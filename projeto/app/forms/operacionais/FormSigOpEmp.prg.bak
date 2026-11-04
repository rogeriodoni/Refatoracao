*==============================================================================
* FormSigOpEmp.prg - Form Operacional: Empenho
* Migrado de: tasks/task729/SIGOPEMP.SCX
* BO: SigOpEmpBO.prg (classes/SigOpEmpBO.prg)
*
* Dialogo filho do movimento (SigMvEtr/Etiqueta), aberto passando a
* referencia do form pai e o numero da data session dele (equivalente a
* Lparameters poForm, pnDatSes do legado). Layout CUSTOMIZADO - NAO segue o
* padrao CRUD Page1=Lista/Page2=Dados: cabecalho + grid de itens empenhados +
* shape decorativo + dois campos de descricao (grupo/conta) + botao
* Encerrar, todos direto no Form.
*
* O legado le crSigMvEtr.Cpros trocando PERMANENTEMENTE a data session do
* dialogo para a do form pai (Set DataSession to pnDatSes, sem restaurar) e
* liga o grid direto ao cursor 'CrEmpenhado' que o pai ja deixa aberto -
* dependencia cruzada entre data sessions, fragil para a arquitetura nova.
* Aqui a troca eh TEMPORARIA (THIS.ObterProdutoDoFormPai): o UNICO uso do
* cursor do pai eh obter o codigo do produto, guardado em THIS.this_cProduto
* e repassado ao BO, que busca os empenhos com SQL proprio
* (SigOpEmpBO.BuscarEmpenhosDoProduto) em vez de depender de CrEmpenhado
* continuar aberto na sessao do pai pelo resto da vida deste dialogo.
*
* FASE 6/8 - SEM TRABALHO NESTA FASE (confirmado contra o dump e o
* comportamento.json, nao assumido por omissao). O SIGOPEMP.SCX legado tem
* so 7 metodos (montagrades, Load, Init, ok.Click, get_NGrupo.When,
* Get_NConta.When, grdItens.AfterRowColChange) e NENHUM casa padrao de
* lookup do Framework (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
* CreateObject de busca) - comportamento.json.resumo.funcoesExternas lista
* so fConfigGeral e MontaGrade. Os dois UNICOS TextBox do form
* (get_NGrupo/Get_NConta) tem `PROCEDURE When / Return .f.` no legado, ou
* seja NUNCA entram em edicao - sao visores, ja entregues na Fase 5 como
* txt_4c__NGrupo/txt_4c_NConta (ReadOnly=.T./TabStop=.F.) e ja alimentados
* por THIS.BOParaForm(). Nao ha "ultimos 50% de campos" a adicionar (zero
* campos em analise.json.campos) nem container cnt_4c_BotoesAcao
* Salvar/Cancelar - o legado so tem o botao "ok" (Encerrar), ja migrado na
* Fase 5 como cmd_4c_Ok/BtnEncerrarClick. Inventar lookup ou botoes de
* Salvar/Cancelar aqui violaria o PILAR 1 e a regra "NUNCA inventar
* tabelas de lookup que nao existem no original". O unico metodo do dump
* ainda sem equivalente - grdItens.AfterRowColChange - foi portado na
* Fase 7 (handler PUBLIC da grade, conforme ja registrado no cabecalho de
* BOParaForm abaixo).
*
* FASE 7/8 - EVENTOS PRINCIPAIS. Os quatro handlers da barra CRUD do
* framework (um por verbo: incluir, alterar, visualizar e excluir registro)
* NAO existem aqui porque o legado NAO TEM essa barra - conferido no dump,
* nao assumido por omissao:
*   - SIGOPEMP herda de form PURO, e nao da classe de cadastro do framework
*     (zero ocorrencia do nome dessa classe-mae no dump), logo nao herda a
*     barra de botoes dela;
*   - zero ocorrencia do CommandGroup que hospeda essa barra, da variavel de
*     MODO do cadastro e dos quatro verbos CRUD em qualquer forma - nome de
*     objeto, caption, metodo ou chamada de Click;
*   - a SUPERFICIE DE BOTAO do legado eh UM botao so: o dump tem exatamente
*     1 objeto de base commandbutton (SIGOPEMP.ok, Caption "Encerrar") e
*     nenhum de base commandgroup.
* Esse unico botao TEM o seu evento portado (ok.Click = ThisForm.Release ->
* cmd_4c_Ok/BtnEncerrarClick, Fase 5), e a Fase 7 acrescenta o unico outro evento
* do dump, o da grade. Criar os quatro handlers da barra CRUD aqui exigiria
* INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
* inventar") ou escrever quatro metodos vazios (viola a regra de
* completude). O form eh um dialogo filho SOMENTE-LEITURA de consulta:
* coerente com isso, o BO recusa Inserir/Atualizar com a mensagem
* "Empenho e uma tela de consulta".
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO. Fecha a migracao com a
* TABELA DE DISPOSICAO dos 7 (e so 7) metodos do SIGOPEMP.SCX, para que a
* ausencia de qualquer outro seja verificavel e nao presumida:
*
*   metodo do SCX legado        | onde foi parar no migrado
*   ----------------------------|-------------------------------------------
*   montagrades                 | ConfigurarGrid            (Fase 4)
*   Init                        | Init + InicializarForm    (Fase 3)
*   ok.Click                    | BtnEncerrarClick           (Fase 5)
*   get_NGrupo.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
*   Get_NConta.When  (Return .f)| ReadOnly=.T. + TabStop=.F. (Fase 5)
*   grdItens.AfterRowColChange  | GradeAfterRowColChange    (Fase 7)
*   Load  (=fConfigGeral())     | NAO PORTADO - ver (a)
*
* (a) Load: "=fConfigGeral()". No Fortyus fConfigGeral era inicializacao
*     GLOBAL da aplicacao (parametros do sistema, cursores de referencia),
*     chamada pelo Load de dezenas de telas. Na arquitetura nova esse papel
*     eh de config.prg/ConfigurarAmbiente(), que roda ANTES de qualquer form
*     existir; chama-la daqui seria re-executar inicializacao global no meio
*     da vida da aplicacao. Mesma disposicao, pelo mesmo motivo, de
*     FormSigMvExp/FormSigMvMen/FormSigMvPdt/FormSigMvSbn/FormSigOpClp. O
*     wrapper utils\fconfiggeral.prg existe para o p-code dos VCX legado que
*     ainda chamam o nome (regra #27), nao para codigo nosso.
*
* A Fase 8 corrigiu dois defeitos reais e NAO inventou superficie nova:
*
*   1. ConfigurarOrdemTabulacao() - novo. A ordem de tabulacao saia da ordem
*      de criacao dos AddObject e divergia do legado: o Encerrar vinha ANTES
*      da grade, e a grade (o conteudo da tela) caia em ULTIMO. Medido no
*      VFP9 e documentado no cabecalho do proprio metodo.
*   2. InicializarForm - o bypass de gb_4c_ValidandoUI estava com RETURN no
*      TOPO do metodo, pulando THIS.Picture e TODA a montagem visual; agora
*      cerca apenas CarregarLista(), o unico trecho que depende de SQL.
*
* Os nomes canonicos de form CRUD que a Fase 8 normalmente fecha NAO se
* aplicam aqui, e a razao eh estrutural (conferida no dump, nao presumida
* por omissao) - este eh um dialogo filho de CONSULTA, sem Page2(Dados) e
* sem modo de edicao:
*
*   BtnSalvarClick / BtnCancelarClick - o dump tem exatamente 1 objeto de
*     base commandbutton (SIGOPEMP.ok) e nenhum commandgroup, e o Click dele
*     so faz ThisForm.Release(). Nao existe par Confirmar/Cancelar a migrar;
*     cria-lo seria inventar botao (viola o PILAR 1) e o handler nasceria
*     vazio (viola a regra de completude). O unico botao TEM handler:
*     BtnEncerrarClick.
*   BtnBuscarClick - nao ha campo de filtro nem botao de busca: a tela abre
*     ja filtrada pelo produto que o form pai informa (this_cProduto), que eh
*     o que CarregarLista() consome.
*   FormParaBO - transfere CAMPO EDITAVEL para o BO. Os dois unicos TextBox
*     tem "When / Return .f." no legado: nunca entram em edicao, nunca
*     recebem digitacao do usuario e nada deles tem de voltar ao BO. O
*     sentido que existe de verdade - BO -> campo - esta em BOParaForm().
*   HabilitarCampos - alterna campo entre editavel e somente-leitura por
*     MODO (INCLUIR/ALTERAR/VISUALIZAR). Aqui nao ha modo nem campo
*     editavel: o estado somente-leitura eh invariante, declarado uma vez em
*     ConfigurarPaginaDados (ReadOnly/TabStop) e no Grid (ReadOnly = .T.),
*     exatamente como o legado o declara.
*   AjustarBotoesPorModo - idem: um unico botao, sempre habilitado, sem modo
*     que o afete. O legado tampouco desabilita o "ok" em qualquer caminho.
*
* Ja entregues e consolidados nas fases anteriores, revisados aqui:
* BOParaForm, LimparCampos e CarregarLista (este ultimo PUBLIC, como o
* harness de teste automatizado exige - regra #3).
*==============================================================================

DEFINE CLASS FormSigOpEmp AS FormBase

    DataSession = 2
    ShowWindow = 1
    BorderStyle = 2
    Height      = 600
    Width       = 800
    AutoCenter  = .T.
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    TitleBar    = 0
    WindowState = 0
    ShowWindow  = 0
    WindowType  = 0

    *-- Referencia ao form pai (equivalente a ThisForm.ParentForm/poForm do legado)
    this_oParentForm = .NULL.

    *-- Codigo do produto cujos empenhos sao exibidos (equivalente a
    *-- Alltrim(crSigMvEtr.Cpros), lido da data session do form pai no Init)
    this_cProduto = ""

    *--------------------------------------------------------------------------
    * Init - recebe o form pai e o numero da data session do pai (equivalente
    * a LParameters poForm, pnDatSes do legado); monta o Caption com CHR() e
    * resolve o produto filtrado antes de delegar ao FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_oParentForm, par_nDataSes

        THIS.Caption = "Empenho"

        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
        ENDIF

        THIS.this_cProduto = THIS.ObterProdutoDoFormPai(par_nDataSes)

        IF !EMPTY(THIS.this_cProduto)
            THIS.Caption = "Empenho - " + ALLTRIM(THIS.this_cProduto)
        ENDIF

        THIS.Icon = gc_4c_CaminhoIcones + "4Control1.ico"

        *-- ShowWindow/WindowType=1 na classe causaria TIMEOUT em VFP9 -T (top-
        *-- level window bloqueante) durante testes headless. Classe definida
        *-- com ShowWindow=0/WindowType=0; producao restaura modal top-level
        *-- aqui (mesmo padrao de FormSigOpChc/FormICD).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType  = 1
            THIS.ShowWindow  = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutoDoFormPai - le crSigMvEtr.Cpros na data session do form pai
    * (equivalente a Alltrim(crSigMvEtr.Cpros) do legado), trocando para ela
    * TEMPORARIAMENTE (mesmo padrao de FormGrupo.prg) e restaurando a sessao
    * corrente em seguida - ao contrario do legado, que troca e nunca
    * restaura.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProdutoDoFormPai(par_nDataSes)
        LOCAL loc_nSessaoAtual, loc_cProduto, loc_oErro

        loc_cProduto     = ""
        loc_nSessaoAtual = SET("DATASESSION")

        IF VARTYPE(par_nDataSes) = "N" AND par_nDataSes > 0
            TRY
                SET DATASESSION TO (par_nDataSes)
                IF USED("crSigMvEtr") AND !EOF("crSigMvEtr")
                    loc_cProduto = ALLTRIM(TratarNulo(crSigMvEtr.Cpros, ""))
                ENDIF
            CATCH TO loc_oErro
                loc_cProduto = ""
            ENDTRY
            SET DATASESSION TO (loc_nSessaoAtual)
        ENDIF

        RETURN loc_cProduto
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpEmpBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpEmpBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ELSE
                THIS.this_oBusinessObject.this_cProduto = THIS.this_cProduto

                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                THIS.ConfigurarOrdemTabulacao()

                *-- O bypass de validacao de UI cerca SO o trecho que depende
                *-- de SQL/conexao. Um RETURN no TOPO deste metodo (como
                *-- estava) pularia tambem THIS.Picture e TODA a montagem
                *-- visual: a etapa de UI Fidelity instanciaria um form vazio
                *-- e nenhuma diferenca seria corrigivel, porque o metodo que
                *-- escreve a propriedade nunca teria rodado.
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (dialogo flat, sem Lista/Dados do CRUD).
    *
    * A ORDEM reproduz a ordem dos objetos no SCX legado (cntSombra, Shape1,
    * ok, get_NGrupo, Get_NConta, grdItens), porque em VFP9 o AddObject
    * define o z-order: o ultimo criado desenha POR CIMA. Importa aqui
    * porque Shape1 (Left 768..788, Top 7..24) fica DENTRO da area do botao
    * Encerrar (Left 725..800, Top 3..78) - criar o Shape DEPOIS do botao o
    * poria sobre ele. ConfigurarPaginaDados vem entao ANTES de
    * ConfigurarBotoes, igual ao legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarGrid()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - cria os controles de DADOS do dialogo, todos
    * filhos DIRETOS do Form (nao ha PageFrame nem container de campos):
    *
    *   shp_4c_Shape1  (SIGOPEMP.Shape1)      Top=7   Left=768 20x17
    *   txt_4c__NGrupo (SIGOPEMP.get_NGrupo)  Top=465 Left=68  360x21
    *   txt_4c_NConta  (SIGOPEMP.Get_NConta)  Top=488 Left=68  360x21
    *
    * Propriedades TRANSCRITAS do dump legado, incluindo o par
    * Format/InputMask (CLAUDE.md regra #49 - o migrador costuma descartar
    * os dois). Nao ha `Say`/Label nenhum para esses dois campos no SCX: a
    * SECAO 1 do dump lista apenas cntSombra+2 labels, Shape1, ok,
    * get_NGrupo, Get_NConta e grdItens - os dois campos ficam sem legenda
    * no legado, e inventar rotulo aqui violaria o PILAR 1.
    *
    * ZOrderSet = 3 do dump NAO eh transcrito: eh bookkeeping do Form
    * Designer, nao existe em runtime e estouraria "Property ZORDERSET is
    * not found" no Init (CLAUDE.md regra #33).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape1: decorativo, BackStyle=0 (sem preenchimento) e
        *-- BorderStyle=0 (sem borda) exatamente como o dump. Shape NAO tem
        *-- ForeColor/BackColor - a cor mora em BorderColor/FillColor
        *-- (CLAUDE.md regra #33), por isso 136,189,188 vai em .BorderColor.
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 768
            .Width       = 20
            .Height      = 17
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- get_NGrupo: descricao do Grupo Destino da linha corrente da grade
        *-- (SigCdGcr.Descrs). O legado tem `PROCEDURE When / Return .f.`,
        *-- isto eh, o campo NUNCA entra em edicao - eh so visor. O
        *-- equivalente no sistema novo eh ReadOnly = .T. + TabStop = .F.
        *-- (When por BINDEVENT nao eh confiavel em TextBox, CLAUDE.md regra
        *-- #3, e BINDEVENT descarta o retorno do delegate, entao um When
        *-- ligado por BINDEVENT nao bloquearia nada).
        THIS.AddObject("txt_4c__NGrupo", "TextBox")
        WITH THIS.txt_4c__NGrupo
            .Top           = 465
            .Left          = 68
            .Width         = 360
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Format        = "K!"
            .MaxLength     = 50
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
        ENDWITH

        *-- Get_NConta: descricao da Conta Destino da linha corrente da grade
        *-- (SigCdCli.Rclis). Mesmo `When / Return .f.` do get_NGrupo.
        THIS.AddObject("txt_4c_NConta", "TextBox")
        WITH THIS.txt_4c_NConta
            .Top           = 488
            .Left          = 68
            .Width         = 360
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Themes        = .F.
            .Format        = "K!"
            .MaxLength     = 50
            .Value         = ""
            .ReadOnly      = .T.
            .TabStop       = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - espelha nos dois visores as descricoes que o BO resolveu
    * para a linha corrente da grade (this_cDescricaoGrupo <- SigCdGcr.Descrs,
    * this_cDescricaoConta <- SigCdCli.Rclis), equivalente as duas atribuicoes
    * do AfterRowColChange legado.
    *
    * PROTECTED de proposito, e NAO ha como alargar: eh override de um HOOK
    * que a FormBase ja declara PROTECTED (formbase.prg:280), e em VFP9 o
    * PROTECTED da classe base PREVALECE sobre o override sem modificador
    * (CLAUDE.md regra #51) - medido aqui: chamar de fora estoura "Property
    * BOPARAFORM is not found". So eh chamado por THIS.BOParaForm(), de
    * DENTRO da classe (CarregarLista e, na Fase 7, o handler da grade - que
    * ai sim eh PUBLIC, como BINDEVENT exige).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        TRY
            THIS.txt_4c__NGrupo.Value = TratarNulo( ;
                THIS.this_oBusinessObject.this_cDescricaoGrupo, "")

            THIS.txt_4c_NConta.Value = TratarNulo( ;
                THIS.this_oBusinessObject.this_cDescricaoConta, "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - zera os dois visores de descricao. Chamado quando a
    * grade esta vazia ou fica sem registro corrente: o AfterRowColChange
    * legado tambem grava '' nos dois campos quando o CursorQuery nao acha a
    * descricao (Iif(..., evaluate(...), '')), entao campo vazio eh estado
    * previsto e nao erro.
    *
    * PROTECTED pelo mesmo motivo do BOParaForm: a FormBase declara este hook
    * PROTECTED (formbase.prg:276) e o override nao alarga o escopo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c__NGrupo.Value = ""
        THIS.txt_4c_NConta.Value  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - cria grd_4c_Dados (equivalente a grdItens do legado) e
    * liga as 7 colunas ao cursor_4c_Empenhado - mesmas colunas, legendas e
    * larguras do PROCEDURE montagrades legado (Emp/Operacao/Codigo/Data/
    * Grupo/Conta/Qtde). O cursor placeholder eh criado ANTES de ligar o
    * ControlSource: Column.ControlSource de alias ainda inexistente derruba
    * o Init (CLAUDE.md regra #41) - CriarCursorEmpenhado() eh o ponto UNICO
    * de CREATE CURSOR desta tela, com a MESMA estrutura usada depois por
    * BuscarEmpenhosDoProduto().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid, loc_cCursor

        THIS.this_oBusinessObject.CriarCursorEmpenhado()
        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top               = 122
            .Left              = 37
            .Width             = 725
            .Height            = 343
            .FontName          = "Tahoma"
            .HeaderHeight      = 17
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ReadOnly          = .T.
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .ColumnCount       = 7
            .RecordSource      = loc_cCursor
        ENDWITH

        loc_oGrid.Column1.ControlSource = loc_cCursor + ".Emps"
        loc_oGrid.Column2.ControlSource = loc_cCursor + ".Dopes"
        loc_oGrid.Column3.ControlSource = loc_cCursor + ".Numes"
        loc_oGrid.Column3.InputMask     = "999999"
        loc_oGrid.Column4.ControlSource = loc_cCursor + ".Datas"
        loc_oGrid.Column5.ControlSource = loc_cCursor + ".GrupoDs"
        loc_oGrid.Column6.ControlSource = loc_cCursor + ".ContaDs"
        loc_oGrid.Column7.ControlSource = loc_cCursor + ".Qtds"
        loc_oGrid.Column7.InputMask     = "9999999.99"

        loc_oGrid.Column1.Width = 31
        loc_oGrid.Column2.Width = 206
        loc_oGrid.Column3.Width = 60
        loc_oGrid.Column4.Width = 80
        loc_oGrid.Column5.Width = 80
        loc_oGrid.Column6.Width = 80
        loc_oGrid.Column7.Width = 80

        loc_oGrid.Column1.Header1.Caption = "Emp"
        loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
        loc_oGrid.Column4.Header1.Caption = "Data"
        loc_oGrid.Column5.Header1.Caption = "Grupo"
        loc_oGrid.Column6.Header1.Caption = "Conta"
        loc_oGrid.Column7.Header1.Caption = "Qtde"

        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column3.Header1.Alignment = 2
        loc_oGrid.Column4.Header1.Alignment = 2
        loc_oGrid.Column5.Header1.Alignment = 2
        loc_oGrid.Column6.Header1.Alignment = 2
        loc_oGrid.Column7.Header1.Alignment = 2

        loc_oGrid.Column1.Header1.FontSize = 8
        loc_oGrid.Column2.Header1.FontSize = 8
        loc_oGrid.Column3.Header1.FontSize = 8
        loc_oGrid.Column4.Header1.FontSize = 8
        loc_oGrid.Column5.Header1.FontSize = 8
        loc_oGrid.Column6.Header1.FontSize = 8
        loc_oGrid.Column7.Header1.FontSize = 8

        loc_oGrid.Column1.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column3.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column4.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column5.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column6.Header1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column7.Header1.ForeColor = RGB(0, 0, 0)

        *-- O PROCEDURE montagrades legado reatribui, no FOR final, Movable/
        *-- Resizable/ReadOnly e FontName de TODA coluna (inclusive do Text1)
        *-- para "Courier New" - isso PREVALECE sobre o FontName Tahoma
        *-- declarado nas propriedades iniciais do grid.
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column2.Movable   = .F.
        loc_oGrid.Column3.Movable   = .F.
        loc_oGrid.Column4.Movable   = .F.
        loc_oGrid.Column5.Movable   = .F.
        loc_oGrid.Column6.Movable   = .F.
        loc_oGrid.Column7.Movable   = .F.

        loc_oGrid.Column1.Resizable = .F.
        loc_oGrid.Column2.Resizable = .F.
        loc_oGrid.Column3.Resizable = .F.
        loc_oGrid.Column4.Resizable = .F.
        loc_oGrid.Column5.Resizable = .F.
        loc_oGrid.Column6.Resizable = .F.
        loc_oGrid.Column7.Resizable = .F.

        loc_oGrid.Column1.ReadOnly = .T.
        loc_oGrid.Column2.ReadOnly = .T.
        loc_oGrid.Column3.ReadOnly = .T.
        loc_oGrid.Column4.ReadOnly = .T.
        loc_oGrid.Column5.ReadOnly = .T.
        loc_oGrid.Column6.ReadOnly = .T.
        loc_oGrid.Column7.ReadOnly = .T.

        loc_oGrid.Column1.FontName = "Courier New"
        loc_oGrid.Column2.FontName = "Courier New"
        loc_oGrid.Column3.FontName = "Courier New"
        loc_oGrid.Column4.FontName = "Courier New"
        loc_oGrid.Column5.FontName = "Courier New"
        loc_oGrid.Column6.FontName = "Courier New"
        loc_oGrid.Column7.FontName = "Courier New"

        loc_oGrid.Column1.Text1.FontName  = "Courier New"
        loc_oGrid.Column2.Text1.FontName  = "Courier New"
        loc_oGrid.Column3.Text1.FontName  = "Courier New"
        loc_oGrid.Column4.Text1.FontName  = "Courier New"
        loc_oGrid.Column5.Text1.FontName  = "Courier New"
        loc_oGrid.Column6.Text1.FontName  = "Courier New"
        loc_oGrid.Column7.Text1.FontName  = "Courier New"

        loc_oGrid.Column1.Text1.ReadOnly  = .T.
        loc_oGrid.Column2.Text1.ReadOnly  = .T.
        loc_oGrid.Column6.Text1.ReadOnly  = .T.
        loc_oGrid.Column7.Text1.ReadOnly  = .T.

        loc_oGrid.Column1.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column2.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column3.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column4.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column5.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column6.Text1.ForeColor = RGB(0, 0, 0)

        loc_oGrid.Column1.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column2.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column3.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column4.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column5.Text1.BackColor = RGB(255, 255, 255)
        loc_oGrid.Column6.Text1.BackColor = RGB(255, 255, 255)

        *-- Coluna 5 (Grupo): Text1.Alignment = 3 (direita) no dump legado
        loc_oGrid.Column5.Text1.Alignment = 3

        *-- Coluna 7 (Qtde): destaque em negrito + fundo amarelo claro, igual
        *-- ao dump legado (Column7.FontBold / Column7.BackColor)
        loc_oGrid.Column7.FontBold        = .T.
        loc_oGrid.Column7.Text1.FontBold  = .T.
        loc_oGrid.Column7.Text1.ForeColor = RGB(0, 0, 0)
        loc_oGrid.Column7.Text1.BackColor = RGB(255, 255, 170)

        *-- Unico evento de dados do form: ao trocar a linha corrente, o
        *-- legado resolve as descricoes de Grupo/Conta e as mostra nos dois
        *-- visores (grdItens.AfterRowColChange). Ligado por BINDEVENT porque
        *-- o Grid eh criado por AddObject e nao ha subclasse onde declarar o
        *-- evento; o delegate eh PUBLIC (CLAUDE.md regra #3).
        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria cmd_4c_Ok (equivalente ao botao "ok" do legado,
    * Caption "Encerrar", que apenas fecha o dialogo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - equivalente a ThisForm.Release() do botao "ok"
    * legado (Caption "Encerrar"). Nome canonico exigido pelo harness de
    * teste automatizado (TesteBtnEncerrarExiste em TesteAutomatico.prg).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - handler de grd_4c_Dados.AfterRowColChange,
    * equivalente ao grdItens.AfterRowColChange do legado:
    *
    *   thisform.get_NGrupo.Value = Iif(...CursorQuery('SigCdGcr','crSigCdGcr',
    *                                    'codigos',crEmpenhado.GrupoDs,[Descrs])
    *                                    ,evaluate('crSigCdGcr.Descrs'),'')
    *   thisform.get_NConta.Value = Iif(...CursorQuery('SigCdCli','crSigCdCli',
    *                                    'iclis',crEmpenhado.ContaDs,[Rclis])
    *                                    ,evaluate('crSigCdCli.Rclis'),'')
    *
    * As duas consultas ficam no BO (ObterDescricaoGrupo/ObterDescricaoConta,
    * chamadas por CarregarDoCursor); aqui o handler so le a linha corrente e
    * espelha o resultado nos visores via BOParaForm(). Descricao nao
    * encontrada vira string vazia nos dois lados - o Iif(...,'') do legado faz
    * o mesmo, entao campo vazio eh estado previsto e NAO erro.
    *
    * SEM filtro por par_nColIndex, igual ao legado: este handler carrega o
    * DETALHE da linha corrente, que eh o uso CORRETO de AfterRowColChange
    * (CLAUDE.md regra #46 - o que a regra proibe eh validar CELULA aqui,
    * filtrando a coluna, porque nColIndex eh a coluna de DESTINO). O
    * parametro eh declarado porque o evento o passa (regra #3), mesmo sem uso.
    *
    * PUBLIC obrigatoriamente: BINDEVENT em metodo PROTECTED falha em silencio
    * (regra #3). Por isso o corpo chama os hooks PROTECTED BOParaForm/
    * LimparCampos de DENTRO da classe, com THIS. (regra #8).
    *
    * NAO chama Refresh no grid - o legado tambem nao chama, e Refresh aqui
    * redispararia o proprio AfterRowColChange. Atribuir .Value aos dois
    * TextBox nao mexe no ponteiro do cursor da grade, entao nao ha
    * reentrancia a cercar.
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCursor, loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        TRY
            IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0 ;
                    AND !EOF(loc_cCursor) AND !BOF(loc_cCursor)
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                THIS.BOParaForm()
            ELSE
                *-- Grade vazia ou sem registro corrente: sem linha nao ha
                *-- Grupo/Conta a descrever.
                THIS.LimparCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em GradeAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - popula cursor_4c_Empenhado com os empenhos do produto
    * filtrado (THIS.this_cProduto, resolvido no Init a partir da data
    * session do form pai) e repinta o grid - popular o cursor NAO repinta a
    * grade por si so (CLAUDE.md regra #21): GO TOP + Refresh sao
    * obrigatorios apos a carga.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = THIS.this_oBusinessObject.BuscarEmpenhosDoProduto( ;
            go_4c_Sistema.cCodEmpresa, THIS.this_cProduto)

        loc_cCursor = THIS.this_oBusinessObject.this_cCursorLista

        IF USED(loc_cCursor)
            GO TOP IN (loc_cCursor)
            THIS.grd_4c_Dados.Refresh()

            *-- Linha 1 ja fica corrente, mas o AfterRowColChange NAO dispara
            *-- na carga - entao os dois visores de descricao sao populados
            *-- aqui, senao abririam vazios com a grade cheia.
            IF RECCOUNT(loc_cCursor) > 0 AND !EOF(loc_cCursor)
                THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
                THIS.BOParaForm()
            ELSE
                THIS.LimparCampos()
            ENDIF
        ELSE
            THIS.LimparCampos()
        ENDIF

        IF !loc_lSucesso AND !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Empenho")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria cnt_4c_Sombra (equivalente a cntSombra do
    * legado) com os labels de sombra e titulo.
    * Propriedades TRANSCRITAS do dump (SIGOPEMP.cntSombra/lblSombra/
    * lblTitulo): Top=0/Left=0/Width=800/Height=80/BackColor=100,100,100 no
    * container; labels com Left=10/Width=769, lblSombra Top=25/Height=40,
    * lblTitulo Top=24/Height=46/ForeColor branco.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCab = THIS.cnt_4c_Sombra
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .AutoSize      = .F.
            .Width         = 769
            .Height        = 40
            .Top           = 25
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .AutoSize  = .F.
            .Width     = 769
            .Height    = 46
            .Top       = 24
            .Left      = 10
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .Alignment = 0
            .BackStyle = 0
            .WordWrap  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - reproduz a ORDEM DE TABULACAO do legado.
    *
    * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
    * tem relacao com a do SCX. Nao ha erro, nao ha log e nao aparece em
    * screenshot - so o Tab andando na ordem errada. Aqui o efeito era
    * concreto: o Encerrar vinha ANTES da grade.
    *
    * Os valores do dump (ok=11, get_NGrupo=81, Get_NConta=84, grdItens=2)
    * NAO podem ser transcritos ao pe da letra: o VFP aplica o TabIndex no
    * instante em que CRIA cada objeto e DESCARTA, em silencio, valor acima
    * do numero de controles tab-aveis existentes naquele momento. Medido no
    * VFP9 (automation\medir_tabindex_729.prg), simulando o load na ordem dos
    * registros do SCX: so o 2 da grade sobrevive; 11/81/84 sao descartados.
    *
    *   objeto      | dump | EFETIVO no legado
    *   cntSombra   |  --  | 1
    *   grdItens    |   2  | 2   <- unico valor do dump que sobrevive
    *   ok          |  11  | 3
    *   get_NGrupo  |  81  | 4
    *   Get_NConta  |  84  | 5
    *
    * Por isso aqui vao os ordinais EFETIVOS, com o valor do dump no
    * comentario - escrever "11"/"81"/"84" afirmaria um TabIndex que o
    * objeto nunca guarda e custaria tempo a quem auditar dump x migrado.
    *
    * Medido na MESMA rodada, com a ordem de criacao deste form:
    *   sem este metodo -> cnt=1, NGrupo=2, NConta=3, Ok=4, Grade=5 (ERRADO:
    *                      Encerrar antes da grade, grade em ULTIMO)
    *   com este metodo -> cnt=1, Grade=2, Ok=3, NGrupo=4, NConta=5 (= legado)
    *
    * Tres cuidados que a medicao confirmou:
    *   - ASCENDENTE: cada atribuicao poe o controle na posicao pedida e
    *     empurra os demais para tras; descendente TROCA pares de lugar.
    *   - DEPOIS de todos os AddObject (chamado no fim de InicializarForm).
    *   - Shape NAO TEM TabIndex (medido: PEMSTATUS devolve .F.), por isso
    *     shp_4c_Shape1 fica fora da sequencia e cada atribuicao eh guardada
    *     por PEMSTATUS no PROPRIO controle - PEMSTATUS(THIS, "<nome>", 5) so
    *     diria que o membro existe no form e o metodo quebraria no Shape com
    *     "Property TABINDEX is not found".
    *
    * Os dois TextBox entram na sequencia por fidelidade, mas estao FORA do
    * ciclo do Tab nos dois lados: no legado por "When / Return .f." e aqui
    * por TabStop = .F. (ver ConfigurarPaginaDados). Na pratica o ciclo
    * visivel eh grade -> Encerrar, como no legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        LOCAL loc_nSeq, loc_nI, loc_cNome, loc_aOrdem[5]

        *-- Ordem EFETIVA do legado (ver tabela no cabecalho deste metodo)
        loc_aOrdem[1] = "cnt_4c_Sombra"     && SCX cntSombra  - sem TabIndex
        loc_aOrdem[2] = "grd_4c_Dados"      && SCX grdItens   - TabIndex 2
        loc_aOrdem[3] = "cmd_4c_Ok"         && SCX ok         - TabIndex 11 (descartado no load)
        loc_aOrdem[4] = "txt_4c__NGrupo"    && SCX get_NGrupo - TabIndex 81 (descartado no load)
        loc_aOrdem[5] = "txt_4c_NConta"     && SCX Get_NConta - TabIndex 84 (descartado no load)

        *-- Contador PROPRIO e sequencial: usar o indice do laco abriria
        *-- lacuna ao pular um controle, e valor FORA da faixa 1..N (N = so
        *-- os controles que TEM TabIndex) eh descartado em silencio.
        loc_nSeq = 0

        FOR loc_nI = 1 TO ALEN(loc_aOrdem)
            loc_cNome = loc_aOrdem[loc_nI]

            IF PEMSTATUS(THIS, loc_cNome, 5)
                *-- Guard no CONTROLE, nao no form: Shape nao tem TabIndex
                IF PEMSTATUS(EVALUATE("THIS." + loc_cNome), "TabIndex", 5)
                    loc_nSeq = loc_nSeq + 1
                    STORE loc_nSeq TO ("THIS." + loc_cNome + ".TabIndex")
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
