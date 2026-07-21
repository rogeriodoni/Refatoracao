*==============================================================================
* FormSIGPRSTF.prg - Dialogo de Senha de Risco (Supervisor)
* Equivalente ao SigTfSup (SIGPRSTF.SCX) do legado
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo modal sem PageFrame
*
* Uso:
*   loForm = CREATEOBJECT("FormSIGPRSTF")
*   loForm.Show()
*   IF !loForm.this_lCancelado
*       lcSenha = loForm.this_cSenhaRetorno
*   ENDIF
*==============================================================================

DEFINE CLASS FormSIGPRSTF AS FormBase

    *-- BO associado
    this_oBusinessObject = .NULL.

    *-- Senha confirmada pelo usuario (ler apos Show())
    this_cSenhaRetorno = ""

    *-- .T. se usuario cancelou sem confirmar senha
    this_lCancelado = .T.

    *-- Propriedades visuais (PILAR 1: identico ao legado SigTfSup)
    Width       = 800
    Height      = 200
    AutoCenter  = .T.
    BorderStyle = 2
    Caption     = "Senha de Risco"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Instancia BO e configura layout base do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRSTFBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Configurar aparencia base do form (fundo, fontes, cores)
                THIS.ConfigurarPageFrame()

                *-- Criar cabecalho cinza (cntSombra do legado)
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Criar controles de entrada de senha
                THIS.ConfigurarControlesSenha()

                *-- Criar area de instrucao ao usuario
                THIS.ConfigurarPaginaDados()

                *-- Criar botao de cancelar
                THIS.ConfigurarBotaoCancelar()

                *-- Tornar todos os controles visiveis pos-AddObject
                THIS.TornarControlesVisiveis()

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SIGPRSTFBO", "Erro ao Inicializar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, ;
                    "Erro ao inicializar FormSIGPRSTF")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura aparencia base do form (sem PageFrame)
    * Dialogo simples: fundo cinza padrao Windows, sem barra de rolagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.BackColor  = RGB(212, 208, 200)
        THIS.ScrollBars = 0
        THIS.ShowTips   = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria container de cabecalho cinza (cntSombra)
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container cinza do cabecalho
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100,100,100)
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (deslocado 1px para efeito de profundidade - preto)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Senha de Risco"
            .Height     = 40
            .Left       = 10
            .Top        = 18
            .Width      = THIS.Width
            .ForeColor  = RGB(0,0,0)
            .Visible    = .T.
        ENDWITH

        *-- Label titulo principal (branco sobre cinza)
        THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
            .AutoSize   = .F.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 18
            .WordWrap   = .T.
            .Alignment  = 0
            .BackStyle  = 0
            .Caption    = "Senha de Risco"
            .Height     = 46
            .Left       = 10
            .Top        = 17
            .Width      = THIS.Width
            .ForeColor  = RGB(255,255,255)
            .Visible    = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - override seguro (dialogo sem botoes CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * Handlers CRUD - Nao aplicavel a este form
    * ------------------------------------------------------------------------
    * SigTfSup (legado) eh dialogo modal de senha de supervisor: nao tem
    * grid de registros, nao tem Page Lista/Dados, nao expoe botoes Incluir/
    * Alterar/Visualizar/Excluir. O usuario digita senha + Enter (confirma) ou
    * clica Cancelar. Os handlers abaixo existem para satisfazer o contrato
    * do pipeline OPERACIONAL - caso o form seja acidentalmente chamado como
    * CRUD por menu.prg, os cliques nao geram erro em runtime.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        MsgAviso("Esta janela n" + CHR(227) + "o suporta inclus" + CHR(227) + "o de registros.", ;
                 "Senha de Risco")
    ENDPROC

    PROCEDURE BtnAlterarClick()
        MsgAviso("Esta janela n" + CHR(227) + "o suporta altera" + CHR(231) + CHR(227) + "o de registros.", ;
                 "Senha de Risco")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        MsgAviso("Esta janela n" + CHR(227) + "o suporta visualiza" + CHR(231) + CHR(227) + "o de registros.", ;
                 "Senha de Risco")
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Esta janela n" + CHR(227) + "o suporta exclus" + CHR(227) + "o de registros.", ;
                 "Senha de Risco")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Nao aplicavel (dialogo modal sem PageFrame)
    * SigTfSup legado eh dialogo simples de senha de supervisor sem lista/grid.
    * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
    * O layout completo eh criado por ConfigurarCabecalho/ConfigurarControlesSenha/
    * ConfigurarBotaoCancelar - nao ha PageFrame.Page1 (Lista) a configurar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Area de instrucao ao usuario (Container1 do legado)
    * Container1 exibe orientacao dinamica definida em Init() original:
    *   ThisForm.Container1.Label1.Caption = "Digite a Senha" + CHR(13) + "do Supervisor"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Container instrucao ao usuario (Container1 do legado)
        THIS.AddObject("cnt_4c_Container1", "Container")
        WITH THIS.cnt_4c_Container1
            .Top           = 137
            .Left          = 114
            .Width         = 171
            .Height        = 56
            .SpecialEffect = 0
            .BackStyle     = 1
            .BackColor     = RGB(212,208,200)
            .BorderWidth   = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Container1.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.cnt_4c_Container1.lbl_4c_Label1
            .AutoSize  = .F.
            .FontBold  = .T.
            .FontName  = "Trebuchet MS"
            .FontSize  = 10
            .Alignment = 2
            .Caption   = "Insira ou Passe o Cartao"
            .Height    = 30
            .Left      = 7
            .Top       = 16
            .Width     = 157
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
            .WordWrap  = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel (dialogo modal sem PageFrame)
    * SigTfSup legado nao tem navegacao Lista<->Dados.
    * Mantido para satisfazer contrato de forms OPERACIONAL do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarControlesSenha - Cria controles da area de entrada de senha
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarControlesSenha()
        *-- Shape retangulo borda da area de senha (Shape1 do legado)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top           = 90
            .Left          = 76
            .Height        = 42
            .Width         = 247
            .SpecialEffect = 0
        ENDWITH

        *-- Label "Senha do Supervisor :" (Label3 do legado)
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Alignment = 0
            .Caption   = "Senha do Supervisor :"
            .Height    = 15
            .Left      = 87
            .Top       = 104
            .Width     = 108
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- TextBox GetSenha desabilitado (leitura de cartao - GetSenha do legado)
        THIS.AddObject("txt_4c_GetSenha", "TextBox")
        WITH THIS.txt_4c_GetSenha
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
            .Height    = 23
            .Left      = 214
            .Top       = 99
            .Width     = 100
            .ForeColor = RGB(0,0,0)
            .Value     = ""
        ENDWITH

        *-- TextBox de senha com mascara (SENHA do legado)
        THIS.AddObject("txt_4c_Senha", "TextBox")
        WITH THIS.txt_4c_Senha
            .FontBold     = .F.
            .FontName     = "Tahoma"
            .FontSize     = 8
            .BackStyle    = 1
            .BackColor    = RGB(255,255,255)
            .ForeColor    = RGB(0,0,0)
            .Height       = 23
            .Left         = 214
            .Top          = 99
            .Width        = 100
            .PasswordChar = "*"
            .TabIndex     = 1
            .Value        = ""
        ENDWITH

        BINDEVENT(THIS.txt_4c_Senha, "KeyPress", THIS, "TxtSenhaKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotaoCancelar - Cria botao de cancelar (SAIDA do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotaoCancelar()
        LOCAL loc_oCmg

        THIS.AddObject("cmg_4c_Saida", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Saida

        WITH loc_oCmg
            .ButtonCount = 1
            .BackStyle   = 0
            .BackColor   = RGB(255,255,255)
            .BorderStyle = 0
            .Value       = 0
            .Height      = 85
            .Left        = 320
            .Top         = -2
            .Width       = 85
            .TabIndex    = 4

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .FontBold        = .T.
                .FontItalic      = .F.
                .Caption         = "\<Cancelar"
                .ForeColor       = RGB(90,90,90)
                .BackColor       = RGB(255,255,255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .MousePointer    = 15
                .WordWrap        = .T.
                .Cancel          = .T.
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            ENDWITH
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Saida.Buttons(1), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSenhaKeyPress - Handler KeyPress do campo senha
    * Enter (13): confirma senha e oculta form
    *--------------------------------------------------------------------------
    PROCEDURE TxtSenhaKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl

        IF par_nKeyCode = 13
            THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
            THIS.this_lCancelado    = .F.
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Handler do botao Cancelar (tambem disparado por ESC)
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick
        THIS.txt_4c_Senha.Value = ""
        THIS.this_cSenhaRetorno = ""
        THIS.this_lCancelado    = .T.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis pos-AddObject
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_i, loc_oControl, loc_j, loc_oSub

        FOR loc_i = 1 TO THIS.ControlCount
            loc_oControl = THIS.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    FOR loc_j = 1 TO loc_oControl.ControlCount
                        loc_oSub = loc_oControl.Controls(loc_j)
                        IF VARTYPE(loc_oSub) = "O" AND PEMSTATUS(loc_oSub, "Visible", 5)
                            loc_oSub.Visible = .T.
                        ENDIF
                    ENDFOR
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores dos controles para o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cSenha     = THIS.txt_4c_Senha.Value
            THIS.this_oBusinessObject.this_lCancelado = THIS.this_lCancelado
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia valores do BO para os controles do form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
                THIS.txt_4c_Senha.Value = THIS.this_oBusinessObject.this_cSenha
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            THIS.txt_4c_Senha.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos do dialogo
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_Senha", 5)
            THIS.txt_4c_Senha.Value = ""
        ENDIF
        THIS.this_cSenhaRetorno = ""
        THIS.this_lCancelado    = .T.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cSenha     = ""
            THIS.this_oBusinessObject.this_lCancelado = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel (dialogo modal sem lista/grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel (dialogo sem modos CRUD)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel (dialogo sem busca de registros)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Cancela o dialogo (equivalente a BtnCancelarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma a senha digitada
    * Equivalente ao SENHA.KeyPress Enter=13 do legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        IF EMPTY(ALLTRIM(THIS.txt_4c_Senha.Value))
            MsgAviso("A senha n" + CHR(227) + "o pode estar em branco.", "Senha de Risco")
            RETURN
        ENDIF
        THIS.FormParaBO()
        THIS.this_cSenhaRetorno = THIS.txt_4c_Senha.Value
        THIS.this_lCancelado    = .F.
        THIS.Hide()
    ENDPROC

ENDDEFINE
