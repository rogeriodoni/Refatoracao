SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gcLog
gcLog = "C:\4c\tasks\task570\_f8_valida.log"
IF FILE(gcLog)
    DELETE FILE (gcLog)
ENDIF
STRTOFILE("INICIO FASE8" + CHR(13) + CHR(10), gcLog)

*-- ETAPA A: COMPILACAO LIMPA (erros vao para .err)
IF FILE("C:\4c\projeto\app\classes\sigmvexpbo.fxp")
    DELETE FILE C:\4c\projeto\app\classes\sigmvexpbo.fxp
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigmvexp.fxp")
    DELETE FILE C:\4c\projeto\app\forms\operacionais\formsigmvexp.fxp
ENDIF
COMPILE C:\4c\projeto\app\classes\SigMvExpBO.prg
COMPILE C:\4c\projeto\app\forms\operacionais\FormSigMvExp.prg
STRTOFILE("A1 BO.fxp gerado=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\sigmvexpbo.fxp")) + CHR(13) + CHR(10), gcLog, 1)
STRTOFILE("A2 FORM.fxp gerado=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\formsigmvexp.fxp")) + CHR(13) + CHR(10), gcLog, 1)
STRTOFILE("A3 BO.err existe=" + TRANSFORM(FILE("C:\4c\projeto\app\classes\SigMvExpBO.err")) + CHR(13) + CHR(10), gcLog, 1)
STRTOFILE("A4 FORM.err existe=" + TRANSFORM(FILE("C:\4c\projeto\app\forms\operacionais\FormSigMvExp.err")) + CHR(13) + CHR(10), gcLog, 1)

*-- ETAPA B: harness minimo
PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoBase, gc_4c_UsuarioLogado
gnConnHandle        = -1
gb_4c_ModoTeste     = .T.
gb_4c_ValidandoUI   = .T.
gc_4c_CaminhoBase   = "C:\4c\projeto\app\start\"
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gc_4c_UsuarioLogado = "TESTE"

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg      ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg       ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg   ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg     ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigMvExpBO.prg   ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigMvExp.prg ADDITIVE
STRTOFILE("B HARNESS_OK" + CHR(13) + CHR(10), gcLog, 1)

*-- ETAPA C: instanciacao nos 3 modos do legado (E / C / A)
LOCAL i, lcTipo, loF
FOR i = 1 TO 3
    lcTipo = SUBSTR("ECA", i, 1)
    TRY
        loF = CREATEOBJECT("FormSigMvExp", "OPERACAO01", lcTipo, 42, "001", .T., 7, .F.)
        IF VARTYPE(loF) = "O"
            STRTOFILE("C" + TRANSFORM(i) + " TIPO=" + lcTipo + " OK " + ;
                TRANSFORM(loF.Width) + "x" + TRANSFORM(loF.Height) + ;
                " BOtipo=[" + loF.this_oBusinessObject.this_cTipo + "]" + ;
                " NUME=" + TRANSFORM(loF.this_oBusinessObject.this_nNume) + ;
                " EMP=[" + loF.this_oBusinessObject.this_cEmp + "]" + ;
                " botao=" + TRANSFORM(PEMSTATUS(loF, "cmd_4c_Processo", 5)) + ;
                " cap=[" + loF.cmd_4c_Processo.Caption + "]" + ;
                " vis=" + TRANSFORM(loF.cmd_4c_Processo.Visible) + ;
                " L/T/W/H=" + TRANSFORM(loF.cmd_4c_Processo.Left) + "/" + ;
                TRANSFORM(loF.cmd_4c_Processo.Top) + "/" + ;
                TRANSFORM(loF.cmd_4c_Processo.Width) + "/" + ;
                TRANSFORM(loF.cmd_4c_Processo.Height) + CHR(13) + CHR(10), gcLog, 1)
        ELSE
            STRTOFILE("C" + TRANSFORM(i) + " FALHOU VARTYPE=" + VARTYPE(loF) + CHR(13) + CHR(10), gcLog, 1)
        ENDIF
    CATCH TO loE
        STRTOFILE("C" + TRANSFORM(i) + " ERRO=" + loE.Message + CHR(13) + CHR(10), gcLog, 1)
    ENDTRY
    loF = .NULL.
ENDFOR

*-- ETAPA D: trava anti-loop do Activate (5 Activate -> 1 despacho)
*-- gb_4c_ModoTeste = .T. faz BtnProcessoClick retornar cedo, entao medimos a
*-- flag this_lDespachouAuto, que eh o que efetivamente barra a re-entrancia.
TRY
    loF = CREATEOBJECT("FormSigMvExp", "OPERACAO01", "E", 0, "", .F., 0, .F.)
    STRTOFILE("D0 flag inicial=" + TRANSFORM(loF.this_lDespachouAuto) + CHR(13) + CHR(10), gcLog, 1)
    FOR i = 1 TO 5
        loF.Activate()
    ENDFOR
    STRTOFILE("D1 apos 5 Activate flag=" + TRANSFORM(loF.this_lDespachouAuto) + CHR(13) + CHR(10), gcLog, 1)
CATCH TO loE
    STRTOFILE("D ERRO=" + loE.Message + CHR(13) + CHR(10), gcLog, 1)
ENDTRY

STRTOFILE("FIM" + CHR(13) + CHR(10), gcLog, 1)
QUIT
