# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\SigReDpDBO.prg: SCAN IN CrSigCdNec | Error in line 671: Command contains unrecognized phrase/keyword. | 

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReDpD.prg):
*==============================================================================
* FORMSIGREDDPD.PRG
* Form para relatorio de analise de producao por dopps (SigReDpD)
* Tipo: REPORT (herda FormBase, BO = SigReDpDBO herda RelatorioBase)
*
* Layout: FLAT (PageFrame com 1 pagina de filtros)
*   - Cabecalho escuro (cnt_4c_Cabecalho)
*   - Botoes relatorio (cmg_4c_Botoes): Visualizar/Imprimir/Excel/Encerrar
*   - PageFrame (pgf_4c_Paginas.Page1) com todos os filtros
*   - Container de operacoes (cnt_4c_Ope) com grid CsSigCdOpd e botoes
*
* Dimensoes: Width=800, Height=492 (EXATAS do original SIGREDPD.SCX)
*==============================================================================

DEFINE CLASS FormSigReDpD AS FormBase

    Height      = 492
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

    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura completa do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            THIS.Caption = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- BO faz SQLEXEC no Init - pular em modo de validacao de UI (gnConnHandle=-1)
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("SigReDpDBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar SigReDpDBO", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLabels()
                THIS.ConfigurarPaginaControles()
                THIS.ConfigurarContainerOperacoes()
                THIS.VincularEventos()
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
    * ConfigurarCabecalho - Container escuro superior com titulo
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = THIS.Caption
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
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    * Original: btnReport.Left=527, Top=3 -> canonico Left=529, Top=0
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
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

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
    * ConfigurarPageFrame - PageFrame com 1 pagina de filtros
    * Top=85 (abaixo do cabecalho), Height=492-85=407
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        loc_oPgf.PageCount  = 1
        loc_oPgf.Top        = 85
        loc_oPgf.Left       = -1
        loc_oPgf.Width      = THIS.Width + 2
        loc_oPgf.Height     = THIS.Height - 85
        loc_oPgf.Tabs       = .F.

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
    * ConfigurarPaginaLabels - Adiciona labels de filtro na Page1
    * Posicoes: original_Top - 85 (offset do PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLabels()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- "Periodo :" (Say_Conta: Top=97->12, Left=73)
        loc_oPg.AddObject("lbl_4c_Periodo", "Label")
        WITH loc_oPg.lbl_4c_Periodo
            .Top       = 12
            .Left      = 73
            .Width     = 45
            .Height    = 17
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- "ate" (Say1: Top=97->12, Left=204)
        loc_oPg.AddObject("lbl_4c_Ate", "Label")
        WITH loc_oPg.lbl_4c_Ate
            .Top       = 12
            .Left      = 204
            .Width     = 24
            .Height    = 17
            .Caption   = " at" + CHR(233) + " "
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "Tipo de OP:" (Label5: Top=123->38, Left=60)
        loc_oPg.AddObject("lbl_4c_TpGOp", "Label")
        WITH loc_oPg.lbl_4c_TpGOp
            .Top       = 38
            .Left      = 60
            .Width     = 58
            .Height    = 15
            .Caption   = "Tipo de OP:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "Movimentacao :" (lbl_dopes: Top=149->64, Left=40)
        loc_oPg.AddObject("lbl_4c_GetDopes", "Label")
        WITH loc_oPg.lbl_4c_GetDopes
            .Top       = 64
            .Left      = 40
            .Width     = 78
            .Height    = 15
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- "Grupo :" (Say2: Top=175->90, Left=80)
        loc_oPg.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPg.lbl_4c_Grupo
            .Top       = 90
            .Left      = 80
            .Width     = 38
            .Height    = 17
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- "Conta :" (Say3: Top=201->116, Left=80)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .Top       = 116
            .Left      = 80
            .Width     = 38
            .Height    = 17
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- "Grande Grupo :" (Say7: Top=227->142, Left=42)
        loc_oPg.AddObject("lbl_4c_GGrp", "Label")
        WITH loc_oPg.lbl_4c_GGrp
            .Top       = 142
            .Left      = 42
            .Width     = 76
            .Height    = 15
            .Caption   = "Grande Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "Grupo Mat. Prima :" (Say8: Top=253->168, Left=26)
        loc_oPg.AddObject("lbl_4c_GruMat", "Label")
        WITH loc_oPg.lbl_4c_GruMat
            .Top       = 168
            .Left      = 26
            .Width     = 92
            .Height    = 15
            .Caption   = "Grupo Mat. Prima :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "Tipo de Material :" (Say4: Top=279->194, Left=33)
        loc_oPg.AddObject("lbl_4c_TpOps", "Label")
        WITH loc_oPg.lbl_4c_TpOps
            .Top       = 194
            .Left      = 33
            .Width     = 85
            .Height    = 15
            .Caption   = "Tipo de Material :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- "Envelope :" (Say5: Top=279->194, Left=252)
        loc_oPg.AddObject("lbl_4c_Envelope", "Label")
        WITH loc_oPg.lbl_4c_Envelope
            .Top       = 194
            .Left      = 252
            .Width     = 53
            .Height    = 15
            .Caption   = "Envelope :"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "OP :" (Say6: Top=279->194, Left=396)
        loc_oPg.AddObject("lbl_4c_Nop", "Label")
        WITH loc_oPg.lbl_4c_Nop
            .Top       = 194
            .Left      = 396
            .Width     = 23
            .Height    = 15
            .Caption   = "OP :"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- "Cliente :" (Say10: Top=305->220, Left=76)
        loc_oPg.AddObject("lbl_4c_Cliente", "Label")
        WITH loc_oPg.lbl_4c_Cliente
            .Top       = 220
            .Left      = 76
            .Width     = 42
            .Height    = 15
            .Caption   = "Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaControles - Adiciona campos de entrada e checkboxes na Page1
    * Posicoes: original_Top - 85 (offset do PageFrame)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaControles()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Data Inicial (Get_Datai: Top=93->8, Left=123, W=80)
        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 8
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Data Final (Get_Dataf: Top=93->8, Left=231, W=80)
        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 8
            .Left          = 231
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Tipo Geracao OP (Get_TpGOp: Top=119->34, Left=123, W=80)
        loc_oPg.AddObject("txt_4c_TpGOp", "TextBox")
        WITH loc_oPg.txt_4c_TpGOp
            .Top           = 34
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .Margin        = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Tipo de Gera" + CHR(231) + CHR(227) + "o de OP (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- DopPs / Movimentacao (Get_Dopes: Top=145->60, Left=123, W=173)
        loc_oPg.AddObject("txt_4c_GetDopes", "TextBox")
        WITH loc_oPg.txt_4c_GetDopes
            .Top           = 60
            .Left          = 123
            .Width         = 173
            .Height        = 23
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "C" + CHR(243) + "d. Movimenta" + CHR(231) + CHR(227) + "o (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Numero movimentacao (getNumes: Top=145->60, Left=298, W=52)
        loc_oPg.AddObject("txt_4c_Numes", "TextBox")
        WITH loc_oPg.txt_4c_Numes
            .Top           = 60
            .Left          = 298
            .Width         = 52
            .Height        = 23
            .Value         = 0
            .Format        = "999999"
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Grupo balancete - codigo (Get_grupo: Top=171->86, Left=123, W=80)
        loc_oPg.AddObject("txt_4c_GetGrupo", "TextBox")
        WITH loc_oPg.txt_4c_GetGrupo
            .Top           = 86
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Grupo (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Grupo balancete - descricao (get_dgrupo: Top=171->86, Left=206, W=279)
        loc_oPg.AddObject("txt_4c_GetDGrupo", "TextBox")
        WITH loc_oPg.txt_4c_GetDGrupo
            .Top           = 86
            .Left          = 206
            .Width         = 279
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o do Grupo (F4 = busca por descri" + CHR(231) + CHR(227) + "o)"
            .Visible       = .T.
        ENDWITH

        *-- Conta balancete - codigo (Get_conta: Top=197->112, Left=123, W=80)
        loc_oPg.AddObject("txt_4c_GetConta", "TextBox")
        WITH loc_oPg.txt_4c_GetConta
            .Top           = 112
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Enabled       = .F.
            .ToolTipText   = "Conta (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Conta balancete - descricao (Get_dconta: Top=197->112, Left=206, W=279)
        loc_oPg.AddObject("txt_4c_GetDConta", "TextBox")
        WITH loc_oPg.txt_4c_GetDConta
            .Top           = 112
            .Left          = 206
            .Width         = 279
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Enabled       = .F.
            .ToolTipText   = "Nome da Conta (F4 = busca por nome)"
            .Visible       = .T.
        ENDWITH

        *-- Grande grupo - codigo (Get_Ggrp: Top=223->138, Left=123, W=31)
        loc_oPg.AddObject("txt_4c_GetGgrp", "TextBox")
        WITH loc_oPg.txt_4c_GetGgrp
            .Top           = 138
            .Left          = 123
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Grande Grupo (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Grande grupo - descricao (Get_dGGrp: Top=223->138, Left=157, W=328)
        loc_oPg.AddObject("txt_4c_GetDGgrp", "TextBox")
        WITH loc_oPg.txt_4c_GetDGgrp
            .Top           = 138
            .Left          = 157
            .Width         = 328
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Grupo mat. prima - codigo (Get_CGru: Top=249->164, Left=123, W=31)
        loc_oPg.AddObject("txt_4c_GetCGru", "TextBox")
        WITH loc_oPg.txt_4c_GetCGru
            .Top           = 164
            .Left          = 123
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Grupo Mat. Prima (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Grupo mat. prima - descricao (Get_DGru: Top=249->164, Left=157, W=328)
        loc_oPg.AddObject("txt_4c_GetDGru", "TextBox")
        WITH loc_oPg.txt_4c_GetDGru
            .Top           = 164
            .Left          = 157
            .Width         = 328
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o Grupo Mat. Prima (F4 = busca por descr.)"
            .Visible       = .T.
        ENDWITH

        *-- Tipo operacao (Get_TpOps: Top=275->190, Left=123, W=115)
        loc_oPg.AddObject("txt_4c_GetTpOps", "TextBox")
        WITH loc_oPg.txt_4c_GetTpOps
            .Top           = 190
            .Left          = 123
            .Width         = 115
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Tipo de Material (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Envelope (get_envelope: Top=275->190, Left=308, W=80)
        loc_oPg.AddObject("txt_4c_GetEnvelope", "TextBox")
        WITH loc_oPg.txt_4c_GetEnvelope
            .Top           = 190
            .Left          = 308
            .Width         = 80
            .Height        = 23
            .Value         = 0
            .InputMask     = "9999999999"
            .MaxLength     = 10
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Numero OP (get_Nop: Top=275->190, Left=427, W=58)
        loc_oPg.AddObject("txt_4c_GetNop", "TextBox")
        WITH loc_oPg.txt_4c_GetNop
            .Top           = 190
            .Left          = 427
            .Width         = 58
            .Height        = 23
            .Value         = 0
            .InputMask     = "999999"
            .MaxLength     = 6
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- Cliente producao - codigo (get_codcli: Top=301->216, Left=123, W=80)
        loc_oPg.AddObject("txt_4c_GetCodCli", "TextBox")
        WITH loc_oPg.txt_4c_GetCodCli
            .Top           = 216
            .Left          = 123
            .Width         = 80
            .Height        = 23
            .Value         = ""
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "C" + CHR(243) + "d. Cliente (F4 = busca)"
            .Visible       = .T.
        ENDWITH

        *-- Cliente producao - descricao (get_desccli: Top=301->216, Left=206, W=279)
        loc_oPg.AddObject("txt_4c_GetDescCli", "TextBox")
        WITH loc_oPg.txt_4c_GetDescCli
            .Top           = 216
            .Left          = 206
            .Width         = 279
            .Height        = 23
            .Value         = ""
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Themes        = .F.
            .ToolTipText   = "Nome do Cliente (F4 = busca por nome)"
            .Visible       = .T.
        ENDWITH

        *-- Checkbox: Imprimir Tipo de Material (ChkTpoOp: Top=331->246, Left=123)
        loc_oPg.AddObject("chk_4c_TpoOp", "CheckBox")
        WITH loc_oPg.chk_4c_TpoOp
            .Top       = 246
            .Left      = 123
            .Height    = 15
            .Width     = 135
            .Caption   = "Imprimir Tipo de Material"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Valor (chkvalor: Top=349->264, Left=123)
        loc_oPg.AddObject("chk_4c_Valor", "CheckBox")
        WITH loc_oPg.chk_4c_Valor
            .Top       = 264
            .Left      = 123
            .Height    = 15
            .Width     = 83
            .Caption   = "Imprimir Valor"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Quantidade e Peso (chkQtdPes: Top=349->264, Left=250)
        loc_oPg.AddObject("chk_4c_QtdPes", "CheckBox")
        WITH loc_oPg.chk_4c_QtdPes
            .Top       = 264
            .Left      = 250
            .Height    = 15
            .Width     = 150
            .Caption   = "Imprimir Quantidade e Peso"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Analisar pelo Destino (ChkDestino: Top=367->282, Left=123)
        loc_oPg.AddObject("chk_4c_Destino", "CheckBox")
        WITH loc_oPg.chk_4c_Destino
            .Top       = 282
            .Left      = 123
            .Height    = 15
            .Width     = 118
            .Caption   = "Analisar pelo Destino"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Movimentacoes (Chk_Dopes: Top=386->301, Left=123)
        loc_oPg.AddObject("chk_4c_Dopes", "CheckBox")
        WITH loc_oPg.chk_4c_Dopes
            .Top       = 301
            .Left      = 123
            .Height    = 15
            .Width     = 133
            .Caption   = "Imprimir Movimenta" + CHR(231) + CHR(245) + "es"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Movimentacoes Detalhadas (chk_detalhe: Top=405->320, Left=123)
        loc_oPg.AddObject("chk_4c_Detalhe", "CheckBox")
        WITH loc_oPg.chk_4c_Detalhe
            .Top       = 320
            .Left      = 123
            .Height    = 15
            .Width     = 190
            .Caption   = "Imprimir Movimenta" + CHR(231) + CHR(245) + "es Detalhadas"
            .Value     = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Produtos (chkProdutos: Top=426->341, Left=141)
        loc_oPg.AddObject("chk_4c_Produtos", "CheckBox")
        WITH loc_oPg.chk_4c_Produtos
            .Top       = 341
            .Left      = 141
            .Height    = 15
            .Width     = 102
            .Caption   = "Imprimir Produtos"
            .Value     = 0
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Imprimir Funcionario/Assinatura (chkFuncs: Top=444->359, Left=141)
        loc_oPg.AddObject("chk_4c_Funcs", "CheckBox")
        WITH loc_oPg.chk_4c_Funcs
            .Top       = 359
            .Left      = 141
            .Height    = 15
            .Width     = 175
            .Caption   = "Imprimir Funcion" + CHR(225) + "rio / Assinatura"
            .Value     = 0
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Checkbox: Modelo Relatorio de Producao (chkRelatorio: Top=463->378, Left=159)
        loc_oPg.AddObject("chk_4c_Relatorio", "CheckBox")
        WITH loc_oPg.chk_4c_Relatorio
            .Top       = 378
            .Left      = 159
            .Height    = 15
            .Width     = 161
            .Caption   = "Modelo Relat" + CHR(243) + "rio de Produ" + CHR(231) + CHR(227) + "o"
            .Value     = 0
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacoes - Container com grid de operacoes e botoes
    * Original: cntOpe.Top=89->4, Left=492, Width=330, Height=270
    * Grid: 2 colunas (Marca=checkbox, Dopps=readonly text)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacoes()
        LOCAL loc_oPg, loc_oCnt, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Ope", "Container")
        loc_oCnt = loc_oPg.cnt_4c_Ope

        WITH loc_oCnt
            .Top         = 4
            .Left        = 492
            .Width       = 330
            .Height      = 270
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_LabelOpe", "Label")
            WITH .lbl_4c_LabelOpe
                .Top       = 1
                .Left      = 5
                .Width     = 91
                .Height    = 16
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            .AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = .grd_4c_Dados

            WITH loc_oGrd
                .Top          = 17
                .Left         = 5
                .Width        = 257
                .Height       = 247
                .ColumnCount  = 2
                .AllowRowSizing = .F.
                .DeleteMark   = .F.
                .GridLines    = 3
                .HeaderHeight = 0
                .RowHeight    = 18
                .ScrollBars   = 2
                .RecordMark   = .F.
                .FontName     = "Tahoma"
                .GridLineColor = RGB(238, 238, 238)
                .TabStop      = .F.
                .Panel        = 1
                .Visible      = .T.

                WITH .Column1
                    .Width     = 15
                    .Alignment = 0
                    .Enabled   = .T.
                    .Sparse    = .F.
                    .AddObject("chk_4c_Marca", "CheckBox")
                    WITH .chk_4c_Marca
                        .Caption   = ""
                        .Alignment = 0
                        .Enabled   = .T.
                        .FontName  = "Tahoma"
                    ENDWITH
                    .CurrentControl = "chk_4c_Marca"
                    .ControlSource  = "CsSigCdOpd.Marca"
                    WITH .Header1
                        .Caption   = ""
                        .FontName  = "Tahoma"
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                ENDWITH

                WITH .Column2
                    .Width         = 220
                    .ControlSource = "CsSigCdOpd.Dopps"
                    .Enabled       = .T.
                    .ReadOnly      = .T.
                    .Sparse        = .F.
                    WITH .Header1
                        .Caption   = "Descrs"
                        .FontName  = "Tahoma"
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Text1
                        .Enabled     = .T.
                        .ReadOnly    = .T.
                        .ForeColor   = RGB(0, 0, 0)
                        .BackColor   = RGB(255, 255, 255)
                        .FontName    = "Tahoma"
                    ENDWITH
                ENDWITH

                .RecordSource = "CsSigCdOpd"
            ENDWITH

            .AddObject("cmd_4c_SelecionarTudo", "CommandButton")
            WITH .cmd_4c_SelecionarTudo
                .Top          = 110
                .Left         = 264
                .Width        = 40
                .Height       = 40
                .Caption      = ""
                .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
                .ToolTipText  = "Marca todos"
                .BackColor    = RGB(255, 255, 255)
                .ForeColor    = RGB(36, 84, 155)
                .FontName     = "Verdana"
                .FontSize     = 8
                .TabStop      = .F.
                .Themes       = .F.
                .Visible      = .T.
            ENDWITH

            .AddObject("cmd_4c_LimparSelecao", "CommandButton")
            WITH .cmd_4c_LimparSelecao
                .Top          = 150
                .Left         = 264
                .Width        = 40
                .Height       = 40
                .Caption      = ""
                .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .ToolTipText  = "Desmarca todos"
                .BackColor    = RGB(255, 255, 255)
                .ForeColor    = RGB(36, 84, 155)
                .FontName     = "Verdana"
                .FontSize     = 8
                .TabStop      = .F.
                .Themes       = .F.
                .Visible      = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularEventos - Associa handlers de eventos via BINDEVENT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularEventos()
        LOCAL loc_oPg, loc_oCnt
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_oCnt = loc_oPg.cnt_4c_Ope

        BINDEVENT(loc_oPg.txt_4c_DtInicial,   "KeyPress", THIS, "TeclaDtInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,     "KeyPress", THIS, "TeclaDtFinal")
        BINDEVENT(loc_oPg.txt_4c_TpGOp,       "KeyPress", THIS, "TeclaGetTpGOp")
        BINDEVENT(loc_oPg.txt_4c_GetDopes,    "KeyPress", THIS, "TeclaGetDopes")
        BINDEVENT(loc_oPg.txt_4c_Numes,       "KeyPress", THIS, "TeclaNumes")
        BINDEVENT(loc_oPg.txt_4c_GetGrupo,    "KeyPress", THIS, "TeclaGetGrupo")
        BINDEVENT(loc_oPg.txt_4c_GetDGrupo,   "KeyPress", THIS, "TeclaGetDGrupo")
        BINDEVENT(loc_oPg.txt_4c_GetConta,    "KeyPress", THIS, "TeclaGetConta")
        BINDEVENT(loc_oPg.txt_4c_GetDConta,   "KeyPress", THIS, "TeclaGetDConta")
        BINDEVENT(loc_oPg.txt_4c_GetGgrp,     "KeyPress", THIS, "TeclaGetGgrp")
        BINDEVENT(loc_oPg.txt_4c_GetDGgrp,    "KeyPress", THIS, "TeclaGetDGgrp")
        BINDEVENT(loc_oPg.txt_4c_GetCGru,     "KeyPress", THIS, "TeclaGetCGru")
        BINDEVENT(loc_oPg.txt_4c_GetDGru,     "KeyPress", THIS, "TeclaGetDGru")
        BINDEVENT(loc_oPg.txt_4c_GetTpOps,    "KeyPress", THIS, "TeclaGetTpOps")
        BINDEVENT(loc_oPg.txt_4c_GetEnvelope, "KeyPress", THIS, "TeclaGetEnvelope")
        BINDEVENT(loc_oPg.txt_4c_GetNop,      "KeyPress", THIS, "TeclaGetNop")
        BINDEVENT(loc_oPg.txt_4c_GetCodCli,   "KeyPress", THIS, "TeclaGetCodCli")
        BINDEVENT(loc_oPg.txt_4c_GetDescCli,  "KeyPress", THIS, "TeclaGetDescCli")

        *-- DblClick: abre lookup por duplo-clique (alternativa ao F4)
        BINDEVENT(loc_oPg.txt_4c_TpGOp,       "DblClick", THIS, "DblClickGetTpGOp")
        BINDEVENT(loc_oPg.txt_4c_GetDopes,    "DblClick", THIS, "DblClickGetDopes")
        BINDEVENT(loc_oPg.txt_4c_GetGrupo,    "DblClick", THIS, "DblClickGetGrupo")
        BINDEVENT(loc_oPg.txt_4c_GetDGrupo,   "DblClick", THIS, "DblClickGetDGrupo")
        BINDEVENT(loc_oPg.txt_4c_GetConta,    "DblClick", THIS, "DblClickGetConta")
        BINDEVENT(loc_oPg.txt_4c_GetDConta,   "DblClick", THIS, "DblClickGetDConta")
        BINDEVENT(loc_oPg.txt_4c_GetGgrp,     "DblClick", THIS, "DblClickGetGgrp")
        BINDEVENT(loc_oPg.txt_4c_GetCGru,     "DblClick", THIS, "DblClickGetCGru")
        BINDEVENT(loc_oPg.txt_4c_GetDGru,     "DblClick", THIS, "DblClickGetDGru")
        BINDEVENT(loc_oPg.txt_4c_GetTpOps,    "DblClick", THIS, "DblClickGetTpOps")
        BINDEVENT(loc_oPg.txt_4c_GetCodCli,   "DblClick", THIS, "DblClickGetCodCli")
        BINDEVENT(loc_oPg.txt_4c_GetDescCli,  "DblClick", THIS, "DblClickGetDescCli")

        BINDEVENT(loc_oPg.chk_4c_TpoOp,    "InteractiveChange", THIS, "ChkTpoOpInteractiveChange")
        BINDEVENT(loc_oPg.chk_4c_Detalhe,  "InteractiveChange", THIS, "ChkDetalheInteractiveChange")
        BINDEVENT(loc_oPg.chk_4c_Produtos, "InteractiveChange", THIS, "ChkProdutosInteractiveChange")
        BINDEVENT(loc_oPg.chk_4c_Valor,    "InteractiveChange", THIS, "ChkValorInteractiveChange")
        BINDEVENT(loc_oPg.chk_4c_QtdPes,   "InteractiveChange", THIS, "ChkQtdPesInteractiveChange")
        BINDEVENT(loc_oPg.chk_4c_Funcs,    "InteractiveChange", THIS, "ChkFuncsInteractiveChange")

        BINDEVENT(loc_oCnt.cmd_4c_SelecionarTudo, "Click", THIS, "BtnSelecionarTudoClick")
        BINDEVENT(loc_oCnt.cmd_4c_LimparSelecao,  "Click", THIS, "BtnLimparSelecaoClick")

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Define valores iniciais e estado habilitado dos campos
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_oErro
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oPg) != "O"
            RETURN
        ENDIF

        TRY
            loc_oPg.txt_4c_DtInicial.Value   = {}
            loc_oPg.txt_4c_DtFinal.Value     = {}
            loc_oPg.txt_4c_GetDopes.Value    = ""
            loc_oPg.txt_4c_Numes.Value       = 0
            loc_oPg.txt_4c_GetGrupo.Value    = ""
            loc_oPg.txt_4c_GetDGrupo.Value   = ""
            loc_oPg.txt_4c_GetConta.Value    = ""
            loc_oPg.txt_4c_GetDConta.Value   = ""
            loc_oPg.txt_4c_GetGgrp.Value     = ""
            loc_oPg.txt_4c_GetDGgrp.Value    = ""
            loc_oPg.txt_4c_GetCGru.Value     = ""
            loc_oPg.txt_4c_GetDGru.Value     = ""
            loc_oPg.txt_4c_GetTpOps.Value    = ""
            loc_oPg.txt_4c_GetEnvelope.Value = 0
            loc_oPg.txt_4c_GetNop.Value      = 0
            loc_oPg.txt_4c_GetCodCli.Value   = ""
            loc_oPg.txt_4c_GetDescCli.Value  = ""

            loc_oPg.chk_4c_TpoOp.Value    = 0
            loc_oPg.chk_4c_Valor.Value    = 0
            loc_oPg.chk_4c_QtdPes.Value   = 0
            loc_oPg.chk_4c_Destino.Value  = 0
            loc_oPg.chk_4c_Dopes.Value    = 0
            loc_oPg.chk_4c_Detalhe.Value  = 0
            loc_oPg.chk_4c_Produtos.Value = 0
            loc_oPg.chk_4c_Funcs.Value    = 0
            loc_oPg.chk_4c_Relatorio.Value = 0

            *-- Estado habilitado conforme regras originais (When conditions)
            loc_oPg.txt_4c_GetConta.Enabled  = .F.
            loc_oPg.txt_4c_GetDConta.Enabled = .F.
            loc_oPg.txt_4c_GetDGgrp.Enabled  = .F.
            loc_oPg.chk_4c_Produtos.Enabled  = .F.
            loc_oPg.chk_4c_Funcs.Enabled     = .F.
            loc_oPg.chk_4c_Relatorio.Enabled = .F.

            *-- Descricoes sao editaveis apenas quando codigo esta vazio
            loc_oPg.txt_4c_GetDGrupo.Enabled = .T.
            loc_oPg.txt_4c_GetDGru.Enabled   = .T.

            *-- Container de operacoes visivel quando DopPs esta vazio
            loc_oPg.cnt_4c_Ope.Visible = .T.

            *-- TpGOp: pre-preenche se apenas 1 opcao, desabilita
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                LOCAL loc_nCount
                loc_nCount = IIF(USED("CrTmpTpGop"), RECCOUNT("CrTmpTpGop"), 0)
                IF loc_nCount >= 1
                    SELECT CrTmpTpGop
                    GO TOP
                    loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(CrTmpTpGop.Codigos)
                ELSE
                    loc_oPg.txt_4c_TpGOp.Value = ""
                ENDIF
                loc_oPg.txt_4c_TpGOp.Enabled = (loc_nCount > 1)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSigReDpD.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoConta - Atualiza Enabled de campos dependentes do Grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoConta()
        LOCAL loc_oPg, loc_lTemGrupo, loc_lTemConta
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_lTemGrupo = !EMPTY(ALLTRIM(loc_oPg.txt_4c_GetGrupo.Value))
        loc_lTemConta = !EMPTY(ALLTRIM(loc_oPg.txt_4c_GetConta.Value))

        loc_oPg.txt_4c_GetConta.Enabled  = loc_lTemGrupo
        loc_oPg.txt_4c_GetDConta.Enabled = loc_lTemGrupo AND !loc_lTemConta
        loc_oPg.txt_4c_GetDGrupo.Enabled = !loc_lTemGrupo

        *-- chkFuncs depende de conta preenchida
        IF !loc_lTemConta
            loc_oPg.chk_4c_Funcs.Value    = 0
            loc_oPg.chk_4c_Funcs.Enabled  = .F.
            loc_oPg.chk_4c_Relatorio.Value   = 0
            loc_oPg.chk_4c_Relatorio.Enabled = .F.
        ELSE
            *-- chkFuncs so habilita quando detalhe E produtos estao marcados
            IF loc_oPg.chk_4c_Detalhe.Value = 1 AND loc_oPg.chk_4c_Produtos.Value = 1
                loc_oPg.chk_4c_Funcs.Enabled = .T.
            ENDIF
        ENDIF

        IF !loc_lTemGrupo
            loc_oPg.txt_4c_GetConta.Value  = ""
            loc_oPg.txt_4c_GetDConta.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_dDtInicial       = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal         = loc_oPg.txt_4c_DtFinal.Value
            .this_cDopp            = ALLTRIM(loc_oPg.txt_4c_GetDopes.Value)
            .this_nNumes           = loc_oPg.txt_4c_Numes.Value
            .this_cGrupoGcr        = ALLTRIM(loc_oPg.txt_4c_GetGrupo.Value)
            .this_cDGrupoGcr       = ALLTRIM(loc_oPg.txt_4c_GetDGrupo.Value)
            .this_cCodConta        = ALLTRIM(loc_oPg.txt_4c_GetConta.Value)
            .this_cNomeConta       = ALLTRIM(loc_oPg.txt_4c_GetDConta.Value)
            .this_cGgrp            = ALLTRIM(loc_oPg.txt_4c_GetGgrp.Value)
            .this_cDGgrp           = ALLTRIM(loc_oPg.txt_4c_GetDGgrp.Value)
            .this_cCGru            = ALLTRIM(loc_oPg.txt_4c_GetCGru.Value)
            .this_cDGru            = ALLTRIM(loc_oPg.txt_4c_GetDGru.Value)
            .this_cTpOps           = ALLTRIM(loc_oPg.txt_4c_GetTpOps.Value)
            .this_nEnvelope        = loc_oPg.txt_4c_GetEnvelope.Value
            .this_nNop             = loc_oPg.txt_4c_GetNop.Value
            .this_cCodCli          = ALLTRIM(loc_oPg.txt_4c_GetCodCli.Value)
            .this_cDescCli         = ALLTRIM(loc_oPg.txt_4c_GetDescCli.Value)
            .this_cTpGOp           = ALLTRIM(loc_oPg.txt_4c_TpGOp.Value)
            .this_lImprimeTpMat    = (loc_oPg.chk_4c_TpoOp.Value = 1)
            .this_lAnalisarDestino = (loc_oPg.chk_4c_Destino.Value = 1)
            .this_lImprimeDopes    = (loc_oPg.chk_4c_Dopes.Value = 1)
            .this_lDetalhar        = (loc_oPg.chk_4c_Detalhe.Value = 1)
            .this_lImprimeValor    = (loc_oPg.chk_4c_Valor.Value = 1)
            .this_lImprimeProdutos = (loc_oPg.chk_4c_Produtos.Value = 1)
            .this_lImprimeFuncs    = (loc_oPg.chk_4c_Funcs.Value = 1)
            .this_lRelatorio       = (loc_oPg.chk_4c_Relatorio.Value = 1)
            .this_lImprimeQtdPes   = (loc_oPg.chk_4c_QtdPes.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF EMPTY(loc_oPg.txt_4c_DtInicial.Value)
            MsgAviso("Data inicial inv" + CHR(225) + "lida!", "Aviso")
            loc_oPg.txt_4c_DtInicial.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oPg.txt_4c_DtFinal.Value)
            MsgAviso("Data final inv" + CHR(225) + "lida!", "Aviso")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF

        IF loc_oPg.txt_4c_DtFinal.Value < loc_oPg.txt_4c_DtInicial.Value
            MsgAviso("Data final deve ser maior ou igual " + ;
                CHR(224) + " data inicial!", "Aviso")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * METODOS DE BUSCA (LOOKUP)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Busca em SigCdGcr pelo codigo do grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_BuscaGrupo", ;
                "Codigos", ALLTRIM(loc_oPg.txt_4c_GetGrupo.Value), ;
                "Selecionar Grupo", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        IF !EOF()
                            loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                            loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
                        SELECT cursor_4c_BuscaGrupo
                        IF !EOF()
                            loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
                            loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaGrupo")
                    USE IN cursor_4c_BuscaGrupo
                ENDIF
                THIS.AtualizarEstadoConta()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGrupo - Busca em SigCdGcr pela descricao do grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGrupo()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGcr", "cursor_4c_BuscaDGrupo", ;
                "Descrs", ALLTRIM(loc_oPg.txt_4c_GetDGrupo.Value), ;
                "Selecionar Grupo", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDGrupo")
                        SELECT cursor_4c_BuscaDGrupo
                        IF !EOF()
                            loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.Codigos)
                            loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.Descrs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDGrupo")
                        SELECT cursor_4c_BuscaDGrupo
                        IF !EOF()
                            loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(cursor_4c_BuscaDGrupo.Codigos)
                            loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(cursor_4c_BuscaDGrupo.Descrs)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDGrupo")
                    USE IN cursor_4c_BuscaDGrupo
                ENDIF
                THIS.AtualizarEstadoConta()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Busca em SigCdCli pelo codigo da conta
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdCli", "cursor_4c_BuscaConta", ;
                "IClis", ALLTRIM(loc_oPg.txt_4c_GetConta.Value), ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        IF !EOF()
                            loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                            loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaConta")
                        SELECT cursor_4c_BuscaConta
                        IF !EOF()
                            loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
                            loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaConta")
                    USE IN cursor_4c_BuscaConta
                ENDIF
                THIS.AtualizarEstadoConta()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDConta - Busca em SigCdCli pelo nome da conta
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDConta()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdCli", "cursor_4c_BuscaDConta", ;
                "RClis", ALLTRIM(loc_oPg.txt_4c_GetDConta.Value), ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDConta")
                        SELECT cursor_4c_BuscaDConta
                        IF !EOF()
                            loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaDConta.IClis)
                            loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaDConta.RClis)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
                        SELECT cursor_4c_BuscaDConta
                        IF !EOF()
                            loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaDConta.IClis)
                            loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(cursor_4c_BuscaDConta.RClis)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDConta")
                    USE IN cursor_4c_BuscaDConta
                ENDIF
                THIS.AtualizarEstadoConta()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCGru - Busca em SigCdGrp pelo codigo do grupo de mat. prima
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCGru()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGrp", "cursor_4c_BuscaCGru", ;
                "CGrus", ALLTRIM(loc_oPg.txt_4c_GetCGru.Value), ;
                "Selecionar Grupo Mat. Prima")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCGru")
                        SELECT cursor_4c_BuscaCGru
                        IF !EOF()
                            loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaCGru.CGrus)
                            loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaCGru.DGrus)
                            loc_oPg.txt_4c_GetDGru.Enabled = .F.
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCGru")
                        SELECT cursor_4c_BuscaCGru
                        IF !EOF()
                            loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaCGru.CGrus)
                            loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaCGru.DGrus)
                            loc_oPg.txt_4c_GetDGru.Enabled = .F.
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCGru")
                    USE IN cursor_4c_BuscaCGru
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCGru")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGru - Busca em SigCdGrp pela descricao do grupo de mat. prima
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGru()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGrp", "cursor_4c_BuscaDGru", ;
                "DGrus", ALLTRIM(loc_oPg.txt_4c_GetDGru.Value), ;
                "Selecionar Grupo Mat. Prima")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDGru")
                        SELECT cursor_4c_BuscaDGru
                        IF !EOF()
                            loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaDGru.CGrus)
                            loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaDGru.DGrus)
                            loc_oPg.txt_4c_GetDGru.Enabled = .F.
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDGru")
                        SELECT cursor_4c_BuscaDGru
                        IF !EOF()
                            loc_oPg.txt_4c_GetCGru.Value = ALLTRIM(cursor_4c_BuscaDGru.CGrus)
                            loc_oPg.txt_4c_GetDGru.Value = ALLTRIM(cursor_4c_BuscaDGru.DGrus)
                            loc_oPg.txt_4c_GetDGru.Enabled = .F.
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDGru")
                    USE IN cursor_4c_BuscaDGru
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDGru")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGgrp - Busca em SigCdGpr pelo codigo do grande grupo
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGgrp()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdGpr", "cursor_4c_BuscaGgrp", ;
                "Codigos", ALLTRIM(loc_oPg.txt_4c_GetGgrp.Value), ;
                "Selecionar Grande Grupo")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaGgrp")
                        SELECT cursor_4c_BuscaGgrp
                        IF !EOF()
                            loc_oPg.txt_4c_GetGgrp.Value  = ALLTRIM(cursor_4c_BuscaGgrp.Codigos)
                            loc_oPg.txt_4c_GetDGgrp.Value = ALLTRIM(cursor_4c_BuscaGgrp.Descs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGgrp")
                        SELECT cursor_4c_BuscaGgrp
                        IF !EOF()
                            loc_oPg.txt_4c_GetGgrp.Value  = ALLTRIM(cursor_4c_BuscaGgrp.Codigos)
                            loc_oPg.txt_4c_GetDGgrp.Value = ALLTRIM(cursor_4c_BuscaGgrp.Descs)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaGgrp")
                    USE IN cursor_4c_BuscaGgrp
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaGgrp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTpOps - Busca em SigOpOpt pelo tipo de operacao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTpOps()
        LOCAL loc_oForm, loc_oPg, loc_oErro, loc_cFiltro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_cFiltro = "Situas < 2 AND (Emps = ' ' OR Emps = " + ;
            EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigOpOpt", "cursor_4c_BuscaTpOps", ;
                "Cods", ALLTRIM(loc_oPg.txt_4c_GetTpOps.Value), ;
                "Selecionar Tipo de Opera" + CHR(231) + CHR(227) + "o", ;
                .F., .F., loc_cFiltro)
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTpOps")
                        SELECT cursor_4c_BuscaTpOps
                        IF !EOF()
                            loc_oPg.txt_4c_GetTpOps.Value = ALLTRIM(cursor_4c_BuscaTpOps.Cods)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTpOps")
                        SELECT cursor_4c_BuscaTpOps
                        IF !EOF()
                            loc_oPg.txt_4c_GetTpOps.Value = ALLTRIM(cursor_4c_BuscaTpOps.Cods)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaTpOps")
                    USE IN cursor_4c_BuscaTpOps
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaTpOps")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCodCli - Busca em SigCdCli pelo codigo do cliente de producao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCodCli()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdCli", "cursor_4c_BuscaCodCli", ;
                "IClis", ALLTRIM(loc_oPg.txt_4c_GetCodCli.Value), ;
                "Selecionar Cliente", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaCodCli")
                        SELECT cursor_4c_BuscaCodCli
                        IF !EOF()
                            loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaCodCli.IClis)
                            loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaCodCli.RClis)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("RClis", "", "Nome")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCodCli")
                        SELECT cursor_4c_BuscaCodCli
                        IF !EOF()
                            loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaCodCli.IClis)
                            loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaCodCli.RClis)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCodCli")
                    USE IN cursor_4c_BuscaCodCli
                ENDIF
                *-- Quando cliente preenchido: desabilita detalhe/produtos
                THIS.AtualizarEstadoCodCli()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaCodCli")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDescCli - Busca em SigCdCli pelo nome do cliente de producao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDescCli()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdCli", "cursor_4c_BuscaDescCli", ;
                "RClis", ALLTRIM(loc_oPg.txt_4c_GetDescCli.Value), ;
                "Selecionar Cliente", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDescCli")
                        SELECT cursor_4c_BuscaDescCli
                        IF !EOF()
                            loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaDescCli.IClis)
                            loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaDescCli.RClis)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("RClis", "", "Nome")
                    loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDescCli")
                        SELECT cursor_4c_BuscaDescCli
                        IF !EOF()
                            loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(cursor_4c_BuscaDescCli.IClis)
                            loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(cursor_4c_BuscaDescCli.RClis)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDescCli")
                    USE IN cursor_4c_BuscaDescCli
                ENDIF
                THIS.AtualizarEstadoCodCli()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDescCli")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDopps - Busca em SigCdOpd pelo codigo de movimentacao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDopps()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigCdOpd", "cursor_4c_BuscaDopps", ;
                "DopPs", ALLTRIM(loc_oPg.txt_4c_GetDopes.Value), ;
                "Selecionar Movimenta" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaDopps")
                        SELECT cursor_4c_BuscaDopps
                        IF !EOF()
                            loc_oPg.txt_4c_GetDopes.Value = ALLTRIM(cursor_4c_BuscaDopps.DopPs)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("DopPs", "", "Movimenta" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDopps")
                        SELECT cursor_4c_BuscaDopps
                        IF !EOF()
                            loc_oPg.txt_4c_GetDopes.Value = ALLTRIM(cursor_4c_BuscaDopps.DopPs)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaDopps")
                    USE IN cursor_4c_BuscaDopps
                ENDIF
                *-- Atualiza visibilidade do container de operacoes
                loc_oPg.cnt_4c_Ope.Visible = EMPTY(ALLTRIM(loc_oPg.txt_4c_GetDopes.Value))
                loc_oPg.cnt_4c_Ope.Refresh()
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaDopps")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaTpGOp - Busca em SigInTgo pelo codigo de tipo de geracao OP
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaTpGOp()
        LOCAL loc_oForm, loc_oPg, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, "SigInTgo", "cursor_4c_BuscaTpGOp", ;
                "Codigos", ALLTRIM(loc_oPg.txt_4c_TpGOp.Value), ;
                "Tipos de Gera" + CHR(231) + CHR(227) + "o de O.P.")
            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTpGOp")
                        SELECT cursor_4c_BuscaTpGOp
                        IF !EOF()
                            loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_BuscaTpGOp.Codigos)
                        ENDIF
                    ENDIF
                ELSE
                    loc_oForm.mAddColuna("Codigos", "XXXXXXXXXX", "Codigo")
                    loc_oForm.mAddColuna("Descs",   " ",          "Descricao")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTpGOp")
                        SELECT cursor_4c_BuscaTpGOp
                        IF !EOF()
                            loc_oPg.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_BuscaTpGOp.Codigos)
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaTpGOp")
                    USE IN cursor_4c_BuscaTpGOp
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AbrirBuscaTpGOp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCodCli - Atualiza habilitacao conforme get_codcli
    * Quando cliente preenchido: desabilita chk_detalhe e chkProdutos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarEstadoCodCli()
        LOCAL loc_oPg
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_GetCodCli.Value))
            loc_oPg.chk_4c_Detalhe.Value    = 0
            loc_oPg.chk_4c_Detalhe.Enabled  = .F.
            loc_oPg.chk_4c_Produtos.Value   = 0
            loc_oPg.chk_4c_Produtos.Enabled = .F.
        ELSE
            loc_oPg.txt_4c_GetDescCli.Value  = ""
            loc_oPg.chk_4c_Detalhe.Enabled  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE KEYPRESS
    *==========================================================================

    PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaNumes(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaGetEnvelope(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaGetNop(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaGetTpGOp(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaTpGOp()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cVal, loc_oPg
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_TpGOp.Value)
            IF EMPTY(loc_cVal)
                RETURN
            ENDIF
            IF USED("CrTmpTpGop")
                SELECT CrTmpTpGop
                SET ORDER TO Codigos
                IF !SEEK(loc_cVal)
                    THIS.AbrirBuscaTpGOp()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDopes(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDopps()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetDopes.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.cnt_4c_Ope.Visible = .T.
                loc_oPg.cnt_4c_Ope.Refresh()
                RETURN
            ENDIF
            IF USED("CsSigCdOpd")
                SELECT CsSigCdOpd
                SET ORDER TO Dopps
                IF SEEK(UPPER(PADR(loc_cVal, 20)))
                    loc_oPg.cnt_4c_Ope.Visible = .F.
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o inv" + ;
                        CHR(225) + "lida ou sem acesso!", "Aviso")
                    loc_oPg.txt_4c_GetDopes.Value = ""
                    loc_oPg.cnt_4c_Ope.Visible = .T.
                ENDIF
                loc_oPg.cnt_4c_Ope.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetGrupo.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetDGrupo.Value = ""
                THIS.AtualizarEstadoConta()
                RETURN
            ENDIF
            IF USED("CrSigCdGcr")
                SELECT CrSigCdGcr
                SET ORDER TO BalCodigo
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(CrSigCdGcr.Codigos)
                    loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(CrSigCdGcr.Descrs)
                ELSE
                    THIS.AbrirBuscaGrupo()
                ENDIF
            ELSE
                THIS.AbrirBuscaGrupo()
            ENDIF
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGrupo()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetDGrupo.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetGrupo.Value = ""
                THIS.AtualizarEstadoConta()
                RETURN
            ENDIF
            IF USED("CrSigCdGcr")
                SELECT CrSigCdGcr
                SET ORDER TO BalDescrs
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetGrupo.Value  = ALLTRIM(CrSigCdGcr.Codigos)
                    loc_oPg.txt_4c_GetDGrupo.Value = ALLTRIM(CrSigCdGcr.Descrs)
                ELSE
                    THIS.AbrirBuscaDGrupo()
                ENDIF
            ELSE
                THIS.AbrirBuscaDGrupo()
            ENDIF
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetConta.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetDConta.Value = ""
                THIS.AtualizarEstadoConta()
                RETURN
            ENDIF
            IF USED("CrSigCdCli")
                SELECT CrSigCdCli
                SET ORDER TO BalCodigo
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(CrSigCdCli.IClis)
                    loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(CrSigCdCli.RClis)
                ELSE
                    THIS.AbrirBuscaConta()
                ENDIF
            ELSE
                THIS.AbrirBuscaConta()
            ENDIF
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDConta()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetDConta.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetConta.Value = ""
                THIS.AtualizarEstadoConta()
                RETURN
            ENDIF
            IF USED("CrSigCdCli")
                SELECT CrSigCdCli
                SET ORDER TO BalNome
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetConta.Value  = ALLTRIM(CrSigCdCli.IClis)
                    loc_oPg.txt_4c_GetDConta.Value = ALLTRIM(CrSigCdCli.RClis)
                ELSE
                    THIS.AbrirBuscaDConta()
                ENDIF
            ELSE
                THIS.AbrirBuscaDConta()
            ENDIF
            THIS.AtualizarEstadoConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetGgrp(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGgrp()
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            LOCAL loc_cVal, loc_oPg
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetGgrp.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetDGgrp.Value = ""
                RETURN
            ENDIF
            THIS.AbrirBuscaGgrp()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDGgrp(par_nKeyCode, par_nShiftAltCtrl)
    ENDPROC

    PROCEDURE TeclaGetCGru(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal, loc_cSQL, loc_nResult
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCGru()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetCGru.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetDGru.Value   = ""
                loc_oPg.txt_4c_GetDGru.Enabled = .T.
                RETURN
            ENDIF
            loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                EscaparSQL(loc_cVal)
            IF USED("cursor_4c_ValCGru")
                USE IN cursor_4c_ValCGru
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCGru")
            IF loc_nResult > 0 AND !EOF("cursor_4c_ValCGru")
                SELECT cursor_4c_ValCGru
                loc_oPg.txt_4c_GetCGru.Value   = ALLTRIM(cursor_4c_ValCGru.CGrus)
                loc_oPg.txt_4c_GetDGru.Value   = ALLTRIM(cursor_4c_ValCGru.DGrus)
                loc_oPg.txt_4c_GetDGru.Enabled = .F.
            ELSE
                THIS.AbrirBuscaCGru()
            ENDIF
            IF USED("cursor_4c_ValCGru")
                USE IN cursor_4c_ValCGru
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDGru(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGru()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetDGru.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetCGru.Value   = ""
                loc_oPg.txt_4c_GetDGru.Enabled = .T.
                RETURN
            ENDIF
            THIS.AbrirBuscaDGru()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetTpOps(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaTpOps()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetTpOps.Value)
            IF EMPTY(loc_cVal)
                RETURN
            ENDIF
            IF USED("CrSigOpOpt")
                SELECT CrSigOpOpt
                SET ORDER TO Cods
                IF !SEEK(loc_cVal)
                    THIS.AbrirBuscaTpOps()
                ENDIF
            ELSE
                THIS.AbrirBuscaTpOps()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetCodCli(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodCli()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetCodCli.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetDescCli.Value = ""
                THIS.AtualizarEstadoCodCli()
                RETURN
            ENDIF
            IF USED("CrSigCdCli")
                SELECT CrSigCdCli
                SET ORDER TO BalCodigo
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(CrSigCdCli.IClis)
                    loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(CrSigCdCli.RClis)
                ELSE
                    THIS.AbrirBuscaCodCli()
                ENDIF
            ELSE
                THIS.AbrirBuscaCodCli()
            ENDIF
            THIS.AtualizarEstadoCodCli()
        ENDIF
    ENDPROC

    PROCEDURE TeclaGetDescCli(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_cVal
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDescCli()
            RETURN
        ENDIF
        IF INLIST(par_nKeyCode, 13, 9)
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_GetDescCli.Value)
            IF EMPTY(loc_cVal)
                loc_oPg.txt_4c_GetCodCli.Value = ""
                THIS.AtualizarEstadoCodCli()
                RETURN
            ENDIF
            IF USED("CrSigCdCli")
                SELECT CrSigCdCli
                SET ORDER TO BalNome
                IF SEEK(loc_cVal)
                    loc_oPg.txt_4c_GetCodCli.Value  = ALLTRIM(CrSigCdCli.IClis)
                    loc_oPg.txt_4c_GetDescCli.Value = ALLTRIM(CrSigCdCli.RClis)
                ELSE
                    THIS.AbrirBuscaDescCli()
                ENDIF
            ELSE
                THIS.AbrirBuscaDescCli()
            ENDIF
            THIS.AtualizarEstadoCodCli()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE DBLCLICK
    *==========================================================================

    PROCEDURE DblClickGetTpGOp()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF THIS.pgf_4c_Paginas.Page1.txt_4c_TpGOp.Enabled
                THIS.AbrirBuscaTpGOp()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DblClickGetDopes()
        THIS.AbrirBuscaDopps()
    ENDPROC

    PROCEDURE DblClickGetGrupo()
        THIS.AbrirBuscaGrupo()
    ENDPROC

    PROCEDURE DblClickGetDGrupo()
        THIS.AbrirBuscaDGrupo()
    ENDPROC

    PROCEDURE DblClickGetConta()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF THIS.pgf_4c_Paginas.Page1.txt_4c_GetConta.Enabled
                THIS.AbrirBuscaConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DblClickGetDConta()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF THIS.pgf_4c_Paginas.Page1.txt_4c_GetDConta.Enabled
                THIS.AbrirBuscaDConta()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DblClickGetGgrp()
        THIS.AbrirBuscaGgrp()
    ENDPROC

    PROCEDURE DblClickGetCGru()
        THIS.AbrirBuscaCGru()
    ENDPROC

    PROCEDURE DblClickGetDGru()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            IF THIS.pgf_4c_Paginas.Page1.txt_4c_GetDGru.Enabled
                THIS.AbrirBuscaDGru()
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE DblClickGetTpOps()
        THIS.AbrirBuscaTpOps()
    ENDPROC

    PROCEDURE DblClickGetCodCli()
        THIS.AbrirBuscaCodCli()
    ENDPROC

    PROCEDURE DblClickGetDescCli()
        THIS.AbrirBuscaDescCli()
    ENDPROC

    *==========================================================================
    * HANDLERS DE CHECKBOX INTERACTIVECHANGE
    *==========================================================================

    *-- ChkTpoOp: desmarca valor e qtdpes (mutuamente exclusivos)
    PROCEDURE ChkTpoOpInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.chk_4c_Valor.Value  = 0
        loc_oPg.chk_4c_QtdPes.Value = 0
    ENDPROC

    *-- Chk_Detalhe: habilita/desabilita Produtos e Funcs
    PROCEDURE ChkDetalheInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.chk_4c_Detalhe.Value = 1
            loc_oPg.chk_4c_Produtos.Enabled = .T.
        ELSE
            loc_oPg.chk_4c_Produtos.Value   = 0
            loc_oPg.chk_4c_Produtos.Enabled = .F.
            loc_oPg.chk_4c_Funcs.Value      = 0
            loc_oPg.chk_4c_Funcs.Enabled    = .F.
            loc_oPg.chk_4c_Relatorio.Value   = 0
            loc_oPg.chk_4c_Relatorio.Enabled = .F.
        ENDIF
    ENDPROC

    *-- ChkProdutos: habilita/desabilita Funcs
    PROCEDURE ChkProdutosInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.chk_4c_Produtos.Value = 1
            loc_oPg.chk_4c_Funcs.Enabled = .T.
        ELSE
            loc_oPg.chk_4c_Funcs.Value   = 0
            loc_oPg.chk_4c_Funcs.Enabled = .F.
            loc_oPg.chk_4c_Relatorio.Value   = 0
            loc_oPg.chk_4c_Relatorio.Enabled = .F.
        ENDIF
    ENDPROC

    *-- Chkvalor: desmarca TpoOp e QtdPes
    PROCEDURE ChkValorInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.chk_4c_TpoOp.Value  = 0
        loc_oPg.chk_4c_QtdPes.Value = 0
    ENDPROC

    *-- ChkQtdPes: desmarca TpoOp e Valor
    PROCEDURE ChkQtdPesInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        loc_oPg.chk_4c_TpoOp.Value = 0
        loc_oPg.chk_4c_Valor.Value  = 0
    ENDPROC

    *-- ChkFuncs: habilita/desabilita Relatorio
    PROCEDURE ChkFuncsInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.chk_4c_Funcs.Value = 0
            loc_oPg.chk_4c_Relatorio.Value   = 0
        ENDIF
        loc_oPg.chk_4c_Relatorio.Enabled = (loc_oPg.chk_4c_Funcs.Value = 1)
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES DO CONTAINER DE OPERACOES
    *==========================================================================

    PROCEDURE BtnSelecionarTudoClick()
        IF USED("CsSigCdOpd")
            SELECT CsSigCdOpd
            REPLACE ALL Marca WITH 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Ope.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnLimparSelecaoClick()
        IF USED("CsSigCdOpd")
            SELECT CsSigCdOpd
            REPLACE ALL Marca WITH 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.cnt_4c_Ope.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES DE RELATORIO
    *==========================================================================

    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        *-- Restaura visibilidade do container apos relatorio
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2.txt_4c_GetDopes.Value = ""
            loc_oPg2.cnt_4c_Ope.Visible = .T.
            loc_oPg2.cnt_4c_Ope.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir(.T.)
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            LOCAL loc_oPg3
            loc_oPg3 = THIS.pgf_4c_Paginas.Page1
            loc_oPg3.txt_4c_GetDopes.Value = ""
            loc_oPg3.cnt_4c_Ope.Visible = .T.
            loc_oPg3.cnt_4c_Ope.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE BtnExcelClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ALIASES DE COMPATIBILIDADE CRUD
    *==========================================================================

    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            loc_oPg.txt_4c_DtInicial.Value   = .this_dDtInicial
            loc_oPg.txt_4c_DtFinal.Value     = .this_dDtFinal
            loc_oPg.txt_4c_GetDopes.Value    = ALLTRIM(.this_cDopp)
            loc_oPg.txt_4c_Numes.Value       = .this_nNumes
            loc_oPg.txt_4c_GetGrupo.Value    = ALLTRIM(.this_cGrupoGcr)
            loc_oPg.txt_4c_GetDGrupo.Value   = ALLTRIM(.this_cDGrupoGcr)
            loc_oPg.txt_4c_GetConta.Value    = ALLTRIM(.this_cCodConta)
            loc_oPg.txt_4c_GetDConta.Value   = ALLTRIM(.this_cNomeConta)
            loc_oPg.txt_4c_GetGgrp.Value     = ALLTRIM(.this_cGgrp)
            loc_oPg.txt_4c_GetDGgrp.Value    = ALLTRIM(.this_cDGgrp)
            loc_oPg.txt_4c_GetCGru.Value     = ALLTRIM(.this_cCGru)
            loc_oPg.txt_4c_GetDGru.Value     = ALLTRIM(.this_cDGru)
            loc_oPg.txt_4c_GetTpOps.Value    = ALLTRIM(.this_cTpOps)
            loc_oPg.txt_4c_GetEnvelope.Value = .this_nEnvelope
            loc_oPg.txt_4c_GetNop.Value      = .this_nNop
            loc_oPg.txt_4c_GetCodCli.Value   = ALLTRIM(.this_cCodCli)
            loc_oPg.txt_4c_GetDescCli.Value  = ALLTRIM(.this_cDescCli)
            loc_oPg.txt_4c_TpGOp.Value       = ALLTRIM(.this_cTpGOp)
            loc_oPg.chk_4c_TpoOp.Value       = IIF(.this_lImprimeTpMat, 1, 0)
            loc_oPg.chk_4c_Destino.Value     = IIF(.this_lAnalisarDestino, 1, 0)
            loc_oPg.chk_4c_Dopes.Value       = IIF(.this_lImprimeDopes, 1, 0)
            loc_oPg.chk_4c_Detalhe.Value     = IIF(.this_lDetalhar, 1, 0)
            loc_oPg.chk_4c_Valor.Value       = IIF(.this_lImprimeValor, 1, 0)
            loc_oPg.chk_4c_Produtos.Value    = IIF(.this_lImprimeProdutos, 1, 0)
            loc_oPg.chk_4c_Funcs.Value       = IIF(.this_lImprimeFuncs, 1, 0)
            loc_oPg.chk_4c_Relatorio.Value   = IIF(.this_lRelatorio, 1, 0)
            loc_oPg.chk_4c_QtdPes.Value      = IIF(.this_lImprimeQtdPes, 1, 0)
        ENDWITH
        THIS.AtualizarEstadoConta()
        THIS.AtualizarEstadoCodCli()
    ENDPROC

    PROCEDURE CarregarLista()
        IF VARTYPE(THIS.this_oRelatorio) = "O" ;
                AND !EMPTY(THIS.this_oRelatorio.this_cGrupoGcr)
            THIS.BOParaForm()
        ELSE
            THIS.LimparCampos()
        ENDIF
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.BtnSairClick()
    ENDPROC

    PROCEDURE BtnIncluirClick()
        *-- Form REPORT nao tem operacao Incluir; alias de compatibilidade CRUD
    ENDPROC

    PROCEDURE BtnAlterarClick()
        *-- Form REPORT nao tem operacao Alterar; alias de compatibilidade CRUD
    ENDPROC

    PROCEDURE BtnExcluirClick()
        *-- Form REPORT nao tem operacao Excluir; alias de compatibilidade CRUD
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Formulario REPORT: grid e selecao de operacoes
    * ja configurados em ConfigurarContainerOperacoes (chamado no InicializarForm).
    * Este metodo existe para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Form REPORT nao tem Page1/Page2 CRUD.
        *-- O grid de operacoes (cnt_4c_Ope/grd_4c_Dados) foi criado em
        *-- ConfigurarContainerOperacoes(). Os botoes de acao do relatorio
        *-- (Visualizar/Imprimir/Excel/Encerrar) foram criados em ConfigurarBotoes().
        *-- Nada adicional a fazer aqui.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Formulario REPORT: campos de filtro ja configurados
    * em ConfigurarPaginaLabels() e ConfigurarPaginaControles() (chamados no
    * InicializarForm). Este metodo existe para compatibilidade com o pipeline
    * multi-fase. Forms REPORT tem layout FLAT (Page1 unica de filtros) sem
    * separacao Lista/Dados do padrao CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form REPORT nao tem Page2 de Dados no padrao CRUD.
        *-- Todos os campos de filtro (Labels + TextBoxes + CheckBoxes) foram
        *-- adicionados em ConfigurarPaginaLabels() e ConfigurarPaginaControles()
        *-- diretamente na pgf_4c_Paginas.Page1 (pagina unica de filtros).
        *-- O container de operacoes com grid CsSigCdOpd foi criado em
        *-- ConfigurarContainerOperacoes(). Nada adicional a fazer aqui.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Formulario REPORT tem apenas 1 pagina de filtros.
    * Este metodo existe para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        *-- Form REPORT com layout FLAT: sem alternancia de paginas CRUD.
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos de filtro
    * Forms REPORT habilitam todos os filtros; campos condicionais (Conta,
    * DGgrp) seguem regras do When original (controladas por AtualizarEstado*).
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        IF VARTYPE(THIS.pgf_4c_Paginas) != "O"
            RETURN
        ENDIF
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        loc_oPg.txt_4c_DtInicial.Enabled    = loc_lHab
        loc_oPg.txt_4c_DtFinal.Enabled      = loc_lHab
        loc_oPg.txt_4c_TpGOp.Enabled        = loc_lHab AND ;
            (IIF(USED("CrTmpTpGop"), RECCOUNT("CrTmpTpGop"), 0) > 1)
        loc_oPg.txt_4c_GetDopes.Enabled     = loc_lHab
        loc_oPg.txt_4c_Numes.Enabled        = loc_lHab
        loc_oPg.txt_4c_GetGrupo.Enabled     = loc_lHab
        loc_oPg.txt_4c_GetTpOps.Enabled     = loc_lHab
        loc_oPg.txt_4c_GetEnvelope.Enabled  = loc_lHab
        loc_oPg.txt_4c_GetNop.Enabled       = loc_lHab
        loc_oPg.txt_4c_GetCodCli.Enabled    = loc_lHab
        loc_oPg.chk_4c_TpoOp.Enabled        = loc_lHab
        loc_oPg.chk_4c_Valor.Enabled        = loc_lHab
        loc_oPg.chk_4c_QtdPes.Enabled       = loc_lHab
        loc_oPg.chk_4c_Destino.Enabled      = loc_lHab
        loc_oPg.chk_4c_Dopes.Enabled        = loc_lHab
        loc_oPg.chk_4c_Detalhe.Enabled      = loc_lHab
        loc_oPg.cnt_4c_Ope.cmd_4c_SelecionarTudo.Enabled = loc_lHab
        loc_oPg.cnt_4c_Ope.cmd_4c_LimparSelecao.Enabled  = loc_lHab

        *-- Campos condicionais respeitam regras originais (When)
        IF loc_lHab
            THIS.AtualizarEstadoConta()
            THIS.AtualizarEstadoCodCli()
        ELSE
            loc_oPg.txt_4c_GetGgrp.Enabled    = .F.
            loc_oPg.txt_4c_GetCGru.Enabled    = .F.
            loc_oPg.txt_4c_GetConta.Enabled   = .F.
            loc_oPg.txt_4c_GetDescCli.Enabled = .F.
            loc_oPg.chk_4c_Produtos.Enabled   = .F.
            loc_oPg.chk_4c_Funcs.Enabled      = .F.
            loc_oPg.chk_4c_Relatorio.Enabled  = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Forms REPORT nao tem modos CRUD.
    * Metodo de compatibilidade com o pipeline multi-fase.
    * Garante botoes de relatorio sempre visiveis e habilitados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
            RETURN
        ENDIF
        WITH THIS.cmg_4c_Botoes
            .Buttons(1).Enabled = .T.
            .Buttons(2).Enabled = .T.
            .Buttons(3).Enabled = .T.
            .Buttons(4).Enabled = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Forms REPORT: buscar = visualizar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o BO e delega limpeza para FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReDpDBO.prg):
*==============================================================================
* SIGREDPDBO.PRG
* BO para relatorio de analise de producao por dopps (SigReDpD)
*
* Herda de RelatorioBase
* Carrega cursores de referencia para lookups e processamento do relatorio
*==============================================================================

DEFINE CLASS SigReDpDBO AS RelatorioBase

    *-- Filtros de periodo
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Filtro movimentacao / DopPs
    this_cDopp            = ""
    this_nNumes           = 0

    *-- Filtro grupo balancete (SigCdGcr.Codigos / Descrs)
    this_cGrupoGcr        = ""
    this_cDGrupoGcr       = ""

    *-- Filtro conta balancete (SigCdCli.IClis / RClis)
    this_cCodConta        = ""
    this_cNomeConta       = ""

    *-- Filtro cliente producao (SigCdCli.IClis / RClis) - get_codcli/get_desccli
    this_cCodCli          = ""
    this_cDescCli         = ""

    *-- Filtro grupo materia prima (SigCdGrp.CGrus / DGrus)
    this_cCGru            = ""
    this_cDGru            = ""

    *-- Filtro grande grupo (SigCdGpr.Codigos / Descs)
    this_cGgrp            = ""
    this_cDGgrp           = ""

    *-- Filtro tipo operacao (SigOpOpt.Cods)
    this_cTpOps           = ""

    *-- Filtro envelope e numero de OP
    this_nEnvelope        = 0
    this_nNop             = 0

    *-- Filtro tipo geracao OP (SigInTgo.Codigos) - auto-preenchido se apenas 1 opcao
    this_cTpGOp           = ""

    *-- Flags de impressao (correspondem aos checkboxes do form)
    this_lImprimeTpMat    = .F.
    this_lAnalisarDestino = .F.
    this_lImprimeDopes    = .F.
    this_lDetalhar        = .F.
    this_lImprimeValor    = .F.
    this_lImprimeProdutos = .F.
    this_lImprimeFuncs    = .F.
    this_lRelatorio       = .F.
    this_lImprimeQtdPes   = .F.

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de referencia para lookups e processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                *-- Grupos de balancete (lookup Get_grupo / get_dgrupo)
                IF USED("CrSigCdGcr")
                    USE IN CrSigCdGcr
                ENDIF
                loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdGcr")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar grupos de balancete"
                    EXIT
                ENDIF
                SELECT CrSigCdGcr
                INDEX ON Codigos TAG BalCodigo
                INDEX ON Descrs  TAG BalDescrs

                *-- Tipos de operacao (lookup Get_TpOps)
                IF USED("CrSigOpOpt")
                    USE IN CrSigOpOpt
                ENDIF
                loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt " + ;
                           "WHERE Situas < 2 AND (Emps = ' ' OR Emps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ")"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpOpt")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de opera" + ;
                        CHR(231) + CHR(227) + "o"
                    EXIT
                ENDIF
                SELECT CrSigOpOpt
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs

                *-- Clientes de balancete (lookup Get_conta / Get_dconta / get_codcli)
                IF USED("CrSigCdCli")
                    USE IN CrSigCdCli
                ENDIF
                loc_cSQL = "SELECT IClis, RClis, Inativas FROM SigCdCli WHERE GerBals = 1"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdCli")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar clientes"
                    EXIT
                ENDIF
                SELECT CrSigCdCli
                INDEX ON IClis TAG BalCodigo
                INDEX ON RClis TAG BalNome

                *-- Parametros SigCdPam (GrTrans filtra grupo transito no processamento)
                IF USED("CrSigCdPam")
                    USE IN CrSigCdPam
                ENDIF
                loc_cSQL = "SELECT GrTrans FROM SigCdPam"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdPam")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar par" + CHR(226) + "metros"
                    EXIT
                ENDIF
                SELECT CrSigCdPam
                GO TOP

                *-- Tipos de geracao OP com filtro de acesso do usuario (SigInTgo)
                IF USED("cursor_4c_TmpTpGop")
                    USE IN cursor_4c_TmpTpGop
                ENDIF
                loc_cSQL = "SELECT 0 AS Acesso, Codigos, Descs FROM SigInTgo"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGop")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar tipos de gera" + ;
                        CHR(231) + CHR(227) + "o OP"
                    EXIT
                ENDIF
                THIS.FiltrarAcessosTpGop()

                *-- Operacoes de producao com filtro de acesso (SigCdOpd)
                *-- INDEX criado ANTES do filtro (replicando ordem do legado)
                IF USED("CsSigCdOpd")
                    USE IN CsSigCdOpd
                ENDIF
                loc_cSQL = "SELECT 0 AS Marca, DopPs, ndopps, CodTgOps FROM SigCdOpd"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCdOpd")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF
                SELECT CsSigCdOpd
                INDEX ON Dopps TAG Dopps
                THIS.FiltrarAcessosOperacoes()
                SELECT CsSigCdOpd
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Init")
        ENDTRY

        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosTpGop - Filtra tipos de geracao OP por acesso do usuario
    * Replica: fChecaAcesso('SIGPRGLOT', Codigos) do legado
    * Se apenas 1 tipo com acesso, pre-preenche this_cTpGOp
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosTpGop()
        LOCAL loc_oErro

        TRY
            SELECT cursor_4c_TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(cursor_4c_TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN cursor_4c_TmpTpGop
                ENDIF
            ENDSCAN

            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM cursor_4c_TmpTpGop WHERE Acesso = 1 ;
                INTO CURSOR CrTmpTpGop READWRITE
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            IF RECCOUNT("CrTmpTpGop") = 1
                SELECT CrTmpTpGop
                GO TOP
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            IF USED("cursor_4c_TmpTpGop")
                USE IN cursor_4c_TmpTpGop
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosTpGop")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarAcessosOperacoes - Remove operacoes sem acesso do usuario
    * Replica: fChecaAcesso('P'+padl(ndopps,8,'0')) do legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FiltrarAcessosOperacoes()
        LOCAL loc_oErro

        TRY
            SELECT CsSigCdOpd
            SCAN
                IF !fChecaAcesso("P" + PADL(CsSigCdOpd.ndopps, 8, "0"))
                    DELETE
                ENDIF
            ENDSCAN
            SELECT CsSigCdOpd
            GO TOP

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.FiltrarAcessosOperacoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("CrSigCdGcr")
            USE IN CrSigCdGcr
        ENDIF
        IF USED("CrSigOpOpt")
            USE IN CrSigOpOpt
        ENDIF
        IF USED("CrSigCdCli")
            USE IN CrSigCdCli
        ENDIF
        IF USED("CrSigCdPam")
            USE IN CrSigCdPam
        ENDIF
        IF USED("CrTmpTpGop")
            USE IN CrTmpTpGop
        ENDIF
        IF USED("CsSigCdOpd")
            USE IN CsSigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpTpGop")
            USE IN cursor_4c_TmpTpGop
        ENDIF
        THIS.LimparCursoresTemp()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao dos filtros para auditoria
    *
    * Relatorio nao possui chave primaria de registro. Esta funcao monta
    * uma "chave" concatenando os principais filtros aplicados, usada
    * pelo log de auditoria para identificar qual configuracao foi executada.
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_dDtInicial)
            loc_cChave = "DT=" + DTOC(THIS.this_dDtInicial) + "-" + DTOC(THIS.this_dDtFinal)
        ENDIF
        IF !EMPTY(THIS.this_cGrupoGcr)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "GRP=" + ALLTRIM(THIS.this_cGrupoGcr)
        ENDIF
        IF !EMPTY(THIS.this_cCodConta)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "CTA=" + ALLTRIM(THIS.this_cCodConta)
        ENDIF
        IF !EMPTY(THIS.this_cDopp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "DOPP=" + ALLTRIM(THIS.this_cDopp)
        ENDIF
        IF !EMPTY(THIS.this_cTpGOp)
            loc_cChave = loc_cChave + IIF(EMPTY(loc_cChave), "", ";") + ;
                         "TGOP=" + ALLTRIM(THIS.this_cTpGOp)
        ENDIF
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de um cursor
    *
    * Permite recuperar configuracao de filtros previamente persistida
    * (ex: historico de execucoes). Mapeia colunas do cursor para as
    * propriedades this_* deste BO, validando tipos antes de atribuir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("DtInicial") = "D"
                    THIS.this_dDtInicial = NVL(EVALUATE("DtInicial"), {})
                ENDIF
                IF TYPE("DtFinal") = "D"
                    THIS.this_dDtFinal = NVL(EVALUATE("DtFinal"), {})
                ENDIF
                IF TYPE("Dopp") = "C"
                    THIS.this_cDopp = ALLTRIM(NVL(EVALUATE("Dopp"), ""))
                ENDIF
                IF TYPE("Numes") = "N"
                    THIS.this_nNumes = NVL(EVALUATE("Numes"), 0)
                ENDIF
                IF TYPE("GrupoGcr") = "C"
                    THIS.this_cGrupoGcr = ALLTRIM(NVL(EVALUATE("GrupoGcr"), ""))
                ENDIF
                IF TYPE("CodConta") = "C"
                    THIS.this_cCodConta = ALLTRIM(NVL(EVALUATE("CodConta"), ""))
                ENDIF
                IF TYPE("CodCli") = "C"
                    THIS.this_cCodCli = ALLTRIM(NVL(EVALUATE("CodCli"), ""))
                ENDIF
                IF TYPE("CGru") = "C"
                    THIS.this_cCGru = ALLTRIM(NVL(EVALUATE("CGru"), ""))
                ENDIF
                IF TYPE("Ggrp") = "C"
                    THIS.this_cGgrp = ALLTRIM(NVL(EVALUATE("Ggrp"), ""))
                ENDIF
                IF TYPE("TpOps") = "C"
                    THIS.this_cTpOps = ALLTRIM(NVL(EVALUATE("TpOps"), ""))
                ENDIF
                IF TYPE("Envelope") = "N"
                    THIS.this_nEnvelope = NVL(EVALUATE("Envelope"), 0)
                ENDIF
                IF TYPE("Nop") = "N"
                    THIS.this_nNop = NVL(EVALUATE("Nop"), 0)
                ENDIF
                IF TYPE("TpGOp") = "C"
                    THIS.this_cTpGOp = ALLTRIM(NVL(EVALUATE("TpGOp"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva caso seja invocado indevidamente.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir() ou Visualizar()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "SigReDpDBO.Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Grava evento de impressao/visualizacao do relatorio para rastreabilidade
    * de quem executou o relatorio de Analise de Producao por DopPs e com
    * quais filtros (datas, grupos, contas, dopp, tipo geracao OP).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL("SigReDpD") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio An" + CHR(225) + ;
                                  "lise Produ" + CHR(231) + CHR(227) + "o por DopPs") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigReDpDBO.RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNomeFRX - Retorna nome do FRX conforme opcoes selecionadas
    * Replica logica de selecao dos 8 relatorios (SigReDp1 a SigReDp8)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNomeFRX()
        LOCAL loc_cFRX
        IF THIS.this_lDetalhar
            IF THIS.this_lImprimeValor
                IF THIS.this_lRelatorio
                    loc_cFRX = "SigReDp7"
                ELSE
                    loc_cFRX = "SigReDp6"
                ENDIF
            ELSE
                IF THIS.this_lImprimeProdutos
                    loc_cFRX = "SigReDp5"
                ELSE
                    loc_cFRX = "SigReDp1"
                ENDIF
            ENDIF
        ELSE
            IF THIS.this_lImprimeDopes
                loc_cFRX = "SigReDp2"
            ELSE
                IF THIS.this_lImprimeValor
                    loc_cFRX = "SigReDp4"
                ELSE
                    IF THIS.this_lImprimeQtdPes
                        loc_cFRX = "SigReDp8"
                    ELSE
                        loc_cFRX = "SigReDp3"
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        RETURN loc_cFRX
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursoresTemp - Fecha cursores temporarios criados em PrepararDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresTemp()
        IF USED("TmpRelat")
            USE IN TmpRelat
        ENDIF
        IF USED("TmpNens")
            USE IN TmpNens
        ENDIF
        IF USED("CrSigCdNec")
            USE IN CrSigCdNec
        ENDIF
        IF USED("csLocalMc")
            USE IN csLocalMc
        ENDIF
        IF USED("crEnvelope")
            USE IN crEnvelope
        ENDIF
        IF USED("LocalCli")
            USE IN LocalCli
        ENDIF
        IF USED("LocalPro")
            USE IN LocalPro
        ENDIF
        IF USED("CrTmpCli")
            USE IN CrTmpCli
        ENDIF
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("CrSigCdEmp")
            USE IN CrSigCdEmp
        ENDIF
        IF USED("CrSigCdPro")
            USE IN CrSigCdPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa movimentacoes e monta TmpRelat para relatorio
    * Replica: PROCEDURE processamento do legado (SIGREDPD)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cGrupo, loc_cConta, loc_cGruMat, loc_cGgrp
        LOCAL loc_dDatai, loc_dDataf, loc_cDataFimSQL
        LOCAL loc_cDopp, loc_nNumes
        LOCAL loc_lImprimeTpMat, loc_lDestino
        LOCAL loc_cTpOpt, loc_lDope, loc_lDopeDt
        LOCAL loc_nEnvelope, loc_nOp, loc_nOpI, loc_nOpF
        LOCAL loc_cCodCli, loc_cTGOp
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cCab, loc_cSub, loc_cEmp
        LOCAL loc_cTpOps, loc_cGrp, loc_cCta, loc_cPed, loc_nEnv
        LOCAL loc_cPro, loc_cDpr
        LOCAL loc_lAbortarScan

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                THIS.this_cMensagemErro = ""
                THIS.LimparCursoresTemp()

                *-- Capturar valores dos filtros das propriedades
                loc_cGrupo        = ALLTRIM(THIS.this_cGrupoGcr)
                loc_cConta        = ALLTRIM(THIS.this_cCodConta)
                loc_cGruMat       = ALLTRIM(THIS.this_cCGru)
                loc_cGgrp         = ALLTRIM(THIS.this_cGgrp)
                loc_dDatai        = THIS.this_dDtInicial
                loc_dDataf        = THIS.this_dDtFinal
                loc_cDopp         = ALLTRIM(THIS.this_cDopp)
                loc_nNumes        = THIS.this_nNumes
                loc_lImprimeTpMat = THIS.this_lImprimeTpMat
                loc_lDestino      = THIS.this_lAnalisarDestino
                loc_cTpOpt        = ALLTRIM(THIS.this_cTpOps)
                loc_lDope         = THIS.this_lImprimeDopes
                loc_lDopeDt       = THIS.this_lDetalhar
                loc_nEnvelope     = THIS.this_nEnvelope
                loc_nOp           = THIS.this_nNop
                loc_nOpI          = (loc_nOp * 10000) + 1
                loc_nOpF          = (loc_nOp * 10000) + 9999
                loc_cCodCli       = ALLTRIM(THIS.this_cCodCli)
                loc_cTGOp         = ALLTRIM(THIS.this_cTpGOp)

                *-- Data final com 23:59:59 para cobrir todo o dia (replica fDtoSQL do legado)
                loc_cDataFimSQL = "'" + ;
                    PADL(YEAR(loc_dDataf),  4, "0") + "-" + ;
                    PADL(MONTH(loc_dDataf), 2, "0") + "-" + ;
                    PADL(DAY(loc_dDataf),   2, "0") + " 23:59:59'"

                *-- Criar cursor de resultado do processamento
                CREATE CURSOR TmpRelat (;
                    Fase c(10), IClis c(10), RClis c(50), CMats c(14), ;
                    DPros c(40), CPros c(14), DDPros c(40), Qtde n(12,3), ;
                    TpOps c(15), CUnis c(3), Operacaos c(31), Nenvs n(10), ;
                    Datas D, Pesos n(12,3), Valor n(12,2), Fators n(12,3), ;
                    Peso2s n(12,3), CUniPs c(3))
                INDEX ON DTOS(Datas) + Operacaos + STR(Nenvs,10) + CMats ;
                    TAG Operacao
                INDEX ON Fase + IClis + TpOps + CUnis + CUniPs + CMats + ;
                    Operacaos + STR(Nenvs,10) TAG FFuncMat

                *-- SQL principal: SigCdNec (cabecalho) x SigCdNei (itens)
                loc_cSQL = ;
                    "SELECT a.Datas,a.CIdChaves,a.Emps,a.DopPs,a.NumPs," + ;
                    "a.GrupoOs,a.ContaOs,b.CMats,b.Qtds,b.TpOps,b.Nenvs," + ;
                    "a.GrupoDs,a.ContaDs,b.Nops,b.Pesos,b.peso2s,b.Fators," + ;
                    "b.Servicos,b.Cats,b.Empdnps " + ;
                    "FROM SigCdNec a, SigCdNei b " + ;
                    "WHERE a.Datas BETWEEN " + FormatarDataSQL(loc_dDatai) + ;
                    " AND " + loc_cDataFimSQL + " AND "

                IF !EMPTY(loc_cGrupo)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.GrupoDs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.GrupoOs = " + EscaparSQL(loc_cGrupo) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cConta)
                    IF loc_lDestino
                        loc_cSQL = loc_cSQL + "a.ContaDs = " + EscaparSQL(loc_cConta) + " AND "
                    ELSE
                        loc_cSQL = loc_cSQL + "a.ContaOs = " + EscaparSQL(loc_cConta) + " AND "
                    ENDIF
                ENDIF

                IF !EMPTY(loc_cDopp)
                    loc_cSQL = loc_cSQL + "a.Dopps = " + EscaparSQL(loc_cDopp) + " AND "
                ENDIF

                IF loc_nNumes > 0
                    loc_cSQL = loc_cSQL + "a.NumPs = " + FormatarNumeroSQL(loc_nNumes) + " AND "
                ENDIF

                loc_cSQL = loc_cSQL + "a.EmpDNPs = b.EmpDNPs ORDER BY a.cIdChaves"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpNens")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = ;
                        "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es"
                    EXIT
                ENDIF

                *-- Filtrar operacoes marcadas no grid + tipo geracao OP
                SELECT * FROM CsSigCdOpd ;
                    WHERE Marca > 0 ;
                    AND IIF(!EMPTY(loc_cTGOp), CodTgOps = loc_cTGOp, .T.) ;
                    INTO CURSOR csLocalMc READWRITE
                GO TOP IN csLocalMc

                *-- Cruzar movimentacoes com operacoes selecionadas
                IF EMPTY(loc_cDopp) AND !EOF("csLocalMc")
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs AND b.Marca > 0 ;
                        INTO CURSOR CrSigCdNec READWRITE
                ELSE
                    SELECT a.* FROM TmpNens a, CsSigCdOpd b ;
                        WHERE a.DopPs = b.DopPs ;
                        AND IIF(!EMPTY(loc_cTGOp), b.CodTgOps = loc_cTGOp, .T.) ;
                        INTO CURSOR CrSigCdNec READWRITE
                ENDIF

                *-- Filtro por envelope especifico
                IF loc_nEnvelope > 0
                    SELECT DISTINCT Empdnps FROM CrSigCdNec ;
                        WHERE Nenvs = loc_nEnvelope ;
                        INTO CURSOR crEnvelope READWRITE
                ENDIF

                SELECT CrSigCdNec
                INDEX ON DTOS(Datas) + CIdChaves TAG Datas
                SET ORDER TO Datas
                GO TOP IN CrSigCdNec

                *-- Processar cada registro de movimentacao
                loc_lAbortarScan = .F.
                IF RECCOUNT("CrSigCdNec") > 0
                    SCAN IN CrSigCdNec
                        *-- Filtro tipo material/operacao
                        IF !EMPTY(loc_cTpOpt) AND ;
                                ALLTRIM(CrSigCdNec.TpOps) <> ALLTRIM(loc_cTpOpt)
                            LOOP
                        ENDIF

                        *-- Filtro por envelope
                        IF loc_nEnvelope > 0
                            SELECT crEnvelope
                            LOCATE FOR ALLTRIM(Empdnps) = ALLTRIM(CrSigCdNec.Empdnps)
                            IF EOF("crEnvelope")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Filtro por numero de OP
                        IF loc_nOp > 0 AND ;
                                !BETWEEN(CrSigCdNec.Nops, loc_nOpI, loc_nOpF)
                            LOOP
                        ENDIF

                        *-- Filtro por cliente especifico
                        IF !EMPTY(loc_cCodCli)
                            LOCAL loc_cQLCli
                            IF !EMPTY(CrSigCdNec.Nops) AND CrSigCdNec.Nops <> 0
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM sigoppic a " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE a.Nops = " + ;
                                    FormatarNumeroSQL(CrSigCdNec.Nops) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ELSE
                                loc_cQLCli = ;
                                    "SELECT CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Iclis ELSE e.Iclis END AS Iclis," + ;
                                    "CASE WHEN c.globalizas = 1 " + ;
                                    "THEN d.Rclis ELSE e.Rclis END AS Rclis " + ;
                                    "FROM SigPdMvf f " + ;
                                    "INNER JOIN sigoppic a ON f.Nops = a.Nops " + ;
                                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                                    "INNER JOIN SigCdOpe c ON b.Dopes = c.Dopes " + ;
                                    "INNER JOIN SigCdCli d ON b.ContaOs = d.Iclis " + ;
                                    "INNER JOIN SigCdCli e ON b.ContaDs = e.Iclis " + ;
                                    "WHERE f.EmpDnPs = " + ;
                                    EscaparSQL(ALLTRIM(CrSigCdNec.EmpDnPs)) + ;
                                    " AND (b.ContaOs = " + EscaparSQL(loc_cCodCli) + ;
                                    " OR b.ContaDs = " + EscaparSQL(loc_cCodCli) + ")"
                            ENDIF
                            IF USED("LocalCli")
                                USE IN LocalCli
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLCli, "LocalCli") < 1
                                THIS.this_cMensagemErro = "Erro ao verificar cliente"
                                loc_lAbortarScan = .T.
                                EXIT
                            ENDIF
                            IF EOF("LocalCli")
                                SELECT CrSigCdNec
                                LOOP
                            ENDIF
                            SELECT CrSigCdNec
                        ENDIF

                        *-- Ignorar servicos sem OP vinculada
                        IF CrSigCdNec.Servicos AND ;
                                !EMPTY(CrSigCdNec.Nenvs) AND ;
                                EMPTY(ALLTRIM(CrSigCdNec.Cats))
                            LOOP
                        ENDIF

                        *-- Buscar descricao e grupo do material
                        LOCAL loc_cQLPro
                        loc_cQLPro = ;
                            "SELECT a.CPros,a.DPros,a.CGrus,a.CUnis,a.CUniPs,b.Mercs " + ;
                            "FROM SigCdPro a, SigCdGrp b " + ;
                            "WHERE a.CPros = " + ;
                            EscaparSQL(ALLTRIM(CrSigCdNec.CMats)) + ;
                            " AND a.Cgrus = b.Cgrus"
                        IF USED("CrSigCdPro")
                            USE IN CrSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cQLPro, "CrSigCdPro") < 1
                            THIS.this_cMensagemErro = "Erro ao buscar produto"
                            loc_lAbortarScan = .T.
                            EXIT
                        ENDIF
                        SELECT CrSigCdPro

                        *-- Filtro grupo materia prima
                        IF !EMPTY(loc_cGruMat) AND ;
                                ALLTRIM(CrSigCdPro.CGrus) <> ALLTRIM(loc_cGruMat)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Filtro grande grupo
                        IF !EMPTY(loc_cGgrp) AND ;
                                ALLTRIM(CrSigCdPro.Mercs) <> ALLTRIM(loc_cGgrp)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Montar variaveis de agrupamento
                        loc_cTpOps = IIF(loc_lImprimeTpMat, ;
                            CrSigCdNec.TpOps, SPACE(15))
                        loc_cGrp = IIF(loc_lDestino, ;
                            CrSigCdNec.GrupoDs, CrSigCdNec.GrupoOs)
                        loc_cCta = IIF(loc_lDestino, ;
                            CrSigCdNec.Contads, CrSigCdNec.ContaOs)
                        loc_cPed = PADR(IIF(loc_lDope, ;
                            ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                            ALLTRIM(STR(CrSigCdNec.Numps,10)), " "), 31)
                        loc_nEnv = IIF(loc_lDope, CrSigCdNec.Nenvs, 0)

                        *-- Filtrar grupo de transito (configurado em SigCdPam)
                        IF USED("CrSigCdPam") AND ;
                                ALLTRIM(loc_cGrp) = ALLTRIM(CrSigCdPam.GrTrans)
                            SELECT CrSigCdNec
                            LOOP
                        ENDIF

                        *-- Buscar produto da OP (apenas quando necessario)
                        loc_cPro = ""
                        loc_cDpr = ""
                        IF !EMPTY(CrSigCdNec.Nops) AND ;
                                CrSigCdNec.Nops <> 0 AND ;
                                THIS.this_lImprimeProdutos
                            LOCAL loc_cQLOpPro
                            loc_cQLOpPro = ;
                                "SELECT TOP 1 a.Cpros, b.DPros " + ;
                                "FROM SigOpPic a " + ;
                                "INNER JOIN SigCdPro b ON a.Cpros = b.Cpros " + ;
                                "WHERE Nops = " + ;
                                FormatarNumeroSQL(CrSigCdNec.Nops)
                            IF USED("LocalPro")
                                USE IN LocalPro
                            ENDIF
                            IF SQLEXEC(gnConnHandle, loc_cQLOpPro, "LocalPro") > 0
                                GO TOP IN LocalPro
                                IF !EOF("LocalPro")
                                    loc_cDpr = ALLTRIM(LocalPro.DPros)
                                    loc_cPro = ALLTRIM(LocalPro.Cpros)
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Inserir/acumular em TmpRelat
                        SELECT TmpRelat
                        IF loc_lDopeDt
                            *-- Modo detalhado: agrupa por DopPs + data
                            LOCAL loc_cPedDt, loc_nEnvDt
                            loc_cPedDt = ALLTRIM(CrSigCdNec.Dopps) + "-" + ;
                                ALLTRIM(STR(CrSigCdNec.Numps,10))
                            loc_nEnvDt = CrSigCdNec.Nops
                            SET ORDER TO Operacao
                            IF !SEEK(DTOS(CrSigCdNec.Datas) + ;
                                    PADR(loc_cPedDt,31) + ;
                                    STR(loc_nEnvDt,10) + ;
                                    PADR(ALLTRIM(CrSigCdNec.CMats),14))
                                INSERT INTO TmpRelat ;
                                    (Datas, Operacaos, Nenvs, CMats, Dpros, ;
                                    Cunis, CPros, DDPros, Fators) ;
                                    VALUES (CrSigCdNec.Datas, loc_cPedDt, ;
                                    loc_nEnvDt, ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPro, loc_cDpr, CrSigCdNec.Fators)
                            ENDIF
                            REPLACE Qtde  WITH Qtde  + CrSigCdNec.Qtds, ;
                                    Pesos WITH Pesos + CrSigCdNec.Pesos
                            REPLACE Valor WITH Valor + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ELSE
                            *-- Modo resumido: agrupa por grupo/conta/material
                            SET ORDER TO FFuncMat
                            IF !SEEK(loc_cGrp + loc_cCta + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats + loc_cPed + ;
                                    STR(loc_nEnv,10))
                                *-- Buscar nome da conta para exibicao
                                LOCAL loc_cRClis, loc_cQLCli2
                                loc_cRClis = ""
                                loc_cQLCli2 = ;
                                    "SELECT IClis, RClis FROM SigCdCli " + ;
                                    "WHERE IClis = " + ;
                                    EscaparSQL(ALLTRIM(loc_cCta))
                                IF USED("CrTmpCli")
                                    USE IN CrTmpCli
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cQLCli2, "CrTmpCli") > 0
                                    SELECT CrTmpCli
                                    IF !EOF("CrTmpCli")
                                        loc_cRClis = ALLTRIM(CrTmpCli.RClis)
                                    ENDIF
                                ENDIF
                                SELECT TmpRelat
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, Dpros, CPros, ;
                                    DDPros, TpOps, Cunis, Operacaos, Nenvs, ;
                                    Datas, Fators, CuniPs) ;
                                    VALUES (loc_cGrp, loc_cCta, loc_cRClis, ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    ALLTRIM(CrSigCdPro.Dpros), ;
                                    loc_cPro, loc_cDpr, loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    loc_cPed, loc_nEnv, CrSigCdNec.Datas, ;
                                    CrSigCdNec.Fators, ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)

                            *-- Linha de total geral por material
                            SET ORDER TO FFuncMat
                            IF !SEEK(REPLICATE(CHR(255),20) + loc_cTpOps + ;
                                    CrSigCdPro.Cunis + CrSigCdPro.CuniPs + ;
                                    CrSigCdNec.CMats)
                                INSERT INTO TmpRelat ;
                                    (Fase, Iclis, RClis, CMats, TpOps, ;
                                    Cunis, CuniPs) ;
                                    VALUES (REPLICATE(CHR(255),10), ;
                                    REPLICATE(CHR(255),10), ;
                                    "Total Geral : ", ;
                                    ALLTRIM(CrSigCdNec.CMats), ;
                                    loc_cTpOps, ;
                                    ALLTRIM(CrSigCdPro.Cunis), ;
                                    ALLTRIM(CrSigCdPro.CuniPs))
                            ENDIF
                            REPLACE Qtde   WITH Qtde   + CrSigCdNec.Qtds, ;
                                    Peso2s WITH Peso2s + CrSigCdNec.Peso2s
                            REPLACE Valor  WITH Valor  + ;
                                (CrSigCdNec.Fators * CrSigCdNec.Qtds)
                        ENDIF

                        SELECT CrSigCdNec
                    ENDSCAN
                ENDIF

                IF loc_lAbortarScan
                    EXIT
                ENDIF

                *-- Montar cabecalho do relatorio
                loc_cCab = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
                loc_cSub = IIF(THIS.this_lRelatorio, "", ;
                    IIF(loc_lDestino, "Por Destino", "Por Origem") + " - ") + ;
                    "Per" + CHR(237) + "odo : " + ;
                    ALLTRIM(DTOC(loc_dDatai)) + ;
                    " at" + CHR(233) + " " + ALLTRIM(DTOC(loc_dDataf))

                IF USED("CrSigCdEmp")
                    USE IN CrSigCdEmp
                ENDIF
                LOCAL loc_cQLEmp
                loc_cQLEmp = "SELECT Cemps, Razas FROM SigCdEmp " + ;
                    "WHERE Cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                SQLEXEC(gnConnHandle, loc_cQLEmp, "CrSigCdEmp")
                loc_cEmp = go_4c_Sistema.cCodEmpresa + " - "
                IF USED("CrSigCdEmp") AND !EOF("CrSigCdEmp")
                    loc_cEmp = loc_cEmp + ALLTRIM(CrSigCdEmp.Razas)
                ENDIF

                IF THIS.this_lImprimeFuncs AND !EMPTY(loc_cConta)
                    LOCAL loc_cQLFuncs
                    loc_cQLFuncs = ;
                        "SELECT a.RClis, a.Cpfs FROM SigCdCli a " + ;
                        "WHERE a.IClis = " + EscaparSQL(PADR(loc_cConta,10))
                    IF USED("LocalCli")
                        USE IN LocalCli
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cQLFuncs, "LocalCli") < 1
                        THIS.this_cMensagemErro = ;
                            "Erro ao buscar funcion" + CHR(225) + "rio"
                        EXIT
                    ENDIF
                    SELECT LocalCli
                    GO TOP IN LocalCli
                    IF !EOF("LocalCli")
                        loc_cSub = loc_cSub + CHR(13) + CHR(13) + ;
                            "NOME: " + ALLTRIM(LocalCli.RClis) + ;
                            " / CPF: " + ALLTRIM(LocalCli.Cpfs)
                    ENDIF
                ENDIF

                CREATE CURSOR dbCabecalho ;
                    (Titulo c(100), SubTitulo c(200), NomeEmpresa c(100), ImpFuncs L)
                INSERT INTO dbCabecalho (Titulo, SubTitulo, NomeEmpresa, ImpFuncs) ;
                    VALUES (loc_cCab, loc_cSub, loc_cEmp, THIS.this_lImprimeFuncs)

                SELECT TmpRelat
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em tela (preview)
    * Replica: PROCEDURE visualizacao do legado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX

        loc_lSucesso = .F.

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) PREVIEW NOCONSOLE
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    * par_lComDialogo: .T. = abre dialogo de impressora, .F. = imprime direto
    * Replica: PROCEDURE impressao (prompt) e documento (direto) do legado
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir(par_lComDialogo)
        LOCAL loc_lSucesso, loc_oErro, loc_cFRX, loc_lDialogo

        loc_lSucesso = .F.
        loc_lDialogo = IIF(PCOUNT() >= 1, par_lComDialogo, .F.)

        TRY
            DO WHILE .T.
                IF !THIS.PrepararDados()
                    EXIT
                ENDIF

                loc_cFRX = THIS.ObterNomeFRX()

                IF loc_cFRX = "SigReDp7"
                    SET POINT TO ","
                    SET SEPARATOR TO "."
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                    SET POINT TO "."
                    SET SEPARATOR TO ","
                ELSE
                    IF loc_lDialogo
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT PROMPT NOCONSOLE
                    ELSE
                        REPORT FORM (gc_4c_CaminhoReports + loc_cFRX) ;
                            TO PRINT NOCONSOLE
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigReDpDBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

