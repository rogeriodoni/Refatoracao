# EXTRACAO VERBATIM de OrquestradorMigracao.ps1 (task746, gate Fase 6)
function Test-CompletudeCodigo {
    param(
        [string]$FilePath,
        [string]$Descricao
    )

    if (-not (Test-Path $FilePath)) {
        Write-Host "  [WARN] $Descricao nao encontrado: $FilePath" -ForegroundColor Yellow
        return $false
    }

    $content = Get-Content $FilePath -Raw -ErrorAction SilentlyContinue
    if (-not $content) { return $false }

    $problemas = @()

    # 1. Detectar TODO/FIXME/HACK/PLACEHOLDER em comentarios VFP (*--)
    $todoPattern = "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b"
    $todoMatches = [regex]::Matches($content, $todoPattern)
    foreach ($m in $todoMatches) {
        $problemas += "Marcador encontrado: $($m.Value.Trim())"
    }

    # 2. Detectar procedures/methods vazios (PROCEDURE ... apenas comentarios ... ENDPROC)
    $procPattern = "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC"
    $procMatches = [regex]::Matches($content, $procPattern)
    foreach ($m in $procMatches) {
        $procName = $m.Groups[1].Value
        $body = $m.Groups[3].Value

        # Ignorar procedures que sao DODEFAULT() only (heranca normal)
        if ($body -match "DODEFAULT\(\)") { continue }

        # Ignorar handlers de KeyPress para campos sem lookup (data, PV, etc.)
        # Estes sao intencionalmente vazios - campos que nao precisam de F4/F5
        $procParams = $m.Groups[2].Value
        if ($procName -match "^Tecla" -and $procParams -match "par_nKeyCode") { continue }

        # Remover comentarios e linhas em branco
        $codeLines = ($body -split "`n" |
                      Where-Object { $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&" } |
                      Measure-Object).Count

        if ($codeLines -eq 0) {
            $problemas += "Procedure vazia (sem codigo): $procName"
        }
    }

    # 3. Detectar "implementar depois" / "proxima fase" em comentarios
    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o?]xima\s+fase|\bpendente|nao\s+implement)"
    $laterMatches = [regex]::Matches($content, $laterPattern)
    foreach ($m in $laterMatches) {
        $problemas += "Indicador de pendencia: $($m.Value.Trim())"
    }

    # 4. Detectar stubs com MsgAviso("...ser? implementad...")
    # Claude gera stubs que passam checks 1-3 porque usam MsgAviso em vez de comentario
    $stubMsgPattern = '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)'
    $stubMsgMatches = [regex]::Matches($content, $stubMsgPattern)
    foreach ($m in $stubMsgMatches) {
        # Encontrar nome do PROCEDURE que contem este stub
        $pos = $m.Index
        $beforeText = $content.Substring(0, $pos)
        $procMatch = [regex]::Match($beforeText, '(?i)PROCEDURE\s+(\w+)', [System.Text.RegularExpressions.RegexOptions]::RightToLeft)
        $stubProc = if ($procMatch.Success) { $procMatch.Groups[1].Value } else { "(desconhecido)" }
        $problemas += "Metodo stub com MsgAviso placeholder: $stubProc - deve ter logica FUNCIONAL, nao mensagem 'sera implementado'"
    }

    if ($problemas.Count -gt 0) {
        Write-Host "  [COMPLETUDE] $Descricao tem $($problemas.Count) problema(s):" -ForegroundColor Yellow
        foreach ($p in $problemas[0..([math]::Min(9, $problemas.Count - 1))]) {
            Write-Host "    - $p" -ForegroundColor Yellow
        }
        if ($problemas.Count -gt 10) {
            Write-Host "    ... e mais $($problemas.Count - 10) problemas" -ForegroundColor Yellow
        }
        return $false
    }

    Write-Host "  [OK] ${Descricao} - nenhum TODO/stub/procedure vazia detectado" -ForegroundColor Green
    return $true
}

