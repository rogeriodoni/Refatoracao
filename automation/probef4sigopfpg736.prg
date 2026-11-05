*==============================================================================
* probef4sigopfpg736.prg - Exercita em RUNTIME a Fase 4 do FormSigOpFpg
* (task736): grd_4c_Dados (5 colunas sobre cursor_4c_Dados) + botoes
* cmd_4c_Apaga/cmd_4c_Ok/cmd_4c_Cancela.
*
* Setup conforme a receita medida nesta maquina: NAO chamar
* ConfigurarAmbiente() - DO config.prg + SET PATH + SET PROCEDURE a mao do
* que o form usa, mais PUBLIC gnConnHandle. gb_4c_ModoTeste +
* gc_4c_ArquivoErroTeste SEMPRE em par, senao MsgAviso cai num MESSAGEBOX
* real e o processo trava sem produzir resultado.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m736\probe_f4_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m736\probe_f4_sigopfpg.txt"
loc_cOut = "=== PROBE Fase 4 - FormSigOpFpg (task736) ===" + CHR(13) + CHR(10)

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
    *-- Mesma assinatura do Init: par_oFormPai, par_nDataSessionPai, par_lAltDireta
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

*-- [3] Cursor local da grade
IF USED("cursor_4c_Dados")
    loc_cOut = loc_cOut + "[3] cursor_4c_Dados existe - campos: " + ;
        TRANSFORM(AFIELDS(loc_aCampos, "cursor_4c_Dados")) + CHR(13) + CHR(10)
    LOCAL loc_nF
    FOR loc_nF = 1 TO ALEN(loc_aCampos, 1)
        loc_cOut = loc_cOut + "    " + loc_aCampos[loc_nF, 1] + " " + ;
            loc_aCampos[loc_nF, 2] + "(" + TRANSFORM(loc_aCampos[loc_nF, 3]) + ;
            "," + TRANSFORM(loc_aCampos[loc_nF, 4]) + ")" + CHR(13) + CHR(10)
    ENDFOR
ELSE
    loc_cOut = loc_cOut + "[3] FALHA - cursor_4c_Dados NAO existe" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] Grid
IF PEMSTATUS(loc_oForm, "grd_4c_Dados", 5)
    WITH loc_oForm.grd_4c_Dados
        loc_cOut = loc_cOut + "[4] grd_4c_Dados OK - ColumnCount=" + ;
            TRANSFORM(.ColumnCount) + " RecordSource=[" + .RecordSource + ;
            "] ReadOnly=" + TRANSFORM(.ReadOnly) + " RecordMark=" + ;
            TRANSFORM(.RecordMark) + " DeleteMark=" + TRANSFORM(.DeleteMark) + ;
            CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "    Col1=[" + .Column1.ControlSource + ;
            "] W=" + TRANSFORM(.Column1.Width) + " RO=" + TRANSFORM(.Column1.ReadOnly) + ;
            " Hdr=[" + .Column1.Header1.Caption + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "    Col2=[" + .Column2.ControlSource + ;
            "] W=" + TRANSFORM(.Column2.Width) + " Mask=[" + .Column2.InputMask + ;
            "] Hdr=[" + .Column2.Header1.Caption + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "    Col3=[" + .Column3.ControlSource + ;
            "] W=" + TRANSFORM(.Column3.Width) + " Order=" + TRANSFORM(.Column3.ColumnOrder) + ;
            " Hdr=[" + .Column3.Header1.Caption + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "    Col4=[" + .Column4.ControlSource + ;
            "] W=" + TRANSFORM(.Column4.Width) + " Order=" + TRANSFORM(.Column4.ColumnOrder) + ;
            " Hdr=[" + .Column4.Header1.Caption + "]" + CHR(13) + CHR(10)
        loc_cOut = loc_cOut + "    Col5=[" + .Column5.ControlSource + ;
            "] W=" + TRANSFORM(.Column5.Width) + " Order=" + TRANSFORM(.Column5.ColumnOrder) + ;
            " Mask=[" + .Column5.InputMask + "] Hdr=[" + .Column5.Header1.Caption + ;
            "]" + CHR(13) + CHR(10)
    ENDWITH
ELSE
    loc_cOut = loc_cOut + "[4] FALHA - grd_4c_Dados NAO existe" + CHR(13) + CHR(10)
ENDIF
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] Botoes
LOCAL loc_nI
LOCAL ARRAY loc_aBtn[3]
loc_aBtn[1] = "cmd_4c_Apaga"
loc_aBtn[2] = "cmd_4c_Ok"
loc_aBtn[3] = "cmd_4c_Cancela"
FOR loc_nI = 1 TO ALEN(loc_aBtn, 1)
    IF PEMSTATUS(loc_oForm, loc_aBtn[loc_nI], 5)
        loc_cOut = loc_cOut + "[5] " + loc_aBtn[loc_nI] + " OK - Left=" + ;
            TRANSFORM(EVALUATE("loc_oForm." + loc_aBtn[loc_nI] + ".Left")) + ;
            " Top=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aBtn[loc_nI] + ".Top")) + ;
            " Picture=[" + EVALUATE("loc_oForm." + loc_aBtn[loc_nI] + ".Picture") + ;
            "] Visible=" + TRANSFORM(EVALUATE("loc_oForm." + loc_aBtn[loc_nI] + ".Visible")) + ;
            CHR(13) + CHR(10)
    ELSE
        loc_cOut = loc_cOut + "[5] FALHA - " + loc_aBtn[loc_nI] + " NAO existe" + CHR(13) + CHR(10)
    ENDIF
ENDFOR
STRTOFILE(loc_cOut, loc_cLog)

loc_oForm.Release()
loc_cOut = loc_cOut + "[6] Form liberado - FIM" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
