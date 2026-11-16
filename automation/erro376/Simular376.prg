SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
SET DATE TO BRITISH
SET CENTURY ON
LOCAL loc_cOut, loE
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, gnConnHandle, gc_376Png, gc_376Info
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gc_4c_ArquivoErroTeste = "C:\4c\refatoracao\automation\erro376\mensagens.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)
loc_cOut = ""
TRY
    CD "C:\4c\refatoracao\projeto\app\start"
    DO config.prg
    ConfigurarAmbiente()
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    *-- VFP do usuario esta com classes\sigreifxbo.fxp aberto: carrega copia
    gl_4c_CargaSobDemanda = .F.
    SET PROCEDURE TO "C:\4c\refatoracao\automation\erro376\sigreifxBO_sim.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\refatoracao\projeto\app\forms\relatorios\Formsigreifx.prg" ADDITIVE

    loc_cOut = loc_cOut + Cenario("001", "", 0, "A_menu", "A) pelo menu, sem documento (a imagem)")
    loc_cOut = loc_cOut + Cenario("001", "VENDA", 19, "B_venda19", "B) VENDA 19")
    loc_cOut = loc_cOut + Cenario("001", "PEDIDO RESUMO", 106, "C_pedido106", "C) PEDIDO RESUMO 106")
    loc_cOut = loc_cOut + Cenario("001", "VENDA", 999999, "D_inexistente", "D) VENDA 999999 (nao existe)")
CATCH TO loE
    loc_cOut = loc_cOut + "ERRO: " + loE.Message + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Procedure + " | " + loE.LineContents + CHR(13)+CHR(10)
ENDTRY
STRTOFILE(loc_cOut, "C:\4c\refatoracao\automation\erro376\simulacao_out.txt")
QUIT

FUNCTION Cenario(par_cEmp, par_cDop, par_nNum, par_cPng, par_cTit)
    LOCAL loForm, loR, loOrig, loc_c, loE2
    loc_c = par_cTit + ": "
    TRY
        loForm = CREATEOBJECT("Formsigreifx", par_cEmp, par_cDop, par_nNum, 0, .F.)
        loc_c = loc_c + "form=" + VARTYPE(loForm)
        IF VARTYPE(loForm) = "O"
            loc_c = loc_c + " caption=[" + loForm.Caption + "] W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height)
            SET DATASESSION TO loForm.DataSessionId
            loOrig = loForm.this_oRelatorio
            loR = CREATEOBJECT("T376BO")
            loR.this_cEmps = loOrig.this_cEmps
            loR.this_cDopes = loOrig.this_cDopes
            loR.this_nNumes = loOrig.this_nNumes
            loR.this_nTpImpressao = loOrig.this_nTpImpressao
            loForm.this_oRelatorio = loR
            gc_376Png = "C:\4c\refatoracao\automation\erro376\" + par_cPng + ".png"
            gc_376Info = "(nao renderizou)"
            loForm.BtnVisualizarClick()
            loc_c = loc_c + CHR(13)+CHR(10) + "     " + gc_376Info + IIF(EMPTY(loR.this_cMensagemErro), "", " msg=[" + loR.this_cMensagemErro + "]")
            SET DATASESSION TO 1
            loForm.this_oRelatorio = .NULL.
            loForm.Release()
        ENDIF
    CATCH TO loE2
        loc_c = loc_c + " ERRO: " + loE2.Message + " linha " + TRANSFORM(loE2.LineNo) + " " + loE2.Procedure
    ENDTRY
    RETURN loc_c + CHR(13)+CHR(10)
ENDFUNC

DEFINE CLASS T376BO AS sigreifxBO
    PROCEDURE ExecutarRelatorio(par_lPreview)
        LOCAL loL, loc_c, loc_cFrx, loc_cAlias
        loc_cAlias = ALIAS()
        loc_cFrx = ICASE(INLIST(LocalOpe.Docus, 3, 11), "SigReIfx", LocalOpe.Docus = 7, "SigRevf3", ;
            LocalOpe.Docus = 10, "SigRevfs", "SigReIfi")
        loc_c = "Docus=" + TRANSFORM(LocalOpe.Docus) + " frx=" + loc_cFrx + " alias=" + loc_cAlias + ;
            " crDados=" + TRANSFORM(RECCOUNT("crDados")) + " cab=[" + ALLTRIM(crCabecalho.Dopes) + " " + TRANSFORM(crCabecalho.Numes) + " " + ALLTRIM(crCabecalho.RazSocs) + "]" + ;
            " logo=" + JUSTFNAME(THIS.this_cImgLogotipo) + "(" + TRANSFORM(IIF(FILE(THIS.this_cImgLogotipo), LEN(FILETOSTR(THIS.this_cImgLogotipo)), -1)) + "b)"
        SELECT crDados
        SCAN
            loc_c = loc_c + CHR(13)+CHR(10) + "       " + ALLTRIM(CPros) + " " + LEFT(ALLTRIM(DPros), 30) + " qtd=" + TRANSFORM(Qtds) + " tot=" + TRANSFORM(Totas)
        ENDSCAN
        SELECT (loc_cAlias)
        GO TOP

        SET REPORTBEHAVIOR 90
        loL = CREATEOBJECT("ReportListener")
        loL.ListenerType = 3
        REPORT FORM (gc_4c_CaminhoReports + loc_cFrx) OBJECT loL
        loL.OutputPage(1, gc_376Png, 104)
        gc_376Info = loc_c + CHR(13)+CHR(10) + "     paginas=" + TRANSFORM(loL.PageTotal)
    ENDPROC
ENDDEFINE
