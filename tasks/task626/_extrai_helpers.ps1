$src = Get-Content 'C:\4c\automation\OrquestradorMigracao.ps1'
$nomes = @('Get-ContagemBotoesLegado','Get-NomesBotoesLegado','Test-AcaoDoLegadoTemHandler',
 'Test-LegadoAddCursorLigaGrade','Test-LegadoCliqueSoFecha','Test-LegadoControlSourceLigaLista',
 'Test-LegadoDialogoExibicao','Test-LegadoEscritaSoEmCursorLocal',
 'Test-LegadoEscritaSoEmTabelaLocalFree','Test-LegadoPersisteViaAddCursor','Test-LegadoSomenteLeitura',
 'Test-ModoRecebidoDoChamador','Test-LegadoSemBotaoAlgum','Test-LegadoSemCamposSoltos','Test-LegadoSemLookupAlgum',
 'Test-CompletudeCodigo')
$out = New-Object System.Collections.Generic.List[string]
for ($i=0; $i -lt $src.Count; $i++) {
  $m = [regex]::Match($src[$i], '^function\s+([A-Za-z0-9\-]+)')
  if (-not $m.Success) { continue }
  $nome = $m.Groups[1].Value
  if ($nomes -notcontains $nome) { continue }
  $j = $i
  while ($j -lt $src.Count -and -not ($src[$j] -eq '}' -and $j -gt $i)) { $out.Add($src[$j]); $j++ }
  $out.Add('}'); $out.Add('')
  Write-Host "extraido: $nome ($($i+1)..$($j+1))"
}
Set-Content -Path 'C:\4c\tasks\task626\_helpers_gate.ps1' -Value $out -Encoding UTF8
