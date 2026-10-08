*==============================================================================
* ProbeIcoF7.prg - Instancia Formsigprico headless (Fase 7 / task624) e confere
* o catalogo de 24 Image contra o dump do legado.
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina; carrega a mao
* so as dependencias do form (licao do probe de instanciacao).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ico_f7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

#DEFINE SAIDA "C:\4c\automation\probe_ico_f7_result.txt"
LOCAL loc_oForm, loc_oErro, loc_nI, loc_nImg, loc_nPicOk, loc_oObj, loc_cLista
STRTOFILE("INICIO", SAIDA)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    STRTOFILE(CHR(13)+CHR(10)+"config OK", SAIDA, 1)

    *-- config.prg reseta as flags de teste - repor DEPOIS do DO
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

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

    loc_oForm = CREATEOBJECT("Formsigprico")
    STRTOFILE(CHR(13)+CHR(10)+"createobject retornou " + VARTYPE(loc_oForm), SAIDA, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_nImg   = 0
        loc_nPicOk = 0
        loc_cLista = ""
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            loc_oObj = loc_oForm.Controls(loc_nI)
            IF UPPER(loc_oObj.BaseClass) = "IMAGE"
                loc_nImg = loc_nImg + 1
                loc_cLista = loc_cLista + CHR(13) + CHR(10) + "  " + ;
                    PADR(loc_oObj.Name, 16) + ;
                    " Top=" + PADL(TRANSFORM(loc_oObj.Top), 4) + ;
                    " Left=" + PADL(TRANSFORM(loc_oObj.Left), 4) + ;
                    " W=" + TRANSFORM(loc_oObj.Width) + ;
                    " H=" + TRANSFORM(loc_oObj.Height) + ;
                    " Str=" + TRANSFORM(loc_oObj.Stretch) + ;
                    " Vis=" + TRANSFORM(loc_oObj.Visible) + ;
                    " Pic=" + JUSTFNAME(loc_oObj.Picture) + ;
                    IIF(FILE(loc_oObj.Picture), "", "  <<< ARQUIVO AUSENTE")
                IF FILE(loc_oObj.Picture)
                    loc_nPicOk = loc_nPicOk + 1
                ENDIF
            ENDIF
        ENDFOR

        STRTOFILE(CHR(13) + CHR(10) + "INSTANCIA OK" + ;
            CHR(13) + CHR(10) + "  Caption   = [" + loc_oForm.Caption + "]" + ;
            CHR(13) + CHR(10) + "  BaseClass = [" + loc_oForm.BaseClass + "]" + ;
            CHR(13) + CHR(10) + "  W/H       = " + TRANSFORM(loc_oForm.Width) + "/" + TRANSFORM(loc_oForm.Height) + ;
            CHR(13) + CHR(10) + "  BO        = " + VARTYPE(loc_oForm.this_oBusinessObject) + ;
            CHR(13) + CHR(10) + "  Images    = " + TRANSFORM(loc_nImg) + ;
                                " | Picture existente = " + TRANSFORM(loc_nPicOk) + ;
            CHR(13) + CHR(10) + "  ControlCount total = " + TRANSFORM(loc_oForm.ControlCount) + ;
            loc_cLista, SAIDA, 1)

        loc_oForm.Release()
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure, SAIDA, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(CHR(13) + CHR(10) + "ERRO RUNTIME CAPTURADO: " + ;
        FILETOSTR(gc_4c_ArquivoErroTeste), SAIDA, 1)
ENDIF

QUIT
