SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_PrbDir, gn_4c_PrbPag
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_PrbDir = "C:\4c\refatoracao\automation\erro365\probe\"
gn_4c_PrbPag = 0
gc_4c_ArquivoErroTeste = gc_4c_PrbDir + "mensagens_todas.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigregnf")
    CD (gc_4c_PrbDir)
    loForm = CREATEOBJECT("Formsigregnf")
    SET DATASESSION TO loForm.DataSessionId
    loForm.cnt_4c_Corpo.txt_4c_Serie.Value = "1"
    loForm.BtnProcessarClick()
    SELECT cursor_4c_TmpNFis
    COUNT FOR Flag TO lnM
    loc_cOut = loc_cOut + "na grade=" + TRANSFORM(RECCOUNT()) + " marcadas=" + TRANSFORM(lnM) + CHR(13)+CHR(10)
    loForm.BtnVisualizarClick()
    loc_cOut = loc_cOut + "paginas de preview=" + TRANSFORM(gn_4c_PrbPag) + " | grade apos=" + TRANSFORM(RECCOUNT("cursor_4c_TmpNFis")) + CHR(13)+CHR(10)
    =SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS n FROM SigMvNfi WHERE series = '1' AND impress > 0 AND cidchaves LIKE 'T364%'", "cursor_4c_Imp")
    loc_cOut = loc_cOut + "NFs de teste marcadas como impressas no banco=" + TRANSFORM(cursor_4c_Imp.n) + CHR(13)+CHR(10)
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, gc_4c_PrbDir + "todas_out.txt")
QUIT
