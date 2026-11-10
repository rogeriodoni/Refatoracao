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
