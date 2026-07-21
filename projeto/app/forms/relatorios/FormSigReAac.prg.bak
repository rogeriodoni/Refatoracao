*==============================================================================
* FORMSIGREAAC.PRG
* Relatorio do Log de Acessos - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAAC.SCX (frmrelatorio)
*
* Filtros (mutuamente exclusivos):
*   - Usuario : Codigo (SigCdUsu.Usuarios) + Nome (SigCdUsu.NComps)
*   - Grupo   : Codigo (SigCdGrA.Grupos)  + Nome (SigCdGrA.NComps)
*
* Regra de exclusao mutua (replicada dos eventos When do legado):
*   - txt_4c_CUsuario: editavel apenas quando CGrupo esta vazio
*   - txt_4c_DUsuario: editavel apenas quando CUsuario E CGrupo estao vazios
*   - txt_4c_CGrupo  : editavel apenas quando CUsuario esta vazio
*   - txt_4c_DGrupo  : editavel apenas quando CUsuario E CGrupo estao vazios
*==============================================================================

DEFINE CLASS FormSigReAac AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=149)
    Height      = 149
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
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio do Log de Acessos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReAacBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReAacBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Vincular eventos Click dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
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
                .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
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
                .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
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
    *   Geometria EXATA do framework frmrelatorio:
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Botoes: Visualizar/Imprimir/Excel/Encerrar (Left=5/71/137/203)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 494
            .Width         = 310
            .Height        = 85
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
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

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
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
                .Left            = 155
                .Width           = 75
                .Height          = 75
                .Caption         = "Arquivos Email"
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

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .WordWrap        = .T.
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
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado abaixo do cabecalho (Top=85) ate o fim do form (Height=64px)
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

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles do bloco USUARIO na Page1
    *
    * Forms REPORT (frmrelatorio) tem layout FLAT: PageFrame com apenas Page1
    * (Filtros). Os filtros sao agrupados em dois blocos:
    *   - Bloco USUARIO : Codigo + Nome do usuario  (este metodo)
    *   - Bloco GRUPO   : Codigo + Nome do grupo    (ConfigurarPaginaDados)
    *
    * Posicoes ajustadas relativas ao PageFrame.Top=85:
    *   Linha Usuario : Top_original=86 -> Page1.Top=1
    *   Label Usuario : Top_original=90 -> Page1.Top=5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Usuario :"
        loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
        WITH loc_oPg.lbl_4c_LblUsuario
            .Top       = 5
            .Left      = 57
            .Width     = 45
            .Height    = 15
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Usuario (SigCdUsu.Usuarios, MaxLength=10)
        loc_oPg.AddObject("txt_4c_CUsuario", "TextBox")
        WITH loc_oPg.txt_4c_CUsuario
            .Top         = 1
            .Left        = 105
            .Width       = 80
            .Height      = 25
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Nome do Usuario (SigCdUsu.NComps, MaxLength=30)
        loc_oPg.AddObject("txt_4c_DUsuario", "TextBox")
        WITH loc_oPg.txt_4c_DUsuario
            .Top         = 1
            .Left        = 187
            .Width       = 301
            .Height      = 25
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- KeyPress: F4=lookup direto, ENTER/TAB=validar codigo/nome digitado
        BINDEVENT(loc_oPg.txt_4c_CUsuario, "KeyPress", THIS, "TeclaCUsuario")
        BINDEVENT(loc_oPg.txt_4c_DUsuario, "KeyPress", THIS, "TeclaDUsuario")

        *-- DblClick: abre lookup diretamente (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CUsuario, "DblClick", THIS, "AbrirBuscaCUsuario")
        BINDEVENT(loc_oPg.txt_4c_DUsuario, "DblClick", THIS, "AbrirBuscaDUsuario")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona controles do bloco GRUPO na Page1
    *
    * Em forms REPORT FLAT a unica Page (Page1) hospeda TODOS os filtros, mas
    * separamos a montagem em dois metodos para manter o contrato esperado
    * pelo pipeline de migracao (ConfigurarPaginaLista + ConfigurarPaginaDados).
    *
    * Posicoes ajustadas relativas ao PageFrame.Top=85:
    *   Linha Grupo : Top_original=113 -> Page1.Top=28
    *   Label Grupo : Top_original=117 -> Page1.Top=32
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Grupo :"
        loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblGrupo
            .Top       = 32
            .Left      = 64
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (SigCdGrA.Grupos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_CGrupo", "TextBox")
        WITH loc_oPg.txt_4c_CGrupo
            .Top         = 28
            .Left        = 105
            .Width       = 80
            .Height      = 25
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Nome do Grupo (SigCdGrA.NComps, MaxLength=30)
        loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DGrupo
            .Top         = 28
            .Left        = 187
            .Width       = 301
            .Height      = 25
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- KeyPress: F4=lookup direto, ENTER/TAB=validar codigo/nome digitado
        BINDEVENT(loc_oPg.txt_4c_CGrupo, "KeyPress", THIS, "TeclaCGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo, "KeyPress", THIS, "TeclaDGrupo")

        *-- DblClick: abre lookup diretamente (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CGrupo, "DblClick", THIS, "AbrirBuscaCGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo, "DblClick", THIS, "AbrirBuscaDGrupo")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura todos os filtros para valores padrao (vazios)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CUsuario.Value = ""
            loc_oPg.txt_4c_DUsuario.Value = ""
            loc_oPg.txt_4c_CGrupo.Value   = ""
            loc_oPg.txt_4c_DGrupo.Value   = ""
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCUsuario = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
            .this_cDUsuario = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
            .this_cCGrupo   = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
            .this_cDGrupo   = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Aplica regra de exclusao mutua (legado: When events)
    *
    *   GetCUsuario.When = Empty(GetCGrupo.Value)
    *   GetDUsuario.When = Empty(GetCUsuario.Value) And Empty(GetCGrupo.Value)
    *   GetCGrupo.When   = Empty(GetCUsuario.Value)
    *   GetDGrupo.When   = Empty(GetCUsuario.Value) And Empty(GetCGrupo.Value)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg, loc_lGrupoVazio, loc_lUsuarioVazio, loc_lAmbosVazios
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                loc_lGrupoVazio   = EMPTY(ALLTRIM(loc_oPg.txt_4c_CGrupo.Value))
                loc_lUsuarioVazio = EMPTY(ALLTRIM(loc_oPg.txt_4c_CUsuario.Value))
                loc_lAmbosVazios  = loc_lGrupoVazio AND loc_lUsuarioVazio

                loc_oPg.txt_4c_CUsuario.ReadOnly = !loc_lGrupoVazio
                loc_oPg.txt_4c_DUsuario.ReadOnly = !loc_lAmbosVazios
                loc_oPg.txt_4c_CGrupo.ReadOnly   = !loc_lUsuarioVazio
                loc_oPg.txt_4c_DGrupo.ReadOnly   = !loc_lAmbosVazios
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina no PageFrame
    *
    *   Forms REPORT (frmrelatorio) possuem APENAS 1 pagina (Filtros), ao
    *   contrario dos forms CRUD que alternam entre Page1 (Lista) e Page2
    *   (Dados). Este metodo garante que a unica pagina existente permaneca
    *   ativa e devolve o foco para o primeiro campo de filtro, mantendo
    *   compatibilidade com o contrato esperado pelo pipeline de migracao.
    *
    *   par_nPagina  - Indice da pagina (1 = Filtros). Valores invalidos
    *                  sao normalizados para 1, pois o form so tem 1 Page.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPg
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                IF !loc_oPg.txt_4c_CUsuario.ReadOnly
                    loc_oPg.txt_4c_CUsuario.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * F4=115, ENTER=13, TAB=9, ESC=27
    *==========================================================================

    PROCEDURE TeclaCUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCUsuario()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CUsuario.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDUsuario()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CUsuario.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCGrupo()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGrupo.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDGrupo()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGrupo.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO (ENTER/TAB em campo de codigo ou nome)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCUsuario - Busca usuario pelo codigo digitado (SigCdUsu.Usuarios)
    *   Replica GetCUsuario.Valid do original: lookup exato por campo Usuarios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCUsuario()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE Usuarios = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuVal
            IF !EOF()
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaCUsuario()
            ENDIF
            USE IN cursor_4c_UsuVal
        ELSE
            THIS.AbrirBuscaCUsuario()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDUsuario - Busca usuario pelo nome digitado (SigCdUsu.NComps)
    *   Replica GetDUsuario.Valid do original: lookup por NComps (LIKE prefixo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDUsuario()
        LOCAL loc_oPg, loc_cNome, loc_cSQL, loc_nResult
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cNome = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
        IF EMPTY(loc_cNome)
            loc_oPg.txt_4c_CUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE NComps LIKE " + ;
                   EscaparSQL(loc_cNome + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuNomVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuNomVal
            IF !EOF()
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaDUsuario()
            ENDIF
            USE IN cursor_4c_UsuNomVal
        ELSE
            THIS.AbrirBuscaDUsuario()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCGrupo - Busca grupo pelo codigo digitado (SigCdGrA.Grupos)
    *   Replica GetCGrupo.Valid do original: lookup exato por campo Grupos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCGrupo()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE Grupos = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrAVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrAVal
            IF !EOF()
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaCGrupo()
            ENDIF
            USE IN cursor_4c_GrAVal
        ELSE
            THIS.AbrirBuscaCGrupo()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - Busca grupo pelo nome digitado (SigCdGrA.NComps)
    *   Replica GetDGrupo.Valid do original: lookup por NComps (LIKE prefixo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDGrupo()
        LOCAL loc_oPg, loc_cNome, loc_cSQL, loc_nResult
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cNome = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        IF EMPTY(loc_cNome)
            loc_oPg.txt_4c_CGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE NComps LIKE " + ;
                   EscaparSQL(loc_cNome + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrANomVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrANomVal
            IF !EOF()
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaDGrupo()
            ENDIF
            USE IN cursor_4c_GrANomVal
        ELSE
            THIS.AbrirBuscaDGrupo()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCUsuario - Lookup de usuario pelo codigo (SigCdUsu.Usuarios)
    *   Replica GetCUsuario.Valid do original: fwBuscaExt por campo Usuarios
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_CUsuario.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rio", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                        loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                    ELSE
                        loc_oPg.txt_4c_CUsuario.Value = ""
                        loc_oPg.txt_4c_DUsuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDUsuario - Lookup de usuario pelo nome (SigCdUsu.NComps)
    *   Replica GetDUsuario.Valid do original: fwBuscaExt por campo NComps
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_DUsuario.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rio", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                        loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ELSE
                        loc_oPg.txt_4c_CUsuario.Value = ""
                        loc_oPg.txt_4c_DUsuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCGrupo - Lookup de grupo pelo codigo (SigCdGrA.Grupos)
    *   Replica GetCGrupo.Valid do original: fwBuscaExt por campo Grupos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_CGrupo.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrA", "cursor_4c_BuscaGrA", "Grupos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Acesso", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Grupos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrA")
                        loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                    ELSE
                        loc_oPg.txt_4c_CGrupo.Value = ""
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrA")
            USE IN cursor_4c_BuscaGrA
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGrupo - Lookup de grupo pelo nome (SigCdGrA.NComps)
    *   Replica GetDGrupo.Valid do original: fwBuscaExt por campo NComps
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_DGrupo.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrA", "cursor_4c_BuscaGrA", "NComps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Acesso", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.mAddColuna("Grupos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrA")
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                        loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                    ELSE
                        loc_oPg.txt_4c_CGrupo.Value = ""
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrA")
            USE IN cursor_4c_BuscaGrA
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se pelo menos um filtro esta preenchido
    *   Replica a validacao explicita do form original antes de processar:
    *   "If Empty(GetCGrupo.Value) And Empty(GetCUsuario.Value)"
    *   Retorna .T. se ao menos um filtro (usuario OU grupo) esta preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)) OR ;
               !EMPTY(ALLTRIM(loc_oPg.txt_4c_CGrupo.Value))
                loc_lValido = .T.
            ELSE
                MsgInfo("Sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                         "o Realizada !!!", ;
                         "Filtro Obrigat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                    ENDIF
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                    ENDIF
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.ExportarExcel()
                    IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                    ENDIF
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
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

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Aliases para compatibilidade com pipeline que espera metodos CRUD.
    * Forms REPORT (frmrelatorio) nao tem operacoes CRUD - apenas geram saidas
    * a partir de filtros. Os metodos abaixo replicam o contrato BtnXxxClick
    * delegando para o equivalente semantico em relatorios.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Gerar relatorio" em form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: equivale a gerar o relatorio (visualizar preview) com os
    *   filtros atuais. Delega para BtnVisualizarClick que ja faz validacao
    *   de filtros, FormParaRelatorio, PrepararDados e REPORT FORM PREVIEW.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui o registro selecionado apos confirmacao.
    *   Em REPORT: nao ha registros para excluir (apenas filtros e cursores
    *   temporarios). Informa o usuario que a operacao nao se aplica neste
    *   contexto e sugere o uso de Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * METODOS COMPLEMENTARES - FASE 8
    * Contratos exigidos pelo pipeline de migracao para forms de qualquer tipo
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - "Buscar/Consultar" em form de relatorio
    *   Em CRUD: abre form de consulta para um registro existente.
    *   Em REPORT: semanticamente equivale a visualizar o relatorio com os
    *   filtros atuais (preview na tela), permitindo "buscar" os dados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *   Alias para BtnSairClick. Mapeia o contrato de encerramento do
    *   pipeline para o metodo especifico deste form de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar/Confirmar" em form de relatorio
    *   Em CRUD: persiste alteracoes do registro no banco de dados.
    *   Em REPORT: semanticamente equivale a imprimir/gerar o relatorio
    *   (acao principal de "confirmar" a selecao de filtros e produzir saida).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Cancelar" em form de relatorio
    *   Em CRUD: descarta alteracoes e retorna para a lista.
    *   Em REPORT: limpa todos os filtros preenchidos, permitindo ao usuario
    *   recomecar a selecao sem fechar o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                IF !loc_oPg.txt_4c_CUsuario.ReadOnly
                    loc_oPg.txt_4c_CUsuario.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias para FormParaRelatorio
    *   Garante compatibilidade com o contrato CRUD do pipeline de migracao.
    *   Forms REPORT nao tem BO de cadastro; FormParaRelatorio copia os
    *   valores dos controles de filtro para as propriedades do BO de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega valores do BO de relatorio de volta para os controles
    *   Em CRUD: preenche os controles com os dados do registro carregado.
    *   Em REPORT: o BO de relatorio nao tem "registro" para exibir; apenas
    *   repoe os filtros armazenados nas propriedades do BO nos controles,
    *   util para restaurar o estado de filtros apos PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_CUsuario.Value = NVL(.this_cCUsuario, "")
                loc_oPg.txt_4c_DUsuario.Value = NVL(.this_cDUsuario, "")
                loc_oPg.txt_4c_CGrupo.Value   = NVL(.this_cCGrupo, "")
                loc_oPg.txt_4c_DGrupo.Value   = NVL(.this_cDGrupo, "")
            ENDWITH
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de filtro
    *   Em CRUD: habilita/desabilita campos conforme modo INCLUIR/ALTERAR/VISUALIZAR.
    *   Em REPORT: a habilitacao e controlada pela regra de exclusao mutua
    *   (AtualizarEstadoCampos). Este metodo aplica o estado base e depois
    *   chama AtualizarEstadoCampos para refinar conforme as regras do legado.
    *   par_lHabilitar = .T. -> habilita todos (ReadOnly=.F.)
    *   par_lHabilitar = .F. -> desabilita todos (ReadOnly=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                    loc_oPg.txt_4c_CUsuario.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DUsuario", 5)
                    loc_oPg.txt_4c_DUsuario.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CGrupo", 5)
                    loc_oPg.txt_4c_CGrupo.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGrupo", 5)
                    loc_oPg.txt_4c_DGrupo.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
            IF loc_lHab
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega a lista de registros (contrato CRUD)
    *   Em CRUD: executa query e popula o grid da Page1 com os registros.
    *   Em REPORT: forms de relatorio nao tem lista de registros nem grid.
    *   Retorna .T. para indicar sucesso ao pipeline (nao ha dados para carregar).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *   Em CRUD: habilita/desabilita botoes CRUD de acordo com o modo
    *   (LISTA, INCLUIR, ALTERAR, VISUALIZAR).
    *   Em REPORT: nao ha modos CRUD; os 4 botoes do CommandGroup permanecem
    *   sempre habilitados (Visualizar/Imprimir/Excel/Encerrar). Nao ha
    *   estado de modo a gerenciar neste tipo de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
