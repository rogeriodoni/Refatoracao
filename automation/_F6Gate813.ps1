$ErrorActionPreference = 'Stop'
$orq = 'C:\4c\automation\OrquestradorMigracao.ps1'
$all = Get-Content $orq

# extrai SO as definicoes de function necessarias (sem dot-source do arquivo
# inteiro, que dispararia a migracao - feedback_dot_source_orquestrador_dispara_migracao)
$necessarias = @('Get-ContagemBotoesLegado','Get-ContagemCamposLegadoForaDeGrade',
  'Test-LegadoAddCursorLigaGrade','Test-LegadoCamposSaoCelulasDeGrade',
  'Test-LegadoControlSourceLigaLista','Test-LegadoDialogoExibicao',
  'Test-LegadoListBoxLigaLista','Test-LegadoPaginadoSemPaginaDados',
  'Test-LegadoSomenteLeitura','Test-LegadoTokenGradeProprioForm')

$defs = New-Object System.Collections.Generic.List[string]
for ($i = 0; $i -lt $all.Count; $i++) {
    if ($all[$i] -match '^function\s+([A-Za-z\-]+)\s*\{?\s*$' -and $necessarias -contains $Matches[1]) {
        $depth = 0; $j = $i
        do {
            $depth += ([regex]::Matches($all[$j], '\{')).Count - ([regex]::Matches($all[$j], '\}')).Count
            $defs.Add($all[$j]); $j++
        } while ($depth -gt 0 -and $j -lt $all.Count)
    }
}
$faltando = @($necessarias | Where-Object { ($defs -join "`n") -notmatch "function\s+$_\b" })
if ($faltando.Count) { throw "funcoes nao extraidas: $($faltando -join ', ')" }

# corpo do case 6, VERBATIM
$corpo = $all[(11136-1)..(11687-1)]

# contexto que o case 6 le
$pre = @(
  '$formFile = "C:\4c\projeto\app\forms\operacionais\FormSigOpTot.prg"',
  '$TaskPath  = "C:\4c\tasks\task813"',
  '$BaseName  = "SigOpTot"',
  '$FormType  = "OPERACIONAL"',
  '$validado  = $false'
)
$post = @('"";"RESULTADO DO GATE case 6 -> validado = $validado"')

$harness = Join-Path $env:TEMP 'f6gate813.ps1'
Set-Content -Path $harness -Value ($defs + '' + $pre + $corpo + $post) -Encoding UTF8
& powershell -ExecutionPolicy Bypass -File $harness
