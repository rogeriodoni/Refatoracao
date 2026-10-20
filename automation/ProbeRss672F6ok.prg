*==============================================================================
* ProbeRss672F6ok.prg - task672 / Fase 6
* Prova que o TRY/CATCH acrescentado NAO alterou o caminho NORMAL:
*  (C) fila com 2 itens, todos processam -> drena a fila, nenhuma mensagem
*  (D) 1 item falha com this_lRecalculoDisponivel = .T. -> Loop (legado),
*      fila NAO drenada para ele, UMA mensagem de AVISO no fim
* O cursor eh criado DENTRO de BuscarFila (metodo chamado pelo form), para
* nascer na datasession PRIVADA do form (DataSession = 2).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_rss672ok.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oStub
loc_cOut = "C:\4c\automation\probe_rss672ok_result.txt"
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

    *-- (C) caminho feliz
    loc_oForm = CREATEOBJECT("TesteRssDS1")
    loc_oStub = CREATEOBJECT("StubOkRss")
    loc_oStub.nLinhas = 2
    loc_oForm.this_oBusinessObject = loc_oStub
    loc_oForm.this_lParametrizado  = .F.
    loc_oForm.BtnOKClick()
    STRTOFILE(CHR(13)+CHR(10)+"C_DIAG_STUB=[" + loc_oStub.cDiag + "] probeDS=" + TRANSFORM(SET("Datasession")) + " formDS=" + TRANSFORM(loc_oForm.DataSessionID), loc_cOut, 1)
    STRTOFILE(CHR(13)+CHR(10)+"C_itens_carregados=" + TRANSFORM(loc_oStub.nCarregados) + ;
              " lock=" + TRANSFORM(loc_oStub.nLock) + ;
              " processados=" + TRANSFORM(loc_oStub.nProcessados) + ;
              " excluidos=" + TRANSFORM(loc_oStub.nExcluidos) + ;
              " rollbacks=" + TRANSFORM(loc_oStub.nRollback), loc_cOut, 1)
    STRTOFILE(CHR(13)+CHR(10)+"C_OK_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
              " C_Sair_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
              " C_Cursor=" + SET("Cursor") + ;
              " C_msg_reportada=" + TRANSFORM(FILE(gc_4c_ArquivoErroTeste)), loc_cOut, 1)
    loc_oForm.Release()

    *-- (D) um item falha, recalculo DISPONIVEL -> Loop e aviso no fim
    loc_oForm = CREATEOBJECT("TesteRssDS1")
    loc_oStub = CREATEOBJECT("StubOkRss")
    loc_oStub.nLinhas       = 2
    loc_oStub.lFalhaItem    = .T.
    loc_oForm.this_oBusinessObject = loc_oStub
    loc_oForm.this_lParametrizado  = .F.
    loc_oForm.BtnOKClick()
    STRTOFILE(CHR(13)+CHR(10)+"D_processados=" + TRANSFORM(loc_oStub.nProcessados) + ;
              " excluidos=" + TRANSFORM(loc_oStub.nExcluidos) + ;
              " OK_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
              " Sair_Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)
    loc_oForm.Release()

    STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO_PROBE: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*-- Subclasse so para o teste: DataSession = 1 faz o form compartilhar a
*-- sessao do probe, para o cursor do stub ficar VISIVEL. O corpo de
*-- BtnOKClick testado eh o REAL, herdado sem override.
DEFINE CLASS TesteRssDS1 AS FormSigPrRss
    DataSession = 1
ENDDEFINE

DEFINE CLASS StubOkRss AS Custom
    this_cMensagemErro        = ""
    this_lRecalculoDisponivel = .T.
    this_lParametrizado       = .F.
    this_lOnline              = .F.
    this_cUsuario             = ""
    nLinhas      = 2
    nCarregados  = 0
    nLock        = 0
    nProcessados = 0
    nExcluidos   = 0
    nRollback    = 0
    lFalhaItem   = .F.
    cDiag        = ""

    PROCEDURE BuscarFila()
        LOCAL loc_i
        IF USED("CrSigOpCls")
            USE IN CrSigOpCls
        ENDIF
        CREATE CURSOR CrSigOpCls (CidChaves C(20), Grupos C(10), Contas C(20), Moedas C(10))
        FOR loc_i = 1 TO THIS.nLinhas
            APPEND BLANK
            REPLACE CidChaves WITH "CH" + TRANSFORM(loc_i)
        ENDFOR
        GO TOP
        THIS.cDiag = "criado USED=" + TRANSFORM(USED("CrSigOpCls")) + ;
                     " RECCOUNT=" + TRANSFORM(RECCOUNT("CrSigOpCls")) + ;
                     " DS=" + TRANSFORM(SET("Datasession"))
        RETURN .T.
    ENDPROC
    PROCEDURE CarregarDoCursor(par_c)
        THIS.nCarregados = THIS.nCarregados + 1
        RETURN .T.
    ENDPROC
    PROCEDURE MarcarEmProcessamento()
        THIS.nLock = THIS.nLock + 1
        RETURN 1
    ENDPROC
    PROCEDURE ProcessarItem()
        THIS.nProcessados = THIS.nProcessados + 1
        IF THIS.lFalhaItem
            THIS.this_cMensagemErro = "falha simulada no item"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC
    PROCEDURE VerificarMovimento()
        RETURN .F.
    ENDPROC
    PROCEDURE Excluir()
        THIS.nExcluidos = THIS.nExcluidos + 1
        RETURN .T.
    ENDPROC
    PROCEDURE DesfazerTransacao()
        THIS.nRollback = THIS.nRollback + 1
        RETURN .T.
    ENDPROC
    PROCEDURE GravarLog(par_c)
        RETURN .T.
    ENDPROC
ENDDEFINE
