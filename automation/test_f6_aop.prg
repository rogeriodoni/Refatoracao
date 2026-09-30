SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
ON ERROR STRTOFILE("!! ERRO NAO TRATADO: " + MESSAGE() + " LN=" + TRANSFORM(LINENO()) + CHR(13)+CHR(10), "C:\4c\automation\test_f6_aop_resultado.txt", 1)
LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnSessAnt
lcCRLF = CHR(13)+CHR(10)
lcLog  = "C:\4c\automation\test_f6_aop_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"
STRTOFILE("=== FASE 6 FormSigPrAop - campos restantes + eventos do Get_OP ===" + lcCRLF, lcLog, 0)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\test_f6_aop_erros.txt"
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
STRTOFILE("[1] VARTYPE(loForm)=" + VARTYPE(loForm) + lcCRLF, lcLog, 1)

STRTOFILE("[2] txt_4c_Produto=" + TRANSFORM(PEMSTATUS(loForm, "txt_4c_Produto", 5)) + ;
    "  ReadOnly=" + TRANSFORM(loForm.txt_4c_Produto.ReadOnly) + ;
    "  edt_4c_Obss=" + TRANSFORM(PEMSTATUS(loForm, "edt_4c_Obss", 5)) + ;
    "  ObssCtrlSrc=[" + loForm.edt_4c_Obss.ControlSource + "]" + lcCRLF, lcLog, 1)

*-- [3] BINDEVENT vivo: RAISEEVENT no controle dispara o handler do form.
*--     Mede o EFEITO do binding, nao so o registro.
loForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled = .T.
TRY
    RAISEEVENT(loForm.txt_4c_OP, "GotFocus")
    STRTOFILE("[3] RAISEEVENT GotFocus -> Confirmar.Enabled=" + ;
        TRANSFORM(loForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled) + ;
        " (esperado .F. = binding vivo)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[3] RAISEEVENT GotFocus FALHOU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- [4] handlers chamaveis de FORA da classe (PROTECTED falharia aqui)
TRY
    loForm.TxtOPGotFocus()
    STRTOFILE("[4] TxtOPGotFocus OK - Confirmar.Enabled=" + ;
        TRANSFORM(loForm.cmg_4c_Grupo_Conf.Buttons(1).Enabled) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[4] TxtOPGotFocus FALHOU - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- [5] ValidarOP com campo VAZIO: esvazia a grade, sem avisar nada (ZAP no BO)
TRY
    loForm.txt_4c_OP.Value = ""
    STRTOFILE("[5] ValidarOP(vazio) ret=" + TRANSFORM(loForm.ValidarOP()) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[5] ValidarOP(vazio) EXCECAO - " + loErr.Message + ;
        " | LN " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- [6] truncagem dos 12 digitos do InputMask para os 10 de SigOpPic.Nops
TRY
    loForm.txt_4c_OP.Value = "123456789012"
    loForm.ValidarOP()
    STRTOFILE("[6] apos ValidarOP(12 digitos) txt_4c_OP.Value=[" + ;
        ALLTRIM(loForm.txt_4c_OP.Value) + "] (legado limpa no insucesso)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[6] EXCECAO - " + loErr.Message + " | LN " + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY

*-- [7] binding da grade SOBREVIVE ao esvaziamento do cursor (ZAP, nao recriar)
lnSessAnt = SET("Datasession")
SET DATASESSION TO loForm.DataSessionId
STRTOFILE("[7] USED(cursor_4c_DivOp)=" + TRANSFORM(USED("cursor_4c_DivOp")) + ;
    "  FCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_DivOp"), FCOUNT("cursor_4c_DivOp"), -1)) + ;
    "  RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_DivOp"), RECCOUNT("cursor_4c_DivOp"), -1)) + lcCRLF, lcLog, 1)
SET DATASESSION TO (lnSessAnt)
STRTOFILE("    Grid.RecordSource=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
    "  Col5.CtrlSrc=[" + loForm.grd_4c_Dados.Column5.ControlSource + "]" + ;
    "  Col5.Header=[" + loForm.grd_4c_Dados.Column5.Header1.Caption + "]" + ;
    "  Col5.Width=" + TRANSFORM(loForm.grd_4c_Dados.Column5.Width) + lcCRLF, lcLog, 1)

*-- [8] KeyPress: so age em ENTER/TAB, ignora o resto
TRY
    loForm.TxtOPKeyPress(65, 0)
    loForm.TxtOPKeyPress(13, 0)
    loForm.TxtOPKeyPress(9, 0)
    STRTOFILE("[8] TxtOPKeyPress(65/13/9) OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[8] TxtOPKeyPress FALHOU - " + loErr.Message + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- [9] LostFocus nao estoura com a grade vazia
TRY
    loForm.TxtOPLostFocus()
    STRTOFILE("[9] TxtOPLostFocus OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("[9] TxtOPLostFocus FALHOU - " + loErr.Message + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

STRTOFILE("[10] form vivo no fim=" + TRANSFORM(VARTYPE(loForm) = "O") + lcCRLF, lcLog, 1)
STRTOFILE("ERROS VFP: " + IIF(FILE(gc_4c_ArquivoErroTeste), FILETOSTR(gc_4c_ArquivoErroTeste), "(nenhum)") + lcCRLF, lcLog, 1)
STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
loForm = .NULL.
QUIT
