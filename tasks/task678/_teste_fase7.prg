*==============================================================================
* _teste_fase7.prg - Teste do gerador de senhas da Fase 7 (SigPrSndBO)
*
* Roda SEM banco: a maquina nao tem rota para 192.168.200.10. O que se mede
* aqui eh a logica NOVA que nao depende do SQL Server - o laco de geracao, a
* faixa da senha, a unicidade dentro do lote, o teto de tentativas e o aborto
* imediato quando a consulta de duplicidade falha.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task678\_teste_fase7_erros.txt"
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\FormErro.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigPrSndBO.prg" ADDITIVE

LOCAL lcRes, loBO, lcSenha, lnI, lnOk, lnFalhou, llTudoDigito, lnMin, lnMax
LOCAL lcS1, lnDistintas
lcRes    = ""
lnOk     = 0
lnFalhou = 0

loBO = CREATEOBJECT("SigPrSndBOTeste")

lcRes = lcRes + "=== TESTE FASE 7 - gerador de senhas ===" + CHR(13) + CHR(10)

*------------------------------------------------------------------------------
* T0 - escopo dos metodos novos (regra #51: o Form chama de FORA da classe)
*------------------------------------------------------------------------------
LOCAL laMet(4), lnM, lcMet, llProt, lcT0
laMet(1) = "GerarSenhasLivres"
laMet(2) = "GerarSenhaUnica"
laMet(3) = "ContarSenhasIguais"
laMet(4) = "CriarCursorSenhas"
lcT0 = ""
FOR lnM = 1 TO 4
    lcMet  = laMet(lnM)
    llProt = PEMSTATUS(loBO, lcMet, 2)
    lcT0   = lcT0 + "    " + PADR(lcMet, 22) + "existe=" + TRANSFORM(PEMSTATUS(loBO, lcMet, 5)) + ;
             "  protected=" + TRANSFORM(llProt) + CHR(13) + CHR(10)
    IF llProt
        lnFalhou = lnFalhou + 1
    ELSE
        lnOk = lnOk + 1
    ENDIF
ENDFOR
lcRes = lcRes + "T0 escopo PUBLIC dos metodos novos:" + CHR(13) + CHR(10) + lcT0

*------------------------------------------------------------------------------
* T1 - senha com 6 digitos, na faixa 100000..999999
*------------------------------------------------------------------------------
loBO.teste_nRetorno  = 0
loBO.teste_nChamadas = 0

llTudoDigito = .T.
lnMin        = 999999999
lnMax        = 0

FOR lnI = 1 TO 300
    lcSenha = loBO.GerarSenhaUnica()
    IF LEN(lcSenha) != 6
        llTudoDigito = .F.
        EXIT
    ENDIF
    IF LEN(CHRTRAN(lcSenha, "0123456789", "")) > 0
        llTudoDigito = .F.
        EXIT
    ENDIF
    lnMin = MIN(lnMin, VAL(lcSenha))
    lnMax = MAX(lnMax, VAL(lcSenha))
ENDFOR

lcRes = lcRes + "T1 300 senhas: 6 digitos sem espaco = " + TRANSFORM(llTudoDigito) + ;
        "  min=" + TRANSFORM(lnMin) + "  max=" + TRANSFORM(lnMax) + CHR(13) + CHR(10)
IF llTudoDigito AND lnMin >= 100000 AND lnMax <= 999999
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

*------------------------------------------------------------------------------
* T2 - unicidade DENTRO do lote em montagem
*------------------------------------------------------------------------------
IF USED("cursor_4c_Lote")
    USE IN cursor_4c_Lote
ENDIF
CREATE CURSOR cursor_4c_Lote (senhads C(6))

loBO.teste_nRetorno = 0
FOR lnI = 1 TO 200
    lcSenha = loBO.GerarSenhaUnica("cursor_4c_Lote")
    IF EMPTY(lcSenha)
        EXIT
    ENDIF
    INSERT INTO cursor_4c_Lote (senhads) VALUES (lcSenha)
ENDFOR

SELECT DISTINCT senhads FROM cursor_4c_Lote INTO CURSOR cursor_4c_Dist
lnDistintas = RECCOUNT("cursor_4c_Dist")

lcRes = lcRes + "T2 lote de 200: linhas=" + TRANSFORM(RECCOUNT("cursor_4c_Lote")) + ;
        "  distintas=" + TRANSFORM(lnDistintas) + CHR(13) + CHR(10)
IF RECCOUNT("cursor_4c_Lote") = 200 AND lnDistintas = 200
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

USE IN cursor_4c_Dist
USE IN cursor_4c_Lote

*------------------------------------------------------------------------------
* T3 - faixa esgotada (a senha SEMPRE existe): para no teto e avisa
*------------------------------------------------------------------------------
loBO.this_cMensagemErro = ""
loBO.teste_nRetorno     = 1
loBO.teste_nChamadas    = 0

lcSenha = loBO.GerarSenhaUnica()

lcRes = lcRes + "T3 sempre duplicada: senha=[" + lcSenha + "]  chamadas=" + ;
        TRANSFORM(loBO.teste_nChamadas) + " (teto " + ;
        TRANSFORM(loBO.this_nMaxTentativasSenha) + ")  msg=[" + ;
        ALLTRIM(loBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10)
IF EMPTY(lcSenha) AND loBO.teste_nChamadas = loBO.this_nMaxTentativasSenha ;
        AND !EMPTY(ALLTRIM(loBO.this_cMensagemErro))
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

*------------------------------------------------------------------------------
* T4 - consulta de duplicidade FALHOU (-1): aborta na 1a volta, nao gira 100x
*------------------------------------------------------------------------------
loBO.this_cMensagemErro = ""
loBO.teste_nRetorno     = -1
loBO.teste_nChamadas    = 0

lcSenha = loBO.GerarSenhaUnica()

lcRes = lcRes + "T4 consulta falhou: senha=[" + lcSenha + "]  chamadas=" + ;
        TRANSFORM(loBO.teste_nChamadas) + " (esperado 1)" + CHR(13) + CHR(10)
IF EMPTY(lcSenha) AND loBO.teste_nChamadas = 1
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

*------------------------------------------------------------------------------
* T5 - GerarSenhasLivres sem conexao: recusa, avisa e NAO deixa cursor de lote
*------------------------------------------------------------------------------
loBO.this_cMensagemErro = ""
loBO.this_lErroExibido  = .F.
loBO.teste_nRetorno     = 0

LOCAL llRet5
llRet5 = loBO.GerarSenhasLivres(3)

lcRes = lcRes + "T5 sem conexao: ret=" + TRANSFORM(llRet5) + ;
        "  erroExibido=" + TRANSFORM(loBO.this_lErroExibido) + ;
        "  cursorLote=" + TRANSFORM(USED("cursor_4c_SenhasTemp")) + ;
        "  msg=[" + ALLTRIM(loBO.this_cMensagemErro) + "]" + CHR(13) + CHR(10)
IF !llRet5 AND loBO.this_lErroExibido AND !USED("cursor_4c_SenhasTemp")
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

*------------------------------------------------------------------------------
* T6 - quantidade invalida (0 / nao numerica): recusa igual ao guard do legado
*------------------------------------------------------------------------------
LOCAL llRet6a, llRet6b
loBO.this_cMensagemErro = ""
loBO.this_lErroExibido  = .F.
llRet6a = loBO.GerarSenhasLivres(0)

loBO.this_cMensagemErro = ""
loBO.this_lErroExibido  = .F.
llRet6b = loBO.GerarSenhasLivres("abc")

lcRes = lcRes + "T6 qtde invalida: ret(0)=" + TRANSFORM(llRet6a) + ;
        "  ret('abc')=" + TRANSFORM(llRet6b) + CHR(13) + CHR(10)
IF !llRet6a AND !llRet6b
    lnOk = lnOk + 1
ELSE
    lnFalhou = lnFalhou + 1
ENDIF

*------------------------------------------------------------------------------
lcRes = lcRes + CHR(13) + CHR(10) + "RESUMO: OK=" + TRANSFORM(lnOk) + ;
        "  FALHOU=" + TRANSFORM(lnFalhou) + CHR(13) + CHR(10)

STRTOFILE(lcRes, "C:\4c\tasks\task678\_teste_fase7.out", 0)
QUIT


*==============================================================================
* Subclasse de teste: Init VAZIO (instanciar o BO de verdade sem conexao abre
* dialogo e trava o VFP headless) e ContarSenhasIguais controlada, para medir o
* laco de geracao sem banco.
*==============================================================================
DEFINE CLASS SigPrSndBOTeste AS SigPrSndBO

    teste_nRetorno  = 0
    teste_nChamadas = 0

    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrSnd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    PROCEDURE ContarSenhasIguais(par_cSenha)
        THIS.teste_nChamadas = THIS.teste_nChamadas + 1
        RETURN THIS.teste_nRetorno
    ENDPROC

ENDDEFINE
