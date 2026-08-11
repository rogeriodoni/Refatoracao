# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[DrsBO.prg] Indicador de pendencia: * par_cFiltro: ""/"TODAS"=todos; "PENDENTE
[FormDrs.prg] Indicador de pendencia: *-- optFiltro: Todas/Pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[01/08/2026 05:49:21] Erro: Connection handle is invalid.
[01/08/2026 05:49:21] Erro: Connection handle is invalid.
[01/08/2026 05:49:21] Fichas Técnicas: Não foi possível gerar novo código.


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormDrs",
  "timestamp": "20260801054921",
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
      "detalhes": "Propriedade this_cModoAtual configurada"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 1 (KEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDrs.prg):
*==============================================================================
* FormDrs.prg - Formulario de Fichas Tecnicas (SigSyCrs)
* Migrado de: SigCdDrs.SCX (frmcadastro)
*
* Recebe par_cTits (C20) para identificar o tipo de ficha tecnica.
* Modelo: chave-valor em SigSyCrs (Tits+Cods = PK logica; Campos=campo; Resps=valor).
* Campos dinamicos definidos em SigSyCit; campos fixos: Emps, Dopes, Numes, Aprova, Datas, Baixa.
* Workflow: Aprovar/Desaprovar (cmd_4c_Aprovar) e Baixar/Canc Baixa (cmd_4c_Baixar).
*==============================================================================

