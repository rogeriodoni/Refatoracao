*==============================================================================
* ProbeIcoF8Polaridades.prg - Fase 8 / task624
*
* Instancia Formsigprico nas DUAS polaridades do guard de modo:
*   (1) MODO TESTE    - gb_4c_ModoTeste = .T.  (a que o harness exercita)
*   (2) PRODUCAO      - gb_4c_ModoTeste = .F.  (a que o harness NUNCA exercita)
*
* Motivo: a licao do ShowWindow mostra que atribuicao dentro de guard de modo
* esconde o defeito de todo gate - "instanciar para provar que abre" passa
* limpo porque o harness sempre liga gb_4c_ModoTeste, e o usuario que clica no
* menu cai no outro ramo. Entao as DUAS tem de ser medidas.
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina.
* Nao chama Show() - em WindowType = 1 ele BLOQUEIA (e isso e' o esperado);
* o que interessa aqui e' se Load() + Init() sobrevivem.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE SAIDA "C:\4c\automation\probe_ico_f8_polaridades.txt"

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
LOCAL loc_oErro
STRTOFILE("PROBE FASE 8 - DUAS POLARIDADES", SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigpricoBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprico.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", SAIDA, 1)

    DO MedirPolaridade WITH .T., "MODO TESTE (gb_4c_ModoTeste = .T.)"
    DO MedirPolaridade WITH .F., "PRODUCAO  (gb_4c_ModoTeste = .F.)"

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO NO SETUP: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure, SAIDA, 1)
ENDTRY

QUIT

*------------------------------------------------------------------------------
PROCEDURE MedirPolaridade(par_lModoTeste, par_cRotulo)
*------------------------------------------------------------------------------
    LOCAL loc_oForm, loc_oErro, loc_nI, loc_nImg, loc_nPicOk, loc_oObj, loc_cErroArq

    gb_4c_ModoTeste        = par_lModoTeste
    gb_4c_ValidandoUI      = par_lModoTeste
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ico_f8_" + ;
                             IIF(par_lModoTeste, "teste", "prod") + ".txt"
    IF FILE(gc_4c_ArquivoErroTeste)
        DELETE FILE (gc_4c_ArquivoErroTeste)
    ENDIF

    STRTOFILE(CHR(13)+CHR(10)+CHR(13)+CHR(10)+ ;
        "======================================================"+CHR(13)+CHR(10)+ ;
        par_cRotulo +CHR(13)+CHR(10)+ ;
        "======================================================", SAIDA, 1)

    TRY
        loc_oForm = CREATEOBJECT("Formsigprico")

        STRTOFILE(CHR(13)+CHR(10)+"  CREATEOBJECT -> " + VARTYPE(loc_oForm), SAIDA, 1)

        IF VARTYPE(loc_oForm) = "O"
            loc_nImg   = 0
            loc_nPicOk = 0
            FOR loc_nI = 1 TO loc_oForm.ControlCount
                loc_oObj = loc_oForm.Controls(loc_nI)
                IF UPPER(loc_oObj.BaseClass) = "IMAGE"
                    loc_nImg = loc_nImg + 1
                    IF FILE(loc_oObj.Picture)
                        loc_nPicOk = loc_nPicOk + 1
                    ENDIF
                ENDIF
            ENDFOR

            STRTOFILE(CHR(13)+CHR(10)+"  INSTANCIA OK" + ;
                CHR(13)+CHR(10)+"    Caption      = [" + loc_oForm.Caption + "]" + ;
                CHR(13)+CHR(10)+"    ShowWindow   = " + TRANSFORM(loc_oForm.ShowWindow) + ;
                CHR(13)+CHR(10)+"    WindowType   = " + TRANSFORM(loc_oForm.WindowType) + ;
                CHR(13)+CHR(10)+"    Visible      = " + TRANSFORM(loc_oForm.Visible) + ;
                CHR(13)+CHR(10)+"    BO           = " + VARTYPE(loc_oForm.this_oBusinessObject) + ;
                CHR(13)+CHR(10)+"    Images       = " + TRANSFORM(loc_nImg) + ;
                                 " | Picture em disco = " + TRANSFORM(loc_nPicOk) + ;
                CHR(13)+CHR(10)+"    ControlCount = " + TRANSFORM(loc_oForm.ControlCount), SAIDA, 1)

            loc_oForm.Release()
            loc_oForm = .NULL.
        ELSE
            STRTOFILE(CHR(13)+CHR(10)+"  *** FALHOU: CREATEOBJECT nao devolveu objeto ***", SAIDA, 1)
        ENDIF

    CATCH TO loc_oErro
        STRTOFILE(CHR(13)+CHR(10)+"  *** EXCECAO: " + loc_oErro.Message + ;
            " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
            " | Proc " + loc_oErro.Procedure + " ***", SAIDA, 1)
    ENDTRY

    IF FILE(gc_4c_ArquivoErroTeste)
        STRTOFILE(CHR(13)+CHR(10)+"  DIALOGOS/ERROS SUPRIMIDOS: " + ;
            FILETOSTR(gc_4c_ArquivoErroTeste), SAIDA, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"  (nenhum dialogo/erro suprimido)", SAIDA, 1)
    ENDIF
ENDPROC
