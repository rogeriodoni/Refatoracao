*==============================================================================
* FORMSIGREC SP.PRG
* Pesquisa de Opera" + CHR(231) + CHR(245) + "es (SIGRECSP)
* Tipo: PESQUISA/RELATORIO (herda FormBase, BO herda RelatorioBase)
* Migrado de: SigReCsp.SCX (frmrelatorio)
*
* Descricao: Formulario FLAT (sem PageFrame) que exibe grid de resultados
*   em resposta a filtros de busca. Ao selecionar uma linha no grid, o botao
*   Movimento abre o form de detalhe SigMvExp.
*
* Filtros (direto no form - adicionados em Fase 5-6):
*   - Empresa (codigo + razao social - SigCdEmp)
*   - Periodo (data inicial / data final)
*   - Movimentacao (operacao + numero + documento)
*   - Conta/Grupo contabil (OptConta: Origem / Destino)
*   - Observacao (busca por LIKE)
*
* Grid de resultados (adicionado em Fase 4):
*   - SigMvCab: dopes, numes, notas, datas, usulibs, Obses
*
* FASE 3/8 - Estrutura base:
*   - DEFINE CLASS + propriedades visuais EXATAS do original
*   - Init() / InicializarForm() / Destroy()
*   - ConfigurarCabecalho() - header escuro com titulo
*   - ConfigurarBotoesRelatorio() - cmg_4c_Botoes (Visualizar/Imprimir/Excel/Encerrar)
*   - ConfigurarBotoesAcao() - cmd_4c_Processar + cmd_4c_Movimento
*   - LimparCampos() - inicializa valores do BO nos campos de filtro
*   - FormParaRelatorio() - transfere campos do form para o BO
*   - ProcessarClick() - executa query e popula grid
*   - MovimentoClick() - abre SigMvExp com registro selecionado
*   - BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnSairClick
*==============================================================================

