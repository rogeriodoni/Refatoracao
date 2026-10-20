*-- Mede SET("SAFETY") dentro de datasession PRIVADA (DataSession = 2),
*-- reproduzindo o ambiente do FormSIGPRNSE. NAO executa ZAP: com SAFETY ON
*-- o ZAP abriria o dialogo modal e travaria o processo headless.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_oTeste, loc_cSaida

loc_cSaida = "SAFETY_SESSAO_1=" + SET("SAFETY") + CHR(13) + CHR(10)

loc_oTeste = CREATEOBJECT("TesteSafetyDS2")
loc_cSaida = loc_cSaida + ;
    "SAFETY_DATASESSION_PRIVADA=" + loc_oTeste.cSafety + CHR(13) + CHR(10) + ;
    "DATASESSIONID=" + TRANSFORM(loc_oTeste.nSessao) + CHR(13) + CHR(10)

STRTOFILE(loc_cSaida, "C:\4c\automation\medir_safety_ds2_nse.txt")
QUIT

DEFINE CLASS TesteSafetyDS2 AS Form
    DataSession = 2
    cSafety  = ""
    nSessao  = 0

    PROCEDURE Init()
        THIS.cSafety = SET("SAFETY")
        THIS.nSessao = THIS.DataSessionId
    ENDPROC
ENDDEFINE
