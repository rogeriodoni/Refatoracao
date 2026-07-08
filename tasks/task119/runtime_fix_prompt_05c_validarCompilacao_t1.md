# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05c_validarCompilacao
- Tentativa: 1/10
- Mensagem: C:\4c\projeto\app\classes\SigReIfvBO.prg: SEEK("O" + m.Ocorrencia, "CrSigBaOco", "TipCods") | Error in line 458: Function name is missing ). | SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes") | Error in line 467: Function name is missing ). | SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes") | Error in line 596: Function name is missing ). | SEEK("O" + Tratamento.Ocorrencia, "CrSigBaOco", "TipCods") | Error in line 744: Function name is missing ). | 

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReIfv.prg):
*==============================================================================
* FORMSIGREIFV.PRG
* Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIFV.SCX (frmrelatorio)
*
* Original: Width=800, Height=424
* Filtros:
*   - Tipo (Anal" + CHR(237) + "tico / Sint" + CHR(233) + "tico / Consulta Barra)
*   - Empresa (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - Data Base (MM/YYYY)
*   - Data Base Anterior (MM/YYYY) - apenas tipo Sint" + CHR(233) + "tico
*   - Moeda (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - Grupo de Estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - Conta de Estoque (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o)
*   - N" + CHR(250) + "mero de Barra/Etiqueta - apenas tipo Consulta Barra
*   - Grid de empresas com CheckBox de sele" + CHR(231) + CHR(227) + "o - apenas tipo Sint" + CHR(233) + "tico
*
* FASE 7/8 - Eventos Principais (COMPLETO)
*   * Propriedades visuais do form (exatas do original)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo)
*   * ConfigurarBotoes() (Visualizar / Imprimir / Excel / Encerrar)
*   * ConfigurarPageFrame() (PageFrame com 1 p" + CHR(225) + "gina - "Filtros")
*   * ConfigurarPaginaLista() - filtros, grid empresas, bot" + CHR(245) + "es Sel/Desel
*   * ConfigurarPaginaDados() - BINDEVENTs de todos os campos e bot" + CHR(245) + "es
*   * Validar*/Abrir*/Tecla* - handlers de lookup para todos os campos
*   * AjustarVisibilidadePorTipo() - oculta/exibe controles por tipo
*   * FormParaRelatorio() - transfere filtros para o BO
*   * ValidarFiltros() - valida campos obrigat" + CHR(243) + "rios antes de gerar
*   * BtnVisualizarClick() / BtnImprimirClick() / BtnExcelClick() / BtnEncerrarClick()
*   * CmdSelempClick() / CmdApgEmpClick() - marcar/desmarcar empresas no grid
*==============================================================================

DEFINE CLASS FormSigReIfv AS FormBase

    *-- Dimens" + CHR(245) + "es e apar" + CHR(234) + "ncia (EXATAS do original: Width=800, Height=424)
    Height      = 424
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
    *   2. Cria SigReIfvBO e carrega cursores auxiliares (pula em modo UI)
    *   3. Monta cabe" + CHR(231) + "alho escuro + bot" + CHR(245) + "es do relat" + CHR(243) + "rio + PageFrame
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO do relat" + CHR(243) + "rio
            THIS.this_oRelatorio = CREATEOBJECT("SigReIfvBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReIfvBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar cursores auxiliares (CrSigCdEmp, CsBases, etc.)
            *   Equivalente ao Init() original que fazia SqlExecute de SigCdEmp.
            *   Pulado em modo de valida" + CHR(231) + CHR(227) + "o de UI (sem conex" + CHR(227) + "o SQL).
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.CarregarDadosAuxiliares()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabe" + CHR(231) + "alho escuro com t" + CHR(237) + "tulo (equivalente a cntSombra)
                THIS.ConfigurarCabecalho()

                *-- Bot" + CHR(245) + "es do relat" + CHR(243) + "rio (Visualizar / Imprimir / Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame com p" + CHR(225) + "gina de filtros
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

                *-- BINDEVENTs dos campos de filtro (primeira metade: empresa, datas)
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

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
                .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
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
                .Caption   = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"
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
    *   Original: btnReport.Left=529, Height=80, Width=273
    *   Bot" + CHR(245) + "es: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
    *   Eventos Click vinculados em ConfigurarPaginaDados() via BINDEVENT.
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

            *-- Encerrar (fechar form - ESC)
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
    *   Posicionado logo abaixo do cabe" + CHR(231) + "alho (80px) at" + CHR(233) + " o fim do form.
    *   Os campos de filtro s" + CHR(227) + "o adicionados em ConfigurarPaginaLista() (Fase 4+).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho ate o fim do form
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
    * ConfigurarPaginaLista - Adiciona campos de filtro e grid de empresas
    *   Equivalente aos controles diretos do form original (SIGREIFV):
    *   optGtprel, campos empresa/data/moeda/grupo/conta/barra, GrdEmp
    *   Posicoes calculadas: Original_Top - 80 (PageFrame inicia em Top=85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPag, loc_oGrd
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- OptionGroup Tipo: Anal" + CHR(237) + "tico(1) / Sint" + CHR(233) + "tico(2) / Consulta Barra(3)
        *   Original: Top=84, Left=161, Width=247, Height=27, ButtonCount=3
        loc_oPag.AddObject("obj_4c_OptGtprel", "OptionGroup")
        WITH loc_oPag.obj_4c_OptGtprel
            .Top         = 5
            .Left        = 161
            .Width       = 247
            .Height      = 27
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.

            WITH .Buttons(1)
                .Caption  = "Anal" + CHR(237) + "tico"
                .Width    = 80
                .Left     = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Sint" + CHR(233) + "tico"
                .Width    = 80
                .Left     = 83
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
            WITH .Buttons(3)
                .Caption  = "Consulta Barra"
                .Width    = 84
                .Left     = 163
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Label "Tipo :" (Say2 original: Top=90, Left=131)
        loc_oPag.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPag.lbl_4c_Label2
            .Top       = 10
            .Left      = 131
            .Width     = 29
            .Height    = 18
            .Caption   = "Tipo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Barra :" (Label4 original: Top=114, Left=125) - Tipo=3 only
        loc_oPag.AddObject("lbl_4c_Barra", "Label")
        WITH loc_oPag.lbl_4c_Barra
            .Top       = 29
            .Left      = 125
            .Width     = 35
            .Height    = 15
            .Caption   = "Barra :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Campo N" + CHR(250) + "mero de Barra/Etiqueta (GetiBarra original: Top=110, Left=164, Width=67)
        *   When original: OptGtpRel.Value = 3
        loc_oPag.AddObject("txt_4c_IBarra", "TextBox")
        WITH loc_oPag.txt_4c_IBarra
            .Top      = 25
            .Left     = 164
            .Width    = 67
            .Height   = 23
            .Value    = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .F.
        ENDWITH

        *-- Label "Empresa :" (Say3 original: Top=139, Left=110) - Tipo=1 e Tipo=3
        loc_oPag.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPag.lbl_4c_Label3
            .Top       = 59
            .Left      = 110
            .Width     = 52
            .Height    = 18
            .Caption   = "Empresa :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo c" + CHR(243) + "digo da Empresa (Get_Empresa original: Top=135, Left=164, Width=33)
        *   When original: InList(OptGtpRel.Value, 1, 3)
        loc_oPag.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPag.txt_4c_Empresa
            .Top       = 55
            .Left      = 164
            .Width     = 33
            .Height    = 23
            .Value     = ""
            .InputMask = "XXX"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Campo descri" + CHR(231) + CHR(227) + "o da Empresa (Get_Dempresa: Top=135, Left=197, Width=205)
        *   When original: Empty(Get_Empresa.Value)
        loc_oPag.AddObject("txt_4c_Dempresa", "TextBox")
        WITH loc_oPag.txt_4c_Dempresa
            .Top      = 55
            .Left     = 197
            .Width    = 205
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Data Base:" (Say1 original: Top=164, Left=105)
        loc_oPag.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPag.lbl_4c_Label1
            .Top       = 84
            .Left      = 105
            .Width     = 57
            .Height    = 18
            .Caption   = "Data Base:"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo Data Base MM/YYYY (Get_DtBase original: Top=160, Left=164, Width=59)
        *   Busca em CsBases (datas base dispon" + CHR(237) + "veis no sistema)
        *   Formato: MM/AAAA conforme Right(value,4)+Left(value,2) no c" + CHR(243) + "digo original
        loc_oPag.AddObject("txt_4c_DtBase", "TextBox")
        WITH loc_oPag.txt_4c_DtBase
            .Top       = 80
            .Left      = 164
            .Width     = 59
            .Height    = 23
            .Value     = ""
            .InputMask = "99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Label "Data Base Anterior :" (Say4 original: Top=164, Left=267) - Tipo=2 only
        loc_oPag.AddObject("lbl_4c_DtBaseAnt", "Label")
        WITH loc_oPag.lbl_4c_DtBaseAnt
            .Top       = 84
            .Left      = 267
            .Width     = 100
            .Height    = 18
            .Caption   = "Data Base Anterior :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .F.
        ENDWITH

        *-- Campo Data Base Anterior MM/YYYY (Get_dtBasea original: Top=160, Left=370, Width=59)
        *   When original: OptGtpRel.Value = 2 (Tipo Sint" + CHR(233) + "tico)
        loc_oPag.AddObject("txt_4c_DtBasea", "TextBox")
        WITH loc_oPag.txt_4c_DtBasea
            .Top       = 80
            .Left      = 370
            .Width     = 59
            .Height    = 23
            .Value     = ""
            .InputMask = "99/9999"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .F.
        ENDWITH

        *-- Label "Moeda :" (lbl_moeda original: Top=189, Left=119, Width=41)
        loc_oPag.AddObject("lbl_4c_Lbl_moeda", "Label")
        WITH loc_oPag.lbl_4c_Lbl_moeda
            .Top       = 109
            .Left      = 119
            .Width     = 41
            .Height    = 18
            .Caption   = "Moeda :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo c" + CHR(243) + "digo da Moeda (get_cd_moeda original: Top=185, Left=164, Width=31)
        *   When original: InList(OptGtpRel.Value, 1, 2)
        loc_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
        WITH loc_oPag.txt_4c__cd_moeda
            .Top      = 105
            .Left     = 164
            .Width    = 31
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Campo descri" + CHR(231) + CHR(227) + "o da Moeda (get_ds_moeda original: Top=185, Left=197, Width=115)
        *   When original: Empty(get_cd_moeda.Value) AND InList(OptGtpRel.Value, 1, 2)
        loc_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
        WITH loc_oPag.txt_4c__ds_moeda
            .Top      = 105
            .Left     = 197
            .Width    = 115
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Grupo  :" (Say5 original: Top=215, Left=119, Width=41)
        loc_oPag.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPag.lbl_4c_Label5
            .Top       = 135
            .Left      = 119
            .Width     = 41
            .Height    = 15
            .Caption   = "Grupo  :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo c" + CHR(243) + "digo do Grupo de Estoque (get_Cd_GrEstoque: Top=210, Left=164, Width=80)
        loc_oPag.AddObject("txt_4c__Cd_GrEstoque", "TextBox")
        WITH loc_oPag.txt_4c__Cd_GrEstoque
            .Top      = 130
            .Left     = 164
            .Width    = 80
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Campo descri" + CHR(231) + CHR(227) + "o do Grupo de Estoque (get_Ds_GrEstoque: Top=210, Left=246, Width=290)
        *   When original: Empty(get_Cd_GrEstoque.Value)
        loc_oPag.AddObject("txt_4c__Ds_GrEstoque", "TextBox")
        WITH loc_oPag.txt_4c__Ds_GrEstoque
            .Top      = 130
            .Left     = 246
            .Width    = 290
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Label "Conta :" (Say7 original: Top=242, Left=122, Width=38)
        loc_oPag.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPag.lbl_4c_Label7
            .Top       = 162
            .Left      = 122
            .Width     = 38
            .Height    = 15
            .Caption   = "Conta :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Campo c" + CHR(243) + "digo da Conta de Estoque (Get_Cd_Estoque: Top=237, Left=164, Width=80)
        loc_oPag.AddObject("txt_4c_Cd_Estoque", "TextBox")
        WITH loc_oPag.txt_4c_Cd_Estoque
            .Top      = 157
            .Left     = 164
            .Width    = 80
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Campo descri" + CHR(231) + CHR(227) + "o da Conta de Estoque (Get_Ds_Estoque: Top=237, Left=246, Width=290)
        *   When original: Empty(Get_Cd_Estoque.Value)
        loc_oPag.AddObject("txt_4c_Ds_Estoque", "TextBox")
        WITH loc_oPag.txt_4c_Ds_Estoque
            .Top      = 157
            .Left     = 246
            .Width    = 290
            .Height   = 25
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Grid de sele" + CHR(231) + CHR(227) + "o de Empresas (GrdEmp original: Top=266, Left=163, W=342, H=147)
        *   3 colunas: CheckBox(lMarca) | C" + CHR(243) + "d.(CEmps) | Nome da Empresa(DEmps)
        *   Vis" + CHR(237) + "vel apenas quando Tipo=2 (Sint" + CHR(233) + "tico)
        *   Ordem OBRIGAT" + CHR(211) + "RIA da Column1: AddObject(Check1) -> CurrentControl -> ControlSource
        loc_oPag.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPag.grd_4c_Dados
        WITH loc_oGrd
            .Top                = 186
            .Left               = 163
            .Width              = 342
            .Height             = 147
            .ColumnCount        = 3
            .FontName           = "Verdana"
            .FontSize           = 8
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .GridLineColor      = RGB(238, 238, 238)
            .BackColor          = RGB(255, 255, 255)
            .ForeColor          = RGB(90, 90, 90)
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .Visible            = .F.

            WITH .Column1
                .Width           = 25
                .Resizable       = .F.
                .Header1.Caption = ""
                .AddObject("Check1", "CheckBox")
                .Check1.Caption  = ""
                .Check1.Value    = 0
                .CurrentControl  = "Check1"
            ENDWITH

            WITH .Column2
                .Width           = 60
                .Resizable       = .F.
                .Header1.Caption = "C" + CHR(243) + "d."
            ENDWITH

            WITH .Column3
                .Width           = 250
                .Resizable       = .T.
                .Header1.Caption = "Nome da Empresa"
            ENDWITH
        ENDWITH

        *-- RecordSource e ControlSource ap" + CHR(243) + "s WITH (evita reset de cabe" + CHR(231) + "alhos)
        *   ControlSource da Column1 DEPOIS de CurrentControl (regra Error 1767)
        IF USED("CsSigCdEmp")
            loc_oGrd.RecordSource          = "CsSigCdEmp"
            loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
            loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
            loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
            loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
            loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
        ENDIF

        *-- Bot" + CHR(227) + "o Marcar Todas as Empresas (cmdSelemp original: Top=332, Left=508, W=40, H=40)
        loc_oPag.AddObject("cmd_4c_CmdSelemp", "CommandButton")
        WITH loc_oPag.cmd_4c_CmdSelemp
            .Top           = 252
            .Left          = 508
            .Width         = 40
            .Height        = 40
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText   = "Marcar Todas as Empresas"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .F.
        ENDWITH

        *-- Bot" + CHR(227) + "o Desmarcar Todas as Empresas (CmdApgEmp original: Top=372, Left=508, W=40, H=40)
        loc_oPag.AddObject("cmd_4c_CmdApgEmp", "CommandButton")
        WITH loc_oPag.cmd_4c_CmdApgEmp
            .Top           = 292
            .Left          = 508
            .Width         = 40
            .Height        = 40
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ToolTipText   = "Desmarcar Todas as Empresas"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarVisibilidadePorTipo - Exibe/oculta controles conforme tipo
    *   Tipo=1 (Anal" + CHR(237) + "tico)     : empresa, sem grid, sem barra, sem DtBaseAnt
    *   Tipo=2 (Sint" + CHR(233) + "tico)     : grid+bot" + CHR(245) + "es, sem empresa, com DtBaseAnt
    *   Tipo=3 (Consulta Barra): empresa, com campo barra, sem grid
    *   Chamado via BINDEVENT do obj_4c_OptGtprel.InteractiveChange (Fase 7)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarVisibilidadePorTipo()
        LOCAL loc_nTipo, loc_oPag
        loc_nTipo = THIS.pgf_4c_Paginas.Page1.obj_4c_OptGtprel.Value
        loc_oPag  = THIS.pgf_4c_Paginas.Page1

        IF loc_nTipo = 2
            loc_oPag.grd_4c_Dados.Visible     = .T.
            loc_oPag.cmd_4c_CmdApgEmp.Visible = .T.
            loc_oPag.cmd_4c_CmdSelemp.Visible = .T.
            loc_oPag.lbl_4c_Label3.Visible    = .F.
            loc_oPag.txt_4c_Empresa.Visible   = .F.
            loc_oPag.txt_4c_Dempresa.Visible  = .F.
            loc_oPag.lbl_4c_DtBaseAnt.Visible = .T.
            loc_oPag.txt_4c_DtBasea.Visible   = .T.
            loc_oPag.lbl_4c_Barra.Visible     = .F.
            loc_oPag.txt_4c_IBarra.Visible    = .F.
        ELSE
            loc_oPag.grd_4c_Dados.Visible     = .F.
            loc_oPag.cmd_4c_CmdApgEmp.Visible = .F.
            loc_oPag.cmd_4c_CmdSelemp.Visible = .F.
            loc_oPag.lbl_4c_Label3.Visible    = .T.
            loc_oPag.txt_4c_Empresa.Visible   = .T.
            loc_oPag.txt_4c_Dempresa.Visible  = .T.
            loc_oPag.lbl_4c_DtBaseAnt.Visible = .F.
            loc_oPag.txt_4c_DtBasea.Visible   = .F.
            loc_oPag.lbl_4c_Barra.Visible     = (loc_nTipo = 3)
            loc_oPag.txt_4c_IBarra.Visible    = (loc_nTipo = 3)
        ENDIF

        THIS.Refresh
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para a p" + CHR(225) + "gina especificada no PageFrame
    *   Este form tem 1 p" + CHR(225) + "gina (Filtros); m" + CHR(233) + "todo preparado para expans" + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *   BO " + CHR(233) + " objeto Custom - usar = .NULL. (NAO .Release())
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura BINDEVENTs dos campos de filtro
    *   Fase 5: OptGtprel, Empresa cod/desc, DtBase, DtBasea
    *   Fase 6 completa: Moeda, GrupoEstoque, ContaEstoque, IBarra, botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        *-- OptGtprel -> AjustarVisibilidadePorTipo (metodo PUBLIC)
        BINDEVENT(loc_oPag.obj_4c_OptGtprel, "InteractiveChange", ;
                  THIS, "AjustarVisibilidadePorTipo")

        *-- Empresa codigo: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_Empresa, "KeyPress", THIS, "TeclaEmpresa")

        *-- Empresa descricao: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_Dempresa, "KeyPress", THIS, "TeclaDEmpresa")

        *-- Data Base MM/YYYY: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_DtBase, "KeyPress", THIS, "TeclaDtBase")

        *-- Data Base Anterior MM/YYYY: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_DtBasea, "KeyPress", THIS, "TeclaDtBasea")

        *-- Moeda codigo: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c__cd_moeda, "KeyPress", THIS, "TeclaCdMoeda")

        *-- Moeda descricao: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c__ds_moeda, "KeyPress", THIS, "TeclaDsMoeda")

        *-- Grupo Estoque codigo: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c__Cd_GrEstoque, "KeyPress", THIS, "TeclaCdGrEstoque")

        *-- Grupo Estoque descricao: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c__Ds_GrEstoque, "KeyPress", THIS, "TeclaDsGrEstoque")

        *-- Conta Estoque codigo: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_Cd_Estoque, "KeyPress", THIS, "TeclaCdEstoque")

        *-- Conta Estoque descricao: ENTER(13)/TAB(9)/F4(115)
        BINDEVENT(loc_oPag.txt_4c_Ds_Estoque, "KeyPress", THIS, "TeclaDsEstoque")

        *-- Numero de Barra/Etiqueta: ENTER(13)/TAB(9) valida
        BINDEVENT(loc_oPag.txt_4c_IBarra, "KeyPress", THIS, "TeclaIBarra")

        *-- Botoes do CommandGroup: Visualizar / Imprimir / Excel / Encerrar
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")

        *-- Botoes de controle do grid de selecao de empresas (Tipo=2)
        BINDEVENT(loc_oPag.cmd_4c_CmdSelemp, "Click", THIS, "CmdSelempClick")
        BINDEVENT(loc_oPag.cmd_4c_CmdApgEmp, "Click", THIS, "CmdApgEmpClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos de filtro para estado inicial
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.obj_4c_OptGtprel.Value     = 1
        loc_oPag.txt_4c_IBarra.Value        = 0
        loc_oPag.txt_4c_Empresa.Value       = ""
        loc_oPag.txt_4c_Dempresa.Value      = ""
        loc_oPag.txt_4c_DtBase.Value        = ""
        loc_oPag.txt_4c_DtBasea.Value       = ""
        loc_oPag.txt_4c__cd_moeda.Value     = ""
        loc_oPag.txt_4c__ds_moeda.Value     = ""
        loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
        loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
        loc_oPag.txt_4c_Cd_Estoque.Value    = ""
        loc_oPag.txt_4c_Ds_Estoque.Value    = ""

        THIS.AjustarVisibilidadePorTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - KeyPress do campo codigo de empresa
    *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa em CrSigCdEmp e preenche Razas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_cCodigo
        loc_cCodigo = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_Empresa.Value)

        IF EMPTY(loc_cCodigo)
            THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ""
            RETURN
        ENDIF

        IF USED("CrSigCdEmp")
            SELECT CrSigCdEmp
            SET ORDER TO CEmps
            IF SEEK(loc_cCodigo)
                THIS.pgf_4c_Paginas.Page1.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
                RETURN
            ENDIF
        ENDIF

        THIS.AbrirBuscaEmpresa()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - FormBuscaAuxiliar Modo 1 para selecao de empresa
    *   Tabela: SigCdEmp | Cod: CEmps | Desc: Razas
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oBusca, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "CEmps", loc_cValor, ;
            "Empresa")

        IF VARTYPE(loc_oBusca) != "O"
            MsgErro("Erro ao abrir busca de empresas", "Erro")
            RETURN
        ENDIF

        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
            loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
            loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ELSE
            IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ENDIF
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDEmpresa - KeyPress do campo descricao de empresa
    *   F4(115)/ENTER(13)/TAB(9): busca empresa por Razas e preenche CEmps
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDEmpresa - Busca empresa por descricao (Razas) e preenche CEmps
    *   LOCATE em CrSigCdEmp; se nao achar, abre FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDEmpresa()
        LOCAL loc_cDesc, loc_oPag, loc_oBusca
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)

        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c_Empresa.Value  = ""
            loc_oPag.txt_4c_Dempresa.Value = ""
            RETURN
        ENDIF

        IF USED("CrSigCdEmp")
            SELECT CrSigCdEmp
            LOCATE FOR UPPER(ALLTRIM(Razas)) = UPPER(loc_cDesc)
            IF FOUND()
                loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(CrSigCdEmp.CEmps)
                loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(CrSigCdEmp.Razas)
                RETURN
            ENDIF
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cDesc, ;
            "Empresa")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
            loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
            loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
        ELSE
            IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("CEmps", "XXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Razas", "", "Empresa")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
                loc_oPag.txt_4c_Dempresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
            ENDIF
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtBase - KeyPress do campo Data Base (formato MM/YYYY)
    *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtBase(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDtBase("DtBase")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDtBase()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDtBase - Valida Data Base contra cursor CsBases (formato MM/YYYY)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDtBase()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value)

        IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ""
            RETURN
        ENDIF

        IF USED("CsBases")
            SELECT CsBases
            SET ORDER TO Bases
            IF SEEK(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.Value = ALLTRIM(CsBases.Bases)
                RETURN
            ENDIF
        ENDIF

        THIS.AbrirBuscaDtBase("DtBase")
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDtBase - FormBuscaAuxiliar Modo 2 sobre cursor CsBases
    *   par_cCampo: "DtBase" ou "DtBasea" para indicar qual campo preencher
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDtBase(par_cCampo)
        LOCAL loc_oBusca, loc_oPag, loc_cSel
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        IF !USED("CsBases")
            MsgAviso("Datas base n" + CHR(227) + "o carregadas.", "Busca")
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) != "O"
            MsgErro("Erro ao abrir busca de datas base", "Erro")
            RETURN
        ENDIF

        loc_oBusca.this_cCursorDestino = "CsBases"
        loc_oBusca.this_cTitulo        = "Data Base"
        loc_oBusca.mAddColuna("Bases", "XXXXXXXXXX", "Data Base")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("CsBases")
            loc_cSel = ALLTRIM(CsBases.Bases)
            IF par_cCampo = "DtBase"
                loc_oPag.txt_4c_DtBase.Value  = loc_cSel
            ELSE
                loc_oPag.txt_4c_DtBasea.Value = loc_cSel
            ENDIF
        ENDIF

        loc_oBusca.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDtBasea - KeyPress do campo Data Base Anterior (formato MM/YYYY)
    *   F4(115): abre lookup; ENTER(13)/TAB(9): valida no CsBases
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDtBasea(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDtBase("DtBasea")
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDtBasea()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDtBasea - Valida Data Base Anterior contra cursor CsBases (MM/YYYY)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDtBasea()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value)

        IF EMPTY(loc_cValor) OR loc_cValor = "  /    "
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ""
            RETURN
        ENDIF

        IF USED("CsBases")
            SELECT CsBases
            SET ORDER TO Bases
            IF SEEK(loc_cValor)
                THIS.pgf_4c_Paginas.Page1.txt_4c_DtBasea.Value = ALLTRIM(CsBases.Bases)
                RETURN
            ENDIF
        ENDIF

        THIS.AbrirBuscaDtBase("DtBasea")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdMoeda - KeyPress do campo codigo de moeda
    *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em CrSigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaMoeda()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdMoeda()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdMoeda - Valida codigo de moeda em CrSigCdMoe e preenche DMoes
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdMoeda()
        LOCAL loc_cCodigo, loc_oPag
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPag.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF

        IF USED("CrSigCdMoe")
            SELECT CrSigCdMoe
            SET ORDER TO CMoes
            IF SEEK(loc_cCodigo)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
                RETURN
            ENDIF
        ENDIF

        THIS.AbrirBuscaMoeda()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - FormBuscaAuxiliar para selecao de moeda
    *   Tabela: SigCdMoe | Cod: CMoes | Desc: DMoes
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaMoeda()
        LOCAL loc_oBusca, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
            "Moeda")

        IF VARTYPE(loc_oBusca) != "O"
            MsgErro("Erro ao abrir busca de moedas", "Erro")
            RETURN
        ENDIF

        IF loc_oBusca.this_lAchouRegistro
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ENDIF
        ELSE
            loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsMoeda - KeyPress do campo descricao de moeda
    *   F4(115)/ENTER(13)/TAB(9): busca moeda por DMoes e preenche CMoes
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsMoeda(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsMoeda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsMoeda - Busca moeda por descricao (DMoes) em CrSigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsMoeda()
        LOCAL loc_cDesc, loc_oPag, loc_oBusca
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)

        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__cd_moeda.Value = ""
            loc_oPag.txt_4c__ds_moeda.Value = ""
            RETURN
        ENDIF

        IF USED("CrSigCdMoe")
            SELECT CrSigCdMoe
            LOCATE FOR UPPER(ALLTRIM(DMoes)) = UPPER(loc_cDesc)
            IF FOUND()
                loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(CrSigCdMoe.CMoes)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(CrSigCdMoe.DMoes)
                RETURN
            ENDIF
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoe", "DMoes", loc_cDesc, ;
            "Moeda")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
            loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
            loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
        ELSE
            IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("CMoes", "XXXXXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
                loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.DMoes)
            ENDIF
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaMoe")
            USE IN cursor_4c_BuscaMoe
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdGrEstoque - KeyPress do campo codigo do grupo de estoque
    *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdGrEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrEstoque()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdGrEstoque()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdGrEstoque - Valida codigo do grupo de estoque em SigCdGcr
    *   Equivalente ao fAcessoContab(Usuar,'C',...) do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdGrEstoque()
        LOCAL loc_cCodigo, loc_oPag, loc_cSQL, loc_nResult
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")

        IF loc_nResult > 0
            SELECT cursor_4c_ValGrEst
            IF !EOF()
                loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
                USE IN cursor_4c_ValGrEst
                RETURN
            ENDIF
            IF USED("cursor_4c_ValGrEst")
                USE IN cursor_4c_ValGrEst
            ENDIF
        ENDIF

        THIS.AbrirBuscaGrEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrEstoque - FormBuscaAuxiliar para selecao do grupo de estoque
    *   Tabela: SigCdGcr | Cod: codigos | Desc: descrs
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrEstoque()
        LOCAL loc_oBusca, loc_cValor, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cValor = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrEst", "codigos", loc_cValor, ;
            "Grupo de Estoque")

        IF VARTYPE(loc_oBusca) != "O"
            MsgErro("Erro ao abrir busca de grupos de estoque", "Erro")
            RETURN
        ENDIF

        IF loc_oBusca.this_lAchouRegistro
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
                loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
            ENDIF
        ELSE
            loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
                loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaGrEst")
            USE IN cursor_4c_BuscaGrEst
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsGrEstoque - KeyPress do campo descricao do grupo de estoque
    *   F4(115)/ENTER(13)/TAB(9): busca grupo por descrs e preenche codigos
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsGrEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsGrEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsGrEstoque - Busca grupo de estoque por descricao em SigCdGcr
    *   Equivalente ao fAcessoContab(Usuar,'D',...) do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsGrEstoque()
        LOCAL loc_cDesc, loc_oPag, loc_oBusca, loc_cSQL, loc_nResult
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)

        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c__Cd_GrEstoque.Value = ""
            loc_oPag.txt_4c__Ds_GrEstoque.Value = ""
            RETURN
        ENDIF

        loc_cSQL    = "SELECT codigos, descrs FROM SigCdGcr WHERE UPPER(descrs) LIKE '%" + ;
                      UPPER(STRTRAN(loc_cDesc, "'", "''")) + "%'"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")

        IF loc_nResult > 0
            SELECT cursor_4c_ValGrEst
            IF !EOF() AND RECCOUNT("cursor_4c_ValGrEst") = 1
                loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.codigos)
                loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_ValGrEst.descrs)
                USE IN cursor_4c_ValGrEst
                RETURN
            ENDIF
            IF USED("cursor_4c_ValGrEst")
                USE IN cursor_4c_ValGrEst
            ENDIF
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGcr", "cursor_4c_BuscaGrEst", "descrs", loc_cDesc, ;
            "Grupo de Estoque")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
            loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
            loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
        ELSE
            IF !loc_oBusca.this_lAchouRegistro
            loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrEst")
                loc_oPag.txt_4c__Cd_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.codigos)
                loc_oPag.txt_4c__Ds_GrEstoque.Value = ALLTRIM(cursor_4c_BuscaGrEst.descrs)
            ENDIF
            ENDIF
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaGrEst")
            USE IN cursor_4c_BuscaGrEst
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaCdEstoque - KeyPress do campo codigo da conta de estoque
    *   F4(115): abre busca; ENTER(13)/TAB(9): valida codigo em SigCdBal
    *--------------------------------------------------------------------------
    PROCEDURE TeclaCdEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEstoque()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCdEstoque()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdEstoque - Valida codigo de conta de estoque em SigCdBal
    *   Equivalente ao fAcessoContas(Usuar,Grupo,'C',...) do sistema legado
    *   Filtra por Grupos se o campo de grupo estiver preenchido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCdEstoque()
        LOCAL loc_cCodigo, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
        loc_oPag    = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
        loc_cGrupo  = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPag.txt_4c_Ds_Estoque.Value = ""
            RETURN
        ENDIF

        loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas = " + EscaparSQL(loc_cCodigo)
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")

        IF loc_nResult > 0
            SELECT cursor_4c_ValEst
            IF !EOF()
                loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_ValEst.Contas)
                USE IN cursor_4c_ValEst
                RETURN
            ENDIF
            IF USED("cursor_4c_ValEst")
                USE IN cursor_4c_ValEst
            ENDIF
        ENDIF

        THIS.AbrirBuscaEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEstoque - FormBuscaAuxiliar para selecao de conta de estoque
    *   Busca contas distintas em SigCdBal filtradas pelo grupo selecionado
    *   Equivalente ao fAcessoContas(Usuar,Grupo,...) do sistema legado
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEstoque()
        LOCAL loc_oBusca, loc_cGrupo, loc_oPag, loc_cSQL, loc_nResult
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_cGrupo = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)

        loc_cSQL = "SELECT DISTINCT Contas FROM SigCdBal WHERE Contas IS NOT NULL AND LEN(RTRIM(Contas)) > 0"
        IF !EMPTY(loc_cGrupo)
            loc_cSQL = loc_cSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
        ENDIF
        loc_cSQL    = loc_cSQL + " ORDER BY Contas"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEst")

        IF loc_nResult < 1
            MsgErro("Erro ao buscar contas de estoque", "Erro")
            RETURN
        ENDIF

        SELECT cursor_4c_BuscaEst
        GO TOP

        IF EOF()
            MsgAviso("Nenhuma conta encontrada" + ;
                IIF(!EMPTY(loc_cGrupo), " para o grupo " + loc_cGrupo, "") + ".", ;
                "Busca")
            USE IN cursor_4c_BuscaEst
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
        IF VARTYPE(loc_oBusca) != "O"
            MsgErro("Erro ao abrir busca de contas", "Erro")
            USE IN cursor_4c_BuscaEst
            RETURN
        ENDIF

        loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEst"
        loc_oBusca.this_cTitulo        = "Conta de Estoque"
        loc_oBusca.mAddColuna("Contas", "XXXXXXXX", "Conta")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEst")
            loc_oPag.txt_4c_Cd_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
            loc_oPag.txt_4c_Ds_Estoque.Value = ALLTRIM(cursor_4c_BuscaEst.Contas)
        ENDIF

        loc_oBusca.Release()
        IF USED("cursor_4c_BuscaEst")
            USE IN cursor_4c_BuscaEst
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDsEstoque - KeyPress do campo descricao da conta de estoque
    *   F4(115)/ENTER(13)/TAB(9): abre busca de contas de estoque
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDsEstoque(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 115 OR par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsEstoque()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDsEstoque - Busca conta de estoque por valor digitado na descricao
    *   Como Contas nao tem descricao separada, abre lookup para selecao
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDsEstoque()
        LOCAL loc_cDesc, loc_oPag
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_cDesc = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)

        IF EMPTY(loc_cDesc)
            loc_oPag.txt_4c_Cd_Estoque.Value = ""
            loc_oPag.txt_4c_Ds_Estoque.Value = ""
            RETURN
        ENDIF

        THIS.AbrirBuscaEstoque()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaIBarra - KeyPress do campo numero de barra/etiqueta
    *   ENTER(13)/TAB(9): valida numero em SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE TeclaIBarra(par_nKeyCode, par_nShift)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarIBarra()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarIBarra - Valida numero de etiqueta em SigOpEtq (campo CBars)
    *   Equivalente ao Valid original de GetiBarra:
    *   Select CBars From SigOpEtq Where CBars = nBarra -> se nao achar avisa
    *--------------------------------------------------------------------------
    PROCEDURE ValidarIBarra()
        LOCAL loc_nBarra, loc_cSQL, loc_nResult, loc_oPag
        loc_oPag   = THIS.pgf_4c_Paginas.Page1
        loc_nBarra = loc_oPag.txt_4c_IBarra.Value

        IF loc_nBarra = 0
            RETURN
        ENDIF

        loc_cSQL    = "SELECT CBars FROM SigOpEtq WHERE CBars = " + ALLTRIM(STR(loc_nBarra, 8))
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValBarra")

        IF loc_nResult > 0
            SELECT cursor_4c_ValBarra
            IF EOF()
                IF USED("cursor_4c_ValBarra")
                    USE IN cursor_4c_ValBarra
                ENDIF
                MsgAviso("Etiqueta n" + CHR(227) + "o Encontrada !!!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPag.txt_4c_IBarra.Value = 0
                RETURN
            ENDIF
            IF USED("cursor_4c_ValBarra")
                USE IN cursor_4c_ValBarra
            ENDIF
        ELSE
            MsgErro("Erro ao validar n" + CHR(250) + "mero de etiqueta", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos filtros do form para o BO
    *   Chamado antes de Visualizar() ou Imprimir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_nTipo        = loc_oPag.obj_4c_OptGtprel.Value
            .this_cDtBase      = ALLTRIM(loc_oPag.txt_4c_DtBase.Value)
            .this_cDtBaseA     = ALLTRIM(loc_oPag.txt_4c_DtBasea.Value)
            .this_cCdEmpresa   = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
            .this_cDsEmpresa   = ALLTRIM(loc_oPag.txt_4c_Dempresa.Value)
            .this_cCdMoeda     = ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)
            .this_cDsMoeda     = ALLTRIM(loc_oPag.txt_4c__ds_moeda.Value)
            .this_cCdGrEstoque = ALLTRIM(loc_oPag.txt_4c__Cd_GrEstoque.Value)
            .this_cDsGrEstoque = ALLTRIM(loc_oPag.txt_4c__Ds_GrEstoque.Value)
            .this_cCdEstoque   = ALLTRIM(loc_oPag.txt_4c_Cd_Estoque.Value)
            .this_cDsEstoque   = ALLTRIM(loc_oPag.txt_4c_Ds_Estoque.Value)
            .this_nIBarra      = loc_oPag.txt_4c_IBarra.Value
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica campos obrigatorios antes de gerar relatorio
    *   Equivalente as validacoes do Click original do botao de relatorio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarFiltros()
        LOCAL loc_nTipo, loc_oPag
        loc_oPag  = THIS.pgf_4c_Paginas.Page1
        loc_nTipo = loc_oPag.obj_4c_OptGtprel.Value

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c_DtBase.Value)) OR ;
           ALLTRIM(loc_oPag.txt_4c_DtBase.Value) = "  /    "
            MsgAviso("Data Base Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
            loc_oPag.txt_4c_DtBase.SetFocus
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value)) AND ;
           INLIST(loc_nTipo, 1, 2)
            MsgAviso("Moeda Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
            loc_oPag.txt_4c__cd_moeda.SetFocus
            RETURN .F.
        ENDIF

        IF loc_nTipo = 1
            IF EMPTY(ALLTRIM(loc_oPag.txt_4c_Empresa.Value))
                MsgAviso("Empresa Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
                loc_oPag.txt_4c_Empresa.SetFocus
                RETURN .F.
            ENDIF
        ENDIF

        IF loc_nTipo = 3
            IF loc_oPag.txt_4c_IBarra.Value = 0
                MsgAviso("N" + CHR(250) + "mero de Barra Inv" + CHR(225) + "lido !!!", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                loc_oPag.txt_4c_IBarra.SetFocus
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza relatorio em tela (preview)
    *   Equivalente ao btnReport.Visualiza.Click original
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Visualizar()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia relatorio para impressora
    *   Equivalente ao btnReport.Imprime.Click original
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.Imprimir()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados do relatorio para planilha Excel
    *   Equivalente ao btnReport.DocExcel.Click original
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF !THIS.this_oRelatorio.PrepararDados()
            MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
            RETURN
        ENDIF
        IF !USED("CsRelatorio")
            MsgAviso("Nenhum dado para exportar.", "Excel")
            RETURN
        ENDIF
        LOCAL loc_cArquivo
        loc_cArquivo = GETFILE("XLS", "Salvar como...", "Salvar", 0, "Exportar para Excel")
        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF
        COPY TO (loc_cArquivo) TYPE XLS
        MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *   Equivalente ao btnReport.Sair.Click original (Cancel=.T. ja trata ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSelempClick - Marca todas as empresas no grid (lMarca=1)
    *   Equivalente ao cmdSelemp.Click original: Update CsSigCdEmp Set lMarca=1
    *--------------------------------------------------------------------------
    PROCEDURE CmdSelempClick()
        IF USED("CsSigCdEmp")
            SELECT CsSigCdEmp
            REPLACE ALL lMarca WITH 1
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdApgEmpClick - Desmarca todas as empresas no grid (lMarca=0)
    *   Equivalente ao CmdApgEmp.Click original: Update CsSigCdEmp Set lMarca=0
    *--------------------------------------------------------------------------
    PROCEDURE CmdApgEmpClick()
        IF USED("CsSigCdEmp")
            SELECT CsSigCdEmp
            REPLACE ALL lMarca WITH 0
            GO TOP
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh
        ENDIF
    ENDPROC

    *==========================================================================
    * COMPATIBILIDADE CRUD (mapeamento semantico de botoes para form REPORT)
    *   Form REPORT (frmrelatorio) nao possui operacoes CRUD nativas. Estes
    *   metodos existem para compatibilidade com o pipeline generico do sistema
    *   e mapeiam acoes CRUD para operacoes equivalentes no contexto de relatorio:
    *     - BtnIncluirClick  -> Visualizar (gera e exibe o relatorio)
    *     - BtnAlterarClick  -> LimparCampos + foco no 1o filtro (reset edicao)
    *     - BtnExcluirClick  -> LimparCampos (limpa filtros = "remove" selecao)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Em REPORT delega para Visualizar (gerar relatorio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Em REPORT limpa filtros e devolve foco ao 1o campo
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        THIS.LimparCampos()
        TRY
            THIS.pgf_4c_Paginas.Page1.txt_4c_DtBase.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Em REPORT delega para LimparCampos (excluir = limpar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Em REPORT busca = visualizar relatorio em tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT salvar = imprimir relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT cancelar = limpar todos os filtros
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Delega para FormParaRelatorio (padrao REPORT)
    *   Transfere valores dos filtros do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega propriedades do BO de volta nos campos do form
    *   Em REPORT, os filtros sao definidos pelo usuario; BO nao tem estado
    *   persistente a recarregar. Metodo existe para compatibilidade de pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            loc_oPag.obj_4c_OptGtprel.Value     = .this_nTipo
            loc_oPag.txt_4c_DtBase.Value        = .this_cDtBase
            loc_oPag.txt_4c_DtBasea.Value       = .this_cDtBaseA
            loc_oPag.txt_4c_Empresa.Value       = .this_cCdEmpresa
            loc_oPag.txt_4c_Dempresa.Value      = .this_cDsEmpresa
            loc_oPag.txt_4c__cd_moeda.Value     = .this_cCdMoeda
            loc_oPag.txt_4c__ds_moeda.Value     = .this_cDsMoeda
            loc_oPag.txt_4c__Cd_GrEstoque.Value = .this_cCdGrEstoque
            loc_oPag.txt_4c__Ds_GrEstoque.Value = .this_cDsGrEstoque
            loc_oPag.txt_4c_Cd_Estoque.Value    = .this_cCdEstoque
            loc_oPag.txt_4c_Ds_Estoque.Value    = .this_cDsEstoque
            loc_oPag.txt_4c_IBarra.Value        = .this_nIBarra
        ENDWITH

        THIS.AjustarVisibilidadePorTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de filtro
    *   Em REPORT todos os filtros ficam sempre editaveis (sem modo VISUALIZAR)
    *   par_lHabilitar: .T. para habilitar, .F. para desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1

        loc_oPag.obj_4c_OptGtprel.Enabled     = par_lHabilitar
        loc_oPag.txt_4c_IBarra.Enabled        = par_lHabilitar
        loc_oPag.txt_4c_Empresa.Enabled       = par_lHabilitar
        loc_oPag.txt_4c_Dempresa.Enabled      = par_lHabilitar
        loc_oPag.txt_4c_DtBase.Enabled        = par_lHabilitar
        loc_oPag.txt_4c_DtBasea.Enabled       = par_lHabilitar
        loc_oPag.txt_4c__cd_moeda.Enabled     = par_lHabilitar
        loc_oPag.txt_4c__ds_moeda.Enabled     = par_lHabilitar
        loc_oPag.txt_4c__Cd_GrEstoque.Enabled = par_lHabilitar
        loc_oPag.txt_4c__Ds_GrEstoque.Enabled = par_lHabilitar
        loc_oPag.txt_4c_Cd_Estoque.Enabled    = par_lHabilitar
        loc_oPag.txt_4c_Ds_Estoque.Enabled    = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT nao ha lista; recarrega grid de empresas se aberto
    *   Chamado quando tipo=2 (Sint" + CHR(233) + "tico) e grid de empresas precisa ser atualizado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrd, loc_oPag
        loc_oPag = THIS.pgf_4c_Paginas.Page1
        loc_oGrd = loc_oPag.grd_4c_Dados

        IF USED("CsSigCdEmp")
            loc_oGrd.RecordSource          = "CsSigCdEmp"
            loc_oGrd.Column1.ControlSource = "CsSigCdEmp.lMarca"
            loc_oGrd.Column2.ControlSource = "CsSigCdEmp.CEmps"
            loc_oGrd.Column3.ControlSource = "CsSigCdEmp.Razas"
            loc_oGrd.Column2.Header1.Caption = "C" + CHR(243) + "d."
            loc_oGrd.Column3.Header1.Caption = "Nome da Empresa"
            loc_oGrd.Refresh
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT os botoes do CommandGroup ficam sempre
    *   habilitados (nao ha modo INCLUIR/ALTERAR/VISUALIZAR como no CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReIfvBO.prg):
*==============================================================================
* SIGREIFVBO.PRG
* Business Object para Relatorio de Fechamento de Inventario
* Herda de RelatorioBase
*
* Relatorio original: SIGREIFV.SCX (frmrelatorio)
* FRX: SigReIf1 (Analitico), SigReIf0 (Sintetico), SigReIf9 (Consulta Barra)
*==============================================================================

DEFINE CLASS SigReIfvBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""
    this_cTituloRel     = "Relat" + CHR(243) + "rio de Fechamento de Invent" + CHR(225) + "rio"

    *-- Filtros: tipo de relatorio
    *-- 1 = Analitico (empresa unica)
    *-- 2 = Sintetico (multiplas empresas via grid)
    *-- 3 = Consulta Barra (por numero de etiqueta)
    this_nTipo          = 1

    *-- Filtros: datas (formato MM/YYYY - InputMask "99/9999")
    this_cDtBase        = ""
    this_cDtBaseA       = ""

    *-- Filtros: empresa (codigo + descricao)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Filtros: moeda (codigo + descricao)
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Filtros: grupo de estoque/contabilidade (codigo + descricao)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: conta de estoque (codigo + descricao)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: numero de barra/etiqueta (apenas tipo 3)
    this_nIBarra        = 0

    *-- Nomes dos arquivos FRX por tipo
    this_cFrxAnalitico     = "SigReIf1"
    this_cFrxSintetico     = "SigReIf0"
    this_cFrxConsultaBarra = "SigReIf9"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de fechamento de inventario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosAuxiliares - Carrega cursores auxiliares para o relatorio
    * Deve ser chamado pelo Form durante InicializarForm()
    * Carrega: CrSigCdEmp, CrSigCdMoe, CrSigCdCot, CrSigBaOco, CsBases
    * Cria: CsSigCdEmp (cursor editavel para grid de selecao de empresas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosAuxiliares()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigCdEmp")
                USE IN CrSigCdEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdEmp", "CrSigCdEmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar empresas (CrSigCdEmp)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdEmp
            INDEX ON CEmps TAG CEmps
            GO TOP

            IF USED("CrSigCdMoe")
                USE IN CrSigCdMoe
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "CrSigCdMoe")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar moedas (CrSigCdMoe)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdMoe
            INDEX ON CMoes TAG CMoes
            GO TOP

            IF USED("CrSigCdCot")
                USE IN CrSigCdCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "CrSigCdCot")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar cota" + CHR(231) + CHR(245) + "es (CrSigCdCot)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigCdCot
            INDEX ON CMoes + DTOS(TTOD(Datas)) TAG CMoeData
            GO TOP

            IF USED("CrSigBaOco")
                USE IN CrSigBaOco
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigBaOco", "CrSigBaOco")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar ocorr" + CHR(234) + "ncias (CrSigBaOco)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CrSigBaOco
            INDEX ON Tipos + Codigos TAG TipCods
            GO TOP

            *-- CsBases: datas base disponiveis (para lookup de data base no form)
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF
            CREATE CURSOR cursor_4c_IfvTmpBase (Bases c(7))
            INSERT INTO cursor_4c_IfvTmpBase (Bases) VALUES ("  /    ")

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DtBases FROM SigCdBal WHERE DtBases IS NOT NULL", ;
                "cursor_4c_IfvTmpBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar bases (SigCdBal)"
                loc_lSucesso = .F.
            ENDIF

            IF USED("CsBases")
                USE IN CsBases
            ENDIF
            SELECT SUBSTR(DTOS(DtBases),5,2) + "/" + LEFT(DTOS(DtBases),4) AS Bases ;
            FROM cursor_4c_IfvTmpBal ;
            GROUP BY 1 ;
            UNION ALL ;
            SELECT Bases FROM cursor_4c_IfvTmpBase ;
            GROUP BY 1 ;
            INTO CURSOR CsBases READWRITE

            SELECT CsBases
            INDEX ON Bases TAG Bases
            GO TOP

            IF USED("cursor_4c_IfvTmpBal")
                USE IN cursor_4c_IfvTmpBal
            ENDIF
            IF USED("cursor_4c_IfvTmpBase")
                USE IN cursor_4c_IfvTmpBase
            ENDIF

            *-- CsSigCdEmp: cursor editavel para grid de selecao de empresas (tipo 2)
            IF USED("CsSigCdEmp")
                USE IN CsSigCdEmp
            ENDIF
            SELECT IIF(Ativas = 1, 1, 0) AS lMarca, CEmps, Razas, Ativas, Nums ;
            FROM CrSigCdEmp ;
            WHERE !EMPTY(CEmps) AND !EMPTY(Razas) ;
            INTO CURSOR CsSigCdEmp READWRITE

            SELECT CsSigCdEmp
            INDEX ON Razas TAG Razas
            INDEX ON CEmps TAG CEmps
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta os cursores de dados para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado
    * Resultado: cursores CsCabecalho e CsRelatorio prontos para REPORT FORM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cDtBase, loc_cDtBaseA, loc_nTipo
        LOCAL loc_cEmp, loc_cMoe, loc_cGrupo, loc_cConta, loc_nBarra
        LOCAL loc_nResult, loc_cNomeEmpresa, loc_cEmpresaCab
        LOCAL loc_cTitulo, loc_cSubTitulo, loc_lProcess

        loc_lSucesso = .F.
        TRY
            loc_cDtBase  = RIGHT(ALLTRIM(THIS.this_cDtBase), 4)  + LEFT(ALLTRIM(THIS.this_cDtBase), 2)
            loc_cDtBaseA = RIGHT(ALLTRIM(THIS.this_cDtBaseA), 4) + LEFT(ALLTRIM(THIS.this_cDtBaseA), 2)
            loc_nTipo    = THIS.this_nTipo
            loc_cEmp     = ALLTRIM(THIS.this_cCdEmpresa)
            loc_cMoe     = ALLTRIM(THIS.this_cCdMoeda)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cConta   = ALLTRIM(THIS.this_cCdEstoque)
            loc_nBarra   = THIS.this_nIBarra

            loc_cNomeEmpresa = ""
            IF USED("CrSigCdEmp")
                IF SEEK(go_4c_Sistema.cCodEmpresa, "CrSigCdEmp", "CEmps")
                    loc_cNomeEmpresa = ALLTRIM(CrSigCdEmp.Razas)
                ENDIF
            ENDIF
            loc_cEmpresaCab = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + loc_cNomeEmpresa

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (;
                Empresa   c(80), ;
                Titulo    c(80), ;
                SubTitulo c(80), ;
                DtBase    c(7),  ;
                DtBaseA   c(7)   ;
            )

            IF loc_nTipo = 3
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase) ;
                VALUES (loc_cEmpresaCab, ;
                        "Consulta Barra", ;
                        ALLTRIM(STR(loc_nBarra, 8)), ;
                        THIS.this_cDtBase)
            ELSE
                loc_cTitulo = "Invent" + CHR(225) + "rio Data Base " + THIS.this_cDtBase
                IF loc_nTipo = 1
                    loc_cSubTitulo = "Lj: " + loc_cEmp + "   " + ;
                                     "Anal" + CHR(237) + "tico de Apura" + CHR(231) + CHR(227) + "o - " + loc_cMoe
                ELSE
                    loc_cSubTitulo = "Sint" + CHR(233) + "tico - " + loc_cMoe
                ENDIF
                INSERT INTO CsCabecalho (Empresa, Titulo, SubTitulo, DtBase, DtBaseA) ;
                VALUES (loc_cEmpresaCab, loc_cTitulo, loc_cSubTitulo, ;
                        THIS.this_cDtBase, THIS.this_cDtBaseA)
            ENDIF

            IF USED("CsBal")
                USE IN CsBal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigCdBal", "CsBal")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar balan" + CHR(231) + "o (CsBal)"
                loc_lSucesso = .F.
            ENDIF
            SELECT CsBal
            GO TOP

            IF USED("Balancos")
                USE IN Balancos
            ENDIF

            IF loc_nTipo <> 2
                SELECT *, LEFT(DTOS(DtBases),6) AS Bases ;
                FROM CsBal ;
                WHERE IIF(loc_nTipo = 1, Emps = loc_cEmp, .T.) ;
                    AND (LEFT(DTOS(DtBases),6) = loc_cDtBase ;
                        OR (LEFT(DTOS(DtBases),6) = loc_cDtBaseA ;
                            AND loc_nTipo = 2 AND !EMPTY(loc_cDtBaseA))) ;
                    AND (Grupos = loc_cGrupo OR EMPTY(loc_cGrupo)) ;
                    AND (Contas = loc_cConta OR EMPTY(loc_cConta)) ;
                ORDER BY Emps ;
                INTO CURSOR Balancos
            ELSE
                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
                SELECT * FROM CsSigCdEmp WHERE lMarca = 1 INTO CURSOR cursor_4c_IfvEmps

                SELECT a.*, LEFT(DTOS(a.DtBases),6) AS Bases ;
                FROM CsBal a, cursor_4c_IfvEmps b ;
                WHERE a.Emps = b.CEmps ;
                    AND (LEFT(DTOS(a.DtBases),6) = loc_cDtBase ;
                        OR (LEFT(DTOS(a.DtBases),6) = loc_cDtBaseA ;
                            AND !EMPTY(loc_cDtBaseA))) ;
                    AND (a.Grupos = loc_cGrupo OR EMPTY(loc_cGrupo)) ;
                    AND (a.Contas = loc_cConta OR EMPTY(loc_cConta)) ;
                ORDER BY a.Emps ;
                INTO CURSOR Balancos

                IF USED("cursor_4c_IfvEmps")
                    USE IN cursor_4c_IfvEmps
                ENDIF
            ENDIF

            DO CASE
                CASE loc_nTipo = 1
                    loc_lProcess = THIS.ProcessarAnalitico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                CASE loc_nTipo = 2
                    loc_lProcess = THIS.ProcessarSintetico(loc_cDtBase, loc_cDtBaseA, loc_cMoe)
                OTHERWISE
                    loc_lProcess = THIS.ProcessarConsultaBarra(loc_cDtBase, loc_cMoe, loc_nBarra)
            ENDCASE

            IF loc_lProcess
                SELECT CsRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            WAIT CLEAR
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFrx = gc_4c_CaminhoReports + THIS.ObterFrxAtual()
                REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFrxAtual - Retorna nome do arquivo FRX conforme tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE ObterFrxAtual()
        DO CASE
            CASE THIS.this_nTipo = 1
                RETURN THIS.this_cFrxAnalitico
            CASE THIS.this_nTipo = 2
                RETURN THIS.this_cFrxSintetico
            OTHERWISE
                RETURN THIS.this_cFrxConsultaBarra
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna cotacao da moeda na data informada
    * Equivalente a fCarregarCambio() do sistema legado
    * Busca a cotacao mais recente <= par_dData para a moeda informada
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda
        loc_nCotacao = 1
        loc_cMoeda   = ALLTRIM(par_cMoeda)
        IF USED("CrSigCdCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(par_dData)
            SELECT CrSigCdCot
            SET ORDER TO CMoeData
            IF SEEK(loc_cMoeda + DTOS(par_dData))
                loc_nCotacao = CrSigCdCot.Valos
            ELSE
                SKIP -1
                IF !BOF() AND ALLTRIM(CrSigCdCot.CMoes) = loc_cMoeda AND ;
                   TTOD(CrSigCdCot.Datas) <= par_dData
                    loc_nCotacao = CrSigCdCot.Valos
                ENDIF
            ENDIF
        ENDIF
        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarAnalitico - Processa relatorio analitico empresa unica (Tipo 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarAnalitico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL, loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Ocorrencia c(10),   Barras     n(8),    Barra2s   n(8),    ;
            CCustos    n(12,2), CCusto2s   n(12,2), DifCustos n(12,2), ;
            Ocor2s     c(10),   DesOco     c(40),   Obs2s     m,       ;
            DPros      c(40),   Pesos      n(12,2)  ;
        )
        INDEX ON Ocorrencia + STR(Barras,8) TAG Produto

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "LEFT JOIN SigOpEtq c ON c.CBars = a.Barras " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs,c.CBars,c.Pesos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                SCATTER MEMVAR MEMO

                SEEK("O" + m.Ocorrencia, "CrSigBaOco", "TipCods")
                IF CrSigBaOco.Apuras <> "S"
                    LOOP
                ENDIF

                m.DPros  = IIF(EMPTY(m.Obs), m.DPros, m.Obs)
                m.DesOco = CrSigBaOco.Descrs

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe,  DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas,  DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos   = m.CCustos  * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.CCusto2s  = m.CCusto2s * IIF(CrSigBaOco.Opers = "DB", -1, 1)
                m.DifCustos = (m.CCustos - m.CCusto2s)
                m.Obs2s     = NVL(m.Obs2s, "")
                m.Pesos     = NVL(m.Pesos, 0)

                INSERT INTO CsRelatorio FROM MEMVAR

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarSintetico - Processa relatorio sintetico multi-empresa (Tipo 2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarSintetico(par_cDtBase, par_cDtBaseA, par_cMoe)
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_nCotaMCC, loc_nCotaMoe, loc_nQtdeQs
        LOCAL loc_cDataBase, loc_nColuna, loc_nQtde, loc_nDif
        LOCAL loc_cCusto, loc_cQtde

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps    c(3),    DtBals  d(8),    ;
            Qtde1   n(12,2), Custo1  n(12,2), ;
            Qtde2   n(12,2), Custo2  n(12,2), ;
            Qtde3   n(12,2), Custo3  n(12,2), ;
            Custo3d n(12,2), Dif3d   n(12,2), ;
            Qtde4   n(12,2), Custo4  n(12,2), ;
            Qtde5   n(12,2), Custo5  n(12,2), ;
            Contac  n(12,2)  ;
        )
        INDEX ON Emps TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = Balancos.Bases
            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros,b.MoecusFs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            SELECT CsRelatorio
            SEEK Balancos.Emps
            IF EOF()
                INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
            ENDIF
            IF loc_cDataBase = par_cDtBase
                REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
            ENDIF

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF
            SELECT a.*, b.Lancas, b.Opers ;
            FROM Tratamento a, CrSigBaOco b ;
            WHERE "O" + a.Ocorrencia = b.Tipos + b.Codigos AND b.Apuras = "S" ;
            INTO CURSOR cursor_4c_IfvConsulta

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT cursor_4c_IfvConsulta
            GO TOP
            SCAN
                SELECT CsRelatorio
                SCATTER MEMVAR BLANK

                SELECT cursor_4c_IfvConsulta
                SCATTER MEMVAR MEMO

                m.MoeCusFs = NVL(m.MoeCusFs, " ")
                SEEK(m.MoeCusFs, "CrSigCdMoe", "CMoes")
                IF !EMPTY(CrSigCdMoe.MoeQs)
                    m.Moedas    = CrSigCdMoe.MoeQs
                    loc_nQtdeQs = IIF(CrSigCdMoe.QtdeQs = 0, 1, CrSigCdMoe.QtdeQs)
                ELSE
                    m.Moedas    = m.MoeCusFs
                    loc_nQtdeQs = 1
                ENDIF

                m.CCustos  = m.CCustos  * loc_nQtdeQs
                m.CCusto2s = m.CCusto2s * loc_nQtdeQs

                IF m.Moedas <> par_cMoe
                    loc_nCotaMCC = THIS.CarregarCambio(par_cMoe, DATE())
                    loc_nCotaMoe = THIS.CarregarCambio(m.Moedas, DATE())
                    m.CCustos  = ROUND(m.CCustos  * loc_nCotaMoe / loc_nCotaMCC, 2)
                    m.CCusto2s = ROUND(m.CCusto2s * loc_nCotaMoe / loc_nCotaMCC, 2)
                ENDIF

                m.CCustos  = m.CCustos  * IIF(m.Opers = "DB", -1, 1)
                m.CCusto2s = m.CCusto2s * IIF(m.Opers = "DB", -1, 1)

                loc_nDif    = (m.CCustos - m.CCusto2s)
                loc_nColuna = 0

                DO CASE
                    CASE m.Ocorrencia = "FB"
                        IF loc_cDataBase = par_cDtBase
                            loc_nColuna = 2
                        ELSE
                            loc_nColuna = 1
                        ENDIF
                    CASE m.Ocorrencia = "ET" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 3
                    CASE m.Ocorrencia = "SB" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 4
                    CASE m.Ocorrencia = "FE" AND loc_cDataBase = par_cDtBase
                        loc_nColuna = 5
                ENDCASE

                IF loc_nColuna = 0
                    SELECT cursor_4c_IfvConsulta
                    LOOP
                ENDIF

                loc_cCusto = "Custo" + STR(loc_nColuna, 1)
                loc_cQtde  = "Qtde"  + STR(loc_nColuna, 1)
                loc_nQtde  = m.Falta + m.Sobra

                SELECT CsRelatorio
                SEEK ALLTRIM(Balancos.Emps)
                IF EOF()
                    INSERT INTO CsRelatorio (Emps) VALUES (ALLTRIM(Balancos.Emps))
                ENDIF
                IF loc_cDataBase = par_cDtBase
                    REPLACE DtBals WITH Balancos.DataInis IN CsRelatorio
                ENDIF
                REPLACE &loc_cCusto. WITH &loc_cCusto. + m.CCustos, ;
                        &loc_cQtde.  WITH &loc_cQtde.  + IIF(loc_nQtde = 0, m.Apurado, (m.Falta + m.Sobra))

                IF m.Ocorrencia = "ET"
                    REPLACE Custo3d WITH Custo3d + m.CCusto2s, ;
                            Dif3d   WITH Custo3  - Custo3d
                ENDIF

                IF m.Lancas = "S" AND loc_nColuna <> 1
                    REPLACE Contac WITH Contac + loc_nDif IN CsRelatorio
                ENDIF

                SELECT cursor_4c_IfvConsulta
            ENDSCAN

            IF USED("cursor_4c_IfvConsulta")
                USE IN cursor_4c_IfvConsulta
            ENDIF

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConsultaBarra - Processa consulta por numero de barra (Tipo 3)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarConsultaBarra(par_cDtBase, par_cMoe, par_nBarra)
        LOCAL loc_nResult, loc_cSQL, loc_cDataBase, loc_cObss

        IF USED("CsRelatorio")
            USE IN CsRelatorio
        ENDIF
        CREATE CURSOR CsRelatorio (;
            Emps       c(3),  ;
            DtBals     d(8),  ;
            DtBases    c(7),  ;
            Ocorrencia c(10), ;
            DesOco     c(40), ;
            Obss       m      ;
        )
        INDEX ON Emps + DtBases TAG Emps

        WAIT WINDOW "Aguarde! Abrindo o Balan" + CHR(231) + "o..." NOWAIT

        SELECT Balancos
        GO TOP
        SCAN
            loc_cDataBase = RIGHT(Balancos.Bases,2) + "/" + LEFT(Balancos.Bases,4)

            IF USED("Tratamento")
                USE IN Tratamento
            ENDIF

            loc_cSQL = "SELECT a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia,a.Obs," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.Obs2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros " + ;
                       "FROM SigIvTrT a " + ;
                       "LEFT JOIN SigCdPro b ON b.CPros = a.Produto " + ;
                       "WHERE a.Emps = '" + ALLTRIM(Balancos.Emps) + "' " + ;
                       "AND a.Codigos = " + ALLTRIM(STR(Balancos.Codigos,4)) + " " + ;
                       "AND a.Barras = " + ALLTRIM(STR(par_nBarra, 8)) + " " + ;
                       "ORDER BY a.Emps,a.Codigos,a.Tipos,a.Produto,a.Barras," + ;
                       "a.Apurado,a.Estoque,a.Falta,a.Sobra,a.Ocorrencia," + ;
                       "a.PesReals,a.CCustos,a.Barra2s,a.Ocor2s,a.CCusto2s," + ;
                       "a.Peso2s,a.CItens,a.Usuars,a.CIdChaves," + ;
                       "b.CPros,b.DPros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "Tratamento")
            IF loc_nResult < 1
                WAIT CLEAR
                MsgErro("Falha na conex" + CHR(227) + "o (Tratamento)", "Erro")
                RETURN .F.
            ENDIF

            SELECT Tratamento
            GO TOP
            IF EOF()
                SELECT Balancos
                LOOP
            ENDIF

            WAIT WINDOW "Analisando o Tratamento..." NOWAIT

            SELECT Tratamento
            GO TOP
            SCAN
                SEEK("O" + Tratamento.Ocorrencia, "CrSigBaOco", "TipCods")
                loc_cObss = IIF(EMPTY(Tratamento.Obs), ;
                               NVL(Tratamento.DPros, ""), ;
                               NVL(Tratamento.Obs, ""))

                INSERT INTO CsRelatorio (Emps, DtBals, DtBases, Ocorrencia, DesOco, Obss) ;
                VALUES (ALLTRIM(Balancos.Emps), Balancos.DataInis, loc_cDataBase, ;
                        ALLTRIM(Tratamento.Ocorrencia), ALLTRIM(CrSigBaOco.Descrs), loc_cObss)

                SELECT Tratamento
            ENDSCAN

            SELECT Balancos
        ENDSCAN

        WAIT CLEAR
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

