* ProbeF4SigOpTor812Item.prg
* Fase 4 da task812: mesmo probe, modo "Itens Subnivel" (pVisual <> "P"),
* sem crSigMvOrc aberto - deve cair no ramo "sem contexto" (RETURN .T.,
* nao o Return .f. do legado, que pressupoe contexto valido e cadeia vazia).
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .F.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f4_sigoptor812item.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oFormPaiFake, loc_lRet
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SIGOPTORBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGOPTOR.prg" ADDITIVE

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oForm = CREATEOBJECT("FormSIGOPTOR", loc_oFormPaiFake, 1, "I")

    IF VARTYPE(loc_oForm) != "O"
        loc_cSaida = "CK01 FALHA: CREATEOBJECT devolveu [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = "CK01 instanciou           = OK" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK02 this_cModoVisual     = [" + loc_oForm.this_cModoVisual + "]" + CHR(13) + CHR(10)

        loc_lRet = loc_oForm.CarregarLista()
        loc_cSaida = loc_cSaida + "CK03 CarregarLista() modo I  = [" + TRANSFORM(loc_lRet) + ;
            "] (esperado .T. - sem crSigMvOrc aberto, ramo sem contexto)" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK04 Caption pos-carga       = [" + ALLTRIM(loc_oForm.Caption) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK05 grdItem.Visible=[" + TRANSFORM(loc_oForm.grd_4c_ItensPendentes.Visible) + ;
            "] grdTotPrev.Visible=[" + TRANSFORM(loc_oForm.grd_4c_TotalPorData.Visible) + ;
            "] grdTotal.Visible=[" + TRANSFORM(loc_oForm.grd_4c_TotalGeral.Visible) + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
        loc_oForm = .NULL.
    ENDIF

CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc: " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

= STRTOFILE(loc_cSaida, "C:\4c\automation\_probe812f4item.txt")
QUIT
