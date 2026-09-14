# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[sigrecrpBO.prg] Indicador de pendencia: * Business Object para Relatorio de Debitos/Creditos Pendente
[sigrecrpBO.prg] Indicador de pendencia: *-- Opcao: 1=Debitos Pendente
[sigrecrpBO.prg] Indicador de pendencia: *-- Monta historico e calcula valor pendente
[Formsigrecrp.prg] Procedure vazia (sem codigo): AlternarPagina
[Formsigrecrp.prg] Indicador de pendencia: * Relatorio de Debitos/Creditos Pendente

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrp.prg):
*==============================================================================
* FORMSIGRECRP.PRG
* Relatorio de Debitos/Creditos Pendentes
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGRECRP.SCX (frmrelatorio)
*
* FASE 3/8 - Form - Estrutura Base
*   * Propriedades visuais do form (Width=800, Height=320)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho()  (cabecalho escuro com titulo)
*   * ConfigurarBotoes()     (cmg_4c_Botoes: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame()  (PageFrame com 1 pagina - "Filtros")
* FASE 4/8 - Form - Filtros na Page1
*   * ConfigurarPaginaLista() (controles de filtro: data inicial/final, opcao,
*       grupo/conta, empresa, moeda)
* FASE 5/8 - Form - Campos principais parte 1 (CONCLUIDO)
*   * ConfigurarPaginaDados() - BINDEVENTs para Grupo e Conta principal
*   * TeclaGrupoCod / TeclaGrupoDesc + ValidarGrupoCodigo + AbrirBuscaGrupoCont
*   * TeclaContaCod / TeclaContaDesc + ValidarContaCodigo + AbrirBuscaContaCont
* FASE 6/8 - Form - Campos restantes e lookups
*   * Linha 4: Subgrupo CP (txt_4c_Sgrupo + txt_4c_Dsgrupo)
*   * Linha 5: Subconta CP (txt_4c_Sconta + txt_4c_DsConta)
*   * Linha 6: Vencimento (txt_4c__dt_inicial + txt_4c__dt_final)
*   * Linha 7: Empresa (txt_4c__cd_empresa + txt_4c__ds_empresa)
*   * Linha 8: Moeda (txt_4c__cd_moeda + txt_4c__ds_moeda)
*   * ConfigurarPaginaDados() - BINDEVENTs para todos os campos
* FASE 7/8 - Form - Eventos principais
*   * BtnVisualizarClick() - preview em tela (REPORT FORM ... PREVIEW)
*   * BtnImprimirClick()   - impressora com dialogo (REPORT FORM ... TO PRINT)
*   * BtnExcelClick()      - exportar para Excel
*   * BtnEncerrarClick()   - fechar formulario
*   * BtnIncluirClick / BtnAlterarClick / BtnExcluirClick - stubs (REPORT sem CRUD)
* FASE 8/8 - Form - Eventos auxiliares e consolidacao final
*   * CarregarLista()      - stub compatibilidade pipeline (REPORT sem grid CRUD)
*   * HabilitarCampos()    - habilita/desabilita todos os filtros do form
*   * AjustarBotoesPorModo() - stub compatibilidade pipeline (REPORT sem modos)
*   * FormParaBO()         - wrapper de compatibilidade -> FormParaRelatorio()
*   * BOParaForm()         - carrega propriedades do BO de volta nos controles
*   * LimparCampos()       - inicializa filtros com valores padrao
*==============================================================================

DEFINE CLASS Formsigrecrp AS FormBase

    *-- Dimensoes e aparencia (Width=800 exato do original, Height=320)
    Height      = 320
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

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo)
    *   2. Cria sigrecrpBO
    *   3. Monta cabecalho escuro + botoes do relatorio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de D" + CHR(233) + ;
                           "bitos/Cr" + CHR(233) + "ditos Pendentes"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("sigrecrpBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar sigrecrpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com pagina de filtros
                THIS.ConfigurarPageFrame()

                *-- Controles de filtro na Page1
                THIS.ConfigurarPaginaLista()

                *-- BINDEVENTs: Fase 5 cobre Grupo+Conta; Fase 6 completa com demais
                THIS.ConfigurarPaginaDados()

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cTitulo
        loc_cTitulo = "Relat" + CHR(243) + "rio de D" + CHR(233) + ;
                      "bitos/Cr" + CHR(233) + "ditos Pendentes"

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

            *-- Sombra deslocada 2px para efeito 3D do texto branco
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = loc_cTitulo
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = loc_cTitulo
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
    * ConfigurarBotoes - CommandGroup com botoes de relatorio (btnReport area)
    *   Original: btnReport ButtonCount=4
    *   Botoes: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
    *   Geometria: Left=526, Width=273, Height=80 (cabe em Form Width=800)
    *   Buttons(4).Cancel=.T. fecha via ESC (substitui ControlBox)
    *   Eventos Click vinculados em ConfigurarPaginaDados (Fase 7/8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 526
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

            *-- Imprimir (impressora com dialogo)
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

            *-- Excel (exportar)
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

            *-- Encerrar (fechar form - Cancel=.T. dispara no ESC)
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   Form REPORT FLAT: controles de filtro sao adicionados em Page1
    *   nas fases seguintes (4-6). Posicionado logo abaixo do cabecalho.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        *-- Configurar Page1 (FORA de qualquer WITH - usar referencia direta)
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
    * ConfigurarPaginaLista - Adiciona todos os controles de filtro na Page1
    *   Coordenadas relativas a Page1: top_original - 85 (PageFrame.Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- === Linha 1: Label + OptionGroup (D<e9>bito / Cr<e9>dito) ===
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 7
            .Left      = 201
            .Width     = 43
            .Height    = 17
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("obj_4c_Opt_oper", "OptionGroup")
        WITH loc_oPag.obj_4c_Opt_oper
            .Top         = 2
            .Left        = 243
            .Width       = 268
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption  = "D" + CHR(233) + "bito"
                .Top      = 3
                .Left     = 0
                .Width    = 130
                .Height   = 20
                .Visible  = .T.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Cr" + CHR(233) + "dito"
                .Top      = 3
                .Left     = 133
                .Width    = 130
                .Height   = 20
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .T.
            ENDWITH
        ENDWITH

        *-- === Linha 2: Grupo cont<e1>bil principal ===
        loc_oPag.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPag.lbl_4c_Label4
            .Top       = 29
            .Left      = 203
            .Width     = 43
            .Height    = 17
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPag.txt_4c_Grupo
            .Top      = 27
            .Left     = 248
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__Ds_Grupo", "TextBox")
        WITH loc_oPag.txt_4c__Ds_Grupo
            .Top      = 27
            .Left     = 329
            .Width    = 150
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Linha 3: Conta cont<e1>bil principal ===
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 55
            .Left      = 203
            .Width     = 43
            .Height    = 17
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPag.txt_4c_Conta
            .Top      = 52
            .Left     = 248
            .Width    = 79
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DCONTA", "TextBox")
        WITH loc_oPag.txt_4c_DCONTA
            .Top      = 52
            .Left     = 329
            .Width    = 327
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Linha 4: Subgrupo contra-partida ===
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 80
            .Left      = 174
            .Width     = 70
            .Height    = 15
            .Caption   = "Grupo (C.P.) :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Sgrupo", "TextBox")
        WITH loc_oPag.txt_4c_Sgrupo
            .Top      = 77
            .Left     = 248
            .Width    = 79
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Dsgrupo", "TextBox")
        WITH loc_oPag.txt_4c_Dsgrupo
            .Top      = 77
            .Left     = 329
            .Width    = 150
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Linha 5: Subconta contra-partida ===
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 108
            .Left      = 174
            .Width     = 70
            .Height    = 17
            .Caption   = "Conta (C.P.) :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_Sconta", "TextBox")
        WITH loc_oPag.txt_4c_Sconta
            .Top      = 104
            .Left     = 248
            .Width    = 79
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c_DsConta", "TextBox")
        WITH loc_oPag.txt_4c_DsConta
            .Top      = 104
            .Left     = 329
            .Width    = 327
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Linha 6: Per<ed>odo de vencimento ===
        loc_oPag.AddObject("lbl_4c_Lbl_vencimento", "Label")
        WITH loc_oPag.lbl_4c_Lbl_vencimento
            .Top       = 134
            .Left      = 177
            .Width     = 67
            .Height    = 17
            .Caption   = "Vencimento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
        WITH loc_oPag.txt_4c__dt_inicial
            .Top       = 131
            .Left      = 248
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("lbl_4c_Lbl_vencimento_a", "Label")
        WITH loc_oPag.lbl_4c_Lbl_vencimento_a
            .Top       = 134
            .Left      = 333
            .Width     = 10
            .Height    = 17
            .Caption   = "a"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__dt_final", "TextBox")
        WITH loc_oPag.txt_4c__dt_final
            .Top       = 131
            .Left      = 345
            .Width     = 80
            .Height    = 23
            .Value     = {}
            .InputMask = "99/99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- === Linha 7: Empresa ===
        loc_oPag.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPag.lbl_4c_Lbl_empresa
            .Top       = 159
            .Left      = 191
            .Width     = 53
            .Height    = 17
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__cd_empresa", "TextBox")
        WITH loc_oPag.txt_4c__cd_empresa
            .Top      = 156
            .Left     = 248
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__ds_empresa", "TextBox")
        WITH loc_oPag.txt_4c__ds_empresa
            .Top      = 156
            .Left     = 281
            .Width    = 290
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- === Linha 8: Moeda ===
        loc_oPag.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oPag.lbl_4c_Lbl_moeda
            .Top       = 185
            .Left      = 200
            .Width     = 44
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oPag.txt_4c__cd_moeda
            .Top      = 181
            .Left     = 248
            .Width    = 31
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        loc_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPag.txt_4c__ds_moeda
            .Top      = 181
            .Left     = 281
            .Width    = 290
            .Height   = 21
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Stub compatibilidade pipeline (form REPORT: sem paginas CRUD)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - BINDEVENTs para todos os campos com lookup:
    *   Grupo/Conta (principal), Sgrupo/Sconta (contra-partida), Empresa, Moeda
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- GRUPO CONTABIL (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c_Grupo,       "KeyPress", THIS, "TeclaGrupoCod")
        BINDEVENT(loc_oPag.txt_4c_Grupo,       "DblClick", THIS, "AbrirBuscaGrupoCont")

        *-- GRUPO CONTABIL (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c__Ds_Grupo,   "KeyPress", THIS, "TeclaGrupoDesc")
        BINDEVENT(loc_oPag.txt_4c__Ds_Grupo,   "DblClick", THIS, "AbrirBuscaGrupoCont")

        *-- CONTA CONTABIL (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c_Conta,       "KeyPress", THIS, "TeclaContaCod")
        BINDEVENT(loc_oPag.txt_4c_Conta,       "DblClick", THIS, "AbrirBuscaContaCont")

        *-- CONTA CONTABIL (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c_DCONTA,      "KeyPress", THIS, "TeclaContaDesc")
        BINDEVENT(loc_oPag.txt_4c_DCONTA,      "DblClick", THIS, "AbrirBuscaContaCont")

        *-- SUBGRUPO CONTRA-PARTIDA (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c_Sgrupo,      "KeyPress", THIS, "TeclaSgrupoCod")
        BINDEVENT(loc_oPag.txt_4c_Sgrupo,      "DblClick", THIS, "AbrirBuscaSgrupoCont")

        *-- SUBGRUPO CONTRA-PARTIDA (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c_Dsgrupo,     "KeyPress", THIS, "TeclaSgrupoDesc")
        BINDEVENT(loc_oPag.txt_4c_Dsgrupo,     "DblClick", THIS, "AbrirBuscaSgrupoCont")

        *-- SUBCONTA CONTRA-PARTIDA (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c_Sconta,      "KeyPress", THIS, "TeclaScontaCod")
        BINDEVENT(loc_oPag.txt_4c_Sconta,      "DblClick", THIS, "AbrirBuscaSconta")

        *-- SUBCONTA CONTRA-PARTIDA (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c_DsConta,     "KeyPress", THIS, "TeclaScontaDesc")
        BINDEVENT(loc_oPag.txt_4c_DsConta,     "DblClick", THIS, "AbrirBuscaSconta")

        *-- EMPRESA (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c__cd_empresa, "KeyPress", THIS, "TeclaEmpresaCod")
        BINDEVENT(loc_oPag.txt_4c__cd_empresa, "DblClick", THIS, "AbrirBuscaEmpresa")

        *-- EMPRESA (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c__ds_empresa, "KeyPress", THIS, "TeclaEmpresaDesc")
        BINDEVENT(loc_oPag.txt_4c__ds_empresa, "DblClick", THIS, "AbrirBuscaEmpresa")

        *-- MOEDA (CODIGO): F4/DblClick abre busca; ENTER/TAB valida
        BINDEVENT(loc_oPag.txt_4c__cd_moeda,   "KeyPress", THIS, "TeclaMoedaCod")
        BINDEVENT(loc_oPag.txt_4c__cd_moeda,   "DblClick", THIS, "AbrirBuscaMoeda")

        *-- MOEDA (DESCRICAO): F4/ENTER/TAB abre busca reversa
        BINDEVENT(loc_oPag.txt_4c__ds_moeda,   "KeyPress", THIS, "TeclaMoedaDesc")
        BINDEVENT(loc_oPag.txt_4c__ds_moeda,   "DblClick", THIS, "AbrirBuscaMoeda")

        *-- BOTOES DO RELATORIO (cmg_4c_Botoes criado em ConfigurarBotoes)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoCod - KeyPress em txt_4c_Grupo (codigo do grupo contabil)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupoCont()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupoCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupoDesc - KeyPress em txt_4c__Ds_Grupo (descricao do grupo)
    *   F4/ENTER/TAB: abre busca pelo texto digitado na descricao
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupoDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaGrupoCont()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaContaCod - KeyPress em txt_4c_Conta (codigo da conta)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaContaCont()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaContaDesc - KeyPress em txt_4c_DCONTA (descricao da conta)
    *   F4/ENTER/TAB: abre busca pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaContaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaContaCont()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupoCodigo - Valida codigo digitado em txt_4c_Grupo
    *   Busca exata em SigCdGcr; encontrado -> preenche descricao;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupoCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c__Ds_Grupo.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
                      "WHERE Codigos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")

        IF loc_nResult > 0
            SELECT cursor_4c_GrupoVal
            IF !EOF()
                loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
                loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
                USE IN cursor_4c_GrupoVal
                RETURN
            ENDIF
            USE IN cursor_4c_GrupoVal
        ENDIF

        loc_oPag.txt_4c__Ds_Grupo.Value = ""
        THIS.AbrirBuscaGrupoCont()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupoCont - FormBuscaAuxiliar para SigCdGcr (Codigos / Descrs)
    *   Preenche txt_4c_Grupo e txt_4c__Ds_Grupo apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupoCont()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGCont", "Codigos", loc_cValor, ;
            "Busca de Grupos Cont" + CHR(225) + "beis")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaGCont")
                    SELECT cursor_4c_BuscaGCont
                    loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
                    loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGCont")
                    SELECT cursor_4c_BuscaGCont
                    loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
                    loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaGCont")
            USE IN cursor_4c_BuscaGCont
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaCodigo - Valida codigo digitado em txt_4c_Conta
    *   Busca em SigCdCli por iclis; encontrado -> preenche rclis em DCONTA;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DCONTA.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli " + ;
                      "WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")

        IF loc_nResult > 0
            SELECT cursor_4c_ContaVal
            IF !EOF()
                loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
                loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
                USE IN cursor_4c_ContaVal
                RETURN
            ENDIF
            USE IN cursor_4c_ContaVal
        ENDIF

        loc_oPag.txt_4c_DCONTA.Value = ""
        THIS.AbrirBuscaContaCont()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaContaCont - FormBuscaAuxiliar para SigCdCli (iclis / rclis)
    *   Preenche txt_4c_Conta e txt_4c_DCONTA apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaContaCont()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Conta.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaCCont", "iclis", loc_cValor, ;
            "Busca de Contas")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCCont")
                    SELECT cursor_4c_BuscaCCont
                    loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
                    loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCCont")
                    SELECT cursor_4c_BuscaCCont
                    loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
                    loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCCont")
            USE IN cursor_4c_BuscaCCont
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaSgrupoCod - KeyPress em txt_4c_Sgrupo (codigo do subgrupo CP)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSgrupoCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSgrupoCont()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSgrupoCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaSgrupoDesc - KeyPress em txt_4c_Dsgrupo (descricao do subgrupo CP)
    *   F4/ENTER/TAB: abre busca pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaSgrupoDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaSgrupoCont()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSgrupoCodigo - Valida codigo digitado em txt_4c_Sgrupo
    *   Busca exata em SigCdGcr; encontrado -> preenche descricao;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSgrupoCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Sgrupo.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_Dsgrupo.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
                      "WHERE Codigos = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SgrupoVal")

        IF loc_nResult > 0
            SELECT cursor_4c_SgrupoVal
            IF !EOF()
                loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
                loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
                USE IN cursor_4c_SgrupoVal
                RETURN
            ENDIF
            USE IN cursor_4c_SgrupoVal
        ENDIF

        loc_oPag.txt_4c_Dsgrupo.Value = ""
        THIS.AbrirBuscaSgrupoCont()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaSgrupoCont - FormBuscaAuxiliar para SigCdGcr (Codigos / Descrs)
    *   Preenche txt_4c_Sgrupo e txt_4c_Dsgrupo apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaSgrupoCont()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Sgrupo.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaSGCont", "Codigos", loc_cValor, ;
            "Busca de Subgrupos Cont" + CHR(225) + "beis (C.P.)")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaSGCont")
                    SELECT cursor_4c_BuscaSGCont
                    loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
                    loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGCont")
                    SELECT cursor_4c_BuscaSGCont
                    loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
                    loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSGCont")
            USE IN cursor_4c_BuscaSGCont
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaScontaCod - KeyPress em txt_4c_Sconta (codigo da subconta CP)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaScontaCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaSconta()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarScontaCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaScontaDesc - KeyPress em txt_4c_DsConta (descricao da subconta CP)
    *   F4/ENTER/TAB: abre busca pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaScontaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaSconta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarScontaCodigo - Valida codigo digitado em txt_4c_Sconta
    *   Busca exata em SigCdCli; encontrado -> preenche rclis em DsConta;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarScontaCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Sconta.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c_DsConta.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli " + ;
                      "WHERE iclis = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScontaVal")

        IF loc_nResult > 0
            SELECT cursor_4c_ScontaVal
            IF !EOF()
                loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
                loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
                USE IN cursor_4c_ScontaVal
                RETURN
            ENDIF
            USE IN cursor_4c_ScontaVal
        ENDIF

        loc_oPag.txt_4c_DsConta.Value = ""
        THIS.AbrirBuscaSconta()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaSconta - FormBuscaAuxiliar para SigCdCli (iclis / rclis)
    *   Preenche txt_4c_Sconta e txt_4c_DsConta apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaSconta()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Sconta.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCli", "cursor_4c_BuscaSConta", "iclis", loc_cValor, ;
            "Busca de Subcontas (C.P.)")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaSConta")
                    SELECT cursor_4c_BuscaSConta
                    loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
                    loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSConta")
                    SELECT cursor_4c_BuscaSConta
                    loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
                    loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaSConta")
            USE IN cursor_4c_BuscaSConta
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaCod - KeyPress em txt_4c__cd_empresa (codigo da empresa)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresaCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresaDesc - KeyPress em txt_4c__ds_empresa (razao social)
    *   F4/ENTER/TAB: abre busca pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresaCodigo - Valida codigo digitado em txt_4c__cd_empresa
    *   Busca exata em sigcdemp; encontrado -> preenche razas;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresaCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_empresa.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c__ds_empresa.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT cemps, razas FROM sigcdemp " + ;
                      "WHERE cemps = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaVal")

        IF loc_nResult > 0
            SELECT cursor_4c_EmpresaVal
            IF !EOF()
                loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
                loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
                USE IN cursor_4c_EmpresaVal
                RETURN
            ENDIF
            USE IN cursor_4c_EmpresaVal
        ENDIF

        loc_oPag.txt_4c__ds_empresa.Value = ""
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - FormBuscaAuxiliar para sigcdemp (cemps / razas)
    *   Preenche txt_4c__cd_empresa e txt_4c__ds_empresa apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_empresa.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "sigcdemp", "cursor_4c_BuscaEmpresa", "cemps", loc_cValor, ;
            "Busca de Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    SELECT cursor_4c_BuscaEmpresa
                    loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
                    loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("razas", "", "Empresa")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                    SELECT cursor_4c_BuscaEmpresa
                    loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
                    loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaEmpresa")
            USE IN cursor_4c_BuscaEmpresa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoedaCod - KeyPress em txt_4c__cd_moeda (codigo da moeda)
    *   F4(115): abre busca direta | ENTER(13)/TAB(9): valida codigo digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaCod(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoedaCodigo()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaMoedaDesc - KeyPress em txt_4c__ds_moeda (descricao da moeda)
    *   F4/ENTER/TAB: abre busca pelo texto digitado
    *--------------------------------------------------------------------------
    PROCEDURE TeclaMoedaDesc(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.AbrirBuscaMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoedaCodigo - Valida codigo digitado em txt_4c__cd_moeda
    *   Busca exata em SigCdMoe; encontrado -> preenche dmoes;
    *   nao encontrado -> abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMoedaCodigo()
        LOCAL loc_oPag, loc_cValor, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)

        IF EMPTY(loc_cValor)
            loc_oPag.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
                      "WHERE cmoes = " + EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaVal")

        IF loc_nResult > 0
            SELECT cursor_4c_MoedaVal
            IF !EOF()
                loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                USE IN cursor_4c_MoedaVal
                RETURN
            ENDIF
            USE IN cursor_4c_MoedaVal
        ENDIF

        loc_oPag.txt_4c__ds_moeda.Value = ""
        THIS.AbrirBuscaMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - FormBuscaAuxiliar para SigCdMoe (cmoes / dmoes)
    *   Preenche txt_4c__cd_moeda e txt_4c__ds_moeda apos selecao.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oPag, loc_cValor, loc_oBusca
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", loc_cValor, ;
            "Busca de Moeda")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Moeda")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
                    loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
                ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_nOper      = loc_oPag.obj_4c_Opt_oper.Value
            .this_cGrupo     = ALLTRIM(loc_oPag.txt_4c_Grupo.Value)
            .this_cDsGrupo   = ALLTRIM(loc_oPag.txt_4c__Ds_Grupo.Value)
            .this_cConta     = ALLTRIM(loc_oPag.txt_4c_Conta.Value)
            .this_cDConta    = ALLTRIM(loc_oPag.txt_4c_DCONTA.Value)
            .this_cSgrupo    = ALLTRIM(loc_oPag.txt_4c_Sgrupo.Value)
            .this_cDsgrupo   = ALLTRIM(loc_oPag.txt_4c_Dsgrupo.Value)
            .this_cSconta    = ALLTRIM(loc_oPag.txt_4c_Sconta.Value)
            .this_cDsConta   = ALLTRIM(loc_oPag.txt_4c_DsConta.Value)
            .this_dDtInicial = loc_oPag.txt_4c__dt_inicial.Value
            .this_dDtFinal   = loc_oPag.txt_4c__dt_final.Value
            .this_cCdEmpresa = ALLTRIM(loc_oPag.txt_4c__cd_empresa.Value)
            .this_cDsEmpresa = ALLTRIM(loc_oPag.txt_4c__ds_empresa.Value)
            .this_cCdMoeda   = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
            .this_cDsMoeda   = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Buttons(1) click: preview em tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Visualizar()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Buttons(2) click: impressora com dialogo (PROMPT)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.FormParaRelatorio()
            THIS.this_oRelatorio.Imprimir()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Buttons(3) click: exporta cursor_4c_Dados para .XLS
    *   Prepara dados via BO, depois copia cursor para arquivo Excel temporario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_oErro
        TRY
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF THIS.this_oRelatorio.PrepararDados()
                    loc_cArquivo = SYS(2023) + "\sigrecrp_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    SELECT cursor_4c_Dados
                    COPY TO (loc_cArquivo) TYPE XL5
                    MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
                        "Exportar Excel")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao Exportar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Buttons(4) click (Cancel=.T. dispara no ESC): fecha form
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT forms "Incluir" equivale a "Novo Relatorio":
    *   reseta todos os filtros para os valores default (LimparCampos replica
    *   o Init() do legado) e posiciona o foco na primeira data, permitindo
    *   gerar uma nova consulta sem fechar/reabrir o form. Mantido para
    *   uniformidade arquitetural com o pipeline CRUD (validacao exige a
    *   existencia deste handler em todo form migrado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPag
        THIS.LimparCampos()
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag) = "O" AND VARTYPE(loc_oPag.txt_4c__dt_inicial) = "O"
            loc_oPag.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT forms "Alterar" equivale a "Alterar Filtros":
    *   preserva os valores atuais (NAO chama LimparCampos), devolve o foco
    *   ao primeiro filtro de data e habilita os campos para edicao. Permite
    *   refinar a consulta antes de re-Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag) != "O"
            RETURN
        ENDIF
        THIS.HabilitarCampos(.T.)
        IF VARTYPE(loc_oPag.txt_4c__dt_inicial) = "O"
            loc_oPag.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT forms "Excluir" mapeia para "Limpar Filtros":
    *   pede confirmacao e descarta os parametros atuais, resetando todos os
    *   filtros para os defaults. Util quando o usuario quer abandonar uma
    *   combinacao de filtros e recomecar do zero sem fechar o form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oPag, loc_cMsg
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPag) != "O"
            RETURN
        ENDIF
        loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
        IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
            RETURN
        ENDIF
        THIS.LimparCampos()
        IF VARTYPE(loc_oPag.txt_4c__dt_inicial) = "O"
            loc_oPag.txt_4c__dt_inicial.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT forms "Buscar" mapeia para Visualizar
    *   (gerar o relatorio em preview, equivalente semantico de "consultar
    *   dados" em forms CRUD). Mantido para uniformidade com pipeline CRUD.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT forms "Salvar" mapeia para Imprimir
    *   (gerar saida definitiva do relatorio na impressora). Tambem registra
    *   auditoria via Inserir() do BO (RegistrarAuditoria "REPORT_RUN").
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            MsgErro("Objeto de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o inicializado.", "Imprimir")
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Inserir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
            RETURN
        ENDIF
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT forms "Cancelar" mapeia para Encerrar:
    *   abandona a operacao corrente e fecha o form, descartando filtros.
    *   Pede confirmacao se houver datas preenchidas para evitar perda
    *   acidental de parametros ja informados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPag, loc_lTemDados, loc_cMsg
        loc_oPag      = THIS.pgf_4c_Paginas.Page1
        loc_lTemDados = .F.
        IF VARTYPE(loc_oPag) = "O"
            IF VARTYPE(loc_oPag.txt_4c__cd_empresa) = "O" ;
               AND !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_empresa.Value))
                loc_lTemDados = .T.
            ENDIF
            IF VARTYPE(loc_oPag.txt_4c_Grupo) = "O" ;
               AND !EMPTY(ALLTRIM(loc_oPag.txt_4c_Grupo.Value))
                loc_lTemDados = .T.
            ENDIF
        ENDIF
        IF loc_lTemDados
            loc_cMsg = "Cancelar e fechar o relat" + CHR(243) + "rio?" + ;
                       CHR(13) + "Os filtros informados ser" + CHR(227) + ;
                       "o descartados."
            IF !MsgConfirma(loc_cMsg, "Cancelar")
                RETURN
            ENDIF
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO (objeto Custom: NUNCA usar .Release(),
    *   apenas atribuir .NULL.). Cursores sao fechados pelo Destroy do BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC


    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa todos os filtros com valores padrao
    *   Opcao = Debito (1), datas = DATE(), demais campos em branco.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH loc_oPag
            .obj_4c_Opt_oper.Value  = 1
            .txt_4c_Grupo.Value     = ""
            .txt_4c__Ds_Grupo.Value = ""
            .txt_4c_Conta.Value     = ""
            .txt_4c_DCONTA.Value    = ""
            .txt_4c_Sgrupo.Value    = ""
            .txt_4c_Dsgrupo.Value   = ""
            .txt_4c_Sconta.Value    = ""
            .txt_4c_DsConta.Value   = ""
            .txt_4c__dt_inicial.Value = DATE()
            .txt_4c__dt_final.Value   = DATE()
            .txt_4c__cd_empresa.Value = ""
            .txt_4c__ds_empresa.Value = ""
            .txt_4c__cd_moeda.Value   = ""
            .txt_4c__ds_moeda.Value   = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita todos os controles de filtro
    *   par_lHabilitar: .T. = habilita (edicao normal), .F. = somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag, loc_lEnable
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_lEnable = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        WITH loc_oPag
            .obj_4c_Opt_oper.Enabled    = loc_lEnable
            .txt_4c_Grupo.Enabled       = loc_lEnable
            .txt_4c__Ds_Grupo.Enabled   = loc_lEnable
            .txt_4c_Conta.Enabled       = loc_lEnable
            .txt_4c_DCONTA.Enabled      = loc_lEnable
            .txt_4c_Sgrupo.Enabled      = loc_lEnable
            .txt_4c_Dsgrupo.Enabled     = loc_lEnable
            .txt_4c_Sconta.Enabled      = loc_lEnable
            .txt_4c_DsConta.Enabled     = loc_lEnable
            .txt_4c__dt_inicial.Enabled = loc_lEnable
            .txt_4c__dt_final.Enabled   = loc_lEnable
            .txt_4c__cd_empresa.Enabled = loc_lEnable
            .txt_4c__ds_empresa.Enabled = loc_lEnable
            .txt_4c__cd_moeda.Enabled   = loc_lEnable
            .txt_4c__ds_moeda.Enabled   = loc_lEnable
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Stub de compatibilidade (form REPORT nao tem grid CRUD)
    *   Pipeline exige metodo CarregarLista nos forms; para REPORT retorna .T.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em forms REPORT nao ha modos CRUD; os 4 botoes
    *   do CommandGroup (Visualizar/Imprimir/DocExcel/Encerrar) permanecem
    *   sempre habilitados, sem depender de qualquer estado. Mantido para
    *   uniformidade arquitetural com o pipeline de migracao.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
        THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Wrapper de compatibilidade -> delega para FormParaRelatorio()
    *   Pipeline de CRUD chama FormParaBO; para REPORT o equivalente e
    *   FormParaRelatorio que transfere filtros ao BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta nos controles do form
    *   Inverso de FormParaRelatorio(): permite restaurar filtros apos PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPag.obj_4c_Opt_oper.Value  = .this_nOper
            loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(.this_cGrupo)
            loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(.this_cDsGrupo)
            loc_oPag.txt_4c_Conta.Value     = ALLTRIM(.this_cConta)
            loc_oPag.txt_4c_DCONTA.Value    = ALLTRIM(.this_cDConta)
            loc_oPag.txt_4c_Sgrupo.Value    = ALLTRIM(.this_cSgrupo)
            loc_oPag.txt_4c_Dsgrupo.Value   = ALLTRIM(.this_cDsgrupo)
            loc_oPag.txt_4c_Sconta.Value    = ALLTRIM(.this_cSconta)
            loc_oPag.txt_4c_DsConta.Value   = ALLTRIM(.this_cDsConta)
            loc_oPag.txt_4c__dt_inicial.Value = .this_dDtInicial
            loc_oPag.txt_4c__dt_final.Value   = .this_dDtFinal
            loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(.this_cCdEmpresa)
            loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(.this_cDsEmpresa)
            loc_oPag.txt_4c__cd_moeda.Value   = ALLTRIM(.this_cCdMoeda)
            loc_oPag.txt_4c__ds_moeda.Value   = ALLTRIM(.this_cDsMoeda)
        ENDWITH
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecrpBO.prg):
*==============================================================================
* SIGRECRPBO.PRG
* Business Object para Relatorio de Debitos/Creditos Pendentes (SIGRECRP)
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecrpBO AS RelatorioBase

    this_cArquivoFRX    = ""
    this_cTitulo        = ""
    this_cCursorDados   = "cursor_4c_Dados"
    this_lMensagemAviso = .F.

    *-- Opcao: 1=Debitos Pendentes, 2=Creditos Pendentes
    this_nOper          = 1

    *-- Grupo conta contabil principal
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta contabil principal
    this_cConta         = ""
    this_cDConta        = ""

    *-- Subgrupo contra partida
    this_cSgrupo        = ""
    this_cDsgrupo       = ""

    *-- Subconta contra partida
    this_cSconta        = ""
    this_cDsConta       = ""

    *-- Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Periodo de vencimento
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Moeda
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSigrecrp.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados e cursor_4c_Cabecalho
    * Replica logica completa do procedimento "processamento" do SIGRECRP.SCX
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_nOper, loc_cOperacao
        LOCAL loc_cGrupo, loc_cConta, loc_cSgrupo, loc_cSconta
        LOCAL loc_cCdEmpresa, loc_cMoeda
        LOCAL loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo
        LOCAL loc_nX, loc_cCampoGrupo, loc_cCampoConta
        LOCAL loc_cCodigoGrupo
        LOCAL loc_cContasCab, loc_cNomeCab, loc_dDataCab, loc_cEmpdopnums
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_cHist
        LOCAL loc_nValor, loc_nTipo, loc_cOpers
        LOCAL ldInicial, ldFinal

        THIS.this_cMensagemErro  = ""
        THIS.this_lMensagemAviso = .F.

        *-- Mapear filtros das propriedades
        loc_nOper      = THIS.this_nOper
        loc_cGrupo     = ALLTRIM(THIS.this_cGrupo)
        loc_cConta     = ALLTRIM(THIS.this_cConta)
        loc_cSgrupo    = ALLTRIM(THIS.this_cSgrupo)
        loc_cSconta    = ALLTRIM(THIS.this_cSconta)
        loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
        loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
        ldInicial      = THIS.this_dDtInicial
        ldFinal        = THIS.this_dDtFinal

        *-- Busca dados da empresa para cabecalho
        loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp" + ;
                   " WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdEmp)"
            RETURN .F.
        ENDIF
        loc_cCbEmpresa = ""
        SELECT cursor_4c_SigrecrpEmp
        IF !EOF()
            loc_cCbEmpresa = ALLTRIM(cursor_4c_SigrecrpEmp.Razas)
        ENDIF
        USE IN cursor_4c_SigrecrpEmp

        *-- Monta strings de cabecalho
        loc_cOperacao  = IIF(loc_nOper = 1, "D", "C")
        loc_cCbTitulo  = "Relat" + CHR(243) + "rio de " + ;
                         IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                         " Pendentes"
        loc_cCbPeriodo = " de " + DTOC(ldInicial) + " " + CHR(224) + " " + DTOC(ldFinal)
        loc_cCbTitulo  = loc_cCbTitulo + loc_cCbPeriodo

        *-- Cursor de cabecalho para o relatorio
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        CREATE CURSOR cursor_4c_Cabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
        INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
            VALUES (loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo)

        *-- Cursor principal de resultado
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados ( ;
            Tipo      N(1), ;
            Grupo     C(10), ;
            Conta     C(10), ;
            Nome      C(40), ;
            Empresa   C(3), ;
            Data      D, ;
            Vecto     D, ;
            Historico C(40), ;
            Integral  N(12,2), ;
            Pendente  N(12,2), ;
            Moeda     C(3))

        *-- Busca grupos contabeis conforme filtro
        loc_cSQL = "SELECT * FROM SigCdGcr" + ;
                   IIF(!EMPTY(loc_cGrupo), " WHERE Codigos = " + EscaparSQL(loc_cGrupo), "") + ;
                   " ORDER BY Codigos"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpGcr")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdGcr)"
            RETURN .F.
        ENDIF

        *-- Itera grupos contabeis
        SELECT cursor_4c_SigrecrpGcr
        SCAN
            loc_cCodigoGrupo = ALLTRIM(cursor_4c_SigrecrpGcr.Codigos)

            IF USED("cursor_4c_SigrecrpMvCcr")
                SELECT cursor_4c_SigrecrpMvCcr
                ZAP
                USE IN cursor_4c_SigrecrpMvCcr
            ENDIF

            *-- Busca movimentos conta corrente (SigMvCcr)
            loc_cSQL = "SELECT a.contas, a.grupos, a.Nopers, a.Tipos," + ;
                       " a.Emps, a.Dopes, a.Numes, a.opers, a.Datas," + ;
                       " a.Valors, a.ValPags, a.Moedas, a.Vencs, a.Hists," + ;
                       " b.iclis, b.rclis" + ;
                       " FROM SigMvCcr a, SigCdCli b" + ;
                       " WHERE b.iclis = a.contas" + ;
                       IIF(!EMPTY(loc_cConta),     " AND a.Contas = "  + EscaparSQL(loc_cConta), " ") + ;
                       IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = "    + EscaparSQL(loc_cCdEmpresa), "") + ;
                       IIF(!EMPTY(loc_cSgrupo),    " AND a.Sgrupos = " + EscaparSQL(loc_cSgrupo), " ") + ;
                       IIF(!EMPTY(loc_cSconta),    " AND a.SContas = " + EscaparSQL(loc_cSconta), " ") + ;
                       IIF(!EMPTY(loc_cMoeda),     " AND a.Moedas = "  + EscaparSQL(loc_cMoeda), " ") + ;
                       " AND a.Nopers <> 0 AND (a.Tipos = ' ' OR a.Tipos = 'X')" + ;
                       " AND a.Opers = " + EscaparSQL(loc_cOperacao) + ;
                       " AND a.grupos = " + EscaparSQL(loc_cCodigoGrupo) + ;
                       " AND a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                       " ORDER BY GruConMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                          "Falha na Conex" + CHR(227) + "o (SigMvCcr)"
                RETURN .F.
            ENDIF

            *-- Processa movimentos conta corrente
            SELECT cursor_4c_SigrecrpMvCcr
            SCAN
                IF !EMPTY(cursor_4c_SigrecrpMvCcr.Dopes) AND ;
                   !EMPTY(cursor_4c_SigrecrpMvCcr.Numes) AND ;
                   ALLTRIM(cursor_4c_SigrecrpMvCcr.Tipos) <> "X"
                    LOOP
                ENDIF
                loc_nValor = cursor_4c_SigrecrpMvCcr.Valors - cursor_4c_SigrecrpMvCcr.ValPags
                IF loc_nValor <> 0
                    INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                        Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                        VALUES (1, loc_cCodigoGrupo, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Contas), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.RClis), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Emps), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Datas, CTOD(SPACE(8))), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Vencs, CTOD(SPACE(8))), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Hists), ;
                            cursor_4c_SigrecrpMvCcr.Valors, ;
                            loc_nValor, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Moedas))
                ENDIF
            ENDSCAN

            *-- Loop x=1 (Grupods/Contads) e x=2 (Grupoos/Contaos) - SigMvCab
            FOR loc_nX = 1 TO 2
                IF loc_nX = 1
                    loc_cCampoGrupo = "Grupods"
                    loc_cCampoConta = "Contads"
                ELSE
                    loc_cCampoGrupo = "Grupoos"
                    loc_cCampoConta = "Contaos"
                ENDIF

                loc_cSQL = "SELECT a.empdopnums, a." + loc_cCampoGrupo + ;
                           ", a." + loc_cCampoConta + ", a.Datas," + ;
                           " b.Dopes, b.ValPends, b.parcs, b.Copers, c.iclis, c.rclis" + ;
                           " FROM SigMvCab a, SigCdOpe b, SigCdCli c" + ;
                           " WHERE a." + loc_cCampoGrupo + " = " + EscaparSQL(loc_cCodigoGrupo) + ;
                           IIF(!EMPTY(loc_cConta), " AND a." + loc_cCampoConta + " = " + EscaparSQL(loc_cConta), "") + ;
                           " AND (b.Dopes = a.Dopes AND b.ValPends = 1 AND b.parcs = 1)" + ;
                           IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = " + EscaparSQL(loc_cCdEmpresa), "") + ;
                           IIF(!EMPTY(loc_cSgrupo), " AND 0 = 1", "") + ;
                           IIF(!EMPTY(loc_cSconta), " AND 0 = 1", "") + ;
                           " AND c.iclis = a." + loc_cCampoConta + ;
                           " ORDER BY " + loc_cCampoGrupo + ", " + loc_cCampoConta
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                              "Falha na Conex" + CHR(227) + "o (SigMvCab)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_SigrecrpMvCab
                GO TOP
                SCAN
                    *-- Captura valores da linha atual de MvCab antes de entrar no SCAN interno
                    loc_cContasCab  = EVALUATE("cursor_4c_SigrecrpMvCab." + loc_cCampoConta)
                    loc_cNomeCab    = ALLTRIM(cursor_4c_SigrecrpMvCab.rclis)
                    loc_dDataCab    = cursor_4c_SigrecrpMvCab.Datas
                    loc_cEmpdopnums = ALLTRIM(cursor_4c_SigrecrpMvCab.empdopnums)

                    loc_cSQL = "SELECT a.empdopnums, a.VPags, a.Valos, a.FPags, a.Moefpgs," + ;
                               " a.Bancos, a.Agencias, a.Contas, a.Numeros, a.Nopers, a.Vencs" + ;
                               " FROM SigMvPar a" + ;
                               " WHERE a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                               " AND a.empdopnums = " + EscaparSQL(loc_cEmpdopnums) + ;
                               IIF(EMPTY(loc_cMoeda), "", " AND a.Moefpgs = " + EscaparSQL(loc_cMoeda))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                  "Falha na Conex" + CHR(227) + "o (SigMvPar)"
                        RETURN .F.
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvPar
                    SCAN
                        loc_cSQL = "SELECT a.FPags, a.ValPends, a.Infos, a.Grupods, a.contads" + ;
                                   " FROM SigOpFp a" + ;
                                   " WHERE a.FPags = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.FPags))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpFp")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                      "Falha na Conex" + CHR(227) + "o (SigOpFps)"
                            RETURN .F.
                        ENDIF

                        IF (cursor_4c_SigrecrpOpFp.Valpends <> 1 OR ;
                            cursor_4c_SigrecrpMvPar.Nopers = 0) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF
                        IF !EMPTY(cursor_4c_SigrecrpOpFp.Grupods) AND ;
                           !EMPTY(cursor_4c_SigrecrpOpFp.Contads) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF

                        *-- Verifica cheque se forma de pagamento = "C"
                        IF ALLTRIM(cursor_4c_SigrecrpOpFp.Infos) = "C"
                            loc_cSQL = "SELECT a.UMovs FROM SigChe a" + ;
                                       " WHERE a.Bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Bancos)) + ;
                                       " AND a.Agencias = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Agencias)) + ;
                                       " AND a.Contas = "     + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Contas)) + ;
                                       " AND a.ncheques = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Numeros))
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpChe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigChe)"
                                RETURN .F.
                            ENDIF

                            loc_cSQL = "SELECT a.operacaos FROM SigCdOpt a" + ;
                                       " WHERE a.Operacaos = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpChe.UMovs)) + ;
                                       " AND a.Tipos = 'DB'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpt")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigCdOpt)"
                                RETURN .F.
                            ENDIF

                            SELECT cursor_4c_SigrecrpOpt
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_SigrecrpMvPar
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Determina direcao da operacao (D=debito, C=credito)
                        IF cursor_4c_SigrecrpOpFp.Valpends <> 1 AND ;
                           cursor_4c_SigrecrpMvPar.VPags <> cursor_4c_SigrecrpMvPar.Valos
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "C", "D")
                        ELSE
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "D", "C")
                        ENDIF

                        *-- Filtra por tipo de operacao solicitado
                        IF (loc_nOper = 1 AND loc_cOpers = "C") OR ;
                           (loc_nOper = 2 AND loc_cOpers = "D")
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        *-- Monta historico e calcula valor pendente
                        loc_cEmps  = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 1, 3)
                        loc_cDopes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 4, 20)
                        loc_cNumes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 24, 6)
                        loc_cHist  = ALLTRIM(cursor_4c_SigrecrpMvPar.FPags) + " " + ;
                                     loc_cEmps + ALLTRIM(loc_cDopes) + " " + ALLTRIM(loc_cNumes)
                        loc_nValor = cursor_4c_SigrecrpMvPar.Valos - cursor_4c_SigrecrpMvPar.VPags

                        IF loc_nValor = 0
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                            Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                            VALUES (1, loc_cCodigoGrupo, ALLTRIM(loc_cContasCab), ;
                                ALLTRIM(loc_cNomeCab), ALLTRIM(loc_cEmps), ;
                                loc_dDataCab, cursor_4c_SigrecrpMvPar.Vencs, ;
                                ALLTRIM(loc_cHist), cursor_4c_SigrecrpMvPar.Valos, ;
                                loc_nValor, ALLTRIM(cursor_4c_SigrecrpMvPar.Moefpgs))

                        SELECT cursor_4c_SigrecrpMvPar
                    ENDSCAN

                    IF USED("cursor_4c_SigrecrpMvPar")
                        USE IN cursor_4c_SigrecrpMvPar
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvCab
                ENDSCAN

                IF USED("cursor_4c_SigrecrpMvCab")
                    USE IN cursor_4c_SigrecrpMvCab
                ENDIF
            ENDFOR

            SELECT cursor_4c_SigrecrpGcr
        ENDSCAN

        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF

        *-- Verifica se ha dados no resultado
        SELECT cursor_4c_Dados
        INDEX ON STR(Tipo, 1) + Empresa + Grupo + Conta + DTOS(Vecto) TAG GruConVec
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro  = "N" + CHR(227) + "o h" + CHR(225) + " " + ;
                IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                " pendente nesta conta!"
            THIS.this_lMensagemAviso = .T.
            RETURN .F.
        ENDIF

        *-- Totaliza por moeda e insere linhas de totalizacao
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        SELECT Moeda, SUM(Integral) AS Integral, SUM(Pendente) AS Pendente ;
            FROM cursor_4c_Dados ;
            GROUP BY Moeda ;
            ORDER BY Moeda ;
            INTO CURSOR cursor_4c_SigrecrpTotaliza

        loc_nTipo = 2
        SELECT cursor_4c_SigrecrpTotaliza
        SCAN
            SELECT cursor_4c_Dados
            INSERT INTO cursor_4c_Dados (Tipo, Moeda, Pendente, Integral) ;
                VALUES (loc_nTipo, ALLTRIM(cursor_4c_SigrecrpTotaliza.Moeda), ;
                    cursor_4c_SigrecrpTotaliza.Pendente, ;
                    cursor_4c_SigrecrpTotaliza.Integral)
            IF loc_nTipo = 2
                loc_nTipo = 3
            ENDIF
            SELECT cursor_4c_SigrecrpTotaliza
        ENDSCAN

        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em tela (preview)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio na impressora com dialogo de escolha
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRP|" + ;
                     STR(THIS.this_nOper, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cSgrupo) + "|" + ;
                     ALLTRIM(THIS.this_cSconta) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas Oper, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, Grupo, DsGrupo, Conta, DConta, Sgrupo, Dsgrupo,
    *   Sconta, DsConta, CdMoeda, DsMoeda
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
                IF TYPE(loc_cAlias + ".Oper") = "N"
                    THIS.this_nOper = EVALUATE(loc_cAlias + ".Oper")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".Grupo") = "C"
                    THIS.this_cGrupo = EVALUATE(loc_cAlias + ".Grupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrupo") = "C"
                    THIS.this_cDsGrupo = EVALUATE(loc_cAlias + ".DsGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Conta") = "C"
                    THIS.this_cConta = EVALUATE(loc_cAlias + ".Conta")
                ENDIF
                IF TYPE(loc_cAlias + ".DConta") = "C"
                    THIS.this_cDConta = EVALUATE(loc_cAlias + ".DConta")
                ENDIF
                IF TYPE(loc_cAlias + ".Sgrupo") = "C"
                    THIS.this_cSgrupo = EVALUATE(loc_cAlias + ".Sgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Dsgrupo") = "C"
                    THIS.this_cDsgrupo = EVALUATE(loc_cAlias + ".Dsgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Sconta") = "C"
                    THIS.this_cSconta = EVALUATE(loc_cAlias + ".Sconta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsConta") = "C"
                    THIS.this_cDsConta = EVALUATE(loc_cAlias + ".DsConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
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
    * Destroy - Limpeza de todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrpEmp")
            USE IN cursor_4c_SigrecrpEmp
        ENDIF
        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCab")
            USE IN cursor_4c_SigrecrpMvCab
        ENDIF
        IF USED("cursor_4c_SigrecrpMvPar")
            USE IN cursor_4c_SigrecrpMvPar
        ENDIF
        IF USED("cursor_4c_SigrecrpOpFp")
            USE IN cursor_4c_SigrecrpOpFp
        ENDIF
        IF USED("cursor_4c_SigrecrpChe")
            USE IN cursor_4c_SigrecrpChe
        ENDIF
        IF USED("cursor_4c_SigrecrpOpt")
            USE IN cursor_4c_SigrecrpOpt
        ENDIF
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

