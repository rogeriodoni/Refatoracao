SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loForm, loE, loBO, loR, loc_nTit
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro368\mensagens.txt"
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("FormSIGREHPE")
    loForm = CREATEOBJECT("FormSIGREHPE")
    loc_nTit = TXTWIDTH(loForm.Caption, "Tahoma", 16, "B") * FONTMETRIC(6, "Tahoma", 16, "B")
    loc_cOut = loc_cOut + "form=" + VARTYPE(loForm) + " W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height) + ;
        " botoes L=" + TRANSFORM(loForm.cmg_4c_Botoes.Left) + " fim=" + TRANSFORM(loForm.cmg_4c_Botoes.Left + loForm.cmg_4c_Botoes.Width) + ;
        " | titulo L=" + TRANSFORM(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Left) + " texto=" + TRANSFORM(ROUND(loc_nTit,0)) + "px fim=" + TRANSFORM(ROUND(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Left + loc_nTit,0)) + ;
        " | lbl L=" + TRANSFORM(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Left) + " W=" + TRANSFORM(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Width) + " T=" + TRANSFORM(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Top) + " H=" + TRANSFORM(loForm.cnt_4c_Cabecalho.lbl_4c_Titulo.Height) + " | fundo=" + JUSTFNAME(loForm.Picture) + CHR(13)+CHR(10)
    SET DATASESSION TO loForm.DataSessionId
    loBO = loForm.this_oRelatorio
    loc_cOut = loc_cOut + "PrepararDados=" + TRANSFORM(loBO.PrepararDados()) + " regs=" + TRANSFORM(RECCOUNT("CsRelatorio")) + " frx=" + JUSTFNAME(loBO.this_cArquivoFRX) + " existe=" + TRANSFORM(FILE(loBO.this_cArquivoFRX)) + CHR(13)+CHR(10)
    SELECT CsRelatorio
    SCAN
        loc_cOut = loc_cOut + "   " + PADR(Umovs, 16) + TRANSFORM(Valor, "999,999,999.99") + CHR(13)+CHR(10)
    ENDSCAN
    loR = CREATEOBJECT("T368BO")
    loc_cOut = loc_cOut + "render paginas=" + TRANSFORM(loR.Renderizar()) + " cab=" + ALLTRIM(csCabecalho.Empresa) + " / " + ALLTRIM(csCabecalho.Titulo) + CHR(13)+CHR(10)
    SET DATASESSION TO 1
    loForm.Release()
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro368\simulacao_out.txt")
QUIT

DEFINE CLASS T368BO AS SIGREHPEBO
    PROCEDURE Renderizar()
        LOCAL loL
        THIS.PrepararDados()
        THIS.MontarCabecalho()
        SELECT CsRelatorio
        GO TOP
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (THIS.this_cArquivoFRX) OBJECT loL
        loL.OutputPage(1, "C:\4c\refatoracao\automation\erro368\resumo.png", 104)
        RETURN loL.PageTotal
    ENDPROC
ENDDEFINE
