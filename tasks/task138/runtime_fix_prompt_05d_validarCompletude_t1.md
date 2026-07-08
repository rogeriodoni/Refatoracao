# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[SigPdM13BO.prg] Indicador de pendencia: *   - Pendente
[FormSigPdM13.prg] Procedure vazia (sem codigo): ConfigurarPaginaLista
[FormSigPdM13.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSigPdM13.prg] Procedure vazia (sem codigo): BtnIncluirClick
[FormSigPdM13.prg] Procedure vazia (sem codigo): BtnAlterarClick
[FormSigPdM13.prg] Procedure vazia (sem codigo): BtnVisualizarClick
[FormSigPdM13.prg] Procedure vazia (sem codigo): BtnExcluirClick
[FormSigPdM13.prg] Procedure vazia (sem codigo): BtnSalvarClick
[FormSigPdM13.prg] Procedure vazia (sem codigo): HabilitarCampos
[FormSigPdM13.prg] Procedure vazia (sem codigo): AjustarBotoesPorModo

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM13.prg):
*==============================================================================
* FormSigPdM13.prg - Checagem de Devolucao de Pedras
* Origem: SIGPDM13.SCX (OPERACIONAL)
* Herda de: FormBase
* Tipo: OPERACIONAL (modal, recebe par_nNenvs como parametro)
*==============================================================================

