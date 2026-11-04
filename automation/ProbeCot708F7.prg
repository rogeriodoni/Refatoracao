*==============================================================================
* ProbeCot708F7.prg - Fase 7 do FormSigOpCot (task708): prova que os eventos
* dos TRES botoes do SCX legado estao ligados e fazem o que o legado faz.
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_708_f7_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_708_f7_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\TextBoxGridLookup.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCotBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCot.prg ADDITIVE

LOCAL lcOut, loF, loErr, lcCr, llRet, lnI, lcLinha
LOCAL ARRAY laEv[1, 5]
lcCr  = CHR(13) + CHR(10)
lcOut = ""

*-- Cursor de trabalho do form PAI (TmpCot do legado) e cabecalho (TprMvCab)
IF USED("TmpCot")
    USE IN TmpCot
ENDIF
IF USED("TprMvCab")
    USE IN TprMvCab
ENDIF
CREATE CURSOR TmpCot (cmoes C(3), valos N(12,7), avalos N(12,7))
INSERT INTO TmpCot (cmoes, valos, avalos) VALUES ("US$", 5.1234567, 0)
INSERT INTO TmpCot (cmoes, valos, avalos) VALUES ("EUR", 6.0000000, 0)
GO TOP IN TmpCot

CREATE CURSOR TprMvCab (cotusus C(10))
APPEND BLANK IN TprMvCab

*===========================================================================
* CENARIO A - instanciacao com os BINDEVENT da Fase 7
*===========================================================================
lcOut = lcOut + "=== CENARIO A: instanciacao ===" + lcCr
loF = .NULL.
TRY
    loF = CREATEOBJECT("FormSigOpCot")
CATCH TO loErr
    lcOut = lcOut + "EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
            " PROC=" + loErr.Procedure + lcCr
ENDTRY
lcOut = lcOut + "VARTYPE(form) = " + VARTYPE(loF) + lcCr

