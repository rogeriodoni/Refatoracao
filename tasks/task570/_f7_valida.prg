SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gcLog, gnDespachos
gcLog = "C:\4c\tasks\task570\_f7_valida.log"
gnDespachos = 0
IF FILE(gcLog)
    DELETE FILE (gcLog)
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), gcLog)

*-- Harness MINIMO (ConfigurarAmbiente() trava headless: varre 500+ forms)
PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoBase, gc_4c_UsuarioLogado
gnConnHandle       = -1
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoBase  = "C:\4c\projeto\app\start\"
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_UsuarioLogado = "TESTE"

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg      ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg       ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg   ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg     ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigMvExpBO.prg   ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigMvExp.prg ADDITIVE
STRTOFILE("HARNESS_OK" + CHR(13) + CHR(10), gcLog, 1)

*-- TESTE 1: chamada NORMAL (7 args)
TRY
    loF1 = CREATEOBJECT("FormSigMvExp", "OPERACAO01", "C", 42, "001", .T., 7, .F.)
    IF VARTYPE(loF1) = "O"
        STRTOFILE("T1 (7 args) OK W/H=" + TRANSFORM(loF1.Width) + "x" + TRANSFORM(loF1.Height) + ;
            " TIPO=[" + loF1.this_oBusinessObject.this_cTipo + "]" + ;
            " NUME=" + TRANSFORM(loF1.this_oBusinessObject.this_nNume) + ;
            " EMP=[" + loF1.this_oBusinessObject.this_cEmp + "]" + ;
            " CAIXA=" + TRANSFORM(loF1.this_oBusinessObject.this_nCaixa) + CHR(13) + CHR(10), gcLog, 1)
    ELSE
        STRTOFILE("T1 FALHOU VARTYPE=" + VARTYPE(loF1) + CHR(13) + CHR(10), gcLog, 1)
    ENDIF
CATCH TO loE
    STRTOFILE("T1 ERRO=" + loE.Message + CHR(13) + CHR(10), gcLog, 1)
ENDTRY

*-- TESTE 2: 5 args (padrao real FormCNF.prg:2655 - sem pCaixa/pMacro)
TRY
    loF2 = CREATEOBJECT("FormSigMvExp", "OPERACAO01", "C", 42, "001", .T.)
    STRTOFILE("T2 (5 args) VARTYPE=" + VARTYPE(loF2) + ;
        IIF(VARTYPE(loF2) = "O", " => ABRE", " => NAO ABRE") + CHR(13) + CHR(10), gcLog, 1)
CATCH TO loE
    STRTOFILE("T2 ERRO=" + loE.Message + CHR(13) + CHR(10), gcLog, 1)
ENDTRY

*-- TESTE 3: UM arg OBJETO (padrao real FormSigPrHpr.prg:936)
TRY
    loF3 = CREATEOBJECT("FormSigMvExp", CREATEOBJECT("Custom"))
    STRTOFILE("T3 (1 arg objeto) VARTYPE=" + VARTYPE(loF3) + ;
        IIF(VARTYPE(loF3) = "O", " TIPO=[" + loF3.this_oBusinessObject.this_cTipo + "] => ABRE", " => NAO ABRE") + ;
        CHR(13) + CHR(10), gcLog, 1)
CATCH TO loE
    STRTOFILE("T3 ERRO=" + loE.Message + CHR(13) + CHR(10), gcLog, 1)
ENDTRY

*-- TESTE 4: trava de re-entrancia - 5 Activate devem dar 1 despacho so
TRY
    loF4 = CREATEOBJECT("TSpyDespacho", "OPERACAO01", "E", 0, "001", .F., 0, .F.)
    IF VARTYPE(loF4) = "O"
        STRTOFILE("T4 flag inicial=" + TRANSFORM(loF4.this_lDespachouAuto) + CHR(13) + CHR(10), gcLog, 1)
        FOR lni = 1 TO 5
            loF4.Activate()
        ENDFOR
        STRTOFILE("T4 apos 5 Activate: despachos=" + TRANSFORM(gnDespachos) + ;
            " flag=" + TRANSFORM(loF4.this_lDespachouAuto) + ;
            IIF(gnDespachos = 1, "  => TRAVA OK", "  => TRAVA FALHOU") + CHR(13) + CHR(10), gcLog, 1)
    ELSE
        STRTOFILE("T4 FALHOU VARTYPE=" + VARTYPE(loF4) + CHR(13) + CHR(10), gcLog, 1)
    ENDIF
CATCH TO loE
    STRTOFILE("T4 ERRO=" + loE.Message + " LN=" + TRANSFORM(loE.LineNo) + CHR(13) + CHR(10), gcLog, 1)
ENDTRY

STRTOFILE("FIM" + CHR(13) + CHR(10), gcLog, 1)
QUIT

DEFINE CLASS TSpyDespacho AS FormSigMvExp
    PROCEDURE BtnProcessoClick()
        gnDespachos = gnDespachos + 1
        STRTOFILE("   [spy] despacho acionado (#" + TRANSFORM(gnDespachos) + ")" + CHR(13) + CHR(10), gcLog, 1)
    ENDPROC
ENDDEFINE
