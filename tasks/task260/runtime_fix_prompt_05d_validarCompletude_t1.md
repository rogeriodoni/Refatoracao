# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSigPrCar.prg] Procedure vazia (sem codigo): AlternarPagina

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg):
*===============================================================================
* FormSigPrCar.prg - Sub-form modal: Caracter" + CHR(237) + "sticas do Produto
* Legado: SigPrCar.SCX (OPERACIONAL sub-form)
* Herda de FormBase
* Chamado por: FormSigPrAop / FormSigPrApr com produto selecionado
* Interface: CREATEOBJECT("FormSigPrCar", oParentForm, cCpros, cCgrus, cPcEscolha)
*
* MIGRACAO COMPLETA (8/8 fases)
*   - Init(4 params): armazena ParentForm, CPros, CGrus, PcEscolha
*   - ConfigurarPageFrame: fundo new_background.jpg (form plano OPERACIONAL)
*   - ConfigurarCabecalho: cnt_4c_Cabecalho cinza com lbl_4c_Sombra/Titulo
*   - ConfigurarBotoes: Shape1 + cmd_4c_Inserir/Excluir/Sair
*   - ConfigurarGrade: grd_4c_Grade (2 colunas Codigos+Descrs) + cursor placeholder
*   - CarregarGrid: SQLEXEC sigprcar filtrado por CPros (cursor temp + ZAP/APPEND)
*   - AjustarBotoesVisibilidade: Inserir/Excluir visiveis apenas em INSERIR/ALTERAR
*   - RegistrarBINDEVENTs: Click e KeyPress bindados
*   - CmdInserirClick: insere linha vazia, foca Column1
*   - CmdExcluirClick: deleta linha corrente (guard CPros)
*   - CmdSairClick: limpa linhas vazias, reabilita form pai, Release
*   - GrdCol1/2KeyPress: guard ENTER/TAB/F4 + ValidarCodigo/Descricao
*   - ValidarCodigo/Descricao: match exato + duplicidade + picker
*   - AbrirPickerCodigo/Descricao: FormBuscaAuxiliar com filtro CGrus em SIGCRRAP
*   - Destroy: cursor + BO liberados
*===============================================================================

