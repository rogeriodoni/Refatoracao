*==============================================================================
* ProbeRss672F6.prg - task672 / Fase 6
* (A) Instancia FormSigPrRss headless (prova que a tela abre)
* (B) Forca excecao REALISTA dentro do loop de BtnOKClick (BO devolve .T. sem
*     criar CrSigOpCls) e MEDE o estado em que a tela fica: Enabled dos dois
*     botoes + SET("Cursor"). Com TitleBar=0 e ControlBox=.F. o botao Encerrar
*     eh a UNICA saida da janela.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_rss672.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oStub
loc_cOut = "C:\4c\automation\probe_rss672_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrRssBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrRss.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (A) a tela abre?
    loc_oForm = CREATEOBJECT("FormSigPrRss")
    STRTOFILE(CHR(13)+CHR(10)+"A_CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        STRTOFILE(CHR(13)+CHR(10)+"A_Caption=[" + loc_oForm.Caption + "]" + ;
                  " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
                  " TitleBar=" + TRANSFORM(loc_oForm.TitleBar) + ;
                  " ControlBox=" + TRANSFORM(loc_oForm.ControlBox), loc_cOut, 1)
        STRTOFILE(CHR(13)+CHR(10)+"A_OK_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
                  " A_Sair_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
                  " A_SET_Cursor=" + SET("Cursor"), loc_cOut, 1)

        *-- (B) BO stub: BuscarFila devolve .T. e NAO cria CrSigOpCls.
        *--     Reproduz o caminho em que a consulta "deu certo" mas o alias
        *--     nao esta aberto -> SELECT CrSigOpCls estoura dentro do loop.
        loc_oStub = CREATEOBJECT("StubBoRss")
        loc_oForm.this_oBusinessObject = loc_oStub
        loc_oForm.this_lParametrizado  = .F.

        TRY
            loc_oForm.BtnOKClick()
            STRTOFILE(CHR(13)+CHR(10)+"B_BtnOKClick=RETORNOU_SEM_EXCECAO", loc_cOut, 1)
        CATCH TO loc_oErro
            STRTOFILE(CHR(13)+CHR(10)+"B_EXCECAO_ESCAPOU=" + TRANSFORM(loc_oErro.ErrorNo) + ;
                      " [" + loc_oErro.Message + "] PROC=" + loc_oErro.Procedure + ;
                      " LN=" + TRANSFORM(loc_oErro.LineNo), loc_cOut, 1)
        ENDTRY

        *-- ESTADO EM QUE A TELA FICOU
        STRTOFILE(CHR(13)+CHR(10)+"B_OK_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
                  " B_Sair_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
                  " B_SET_Cursor=" + SET("Cursor") + ;
                  " B_Label=[" + loc_oForm.lbl_4c_Label1.Caption + "]", loc_cOut, 1)

        SET CURSOR ON
        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO_PROBE: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*-- BO stub minimo: so o que BtnOKClick toca antes do ponto de falha
DEFINE CLASS StubBoRss AS Custom
    this_cMensagemErro         = ""
    this_lRecalculoDisponivel  = .T.
    this_lParametrizado        = .F.
    this_lOnline               = .F.
    this_cUsuario              = ""
    PROCEDURE BuscarFila()
        *-- "deu certo" mas o alias CrSigOpCls nao esta aberto
        IF USED("CrSigOpCls")
            USE IN CrSigOpCls
        ENDIF
        RETURN .T.
    ENDPROC
    PROCEDURE DesfazerTransacao()
        RETURN .T.
    ENDPROC
    PROCEDURE GravarLog(par_c)
        RETURN .T.
    ENDPROC
ENDDEFINE
