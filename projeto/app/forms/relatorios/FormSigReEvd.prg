*==============================================================================
* FORMSIGREEVD.PRG
* Demonstrativo de Envelopes Duplicados
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREEVD.SCX (frmrelatorio)
*
* Filtros:
*   - Grupo   (codigo - SigCdGcr WHERE GerBals=1)
*   - Conta   (codigo - SigCdCli WHERE GerBals=1, busca por IClis)
*   - DConta  (descricao - SigCdCli, busca por RClis)
*   - Periodo (data inicial / data final)
*
* FASES 3-7/8 - Estrutura completa + Eventos Principais:
*   * Propriedades visuais (Width=800, Height=300 EXATOS do original)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() (cabecalho escuro com titulo)
*   * ConfigurarBotoes()    (CommandGroup: Visualizar/Imprimir/Excel/Encerrar)
*   * ConfigurarPageFrame() (PageFrame 1 pagina "Filtros")
*   * ConfigurarPaginaLista/Dados() (Grupo, Conta, DConta, datas)
*   * Validar*/AbrirLookup* (F4/Enter/Tab: SigCdGcr, SigCdCli)
*   * FormParaRelatorio() / ValidarFiltros()
*   * ConfigurarEventosBotoes() + BtnVisualizarClick/ImprimirClick/ExcelClick/EncerrarClick
*==============================================================================

