# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigrefcx.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo
[Formsigrefcx.prg] Procedure vazia (sem codigo): HabilitarCampos

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefcx.prg):
*==============================================================================
* FORMSIGREFCX.PRG
* Relat" + CHR(243) + "rio Fechamento de Caixa
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREFCX.SCX (frmrelatorio)
*
* Filtros: Empresa, Per" + CHR(237) + "odo, Moeda, Usu" + CHR(225) + "rio, Operador
*          OptQuebra, OptImpNomCli, OpcTipo, OptCol, OptMov, opt_nr_opcao
*          9 combos de resumo, 3 checkboxes, GrdTipo (SigCdTom)
*
* Bot" + CHR(245) + "es: Visualizar / Imprimir / Excel / Encerrar
*==============================================================================

DEFINE CLASS Formsigrefcx AS FormBase

    Height      = 500
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

    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Fechamento de Caixa"
            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_oRelatorio = CREATEOBJECT("sigrefcxBO")
                IF VARTYPE(THIS.this_oRelatorio) != "O"
                    MsgErro("Erro ao criar sigrefcxBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Garante cs_SigCdTom para grid (BO popula com dados reais; placeholder aqui para UI validation)
                IF !USED("cs_SigCdTom")
                    CREATE CURSOR cs_SigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                    INDEX ON Codigos TAG Codigos
                ENDIF

                THIS.ConfigurarPaginaLista()

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
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
                .Caption   = "Fechamento de Caixa"
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
                .Caption   = "Fechamento de Caixa"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

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
                .FontName        = "Tahoma"
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
                .FontName        = "Tahoma"
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
                .FontName        = "Tahoma"
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

    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas
        loc_oPgf.PageCount = 1
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *======================================================================
        * EMPRESA (original top=96/99 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH loc_oPg.lbl_4c_LblEmpresa
            .Top       = 14
            .Left      = 108
            .Width     = 52
            .Height    = 15
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_CdEmpresa
            .Top           = 11
            .Left          = 162
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsEmpresa", "TextBox")
        WITH loc_oPg.txt_4c_DsEmpresa
            .Top           = 11
            .Left          = 195
            .Width         = 289
            .Height        = 23
            .Value         = ""
            .MaxLength     = 40
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * PERIODO (original top=121/124 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH loc_oPg.lbl_4c_LblPeriodo
            .Top       = 39
            .Left      = 113
            .Width     = 48
            .Height    = 15
            .Caption   = "Per" + CHR(237) + "odo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPg.txt_4c_DtInicial
            .Top           = 36
            .Left          = 162
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_SepDatas", "Label")
        WITH loc_oPg.lbl_4c_SepDatas
            .Top       = 39
            .Left      = 247
            .Width     = 22
            .Height    = 15
            .Caption   = "at" + CHR(233)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPg.txt_4c_DtFinal
            .Top           = 36
            .Left          = 271
            .Width         = 80
            .Height        = 23
            .Value         = {}
            .Format        = "D"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * MOEDA (original top=146/149 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
        WITH loc_oPg.lbl_4c_LblMoeda
            .Top       = 64
            .Left      = 117
            .Width     = 44
            .Height    = 15
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CdMoeda", "TextBox")
        WITH loc_oPg.txt_4c_CdMoeda
            .Top           = 61
            .Left          = 162
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 3
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_DsMoeda", "TextBox")
        WITH loc_oPg.txt_4c_DsMoeda
            .Top           = 61
            .Left          = 195
            .Width         = 156
            .Height        = 23
            .Value         = ""
            .MaxLength     = 15
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * USUARIO / OPERADOR (original top=171/174 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
        WITH loc_oPg.lbl_4c_LblUsuario
            .Top       = 89
            .Left      = 113
            .Width     = 47
            .Height    = 15
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Usuario", "TextBox")
        WITH loc_oPg.txt_4c_Usuario
            .Top           = 86
            .Left          = 162
            .Width         = 82
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .InputMask     = "!"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblOperador", "Label")
        WITH loc_oPg.lbl_4c_LblOperador
            .Top       = 89
            .Left      = 262
            .Width     = 56
            .Height    = 15
            .Caption   = "Operador :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Operador", "TextBox")
        WITH loc_oPg.txt_4c_Operador
            .Top           = 86
            .Left          = 320
            .Width         = 31
            .Height        = 23
            .Value         = ""
            .MaxLength     = 10
            .InputMask     = "999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *======================================================================
        * QUEBRA DE IMPRESSAO (original top=198/199 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblQuebra", "Label")
        WITH loc_oPg.lbl_4c_LblQuebra
            .Top       = 114
            .Left      = 45
            .Width     = 110
            .Height    = 15
            .Caption   = "Quebra de Impress" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptQuebra", "OptionGroup")
        loc_oPg.opt_4c_OptQuebra.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptQuebra
            .Top         = 113
            .Left        = 155
            .Width       = 232
            .Height      = 20
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptQuebra.Buttons(1)
            .Caption   = "Usu" + CHR(225) + "rio"
            .Left      = 5
            .Top       = 2
            .Width     = 54
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptQuebra.Buttons(2)
            .Caption   = "Sem Quebra"
            .Left      = 111
            .Top       = 2
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptQuebra.Value = 1

        *======================================================================
        * NOME DO CLIENTE (original top=221/222 -> ajustado -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblNomeCli", "Label")
        WITH loc_oPg.lbl_4c_LblNomeCli
            .Top       = 137
            .Left      = 71
            .Width     = 82
            .Height    = 15
            .Caption   = "Nome do Cliente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_ImpNomCli", "OptionGroup")
        loc_oPg.opt_4c_ImpNomCli.ButtonCount = 3
        WITH loc_oPg.opt_4c_ImpNomCli
            .Top         = 136
            .Left        = 155
            .Width       = 232
            .Height      = 36
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(1)
            .Caption   = "Imprimir"
            .Left      = 5
            .Top       = 2
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(2)
            .Caption   = "N" + CHR(227) + "o Imprimir"
            .Left      = 111
            .Top       = 2
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_ImpNomCli.Buttons(3)
            .Caption   = "Imprimir Nome OU Observa" + CHR(231) + CHR(227) + "o"
            .Left      = 5
            .Top       = 19
            .Width     = 165
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *======================================================================
        * TIPO (Opc_Tipo): Agrupado/Individual (original top=259/264 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
        WITH loc_oPg.lbl_4c_LblTipo
            .Top       = 179
            .Left      = 129
            .Width     = 29
            .Height    = 15
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OpcTipo", "OptionGroup")
        loc_oPg.opt_4c_OpcTipo.ButtonCount = 2
        WITH loc_oPg.opt_4c_OpcTipo
            .Top         = 174
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OpcTipo.Buttons(1)
            .Caption   = "Agrupado"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OpcTipo.Buttons(2)
            .Caption   = "Individual"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OpcTipo.Value = 1

        *======================================================================
        * IMPRESSAO EM (OptCol): 40/80 colunas (original top=283/288 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblOptCol", "Label")
        WITH loc_oPg.lbl_4c_LblOptCol
            .Top       = 203
            .Left      = 82
            .Width     = 71
            .Height    = 15
            .Caption   = "Impress" + CHR(227) + "o em :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptCol", "OptionGroup")
        loc_oPg.opt_4c_OptCol.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptCol
            .Top         = 198
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptCol.Buttons(1)
            .Caption   = "40 Colunas"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptCol.Buttons(2)
            .Caption   = "80 Colunas"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptCol.Value = 2

        *======================================================================
        * OPCAO (opt_nr_opcao): Sim/Nao/Ambos (original top=308/311 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblNrOpcao", "Label")
        WITH loc_oPg.lbl_4c_LblNrOpcao
            .Top       = 226
            .Left      = 118
            .Width     = 35
            .Height    = 15
            .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_NrOpcao", "OptionGroup")
        loc_oPg.opt_4c_NrOpcao.ButtonCount = 3
        WITH loc_oPg.opt_4c_NrOpcao
            .Top         = 223
            .Left        = 155
            .Width       = 232
            .Height      = 23
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 59
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_NrOpcao.Buttons(3)
            .Caption   = "Ambos"
            .Left      = 111
            .Top       = 4
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_NrOpcao.Value = 3

        *======================================================================
        * MOVIMENTACOES (OptMov): Sim/Nao (original top=327/332 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblOptMov", "Label")
        WITH loc_oPg.lbl_4c_LblOptMov
            .Top       = 247
            .Left      = 75
            .Width     = 80
            .Height    = 15
            .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("opt_4c_OptMov", "OptionGroup")
        loc_oPg.opt_4c_OptMov.ButtonCount = 2
        WITH loc_oPg.opt_4c_OptMov
            .Top         = 242
            .Left        = 155
            .Width       = 232
            .Height      = 27
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.opt_4c_OptMov.Buttons(1)
            .Caption   = "Sim"
            .Left      = 5
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg.opt_4c_OptMov.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 111
            .Top       = 5
            .Width     = 83
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        loc_oPg.opt_4c_OptMov.Value = 1

        *======================================================================
        * TIPO DE MOVIMENTACAO (painel direito) - original top=201/216 -> -85
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblTipoMov", "Label")
        WITH loc_oPg.lbl_4c_LblTipoMov
            .Top       = 116
            .Left      = 403
            .Width     = 172
            .Height    = 17
            .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("grd_4c_GrdTipo", "Grid")
        WITH loc_oPg.grd_4c_GrdTipo
            .Top           = 131
            .Left          = 403
            .Width         = 251
            .Height        = 138
            .RecordSource  = "cs_SigCdTom"
            .ColumnCount   = 2
            .DeleteMark    = .F.
            .HeaderHeight  = 0
            .RecordMark    = .F.
            .RowHeight     = 18
            .ScrollBars    = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .GridLineColor = RGB(238, 238, 238)
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.grd_4c_GrdTipo.Column1
            .Width     = 20
            .Alignment = 0
            .Sparse    = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .T.
            .AddObject("chk_4c_GrdMarca", "CheckBox")
            WITH .chk_4c_GrdMarca
                .Caption   = ""
                .Alignment = 0
                .Width     = 20
                .Height    = 17
                .FontName  = "Tahoma"
            ENDWITH
            .CurrentControl = "chk_4c_GrdMarca"
            .ControlSource  = "cs_SigCdTom.Marca"
        ENDWITH
        WITH loc_oPg.grd_4c_GrdTipo.Column2
            .Width         = 215
            .ControlSource = "cs_SigCdTom.Descri"
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Enabled       = .T.
        ENDWITH

        loc_oPg.AddObject("btn_4c_SelTudo", "CommandButton")
        WITH loc_oPg.btn_4c_SelTudo
            .Top         = 156
            .Left        = 657
            .Width       = 45
            .Height      = 45
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Marcar"
            .TabStop     = .F.
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("btn_4c_Apaga", "CommandButton")
        WITH loc_oPg.btn_4c_Apaga
            .Top         = 201
            .Left        = 657
            .Width       = 45
            .Height      = 45
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar"
            .TabStop     = .F.
            .ForeColor   = RGB(36, 84, 155)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .FontName    = "Verdana"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * SEPARADOR (shp_fechamento original top=366 -> -85)
        *======================================================================
        loc_oPg.AddObject("shp_4c_Separador", "Shape")
        WITH loc_oPg.shp_4c_Separador
            .Top         = 275
            .Left        = 6
            .Width       = 782
            .Height      = 2
            .BackStyle   = 1
            .BorderStyle = 6
            .BorderWidth = 2
            .FillStyle   = 1
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *======================================================================
        * IMPRESSAO DE RESUMOS - cabecalho (original top=351 -> -85)
        *======================================================================
        loc_oPg.AddObject("lbl_4c_LblResumos", "Label")
        WITH loc_oPg.lbl_4c_LblResumos
            .Top       = 266
            .Left      = 6
            .Width     = 135
            .Height    = 15
            .Caption   = "Impress" + CHR(227) + "o de Resumos"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Linha 1: Lancamento | Lancto.xF.Pagto | Conta Corrente
        loc_oPg.AddObject("lbl_4c_LblLanca", "Label")
        WITH loc_oPg.lbl_4c_LblLanca
            .Top       = 292
            .Left      = 32
            .Width     = 70
            .Height    = 15
            .Caption   = "Lan" + CHR(231) + "amento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResLanca", "ComboBox")
        WITH loc_oPg.cmb_4c_ResLanca
            .Top           = 287
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_ChkDetLan", "CheckBox")
        WITH loc_oPg.chk_4c_ChkDetLan
            .Top           = 291
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLanFor", "Label")
        WITH loc_oPg.lbl_4c_LblLanFor
            .Top       = 292
            .Left      = 322
            .Width     = 100
            .Height    = 15
            .Caption   = "Lan" + CHR(231) + "to. x F. Pagto.:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResLanFor", "ComboBox")
        WITH loc_oPg.cmb_4c_ResLanFor
            .Top           = 287
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblContaC", "Label")
        WITH loc_oPg.lbl_4c_LblContaC
            .Top       = 292
            .Left      = 590
            .Width     = 85
            .Height    = 15
            .Caption   = "Conta Corrente :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResContac", "ComboBox")
        WITH loc_oPg.cmb_4c_ResContac
            .Top           = 287
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Linha 2: Cartao | Forma de Pagamento | Resumo Quantidade
        loc_oPg.AddObject("lbl_4c_LblCartao", "Label")
        WITH loc_oPg.lbl_4c_LblCartao
            .Top       = 318
            .Left      = 57
            .Width     = 44
            .Height    = 15
            .Caption   = "Cart" + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResCartao", "ComboBox")
        WITH loc_oPg.cmb_4c_ResCartao
            .Top           = 313
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_CrtDetalhado", "CheckBox")
        WITH loc_oPg.chk_4c_CrtDetalhado
            .Top           = 318
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblForma", "Label")
        WITH loc_oPg.lbl_4c_LblForma
            .Top       = 318
            .Left      = 310
            .Width     = 112
            .Height    = 15
            .Caption   = "Forma de Pagamento :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResForma", "ComboBox")
        WITH loc_oPg.cmb_4c_ResForma
            .Top           = 313
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblQtdes", "Label")
        WITH loc_oPg.lbl_4c_LblQtdes
            .Top       = 318
            .Left      = 568
            .Width     = 108
            .Height    = 15
            .Caption   = "Resumo Quantidade :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResQtdes", "ComboBox")
        WITH loc_oPg.cmb_4c_ResQtdes
            .Top           = 313
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        *-- Linha 3: Cheques | Vendedor | Vendedor Detalhado
        loc_oPg.AddObject("lbl_4c_LblCheque", "Label")
        WITH loc_oPg.lbl_4c_LblCheque
            .Top       = 344
            .Left      = 48
            .Width     = 53
            .Height    = 15
            .Caption   = "Cheques :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResCheque", "ComboBox")
        WITH loc_oPg.cmb_4c_ResCheque
            .Top           = 339
            .Left          = 103
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("chk_4c_ChqDetalhado", "CheckBox")
        WITH loc_oPg.chk_4c_ChqDetalhado
            .Top           = 344
            .Left          = 155
            .Width         = 67
            .Height        = 15
            .Caption       = "Detalhado"
            .Value         = 0
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblVendedor", "Label")
        WITH loc_oPg.lbl_4c_LblVendedor
            .Top       = 344
            .Left      = 366
            .Width     = 56
            .Height    = 15
            .Caption   = "Vendedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResVende", "ComboBox")
        WITH loc_oPg.cmb_4c_ResVende
            .Top           = 339
            .Left          = 424
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblDetVen", "Label")
        WITH loc_oPg.lbl_4c_LblDetVen
            .Top       = 344
            .Left      = 567
            .Width     = 110
            .Height    = 15
            .Caption   = "Vendedor Detalhado :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("cmb_4c_ResDetVen", "ComboBox")
        WITH loc_oPg.cmb_4c_ResDetVen
            .Top           = 339
            .Left          = 678
            .Width         = 48
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarPaginaDados()
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_CdMoeda,   "KeyPress", THIS, "TeclaCdMoeda")
        BINDEVENT(loc_oPg.txt_4c_DsMoeda,   "KeyPress", THIS, "TeclaDsMoeda")
        BINDEVENT(loc_oPg.txt_4c_DtInicial, "KeyPress", THIS, "TeclaDataInicial")
        BINDEVENT(loc_oPg.txt_4c_DtFinal,   "KeyPress", THIS, "TeclaDataFinal")
        BINDEVENT(loc_oPg.txt_4c_Usuario,   "KeyPress", THIS, "TeclaUsuario")
        BINDEVENT(loc_oPg.txt_4c_Operador,  "KeyPress", THIS, "TeclaOperador")

        BINDEVENT(loc_oPg.txt_4c_CdEmpresa, "DblClick", THIS, "AbrirBuscaCdEmpresa")
        BINDEVENT(loc_oPg.txt_4c_DsEmpresa, "DblClick", THIS, "AbrirBuscaDsEmpresa")
        BINDEVENT(loc_oPg.txt_4c_CdMoeda,   "DblClick", THIS, "AbrirBuscaCdMoeda")
        BINDEVENT(loc_oPg.txt_4c_DsMoeda,   "DblClick", THIS, "AbrirBuscaDsMoeda")
        BINDEVENT(loc_oPg.txt_4c_Usuario,   "DblClick", THIS, "AbrirBuscaUsuario")
        BINDEVENT(loc_oPg.txt_4c_Operador,  "DblClick", THIS, "AbrirBuscaOperador")

        BINDEVENT(loc_oPg.opt_4c_OptCol,   "InteractiveChange", THIS, "OptColMudou")
        BINDEVENT(loc_oPg.btn_4c_SelTudo,  "Click",             THIS, "BtnSelTudoClick")
        BINDEVENT(loc_oPg.btn_4c_Apaga,    "Click",             THIS, "BtnApagaClick")
    ENDPROC

    PROCEDURE LimparCampos()
        LOCAL loc_oPg, loc_nOptCol
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1

            loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cCdEmpresa)
            loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(THIS.this_oRelatorio.this_cDsEmpresa)
            loc_oPg.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
            loc_oPg.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
            loc_oPg.txt_4c_CdMoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cCdMoeda)
            loc_oPg.txt_4c_DsMoeda.Value   = ALLTRIM(THIS.this_oRelatorio.this_cDsMoeda)
            loc_oPg.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oRelatorio.this_cUsuario)
            loc_oPg.txt_4c_Operador.Value  = ALLTRIM(THIS.this_oRelatorio.this_cOperador)

            *-- OptCol a partir de SigCdPam.resimps (default 2 = 80 colunas)
            loc_nOptCol = 2
            IF USED("CrSigCdPam")
                SELECT CrSigCdPam
                GO TOP
                IF !EOF() AND TYPE("CrSigCdPam.resimps") != "U"
                    IF INLIST(NVL(resimps, 0), 1, 2)
                        loc_nOptCol = NVL(resimps, 2)
                    ENDIF
                ENDIF
            ENDIF
            loc_oPg.opt_4c_OptCol.Value = loc_nOptCol

            loc_oPg.opt_4c_OptQuebra.Value = THIS.this_oRelatorio.this_nOptQuebra
            loc_oPg.opt_4c_ImpNomCli.Value = THIS.this_oRelatorio.this_nOptImpNomCli
            loc_oPg.opt_4c_OpcTipo.Value   = THIS.this_oRelatorio.this_nOpcTipo
            loc_oPg.opt_4c_OptMov.Value    = THIS.this_oRelatorio.this_nOptMov
            loc_oPg.opt_4c_NrOpcao.Value   = THIS.this_oRelatorio.this_nOptNrOpcao

            *-- 40 colunas: desabilita e forca ImpNomCli = Nao Imprimir
            loc_oPg.opt_4c_ImpNomCli.Enabled = (loc_nOptCol = 2)
            IF loc_nOptCol = 1
                loc_oPg.opt_4c_ImpNomCli.Value = 2
            ENDIF

            *-- ComboBoxes de resumo (ListIndex: 1=Sim, 2=Nao)
            loc_oPg.cmb_4c_ResLanca.ListIndex  = THIS.this_oRelatorio.this_nResLanca
            loc_oPg.cmb_4c_ResForma.ListIndex  = THIS.this_oRelatorio.this_nResForma
            loc_oPg.cmb_4c_ResCheque.ListIndex = THIS.this_oRelatorio.this_nResCheque
            loc_oPg.cmb_4c_ResCartao.ListIndex = THIS.this_oRelatorio.this_nResCartao
            loc_oPg.cmb_4c_ResVende.ListIndex  = THIS.this_oRelatorio.this_nResVende
            loc_oPg.cmb_4c_ResContac.ListIndex = THIS.this_oRelatorio.this_nResConta
            loc_oPg.cmb_4c_ResLanFor.ListIndex = THIS.this_oRelatorio.this_nResLanFor
            loc_oPg.cmb_4c_ResQtdes.ListIndex  = THIS.this_oRelatorio.this_nResQtdes
            loc_oPg.cmb_4c_ResDetVen.ListIndex = THIS.this_oRelatorio.this_nResVDets

            *-- CheckBoxes
            loc_oPg.chk_4c_CrtDetalhado.Value = THIS.this_oRelatorio.this_nCrtDetalhado
            loc_oPg.chk_4c_ChqDetalhado.Value = THIS.this_oRelatorio.this_nChqDetalhado
            loc_oPg.chk_4c_ChkDetLan.Value    = THIS.this_oRelatorio.this_nChkDetLan

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "LimparCampos")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCdEmpresa    = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
            .this_cDsEmpresa    = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
            .this_dDtInicial    = loc_oPg.txt_4c_DtInicial.Value
            .this_dDtFinal      = loc_oPg.txt_4c_DtFinal.Value
            .this_cCdMoeda      = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
            .this_cDsMoeda      = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
            .this_cUsuario      = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
            .this_cOperador     = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
            .this_nOptQuebra    = loc_oPg.opt_4c_OptQuebra.Value
            .this_nOptImpNomCli = loc_oPg.opt_4c_ImpNomCli.Value
            .this_nOpcTipo      = loc_oPg.opt_4c_OpcTipo.Value
            .this_nOptcol       = loc_oPg.opt_4c_OptCol.Value
            .this_nOptNrOpcao   = loc_oPg.opt_4c_NrOpcao.Value
            .this_nOptMov       = loc_oPg.opt_4c_OptMov.Value
            .this_nResLanca  = IIF(loc_oPg.cmb_4c_ResLanca.ListIndex  > 0, loc_oPg.cmb_4c_ResLanca.ListIndex,  1)
            .this_nResForma  = IIF(loc_oPg.cmb_4c_ResForma.ListIndex  > 0, loc_oPg.cmb_4c_ResForma.ListIndex,  1)
            .this_nResCheque = IIF(loc_oPg.cmb_4c_ResCheque.ListIndex > 0, loc_oPg.cmb_4c_ResCheque.ListIndex, 1)
            .this_nResCartao = IIF(loc_oPg.cmb_4c_ResCartao.ListIndex > 0, loc_oPg.cmb_4c_ResCartao.ListIndex, 1)
            .this_nResVende  = IIF(loc_oPg.cmb_4c_ResVende.ListIndex  > 0, loc_oPg.cmb_4c_ResVende.ListIndex,  1)
            .this_nResConta  = IIF(loc_oPg.cmb_4c_ResContac.ListIndex > 0, loc_oPg.cmb_4c_ResContac.ListIndex, 1)
            .this_nResLanFor = IIF(loc_oPg.cmb_4c_ResLanFor.ListIndex > 0, loc_oPg.cmb_4c_ResLanFor.ListIndex, 1)
            .this_nResQtdes  = IIF(loc_oPg.cmb_4c_ResQtdes.ListIndex  > 0, loc_oPg.cmb_4c_ResQtdes.ListIndex,  1)
            .this_nResVDets  = IIF(loc_oPg.cmb_4c_ResDetVen.ListIndex > 0, loc_oPg.cmb_4c_ResDetVen.ListIndex, 1)
            .this_nCrtDetalhado = loc_oPg.chk_4c_CrtDetalhado.Value
            .this_nChqDetalhado = loc_oPg.chk_4c_ChqDetalhado.Value
            .this_nChkDetLan    = loc_oPg.chk_4c_ChkDetLan.Value
        ENDWITH
    ENDPROC

    PROTECTED PROCEDURE ValidarPeriodo()
        LOCAL loc_oPg, loc_dIni, loc_dFim
        loc_oPg  = THIS.pgf_4c_Paginas.Page1
        loc_dIni = loc_oPg.txt_4c_DtInicial.Value
        loc_dFim = loc_oPg.txt_4c_DtFinal.Value
        IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
            MsgAviso("Data Final Menor Que a Inicial!!!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_DtFinal.SetFocus()
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lContinuar
        loc_lContinuar = .T.
        TRY
            IF !THIS.ValidarPeriodo()
                loc_lContinuar = .F.
            ENDIF
            IF loc_lContinuar AND VARTYPE(THIS.this_oRelatorio) = "O"
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.GerarExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *-- OptCol.InteractiveChange: 40 colunas obriga ImpNomCli = Nao Imprimir
    PROCEDURE OptColMudou()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF loc_oPg.opt_4c_OptCol.Value = 1
                loc_oPg.opt_4c_ImpNomCli.Value   = 2
                loc_oPg.opt_4c_ImpNomCli.Enabled = .F.
            ELSE
                loc_oPg.opt_4c_ImpNomCli.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "OptColMudou")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSelTudoClick()
        TRY
            IF USED("cs_SigCdTom")
                SELECT cs_SigCdTom
                REPLACE ALL Marca WITH 1
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnSelTudoClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnApagaClick()
        TRY
            IF USED("cs_SigCdTom")
                SELECT cs_SigCdTom
                REPLACE ALL Marca WITH 0
                GO TOP
                THIS.pgf_4c_Paginas.Page1.grd_4c_GrdTipo.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "BtnApagaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (F4=115, ENTER=13, TAB=9)
    *==========================================================================

    PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCdMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDsMoeda()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dIni > loc_dFim
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaDataFinal(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg, loc_dIni, loc_dFim
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            loc_dIni = loc_oPg.txt_4c_DtInicial.Value
            loc_dFim = loc_oPg.txt_4c_DtFinal.Value
            IF !EMPTY(loc_dIni) AND !EMPTY(loc_dFim) AND loc_dFim < loc_dIni
                MsgAviso("Data Final Menor Que a Inicial!!!", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_DtFinal.Value = loc_dIni
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TeclaUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarUsuario()
        ENDIF
    ENDPROC

    PROCEDURE TeclaOperador(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaOperador()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOperador()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - EMPRESA
    *==========================================================================

    PROCEDURE AbrirBuscaCdEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDsEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Razas", "", "Empresa")
                    loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                        loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                        loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarCdEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
            EscaparSQL(loc_cValor)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal
            IF !EOF()
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
            ELSE
                loc_oPg.txt_4c_DsEmpresa.Value = ""
                THIS.AbrirBuscaCdEmpresa()
            ENDIF
        ELSE
            loc_oPg.txt_4c_DsEmpresa.Value = ""
            THIS.AbrirBuscaCdEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal")
            USE IN cursor_4c_EmpVal
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarDsEmpresa()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsEmpresa.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdEmpresa.Value = ""
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
            EscaparSQL(loc_cValor + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal2")
        IF loc_nResult > 0
            SELECT cursor_4c_EmpVal2
            IF !EOF()
                loc_oPg.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Cemps)
                loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal2.Razas)
            ELSE
                THIS.AbrirBuscaDsEmpresa()
            ENDIF
        ELSE
            THIS.AbrirBuscaDsEmpresa()
        ENDIF
        IF USED("cursor_4c_EmpVal2")
            USE IN cursor_4c_EmpVal2
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - MOEDA
    *==========================================================================

    PROCEDURE AbrirBuscaCdMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cValor, ;
            "Moedas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ELSE
                        loc_oPg.txt_4c_CdMoeda.Value = ""
                        loc_oPg.txt_4c_DsMoeda.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    PROCEDURE AbrirBuscaDsMoeda()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "dmoes", loc_cValor, ;
            "Moedas", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cmoes", "XXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                        loc_oPg.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
                        loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
                    ELSE
                        loc_oPg.txt_4c_DsMoeda.Value = ""
                        loc_oPg.txt_4c_CdMoeda.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarCdMoeda()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CdMoeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_DsMoeda.Value = ""
            RETURN
        ENDIF
        IF USED("CrSigCdMoe") AND SEEK(PADR(loc_cValor, 3), "CrSigCdMoe", "cmoes")
            loc_oPg.txt_4c_DsMoeda.Value = ALLTRIM(CrSigCdMoe.dmoes)
        ELSE
            loc_oPg.txt_4c_DsMoeda.Value = ""
            THIS.AbrirBuscaCdMoeda()
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarDsMoeda()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DsMoeda.Value)
        IF EMPTY(loc_cValor)
            loc_oPg.txt_4c_CdMoeda.Value = ""
            RETURN
        ENDIF
        THIS.AbrirBuscaDsMoeda()
    ENDPROC

    *==========================================================================
    * LOOKUP - USUARIO
    *==========================================================================

    PROCEDURE AbrirBuscaUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "usuarios", loc_cValor, ;
            "Usu" + CHR(225) + "rios", .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_Usuario.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
                    ELSE
                        loc_oPg.txt_4c_Usuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarUsuario()
        LOCAL loc_cValor, loc_cSQL, loc_nResult, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Usuario.Value)
        IF EMPTY(loc_cValor)
            RETURN
        ENDIF
        loc_cSQL = "SELECT TOP 1 usuarios FROM SigCdUsu WHERE usuarios = " + ;
            EscaparSQL(PADR(loc_cValor, 10))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuVal
            IF EOF()
                loc_oPg.txt_4c_Usuario.Value = ""
                THIS.AbrirBuscaUsuario()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Usuario.Value = ""
            THIS.AbrirBuscaUsuario()
        ENDIF
        IF USED("cursor_4c_UsuVal")
            USE IN cursor_4c_UsuVal
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUP - OPERADOR (lista de usuarios com codigo numerico curto)
    *==========================================================================

    PROCEDURE AbrirBuscaOperador()
        LOCAL loc_cValor, loc_oPg, loc_nResult, loc_oBusca
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Operador.Value)

        loc_nResult = SQLEXEC(gnConnHandle, ;
            "SELECT Usuarios FROM SigCdUsu " + ;
            "WHERE LEN(RTRIM(Usuarios)) < 4 AND ISNUMERIC(Usuarios) = 1", ;
            "cursor_4c_Operadores")
        IF loc_nResult < 1
            MsgErro("Falha ao carregar lista de operadores", "AbrirBuscaOperador")
            RETURN
        ENDIF
        SELECT cursor_4c_Operadores
        INDEX ON Usuarios TAG Usuarios

        IF EMPTY(loc_cValor) OR ;
           !SEEK(PADR(loc_cValor, 10), "cursor_4c_Operadores", "Usuarios")
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "cursor_4c_Operadores", "cursor_4c_Operadores", "Usuarios", ;
                loc_cValor, "Operadores", .F., .T., "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Usuarios", "", "Operadores")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operadores")
                    loc_oPg.txt_4c_Operador.Value = ALLTRIM(cursor_4c_Operadores.Usuarios)
                ELSE
                    loc_oPg.txt_4c_Operador.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        ELSE
            loc_oPg.txt_4c_Operador.Value = ALLTRIM(cursor_4c_Operadores.Usuarios)
        ENDIF

        IF USED("cursor_4c_Operadores")
            USE IN cursor_4c_Operadores
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE ValidarOperador()
        LOCAL loc_cValor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_Operador.Value)
        IF !EMPTY(loc_cValor)
            THIS.AbrirBuscaOperador()
        ENDIF
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    *==========================================================================

    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + ;
            "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROCEDURE BOParaForm()
        THIS.LimparCampos()
    ENDPROC

    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo()
    ENDPROC

    PROCEDURE HabilitarCampos(par_lHabilitar)
    ENDPROC

    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.Page1.txt_4c_CdEmpresa.SetFocus()
        ENDIF
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oPgf
        TRY
            loc_oPgf = THIS.pgf_4c_Paginas
            IF VARTYPE(loc_oPgf) = "O"
                loc_oPgf.ActivePage = 1
                IF VARTYPE(loc_oPgf.Pages(1)) = "O" AND ;
                   PEMSTATUS(loc_oPgf.Pages(1), "txt_4c_CdEmpresa", 5)
                    loc_oPgf.Pages(1).txt_4c_CdEmpresa.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "AlternarPagina")
        ENDTRY
    ENDPROC

    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrefcxBO.prg):
