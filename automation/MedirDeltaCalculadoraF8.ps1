# Mede o delta do SEXTO ramo (CALCULADORA) do gate da Fase 8.
# Reimplementa os predicados do case 8 sobre TODOS os pares dump <-> .prg de
# tasks\, e reporta em quantos o ramo novo MUDA o resultado (ou seja: o form
# hoje falharia por BtnCancelarClick/CarregarLista ausentes e passaria a ser
# dispensado). Sem isso nao ha como afirmar "zero regressao".

# Raiz do repo = pai de automation\ (era C:\4c\ fixo ate 2026-10-06; o repo vive em C:\4c\refatoracao)
$RaizRepo4c = Split-Path -Parent $PSScriptRoot

$ErrorActionPreference = 'Continue'

# As duas funcoes auxiliares sao copiadas aqui para nao depender de dot-source
# do orquestrador inteiro (que executa o fluxo principal).
function Test-CliqueSoFecha {
    param([string]$TextoDump)
    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return $null }
    $blocos = [regex]::Matches($TextoDump, '(?ims)^PROCEDURE[^\S\r\n]+[\w\.]*Click[^\S\r\n]*\r?$(.*?)^ENDPROC[^\S\r\n]*\r?$')
    if ($blocos.Count -eq 0) { return $null }
    foreach ($bloco in $blocos) {
        $linhas = ($bloco.Groups[1].Value -split "`r?`n") |
                  ForEach-Object { $_.Trim() } |
                  Where-Object { $_ -ne '' -and $_ -notmatch '^\*' -and $_ -notmatch '^&&' }
        foreach ($linha in $linhas) {
            if ($linha -notmatch '(?i)^(=\s*)?(This)?Form\.Release(\s*\(\s*\))?$' -and
                $linha -notmatch '(?i)^Release[^\S\r\n]+Thisform$') { return $false }
        }
    }
    return $true
}

function Get-NBotoes {
    param([string]$TextoDump)
    if ([string]::IsNullOrWhiteSpace($TextoDump)) { return -1 }
    return ([regex]::Matches($TextoDump, '(?im)^\s*BaseClass:\s*commandbutton\s*$')).Count
}

$linhasSaida = @()
$nCasa = 0; $nMuda = 0; $nNoop = 0

Get-ChildItem "$($RaizRepo4c)\tasks" -Directory -ErrorAction SilentlyContinue | ForEach-Object {
    $task = $_
    Get-ChildItem (Join-Path $task.FullName "*_form_codigo_fonte.txt") -ErrorAction SilentlyContinue | ForEach-Object {
        $dump = $_
        $base = $dump.BaseName -replace '_form_codigo_fonte$',''
        $txt  = Get-Content $dump.FullName -Raw -ErrorAction SilentlyContinue
        if (-not $txt) { return }

        # --- predicados do lado DUMP (identicos ao case 8) ---
        $temLista = ($txt -match '(?im)^\s*BaseClass:\s*(grid|pageframe)\s*$') -or
                    ($txt -match '(?i)(AddCursor|pColuna|RecordSource|ControlSource|\bGrade\b|\bgrd)')
        $temCampos = ($txt -match '(?im)^\s*BaseClass:\s*(textbox|editbox|combobox|listbox|checkbox|optiongroup|optionbutton|spinner)\s*$')
        $semCrud = -not (@('frmcadastro','pcEscolha','Grupo_Op',
                           '(btn|cmd|Command)(Incluir|Alterar|Visualizar|Excluir)',
                           '(Incluir|Alterar|Visualizar|Excluir)\.Click') |
                         Where-Object { $txt -match $_ })
        $semSalvar = -not (@('btnSalvar','btnGravar','PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click','mGravaDados') |
                           Where-Object { $txt -match $_ })
        $semAcaoCalc = -not ($txt -match '(?i)(btn|cmd|Command)(Cancel|Confirm|Salva|Grava|Aplica|Executa|Process)')
        $cliqueFecha = Test-CliqueSoFecha -TextoDump $txt
        $nBotoes     = Get-NBotoes -TextoDump $txt

        $ladoDump = ($semCrud -and (-not $temLista) -and $temCampos -and $semSalvar -and
                     $semAcaoCalc -and ($cliqueFecha -eq $true) -and ($nBotoes -eq 1))
        if (-not $ladoDump) { return }
        $nCasa++

        # --- lado .prg: localizar o form migrado ---
        $prg = @(Get-ChildItem "$($RaizRepo4c)\projeto\app\forms" -Recurse -Filter "Form$base.prg" -ErrorAction SilentlyContinue) +
               @(Get-ChildItem "$($RaizRepo4c)\projeto\app\forms" -Recurse -Filter "$base.prg" -ErrorAction SilentlyContinue)
        if ($prg.Count -eq 0) {
            $linhasSaida += "SEM-PRG  $($task.Name)/$base"
            return
        }
        $conteudo = Get-Content $prg[0].FullName -Raw

        $temSuperficie = ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+FormParaBO\b') -and
                         ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+BOParaForm\b') -and
                         ($conteudo -match '(?m)^\s*(PROTECTED\s+|HIDDEN\s+)?(PROCEDURE|FUNCTION)\s+Btn\w*Click\b')

        # metodosFaltantes ANTES da dispensa (substring, como o gate faz)
        $faltantes = @(@("BtnCancelarClick","FormParaBO","BOParaForm","CarregarLista") |
                       Where-Object { $conteudo -notmatch $_ })
        $dispensaveis = @($faltantes | Where-Object { @("BtnCancelarClick","CarregarLista") -contains $_ })

        if ($temSuperficie -and $faltantes.Count -gt 0 -and $dispensaveis.Count -gt 0) {
            $nMuda++
            $linhasSaida += "MUDA     $($task.Name)/$base -> $($prg[0].Name) | faltavam: $($faltantes -join ',') | dispensa: $($dispensaveis -join ',')"
        } else {
            $nNoop++
            $motivo = if (-not $temSuperficie) { "sem superficie (FormParaBO/BOParaForm/Btn*Click)" }
                      elseif ($faltantes.Count -eq 0) { "ja passa (nada faltando)" }
                      else { "faltantes nao dispensaveis: $($faltantes -join ',')" }
            $linhasSaida += "NO-OP    $($task.Name)/$base -> $($prg[0].Name) | $motivo"
        }
    }
}

$linhasSaida += ""
$linhasSaida += "RESUMO: lado-dump casa=$nCasa | MUDA resultado=$nMuda | NO-OP=$nNoop"
$linhasSaida | Set-Content "$($RaizRepo4c)\automation\delta_calculadora_f8.txt" -Encoding utf8
$linhasSaida | ForEach-Object { Write-Output $_ }
