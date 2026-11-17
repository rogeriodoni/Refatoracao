* Probe790F8.prg - Fase 8 da task790 (SIGOPPRO -> Formsigoppro)
* Instancia o form e exercita os metodos de consolidacao da fase.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ValidandoUI, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe790f8_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

LOCAL lcLog, loForm, loErr, loPag, loFis
lcLog = "C:\4c\automation\probe790f8.txt"
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), lcLog)

DO ("C:\4c\projeto\app\start\config.prg")
gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.
STRTOFILE("CK01 config ok" + CHR(13) + CHR(10), lcLog, .T.)

ON ERROR STRTOFILE("ONERROR " + MESSAGE() + " LN=" + TRANSFORM(LINENO()) + ;
                   " PROG=" + PROGRAM() + CHR(13) + CHR(10), lcLog, .T.)

STRTOFILE("CK01a base=[" + gc_4c_CaminhoBase + "]" + CHR(13) + CHR(10), lcLog, .T.)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
STRTOFILE("CK01b path ok" + CHR(13) + CHR(10), lcLog, .T.)

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")          ADDITIVE
STRTOFILE("CK01c functions ok" + CHR(13) + CHR(10), lcLog, .T.)
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")       ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")           ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormBuscaAuxiliar.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopproBO.prg")         ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\Formsigoppro.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\automation\Probe790F8.prg") ADDITIVE
STRTOFILE("CK02 classes carregadas" + CHR(13) + CHR(10), lcLog, .T.)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Probe790F8Form")
CATCH TO loErr
    STRTOFILE("CK03 EXCECAO " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
              " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
ENDTRY
STRTOFILE("CK03 VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcLog, .T.)

IF VARTYPE(loForm) = "O"
    *-- O form eh DataSession = 2 (privado): os cursores dele NAO existem na
    *-- sessao do probe. Sem trocar de sessao, todo SELECT cursor_4c_* falha
    *-- com "Alias not found".
    SET DATASESSION TO loForm.DataSessionId
    STRTOFILE("CK03b DataSessionId=" + TRANSFORM(loForm.DataSessionId) + ;
              " USED(itens)=" + TRANSFORM(USED("cursor_4c_Itens")) + ;
              " USED(precos)=" + TRANSFORM(USED("cursor_4c_Precos")) + ;
              CHR(13) + CHR(10), lcLog, .T.)

    loPag = loForm.pgf_4c_Paginas.Page1
    loFis = loForm.pgf_4c_Paginas.Page3.cnt_4c_Item

    STRTOFILE("CK04 PageCount=" + TRANSFORM(loForm.pgf_4c_Paginas.PageCount) + ;
              " ControlCount P1=" + TRANSFORM(loPag.ControlCount) + ;
              " P2=" + TRANSFORM(loForm.pgf_4c_Paginas.Page2.ControlCount) + ;
              " P3=" + TRANSFORM(loForm.pgf_4c_Paginas.Page3.ControlCount) + ;
              " P4=" + TRANSFORM(loForm.pgf_4c_Paginas.Page4.ControlCount) + ;
              " cntItem=" + TRANSFORM(loFis.ControlCount) + CHR(13) + CHR(10), lcLog, .T.)

    STRTOFILE("CK05 P1 visiveis: prod=" + TRANSFORM(loPag.txt_4c__prod.Visible) + ;
              " qtd=" + TRANSFORM(loPag.txt_4c__qtd.Visible) + ;
              " busca=" + TRANSFORM(loPag.txt_4c_Busca.Visible) + ;
              " dpros=" + TRANSFORM(loPag.txt_4c_DPros.Visible) + ;
              " | ocultos (esperado F): cntObs=" + TRANSFORM(loPag.cnt_4c_Obs.Visible) + ;
              " img=" + TRANSFORM(loPag.img_4c_ImgProds.Visible) + ;
              " valors=" + TRANSFORM(loPag.txt_4c_Valors.Visible) + ;
              " codcors=" + TRANSFORM(loPag.txt_4c_CodCors.Visible) + ;
              " difors=" + TRANSFORM(loPag.txt_4c_GerDIfors.Visible) + ;
              " grdPrecos=" + TRANSFORM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible) + ;
              CHR(13) + CHR(10), lcLog, .T.)

    STRTOFILE("CK06 ControlSource P1 dpros=[" + loPag.txt_4c_DPros.ControlSource + "]" + ;
              " notas=[" + loPag.txt_4c_Docs.ControlSource + "]" + ;
              " vdescs=[" + loPag.txt_4c_VDescs.ControlSource + "]" + ;
              " | P3 cpros=[" + loFis.txt_4c_FCPros.ControlSource + "]" + ;
              " sittri=[" + loFis.txt_4c_SitTrI.ControlSource + "]" + ;
              " nadis=[" + loFis.txt_4c_NAdis.ControlSource + "]" + CHR(13) + CHR(10), lcLog, .T.)

    STRTOFILE("CK07 grdPrecos CC=" + TRANSFORM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.ColumnCount) + ;
              " RS=[" + loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.RecordSource + "]" + ;
              " W=" + TRANSFORM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.Column1.Width) + "/" + ;
              TRANSFORM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.Column3.Width) + ;
              " Cap1=[" + ALLTRIM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.Column1.Header1.Caption) + "]" + ;
              CHR(13) + CHR(10), lcLog, .T.)

    STRTOFILE("CK08 escopo (5=existe/2=protected) CarregarLista=" + ;
              TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "CarregarLista", 2)) + ;
              " BtnCancelarClick=" + TRANSFORM(PEMSTATUS(loForm, "BtnCancelarClick", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "BtnCancelarClick", 2)) + ;
              " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loForm, "AjustarBotoesPorModo", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "AjustarBotoesPorModo", 2)) + ;
              " AtualizarPainelProduto=" + TRANSFORM(PEMSTATUS(loForm, "AtualizarPainelProduto", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "AtualizarPainelProduto", 2)) + ;
              " GradeAfterRowColChange=" + TRANSFORM(PEMSTATUS(loForm, "GradeAfterRowColChange", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "GradeAfterRowColChange", 2)) + ;
              " HabilitarCampos=" + TRANSFORM(PEMSTATUS(loForm, "HabilitarCampos", 5)) + "/" + TRANSFORM(PEMSTATUS(loForm, "HabilitarCampos", 2)) + ;
              CHR(13) + CHR(10), lcLog, .T.)

    *-- Uma linha de item na grade, como o pai entregaria
    loForm.this_cEmps       = "001"
    loForm.this_cDopes      = "MALOTE"
    loForm.this_nNumes      = 3
    loForm.this_cOpEscolha  = "ALTERAR"

    SELECT cursor_4c_Itens
    INSERT INTO cursor_4c_Itens (cidchaves, citens, cpros, dpros, qtds, units, ;
                                 totas, moedas, codbarras, valdescs, pdescs, ;
                                 notas, nlotes, nadis, niadis, codfabs, ;
                                 sittricms, cfops, iss, unitorigs) ;
        VALUES ("CHV0000001", 1, "PROD0001", "PRODUTO DE TESTE", 10, 5, ;
                50, "BRL", 7891234567890, 0, 0, ;
                "000123", 99, 2, 3, "FAB01", ;
                "060", "5102", 1.5, 5)
    GO TOP
    STRTOFILE("CK09 RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Itens")) + CHR(13) + CHR(10), lcLog, .T.)

    TRY
        STRTOFILE("CK10 HabilitarCampos(.T.)=" + TRANSFORM(loForm.HabilitarCampos(.T.)) + ;
                  " dpros.RO=" + TRANSFORM(loPag.txt_4c_DPros.ReadOnly) + ;
                  " docs.RO=" + TRANSFORM(loPag.txt_4c_Docs.ReadOnly) + ;
                  " prod.En=" + TRANSFORM(loPag.txt_4c__prod.Enabled) + ;
                  " P3.En=" + TRANSFORM(loForm.pgf_4c_Paginas.Page3.Enabled) + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK10 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK11 ProbeFormParaBO=" + TRANSFORM(loForm.ProbeFormParaBO()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK11 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK12 BO cpros=[" + ALLTRIM(loForm.this_oBusinessObject.this_cCpros) + "]" + ;
                  " dpros=[" + ALLTRIM(loForm.this_oBusinessObject.this_cDpros) + "]" + ;
                  " qtds=" + TRANSFORM(loForm.this_oBusinessObject.this_nQtds) + ;
                  " nadis=" + TRANSFORM(loForm.this_oBusinessObject.this_nNadis) + ;
                  " sittricms=[" + ALLTRIM(loForm.this_oBusinessObject.this_cSittricms) + "]" + ;
                  " edn=[" + ALLTRIM(loForm.this_oBusinessObject.this_cEmpdopnums) + "]" + ;
                  " len=" + TRANSFORM(LEN(loForm.this_oBusinessObject.this_cEmpdopnums)) + ;
                  " usulibs=[" + ALLTRIM(loForm.this_oBusinessObject.this_cUsulibs) + "]" + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK12 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        loForm.this_oBusinessObject.this_cDpros   = "ALTERADO PELO BO"
        loForm.this_oBusinessObject.this_nNadis   = 7
        loForm.this_oBusinessObject.this_cCodfabs = "FAB99"
        STRTOFILE("CK13 ProbeBOParaForm=" + TRANSFORM(loForm.ProbeBOParaForm()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK13 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    SELECT cursor_4c_Itens
    LOCATE FOR citens = 1
    STRTOFILE("CK14 cursor dpros=[" + ALLTRIM(cursor_4c_Itens.dpros) + "]" + ;
              " nadis=" + TRANSFORM(cursor_4c_Itens.nadis) + ;
              " codfabs=[" + ALLTRIM(cursor_4c_Itens.codfabs) + "]" + ;
              " | tela dpros=[" + ALLTRIM(loPag.txt_4c_DPros.Value) + "]" + ;
              " P3 nadis=" + TRANSFORM(loFis.txt_4c_NAdis.Value) + CHR(13) + CHR(10), lcLog, .T.)

    TRY
        STRTOFILE("CK15 AtualizarPainelProduto=" + TRANSFORM(loForm.AtualizarPainelProduto()) + ;
                  " (sem conexao: esperado F)" + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK15 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK16 GradeAfterRowColChange=" + ;
                  TRANSFORM(loForm.GradeAfterRowColChange(1)) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK16 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Procura na grade: barra conhecida e produto conhecido
    TRY
        loPag.obj_4c_Opt_Busca.Value = 1
        loPag.txt_4c_Busca.Value     = "7891234567890"
        STRTOFILE("CK17 BtnBuscarClick(barra)=" + TRANSFORM(loForm.BtnBuscarClick()) + ;
                  " campo apos=[" + ALLTRIM(loPag.txt_4c_Busca.Value) + "]" + CHR(13) + CHR(10), lcLog, .T.)
        loPag.obj_4c_Opt_Busca.Value = 2
        loPag.txt_4c_Busca.Value     = "PROD0001"
        STRTOFILE("CK18 BtnBuscarClick(produto)=" + TRANSFORM(loForm.BtnBuscarClick()) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK17 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Desconto: formula transcrita do legado (positivo SUBTRAI de unitorigs)
    TRY
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 1
        loPag.txt_4c_VDescs.Value = 2
        STRTOFILE("CK19 ValidarVDescs=" + TRANSFORM(loForm.ValidarVDescsLostFocus()) + ;
                  " units=" + TRANSFORM(cursor_4c_Itens.units) + ;
                  " (unitorigs=5, desconto 2 -> esperado 3)" + CHR(13) + CHR(10), lcLog, .T.)
        loPag.txt_4c_PDescs.Value = 20
        STRTOFILE("CK20 ValidarPDescs=" + TRANSFORM(loForm.ValidarPDescsLostFocus()) + ;
                  " units=" + TRANSFORM(cursor_4c_Itens.units) + ;
                  " (unitorigs=5, 20% -> esperado 4)" + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK19 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Documento e lote (getDocs.Valid / getLotes.Valid do legado)
    TRY
        SELECT cursor_4c_Itens
        LOCATE FOR citens = 1
        loForm.this_nEditDocs  = 5
        loPag.txt_4c_Docs.Value = ""
        STRTOFILE("CK20a ValidarDocs(vazio,obrig)=" + TRANSFORM(loForm.ValidarDocsLostFocus()) + ;
                  " (esperado F)" + CHR(13) + CHR(10), lcLog, .T.)
        loForm.this_nEditDocs   = 0
        loForm.this_nValiNotas  = 1
        loPag.txt_4c_Docs.Value = "123"
        STRTOFILE("CK20b ValidarDocs(123)=" + TRANSFORM(loForm.ValidarDocsLostFocus()) + ;
                  " campo=[" + ALLTRIM(TRANSFORM(loPag.txt_4c_Docs.Value)) + "]" + ;
                  " (esperado 000123 - normalizacao do legado)" + CHR(13) + CHR(10), lcLog, .T.)
        loForm.this_nValiNotas = 0
        loPag.txt_4c_Lotes.Value = 123499
        STRTOFILE("CK20c ValidarLotes=" + TRANSFORM(loForm.ValidarLotesLostFocus()) + ;
                  " (sem conexao: esperado T, sai antes de consultar)" + CHR(13) + CHR(10), lcLog, .T.)
        loPag.txt_4c_Docs.Value  = ""
        loPag.txt_4c_Lotes.Value = 0
    CATCH TO loErr
        STRTOFILE("CK20a FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Painel flutuante da observacao
    TRY
        STRTOFILE("CK21 ObsAbrirPainelClick=" + TRANSFORM(loForm.ObsAbrirPainelClick()) + ;
                  " cntObs.Visible=" + TRANSFORM(loPag.cnt_4c_Obs.Visible) + CHR(13) + CHR(10), lcLog, .T.)
        STRTOFILE("CK22 ObsFecharPainelLostFocus=" + TRANSFORM(loForm.ObsFecharPainelLostFocus()) + ;
                  " cntObs.Visible=" + TRANSFORM(loPag.cnt_4c_Obs.Visible) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK21 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Lista de precificacao entregue pelo pai
    TRY
        CREATE CURSOR cursor_4c_PaiLpi (lprecos C(30), tabds C(20), units N(11,2), moedas C(3))
        INSERT INTO cursor_4c_PaiLpi (lprecos, tabds, units, moedas) ;
            VALUES ("LISTA PADRAO", "TB01", 12.34, "BRL")
        STRTOFILE("CK23 CarregarPrecos=" + TRANSFORM(loForm.CarregarPrecos("cursor_4c_PaiLpi")) + ;
                  " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Precos")) + ;
                  " grdVisible=" + TRANSFORM(loForm.pgf_4c_Paginas.Page4.grd_4c_Dados.Visible) + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK23 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK24 AlternarPagina(3)=" + TRANSFORM(loForm.AlternarPagina(3)) + ;
                  " ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10), lcLog, .T.)
        STRTOFILE("CK25 AlternarPagina(1)=" + TRANSFORM(loForm.AlternarPagina(1)) + ;
                  " ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10), lcLog, .T.)

        *-- Pagina Fiscal so eh alcancavel com "Visualizar Impostos" ligado
        loForm.cnt_4c_Botoes.chk_4c_BtnVerImps.Value = 1
        loForm.HabilitarCampos(.T.)
        STRTOFILE("CK25b VerImps=1 P3.En=" + TRANSFORM(loForm.pgf_4c_Paginas.Page3.Enabled) + ;
                  " AlternarPagina(3)=" + TRANSFORM(loForm.AlternarPagina(3)) + ;
                  " ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + ;
                  " (esperado 3)" + CHR(13) + CHR(10), lcLog, .T.)
        loForm.AlternarPagina(1)
    CATCH TO loErr
        STRTOFILE("CK24 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    *-- Conferencia por codigo: sem conexao o legado avisa e nao resolve nada
    TRY
        loPag.txt_4c__prod.Value = "PROD0001"
        STRTOFILE("CK25c TxtProdLostFocus=" + TRANSFORM(loForm.TxtProdLostFocus()) + ;
                  " prod=[" + ALLTRIM(loPag.txt_4c__prod.Value) + "]" + CHR(13) + CHR(10), lcLog, .T.)
        loPag.txt_4c__prod.Value = "PROD0001"
        loPag.txt_4c__qtd.Value  = 10
        STRTOFILE("CK25d TxtQtdLostFocus=" + TRANSFORM(loForm.TxtQtdLostFocus()) + ;
                  " iconfs=" + TRANSFORM(cursor_4c_Itens.iconfs) + ;
                  " prod=[" + ALLTRIM(loPag.txt_4c__prod.Value) + "]" + ;
                  " qtd=" + TRANSFORM(loPag.txt_4c__qtd.Value) + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK25c FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        loPag.txt_4c__prod.Value = "XX"
        loPag.txt_4c__qtd.Value  = 9
        STRTOFILE("CK26 ProbeLimparCampos=" + TRANSFORM(loForm.ProbeLimparCampos()) + ;
                  " prod=[" + ALLTRIM(loPag.txt_4c__prod.Value) + "]" + ;
                  " qtd=" + TRANSFORM(loPag.txt_4c__qtd.Value) + ;
                  " cursor dpros ainda=[" + ALLTRIM(cursor_4c_Itens.dpros) + "]" + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK26 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        STRTOFILE("CK27 CarregarLista=" + TRANSFORM(loForm.CarregarLista()) + ;
                  " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Itens")) + ;
                  " gridCC=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + ;
                  " RS=[" + loForm.grd_4c_Dados.RecordSource + "]" + ;
                  " Cap1=[" + ALLTRIM(loForm.grd_4c_Dados.Column1.Header1.Caption) + "]" + ;
                  CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK27 FALHOU: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
                  " PROC=" + loErr.Procedure + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY

    TRY
        loForm.Release()
        STRTOFILE("CK28 release ok" + CHR(13) + CHR(10), lcLog, .T.)
    CATCH TO loErr
        STRTOFILE("CK28 FALHOU: " + loErr.Message + CHR(13) + CHR(10), lcLog, .T.)
    ENDTRY
ENDIF

STRTOFILE("CK99 fim" + CHR(13) + CHR(10), lcLog, .T.)
QUIT

DEFINE CLASS Probe790F8Form AS Formsigoppro
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
    PROCEDURE ProbeLimparCampos()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC
ENDDEFINE
