# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormFpo.prg] Procedure vazia (sem codigo): GradeAfterRowColChange

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpo.prg):
*==============================================================================
* FormFpo.prg - Condicao de Pagamento Por Operacao
* Migrado de: SIGCDFPO.SCX (Form Operacional - dialogo grid inline)
* Tabela principal: SigOpFpo (condicoes de pagamento por operacao)
* Chamado de: FormSigCdOpe (cadastro de operacoes)
* Propriedade this_cDopes DEVE ser definida antes de Show()
*==============================================================================

DEFINE CLASS FormFpo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 1

    *-- Propriedades de estado e BO
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cDopes          = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario via FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado automaticamente pelo FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Condi" + CHR(231) + CHR(227) + ;
                "o de Pagamento Por Opera" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("FpoBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar FpoBO", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ELSE
                THIS.ConfigurarPageFrame()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                        THIS.CarregarGrade()
                    ENDIF
                    THIS.pgf_4c_Paginas.ActivePage = 1
                ENDIF

                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount  = 2
                .Top        = -29
                .Left       = 0
                .Width      = THIS.Width
                .Height     = THIS.Height + 29
                .Tabs       = .F.
                .Visible    = .T.
                .Page1.Caption   = "Lista"
                .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page1.BackColor = RGB(255, 255, 255)
                .Page2.Caption   = "Dados"
                .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.BackColor = RGB(255, 255, 255)
            ENDWITH

            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.pgf_4c_Paginas.Visible = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 com cabecalho, botoes e grade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cabecalho cinza escuro (cntSombra no legado)
            *-- Top=31 = 2 + 29 (compensacao PageFrame.Top = -29)
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
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .Caption   = THIS.Caption
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .Caption   = THIS.Caption
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Container de botoes operacionais (cmdInserir/cmdExcluir/cmdSair no legado)
            *-- Top=29 = 0 + 29 (compensacao PageFrame.Top = -29)
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            WITH loc_oPagina.cnt_4c_Botoes
                .Top         = 29
                .Left        =  542
                .Width       = 300
                .Height      = 85
                .BackStyle = 0
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            *-- Botao Inserir (cmdInserir no legado)
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            *-- Botao Excluir (cmdExcluir no legado)
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            *-- Botao Encerrar/Sair - valida, salva e fecha (cmdSair no legado)
            loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            *-- BINDEVENTs para botoes operacionais
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

            *-- Grade de dados (GradeFPagto no legado)
            *-- RecordSource sera definido em CarregarGrade() apos carga dos dados
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oPagina.grd_4c_Dados.ColumnCount = 5
            WITH loc_oPagina.grd_4c_Dados
                .Top                = 120
                .Left               = 12
                .Width              = 680
                .Height             = 380
                .FontName           = "Tahoma"
                .FontSize           = 8
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 20
                .GridLineColor      = RGB(200, 200, 200)
                .GridLines          = 3
                .HighlightStyle     = 2
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .ScrollBars         = 2
                .Visible            = .T.
            ENDWITH

            *-- BINDEVENTs para colunas de texto (F4 abre lookup de condicao de pagamento)
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GradeCol1KeyPress")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GradeCol5KeyPress")
            BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")

            *-- BINDEVENTs para CheckBoxes das colunas O/A/C (KeyPress para toggle Enter/Space)
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Check1, "KeyPress", THIS, "GradeCol2CheckKeyPress")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Check1, "KeyPress", THIS, "GradeCol3CheckKeyPress")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Check1, "KeyPress", THIS, "GradeCol4CheckKeyPress")

            *-- BINDEVENT para ordenacao por clique no Header e LostFocus de validacao
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Header1, "Click",     THIS, "GradeCol1HeaderClick")
            BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1,   "KeyPress", THIS, "GradeCol1TextLostFocus")

            *-- Labels de legenda (Say1/Say2/Say3 do legado)
            loc_oPagina.AddObject("lbl_4c_Say1", "Label")
            WITH loc_oPagina.lbl_4c_Say1
                .Caption   = "O = Obrigat" + CHR(243) + "rio"
                .Top       = 510
                .Left      = 237
                .Width     = 100
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(216, 39, 70)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Say2", "Label")
            WITH loc_oPagina.lbl_4c_Say2
                .Caption   = "A = S" + CHR(243) + " Auto"
                .Top       = 510
                .Left      = 277
                .Width     = 80
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 128)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Say3", "Label")
            WITH loc_oPagina.lbl_4c_Say3
                .Caption   = "C = N" + CHR(195) + "O Contabilizar"
                .Top       = 510
                .Left      = 315
                .Width     = 145
                .Height    = 15
                .BackStyle = 0
                .ForeColor = RGB(0, 128, 255)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 com cabecalho e botoes Confirmar/Cancelar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cabecalho cinza (mesmo estilo da Page1)
            *-- Top=31 = 2 + 29 (compensacao PageFrame.Top = -29)
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
                .Top       = 18
                .Left      = 10
                .Width     = 769
                .Height    = 40
                .Caption   = THIS.Caption
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = 769
                .Height    = 46
                .Caption   = THIS.Caption
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            *-- Container de botoes de acao (Confirmar/Cancelar)
            *-- Top=33 = 4 + 29 (compensacao PageFrame.Top = -29)
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            WITH loc_oPagina.cnt_4c_BotoesAcao
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
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
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

            THIS.TornarControlesVisiveis(loc_oPagina)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("crSigOpFp")
                USE IN crSigOpFp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGrade - Carrega dados de SigOpFpo em cursor_4c_Dados e configura
    * a grade. Usa CREATE CURSOR para manter cursor editavel (APPEND BLANK/REPLACE
    * funcionam sem restricoes, ao contrario de cursor de SQLEXEC direto).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGrade()
        LOCAL loc_lResultado, loc_oGrid, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo" + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ;
                       " ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado < 0
                MsgErro(CapturarErroSQL(), "Erro ao carregar grade")
            ELSE
                *-- Criar ou reinicializar cursor editavel para a grade (Problema 34/35)
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (;
                        CidChaves C(20), Dopes C(20), FPags C(12), ;
                        Obrigs    N(1,0), Autos N(1,0), Contabs N(1,0), ;
                        FPagss    C(12),  BlqAltExc N(1,0))
                    SET NULL OFF
                ELSE
                    ZAP IN cursor_4c_Dados
                ENDIF

                IF RECCOUNT("cursor_4c_DadosTemp") > 0
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ENDIF
                GO TOP IN cursor_4c_Dados

                *-- Carregar cursor de lookup de condicoes de pagamento (crSigOpFp)
                THIS.this_oBusinessObject.BuscarCondicoesPagamento()

                *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"
                loc_oGrid.ColumnCount  = 5

                *-- Configurar colunas APOS RecordSource (Problema 48)
                WITH loc_oGrid
                    .Column1.ControlSource   = "cursor_4c_Dados.FPags"
                    .Column1.Width           = 230
                    .Column1.Sparse          = .T.
                    .Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
                    .Column1.Text1.MaxLength = 12

                    .Column2.ControlSource   = "cursor_4c_Dados.Obrigs"
                    .Column2.Width           = 42
                    .Column2.Sparse          = .F.
                    .AddObject("Check1", "CheckBox")
                    .Check1.Caption = ""
                    .Check1.Alignment = 0
                    .Check1.ReadOnly  = .F.
                    .Check1.Visible   = .T.
                    .Check1.Top       = 9
                    .Check1.Left      = 2
                    .Check1.Height    = 17
                    .Check1.Width     = 22
                    .Column2.CurrentControl  = "Check1"
                    .Column2.Header1.Caption = "O"
                    .Column2.Check1.Alignment = 0
                    .Column2.Check1.ReadOnly  = .F.
                    .Column2.Check1.Visible   = .T.
                    .Column2.Check1.Top       = 9
                    .Column2.Check1.Left      = 2
                    .Column2.Check1.Height    = 17
                    .Column2.Check1.Width     = 22
                    .Column2.Check1.Caption   = ""

                    .Column3.ControlSource   = "cursor_4c_Dados.Autos"
                    .Column3.Width           = 42
                    .Column3.Sparse          = .F.
                    .AddObject("Check1", "CheckBox")
                    .Check1.Caption = ""
                    .Check1.Alignment = 0
                    .Check1.ReadOnly  = .F.
                    .Check1.Visible   = .T.
                    .Check1.Top       = 9
                    .Check1.Left      = 2
                    .Check1.Height    = 17
                    .Check1.Width     = 22
                    .Column3.CurrentControl  = "Check1"
                    .Column3.Header1.Caption = "A"
                    .Column3.Check1.Alignment = 0
                    .Column3.Check1.ReadOnly  = .F.
                    .Column3.Check1.Visible   = .T.
                    .Column3.Check1.Top       = 9
                    .Column3.Check1.Left      = 2
                    .Column3.Check1.Height    = 17
                    .Column3.Check1.Width     = 22
                    .Column3.Check1.Caption   = ""

                    .Column4.ControlSource   = "cursor_4c_Dados.Contabs"
                    .Column4.Width           = 42
                    .Column4.Sparse          = .F.
                    .AddObject("Check1", "CheckBox")
                    .Check1.Caption = ""
                    .Check1.Alignment = 0
                    .Check1.ReadOnly  = .F.
                    .Check1.Visible   = .T.
                    .Check1.Top       = 9
                    .Check1.Left      = 2
                    .Check1.Height    = 17
                    .Check1.Width     = 22
                    .Column4.CurrentControl  = "Check1"
                    .Column4.Header1.Caption = "C"
                    .Column4.Check1.Alignment = 0
                    .Column4.Check1.ReadOnly  = .F.
                    .Column4.Check1.Visible   = .T.
                    .Column4.Check1.Top       = 9
                    .Column4.Check1.Left      = 2
                    .Column4.Check1.Height    = 17
                    .Column4.Check1.Width     = 22
                    .Column4.Check1.Caption   = ""

                    .Column5.ControlSource   = "cursor_4c_Dados.FPagss"
                    .Column5.Width           = 230
                    .Column5.Sparse          = .T.
                    .Column5.Header1.Caption = "Substituir"
                    .Column5.Text1.MaxLength = 12

                    *-- Cores das colunas CheckBox (fidelidade visual PILAR 1)
                    .Column2.BackColor = RGB(216, 39, 70)
                    .Column3.BackColor = RGB(0, 0, 128)
                    .Column4.BackColor = RGB(0, 128, 255)

                    *-- Propriedades visuais dos Headers (PILAR 1)
                    .Column1.Header1.FontBold  = .T.
                    .Column1.Header1.ForeColor = RGB(90, 90, 90)
                    .Column1.Header1.Alignment = 2
                    .Column2.Header1.FontBold  = .T.
                    .Column2.Header1.ForeColor = RGB(90, 90, 90)
                    .Column2.Header1.Alignment = 2
                    .Column3.Header1.FontBold  = .T.
                    .Column3.Header1.ForeColor = RGB(0, 0, 128)
                    .Column3.Header1.Alignment = 2
                    .Column4.Header1.FontBold  = .T.
                    .Column4.Header1.Alignment = 2
                    .Column5.Header1.FontBold  = .T.
                    .Column5.Header1.Alignment = 2

                    *-- Colunas nao movimentaveis/redimensionaveis (PILAR 1)
                    .Column1.Movable   = .F.
                    .Column1.Resizable = .F.
                    .Column2.Movable   = .F.
                    .Column2.Resizable = .F.
                    .Column3.Movable   = .F.
                    .Column3.Resizable = .F.
                    .Column4.Movable   = .F.
                    .Column4.Resizable = .F.
                    .Column5.Movable   = .F.
                    .Column5.Resizable = .F.
                ENDWITH

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarGrade")
        ENDTRY

        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInserirClick - Append de linha em branco na grade (cmdInserir no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnInserirClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Grade n" + CHR(227) + "o inicializada. Abra o formul" + ;
                    CHR(225) + "rio com uma opera" + CHR(231) + CHR(227) + "o.", "")
                RETURN
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            SELECT cursor_4c_Dados
            APPEND BLANK
            REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
            REPLACE FPags     WITH ""
            REPLACE Obrigs    WITH 0
            REPLACE Autos     WITH 0
            REPLACE Contabs   WITH 0
            REPLACE FPagss    WITH ""
            REPLACE BlqAltExc WITH 0
            GO BOTTOM IN cursor_4c_Dados

            loc_oGrid.Refresh()
            loc_oGrid.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnInserirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove linha atual da grade (cmdExcluir no legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                RETURN
            ENDIF

            IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                RETURN
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            SELECT cursor_4c_Dados
            DELETE
            SKIP
            IF EOF("cursor_4c_Dados")
                SKIP -1
            ENDIF

            loc_oGrid.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Valida, salva e fecha (cmdSair no legado)
    * Logica: valida duplicatas via BO.SalvarLote, fecha form se sucesso
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EMPTY(ALLTRIM(THIS.this_cDopes))
                IF THIS.this_oBusinessObject.SalvarLote(THIS.this_cDopes, "cursor_4c_Dados")
                    THIS.Release()
                ENDIF
            ELSE
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeAfterRowColChange - Disparado ao mover entre celulas da grade
    *--------------------------------------------------------------------------
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        *-- Reservado para logica de navegacao futura entre linhas/colunas
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol1KeyPress - KeyPress na coluna FPags (Column1)
    * F4 abre lookup de condicao de pagamento
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupFPags(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol5KeyPress - KeyPress na coluna Substituir/FPagss (Column5)
    * F4 abre lookup de condicao de pagamento substituta
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupFPags(5)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFPags - Abre FormBuscaAuxiliar para selecao de condicao de pagamento
    * par_nColuna: 1 = coluna FPags, 5 = coluna FPagss (Substituir)
    * Usa crSigOpFp (carregado por BuscarCondicoesPagamento) - Modo 2 sem params Init
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupFPags(par_nColuna)
        LOCAL loc_oBusca, loc_cCampoDestino, loc_oErro

        IF !INLIST(par_nColuna, 1, 5)
            RETURN .F.
        ENDIF

        loc_cCampoDestino = IIF(par_nColuna = 5, "FPagss", "FPags")

        TRY
            IF !USED("crSigOpFp")
                THIS.this_oBusinessObject.BuscarCondicoesPagamento()
            ENDIF

            IF !USED("crSigOpFp")
                MsgAviso("Lista de condi" + CHR(231) + CHR(245) + "es de pagamento n" + ;
                    CHR(227) + "o carregada.", "")
                RETURN
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "crSigOpFp"
                loc_oBusca.this_cTitulo = "Condi" + CHR(231) + CHR(227) + "o de Pagamento"
                loc_oBusca.mAddColuna("FPags",  "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Fparcs", "99", "Parcelas")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("crSigOpFp")
                    IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        IF loc_cCampoDestino = "FPags"
                            REPLACE FPags  WITH ALLTRIM(crSigOpFp.FPags)
                        ELSE
                            REPLACE FPagss WITH ALLTRIM(crSigOpFp.FPags)
                        ENDIF
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ELSE
                MsgErro("Erro ao criar FormBuscaAuxiliar", "Lookup")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AbrirLookupFPags")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida grade, salva e fecha (Page2 -> save lote)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados") AND !EMPTY(ALLTRIM(THIS.this_cDopes))
                IF THIS.this_oBusinessObject.SalvarLote(THIS.this_cDopes, "cursor_4c_Dados")
                    THIS.Release()
                ENDIF
            ELSE
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnConfirmarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Volta para Page1 sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.AlternarPagina(1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol2CheckKeyPress - KeyPress no CheckBox da coluna Obrigatorio (Column2)
    * Enter (13) ou Space (32) alterna Obrigs do registro atual (mirror do KeyPress legado)
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol2CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF INLIST(par_nKeyCode, 13, 32)
            TRY
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    REPLACE Obrigs WITH IIF(cursor_4c_Dados.Obrigs = 1, 0, 1)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em GradeCol2CheckKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol3CheckKeyPress - KeyPress no CheckBox da coluna Auto (Column3)
    * Enter (13) ou Space (32) alterna Autos do registro atual (mirror do KeyPress legado)
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol3CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF INLIST(par_nKeyCode, 13, 32)
            TRY
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    REPLACE Autos WITH IIF(cursor_4c_Dados.Autos = 1, 0, 1)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em GradeCol3CheckKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol4CheckKeyPress - KeyPress no CheckBox da coluna Nao Contabilizar (Column4)
    * Enter (13) ou Space (32) alterna Contabs do registro atual (mirror do KeyPress legado)
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol4CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF INLIST(par_nKeyCode, 13, 32)
            TRY
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    REPLACE Contabs WITH IIF(cursor_4c_Dados.Contabs = 1, 0, 1)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro em GradeCol4CheckKeyPress")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol1TextLostFocus - LostFocus na coluna FPags (Column1.Text1)
    * Quando FPags esta vazio, redireciona foco para botao Encerrar
    * (mirror do LostFocus original: "If IsEmpty(This.Value): Thisform.cmdSair.SetFocus")
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol1TextLostFocus()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                IF EMPTY(ALLTRIM(cursor_4c_Dados.FPags))
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GradeCol1TextLostFocus")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeCol1HeaderClick - Click no Header da coluna FPags (Column1.Header1)
    * Reordena cursor_4c_Dados por FPags (mirror do Click legado no Header1)
    *--------------------------------------------------------------------------
    PROCEDURE GradeCol1HeaderClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON FPags TAG FPags COMPACT
                SET ORDER TO TAG FPags IN cursor_4c_Dados
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GradeCol1HeaderClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Alias canonico do fluxo "Incluir" (append blank na grade)
    * Form OPERACIONAL: sem Page2/CRUD separado; edicao acontece inline na grade.
    * Reusa a logica de BtnInserirClick (equivalente ao cmdInserir legado).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados")
                MsgAviso("Grade n" + CHR(227) + "o inicializada. Abra o formul" + ;
                    CHR(225) + "rio com uma opera" + CHR(231) + CHR(227) + "o.", "")
                RETURN
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            SELECT cursor_4c_Dados
            APPEND BLANK
            REPLACE Dopes     WITH ALLTRIM(THIS.this_cDopes)
            REPLACE FPags     WITH ""
            REPLACE Obrigs    WITH 0
            REPLACE Autos     WITH 0
            REPLACE Contabs   WITH 0
            REPLACE FPagss    WITH ""
            REPLACE BlqAltExc WITH 0
            GO BOTTOM IN cursor_4c_Dados

            THIS.this_cModoAtual = "INCLUIR"
            loc_oGrid.Refresh()
            loc_oGrid.Column1.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Coloca a linha atual da grade em modo de edicao
    * Form OPERACIONAL: nao ha Page2; foco vai para Column1 do registro atual
    * respeitando BlqAltExc (registros bloqueados nao podem ser alterados).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro na grade para alterar.", "")
                RETURN
            ENDIF

            IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                MsgAviso("Selecione um registro na grade.", "")
                RETURN
            ENDIF

            SELECT cursor_4c_Dados
            IF NVL(cursor_4c_Dados.BlqAltExc, 0) = 1
                MsgAviso("Registro bloqueado para altera" + CHR(231) + CHR(227) + "o.", "")
                RETURN
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            THIS.this_cModoAtual = "ALTERAR"
            loc_oGrid.Refresh()
            loc_oGrid.SetFocus()
            loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Foca a linha atual em modo leitura
    * Form OPERACIONAL: nao ha Page2 de detalhe; posiciona foco na Column1
    * da linha corrente da grade para visualizacao do registro selecionado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro na grade para visualizar.", "")
                RETURN
            ENDIF

            IF EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF

            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            THIS.this_cModoAtual = "VISUALIZAR"
            loc_oGrid.Refresh()
            loc_oGrid.SetFocus()
            loc_oGrid.ActivateCell(RECNO("cursor_4c_Dados"), 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Wrapper canonico para CarregarGrade (compatibilidade CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cDopes))
            loc_lResultado = THIS.CarregarGrade()
        ELSE
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a grade com dados atuais de SigOpFpo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cDopes))
                THIS.CarregarGrade()
            ELSE
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                    "o definida.", "")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick (padrao CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados da linha atual do grid para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            THIS.this_oBusinessObject.this_cCidChaves = ALLTRIM(NVL(CidChaves, ""))
            THIS.this_oBusinessObject.this_cDopes     = ALLTRIM(NVL(Dopes,    ""))
            THIS.this_oBusinessObject.this_cFPags     = ALLTRIM(NVL(FPags,    ""))
            THIS.this_oBusinessObject.this_nObrigs    = NVL(Obrigs,    0)
            THIS.this_oBusinessObject.this_nAutos     = NVL(Autos,     0)
            THIS.this_oBusinessObject.this_nContabs   = NVL(Contabs,   0)
            THIS.this_oBusinessObject.this_cFPagss    = ALLTRIM(NVL(FPagss,   ""))
            THIS.this_oBusinessObject.this_nBlqAltExc = NVL(BlqAltExc, 0)
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o registro atual do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Dados
            REPLACE CidChaves WITH ALLTRIM(THIS.this_oBusinessObject.this_cCidChaves)
            REPLACE Dopes     WITH ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
            REPLACE FPags     WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPags)
            REPLACE Obrigs    WITH THIS.this_oBusinessObject.this_nObrigs
            REPLACE Autos     WITH THIS.this_oBusinessObject.this_nAutos
            REPLACE Contabs   WITH THIS.this_oBusinessObject.this_nContabs
            REPLACE FPagss    WITH ALLTRIM(THIS.this_oBusinessObject.this_cFPagss)
            REPLACE BlqAltExc WITH THIS.this_oBusinessObject.this_nBlqAltExc
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita grade e botoes de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                loc_oPagina.grd_4c_Dados.ReadOnly = !par_lHabilitar
            ENDIF

            IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Inserir", 5)
                    loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir.Enabled = par_lHabilitar
                ENDIF
                IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = par_lHabilitar
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - ZAP do cursor de dados + refresh da grade
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                ZAP IN cursor_4c_Dados
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta botoes conforme this_cModoAtual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
                IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Inserir", 5)
                    loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir.Enabled  = .T.
                ENDIF
                IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled  = .T.
                ENDIF
                IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Encerrar", 5)
                    loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpoBO.prg):
