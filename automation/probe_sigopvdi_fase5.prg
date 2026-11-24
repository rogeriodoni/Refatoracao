*-- Probe da Fase 5/8 (Parte 1) do FormSigOpVdi: compila BO+Form e instancia
*-- em modo gb_4c_ValidandoUI (sem SQL - CarregarFiltrosIniciais/CarregarDados
*-- sao pulados), e confere os campos de Periodo/Moeda recem-adicionados:
*-- existencia, valores iniciais (BOParaFormFiltros) e sincronizacao de
*-- volta ao BO via LostFocus (TxtDataIniLostFocus/TxtDataFimLostFocus/
*-- TxtCodMoedaLostFocus). Mesmo padrao do automation\CompileCheckMluF8.prg.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

LOCAL loc_cBO, loc_cForm, loc_cFxpBO, loc_cFxpForm

loc_cBO      = "C:\4c\projeto\app\classes\SigOpVdiBO.prg"
loc_cForm    = "C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.prg"
loc_cFxpBO   = "C:\4c\projeto\app\classes\sigopvdibo.FXP"
loc_cFxpForm = "C:\4c\projeto\app\forms\operacionais\formsigopvdi.FXP"

IF FILE(loc_cFxpBO)
    DELETE FILE (loc_cFxpBO)
ENDIF
IF FILE(loc_cFxpForm)
    DELETE FILE (loc_cFxpForm)
ENDIF
IF FILE("C:\4c\projeto\app\classes\SigOpVdiBO.err")
    DELETE FILE "C:\4c\projeto\app\classes\SigOpVdiBO.err"
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.err")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.err"
ENDIF

COMPILE (loc_cBO)
COMPILE (loc_cForm)

LOCAL loc_cErrBO, loc_cErrForm, loc_cSaida
loc_cErrBO   = ""
loc_cErrForm = ""
IF FILE("C:\4c\projeto\app\classes\SigOpVdiBO.err")
    loc_cErrBO = FILETOSTR("C:\4c\projeto\app\classes\SigOpVdiBO.err")
ENDIF
IF FILE("C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.err")
    loc_cErrForm = FILETOSTR("C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.err")
ENDIF

loc_cSaida = "FXP_BO="   + IIF(FILE(loc_cFxpBO),   "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "FXP_FORM=" + IIF(FILE(loc_cFxpForm), "SIM", "NAO") + CHR(13) + CHR(10) + ;
             "ERR_BO=["   + ALLTRIM(loc_cErrBO)   + "]" + CHR(13) + CHR(10) + ;
             "ERR_FORM=[" + ALLTRIM(loc_cErrForm) + "]" + CHR(13) + CHR(10)

IF EMPTY(ALLTRIM(loc_cErrBO)) AND EMPTY(ALLTRIM(loc_cErrForm)) ;
   AND FILE(loc_cFxpBO) AND FILE(loc_cFxpForm)
    loc_cSaida = loc_cSaida + "COMPILE_OK" + CHR(13) + CHR(10)
ELSE
    loc_cSaida = loc_cSaida + "COMPILE_FAIL" + CHR(13) + CHR(10)
    STRTOFILE(loc_cSaida, "C:\4c\automation\probe_sigopvdi_fase5.txt")
    QUIT
ENDIF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_sigopvdi_fase5_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD C:\4c\projeto\app\start
DO config.prg

gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpVdiBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpVdi.prg") ADDITIVE

LOCAL loc_oForm, loc_oErro, loc_cProbe, loc_oPag
loc_cProbe = ""

TRY
    loc_oForm = CREATEOBJECT("FormSigOpVdi")
    loc_cProbe = loc_cProbe + "VARTYPE_FORM=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oForm) = "O"
        loc_oPag = loc_oForm.pgf_4c_Paginas.Page1

        loc_cProbe = loc_cProbe + "PEM_LBL_PERIODO="  + TRANSFORM(PEMSTATUS(loc_oPag, "lbl_4c_Periodo", 5))        + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_LBL_AT="       + TRANSFORM(PEMSTATUS(loc_oPag, "lbl_4c_At", 5))             + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_LBL_MOEDA="    + TRANSFORM(PEMSTATUS(loc_oPag, "lbl_4c_MoedaConversao", 5)) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_TXT_DATAINI="  + TRANSFORM(PEMSTATUS(loc_oPag, "txt_4c_DataIni", 5))        + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_TXT_DATAFIM="  + TRANSFORM(PEMSTATUS(loc_oPag, "txt_4c_DataFim", 5))        + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_TXT_CODMOEDA=" + TRANSFORM(PEMSTATUS(loc_oPag, "txt_4c_CodMoeda", 5))       + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "PEM_TXT_DESCMOEDA="+ TRANSFORM(PEMSTATUS(loc_oPag, "txt_4c_DescMoeda", 5))      + CHR(13) + CHR(10)

        *-- BOParaFormFiltros deve ter copiado DATE()/DATE() do BO (AplicarFiltrosPadrao
        *-- roda incondicionalmente no Init do BO, sem depender de SQL)
        loc_cProbe = loc_cProbe + "DATAINI_FORM=" + TRANSFORM(loc_oPag.txt_4c_DataIni.Value) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "DATAFIM_FORM=" + TRANSFORM(loc_oPag.txt_4c_DataFim.Value) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "DATAINI_BO="   + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataIni) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "DATAFIM_BO="   + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFim) + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "IGUAIS_DATAS=" + TRANSFORM(loc_oPag.txt_4c_DataIni.Value == loc_oForm.this_oBusinessObject.this_dDataIni) + CHR(13) + CHR(10)

        *-- Simula o usuario digitando uma nova data inicial e saindo do campo
        loc_oPag.txt_4c_DataIni.Value = DATE() - 10
        loc_oForm.TxtDataIniLostFocus()
        loc_cProbe = loc_cProbe + "DATAINI_BO_APOS_EDIT=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataIni) + CHR(13) + CHR(10)

        *-- Simula o usuario digitando um codigo de moeda em minuscula/com espacos
        loc_oPag.txt_4c_CodMoeda.Value = "  usd  "
        loc_oForm.TxtCodMoedaLostFocus()
        loc_cProbe = loc_cProbe + "CODMOEDA_FORM_APOS_EDIT=[" + loc_oPag.txt_4c_CodMoeda.Value + "]" + CHR(13) + CHR(10)
        loc_cProbe = loc_cProbe + "MOEDA_BO_APOS_EDIT=["      + loc_oForm.this_oBusinessObject.this_cMoeda + "]" + CHR(13) + CHR(10)

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_cProbe = loc_cProbe + "EXCECAO=[" + loc_oErro.Message + "] LINHA=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF FILE("C:\4c\automation\probe_sigopvdi_fase5_erros.txt")
    loc_cProbe = loc_cProbe + "MSG_CAPTURADAS=[" + ;
        ALLTRIM(FILETOSTR("C:\4c\automation\probe_sigopvdi_fase5_erros.txt")) + "]" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida + loc_cProbe, "C:\4c\automation\probe_sigopvdi_fase5.txt")
QUIT
