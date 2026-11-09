SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro325_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loF, loT
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    L("conn=" + TRANSFORM(gnConnHandle) + " empresa=[" + TRANSFORM(go_4c_Sistema.cCodEmpresa) + "]")
    go_4c_Sistema.cCodEmpresa = "001"
    GarantirClasse("Formsigrecpr")
    loForm = CREATEOBJECT("Formsigrecpr")
    L("form=" + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    loF = loForm.cnt_4c_Filtros
    L("tela: TipoRel ListIndex=" + TRANSFORM(loF.cbo_4c_TipoRel.ListIndex) + " [" + loF.cbo_4c_TipoRel.DisplayValue + "]" + ;
      " OptFiltro=" + TRANSFORM(loF.opt_4c_OptFiltro.Value) + " Bons=" + TRANSFORM(loF.opt_4c_Bons.Value) + " Opcao=" + TRANSFORM(loF.opt_4c_Opcao.Value))
    loF.txt_4c_DataIni.Value = DATE(2000, 1, 1)
    loF.txt_4c_DataFin.Value = DATE(2026, 11, 9)
    loT = CREATEOBJECT("T325")

    Cen(loForm, loT, 1, 1, 1, .T.)
    Cen(loForm, loT, 2, 1, 1, .F.)
    Cen(loForm, loT, 1, 2, 1, .F.)
    Cen(loForm, loT, 1, 3, 1, .F.)
    Cen(loForm, loT, 1, 4, 1, .F.)
    Cen(loForm, loT, 1, 4, 2, .F.)
    Cen(loForm, loT, 1, 5, 1, .F.)
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

PROCEDURE Cen(par_oForm, par_oT, par_nFiltro, par_nRel, par_nBons, par_lRender)
    LOCAL loF, loB, lcRet
    loF = par_oForm.cnt_4c_Filtros
    loF.opt_4c_OptFiltro.Value  = par_nFiltro
    loF.cbo_4c_TipoRel.ListIndex = par_nRel
    loF.opt_4c_Bons.Value       = par_nBons
    WITH par_oT
        .this_dDataIni    = loF.txt_4c_DataIni.Value
        .this_dDataFin    = loF.txt_4c_DataFin.Value
        .this_nTipoFiltro = loF.opt_4c_OptFiltro.Value
        .this_nTipoRel    = loF.cbo_4c_TipoRel.ListIndex
        .this_nBons       = loF.opt_4c_Bons.Value
        .this_nOpcao      = loF.opt_4c_Opcao.Value
    ENDWITH
    lcRet = par_oT.Rodar(par_lRender, gcDir + "rel_f" + TRANSFORM(par_nFiltro) + "_r" + TRANSFORM(par_nRel) + ".txt")
    L(IIF(par_nFiltro = 1, "Prorrogados", "Vencimento ") + " | " + PADR(loF.cbo_4c_TipoRel.DisplayValue, 10) + ;
      IIF(par_nRel = 4, " bons=" + TRANSFORM(par_nBons), "      ") + " -> " + lcRet)
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T325 AS sigrecprBO
    PROCEDURE Rodar(par_lRender, par_cTxt)
        LOCAL lcR, loE2, lcN
        lcR = ""
        TRY
            IF THIS.PrepararDados() AND THIS.MontarCabecalho()
                lcN = ""
                SELECT CsRelatorio
                SCAN
                    lcN = lcN + ALLTRIM(nums) + " "
                ENDSCAN
                lcR = "linhas=" + TRANSFORM(RECCOUNT("CsRelatorio")) + " [" + ALLTRIM(lcN) + "] titulo=[" + ALLTRIM(CsCabecalho.Titulo) + "]"
                IF par_lRender
                    SELECT CsRelatorio
                    GO TOP
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                    SET REPORTBEHAVIOR 80
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCpr.frx") TO FILE (par_cTxt) ASCII NOCONSOLE
                    lcR = lcR + " | render OK"
                ENDIF
            ELSE
                lcR = "FALHOU " + THIS.this_cMensagemErro
            ENDIF
        CATCH TO loE2
            lcR = lcR + " ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
