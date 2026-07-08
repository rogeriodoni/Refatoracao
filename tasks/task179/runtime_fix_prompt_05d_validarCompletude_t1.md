# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[Formsigpres2.prg] Procedure vazia (sem codigo): FormParaBO
[Formsigpres2.prg] Procedure vazia (sem codigo): HabilitarCampos

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg):
*==============================================================================
* Formsigpres2.prg - Pressupostos - Detalhe de Movimento
* Formulario OPERACIONAL (consulta de cabecalho e itens de movimento SigMvCab)
* Fase 3 de 8: Estrutura base - PageFrame e containers principais
*==============================================================================

DEFINE CLASS Formsigpres2 AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Pressupostos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cDopes          = ""     && Tipo de operacao passado pelo form pai (_Chave)
    this_oParentForm     = .NULL. && Referencia ao formulario pai

    *==========================================================================
    * Init - Inicializa o formulario
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado por FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object sigpres2BO." + CHR(13) + ;
                            "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
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
            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(100, 100, 100)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(100, 100, 100)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 (lista de movimentos)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho (cntSombra: Top=2+29=31 compensacao PageFrame)
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

        *-- Container botao Consultar (Grupo_Op original: Width=10+80=90, apenas Consultar visivel)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container Encerrar - padrao canonico (Left=917, Width=90)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Consultar (original: so Consultar visivel; Inserir/Alterar/Excluir/Procurar ocultos)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Consultar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar
            .Caption         = "Consultar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (padrao canonico)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid de listagem (11 colunas: Numes, Datas, GrupoOs, ContaOs, GrupoDs, ContaDs, Nops, Usuars, PStatus, Emps, Empds)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 11
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 460
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes (metodos PUBLIC, sem PROTECTED)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Consultar, "Click", ;
                  THIS, "BtnConsultarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
                  THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (detalhe do movimento)
    * FASE 5: cabecalho, grid operacao, cmdEntrega, SubNiveis
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes acao (Grupo_Salva: top=4+29=33)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva/OK no CONSULTAR)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (volta para lista)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Grid GradeOperacao: lista de operacoes (top=10+29=39, gridLines=1 fiel ao original)
        loc_oPagina.AddObject("grd_4c_Operacao", "Grid")
        loc_oPagina.grd_4c_Operacao.ColumnCount = 1
        WITH loc_oPagina.grd_4c_Operacao
            .Top                = 39
            .Left               = 679
            .Width              = 112
            .Height             = 148
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 1
            .Visible            = .T.
        ENDWITH

        *-- Botao Entrega (cmdEntrega original: CommandGroup 1-botao, top=7+29=36)
        loc_oPagina.AddObject("cmd_4c_Entrega", "CommandButton")
        WITH loc_oPagina.cmd_4c_Entrega
            .Caption         = "Entrega"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 36
            .Left            = 23
            .Width           = 90
            .Height          = 110
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Area de cabecalho: 1a linha (Codigo, Data, Prz.Entrega)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo"
            .Top       = 43
            .Left      = 131
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 60
            .Left          = 131
            .Width         = 61
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Data", "Label")
        WITH loc_oPagina.lbl_4c_Data
            .Caption   = "Data"
            .Top       = 43
            .Left      = 201
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oPagina.txt_4c_Data
            .Value         = {}
            .ReadOnly      = .T.
            .Top           = 60
            .Left          = 201
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_PrvEnts", "Label")
        WITH loc_oPagina.lbl_4c_PrvEnts
            .Caption   = "Prz Entrega"
            .Top       = 43
            .Left      = 289
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PrvEnts", "TextBox")
        WITH loc_oPagina.txt_4c_PrvEnts
            .Value         = {}
            .ReadOnly      = .T.
            .Top           = 60
            .Left          = 289
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- 2a linha: OP, Docto, Tb.Desconto, Status
        loc_oPagina.AddObject("lbl_4c_Nop", "Label")
        WITH loc_oPagina.lbl_4c_Nop
            .Caption   = "OP"
            .Top       = 91
            .Left      = 131
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Nop", "TextBox")
        WITH loc_oPagina.txt_4c_Nop
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 108
            .Left          = 131
            .Width         = 55
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Nota", "Label")
        WITH loc_oPagina.lbl_4c_Nota
            .Caption   = "Docto"
            .Top       = 91
            .Left      = 193
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
        WITH loc_oPagina.txt_4c_Nota
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 107
            .Left          = 193
            .Width         = 66
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Tabd", "Label")
        WITH loc_oPagina.lbl_4c_Tabd
            .Caption   = "Tb. Desconto"
            .Top       = 91
            .Left      = 269
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
        WITH loc_oPagina.txt_4c_Tabd
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 108
            .Left          = 269
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_PStatus", "Label")
        WITH loc_oPagina.lbl_4c_PStatus
            .Caption   = "Status"
            .Top       = 91
            .Left      = 358
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_PStatus", "TextBox")
        WITH loc_oPagina.txt_4c_PStatus
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 108
            .Left          = 358
            .Width         = 36
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Botao SubNiveis (top=125+29=154, left=833)
        loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
        WITH loc_oPagina.cmd_4c_SubNiveis
            .Caption         = "Sub" + CHR(237) + "veis"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 154
            .Left            = 833
            .Width           = 137
            .Height          = 40
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Container Origem (grupos/contas Origem, Destino, Representante)
        *-- Original: top=173+29=202, left=27, width=582, height=164
        loc_oPagina.AddObject("cnt_4c_Origem", "Container")
        WITH loc_oPagina.cnt_4c_Origem
            .Top         = 202
            .Left        = 27
            .Width       = 582
            .Height      = 164
            .BackStyle   = 1
            .BackColor   = RGB(255, 255, 255)
            .SpecialEffect = 0
            .Visible     = .T.
        ENDWITH

        *-- Labels de secao (Origem, Destino, Representante)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblOrigem", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblOrigem
            .Caption   = "Origem"
            .Top       = 5
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblDestino", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblDestino
            .Caption   = "Destino"
            .Top       = 59
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_LblRepres", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_LblRepres
            .Caption   = "Representante"
            .Top       = 113
            .Left      = 5
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Labels Grupo/Conta (linha Origem: top=30, linha Destino: top=85, linha Repres: top=138)
        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupO1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupO1
            .Caption   = "Grupo :"
            .Top       = 30
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContO1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContO1
            .Caption   = "Conta :"
            .Top       = 30
            .Left      = 154
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupD1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupD1
            .Caption   = "Grupo :"
            .Top       = 85
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContD1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContD1
            .Caption   = "Conta :"
            .Top       = 85
            .Left      = 154
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_GrupR1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_GrupR1
            .Caption   = "Grupo :"
            .Top       = 138
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("lbl_4c_ContR1", "Label")
        WITH loc_oPagina.cnt_4c_Origem.lbl_4c_ContR1
            .Caption   = "Conta :"
            .Top       = 138
            .Left      = 154
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBoxes Origem (Get_grupo=GrupoOs, Get_conta=ContaOs, Get_dconta=desc)
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_GrupoOs", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOs
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 27
            .Left          = 61
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_ContaOs", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaOs
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 27
            .Left          = 197
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dconta
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 27
            .Left          = 277
            .Width         = 267
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- TextBoxes Destino (Get_GrupoD=GrupoDs, Get_ContaD=ContaDs, Get_dcontad=desc)
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_GrupoDs", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_GrupoDs
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 82
            .Left          = 61
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_ContaD", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_ContaD
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 82
            .Left          = 196
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Dcontad", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dcontad
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 82
            .Left          = 277
            .Width         = 267
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- TextBoxes Representante (get_GruResp=Grresps, Get_resps=Resps, Get_dresps=desc)
        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_GruResp", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_GruResp
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 135
            .Left          = 61
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Resps", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Resps
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 135
            .Left          = 195
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Origem.AddObject("txt_4c_Dresps", "TextBox")
        WITH loc_oPagina.cnt_4c_Origem.txt_4c_Dresps
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 135
            .Left          = 277
            .Width         = 267
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- Botao acesso cadastro conta destino (btnCadastros: top=79, left=549, w=27, h=31)
        loc_oPagina.cnt_4c_Origem.AddObject("cmd_4c_BtnCadastros", "CommandButton")
        WITH loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
            .PicturePosition = 0
            .Top             = 79
            .Left            = 549
            .Width           = 27
            .Height          = 31
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 7
            .Themes          = .F.
            .SpecialEffect   = 0
            .ToolTipText     = "<F3> Acessa o Cadastro Desta Conta"
            .Visible         = .T.
        ENDWITH

        *-- Container de Observacoes do movimento (Container1: top=173+29=202, left=614)
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top       = 202
            .Left      = 614
            .Width     = 373
            .Height    = 164
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_ObsCnt", "Label")
        WITH loc_oPagina.cnt_4c_Container1.lbl_4c_ObsCnt
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
            .Top       = 3
            .Left      = 7
            .Width     = 69
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_MemoObs", "EditBox")
        WITH loc_oPagina.cnt_4c_Container1.txt_4c_MemoObs
            .Value     = ""
            .ReadOnly  = .T.
            .Top       = 20
            .Left      = 7
            .Width     = 359
            .Height    = 138
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Grid de itens do movimento (fwgrade1: top=350+29=379, left=23, width=732, height=191)
        *-- 10 colunas: Produto, Produzido, Qtd., Saldo, Qtd.Baixa, Produzir, #item, Peso, %Ent., Tam.
        loc_oPagina.AddObject("grd_4c_Itens", "Grid")
        loc_oPagina.grd_4c_Itens.ColumnCount = 10
        WITH loc_oPagina.grd_4c_Itens
            .Top                = 379
            .Left               = 23
            .Width              = 732
            .Height             = 191
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .AllowHeaderSizing  = .F.
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
            .BackColor          = RGB(255, 255, 255)
            .RowHeight          = 17
            .HeaderHeight       = 17
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.
        ENDWITH

        *-- Label Descricao do item (Say2: top=546+29=575, left=23)
        loc_oPagina.AddObject("lbl_4c_DescItem", "Label")
        WITH loc_oPagina.lbl_4c_DescItem
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Top       = 575
            .Left      = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao do item (Get_descr: top=562+29=591, left=23, width=454)
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value         = ""
            .ReadOnly      = .T.
            .Top           = 591
            .Left          = 23
            .Width         = 454
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .Visible       = .T.
        ENDWITH

        *-- Label Observacao do item (Say_Obs: top=544+29=573, left=496)
        loc_oPagina.AddObject("lbl_4c_ObsItem", "Label")
        WITH loc_oPagina.lbl_4c_ObsItem
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
            .Top       = 573
            .Left      = 496
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- EditBox Observacao do item (Get_obs: top=561+29=590, left=496, width=454, height=24)
        loc_oPagina.AddObject("txt_4c_ObsItem", "EditBox")
        WITH loc_oPagina.txt_4c_ObsItem
            .Value     = ""
            .ReadOnly  = .T.
            .Top       = 590
            .Left      = 496
            .Width     = 454
            .Height    = 24
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Imagem do produto (FigJpg: top=365+29=394, left=762, width=225, height=163, Visible=.F.)
        loc_oPagina.AddObject("img_4c_FigJpg", "Image")
        WITH loc_oPagina.img_4c_FigJpg
            .Top     = 394
            .Left    = 762
            .Width   = 225
            .Height  = 163
            .Stretch = 1
            .Visible = .F.
        ENDWITH

        *-- BINDEVENTs (metodos PUBLIC para funcionar com BINDEVENT)
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", ;
                  THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", ;
                  THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Entrega, "Click", ;
                  THIS, "BtnEntregaClick")
        BINDEVENT(loc_oPagina.cmd_4c_SubNiveis, "Click", ;
                  THIS, "BtnSubNiveisClick")
        BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", ;
                  THIS, "BtnCadastrosClick")
        BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", ;
                  THIS, "GrdItensAfterRowColChange")
        BINDEVENT(loc_oPagina.img_4c_FigJpg, "Click", ;
                  THIS, "ImgFigJpgClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega movimentos do tipo this_cDopes
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    IF VARTYPE(loc_oGrid) = "O"
                        *-- RecordSource fora de WITH (Problem 36: evita "Unknown member COLUMN1")
                        loc_oGrid.ColumnCount = 11
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        *-- ControlSource APOS RecordSource (auto-bind e substituido)
                        loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Numes"
                        loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Datas"
                        loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.GrupoOs"
                        loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.ContaOs"
                        loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.GrupoDs"
                        loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.ContaDs"
                        loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Nops"
                        loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Usuars"
                        loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.PStatus"
                        loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Emps"
                        loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Empds"

                        loc_oGrid.Column1.Width  = 70
                        loc_oGrid.Column2.Width  = 70
                        loc_oGrid.Column3.Width  = 80
                        loc_oGrid.Column4.Width  = 100
                        loc_oGrid.Column5.Width  = 80
                        loc_oGrid.Column6.Width  = 100
                        loc_oGrid.Column7.Width  = 70
                        loc_oGrid.Column8.Width  = 80
                        loc_oGrid.Column9.Width  = 55
                        loc_oGrid.Column10.Width = 50
                        loc_oGrid.Column11.Width = 55

                        *-- Headers APOS RecordSource (RecordSource reseta captions - Problem 2)
                        loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption  = "Data"
                        loc_oGrid.Column3.Header1.Caption  = "Grupo"
                        loc_oGrid.Column4.Header1.Caption  = "Origem"
                        loc_oGrid.Column5.Header1.Caption  = "Grupo"
                        loc_oGrid.Column6.Header1.Caption  = "Destino"
                        loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
                        loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column9.Header1.Caption  = "Status"
                        loc_oGrid.Column10.Header1.Caption = "EmpO"
                        loc_oGrid.Column11.Header1.Caption = "EmpD"

                        loc_oGrid.Refresh()
                    ENDIF

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_ItensPam")
            USE IN cursor_4c_ItensPam
        ENDIF
        IF USED("cursor_4c_ItensPamTemp")
            USE IN cursor_4c_ItensPamTemp
        ENDIF
        IF USED("cursor_4c_FigPro")
            USE IN cursor_4c_FigPro
        ENDIF
        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnConsultarClick - Carrega movimento selecionado e navega para Page2
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_cEmpDopNums, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na lista.", "Consultar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEmpDopNums = ALLTRIM(TratarNulo(EmpDopNums, "C"))

                IF EMPTY(loc_cEmpDopNums)
                    MsgAviso("Registro sem identificador v" + CHR(225) + "lido.", "Consultar")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEmpDopNums)
                        THIS.this_oBusinessObject.CarregarItens(loc_cEmpDopNums)
                        THIS.this_oBusinessObject.CarregarOperacao(THIS.this_cDopes)
                        THIS.BOParaForm()
                        THIS.CarregarOperacaoGrid()
                        THIS.CarregarItensGrid()
                        THIS.pgf_4c_Paginas.ActivePage = 2
                        THIS.this_cModoAtual = "VISUALIZAR"
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.BtnConsultarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarOperacaoGrid - Carrega lista de operacoes no grd_4c_Operacao
    *==========================================================================
    PROTECTED PROCEDURE CarregarOperacaoGrid()
        LOCAL loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF

                loc_cSQL = "SELECT a.Dopes FROM SigCdOpe a ORDER BY a.Dopes"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
                IF loc_nResultado >= 0
                    loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Operacao

                    IF VARTYPE(loc_oGrid) = "O"
                        loc_oGrid.ColumnCount = 1
                        loc_oGrid.RecordSource = "cursor_4c_Operacoes"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Dopes"
                        loc_oGrid.Column1.Width = 110
                        loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Refresh()
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.CarregarOperacaoGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Popula campos da Page2 a partir do Business Object
    * (Fase 5: campos do cabecalho - Numes, Datas, PrazoEnts, Nops, Notas, Tabds, PStatus)
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO, loc_oPagina
        loc_oBO     = THIS.this_oBusinessObject
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Codigo do movimento (MascNum mascarado ou Numes numerico)
            IF VARTYPE(loc_oPagina.txt_4c_Codigo) = "O"
                IF !EMPTY(loc_oBO.this_cMascNum)
                    loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(loc_oBO.this_cMascNum)
                ELSE
                    loc_oPagina.txt_4c_Codigo.Value = TRANSFORM(loc_oBO.this_nNumes)
                ENDIF
            ENDIF

            *-- Data do movimento
            IF VARTYPE(loc_oPagina.txt_4c_Data) = "O"
                loc_oPagina.txt_4c_Data.Value = loc_oBO.this_dDatas
            ENDIF

            *-- Prazo de entrega
            IF VARTYPE(loc_oPagina.txt_4c_PrvEnts) = "O"
                loc_oPagina.txt_4c_PrvEnts.Value = loc_oBO.this_dPrazoEnts
            ENDIF

            *-- Numero da OP
            IF VARTYPE(loc_oPagina.txt_4c_Nop) = "O"
                IF loc_oBO.this_nNops > 0
                    loc_oPagina.txt_4c_Nop.Value = TRANSFORM(loc_oBO.this_nNops)
                ELSE
                    loc_oPagina.txt_4c_Nop.Value = ""
                ENDIF
            ENDIF

            *-- Numero do documento (Notas)
            IF VARTYPE(loc_oPagina.txt_4c_Nota) = "O"
                loc_oPagina.txt_4c_Nota.Value = ALLTRIM(loc_oBO.this_cNotas)
            ENDIF

            *-- Tabela de desconto
            IF VARTYPE(loc_oPagina.txt_4c_Tabd) = "O"
                loc_oPagina.txt_4c_Tabd.Value = ALLTRIM(loc_oBO.this_cTabds)
            ENDIF

            *-- Status do pedido
            IF VARTYPE(loc_oPagina.txt_4c_PStatus) = "O"
                loc_oPagina.txt_4c_PStatus.Value = ALLTRIM(loc_oBO.this_cPStatus)
            ENDIF

            *-- Container Origem: grupos e contas de Origem, Destino e Representante
            IF VARTYPE(loc_oPagina.cnt_4c_Origem) = "O"
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOs) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(loc_oBO.this_cGrupoOs)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOs) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_ContaOs.Value = ALLTRIM(loc_oBO.this_cContaOs)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_Dconta) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_Dconta.Value = ;
                        loc_oBO.CarregarDescricaoConta(loc_oBO.this_cContaOs)
                ENDIF

                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoDs) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_GrupoDs.Value = ALLTRIM(loc_oBO.this_cGrupoDs)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_ContaD) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_ContaD.Value = ALLTRIM(loc_oBO.this_cContaDs)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_Dcontad) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_Dcontad.Value = ;
                        loc_oBO.CarregarDescricaoConta(loc_oBO.this_cContaDs)
                ENDIF

                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_GruResp) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_GruResp.Value = ALLTRIM(loc_oBO.this_cGrresps)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_Resps) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_Resps.Value = ALLTRIM(loc_oBO.this_cResps)
                ENDIF
                IF VARTYPE(loc_oPagina.cnt_4c_Origem.txt_4c_Dresps) = "O"
                    loc_oPagina.cnt_4c_Origem.txt_4c_Dresps.Value = ;
                        loc_oBO.CarregarDescricaoConta(loc_oBO.this_cResps)
                ENDIF
            ENDIF

            *-- Container1: observacoes do movimento (Obses)
            IF VARTYPE(loc_oPagina.cnt_4c_Container1) = "O"
                IF VARTYPE(loc_oPagina.cnt_4c_Container1.txt_4c_MemoObs) = "O"
                    loc_oPagina.cnt_4c_Container1.txt_4c_MemoObs.Value = loc_oBO.this_cObses
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - Confirma consulta e volta para lista (OK)
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnEntregaClick - Abre form de entrega SigOpEnt (se disponivel)
    *==========================================================================
    PROCEDURE BtnEntregaClick()
        LOCAL loc_oBO, loForm, loException
        loc_oBO = THIS.this_oBusinessObject

        IF EMPTY(loc_oBO.this_cEmpDopNums)
            MsgAviso("Nenhum movimento carregado.", "Entrega")
            RETURN
        ENDIF

        TRY
            loForm = CREATEOBJECT("Formsigopent")
            IF VARTYPE(loForm) = "O"
                loForm.Show()
            ELSE
                MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
                         CHR(237) + "vel.", "Entrega")
            ENDIF
        CATCH TO loException
            MsgAviso("Form de entrega (SigOpEnt) n" + CHR(227) + "o dispon" + ;
                     CHR(237) + "vel.", "Entrega")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSubNiveisClick - Abre form de subniveis SigMvSbn (se disponivel)
    *==========================================================================
    PROCEDURE BtnSubNiveisClick()
        LOCAL loc_oBO, loForm, loException
        loc_oBO = THIS.this_oBusinessObject

        IF EMPTY(loc_oBO.this_cEmpDopNums)
            MsgAviso("Nenhum movimento carregado.", "Sub" + CHR(237) + "veis")
            RETURN
        ENDIF

        TRY
            loForm = CREATEOBJECT("Formsigmvsbn")
            IF VARTYPE(loForm) = "O"
                loForm.Show()
            ELSE
                MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
                         "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
            ENDIF
        CATCH TO loException
            MsgAviso("Form de sub" + CHR(237) + "veis (SigMvSbn) n" + CHR(227) + ;
                     "o dispon" + CHR(237) + "vel.", "Sub" + CHR(237) + "veis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarItensGrid - Carrega itens do movimento em grd_4c_Itens
    * JOIN SigMvPec + SigCdPam para descricao do produto (DPros)
    *==========================================================================
    PROTECTED PROCEDURE CarregarItensGrid()
        LOCAL loc_cEmpDopNums, loc_cSQL, loc_nResultado, loc_oGrid, loc_lSucesso
        loc_cEmpDopNums = ""
        loc_lSucesso    = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                loc_cEmpDopNums = THIS.this_oBusinessObject.this_cEmpDopNums

                IF !EMPTY(loc_cEmpDopNums)
                    IF USED("cursor_4c_ItensPam")
                        USE IN cursor_4c_ItensPam
                    ENDIF

                    loc_cSQL = "SELECT a.Codigos AS CPros," + ;
                               " ISNULL(a.Cidchaves, 0) AS Produzido," + ;
                               " ISNULL(a.Ntrans, 0) AS Ntrans," + ;
                               " (ISNULL(a.Ntrans, 0) - ISNULL(a.Valobxs, 0)) AS Saldo," + ;
                               " ISNULL(a.Valobxs, 0) AS Valobxs," + ;
                               " CASE WHEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))>0" + ;
                               " THEN (ISNULL(a.Ntrans,0)-ISNULL(a.Valobxs,0)-ISNULL(a.Cidchaves,0))" + ;
                               " ELSE 0 END AS Produzir," + ;
                               " ISNULL(a.Nparcs, 0) AS Nparcs," + ;
                               " CAST(0 AS DECIMAL(8,2)) AS Pesos," + ;
                               " CASE WHEN ISNULL(a.Ntrans,0)>0" + ;
                               " THEN CAST((ISNULL(a.Valobxs,0)*100.0/a.Ntrans) AS DECIMAL(8,2))" + ;
                               " ELSE CAST(0 AS DECIMAL(8,2)) END AS PctEnt," + ;
                               " ISNULL(a.Locals,'') AS Locals," + ;
                               " ISNULL(p.DPros,'') AS DPros" + ;
                               " FROM SigMvPec a" + ;
                               " LEFT JOIN SigCdPam p ON p.MascNums = a.Codigos" + ;
                               " WHERE a.EmpDopNums = " + EscaparSQL(loc_cEmpDopNums) + ;
                               " ORDER BY a.Codigos"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPam")

                    IF loc_nResultado >= 0
                        loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_Itens

                        IF VARTYPE(loc_oGrid) = "O"
                            loc_oGrid.ColumnCount = 10
                            loc_oGrid.RecordSource = "cursor_4c_ItensPam"

                            loc_oGrid.Column1.ControlSource  = "cursor_4c_ItensPam.CPros"
                            loc_oGrid.Column2.ControlSource  = "cursor_4c_ItensPam.Produzido"
                            loc_oGrid.Column3.ControlSource  = "cursor_4c_ItensPam.Ntrans"
                            loc_oGrid.Column4.ControlSource  = "cursor_4c_ItensPam.Saldo"
                            loc_oGrid.Column5.ControlSource  = "cursor_4c_ItensPam.Valobxs"
                            loc_oGrid.Column6.ControlSource  = "cursor_4c_ItensPam.Produzir"
                            loc_oGrid.Column7.ControlSource  = "cursor_4c_ItensPam.Nparcs"
                            loc_oGrid.Column8.ControlSource  = "cursor_4c_ItensPam.Pesos"
                            loc_oGrid.Column9.ControlSource  = "cursor_4c_ItensPam.PctEnt"
                            loc_oGrid.Column10.ControlSource = "cursor_4c_ItensPam.Locals"

                            loc_oGrid.Column1.Width  = 80
                            loc_oGrid.Column2.Width  = 65
                            loc_oGrid.Column3.Width  = 55
                            loc_oGrid.Column4.Width  = 55
                            loc_oGrid.Column5.Width  = 60
                            loc_oGrid.Column6.Width  = 55
                            loc_oGrid.Column7.Width  = 35
                            loc_oGrid.Column8.Width  = 55
                            loc_oGrid.Column9.Width  = 45
                            loc_oGrid.Column10.Width = 40

                            loc_oGrid.Column1.Header1.Caption  = "Produto"
                            loc_oGrid.Column2.Header1.Caption  = "Produzido"
                            loc_oGrid.Column3.Header1.Caption  = "Qtd."
                            loc_oGrid.Column4.Header1.Caption  = "Saldo"
                            loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
                            loc_oGrid.Column6.Header1.Caption  = "Produzir"
                            loc_oGrid.Column7.Header1.Caption  = ""
                            loc_oGrid.Column8.Header1.Caption  = "Peso"
                            loc_oGrid.Column9.Header1.Caption  = "%Ent."
                            loc_oGrid.Column10.Header1.Caption = "Tam."

                            loc_oGrid.Refresh()

                            IF RECCOUNT("cursor_4c_ItensPam") > 0
                                SELECT cursor_4c_ItensPam
                                GO TOP
                                THIS.GrdItensAfterRowColChange(0)
                            ELSE
                                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Descr) = "O"
                                    THIS.pgf_4c_Paginas.Page2.txt_4c_Descr.Value = ""
                                ENDIF
                                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem) = "O"
                                    THIS.pgf_4c_Paginas.Page2.txt_4c_ObsItem.Value = ""
                                ENDIF
                                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
                                    THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture = ""
                                    THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Visible = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao carregar itens do movimento:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.CarregarItensGrid")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GrdItensAfterRowColChange - Atualiza descricao, obs e imagem do item
    *==========================================================================
    PROCEDURE GrdItensAfterRowColChange(par_nColIndex)
        LOCAL loc_oPagina, loc_cCPros, loc_cDPros, loc_cSQLFig, loc_nFig
        LOCAL loc_cFigJpgs, loc_lVazio
        loc_oPagina  = THIS.pgf_4c_Paginas.Page2
        loc_cCPros   = ""
        loc_cDPros   = ""
        loc_cSQLFig  = ""
        loc_nFig     = 0
        loc_cFigJpgs = ""
        loc_lVazio   = .F.

        TRY
            IF !USED("cursor_4c_ItensPam") OR EOF("cursor_4c_ItensPam")
                loc_lVazio = .T.
            ELSE
                SELECT cursor_4c_ItensPam
                loc_cCPros = ALLTRIM(TratarNulo(CPros, "C"))
                loc_cDPros = ALLTRIM(TratarNulo(DPros, "C"))
            ENDIF

            IF loc_lVazio
                IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
                    loc_oPagina.txt_4c_Descr.Value = ""
                ENDIF
                IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
                    loc_oPagina.txt_4c_ObsItem.Value = ""
                ENDIF
                IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
                    loc_oPagina.img_4c_FigJpg.Picture = ""
                    loc_oPagina.img_4c_FigJpg.Visible = .F.
                ENDIF
            ELSE
                IF VARTYPE(loc_oPagina.txt_4c_Descr) = "O"
                    loc_oPagina.txt_4c_Descr.Value = loc_cDPros
                ENDIF
                IF VARTYPE(loc_oPagina.txt_4c_ObsItem) = "O"
                    loc_oPagina.txt_4c_ObsItem.Value = ""
                ENDIF

                *-- Imagem do produto via SigCdPro.FigJpgs
                IF !EMPTY(loc_cCPros)
                    IF USED("cursor_4c_FigPro")
                        USE IN cursor_4c_FigPro
                    ENDIF
                    loc_cSQLFig = "SELECT TOP 1 a.FigJpgs FROM SigCdPro a" + ;
                                  " WHERE a.MascNums = " + EscaparSQL(loc_cCPros)
                    loc_nFig = SQLEXEC(gnConnHandle, loc_cSQLFig, "cursor_4c_FigPro")
                    IF loc_nFig >= 0 AND RECCOUNT("cursor_4c_FigPro") > 0
                        SELECT cursor_4c_FigPro
                        loc_cFigJpgs = ALLTRIM(TratarNulo(FigJpgs, "C"))
                    ENDIF
                    IF USED("cursor_4c_FigPro")
                        USE IN cursor_4c_FigPro
                    ENDIF
                ENDIF

                IF VARTYPE(loc_oPagina.img_4c_FigJpg) = "O"
                    IF !EMPTY(loc_cFigJpgs) AND FILE(loc_cFigJpgs)
                        loc_oPagina.img_4c_FigJpg.Picture = loc_cFigJpgs
                        loc_oPagina.img_4c_FigJpg.Visible = .T.
                    ELSE
                        loc_oPagina.img_4c_FigJpg.Picture = ""
                        loc_oPagina.img_4c_FigJpg.Visible = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.GrdItensAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ImgFigJpgClick - Abre imagem do produto no visualizador padrao
    *==========================================================================
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_cPicture
        loc_cPicture = ""

        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg) = "O"
                loc_cPicture = THIS.pgf_4c_Paginas.Page2.img_4c_FigJpg.Picture
            ENDIF
            IF !EMPTY(loc_cPicture) AND FILE(loc_cPicture)
                DECLARE INTEGER ShellExecute IN shell32 ;
                    INTEGER hwnd, STRING lpVerb, STRING lpFile, ;
                    STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
                ShellExecute(0, "open", loc_cPicture, "", "", 1)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.ImgFigJpgClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
    * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
    * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Carrega movimento selecionado e navega para Page2
    * Equivalente ao BtnConsultarClick (Value=2 no CommandGroup original)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.BtnConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Nao aplicavel: form OPERACIONAL (consulta apenas)
    * Original: Inlist(This.Value, 1,3,4,5) -> mAtivaPagina1 (retorna lista)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnCadastrosClick - Abre cadastro da conta destino selecionada
    *==========================================================================
    PROCEDURE BtnCadastrosClick()
        LOCAL loc_cContaD, loForm
        loc_cContaD = ""

        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem) = "O"
                IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD) = "O"
                    loc_cContaD = ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem.txt_4c_ContaD.Value)
                ENDIF
            ENDIF

            IF EMPTY(loc_cContaD)
                MsgAviso("Nenhuma conta destino definida.", "Cadastro")
            ELSE
                loForm = CREATEOBJECT("Formsigcdcli")
                IF VARTYPE(loForm) = "O"
                    loForm.Show()
                ELSE
                    MsgAviso("Form de cadastro de contas n" + CHR(227) + ;
                             "o dispon" + CHR(237) + "vel.", "Cadastro")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.BtnCadastrosClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega lista de movimentos (Procurar oculto no original)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Alias de BtnConfirmarClick (confirmar consulta = volta lista)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Nao aplicavel: form OPERACIONAL (todos campos ReadOnly)
    * Implementado para conformidade com a interface padrao FormBase
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        *-- Formulario OPERACIONAL: campos sao somente leitura, sem transferencia
        *-- de dados do form para o BO. O BO e populado via CarregarPorCodigo().
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Nao aplicavel: form OPERACIONAL (todos ReadOnly)
    * Implementado para conformidade com a interface padrao FormBase
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Todos os campos sao ReadOnly=.T. por definicao neste form operacional.
        *-- Nao ha campos editaveis para habilitar/desabilitar.
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de exibicao da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_oCnt
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
                loc_oPg2.txt_4c_Codigo.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
                loc_oPg2.txt_4c_Data.Value = {}
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_PrvEnts) = "O"
                loc_oPg2.txt_4c_PrvEnts.Value = {}
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Nop) = "O"
                loc_oPg2.txt_4c_Nop.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Nota) = "O"
                loc_oPg2.txt_4c_Nota.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Tabd) = "O"
                loc_oPg2.txt_4c_Tabd.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_PStatus) = "O"
                loc_oPg2.txt_4c_PStatus.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
                loc_oPg2.txt_4c_Descr.Value = ""
            ENDIF
            IF VARTYPE(loc_oPg2.txt_4c_ObsItem) = "O"
                loc_oPg2.txt_4c_ObsItem.Value = ""
            ENDIF

            loc_oCnt = loc_oPg2.cnt_4c_Origem
            IF VARTYPE(loc_oCnt) = "O"
                IF VARTYPE(loc_oCnt.txt_4c_GrupoOs) = "O"
                    loc_oCnt.txt_4c_GrupoOs.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_ContaOs) = "O"
                    loc_oCnt.txt_4c_ContaOs.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_Dconta) = "O"
                    loc_oCnt.txt_4c_Dconta.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_GrupoDs) = "O"
                    loc_oCnt.txt_4c_GrupoDs.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_ContaD) = "O"
                    loc_oCnt.txt_4c_ContaD.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_Dcontad) = "O"
                    loc_oCnt.txt_4c_Dcontad.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_GruResp) = "O"
                    loc_oCnt.txt_4c_GruResp.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_Resps) = "O"
                    loc_oCnt.txt_4c_Resps.Value = ""
                ENDIF
                IF VARTYPE(loc_oCnt.txt_4c_Dresps) = "O"
                    loc_oCnt.txt_4c_Dresps.Value = ""
                ENDIF
            ENDIF

            IF VARTYPE(loc_oPg2.cnt_4c_Container1) = "O"
                IF VARTYPE(loc_oPg2.cnt_4c_Container1.txt_4c_MemoObs) = "O"
                    loc_oPg2.cnt_4c_Container1.txt_4c_MemoObs.Value = ""
                ENDIF
            ENDIF

            IF VARTYPE(loc_oPg2.img_4c_FigJpg) = "O"
                loc_oPg2.img_4c_FigJpg.Picture = ""
                loc_oPg2.img_4c_FigJpg.Visible = .F.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta visibilidade de botoes conforme o modo
    * LISTA: habilita Consultar, desabilita botoes de Page2
    * VISUALIZAR: habilita Confirmar/Cancelar, SubNiveis, Entrega
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lLista
        loc_lLista = (THIS.this_cModoAtual == "LISTA")

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            *-- Page1: botao Consultar habilitado apenas no modo LISTA
            IF VARTYPE(loc_oPg1.cnt_4c_Botoes) = "O"
                IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar) = "O"
                    loc_oPg1.cnt_4c_Botoes.cmd_4c_Consultar.Enabled = loc_lLista
                ENDIF
            ENDIF

            *-- Page2: botoes de acao habilitados apenas no modo VISUALIZAR
            IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
                IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lLista
                ENDIF
                IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar) = "O"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = !loc_lLista
                ENDIF
            ENDIF

            IF VARTYPE(loc_oPg2.cmd_4c_SubNiveis) = "O"
                loc_oPg2.cmd_4c_SubNiveis.Enabled = !loc_lLista
            ENDIF

            IF VARTYPE(loc_oPg2.cmd_4c_Entrega) = "O"
                loc_oPg2.cmd_4c_Entrega.Enabled = !loc_lLista
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "Formsigpres2.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* sigpres2BO.prg - Business Object para SIGPRES2 (Detalhe de Movimento)
* Herda de BusinessBase
* Formulario OPERACIONAL - consulta de itens de movimento de pedido
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento: Emps+Dopes+Str(Numes,6) padded
    this_cEmpDopNums = ""

    *-- Identificacao do movimento
    this_cEmps        = ""  && Empresa origem C(3)
    this_cDopes       = ""  && Tipo de operacao C(20)
    this_nNumes       = 0   && Numero do movimento N(6,0)
    this_cChave       = ""  && _Chave passado no Init (= Dopes)
    this_cMascNum     = ""  && Codigo mascarado do movimento C(10) - SigMvCab.mascnum

    *-- Cabecalho do movimento (SigMvCab)
    this_dDatas       = {}  && Data do movimento D - SigMvCab.datas
    this_cNotas       = ""  && Numero do documento C(6) - SigMvCab.notas
    this_nNops        = 0   && Numero da OP N - SigMvCab.nops
    this_cPStatus     = ""  && Status do pedido C(1) - SigMvCab.pstatus
    this_cTabds       = ""  && Tabela de desconto C(10) - SigMvCab.tabds
    this_cUsuars      = ""  && Usuario C(10) - SigMvCab.usuars
    this_dPrazoEnts   = {}  && Prazo de entrega D - SigMvCab.prazoents
    this_cObses       = ""  && Observacoes do movimento C/M - SigMvCab.obses
    this_lChkSubn     = .F. && Possui sub-niveis L - SigMvCab.chksubn
    this_lChkBxParcs  = .F. && Baixa parcial L - SigMvCab.chkbxparcs

    *-- Origem (conta origem) - SigMvCab
    this_cGrupoOs     = ""  && Grupo de conta origem C(10) - SigMvCab.grupoos
    this_cContaOs     = ""  && Conta origem C(10) - SigMvCab.contaos
    this_cDContaOs    = ""  && Descricao da conta origem C (de SigCdCli)

    *-- Destino (conta destino) - SigMvCab
    this_cGrupoDs     = ""  && Grupo de conta destino C(10) - SigMvCab.grupods
    this_cContaDs     = ""  && Conta destino C(10) - SigMvCab.contads
    this_cDContaDs    = ""  && Descricao da conta destino C (de SigCdCli)
    this_cEmpds       = ""  && Empresa destino C(3) - SigMvCab.empds

    *-- Vendedor - SigMvCab
    this_cGrvends     = ""  && Grupo do vendedor C(10) - SigMvCab.grvends
    this_cVends       = ""  && Codigo do vendedor C(10) - SigMvCab.vends
    this_cDVends      = ""  && Descricao do vendedor C (de SigCdCli)

    *-- Representante - SigMvCab
    this_cGrresps     = ""  && Grupo do representante C(10) - SigMvCab.grresps
    this_cResps       = ""  && Codigo do representante C(10) - SigMvCab.resps
    this_cDResps      = ""  && Descricao do representante C (de SigCdCli)

    *-- Configuracao da operacao (SigCdOpe)
    this_nBlqDatas    = 0   && Bloqueio de datas N - SigCdOpe.blqdatas
    this_nDtEntrs     = 0   && Tipo de entrega N - SigCdOpe.dtentrs

    *-- Tipo de instalacao (global gcTpInstalas)
    this_cTpInstalas  = ""  && Tipo de instalacao C

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos filtrados pelo Dopes (operacao)
    * par_cFiltro: filtro SQL adicional (WHERE clause extra, sem WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs," + ;
                       " a.Nops, a.Usuars, a.PStatus, a.Empds" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes)

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar movimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do movimento por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Emps, a.Dopes, a.Numes, a.MascNum," + ;
                       " a.Datas, a.Notas, a.Nops, a.PStatus, a.Tabds, a.Usuars," + ;
                       " a.PrazoEnts, a.Obses, a.ChkSubn, a.ChkBxParcs," + ;
                       " a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.Empds," + ;
                       " a.Vends, a.Grvends, a.Resps, a.Grresps" + ;
                       " FROM SigMvCab a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps, "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes, "C"))
            THIS.this_nNumes       = TratarNulo(Numes, "N")

            *-- MascNum so existe no cursor completo (CarregarPorCodigo)
            IF TYPE("MascNum") != "U"
                THIS.this_cMascNum = ALLTRIM(TratarNulo(MascNum, "C"))
            ENDIF

            THIS.this_dDatas       = TratarNulo(Datas, "D")
            THIS.this_dPrazoEnts   = TratarNulo(PrazoEnts, "D")
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas, "C"))
            THIS.this_nNops        = TratarNulo(Nops, "N")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus, "C"))
            THIS.this_cTabds       = ALLTRIM(TratarNulo(Tabds, "C"))
            THIS.this_cUsuars      = ALLTRIM(TratarNulo(Usuars, "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_lChkSubn     = (TratarNulo(ChkSubn, "N") = 1)
            THIS.this_lChkBxParcs  = (TratarNulo(ChkBxParcs, "N") = 1)

            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs, "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs, "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs, "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs, "C"))
            THIS.this_cEmpds       = ALLTRIM(TratarNulo(Empds, "C"))

            THIS.this_cGrvends     = ALLTRIM(TratarNulo(Grvends, "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends, "C"))
            THIS.this_cGrresps     = ALLTRIM(TratarNulo(Grresps, "C"))
            THIS.this_cResps       = ALLTRIM(TratarNulo(Resps, "C"))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega itens do movimento (SigMvPec) por EmpDopNums
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.EmpDopNums, a.Codigos, a.Emps, a.Dopes, a.Numes," + ;
                       " a.Datas, a.Ntrans, a.Locals, a.Valobxs, a.Cidchaves," + ;
                       " a.ChkSubn, a.ChkPagos, a.Nparcs, a.Valps, a.PStatus" + ;
                       " FROM SigMvPec a" + ;
                       " WHERE a.EmpDopNums = " + EscaparSQL(par_cEmpDopNums) + ;
                       " ORDER BY a.Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarItens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega configuracao da operacao (SigCdOpe)
    * Popula this_nBlqDatas e this_nDtEntrs
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cDopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT a.Dopes, a.BlqDatas, a.DtEntrs" + ;
                       " FROM SigCdOpe a" + ;
                       " WHERE a.Dopes = " + EscaparSQL(par_cDopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Operacao") > 0
                SELECT cursor_4c_Operacao
                THIS.this_nBlqDatas = TratarNulo(BlqDatas, "N")
                THIS.this_nDtEntrs  = TratarNulo(DtEntrs, "N")
                loc_lSucesso = .T.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescricaoConta - Carrega descricao de uma conta (SigCdCli)
    * Retorna a descricao ou string vazia se nao encontrado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricaoConta(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        IF EMPTY(par_cConta)
            RETURN loc_cDescricao
        ENDIF

        TRY
            IF USED("cursor_4c_DescConta")
                USE IN cursor_4c_DescConta
            ENDIF

            loc_cSQL = "SELECT TOP 1 a.IClis, a.Rclis" + ;
                       " FROM SigCdCli a" + ;
                       " WHERE a.IClis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescConta") > 0
                SELECT cursor_4c_DescConta
                loc_cDescricao = ALLTRIM(TratarNulo(Rclis, "C"))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarDescricaoConta:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF

        RETURN loc_cDescricao
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        MsgErro("Inser" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab (data, contas origem/destino, obs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpDopNums)
            MsgErro("Chave do movimento n" + CHR(227) + "o definida.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " GrupoOs = " + EscaparSQL(THIS.this_cGrupoOs) + "," + ;
                       " ContaOs = " + EscaparSQL(THIS.this_cContaOs) + "," + ;
                       " GrupoDs = " + EscaparSQL(THIS.this_cGrupoDs) + "," + ;
                       " ContaDs = " + EscaparSQL(THIS.this_cContaDs) + "," + ;
                       " Vends = " + EscaparSQL(THIS.this_cVends) + "," + ;
                       " Grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoEnts) + "," + ;
                       " Notas = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                       " Tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " Obses = " + EscaparSQL(THIS.this_cObses) + "," + ;
                       " DtAlts = GETDATE()" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNums)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - NAO aplicavel para este formulario operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        MsgErro("Exclus" + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
                CHR(237) + "vel neste formul" + CHR(225) + "rio.", "Aviso")
        RETURN .F.
    ENDPROC

ENDDEFINE

