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
    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[o�]xima\s+fase|pendente|nao\s+implement)"
    $laterMatches = [regex]::Matches($content, $laterPattern)
    foreach ($m in $laterMatches) {
        $problemas += "Indicador de pendencia: $($m.Value.Trim())"
    }

    # 4. Detectar stubs com MsgAviso("...ser� implementad...")
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

function Get-ContagemBotoesLegado {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return 0 }

    $nBotoes = ([regex]::Matches($TextoDump, '(?im)^\s*BaseClass:\s*commandbutton\s*$')).Count

    # 1a passada: quais objetos sao CommandGroup (a BaseClass aparece na secao
    # "Objeto:", a ButtonCount aparece na secao "PROPRIEDADES DE:")
    $grupos   = @{}
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\w+)\s*$') {
            if ($matches[1] -ieq 'commandgroup' -and $objAtual) {
                $grupos[$objAtual.ToUpper()] = $true
            }
        }
    }

    # 2a passada: soma a ButtonCount SO dos objetos identificados como grupo
    $objProp = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\*\s*PROPRIEDADES DE:\s*(\S+)\s*$') {
            $partes  = $matches[1] -split '\.'
            $objProp = $partes[$partes.Count - 1]
        } elseif ($linha -match '^\s*ButtonCount\s*=\s*(\d+)\s*$') {
            if ($objProp -and $grupos.ContainsKey($objProp.ToUpper())) {
                $nBotoes += [int]$matches[1]
            }
        }
    }

    return $nBotoes
}

function Get-NomesBotoesLegado {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return @() }

    $nomes    = New-Object System.Collections.Generic.List[string]
    $objAtual = ""
    foreach ($linha in ($TextoDump -split "`r?`n")) {
        if ($linha -match '^\s*Objeto:\s*(\S+)\s*$') {
            $objAtual = $matches[1]
        } elseif ($linha -match '^\s*BaseClass:\s*(\w+)\s*$') {
            if ($matches[1] -ieq 'commandbutton' -and $objAtual) {
                $partes = $objAtual -split '\.'
                $nomes.Add($partes[$partes.Count - 1])
            }
        }
    }

    return $nomes.ToArray()
}

function Test-ModoRecebidoDoChamador {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    # (a) O form decide o proprio modo? Entao NAO eh recebido.
    if ([regex]::IsMatch($TextoDump, '(?im)^\s*(ThisForm\.|This\.|\.)?pcEscolha\s*=\s*[\["'']')) {
        return $false
    }

    # (b) Parametros formais declarados no dump.
    $parametros = @{}
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:LParameters|LParameter|Parameters)\s+(.+)$')) {
        foreach ($p in ($m.Groups[1].Value -split ',')) {
            $p = $p.Trim()
            if ($p -match '^[A-Za-z_][A-Za-z0-9_]*$') { $parametros[$p.ToUpper()] = $true }
        }
    }
    if ($parametros.Count -eq 0) { return $false }

    # (c) Alguma atribuicao a pcEscolha cujo valor eh um desses parametros?
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:ThisForm\.|This\.|\.)?pcEscolha\s*=\s*([A-Za-z_][A-Za-z0-9_]*)\s*$')) {
        if ($parametros.ContainsKey($m.Groups[1].Value.ToUpper())) { return $true }
    }

    # (d) Terceira forma de RECEBER: a atribuicao LE o modo do form PAI dentro
    #     de uma expressao, com literal so como fallback -
    #       .pcEscolha = Iif(Type([ThisForm.ParentForm.pcEscolha])=[C], ;
    #                        .ParentForm.pcEscolha, [CONSULTAR])
    #     Quem decide o valor continua sendo o PAI; o literal eh o default de
    #     quando nao ha pai. As formas (c) e (d) diferem so no transporte
    #     (parametro formal x propriedade do pai).
    #     Continua FAIL-CLOSED: o guard (a) ja devolveu $false se em algum
    #     ponto o form atribui um LITERAL direto a pcEscolha, e aqui exige-se a
    #     referencia explicita ao pai do lado direito.
    foreach ($m in [regex]::Matches($TextoDump, '(?im)^\s*(?:ThisForm\.|This\.|\.)?pcEscolha\s*=\s*(.+)$')) {
        if ($m.Groups[1].Value -match '(?i)(ParentForm|pForm|poForm|oForm|oFormulario|par_oForm)\s*\.\s*pcEscolha') {
            return $true
        }
    }

    return $false
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

            # ControlSource: so NAO e' lista quando o dono e' grupo de botoes.
            if (-not $objProp) { return $true }
            if (-not $baseClass.ContainsKey($objProp)) { return $true }
            if ($baseClass[$objProp] -notin @('commandgroup', 'optiongroup')) { return $true }
        }
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

