*==============================================================================
* FORMSIGREIPS.PRG
* Impress" + CHR(227) + "o de Etiquetas - Mala Direta (SigReIp3)
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREIPS.SCX (frmrelatorio)
*
* Layout FLAT (sem PageFrame CRUD). Filtro unico: selecao de item em SigMlItn
* pelo codigo (Codigos) ou descricao (Descs), que filtra SigMlCab para o
* relatorio SigReIp3 (etiquetas de mala direta).
*
* Controles:
*   lbl_4c_Selecao  - label "Selecao :"  (Say1, Top=139, Left=61)
*   txt_4c_Codigo   - codigo (Get_codigo, Top=136, Left=124, W=66)
*   txt_4c_Desc     - descricao (Get_desc,  Top=136, Left=192, W=220)
*
* Lookups: F4/DblClick em ambos os campos -> SigMlItn (Codigos, Descs)
* Validacao: txt_4c_Desc.ReadOnly = !EMPTY(txt_4c_Codigo) (Get_desc.When)
*==============================================================================

DEFINE CLASS FormSIGREIPS AS FormBase

    *-- Dimensoes exatas do original (Width=596, Height=205)
    Height      = 205
    Width       = 596
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
    * InicializarForm - Cria estrutura visual do form de relatorio
    *   1. Define Caption e Picture (fundo)
    *   2. Instancia SIGREIPSBO
    *   3. Monta cabecalho + botoes + campos de filtro
    *   4. Vincula BINDEVENTs e limpa campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Impress" + CHR(227) + "o de Etiquetas"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            THIS.this_oRelatorio = CREATEOBJECT("SIGREIPSBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREIPSBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarPageFrame()
                THIS.TornarControlesVisiveis(THIS)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                BINDEVENT(THIS.txt_4c_Codigo, "KeyPress", THIS, "TeclaCodigo")
                BINDEVENT(THIS.txt_4c_Codigo, "DblClick", THIS, "AbrirBuscaCodigo")
                BINDEVENT(THIS.txt_4c_Desc,   "KeyPress", THIS, "TeclaDesc")
                BINDEVENT(THIS.txt_4c_Desc,   "DblClick", THIS, "AbrirBuscaDesc")

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
    * ConfigurarPageFrame - Orquestra layout flat do relatorio
    *   Em frmrelatorio sem PageFrame CRUD, este metodo delega para
    *   ConfigurarPaginaLista (cabecalho + botoes) e ConfigurarCamposFiltro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarCamposFiltro()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta cabecalho escuro e CommandGroup de botoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza cobrindo todo o form (cntSombra)
    *   O container ocupa todo o form (Height=THIS.Height) fornecendo fundo
    *   cinza uniforme. Labels e TextBoxes de filtro sao adicionados depois
    *   (z-order superior) e ficam visiveis sobre este container.
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
                .Top       = 32
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 30
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
                .FontName  = "Tahoma"
                .FontSize  = 12
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup dos botoes do relatorio (btnReport)
    *   Original: Left=290, Width=310, Height=85, Top=-2
    *   Botoes: Visualiza(5), Imprime(80), DocExcel(155), Sair(230) - W=75 cada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 286
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

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 230
                .Width           = 75
                .Height          = 75
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
    * ConfigurarCamposFiltro - Adiciona label e TextBoxes de selecao
    *   Original: Say1 (Top=139,Left=61) + Get_codigo (136,124,W=66)
    *             + Get_desc (136,192,W=220)
    *   Adicionados ao form (nao ao container) para z-order sobre fundo cinza.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        THIS.AddObject("lbl_4c_Selecao", "Label")
        WITH THIS.lbl_4c_Selecao
            .Top       = 139
            .Left      = 61
            .Caption   = "Sele" + CHR(231) + CHR(227) + "o : "
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top         = 136
            .Left        = 124
            .Width       = 66
            .Height      = 23
            .MaxLength   = 8
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Desc", "TextBox")
        WITH THIS.txt_4c_Desc
            .Top         = 136
            .Left        = 192
            .Width       = 220
            .Height      = 23
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - NAO APLICAVEL: layout flat (frmrelatorio)
    *   Form SIGREIPS eh de relatorio (frmrelatorio), nao CRUD (frmcadastro).
    *   Nao ha PageFrame de duas paginas nem Page2 de edicao.
    *   Todos os controles de filtro (lbl_4c_Selecao, txt_4c_Codigo,
    *   txt_4c_Desc) sao adicionados em ConfigurarCamposFiltro(), chamado
    *   por ConfigurarPageFrame(). Este metodo existe por compatibilidade
    *   com FormBase e nao executa configuracoes adicionais.
    *   Campos desta fase (50% inicial = todos, pois sao apenas 3):
    *     [1] lbl_4c_Selecao  -> "Sele" + CHR(231) + CHR(227) + "o : "
    *     [2] txt_4c_Codigo   -> Get_codigo (Top=136, Left=124, W=66)
    *     [3] txt_4c_Desc     -> Get_desc   (Top=136, Left=192, W=220)
    *   Implementados integralmente em ConfigurarCamposFiltro() (fases 3-4).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO - BINDEVENT KeyPress
    * F4=115, ENTER=13, TAB=9
    *==========================================================================

    PROCEDURE TeclaCodigo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCodigo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodigo()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDesc(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDesc()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDesc()
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS - SigMlItn (Codigos / Descs)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCodigo - Lookup por codigo em SigMlItn
    *   Equivale ao Get_codigo.Valid com fwbuscaext (campo Codigos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCodigo()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Codigo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMlItn", "cursor_4c_BuscaCodigos", "Codigos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigos.Codigos)
                THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigos.Descs)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCodigos")
                        THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigos.Codigos)
                        THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigos.Descs)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaCodigos")
            USE IN cursor_4c_BuscaCodigos
        ENDIF
        THIS.AtualizarEstadoDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDesc - Lookup reverso por descricao em SigMlItn
    *   Equivale ao Get_desc.Valid com fwbuscaext (campo Descs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDesc()
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.txt_4c_Desc.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigMlItn", "cursor_4c_BuscaDescs", "Descs", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDescs.Descs)
                THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDescs.Codigos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDescs")
                        THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDescs.Descs)
                        THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDescs.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaDescs")
            USE IN cursor_4c_BuscaDescs
        ENDIF
        THIS.AtualizarEstadoDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Valida codigo digitado diretamente (ENTER/TAB)
    *   Se vazio: limpa desc. Se encontrado: preenche desc. Se invalido: abre busca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodigo()
        LOCAL loc_cValor, loc_cSQL, loc_nResult
        loc_cValor = ALLTRIM(THIS.txt_4c_Codigo.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Desc.Value = ""
            THIS.AtualizarEstadoDesc()
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Codigos, Descs FROM SigMlItn WHERE Codigos = " + ;
                EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodigosVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CodigosVal
                IF !EOF()
                    THIS.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_CodigosVal.Codigos)
                    THIS.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_CodigosVal.Descs)
                ELSE
                    USE IN cursor_4c_CodigosVal
                    THIS.AbrirBuscaCodigo()
                    RETURN
                ENDIF
            ELSE
                THIS.AbrirBuscaCodigo()
                RETURN
            ENDIF
            IF USED("cursor_4c_CodigosVal")
                USE IN cursor_4c_CodigosVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        THIS.AtualizarEstadoDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDesc - Valida descricao digitada diretamente (ENTER/TAB)
    *   Se vazia: limpa codigo. Se encontrada: preenche codigo. Se invalida: abre busca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDesc()
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.txt_4c_Desc.Value)
        IF EMPTY(loc_cValor)
            THIS.txt_4c_Codigo.Value = ""
            THIS.AtualizarEstadoDesc()
            RETURN
        ENDIF
        THIS.AbrirBuscaDesc()
        THIS.AtualizarEstadoDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoDesc - Controla ReadOnly de txt_4c_Desc
    *   Equivale ao Get_desc.When: Return Empty(ThisForm.Get_codigo.Value)
    *   Desc editavel apenas quando codigo esta vazio (busca por descricao).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoDesc()
        TRY
            IF PEMSTATUS(THIS, "txt_4c_Desc", 5)
                THIS.txt_4c_Desc.ReadOnly = !EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO
    *   Equivale ao 'processamento' do form legado (pCod -> poDataMgr.Requery)
    *   Pre-validacao: se desc preenchida mas codigo vazio (usuario clicou no botao
    *   sem pressionar ENTER/TAB), chama ValidarDesc() para obter o codigo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF PEMSTATUS(THIS, "txt_4c_Codigo", 5) AND PEMSTATUS(THIS, "txt_4c_Desc", 5)
            IF EMPTY(ALLTRIM(THIS.txt_4c_Codigo.Value)) AND !EMPTY(ALLTRIM(THIS.txt_4c_Desc.Value))
                THIS.ValidarDesc()
            ENDIF
        ENDIF
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            WITH THIS.this_oRelatorio
                .this_cCodigos = ALLTRIM(THIS.txt_4c_Codigo.Value)
                .this_cDescs   = ALLTRIM(THIS.txt_4c_Desc.Value)
            ENDWITH
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de filtro e atualiza estado de desc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        TRY
            IF PEMSTATUS(THIS, "txt_4c_Codigo", 5)
                THIS.txt_4c_Codigo.Value = ""
            ENDIF
            IF PEMSTATUS(THIS, "txt_4c_Desc", 5)
                THIS.txt_4c_Desc.Value    = ""
                THIS.txt_4c_Desc.ReadOnly = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do relatorio na tela (PROCEDURE visualizacao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        TRY
            THIS.FormParaRelatorio()
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.Visualizar()
                    IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio na impressora (PROCEDURE impressao)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        TRY
            THIS.FormParaRelatorio()
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF !THIS.this_oRelatorio.Imprimir()
                    IF !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                    MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta dados de SigMlCab para Excel (PROCEDURE documento)
    *   Original: Report Form SigReIp3 To Printer (sem NOCONSOLE = dialogo)
    *   Novo: exporta cursor de dados para XLS via PUTFILE
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArquivo, loc_cCursor
        TRY
            THIS.FormParaRelatorio()
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            IF !THIS.this_oRelatorio.PrepararDados() ;
               AND !EMPTY(THIS.this_oRelatorio.this_cMensagemErro)
                MsgErro(THIS.this_oRelatorio.this_cMensagemErro, "Erro")
                RETURN
            ENDIF
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum dado encontrado para exportar.", "Excel")
                RETURN
            ENDIF
            loc_cArquivo = PUTFILE("Salvar como...", "SigReIp3", "XLS")
            IF !EMPTY(loc_cArquivo)
                SELECT (loc_cCursor)
                COPY TO (loc_cArquivo) TYPE XLS
                MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + ;
                    loc_cArquivo, "Excel")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Fecha o formulario (PROCEDURE Release do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Devolve foco ao primeiro botao (sem PageFrame neste form)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
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
    * MAPEAMENTO CRUD -> REPORT
    * Metodos exigidos pelo FormBase que nao se aplicam a formularios de relatorio
    *==========================================================================

    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        RETURN
    ENDPROC

    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    PROCEDURE AjustarBotoesPorModo(par_cModo)
        RETURN
    ENDPROC

    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnSalvarClick()
        MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO de relatorio (NAO usar .Release() em objetos Custom)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
