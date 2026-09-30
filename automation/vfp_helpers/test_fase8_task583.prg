*-- Fase 8 / task583: instanciacao OFFLINE do FormSigPrAop.
*-- A maquina do pipeline nao alcanca 192.168.200.10 (erro 1526), e o
*-- TestFormWrapper aborta na ETAPA 1B antes de instanciar qualquer coisa.
*-- Este harness pula a conexao (gnConnHandle = -1) e exercita a superficie
*-- que a Fase 8 entrega: Init completo + os handlers auxiliares.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\fase8_aop_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_lCD, loc_nRec, loc_nSessaoAnt
LOCAL ARRAY loc_aCampos[1]
loc_cOut = ""

CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
loc_cOut = loc_cOut + "CONFIG=OK" + CHR(13) + CHR(10)

*-- Sem banco: o BO.Init guarda todo SQLEXEC atras de gnConnHandle > 0
gnConnHandle = -1

TRY
    loc_oForm = CREATEOBJECT("FormSigPrAop")
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "CREATE_EXCEPTION=[" + loc_oErro.Message + ;
               " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
               " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

IF VARTYPE(loc_oForm) = "O"
    loc_cOut = loc_cOut + "CLASSE="    + loc_oForm.Class + CHR(13) + CHR(10) + ;
               "BASECLASS=" + loc_oForm.BaseClass + CHR(13) + CHR(10) + ;
               "CAPTION=["  + loc_oForm.Caption + "]" + CHR(13) + CHR(10) + ;
               "WIDTHxHEIGHT=" + TRANSFORM(loc_oForm.Width) + "x" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

    *-- ETAPA 3 do TestFormWrapper: exibir nao-modal. Reproduzida aqui porque o
    *-- wrapper real aborta na ETAPA 1B (a maquina do pipeline nao alcanca o SQL
    *-- Server - erro 1526), e eh o Show() que prova ShowWindow/WindowType.
    TRY
        loc_oForm.WindowType = 0
        loc_oForm.Show()
        DOEVENTS
        loc_cOut = loc_cOut + "SHOW=OK VISIBLE=" + TRANSFORM(loc_oForm.Visible) + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "SHOW=ERRO [" + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
    ENDTRY

    *-- Objetos que a tela precisa ter (equivalentes do SCX legado)
    loc_cOut = loc_cOut + "OBJ_CABECALHO=" + IIF(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
               "OBJ_GRID="      + IIF(PEMSTATUS(loc_oForm, "grd_4c_Dados", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
               "OBJ_BOTOES="    + IIF(PEMSTATUS(loc_oForm, "cmg_4c_Grupo_Conf", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
               "OBJ_TXTOP="     + IIF(PEMSTATUS(loc_oForm, "txt_4c_OP", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
               "OBJ_TXTPROD="   + IIF(PEMSTATUS(loc_oForm, "txt_4c_Produto", 5), "SIM", "NAO") + CHR(13) + CHR(10) + ;
               "OBJ_EDTOBSS="   + IIF(PEMSTATUS(loc_oForm, "edt_4c_Obss", 5), "SIM", "NAO") + CHR(13) + CHR(10)

    IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
        loc_cOut = loc_cOut + "GRID_COLCOUNT=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10) + ;
                   "GRID_RECSOURCE=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10) + ;
                   "GRID_HEADERS=[" + ;
                   ALLTRIM(loc_oForm.grd_4c_Dados.Column1.Header1.Caption) + "|" + ;
                   ALLTRIM(loc_oForm.grd_4c_Dados.Column2.Header1.Caption) + "|" + ;
                   ALLTRIM(loc_oForm.grd_4c_Dados.Column3.Header1.Caption) + "|" + ;
                   ALLTRIM(loc_oForm.grd_4c_Dados.Column4.Header1.Caption) + "|" + ;
                   ALLTRIM(loc_oForm.grd_4c_Dados.Column5.Header1.Caption) + "]" + CHR(13) + CHR(10) + ;
                   "GRID_WIDTHS=[" + ;
                   TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + "|" + ;
                   TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + "|" + ;
                   TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Width) + "|" + ;
                   TRANSFORM(loc_oForm.grd_4c_Dados.Column4.Width) + "|" + ;
                   TRANSFORM(loc_oForm.grd_4c_Dados.Column5.Width) + "]" + CHR(13) + CHR(10) + ;
                   "GRID_SOMENTE_COL5_EDITAVEL=" + ;
                   IIF(loc_oForm.grd_4c_Dados.Column1.ReadOnly AND loc_oForm.grd_4c_Dados.Column2.ReadOnly ;
                       AND loc_oForm.grd_4c_Dados.Column3.ReadOnly AND loc_oForm.grd_4c_Dados.Column4.ReadOnly ;
                       AND !loc_oForm.grd_4c_Dados.Column5.ReadOnly, "SIM", "NAO") + CHR(13) + CHR(10)
    ENDIF

    *-- O form eh DataSession = 2: o cursor vive na datasession PRIVADA dele, e
    *-- USED()/RECCOUNT() na sessao do harness devolvem "nao existe" - isso eh
    *-- escopo do harness, NAO defeito do form. Entrar na datasession do form.
    loc_nSessaoAnt = SET("DATASESSION")
    SET DATASESSION TO loc_oForm.DataSessionId
    loc_cOut = loc_cOut + "CURSOR_DIVOP=" + IIF(USED("cursor_4c_DivOp"), "SIM", "NAO") + CHR(13) + CHR(10)
    IF USED("cursor_4c_DivOp")
        SELECT cursor_4c_DivOp
        loc_cOut = loc_cOut + "CURSOR_DIVOP_NCAMPOS=" + TRANSFORM(AFIELDS(loc_aCampos)) + CHR(13) + CHR(10)
    ENDIF
    SET DATASESSION TO (loc_nSessaoAnt)

    *-- Handlers auxiliares consolidados na Fase 8 (chamados de FORA da classe,
    *-- igual ao harness do pipeline - metodo PROTECTED falharia aqui)
    TRY
        loc_oForm.TxtOPGotFocus()
        loc_cOut = loc_cOut + "TXTOPGOTFOCUS=OK BTNCONF_ENABLED=" + ;
                   TRANSFORM(loc_oForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled) + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "TXTOPGOTFOCUS=ERRO [" + loc_oErro.Message + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_oForm.TxtOPKeyPress(65, 0)
        loc_cOut = loc_cOut + "TXTOPKEYPRESS_LETRA=OK (ignorado, nao dispara consulta)" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "TXTOPKEYPRESS_LETRA=ERRO [" + loc_oErro.Message + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_lCD        = loc_oForm.CarregarDados(0)
        loc_nSessaoAnt = SET("DATASESSION")
        SET DATASESSION TO loc_oForm.DataSessionId
        loc_nRec = IIF(USED("cursor_4c_DivOp"), RECCOUNT("cursor_4c_DivOp"), -1)
        SET DATASESSION TO (loc_nSessaoAnt)
        loc_cOut = loc_cOut + "CARREGARDADOS_0=" + TRANSFORM(loc_lCD) + ;
                   " RECCOUNT=" + TRANSFORM(loc_nRec) + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "CARREGARDADOS_0=ERRO [" + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_oForm.ValidarOP()
        loc_cOut = loc_cOut + "VALIDAROP_VAZIO=OK" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "VALIDAROP_VAZIO=ERRO [" + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_oForm.GridAfterRowColChange(1)
        loc_cOut = loc_cOut + "GRIDAFTERROWCOLCHANGE=OK" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "GRIDAFTERROWCOLCHANGE=ERRO [" + loc_oErro.Message + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_oForm.PularParaGradeAposOP()
        loc_cOut = loc_cOut + "PULARPARAGRADE=OK" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "PULARPARAGRADE=ERRO [" + loc_oErro.Message + "]" + CHR(13) + CHR(10)
    ENDTRY

    *-- BtnConfirmarClick sem O.P. informada: o BO recusa e reporta sozinho
    TRY
        loc_oForm.BtnConfirmarClick()
        loc_cOut = loc_cOut + "BTNCONFIRMAR_SEM_OP=OK (recusado pelo BO) MSG=[" + ;
                   ALLTRIM(loc_oForm.this_oBusinessObject.this_cMensagemErro) + "]" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "BTNCONFIRMAR_SEM_OP=ERRO [" + loc_oErro.Message + ;
                   " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + "]" + CHR(13) + CHR(10)
    ENDTRY

    TRY
        loc_oForm.BtnEncerrarClick()
        loc_cOut = loc_cOut + "BTNENCERRAR=OK" + CHR(13) + CHR(10)
    CATCH TO loc_oErro
        loc_cOut = loc_cOut + "BTNENCERRAR=ERRO [" + loc_oErro.Message + "]" + CHR(13) + CHR(10)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cOut = loc_cOut + "ARQUIVO_ERRO_TESTE=[" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]" + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "ARQUIVO_ERRO_TESTE=(vazio)" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cOut, "C:\4c\automation\fase8_aop_teste.txt")
QUIT