DEFINE CLASS FormSigReCsp AS FormBase

    *-- Dimensoes EXATAS do original (SigReCsp.SCX: Width=800, Height=600)
    Height      = 600
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 1
    Themes      = .F.
    ShowTips    = .T.

    *-- BO de pesquisa (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura estrutura completa do formulario de pesquisa
    *   1. Caption + Picture (fundo)
    *   2. Cria SigReCspBO e carrega empresa padrao
    *   3. Monta cabecalho + botoes de relatorio + botoes de acao
    *   4. Vincula eventos Click de todos os botoes
    *   5. Inicializa valores dos campos de filtro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Pesquisa opera" + CHR(231) + CHR(245) + "es"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de pesquisa de operacoes
            THIS.this_oRelatorio = CREATEOBJECT("SigReCspBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReCspBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            *-- Carregar empresa padrao e descricao (pula em validacao de UI sem SQL)
            IF loc_lContinuar AND ;
               (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                IF !THIS.this_oRelatorio.InicializarFiltros()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do legado)
                THIS.ConfigurarCabecalho()

                *-- Botoes de relatorio: Visualizar / Imprimir / Excel / Encerrar
                THIS.ConfigurarBotoesRelatorio()

                *-- Botoes de acao especificos: Processar / Movimento
                THIS.ConfigurarBotoesAcao()

                *-- PageFrame com Page1 (Resultados) e Page2 (Filtros)
                *-- Page1 hospeda a grade de resultados (preenchida na proxima etapa)
                *-- Page2 hospeda os textboxes de filtro (preenchidos nas etapas seguintes)
                THIS.ConfigurarPageFrame()

                *-- Grade de resultados em Page1
                THIS.ConfigurarPaginaLista()

                *-- Campos de filtro - Fase 5: Empresa, Periodo, Mov/Nr/Doc
                THIS.ConfigurarPaginaDados()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Vincular clicks dos botoes de relatorio (cmg_4c_Botoes)
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                *-- Vincular clicks dos botoes de acao
                BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "ProcessarClick")
                BINDEVENT(THIS.cmd_4c_Movimento, "Click", THIS, "MovimentoClick")

                *-- Valores iniciais dos campos de filtro
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
    * ConfigurarCabecalho - Container escuro superior com titulo da pesquisa
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
                .Caption   = "Pesquisa opera" + CHR(231) + CHR(245) + "es"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco (sobre a sombra)
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Pesquisa opera" + CHR(231) + CHR(245) + "es"
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
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes (btnReport legado)
    *   Original: btnReport.Left=528, Top=-1, Width=273, Height=80
    *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
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

            *-- Visualizar
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
                .ToolTipText     = "Visualizar resultado"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Imprimir
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
                .ToolTipText     = "Imprimir resultado"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            *-- Excel
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

            *-- Encerrar (ESC fecha o formulario)
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
    * ConfigurarBotoesAcao - Botoes de acao especificos desta pesquisa
    *   Equivalentes a cmdProcessar (Left=543) e Dados (Left=619) do legado.
    *   Posicionados diretamente no form na area de filtros (Top=122).
    *   Z-order: adicionados apos ConfigurarBotoesRelatorio, ficam na frente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        *-- Processar: executa query com os filtros preenchidos
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 122
            .Left            = 543
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Processar pesquisa"
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH

        *-- Movimento: abre detalhe do registro selecionado no grid (SigMvExp)
        THIS.AddObject("cmd_4c_Movimento", "CommandButton")
        WITH THIS.cmd_4c_Movimento
            .Top             = 122
            .Left            = 619
            .Width           = 75
            .Height          = 75
            .Caption         = "Movimento"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Ver detalhes do movimento selecionado"
            .Themes           = .T.
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria pgf_4c_Paginas com 2 paginas para hospedar
    *   o conteudo da pesquisa.
    *
    *   Page1 (Resultados): area para a grade de resultados de SigMvCab.
    *   Page2 (Filtros)   : area para os textboxes de filtro de pesquisa.
    *
    *   Posicionado abaixo dos botoes de acao (Top=205) e cobre o restante
    *   do form. O PageFrame eh criado com Tabs=.F. e ActivePage=1; a
    *   navegacao acontece via codigo (AlternarPagina) e nao via clique em aba.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf, loc_cFundo

        loc_cFundo = ""
        IF TYPE("gc_4c_CaminhoIcones") = "C"
            loc_cFundo = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDIF

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
        loc_oPgf.PageCount = 2

        *-- Posicionamento: logo abaixo dos botoes de acao (Top 122 + 75 + 8 = 205)
        loc_oPgf.Top    = 205
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 205
        loc_oPgf.Tabs   = .F.

        *-- Page1: Resultados (grade preenchida na proxima etapa)
        loc_oPgf.Page1.Caption   = "Resultados"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
        IF !EMPTY(loc_cFundo)
            loc_oPgf.Page1.Picture = loc_cFundo
        ENDIF

        *-- Page2: Filtros (textboxes preenchidos nas etapas seguintes)
        loc_oPgf.Page2.Caption   = "Filtros"
        loc_oPgf.Page2.FontName  = "Tahoma"
        loc_oPgf.Page2.FontSize  = 8
        loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
        IF !EMPTY(loc_cFundo)
            loc_oPgf.Page2.Picture = loc_cFundo
        ENDIF

        *-- PageFrame.Visible OBRIGATORIO antes de ActivePage (regra do framework)
        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa campos de filtro com valores do BO
    *   Empresa/descricao carregadas pelo InicializarFiltros() do BO.
    *   Demais filtros zerados. Campos verificados com TYPE() para robustez
    *   em fases anteriores a criacao dos controles (Fases 5-6).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        IF TYPE("THIS.txt_4c_Empresa") = "O"
            THIS.txt_4c_Empresa.Value   = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
        ENDIF
        IF TYPE("THIS.txt_4c_DEmpresa") = "O"
            THIS.txt_4c_DEmpresa.Value  = ALLTRIM(THIS.this_oRelatorio.this_cDEmpresa)
        ENDIF
        IF TYPE("THIS.txt_4c_DtInicial") = "O"
            THIS.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
        ENDIF
        IF TYPE("THIS.txt_4c_DtFinal") = "O"
            THIS.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
        ENDIF
        IF TYPE("THIS.txt_4c_NmOperacao") = "O"
            THIS.txt_4c_NmOperacao.Value = ""
        ENDIF
        IF TYPE("THIS.txt_4c_Codigo") = "O"
            THIS.txt_4c_Codigo.Value     = ""
        ENDIF
        IF TYPE("THIS.txt_4c_Documento") = "O"
            THIS.txt_4c_Documento.Value  = ""
        ENDIF
        IF TYPE("THIS.opt_4c_Conta") = "O"
            THIS.opt_4c_Conta.Value      = 1
        ENDIF
        IF TYPE("THIS.txt_4c_Grupo") = "O"
            THIS.txt_4c_Grupo.Value      = ""
        ENDIF
        IF TYPE("THIS.txt_4c_DGrupo") = "O"
            THIS.txt_4c_DGrupo.Value     = ""
        ENDIF
        IF TYPE("THIS.txt_4c_Conta") = "O"
            THIS.txt_4c_Conta.Value      = ""
        ENDIF
        IF TYPE("THIS.txt_4c_DConta") = "O"
            THIS.txt_4c_DConta.Value     = ""
        ENDIF
        IF TYPE("THIS.txt_4c_Obses") = "O"
            THIS.txt_4c_Obses.Value      = ""
        ENDIF
        *-- Grid: limpar RecordSource
        IF TYPE("THIS.pgf_4c_Paginas") = "O"
            IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource = ""
            ENDIF
        ENDIF
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere valores dos campos de filtro para o BO
    *   Chamado por ProcessarClick antes de executar PrepararDados().
    *   Campos verificados com TYPE() - antes da Fase 5-6 os controles
    *   nao existem e o BO mantem seus valores de inicializacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF

        WITH THIS.this_oRelatorio
            IF TYPE("THIS.txt_4c_Empresa") = "O"
                .this_cEmpresa    = ALLTRIM(THIS.txt_4c_Empresa.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_DtInicial") = "O"
                .this_dDtInicial  = THIS.txt_4c_DtInicial.Value
            ENDIF
            IF TYPE("THIS.txt_4c_DtFinal") = "O"
                .this_dDtFinal    = THIS.txt_4c_DtFinal.Value
            ENDIF
            IF TYPE("THIS.txt_4c_NmOperacao") = "O"
                .this_cNmOperacao = ALLTRIM(THIS.txt_4c_NmOperacao.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_Codigo") = "O"
                .this_cCodigo     = ALLTRIM(THIS.txt_4c_Codigo.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_Documento") = "O"
                .this_cDocumento  = ALLTRIM(THIS.txt_4c_Documento.Value)
            ENDIF
            IF TYPE("THIS.opt_4c_Conta") = "O"
                .this_nOptConta   = THIS.opt_4c_Conta.Value
            ENDIF
            IF TYPE("THIS.txt_4c_Grupo") = "O"
                .this_cGrupos     = ALLTRIM(THIS.txt_4c_Grupo.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_Conta") = "O"
                .this_cContas     = ALLTRIM(THIS.txt_4c_Conta.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_DConta") = "O"
                .this_cDContas    = ALLTRIM(THIS.txt_4c_DConta.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_DGrupo") = "O"
                .this_cDGrupos    = ALLTRIM(THIS.txt_4c_DGrupo.Value)
            ENDIF
            IF TYPE("THIS.txt_4c_Obses") = "O"
                .this_cObses      = ALLTRIM(THIS.txt_4c_Obses.Value)
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarClick - Executa a pesquisa e exibe resultados no grid
    *   1. FormParaRelatorio() copia filtros para o BO
    *   2. PrepararDados() executa SQLEXEC em SigMvCab
    *   3. RecordSource + ControlSource do grid apontam para cursor resultado
    *   4. Headers reconfigurados apos RecordSource (VFP9 os reseta)
    *   Equivalente ao procedimento 'processamento' do legado SIGRECSP.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarClick()
        LOCAL loc_lResultado, loc_oGrid, loc_cCursor
        loc_lResultado = .F.
        loc_oGrid      = .NULL.

        *-- Obter referencia ao grid dentro do PageFrame.Page1
        IF TYPE("THIS.pgf_4c_Paginas") = "O"
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
        ENDIF

        TRY
            IF VARTYPE(loc_oGrid) != "O"
                MsgAviso("Grid de resultados n" + CHR(227) + ;
                    "o configurado.", "Processar")
            ELSE
                THIS.FormParaRelatorio()
                THIS.Enabled = .F.
                THIS.Refresh()

                IF THIS.this_oRelatorio.PrepararDados()
                    loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
                    IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0

                        loc_oGrid.RecordSource = ""
                        loc_oGrid.RecordSource = loc_cCursor

                        loc_oGrid.Column1.ControlSource = loc_cCursor + ".dopes"
                        loc_oGrid.Column2.ControlSource = loc_cCursor + ".numes"
                        loc_oGrid.Column3.ControlSource = loc_cCursor + ".notas"
                        loc_oGrid.Column4.ControlSource = loc_cCursor + ".datas"
                        loc_oGrid.Column5.ControlSource = loc_cCursor + ".usulibs"
                        loc_oGrid.Column6.ControlSource = loc_cCursor + ".Obses"

                        *-- Reconfigurar headers (VFP9 reseta ao alterar RecordSource)
                        loc_oGrid.Column1.Header1.Caption = ;
                            "Movimenta" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column2.Header1.Caption = ;
                            "N" + CHR(250) + "mero"
                        loc_oGrid.Column3.Header1.Caption = "Docum."
                        loc_oGrid.Column4.Header1.Caption = "Data"
                        loc_oGrid.Column5.Header1.Caption = ;
                            "Usu" + CHR(225) + "rio"
                        loc_oGrid.Column6.Header1.Caption = ;
                            "Observa" + CHR(231) + CHR(227) + "o"

                        *-- Navegar para a pagina de resultados e focar grid
                        THIS.AlternarPagina(1)
                        loc_oGrid.SetFocus()
                        loc_lResultado = .T.
                    ELSE
                        MsgAviso("N" + CHR(227) + "o existe movimenta" + ;
                            CHR(231) + CHR(227) + "o para os filtros selecionados.", ;
                            "Pesquisa de Opera" + CHR(231) + CHR(245) + "es")
                    ENDIF
                ELSE
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Erro ao processar")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao Processar")
        ENDTRY
        THIS.Enabled = .T.
        THIS.Refresh()
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MovimentoClick - Abre SigMvExp com o registro selecionado no grid
    *   Equivalente ao click de Dados no legado SIGRECSP.
    *   Verifica se operacao existe em SigCdOpe antes de abrir SigMvExp.
    *--------------------------------------------------------------------------
    PROCEDURE MovimentoClick()
        LOCAL loc_cSQL, loc_nResult, loc_cDopes, loc_nNumes, loc_cEmps
        loc_cDopes = ""
        loc_nNumes = 0
        loc_cEmps  = ""
        TRY
            IF !USED(THIS.this_oRelatorio.this_cCursorDados) OR ;
               RECCOUNT(THIS.this_oRelatorio.this_cCursorDados) = 0
                MsgAviso("Sem registros. Execute Processar primeiro.", ;
                    "Movimento")
            ELSE
                SELECT (THIS.this_oRelatorio.this_cCursorDados)
                loc_cDopes = ALLTRIM(dopes)
                loc_nNumes = numes
                loc_cEmps  = ALLTRIM(emps)

                *-- Verificar se operacao existe em SigCdOpe (igual ao legado Dados.Click)
                loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                    EscaparSQL(loc_cDopes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")

                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TmpOpe") > 0
                    USE IN cursor_4c_TmpOpe
                    THIS.Enabled = .F.
                    THIS.Refresh()
                    DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
                    SELECT (THIS.this_oRelatorio.this_cCursorDados)
                    THIS.Enabled = .T.
                    THIS.Refresh()
                ELSE
                    IF USED("cursor_4c_TmpOpe")
                        USE IN cursor_4c_TmpOpe
                    ENDIF
                    MsgAviso("Opera" + CHR(231) + CHR(227) + ;
                        "o n" + CHR(227) + "o encontrada em SigCdOpe.", ;
                        "Movimento")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.Enabled = .T.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao abrir Movimento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa pesquisa e exibe resultados no grid
    *   Para form de pesquisa (sem FRX): Visualizar = Processar (rodar query
    *   e mostrar resultados na Page1). Equivalente ao Processar do legado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.ProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime o cursor de resultados via REPORT FORM
    *   Se nao ha dados, orienta o usuario a executar Processar primeiro.
    *   Usa SET PRINTER TO PROMPT para selecionar impressora.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cCursor, loc_lResultado
        loc_lResultado = .F.
        loc_cCursor    = ""

        IF VARTYPE(THIS.this_oRelatorio) = "O"
            loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
        ENDIF

        TRY
            IF EMPTY(loc_cCursor) OR !USED(loc_cCursor) OR ;
               RECCOUNT(loc_cCursor) = 0
                MsgAviso("Execute Processar para carregar dados antes de imprimir.", ;
                    "Imprimir")
            ELSE
                SELECT (loc_cCursor)
                SET PRINTER TO PROMPT
                SET PRINTER ON
                LIST OFF TO PRINTER
                SET PRINTER OFF
                SET PRINTER TO
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Exporta cursor de resultados para arquivo XLS
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cArq
        IF USED(THIS.this_oRelatorio.this_cCursorDados) AND ;
           RECCOUNT(THIS.this_oRelatorio.this_cCursorDados) > 0
            loc_cArq = SYS(5) + CURDIR() + "SigReCsp_" + ;
                STRTRAN(DTOC(DATE()), "/", "") + ".xls"
            SELECT (THIS.this_oRelatorio.this_cCursorDados)
            COPY TO (loc_cArq) TYPE XLS
            MsgInfo("Exportado para: " + loc_cArq, "Excel")
        ELSE
            MsgAviso("Sem dados para exportar. Execute Processar primeiro.", ;
                "Excel")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia uma nova pesquisa
    *   Para form de pesquisa/relat" + CHR(243) + "rio: equivalente a iniciar
    *   uma nova consulta. Fecha cursor de resultados anteriores, restaura
    *   filtros aos valores iniciais e navega para a Page2 (Filtros).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cCursor, loc_oGrid
        TRY
            *-- Fechar cursor de resultados (se existir)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
                *-- Reinicializar valores padrao dos filtros no BO
                THIS.this_oRelatorio.this_dDtInicial = DATE()
                THIS.this_oRelatorio.this_dDtFinal   = DATE()
                THIS.this_oRelatorio.this_cNmOperacao = ""
                THIS.this_oRelatorio.this_cCodigo     = ""
                THIS.this_oRelatorio.this_cDocumento  = ""
                THIS.this_oRelatorio.this_cObses      = ""
                THIS.this_oRelatorio.this_cGrupos     = ""
                THIS.this_oRelatorio.this_cContas     = ""
                THIS.this_oRelatorio.this_cDContas    = ""
                THIS.this_oRelatorio.this_nOptConta   = 1
            ENDIF

            *-- Limpar RecordSource do grid
            IF TYPE("THIS.pgf_4c_Paginas") = "O"
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.RecordSource = ""
                ENDIF
            ENDIF

            *-- Restaurar valores nos controles e navegar para Filtros
            THIS.LimparCampos()
            THIS.AlternarPagina(2)
            IF TYPE("THIS.txt_4c_Empresa") = "O"
                THIS.txt_4c_Empresa.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao iniciar nova pesquisa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Volta para a tela de filtros preservando valores
    *   Permite ao usuario ajustar filtros sem perder a configura" + CHR(231) + CHR(227) + "o
    *   atual. Mantem cursor de resultados (caso usuario queira voltar)
    *   e simplesmente navega para a Page2 (Filtros).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        TRY
            *-- Sincronizar campos com valores atuais do BO (preserva ajustes)
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                IF TYPE("THIS.txt_4c_Empresa") = "O"
                    THIS.txt_4c_Empresa.Value = ;
                        ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
                ENDIF
                IF TYPE("THIS.txt_4c_DEmpresa") = "O"
                    THIS.txt_4c_DEmpresa.Value = ;
                        ALLTRIM(THIS.this_oRelatorio.this_cDEmpresa)
                ENDIF
                IF TYPE("THIS.txt_4c_DtInicial") = "O"
                    THIS.txt_4c_DtInicial.Value = ;
                        THIS.this_oRelatorio.this_dDtInicial
                ENDIF
                IF TYPE("THIS.txt_4c_DtFinal") = "O"
                    THIS.txt_4c_DtFinal.Value = ;
                        THIS.this_oRelatorio.this_dDtFinal
                ENDIF
            ENDIF

            *-- Navegar para Page2 (Filtros) sem limpar valores
            THIS.AlternarPagina(2)
            IF TYPE("THIS.txt_4c_NmOperacao") = "O"
                THIS.txt_4c_NmOperacao.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao alterar filtros")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa resultados da pesquisa atual
    *   Para form de pesquisa: excluir = descartar resultados carregados.
    *   Solicita confirma" + CHR(231) + CHR(227) + "o, fecha cursor de resultados,
    *   limpa RecordSource do grid e navega para a Page2 (Filtros).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCursor, loc_oGrid, loc_lTemDados
        loc_lTemDados = .F.

        TRY
            *-- Verificar se ha dados para excluir
            IF VARTYPE(THIS.this_oRelatorio) = "O"
                loc_cCursor = THIS.this_oRelatorio.this_cCursorDados
                IF !EMPTY(loc_cCursor) AND USED(loc_cCursor) AND ;
                   RECCOUNT(loc_cCursor) > 0
                    loc_lTemDados = .T.
                ENDIF
            ENDIF

            IF !loc_lTemDados
                MsgAviso("N" + CHR(227) + "o existem resultados para limpar.", ;
                    "Limpar Resultados")
                RETURN
            ENDIF

            *-- Confirmar com o usuario
            IF !MsgConfirma("Deseja realmente limpar os resultados da pesquisa?", ;
               "Confirma" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF

            *-- Limpar RecordSource antes de fechar o cursor
            IF TYPE("THIS.pgf_4c_Paginas") = "O"
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                IF VARTYPE(loc_oGrid) = "O"
                    loc_oGrid.RecordSource = ""
                ENDIF
            ENDIF

            *-- Fechar cursor de resultados
            IF !EMPTY(loc_cCursor) AND USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            *-- Voltar para Page2 (Filtros)
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao limpar resultados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona grd_4c_Dados na Page1 (Resultados)
    *   Grid com 6 colunas equivalentes ao Grid1 original:
    *   dopes (Movimentacao), numes (Numero), notas (Docum.),
    *   datas (Data), usulibs (Usuario), Obses (Observacao).
    *   ControlSource e headers sao reconfigurados por ProcessarClick()
    *   apos cada execucao de query (VFP9 reseta headers ao mudar RecordSource).
    *   Posicao: Top=55 (260-205=55 do topo do PageFrame), Left=16,
    *            Width=760, Height=308 - espelha Grid1 original.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados

        WITH loc_oGrid
            .Top                = 55
            .Left               = 16
            .Width              = 760
            .Height             = 308
            .ColumnCount        = 6
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2

            *-- Movimentacao (dopes) - operacao
            WITH .Column1
                .Width              = 140
                .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
                .FontName           = "Verdana"
                .FontSize           = 8
            ENDWITH

            *-- Numero (numes)
            WITH .Column2
                .Width              = 70
                .Header1.Caption    = "N" + CHR(250) + "mero"
                .FontName           = "Verdana"
                .FontSize           = 8
                .Alignment          = 1
            ENDWITH

            *-- Documento (notas)
            WITH .Column3
                .Width              = 100
                .Header1.Caption    = "Docum."
                .FontName           = "Verdana"
                .FontSize           = 8
            ENDWITH

            *-- Data (datas)
            WITH .Column4
                .Width              = 90
                .Header1.Caption    = "Data"
                .FontName           = "Verdana"
                .FontSize           = 8
                .Alignment          = 3
            ENDWITH

            *-- Usuario (usulibs)
            WITH .Column5
                .Width              = 100
                .Header1.Caption    = "Usu" + CHR(225) + "rio"
                .FontName           = "Verdana"
                .FontSize           = 8
            ENDWITH

            *-- Observacao (Obses)
            WITH .Column6
                .Width              = 260
                .Header1.Caption    = "Observa" + CHR(231) + CHR(227) + "o"
                .FontName           = "Verdana"
                .FontSize           = 8
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Vincular DblClick no grid para abrir movimento (equivalente ao Dados.Click legado)
        BINDEVENT(loc_oGrid, "DblClick", THIS, "MovimentoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Resultados) e Page2 (Filtros)
    *   par_nPagina: 1=Resultados, 2=Filtros (padrao=1)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPag
        loc_nPag = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1, ;
            par_nPagina, 1)
        IF TYPE("THIS.pgf_4c_Paginas") = "O"
            THIS.pgf_4c_Paginas.ActivePage = loc_nPag
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e cursores ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona campos de filtro diretamente no form
    *   Fase 5 (50% iniciais): Empresa, Periodo, Movimentacao/Numero/Documento
    *   Controles adicionados com THIS.AddObject - acessiveis via THIS.txt_4c_*
    *   Posicoes EXATAS do original SIGRECSP.SCX (Top/Left/Width/Height identicos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- ROW 1: Empresa (Say6 / Get_Empresa / Get_Dempresa)
        THIS.AddObject("lbl_4c_Empresa", "Label")
        WITH THIS.lbl_4c_Empresa
            .Top       = 96
            .Left      = 61
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Empresa", "TextBox")
        WITH THIS.txt_4c_Empresa
            .Top           = 93
            .Left          = 114
            .Width         = 33
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH THIS.txt_4c_DEmpresa
            .Top           = 93
            .Left          = 148
            .Width         = 359
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ROW 2: Periodo (lbl_periodo / get_dt_inicial / "a" / get_dt_final)
        THIS.AddObject("lbl_4c_Periodo", "Label")
        WITH THIS.lbl_4c_Periodo
            .Top       = 121
            .Left      = 63
            .Width     = 48
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Per" + CHR(237) + "odo : "
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtInicial", "TextBox")
        WITH THIS.txt_4c_DtInicial
            .Top           = 118
            .Left          = 114
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = {}
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_PeriodoA", "Label")
        WITH THIS.lbl_4c_PeriodoA
            .Top       = 121
            .Left      = 199
            .Width     = 8
            .AutoSize  = .T.
            .Caption   = CHR(224)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DtFinal", "TextBox")
        WITH THIS.txt_4c_DtFinal
            .Top           = 118
            .Left          = 209
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = {}
            .Format        = "K"
            .Visible       = .T.
        ENDWITH

        *-- ROW 3: Movimentacao / Numero / Documento (lbl_dopes / get_nm_operacao /
        *--        Say1 / get_codigo / Say2 / get_documento)
        THIS.AddObject("lbl_4c_Dopes", "Label")
        WITH THIS.lbl_4c_Dopes
            .Top       = 146
            .Left      = 33
            .Width     = 78
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_NmOperacao", "TextBox")
        WITH THIS.txt_4c_NmOperacao
            .Top           = 143
            .Left          = 114
            .Width         = 150
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 9
            .SpecialEffect = 1
            .Alignment     = 0
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .MaxLength     = 20
            .Format        = "K!"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Say1", "Label")
        WITH THIS.lbl_4c_Say1
            .Top       = 146
            .Left      = 277
            .Width     = 46
            .AutoSize  = .T.
            .FontSize  = 8
            .Caption   = "N" + CHR(250) + "mero :"
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top           = 143
            .Left          = 326
            .Width         = 45
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 9
            .SpecialEffect = 1
            .Alignment     = 0
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .InputMask     = "999999"
            .MaxLength     = 6
            .Format        = "K!"
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Say2", "Label")
        WITH THIS.lbl_4c_Say2
            .Top       = 146
            .Left      = 392
            .Width     = 60
            .AutoSize  = .T.
            .FontSize  = 8
            .Caption   = "Documento:"
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Documento", "TextBox")
        WITH THIS.txt_4c_Documento
            .Top           = 143
            .Left          = 455
            .Width         = 52
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 9
            .SpecialEffect = 1
            .Alignment     = 0
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .MaxLength     = 6
            .Format        = "K!"
            .Visible       = .T.
        ENDWITH

        *-- ROW 4: Tipo conta - Say4 / OptConta (Origem / Destino)
        THIS.AddObject("lbl_4c_Say4", "Label")
        WITH THIS.lbl_4c_Say4
            .Top       = 167
            .Left      = 68
            .Width     = 43
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Contas :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("opt_4c_Conta", "OptionGroup")
        WITH THIS.opt_4c_Conta
            .Top         = 164
            .Left        = 114
            .Width       = 131
            .Height      = 21
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Origem"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Value     = 1
                .Height    = 15
                .Left      = 5
                .Top       = 4
                .Width     = 52
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Destino"
                .Height    = 15
                .Left      = 68
                .Top       = 4
                .Width     = 54
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- ROW 5: Grupo contabil (Say3 / getGrupo / getDGrupo)
        THIS.AddObject("lbl_4c_Say3", "Label")
        WITH THIS.lbl_4c_Say3
            .Top       = 189
            .Left      = 73
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top           = 186
            .Left          = 114
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DGrupo", "TextBox")
        WITH THIS.txt_4c_DGrupo
            .Top           = 186
            .Left          = 196
            .Width         = 311
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ROW 6: Conta contabil (lbl_estoque / getConta / getDConta)
        THIS.AddObject("lbl_4c_Estoque", "Label")
        WITH THIS.lbl_4c_Estoque
            .Top       = 214
            .Left      = 73
            .Width     = 38
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top           = 211
            .Left          = 114
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_DConta", "TextBox")
        WITH THIS.txt_4c_DConta
            .Top           = 211
            .Left          = 196
            .Width         = 311
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ROW 7: Observacao (Say5 / get_Obses)
        THIS.AddObject("lbl_4c_Say5", "Label")
        WITH THIS.lbl_4c_Say5
            .Top       = 235
            .Left      = 44
            .Width     = 67
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Obses", "TextBox")
        WITH THIS.txt_4c_Obses
            .Top           = 235
            .Left          = 114
            .Width         = 393
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- Vincular validacao de campos por codigo/descricao (ENTER ou TAB)
        BINDEVENT(THIS.txt_4c_Empresa,    "KeyPress", THIS, "TeclaEmpresa")
        BINDEVENT(THIS.txt_4c_DEmpresa,   "KeyPress", THIS, "TeclaDEmpresa")
        BINDEVENT(THIS.txt_4c_NmOperacao, "KeyPress", THIS, "TeclaNmOperacao")
        BINDEVENT(THIS.txt_4c_Grupo,      "KeyPress", THIS, "TeclaGrupo")
        BINDEVENT(THIS.txt_4c_DGrupo,     "KeyPress", THIS, "TeclaDGrupo")
        BINDEVENT(THIS.txt_4c_Conta,      "KeyPress", THIS, "TeclaConta")
        BINDEVENT(THIS.txt_4c_DConta,     "KeyPress", THIS, "TeclaDConta")
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaEmpresa - KeyPress de txt_4c_Empresa (ENTER=13, TAB=9 dispara validacao)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodEmpresa()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodEmpresa - Busca empresa pelo codigo em SigCdEmp, preenche Razas
    *   Equivalente a fAcessoEmpresa(Usuar, 'C', This.Value, ...) do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodEmpresa()
        LOCAL loc_cEmpresa, loc_cSQL, loc_nResult
        loc_cEmpresa = ""
        IF VARTYPE(THIS.txt_4c_Empresa) = "O"
            loc_cEmpresa = ALLTRIM(THIS.txt_4c_Empresa.Value)
        ENDIF
        IF EMPTY(loc_cEmpresa)
            IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                THIS.txt_4c_DEmpresa.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                EscaparSQL(loc_cEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValC")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpValC
                IF !EOF()
                    IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                        THIS.txt_4c_DEmpresa.Value = ALLTRIM(Razas)
                    ENDIF
                ELSE
                    IF VARTYPE(THIS.txt_4c_Empresa) = "O"
                        THIS.txt_4c_Empresa.Value = ""
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                        THIS.txt_4c_DEmpresa.Value = ""
                    ENDIF
                ENDIF
                USE IN cursor_4c_EmpValC
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Validar Empresa")
        ENDTRY
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDEmpresa - KeyPress de txt_4c_DEmpresa (busca por descricao no ENTER/TAB)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDescEmpresa()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDescEmpresa - Busca empresa por descricao em SigCdEmp, preenche Cemps
    *   Equivalente a fAcessoEmpresa(Usuar, 'D', This.Value, ...) do legado.
    *   Se unico resultado: preenche codigo. Se multiplos: abre FormBuscaAuxiliar.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDescEmpresa()
        LOCAL loc_cDesc, loc_cSQL, loc_nResult
        loc_cDesc = ""
        IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
            loc_cDesc = ALLTRIM(THIS.txt_4c_DEmpresa.Value)
        ENDIF
        IF EMPTY(loc_cDesc)
            IF VARTYPE(THIS.txt_4c_Empresa) = "O"
                THIS.txt_4c_Empresa.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
                EscaparSQL("%" + loc_cDesc + "%") + " ORDER BY Razas"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValD")
            IF loc_nResult > 0
                SELECT cursor_4c_EmpValD
                DO CASE
                    CASE RECCOUNT("cursor_4c_EmpValD") = 1
                        IF VARTYPE(THIS.txt_4c_Empresa) = "O"
                            THIS.txt_4c_Empresa.Value = ALLTRIM(Cemps)
                        ENDIF
                        IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                            THIS.txt_4c_DEmpresa.Value = ALLTRIM(Razas)
                        ENDIF
                    CASE RECCOUNT("cursor_4c_EmpValD") > 1
                        USE IN cursor_4c_EmpValD
                        THIS.AbrirBuscaEmpresa()
                        RETURN
                    OTHERWISE
                        IF VARTYPE(THIS.txt_4c_Empresa) = "O"
                            THIS.txt_4c_Empresa.Value = ""
                        ENDIF
                        IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                            THIS.txt_4c_DEmpresa.Value = ""
                        ENDIF
                ENDCASE
                IF USED("cursor_4c_EmpValD")
                    USE IN cursor_4c_EmpValD
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Validar Empresa")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaEmpresa - Abre FormBuscaAuxiliar para selecao de empresa
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_oForm, loc_cEmpresa, loc_cRazas
        loc_cEmpresa = ""
        loc_cRazas   = ""
        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigCdEmp", "Cemps", "Razas", ;
                "Empresa", "Descri" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
                loc_cEmpresa = ALLTRIM(loc_oForm.this_cCodigoSelecionado)
                loc_cRazas   = ALLTRIM(loc_oForm.this_cDescricaoSelecionada)
                loc_oForm    = .NULL.
                IF !EMPTY(loc_cEmpresa)
                    IF VARTYPE(THIS.txt_4c_Empresa) = "O"
                        THIS.txt_4c_Empresa.Value = loc_cEmpresa
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
                        THIS.txt_4c_DEmpresa.Value = loc_cRazas
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Busca Empresa")
        ENDTRY
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaNmOperacao - KeyPress de txt_4c_NmOperacao (valida operacao no ENTER/TAB)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaNmOperacao(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarNmOperacao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNmOperacao - Verifica se operacao existe em SigCdOpe
    *   Equivalente a fAcessoMovmto(Usuar, This.Value, This) do legado.
    *   Se nao encontrar, limpa o campo e avisa o usuario.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNmOperacao()
        LOCAL loc_cOp, loc_cSQL, loc_nResult
        loc_cOp = ""
        IF VARTYPE(THIS.txt_4c_NmOperacao) = "O"
            loc_cOp = ALLTRIM(THIS.txt_4c_NmOperacao.Value)
        ENDIF
        IF EMPTY(loc_cOp)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                EscaparSQL(loc_cOp)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
            IF loc_nResult > 0
                SELECT cursor_4c_OpeVal
                IF EOF()
                    IF VARTYPE(THIS.txt_4c_NmOperacao) = "O"
                        THIS.txt_4c_NmOperacao.Value = ""
                    ENDIF
                    MsgAviso("Opera" + CHR(231) + CHR(227) + ;
                        "o n" + CHR(227) + "o encontrada em SigCdOpe.", ;
                        "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF
                USE IN cursor_4c_OpeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, ;
                "Validar Opera" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaGrupo - KeyPress de txt_4c_Grupo (ENTER=13, TAB=9 valida codigo)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodGrupo()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodGrupo - Valida codigo de grupo digitado contra SigCdGcr
    *   Equivalente a fAcessoContab(Usuar,'C',This.Value,...) do legado.
    *   Se encontrado: preenche descricao. Se nao encontrado: abre busca.
    *   Ao limpar grupo, limpa tambem conta (como no original).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodGrupo()
        LOCAL loc_cCod, loc_cSQL, loc_nResult
        loc_cCod = ""
        IF VARTYPE(THIS.txt_4c_Grupo) = "O"
            loc_cCod = ALLTRIM(THIS.txt_4c_Grupo.Value)
        ENDIF
        IF EMPTY(loc_cCod)
            IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
                THIS.txt_4c_DGrupo.Value = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_Conta) = "O"
                THIS.txt_4c_Conta.Value  = ""
            ENDIF
            IF VARTYPE(THIS.txt_4c_DConta) = "O"
                THIS.txt_4c_DConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                EscaparSQL(loc_cCod)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nResult > 0
                SELECT cursor_4c_GcrVal
                IF !EOF()
                    IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
                        THIS.txt_4c_DGrupo.Value = ALLTRIM(descrs)
                    ENDIF
                ELSE
                    IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                        THIS.txt_4c_Grupo.Value  = ""
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
                        THIS.txt_4c_DGrupo.Value = ""
                    ENDIF
                    THIS.AbrirBuscaGrupo()
                ENDIF
                USE IN cursor_4c_GcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Validar Grupo")
        ENDTRY
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDGrupo - KeyPress de txt_4c_DGrupo (abre busca por descricao no ENTER/TAB)
    *   Rejeita se Grupo ja tem codigo - equivalente ao When=IsEmpty(getGrupo) legado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                IF !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
                    RETURN
                ENDIF
            ENDIF
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao de grupo contabil
    *   Tabela: SigCdGcr, campos: codigos / descrs.
    *   Equivalente a fAcessoContab(Usuar,'D',...) do legado getDGrupo.Valid.
    *   Ao selecionar novo grupo, limpa conta (comportamento identico ao original).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oBusca, loc_cValor, loc_cCursor
        loc_cCursor = "cursor_4c_GcrBusca"
        TRY
            loc_cValor = ""
            IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", loc_cCursor, "codigos", loc_cValor, ;
                "Selecionar Grupo Cont" + CHR(225) + "bil", "")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                        THIS.txt_4c_Grupo.Value  = ALLTRIM(codigos)
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
                        THIS.txt_4c_DGrupo.Value = ALLTRIM(descrs)
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_Conta) = "O"
                        THIS.txt_4c_Conta.Value  = ""
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DConta) = "O"
                        THIS.txt_4c_DConta.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Busca Grupo")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaConta - KeyPress de txt_4c_Conta (ENTER=13, TAB=9 valida codigo)
    *--------------------------------------------------------------------------
    PROCEDURE TeclaConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodConta()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodConta - Valida codigo de conta digitado contra SigCdCli
    *   Equivalente a fAcessoContas(Usuar,Grupo,'C',This.Value,...) do legado.
    *   Se grupo preenchido, filtra iclis LIKE grupo% (igual ao fAcessoContas).
    *   Se encontrado: preenche descricao. Se nao encontrado: abre busca.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodConta()
        LOCAL loc_cCod, loc_cGrupo, loc_cFiltro, loc_cSQL, loc_nResult
        loc_cCod = ""
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            loc_cCod = ALLTRIM(THIS.txt_4c_Conta.Value)
        ENDIF
        IF EMPTY(loc_cCod)
            IF VARTYPE(THIS.txt_4c_DConta) = "O"
                THIS.txt_4c_DConta.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            loc_cGrupo  = ""
            loc_cFiltro = ""
            IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                EscaparSQL(loc_cCod) + loc_cFiltro
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
            IF loc_nResult > 0
                SELECT cursor_4c_CliVal
                IF !EOF()
                    IF VARTYPE(THIS.txt_4c_DConta) = "O"
                        THIS.txt_4c_DConta.Value = ALLTRIM(rclis)
                    ENDIF
                ELSE
                    IF VARTYPE(THIS.txt_4c_Conta) = "O"
                        THIS.txt_4c_Conta.Value  = ""
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DConta) = "O"
                        THIS.txt_4c_DConta.Value = ""
                    ENDIF
                    THIS.AbrirBuscaConta()
                ENDIF
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Validar Conta")
        ENDTRY
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TeclaDConta - KeyPress de txt_4c_DConta (abre busca por descricao no ENTER/TAB)
    *   Rejeita se Conta ja tem codigo - equivalente ao When=IsEmpty(getConta) legado.
    *--------------------------------------------------------------------------
    PROCEDURE TeclaDConta(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF VARTYPE(THIS.txt_4c_Conta) = "O"
                IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
                    RETURN
                ENDIF
            ENDIF
            THIS.AbrirBuscaConta()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecao de conta contabil
    *   Tabela: SigCdCli, campos: iclis / rclis.
    *   Equivalente a fAcessoContas(Usuar,Grupo,'D',...) do legado getDConta.Valid.
    *   Se grupo preenchido, filtra SigCdCli pelo grupo (iclis LIKE grupo%).
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_oBusca, loc_cValor, loc_cGrupo, loc_cFiltro, loc_cCursor
        loc_cCursor = "cursor_4c_CliBusca"
        TRY
            loc_cValor  = ""
            loc_cGrupo  = ""
            loc_cFiltro = ""
            IF VARTYPE(THIS.txt_4c_Conta) = "O"
                loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)
            ENDIF
            IF VARTYPE(THIS.txt_4c_Grupo) = "O"
                loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
                "Selecionar Conta Cont" + CHR(225) + "bil", loc_cFiltro)
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("rclis", "", "Nome")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    IF VARTYPE(THIS.txt_4c_Conta) = "O"
                        THIS.txt_4c_Conta.Value  = ALLTRIM(iclis)
                    ENDIF
                    IF VARTYPE(THIS.txt_4c_DConta) = "O"
                        THIS.txt_4c_DConta.Value = ALLTRIM(rclis)
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Busca Conta")
        ENDTRY
        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula campos do form com valores do BO
    *   Equivalente ao BOParaForm() dos forms CRUD. Para este form de pesquisa,
    *   sincroniza os controles de filtro com os valores armazenados no BO,
    *   delegando para LimparCampos() que realiza esse preenchimento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos controles de filtro para o BO
    *   Alias de FormParaRelatorio() mantido para consistencia com a
    *   nomenclatura padrao dos forms do sistema (FormParaBO/BOParaForm).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Gerencia estado ReadOnly dos campos de descricao
    *   Implementa o equivalente ao evento When= do legado VFP9:
    *     Get_Dempresa.When = Return Empty(get_Empresa.Value)
    *     getDGrupo.When    = Return(IsEmpty(getGrupo.Value))
    *     getDConta.When    = Return(IsEmpty(getConta.Value))
    *   Campos de descricao ficam ReadOnly quando o codigo ja esta preenchido
    *   (codigo preenchido = usuario ja selecionou; desc apenas para exibicao).
    *   Deve ser chamado apos toda alteracao nos campos de codigo.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cConta
        loc_cEmpresa = ""
        loc_cGrupo   = ""
        loc_cConta   = ""

        IF VARTYPE(THIS.txt_4c_Empresa) = "O"
            loc_cEmpresa = ALLTRIM(THIS.txt_4c_Empresa.Value)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Grupo) = "O"
            loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
        ENDIF
        IF VARTYPE(THIS.txt_4c_Conta) = "O"
            loc_cConta = ALLTRIM(THIS.txt_4c_Conta.Value)
        ENDIF

        *-- DEmpresa readonly quando Empresa tem codigo (When=Empty(get_Empresa.Value))
        IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
            THIS.txt_4c_DEmpresa.ReadOnly = !EMPTY(loc_cEmpresa)
        ENDIF

        *-- DGrupo readonly quando Grupo tem codigo (When=IsEmpty(getGrupo.Value))
        IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
            THIS.txt_4c_DGrupo.ReadOnly = !EMPTY(loc_cGrupo)
        ENDIF

        *-- DConta readonly quando Conta tem codigo (When=IsEmpty(getConta.Value))
        IF VARTYPE(THIS.txt_4c_DConta) = "O"
            THIS.txt_4c_DConta.ReadOnly = !EMPTY(loc_cConta)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Para form de pesquisa: garante grid sem RecordSource residual
    *   Nao carrega dados automaticamente - usuario pressiona Processar/Visualizar.
    *   Chamado em InicializarForm para estado inicial limpo.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("THIS.pgf_4c_Paginas") = "O"
            IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
                THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.RecordSource = ""
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado atual
    *   Para form de pesquisa: botao Movimento habilitado apenas quando ha
    *   resultados carregados no grid. Processar e botoes de relatorio sempre
    *   habilitados.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemDados
        loc_lTemDados = .F.
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            IF !EMPTY(THIS.this_oRelatorio.this_cCursorDados)
                IF USED(THIS.this_oRelatorio.this_cCursorDados)
                    IF RECCOUNT(THIS.this_oRelatorio.this_cCursorDados) > 0
                        loc_lTemDados = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Movimento) = "O"
            THIS.cmd_4c_Movimento.Enabled = loc_lTemDados
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Executa a pesquisa com os filtros atuais
    *   Alias de ProcessarClick() para consistencia com a nomenclatura padrao
    *   dos forms do sistema (BtnBuscarClick disparado pelo botao Processar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.ProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o formulario
    *   Alias de BtnSairClick() para consistencia com a nomenclatura padrao.
    *   Chamado por BINDEVENT(Buttons(4), "Click", THIS, "BtnSairClick").
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Para form de pesquisa: executa a pesquisa (salva filtros
    *   e gera resultado). Equivale a confirmar os parametros e processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.ProcessarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela filtros atuais e restaura estado inicial
    *   Para form de pesquisa: limpa todos os campos de filtro, fecha cursor
    *   de resultados e navega para a pagina de filtros (equivale a Nova Pesquisa).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnIncluirClick()
    ENDPROC

ENDDEFINE
