$content = [System.IO.File]::ReadAllText('C:/4c/projeto/app/forms/operacionais/Formsigopind.prg', [System.Text.Encoding]::GetEncoding(1252))

# Fix 1: Remove InicializarForm call from Init (keep DODEFAULT only)
$old1 = "`t`t`t*-- Construir layout visual`r`n`t`t`tIF !THIS.InicializarForm()`r`n`t`t`t`tloc_lSucesso = .F.`r`n`t`t`tENDIF`r`n`r`n`t`t`tDODEFAULT()"
$new1 = "`t`t`t*-- Construir layout visual (FormBase.Init via DODEFAULT chama InicializarForm)`r`n`t`t`tDODEFAULT()"
if ($content.Contains($old1)) {
    $content = $content.Replace($old1, $new1)
    Write-Host "Fix 1 applied"
} else {
    Write-Host "Fix 1 NOT FOUND - trying alternate"
    # Try without double blank line
    $old1b = "`t`t`t*-- Construir layout visual`r`n`t`t`tIF !THIS.InicializarForm()`r`n`t`t`t`tloc_lSucesso = .F.`r`n`t`t`tENDIF`r`n`t`t`tDODEFAULT()"
    if ($content.Contains($old1b)) {
        $content = $content.Replace($old1b, $new1)
        Write-Host "Fix 1 alternate applied"
    } else {
        Write-Host "Fix 1 still NOT FOUND"
    }
}

# Fix 3a: Move ColumnCount=7 outside WITH in ConfigurarPaginaSaldo
$old3a = "`t`tloc_oPg.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`tWITH loc_oPg.grd_4c_Dados`r`n`t`t`t.ColumnCount    = 7"
$new3a = "`t`tloc_oPg.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`tloc_oPg.grd_4c_Dados.ColumnCount = 7`r`n`t`tWITH loc_oPg.grd_4c_Dados"
if ($content.Contains($old3a)) {
    $content = $content.Replace($old3a, $new3a)
    Write-Host "Fix 3a applied"
} else {
    Write-Host "Fix 3a NOT FOUND"
}

# Fix 3b: Move ColumnCount=10 outside WITH in ConfigurarPaginaHist
$old3b = "`t`tloc_oPg.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`tWITH loc_oPg.grd_4c_Dados`r`n`t`t`t.ColumnCount      = 10"
$new3b = "`t`tloc_oPg.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`tloc_oPg.grd_4c_Dados.ColumnCount = 10`r`n`t`tWITH loc_oPg.grd_4c_Dados"
if ($content.Contains($old3b)) {
    $content = $content.Replace($old3b, $new3b)
    Write-Host "Fix 3b applied"
} else {
    Write-Host "Fix 3b NOT FOUND"
}

# Fix 3c: Move ColumnCount=6 outside WITH in CriarContainerQuitas
$old3c = "`t`t`t.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`t`tWITH .grd_4c_Dados`r`n`t`t`t`t.ColumnCount      = 6"
$new3c = "`t`t`t.AddObject(`"grd_4c_Dados`", `"Grid`")`r`n`t`t`tloc_oPg.cnt_4c_Quitas.grd_4c_Dados.ColumnCount = 6`r`n`t`t`tWITH .grd_4c_Dados"
if ($content.Contains($old3c)) {
    $content = $content.Replace($old3c, $new3c)
    Write-Host "Fix 3c applied"
} else {
    Write-Host "Fix 3c NOT FOUND"
}

[System.IO.File]::WriteAllText('C:/4c/projeto/app/forms/operacionais/Formsigopind.prg', $content, [System.Text.Encoding]::GetEncoding(1252))
Write-Host "File saved"