IF VARTYPE(loF) = "O"
    *-- o form PAI informa os aliases e o modo (ResolverContextoPai faria
    *-- isso lendo o proprio pai; aqui nao existe pai)
    loF.this_cCursorCotacao   = "TmpCot"
    loF.this_cCursorCabecalho = "TprMvCab"
    loF.this_oBusinessObject.this_cCursorCotacao   = "TmpCot"
    loF.this_oBusinessObject.this_cCursorCabecalho = "TprMvCab"
    loF.CarregarLista()

    *=======================================================================
    * CENARIO B - os tres handlers existem e sao PUBLIC (regras #3 e #51)
    *             PEMSTATUS(o, "X", 2) = .F. significa NAO-protegido
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO B: handlers de botao (PUBLIC) ===" + lcCr
    lcOut = lcOut + "BtnConfirmarClick existe=" + ;
        IIF(PEMSTATUS(loF, "BtnConfirmarClick", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "BtnConfirmarClick", 2)) + lcCr
    lcOut = lcOut + "BtnCancelarClick  existe=" + ;
        IIF(PEMSTATUS(loF, "BtnCancelarClick", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "BtnCancelarClick", 2)) + lcCr
    lcOut = lcOut + "BtnCotacaoClick   existe=" + ;
        IIF(PEMSTATUS(loF, "BtnCotacaoClick", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "BtnCotacaoClick", 2)) + lcCr
    lcOut = lcOut + "FecharDialogo     existe=" + ;
        IIF(PEMSTATUS(loF, "FecharDialogo", 5), "SIM", "NAO") + ;
        "  protected=" + TRANSFORM(PEMSTATUS(loF, "FecharDialogo", 2)) + lcCr

    *=======================================================================
    * CENARIO C - os BINDEVENT da Fase 7 realmente existem (AEVENTS)
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO C: BINDEVENT dos botoes (AEVENTS) ===" + lcCr
    *-- col 3 = nome do EVENTO, col 4 = nome do METODO delegate. A col 2 eh
    *-- OBJETO: concatenar com string estoura (nao usar)
    STORE 0 TO lnI
    TRY
        lnI = AEVENTS(laEv, loF.cmg_4c_Botoes.Buttons(1))
        lcOut = lcOut + "Buttons(1) -> binds=" + TRANSFORM(lnI) + ;
            IIF(lnI > 0, " evento=[" + laEv[1, 3] + "] metodo=[" + laEv[1, 4] + "]", "") + lcCr
        lnI = AEVENTS(laEv, loF.cmg_4c_Botoes.Buttons(2))
        lcOut = lcOut + "Buttons(2) -> binds=" + TRANSFORM(lnI) + ;
            IIF(lnI > 0, " evento=[" + laEv[1, 3] + "] metodo=[" + laEv[1, 4] + "]", "") + lcCr
        lnI = AEVENTS(laEv, loF.cmd_4c_BtnCotacao)
        lcOut = lcOut + "cmd_4c_BtnCotacao -> binds=" + TRANSFORM(lnI) + ;
            IIF(lnI > 0, " evento=[" + laEv[1, 3] + "] metodo=[" + laEv[1, 4] + "]", "") + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO AEVENTS: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO D - btnCotacao.When legado: so em INSERIR / ALTERAR.
    * Em PROCURAR o Click tem de devolver .F. SEM abrir o FormSigOpAlC -
    * se abrisse, o Show() MODAL travaria este script (o fato de ele
    * terminar eh a prova de que o guard pegou)
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO D: guard de modo no Click do Alterar ===" + lcCr
    loF.this_cEscolhaPai = "PROCURAR"
    loF.this_oBusinessObject.this_cEscolhaPai = "PROCURAR"
    TRY
        llRet = loF.BtnCotacaoClick()
        lcOut = lcOut + "BtnCotacaoClick() em PROCURAR = " + TRANSFORM(llRet) + ;
                " (esperado .F., sem abrir dialogo)" + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO BtnCotacaoClick/PROCURAR: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + lcCr
    ENDTRY

    lcOut = lcOut + "PodeUsarBotaoCotacao(PROCURAR) = " + ;
        TRANSFORM(loF.this_oBusinessObject.PodeUsarBotaoCotacao("PROCURAR")) + lcCr
    lcOut = lcOut + "PodeUsarBotaoCotacao(INSERIR)  = " + ;
        TRANSFORM(loF.this_oBusinessObject.PodeUsarBotaoCotacao("INSERIR")) + lcCr
    lcOut = lcOut + "PodeUsarBotaoCotacao(ALTERAR)  = " + ;
        TRANSFORM(loF.this_oBusinessObject.PodeUsarBotaoCotacao("ALTERAR")) + lcCr

    *=======================================================================
    * CENARIO E - o que o Click do Alterar faz com o retorno do dialogo
    * (o Show() modal nao roda em headless, entao o retorno eh injetado
    * exatamente na forma que o FormSigOpAlC monta:
    * "OK" + CHR(13) + cotacao + CHR(13) + usuario)
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO E: aplicacao do retorno autorizado ===" + lcCr
    GO TOP IN TmpCot
    lcOut = lcOut + "antes : valos=" + TRANSFORM(TmpCot.valos) + ;
            " avalos=" + TRANSFORM(TmpCot.avalos) + ;
            " cotusus=[" + TprMvCab.cotusus + "]" + lcCr
    TRY
        llRet = loF.this_oBusinessObject.AplicarCotacaoAutorizada( ;
                    "OK" + CHR(13) + "7.7777777" + CHR(13) + "CHEFE", ;
                    "TmpCot", "TprMvCab")
        lcOut = lcOut + "AplicarCotacaoAutorizada(OK) = " + TRANSFORM(llRet) + lcCr
        lcOut = lcOut + "depois: valos=" + TRANSFORM(TmpCot.valos) + ;
                " avalos=" + TRANSFORM(TmpCot.avalos) + ;
                " cotusus=[" + TprMvCab.cotusus + "]" + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO AplicarCotacaoAutorizada: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + lcCr
    ENDTRY

    *-- retorno CANCELADO nao muda nada e nao produz mensagem
    TRY
        llRet = loF.this_oBusinessObject.AplicarCotacaoAutorizada("CANCELADO", "TmpCot", "TprMvCab")
        lcOut = lcOut + "AplicarCotacaoAutorizada(CANCELADO) = " + TRANSFORM(llRet) + ;
                "  mensagem=[" + ALLTRIM(loF.this_oBusinessObject.this_cMensagemErro) + "]" + ;
                "  valos=" + TRANSFORM(TmpCot.valos) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO AplicarCotacaoAutorizada/CANCELADO: " + loErr.Message + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO F - btnSair.Click legado: Replace All Valos With aValos e o
    * objeto CONTINUA vivo depois de fechar (Hide, nao Release)
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO F: Cancelar desfaz e fecha com Hide ===" + lcCr
    REPLACE ALL avalos WITH 1.1111111 IN TmpCot
    REPLACE ALL valos  WITH 9.9999999 IN TmpCot
    GO TOP IN TmpCot
    lcOut = lcOut + "antes : valos=" + TRANSFORM(TmpCot.valos) + ;
            " avalos=" + TRANSFORM(TmpCot.avalos) + ;
            " SET(Decimals)=" + TRANSFORM(SET("Decimals")) + lcCr
    TRY
        llRet = loF.BtnCancelarClick()
        GO TOP IN TmpCot
        lcOut = lcOut + "BtnCancelarClick() = " + TRANSFORM(llRet) + lcCr
        lcOut = lcOut + "depois: valos=" + TRANSFORM(TmpCot.valos) + ;
                " avalos=" + TRANSFORM(TmpCot.avalos) + ;
                " SET(Decimals)=" + TRANSFORM(SET("Decimals")) + lcCr
        lcOut = lcOut + "this_lConfirmado = " + TRANSFORM(loF.this_lConfirmado) + ;
                "  VARTYPE(form) apos fechar = " + VARTYPE(loF) + ;
                " (tem de seguir O - Hide, nao Release)" + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO BtnCancelarClick: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + lcCr
    ENDTRY

    *=======================================================================
    * CENARIO G - btnConfirmar.Click legado: mantem o cursor como esta,
    * marca this_lConfirmado e fecha sem destruir o objeto
    *=======================================================================
    STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
    lcOut = lcOut + lcCr + "=== CENARIO G: Confirmar mantem e fecha com Hide ===" + lcCr
    REPLACE ALL valos WITH 3.3333333 IN TmpCot
    GO TOP IN TmpCot
    TRY
        llRet = loF.BtnConfirmarClick()
        GO TOP IN TmpCot
        lcOut = lcOut + "BtnConfirmarClick() = " + TRANSFORM(llRet) + lcCr
        lcOut = lcOut + "valos (inalterado) = " + TRANSFORM(TmpCot.valos) + lcCr
        lcOut = lcOut + "this_lConfirmado = " + TRANSFORM(loF.this_lConfirmado) + ;
                "  VARTYPE(form) = " + VARTYPE(loF) + lcCr
    CATCH TO loErr
        lcOut = lcOut + "EXCECAO BtnConfirmarClick: " + loErr.Message + ;
                " LN=" + TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + lcCr
    ENDTRY

    *-- o CHAMADOR eh quem libera (contrato do FecharDialogo)
    IF VARTYPE(loF) = "O"
        loF.Release()
    ENDIF
    lcOut = lcOut + "apos Release do chamador: VARTYPE(form) = " + VARTYPE(loF) + lcCr
ENDIF

lcOut = lcOut + lcCr + "=== dialogos suprimidos ===" + lcCr
IF FILE(gc_4c_ArquivoErroTeste)
    lcOut = lcOut + FILETOSTR(gc_4c_ArquivoErroTeste) + lcCr
ELSE
    lcOut = lcOut + "(nenhum)" + lcCr
ENDIF

STRTOFILE(lcOut, "C:\4c\automation\probe_708_f7.txt")
QUIT
