*-- Fase 8 task606 (SIGPRES1): compilacao do BO + Form e medicao do
*-- REPLACE de coluna DATETIME com valor DATE (CTOD("")).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cSaida, loc_cErrBO, loc_cErrForm, loc_cMedida

loc_cBO   = "C:\4c\projeto\app\classes\SigPrEs1BO.prg"
loc_cForm = "C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.prg"

IF FILE("C:\4c\projeto\app\classes\sigpres1bo.FXP")
    DELETE FILE "C:\4c\projeto\app\classes\sigpres1bo.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\formsigpres1.FXP")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigpres1.FXP"
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigPrEs1BO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigPrEs1BO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigPrEs1BO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigPrEs1BO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigPrEs1.err")
ENDIF

*-- Medicao: REPLACE de coluna T (datetime) com DATE, e com DATETIME vazio.
loc_cMedida = ""
SET NULL ON
CREATE CURSOR cur_medida (PrazoEnts T NULL, Nome C(5))
SET NULL OFF
INSERT INTO cur_medida (PrazoEnts, Nome) VALUES (.NULL., "a")
INSERT INTO cur_medida (PrazoEnts, Nome) VALUES (DATETIME(), "b")

TRY
    SELECT cur_medida
    REPLACE ALL PrazoEnts WITH CTOD("") FOR ISNULL(PrazoEnts)
    GO TOP
    loc_cMedida = loc_cMedida + "REPLACE_COM_DATE=OK tipo=" + VARTYPE(cur_medida.PrazoEnts) + ;
                  " isnull=" + IIF(ISNULL(cur_medida.PrazoEnts), "SIM", "NAO")
CATCH TO loc_oE
    loc_cMedida = loc_cMedida + "REPLACE_COM_DATE=ERRO [" + loc_oE.Message + "]"
ENDTRY
loc_cMedida = loc_cMedida + CHR(13) + CHR(10)

TRY
    SELECT cur_medida
    GO TOP
    REPLACE ALL PrazoEnts WITH .NULL. FOR .T.
    REPLACE ALL PrazoEnts WITH CTOT("") FOR ISNULL(PrazoEnts)
    GO TOP
    loc_cMedida = loc_cMedida + "REPLACE_COM_CTOT=OK tipo=" + VARTYPE(cur_medida.PrazoEnts) + ;
                  " isnull=" + IIF(ISNULL(cur_medida.PrazoEnts), "SIM", "NAO")
CATCH TO loc_oE2
    loc_cMedida = loc_cMedida + "REPLACE_COM_CTOT=ERRO [" + loc_oE2.Message + "]"
ENDTRY

loc_cSaida = "FXP_BO="   + IIF(FILE("C:\4c\projeto\app\classes\sigpres1bo.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE("C:\4c\projeto\app\forms\operacionais\formsigpres1.FXP"), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10) + ;
             loc_cMedida + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE("C:\4c\projeto\app\classes\sigpres1bo.FXP") ;
   AND FILE("C:\4c\projeto\app\forms\operacionais\formsigpres1.FXP")
    loc_cSaida = loc_cSaida + "COMPILE_OK"
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL"
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\compile_check_sigpres1_f8.txt")
QUIT