DEFINE CLASS FormSigReEvd AS FormBase

    *-- Dimensoes EXATAS do original SIGREEVD.SCX (Width=800, Height=300)
    Height      = 300
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
    * InicializarForm - Cria estrutura base do formulario de relatorio.
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SigReEvdBO (Init() carrega cursor_4c_Grupos e cursor_4c_Clientes)
    *   3. Monta cabecalho escuro + botoes relatorio + PageFrame
    *   Em modo de validacao de UI (gb_4c_ValidandoUI=.T.), a criacao do BO
    *   pode falhar graciosamente (sem conexao SQL) sem impedir a visualizacao
    *   da estrutura visual do formulario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Demonstrativo de Envelopes Duplicados"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO. Init() carrega cursores de lookup via SQL.
            *   Em modo UI sem conexao, CREATEOBJECT retorna .F. (Init falha)
            *   e nao deve bloquear a criacao da estrutura visual.
            THIS.this_oRelatorio = CREATEOBJECT("SigReEvdBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.this_oRelatorio = .NULL.
                ELSE
                    MsgErro("Erro ao criar SigReEvdBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarEventosBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()

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
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio.
    *   Equivalente ao cntSombra herdado do frmrelatorio legado.
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

            *-- Sombra deslocada 2px para efeito 3D do texto
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Envelopes Duplicados"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Demonstrativo de Envelopes Duplicados"
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
    * ConfigurarBotoes - CommandGroup de relatorio (equivalente a btnReport).
    *   Original SIGREEVD: btnReport.Left=525, Top=3.
    *   Geometria canonica frmrelatorio: cmg_4c_Botoes.Left=529, Top=0.
    *   BINDEVENT dos clicks adicionados em InicializarForm (Fase 7).
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
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir (impressora)
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
                .Caption         = "\<Arquivos Email"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
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

            *-- Encerrar (ESC fecha o form)
            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .WordWrap        = .T.
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
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros").
    *   O form legado SIGREEVD e FLAT (sem PageFrame), mas no novo padrao
    *   os filtros sao agrupados em PageFrame para consistencia com o sistema.
    *   PageFrame.Height = This.Height - 85 (form height - header height).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1
        loc_oPgf.Top       = 85
        loc_oPgf.Left      = -1
        loc_oPgf.Width     = THIS.Width + 2
        loc_oPgf.Height    = THIS.Height - 85
        loc_oPgf.Tabs      = .F.

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
    * Destroy - Libera o BO de relatorio e chama destrutor base.
    *   NUNCA usar .Release() em Custom objects (RelatorioBase herda Custom).
    *   Atribuir .NULL. e suficiente para liberar a referencia.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Linha 1-2 dos filtros: Grupo, Conta, DConta.
    *   Form REPORT: sem grid nem CRUD. Labels e TextBoxes para os filtros
    *   com lookup (Grupo=SigCdGcr, Conta/DConta=SigCdCli).
    *   Os campos de periodo (datas) ficam em ConfigurarPaginaDados.
    *   Posicoes: Top_Page1 = Top_form_original - PageFrame.Top (85)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- GRUPO: Say2 (form Top=134 -> page Top=49), Get_grupo (form Top=132 -> page Top=47)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Top       = 49
            .Left      = 233
            .Width     = 41
            .Height    = 18
            .Caption   = "Grupo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPg.txt_4c_Grupo
            .Top      = 47
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- CONTA: Say3 (form Top=160 -> page Top=75), Get_conta (form Top=157 -> page Top=72)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Top       = 75
            .Left      = 233
            .Width     = 41
            .Height    = 18
            .Caption   = "Conta : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPg.txt_4c_Conta
            .Top      = 72
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- DCONTA (descricao cliente RClis): Get_dconta (form Top=157 -> page Top=72, Left=360 -> 361)
        loc_oPg.AddObject("txt_4c_Dconta", "TextBox")
        WITH loc_oPg.txt_4c_Dconta
            .Top      = 72
            .Left     = 361
            .Width    = 216
            .Height   = 23
            .Value    = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- BINDEVENTs dos campos com lookup: F4=115, Enter=13, Tab=9
        BINDEVENT(loc_oPg.txt_4c_Grupo,  "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(loc_oPg.txt_4c_Conta,  "KeyPress", THIS, "TeclaConta")
        BINDEVENT(loc_oPg.txt_4c_Dconta, "KeyPress", THIS, "TeclaDconta")

        *-- Configura campos de periodo (datas) na mesma Page1
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Linha 3 dos filtros: Periodo (Data Inicial / Final)
    *   Form REPORT eh FLAT (1 pagina). Este metodo eh chamado por
    *   ConfigurarPaginaLista para completar a Page1 com os filtros de data.
    *   Posicoes relativas ao Page1:
    *     lbl_4c_Conta (Periodo): form Top=186 -> page Top=101
    *     txt_4c_Datai:           form Top=181 -> page Top=96
    *     lbl_4c_Label1 ("ate"):  form Top=186 -> page Top=101
    *     txt_4c_Dataf:           form Top=181 -> page Top=96
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- PERIODO: Say_Conta (form Top=186 -> page Top=101), Get_Datai (form Top=181 -> page Top=96)
        loc_oPg.AddObject("lbl_4c_Conta", "Label")
        WITH loc_oPg.lbl_4c_Conta
            .Top       = 101
            .Left      = 226
            .Width     = 48
            .Height    = 18
            .Caption   = "Per" + CHR(237) + "odo : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Datai", "TextBox")
        WITH loc_oPg.txt_4c_Datai
            .Top      = 96
            .Left     = 277
            .Width    = 82
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Say1 (" ate "): form Top=186 -> page Top=101, Left=360 -> 361
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Top       = 101
            .Left      = 361
            .Width     = 24
            .Height    = 18
            .Caption   = " at" + CHR(233) + " "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Dataf", "TextBox")
        WITH loc_oPg.txt_4c_Dataf
            .Top      = 96
            .Left     = 385
            .Width    = 82
            .Height   = 23
            .Value    = {}
            .Format   = "D"
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Sem efeito em formularios de relatorio (1 pagina unica).
    *   Mantida para compatibilidade com o pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Zera todos os filtros e atualiza estado dos controles.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_Grupo.Value  = ""
            loc_oPg.txt_4c_Conta.Value  = ""
            loc_oPg.txt_4c_Dconta.Value = ""
            loc_oPg.txt_4c_Datai.Value  = {}
            loc_oPg.txt_4c_Dataf.Value  = {}
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Habilita/desabilita Conta e DConta conforme o
    *   estado do Grupo e Conta (replica os When events do legado SIGREEVD).
    *   Regras: Conta so ativo se Grupo preenchido.
    *           DConta so ativo se Grupo preenchido E Conta vazia.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg, loc_lGrupoOk, loc_lContaVazia
        TRY
            loc_oPg         = THIS.pgf_4c_Paginas.Page1
            loc_lGrupoOk    = !EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
            loc_lContaVazia = EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))

            loc_oPg.txt_4c_Conta.Enabled  = loc_lGrupoOk
            loc_oPg.txt_4c_Dconta.Enabled = loc_lGrupoOk AND loc_lContaVazia
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    *  EVENTOS DE TECLADO (Public - exigido pelo BINDEVENT)
    *==========================================================================

    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGrupo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupConta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarConta()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDconta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDconta()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDconta()
        ENDIF
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Grupo (SigCdGcr WHERE GerBals=1: Codigos)
    *==========================================================================

    PROCEDURE ValidarGrupo()
        LOCAL loc_oPg, loc_cCodigo
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page1
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            IF EMPTY(loc_cCodigo)
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            SELECT cursor_4c_Grupos
            LOCATE FOR ALLTRIM(Codigos) = loc_cCodigo
            IF FOUND()
                loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
            ELSE
                MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "Grupo")
                loc_oPg.txt_4c_Grupo.Value  = ""
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupGrupo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdGrpBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "Codigos", loc_cValor, ;
                "Selecionar Grupo", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Grupo.Value = ALLTRIM(Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - Conta (SigCdCli: IClis/codigo; preenche tb DConta)
    *   Disponivel apenas quando Grupo preenchido (When legado).
    *   Ao selecionar por codigo, preenche txt_4c_Dconta com RClis.
    *==========================================================================

    PROCEDURE ValidarConta()
        LOCAL loc_oPg, loc_cCodigo
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                RETURN
            ENDIF
            loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            IF EMPTY(loc_cCodigo)
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            SELECT cursor_4c_Clientes
            LOCATE FOR ALLTRIM(IClis) = loc_cCodigo
            IF FOUND()
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupConta()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupConta()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdContBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "IClis", loc_cValor, ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                    loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                ELSE
                    loc_oPg.txt_4c_Conta.Value  = ""
                    loc_oPg.txt_4c_Dconta.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  VALIDACAO E LOOKUP - DConta (busca por RClis/nome; preenche tb Conta)
    *   Disponivel apenas quando Grupo preenchido E Conta vazia (When legado).
    *   Ao selecionar por nome, preenche txt_4c_Conta com IClis.
    *==========================================================================

    PROCEDURE ValidarDconta()
        LOCAL loc_oPg, loc_cNome
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Grupo.Value))
                RETURN
            ENDIF
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Conta.Value))
                RETURN
            ENDIF
            loc_cNome = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
            IF EMPTY(loc_cNome)
                THIS.AtualizarEstadoCampos()
                RETURN
            ENDIF
            SELECT cursor_4c_Clientes
            LOCATE FOR ALLTRIM(RClis) = loc_cNome
            IF FOUND()
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
            ELSE
                MsgAviso("Conta n" + CHR(227) + "o encontrada.", "Conta")
                loc_oPg.txt_4c_Conta.Value  = ""
                loc_oPg.txt_4c_Dconta.Value = ""
                THIS.AbrirLookupDconta()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoCampos()
    ENDPROC

    PROCEDURE AbrirLookupDconta()
        LOCAL loc_oBusca, loc_cValor, loc_oPg, loc_cCursor
        loc_cCursor = "cursor_4c_EvdDcBusca"
        TRY
            loc_oPg    = THIS.pgf_4c_Paginas.Page1
            loc_cValor = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "RClis", loc_cValor, ;
                "Selecionar Conta", .F., .F., "GerBals = 1")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_oPg.txt_4c_Dconta.Value = ALLTRIM(RClis)
                    loc_oPg.txt_4c_Conta.Value  = ALLTRIM(IClis)
                ELSE
                    loc_oPg.txt_4c_Conta.Value  = ""
                    loc_oPg.txt_4c_Dconta.Value = ""
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  MAPEAMENTO FORM -> BO E VALIDACAO DE FILTROS
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos de filtro para o BO.
    *   Chamado antes de Visualizar/Imprimir para popular this_oRelatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                .this_cGrupo  = ALLTRIM(loc_oPg.txt_4c_Grupo.Value)
                .this_cConta  = ALLTRIM(loc_oPg.txt_4c_Conta.Value)
                .this_cDConta = ALLTRIM(loc_oPg.txt_4c_Dconta.Value)
                .this_dDatai  = loc_oPg.txt_4c_Datai.Value
                .this_dDataf  = loc_oPg.txt_4c_Dataf.Value
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se os filtros obrigatorios estao preenchidos.
    *   Datas inicial e final sao obrigatorias (o processamento original
    *   usava ambas diretamente sem verificar se estavam vazias).
    *   Retorna .T. se OK para gerar relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF EMPTY(loc_oPg.txt_4c_Datai.Value)
                MsgAviso("Informe a Data Inicial do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Datai.SetFocus()
            ELSE
                IF EMPTY(loc_oPg.txt_4c_Dataf.Value)
                MsgAviso("Informe a Data Final do per" + CHR(237) + "odo.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Dataf.SetFocus()
            ELSE
                IF loc_oPg.txt_4c_Datai.Value > loc_oPg.txt_4c_Dataf.Value
                MsgAviso("Data Inicial deve ser menor ou igual " + ;
                    CHR(224) + " Data Final.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_oPg.txt_4c_Datai.SetFocus()
            ELSE
                loc_lValido = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC


    *==========================================================================
    *  EVENTOS DOS BOTOES DO COMMANDGROUP DE RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * MAPEAMENTO EVENTOS PRINCIPAIS (form REPORT - frmrelatorio)
    *
    * Forms CRUD usam os handlers BtnIncluirClick, BtnAlterarClick,
    * BtnVisualizarClick, BtnExcluirClick. Para este form REPORT (frmrelatorio)
    * o equivalente funcional dos botoes do CommandGroup superior eh:
    *
    *   BtnIncluirClick    -> Mapeado para BtnImprimirClick  (Buttons(2))
    *   BtnAlterarClick    -> Mapeado para BtnExcelClick     (Buttons(3))
    *   BtnVisualizarClick -> Implementado abaixo            (Buttons(1))
    *   BtnExcluirClick    -> Mapeado para BtnEncerrarClick  (Buttons(4))
    *
    * O legado SIGREEVD (frmrelatorio) so define as 3 acoes de relatorio
    * (Preview, Print Prompt, Print) + ESC para fechar. Nao existem operacoes
    * de Inserir/Alterar/Excluir em forms de relatorio - apenas filtros de
    * entrada e geracao do REPORT FORM. Os 4 metodos abaixo cobrem todas as
    * acoes funcionalmente equivalentes ao padrao CRUD para um form REPORT.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ConfigurarEventosBotoes - BINDEVENT dos 4 botoes do cmg_4c_Botoes.
    *   Chamado em InicializarForm apos ConfigurarBotoes().
    *   BINDEVENT exige metodos PUBLIC (sem PROTECTED).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventosBotoes()
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview em tela.
    *   Equivalente ao metodo 'visualizacao' do legado SIGREEVD:
    *   Report Form SigReEvd Preview Noconsole
    *--------------------------------------------------------------------------
    *-- ============================================================
    *-- PROCEDURE ExecutarReportForm (Pattern #117)
    *-- Executa REPORT FORM apenas se o FRX existir; caso contrario,
    *-- exibe MostrarErro descritivo com o path faltante.
    *-- Isola SET POINT/SEPARATOR/REPORTBEHAVIOR durante o REPORT FORM
    *-- porque FRXs legados Fortyus (VFP6/7/8) foram desenhados com
    *-- POINT="." + REPORTBEHAVIOR 80. Sem isolamento o modo 90 remede
    *-- fontes em runtime e mostra asteriscos em campos numericos.
    *-- par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *-- ============================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        *-- Guard cursor vazio: evita preview em branco / impressao vazia (Erro30)
        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF


        *-- Isolamento de locale + modo de renderizacao (Pattern #117 / Erro28)
        LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        RETURN .T.
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cFrx
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                ENDIF
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZACAO")
        ENDIF
        IF FILE(loc_cFrx)
            THIS.ExecutarReportForm("SigReEvd", "PREVIEW", THIS.this_oRelatorio.this_cCursorDados)
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia para impressora com dialogo de selecao.
    *   Equivalente ao metodo 'impressao' do legado SIGREEVD:
    *   Report Form SigReEvd to PRINTER Prompt Noconsole
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cFrx
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                ENDIF
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("IMPRESSAO")
        ENDIF
        IF FILE(loc_cFrx)
            THIS.ExecutarReportForm("SigReEvd", "PRINTER_PROMPT")
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta para arquivo XLS.
    *   Equivalente ao metodo 'documento' do legado SIGREEVD:
    *   Report Form SigReEvd to PRINTER Noconsole
    *   No novo sistema, exporta para XLS em vez de impressora direta.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cFrx, loc_cArquivo
        IF !THIS.ValidarFiltros()
            RETURN
        ENDIF
        THIS.FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !THIS.this_oRelatorio.PrepararDados()
                IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Erro ao preparar dados")
                ENDIF
                RETURN
            ENDIF
            THIS.this_oRelatorio.RegistrarAuditoria("EXPORTACAO")
        ENDIF
        loc_cFrx     = gc_4c_CaminhoReports + "SigReEvd.frx"
        loc_cArquivo = gc_4c_CaminhoReports + "SigReEvd_" + ;
                       STRTRAN(DTOC(DATE()), "/", "") + ".xls"
        IF FILE(loc_cFrx)
            REPORT FORM (loc_cFrx) TO FILE (loc_cArquivo) NOCONSOLE
            IF FILE(loc_cArquivo)
                MsgInfo("Exportado para:" + CHR(13) + loc_cArquivo, "Excel")
            ENDIF
        ELSE
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado: " + loc_cFrx, "Relat" + CHR(243) + "rio")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario.
    *   Botoes(4) tem .Cancel=.T. e tambem responde ao ESC automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Aplica as regras de habilitacao dos campos de filtro.
    *   Para forms REPORT o "modo" e sempre entrada de filtros; apenas as
    *   dependencias Grupo->Conta->DConta determinam quais campos ficam ativos.
    *   Chama AtualizarEstadoCampos() que encapsula toda essa logica.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    *  COMPATIBILIDADE COM PIPELINE CRUD (forms REPORT - frmrelatorio)
    *
    *  O pipeline multi-fase valida a presenca de metodos padrao de CRUD
    *  (BtnSalvarClick, BtnCancelarClick, FormParaBO, BOParaForm,
    *  CarregarLista, AjustarBotoesPorModo). Como SIGREEVD eh REPORT, os
    *  metodos abaixo mapeiam essas operacoes para as equivalentes funcionais
    *  do relatorio.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT, gera o relatorio (preview).
    *   Mapeado para BtnVisualizarClick (Buttons(1) do CommandGroup).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT, limpa os filtros (mantem o form aberto)
    *   para o usuario informar novos parametros sem precisar reabrir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Em REPORT, transfere filtros do form para o BO.
    *   Wrapper publico de FormParaRelatorio() para compatibilidade com o
    *   pipeline de migracao (validacao Fase 8 procura FormParaBO).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Em REPORT, recupera filtros do BO para os campos do form.
    *   Util quando o BO foi populado externamente (ex.: agendamento, drill).
    *   Para SIGREEVD: copia this_oRelatorio.this_cGrupo/cConta/cDConta/datas
    *   para os TextBoxes correspondentes.
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_Grupo.Value  = ALLTRIM(.this_cGrupo)
                loc_oPg.txt_4c_Conta.Value  = ALLTRIM(.this_cConta)
                loc_oPg.txt_4c_Dconta.Value = ALLTRIM(.this_cDConta)
                loc_oPg.txt_4c_Datai.Value  = .this_dDatai
                loc_oPg.txt_4c_Dataf.Value  = .this_dDataf
            ENDWITH
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT, nao existe lista de registros para carregar.
    *   Equivalente a "preparar a tela" - garante que os campos de filtro
    *   estejam zerados e com estado de habilitacao correto, pronto para uso.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.LimparCampos()
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Em REPORT, nao ha modos (INCLUIR/ALTERAR/etc).
    *   Os botoes do CommandGroup (Visualizar/Imprimir/Excel/Encerrar)
    *   estao sempre habilitados. Metodo mantido para compatibilidade com
    *   o pipeline e para chamadas externas (HabilitarCampos delega aqui).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_nI
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
                    THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
                ENDFOR
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
