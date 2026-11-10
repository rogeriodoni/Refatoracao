SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON
SET EXACT ON

lcLog = "C:\4c\automation\ProbeF6SigOpLim761Params.log"
STRTOFILE("", lcLog)
#DEFINE L CHR(13) + CHR(10)

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
gc_4c_ArquivoErroTeste = "C:\4c\automation\ProbeF6SigOpLim761Params_dialogs.txt"
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
SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg" ADDITIVE

*-- ORDEM REAL do Init migrado (poform/Pcx do legado NAO entram):
*--   1 totite  2 valor  3 pvalor  4 tipo  5 pMotivo
*--   6 pClaConta  7 plCheckBin  8 plCheckTabD  9 pcEmpresa

STRTOFILE("=== A: Tipo D, pMotivo=.T. (arg 5) - esperado 'usuario ... e Motivo:' ===" + L, lcLog, 1)
loA = CREATEOBJECT("FormSigOpLim", 3, 500.00, 10.00, "D", .T.)
IF VARTYPE(loA) = "O"
    STRTOFILE("this_lMotivo (esp .T.) .. " + TRANSFORM(loA.this_lMotivo) + L, lcLog, 1)
    STRTOFILE("Frase ................... [" + loA.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
    STRTOFILE("Lbl1/Motivo (esp .T./.T.) " + TRANSFORM(loA.lbl_4c_Label1.Visible) + "/" + ;
        TRANSFORM(loA.txt_4c__Motivo.Visible) + L, lcLog, 1)
    STRTOFILE("Lbl2/Usuario (esp .T./.T.)" + TRANSFORM(loA.lbl_4c_Label2.Visible) + "/" + ;
        TRANSFORM(loA.txt_4c_Usuario.Visible) + L, lcLog, 1)
    STRTOFILE("Motivo.Enabled (esp .T.)  " + TRANSFORM(loA.txt_4c__Motivo.Enabled) + L, lcLog, 1)
    STRTOFILE("BO Motivo (esp .T.) ..... " + TRANSFORM(loA.this_oBusinessObject.this_lMotivo) + L, lcLog, 1)
    STRTOFILE("BO CheckBin (esp .F.) ... " + TRANSFORM(loA.this_oBusinessObject.this_lCheckBin) + L, lcLog, 1)
    loA.Release()
ENDIF

STRTOFILE(L + "=== B: so motivo (0/0/0, D, pMotivo=.T.) ===" + L, lcLog, 1)
loB = CREATEOBJECT("FormSigOpLim", 0, 0, 0, "D", .T.)
IF VARTYPE(loB) = "O"
    STRTOFILE("SoMotivo (esp .T.) ...... " + TRANSFORM(loB.this_lSoMotivo) + L, lcLog, 1)
    STRTOFILE("Frase ................... [" + loB.lbl_4c_Frase.Caption + "]" + L, lcLog, 1)
    STRTOFILE("Motivo Visible/Enabled .. " + TRANSFORM(loB.txt_4c__Motivo.Visible) + "/" + ;
        TRANSFORM(loB.txt_4c__Motivo.Enabled) + "  (esp .T./.T.)" + L, lcLog, 1)
    STRTOFILE("Usuario Visible (esp .F.) " + TRANSFORM(loB.txt_4c_Usuario.Visible) + L, lcLog, 1)
    loB.Release()
ENDIF

STRTOFILE(L + "=== C: todos os 9 argumentos, ordem documentada ===" + L, lcLog, 1)
loC = CREATEOBJECT("FormSigOpLim", 7, 1234.56, 15.50, "A", .T., "CLA01", .T., .T., "002")
IF VARTYPE(loC) = "O"
    WITH loC.this_oBusinessObject
        STRTOFILE("BO TotIte/ValDesc/PDescs  " + TRANSFORM(.this_nTotIte) + "/" + ;
            TRANSFORM(.this_nValDesc) + "/" + TRANSFORM(.this_nPDescs) + ;
            "   (esp 7/1234.56/15.50)" + L, lcLog, 1)
        STRTOFILE("BO Tipo (esp A) ......... [" + .this_cTipo + "]" + L, lcLog, 1)
        STRTOFILE("BO Motivo (esp .T.) ..... " + TRANSFORM(.this_lMotivo) + L, lcLog, 1)
        STRTOFILE("BO ClaConta (esp CLA01) . [" + ALLTRIM(.this_cClaConta) + "]" + L, lcLog, 1)
        STRTOFILE("BO CheckBin/CheckTbd .... " + TRANSFORM(.this_lCheckBin) + "/" + ;
            TRANSFORM(.this_lCheckTbd) + "  (esp .T./.T.)" + L, lcLog, 1)
        STRTOFILE("BO Emps (esp 002) ....... [" + ALLTRIM(.this_cEmps) + "]" + L, lcLog, 1)
    ENDWITH
    loC.Release()
ENDIF

STRTOFILE(L + "=== D: FecharDialogo(.F.) nega; e sem argumento tambem nega ===" + L, lcLog, 1)
loD = CREATEOBJECT("FormSigOpLim", 1, 10, 1, "D", .T.)
IF VARTYPE(loD) = "O"
    loD.this_oBusinessObject.this_cZSenha = "NAODEVEVAZAR"
    loD.FecharDialogo(.F.)
    STRTOFILE("ObterResultado tipo/val . " + VARTYPE(loD.ObterResultado()) + " / " + ;
        TRANSFORM(loD.ObterResultado()) + "  (esp L / .F.)" + L, lcLog, 1)
    loD.Release()
ENDIF
loE = CREATEOBJECT("FormSigOpLim", 1, 10, 1, "D", .T.)
IF VARTYPE(loE) = "O"
    loE.this_oBusinessObject.this_cZSenha = "NAODEVEVAZAR"
    loE.FecharDialogo()
    STRTOFILE("sem arg: tipo/val ....... " + VARTYPE(loE.ObterResultado()) + " / " + ;
        TRANSFORM(loE.ObterResultado()) + "  (esp L / .F.)" + L, lcLog, 1)
    loE.Release()
ENDIF

STRTOFILE(L + "=== E: Destroy fecha os cursores do BO (datasession compartilhada) ===" + L, lcLog, 1)
loG = CREATEOBJECT("FormSigOpLim", 1, 10, 1, "D", .T.)
IF VARTYPE(loG) = "O"
    *-- simula os cursores que BuscarMotivos/BuscarUsuariosAutorizados criariam
    CREATE CURSOR cursor_4c_Usuarios (usuarios C(10), senhas C(10), ccargs C(10), limdescs C(1))
    CREATE CURSOR cursor_4c_Motivos  (codigos C(10), descrs C(40))
    STRTOFILE("antes do Release: Usuarios/Motivos = " + ;
        TRANSFORM(USED("cursor_4c_Usuarios")) + "/" + TRANSFORM(USED("cursor_4c_Motivos")) + L, lcLog, 1)
    loG.Release()
    STRTOFILE("apos  o Release: Usuarios/Motivos = " + ;
        TRANSFORM(USED("cursor_4c_Usuarios")) + "/" + TRANSFORM(USED("cursor_4c_Motivos")) + ;
        "  (esp .F./.F.)" + L, lcLog, 1)
ENDIF

STRTOFILE(L + "=== F: SEEK com PADR/FSIZE acha codigo curto sob SET EXACT ON ===" + L, lcLog, 1)
STRTOFILE("SET(EXACT) = " + SET("EXACT") + L, lcLog, 1)
CREATE CURSOR cursor_4c_Teste (codigos C(10), descrs C(40))
INSERT INTO cursor_4c_Teste VALUES ("7", "DESCONTO PROMOCIONAL")
INSERT INTO cursor_4c_Teste VALUES ("23", "AVARIA")
SELECT cursor_4c_Teste
INDEX ON codigos TAG codigos
GO TOP
STRTOFILE("SEEK valor CRU      ('7') ... " + ;
    TRANSFORM(SEEK("7", "cursor_4c_Teste", "codigos")) + "  <- forma descartada" + L, lcLog, 1)
GO TOP
STRTOFILE("SEEK PADR/FSIZE     ('7') ... " + ;
    TRANSFORM(SEEK(PADR("7", FSIZE("codigos", "cursor_4c_Teste")), "cursor_4c_Teste", "codigos")) + ;
    "  <- forma usada  (esp .T.)" + L, lcLog, 1)
STRTOFILE("   RECNO apos o SEEK ....... " + TRANSFORM(RECNO("cursor_4c_Teste")) + ;
    "  codigos=[" + ALLTRIM(cursor_4c_Teste.codigos) + "]" + L, lcLog, 1)
GO TOP
STRTOFILE("SEEK inexistente   ('99') ... " + ;
    TRANSFORM(SEEK(PADR("99", FSIZE("codigos", "cursor_4c_Teste")), "cursor_4c_Teste", "codigos")) + ;
    "  (esp .F.)" + L, lcLog, 1)
USE IN cursor_4c_Teste

STRTOFILE(L + "=== dialogos suprimidos ===" + L, lcLog, 1)
STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + L, lcLog, 1)
STRTOFILE("FIM" + L, lcLog, 1)
QUIT
