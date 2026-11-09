SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro326_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPg, loT
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "sigrecrfBO.prg"), (gcDir + "Formsigrecrf.prg") ADDITIVE
    loForm = CREATEOBJECT("Formsigrecrf")
    L("form=" + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    SET DELETED ON
    loPg = loForm.pgf_4c_Paginas.Page1
    L("tela: Data=" + TRANSFORM(loPg.txt_4c_Datas.Value) + " OptLocal=" + TRANSFORM(loPg.obj_4c_OptLocal.Value) + " SET DELETED=" + SET("DELETED"))
    loT = CREATEOBJECT("T326")

    Cen(loForm, loT, "Imagem: 01/01/2000 Diferencas", DATE(2000,1,1), 4, "", "", "", "", .T.)
    Cen(loForm, loT, "01/01/2000 Todas",              DATE(2000,1,1), 1, "", "", "", "", .F.)
    Cen(loForm, loT, "01/01/2000 Somente Lidos",      DATE(2000,1,1), 2, "", "", "", "", .F.)
    Cen(loForm, loT, "01/01/2000 Nao Lidos",          DATE(2000,1,1), 3, "", "", "", "", .F.)
    Cen(loForm, loT, "Vendedor DANISA Diferencas",    DATE(2000,1,1), 4, "DANISA", "", "", "", .F.)
    Cen(loForm, loT, "Vendedor LETICIA Diferencas",   DATE(2000,1,1), 4, "LETICIA", "", "", "", .F.)
    Cen(loForm, loT, "Grupo 11210/Conta 1121001",     DATE(2000,1,1), 1, "", "11210", "1121001", "", .F.)
    Cen(loForm, loT, "Produto TST326C",               DATE(2000,1,1), 1, "", "", "", "TST326C", .F.)
    Cen(loForm, loT, "Data 09/11/2026 Diferencas",    DATE(2026,11,9), 4, "", "", "", "", .F.)
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

PROCEDURE Cen(par_oForm, par_oT, par_cNome, par_dData, par_nOpt, par_cVend, par_cGru, par_cEst, par_cPro, par_lRender)
    LOCAL loPg
    loPg = par_oForm.pgf_4c_Paginas.Page1
    loPg.txt_4c_Datas.Value       = par_dData
    loPg.obj_4c_OptLocal.Value    = par_nOpt
    loPg.txt_4c_Conta.Value       = par_cVend
    loPg.txt_4c_Cd_GrEstoque.Value = par_cGru
    loPg.txt_4c_Cd_Estoque.Value  = par_cEst
    loPg.txt_4c__Produto.Value    = par_cPro
    WITH par_oT
        .this_dData        = loPg.txt_4c_Datas.Value
        .this_cCods        = ALLTRIM(loPg.txt_4c_Codigo.Value)
        .this_cConta       = ALLTRIM(loPg.txt_4c_Conta.Value)
        .this_cCdGrEstoque = ALLTRIM(loPg.txt_4c_Cd_GrEstoque.Value)
        .this_cCdEstoque   = ALLTRIM(loPg.txt_4c_Cd_Estoque.Value)
        .this_cProduto     = ALLTRIM(loPg.txt_4c__Produto.Value)
        .this_nOptLocal    = loPg.obj_4c_OptLocal.Value
    ENDWITH
    L(PADR(par_cNome, 32) + " -> " + par_oT.Rodar(par_lRender, gcDir + "rel_opt" + TRANSFORM(par_nOpt) + ".txt"))
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T326 AS sigrecrfBO
    PROCEDURE Rodar(par_lRender, par_cTxt)
        LOCAL lcR, loE2, lcN
        lcR = ""
        TRY
            IF THIS.PrepararDados()
                lcN = ""
                SELECT crRel
                SCAN
                    lcN = lcN + ALLTRIM(cpros) + "(lido " + TRANSFORM(qtds) + "/est " + TRANSFORM(qtde) + ") "
                ENDSCAN
                lcR = "linhas=" + TRANSFORM(RECCOUNT("crRel")) + " " + lcN + " VisualizaCtg=" + TRANSFORM(csCabecalho.VisualizaCtg)
                IF par_lRender
                    SELECT crRel
                    GO TOP
                    SET REPORTBEHAVIOR 80
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) TO FILE (par_cTxt) ASCII NOCONSOLE
                    lcR = lcR + " | render OK"
                ENDIF
            ELSE
                lcR = "SEM DADOS: " + THIS.this_cMensagemErro
            ENDIF
        CATCH TO loE2
            lcR = lcR + " ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
