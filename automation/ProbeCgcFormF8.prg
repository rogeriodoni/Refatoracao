*==============================================================================
* ProbeCgcFormF8.prg - Prova a Fase 8/8 (consolidacao final) do Formsigopcgc
* (task690). Cobre o que as fases anteriores nao exercitavam:
*   1) instanciacao completa (Init -> InicializarForm -> as 2 paginas + o
*      PageFrame Result com as 5 sub-paginas e as 7 grades)
*   2) presenca e binding das grades (RecordSource / ColumnCount / Headers)
*   3) os 8 cursores locais criados pelo BO (Load do legado)
*   4) CarregarLista / AtualizarGrades sem conexao SQL
*   5) MostrarBlocoCadastro / MostrarBlocoMovimento (BtnMudaFor/BtnMudaMov)
*   6) OptSituasChange e os 8 handlers de ordenacao dos headers
*   7) BtnImprimirMovClick / BtnSairOpcoesClick (painel ImprimeOpcoes)
*   8) ValidarFiltrosConsulta recusando filtro vazio (sem abrir a Page2)
*   9) BtnCancelarClick: Release() fecha o form sem excecao
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF
* obrigatorios (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cgcform_f8.txt"

#DEFINE OUT "C:\4c\automation\probe_cgcform_f8.txt"

LOCAL loc_oE, loc_oForm, loc_oRes, loc_oP, loc_nI, loc_cL, loc_aCur[8]

STRTOFILE("=== PROBE Formsigopcgc - Fase 8/8 (task690) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gnConnHandle = -1

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")               ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg")              ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")                  ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")                   ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopcgcBO.prg")                 ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopcgc.prg")    ADDITIVE

    *-- ================================================= 1) instanciacao
    loc_oForm = CREATEOBJECT("Formsigopcgc")
    STRTOFILE("1) CREATEOBJECT Formsigopcgc -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", "") + ;
        CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        IF FILE(gc_4c_ArquivoErroTeste)
            STRTOFILE("   ERRO REGISTRADO: " + FILETOSTR(gc_4c_ArquivoErroTeste) + ;
                CHR(13) + CHR(10), OUT, 1)
        ENDIF
        STRTOFILE("ABORTADO - form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    *-- ============================================ 2) PageFrame Result
    STRTOFILE("2) pgf_4c_Result existe=" + ;
        TRANSFORM(PEMSTATUS(loc_oForm.pgf_4c_Paginas.Page2, "pgf_4c_Result", 5)) + ;
        CHR(13) + CHR(10), OUT, 1)

    loc_oRes = loc_oForm.pgf_4c_Paginas.Page2.pgf_4c_Result
    STRTOFILE("   PageCount=" + TRANSFORM(loc_oRes.PageCount) + ;
        " Top=" + TRANSFORM(loc_oRes.Top) + " Left=" + TRANSFORM(loc_oRes.Left) + ;
        " W=" + TRANSFORM(loc_oRes.Width) + " H=" + TRANSFORM(loc_oRes.Height) + ;
        " Visible=" + TRANSFORM(loc_oRes.Visible) + CHR(13) + CHR(10), OUT, 1)

    FOR loc_nI = 1 TO loc_oRes.PageCount
        STRTOFILE("   Page" + TRANSFORM(loc_nI) + " Caption=[" + ;
            loc_oRes.Pages(loc_nI).Caption + "] ControlCount=" + ;
            TRANSFORM(loc_oRes.Pages(loc_nI).ControlCount) + CHR(13) + CHR(10), OUT, 1)
    ENDFOR

    *-- ====================================== 3) grades e seus bindings
    STRTOFILE("3) GRADES:" + CHR(13) + CHR(10), OUT, 1)

    loc_oP = loc_oRes.Page1
    STRTOFILE("   grd_4c_Saldo      cols=" + TRANSFORM(loc_oP.grd_4c_Saldo.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Saldo.RecordSource + "]" + ;
        " C1=[" + loc_oP.grd_4c_Saldo.Column1.ControlSource + "]" + ;
        " H1=[" + loc_oP.grd_4c_Saldo.Column1.Header1.Caption + "]" + ;
        " W1=" + TRANSFORM(loc_oP.grd_4c_Saldo.Column1.Width) + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   grd_4c_Historico  cols=" + TRANSFORM(loc_oP.grd_4c_Historico.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Historico.RecordSource + "]" + ;
        " LinkMaster=[" + loc_oP.grd_4c_Historico.LinkMaster + "]" + ;
        " ChildOrder=[" + loc_oP.grd_4c_Historico.ChildOrder + "]" + ;
        " RelExpr=[" + loc_oP.grd_4c_Historico.RelationalExpr + "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   grd_4c_Historico  C1=[" + loc_oP.grd_4c_Historico.Column1.ControlSource + ;
        "] H1=[" + loc_oP.grd_4c_Historico.Column1.Header1.Caption + "] Hn=[" + ;
        loc_oP.grd_4c_Historico.Columns(loc_oP.grd_4c_Historico.ColumnCount).Header1.Caption + ;
        "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   txt_4c_Hists CS=[" + loc_oP.txt_4c_Hists.ControlSource + "]" + ;
        " cmd_4c_ImprimirExtrato Pic=" + TRANSFORM(FILE(loc_oP.cmd_4c_ImprimirExtrato.Picture)) + ;
        CHR(13) + CHR(10), OUT, 1)

    loc_oP = loc_oRes.Page2
    STRTOFILE("   grd_4c_Pendente   cols=" + TRANSFORM(loc_oP.grd_4c_Pendente.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Pendente.RecordSource + "]" + ;
        " C4=[" + loc_oP.grd_4c_Pendente.Column4.ControlSource + "]" + ;
        " H4=[" + loc_oP.grd_4c_Pendente.Column4.Header1.Caption + "]" + ;
        " oculta.Visible=" + TRANSFORM(loc_oP.grd_4c_PendenteOculta.Visible) + ;
        CHR(13) + CHR(10), OUT, 1)

    loc_oP = loc_oRes.Page3
    STRTOFILE("   grd_4c_Produto    cols=" + TRANSFORM(loc_oP.grd_4c_Produto.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Produto.RecordSource + "]" + ;
        " C10=[" + loc_oP.grd_4c_Produto.Column10.ControlSource + "]" + ;
        " W10=" + TRANSFORM(loc_oP.grd_4c_Produto.Column10.Width) + ;
        " H6=[" + loc_oP.grd_4c_Produto.Column6.Header1.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   grd_4c_Resumo     cols=" + TRANSFORM(loc_oP.grd_4c_Resumo.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Resumo.RecordSource + "]" + ;
        " C1=[" + loc_oP.grd_4c_Resumo.Column1.ControlSource + "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   grd_4c_OperaProd  cols=" + TRANSFORM(loc_oP.grd_4c_OperaProd.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_OperaProd.RecordSource + "]" + ;
        " LinkMaster=[" + loc_oP.grd_4c_OperaProd.LinkMaster + "]" + ;
        " ChildOrder=[" + loc_oP.grd_4c_OperaProd.ChildOrder + "]" + CHR(13) + CHR(10), OUT, 1)
    STRTOFILE("   obj_4c_OptSituas  Value=" + TRANSFORM(loc_oP.obj_4c_OptSituas.Value) + ;
        " B1=[" + loc_oP.obj_4c_OptSituas.Buttons(1).Caption + "]" + ;
        " B3=[" + loc_oP.obj_4c_OptSituas.Buttons(3).Caption + "]" + CHR(13) + CHR(10), OUT, 1)

    loc_oP = loc_oRes.Page4
    STRTOFILE("   grd_4c_EstoqueProd cols=" + TRANSFORM(loc_oP.grd_4c_EstoqueProd.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_EstoqueProd.RecordSource + "]" + ;
        " img.Visible=" + TRANSFORM(loc_oP.img_4c_FotoProduto.Visible) + CHR(13) + CHR(10), OUT, 1)

    loc_oP = loc_oRes.Page5
    STRTOFILE("   grd_4c_Conserto   cols=" + TRANSFORM(loc_oP.grd_4c_Conserto.ColumnCount) + ;
        " RS=[" + loc_oP.grd_4c_Conserto.RecordSource + "]" + ;
        " H4=[" + loc_oP.grd_4c_Conserto.Column4.Header1.Caption + "]" + CHR(13) + CHR(10), OUT, 1)

    *-- ============================================= 4) cursores do BO
    loc_aCur[1] = "cursor_4c_Saldo"
    loc_aCur[2] = "cursor_4c_Historico"
    loc_aCur[3] = "cursor_4c_ProdFor"
    loc_aCur[4] = "cursor_4c_Resumo"
    loc_aCur[5] = "cursor_4c_OperaProd"
    loc_aCur[6] = "cursor_4c_Estoque"
    loc_aCur[7] = "cursor_4c_Conserto"
    loc_aCur[8] = "cursor_4c_Parcela"

    *-- O form eh DataSession = 2: os cursores do BO vivem na sessao PRIVADA
    *-- dele, nao na sessao 1 deste script. Sem o SET DATASESSION o USED()
    *-- devolveria .F. para todos (falso negativo).
    SET DATASESSION TO loc_oForm.DataSessionId

    loc_cL = "4) CURSORES (datasession " + TRANSFORM(loc_oForm.DataSessionId) + "):"
    FOR loc_nI = 1 TO 8
        loc_cL = loc_cL + " " + loc_aCur[loc_nI] + "=" + ;
                 IIF(USED(loc_aCur[loc_nI]), "OK", "AUSENTE")
    ENDFOR
    STRTOFILE(loc_cL + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("   tags ProdFor=[" + TAG(1, "cursor_4c_ProdFor") + "," + ;
        TAG(2, "cursor_4c_ProdFor") + "," + TAG(3, "cursor_4c_ProdFor") + "," + ;
        TAG(4, "cursor_4c_ProdFor") + "] Historico=[" + ;
        TAG(1, "cursor_4c_Historico") + "] OperaProd=[" + ;
        TAG(1, "cursor_4c_OperaProd") + "]" + CHR(13) + CHR(10), OUT, 1)

    *-- ========================================= 5) CarregarLista / grades
    STRTOFILE("5) CarregarLista -> " + TRANSFORM(loc_oForm.CarregarLista()) + ;
        CHR(13) + CHR(10), OUT, 1)
    loc_oForm.AtualizarGrades()
    STRTOFILE("   AtualizarGrades OK" + CHR(13) + CHR(10), OUT, 1)

    *-- ================================== 6) alternancia Cadastro/Movimento
    loc_oForm.BtnMudaMovClick()
    STRTOFILE("6) BtnMudaMovClick -> Result.Visible=" + TRANSFORM(loc_oRes.Visible) + ;
        " Cadastro.Visible=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Cadastro.Visible) + ;
        CHR(13) + CHR(10), OUT, 1)
    loc_oForm.BtnMudaForClick()
    STRTOFILE("   BtnMudaForClick -> Result.Visible=" + TRANSFORM(loc_oRes.Visible) + ;
        " Cadastro.Visible=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_Cadastro.Visible) + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- ============================ 7) filtro de situacao + ordenacoes
    loc_oRes.Page3.obj_4c_OptSituas.Value = 1
    loc_oForm.OptSituasChange()
    loc_oRes.Page3.obj_4c_OptSituas.Value = 3
    loc_oForm.OptSituasChange()
    STRTOFILE("7) OptSituasChange(1 e 3) OK - filtro=[" + ;
        FILTER("cursor_4c_ProdFor") + "]" + CHR(13) + CHR(10), OUT, 1)

    loc_oForm.HeaderProdutoClick()
    loc_oForm.HeaderProdutoDblClick()
    loc_oForm.HeaderQtVendClick()
    loc_oForm.HeaderQtVendDblClick()
    loc_oForm.HeaderVlVendClick()
    loc_oForm.HeaderVlVendDblClick()
    loc_oForm.HeaderReffsClick()
    loc_oForm.HeaderReffsDblClick()
    SELECT cursor_4c_ProdFor
    STRTOFILE("   8 handlers de ordenacao OK - ORDER=[" + ORDER() + "]" + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- ================================= 8) painel de opcoes de impressao
    loc_oForm.BtnImprimirMovClick()
    STRTOFILE("8) BtnImprimirMovClick -> ImprimeOpcoes.Visible=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_ImprimeOpcoes.Visible) + ;
        " Opcao.Value=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_ImprimeOpcoes.obj_4c_Opcao.Value) + ;
        CHR(13) + CHR(10), OUT, 1)
    loc_oForm.BtnSairOpcoesClick()
    STRTOFILE("   BtnSairOpcoesClick -> ImprimeOpcoes.Visible=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.Page2.cnt_4c_ImprimeOpcoes.Visible) + ;
        " Page1.Enabled=" + TRANSFORM(loc_oForm.pgf_4c_Paginas.Page1.Enabled) + ;
        CHR(13) + CHR(10), OUT, 1)

    *-- ======================= 9) validacao recusa filtro vazio / Release
    loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Grupo.Value = ""
    loc_oForm.pgf_4c_Paginas.Page1.cnt_4c_Origem.txt_4c_Conta.Value = ""
    loc_oForm.BtnCadastroClick()
    STRTOFILE("9) BtnCadastroClick com filtro VAZIO -> ActivePage=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + " (esperado 1)" + ;
        CHR(13) + CHR(10), OUT, 1)

    loc_oForm.BtnCancelarClick()
    STRTOFILE("   BtnCancelarClick (Release) OK" + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE(CHR(13) + CHR(10) + "=== PROBE CONCLUIDO SEM EXCECAO ===" + ;
        CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE(CHR(13) + CHR(10) + "*** EXCECAO ***" + CHR(13) + CHR(10) + ;
        "Msg : " + loc_oE.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
        "Proc : " + loc_oE.Procedure + CHR(13) + CHR(10) + ;
        "Det  : " + loc_oE.Details + CHR(13) + CHR(10), OUT, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(CHR(13) + CHR(10) + "--- gc_4c_ArquivoErroTeste ---" + CHR(13) + CHR(10) + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13) + CHR(10), OUT, 1)
ENDIF

QUIT
