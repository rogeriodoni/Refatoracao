*==============================================================================
* FormSigOpDmp.prg - Cadastro de Demonstrativos de Balanco
* Migrado de: SigOpDmp.SCX (classe legada frmcadastro) - task722
*
* Tabela mestre : SigPrDmo (nome, grupos, contas, cidchaves)
* Tabela detalhe: SigCdDpr (fases do demonstrativo - grade da pagina Dados)
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL
*   Fases 1-2 : SigOpDmpBO (propriedades, Init, CarregarDoCursor, Inserir,
*               Atualizar) + Buscar, que alimenta cursor_4c_Dados - o cursor
*               da grade entregue nesta fase.
*   Fase  3   : DEFINE CLASS + estado, Init, InicializarForm,
*               ConfigurarPageFrame (Page1 = Lista / Page2 = Dados) e a faixa
*               cinza do cabecalho nas DUAS paginas (CLAUDE.md regra #11).
*   Fase  4   : grade da Lista (coluna Nome, espelhando o pColuna do Init
*               legado), os 5 botoes CRUD, o Encerrar, Confirmar/Cancelar da
*               pagina Dados, CarregarLista, AlternarPagina e
*               AjustarBotoesPorModo.
*   Fase  5   : os campos da PARTE 1 da pagina Dados - a linha Nome
*               (Say1/GetNome do SCX) e a linha Grupo Sd Inicial
*               (Label1/Get_Grupo/Get_DGrupo).
*   Fase  6   : a linha Conta Sd Inicial (Label2/Get_Conta/Get_DConta), a
*               grade de fases (Grade - SigCdDpr, 5 colunas) com as celulas
*               editaveis e os botoes Inserir/Excluir de LINHA, os 7 lookups
*               (Grupo, DGrupo, Conta, DConta e as celulas Fase, Funcionario
*               e Tipo Operacao), as validacoes de Ordem e E/S, e o
*               AtualizarEstadoCampos que reproduz os "When" do legado.
*   Fase  7   : BINDEVENT dos 4 primeiros botoes CRUD e as regras do
*               Grupo_op.Click - os tres verbos que carregam registro
*               existente (AbrirFichaDoRegistro), o IniciaDesc
*               (CarregarDescricoesMestre), o Requery de SigCdDpr
*               (CarregarFasesDoBanco), o Zap do ramo INSERIR (LimparFases),
*               o Cancelar e o Encerrar.
*   Fase  8   : o Confirmar (BtnSalvarClick e o Do Case do Salva.Click do
*               frmcadastro) com a PERSISTENCIA da grade de fases
*               (SigOpDmpBO.GravarFases), a exclusao (ExcluirFicha +
*               ExcluiItens), o Buscar por exemplo (BtnBuscarClick +
*               ExecutarBuscaPorNome = msv_procurar), o FormParaBO, o
*               HabilitarCampos e o par Commit/RollBack do poDataMgr.
*
* Cursores desta tela:
*   cursor_4c_Dados - mestre (SigPrDmo), grade da pagina Lista, alimentado
*                     por SigOpDmpBO.Buscar (Fases 1-2).
*   cursor_4c_Fases - detalhe (SigCdDpr), grade da pagina Dados. Equivale ao
*                     crSigCdDpr do AddCursor do Init legado, que nasce VAZIO
*                     (sNome = Space(20) nao casa nenhuma linha) e so e'
*                     recarregado pelo Grupo_op.Click - Fases 7-8. Aqui ele e'
*                     criado como placeholder com a estrutura EXATA de
*                     SigCdDpr, porque ligar Column.ControlSource a um cursor
*                     inexistente derruba o Init e a tela nao abre (regra #41).
*
* Notas de fidelidade (PILAR 1):
*   - O SCX legado tem Caption = (prompt()), resolvido em tempo de execucao a
*     partir do prompt da barra de menu. O dump nao traz o texto literal, logo
*     o Caption fixo abaixo acompanha o cabecalho do SigOpDmpBO (Fases 1-2) e
*     sera o mesmo texto do DEFINE BAR no menu.prg.
*   - Pagina.Dados.Picture = imagens\new_background.jpg vem do SCX. A pagina
*     Lista nao e sobrescrita no SCX: usa a textura canonica do form de
*     1000px de largura (fundo_cad_1003.jpg).
*   - Grupo_op (Left=338) e Grupo_Saida (Left=718) do SCX estao no espaco de
*     coordenadas do frmcadastro de 800px. O form novo tem 1000px e usa os
*     valores canonicos 542 e 917 (CLAUDE.md regra #10).
*   - Pagina.Top = -29 no legado: todo controle das Pages compensa +29 no Top.
*==============================================================================

DEFINE CLASS FormSigOpDmp AS FormBase

    *-- Propriedades visuais (PILAR 1 - frmcadastro: 1000x600, sem barra de titulo)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Demonstrativos de Balan" + CHR(231) + "o"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Guarda de reentrancia dos lookups (regra #37/#47): o FormBuscaAuxiliar
    *-- e MODAL, tira o foco do campo e redispara o proprio LostFocus que o
    *-- abriu - sem a flag sobem DOIS pickers. Ligada e desligada no FUNIL
    *-- (AbrirLookup*), que atende as tres portas: LostFocus, F4/F5 e DblClick.
    this_lEmLookup       = .F.

    *-- Guarda "ultimo valor validado" dos 4 campos de ficha com lookup em
    *-- LostFocus (Grupo/DGrupo/Conta/DConta). LostFocus dispara SEMPRE que o
    *-- foco sai do campo, mesmo sem digitacao - diferente do Valid do
    *-- legado; sem esta guarda, so tabular pelos campos repete o
    *-- SQLEXEC/CreateObject("FormBuscaAuxiliar") a cada passagem, mesmo com
    *-- o valor inalterado. Declarado com "" aqui (DEFINE CLASS so aceita
    *-- literal, nunca CHR() - a sentinela CHR(1) e atribuida em
    *-- InicializarForm, onde chamada de funcao e permitida).
    this_cUltimoValidarGrupoLostFocusValidado  = ""
    this_cUltimoValidarDGrupoLostFocusValidado = ""
    this_cUltimoValidarContaLostFocusValidado  = ""
    this_cUltimoValidarDContaLostFocusValidado = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: apenas RETURN DODEFAULT().
    * FormBase.Init() ja chama InicializarForm() - NUNCA duplicar a chamada.
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Cria o Business Object e monta a estrutura do form
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Sentinela da guarda "ultimo valor validado" dos 4 lookups da
            *-- ficha (CHR(1): nenhum valor real de ALLTRIM e igual a ele,
            *-- logo a 1a chamada de cada handler sempre executa por
            *-- completo). Atribuido aqui porque DEFINE CLASS so aceita
            *-- literal no default da property.
            THIS.this_cUltimoValidarGrupoLostFocusValidado  = CHR(1)
            THIS.this_cUltimoValidarDGrupoLostFocusValidado = CHR(1)
            THIS.this_cUltimoValidarContaLostFocusValidado  = CHR(1)
            THIS.this_cUltimoValidarDContaLostFocusValidado = CHR(1)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpDmpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SigOpDmpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSigOpDmp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                *-- Titulo das faixas das DUAS paginas (legado: lblSombra/lblTitulo
                *-- recebem ThisForm.Caption no Init do frmcadastro)
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                *-- Carga inicial da grade da Lista.
                *-- gb_4c_ValidandoUI = .T. significa ValidarUIFidelity rodando
                *-- sem conexao SQL: nao consultar o banco (Problema 8).
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.AjustarBotoesPorModo()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSigOpDmp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - PageFrame com Page1 (Lista) e Page2 (Dados)
    * Legado: Pagina.PageCount=2, Top=-29, Left=0, abas escondidas.
    * Top=-29 esconde as abas; os controles das Pages compensam +29 no Top.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 = Lista (legado: Pagina.Page1.Name = "Lista")
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 = Dados (legado: Pagina.Page2.Name = "Dados", com a
            *-- Picture sobrescrita no SCX para new_background.jpg)
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Monta a Page1 (faixa, botoes CRUD, saida, grade)
    * A faixa do cabecalho e o PRIMEIRO AddObject da pagina (regra #11): os
    * containers de botao ficam em Top=29, DENTRO da area da faixa, e so
    * aparecem se criados DEPOIS dela.
    * A grade espelha o pColuna do Init legado: UMA coluna (Nome). O bind do
    * RecordSource/ControlSource fica em CarregarLista, porque a Page1 e
    * montada ANTES de o cursor existir (regra #41).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do cabecalho (legado: Pagina.Lista.cntSombra Top=2, Height=80,
        *-- BackColor=100,100,100; com a compensacao +29 do PageFrame -> Top=29)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarLabelsCabecalho(loc_oPagina.cnt_4c_Cabecalho)

        *-- Container dos botoes CRUD (legado: Pagina.Lista.Grupo_op Top=-1,
        *-- Width=389, Height=85, Left=338 no espaco de 800px).
        *-- Canonico do form de 1000px: Top=29 (-1+29), Left=542, Width=390.
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Os 5 botoes CRUD. Ordem e papel identicos ao Grupo_op do legado:
        *--   Inserir(5) Consultar(81) Alterar(157) Excluir(233) Procurar(309)
        *-- Os Left usados sao os do framework (5/80/155/230/305, passo 75),
        *-- obrigatorios para todo CRUD migrado conforme
        *-- docs\framework_frmcadastro_layout.md; o legado usa passo 76 e os
        *-- 5 botoes cabem nos dois esquemas (305+75=380 < 390).
        *-- Sem BINDEVENT nesta fase: BINDEVENT valida o delegado no REGISTRO,
        *-- entao vincular a metodo que ainda nao existe aborta o Init. Os
        *-- handlers dos 5 vem na Fase 7, junto com o Grupo_op.Click do legado.

        *-- Incluir (legado: Grupo_op.Inserir)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Visualizar (legado: Grupo_op.Consultar)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Alterar (legado: Grupo_op.Alterar)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Excluir (legado: Grupo_op.Excluir)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Buscar (legado: Grupo_op.Procurar).
        *-- ATENCAO Fase 7: o legado tem PROCEDURE msv_procurar, logo o
        *-- Procurar deste form e BUSCA POR EXEMPLO - NAO abre picker.
        *-- Ele poe o form em modo PROCURAR, limpa a ficha e habilita so o
        *-- campo Nome na pagina Dados; quem executa a consulta e o Confirmar,
        *-- que reproduz o msv_procurar (Set Near On, Seek pelo nome digitado,
        *-- Set Near Off) para posicionar a grade da Lista.
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- BINDEVENT dos 5 verbos CRUD. No legado os cinco botoes sao UM
        *-- CommandGroup e o verbo vem do Value (Grupo_op.Click(lnOpt), com
        *-- 1=INSERIR 2=CONSULTAR 3=ALTERAR 4=EXCLUIR 5=PROCURAR); aqui cada
        *-- Case do Do Case virou um handler PUBLIC proprio.
        *-- O Buscar (BtnBuscarClick) e BUSCA POR EXEMPLO - o legado tem
        *-- PROCEDURE msv_procurar - e quem executa a consulta e o Confirmar.
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")

        *-- Container de saida (legado: Pagina.Lista.Grupo_Saida Top=-1,
        *-- Left=718 no espaco de 800px). Padrao canonico (regra #10, que
        *-- prevalece sobre o PILAR 1): Left=917, Width=90, Height=85,
        *-- transparente.
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Encerrar (legado: Grupo_Saida.SAIR Top=5 Left=5). Caption, Width e
        *-- Height sao os canonicos da regra #10, nao os do SCX.
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grade da Lista (legado: Pagina.Lista.Grade). O SCX sobrescreve so
        *-- FontName="Tahoma", FontSize=8, RowHeight=16 e ForeColor=90,90,90;
        *-- a geometria vem da classe frmcadastro (Top=88 -> 117 com a
        *-- compensacao +29, Left=26, Height=498). Width=880 para a grade nao
        *-- correr por baixo de cnt_4c_Saida (Left=917).
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH as colunas
        *-- nao existem na linha seguinte).
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 1
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .FontName           = "Tahoma"
            .FontSize           = 8
            .RowHeight          = 16
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- Atalhos da grade (Fase 7). O Enter sobre a grade da Lista e
        *-- CONSULTAR no frmcadastro (KeyPress: nKeyCode=13 + ActiveControl
        *-- GRID -> Grupo_Op.Click(2)); o duplo clique nao existe no legado e
        *-- cai no MESMO funil. O handler de KeyPress declara os DOIS
        *-- parametros do evento, senao o VFP estoura "No PARAMETER statement
        *-- is found" a cada tecla (regra #3).
        BINDEVENT(loc_oPagina.grd_4c_Lista, "KeyPress", THIS, "GradeListaKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GradeListaDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Monta a Page2 (faixa e Confirmar/Cancelar)
    * A faixa tambem vai aqui (regra #11: cabecalho nas DUAS paginas) e e o
    * PRIMEIRO AddObject, antes do container de Confirmar/Cancelar.
    * PARTE 1 (Fase 5): a linha Nome e a linha Grupo Sd Inicial.
    * PARTE 2 (Fase 6): a linha Conta Sd Inicial, a grade de fases com os
    * botoes Inserir/Excluir de linha, os BINDEVENT dos lookups e o vinculo
    * da grade ao cursor de detalhe.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Faixa do cabecalho (mesmos valores canonicos da Page1)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.ConfigurarLabelsCabecalho(loc_oPagina.cnt_4c_Cabecalho)

        *-- Container Confirmar/Cancelar (legado: Pagina.Dados.Grupo_Salva,
        *-- com Salva em Left=5 e Cancelar em Left=80, ambos Top=5).
        *-- Canonico do form de 1000px: Top=33 (4+29), Left=842, Width=160.
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Confirmar (legado: Grupo_Salva.Salva). O Click e o despachante por
        *-- modo: grava o cabecalho e as fases em INCLUIR/ALTERAR, exclui em
        *-- EXCLUIR e executa o msv_procurar em PROCURAR (BtnSalvarClick).
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Cancelar (legado: Grupo_Salva.Cancelar, cujo Click chama
        *-- DoDefault() e, se plCancelar, mAtivapagina1 - ou seja, volta para a
        *-- pagina Lista). O handler esta completo nesta fase, por isso ele ja
        *-- recebe BINDEVENT: sem ele a pagina Dados nao teria saida.
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- ---------------------------------------------------------------
        *-- CAMPOS DA FICHA - PARTE 1: Nome e Grupo Sd Inicial
        *-- ---------------------------------------------------------------
        *-- No SCX legado os campos ficam DIRETO na Pagina.Dados (nao existe
        *-- container de campos), e todo Top compensa +29 porque
        *-- pgf_4c_Paginas.Top = -29. Nenhum deles fica abaixo de 109, logo
        *-- nenhum e' coberto pela faixa do cabecalho (regra #11).
        *--
        *-- Os labels sao criados ANTES dos TextBox vizinhos: a caixa de um
        *-- label com BackStyle = 0 nao pinta, mas interceptaria o clique no
        *-- campo se fosse desenhada por cima dele (regra #23).
        *--
        *-- ZOrderSet do dump NAO e' transcrito: e' propriedade so do Form
        *-- Designer e atribui-la em runtime derruba o Init (regra #33). O
        *-- legado nao chama ZOrder() em nenhum desses controles.

        *-- Say1 -> lbl_4c_Nome ("Nome : ", classe legada say).
        *-- A classe say e' AutoSize = .T., mas AutoSize e' no-op em Label
        *-- criado por AddObject e, com WordWrap, DESCARTA a Height (regra
        *-- #23): vai como .F. com os 39x15 do dump, que JA SAO o auto-size
        *-- calculado pelo Form Designer.
        *-- Alignment = 0 (esquerda) e ForeColor = 90,90,90 sao os da classe
        *-- say: branco aqui ficaria INVISIVEL, porque a Page tem Picture
        *-- clara por cima do BackColor (regra #12).
        loc_oPagina.AddObject("lbl_4c_Nome", "Label")
        WITH loc_oPagina.lbl_4c_Nome
            .Caption   = "Nome : "
            .Top       = 178
            .Left      = 172
            .Width     = 39
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- GetNome -> txt_4c_Nome (classe legada fwget).
        *-- O SCX sobrescreve Height/Left/Top/Width/MaxLength; FontName,
        *-- FontSize, Format = "K", Themes = .F. e as cores de desabilitado
        *-- vem da classe fwget.
        *-- Format = "K" seleciona o conteudo ao entrar no campo - sem o "!"
        *-- dos demais, ou seja este campo NAO forca maiuscula (regra #49).
        *-- MaxLength = 20 e' a largura de SigPrDmo.nome char(20), NUNCA o
        *-- Width em pixels (regra #19).
        *-- O legado usa ControlSource = "crSigPrDmo.nome"; na arquitetura
        *-- nova o valor trafega por FormParaBO/BOParaForm, entao o campo
        *-- nasce com .Value = "" e sem ControlSource.
        loc_oPagina.AddObject("txt_4c_Nome", "TextBox")
        WITH loc_oPagina.txt_4c_Nome
            .Value             = ""
            .Top               = 175
            .Left              = 214
            .Width             = 150
            .Height            = 23
            .MaxLength         = 20
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Format            = "K"
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Label1 -> lbl_4c_Grupo ("Grupo Sd Inicial : ", BaseClass label).
        *-- O dump declara AutoSize = .T. com Width = 86 e Height = 15; vale
        *-- a mesma regra #23 do label anterior - AutoSize = .F. e a
        *-- geometria transcrita.
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo Sd Inicial : "
            .Top       = 203
            .Left      = 125
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Grupo -> txt_4c_Grupo (codigo do grupo de saldo inicial).
        *-- Dump: FontName = "Courier New", Format = "K!", 80x25 em 214/169.
        *-- FontSize = 9 vem da tabela de fontes do SCX, que lista Courier New
        *-- so no tamanho 9 - e' o que o Get_Conta irmao declara explicitamente.
        *-- Format = "K!" seleciona ao entrar E forca MAIUSCULA; os dois
        *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
        *-- MaxLength = 10 = SigPrDmo.grupos char(10) (regra #19).
        *-- O legado usa ControlSource = "crSigPrDmo.Grupos".
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value             = ""
            .Top               = 198
            .Left              = 214
            .Width             = 80
            .Height            = 25
            .MaxLength         = 10
            .FontName          = "Courier New"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 0
            .Format            = "K!"
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Get_DGrupo -> txt_4c_DGrupo (descricao do grupo).
        *-- Campo SEM ControlSource no legado: ele e' preenchido pelo Valid de
        *-- Get_Grupo (crSigCdGcr.Descrs) e pelo IniciaDesc do form, e aceita
        *-- digitacao para buscar o grupo PELA descricao - por isso tem Valid
        *-- proprio e MaxLength = 20, embora SigCdGcr.descrs seja char(40).
        *-- Os dois numeros sao do dump e ficam como estao (PILAR 1).
        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Value             = ""
            .Top               = 198
            .Left              = 294
            .Width             = 271
            .Height            = 25
            .MaxLength         = 20
            .FontName          = "Courier New"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 0
            .Format            = "K!"
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- ---------------------------------------------------------------
        *-- CAMPOS DA FICHA - PARTE 2: Conta Sd Inicial
        *-- ---------------------------------------------------------------

        *-- Label2 -> lbl_4c_Conta ("Conta Sd Inicial : ", BaseClass label).
        *-- Criado ANTES dos TextBox da mesma linha (regra #23) e com
        *-- AutoSize = .F. + a geometria 86x15 do dump, que JA E' o auto-size
        *-- calculado pelo Form Designer - AutoSize = .T. e' no-op em Label
        *-- criado por AddObject e, com WordWrap, DESCARTA a Height.
        *-- ForeColor 90,90,90 (classe say/label do legado): branco ficaria
        *-- INVISIVEL sobre a Picture clara da Page (regra #12).
        *-- ZOrderSet = 3 do dump NAO e' transcrito (regra #33).
        loc_oPagina.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPagina.lbl_4c_Conta
            .Caption   = "Conta Sd Inicial : "
            .Top       = 228
            .Left      = 125
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .Alignment = 0
            .AutoSize  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Get_Conta -> txt_4c_Conta (codigo da conta de saldo inicial).
        *-- O dump declara explicitamente FontSize = 9 para o Courier New -
        *-- o mesmo tamanho que a tabela de fontes do SCX lista para essa
        *-- fonte e que o irmao Get_Grupo herda.
        *-- Format = "K!" seleciona ao entrar E forca MAIUSCULA; os dois
        *-- efeitos sao do legado e mudam o DADO digitado (regra #49).
        *-- MaxLength = 10 = SigPrDmo.contas char(10), NUNCA o Width em
        *-- pixels (regra #19).
        *-- O legado usa ControlSource = "crSigPrDmo.Contas"; na arquitetura
        *-- nova o valor trafega por FormParaBO/BOParaForm.
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value             = ""
            .Top               = 223
            .Left              = 214
            .Width             = 80
            .Height            = 25
            .MaxLength         = 10
            .FontName          = "Courier New"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 0
            .Format            = "K!"
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- Get_DConta -> txt_4c_DConta (descricao/nome da conta).
        *-- Campo SEM ControlSource no legado: e' preenchido pelo Valid de
        *-- Get_Conta (crSigCdCli.RClis) e pelo IniciaDesc do form, e aceita
        *-- digitacao para buscar a conta PELO NOME - por isso tem Valid
        *-- proprio e NAO pode nascer ReadOnly fixo, que apagaria a segunda
        *-- porta de entrada. Quem o habilita e' o AtualizarEstadoCampos,
        *-- que reproduz o "When" do legado.
        *-- MaxLength = 40 e' o do dump (SigCdCli.rclis e' char(50)): o
        *-- numero do SCX fica como esta (PILAR 1).
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value             = ""
            .Top               = 223
            .Left              = 294
            .Width             = 271
            .Height            = 25
            .MaxLength         = 40
            .FontName          = "Courier New"
            .FontSize          = 9
            .FontBold          = .F.
            .FontItalic        = .F.
            .FontUnderline     = .F.
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 0
            .Format            = "K!"
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(192, 192, 192)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .Visible           = .T.
        ENDWITH

        *-- ---------------------------------------------------------------
        *-- GRADE DE FASES (SigCdDpr) E OS BOTOES DE LINHA
        *-- ---------------------------------------------------------------
        THIS.ConfigurarGradeFases(loc_oPagina)

        *-- Inserir -> cmd_4c_InserirFase (legado: Pagina.Dados.Inserir, cujo
        *-- Click chama InsiraRegGrade e devolve o foco a' coluna Ordem).
        *-- Caption = "" e Picture 26px sao do dump: e' botao SO de icone, e
        *-- .Picture apontando para arquivo inexistente falha em SILENCIO
        *-- (regra #25) - cadastro_inserir_26.jpg conferido em vbmp\.
        *-- ForeColor 36,84,155 e BackColor 255,255,255 transcritos do dump.
        loc_oPagina.AddObject("cmd_4c_InserirFase", "CommandButton")
        WITH loc_oPagina.cmd_4c_InserirFase
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText   = "Inserir Fase"
            .Top           = 338
            .Left          = 607
            .Width         = 40
            .Height        = 40
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")

        *-- Excluir -> cmd_4c_ExcluirFase (legado: Pagina.Dados.Excluir).
        *-- NAO confundir com o cmd_4c_Excluir da pagina Lista (CRUD do
        *-- registro mestre): este exclui a LINHA da grade de fases.
        loc_oPagina.AddObject("cmd_4c_ExcluirFase", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcluirFase
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText   = "Excluir Fase"
            .Top           = 381
            .Left          = 607
            .Width         = 40
            .Height        = 40
            .FontName      = "Verdana"
            .FontSize      = 8
            .ForeColor     = RGB(36, 84, 155)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")

        *-- ---------------------------------------------------------------
        *-- LOOKUPS DOS CAMPOS DA FICHA (Valid do legado = ao SAIR do campo)
        *-- ---------------------------------------------------------------
        *-- O legado valida/abre o picker no "Valid" dos quatro campos, ou
        *-- seja ao SAIR deles -> "LostFocus", NUNCA "KeyPress" (regra #47):
        *-- ligado a KeyPress sem testar a tecla, o dialogo subiria a CADA
        *-- caractere e o usuario nao conseguiria terminar de digitar.
        *-- O F4/F5 e o duplo clique sao portas EXTRA para o mesmo funil, e
        *-- ali o handler TESTA par_nKeyCode antes de abrir.
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "LostFocus", THIS, "ValidarGrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "KeyPress",  THIS, "TxtGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "DblClick",  THIS, "TxtGrupoDblClick")

        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "LostFocus", THIS, "ValidarDGrupoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress",  THIS, "TxtDGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick",  THIS, "TxtDGrupoDblClick")

        BINDEVENT(loc_oPagina.txt_4c_Conta,  "LostFocus", THIS, "ValidarContaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "KeyPress",  THIS, "TxtContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "DblClick",  THIS, "TxtContaDblClick")

        BINDEVENT(loc_oPagina.txt_4c_DConta, "LostFocus", THIS, "ValidarDContaLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress",  THIS, "TxtDContaKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick",  THIS, "TxtDContaDblClick")

        *-- O "When" de Get_DGrupo/Get_DConta depende do valor CORRENTE do
        *-- campo de codigo irmao (IsEmpty(Get_Grupo.Value) / Get_Conta) e o
        *-- legado o reavalia a cada chegada de foco: esvaziar o codigo tem de
        *-- REABRIR a descricao. InteractiveChange cobre a digitacao.
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "AtualizarEstadoCampos")
        BINDEVENT(loc_oPagina.txt_4c_Conta, "InteractiveChange", THIS, "AtualizarEstadoCampos")

        *-- GetNome.Valid do legado: nome obrigatorio e, com a grade de fases
        *-- vazia, insere a primeira linha. Ligado em LostFocus pelo mesmo
        *-- motivo dos lookups.
        BINDEVENT(loc_oPagina.txt_4c_Nome, "LostFocus", THIS, "ValidarNomeLostFocus")

        *-- Ordem de tabulacao do legado, numerada de uma vez com a pagina
        *-- ja montada (ver AjustarOrdemTabulacao).
        THIS.AjustarOrdemTabulacao(loc_oPagina)

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Cursor de detalhe + vinculo da grade DEPOIS do TornarControlesVisiveis:
        *-- Column.ControlSource exige o cursor ABERTO, senao o Init estoura
        *-- "Alias not found" e a tela nao abre (regra #41).
        THIS.CriarCursorFases()
        THIS.VincularGradeFases()

        *-- Estado inicial dos campos conforme os "When" do legado.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *===========================================================================
    * ConfigurarLabelsCabecalho - Cria lbl_4c_Sombra/lbl_4c_Titulo na faixa
    * Fonte unica para as duas paginas (regra #11: os labels NUNCA ficam
    * pelados, e o Caption vem do Caption do form). O ForeColor branco e
    * legitimo aqui porque o container e OPACO e escuro (excecao da regra #12).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarLabelsCabecalho(par_oCabecalho)
        par_oCabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH par_oCabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oCabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH par_oCabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * AjustarOrdemTabulacao - Define a ordem de tabulacao da pagina Dados
    *
    * TabIndex NAO pode ser atribuido junto com o AddObject de cada controle.
    * Medido no VFP9 nesta tela: atribuir TabIndex REPOSICIONA o controle na
    * lista do container e EMPURRA os de indice >= N, entao o valor gravado
    * antes do proximo AddObject e desfeito pelo controle seguinte - o
    * txt_4c_Nome recebia 4 e terminava com 7, atras do txt_4c_DGrupo, com o
    * Tab saltando de "Nome :" direto para o grupo.
    *
    * A numeracao vai toda aqui, em ORDEM CRESCENTE e com a pagina ja montada:
    * ao por o controle no slot N, os slots 1..N-1 ja estao ocupados pelos
    * controles certos e so os de indice >= N sao empurrados - o resultado e
    * estavel. Fonte UNICA da ordem: nenhum bloco WITH acima atribui TabIndex.
    *
    * A sequencia e a do dump do SCX (Pagina.Dados): Grupo_Salva=1, Say1=2,
    * Label1=3, GetNome=4, Get_Grupo=5, Get_DGrupo=6, Get_Conta=7,
    * Get_DConta=8, Label2=9, Grade=10, Inserir=11, Excluir=12.
    * O cnt_4c_Cabecalho nao tem equivalente na Pagina.Dados legada (e a faixa
    * da regra #11) e por isso fica fora da lista, no fim: ele so contem Label,
    * que nao recebe foco.
    *
    * Os PEMSTATUS permanecem por seguranca: o metodo numera o que ja existe,
    * na ordem do legado, sem presumir que todo controle esteja criado.
    *===========================================================================
    PROTECTED PROCEDURE AjustarOrdemTabulacao(par_oPagina)
        LOCAL ARRAY loc_aOrdem[12]
        LOCAL loc_nI, loc_nSlot

        IF VARTYPE(par_oPagina) != "O"
            RETURN
        ENDIF

        loc_aOrdem[1]  = "cnt_4c_Salva"
        loc_aOrdem[2]  = "lbl_4c_Nome"
        loc_aOrdem[3]  = "lbl_4c_Grupo"
        loc_aOrdem[4]  = "txt_4c_Nome"
        loc_aOrdem[5]  = "txt_4c_Grupo"
        loc_aOrdem[6]  = "txt_4c_DGrupo"
        loc_aOrdem[7]  = "txt_4c_Conta"
        loc_aOrdem[8]  = "txt_4c_DConta"
        loc_aOrdem[9]  = "lbl_4c_Conta"
        loc_aOrdem[10] = "grd_4c_Fases"
        loc_aOrdem[11] = "cmd_4c_InserirFase"
        loc_aOrdem[12] = "cmd_4c_ExcluirFase"

        loc_nSlot = 0

        FOR loc_nI = 1 TO ALEN(loc_aOrdem)
            IF PEMSTATUS(par_oPagina, loc_aOrdem[loc_nI], 5)
                loc_nSlot = loc_nSlot + 1
                *-- Membro alcancado por NOME: STORE ... TO (expressao).
                *-- Controls(<nome>) e array por NUMERO e estouraria aqui
                *-- (regra #34); EVALUATE nao atribui (regra #15).
                STORE loc_nSlot TO ("par_oPagina." + loc_aOrdem[loc_nI] + ".TabIndex")
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna os controles visiveis recursivamente
    * AddObject cria com Visible=.F.; chamar SEMPRE com o container por parametro
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nP, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formatacao visual da grade da Lista
    * Legado: Pagina.Lista.Grade FontName="Tahoma", FontSize=8, RowHeight=16,
    * ForeColor=90,90,90, GridLineColor=238,238,238.
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        WITH par_oGrid
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowHeight     = 16
            .ForeColor     = RGB(90, 90, 90)
            .GridLineColor = RGB(238, 238, 238)
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * CarregarLista - Alimenta a grade da pagina Lista
    * Legado (Init): AddCursor('SigPrDmo', 'cIdChaves', 'crSigPrDmo', '',
    *   ThisForm.Pagina.Lista.Grade, [Select * From SigPrDmo ]) seguido de
    *   pfSqlTabela(1).pColuna('Nome','','','Nome do Demonstrativo',150,.t.)
    * Ou seja: UMA coluna na grade da Lista (regra #35 - a grade espelha o
    * pColuna do Init, nao os headers desenhados no SCX) e consulta SEM filtro.
    * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                *-- Ordem obrigatoria (regra #41 / Problemas 32 e 48):
                *-- ColumnCount -> RecordSource -> ControlSource ->
                *-- Header1.Caption -> FormatarGridLista -> Width.
                *-- RecordSource faz auto-bind e RESETA largura e caption.
                loc_oGrid.ColumnCount  = 1
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.nome"
                loc_oGrid.Column1.Header1.Caption = "Nome do Demonstrativo"

                *-- Column.ReadOnly DEPOIS do Grid.ReadOnly (regra #18): o do
                *-- grid propaga para as colunas e sobrescreveria este.
                loc_oGrid.Column1.ReadOnly = .T.

                THIS.FormatarGridLista(loc_oGrid)

                *-- Column.Width por ULTIMO (regra #35): mexer em RecordSource,
                *-- em ControlSource ou na FONTE do grid faz o VFP recalcular a
                *-- largura das colunas. Medido nesta tela: com o Width antes do
                *-- FormatarGridLista a coluna abria com 45 em vez de 150.
                loc_oGrid.Column1.Width = 150

                *-- Popular o cursor NAO repinta a grade (regra #21).
                *-- Legado: "Go Top In <cursor>" + "<grid>.Refresh".
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar a lista de demonstrativos:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista = 1) e Page2 (Dados = 2)
    * Legado: mAtivapagina1 do frmcadastro, chamado pelo Grupo_op.Click e pelo
    * Cancelar.Click para voltar a Lista.
    * O modo e repostos AQUI e AjustarBotoesPorModo e chamado no FIM: quem
    * desabilita botao tem de reabilitar no funil de volta (regra #40), senao o
    * usuario grava, volta para a Lista e encontra os 5 botoes cinza.
    * PUBLIC: chamado de fora pelos handlers e pelo harness de teste.
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                    TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                THIS.AjustarBotoesPorModo()
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita os botoes conforme o modo
    * Legado: o When de cada botao do Grupo_op/Grupo_Salva do frmcadastro -
    * os 5 do CRUD valem so na Lista; na pagina Dados valem Confirmar (quando
    * ha o que gravar ou excluir) e Cancelar (sempre, e a saida da ficha).
    * Os PEMSTATUS permanecem por seguranca: o metodo e chamado tambem pelo
    * InicializarForm e pelo harness de teste, e nao pode presumir que toda a
    * pagina Dados esteja montada.
    * PUBLIC: chamado de fora por AlternarPagina e pelo harness de teste.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lNaLista, loc_lEditando

        TRY
            loc_lNaLista  = (THIS.this_cModoAtual == "LISTA")
            loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "PROCURAR")

            loc_oPg1 = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                WITH loc_oPg1.cnt_4c_Botoes
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                        .cmd_4c_Incluir.Enabled = loc_lNaLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                        .cmd_4c_Visualizar.Enabled = loc_lNaLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                        .cmd_4c_Alterar.Enabled = loc_lNaLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                        .cmd_4c_Excluir.Enabled = loc_lNaLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                        .cmd_4c_Buscar.Enabled = loc_lNaLista
                    ENDIF
                ENDWITH
            ENDIF

            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
                WITH loc_oPg2.cnt_4c_Salva
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                        .cmd_4c_Confirmar.Enabled = loc_lEditando OR ;
                            (THIS.this_cModoAtual == "EXCLUIR")
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
                        .cmd_4c_Cancelar.Enabled = .T.
                    ENDIF
                ENDWITH
            ENDIF

            *-- Os campos da ficha seguem os "When" do legado, nao o estado
            *-- dos botoes - mas a troca de modo muda os dois, e este e o
            *-- funil por onde TODA troca passa (regra #40). Os botoes
            *-- Inserir/Excluir de LINHA ficam de fora de proposito: sao
            *-- icone-only e Enabled = .F. em runtime os deixaria como
            *-- retangulo vazio; o "When" deles vive no proprio handler.
            THIS.AtualizarEstadoCampos()

        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarGradeFases - Monta a grade de fases da pagina Dados (Grade)
    *
    * Legado: SIGOPDMP.Pagina.Dados.Grade, ColumnCount = 5, 492x260 em
    * 108/225 (+29 pela compensacao do PageFrame).
    *
    * ORDEM DAS COLUNAS: o dump declara ColumnOrder em todas as cinco e os
    * objetos foram RENOMEADOS pelo Form Designer, logo a posicao no array
    * NAO e a posicao visual. Resolvendo pelos nomes (que e como o
    * Grupo_op.Click do legado liga os ControlSource) a ordem visual e:
    *
    *   ColumnOrder | nome legado | ControlSource        | Header         | W
    *   ------------+-------------+----------------------+----------------+----
    *        1      | Column1     | crSigCdDpr.Ordems    | Ordem          |  40
    *        2      | Column2     | crSigCdDpr.grupos    | Fase           |  75
    *        3      | Column3     | crSigCdDpr.contas    | Funcionario    |  75
    *        4      | Column4     | crSigCdDpr.tpops     | Tipo Operacao  | 100
    *        5      | Column5     | crSigCdDpr.operas    | E/S            |  30
    *
    * As colunas sao criadas JA na ordem visual (Column1 = primeira coluna) e
    * ColumnOrder NAO e atribuido: reatribuir RecordSource faz o VFP refazer o
    * auto-bind pela ORDEM dos campos do cursor, ignorando ColumnOrder, e os
    * dados saem desalinhados dos cabecalhos.
    *
    * ZOrderSet = 15 do dump NAO e transcrito: e propriedade so do Form
    * Designer e atribui-la em runtime derruba o Init (regra #33).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGradeFases(par_oPagina)
        LOCAL loc_oGrid

        par_oPagina.AddObject("grd_4c_Fases", "Grid")
        loc_oGrid = par_oPagina.grd_4c_Fases

        *-- ColumnCount FORA de bloco WITH e antes de qualquer acesso a
        *-- Column1..N: dentro do WITH as colunas podem nao existir ainda e a
        *-- linha seguinte estoura "Unknown member COLUMN1" (Problema 36).
        loc_oGrid.ColumnCount = 5

        WITH loc_oGrid
            .Top               = 254
            .Left              = 108
            .Width             = 492
            .Height            = 260
            .FontName          = "Tahoma"
            .FontSize          = 8
            .RowHeight         = 20
            .ScrollBars        = 2
            .Panel             = 1
            .DeleteMark        = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .GridLineColor     = RGB(238, 238, 238)
            .ReadOnly          = .F.
            .Visible           = .T.
        ENDWITH

        *-- Propriedades que NAO dependem do cursor. O ControlSource, os
        *-- Header1.Caption e a Width ficam no VincularGradeFases: ligar
        *-- Column.ControlSource a um cursor que ainda nao existe estoura
        *-- "Alias not found" DENTRO do Init e a tela nao abre (regra #41).
        *-- Column.ReadOnly vem DEPOIS de Grid.ReadOnly, que propaga para as
        *-- colunas e sobrescreveria este (regra #18).
        loc_oGrid.Column1.Movable   = .F.
        loc_oGrid.Column1.Resizable = .F.
        loc_oGrid.Column1.ReadOnly  = .F.
        loc_oGrid.Column1.FontName  = "Tahoma"
        loc_oGrid.Column1.FontSize  = 8
        loc_oGrid.Column1.InputMask = "999"

        loc_oGrid.Column2.Movable   = .F.
        loc_oGrid.Column2.Resizable = .F.
        loc_oGrid.Column2.ReadOnly  = .F.
        loc_oGrid.Column2.FontName  = "Tahoma"
        loc_oGrid.Column2.FontSize  = 8
        loc_oGrid.Column2.Format    = "K!"

        loc_oGrid.Column3.Movable   = .F.
        loc_oGrid.Column3.Resizable = .F.
        loc_oGrid.Column3.ReadOnly  = .F.
        loc_oGrid.Column3.FontName  = "Tahoma"
        loc_oGrid.Column3.FontSize  = 8
        loc_oGrid.Column3.Format    = "K!"

        loc_oGrid.Column4.Movable   = .F.
        loc_oGrid.Column4.Resizable = .F.
        loc_oGrid.Column4.ReadOnly  = .F.
        loc_oGrid.Column4.FontName  = "Tahoma"
        loc_oGrid.Column4.FontSize  = 8
        loc_oGrid.Column4.Format    = "K!"

        loc_oGrid.Column5.Movable   = .F.
        loc_oGrid.Column5.Resizable = .F.
        loc_oGrid.Column5.ReadOnly  = .F.
        loc_oGrid.Column5.FontName  = "Tahoma"
        loc_oGrid.Column5.FontSize  = 8
        loc_oGrid.Column5.Format    = "K!"

        *-- Cabecalhos: Alignment = 2 (centralizado) em todos, como o dump.
        *-- Reescritos tambem no VincularGradeFases, porque RecordSource os
        *-- RESETA para o nome do campo (Problema 32).
        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
        loc_oGrid.Column1.Header1.FontSize  = 8
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column2.Header1.FontName  = "Tahoma"
        loc_oGrid.Column2.Header1.FontSize  = 8
        loc_oGrid.Column2.Header1.Alignment = 2
        loc_oGrid.Column3.Header1.FontName  = "Tahoma"
        loc_oGrid.Column3.Header1.FontSize  = 8
        loc_oGrid.Column3.Header1.Alignment = 2
        loc_oGrid.Column4.Header1.FontName  = "Tahoma"
        loc_oGrid.Column4.Header1.FontSize  = 8
        loc_oGrid.Column4.Header1.Alignment = 2
        loc_oGrid.Column5.Header1.FontName  = "Tahoma"
        loc_oGrid.Column5.Header1.FontSize  = 8
        loc_oGrid.Column5.Header1.Alignment = 2

        THIS.InstalarCelulasGradeFases(loc_oGrid)
    ENDPROC

    *===========================================================================
    * InstalarCelulasGradeFases - Poe as celulas editaveis nas 5 colunas
    *
    * Column.AddObject NAO faz o controle aparecer: sem CurrentControl a
    * coluna segue desenhando o Text1 dela, e sem Sparse = .F. o controle so
    * aparece na linha ativa (regra #18).
    *
    * As celulas sao TextBoxCelulaDmp_4c (classes\TextBoxGridLookup.prg) com
    * When/Valid/KeyPress/DblClick EMBUTIDOS: BINDEVENT em evento de
    * Column.Text1 nao dispara de forma confiavel e AfterRowColChange entrega
    * a coluna de DESTINO, nao a de origem - o lookup nunca abriria (regra #46).
    *
    * Idempotente (PEMSTATUS): o metodo e chamado tambem pelo
    * VincularGradeFases, que pode ter mexido em ColumnCount/RecordSource.
    *===========================================================================
    PROTECTED PROCEDURE InstalarCelulasGradeFases(par_oGrid)
        LOCAL ARRAY loc_aCel[5, 2]
        LOCAL loc_nI, loc_oCol, loc_oCel, loc_lNova

        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF

        *-- this_cCelula + MaxLength pela largura da COLUNA no schema, NUNCA
        *-- pelo Width em pixels (regra #19): SigCdDpr.ordems numeric(4,0),
        *-- grupos/contas char(10), tpops char(15), operas char(1).
        loc_aCel[1, 1] = "ORDEM"
        loc_aCel[1, 2] = 3
        loc_aCel[2, 1] = "FASE"
        loc_aCel[2, 2] = 10
        loc_aCel[3, 1] = "FUNCIONARIO"
        loc_aCel[3, 2] = 10
        loc_aCel[4, 1] = "TPOP"
        loc_aCel[4, 2] = 15
        loc_aCel[5, 1] = "ES"
        loc_aCel[5, 2] = 1

        FOR loc_nI = 1 TO 5
            *-- Columns e array indexado por NUMERO - este e o uso CORRETO
            *-- (regra #34: o que estoura e passar o NOME da coluna).
            loc_oCol = par_oGrid.Columns(loc_nI)

            loc_lNova = !PEMSTATUS(loc_oCol, "txt_4c_Cel", 5)
            IF loc_lNova
                loc_oCol.AddObject("txt_4c_Cel", "TextBoxCelulaDmp_4c")
            ENDIF

            loc_oCel = loc_oCol.txt_4c_Cel

            loc_oCel.this_cCelula = loc_aCel[loc_nI, 1]
            loc_oCel.MaxLength    = loc_aCel[loc_nI, 2]
            loc_oCel.Visible      = .T.

            IF loc_nI = 1
                *-- Coluna Ordem: numerica, alinhada a direita e com o
                *-- InputMask "999" do dump. O .Value inicial SO na criacao -
                *-- depois do ControlSource ligado, atribuir .Value GRAVARIA
                *-- no cursor, zerando a Ordem da linha corrente.
                loc_oCel.InputMask = "999"
                loc_oCel.Alignment = 1
                IF loc_lNova
                    loc_oCel.Value = 0
                ENDIF
            ELSE
                *-- Format = "K!" das quatro colunas character (dump).
                loc_oCel.Format = "K!"
            ENDIF

            *-- Column3.Text1 e o UNICO dos cinco que o dump declara com
            *-- BackStyle = 0 (transparente). Vai na INSTANCIA, nao no
            *-- default da classe, exatamente como o legado.
            IF loc_nI = 3
                loc_oCel.BackStyle = 0
            ENDIF

            *-- SEM estas duas linhas a coluna segue desenhando o Text1 dela e
            *-- a celula nunca aparece / so aparece na linha ativa (regra #18).
            loc_oCol.CurrentControl = "txt_4c_Cel"
            loc_oCol.Sparse         = .F.
        ENDFOR
    ENDPROC

    *===========================================================================
    * CriarCursorFases - Cria o cursor de detalhe (SigCdDpr) da pagina Dados
    *
    * Equivale ao .AddCursor('SigCdDpr','cIdChaves','crSigCdDpr','', ,
    *   [Select * From SigCdDpr Where nome=?sNome Order By Ordems])
    * do Init legado com sNome = Space(20): nenhuma linha casa, o cursor nasce
    * VAZIO e so e recarregado pelo Grupo_op.Click (Fases 7-8).
    *
    * A estrutura e a EXATA de SigCdDpr (docs\schema.sql, lido com
    * Get-Content -Raw por ser UTF-16 - regra #14), inclusive dopes, que nao
    * aparece em lugar nenhum do codigo legado mas e NOT NULL na tabela: o
    * legado a recebia de graca do "Select *" + "Append Blank", e omiti-la
    * aqui faria o INSERT da Fase 7 ser recusado inteiro (regra #22).
    *
    * SET NULL ON durante o CREATE CURSOR: CarregarFasesDoBanco alimenta este
    * cursor com APPEND FROM a partir do resultado de um SQLEXEC direto no
    * SQL Server (cursor_4c_FasesTmp); se qualquer linha trouxer NULL numa
    * coluna, um cursor criado com SET NULL OFF recusa o APPEND FROM inteiro
    * com "Field XXX does not accept null values". InserirLinhaFase continua
    * seguro: o APPEND BLANK ali e seguido de REPLACE nas OITO colunas, sem
    * nenhuma sobrar com .NULL.
    *===========================================================================
    PROTECTED PROCEDURE CriarCursorFases()
        IF USED("cursor_4c_Fases")
            *-- USE IN fecha o alias mesmo com buffer sujo; TABLEREVERT sem
            *-- antes conferir o Buffering dispara o erro 1586 (regra #52).
            IF CURSORGETPROP("Buffering", "cursor_4c_Fases") > 1
                TABLEREVERT(.T., "cursor_4c_Fases")
            ENDIF
            USE IN cursor_4c_Fases
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Fases ( ;
            contas    C(10), ;
            grupos    C(10), ;
            nome      C(20), ;
            operas    C(1),  ;
            ordems    N(4),  ;
            tpops     C(15), ;
            cidchaves C(20), ;
            dopes     C(20))
        SET NULL OFF
    ENDPROC

    *===========================================================================
    * VincularGradeFases - Liga a grade de fases ao cursor_4c_Fases
    *
    * Ordem OBRIGATORIA (regra #41 / Problemas 32, 36 e 48):
    *   ColumnCount -> RecordSource -> ControlSource -> Header1.Caption ->
    *   celulas (CurrentControl) -> Width (por ULTIMO).
    * RecordSource faz auto-bind pela ordem dos campos do cursor e RESETA
    * ControlSource, Header1.Caption e a largura das colunas para o default 90.
    *
    * ColumnCount so e tocado se divergir de 5: reatribui-lo DESTROI os
    * objetos postos por Column.AddObject (as celulas).
    *
    * PUBLIC: chamado de fora pelos handlers de recarga da grade (Fases 7-8) e
    * pelo harness de teste.
    *===========================================================================
    PROCEDURE VincularGradeFases()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases

            IF !USED("cursor_4c_Fases")
                MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp")
            ELSE
                IF loc_oGrid.ColumnCount != 5
                    loc_oGrid.ColumnCount = 5
                ENDIF

                loc_oGrid.RecordSource = "cursor_4c_Fases"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Fases.ordems"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Fases.grupos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Fases.contas"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Fases.tpops"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Fases.operas"

                loc_oGrid.Column1.Header1.Caption = "Ordem"
                loc_oGrid.Column2.Header1.Caption = "Fase"
                loc_oGrid.Column3.Header1.Caption = "Funcion" + CHR(225) + "rio"
                loc_oGrid.Column4.Header1.Caption = "Tipo Opera" + CHR(231) + ;
                    CHR(227) + "o"
                loc_oGrid.Column5.Header1.Caption = "E/S"

                *-- Grid.ReadOnly ANTES de Column.ReadOnly: o do grid propaga
                *-- para as colunas (regra #18). O legado faz exatamente isto
                *-- no Grupo_op.Click (columnN.ReadOnly = .F.); quem bloqueia a
                *-- edicao fora dos modos INSERIR/ALTERAR e o "When" da celula.
                loc_oGrid.ReadOnly         = .F.
                loc_oGrid.Column1.ReadOnly = .F.
                loc_oGrid.Column2.ReadOnly = .F.
                loc_oGrid.Column3.ReadOnly = .F.
                loc_oGrid.Column4.ReadOnly = .F.
                loc_oGrid.Column5.ReadOnly = .F.

                *-- Reafirma CurrentControl/Sparse: RecordSource pode ter
                *-- desfeito o vinculo da celula com a coluna.
                THIS.InstalarCelulasGradeFases(loc_oGrid)

                *-- Larguras por ULTIMO, na ordem visual do ColumnOrder do dump
                loc_oGrid.Column1.Width = 40
                loc_oGrid.Column2.Width = 75
                loc_oGrid.Column3.Width = 75
                loc_oGrid.Column4.Width = 100
                loc_oGrid.Column5.Width = 30

                THIS.RepintarGradeFases()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao vincular a grade de fases:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.VincularGradeFases")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * RepintarGradeFases - Reposiciona e repinta a grade de fases
    *
    * Popular (ou alterar) o cursor NAO repinta a grade sozinho: o legado
    * sempre fecha com "Go Top in ('crSigCdDpr')" + "Grade.Refresh"
    * (regra #21). Metodo UNICO, chamado em TODO caminho que mexe no cursor -
    * vinculo, Inserir e Excluir de linha - senao a grade fica
    * visualmente vazia com o cursor cheio.
    *
    * PUBLIC: chamado de fora pelos handlers e pelas Fases 7-8.
    *===========================================================================
    PROCEDURE RepintarGradeFases()
        IF USED("cursor_4c_Fases")
            GO TOP IN cursor_4c_Fases
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Fases", 5)
            THIS.pgf_4c_Paginas.Page2.grd_4c_Fases.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * ContarLinhasFases - COUNT de linhas vivas do cursor de fases
    *
    * Legado: "Select crSigCdDpr / Count to lnLinhas" - COUNT respeita
    * SET DELETED ON (as linhas excluidas pelo botao Excluir NAO entram),
    * diferente de RECCOUNT(). O preco e que COUNT percorre o cursor e MOVE o
    * ponteiro: o RECNO e o alias correntes sao salvos e repostos, senao a
    * linha selecionada na grade salta sozinha.
    *===========================================================================
    PROTECTED PROCEDURE ContarLinhasFases()
        LOCAL loc_nLinhas, loc_nAliasAnt, loc_nRegAnt

        loc_nLinhas = 0

        IF USED("cursor_4c_Fases")
            loc_nAliasAnt = SELECT(0)
            SELECT cursor_4c_Fases
            loc_nRegAnt = RECNO("cursor_4c_Fases")

            COUNT TO loc_nLinhas

            IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
                GO loc_nRegAnt IN cursor_4c_Fases
            ENDIF
            SELECT (loc_nAliasAnt)
        ENDIF

        RETURN loc_nLinhas
    ENDPROC

    *===========================================================================
    * NomeEditavel - Reproduz o "When" de GetNome do legado
    *
    *   Case pcEscolha = 'PROCURAR'  -> .T.
    *   Case pcEscolha <> 'INSERIR'  -> .F.
    *   Case pcEscolha = 'INSERIR'   -> .T. so se a grade de fases estiver
    *        vazia, ou tiver UMA unica linha com Grupos E Contas vazios
    *        (ou seja, a linha em branco que o proprio form acabou de inserir)
    *   Other                        -> .F.
    *
    * Ou seja: depois que o usuario comeca a preencher as fases, o Nome deixa
    * de ser editavel - ele e a chave que amarra as linhas de SigCdDpr.
    *===========================================================================
    PROTECTED PROCEDURE NomeEditavel()
        LOCAL loc_lEditavel, loc_nLinhas, loc_nAliasAnt, loc_nRegAnt
        LOCAL loc_lPrimeiraVazia

        loc_lEditavel = .F.

        DO CASE
            CASE THIS.this_cModoAtual == "PROCURAR"
                loc_lEditavel = .T.

            CASE THIS.this_cModoAtual != "INCLUIR"
                loc_lEditavel = .F.

            OTHERWISE
                loc_nLinhas       = THIS.ContarLinhasFases()
                loc_lPrimeiraVazia = .F.

                IF loc_nLinhas = 1 AND USED("cursor_4c_Fases")
                    loc_nAliasAnt = SELECT(0)
                    SELECT cursor_4c_Fases
                    loc_nRegAnt = RECNO("cursor_4c_Fases")

                    GO TOP IN cursor_4c_Fases
                    loc_lPrimeiraVazia = EMPTY(cursor_4c_Fases.grupos) AND ;
                        EMPTY(cursor_4c_Fases.contas)

                    IF loc_nRegAnt > 0 AND loc_nRegAnt <= RECCOUNT("cursor_4c_Fases")
                        GO loc_nRegAnt IN cursor_4c_Fases
                    ENDIF
                    SELECT (loc_nAliasAnt)
                ENDIF

                loc_lEditavel = (loc_nLinhas = 0) OR loc_lPrimeiraVazia
        ENDCASE

        RETURN loc_lEditavel
    ENDPROC

    *===========================================================================
    * AtualizarEstadoCampos - Reavalia os "When" dos campos da pagina Dados
    *
    * FONTE UNICA das regras de habilitacao do legado:
    *   GetNome.When    -> ver NomeEditavel
    *   Get_Grupo.When  -> Inlist(pcEscolha,'INSERIR','ALTERAR')
    *   Get_DGrupo.When -> IsEmpty(Get_Grupo.Value) And Inlist(...)
    *   Get_Conta.When  -> Inlist(pcEscolha,'INSERIR','ALTERAR')
    *   Get_DConta.When -> IsEmpty(Get_Conta.Value) And Inlist(...)
    *
    * Os campos de DESCRICAO nao sao rotulo: sao a SEGUNDA porta de entrada
    * (buscar o grupo/a conta pelo nome) e por isso NAO podem nascer com
    * ReadOnly fixo - quem decide e este metodo, chamado no fim do
    * ConfigurarPaginaDados, nos lookups e por BINDEVENT InteractiveChange dos
    * campos de CODIGO, porque esvaziar o codigo tem de REABRIR a descricao.
    *
    * ReadOnly (e nao Enabled) de proposito: o "When" do legado so impede o
    * foco, nao pinta o campo de cinza - Enabled = .F. aplicaria o
    * DisabledBackColor 192,192,192 e mudaria a tela (PILAR 1).
    *
    * Os botoes Inserir/Excluir de LINHA ficam de fora: sao icone-only
    * (Caption = "") e Enabled = .F. em runtime faz o VFP desenhar um
    * retangulo VAZIO, sem icone. O "When" deles vive no proprio handler.
    *
    * PUBLIC: e alvo de BINDEVENT (regra #3) e do harness de teste.
    *===========================================================================
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg2, loc_lEditando, loc_cGrupo, loc_cConta

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
                loc_oPg2.txt_4c_Nome.ReadOnly = !THIS.NomeEditavel()
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oPg2.txt_4c_Grupo.ReadOnly = !loc_lEditando
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.ReadOnly = !loc_lEditando
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5) AND ;
               PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
                loc_oPg2.txt_4c_DGrupo.ReadOnly = ;
                    !(EMPTY(loc_cGrupo) AND loc_lEditando)
            ENDIF

            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5) AND ;
               PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
                loc_oPg2.txt_4c_DConta.ReadOnly = ;
                    !(EMPTY(loc_cConta) AND loc_lEditando)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar o estado dos campos:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.AtualizarEstadoCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarNomeLostFocus - GetNome.Valid do legado
    *
    *   If IsEmpty(This.Value) And LastKey() # 27
    *       Messagebox('O Nome deve ser informado...',32,'')
    *       Return 0
    *   Endif
    *   Select crSigCdDpr / Go Top / If Eof() -> InsiraRegGrade() / Go Top
    *
    * DIVERGENCIA DOCUMENTADA: "Return 0" num Valid retem o foco no campo;
    * LostFocus nao tem como fazer isso e devolver o foco daqui provocaria
    * reentrancia. O aviso continua aparecendo no mesmo momento, e o bloqueio
    * efetivo da gravacao fica no Confirmar (Fase 7), que e onde o legado
    * tambem recusa gravar sem nome.
    *
    * A guarda this_lEmLookup tambem vale aqui: o MsgAviso e MODAL, tira o
    * foco e redisparia este proprio LostFocus.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3). LostFocus nao passa
    * parametro nenhum.
    *===========================================================================
    PROCEDURE ValidarNomeLostFocus()
        LOCAL loc_oPg2, loc_cNome, loc_lEmLookupAnt

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.

        TRY
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)

            IF EMPTY(loc_cNome)
                IF LASTKEY() != 27 AND ;
                   INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    MsgAviso("O Nome deve ser informado...", "FormSigOpDmp")
                ENDIF
            ELSE
                *-- Com a grade de fases vazia, o legado insere a primeira
                *-- linha em branco assim que o Nome e confirmado - e ela que
                *-- carrega o nome como chave de SigCdDpr.
                IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
                   THIS.ContarLinhasFases() = 0
                    THIS.InserirLinhaFase()
                ENDIF
            ENDIF

            THIS.AtualizarEstadoCampos()

        CATCH TO loException
            MostrarErro("Erro ao validar o Nome:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.ValidarNomeLostFocus")
        ENDTRY

        *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *===========================================================================
    * InserirLinhaFase - PROCEDURE insirareggrade do legado
    *
    *   Select crSigCdDpr / Append Blank
    *   Replace contas With Space(10), grupos With Space(10),
    *           nome With getNome.Value, operas With Space(1),
    *           ordems With 0, tpops With Space(15),
    *           cIdChaves With fUniqueIds()
    *
    * cidchaves vem de fUniqueIds() e NUNCA de string vazia: com cidchaves em
    * branco a segunda linha colidiria no indice unico de SigCdDpr (regra #22).
    * dopes nao e citada em lugar nenhum do legado, mas e NOT NULL na tabela -
    * o legado a ganhava em branco do "Select *" + "Append Blank" e aqui ela e
    * preenchida explicitamente pelo mesmo motivo.
    *
    * PUBLIC: chamado pelo handler do botao, pelo ValidarNomeLostFocus e pelas
    * Fases 7-8.
    *===========================================================================
    PROCEDURE InserirLinhaFase()
        LOCAL loc_lResultado, loc_nAliasAnt, loc_cNome
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Fases")
                MsgAviso("Cursor de fases indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp")
            ELSE
                loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)

                loc_nAliasAnt = SELECT(0)
                SELECT cursor_4c_Fases
                APPEND BLANK
                REPLACE contas    WITH SPACE(10), ;
                        grupos    WITH SPACE(10), ;
                        nome      WITH loc_cNome, ;
                        operas    WITH SPACE(1),  ;
                        ordems    WITH 0,         ;
                        tpops     WITH SPACE(15), ;
                        cidchaves WITH fUniqueIds(), ;
                        dopes     WITH SPACE(20) ;
                        IN cursor_4c_Fases
                SELECT (loc_nAliasAnt)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir a linha de fase:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.InserirLinhaFase")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnInserirFaseClick - Pagina.Dados.Inserir.Click do legado
    *
    *   ThisForm.InsiraRegGrade()
    *   ThisForm.Pagina.Dados.Grade.Column1.Text1.SetFocus
    *   ThisForm.Pagina.Dados.Grade.Refresh
    *
    * O "When" do botao (Inlist(pcEscolha,'INSERIR','ALTERAR')) vira guarda no
    * inicio do handler: o botao e icone-only e Enabled = .F. em runtime
    * fa-lo-ia virar um retangulo vazio, sem icone.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnInserirFaseClick()
        LOCAL loc_oGrid

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            IF THIS.InserirLinhaFase()
                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases

                *-- O legado devolve o foco a' celula Ordem da linha corrente.
                *-- A linha nova e' a ULTIMA, por isso o GO BOTTOM antes -
                *-- sem ele o RepintarGradeFases levaria o ponteiro para o
                *-- topo e o usuario digitaria na linha errada.
                IF USED("cursor_4c_Fases")
                    GO BOTTOM IN cursor_4c_Fases
                ENDIF
                loc_oGrid.Refresh()
                THIS.AtualizarEstadoCampos()
                loc_oGrid.SetFocus()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir fase:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.BtnInserirFaseClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirFaseClick - Pagina.Dados.Excluir.Click do legado
    *
    *   If Inlist( pcEscolha, 'INSERIR', 'ALTERAR' )
    *       Select crSigCdDpr / Delete / Skip
    *       If Eof() -> Go Bottom
    *       If Eof() -> InsiraRegGrade()
    *       Grade.Column1.Text1.SetFocus / Grade.Refresh
    *   Endif
    *
    * O segundo "If Eof()" nao e repetido por descuido: com o cursor vazio o
    * GO BOTTOM nao sai do EOF, e e dai que o legado conclui que a grade ficou
    * sem nenhuma linha e repoe a linha em branco.
    *
    * NAO confundir com BtnExcluirClick (CRUD do registro mestre, pagina
    * Lista): este exclui a LINHA da grade de fases.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnExcluirFaseClick()
        LOCAL loc_oGrid, loc_nAliasAnt

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        TRY
            IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
                MsgAviso("Nenhuma fase selecionada.", "FormSigOpDmp")
            ELSE
                loc_nAliasAnt = SELECT(0)
                SELECT cursor_4c_Fases
                DELETE
                SKIP

                IF EOF("cursor_4c_Fases")
                    GO BOTTOM IN cursor_4c_Fases
                ENDIF
                SELECT (loc_nAliasAnt)

                *-- Grade sem nenhuma linha viva: repor a linha em branco.
                IF THIS.ContarLinhasFases() = 0
                    THIS.InserirLinhaFase()
                ENDIF

                loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Fases
                loc_oGrid.Refresh()
                THIS.AtualizarEstadoCampos()
                loc_oGrid.SetFocus()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir fase:" + CHR(13) + ;
                loException.Message, "FormSigOpDmp.BtnExcluirFaseClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConexaoAtiva - Ha conexao SQL utilizavel?
    *
    * Os sete lookups consultam o banco. Com gnConnHandle invalido o SQLEXEC
    * do FormBuscaAuxiliar dispara EXCECAO (nao devolve -1), e sem esta guarda
    * o ValidarUIFidelity e o harness headless - que rodam com
    * gnConnHandle = -1 - encheriam a tela de dialogos de erro.
    *===========================================================================
    PROTECTED PROCEDURE ConexaoAtiva()
        RETURN (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
    ENDPROC

    *===========================================================================
    * UsuarioCorrente - Usuario logado para os checks de acesso
    *===========================================================================
    PROTECTED PROCEDURE UsuarioCorrente()
        LOCAL loc_cUsuario
        loc_cUsuario = ""

        IF TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF

        RETURN loc_cUsuario
    ENDPROC

    *===========================================================================
    * FecharCursorBusca - Fecha um cursor de lookup com o guard de Buffering
    * TABLEREVERT sem conferir o Buffering dispara o erro 1586; USE IN fecha o
    * alias mesmo com buffer sujo (regra #52).
    *===========================================================================
    PROTECTED PROCEDURE FecharCursorBusca(par_cCursor)
        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF
    ENDPROC

    *===========================================================================
    * GravarCelulaFase - Escreve o valor resolvido na linha corrente da grade
    *
    * Dentro de um Valid de celula o valor digitado vive em <TextBox>.Value e
    * o CURSOR so o recebe depois (regra #46). Quando o lookup resolve outro
    * valor, ele tem de ir para os DOIS lugares - para a .Value (senao o texto
    * digitado sobrescreve o cursor na saida da celula) e para o cursor (senao
    * a linha mantem o valor antigo).
    *
    * REPLACE aceita name expression entre parenteses, logo o nome da coluna
    * pode vir por parametro.
    *===========================================================================
    PROTECTED PROCEDURE GravarCelulaFase(par_cCampo, par_uValor)
        LOCAL loc_nAliasAnt

        IF !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
            RETURN
        ENDIF

        loc_nAliasAnt = SELECT(0)
        SELECT cursor_4c_Fases
        REPLACE (par_cCampo) WITH par_uValor IN cursor_4c_Fases
        SELECT (loc_nAliasAnt)
    ENDPROC

    *===========================================================================
    * GrupoDaLinhaFase - Grupo da linha corrente da grade de fases
    * Legado: crSigCdDpr.Grupos, usado como filtro do lookup de Tipo de
    * Operacao e como 2o argumento do fAcessoContas.
    *===========================================================================
    PROTECTED PROCEDURE GrupoDaLinhaFase()
        LOCAL loc_cGrupo
        loc_cGrupo = ""

        IF USED("cursor_4c_Fases") AND !EOF("cursor_4c_Fases")
            loc_cGrupo = ALLTRIM(cursor_4c_Fases.grupos)
        ENDIF

        RETURN loc_cGrupo
    ENDPROC

    *===========================================================================
    * LOOKUP DO CAMPO GRUPO SD INICIAL (Get_Grupo do legado)
    *
    * Legado (Valid):
    *   If !IsEmpty(This.Value)
    *       If !Seek( This.Value, 'crSigCdGcr', 'BalCodigo')
    *           xBrow = CreateObject('fwBuscaSel','crSigCdGcr','BalCodigo',...)
    *           xBrow.AddColuna('Codigos',...,'Codigo') / ('Descrs',...,'Descricao')
    *           xBrow.Show
    *       EndIf
    *       Get_Grupo.Value  = Iif(LastKey()==27,'', crSigCdGcr.Codigos )
    *       Get_DGrupo.Value = Iif(LastKey()==27,'', crSigCdGcr.Descrs  )
    *   Else
    *       Get_DGrupo.Value = Space(20)
    *   EndIf
    *
    * crSigCdGcr e criado no Init legado com
    *   Select codigos,Descrs From SigCdGcr Where gerbals=1
    * logo o universo do lookup e' SO os grupos com gerbals = 1 - o filtro faz
    * parte da regra e vai para o 9o argumento do FormBuscaAuxiliar, que o
    * aplica na busca exata, na parcial e no fallback show-all.
    *===========================================================================
    PROCEDURE ValidarGrupoLostFocus()
        LOCAL loc_oPg2, loc_cGrupo

        *-- Guarda de reentrancia: o picker e MODAL, tira o foco do campo e
        *-- redispara este proprio LostFocus (regra #37). A flag e ligada
        *-- dentro de AbrirLookupGrupo, funil das TRES portas (LostFocus,
        *-- F4/F5 e DblClick).
        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        *-- LostFocus dispara mesmo sem o valor mudar (so tabular pelo campo
        *-- ja dispararia o lookup de novo); pular quando igual ao ultimo
        *-- valor ja validado.
        IF loc_cGrupo == THIS.this_cUltimoValidarGrupoLostFocusValidado
            RETURN
        ENDIF

        TRY
            IF EMPTY(loc_cGrupo)
                *-- ELSE do legado: codigo vazio limpa a descricao
                loc_oPg2.txt_4c_DGrupo.Value = ""
            ELSE
                THIS.AbrirLookupGrupo()
            ENDIF

            THIS.AtualizarEstadoCampos()

            *-- Lido de novo: AbrirLookupGrupo pode ter resolvido outro
            *-- codigo e mudado a .Value depois do loc_cGrupo capturado acima.
            THIS.this_cUltimoValidarGrupoLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.ValidarGrupoLostFocus: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- Porta EXTRA do mesmo funil. O par_nKeyCode E testado: handler que
        *-- abre picker sem olhar a tecla faz o dialogo subir a CADA
        *-- caractere e o usuario nao consegue digitar o codigo (regra #47).
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupGrupo()
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TxtGrupoDblClick()
        THIS.AbrirLookupGrupo()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_cGrupo, loc_oPg2, loc_lMostrou

        IF !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)

        THIS.this_lEmLookup = .T.
        TRY
            *-- 1o argumento = HANDLE da conexao (regra #36): passar a tabela
            *-- ali desloca todos os outros e o picker abre VAZIO.
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cGrupo, ;
                "Grupos de Estoque", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                *-- Show SO se o Init nao resolveu sozinho (regra #37): com o
                *-- codigo JA valido o dialogo abriria por cima da ficha
                *-- preenchida e o usuario teria de dispensa-lo.
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    *-- ESC/Cancelar com o picker ABERTO: o legado limpa os
                    *-- dois (Iif(LastKey()==27,'',...)). Sem o picker na tela
                    *-- nada e limpado - apagar o que o usuario digitou o
                    *-- deixaria sem como preencher o campo (regra #50).
                    IF loc_lMostrou
                        loc_oPg2.txt_4c_Grupo.Value  = ""
                        loc_oPg2.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupGrupo: " + ;
                loException.Message, "Erro")
        ENDTRY
        *-- Liberar DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara
        THIS.this_lEmLookup = .F.

        THIS.FecharCursorBusca("cursor_4c_BuscaGcr")
    ENDPROC

    *===========================================================================
    * LOOKUP DA DESCRICAO DO GRUPO (Get_DGrupo do legado)
    *
    * Mesma tabela do Get_Grupo, buscando pela DESCRICAO (indice BalDescrs) -
    * e a segunda porta de entrada do campo Grupo, nao um rotulo.
    * As colunas do browse vem na ordem do legado: Descricao primeiro.
    *
    * O ELSE do legado aqui limpa o CODIGO (Get_Grupo.Value = Space(20)),
    * assimetrico em relacao ao Get_DConta (que limpa a si mesmo). Na pratica
    * e inofensivo, porque o "When" so libera a descricao com o codigo vazio -
    * mas fica transcrito como esta (PILAR 1).
    *===========================================================================
    PROCEDURE ValidarDGrupoLostFocus()
        LOCAL loc_oPg2, loc_cDesc

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)

        *-- LostFocus dispara mesmo sem o valor mudar; pular quando igual ao
        *-- ultimo valor ja validado.
        IF loc_cDesc == THIS.this_cUltimoValidarDGrupoLostFocusValidado
            RETURN
        ENDIF

        TRY
            IF EMPTY(loc_cDesc)
                loc_oPg2.txt_4c_Grupo.Value = ""
            ELSE
                THIS.AbrirLookupDGrupo()
            ENDIF

            THIS.AtualizarEstadoCampos()

            THIS.this_cUltimoValidarDGrupoLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.ValidarDGrupoLostFocus: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupDGrupo()
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TxtDGrupoDblClick()
        THIS.AbrirLookupDGrupo()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDGrupo()
        LOCAL loc_oBusca, loc_cDesc, loc_oPg2, loc_lMostrou

        IF !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcrD", "descrs", loc_cDesc, ;
                "Grupos de Estoque", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("descrs",  "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcrD")
                    SELECT cursor_4c_BuscaGcrD
                    loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcrD.codigos)
                    loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcrD.descrs)
                ELSE
                    IF loc_lMostrou
                        loc_oPg2.txt_4c_Grupo.Value  = ""
                        loc_oPg2.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupDGrupo: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        THIS.FecharCursorBusca("cursor_4c_BuscaGcrD")
    ENDPROC

    *===========================================================================
    * LOOKUP DO CAMPO CONTA SD INICIAL (Get_Conta do legado)
    *
    * Legado (Valid): Seek em crSigCdCli pelo indice BalCodigo e, falhando,
    * fwBuscaSel com as colunas IClis / RClis; depois preenche Get_Conta e
    * Get_DConta, limpando os dois no ESC.
    *
    * crSigCdCli e criado no Init legado com
    *   Select Grupos, IClis, RClis From SigCdCli Where GerBals = 1
    * logo o universo e' SO as contas com gerbals = 1.
    *===========================================================================
    PROCEDURE ValidarContaLostFocus()
        LOCAL loc_oPg2, loc_cConta

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        *-- LostFocus dispara mesmo sem o valor mudar; pular quando igual ao
        *-- ultimo valor ja validado.
        IF loc_cConta == THIS.this_cUltimoValidarContaLostFocusValidado
            RETURN
        ENDIF

        TRY
            IF EMPTY(loc_cConta)
                loc_oPg2.txt_4c_DConta.Value = ""
            ELSE
                THIS.AbrirLookupConta()
            ENDIF

            THIS.AtualizarEstadoCampos()

            THIS.this_cUltimoValidarContaLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.ValidarContaLostFocus: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupConta()
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TxtContaDblClick()
        THIS.AbrirLookupConta()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_cConta, loc_oPg2, loc_lMostrou

        IF !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cConta, ;
                "Contas", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    SELECT cursor_4c_BuscaCli
                    loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                ELSE
                    IF loc_lMostrou
                        loc_oPg2.txt_4c_Conta.Value  = ""
                        loc_oPg2.txt_4c_DConta.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupConta: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        THIS.FecharCursorBusca("cursor_4c_BuscaCli")
    ENDPROC

    *===========================================================================
    * LOOKUP DA DESCRICAO DA CONTA (Get_DConta do legado)
    *
    * Busca em SigCdCli pelo NOME (indice BalNome do legado), colunas RClis /
    * IClis nessa ordem. O ELSE do legado limpa a si mesmo (Get_DConta), nao o
    * codigo - assimetrico em relacao ao Get_DGrupo, e transcrito como esta.
    *===========================================================================
    PROCEDURE ValidarDContaLostFocus()
        LOCAL loc_oPg2, loc_cDesc

        IF THIS.this_lEmLookup
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)

        *-- LostFocus dispara mesmo sem o valor mudar; pular quando igual ao
        *-- ultimo valor ja validado.
        IF loc_cDesc == THIS.this_cUltimoValidarDContaLostFocusValidado
            RETURN
        ENDIF

        TRY
            IF EMPTY(loc_cDesc)
                loc_oPg2.txt_4c_DConta.Value = ""
            ELSE
                THIS.AbrirLookupDConta()
            ENDIF

            THIS.AtualizarEstadoCampos()

            THIS.this_cUltimoValidarDContaLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_DConta.Value)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.ValidarDContaLostFocus: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupDConta()
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TxtDContaDblClick()
        THIS.AbrirLookupDConta()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROTECTED PROCEDURE AbrirLookupDConta()
        LOCAL loc_oBusca, loc_cDesc, loc_oPg2, loc_lMostrou

        IF !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)

        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCliD", "rclis", loc_cDesc, ;
                "Contas", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
                    SELECT cursor_4c_BuscaCliD
                    loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCliD.iclis)
                    loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
                ELSE
                    IF loc_lMostrou
                        loc_oPg2.txt_4c_Conta.Value  = ""
                        loc_oPg2.txt_4c_DConta.Value = ""
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupDConta: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = .F.

        THIS.FecharCursorBusca("cursor_4c_BuscaCliD")
    ENDPROC

    *===========================================================================
    * CELULAS DA GRADE DE FASES - "When" comum as cinco
    *
    * Legado (Column1..5.Text1.When, corpo IDENTICO nas cinco):
    *   Return Inlist( ThisForm.pcEscolha, 'INSERIR', 'ALTERAR' )
    *
    * PUBLIC: a classe TextBoxCelulaDmp_4c chama este metodo de FORA
    * (THISFORM.GradeFasesCelulaWhen()), nao por BINDEVENT - PROTECTED
    * estouraria "Property GRADEFASESCELULAWHEN is not found" em runtime,
    * mesmo com o PEMSTATUS da classe devolvendo .T. (regra #3/#51).
    *===========================================================================
    PROCEDURE GradeFasesCelulaWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *===========================================================================
    * GradeFasesOrdemValid - Column1.Text1.Valid do legado (coluna Ordem)
    *
    *   If !Between( This.Value, 0, 999 )
    *       Messagebox( 'Entre com um valor entre 1 e 999...', 32, '' )
    *       This.Value = 0
    *       Return
    *   Endif
    *
    * O limite 0..999 nao e enfeite: SigCdDpr.ordems e numeric(4,0) e o
    * InputMask "999" do dump reflete o mesmo teto.
    *===========================================================================
    PROCEDURE GradeFasesOrdemValid(par_oTxt)
        LOCAL loc_nOrdem

        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        TRY
            *-- O valor digitado vive na .Value da celula; o cursor so o
            *-- recebe depois (regra #46). VARTYPE antes de comparar: celula
            *-- recem-criada pode trazer character.
            loc_nOrdem = IIF(VARTYPE(par_oTxt.Value) = "N", par_oTxt.Value, ;
                VAL(TRANSFORM(par_oTxt.Value)))

            IF !BETWEEN(loc_nOrdem, 0, 999)
                MsgAviso("Entre com um valor entre 1 e 999...", "FormSigOpDmp")
                par_oTxt.Value = 0
                THIS.GravarCelulaFase("ordems", 0)
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.GradeFasesOrdemValid: " + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *===========================================================================
    * GradeFasesFaseValid - Column2.Text1.Valid do legado (coluna Fase)
    *
    *   If not IsEmpty(This.Value)
    *       If not Seek(Padr(This.Value,10),'crSigCdGcr','BalCodigo')
    *           xBrow = CreateObject('fwBuscaInt','crSigCdGcr','Codigos',...)
    *           ... xBrow.Show
    *           If Lastkey()<>27 -> This.Value = crSigCdGcr.Codigos
    *       EndIf
    *   EndIf
    *
    * Repare que aqui o ESC NAO limpa a celula (diferente das colunas
    * Funcionario e Tipo Operacao): o legado so atribui quando LastKey()<>27.
    *===========================================================================
    PROCEDURE GradeFasesFaseValid(par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
            THIS.AbrirLookupFaseGrade(par_oTxt)
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * AbrirLookupFaseGrade - Lookup da coluna Fase (SigCdGcr)
    * Universo: gerbals = 1, o mesmo do crSigCdGcr do Init legado.
    * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
    *===========================================================================
    PROCEDURE AbrirLookupFaseGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cFase, loc_lEmLookupAnt

        IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_cFase = ALLTRIM(TRANSFORM(par_oTxt.Value))

        *-- save/restore (nao set/clear): este metodo e chamado tanto do Valid
        *-- quanto do F4/DblClick da propria celula, e um clear interno
        *-- liberaria a flag cedo demais se houver aninhamento (regra #47).
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaFase", "codigos", loc_cFase, ;
                "Cadastro de Grupos", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
                    SELECT cursor_4c_BuscaFase
                    *-- O codigo escolhido vai para os DOIS lugares: .Value e
                    *-- cursor. Sem a .Value o texto digitado sobrescreveria o
                    *-- cursor na saida da celula (regra #46).
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFase.codigos)
                    THIS.GravarCelulaFase("grupos", ;
                        PADR(ALLTRIM(cursor_4c_BuscaFase.codigos), 10))
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupFaseGrade: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = loc_lEmLookupAnt

        THIS.FecharCursorBusca("cursor_4c_BuscaFase")
    ENDPROC

    *===========================================================================
    * GradeFasesFuncionarioValid - Column3.Text1.Valid (coluna Funcionario)
    *
    *   If !IsEmpty( This.Value )
    *       If !Seek( This.Value, 'crSigCdCli', 'BalCodigo' ) -> fwBuscaSel
    *           If Lastkey() = 27 -> this.Value = ''
    *           Else              -> this.Value = crSigCdCli.Iclis
    *       Endif
    *       If !fAcessoContas( Usuar, crSigCdDpr.Grupos, 'C', This.Value )
    *           Messagebox( 'Acesso Negado...', 48, '' )
    *           This.Value = ''
    *       Endif
    *   Endif
    *
    * O check de acesso e a parte que NAO se pode perder: a conta pode existir
    * e o usuario nao ter permissao para ela naquele grupo. fAcessoContas e
    * chamada com QUATRO argumentos, que e o modo "sem UI" (nao recebe objeto
    * TextBox): ela consulta SigSyAcc/SigSyAgc/SigCdAcG e devolve logico, sem
    * abrir picker nem popular campo nenhum.
    *===========================================================================
    PROCEDURE GradeFasesFuncionarioValid(par_oTxt)
        LOCAL loc_cConta, loc_cGrupoLinha, loc_cUsuario

        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        TRY
            IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
                THIS.AbrirLookupFuncionarioGrade(par_oTxt)

                loc_cConta = ALLTRIM(TRANSFORM(par_oTxt.Value))

                *-- O check de acesso so faz sentido com conta resolvida e com
                *-- conexao: fAcessoContas consulta o banco.
                IF !EMPTY(loc_cConta) AND THIS.ConexaoAtiva()
                    loc_cGrupoLinha = THIS.GrupoDaLinhaFase()
                    loc_cUsuario    = THIS.UsuarioCorrente()

                    IF !fAcessoContas(loc_cUsuario, loc_cGrupoLinha, "C", loc_cConta)
                        MsgAviso("Acesso Negado...", "FormSigOpDmp")
                        par_oTxt.Value = ""
                        THIS.GravarCelulaFase("contas", SPACE(10))
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.GradeFasesFuncionarioValid: " + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *===========================================================================
    * AbrirLookupFuncionarioGrade - Lookup da coluna Funcionario (SigCdCli)
    * Universo: gerbals = 1, o mesmo do crSigCdCli do Init legado.
    * Aqui o ESC LIMPA a celula (this.Value = ''), como o legado.
    * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
    *===========================================================================
    PROCEDURE AbrirLookupFuncionarioGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cConta, loc_lEmLookupAnt, loc_lMostrou

        IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_cConta = ALLTRIM(TRANSFORM(par_oTxt.Value))

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaFunc", "iclis", loc_cConta, ;
                "Cadastro de Contas", .F., .T., "gerbals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis",  "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("grupos", "", "Grupo")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFunc")
                    SELECT cursor_4c_BuscaFunc
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaFunc.iclis)
                    THIS.GravarCelulaFase("contas", ;
                        PADR(ALLTRIM(cursor_4c_BuscaFunc.iclis), 10))
                ELSE
                    IF loc_lMostrou
                        par_oTxt.Value = ""
                        THIS.GravarCelulaFase("contas", SPACE(10))
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupFuncionarioGrade: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = loc_lEmLookupAnt

        THIS.FecharCursorBusca("cursor_4c_BuscaFunc")
    ENDPROC

    *===========================================================================
    * GradeFasesTpOpValid - Column4.Text1.Valid (coluna Tipo Operacao)
    *
    *   If IsEmpty( This.Value ) -> Return .t.
    *   Select crSigOpOpt / Set Order to Cods / Set Near On
    *   If !Seek( This.Value ) Or ( crSigCdDpr.Grupos # crSigOpOpt.Grupos
    *                               And !IsEmpty( crSigOpOpt.Grupos ) )
    *       lcGrupo = crSigCdDpr.Grupos
    *       Select Cods, Descs, pFalhas From crSigOpOpt
    *           where Grupos = lcGrupo Or IsEmpty( Grupos ) Into cursor TmpOpt
    *       loBrowse = fwBuscaSel( 'TmpOpt', 'Cods', ... )
    *       This.Value = Iif( Lastkey() == 27, '', TmpOpt.Cods )
    *   Endif
    *
    * A condicao do WHERE e regra de negocio e vai inteira: um tipo de
    * operacao serve se for do grupo da LINHA ou se for generico (Grupos
    * vazio). Esse filtro tambem e o que invalida um codigo que existe mas
    * pertence a outro grupo - e por isso ele vai no 9o argumento do
    * FormBuscaAuxiliar, que o aplica TAMBEM na busca exata.
    *===========================================================================
    PROCEDURE GradeFasesTpOpValid(par_oTxt)
        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        *-- "If IsEmpty(This.Value) -> Return .t." do legado: tipo de operacao
        *-- em branco e valido e nao abre nada.
        IF !EMPTY(ALLTRIM(TRANSFORM(par_oTxt.Value)))
            THIS.AbrirLookupTpOpGrade(par_oTxt)
        ENDIF

        RETURN .T.
    ENDPROC

    *===========================================================================
    * AbrirLookupTpOpGrade - Lookup da coluna Tipo Operacao (SigOpOpt)
    * Aqui o ESC LIMPA a celula (Iif(Lastkey()==27,'',TmpOpt.Cods)).
    * PUBLIC: chamado de FORA pela classe TextBoxCelulaDmp_4c (regra #51).
    *===========================================================================
    PROCEDURE AbrirLookupTpOpGrade(par_oTxt)
        LOCAL loc_oBusca, loc_cTpOp, loc_cGrupoLinha, loc_cFiltro
        LOCAL loc_lEmLookupAnt, loc_lMostrou

        IF VARTYPE(par_oTxt) != "O" OR !THIS.ConexaoAtiva()
            RETURN
        ENDIF

        loc_cTpOp       = ALLTRIM(TRANSFORM(par_oTxt.Value))
        loc_cGrupoLinha = THIS.GrupoDaLinhaFase()

        *-- "Where Grupos = lcGrupo Or IsEmpty( Grupos )" do legado.
        *-- EscaparSQL JA devolve o valor COM as aspas (regra #5).
        loc_cFiltro = "(RTRIM(grupos) = " + EscaparSQL(loc_cGrupoLinha) + ;
            " OR RTRIM(grupos) = '')"

        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpOpt", "cursor_4c_BuscaTpOp", "cods", loc_cTpOp, ;
                "Cadastro de Tipos de Opera" + CHR(231) + CHR(227) + "o", ;
                .F., .T., loc_cFiltro)

            IF VARTYPE(loc_oBusca) = "O"
                loc_lMostrou = .F.

                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cods",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descs",   "", ;
                        "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("pfalhas", "999.99 %", "Falha")
                    loc_oBusca.Show()
                    loc_lMostrou = .T.
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpOp")
                    SELECT cursor_4c_BuscaTpOp
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaTpOp.cods)
                    THIS.GravarCelulaFase("tpops", ;
                        PADR(ALLTRIM(cursor_4c_BuscaTpOp.cods), 15))
                ELSE
                    IF loc_lMostrou
                        par_oTxt.Value = ""
                        THIS.GravarCelulaFase("tpops", SPACE(15))
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.AbrirLookupTpOpGrade: " + ;
                loException.Message, "Erro")
        ENDTRY
        THIS.this_lEmLookup = loc_lEmLookupAnt

        THIS.FecharCursorBusca("cursor_4c_BuscaTpOp")
    ENDPROC

    *===========================================================================
    * GradeFasesEsValid - Column5.Text1.Valid do legado (coluna E/S)
    *
    *   If !Inlist( Upper( This.Value ), 'E', 'S', 'P', 'H', 'T' )
    *       Messagebox( 'Informe [E]NTRADA / [S]AIDA / [P]OSICAO ATUAL...',32,'')
    *       This.Value = ' '
    *       Return
    *   Endif
    *
    * A lista das cinco letras e regra de negocio: TRANSCRITA, nao deduzida da
    * mensagem (que so cita tres delas). Repare que a lista NAO inclui o
    * branco - o legado recusa a celula vazia e a repoe com um espaco, o que
    * dispara o aviso de novo na proxima saida. Comportamento do legado,
    * mantido (PILAR 1).
    *===========================================================================
    PROCEDURE GradeFasesEsValid(par_oTxt)
        LOCAL loc_cEs

        IF VARTYPE(par_oTxt) != "O"
            RETURN .T.
        ENDIF

        TRY
            loc_cEs = UPPER(ALLTRIM(TRANSFORM(par_oTxt.Value)))

            IF !INLIST(loc_cEs, "E", "S", "P", "H", "T")
                MsgAviso("Informe [E]NTRADA / [S]A" + CHR(205) + "DA / " + ;
                    "[P]OSI" + CHR(199) + CHR(195) + "O ATUAL...", ;
                    "FormSigOpDmp")
                par_oTxt.Value = " "
                THIS.GravarCelulaFase("operas", " ")
            ELSE
                *-- Format = "K!" do legado forca maiuscula na digitacao; a
                *-- normalizacao aqui cobre o valor vindo do cursor/banco.
                par_oTxt.Value = loc_cEs
                THIS.GravarCelulaFase("operas", loc_cEs)
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.GradeFasesEsValid: " + ;
                loException.Message, "Erro")
        ENDTRY

        RETURN .T.
    ENDPROC

    *===========================================================================
    * FASE 7 - EVENTOS PRINCIPAIS (os ramos do Grupo_op.Click do legado)
    *
    * No legado os cinco botoes da barra da Lista sao UM CommandGroup
    * (Pagina.Lista.Grupo_op) e o Do Case do frmcadastro resolve o verbo pelo
    * Value do grupo:
    *
    *   Value | pcEscolha  | o que o frmcadastro faz
    *   ------+------------+------------------------------------------------
    *     1   | INSERIR    | poDataMgr.NewReg(1,.t.)  -> registro em branco
    *     2   | CONSULTAR  | ReQuery(1, PK, <cursor>.PK) -> recarrega o atual
    *     3   | ALTERAR    | ReQuery(1, PK, <cursor>.PK)
    *     4   | EXCLUIR    | ReQuery(1, PK, <cursor>.PK)
    *     5   | PROCURAR   | NewReg(1) (busca por exemplo - Fase 8)
    *
    * e, DEPOIS do Do Case, comum a todos:
    *   mObjEnabled(Pagina.Dados,.t.)
    *   If (Value<>0) And (Not Used(<cursor>) Or Not Eof(<cursor>))
    *       Pagina.Dados.Grupo_Salva.Salva.Enabled = (Not pcEscolha=[CONSULTAR])
    *       Pagina.ActivePage = 2
    *   Else
    *       Return .f.            && lista vazia: NAO vai para a ficha
    *   EndIf
    *
    * O SCX do SIGOPDMP sobrescreve esse Click e acrescenta o que e PROPRIO
    * desta tela (o detalhe SigCdDpr):
    *   If !DoDefault(opcao) / ThisForm.mAtivapagina1 / Return
    *   Do Case ... SetFocus (GetNome | Salva | Get_Grupo)
    *   grade.RecordSource = ''
    *   If not Inlist(pcEscolha,'INSERIR','PROCURAR')
    *       IniciaDesc() / sNome = getNome.Value / Requery('crSigCdDpr')
    *   Else
    *       Zap in ('crSigCdDpr')
    *   EndIf
    *   <re-liga as 5 colunas da grade> / Go Top in ('crSigCdDpr') / Refresh
    *
    * Aqui cada botao e um CommandButton com o seu proprio handler PUBLIC
    * (BINDEVENT exige metodo publico - regra #3) e os tres ramos que carregam
    * registro existente compartilham o funil AbrirFichaDoRegistro: o verbo
    * muda so o modo resultante e o foco inicial.
    *
    * A EXCLUSAO NAO ACONTECE AQUI: no legado o Excluir apenas abre a ficha em
    * modo EXCLUIR com os campos travados, e quem pergunta "Deseja Realmente
    * Excluir Esses Dados?" e executa o DELETE e o Salva.Click (frmcadastro:
    * Case pcEscolha=[EXCLUIR] -> MessageBox + mSv_Excluir, mais o ExcluiItens
    * desta tela, que apaga as linhas de SigCdDpr). Esse caminho e o Confirmar,
    * da Fase 8.
    *===========================================================================

    *===========================================================================
    * LimparCampos - Deixa a ficha em branco (legado: poDataMgr.NewReg, que
    * cria um registro VAZIO no cursor mestre, e os controles ligados a ele
    * passam a exibir branco).
    * Os campos desta tela nao tem ControlSource: quem os esvazia e este
    * metodo. Os PEMSTATUS existem porque ele pode ser chamado antes de a
    * pagina Dados estar inteiramente montada.
    * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
    * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
    * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
    * o modificador nao torna o metodo publico, so esconde do leitor que ele
    * continua protegido. Chamar sempre por THIS. de dentro da classe; de
    * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
    * "da para chamar daqui?").
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
                loc_oPg2.txt_4c_Nome.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                loc_oPg2.txt_4c_Grupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5)
                loc_oPg2.txt_4c_DGrupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                loc_oPg2.txt_4c_Conta.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                loc_oPg2.txt_4c_DConta.Value = ""
            ENDIF

            *-- Reseta a guarda de "ultimo valor validado" dos 4 lookups
            *-- (CHR(1), nunca igual a um valor real) para a ficha em branco
            *-- nao herdar o ultimo valor validado do registro anterior.
            THIS.this_cUltimoValidarGrupoLostFocusValidado  = CHR(1)
            THIS.this_cUltimoValidarDGrupoLostFocusValidado = CHR(1)
            THIS.this_cUltimoValidarContaLostFocusValidado  = CHR(1)
            THIS.this_cUltimoValidarDContaLostFocusValidado = CHR(1)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.LimparCampos: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Espelha as propriedades do BO nos campos da ficha
    *
    * SigPrDmo tem QUATRO colunas: nome, grupos, contas e cidchaves. As tres
    * primeiras tem campo na tela; cidchaves e a PK Fortyus, que o legado
    * tambem nunca exibe (e gerada por fUniqueIds no Salva.Click) e por isso
    * fica so na property do BO.
    * As DESCRICOES (txt_4c_DGrupo/txt_4c_DConta) nao vem do BO: sao de outras
    * tabelas e sao resolvidas por CarregarDescricoesMestre, o IniciaDesc do
    * legado.
    * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
    * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
    * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
    * o modificador nao torna o metodo publico, so esconde do leitor que ele
    * continua protegido. Chamar sempre por THIS. de dentro da classe; de
    * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
    * "da para chamar daqui?").
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp.BOParaForm")
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                loc_oBO  = THIS.this_oBusinessObject

                loc_oPg2.txt_4c_Nome.Value  = ALLTRIM(loc_oBO.this_cNome)
                loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupos)
                loc_oPg2.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContas)

                *-- Reseta a guarda de "ultimo valor validado" para o valor
                *-- que acabou de vir do BO: o registro foi carregado AGORA,
                *-- nao via lookup, e sem isto um valor igual ao do registro
                *-- anterior (editado na mesma sessao do form) faria o
                *-- 1o LostFocus deste registro ser pulado por engano.
                THIS.this_cUltimoValidarGrupoLostFocusValidado = ;
                    ALLTRIM(loc_oBO.this_cGrupos)
                THIS.this_cUltimoValidarContaLostFocusValidado = ;
                    ALLTRIM(loc_oBO.this_cContas)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.BOParaForm: " + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarDescricoesMestre - PROCEDURE iniciadesc do legado
    *
    *   Chave = crSigPrDmo.Grupos
    *   If not IsEmpty(Chave)
    *       poDataMgr.CursorQuery('SigCdGcr','crCursorPesq','Codigos',Chave)
    *       Get_DGrupo.Value = crCursorPesq.DesCrs
    *   Else
    *       Get_DGrupo.Value = ''
    *   EndIf
    *   <o mesmo para Contas -> SigCdCli.iclis -> Get_DConta = rclis>
    *
    * O CursorQuery do fSqlConector consulta a TABELA pela chave, sem o filtro
    * gerbals = 1 que o Init aplica aos cursores de LOOKUP - logo a descricao
    * aparece mesmo para um grupo/conta que hoje nao esteja mais marcado como
    * de balanco. Transcrito assim de proposito: filtrar aqui esconderia a
    * descricao de registro gravado antes da mudanca do cadastro.
    *
    * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir.
    *===========================================================================
    PROCEDURE CarregarDescricoesMestre()
        LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_cSQL, loc_nResultado

        TRY
            loc_oPg2   = THIS.pgf_4c_Paginas.Page2
            loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)

            *-- Descricao do Grupo Sd Inicial (SigCdGcr.descrs)
            IF EMPTY(loc_cGrupo) OR !THIS.ConexaoAtiva()
                loc_oPg2.txt_4c_DGrupo.Value = ""
            ELSE
                THIS.FecharCursorBusca("cursor_4c_DescGcr")

                loc_cSQL = "SELECT descrs FROM SigCdGcr" + ;
                    " WHERE RTRIM(codigos) = " + EscaparSQL(loc_cGrupo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGcr")

                IF loc_nResultado < 0
                    MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
                        "o do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_oPg2.txt_4c_DGrupo.Value = ""
                ELSE
                    IF USED("cursor_4c_DescGcr") AND RECCOUNT("cursor_4c_DescGcr") > 0
                        GO TOP IN cursor_4c_DescGcr
                        loc_oPg2.txt_4c_DGrupo.Value = ;
                            ALLTRIM(TratarNulo(cursor_4c_DescGcr.descrs, ""))
                    ELSE
                        loc_oPg2.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF

                THIS.FecharCursorBusca("cursor_4c_DescGcr")
            ENDIF

            *-- Descricao da Conta Sd Inicial (SigCdCli.rclis)
            IF EMPTY(loc_cConta) OR !THIS.ConexaoAtiva()
                loc_oPg2.txt_4c_DConta.Value = ""
            ELSE
                THIS.FecharCursorBusca("cursor_4c_DescCli")

                loc_cSQL = "SELECT rclis FROM SigCdCli" + ;
                    " WHERE RTRIM(iclis) = " + EscaparSQL(loc_cConta)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")

                IF loc_nResultado < 0
                    MsgErro("Erro ao ler a descri" + CHR(231) + CHR(227) + ;
                        "o da conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_oPg2.txt_4c_DConta.Value = ""
                ELSE
                    IF USED("cursor_4c_DescCli") AND RECCOUNT("cursor_4c_DescCli") > 0
                        GO TOP IN cursor_4c_DescCli
                        loc_oPg2.txt_4c_DConta.Value = ;
                            ALLTRIM(TratarNulo(cursor_4c_DescCli.rclis, ""))
                    ELSE
                        loc_oPg2.txt_4c_DConta.Value = ""
                    ENDIF
                ENDIF

                THIS.FecharCursorBusca("cursor_4c_DescCli")
            ENDIF

            *-- Reseta a guarda de "ultimo valor validado" das descricoes
            *-- para o valor que acabou de vir do banco (mesmo motivo do
            *-- BOParaForm): elas nao passaram pelo lookup, e um valor igual
            *-- ao do registro anterior pularia o 1o LostFocus por engano.
            THIS.this_cUltimoValidarDGrupoLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value)
            THIS.this_cUltimoValidarDContaLostFocusValidado = ;
                ALLTRIM(loc_oPg2.txt_4c_DConta.Value)

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.CarregarDescricoesMestre: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparFases - o "Zap in ('crSigCdDpr')" do ramo INSERIR/PROCURAR
    *
    * ZAP (e nao USE IN + CREATE CURSOR) de proposito: fechar e recriar o alias
    * derruba Grid.RecordSource e as Column.ControlSource ligadas na montagem
    * da pagina, e a grade fica permanentemente vazia com o cursor cheio. O
    * legado Fortyus faz "Zap In <cursor>" exatamente por isso.
    *
    * O par SET SAFETY e obrigatorio: com SAFETY ON o ZAP abre o dialogo modal
    * de confirmacao e CONGELA a tela. SET SAFETY e escopado por data session,
    * logo o SET SAFETY OFF do main.prg nao alcanca form com DataSession = 2 -
    * e o estado anterior e reposto para nao mexer no ambiente do chamador.
    *===========================================================================
    PROTECTED PROCEDURE LimparFases()
        LOCAL loc_cSafety

        IF USED("cursor_4c_Fases")
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF

            ZAP IN cursor_4c_Fases

            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * CarregarFasesDoBanco - o Requery('crSigCdDpr') do legado
    *
    * Query do AddCursor do Init legado, com o nome da ficha no lugar do
    * parametro ?sNome que o Grupo_op.Click atribuia antes do Requery:
    *   Select * From SigCdDpr Where nome=?sNome Order By Ordems
    *
    * O SELECT vai para um cursor TEMPORARIO e as linhas entram no
    * cursor_4c_Fases por ZAP + APPEND FROM: SQLEXEC direto sobre o alias da
    * grade DESTROI o cursor e com ele todas as Column (Problema 34) - a linha
    * seguinte estouraria "Unknown member COLUMN1". A lista de colunas segue a
    * ordem EXATA de SigCdDpr, que e a ordem do CREATE CURSOR de
    * CriarCursorFases, porque APPEND FROM casa os campos por POSICAO.
    *
    * PUBLIC: chamado pelos handlers de Alterar/Visualizar/Excluir e pela
    * Fase 8 (o Confirmar recarrega a ficha gravada).
    *===========================================================================
    PROCEDURE CarregarFasesDoBanco()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cNome, loc_nAliasAnt
        loc_lResultado = .F.

        TRY
            loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)

            IF !USED("cursor_4c_Fases")
                *-- O placeholder e criado na montagem da pagina Dados; se
                *-- algum caminho de erro o fechou, recria-lo aqui e o que
                *-- permite a grade voltar a funcionar. Quem religa a grade e o
                *-- VincularGradeFases, chamado pelos handlers logo depois.
                THIS.CriarCursorFases()
            ENDIF

            IF !THIS.ConexaoAtiva()
                *-- Sem conexao (ValidarUIFidelity / teste headless) a ficha
                *-- abre com a grade vazia, nao com as linhas da ficha anterior.
                THIS.LimparFases()
                loc_lResultado = .T.
            ELSE
                THIS.FecharCursorBusca("cursor_4c_FasesTmp")

                loc_cSQL = "SELECT contas, grupos, nome, operas, ordems," + ;
                    " tpops, cidchaves, dopes FROM SigCdDpr" + ;
                    " WHERE RTRIM(nome) = " + EscaparSQL(loc_cNome) + ;
                    " ORDER BY ordems"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar as fases do demonstrativo:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.LimparFases()

                    IF USED("cursor_4c_FasesTmp") AND ;
                       RECCOUNT("cursor_4c_FasesTmp") > 0
                        loc_nAliasAnt = SELECT(0)
                        SELECT cursor_4c_Fases
                        APPEND FROM DBF("cursor_4c_FasesTmp")
                        SELECT (loc_nAliasAnt)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF

                THIS.FecharCursorBusca("cursor_4c_FasesTmp")
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.CarregarFasesDoBanco: " + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FocarAposAbrirFicha - o Do Case de SetFocus do Grupo_op.Click do SCX
    *
    *   Case Inlist(pcEscolha,'INSERIR','PROCURAR')  -> GetNome.SetFocus
    *   Case Inlist(pcEscolha,'EXCLUIR','CONSULTAR') -> Grupo_Salva.Salva
    *   Case pcEscolha = 'ALTERAR'                   -> Get_Grupo.SetFocus
    *
    * Em CONSULTAR o frmcadastro DESABILITA o Confirmar
    * (Salva.Enabled = Not pcEscolha = [CONSULTAR]) e SetFocus em controle
    * desabilitado dispara erro - por isso o Enabled e conferido antes e o foco
    * cai no Cancelar, que nesse modo e a unica saida da ficha.
    *===========================================================================
    PROTECTED PROCEDURE FocarAposAbrirFicha()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "PROCURAR")
                IF loc_oPg2.txt_4c_Nome.Enabled AND loc_oPg2.txt_4c_Nome.Visible
                    loc_oPg2.txt_4c_Nome.SetFocus()
                ENDIF

            CASE THIS.this_cModoAtual == "ALTERAR"
                IF loc_oPg2.txt_4c_Grupo.Enabled AND loc_oPg2.txt_4c_Grupo.Visible
                    loc_oPg2.txt_4c_Grupo.SetFocus()
                ENDIF

            CASE INLIST(THIS.this_cModoAtual, "EXCLUIR", "VISUALIZAR")
                IF loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled AND ;
                   loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible
                    loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
                ELSE
                    IF loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled AND ;
                       loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Visible
                        loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
                    ENDIF
                ENDIF
        ENDCASE
    ENDPROC

    *===========================================================================
    * AbrirFichaDoRegistro - funil dos tres verbos que carregam registro
    * existente (CONSULTAR, ALTERAR e EXCLUIR do Grupo_op.Click)
    *
    * Os tres fazem a MESMA coisa no legado - ReQuery(1, PK, <cursor>.PK), ou
    * seja recarregam do BANCO o registro em que a grade da Lista esta
    * posicionada - e divergem so no modo resultante (que e quem trava os
    * campos e habilita o Confirmar) e no foco inicial.
    *
    * Com a Lista VAZIA o frmcadastro devolve .F. e o Click do SCX volta para a
    * pagina 1 sem abrir a ficha. Aqui a recusa vem com MsgAviso: o silencio do
    * legado e efeito da arquitetura dele, e botao que nao responde ao clique
    * nem explica por que e o pior dos dois mundos.
    *===========================================================================
    PROTECTED PROCEDURE AbrirFichaDoRegistro(par_cModo)
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_cErroBO
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
               EOF("cursor_4c_Dados")
                MsgAviso("Selecione um demonstrativo na lista.", "FormSigOpDmp")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cNome = ALLTRIM(TratarNulo(cursor_4c_Dados.nome, ""))

                IF EMPTY(loc_cNome)
                    MsgAviso("A linha selecionada n" + CHR(227) + "o tem nome " + ;
                        "de demonstrativo.", "FormSigOpDmp")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- ReQuery do legado: o registro vem do BANCO, nao do cursor
                *-- da grade - a lista pode estar na tela desde antes de outro
                *-- usuario alterar o registro.
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cNome)
                    loc_cErroBO = ;
                        ALLTRIM(THIS.this_oBusinessObject.ObterMensagemErro())
                    IF !EMPTY(loc_cErroBO)
                        MsgAviso(loc_cErroBO, "FormSigOpDmp")
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- EditarRegistro so no ALTERAR: ele liga this_lEmEdicao, que
                *-- e o que autoriza o Salvar do BusinessBase. CONSULTAR e
                *-- EXCLUIR nao gravam por este caminho.
                IF par_cModo == "ALTERAR"
                    THIS.this_oBusinessObject.EditarRegistro()
                ENDIF

                THIS.BOParaForm()
                THIS.CarregarDescricoesMestre()
                THIS.CarregarFasesDoBanco()

                *-- Modo ANTES de trocar de pagina: AlternarPagina chama
                *-- AjustarBotoesPorModo, que decide o Confirmar e o ReadOnly
                *-- dos campos pelo modo (Problema 19).
                THIS.this_cModoAtual = par_cModo
                THIS.AlternarPagina(2)

                *-- Re-liga a grade DEPOIS de popular o cursor, como o
                *-- Grupo_op.Click do legado, e repinta so com a pagina JA
                *-- ativa: Refresh em pagina oculta nao pinta (regra #21).
                THIS.VincularGradeFases()
                THIS.RepintarGradeFases()

                THIS.FocarAposAbrirFicha()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir a ficha do demonstrativo:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.AbrirFichaDoRegistro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Grupo_op.Click(1), pcEscolha = 'INSERIR'
    *
    * Legado: poDataMgr.NewReg(1,.t.) poe o cursor mestre num registro em
    * branco; o ramo INSERIR do Click do SCX faz "Zap in ('crSigCdDpr')", logo
    * a grade de fases abre VAZIA - a primeira linha nasce quando o Nome e
    * confirmado (GetNome.Valid -> InsiraRegGrade, ja em ValidarNomeLostFocus)
    * ou pelo botao Inserir de linha.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
    * chama este metodo de fora.
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp.BtnIncluirClick")
            ELSE
                *-- NovoRegistro limpa as properties do BO e liga
                *-- this_lNovoRegistro, que e o que faz o Salvar escolher
                *-- INSERT em vez de UPDATE. Sem ele o Confirmar da Fase 8
                *-- tentaria atualizar um registro que ainda nao existe.
                THIS.this_oBusinessObject.NovoRegistro()

                THIS.LimparCampos()
                THIS.LimparFases()

                THIS.this_cModoAtual = "INCLUIR"
                THIS.AlternarPagina(2)

                THIS.VincularGradeFases()
                THIS.RepintarGradeFases()

                THIS.FocarAposAbrirFicha()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao iniciar a inclus" + CHR(227) + "o:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.BtnIncluirClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Grupo_op.Click(2), pcEscolha = 'CONSULTAR'
    *
    * Ficha somente leitura: o AjustarBotoesPorModo deixa o Confirmar
    * desabilitado (frmcadastro: Salva.Enabled = Not pcEscolha=[CONSULTAR]) e o
    * AtualizarEstadoCampos poe ReadOnly em todos os campos, porque o "When"
    * deles so libera INSERIR e ALTERAR.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        RETURN THIS.AbrirFichaDoRegistro("VISUALIZAR")
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Grupo_op.Click(3), pcEscolha = 'ALTERAR'
    *
    * Unico verbo que chama EditarRegistro no BO. O Nome continua travado
    * (NomeEditavel devolve .F. fora de INCLUIR/PROCURAR): ele e a chave que
    * amarra as linhas de SigCdDpr ao demonstrativo.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        RETURN THIS.AbrirFichaDoRegistro("ALTERAR")
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Grupo_op.Click(4), pcEscolha = 'EXCLUIR'
    *
    * NAO exclui nada: abre a ficha travada em modo EXCLUIR, com o Confirmar
    * habilitado, exatamente como o legado. A pergunta "Deseja Realmente
    * Excluir Esses Dados?" e o DELETE (mSv_Excluir + ExcluiItens, que apaga as
    * linhas de SigCdDpr do mesmo nome) vivem no Confirmar, da Fase 8.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        RETURN THIS.AbrirFichaDoRegistro("EXCLUIR")
    ENDPROC

    *===========================================================================
    * GradeListaKeyPress / GradeListaDblClick - atalhos da grade da Lista
    *
    * O frmcadastro trata o Enter na grade da Lista como CONSULTAR:
    *   Case (nKeyCode = 13) And lnPag = 1 And ...ActiveControl.BaseClass=[GRID]
    *       NoDefault / loGrp.Click(2)
    * O duplo clique nao existe no legado e vai para o MESMO funil: e o gesto
    * que o usuario tenta primeiro numa lista e nao retira nada da tela.
    *
    * KeyPress PRECISA declarar os dois parametros do evento (regra #3): sem
    * eles o VFP estoura "No PARAMETER statement is found" a cada tecla.
    * PUBLIC: alvo de BINDEVENT.
    *===========================================================================
    PROCEDURE GradeListaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 AND par_nShiftAltCtrl = 0 AND ;
           THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    PROCEDURE GradeListaDblClick()
        IF THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.BtnVisualizarClick()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a ficha e volta para a pagina Lista
    * Legado: Grupo_Salva.Cancelar.Click -> DoDefault() e, se plCancelar,
    * ThisForm.mAtivapagina1. AlternarPagina(1) ja repoe o modo LISTA,
    * recarrega a grade e reabilita os botoes CRUD.
    *
    * O mAtivapagina1 do frmcadastro ABRE com ".poDataMgr.RollBack": e o
    * rollback que faz o Cancelar realmente cancelar numa conexao em transacao
    * manual. Sem ele, uma gravacao parcial ainda aberta na transacao
    * seria efetivada depois, no disconnect.
    *
    * A confirmacao vem do Cancelar.Click do frmcadastro, transcrita:
    *   .plCancelar = (Not InList(.pcEscolha, [INSERIR], [ALTERAR]) Or
    *                  MessageBox([Confirma o Cancelamento Dos Dados
    *                  Informados?], 4+32+256, ...) = 6)
    * ou seja: so pergunta quando ha dado digitado para perder (INSERIR e
    * ALTERAR); em CONSULTAR/EXCLUIR/PROCURAR o Cancelar sai direto. E "Nao"
    * NAO fecha a ficha - o mAtivapagina1 do SCX so roda "If Thisform
    * .plCancelar". MsgConfirma devolve LOGICO, nunca 6 (regra #7).
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lCancelar

        loc_lCancelar = .T.

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_lCancelar = MsgConfirma("Confirma o Cancelamento Dos Dados " + ;
                "Informados?", "Confirma" + CHR(231) + CHR(227) + "o de " + ;
                "Cancelamento")
        ENDIF

        IF loc_lCancelar
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CancelarEdicao()
            ENDIF

            THIS.DesfazerTransacao()

            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * Legado: Grupo_Saida.SAIR, cujo Click do frmcadastro libera o form.
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FASE 8 - CONFIRMAR, BUSCAR POR EXEMPLO E PERSISTENCIA
    *
    * Legado (Pagina.Dados.Grupo_Salva.Salva.Click do SCX):
    *   <limpa RecordSource/ControlSource da grade de fases>
    *   If pcescolha = 'INSERIR' -> Replace cIdChaves With fUniqueIds()
    *   If Not poDataMgr.Update('crSigCdDpr') -> erro
    *   If Inlist( pcEscolha, 'EXCLUIR' ) -> ExcluiItens()
    *   =DoDefault()          && frmcadastro.Salva.Click: o Do Case por verbo
    *   ThisForm.mAtivapagina1
    *
    * e o Do Case do frmcadastro, que e o despachante de verdade:
    *   INSERIR   -> mSv_Inserir   (poDataMgr.Update(1) + Commit)
    *   CONSULTAR -> mSv_Consultar
    *   ALTERAR   -> mSv_Alterar   (poDataMgr.Update(1) + Commit)
    *   EXCLUIR   -> MessageBox('Deseja Realmente Excluir Esses Dados?')
    *                e, se 6, mSv_Excluir (poDataMgr.Delete(1) + Commit)
    *   PROCURAR  -> apaga o registro em branco do cursor mestre e chama
    *                mSv_Procurar, que nesta tela e o Seek por nome
    *===========================================================================

    *===========================================================================
    * FormParaBO - Transfere os campos da ficha para as propriedades do BO
    *
    * No SCX os TRES campos do cabecalho tem ControlSource no cursor mestre:
    *   GetNome   -> crSigPrDmo.nome
    *   Get_Grupo -> crSigPrDmo.Grupos
    *   Get_Conta -> crSigPrDmo.Contas
    * ou seja, o que o usuario digita vai DIRETO para o registro que o
    * TableUpdate do Salva.Click grava. Os campos desta tela nao tem
    * ControlSource (o valor vive na .Value) e este metodo e o equivalente.
    *
    * Os campos de DESCRICAO (txt_4c_DGrupo/txt_4c_DConta) NAO entram: eles
    * sao a segunda porta de entrada do lookup e vem de outras tabelas
    * (SigCdGcr.descrs e SigCdCli.rclis); quem os resolve e o
    * CarregarDescricoesMestre. SigPrDmo nao tem coluna de descricao.
    *
    * cidchaves tambem nao vem da tela: e a PK Fortyus de SigPrDmo. No
    * INCLUIR o Inserir do BO a gera com fUniqueIds (legado: "If pcescolha
    * ='INSERIR' Replace cIdChaves With fUniqueIds() in crSigPrDmo"); no
    * ALTERAR ela ja veio do CarregarPorCodigo e nao se toca.
    *
    * PROTECTED OBRIGATORIO: FormBase declara LimparCampos / BOParaForm /
    * FormParaBO como PROTECTED (sao os hooks que FormBase chama por THIS.) e
    * o VFP9 NAO deixa a subclasse ALARGAR o escopo - escrever PROCEDURE sem
    * o modificador nao torna o metodo publico, so esconde do leitor que ele
    * continua protegido. Chamar sempre por THIS. de dentro da classe; de
    * fora, nem o harness alcanca (PEMSTATUS(...,5) responde "existe?", nao
    * "da para chamar daqui?").
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp.FormParaBO")
            ELSE
                loc_oPg2 = THIS.pgf_4c_Paginas.Page2
                loc_oBO  = THIS.this_oBusinessObject

                *-- Os LEFT() respeitam a largura das colunas de SigPrDmo
                *-- (nome char(20), grupos char(10), contas char(10)): sem
                *-- eles o SQL Server recusa o INSERT inteiro com "String or
                *-- binary data would be truncated" (regra #19).
                loc_oBO.this_cNome   = LEFT(ALLTRIM(loc_oPg2.txt_4c_Nome.Value), 20)
                loc_oBO.this_cGrupos = LEFT(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value), 10)
                loc_oBO.this_cContas = LEFT(ALLTRIM(loc_oPg2.txt_4c_Conta.Value), 10)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.FormParaBO: " + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Libera ou trava os campos editaveis da ficha
    *
    * Equivale ao mObjEnabled(Pagina.Dados, .t.) do frmcadastro, chamado pelo
    * Grupo_op.Click antes de trocar de pagina.
    *
    * ReadOnly, e NAO Enabled (PILAR 1): o mObjEnabled do legado deixa
    * Enabled = .T. ate em CONSULTAR/EXCLUIR e mexe no ReadOnly justamente
    * para nao pintar o campo de cinza (ele chega a copiar ForeColor/BackColor
    * para DisabledForeColor/DisabledBackColor quando precisa desabilitar).
    * Enabled = .F. aplicaria o DisabledBackColor 192,192,192 e mudaria a tela.
    *
    * Com par_lHabilitar = .T. este metodo NAO decide nada por conta propria:
    * delega ao AtualizarEstadoCampos, que e a FONTE UNICA dos "When" do
    * legado (Nome editavel so em INCLUIR/PROCURAR com a grade em branco,
    * Grupo/Conta so em INCLUIR/ALTERAR, descricao so com o codigo vazio).
    * Duplicar a regra aqui criaria duas versoes dela para divergir.
    *
    * PUBLIC: alvo do harness de teste.
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar, loc_oPg2

        loc_lHabilitar = .T.
        IF VARTYPE(par_lHabilitar) = "L"
            loc_lHabilitar = par_lHabilitar
        ENDIF

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            IF loc_lHabilitar
                *-- Grid.ReadOnly ANTES das colunas: o do grid propaga
                *-- (regra #18). Quem bloqueia a digitacao celula a celula
                *-- fora de INCLUIR/ALTERAR e o GradeFasesCelulaWhen.
                IF PEMSTATUS(loc_oPg2, "grd_4c_Fases", 5)
                    loc_oPg2.grd_4c_Fases.ReadOnly = .F.
                ENDIF

                THIS.AtualizarEstadoCampos()
            ELSE
                IF PEMSTATUS(loc_oPg2, "txt_4c_Nome", 5)
                    loc_oPg2.txt_4c_Nome.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Grupo", 5)
                    loc_oPg2.txt_4c_Grupo.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DGrupo", 5)
                    loc_oPg2.txt_4c_DGrupo.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
                    loc_oPg2.txt_4c_Conta.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
                    loc_oPg2.txt_4c_DConta.ReadOnly = .T.
                ENDIF
                IF PEMSTATUS(loc_oPg2, "grd_4c_Fases", 5)
                    loc_oPg2.grd_4c_Fases.ReadOnly = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro em FormSigOpDmp.HabilitarCampos: " + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfirmarTransacao - o poDataMgr.Commit() do legado
    *
    * O legado NAO trata o Commit como detalhe de infra: ele e um passo com
    * caminho de falha PROPRIO, repetido em mSv_Inserir, mSv_Alterar,
    * mSv_Excluir e no ExcluiItens desta tela -
    *   If (ThisForm.poDataMgr.Commit() < 1)
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    * - e descarta-lo e defeito MUDO: neste ambiente
    * SQLGETPROP(0,"Transactions") ja vale 2 (transacao MANUAL) num VFP9
    * virgem, logo toda conexao nasce manual e o gravado sem SQLCOMMIT so
    * seria efetivado num SQLDISCONNECT limpo - some se o processo morrer.
    *
    * UM commit por gravacao, cobrindo o mestre (SigPrDmo) E as fases
    * (SigCdDpr): por isso ele vive aqui, no form, e nao dentro de cada
    * metodo do BO.
    *
    * loc_lManual deixa o par inerte se a conexao estiver em auto-commit, e o
    * IF e ANINHADO de proposito: VFP9 nao faz curto-circuito em AND, logo
    * "IF loc_lManual AND SQLCOMMIT(...)" chamaria o SQLCOMMIT de qualquer
    * jeito.
    *===========================================================================
    PROTECTED PROCEDURE ConfirmarTransacao()
        LOCAL loc_lResultado, loc_lManual
        loc_lResultado = .T.

        IF THIS.ConexaoAtiva()
            loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

            IF loc_lManual
                IF SQLCOMMIT(gnConnHandle) < 1
                    MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        CapturarErroSQL(), "Falha ao confirmar a grava" + ;
                        CHR(231) + CHR(227) + "o")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * DesfazerTransacao - o poDataMgr.RollBack do mAtivapagina1 legado
    *
    * O mAtivapagina1 do frmcadastro ABRE com ".poDataMgr.RollBack", ou seja
    * qualquer retorno a pagina Lista descarta o nao confirmado - e o que
    * faz o Cancelar realmente cancelar numa conexao em transacao manual.
    * Depois de um Confirmar bem-sucedido o rollback e inofensivo: a transacao
    * ja foi fechada pelo commit e nao resta nada aberto.
    *
    * O legado ignora o retorno do RollBack e aqui tambem: a conexao pode
    * estar em auto-commit (loc_lManual = .F.) ou sem transacao aberta, e os
    * dois casos sao normais - nao ha falha a reportar ao usuario.
    *===========================================================================
    PROTECTED PROCEDURE DesfazerTransacao()
        LOCAL loc_lManual

        IF THIS.ConexaoAtiva()
            loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Grupo_op.Click(5), pcEscolha = 'PROCURAR'
    *
    * Legado (frmcadastro.Pagina.Lista.Grupo_Op.Click, Case This.Value = 5):
    *   .pcEscolha = [PROCURAR]
    *   If (Used(<cursor mestre>) And Not Eof(<cursor mestre>))
    *       ThisForm.poDataMgr.NewReg(1)
    *   EndIf
    * e, no Click do SCX, "Zap in ('crSigCdDpr')" (o ramo nao-INSERIR e o
    * unico que faz Requery) e "GetNome.SetFocus".
    *
    * NAO ABRE PICKER. Este form tem PROCEDURE msv_procurar, logo o Procurar
    * e BUSCA POR EXEMPLO: ele poe a ficha em branco, libera SO o campo Nome
    * (o "When" de GetNome devolve .T. em PROCURAR e os de Grupo/Conta
    * devolvem .F.) e quem executa a consulta e o Confirmar.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
    * chama este metodo de fora.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel.", ;
                    "FormSigOpDmp.BtnBuscarClick")
            ELSE
                *-- NewReg(1) do legado: a ficha passa a exibir um registro em
                *-- branco. Aqui o equivalente e LimparDados no BO (que zera
                *-- inclusive a cidchaves do registro anterior - regra #22) e
                *-- LimparCampos na tela.
                THIS.this_oBusinessObject.LimparDados()
                THIS.this_oBusinessObject.CancelarEdicao()

                THIS.LimparCampos()
                THIS.LimparFases()

                THIS.this_cModoAtual = "PROCURAR"
                THIS.AlternarPagina(2)

                THIS.VincularGradeFases()
                THIS.RepintarGradeFases()

                THIS.FocarAposAbrirFicha()

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao iniciar a busca:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.BtnBuscarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Pagina.Dados.Grupo_Salva.Salva.Click (o Confirmar)
    *
    * Despachante por modo, como o Do Case do frmcadastro. Cada ramo esta no
    * seu proprio metodo porque os tres fazem coisas sem nada em comum:
    * gravar, excluir e posicionar a lista.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3) e o harness de teste
    * chama este metodo de fora.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DO CASE
                CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    loc_lResultado = THIS.GravarFicha()

                CASE THIS.this_cModoAtual == "EXCLUIR"
                    loc_lResultado = THIS.ExcluirFicha()

                CASE THIS.this_cModoAtual == "PROCURAR"
                    loc_lResultado = THIS.ExecutarBuscaPorNome()

                CASE THIS.this_cModoAtual == "VISUALIZAR"
                    *-- Legado: mSv_Consultar, que no frmcadastro nao grava
                    *-- nada - e o Confirmar esta DESABILITADO neste modo
                    *-- (Salva.Enabled = Not pcEscolha = [CONSULTAR]), logo
                    *-- o clique nao chega aqui. O ramo existe porque o
                    *-- handler tambem e chamado de fora (harness de teste),
                    *-- e a unica coisa coerente a fazer e fechar a ficha.
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.

                OTHERWISE
                    MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o em " + ;
                        "andamento para confirmar.", "FormSigOpDmp")
            ENDCASE

        CATCH TO loException
            MostrarErro("Erro ao confirmar:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.BtnSalvarClick")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GravarFicha - ramos INSERIR e ALTERAR do Confirmar
    *
    * ORDEM: fases (SigCdDpr) ANTES do mestre (SigPrDmo), como no legado - o
    * Salva.Click do SCX faz "poDataMgr.Update('crSigCdDpr')" e so depois
    * chama o DoDefault() que dispara mSv_Inserir/mSv_Alterar. As duas tabelas
    * nao tem FK entre si, logo a ordem nao muda o resultado no banco; o que
    * ela muda e o estado do BO quando algo falha. Com o mestre primeiro, uma
    * falha nas fases deixaria o BO com this_lNovoRegistro = .F. (o Salvar
    * limpa os flags no sucesso) e a retentativa viraria um UPDATE de um
    * registro que o rollback apagou - UPDATE que afeta 0 linhas devolve
    * sucesso e perderia o cadastro EM SILENCIO. Na ordem do legado o BO so
    * muda de estado depois que tudo deu certo.
    *
    * A validacao do Nome fica FORA do TRY. Ela e a mesma do GetNome.Valid
    * legado ("O Nome deve ser informado..."), que la retem o foco com
    * "Return 0" e por isso impede o usuario de chegar ao Confirmar sem nome;
    * aqui o LostFocus nao pode reter o foco (ver ValidarNomeLostFocus) e este
    * e o ponto onde a gravacao e efetivamente recusada.
    *===========================================================================
    PROTECTED PROCEDURE GravarFicha()
        LOCAL loc_lResultado, loc_lProsseguir, loc_oPg2, loc_cNome, loc_oBO
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Nome.Value)

        IF EMPTY(loc_cNome)
            MsgAviso("O Nome deve ser informado...", "FormSigOpDmp")

            IF loc_oPg2.txt_4c_Nome.Enabled AND loc_oPg2.txt_4c_Nome.Visible ;
               AND !loc_oPg2.txt_4c_Nome.ReadOnly
                loc_oPg2.txt_4c_Nome.SetFocus()
            ENDIF

            RETURN .F.
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF !THIS.FormParaBO()
                loc_lProsseguir = .F.
            ENDIF

            *-- Fases primeiro (poDataMgr.Update('crSigCdDpr') do legado).
            IF loc_lProsseguir
                IF !loc_oBO.GravarFases("cursor_4c_Fases", loc_cNome)
                    IF !loc_oBO.this_lErroExibido
                        MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
                            "Favor Reinicializar o Processo!!!", ;
                            ALLTRIM(loc_oBO.ObterMensagemErro())), ;
                            "Falha ao gravar as fases")
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            *-- Mestre depois (mSv_Inserir / mSv_Alterar do frmcadastro).
            *-- O BusinessBase.Salvar() escolhe INSERT ou UPDATE pelo
            *-- this_lNovoRegistro e JA reporta toda falha (regra #20): o
            *-- ELSE abaixo so cobre o caso de ele recusar sem exibir.
            IF loc_lProsseguir
                IF !loc_oBO.Salvar()
                    IF !loc_oBO.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel gravar o demonstrativo.", "Confirmar")
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF THIS.ConfirmarTransacao()
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF loc_lResultado
                MsgInfo("Registro salvo com sucesso!", "Confirmar")

                *-- mAtivapagina1: recarrega a grade da Lista, repoe o modo
                *-- LISTA e reabilita os 5 botoes CRUD (regra #40).
                THIS.AlternarPagina(1)
            ELSE
                *-- Nada foi efetivado. O BO continua em edicao (o Salvar so
                *-- limpa os flags no sucesso), logo o usuario pode corrigir e
                *-- confirmar de novo sem perder o que digitou.
                THIS.DesfazerTransacao()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao gravar o demonstrativo:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.GravarFicha")
            THIS.DesfazerTransacao()
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ExcluirFicha - ramo EXCLUIR do Confirmar
    *
    * Legado: a pergunta vive no frmcadastro.Salva.Click
    *   Case (.pcEscolha = [EXCLUIR])
    *       If (MessageBox([Deseja Realmente Excluir Esses Dados?],
    *                      4+32+256, [Confirmacao de Exclusao]) = 6)
    *           .mSv_Excluir()
    *       Else
    *           .plCancelar = .t.
    *       EndIf
    * e o ExcluiItens (DELETE das fases) no Salva.Click do SCX.
    *
    * DIVERGENCIA DELIBERADA NA ORDEM - a pergunta vem PRIMEIRO.
    * No legado o Salva.Click do SCX executa o ExcluiItens (que tem
    * SqlExecute + Commit PROPRIOS) ANTES de chamar o DoDefault() que
    * pergunta: responder "Nao" ja chegava com as fases apagadas e
    * COMMITADAS, e o RollBack do mAtivapagina1 nao as trazia de volta. E
    * perda de dados silenciosa no caminho de CANCELAMENTO - reproduzi-la
    * seria migrar um defeito destrutivo. Aqui nada e tocado antes do "Sim",
    * e o DELETE das fases e o do mestre ficam sob o MESMO commit.
    *
    * MsgConfirma devolve LOGICO (.T./.F.), nunca 6 (regra #7).
    *===========================================================================
    PROTECTED PROCEDURE ExcluirFicha()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNome, loc_oBO
        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)

        IF EMPTY(loc_cNome)
            MsgAviso("A ficha n" + CHR(227) + "o tem nome de demonstrativo " + ;
                "para excluir.", "FormSigOpDmp")
            RETURN .F.
        ENDIF

        IF !MsgConfirma("Deseja Realmente Excluir Esses Dados?", ;
                "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
            *-- plCancelar = .T. no legado, e o Salva.Click do SCX segue para o
            *-- mAtivapagina1: a ficha fecha e a Lista volta como estava.
            THIS.AlternarPagina(1)
            RETURN .F.
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- ExcluiItens do legado: apaga as fases do nome.
            IF !loc_oBO.ExcluirFases(loc_cNome)
                IF !loc_oBO.this_lErroExibido
                    MsgErro(IIF(EMPTY(ALLTRIM(loc_oBO.ObterMensagemErro())), ;
                        "Favor Reinicializar o Processo!!!", ;
                        ALLTRIM(loc_oBO.ObterMensagemErro())), ;
                        "Falha ao excluir as fases")
                ENDIF
                loc_lProsseguir = .F.
            ENDIF

            *-- mSv_Excluir: DELETE do mestre. O Excluir() do BusinessBase e
            *-- PUBLIC e chama o ExecutarExclusao do BO (regra #51); ele ja
            *-- reporta toda falha (regra #20).
            IF loc_lProsseguir
                IF !loc_oBO.Excluir()
                    IF !loc_oBO.this_lErroExibido
                        MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                            "vel excluir o demonstrativo.", "Confirmar")
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF THIS.ConfirmarTransacao()
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF loc_lResultado
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                    "Confirmar")
                THIS.AlternarPagina(1)
            ELSE
                THIS.DesfazerTransacao()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir o demonstrativo:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.ExcluirFicha")
            THIS.DesfazerTransacao()
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ExecutarBuscaPorNome - PROCEDURE msv_procurar do legado
    *
    *   Set Near On
    *   Select crSigPrDmo
    *   Index On nome tag ix_Nome
    *   Set Order To ix_nome
    *   Seek ThisForm.pagina.dados.getNome.Value
    *   Set Near Off
    *
    * SET NEAR ON e o que faz desta uma busca APROXIMADA: sem casamento
    * exato o ponteiro para no registro mais proximo em vez de ir para EOF.
    * Repor o SET anterior em vez de forcar OFF (o legado forca) porque
    * SET NEAR e de sessao e esta tela nao tem data session privada - deixar
    * o ambiente como estava e o que nao quebra quem chamou.
    *
    * ORDEM INVERTIDA EM RELACAO AO LEGADO, por necessidade: a volta para a
    * pagina Lista vem ANTES do Seek. AlternarPagina(1) chama CarregarLista,
    * que refaz o SELECT e RECRIA o cursor_4c_Dados - posicionar antes seria
    * jogado fora na troca de pagina. No legado o mAtivapagina1 tambem faz
    * ReQuery depois do msv_procurar, com o mesmo efeito de descartar a
    * posicao; a ordem daqui e a unica em que o Procurar realmente posiciona
    * a grade, que e o que o usuario pediu ao clicar no botao.
    *===========================================================================
    PROTECTED PROCEDURE ExecutarBuscaPorNome()
        LOCAL loc_lResultado, loc_cNome, loc_oGrid, loc_nAliasAnt, loc_cNearAnt
        loc_lResultado = .F.

        TRY
            loc_cNome = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Nome.Value)

            THIS.AlternarPagina(1)

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF EMPTY(loc_cNome)
                *-- Procurar sem nome nenhum: o Seek do legado com a string em
                *-- branco para no primeiro registro, que e onde a Lista
                *-- recem-recarregada ja esta. Nada a fazer.
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                    loc_nAliasAnt = SELECT(0)
                    SELECT cursor_4c_Dados

                    *-- O Buscar do BO ja devolve ORDER BY nome, logo a ordem
                    *-- visual da grade nao muda com este indice - ele existe
                    *-- so para o SEEK, que exige tag ativa.
                    INDEX ON nome TAG ix_nome
                    SET ORDER TO ix_nome IN cursor_4c_Dados

                    loc_cNearAnt = SET("NEAR")
                    SET NEAR ON

                    SEEK loc_cNome IN cursor_4c_Dados

                    IF loc_cNearAnt == "ON"
                        SET NEAR ON
                    ELSE
                        SET NEAR OFF
                    ENDIF

                    *-- Nome posterior ao ultimo do indice: o NEAR deixa o
                    *-- ponteiro em EOF e a grade apareceria sem linha
                    *-- selecionada. O registro mais proximo, nesse caso, e o
                    *-- ultimo.
                    IF EOF("cursor_4c_Dados")
                        GO BOTTOM IN cursor_4c_Dados
                    ENDIF

                    SELECT (loc_nAliasAnt)

                    *-- Mover o ponteiro NAO repinta a grade (regra #21).
                    loc_oGrid.Refresh()

                    IF loc_oGrid.Enabled AND loc_oGrid.Visible
                        loc_oGrid.SetFocus()
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Nenhum demonstrativo cadastrado.", "FormSigOpDmp")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao procurar o demonstrativo:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSigOpDmp.ExecutarBuscaPorNome")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Libera o Business Object e os cursores do formulario
    * O fechamento passa pelo FecharCursorBusca, que tem o guard de Buffering
    * obrigatorio (regra #52): TABLEREVERT em cursor com Buffering = 1 dispara
    * o erro 1586, e USE IN fecha o alias mesmo com buffer sujo.
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        THIS.FecharCursorBusca("cursor_4c_Dados")
        THIS.FecharCursorBusca("cursor_4c_Fases")

        *-- Cursores dos sete lookups: cada funil ja fecha o seu no caminho
        *-- normal, mas um CATCH no meio pode deixar algum aberto.
        THIS.FecharCursorBusca("cursor_4c_BuscaGcr")
        THIS.FecharCursorBusca("cursor_4c_BuscaGcrD")
        THIS.FecharCursorBusca("cursor_4c_BuscaCli")
        THIS.FecharCursorBusca("cursor_4c_BuscaCliD")
        THIS.FecharCursorBusca("cursor_4c_BuscaFase")
        THIS.FecharCursorBusca("cursor_4c_BuscaFunc")
        THIS.FecharCursorBusca("cursor_4c_BuscaTpOp")

        DODEFAULT()
    ENDPROC

ENDDEFINE
