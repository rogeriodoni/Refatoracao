SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL lcLog, lcBase, loForm, loErr, lnI, lnJ
lcBase = "C:\4c\projeto\app\"
lcLog  = "C:\4c\automation\_tmp746\probe_aevents.txt"
STRTOFILE("=== AEVENTS ===" + CHR(13) + CHR(10), lcLog)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_CaminhoReports
PUBLIC gc_4c_UsuarioLogado, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_tmp746\probe_aevents_err.txt"

PUBLIC go_4c_Sistema
go_4c_Sistema = CREATEOBJECT("Custom")
go_4c_Sistema.AddProperty("cCodEmpresa", "001")
go_4c_Sistema.AddProperty("cEmpresa", "TESTE")
go_4c_Sistema.AddProperty("cCNPJ", "")

SET PATH TO (lcBase + "utils," + lcBase + "classes," + lcBase + "forms\operacionais," + lcBase + "start")
SET PROCEDURE TO (lcBase + "utils\functions.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\messages.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "utils\validators.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\dataaccess.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\formbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\gridbase.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "classes\SigOpIboBO.prg") ADDITIVE
SET PROCEDURE TO (lcBase + "forms\operacionais\FormSigOpIbo.prg") ADDITIVE

loForm = CREATEOBJECT("FormSigOpIbo", .NULL., 2, "", "001", "MALOTE", 7, 0, 1, 2, "crTeste")
STRTOFILE("form=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)

PRIVATE laEv
DIMENSION laEv(1, 5)
STRTOFILE("antes do AEVENTS" + CHR(13) + CHR(10), lcLog, 1)
lnI = AEVENTS(laEv, loForm.txt_4c_Qtde)
STRTOFILE("AEVENTS txt_4c_Qtde = " + TRANSFORM(lnI) + CHR(13) + CHR(10), lcLog, 1)
IF lnI > 0
    FOR lnJ = 1 TO lnI
        STRTOFILE("   [" + TRANSFORM(laEv(lnJ, 3)) + "] -> [" + TRANSFORM(laEv(lnJ, 4)) + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDFOR
ENDIF

lnI = AEVENTS(laEv, loForm.obj_4c_BtnReport.Buttons(1))
STRTOFILE("AEVENTS Buttons(1) = " + TRANSFORM(lnI) + CHR(13) + CHR(10), lcLog, 1)
IF lnI > 0
    FOR lnJ = 1 TO lnI
        STRTOFILE("   [" + TRANSFORM(laEv(lnJ, 3)) + "] -> [" + TRANSFORM(laEv(lnJ, 4)) + "]" + CHR(13) + CHR(10), lcLog, 1)
    ENDFOR
ENDIF

STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
loForm.Release()
QUIT
