*==============================================================================
* test_fase8_sigmvvde.prg - Harness da Fase 8 do FormSigMvVde
* Prova, INSTANCIANDO de verdade: o form abre; o botao de acao existe com o
* nome novo; o BINDEVENT chega em BtnConfirmarClick (disparando o .Click do
* proprio botao, nao chamando o handler na mao); os 33 campos existem; a ponte
* Form->BO leva os valores da TELA para as properties do BO; e o caminho
* FAIL-CLOSED do SigOpSen ausente NAO libera vendedor nenhum.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loBO, loErr, lcCls, lcUtl, lcCRLF, i, lnFaltando
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\fase8_sigmvvde_teste.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 8 FormSigMvVde ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado, go_4c_Sistema
PUBLIC gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\fase8_sigmvvde_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SigMvVdeBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigMvVde.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE        : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE        : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigMvVde")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT         : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT         : FALHOU (VARTYPE=" + VARTYPE(loForm) + ")" + lcCRLF, lcLog, 1)
    STRTOFILE("RESULTADO            : FALHA" + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT         : OK (form instanciado)" + lcCRLF, lcLog, 1)

*-- 1) Botao de acao com o NOME NOVO
STRTOFILE("cmd_4c_Confirmar     : " + ;
    IIF(PEMSTATUS(loForm, "cmd_4c_Confirmar", 5), "EXISTE", "AUSENTE") + lcCRLF, lcLog, 1)
STRTOFILE("cmd_4c_BtnSair(velho): " + ;
    IIF(PEMSTATUS(loForm, "cmd_4c_BtnSair", 5), "AINDA EXISTE (ERRO)", "removido OK") + lcCRLF, lcLog, 1)
STRTOFILE("BtnConfirmarClick    : " + ;
    IIF(PEMSTATUS(loForm, "BtnConfirmarClick", 5), "EXISTE", "AUSENTE") + lcCRLF, lcLog, 1)
STRTOFILE("Caption do botao     : [" + loForm.cmd_4c_Confirmar.Caption + "]" + lcCRLF, lcLog, 1)
STRTOFILE("Picture existe       : " + ;
    IIF(FILE(loForm.cmd_4c_Confirmar.Picture), "SIM", "NAO -> " + loForm.cmd_4c_Confirmar.Picture) + lcCRLF, lcLog, 1)
STRTOFILE("botao Left+Width     : " + TRANSFORM(loForm.cmd_4c_Confirmar.Left + loForm.cmd_4c_Confirmar.Width) + ;
    " vs Form.Width=" + TRANSFORM(loForm.Width) + lcCRLF, lcLog, 1)

*-- 2) Os 33 campos existem
lnFaltando = 0
FOR i = 0 TO 10
    IF !PEMSTATUS(loForm, "txt_4c_Conta" + TRANSFORM(i), 5)
        lnFaltando = lnFaltando + 1
    ENDIF
    IF !PEMSTATUS(loForm, "txt_4c_DConta" + TRANSFORM(i), 5)
        lnFaltando = lnFaltando + 1
    ENDIF
    IF !PEMSTATUS(loForm, "txt_4c_Grupo" + TRANSFORM(i), 5)
        lnFaltando = lnFaltando + 1
    ENDIF
ENDFOR
STRTOFILE("33 campos de tela    : " + TRANSFORM(33 - lnFaltando) + "/33 presentes" + lcCRLF, lcLog, 1)

*-- 3) Referencia ao BO ANTES do Click (o handler faz THIS.Release() no fim)
loBO = loForm.this_oBusinessObject
STRTOFILE("ref ao BO            : " + IIF(VARTYPE(loBO) = "O", "OK", "FALHOU") + lcCRLF, lcLog, 1)

*-- 4) PONTE DE DADOS + BINDEVENT + FAIL-CLOSED, tudo num disparo:
*--    preenche a TELA, dispara o .Click do PROPRIO BOTAO (so chega em
*--    BtnConfirmarClick se o BINDEVENT estiver correto) e confere depois.
loForm.txt_4c_Conta0.Value  = "1001"
loForm.txt_4c_DConta0.Value = "VENDEDOR TESTE A"
loForm.txt_4c_Grupo0.Value  = "GRP1"
loForm.txt_4c_Conta3.Value  = "1004"

go_4c_Vendedor.Vendedor00 = ""
go_4c_Vendedor.Vendedor03 = ""

TRY
    loForm.cmd_4c_Confirmar.Click()
    STRTOFILE("Click do botao       : executou SEM excecao vazada" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("Click do botao       : EXCECAO VAZOU - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- FormParaBO rodou? (properties do BO alimentadas pela TELA = BINDEVENT ok)
STRTOFILE("BO.this_cConta0      : [" + TRANSFORM(loBO.this_cConta0) + "]" + ;
    IIF(ALLTRIM(loBO.this_cConta0) == "1001", " <- FormParaBO OK", " <- NAO copiou!") + lcCRLF, lcLog, 1)
STRTOFILE("BO.this_cDConta0     : [" + TRANSFORM(loBO.this_cDConta0) + "]" + lcCRLF, lcLog, 1)
STRTOFILE("BO.this_cGrupo0      : [" + TRANSFORM(loBO.this_cGrupo0) + "]" + lcCRLF, lcLog, 1)
STRTOFILE("BO.this_cConta3      : [" + TRANSFORM(loBO.this_cConta3) + "]" + lcCRLF, lcLog, 1)
STRTOFILE("BO.this_lConfirmado  : " + TRANSFORM(loBO.this_lConfirmado) + ;
    IIF(loBO.this_lConfirmado, " <- LIBEROU SEM SENHA (ERRO)", " <- fail-closed OK") + lcCRLF, lcLog, 1)

*-- FAIL-CLOSED: sem autorizacao, Vendedor00 = sentinela e Vendedor03 vazio
STRTOFILE("go_4c_Vendedor00     : " + ;
    IIF(go_4c_Vendedor.Vendedor00 == REPLICATE(CHR(254), 10), ;
        "SENTINELA (fail-closed CORRETO)", ;
        "[" + TRANSFORM(go_4c_Vendedor.Vendedor00) + "] <- NAO deveria liberar!") + lcCRLF, lcLog, 1)
STRTOFILE("go_4c_Vendedor03     : [" + TRANSFORM(go_4c_Vendedor.Vendedor03) + "]" + ;
    IIF(EMPTY(go_4c_Vendedor.Vendedor03), " (vazio, correto)", " <- vazou!") + lcCRLF, lcLog, 1)

*-- 5) Mensagens/erros capturados pelo modo teste
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("--- MSGS do modo teste ---" + lcCRLF + FILETOSTR(gc_4c_ArquivoErroTeste) + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("--- MSGS do modo teste ---: (arquivo nao criado)" + lcCRLF, lcLog, 1)
ENDIF

STRTOFILE("RESULTADO            : FIM" + lcCRLF, lcLog, 1)
QUIT
