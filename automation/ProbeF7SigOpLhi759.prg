*-- Probe Fase 7 - task759 / FormSigOpLhi
*-- Prova: (1) o form INSTANCIA com o BINDEVENT novo (bind com delegate
*-- inexistente estouraria aqui), (2) o BINDEVENT esta REGISTRADO no grid,
*-- (3) os metodos da fase existem e sao PUBLIC, (4) SincronizarLinhaCorrente
*-- leva o Hists EDITADO para o BO e PRESERVA a area de trabalho corrente,
*-- (5) MarcarCanceladoNoPai marca a flag nos TRES formatos de pai possiveis
*-- e (6) os dois Click do legado rodam sem estourar.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_f7_759_probe_dialogs.txt"
gnConnHandle           = 0

LOCAL lcOut, lcEol, loForm, loErro, lnI, loPaiMig, loPaiLeg, loPaiNu
lcEol = CHR(13) + CHR(10)
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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpLhiBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpLhi.prg") ADDITIVE

lcOut = lcOut + "DEPENDENCIAS CARREGADAS" + lcEol

*-- O form PAI monta TmpLanca ANTES de abrir o dialogo (SIGCDPGR).
CREATE CURSOR cursor_4c_Lancamentos ;
    (Grupos C(10), Contas C(10), Moeda C(3), Cotacaos N(14,4), ;
     GrupoC C(10), ContaC C(10), MoedaC C(3), CotacaoC N(14,4), ;
     Hists C(40), Valor N(12,2), ValPag N(12,2), Tipos C(1), ;
     ValorC N(12,2), ValPagC N(12,2), Hist2s C(40))

INSERT INTO cursor_4c_Lancamentos ;
    (Grupos, Contas, Moeda, Hists, Valor, Tipos) ;
    VALUES ("001", "1101", "BRL", "PAGTO DUPLICATA 001", 1500.00, "D")
INSERT INTO cursor_4c_Lancamentos ;
    (Grupos, Contas, Moeda, Hists, Valor, Tipos) ;
    VALUES ("002", "2202", "BRL", "CONTRAPARTIDA 001", 1500.00, "C")

*-- Cursor de contexto (crSigCdPgr no legado), so para o titulo
CREATE CURSOR cursor_4c_Ctx ;
    (dopes C(20), mascnum C(6), cidchaves C(20), emps C(3), ;
     numes N(6,0), grupos C(10), contas C(10), empdopnums C(29))
INSERT INTO cursor_4c_Ctx (dopes, mascnum, cidchaves, emps, numes) ;
    VALUES ("DUPLICATA", "000123", "CHAVE-TESTE-759", "001", 123)
GO TOP IN cursor_4c_Ctx

lcOut = lcOut + "CURSOR DO PAI: RECCOUNT=" + ;
    TRANSFORM(RECCOUNT("cursor_4c_Lancamentos")) + lcEol

