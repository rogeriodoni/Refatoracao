SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
lcLog = "C:\4c\tasks\task570\_f6_instancia.log"
IF FILE(lcLog)
    DELETE FILE (lcLog)
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), lcLog)
CD C:\4c\projeto\app\start
DO config.prg
ConfigurarAmbiente()
PUBLIC gb_4c_ModoTeste
gb_4c_ModoTeste  = .T.
gb_4c_ValidandoUI = .T.
STRTOFILE("CONFIG_OK PATH=[" + SET("PATH") + "]" + CHR(13) + CHR(10), lcLog, 1)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSigMvExp", "OPERACAO01", "E", 0, "001", .F., 0, .F.)
    STRTOFILE("VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, 1)
    IF VARTYPE(loForm) = "O"
        STRTOFILE("BASECLASS=" + loForm.BaseClass + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("W/H=" + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10), lcLog, 1)
        STRTOFILE("BOTAO=" + IIF(PEMSTATUS(loForm, "cmd_4c_Processo", 5), "SIM", "NAO") + CHR(13) + CHR(10), lcLog, 1)
        IF PEMSTATUS(loForm, "cmd_4c_Processo", 5)
            STRTOFILE("BTN_VISIBLE=" + TRANSFORM(loForm.cmd_4c_Processo.Visible) + ;
                " CAPTION=[" + loForm.cmd_4c_Processo.Caption + "]" + ;
                " T/L/W/H=" + TRANSFORM(loForm.cmd_4c_Processo.Top) + "/" + ;
                TRANSFORM(loForm.cmd_4c_Processo.Left) + "/" + ;
                TRANSFORM(loForm.cmd_4c_Processo.Width) + "/" + ;
                TRANSFORM(loForm.cmd_4c_Processo.Height) + CHR(13) + CHR(10), lcLog, 1)
        ENDIF
        STRTOFILE("BO=" + VARTYPE(loForm.this_oBusinessObject) + ;
            " TIPO=[" + TRANSFORM(loForm.this_oBusinessObject.this_cTipo) + "]" + ;
            " DOPE=[" + TRANSFORM(loForm.this_oBusinessObject.this_cDope) + "]" + CHR(13) + CHR(10), lcLog, 1)
        loForm.Activate()
        STRTOFILE("ACTIVATE_OK (modo teste nao despacha)" + CHR(13) + CHR(10), lcLog, 1)
        loForm.Release()
    ENDIF
CATCH TO loErr
    STRTOFILE("ERRO=" + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, 1)
ENDTRY
STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT
