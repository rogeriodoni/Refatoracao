*==============================================================================
* test_fase4_sigmvmvt.prg - Harness da Fase 4 do FormSIGMVMVT
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL e trava em
* execucao desatendida). Carrega so as dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\vfp_helpers\test_fase4_sigmvmvt_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 4 FormSIGMVMVT ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework, gc_4c_UsuarioLogado, go_4c_Sistema
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

*-- 1) Compilacao
TRY
    COMPILE (lcCls + "SIGMVMVTBO.prg")
    COMPILE "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg"
    STRTOFILE("COMPILE           : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("COMPILE           : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 2) Dependencias
TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVMVTBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 3) Instanciacao real - prova que o Init inteiro roda (sem drill direto)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVMVT")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) = "O"
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)

    STRTOFILE("--- CONTROLES FASE 4 ---" + lcCRLF, lcLog, 1)

    STRTOFILE("shp_4c_Shape1        : " + TRANSFORM(PEMSTATUS(loForm, "shp_4c_Shape1", 5)) + ;
        " | Visible=" + TRANSFORM(loForm.shp_4c_Shape1.Visible) + ;
        " | Left=" + TRANSFORM(loForm.shp_4c_Shape1.Left) + lcCRLF, lcLog, 1)

    STRTOFILE("cmd_4c_BtnOperacao   : " + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_BtnOperacao", 5)) + ;
        " | Caption=[" + ALLTRIM(loForm.cmd_4c_BtnOperacao.Caption) + "]" + ;
        " | Visible=" + TRANSFORM(loForm.cmd_4c_BtnOperacao.Visible) + ;
        " | picExiste=" + TRANSFORM(FILE(loForm.cmd_4c_BtnOperacao.Picture)) + lcCRLF, lcLog, 1)

    STRTOFILE("cmd_4c_BtnOficina    : " + TRANSFORM(PEMSTATUS(loForm, "cmd_4c_BtnOficina", 5)) + ;
        " | Caption=[" + ALLTRIM(loForm.cmd_4c_BtnOficina.Caption) + "]" + ;
        " | Visible=" + TRANSFORM(loForm.cmd_4c_BtnOficina.Visible) + " (esperado .F.)" + ;
        " | picExiste=" + TRANSFORM(FILE(loForm.cmd_4c_BtnOficina.Picture)) + lcCRLF, lcLog, 1)

    STRTOFILE("obj_4c_Commandgroup1 : " + TRANSFORM(PEMSTATUS(loForm, "obj_4c_Commandgroup1", 5)) + ;
        " | ButtonCount=" + TRANSFORM(loForm.obj_4c_Commandgroup1.ButtonCount) + ;
        " | Visible=" + TRANSFORM(loForm.obj_4c_Commandgroup1.Visible) + lcCRLF, lcLog, 1)

    LOCAL loc_nB
    FOR loc_nB = 1 TO 6
        STRTOFILE("  Buttons(" + TRANSFORM(loc_nB) + ")        : [" + ;
            ALLTRIM(loForm.obj_4c_Commandgroup1.Buttons(loc_nB).Caption) + "]" + ;
            " Visible=" + TRANSFORM(loForm.obj_4c_Commandgroup1.Buttons(loc_nB).Visible) + ;
            " picExiste=" + TRANSFORM(FILE(loForm.obj_4c_Commandgroup1.Buttons(loc_nB).Picture)) + lcCRLF, lcLog, 1)
    ENDFOR

    STRTOFILE("obj_4c_TreeView      : " + TRANSFORM(PEMSTATUS(loForm, "obj_4c_TreeView", 5)) + ;
        " (esperado .F. em modo teste - guard pula a criacao)" + lcCRLF, lcLog, 1)

    STRTOFILE("--- FIM (form permanece VARTYPE O, sem crash) ---" + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("CREATEOBJECT      : FALHOU (loForm nao eh objeto)" + lcCRLF, lcLog, 1)
ENDIF

CLOSE ALL
QUIT