function Test-LegadoSemCamposSoltos {
    param([string]$TextoDump)

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $rxEntrada   = '^(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)$'
    $rxAgrupador = '^(container|pageframe|page|custom|control|toolbar)$'
    $nBlocos = 0
    $nSoltos = 0

    foreach ($bloco in [regex]::Matches($TextoDump, '(?im)^Objeto:[^\r\n]*(?:\r?\n[ \t]+[^\r\n]*)*')) {
        $t = $bloco.Value

        $mBase = [regex]::Match($t, '(?im)^\s*BaseClass:\s*([A-Za-z]+)\s*$')
        if (-not $mBase.Success) { continue }
        $nBlocos++
        $bc = $mBase.Groups[1].Value.ToLower()

        $mCls = [regex]::Match($t, '(?im)^\s*Class:\s*([A-Za-z0-9_]+)\s*$')
        $cls = if ($mCls.Success) { $mCls.Groups[1].Value.ToLower() } else { "" }
        $temClassLoc = ($t -match '(?im)^\s*ClassLoc:')

        # Agrupador vindo de VCX esconde os campos no p-code - ver .DESCRIPTION
        if (($temClassLoc -and $bc -match $rxAgrupador) -or $cls -match '^cls') {
            return $false
        }

        if ($bc -notmatch $rxEntrada) { continue }

        $mPai = [regex]::Match($t, '(?im)^\s*Parent:[ \t]*([^\r\n]*?)[ \t]*\r?$')
        $pai = if ($mPai.Success) { $mPai.Groups[1].Value } else { "" }
        if ($pai -notmatch '(?i)\.Column\d+$') { $nSoltos++ }
    }

    return ($nBlocos -ge 1 -and $nSoltos -eq 0)
}

function Test-LegadoSemBotaoAlgum {
    param([string]$TextoDump)

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    # Camada 1: o piso de 1 handler ja cobre o legado de UM botao.
    if ((Get-ContagemBotoesLegado -TextoDump $TextoDump) -ne 0) { return $false }

    # Camada 2: botao acionado por codigo prova superficie de botao.
    if ($TextoDump -match '(?i)\.\s*Click') { return $false }

    # Camada 3 e 4: Class do FORM e agrupador de VCX.
    $blocos = [regex]::Matches($TextoDump, '(?im)^\s*Objeto:\s*(\S+)\s*\r?\n\s*Parent:\s*([^\r\n]*?)\s*\r?\n\s*Class:\s*(\S+)\s*\r?\n\s*BaseClass:\s*(\w+)\s*\r?$')
    if ($blocos.Count -eq 0) { return $false }

    $achouForm = $false
    foreach ($b in $blocos) {
        $cls  = $b.Groups[3].Value
        $base = $b.Groups[4].Value

        if ($base -ieq 'form') {
            # frmcadastro/frmrelatorio HERDAM a barra de botoes sem declarar.
            if ($cls -ine 'form') { return $false }
            $achouForm = $true
        }

        # Agrupador de VCX: os botoes moram no p-code, nao no dump.
        if ($cls -imatch '^cls') { return $false }
    }

    if (-not $achouForm) { return $false }
    if ($TextoDump -match '(?im)^\s*ClassLoc:') { return $false }

    return $true
}

function Test-LegadoSemLookupAlgum {
    param([string]$TextoDump)

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $padroesLookup = @(
        'fwbusca',
        'mAddColuna',
        'sigacess\s*\(',
        'Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo)\s*\(',
        'FormBuscaAuxiliar'
    )

    return -not ($padroesLookup | Where-Object { $TextoDump -match $_ })
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

function Test-LegadoCliqueSoFecha {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $null }

    # [^\S\r\n] = espaco/tab SEM quebra de linha: impede o \s* de atravessar
    # linhas e casar um ENDPROC de outro metodo.
    $blocos = [regex]::Matches($TextoDump, '(?ims)^PROCEDURE[^\S\r\n]+[\w\.]*Click[^\S\r\n]*\r?$(.*?)^ENDPROC[^\S\r\n]*\r?$')
    if ($blocos.Count -eq 0) { return $null }

    foreach ($bloco in $blocos) {
        $linhas = ($bloco.Groups[1].Value -split "`r?`n") |
                  ForEach-Object { $_.Trim() } |
                  Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' }

        foreach ($linha in $linhas) {
            # Aceita ThisForm.Release / Form.Release / =ThisForm.Release() /
            # Release Thisform. Qualquer outra instrucao = botao de acao.
            if ($linha -notmatch '(?i)^(=\s*)?(This)?Form\.Release(\s*\(\s*\))?$' -and
                $linha -notmatch '(?i)^Release[^\S\r\n]+Thisform$') {
                return $false
            }
        }
    }

    return $true
}

