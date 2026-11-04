# Replica standalone dos checks do Orquestrador que valem para a Fase 8.
# NAO dot-source o OrquestradorMigracao.ps1 (isso dispara migracao).
param(
    [string]$Form = 'C:\4c\projeto\app\forms\operacionais\FormSIGOPCPE.prg',
    [string]$BO   = 'C:\4c\projeto\app\classes\SIGOPCPEBO.prg',
    [string]$Dump = 'C:\4c\tasks\task709\SIGOPCPE_form_codigo_fonte.txt'
)

$falhas = 0

function Test-Completude {
    param([string]$FilePath, [string]$Descricao)
    $content = Get-Content $FilePath -Raw
    $problemas = @()

    $todoPattern = "(?im)^\s*\*\-?\-?\s*(TODO|FIXME|HACK|XXX|PLACEHOLDER)\b"
    foreach ($m in [regex]::Matches($content, $todoPattern)) {
        $problemas += "Marcador: $($m.Value.Trim())"
    }

    $procPattern = "(?ims)PROCEDURE\s+(\w+)\s*(\(.*?\))?\s*\r?\n(.*?)ENDPROC"
    foreach ($m in [regex]::Matches($content, $procPattern)) {
        $procName = $m.Groups[1].Value
        $body     = $m.Groups[3].Value
        if ($body -match "DODEFAULT\(\)") { continue }
        if ($procName -match "^Tecla" -and $m.Groups[2].Value -match "par_nKeyCode") { continue }
        $codeLines = ($body -split "`n" | Where-Object {
            $_ -match "\S" -and $_ -notmatch "^\s*\*" -and $_ -notmatch "^\s*&&"
        } | Measure-Object).Count
        if ($codeLines -eq 0) { $problemas += "Procedure vazia: $procName" }
    }

    $laterPattern = "(?im)\*.*?(implementar\s+(depois|later|futur)|pr[oó]xima\s+fase|\bpendente|nao\s+implement)"
    foreach ($m in [regex]::Matches($content, $laterPattern)) {
        $problemas += "Pendencia: $($m.Value.Trim())"
    }

    $stubMsgPattern = '(?im)MsgAviso\(.+?(implementad|ser.{1,5}\s+implementad|n.o\s+dispon.vel|em\s+desenvolvimento)'
    foreach ($m in [regex]::Matches($content, $stubMsgPattern)) {
        $problemas += "Stub MsgAviso"
    }

    if ($problemas.Count -gt 0) {
        Write-Host "[COMPLETUDE-FALHA] $Descricao" -ForegroundColor Red
        $problemas | ForEach-Object { Write-Host "   - $_" -ForegroundColor Yellow }
        return $false
    }
    Write-Host "[OK] Completude - $Descricao" -ForegroundColor Green
    return $true
}

if (-not (Test-Completude -FilePath $Form -Descricao 'FormSIGOPCPE.prg')) { $falhas++ }
if (-not (Test-Completude -FilePath $BO   -Descricao 'SIGOPCPEBO.prg'))   { $falhas++ }

# --- Gate da Fase 8: nomes obrigatorios -------------------------------------
$conteudo      = Get-Content $Form -Raw
$metodosFinals = @("BtnCancelarClick", "FormParaBO", "BOParaForm", "CarregarLista")
$faltantes     = @($metodosFinals | Where-Object { $conteudo -notmatch $_ })

if ($faltantes.Count -eq 0) {
    Write-Host "[OK] Gate Fase 8 - os 4 nomes obrigatorios estao presentes" -ForegroundColor Green
} else {
    Write-Host "[GATE-FALHA] Fase 8 - faltam: $($faltantes -join ', ')" -ForegroundColor Red
    $falhas++
}

# --- Botao de gravar no legado (o gate dispensa BtnSalvarClick se nao ha) ----
$txt = Get-Content $Dump -Raw
$padroesSalvar = @('btnSalvar', 'btnGravar', 'PROCEDURE\s+\w*(Salvar|Gravar)\w*\.Click', 'mGravaDados')
$achados = @($padroesSalvar | Where-Object { $txt -match $_ })
if ($achados.Count -eq 0) {
    Write-Host "[OK] Legado SEM botao de gravar nomeado Salvar/Gravar - BtnSalvarClick dispensado pelo gate" -ForegroundColor Green
} else {
    Write-Host "[ATENCAO] Legado TEM padrao de gravar: $($achados -join ', ') - BtnSalvarClick seria exigido" -ForegroundColor Yellow
}

# --- RETURN dentro de TRY (regra #1), por profundidade -----------------------
$linhas = Get-Content $Form
$prof = 0; $retDentro = @()
for ($i = 0; $i -lt $linhas.Count; $i++) {
    $l = $linhas[$i]
    if ($l -match '^\s*\*') { continue }
    if ($l -match '(?i)^\s*TRY\b')    { $prof++ }
    if ($l -match '(?i)^\s*ENDTRY\b') { $prof-- }
    if ($prof -gt 0 -and $l -match '(?i)^\s*RETURN\b') { $retDentro += "L$($i+1): $($l.Trim())" }
}
if ($retDentro.Count -eq 0) {
    Write-Host "[OK] Regra #1 - nenhum RETURN dentro de TRY/CATCH" -ForegroundColor Green
} else {
    Write-Host "[FALHA] Regra #1 - RETURN dentro de TRY:" -ForegroundColor Red
    $retDentro | ForEach-Object { Write-Host "   - $_" -ForegroundColor Yellow }
    $falhas++
}

# --- Acentos literais (regra #4) --------------------------------------------
foreach ($f in @($Form, $BO)) {
    $bytes = [System.IO.File]::ReadAllBytes($f)
    $naoAscii = @($bytes | Where-Object { $_ -gt 126 }).Count
    if ($naoAscii -eq 0) {
        Write-Host "[OK] Regra #4 - zero byte nao-ASCII em $(Split-Path $f -Leaf)" -ForegroundColor Green
    } else {
        Write-Host "[FALHA] Regra #4 - $naoAscii byte(s) nao-ASCII em $(Split-Path $f -Leaf)" -ForegroundColor Red
        $falhas++
    }
}

Write-Host ""
if ($falhas -eq 0) {
    Write-Host "RESULTADO: todos os checks passaram" -ForegroundColor Green
    exit 0
} else {
    Write-Host "RESULTADO: $falhas check(s) falharam" -ForegroundColor Red
    exit 1
}