DEFINE CLASS FormDrs AS FormBase

    *-- Propriedades visuais
    Height      = 640
    Width       = 1007
    Caption     = "Fichas T" + CHR(233) + "cnicas"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cTits           = ""
    this_nCodAtual       = 0
    this_lMontouObjetos  = .F.
    this_nNroControles   = 0

    *-- Array de controles dinamicos (nomeCtrl, obrigatorio, nomeCampo)
    DIMENSION laControles[1, 3]

    *===========================================================================
    * Init - Recebe par_cTits antes de delegar ao FormBase
    *===========================================================================
    PROCEDURE Init(par_cTits)
        IF VARTYPE(par_cTits) = "C"
            THIS.this_cTits = PADR(ALLTRIM(par_cTits), 20)
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DrsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar DrsBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormDrs.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_cTits = THIS.this_cTits

                IF !THIS.this_oBusinessObject.CarregarSigSyCit()
                    MostrarErro("Erro ao carregar SigSyCit para Tits=" + ;
                        ALLTRIM(THIS.this_cTits), "FormDrs.InicializarForm")
                ELSE
                    THIS.this_oBusinessObject.InicializarCursores()

                    THIS.ConfigurarPageFrame()
                    THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ALLTRIM(THIS.this_cTits)
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Visible    = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual           = "LISTA"

                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.CarregarLista()
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormDrs:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - PageFrame com 2 paginas (Top=-29, Tabs=.F.)
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
    * ConfigurarPaginaLista - Page1: cabecalho + CRUD + filtro + workflow + grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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
            .Width     = 750
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
            .Width     = 750
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Botoes CRUD (Incluir/Alterar/Excluir/Buscar)
        *-- Original grupo_op: Left=342, Top=-1. Compensado: Top=29
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
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

        *-- optFiltro: Todas/Pendentes/Baixadas
        *-- Original: Left=35, Top=87. Compensado: Top=116 (87+29)
        loc_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
        WITH loc_oPagina.opt_4c_Filtro
            .ButtonCount  = 3
            .AutoSize     = .F.
            .Height       = 58
            .Left         = 35
            .Top          = 116
            .Width        = 82
            .BackStyle    = 0
            .BorderStyle  = 0
            .Value        = 1
            .Visible      = .T.

            WITH .Buttons(1)
                .Caption   = "Todas"
                .Height    = 17
                .Left      = 3
                .Top       = 3
                .Width     = 74
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Pendentes"
                .Height    = 17
                .Left      = 3
                .Top       = 21
                .Width     = 74
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Baixadas"
                .Height    = 17
                .Left      = 3
                .Top       = 39
                .Width     = 74
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .AutoSize  = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Filtro, "InteractiveChange", THIS, "OptFiltroInteractiveChange")

        *-- Botoes de Workflow: Aprovar/Desaprovar e Baixar/Canc Baixa
        *-- Original Commandgroup1: Left=115, Top=91. Compensado: Top=120 (91+29)
        loc_oPagina.AddObject("cnt_4c_Workflow", "Container")
        WITH loc_oPagina.cnt_4c_Workflow
            .Top         = 120
            .Left        = 122
            .Width       = 250
            .Height      = 55
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Aprovar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
            .Caption         = "Aprovar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
            .PicturePosition = 1
            .Top             = 5
            .Left            = 4
            .Width           = 115
            .Height          = 45
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar, "Click", THIS, "BtnAprovarClick")

        loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Baixar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
            .Caption         = "Baixar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 1
            .Top             = 5
            .Left            = 127
            .Width           = 115
            .Height          = 45
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar, "Click", THIS, "BtnBaixarClick")

        *-- Grid de listagem (colunas montadas em MontarColunasGrid apos Buscar)
        *-- Original grade: Left=29, Top=142. Compensado Top: 175 (142+29+4)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 0
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 180
            .Left               = 29
            .Width              = 880
            .Height             = 425
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
            .ScrollBars         = 3
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GrdAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick",          THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: botoes acao + codigo + container dinamico
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Botoes Confirmar/Cancelar
        *-- Original grupo_salva: Top=9. Compensado: Top=38 (9+29)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 38
            .Left        = 840
            .Width       = 160
            .Height      = 85
            .BackStyle = 0
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

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

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 83
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

        *-- Label e TextBox de Codigo
        *-- Original Label1: Left=102, Top=137; getCods: Left=152, Top=134
        *-- Compensados: Top Label=166 (137+29), Top getCods=163 (134+29)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 166
            .Left      = 102
            .Height    = 16
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Cods", "TextBox")
        WITH loc_oPagina.txt_4c_Cods
            .Value             = 0
            .Enabled           = .F.
            .Left              = 155
            .Top               = 163
            .Width             = 52
            .Height            = 20
            .DisabledBackColor = RGB(255, 255, 255)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .T.
        ENDWITH

        *-- Container para campos dinamicos de SigSyCit + campos fixos de header
        *-- Original Shape1: Top=167, Height=309, Left=65, Width=670 -> compensado Top=196
        loc_oPagina.AddObject("cnt_4c_Campos", "Container")
        WITH loc_oPagina.cnt_4c_Campos
            .Top         = 196
            .Left        = 65
            .Width       = THIS.Width
            .Height      = 420
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderColor = RGB(180, 180, 180)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Busca registros e configura grid dinamico
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cFiltro, loc_oGrd, loc_oPagina
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oGrd    = loc_oPagina.grd_4c_Lista

            DO CASE
                CASE loc_oPagina.opt_4c_Filtro.Value = 2
                    loc_cFiltro = "PENDENTES"
                CASE loc_oPagina.opt_4c_Filtro.Value = 3
                    loc_cFiltro = "BAIXADAS"
                OTHERWISE
                    loc_cFiltro = "TODAS"
            ENDCASE

            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                *-- cursor_4c_Dados: alias padrao do framework de testes
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                IF USED("crSigSyCrs")
                    SELECT * FROM crSigSyCrs INTO CURSOR cursor_4c_Dados NOFILTER READWRITE
                    SELECT crSigSyCrs
                ENDIF
                THIS.MontarColunasGrid()
                IF USED("crSigSyCrs")
                    loc_oGrd.SetAll("DynamicForeColor", ;
                        "Iif(crSigSyCrs.ChkSubn, RGB(0,0,255), Iif(crSigSyCrs.ChkApro, RGB(0,128,0), RGB(0,0,0)))", ;
                        "Column")
                    loc_oGrd.RecordSource = "crSigSyCrs"
                    loc_oGrd.Refresh()
                ENDIF
                THIS.AtualizarBotoesWorkflow()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.CarregarLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * MontarColunasGrid - Configura colunas do grid baseado em crSigSyCit.Listas=1
    *===========================================================================
    PROTECTED PROCEDURE MontarColunasGrid()
        LOCAL loc_oGrd, loc_nCols, loc_nColIdx, loc_cCampo, loc_nWidth, loc_cHeader
        TRY
            loc_oGrd  = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
            loc_nCols = 1

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_nCols = loc_nCols + 1
                    ENDIF
                ENDSCAN
            ENDIF

            loc_oGrd.RecordSource = ""
            loc_oGrd.ColumnCount  = loc_nCols

            WITH loc_oGrd.Column1
                .ControlSource       = "crSigSyCrs.Cods"
                .Width               = 60
                .ReadOnly            = .T.
                .Header1.Caption     = "C" + CHR(243) + "digo"
                .Header1.FontName    = "Tahoma"
                .Header1.FontBold    = .T.
                .Header1.FontSize    = 8
            ENDWITH

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                loc_nColIdx = 2
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCampo  = ALLTRIM(crSigSyCit.Campos)
                        loc_cHeader = PROPER(ALLTRIM(crSigSyCit.Descs))

                        DO CASE
                            CASE crSigSyCit.Tipos = "D"
                                loc_nWidth = 80
                            CASE crSigSyCit.Tipos = "N"
                                loc_nWidth = 100
                            CASE !EMPTY(ALLTRIM(crSigSyCit.Pictures))
                                loc_nWidth = MAX(60, LEN(ALLTRIM(crSigSyCit.Pictures)) * 8)
                            OTHERWISE
                                loc_nWidth = 400
                        ENDCASE

                        WITH loc_oGrd.Columns(loc_nColIdx)
                            .ControlSource       = "crSigSyCrs." + loc_cCampo
                            .Width               = loc_nWidth
                            .ReadOnly            = .T.
                            .Header1.Caption     = loc_cHeader
                            .Header1.FontName    = "Tahoma"
                            .Header1.FontBold    = .T.
                            .Header1.FontSize    = 8
                        ENDWITH

                        loc_nColIdx = loc_nColIdx + 1
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.MontarColunasGrid")
        ENDTRY
    ENDPROC

    *===========================================================================
    * MontarObjetos - Popula cnt_4c_Campos com Label+Controle por campo de SigSyCit
    * par_cModo: "INSERIR" | "ALTERAR" | "EXCLUIR" | "CONSULTAR"
    *===========================================================================
    PROCEDURE MontarObjetos(par_cModo)
        LOCAL loc_oCnt, loc_nTop, loc_nLef, loc_nWid, loc_nHei
        LOCAL loc_cObjName, loc_cLblName, loc_lReadOnly
        LOCAL loc_cTipos, loc_cCampo, loc_cDescs, loc_nOrdems, loc_cInputMask
        LOCAL loc_nWidCtrl, loc_nIdx, loc_cNome
        TRY
            THIS.DesmontarObjetos()

            loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
            loc_lReadOnly = INLIST(UPPER(ALLTRIM(par_cModo)), "EXCLUIR", "CONSULTAR")
            loc_nTop      = 6
            loc_nLef      = 5
            loc_nWid      = loc_oCnt.Width - 30
            THIS.this_nNroControles = 0

            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    loc_cCampo     = ALLTRIM(crSigSyCit.Campos)
                    loc_cDescs     = ALLTRIM(crSigSyCit.Descs)
                    loc_cTipos     = ALLTRIM(crSigSyCit.Tipos)
                    loc_nOrdems    = crSigSyCit.Ordems
                    loc_cInputMask = ALLTRIM(crSigSyCit.Pictures)

                    *-- Label
                    loc_cLblName = "lbl_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
                    loc_oCnt.AddObject(loc_cLblName, "Label")
                    WITH loc_oCnt.&loc_cLblName.
                        .Caption   = PROPER(loc_cDescs)
                        .Top       = loc_nTop
                        .Left      = loc_nLef + 4
                        .FontName  = "Tahoma"
                        .FontBold  = .T.
                        .FontSize  = 8
                        .ForeColor = RGB(0, 0, 128)
                        .BackStyle = 0
                        .AutoSize  = .T.
                        .Visible   = .T.
                    ENDWITH

                    loc_nTop = loc_nTop + 14

                    *-- Controle de entrada
                    loc_cObjName = "txt_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
                    loc_nHei     = IIF(crSigSyCit.Linhas > 1 OR loc_cTipos = "M", ;
                                       MAX(23, crSigSyCit.Linhas * 16), 23)

                    DO CASE
                        CASE loc_cTipos = "M" AND EMPTY(crSigSyCit.Files)
                            loc_oCnt.AddObject(loc_cObjName, "EditBox")
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), loc_nWid, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = ""
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        CASE loc_cTipos = "D"
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = CTOD("")
                                .InputMask         = "99/99/9999"
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = 80
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        CASE loc_cTipos = "N"
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), 100, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = 0
                                .InputMask         = IIF(EMPTY(loc_cInputMask), "999999999.99", loc_cInputMask)
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH

                        OTHERWISE
                            loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), loc_nWid, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
                            loc_oCnt.AddObject(loc_cObjName, "TextBox")
                            WITH loc_oCnt.&loc_cObjName.
                                .Value             = ""
                                .MaxLength         = IIF(EMPTY(loc_cInputMask), 200, LEN(loc_cInputMask))
                                .Top               = loc_nTop
                                .Left              = loc_nLef
                                .Width             = loc_nWidCtrl
                                .Height            = loc_nHei
                                .ReadOnly          = loc_lReadOnly
                                .DisabledBackColor = RGB(255, 255, 255)
                                .DisabledForeColor = RGB(0, 0, 128)
                                .FontName          = "Tahoma"
                                .FontSize          = 8
                                .Visible           = .T.
                            ENDWITH
                    ENDCASE

                    *-- Registrar no array de controles
                    THIS.this_nNroControles = THIS.this_nNroControles + 1
                    DIMENSION THIS.laControles[THIS.this_nNroControles, 3]
                    THIS.laControles[THIS.this_nNroControles, 1] = loc_cObjName
                    THIS.laControles[THIS.this_nNroControles, 2] = crSigSyCit.Obrigatorios
                    THIS.laControles[THIS.this_nNroControles, 3] = loc_cCampo

                    loc_nTop = loc_nTop + loc_nHei + 4
                ENDSCAN

                *-- Separador antes dos campos fixos de header
                loc_oCnt.AddObject("shp_4c_Sep1", "Shape")
                WITH loc_oCnt.shp_4c_Sep1
                    .Top           = loc_nTop
                    .Left          = 1
                    .Width         = loc_nWid + 9
                    .Height        = 2
                    .SpecialEffect = 0
                    .Visible       = .T.
                ENDWITH
                loc_nTop = loc_nTop + 6

                *-- Labels dos campos fixos (mesma linha)
                loc_oCnt.AddObject("lbl_4c_FEmps", "Label")
                WITH loc_oCnt.lbl_4c_FEmps
                    .Caption   = "Empresa"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 4
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FDopes", "Label")
                WITH loc_oCnt.lbl_4c_FDopes
                    .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 41
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FNumes", "Label")
                WITH loc_oCnt.lbl_4c_FNumes
                    .Caption   = "N" + CHR(250) + "mero"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 196
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FAprova", "Label")
                WITH loc_oCnt.lbl_4c_FAprova
                    .Caption   = "Aprovador"
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 252
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_oCnt.AddObject("lbl_4c_FDatas", "Label")
                WITH loc_oCnt.lbl_4c_FDatas
                    .Caption   = "Data Aprov."
                    .Top       = loc_nTop
                    .Left      = loc_nLef + 335
                    .FontName  = "Tahoma"
                    .FontBold  = .T.
                    .FontSize  = 8
                    .ForeColor = RGB(0, 0, 128)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                loc_nTop = loc_nTop + 14

                *-- TextBoxes dos campos fixos
                loc_oCnt.AddObject("txt_4c_FEmps", "TextBox")
                WITH loc_oCnt.txt_4c_FEmps
                    .Value             = ""
                    .MaxLength         = 3
                    .Top               = loc_nTop
                    .Left              = loc_nLef
                    .Width             = 35
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FDopes", "TextBox")
                WITH loc_oCnt.txt_4c_FDopes
                    .Value             = ""
                    .MaxLength         = 20
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 37
                    .Width             = 155
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FNumes", "TextBox")
                WITH loc_oCnt.txt_4c_FNumes
                    .Value             = ""
                    .MaxLength         = 6
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 194
                    .Width             = 54
                    .Height            = 23
                    .ReadOnly          = loc_lReadOnly
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FAprova", "TextBox")
                WITH loc_oCnt.txt_4c_FAprova
                    .Value             = ""
                    .MaxLength         = 10
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 250
                    .Width             = 80
                    .Height            = 23
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH

                loc_oCnt.AddObject("txt_4c_FDatas", "TextBox")
                WITH loc_oCnt.txt_4c_FDatas
                    .Value             = ""
                    .MaxLength         = 20
                    .Top               = loc_nTop
                    .Left              = loc_nLef + 332
                    .Width             = 122
                    .Height            = 23
                    .ReadOnly          = .T.
                    .DisabledBackColor = RGB(255, 255, 255)
                    .FontName          = "Tahoma"
                    .FontSize          = 8
                    .Visible           = .T.
                ENDWITH
            ENDIF

            THIS.this_lMontouObjetos = .T.
            THIS.this_cModoAtual     = par_cModo
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = THIS.this_nCodAtual

            THIS.TornarControlesVisiveis(THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.MontarObjetos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * DesmontarObjetos - Remove controles dinamicos de cnt_4c_Campos
    *===========================================================================
    PROCEDURE DesmontarObjetos()
        LOCAL loc_oCnt, loc_cNome, loc_cLbl, loc_nIdx
        LOCAL loc_aFixos[11]
        TRY
            IF THIS.this_lMontouObjetos AND VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

                FOR loc_nIdx = 1 TO THIS.this_nNroControles
                    loc_cNome = THIS.laControles[loc_nIdx, 1]
                    loc_cLbl  = STRTRAN(loc_cNome, "txt_4c_F", "lbl_4c_F")
                    IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                        loc_oCnt.RemoveObject(loc_cNome)
                    ENDIF
                    IF TYPE("loc_oCnt.&loc_cLbl.") = "O"
                        loc_oCnt.RemoveObject(loc_cLbl)
                    ENDIF
                ENDFOR

                loc_aFixos[1]  = "shp_4c_Sep1"
                loc_aFixos[2]  = "lbl_4c_FEmps"
                loc_aFixos[3]  = "lbl_4c_FDopes"
                loc_aFixos[4]  = "lbl_4c_FNumes"
                loc_aFixos[5]  = "lbl_4c_FAprova"
                loc_aFixos[6]  = "lbl_4c_FDatas"
                loc_aFixos[7]  = "txt_4c_FEmps"
                loc_aFixos[8]  = "txt_4c_FDopes"
                loc_aFixos[9]  = "txt_4c_FNumes"
                loc_aFixos[10] = "txt_4c_FAprova"
                loc_aFixos[11] = "txt_4c_FDatas"

                FOR loc_nIdx = 1 TO 11
                    loc_cNome = loc_aFixos[loc_nIdx]
                    IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                        loc_oCnt.RemoveObject(loc_cNome)
                    ENDIF
                ENDFOR

                THIS.this_lMontouObjetos = .F.
                THIS.this_nNroControles  = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.DesmontarObjetos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarDados - Popula controles com valores do registro (via LocalCadRs)
    *===========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_oCnt, loc_cObjName, loc_cCampo, loc_cTipos, loc_cVal, loc_nIdx
        TRY
            IF !THIS.this_lMontouObjetos
                RETURN
            ENDIF
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

            IF !USED("LocalCadRs")
                THIS.this_oBusinessObject.ApanhaRespostas()
            ENDIF

            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                loc_cObjName = THIS.laControles[loc_nIdx, 1]
                loc_cCampo   = THIS.laControles[loc_nIdx, 3]

                SELECT crSigSyCit
                LOCATE FOR ALLTRIM(Campos) = loc_cCampo
                IF !EOF("crSigSyCit")
                    loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
                ELSE
                    loc_cTipos = "M"
                ENDIF

                IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR(loc_cCampo, 10), "LocalCadRs", "CodCampos")
                    loc_cVal = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    loc_cVal = ""
                ENDIF

                IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                    DO CASE
                        CASE loc_cTipos = "D"
                            loc_oCnt.&loc_cObjName..Value = IIF(EMPTY(loc_cVal), CTOD(""), CTOD(loc_cVal))
                        CASE loc_cTipos = "N"
                            loc_oCnt.&loc_cObjName..Value = VAL(loc_cVal)
                        OTHERWISE
                            loc_oCnt.&loc_cObjName..Value = loc_cVal
                    ENDCASE
                ENDIF
            ENDFOR

            *-- Campos fixos
            IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                IF TYPE("loc_oCnt.txt_4c_FEmps") = "O"
                    loc_oCnt.txt_4c_FEmps.Value = ALLTRIM(LocalCadRs.Resps)
                ENDIF
            ENDIF
            IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                IF TYPE("loc_oCnt.txt_4c_FDopes") = "O"
                    loc_oCnt.txt_4c_FDopes.Value = ALLTRIM(LocalCadRs.Resps)
                ENDIF
            ENDIF
            IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                IF TYPE("loc_oCnt.txt_4c_FNumes") = "O"
                    loc_oCnt.txt_4c_FNumes.Value = ALLTRIM(LocalCadRs.Resps)
                ENDIF
            ENDIF
            IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                IF TYPE("loc_oCnt.txt_4c_FAprova") = "O"
                    loc_oCnt.txt_4c_FAprova.Value = ALLTRIM(LocalCadRs.Resps)
                ENDIF
            ENDIF
            IF SEEK(STR(THIS.this_nCodAtual, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                IF TYPE("loc_oCnt.txt_4c_FDatas") = "O"
                    loc_oCnt.txt_4c_FDatas.Value = ALLTRIM(LocalCadRs.Resps)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.CarregarDados")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GravarDados - Le controles e preenche crGrvCadRs para o BO salvar
    * Retorna .T. se gravou, .F. se falhou
    *===========================================================================
    FUNCTION GravarDados()
        LOCAL loc_oCnt, loc_cObjName, loc_cCampo, loc_cTipos, loc_cVal
        LOCAL loc_lResultado, loc_lGrv, loc_cPicture, loc_cDescs, loc_nIdx
        loc_lResultado = .F.
        TRY
            IF THIS.this_lMontouObjetos AND USED("crGrvCadRs")
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

            ZAP IN crGrvCadRs

            *-- Campos dinamicos de SigSyCit
            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                loc_cObjName = THIS.laControles[loc_nIdx, 1]
                loc_cCampo   = THIS.laControles[loc_nIdx, 3]

                SELECT crSigSyCit
                LOCATE FOR ALLTRIM(Campos) = loc_cCampo
                IF !EOF("crSigSyCit")
                    loc_cTipos   = ALLTRIM(crSigSyCit.Tipos)
                    loc_cPicture = ALLTRIM(crSigSyCit.Pictures)
                    loc_cDescs   = ALLTRIM(crSigSyCit.Descs)
                ELSE
                    loc_cTipos   = "M"
                    loc_cPicture = ""
                    loc_cDescs   = loc_cCampo
                ENDIF

                IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                    DO CASE
                        CASE loc_cTipos = "M"
                            loc_cVal = ALLTRIM(loc_oCnt.&loc_cObjName..Value)
                        CASE loc_cTipos = "D"
                            loc_cVal = DTOC(loc_oCnt.&loc_cObjName..Value)
                        CASE loc_cTipos = "N"
                            loc_cVal = ALLTRIM(IIF(EMPTY(loc_cPicture), ;
                                STR(loc_oCnt.&loc_cObjName..Value), ;
                                TRANSFORM(loc_oCnt.&loc_cObjName..Value, loc_cPicture)))
                        OTHERWISE
                            loc_cVal = ALLTRIM(loc_oCnt.&loc_cObjName..Value)
                    ENDCASE

                    IF !EMPTY(loc_cVal)
                        INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                            VALUES (THIS.this_cTits, loc_cCampo, THIS.this_nCodAtual, ;
                                    loc_cVal, loc_cDescs, ;
                                    THIS.this_oBusinessObject.this_lChkApro, .F.)
                    ENDIF
                ENDIF
            ENDFOR

            *-- Campos fixos: Emps, Dopes, Numes (determina ChkSubn)
            loc_lGrv = .T.

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FEmps") = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Emps", THIS.this_nCodAtual, ;
                            loc_cVal, "Empresa", THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Dopes", THIS.this_nCodAtual, ;
                            loc_cVal, "Opera" + CHR(231) + CHR(227) + "o", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Numes", THIS.this_nCodAtual, ;
                            loc_cVal, "N" + CHR(250) + "mero", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Baixa", THIS.this_nCodAtual, ;
                            ALLTRIM(gc_4c_UsuarioLogado), "Baixa", ;
                            THIS.this_oBusinessObject.this_lChkApro, .F.)
            ELSE
                loc_lGrv = .F.
            ENDIF

            *-- Aprova/Datas (readonly, preservados se preenchidos)
            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FAprova") = "O", ALLTRIM(loc_oCnt.txt_4c_FAprova.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Aprova", THIS.this_nCodAtual, ;
                            loc_cVal, "Aprovado", .T., loc_lGrv)
            ENDIF

            loc_cVal = IIF(TYPE("loc_oCnt.txt_4c_FDatas") = "O", ALLTRIM(loc_oCnt.txt_4c_FDatas.Value), "")
            IF !EMPTY(loc_cVal)
                INSERT INTO crGrvCadRs (Tits, Campos, Cods, Resps, Pergs, ChkApro, ChkSubn) ;
                    VALUES (THIS.this_cTits, "Datas", THIS.this_nCodAtual, ;
                            loc_cVal, "Data", .T., loc_lGrv)
            ENDIF

            *-- ChkSubn = .T. somente quando Emps+Dopes+Numes todos preenchidos
            REPLACE ALL ChkSubn WITH loc_lGrv IN crGrvCadRs

            loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.GravarDados")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AtualizarBotoesWorkflow - Atualiza estado dos botoes Aprovar/Baixar
    *===========================================================================
    PROCEDURE AtualizarBotoesWorkflow()
        LOCAL loc_oPagina, loc_oAprovar, loc_oBaixar
        TRY
            loc_oPagina  = THIS.pgf_4c_Paginas.Page1
            loc_oAprovar = loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
            loc_oBaixar  = loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar

            IF USED("crSigSyCrs") AND !EOF("crSigSyCrs")
                IF crSigSyCrs.ChkSubn
                    loc_oAprovar.Enabled = .F.
                    loc_oAprovar.Caption = "Aprovar"
                    loc_oBaixar.Caption  = "Canc Baixa"
                    loc_oBaixar.Enabled  = .T.
                ELSE
                    loc_oAprovar.Enabled = .T.
                    loc_oBaixar.Enabled  = .T.
                    loc_oBaixar.Caption  = "Baixar"
                    IF crSigSyCrs.ChkApro
                        loc_oAprovar.Caption = "Desaprovar"
                    ELSE
                        loc_oAprovar.Caption = "Aprovar"
                    ENDIF
                ENDIF
            ELSE
                loc_oAprovar.Enabled = .F.
                loc_oBaixar.Enabled  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.AtualizarBotoesWorkflow")
        ENDTRY
    ENDPROC

    *===========================================================================
    * OptFiltroInteractiveChange - Recarrega lista ao mudar filtro
    *===========================================================================
    PROCEDURE OptFiltroInteractiveChange()
        TRY
            THIS.CarregarLista()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.OptFiltroInteractiveChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GrdAfterRowColChange - Atualiza botoes ao mudar linha do grid
    *===========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
        THIS.AtualizarBotoesWorkflow()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara novo registro
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_nNewCods
        TRY
            loc_nNewCods = THIS.this_oBusinessObject.GerarNovoCods()
            IF loc_nNewCods > 0
                THIS.this_nCodAtual = loc_nNewCods
                THIS.this_oBusinessObject.this_nCods         = loc_nNewCods
                THIS.this_oBusinessObject.this_lNovoRegistro = .T.
                THIS.this_oBusinessObject.this_lEmEdicao     = .T.
                THIS.this_oBusinessObject.this_lChkApro      = .F.
                THIS.this_oBusinessObject.this_lChkSubn      = .F.

                THIS.this_oBusinessObject.InicializarCursores()
                THIS.MontarObjetos("INSERIR")
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nNewCods
                THIS.pgf_4c_Paginas.ActivePage = 2
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar novo c" + ;
                    CHR(243) + "digo.", "Fichas T" + CHR(233) + "cnicas")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Edita registro selecionado no grid
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nCods
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF
            IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
                MsgAviso("Registro aprovado ou baixado n" + CHR(227) + ;
                    "o pode ser alterado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            loc_nCods = crSigSyCrs.Cods
            THIS.this_nCodAtual = loc_nCods
            THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.
            THIS.this_oBusinessObject.this_lEmEdicao     = .T.
            THIS.this_oBusinessObject.InicializarCursores()
            THIS.MontarObjetos("ALTERAR")
            THIS.CarregarDados()
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nCods, loc_lConfirma
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF
            IF crSigSyCrs.ChkApro OR crSigSyCrs.ChkSubn
                MsgAviso("Registro aprovado ou baixado n" + CHR(227) + "o pode ser exclu" + ;
                    CHR(237) + "do.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
                ALLTRIM(STR(crSigSyCrs.Cods)) + "?", "Excluir Ficha")
            IF loc_lConfirma
                loc_nCods = crSigSyCrs.Cods
                THIS.this_oBusinessObject.this_nCods = loc_nCods
                THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
                IF THIS.this_oBusinessObject.Excluir()
                    THIS.this_oBusinessObject.ApanhaRespostas()
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.AlternarPagina")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Exibe registro selecionado em modo leitura (CONSULTAR)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_nCods
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            loc_nCods = crSigSyCrs.Cods
            THIS.this_nCodAtual = loc_nCods
            THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
            THIS.this_oBusinessObject.this_lNovoRegistro = .F.
            THIS.MontarObjetos("CONSULTAR")
            THIS.CarregarDados()
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega lista aplicando filtro atual (optFiltro)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
            IF USED("crSigSyCrs") AND RECCOUNT("crSigSyCrs") > 0
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Valida, grava em crGrvCadRs e persiste via BO
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_nIdx, loc_cObjName, loc_oCnt, loc_lValido
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_lSoDigitos, loc_nChr
        LOCAL loc_cEDN, loc_nResult
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
                THIS.BtnCancelarClick()
                RETURN
            ENDIF

            loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
            loc_lValido = .T.

            *-- Validar campos obrigatorios
            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                IF THIS.laControles[loc_nIdx, 2] = 1
                    loc_cObjName = THIS.laControles[loc_nIdx, 1]
                    IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                        IF EMPTY(loc_oCnt.&loc_cObjName..Value)
                            MsgAviso("Campo de preenchimento obrigat" + CHR(243) + "rio n" + ;
                                CHR(227) + "o preenchido.", "Fichas T" + CHR(233) + "cnicas")
                            loc_oCnt.&loc_cObjName..SetFocus()
                            loc_lValido = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR

            IF !loc_lValido
                RETURN
            ENDIF

            *-- Validar Numes (somente digitos, se preenchido)
            loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")
            IF !EMPTY(loc_cNumes)
                loc_lSoDigitos = .T.
                FOR loc_nChr = 1 TO LEN(loc_cNumes)
                    IF !ISDIGIT(SUBSTR(loc_cNumes, loc_nChr, 1))
                        loc_lSoDigitos = .F.
                        EXIT
                    ENDIF
                ENDFOR
                IF !loc_lSoDigitos
                    MsgAviso("O N" + CHR(250) + "mero da Opera" + CHR(231) + CHR(227) + ;
                        "o digitado n" + CHR(227) + "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                        "Fichas T" + CHR(233) + "cnicas")
                    RETURN
                ENDIF
            ENDIF

            *-- Obter valores dos campos header
            loc_cEmps  = IIF(TYPE("loc_oCnt.txt_4c_FEmps")  = "O", ALLTRIM(loc_oCnt.txt_4c_FEmps.Value),  "")
            loc_cDopes = IIF(TYPE("loc_oCnt.txt_4c_FDopes") = "O", ALLTRIM(loc_oCnt.txt_4c_FDopes.Value), "")
            loc_cNumes = IIF(TYPE("loc_oCnt.txt_4c_FNumes") = "O", ALLTRIM(loc_oCnt.txt_4c_FNumes.Value), "")

            *-- Empresa obrigatoria quando Dopes e Numes informados
            IF EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
                MsgAviso(CHR(201) + " necess" + CHR(225) + "rio preencher a Empresa ao informar" + ;
                    " a Opera" + CHR(231) + CHR(227) + "o e o N" + CHR(250) + "mero.", ;
                    "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            *-- Se Emps+Dopes+Numes preenchidos: deve estar aprovado + validar SigMvCab
            IF !EMPTY(loc_cEmps) AND !EMPTY(loc_cDopes) AND !EMPTY(loc_cNumes)
                IF !THIS.this_oBusinessObject.this_lChkApro
                    MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
                    RETURN
                ENDIF
                loc_cEDN    = PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + PADL(loc_cNumes, 6)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 EmpDopNums FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEDN), ;
                    "cursor_4c_ValidaEDN")
                IF loc_nResult > 0
                    IF EOF("cursor_4c_ValidaEDN")
                        MsgAviso("A Opera" + CHR(231) + CHR(227) + "o com o N" + CHR(250) + ;
                            "mero digitado n" + CHR(227) + "o foi encontrada na Empresa.", ;
                            "Fichas T" + CHR(233) + "cnicas")
                        USE IN cursor_4c_ValidaEDN
                        RETURN
                    ENDIF
                    USE IN cursor_4c_ValidaEDN
                ELSE
                    MsgErro("Erro ao validar SigMvCab:" + CHR(13) + CapturarErroSQL(), ;
                        "FormDrs.BtnSalvarClick")
                    RETURN
                ENDIF
            ENDIF

            *-- Gravar controles em crGrvCadRs e persistir via BO
            IF THIS.GravarDados()
                THIS.this_oBusinessObject.this_nCods = THIS.this_nCodAtual
                THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
                IF THIS.this_oBusinessObject.Salvar()
                    THIS.this_oBusinessObject.ApanhaRespostas()
                    THIS.DesmontarObjetos()
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Descarta edicao e volta para lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.DesmontarObjetos()
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAprovarClick - Aprova ou Desaprova o registro selecionado
    *===========================================================================
    PROCEDURE BtnAprovarClick()
        LOCAL loc_oAprovar, loc_lConfirma
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            loc_oAprovar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Aprovar

            IF !crSigSyCrs.ChkApro
                loc_lConfirma = MsgConfirma("Confirma Aprova" + CHR(231) + CHR(227) + "o?", ;
                    "Fichas T" + CHR(233) + "cnicas")
                IF loc_lConfirma
                    THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
                    IF THIS.this_oBusinessObject.Aprovar(ALLTRIM(gc_4c_UsuarioLogado))
                        SELECT crSigSyCrs
                        REPLACE crSigSyCrs.ChkApro WITH .T.
                        loc_oAprovar.Caption = "Desaprovar"
                        THIS.AtualizarBotoesWorkflow()
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
            ELSE
                loc_lConfirma = MsgConfirma("Confirma Desaprova" + CHR(231) + CHR(227) + "o?", ;
                    "Fichas T" + CHR(233) + "cnicas")
                IF loc_lConfirma
                    THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
                    IF THIS.this_oBusinessObject.Desaprovar()
                        SELECT crSigSyCrs
                        REPLACE crSigSyCrs.ChkApro WITH .F.
                        loc_oAprovar.Caption = "Aprovar"
                        THIS.AtualizarBotoesWorkflow()
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnAprovarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBaixarClick - Baixa (abre Page2 em ALTERAR) ou Cancela Baixa
    *===========================================================================
    PROCEDURE BtnBaixarClick()
        LOCAL loc_oBaixar, loc_lConfirma, loc_nCods
        TRY
            IF !USED("crSigSyCrs") OR EOF("crSigSyCrs")
                MsgAviso("Nenhum registro selecionado.", "Fichas T" + CHR(233) + "cnicas")
                RETURN
            ENDIF

            loc_oBaixar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Baixar

            IF !crSigSyCrs.ChkSubn
                *-- Baixar: exige aprovacao previa
                IF !crSigSyCrs.ChkApro
                    MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")
                    RETURN
                ENDIF
                *-- Abre Page2 em modo ALTERAR para preencher Emps/Dopes/Numes
                loc_nCods = crSigSyCrs.Cods
                THIS.this_nCodAtual = loc_nCods
                THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCods)
                THIS.this_oBusinessObject.this_lNovoRegistro = .F.
                THIS.this_oBusinessObject.this_lEmEdicao     = .T.
                THIS.this_oBusinessObject.InicializarCursores()
                THIS.MontarObjetos("ALTERAR")
                THIS.CarregarDados()
                THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = loc_nCods
                THIS.pgf_4c_Paginas.ActivePage = 2
                THIS.this_cModoAtual = "ALTERAR"
            ELSE
                *-- Cancelar Baixa
                loc_lConfirma = MsgConfirma("Confirma Cancelamento da Baixa?", ;
                    "Fichas T" + CHR(233) + "cnicas")
                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CancelarBaixa(crSigSyCrs.Cods)
                        SELECT crSigSyCrs
                        REPLACE crSigSyCrs.ChkSubn WITH .F.
                        loc_oBaixar.Caption = "Baixar"
                        THIS.AtualizarBotoesWorkflow()
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.BtnBaixarClick")
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
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores da UI para o BO (via crGrvCadRs)
    * Wrapper canonico do padrao CRUD; delega para GravarDados() que popula
    * crGrvCadRs (usado pelo DrsBO.Salvar) e propriedades this_ do BO.
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.this_nCods = THIS.this_nCodAtual
            THIS.this_oBusinessObject.this_cTits = THIS.this_cTits
            loc_lResultado = THIS.GravarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.FormParaBO")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do BO para a UI (via LocalCadRs)
    * Wrapper canonico do padrao CRUD; delega para CarregarDados() que le
    * LocalCadRs (cursor mantido pelo DrsBO.ApanhaRespostas) e popula controles.
    *===========================================================================
    PROCEDURE BOParaForm()
        TRY
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = THIS.this_oBusinessObject.this_nCods
            THIS.this_nCodAtual = THIS.this_oBusinessObject.this_nCods
            THIS.CarregarDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita controles editaveis de cnt_4c_Campos
    * par_lHabilitar: .T. para habilitar (INSERIR/ALTERAR), .F. para bloquear (CONSULTAR)
    * txt_4c_FAprova e txt_4c_FDatas permanecem sempre readonly (populados pelo sistema).
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt, loc_nIdx, loc_cObjName, loc_lReadOnly, loc_cNome, loc_oCtl
        LOCAL loc_aEdit[3], loc_aReadOnly[2]
        TRY
            IF !THIS.this_lMontouObjetos
                RETURN
            ENDIF
            loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos
            loc_lReadOnly = !par_lHabilitar

            *-- Campos dinamicos de SigSyCit
            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                loc_cObjName = THIS.laControles[loc_nIdx, 1]
                IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                    loc_oCnt.&loc_cObjName..ReadOnly = loc_lReadOnly
                    loc_oCnt.&loc_cObjName..Enabled  = .T.
                ENDIF
            ENDFOR

            *-- Campos fixos editaveis
            loc_aEdit[1] = "txt_4c_FEmps"
            loc_aEdit[2] = "txt_4c_FDopes"
            loc_aEdit[3] = "txt_4c_FNumes"
            FOR loc_nIdx = 1 TO 3
                loc_cNome = loc_aEdit[loc_nIdx]
                IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                    loc_oCtl          = EVALUATE("loc_oCnt." + loc_cNome)
                    loc_oCtl.ReadOnly = loc_lReadOnly
                    loc_oCtl.Enabled  = .T.
                ENDIF
            ENDFOR

            *-- Campos fixos sempre readonly
            loc_aReadOnly[1] = "txt_4c_FAprova"
            loc_aReadOnly[2] = "txt_4c_FDatas"
            FOR loc_nIdx = 1 TO 2
                loc_cNome = loc_aReadOnly[loc_nIdx]
                IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                    loc_oCtl          = EVALUATE("loc_oCnt." + loc_cNome)
                    loc_oCtl.ReadOnly = .T.
                ENDIF
            ENDFOR

            *-- Ajustar botoes conforme modo atual
            THIS.AjustarBotoesPorModo()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Zera todos os controles editaveis de Page2
    * Aplicado ao entrar em INSERIR ou apos cancelar edicao.
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt, loc_nIdx, loc_cObjName, loc_cTipos, loc_cCampo, loc_cNome, loc_oCtl
        LOCAL loc_aFixos[5]
        TRY
            THIS.pgf_4c_Paginas.Page2.txt_4c_Cods.Value = 0

            IF !THIS.this_lMontouObjetos
                RETURN
            ENDIF
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Campos

            *-- Campos dinamicos: zerar conforme tipo
            FOR loc_nIdx = 1 TO THIS.this_nNroControles
                loc_cObjName = THIS.laControles[loc_nIdx, 1]
                loc_cCampo   = THIS.laControles[loc_nIdx, 3]

                SELECT crSigSyCit
                LOCATE FOR ALLTRIM(Campos) = loc_cCampo
                IF !EOF("crSigSyCit")
                    loc_cTipos = ALLTRIM(crSigSyCit.Tipos)
                ELSE
                    loc_cTipos = "M"
                ENDIF

                IF TYPE("loc_oCnt.&loc_cObjName.") = "O"
                    DO CASE
                        CASE loc_cTipos = "D"
                            loc_oCnt.&loc_cObjName..Value = CTOD("")
                        CASE loc_cTipos = "N"
                            loc_oCnt.&loc_cObjName..Value = 0
                        OTHERWISE
                            loc_oCnt.&loc_cObjName..Value = ""
                    ENDCASE
                ENDIF
            ENDFOR

            *-- Campos fixos: todos texto
            loc_aFixos[1] = "txt_4c_FEmps"
            loc_aFixos[2] = "txt_4c_FDopes"
            loc_aFixos[3] = "txt_4c_FNumes"
            loc_aFixos[4] = "txt_4c_FAprova"
            loc_aFixos[5] = "txt_4c_FDatas"
            FOR loc_nIdx = 1 TO 5
                loc_cNome = loc_aFixos[loc_nIdx]
                IF TYPE("loc_oCnt.&loc_cNome.") = "O"
                    loc_oCtl       = EVALUATE("loc_oCnt." + loc_cNome)
                    loc_oCtl.Value = ""
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormDrs.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme this_cModoAtual
    * LISTA:      CRUD ativos, Salvar/Cancelar inativos
    * INSERIR/ALTERAR: Salvar/Cancelar ativos, CRUD inativos
    * VISUALIZAR: apenas Cancelar (voltar) ativo
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCrud, loc_oAcao, loc_cModo
        TRY
            loc_oCrud = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_oAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))

            DO CASE
                CASE loc_cModo = "LISTA"
                    loc_oCrud.cmd_4c_Incluir.Enabled    = .T.
                    loc_oCrud.cmd_4c_Visualizar.Enabled = .T.
                    loc_oCrud.cmd_4c_Alterar.Enabled    = .T.
                    loc_oCrud.cmd_4c_Excluir.Enabled    = .T.
                    loc_oCrud.cmd_4c_Buscar.Enabled     = .T.
                    loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
                    loc_oAcao.cmd_4c_Cancelar.Enabled   = .F.

                CASE INLIST(loc_cModo, "INSERIR", "ALTERAR")
                    loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
                    loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
                    loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
                    loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
                    loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
                    loc_oAcao.cmd_4c_Confirmar.Enabled  = .T.
                    loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.

                CASE loc_cModo = "VISUALIZAR"
                    loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
                    loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
                    loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
                    loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
                    loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
                    loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
                    loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Limpa recursos ao fechar
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            THIS.DesmontarObjetos()
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.FecharCursores()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormDrs.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DrsBO.prg):
*===============================================================================
* DrsBO.prg - Business Object para Fichas Tecnicas (SigSyCrs)
* Herda de BusinessBase
*
* Tabela principal: SigSyCrs
* Tabela config: SigSyCit
*
* MODELO DE DADOS (key-value store):
*   SigSyCrs (Tits C20, Cods N, Campos C10, Resps M, Pergs C, cIdChaves C,
*             ChkApro L, ChkSubn L)
*   SigSyCit (Tits C20, Campos C10, Descs C, Tipos C1, Ordems N, Listas N,
*             Linhas N, Files C, Fields C, Chaves C, cIdChaves C, CampoOAs C,
*             CampoDAs C, Associados C, Cadeado N, Vinculados C,
*             Obrigatorios L, Pictures C)
*
* Um "registro logico" = conjunto de rows em SigSyCrs com mesmo (Tits, Cods).
* Cada row armazena um campo: Campos=nome, Resps=valor, Pergs=rotulo.
* cIdChaves e a PK fisica de cada row individual.
*===============================================================================