function Test-LegadoAddCursorLigaGrade {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    foreach ($m in [regex]::Matches($TextoDump, '(?i)\.AddCursor\s*\(([^\r\n]*)')) {
        # Recorta a lista de argumentos no ')' que FECHA a chamada, andando com
        # contador de profundidade e ignorando o que esta entre delimitadores de
        # string ('...', "...", [...]). Sem esse recorte, o ')' final fica GRUDADO
        # no ultimo argumento e uma chamada de 5 argumentos terminada em ''
        # produz arg5 = "'')" - que nao casa o teste de vazio e faz a funcao
        # afirmar que existe grade onde nao existe. Foi esse falso positivo que
        # reprovou SIGPRGLO -> FormSigPrGlo (task615) na Fase 8: as 12 chamadas
        # do Init legado sao .AddCursor('SigMvCab','cIdChaves','crSigMvCab','','')
        # e o dump nao tem UM grid (zero 'BaseClass: grid|pageframe|listbox',
        # zero pColuna, zero \bGrade\b|\bgrd).
        $argumentos = $m.Groups[1].Value
        $profundidade = 0
        $fim = $argumentos.Length
        $delimitador = ''
        for ($i = 0; $i -lt $argumentos.Length; $i++) {
            $ch = $argumentos[$i]
            if ($delimitador -ne '') {
                if ($ch -eq $delimitador) { $delimitador = '' }
                continue
            }
            switch ($ch) {
                "'" { $delimitador = "'" }
                '"' { $delimitador = '"' }
                '[' { $delimitador = ']' }
                '(' { $profundidade++ }
                ')' {
                    if ($profundidade -eq 0) { $fim = $i } else { $profundidade-- }
                }
            }
            if ($fim -ne $argumentos.Length) { break }
        }
        $argumentos = $argumentos.Substring(0, $fim)

        $partes = $argumentos -split ','
        if ($partes.Count -lt 5) { continue }

        $arg5 = $partes[4].Trim()
        if ([string]::IsNullOrWhiteSpace($arg5)) { continue }
        if ($arg5 -match "^('\s*'|`"\s*`"|\.[fF]\.)$") { continue }

        return $true
    }

    return $false
}

function Test-LegadoControlSourceLigaLista {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): BaseClass de cada objeto.
    $baseClass = @{}
    $objAtual  = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\S+)\s*$') {
            if ($objAtual) { $baseClass[$objAtual.ToUpper()] = $matches[1].ToLower() }
        }
    }

    # 2a passada (SECAO 2 - propriedades): de quem e' cada RecordSource/
    # ControlSource. O cabecalho traz o caminho completo; a chave e' a ultima
    # parte, igual ao que Test-LegadoDialogoExibicao ja faz para ReadOnly.
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1].ToUpper()
        } elseif ($linha -match '^\s*(RecordSource|ControlSource)\s*=\s*"[^"]+"\s*$') {
            # RecordSource e' propriedade de grade: prova de lista, sempre.
            if ($matches[1] -ieq 'RecordSource') { return $true }

            # ControlSource: NAO e' lista quando o dono e' um controle de
            # valor unico (grupo de botoes ou campo de entrada escalar).
            if (-not $objProp) { return $true }
            if (-not $baseClass.ContainsKey($objProp)) { return $true }
            # Controle de valor ESCALAR: ControlSource liga UM campo do
            # registro corrente, nunca uma lista (ver .DESCRIPTION).
            # 'column' fica FORA desta lista de proposito - Column.ControlSource
            # e' coluna de GRADE, isto e', prova de lista.
            if ($baseClass[$objProp] -notin @('commandgroup', 'optiongroup', 'listbox', 'combobox',
                                               'textbox', 'editbox', 'spinner', 'checkbox', 'optionbutton')) { return $true }
        }
    }

    return $false
}

function Test-LegadoListBoxLigaLista {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): quais objetos sao ListBox.
    $listbox  = @{}
    $objAtual = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*listbox\s*$') {
            if ($objAtual) { $listbox[$objAtual.ToUpper()] = $null }
        }
    }

    # Sem ListBox nenhum nao ha o que decidir aqui.
    if ($listbox.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): RowSourceType de cada ListBox. O
    # cabecalho traz o caminho completo; a chave e' a ultima parte, igual ao
    # que Test-LegadoDialogoExibicao ja faz para ReadOnly.
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1].ToUpper()
        } elseif ($linha -match '^\s*RowSourceType\s*=\s*(\d+)\s*$') {
            if ($objProp -and $listbox.ContainsKey($objProp)) {
                $listbox[$objProp] = [int]$matches[1]
            }
        }
    }

    # FAIL-CLOSED: um unico ListBox sem prova de RowSourceType em {0,1} basta
    # para manter a exigencia de grade.
    foreach ($chave in @($listbox.Keys)) {
        $tipo = $listbox[$chave]
        if ($null -eq $tipo) { return $true }
        if ($tipo -ne 0 -and $tipo -ne 1) { return $true }
    }

    return $false
}

function Test-LegadoDialogoExibicao {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    # 1a passada (SECAO 1 - arvore de objetos): quais objetos sao controle de
    # entrada de dados. Label/Image/Shape/Container NAO contam - sao decoracao.
    $campos   = @{}
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) { $campos[$objAtual.ToUpper()] = $false }
        }
    }

    if ($campos.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): quais desses objetos declaram
    # ReadOnly = .T.. O cabecalho traz o caminho completo; a chave e' a ultima
    # parte, igual ao que Get-ContagemBotoesLegado ja faz para ButtonCount.
    $objProp = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1].ToUpper()
        } elseif ($linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            if ($objProp -and $campos.ContainsKey($objProp)) { $campos[$objProp] = $true }
        }
    }

    foreach ($v in $campos.Values) {
        if (-not $v) { return $false }
    }

    return $true
}

function Test-LegadoTokenGradeProprioForm {
    param([string]$TextoDump)

    # O token cru pColuna|Grade|grd e' usado como prova de que o LEGADO tem
    # superficie de LISTA. Mas ele casa tambem quando o dump so MENCIONA a
    # grade de OUTRO form - tipicamente um dialogo filho que, no fim do
    # Click, manda o pai repintar a propria grade:
    #
    #     ThisForm.FormPai.Page.Hist.grd_lancamento.Refresh
    #     ThisForm.FormPai.Page.Hist.grd_lancamento.SetFocus
    #
    # Isso NAO e' lista no form corrente: e' a lista do PAI. Contar como
    # lista derrubava os ramos "sem lista" (CAPTURA/EXIBICAO) justamente em
    # quem mais depende deles - um dialogo modal sem grade nenhuma -, e
    # sobrava inventar Grid/PageFrame (viola o PILAR 1 e "NUNCA inventar")
    # ou escrever metodo-adaptador vazio (proibido pela regra de completude).
    # Mesma familia de [feedback_gate_fase4_exige_grid_dialogo_exibicao], onde
    # o predicado LARGO consumia a propria prova de que o ramo se aplicava.
    #
    # Esta funcao e' um REMOVEDOR DE FALSO POSITIVO puro: so pode devolver
    # $false onde o teste antigo devolvia $true, nunca o contrario. Por isso
    # o veredito da Fase 4 so pode ir REPROVA -> PASSA, nunca regredir.
    #
    # A lista de raizes e' um ALLOWLIST EXPLICITO, medido nos 713 dumps de
    # tasks\ (2026-10-30). NAO usar curinga tipo \w*Pai\w* / \w*Parent\w*: ele
    # casa controle comum - getPaises (paises!), optpais, Get_DespAI -, e com
    # ele a funcao passaria a esconder a grade do PROPRIO form.
    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $rxToken = '(?i)(pColuna|\bGrade\b|\bgrd)'

    # Token ausente: identico ao teste antigo.
    if ($TextoDump -notmatch $rxToken) { return $false }

    # Consome a CADEIA inteira ancorada num form estrangeiro (incluindo os
    # membros seguintes, que e' onde o grd aparece) e testa o que sobrou.
    $rxCadeiaEstrangeira = '(?i)\b(?:ThisForm\s*\.\s*)?(?:FormPai|FrmPai|FormParent|ParentForm|oParentForm|ThisParent|FormChamador)\b(?:\s*\.\s*\w+)+'
    $restante = [regex]::Replace($TextoDump, $rxCadeiaEstrangeira, ' ')

    return ($restante -match $rxToken)
}

function Test-LegadoSomenteLeitura {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $linhas = $TextoDump -split "`r?`n"

    # 1a passada (SECAO 1 - arvore de objetos): caminho COMPLETO de cada
    # controle de ENTRADA de dados. Label/Image/Shape/Container NAO contam.
    # O caminho completo (Parent + "." + Objeto) e' necessario porque a
    # heranca de ReadOnly vem do ancestral - nome curto nao permite subir.
    $campos   = @{}
    $tipos    = @{}
    $objAtual = ""
    $paiAtual = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\s*Objeto:') {
            # Zera SEMPRE: "Objeto:" sem nome (ha entradas vazias no dump) nao
            # pode herdar o nome do objeto anterior.
            $objAtual = ""
            $paiAtual = ""
            if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') { $objAtual = $matches[1] }
        } elseif ($linha -match '^\s*Parent:\s*(\S+)\s*$') {
            $paiAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$') {
            if ($objAtual) {
                $caminho = if ($paiAtual -and $paiAtual -ne '(raiz)') { "$paiAtual.$objAtual" } else { $objAtual }
                $campos[$caminho.ToUpper()] = $false
                $tipos[$caminho.ToUpper()]  = $matches[1].ToLower()
            }
        }
    }

    if ($campos.Count -eq 0) { return $false }

    # 2a passada (SECAO 2 - propriedades): ReadOnly = .T., do proprio objeto do
    # bloco ou de um descendente declarado por caminho RELATIVO dentro dele
    # (Column3.ReadOnly = .T. / Column3.Text1.ReadOnly = .T. no bloco do Grid).
    $somenteLeitura = @{}
    $objProp = ""
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:') {
            $objProp = ""
            if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') { $objProp = $matches[1].ToUpper() }
        } elseif ($objProp -and $linha -match '^\s*ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura[$objProp] = $true
        } elseif ($objProp -and $linha -match '^\s*([\w\.]+)\.ReadOnly\s*=\s*\.T\.\s*$') {
            $somenteLeitura["$objProp.$($matches[1].ToUpper())"] = $true
        } elseif ($objProp -and $linha -match '^\s*Style\s*=\s*2\s*$' -and
                  $tipos[$objProp] -eq 'combobox') {
            # ComboBox Style = 2 (Dropdown List) eh somente-selecao: 3a forma
            # canonica de campo nao-digitavel, alem de ReadOnly = .T. e
            # When -> .F.. Medido no VFP9 em 2026-09-29
            # (automation\medir_combo_style2.prg): com Style = 0 a digitacao de
            # "Zebra" cai em DisplayValue; com Style = 2 ela eh DESCARTADA e
            # ate a atribuicao por codigo de valor fora da lista eh recusada.
            # Style = 0/1 segue digitavel e derruba a excecao (fail-closed).
            $somenteLeitura[$objProp] = $true
        }
    }

    # 3a passada (SECAO 3 - metodos): PROCEDURE When que devolve .F. sem
    # condicao nenhuma. Aceita "Return .f.", "Return (.F.)" e "Return(.f.)" -
    # as tres grafias aparecem no MESMO dump do SIGMVSBN. When com qualquer
    # outra linha util NAO conta: pode devolver .T. em algum caminho.
    $objMet = ""
    $emWhen = $false
    $corpo  = @()
    foreach ($linha in $linhas) {
        if ($linha -match '^\*\s*OBJETO:\s*(\S+)\s*$') {
            $objMet = $matches[1].ToUpper()
            continue
        }
        if (-not $emWhen) {
            if ($linha -match '^\s*PROCEDURE\s+When\s*$') {
                $emWhen = $true
                $corpo  = @()
            }
            continue
        }
        if ($linha -match '^\s*ENDPROC\s*$') {
            $emWhen = $false
            # @(...) obrigatorio: com UMA linha util o pipeline devolve String,
            # e $uteis[0] numa String da o primeiro CARACTERE, nao a linha.
            $uteis = @($corpo | ForEach-Object { $_.Trim() } |
                       Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' })
            if ($objMet -and $uteis.Count -eq 1 -and
                $uteis[0] -match '(?i)^Return\s*\(?\s*\.F\.\s*\)?\s*$') {
                $somenteLeitura[$objMet] = $true
            }
        } else {
            $corpo += $linha
        }
    }

    # Veredito: UM campo digitavel derruba a excecao.
    foreach ($caminho in @($campos.Keys)) {
        if ($somenteLeitura[$caminho]) { continue }

        # Sobe a hierarquia: Grid/Column com ReadOnly = .T. propaga aos filhos.
        $herdou = $false
        $partes = $caminho -split '\.'
        for ($i = $partes.Count - 2; $i -ge 0; $i--) {
            if ($somenteLeitura[(($partes[0..$i]) -join '.')]) { $herdou = $true; break }
        }
        if (-not $herdou) { return $false }
    }

    return $true
}