function Test-AcaoDoLegadoTemHandler {
    <#
    .SYNOPSIS
        O botao de ACAO que o legado realmente tem ganhou handler no migrado?
    .DESCRIPTION
        O gate da Fase 8 diz, em comentario, que "aceita o nome canonico CRUD
        ou o nome que o legado usa" - mas $padraoAcaoGravar so aceita a lista
        canonica Btn(Salvar|Confirmar|Gravar|Processa|Aplicar|Executar|OK).
        Legado cuja acao NAO eh gravar em tabela usa outro verbo e a fase
        reprovava um form completo: SIGPRFTP -> Formsigprftp (task611), tela de
        transferencia de arquivos via FTP cujos botoes sao "Conecta",
        "Transfere", "Recebe" e "Rede Dial-Up". Nenhum verbo desses esta na
        lista, e a tela nao persiste NADA em tabela de negocio - a acao dela eh
        mover arquivo. Satisfazer a lista exigiria INVENTAR um botao que o
        legado nao tem (viola o PILAR 1) ou renomear o handler para um verbo
        que mente sobre o que ele faz.

        Lista de palavras no nome erra igual do lado do migrado e do lado do
        legado - a mesma armadilha que a Fase 7 teve com o verbo CRUD com
        sufixo. Entao aqui NAO se acrescenta verbo a lista: deriva-se o verbo
        do PROPRIO dump, pelo Caption/Name de cada CommandButton, e cobra-se
        que exista "PROCEDURE Btn<verbo>*Click" no migrado.

        FAIL-CLOSED:
          - dump ausente/ilegivel -> $false (ausencia de prova nao eh prova);
          - botao que so FECHA a tela nao conta como acao (Sair/Encerrar/
            Fechar/Cancelar/Retornar/OK/X) - senao qualquer form passaria pelo
            botao de sair;
          - Caption/Name com menos de 4 letras uteis eh descartado: raiz curta
            casaria por acidente (ex.: "Ok" dentro de "BtnBloqueioClick");
          - exige o handler ancorado em inicio de linha, para a tabela
            "o que nao se aplica" do cabecalho do form nao satisfazer um
            -match solto e a checagem virar NO-OP.
    .OUTPUTS
        [bool] $true quando ao menos um botao de ACAO do legado tem handler.
    #>
    param(
        [string]$TextoDump,
        [string]$ConteudoForm
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump))    { return $false }
    if ([string]::IsNullOrWhiteSpace($ConteudoForm)) { return $false }

    # Verbos que apenas FECHAM a tela - nao sao acao
    $verbosDeSaida = @('sair','encerrar','fechar','cancelar','cancela','retornar',
                       'voltar','abandonar','ok','x','esc','exit','close')

    # Blocos "* PROPRIEDADES DE: ..." de cada CommandButton do SCX. O dump
    # traz Name = "..." e, quando existe, Caption = "..." - e do Caption que
    # sai o verbo que o USUARIO ve (o Name costuma ser abreviado: cmdtran).
    $candidatos = New-Object System.Collections.Generic.List[string]

    $blocos = [regex]::Matches($TextoDump,
        '(?is)\*\s*PROPRIEDADES\s+DE:\s*(?<caminho>[^\r\n]+)\r?\n[-\s]*\r?\n(?<corpo>.*?)(?=\*\s*PROPRIEDADES\s+DE:|\z)')

    foreach ($b in $blocos) {
        $corpo = $b.Groups['corpo'].Value

        # So CommandButton/CommandGroup: o resto nao dispara acao por Click
        $nome = [regex]::Match($corpo, '(?im)^\s*Name\s*=\s*"([^"]+)"').Groups[1].Value
        if ([string]::IsNullOrWhiteSpace($nome)) { continue }
        if ($nome -notmatch '(?i)^(cmd|btn|command|Grupo)') { continue }

        $caption = [regex]::Match($corpo, '(?im)^\s*Caption\s*=\s*"([^"]*)"').Groups[1].Value

        foreach ($bruto in @($caption, $nome)) {
            if ([string]::IsNullOrWhiteSpace($bruto)) { continue }

            # "\<Transfere" -> "Transfere"; "Rede \<Dial-Up" -> "Rede Dial Up";
            # "cmdtran" -> "tran"
            $limpo = $bruto -replace '\\<', '' -replace '&', ''
            $limpo = $limpo -replace '(?i)^(cmd|btn|command)', ''
            $limpo = $limpo -replace '[^A-Za-zÀ-ÿ]+', ' '

            foreach ($palavra in ($limpo -split '\s+')) {
                if ($palavra.Length -lt 4) { continue }
                if ($verbosDeSaida -contains $palavra.ToLower()) { continue }
                [void]$candidatos.Add($palavra)
            }
        }
    }

    foreach ($verbo in ($candidatos | Select-Object -Unique)) {
        # Raiz do verbo: "Transfere"/"Transferir"/"Transferencia" partilham
        # "Transfer"; "Recebe"/"Receber"/"Recebimento" partilham "Receb".
        $raiz = $verbo
        if ($raiz.Length -gt 5) { $raiz = $raiz.Substring(0, $raiz.Length - 1) }
        $raizEscapada = [regex]::Escape($raiz)

        if ($ConteudoForm -match "(?im)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*$raizEscapada\w*Click\b") {
            return $true
        }
    }

    return $false
}

