SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnSessAnt
lcCRLF = CHR(13)+CHR(10)
lcLog  = "C:\4c\automation\test_f4_aop2_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"
STRTOFILE("=== FASE 4 FormSigPrAop - cursor na datasession do form ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gb_4c_ValidandoUI = .F.
gnConnHandle = -1
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_f4_aop2_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")
SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais,C:\4c\vbmp")
SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "SigPrAopBO.prg") ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigPrAop.prg" ADDITIVE

loForm = CREATEOBJECT("FormSigPrAop")

*-- entra na datasession PRIVADA do form para conferir o cursor
lnSessAnt = SET("Datasession")
SET DATASESSION TO loForm.DataSessionId
STRTOFILE("DataSessionId=" + TRANSFORM(loForm.DataSessionId) + ;
    "  USED(cursor_4c_DivOp)=" + TRANSFORM(USED("cursor_4c_DivOp")) + ;
    "  RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_DivOp"), RECCOUNT("cursor_4c_DivOp"), -1)) + ;
    "  FCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_DivOp"), FCOUNT("cursor_4c_DivOp"), -1)) + lcCRLF, lcLog, 1)
SET DATASESSION TO (lnSessAnt)

*-- caminho com O.P. informada e conexao INVALIDA: tem de reportar, nao travar
TRY
    STRTOFILE("CarregarDados(12345) ret=" + TRANSFORM(loForm.CarregarDados(12345)) + ;
        "  Confirmar.Enabled=" + TRANSFORM(loForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("CarregarDados(12345) EXCECAO VAZOU - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- form continua vivo depois da falha?
STRTOFILE("form vivo apos falha  = " + TRANSFORM(VARTYPE(loForm) = "O") + lcCRLF, lcLog, 1)
loForm.Release()
QUIT
