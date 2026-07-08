$content = Get-Content 'C:\4c\projeto\app\forms\operacionais\Formsigopind.prg' -Raw

$idx = $content.IndexOf('PUBLIC PROCEDURE BtnEncerrarHistClick')
$endIdx = $content.IndexOf('ENDPROC', $idx) + 7

$t = "`t"
$n = "`r`n"
$q = '"'

$newChunk = "PUBLIC PROCEDURE BtnEncerrarHistClick()$n"
$newChunk += "${t}${t}LOCAL loc_lcGrupo, loc_lcCliente$n"
$newChunk += "${t}${t}THIS.DesabilitarContainers()$n"
$newChunk += "${t}${t}THIS.dataconcilia = {}$n"
$newChunk += "${t}${t}*-- Recarrega saldos do grupo antes de voltar$n"
$newChunk += "${t}${t}loc_lcGrupo   = THIS.pgf_4c_Principal.Page1.txt_4c_Grupo.Value$n"
$newChunk += "${t}${t}loc_lcCliente = THIS.cliente$n"
$newChunk += "${t}${t}THIS.MontaGrade(ALLTRIM(loc_lcGrupo))$n"
$newChunk += "${t}${t}*-- Posiciona no cliente consultado$n"
$newChunk += "${t}${t}IF USED(${q}cursor_4c_Saldos${q}) AND !EMPTY(ALLTRIM(loc_lcCliente))$n"
$newChunk += "${t}${t}${t}SELECT cursor_4c_Saldos$n"
$newChunk += "${t}${t}${t}LOCATE FOR ALLTRIM(Contas) = ALLTRIM(loc_lcCliente)$n"
$newChunk += "${t}${t}ENDIF$n"
$newChunk += "${t}${t}THIS.pgf_4c_Principal.Page1.grd_4c_Dados.Refresh()$n"
$newChunk += "${t}${t}THIS.pgf_4c_Principal.ActivePage = 1$n"
$newChunk += "${t}${t}THIS.operacao = ${q}${q}$n"
$newChunk += "${t}${t}THIS.pgf_4c_Principal.Page2.Enabled = .F.$n"
$newChunk += "${t}${t}THIS.pgf_4c_Principal.Page1.grd_4c_Dados.SetFocus()$n"
$newChunk += "${t}ENDPROC"

$newContent = $content.Substring(0, $idx) + $newChunk + $content.Substring($endIdx)
[System.IO.File]::WriteAllText('C:\4c\projeto\app\forms\operacionais\Formsigopind.prg', $newContent)
Write-Host "DONE - BtnEncerrarHistClick fixed"
