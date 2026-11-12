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
$formFile  = 'C:\4c\projeto\app\forms\operacionais\Formsigoppei.prg'
$dump      = 'C:\4c\tasks\task780\sigoppei_form_codigo_fonte.txt'
$conteudo  = Get-Content $formFile -Raw
$txtLegado = Get-Content $dump -Raw
$FormType  = 'OPERACIONAL'

$semPageFrame    = ($conteudo -notmatch 'AddObject\(\s*"pgf_4c_')
$temBindEvent    = ($conteudo -match 'BINDEVENT')
$temMetodoLookup = ($conteudo -match 'PROCEDURE\s+(AbrirLookup|AbrirBusca)\w*')
$padroesLookup   = @('fwbusca','mAddColuna','sigacess\s*\(','Acesso(Campos|Contab|Contas|Empresa|Grupos|MovInd|MovMto|Produto|Titulo)\s*\(','FormBuscaAuxiliar')
$legadoSemLookup = -not ($padroesLookup | Where-Object { $txtLegado -match $_ })
$legadoSomenteLeitura = Test-LegadoSomenteLeitura -TextoDump $txtLegado
$temSuperficieVisualizador = ($conteudo -match 'AddObject\(\s*"[^"]+"\s*,\s*"(EditBox\w*|TextBox\w*)"') -and ($conteudo -match '\.ReadOnly\s*=\s*\.T\.') -and ($conteudo -match '\.ControlSource\s*=')
$temLayoutVisualizador = ($FormType -eq 'OPERACIONAL' -and $semPageFrame -and $temBindEvent -and $legadoSemLookup -and $legadoSomenteLeitura -and $temSuperficieVisualizador)

Write-Output ('semPageFrame               = ' + $semPageFrame)
Write-Output ('temBindEvent               = ' + $temBindEvent)
Write-Output ('temMetodoLookup            = ' + $temMetodoLookup)
Write-Output ('legadoSemLookup            = ' + $legadoSemLookup)
Write-Output ('legadoSomenteLeitura       = ' + $legadoSomenteLeitura)
Write-Output ('temSuperficieVisualizador  = ' + $temSuperficieVisualizador)
Write-Output ('>>> temLayoutVISUALIZADOR  = ' + $temLayoutVisualizador)
