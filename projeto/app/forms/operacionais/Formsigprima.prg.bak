*==============================================================================
* Formsigprima.prg
* Formulario: Importacao de Imagens de Produtos
* Tipo: OPERACIONAL (flat - sem PageFrame)
* Migrado de SIGPRIMA.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (Width=800, Height=200)
*   BD   -> SigCdPro / SigCdPrc / sigscjim
*   CODE -> arquitetura em camadas (FormBase / sigprimaBO)
*==============================================================================

DEFINE CLASS Formsigprima AS FormBase

    *-- Propriedades visuais (copiadas do SCX original)
    Height      = 200
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    ShowTips    = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    DataSession = 2
    Picture     = "..\framework\imagens\new_background.jpg"

    *-- Propriedades do form
    this_cMensagemErro = ""
    this_cTipo1        = ""   && modo de execucao: 'A'=automatico, ''=manual
    this_cPath1        = ""   && caminho do diretorio de imagens
    this_lModoAuto     = .F.  && .T. quando lcTipo1 == 'A'

    *==========================================================================
    * Init - Aceita parametros do chamador (lcTipo1, lcPath1)
    * Em modo automatico ('A'): executa processamento e fecha sem exibir form
    *==========================================================================
    PROCEDURE Init(par_cTipo1, par_cPath1)
        LOCAL loc_lSucesso

        *-- Armazenar parametros antes do DODEFAULT
        THIS.this_cTipo1    = UPPER(ALLTRIM(IIF(VARTYPE(par_cTipo1) = "C", par_cTipo1, "")))
        THIS.this_cPath1    = ADDBS(ALLTRIM(IIF(VARTYPE(par_cPath1) = "C", par_cPath1, "")))
        THIS.this_lModoAuto = (THIS.this_cTipo1 == "A")

        *-- Em modo automatico, validar diretorio antes de criar form
        IF THIS.this_lModoAuto AND !EMPTY(THIS.this_cPath1)
            IF !DIRECTORY(THIS.this_cPath1)
                MsgAviso("Diret" + CHR(243) + "rio de Importa" + CHR(231) + CHR(227) + ;
                         "o de Imagens Inv" + CHR(225) + "lido", "Pasta")
                RETURN .F.
            ENDIF
        ENDIF

        *-- Inicializar Business Object
        THIS.this_oBusinessObject = CREATEOBJECT("sigprimaBO")
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("Erro ao criar sigprimaBO.", "Erro")
            RETURN .F.
        ENDIF

        *-- FormBase.Init() -> InicializarForm()
        loc_lSucesso = DODEFAULT()
        IF !loc_lSucesso
            RETURN .F.
        ENDIF

        *-- Definir diretorio inicial no campo (criado em fase posterior)
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
            IF VARTYPE(THIS.txt_4c_Arquivo) = "O"
                THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
            ENDIF
        ENDIF

        *-- Modo automatico: executar processamento e fechar sem exibir form
        IF THIS.this_lModoAuto
            THIS.this_oBusinessObject.Processamento(THIS.this_cPath1, 1)
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura controles da interface
    *==========================================================================
    PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCabecalho()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            THIS.TornarControlesVisiveis()

            *-- Selecionar tipo padrao (Produtos) equivalente ao SCX original
            THIS.AlternarPagina(1)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar form: " + loc_oErro.Message + ;
                    " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    " | Proc: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Ajusta imagem de fundo do Form
    * OPERACIONAL flat: sem PageFrame; mantido por consistencia com FormBase
    * e demais forms operacionais (Formsigprila/Formsigprico/FormSIGPRIFF)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Container cinza escuro com labels de titulo
    * Equivalente ao cntSombra do SCX original (Top=0, Height=80)
    *==========================================================================
    PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_cCaption
        loc_cCaption = "Importa" + CHR(231) + CHR(227) + "o de Imagens de Produtos"

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top        = 0
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 80
            .BorderWidth = 0
            .BackColor  = RGB(100,100,100)
            .Visible    = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
            WITH .lbl_4c_LblSombra
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = THIS.Width
                .ForeColor     = RGB(0,0,0)
                .Visible       = .T.
            ENDWITH

            .AddObject("lbl_4c_LblTitulo", "Label")
            WITH .lbl_4c_LblTitulo
                .AutoSize      = .F.
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .Caption       = loc_cCaption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width
                .ForeColor     = RGB(255,255,255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Formul" + CHR(225) + "rio"
                .Visible       = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do form visiveis
    * (AddObject cria controles com Visible=.F. por padrao)
    *==========================================================================
    PROCEDURE TornarControlesVisiveis()
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO THIS.ControlCount
            loc_oObjeto = THIS.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_nI, loc_oObjeto
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
                   loc_oObjeto.ControlCount > 0
                    THIS.TornarSubControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura o corpo do form (area operacional)
    *
    * OPERACIONAL flat: nao ha PageFrame; a "pagina lista" corresponde a
    * toda a area do form abaixo do cabecalho, onde ficam:
    *   - Botoes de acao (Processar / Encerrar) - lado direito
    *   - Campos de parametros (Diretorio, Tipo de importacao)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampos()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Adiciona container decorativo de agrupamento
    * Equivalente ao Commandgroup3 do legado (ButtonCount=0, apenas visual):
    * borda de agrupamento ao redor dos botoes Processar/Encerrar.
    * Left=612, Top=7, Width=173, Height=110 / SpecialEffect=1 / ZOrder=1 (atras).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.AddObject("obj_4c_Commandgroup3", "Container")
        WITH THIS.obj_4c_Commandgroup3
            .Top          = 7
            .Left         = 612
            .Width        = 173
            .Height       = 110
            .BackStyle    = 0
            .BorderWidth  = 1
            .SpecialEffect = 1
            .BorderColor  = RGB(136,189,188)
            .Visible      = .T.
        ENDWITH
        *-- Enviar para tras dos botoes (cosm?tico - nao interfere em eventos)
        THIS.obj_4c_Commandgroup3.ZOrder(1)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o modo/tipo de importacao selecionado
    *
    * OPERACIONAL flat: nao ha paginas para alternar. Neste form, "alternar"
    * corresponde a selecionar um dos 3 tipos de importacao no OptionGroup:
    *   1 = Produtos, 2 = Auxiliar, 3 = Exportar
    * (equivalente semantico ao switch de pagina em forms CRUD)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nTipo)
        IF VARTYPE(par_nTipo) = "N" AND BETWEEN(par_nTipo, 1, 3)
            IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND ;
               VARTYPE(THIS.obj_4c_OptTipo) = "O"
                THIS.obj_4c_OptTipo.Value = par_nTipo
                THIS.obj_4c_OptTipo.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Adiciona botoes de acao (Processar e Encerrar)
    * Posicionados na area direita do cabecalho (Top=3), identicos ao legado
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Processar (equivalente ao btnProcessar fwbtng do legado)
        THIS.AddObject("cmd_4c_BtnProcessar", "CommandButton")
        WITH THIS.cmd_4c_BtnProcessar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (equivalente ao btnSair fwbtng do legado)
        THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
        WITH THIS.cmd_4c_BtnSair
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Cancel          = .T.
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "CmdBtnProcessarClick")
        BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "CmdBtnSairClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Adiciona campos operacionais: label, textbox diretorio,
    * botao browse "...", label tipo e OptionGroup de tipo de importacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        *-- Label "Diretorio :"
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Diret" + CHR(243) + "rio :"
            .Height    = 15
            .Left      = 156
            .Top       = 113
            .Width     = 58
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox para o caminho do diretorio de imagens
        THIS.AddObject("txt_4c_Arquivo", "TextBox")
        WITH THIS.txt_4c_Arquivo
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Height        = 21
            .Left          = 216
            .SpecialEffect = 1
            .TabIndex      = 2
            .Top           = 110
            .Width         = 402
            .ForeColor     = RGB(0,0,0)
            .Visible       = .T.
        ENDWITH

        *-- Botao "..." para navegar e selecionar diretorio
        THIS.AddObject("cmd_4c_BtnArquivo", "CommandButton")
        WITH THIS.cmd_4c_BtnArquivo
            .Top       = 110
            .Left      = 622
            .Height    = 21
            .Width     = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .WordWrap  = .T.
            .Caption   = "..."
            .TabIndex  = 3
            .BackColor = RGB(255,255,255)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Tipo :"
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize  = .T.
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Tipo :"
            .Height    = 15
            .Left      = 182
            .Top       = 135
            .Width     = 32
            .ForeColor = RGB(90,90,90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup para tipo de importacao (Produtos / Auxiliar / Exportar)
        THIS.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH THIS.obj_4c_OptTipo
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Height      = 63
            .Left        = 216
            .Top         = 129
            .Width       = 92
            .Visible     = .T.

            WITH .Buttons(1)
                .FontBold      = .T.
                .FontUnderline = .F.
                .BackStyle     = 0
                .Caption       = "Produtos"
                .Height        = 15
                .Left          = 5
                .Top           = 5
                .Width         = 69
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(2)
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .F.
                .BackStyle     = 0
                .Caption       = "Auxiliar"
                .Height        = 15
                .Left          = 5
                .Top           = 24
                .Width         = 61
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
            ENDWITH

            WITH .Buttons(3)
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontUnderline = .F.
                .BackStyle     = 0
                .Caption       = "Exportar"
                .Height        = 15
                .Left          = 5
                .Top           = 44
                .Width         = 67
                .AutoSize      = .T.
                .ForeColor     = RGB(90,90,90)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmd_4c_BtnArquivo, "Click",    THIS, "CmdBtnArquivoClick")
        BINDEVENT(THIS.txt_4c_Arquivo,    "KeyPress", THIS, "TxtArquivoKeyPress")
    ENDPROC

    *==========================================================================
    * CmdBtnArquivoClick - Abre dialogo GetDir para selecionar diretorio
    *==========================================================================
    PROCEDURE CmdBtnArquivoClick()
        LOCAL loc_cDir
        THIS.txt_4c_Arquivo.Value = ""
        loc_cDir = GETDIR("C:\", ;
                          "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
                          "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
        IF !EMPTY(loc_cDir)
            THIS.txt_4c_Arquivo.Value = loc_cDir
        ENDIF
        THIS.txt_4c_Arquivo.Refresh()
    ENDPROC

    *==========================================================================
    * CmdBtnProcessarClick - Executa Exportar (tipo=3) ou Processamento (tipos 1/2)
    *==========================================================================
    PROCEDURE CmdBtnProcessarClick()
        LOCAL loc_cDir, loc_nTipo
        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdBtnSairClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdBtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtArquivoKeyPress - Valida/corrige diretorio ao pressionar ENTER ou TAB
    *==========================================================================
    PROCEDURE TxtArquivoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF
        LOCAL loc_cDir
        loc_cDir = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        IF !EMPTY(loc_cDir) AND !DIRECTORY(loc_cDir)
            loc_cDir = GETDIR("C:\", ;
                              "Selecione o Diret" + CHR(243) + "rio Abaixo :", ;
                              "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rio de Imagens")
        ENDIF
        THIS.txt_4c_Arquivo.Value = loc_cDir
        THIS.txt_4c_Arquivo.Refresh()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Executa importacao (equivalente a "incluir" imagens)
    * Mapeamento semantico OPERACIONAL: Incluir = importar novas imagens
    * Valida diretorio e tipo, entao dispara Exportar (tipo 3) ou Processamento
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cDir, loc_nTipo

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Re-processa importacao (mesmo fluxo do Incluir).
    * Form OPERACIONAL de importacao nao possui distincao entre inserir e
    * alterar - reprocessa as imagens do diretorio informado.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Valida configuracao sem executar importacao
    * Conta arquivos JPG no diretorio informado e exibe resumo para o usuario
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDir, loc_nTipo, loc_cTipoDesc, loc_nArquivos
        LOCAL ARRAY loc_aArq(1)

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        loc_nArquivos = ADIR(loc_aArq, ADDBS(loc_cDir) + "*.JPG")
        loc_cTipoDesc = ICASE(loc_nTipo = 1, "Produtos", ;
                              loc_nTipo = 2, "Auxiliar", ;
                              loc_nTipo = 3, "Exportar", ;
                              "Desconhecido")

        MsgInfo("Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + ;
                "Tipo: " + loc_cTipoDesc + CHR(13) + ;
                "Arquivos .JPG encontrados: " + TRANSFORM(loc_nArquivos), ;
                "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa a configuracao atual (diretorio + tipo padrao)
    * Nao remove nenhum dado do banco - apenas reseta os campos da tela
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais?")
            THIS.txt_4c_Arquivo.Value = ""
            THIS.obj_4c_OptTipo.Value = 1
            THIS.txt_4c_Arquivo.Refresh()
            THIS.obj_4c_OptTipo.Refresh()
            THIS.txt_4c_Arquivo.SetFocus()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Valida configuracao antes de disparar (equivalente
    * semantico de "buscar" nesse form OPERACIONAL: pre-visualiza contagem
    * de arquivos .JPG no diretorio informado). Reusa BtnVisualizarClick.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (alias semantico de CmdBtnSairClick)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdBtnSairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma execucao (alias semantico de CmdBtnProcessarClick).
    * Sincroniza dados do form para o BO e dispara Exportar/Processamento.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_cDir, loc_nTipo

        THIS.FormParaBO()

        loc_cDir  = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        loc_nTipo = THIS.obj_4c_OptTipo.Value

        IF EMPTY(loc_cDir)
            MsgAviso("O Diret" + CHR(243) + "rio N" + CHR(227) + "o Foi Informado!!!", ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cDir)
            MsgAviso("Diret" + CHR(243) + "rio inexistente: " + loc_cDir, ;
                     "Diret" + CHR(243) + "rio Inv" + CHR(225) + "lido")
            THIS.txt_4c_Arquivo.SetFocus()
            RETURN
        ENDIF

        IF loc_nTipo = 3
            THIS.this_oBusinessObject.Exportar(loc_cDir)
        ELSE
            THIS.this_oBusinessObject.Processamento(loc_cDir, loc_nTipo)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao em andamento e limpa selecao atual
    * (reset dos campos + recarrega estado padrao). Nao fecha o formulario.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        THIS.CarregarLista()
        THIS.AjustarBotoesPorModo("LISTA")
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza valores dos controles da tela para o BO
    * Form OPERACIONAL: transfere diretorio e tipo de operacao selecionados
    *==========================================================================
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.this_oBusinessObject.this_cDiretorio = ALLTRIM(THIS.txt_4c_Arquivo.Value)
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.this_oBusinessObject.this_nTipoOp = THIS.obj_4c_OptTipo.Value
        ENDIF

        THIS.this_oBusinessObject.this_cTipo1 = THIS.this_cTipo1
        RETURN .T.
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza valores do BO para os controles da tela
    * Form OPERACIONAL: restaura diretorio e tipo do BO nos controles
    *==========================================================================
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cDiretorio
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            IF BETWEEN(THIS.this_oBusinessObject.this_nTipoOp, 1, 3)
                THIS.obj_4c_OptTipo.Value = THIS.this_oBusinessObject.this_nTipoOp
                THIS.obj_4c_OptTipo.Refresh()
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita controles editaveis do form
    * conforme o modo atual (LISTA/DADOS/INCLUIR/ALTERAR/VISUALIZAR)
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Enabled = loc_lHab
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_BtnArquivo", 5) AND VARTYPE(THIS.cmd_4c_BtnArquivo) = "O"
            THIS.cmd_4c_BtnArquivo.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Reseta os controles editaveis para valores default
    *==========================================================================
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            THIS.txt_4c_Arquivo.Value = ""
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Value = 1
            THIS.obj_4c_OptTipo.Refresh()
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cDiretorio = ""
            THIS.this_oBusinessObject.this_nTipoOp    = 1
            THIS.this_oBusinessObject.this_lSucesso   = .F.
            THIS.this_oBusinessObject.this_cMsgFinal  = ""
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Restaura o estado padrao dos campos operacionais
    * Form OPERACIONAL flat: nao ha grid de listagem; o metodo cumpre
    * o contrato semantico de "carregar estado inicial" pos-BtnCancelar
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5) AND VARTYPE(THIS.txt_4c_Arquivo) = "O"
            IF !EMPTY(THIS.this_cPath1)
                THIS.txt_4c_Arquivo.Value = THIS.this_cPath1
            ENDIF
            THIS.txt_4c_Arquivo.Refresh()
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_OptTipo", 5) AND VARTYPE(THIS.obj_4c_OptTipo) = "O"
            THIS.obj_4c_OptTipo.Refresh()
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta Enabled dos botoes conforme o modo atual
    * Form OPERACIONAL: apenas 2 botoes de acao (Processar/Encerrar) sempre
    * habilitados; metodo cumpre o contrato dos forms CRUD para consistencia
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo(par_cModo)
        LOCAL loc_cModo, loc_lEditavel
        loc_cModo = UPPER(ALLTRIM(IIF(VARTYPE(par_cModo) = "C", par_cModo, "LISTA")))
        loc_lEditavel = (loc_cModo != "VISUALIZAR")

        IF PEMSTATUS(THIS, "cmd_4c_BtnProcessar", 5) AND ;
           VARTYPE(THIS.cmd_4c_BtnProcessar) = "O"
            THIS.cmd_4c_BtnProcessar.Enabled = loc_lEditavel
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_BtnSair", 5) AND VARTYPE(THIS.cmd_4c_BtnSair) = "O"
            THIS.cmd_4c_BtnSair.Enabled = .T.
        ENDIF

        THIS.HabilitarCampos(loc_lEditavel)
    ENDPROC

    *==========================================================================
    * Unload - Chamado ao encerrar o form
    * Em modo automatico: limpa loop de eventos para scripts batch
    *==========================================================================
    PROCEDURE Unload()
        IF THIS.this_lModoAuto
            CLEAR EVENTS
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
