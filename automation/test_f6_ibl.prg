SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
ON ERROR STRTOFILE("!! ERRO NAO TRATADO: " + MESSAGE() + " LN=" + TRANSFORM(LINENO()) + CHR(13)+CHR(10), "C:\4c\automation\test_f6_ibl_resultado.txt", 1)
LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnI, lcBind
lcCRLF = CHR(13)+CHR(10)
lcLog  = "C:\4c\automation\test_f6_ibl_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"
STRTOFILE("=== FASE 6 FormSIGPRIBL - lookup getFPags ===" + lcCRLF, lcLog, 0)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_f6_ibl_erros.txt"
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
SET PROCEDURE TO (lcCls + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (lcCls + "SIGPRIBLBO.prg") ADDITIVE
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGPRIBL.prg" ADDITIVE

loForm = CREATEOBJECT("FormSIGPRIBL")
STRTOFILE("[1] VARTYPE(loForm)=" + VARTYPE(loForm) + lcCRLF, lcLog, 1)

*-- [2] campos de dados do legado todos presentes
STRTOFILE("[2] txt_4c_FPags=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_FPags", 5)) + ;
    " MaxLength=" + TRANSFORM(loForm.txt_4c_FPags.MaxLength) + ;
    " | txt_4c_Locals=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_Locals", 5)) + ;
    " | obj_4c_GetTxtCds=" + TRANSFORM(PEMSTATUS(loForm, "obj_4c_GetTxtCds", 5)) + ;
    " | lbl_4c_LblAviso.Visible=" + TRANSFORM(loForm.lbl_4c_LblAviso.Visible) + lcCRLF, lcLog, 1)

*-- [3] metodos do lookup existem E sao PUBLIC (chamaveis de fora da classe)
STRTOFILE("[3] AbrirLookupFPags=" + TRANSFORM(PEMSTATUS(loForm, "AbrirLookupFPags", 5)) + ;
    " TxtFPagsKeyPress=" + TRANSFORM(PEMSTATUS(loForm, "TxtFPagsKeyPress", 5)) + ;
    " TxtFPagsDblClick=" + TRANSFORM(PEMSTATUS(loForm, "TxtFPagsDblClick", 5)) + ;
    " this_lLookupAberto=" + TRANSFORM(PEMSTATUS(loForm, "this_lLookupAberto", 5)) + lcCRLF, lcLog, 1)

*-- [4] BINDEVENT registrados no campo de lookup (AEVENTS: evento na col 3)
lcBind = ""
LOCAL ARRAY laEv[1,1]
IF AEVENTS(laEv, 0) > 0
    FOR lnI = 1 TO ALEN(laEv, 1)
        IF UPPER(laEv[lnI, 2]) == "TXT_4C_FPAGS"
            lcBind = lcBind + ALLTRIM(laEv[lnI, 3]) + "->" + ALLTRIM(laEv[lnI, 4]) + " "
        ENDIF
    ENDFOR
ENDIF
STRTOFILE("[4] bindings de txt_4c_FPags: " + lcBind + lcCRLF, lcLog, 1)

*-- [5] guarda de reentrancia: com a flag LIGADA o metodo sai na hora, sem
*--     abrir picker nenhum e sem tocar no campo
loForm.txt_4c_FPags.Value = "SENTINELA"
loForm.this_lLookupAberto = .T.
TRY
    loForm.AbrirLookupFPags()
    STRTOFILE("[5] guarda ON: Value=[" + ALLTRIM(loForm.txt_4c_FPags.Value) + ;
        "] (esperado SENTINELA) flag=" + TRANSFORM(loForm.this_lLookupAberto) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[5] FALHOU - " + loErr.Message + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- [6] guarda DESLIGADA + conexao invalida: tem de CAIR NO CATCH sem abrir
*--     modal (se abrisse Show() o script travaria) e tem de LIBERAR a flag
loForm.this_lLookupAberto = .F.
TRY
    loForm.AbrirLookupFPags()
    STRTOFILE("[6] sem conexao: retornou. flag liberada=" + ;
        TRANSFORM(!loForm.this_lLookupAberto) + " (esperado .T.)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[6] EXCECAO VAZOU - " + loErr.Message + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- [7] DblClick chamavel de fora (PROTECTED falharia aqui)
loForm.this_lLookupAberto = .T.
TRY
    loForm.TxtFPagsDblClick()
    STRTOFILE("[7] TxtFPagsDblClick OK (guarda ON, sem modal)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[7] TxtFPagsDblClick FALHOU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
loForm.this_lLookupAberto = .F.

*-- [8] KeyPress: ignora tecla que nao eh Enter/Tab/F4; campo vazio zera a tela
TRY
    loForm.txt_4c_FPags.Value = ""
    loForm.TxtFPagsKeyPress(65, 0)
    loForm.TxtFPagsKeyPress(13, 0)
    loForm.TxtFPagsKeyPress(9, 0)
    loForm.TxtFPagsKeyPress(115, 0)
    STRTOFILE("[8] TxtFPagsKeyPress(65/13/9/115) OK | Locals.Enabled=" + ;
        TRANSFORM(loForm.txt_4c_Locals.Enabled) + " Imprimir.Enabled=" + ;
        TRANSFORM(loForm.obj_4c_CmdGImprimir.Buttons(1).Enabled) + ;
        " Aviso.Visible=" + TRANSFORM(loForm.lbl_4c_LblAviso.Visible) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[8] TxtFPagsKeyPress FALHOU - " + loErr.Message + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- [9] RAISEEVENT no controle dispara o handler ligado por BINDEVENT
loForm.this_lLookupAberto = .T.
TRY
    RAISEEVENT(loForm.txt_4c_FPags, "DblClick")
    STRTOFILE("[9] RAISEEVENT DblClick OK (binding vivo, guarda conteve)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[9] RAISEEVENT DblClick FALHOU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
loForm.this_lLookupAberto = .F.

STRTOFILE("[10] form vivo no fim=" + TRANSFORM(VARTYPE(loForm) = "O") + lcCRLF, lcLog, 1)
STRTOFILE("ERROS VFP: " + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "(nenhum)") + lcCRLF, lcLog, 1)
STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
loForm = .NULL.
QUIT
