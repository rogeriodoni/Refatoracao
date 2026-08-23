# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormOPE.prg] Procedure vazia (sem codigo): OptBlqdtChange
[FormOPE.prg] Procedure vazia (sem codigo): OptTipoChange
[FormOPE.prg] Procedure vazia (sem codigo): OptTipoNFChange
[FormOPE.prg] Procedure vazia (sem codigo): OptVendeChange

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[22/08/2026 06:00:46 AM] Erro em HabilitarCampos: Property CONTROLCOUNT is not found.Linha: 1799
[22/08/2026 06:00:46 AM] Erro em LimparCampos: Property CONTROLCOUNT is not found.Linha: 1852
[22/08/2026 06:00:46 AM] Erro em HabilitarCampos: Property CONTROLCOUNT is not found.Linha: 1799


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormOPE",
  "timestamp": "20260822060046",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 9,
    "falhou": 0,
    "percentual": 100
  }
}



## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOPE.prg):
*==============================================================================
* FormOPE.prg - Formulario de Cadastro de Tipos de Operacao
* Migrado de: SIGCDOPE.SCX (frmcadastro)
* Fase A: Layout base com logica stub (sem controles de dados nas abas internas)
*==============================================================================

DEFINE CLASS FormOPE AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 650
    Width       = 1000
    Caption     = "Cadastro de Movimenta" + CHR(231) + CHR(245) + "es de Estoque"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    MaxButton   = .F.
    Closable    = .F.
    Themes      = .F.
    BorderStyle = 2
    ClipControls = .F.
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("OPEBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar OPEBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormOPE.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = THIS.Caption
                    .lbl_4c_Titulo.Caption = THIS.Caption
                    .Visible = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormOPE:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormOPE.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *==========================================================================
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

            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, filtro, botoes CRUD,
    *   grid cursor_4c_Dados, botoes de acao auxiliares
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (compensacao +29: Top=30)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 30
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Container Botoes CRUD (Left=542, Top=29, Width=385, Height=85)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 29
            .Left      = 542
            .Width     = 385
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Incluir
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

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Excluir
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

        *-- Botao Buscar
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

        *-- Container Saida (Encerrar) - PADRAO CANONICO (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Left      = 917
            .Top       = 29
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

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

        *-- Filtro optFilSituas (legado: optFilSituas Top=93, Left=11, Width=181, Height=25)
        *-- Compensacao +29: Top=122
        loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
        WITH loc_oPagina.opt_4c_FilSituas
            .Top         = 122
            .Left        = 11
            .Width       = 181
            .Height      = 25
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_FilSituas
            .Buttons(1).Caption = "Todos"
            .Buttons(1).Left    = 0
            .Buttons(1).Top     = 0
            .Buttons(1).Width   = 60
            .Buttons(1).Height  = 25
            .Buttons(1).Themes  = .F.
            .Buttons(2).Caption = "Ativos"
            .Buttons(2).Left    = 60
            .Buttons(2).Top     = 0
            .Buttons(2).Width   = 60
            .Buttons(2).Height  = 25
            .Buttons(2).Themes  = .F.
            .Buttons(3).Caption = "Inativos"
            .Buttons(3).Left    = 120
            .Buttons(3).Top     = 0
            .Buttons(3).Width   = 61
            .Buttons(3).Height  = 25
            .Buttons(3).Themes  = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "FiltroSituaClick")

        *-- Grid principal cursor_4c_Dados
        *-- Legado: Grade Top=127 (compensado +29 = 156), Left=5, Width=997, Height=441
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        WITH loc_oPagina.grd_4c_Dados
            .Top         = 156
            .Left        = 5
            .Width       = 992
            .Height      = 410
            .ColumnCount = 2
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 9
            .Visible     = .T.
            .Column1.Width     = 100
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 892
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GridAfterRowColChange")

        *-- Botoes de acao no topo (legado top=82, compensado +29 = 111)
        *-- btnExpXML (Exportar): left=519
        loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExpXML
            .Caption         = "Exportar"
            .Top             = 111
            .Left            = 519
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")

        *-- btnImpXML (Importar): left=639
        loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnImpXML
            .Caption         = "Importar"
            .Top             = 111
            .Left            = 639
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")

        *-- CmdCopia (Copiar): left=759
        loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copia
            .Caption         = "Copiar"
            .Top             = 111
            .Left            = 759
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Copia, "Click", THIS, "BtnCopiaClick")

        *-- btnMapa (Mapa): left=879
        loc_oPagina.AddObject("cmd_4c_Mapa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Mapa
            .Caption         = "Mapa"
            .Top             = 111
            .Left            = 879
            .Width           = 120
            .Height          = 40
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Mapa, "Click", THIS, "BtnMapaClick")

        *-- Botoes de acao inferiores (legado top=574, compensado +29 = 603)
        *-- Credito (Ger. Creditos): left=4
        loc_oPagina.AddObject("cmd_4c_Credito", "CommandButton")
        WITH loc_oPagina.cmd_4c_Credito
            .Caption     = "Ger. Cr" + CHR(233) + "ditos"
            .Top         = 603
            .Left        = 4
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Credito, "Click", THIS, "BtnCreditoClick")

        *-- Deprecia (Depreciacao): left=66
        loc_oPagina.AddObject("cmd_4c_Deprecia", "CommandButton")
        WITH loc_oPagina.cmd_4c_Deprecia
            .Caption     = "Deprecia" + CHR(231) + CHR(227) + "o"
            .Top         = 603
            .Left        = 66
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Deprecia, "Click", THIS, "BtnDepreciaClick")

        *-- cmdEtiquetas (Etiquetas): left=128
        loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Etiquetas
            .Caption     = "Etiquetas"
            .Top         = 603
            .Left        = 128
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")

        *-- Transporte (Transportes): left=190
        loc_oPagina.AddObject("cmd_4c_Transporte", "CommandButton")
        WITH loc_oPagina.cmd_4c_Transporte
            .Caption     = "Transportes"
            .Top         = 603
            .Left        = 190
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Transporte, "Click", THIS, "BtnTransporteClick")

        *-- Frete (Fretes): left=252
        loc_oPagina.AddObject("cmd_4c_Frete", "CommandButton")
        WITH loc_oPagina.cmd_4c_Frete
            .Caption     = "Fretes"
            .Top         = 603
            .Left        = 252
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Frete, "Click", THIS, "BtnFreteClick")

        *-- Caixa (Sequencia Cx): left=314
        loc_oPagina.AddObject("cmd_4c_Caixa", "CommandButton")
        WITH loc_oPagina.cmd_4c_Caixa
            .Caption     = "Sequ" + CHR(234) + "ncia Cx"
            .Top         = 603
            .Left        = 314
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Caixa, "Click", THIS, "BtnCaixaClick")

        *-- TabDesconto (Tabelas): left=438
        loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
        WITH loc_oPagina.cmd_4c_TabDesconto
            .Caption     = "Tabelas"
            .Top         = 603
            .Left        = 438
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")

        *-- MontaLista (Monta Grade): left=500
        loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
        WITH loc_oPagina.cmd_4c_MontaLista
            .Caption     = "Monta Grade"
            .Top         = 603
            .Left        = 500
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")

        *-- CmdTrf (Automaticas): left=562
        loc_oPagina.AddObject("cmd_4c_Trf", "CommandButton")
        WITH loc_oPagina.cmd_4c_Trf
            .Caption     = "Autom" + CHR(225) + "ticas"
            .Top         = 603
            .Left        = 562
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Trf, "Click", THIS, "BtnTrfClick")

        *-- cmdMultiSubN (Multiplos): left=624
        loc_oPagina.AddObject("cmd_4c_MultiSubN", "CommandButton")
        WITH loc_oPagina.cmd_4c_MultiSubN
            .Caption     = "M" + CHR(250) + "ltiplos"
            .Top         = 603
            .Left        = 624
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_MultiSubN, "Click", THIS, "BtnMultiSubNClick")

        *-- SubNivel2 (Subnivel +): left=686
        loc_oPagina.AddObject("cmd_4c_SubNivel2", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNivel2
            .Caption     = "Subn" + CHR(237) + "vel (+)"
            .Top         = 603
            .Left        = 686
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_SubNivel2, "Click", THIS, "BtnSubNivel2Click")

        *-- Multiplas (Subnivel -): left=748
        loc_oPagina.AddObject("cmd_4c_Multiplas", "CommandButton")
        WITH loc_oPagina.cmd_4c_Multiplas
            .Caption     = "Subn" + CHR(237) + "vel (-)"
            .Top         = 603
            .Left        = 748
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Multiplas, "Click", THIS, "BtnMultiplasClick")

        *-- Ccusto (C.C.): left=810
        loc_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
        WITH loc_oPagina.cmd_4c_Ccusto
            .Caption     = "C.C."
            .Top         = 603
            .Left        = 810
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")

        *-- GrupoConta (Grupo/Conta): left=872
        loc_oPagina.AddObject("cmd_4c_GrupoConta", "CommandButton")
        WITH loc_oPagina.cmd_4c_GrupoConta
            .Caption     = "Grupo/Conta"
            .Top         = 603
            .Left        = 872
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_GrupoConta, "Click", THIS, "BtnGrupoContaClick")

        *-- Status: left=934
        loc_oPagina.AddObject("cmd_4c_Status", "CommandButton")
        WITH loc_oPagina.cmd_4c_Status
            .Caption     = "Status"
            .Top         = 603
            .Left        = 934
            .Width       = 62
            .Height      = 59
            .FontName    = "Tahoma"
            .FontSize    = 7
            .FontBold    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .WordWrap    = .T.
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Status, "Click", THIS, "BtnStatusClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: cabecalho de identificacao,
    *   botoes Salvar/Cancelar, PageFrame interno PagDados com 18 abas stub
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (legado: Grupo_Salva Top=-2, Left=840; canonico Top=27)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top       = 27
            .Left      = 840
            .Width     = 160
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

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

        *-- Cabecalho de identificacao da operacao (acima do PagDados)
        *-- Legado: campos no topo da Page2 (top < 130) sem container explicito
        *-- Compensacao +29: tops originais + 29

        *-- Label "Codigo :" (Say1 legado: top=7)
        loc_oPagina.AddObject("lbl_4c_LCodigo", "Label")
        WITH loc_oPagina.lbl_4c_LCodigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 36
            .Left      = 30
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_desc legado: top=3, left=73, width=179, height=23)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 32
            .Left          = 73
            .Width         = 179
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 20
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Descricao :" (Say28 legado: top=32)
        loc_oPagina.AddObject("lbl_4c_LDescricao", "Label")
        WITH loc_oPagina.lbl_4c_LDescricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 61
            .Left      = 17
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get1 legado: top=28, left=73, width=179, height=23)
        *-- titopes char(30) -> MaxLength=30
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 57
            .Left          = 73
            .Width         = 250
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 30
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Menu :" (menus char(10))
        loc_oPagina.AddObject("lbl_4c_LMenu", "Label")
        WITH loc_oPagina.lbl_4c_LMenu
            .Caption   = "Menu :"
            .Top       = 86
            .Left      = 37
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ComboBox Menu (menus char(10))
        loc_oPagina.AddObject("cbo_4c_Menu", "ComboBox")
        WITH loc_oPagina.cbo_4c_Menu
            .Value         = ""
            .Top           = 82
            .Left          = 73
            .Width         = 150
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = ",SISTEMA,OPERACIONA,CAIXA"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Label "Tipo :" (Say4 legado: top=32, left=295)
        loc_oPagina.AddObject("lbl_4c_LTipo", "Label")
        WITH loc_oPagina.lbl_4c_LTipo
            .Caption   = "Tipo :"
            .Top       = 61
            .Left      = 295
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Tipo (cmbTOpers legado: top=28, left=325, width=227, height=23)
        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value         = ""
            .Top           = 57
            .Left          = 325
            .Width         = 100
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Nested PageFrame PagDados (legado: top=130, left=0, width=1002, height=677)
        *-- Compensacao +29: top=159
        loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_PagDados
            .Top       = 159
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29 - 159
            .PageCount = 18
            .Tabs      = .T.
            .Visible   = .T.
            *-- Captions das 18 abas (Fase A: stubs)
            .Page1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            .Page2.Caption  = "Itens"
            .Page3.Caption  = "Financeiro"
            .Page4.Caption  = "Fiscal"
            .Page5.Caption  = "Documento"
            .Page6.Caption  = "Pre" + CHR(231) + "o"
            .Page7.Caption  = "Div"
            .Page8.Caption  = "Diversos"
            .Page9.Caption  = "Subn" + CHR(237) + "vel"
            .Page10.Caption = "Estoque"
            .Page11.Caption = "Boleto"
            .Page12.Caption = "Config. Fin."
            .Page13.Caption = "Invoices"
            .Page14.Caption = "Div2"
            .Page15.Caption = "Itens2"
            .Page16.Caption = "Jobs"
            .Page17.Caption = "Comiss" + CHR(227) + "o"
            .Page18.Caption = "T" + CHR(237) + "tulos"
        ENDWITH

        *-- Fase C: Popular paginas internas com controles
        THIS.ConfigurarPagOperacao(loc_oPagina.pgf_4c_PagDados.Page1)
        THIS.ConfigurarPagItens(loc_oPagina.pgf_4c_PagDados.Page2)
        THIS.ConfigurarPagFinanceiro(loc_oPagina.pgf_4c_PagDados.Page3)
        THIS.ConfigurarPagFiscal(loc_oPagina.pgf_4c_PagDados.Page4)
        THIS.ConfigurarPagDocumento(loc_oPagina.pgf_4c_PagDados.Page5)
        THIS.ConfigurarPagPreco(loc_oPagina.pgf_4c_PagDados.Page6)
        THIS.ConfigurarPagDiv(loc_oPagina.pgf_4c_PagDados.Page7)
        THIS.ConfigurarPagDiversos(loc_oPagina.pgf_4c_PagDados.Page8)
        THIS.ConfigurarPagComissao(loc_oPagina.pgf_4c_PagDados.Page17)

        *-- Z-ORDER: Trazer botoes Salvar/Cancelar para frente do PageFrame interno
        loc_oPagina.cnt_4c_Salva.ZOrder(0)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados com tipos de operacao
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nFiltroSit
        loc_lResultado = .F.
        loc_nFiltroSit = 1

        *-- Modo de validacao de UI: criar cursor vazio para testes sem banco
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (dopes C(4), titopes C(30), tipoops N(2,0), situas N(1,0), opers N(1,0))
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            *-- Ler filtro de situacao se disponivel
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "opt_4c_FilSituas", 5)
                loc_nFiltroSit = THIS.pgf_4c_Paginas.Page1.opt_4c_FilSituas.Value
            ENDIF

            *-- SigCdOpe nao tem coluna emps - tabela global de configuracao
            *-- Descricao em SigCdOpe: titopes char(30)
            DO CASE
            CASE loc_nFiltroSit = 2
                *-- Ativos: situas = 0
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas = 0 " + ;
                           "ORDER BY a.dopes"
            CASE loc_nFiltroSit = 3
                *-- Inativos: situas <> 0
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "WHERE a.situas <> 0 " + ;
                           "ORDER BY a.dopes"
            OTHERWISE
                *-- Todos
                loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                           "FROM SigCdOpe a " + ;
                           "ORDER BY a.dopes"
            ENDCASE

            *-- SQLEXEC em cursor temporario para preservar colunas do Grid
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar tipos de opera" + CHR(231) + CHR(227) + "o.", ;
                    "Erro em CarregarLista")
            ELSE
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ELSE
                    SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN SELECT("cursor_4c_DadosTemp")
                ENDIF
                IF USED("cursor_4c_Dados")
                    *-- Configurar grid
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
                        LOCAL loc_oGrid
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                        loc_oGrid.ColumnCount = 2
                        loc_oGrid.RecordSource          = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopes"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.titopes"
                        loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column2.Header1.Caption = "Origem dos Valores a Serem Lan" + CHR(231) + "ados na Movimenta" + CHR(231) + CHR(227) + "o Financeira"
                        THIS.FormatarGridLista(loc_oGrid)
                    ENDIF
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_cPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Suporta tanto string ("LISTA"/"DADOS") quanto numero (1/2)
            IF (VARTYPE(par_cPagina) = "N" AND par_cPagina = 1) OR ;
               (VARTYPE(par_cPagina) = "C" AND UPPER(ALLTRIM(par_cPagina)) = "LISTA")
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = 2
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em AlternarPagina")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CRUD - Handlers de clique dos botoes principais
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_cModoAtual = "INCLUSAO"
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina("DADOS")
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnIncluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- Fase B: implementar ValidarPreAcao + logica de alteracao
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para alterar.", "Alterar")
            ELSE
                THIS.this_cModoAtual = "ALTERACAO"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina("DADOS")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnAlterarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        *-- Fase B: implementar ValidarPreAcao + logica de visualizacao
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para visualizar.", "Visualizar")
            ELSE
                THIS.this_cModoAtual = "VISUALIZACAO"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina("DADOS")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnVisualizarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- Fase B: implementar ValidarPreAcao + logica de exclusao
        LOCAL loc_lResultado, loc_lConfirma
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro para excluir.", "Excluir")
            ELSE
                loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro?", "Excluir")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.Excluir()
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnExcluirClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnBuscarClick()
        *-- Fase B: implementar busca
        THIS.CarregarLista()
    ENDPROC

    PROCEDURE BtnSalvarClick()
        *-- Fase B: implementar FormParaBO + Inserir/Atualizar
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.FormParaBO()
            DO CASE
            CASE THIS.this_cModoAtual = "INCLUSAO"
                loc_lResultado = THIS.this_oBusinessObject.Inserir()
            CASE THIS.this_cModoAtual = "ALTERACAO"
                loc_lResultado = THIS.this_oBusinessObject.Atualizar()
            ENDCASE
            IF loc_lResultado
                THIS.CarregarLista()
                THIS.AlternarPagina("LISTA")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BtnSalvarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        *-- Fase B: implementar cancelamento
        THIS.AlternarPagina("LISTA")
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers de eventos de grid e filtro
    *==========================================================================
    PROCEDURE GridAfterRowColChange(par_nColIndex)
        IF THIS.this_cModoAtual = "LISTA" AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
        ENDIF
    ENDPROC

    PROCEDURE FiltroSituaClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * Botoes de acao auxiliares (stubs - Fase B)
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        *-- Fase B: implementar exportar XML
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Exportar XML (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnImpXMLClick()
        *-- Fase B: implementar importar XML
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Importar XML (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCopiaClick()
        *-- Fase B: implementar copiar operacao
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Copiar (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMapaClick()
        *-- Fase B: implementar mapa
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Mapa (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCreditoClick()
        *-- Fase B: implementar gerar creditos
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Ger. Cr" + CHR(233) + "ditos (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnDepreciaClick()
        *-- Fase B: implementar depreciacao
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Deprecia" + CHR(231) + CHR(227) + "o (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnEtiquetasClick()
        *-- Fase B: implementar etiquetas
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Etiquetas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTransporteClick()
        *-- Fase B: implementar transportes
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Transportes (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnFreteClick()
        *-- Fase B: implementar fretes
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Fretes (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCaixaClick()
        *-- Fase B: implementar sequencia caixa
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Sequ" + CHR(234) + "ncia Cx (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTabDescontoClick()
        *-- Fase B: implementar tabelas de desconto
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Tabelas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMontaListaClick()
        *-- Fase B: implementar monta grade
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Monta Grade (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnTrfClick()
        *-- Fase B: implementar automaticas
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Autom" + CHR(225) + "ticas (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMultiSubNClick()
        *-- Fase B: implementar multiplos
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: M" + CHR(250) + "ltiplos (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnSubNivel2Click()
        *-- Fase B: implementar subnivel +
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (+) (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnMultiplasClick()
        *-- Fase B: implementar subnivel -
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Subn" + CHR(237) + "vel (-) (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnCcustoClick()
        *-- Fase B: implementar centro de custo
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: C.C. (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnGrupoContaClick()
        *-- Fase B: implementar grupo/conta
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Grupo/Conta (Fase B)", "Em desenvolvimento")
    ENDPROC

    PROCEDURE BtnStatusClick()
        *-- Fase B: implementar status
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o: Status (Fase B)", "Em desenvolvimento")
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos visuais para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagDados, loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            *-- Cabecalho (Pagina Dados)
            THIS.this_oBusinessObject.this_cDopes   = UPPER(ALLTRIM(loc_oPagDados.txt_4c_Codigo.Value))
            THIS.this_oBusinessObject.this_cTitopes = ALLTRIM(loc_oPagDados.txt_4c_Descricao.Value)
            THIS.this_oBusinessObject.this_nTipoops = ALLTRIM(loc_oPagDados.txt_4c_Tipo.Value)
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                THIS.this_oBusinessObject.this_cMenus = ALLTRIM(loc_oPagDados.cbo_4c_Menu.Value)
            ENDIF

            *-- Referencias das paginas internas
            loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
            loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
            loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
            loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
            loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
            loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
            loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
            loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
            loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17

            *-- Pagina 1: Operacao
            IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
                THIS.this_oBusinessObject.this_nBlqdatas = loc_oPg1.opt_4c_Blqdt.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
                THIS.this_oBusinessObject.this_nConfes = loc_oPg1.opt_4c_Conf.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
                THIS.this_oBusinessObject.this_nAciosens = loc_oPg1.opt_4c_Bloqueio.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
                THIS.this_oBusinessObject.this_cDopestrfs = ALLTRIM(loc_oPg1.txt_4c_DopeSTrfs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
                THIS.this_oBusinessObject.this_cDopeetrfs = ALLTRIM(loc_oPg1.txt_4c_DopeETrfs.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
                THIS.this_oBusinessObject.this_cCcentrals = ALLTRIM(loc_oPg1.txt_4c_Central.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "chk_4c_CarESubN", 5)
                THIS.this_oBusinessObject.this_nCempsubns = IIF(loc_oPg1.chk_4c_CarESubN.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "chk_4c_VincEstM", 5)
                THIS.this_oBusinessObject.this_nMestoqs = IIF(loc_oPg1.chk_4c_VincEstM.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
                THIS.this_oBusinessObject.this_cEmppads = ALLTRIM(loc_oPg1.txt_4c_EmpPad.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
                THIS.this_oBusinessObject.this_nOpers = loc_oPg1.opt_4c_Tipo.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
                THIS.this_oBusinessObject.this_nCaixas = loc_oPg1.opt_4c_Cai.Value
            ENDIF
            IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
                THIS.this_oBusinessObject.this_mObsopes = ALLTRIM(loc_oPg1.mem_4c_ObsOpe.Value)
            ENDIF

            *-- Pagina 2: Itens
            IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
                THIS.this_oBusinessObject.this_nCodbars = loc_oPg2.opt_4c_Cbar.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
                THIS.this_oBusinessObject.this_nImagems = loc_oPg2.opt_4c_Imagem.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_ObsItems", 5)
                THIS.this_oBusinessObject.this_nObsitems = loc_oPg2.opt_4c_ObsItems.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_Desmemb", 5)
                THIS.this_oBusinessObject.this_nDesmembs = loc_oPg2.opt_4c_Desmemb.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "opt_4c_ChkQtds", 5)
                THIS.this_oBusinessObject.this_nChkqtds = loc_oPg2.opt_4c_ChkQtds.Value
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_QtdIte", 5)
                THIS.this_oBusinessObject.this_nQtdites = ALLTRIM(loc_oPg2.txt_4c_QtdIte.Value)
            ENDIF

            *-- Pagina 3: Financeiro
            IF PEMSTATUS(loc_oPg3, "opt_4c_Che", 5)
                THIS.this_oBusinessObject.this_nCheqs = loc_oPg3.opt_4c_Che.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_Contas", 5)
                THIS.this_oBusinessObject.this_nParcontas = loc_oPg3.opt_4c_Contas.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_LimCre", 5)
                THIS.this_oBusinessObject.this_nLimcres = loc_oPg3.opt_4c_LimCre.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "opt_4c_Troco", 5)
                THIS.this_oBusinessObject.this_nTrocoauts = loc_oPg3.opt_4c_Troco.Value
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqEnt", 5)
                THIS.this_oBusinessObject.this_cOperchqes = ALLTRIM(loc_oPg3.txt_4c_OpChqEnt.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqSai", 5)
                THIS.this_oBusinessObject.this_cOperchqss = ALLTRIM(loc_oPg3.txt_4c_OpChqSai.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_Conta", 5)
                THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg3.txt_4c_Conta.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg3, "txt_4c_Grupo", 5)
                THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPg3.txt_4c_Grupo.Value)
            ENDIF

            *-- Pagina 4: Fiscal
            IF PEMSTATUS(loc_oPg4, "txt_4c_Especies", 5)
                THIS.this_oBusinessObject.this_cEspecies = ALLTRIM(loc_oPg4.txt_4c_Especies.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_Series", 5)
                THIS.this_oBusinessObject.this_cSeries = ALLTRIM(loc_oPg4.txt_4c_Series.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
                THIS.this_oBusinessObject.this_cCfos = ALLTRIM(loc_oPg4.txt_4c_CfoPad.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
                THIS.this_oBusinessObject.this_nTiponfs = loc_oPg4.opt_4c_TipoNF.Value
            ENDIF

            *-- Pagina 5: Documento
            IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
                THIS.this_oBusinessObject.this_nDigdoc = loc_oPg5.opt_4c_DigDoc.Value
            ENDIF
            IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
                THIS.this_oBusinessObject.this_nEditdocs = loc_oPg5.opt_4c_EditDocs.Value
            ENDIF

            *-- Pagina 6: Preco
            IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
                THIS.this_oBusinessObject.this_nEprecos = loc_oPg6.opt_4c_AltPreco.Value
            ENDIF
            IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)
                THIS.this_oBusinessObject.this_nEpesos = loc_oPg6.opt_4c_AltPeso.Value
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_LPrecoPad", 5)
                THIS.this_oBusinessObject.this_cLprecopads = ALLTRIM(loc_oPg6.txt_4c_LPrecoPad.Value)
            ENDIF

            *-- Pagina 7: Div
            IF PEMSTATUS(loc_oPg7, "opt_4c_DivVar", 5)
                THIS.this_oBusinessObject.this_nVars = loc_oPg7.opt_4c_DivVar.Value
            ENDIF

            *-- Pagina 8: Diversos
            IF PEMSTATUS(loc_oPg8, "chk_4c_Digenves", 5)
                THIS.this_oBusinessObject.this_nDigenves = IIF(loc_oPg8.chk_4c_Digenves.Value = 1, 1, 0)
            ENDIF
            IF PEMSTATUS(loc_oPg8, "chk_4c_Digrecs", 5)
                THIS.this_oBusinessObject.this_nDigrecs = IIF(loc_oPg8.chk_4c_Digrecs.Value = 1, 1, 0)
            ENDIF

            *-- Pagina 17: Comissao
            IF PEMSTATUS(loc_oPg17, "chk_4c_Grupov", 5)
                THIS.this_oBusinessObject.this_lFixgvends = (loc_oPg17.chk_4c_Grupov.Value = 1)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "txt_4c_Grupov", 5)
                THIS.this_oBusinessObject.this_cGrvends = ALLTRIM(loc_oPg17.txt_4c_Grupov.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
                THIS.this_oBusinessObject.this_cMascvens = ALLTRIM(loc_oPg17.txt_4c_MascVen.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
                THIS.this_oBusinessObject.this_nVendes = loc_oPg17.opt_4c_Vende.Value
            ENDIF
            IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
                THIS.this_oBusinessObject.this_nCadclis = loc_oPg17.opt_4c_CadCli.Value
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos visuais
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPagDados, loc_cDopes
        LOCAL loc_oPg1, loc_oPg2, loc_oPg3, loc_oPg4, loc_oPg5, loc_oPg6, loc_oPg7, loc_oPg8, loc_oPg17
        LOCAL loc_oBO
        loc_lResultado = .F.
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                loc_cDopes = ALLTRIM(cursor_4c_Dados.dopes)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDopes)
                    loc_oBO = THIS.this_oBusinessObject

                    *-- Cabecalho
                    loc_oPagDados.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cDopes)
                    loc_oPagDados.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cTitopes)
                    loc_oPagDados.txt_4c_Tipo.Value      = TRANSFORM(loc_oBO.this_nTipoops)
                    IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                        loc_oPagDados.cbo_4c_Menu.Value  = ALLTRIM(loc_oBO.this_cMenus)
                    ENDIF

                    loc_oPg1  = loc_oPagDados.pgf_4c_PagDados.Page1
                    loc_oPg2  = loc_oPagDados.pgf_4c_PagDados.Page2
                    loc_oPg3  = loc_oPagDados.pgf_4c_PagDados.Page3
                    loc_oPg4  = loc_oPagDados.pgf_4c_PagDados.Page4
                    loc_oPg5  = loc_oPagDados.pgf_4c_PagDados.Page5
                    loc_oPg6  = loc_oPagDados.pgf_4c_PagDados.Page6
                    loc_oPg7  = loc_oPagDados.pgf_4c_PagDados.Page7
                    loc_oPg8  = loc_oPagDados.pgf_4c_PagDados.Page8
                    loc_oPg17 = loc_oPagDados.pgf_4c_PagDados.Page17

                    *-- Pagina 1: Operacao
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Blqdt", 5)
                        loc_oPg1.opt_4c_Blqdt.Value = IIF(loc_oBO.this_nBlqdatas > 0, loc_oBO.this_nBlqdatas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Conf", 5)
                        loc_oPg1.opt_4c_Conf.Value = loc_oBO.this_nConfes
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Bloqueio", 5)
                        loc_oPg1.opt_4c_Bloqueio.Value = loc_oBO.this_nAciosens
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_DopeSTrfs", 5)
                        loc_oPg1.txt_4c_DopeSTrfs.Value = ALLTRIM(loc_oBO.this_cDopestrfs)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_DopeETrfs", 5)
                        loc_oPg1.txt_4c_DopeETrfs.Value = ALLTRIM(loc_oBO.this_cDopeetrfs)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_Central", 5)
                        loc_oPg1.txt_4c_Central.Value = ALLTRIM(loc_oBO.this_cCcentrals)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "chk_4c_CarESubN", 5)
                        loc_oPg1.chk_4c_CarESubN.Value = IIF(loc_oBO.this_nCempsubns = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "chk_4c_VincEstM", 5)
                        loc_oPg1.chk_4c_VincEstM.Value = IIF(loc_oBO.this_nMestoqs = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "txt_4c_EmpPad", 5)
                        loc_oPg1.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmppads)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Tipo", 5)
                        loc_oPg1.opt_4c_Tipo.Value = IIF(loc_oBO.this_nOpers > 0, loc_oBO.this_nOpers, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "opt_4c_Cai", 5)
                        loc_oPg1.opt_4c_Cai.Value = IIF(loc_oBO.this_nCaixas > 0, loc_oBO.this_nCaixas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg1, "mem_4c_ObsOpe", 5)
                        loc_oPg1.mem_4c_ObsOpe.Value = ALLTRIM(loc_oBO.this_mObsopes)
                    ENDIF

                    *-- Pagina 2: Itens
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Cbar", 5)
                        loc_oPg2.opt_4c_Cbar.Value = IIF(loc_oBO.this_nCodbars > 0, loc_oBO.this_nCodbars, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Imagem", 5)
                        loc_oPg2.opt_4c_Imagem.Value = IIF(loc_oBO.this_nImagems > 0, loc_oBO.this_nImagems, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_ObsItems", 5)
                        loc_oPg2.opt_4c_ObsItems.Value = IIF(loc_oBO.this_nObsitems > 0, loc_oBO.this_nObsitems, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_Desmemb", 5)
                        loc_oPg2.opt_4c_Desmemb.Value = IIF(loc_oBO.this_nDesmembs > 0, loc_oBO.this_nDesmembs, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "opt_4c_ChkQtds", 5)
                        loc_oPg2.opt_4c_ChkQtds.Value = IIF(loc_oBO.this_nChkqtds > 0, loc_oBO.this_nChkqtds, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "txt_4c_QtdIte", 5)
                        loc_oPg2.txt_4c_QtdIte.Value = TRANSFORM(loc_oBO.this_nQtdites)
                    ENDIF

                    *-- Pagina 3: Financeiro
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Che", 5)
                        loc_oPg3.opt_4c_Che.Value = IIF(loc_oBO.this_nCheqs > 0, loc_oBO.this_nCheqs, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Contas", 5)
                        loc_oPg3.opt_4c_Contas.Value = IIF(loc_oBO.this_nParcontas > 0, loc_oBO.this_nParcontas, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_LimCre", 5)
                        loc_oPg3.opt_4c_LimCre.Value = IIF(loc_oBO.this_nLimcres > 0, loc_oBO.this_nLimcres, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "opt_4c_Troco", 5)
                        loc_oPg3.opt_4c_Troco.Value = IIF(loc_oBO.this_nTrocoauts > 0, loc_oBO.this_nTrocoauts, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqEnt", 5)
                        loc_oPg3.txt_4c_OpChqEnt.Value = ALLTRIM(loc_oBO.this_cOperchqes)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_OpChqSai", 5)
                        loc_oPg3.txt_4c_OpChqSai.Value = ALLTRIM(loc_oBO.this_cOperchqss)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_Conta", 5)
                        loc_oPg3.txt_4c_Conta.Value = ALLTRIM(loc_oBO.this_cContas)
                    ENDIF
                    IF PEMSTATUS(loc_oPg3, "txt_4c_Grupo", 5)
                        loc_oPg3.txt_4c_Grupo.Value = ALLTRIM(loc_oBO.this_cGrupos)
                    ENDIF

                    *-- Pagina 4: Fiscal
                    IF PEMSTATUS(loc_oPg4, "txt_4c_Especies", 5)
                        loc_oPg4.txt_4c_Especies.Value = ALLTRIM(loc_oBO.this_cEspecies)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "txt_4c_Series", 5)
                        loc_oPg4.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "txt_4c_CfoPad", 5)
                        loc_oPg4.txt_4c_CfoPad.Value = ALLTRIM(loc_oBO.this_cCfos)
                    ENDIF
                    IF PEMSTATUS(loc_oPg4, "opt_4c_TipoNF", 5)
                        loc_oPg4.opt_4c_TipoNF.Value = IIF(loc_oBO.this_nTiponfs > 0, loc_oBO.this_nTiponfs, 1)
                    ENDIF

                    *-- Pagina 5: Documento
                    IF PEMSTATUS(loc_oPg5, "opt_4c_DigDoc", 5)
                        loc_oPg5.opt_4c_DigDoc.Value = IIF(loc_oBO.this_nDigdoc > 0, loc_oBO.this_nDigdoc, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg5, "opt_4c_EditDocs", 5)
                        loc_oPg5.opt_4c_EditDocs.Value = IIF(loc_oBO.this_nEditdocs > 0, loc_oBO.this_nEditdocs, 1)
                    ENDIF

                    *-- Pagina 6: Preco
                    IF PEMSTATUS(loc_oPg6, "opt_4c_AltPreco", 5)
                        loc_oPg6.opt_4c_AltPreco.Value = IIF(loc_oBO.this_nEprecos > 0, loc_oBO.this_nEprecos, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg6, "opt_4c_AltPeso", 5)
                        loc_oPg6.opt_4c_AltPeso.Value = IIF(loc_oBO.this_nEpesos > 0, loc_oBO.this_nEpesos, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg6, "txt_4c_LPrecoPad", 5)
                        loc_oPg6.txt_4c_LPrecoPad.Value = ALLTRIM(loc_oBO.this_cLprecopads)
                    ENDIF

                    *-- Pagina 7: Div
                    IF PEMSTATUS(loc_oPg7, "opt_4c_DivVar", 5)
                        loc_oPg7.opt_4c_DivVar.Value = IIF(loc_oBO.this_nVars > 0, loc_oBO.this_nVars, 1)
                    ENDIF

                    *-- Pagina 8: Diversos
                    IF PEMSTATUS(loc_oPg8, "chk_4c_Digenves", 5)
                        loc_oPg8.chk_4c_Digenves.Value = IIF(loc_oBO.this_nDigenves = 1, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg8, "chk_4c_Digrecs", 5)
                        loc_oPg8.chk_4c_Digrecs.Value = IIF(loc_oBO.this_nDigrecs = 1, 1, 0)
                    ENDIF

                    *-- Pagina 17: Comissao
                    IF PEMSTATUS(loc_oPg17, "chk_4c_Grupov", 5)
                        loc_oPg17.chk_4c_Grupov.Value = IIF(loc_oBO.this_lFixgvends, 1, 0)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "txt_4c_Grupov", 5)
                        loc_oPg17.txt_4c_Grupov.Value = ALLTRIM(loc_oBO.this_cGrvends)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "txt_4c_MascVen", 5)
                        loc_oPg17.txt_4c_MascVen.Value = ALLTRIM(loc_oBO.this_cMascvens)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "opt_4c_Vende", 5)
                        loc_oPg17.opt_4c_Vende.Value = IIF(loc_oBO.this_nVendes > 0, loc_oBO.this_nVendes, 1)
                    ENDIF
                    IF PEMSTATUS(loc_oPg17, "opt_4c_CadCli", 5)
                        loc_oPg17.opt_4c_CadCli.Value = IIF(loc_oBO.this_nCadclis > 0, loc_oBO.this_nCadclis, 1)
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em BOParaForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita edicao dos campos
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.ReadOnly    = !par_lHabilitar
            loc_oPagDados.txt_4c_Descricao.ReadOnly = !par_lHabilitar
            loc_oPagDados.txt_4c_Tipo.ReadOnly       = !par_lHabilitar
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                loc_oPagDados.cbo_4c_Menu.Enabled = par_lHabilitar
            ENDIF
            *-- Habilitar recursivamente todos os controles das paginas internas
            IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
                THIS.HabilitarControlesRecursivo(loc_oPagDados.pgf_4c_PagDados, par_lHabilitar)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarControlesRecursivo - Percorre recursivamente e ajusta ReadOnly/Enabled
    *==========================================================================
    PROTECTED PROCEDURE HabilitarControlesRecursivo(par_oContainer, par_lHabilitar)
        LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
        *-- PageFrame usa Pages(N)/PageCount, nao Controls(N)/ControlCount
        IF UPPER(par_oContainer.BaseClass) = "PAGEFRAME"
            FOR loc_nP = 1 TO par_oContainer.PageCount
                THIS.HabilitarControlesRecursivo(par_oContainer.Pages(loc_nP), par_lHabilitar)
            ENDFOR
            RETURN
        ENDIF
        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                loc_cCls = UPPER(loc_oObj.BaseClass)
                DO CASE
                CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
                    IF PEMSTATUS(loc_oObj, "ReadOnly", 5)
                        loc_oObj.ReadOnly = !par_lHabilitar
                    ENDIF
                CASE loc_cCls = "CHECKBOX" OR loc_cCls = "OPTIONGROUP" OR loc_cCls = "COMBOBOX" OR loc_cCls = "SPINNER"
                    IF PEMSTATUS(loc_oObj, "Enabled", 5)
                        loc_oObj.Enabled = par_lHabilitar
                    ENDIF
                CASE loc_cCls = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObj.PageCount
                        THIS.HabilitarControlesRecursivo(loc_oObj.Pages(loc_nP), par_lHabilitar)
                    ENDFOR
                CASE loc_cCls = "CONTAINER"
                    THIS.HabilitarControlesRecursivo(loc_oObj, par_lHabilitar)
                ENDCASE
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de edicao
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagDados
        loc_oPagDados = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPagDados.txt_4c_Codigo.Value    = ""
            loc_oPagDados.txt_4c_Descricao.Value = ""
            loc_oPagDados.txt_4c_Tipo.Value      = "0"
            IF PEMSTATUS(loc_oPagDados, "cbo_4c_Menu", 5)
                loc_oPagDados.cbo_4c_Menu.Value = ""
            ENDIF
            *-- Limpar todos os controles das paginas internas
            IF PEMSTATUS(loc_oPagDados, "pgf_4c_PagDados", 5)
                THIS.LimparControlesRecursivo(loc_oPagDados.pgf_4c_PagDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparControlesRecursivo - Reset de todos controles a defaults
    *==========================================================================
    PROTECTED PROCEDURE LimparControlesRecursivo(par_oContainer)
        LOCAL loc_nI, loc_oObj, loc_nP, loc_cCls
        *-- PageFrame usa Pages(N)/PageCount, nao Controls(N)/ControlCount
        IF UPPER(par_oContainer.BaseClass) = "PAGEFRAME"
            FOR loc_nP = 1 TO par_oContainer.PageCount
                THIS.LimparControlesRecursivo(par_oContainer.Pages(loc_nP))
            ENDFOR
            RETURN
        ENDIF
        IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
            RETURN
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObj = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObj) = "O"
                loc_cCls = UPPER(loc_oObj.BaseClass)
                DO CASE
                CASE loc_cCls = "TEXTBOX" OR loc_cCls = "EDITBOX"
                    IF PEMSTATUS(loc_oObj, "Value", 5)
                        IF VARTYPE(loc_oObj.Value) = "N"
                            loc_oObj.Value = 0
                        ELSE
                            loc_oObj.Value = ""
                        ENDIF
                    ENDIF
                CASE loc_cCls = "CHECKBOX"
                    loc_oObj.Value = 0
                CASE loc_cCls = "OPTIONGROUP"
                    loc_oObj.Value = 1
                CASE loc_cCls = "COMBOBOX"
                    loc_oObj.Value = ""
                CASE loc_cCls = "SPINNER"
                    loc_oObj.Value = 0
                CASE loc_cCls = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObj.PageCount
                        THIS.LimparControlesRecursivo(loc_oObj.Pages(loc_nP))
                    ENDFOR
                CASE loc_cCls = "CONTAINER"
                    THIS.LimparControlesRecursivo(loc_oObj)
                ENDCASE
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_lHabilitar, loc_lModoEdicao
        loc_lHabilitar = .T.
        loc_lModoEdicao = (THIS.this_cModoAtual = "INCLUSAO" OR THIS.this_cModoAtual = "ALTERACAO")
        IF VARTYPE(par_cModo) = "C" AND !EMPTY(par_cModo)
            loc_lModoEdicao = (par_cModo = "INCLUSAO" OR par_cModo = "ALTERACAO")
        ENDIF
        *-- Habilitar/desabilitar campos conforme modo
        THIS.HabilitarCampos(loc_lModoEdicao)
    ENDPROC

    *==========================================================================
    * Destroy - Liberacao de recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN SELECT("cursor_4c_Dados")
        ENDIF
        IF USED("cursor_4c_DadosTemp")
            USE IN SELECT("cursor_4c_DadosTemp")
        ENDIF
        DODEFAULT()
    ENDPROC


    *==========================================================================
    * Handlers InteractiveChange dos OptionGroups das paginas internas
    *==========================================================================
    PROCEDURE OptBlqdtChange()
    ENDPROC

    PROCEDURE OptTipoChange()
    ENDPROC

    PROCEDURE OptTipoNFChange()
    ENDPROC

    PROCEDURE OptVendeChange()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * Helpers de criacao rapida (reduzem verbosidade)
    *==========================================================================
    PROTECTED PROCEDURE AddLabel(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
        par_oPag.AddObject(par_cName, "Label")
        WITH EVALUATE("par_oPag." + par_cName)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddTextBox(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth, par_nMaxLen)
        par_oPag.AddObject(par_cName, "TextBox")
        WITH EVALUATE("par_oPag." + par_cName)
            .Value         = ""
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = par_nMaxLen
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddCheckBox(par_oPag, par_cName, par_cCaption, par_nTop, par_nLeft, par_nWidth)
        par_oPag.AddObject(par_cName, "CheckBox")
        WITH EVALUATE("par_oPag." + par_cName)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeft
            .Width     = par_nWidth
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Value     = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE AddOptGroupSN(par_oPag, par_cName, par_nTop, par_nLeft, par_nWidth)
        *-- Cria OptionGroup padrao "Sim / Nao" (2 botoes horizontais)
        par_oPag.AddObject(par_cName, "OptionGroup")
        WITH EVALUATE("par_oPag." + par_cName)
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 1
            .SpecialEffect = 1
            .Top           = par_nTop
            .Left          = par_nLeft
            .Width         = par_nWidth
            .Height        = 22
            .Value         = 1
            .Themes        = .F.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontName  = "Tahoma"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Top       = 3
            .Buttons(1).Left      = 5
            .Buttons(1).Width     = 45
            .Buttons(1).Height    = 17
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).AutoSize  = .F.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontName  = "Tahoma"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Top       = 3
            .Buttons(2).Left      = 60
            .Buttons(2).Width     = 45
            .Buttons(2).Height    = 17
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).AutoSize  = .F.
            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPagOperacao - Popula Page1 (Operacao) do PageFrame interno
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagOperacao(par_oPagina)
        TRY
            *-- Numeracao label
            THIS.AddLabel(par_oPagina, "lbl_4c_Numeracao", "Numera" + CHR(231) + CHR(227) + "o :", 11, 78, 63)
            *-- Bloqueio de alterar data (OptionGroup 4 botoes)
            THIS.AddLabel(par_oPagina, "lbl_4c_BlqDt", "Bloq. Alterar Data :", 45, 46, 95)
            par_oPagina.AddObject("opt_4c_Blqdt", "OptionGroup")
            WITH par_oPagina.opt_4c_Blqdt
                .ButtonCount   = 4
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 43
                .Left          = 145
                .Width         = 248
                .Height        = 32
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Value   = 1
                .Buttons(1).Top     = 2
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 40
                .Buttons(1).Height  = 17
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(1).ForeColor = RGB(90, 90, 90)
                .Buttons(1).AutoSize  = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Top     = 15
                .Buttons(2).Left    = 5
                .Buttons(2).Width   = 40
                .Buttons(2).Height  = 17
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(2).ForeColor = RGB(90, 90, 90)
                .Buttons(2).AutoSize  = .F.
                .Buttons(3).Caption = "Subn" + CHR(237) + "vel Sim"
                .Buttons(3).Top     = 2
                .Buttons(3).Left    = 110
                .Buttons(3).Width   = 100
                .Buttons(3).Height  = 15
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Buttons(3).ForeColor = RGB(90, 90, 90)
                .Buttons(3).AutoSize  = .T.
                .Buttons(4).Caption = "Subn" + CHR(237) + "vel N" + CHR(227) + "o"
                .Buttons(4).Top     = 15
                .Buttons(4).Left    = 110
                .Buttons(4).Width   = 100
                .Buttons(4).Height  = 15
                .Buttons(4).BackStyle = 0
                .Buttons(4).FontName  = "Tahoma"
                .Buttons(4).FontSize  = 8
                .Buttons(4).ForeColor = RGB(90, 90, 90)
                .Buttons(4).AutoSize  = .T.
                .Visible = .T.
            ENDWITH
            BINDEVENT(par_oPagina.opt_4c_Blqdt, "InteractiveChange", THIS, "OptBlqdtChange")

            *-- Conferencia (S/N)
            THIS.AddLabel(par_oPagina, "lbl_4c_Conf", "Confer" + CHR(234) + "ncia :", 181, 74, 67)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Conf", 179, 145, 248)

            *-- Verificar Bloqueio (Aciosens)
            THIS.AddLabel(par_oPagina, "lbl_4c_VerBlq", "Verificar Bloqueio :", 221, 516, 91)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Bloqueio", 219, 611, 175)

            *-- Transferencia de Saida
            THIS.AddLabel(par_oPagina, "lbl_4c_MovSai", "Movimenta" + CHR(231) + CHR(227) + "o de Sa" + CHR(237) + "da :", 309, 340, 145)
            THIS.AddTextBox(par_oPagina, "txt_4c_DopeSTrfs", 306, 486, 150, 20)

            *-- Movimentacao de Entrada
            THIS.AddLabel(par_oPagina, "lbl_4c_MovEnt", "Movimenta" + CHR(231) + CHR(227) + "o de Entrada :", 331, 340, 145)
            THIS.AddTextBox(par_oPagina, "txt_4c_DopeETrfs", 328, 486, 150, 20)

            *-- Central
            THIS.AddLabel(par_oPagina, "lbl_4c_Central", "Central :", 258, 90, 50)
            THIS.AddTextBox(par_oPagina, "txt_4c_Central", 255, 145, 50, 2)

            *-- Empresa Padrao
            THIS.AddLabel(par_oPagina, "lbl_4c_EmpPad", "Empresa Padr" + CHR(227) + "o :", 388, 60, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_EmpPad", 385, 145, 50, 3)

            *-- CheckBoxes
            THIS.AddCheckBox(par_oPagina, "chk_4c_CarESubN", "Carregar E-Subn" + CHR(237) + "vel", 415, 145, 180)
            THIS.AddCheckBox(par_oPagina, "chk_4c_VincEstM", "Vincular Est. Mestre", 435, 145, 180)

            *-- Tipo (Opers)
            THIS.AddLabel(par_oPagina, "lbl_4c_Tipo1", "Tipo :", 460, 100, 45)
            par_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
            WITH par_oPagina.opt_4c_Tipo
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 458
                .Left          = 145
                .Width         = 250
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Sa" + CHR(237) + "da"
                .Buttons(1).Value   = 1
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 60
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(1).ForeColor = RGB(90, 90, 90)
                .Buttons(2).Caption = "Entrada"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 70
                .Buttons(2).Width   = 60
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(2).ForeColor = RGB(90, 90, 90)
                .Buttons(3).Caption = "Nenhum"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 140
                .Buttons(3).Width   = 60
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Buttons(3).ForeColor = RGB(90, 90, 90)
                .Visible = .T.
            ENDWITH
            BINDEVENT(par_oPagina.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoChange")

            *-- Caixa
            THIS.AddLabel(par_oPagina, "lbl_4c_Cai", "Caixa :", 490, 100, 45)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cai", 488, 145, 120)

            *-- Observacao (EditBox)
            THIS.AddLabel(par_oPagina, "lbl_4c_ObsOpe", "Observa" + CHR(231) + CHR(245) + "es :", 520, 60, 80)
            par_oPagina.AddObject("mem_4c_ObsOpe", "EditBox")
            WITH par_oPagina.mem_4c_ObsOpe
                .Value       = ""
                .Top         = 518
                .Left        = 145
                .Width       = 640
                .Height      = 60
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(0, 0, 0)
                .BorderStyle = 1
                .SpecialEffect = 1
                .Visible     = .T.
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagOperacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagItens - Popula Page2 (Itens)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagItens(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_CBar", "C" + CHR(243) + "d. Barras :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Cbar", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Imagem", "Imagem :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Imagem", 48, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_ObsItems", "Obs. Itens :", 80, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_ObsItems", 78, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Desmemb", "Desmembra :", 110, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Desmemb", 108, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_ChkQtds", "Check Qtd :", 140, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_ChkQtds", 138, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_QtdIte", "Qtde. Itens :", 175, 30, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_QtdIte", 172, 120, 60, 4)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagItens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagFinanceiro - Popula Page3 (Financeiro)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagFinanceiro(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_Che", "Cheque :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Che", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Contas", "Contas :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Contas", 48, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_LimCre", "Lim. Cr" + CHR(233) + "dito :", 80, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_LimCre", 78, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_Troco", "Troco Auto :", 110, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_Troco", 108, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_OpChqEnt", "Op. Cheq. Entr. :", 145, 30, 100)
            THIS.AddTextBox(par_oPagina, "txt_4c_OpChqEnt", 142, 145, 150, 15)

            THIS.AddLabel(par_oPagina, "lbl_4c_OpChqSai", "Op. Cheq. Sa" + CHR(237) + "da :", 175, 30, 100)
            THIS.AddTextBox(par_oPagina, "txt_4c_OpChqSai", 172, 145, 150, 15)

            THIS.AddLabel(par_oPagina, "lbl_4c_Conta", "Conta :", 205, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Conta", 202, 145, 100, 10)

            THIS.AddLabel(par_oPagina, "lbl_4c_Grupo", "Grupo :", 235, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Grupo", 232, 145, 100, 10)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagFinanceiro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagFiscal - Popula Page4 (Fiscal)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagFiscal(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_Especies", "Esp" + CHR(233) + "cie :", 20, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Especies", 17, 120, 80, 6)

            THIS.AddLabel(par_oPagina, "lbl_4c_Series", "S" + CHR(233) + "rie :", 50, 30, 60)
            THIS.AddTextBox(par_oPagina, "txt_4c_Series", 47, 120, 80, 3)

            THIS.AddLabel(par_oPagina, "lbl_4c_CfoPad", "CFO Padr" + CHR(227) + "o :", 80, 30, 80)
            THIS.AddTextBox(par_oPagina, "txt_4c_CfoPad", 77, 120, 100, 10)

            THIS.AddLabel(par_oPagina, "lbl_4c_TipoNF", "Tipo NF :", 110, 30, 60)
            par_oPagina.AddObject("opt_4c_TipoNF", "OptionGroup")
            WITH par_oPagina.opt_4c_TipoNF
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 108
                .Left          = 120
                .Width         = 260
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Entrada"
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 70
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(2).Caption = "Sa" + CHR(237) + "da"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 80
                .Buttons(2).Width   = 70
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(3).Caption = "Nenhum"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 155
                .Buttons(3).Width   = 70
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Visible = .T.
            ENDWITH
            BINDEVENT(par_oPagina.opt_4c_TipoNF, "InteractiveChange", THIS, "OptTipoNFChange")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagFiscal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDocumento - Popula Page5 (Documento)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDocumento(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_DigDoc", "Digita Doc :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_DigDoc", 18, 120, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_EditDocs", "Editar Docs :", 50, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_EditDocs", 48, 120, 120)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDocumento")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagPreco - Popula Page6 (Preco)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagPreco(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_AltPreco", "Altera Pre" + CHR(231) + "o :", 20, 30, 100)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPreco", 18, 140, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_AltPeso", "Altera Peso :", 50, 30, 100)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_AltPeso", 48, 140, 120)

            THIS.AddLabel(par_oPagina, "lbl_4c_LPrecoPad", "Lista Pre" + CHR(231) + "o Padr" + CHR(227) + "o :", 80, 30, 120)
            THIS.AddTextBox(par_oPagina, "txt_4c_LPrecoPad", 77, 155, 200, 30)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagPreco")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDiv - Popula Page7 (Div)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDiv(par_oPagina)
        TRY
            THIS.AddLabel(par_oPagina, "lbl_4c_DivVar", "Var. Div. :", 20, 30, 80)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_DivVar", 18, 120, 120)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDiv")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagDiversos - Popula Page8 (Diversos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagDiversos(par_oPagina)
        TRY
            THIS.AddCheckBox(par_oPagina, "chk_4c_Digenves", "Digitar Envelope", 20, 30, 200)
            THIS.AddCheckBox(par_oPagina, "chk_4c_Digrecs", "Digitar Recebimento", 45, 30, 200)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagDiversos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPagComissao - Popula Page17 (Comissao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPagComissao(par_oPagina)
        TRY
            THIS.AddCheckBox(par_oPagina, "chk_4c_Grupov", "Fixar Grupo Vend.", 20, 30, 180)
            THIS.AddLabel(par_oPagina, "lbl_4c_Grupov", "Grupo Vend. :", 45, 30, 90)
            THIS.AddTextBox(par_oPagina, "txt_4c_Grupov", 42, 130, 120, 20)

            THIS.AddLabel(par_oPagina, "lbl_4c_MascVen", "M" + CHR(225) + "scara Vend. :", 75, 30, 90)
            THIS.AddTextBox(par_oPagina, "txt_4c_MascVen", 72, 130, 120, 20)

            THIS.AddLabel(par_oPagina, "lbl_4c_Vende", "Vendedor :", 105, 30, 80)
            par_oPagina.AddObject("opt_4c_Vende", "OptionGroup")
            WITH par_oPagina.opt_4c_Vende
                .ButtonCount   = 3
                .BackStyle     = 0
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 103
                .Left          = 130
                .Width         = 260
                .Height        = 22
                .Value         = 1
                .Themes        = .F.
                .Buttons(1).Caption = "Obrigat" + CHR(243) + "rio"
                .Buttons(1).Top     = 3
                .Buttons(1).Left    = 5
                .Buttons(1).Width   = 80
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(2).Caption = "Opcional"
                .Buttons(2).Top     = 3
                .Buttons(2).Left    = 90
                .Buttons(2).Width   = 70
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(3).Caption = "N" + CHR(227) + "o"
                .Buttons(3).Top     = 3
                .Buttons(3).Left    = 165
                .Buttons(3).Width   = 50
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName  = "Tahoma"
                .Buttons(3).FontSize  = 8
                .Visible = .T.
            ENDWITH
            BINDEVENT(par_oPagina.opt_4c_Vende, "InteractiveChange", THIS, "OptVendeChange")

            THIS.AddLabel(par_oPagina, "lbl_4c_CadCli", "Cad. Cliente :", 140, 30, 90)
            THIS.AddOptGroupSN(par_oPagina, "opt_4c_CadCli", 138, 130, 120)

            *-- Ccusto: legado Lista Top=574, compensado +29=603, Left=810
            par_oPagina.AddObject("cmd_4c_Ccusto", "CommandButton")
            WITH par_oPagina.cmd_4c_Ccusto
                .Caption       = "C.C."
                .Top           = 603
                .Left          = 810
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .ForeColor     = RGB(90, 90, 90)
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(par_oPagina.cmd_4c_Ccusto, "Click", THIS, "BtnCcustoClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Erro em ConfigurarPagComissao")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\OPEBO.prg):
*====================================================================
* OPEBO.prg
*
* Business Object para Cadastro de Tipos de Operacao
* Tabela: SigCdOpe
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS OPEBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdOpe)
    *-- PK
    this_cDopes         = ""    && dopes char(20) - PK
    *-- numeric(1,0) flags / boolean-like
    this_nPedclis       = 0     && pedclis numeric(1,0)
    this_nZerqtds       = 0     && zerqtds numeric(1,0)
    this_nValinotas     = 0     && valinotas numeric(1,0)
    this_nValitems      = 0     && valitems numeric(1,0)
    this_nExibsits      = 0     && exibsits numeric(1,0)
    this_nChkqtds       = 0     && chkqtds numeric(1,0)
    this_nDtcontab      = 0     && dtcontab numeric(1,0)
    this_nAltdescs      = 0     && altdescs numeric(1,0)
    this_nAntecs        = 0     && antecs numeric(1,0)
    this_nAptpfats      = 0     && aptpfats numeric(1,0)
    this_nArreds        = 0     && arreds numeric(1,0)
    this_nBaixasns      = 0     && baixasns numeric(1,0)
    this_nBxautos       = 0     && bxautos numeric(1,0)
    this_nBxparcials    = 0     && bxparcials numeric(1,0)
    this_nCadclis       = 0     && cadclis numeric(1,0)
    this_nCaixas        = 0     && caixas numeric(1,0)
    this_nCalcfecs      = 0     && calcfecs numeric(1,0)
    this_nCarnes        = 0     && carnes numeric(1,0)
    this_nCcomis        = 0     && ccomis numeric(1,0)
    this_nCdesps        = 0     && cdesps numeric(1,0)
    this_nChdtentrs     = 0     && chdtentrs numeric(1,0)
    this_nCheqs         = 0     && cheqs numeric(1,0)
    this_nCodbars       = 0     && codbars numeric(1,0)
    this_nComcargs      = 0     && comcargs numeric(1,0)
    this_nCondsubs      = 0     && condsubs numeric(1,0)
    this_nConfes        = 0     && confes numeric(1,0)
    this_nConosubs      = 0     && conosubs numeric(1,0)
    this_nConsclis      = 0     && consclis numeric(1,0)
    this_nConsers       = 0     && consers numeric(1,0)
    this_nConsgs        = 0     && consgs numeric(1,0)
    this_nCopers        = 0     && copers numeric(1,0)
    this_nCrepls        = 0     && crepls numeric(1,0)
    this_nCtipos        = 0     && ctipos numeric(1,0)
    this_nCupfis        = 0     && cupfis numeric(1,0)
    this_nDeacrs        = 0     && deacrs numeric(1,0)
    this_nDesmembs      = 0     && desmembs numeric(1,0)
    this_nDestinos      = 0     && destinos numeric(1,0)
    this_nDfpags        = 0     && dfpags numeric(1,0)
    this_nDigdoc        = 0     && digdoc numeric(1,0)
    this_nDigitens      = 0     && digitens numeric(1,0)
    this_nDigobs        = 0     && digobs numeric(1,0)
    this_nDtentrs       = 0     && dtentrs numeric(1,0)
    this_nEdcotas       = 0     && edcotas numeric(1,0)
    this_nEdtpfats      = 0     && edtpfats numeric(1,0)
    this_nEfators       = 0     && efators numeric(1,0)
    this_nEpesos        = 0     && epesos numeric(1,0)
    this_nEprecos       = 0     && eprecos numeric(1,0)
    this_nEstdests      = 0     && estdests numeric(1,0)
    this_nEstoqs        = 0     && estoqs numeric(1,0)
    this_nEstorigs      = 0     && estorigs numeric(1,0)
    this_nExpends       = 0     && expends numeric(1,0)
    this_nFatauts       = 0     && fatauts numeric(1,0)
    this_nGlobalizas    = 0     && globalizas numeric(1,0)
    this_nImagems       = 0     && imagems numeric(1,0)
    this_nItemalfas     = 0     && itemalfas numeric(1,0)
    this_nItemzeros     = 0     && itemzeros numeric(1,0)
    this_nLimcres       = 0     && limcres numeric(1,0)
    this_nLimpauts      = 0     && limpauts numeric(1,0)
    this_nLprecos       = 0     && lprecos numeric(1,0)
    this_nMestoqs       = 0     && mestoqs numeric(1,0)
    this_nNdebitos      = 0     && ndebitos numeric(1,0)
    this_nNfiscals      = 0     && nfiscals numeric(1,0)
    this_nNumeras       = 0     && numeras numeric(1,0)
    this_nOpcrs         = 0     && opcrs numeric(1,0)
    this_nOpers         = 0     && opers numeric(1,0)
    this_nOrigems       = 0     && origems numeric(1,0)
    this_nParautos      = 0     && parautos numeric(1,0)
    this_nParcontas     = 0     && parcontas numeric(1,0)
    this_nParcs         = 0     && parcs numeric(1,0)
    this_nParrecals     = 0     && parrecals numeric(1,0)
    this_nPesoauts      = 0     && pesoauts numeric(1,0)
    this_nPesods        = 0     && pesods numeric(1,0)
    this_nPesos         = 0     && pesos numeric(1,0)
    this_nPesovts       = 0     && pesovts numeric(1,0)
    this_nPrecoauts     = 0     && precoauts numeric(1,0)
    this_nPrecods       = 0     && precods numeric(1,0)
    this_nPrecovts      = 0     && precovts numeric(1,0)
    this_nProduc        = 0     && produc numeric(1,0)
    this_nQtdpesos      = 0     && qtdpesos numeric(1,0)
    this_nQtdprecos     = 0     && qtdprecos numeric(1,0)
    this_nQtdrelevs     = 0     && qtdrelevs numeric(1,0)
    this_nRelfechas     = 0     && relfechas numeric(1,0)
    this_nReservas      = 0     && reservas numeric(1,0)
    this_nResults       = 0     && results numeric(1,0)
    this_nSituas        = 0     && situas numeric(1,0)
    this_nSubns         = 0     && subns numeric(1,0)
    this_nTabdescs      = 0     && tabdescs numeric(1,0)
    this_nTransons      = 0     && transons numeric(1,0)
    this_nTransps       = 0     && transps numeric(1,0)
    this_nTranss        = 0     && transs numeric(1,0)
    this_nUnitpesos     = 0     && unitpesos numeric(1,0)
    this_nValests       = 0     && valests numeric(1,0)
    this_nValpends      = 0     && valpends numeric(1,0)
    this_nValpres       = 0     && valpres numeric(1,0)
    this_nVars          = 0     && vars numeric(1,0)
    this_nVendas        = 0     && vendas numeric(1,0)
    this_nVendes        = 0     && vendes numeric(1,0)
    this_nSemetiqs      = 0     && semetiqs numeric(1,0)
    this_nCasas         = 0     && casas numeric(1,0)
    this_nAlttrans      = 0     && alttrans numeric(1,0)
    this_nDadosnotas    = 0     && dadosnotas numeric(1,0)
    this_nObsdests      = 0     && obsdests numeric(1,0)
    this_nObsorigs      = 0     && obsorigs numeric(1,0)
    this_nServicos      = 0     && servicos numeric(1,0)
    this_nSubnobrigs    = 0     && subnobrigs numeric(1,0)
    this_nTphist2s      = 0     && tphist2s numeric(1,0)
    this_nTphists       = 0     && tphists numeric(1,0)
    this_nBlqdatas      = 0     && blqdatas numeric(1,0)
    this_nSenhads       = 0     && senhads numeric(1,0)
    this_nSenhaos       = 0     && senhaos numeric(1,0)
    this_nDemocreds     = 0     && democreds numeric(1,0)
    this_nDigcpfs       = 0     && digcpfs numeric(1,0)
    this_nCongvends     = 0     && congvends numeric(1,0)
    this_nChkqtdss      = 0     && chkqtdss numeric(1,0)
    this_nValitnegs     = 0     && valitnegs numeric(1,0)
    this_nCalcmos       = 0     && calcmos numeric(1,0)
    this_nChkdval       = 0     && chkdval numeric(1,0)
    this_nTabdobrigs    = 0     && tabdobrigs numeric(1,0)
    this_nDtemis        = 0     && dtemis numeric(1,0)
    this_nConprecs      = 0     && conprecs numeric(1,0)
    this_nTrocoauts     = 0     && trocoauts numeric(1,0)
    this_nParczeros     = 0     && parczeros numeric(1,0)
    this_nBxvlopcrs     = 0     && bxvlopcrs numeric(1,0)
    this_nCadcliauts    = 0     && cadcliauts numeric(1,0)
    this_nObsitems      = 0     && obsitems numeric(1,0)
    this_nVaritems      = 0     && varitems numeric(1,0)
    this_nItsituas      = 0     && itsituas numeric(1,0)
    this_nHabsubits     = 0     && habsubits numeric(1,0)
    this_nOppends       = 0     && oppends numeric(1,0)
    this_nCadprods      = 0     && cadprods numeric(1,0)
    this_nSubnautos     = 0     && subnautos numeric(1,0)
    this_nSenhars       = 0     && senhars numeric(1,0)
    this_nTotcompos     = 0     && totcompos numeric(1,0)
    this_nChkedesc      = 0     && chkedesc numeric(1,0)
    this_nNcpesos       = 0     && ncpesos numeric(1,0)
    this_nEditdocs      = 0     && editdocs numeric(1,0)
    this_nCempsubns     = 0     && cempsubns numeric(1,0)
    this_nCarcbars      = 0     && carcbars numeric(1,0)
    this_nCtrllotes     = 0     && ctrllotes numeric(1,0)
    this_nOrilotes      = 0     && orilotes numeric(1,0)
    this_nReffs         = 0     && reffs numeric(1,0)
    this_nCcustos       = 0     && ccustos numeric(1,0)
    this_nDcpns         = 0     && dcpns numeric(1,0)
    this_nDtbars        = 0     && dtbars numeric(1,0)
    this_nAciosens      = 0     && aciosens numeric(1,0)
    this_nCliods        = 0     && cliods numeric(1,0)
    this_nEdcomis       = 0     && edcomis numeric(1,0)
    this_nInfoipis      = 0     && infoipis numeric(1,0)
    this_nAgrupas       = 0     && agrupas numeric(1,0)
    this_nDigenves      = 0     && digenves numeric(1,0)
    this_nDigrecs       = 0     && digrecs numeric(1,0)
    this_nEmpsubns      = 0     && empsubns numeric(1,0)
    this_nFechmals      = 0     && fechmals numeric(1,0)
    this_nHabservs      = 0     && habservs numeric(1,0)
    this_nMarcasubns    = 0     && marcasubns numeric(1,0)
    this_nTiponfs       = 0     && tiponfs numeric(1,0)
    this_nChkacpro      = 0     && chkacpro numeric(1,0)
    this_nEdunis        = 0     && edunis numeric(1,0)
    this_nAnprodzs      = 0     && anprodzs numeric(1,0)
    this_nAutenticas    = 0     && autenticas numeric(1,0)
    this_nAutoins       = 0     && autoins numeric(1,0)
    this_nBxpagos       = 0     && bxpagos numeric(1,0)
    this_nCarvends      = 0     && carvends numeric(1,0)
    this_nCbxsubns      = 0     && cbxsubns numeric(1,0)
    this_nChecpagos     = 0     && checpagos numeric(1,0)
    this_nChkagends     = 0     && chkagends numeric(1,0)
    this_nInibcchqs     = 0     && inibcchqs numeric(1,0)
    this_nInibmens      = 0     && inibmens numeric(1,0)
    this_nInibmlcs      = 0     && inibmlcs numeric(1,0)
    this_nNcarsubs      = 0     && ncarsubs numeric(1,0)
    this_nObrigvd2s     = 0     && obrigvd2s numeric(1,0)
    this_nObrigvds      = 0     && obrigvds numeric(1,0)
    this_nTplprecs      = 0     && tplprecs numeric(1,0)
    this_nFpubl         = 0     && fpubl numeric(1,0)
    this_nNfcompls      = 0     && nfcompls numeric(1,0)
    *-- numeric(2,0)
    this_nDocus         = 0     && docus numeric(2,0)
    this_nItautos       = 0     && itautos numeric(2,0)
    this_nPrecops       = 0     && precops numeric(2,0)
    this_nComisdivs     = 0     && comisdivs numeric(2,0)
    this_nTipoops       = 0     && tipoops numeric(2,0)
    this_nTrnfis        = 0     && trnfis numeric(2,0)
    *-- numeric(3,0)
    this_nObspads       = 0     && obspads numeric(3,0)
    this_nObsfins       = 0     && obsfins numeric(3,0)
    this_nObsinis       = 0     && obsinis numeric(3,0)
    this_nCdopes        = 0     && cdopes numeric(3,0)
    *-- numeric(4,0)
    this_nNdopes        = 0     && ndopes numeric(4,0)
    this_nOrdes         = 0     && ordes numeric(4,0)
    this_nQtdites       = 0     && qtdites numeric(4,0)
    *-- numeric(5,2)
    this_nPorcs         = 0     && porcs numeric(5,2)
    this_nVcompensas    = 0     && vcompensas numeric(5,2)
    *-- bit columns
    this_lFixcdests     = .F.   && fixcdests bit
    this_lFixcnopes     = .F.   && fixcnopes bit
    this_lFixcorigs     = .F.   && fixcorigs bit
    this_lFixgdests     = .F.   && fixgdests bit
    this_lFixgorigs     = .F.   && fixgorigs bit
    this_lFixgropes     = .F.   && fixgropes bit
    this_lFixgvends     = .F.   && fixgvends bit
    this_lChkfunds      = .F.   && chkfunds bit
    this_lFixgven2s     = .F.   && fixgven2s bit
    *-- datetime
    this_dDatatrans     = {}    && datatrans datetime
    *-- char columns
    this_cDopeetrfs     = ""    && dopeetrfs char(20)
    this_cAbrevs        = ""    && abrevs char(3)
    this_cCcentrals     = ""    && ccentrals char(2)
    this_cCmoes         = ""    && cmoes char(3)
    this_cCnopes        = ""    && cnopes char(10)
    this_cCondests      = ""    && condests char(10)
    this_cConorigs      = ""    && conorigs char(10)
    this_cContas        = ""    && contas char(10)
    this_cEmppads       = ""    && emppads char(3)
    this_cGrudests      = ""    && grudests char(10)
    this_cGruorigs      = ""    && gruorigs char(10)
    this_cGrupos        = ""    && grupos char(10)
    this_cGrvends       = ""    && grvends char(20)
    this_cMenus         = ""    && menus char(10)
    this_cNivels        = ""    && nivels char(20)
    this_cNopcrs        = ""    && nopcrs char(20)
    this_cTabdps        = ""    && tabdps char(10)
    this_cDopcs         = ""    && dopcs char(20)
    this_cEspecies      = ""    && especies char(6)
    this_cSeries        = ""    && series char(3)
    this_cHist2s        = ""    && hist2s char(30)
    this_cHists         = ""    && hists char(30)
    this_cSubmenus      = ""    && submenus char(15)
    this_cGrucados      = ""    && grucados char(10)
    this_cGrucadds      = ""    && grucadds char(10)
    this_cGrucadvs      = ""    && grucadvs char(20)
    this_cCfos          = ""    && cfos char(10)
    this_cRelfechgrs    = ""    && relfechgrs char(2)
    this_cTitopes       = ""    && titopes char(30)
    this_cDopestrfs     = ""    && dopestrfs char(20)
    this_cOperchqes     = ""    && operchqes char(15)
    this_cOperchqss     = ""    && operchqss char(15)
    this_cGremiss       = ""    && gremiss char(10)
    this_cConemiss      = ""    && conemiss char(10)
    this_cOperfisics    = ""    && operfisics char(2)
    this_cCodpropads    = ""    && codpropads char(14)
    this_cFpagopcrs     = ""    && fpagopcrs char(12)
    this_cLprecopads    = ""    && lprecopads char(30)
    this_cMascvens      = ""    && mascvens char(20)
    this_cImpclis       = ""    && impclis char(1)
    this_cOpernf        = ""    && opernf char(2)
    this_cCodconpads    = ""    && codconpads char(10)
    this_cEmpbxs        = ""    && empbxs char(3)
    this_cEmplancs      = ""    && emplancs char(3)
    this_cOpepads       = ""    && opepads char(1)
    this_cProgramas     = ""    && programas char(15)
    this_cCtipomarms    = ""    && ctipomarms char(1) NULL
    this_cCarqicones    = ""    && carqicones char(64) NULL
    this_cDopcreds      = ""    && dopcreds char(20)
    this_cCfgfinancs    = ""    && cfgfinancs char(20)
    *-- text/memo
    this_mObsopes       = ""    && obsopes text

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        IF !DODEFAULT()
            RETURN .F.
        ENDIF
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_BuscaOPE")
                USE IN SELECT("cursor_4c_BuscaOPE")
            ENDIF
            loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                       "FROM SigCdOpe a"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOPE")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro em Buscar")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Buscar")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_OPE_tmp")
                USE IN SELECT("cursor_4c_OPE_tmp")
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE dopes = " + EscaparSQL(par_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPE_tmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_OPE_tmp")
                THIS.CarregarDoCursor("cursor_4c_OPE_tmp")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_OPE_tmp")
                USE IN SELECT("cursor_4c_OPE_tmp")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarPorCodigo")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- PK
                THIS.this_cDopes         = ALLTRIM(dopes)
                *-- char
                THIS.this_cTitopes       = ALLTRIM(titopes)
                THIS.this_cAbrevs        = ALLTRIM(abrevs)
                THIS.this_cCcentrals     = ALLTRIM(ccentrals)
                THIS.this_cCmoes         = ALLTRIM(cmoes)
                THIS.this_cCnopes        = ALLTRIM(cnopes)
                THIS.this_cCondests      = ALLTRIM(condests)
                THIS.this_cConorigs      = ALLTRIM(conorigs)
                THIS.this_cContas        = ALLTRIM(contas)
                THIS.this_cEmppads       = ALLTRIM(emppads)
                THIS.this_cGrudests      = ALLTRIM(grudests)
                THIS.this_cGruorigs      = ALLTRIM(gruorigs)
                THIS.this_cGrupos        = ALLTRIM(grupos)
                THIS.this_cGrvends       = ALLTRIM(grvends)
                THIS.this_cMenus         = ALLTRIM(menus)
                THIS.this_cNivels        = ALLTRIM(nivels)
                THIS.this_cNopcrs        = ALLTRIM(nopcrs)
                THIS.this_cTabdps        = ALLTRIM(tabdps)
                THIS.this_cDopcs         = ALLTRIM(dopcs)
                THIS.this_cEspecies      = ALLTRIM(especies)
                THIS.this_cSeries        = ALLTRIM(series)
                THIS.this_cHist2s        = ALLTRIM(hist2s)
                THIS.this_cHists         = ALLTRIM(hists)
                THIS.this_cSubmenus      = ALLTRIM(submenus)
                THIS.this_cGrucados      = ALLTRIM(grucados)
                THIS.this_cGrucadds      = ALLTRIM(grucadds)
                THIS.this_cGrucadvs      = ALLTRIM(grucadvs)
                THIS.this_cCfos          = ALLTRIM(cfos)
                THIS.this_cRelfechgrs    = ALLTRIM(relfechgrs)
                THIS.this_cDopeetrfs     = ALLTRIM(dopeetrfs)
                THIS.this_cDopestrfs     = ALLTRIM(dopestrfs)
                THIS.this_cOperchqes     = ALLTRIM(operchqes)
                THIS.this_cOperchqss     = ALLTRIM(operchqss)
                THIS.this_cGremiss       = ALLTRIM(gremiss)
                THIS.this_cConemiss      = ALLTRIM(conemiss)
                THIS.this_cOperfisics    = ALLTRIM(operfisics)
                THIS.this_cCodpropads    = ALLTRIM(codpropads)
                THIS.this_cFpagopcrs     = ALLTRIM(fpagopcrs)
                THIS.this_cLprecopads    = ALLTRIM(lprecopads)
                THIS.this_cMascvens      = ALLTRIM(mascvens)
                THIS.this_cImpclis       = ALLTRIM(impclis)
                THIS.this_cOpernf        = ALLTRIM(opernf)
                THIS.this_cCodconpads    = ALLTRIM(codconpads)
                THIS.this_cEmpbxs        = ALLTRIM(empbxs)
                THIS.this_cEmplancs      = ALLTRIM(emplancs)
                THIS.this_cOpepads       = ALLTRIM(opepads)
                THIS.this_cProgramas     = ALLTRIM(programas)
                THIS.this_cCtipomarms    = ALLTRIM(NVL(ctipomarms, ""))
                THIS.this_cCarqicones    = ALLTRIM(NVL(carqicones, ""))
                THIS.this_cDopcreds      = ALLTRIM(dopcreds)
                THIS.this_cCfgfinancs    = ALLTRIM(cfgfinancs)
                *-- numeric(1,0)
                THIS.this_nPedclis       = pedclis
                THIS.this_nZerqtds       = zerqtds
                THIS.this_nValinotas     = valinotas
                THIS.this_nValitems      = valitems
                THIS.this_nExibsits      = exibsits
                THIS.this_nChkqtds       = chkqtds
                THIS.this_nDtcontab      = dtcontab
                THIS.this_nAltdescs      = altdescs
                THIS.this_nAntecs        = antecs
                THIS.this_nAptpfats      = aptpfats
                THIS.this_nArreds        = arreds
                THIS.this_nBaixasns      = baixasns
                THIS.this_nBxautos       = bxautos
                THIS.this_nBxparcials    = bxparcials
                THIS.this_nCadclis       = cadclis
                THIS.this_nCaixas        = caixas
                THIS.this_nCalcfecs      = calcfecs
                THIS.this_nCarnes        = carnes
                THIS.this_nCcomis        = ccomis
                THIS.this_nCdesps        = cdesps
                THIS.this_nChdtentrs     = chdtentrs
                THIS.this_nCheqs         = cheqs
                THIS.this_nCodbars       = codbars
                THIS.this_nComcargs      = comcargs
                THIS.this_nCondsubs      = condsubs
                THIS.this_nConfes        = confes
                THIS.this_nConosubs      = conosubs
                THIS.this_nConsclis      = consclis
                THIS.this_nConsers       = consers
                THIS.this_nConsgs        = consgs
                THIS.this_nCopers        = copers
                THIS.this_nCrepls        = crepls
                THIS.this_nCtipos        = ctipos
                THIS.this_nCupfis        = cupfis
                THIS.this_nDeacrs        = deacrs
                THIS.this_nDesmembs      = desmembs
                THIS.this_nDestinos      = destinos
                THIS.this_nDfpags        = dfpags
                THIS.this_nDigdoc        = digdoc
                THIS.this_nDigitens      = digitens
                THIS.this_nDigobs        = digobs
                THIS.this_nDtentrs       = dtentrs
                THIS.this_nEdcotas       = edcotas
                THIS.this_nEdtpfats      = edtpfats
                THIS.this_nEfators       = efators
                THIS.this_nEpesos        = epesos
                THIS.this_nEprecos       = eprecos
                THIS.this_nEstdests      = estdests
                THIS.this_nEstoqs        = estoqs
                THIS.this_nEstorigs      = estorigs
                THIS.this_nExpends       = expends
                THIS.this_nFatauts       = fatauts
                THIS.this_nGlobalizas    = globalizas
                THIS.this_nImagems       = imagems
                THIS.this_nItemalfas     = itemalfas
                THIS.this_nItemzeros     = itemzeros
                THIS.this_nLimcres       = limcres
                THIS.this_nLimpauts      = limpauts
                THIS.this_nLprecos       = lprecos
                THIS.this_nMestoqs       = mestoqs
                THIS.this_nNdebitos      = ndebitos
                THIS.this_nNfiscals      = nfiscals
                THIS.this_nNumeras       = numeras
                THIS.this_nOpcrs         = opcrs
                THIS.this_nOpers         = opers
                THIS.this_nOrigems       = origems
                THIS.this_nParautos      = parautos
                THIS.this_nParcontas     = parcontas
                THIS.this_nParcs         = parcs
                THIS.this_nParrecals     = parrecals
                THIS.this_nPesoauts      = pesoauts
                THIS.this_nPesods        = pesods
                THIS.this_nPesos         = pesos
                THIS.this_nPesovts       = pesovts
                THIS.this_nPrecoauts     = precoauts
                THIS.this_nPrecods       = precods
                THIS.this_nPrecovts      = precovts
                THIS.this_nProduc        = produc
                THIS.this_nQtdpesos      = qtdpesos
                THIS.this_nQtdprecos     = qtdprecos
                THIS.this_nQtdrelevs     = qtdrelevs
                THIS.this_nRelfechas     = relfechas
                THIS.this_nReservas      = reservas
                THIS.this_nResults       = results
                THIS.this_nSituas        = situas
                THIS.this_nSubns         = subns
                THIS.this_nTabdescs      = tabdescs
                THIS.this_nTransons      = transons
                THIS.this_nTransps       = transps
                THIS.this_nTranss        = transs
                THIS.this_nUnitpesos     = unitpesos
                THIS.this_nValests       = valests
                THIS.this_nValpends      = valpends
                THIS.this_nValpres       = valpres
                THIS.this_nVars          = vars
                THIS.this_nVendas        = vendas
                THIS.this_nVendes        = vendes
                THIS.this_nSemetiqs      = semetiqs
                THIS.this_nCasas         = casas
                THIS.this_nAlttrans      = alttrans
                THIS.this_nDadosnotas    = dadosnotas
                THIS.this_nObsdests      = obsdests
                THIS.this_nObsorigs      = obsorigs
                THIS.this_nServicos      = servicos
                THIS.this_nSubnobrigs    = subnobrigs
                THIS.this_nTphist2s      = tphist2s
                THIS.this_nTphists       = tphists
                THIS.this_nBlqdatas      = blqdatas
                THIS.this_nSenhads       = senhads
                THIS.this_nSenhaos       = senhaos
                THIS.this_nDemocreds     = democreds
                THIS.this_nDigcpfs       = digcpfs
                THIS.this_nCongvends     = congvends
                THIS.this_nChkqtdss      = chkqtdss
                THIS.this_nValitnegs     = valitnegs
                THIS.this_nCalcmos       = calcmos
                THIS.this_nChkdval       = chkdval
                THIS.this_nTabdobrigs    = tabdobrigs
                THIS.this_nDtemis        = dtemis
                THIS.this_nConprecs      = conprecs
                THIS.this_nTrocoauts     = trocoauts
                THIS.this_nParczeros     = parczeros
                THIS.this_nBxvlopcrs     = bxvlopcrs
                THIS.this_nCadcliauts    = cadcliauts
                THIS.this_nObsitems      = obsitems
                THIS.this_nVaritems      = varitems
                THIS.this_nItsituas      = itsituas
                THIS.this_nHabsubits     = habsubits
                THIS.this_nOppends       = oppends
                THIS.this_nCadprods      = cadprods
                THIS.this_nSubnautos     = subnautos
                THIS.this_nSenhars       = senhars
                THIS.this_nTotcompos     = totcompos
                THIS.this_nChkedesc      = chkedesc
                THIS.this_nNcpesos       = ncpesos
                THIS.this_nEditdocs      = editdocs
                THIS.this_nCempsubns     = cempsubns
                THIS.this_nCarcbars      = carcbars
                THIS.this_nCtrllotes     = ctrllotes
                THIS.this_nOrilotes      = orilotes
                THIS.this_nReffs         = reffs
                THIS.this_nCcustos       = ccustos
                THIS.this_nDcpns         = dcpns
                THIS.this_nDtbars        = dtbars
                THIS.this_nAciosens      = aciosens
                THIS.this_nCliods        = cliods
                THIS.this_nEdcomis       = edcomis
                THIS.this_nInfoipis      = infoipis
                THIS.this_nAgrupas       = agrupas
                THIS.this_nDigenves      = digenves
                THIS.this_nDigrecs       = digrecs
                THIS.this_nEmpsubns      = empsubns
                THIS.this_nFechmals      = fechmals
                THIS.this_nHabservs      = habservs
                THIS.this_nMarcasubns    = marcasubns
                THIS.this_nTiponfs       = tiponfs
                THIS.this_nChkacpro      = chkacpro
                THIS.this_nEdunis        = edunis
                THIS.this_nAnprodzs      = anprodzs
                THIS.this_nAutenticas    = autenticas
                THIS.this_nAutoins       = autoins
                THIS.this_nBxpagos       = bxpagos
                THIS.this_nCarvends      = carvends
                THIS.this_nCbxsubns      = cbxsubns
                THIS.this_nChecpagos     = checpagos
                THIS.this_nChkagends     = chkagends
                THIS.this_nInibcchqs     = inibcchqs
                THIS.this_nInibmens      = inibmens
                THIS.this_nInibmlcs      = inibmlcs
                THIS.this_nNcarsubs      = ncarsubs
                THIS.this_nObrigvd2s     = obrigvd2s
                THIS.this_nObrigvds      = obrigvds
                THIS.this_nTplprecs      = tplprecs
                THIS.this_nFpubl         = fpubl
                THIS.this_nNfcompls      = nfcompls
                *-- numeric(2,0)
                THIS.this_nDocus         = docus
                THIS.this_nItautos       = itautos
                THIS.this_nPrecops       = precops
                THIS.this_nComisdivs     = comisdivs
                THIS.this_nTipoops       = tipoops
                THIS.this_nTrnfis        = trnfis
                *-- numeric(3,0)
                THIS.this_nObspads       = obspads
                THIS.this_nObsfins       = obsfins
                THIS.this_nObsinis       = obsinis
                THIS.this_nCdopes        = cdopes
                *-- numeric(4,0)
                THIS.this_nNdopes        = ndopes
                THIS.this_nOrdes         = ordes
                THIS.this_nQtdites       = qtdites
                *-- numeric(5,2)
                THIS.this_nPorcs         = porcs
                THIS.this_nVcompensas    = vcompensas
                *-- bit (SQL Server bit -> VFP numeric 0/1 -> logical)
                THIS.this_lFixcdests     = (fixcdests = 1)
                THIS.this_lFixcnopes     = (fixcnopes = 1)
                THIS.this_lFixcorigs     = (fixcorigs = 1)
                THIS.this_lFixgdests     = (fixgdests = 1)
                THIS.this_lFixgorigs     = (fixgorigs = 1)
                THIS.this_lFixgropes     = (fixgropes = 1)
                THIS.this_lFixgvends     = (fixgvends = 1)
                THIS.this_lChkfunds      = (chkfunds = 1)
                THIS.this_lFixgven2s     = (fixgven2s = 1)
                *-- datetime
                THIS.this_dDatatrans     = datatrans
                *-- text/memo
                THIS.this_mObsopes       = ALLTRIM(obsopes)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCols, loc_cVals, loc_nResult
        LOCAL loc_cDatatrans
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("I")
            IF EMPTY(THIS.this_dDatatrans)
                loc_cDatatrans = "NULL"
            ELSE
                loc_cDatatrans = FormatarDataSQL(THIS.this_dDatatrans)
            ENDIF
            loc_cCols = "dopes, titopes, tipoops, situas, opers, pedclis, zerqtds, valinotas, " + ;
                        "valitems, exibsits, chkqtds, dtcontab, altdescs, antecs, aptpfats, arreds, " + ;
                        "baixasns, bxautos, bxparcials, cadclis, caixas, calcfecs, carnes, ccomis, " + ;
                        "cdesps, chdtentrs, cheqs, codbars, comcargs, condsubs, confes, conosubs, " + ;
                        "consclis, consers, consgs, copers, crepls, ctipos, cupfis, deacrs, " + ;
                        "desmembs, destinos, dfpags, digdoc, digitens, digobs, dtentrs, edcotas, " + ;
                        "edtpfats, efators, epesos, eprecos, estdests, estoqs, estorigs, expends, " + ;
                        "fatauts, globalizas, imagems, itemalfas, itemzeros, limcres, limpauts, " + ;
                        "lprecos, mestoqs, ndebitos, nfiscals, numeras, opcrs, origems, parautos, " + ;
                        "parcontas, parcs, parrecals, pesoauts, pesods, pesos, pesovts, precoauts, " + ;
                        "precods, precovts, produc, qtdpesos, qtdprecos, qtdrelevs, relfechas, " + ;
                        "reservas, results, subns, tabdescs, transons, transps, transs, unitpesos, " + ;
                        "valests, valpends, valpres, vars, vendas, vendes, semetiqs, casas, " + ;
                        "alttrans, dadosnotas, obsdests, obsorigs, servicos, subnobrigs, tphist2s, " + ;
                        "tphists, blqdatas, senhads, senhaos, democreds, digcpfs, congvends, " + ;
                        "chkqtdss, valitnegs, calcmos, chkdval, tabdobrigs, dtemis, conprecs, " + ;
                        "trocoauts, parczeros, bxvlopcrs, cadcliauts, obsitems, varitems, itsituas, " + ;
                        "habsubits, oppends, cadprods, subnautos, senhars, totcompos, chkedesc, " + ;
                        "ncpesos, editdocs, cempsubns, carcbars, ctrllotes, orilotes, reffs, " + ;
                        "ccustos, dcpns, dtbars, aciosens, cliods, edcomis, infoipis, agrupas, " + ;
                        "digenves, digrecs, empsubns, fechmals, habservs, marcasubns, tiponfs, " + ;
                        "chkacpro, edunis, anprodzs, autenticas, autoins, bxpagos, carvends, " + ;
                        "cbxsubns, checpagos, chkagends, inibcchqs, inibmens, inibmlcs, ncarsubs, " + ;
                        "obrigvd2s, obrigvds, tplprecs, fpubl, nfcompls, " + ;
                        "docus, itautos, precops, comisdivs, trnfis, " + ;
                        "obspads, obsfins, obsinis, cdopes, " + ;
                        "ndopes, ordes, qtdites, " + ;
                        "porcs, vcompensas, " + ;
                        "fixcdests, fixcnopes, fixcorigs, fixgdests, fixgorigs, fixgropes, fixgvends, " + ;
                        "chkfunds, fixgven2s, datatrans, " + ;
                        "dopeetrfs, abrevs, ccentrals, cmoes, cnopes, condests, conorigs, contas, " + ;
                        "emppads, grudests, gruorigs, grupos, grvends, menus, nivels, nopcrs, " + ;
                        "tabdps, dopcs, especies, series, hist2s, hists, submenus, grucados, " + ;
                        "grucadds, grucadvs, cfos, relfechgrs, dopestrfs, operchqes, operchqss, " + ;
                        "gremiss, conemiss, operfisics, codpropads, fpagopcrs, lprecopads, " + ;
                        "mascvens, impclis, opernf, codconpads, empbxs, emplancs, opepads, " + ;
                        "programas, ctipomarms, carqicones, dopcreds, cfgfinancs, obsopes"
            loc_cVals = EscaparSQL(THIS.this_cDopes) + ", " + ;
                        EscaparSQL(THIS.this_cTitopes) + ", " + ;
                        TRANSFORM(THIS.this_nTipoops) + ", " + ;
                        TRANSFORM(THIS.this_nSituas) + ", " + ;
                        TRANSFORM(THIS.this_nOpers) + ", " + ;
                        TRANSFORM(THIS.this_nPedclis) + ", " + ;
                        TRANSFORM(THIS.this_nZerqtds) + ", " + ;
                        TRANSFORM(THIS.this_nValinotas) + ", " + ;
                        TRANSFORM(THIS.this_nValitems) + ", " + ;
                        TRANSFORM(THIS.this_nExibsits) + ", " + ;
                        TRANSFORM(THIS.this_nChkqtds) + ", " + ;
                        TRANSFORM(THIS.this_nDtcontab) + ", " + ;
                        TRANSFORM(THIS.this_nAltdescs) + ", " + ;
                        TRANSFORM(THIS.this_nAntecs) + ", " + ;
                        TRANSFORM(THIS.this_nAptpfats) + ", " + ;
                        TRANSFORM(THIS.this_nArreds) + ", " + ;
                        TRANSFORM(THIS.this_nBaixasns) + ", " + ;
                        TRANSFORM(THIS.this_nBxautos) + ", " + ;
                        TRANSFORM(THIS.this_nBxparcials) + ", " + ;
                        TRANSFORM(THIS.this_nCadclis) + ", " + ;
                        TRANSFORM(THIS.this_nCaixas) + ", " + ;
                        TRANSFORM(THIS.this_nCalcfecs) + ", " + ;
                        TRANSFORM(THIS.this_nCarnes) + ", " + ;
                        TRANSFORM(THIS.this_nCcomis) + ", " + ;
                        TRANSFORM(THIS.this_nCdesps) + ", " + ;
                        TRANSFORM(THIS.this_nChdtentrs) + ", " + ;
                        TRANSFORM(THIS.this_nCheqs) + ", " + ;
                        TRANSFORM(THIS.this_nCodbars) + ", " + ;
                        TRANSFORM(THIS.this_nComcargs) + ", " + ;
                        TRANSFORM(THIS.this_nCondsubs) + ", " + ;
                        TRANSFORM(THIS.this_nConfes) + ", " + ;
                        TRANSFORM(THIS.this_nConosubs) + ", " + ;
                        TRANSFORM(THIS.this_nConsclis) + ", " + ;
                        TRANSFORM(THIS.this_nConsers) + ", " + ;
                        TRANSFORM(THIS.this_nConsgs) + ", " + ;
                        TRANSFORM(THIS.this_nCopers) + ", " + ;
                        TRANSFORM(THIS.this_nCrepls) + ", " + ;
                        TRANSFORM(THIS.this_nCtipos) + ", " + ;
                        TRANSFORM(THIS.this_nCupfis) + ", " + ;
                        TRANSFORM(THIS.this_nDeacrs) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nDesmembs) + ", " + ;
                        TRANSFORM(THIS.this_nDestinos) + ", " + ;
                        TRANSFORM(THIS.this_nDfpags) + ", " + ;
                        TRANSFORM(THIS.this_nDigdoc) + ", " + ;
                        TRANSFORM(THIS.this_nDigitens) + ", " + ;
                        TRANSFORM(THIS.this_nDigobs) + ", " + ;
                        TRANSFORM(THIS.this_nDtentrs) + ", " + ;
                        TRANSFORM(THIS.this_nEdcotas) + ", " + ;
                        TRANSFORM(THIS.this_nEdtpfats) + ", " + ;
                        TRANSFORM(THIS.this_nEfators) + ", " + ;
                        TRANSFORM(THIS.this_nEpesos) + ", " + ;
                        TRANSFORM(THIS.this_nEprecos) + ", " + ;
                        TRANSFORM(THIS.this_nEstdests) + ", " + ;
                        TRANSFORM(THIS.this_nEstoqs) + ", " + ;
                        TRANSFORM(THIS.this_nEstorigs) + ", " + ;
                        TRANSFORM(THIS.this_nExpends) + ", " + ;
                        TRANSFORM(THIS.this_nFatauts) + ", " + ;
                        TRANSFORM(THIS.this_nGlobalizas) + ", " + ;
                        TRANSFORM(THIS.this_nImagems) + ", " + ;
                        TRANSFORM(THIS.this_nItemalfas) + ", " + ;
                        TRANSFORM(THIS.this_nItemzeros) + ", " + ;
                        TRANSFORM(THIS.this_nLimcres) + ", " + ;
                        TRANSFORM(THIS.this_nLimpauts) + ", " + ;
                        TRANSFORM(THIS.this_nLprecos) + ", " + ;
                        TRANSFORM(THIS.this_nMestoqs) + ", " + ;
                        TRANSFORM(THIS.this_nNdebitos) + ", " + ;
                        TRANSFORM(THIS.this_nNfiscals) + ", " + ;
                        TRANSFORM(THIS.this_nNumeras) + ", " + ;
                        TRANSFORM(THIS.this_nOpcrs) + ", " + ;
                        TRANSFORM(THIS.this_nOrigems) + ", " + ;
                        TRANSFORM(THIS.this_nParautos) + ", " + ;
                        TRANSFORM(THIS.this_nParcontas) + ", " + ;
                        TRANSFORM(THIS.this_nParcs) + ", " + ;
                        TRANSFORM(THIS.this_nParrecals) + ", " + ;
                        TRANSFORM(THIS.this_nPesoauts) + ", " + ;
                        TRANSFORM(THIS.this_nPesods) + ", " + ;
                        TRANSFORM(THIS.this_nPesos) + ", " + ;
                        TRANSFORM(THIS.this_nPesovts) + ", " + ;
                        TRANSFORM(THIS.this_nPrecoauts) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nPrecods) + ", " + ;
                        TRANSFORM(THIS.this_nPrecovts) + ", " + ;
                        TRANSFORM(THIS.this_nProduc) + ", " + ;
                        TRANSFORM(THIS.this_nQtdpesos) + ", " + ;
                        TRANSFORM(THIS.this_nQtdprecos) + ", " + ;
                        TRANSFORM(THIS.this_nQtdrelevs) + ", " + ;
                        TRANSFORM(THIS.this_nRelfechas) + ", " + ;
                        TRANSFORM(THIS.this_nReservas) + ", " + ;
                        TRANSFORM(THIS.this_nResults) + ", " + ;
                        TRANSFORM(THIS.this_nSubns) + ", " + ;
                        TRANSFORM(THIS.this_nTabdescs) + ", " + ;
                        TRANSFORM(THIS.this_nTransons) + ", " + ;
                        TRANSFORM(THIS.this_nTransps) + ", " + ;
                        TRANSFORM(THIS.this_nTranss) + ", " + ;
                        TRANSFORM(THIS.this_nUnitpesos) + ", " + ;
                        TRANSFORM(THIS.this_nValests) + ", " + ;
                        TRANSFORM(THIS.this_nValpends) + ", " + ;
                        TRANSFORM(THIS.this_nValpres) + ", " + ;
                        TRANSFORM(THIS.this_nVars) + ", " + ;
                        TRANSFORM(THIS.this_nVendas) + ", " + ;
                        TRANSFORM(THIS.this_nVendes) + ", " + ;
                        TRANSFORM(THIS.this_nSemetiqs) + ", " + ;
                        TRANSFORM(THIS.this_nCasas) + ", " + ;
                        TRANSFORM(THIS.this_nAlttrans) + ", " + ;
                        TRANSFORM(THIS.this_nDadosnotas) + ", " + ;
                        TRANSFORM(THIS.this_nObsdests) + ", " + ;
                        TRANSFORM(THIS.this_nObsorigs) + ", " + ;
                        TRANSFORM(THIS.this_nServicos) + ", " + ;
                        TRANSFORM(THIS.this_nSubnobrigs) + ", " + ;
                        TRANSFORM(THIS.this_nTphist2s) + ", " + ;
                        TRANSFORM(THIS.this_nTphists) + ", " + ;
                        TRANSFORM(THIS.this_nBlqdatas) + ", " + ;
                        TRANSFORM(THIS.this_nSenhads) + ", " + ;
                        TRANSFORM(THIS.this_nSenhaos) + ", " + ;
                        TRANSFORM(THIS.this_nDemocreds) + ", " + ;
                        TRANSFORM(THIS.this_nDigcpfs) + ", " + ;
                        TRANSFORM(THIS.this_nCongvends) + ", " + ;
                        TRANSFORM(THIS.this_nChkqtdss) + ", " + ;
                        TRANSFORM(THIS.this_nValitnegs) + ", " + ;
                        TRANSFORM(THIS.this_nCalcmos) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nChkdval) + ", " + ;
                        TRANSFORM(THIS.this_nTabdobrigs) + ", " + ;
                        TRANSFORM(THIS.this_nDtemis) + ", " + ;
                        TRANSFORM(THIS.this_nConprecs) + ", " + ;
                        TRANSFORM(THIS.this_nTrocoauts) + ", " + ;
                        TRANSFORM(THIS.this_nParczeros) + ", " + ;
                        TRANSFORM(THIS.this_nBxvlopcrs) + ", " + ;
                        TRANSFORM(THIS.this_nCadcliauts) + ", " + ;
                        TRANSFORM(THIS.this_nObsitems) + ", " + ;
                        TRANSFORM(THIS.this_nVaritems) + ", " + ;
                        TRANSFORM(THIS.this_nItsituas) + ", " + ;
                        TRANSFORM(THIS.this_nHabsubits) + ", " + ;
                        TRANSFORM(THIS.this_nOppends) + ", " + ;
                        TRANSFORM(THIS.this_nCadprods) + ", " + ;
                        TRANSFORM(THIS.this_nSubnautos) + ", " + ;
                        TRANSFORM(THIS.this_nSenhars) + ", " + ;
                        TRANSFORM(THIS.this_nTotcompos) + ", " + ;
                        TRANSFORM(THIS.this_nChkedesc) + ", " + ;
                        TRANSFORM(THIS.this_nNcpesos) + ", " + ;
                        TRANSFORM(THIS.this_nEditdocs) + ", " + ;
                        TRANSFORM(THIS.this_nCempsubns) + ", " + ;
                        TRANSFORM(THIS.this_nCarcbars) + ", " + ;
                        TRANSFORM(THIS.this_nCtrllotes) + ", " + ;
                        TRANSFORM(THIS.this_nOrilotes) + ", " + ;
                        TRANSFORM(THIS.this_nReffs) + ", " + ;
                        TRANSFORM(THIS.this_nCcustos) + ", " + ;
                        TRANSFORM(THIS.this_nDcpns) + ", " + ;
                        TRANSFORM(THIS.this_nDtbars) + ", " + ;
                        TRANSFORM(THIS.this_nAciosens) + ", " + ;
                        TRANSFORM(THIS.this_nCliods) + ", " + ;
                        TRANSFORM(THIS.this_nEdcomis) + ", " + ;
                        TRANSFORM(THIS.this_nInfoipis) + ", " + ;
                        TRANSFORM(THIS.this_nAgrupas) + ", " + ;
                        TRANSFORM(THIS.this_nDigenves) + ", " + ;
                        TRANSFORM(THIS.this_nDigrecs) + ", " + ;
                        TRANSFORM(THIS.this_nEmpsubns) + ", " + ;
                        TRANSFORM(THIS.this_nFechmals) + ", " + ;
                        TRANSFORM(THIS.this_nHabservs) + ", " + ;
                        TRANSFORM(THIS.this_nMarcasubns) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nTiponfs) + ", " + ;
                        TRANSFORM(THIS.this_nChkacpro) + ", " + ;
                        TRANSFORM(THIS.this_nEdunis) + ", " + ;
                        TRANSFORM(THIS.this_nAnprodzs) + ", " + ;
                        TRANSFORM(THIS.this_nAutenticas) + ", " + ;
                        TRANSFORM(THIS.this_nAutoins) + ", " + ;
                        TRANSFORM(THIS.this_nBxpagos) + ", " + ;
                        TRANSFORM(THIS.this_nCarvends) + ", " + ;
                        TRANSFORM(THIS.this_nCbxsubns) + ", " + ;
                        TRANSFORM(THIS.this_nChecpagos) + ", " + ;
                        TRANSFORM(THIS.this_nChkagends) + ", " + ;
                        TRANSFORM(THIS.this_nInibcchqs) + ", " + ;
                        TRANSFORM(THIS.this_nInibmens) + ", " + ;
                        TRANSFORM(THIS.this_nInibmlcs) + ", " + ;
                        TRANSFORM(THIS.this_nNcarsubs) + ", " + ;
                        TRANSFORM(THIS.this_nObrigvd2s) + ", " + ;
                        TRANSFORM(THIS.this_nObrigvds) + ", " + ;
                        TRANSFORM(THIS.this_nTplprecs) + ", " + ;
                        TRANSFORM(THIS.this_nFpubl) + ", " + ;
                        TRANSFORM(THIS.this_nNfcompls) + ", " + ;
                        TRANSFORM(THIS.this_nDocus) + ", " + ;
                        TRANSFORM(THIS.this_nItautos) + ", " + ;
                        TRANSFORM(THIS.this_nPrecops) + ", " + ;
                        TRANSFORM(THIS.this_nComisdivs) + ", " + ;
                        TRANSFORM(THIS.this_nTrnfis) + ", " + ;
                        TRANSFORM(THIS.this_nObspads) + ", " + ;
                        TRANSFORM(THIS.this_nObsfins) + ", " + ;
                        TRANSFORM(THIS.this_nObsinis) + ", " + ;
                        TRANSFORM(THIS.this_nCdopes) + ", " + ;
                        TRANSFORM(THIS.this_nNdopes) + ", " + ;
                        TRANSFORM(THIS.this_nOrdes) + ", " + ;
                        TRANSFORM(THIS.this_nQtdites) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPorcs) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nVcompensas) + ", " + ;
                        IIF(THIS.this_lFixcdests, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixcnopes, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixcorigs, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgdests, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgorigs, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgropes, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgvends, "1", "0") + ", " + ;
                        IIF(THIS.this_lChkfunds,  "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgven2s, "1", "0") + ", " + ;
                        loc_cDatatrans + ", "
            loc_cVals = loc_cVals + ;
                        EscaparSQL(THIS.this_cDopeetrfs) + ", " + ;
                        EscaparSQL(THIS.this_cAbrevs) + ", " + ;
                        EscaparSQL(THIS.this_cCcentrals) + ", " + ;
                        EscaparSQL(THIS.this_cCmoes) + ", " + ;
                        EscaparSQL(THIS.this_cCnopes) + ", " + ;
                        EscaparSQL(THIS.this_cCondests) + ", " + ;
                        EscaparSQL(THIS.this_cConorigs) + ", " + ;
                        EscaparSQL(THIS.this_cContas) + ", " + ;
                        EscaparSQL(THIS.this_cEmppads) + ", " + ;
                        EscaparSQL(THIS.this_cGrudests) + ", " + ;
                        EscaparSQL(THIS.this_cGruorigs) + ", " + ;
                        EscaparSQL(THIS.this_cGrupos) + ", " + ;
                        EscaparSQL(THIS.this_cGrvends) + ", " + ;
                        EscaparSQL(THIS.this_cMenus) + ", " + ;
                        EscaparSQL(THIS.this_cNivels) + ", " + ;
                        EscaparSQL(THIS.this_cNopcrs) + ", " + ;
                        EscaparSQL(THIS.this_cTabdps) + ", " + ;
                        EscaparSQL(THIS.this_cDopcs) + ", " + ;
                        EscaparSQL(THIS.this_cEspecies) + ", " + ;
                        EscaparSQL(THIS.this_cSeries) + ", " + ;
                        EscaparSQL(THIS.this_cHist2s) + ", " + ;
                        EscaparSQL(THIS.this_cHists) + ", " + ;
                        EscaparSQL(THIS.this_cSubmenus) + ", " + ;
                        EscaparSQL(THIS.this_cGrucados) + ", " + ;
                        EscaparSQL(THIS.this_cGrucadds) + ", " + ;
                        EscaparSQL(THIS.this_cGrucadvs) + ", " + ;
                        EscaparSQL(THIS.this_cCfos) + ", " + ;
                        EscaparSQL(THIS.this_cRelfechgrs) + ", " + ;
                        EscaparSQL(THIS.this_cDopestrfs) + ", " + ;
                        EscaparSQL(THIS.this_cOperchqes) + ", " + ;
                        EscaparSQL(THIS.this_cOperchqss) + ", " + ;
                        EscaparSQL(THIS.this_cGremiss) + ", " + ;
                        EscaparSQL(THIS.this_cConemiss) + ", " + ;
                        EscaparSQL(THIS.this_cOperfisics) + ", " + ;
                        EscaparSQL(THIS.this_cCodpropads) + ", " + ;
                        EscaparSQL(THIS.this_cFpagopcrs) + ", " + ;
                        EscaparSQL(THIS.this_cLprecopads) + ", " + ;
                        EscaparSQL(THIS.this_cMascvens) + ", " + ;
                        EscaparSQL(THIS.this_cImpclis) + ", " + ;
                        EscaparSQL(THIS.this_cOpernf) + ", " + ;
                        EscaparSQL(THIS.this_cCodconpads) + ", " + ;
                        EscaparSQL(THIS.this_cEmpbxs) + ", " + ;
                        EscaparSQL(THIS.this_cEmplancs) + ", " + ;
                        EscaparSQL(THIS.this_cOpepads) + ", " + ;
                        EscaparSQL(THIS.this_cProgramas) + ", " + ;
                        IIF(EMPTY(THIS.this_cCtipomarms), "NULL", EscaparSQL(THIS.this_cCtipomarms)) + ", " + ;
                        IIF(EMPTY(THIS.this_cCarqicones), "NULL", EscaparSQL(THIS.this_cCarqicones)) + ", " + ;
                        EscaparSQL(THIS.this_cDopcreds) + ", " + ;
                        EscaparSQL(THIS.this_cCfgfinancs) + ", " + ;
                        EscaparSQL(THIS.this_mObsopes)
            loc_cSQL = "INSERT INTO SigCdOpe (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o.", "Erro em Inserir")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_cSet, loc_nResult, loc_cDatatrans
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("A")
            IF EMPTY(THIS.this_dDatatrans)
                loc_cDatatrans = "NULL"
            ELSE
                loc_cDatatrans = FormatarDataSQL(THIS.this_dDatatrans)
            ENDIF
            loc_cSet = "titopes = "     + EscaparSQL(THIS.this_cTitopes)   + ", " + ;
                       "tipoops = "     + TRANSFORM(THIS.this_nTipoops)    + ", " + ;
                       "situas = "      + TRANSFORM(THIS.this_nSituas)     + ", " + ;
                       "opers = "       + TRANSFORM(THIS.this_nOpers)      + ", " + ;
                       "pedclis = "     + TRANSFORM(THIS.this_nPedclis)    + ", " + ;
                       "zerqtds = "     + TRANSFORM(THIS.this_nZerqtds)    + ", " + ;
                       "valinotas = "   + TRANSFORM(THIS.this_nValinotas)  + ", " + ;
                       "valitems = "    + TRANSFORM(THIS.this_nValitems)   + ", " + ;
                       "exibsits = "    + TRANSFORM(THIS.this_nExibsits)   + ", " + ;
                       "chkqtds = "     + TRANSFORM(THIS.this_nChkqtds)    + ", " + ;
                       "dtcontab = "    + TRANSFORM(THIS.this_nDtcontab)   + ", " + ;
                       "altdescs = "    + TRANSFORM(THIS.this_nAltdescs)   + ", " + ;
                       "antecs = "      + TRANSFORM(THIS.this_nAntecs)     + ", " + ;
                       "aptpfats = "    + TRANSFORM(THIS.this_nAptpfats)   + ", " + ;
                       "arreds = "      + TRANSFORM(THIS.this_nArreds)     + ", " + ;
                       "baixasns = "    + TRANSFORM(THIS.this_nBaixasns)   + ", " + ;
                       "bxautos = "     + TRANSFORM(THIS.this_nBxautos)    + ", " + ;
                       "bxparcials = "  + TRANSFORM(THIS.this_nBxparcials) + ", " + ;
                       "cadclis = "     + TRANSFORM(THIS.this_nCadclis)    + ", " + ;
                       "caixas = "      + TRANSFORM(THIS.this_nCaixas)     + ", "
            loc_cSet = loc_cSet + ;
                       "calcfecs = "    + TRANSFORM(THIS.this_nCalcfecs)   + ", " + ;
                       "carnes = "      + TRANSFORM(THIS.this_nCarnes)     + ", " + ;
                       "ccomis = "      + TRANSFORM(THIS.this_nCcomis)     + ", " + ;
                       "cdesps = "      + TRANSFORM(THIS.this_nCdesps)     + ", " + ;
                       "chdtentrs = "   + TRANSFORM(THIS.this_nChdtentrs)  + ", " + ;
                       "cheqs = "       + TRANSFORM(THIS.this_nCheqs)      + ", " + ;
                       "codbars = "     + TRANSFORM(THIS.this_nCodbars)    + ", " + ;
                       "comcargs = "    + TRANSFORM(THIS.this_nComcargs)   + ", " + ;
                       "condsubs = "    + TRANSFORM(THIS.this_nCondsubs)   + ", " + ;
                       "confes = "      + TRANSFORM(THIS.this_nConfes)     + ", " + ;
                       "conosubs = "    + TRANSFORM(THIS.this_nConosubs)   + ", " + ;
                       "consclis = "    + TRANSFORM(THIS.this_nConsclis)   + ", " + ;
                       "consers = "     + TRANSFORM(THIS.this_nConsers)    + ", " + ;
                       "consgs = "      + TRANSFORM(THIS.this_nConsgs)     + ", " + ;
                       "copers = "      + TRANSFORM(THIS.this_nCopers)     + ", " + ;
                       "crepls = "      + TRANSFORM(THIS.this_nCrepls)     + ", " + ;
                       "ctipos = "      + TRANSFORM(THIS.this_nCtipos)     + ", " + ;
                       "cupfis = "      + TRANSFORM(THIS.this_nCupfis)     + ", " + ;
                       "deacrs = "      + TRANSFORM(THIS.this_nDeacrs)     + ", " + ;
                       "desmembs = "    + TRANSFORM(THIS.this_nDesmembs)   + ", "
            loc_cSet = loc_cSet + ;
                       "destinos = "    + TRANSFORM(THIS.this_nDestinos)   + ", " + ;
                       "dfpags = "      + TRANSFORM(THIS.this_nDfpags)     + ", " + ;
                       "digdoc = "      + TRANSFORM(THIS.this_nDigdoc)     + ", " + ;
                       "digitens = "    + TRANSFORM(THIS.this_nDigitens)   + ", " + ;
                       "digobs = "      + TRANSFORM(THIS.this_nDigobs)     + ", " + ;
                       "dtentrs = "     + TRANSFORM(THIS.this_nDtentrs)    + ", " + ;
                       "edcotas = "     + TRANSFORM(THIS.this_nEdcotas)    + ", " + ;
                       "edtpfats = "    + TRANSFORM(THIS.this_nEdtpfats)   + ", " + ;
                       "efators = "     + TRANSFORM(THIS.this_nEfators)    + ", " + ;
                       "epesos = "      + TRANSFORM(THIS.this_nEpesos)     + ", " + ;
                       "eprecos = "     + TRANSFORM(THIS.this_nEprecos)    + ", " + ;
                       "estdests = "    + TRANSFORM(THIS.this_nEstdests)   + ", " + ;
                       "estoqs = "      + TRANSFORM(THIS.this_nEstoqs)     + ", " + ;
                       "estorigs = "    + TRANSFORM(THIS.this_nEstorigs)   + ", " + ;
                       "expends = "     + TRANSFORM(THIS.this_nExpends)    + ", " + ;
                       "fatauts = "     + TRANSFORM(THIS.this_nFatauts)    + ", " + ;
                       "globalizas = "  + TRANSFORM(THIS.this_nGlobalizas) + ", " + ;
                       "imagems = "     + TRANSFORM(THIS.this_nImagems)    + ", " + ;
                       "itemalfas = "   + TRANSFORM(THIS.this_nItemalfas)  + ", " + ;
                       "itemzeros = "   + TRANSFORM(THIS.this_nItemzeros)  + ", "
            loc_cSet = loc_cSet + ;
                       "limcres = "     + TRANSFORM(THIS.this_nLimcres)    + ", " + ;
                       "limpauts = "    + TRANSFORM(THIS.this_nLimpauts)   + ", " + ;
                       "lprecos = "     + TRANSFORM(THIS.this_nLprecos)    + ", " + ;
                       "mestoqs = "     + TRANSFORM(THIS.this_nMestoqs)    + ", " + ;
                       "ndebitos = "    + TRANSFORM(THIS.this_nNdebitos)   + ", " + ;
                       "nfiscals = "    + TRANSFORM(THIS.this_nNfiscals)   + ", " + ;
                       "numeras = "     + TRANSFORM(THIS.this_nNumeras)    + ", " + ;
                       "opcrs = "       + TRANSFORM(THIS.this_nOpcrs)      + ", " + ;
                       "origems = "     + TRANSFORM(THIS.this_nOrigems)    + ", " + ;
                       "parautos = "    + TRANSFORM(THIS.this_nParautos)   + ", " + ;
                       "parcontas = "   + TRANSFORM(THIS.this_nParcontas)  + ", " + ;
                       "parcs = "       + TRANSFORM(THIS.this_nParcs)      + ", " + ;
                       "parrecals = "   + TRANSFORM(THIS.this_nParrecals)  + ", " + ;
                       "pesoauts = "    + TRANSFORM(THIS.this_nPesoauts)   + ", " + ;
                       "pesods = "      + TRANSFORM(THIS.this_nPesods)     + ", " + ;
                       "pesos = "       + TRANSFORM(THIS.this_nPesos)      + ", " + ;
                       "pesovts = "     + TRANSFORM(THIS.this_nPesovts)    + ", " + ;
                       "precoauts = "   + TRANSFORM(THIS.this_nPrecoauts)  + ", " + ;
                       "precods = "     + TRANSFORM(THIS.this_nPrecods)    + ", " + ;
                       "precovts = "    + TRANSFORM(THIS.this_nPrecovts)   + ", "
            loc_cSet = loc_cSet + ;
                       "produc = "      + TRANSFORM(THIS.this_nProduc)     + ", " + ;
                       "qtdpesos = "    + TRANSFORM(THIS.this_nQtdpesos)   + ", " + ;
                       "qtdprecos = "   + TRANSFORM(THIS.this_nQtdprecos)  + ", " + ;
                       "qtdrelevs = "   + TRANSFORM(THIS.this_nQtdrelevs)  + ", " + ;
                       "relfechas = "   + TRANSFORM(THIS.this_nRelfechas)  + ", " + ;
                       "reservas = "    + TRANSFORM(THIS.this_nReservas)   + ", " + ;
                       "results = "     + TRANSFORM(THIS.this_nResults)    + ", " + ;
                       "subns = "       + TRANSFORM(THIS.this_nSubns)      + ", " + ;
                       "tabdescs = "    + TRANSFORM(THIS.this_nTabdescs)   + ", " + ;
                       "transons = "    + TRANSFORM(THIS.this_nTransons)   + ", " + ;
                       "transps = "     + TRANSFORM(THIS.this_nTransps)    + ", " + ;
                       "transs = "      + TRANSFORM(THIS.this_nTranss)     + ", " + ;
                       "unitpesos = "   + TRANSFORM(THIS.this_nUnitpesos)  + ", " + ;
                       "valests = "     + TRANSFORM(THIS.this_nValests)    + ", " + ;
                       "valpends = "    + TRANSFORM(THIS.this_nValpends)   + ", " + ;
                       "valpres = "     + TRANSFORM(THIS.this_nValpres)    + ", " + ;
                       "vars = "        + TRANSFORM(THIS.this_nVars)       + ", " + ;
                       "vendas = "      + TRANSFORM(THIS.this_nVendas)     + ", " + ;
                       "vendes = "      + TRANSFORM(THIS.this_nVendes)     + ", " + ;
                       "semetiqs = "    + TRANSFORM(THIS.this_nSemetiqs)   + ", "
            loc_cSet = loc_cSet + ;
                       "casas = "       + TRANSFORM(THIS.this_nCasas)      + ", " + ;
                       "alttrans = "    + TRANSFORM(THIS.this_nAlttrans)   + ", " + ;
                       "dadosnotas = "  + TRANSFORM(THIS.this_nDadosnotas) + ", " + ;
                       "obsdests = "    + TRANSFORM(THIS.this_nObsdests)   + ", " + ;
                       "obsorigs = "    + TRANSFORM(THIS.this_nObsorigs)   + ", " + ;
                       "servicos = "    + TRANSFORM(THIS.this_nServicos)   + ", " + ;
                       "subnobrigs = "  + TRANSFORM(THIS.this_nSubnobrigs) + ", " + ;
                       "tphist2s = "    + TRANSFORM(THIS.this_nTphist2s)   + ", " + ;
                       "tphists = "     + TRANSFORM(THIS.this_nTphists)    + ", " + ;
                       "blqdatas = "    + TRANSFORM(THIS.this_nBlqdatas)   + ", " + ;
                       "senhads = "     + TRANSFORM(THIS.this_nSenhads)    + ", " + ;
                       "senhaos = "     + TRANSFORM(THIS.this_nSenhaos)    + ", " + ;
                       "democreds = "   + TRANSFORM(THIS.this_nDemocreds)  + ", " + ;
                       "digcpfs = "     + TRANSFORM(THIS.this_nDigcpfs)    + ", " + ;
                       "congvends = "   + TRANSFORM(THIS.this_nCongvends)  + ", " + ;
                       "chkqtdss = "    + TRANSFORM(THIS.this_nChkqtdss)   + ", " + ;
                       "valitnegs = "   + TRANSFORM(THIS.this_nValitnegs)  + ", " + ;
                       "calcmos = "     + TRANSFORM(THIS.this_nCalcmos)    + ", " + ;
                       "chkdval = "     + TRANSFORM(THIS.this_nChkdval)    + ", " + ;
                       "tabdobrigs = "  + TRANSFORM(THIS.this_nTabdobrigs) + ", "
            loc_cSet = loc_cSet + ;
                       "dtemis = "      + TRANSFORM(THIS.this_nDtemis)     + ", " + ;
                       "conprecs = "    + TRANSFORM(THIS.this_nConprecs)   + ", " + ;
                       "trocoauts = "   + TRANSFORM(THIS.this_nTrocoauts)  + ", " + ;
                       "parczeros = "   + TRANSFORM(THIS.this_nParczeros)  + ", " + ;
                       "bxvlopcrs = "   + TRANSFORM(THIS.this_nBxvlopcrs)  + ", " + ;
                       "cadcliauts = "  + TRANSFORM(THIS.this_nCadcliauts) + ", " + ;
                       "obsitems = "    + TRANSFORM(THIS.this_nObsitems)   + ", " + ;
                       "varitems = "    + TRANSFORM(THIS.this_nVaritems)   + ", " + ;
                       "itsituas = "    + TRANSFORM(THIS.this_nItsituas)   + ", " + ;
                       "habsubits = "   + TRANSFORM(THIS.this_nHabsubits)  + ", " + ;
                       "oppends = "     + TRANSFORM(THIS.this_nOppends)    + ", " + ;
                       "cadprods = "    + TRANSFORM(THIS.this_nCadprods)   + ", " + ;
                       "subnautos = "   + TRANSFORM(THIS.this_nSubnautos)  + ", " + ;
                       "senhars = "     + TRANSFORM(THIS.this_nSenhars)    + ", " + ;
                       "totcompos = "   + TRANSFORM(THIS.this_nTotcompos)  + ", " + ;
                       "chkedesc = "    + TRANSFORM(THIS.this_nChkedesc)   + ", " + ;
                       "ncpesos = "     + TRANSFORM(THIS.this_nNcpesos)    + ", " + ;
                       "editdocs = "    + TRANSFORM(THIS.this_nEditdocs)   + ", " + ;
                       "cempsubns = "   + TRANSFORM(THIS.this_nCempsubns)  + ", " + ;
                       "carcbars = "    + TRANSFORM(THIS.this_nCarcbars)   + ", "
            loc_cSet = loc_cSet + ;
                       "ctrllotes = "   + TRANSFORM(THIS.this_nCtrllotes)  + ", " + ;
                       "orilotes = "    + TRANSFORM(THIS.this_nOrilotes)   + ", " + ;
                       "reffs = "       + TRANSFORM(THIS.this_nReffs)      + ", " + ;
                       "ccustos = "     + TRANSFORM(THIS.this_nCcustos)    + ", " + ;
                       "dcpns = "       + TRANSFORM(THIS.this_nDcpns)      + ", " + ;
                       "dtbars = "      + TRANSFORM(THIS.this_nDtbars)     + ", " + ;
                       "aciosens = "    + TRANSFORM(THIS.this_nAciosens)   + ", " + ;
                       "cliods = "      + TRANSFORM(THIS.this_nCliods)     + ", " + ;
                       "edcomis = "     + TRANSFORM(THIS.this_nEdcomis)    + ", " + ;
                       "infoipis = "    + TRANSFORM(THIS.this_nInfoipis)   + ", " + ;
                       "agrupas = "     + TRANSFORM(THIS.this_nAgrupas)    + ", " + ;
                       "digenves = "    + TRANSFORM(THIS.this_nDigenves)   + ", " + ;
                       "digrecs = "     + TRANSFORM(THIS.this_nDigrecs)    + ", " + ;
                       "empsubns = "    + TRANSFORM(THIS.this_nEmpsubns)   + ", " + ;
                       "fechmals = "    + TRANSFORM(THIS.this_nFechmals)   + ", " + ;
                       "habservs = "    + TRANSFORM(THIS.this_nHabservs)   + ", " + ;
                       "marcasubns = "  + TRANSFORM(THIS.this_nMarcasubns) + ", " + ;
                       "tiponfs = "     + TRANSFORM(THIS.this_nTiponfs)    + ", " + ;
                       "chkacpro = "    + TRANSFORM(THIS.this_nChkacpro)   + ", " + ;
                       "edunis = "      + TRANSFORM(THIS.this_nEdunis)     + ", "
            loc_cSet = loc_cSet + ;
                       "anprodzs = "    + TRANSFORM(THIS.this_nAnprodzs)   + ", " + ;
                       "autenticas = "  + TRANSFORM(THIS.this_nAutenticas) + ", " + ;
                       "autoins = "     + TRANSFORM(THIS.this_nAutoins)    + ", " + ;
                       "bxpagos = "     + TRANSFORM(THIS.this_nBxpagos)    + ", " + ;
                       "carvends = "    + TRANSFORM(THIS.this_nCarvends)   + ", " + ;
                       "cbxsubns = "    + TRANSFORM(THIS.this_nCbxsubns)   + ", " + ;
                       "checpagos = "   + TRANSFORM(THIS.this_nChecpagos)  + ", " + ;
                       "chkagends = "   + TRANSFORM(THIS.this_nChkagends)  + ", " + ;
                       "inibcchqs = "   + TRANSFORM(THIS.this_nInibcchqs)  + ", " + ;
                       "inibmens = "    + TRANSFORM(THIS.this_nInibmens)   + ", " + ;
                       "inibmlcs = "    + TRANSFORM(THIS.this_nInibmlcs)   + ", " + ;
                       "ncarsubs = "    + TRANSFORM(THIS.this_nNcarsubs)   + ", " + ;
                       "obrigvd2s = "   + TRANSFORM(THIS.this_nObrigvd2s)  + ", " + ;
                       "obrigvds = "    + TRANSFORM(THIS.this_nObrigvds)   + ", " + ;
                       "tplprecs = "    + TRANSFORM(THIS.this_nTplprecs)   + ", " + ;
                       "fpubl = "       + TRANSFORM(THIS.this_nFpubl)      + ", " + ;
                       "nfcompls = "    + TRANSFORM(THIS.this_nNfcompls)   + ", " + ;
                       "docus = "       + TRANSFORM(THIS.this_nDocus)      + ", " + ;
                       "itautos = "     + TRANSFORM(THIS.this_nItautos)    + ", " + ;
                       "precops = "     + TRANSFORM(THIS.this_nPrecops)    + ", "
            loc_cSet = loc_cSet + ;
                       "comisdivs = "   + TRANSFORM(THIS.this_nComisdivs)  + ", " + ;
                       "trnfis = "      + TRANSFORM(THIS.this_nTrnfis)     + ", " + ;
                       "obspads = "     + TRANSFORM(THIS.this_nObspads)    + ", " + ;
                       "obsfins = "     + TRANSFORM(THIS.this_nObsfins)    + ", " + ;
                       "obsinis = "     + TRANSFORM(THIS.this_nObsinis)    + ", " + ;
                       "cdopes = "      + TRANSFORM(THIS.this_nCdopes)     + ", " + ;
                       "ndopes = "      + TRANSFORM(THIS.this_nNdopes)     + ", " + ;
                       "ordes = "       + TRANSFORM(THIS.this_nOrdes)      + ", " + ;
                       "qtdites = "     + TRANSFORM(THIS.this_nQtdites)    + ", " + ;
                       "porcs = "       + FormatarNumeroSQL(THIS.this_nPorcs)      + ", " + ;
                       "vcompensas = "  + FormatarNumeroSQL(THIS.this_nVcompensas) + ", " + ;
                       "fixcdests = "   + IIF(THIS.this_lFixcdests, "1", "0") + ", " + ;
                       "fixcnopes = "   + IIF(THIS.this_lFixcnopes, "1", "0") + ", " + ;
                       "fixcorigs = "   + IIF(THIS.this_lFixcorigs, "1", "0") + ", " + ;
                       "fixgdests = "   + IIF(THIS.this_lFixgdests, "1", "0") + ", " + ;
                       "fixgorigs = "   + IIF(THIS.this_lFixgorigs, "1", "0") + ", " + ;
                       "fixgropes = "   + IIF(THIS.this_lFixgropes, "1", "0") + ", " + ;
                       "fixgvends = "   + IIF(THIS.this_lFixgvends, "1", "0") + ", " + ;
                       "chkfunds = "    + IIF(THIS.this_lChkfunds,  "1", "0") + ", " + ;
                       "fixgven2s = "   + IIF(THIS.this_lFixgven2s, "1", "0") + ", " + ;
                       "datatrans = "   + loc_cDatatrans + ", "
            loc_cSet = loc_cSet + ;
                       "dopeetrfs = "   + EscaparSQL(THIS.this_cDopeetrfs)  + ", " + ;
                       "abrevs = "      + EscaparSQL(THIS.this_cAbrevs)     + ", " + ;
                       "ccentrals = "   + EscaparSQL(THIS.this_cCcentrals)  + ", " + ;
                       "cmoes = "       + EscaparSQL(THIS.this_cCmoes)      + ", " + ;
                       "cnopes = "      + EscaparSQL(THIS.this_cCnopes)     + ", " + ;
                       "condests = "    + EscaparSQL(THIS.this_cCondests)   + ", " + ;
                       "conorigs = "    + EscaparSQL(THIS.this_cConorigs)   + ", " + ;
                       "contas = "      + EscaparSQL(THIS.this_cContas)     + ", " + ;
                       "emppads = "     + EscaparSQL(THIS.this_cEmppads)    + ", " + ;
                       "grudests = "    + EscaparSQL(THIS.this_cGrudests)   + ", " + ;
                       "gruorigs = "    + EscaparSQL(THIS.this_cGruorigs)   + ", " + ;
                       "grupos = "      + EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                       "grvends = "     + EscaparSQL(THIS.this_cGrvends)    + ", " + ;
                       "menus = "       + EscaparSQL(THIS.this_cMenus)      + ", " + ;
                       "nivels = "      + EscaparSQL(THIS.this_cNivels)     + ", " + ;
                       "nopcrs = "      + EscaparSQL(THIS.this_cNopcrs)     + ", " + ;
                       "tabdps = "      + EscaparSQL(THIS.this_cTabdps)     + ", " + ;
                       "dopcs = "       + EscaparSQL(THIS.this_cDopcs)      + ", " + ;
                       "especies = "    + EscaparSQL(THIS.this_cEspecies)   + ", " + ;
                       "series = "      + EscaparSQL(THIS.this_cSeries)     + ", "
            loc_cSet = loc_cSet + ;
                       "hist2s = "      + EscaparSQL(THIS.this_cHist2s)     + ", " + ;
                       "hists = "       + EscaparSQL(THIS.this_cHists)      + ", " + ;
                       "submenus = "    + EscaparSQL(THIS.this_cSubmenus)   + ", " + ;
                       "grucados = "    + EscaparSQL(THIS.this_cGrucados)   + ", " + ;
                       "grucadds = "    + EscaparSQL(THIS.this_cGrucadds)   + ", " + ;
                       "grucadvs = "    + EscaparSQL(THIS.this_cGrucadvs)   + ", " + ;
                       "cfos = "        + EscaparSQL(THIS.this_cCfos)       + ", " + ;
                       "relfechgrs = "  + EscaparSQL(THIS.this_cRelfechgrs) + ", " + ;
                       "dopestrfs = "   + EscaparSQL(THIS.this_cDopestrfs)  + ", " + ;
                       "operchqes = "   + EscaparSQL(THIS.this_cOperchqes)  + ", " + ;
                       "operchqss = "   + EscaparSQL(THIS.this_cOperchqss)  + ", " + ;
                       "gremiss = "     + EscaparSQL(THIS.this_cGremiss)    + ", " + ;
                       "conemiss = "    + EscaparSQL(THIS.this_cConemiss)   + ", " + ;
                       "operfisics = "  + EscaparSQL(THIS.this_cOperfisics) + ", " + ;
                       "codpropads = "  + EscaparSQL(THIS.this_cCodpropads) + ", " + ;
                       "fpagopcrs = "   + EscaparSQL(THIS.this_cFpagopcrs)  + ", " + ;
                       "lprecopads = "  + EscaparSQL(THIS.this_cLprecopads) + ", " + ;
                       "mascvens = "    + EscaparSQL(THIS.this_cMascvens)   + ", " + ;
                       "impclis = "     + EscaparSQL(THIS.this_cImpclis)    + ", " + ;
                       "opernf = "      + EscaparSQL(THIS.this_cOpernf)     + ", "
            loc_cSet = loc_cSet + ;
                       "codconpads = "  + EscaparSQL(THIS.this_cCodconpads) + ", " + ;
                       "empbxs = "      + EscaparSQL(THIS.this_cEmpbxs)     + ", " + ;
                       "emplancs = "    + EscaparSQL(THIS.this_cEmplancs)   + ", " + ;
                       "opepads = "     + EscaparSQL(THIS.this_cOpepads)    + ", " + ;
                       "programas = "   + EscaparSQL(THIS.this_cProgramas)  + ", " + ;
                       "ctipomarms = "  + IIF(EMPTY(THIS.this_cCtipomarms), "NULL", EscaparSQL(THIS.this_cCtipomarms)) + ", " + ;
                       "carqicones = "  + IIF(EMPTY(THIS.this_cCarqicones), "NULL", EscaparSQL(THIS.this_cCarqicones)) + ", " + ;
                       "dopcreds = "    + EscaparSQL(THIS.this_cDopcreds)   + ", " + ;
                       "cfgfinancs = "  + EscaparSQL(THIS.this_cCfgfinancs) + ", " + ;
                       "obsopes = "     + EscaparSQL(THIS.this_mObsopes)
            loc_cSQL = "UPDATE SigCdOpe SET " + loc_cSet + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o.", "Erro em Atualizar")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Atualizar")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("E")
            loc_cSQL = "DELETE FROM SigCdOpe WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "Erro em ExecutarExclusao")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

