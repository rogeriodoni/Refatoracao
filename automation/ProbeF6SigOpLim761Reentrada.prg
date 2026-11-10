SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

lcLog = "C:\4c\automation\ProbeF6SigOpLim761Reentrada.log"
STRTOFILE("", lcLog)
#DEFINE L CHR(13) + CHR(10)

*-- compila primeiro, com o .fxp apagado
lcPrg = "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg"
lcErr = "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.err"
lcFxp = "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.fxp"
IF FILE(lcFxp)
    ERASE (lcFxp)
ENDIF
IF FILE(lcErr)
    ERASE (lcErr)
ENDIF
COMPILE (lcPrg)
STRTOFILE("COMPILE: FXP=" + IIF(FILE(lcFxp), "SIM", "NAO") + ;
    "  ERR=" + IIF(FILE(lcErr), "SIM", "NAO") + L, lcLog, 1)
IF FILE(lcErr)
    STRTOFILE(FILETOSTR(lcErr) + L, lcLog, 1)
ENDIF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_ArquivoErroTeste, gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_CaminhoBase

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoBase      = "C:\4c\projeto\app\start"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeF6SigOpLim761Reentrada_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"
STRTOFILE("", gc_4c_ArquivoErroTeste)
go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")

SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg"  ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\utils\validators.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg"   ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\gridbase.prg"     ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\formbuscaauxiliar.prg" ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpLimBO.prg"   ADDITIVE
SET PROCEDURE TO (lcPrg) ADDITIVE

STRTOFILE(L + "=== reentrada: AplicarRegrasDeExibicao zera o estado de saida ===" + L, lcLog, 1)
loF = CREATEOBJECT("FormSigOpLim", 2, 300, 5, "D", .T.)
IF VARTYPE(loF) = "O"
    STRTOFILE("1a rodada: Encerrando=" + TRANSFORM(loF.this_lEncerrando) + ;
        "  ZSenha=" + TRANSFORM(loF.ObterResultado()) + L, lcLog, 1)

    loF.this_oBusinessObject.this_cZSenha = "AUTORIZOU1"
    loF.FecharDialogo(.T.)
    STRTOFILE("apos fechar: Encerrando=" + TRANSFORM(loF.this_lEncerrando) + ;
        "  ZSenha=[" + TRANSFORM(loF.ObterResultado()) + "]" + L, lcLog, 1)

    *-- reabre pelo funil documentado
    loF.AplicarRegrasDeExibicao()
    STRTOFILE("reaberto  : Encerrando=" + TRANSFORM(loF.this_lEncerrando) + ;
        "  ZSenha=" + TRANSFORM(loF.ObterResultado()) + ;
        "  (esp .F. / .F.)" + L, lcLog, 1)
    STRTOFILE("flags lookup: " + TRANSFORM(loF.this_lEmLookupUsuario) + "/" + ;
        TRANSFORM(loF.this_lEmLookupMotivo) + "/" + TRANSFORM(loF.this_lEmValidarSenha) + ;
        "  (esp .F./.F./.F.)" + L, lcLog, 1)
    STRTOFILE("Caption/Frase ainda certos: [" + loF.Caption + "] [" + ;
        loF.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
    loF.Release()
ELSE
    STRTOFILE("FALHOU: " + VARTYPE(loF) + L, lcLog, 1)
ENDIF

STRTOFILE(L + "dialogos: [" + FILETOSTR(gc_4c_ArquivoErroTeste) + "]" + L, lcLog, 1)
STRTOFILE("FIM" + L, lcLog, 1)
QUIT