DEFINE CLASS DrsBO AS BusinessBase

    *---------------------------------------------------------------------------
    * Identificacao do registro logico (Tits + Cods formam a PK logica)
    *---------------------------------------------------------------------------
    this_cTits   = ""   && Tipo de ficha C(20) - identifica o formulario/processo
    this_nCods   = 0    && Codigo do registro (PK logica dentro do Tits)

    *---------------------------------------------------------------------------
    * Status do workflow de aprovacao/baixa
    *---------------------------------------------------------------------------
    this_lChkApro  = .F.    && Aprovado
    this_lChkSubn  = .F.    && Baixado/Encerrado (ChkSubn)

    *---------------------------------------------------------------------------
    * Campos fixos de cabecalho (armazenados como key-value em SigSyCrs)
    * Campos = 'Emps', 'Dopes', 'Numes', 'Aprova', 'Datas', 'Baixa'
    *---------------------------------------------------------------------------
    this_cEmps   = ""   && Empresa (C3) - referencia SigCdEmp.CEmps
    this_cDopes  = ""   && Operacao (C20) - referencia SigCdOpe.Dopes
    this_cNumes  = ""   && Numero da operacao (C6)
    this_cAprova = ""   && Aprovador - usuario que aprovou (C10)
    this_cDatas  = ""   && Data de aprovacao como string (C20)
    this_cBaixa  = ""   && Usuario que registrou baixa (C10)

    *---------------------------------------------------------------------------
    * Nomes dos cursores de trabalho (mantidos como constantes aqui para
    * referencia cruzada com o Form)
    *---------------------------------------------------------------------------
    this_cCursorRs    = "crGrvCadRs"    && Cursor escrita SigSyCrs (key=cIdChaves)
    this_cCursorLista = "crSigSyCrs"    && Cursor lista SigSyCrs (key=Cods)
    this_cCursorCit   = "crSigSyCit"    && Cursor config SigSyCit
    this_cCursorLocal = "LocalCadRs"    && Cursor local de respostas (key=CodCampos)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigSyCrs"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Fecha cursores ao destruir o BO
    *===========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN EscaparSQL(ALLTRIM(THIS.this_cTits)) + ", " + ;
               FormatarNumeroSQL(THIS.this_nCods)
    ENDFUNC

    *===========================================================================
    * FecharCursores - Fecha todos os cursores de trabalho
    *===========================================================================
    PROCEDURE FecharCursores()
        IF USED("crSigSyCrs")
            USE IN crSigSyCrs
        ENDIF
        IF USED("LocalCadRs")
            USE IN LocalCadRs
        ENDIF
        IF USED("crSigSyCit")
            USE IN crSigSyCit
        ENDIF
        IF USED("crGrvCadRs")
            USE IN crGrvCadRs
        ENDIF
    ENDPROC

    *===========================================================================
    * InicializarCursores - Cria cursor de escrita crGrvCadRs
    *===========================================================================
    FUNCTION InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crGrvCadRs")
                USE IN crGrvCadRs
            ENDIF
            SET NULL ON
            CREATE CURSOR crGrvCadRs ( ;
                Tits      C(20),  ;
                Campos    C(10),  ;
                Cods      N(10,0), ;
                cIdChaves C(38),  ;
                Resps     M,      ;
                Pergs     C(200), ;
                ChkApro   L,      ;
                ChkSubn   L )
            SET NULL OFF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarSigSyCit - Carrega definicoes de campos de SigSyCit para este Tits
    *===========================================================================
    FUNCTION CarregarSigSyCit()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crSigSyCit")
                USE IN crSigSyCit
            ENDIF

            *-- Test mode without DB: create empty cursor so form can initialize
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCit (Tits C(20), Campos C(10), Descs C(60), Tipos C(1), ;
                    Ordems N(3,0), Listas N(1,0), Linhas N(3,0), Files C(200), Fields C(200), ;
                    Chaves C(100), cIdChaves C(38), CampoOAs C(20), CampoDAs C(20), ;
                    Associados C(100), Cadeado N(1,0), Vinculados C(100), ;
                    Obrigatorios N(1,0), Pictures C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE

            loc_cSQL = "SELECT Tits, Campos, Descs, Tipos, Ordems, Listas, Linhas, Files," + ;
                       " Fields, Chaves, cIdChaves, CampoOAs, CampoDAs, Associados, Cadeado," + ;
                       " Vinculados, Obrigatorios, Pictures FROM SigSyCit" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + " ORDER BY Ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCit")
            IF loc_nResult > 0
                IF RECCOUNT("crSigSyCit") > 0
                    SELECT crSigSyCit
                    INDEX ON STR(Ordems, 2) TAG Ordems ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar SigSyCit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && gnConnHandle
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ApanhaRespostas - Carrega todas as respostas de SigSyCrs em LocalCadRs indexado
    *===========================================================================
    FUNCTION ApanhaRespostas()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalCadRs")
                USE IN LocalCadRs
            ENDIF
            loc_cSQL = "SELECT Cods, Campos, CAST(Resps AS VARCHAR(8000)) AS Resps" + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " ORDER BY Cods, Campos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCadRs")
            IF loc_nResult > 0
                IF RECCOUNT("LocalCadRs") > 0
                    SELECT LocalCadRs
                    INDEX ON STR(Cods, 6) + Campos TAG CodCampos ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar respostas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AlimentaLista - Preenche colunas dinamicas de crSigSyCrs via LocalCadRs
    *===========================================================================
    PROCEDURE AlimentaLista()
        LOCAL loc_cCpo
        TRY
            IF USED("crSigSyCrs") AND USED("LocalCadRs") AND USED("crSigSyCit") ;
                    AND RECCOUNT("crSigSyCrs") > 0 AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCrs
                SCAN
                    SELECT crSigSyCit
                    SCAN
                        IF crSigSyCit.Listas = 1
                            loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                            IF SEEK(STR(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, ;
                                    "LocalCadRs", "CodCampos")
                                IF crSigSyCit.Tipos = "N"
                                    REPLACE &loc_cCpo. WITH VAL(LocalCadRs.Resps) IN crSigSyCrs
                                ELSE
                                    REPLACE &loc_cCpo. WITH LocalCadRs.Resps IN crSigSyCrs
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN
                    SELECT crSigSyCrs
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista registros em crSigSyCrs com colunas dinamicas de SigSyCit
    * par_cFiltro: ""/"TODAS"=todos; "PENDENTES"=nao-baixados; "BAIXADAS"=baixados
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado, loc_cCpo
        loc_lResultado = .F.
        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF
        TRY
            IF !USED("crSigSyCit")
                THIS.CarregarSigSyCit()
            ENDIF
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            DO CASE
                CASE UPPER(ALLTRIM(par_cFiltro)) = "PENDENTES"
                    loc_cWhere = " AND ChkSubn = 0"
                CASE UPPER(ALLTRIM(par_cFiltro)) = "BAIXADAS"
                    loc_cWhere = " AND ChkSubn = 1"
                OTHERWISE
                    loc_cWhere = ""
            ENDCASE
            loc_cSQL = "SELECT DISTINCT ChkSubn, ChkApro, Cods"
            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                        DO CASE
                            CASE crSigSyCit.Tipos = "N"
                                loc_cSQL = loc_cSQL + ;
                                           ", CAST(9999999999.99 AS DECIMAL(14,2)) AS " + loc_cCpo
                            CASE crSigSyCit.Tipos = "M"
                                loc_cSQL = loc_cSQL + ", SPACE(50) AS " + loc_cCpo
                            OTHERWISE
                                loc_cSQL = loc_cSQL + ", SPACE(12) AS " + loc_cCpo
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       loc_cWhere + " ORDER BY Cods"
            IF USED("crSigSyCrs")
                USE IN crSigSyCrs
            ENDIF
            *-- Test mode without DB: create empty cursor
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCrs (ChkSubn L, ChkApro L, Cods N(10,0))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCrs")
                IF loc_nResult > 0
                    THIS.AlimentaLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * GerarNovoCods - Gera proximo Cods disponivel para este Tits
    *===========================================================================
    FUNCTION GerarNovoCods()
        LOCAL loc_cSQL, loc_nCods, loc_nResult
        loc_nCods = 0
        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Cods), 0) + 1 AS NextCods FROM SigSyCrs" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_NextCods")
                TABLEREVERT(.T., "cursor_4c_NextCods")
                USE IN cursor_4c_NextCods
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextCods")
            IF loc_nResult > 0 AND !EOF("cursor_4c_NextCods")
                loc_nCods = cursor_4c_NextCods.NextCods
                USE IN cursor_4c_NextCods
            ELSE
                MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_NextCods")
                    USE IN cursor_4c_NextCods
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCods
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCods    = TratarNulo(Cods, "N")
                THIS.this_lChkApro = (TratarNulo(ChkApro, "N") <> 0)
                THIS.this_lChkSubn = (TratarNulo(ChkSubn, "N") <> 0)
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega propriedades do BO para um Cods especifico
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            IF USED("LocalCadRs")
                THIS.this_nCods = par_nCods
                IF SEEK(STR(par_nCods, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cEmps = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cEmps = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDopes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDopes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cNumes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cNumes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cAprova = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cAprova = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDatas = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDatas = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Baixa", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cBaixa = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cBaixa = ""
                ENDIF
            ENDIF
            IF USED("crSigSyCrs")
                SELECT crSigSyCrs
                LOCATE FOR Cods = par_nCods
                IF !EOF("crSigSyCrs")
                    THIS.this_lChkApro = crSigSyCrs.ChkApro
                    THIS.this_lChkSubn = crSigSyCrs.ChkSubn
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_cSQL = "SELECT TOP 1 ChkApro, ChkSubn FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(par_nCods)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CarregaFlags")
                    TABLEREVERT(.T., "cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFlags")
                IF loc_nResult > 0 AND !EOF("cursor_4c_CarregaFlags")
                    THIS.this_lChkApro = (cursor_4c_CarregaFlags.ChkApro <> 0)
                    THIS.this_lChkSubn = (cursor_4c_CarregaFlags.ChkSubn <> 0)
                    loc_lResultado = .T.
                ENDIF
                IF USED("cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF
            ENDIF
            IF loc_lResultado
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarCampos - PRIVADO - Executa DELETE+INSERT de crGrvCadRs em SigSyCrs
    * Retorna .T. se salvou com sucesso
    *===========================================================================
    PROTECTED FUNCTION SalvarCampos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_lTransacao
        loc_lResultado = .F.
        loc_lTransacao = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 0
                loc_lTransacao = .T.
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF loc_lTransacao
                loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                           EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao excluir registros anteriores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
            IF loc_lTransacao AND USED("crGrvCadRs") AND RECCOUNT("crGrvCadRs") > 0
                SELECT crGrvCadRs
                SCAN WHILE loc_lTransacao
                    loc_cSQL = "INSERT INTO SigSyCrs" + ;
                               " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Tits)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Campos)) + ", " + ;
                               FormatarNumeroSQL(crGrvCadRs.Cods) + ", " + ;
                               "CAST(NEWID() AS VARCHAR(38)), " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Resps)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Pergs)) + ", " + ;
                               IIF(crGrvCadRs.ChkApro, "1", "0") + ", " + ;
                               IIF(crGrvCadRs.ChkSubn, "1", "0") + ;
                               ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir campo '" + ALLTRIM(crGrvCadRs.Campos) + ;
                                "':" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lTransacao = .F.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_lTransacao
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacao = .F.
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro no commit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - Salva novo registro (chamado por BusinessBase.Salvar)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - Atualiza registro existente (chamado por BusinessBase.Salvar)
    * Usa padrao delete-insert identico ao original
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - Exclui todos os campos de um registro logico (Tits+Cods)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Aprovar - Aprova o registro atual (seta ChkApro=.T., grava Aprova/Datas)
    * par_cUsuario: nome do usuario que esta aprovando
    *===========================================================================
    FUNCTION Aprovar(par_cUsuario)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cDataHora
        loc_lResultado = .F.
        TRY
            loc_cDataHora = TTOC(DATETIME())
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "INSERT INTO SigSyCrs" + ;
                       " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTits) + ", 'Aprova', " + ;
                       FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                       "CAST(NEWID() AS VARCHAR(38)), " + ;
                       EscaparSQL(ALLTRIM(par_cUsuario)) + ", 'Aprovado', 1, 0)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_cSQL = "INSERT INTO SigSyCrs" + ;
                           " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cTits) + ", 'Datas', " + ;
                           FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                           "CAST(NEWID() AS VARCHAR(38)), " + ;
                           EscaparSQL(loc_cDataHora) + ", 'Data', 1, 0)"
                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 1" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.this_lChkApro = .T.
                    THIS.this_cAprova  = ALLTRIM(par_cUsuario)
                    THIS.this_cDatas   = loc_cDataHora
                    THIS.ApanhaRespostas()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao aprovar registro:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gravar aprovador:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Desaprovar - Remove aprovacao do registro atual (seta ChkApro=.F.)
    *===========================================================================
    FUNCTION Desaprovar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkApro = .F.
                THIS.this_cAprova  = ""
                THIS.this_cDatas   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao desaprovar registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CancelarBaixa - Cancela baixa do registro (seta ChkSubn=.F., remove campos de baixa)
    *===========================================================================
    FUNCTION CancelarBaixa(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods) + ;
                       " AND Campos IN ('Emps', 'Dopes', 'Numes', 'Baixa')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkSubn = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkSubn = .F.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cNumes   = ""
                THIS.this_cBaixa   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao cancelar baixa:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

