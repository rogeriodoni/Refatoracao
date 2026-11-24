* ProbeF3SigOpTop811.prg
* Instancia FormSigOpTop (Fase 3) e grava o estado da estrutura base num TXT.
* NAO roda config.prg: o SQL Server do ambiente nao esta acessivel nesta
* maquina e ConfigurarAmbiente() travaria o probe. InicializarForm() nesta
* fase nao consulta banco nenhum (SigOpTopBO.Init nao faz SQLEXEC), entao
* basta carregar as classes base e definir as globais que o Form le.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoFramework, gc_4c_CaminhoIcones, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste    = .T.
gb_4c_ValidandoUI  = .T.
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\_erro_f3_sigoptop811.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_oCab, loc_oFormPaiFake
loc_cSaida = ""

TRY
    SET PROCEDURE TO "C:\4c\projeto\app\utils\messages.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\utils\functions.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\dataaccess.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\businessbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\formbase.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\classes\SigOpTopBO.prg" ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSigOpTop.prg" ADDITIVE

    *-- Form pai fake, so para provar o contrato this_oFormPai + Destroy
    loc_oFormPaiFake = CREATEOBJECT("Form")
    loc_oFormPaiFake.Enabled = .F.

    loc_oForm = CREATEOBJECT("FormSigOpTop", loc_oFormPaiFake, "001234", 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = "OK: FormSigOpTop instanciado" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "BaseClass=[" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Width=[" + TRANSFORM(loc_oForm.Width) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Height=[" + TRANSFORM(loc_oForm.Height) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "TitleBar=[" + TRANSFORM(loc_oForm.TitleBar) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlBox=[" + TRANSFORM(loc_oForm.ControlBox) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "MaxButton=[" + TRANSFORM(loc_oForm.MaxButton) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "Movable=[" + TRANSFORM(loc_oForm.Movable) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "WindowType=[" + TRANSFORM(loc_oForm.WindowType) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "BorderStyle=[" + TRANSFORM(loc_oForm.BorderStyle) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "DataSession=[" + TRANSFORM(loc_oForm.DataSession) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "BO=[" + VARTYPE(loc_oForm.this_oBusinessObject) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "FormPai=[" + VARTYPE(loc_oForm.this_oFormPai) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_cDopes=[" + loc_oForm.this_cDopes + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "this_nDataSessionPai=[" + TRANSFORM(loc_oForm.this_nDataSessionPai) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "BO.this_cDopes=[" + loc_oForm.this_oBusinessObject.this_cDopes + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount=[" + TRANSFORM(loc_oForm.ControlCount) + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "FormPaiEnabledDuranteDialogo=[" + TRANSFORM(loc_oFormPaiFake.Enabled) + "]" + CHR(13) + CHR(10)

        IF PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)
            loc_oCab = loc_oForm.cnt_4c_Cabecalho
            loc_cSaida = loc_cSaida + "cnt_4c_Cabecalho: Visible=[" + TRANSFORM(loc_oCab.Visible) + ;
                "] Top=[" + TRANSFORM(loc_oCab.Top) + "] Width=[" + TRANSFORM(loc_oCab.Width) + ;
                "] Height=[" + TRANSFORM(loc_oCab.Height) + "] BackColor=[" + ;
                TRANSFORM(loc_oCab.BackColor) + "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "lbl_4c_Sombra: Caption=[" + ;
                loc_oCab.lbl_4c_Sombra.Caption + "] Visible=[" + ;
                TRANSFORM(loc_oCab.lbl_4c_Sombra.Visible) + "] Width=[" + ;
                TRANSFORM(loc_oCab.lbl_4c_Sombra.Width) + "]" + CHR(13) + CHR(10)
            loc_cSaida = loc_cSaida + "lbl_4c_Titulo: Caption=[" + ;
                loc_oCab.lbl_4c_Titulo.Caption + "] Visible=[" + ;
                TRANSFORM(loc_oCab.lbl_4c_Titulo.Visible) + "] Width=[" + ;
                TRANSFORM(loc_oCab.lbl_4c_Titulo.Width) + "]" + CHR(13) + CHR(10)
        ELSE
            loc_cSaida = loc_cSaida + "FALHA: cnt_4c_Cabecalho nao existe" + CHR(13) + CHR(10)
        ENDIF

        loc_cSaida = loc_cSaida + "Picture=[" + loc_oForm.Picture + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "PictureExiste=[" + IIF(FILE(loc_oForm.Picture), "SIM", "NAO") + ;
            "]" + CHR(13) + CHR(10)

        *-- Prova do Destroy: form pai fake deve voltar Enabled = .T.
        loc_oForm.Release()
        loc_cSaida = loc_cSaida + "PaiReabilitadoAposRelease=[" + TRANSFORM(loc_oFormPaiFake.Enabled) + "]" + CHR(13) + CHR(10)

        loc_oFormPaiFake.Release()
    ELSE
        loc_cSaida = "FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "ERRO: " + loc_oErro.Message + " | LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " | PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_f3_sigoptop811.txt")

QUIT
