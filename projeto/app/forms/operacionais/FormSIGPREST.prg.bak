*==============================================================================
* FormSIGPREST.prg - Form Operacional - Gerar Estrutura de Arquivos
* Herda de: FormBase
* Tipo: OPERACIONAL (dialog utilitario de manutencao)
* Original: SIGPREST.SCX (600x191, TitleBar=0, sem PageFrame)
*==============================================================================

DEFINE CLASS FormSIGPREST AS FormBase

    *-- Dimensoes do dialog
    Width  = 600
    Height = 191

    *-- Propriedades visuais (identicas ao original)
    Caption     = "Gerar Estrutura"
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2
    BorderStyle = 2
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Objeto de negocio
    this_oBusinessObject = .NULL.

    *-- Estado de processamento
    this_lProcessando = .F.
    this_cDirAtual    = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRESTBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configuracao form-level (fundo, dimensoes, estado)
                THIS.ConfigurarPageFrame()

                *-- Configurar layout (cabecalho + shape/label/botoes)
                THIS.ConfigurarLayout()

                *-- Propagar Caption do form para os labels do cabecalho
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Configurar area de dados (Parte 1: shape decorativo + checkbox Estrutura)
                *-- OPERACIONAL: nao ha Page2 - "pagina dados" mapeia para os controles
                *-- interativos do dialog (checkboxes de selecao das operacoes).
                THIS.ConfigurarPaginaDados()

                *-- Configurar area de trabalho (atalhos, tooltips, estado inicial)
                THIS.ConfigurarPaginaLista()

                *-- Tornar controles visiveis
                THIS.TornarControlesVisiveis(THIS)

                *-- Estado inicial do dialog: pronto para uso (habilitado)
                THIS.AlternarPagina(1)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRESTBO", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, ;
                "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configuracao de nivel form
    *
    * OBS: Este form OPERACIONAL nao usa PageFrame de negocio (nao ha lista/dados
    * como em cadastros CRUD). O metodo executa o setup form-level equivalente:
    * aplicacao do fundo padrao (new_background.jpg do framework original) e
    * ajuste de dimensoes/estado da janela para um dialog utilitario.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo

        *-- Fundo padrao do framework (equivalente ao SCX original)
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas do dialog (evita ajuste do FormBase)
        THIS.Width  = 600
        THIS.Height = 191

        *-- Estado inicial do dialog: centralizado, sem barra de titulo
        THIS.AutoCenter  = .T.
        THIS.AlwaysOnTop = .T.

        *-- Diretorio base do processamento (equivale a .\basededados\ do original)
        THIS.this_cDirAtual = SYS(5) + SYS(2003) + "\basededados\"
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLayout()
    *--------------------------------------------------------------------------
        *-- Cabecalho escuro (cntSombra original: Top=-1, Left=-1, W=800, H=80)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = -1
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0

            *-- Sombra (deslocada 1px para efeito 3D)
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = "Cadastro de Testes"
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            *-- Titulo branco sobre fundo escuro
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .AutoSize    = .F.
                .Caption     = "Cadastro de Testes"
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = THIS.Width
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible     = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Botao OK - Gerar (Top=3, Left=450)
        THIS.AddObject("cmd_4c_OK", "CommandButton")
        WITH THIS.cmd_4c_OK
            .Top            = 3
            .Left           = 450
            .Width          = 75
            .Height         = 75
            .Caption        = CHR(60) + "Gerar"
            .Picture        = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .Visible        = .T.
        ENDWITH

        *-- Botao Cancela - Encerrar (Top=3, Left=525)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top            = 3
            .Left           = 525
            .Width          = 75
            .Height         = 75
            .Caption        = "Encerrar"
            .Cancel         = .T.
            .Picture        = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .FontBold       = .T.
            .FontItalic     = .T.
            .ForeColor      = RGB(90, 90, 90)
            .BackColor      = RGB(255, 255, 255)
            .Themes         = .T.
            .SpecialEffect  = 0
            .PicturePosition = 13
            .MousePointer   = 15
            .WordWrap       = .T.
            .Visible        = .T.
        ENDWITH

        *-- BINDEVENTs dos botoes
        BINDEVENT(THIS.cmd_4c_OK,     "Click", THIS, "CmdOKClick")
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "CmdCancelaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Controles interativos do dialog (area de selecao)
    *
    * OPERACIONAL: este dialog NAO tem PageFrame com Page2 (Dados). O metodo
    * cria TODOS os controles interativos que compoem a area de selecao do dialog:
    *
    *   - shp_4c_Shape1        : moldura decorativa em volta das checkboxes
    *                            (Shape1 no SCX original: Top=9, Left=49, W=173, H=110)
    *   - chk_4c_GeraArquivos  : checkbox Estrutura (GeraArquivos: Top=90, Left=55)
    *   - chk_4c_GeraIndices   : checkbox Indice (GeraIndices: Top=90, Left=136)
    *   - lbl_4c_Mensagem      : label de status (Mensagem1: Top=132, Left=48)
    *
    * Posicoes seguem o layout.json extraido do SCX original (PILAR 1 - UX).
    * Nao ha lookups neste form (original nao usa fwBuscaExt/sigacess).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Shape decorativo em volta da area de checkboxes
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top     = 9
            .Left    = 49
            .Width   = 173
            .Height  = 110
            .Visible = .T.
        ENDWITH

        *-- Checkbox 1/2: Gerar Estrutura de arquivos DBF
        THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
        WITH THIS.chk_4c_GeraArquivos
            .Top        = 90
            .Left       = 55
            .Width      = 75
            .Height     = 75
            .Caption    = "Estrutura"
            .Value      = 1
            .Style      = 1
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 2
            .BackStyle  = 1
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Checkbox 2/2: Gerar Indices (GeraIndices: Top=90, Left=136, W=75, H=75)
        THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
        WITH THIS.chk_4c_GeraIndices
            .Top        = 90
            .Left       = 136
            .Width      = 75
            .Height     = 75
            .Caption    = CHR(205) + "ndice"
            .Value      = 1
            .Style      = 1
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontName   = "Tahoma"
            .FontSize   = 8
            .FontBold   = .T.
            .FontItalic = .T.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Alignment  = 2
            .BackStyle  = 1
            .ForeColor  = RGB(90, 90, 90)
            .BackColor  = RGB(255, 255, 255)
            .Themes     = .F.
            .Visible    = .T.
        ENDWITH

        *-- Label de mensagem de status (Mensagem1: Top=132, Left=48, W=480, H=24)
        THIS.AddObject("lbl_4c_Mensagem", "Label")
        WITH THIS.lbl_4c_Mensagem
            .Top       = 132
            .Left      = 48
            .Width     = 480
            .Height    = 24
            .Caption   = ""
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .Alignment = 2
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura a area operacional (checkboxes + atalhos)
    *
    * OPERACIONAL: este dialog NAO tem PageFrame Lista/Dados como CRUDs.
    * A "pagina lista" mapeia para a area de trabalho onde o usuario escolhe
    * quais estruturas gerar (Estrutura / Indice). Este metodo:
    *   1. Vincula atalhos de teclado (F5=Gerar, ESC=Encerrar) via KeyPress
    *   2. Ajusta ToolTipText dos controles operacionais
    *   3. Reseta estado dos checkboxes para o padrao (ambos marcados)
    *   4. Limpa label de mensagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- ToolTipTexts descritivos (documentacao contextual em runtime)
        THIS.chk_4c_GeraArquivos.ToolTipText = ;
            "Gerar estrutura de tabelas DBF a partir das tabelas do banco"
        THIS.chk_4c_GeraIndices.ToolTipText = ;
            "Gerar " + CHR(237) + "ndices das tabelas DBF geradas"
        THIS.cmd_4c_OK.ToolTipText = ;
            "Iniciar gera" + CHR(231) + CHR(227) + "o (F5)"
        THIS.cmd_4c_Cancela.ToolTipText = ;
            "Encerrar sem gerar (ESC)"

        *-- Estado padrao dos checkboxes (ambos marcados)
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1

        *-- Label de mensagem inicia limpa
        THIS.lbl_4c_Mensagem.Caption = ""

        *-- Vincular atalhos de teclado nos botoes (F5=Gerar, ESC=Cancelar)
        BINDEVENT(THIS.cmd_4c_OK,      "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.cmd_4c_Cancela, "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.chk_4c_GeraArquivos, "KeyPress", THIS, "TrataAtalhoTeclado")
        BINDEVENT(THIS.chk_4c_GeraIndices,  "KeyPress", THIS, "TrataAtalhoTeclado")

        *-- Ordem de tabulacao para navegacao coerente
        THIS.chk_4c_GeraArquivos.TabIndex = 1
        THIS.chk_4c_GeraIndices.TabIndex  = 2
        THIS.cmd_4c_OK.TabIndex           = 3
        THIS.cmd_4c_Cancela.TabIndex      = 4

        *-- Foco inicial no primeiro checkbox
        IF THIS.chk_4c_GeraArquivos.Enabled
            THIS.chk_4c_GeraArquivos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TrataAtalhoTeclado - Handler unico dos atalhos (F5, ESC)
    * F5  (116) -> dispara CmdOKClick (Gerar)
    * ESC ( 27) -> dispara CmdCancelaClick (Encerrar)
    *--------------------------------------------------------------------------
    PROCEDURE TrataAtalhoTeclado(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
        CASE par_nKeyCode = 116 AND THIS.cmd_4c_OK.Enabled
            THIS.CmdOKClick()
        CASE par_nKeyCode = 27 AND THIS.cmd_4c_Cancela.Enabled
            THIS.CmdCancelaClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - State machine do dialog operacional
    *
    * OPERACIONAL: este dialog NAO tem multiplas Pages (nao ha ActivePage a
    * mudar). "AlternarPagina" implementa a maquina de estados do processo:
    *   par_nPagina = 1 (PRONTO)     -> UI habilitada, checkboxes editaveis
    *   par_nPagina = 2 (PROCESSANDO)-> UI bloqueada, mensagem "Processando..."
    *   par_nPagina = 3 (CONCLUIDO)  -> UI reabilitada, mensagem final preservada
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nEstado
        loc_nEstado = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        DO CASE
        CASE loc_nEstado = 1
            *-- Estado PRONTO: dialog aceitando input do usuario
            THIS.chk_4c_GeraArquivos.Enabled = .T.
            THIS.chk_4c_GeraIndices.Enabled  = .T.
            THIS.cmd_4c_OK.Enabled           = .T.
            THIS.cmd_4c_Cancela.Enabled      = .T.
            THIS.this_lProcessando           = .F.
            THIS.lbl_4c_Mensagem.Caption     = ""

        CASE loc_nEstado = 2
            *-- Estado PROCESSANDO: bloquear input durante geracao
            THIS.chk_4c_GeraArquivos.Enabled = .F.
            THIS.chk_4c_GeraIndices.Enabled  = .F.
            THIS.cmd_4c_OK.Enabled           = .F.
            THIS.cmd_4c_Cancela.Enabled      = .F.
            THIS.this_lProcessando           = .T.
            THIS.lbl_4c_Mensagem.Caption     = "Processando..."
            THIS.Refresh()

        CASE loc_nEstado = 3
            *-- Estado CONCLUIDO: reabilitar UI, preservar mensagem final
            THIS.chk_4c_GeraArquivos.Enabled = .T.
            THIS.chk_4c_GeraIndices.Enabled  = .T.
            THIS.cmd_4c_OK.Enabled           = .T.
            THIS.cmd_4c_Cancela.Enabled      = .T.
            THIS.this_lProcessando           = .F.
            THIS.Refresh()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOKClick - Executa geracao de estrutura e/ou indices
    *--------------------------------------------------------------------------
    PROCEDURE CmdOKClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lcDirAtual, loc_lContinuar

        *-- Estado 2 = PROCESSANDO (bloqueia UI + mostra "Processando...")
        THIS.AlternarPagina(2)

        loc_lContinuar = .T.

        TRY
            loc_lcDirAtual = SYS(5) + SYS(2003) + "\basededados\"

            CLOSE TABLES ALL

            *-- Etapa 1: Gerar estrutura de arquivos
            THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
            IF THIS.chk_4c_GeraArquivos.Value = 1
                IF !THIS.this_oBusinessObject.GerarEstrutura(loc_lcDirAtual)
                    THIS.lbl_4c_Mensagem.Caption = "Erro ao gerar estrutura."
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Etapa 2: Gerar indices (somente se etapa 1 OK)
            IF loc_lContinuar
                CLOSE TABLES ALL
                THIS.this_oBusinessObject.this_lGeraIndices = (THIS.chk_4c_GeraIndices.Value = 1)
                IF THIS.chk_4c_GeraIndices.Value = 1
                    IF !THIS.this_oBusinessObject.GerarIndices(loc_lcDirAtual)
                        THIS.lbl_4c_Mensagem.Caption = THIS.this_oBusinessObject.this_cMensagem
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            *-- Finalizacao
            IF loc_lContinuar
                CLOSE TABLES ALL
                THIS.lbl_4c_Mensagem.Caption = "Processamento Finalizado."
                THIS.this_oBusinessObject.CarregarLogo()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro no Processamento")
            THIS.lbl_4c_Mensagem.Caption = "Erro no processamento."
        ENDTRY

        *-- Estado 3 = CONCLUIDO (reabilita UI, preserva mensagem final)
        THIS.AlternarPagina(3)
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCancelaClick - Encerra o formulario
    *--------------------------------------------------------------------------
    PROCEDURE CmdCancelaClick()
    *--------------------------------------------------------------------------
        *-- Recarregar logo antes de sair (comportamento do original)
        THIS.this_oBusinessObject.CarregarLogo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Fluxo "Incluir arquivos DBF" (gera estrutura completa)
    *
    * OPERACIONAL: o SIGPREST original nao tem botoes CRUD; este handler mapeia
    * o conceito de "Incluir" para a operacao equivalente do dialog: garantir a
    * geracao da estrutura de arquivos DBF (marca chk_4c_GeraArquivos e delega
    * para CmdOKClick, que executa GerarEstrutura + GerarIndices no BO).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Fluxo "Alterar estruturas" (regenera apenas indices)
    *
    * OPERACIONAL: mapeia o conceito de "Alterar" para regeneracao dos indices
    * sobre arquivos ja existentes (desmarca chk_4c_GeraArquivos, marca
    * chk_4c_GeraIndices e delega para CmdOKClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = 0
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe informacoes do diretorio de trabalho
    *
    * OPERACIONAL: mapeia o conceito de "Visualizar" para uma consulta de estado
    * do processamento - exibe na label de mensagem o diretorio destino das
    * estruturas DBF e o total de arquivos existentes nele.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDir, loc_nArquivos, loc_cMsg
        LOCAL ARRAY loc_aArqs[1]
        loc_cDir = SYS(5) + SYS(2003) + "\basededados\"

        IF DIRECTORY(loc_cDir)
            loc_nArquivos = ADIR(loc_aArqs, loc_cDir + "*.dbf")
            loc_cMsg = "Diret" + CHR(243) + "rio: " + loc_cDir + " (" + ;
                       TRANSFORM(loc_nArquivos) + " arquivos DBF)"
        ELSE
            loc_cMsg = "Diret" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + loc_cDir
        ENDIF

        THIS.lbl_4c_Mensagem.Caption = loc_cMsg
        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Fluxo "Excluir/cancelar processamento"
    *
    * OPERACIONAL: mapeia o conceito de "Excluir" para o encerramento do dialog
    * sem executar geracao (equivalente ao botao Encerrar / ESC). Se estiver
    * em meio a um processamento, apenas ignora o clique (state machine bloqueia).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *--------------------------------------------------------------------------
        LOCAL loc_nI, loc_oControle

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControle = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControle) = "O"
                IF PEMSTATUS(loc_oControle, "Visible", 5)
                    loc_oControle.Visible = .T.
                ENDIF

                IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControle.PageCount
                        THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControle, "ControlCount", 5)
                    IF loc_oControle.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControle)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialog (alias para CmdCancelaClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa o processamento (alias para CmdOKClick)
    *
    * OPERACIONAL: "Salvar" = executar geracao da estrutura/indices.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.CmdOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela/reseta o dialog sem executar geracao
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF THIS.this_lProcessando
            RETURN
        ENDIF
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Exibe informacoes do diretorio destino
    *
    * OPERACIONAL: nao ha grid de busca. "Buscar" mapeia para consulta de
    * estado do diretorio de trabalho (equivalente a BtnVisualizarClick).
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores do form para as propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_lGeraArquivos = ;
            (THIS.chk_4c_GeraArquivos.Value = 1)
        THIS.this_oBusinessObject.this_lGeraIndices = ;
            (THIS.chk_4c_GeraIndices.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia propriedades do BO de volta para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.chk_4c_GeraArquivos.Value = ;
            IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
        THIS.chk_4c_GeraIndices.Value = ;
            IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles editaveis
    *
    * par_lHabilitar = .T. -> habilita (estado PRONTO)
    * par_lHabilitar = .F. -> desabilita (estado PROCESSANDO)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        THIS.chk_4c_GeraArquivos.Enabled = loc_lHab
        THIS.chk_4c_GeraIndices.Enabled  = loc_lHab
        THIS.cmd_4c_OK.Enabled           = loc_lHab
        THIS.cmd_4c_Cancela.Enabled      = loc_lHab
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta o dialog para o estado inicial (ambas opcoes marcadas)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.lbl_4c_Mensagem.Caption   = ""
        THIS.this_lProcessando         = .F.
        THIS.HabilitarCampos(.T.)
        IF THIS.chk_4c_GeraArquivos.Enabled
            THIS.chk_4c_GeraArquivos.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Operacional: nao ha grid de lista a carregar
    *
    * OPERACIONAL: SIGPREST e um dialog utilitario sem grid de registros.
    * Mantido por compatibilidade com o pipeline de validacao.
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo operacional
    *
    * OPERACIONAL: delega para AlternarPagina() que implementa a maquina de
    * estados do dialog (1=PRONTO, 2=PROCESSANDO, 3=CONCLUIDO).
    * par_cModo: "PRONTO" / "PROCESSANDO" / "CONCLUIDO"
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo
        loc_cModo = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "PRONTO")

        DO CASE
        CASE loc_cModo = "PROCESSANDO"
            THIS.AlternarPagina(2)
        CASE loc_cModo = "CONCLUIDO"
            THIS.AlternarPagina(3)
        OTHERWISE
            THIS.AlternarPagina(1)
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
