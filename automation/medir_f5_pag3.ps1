# Carve-out "PAGINADO NAO-CRUD" da Fase 5, com as DUAS guardas reais:
#   (a) FormType = OPERACIONAL (lido de analise.json, mesma fonte do gate)
#   (b) nenhuma Page do PageFrame legado tem nome de Dados NEM de Lista
#       (teste por SUBSTRING: pgDados/PagDados/pgdados contam como Dados)
$ErrorActionPreference = 'Stop'
$res = New-Object System.Collections.ArrayList

Get-ChildItem 'C:\4c\tasks' -Directory | ForEach-Object {
  $taskDir = $_; $task = $_.Name

  $ft = 'CRUD'
  $aj = Join-Path $taskDir.FullName 'analise.json'
  if (Test-Path $aj) {
    try { $o = (Get-Content $aj -Raw | ConvertFrom-Json); if ($o.form.formType) { $ft = $o.form.formType } } catch {}
  }

  Get-ChildItem $taskDir.FullName -Filter '*_form_codigo_fonte.txt' -File -EA SilentlyContinue | ForEach-Object {
    $base = $_.BaseName -replace '_form_codigo_fonte$',''
    $linhas = Get-Content $_.FullName -EA SilentlyContinue
    if (-not $linhas) { return }

    $objAtual=''; $parentAtual=''; $pgfs=@{}; $paginas=@{}; $nTb=0
    foreach ($l in $linhas) {
      if     ($l -match '^\s*Objeto:\s*(\S+)\s*$')        { $objAtual=$matches[1]; $parentAtual='' }
      elseif ($l -match '^\s*Parent:\s*(\S+)\s*$')        { $parentAtual=$matches[1] }
      elseif ($l -match '^\s*BaseClass:\s*pageframe\s*$') { if ($objAtual) { $pgfs[$objAtual.ToUpper()]=$true } }
      elseif ($l -match '^\s*BaseClass:\s*textbox\s*$')   { if ($parentAtual -notmatch '(?i)\.Column\d+$') { $nTb++ } }
    }
    if ($pgfs.Count -eq 0) { return }

    foreach ($l in $linhas) {
      if ($l -match '^\s*Parent:\s*(\S+)\s*$') {
        $segs = $matches[1] -split '\.'
        for ($i=0; $i -lt $segs.Count-1; $i++) {
          if ($pgfs.ContainsKey($segs[$i].ToUpper())) { $paginas[$segs[$i+1]]=$true }
        }
      }
    }
    if ($paginas.Count -eq 0) { return }

    $temDadoOuLista = @($paginas.Keys | Where-Object { $_ -match '(?i)(dado|lista)' }).Count -ge 1

    [void]$res.Add([pscustomobject]@{
      Task=$task; Base=$base; FT=$ft; Paginas=(($paginas.Keys) -join '/')
      TemDadoOuLista=$temDadoOuLista; NTb=$nTb })
  }
}

$oper = @($res | Where-Object { $_.FT -eq 'OPERACIONAL' })
$cand = @($oper | Where-Object { -not $_.TemDadoOuLista -and $_.NTb -ge 1 })
"dumps com PageFrame                  : $($res.Count)"
"  destes, FormType = OPERACIONAL     : $($oper.Count)"
"    OPERACIONAL com Page Dado/Lista  : $(@($oper | Where-Object TemDadoOuLista).Count)  (reprovam - ramo PAGINADO original)"
"    OPERACIONAL sem campo (NTb=0)    : $(@($oper | Where-Object { -not $_.TemDadoOuLista -and $_.NTb -lt 1 }).Count)  (reprovam)"
"  CANDIDATOS do carve-out            : $($cand.Count)"
"  forms distintos                    : $(@($cand | Select-Object -ExpandProperty Base -Unique).Count)"
""
"--- CANDIDATOS ---"
$cand | Sort-Object Base | Format-Table Task,Base,Paginas,NTb -AutoSize
""
"--- OPERACIONAL que o carve-out RECUSA (tem Page Dado/Lista) ---"
@($oper | Where-Object TemDadoOuLista) | Sort-Object Base | Format-Table Task,Base,Paginas -AutoSize
