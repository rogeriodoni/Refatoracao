SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe720f8_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

LOCAL lcLog, loForm, loErr
lcLog = "C:\4c\automation\probe720f8.txt"
STRTOFILE("CK00 inicio v2 - subclasse para hooks PROTECTED" + CHR(13) + CHR(10), lcLog)

DO ("C:\4c\projeto\app\start\config.prg")
gb_4c_ValidandoUI = .T.
STRTOFILE("CK01 config ok ValidandoUI=" + TRANSFORM(gb_4c_ValidandoUI) + CHR(13) + CHR(10), lcLog, .T.)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")          ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")       ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormBuscaSimples.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "TextBoxGridLookup.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpDetBO.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\FormSigOpDet.prg") ADDITIVE
STRTOFILE("CK02 set procedure ok" + CHR(13) + CHR(10), lcLog, .T.)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Probe720F8Form", "ALTERAR", "GRP01", "PROD0001", "001MALOTE                   3")
CATCH TO loErr
    STRTOFILE("CK03 EXCECAO " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
              " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
ENDTRY
STRTOFILE("CK03 VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, .T.)

IF VARTYPE(loForm) = "O"
    LOCAL loG
    loG = loForm.grd_4c_Dados
    STRTOFILE("CK04 ColumnCount=" + TRANSFORM(loG.ColumnCount) + ;
              " RecordSource=[" + loG.RecordSource + "]" + CHR(13) + CHR(10), lcLog, .T.)
    STRTOFILE("CK05 W=" + TRANSFORM(loG.Column1.Width) + "/" + TRANSFORM(loG.Column2.Width) + ;
              "/" + TRANSFORM(loG.Column3.Width) + ;
              " Cap=[" + ALLTRIM(loG.Column1.Header1.Caption) + "][" + ;
              ALLTRIM(loG.Column2.Header1.Caption) + "][" + ALLTRIM(loG.Column3.Header1.Caption) + "]" + ;
              CHR(13) + CHR(10), lcLog, .T.)
    STRTOFILE("CK06 CurrentControl=[" + loG.Column1.CurrentControl + "][" + ;
              loG.Column2.CurrentControl + "][" + loG.Column3.CurrentControl + "]" + ;
              " Sparse=" + TRANSFORM(loG.Column1.Sparse) + TRANSFORM(loG.Column2.Sparse) + ;
              TRANSFORM(loG.Column3.Sparse) + CHR(13) + CHR(10), lcLog, .T.)
    STRTOFILE("CK07 CtrlSrc=[" + loG.Column1.ControlSource + "][" + loG.Column2.ControlSource + ;
              "][" + loG.Column3.ControlSource + "]" + CHR(13) + CHR(10), lcLog, .T.)
    STRTOFILE("CK08 ReadOnly grid=" + TRANSFORM(loG.ReadOnly) + " cols=" + ;
              TRANSFORM(loG.Column1.ReadOnly) + TRANSFORM(loG.Column2.ReadOnly) + ;
              TRANSFORM(loG.Column3.ReadOnly) + " modo ALTERAR esperado F" + ;
              CHR(13) + CHR(10), lcLog, .T.)

    STRTOFILE("CK09 existe/protected CarregarLista=" + ;
              TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + ;
              " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loForm, "AjustarBotoesPorModo", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "AjustarBotoesPorModo", 2)) + ;
              " FormParaBO=" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "FormParaBO", 2)) + ;
              " BOParaForm=" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "BOParaForm", 2)) + ;
              CHR(13) + CHR(10), lcLog, .T.)

    SELECT cursor_4c_Itens
    INSERT INTO cursor_4c_Itens (cidchaves, empdopnums, cpros, ccars, ctits, resps, ordens) ;
        VALUES ("CHV0000001", "001MALOTE                   3", "PROD0001", "COR", "AZUL", "OBS", 7)
    GO TOP
    STRTOFILE("CK10 RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Itens")) + CHR(13) + CHR(10), lcLog, .T.)

    TRY
        STRTOFILE("CK11 ProbeFormParaBO=" + TRANSFORM(loForm.ProbeFormParaBO()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK11 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK12 BO ccars=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCCars) + "]" + ;
                  " ctits=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCTits) + "]" + ;
                  " resps=[" + ALLTRIM(loForm.this_oBusinessObject.this_cResps) + "]" + ;
                  " ordens=" + TRANSFORM(loForm.this_oBusinessObject.this_nOrdens) + ;
                  " edn=[" + ALLTRIM(loForm.this_oBusinessObject.this_cEmpDopNums) + "]" + ;
                  " cpros=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCpros) + "]" + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK12 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        loForm.this_oBusinessObject.this_cCTits = "VERDE"
        loForm.this_oBusinessObject.this_cResps = ""
        STRTOFILE("CK13 ProbeBOParaForm=" + TRANSFORM(loForm.ProbeBOParaForm()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK13 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    SELECT cursor_4c_Itens
    GO TOP
    STRTOFILE("CK14 cursor ctits=[" + ALLTRIM(cursor_4c_Itens.ctits) + "]" + ;
              " resps=[" + ALLTRIM(cursor_4c_Itens.resps) + "]" + ;
              " ccars=[" + ALLTRIM(cursor_4c_Itens.ccars) + "]" + ;
              " ordens=" + TRANSFORM(cursor_4c_Itens.ordens) + CHR(13) + CHR(10), lcLog, .T.)

    TRY
        loForm.this_cModoOperacao = "VISUALIZAR"
        STRTOFILE("CK15 AjustarBotoesPorModo=" + TRANSFORM(loForm.AjustarBotoesPorModo()) + ;
                  " cols=" + TRANSFORM(loG.Column1.ReadOnly) + TRANSFORM(loG.Column2.ReadOnly) + ;
                  TRANSFORM(loG.Column3.ReadOnly) + " grid=" + TRANSFORM(loG.ReadOnly) + ;
                  " esperado cols T e grid F" + CHR(13) + CHR(10), lcLog, .T.)
        loForm.this_cModoOperacao = "ALTERAR"
    CATCH TO loErr
        STRTOFILE("CK15 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK16 CarregarLista=" + TRANSFORM(loForm.CarregarLista()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK16 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    STRTOFILE("CK17 pos-reload ColumnCount=" + TRANSFORM(loG.ColumnCount) + ;
              " RecordSource=[" + loG.RecordSource + "]" + ;
              " W=" + TRANSFORM(loG.Column1.Width) + "/" + TRANSFORM(loG.Column2.Width) + ;
              "/" + TRANSFORM(loG.Column3.Width) + ;
              " Cap1=[" + ALLTRIM(loG.Column1.Header1.Caption) + "]" + ;
              " CC1=[" + loG.Column1.CurrentControl + "]" + ;
              " Sparse1=" + TRANSFORM(loG.Column1.Sparse) + ;
              " RO1=" + TRANSFORM(loG.Column1.ReadOnly) + CHR(13) + CHR(10), lcLog, .T.)

    TRY
        loForm.Release()
        STRTOFILE("CK18 release ok" + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK18 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY
ENDIF

STRTOFILE("CK99 fim" + CHR(13) + CHR(10), lcLog, .T.)
QUIT

DEFINE CLASS Probe720F8Form AS FormSigOpDet
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
ENDDEFINE
