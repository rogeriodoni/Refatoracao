*==============================================================================
* FormSIGPREST.prg - Form Gerar Estrutura de Arquivos DBF
* Herdado de: FormBase
* Tipo: OPERACIONAL (dialogo utilitario - sem PageFrame)
*==============================================================================
DEFINE CLASS FormSIGPREST AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SIGPREST.SCX)
    Width       = 600
    Height      = 191
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado de exibicao de mensagem ao usuario
    this_cMensagem = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Aparencia base do dialogo (OPERACIONAL sem PageFrame)
    * Configura fundo, fontes e cor de base do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)

        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria Business Object e configura controles do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRESTBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object SIGPRESTBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container de cabecalho escuro com titulo do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top        = -1
            .Left       = -1
            .Width      = THIS.Width
            .Height     = 80
            .BackStyle  = 1
            .BackColor  = RGB(100,100,100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top          = 18
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 40
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .FontUnderline = .F.
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(0,0,0)
            .Caption      = "Gerar Estrutura"
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top          = 17
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 46
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(255,255,255)
            .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption      = "Gerar Estrutura"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Frame decorativo e botoes de acao do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()

        *-- Shape decorativo que agrupa os checkboxes visualmente
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 9
            .Left          = 49
            .Height        = 110
            .Width         = 173
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
        ENDWITH

        *-- Botao Gerar (cmd_4c_OK)
        THIS.AddObject("cmd_4c_OK", "CommandButton")
        WITH THIS.cmd_4c_OK
            .Top             = 3
            .Left            = 450
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_OK, "Click", THIS, "BtnOKClick")

        *-- Botao Encerrar (cmd_4c_Cancela)
        THIS.AddObject("cmd_4c_Cancela", "CommandButton")
        WITH THIS.cmd_4c_Cancela
            .Top             = 3
            .Left            = 525
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(THIS.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Campos de entrada do dialogo (checkboxes + status)
    * SIGPREST eh utilitario sem PageFrame, entao "Dados" aqui sao os controles
    * de entrada do usuario (opcoes de processamento) e a label de status.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()

        *-- Checkbox: Gerar Estrutura
        THIS.AddObject("chk_4c_GeraArquivos", "CheckBox")
        WITH THIS.chk_4c_GeraArquivos
            .Top        = 90
            .Left       = 55
            .Width      = 75
            .Height     = 75
            .Caption    = "Estrutura"
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 1
            .BackColor  = RGB(255,255,255)
            .ForeColor  = RGB(90,90,90)
            .Themes     = .F.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Style      = 1
            .Value      = 1
        ENDWITH

        *-- Checkbox: Gerar Indices
        THIS.AddObject("chk_4c_GeraIndices", "CheckBox")
        WITH THIS.chk_4c_GeraIndices
            .Top        = 90
            .Left       = 136
            .Width      = 75
            .Height     = 75
            .Caption    = CHR(205) + "ndice"
            .Picture    = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
            .FontBold   = .T.
            .FontItalic = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .Alignment  = 2
            .BackStyle  = 1
            .BackColor  = RGB(255,255,255)
            .ForeColor  = RGB(90,90,90)
            .Themes     = .F.
            .WordWrap   = .T.
            .AutoSize   = .F.
            .Style      = 1
            .Value      = 1
        ENDWITH

        *-- Label de status do processamento
        THIS.AddObject("lbl_4c_Mensagem1", "Label")
        WITH THIS.lbl_4c_Mensagem1
            .Top       = 132
            .Left      = 48
            .Width     = 480
            .Height    = 24
            .Caption   = ""
            .Alignment = 2
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 11
            .ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOKClick - Dispara geracao de estrutura de arquivos DBF e/ou indices
    *--------------------------------------------------------------------------
    PROCEDURE BtnOKClick()
        THIS.FormParaBO()
        THIS.HabilitarCampos(.F.)
        THIS.Refresh()

        THIS.this_oBusinessObject.GerarEstrutura( ;
            THIS.this_oBusinessObject.this_lGeraArquivos, ;
            THIS.this_oBusinessObject.this_lGeraIndices)

        THIS.BOParaForm()
        THIS.HabilitarCampos(.T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelaClick - Encerra o dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelaClick()
        THIS.this_oBusinessObject.CarregarLogoTipo()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao principal do dialogo OPERACIONAL
    * SIGPREST eh utilitario de geracao de estrutura (nao CRUD): a acao "Incluir"
    * do padrao CRUD mapeia para a acao unica do dialogo = disparar a geracao
    * de ArqDBF/ArqInd via THIS.BtnOKClick(). Mantido para compatibilidade com
    * o pipeline e para permitir integracao via menu/toolbar generico.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Re-executa a geracao (re-processa estrutura/indices)
    * Em um dialogo de utilitario, "Alterar" = re-rodar o processamento com as
    * opcoes correntes dos checkboxes (Estrutura/Indice). Delegacao explicita
    * para BtnOKClick que ja carrega o estado dos checkboxes e chama o BO.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa a geracao em modo somente-processamento
    * SIGPREST nao tem tela de "visualizacao de registro" (sem grid, sem lista):
    * a unica saida visivel eh a label de status atualizada via GerarEstrutura.
    * Delega para BtnOKClick que executa o processo e atualiza a mensagem.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o dialogo (equivale a cancelar/fechar)
    * Em um utilitario one-shot, "Excluir" nao remove registros (nao ha
    * entidade persistida); mapeia para o fluxo de saida do dialogo, que
    * garante fechamento de tabelas e recarga do logo via CarregarLogoTipo.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa a geracao de estrutura (sinonimo de BtnOKClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o dialogo (sinonimo de BtnCancelaClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Sem lista neste dialogo; compatibilidade com pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnOKClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Encerra o dialogo
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere opcoes dos checkboxes para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.this_oBusinessObject.this_lGeraArquivos = (THIS.chk_4c_GeraArquivos.Value = 1)
        THIS.this_oBusinessObject.this_lGeraIndices  = (THIS.chk_4c_GeraIndices.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza controles do dialogo com estado do Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.chk_4c_GeraArquivos.Value = IIF(THIS.this_oBusinessObject.this_lGeraArquivos, 1, 0)
        THIS.chk_4c_GeraIndices.Value  = IIF(THIS.this_oBusinessObject.this_lGeraIndices, 1, 0)
        THIS.lbl_4c_Mensagem1.Caption  = THIS.this_oBusinessObject.this_cMensagem
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de entrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        THIS.chk_4c_GeraArquivos.Enabled = par_lHabilitar
        THIS.chk_4c_GeraIndices.Enabled  = par_lHabilitar
        THIS.cmd_4c_OK.Enabled           = par_lHabilitar
        THIS.cmd_4c_Cancela.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura controles para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.chk_4c_GeraArquivos.Value = 1
        THIS.chk_4c_GeraIndices.Value  = 1
        THIS.lbl_4c_Mensagem1.Caption  = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a este dialogo (sem grid de lista)
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Dialogo utilitario: botoes sempre visiveis/habilitados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmd_4c_OK", 5)
            THIS.cmd_4c_OK.Visible      = .T.
            THIS.cmd_4c_OK.Enabled      = .T.
        ENDIF
        IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
            THIS.cmd_4c_Cancela.Visible = .T.
            THIS.cmd_4c_Cancela.Enabled = .T.
        ENDIF
    ENDPROC

ENDDEFINE
