*==============================================================================
* FORMSIGOPFLU.PRG
* Impressao de FollowUp - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGOPFLU.SCX (frmrelatorio)
*
* Filtros:
*   - Periodo : Data Inicial + Data Final
*   - Grupo   : Codigo (SigCdGcr.codigos) + Descricao (SigCdGcr.descrs)
*   - Conta   : Codigo (SigCdCli.Iclis) + Descricao (SigCdCli.Rclis)
*   - Opcao   : Imprime Data / Hora da Ocorrencia (ChkData)
*==============================================================================

DEFINE CLASS FormSIGOPFLU AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=220)
    Height      = 220
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

    *-- Guarda de reentrancia dos lookups (regra #37/#47): o picker eh MODAL
    *-- e tira o foco do campo, o que redispara o proprio LostFocus.
    this_lEmLookup     = .F.

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de FollowUp"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGOPFLUBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGOPFLUBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.AlternarPagina(1)
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
    *   Largura total do form (Width) para cobrir toda a faixa superior.
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
                .Caption   = "Impress" + CHR(227) + "o de FollowUp"
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
                .Caption   = "Impress" + CHR(227) + "o de FollowUp"
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
    * ConfigurarBotoes - Barra de acao do relatorio (btnReport do frmrelatorio)
    *   CommandGroup unico com 4 botoes: Visualizar / Imprimir / Arquivos Email
    *   / Encerrar. Criado DEPOIS de cnt_4c_Cabecalho para desenhar POR CIMA da
    *   faixa cinza (a faixa ocupa Top=0..80 e os botoes Top=-2..83).
    *
    *   Geometria transcrita do SCX legado (os overrides do SCX PRECEDEM os
    *   defaults do framework.vcx):
    *     btnReport.Top=-2 Left=495 Width=310 Height=85
    *     Visualiza/Imprime/DocExcel/Sair: Top=5 Width=75 Height=75
    *     Lefts = 5 / 80 / 155 / 230  (230+75 = 305 <= 310, nenhum botao corta)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 495
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            *-- Botao 1: Visualizar (preview em tela)
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Visualizar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .F.
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 2: Imprimir (impressora com dialogo)
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Imprimir"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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

            *-- Botao 3: Arquivos Email (geracao de arquivo para envio)
            WITH .Buttons(3)
                .Top             = 5
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Arquivos Email"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Botao 4: Encerrar (Cancel = .T. para o ESC fechar o form)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Encerrar"
                .WordWrap        = .T.
                .Cancel          = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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

        *-- Eventos dos botoes do relatorio (FASE 7).
        *   BINDEVENT vai em Buttons(N) do CommandGroup, NUNCA no grupo: o
        *   legado trata o clique num unico btnReport.Click lendo This.Value,
        *   e o mapeamento dos indices vem de frmrelatorio.btnReport.Click no
        *   framework.vcx -> 1 = Video (preview), 2 = Impressora,
        *   3 = Excel/Arquivos Email, 4 = Encerrar.
        *   Click nao passa parametro, entao os handlers nao declaram nenhum
        *   (regra #3) e sao PUBLIC (BINDEVENT ignora metodo PROTECTED).
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado abaixo do cabecalho (Top=85) ate o fim do form.
    *   Os controles de filtro (Periodo/Grupo/Conta/ChkData) entram na
    *   Page1 via ConfigurarPaginaLista(); os botoes do relatorio
    *   (Visualizar/Imprimir/Arquivos Email/Encerrar) ficam em
    *   cmg_4c_Botoes, criado por ConfigurarBotoes() ANTES deste metodo.
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

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        *-- Controles de filtro da Page1 (labels, datas, grupo,
        *-- conta e a opcao de impressao de data/hora)
        THIS.ConfigurarPaginaLista()

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Page1)
    *   Form REPORT tem pagina UNICA: a Page1 eh ao mesmo tempo a pagina de
    *   parametros ("lista") e a de campos ("dados"). Este metodo recebe a
    *   PRIMEIRA METADE dos campos do SCX legado, na mesma ordem de criacao do
    *   original:
    *     Periodo : Say2 + getDtInicial + Say3 + getDtFinal
    *     Grupo   : Say1 + getGrupo     + getDGrupo
    *   Os campos restantes (Conta e a opcao de data/hora) ficam em
    *   ConfigurarPaginaLista, que chama este metodo ANTES de criar os seus,
    *   para que a ordem de AddObject seja a mesma do legado.
    *
    *   Offset de Top: como os controles moram na Page1 e o PageFrame esta em
    *   Top=85, todo Top do legado entra como (Top_original - 85):
    *     Say2 101->16 | getDtInicial 98->13 | Say3 101->16 | getDtFinal 98->13
    *     Say1 128->43 | getGrupo 124->39    | getDGrupo 124->39
    *
    *   A faixa cinza do titulo NAO eh recriada dentro da pagina: em form de
    *   relatorio ela eh filha do FORM (criada por ConfigurarCabecalho, em
    *   Top=0..80) e o PageFrame comeca logo abaixo dela, em Top=85 - repetir a
    *   faixa aqui desenharia duas faixas sobrepostas.
    *
    *   Labels: a classe "say" do framework eh AutoSize=.T./Alignment=0/
    *   ForeColor=90,90,90 e o SCX so declara Caption/Left/Top/Width. Aqui
    *   AutoSize entra .F. (eh no-op em Label criado por AddObject e com ele a
    *   Height declarada seria descartada) com Width/Height transcritos.
    *   Os campos de data vem da classe "fweditdata" (Width=80, Height=23,
    *   Alignment=3, Tahoma 8, Themes=.F.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *----------------------------------------------------------------------
        *-- Linha 1: Periodo (Data Inicial ate Data Final)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Per" + CHR(237) + "odo :"
            .Left      = 195
            .Top       = 16
            .Width     = 45
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DtInicial
            *-- Legado: ThisForm.GetDtInicial.Value = Date() no Init
            .Value             = DATE()
            .Left              = 242
            .Top               = 13
            .Width             = 80
            .Height            = 23
            .Alignment         = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 1
            .ToolTipText       = "Data inicial do per" + CHR(237) + "odo"
            .Visible           = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            *-- Separador do periodo: a-grave (CHR(224)), como no SCX
            .Caption   = CHR(224)
            .Left      = 328
            .Top       = 16
            .Width     = 8
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DtFinal
            *-- Legado: ThisForm.GetDtFinal.Value = Date() no Init
            .Value             = DATE()
            .Left              = 341
            .Top               = 13
            .Width             = 80
            .Height            = 23
            .Alignment         = 3
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .BackColor         = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .Themes            = .F.
            .TabIndex          = 2
            .ToolTipText       = "Data final do per" + CHR(237) + "odo"
            .Visible           = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 2: Grupo contabil (SigCdGcr.Codigos + SigCdGcr.Descrs)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Grupo :"
            .Left      = 202
            .Top       = 43
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 10
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value             = ""
            .Left              = 242
            .Top               = 39
            .Width             = 80
            .Height            = 25
            .MaxLength         = 10
            .Format            = "K"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 3
            .ToolTipText       = "C" + CHR(243) + "digo do grupo cont" + CHR(225) + "bil"
            .Visible           = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Value             = ""
            .Left              = 324
            .Top               = 39
            .Width             = 150
            .Height            = 25
            .MaxLength         = 20
            .Format            = "K"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 4
            .ToolTipText       = "Descri" + CHR(231) + CHR(227) + "o do grupo cont" + CHR(225) + "bil"
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Campos de filtro restantes e funil da pagina
    *   FORM REPORT: a Page1 eh a unica pagina e contem os filtros. O nome
    *   "ConfigurarPaginaLista" eh o do pipeline multi-fase (em form CRUD esta
    *   seria a pagina de Lista; aqui eh a pagina de Filtros do relatorio) e eh
    *   por ele que ConfigurarPageFrame monta a pagina inteira.
    *
    *   A primeira metade dos campos (Periodo e Grupo) eh criada por
    *   ConfigurarPaginaDados, chamado na primeira linha deste metodo para
    *   preservar a ordem de AddObject do SCX legado. Aqui ficam os demais,
    *   tambem com o Top deslocado em (Top_original - 85):
    *     lbl_estoque "Conta" 155->70 | getConta 151->66 | getDConta 151->66
    *     ChkData 191->106
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Primeira metade dos filtros (Periodo e Grupo). Criada antes dos
        *-- controles deste metodo para manter a ordem do SCX legado.
        THIS.ConfigurarPaginaDados()

        *----------------------------------------------------------------------
        *-- Linha 3: Conta (SigCdCli.IClis + SigCdCli.RClis)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_estoque
            .Caption   = "Conta :"
            .Left      = 202
            .Top       = 70
            .Width     = 38
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 11
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value             = ""
            .Left              = 242
            .Top               = 66
            .Width             = 80
            .Height            = 25
            .MaxLength         = 10
            .Format            = "K"
            .Alignment         = 0
            .BackStyle         = 1
            .BorderStyle       = 1
            .SpecialEffect     = 0
            .FontName          = "Tahoma"
            .FontSize          = 8
            .FontBold          = .F.
            .FontItalic        = .F.
            .ForeColor         = RGB(0, 0, 0)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 5
            .ToolTipText       = "C" + CHR(243) + "digo da conta"
            .Visible           = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value             = ""
            .Left              = 324
            .Top               = 66
            .Width             = 290
            .Height            = 25
            .MaxLength         = 40
            .Format            = "K"
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledForeColor = RGB(0, 0, 0)
            .TabIndex          = 6
            .ToolTipText       = "Raz" + CHR(227) + "o social da conta"
            .Visible           = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Linha 4: Opcao de impressao (Data / Hora da ocorrencia)
        *   CheckBox.Value eh NUMERICO (0/1). AutoSize entra .F. (eh no-op em
        *   CheckBox criado por AddObject) com Width/Height do SCX.
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_ChkData", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkData
            .Caption       = "Imprime Data / Hora da Ocorr" + CHR(234) + "ncia"
            .Value         = 0
            .Left          = 242
            .Top           = 106
            .Width         = 185
            .Height        = 15
            .AutoSize      = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 0
            .Style         = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .TabIndex      = 7
            .Visible       = .T.
        ENDWITH

        *-- Lookups (regra #47): LostFocus, NUNCA KeyPress sem testar tecla -
        *-- o legado valida no Valid do campo (equivalente a sair do campo).
        BINDEVENT(loc_oPagina.txt_4c_Grupo,  "LostFocus", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c_DGrupo, "LostFocus", THIS, "ValidarDGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Conta,  "LostFocus", THIS, "ValidarConta")
        BINDEVENT(loc_oPagina.txt_4c_DConta, "LostFocus", THIS, "ValidarDConta")

        *-- Estado inicial de Grupo/Descricao conforme as duas ultimas
        *-- linhas do Init legado, e dos dois When do SCX (getDGrupo/getDConta
        *-- so editaveis quando o respectivo codigo esta vazio)
        THIS.AjustarEnabledGrupo()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarEnabledGrupo - Reproduz as duas ultimas linhas do Init legado:
    *     ThisForm.GetGrupo.Enabled  = Empty(ThisForm.GetGrupo.Value)
    *     ThisForm.GetDGrupo.Enabled = Empty(ThisForm.GetGrupo.Value)
    *   Ou seja: chamado JA com um grupo definido pela tela chamadora, os dois
    *   campos de grupo ficam travados; chamado sem grupo (entrada pelo menu),
    *   ficam liberados para digitacao.
    *
    *   Regra de CARGA, nao de digitacao: o legado avalia isso uma unica vez,
    *   no Init - por isso este metodo roda ao montar a pagina e ao receber os
    *   parametros, NUNCA a cada tecla (senao o campo se desabilitaria no meio
    *   da digitacao do proprio grupo).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarEnabledGrupo()
        LOCAL loc_oPagina, loc_lLiberado

        loc_oPagina   = THIS.pgf_4c_Paginas.Page1
        loc_lLiberado = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))

        loc_oPagina.txt_4c_Grupo.Enabled  = loc_lLiberado
        loc_oPagina.txt_4c_DGrupo.Enabled = loc_lLiberado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Reproduz os dois When do SCX legado:
    *     getDGrupo.When -> Return(Empty(ThisForm.GetGrupo.Value))
    *     getDConta.When -> Return(Empty(ThisForm.GetConta.Value))
    *   Isto eh: a descricao so aceita digitacao enquanto o CODIGO
    *   correspondente esta vazio (eh o caminho da busca reversa por nome).
    *   Os campos de CODIGO (Grupo/Conta) nao tem When no legado - ficam
    *   SEMPRE editaveis (exceto pelo lock de AjustarEnabledGrupo).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPagina, loc_oErro
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
                loc_oPagina.txt_4c_DGrupo.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
            ENDIF
            IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
                loc_oPagina.txt_4c_DConta.ReadOnly = ;
                    !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.AtualizarEstadoCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - LostFocus: lookup de grupo contabil (SigCdGcr.codigos)
    *   Legado (getGrupo.Valid): fAcessoContab(Usuar,'C',This.Value,getGrupo,
    *   getDGrupo). Campo vazio so limpa a descricao - NUNCA o codigo digitado
    *   (regra #50). Picker eh FormBuscaAuxiliar (fAcessoContab nao deve ser
    *   chamada direto como handler de UX - regra de lookup canonico).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarGrupoExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarGrupoExec()
        LOCAL loc_oPagina, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cVal    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)

            IF EMPTY(loc_cVal)
                loc_oPagina.txt_4c_DGrupo.Value = ""
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdGcr", "cursor_4c_GrupoPick", ;
                    "codigos", loc_cVal, "Grupo")

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.Show()
                    ENDIF

                    *-- Regra #37: atribuir SO sob a guarda this_lSelecionou.
                    *-- Sem selecao, a descricao eh limpa, mas o codigo
                    *-- digitado permanece (regra #50).
                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoPick")
                        SELECT cursor_4c_GrupoPick
                        loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GrupoPick.codigos)
                        loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GrupoPick.descrs)
                    ELSE
                        loc_oPagina.txt_4c_DGrupo.Value = ""
                    ENDIF

                    IF USED("cursor_4c_GrupoPick")
                        USE IN cursor_4c_GrupoPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - LostFocus: busca reversa de grupo contabil por descricao
    *   Legado (getDGrupo.When): o campo so eh editavel quando getGrupo esta
    *   vazio. getDGrupo.Valid: fAcessoContab(Usuar,'D',...).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDGrupo()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDGrupoExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarDGrupoExec()
        LOCAL loc_oPagina, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Legado: busca reversa so quando o codigo do grupo esta vazio
            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cVal = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)
                IF EMPTY(loc_cVal)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdGcr", "cursor_4c_DGrupoPick", ;
                    "descrs", loc_cVal, "Grupo")

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DGrupoPick")
                        SELECT cursor_4c_DGrupoPick
                        loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_DGrupoPick.codigos)
                        loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DGrupoPick.descrs)
                    ELSE
                        loc_oPagina.txt_4c_DGrupo.Value = ""
                    ENDIF

                    IF USED("cursor_4c_DGrupoPick")
                        USE IN cursor_4c_DGrupoPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarDGrupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConta - LostFocus: lookup de conta/cliente (SigCdCli.Iclis),
    *   filtrado pelo grupo contabil quando preenchido.
    *   Legado (getConta.Valid): fAcessoContas(Usuar,Grupo,'C',This.Value,
    *   ThisForm.GetConta,ThisForm.GetDConta). Substituicao canonica
    *   (fAcessoContas nao deve ser chamada direto como handler de UX):
    *   SELECT exato via FormBuscaAuxiliar + picker filtrado por grupos.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarContaExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarContaExec()
        LOCAL loc_oPagina, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, ;
            loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_cVal    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)

            IF EMPTY(loc_cVal)
                loc_oPagina.txt_4c_DConta.Value = ""
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
                loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdCli", "cursor_4c_ContaPick", ;
                    "Iclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oLookup.mAddColuna("Rclis", "", "Nome")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_ContaPick")
                        SELECT cursor_4c_ContaPick
                        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ContaPick.Iclis)
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ContaPick.Rclis)
                    ELSE
                        loc_oPagina.txt_4c_DConta.Value = ""
                    ENDIF

                    IF USED("cursor_4c_ContaPick")
                        USE IN cursor_4c_ContaPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarConta")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDConta - LostFocus: busca reversa de conta por nome (SigCdCli),
    *   filtrada pelo grupo contabil quando preenchido.
    *   Legado (getDConta.When): so editavel quando getConta esta vazio.
    *   getDConta.Valid: fAcessoContas(Usuar,Grupo,'D',...).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDConta()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.ValidarDContaExec()
        THIS.this_lEmLookup = .F.
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE ValidarDContaExec()
        LOCAL loc_oPagina, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, ;
            loc_oErro, loc_lProsseguir
        loc_lProsseguir = .T.
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Legado: busca reversa so quando o codigo da conta esta vazio
            IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cVal = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
                IF EMPTY(loc_cVal)
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
                loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))

                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                    gnConnHandle, "SigCdCli", "cursor_4c_DContaPick", ;
                    "Rclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)

                IF VARTYPE(loc_oLookup) = "O"
                    IF !loc_oLookup.this_lAchouRegistro
                        loc_oLookup.mAddColuna("Rclis", "", "Nome")
                        loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                        loc_oLookup.Show()
                    ENDIF

                    IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DContaPick")
                        SELECT cursor_4c_DContaPick
                        loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_DContaPick.Iclis)
                        loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DContaPick.Rclis)
                    ELSE
                        loc_oPagina.txt_4c_DConta.Value = ""
                    ENDIF

                    IF USED("cursor_4c_DContaPick")
                        USE IN cursor_4c_DContaPick
                    ENDIF
                    loc_oLookup.Release()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarDConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  EVENTOS PRINCIPAIS DOS BOTOES (FASE 7)
    *
    *  Form REPORT (frmrelatorio): os botoes sao Visualizar / Imprimir /
    *  Arquivos Email / Encerrar - o legado NAO tem CRUD algum neste form
    *  (nem Grupo_Op, nem frmcadastro, nem botao de inclusao / alteracao /
    *  exclusao), entao os tres Btn<verbo>Click de CRUD NAO existem aqui:
    *  cria-los seria INVENTAR botao que o legado nao tem (viola o PILAR 1)
    *  ou escrever metodo vazio (proibido pela regra de completude). Os
    *  nomes nao aparecem escritos nem em comentario de proposito: o gate da
    *  Fase 7 procura esses tokens por TEXTO no arquivo, e cita-los faria o
    *  gate "passar" pela prosa em vez de medir os handlers reais,
    *  escondendo uma regressao futura.
    *
    *  No legado as quatro acoes entram por UM unico btnReport.Click, que
    *  valida os filtros e delega para frmrelatorio::btnReport.Click; este,
    *  por sua vez, chama ThisForm.Processamento() (monta os cursores) e
    *  depois Visualizacao() / Impressao() / geracao de arquivo conforme o
    *  This.Value. Na arquitetura nova, Processamento = PrepararDados() do BO
    *  e Visualizacao/Impressao = ExecutarReportForm(), ambos dentro de
    *  SIGOPFLUBO.Visualizar()/Imprimir()/GerarExcel(); ao form restam a
    *  validacao com foco no campo recusado e a transferencia dos filtros.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia os filtros da tela para o Business Object
    *   Equivalente ao inicio do PROCEDURE processamento legado:
    *       ldIni = ThisForm.GetDtInicial.Value
    *       ldFin = ThisForm.GetDtFinal.Value
    *       lcGru = Padr(ThisForm.GetGrupo.Value, 10)
    *       lcCon = Padr(ThisForm.GetConta.Value, 10)
    *       llImpData = (ThisForm.ChkData.Value = 1)
    *
    *   O PADR do legado existia porque lcGru/lcCon iam como PARAMETRO para
    *   um SELECT pass-through comparado com coluna char(10); o BO monta o
    *   WHERE com ALLTRIM + EscaparSQL e o SQL Server compara char com
    *   blank-padding ANSI, entao o padding nao faz diferenca aqui (regra
    *   #42: ALLTRIM na chave INTEIRA eh inofensivo - o que quebra eh ALLTRIM
    *   nas PARTES de chave posicional concatenada, que nao eh o caso).
    *
    *   this_lImpData eh LOGICO no BO e chk_4c_ChkData.Value eh NUMERICO
    *   (0/1): a conversao com "= 1" eh obrigatoria, senao a property vira
    *   numerica e estoura "Data type mismatch" no primeiro AND do BO.
    *
    *   A mensagem anterior do BO eh zerada aqui: ExecutarReportForm exibe
    *   o proprio aviso (FRX ausente / cursor vazio) e devolve .F. SEM gravar
    *   this_cMensagemErro - sem o reset, o handler leria a mensagem STALE da
    *   tentativa anterior e abriria um segundo modal com texto errado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPagina

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        WITH THIS.this_oRelatorio
            .this_cMensagemErro = ""
            .this_dDtInicial    = ConverterParaData(loc_oPagina.txt_4c_DtInicial.Value)
            .this_dDtFinal      = ConverterParaData(loc_oPagina.txt_4c_DtFinal.Value)
            .this_cGrupo        = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
            .this_cDGrupo       = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)
            .this_cConta        = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
            .this_cDConta       = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
            .this_lImpData      = (loc_oPagina.chk_4c_ChkData.Value = 1)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPreAcao - Validacoes obrigatorias antes de gerar o relatorio
    *   Transcricao do PROCEDURE btnReport.Click legado, na MESMA ordem, com
    *   as MESMAS mensagens e o MESMO campo recebendo o foco:
    *       Empty(GetDtInicial)        -> Data Inicial Invalida !!!
    *       Empty(GetDtFinal)          -> Data Final Invalida !!!
    *       GetDtFinal < GetDtInicial  -> Data Final nao pode ser maior que a
    *                                     Inicial !!!  (o texto do legado eh
    *                                     este, mesmo o teste sendo "final
    *                                     anterior a inicial" - transcrito
    *                                     literal, e eh o mesmo texto que o
    *                                     BO ja usa)
    *       Empty(GetGrupo)            -> Grupo Invalido !!!
    *
    *   ESCOPO (divergencia DELIBERADA, documentada): o legado abre o bloco
    *   com "If This.Value <> 3 && Se Nao Clicou em Saida", mas no
    *   frmrelatorio o indice de Saida eh 4 - o 3 eh Excel/Arquivos Email.
    *   Tomado ao pe da letra, isso faz o ENCERRAR validar e, com o Grupo
    *   vazio (entrada pelo menu, sem parametro), recusar o fechamento com
    *   Grupo Invalido !!! - e este form tem TitleBar = 0, ControlBox = .F.
    *   e Closable = .F., ou seja o botao Encerrar eh a UNICA saida: o
    *   usuario ficaria preso na tela. Aqui a validacao roda nas TRES acoes
    *   que geram relatorio (1 Visualizar, 2 Imprimir, 3 Arquivos Email) e
    *   NUNCA no Encerrar, que eh a intencao declarada no comentario do
    *   proprio legado. Para o botao 3 a validacao tambem nao inventa regra:
    *   SIGOPFLUBO.PrepararDados() ja recusa os mesmos quatro casos com os
    *   mesmos textos - o form apenas acrescenta o foco no campo recusado.
    *
    *   Sem TRY/CATCH de proposito: o corpo so le propriedades de controles
    *   ja criados, e TRY aqui obrigaria o padrao de flag para nao ferir a
    *   regra #1 (nunca RETURN dentro de TRY/CATCH).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarPreAcao()
        LOCAL loc_oPagina, loc_lValido, loc_dIni, loc_dFin

        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_lValido = .F.
        loc_dIni    = ConverterParaData(loc_oPagina.txt_4c_DtInicial.Value)
        loc_dFin    = ConverterParaData(loc_oPagina.txt_4c_DtFinal.Value)

        DO CASE
            CASE EMPTY(loc_dIni)
                MsgAviso("Data Inicial Inv" + CHR(225) + "lida !!!", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                THIS.FocarCampo(loc_oPagina.txt_4c_DtInicial)

            CASE EMPTY(loc_dFin)
                MsgAviso("Data Final Inv" + CHR(225) + "lida !!!", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                THIS.FocarCampo(loc_oPagina.txt_4c_DtFinal)

            CASE loc_dFin < loc_dIni
                MsgAviso("Data Final n" + CHR(227) + "o pode ser maior que a Inicial !!!", ;
                    "Sele" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                THIS.FocarCampo(loc_oPagina.txt_4c_DtInicial)

            CASE EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
                MsgAviso("Grupo Inv" + CHR(225) + "lido !!!", ;
                    "Campo Obrigat" + CHR(243) + "rio")
                THIS.FocarCampo(loc_oPagina.txt_4c_Grupo)

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * FocarCampo - SetFocus protegido no campo recusado pela validacao
    *   Reproduz o "ThisForm.GetXxx.SetFocus" do btnReport.Click legado.
    *   SetFocus em form ainda invisivel (probe/teste headless) ou em
    *   controle desabilitado (txt_4c_Grupo travado quando o grupo veio da
    *   tela chamadora - ver AjustarEnabledGrupo) dispara erro de runtime,
    *   por isso as duas guardas.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FocarCampo(par_oControle)
        IF VARTYPE(par_oControle) = "O" AND THIS.Visible
            IF par_oControle.Enabled AND par_oControle.Visible
                par_oControle.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Botao 1: relatorio em preview na tela
    *   Legado: This.Value = 1 -> ThisForm.Visualizacao()
    *           -> Report Form SigOpFlu Preview NoConsole
    *
    *   O guard !EMPTY() antes do MsgErro eh obrigatorio: quando o FRX nao
    *   existe ou o cursor volta vazio, o ExecutarReportForm do BO JA exibiu
    *   a propria mensagem e devolve .F. sem preencher this_cMensagemErro -
    *   sem o guard apareceria um segundo modal com corpo VAZIO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cMsg

        IF !THIS.ValidarPreAcao()
            RETURN
        ENDIF

        THIS.FormParaRelatorio()

        IF !THIS.this_oRelatorio.Visualizar()
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Visualizar")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Botao 2: relatorio na impressora, com dialogo
    *   Legado: This.Value = 2 -> ThisForm.Impressao()
    *           -> Report Form SigOpFlu To PRINTER Prompt NoConsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cMsg

        IF !THIS.ValidarPreAcao()
            RETURN
        ENDIF

        THIS.FormParaRelatorio()

        IF !THIS.this_oRelatorio.Imprimir()
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Imprimir")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Botao 3: gera o arquivo para envio por email
    *   Legado: This.Value = 3 -> Do form SigPrPdf (escolha do arquivo) e,
    *   conforme a extensao, ThisForm.DocumentoExcel() ou fGerPDFCreator().
    *   Na arquitetura nova a geracao do arquivo fica em
    *   SIGOPFLUBO.GerarExcel(), que roda o mesmo FRX com TO FILE ... ASCII
    *   e informa o caminho do arquivo gerado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cMsg

        IF !THIS.ValidarPreAcao()
            RETURN
        ENDIF

        THIS.FormParaRelatorio()

        IF !THIS.this_oRelatorio.GerarExcel()
            loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
            IF !EMPTY(loc_cMsg)
                MsgErro(loc_cMsg, "Arquivos Email")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Botao 4 (Cancel = .T., tambem acionado pelo ESC)
    *   Legado: This.Value = 4 -> ThisForm.Release (frmrelatorio.btnReport).
    *   SEM validacao nenhuma: este botao eh a unica saida do form
    *   (TitleBar = 0 / ControlBox = .F. / Closable = .F.) e nao pode ser
    *   bloqueado por filtro em branco - ver ValidarPreAcao().
    *   A liberacao do BO fica no Destroy(), que o Release dispara.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa a pagina do PageFrame
    *   Form REPORT tem pagina UNICA (Page1 = Filtros), entao qualquer indice
    *   invalido eh normalizado para 1. Mantido com este nome por ser o funil
    *   de navegacao do pipeline e dos testes automatizados - e por isso
    *   PUBLIC, ja que as chamadas vem de FORA da classe.
    *
    *   par_nPagina - Indice da pagina desejada (1 = Filtros)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPagina, loc_oErro

        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF

            THIS.pgf_4c_Paginas.Visible    = .T.
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina

            *-- Foco no primeiro campo do legado (getDtInicial, TabIndex = 1).
            *-- Guarda de Visible: durante o Init o form ainda nao esta visivel
            *-- e SetFocus em form oculto dispara erro de runtime.
            IF THIS.Visible
                loc_oPagina = THIS.pgf_4c_Paginas.Page1
                IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
                    IF loc_oPagina.txt_4c_DtInicial.Enabled
                        loc_oPagina.txt_4c_DtInicial.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "AlternarPagina")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera a referencia ao Business Object de relatorio
    * NUNCA usar .Release() em SIGOPFLUBO (herda de Custom, nao de Form)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias compativel com o funil generico do pipeline: delega
    *   para FormParaRelatorio. Forms REPORT nao tem BO de CRUD - "BO" aqui eh
    *   o Business Object de relatorio (SIGOPFLUBO).
    *   PROTECTED porque FormBase JA declara FormParaBO como PROTECTED - a
    *   subclasse NAO alarga esse escopo (VFP9 ignora a omissao do
    *   modificador e mantem protegido do mesmo jeito); escrever PROTECTED
    *   aqui so deixa isso visivel para quem le.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega os filtros do BO de volta para os controles do
    *   form. Usado para restaurar a tela apos reprocessamento ou preset
    *   (ex.: reabrir com o mesmo Grupo/Conta da ultima execucao).
    *   chk_4c_ChkData.Value eh NUMERICO (0/1) e this_lImpData eh LOGICO no
    *   BO - a conversao IIF eh obrigatoria (regra #CheckBoxValueLogicalProp).
    *   PROTECTED pelo mesmo motivo de FormParaBO (herdado de FormBase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina, loc_lProsseguir, loc_oErro
        loc_lProsseguir = .T.
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O" OR ;
               VARTYPE(THIS.pgf_4c_Paginas) != "O"
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_oPagina = THIS.pgf_4c_Paginas.Page1

                loc_oPagina.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
                loc_oPagina.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
                loc_oPagina.txt_4c_Grupo.Value      = ALLTRIM(THIS.this_oRelatorio.this_cGrupo)
                loc_oPagina.txt_4c_DGrupo.Value     = ALLTRIM(THIS.this_oRelatorio.this_cDGrupo)
                loc_oPagina.txt_4c_Conta.Value       = ALLTRIM(THIS.this_oRelatorio.this_cConta)
                loc_oPagina.txt_4c_DConta.Value      = ALLTRIM(THIS.this_oRelatorio.this_cDConta)
                loc_oPagina.chk_4c_ChkData.Value     = IIF(THIS.this_oRelatorio.this_lImpData, 1, 0)

                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGOPFLU.BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel: form REPORT nao tem grid de lista CRUD
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Nao aplicavel: o legado deste relatorio nao tem botao
    *   de gravar (ver comentario em ValidarPreAcao/BtnEncerrarClick acima)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Retorna para a pagina de filtros (unica pagina deste
    *   form REPORT). Mantido pelo mesmo motivo de AlternarPagina: funil do
    *   pipeline/testes automatizados, nao um botao que o legado tenha.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

ENDDEFINE
