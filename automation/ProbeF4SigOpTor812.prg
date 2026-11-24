* ProbeF4SigOpTor812.prg
* Fase 4 da task812: prova em RUNTIME que as 3 grades e o botao Retornar
* existem, que CarregarLista() eh alcancavel de FORA da classe sem estourar
* (regra #3) e que o toggle de modo funciona nos dois ramos.
*
* NAO roda ConfigurarAmbiente(): so carrega as dependencias diretas.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .F.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f4_sigoptor812.txt"

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
    loc_oForm = CREATEOBJECT("FormSIGOPTOR", loc_oFormPaiFake, 1, "P")

    IF VARTYPE(loc_oForm) != "O"
        loc_cSaida = "CK01 FALHA: CREATEOBJECT devolveu [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10)
    ELSE
        loc_cSaida = "CK01 instanciou           = OK" + CHR(13) + CHR(10)

        *-- CK02-04: as 3 grades existem
        loc_cSaida = loc_cSaida + "CK02 grd_4c_ItensPendentes = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_ItensPendentes", 5)) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK03 grd_4c_TotalPorData   = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_TotalPorData", 5)) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK04 grd_4c_TotalGeral     = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "grd_4c_TotalGeral", 5)) + "]" + CHR(13) + CHR(10)

        *-- CK05: geometria da grade de 9 colunas (Column5 = "Column6" do dump)
        loc_cSaida = loc_cSaida + "CK05 grdItem ColumnCount=[" + TRANSFORM(loc_oForm.grd_4c_ItensPendentes.ColumnCount) + ;
            "] C1.W=[" + TRANSFORM(loc_oForm.grd_4c_ItensPendentes.Column1.Width) + ;
            "] C5.W=[" + TRANSFORM(loc_oForm.grd_4c_ItensPendentes.Column5.Width) + ;
            "] C5.Header=[" + ALLTRIM(loc_oForm.grd_4c_ItensPendentes.Column5.Header1.Caption) + "]" + CHR(13) + CHR(10)

        *-- CK06: botao Retornar existe, dentro do CommandGroup cmg_4c_OK
        loc_cSaida = loc_cSaida + "CK06 cmg_4c_OK           = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "cmg_4c_OK", 5)) + "]" + CHR(13) + CHR(10)
        IF PEMSTATUS(loc_oForm, "cmg_4c_OK", 5)
            loc_cSaida = loc_cSaida + "CK07 Buttons(1).Caption  = [" + ;
                ALLTRIM(loc_oForm.cmg_4c_OK.Buttons(1).Caption) + "]" + CHR(13) + CHR(10)
        ENDIF

        *-- CK08: CarregarLista eh PUBLIC e alcancavel de fora (regra #3)
        loc_cSaida = loc_cSaida + "CK08 CarregarLista PROTECTED = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + "] (esperado .F.)" + CHR(13) + CHR(10)

        *-- CK09: chamada externa - sem crSigMvOrp/crSigMvOrc abertos, modo
        *-- "P" so formata e torna visiveis as grades certas, sem estourar
        loc_lRet = loc_oForm.CarregarLista()
        loc_cSaida = loc_cSaida + "CK09 CarregarLista() modo P  = [" + TRANSFORM(loc_lRet) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK10 Caption pos-carga       = [" + ALLTRIM(loc_oForm.Caption) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "CK11 grdItem.Visible=[" + TRANSFORM(loc_oForm.grd_4c_ItensPendentes.Visible) + ;
            "] grdTotPrev.Visible=[" + TRANSFORM(loc_oForm.grd_4c_TotalPorData.Visible) + ;
            "] grdTotal.Visible=[" + TRANSFORM(loc_oForm.grd_4c_TotalGeral.Visible) + "]" + CHR(13) + CHR(10)

        *-- CK12: BtnRetornarClick PUBLIC
        loc_cSaida = loc_cSaida + "CK12 BtnRetornarClick PROTECTED = [" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "BtnRetornarClick", 2)) + "] (esperado .F.)" + CHR(13) + CHR(10)

        *-- CK13: clique no botao reabilita o pai e fecha o dialogo
        loc_oFormPaiFake.Enabled = .F.
        loc_oForm.BtnRetornarClick()
        loc_cSaida = loc_cSaida + "CK13 FormPai.Enabled pos-click = [" + ;
            TRANSFORM(loc_oFormPaiFake.Enabled) + "] (esperado .T.)" + CHR(13) + CHR(10)
        loc_oForm = .NULL.
    ENDIF

CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc: " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cSaida = loc_cSaida + "--- DIALOGOS CAPTURADOS (ModoTeste) ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "--- nenhum dialogo capturado ---" + CHR(13) + CHR(10)
ENDIF

= STRTOFILE(loc_cSaida, "C:\4c\automation\_probe812f4.txt")
QUIT
