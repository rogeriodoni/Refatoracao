*==============================================================================
* test_fase5_sigmvmvt.prg - Harness da Fase 5 do FormSIGMVMVT
* Prova que o form INSTANCIA (Init de form grande falha em cadeia) e confere
* os 5 campos de filtro + 5 labels contra os valores do dump do SCX legado.
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnI
LOCAL lcNome, lcEsp, lcObt, lcOk
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\automation\vfp_helpers\test_fase5_sigmvmvt_resultado.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 5 FormSIGMVMVT ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema
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

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg")  ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg")   ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVMVTBO.prg")   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- 1) INSTANCIACAO SEM PARAMETROS (modo filtro manual - Automatico = .F.)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVMVT")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : FALHA - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT      : FALHA - retornou " + VARTYPE(loForm) + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)
    STRTOFILE(lcCRLF + "--- CAMPOS DE FILTRO (Fase 5) x DUMP DO SCX LEGADO ---" + lcCRLF, lcLog, 1)

    *-- esperado TRANSCRITO do dump: nome | Top | Left | Width | Height | MaxLength
    LOCAL ARRAY laEsp[5, 6]
    laEsp[1,1] = "txt_4c_CEmp"
    laEsp[1,2] = 127
    laEsp[1,3] = 104
    laEsp[1,4] = 39
    laEsp[1,5] = 23
    laEsp[1,6] = 3

    laEsp[2,1] = "txt_4c_Dopes"
    laEsp[2,2] = 127
    laEsp[2,3] = 221
    laEsp[2,4] = 178
    laEsp[2,5] = 23
    laEsp[2,6] = 20

    laEsp[3,1] = "txt_4c_Numes"
    laEsp[3,2] = 127
    laEsp[3,3] = 463
    laEsp[3,4] = 53
    laEsp[3,5] = 23
    laEsp[3,6] = 6

    laEsp[4,1] = "txt_4c_DtI"
    laEsp[4,2] = 127
    laEsp[4,3] = 596
    laEsp[4,4] = 75
    laEsp[4,5] = 23
    laEsp[4,6] = 6

    laEsp[5,1] = "txt_4c_DtF"
    laEsp[5,2] = 127
    laEsp[5,3] = 692
    laEsp[5,4] = 75
    laEsp[5,5] = 23
    laEsp[5,6] = 6

    FOR lnI = 1 TO 5
        lcNome = laEsp[lnI, 1]
        IF !PEMSTATUS(loForm, lcNome, 5)
            STRTOFILE(">>>>" + PADR(lcNome, 15) + ": AUSENTE" + lcCRLF, lcLog, 1)
        ELSE
            lcObt = "Top=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Top")) + ;
                " Left=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Left")) + ;
                " Width=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Width")) + ;
                " Height=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Height")) + ;
                " MaxLen=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".MaxLength"))
            lcEsp = "Top=" + TRANSFORM(laEsp[lnI,2]) + " Left=" + TRANSFORM(laEsp[lnI,3]) + ;
                " Width=" + TRANSFORM(laEsp[lnI,4]) + " Height=" + TRANSFORM(laEsp[lnI,5]) + ;
                " MaxLen=" + TRANSFORM(laEsp[lnI,6])
            lcOk = IIF(lcObt == lcEsp, "OK  ", ">>>>")
            STRTOFILE(lcOk + PADR(lcNome, 15) + ": " + lcObt + ;
                " | VARTYPE(Value)=" + VARTYPE(EVALUATE("loForm." + lcNome + ".Value")) + ;
                " | Enabled=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Enabled")) + ;
                " | ReadOnly=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".ReadOnly")) + ;
                " | InputMask=[" + EVALUATE("loForm." + lcNome + ".InputMask") + "]" + lcCRLF, lcLog, 1)
            IF lcOk != "OK  "
                STRTOFILE("      esperado do dump: " + lcEsp + lcCRLF, lcLog, 1)
            ENDIF
        ENDIF
    ENDFOR

    STRTOFILE(lcCRLF + "--- LABELS DO FILTRO ---" + lcCRLF, lcLog, 1)
    FOR lnI = 1 TO 5
        lcNome = "lbl_4c_Label" + TRANSFORM(lnI)
        IF !PEMSTATUS(loForm, lcNome, 5)
            STRTOFILE(">>>>" + PADR(lcNome, 15) + ": AUSENTE" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE(PADR(lcNome, 15) + ": Caption=[" + EVALUATE("loForm." + lcNome + ".Caption") + "]" + ;
                " Top=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Top")) + ;
                " Left=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Left")) + ;
                " ForeColor=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".ForeColor")) + ;
                " Visible=" + TRANSFORM(EVALUATE("loForm." + lcNome + ".Visible")) + lcCRLF, lcLog, 1)
        ENDIF
    ENDFOR

    STRTOFILE(lcCRLF + "this_lAutomatico (sem params, esperado .F.) = " + ;
        TRANSFORM(loForm.this_lAutomatico) + lcCRLF, lcLog, 1)
    loForm.Release()
    loForm = .NULL.
