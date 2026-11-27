<#
.SYNOPSIS
    Dumpa as expressoes <alias>.<coluna> e os paths de imagem de UM relatorio FRX,
    lendo o memo .FRT byte a byte.

.DESCRIPTION
    O alias do cursor que um FRX le eh CONTRATO do relatorio, nao nome escolhido
    pelo migrador: o PILAR 3 nao o renomeia. Rebatizar para cursor_4c_* faz o
    REPORT FORM estourar "Alias <X> is not found" - compila limpo e so quebra
    quando o usuario aciona Visualizar/Imprimir.

    Este script existe para responder UMA pergunta antes de nomear o cursor:
    "que alias este FRX cita?". NAO eh auditoria em lote - varrer os ~200 FRT
    comparando com o codigo gera centenas de falsos positivos (ja medido e
    descartado); aqui se le um arquivo e se olha a resposta.

    O .FRT eh o memo de um DBF: nao da para ler com Get-Content. Extraimos os
    bytes imprimiveis e casamos as expressoes.

.PARAMETER Frx
    Caminho do .FRX ou do .FRT (qualquer um dos dois; o par eh resolvido sozinho).

.EXAMPLE
    powershell -NoProfile -ExecutionPolicy Bypass -File automation\LerAliasFRX.ps1 `
        -Frx projeto\app\reports\SigReAac.frx
    # crCabecalho.cSubTitulos
    # crCabecalho.cTitulos

.NOTES
    Origem: erro395 (FormSIGPGCNB - "sigrecnb.frx" ausente no acervo).
    Regra relacionada: alias de FRX eh contrato; ver memoria
    feedback_frx_alias_cursor_eh_contrato.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Frx
)

$ErrorActionPreference = 'Stop'

if (-not [System.IO.Path]::IsPathRooted($Frx)) {
    $Frx = Join-Path (Get-Location).Path $Frx
}

# Aceita .frx ou .frt e resolve o par
$frt = [System.IO.Path]::ChangeExtension($Frx, '.frt')
if (-not (Test-Path -LiteralPath $frt)) {
    # tentativa case-insensitive na pasta (o acervo mistura .FRT e .frt)
    $dir  = Split-Path -Parent $frt
    $base = [System.IO.Path]::GetFileNameWithoutExtension($frt)
    $alt  = Get-ChildItem -LiteralPath $dir -Filter "$base.*" -ErrorAction SilentlyContinue |
            Where-Object { $_.Extension -ieq '.frt' } | Select-Object -First 1
    if ($alt) { $frt = $alt.FullName }
}

if (-not (Test-Path -LiteralPath $frt)) {
    Write-Output "[FRX-ALIAS] memo .FRT nao encontrado para: $Frx"
    Write-Output "[FRX-ALIAS] sem o .FRT nao ha como ler as expressoes - o .FRX sozinho so tem a estrutura."
    exit 1
}

$bytes = [System.IO.File]::ReadAllBytes($frt)
$sb    = New-Object System.Text.StringBuilder ($bytes.Length)
foreach ($b in $bytes) {
    # troca nao-imprimivel por espaco: preserva os offsets e quebra tokens colados
    if ($b -ge 32 -and $b -le 126) { [void]$sb.Append([char]$b) } else { [void]$sb.Append(' ') }
}
$texto = $sb.ToString()

Write-Output "[FRX-ALIAS] $([System.IO.Path]::GetFileName($frt))  ($($bytes.Length) bytes)"
Write-Output ''

# ---- 1) expressoes <alias>.<coluna> -----------------------------------------
$expr = [regex]::Matches($texto, '(?i)\b([A-Za-z_][A-Za-z0-9_]{1,30})\.([A-Za-z_][A-Za-z0-9_]{0,30})\b') |
        ForEach-Object { $_.Value } |
        Sort-Object -Unique

# descarta o que nao eh alias de cursor: chamadas de objeto e nomes de arquivo
$ignorar = '^(this|thisform|_screen|sys|alltrim|iif|date|time|left|right|str|val)\.'
$expr = $expr | Where-Object { $_ -notmatch $ignorar -and $_ -notmatch '(?i)\.(frx|frt|jpg|bmp|ico|dbf|prg|exe|dll)$' }

if ($expr) {
    Write-Output '--- expressoes <alias>.<coluna> citadas pelo relatorio ---'
    $expr | ForEach-Object { Write-Output "   $_" }
    Write-Output ''
    Write-Output '--- ALIASES distintos (CRIAR o cursor com ESTE nome exato) ---'
    $expr | ForEach-Object { ($_ -split '\.')[0] } | Sort-Object -Unique |
        ForEach-Object { Write-Output "   $_" }
} else {
    Write-Output '--- nenhuma expressao <alias>.<coluna> encontrada ---'
    Write-Output '    (relatorio pode ler a area de trabalho corrente sem qualificar o alias)'
}

Write-Output ''

# ---- 2) paths de imagem (nome FIXO eh contrato tambem) ----------------------
# sem espaco na classe: com ele o match arrasta o texto vizinho (fonte, tamanho)
$img = [regex]::Matches($texto, "(?i)[A-Za-z0-9_\\:\.]{0,60}\.(jpg|bmp|ico|gif|png)") |
       ForEach-Object { $_.Value.TrimStart('\') } |
       Where-Object { $_ -match '[A-Za-z0-9_]' } |
       Sort-Object -Unique

if ($img) {
    Write-Output '--- imagens referenciadas (gravar com ESTE nome, nao com SYS(2015)) ---'
    $img | ForEach-Object { Write-Output "   $_" }
} else {
    Write-Output '--- nenhuma imagem referenciada ---'
}
