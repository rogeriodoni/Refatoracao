*------------------------------------------------------------------------------
* FormICD.prg - Form Operacional: Duplicacao dos Tipo de Tributacao
* Migrado de: tasks/task446/SIGCDICD.SCX
* Tabela principal: SigPrTri
*------------------------------------------------------------------------------

DEFINE CLASS FormICD AS FormBase

    Height      = 262
    Width       = 443
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Verdana"
    FontSize    = 8
    MaxButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    ForeColor   = RGB(36,84,155)
    Themes      = .F.

    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Duplica" + CHR(231) + CHR(227) + "o dos Tipo de Tributa" + CHR(231) + CHR(227) + "o"
        *-- ShowWindow=1 na classe causaria TIMEOUT em VFP9 -T (top-level window bloqueante).
        *-- Classe definida com ShowWindow=0; producao restaura para modal top-level aqui.
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ICDBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio ICDBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.TornarControlesVisiveis(THIS)
            THIS.RegistrarEventos()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra montagem visual do form OPERACIONAL
    * Nao ha PageFrame real (form nao tem Lista/Dados como CRUD); metodo delega
    * para os configuradores especificos: cabecalho escuro, campos e botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria container escuro superior com labels de titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100,100,100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0,0,0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255,255,255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria container branco dos campos de entrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oCnt

        *-- Shape decorativo ao redor do container (top=79, left=103, w=173, h=110)
        THIS.AddObject("shp_4c_Borda", "Shape")
        WITH THIS.shp_4c_Borda
            .Top           = 79
            .Left          = 103
            .Height        = 110
            .Width         = 173
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136,189,188)
        ENDWITH

        *-- Container principal dos campos (Tipo: e Novo:)
        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 132
            .Left          = 84
            .Width         = 279
            .Height        = 59
            .SpecialEffect = 0
            .BackColor     = RGB(255,255,255)
            .BackStyle     = 1
            .BorderWidth   = 0
        ENDWITH

        *-- Labels "Tipo :" e "Novo :"
        loc_oCnt.AddObject("lbl_4c_RotTipo", "Label")
        WITH loc_oCnt.lbl_4c_RotTipo
            .Caption  = "Tipo :"
            .Left     = 9
            .Top      = 8
            .AutoSize = .T.
            .TabIndex = 5
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_RotNovo", "Label")
        WITH loc_oCnt.lbl_4c_RotNovo
            .Caption  = "Novo :"
            .Left     = 6
            .Top      = 34
            .AutoSize = .T.
            .TabIndex = 6
        ENDWITH

        *-- TextBoxes: linha 1 = tipo existente (Tipo + Desc)
        loc_oCnt.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oCnt.txt_4c_Tipo
            .Value     = ""
            .MaxLength = 4
            .Height    = 23
            .Width     = 40
            .Left      = 46
            .Top       = 4
            .TabIndex  = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oCnt.txt_4c_Desc
            .Value     = ""
            .MaxLength = 20
            .Height    = 23
            .Width     = 184
            .Left      = 90
            .Top       = 4
            .TabIndex  = 2
        ENDWITH

        *-- TextBoxes: linha 2 = novo tipo (NovoTipo + NovaDesc)
        loc_oCnt.AddObject("txt_4c_NovoTipo", "TextBox")
        WITH loc_oCnt.txt_4c_NovoTipo
            .Value     = ""
            .MaxLength = 4
            .Height    = 23
            .Width     = 40
            .Left      = 46
            .Top       = 30
            .TabIndex  = 3
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NovaDesc", "TextBox")
        WITH loc_oCnt.txt_4c_NovaDesc
            .Value     = ""
            .MaxLength = 20
            .Height    = 23
            .Width     = 184
            .Left      = 90
            .Top       = 30
            .TabIndex  = 4
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria botoes Duplicar e Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Duplicar", "CommandButton")
        WITH THIS.cmd_4c_Duplicar
            .Top             = 2
            .Left            = 294
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Duplicar"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 2
            .Left            = 367
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "simbolosl_erro_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "simbolosl_erro_26.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - form OPERACIONAL dialogo (443x262) sem PageFrame
    * SIGCDICD eh dialogo modal de duplicacao (Tipo origem + Novo tipo),
    * NAO tem estrutura Page1=Lista/Page2=Dados nem grid de registros.
    * Layout completo esta em ConfigurarCampos() / ConfigurarBotoes().
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - form OPERACIONAL dialogo (443x262) sem PageFrame
    * SIGCDICD eh dialogo modal de duplicacao; nao tem Page2 Dados separada.
    * Todos os campos estao em ConfigurarCampos(). Metodo mantido apenas para
    * conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - form OPERACIONAL dialogo sem PageFrame; nao ha alternancia
    * entre paginas. par_nPagina eh ignorado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Incluir no layout (SCX legado tem apenas Command1=Duplicar
    * e Command2=Encerrar). A acao de "incluir" nova tributacao eh feita pelo
    * CmdDuplicarClick (duplica registro origem em novo codigo).
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Alterar no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Visualizar no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Excluir no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
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
    * CmdDuplicarClick - valida e executa duplicacao do tipo de tributacao
    *--------------------------------------------------------------------------
    PROCEDURE CmdDuplicarClick()
        LOCAL loc_cTipoOrig, loc_cNovoTipo, loc_cNovaDesc

        loc_cTipoOrig  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)
        loc_cNovoTipo  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NovoTipo.Value)
        loc_cNovaDesc  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value)

        IF EMPTY(loc_cTipoOrig)
            MsgAviso("Informe o Tipo de origem.", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_Tipo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cNovoTipo)
            MsgAviso("Informe o novo c" + CHR(243) + "digo do Tipo.", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_NovoTipo.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.DuplicarTipo(loc_cTipoOrig, loc_cNovoTipo, loc_cNovaDesc)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - fecha o form sem executar duplicacao
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTipoKeyPress - lookup de tipo existente em SigPrTri
    *--------------------------------------------------------------------------
    PROCEDURE TxtTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTipo - busca Tipos digitado e preenche Desc; abre lookup se nao achou
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarTipo()
        LOCAL loc_cTipo, loc_cSQL, loc_oErro

        loc_cTipo = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)
        IF EMPTY(loc_cTipo)
            THIS.cnt_4c_Container1.txt_4c_Desc.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Tipos, Descs FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(loc_cTipo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTipo") > 0
                SELECT cursor_4c_LkpTipo
                IF !EOF()
                    THIS.cnt_4c_Container1.txt_4c_Tipo.Value    = ALLTRIM(Tipos)
                    THIS.cnt_4c_Container1.txt_4c_Desc.Value    = ALLTRIM(Descs)
                    THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                    USE IN cursor_4c_LkpTipo
                    RETURN
                ENDIF
                USE IN cursor_4c_LkpTipo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTipo")
            RETURN
        ENDTRY

        THIS.AbrirLookupTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTipo - abre FormBuscaAuxiliar para SigPrTri por Tipos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTipo()
        LOCAL loc_oLookup, loc_cValor

        loc_cValor = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)

        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
                                   "cursor_4c_LkpTipo", "Tipos", loc_cValor, ;
                                   "Sele" + CHR(231) + CHR(227) + "o de Tipo", .F., .T., "")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Tipos", "XXXX", "Tipo")
            loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpTipo")
                SELECT cursor_4c_LkpTipo
                THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
                THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
                THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                USE IN cursor_4c_LkpTipo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTipoDblClick - abre lookup de SigPrTri por Tipos via duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE TxtTipoDblClick()
        THIS.AbrirLookupTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDescKeyPress - lookup de tipo existente em SigPrTri por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TxtDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        *-- Busca por descricao permitida apenas quando Tipo ainda nao foi preenchido
        *-- (replica comportamento do When: Empty(GetTipo.Value) = .T. -> foco permitido)
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value))
            RETURN
        ENDIF
        THIS.ValidarDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDesc - busca Descs digitado e preenche Tipo; abre lookup se nao achou
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDesc()
        LOCAL loc_cDesc

        loc_cDesc = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Desc.Value)
        IF EMPTY(loc_cDesc)
            RETURN
        ENDIF

        THIS.AbrirLookupDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDescDblClick - abre lookup de SigPrTri por Descs via duplo clique
    * Respeita comportamento When: ativo apenas quando Tipo ainda nao preenchido
    *--------------------------------------------------------------------------
    PROCEDURE TxtDescDblClick()
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value))
            RETURN
        ENDIF
        THIS.AbrirLookupDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDesc - abre FormBuscaAuxiliar para SigPrTri por Descs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupDesc()
        LOCAL loc_oLookup, loc_cValor

        loc_cValor = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Desc.Value)

        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
                                   "cursor_4c_LkpDesc", "Descs", loc_cValor, ;
                                   "Sele" + CHR(231) + CHR(227) + "o de Tipo", .F., .T., "")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLookup.mAddColuna("Tipos", "XXXX", "Tipo")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpDesc")
                SELECT cursor_4c_LkpDesc
                THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
                THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
                THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                USE IN cursor_4c_LkpDesc
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventos - vincula eventos dos controles via BINDEVENT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        BINDEVENT(loc_oCnt.txt_4c_Tipo,  "KeyPress", THIS, "TxtTipoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Tipo,  "DblClick", THIS, "TxtTipoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Desc,  "KeyPress", THIS, "TxtDescKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Desc,  "DblClick", THIS, "TxtDescDblClick")
        BINDEVENT(THIS.cmd_4c_Duplicar,  "Click",    THIS, "CmdDuplicarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click",    THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - popula propriedades do BO com valores dos campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        THIS.this_oBusinessObject.this_cTipos     = ALLTRIM(loc_oCnt.txt_4c_Tipo.Value)
        THIS.this_oBusinessObject.this_cDescs     = ALLTRIM(loc_oCnt.txt_4c_Desc.Value)
        THIS.this_oBusinessObject.this_cNovoTipos = ALLTRIM(loc_oCnt.txt_4c_NovoTipo.Value)
        THIS.this_oBusinessObject.this_cNovaDescs = ALLTRIM(loc_oCnt.txt_4c_NovaDesc.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - popula campos do form com propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oCnt.txt_4c_Desc.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        loc_oCnt.txt_4c_NovoTipo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cNovoTipos)
        loc_oCnt.txt_4c_NovaDesc.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cNovaDescs)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita ou desabilita os campos de entrada
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Enabled      = par_lHabilitar
        loc_oCnt.txt_4c_Desc.Enabled      = par_lHabilitar
        loc_oCnt.txt_4c_NovoTipo.Enabled  = par_lHabilitar
        loc_oCnt.txt_4c_NovaDesc.Enabled  = par_lHabilitar
        THIS.cmd_4c_Duplicar.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos de entrada
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Value     = ""
        loc_oCnt.txt_4c_Desc.Value     = ""
        loc_oCnt.txt_4c_NovoTipo.Value = ""
        loc_oCnt.txt_4c_NovaDesc.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - form OPERACIONAL dialogo sem lista de registros; contrato
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - form OPERACIONAL sem modos CRUD; contrato pipeline
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - contrato do pipeline; delega para CmdEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - form OPERACIONAL dialogo sem botao Buscar; contrato
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - acao principal deste dialogo eh Duplicar; contrato
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdDuplicarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - form OPERACIONAL dialogo; contrato do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cnSigPrTri")
            USE IN cnSigPrTri
        ENDIF
        IF USED("cursor_4c_CheckTipo")
            USE IN cursor_4c_CheckTipo
        ENDIF
        IF USED("cursor_4c_LkpTipo")
            USE IN cursor_4c_LkpTipo
        ENDIF
        IF USED("cursor_4c_LkpDesc")
            USE IN cursor_4c_LkpDesc
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
