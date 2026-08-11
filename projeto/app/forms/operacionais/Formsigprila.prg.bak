*==============================================================================
* Formsigprila.prg - Importacao de Planilha (XLS) para o sistema
*
* Tipo: OPERACIONAL - layout flat customizado (sem PageFrame)
* Migrado de: SIGPRILA.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (800x350, container planilha + botoes)
*   BD   -> SigPrTam, SigMvCab, SigMvItn, SigCdLpc, SigCdLpi via SQLEXEC
*   CODE -> arquitetura em camadas (FormBase / sigprilaBO)
*==============================================================================

DEFINE CLASS Formsigprila AS FormBase

    *-- Dimensoes e aparencia (identico ao legado)
    Height       = 350
    Width        = 800
    AutoCenter   = .T.
    BorderStyle  = 2
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    KeyPreview   = .T.
    DataSession  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    PROCEDURE Init
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame
    *==========================================================================
        LOCAL loc_cImgFundo
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprilaBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprilaBO.", "Erro")
            ELSE
                THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Planilha"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption  = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis()

                IF !THIS.this_oBusinessObject.InicializarParametros()
                    MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
                ENDIF
                THIS.PreencherCombo()

                THIS.ConfigurarBINDEVENTs()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Formsigprila: " + loc_oErro.Message + ;
                " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                " Proc=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho
    *==========================================================================
        LOCAL loc_nW, loc_cCaption
        loc_nW      = THIS.Width
        loc_cCaption = THIS.Caption

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = loc_nW
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 40
                .Top       = 18
                .Left      = 10
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Width     = loc_nW
                .Height    = 46
                .Top       = 17
                .Left      = 10
                .Caption   = loc_cCaption
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
            ENDWITH
        ENDWITH
        THIS.cnt_4c_Cabecalho.Visible = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPainelPlanilha
    *==========================================================================
        THIS.AddObject("cnt_4c_Planilha", "Container")
        WITH THIS.cnt_4c_Planilha
            .Top          = 96
            .Left         = 167
            .Width        = 466
            .Height       = 221
            .BackStyle    = 0
            .BorderWidth  = 0
            .SpecialEffect = 0

            *-- Label Tipo:
            .AddObject("lbl_4c_Say3", "Label")
            WITH .lbl_4c_Say3
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Tipo:"
                .Height    = 15
                .Left      = 54
                .Top       = 15
                .Width     = 29
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- ComboBox tipos de importacao
            .AddObject("cbo_4c_CmbTipos", "ComboBox")
            WITH .cbo_4c_CmbTipos
                .FontName       = "Tahoma"
                .FontSize       = 8
                .ColumnCount    = 1
                .ColumnWidths   = "100"
                .RowSourceType  = 6
                .RowSource      = ""
                .FirstElement   = 1
                .Height         = 23
                .Left           = 85
                .Style          = 2
                .Top            = 12
                .Width          = 187
                .ForeColor      = RGB(0, 0, 0)
            ENDWITH

            *-- Label Planilha:
            .AddObject("lbl_4c_Say4", "Label")
            WITH .lbl_4c_Say4
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Planilha:"
                .Height    = 15
                .Left      = 34
                .Top       = 40
                .Width     = 49
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox caminho do arquivo XLS (somente leitura)
            .AddObject("txt_4c_Planilha", "TextBox")
            WITH .txt_4c_Planilha
                .FontName            = "Tahoma"
                .FontSize            = 8
                .ControlSource       = ""
                .Enabled             = .F.
                .Height              = 23
                .Left                = 85
                .MaxLength           = 0
                .ReadOnly            = .T.
                .Top                 = 37
                .Width               = 336
                .ForeColor           = RGB(0, 0, 0)
                .DisabledBackColor   = RGB(255, 255, 255)
            ENDWITH

            *-- Botao abrir arquivo XLS
            .AddObject("cmd_4c_Cmdgetp", "CommandButton")
            WITH .cmd_4c_Cmdgetp
                .Top         = 36
                .Left        = 423
                .Height      = 25
                .Width       = 36
                .FontName    = "Verdana"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "a_fold1.bmp"
                .Caption     = ""
                .ForeColor   = RGB(36, 84, 155)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .T.
                .DisabledPicture = gc_4c_CaminhoIcones + "a_fold1.bmp"
            ENDWITH

            *-- Label Ordem das Colunas na Planilha:
            .AddObject("lbl_4c_Say1", "Label")
            WITH .lbl_4c_Say1
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Ordem das Colunas na Planilha:"
                .Height    = 15
                .Left      = 85
                .Top       = 63
                .Width     = 177
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- ListBox de colunas (drag-to-reorder)
            .AddObject("obj_4c_List1", "ListBox")
            WITH .obj_4c_List1
                .FontName         = "Tahoma"
                .FontSize         = 8
                .BoundColumn      = 2
                .ColumnCount      = 2
                .ColumnWidths     = "172,70"
                .RowSourceType    = 1
                .RowSource        = ""
                .FirstElement     = 1
                .Height           = 124
                .Left             = 82
                .MoverBars        = .T.
                .SpecialEffect    = 0
                .Top              = 78
                .Width            = 191
            ENDWITH

            *-- Label Validar: (oculto por padrao - visivel para TRANSFERENCIA etc)
            .AddObject("lbl_4c_Say5", "Label")
            WITH .lbl_4c_Say5
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Validar :"
                .Height    = 15
                .Left      = 290
                .Top       = 82
                .Width     = 47
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            *-- OptionGroup tipo de validacao (Codigo / Descritivo / Referencia Forn.)
            .AddObject("obj_4c_OptTipo", "OptionGroup")
            WITH .obj_4c_OptTipo
                .AutoSize    = .F.
                .ButtonCount = 3
                .BackStyle   = 0
                .Value       = 1
                .Height      = 65
                .Left        = 335
                .Top         = 80
                .Width       = 123
                .Themes      = .T.
                .Visible     = .F.

                WITH .Buttons(1)
                    .Caption   = "C" + CHR(243) + "digo"
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 51
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Descritivo"
                    .Height    = 15
                    .Left      = 5
                    .Top       = 22
                    .Width     = 65
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Caption   = "Refer" + CHR(234) + "ncia Forn."
                    .Height    = 15
                    .Left      = 5
                    .Top       = 41
                    .Width     = 99
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label Preco: (oculto por padrao - visivel para PEDIDO tipos)
            .AddObject("lbl_4c_Say6", "Label")
            WITH .lbl_4c_Say6
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Pre" + CHR(231) + "o :"
                .Height    = 15
                .Left      = 297
                .Top       = 142
                .Width     = 40
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            *-- OptionGroup tipo de preco (Venda / Custo)
            .AddObject("obj_4c_OptPreco", "OptionGroup")
            WITH .obj_4c_OptPreco
                .AutoSize    = .F.
                .ButtonCount = 2
                .BackStyle   = 0
                .Value       = 1
                .Height      = 44
                .Left        = 335
                .Top         = 140
                .Width       = 123
                .Themes      = .T.
                .Visible     = .F.

                WITH .Buttons(1)
                    .Caption   = "Venda"
                    .Height    = 15
                    .Left      = 5
                    .Top       = 5
                    .Width     = 48
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Caption   = "Custo"
                    .Height    = 15
                    .Left      = 5
                    .Top       = 22
                    .Width     = 46
                    .AutoSize  = .T.
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *-- Label Clique e Arraste para Mudar
            .AddObject("lbl_4c_Say2", "Label")
            WITH .lbl_4c_Say2
                .AutoSize  = .T.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Clique e Arraste para Mudar"
                .Height    = 15
                .Left      = 83
                .Top       = 204
                .Width     = 160
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- Checkbox Cabecalho na 1a Linha
            .AddObject("chk_4c_Cabecalho", "CheckBox")
            WITH .chk_4c_Cabecalho
                .Top         = 204
                .Left        = 289
                .Height      = 15
                .Width       = 142
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .AutoSize    = .T.
                .Alignment   = 0
                .BackStyle   = 0
                .Caption     = "Cabe" + CHR(231) + "alho na 1" + CHR(170) + " Linha"
                .Value       = 0
                .ForeColor   = RGB(90, 90, 90)
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes
    *==========================================================================
        *-- Botao Processar (Command1 do legado: Left=650, Top=3)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 650
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH

        *-- Botao Encerrar (Command2 do legado: Left=725, Top=3)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 725
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .WordWrap        = .T.
            .MousePointer    = 15
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Monta o painel de entrada (equivalente logico da
    * Page1 Lista do pipeline CRUD). Formsigprila e OPERACIONAL (layout flat
    * 800x350 sem PageFrame): agrupa combo de tipo, textbox do arquivo,
    * listbox de colunas, option groups de validacao/preco e checkbox de
    * cabecalho no container cnt_4c_Planilha.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista
        THIS.ConfigurarPainelPlanilha()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Monta a area de acoes sobre os dados de entrada
    * (equivalente logico da Page2 Dados do pipeline CRUD). Em Formsigprila
    * corresponde aos botoes que operam sobre o painel configurado por
    * ConfigurarPaginaLista: Processar (executa a importacao SQLEXEC/INSERT)
    * e Encerrar (fecha o formulario). Separado por semantica list-vs-action.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados
        THIS.ConfigurarBotoes()
    ENDPROC

    *==========================================================================
    * AlternarPagina - Reinicia o fluxo de importacao para uma nova operacao.
    * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1"
    * equivale a limpar todos os campos de entrada, fechar cursores de
    * processamento anterior e reposicionar o foco no combo de tipos.
    * Chamado apos concluir uma importacao (Processar) para preparar o form
    * para importar outra planilha sem precisar recriar controles.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_oErro

        TRY
            *-- Limpa selecao de tipo e arquivo
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
                THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
                THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = ""
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "chk_4c_Cabecalho", 5)
                THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 0
            ENDIF

            *-- Limpa lista de colunas e restaura defaults dos option groups
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_List1", 5)
                THIS.cnt_4c_Planilha.obj_4c_List1.RowSource = ""
                THIS.cnt_4c_Planilha.obj_4c_List1.Clear()
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptTipo", 5)
                THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = 1
                THIS.cnt_4c_Planilha.obj_4c_OptTipo.Visible = .F.
                THIS.cnt_4c_Planilha.lbl_4c_Say5.Visible    = .F.
            ENDIF
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptPreco", 5)
                THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value  = 1
                THIS.cnt_4c_Planilha.obj_4c_OptPreco.Visible = .F.
                THIS.cnt_4c_Planilha.lbl_4c_Say6.Visible     = .F.
            ENDIF

            *-- Descarta cursores de processamento anterior para nova importacao
            IF USED("TmpPlanilha")
                USE IN TmpPlanilha
            ENDIF
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
            IF USED("csPrSemCT")
                USE IN csPrSemCT
            ENDIF
            IF USED("crNomeLista")
                USE IN crNomeLista
            ENDIF

            *-- Reposiciona foco no combo de tipos para nova operacao
            IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
                THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
                " Proc=" + loc_oErro.Procedure, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs
    *==========================================================================
        BINDEVENT(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos, "InteractiveChange", ;
            THIS, "CmbTiposInteractiveChange")
        BINDEVENT(THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp, "Click", ;
            THIS, "CmdgetpClick")
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdokClick")
        BINDEVENT(THIS.cmd_4c_Encerrar, "Click",  THIS, "CmdsairClick")
        BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente.
    * Controles condicionais (OPT/LBL de tipo/preco) sao filtrados: ficam
    * com Visible=.F. e sao ativados apenas em CmbTiposInteractiveChange.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_oContainer, loc_i, loc_oControl, loc_cBase, loc_cNome

        IF VARTYPE(par_oContainer) = "O"
            loc_oContainer = par_oContainer
        ELSE
            loc_oContainer = THIS
        ENDIF

        IF VARTYPE(loc_oContainer) # "O"
            RETURN
        ENDIF
        IF VARTYPE(loc_oContainer.ControlCount) # "N"
            RETURN
        ENDIF

        FOR loc_i = 1 TO loc_oContainer.ControlCount
            loc_oControl = loc_oContainer.Controls(loc_i)
            loc_cBase    = LOWER(loc_oControl.BaseClass)
            loc_cNome    = UPPER(loc_oControl.Name)

            *-- Controles condicionais ou com Visible gerenciado externamente preservam estado
            IF INLIST(loc_cNome, "OBJ_4C_OPTTIPO", "OBJ_4C_OPTPRECO", ;
                    "LBL_4C_SAY5", "LBL_4C_SAY6", "CNT_4C_CABECALHO")
                *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF INLIST(loc_cBase, "container", "commandgroup")
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
            loc_oControl.Visible = .T.
        ENDFOR
    ENDPROC

    *==========================================================================
    * PreencherCombo - Popula cbo_4c_CmbTipos com os tipos de importacao
    *==========================================================================
    PROCEDURE PreencherCombo()
        THIS.this_oBusinessObject.PreencherTipos()
        WITH THIS.cnt_4c_Planilha.cbo_4c_CmbTipos
            .RowSourceType = 6
            .RowSource     = "ComboTipo.Titulo"
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmbTiposInteractiveChange - Atualiza lista de colunas e visibilidade
    *==========================================================================
    PROCEDURE CmbTiposInteractiveChange()
        LOCAL loc_cColunaLi, loc_cTitulo, loc_lVisOpt, loc_lVisPreco

        IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
            RETURN
        ENDIF

        loc_cColunaLi = THIS.this_oBusinessObject.CompletarLista("")
        loc_cTitulo   = ""
        IF USED("ComboTipo") AND !EOF("ComboTipo")
            loc_cTitulo = ALLTRIM(ComboTipo.Titulo)
        ENDIF
        loc_lVisOpt   = THIS.this_oBusinessObject.ObterVisibilidadeTipo(loc_cTitulo)
        loc_lVisPreco = THIS.this_oBusinessObject.ObterVisibilidadePreco(loc_cTitulo)

        WITH THIS.cnt_4c_Planilha
            .obj_4c_List1.RowSource = loc_cColunaLi
            .lbl_4c_Say5.Visible    = loc_lVisOpt
            .obj_4c_OptTipo.Visible = loc_lVisOpt
            .lbl_4c_Say6.Visible    = loc_lVisPreco
            .obj_4c_OptPreco.Visible = loc_lVisPreco
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmdgetpClick - Abre dialogo para selecionar arquivo XLS
    *==========================================================================
    PROCEDURE CmdgetpClick()
        LOCAL loc_cArq
        loc_cArq = GETFILE("xls", "Planilha", "Importar")
        IF !EMPTY(loc_cArq)
            THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = loc_cArq
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdokClick - Delega para BtnIncluirClick (padrao pipeline OPERACIONAL)
    *==========================================================================
    PROCEDURE CmdokClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Executa a importacao da planilha XLS para o sistema.
    * Em Formsigprila "Incluir" = processar/importar os dados da planilha.
    * Apos importacao bem-sucedida reseta o form para nova operacao.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cArquivo, loc_cRotina, loc_nTipo, loc_nPreco, loc_lCabecalho
        LOCAL loc_lResultado

        IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
            MsgAviso("Tipo Inv" + CHR(225) + "lido")
            THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
            RETURN
        ENDIF

        loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
        IF EMPTY(loc_cArquivo)
            MsgAviso("Arquivo Inv" + CHR(225) + "lido")
            THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
            RETURN
        ENDIF

        loc_nTipo      = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
        loc_nPreco     = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
        loc_lCabecalho = (THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 1)

        loc_cRotina = ""
        IF USED("ComboTipo") AND !EOF("ComboTipo")
            SELECT ComboTipo
            loc_cRotina = ALLTRIM(ComboTipo.Rotina)
        ENDIF

        loc_lResultado = THIS.this_oBusinessObject.Processamento( ;
            loc_nTipo, loc_nPreco, loc_cRotina, loc_cArquivo, ;
            loc_lCabecalho, THIS.cnt_4c_Planilha.obj_4c_List1)

        IF loc_lResultado
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reaproveita o fluxo de importacao (BtnIncluirClick).
    * Importacao e sempre substituicao/idempotente -- nao ha distincao entre
    * "novo" e "re-processar" para este formulario de entrada de dados.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Valida a configuracao sem importar dados.
    * Verifica tipo selecionado, existencia do arquivo e rotina reconhecida;
    * reposiciona foco no campo invalido ou exibe confirmacao de configuracao
    * valida. Semantica nao-destrutiva (nenhum dado e gravado no banco).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cArquivo, loc_cRotina, loc_cTipoSel

        loc_cTipoSel = ALLTRIM(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
        IF EMPTY(loc_cTipoSel)
            MsgAviso("Selecione o tipo de importa" + CHR(231) + CHR(227) + "o antes de visualizar.")
            THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
            RETURN
        ENDIF

        loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
        IF EMPTY(loc_cArquivo)
            MsgAviso("Selecione o arquivo de planilha antes de visualizar.")
            THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
            RETURN
        ENDIF

        IF !FILE(loc_cArquivo)
            MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo)
            THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
            RETURN
        ENDIF

        loc_cRotina = ""
        IF USED("ComboTipo") AND !EOF("ComboTipo")
            SELECT ComboTipo
            loc_cRotina = ALLTRIM(ComboTipo.Rotina)
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarColunas(loc_cRotina)
            MsgAviso("Rotina '" + loc_cRotina + "' n" + CHR(227) + "o reconhecida para o tipo selecionado.")
            RETURN
        ENDIF

        MsgInfo("Configura" + CHR(231) + CHR(227) + "o v" + CHR(225) + "lida." + CHR(13) + ;
            "Tipo: " + loc_cTipoSel + CHR(13) + ;
            "Arquivo: " + loc_cArquivo)
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Descarta as selecoes atuais e reinicia o fluxo.
    * Semantica "excluir" = limpar tipo, arquivo e colunas para comecar nova
    * importacao sem fechar o formulario. Solicita confirmacao antes de limpar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais" + CHR(13) + ;
                "e iniciar nova importa" + CHR(231) + CHR(227) + "o?")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdsairClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdsairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * FormKeyPress - ESC fecha o formulario
    *==========================================================================
    PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.CmdsairClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre dialogo de selecao de arquivo XLS (planilha)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CmdgetpClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdsairClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Executa a importacao (sinonimo de Processar)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao atual e limpa os campos
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere estado do form para o Business Object
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_nTipoImport = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
            .this_nTipoPreco  = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere estado do Business Object para o form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = THIS.this_oBusinessObject.this_nTipoImport
        THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value = THIS.this_oBusinessObject.this_nTipoPreco
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita controles de entrada.
    * cmd_4c_Cmdgetp tem Caption="" (icone-only) - nao recebe .Enabled conforme
    * regra de standalone icon-only buttons.
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        WITH THIS.cnt_4c_Planilha
            .cbo_4c_CmbTipos.Enabled  = loc_lHab
            .chk_4c_Cabecalho.Enabled = loc_lHab
            .Visible     = .T.
        ENDWITH

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de entrada e cursores temporarios
    *==========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oErro
        TRY
            WITH THIS.cnt_4c_Planilha
                .cbo_4c_CmbTipos.Value   = ""
                .txt_4c_Planilha.Value   = ""
                .chk_4c_Cabecalho.Value  = 0
                .obj_4c_List1.RowSource  = ""
                .obj_4c_List1.Clear()
                .obj_4c_OptTipo.Value    = 1
                .obj_4c_OptTipo.Visible  = .F.
                .lbl_4c_Say5.Visible     = .F.
                .obj_4c_OptPreco.Value   = 1
                .obj_4c_OptPreco.Visible = .F.
                .lbl_4c_Say6.Visible     = .F.
            ENDWITH

            IF USED("TmpPlanilha")
                USE IN TmpPlanilha
            ENDIF
            IF USED("csPrNAOCad")
                USE IN csPrNAOCad
            ENDIF
            IF USED("csPrSemCT")
                USE IN csPrSemCT
            ENDIF
            IF USED("crNomeLista")
                USE IN crNomeLista
            ENDIF

            IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
                THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Recarrega o combo de tipos de importacao disponiveis
    *==========================================================================
    PROCEDURE CarregarLista()
        THIS.PreencherCombo()
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita cmd_4c_Processar somente quando tipo
    * e arquivo estao preenchidos. Formsigprila nao tem modos CRUD; "modo"
    * aqui equivale ao estado de preenchimento dos campos obrigatorios.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTipoOk, loc_lArqOk
        loc_lTipoOk = .F.
        loc_lArqOk  = .F.

        IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
            loc_lTipoOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
        ENDIF
        IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
            loc_lArqOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
        ENDIF

        IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
            THIS.cmd_4c_Processar.Enabled = (loc_lTipoOk AND loc_lArqOk)
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy
    *==========================================================================
        *-- Cursores de configuracao
        IF USED("ComboTipo")
            USE IN ComboTipo
        ENDIF
        *-- Cursores de processamento de planilha
        IF USED("TmpPlanilha")
            USE IN TmpPlanilha
        ENDIF
        IF USED("TmpCot")
            USE IN TmpCot
        ENDIF
        *-- Cursores de moeda carregados em InicializarParametros
        IF USED("crSigCdMoe")
            USE IN crSigCdMoe
        ENDIF
        IF USED("crSigCdCot")
            USE IN crSigCdCot
        ENDIF
        *-- Cursores de erros de importacao
        IF USED("csPrNAOCad")
            USE IN csPrNAOCad
        ENDIF
        IF USED("csPrSemCT")
            USE IN csPrSemCT
        ENDIF
        IF USED("crNomeLista")
            USE IN crNomeLista
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