TRY
    loPaiMig = CREATEOBJECT("PaiMigrado759")
    loForm   = CREATEOBJECT("FormSigOpLhi", loPaiMig, "cursor_4c_Ctx", "cursor_4c_Lancamentos")

    lcOut = lcOut + "VARTYPE(loForm)       = " + VARTYPE(loForm) + lcEol

    IF VARTYPE(loForm) = "O"
        lcOut = lcOut + "BaseClass             = " + loForm.BaseClass + lcEol
        lcOut = lcOut + "Caption               = [" + ALLTRIM(loForm.Caption) + "]" + lcEol

        lcOut = lcOut + "--- METODOS DA FASE 7 (ex=existe, prot=protegido) ---" + lcEol
        lcOut = lcOut + "SincronizarLinhaCorrente   ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "SincronizarLinhaCorrente", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "SincronizarLinhaCorrente", 2)) + lcEol
        lcOut = lcOut + "GrdDadosAfterRowColChange  ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "GrdDadosAfterRowColChange", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "GrdDadosAfterRowColChange", 2)) + lcEol
        lcOut = lcOut + "MarcarCanceladoNoPai       ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "MarcarCanceladoNoPai", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "MarcarCanceladoNoPai", 2)) + lcEol
        lcOut = lcOut + "CmdConfirmaClick           ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "CmdConfirmaClick", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "CmdConfirmaClick", 2)) + lcEol
        lcOut = lcOut + "CmdCancelaClick            ex=" + ;
            TRANSFORM(PEMSTATUS(loForm, "CmdCancelaClick", 5)) + ;
            " prot=" + TRANSFORM(PEMSTATUS(loForm, "CmdCancelaClick", 2)) + lcEol

        lcOut = lcOut + "--- BINDEVENT REGISTRADOS ---" + lcEol
        LOCAL ARRAY laGrd[1,5], laOk[1,5], laCan[1,5]
        lcOut = lcOut + "grd_4c_Dados    nEventos=" + ;
            TRANSFORM(AEVENTS(laGrd, loForm.grd_4c_Dados)) + lcEol
        IF TYPE("laGrd[1,3]") = "C"
            FOR lnI = 1 TO ALEN(laGrd, 1)
                lcOut = lcOut + "   [" + laGrd[lnI,3] + "] -> " + laGrd[lnI,4] + lcEol
            ENDFOR
        ENDIF
        lcOut = lcOut + "cmd_4c_Confirma nEventos=" + ;
            TRANSFORM(AEVENTS(laOk, loForm.cnt_4c_Botoes.cmd_4c_Confirma)) + lcEol
        IF TYPE("laOk[1,3]") = "C"
            FOR lnI = 1 TO ALEN(laOk, 1)
                lcOut = lcOut + "   [" + laOk[lnI,3] + "] -> " + laOk[lnI,4] + lcEol
            ENDFOR
        ENDIF
        lcOut = lcOut + "cmd_4c_Cancela  nEventos=" + ;
            TRANSFORM(AEVENTS(laCan, loForm.cnt_4c_Botoes.cmd_4c_Cancela)) + lcEol
        IF TYPE("laCan[1,3]") = "C"
            FOR lnI = 1 TO ALEN(laCan, 1)
                lcOut = lcOut + "   [" + laCan[lnI,3] + "] -> " + laCan[lnI,4] + lcEol
            ENDFOR
        ENDIF

        lcOut = lcOut + "--- GRID ---" + lcEol
        lcOut = lcOut + "RecordSource          = [" + loForm.grd_4c_Dados.RecordSource + "]" + lcEol
        lcOut = lcOut + "ColumnCount           = " + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + lcEol
        lcOut = lcOut + "Col3 ControlSource    = [" + loForm.grd_4c_Dados.Column3.ControlSource + "]" + lcEol
        lcOut = lcOut + "Col3 ReadOnly         = " + TRANSFORM(loForm.grd_4c_Dados.Column3.ReadOnly) + lcEol
        lcOut = lcOut + "Col1 ReadOnly         = " + TRANSFORM(loForm.grd_4c_Dados.Column1.ReadOnly) + lcEol
        lcOut = lcOut + "BO total lancamentos  = " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nTotalLancamentos) + lcEol

        lcOut = lcOut + "--- SINCRONIA DO HISTORICO EDITADO ---" + lcEol
        SELECT cursor_4c_Lancamentos
        GO TOP
        REPLACE Hists WITH "HISTORICO EDITADO PELO USUARIO"
        SELECT cursor_4c_Ctx
        lcOut = lcOut + "alias antes           = [" + ALIAS() + "]" + lcEol
        lcOut = lcOut + "Sincronizar           = " + ;
            TRANSFORM(loForm.SincronizarLinhaCorrente()) + lcEol
        lcOut = lcOut + "alias depois          = [" + ALIAS() + "]  (tem de ser o MESMO)" + lcEol
        lcOut = lcOut + "BO.this_cHists        = [" + ;
            ALLTRIM(loForm.this_oBusinessObject.this_cHists) + "]" + lcEol
        lcOut = lcOut + "BO.this_cGrupos       = [" + ;
            ALLTRIM(loForm.this_oBusinessObject.this_cGrupos) + "]" + lcEol
        lcOut = lcOut + "BO.this_nValor        = " + ;
            TRANSFORM(loForm.this_oBusinessObject.this_nValor) + lcEol

        SELECT cursor_4c_Lancamentos
        GO BOTTOM
        loForm.GrdDadosAfterRowColChange(3)
        lcOut = lcOut + "AfterRowColChange(3)  -> BO.this_cGrupos=[" + ;
            ALLTRIM(loForm.this_oBusinessObject.this_cGrupos) + "] (linha 2)" + lcEol

        lcOut = lcOut + "--- MARCAR CANCELADO NO PAI ---" + lcEol
        lcOut = lcOut + "pai MIGRADO : marcou=" + TRANSFORM(loForm.MarcarCanceladoNoPai()) + ;
            "  flag=" + TRANSFORM(loPaiMig.this_lCanceladoExterno) + lcEol

        loPaiLeg = CREATEOBJECT("PaiLegado759")
        loForm.this_oFormPai = loPaiLeg
        lcOut = lcOut + "pai LEGADO  : marcou=" + TRANSFORM(loForm.MarcarCanceladoNoPai()) + ;
            "  flag=" + TRANSFORM(loPaiLeg.CanceladoExterno) + lcEol

        loPaiNu = CREATEOBJECT("Form")
        loForm.this_oFormPai = loPaiNu
        lcOut = lcOut + "pai SEM FLAG: marcou=" + TRANSFORM(loForm.MarcarCanceladoNoPai()) + ;
            "  criou=" + TRANSFORM(PEMSTATUS(loPaiNu, "CanceladoExterno", 5)) + lcEol

        loForm.this_oFormPai = .NULL.
        lcOut = lcOut + "pai NULO    : marcou=" + TRANSFORM(loForm.MarcarCanceladoNoPai()) + ;
            "  (tem de ser .F., sem excecao)" + lcEol

        loForm.Release()
        loForm = .NULL.
        lcOut = lcOut + "RELEASE OK" + lcEol
    ENDIF

    lcOut = lcOut + "--- CLICK CONFIRMA ---" + lcEol
    SELECT cursor_4c_Lancamentos
    GO TOP
    REPLACE Hists WITH "OK EDITADO"
    loPaiMig = CREATEOBJECT("PaiMigrado759")
    loForm   = CREATEOBJECT("FormSigOpLhi", loPaiMig, "cursor_4c_Ctx", "cursor_4c_Lancamentos")
    SELECT cursor_4c_Lancamentos
    GO TOP
    loForm.CmdConfirmaClick()
    lcOut = lcOut + "pai.flag apos Ok      = " + TRANSFORM(loPaiMig.this_lCanceladoExterno) + ;
        "  (tem de ser .F.)" + lcEol
    lcOut = lcOut + "form apos Release     = " + VARTYPE(loForm) + lcEol

    lcOut = lcOut + "--- CLICK CANCELA ---" + lcEol
    loPaiMig = CREATEOBJECT("PaiMigrado759")
    loForm   = CREATEOBJECT("FormSigOpLhi", loPaiMig, "cursor_4c_Ctx", "cursor_4c_Lancamentos")
    loForm.CmdCancelaClick()
    lcOut = lcOut + "pai.flag apos Encerrar= " + TRANSFORM(loPaiMig.this_lCanceladoExterno) + ;
        "  (tem de ser .T.)" + lcEol
    lcOut = lcOut + "form apos Release     = " + VARTYPE(loForm) + lcEol
CATCH TO loErro
    lcOut = lcOut + "EXCECAO: " + loErro.Message + lcEol + ;
        "Linha: " + TRANSFORM(loErro.LineNo) + lcEol + ;
        "Procedure: " + loErro.Procedure + lcEol
ENDTRY

STRTOFILE(lcOut, "C:\4c\automation\_f7_759_probe.txt")
QUIT

DEFINE CLASS PaiMigrado759 AS Form
    this_lCanceladoExterno = .F.
ENDDEFINE

DEFINE CLASS PaiLegado759 AS Form
    CanceladoExterno = .F.
ENDDEFINE
