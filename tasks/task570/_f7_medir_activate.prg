SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL
PUBLIC gnActivate, gnDespachos, gcLog
gnActivate  = 0
gnDespachos = 0
gcLog = "C:\4c\tasks\task570\_f7_medir_activate.log"
IF FILE(gcLog)
    DELETE FILE (gcLog)
ENDIF
STRTOFILE("INICIO" + CHR(13) + CHR(10), gcLog)

loPai = .NULL.
TRY
    loPai = CREATEOBJECT("TPaiSemGuarda")
    STRTOFILE("pai criado VARTYPE=" + VARTYPE(loPai) + CHR(13) + CHR(10), gcLog, 1)
    loPai.Show()
    STRTOFILE("apos Show() - entrando em READ EVENTS" + CHR(13) + CHR(10), gcLog, 1)
    READ EVENTS
    STRTOFILE("RESULTADO: Activate do pai disparou " + TRANSFORM(gnActivate) + ;
        " vez(es); despachos = " + TRANSFORM(gnDespachos) + CHR(13) + CHR(10), gcLog, 1)
CATCH TO loErr
    STRTOFILE("ERRO=" + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), gcLog, 1)
ENDTRY
STRTOFILE("FIM" + CHR(13) + CHR(10), gcLog, 1)
QUIT

DEFINE CLASS TFilho AS Form
    WindowType = 1
    Caption    = "Filho"
    PROCEDURE Activate()
        STRTOFILE("   [filho] Activate - vou me fechar" + CHR(13) + CHR(10), gcLog, 1)
        THIS.Release()
    ENDPROC
ENDDEFINE

DEFINE CLASS TPaiSemGuarda AS Form
    WindowType = 0
    Caption    = "PaiSemGuarda"
    PROCEDURE Init()
        THIS.AddObject("tmr_Corta", "TTimerCorta")
        THIS.tmr_Corta.Enabled = .T.
    ENDPROC
    PROCEDURE Activate()
        gnActivate = gnActivate + 1
        STRTOFILE("[pai] Activate #" + TRANSFORM(gnActivate) + CHR(13) + CHR(10), gcLog, 1)
        IF gnActivate > 3
            STRTOFILE("[pai] CORTANDO em 3 - seria LOOP INFINITO" + CHR(13) + CHR(10), gcLog, 1)
            CLEAR EVENTS
            RETURN
        ENDIF
        THIS.Despachar()
    ENDPROC
    PROCEDURE Despachar()
        LOCAL loF
        gnDespachos = gnDespachos + 1
        STRTOFILE("[pai] despacho #" + TRANSFORM(gnDespachos) + CHR(13) + CHR(10), gcLog, 1)
        loF = CREATEOBJECT("TFilho")
        IF VARTYPE(loF) = "O"
            loF.Show()
        ENDIF
    ENDPROC
ENDDEFINE

DEFINE CLASS TTimerCorta AS Timer
    Interval = 10000
    Enabled  = .F.
    PROCEDURE Timer()
        STRTOFILE("[timer] tempo esgotado - CLEAR EVENTS" + CHR(13) + CHR(10), gcLog, 1)
        THIS.Enabled = .F.
        CLEAR EVENTS
    ENDPROC
ENDDEFINE
