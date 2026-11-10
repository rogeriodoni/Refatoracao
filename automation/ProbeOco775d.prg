* ProbeOco775d.prg - igual ao ProbeOco775, mas gravando CADA etapa na hora
* (STRTOFILE append), para dizer QUAL chamada pendura quando o processo eh morto.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOG "C:\4c\automation\probe_oco775d.txt"

LOCAL loc_oForm, loc_oCol, loc_nI, loc_nQtd
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_oco775d.txt"

STRTOFILE("P01 inicio" + CHR(13) + CHR(10), LOG)

CD C:\4c\projeto\app\start
DO config.prg
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")           ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")            ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpOcoBO.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpOco.prg") ADDITIVE
STRTOFILE("P02 setup OK" + CHR(13) + CHR(10), LOG, 1)

IF USED("cursor_4c_Historico")
    USE IN cursor_4c_Historico
ENDIF
CREATE CURSOR cursor_4c_Historico ( ;
    cbars N(14,0), localis C(10), ocors C(10), pesreals N(8,2), ;
    obs C(100), usuars C(10))
INSERT INTO cursor_4c_Historico (cbars, localis, ocors, pesreals, obs, usuars) ;
    VALUES (1234567890, "LOC01", "", 12.34, "", "")
INDEX ON cbars TAG CBars
GO TOP
STRTOFILE("P03 cursor OK reccount=" + TRANSFORM(RECCOUNT("cursor_4c_Historico")) + ;
          CHR(13) + CHR(10), LOG, 1)

loc_oForm = CREATEOBJECT("FormSigOpOco", 1234567890, .NULL., .T., "OBS TESTE", 100, 200)
STRTOFILE("P04 CREATEOBJECT = [" + VARTYPE(loc_oForm) + "]" + CHR(13) + CHR(10), LOG, 1)

IF VARTYPE(loc_oForm) # "O"
    STRTOFILE("FALHOU: form nao instanciou" + CHR(13) + CHR(10), LOG, 1)
    QUIT
ENDIF

STRTOFILE("P05 ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P06 RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
          CHR(13) + CHR(10), LOG, 1)

loc_oCol = loc_oForm.grd_4c_Dados.Column3
STRTOFILE("P07 Col3.ControlSource=[" + loc_oCol.ControlSource + "]" + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P08 Col3.CurrentControl=[" + loc_oCol.CurrentControl + "]" + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P09 Col3.Sparse=" + TRANSFORM(loc_oCol.Sparse) + ;
          " Col3.ReadOnly=" + TRANSFORM(loc_oCol.ReadOnly) + ;
          " Col3.Width=" + TRANSFORM(loc_oCol.Width) + ;
          " Header=[" + loc_oCol.Header1.Caption + "]" + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P10 tem celula=" + TRANSFORM(PEMSTATUS(loc_oCol, "txt_4c_Ocorrencia", 5)) + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P11 celula Class=[" + loc_oCol.txt_4c_Ocorrencia.Class + ;
          "] MaxLength=" + TRANSFORM(loc_oCol.txt_4c_Ocorrencia.MaxLength) + ;
          " Visible=" + TRANSFORM(loc_oCol.txt_4c_Ocorrencia.Visible) + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P12 GetObs Class=[" + loc_oForm.obj_4c_Get_Obs.Class + ;
          "] CtrlSource=[" + loc_oForm.obj_4c_Get_Obs.ControlSource + "]" + ;
          CHR(13) + CHR(10), LOG, 1)

STRTOFILE("P13 (AEVENTS omitido: forma de argumento dispara dialogo modal)" + ;
          CHR(13) + CHR(10), LOG, 1)

STRTOFILE("P14 PEMSTATUS  ValidarOcorrenciaGrade=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ValidarOcorrenciaGrade", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ValidarOcorrenciaGrade", 2)) + ;
          "  AbrirBuscaOcorrencia=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "AbrirBuscaOcorrencia", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "AbrirBuscaOcorrencia", 2)) + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P15 PEMSTATUS  PodeEditarObservacao=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "PodeEditarObservacao", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "PodeEditarObservacao", 2)) + ;
          "  ObservacaoLostFocus=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ObservacaoLostFocus", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ObservacaoLostFocus", 2)) + ;
          "  FocarObservacao=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "FocarObservacao", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "FocarObservacao", 2)) + ;
          CHR(13) + CHR(10), LOG, 1)

STRTOFILE("P16 antes de Valid(vazio)" + CHR(13) + CHR(10), LOG, 1)
loc_oCol.txt_4c_Ocorrencia.Value = ""
STRTOFILE("P17 Value limpo" + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P18 Valid(vazio)=" + ;
          TRANSFORM(loc_oForm.ValidarOcorrenciaGrade(loc_oCol.txt_4c_Ocorrencia)) + ;
          CHR(13) + CHR(10), LOG, 1)

STRTOFILE("P19 When(ocors vazio)=" + ;
          TRANSFORM(loc_oForm.PodeEditarObservacao()) + CHR(13) + CHR(10), LOG, 1)

SELECT cursor_4c_Historico
REPLACE ocors WITH "OC01"
loc_oCol.txt_4c_Ocorrencia.Value = "OC01"
loc_oForm.obj_4c_Get_Obs.Value   = ""
STRTOFILE("P20 ocors preenchido" + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P21 When(ocors cheio)=" + ;
          TRANSFORM(loc_oForm.PodeEditarObservacao()) + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P22 auto-preencheu obs=[" + ;
          ALLTRIM(loc_oForm.obj_4c_Get_Obs.Value) + "]" + CHR(13) + CHR(10), LOG, 1)

loc_oForm.obj_4c_Get_Obs.Value = "NOVA OBS"
loc_oForm.ObservacaoLostFocus()
STRTOFILE("P23 this_cObservas=[" + ALLTRIM(loc_oForm.this_cObservas) + ;
          "] BO=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cObservas) + "]" + ;
          CHR(13) + CHR(10), LOG, 1)

loc_oForm.CarregarDados()
STRTOFILE("P24 pos-recarga CurrentControl=[" + ;
          loc_oForm.grd_4c_Dados.Column3.CurrentControl + "] Width=" + ;
          TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Width) + " Header=[" + ;
          loc_oForm.grd_4c_Dados.Column3.Header1.Caption + "]" + ;
          CHR(13) + CHR(10), LOG, 1)

*-- P25: o BINDEVENT dispara de verdade? Zera o estado, mexe no valor e
*--      aciona o EVENTO (nao o handler) - se this_cObservas mudar, a ligacao
*--      LostFocus -> ObservacaoLostFocus esta viva.
loc_oForm.this_cObservas       = "ZERADO"
loc_oForm.obj_4c_Get_Obs.Value = "VIA BINDEVENT"
loc_oForm.obj_4c_Get_Obs.LostFocus()
STRTOFILE("P25 apos disparar LostFocus: this_cObservas=[" + ;
          ALLTRIM(loc_oForm.this_cObservas) + "]" + CHR(13) + CHR(10), LOG, 1)

loc_oForm.Release()
loc_oForm = .NULL.
STRTOFILE("P26 FIM OK" + CHR(13) + CHR(10), LOG, 1)

QUIT
