* ProbeF6Sigoptrp815.prg
* Instancia FormSigoptrp (Fase 6) e grava o estado do lookup de celula
* (Column1/Itras) num TXT. NAO roda config.prg: o SQL Server do ambiente
* nao esta acessivel nesta maquina. gb_4c_ValidandoUI pula CarregarLista
* (SQLEXEC) - a grade fica vazia, mas ja formatada por AplicarFormatoGrade,
* inclusive o TextBox customizado de lookup instalado em Column1.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f6_sigoptrp815.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oGrid, loc_oFormPaiFake, loc_oTxt
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\textboxgridlookup.PRG" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigoptrpBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigoptrp.prg" ADDITIVE

    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oFormPaiFake.Enabled = .F.

    loc_oForm = CREATEOBJECT("FormSigoptrp", loc_oFormPaiFake, "001234", 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: FormSigoptrp instanciado" + CHR(13) + CHR(10)

        IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
            loc_oGrid = loc_oForm.grd_4c_Dados

            loc_cSaida = loc_cSaida + "Column1.CurrentControl=[" + loc_oGrid.Column1.CurrentControl + ;
                "] Sparse=[" + TRANSFORM(loc_oGrid.Column1.Sparse) + ;
                "] ReadOnly=[" + TRANSFORM(loc_oGrid.Column1.ReadOnly) + "]" + CHR(13) + CHR(10)

            IF PEMSTATUS(loc_oGrid.Column1, "txt_4c_CelItras", 5)
                loc_oTxt = loc_oGrid.Column1.txt_4c_CelItras
                loc_cSaida = loc_cSaida + "txt_4c_CelItras: BaseClass=[" + loc_oTxt.BaseClass + ;
                    "] Class=[" + loc_oTxt.Class + "] MaxLength=[" + TRANSFORM(loc_oTxt.MaxLength) + "]" + CHR(13) + CHR(10)

                *-- Legado: When -> Thisform.AntValue = This.Value
                loc_oTxt.Value = "0001234567"
                loc_oForm.GuardarItrasAnterior(loc_oTxt)
                loc_cSaida = loc_cSaida + "ValorAnteriorAposWhen=[" + loc_oForm.this_cValorAnteriorItras + "]" + CHR(13) + CHR(10)

                *-- Legado: Valid com This.Value vazio -> This.Value = ''
                loc_oTxt.Value = "   "
                loc_cSaida = loc_cSaida + "ValidarVazio=[" + TRANSFORM(loc_oForm.ValidarItrasGridExec(loc_oTxt)) + ;
                    "] ValueAposLimpar=[" + loc_oTxt.Value + "]" + CHR(13) + CHR(10)

                *-- Sem gnConnHandle/SQL (modo teste): o lookup estourando ou
                *-- travando seria um FALHA aqui, nao um "achou"/"nao achou"
                loc_oTxt.Value = "0001234567"
                loc_cSaida = loc_cSaida + "AbrirLookupItrasExiste=[" + ;
                    TRANSFORM(PEMSTATUS(loc_oForm, "AbrirLookupItras", 5)) + "]" + CHR(13) + CHR(10)
                loc_cSaida = loc_cSaida + "this_lEmLookupItrasInicial=[" + TRANSFORM(loc_oForm.this_lEmLookupItras) + "]" + CHR(13) + CHR(10)
            ELSE
                loc_cSaida = loc_cSaida + "FALHA: txt_4c_CelItras nao existe em Column1" + CHR(13) + CHR(10)
            ENDIF
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: grd_4c_Dados nao existe" + CHR(13) + CHR(10)
        ENDIF

        loc_oForm.Release()
        loc_oFormPaiFake.Release()
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f6_sigoptrp815.txt")

QUIT
