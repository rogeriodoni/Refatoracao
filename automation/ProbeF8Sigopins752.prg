*-- Probe Fase 8 - task752 / FormSIGOPins
*-- Prova: (1) o form INSTANCIA, (2) BOParaForm() rodou de fato (Caption nos dois
*-- labels + chk_4c_Pular vindo do BO), (3) os tres nomes da Fase 8 existem como
*-- METODO (nao como substring de comentario) e com o escopo certo.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f8_752_probe_dialogs.txt"
gnConnHandle           = 0

LOCAL lcOut, loForm, loErro

lcOut = ""

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
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPinsBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGOPins.prg") ADDITIVE

lcOut = lcOut + "DEPENDENCIAS CARREGADAS" + CHR(13) + CHR(10)

TRY
    *-- Fluxo FINALIDADES (pLista informado) - nao depende de TprMvCab
    loForm = CREATEOBJECT("FormSIGOPins", "", "GRP", "Finalidades do Grupo")

    lcOut = lcOut + "VARTYPE(loForm)     = " + VARTYPE(loForm) + CHR(13) + CHR(10)

    IF VARTYPE(loForm) = "O"
        lcOut = lcOut + "BaseClass           = " + loForm.BaseClass + CHR(13) + CHR(10)
        lcOut = lcOut + "Caption             = [" + loForm.Caption + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "lblSombra.Caption   = [" + ;
            loForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "lblTitulo.Caption   = [" + ;
            loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10)

        *-- BOParaForm: tipo E valor do chk_4c_Pular vindos do BO
        lcOut = lcOut + "chkPular VARTYPE    = " + ;
            VARTYPE(loForm.chk_4c_Pular.Value) + CHR(13) + CHR(10)
        lcOut = lcOut + "chkPular Value      = " + ;
            TRANSFORM(loForm.chk_4c_Pular.Value) + CHR(13) + CHR(10)
        lcOut = lcOut + "BO.this_lPularLinhas= " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_lPularLinhas) + CHR(13) + CHR(10)

        *-- Nomes exigidos pela Fase 8: existencia (5) e escopo PROTECTED (2)
        lcOut = lcOut + "BtnCancelarClick ex = " + ;
            TRANSFORM(PEMSTATUS(loForm, "BtnCancelarClick", 5)) + CHR(13) + CHR(10)
        lcOut = lcOut + "BtnConfirmarClick ex= " + ;
            TRANSFORM(PEMSTATUS(loForm, "BtnConfirmarClick", 5)) + CHR(13) + CHR(10)
        lcOut = lcOut + "CarregarLista ex    = " + ;
            TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 5)) + ;
            "  prot=" + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + CHR(13) + CHR(10)
        lcOut = lcOut + "FormParaBO ex       = " + ;
            TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 5)) + ;
            "  prot=" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 2)) + CHR(13) + CHR(10)
        lcOut = lcOut + "BOParaForm ex       = " + ;
            TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 5)) + ;
            "  prot=" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 2)) + CHR(13) + CHR(10)

        *-- Grade ligada?
        lcOut = lcOut + "Grid ColumnCount    = " + ;
            TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + CHR(13) + CHR(10)
        lcOut = lcOut + "Grid RecordSource   = [" + ;
            loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "Col1 CurrentControl = [" + ;
            loForm.grd_4c_Dados.Column1.CurrentControl + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "Col1 ControlSource  = [" + ;
            loForm.grd_4c_Dados.Column1.ControlSource + "]" + CHR(13) + CHR(10)
        lcOut = lcOut + "getObs ControlSource= [" + ;
            loForm.obj_4c_GetObs.ControlSource + "]" + CHR(13) + CHR(10)

        loForm.Release()
        loForm = .NULL.
        lcOut = lcOut + "RELEASE OK" + CHR(13) + CHR(10)
    ENDIF
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loErro.LineNo) + CHR(13) + CHR(10) + ;
        "Procedure: " + loErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\_f8_752_probe.txt")
QUIT