DEFINE CLASS FormSigPdM13 AS FormBase

    *-- Dimensoes (escalonado de 800 para 1000)
    Width        = 1000
    Height       = 600
    Caption      = ""
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    AlwaysOnTop  = .T.
    AutoCenter   = .T.
    WindowType   = 1
    ClipControls = .F.
    DataSession  = 2

    *-- Numero do envelope (parametro de entrada)
    this_nNenvs          = 0

    *-- Totalizador das quantidades
    this_nTotalQtds      = 0

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - armazena numero do envelope antes de FormBase.Init() rodar
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nNenvs)
        THIS.this_nNenvs = par_nNenvs
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - chamado automaticamente por FormBase.Init()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPdM13BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.LockScreen = .T.

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarContainerOperacao()
                THIS.ConfigurarShape1()
                THIS.ConfigurarBotaoOK()
                THIS.ConfigurarGrid()
                THIS.ConfigurarTotalizador()

                THIS.CarregarDados()

                THIS.TornarControlesVisiveis(THIS)

                THIS.LockScreen = .F.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao instanciar SigPdM13BO.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura layout base do form operacional
    * Form OPERACIONAL (checagem de devolucao de pedras): NAO usa o padrao
    * CRUD (Page1=Lista / Page2=Dados). O layout e CUSTOMIZADO conforme o
    * SCX legado: cabecalho escuro (cntSombra), container de operacao
    * corrente (Opera...o), shape decorativo (Shape1), grid de pendencias
    * (Grade), totalizador (Qtd_os) e botao OK posicionados diretamente
    * no form.
    *
    * Este metodo define as propriedades visuais "page-level" derivadas do
    * Caption do form e do background do framework. As proximas fases
    * adicionam container de operacao, grid, totalizador e botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- Caption sem literais acentuados (CHR(231)=c-cedilha, CHR(227)=a-til)
        THIS.Caption = "Checagem de Devolu" + CHR(231) + CHR(227) + "o de Pedras"

        *-- Imagem de fundo do framework
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

        *-- Form modal sempre ao topo (WindowType=1 modal, AlwaysOnTop=.T.)
        THIS.WindowType  = 1
        THIS.AlwaysOnTop = .T.
        THIS.AutoCenter  = .T.

        *-- Padroniza fonte base aplicada por heranca aos controles filhos
        THIS.FontName = "Tahoma"
        THIS.FontSize = 8
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container escuro com titulo do form
    * Origem: cntSombra (Top=0, Left=0, Width=800?1000, Height=80)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cCaption
        loc_cCaption = "Checagem de Devolu" + CHR(231) + CHR(227) + "o de Pedras"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCnt = THIS.cnt_4c_Cabecalho
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- lblSombra: sombra preta deslocada (ForeColor preto)
        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 969
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0,0,0)
            .Caption       = loc_cCaption
            .Visible       = .T.
        ENDWITH

        *-- lblTitulo: titulo branco principal
        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 969
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255,255,255)
            .Caption   = loc_cCaption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera BO e cursores ao fechar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Operacao")
            USE IN cursor_4c_Operacao
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarContainerOperacao - Container de info do envelope (read-only)
    * Origem: SIGPDM13.Opera??o (Top=94, Left=60, Width=372, Height=40)
    * Conteudo: label "Movimentacao :", empresa, operacao, numero do envelope
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContainerOperacao()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Operacao", "Container")
        loc_oCnt = THIS.cnt_4c_Operacao
        WITH loc_oCnt
            .Top         = 94
            .Left        = 75
            .Width       = 465
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Top      = 12
            .Left     = 10
            .AutoSize = .T.
            .BackStyle = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Caption  = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .Visible  = .T.
        ENDWITH

        *-- Empresa do envelope (GetEmpresa do legado)
        loc_oCnt.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oCnt.txt_4c_Empresa
            .Top               = 8
            .Left              = 130
            .Width             = 45
            .Height            = 23
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Codigo da operacao (GetOperacao do legado)
        loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
        WITH loc_oCnt.txt_4c_Operacao
            .Top               = 8
            .Left              = 178
            .Width             = 195
            .Height            = 23
            .ReadOnly          = .T.
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .Value             = ""
            .Visible           = .T.
        ENDWITH

        *-- Numero do envelope (GetCodigo do legado)
        loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oCnt.txt_4c_Codigo
            .Top               = 8
            .Left              = 375
            .Width             = 101
            .Height            = 23
            .ReadOnly          = .T.
            .Format            = "L"
            .InputMask         = "9999999999"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0,0,0)
            .DisabledBackColor = RGB(255,255,255)
            .Value             = 0
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoOK - Botao OK que fecha o form
    * Origem: SIGPDM13.Ok (Top=3, Left=725->906, Width=75, Height=75)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoOK()
        THIS.AddObject("cmd_4c_Ok", "CommandButton")
        WITH THIS.cmd_4c_Ok
            .Top             = 3
            .Left            = 906
            .Width           = 75
            .Height          = 75
            .Caption         = "OK"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnOKClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grid 4 colunas: Movimentacao|Componente|TpMaterial|Qtd
    * Origem: SIGPDM13.Grade (Top=132, Left=67->84, Width=673->841, Height=426)
    * Ordem visual: EmpDnPs | Cmats | TpOps | Qtds
    * Todas as colunas read-only (form de checagem/consulta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrd

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = THIS.grd_4c_Dados
        loc_oGrd.ColumnCount = 4

        WITH loc_oGrd
            .Top           = 132
            .Left          = 84
            .Width         = 841
            .Height        = 426
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .GridLineColor = RGB(238,238,238)
            .FontName      = "Verdana"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        WITH loc_oGrd.Column1
            .ColumnOrder        = 1
            .Width              = 270
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .T.
            .FontName           = "Courier New"
            .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0,0,0)
            .Text1.FontName     = "Courier New"
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .T.
            .Text1.ForeColor    = RGB(0,0,0)
            .Text1.BackColor    = RGB(255,255,255)
        ENDWITH

        *-- Column2 (Componente/Cmats) exibida por ULTIMO (ColumnOrder=4),
        *-- replicando o SCX legado onde Column2.ColumnOrder=4
        WITH loc_oGrd.Column2
            .ColumnOrder        = 4
            .Width              = 153
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .T.
            .Header1.Caption    = "Componente"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0,0,0)
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .T.
            .Text1.ForeColor    = RGB(0,0,0)
            .Text1.BackColor    = RGB(255,255,255)
        ENDWITH

        WITH loc_oGrd.Column3
            .ColumnOrder        = 3
            .Width              = 188
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .T.
            .Header1.Caption    = "Tipo de Material"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0,0,0)
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .T.
            .Text1.ForeColor    = RGB(0,0,0)
            .Text1.BackColor    = RGB(255,255,255)
        ENDWITH

        *-- Column4 (Quantidade/Qtds) exibida em SEGUNDO lugar (ColumnOrder=2),
        *-- replicando o SCX legado onde Column4 fisico tinha ColumnOrder=2
        WITH loc_oGrd.Column4
            .ColumnOrder        = 2
            .Width              = 188
            .Movable            = .F.
            .Resizable          = .F.
            .ReadOnly           = .T.
            .Header1.Caption    = "Quantidade"
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Header1.Alignment  = 2
            .Header1.ForeColor  = RGB(0,0,0)
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .T.
            .Text1.ForeColor    = RGB(0,0,0)
            .Text1.BackColor    = RGB(255,255,255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarTotalizador - TextBox para exibir SUM(Qtds)
    * Origem: SIGPDM13.Qtd_os (Top=566, Left=596->745, Width=124->155)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarTotalizador()
        THIS.AddObject("txt_4c_TotalQtds", "TextBox")
        WITH THIS.txt_4c_TotalQtds
            .Top       = 566
            .Left      = 745
            .Width     = 155
            .Height    = 21
            .InputMask = "9999"
            .MaxLength = 4
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega dados do envelope e popula grid
    * 1. BO.CarregarOperacao -> preenche container Operacao
    * 2. BO.CarregarDados   -> popula cursor_4c_Dados
    * 3. Rebind do grid (ControlSource + headers reconfigurados apos RecordSource)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso, loc_oGrd, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Carregar informacoes do envelope (empresa, operacao, numero)
            IF THIS.this_oBusinessObject.CarregarOperacao(THIS.this_nNenvs)
                WITH THIS.cnt_4c_Operacao
                    .txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
                    .txt_4c_Operacao.Value = THIS.this_oBusinessObject.this_cDopps
                    .txt_4c_Codigo.Value   = THIS.this_oBusinessObject.this_nNumps
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Carregar pendencias de devolucao de pedras
            IF THIS.this_oBusinessObject.CarregarDados(THIS.this_nNenvs)
                loc_oGrd = THIS.grd_4c_Dados

                *-- RecordSource antes de ControlSource (reseta headers - Licao #2 FORMCOR)
                loc_oGrd.ColumnCount  = 4
                loc_oGrd.RecordSource = "cursor_4c_Dados"

                loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.EmpDnPs"
                loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.Cmats"
                loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.TpOps"
                loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.Qtds"

                *-- Reconfigurar headers obrigatoriamente apos RecordSource
                loc_oGrd.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Column2.Header1.Caption = "Componente"
                loc_oGrd.Column3.Header1.Caption = "Tipo de Material"
                loc_oGrd.Column4.Header1.Caption = "Quantidade"

                THIS.txt_4c_TotalQtds.Value = THIS.this_oBusinessObject.this_nTotalQtds

                loc_oGrd.Refresh()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - Fecha o form (replica: ThisForm.Release do legado Ok.Click)
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - No-op em form OPERACIONAL de layout direto
    *
    * InicializarForm() configura todos os controles diretamente sem delegar
    * a este metodo. Mantido apenas para compatibilidade com o pipeline de
    * migracao multi-fase. NUNCA adicionar AddObject aqui - duplicaria
    * objetos ja criados e causaria "member already exists".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Form OPERACIONAL: layout configurado diretamente em InicializarForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarShape1 - Shape decorativo atras do botao OK
    * Origem: SIGPDM13.Shape1 (Top=7, Left=699->874, Width=90->113, Height=110)
    * BackStyle=0 + BorderStyle=0: elemento transparente de z-order/agrupamento
    * BorderColor=RGB(136,189,188) preservado conforme SCX legado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape1()
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 874
            .Width       = 113
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136,189,188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - No-op em forms OPERACIONAIS sem pagina de edicao
    *
    * Este form (Checagem de Devolucao de Pedras) e OPERACIONAL de consulta:
    * todos os controles sao read-only e nao ha "Page2 de edicao/dados" como
    * nos forms CRUD (frmcadastro). O metodo existe apenas para compatibilidade
    * com o pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Form OPERACIONAL sem pagina de dados - nenhuma acao necessaria
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - No-op em forms OPERACIONAIS de pagina unica
    *
    * Forms OPERACIONAIS de consulta como este nao tem multiplas paginas
    * (nao ha "Lista" + "Dados"), portanto nao ha como alternar. Mantemos o
    * metodo como ponto de extensao e para compatibilizar com o pipeline.
    * Apenas refresca o grid caso o BO tenha alterado o cursor entre
    * chamadas (ex: re-execucao de CarregarDados).
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        *-- Nao ha PageFrame neste form; apenas reforca o refresh do grid
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - No-op: form OPERACIONAL read-only (checagem)
    *
    * SIGPDM13 e um form de CONSULTA/CHECAGEM de devolucao de pedras.
    * Nao ha operacao de inclusao: o grid exibe pendencias calculadas pelo
    * legado via SELECT em SigCdNei+SigCdOpd+SigOpOpt (queries somente-leitura).
    * Nenhum botao Incluir existe na UI deste form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        *-- Form OPERACIONAL de checagem: operacao de inclusao nao aplicavel
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - No-op: form OPERACIONAL read-only (checagem)
    *
    * Todos os controles do grid (Column1-4) tem ReadOnly=.T. e When=.F.,
    * replicando o comportamento do SCX legado onde nenhuma coluna era
    * editavel pelo usuario. Nenhum botao Alterar existe na UI deste form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        *-- Form OPERACIONAL de checagem: operacao de alteracao nao aplicavel
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - No-op: form OPERACIONAL sempre em modo consulta
    *
    * O form inteiro e modo VISUALIZAR por natureza: exibe pendencias de
    * devolucao de pedras do envelope (par_nNenvs) sem permitir edicao.
    * Nenhum botao Visualizar existe na UI deste form.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        *-- Form OPERACIONAL de checagem: modo visualizar e o unico modo existente
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - No-op: form OPERACIONAL sem operacao de exclusao
    *
    * Checagem de Devolucao de Pedras e um form de consulta que apenas
    * verifica status de pendencias. Nenhuma exclusao de registros e
    * realizada a partir deste form. Nenhum botao Excluir existe na UI.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        *-- Form OPERACIONAL de checagem: operacao de exclusao nao aplicavel
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega dados do envelope (refresh da consulta)
    * Form OPERACIONAL: "buscar" equivale a recarregar os dados do envelope
    * corrente sem alterar THIS.this_nNenvs.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form (mesmo comportamento que BtnOKClick)
    * Botao OK fisico do SCX legado usa ThisForm.Release; mapeado aqui para
    * compatibilidade com o pipeline FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - No-op: form OPERACIONAL read-only sem edicao
    * Todos os controles sao ReadOnly=.T.; nenhuma gravacao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        *-- Form OPERACIONAL de checagem: nao ha dados editaveis para salvar
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o form sem alteracoes
    * Form OPERACIONAL read-only: cancelar e equivalente a fechar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega o grid com dados do envelope corrente
    * Wrapper sobre CarregarDados() para compatibilidade com pipeline FormBase.
    * Em forms CRUD CarregarLista popula o grid da Page1; aqui popula o unico
    * grid de consulta usando THIS.this_nNenvs ja armazenado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia parametro de entrada do form para o BO
    * Unico "campo editavel" pelo chamador e o numero do envelope (par_nNenvs
    * recebido em Init). Preenche BO para eventual requery por BtnBuscarClick.
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_nNenvs = THIS.this_nNenvs
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles de exibicao com propriedades do BO
    * Replica o bloco de atribuicao de CarregarDados() para que o pipeline
    * FormBase possa refresh os campos do container Operacao e o totalizador
    * sem re-executar a query completa.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        WITH THIS.cnt_4c_Operacao
            .txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
            .txt_4c_Operacao.Value = THIS.this_oBusinessObject.this_cDopps
            .txt_4c_Codigo.Value   = THIS.this_oBusinessObject.this_nNumps
            .Visible     = .T.
        ENDWITH
        THIS.txt_4c_TotalQtds.Value = THIS.this_oBusinessObject.this_nTotalQtds
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - No-op: todos os controles sao ReadOnly=.T.
    * O form e de consulta pura; ReadOnly foi definido no AddObject e nao
    * precisa ser alternado por modo. Mantido para compatibilidade FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        *-- Form OPERACIONAL de checagem: controles sempre read-only
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de exibicao (container Operacao e total)
    * Chamado antes de carregar novos dados para evitar exibicao residual.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        WITH THIS.cnt_4c_Operacao
            .txt_4c_Empresa.Value  = ""
            .txt_4c_Operacao.Value = ""
            .txt_4c_Codigo.Value   = 0
            .Visible     = .T.
        ENDWITH
        THIS.txt_4c_TotalQtds.Value = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - No-op: form OPERACIONAL sem alternancia de modo
    * SIGPDM13 tem apenas um botao (OK/Release) sem estados INCLUIR/ALTERAR/
    * VISUALIZAR. Mantido para compatibilidade com pipeline FormBase.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        *-- Form OPERACIONAL: modo unico de consulta, sem ajuste de botoes necessario
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdM13BO.prg):
*==============================================================================
* SigPdM13BO.prg - Business Object para Checagem de Devolucao de Pedras
* Origem: SIGPDM13.SCX
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS SigPdM13BO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela      = "SigCdNei"
    this_cCampoChave  = "Nenvs"

    *-- Parametro de entrada: numero do envelope
    this_nNenvs       = 0

    *-- Informacoes do envelope (container Operacao)
    this_nNumps       = 0         && Numero do envelope
    this_cEmps        = ""        && Empresa
    this_cDopps       = ""        && Codigo da operacao

    *-- Campos da linha corrente do cursor (SigCdNei)
    this_cEmpDnPs     = ""        && Empresa/deposito da movimentacao
    this_cCmats       = ""        && Componente/material
    this_nQtds        = 0         && Quantidade
    this_cTpOps       = ""        && Tipo de operacao

    *-- Totalizador: SUM(Qtds) apos carregar cursor
    this_nTotalQtds   = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdNei")
        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "Nenvs"
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNenvs
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades da linha corrente de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                THIS.this_cCmats   = TratarNulo(Cmats,   "C")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cTpOps   = TratarNulo(TpOps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega informacoes do envelope para o container
    * par_nNenvs: numero do envelope
    * Cria cursor_4c_Operacao com numps, emps, dopps para ControlSource
    *--------------------------------------------------------------------------
    FUNCTION CarregarOperacao(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            *-- Valores default: envelope passado, campos vazios
            THIS.this_nNumps = par_nNenvs
            THIS.this_cEmps  = ""
            THIS.this_cDopps = ""

            loc_cSQL = "SELECT TOP 1 numps, emps, dopps " + ;
                       "FROM SigCdNei " + ;
                       "WHERE Nenvs = " + TRANSFORM(par_nNenvs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacaoTemp")

            IF loc_nResultado >= 1 AND RECCOUNT("cursor_4c_OperacaoTemp") > 0
                SELECT cursor_4c_OperacaoTemp
                GO TOP
                THIS.this_nNumps = TratarNulo(numps, "N")
                THIS.this_cEmps  = TratarNulo(emps,  "C")
                THIS.this_cDopps = TratarNulo(dopps, "C")
            ENDIF

            IF USED("cursor_4c_OperacaoTemp")
                USE IN cursor_4c_OperacaoTemp
            ENDIF

            *-- Recriar cursor de bind para container Operacao
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Operacao (numps N(10,0) NULL, emps C(3) NULL, dopps C(20) NULL)
            SET NULL OFF

            SELECT cursor_4c_Operacao
            APPEND BLANK
            REPLACE numps WITH THIS.this_nNumps
            REPLACE emps  WITH THIS.this_cEmps
            REPLACE dopps WITH THIS.this_cDopps
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDados - Executa UNION ALL do legado e popula cursor_4c_Dados
    * Replica exata da query de SIGPDM13.Init:
    *   - Pendentes devolucao: SepPedras=1, ChkDests<>4, tipo com chkDevs='S'
    *   - Ja devolvidos: ChkDests=4, Qtds negativo
    * par_nNenvs: numero do envelope
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_nNenvs)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            THIS.this_nNenvs     = par_nNenvs
            THIS.this_nTotalQtds = 0

            *-- Protecao uncommitted changes no cursor do grid
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT a.EmpDnPs, a.Cmats, a.Qtds, a.TpOps " + ;
                       "FROM SigCdNei a, SigCdOpd b, SigOpOpt c " + ;
                       "WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.SepPedras = 1" + ;
                       " AND b.ChkDests <> 4" + ;
                       " AND a.TpOps = c.Cods AND c.chkDevs = 'S'" + ;
                       " UNION ALL" + ;
                       " SELECT a.EmpDnPs, a.Cmats, (a.Qtds * -1) AS Qtds, a.TpOps" + ;
                       " FROM SigCdNei a, SigCdOpd b" + ;
                       " WHERE a.Nenvs = " + TRANSFORM(par_nNenvs) + ;
                       " AND a.Dopps = b.Dopps AND b.ChkDests = 4" + ;
                       " ORDER BY a.Cmats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado < 1
                MsgErro("Falha ao carregar dados de devolu" + CHR(231) + CHR(227) + "o de pedras.", "Erro")
            ELSE
                *-- Calcular total (replica: Sum Qtds to _Total do legado)
                SELECT cursor_4c_DadosTemp
                SUM Qtds TO THIS.this_nTotalQtds
                GO TOP

                *-- Criar cursor definitivo com estrutura identica ao temporario
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (EmpDnPs C(33) NULL, Cmats C(14) NULL, Qtds N(9,3) NULL, TpOps C(15) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                GO TOP

                USE IN cursor_4c_DadosTemp

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei com os campos disponiveis na linha corrente
    * Form SIGPDM13 eh OPERACIONAL/consulta - este metodo existe para paridade
    * com BusinessBase e eventuais chamadas de processo de checagem.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdNei " + ;
                       "(Nenvs, numps, emps, dopps, EmpDnPs, Cmats, Qtds, TpOps) " + ;
                       "VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nNenvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)   + ", " + ;
                       EscaparSQL(THIS.this_cEmps)           + ", " + ;
                       EscaparSQL(THIS.this_cDopps)          + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)        + ", " + ;
                       EscaparSQL(THIS.this_cCmats)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)    + ", " + ;
                       EscaparSQL(THIS.this_cTpOps)          + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao inserir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei dos campos da linha corrente
    * Usa Nenvs + EmpDnPs + Cmats como filtro (chave composta natural)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Qtds   = " + FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       "TpOps  = " + EscaparSQL(THIS.this_cTpOps)        + ", " + ;
                       "numps  = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       "emps   = " + EscaparSQL(THIS.this_cEmps)         + ", " + ;
                       "dopps  = " + EscaparSQL(THIS.this_cDopps)        + " " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs) + ;
                       " AND EmpDnPs = " + EscaparSQL(THIS.this_cEmpDnPs) + ;
                       " AND Cmats = "   + EscaparSQL(THIS.this_cCmats)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNei filtrado pela chave corrente
    * PROTECTED conforme padrao BusinessBase (chamado via Excluir() publico)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdNei " + ;
                       "WHERE Nenvs = " + FormatarNumeroSQL(THIS.this_nNenvs) + ;
                       " AND EmpDnPs = " + EscaparSQL(THIS.this_cEmpDnPs) + ;
                       " AND Cmats = "   + EscaparSQL(THIS.this_cCmats)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 1
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao excluir registro em SigCdNei.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigCdNei") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nNenvs)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE

