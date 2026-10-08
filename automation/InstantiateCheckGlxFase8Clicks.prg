*==============================================================================
* InstantiateCheckGlxFase8Clicks.prg - exercita os botoes de navegacao da
* grade principal (TotLinha/SelEstoque/Disponivel) com dados de teste, para
* provar que o rebind de grid (RecordSource/ControlSource) nao perde
* Header1.Caption/Width/ReadOnly - e que os handlers nao estouram.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogGlxClicks
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_glxclicks.txt"
gc_4c_LogGlxClicks      = "C:\4c\automation\logs\instantiate_glxfase8_clicks.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogGlxClicks)
    DELETE FILE (gc_4c_LogGlxClicks)
ENDIF

LOCAL loc_oForm, loc_oErro

LogC("GLX FASE8 CLICKS CHECK - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrGlxBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrGlx.prg") ADDITIVE
    LogC("0 SETUP: OK")
CATCH TO loc_oErro
    LogC("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGlx")
    LogC("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogC("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    SET DATASESSION TO loc_oForm.DataSessionId

    *-- Popula TmpFinalg com 2 linhas de teste (2 linhas de producao)
    TRY
        SELECT TmpFinalg
        ZAP
        APPEND BLANK
        REPLACE Flag WITH "", CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Linhas WITH "LINHA1", Qtds WITH 1, Saldo WITH 100, Estoque WITH 0, ;
            Produzir WITH 50, Fabrs WITH 0, Produzir2 WITH 50, TotVenda WITH 10, ;
            QtdMins WITH 5, KeySelM WITH .F., KeySelMP WITH .F., UsuLibs WITH "" ;
            IN TmpFinalg
        APPEND BLANK
        REPLACE Flag WITH "", CPros WITH "PROD002", CodCors WITH "02", CodTams WITH "G", ;
            Linhas WITH "LINHA2", Qtds WITH 1, Saldo WITH 80, Estoque WITH 20, ;
            Produzir WITH 30, Fabrs WITH 10, Produzir2 WITH 20, TotVenda WITH 5, ;
            QtdMins WITH 2, KeySelM WITH .F., KeySelMP WITH .F., UsuLibs WITH "" ;
            IN TmpFinalg
        GO TOP IN TmpFinalg
        LogC("2 TmpFinalg populado: RECCOUNT=" + TRANSFORM(RECCOUNT("TmpFinalg")))
    CATCH TO loc_oErro
        LogC("2 POPULAR TmpFinalg FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- BtnTotLinhaClick
    TRY
        loc_oForm.BtnTotLinhaClick()
        LogC("3a BtnTotLinhaClick OK - RecordSource=[" + ;
            loc_oForm.pgf_4c_1.Page3.grd_4c_Linhas.RecordSource + "]" + ;
            " H1=[" + loc_oForm.pgf_4c_1.Page3.grd_4c_Linhas.Column1.Header1.Caption + "]" + ;
            " H2=[" + loc_oForm.pgf_4c_1.Page3.grd_4c_Linhas.Column2.Header1.Caption + "]" + ;
            " W1=" + TRANSFORM(loc_oForm.pgf_4c_1.Page3.grd_4c_Linhas.Column1.Width) + ;
            " C1.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page3.grd_4c_Linhas.Column1.ReadOnly) + ;
            " RECCOUNT=" + TRANSFORM(RECCOUNT("TmpLinha")))
        loc_oForm.BtnCancelaLinClick()
        LogC("3b BtnCancelaLinClick OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
    CATCH TO loc_oErro
        LogC("3 TOTLINHA FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- Popula cursor_4c_TmpSaldg (base do BtnSelEstoqueClick) com saldo do PROD001
    TRY
        GO TOP IN TmpFinalg
        SELECT cursor_4c_TmpSaldg
        ZAP
        APPEND BLANK
        REPLACE Emps WITH "001", Grupos WITH "GRP01", Estos WITH "CTA01", ;
            CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Saldo WITH 100, Disps WITH 60, Priors WITH 1, Reservs WITH 0 ;
            IN cursor_4c_TmpSaldg
        GO TOP IN cursor_4c_TmpSaldg
        LogC("4 cursor_4c_TmpSaldg populado: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_TmpSaldg")))
    CATCH TO loc_oErro
        LogC("4 POPULAR TmpSaldg FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- BtnSelEstoqueClick
    TRY
        loc_oForm.BtnSelEstoqueClick()
        LogC("5a BtnSelEstoqueClick OK - RecordSource=[" + ;
            loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.RecordSource + "]" + ;
            " H1=[" + loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.Column1.Header1.Caption + "]" + ;
            " H5=[" + loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.Header1.Caption + "]" + ;
            " W1=" + TRANSFORM(loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.Column1.Width) + ;
            " C1.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.Column1.ReadOnly) + ;
            " C5.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page4.grd_4c_DispEstoque.Column5.ReadOnly) + ;
            " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_DispEstoque")))
        loc_oForm.BtnCancelaDispPage4Click()
        LogC("5b BtnCancelaDispPage4Click OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
    CATCH TO loc_oErro
        LogC("5 SELESTOQUE FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- Popula cursor_4c_TmpSaldo (base do BtnDisponivelClick) - requer Estoque=0 e Fabrs=0
    TRY
        SELECT TmpFinalg
        LOCATE FOR CPros = "PROD001"
        SELECT cursor_4c_TmpSaldo
        ZAP
        APPEND BLANK
        REPLACE CPros WITH "PROD001", CodCors WITH "01", CodTams WITH "M", ;
            Saldo WITH 100, Disps WITH 40, Fabrs WITH 0, DispFs WITH 0 ;
            IN cursor_4c_TmpSaldo
        GO TOP IN cursor_4c_TmpSaldo
        LogC("6 cursor_4c_TmpSaldo populado: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_TmpSaldo")))
    CATCH TO loc_oErro
        LogC("6 POPULAR TmpSaldo FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- BtnDisponivelClick
    TRY
        loc_oForm.BtnDisponivelClick()
        LogC("7a BtnDisponivelClick OK - RecordSource=[" + ;
            loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.RecordSource + "]" + ;
            " H1=[" + loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.Column1.Header1.Caption + "]" + ;
            " H5=[" + loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.Header1.Caption + "]" + ;
            " W1=" + TRANSFORM(loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.Column1.Width) + ;
            " C1.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.Column1.ReadOnly) + ;
            " C5.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page5.grd_4c_DispTamanho.Column5.ReadOnly) + ;
            " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_DispTamanho")))
        loc_oForm.BtnCancelaDispPage5Click()
        LogC("7b BtnCancelaDispPage5Click OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
    CATCH TO loc_oErro
        LogC("7 DISPONIVEL FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- BtnPedrasClick (abre Page6 - Requisicao) - chamado DUAS vezes para
    *-- provar que o ColumnCount=5 reatribuido (mesmo valor) nao orfaniza o
    *-- BINDEVENT dos lookups (Column1/Column5.Text1) registrado so UMA vez
    *-- em ConfigurarPaginaRequisicao.
    TRY
        LOCAL loc_nQtdAEv
        LOCAL ARRAY loc_aEvTeste[1]

        loc_nQtdAEv = AEVENTS(loc_aEvTeste, loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Text1)
        LogC("8a0 ANTES do 1o BtnPedrasClick: AEVENTS Column1.Text1=" + TRANSFORM(loc_nQtdAEv))

        loc_oForm.BtnPedrasClick()
        LogC("8a BtnPedrasClick (1a vez) OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
        loc_oForm.BtnCancelaDispPage6Click()
        LogC("8b BtnCancelaDispPage6Click OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))

        loc_oForm.BtnPedrasClick()
        loc_nQtdAEv = AEVENTS(loc_aEvTeste, loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Text1)
        LogC("8c BtnPedrasClick (2a vez) OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage) + ;
            " AEVENTS Column1.Text1=" + TRANSFORM(loc_nQtdAEv) + ;
            IIF(loc_nQtdAEv > 0, " evento=[" + loc_aEvTeste[1, 3] + "] delegate=[" + loc_aEvTeste[1, 4] + "]", " <<< BINDEVENT PERDIDO"))

        *-- Tambem confere o Header1.Caption/ReadOnly de todas as colunas
        *-- apos o 2o rebind (mesmo defeito de reset que afetou os outros
        *-- botoes de navegacao).
        LogC("8d apos 2o click: H1=[" + loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Header1.Caption + "]" + ;
            " H2=[" + loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column2.Header1.Caption + "]" + ;
            " C1.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.ReadOnly) + ;
            " C2.RO=" + TRANSFORM(loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column2.ReadOnly) + ;
            " C1.W=" + TRANSFORM(loc_oForm.pgf_4c_1.Page6.grd_4c_Pedra.Column1.Width))

        loc_oForm.BtnCancelaDispPage6Click()
        LogC("8e BtnCancelaDispPage6Click (2a vez) OK - ActivePage=" + TRANSFORM(loc_oForm.pgf_4c_1.ActivePage))
    CATCH TO loc_oErro
        LogC("8 PEDRAS FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- BtnProcessarClick sem conexao SQL - deve falhar graciosamente (sem crash)
    TRY
        loc_oForm.BtnProcessarClick()
        LogC("9a BtnProcessarClick (sem SQL) OK - nao travou. VARTYPE pos=" + VARTYPE(loc_oForm))
    CATCH TO loc_oErro
        LogC("9 PROCESSAR FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    SET DATASESSION TO 1
    IF VARTYPE(loc_oForm) = "O"
        TRY
            loc_oForm.Release()
            LogC("10 RELEASE: OK")
        CATCH TO loc_oErro
            LogC("10 RELEASE FALHOU: " + loc_oErro.Message)
        ENDTRY
    ELSE
        LogC("10 RELEASE: form ja foi liberado (fechou sozinho)")
    ENDIF
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogC("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogC("DIALOGOS: nenhum")
ENDIF

LogC("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogC(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogGlxClicks, 1)
ENDPROC
