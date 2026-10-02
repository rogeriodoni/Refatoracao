*-- Aba SubGrupos (Page7): grade ligada ao cursor compartilhado + inserir/excluir.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_gpdsgru.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
#DEFINE OUT "C:\4c\automation\probe_gpdsgru.txt"
LOCAL loc_oE, loc_oForm, loc_nR, loc_oPg1, loc_oPg7, loc_oPgD
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
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdGrp WHERE cgrus = 'Z96'")
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'Z96'")

    loc_oForm = CREATEOBJECT("Formgpd")
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_oPg1 = loc_oForm.pgf_4c_Paginas.Page1
    loc_oPgD = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
    loc_oPg7 = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7
    STRTOFILE(Dump7(loc_oPg7, "01-apos-Init"), OUT, 1)

    *-- INCLUIR com Grande Grupo
    loc_oPg1.cnt_4c_Filtros.txt_4c_Gde.Value = "JOO"
    loc_oForm.BtnIncluirClick()
    loc_oPgD.txt_4c_Cgrus.Value = "Z96"
    loc_oPgD.txt_4c_Dgrus.Value = "TESTE SGRU"

    *-- "+" da aba SubGrupos (Value=1) e preenche as 6 colunas
    loc_oPg7.cmg_4c_BotoesSgrus.Value = 1
    loc_oForm.BtnSubGrupoClick()
    STRTOFILE(Dump7(loc_oPg7, "02-apos-+-da-aba-SubGrupos"), OUT, 1)
    IF USED("cursor_4c_SigCdPsg") AND RECCOUNT("cursor_4c_SigCdPsg") > 0
        SELECT cursor_4c_SigCdPsg
        GO TOP
        REPLACE codigos WITH "SG9601", descricaos WITH "SUB DA ABA SGRU", ;
                nfaixainis WITH 10.5, nfaixafins WITH 99.75, ;
                npars WITH 7, nminpars WITH 33.25, marckupa WITH 5.5 ;
                IN cursor_4c_SigCdPsg
    ENDIF

    *-- grava e le de volta do servidor
    loc_oForm.BtnSalvarClick()
    loc_nR = SQLEXEC(gnConnHandle, ;
        "SELECT cgrus, codigos, descricaos, cgrucods, nfaixainis, nfaixafins, " + ;
        "npars, nminpars, marckupa FROM SigCdPsg WHERE cgrus = 'Z96'", "crV")
    STRTOFILE(CHR(13)+CHR(10) + "=== 03-BANCO (SQLEXEC=" + TRANSFORM(loc_nR) + ;
        " linhas=" + IIF(USED("crV"), TRANSFORM(RECCOUNT("crV")), "?") + ")" + ;
        CHR(13)+CHR(10), OUT, 1)
    IF USED("crV") AND RECCOUNT("crV") > 0
        SCAN
            STRTOFILE("   cod=[" + crV.codigos + "] desc=[" + ALLTRIM(crV.descricaos) + ;
                "] cgrucods=[" + crV.cgrucods + "]" + CHR(13)+CHR(10) + ;
                "   fxini=" + TRANSFORM(crV.nfaixainis) + " fxfim=" + TRANSFORM(crV.nfaixafins) + ;
                " npars=" + TRANSFORM(crV.npars) + " nminpars=" + TRANSFORM(crV.nminpars) + ;
                " markup=" + TRANSFORM(crV.marckupa) + CHR(13)+CHR(10), OUT, 1)
        ENDSCAN
    ENDIF

    *-- reabre em ALTERAR: as 6 colunas tem de voltar nas DUAS grades
    loc_oForm.CarregarSigCdPsgCad("Z96")
    STRTOFILE(Dump7(loc_oPg7, "04-apos-recarga (ALTERAR)"), OUT, 1)
    IF USED("cursor_4c_SigCdPsg") AND RECCOUNT("cursor_4c_SigCdPsg") > 0
        GO TOP IN cursor_4c_SigCdPsg
        STRTOFILE("   cursor: cod=[" + cursor_4c_SigCdPsg.codigos + "] fxini=" + ;
            TRANSFORM(cursor_4c_SigCdPsg.nfaixainis) + " npars=" + ;
            TRANSFORM(cursor_4c_SigCdPsg.npars) + " nminpars=" + ;
            TRANSFORM(cursor_4c_SigCdPsg.nminpars) + CHR(13)+CHR(10), OUT, 1)
    ENDIF
    *-- a grade da aba CADASTRO tem de estar viva tambem (mesmo cursor)
    STRTOFILE("   grd_4c_PsgCad: ColumnCount=" + ;
        TRANSFORM(loc_oPgD.grd_4c_PsgCad.ColumnCount) + " RS=[" + ;
        loc_oPgD.grd_4c_PsgCad.RecordSource + "]" + CHR(13)+CHR(10), OUT, 1)

    SQLEXEC(gnConnHandle, "DELETE FROM SigCdGrp WHERE cgrus = 'Z96'")
    SQLEXEC(gnConnHandle, "DELETE FROM SigCdPsg WHERE cgrus = 'Z96'")
    STRTOFILE("   limpeza Z96 executada" + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT, 1)
ENDTRY
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT, 1)
QUIT

FUNCTION Dump7(par_oPg7, par_cTag)
    LOCAL loc_c, loc_oG, loc_oE3, loc_nI
    loc_c = CHR(13)+CHR(10) + "=== " + par_cTag + CHR(13)+CHR(10)
    TRY
        loc_c = loc_c + "  RECCOUNT cursor = " + ;
            IIF(USED("cursor_4c_SigCdPsg"), TRANSFORM(RECCOUNT("cursor_4c_SigCdPsg")), "SEM CURSOR") + ;
            CHR(13)+CHR(10)
        loc_oG = par_oPg7.grd_4c_SigCdPsg
        loc_c = loc_c + "  RecordSource=[" + loc_oG.RecordSource + "]  ColumnCount=" + ;
            TRANSFORM(loc_oG.ColumnCount) + "  Grid.ReadOnly=" + TRANSFORM(loc_oG.ReadOnly) + ;
            CHR(13)+CHR(10)
        FOR loc_nI = 1 TO loc_oG.ColumnCount
            loc_c = loc_c + "  Col" + TRANSFORM(loc_nI) + ;
                " CS=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".ControlSource") + "]" + ;
                " W=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Width")) + ;
                " Cap=[" + EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".Header1.Caption") + "]" + ;
                " RO=" + TRANSFORM(EVALUATE("loc_oG.Column" + TRANSFORM(loc_nI) + ".ReadOnly")) + ;
                CHR(13)+CHR(10)
        ENDFOR
    CATCH TO loc_oE3
        loc_c = loc_c + "  DUMP-ERRO: " + loc_oE3.Message + CHR(13)+CHR(10)
    ENDTRY
    RETURN loc_c
ENDFUNC
