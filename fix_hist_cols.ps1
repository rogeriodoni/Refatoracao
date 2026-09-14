$content = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg' -Raw

# Fix Column1: should be Emp (IIF EmpCCs/Emps), not Datas
$old1 = 'loc_oGrd.Column1.ControlSource  = "cursor_4c_Historico.Datas"'
$new1 = 'loc_oGrd.Column1.ControlSource  = "IIF(!EMPTY(cursor_4c_Historico.EmpCCs), cursor_4c_Historico.EmpCCs, cursor_4c_Historico.Emps)"'

# Fix Column2: should be Datas, not Saldos
$old2 = 'loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.Saldos"'
$new2 = 'loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.Datas"'

# Fix Column6: should be Saldos, not IIF(EmpCCs...)
$old6 = 'loc_oGrd.Column6.ControlSource  = "IIF(!EMPTY(cursor_4c_Historico.EmpCCs), cursor_4c_Historico.EmpCCs, cursor_4c_Historico.Emps)"'
$new6 = 'loc_oGrd.Column6.ControlSource  = "cursor_4c_Historico.Saldos"'

if ($content.Contains($old1)) {
    $content = $content.Replace($old1, $new1)
    Write-Host "Fixed Column1"
} else {
    Write-Host "Column1 NOT FOUND"
}

if ($content.Contains($old2)) {
    $content = $content.Replace($old2, $new2)
    Write-Host "Fixed Column2"
} else {
    Write-Host "Column2 NOT FOUND"
}

if ($content.Contains($old6)) {
    $content = $content.Replace($old6, $new6)
    Write-Host "Fixed Column6"
} else {
    Write-Host "Column6 NOT FOUND"
}

[System.IO.File]::WriteAllText('C:\4c\projeto\app\forms\operacionais\Formsigopind.prg', $content)
Write-Host "DONE"
