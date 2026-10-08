# =============================================================================
# VerificarFormatInputMask.ps1
#
# Erro197 (2026-10-08): o migrador DESCARTA `Format` e `InputMask` declarados
# no SCX. No FormCEP os 10 (9 Format = "K!" + 1 InputMask = "99999-999") foram
# perdidos: o CEP aparecia sem mascara (07083280) e os campos aceitavam
# minuscula. Compila limpo, nenhum gate pega - so se ve na tela.
#
# A comparacao eh por CONTAGEM, nunca por nome: o PILAR 3 manda RENOMEAR os
# objetos (getTipoNomes -> txt_4c_TipoNomes), entao casar legado x migrado pelo
# nome nunca funciona (mesma razao das regras #30 e #39). O script lista os
# objetos e valores do legado para quem for transcrever; o mapeamento final eh
# humano.
#
# Severidade:
#   ALTA  InputMask ausente      - muda o que eh digitado/gravado
#   MEDIA Format com '!' ausente - forca MAIUSCULA, muda o dado
#   BAIXA Format sem '!' ausente - so seleciona ao entrar (UX)
#
# Medido em 2026-10-08 no projeto inteiro: ALTA 541 sites/78 forms,
# MEDIA 350/106, BAIXA 534/104. Por isso NAO ha sweep automatico - o valor
# certo eh por controle e sai do dump.
#
# Ignora `Format = ""` / `InputMask = ""`: override VAZIO do Form Designer, que
# nao eh formatacao nenhuma (contava 678 sites a mais).
# =============================================================================
param(
    [string]$Forms    = "C:\4c\projeto\app\forms",
    [string]$Tasks    = "C:\4c\tasks",
    [string]$Form     = "",          # so este form (nome da classe), opcional
    [switch]$Detalhar                # lista objeto + valor do legado
)

$ErrorActionPreference = "Stop"

# ---- mapa classe -> dump do legado (task mais recente vence) ----------------
$dump = @{}
foreach ($t in (Get-ChildItem $Tasks -Directory -ErrorAction SilentlyContinue | Sort-Object Name)) {
    $aj = Join-Path $t.FullName "analise.json"
    if (-not (Test-Path $aj)) { continue }
    $txt = Get-Content $aj -Raw
    if ($txt -notmatch '"formClass"\s*:\s*"([^"]+)"') { continue }
    $cls = $Matches[1]
    $cod = Get-ChildItem (Join-Path $t.FullName "*_form_codigo_fonte.txt") -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($cod) { $dump[$cls.ToLower()] = $cod.FullName }
}

$tot = @{ ALTA = 0; MEDIA = 0; BAIXA = 0 }
$nForms = 0
$semDump = 0

foreach ($prg in (Get-ChildItem $Forms -Filter "*.prg" -Recurse -File | Sort-Object Name)) {
    $base = [IO.Path]::GetFileNameWithoutExtension($prg.Name)
    if ($Form -and $base -ne $Form) { continue }
    if (-not $dump.ContainsKey($base.ToLower())) { $semDump++; continue }

    $leg = Get-Content $dump[$base.ToLower()] -Raw
    $mig = Get-Content $prg.FullName -Raw

    # objeto + valor, so nao-vazios
    $legItens = @()
    $obj = ""
    foreach ($l in ($leg -split "`r?`n")) {
        if ($l -match '^\* PROPRIEDADES DE:\s*(\S+)') { $obj = $Matches[1]; continue }
        if ($l -match '^\s*(Format|InputMask)\s*=\s*"([^"]+)"') {
            $legItens += [pscustomobject]@{ Obj = $obj; Prop = $Matches[1]; Val = $Matches[2] }
        }
    }
    if ($legItens.Count -eq 0) { continue }

    $legMask  = @($legItens | Where-Object { $_.Prop -eq 'InputMask' })
    $legFmt   = @($legItens | Where-Object { $_.Prop -eq 'Format' })
    $migMask  = @([regex]::Matches($mig, '(?im)^\s*\.InputMask\s*=')).Count
    $migFmt   = @([regex]::Matches($mig, '(?im)^\s*\.Format\s*=')).Count

    $faltaMask = $legMask.Count - $migMask
    $faltaFmt  = $legFmt.Count  - $migFmt
    if ($faltaMask -le 0 -and $faltaFmt -le 0) { continue }

    $upper = @($legFmt | Where-Object { $_.Val -like '*!*' }).Count
    $sevM  = if ($faltaMask -gt 0) { $faltaMask } else { 0 }
    $sevA  = if ($faltaFmt  -gt 0) { [int][Math]::Round($faltaFmt * $upper / [Math]::Max($legFmt.Count,1)) } else { 0 }
    $sevB  = if ($faltaFmt  -gt 0) { $faltaFmt - $sevA } else { 0 }

    $tot.ALTA += $sevM; $tot.MEDIA += $sevA; $tot.BAIXA += $sevB
    $nForms++

    $cor = if ($sevM -gt 0) { "Red" } elseif ($sevA -gt 0) { "Yellow" } else { "DarkGray" }
    Write-Host ("[FORMAT] {0,-24} InputMask {1}/{2}  Format {3}/{4}   faltam: ALTA={5} MEDIA={6} BAIXA={7}" -f `
        $base, $migMask, $legMask.Count, $migFmt, $legFmt.Count, $sevM, $sevA, $sevB) -ForegroundColor $cor

    if ($Detalhar) {
        foreach ($it in $legItens) {
            Write-Host ("           legado: {0} {1} = `"{2}`"" -f $it.Obj, $it.Prop, $it.Val) -ForegroundColor DarkGray
        }
    }
}

Write-Host ""
Write-Host ("[FORMAT] forms com falta: {0}   ALTA={1} MEDIA={2} BAIXA={3}   (sem dump: {4})" -f `
    $nForms, $tot.ALTA, $tot.MEDIA, $tot.BAIXA, $semDump) -ForegroundColor Cyan
Write-Host "[FORMAT] ALTA=InputMask (muda o gravado)  MEDIA=Format com '!' (maiuscula)  BAIXA=Format sem '!' (so UX)" -ForegroundColor Cyan
Write-Host "[FORMAT] Transcrever do dump: o mapeamento objeto legado -> objeto migrado eh HUMANO (PILAR 3 renomeia)." -ForegroundColor Cyan

if ($tot.ALTA -gt 0) { exit 1 }
exit 0
