# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigrecorBO.prg] Indicador de pendencia: * Business Object para Relatorio de Comissao Pendente
[sigrecorBO.prg] Indicador de pendencia: *-- this_nOptPenPag: 0=Nao  1=Sim (pendente
[sigrecorBO.prg] Indicador de pendencia: * PrepararDados - Processa dados do relatorio Comissao Pendente
[sigrecorBO.prg] Indicador de pendencia: *-- Processamento de pendente
[sigrecorBO.prg] Indicador de pendencia: *-- Aplica filtros SNA (Sim/Nao/Ambos) e Pendente
[Formsigrecor.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[Formsigrecor.prg] Indicador de pendencia: * Relat" + CHR(243) + "rio: Comiss" + CHR(227) + "o Pendente
[Formsigrecor.prg] Indicador de pendencia: *   - Pendente
[Formsigrecor.prg] Indicador de pendencia: *-- CheckBox Pendente
[Formsigrecor.prg] Indicador de pendencia: * OptPenPagClick - Click no CheckBox Pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecor.prg):
*==============================================================================
* FORMSIGRECOR.PRG
* Relat" + CHR(243) + "rio: Comiss" + CHR(227) + "o Pendente por Vendedor
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECOR.SCX (frmrelatorio)
*
* Filtros:
*   - Per" + CHR(237) + "odo (data inicial / data final)
*   - Grupo de estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - fAcessoContab)
*   - Conta de estoque  (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - fAcessoContas)
*   - Moeda (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe, via fwBuscaExt)
*   - Op" + CHR(231) + CHR(227) + "o SNA (Sim / N" + CHR(227) + "o / Ambos)
*   - Tipo (Anal" + CHR(237) + "tico / Sint" + CHR(233) + "tico / Resumo)
*   - Quebra (Datas / Data+Movimenta" + CHR(231) + CHR(227) + "o / Cliente)
*   - Pendente de Pagamento (CheckBox)
*
* FASE 3/8 - Estrutura base do form
*   * Propriedades visuais do form (Width=800, Height=300, TitleBar=0)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes()    (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame() (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*==============================================================================

DEFINE CLASS Formsigrecor AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=300)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Refer" + CHR(234) + "ncia ao BO de relat" + CHR(243) + "rio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formul" + CHR(225) + "rio de relat" + CHR(243) + "rio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrecorBO
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Comiss" + CHR(227) + "o Pendente por Vendedor"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO do relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecorBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecorBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente ao cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro em Page1
                THIS.ConfigurarPaginaLista()

                *-- Vincula eventos (BINDEVENTs) dos botoes e campos (Fase 5)
                THIS.ConfigurarPaginaDados()

                *-- Inicializa filtros com valores padrao
                THIS.LimparCampos()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com t" + CHR(237) + "tulo do relat" + CHR(243) + "rio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra (deslocada 2px para efeito 3D do texto branco)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Comiss" + CHR(227) + "o Pendente por Vendedor"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
    *   Original: btnReport.Left=529, Top=0, ButtonCount=4
    *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
    *   BINDEVENTs Click s" + CHR(227) + "o vinculados na Fase 7.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            *-- Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora padr" + CHR(227) + "o)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Excel (exportar dados)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Encerrar (fechar form)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 p" + CHR(225) + "gina ("Filtros")
    *   O form legado SIGRECOR " + CHR(233) + " FLAT (controles direto no form), mas no novo
    *   padr" + CHR(227) + "o os campos s" + CHR(227) + "o agrupados em PageFrame de 1 p" + CHR(225) + "gina para
    *   consist" + CHR(234) + "ncia com o restante do sistema.
    *
    *   Posicionamento: abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form (300px).
    *   Os campos de filtro s" + CHR(227) + "o adicionados em ConfigurarPaginaLista() (Fase 4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos do relat" + CHR(243) + "rio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles de filtro em Page1 (Filtros)
    *   Form REPORT: Page1 contem campos de filtro (sem grid, sem CRUD).
    *   Replica layout flat do legado SIGRECOR dentro do PageFrame.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- --- Periodo ---
            loc_oPagina.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPagina.lbl_4c_Label1
                .Top       = 15
                .Left      = 191
                .Width     = 50
                .Height    = 15
                .Caption   = "Per" + CHR(237) + "odo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_inicial", "TextBox")
            WITH loc_oPagina.txt_4c__dt_inicial
                .Top         = 11
                .Left        = 240
                .Width       = 80
                .Height      = 25
                .Value       = {}
                .Format      = "D"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPagina.lbl_4c_Label4
                .Top       = 16
                .Left      = 324
                .Width     = 20
                .Height    = 15
                .Caption   = "at" + CHR(233)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__dt_final", "TextBox")
            WITH loc_oPagina.txt_4c__dt_final
                .Top         = 11
                .Left        = 348
                .Width       = 80
                .Height      = 25
                .Value       = {}
                .Format      = "D"
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Grupo de Estoque ---
            loc_oPagina.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPagina.lbl_4c_Label3
                .Top       = 40
                .Left      = 198
                .Width     = 38
                .Height    = 15
                .Caption   = "Grupo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Cd_GrEstoque
                .Top         = 36
                .Left        = 240
                .Width       = 79
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
            WITH loc_oPagina.txt_4c__Ds_GrEstoque
                .Top         = 36
                .Left        = 321
                .Width       = 290
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Conta de Estoque ---
            loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_estoque
                .Top       = 67
                .Left      = 198
                .Width     = 38
                .Height    = 15
                .Caption   = "Conta :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__cd_estoque
                .Top         = 63
                .Left        = 240
                .Width       = 79
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_estoque", "TextBox")
            WITH loc_oPagina.txt_4c__ds_estoque
                .Top         = 63
                .Left        = 321
                .Width       = 290
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- --- Moeda ---
            loc_oPagina.AddObject("lbl_4c_Lbl_moeda", "Label")
            WITH loc_oPagina.lbl_4c_Lbl_moeda
                .Top       = 94
                .Left      = 195
                .Width     = 42
                .Height    = 15
                .Caption   = "Moeda :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__cd_moeda", "TextBox")
            WITH loc_oPagina.txt_4c__cd_moeda
                .Top         = 90
                .Left        = 240
                .Width       = 31
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c__ds_moeda", "TextBox")
            WITH loc_oPagina.txt_4c__ds_moeda
                .Top         = 90
                .Left        = 273
                .Width       = 115
                .Height      = 25
                .Value       = ""
                .FontName    = "Tahoma"
                .FontSize    = 8
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .BorderStyle = 1
                .Visible     = .T.
            ENDWITH

            *-- CheckBox Pendente de Pagamento
            loc_oPagina.AddObject("chk_4c_OptPenPag", "CheckBox")
            WITH loc_oPagina.chk_4c_OptPenPag
                .Top       = 94
                .Left      = 442
                .Width     = 136
                .Height    = 15
                .Caption   = "Pendente de Pagamento"
                .Value     = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .BackColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH

            *-- --- Opcao SNA (Sim / Nao / Ambos) ---
            loc_oPagina.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPagina.lbl_4c_Label6
                .Top       = 120
                .Left      = 196
                .Width     = 42
                .Height    = 15
                .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptSNA", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptSNA
                .Top         = 116
                .Left        = 235
                .Width       = 220
                .Height      = 23
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 3
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Sim"
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 73
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "N" + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 146
                    .Width     = 74
                    .Height    = 23
                    .Caption   = "Ambos"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- --- Tipo (Analitico / Sintetico / Resumo) ---
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .Top       = 145
                .Left      = 207
                .Width     = 30
                .Height    = 15
                .Caption   = "Tipo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptTipo
                .Top         = 141
                .Left        = 235
                .Width       = 220
                .Height      = 23
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Anal" + CHR(237) + "tico"
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 73
                    .Width     = 73
                    .Height    = 23
                    .Caption   = "Sint" + CHR(233) + "tico"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 146
                    .Width     = 74
                    .Height    = 23
                    .Caption   = "Resumo"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *-- --- Quebra (Datas / Data+Mov. / Cliente) ---
            loc_oPagina.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPagina.lbl_4c_Label5
                .Top       = 168
                .Left      = 191
                .Width     = 45
                .Height    = 15
                .Caption   = "Quebra :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("obj_4c_OptQuebras", "OptionGroup")
            WITH loc_oPagina.obj_4c_OptQuebras
                .Top         = 164
                .Left        = 235
                .Width       = 303
                .Height      = 25
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.
                WITH .Buttons(1)
                    .Top       = 0
                    .Left      = 0
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Datas"
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(2)
                    .Top       = 0
                    .Left      = 101
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Data+Mov."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
                WITH .Buttons(3)
                    .Top       = 0
                    .Left      = 202
                    .Width     = 101
                    .Height    = 25
                    .Caption   = "Cliente"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .BackColor = RGB(255, 255, 255)
                    .ForeColor = RGB(90, 90, 90)
                    .Visible   = .T.
                ENDWITH
            ENDWITH

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reinicia filtros com valores padrao
    *   Data inicial/final = DATE(); opcoes = defaults do BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro, loc_nResultMoe
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.txt_4c__dt_inicial.Value   = DATE()
            loc_oPagina.txt_4c__dt_final.Value     = DATE()
            loc_oPagina.txt_4c__Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            *-- Moeda padrao: R$ (identico ao Init do legado que inicializava com 'R')
            loc_oPagina.txt_4c__cd_moeda.Value = "R"
            loc_nResultMoe = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = 'R'", ;
                "cursor_4c_MoeInit")
            IF loc_nResultMoe > 0
                SELECT cursor_4c_MoeInit
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    loc_oPagina.txt_4c__ds_moeda.Value = ""
                ENDIF
                USE IN cursor_4c_MoeInit
            ELSE
                IF USED("cursor_4c_MoeInit")
                    USE IN cursor_4c_MoeInit
                ENDIF
                loc_oPagina.txt_4c__ds_moeda.Value = ""
            ENDIF
            loc_oPagina.obj_4c_OptSNA.Value        = 3
            loc_oPagina.obj_4c_OptTipo.Value       = 1
            loc_oPagina.obj_4c_OptQuebras.Value    = 1
            loc_oPagina.chk_4c_OptPenPag.Value     = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial   = loc_oPagina.txt_4c__dt_inicial.Value
            .this_dDtFinal     = loc_oPagina.txt_4c__dt_final.Value
            .this_cCdGrEstoque = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
            .this_cDsGrEstoque = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
            .this_cCdEstoque   = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
            .this_cDsEstoque   = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
            .this_cCdMoeda     = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
            .this_cDsMoeda     = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
            .this_nOptSNA      = loc_oPagina.obj_4c_OptSNA.Value
            .this_nOptTipo     = loc_oPagina.obj_4c_OptTipo.Value
            .this_nOptQuebras  = loc_oPagina.obj_4c_OptQuebras.Value
            .this_nOptPenPag   = loc_oPagina.chk_4c_OptPenPag.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Vincula BINDEVENTs dos botoes e dos campos de
    * filtro (primeira metade: datas + grupo de estoque + conta de estoque).
    * O form REPORT nao tem Page2/Dados - todos os controles estao em Page1.
    * Fase 5/8: botoes do relatorio + campos data + grupo + conta de estoque.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

            *-- Campos de data (handler trivial - dados tipo D nao precisam de lookup)
            BINDEVENT(loc_oPagina.txt_4c__dt_inicial, "KeyPress", THIS, "TeclaDataInicial")
            BINDEVENT(loc_oPagina.txt_4c__dt_final,   "KeyPress", THIS, "TeclaDataFinal")

            *-- Grupo de Estoque: F4 abre busca; Enter/Tab valida codigo e preenche desc
            BINDEVENT(loc_oPagina.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")
            BINDEVENT(loc_oPagina.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

            *-- Conta de Estoque: F4 abre busca filtrada por grupo; Enter/Tab valida
            BINDEVENT(loc_oPagina.txt_4c__cd_estoque, "KeyPress", THIS, "TeclaCdEstoque")
            BINDEVENT(loc_oPagina.txt_4c__ds_estoque, "KeyPress", THIS, "TeclaDsEstoque")

            *-- Moeda: F4 abre busca; Enter/Tab valida codigo e preenche descricao
            BINDEVENT(loc_oPagina.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")
            BINDEVENT(loc_oPagina.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")

            *-- OptionGroups e CheckBox: Click handlers para controle mutuo (padrao legado)
            BINDEVENT(loc_oPagina.obj_4c_OptTipo,    "Click", THIS, "OptTipoClick")
            BINDEVENT(loc_oPagina.obj_4c_OptQuebras, "Click", THIS, "OptQuebrasClick")
            BINDEVENT(loc_oPagina.chk_4c_OptPenPag,  "Click", THIS, "OptPenPagClick")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Visualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF !THIS.this_oRelatorio.Imprimir()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArq, loc_oErro
        TRY
            THIS.FormParaRelatorio()
            IF THIS.this_oRelatorio.PrepararDados()
                IF USED("cursor_4c_Analitico")
                    loc_cArq = ADDBS(SYS(2023)) + "sigrecor_" + DTOS(DATE()) + ".xls"
                    SELECT cursor_4c_Analitico
                    SET SAFETY OFF
                    COPY TO (loc_cArq) TYPE XL5
                    SET SAFETY ON
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArq, "Excel")
                ELSE
                    MsgAviso("Nenhum dado para exportar.", "Excel")
                ENDIF
            ELSE
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnExcelClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Eventos CRUD nomeados (interface generica FormBase)
    *
    * Este form e um RELATORIO (frmrelatorio), nao um CRUD. As acoes nativas
    * sao: Visualizar (preview) / Imprimir / Excel / Encerrar.
    *
    * Os handlers CRUD abaixo existem para satisfazer a interface comum do
    * FormBase e quaisquer integradores externos (menu, atalhos de teclado).
    * Eles delegam para a acao de relatorio semanticamente mais proxima:
    *   - BtnIncluirClick  -> Visualizar (gerar nova previa do relatorio)
    *   - BtnAlterarClick  -> Visualizar (mesma previa, parametros editaveis)
    *   - BtnExcluirClick  -> Visualizar (sem operacao destrutiva em REPORT)
    *
    * Padrao identico aos demais forms REPORT do projeto (ver Formsigrecop.prg
    * linhas 1485-1495 - delegacao para BtnVisualizarClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataInicial - Handler KeyPress do campo data inicial
    * Campos de data nao precisam de lookup; aceita qualquer tecla.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDataFinal - Handler KeyPress do campo data final
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdGrEstoque - KeyPress do campo Codigo do Grupo de Estoque
    * F4(115): abre busca direta por codigo. Enter(13)/Tab(9): valida codigo.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdGrEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrEstoque - KeyPress do campo Descricao do Grupo de Estoque
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsGrEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress do campo Codigo da Conta de Estoque
    * F4(115): abre busca filtrada pelo grupo selecionado.
    * Enter(13)/Tab(9): valida codigo e preenche descricao.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEstoque - KeyPress do campo Descricao da Conta de Estoque
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEstoque()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo de grupo digitado; preenche descricao
    * Replica comportamento de get_Cd_GrEstoque.Valid (modo 'C') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_oPagina, loc_cCod, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod    = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                       " WHERE codigos = " + EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GrVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ""
                    USE IN cursor_4c_GrVal
                    THIS.AbrirBuscaCdGrEstoque()
                    RETURN
                ENDIF
                USE IN cursor_4c_GrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsGrEstoque - Valida descricao de grupo digitada; aciona lookup reverso
    * Replica comportamento de get_Ds_GrEstoque.Valid (modo 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__Cd_GrEstoque.Value = ""
            loc_oPagina.txt_4c__cd_estoque.Value   = ""
            loc_oPagina.txt_4c__ds_estoque.Value   = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsGrEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo de conta digitado; preenche descricao
    * Replica comportamento de get_cd_estoque.Valid (modo 'C') do legado.
    * A consulta e filtrada pelo grupo selecionado (grufals = grupo).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_oPagina, loc_cCod, loc_cGrupo, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod   = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
        loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__ds_estoque.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr" + ;
                       " WHERE codigos = " + EscaparSQL(loc_cCod)
            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + " AND grufals = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CntVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CntVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    loc_oPagina.txt_4c__ds_estoque.Value = ""
                    USE IN cursor_4c_CntVal
                    THIS.AbrirBuscaCdEstoque()
                    RETURN
                ENDIF
                USE IN cursor_4c_CntVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEstoque - Valida descricao de conta digitada; aciona lookup reverso
    * Replica comportamento de get_ds_estoque.Valid (modo 'D') do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEstoque()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__cd_estoque.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdGrEstoque - Abre FormBuscaAuxiliar para selecionar Grupo de
    * Estoque por codigo. Tabela: SigCdGcr (codigos / descrs).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdGrEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGr", "codigos", loc_cValor, ;
                "Grupos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaGr
                    loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
                        SELECT cursor_4c_BuscaGr
                        loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGr")
                USE IN cursor_4c_BuscaGr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsGrEstoque - Abre FormBuscaAuxiliar para selecionar Grupo de
    * Estoque por descricao (busca reversa). Tabela: SigCdGcr.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsGrEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__Ds_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGr", "descrs", loc_cValor, ;
                "Grupos")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaGr
                    loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGr")
                        SELECT cursor_4c_BuscaGr
                        loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaGr")
                USE IN cursor_4c_BuscaGr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsGrEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdEstoque - Abre FormBuscaAuxiliar para selecionar Conta de
    * Estoque por codigo, filtrada pelo grupo selecionado.
    * Tabela: SigCdGcr (codigos / descrs) WHERE grufals = grupo.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__cd_estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaCnt", "codigos", loc_cValor, ;
                "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaCnt
                    loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
                        SELECT cursor_4c_BuscaCnt
                        loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCnt")
                USE IN cursor_4c_BuscaCnt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsEstoque - Abre FormBuscaAuxiliar para selecionar Conta de
    * Estoque por descricao (busca reversa), filtrada pelo grupo selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsEstoque()
        LOCAL loc_oPagina, loc_cValor, loc_cGrupo, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__ds_estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c__Cd_GrEstoque.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaCnt", "descrs", loc_cValor, ;
                "Contas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaCnt
                    loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                    loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnt")
                        SELECT cursor_4c_BuscaCnt
                        loc_oPagina.txt_4c__cd_estoque.Value = ALLTRIM(codigos)
                        loc_oPagina.txt_4c__ds_estoque.Value = ALLTRIM(descrs)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaCnt")
                USE IN cursor_4c_BuscaCnt
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsEstoque")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para pagina (REPORT: apenas Page1 existe)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.Visible = .T.
        THIS.pgf_4c_Paginas.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress do campo Codigo da Moeda
    * F4(115): abre busca direta por codigo. Enter(13)/Tab(9): valida codigo.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress do campo Descricao da Moeda
    * F4(115): abre busca por descricao. Enter(13)/Tab(9): aciona lookup reverso.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsMoeda()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda digitado; preenche descricao
    * Replica comportamento de get_cd_moeda.Valid do legado (via fwBuscaExt).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda()
        LOCAL loc_oPagina, loc_cCod, loc_cSQL, loc_nResult, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cCod    = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
        IF EMPTY(loc_cCod)
            loc_oPagina.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL    = "SELECT cmoes, dmoes FROM SigCdMoe WHERE RTRIM(cmoes) = " + ;
                          EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
            IF loc_nResult > 0
                SELECT cursor_4c_MoeVal
                GO TOP
                IF !EOF()
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    loc_oPagina.txt_4c__ds_moeda.Value = ""
                    USE IN cursor_4c_MoeVal
                    THIS.AbrirBuscaCdMoeda()
                    RETURN
                ENDIF
                USE IN cursor_4c_MoeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ValidarCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Valida descricao de moeda digitada; aciona lookup reverso
    * Replica comportamento de get_ds_moeda.Valid do legado (via fwBuscaExt).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda()
        LOCAL loc_oPagina, loc_cDs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cDs = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
        IF EMPTY(loc_cDs)
            loc_oPagina.txt_4c__cd_moeda.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCdMoeda - Abre FormBuscaAuxiliar para selecionar Moeda por codigo
    * Tabela: SigCdMoe (cmoes / dmoes).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__cd_moeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
                "Moedas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                        loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCdMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDsMoeda - Abre FormBuscaAuxiliar para selecionar Moeda por
    * descricao (busca reversa). Tabela: SigCdMoe.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDsMoeda()
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_oErro
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c__ds_moeda.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "dmoes", loc_cValor, ;
                "Moedas")
            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    SELECT cursor_4c_BuscaMoe
                    loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        SELECT cursor_4c_BuscaMoe
                        loc_oPagina.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                        loc_oPagina.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                    ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDsMoeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTipoClick - Click no OptionGroup Tipo
    * Replica: se tipo != Analitico, desmarca optPenPag (nao faz sentido).
    *--------------------------------------------------------------------------
    PROCEDURE OptTipoClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.obj_4c_OptTipo.Value <> 1
            loc_oPagina.chk_4c_OptPenPag.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptQuebrasClick - Click no OptionGroup Quebras
    * Replica: se quebra != Datas, desmarca optPenPag.
    *--------------------------------------------------------------------------
    PROCEDURE OptQuebrasClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.obj_4c_OptQuebras.Value <> 1
            loc_oPagina.chk_4c_OptPenPag.Value = 0
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptPenPagClick - Click no CheckBox Pendente de Pagamento
    * Replica: ao marcar PenPag, forca tipo=Analitico e quebra=Datas.
    *--------------------------------------------------------------------------
    PROCEDURE OptPenPagClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        IF loc_oPagina.chk_4c_OptPenPag.Value = 1
            loc_oPagina.obj_4c_OptTipo.Value    = 1
            loc_oPagina.obj_4c_OptQuebras.Value = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Gera preview do relatorio (interface generica FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Envia relatorio para impressora (interface generica FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa filtros e restaura valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Restaura filtros do BO para os controles do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                IF VARTYPE(.this_dDtInicial) = "D" AND !EMPTY(.this_dDtInicial)
                    loc_oPagina.txt_4c__dt_inicial.Value = .this_dDtInicial
                ENDIF
                IF VARTYPE(.this_dDtFinal) = "D" AND !EMPTY(.this_dDtFinal)
                    loc_oPagina.txt_4c__dt_final.Value = .this_dDtFinal
                ENDIF
                loc_oPagina.txt_4c__Cd_GrEstoque.Value = ALLTRIM(.this_cCdGrEstoque)
                loc_oPagina.txt_4c__Ds_GrEstoque.Value = ALLTRIM(.this_cDsGrEstoque)
                loc_oPagina.txt_4c__cd_estoque.Value   = ALLTRIM(.this_cCdEstoque)
                loc_oPagina.txt_4c__ds_estoque.Value   = ALLTRIM(.this_cDsEstoque)
                loc_oPagina.txt_4c__cd_moeda.Value     = ALLTRIM(.this_cCdMoeda)
                loc_oPagina.txt_4c__ds_moeda.Value     = ALLTRIM(.this_cDsMoeda)
                loc_oPagina.obj_4c_OptSNA.Value        = .this_nOptSNA
                loc_oPagina.obj_4c_OptTipo.Value       = .this_nOptTipo
                loc_oPagina.obj_4c_OptQuebras.Value    = .this_nOptQuebras
                loc_oPagina.chk_4c_OptPenPag.Value     = .this_nOptPenPag
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Em forms REPORT todos os filtros ficam sempre habilitados
    * par_lHabilitar ignorado (sem modos INCLUIR/ALTERAR/VISUALIZAR)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_oPagina.txt_4c__dt_inicial.Enabled   = .T.
        loc_oPagina.txt_4c__dt_final.Enabled     = .T.
        loc_oPagina.txt_4c__Cd_GrEstoque.Enabled = .T.
        loc_oPagina.txt_4c__Ds_GrEstoque.Enabled = .T.
        loc_oPagina.txt_4c__cd_estoque.Enabled   = .T.
        loc_oPagina.txt_4c__ds_estoque.Enabled   = .T.
        loc_oPagina.txt_4c__cd_moeda.Enabled     = .T.
        loc_oPagina.txt_4c__ds_moeda.Enabled     = .T.
        loc_oPagina.obj_4c_OptSNA.Enabled        = .T.
        loc_oPagina.obj_4c_OptTipo.Enabled       = .T.
        loc_oPagina.obj_4c_OptQuebras.Enabled    = .T.
        loc_oPagina.chk_4c_OptPenPag.Enabled     = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel em form REPORT (sem grid de lista)
    * Existe para compatibilidade com interface generica FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel em form REPORT (sem modos CRUD)
    * Existe para compatibilidade com interface generica FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecorBO.prg):
*==============================================================================
* SIGRECORBO.PRG
* Business Object para Relatorio de Comissao Pendente por Vendedor
*
* Herda de RelatorioBase
* Tabela principal: SigCdCmm
*==============================================================================

DEFINE CLASS sigrecorBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial   = {}
    this_dDtFinal     = {}

    *-- Filtros: moeda
    this_cCdMoeda     = ""
    this_cDsMoeda     = ""

    *-- Filtros: grupo de estoque/contabilidade
    this_cCdGrEstoque = ""
    this_cDsGrEstoque = ""

    *-- Filtros: conta de estoque/contabilidade
    this_cCdEstoque   = ""
    this_cDsEstoque   = ""

    *-- Opcoes do relatorio
    *-- this_nOptTipo: 1=Analitico  2=Sintetico  3=Resumo
    this_nOptTipo     = 1

    *-- this_nOptSNA: 1=Sim  2=Nao  3=Ambos  (default=3)
    this_nOptSNA      = 3

    *-- this_nOptQuebras: 1=Datas  2=Data+Movimentacao  3=Cliente
    this_nOptQuebras  = 1

    *-- this_nOptPenPag: 0=Nao  1=Sim (pendente de pagamento)
    this_nOptPenPag   = 0

    *-- Cursores de saida do relatorio
    this_cCursorAnalitico = "cursor_4c_Analitico"
    this_cCursorCabecalho = "cursor_4c_Cabecalho"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCmm"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cTabela) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
                     ALLTRIM(THIS.this_cCdGrEstoque) + "|" + ;
                     ALLTRIM(THIS.this_cCdEstoque) + "|" + ;
                     STR(THIS.this_nOptTipo, 1) + "|" + ;
                     STR(THIS.this_nOptSNA, 1) + "|" + ;
                     STR(THIS.this_nOptQuebras, 1) + "|" + ;
                     STR(THIS.this_nOptPenPag, 1)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros salva previamente.
    * par_cAliasCursor: alias do cursor com colunas DtInicial, DtFinal,
    *   CdMoeda, DsMoeda, CdGrEstoque, DsGrEstoque, CdEstoque, DsEstoque,
    *   OptTipo, OptSNA, OptQuebras, OptPenPag
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".CdGrEstoque") = "C"
                    THIS.this_cCdGrEstoque = EVALUATE(loc_cAlias + ".CdGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrEstoque") = "C"
                    THIS.this_cDsGrEstoque = EVALUATE(loc_cAlias + ".DsGrEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEstoque") = "C"
                    THIS.this_cCdEstoque = EVALUATE(loc_cAlias + ".CdEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEstoque") = "C"
                    THIS.this_cDsEstoque = EVALUATE(loc_cAlias + ".DsEstoque")
                ENDIF
                IF TYPE(loc_cAlias + ".OptTipo") = "N"
                    THIS.this_nOptTipo = EVALUATE(loc_cAlias + ".OptTipo")
                ENDIF
                IF TYPE(loc_cAlias + ".OptSNA") = "N"
                    THIS.this_nOptSNA = EVALUATE(loc_cAlias + ".OptSNA")
                ENDIF
                IF TYPE(loc_cAlias + ".OptQuebras") = "N"
                    THIS.this_nOptQuebras = EVALUATE(loc_cAlias + ".OptQuebras")
                ENDIF
                IF TYPE(loc_cAlias + ".OptPenPag") = "N"
                    THIS.this_nOptPenPag = EVALUATE(loc_cAlias + ".OptPenPag")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio Comissao Pendente por Vendedor
    * Replica logica do procedimento 'processamento' do legado SIGRECOR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_lErroNoScan, loc_oErro
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_cMoeda, loc_nCot1, loc_nCot
        LOCAL loc_cGrupo, loc_cConta, loc_cCdMoeda, loc_cDsMoeda
        LOCAL loc_nTip, loc_nOpt, loc_nPenPag
        LOCAL loc_cNmEmpresa, loc_cNmTitulo
        LOCAL loc_cCta, loc_cNvends
        LOCAL loc_nReg, loc_nValA, loc_nValR
        LOCAL loc_nComiAtual, loc_cHistPat, loc_cEdn

        loc_lResultado  = .F.
        loc_lErroNoScan = .F.

        TRY
            loc_cMoeda   = "AU"
            loc_nCot1    = THIS.BuscarCotacao(loc_cMoeda, DATE())
            loc_cGrupo   = PADR(THIS.this_cCdGrEstoque, 10)
            loc_cConta   = PADR(THIS.this_cCdEstoque, 10)
            loc_cCdMoeda = ALLTRIM(THIS.this_cCdMoeda)
            loc_cDsMoeda = ALLTRIM(THIS.this_cDsMoeda)
            loc_nTip     = THIS.this_nOptTipo
            loc_nOpt     = THIS.this_nOptSNA
            loc_nPenPag  = THIS.this_nOptPenPag

            *-- Busca nome da empresa
            loc_cNmEmpresa = ""
            loc_cSQL = "SELECT razas FROM SigCdEmp" + ;
                       " WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    loc_cNmEmpresa = ALLTRIM(razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            *-- Monta titulo do relatorio
            loc_cNmTitulo = "Comiss" + CHR(227) + "o em " + PROPER(loc_cDsMoeda) + ;
                            " de " + DTOC(THIS.this_dDtInicial) + ;
                            " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                            IIF(loc_nTip = 1, "Anal" + CHR(237) + "tico", ;
                                IIF(loc_nTip = 2, "Sint" + CHR(233) + "tico", "Resumido")) + ;
                            " - Op" + CHR(231) + CHR(227) + "o: " + ;
                            IIF(loc_nOpt = 1, "Sim", ;
                                IIF(loc_nOpt = 2, "N" + CHR(227) + "o", "Ambos"))

            *-- Cursor cabecalho
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80))
            INSERT INTO cursor_4c_Cabecalho (NomeEmpresa, Titulo) ;
                VALUES (loc_cNmEmpresa, loc_cNmTitulo)

            *-- Cursor analitico de saida
            IF USED("cursor_4c_Analitico")
                USE IN cursor_4c_Analitico
            ENDIF
            CREATE CURSOR cursor_4c_Analitico ;
                (Vends C(10), NVends C(50), Comis N(9,4), Valos N(12,4), ;
                 Datas D(8), EmpDopNums C(29), ContaDs C(10), RClis C(40), ;
                 Notas C(6), Dopes C(20), VlBaixas N(12,4), moedas C(3), ;
                 VlPago N(12,4), VlComi N(12,4), VlPagoR N(12,4), VlComiR N(12,4))

            *-- Indice conforme tipo e quebra de relatorio
            DO CASE
                CASE (loc_nTip = 1)
                    IF THIS.this_nOptQuebras <> 3
                        INDEX ON Vends + DTOS(Datas) + EmpDopNums + moedas TAG VendDatas
                    ELSE
                        INDEX ON Vends + RClis + moedas TAG VendDatas
                    ENDIF
                CASE (loc_nTip = 2)
                    INDEX ON Vends + moedas TAG VendDatas
                OTHERWISE
                    INDEX ON Vends + DTOS(Datas) + Dopes + moedas TAG VendDatas
            ENDCASE

            *-- Query principal em SigCdCmm com filtros de periodo/grupo/conta/moeda
            loc_cSQL = "SELECT * FROM SigCdCmm" + ;
                       " WHERE datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(loc_cGrupo))
                loc_cSQL = loc_cSQL + " AND grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(ALLTRIM(loc_cConta))
                loc_cSQL = loc_cSQL + " AND contas = " + EscaparSQL(loc_cConta)
            ENDIF
            IF !EMPTY(loc_cCdMoeda)
                loc_cSQL = loc_cSQL + " AND moedas = " + EscaparSQL(loc_cCdMoeda)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cmm")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                loc_lErroNoScan = .T.
            ENDIF

            *-- SCAN principal: processa cada registro de comissao
            IF !loc_lErroNoScan
                SELECT cursor_4c_Cmm
                SCAN WHILE !loc_lErroNoScan

                    *-- Busca cabecalho do movimento correspondente
                    loc_cSQL = "SELECT Emps, Dopes, Datas, Numes, Notas, Valos," + ;
                               " GrVends, Vends, EmpDopNums, ContaDs FROM SigMvCab" + ;
                               " WHERE EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Cmm.EmpDopNums)) + ;
                               " ORDER BY Emps, Dopes, Datas, Numes, Notas," + ;
                               " Valos, GrVends, Vends, EmpDopNums, ContaDs"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCab")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvCab"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    IF !EOF("cursor_4c_MvCab")
                        SELECT cursor_4c_Analitico
                        APPEND BLANK

                        *-- Busca descricao para ContaDs do movimento
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_MvCab.ContaDs))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli1")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (ContaDs)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cCta = ""
                        SELECT cursor_4c_Cli1
                        IF !EOF()
                            loc_cCta = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli1

                        *-- Busca nome do vendedor via Contas da comissao
                        loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli2")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdCli (Contas)"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        loc_cNvends = ""
                        SELECT cursor_4c_Cli2
                        GO TOP
                        IF !EOF()
                            loc_cNvends = ALLTRIM(RClis)
                        ENDIF
                        USE IN cursor_4c_Cli2

                        SELECT cursor_4c_Analitico
                        REPLACE Vends  WITH cursor_4c_Cmm.Contas, ;
                                NVends WITH loc_cNvends IN cursor_4c_Analitico

                        *-- Verifica se operacao e estorno de comissao
                        loc_cSQL = "SELECT calcfecs FROM SigCdOpe WHERE dopes = " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Cmm.dopes))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ope")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigCdOpe"
                            loc_lErroNoScan = .T.
                            EXIT
                        ENDIF
                        SELECT cursor_4c_Ope
                        IF !EOF() AND cursor_4c_Ope.calcfecs = 1
                            SELECT cursor_4c_Cmm
                            REPLACE bases     WITH -cursor_4c_Cmm.bases     IN cursor_4c_Cmm
                            REPLACE comissaos WITH -cursor_4c_Cmm.comissaos IN cursor_4c_Cmm
                        ENDIF
                        USE IN cursor_4c_Ope

                        *-- Processamento de pendente de pagamento
                        IF loc_nPenPag = 1
                            loc_nReg = RECNO("cursor_4c_Analitico")
                            SELECT cursor_4c_Analitico
                            LOCATE FOR EmpDopNums = cursor_4c_Cmm.EmpDopNums
                            IF !FOUND()
                                GO loc_nReg
                            ELSE
                                REPLACE VlComi WITH VlComi + VlPago IN cursor_4c_Analitico
                            ENDIF

                            *-- Busca valor ja pago ao vendedor via lancamentos
                            loc_cHistPat = ALLTRIM(cursor_4c_Cmm.emps) + ;
                                           ALLTRIM(cursor_4c_Cmm.dopes) + " " + ;
                                           ALLTRIM(STR(cursor_4c_Cmm.numes))
                            loc_cSQL = "SELECT b.acertos AS vlPago, a.cotacaos," + ;
                                       " a.moedas, b.moedas AS moepit" + ;
                                       " FROM sigmvCcr a, sigcdpit b" + ;
                                       " WHERE a.nopers = b.nopers" + ;
                                       " AND a.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND a.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.grupos = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.grupos)) + ;
                                       " AND b.contas = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Cmm.Contas)) + ;
                                       " AND b.hists LIKE '" + loc_cHistPat + "%'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pag")
                            IF loc_nResult < 0
                                THIS.this_cMensagemErro = "Erro ao buscar pagamentos"
                                loc_lErroNoScan = .T.
                                EXIT
                            ENDIF

                            loc_nCot = THIS.BuscarCotacao(loc_cMoeda, DATE())

                            IF ALLTRIM(cursor_4c_Cmm.moedas) = loc_cMoeda
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + cursor_4c_Cmm.comissaos ;
                                            IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos + loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                cursor_4c_Cmm.comissaos - loc_nValA ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ELSE
                                IF RECCOUNT("cursor_4c_Pag") = 0
                                    SELECT cursor_4c_Analitico
                                    REPLACE VlComi WITH VlComi + ;
                                        ROUND(cursor_4c_Cmm.comissaos / loc_nCot, 2) ;
                                        IN cursor_4c_Analitico
                                    REPLACE VlPago WITH 0.00 IN cursor_4c_Analitico
                                ELSE
                                    loc_nValA = 0.00
                                    loc_nValR = 0.00
                                    SELECT cursor_4c_Pag
                                    SCAN
                                        loc_nValA = loc_nValA + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                cursor_4c_Pag.vlPago, ;
                                                ROUND(cursor_4c_Pag.vlPago / ;
                                                      cursor_4c_Pag.cotacaos, 2))
                                        loc_nValR = loc_nValR + ;
                                            IIF(ALLTRIM(cursor_4c_Pag.moedas) = loc_cMoeda, ;
                                                ROUND(cursor_4c_Pag.vlPago * ;
                                                      cursor_4c_Pag.cotacaos, 2), ;
                                                cursor_4c_Pag.vlPago)
                                    ENDSCAN
                                    SELECT cursor_4c_Analitico
                                    DO CASE
                                        CASE cursor_4c_Cmm.comissaos < 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos + ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                        CASE cursor_4c_Cmm.comissaos > 0
                                            REPLACE VlComi WITH VlComi + ;
                                                ROUND((cursor_4c_Cmm.comissaos - ;
                                                       loc_nValR) / loc_nCot, 2) ;
                                                IN cursor_4c_Analitico
                                            REPLACE VlPago WITH loc_nValA ;
                                                IN cursor_4c_Analitico
                                    ENDCASE
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_Pag")
                                USE IN cursor_4c_Pag
                            ENDIF
                        ENDIF

                        *-- Preenche campos conforme tipo de relatorio
                        IF (loc_nTip = 1)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas      WITH cursor_4c_MvCab.Datas, ;
                                    EmpDopNums WITH cursor_4c_MvCab.EmpDopNums, ;
                                    Notas      WITH cursor_4c_MvCab.Notas, ;
                                    ContaDs    WITH cursor_4c_MvCab.ContaDs, ;
                                    RClis      WITH loc_cCta IN cursor_4c_Analitico
                        ENDIF
                        IF (loc_nTip = 3)
                            SELECT cursor_4c_Analitico
                            REPLACE Datas WITH cursor_4c_MvCab.Datas, ;
                                    Dopes WITH cursor_4c_MvCab.Dopes IN cursor_4c_Analitico
                        ENDIF

                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_MvCab")
                            USE IN cursor_4c_MvCab
                        ENDIF
                    ENDIF

                    *-- Acumula valores base no cursor analitico (sempre executa)
                    loc_nComiAtual = cursor_4c_Cmm.comissaos
                    SELECT cursor_4c_Analitico
                    REPLACE valos    WITH valos + cursor_4c_Cmm.bases     IN cursor_4c_Analitico
                    REPLACE comis    WITH comis + loc_nComiAtual           IN cursor_4c_Analitico
                    REPLACE vlbaixas WITH vlbaixas + cursor_4c_Cmm.Baixas IN cursor_4c_Analitico
                    REPLACE moedas   WITH cursor_4c_Cmm.moedas            IN cursor_4c_Analitico
                    SELECT cursor_4c_Cmm

                ENDSCAN

                IF USED("cursor_4c_Cmm")
                    USE IN cursor_4c_Cmm
                ENDIF
            ENDIF

            *-- Pos-processamento tipo Analitico: busca numeros de NF nos subnivels
            IF !loc_lErroNoScan AND (loc_nTip = 1)
                SELECT cursor_4c_Analitico
                SET ORDER TO
                GO TOP
                SCAN WHILE !loc_lErroNoScan
                    loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps," + ;
                               " o.Dopes, RIGHT(a.Codigos, 6) AS Numes" + ;
                               " FROM SigMvPec a, SigMvCab b, SigCdOpe o" + ;
                               " WHERE a.EmpDopNums = b.EmpDopNums" + ;
                               " AND LEFT(a.Codigos, 3) = o.NDopes" + ;
                               " AND a.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ;
                               " AND a.EmpDopNums NOT IN" + ;
                               " (SELECT n.EmpDopNums FROM SigMvNfi n" + ;
                               " WHERE n.EmpDopNums = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_Analitico.EmpDopNums)) + ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sub")
                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar SigMvPec"
                        loc_lErroNoScan = .T.
                        EXIT
                    ENDIF

                    SELECT cursor_4c_Sub
                    GO TOP
                    IF !EOF()
                        loc_cEdn = ALLTRIM(cursor_4c_Sub.Emps) + ;
                                   ALLTRIM(cursor_4c_Sub.Dopes) + ;
                                   STR(INT(VAL(ALLTRIM(cursor_4c_Sub.Numes))), 6)
                        loc_cSQL = "SELECT b.NFis, b.EmpDopNums FROM SigMvNfi b" + ;
                                   " WHERE b.EmpDopNums = " + EscaparSQL(loc_cEdn)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NF")
                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Erro ao buscar SigMvNfi"
                            loc_lErroNoScan = .T.
                            USE IN cursor_4c_Sub
                            EXIT
                        ENDIF
                        SELECT cursor_4c_NF
                        GO TOP
                        IF !EOF()
                            SELECT cursor_4c_Analitico
                            REPLACE EmpDopNums WITH cursor_4c_NF.EmpDopNums, ;
                                    Notas      WITH cursor_4c_NF.NFis IN cursor_4c_Analitico
                        ENDIF
                        IF USED("cursor_4c_NF")
                            USE IN cursor_4c_NF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_Sub")
                        USE IN cursor_4c_Sub
                    ENDIF
                    SELECT cursor_4c_Analitico
                ENDSCAN
            ENDIF

            *-- Aplica filtros SNA (Sim/Nao/Ambos) e PendentePagamento
            IF !loc_lErroNoScan
                SELECT cursor_4c_Analitico
                DO CASE
                    CASE (loc_nOpt = 1)
                        DELETE FROM cursor_4c_Analitico WHERE EMPTY(Notas)
                    CASE (loc_nOpt = 2)
                        DELETE FROM cursor_4c_Analitico WHERE !EMPTY(Notas)
                ENDCASE

                IF loc_nPenPag = 1
                    DELETE FROM cursor_4c_Analitico WHERE VlComi = 0
                ENDIF

                SELECT cursor_4c_Analitico
                SET ORDER TO VendDatas
                GO TOP

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaImprimir()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) TO PRINTER NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado, loc_cFrx, loc_cSep, loc_cPto, loc_oErro
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = THIS.ObterFRXParaVisualizar()
                loc_cSep = SET("Separator")
                loc_cPto = SET("Point")
                SET POINT TO ","
                SET SEPARATOR TO "."
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                SET POINT TO (loc_cPto)
                SET SEPARATOR TO (loc_cSep)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaImprimir - Seleciona FRX conforme opcoes de impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaImprimir()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                IF THIS.this_nOptQuebras = 1
                    RETURN "SigReCr1"
                ELSE
                    RETURN "SigReCr2"
                ENDIF
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFRXParaVisualizar - Seleciona FRX conforme opcoes de preview
    * (opcao de quebra 3 = SigReCr6, exclusivo para preview)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterFRXParaVisualizar()
        IF THIS.this_nOptPenPag = 1
            RETURN "SigReCr11"
        ENDIF
        DO CASE
            CASE THIS.this_nOptTipo = 1
                DO CASE
                    CASE THIS.this_nOptQuebras = 1
                        RETURN "SigReCr1"
                    CASE THIS.this_nOptQuebras = 2
                        RETURN "SigReCr2"
                    OTHERWISE
                        RETURN "SigReCr6"
                ENDCASE
            CASE THIS.this_nOptTipo = 2
                RETURN "SigReCr3"
            OTHERWISE
                RETURN "SigReCr4"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCotacao - Busca cotacao mais recente da moeda ate a data informada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCotacao(par_cMoeda, par_dData)
        LOCAL loc_nResult, loc_nCotacao, loc_cSQL, loc_oErro
        loc_nCotacao = 1.00
        TRY
            loc_cSQL = "SELECT TOP 1 valos FROM SigCdCot" + ;
                       " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                       " AND datas <= " + FormatarDataSQL(par_dData) + ;
                       " ORDER BY datas DESC, horas DESC"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CotBusca")
            IF loc_nResult > 0
                SELECT cursor_4c_CotBusca
                GO TOP
                IF !EOF()
                    loc_nCotacao = NVL(valos, 1.00)
                ENDIF
                USE IN cursor_4c_CotBusca
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCotacao
    ENDPROC

ENDDEFINE

