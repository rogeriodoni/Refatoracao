*==============================================================================
* FormSIGPRIMP.prg - Formulario Operacional de Importacao de Movimentacao de Estoque
* Herda de: FormBase
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* BO: SIGPRIMPBO
*==============================================================================
DEFINE CLASS FormSIGPRIMP AS FormBase

    *-- Dimensoes e aparencia (identicas ao SCX original SIGPRIMP)
    Width        = 1000
    Height       = 330
    AutoCenter   = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    WindowType   = 1
    ShowWindow = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    ClipControls = .F.
    TitleBar     = 0
    DataSession  = 2

    *-- Controle interno de erro
    this_cMensagemErro = ""

    *==========================================================================
    * Init - Cria BO e inicializa form via FormBase
    *==========================================================================
    PROCEDURE Init()
        THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar SIGPRIMPBO.", ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura controles e carrega dados iniciais
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de dados"

        TRY
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarBotoes()
            THIS.ConfigurarCampos()
            THIS.TornarControlesVisiveis()
            THIS.CarregarArquivos()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro ao inicializar form")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Define imagem de fundo do form
    * OPERACIONAL flat: sem PageFrame; metodo existe por compatibilidade com pipeline
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImg
        loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImg)
            THIS.Picture = loc_cImg
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption, loc_oCnt, loc_nFormWidth
        loc_cCaption  = "Importa" + CHR(231) + CHR(227) + "o de dados"
        loc_nFormWidth = THIS.Width

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = 1100
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = loc_cCaption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = loc_nFormWidth
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(255, 255, 255)
            .Caption       = loc_cCaption
            .Height        = 46
            .Left          = 10
            .Top           = 17
            .Width         = loc_nFormWidth
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Botoes de acao posicionados no topo do form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Movimentacao de Estoque (btnMovEst: Left=700, PicturePosition=7)
        THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
        WITH THIS.cmd_4c_BtnMovEst
            .Top             = 3
            .Left            = 700
            .Width           = 75
            .Height          = 75
            .Caption         = "Moviment. de Estoque"
            .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
            .PicturePosition = 7
            .FontName        = "Tahoma"
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
        ENDWITH

        *-- Botao Visualizar (oculto: legado ocultava no Init: Visible=.F.)
        THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH THIS.cmd_4c_Visualizar
            .Top             = 3
            .Left            = 775
            .Width           = 75
            .Height          = 75
            .Caption         = "V" + CHR(237) + "deo"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
        ENDWITH

        *-- Botao Imprimir (oculto: legado ocultava no Init: Visible=.F.)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top             = 3
            .Left            = 850
            .Width           = 75
            .Height          = 75
            .Caption         = "Impressora"
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
        ENDWITH

        *-- Botao Encerrar (Cancela do legado: Left=925, Cancel=.T.)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 925
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
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
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnMovEst,  "Click", THIS, "BtnMovEstClick")
        BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Label, TextBox de arquivo e ListBox de arquivos TXT
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Label "Arquivos Importacao :" (Say4 do legado)
        THIS.AddObject("lbl_4c_Label4", "Label")
        WITH THIS.lbl_4c_Label4
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
            .Height    = 17
            .Left      = 310
            .Top       = 111
            .Width     = 130
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox Get_Arquivo: somente leitura (When=.F. no legado)
        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Height        = 21
            .Left          = 440
            .Top           = 108
            .Width         = 250
            .ReadOnly      = .T.
            .TabStop       = .F.
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(90, 90, 90)
        ENDWITH

        *-- ListBox Arquivos: exibe TXT do diretorio de importacao
        THIS.AddObject("obj_4c_Arquivos", "ListBox")
        WITH THIS.obj_4c_Arquivos
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Height        = 169
            .Left          = 402
            .Top           = 130
            .Width         = 288
            .RowSourceType = 0
            .RowSource     = ""
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Sorted        = .T.
            .MultiSelect   = .F.
        ENDWITH

        BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
    ENDPROC

    *==========================================================================
    * CarregarArquivos - Carrega parametros do SigCdPam e lista arquivos TXT
    *==========================================================================
    PROCEDURE CarregarArquivos()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF THIS.this_oBusinessObject.CarregarParametros()
                *-- Pre-preencher textbox com diretorio de importacao (comportamento do Init legado)
                IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
                    THIS.txt_4c_Arquivo.Value = ;
                        ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
                ENDIF

                IF THIS.this_oBusinessObject.BuscarArquivos()
                    *-- Vincular listbox ao cursor de arquivos
                    IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
                        WITH THIS.obj_4c_Arquivos
                            .RowSourceType = 6
                            .RowSource     = "cursor_4c_Arquivos.cArquivo"
                            .Refresh()
                        ENDWITH
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarArquivos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ArquivosInteractiveChange - Exibe arquivo selecionado no textbox
    *==========================================================================
    PROCEDURE ArquivosInteractiveChange()
        IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            THIS.txt_4c_Arquivo.Value = ;
                ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
                ALLTRIM(THIS.obj_4c_Arquivos.Value)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnMovEstClick - Processa todos os arquivos TXT do diretorio de importacao
    * Para cada arquivo: chama ProcessarArquivo() no BO; se sucesso, move para OK\
    * Equivalente ao btnMovEst.Click do legado
    *==========================================================================
    PROCEDURE BtnMovEstClick()
        LOCAL loc_cDirImports, loc_cDirOk, loc_cArquivo, loc_cArquivoFull
        LOCAL loc_nProcessados, loc_nErros, loc_oErro

        *-- Verificar disponibilidade de arquivos
        THIS.this_oBusinessObject.BuscarArquivos()

        IF !USED("cursor_4c_Arquivos") OR RECCOUNT("cursor_4c_Arquivos") = 0
            MsgAviso("Nenhum arquivo para importar.", "Aviso")
            RETURN
        ENDIF

        loc_nProcessados = 0
        loc_nErros       = 0
        loc_cDirImports  = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports))
        loc_cDirOk       = loc_cDirImports + "OK\"

        TRY
            *-- Garantir existencia do subdiretorio OK\
            IF !DIRECTORY(loc_cDirOk)
                MKDIR (loc_cDirOk)
            ENDIF

            *-- Desabilitar botoes durante processamento
            THIS.cmd_4c_BtnMovEst.Enabled = .F.
            THIS.cmd_4c_Cancela.Enabled   = .F.
            THIS.Refresh()

            SELECT cursor_4c_Arquivos
            GO TOP
            SCAN
                loc_cArquivo     = ALLTRIM(cursor_4c_Arquivos.cArquivo)
                loc_cArquivoFull = loc_cDirImports + loc_cArquivo

                *-- Atualizar display do arquivo em processamento
                IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
                    THIS.txt_4c_Arquivo.Value = loc_cArquivoFull
                    THIS.txt_4c_Arquivo.Refresh()
                ENDIF

                *-- Processar via BO
                IF THIS.this_oBusinessObject.ProcessarArquivo(loc_cArquivoFull)
                    loc_nProcessados = loc_nProcessados + 1
                    *-- Mover arquivo processado para OK\
                    IF FILE(loc_cArquivoFull)
                        SET SAFETY OFF
                        COPY FILE (loc_cArquivoFull) TO (loc_cDirOk + loc_cArquivo)
                        IF FILE(loc_cDirOk + loc_cArquivo)
                            DELETE FILE (loc_cArquivoFull)
                        ENDIF
                        SET SAFETY ON
                    ENDIF
                ELSE
                    loc_nErros = loc_nErros + 1
                ENDIF

                SELECT cursor_4c_Arquivos
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BtnMovEstClick")
        ENDTRY

        *-- Reabilitar botoes
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled = .T.
        ENDIF

        *-- Limpar display e recarregar lista apos processamento
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
        ENDIF
        THIS.CarregarArquivos()
        THIS.Refresh()

        *-- Exibir resultado geral se mais de um arquivo foi processado
        IF loc_nProcessados + loc_nErros > 1
            MsgInfo("Processamento conclu" + CHR(237) + "do. " + ;
                    "Sucesso: " + TRANSFORM(loc_nProcessados) + ;
                    " | Erros: " + TRANSFORM(loc_nErros), ;
                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre o arquivo TXT selecionado no Bloco de Notas
    * Botao permanece oculto (legado: Visualizar.Visible = .F. no Init)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cArquivo, loc_cCmd, loc_oErro
        loc_cArquivo = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        IF EMPTY(loc_cArquivo)
            MsgAviso("Selecione um arquivo na lista antes de visualizar.", ;
                     "Visualizar arquivo")
            RETURN
        ENDIF
        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo '" + loc_cArquivo + "' n" + CHR(227) + "o encontrado.", ;
                     "Visualizar arquivo")
            RETURN
        ENDIF
        TRY
            loc_cCmd = "notepad.exe " + CHR(34) + loc_cArquivo + CHR(34)
            RUN /N &loc_cCmd.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao abrir arquivo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - Processa importacao (equivalente a Processar('I') do legado)
    * Botao permanece oculto (legado: Imprimir.Visible = .F. no Init)
    * O legado chamava ThisForm.Processar('I') que executava a mesma logica de
    * importacao que btnMovEst.Click
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        THIS.BtnMovEstClick()
    ENDPROC

    *==========================================================================
    * BtnCancelaClick - Fecha o formulario (equivalente a Cancela.Click do legado)
    *==========================================================================
    PROCEDURE BtnCancelaClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Incluir" corresponde a processar
    * os arquivos disponiveis no diretorio (mesma acao do btnMovEst do legado)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
                                    CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
                                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        IF loc_lConfirma
            THIS.BtnMovEstClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Alterar" corresponde a recarregar a
    * lista de arquivos disponiveis (equivalente a atualizar o cursor Arquivos)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_nRegistros
        THIS.CarregarArquivos()
        loc_nRegistros = IIF(USED("cursor_4c_Arquivos"), ;
                             RECCOUNT("cursor_4c_Arquivos"), 0)
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Refresh()
        ENDIF
        MsgInfo("Lista atualizada. Arquivos dispon" + CHR(237) + "veis: " + ;
                TRANSFORM(loc_nRegistros), ;
                "Importa" + CHR(231) + CHR(227) + "o de Dados")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Adaptacao para form OPERACIONAL de importacao
    * No contexto de importacao de dados, "Excluir" corresponde a remover
    * fisicamente o arquivo TXT selecionado do diretorio de importacao
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cArquivo, loc_cValor, loc_lConfirma, loc_oErro
        IF !PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            RETURN
        ENDIF
        loc_cValor = ""
        IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            loc_cValor = ALLTRIM(THIS.obj_4c_Arquivos.Value)
        ENDIF
        IF EMPTY(loc_cValor)
            MsgAviso("Selecione um arquivo na lista antes de excluir.", ;
                     "Excluir arquivo")
            RETURN
        ENDIF
        loc_cArquivo = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
                       loc_cValor
        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo '" + loc_cValor + "' n" + CHR(227) + "o encontrado.", ;
                     "Excluir arquivo")
            RETURN
        ENDIF
        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do arquivo '" + ;
                                    loc_cValor + "'?", ;
                                    "Excluir arquivo")
        IF !loc_lConfirma
            RETURN
        ENDIF
        TRY
            SET SAFETY OFF
            DELETE FILE (loc_cArquivo)
            SET SAFETY ON
            IF FILE(loc_cArquivo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o arquivo.", ;
                        "Excluir arquivo")
            ELSE
                MsgInfo("Arquivo exclu" + CHR(237) + "do com sucesso.", ;
                        "Excluir arquivo")
                THIS.txt_4c_Arquivo.Value = ;
                    ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
                THIS.CarregarArquivos()
                THIS.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao excluir arquivo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do form visiveis
    * cmd_4c_Visualizar e cmd_4c_Imprimir ficam ocultos (legado: Visible=.F. no Init)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_oObjeto, loc_nJ, loc_oFilho
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) != "O"
                LOOP
            ENDIF
            *-- Manter ocultos: Visualizar e Imprimir (legado: Visible=.F.) e
            *-- cnt_4c_Sombra (form usa Picture de fundo; container nao exibido)
            IF INLIST(loc_oObjeto.Name, "cmd_4c_Visualizar", "cmd_4c_Imprimir", "cnt_4c_Sombra")
                *-- Tornar sub-controles visiveis mesmo com pai oculto
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    FOR loc_nJ = 1 TO loc_oObjeto.ControlCount
                        loc_oFilho = loc_oObjeto.Controls(loc_nJ)
                        IF VARTYPE(loc_oFilho) = "O" AND PEMSTATUS(loc_oFilho, "Visible", 5)
                            loc_oFilho.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
                LOOP
            ENDIF
            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF
            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
               loc_oObjeto.ControlCount > 0
                FOR loc_nJ = 1 TO loc_oObjeto.ControlCount
                    loc_oFilho = loc_oObjeto.Controls(loc_nJ)
                    IF VARTYPE(loc_oFilho) = "O" AND ;
                       PEMSTATUS(loc_oFilho, "Visible", 5)
                        loc_oFilho.Visible = .T.
                    ENDIF
                ENDFOR
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista / ConfigurarPaginaDados / AlternarPagina
    * Stubs de compatibilidade com pipeline multi-fase (OPERACIONAL sem paginas)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Atualiza lista de arquivos TXT do diretorio de importacao
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Encerra o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Para form OPERACIONAL de importacao, salvar = processar
    * Confirmacao exigida antes de disparar o processamento
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
                                    CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
                                    "Importa" + CHR(231) + CHR(227) + "o de Dados")
        IF loc_lConfirma
            THIS.BtnMovEstClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela/fecha o formulario
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormParaBO - Atualiza propriedades do BO com os dados selecionados no form
    * Para form OPERACIONAL, atualiza o arquivo selecionado na listbox
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_cArqSel
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5) AND ;
           VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
            loc_cArqSel = ALLTRIM(THIS.obj_4c_Arquivos.Value)
            IF !EMPTY(loc_cArqSel)
                THIS.this_oBusinessObject.this_cArquivoAtual = ;
                    ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + loc_cArqSel
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega dados do BO nos controles do form
    * Para form OPERACIONAL, exibe o diretorio de importacao no textbox
    *==========================================================================
    PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles interativos
    * par_lHabilitar: .T. para habilitar, .F. para desabilitar
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Enabled  = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta controles do form para estado inicial
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            THIS.txt_4c_Arquivo.Value = ;
                ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Value = ""
            THIS.obj_4c_Arquivos.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega cursor de arquivos TXT e vincula ao listbox
    * Retorna numero de arquivos encontrados
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_nRegistros
        loc_nRegistros = 0
        THIS.CarregarArquivos()
        IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            WITH THIS.obj_4c_Arquivos
                .RowSourceType = 6
                .RowSource     = "cursor_4c_Arquivos.cArquivo"
                .Refresh()
            ENDWITH
            loc_nRegistros = RECCOUNT("cursor_4c_Arquivos")
        ENDIF
        RETURN loc_nRegistros
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado atual
    * BtnMovEst fica habilitado somente se houver arquivos na lista
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemArquivos
        loc_lTemArquivos = USED("cursor_4c_Arquivos") AND ;
                           RECCOUNT("cursor_4c_Arquivos") > 0
        IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
            THIS.cmd_4c_BtnMovEst.Enabled = loc_lTemArquivos
        ENDIF
        IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
            THIS.obj_4c_Arquivos.Enabled  = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Enabled   = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Arquivos")
            USE IN cursor_4c_Arquivos
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
