SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro328_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPg, loT, loC
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "sigrectcBO.prg"), (gcDir + "Formsigrectc.prg") ADDITIVE
    loForm = CREATEOBJECT("Formsigrectc")
    L("form=" + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    loPg = loForm.pgf_4c_Paginas.Page1
    FOR EACH loC IN loPg.Controls
        IF INLIST(UPPER(loC.Name), "CHK_4C_ENTRADA", "CHK_4C_RECEBER", "CHK_4C_DEPOSITAR", "CHK_4C_BAIXA", "TXT_4C_DTINICIAL", "TXT_4C_FPAGS", "LBL_4C_FPAGS", "OPT_4C_TPDEP")
            L("  " + PADR(loC.Name, 18) + " Top=" + TRANSFORM(loC.Top) + " Left=" + TRANSFORM(loC.Left) + " Bottom=" + TRANSFORM(loC.Top + loC.Height) + " Right=" + TRANSFORM(loC.Left + loC.Width))
        ENDIF
    ENDFOR
    L("tela ao abrir: Datas=[" + TRANSFORM(loPg.txt_4c_DtInicial.Value) + "] a [" + TRANSFORM(loPg.txt_4c_DtFinal.Value) + "]")
    loT = CREATEOBJECT("T328")

    Cen(loForm, loT, "Imagem (nenhum marcado)",       0, 0, 0, 0, "", .F.)
    Cen(loForm, loT, "Entradas",                      1, 0, 0, 0, "", .F.)
    Cen(loForm, loT, "A Receber",                     0, 1, 0, 0, "", .F.)
    Cen(loForm, loT, "A Depositar",                   0, 0, 1, 0, "", .F.)
    Cen(loForm, loT, "Baixados",                      0, 0, 0, 1, "", .F.)
    Cen(loForm, loT, "Todos os 4",                    1, 1, 1, 1, "", .T.)
    Cen(loForm, loT, "Todos + cartao CIVISA CRED",    1, 1, 1, 1, "CIVISA CRED", .F.)
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

PROCEDURE Cen(par_oForm, par_oT, par_cNome, par_nE, par_nR, par_nD, par_nB, par_cCartao, par_lRender)
    LOCAL loPg
    loPg = par_oForm.pgf_4c_Paginas.Page1
    loPg.txt_4c_DtInicial.Value = DATE(2000,1,1)
    loPg.txt_4c_DtFinal.Value   = DATE(2026,11,9)
    loPg.chk_4c_Entrada.Value   = par_nE
    loPg.chk_4c_Receber.Value   = par_nR
    loPg.chk_4c_Depositar.Value = par_nD
    loPg.chk_4c_Baixa.Value     = par_nB
    loPg.txt_4c_Fpags.Value     = par_cCartao
    WITH par_oT
        .this_dDtInicial = loPg.txt_4c_DtInicial.Value
        .this_dDtFinal   = loPg.txt_4c_DtFinal.Value
        .this_cEmps      = ALLTRIM(loPg.txt_4c_Cemps.Value)
        .this_cFpags     = ALLTRIM(loPg.txt_4c_Fpags.Value)
        .this_lEntrada   = (loPg.chk_4c_Entrada.Value = 1)
        .this_lReceber   = (loPg.chk_4c_Receber.Value = 1)
        .this_lDepositar = (loPg.chk_4c_Depositar.Value = 1)
        .this_lBaixa     = (loPg.chk_4c_Baixa.Value = 1)
        .this_lDepPrev   = .F.
    ENDWITH
    L(PADR(par_cNome, 30) + " -> " + par_oT.Rodar(par_lRender, gcDir + "rel.txt"))
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T328 AS sigrectcBO
    PROCEDURE Rodar(par_lRender, par_cTxt)
        LOCAL lcR, loE2, lcN
        PRIVATE dDtInicial, dDtFinal
        dDtInicial = THIS.this_dDtInicial
        dDtFinal   = THIS.this_dDtFinal
        lcR = ""
        TRY
            IF THIS.PrepararDados() AND USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                lcN = ""
                SELECT (THIS.this_cCursorDados)
                SCAN
                    lcN = lcN + ALLTRIM(cMovimento) + ":" + TRANSFORM(ncarts) + "=" + TRANSFORM(valor) + " "
                ENDSCAN
                lcR = lcN
                IF par_lRender
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    SET REPORTBEHAVIOR 80
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) TO FILE (par_cTxt) ASCII NOCONSOLE
                    lcR = lcR + " | render OK"
                ENDIF
            ELSE
                lcR = "SEM DADOS " + THIS.this_cMensagemErro
            ENDIF
        CATCH TO loE2
            lcR = lcR + " ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
