*==============================================================================
* Formsigmvcab.prg - Formulario de Movimentacao (Cabecalho)
* Migrado de: SIGMVCAB.SCX (frmcadastro)
*
* FASE 3/8: Form - Estrutura Base (PageFrame, cabecalhos nas duas paginas)
* FASE 4/8: Form - Grid e Botoes CRUD (Page1)
* - grd_4c_Lista (Emps/Dopes/Numes/Datas/ContaOs/ContaDs/Valos) ligado a
*   cursor_4c_Dados (sigmvcabBO.Buscar, TOP 300 ORDER BY Datas DESC)
* - cnt_4c_Botoes: Incluir/Visualizar/Alterar/Excluir/Buscar
* - cnt_4c_Saida: Encerrar (padrao canonico, regra #10)
* - CarregarLista()/AlternarPagina()/TornarControlesVisiveis()/FormatarGridLista()
* FASE 5/8: Form - Campos principais da Page2 (parte 1/2 - identificacao)
* - txt_4c_Emps/Dopes/Numes (linha 1), txt_4c_Datas (linha 2)
* - txt_4c_GrupoOs/ContaOs (linha 3), txt_4c_GrupoDs/ContaDs (linha 4)
* - txt_4c_Vends (linha 5)
* - Layout simplificado direto na Page2 (sem reproduzir o PageFrame interno
*   pgfPrincipal/pgContas do legado); abas Operacional/Informacoes completas
*   ficam fora do escopo desta migracao simplificada.
* FASE 6/8: Form - Campos restantes (parte 2) e lookups completos
* - txt_4c_Tabds/Lprecos (linha 6), txt_4c_Jobs/Fpubls (linha 7),
*   txt_4c_Valos (linha 8), txt_4c_Obses memo (linha 9)
* - cnt_4c_BotoesAcao: cmd_4c_Confirmar/cmd_4c_Cancelar + BtnSalvarClick/
*   BtnCancelarClick
* - FormParaBO()/BOParaForm()/LimparCampos()/HabilitarCampos() ligados aos
*   fluxos de Incluir/Alterar/Visualizar/Salvar
* - Lookups (F4/DblClick) completos para GrupoOs/ContaOs/GrupoDs/ContaDs/
*   Vends via AbrirBuscaGrupoConta() (Grupo=SigCdGcr Codigos/Descrs,
*   Conta/Vendedor=SigCdCli Iclis/Rclis)
* FASE 7/8: Form - BtnBuscarClick (FormBuscaAuxiliar por EmpDopNums +
*   LocalizarNaLista), BtnEncerrarClick, Destroy() liberando cursores
* FASE 8/8: Form - Consolidacao final: AjustarBotoesPorModo() (Confirmar
*   desabilitado + Cancelar vira "Voltar" em VISUALIZAR), chamado junto com
*   HabilitarCampos() em BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick.
*   Integracao com config.prg (ADIR dinamico, ja cobre classes\*BO.prg e
*   forms\cadastros\Form*.prg) e menu.prg (AbrirFormsigmvcab + popMovimentos
*   Bar 1) conferida e correta.
*==============================================================================

DEFINE CLASS Formsigmvcab AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1050
    Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
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

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigmvcabBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar sigmvcabBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigmvcab.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                *-- Regra #11 (CLAUDE.md): faixa do cabecalho nas DUAS paginas
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar Formsigmvcab:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvcab.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
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

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
    * Colunas do grid: Emps, Dopes, Numes, Datas, ContaOs, ContaDs, Valos
    * (cursor_4c_Dados do sigmvcabBO.Buscar; cidchaves vem junto, oculto)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op no legado) - canonico
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

        *-- Botao Incluir (Left=5)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=80)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=305)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
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

        *-- Grid de listagem de movimentos
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (RecordSource dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 7
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Estrutura base da Page2 (Dados)
    * Campos e botoes de acao (Confirmar/Cancelar) sao adicionados nas proximas fases
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho - PRIMEIRO AddObject da pagina (regra #11: faixa nas DUAS paginas)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 15
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes de Acao (Grupo_salva no legado) - canonico
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar/Salvar (Left=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Left=80)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- FASE 5/8: Campos principais (parte 1) - identificacao do movimento
        *-- Legado: getCodigo/getEmpD/getDatas (pgOperacional) + Origem/Destino
        *-- (pgContas.Origem/Destino Get_grupo/Get_conta). Layout simplificado:
        *-- campos direto na Page2, sem reproduzir o PageFrame interno pgfPrincipal
        *-- (escopo desta fase e a identificacao do movimento; abas Operacional/
        *-- Informacoes/Contas completas ficam para fases seguintes).

        *-- Linha 1: Empresa / Operacao / Numero
        loc_oPagina.AddObject("lbl_4c_Emps", "Label")
        WITH loc_oPagina.lbl_4c_Emps
            .Caption   = "Emp :"
            .Left      = 30
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH loc_oPagina.txt_4c_Emps
            .Left          = 65
            .Top           = 118
            .Width         = 45
            .Height        = 21
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Dopes", "Label")
        WITH loc_oPagina.lbl_4c_Dopes
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
            .Left      = 130
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Dopes", "TextBox")
        WITH loc_oPagina.txt_4c_Dopes
            .Left          = 185
            .Top           = 118
            .Width         = 200
            .Height        = 21
            .MaxLength     = 20
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Numes", "Label")
        WITH loc_oPagina.lbl_4c_Numes
            .Caption   = "N" + CHR(250) + "mero :"
            .Left      = 400
            .Top       = 120
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oPagina.txt_4c_Numes
            .Left          = 450
            .Top           = 118
            .Width         = 90
            .Height        = 21
            .InputMask     = "999999"
            .ReadOnly      = .T.
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Data
        loc_oPagina.AddObject("lbl_4c_Datas", "Label")
        WITH loc_oPagina.lbl_4c_Datas
            .Caption   = "Data :"
            .Left      = 30
            .Top       = 155
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
        WITH loc_oPagina.txt_4c_Datas
            .Left          = 65
            .Top           = 153
            .Width         = 100
            .Height        = 21
            .Format        = "K"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Grupo/Conta Origem
        loc_oPagina.AddObject("lbl_4c_GrupoOs", "Label")
        WITH loc_oPagina.lbl_4c_GrupoOs
            .Caption   = "Grupo Origem :"
            .Left      = 30
            .Top       = 190
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoOs
            .Left          = 130
            .Top           = 188
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ContaOs", "Label")
        WITH loc_oPagina.lbl_4c_ContaOs
            .Caption   = "Conta Origem :"
            .Left      = 230
            .Top       = 190
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPagina.txt_4c_ContaOs
            .Left          = 330
            .Top           = 188
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 4: Grupo/Conta Destino
        loc_oPagina.AddObject("lbl_4c_GrupoDs", "Label")
        WITH loc_oPagina.lbl_4c_GrupoDs
            .Caption   = "Grupo Destino :"
            .Left      = 30
            .Top       = 225
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoDs
            .Left          = 130
            .Top           = 223
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ContaDs", "Label")
        WITH loc_oPagina.lbl_4c_ContaDs
            .Caption   = "Conta Destino :"
            .Left      = 230
            .Top       = 225
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_ContaDs", "TextBox")
        WITH loc_oPagina.txt_4c_ContaDs
            .Left          = 330
            .Top           = 223
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 5: Vendedor
        loc_oPagina.AddObject("lbl_4c_Vends", "Label")
        WITH loc_oPagina.lbl_4c_Vends
            .Caption   = "Vendedor :"
            .Left      = 30
            .Top       = 260
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Vends", "TextBox")
        WITH loc_oPagina.txt_4c_Vends
            .Left          = 130
            .Top           = 258
            .Width         = 120
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Lookups (F4/DblClick) dos campos de Grupo/Conta/Vendedor da parte 1
        BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "KeyPress", THIS, "GrupoOsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GrupoOs, "DblClick", THIS, "GrupoOsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_ContaOs, "KeyPress", THIS, "ContaOsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ContaOs, "DblClick", THIS, "ContaOsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_GrupoDs, "KeyPress", THIS, "GrupoDsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_GrupoDs, "DblClick", THIS, "GrupoDsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_ContaDs, "KeyPress", THIS, "ContaDsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_ContaDs, "DblClick", THIS, "ContaDsLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Vends, "KeyPress", THIS, "VendsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Vends, "DblClick", THIS, "VendsLookupDblClick")

        *-- FASE 6/8: Campos restantes (parte 2) - tabela de desconto, job,
        *-- publicidade, lista de precos, valor e observacao

        *-- Linha 6: Tabela de Desconto / Lista de Precos
        loc_oPagina.AddObject("lbl_4c_Tabds", "Label")
        WITH loc_oPagina.lbl_4c_Tabds
            .Caption   = "Tabela Desc. :"
            .Left      = 30
            .Top       = 295
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Tabds", "TextBox")
        WITH loc_oPagina.txt_4c_Tabds
            .Left          = 130
            .Top           = 293
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Lprecos", "Label")
        WITH loc_oPagina.lbl_4c_Lprecos
            .Caption   = "Lista Pre" + CHR(231) + CHR(111) + "s :"
            .Left      = 230
            .Top       = 295
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Lprecos", "TextBox")
        WITH loc_oPagina.txt_4c_Lprecos
            .Left          = 330
            .Top           = 293
            .Width         = 120
            .Height        = 21
            .MaxLength     = 30
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 7: Job / Forma de Publicidade
        loc_oPagina.AddObject("lbl_4c_Jobs", "Label")
        WITH loc_oPagina.lbl_4c_Jobs
            .Caption   = "Job :"
            .Left      = 30
            .Top       = 330
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Jobs", "TextBox")
        WITH loc_oPagina.txt_4c_Jobs
            .Left          = 130
            .Top           = 328
            .Width         = 80
            .Height        = 21
            .MaxLength     = 10
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Fpubls", "Label")
        WITH loc_oPagina.lbl_4c_Fpubls
            .Caption   = "F. Publicidade :"
            .Left      = 230
            .Top       = 330
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Fpubls", "TextBox")
        WITH loc_oPagina.txt_4c_Fpubls
            .Left          = 330
            .Top           = 328
            .Width         = 60
            .Height        = 21
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 8: Valor
        loc_oPagina.AddObject("lbl_4c_Valos", "Label")
        WITH loc_oPagina.lbl_4c_Valos
            .Caption   = "Valor :"
            .Left      = 30
            .Top       = 365
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Valos", "TextBox")
        WITH loc_oPagina.txt_4c_Valos
            .Left          = 130
            .Top           = 363
            .Width         = 120
            .Height        = 21
            .InputMask     = "999,999,999.99"
            .Alignment     = 1
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Linha 9: Observacao (memo)
        loc_oPagina.AddObject("lbl_4c_Obses", "Label")
        WITH loc_oPagina.lbl_4c_Obses
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Left      = 30
            .Top       = 400
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        loc_oPagina.AddObject("txt_4c_Obses", "EditBox")
        WITH loc_oPagina.txt_4c_Obses
            .Left          = 130
            .Top           = 398
            .Width         = 500
            .Height        = 60
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * par_cFiltro (opcional): WHERE extra somado ao TOP 300 padrao do BO
    * (usado por LocalizarNaLista para trazer um registro fora da janela).
    * OBRIGATORIO: RecordSource FORA do WITH; ControlSource/Headers APOS
    * RecordSource (RecordSource reseta ControlSource/Header via auto-bind).
    *===========================================================================
    PROCEDURE CarregarLista(par_cFiltro)
        LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
        loc_lResultado = .F.
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")

        TRY
            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                loc_oGrid.ColumnCount = 7
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Emps"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Dopes"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Numes"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Datas"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.ContaOs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.ContaDs"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.Valos"

                loc_oGrid.Column1.Width = 55
                loc_oGrid.Column2.Width = 150
                loc_oGrid.Column3.Width = 70
                loc_oGrid.Column4.Width = 90
                loc_oGrid.Column5.Width = 165
                loc_oGrid.Column6.Width = 165
                loc_oGrid.Column7.Width = 130

                *-- Headers APOS RecordSource (RecordSource reseta os captions)
                loc_oGrid.Column1.Header1.Caption = "Emp"
                loc_oGrid.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column4.Header1.Caption = "Data"
                loc_oGrid.Column5.Header1.Caption = "Origem"
                loc_oGrid.Column6.Header1.Caption = "Destino"
                loc_oGrid.Column7.Header1.Caption = "Valor"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formsigmvcab.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "Formsigmvcab.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "Formsigmvcab.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

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
    * ObterChaveSelecionada - Le a cidchaves (PK) do registro selecionado no Grid
    *===========================================================================
    PROTECTED PROCEDURE ObterChaveSelecionada()
        LOCAL loc_cChave
        loc_cChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    * LocalizarNaLista - Posiciona o Grid no registro par_cChave (cidchaves)
    * Se estiver fora da janela padrao (TOP 300), recarrega filtrando por ele
    *===========================================================================
    PROTECTED PROCEDURE LocalizarNaLista(par_cChave)
        LOCAL loc_lAchou
        loc_lAchou = .F.

        IF USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(cidchaves) == par_cChave
            loc_lAchou = FOUND()
        ENDIF

        IF loc_lAchou
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ELSE
            THIS.CarregarLista("cidchaves = " + EscaparSQL(par_cChave))
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara o BO para incluir novo registro e abre Page2
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar o registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o registro selecionado, com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_cDescricao
        loc_cChave = THIS.ObterChaveSelecionada()

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            loc_cDescricao = ""
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cDescricao = ALLTRIM(cursor_4c_Dados.Emps) + " " + ALLTRIM(cursor_4c_Dados.Dopes) + ;
                    " " + ALLTRIM(TRANSFORM(cursor_4c_Dados.Numes))
            ENDIF

            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do movimento [" + loc_cDescricao + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza um movimento pela chave EmpDopNums (Emp+Doc+Num)
    * e posiciona o Grid nele
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cChave
        loc_cChave = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigMvCab", "cursor_4c_BuscaMov", "EmpDopNums", "", ;
                "Buscar Movimenta" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Emps",  "", "Emp")
                loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Numes", "", "N" + CHR(250) + "mero")
                loc_oBusca.mAddColuna("Datas", "", "Data")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMov")
                    SELECT cursor_4c_BuscaMov
                    loc_cChave = ALLTRIM(cursor_4c_BuscaMov.cidchaves)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaMov")
                USE IN cursor_4c_BuscaMov
            ENDIF

            IF !EMPTY(loc_cChave)
                THIS.LocalizarNaLista(loc_cChave)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formsigmvcab.BtnBuscarClick")
            IF USED("cursor_4c_BuscaMov")
                USE IN cursor_4c_BuscaMov
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Transfere Form->BO e grava (Inserir/Atualizar conforme
    * this_lNovoRegistro, controlado pelo BusinessBase). PUBLIC: BINDEVENT.
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!", "Confirmar")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta alteracoes e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere os valores dos campos da Page2 para o BO
    * Chamado por BtnSalvarClick antes de THIS.this_oBusinessObject.Salvar()
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oBO.this_cEmps      = ALLTRIM(loc_oPg.txt_4c_Emps.Value)
        loc_oBO.this_cDopes     = ALLTRIM(loc_oPg.txt_4c_Dopes.Value)
        loc_oBO.this_nNumes     = TRANSFORM(loc_oPg.txt_4c_Numes.Value)
        loc_oBO.this_dDatas     = loc_oPg.txt_4c_Datas.Value
        loc_oBO.this_cGrupoos   = ALLTRIM(loc_oPg.txt_4c_GrupoOs.Value)
        loc_oBO.this_cContaos   = ALLTRIM(loc_oPg.txt_4c_ContaOs.Value)
        loc_oBO.this_cGrupods   = ALLTRIM(loc_oPg.txt_4c_GrupoDs.Value)
        loc_oBO.this_cContads   = ALLTRIM(loc_oPg.txt_4c_ContaDs.Value)
        loc_oBO.this_cVends     = ALLTRIM(loc_oPg.txt_4c_Vends.Value)
        loc_oBO.this_cTabds     = ALLTRIM(loc_oPg.txt_4c_Tabds.Value)
        loc_oBO.this_cLprecos   = ALLTRIM(loc_oPg.txt_4c_Lprecos.Value)
        loc_oBO.this_cJobs      = ALLTRIM(loc_oPg.txt_4c_Jobs.Value)
        loc_oBO.this_cFpubls    = ALLTRIM(loc_oPg.txt_4c_Fpubls.Value)
        loc_oBO.this_nValos     = loc_oPg.txt_4c_Valos.Value
        loc_oBO.this_cObses     = ALLTRIM(loc_oPg.txt_4c_Obses.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere os valores do BO para os campos da Page2
    * Chamado por BtnVisualizarClick/BtnAlterarClick apos CarregarPorCodigo()
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oBO
        loc_oPg = THIS.pgf_4c_Paginas.Page2
        loc_oBO = THIS.this_oBusinessObject

        loc_oPg.txt_4c_Emps.Value     = loc_oBO.this_cEmps
        loc_oPg.txt_4c_Dopes.Value    = loc_oBO.this_cDopes
        loc_oPg.txt_4c_Numes.Value    = loc_oBO.this_nNumes
        loc_oPg.txt_4c_Datas.Value    = ConverterParaData(loc_oBO.this_dDatas)
        loc_oPg.txt_4c_GrupoOs.Value  = loc_oBO.this_cGrupoos
        loc_oPg.txt_4c_ContaOs.Value  = loc_oBO.this_cContaos
        loc_oPg.txt_4c_GrupoDs.Value  = loc_oBO.this_cGrupods
        loc_oPg.txt_4c_ContaDs.Value  = loc_oBO.this_cContads
        loc_oPg.txt_4c_Vends.Value    = loc_oBO.this_cVends
        loc_oPg.txt_4c_Tabds.Value    = loc_oBO.this_cTabds
        loc_oPg.txt_4c_Lprecos.Value  = loc_oBO.this_cLprecos
        loc_oPg.txt_4c_Jobs.Value     = loc_oBO.this_cJobs
        loc_oPg.txt_4c_Fpubls.Value   = loc_oBO.this_cFpubls
        loc_oPg.txt_4c_Valos.Value    = loc_oBO.this_nValos
        loc_oPg.txt_4c_Obses.Value    = loc_oBO.this_cObses
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos da Page2 (usado em Incluir)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Emps.Value     = ""
        loc_oPg.txt_4c_Dopes.Value    = ""
        loc_oPg.txt_4c_Numes.Value    = 0
        loc_oPg.txt_4c_Datas.Value    = {}
        loc_oPg.txt_4c_GrupoOs.Value  = ""
        loc_oPg.txt_4c_ContaOs.Value  = ""
        loc_oPg.txt_4c_GrupoDs.Value  = ""
        loc_oPg.txt_4c_ContaDs.Value  = ""
        loc_oPg.txt_4c_Vends.Value    = ""
        loc_oPg.txt_4c_Tabds.Value    = ""
        loc_oPg.txt_4c_Lprecos.Value  = ""
        loc_oPg.txt_4c_Jobs.Value     = ""
        loc_oPg.txt_4c_Fpubls.Value   = ""
        loc_oPg.txt_4c_Valos.Value    = 0
        loc_oPg.txt_4c_Obses.Value    = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos editaveis da Page2
    * par_lHabilitar = .T. (Incluir/Alterar) ou .F. (Visualizar)
    * Emps/Dopes/Numes sao sempre ReadOnly (chave de negocio, nao editavel)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2

        loc_oPg.txt_4c_Datas.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_GrupoOs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_ContaOs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_GrupoDs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_ContaDs.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Vends.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Tabds.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Lprecos.Enabled  = par_lHabilitar
        loc_oPg.txt_4c_Jobs.Enabled     = par_lHabilitar
        loc_oPg.txt_4c_Fpubls.Enabled   = par_lHabilitar
        loc_oPg.txt_4c_Valos.Enabled    = par_lHabilitar
        loc_oPg.txt_4c_Obses.Enabled    = par_lHabilitar

        loc_oPg.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao da Page2
    * (cnt_4c_BotoesAcao) conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR).
    * Chamado junto com HabilitarCampos() apos this_cModoAtual ser definido.
    * Confirmar fica desabilitado em VISUALIZAR (regra #20 CLAUDE.md: falha de
    * gravacao/modo somente-leitura nunca deixa o botao de gravar acionavel);
    * Cancelar vira "Voltar" nesse modo, pois nao ha alteracao a descartar.
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes
        loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"

            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"

            OTHERWISE
                loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
                loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
        ENDCASE
    ENDPROC

    *===========================================================================
    * Lookups (F4/DblClick) - Grupo/Conta Origem, Grupo/Conta Destino, Vendedor
    * Grupo  -> SigCdGcr (Grupos de Conta Corrente): Codigos/Descrs
    * Conta / Vendedor -> SigCdCli (Contas/Clientes): Iclis/Rclis
    * PUBLIC: metodos de evento chamados via BINDEVENT devem ser publicos
    *===========================================================================
    PROCEDURE GrupoOsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoOs()
        ENDIF
    ENDPROC

    PROCEDURE GrupoOsLookupDblClick()
        THIS.AbrirLookupGrupoOs()
    ENDPROC

    PROCEDURE AbrirLookupGrupoOs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdGcr", "Codigos", "Descrs", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoOs.Value, "Buscar Grupo Origem")
        ENDIF
    ENDPROC

    PROCEDURE ContaOsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaOs()
        ENDIF
    ENDPROC

    PROCEDURE ContaOsLookupDblClick()
        THIS.AbrirLookupContaOs()
    ENDPROC

    PROCEDURE AbrirLookupContaOs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_ContaOs.Value, "Buscar Conta Origem")
        ENDIF
    ENDPROC

    PROCEDURE GrupoDsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupGrupoDs()
        ENDIF
    ENDPROC

    PROCEDURE GrupoDsLookupDblClick()
        THIS.AbrirLookupGrupoDs()
    ENDPROC

    PROCEDURE AbrirLookupGrupoDs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdGcr", "Codigos", "Descrs", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoDs.Value, "Buscar Grupo Destino")
        ENDIF
    ENDPROC

    PROCEDURE ContaDsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupContaDs()
        ENDIF
    ENDPROC

    PROCEDURE ContaDsLookupDblClick()
        THIS.AbrirLookupContaDs()
    ENDPROC

    PROCEDURE AbrirLookupContaDs()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_ContaDs.Value, "Buscar Conta Destino")
        ENDIF
    ENDPROC

    PROCEDURE VendsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupVends()
        ENDIF
    ENDPROC

    PROCEDURE VendsLookupDblClick()
        THIS.AbrirLookupVends()
    ENDPROC

    PROCEDURE AbrirLookupVends()
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Enabled
            THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Value = ;
                THIS.AbrirBuscaGrupoConta("SigCdCli", "Iclis", "Rclis", ;
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Vends.Value, "Buscar Vendedor")
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaGrupoConta - Helper comum aos lookups de Grupo/Conta/Vendedor
    * (mesmo par tabela/campo-chave/campo-descricao, unica coisa que muda
    * entre eles e a tabela e o titulo do dialogo)
    *===========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupoConta(par_cTabela, par_cCampoChave, par_cCampoDesc, par_cValorAtual, par_cTitulo)
        LOCAL loc_oBusca, loc_cCursor, loc_cRetorno
        loc_cRetorno = ALLTRIM(par_cValorAtual)
        loc_cCursor  = "cursor_4c_BuscaGrpCta"

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                par_cTabela, loc_cCursor, par_cCampoChave, ALLTRIM(par_cValorAtual), par_cTitulo)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna(par_cCampoChave, "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna(par_cCampoDesc, "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_cRetorno = ALLTRIM(EVALUATE(loc_cCursor + "." + par_cCampoChave))
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar " + par_cTitulo + ":" + CHR(13) + loException.Message, ;
                "Formsigmvcab.AbrirBuscaGrupoConta")
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaMov")
            USE IN cursor_4c_BuscaMov
        ENDIF

        IF USED("cursor_4c_BuscaGrpCta")
            USE IN cursor_4c_BuscaGrpCta
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
