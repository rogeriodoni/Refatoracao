SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL loc_cOut
loc_cOut = "INICIO" + CHR(13) + CHR(10)

SET NULL ON
CREATE CURSOR cur_medida (PrazoEnts T NULL, Nome C(5))
SET NULL OFF
INSERT INTO cur_medida (PrazoEnts, Nome) VALUES (.NULL., "a")
INSERT INTO cur_medida (PrazoEnts, Nome) VALUES (DATETIME(), "b")
loc_cOut = loc_cOut + "CURSOR_OK recs=" + TRANSFORM(RECCOUNT("cur_medida")) + CHR(13) + CHR(10)

TRY
    SELECT cur_medida
    REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)
    GO TOP
    loc_cOut = loc_cOut + "REPLACE_DATE=OK tipo=" + VARTYPE(cur_medida.PrazoEnts) + ;
               " isnull=" + IIF(ISNULL(cur_medida.PrazoEnts), "SIM", "NAO") + ;
               " valor=[" + TRANSFORM(cur_medida.PrazoEnts) + "]"
CATCH TO loc_oE
    loc_cOut = loc_cOut + "REPLACE_DATE=ERRO [" + loc_oE.Message + "]"
ENDTRY
loc_cOut = loc_cOut + CHR(13) + CHR(10)

TRY
    SELECT cur_medida
    GO TOP
    REPLACE ALL PrazoEnts WITH .NULL. FOR .T.
    REPLACE ALL PrazoEnts WITH CTOT("") FOR ISNULL(PrazoEnts)
    GO TOP
    loc_cOut = loc_cOut + "REPLACE_CTOT=OK tipo=" + VARTYPE(cur_medida.PrazoEnts) + ;
               " isnull=" + IIF(ISNULL(cur_medida.PrazoEnts), "SIM", "NAO") + ;
               " valor=[" + TRANSFORM(cur_medida.PrazoEnts) + "]"
CATCH TO loc_oE2
    loc_cOut = loc_cOut + "REPLACE_CTOT=ERRO [" + loc_oE2.Message + "]"
ENDTRY
loc_cOut = loc_cOut + CHR(13) + CHR(10) + "FIM"

STRTOFILE(loc_cOut, "C:\4c\automation\medir_replace_datetime.txt")
QUIT