*==============================================================================
* SIGREFCXBO.PRG
* Business Object - Relatorio Fechamento de Caixa (SIGREFCX)
*
* Herda de: RelatorioBase
* Formulario: Formsigrefcx.prg
* Reports: SigReFc1 (40 colunas - impressao texto) / SigReFc2 (80 colunas)
*==============================================================================

DEFINE CLASS sigrefcxBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Filtros: datas
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: moeda
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: usuarios
    this_cUsuario       = ""
    this_cOperador      = ""

    *-- OptionGroups (1-based, valor = indice da opcao selecionada)
    this_nOptNrOpcao    = 3    && opt_nr_opcao: 1=Sim, 2=Nao, 3=Ambos
    this_nOptQuebra     = 1    && OptQuebra: 1=Usuario, 2=Sem Quebra
    this_nOptImpNomCli  = 2    && optImpNomCli: 1=Imprimir, 2=Nao Imprimir, 3=Imprimir Nome OU Obs
    this_nOptcol        = 1    && Optcol: 1=40 Colunas, 2=80 Colunas
    this_nOpcTipo       = 1    && Opc_Tipo: 1=Agrupado, 2=Individual
    this_nOptMov        = 1    && OptMov: 1=Sim, 2=Nao

    *-- ComboBoxes de resumos (1=Sim, 2=Nao; default carregado de SigCdPam via SCATTER)
    this_nResLanca      = 1    && Get_Lanca  (ControlSource=m.reslanca)
    this_nResForma      = 1    && Get_Forma  (ControlSource=m.resforma)
    this_nResCheque     = 1    && Get_Cheque (ControlSource=m.rescheque)
    this_nResCartao     = 1    && Get_Cartao (ControlSource=m.rescartao)
    this_nResVende      = 1    && Get_Vendedor (ControlSource=m.resvende)
    this_nResConta      = 1    && Get_Contac (ControlSource=m.resconta)
    this_nResLanFor     = 1    && Get_LanFor (ControlSource=m.reslanfor)
    this_nResQtdes      = 1    && Get_Qtdes  (ControlSource=m.resqtdes)
    this_nResVDets      = 1    && Get_DetVen (ControlSource=m.ResvDets; default de SigCdPac.ResvDets)

    *-- CheckBoxes detalhado (0=desmarcado, 1=marcado)
    this_nCrtDetalhado  = 0    && Crt_detalhado
    this_nChqDetalhado  = 0    && Chq_Detalhado
    this_nChkDetLan     = 0    && chkDetLan

    *-- Parametros carregados de SigCdPam no Init
    this_cMoedaPs       = ""   && SigCdPam.moedaps - moeda padrao do sistema
    this_cGrupos        = ""   && SigCdPam.Grupos  - grupo da conta corrente para saldo anterior
    this_cContas        = ""   && SigCdPam.Contas  - conta corrente para saldo anterior

    *-- Captions dinamicos das opcoes (carregados de SigCdPac no Init)
    this_cTitOpcS       = "Sim"
    this_cTitOpcN       = "N"  && completado no Init com CHR(227) + "o"
    this_cTitOpcA       = "Ambos"

    *-- Controle interno de processamento
    this_lSegunda       = .F.  && .T. para segunda rodada (relatorio 2)
    this_nMaxCols       = 40   && 40 ou 254 (calculado de this_nOptcol no PrepararDados)

    *-- Configuracao dos reports
    this_cArquivoFRX1   = "SigReFc1"   && 40 colunas (impressao texto / preview)
    this_cArquivoFRX2   = "SigReFc2"   && 80 colunas (preview + print dialog)
    this_cTitulo        = "Fechamento de Caixa"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO carregando cursores de referencia necessarios
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_lAbortou, loc_nResult, loc_oErro, loc_lcQuery
        loc_lSucesso = .F.
        loc_lAbortou = .F.
        TRY
            DODEFAULT()

            *-- Cursor de tipos de movimento (preenchido via SQLEXEC SigCdTom abaixo)
            IF !USED("cs_SigCdTom")
                CREATE CURSOR cs_SigCdTom (Marca n(1), Descri c(40), Codigos n(2))
                INDEX ON Codigos TAG Codigos
            ENDIF

            *-- 1. SigCdPam - parametros de fechamento
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "CrSigCdPam")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                loc_lAbortou = .T.
            ENDIF

            *-- Extrai defaults dos resumos e parametros de SigCdPam
            IF !loc_lAbortou AND RECCOUNT("CrSigCdPam") > 0
                SELECT CrSigCdPam
                GO TOP
                THIS.this_nResLanca  = NVL(reslanca,  1)
                THIS.this_nResForma  = NVL(resforma,  1)
                THIS.this_nResCheque = NVL(rescheque, 1)
                THIS.this_nResCartao = NVL(rescartao, 1)
                THIS.this_nResVende  = NVL(resvende,  1)
                THIS.this_nResConta  = NVL(resconta,  1)
                THIS.this_nResLanFor = NVL(reslanfor, 1)
                THIS.this_nResQtdes  = NVL(resqtdes,  1)
                THIS.this_cMoedaPs   = ALLTRIM(NVL(moedaps, ""))
                THIS.this_cGrupos    = ALLTRIM(NVL(Grupos,  ""))
                THIS.this_cContas    = ALLTRIM(NVL(Contas,  ""))
            ENDIF

            *-- 2. SigCdPac - parametros de tipos de operacao (captions das opcoes)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPac", "CrSigCdPac")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPac"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortou AND RECCOUNT("CrSigCdPac") > 0
                SELECT CrSigCdPac
                GO TOP
                THIS.this_cTitOpcS  = IIF(!EMPTY(TitOpcs), ALLTRIM(TitOpcs), "Sim")
                THIS.this_cTitOpcN  = IIF(!EMPTY(TitOpcN), ALLTRIM(TitOpcN), "N" + CHR(227) + "o")
                THIS.this_cTitOpcA  = IIF(!EMPTY(TitOpcA), ALLTRIM(TitOpcA), "Ambos")
                THIS.this_nResVDets = IIF(NVL(ResvDets, 0) = 0, 1, NVL(ResvDets, 1))
            ENDIF

            *-- 3. SigCdEmp - empresas (para lookup descricao e cabecalho)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT cemps, razas FROM SigCdEmp", "CrSigCdEmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigCdEmp") > 0
                SELECT CrSigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ENDIF

            *-- 4. SigCdMoe - moedas (para lookup moeda padrao)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigCdMoe") > 0
                SELECT CrSigCdMoe
                INDEX ON cmoes TAG cmoes
                GO TOP
            ENDIF

            *-- 5. SigCdCot - cotacoes de cambio (para conversao de moedas)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigCdCot") > 0
                SELECT CrSigCdCot
                INDEX ON cmoes + DTOS(datas) TAG cmoedata
                GO TOP
            ENDIF

            *-- 6. SigCdOpe - operacoes (campos especificos do legado)
            IF !loc_lAbortou
                loc_lcQuery = [SELECT dopes,ordes,vendas,dfpags,opcrs,nopcrs,deacrs,vars,caixas,copers,cmoes,] + ;
                              [relfechas,relfechgrs,tipoops,ccomis,comcargs,Calcfecs,Abrevs FROM SigCdOpe]
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigCdOpe")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdOpe"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigCdOpe") > 0
                SELECT CrSigCdOpe
                INDEX ON dopes TAG Dopes
                INDEX ON ordes TAG Ordes
                GO TOP
            ENDIF

            *-- 7. SigOpFp - formas de pagamento
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigOpFp", "CrSigOpFp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigOpFp"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigOpFp") > 0
                SELECT CrSigOpFp
                INDEX ON fpags TAG FPags
                GO TOP
            ENDIF

            *-- 8. SigCdmp - impressoras matriciais (ntpimpres <> 2)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdmp WHERE ntpimpres <> 2", "CrSigCdmp")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdmp"
                    loc_lAbortou = .T.
                ENDIF
            ENDIF
            IF !loc_lAbortou AND RECCOUNT("CrSigCdmp") > 0
                SELECT CrSigCdmp
                INDEX ON impres TAG Impres
                GO TOP
            ENDIF

            *-- 9. SigCdTom -> popula cs_SigCdTom (tipos de movimento com marca=1)
            IF !loc_lAbortou
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos, Descrs FROM SigCdTom", "crSigCdTomTemp")
                IF loc_nResult > 0 AND RECCOUNT("crSigCdTomTemp") > 0
                    SELECT crSigCdTomTemp
                    SCAN
                        INSERT INTO cs_SigCdTom (Marca, Codigos, Descri) ;
                            VALUES (1, crSigCdTomTemp.Codigos, ;
                                    STR(crSigCdTomTemp.Codigos, 2) + "-" + ;
                                    ALLTRIM(crSigCdTomTemp.Descrs))
                    ENDSCAN
                    USE IN crSigCdTomTemp
                    SELECT cs_SigCdTom
                    GO TOP
                ENDIF
            ENDIF

            *-- Define valores iniciais dos filtros
            IF !loc_lAbortou
                THIS.this_dDtInicial   = DATE()
                THIS.this_dDtFinal     = DATE()
                THIS.this_cCdEmpresa   = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                THIS.this_cDsEmpresa   = ""
                THIS.this_cCdMoeda     = THIS.this_cMoedaPs
                THIS.this_cDsMoeda     = ""
                IF !EMPTY(THIS.this_cCdMoeda) AND USED("CrSigCdMoe")
                    SELECT CrSigCdMoe
                    IF SEEK(THIS.this_cCdMoeda, "CrSigCdMoe", "cmoes")
                        THIS.this_cDsMoeda = ALLTRIM(dmoes)
                    ENDIF
                ENDIF
                THIS.this_cUsuario     = ALLTRIM(gc_4c_UsuarioLogado)
                THIS.this_cOperador    = ""
                THIS.this_lSegunda     = .F.
                THIS.this_nOptcol      = 1
                THIS.this_nMaxCols     = 40
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Init")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia carregados no Init
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(11), loc_n
        loc_aCursores(1)  = "CrSigCdPam"
        loc_aCursores(2)  = "CrSigCdPac"
        loc_aCursores(3)  = "CrSigCdEmp"
        loc_aCursores(4)  = "CrSigCdMoe"
        loc_aCursores(5)  = "CrSigCdCot"
        loc_aCursores(6)  = "CrSigCdOpe"
        loc_aCursores(7)  = "CrSigOpFp"
        loc_aCursores(8)  = "CrSigCdmp"
        loc_aCursores(9)  = "cs_SigCdTom"
        loc_aCursores(10) = "crSigCdTomTemp"
        loc_aCursores(11) = "csRelatorio"
        FOR loc_n = 1 TO 11
            IF USED(loc_aCursores(loc_n))
                USE IN (loc_aCursores(loc_n))
            ENDIF
        ENDFOR
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do relatorio para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
            DTOC(THIS.this_dDtInicial) + "|" + ;
            DTOC(THIS.this_dDtFinal) + "|" + ;
            ALLTRIM(THIS.this_cCdMoeda) + "|" + ;
            ALLTRIM(THIS.this_cUsuario)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra o processamento do relatorio
    * Equivalente a 'processamento' do formulario legado.
    * Cria dbTmpRel/dbTmpRel2, chama Processar() uma ou duas vezes,
    * une resultados em dbRelatorio. Modos: Agrupado (2 passagens) ou
    * Individual (dia a dia, 2 passagens por dia).
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_ldDtIni, loc_ldDtFim, loc_lnOpcCol, loc_lnOpcTipo
        LOCAL loc_ldDtProc, loc_llFirst, loc_lnDias
        loc_lSucesso = .F.
        TRY
            loc_ldDtIni   = THIS.this_dDtInicial
            loc_ldDtFim   = THIS.this_dDtFinal
            loc_lnOpcCol  = THIS.this_nOptcol
            loc_lnOpcTipo = THIS.this_nOpcTipo

            THIS.this_nMaxCols = IIF(loc_lnOpcCol = 1, 40, 254)

            IF USED("dbTmpRel")
                USE IN dbTmpRel
            ENDIF
            IF USED("dbTmpRel2")
                USE IN dbTmpRel2
            ENDIF
            IF USED("dbRelatorio")
                USE IN dbRelatorio
            ENDIF

            CREATE CURSOR dbTmpRel  (detalhe c(THIS.this_nMaxCols) NULL, tipo n(1), usuars c(10), datas d)
            INDEX ON usuars TAG Usuars

            CREATE CURSOR dbTmpRel2 (detalhe c(THIS.this_nMaxCols) NULL, tipo n(1), usuars c(10), datas d)
            INDEX ON usuars TAG Usuars

            IF loc_lnOpcCol = 1 OR loc_lnOpcTipo = 1
                *-- Agrupado: 2 passagens (relfechas=1 e relfechas=3)
                THIS.this_lSegunda = .F.
                IF !THIS.Processar(loc_ldDtIni, loc_ldDtFim)
                    ERROR 2099
                ENDIF
                THIS.this_lSegunda = .T.
                IF !THIS.Processar(loc_ldDtIni, loc_ldDtFim)
                    ERROR 2099
                ENDIF
                SELECT * FROM dbTmpRel ;
                    UNION ALL ;
                    SELECT * FROM dbTmpRel2 ;
                    INTO CURSOR dbRelatorio READWRITE
            ELSE
                *-- Individual: processa dia a dia
                loc_llFirst   = .T.
                loc_lnDias    = (loc_ldDtFim - loc_ldDtIni + 1)
                loc_ldDtProc  = loc_ldDtIni
                WAIT WINDOW "Processando datas... (" + DTOC(loc_ldDtProc) + ")" NOWAIT
                DO WHILE loc_ldDtProc <= loc_ldDtFim
                    THIS.this_lSegunda = .F.
                    IF !THIS.Processar(loc_ldDtProc, loc_ldDtProc)
                        ERROR 2099
                    ENDIF
                    THIS.this_lSegunda = .T.
                    IF !THIS.Processar(loc_ldDtProc, loc_ldDtProc)
                        ERROR 2099
                    ENDIF
                    IF loc_llFirst
                        SELECT * FROM dbTmpRel ;
                            UNION ALL ;
                            SELECT * FROM dbTmpRel2 ;
                            INTO CURSOR dbRelatorio READWRITE
                        loc_llFirst = .F.
                    ELSE
                        SELECT dbTmpRel
                        GO TOP
                        SCAN
                            SCATTER MEMO MEMVAR
                            INSERT INTO dbRelatorio FROM MEMVAR
                            SELECT dbTmpRel
                        ENDSCAN
                        SELECT dbTmpRel2
                        GO TOP
                        SCAN
                            SCATTER MEMO MEMVAR
                            INSERT INTO dbRelatorio FROM MEMVAR
                            SELECT dbTmpRel2
                        ENDSCAN
                    ENDIF
                    loc_ldDtProc = loc_ldDtProc + 1
                    WAIT WINDOW "Processando datas... (" + DTOC(loc_ldDtProc) + ")" NOWAIT
                ENDDO
                WAIT CLEAR
            ENDIF

            *-- Limpar cursores temporarios de processamento
            THIS.LimparCursoresTemp()

            SELECT dbRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            WAIT CLEAR
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresTemp - Fecha cursores temporarios de processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCursoresTemp()
        LOCAL loc_aTemp(30), loc_n
        loc_aTemp(1)  = "TmpUsuarios"
        loc_aTemp(2)  = "dbRelIni"
        loc_aTemp(3)  = "CsCartaos"
        loc_aTemp(4)  = "Parcela"
        loc_aTemp(5)  = "LancFor"
        loc_aTemp(6)  = "ComiComp"
        loc_aTemp(7)  = "Comissao"
        loc_aTemp(8)  = "Vendas"
        loc_aTemp(9)  = "VdaEesti"
        loc_aTemp(10) = "EntCai"
        loc_aTemp(11) = "EntEesti"
        loc_aTemp(12) = "SaiCai"
        loc_aTemp(13) = "SaiEesti"
        loc_aTemp(14) = "DevCai"
        loc_aTemp(15) = "DevEesti"
        loc_aTemp(16) = "dbCabecalho"
        loc_aTemp(17) = "TmpMccr"
        loc_aTemp(18) = "CsEest"
        loc_aTemp(19) = "CsEesti"
        loc_aTemp(20) = "TmpPar"
        loc_aTemp(21) = "TmpCli"
        loc_aTemp(22) = "TmpCheb"
        loc_aTemp(23) = "TmpChe"
        loc_aTemp(24) = "TmpChea"
        loc_aTemp(25) = "TmpOper"
        loc_aTemp(26) = "TmpCar"
        loc_aTemp(27) = "CsResLan"
        loc_aTemp(28) = "CsItem"
        loc_aTemp(29) = "CsCab"
        loc_aTemp(30) = "ImpLanFor"
        FOR loc_n = 1 TO 30
            IF USED(loc_aTemp(loc_n))
                USE IN (loc_aTemp(loc_n))
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa o processamento principal dos dados do fechamento
    * Equivalente ao procedimento 'processa' do formulario legado.
    * Preenche dbTmpRel ou dbTmpRel2 conforme this_lSegunda.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Processar(par_dDtInicial, par_dDtFinal)
        LOCAL loc_lcArq, loc_lcCdMoeda, loc_lcDsMoeda, loc_lcUsuario, loc_lcOperador, loc_lcEmpresa
        LOCAL loc_lnNrOpcao, loc_lnOptQuebra, loc_lnOptCol, loc_lnOptMov, loc_lnImpNomCli
        LOCAL loc_lnResLanca, loc_lnResForma, loc_lnResCheque, loc_lnResCartao, loc_lnResVende
        LOCAL loc_lnResConta, loc_lnResLanFor, loc_lnResQtdes, loc_lnResVDets
        LOCAL loc_lnResult, loc_lcSql, loc_ldDtImp
        LOCAL loc_lnCotE, loc_lnCotC, loc_lnCotF, loc_lnValCal, loc_lnValPar, loc_lnValParAv
        LOCAL loc_lFator, loc_lnComFPag, loc_lnComiss, loc_lnDias, loc_JurMes, loc_TxMes
        LOCAL loc_lnTxDia, loc_lnDesconto, loc_lnPorc
        LOCAL loc_lcTip, loc_lcNmOperacao, loc_llTipoSel, loc_lcUserDopes
        LOCAL loc_lcChkE, loc_lcChkEa, loc_lcChkEb, loc_lxCli, loc_lcObs, loc_lcDet
        LOCAL loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcDtPeriodo, loc_lcCbUsu
        LOCAL loc_lSaldoAnt, loc_lnCtMccr, loc_lcChave, loc_lcOperacao
        LOCAL loc_lnTotgeral, loc_lnQtdGeral, loc_lnTotAV, loc_lnTotPre
        LOCAL loc_lnTotPar, loc_lnTotDev, loc_lnTotTip1, loc_lnTotTip2
        LOCAL loc_lnTotBco, loc_lnTotCom, loc_lnTTotBco, loc_lnTTotCom, loc_lnTotCard
        LOCAL loc_lcCabecalho, loc_lcDetalhe, loc_lcEdn, loc_lcQuery, loc_lTipAnt
        LOCAL loc_dSldAnt, loc_lnOptTipo
        PRIVATE lcDtInicial, lcDtFinal, lcDtSldAntIni, lcDtSldAntFin

        loc_lcArq       = IIF(THIS.this_lSegunda, "dbTmpRel2", "dbTmpRel")
        loc_lcCdMoeda   = THIS.this_cCdMoeda
        loc_lcDsMoeda   = THIS.this_cDsMoeda
        loc_lcUsuario   = THIS.this_cUsuario
        loc_lcOperador  = THIS.this_cOperador
        loc_lcEmpresa   = THIS.this_cCdEmpresa
        loc_lnNrOpcao   = THIS.this_nOptNrOpcao
        loc_lnOptQuebra = THIS.this_nOptQuebra
        loc_lnOptCol    = THIS.this_nOptcol
        loc_lnOptMov    = THIS.this_nOptMov
        loc_lnOptTipo   = THIS.this_nOpcTipo
        loc_lnImpNomCli = THIS.this_nOptImpNomCli
        loc_lnResLanca  = THIS.this_nResLanca
        loc_lnResForma  = THIS.this_nResForma
        loc_lnResCheque = THIS.this_nResCheque
        loc_lnResCartao = THIS.this_nResCartao
        loc_lnResVende  = THIS.this_nResVende
        loc_lnResConta  = THIS.this_nResConta
        loc_lnResLanFor = THIS.this_nResLanFor
        loc_lnResQtdes  = THIS.this_nResQtdes
        loc_lnResVDets  = THIS.this_nResVDets

        *-- Datas para queries parametrizadas (?lcDtInicial, ?lcDtFinal)
        loc_dSldAnt    = par_dDtInicial - 1
        lcDtInicial    = DATETIME(YEAR(par_dDtInicial), MONTH(par_dDtInicial), DAY(par_dDtInicial), 0, 0, 0)
        lcDtFinal      = DATETIME(YEAR(par_dDtFinal),   MONTH(par_dDtFinal),   DAY(par_dDtFinal),  23, 59, 59)
        lcDtSldAntIni  = DATETIME(YEAR(loc_dSldAnt),    MONTH(loc_dSldAnt),    DAY(loc_dSldAnt),   0, 0, 0)
        lcDtSldAntFin  = DATETIME(YEAR(loc_dSldAnt),    MONTH(loc_dSldAnt),    DAY(loc_dSldAnt),   23, 59, 59)
        loc_ldDtImp    = IIF(par_dDtInicial = par_dDtFinal, par_dDtInicial, { })

        *-- Filtros de empresa para SQL
        loc_lcChkE  = IIF(EMPTY(loc_lcEmpresa), [], [ AND emps = '] + loc_lcEmpresa + ['])
        loc_lcChkEa = IIF(EMPTY(loc_lcEmpresa), [], [ AND a.emps = '] + loc_lcEmpresa + ['])
        loc_lcChkEb = IIF(EMPTY(loc_lcEmpresa), [], [ AND b.emps = '] + loc_lcEmpresa + ['])

        *-- Cabecalho 80 colunas
        IF loc_lnOptCol = 2
            loc_lcNmEmpresa = IIF(!EMPTY(loc_lcEmpresa), ;
                loc_lcEmpresa + " - " + ;
                IIF(SEEK(loc_lcEmpresa, "CrSigCdEmp", "Cemps"), ALLTRIM(CrSigCdEmp.razas), ""), ;
                "TODAS AS EMPRESAS")
            loc_lcNmTitulo  = "Fechamento em " + PROPER(ALLTRIM(loc_lcDsMoeda))
            loc_lcDtPeriodo = "Per" + CHR(237) + "odo: " + DTOC(par_dDtInicial) + " a " + DTOC(par_dDtFinal)
            loc_lcCbUsu = IIF(!EMPTY(loc_lcUsuario), "Usu" + CHR(225) + "rio : " + ALLTRIM(loc_lcUsuario), "") + ;
                          IIF(!EMPTY(loc_lcOperador), ;
                              IIF(EMPTY(loc_lcUsuario), "", " - ") + "Operador : " + ALLTRIM(loc_lcOperador), "")
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (nomeempresa c(80), titulo c(80), periodo c(80), usuario c(80), tipo n(1))
            INSERT INTO dbCabecalho (nomeempresa, titulo, periodo, usuario, tipo) ;
                VALUES (loc_lcNmEmpresa, loc_lcNmTitulo, loc_lcDtPeriodo, loc_lcCbUsu, loc_lnOptTipo)
        ENDIF

        *-- Cursores de acumulacao
        CREATE CURSOR TmpUsuarios (usuarios c(10), totvens n(16,2), totents n(16,2), totsais n(16,2))
        INDEX ON usuarios TAG Usuarios

        CREATE CURSOR dbRelIni (Emps c(3), dopes c(20), numes n(6), datas d, notas c(6), ;
                                totas n(10,2), conta c(10), obses memo(4) NULL, vends c(10), ;
                                usuars c(10), det c(30), Abrevs c(3), nPedClis n(11))
        INDEX ON usuars TAG Usuars
        INDEX ON Usuars + Vends TAG Vendedor
        INDEX ON usuars + dopes + DTOS(datas) + STR(numes, 6) TAG UsDop

        CREATE CURSOR CsCartaos (cusuarios c(10), cdcarts c(12), ntotecarts n(14,2), ;
                                  ntotscarts n(14,2), cnIdTefs c(10))
        INDEX ON cusuarios + cdcarts + cnIdTefs TAG IdCart

        *-- Taxa mensal de juros (JurMes) para calculo de avista
        loc_JurMes = "JM "
        loc_TxMes  = THIS.BuscarCambio(loc_JurMes, par_dDtFinal)

        WAIT WINDOW "Aguarde! Selecionando Parcelas..." NOWAIT

        *-- Cursor Parcela: inicializa estrutura de SigMvPar + campos extras
        loc_lcSql = "Select a.*" + ;
                    ",99999999999999.99 As valoavs" + ;
                    ",999999999.99 As devols" + ;
                    ",'      ' As tipo" + ;
                    ",999999999.99 As origs" + ;
                    ",999999999.99 As dorigs" + ;
                    ",'          ' As usuars" + ;
                    " From SigMvPar a Where 0 = 1"
        loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "Parcela")
        IF loc_lnResult < 1
            THIS.this_cMensagemErro = "Falha ao inicializar Parcela (SigMvPar)"
            MsgErro(THIS.this_cMensagemErro, "Processar")
            RETURN .F.
        ENDIF
        SELECT Parcela
        REPLACE ALL valoavs WITH 0, devols WITH 0, origs WITH 0, dorigs WITH 0
        INDEX ON usuars + tipo + fpags TAG Tipo
        INDEX ON usuars + fpags        TAG FPags
        GO TOP

        CREATE CURSOR LancFor (dopes c(20), forma c(12), valos n(16,2), devols n(12,2), ;
                                usuars c(10), Origs n(16,2))
        INDEX ON usuars + dopes + Forma TAG DopPag

        CREATE CURSOR ComiComp (vends c(10), comis n(16,2), valos n(16,2), usuars c(10))
        INDEX ON usuars + vends TAG Vends

        CREATE CURSOR Comissao (vends c(10), comis n(16,2), valos n(16,2), usuars c(10), ;
                                 TotOpE n(6), TotOpS n(6))
        INDEX ON vends TAG Vends

        WAIT WINDOW "Aguarde! Verificando Saldo Anterior..." NOWAIT

        *-- Saldo Anterior (dia anterior ao inicio)
        IF USED("TmpMccr")
            USE IN TmpMccr
        ENDIF
        loc_lcSql = "Select Top 1 Emps, Datas, Saldos, CidChaves From SigMvCcr " + ;
                    "Where Grupos = '" + ALLTRIM(NVL(CrSigCdPam.Grupos, "")) + "'" + ;
                    " And Contas = '" + ALLTRIM(NVL(CrSigCdPam.Contas, "")) + "'" + ;
                    " And Datas Between ?lcDtSldAntIni And ?lcDtSldAntFin " + ;
                    "Order By CidChaves Desc"
        loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "TmpMccr")
        IF loc_lnResult < 1
            THIS.this_cMensagemErro = "Falha ao consultar saldo anterior (SigMvCcr)"
            MsgErro(THIS.this_cMensagemErro, "Processar")
            RETURN .F.
        ENDIF
        SELECT TmpMccr
        GO TOP
        IF !EOF()
            loc_lSaldoAnt = TmpMccr.saldos
        ELSE
            loc_lSaldoAnt = 0
        ENDIF

        CREATE CURSOR Vendas (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), relfechgrs c(2))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG iTipoOps

        CREATE CURSOR VdaEesti (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), ;
                                 relfechgrs c(2), qtds n(12,3))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG iTipoOps

        loc_lcNmOperacao = ""

        *-- Verifica se ha tipos de movimento selecionados em cs_SigCdTom
        loc_llTipoSel = .T.
        SELECT cs_SigCdTom
        LOCATE FOR Marca = 1
        IF EOF()
            loc_llTipoSel = .F.
        ENDIF

        WAIT WINDOW "Aguarde! Verificando Vendas..." NOWAIT

        *==========================================================
        *-- LOOP DE VENDAS: caixas/copers=1/vendas=1/Calcfecs<>1
        *==========================================================
        SELECT CrSigCdOpe
        SET ORDER TO Ordes
        GO TOP
        SCAN FOR CrSigCdOpe.vendas = 1 AND CrSigCdOpe.Calcfecs <> 1 AND ;
                 CrSigCdOpe.relfechas = IIF(THIS.this_lSegunda, 3, 1)

            WAIT WINDOW "Aguarde! Verificando Vendas...(1)" NOWAIT

            SEEK CrSigCdOpe.TipoOps ORDER TAG Codigos IN cs_SigCdTom
            IF loc_llTipoSel AND cs_SigCdTom.Marca = 0
                LOOP
            ENDIF

            IF USED("CsEestAnt")
                USE IN CsEestAnt
            ENDIF
            IF USED("CsEest")
                USE IN CsEest
            ENDIF

            WAIT WINDOW "Aguarde! Verificando Vendas...(2)" NOWAIT

            loc_lFator = IIF(CrSigCdOpe.caixas = 1 AND CrSigCdOpe.copers = 1, 1, -1)

            loc_lcSql = "Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos," + ;
                        "notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab " + ;
                        "Where datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                        "dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkE + ;
                        IIF(loc_lnNrOpcao = 1, " And notas <> '      '", ;
                            IIF(loc_lnNrOpcao = 2, " And notas = '      '", "")) + ;
                        IIF(!EMPTY(loc_lcUsuario), " And usuars = '" + loc_lcUsuario + "'", "") + ;
                        IIF(!EMPTY(loc_lcOperador), " And Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                        " Order By emps,dopes,datas"
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEest")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar SigMvCab (Vendas)"
                MsgErro(THIS.this_cMensagemErro, "Processar")
                RETURN .F.
            ENDIF

            SELECT CsEest
            GO TOP
            SCAN
                IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                    m.usuars = CsEest.usuars
                ELSE
                    m.usuars = SPACE(10)
                ENDIF

                SELECT TmpUsuarios
                SET ORDER TO Usuarios
                SEEK m.usuars
                IF EOF()
                    INSERT INTO TmpUsuarios (usuarios) VALUES (m.usuars)
                ENDIF

                loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEest.datas)
                loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEest.datas)

                SELECT Vendas
                SET ORDER TO Dopes
                IF !SEEK(m.usuars + CrSigCdOpe.dopes)
                    APPEND BLANK
                    REPLACE relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                            tipoops    WITH CrSigCdOpe.tipoops, ;
                            dopes      WITH CrSigCdOpe.dopes, ;
                            usuars     WITH m.usuars IN Vendas
                ENDIF
                loc_lnValCal = ROUND(CsEest.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2) * loc_lFator
                REPLACE Vendas.totas WITH Vendas.totas + loc_lnValCal

                *-- Resumo por Forma de Pagamento
                WAIT WINDOW "Aguarde! Verificando Vendas...(3)" NOWAIT
                IF USED("TmpPar")
                    USE IN TmpPar
                ENDIF
                loc_lcSql = "Select a.cotfpgs,a.Dopes,a.Datas,a.Vencs,a.Fpags,a.Moefpgs,a.Valos," + ;
                            "b.Acumulas,c.ChkPagos,a.cnIdTefs " + ;
                            "From SigMvPar a, SigOpFp b, SigMvCab c " + ;
                            "Where a.EmpDopNums = '" + CsEest.emps + CsEest.dopes + STR(CsEest.numes, 6) + "'" + ;
                            " And a.Fpags = b.Fpags And a.EmpDopNums = c.EmpDopNums"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "TmpPar")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvPar (Vendas)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF

                SELECT TmpPar
                GO TOP
                SCAN
                    IF TmpPar.Acumulas = 1 AND ChkPagos
                        LOOP
                    ENDIF
                    SELECT Parcela
                    SET ORDER TO FPags
                    SEEK m.usuars + TmpPar.fpags
                    IF EOF()
                        APPEND BLANK
                        REPLACE Parcela.fpags  WITH TmpPar.fpags, ;
                                Parcela.usuars WITH m.usuars
                    ENDIF

                    loc_lnCotF = IIF(TmpPar.cotfpgs > 0, TmpPar.cotfpgs, ;
                                     THIS.CarregarCambio(TmpPar.moefpgs, DATE()))
                    loc_lnValPar = ROUND(TmpPar.valos * loc_lnCotF / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    SEEK TmpPar.dopes ORDER TAG Dopes IN CrSigCdOpe
                    SEEK TmpPar.fpags ORDER TAG FPags IN CrSigOpFp
                    loc_lnValPar = loc_lnValPar * loc_lFator * IIF(CrSigOpFp.trocos = 1, -1, 1)

                    REPLACE Parcela.valos  WITH Parcela.valos  + loc_lnValPar, ;
                            Parcela.origs  WITH Parcela.origs  + (TmpPar.valos * loc_lFator * IIF(CrSigOpFp.trocos = 1, -1, 1))

                    loc_lnValParAv = loc_lnValPar
                    loc_lnDias = TTOD(TmpPar.datas) - TTOD(TmpPar.vencs)
                    IF loc_lnDias < 0
                        loc_lnTxDia   = ((1 + loc_TxMes / 100) ^ (1 / 30) - 1) * 100
                        loc_lnTxDia   = INT(loc_lnTxDia * 100 + 0.5) / 100
                        loc_lnDesconto = (1 + loc_lnTxDia / 100) ^ (-1 * loc_lnDias)
                        loc_lnPorc     = (1 - 1 / loc_lnDesconto) * 100
                        loc_lnPorc     = INT(loc_lnPorc * 100 + 0.5) / 100
                        loc_lnValParAv = (loc_lnValPar * (1 - (loc_lnPorc / 100)))
                        loc_lnValParAv = INT(loc_lnValParAv * 100 + 0.5) / 100
                    ENDIF

                    SELECT CrSigOpFp
                    IF !EMPTY(CrSigOpFp.descs)
                        loc_lnValParAv = loc_lnValParAv - ROUND(loc_lnValParAv * CrSigOpFp.descs / 100, 2)
                    ENDIF

                    SELECT Parcela
                    loc_lcTip = THIS.VerTpPag(CrSigOpFp.Infos)
                    REPLACE valoavs WITH Parcela.valoavs + loc_lnValParAv, tipo WITH loc_lcTip IN Parcela

                    IF CrSigCdOpe.ccomis = 1
                        WAIT WINDOW "Aguarde! Verificando Vendas...(4)" NOWAIT
                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lnResult = SQLEXEC(gnConnHandle, ;
                            "Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a " + ;
                            "Left Join SigCdCrg b On b.ccargs = a.ccargs " + ;
                            "Where a.iclis = '" + ALLTRIM(CsEest.vends) + "'", "TmpCli")
                        IF loc_lnResult < 1
                            THIS.this_cMensagemErro = "Falha ao consultar SigCdCli (Vendas)"
                            MsgErro(THIS.this_cMensagemErro, "Processar")
                            RETURN .F.
                        ENDIF
                        loc_lnComFPag = 0
                        SELECT TmpCli
                        GO TOP
                        IF !EOF()
                            IF !EMPTY(TmpCli.comis)
                                loc_lnComFPag = TmpCli.comis
                            ELSE
                                loc_lnComFPag = CrSigOpFp.fpcomiss
                            ENDIF
                            IF CrSigCdOpe.comcargs = 1
                                loc_lnComFPag = NVL(TmpCli.cargcom, 0)
                            ENDIF
                        ENDIF
                        SELECT Comissao
                        SET ORDER TO vends
                        SEEK CsEest.vends
                        IF EOF()
                            APPEND BLANK
                            REPLACE Comissao.vends WITH CsEest.vends
                        ENDIF
                        loc_lnValPar = TmpPar.Valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                        loc_lnComiss = ROUND(loc_lnValPar / 100 * loc_lnComFPag, 2)
                        REPLACE Comissao.valos WITH Comissao.valos + ROUND(loc_lnValPar * loc_lnCotF / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                        REPLACE Comissao.comis WITH Comissao.comis + loc_lnComiss
                    ENDIF

                    IF CrSigOpFp.infos = "T"
                        IF (THIS.this_nCrtDetalhado = 1)
                            IF !SEEK(m.usuars + CrSigOpFp.dcarts + TmpPar.cnIdTefs, "CsCartaos", "IdCart")
                                INSERT INTO CsCartaos (cusuarios, cdcarts, cnIdTefs) ;
                                    VALUES (m.usuars, CrSigOpFp.dcarts, TmpPar.cnIdTefs)
                            ENDIF
                        ELSE
                            IF !SEEK(m.usuars + CrSigOpFp.dcarts, "CsCartaos", "IdCart")
                                INSERT INTO CsCartaos (cusuarios, cdcarts) ;
                                    VALUES (m.usuars, CrSigOpFp.dcarts)
                            ENDIF
                        ENDIF
                        SELECT CsCartaos
                        IF CrSigCdOpe.copers = 1
                            REPLACE CsCartaos.ntotecarts WITH CsCartaos.ntotecarts + ABS(loc_lnValPar)
                        ELSE
                            REPLACE CsCartaos.ntotscarts WITH CsCartaos.ntotscarts + ABS(loc_lnValPar)
                        ENDIF
                    ENDIF

                    IF CrSigOpFp.infos = "C"
                        IF TmpPar.vencs > lcDtFinal
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " PRE", 12)
                        ELSE
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " AV", 12)
                        ENDIF
                    ELSE
                        loc_lcTip = CrSigOpFp.formas
                    ENDIF
                    IF !SEEK(m.usuars + TmpPar.dopes + loc_lcTip, "LancFor", "DopPag")
                        INSERT INTO LancFor (dopes, forma, usuars) VALUES (TmpPar.dopes, loc_lcTip, m.usuars)
                    ENDIF
                    REPLACE LancFor.valos  WITH LancFor.valos  + loc_lnValPar, ;
                            LancFor.Origs  WITH LancFor.Origs  + (TmpPar.valos * loc_lFator * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN LancFor
                    SELECT TmpPar
                ENDSCAN

                IF INLIST(loc_lnOptCol, 1, 2)
                    SELECT CsEest
                    loc_lcNmOperacao = CrSigCdOpe.dopes
                    loc_lxCli = IIF(CrSigCdOpe.copers = 1, CsEest.contads, CsEest.contaos)
                    IF USED("crTmpCli")
                        USE IN crTmpCli
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT TOP 1 rClis FROM SigCdCli WHERE iClis = ?loc_lxCli", "crTmpCli")
                    DO CASE
                        CASE (loc_lnImpNomCli = 1)
                            loc_lcObs = IIF(USED("crTmpCli") AND RECCOUNT("crTmpCli") > 0, ;
                                            LEFT(crTmpCli.rClis, 25), SPACE(25))
                        CASE (loc_lnImpNomCli = 2)
                            loc_lcObs = PADR(LEFT(MLINE(CsEest.obses, 1), 25), 25)
                        CASE (loc_lnImpNomCli = 3)
                            IF CrSigCdOpe.copers = 1
                                loc_lcObs = IIF(USED("crTmpCli") AND RECCOUNT("crTmpCli") > 0, ;
                                                LEFT(crTmpCli.rClis, 25), SPACE(25))
                            ELSE
                                loc_lcObs = PADR(LEFT(MLINE(CsEest.obses, 1), 25), 25)
                            ENDIF
                        OTHERWISE
                            loc_lcObs = SPACE(25)
                    ENDCASE

                    loc_lcDet = ""
                    DO CASE
                        CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.dfpags = 1
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.desc2s, "999.99") + " "
                        CASE CrSigCdOpe.opcrs = 1
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.valdevs, "999,999,999.99") + " "
                    ENDCASE
                    DO CASE
                        CASE INLIST(CrSigCdOpe.vars, 1, 6)
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.vars, "999.99") + " "
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.valvars, "999,999.99")
                        CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.deacrs = 1
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.descs, "999.99") + " "
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.valdescs, "999,999.99") + " "
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.acres, "999.99") + " "
                            loc_lcDet = loc_lcDet + TRANSFORM(CsEest.valacres, "999.99")
                    ENDCASE

                    loc_lnValCal = ROUND(CsEest.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2) * loc_lFator
                    INSERT INTO dbRelIni (emps, numes, dopes, datas, notas, totas, conta, obses, ;
                                          vends, usuars, det, Abrevs, nPedClis) ;
                        VALUES (CsEest.Emps, CsEest.numes, CsEest.dopes, CsEest.datas, CsEest.notas, ;
                                loc_lnValCal, loc_lxCli, loc_lcObs, CsEest.vends, m.usuars, ;
                                loc_lcDet, CrSigCdOpe.Abrevs, CsEest.nPedClis)
                    IF USED("crTmpCli")
                        USE IN crTmpCli
                    ENDIF
                ENDIF

                SELECT Comissao
                SET ORDER TO vends
                SEEK CsEest.vends
                IF EOF()
                    APPEND BLANK
                    REPLACE Comissao.vends WITH CsEest.vends
                ENDIF
                REPLACE TotOpS WITH TotOpS + 1

                SELECT CsEest
            ENDSCAN

            *-- Quantidades (80 col)
            IF loc_lnResQtdes = 1 AND loc_lnOptCol <> 1
                WAIT WINDOW "Aguarde! Verificando Vendas...(5)" NOWAIT
                IF USED("CsEesti")
                    USE IN CsEesti
                ENDIF
                loc_lcSql = "Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars " + ;
                            "From SigMvCab a, SigMvItn b " + ;
                            "Where a.datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                            "a.Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkEa + ;
                            IIF(loc_lnNrOpcao = 1, " And a.notas <> '      '", ;
                                IIF(loc_lnNrOpcao = 2, " And a.notas = '      '", "")) + ;
                            IIF(!EMPTY(loc_lcUsuario), " And a.usuars = '" + loc_lcUsuario + "'", "") + ;
                            IIF(!EMPTY(loc_lcOperador), " And a.Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                            " And a.empdopnums = b.empdopnums" + ;
                            " Order By a.emps,a.dopes,a.datas"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEesti")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvItn (Vendas/Qtde)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT CsEesti
                GO TOP
                SCAN
                    IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                        m.usuars = CsEesti.usuars
                    ELSE
                        m.usuars = SPACE(10)
                    ENDIF
                    SELECT TmpUsuarios
                    SET ORDER TO Usuarios
                    SEEK m.usuars
                    IF EOF()
                        INSERT INTO TmpUsuarios (usuarios) VALUES (m.usuars)
                    ENDIF
                    loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEesti.datas)
                    loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEesti.datas)
                    SELECT VdaEesti
                    SET ORDER TO Dopes
                    IF !SEEK(m.usuars + CrSigCdOpe.dopes)
                        APPEND BLANK
                        REPLACE relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                                tipoops    WITH CrSigCdOpe.tipoops, ;
                                dopes      WITH CrSigCdOpe.dopes, ;
                                usuars     WITH m.usuars IN VdaEesti
                    ENDIF
                    loc_lnValCal = ROUND(CsEesti.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2) * loc_lFator
                    REPLACE VdaEesti.totas WITH VdaEesti.totas + loc_lnValCal
                    REPLACE VdaEesti.qtds  WITH VdaEesti.qtds  + CsEesti.qtds
                    SELECT CsEesti
                ENDSCAN
            ENDIF

            SELECT CrSigCdOpe
        ENDSCAN

        *==========================================================
        *-- LOOP DE ENTRADAS: caixas=1 / copers=1 / vendas<>1
        *==========================================================
        CREATE CURSOR EntCai (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), relfechgrs c(2))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        CREATE CURSOR EntEesti (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), ;
                                 relfechgrs c(2), qtds n(12,3))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        WAIT WINDOW "Aguarde! Verificando Entradas..." NOWAIT

        SELECT CrSigCdOpe
        SET ORDER TO ordes
        GO TOP
        SCAN FOR CrSigCdOpe.caixas = 1 AND CrSigCdOpe.copers = 1 AND ;
                 CrSigCdOpe.vendas <> 1 AND ;
                 CrSigCdOpe.relfechas = IIF(THIS.this_lSegunda, 3, 1)

            WAIT WINDOW "Aguarde! Verificando Entradas...(1)" NOWAIT
            SEEK CrSigCdOpe.TipoOps ORDER TAG Codigos IN cs_SigCdTom
            IF loc_llTipoSel AND cs_SigCdTom.Marca = 0
                LOOP
            ENDIF

            WAIT WINDOW "Aguarde! Verificando Entradas...(2)" NOWAIT
            IF USED("CsEest")
                USE IN CsEest
            ENDIF
            loc_lcSql = "Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos," + ;
                        "notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab " + ;
                        "Where datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                        "Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkE + ;
                        IIF(loc_lnNrOpcao = 1, " And notas <> '      '", ;
                            IIF(loc_lnNrOpcao = 2, " And notas = '      '", "")) + ;
                        IIF(!EMPTY(loc_lcUsuario), " And usuars = '" + loc_lcUsuario + "'", "") + ;
                        IIF(!EMPTY(loc_lcOperador), " And Operadors = '" + loc_lcOperador + "'", "") + ;
                        " Order By emps,dopes,datas"
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEest")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar SigMvCab (Entradas)"
                MsgErro(THIS.this_cMensagemErro, "Processar")
                RETURN .F.
            ENDIF

            SELECT CsEest
            GO TOP
            SCAN
                IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                    m.usuars = CsEest.usuars
                ELSE
                    m.usuars = SPACE(10)
                ENDIF
                SELECT TmpUsuarios
                SET ORDER TO Usuarios
                SEEK m.usuars
                IF EOF()
                    INSERT INTO TmpUsuarios (Usuarios) VALUES (m.usuars)
                ENDIF
                loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEest.datas)
                loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEest.datas)
                SELECT EntCai
                SET ORDER TO Dopes
                SEEK m.usuars + CrSigCdOpe.dopes
                IF EOF()
                    APPEND BLANK
                    REPLACE EntCai.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                            EntCai.tipoops    WITH CrSigCdOpe.tipoops, ;
                            EntCai.dopes      WITH CrSigCdOpe.dopes, ;
                            EntCai.usuars     WITH m.usuars
                ENDIF
                loc_lnValCal = ROUND(CsEest.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                REPLACE EntCai.totas WITH EntCai.totas + loc_lnValCal

                WAIT WINDOW "Aguarde! Verificando Entradas...(3)" NOWAIT
                IF USED("TmpPar")
                    USE IN TmpPar
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos From SigMvPar " + ;
                    "Where empdopnums = '" + CsEest.emps + CsEest.dopes + STR(CsEest.numes, 6) + "'", "TmpPar")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvPar (Entradas)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT TmpPar
                GO TOP
                SCAN
                    SELECT Parcela
                    SET ORDER TO FPags
                    SEEK m.usuars + TmpPar.fpags
                    IF EOF()
                        APPEND BLANK
                        REPLACE Parcela.fpags  WITH TmpPar.fpags, ;
                                Parcela.usuars WITH m.usuars
                    ENDIF
                    loc_lnCotF   = IIF(!EMPTY(TmpPar.cotfpgs), TmpPar.cotfpgs, ;
                                       THIS.CarregarCambio(TmpPar.moefpgs, DATE()))
                    loc_lnValPar = ROUND(TmpPar.valos * loc_lnCotF / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    SEEK TmpPar.dopes ORDER TAG Dopes IN CrSigCdOpe
                    SEEK TmpPar.fpags ORDER TAG FPags IN CrSigOpFp
                    loc_lnValPar = loc_lnValPar * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                    REPLACE Parcela.valos WITH Parcela.valos + loc_lnValPar, ;
                            Parcela.origs WITH Parcela.origs + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1))

                    loc_lnValParAv = loc_lnValPar
                    loc_lnDias = TmpPar.datas - TmpPar.vencs
                    IF loc_lnDias < 0
                        loc_lnTxDia   = ((1 + loc_TxMes / 100) ^ (1 / 30) - 1) * 100
                        loc_lnTxDia   = INT(loc_lnTxDia * 100 + 0.5) / 100
                        loc_lnDesconto = (1 + loc_lnTxDia / 100) ^ (-1 * loc_lnTxDia)
                        loc_lnPorc    = (1 - 1 / loc_lnDesconto) * 100
                        loc_lnPorc    = INT(loc_lnPorc * 100 + 0.5) / 100
                        loc_lnValParAv = (loc_lnValPar * (1 - (loc_lnPorc / 100)))
                        loc_lnValParAv = INT(loc_lnValParAv * 100 + 0.5) / 100
                    ENDIF
                    SELECT CrSigOpFp
                    IF !EMPTY(CrSigOpFp.descs)
                        loc_lnValParAv = loc_lnValParAv - ROUND(loc_lnValParAv * CrSigOpFp.descs / 100, 2)
                    ENDIF
                    SELECT Parcela
                    REPLACE Parcela.valoavs WITH Parcela.valoavs + loc_lnValParAv IN Parcela

                    IF CrSigCdOpe.ccomis = 1
                        WAIT WINDOW "Aguarde! Verificando Entradas..." NOWAIT
                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lnResult = SQLEXEC(gnConnHandle, ;
                            "Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a " + ;
                            "Left Join SigCdCrg b On b.ccargs = a.ccargs " + ;
                            "Where a.grupos = '" + ALLTRIM(CsEest.grvends) + "'" + ;
                            " And a.iclis = '" + ALLTRIM(CsEest.vends) + "'", "TmpCli")
                        IF loc_lnResult < 1
                            THIS.this_cMensagemErro = "Falha ao consultar SigCdCli (Entradas)"
                            MsgErro(THIS.this_cMensagemErro, "Processar")
                            RETURN .F.
                        ENDIF
                        loc_lnComFPag = 0
                        SELECT TmpCli
                        GO TOP
                        IF !EOF()
                            IF !EMPTY(TmpCli.comis)
                                loc_lnComFPag = TmpCli.comis
                            ELSE
                                loc_lnComFPag = CrSigOpFp.fpcomiss
                            ENDIF
                            IF CrSigCdOpe.comcargs = 1
                                loc_lnComFPag = NVL(TmpCli.cargcom, 0)
                            ENDIF
                        ENDIF
                        SELECT Comissao
                        SET ORDER TO vends
                        SEEK CsEest.vends
                        IF EOF()
                            APPEND BLANK
                            REPLACE Comissao.vends WITH CsEest.vends
                        ENDIF
                        loc_lnValPar = TmpPar.Valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                        loc_lnComiss = ROUND(loc_lnValPar / 100 * loc_lnComFPag, 2)
                        REPLACE Comissao.valos WITH Comissao.valos + ROUND(loc_lnValPar * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                        REPLACE Comissao.comis WITH Comissao.comis + loc_lnComiss
                    ENDIF

                    IF CrSigOpFp.infos = "C"
                        IF TmpPar.vencs > lcDtFinal
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " PRE", 12)
                        ELSE
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " AV", 12)
                        ENDIF
                    ELSE
                        loc_lcTip = CrSigOpFp.formas
                    ENDIF
                    IF !SEEK(TmpPar.dopes + loc_lcTip, "LancFor", "DopPag")
                        INSERT INTO LancFor (dopes, forma) VALUES (TmpPar.dopes, loc_lcTip)
                    ENDIF
                    REPLACE LancFor.valos  WITH LancFor.valos  + loc_lnValPar, ;
                            LancFor.Origs  WITH LancFor.Origs  + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN LancFor
                    SELECT TmpPar
                ENDSCAN

                SELECT Comissao
                SET ORDER TO vends
                SEEK CsEest.vends
                IF EOF()
                    APPEND BLANK
                    REPLACE Comissao.vends WITH CsEest.vends
                ENDIF
                REPLACE TotOpS WITH TotOpS + 1

                SELECT CsEest
            ENDSCAN

            IF loc_lnResQtdes = 1 AND loc_lnOptCol <> 1
                WAIT WINDOW "Aguarde! Verificando Entradas...(4)" NOWAIT
                IF USED("CsEesti")
                    USE IN CsEesti
                ENDIF
                loc_lcSql = "Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars " + ;
                            "From SigMvCab a, SigMvItn b " + ;
                            "Where a.datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                            "a.Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkEa + ;
                            IIF(loc_lnNrOpcao = 1, " And a.notas <> '      '", ;
                                IIF(loc_lnNrOpcao = 2, " And a.notas = '      '", "")) + ;
                            IIF(!EMPTY(loc_lcUsuario), " And a.usuars = '" + loc_lcUsuario + "'", "") + ;
                            IIF(!EMPTY(loc_lcOperador), " And a.Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                            " And b.empdopnums = a.empdopnums" + ;
                            " Order By a.emps,a.dopes,a.datas"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEesti")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvItn (Entradas/Qtde)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT CsEesti
                GO TOP
                SCAN
                    IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                        m.usuars = CsEesti.usuars
                    ELSE
                        m.usuars = SPACE(10)
                    ENDIF
                    SELECT TmpUsuarios
                    SET ORDER TO Usuarios
                    SEEK m.usuars
                    IF EOF()
                        INSERT INTO TmpUsuarios (Usuarios) VALUES (m.usuars)
                    ENDIF
                    loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEesti.datas)
                    loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEesti.datas)
                    SELECT EntEesti
                    SET ORDER TO Dopes
                    SEEK m.usuars + CrSigCdOpe.dopes
                    IF EOF()
                        APPEND BLANK
                        REPLACE EntEesti.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                                EntEesti.tipoops    WITH CrSigCdOpe.tipoops, ;
                                EntEesti.dopes      WITH CrSigCdOpe.dopes, ;
                                EntEesti.usuars     WITH m.usuars
                    ENDIF
                    loc_lnValCal = ROUND(CsEesti.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    REPLACE EntEesti.totas WITH EntEesti.totas + loc_lnValCal
                    REPLACE EntEesti.qtds  WITH EntEesti.qtds  + CsEesti.qtds
                ENDSCAN
            ENDIF

            SELECT CrSigCdOpe
        ENDSCAN

        *==========================================================
        *-- LOOP DE SAIDAS: caixas=1 / copers=2 / vendas<>1
        *==========================================================
        CREATE CURSOR SaiCai (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), relfechgrs c(2))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        CREATE CURSOR SaiEesti (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), ;
                                  relfechgrs c(2), qtds n(12,3))
        INDEX ON usuars + dopes TAG Dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das..." NOWAIT

        SELECT CrSigCdOpe
        SET ORDER TO ordes
        GO TOP
        SCAN FOR CrSigCdOpe.caixas = 1 AND CrSigCdOpe.copers = 2 AND ;
                 CrSigCdOpe.vendas <> 1 AND ;
                 CrSigCdOpe.relfechas = IIF(THIS.this_lSegunda, 3, 1)

            WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das...(1)" NOWAIT
            SEEK CrSigCdOpe.TipoOps ORDER TAG Codigos IN cs_SigCdTom
            IF loc_llTipoSel AND cs_SigCdTom.Marca = 0
                LOOP
            ENDIF

            WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das...(2)" NOWAIT
            IF USED("CsEest")
                USE IN CsEest
            ENDIF
            loc_lcSql = "Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos," + ;
                        "notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab " + ;
                        "Where datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                        "Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkE + ;
                        IIF(loc_lnNrOpcao = 1, " And notas <> '      '", ;
                            IIF(loc_lnNrOpcao = 2, " And notas = '      '", "")) + ;
                        IIF(!EMPTY(loc_lcUsuario), " And usuars = '" + loc_lcUsuario + "'", "") + ;
                        IIF(!EMPTY(loc_lcOperador), " And Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                        " Order By emps,dopes,datas"
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEest")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar SigMvCab (Sa" + CHR(237) + "das)"
                MsgErro(THIS.this_cMensagemErro, "Processar")
                RETURN .F.
            ENDIF

            SELECT CsEest
            GO TOP
            SCAN
                IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                    m.usuars = CsEest.usuars
                ELSE
                    m.usuars = SPACE(10)
                ENDIF
                SELECT TmpUsuarios
                SET ORDER TO Usuarios
                SEEK m.usuars
                IF EOF()
                    INSERT INTO TmpUsuarios (usuarios) VALUES (m.usuars)
                ENDIF
                loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEest.datas)
                loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEest.datas)
                SELECT SaiCai
                SET ORDER TO dopes
                SEEK m.usuars + CrSigCdOpe.dopes
                IF EOF()
                    APPEND BLANK
                    REPLACE SaiCai.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                            SaiCai.tipoops    WITH CrSigCdOpe.tipoops, ;
                            SaiCai.dopes      WITH CrSigCdOpe.dopes, ;
                            SaiCai.usuars     WITH m.usuars
                ENDIF
                loc_lnValCal = ROUND(CsEest.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2) * -1
                REPLACE SaiCai.totas WITH SaiCai.totas + loc_lnValCal

                WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das...(3)" NOWAIT
                IF USED("TmpPar")
                    USE IN TmpPar
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos From SigMvPar " + ;
                    "Where empdopnums = '" + CsEest.emps + CsEest.dopes + STR(CsEest.numes, 6) + "'", "TmpPar")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvPar (Sa" + CHR(237) + "das)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT TmpPar
                GO TOP
                SCAN
                    SELECT Parcela
                    SET ORDER TO FPags
                    SEEK m.usuars + TmpPar.fpags
                    IF EOF()
                        APPEND BLANK
                        REPLACE Parcela.fpags  WITH TmpPar.fpags, ;
                                Parcela.usuars WITH m.usuars
                    ENDIF
                    loc_lnCotF   = IIF(!EMPTY(TmpPar.cotfpgs), TmpPar.cotfpgs, ;
                                       THIS.CarregarCambio(TmpPar.moefpgs, DATE()))
                    loc_lnValPar = ROUND(TmpPar.valos * loc_lnCotF / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    SEEK TmpPar.dopes ORDER TAG Dopes IN CrSigCdOpe
                    SEEK TmpPar.fpags ORDER TAG FPags IN CrSigOpFp
                    loc_lnValPar = loc_lnValPar * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                    REPLACE Parcela.valos WITH Parcela.valos + loc_lnValPar, ;
                            Parcela.origs WITH Parcela.origs + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN Parcela
                    loc_lnValParAv = loc_lnValPar
                    loc_lnDias = TmpPar.datas - TmpPar.vencs
                    IF loc_lnDias < 0
                        loc_lnTxDia   = ((1 + loc_TxMes / 100) ^ (1 / 30) - 1) * 100
                        loc_lnTxDia   = INT(loc_lnTxDia * 100 + 0.5) / 100
                        loc_lnDesconto = (1 + loc_lnTxDia / 100) ^ (-1 * loc_lnDias)
                        loc_lnPorc    = (1 - 1 / loc_lnDesconto) * 100
                        loc_lnPorc    = INT(loc_lnPorc * 100 + 0.5) / 100
                        loc_lnValParAv = (loc_lnValPar * (1 - (loc_lnPorc / 100)))
                        loc_lnValParAv = INT(loc_lnValParAv * 100 + 0.5) / 100
                    ENDIF
                    SELECT CrSigOpFp
                    IF !EMPTY(CrSigOpFp.descs)
                        loc_lnValParAv = loc_lnValParAv - ROUND(loc_lnValParAv * CrSigOpFp.descs / 100, 2)
                    ENDIF
                    SELECT Parcela
                    REPLACE Parcela.valoavs WITH Parcela.valoavs + loc_lnValParAv

                    IF CrSigCdOpe.ccomis = 1
                        WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das..." NOWAIT
                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lnResult = SQLEXEC(gnConnHandle, ;
                            "Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a " + ;
                            "Left Join SigCdCrg b On b.ccargs = a.ccargs " + ;
                            "Where a.grupos = '" + ALLTRIM(CsEest.grvends) + "'" + ;
                            " And a.iclis = '" + ALLTRIM(CsEest.vends) + "'", "TmpCli")
                        IF loc_lnResult < 1
                            THIS.this_cMensagemErro = "Falha ao consultar SigCdCli (Sa" + CHR(237) + "das)"
                            MsgErro(THIS.this_cMensagemErro, "Processar")
                            RETURN .F.
                        ENDIF
                        loc_lnComFPag = 0
                        SELECT TmpCli
                        GO TOP
                        IF !EOF()
                            IF !EMPTY(TmpCli.comis)
                                loc_lnComFPag = TmpCli.comis
                            ELSE
                                loc_lnComFPag = CrSigOpFp.fpcomiss
                            ENDIF
                            IF CrSigCdOpe.comcargs = 1
                                loc_lnComFPag = NVL(TmpCli.cargcom, 0)
                            ENDIF
                        ENDIF
                        SELECT Comissao
                        SET ORDER TO vends
                        SEEK CsEest.vends
                        IF EOF()
                            APPEND BLANK
                            REPLACE Comissao.vends WITH CsEest.vends
                        ENDIF
                        loc_lnValPar = TmpPar.Valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                        loc_lnComiss = ROUND(loc_lnValPar / 100 * loc_lnComFPag, 2)
                        REPLACE Comissao.valos WITH Comissao.valos + ROUND(loc_lnValPar * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                        REPLACE Comissao.comis WITH Comissao.comis + loc_lnComiss
                    ENDIF

                    IF CrSigOpFp.infos = "C"
                        IF TmpPar.vencs > lcDtFinal
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " PRE", 12)
                        ELSE
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " AV", 12)
                        ENDIF
                    ELSE
                        loc_lcTip = CrSigOpFp.formas
                    ENDIF
                    IF !SEEK(TmpPar.dopes + loc_lcTip, "LancFor", "DopPag")
                        INSERT INTO LancFor (dopes, forma) VALUES (TmpPar.dopes, loc_lcTip)
                    ENDIF
                    REPLACE LancFor.valos  WITH LancFor.valos  + loc_lnValPar, ;
                            LancFor.Origs  WITH LancFor.Origs  + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN LancFor
                    SELECT TmpPar
                ENDSCAN

                SELECT Comissao
                SET ORDER TO vends
                SEEK CsEest.vends
                IF EOF()
                    APPEND BLANK
                    REPLACE Comissao.vends WITH CsEest.vends
                ENDIF
                REPLACE TotOpS WITH TotOpS + 1

                SELECT CsEest
            ENDSCAN

            IF loc_lnResQtdes = 1 AND loc_lnOptCol <> 1
                WAIT WINDOW "Aguarde! Verificando Sa" + CHR(237) + "das...(4)" NOWAIT
                IF USED("CsEesti")
                    USE IN CsEesti
                ENDIF
                loc_lcSql = "Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars " + ;
                            "From SigMvCab a, SigMvItn b " + ;
                            "Where a.datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                            "a.Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkEa + ;
                            IIF(loc_lnNrOpcao = 1, " And a.notas <> '      '", ;
                                IIF(loc_lnNrOpcao = 2, " And a.notas = '      '", "")) + ;
                            IIF(!EMPTY(loc_lcUsuario), " And a.usuars = '" + loc_lcUsuario + "'", "") + ;
                            IIF(!EMPTY(loc_lcOperador), " And a.Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                            " And b.empdopnums = a.empdopnums" + ;
                            " Order By a.emps,a.dopes,a.datas"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEesti")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvItn (Sa" + CHR(237) + "das/Qtde)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT CsEesti
                GO TOP
                SCAN
                    IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                        m.usuars = CsEesti.usuars
                    ELSE
                        m.usuars = SPACE(10)
                    ENDIF
                    SELECT TmpUsuarios
                    SET ORDER TO Usuarios
                    SEEK m.usuars
                    IF EOF()
                        INSERT INTO TmpUsuarios (usuarios) VALUES (m.usuars)
                    ENDIF
                    loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEesti.datas)
                    loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEesti.datas)
                    SELECT SaiEesti
                    SET ORDER TO dopes
                    SEEK m.usuars + CrSigCdOpe.dopes
                    IF EOF()
                        APPEND BLANK
                        REPLACE SaiEesti.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                                SaiEesti.tipoops    WITH CrSigCdOpe.tipoops, ;
                                SaiEesti.dopes      WITH CrSigCdOpe.dopes, ;
                                SaiEesti.usuars     WITH m.usuars
                    ENDIF
                    loc_lnValCal = ROUND(CsEesti.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2) * -1
                    REPLACE SaiEesti.totas WITH SaiEesti.totas + loc_lnValCal
                    REPLACE SaiEesti.qtds  WITH SaiEesti.qtds  + CsEesti.qtds
                    SELECT CsEesti
                ENDSCAN
            ENDIF

            SELECT CrSigCdOpe
        ENDSCAN

        *==========================================================
        *-- LOOP DE DEVOLUCOES: caixas=1 / copers=2 / CalcFecs=1
        *==========================================================
        CREATE CURSOR DevCai (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), relfechgrs c(2))
        INDEX ON usuars + dopes TAG dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        CREATE CURSOR DevEesti (dopes c(20), totas n(16,2), usuars c(10), tipoops n(2), ;
                                  relfechgrs c(2), qtds n(12,3))
        INDEX ON usuars + dopes TAG dopes
        INDEX ON usuars + STR(tipoops, 2) + dopes TAG ITipoOps

        WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es..." NOWAIT

        SELECT CrSigCdOpe
        SET ORDER TO ordes
        GO TOP
        SCAN FOR CrSigCdOpe.caixas = 1 AND CrSigCdOpe.copers = 2 AND ;
                 CrSigCdOpe.vendas <> 1 AND CrSigCdOpe.CalcFecs = 1 AND ;
                 CrSigCdOpe.relfechas = IIF(THIS.this_lSegunda, 3, 1)

            WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es...(1)" NOWAIT
            SEEK CrSigCdOpe.TipoOps ORDER TAG Codigos IN cs_SigCdTom
            IF loc_llTipoSel AND cs_SigCdTom.Marca = 0
                LOOP
            ENDIF

            WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es...(2)" NOWAIT
            IF USED("CsEest")
                USE IN CsEest
            ENDIF
            loc_lcSql = "Select emps,dopes,numes,datas,valos,grvends,vends,contads,contaos," + ;
                        "notas,nPedClis,obses,usuars,descs,valdescs,acres,valacres,vars,valvars,desc2s,valdevs From SigMvCab " + ;
                        "Where datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                        "Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkE + ;
                        IIF(loc_lnNrOpcao = 1, " And notas <> '      '", ;
                            IIF(loc_lnNrOpcao = 2, " And notas = '      '", "")) + ;
                        IIF(!EMPTY(loc_lcUsuario), " And usuars = '" + loc_lcUsuario + "'", "") + ;
                        IIF(!EMPTY(loc_lcOperador), " And Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                        " Order By emps,dopes,datas"
            loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEest")
            IF loc_lnResult < 1
                THIS.this_cMensagemErro = "Falha ao consultar SigMvCab (Devolu" + CHR(231) + CHR(245) + "es)"
                MsgErro(THIS.this_cMensagemErro, "Processar")
                RETURN .F.
            ENDIF

            SELECT CsEest
            GO TOP
            SCAN
                IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                    m.usuars = CsEest.usuars
                ELSE
                    m.usuars = SPACE(10)
                ENDIF
                SELECT TmpUsuarios
                SET ORDER TO Usuarios
                SEEK m.usuars
                IF EOF()
                    INSERT INTO TmpUsuarios (Usuarios) VALUES (m.usuars)
                ENDIF
                loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEest.datas)
                loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEest.datas)
                SELECT DevCai
                SET ORDER TO Dopes
                SEEK m.usuars + CrSigCdOpe.dopes
                IF EOF()
                    APPEND BLANK
                    REPLACE DevCai.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                            DevCai.tipoops    WITH CrSigCdOpe.tipoops, ;
                            DevCai.dopes      WITH CrSigCdOpe.dopes, ;
                            DevCai.usuars     WITH m.usuars
                ENDIF
                loc_lnValCal = ROUND(CsEest.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                REPLACE DevCai.totas WITH DevCai.totas + loc_lnValCal

                WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es...(3)" NOWAIT
                IF USED("TmpPar")
                    USE IN TmpPar
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "Select dopes,datas,vencs,fpags,moefpgs,cotfpgs,valos From SigMvPar " + ;
                    "Where empdopnums = '" + CsEest.emps + CsEest.dopes + STR(CsEest.numes, 6) + "'", "TmpPar")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvPar (Devolu" + CHR(231) + CHR(245) + "es)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT TmpPar
                GO TOP
                SCAN
                    SELECT Parcela
                    SET ORDER TO FPags
                    SEEK m.usuars + TmpPar.fpags
                    IF EOF()
                        APPEND BLANK
                        REPLACE Parcela.fpags  WITH TmpPar.FPags, ;
                                Parcela.usuars WITH m.usuars IN Parcela
                    ENDIF
                    loc_lnCotF   = IIF(!EMPTY(TmpPar.cotfpgs), TmpPar.cotfpgs, ;
                                       THIS.CarregarCambio(TmpPar.moefpgs, DATE()))
                    loc_lnValPar = ROUND(TmpPar.valos * loc_lnCotF / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    SEEK TmpPar.dopes ORDER TAG Dopes IN CrSigCdOpe
                    SEEK TmpPar.fpags ORDER TAG FPags IN CrSigOpFp
                    loc_lnValPar = loc_lnValPar * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)

                    REPLACE Parcela.devols WITH Parcela.devols + loc_lnValPar, ;
                            Parcela.dorigs WITH Parcela.dorigs + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN Parcela

                    loc_lnValParAv = loc_lnValPar
                    loc_lnDias = TmpPar.datas - TmpPar.vencs
                    IF loc_lnDias < 0
                        loc_lnTxDia   = ((1 + loc_TxMes / 100) ^ (1 / 30) - 1) * 100
                        loc_lnTxDia   = INT(loc_lnTxDia * 100 + 0.5) / 100
                        loc_lnDesconto = (1 + loc_lnTxDia / 100) ^ (-1 * loc_lnDias)
                        loc_lnPorc    = (1 - 1 / loc_lnDesconto) * 100
                        loc_lnPorc    = INT(loc_lnPorc * 100 + 0.5) / 100
                        loc_lnValParAv = (loc_lnValPar * (1 - (loc_lnPorc / 100)))
                        loc_lnValParAv = INT(loc_lnValParAv * 100 + 0.5) / 100
                    ENDIF
                    SELECT CrSigOpFp
                    IF !EMPTY(CrSigOpFp.descs)
                        loc_lnValParAv = loc_lnValParAv - ROUND(loc_lnValParAv * CrSigOpFp.descs / 100, 2)
                    ENDIF
                    SELECT Parcela
                    REPLACE Parcela.valoavs WITH valoavs - loc_lnValParAv IN Parcela

                    IF CrSigCdOpe.ccomis = 1
                        WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es...(4)" NOWAIT
                        IF USED("TmpCli")
                            USE IN TmpCli
                        ENDIF
                        loc_lnResult = SQLEXEC(gnConnHandle, ;
                            "Select a.comis,a.ccargs,b.comis As cargcom From SigCdCli a " + ;
                            "Left Join SigCdCrg b On b.ccargs = a.ccargs " + ;
                            "Where a.grupos = '" + ALLTRIM(CsEest.grvends) + "'" + ;
                            " And a.iclis = '" + ALLTRIM(CsEest.vends) + "'", "TmpCli")
                        IF loc_lnResult < 1
                            THIS.this_cMensagemErro = "Falha ao consultar SigCdCli (Devolu" + CHR(231) + CHR(245) + "es)"
                            MsgErro(THIS.this_cMensagemErro, "Processar")
                            RETURN .F.
                        ENDIF
                        loc_lnComFPag = 0
                        SELECT TmpCli
                        GO TOP
                        IF !EOF()
                            IF !EMPTY(TmpCli.comis)
                                loc_lnComFPag = TmpCli.comis
                            ELSE
                                loc_lnComFPag = CrSigOpFp.fpcomiss
                            ENDIF
                            IF CrSigCdOpe.comcargs = 1
                                loc_lnComFPag = NVL(TmpCli.cargcom, 0)
                            ENDIF
                        ENDIF
                        SELECT Comissao
                        SET ORDER TO vends
                        SEEK CsEest.vends
                        IF EOF()
                            APPEND BLANK
                            REPLACE Comissao.vends WITH CsEest.vends
                        ENDIF
                        loc_lnValPar = TmpPar.Valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)
                        loc_lnComiss = ROUND(loc_lnValPar / 100 * loc_lnComFPag, 2)
                        REPLACE Comissao.valos WITH Comissao.valos + ROUND(loc_lnValPar * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                        REPLACE Comissao.comis WITH Comissao.comis + loc_lnComiss
                    ENDIF

                    IF CrSigOpFp.infos = "C"
                        IF CrSigOpFp.fparcs = 1
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " AV", 12)
                        ELSE
                            loc_lcTip = PADR(ALLTRIM(CrSigOpFp.formas) + " PRE", 12)
                        ENDIF
                    ELSE
                        loc_lcTip = CrSigOpFp.formas
                    ENDIF
                    IF !SEEK(m.usuars + TmpPar.dopes + loc_lcTip, "LancFor", "DopPag")
                        INSERT INTO LancFor (dopes, forma, usuars) VALUES (TmpPar.dopes, loc_lcTip, m.usuars)
                    ENDIF
                    REPLACE LancFor.devols WITH LancFor.devols + loc_lnValPar, ;
                            LancFor.Origs  WITH LancFor.Origs  + (TmpPar.valos * IIF(CrSigCdOpe.copers = 2, -1, 1) * IIF(CrSigOpFp.trocos = 1, -1, 1)) IN LancFor
                    SELECT TmpPar
                ENDSCAN

                SELECT Comissao
                SET ORDER TO vends
                SEEK CsEest.vends
                IF EOF()
                    APPEND BLANK
                    REPLACE Comissao.vends WITH CsEest.vends
                ENDIF
                REPLACE TotOpE WITH TotOpE + 1

                SELECT CsEest
            ENDSCAN

            IF loc_lnResQtdes = 1 AND loc_lnOptCol <> 1
                WAIT WINDOW "Aguarde! Verificando Devolu" + CHR(231) + CHR(245) + "es...(5)" NOWAIT
                IF USED("CsEesti")
                    USE IN CsEesti
                ENDIF
                loc_lcSql = "Select a.emps,a.dopes,a.numes,a.datas,b.qtds,b.totas As valos,a.usuars " + ;
                            "From SigMvCab a, SigMvItn b " + ;
                            "Where a.datas Between ?lcDtInicial And ?lcDtFinal And " + ;
                            "a.Dopes = '" + CrSigCdOpe.Dopes + "'" + loc_lcChkEa + ;
                            IIF(loc_lnNrOpcao = 1, " And a.notas <> '      '", ;
                                IIF(loc_lnNrOpcao = 2, " And a.notas = '      '", "")) + ;
                            IIF(!EMPTY(loc_lcUsuario), " And a.usuars = '" + loc_lcUsuario + "'", "") + ;
                            IIF(!EMPTY(loc_lcOperador), " And a.Operadors = '" + PADR(loc_lcOperador, 10) + "'", "") + ;
                            " And b.empdopnums = a.empdopnums" + ;
                            " Order By a.emps,a.dopes,a.datas"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "CsEesti")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigMvItn (Devolu" + CHR(231) + CHR(245) + "es/Qtde)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                SELECT CsEesti
                GO TOP
                SCAN
                    IF loc_lnOptQuebra = 1 OR !EMPTY(loc_lcUsuario)
                        m.usuars = CsEesti.usuars
                    ELSE
                        m.usuars = SPACE(10)
                    ENDIF
                    SELECT TmpUsuarios
                    SET ORDER TO Usuarios
                    SEEK m.usuars
                    IF EOF()
                        INSERT INTO TmpUsuarios (usuarios) VALUES (m.usuars)
                    ENDIF
                    loc_lnCotE = THIS.CarregarCambio(CrSigCdOpe.cmoes, CsEesti.datas)
                    loc_lnCotC = THIS.CarregarCambio(loc_lcCdMoeda, CsEesti.datas)
                    SELECT DevEesti
                    SET ORDER TO Dopes
                    SEEK m.usuars + CrSigCdOpe.dopes
                    IF EOF()
                        APPEND BLANK
                        REPLACE DevEesti.relfechgrs WITH CrSigCdOpe.relfechgrs, ;
                                DevEesti.tipoops    WITH CrSigCdOpe.tipoops, ;
                                DevEesti.dopes      WITH CrSigCdOpe.dopes, ;
                                DevEesti.usuars     WITH m.usuars
                    ENDIF
                    loc_lnValCal = ROUND(CsEesti.valos * loc_lnCotE / IIF(loc_lnCotC = 0, 1, loc_lnCotC), 2)
                    REPLACE DevEesti.totas WITH DevEesti.totas + loc_lnValCal
                    REPLACE DevEesti.qtds  WITH DevEesti.qtds  + CsEesti.qtds
                    SELECT CsEesti
                ENDSCAN
            ENDIF

            SELECT CrSigCdOpe
        ENDSCAN

        *==========================================================
        *-- SECAO DE SAIDA 80 COLUNAS: Rel_Ini (detalhes por oper.)
        *==========================================================
        SELECT dbRelIni
        GO TOP
        IF loc_lnOptCol = 2 AND loc_lnOptMov = 1
            IF !EOF()
                THIS.RelIni(loc_ldDtImp)
            ENDIF
        ENDIF

        *==========================================================
        *-- SECAO DE OUTPUT: gera linhas de texto por usuario
        *==========================================================
        WAIT WINDOW "Aguarde! Imprimindo resumos..." NOWAIT

        SELECT TmpUsuarios
        SCAN
            SEEK loc_lcEmpresa ORDER TAG cemps IN CrSigCdEmp

            IF loc_lnOptCol = 1
                IF INLIST(1, loc_lnResLanca, loc_lnResCheque, loc_lnResCartao, loc_lnResConta, ;
                             loc_lnResVende, loc_lnResForma, loc_lnResLanFor, loc_lnResQtdes, loc_lnResVDets)
                    THIS.Linha(1, 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADC(ALLTRIM(CrSigCdEmp.razas), 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADC("Fechamento em " + PROPER(ALLTRIM(loc_lcDsMoeda)), 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADC("Periodo: " + DTOC(par_dDtInicial) + " a " + DTOC(par_dDtFinal), 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADC("Data/Hora: " + DTOC(DATE()) + "-" + TIME(), 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    IF !EMPTY(TmpUsuarios.usuarios)
                        THIS.Linha(PADC("Usuario: " + ALLTRIM(TmpUsuarios.usuarios) + ;
                                        IIF(!EMPTY(loc_lcOperador), " - Operador : " + ALLTRIM(loc_lcOperador), ""), 40), ;
                                   2, TmpUsuarios.usuarios, loc_ldDtImp)
                    ENDIF
                    THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
            ELSE
                IF !EMPTY(TmpUsuarios.usuarios)
                    THIS.Linha(PADC("Usuario: " + ALLTRIM(TmpUsuarios.usuarios), 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
            ENDIF

            *-- RESUMO POR LANCAMENTO
            IF loc_lnResLanca = 1
                SELECT Vendas
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT EntCai
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT DevCai
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT SaiCai
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP

                IF !EOF("Vendas") OR !EOF("EntCai") OR !EOF("SaiCai") OR !EOF("DevCai")
                    THIS.Cabecalho("RESUMO POR LANCAMENTO", (loc_lnResLanFor = 1), TmpUsuarios.usuarios, .F., loc_ldDtImp)
                    IF loc_lnResLanFor = 1
                        THIS.Linha(PADC("GERAL", 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                        THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    ENDIF
                ENDIF

                SELECT "Vendas" AS tps, * FROM Vendas ;
                    UNION ALL ;
                    SELECT "EntCai" AS tps, * FROM EntCai ;
                    UNION ALL ;
                    SELECT "SaiCai" AS tps, * FROM SaiCai ;
                    ORDER BY 3, 5, 1 ;
                    INTO CURSOR CsResLan

                SELECT tps, usuars, tipoops, dopes, relfechgrs, SUM(totas) AS totals ;
                    FROM CsResLan ;
                    WHERE usuars = TmpUsuarios.usuarios ;
                    GROUP BY tps, Usuars, Tipoops, relfechgrs, dopes ;
                    ORDER BY tps, relfechgrs, dopes ;
                    INTO CURSOR CsItem

                SELECT COUNT(1) AS totitens, tps, usuars, relfechgrs, SUM(totals) AS totgeral ;
                    FROM CsItem ;
                    WHERE usuars = TmpUsuarios.usuarios ;
                    GROUP BY tps, usuars, relfechgrs ;
                    ORDER BY tps, relfechgrs ;
                    INTO CURSOR CsCab

                SELECT CsCab
                loc_lnTotgeral = 0
                SCAN
                    SELECT CsItem
                    SCAN FOR CsCab.tps = CsItem.tps AND CsCab.relfechgrs == CsItem.relfechgrs
                        SEEK CsItem.dopes ORDER TAG Dopes IN CrSigCdOpe
                        THIS.Linha(CrSigCdOpe.dopes + ":" + TRANSFORM(CsItem.totals, "999,999,999.99"), ;
                                   2, CsItem.usuars, loc_ldDtImp)
                        IF CsItem.tps == "Vendas"
                            REPLACE TmpUsuarios.totvens WITH TmpUsuarios.TotVens + CsItem.totals
                        ENDIF
                        IF CsItem.tps == "EntCai"
                            REPLACE TmpUsuarios.totents WITH TmpUsuarios.totents + CsItem.totals
                        ENDIF
                        IF CsItem.tps == "SaiCai"
                            REPLACE TmpUsuarios.totsais WITH TmpUsuarios.totsais + CsItem.totals
                        ENDIF
                    ENDSCAN
                    SELECT CsCab
                    IF CsCab.totitens > 1
                        THIS.Linha(SPACE(21) + REPLICATE("-", 14), 2, CsCab.usuars, loc_ldDtImp)
                        THIS.Linha(PADR("SubTotal" + CsCab.Tps, 20) + ":" + TRANSFORM(CsCab.totgeral, "999,999,999.99"), ;
                                   2, CsCab.usuars, loc_ldDtImp)
                        THIS.Linha(SPACE(20), 2, CsCab.usuars, loc_ldDtImp)
                    ENDIF
                    loc_lnTotgeral = loc_lnTotgeral + CsCab.totgeral
                ENDSCAN
                SELECT CsCab
                SKIP -1
                THIS.Linha(SPACE(10), 2, CsCab.usuars, loc_ldDtImp)
                THIS.Linha(PADR("Total Geral", 20) + ":" + TRANSFORM(loc_lnTotgeral, "999,999,999.99"), ;
                           2, CsCab.usuars, loc_ldDtImp)
            ENDIF

            *-- RESUMO POR LANCAMENTO - ITENS X VALOR (80 col)
            IF loc_lnResQtdes = 1 AND loc_lnOptCol <> 1
                SELECT VdaEesti
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT EntEesti
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT DevEesti
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                SELECT SaiEesti
                SET ORDER TO Dopes
                SET KEY TO TmpUsuarios.usuarios
                GO TOP

                IF !EOF("VdaEesti") OR !EOF("EntEesti") OR !EOF("SaiEesti") OR !EOF("DevEesti")
                    THIS.Cabecalho("RESUMO POR LANCAMENTO  - ITENS X VALOR", (loc_lnResQtdes = 1), ;
                                   TmpUsuarios.usuarios, .T., loc_ldDtImp)
                    IF loc_lnResQtdes = 1
                        THIS.Linha(PADC("GERAL", 48), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                        THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    ENDIF
                ENDIF

                SELECT "Vendas" AS tps, * FROM VdaEesti ;
                    UNION ALL ;
                    SELECT "EntCai" AS tps, * FROM EntEesti ;
                    UNION ALL ;
                    SELECT "SaiCai" AS tps, * FROM SaiEesti ;
                    UNION ALL ;
                    SELECT "DevCai" AS tps, * FROM DevEesti ;
                    ORDER BY 3, 5, 1 ;
                    INTO CURSOR CsResQtde

                SELECT tps, usuars, tipoops, dopes, relfechgrs, ;
                       SUM(totas) AS totals, SUM(qtds) AS qtds ;
                    FROM CsResQtde ;
                    WHERE usuars = TmpUsuarios.usuarios ;
                    GROUP BY tps, usuars, tipoops, relfechgrs, dopes ;
                    ORDER BY tps, relfechgrs, dopes ;
                    INTO CURSOR CsItemQt

                SELECT COUNT(1) AS totitens, tps, usuars, relfechgrs, ;
                       SUM(totals) AS totgeral, SUM(qtds) AS qtdgeral ;
                    FROM CsItemQt ;
                    WHERE usuars = TmpUsuarios.usuarios ;
                    GROUP BY tps, usuars, relfechgrs ;
                    ORDER BY tps, relfechgrs ;
                    INTO CURSOR CsCabQtde

                SELECT CsCabQtde
                loc_lnTotgeral = 0
                loc_lnQtdGeral = 0
                SCAN
                    SELECT CsItemQt
                    SCAN FOR CsCabQtde.tps = CsItemQt.tps AND CsCabQtde.relfechgrs == CsItemQt.relfechgrs
                        SEEK CsItemQt.dopes ORDER TAG Dopes IN CrSigCdOpe
                        THIS.Linha(CrSigCdOpe.dopes + ":" + TRANSFORM(CsItemQt.qtds, "999,999.999") + " " + ;
                                   TRANSFORM(CsItemQt.totals, "999,999,999.99"), ;
                                   2, CsItemQt.usuars, loc_ldDtImp)
                    ENDSCAN
                    SELECT CsCabQtde
                    IF CsCabQtde.totitens > 1
                        THIS.Linha(SPACE(21) + REPLICATE("-", 11) + " " + REPLICATE("-", 14), ;
                                   2, CsCabQtde.usuars, loc_ldDtImp)
                        THIS.Linha(PADR("SubTotal", 20) + ":" + TRANSFORM(CsCabQtde.qtdgeral, "999,999.999") + " " + ;
                                   TRANSFORM(CsCabQtde.totgeral, "999,999,999.99"), ;
                                   2, CsCabQtde.usuars, loc_ldDtImp)
                        THIS.Linha(SPACE(20), 2, CsCabQtde.usuars, loc_ldDtImp)
                    ENDIF
                    loc_lnTotgeral = loc_lnTotgeral + CsCabQtde.totgeral
                    loc_lnQtdGeral = loc_lnQtdGeral + CsCabQtde.qtdgeral
                ENDSCAN
                SELECT CsCabQtde
                IF !BOF()
                    SKIP -1
                ENDIF
                THIS.Linha(SPACE(10), 2, CsCabQtde.usuars, loc_ldDtImp)
                THIS.Linha(PADR("Total Geral", 20) + ":" + TRANSFORM(loc_lnQtdGeral, "999,999.999") + " " + ;
                           TRANSFORM(loc_lnTotgeral, "999,999,999.99"), 2, CsCabQtde.usuars, loc_ldDtImp)
            ENDIF

            *-- SALDO ANTERIOR
            IF loc_lSaldoAnt > 0
                THIS.Cabecalho("SALDO ANTERIOR GERAL", , TmpUsuarios.usuarios, .F., loc_ldDtImp)
                THIS.Linha(PADR(ALLTRIM(NVL(CrSigCdPam.contas, "")), 20) + ":" + ;
                           TRANSFORM(loc_lSaldoAnt, "999,999,999.99"), 2, TmpUsuarios.usuarios, loc_ldDtImp)
            ENDIF

            *-- RESUMO POR CONDICAO DE PAGAMENTO
            IF loc_lnResForma = 1
                SELECT Parcela
                SET ORDER TO Tipo
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                IF !EOF()
                    THIS.Cabecalho("RESUMO POR CONDICAO DE PAGAMENTO", (loc_lnResLanFor = 1), ;
                                   TmpUsuarios.usuarios, .F., loc_ldDtImp)
                    IF loc_lnResLanFor = 1
                        THIS.Linha(PADC("GERAL", 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                        THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    ENDIF
                    THIS.Linha(SPACE(15) + PADL("Valor", 24), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
                loc_lnTotDev  = 0
                loc_lnTotPar  = 0
                loc_lnTotTip1 = 0
                loc_lnTotTip2 = 0
                SELECT Parcela
                loc_lTipAnt = Tipo
                SCAN
                    SEEK Parcela.fpags ORDER TAG FPags IN CrSigOpFp
                    IF loc_lTipAnt # Tipo
                        THIS.Linha(SPACE(15) + REPLICATE("-", 25), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                        THIS.Linha(PADR(">TOT " + ALLTRIM(loc_lTipAnt), 14) + ":" + ;
                                   TRANSFORM(loc_lnTotTip1, "9,999,999,999,999,999.99"), ;
                                   2, TmpUsuarios.usuarios, loc_ldDtImp)
                        THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                        loc_lTipAnt = Tipo
                        loc_lnTotTip1 = 0
                        loc_lnTotTip2 = 0
                    ENDIF
                    THIS.Linha(PADR(Parcela.fpags, 14) + ":" + TRANSFORM(Parcela.origs, "9,999,999,999,999,999.99"), ;
                               2, TmpUsuarios.usuarios, loc_ldDtImp)
                    IF !NVL(CrSigOpFp.CPags = 2, .F.)
                        loc_lnTotPar  = loc_lnTotPar  + Parcela.valos
                        loc_lnTotDev  = loc_lnTotDev  + Parcela.devols
                        loc_lnTotTip1 = loc_lnTotTip1 + Parcela.valos
                        loc_lnTotTip2 = loc_lnTotTip2 + Parcela.devols
                    ENDIF
                ENDSCAN
                IF loc_lnTotTip1 # 0 OR loc_lnTotTip2 # 0
                    THIS.Linha(SPACE(15) + REPLICATE("-", 25), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADR(">TOT " + ALLTRIM(loc_lTipAnt), 14) + ":" + ;
                               TRANSFORM(loc_lnTotTip1, "9,999,999,999,999,999.99"), ;
                               2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
                IF loc_lnTotPar # 0 OR loc_lnTotDev # 0
                    THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADR(">TOT GERAL", 14) + ":" + ;
                               TRANSFORM(loc_lnTotPar, "9,999,999,999,999,999.99"), ;
                               2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
            ENDIF

            *-- RESUMO DE FORMA DE PAGAMENTO POR LANCAMENTO
            IF loc_lnResLanFor = 1
                SELECT usuars, dopes FROM Vendas WHERE usuars = TmpUsuarios.usuarios ;
                    UNION ALL ;
                    SELECT usuars, dopes FROM EntCai WHERE usuars = TmpUsuarios.usuarios ;
                    UNION ALL ;
                    SELECT usuars, dopes FROM SaiCai WHERE usuars = TmpUsuarios.usuarios ;
                    UNION ALL ;
                    SELECT usuars, dopes FROM DevCai WHERE usuars = TmpUsuarios.usuarios ;
                    INTO CURSOR ImpLanFor
                SELECT ImpLanFor
                GO TOP
                IF !EOF()
                    loc_lnTotDev  = 0
                    loc_lnTotPar  = 0
                    loc_lnTotTip1 = 0
                    loc_lnTotTip2 = 0
                    THIS.Cabecalho("RESUMO DE FORMA DE PAGAMENTO", .T., TmpUsuarios.usuarios, .F., loc_ldDtImp)
                    THIS.Linha(PADC("POR LANCAMENTO", 40), 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                    SCAN
                        SELECT LancFor
                        GO TOP
                        SEEK ImpLanFor.usuars + ImpLanFor.dopes
                        THIS.Linha(PADC("* " + ALLTRIM(LancFor.dopes) + " *", 40), 2, ImpLanFor.usuars, loc_ldDtImp)
                        THIS.Linha("", 2, ImpLanFor.usuars, loc_ldDtImp)
                        THIS.Linha(SPACE(15) + PADL("Valor", 24), 2, ImpLanFor.usuars, loc_ldDtImp)
                        SCAN WHILE LancFor.usuars + LancFor.dopes = ImpLanFor.usuars + ImpLanFor.dopes
                            THIS.Linha(PADR(LancFor.forma, 14) + ":" + ;
                                       TRANSFORM(LancFor.Origs, "9,999,999,999,999,999.99"), ;
                                       2, LancFor.usuars, loc_ldDtImp)
                            loc_lnTotPar  = loc_lnTotPar  + LancFor.valos
                            loc_lnTotDev  = loc_lnTotDev  + LancFor.devols
                            loc_lnTotTip1 = loc_lnTotTip1 + LancFor.valos
                            loc_lnTotTip2 = loc_lnTotTip2 + LancFor.devols
                        ENDSCAN
                        SELECT ImpLanFor
                        IF loc_lnTotTip1 # 0 OR loc_lnTotTip2 # 0
                            THIS.Linha(SPACE(15) + REPLICATE("-", 25), 2, ImpLanFor.usuars, loc_ldDtImp)
                            THIS.Linha(PADR(">TOTAL", 14) + ":" + ;
                                       TRANSFORM(loc_lnTotTip1, "9,999,999,999,999,999.99"), ;
                                       2, ImpLanFor.usuars, loc_ldDtImp)
                            THIS.Linha("", 2, ImpLanFor.usuars, loc_ldDtImp)
                        ENDIF
                        loc_lnTotTip1 = 0
                        loc_lnTotTip2 = 0
                    ENDSCAN
                    IF loc_lnTotPar # 0 OR loc_lnTotDev # 0
                        THIS.Linha(PADR(">TOT GERAL", 14) + ":" + ;
                                   TRANSFORM(loc_lnTotPar, "9,999,999,999,999,999.99"), ;
                                   2, TmpUsuarios.usuarios, loc_ldDtImp)
                    ENDIF
                ENDIF
            ENDIF

            *-- RESUMO MOVIMENTACAO DE CHEQUES
            IF loc_lnResCheque = 1 AND !(loc_lnOptQuebra = 1 AND EMPTY(loc_lcUsuario))
                IF USED("TmpCheb")
                    USE IN TmpCheb
                ENDIF
                IF loc_lnNrOpcao = 3
                    loc_lcSql = "Select a.ncheques,a.vencs,a.umovs,a.valors,b.codigos,c.tipos,b.usuarios,b.dopes,a.Nums,a.Iclis,d.Rclis,o.RelFechas " + ;
                                "From SigChe a, SigCqChm b, SigCdOpt c, SigCdCli d, SigCdOpe o " + ;
                                "Where 1=1" + loc_lcChkEb + ;
                                " And a.nums = b.nums And b.codigos = c.operacaos And a.Iclis = d.Iclis" + ;
                                " And b.dopes <> '" + SPACE(10) + "'" + ;
                                " And b.dtents Between ?lcDtInicial And ?lcDtFinal" + ;
                                IIF(!EMPTY(loc_lcUsuario), " And b.usuarios = '" + loc_lcUsuario + "'", "") + ;
                                " And a.Nums in (Select distinct a.Nums From SigCqChm a, SigCdOpt b where a.codigos=b.operacaos" + ;
                                " And a.dtents Between ?lcDtInicial And ?lcDtFinal and b.Ordens = 1)" + ;
                                " And b.Dopes = o.Dopes" + ;
                                " order by b.codigos,a.vencs"
                ELSE
                    loc_lcSql = "Select a.ncheques,a.vencs,a.umovs,a.valors,b.codigos,c.tipos,b.usuarios,b.dopes,a.Nums,a.Iclis,o.RelFechas " + ;
                                "From SigChe a, SigCqChm b, SigCdOpt c, SigMvCab d, SigCdCli E, SigCdOpe o " + ;
                                "Where 1=1" + loc_lcChkEb + ;
                                " And a.nums = b.nums And b.codigos = c.operacaos And a.Iclis = e.Iclis" + ;
                                " And b.dopes <> '" + SPACE(10) + "'" + ;
                                " And b.dtents Between ?lcDtInicial And ?lcDtFinal" + ;
                                IIF(!EMPTY(loc_lcUsuario), " And b.usuarios = '" + loc_lcUsuario + "' And ", "") + ;
                                " And b.EmpDopNums = d.EmpDopNums" + ;
                                IIF(loc_lnNrOpcao = 1, " And d.notas <> '      '", ;
                                    IIF(loc_lnNrOpcao = 2, " And d.notas = '      '", " ")) + ;
                                " And a.Nums in (Select distinct a.Nums From SigCqChm a, SigCdOpt b where a.codigos=b.operacaos" + ;
                                " And a.dtents Between ?lcDtInicial And ?lcDtFinal and b.Ordens = 1)" + ;
                                " And d.Dopes = o.Dopes" + ;
                                " order by b.codigos,a.vencs"
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSql, "TmpCheb")
                IF loc_lnResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar SigChe (Cheques)"
                    MsgErro(THIS.this_cMensagemErro, "Processar")
                    RETURN .F.
                ENDIF
                DELETE FROM TmpCheb WHERE NOT Relfechas = IIF(THIS.this_lSegunda, 3, 1)

                SELECT TmpCheb
                GO TOP
                IF !EOF()
                    THIS.Cabecalho("RESUMO MOVIMENTACAO DE CHEQUES", , , .F., loc_ldDtImp)
                    THIS.Linha("Numero" + " " + PADC("Vencto", 10) + " " + PADC("Valor", 12) + ;
                               " " + PADC("Opera" + CHR(231) + CHR(227) + "o", 9), ;
                               2, "", loc_ldDtImp)
                    THIS.Linha(REPLICATE("-", 6) + " " + REPLICATE("-", 10) + " " + ;
                               REPLICATE("-", 12) + " " + REPLICATE("-", 9), 2, "", loc_ldDtImp)

                    SELECT TmpCheb
                    loc_lcUserDopes = " "
                    SCAN
                        IF Codigos # loc_lcUserDopes
                            THIS.Linha(TmpCheb.Codigos, 2, "", loc_ldDtImp)
                            loc_lcUserDopes = TmpCheb.Codigos
                        ENDIF
                        THIS.Linha(TmpCheb.ncheques + " " + DTOC(TmpCheb.vencs) + " " + ;
                                   TRANSFORM(TmpCheb.valors, "9,999,999.99") + " " + ;
                                   SUBSTR(TmpCheb.dopes, 1, 9), 2, "", loc_ldDtImp)
                        IF (THIS.this_nChqDetalhado = 1)
                            THIS.Linha(IIF(TYPE("TmpCheb.Rclis") = "C", ALLTRIM(TmpCheb.Rclis), ""), 2, "", loc_ldDtImp)
                        ENDIF
                    ENDSCAN

                    SELECT SUM(valors) AS totchq, codigos FROM TmpCheb GROUP BY codigos INTO CURSOR TmpChe
                    THIS.Linha(, 2, "", loc_ldDtImp)
                    SELECT TmpChe
                    GO TOP
                    SCAN
                        THIS.Linha(TmpChe.codigos + "      :" + TRANSFORM(TmpChe.totchq, "999,999,999.99"), ;
                                   2, "", loc_ldDtImp)
                    ENDSCAN

                    IF USED("TmpOper")
                        USE IN TmpOper
                    ENDIF
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "Select operacaos,tipos From SigCdOpt Where tipos = 'DB'", "TmpOper")
                    IF loc_lnResult < 1
                        THIS.this_cMensagemErro = "Falha ao consultar SigCdOpt (Cheques)"
                        MsgErro(THIS.this_cMensagemErro, "Processar")
                        RETURN .F.
                    ENDIF

                    SELECT c.Tipos, SUM(valors) AS aberto ;
                        FROM TmpCheb a, TmpOper c ;
                        WHERE a.umovs = c.operacaos AND c.tipos = "DB" ;
                        GROUP BY c.tipos ;
                        INTO CURSOR TmpChea
                    SELECT TmpChea
                    GO TOP
                    SCAN
                        THIS.Linha(PADR("ABERTOS", 20) + " :" + TRANSFORM(TmpChea.aberto, "999,999,999.99"), ;
                                   2, "", loc_ldDtImp)
                    ENDSCAN

                    loc_lnTotAV  = 0
                    loc_lnTotPre = 0
                    SELECT TmpCheb
                    GO TOP
                    SCAN
                        IF TmpCheb.vencs > lcDtFinal
                            loc_lnTotPre = loc_lnTotPre + TmpCheb.valors
                        ELSE
                            loc_lnTotAV  = loc_lnTotAV  + TmpCheb.valors
                        ENDIF
                    ENDSCAN
                    THIS.Linha(PADR("A VISTA", 20) + " :" + TRANSFORM(loc_lnTotAV, "999,999,999.99"), ;
                               2, "", loc_ldDtImp)
                    THIS.Linha(PADR("PRE-DATADO", 20) + " :" + TRANSFORM(loc_lnTotPre, "999,999,999.99"), ;
                               2, "", loc_ldDtImp)
                ENDIF
            ENDIF

            *-- RESUMO MOVIMENTACAO DE CARTAO
            IF loc_lnResCartao = 1
                IF !(loc_lnOptQuebra = 1 AND EMPTY(loc_lcUsuario))
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "Select Sum(valos) As totcar From SigCdCtt " + ;
                        "Where dt_deposit Between ?lcDtInicial And ?lcDtFinal", "TmpCar")
                    IF loc_lnResult < 1
                        THIS.this_cMensagemErro = "Falha ao consultar SigCdCtt (Cartao)"
                        MsgErro(THIS.this_cMensagemErro, "Processar")
                        RETURN .F.
                    ENDIF
                    SELECT TmpCar
                    GO TOP
                    IF !EOF()
                        THIS.Cabecalho("RESUMO MOVIMENTACAO DE CARTAO", , , .F., loc_ldDtImp)
                        THIS.Linha(PADR("DEPOSITO", 20) + " :" + TRANSFORM(TmpCar.totcar, "999,999,999.99"), ;
                                   2, "", loc_ldDtImp)
                    ENDIF
                ENDIF

                SELECT CsCartaos
                SET ORDER TO IdCart
                SET KEY TO TmpUsuarios.usuarios
                GO TOP
                loc_lnTotCard = 0

                IF !EOF()
                    THIS.Cabecalho("RESUMO POR ADMINISTRADORA DE CARTAO", .F., TmpUsuarios.usuarios, .F., loc_ldDtImp)
                    SCAN
                        IF !EMPTY(CsCartaos.ntotecarts)
                            THIS.Linha(CsCartaos.cdcarts + "  :" + ;
                                       TRANSFORM(CsCartaos.ntotecarts, "9,999,999,999,999,999.99"), ;
                                       2, TmpUsuarios.usuarios, loc_ldDtImp)
                        ENDIF
                        IF !EMPTY(CsCartaos.ntotscarts)
                            THIS.Linha(CsCartaos.cdcarts + "  :" + ;
                                       TRANSFORM(CsCartaos.ntotscarts * -1, "9,999,999,999,999,999.99"), ;
                                       2, TmpUsuarios.usuarios, loc_ldDtImp)
                        ENDIF
                        loc_lnTotCard = loc_lnTotCard + (CsCartaos.ntotecarts - CsCartaos.ntotscarts)
                    ENDSCAN
                    THIS.Linha(SPACE(15) + IIF(!EMPTY(loc_lnTotCard), REPLICATE("-", 25), SPACE(25)), ;
                               2, TmpUsuarios.usuarios, loc_ldDtImp)
                    THIS.Linha(PADR(">TOTAL", 13) + " :" + ;
                               IIF(!EMPTY(loc_lnTotCard), TRANSFORM(loc_lnTotCard, "9,999,999,999,999,999.99"), SPACE(20)), ;
                               2, TmpUsuarios.usuarios, loc_ldDtImp)
                ENDIF
            ENDIF

            *-- RESUMO POR VENDEDOR
            IF loc_lnResVende = 1 AND !(loc_lnOptQuebra = 1 AND EMPTY(loc_lcUsuario))
                SELECT Comissao
                SET ORDER TO Vends
                GO TOP
                IF !EOF()
                    THIS.Cabecalho("RESUMO POR VENDEDOR", , , .F., loc_ldDtImp)
                    loc_lnTotCom = 0
                    loc_lnTotBco = 0
                    SCAN
                        THIS.Linha(PADR(vends, 14) + ":" + TRANSFORM(Comissao.valos, "9,999,999.99") + " " + ;
                                   TRANSFORM(Comissao.comis, "9,999,999.99"), 2, "", loc_ldDtImp)
                        loc_lnTotBco = loc_lnTotBco + Comissao.valos
                        loc_lnTotCom = loc_lnTotCom + Comissao.comis
                    ENDSCAN
                    IF loc_lnTotCom <> 0 OR loc_lnTotBco <> 0
                        THIS.Linha(SPACE(15) + REPLICATE("-", 12) + " " + REPLICATE("-", 12), 2, "", loc_ldDtImp)
                        THIS.Linha(PADR(">TOTAL", 14) + ":" + TRANSFORM(loc_lnTotBco, "9,999,999.99") + " " + ;
                                   TRANSFORM(loc_lnTotCom, "9,999,999.99"), 2, "", loc_ldDtImp)
                    ENDIF
                ENDIF

                SELECT ComiComp
                SET ORDER TO Vends
                GO TOP
                IF !EOF()
                    THIS.Cabecalho("RESUMO POR COMPRADOR", , , .F., loc_ldDtImp)
                    loc_lnTTotCom = 0
                    loc_lnTTotBco = 0
                    SCAN
                        THIS.Linha(PADR(vends, 14) + ":" + TRANSFORM(ComiComp.valos, "9,999,999.99") + " " + ;
                                   TRANSFORM(ComiComp.comis, "9,999,999.99"), 2, "", loc_ldDtImp)
                        loc_lnTTotBco = loc_lnTTotBco + ComiComp.valos
                        loc_lnTTotCom = loc_lnTTotCom + ComiComp.comis
                    ENDSCAN
                    IF loc_lnTTotCom <> 0 OR loc_lnTTotBco <> 0
                        THIS.Linha(SPACE(15) + REPLICATE("-", 12) + " " + REPLICATE("-", 12), 2, "", loc_ldDtImp)
                        THIS.Linha(PADR(">TOTAL", 14) + ":" + TRANSFORM(loc_lnTTotBco, "9,999,999.99") + " " + ;
                                   TRANSFORM(loc_lnTTotCom, "9,999,999.99"), 2, "", loc_ldDtImp)
                    ENDIF
                ENDIF
            ENDIF

            *-- RESUMO CONTA CORRENTE
            IF loc_lnResConta = 1 AND !(loc_lnOptQuebra = 1 AND EMPTY(loc_lcUsuario))
                THIS.Cabecalho("RESUMO CONTA CORRENTE", , , .F., loc_ldDtImp)
                IF USED("TmpMccr")
                    USE IN TmpMccr
                ENDIF
                FOR loc_lnCtMccr = 1 TO 2
                    loc_lcOperacao = IIF(loc_lnCtMccr = 1, "CAIXA", "BANCOS")
                    loc_lnResult = SQLEXEC(gnConnHandle, ;
                        "Select a.moedas,a.grupos,a.contas,a.datas,a.hists,a.docus," + ;
                        "a.valors,a.opers,a.saldos " + ;
                        "From SigMvCcr a " + ;
                        "Where " + IIF(!EMPTY(loc_lcCdMoeda), "a.moedas = '" + loc_lcCdMoeda + "' And ", "") + ;
                        "a.grupos = '" + loc_lcOperacao + "'" + ;
                        " And a.datas Between ?lcDtInicial And ?lcDtFinal" + ;
                        " Order By a.emps,a.contas,a.datas", "TmpMccr")
                    SELECT TmpMccr
                    GO TOP
                    DO WHILE !EOF()
                        loc_lcChave = TmpMccr.grupos + TmpMccr.contas + TmpMccr.moedas
                        THIS.Linha("* Grupo : " + ALLTRIM(TmpMccr.grupos) + " - Conta : " + ALLTRIM(TmpMccr.contas) + " *", ;
                                   2, "", loc_ldDtImp)
                        THIS.Linha(PADC("Data", 10) + " " + PADC("Valor", 12) + " " + PADC("O", 1) + " " + PADC("Saldo", 12), ;
                                   2, "", loc_ldDtImp)
                        THIS.Linha(REPLICATE("-", 10) + " " + REPLICATE("-", 12) + " " + REPLICATE("-", 1) + " " + REPLICATE("-", 12), ;
                                   2, "", loc_ldDtImp)
                        SCAN WHILE TmpMccr.grupos + TmpMccr.contas + TmpMccr.moedas = loc_lcChave
                            THIS.Linha(DTOC(datas) + " " + TRANSFORM(TmpMccr.valors, "9,999,999.99") + " " + ;
                                       TmpMccr.opers + " " + TRANSFORM(TmpMccr.saldos, "9,999,999.99"), ;
                                       2, "", loc_ldDtImp)
                        ENDSCAN
                        THIS.Linha(, 2, "", loc_ldDtImp)
                    ENDDO
                    THIS.Linha(, 2, "", loc_ldDtImp)
                ENDFOR
            ENDIF

            SELECT TmpUsuarios
            IF INLIST(1, loc_lnResLanca, loc_lnResCheque, loc_lnResCartao, loc_lnResConta, ;
                         loc_lnResVende, loc_lnResForma, loc_lnResLanFor, loc_lnResQtdes, loc_lnResVDets)
                THIS.Linha("", 2, TmpUsuarios.usuarios, loc_ldDtImp)
                THIS.Linha(1, 2, TmpUsuarios.usuarios, loc_ldDtImp)
            ENDIF
        ENDSCAN

        WAIT CLEAR

        *-- Detalhamento por vendedor (40 col, ResvDets=1)
        IF loc_lnOptCol = 1 AND loc_lnResVDets = 1
            SELECT dbRelIni
            GO TOP
            IF !EOF()
                THIS.RelIni2(loc_ldDtImp)
            ENDIF
        ENDIF

        SELECT &loc_lcArq.
        SET ORDER TO Usuars
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RelIni - Imprime cabecalho e detalhes de movimentacoes (por operacao)
    * Equivalente ao procedimento 'rel_ini' do formulario legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RelIni(par_dRelIni)
        LOCAL loc_lcArq, loc_lnTotValCal, loc_lcUserDopes, loc_lnImpNomCli
        LOCAL loc_lcCabecalho, loc_lcDetalhe, loc_lcEdn, loc_lnResult
        loc_lcArq        = IIF(THIS.this_lSegunda, "dbTmpRel2", "dbTmpRel")
        loc_lnTotValCal  = 0
        loc_lcUserDopes  = ""
        loc_lnImpNomCli  = THIS.this_nOptImpNomCli

        SELECT dbRelIni
        SET ORDER TO UsDop
        GO TOP
        DO WHILE !EOF()
            IF loc_lcUserDopes <> dbRelIni.usuars + dbRelIni.dopes
                loc_lnTotValCal  = 0
                loc_lcUserDopes = dbRelIni.usuars + dbRelIni.dopes
                SEEK dbRelIni.dopes ORDER TAG dopes IN CrSigCdOpe

                loc_lcCabecalho = PADR("[ " + ALLTRIM(CrSigCdOpe.dopes) + " ]", 80)
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcCabecalho, 1, dbRelIni.usuars, par_dRelIni)

                loc_lcCabecalho = PADC("C" + CHR(243) + "digo", 6) + " " + ;
                                  PADC("Data", 10) + " " + ;
                                  PADC("Docto.", 6) + " " + ;
                                  PADC("Pedido", 6) + " " + ;
                                  PADC("Valor", 14) + " " + ;
                                  PADC("Cliente", 10) + " "
                DO CASE
                    CASE (loc_lnImpNomCli = 1)
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Nome do Cliente", 25) + " "
                    CASE (loc_lnImpNomCli = 2)
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Observacao", 25) + " "
                    CASE (loc_lnImpNomCli = 3)
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Nome Cliente / Observacao", 25) + " "
                ENDCASE
                loc_lcCabecalho = loc_lcCabecalho + PADC("Vend.", 10) + " "
                DO CASE
                    CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.dfpags = 1
                        loc_lcCabecalho = loc_lcCabecalho + PADC("FP(%)", 6) + " "
                    CASE CrSigCdOpe.opcrs = 1
                        loc_lcCabecalho = loc_lcCabecalho + PADC(PROPER(LEFT(ALLTRIM(CrSigCdOpe.nopcrs), 14)), 14) + " "
                ENDCASE
                DO CASE
                    CASE INLIST(CrSigCdOpe.vars, 1, 6)
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Var(%)", 6) + " "
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Vlr.Var.", 10)
                    CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.deacrs = 1
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Des(%)", 6) + " "
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Vlr.Desc.", 10) + " "
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Acr(%)", 6) + " "
                        loc_lcCabecalho = loc_lcCabecalho + PADC("Vlr.Acres.", 10)
                ENDCASE
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcCabecalho, 1, dbRelIni.usuars, par_dRelIni)

                loc_lcCabecalho = REPLICATE("-", 6) + " " + REPLICATE("-", 10) + " " + ;
                                  REPLICATE("-", 6) + " " + REPLICATE("-", 6) + " " + ;
                                  REPLICATE("-", 14) + " " + REPLICATE("-", 10) + " " + ;
                                  REPLICATE("-", 25) + " " + REPLICATE("-", 10) + " "
                DO CASE
                    CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.dfpags = 1
                        loc_lcCabecalho = loc_lcCabecalho + REPLICATE("-", 6) + " "
                    CASE CrSigCdOpe.opcrs = 1
                        loc_lcCabecalho = loc_lcCabecalho + REPLICATE("-", 14) + " "
                ENDCASE
                DO CASE
                    CASE INLIST(CrSigCdOpe.vars, 1, 6)
                        loc_lcCabecalho = loc_lcCabecalho + REPLICATE("-", 6) + " " + REPLICATE("-", 10)
                    CASE CrSigCdOpe.vendas = 1 AND CrSigCdOpe.deacrs = 1
                        loc_lcCabecalho = loc_lcCabecalho + REPLICATE("-", 6) + " " + ;
                                          REPLICATE("-", 10) + " " + REPLICATE("-", 6) + " " + REPLICATE("-", 10)
                ENDCASE
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcCabecalho, 1, dbRelIni.usuars, par_dRelIni)
            ENDIF

            loc_lcDetalhe = THIS.GerMascara(dbRelIni.numes) + " " + ;
                            DTOC(dbRelIni.datas) + " " + ;
                            dbRelIni.notas + " " + ;
                            PADL(IIF(dbRelIni.nPedClis = 0, [], STR(dbRelIni.nPedClis)), 6) + " " + ;
                            TRANSFORM(dbRelIni.totas, "999,999,999.99") + " " + ;
                            dbRelIni.conta + " " + ;
                            NVL(dbRelIni.obses, SPACE(25)) + " " + ;
                            dbRelIni.vends + " " + ;
                            dbRelIni.det + " "
            INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)

            IF (THIS.this_nChkDetLan = 1)
                loc_lcEdn   = dbRelIni.Emps + dbRelIni.Dopes + STR(dbRelIni.Numes, 6)
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "Select Codbarras,CPros,DPros,Opers,Totas From SigMvItn Where EmpDopNums = '" + loc_lcEdn + "'", ;
                    "LocalItems")
                IF loc_lnResult > 0
                    SELECT LocalItems
                    SCAN
                        loc_lcDetalhe = SPACE(5) + LocalItems.Opers + " " + LocalItems.CPros + " " + ;
                                        STR(LocalItems.Codbarras, 9) + " " + ;
                                        STR(LocalItems.Totas, 14, 2) + " " + LocalItems.DPros
                        INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                            VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)
                    ENDSCAN
                    IF USED("LocalItems")
                        USE IN LocalItems
                    ENDIF
                ENDIF
                loc_lnResult = SQLEXEC(gnConnHandle, ;
                    "Select FPags,Sum(Valos) as Valos,TParcs From SigMvPar " + ;
                    "Where EmpDopNums = '" + loc_lcEdn + "' Group By FPags,TParcs Order By FPags,TParcs", ;
                    "LocalItems")
                IF loc_lnResult > 0
                    SELECT LocalItems
                    SCAN
                        loc_lcDetalhe = SPACE(7) + LocalItems.Fpags + SPACE(10) + ;
                                        PADL(MAX(LocalItems.TParcs, 1), 2, "0") + " " + ;
                                        STR(LocalItems.Valos, 14, 2)
                        INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                            VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)
                    ENDSCAN
                    IF USED("LocalItems")
                        USE IN LocalItems
                    ENDIF
                ENDIF
            ENDIF

            SELECT dbRelIni
            loc_lnTotValCal = loc_lnTotValCal + dbRelIni.totas
            SKIP
            IF EOF() OR loc_lcUserDopes <> dbRelIni.usuars + dbRelIni.dopes
                SKIP -1
                loc_lcDetalhe = SPACE(32) + REPLICATE("-", 14)
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)
                loc_lcDetalhe = SPACE(32) + TRANSFORM(loc_lnTotValCal, "999,999,999.99")
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (SPACE(80), 1, dbRelIni.usuars, par_dRelIni)
                SKIP
            ENDIF
        ENDDO

        SELECT &loc_lcArq.
    ENDPROC

    *--------------------------------------------------------------------------
    * RelIni2 - Imprime detalhamento de movimentacoes por vendedor
    * Equivalente ao procedimento 'rel_ini2' do formulario legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RelIni2(par_dRelIni)
        LOCAL loc_lcArq, loc_lnTotValCal, loc_lcUserDopes, loc_lcCabecalho, loc_lcDetalhe
        loc_lcArq       = IIF(THIS.this_lSegunda, "dbTmpRel2", "dbTmpRel")
        loc_lnTotValCal = 0
        loc_lcUserDopes = ""

        SELECT dbRelIni
        SET ORDER TO Vendedor
        GO TOP
        DO WHILE !EOF()
            IF loc_lcUserDopes <> dbRelIni.usuars + dbRelIni.Vends
                loc_lnTotValCal = 0
                loc_lcUserDopes = dbRelIni.usuars + dbRelIni.Vends
                THIS.Cabecalho("DETALHADO POR VENDEDOR:" + ALLTRIM(dbRelIni.Vends), ;
                               .F., IIF(USED("TmpUsuarios"), TmpUsuarios.usuarios, ""), .F., { })

                loc_lcCabecalho = PADC("Opera" + CHR(231) + CHR(227) + "o", 10) + " " + ;
                                  PADC("Cliente", 10) + " " + ;
                                  PADC("Valor", 14) + " "
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcCabecalho, 1, dbRelIni.usuars, par_dRelIni)

                loc_lcCabecalho = REPLICATE("-", 10) + " " + REPLICATE("-", 10) + " " + REPLICATE("-", 14) + " "
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (loc_lcCabecalho, 1, dbRelIni.usuars, par_dRelIni)
            ENDIF

            loc_lcDetalhe = dbRelIni.Abrevs + " " + ;
                            THIS.GerMascara(dbRelIni.numes) + " " + ;
                            dbRelIni.conta + " " + ;
                            TRANSFORM(dbRelIni.totas, "999,999,999.99") + " "
            INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                VALUES (loc_lcDetalhe, 1, dbRelIni.usuars, par_dRelIni)
            SELECT dbRelIni
            SKIP
        ENDDO

        SELECT &loc_lcArq.
    ENDPROC

    *--------------------------------------------------------------------------
    * Linha - Insere uma linha de texto no cursor de saida do relatorio
    * Equivalente ao metodo 'Linha' do formulario legado.
    * par_Linha: texto (C), numero (N=separator), logico/indefinido (blank)
    * par_nTipo: tipo da linha (1=detalhe, 2=cabecalho)
    * par_cUsuarios: identificador do usuario
    * par_dDatas: data da linha
    *--------------------------------------------------------------------------
    PROCEDURE Linha(par_Linha, par_nTipo, par_cUsuarios, par_dDatas)
        LOCAL loc_lcArq, loc_lcDetalhe
        loc_lcArq = IIF(THIS.this_lSegunda, "dbTmpRel2", "dbTmpRel")

        IF TYPE("par_cUsuarios") <> "C"
            par_cUsuarios = ""
        ENDIF

        DO CASE
            CASE TYPE("par_Linha") = "U" OR TYPE("par_Linha") = "L"
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (SPACE(THIS.this_nMaxCols), par_nTipo, par_cUsuarios, par_dDatas)
            CASE TYPE("par_Linha") = "N"
                INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                    VALUES (REPLICATE("=", THIS.this_nMaxCols), par_nTipo, par_cUsuarios, par_dDatas)
            CASE TYPE("par_Linha") = "C"
                IF EMPTY(par_Linha)
                    INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                        VALUES (SPACE(THIS.this_nMaxCols), par_nTipo, par_cUsuarios, par_dDatas)
                ELSE
                    INSERT INTO &loc_lcArq. (detalhe, tipo, usuars, datas) ;
                        VALUES (LEFT(PADR(par_Linha, THIS.this_nMaxCols), THIS.this_nMaxCols), ;
                                par_nTipo, par_cUsuarios, par_dDatas)
                ENDIF
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * Cabecalho - Insere um bloco de cabecalho de secao no relatorio
    * Equivalente ao metodo 'Cabecalho' do formulario legado.
    *--------------------------------------------------------------------------
    PROCEDURE Cabecalho(par_cDetalhe, par_lSemLinha, par_cUsuarios, par_lQtde, par_dDtCab)
        THIS.Linha("", 2, par_cUsuarios, par_dDtCab)
        THIS.Linha(1, 2, par_cUsuarios, par_dDtCab)
        IF par_lQtde
            THIS.Linha(PADC(" " + ALLTRIM(par_cDetalhe) + " ", 48, "*"), 2, par_cUsuarios, par_dDtCab)
        ELSE
            THIS.Linha(PADC(" " + ALLTRIM(par_cDetalhe) + " ", 40, "*"), 2, par_cUsuarios, par_dDtCab)
        ENDIF
        IF !par_lSemLinha
            THIS.Linha("", 2, par_cUsuarios, par_dDtCab)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao de uma moeda na data informada
    * Busca em CrSigCdCot pelo par cmoes+data. Retorna 1 se nao encontrado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCot, loc_lcMoeda
        loc_nCot   = 1
        loc_lcMoeda = PADR(ALLTRIM(NVL(par_cMoeda, "")), 3)
        IF USED("CrSigCdCot") AND !EMPTY(ALLTRIM(par_cMoeda))
            SELECT CrSigCdCot
            SET ORDER TO cmoedata
            IF SEEK(loc_lcMoeda + DTOS(par_dData), "CrSigCdCot", "cmoedata")
                loc_nCot = CrSigCdCot.valos
            ENDIF
        ENDIF
        RETURN IIF(loc_nCot = 0, 1, loc_nCot)
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCambio - Busca cotacao mais recente de uma moeda ate a data limite
    * Usado para taxa mensal (JurMes). Retorna 0 se nao encontrado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarCambio(par_cMoeda, par_dFim)
        LOCAL loc_nCot, loc_lcMoeda, loc_llAchado
        loc_nCot    = 0
        loc_llAchado = .F.
        loc_lcMoeda = PADR(ALLTRIM(NVL(par_cMoeda, "")), 3)
        IF USED("CrSigCdCot") AND !EMPTY(ALLTRIM(par_cMoeda))
            SELECT CrSigCdCot
            SET ORDER TO cmoedata
            SET NEAR ON
            SEEK loc_lcMoeda + DTOS(par_dFim)
            SET NEAR OFF
            IF !EOF() AND LEFT(CrSigCdCot.cmoes, 3) = loc_lcMoeda
                loc_nCot    = CrSigCdCot.valos
                loc_llAchado = .T.
            ENDIF
            IF !loc_llAchado
                GO TOP
                SCAN FOR LEFT(CrSigCdCot.cmoes, 3) = loc_lcMoeda
                    loc_nCot    = CrSigCdCot.valos
                    loc_llAchado = .T.
                    EXIT
                ENDSCAN
            ENDIF
        ENDIF
        RETURN loc_nCot
    ENDPROC

    *--------------------------------------------------------------------------
    * GerMascara - Formata numero de documento como string de 6 posicoes
    * Equivalente a fGerMascara() do formulario legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerMascara(par_nNumes)
        RETURN STR(par_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * VerTpPag - Retorna tipo de pagamento baseado no campo Infos de SigOpFp
    * Equivalente a fVerTpPag() do formulario legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerTpPag(par_cInfos)
        RETURN PADR(ALLTRIM(NVL(par_cInfos, "")), 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptcol = 1
                    loc_cFrx = gc_4c_CaminhoReports + THIS.this_cArquivoFRX1
                    REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE IN SCREEN ;
                        TO FILE SYS(2023) + "\Nul.txt"
                ELSE
                    loc_cFrx = gc_4c_CaminhoReports + THIS.this_cArquivoFRX2
                    REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                ENDIF
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio
    * 40 col: impressao direta em impressora matricial via ???
    * 80 col: dialogo de impressao com REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro, loc_lnResult
        LOCAL loc_lnImpress, loc_lcLastUsuar, loc_llEncontrou, loc_lnEtqImpres
        LOCAL loc_pTip, loc_lcSQLCmd, loc_lcSql, loc_llFlags, loc_lcImpres
        LOCAL loc_lnI, loc_cFrx
        loc_lSucesso   = .F.
        loc_lnImpress  = 0
        loc_llEncontrou = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = loc_lSucesso
            ENDIF

            IF THIS.this_nOptcol = 1
                *-- Impressao matricial (40 colunas)
                loc_lnEtqImpres = 0
                IF (APRINTERS(gaPrinters) = 0)
                    MsgAviso("O Painel de Controle N" + CHR(227) + "o Possui Impressoras Configuradas!!!", "Impress" + CHR(227) + "o")
                    IF USED("dbRelatorio")
                        USE IN dbRelatorio
                    ENDIF
                    loc_lSucesso = loc_lSucesso
                ENDIF

                loc_pTip = 1
                loc_lcSQLCmd = "Select * From SigCdmp Where nTpImpres = ?loc_pTip"
                loc_lnResult = SQLEXEC(gnConnHandle, loc_lcSQLCmd, "Tmp1")
                IF loc_lnResult < 1
                    MsgErro("Favor Reinicializar o Processo!!! (SigCdmp)", "Imprimir")
                    IF USED("dbRelatorio")
                        USE IN dbRelatorio
                    ENDIF
                    loc_lSucesso = loc_lSucesso
                ENDIF

                loc_llFlags = .F.
                SELECT *, loc_llFlags AS lMarcas, loc_llFlags AS lSituas ;
                    FROM Tmp1 ;
                    INTO CURSOR csSigCdmp READWRITE
                USE IN Tmp1

                SELECT csSigCdmp
                INDEX ON Impres TAG Imprime FOR (lSituas = .T.)
                INDEX ON Impres TAG Impres
                GO TOP IN csSigCdmp

                loc_lcSql = "Select b.* From SigSyImp a, SigCdmp b Where a.UsuAcess = '" + ;
                            ALLTRIM(gc_4c_UsuarioLogado) + "' And a.cImps = b.Impres And b.nTpImpres = ?loc_pTip " + ;
                            "Union all " + ;
                            "Select c.* From SigCdAcG a, SigSyImp b, SigCdmp c Where a.Usuarios='" + ;
                            ALLTRIM(gc_4c_UsuarioLogado) + "' " + ;
                            "And a.Grupos = b.GrAcess And b.Cimps = c.Impres And c.nTpImpres = ?loc_pTip"
                IF SQLEXEC(gnConnHandle, loc_lcSql, "CrTmpCimp") > 0
                    SELECT CrTmpCimp
                    IF RECCOUNT() > 0
                        loc_llFlags = .F.
                        SELECT DISTINCT Impres FROM CrTmpCimp INTO CURSOR LocalcImp READWRITE
                        SELECT *, loc_llFlags AS lMarcas, loc_llFlags AS lSituas ;
                            FROM LocalcImp ;
                            INTO CURSOR csSigCdmp READWRITE
                        SELECT csSigCdmp
                        INDEX ON Impres TAG Imprime FOR (lSituas = .T.)
                        INDEX ON Impres TAG Impres
                        GO TOP IN csSigCdmp
                        IF USED("LocalcImp")
                            USE IN LocalcImp
                        ENDIF
                    ENDIF
                    IF USED("CrTmpCimp")
                        USE IN CrTmpCimp
                    ENDIF
                ENDIF

                FOR loc_lnI = 1 TO APRINTERS(gaPrinters)
                    loc_lcImpres = UPPER(gaPrinters(loc_lnI, 1))
                    IF SEEK(loc_lcImpres, "csSigCdmp", "Impres")
                        loc_lnEtqImpres = loc_lnEtqImpres + 1
                        SELECT csSigCdmp
                        REPLACE lMarcas WITH .T., lSituas WITH .T.
                    ENDIF
                ENDFOR

                IF loc_lnEtqImpres = 0
                    MsgAviso("Nenhuma Impressora Matricial Est" + CHR(225) + " Configurada no" + CHR(13) + ;
                             "Painel de Controle.  Contate o Suporte T" + CHR(233) + "cnico.", ;
                             "Sem Impressora Configurada")
                    IF USED("csSigCdmp")
                        USE IN csSigCdmp
                    ENDIF
                    IF USED("dbRelatorio")
                        USE IN dbRelatorio
                    ENDIF
                    loc_lSucesso = loc_lSucesso
                ENDIF

                IF loc_lnEtqImpres > 1
                    DO FORM SigOpIpB
                ENDIF

                SELECT csSigCdmp
                LOCATE FOR lSituas

                SET PRINTER TO NAME (ALLTRIM(csSigCdmp.impres))
                SET DEVICE TO PRINTER
                ???  CHR(13) + CHR(10)

                loc_lcLastUsuar = SPACE(10)
                SELECT dbRelatorio
                SCAN
                    IF dbRelatorio.usuars <> loc_lcLastUsuar AND !EMPTY(loc_lcLastUsuar) AND loc_lnImpress <> 1
                        ???  CHR(12)
                    ENDIF
                    ???  dbRelatorio.detalhe + CHR(13) + CHR(10)
                    loc_lcLastUsuar = dbRelatorio.Usuars
                ENDSCAN
                ???  CHR(13) + CHR(10)
                ???  CHR(13) + CHR(10)
                ???  CHR(13) + CHR(10)
                ???  CHR(13) + CHR(10)
                SET DEVICE TO SCREEN
                SET PRINTER TO DEFAULT

                IF USED("csSigCdmp")
                    USE IN csSigCdmp
                ENDIF
            ELSE
                *-- 80 colunas: dialogo de impressao
                loc_cFrx = gc_4c_CaminhoReports + THIS.this_cArquivoFRX2
                REPORT FORM (loc_cFrx) TO PRINT PROMPT NOCONSOLE
            ENDIF

            IF USED("dbRelatorio")
                USE IN dbRelatorio
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
            IF USED("dbRelatorio")
                USE IN dbRelatorio
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta relatorio para arquivo texto
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptcol = 1
                    loc_cFrx = gc_4c_CaminhoReports + THIS.this_cArquivoFRX1
                ELSE
                    loc_cFrx = gc_4c_CaminhoReports + THIS.this_cArquivoFRX2
                ENDIF
                loc_cArquivo = SYS(5) + CURDIR() + "SigReFcX_" + ;
                    STRTRAN(DTOC(DATE()), "/", "") + ".txt"
                REPORT FORM (loc_cFrx) TO FILE &loc_cArquivo NOPREVIEW NOCONSOLE ASCII
                IF FILE(loc_cArquivo)
                    MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                ENDIF
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor inv" + CHR(225) + "lido ou n" + CHR(227) + "o aberto"
            ELSE
                SELECT (par_cAliasCursor)
                IF !EOF()
                    IF TYPE("dDtInicial") = "D"
                        THIS.this_dDtInicial = NVL(dDtInicial, DATE())
                    ENDIF
                    IF TYPE("dDtFinal") = "D"
                        THIS.this_dDtFinal = NVL(dDtFinal, DATE())
                    ENDIF
                    IF TYPE("cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(NVL(cCdEmpresa, ""))
                    ENDIF
                    IF TYPE("cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(NVL(cDsEmpresa, ""))
                    ENDIF
                    IF TYPE("cCdMoeda") = "C"
                        THIS.this_cCdMoeda = ALLTRIM(NVL(cCdMoeda, ""))
                    ENDIF
                    IF TYPE("cDsMoeda") = "C"
                        THIS.this_cDsMoeda = ALLTRIM(NVL(cDsMoeda, ""))
                    ENDIF
                    IF TYPE("cUsuario") = "C"
                        THIS.this_cUsuario = ALLTRIM(NVL(cUsuario, ""))
                    ENDIF
                    IF TYPE("nOptcol") = "N"
                        THIS.this_nOptcol = NVL(nOptcol, 1)
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a BO de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o Inserir n" + CHR(227) + "o se aplica a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a BO de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o Atualizar n" + CHR(227) + "o se aplica a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

ENDDEFINE

