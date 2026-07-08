$content = [System.IO.File]::ReadAllText('C:/4c/projeto/app/classes/sigopindBO.prg', [System.Text.Encoding]::GetEncoding(1252))

# Fix 2: Add SET NULL ON/OFF around CREATE CURSOR cursor_4c_Saldos (empty group branch)
$old2 = "`t`t`tIF EMPTY(ALLTRIM(par_cGrupo))`r`n`t`t`t`t*-- Grupo invalido: cria cursor vazio`r`n`t`t`t`tCREATE CURSOR cursor_4c_Saldos (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), Saldos N(12,2), Rclis C(50), Situas C(1), Cpfs C(14), ContaMats C(10), Matriz C(1))`r`n`t`t`t`tloc_lResultado = .T."
$new2 = "`t`t`tIF EMPTY(ALLTRIM(par_cGrupo))`r`n`t`t`t`t*-- Grupo invalido: cria cursor vazio`r`n`t`t`t`tSET NULL ON`r`n`t`t`t`tCREATE CURSOR cursor_4c_Saldos (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), Saldos N(12,2), Rclis C(50), Situas C(1), Cpfs C(14), ContaMats C(10), Matriz C(1))`r`n`t`t`t`tSET NULL OFF`r`n`t`t`t`tloc_lResultado = .T."
if ($content.Contains($old2)) {
    $content = $content.Replace($old2, $new2)
    Write-Host "Fix 2 applied"
} else {
    Write-Host "Fix 2 NOT FOUND"
}

[System.IO.File]::WriteAllText('C:/4c/projeto/app/classes/sigopindBO.prg', $content, [System.Text.Encoding]::GetEncoding(1252))
Write-Host "BO saved"
