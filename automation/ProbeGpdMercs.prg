*-- Erro180: o grupo incluido tem de nascer com mercs = filtro Grande Grupo.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_gpdmercs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_gpdmercs.txt"
LOCAL loc_oE, loc_oForm, loc_nR, loc_oPg1, loc_oPgD, loc_oBO
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT)
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gpdbo.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formgpd.prg") ADDITIVE
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    STRTOFILE("B: conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT, 1)

    SQLEXEC(gnConnHandle, "DELETE FROM SigCdGrp WHERE cgrus = 'Z97'")

    loc_oForm = CREATEOBJECT("Formgpd")
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page1
    loc_oPgD = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    loc_oBO  = loc_oForm.this_oBusinessObject
    STRTOFILE("C: Init OK" + CHR(13)+CHR(10), OUT, 1)

    *-- (1) Incluir SEM Grande Grupo: o guard do legado tem de barrar
    loc_oPg1.cnt_4c_Filtros.txt_4c_Gde.Value = ""
    loc_oForm.this_cModoAtual = "LISTA"
    loc_oForm.BtnIncluirClick()
    STRTOFILE("=== 1) Incluir SEM Grande Grupo" + CHR(13)+CHR(10) + ;
        "   modo = [" + loc_oForm.this_cModoAtual + "] (esperado LISTA)" + ;
        "  ActivePage = " + TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + ;
        " (esperado 1)" + CHR(13)+CHR(10), OUT, 1)

    *-- (2) Incluir COM Grande Grupo: registro nasce associado + defaults
    loc_oPg1.cnt_4c_Filtros.txt_4c_Gde.Value = "JOO"
    loc_oForm.BtnIncluirClick()
    STRTOFILE("=== 2) Incluir COM Grande Grupo [JOO]" + CHR(13)+CHR(10) + ;
        "   modo = [" + loc_oForm.this_cModoAtual + "]  ActivePage = " + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13)+CHR(10) + ;
        "   BO.this_cMercs   = [" + loc_oBO.this_cMercs + "]" + CHR(13)+CHR(10) + ;
        "   txt_4c_Mercs     = [" + loc_oPgD.txt_4c_Mercs.Value + "]  <- tela" + CHR(13)+CHR(10) + ;
        "   cestoqs=" + TRANSFORM(loc_oBO.this_lCestoqs) + ;
        " bpesos=" + TRANSFORM(loc_oBO.this_nBpesos) + ;
        " atucomps=" + TRANSFORM(loc_oBO.this_lAtucomps) + ;
        " fornecs=" + TRANSFORM(loc_oBO.this_nFornecs) + ;
        " avalests=" + TRANSFORM(loc_oBO.this_lAvalests) + ;
        " etidups=" + TRANSFORM(loc_oBO.this_nEtidups) + ;
        " mtprimas=" + TRANSFORM(loc_oBO.this_nMtprimas) + CHR(13)+CHR(10), OUT, 1)

    *-- (3) grava e confere no BANCO
    loc_oPgD.txt_4c_Cgrus.Value = "Z97"
    loc_oPgD.txt_4c_Dgrus.Value = "TESTE ERRO180"
    loc_oForm.BtnSalvarClick()
    loc_nR = SQLEXEC(gnConnHandle, ;
        "SELECT cgrus, dgrus, mercs, cestoqs, bpesos, atucomps, fornecs, " + ;
        "avalests, etidups, mtprimas FROM SigCdGrp WHERE cgrus = 'Z97'", "crV")
    STRTOFILE("=== 3) BANCO apos Confirmar (SQLEXEC=" + TRANSFORM(loc_nR) + ;
        " linhas=" + IIF(USED("crV"), TRANSFORM(RECCOUNT("crV")), "?") + ")" + ;
        CHR(13)+CHR(10), OUT, 1)
    IF USED("crV") AND RECCOUNT("crV") > 0
        STRTOFILE("   cgrus=[" + crV.cgrus + "] dgrus=[" + ALLTRIM(crV.dgrus) + ;
            "] MERCS=[" + crV.mercs + "]" + CHR(13)+CHR(10) + ;
            "   cestoqs=" + TRANSFORM(crV.cestoqs) + " bpesos=" + TRANSFORM(crV.bpesos) + ;
            " atucomps=" + TRANSFORM(crV.atucomps) + " fornecs=" + TRANSFORM(crV.fornecs) + ;
            " avalests=" + TRANSFORM(crV.avalests) + " etidups=" + TRANSFORM(crV.etidups) + ;
            " mtprimas=" + TRANSFORM(crV.mtprimas) + CHR(13)+CHR(10) + ;
            "   (legado: mercs=JOO cestoqs=1 bpesos=2 atucomps=1 fornecs=2 " + ;
            "avalests=1 etidups=2 mtprimas=3)" + CHR(13)+CHR(10), OUT, 1)
    ENDIF
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdGrp WHERE cgrus = 'Z97'")
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'Z97'")
    STRTOFILE("   limpeza Z97 executada" + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT
