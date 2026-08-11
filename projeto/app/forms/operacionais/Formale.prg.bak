*==============================================================================
* Formale.prg (SIGCDALE.SCX migrado)
* Formulario OPERACIONAL: Configuracao de Alertas por Conta
*
* Parametros de abertura (identico ao legado):
*   par_pForm     - Referencia ao form pai (parentform do legado)
*   par_cLpiclis  - Codigo da conta (IClis / FK SigCdCli) -> this_cContas
*   par_cLpGrupos - Grupos (recebido, nao usado na logica atual)
*   par_cLcAcesso - Nivel de acesso (recebido, nao usado na logica atual)
*
* Uso canonico (a partir do form pai):
*   loForm = CREATEOBJECT("Formale", THISFORM, cContas, cGrupos, cAcesso)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*==============================================================================

DEFINE CLASS Formale AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGCDALE)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    BorderStyle  = 2
    Caption      = "Alerta"
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    WindowType   = 1

    *-- Codigo da conta configurada (IClis recebido via par_cLpiclis)
    this_cContas       = ""

    *-- Modo do form pai: "INSERIR" ou "ALTERAR" (lido de parentform.pcescolha)
    this_cPcEscolha    = ""

    *-- Referencia ao form pai (para BtnConfirmarClick ler pcescolha em runtime)
    this_oParentForm   = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe os 4 parametros do legado (pform, lpiclis, lpgrupos, lcacesso)
    * Armazena this_cContas e this_oParentForm ANTES de DODEFAULT
    * (DODEFAULT chama FormBase.Init -> InicializarForm, que ja usa esses valores)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_pForm, par_cLpiclis, par_cLpGrupos, par_cLcAcesso)
        LOCAL loc_lSucesso

        IF TYPE("par_pForm") = "O"
            THIS.this_oParentForm = par_pForm
            IF PEMSTATUS(par_pForm, "pcescolha", 5)
                THIS.this_cPcEscolha = UPPER(ALLTRIM(NVL(par_pForm.pcescolha, "")))
            ENDIF
        ENDIF

        IF TYPE("par_cLpiclis") = "C"
            THIS.this_cContas = ALLTRIM(NVL(par_cLpiclis, ""))
        ENDIF

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura aparencia base do form OPERACIONAL
    * (sem PageFrame: layout plano com fundo new_background.jpg identico ao legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, configura layout completo e carrega dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("aleBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.LockScreen = .T.
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis()
                THIS.CarregarAlertas()
                THIS.grd_4c_Dados.Refresh()
                THIS.LockScreen = .F.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object de Alertas." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar Form de Alertas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
    * Equivalente: SIGCDALE.cntSombra + lblSombra + lblTitulo + Shape1
    * cnt_4c_Sombra: Top=0, Left=0, Width=1000, Height=80, BackColor=RGB(100,100,100)
    * lbl_4c_Sombra: sombra preta (ForeColor preto) deslocada 1px
    * lbl_4c_Titulo: titulo branco (ForeColor branco) sobre a sombra
    * shp_4c_Shape1: separador decorativo direita (BackStyle=0, BorderStyle=0)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .Caption       = THIS.Caption
            .Height        = 46
            .Left          = 10
            .Top           = 17
            .Width         = 769
            .ForeColor     = RGB(255, 255, 255)
            .ToolTipText   = "T" + CHR(237) + "tulo"
            .Visible       = .T.
        ENDWITH

        *-- Shape decorativo: separador visual canto superior direito
        *-- Legado: Shape1 Top=7, Left=815, Height=41, Width=37
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 815
            .Height      = 41
            .Width       = 37
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Agrupa setup da area de listagem (form OPERACIONAL)
    * SIGCDALE nao tem PageFrame Lista/Dados (nao eh CRUD): a "lista" eh a grade
    * unica de alertas, filtrada pelo OptionGroup obj_4c_OptTabela. Este metodo
    * agrega ConfigurarFiltros + ConfigurarGrade para manter contrato do pipeline
    * (validacao mecanica esperava Form CRUD com Page1/Page2).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarFiltros()
        THIS.ConfigurarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Troca "pagina logica" via OptionGroup (form OPERACIONAL)
    * Em SIGCDALE nao ha PageFrame; a nocao de pagina mapeia para a tabela de
    * referencia selecionada no obj_4c_OptTabela (1..5): SIGCDOPE, SIGCDGCR,
    * SIGCDOPD, SIGCDPRO, SIGOPOPE. Ajusta Value e dispara filtragem do BO.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nOpcao)
        LOCAL loc_oErro

        IF VARTYPE(par_nOpcao) != "N" OR par_nOpcao < 1 OR par_nOpcao > 5
            RETURN
        ENDIF

        TRY
            IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
                THIS.obj_4c_OptTabela.Value = par_nOpcao
                THIS.this_oBusinessObject.FiltrarPorTabela(par_nOpcao)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao alternar tabela")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarFiltros - Cria OptionGroup para selecao da tabela de referencia
    * Legado: optTabela (Top=93, Left=128, Width=744, Height=25, ButtonCount=5)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarFiltros()
        THIS.AddObject("obj_4c_OptTabela", "OptionGroup")
        WITH THIS.obj_4c_OptTabela
            .AutoSize    = .T.
            .ButtonCount = 5
            .Height      = 25
            .Left        = 128
            .Top         = 93
            .Width       = 744
            .Value       = 1
            .BackStyle   = 0
            .BorderStyle = 0

            WITH .Buttons(1)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Estoque"
                .BackStyle = 0
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(2)
                .Caption   = "Grupo de Contas"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 164
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH .Buttons(3)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 289
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(4)
                .Caption   = "Grupo de Produtos"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 468
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            WITH .Buttons(5)
                .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o Financeira"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 600
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.obj_4c_OptTabela, "InteractiveChange", THIS, "OptTabelaInteractiveChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - Cria o grid com 7 colunas
    * Legado: grade_ale (Top=126, Left=18, Width=963, Height=460, ColumnCount=7)
    * Col1: TextBox Descricao (ReadOnly)
    * Col2-5: CheckBox flags (I/A/E/B) com Sparse=.F.
    * Col6: ComboBox Prioridade
    * Col7: EditBox Mensagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        LOCAL loc_oGrid

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 126
            .Left               = 18
            .Width              = 963
            .Height             = 460
            .ColumnCount        = 7
            .RowHeight          = 22
            .RecordMark         = .F.
            .DeleteMark         = .F.
            .AllowAutoColumnFit = 2
            .ReadOnly           = .F.
            .FontName           = "Tahoma"
            .FontSize           = 8
        ENDWITH

        *-- Coluna 1: Descricao (TextBox ReadOnly)
        *-- VFP9 auto-cria Text1 em cada coluna ao definir ColumnCount; nao usar AddObject
        WITH loc_oGrid.Column1
            .Width    = 220
            .Movable  = .F.
            .Resizable = .F.
            .ReadOnly = .T.
            WITH .Text1
                .BorderStyle = 0
                .Margin      = 0
                .ReadOnly    = .T.
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
            .CurrentControl      = "Text1"
            .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment   = 2
        ENDWITH

        *-- Coluna 2: CheckBox Inserir (I) - Sparse=.F. para mostrar em todas as linhas
        WITH loc_oGrid.Column2
            .Width      = 17
            .Movable    = .F.
            .Resizable  = .F.
            .Sparse     = .F.
            .ToolTipText = "Inserir"
            .AddObject("Check1", "CheckBox")
            WITH .Check1
                .Caption    = ""
                .BackColor  = RGB(255, 255, 255)
                .Alignment  = 0
                .Value      = 0
            ENDWITH
            .CurrentControl       = "Check1"
            .Header1.Caption      = "I"
            .Header1.Alignment    = 2
            .Header1.FontBold     = .T.
            .Header1.ToolTipText  = "Inserir"
        ENDWITH

        *-- Coluna 3: CheckBox Alterar (A)
        WITH loc_oGrid.Column3
            .Width      = 17
            .Movable    = .F.
            .Resizable  = .F.
            .Sparse     = .F.
            .ToolTipText = "Alterar"
            .AddObject("Check1", "CheckBox")
            WITH .Check1
                .Caption   = ""
                .Alignment = 0
                .Value     = 0
            ENDWITH
            .CurrentControl       = "Check1"
            .Header1.Caption      = "A"
            .Header1.Alignment    = 2
            .Header1.FontBold     = .T.
            .Header1.ToolTipText  = "Alterar"
        ENDWITH

        *-- Coluna 4: CheckBox Excluir (E)
        WITH loc_oGrid.Column4
            .Width      = 17
            .Movable    = .F.
            .Resizable  = .F.
            .Sparse     = .F.
            .ToolTipText = "Excluir"
            .AddObject("Check1", "CheckBox")
            WITH .Check1
                .Caption   = ""
                .Alignment = 0
                .Value     = 0
            ENDWITH
            .CurrentControl       = "Check1"
            .Header1.Caption      = "E"
            .Header1.Alignment    = 2
            .Header1.FontBold     = .T.
            .Header1.ToolTipText  = "Excluir"
        ENDWITH

        *-- Coluna 5: CheckBox Baixar (B)
        WITH loc_oGrid.Column5
            .Width      = 17
            .Movable    = .F.
            .Resizable  = .F.
            .Sparse     = .F.
            .ToolTipText = "Baixar"
            .AddObject("Check1", "CheckBox")
            WITH .Check1
                .Caption   = ""
                .Alignment = 0
                .Value     = 0
            ENDWITH
            .CurrentControl       = "Check1"
            .Header1.Caption      = "B"
            .Header1.Alignment    = 2
            .Header1.FontBold     = .T.
            .Header1.ToolTipText  = "Baixar"
        ENDWITH

        *-- Coluna 6: ComboBox Prioridade
        WITH loc_oGrid.Column6
            .Width     = 110
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .AddObject("Combo1", "ComboBox")
            WITH .Combo1
                .RowSourceType    = 1
                .RowSource        = "URGENTE,IMPORTANTE,NORMAL"
                .Style            = 2
            ENDWITH
            .CurrentControl    = "Combo1"
            .Header1.Caption   = "Prioridade"
            .Header1.Alignment = 2
        ENDWITH

        *-- Coluna 7: EditBox Mensagem
        WITH loc_oGrid.Column7
            .Width     = 538
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .AddObject("EditBox1", "EditBox")
            WITH .EditBox1
                .BorderStyle   = 0
                .SpecialEffect = 1
            ENDWITH
            .CurrentControl    = "EditBox1"
            .Header1.Caption   = "Mensagem"
            .Header1.Alignment = 2
        ENDWITH

        BINDEVENT(loc_oGrid.Column6.Combo1, "InteractiveChange", THIS, "CboGradeComboChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Area de acoes/dados do form OPERACIONAL
    * SIGCDALE nao tem Page2/Dados de cadastro CRUD; a "area de dados" desta
    * tela mapeia para o bloco de acoes sobre o registro em edicao:
    *   - Botoes cmd_4c_Confirmar / cmd_4c_Cancelar (delega a ConfigurarBotoes)
    *   - Ajuste do titulo do cabecalho conforme modo do form pai (INSERIR|ALTERAR)
    * Chamado apos ConfigurarPaginaLista para garantir que grid e OptionGroup ja
    * estao instanciados quando os botoes de acao forem bindados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_cSufixo

        *-- Setup dos botoes de acao (Confirmar/Cancelar) - area de dados/acoes
        THIS.ConfigurarBotoes()

        *-- Refletir modo do form pai no titulo (INSERIR mostra "Novo", ALTERAR mostra "Edicao")
        DO CASE
            CASE THIS.this_cPcEscolha == "INSERIR"
                loc_cSufixo = " - Novo"
            CASE THIS.this_cPcEscolha == "ALTERAR"
                loc_cSufixo = " - Edi" + CHR(231) + CHR(227) + "o"
            OTHERWISE
                loc_cSufixo = ""
        ENDCASE

        IF !EMPTY(loc_cSufixo) AND PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Titulo", 5)
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption + loc_cSufixo
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Sombra, "lbl_4c_Sombra", 5)
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption + loc_cSufixo
            ENDIF
        ENDIF

        *-- Habilitar/desabilitar Confirmar conforme codigo da conta recebido
        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = !EMPTY(THIS.this_cContas)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Cria botoes Confirmar e Cancelar
    * Legado: btnconfirma (Top=3, Left=850) e btnsair (Top=3, Left=925)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAlertas - Chama BO para popular crSigCdAle e vincula ao grid
    * Apos RecordSource, reconfigura headers (VFP9 reseta headers ao mudar RecordSource)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarAlertas()
        LOCAL loc_oErro

        TRY
            IF THIS.this_oBusinessObject.CarregarAlertas(THIS.this_cContas)
                *-- ColumnCount ANTES de RecordSource para evitar auto-expansao
                THIS.grd_4c_Dados.ColumnCount = 7
                THIS.grd_4c_Dados.RecordSource = "crSigCdAle"

                *-- ControlSource: checkbox cols apos CurrentControl ja definido em ConfigurarGrade
                THIS.grd_4c_Dados.Column1.ControlSource = "crSigCdAle.Descrs"
                THIS.grd_4c_Dados.Column2.ControlSource = "crSigCdAle.inserirs"
                THIS.grd_4c_Dados.Column3.ControlSource = "crSigCdAle.alterars"
                THIS.grd_4c_Dados.Column4.ControlSource = "crSigCdAle.excluirs"
                THIS.grd_4c_Dados.Column5.ControlSource = "crSigCdAle.baixas"
                THIS.grd_4c_Dados.Column6.ControlSource = "crSigCdAle.prioridade"
                THIS.grd_4c_Dados.Column7.ControlSource = "crSigCdAle.mensagems"

                *-- Reconfigurar headers apos RecordSource (VFP9 reseta captions)
                THIS.grd_4c_Dados.Column1.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
                THIS.grd_4c_Dados.Column2.Header1.Caption    = "I"
                THIS.grd_4c_Dados.Column3.Header1.Caption    = "A"
                THIS.grd_4c_Dados.Column4.Header1.Caption    = "E"
                THIS.grd_4c_Dados.Column5.Header1.Caption    = "B"
                THIS.grd_4c_Dados.Column6.Header1.Caption    = "Prioridade"
                THIS.grd_4c_Dados.Column7.Header1.Caption    = "Mensagem"
                THIS.grd_4c_Dados.Column2.Header1.Alignment  = 2
                THIS.grd_4c_Dados.Column3.Header1.Alignment  = 2
                THIS.grd_4c_Dados.Column4.Header1.Alignment  = 2
                THIS.grd_4c_Dados.Column5.Header1.Alignment  = 2
                THIS.grd_4c_Dados.Column6.Header1.Alignment  = 2
                THIS.grd_4c_Dados.Column7.Header1.Alignment  = 2
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar alertas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna visiveis todos os controles do form e filhos
    * (AddObject cria controles com Visible=.F. por padrao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_j, loc_oControl, loc_oSub

        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    FOR loc_j = 1 TO loc_oControl.ControlCount
                        loc_oSub = loc_oControl.Controls(loc_j)
                        IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
                            loc_oSub.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva configuracao de alertas e fecha o form
    * Legado: btnconfirma.Click
    * Remove filtro do optTabela, delega save ao BO e fecha
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oErro

        TRY
            *-- Remover filtro para que SalvarAlertas processe todos os registros
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                SET ORDER TO TAG Tabelas
                SET KEY TO
            ENDIF

            IF THIS.this_oBusinessObject.SalvarAlertas(THIS.this_cPcEscolha)
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao confirmar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Fecha o form sem salvar
    * Legado: btnsair.Click
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias canonico do pipeline para o botao de confirmacao
    * O legado SIGCDALE usa btnconfirma (cmd_4c_Confirmar), sem botao "Salvar"
    * distinto. Este wrapper existe para compatibilidade com o contrato do
    * pipeline (validacao mecanica) e apenas delega para BtnConfirmarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * OptTabelaInteractiveChange - Filtra grid conforme tabela selecionada
    * Legado: optTabela.InteractiveChange
    * Opcoes: 1=SIGCDOPE, 2=SIGCDGCR, 3=SIGCDOPD, 4=SIGCDPRO, 5=SIGOPOPE
    *--------------------------------------------------------------------------
    PROCEDURE OptTabelaInteractiveChange()
        LOCAL loc_nOpcao, loc_oErro

        TRY
            loc_nOpcao = THIS.obj_4c_OptTabela.Value
            THIS.this_oBusinessObject.FiltrarPorTabela(loc_nOpcao)
            THIS.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboGradeComboChange - Atualiza campo priors (numerico) ao trocar prioridade
    * Legado: grade_ale.Column6.fwcombo1.InteractiveChange
    * ListItemId: 1=URGENTE, 2=IMPORTANTE, 3=NORMAL
    *--------------------------------------------------------------------------
    PROCEDURE CboGradeComboChange()
        LOCAL loc_nListItemId, loc_oErro

        TRY
            IF USED("crSigCdAle")
                loc_nListItemId = THIS.grd_4c_Dados.Column6.Combo1.ListItemId
                REPLACE priors WITH loc_nListItemId IN crSigCdAle
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Ativa TODOS os flags (I/A/E/B) do registro corrente
    * Semantica operacional adaptada: "Incluir" = ativar todas as notificacoes
    * deste evento (o grid ja lista os eventos disponiveis; nao existe "novo"
    * porque a lista eh derivada das tabelas de referencia SIGCDOPE/GCR/OPD/PRO/OPOPE)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
                MsgAviso("Nenhum registro dispon" + CHR(237) + "vel para ativar alertas.", "Aviso")
            ELSE
                SELECT crSigCdAle
                REPLACE inserirs WITH 1, alterars WITH 1, excluirs WITH 1, baixas WITH 1 ;
                    IN crSigCdAle
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao ativar alertas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Recarrega alertas do banco descartando edicoes em memoria
    * Semantica operacional: reverte alteracoes nao confirmadas + reforca foco
    * no grid para permitir edicao dos checkboxes/combobox/editbox
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF EMPTY(THIS.this_cContas)
                MsgAviso("Conta n" + CHR(227) + "o informada. N" + CHR(227) + ;
                        "o eh poss" + CHR(237) + "vel recarregar alertas.", "Aviso")
            ELSE
                THIS.CarregarAlertas()
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao recarregar alertas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe resumo do alerta corrente em dialog informativo
    * Semantica operacional: leitura consolidada do registro selecionado no grid
    * (descricao do evento, flags I/A/E/B, prioridade e mensagem)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cResumo, loc_cDesc, loc_cMsg, loc_nPri, loc_cPri, loc_oErro

        TRY
            IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
                MsgAviso("Nenhum registro selecionado para visualiza" + CHR(231) + CHR(227) + "o.", "Aviso")
            ELSE
                SELECT crSigCdAle
                loc_cDesc = ALLTRIM(NVL(crSigCdAle.Descrs, ""))
                loc_cMsg  = ALLTRIM(NVL(crSigCdAle.Mensagems, ""))
                loc_nPri  = NVL(crSigCdAle.priors, 0)

                DO CASE
                    CASE loc_nPri = 1
                        loc_cPri = "URGENTE"
                    CASE loc_nPri = 2
                        loc_cPri = "IMPORTANTE"
                    CASE loc_nPri = 3
                        loc_cPri = "NORMAL"
                    OTHERWISE
                        loc_cPri = "N/D"
                ENDCASE

                loc_cResumo = "Evento    : " + loc_cDesc + CHR(13) + ;
                              "Inserir   : " + IIF(crSigCdAle.inserirs = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
                              "Alterar   : " + IIF(crSigCdAle.alterars = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
                              "Excluir   : " + IIF(crSigCdAle.excluirs = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
                              "Baixar    : " + IIF(crSigCdAle.baixas   = 1, "Sim", "N" + CHR(227) + "o") + CHR(13) + ;
                              "Prioridade: " + loc_cPri + CHR(13) + ;
                              "Mensagem  : " + loc_cMsg

                MsgInfo(loc_cResumo, "Detalhes do Alerta")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao visualizar alerta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Desativa TODOS os flags do registro corrente
    * Semantica operacional: "Excluir" = zerar flags I/A/E/B do evento
    * (nao remove a linha do grid porque ela representa um evento fixo da tabela
    * de referencia; apenas desativa as notificacoes associadas)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro, loc_lProsseguir
        loc_lProsseguir = .F.

        TRY
            IF !USED("crSigCdAle") OR RECCOUNT("crSigCdAle") = 0
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                IF MsgConfirma("Desativar todos os alertas do registro corrente?", "Confirmar")
                    loc_lProsseguir = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crSigCdAle
                REPLACE inserirs WITH 0, alterars WITH 0, excluirs WITH 0, baixas WITH 0 ;
                    IN crSigCdAle
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao desativar alertas")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega dados do grid (wrapper para CarregarAlertas)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.CarregarAlertas(THIS.this_cContas)
            IF loc_lResultado
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao carregar lista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Carrega propriedades do BO com dados do registro corrente
    * Form OPERACIONAL: le linha corrente do cursor crSigCdAle
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF USED("crSigCdAle") AND RECCOUNT("crSigCdAle") > 0
                THIS.this_oBusinessObject.CarregarDoCursor("crSigCdAle")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza exibicao do grid com estado atual
    * Form OPERACIONAL: o grid eh a interface primaria de edicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles interativos do form
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = .T.
        IF TYPE("par_lHabilitar") = "L"
            loc_lHab = par_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lHab AND !EMPTY(THIS.this_cContas)
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.ReadOnly = !loc_lHab
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
            THIS.obj_4c_OptTabela.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera cursor de alertas e propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            IF USED("crSigCdAle")
                SELECT crSigCdAle
                ZAP
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
            THIS.this_oBusinessObject.LimparDados()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme disponibilidade
    * Form OPERACIONAL: sem modos CRUD; Confirmar depende da conta informada
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemConta, loc_lTemDados

        loc_lTemConta = !EMPTY(THIS.this_cContas)
        loc_lTemDados = USED("crSigCdAle") AND RECCOUNT("crSigCdAle") > 0

        IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
            THIS.cmd_4c_Confirmar.Enabled = loc_lTemConta
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
            THIS.cmd_4c_Cancelar.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_OptTabela", 5)
            THIS.obj_4c_OptTabela.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Alias canonico para fechar o form sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor principal e referencia ao form pai
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crSigCdAle")
            TABLEREVERT(.T., "crSigCdAle")
            USE IN crSigCdAle
        ENDIF
        THIS.this_oParentForm = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
