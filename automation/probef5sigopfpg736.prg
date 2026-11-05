*==============================================================================
* probef5sigopfpg736.prg - Exercita em RUNTIME a Fase 5 do FormSigOpFpg
* (task736): os campos do cabecalho adicionados em ConfigurarCampos().
*
* Mesma receita medida na maquina (ver probef4sigopfpg736.prg): NAO chamar
* ConfigurarAmbiente() - DO config.prg + SET PATH/SET PROCEDURE a mao, mais
* gb_4c_ModoTeste + gc_4c_ArquivoErroTeste sempre em par.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m736\probe_f5_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m736\probe_f5_sigopfpg.txt"
loc_cOut = "=== PROBE Fase 5 - FormSigOpFpg (task736) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFpgBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFpg.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro

TRY
    loc_oForm = CREATEOBJECT("FormSigOpFpg", .NULL., 0, .F.)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) <> "O"
    loc_cOut = loc_cOut + "[2] Form NAO instanciado - VARTYPE = " + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF

loc_cOut = loc_cOut + "[2] Form instanciado OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

loc_cOut = loc_cOut + "[2b] antes do array" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [3] Campos (TextBox/EditBox) + labels
LOCAL loc_nI
LOCAL ARRAY loc_aCtrl[12]
loc_aCtrl[1]  = "txt_4c_Fpg"
loc_aCtrl[2]  = "txt_4c_Npar"
loc_aCtrl[3]  = "txt_4c_Porc"
loc_aCtrl[4]  = "txt_4c_MoeOcr"
loc_aCtrl[5]  = "txt_4c_COTACAO"
loc_aCtrl[6]  = "txt_4c_Vpar"
loc_aCtrl[7]  = "txt_4c_PEncargo"
loc_aCtrl[8]  = "txt_4c_VEncargo"
loc_aCtrl[9]  = "txt_4c_Fweditdata_venc"
loc_aCtrl[10] = "txt_4c_MoeOper"
loc_aCtrl[11] = "txt_4c_ValTotChqs"
loc_aCtrl[12] = "txt_4c_TotForma"

FOR loc_nI = 1 TO ALEN(loc_aCtrl, 1)
    loc_cOut = loc_cOut + "[3-CK" + TRANSFORM(loc_nI) + "] antes de " + loc_aCtrl[loc_nI] + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    IF PEMSTATUS(loc_oForm, loc_aCtrl[loc_nI], 5)
        loc_cOut = loc_cOut + "[3] " + loc_aCtrl[loc_nI] + " OK - Left=" + ;
            TRANSFORM(EVALUATE("loc_oForm." + loc_aCtrl[loc_nI] + ".Left")) + ;
            " Top=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aCtrl[loc_nI] + ".Top")) + ;
            " Width=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aCtrl[loc_nI] + ".Width")) + ;
            " Visible=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aCtrl[loc_nI] + ".Visible")) + ;
            " Value=[" + TRANSFORM(EVALUATE("loc_oForm." + loc_aCtrl[loc_nI] + ".Value")) + "]" + ;
            CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "[3] FALHA - " + loc_aCtrl[loc_nI] + " NAO existe" + CHR(13) + CHR(10)
    ENDIF
    STRTOFILE(loc_cOut, loc_cLog)
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [3b] cmd_4c_Alteracotacao (CommandButton - sem .Value)
IF PEMSTATUS(loc_oForm, "cmd_4c_Alteracotacao", 5)
    loc_cOut = loc_cOut + "[3b] cmd_4c_Alteracotacao OK - Left=" + ;
        TRANSFORM(loc_oForm.cmd_4c_Alteracotacao.Left) + ;
        " Top=" + TRANSFORM(loc_oForm.cmd_4c_Alteracotacao.Top) + ;
        " Caption=[" + loc_oForm.cmd_4c_Alteracotacao.Caption + "]" + ;
        " Visible=" + TRANSFORM(loc_oForm.cmd_4c_Alteracotacao.Visible) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[3b] FALHA - cmd_4c_Alteracotacao NAO existe" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] GetObs (EditBox) + label
IF PEMSTATUS(loc_oForm, "obj_4c_GetObs", 5)
    loc_cOut = loc_cOut + "[4] obj_4c_GetObs OK - Visible=" + ;
        TRANSFORM(loc_oForm.obj_4c_GetObs.Visible) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[4] FALHA - obj_4c_GetObs NAO existe" + CHR(13) + CHR(10)
ENDIF
IF PEMSTATUS(loc_oForm, "lbl_4c_Obs", 5)
    loc_cOut = loc_cOut + "[4] lbl_4c_Obs OK - Caption=[" + loc_oForm.lbl_4c_Obs.Caption + ;
        "] Visible=" + TRANSFORM(loc_oForm.lbl_4c_Obs.Visible) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[4] FALHA - lbl_4c_Obs NAO existe" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] Labels principais (amostra)
LOCAL ARRAY loc_aLbl[4]
loc_aLbl[1] = "lbl_4c_Label12"
loc_aLbl[2] = "lbl_4c_Label13"
loc_aLbl[3] = "lbl_4c__Cotacao"
loc_aLbl[4] = "lbl_4c_Label23"
FOR loc_nI = 1 TO ALEN(loc_aLbl, 1)
    IF PEMSTATUS(loc_oForm, loc_aLbl[loc_nI], 5)
        loc_cOut = loc_cOut + "[5] " + loc_aLbl[loc_nI] + " OK - Caption=[" + ;
            EVALUATE("loc_oForm." + loc_aLbl[loc_nI] + ".Caption") + ;
            "] Width=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aLbl[loc_nI] + ".Width")) + ;
            " Visible=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aLbl[loc_nI] + ".Visible")) + ;
            CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "[5] FALHA - " + loc_aLbl[loc_nI] + " NAO existe" + CHR(13) + CHR(10)
    ENDIF
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] Imagens de aviso
LOCAL ARRAY loc_aImg[3]
loc_aImg[1] = "img_4c_AvisoPortaM"
loc_aImg[2] = "img_4c_AvisoPortaT"
loc_aImg[3] = "img_4c_AvisoPortaS"
FOR loc_nI = 1 TO ALEN(loc_aImg, 1)
    IF PEMSTATUS(loc_oForm, loc_aImg[loc_nI], 5)
        loc_cOut = loc_cOut + "[6] " + loc_aImg[loc_nI] + " OK - Picture=[" + ;
            EVALUATE("loc_oForm." + loc_aImg[loc_nI] + ".Picture") + "]" + ;
            " PictureExiste=" + TRANSFORM(FILE(EVALUATE("loc_oForm." + loc_aImg[loc_nI] + ".Picture"))) + ;
            CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "[6] FALHA - " + loc_aImg[loc_nI] + " NAO existe" + CHR(13) + CHR(10)
    ENDIF
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] Grid e botoes da Fase 4 continuam intactos?
IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
    loc_cOut = loc_cOut + "[7] grd_4c_Dados ainda OK - ColumnCount=" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
ELSE
    loc_cOut = loc_cOut + "[7] FALHA - grd_4c_Dados sumiu" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

loc_oForm.Release()
loc_cOut = loc_cOut + "[8] Form liberado - FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
