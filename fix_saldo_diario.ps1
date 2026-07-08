$content = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg' -Raw

# For Saldo Diario modes (combos 4, 5, 6), xConta cursor:
# Column2 = Date header -> xConta.Datas
# Column3 = Historico header -> xConta.Hists
# Column6 = Saldo header -> xConta.Saldos
# All others empty

$fixBlock = @'
		loc_oPg2.grd_4c_Dados.Column1.ControlSource  = "xConta.Datas"
			loc_oPg2.grd_4c_Dados.Column2.ControlSource  = "xConta.Saldos"
			loc_oPg2.grd_4c_Dados.Column3.ControlSource  = "xConta.Hists"
'@

# Build the correct block
$correctBlock = @'
		loc_oPg2.grd_4c_Dados.Column1.ControlSource  = ""
			loc_oPg2.grd_4c_Dados.Column2.ControlSource  = "xConta.Datas"
			loc_oPg2.grd_4c_Dados.Column3.ControlSource  = "xConta.Hists"
'@

# Actually let's do it properly - replace each occurrence of the wrong columns

# Each of the 3 Saldo Diario blocks has:
#   Column1 = xConta.Datas  (wrong)
#   Column2 = xConta.Saldos (wrong)
#   Column3 = xConta.Hists  (correct)
# Should be:
#   Column1 = "" (Emp header - leave empty)
#   Column2 = xConta.Datas (Data header)
#   Column3 = xConta.Hists (Historico header - already correct)
#   Column6 = xConta.Saldos (Saldo header)

# Fix column1 (xConta.Datas -> "")
$content = $content -replace [regex]::Escape('loc_oPg2.grd_4c_Dados.Column1.ControlSource  = "xConta.Datas"'), 'loc_oPg2.grd_4c_Dados.Column1.ControlSource  = ""'

# Fix column2 (xConta.Saldos -> xConta.Datas)
$content = $content -replace [regex]::Escape('loc_oPg2.grd_4c_Dados.Column2.ControlSource  = "xConta.Saldos"'), 'loc_oPg2.grd_4c_Dados.Column2.ControlSource  = "xConta.Datas"'

# Fix column6 ("" -> xConta.Saldos) for Saldo Diario blocks only
# The issue is there are multiple Column6 = "" lines. We need to identify which ones are in Saldo Diario blocks.
# The pattern is: after xConta.Datas, Column5="", Column6=""
# Let's do it differently - count replacements needed (3 blocks of 3 combo cases)

$count6 = ([regex]::Matches($content, [regex]::Escape('loc_oPg2.grd_4c_Dados.Column6.ControlSource  = ""'))).Count
Write-Host "Column6 empty occurrences: $count6"

[System.IO.File]::WriteAllText('C:\4c\projeto\app\forms\operacionais\Formsigopind.prg', $content)
Write-Host "DONE - Phase 1 fixed (Col1 and Col2)"
