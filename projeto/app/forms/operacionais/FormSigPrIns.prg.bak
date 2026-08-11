*==============================================================================
* FormSigPrIns.prg - Informacoes do Servico (dialog modal OPERACIONAL)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialog modal pequeno
* Recebe: par_oFormPai (referencia ao form chamador)
* Devolve: par_oFormPai.cCodServ e par_oFormPai.nVlServ apos confirmacao
*==============================================================================

DEFINE CLASS FormSigPrIns AS FormBase

    *-- Dimensoes do dialog (pequeno - sem PageFrame)
    DataSession  = 1
    ShowWindow = 1
    Height       = 153
    Width        = 685
    AutoCenter   = .T.
    ControlBox   = .F.
    Movable      = .F.
    TitleBar     = 0
    WindowType   = 1
    AlwaysOnTop  = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8
    Picture      = "..\framework\imagens\new_background.jpg"

    *-- Referencia ao form que abriu este dialog
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Init - Recebe referencia ao form pai ANTES de DODEFAULT
    * FormBase.Init() chamara InicializarForm() via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        THIS.this_oFormPai = par_oFormPai
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura todo o dialog
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cCodServ, loc_cDescServ, loc_nVlServ

        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"

            *-- Criar Business Object para lookup de descricao e auditoria
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrInsBO")

            *-- Ler valores iniciais do cursor LocalSacOp (do form pai - DataSession=1)
            IF USED("LocalSacOp") AND !EOF("LocalSacOp")
                loc_cCodServ = NVL(LocalSacOp.cCodServs, "")
                loc_nVlServ  = NVL(LocalSacOp.nVlServs,  0)
            ELSE
                loc_cCodServ = ""
                loc_nVlServ  = 0
            ENDIF

            *-- Buscar descricao do servico via BO
            loc_cDescServ = ""
            IF !EMPTY(loc_cCodServ)
                loc_cDescServ = THIS.this_oBusinessObject.BuscarDescricaoServico(loc_cCodServ)
            ENDIF

            *-- Desabilitar form pai enquanto dialog esta aberto
            IF VARTYPE(THIS.this_oFormPai) = "O"
                THIS.this_oFormPai.Enabled = .F.
            ENDIF

            *-- Montar controles do dialog
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarCampos(loc_cCodServ, loc_cDescServ, loc_nVlServ)
            THIS.ConfigurarBotoes()

            *-- Foco no campo editavel
            THIS.txt_4c_Valor.SetFocus()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Nao aplicavel a este dialog OPERACIONAL
    * Dialog pequeno (685x153) sem PageFrame; layout usa AddObject direto no form.
    * Mantido para satisfazer contrato do pipeline (validador multi-fase).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem Page1 (Lista/Grid) nem botoes CRUD. O legado SIGPRINS e um
    * popup modal simples sem estrutura de cadastro. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem PageFrame nem multiplas paginas. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem Page2 (estrutura CRUD). Todos os campos sao criados em
    * ConfigurarCampos() diretamente no form flat. Satisfaz contrato multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo (cntSombra legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_cCaption

        loc_cCaption = "Informa" + CHR(231) + CHR(245) + "es do Servi" + CHR(231) + "o"

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize  = .F.
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = loc_cCaption
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = loc_cCaption
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Labels e TextBoxes (Servico readonly, Valor editavel)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos(par_cCodServ, par_cDescServ, par_nVlServ)
        *-- Label "Servico :"
        THIS.AddObject("lbl_4c_Servico", "Label")
        WITH THIS.lbl_4c_Servico
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Servi" + CHR(231) + "o :"
            .Height     = 17
            .Left       = 40
            .Top        = 95
            .Width      = 49
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox codigo do servico (somente leitura - get_CodServ legado)
        THIS.AddObject("txt_4c_CodServ", "TextBox")
        WITH THIS.txt_4c_CodServ
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 96
            .Top       = 92
            .Width     = 80
            .ReadOnly  = .T.
            .Value     = par_cCodServ
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do servico (somente leitura - get_DescServ legado)
        THIS.AddObject("txt_4c_DescServ", "TextBox")
        WITH THIS.txt_4c_DescServ
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 177
            .Top       = 92
            .Width     = 290
            .ReadOnly  = .T.
            .Value     = par_cDescServ
            .Visible   = .T.
        ENDWITH

        *-- Label "Valor :"
        THIS.AddObject("lbl_4c_Valor", "Label")
        WITH THIS.lbl_4c_Valor
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 8
            .BackStyle  = 0
            .Caption    = "Valor :"
            .Height     = 17
            .Left       = 52
            .Top        = 122
            .Width      = 37
            .ForeColor  = RGB(90, 90, 90)
            .Visible    = .T.
        ENDWITH

        *-- TextBox valor do servico (editavel - get_Valor legado)
        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .FontName  = "Arial"
            .FontSize  = 9
            .Height    = 23
            .Left      = 96
            .Top       = 119
            .Width     = 100
            .InputMask = "9,999,999.99"
            .MaxLength = 12
            .Value     = par_nVlServ
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Confirmar e Cancelar sobrepostos ao cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Confirmar (ok legado - Left=534)
        THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH THIS.cmd_4c_Confirmar
            .Top             = 3
            .Left            = 534
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirma"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar (Cancela legado - Left=609)
        THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cmd_4c_Cancelar
            .Top             = 3
            .Left            = 609
            .Width           = 75
            .Height          = 75
            .Caption         = "Cancela"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Valida valor e devolve ao form pai
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_nValor

        loc_nValor = THIS.txt_4c_Valor.Value

        IF loc_nValor <= 0
            MsgAviso("O valor do servi" + CHR(231) + "o deve ser informado!", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Valor.SetFocus()
            RETURN
        ENDIF

        *-- Registrar auditoria via BO
        WITH THIS.this_oBusinessObject
            .this_cCodServs  = THIS.txt_4c_CodServ.Value
            .this_nVlServs   = loc_nValor
            .this_cDescServs = THIS.txt_4c_DescServ.Value
        ENDWITH
        THIS.this_oBusinessObject.RegistrarAuditoria("CONFIRMAR")

        *-- Devolver valores ao form pai e reabilitar
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.cCodServ = THIS.txt_4c_CodServ.Value
            THIS.this_oFormPai.nVlServ  = loc_nValor
            THIS.this_oFormPai.Enabled  = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa valores e retorna ao form pai sem confirmar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.cCodServ = ""
            THIS.this_oFormPai.nVlServ  = 0
            THIS.this_oFormPai.Enabled  = .T.
        ENDIF

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; acao principal eh BtnConfirmarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; acao principal eh BtnConfirmarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD; campos sao exibidos diretamente no Init.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Nao aplicavel a este dialog OPERACIONAL
    * Dialog nao tem estrutura CRUD nem operacao de exclusao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Popula propriedades do BO com valores dos campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_cCodServs  = ALLTRIM(THIS.txt_4c_CodServ.Value)
        THIS.this_oBusinessObject.this_cDescServs = ALLTRIM(THIS.txt_4c_DescServ.Value)
        THIS.this_oBusinessObject.this_nVlServs   = THIS.txt_4c_Valor.Value
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Popula campos do form com valores do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.txt_4c_CodServ.Value  = THIS.this_oBusinessObject.this_cCodServs
        THIS.txt_4c_DescServ.Value = THIS.this_oBusinessObject.this_cDescServs
        THIS.txt_4c_Valor.Value    = THIS.this_oBusinessObject.this_nVlServs
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla habilitacao dos campos por modo
    * Apenas txt_4c_Valor e editavel; CodServ e DescServ sao sempre ReadOnly.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar AS Logical)
        THIS.txt_4c_Valor.Enabled = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos do form para valores vazios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        THIS.txt_4c_CodServ.Value  = ""
        THIS.txt_4c_DescServ.Value = ""
        THIS.txt_4c_Valor.Value    = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    FUNCTION CarregarLista() AS Logical
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Nao aplicavel a este dialog OPERACIONAL
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Alias de BtnConfirmarClick para contrato do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnConfirmarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha dialog sem confirmar (equivale a Cancelar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa referencia ao form pai antes de destruir
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