*==============================================================================
* FpoBO.prg - Business Object de Condicao de Pagamento Por Operacao
* Tabela: SigOpFpo
* PK: cidchaves
*==============================================================================

DEFINE CLASS FpoBO AS BusinessBase

    *-- Propriedades da tabela SigOpFpo
    this_cCidChaves  = ""    && PK char(20) - chave unica gerada
    this_cDopes      = ""    && char(20) - codigo da operacao (FK SigCdOpe)
    this_cFPags      = ""    && char(12) - condicao de pagamento (FK SigOpFp)
    this_nObrigs     = 0     && numeric(1,0) - obrigatorio (0/1)
    this_nAutos      = 0     && numeric(1,0) - so automatico (0/1)
    this_nContabs    = 0     && numeric(1,0) - nao contabilizar (0/1)
    this_cFPagss     = ""    && char(12) - condicao substituta
    this_nBlqAltExc  = 0     && numeric(1,0) - bloqueado para alterar/excluir (0/1)

    *-- Contexto de operacao corrente (preenchido pelo Form antes de Buscar)
    this_cDopesAtual = ""    && codigo da operacao em edicao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_cDopes      = TratarNulo(Dopes,     "C")
            THIS.this_cFPags      = TratarNulo(FPags,     "C")
            THIS.this_nObrigs     = TratarNulo(Obrigs,    "N")
            THIS.this_nAutos      = TratarNulo(Autos,     "N")
            THIS.this_nContabs    = TratarNulo(Contabs,   "N")
            THIS.this_cFPagss     = TratarNulo(FPagss,    "C")
            THIS.this_nBlqAltExc  = TratarNulo(BlqAltExc, "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo" + ;
                       " WHERE CidChaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFpo")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CarregaFpo") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFpo")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_CarregaFpo")
            USE IN cursor_4c_CarregaFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpo filtrados por Dopes
    * Retorna cursor_4c_Dados com as condicoes de pagamento da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            loc_cWhere = "WHERE 1=1"

            IF !EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_cWhere = loc_cWhere + ;
                    " AND Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopesAtual))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo " + loc_cWhere + ;
                       " ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Buscar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCondicoesPagamento - Carrega SigOpFp disponivel em crSigOpFp
    * Usado pelo lookup do campo FPags no grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCondicoesPagamento()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT FPags, Fparcs, Situas FROM SigOpFp ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - BuscarCondicoesPagamento")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - BuscarCondicoesPagamento")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Valida se ha FPags duplicados no cursor
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicados(par_cCursorDados)
        LOCAL loc_lResultado, loc_cFPagsAnt, loc_cFPagsAtual
        loc_lResultado = .T.

        IF !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        TRY
            *-- Ordena copia do cursor por FPags para detectar adjacentes iguais
            SELECT FPags FROM (par_cCursorDados) ;
                WHERE !EMPTY(ALLTRIM(FPags)) ORDER BY 1 ;
                INTO CURSOR cursor_4c_SortFpo

            IF USED("cursor_4c_SortFpo")
                SELECT cursor_4c_SortFpo
                GO TOP
                loc_cFPagsAnt = ""
                SCAN
                    loc_cFPagsAtual = ALLTRIM(FPags)
                    IF loc_cFPagsAtual == loc_cFPagsAnt
                        MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                            loc_cFPagsAtual + " Digitada em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                    loc_cFPagsAnt = loc_cFPagsAtual
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ValidarDuplicados")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SortFpo")
            USE IN cursor_4c_SortFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Salva todos os registros do grid de volta ao SigOpFpo
    * par_cDopes: codigo da operacao
    * par_cCursorDados: alias do cursor com os dados do grid (ex: crSigOpFpo)
    * Logica: valida duplicatas, gera chaves, delete+insert atomico no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote(par_cDopes, par_cCursorDados)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_lTransacaoAberta, loc_lErroInsert
        loc_lResultado    = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroInsert   = .F.

        *-- Validacoes de entrada ANTES do TRY (retornos validos aqui)
        IF EMPTY(ALLTRIM(par_cDopes))
            MsgAviso("C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informado", "")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorDados)
            MsgAviso("Cursor de dados n" + CHR(227) + "o encontrado", "")
            RETURN .F.
        ENDIF

        IF !THIS.ValidarDuplicados(par_cCursorDados)
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar CidChaves para linhas novas (FPags nao vazio, CidChaves vazio)
            SELECT (par_cCursorDados)
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(FPags)) AND EMPTY(ALLTRIM(CidChaves))
                    loc_cCidChaves = fUniqueIds()
                    REPLACE CidChaves WITH loc_cCidChaves IN (par_cCursorDados)
                ENDIF
            ENDSCAN

            *-- Abrir transacao atomica
            loc_nResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            IF loc_nResultado >= 0
                loc_lTransacaoAberta = .T.

                *-- Deletar todos os registros existentes da operacao
                loc_cSQL = "DELETE FROM SigOpFpo WHERE Dopes = " + ;
                    EscaparSQL(ALLTRIM(par_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Reinserir as linhas validas (com FPags preenchido)
                    SELECT (par_cCursorDados)
                    GO TOP
                    SCAN WHILE !loc_lErroInsert
                        IF !EMPTY(ALLTRIM(FPags))
                            THIS.this_cCidChaves = ALLTRIM(CidChaves)
                            THIS.this_cDopes     = ALLTRIM(Dopes)
                            THIS.this_cFPags     = ALLTRIM(FPags)
                            THIS.this_nObrigs    = NVL(Obrigs, 0)
                            THIS.this_nAutos     = NVL(Autos, 0)
                            THIS.this_nContabs   = NVL(Contabs, 0)
                            THIS.this_cFPagss    = ALLTRIM(NVL(FPagss, ""))
                            THIS.this_nBlqAltExc = NVL(BlqAltExc, 0)
                            IF !THIS.Inserir()
                                loc_lErroInsert = .T.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao excluir registros anteriores")
                    loc_lErroInsert = .T.
                ENDIF

                IF !loc_lErroInsert
                    loc_nResultado = SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    IF loc_nResultado >= 0
                        loc_lTransacaoAberta = .F.
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote COMMIT")
                    ENDIF
                ENDIF

                IF loc_lTransacaoAberta
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote BEGIN TRANSACTION")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - SalvarLote")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigOpFpo
    * Chamado por SalvarLote e por BusinessBase.Salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpFpo" + ;
                " (CidChaves, Dopes, FPags, Obrigs, Autos, Contabs, FPagss, BlqAltExc)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cDopes)       + ", " + ;
                EscaparSQL(THIS.this_cFPags)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nObrigs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nContabs)  + ", " + ;
                EscaparSQL(THIS.this_cFPagss)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqAltExc) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Inserir")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpFpo SET" + ;
                " Dopes    = " + EscaparSQL(THIS.this_cDopes)          + ", " + ;
                " FPags    = " + EscaparSQL(THIS.this_cFPags)          + ", " + ;
                " Obrigs   = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ", " + ;
                " Autos    = " + FormatarNumeroSQL(THIS.this_nAutos)   + ", " + ;
                " Contabs  = " + FormatarNumeroSQL(THIS.this_nContabs) + ", " + ;
                " FPagss   = " + EscaparSQL(THIS.this_cFPagss)         + ", " + ;
                " BlqAltExc= " + FormatarNumeroSQL(THIS.this_nBlqAltExc) + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Atualizar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro de SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpFpo" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