function Test-LegadoEscritaSoEmCursorLocal {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $locais = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
    $padroesCursor = @(
        '(?i)SqlExecute\s*\(\s*[^,()]+,\s*[''"\[]([A-Za-z_]\w*)',
        '(?i)CursorQuery\s*\(\s*[^)]*?[''"\[]([A-Za-z_]\w*)[''"\]]\s*\)',
        '(?i)\bInto\s+Cursor\s+([A-Za-z_]\w*)',
        '(?i)\bCreate\s+Cursor\s+([A-Za-z_]\w*)',
        '(?i)\bUse\s+.*\bAlias\s+([A-Za-z_]\w*)'
    )
    foreach ($padrao in $padroesCursor) {
        foreach ($m in [regex]::Matches($TextoDump, $padrao)) {
            [void]$locais.Add($m.Groups[1].Value)
        }
    }

    foreach ($m in [regex]::Matches($TextoDump, '(?i)\b(?:Insert\s+Into|Update|Delete\s+From)\s+([A-Za-z_]\w*)')) {
        if (-not $locais.Contains($m.Groups[1].Value)) { return $false }
    }

    return $true
}

function Test-LegadoPersisteViaAddCursor {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    if ($TextoDump -notmatch '(?i)(\.Commit\s*\(|TableUpdate\s*\()') { return $false }

    $ligados = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
    foreach ($m in [regex]::Matches($TextoDump, '(?i)\.AddCursor\s*\(\s*[''"\[]([A-Za-z_]\w*)[''"\]]\s*,\s*[^,]+,\s*[''"\[]([A-Za-z_]\w*)[''"\]]')) {
        [void]$ligados.Add($m.Groups[2].Value)
    }
    if ($ligados.Count -eq 0) { return $false }

    foreach ($m in [regex]::Matches($TextoDump, '(?i)\b(?:Insert\s+Into|Update|Delete\s+From)\s+([A-Za-z_]\w*)')) {
        if ($ligados.Contains($m.Groups[1].Value)) { return $true }
    }

    return $false
}

function Test-LegadoEscritaSoEmTabelaLocalFree {
    param(
        [string]$TextoDump
    )

    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $false }

    $locais = New-Object System.Collections.Generic.HashSet[string] ([StringComparer]::OrdinalIgnoreCase)
    $padroesLocais = @(
        '(?i)\bCreate\s+Table\s+([A-Za-z_]\w*)\s+Free\b',
        '(?i)\bInto\s+Cursor\s+([A-Za-z_]\w*)',
        '(?i)\bCreate\s+Cursor\s+([A-Za-z_]\w*)',
        '(?i)\bUse\s+.*\bAlias\s+([A-Za-z_]\w*)'
    )
    foreach ($padrao in $padroesLocais) {
        foreach ($m in [regex]::Matches($TextoDump, $padrao)) {
            [void]$locais.Add($m.Groups[1].Value)
        }
    }

    # Nenhuma tabela local criada = nao eh este ramo (evita devolver $true para
    # dump que simplesmente nao escreve nada).
    if ($locais.Count -eq 0) { return $false }

    foreach ($m in [regex]::Matches($TextoDump, '(?i)\b(?:Insert\s+Into|Update|Delete\s+From)\s+([A-Za-z_]\w*)')) {
        if (-not $locais.Contains($m.Groups[1].Value)) { return $false }
    }

    return $true
}