ENDIF

*-- 2) Automatico: SO com Empresa -> legado NAO liga o modo automatico
LOCAL loF2, loF3
loF2 = .NULL.
TRY
    loF2 = CREATEOBJECT("FormSIGMVMVT", .F., "001", "", 0)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT(so Empresa): FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
IF VARTYPE(loF2) = "O"
    STRTOFILE(lcCRLF + "--- Automatico com SO a Empresa (legado: .F.) ---" + lcCRLF, lcLog, 1)
    STRTOFILE("  this_lAutomatico    = " + TRANSFORM(loF2.this_lAutomatico) + ;
        IIF(loF2.this_lAutomatico, "  >>>> ERRADO", "  OK") + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_CEmp Enabled = " + TRANSFORM(loF2.txt_4c_CEmp.Enabled) + ;
        " (esperado .T. - filtro segue editavel)" + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_Dopes Enabled= " + TRANSFORM(loF2.txt_4c_Dopes.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_CEmp Value   = [" + loF2.txt_4c_CEmp.Value + "] (pre-preenchido)" + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_CEmp ReadOnly= " + TRANSFORM(loF2.txt_4c_CEmp.ReadOnly) + " (esperado .F.)" + lcCRLF, lcLog, 1)
    loF2.Release()
    loF2 = .NULL.
ENDIF

*-- 3) Automatico: os TRES params -> legado liga, trava e desabilita
loF3 = .NULL.
TRY
    loF3 = CREATEOBJECT("FormSIGMVMVT", .F., "001", "MONTAGEM", 123)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT(3 params): FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY
IF VARTYPE(loF3) = "O"
    STRTOFILE(lcCRLF + "--- Automatico com os TRES params (legado: .T.) ---" + lcCRLF, lcLog, 1)
    STRTOFILE("  this_lAutomatico     = " + TRANSFORM(loF3.this_lAutomatico) + ;
        IIF(loF3.this_lAutomatico, "  OK", "  >>>> ERRADO") + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_CEmp  ReadOnly=" + TRANSFORM(loF3.txt_4c_CEmp.ReadOnly) + ;
        " Enabled=" + TRANSFORM(loF3.txt_4c_CEmp.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_Dopes ReadOnly=" + TRANSFORM(loF3.txt_4c_Dopes.ReadOnly) + ;
        " Enabled=" + TRANSFORM(loF3.txt_4c_Dopes.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_Numes ReadOnly=" + TRANSFORM(loF3.txt_4c_Numes.ReadOnly) + ;
        " Enabled=" + TRANSFORM(loF3.txt_4c_Numes.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_DtI   Enabled =" + TRANSFORM(loF3.txt_4c_DtI.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  txt_4c_DtF   Enabled =" + TRANSFORM(loF3.txt_4c_DtF.Enabled) + lcCRLF, lcLog, 1)
    STRTOFILE("  Values: CEmp=[" + loF3.txt_4c_CEmp.Value + "] Dopes=[" + ;
        loF3.txt_4c_Dopes.Value + "] Numes=" + TRANSFORM(loF3.txt_4c_Numes.Value) + lcCRLF, lcLog, 1)
    loF3.Release()
    loF3 = .NULL.
ENDIF

STRTOFILE(lcCRLF + "--- FIM ---" + lcCRLF, lcLog, 1)
QUIT
