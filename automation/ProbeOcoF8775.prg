* ProbeOcoF8775.prg - prova a superficie da FASE 8 do FormSigOpOco (task775):
* celula de Peso Real (Column4), BINDEVENT de AfterRowColChange e os dois
* handlers novos. Grava CADA etapa na hora (STRTOFILE append), para dizer QUAL
* chamada pendura quando o processo eh morto.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOG "C:\4c\automation\probe_oco_f8_775.txt"

LOCAL loc_oForm, loc_oCol, loc_nI, loc_cBind
LOCAL ARRAY laEv[1, 5]
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_oco_f8_775.txt"

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
    VALUES (1234567890, "LOC01", "OC01", 12.34, "OBS LINHA 1", "")
INSERT INTO cursor_4c_Historico (cbars, localis, ocors, pesreals, obs, usuars) ;
    VALUES (1234567890, "LOC02", "OC02", 56.78, "OBS LINHA 2", "")
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

*-- Celula de Peso Real (regra #18: AddObject + CurrentControl + Sparse + Visible)
loc_oCol = loc_oForm.grd_4c_Dados.Column4
STRTOFILE("P05 Col4.ControlSource=[" + loc_oCol.ControlSource + "]" + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P06 Col4.CurrentControl=[" + loc_oCol.CurrentControl + "]" + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P07 Col4.Sparse=" + TRANSFORM(loc_oCol.Sparse) + ;
          " Col4.ReadOnly=" + TRANSFORM(loc_oCol.ReadOnly) + ;
          " Col4.Width=" + TRANSFORM(loc_oCol.Width) + ;
          " Col4.InputMask=[" + loc_oCol.InputMask + "]" + ;
          " Header=[" + loc_oCol.Header1.Caption + "]" + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P08 tem celula=" + TRANSFORM(PEMSTATUS(loc_oCol, "txt_4c_PesoReal", 5)) + ;
          CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P09 celula Class=[" + loc_oCol.txt_4c_PesoReal.Class + ;
          "] VARTYPE(Value)=[" + VARTYPE(loc_oCol.txt_4c_PesoReal.Value) + ;
          "] Value=" + TRANSFORM(loc_oCol.txt_4c_PesoReal.Value) + ;
          " InputMask=[" + loc_oCol.txt_4c_PesoReal.InputMask + ;
          "] Visible=" + TRANSFORM(loc_oCol.txt_4c_PesoReal.Visible) + ;
          CHR(13) + CHR(10), LOG, 1)

*-- Column3 continua intacta (a Fase 8 nao podia mexer nela)
STRTOFILE("P10 Col3.CurrentControl=[" + loc_oForm.grd_4c_Dados.Column3.CurrentControl + ;
          "] Col3.Width=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column3.Width) + ;
          CHR(13) + CHR(10), LOG, 1)

*-- Escopo dos metodos novos (regras #3/#51 - delegate e chamada de fora)
STRTOFILE("P11 PEMSTATUS ConfirmarPesoReal=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ConfirmarPesoReal", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "ConfirmarPesoReal", 2)) + ;
          "  GradeAfterRowColChange=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "GradeAfterRowColChange", 5)) + "/prot=" + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "GradeAfterRowColChange", 2)) + ;
          CHR(13) + CHR(10), LOG, 1)

*-- BINDEVENT REGISTRADO (AEVENTS: col 3 = evento, col 4 = metodo; NUNCA col 2,
*-- que eh OBJETO)
loc_nI    = AEVENTS(laEv, loc_oForm.grd_4c_Dados)
loc_cBind = ""
FOR loc_nI = 1 TO ALEN(laEv, 1)
    IF VARTYPE(laEv[loc_nI, 3]) = "C"
        loc_cBind = loc_cBind + ALLTRIM(laEv[loc_nI, 3]) + "->" + ;
                    ALLTRIM(laEv[loc_nI, 4]) + " "
    ENDIF
ENDFOR
STRTOFILE("P12 bindings do grid: " + loc_cBind + CHR(13) + CHR(10), LOG, 1)

*-- O evento DISPARA de verdade? Aciona o EVENTO (nao o handler).
loc_oForm.grd_4c_Dados.AfterRowColChange(4)
STRTOFILE("P13 AfterRowColChange(4) disparado sem erro" + CHR(13) + CHR(10), LOG, 1)

*-- Handler direto, com o EditBox existindo
STRTOFILE("P14 GradeAfterRowColChange(4)=" + ;
          TRANSFORM(loc_oForm.GradeAfterRowColChange(4)) + CHR(13) + CHR(10), LOG, 1)

*-- ConfirmarPesoReal: com LASTKEY() # 27 tem de ENFILEIRAR {DNARROW}.
*-- CHRSAW() prova que a tecla entrou no buffer; INKEY(0) drena.
CLEAR TYPEAHEAD
STRTOFILE("P15 antes: CHRSAW=" + TRANSFORM(CHRSAW()) + ;
          " LASTKEY=" + TRANSFORM(LASTKEY()) + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P16 ConfirmarPesoReal()=" + ;
          TRANSFORM(loc_oForm.ConfirmarPesoReal()) + CHR(13) + CHR(10), LOG, 1)
STRTOFILE("P17 depois: CHRSAW=" + TRANSFORM(CHRSAW()) + ;
          "  (.T. = DNARROW enfileirado)" + CHR(13) + CHR(10), LOG, 1)
loc_nI = INKEY(0)
STRTOFILE("P18 tecla drenada=" + TRANSFORM(loc_nI) + ;
          "  (24 = DNARROW)  CHRSAW agora=" + TRANSFORM(CHRSAW()) + ;
          CHR(13) + CHR(10), LOG, 1)

*-- Sem alias aberto NAO enfileira (senao a tecla vaza para o proximo controle)
CLEAR TYPEAHEAD
loc_oForm.this_cCursorHistorico = "cursor_4c_Inexistente"
STRTOFILE("P19 sem alias: ConfirmarPesoReal()=" + ;
          TRANSFORM(loc_oForm.ConfirmarPesoReal()) + ;
          " CHRSAW=" + TRANSFORM(CHRSAW()) + "  (esperado .F.)" + ;
          CHR(13) + CHR(10), LOG, 1)
loc_oForm.this_cCursorHistorico = "cursor_4c_Historico"
CLEAR TYPEAHEAD

*-- Recarga: a celula tem de SOBREVIVER ao ColumnCount de VincularGrade (#18)
loc_oForm.CarregarDados()
STRTOFILE("P20 pos-recarga Col4.CurrentControl=[" + ;
          loc_oForm.grd_4c_Dados.Column4.CurrentControl + "] Width=" + ;
          TRANSFORM(loc_oForm.grd_4c_Dados.Column4.Width) + " Header=[" + ;
          loc_oForm.grd_4c_Dados.Column4.Header1.Caption + "] Sparse=" + ;
          TRANSFORM(loc_oForm.grd_4c_Dados.Column4.Sparse) + ;
          CHR(13) + CHR(10), LOG, 1)
loc_nI = AEVENTS(laEv, loc_oForm.grd_4c_Dados)
STRTOFILE("P21 pos-recarga bindings do grid=" + TRANSFORM(loc_nI) + ;
          CHR(13) + CHR(10), LOG, 1)

*-- A celula de Peso Real delega de verdade (Valid da classe -> metodo do form)
CLEAR TYPEAHEAD
loc_oForm.grd_4c_Dados.Column4.txt_4c_PesoReal.Valid()
STRTOFILE("P22 Valid da celula disparado; CHRSAW=" + TRANSFORM(CHRSAW()) + ;
          "  (.T. = delegou e enfileirou)" + CHR(13) + CHR(10), LOG, 1)
CLEAR TYPEAHEAD

loc_oForm.Release()
loc_oForm = .NULL.
STRTOFILE("P23 FIM OK" + CHR(13) + CHR(10), LOG, 1)

QUIT