DEFINE CLASS FormSigPrCar AS FormBase

    *-- Dimensoes identicas ao original (sub-form pequeno, NAO 1000x600)
    Width       = 480
    Height      = 540

    Caption     = ""
    TitleBar    = 0
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 1
    ShowTips    = .T.
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form chamador (recebida em Init)
    this_oParentForm  = .NULL.

    *-- Dados do produto passados pelo form pai
    this_cCpros      = ""    && codigo do produto (CPros de SigCdPro)
    this_cCgrus      = ""    && grupo do produto  (CGrus - filtro do lookup SIGCRRAP)

    *-- Modo de operacao herdado do form pai (INSERIR/ALTERAR/CONSULTAR)
    this_cPcEscolha  = "CONSULTAR"

    *-- Flags consultadas pelo form pai apos fechar o sub-form
    this_lHouveIncl  = .F.
    this_lHouveExcl  = .F.

    *-- Alias do cursor local de caracteristicas
    this_cCursorCarac = "cursor_4c_CaracProd"

    *===========================================================================
    PROCEDURE Init(par_oParentForm, par_cCpros, par_cCgrus, par_cPcEscolha)
    *-- Armazena parametros do form pai ANTES de InicializarForm().
    *-- DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    *===========================================================================
        THIS.Caption          = "Caracter" + CHR(237) + "sticas do Produto"
        THIS.this_oParentForm = par_oParentForm
        THIS.this_cCpros      = IIF(VARTYPE(par_cCpros)     = "C", ALLTRIM(par_cCpros),     "")
        THIS.this_cCgrus      = IIF(VARTYPE(par_cCgrus)     = "C", ALLTRIM(par_cCgrus),     "")
        THIS.this_cPcEscolha  = IIF(VARTYPE(par_cPcEscolha) = "C", UPPER(par_cPcEscolha),   "CONSULTAR")

        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *-- Configuracao base do form plano OPERACIONAL (sem PageFrame real).
    *-- Aplica imagem de fundo identica ao legado new_background.jpg.
    *===========================================================================
        LOCAL loc_cImgFundo

        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        THIS.ScrollBars = 0
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *-- Cria estrutura visual do sub-form.
    *-- FASE 3: PageFrame (background) + Cabecalho.
    *-- FASE 4: ConfigurarBotoes (Shape1 + cmdInserir/Excluir/Sair) + ConfigurarGrade.
    *-- Fases 5+: CarregarGrid, AjustarBotoesVisibilidade, BINDEVENTs.
    *===========================================================================
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)
                THIS.AjustarBotoesVisibilidade()
                loc_lSucesso = .T.
            ELSE
                IF gnConnHandle <= 0
                    MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + ;
                            CHR(227) + "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    THIS.this_oBusinessObject = CREATEOBJECT("SigPrCarBO")
                    IF VARTYPE(THIS.this_oBusinessObject) != "O"
                        MsgErro("Falha ao criar SigPrCarBO.", "Erro")
                    ELSE
                        THIS.ConfigurarPageFrame()
                        THIS.ConfigurarCabecalho()
                        THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                        THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                        THIS.ConfigurarPaginaLista()
                        THIS.ConfigurarPaginaDados()
                        THIS.TornarControlesVisiveis(THIS)
                        THIS.AjustarBotoesVisibilidade()
                        THIS.CarregarGrid()
                        THIS.RegistrarBINDEVENTs()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSigPrCar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *-- Container escuro no topo com labels sombra+titulo (cntSombra do legado).
    *-- Original: Top=0, Left=0, Width=800, Height=80 -> adaptado para Width=THIS.Width
    *===========================================================================
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
                .Top       = 25
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 24
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Caracter" + CHR(237) + "sticas do Produto"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *-- Torna visiveis todos os controles criados por AddObject (Visible=.F. default).
    *===========================================================================
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_p
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *-- Convencao arquitetural: agrupa a "lista de acoes" do sub-form (Shape1 +
    *-- cmdInserir/cmdExcluir/cmdSair), botoes que operam sobre o conjunto de
    *-- caracteristicas. Chamado por InicializarForm ANTES de ConfigurarPaginaDados.
    *===========================================================================
        THIS.ConfigurarBotoes()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *-- Convencao arquitetural: agrupa a "area de dados" do sub-form. Neste
    *-- OPERACIONAL o unico elemento de entrada de dados eh o Grid de
    *-- caracteristicas (grd_4c_Grade + cursor_4c_CaracProd). Chamado por
    *-- InicializarForm APOS ConfigurarPaginaLista para garantir z-order correto
    *-- (grid renderiza abaixo dos botoes).
    *===========================================================================
        THIS.ConfigurarGrade()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *-- Cria Shape decorativo e botoes de acao do sub-form (Shape1 + cmdInserir/Excluir/Sair).
    *-- Visibilidade por modo (INSERIR/ALTERAR vs CONSULTAR) gerenciada em AjustarBotoesVisibilidade (Fase 5).
    *===========================================================================
        *-- Shape decorativo por tras dos botoes (Shape1 do legado: Top=-3, Left=239, W=250, H=38)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -3
            .Left        = 239
            .Width       = 250
            .Height      = 38
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- cmd_4c_Inserir (cmdInserir do legado - Left=255, TabIndex=1)
        THIS.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH THIS.cmd_4c_Inserir
            .Top             = 3
            .Left            = 255
            .Width           = 70
            .Height          = 70
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .PicturePosition = 13
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
            .TabIndex        = 1
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Excluir (cmdExcluir do legado - Left=330, TabIndex=2)
        THIS.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH THIS.cmd_4c_Excluir
            .Top             = 3
            .Left            = 330
            .Width           = 70
            .Height          = 70
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
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
            .TabIndex        = 2
            .Visible         = .T.
        ENDWITH

        *-- cmd_4c_Sair/Encerrar (cmdSair do legado - Left=405, Cancel=.T., TabIndex=3)
        THIS.AddObject("cmd_4c_Sair", "CommandButton")
        WITH THIS.cmd_4c_Sair
            .Top             = 3
            .Left            = 405
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
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
            .TabIndex        = 3
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *-- Cria cursor placeholder e grid de caracteristicas do produto.
    *-- Grade (legado): Top=103, Left=8, Width=463, Height=411, 2 colunas.
    *-- Dados carregados por CarregarGrid na Fase 5 (SQLEXEC SigPrCar por CPros).
    *===========================================================================
        LOCAL loc_oGrade

        *-- Cursor placeholder com estrutura de SigPrCar (dados carregados na Fase 5)
        IF USED(THIS.this_cCursorCarac)
            USE IN (THIS.this_cCursorCarac)
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_CaracProd ;
            (CPros C(15) NULL, Codigos C(20) NULL, Descrs C(50) NULL, pkChaves C(38) NULL)
        SET NULL OFF

        THIS.AddObject("grd_4c_Grade", "Grid")
        loc_oGrade = THIS.grd_4c_Grade

        WITH loc_oGrade
            .Top                = 103
            .Left               = 8
            .Width              = 463
            .Height             = 411
            .ColumnCount        = 2
            .RecordSource       = THIS.this_cCursorCarac
            .FontName           = "Tahoma"
            .FontSize           = 8
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 17
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .AllowCellSelection = .T.

            *-- Coluna 1: Codigos (Caracteristica)
            WITH .Column1
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Width         = 150
                .Movable       = .F.
                .Resizable     = .F.
                .ControlSource = THIS.this_cCursorCarac + ".Codigos"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Caracter" + CHR(237) + "stica"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH

            *-- Coluna 2: Descrs (Descricao)
            WITH .Column2
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Width         = 290
                .Movable       = .F.
                .Resizable     = .F.
                .ControlSource = THIS.this_cCursorCarac + ".Descrs"
                WITH .Header1
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *-- OPERACIONAL sem PageFrame - nao alterna paginas.
    *===========================================================================
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE CarregarGrid()
    *-- Carrega sigprcar filtrado por CPros no cursor local via cursor temporario.
    *===========================================================================
        LOCAL loc_cSQL, loc_oErro, loc_lResultado

        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_CaracProdTemp")
                USE IN cursor_4c_CaracProdTemp
            ENDIF

            loc_cSQL = "SELECT cpros, codigos, descrs, pkchaves " + ;
                       "FROM sigprcar " + ;
                       "WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + " " + ;
                       "ORDER BY codigos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracProdTemp") > 0
                SELECT (THIS.this_cCursorCarac)
                ZAP
                APPEND FROM DBF("cursor_4c_CaracProdTemp")
                USE IN cursor_4c_CaracProdTemp
                SELECT (THIS.this_cCursorCarac)
                GO TOP
            ENDIF

            WITH THIS.grd_4c_Grade
                .ColumnCount             = 2
                .RecordSource            = THIS.this_cCursorCarac
                .Column1.ControlSource   = THIS.this_cCursorCarac + ".Codigos"
                .Column2.ControlSource   = THIS.this_cCursorCarac + ".Descrs"
                .Column1.Header1.Caption = "Caracter" + CHR(237) + "stica"
                .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            ENDWITH

            THIS.grd_4c_Grade.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarGrid")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesVisibilidade()
    *-- Exibe/oculta Inserir+Excluir conforme modo (INSERIR/ALTERAR vs CONSULTAR).
    *-- Em CONSULTAR: grid ReadOnly=.T. replica When=.F. do legado (celulas nao editaveis).
    *===========================================================================
        LOCAL loc_lVis

        loc_lVis = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")

        THIS.cmd_4c_Inserir.Visible = loc_lVis
        THIS.cmd_4c_Inserir.Enabled = loc_lVis
        THIS.cmd_4c_Excluir.Visible = loc_lVis
        THIS.cmd_4c_Excluir.Enabled = loc_lVis

        THIS.grd_4c_Grade.ReadOnly = !loc_lVis

        IF !loc_lVis
            THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
            THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left  - 5
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE RegistrarBINDEVENTs()
    *-- Vincula eventos dos botoes e celulas do grid aos handlers PUBLIC.
    *===========================================================================
        BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
        BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
        BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "CmdSairClick")
        BINDEVENT(THIS.grd_4c_Grade.Column1.Text1, "KeyPress", THIS, "GrdCol1KeyPress")
        BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress", THIS, "GrdCol2KeyPress")
    ENDPROC

    *===========================================================================
    PROCEDURE CmdInserirClick()
    *-- Insere nova linha vazia no cursor para adicionar uma caracteristica.
    *===========================================================================
        THIS.this_lHouveIncl = .T.

        IF THIS.this_oBusinessObject.InserirNovaLinha(THIS.this_cCursorCarac, THIS.this_cCpros)
            SELECT (THIS.this_cCursorCarac)
            GO BOTTOM
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Grade.Column1.SetFocus()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE CmdExcluirClick()
    *-- Remove o registro corrente do cursor (com verificacao de CPros de seguranca).
    *===========================================================================
        IF THIS.this_oBusinessObject.ExcluirLinhaAtual(THIS.this_cCursorCarac, THIS.this_cCpros)
            THIS.this_lHouveExcl = .T.
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE CmdSairClick()
    *-- Limpa linhas vazias (modo edicao), reabilita form pai e fecha sub-form.
    *===========================================================================
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_oBusinessObject.LimparLinhasVazias(THIS.this_cCursorCarac)
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnIncluirClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para INSERIR,
    *-- reconfigura visibilidade dos botoes (Inserir/Excluir enabled) e insere
    *-- linha vazia no grid delegando para CmdInserirClick.
    *===========================================================================
        THIS.this_cPcEscolha = "INSERIR"
        THIS.AjustarBotoesVisibilidade()
        THIS.CmdInserirClick()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnAlterarClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para ALTERAR,
    *-- libera edicao do grid (ReadOnly=.F., Inserir/Excluir enabled) e posiciona
    *-- foco na Column1 (Codigos) do registro corrente para edicao.
    *===========================================================================
        LOCAL loc_oErro

        THIS.this_cPcEscolha = "ALTERAR"
        THIS.AjustarBotoesVisibilidade()

        IF USED(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            IF RECCOUNT() = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                         " caracter" + CHR(237) + "sticas cadastradas para este produto." + ;
                         CHR(13) + "Utilize o bot" + CHR(227) + "o Inserir para adicionar.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF EOF()
                GO TOP
            ENDIF
        ENDIF

        TRY
            THIS.grd_4c_Grade.Refresh()
            THIS.grd_4c_Grade.SetFocus()
            THIS.grd_4c_Grade.ActivateCell(RECNO(THIS.this_cCursorCarac), 1)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    PROCEDURE BtnVisualizarClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: troca modo para CONSULTAR,
    *-- bloqueia edicao do grid (ReadOnly=.T.), oculta Inserir/Excluir e posiciona
    *-- cursor no primeiro registro para exibicao read-only.
    *===========================================================================
        THIS.this_cPcEscolha = "CONSULTAR"
        THIS.AjustarBotoesVisibilidade()

        IF USED(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            IF RECCOUNT() > 0
                GO TOP
            ENDIF
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnExcluirClick()
    *-- Bridge CRUD -> semantica OPERACIONAL sub-form: valida modo editavel, pede
    *-- confirmacao e delega para CmdExcluirClick que remove a linha corrente.
    *===========================================================================
        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            MsgAviso("Exclus" + CHR(227) + "o dispon" + CHR(237) + ;
                     "vel apenas em modo Inserir ou Alterar.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF !USED(THIS.this_cCursorCarac) OR RECCOUNT(THIS.this_cCursorCarac) = 0
            MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                     " caracter" + CHR(237) + "stica selecionada para excluir.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da caracter" + ;
                       CHR(237) + "stica selecionada?", ;
                       "Confirma" + CHR(231) + CHR(227) + "o")
            THIS.CmdExcluirClick()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE GrdCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler KeyPress na coluna Codigos: dispara validacao em ENTER/TAB/F4.
    *===========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        THIS.ValidarCodigo()
    ENDPROC

    *===========================================================================
    PROCEDURE GrdCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *-- Handler KeyPress na coluna Descrs: valida somente se Column1 estiver vazio.
    *===========================================================================
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF !INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            RETURN
        ENDIF

        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.grd_4c_Grade.Column1.Text1.Value))
            RETURN
        ENDIF

        THIS.ValidarDescricao()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ValidarCodigo()
    *-- Valida codigo digitado em Column1 contra SIGCRRAP. Abre picker se nao encontrado.
    *===========================================================================
        LOCAL loc_cValor, loc_cPkAtual, loc_lEncontrado, loc_oErro
        LOCAL loc_cCodFinal, loc_cDescFinal

        TRY
            loc_cValor   = ALLTRIM(THIS.grd_4c_Grade.Column1.Text1.Value)
            loc_cPkAtual = ""

            IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                SELECT (THIS.this_cCursorCarac)
                loc_cPkAtual = ALLTRIM(pkchaves)
            ENDIF

            IF EMPTY(loc_cValor)
                IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                    SELECT (THIS.this_cCursorCarac)
                    REPLACE codigos WITH "", descrs WITH ""
                ENDIF
            ELSE
                loc_lEncontrado = THIS.this_oBusinessObject.BuscarCodigoExato(;
                    loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")

                IF !loc_lEncontrado
                    THIS.AbrirPickerCodigo(loc_cValor)
                ELSE
                    SELECT cursor_4c_PrCarBusca
                    loc_cCodFinal  = ALLTRIM(codigos)
                    loc_cDescFinal = ALLTRIM(descrs)
                    USE IN cursor_4c_PrCarBusca

                    IF THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ValidarCodigo")
        ENDTRY

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ValidarDescricao()
    *-- Valida descricao digitada em Column2 contra SIGCRRAP. Abre picker se nao encontrado.
    *===========================================================================
        LOCAL loc_cValor, loc_cPkAtual, loc_lEncontrado, loc_oErro
        LOCAL loc_cCodFinal, loc_cDescFinal

        TRY
            loc_cValor   = ALLTRIM(THIS.grd_4c_Grade.Column2.Text1.Value)
            loc_cPkAtual = ""

            IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                SELECT (THIS.this_cCursorCarac)
                loc_cPkAtual = ALLTRIM(pkchaves)
            ENDIF

            IF EMPTY(loc_cValor)
                IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                    SELECT (THIS.this_cCursorCarac)
                    REPLACE codigos WITH "", descrs WITH ""
                ENDIF
            ELSE
                loc_lEncontrado = THIS.this_oBusinessObject.BuscarDescricaoExata(;
                    loc_cValor, THIS.this_cCgrus, "cursor_4c_PrCarBusca")

                IF !loc_lEncontrado
                    THIS.AbrirPickerDescricao(loc_cValor)
                ELSE
                    SELECT cursor_4c_PrCarBusca
                    loc_cCodFinal  = ALLTRIM(codigos)
                    loc_cDescFinal = ALLTRIM(descrs)
                    USE IN cursor_4c_PrCarBusca

                    IF THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodFinal, loc_cPkAtual, THIS.this_cCursorCarac)
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodFinal, descrs WITH loc_cDescFinal
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ValidarDescricao")
        ENDTRY

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AbrirPickerCodigo(par_cValor)
    *-- FormBuscaAuxiliar buscando SIGCRRAP.codigos filtrado por grupo do produto.
    *===========================================================================
        LOCAL loc_oPicker, loc_cFiltro, loc_oErro
        LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado

        TRY
            loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"

            loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SIGCRRAP", ;
                "cursor_4c_PrCarPicker", ;
                "codigos", ;
                par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                loc_cFiltro)

            IF VARTYPE(loc_oPicker) = "O"
                loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oPicker.Show()

                IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
                    SELECT cursor_4c_PrCarPicker
                    loc_cCodSel  = ALLTRIM(codigos)
                    loc_cDescSel = ALLTRIM(descrs)

                    loc_cPkAtual = ""
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        loc_cPkAtual = ALLTRIM(pkchaves)
                    ENDIF

                    loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)

                    IF loc_lDuplicado
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
                        ENDIF
                    ENDIF
                ELSE
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        REPLACE codigos WITH "", descrs WITH ""
                    ENDIF
                ENDIF

                loc_oPicker = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AbrirPickerCodigo")
        ENDTRY

        IF USED("cursor_4c_PrCarPicker")
            USE IN cursor_4c_PrCarPicker
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE AbrirPickerDescricao(par_cValor)
    *-- FormBuscaAuxiliar buscando SIGCRRAP.descrs filtrado por grupo do produto.
    *===========================================================================
        LOCAL loc_oPicker, loc_cFiltro, loc_oErro
        LOCAL loc_cCodSel, loc_cDescSel, loc_cPkAtual, loc_lDuplicado

        TRY
            loc_cFiltro = "cgrus IN (" + EscaparSQL(THIS.this_cCgrus) + ", '   ')"

            loc_oPicker = CREATEOBJECT("FormBuscaAuxiliar", ;
                gnConnHandle, ;
                "SIGCRRAP", ;
                "cursor_4c_PrCarPicker", ;
                "descrs", ;
                par_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o", ;
                .F., ;
                .T., ;
                loc_cFiltro)

            IF VARTYPE(loc_oPicker) = "O"
                loc_oPicker.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oPicker.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oPicker.Show()

                IF loc_oPicker.this_lSelecionou AND USED("cursor_4c_PrCarPicker")
                    SELECT cursor_4c_PrCarPicker
                    loc_cCodSel  = ALLTRIM(codigos)
                    loc_cDescSel = ALLTRIM(descrs)

                    loc_cPkAtual = ""
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        loc_cPkAtual = ALLTRIM(pkchaves)
                    ENDIF

                    loc_lDuplicado = THIS.this_oBusinessObject.VerificarDuplicidade(;
                        loc_cCodSel, loc_cPkAtual, THIS.this_cCursorCarac)

                    IF loc_lDuplicado
                        MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
                                 " informada para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH "", descrs WITH ""
                        ENDIF
                    ELSE
                        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                            SELECT (THIS.this_cCursorCarac)
                            REPLACE codigos WITH loc_cCodSel, descrs WITH loc_cDescSel
                        ENDIF
                    ENDIF
                ELSE
                    IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
                        SELECT (THIS.this_cCursorCarac)
                        REPLACE codigos WITH "", descrs WITH ""
                    ENDIF
                ENDIF

                loc_oPicker = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AbrirPickerDescricao")
        ENDTRY

        IF USED("cursor_4c_PrCarPicker")
            USE IN cursor_4c_PrCarPicker
        ENDIF

        THIS.grd_4c_Grade.Refresh()
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarLista()
    *-- Delega ao CarregarGrid (padrao FormBase -> forms OPERACIONAIS).
    *===========================================================================
        RETURN THIS.CarregarGrid()
    ENDPROC

    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
    *-- Delega ao AjustarBotoesVisibilidade (padrao FormBase -> forms OPERACIONAIS).
    *===========================================================================
        THIS.AjustarBotoesVisibilidade()
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *-- Copia dados da linha corrente do cursor para o Business Object.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            THIS.this_oBusinessObject.this_cCodigos  = ALLTRIM(NVL(codigos,  ""))
            THIS.this_oBusinessObject.this_cCpros    = ALLTRIM(NVL(cpros,    ""))
            THIS.this_oBusinessObject.this_cPkChaves = ALLTRIM(NVL(pkchaves, ""))
            IF TYPE("descrs") != "U"
                THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(NVL(descrs, ""))
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Copia dados do Business Object para a linha corrente do cursor.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            REPLACE codigos  WITH THIS.this_oBusinessObject.this_cCodigos, ;
                    descrs   WITH THIS.this_oBusinessObject.this_cDescrs,   ;
                    cpros    WITH THIS.this_oBusinessObject.this_cCpros,    ;
                    pkchaves WITH THIS.this_oBusinessObject.this_cPkChaves
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *-- Habilita/desabilita edicao do grid conforme modo de operacao.
    *===========================================================================
        IF VARTYPE(THIS.grd_4c_Grade) = "O"
            THIS.grd_4c_Grade.ReadOnly = !par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *-- Limpa campos da linha corrente do cursor (codigos e descrs).
    *===========================================================================
        IF USED(THIS.this_cCursorCarac) AND !EOF(THIS.this_cCursorCarac)
            SELECT (THIS.this_cCursorCarac)
            REPLACE codigos WITH "", descrs WITH ""
        ENDIF
        IF VARTYPE(THIS.grd_4c_Grade) = "O"
            THIS.grd_4c_Grade.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Recarrega o grid com os dados atuais do produto (sem filtro adicional).
    *===========================================================================
        THIS.CarregarGrid()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnEncerrarClick()
    *-- Delega ao CmdSairClick: limpa vazios, reabilita pai, fecha sub-form.
    *===========================================================================
        THIS.CmdSairClick()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Persiste todas as caracteristicas no SQL Server e fecha o sub-form.
    *-- Estrategia: LimparLinhasVazias + SalvarTodasCaracteristicas + Release.
    *===========================================================================
        IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
            THIS.this_oBusinessObject.LimparLinhasVazias(THIS.this_cCursorCarac)
            THIS.this_oBusinessObject.SalvarTodasCaracteristicas(;
                THIS.this_cCursorCarac, THIS.this_cCpros)
        ENDIF

        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancela edicao sem persistir: reabilita form pai e fecha sub-form.
    *-- O original nao tem cancelar explicito - dados do cursor sao descartados.
    *===========================================================================
        IF VARTYPE(THIS.this_oParentForm) = "O"
            THIS.this_oParentForm.Enabled = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *===========================================================================
    PROCEDURE Destroy()
    *-- Libera cursor de trabalho e Business Object ao fechar o sub-form.
    *===========================================================================
        IF USED(THIS.this_cCursorCarac)
            USE IN (THIS.this_cCursorCarac)
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*====================================================================
* SigPrCarBO.prg
* Business Object: Caracteristicas do Produto (sigprcar)
* Tabela principal: sigprcar
* Sub-form: aberto pelo form de produto (SigPrApr/SigPrAop)
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Campos da tabela sigprcar
    this_cCodigos  = ""    && char(20) - codigo da caracteristica (FK SIGCRRAP)
    this_cCpros    = ""    && char(14) - codigo do produto (FK SigCdPro)
    this_cPkChaves = ""    && char(20) - chave primaria

    *-- Campo de exibicao: vem de SIGCRRAP.descrs, NAO armazenado em sigprcar
    this_cDescrs   = ""    && char(40) - descricao da caracteristica

    *-- Contexto do produto pai (passado pelo form chamador)
    this_cCgrus    = ""    && char(3) - grupo do produto (filtro de lookup SigCrRap)

    *-- Flags de controle de sessao (consultados pelo form pai apos fechar)
    this_lHouveIncl = .F.  && houve insercao nesta sessao
    this_lHouveExcl = .F.  && houve exclusao nesta sessao

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    * par_cAliasCursor: alias do cursor (crSigPrCar ou outro)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos,  "C")
            THIS.this_cCpros    = TratarNulo(cpros,    "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (pkchaves)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * Inserir - SQL INSERT INTO sigprcar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCpros)   + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - SQL UPDATE sigprcar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprcar SET codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos) + ;
                       " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - SQL DELETE FROM sigprcar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprcar WHERE pkchaves = " + ;
                       EscaparSQL(THIS.this_cPkChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + "stica do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * InserirNovaLinha - Insere linha vazia no cursor local
    * Equivalente a cmdInserir.Click do legado
    * par_cCursorCarac: alias do cursor local (ex: "crSigPrCar")
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE InserirNovaLinha(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cPkChaves, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                *-- Verifica se ja existe linha vazia para este produto
                SELECT (par_cCursorCarac)
                LOCATE FOR RTRIM(cpros) == RTRIM(par_cCpros) AND EMPTY(codigos) AND !DELETED()
                IF !EOF()
                    loc_lResultado = .T.
                ELSE
                    *-- Obtem chave unica do SQL Server
                    IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_PrCarNewid") > 0
                        SELECT cursor_4c_PrCarNewid
                        loc_cPkChaves = LEFT(ALLTRIM(nid), 20)
                        USE IN cursor_4c_PrCarNewid
                    ELSE
                        loc_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
                    ENDIF

                    *-- Insere linha vazia no cursor local
                    SELECT (par_cCursorCarac)
                    INSERT INTO (par_cCursorCarac) (cpros, pkchaves, codigos, descrs) ;
                        VALUES (par_cCpros, loc_cPkChaves, "", "")

                    THIS.this_lHouveIncl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir nova linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExcluirLinhaAtual - Remove o registro corrente do cursor local
    * Equivalente a cmdExcluir.Click do legado
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto (verificacao de seguranca)
    *====================================================================
    PROCEDURE ExcluirLinhaAtual(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            IF !USED(par_cCursorCarac)
                THIS.this_cMensagemErro = "Cursor " + par_cCursorCarac + ;
                    " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            ELSE
                SELECT (par_cCursorCarac)
                IF !EOF() AND RTRIM(cpros) == RTRIM(par_cCpros)
                    DELETE
                    SKIP
                    SKIP -1
                    THIS.this_lHouveExcl = .T.
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir linha: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * LimparLinhasVazias - Remove linhas sem codigo do cursor local
    * Chamado antes de fechar o form (cmdSair.Click do legado)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE LimparLinhasVazias(par_cCursorCarac)
        LOCAL loc_oErro
        TRY
            IF USED(par_cCursorCarac)
                SELECT (par_cCursorCarac)
                SCAN WHILE !EOF()
                    IF EMPTY(codigos)
                        DELETE
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao limpar linhas vazias: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *====================================================================
    * BuscarCodigoExato - Busca codigo exato em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    * par_cCodigos: valor a buscar
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular com resultado
    *====================================================================
    PROCEDURE BuscarCodigoExato(par_cCodigos, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar c" + CHR(243) + "digo: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescricaoExata - Busca descricao exata em SIGCRRAP
    * Retorna .T. se encontrado, cursor par_cCursorDestino tem 1 linha
    *====================================================================
    PROCEDURE BuscarDescricaoExata(par_cDescrs, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SIGCRRAP " + ;
                       "WHERE descrs = " + EscaparSQL(par_cDescrs) + ;
                       " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ')"

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                SELECT (par_cCursorDestino)
                loc_lResultado = !EOF()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar descri" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorCodigo - Lista para picker (Column1)
    * Busca registros em SIGCRRAP por LIKE no campo codigos
    * par_cValor: prefixo digitado
    * par_cCgrus: grupo do produto (filtro)
    * par_cCursorDestino: cursor a popular
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorCodigo(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE codigos LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY codigos"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarCaracteristicasPorDescricao - Lista para picker (Column2)
    * Busca registros em SIGCRRAP por LIKE no campo descrs
    *====================================================================
    PROCEDURE BuscarCaracteristicasPorDescricao(par_cValor, par_cCgrus, par_cCursorDestino)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cLike
        loc_lResultado = .F.
        TRY
            IF USED(par_cCursorDestino)
                USE IN (par_cCursorDestino)
            ENDIF

            IF EMPTY(par_cValor)
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ELSE
                loc_cLike = EscaparSQL(RTRIM(par_cValor) + "%")
                loc_cSQL = "SELECT codigos, descrs FROM SIGCRRAP " + ;
                           "WHERE descrs LIKE " + loc_cLike + ;
                           " AND cgrus IN (" + EscaparSQL(par_cCgrus) + ", '   ') " + ;
                           "ORDER BY descrs"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar caracter" + CHR(237) + "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * VerificarDuplicidade - Checa se codigo ja existe no cursor local
    * para o mesmo produto (exceto o registro corrente)
    * Retorna .T. se duplicado
    * par_cCodigos: codigo a verificar
    * par_cPkChaveAtual: pkchaves do registro corrente (excluido da busca)
    * par_cCursorCarac: alias do cursor local
    *====================================================================
    PROCEDURE VerificarDuplicidade(par_cCodigos, par_cPkChaveAtual, par_cCursorCarac)
        LOCAL loc_lDuplicado, loc_oErro
        loc_lDuplicado = .F.
        TRY
            IF USED(par_cCursorCarac) AND !EMPTY(par_cCodigos)
                SELECT codigos FROM (par_cCursorCarac) ;
                    WHERE RTRIM(codigos) == RTRIM(par_cCodigos) ;
                    AND RTRIM(pkchaves) != RTRIM(par_cPkChaveAtual) ;
                    AND !DELETED() ;
                    INTO CURSOR cursor_4c_PrCarDupCheck
                SELECT cursor_4c_PrCarDupCheck
                loc_lDuplicado = !EOF()
                USE IN cursor_4c_PrCarDupCheck
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao verificar duplicidade: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

    *====================================================================
    * SalvarTodasCaracteristicas - Persiste cursor local no SQL Server
    * Chamado pelo form pai (SigPrAop/SigPrApr) ao salvar o produto
    * Estrategia: DELETE todas as do produto + INSERT das validas
    * par_cCursorCarac: alias do cursor local
    * par_cCpros: codigo do produto pai
    *====================================================================
    PROCEDURE SalvarTodasCaracteristicas(par_cCursorCarac, par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_lOk
        loc_lResultado = .F.
        TRY
            *-- Remove todas as caracteristicas anteriores do produto
            loc_cSQL = "DELETE FROM sigprcar WHERE cpros = " + EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                loc_lOk = .T.
                *-- Reinsere todas as linhas validas do cursor local
                IF USED(par_cCursorCarac)
                    SELECT (par_cCursorCarac)
                    GO TOP
                    SCAN WHILE !EOF() AND loc_lOk
                        IF !DELETED() AND !EMPTY(codigos)
                            loc_cSQL = "INSERT INTO sigprcar (codigos, cpros, pkchaves) VALUES (" + ;
                                       EscaparSQL(codigos) + ", " + ;
                                       EscaparSQL(par_cCpros) + ", " + ;
                                       EscaparSQL(pkchaves) + ")"
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                                THIS.this_cMensagemErro = "Erro ao salvar caracter" + ;
                                    CHR(237) + "stica: " + ALLTRIM(codigos)
                                loc_lOk = .F.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ENDIF
                IF loc_lOk
                    loc_lResultado = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir caracter" + CHR(237) + ;
                    "sticas anteriores do produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao salvar caracter" + CHR(237) + ;
                "sticas: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

