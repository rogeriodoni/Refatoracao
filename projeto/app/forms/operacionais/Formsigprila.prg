*==============================================================================
* Formsigprila.prg - Form Operacional: Importacao de Planilha (SIGPRILA)
* Herda de: FormBase
* Tipo: OPERACIONAL - dialogo utilitario de importacao de planilha Excel que
*       alimenta 7 rotinas distintas (ListaPreco/GeraTransf/AtuaPreco/
*       GeraPedido/Pedidocons/PedidoFab/PedAcesso), escolhidas pelo usuario
*       no combo cntplanilha.cmbTipos. Sem PageFrame no legado (raiz
*       "Class: form" generica, sem BaseClass: pageframe no dump) - layout
*       FLAT com 2 containers (cntSombra/cntplanilha) + 1 CommandGroup
*       (Grupo_Botao), nos moldes de Formsigprsen.
* SCX Origem: sigprila.SCX (tasks\task627)
*
* Eventos do legado ligados por BINDEVENT em ConfigurarEventos:
*   Grupo_Botao.cmdok.Click   -> BtnProcessarClick   -> Processamento
*   Grupo_Botao.cmdsair.Click -> BtnEncerrarClick    -> Release
*   cntplanilha.cmdgetp.Click -> BtnGetPlanilhaClick -> GETFILE
*   cmbTipos.InteractiveChange -> CboTiposInteractiveChange -> CompletaLista
*   SIGPRILA.KeyPress (ESC)   -> BtnEncerrarClick
* As SETE rotinas de importacao que Processamento despacha (ListaPreco/
* GeraTransf/AtuaPreco/GeraPedido/Pedidocons/PedidoFab/PedAcesso) sao regra
* de negocio e moram em sigprilaBO, alcancadas por ObterMetodoRotina.
*
* Superficie que esta tela NAO tem (e por isso nao esta migrada): grade de
* registros, barra CRUD e modo de edicao cancelavel. O SCX legado nao tem
* nenhum dos tres - nem BaseClass grid/pageframe, nem Grupo_Op/frmcadastro,
* nem pcEscolha - e os DEZ AddCursor do Init passam '' na posicao do objeto
* de grade. O que a tela tem eh criterio digitavel (tipo de importacao,
* arquivo, cabecalho na 1a linha, Validar e Preco) mais UM botao de acao que
* le o .xls e GRAVA em tabela de verdade, e UM botao que so fecha. Os dois
* hooks de transferencia (FormParaBO / BOParaForm) sao o par que liga esse
* criterio ao BO nos dois sentidos.
*==============================================================================
DEFINE CLASS Formsigprila AS FormBase

    *-- Dimensoes pixel-perfect do SCX original (PILAR 1) - layout.json:
    *-- form.width=800 / form.height=350 (analise.json trazia 1000x600, mas
    *-- esse arquivo nao foi preenchido pela analise desta task - campos/
    *-- lookups/labels/grid todos vazios - entao prevalece o dump real)
    Width        = 800
    Height       = 350
    Caption      = "Importa" + CHR(231) + CHR(227) + "o de Planilha"
    AutoCenter   = .T.
    ShowTips     = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    DataSession  = 2
    KeyPreview   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * Init - Apenas delega para FormBase.Init() -> InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o BO, aplica background e monta a casca do layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprilaBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
                THIS.ConfigurarEventos()
                THIS.PreencheTipo()
                *-- Painel abre no estado dos criterios guardados no BO, para
                *-- tela e BO nunca comecarem divergentes. Visualmente nao muda
                *-- nada hoje (os defaults do BO sao os mesmos do SCX: arquivo
                *-- vazio, cabecalho desmarcado, OptTipo/OptPreco na 1a opcao) -
                *-- o ganho eh a fonte unica, que o fim do Processamento usa.
                THIS.BOParaForm()
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar sigprilaBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL.
    * Este form nao usa PageFrame (legado sem BaseClass: pageframe) - mantido
    * so como ponto de entrada unico, no mesmo padrao de Formsigprsen.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cabecalho (cntSombra) + painel do assistente de
    * importacao (cntplanilha, com todos os campos do dump)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPainelPlanilha()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Grupo de botoes de acao (Grupo_Botao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    * Posicoes/tamanhos EXATOS do layout.json (PILAR 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
        loc_oCab = THIS.cnt_4c_Sombra

        loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCab.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCab.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPainelPlanilha - Container principal do assistente (cntplanilha
    * original). Campos criados em duas partes, seguindo mapeamento.json.
    * Posicao/tamanho EXATOS do layout.json (PILAR 1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPainelPlanilha()
        THIS.AddObject("cnt_4c_planilha", "Container")
        WITH THIS.cnt_4c_planilha
            .Top           = 96
            .Left          = 167
            .Width         = 466
            .Height        = 221
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        THIS.ConfigurarCamposPlanilhaParte1()
        THIS.ConfigurarCamposPlanilhaParte2()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPlanilhaParte1 - primeira metade dos campos de
    * cnt_4c_planilha (Say3/cmbTipos/Say4/GetPlanilha/cmdgetp/Say1 do dump
    * original). Posicoes/propriedades EXATAS de
    * tasks\task627\sigprila_form_codigo_fonte.txt (SECAO 2). Segunda metade
    * (List1/Say2/chkCabecalho/Say5/OptTipo/Say6/OptPreco) em
    * ConfigurarCamposPlanilhaParte2 (abaixo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte1()
        LOCAL loc_oPnl
        loc_oPnl = THIS.cnt_4c_planilha

        *-- Say3 -> lbl_4c_Label3 ("Tipo:")
        loc_oPnl.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPnl.lbl_4c_Label3
            .Top       = 15
            .Left      = 54
            .Width     = 29
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Tipo:"
        ENDWITH

        *-- cmbTipos -> cbo_4c_CmbTipos (fwcombo, Style=2 dropdown list;
        *-- RowSource eh ligado ao cursor ComboTipo em PreencheTipo, chamado
        *-- pelo InicializarForm - igual ao Init do legado)
        loc_oPnl.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH loc_oPnl.cbo_4c_CmbTipos
            .Top          = 12
            .Left         = 85
            .Width        = 187
            .Height       = 23
            .Style        = 2
            .ColumnCount  = 1
            .ColumnWidths = "100"
            .RowSourceType = 6
            .RowSource    = ""
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(0, 0, 0)
        ENDWITH

        *-- Say4 -> lbl_4c_Label4 ("Planilha:")
        loc_oPnl.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPnl.lbl_4c_Label4
            .Top       = 40
            .Left      = 34
            .Width     = 49
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Planilha:"
        ENDWITH

        *-- GetPlanilha -> txt_4c_Planilha (fwget, preenchido via GetFile() no
        *-- Click de cmdgetp - ReadOnly/Enabled=.F. iguais ao dump original)
        loc_oPnl.AddObject("txt_4c_Planilha", "TextBox")
        WITH loc_oPnl.txt_4c_Planilha
            .Top               = 37
            .Left              = 85
            .Width             = 336
            .Height            = 23
            .MaxLength         = 40
            .ReadOnly          = .T.
            .Enabled           = .F.
            .Value             = ""
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .DisabledBackColor = RGB(255, 255, 255)
        ENDWITH

        *-- cmdgetp -> cmd_4c_Cmdgetp (botao icone-only que abre GetFile() -
        *-- Picture transcrito do dump; Click -> BtnGetPlanilhaClick)
        loc_oPnl.AddObject("cmd_4c_Cmdgetp", "CommandButton")
        WITH loc_oPnl.cmd_4c_Cmdgetp
            .Top       = 36
            .Left      = 423
            .Width     = 36
            .Height    = 25
            .FontName  = "Verdana"
            .FontSize  = 8
            .Caption   = ""
            .Picture   = gc_4c_CaminhoIcones + "a_fold1.bmp"
            .ForeColor = RGB(36, 84, 155)
            .BackColor = RGB(255, 255, 255)
            .Themes    = .F.
        ENDWITH

        *-- Say1 -> lbl_4c_Label1 ("Ordem das Colunas na Planilha:")
        loc_oPnl.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPnl.lbl_4c_Label1
            .Top       = 63
            .Left      = 85
            .Width     = 177
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Ordem das Colunas na Planilha:"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposPlanilhaParte2 - segunda metade dos campos de
    * cnt_4c_planilha: List1 (listbox de ordenacao de colunas, MoverBars),
    * Say2 (instrucao do drag), chkCabecalho, Say5/OptTipo (visiveis so para
    * alguns tipos - CompletaLista alterna .Visible conforme
    * o dump legado), Say6/OptPreco (idem). Posicoes/propriedades EXATAS de
    * tasks\task627\sigprila_form_codigo_fonte.txt (SECAO 2).
    *
    * LOOKUPS: a analise comportamental desta task (comportamento.json/
    * analise.json) NAO identificou nenhum padrao de lookup (fwBuscaExt,
    * fwBuscaSel, sigacess ou classe TextBox customizada de busca) em
    * nenhum campo de SIGPRILA - o formulario eh um assistente de
    * importacao de planilha sem campos de codigo/referencia a outra
    * tabela. cmbTipos eh populado localmente a partir do cursor ComboTipo
    * (array aComboTipo, montado no Init do form legado) e GetPlanilha eh
    * preenchido via GetFile() no Click de cmdgetp - nenhum dos dois abre
    * FormBuscaAuxiliar. Portanto esta fase nao adiciona BINDEVENT de F4/F5.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte2()
        LOCAL loc_oPnl
        loc_oPnl = THIS.cnt_4c_planilha

        *-- List1 -> obj_4c_List1 (listbox MoverBars para reordenar colunas da
        *-- planilha; RowSource real eh montado em runtime por CompletaLista,
        *-- e CriaPlanilha le a coluna 2 de cada item para criar TmpPlanilha)
        loc_oPnl.AddObject("obj_4c_List1", "ListBox")
        WITH loc_oPnl.obj_4c_List1
            .Top            = 78
            .Left           = 82
            .Width          = 191
            .Height         = 124
            .FontName       = "Tahoma"
            .FontSize       = 8
            .BoundColumn    = 2
            .ColumnCount    = 2
            .ColumnWidths   = "172,70"
            .RowSourceType  = 1
            .RowSource      = ""
            .MoverBars      = .T.
            .SpecialEffect  = 0
        ENDWITH

        *-- Say2 -> lbl_4c_Label2 ("Clique e Arraste para Mudar")
        loc_oPnl.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPnl.lbl_4c_Label2
            .Top       = 204
            .Left      = 83
            .Width     = 160
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Clique e Arraste para Mudar"
        ENDWITH

        *-- chkCabecalho -> chk_4c_ChkCabecalho ("Cabecalho na 1a Linha")
        loc_oPnl.AddObject("chk_4c_ChkCabecalho", "CheckBox")
        WITH loc_oPnl.chk_4c_ChkCabecalho
            .Top       = 204
            .Left      = 289
            .Width     = 142
            .Height    = 15
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Cabe" + CHR(231) + "alho na 1" + CHR(170) + " Linha"
            .Value     = 0
        ENDWITH

        *-- Say5 -> lbl_4c_Label5 ("Validar :")
        loc_oPnl.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPnl.lbl_4c_Label5
            .Top       = 82
            .Left      = 290
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Validar :"
        ENDWITH

        *-- OptTipo -> obj_4c_OptTipo (optiongroup: Codigo/Descritivo/
        *-- Referencia Forn. - define qual coluna de SigCdPro casa com o
        *-- produto da planilha; mapeia para sigprilaBO.this_nTipoBusca)
        loc_oPnl.AddObject("obj_4c_OptTipo", "OptionGroup")
        WITH loc_oPnl.obj_4c_OptTipo
            .Top         = 80
            .Left        = 335
            .Width       = 123
            .Height      = 65
            .ButtonCount = 3
            .BackStyle   = 0
            .Themes      = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 51
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "C" + CHR(243) + "digo"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 22
                .Left      = 5
                .Width     = 65
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Descritivo"
            ENDWITH

            WITH .Buttons(3)
                .Top       = 41
                .Left      = 5
                .Width     = 99
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Refer" + CHR(234) + "ncia Forn."
            ENDWITH

            .Value = 1
        ENDWITH

        *-- Say6 -> lbl_4c_Label6 ("Preco :")
        loc_oPnl.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPnl.lbl_4c_Label6
            .Top       = 142
            .Left      = 297
            .Width     = 40
            .Height    = 15
            .AutoSize  = .F.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Pre" + CHR(231) + "o :"
        ENDWITH

        *-- OptPreco -> obj_4c_OptPreco (optiongroup: Venda/Custo - define se
        *-- o valor gravado no movimento vem de PVens/Moevs ou de
        *-- custofs/moecusfs; mapeia para sigprilaBO.this_nTipoPreco)
        loc_oPnl.AddObject("obj_4c_OptPreco", "OptionGroup")
        WITH loc_oPnl.obj_4c_OptPreco
            .Top         = 140
            .Left        = 335
            .Width       = 123
            .Height      = 44
            .ButtonCount = 2
            .BackStyle   = 0
            .Themes      = .T.

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 48
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Venda"
            ENDWITH

            WITH .Buttons(2)
                .Top       = 22
                .Left      = 5
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
                .Caption   = "Custo"
            ENDWITH

            .Value = 1
        ENDWITH

        *-- Visibilidade inicial de Say5/OptTipo e Say6/OptPreco: o legado
        *-- (CompletaLista) alterna .Visible conforme o tipo escolhido em
        *-- cmbTipos. O estado inicial eh oculto, igual ao fim do PreencheTipo
        *-- do legado, que esconde os dois blocos antes de qualquer escolha.
        loc_oPnl.lbl_4c_Label5.Visible    = .F.
        loc_oPnl.obj_4c_OptTipo.Visible   = .F.
        loc_oPnl.lbl_4c_Label6.Visible    = .F.
        loc_oPnl.obj_4c_OptPreco.Visible  = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup de acao (Grupo_Botao original). Buttons(1)
    * "\<Processar" (cmdok) e Buttons(2) "Encerrar" (cmdsair) com Caption/
    * Picture/fontes/cores EXATOS do dump (SECAO 2, Grupo_Botao). Os Click
    * sao ligados por BINDEVENT em ConfigurarEventos: Buttons(1) ->
    * BtnProcessarClick e Buttons(2) -> BtnEncerrarClick.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("obj_4c_Grupo_Botao", "CommandGroup")
        WITH THIS.obj_4c_Grupo_Botao
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Visible       = .T.

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
                .Caption    = "\<Processar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .WordWrap   = .T.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "Encerrar"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarEventos - Liga os eventos do legado aos handlers deste form.
    *
    * BINDEVENT exige metodo PUBLIC (regra #3 do CLAUDE.md) - por isso os
    * handlers Btn*Click/Cbo*InteractiveChange abaixo nao levam PROTECTED.
    *
    * Legado (SECAO 3 de tasks\task627\sigprila_form_codigo_fonte.txt):
    *   Grupo_Botao.cmdok.Click                -> ChecaPlanilha()/Processamento()
    *   Grupo_Botao.cmdsair.Click              -> thisform.Release
    *   cntplanilha.cmdgetp.Click              -> GetFile('xls','Planilha','Importar')
    *   cntplanilha.cmbTipos.InteractiveChange -> ThisForm.Completalista()
    *   cntplanilha.GetPlanilha.When           -> corpo VAZIO no dump (nada a ligar)
    *
    * O legado tem UM Click por BOTAO do CommandGroup, entao a ligacao eh em
    * Buttons(1)/Buttons(2) (padrao do projeto: FormGr1/FormCliente), nao no
    * Click do grupo - assim cada botao mantem o handler que o dump declara.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oPnl, loc_oGrp

        loc_oGrp = THIS.obj_4c_Grupo_Botao
        IF VARTYPE(loc_oGrp) = "O"
            IF loc_oGrp.ButtonCount >= 2
                BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnProcessarClick")
                BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
            ENDIF
        ENDIF

        loc_oPnl = THIS.cnt_4c_planilha
        IF VARTYPE(loc_oPnl) = "O"
            IF PEMSTATUS(loc_oPnl, "cmd_4c_Cmdgetp", 5)
                BINDEVENT(loc_oPnl.cmd_4c_Cmdgetp, "Click", THIS, "BtnGetPlanilhaClick")
            ENDIF
            IF PEMSTATUS(loc_oPnl, "cbo_4c_CmbTipos", 5)
                BINDEVENT(loc_oPnl.cbo_4c_CmbTipos, "InteractiveChange", ;
                          THIS, "CboTiposInteractiveChange")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PreencheTipo - Monta o cursor ComboTipo (as 7 rotinas de importacao) e
    * liga cmbTipos a ele. Transcricao literal de SIGPRILA.PreencheTipo
    * (dump, linha 2129): o array aComboTipo tem 3 colunas por rotina -
    *   1) Titulo exibido no combo
    *   2) Nome da rotina (tambem a chave de acesso em fChecaAcesso)
    *   3) Lista "Titulo da coluna,Campo <tipo>" que define a ORDEM das
    *      colunas da planilha e a estrutura de TmpPlanilha ("|" eh virgula
    *      escapada, trocada por "," em CriaPlanilha)
    *
    * As strings da coluna 3 sao REGRA DE NEGOCIO (definem a leitura do .xls
    * posicao por posicao) e estao transcritas caractere a caractere do dump,
    * inclusive os espacos em sobra dos titulos - mudar qualquer uma delas
    * desloca a leitura da planilha inteira.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PreencheTipo()
        LOCAL loc_nI, loc_oCombo
        LOCAL ARRAY loc_aComboTipo[7, 3]

        IF USED("ComboTipo")
            USE IN ComboTipo
        ENDIF
        CREATE CURSOR ComboTipo (Titulo C(20), Rotina C(20), ColunaLi M)

        loc_aComboTipo[1, 1] = "Lista de Pre" + CHR(231) + "o"
        loc_aComboTipo[1, 2] = "ListaPreco"
        loc_aComboTipo[1, 3] = "Empresa,Emps c(3), Nome da Lista,NomeLista c(20)," + ;
                               "C" + CHR(243) + "digo Produto,cPros c(14),Valor ,Valor c(16)," + ;
                               "Data Inicial,DataIni d,Data Final,DataFim d,Preco De ,PrecoDe c(16)"

        loc_aComboTipo[2, 1] = "Transferencia"
        loc_aComboTipo[2, 2] = "GeraTransf"
        loc_aComboTipo[2, 3] = "Empresa Origem,EmpresaO c(6),Empresa Destino,EmpresaD c(6)," + ;
                               "Categoria ,Categoria c(10),Colecao,Colecao c(20),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Grupo,Grupo c(10),Prazo Entrega ,prazo d," + ;
                               "Codigo Barra,CBars n(14|0),Cor,Cors c(4),Tamanho,Tams c(4) "

        loc_aComboTipo[3, 1] = "Precificacao"
        loc_aComboTipo[3, 2] = "AtuaPreco"
        loc_aComboTipo[3, 3] = "Referencia,Referencia c(20),Data Inicio,dtInicial d," + ;
                               "Data Termino,dtFinal d,Valor Venda,PrecoVen c(16)," + ;
                               "Preco Especial,PrecoEsp c(16),Produto Off,ProdOff c(1)"

        loc_aComboTipo[4, 1] = "Pedido Terceiro"
        loc_aComboTipo[4, 2] = "GeraPedido"
        loc_aComboTipo[4, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        loc_aComboTipo[5, 1] = "Pedido Consignado"
        loc_aComboTipo[5, 2] = "Pedidocons"
        loc_aComboTipo[5, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        loc_aComboTipo[6, 1] = "Pedido Fabrica"
        loc_aComboTipo[6, 2] = "PedidoFab"
        loc_aComboTipo[6, 3] = "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5), " + ;
                               "Valor ,Units n(12|5),Moeda,Moedas c(3),Prazo ,prazoents d," + ;
                               "Movimentacao, Dopes c(20)"

        loc_aComboTipo[7, 1] = "Pedido Acessorio"
        loc_aComboTipo[7, 2] = "PedAcesso"
        loc_aComboTipo[7, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
                               "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
                               "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
                               "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

        *-- Legado: so entra no combo a rotina a que o usuario tem acesso
        FOR loc_nI = 1 TO ALEN(loc_aComboTipo, 1)
            IF fChecaAcesso("SIGPRILA", UPPER(loc_aComboTipo[loc_nI, 2]))
                INSERT INTO ComboTipo (Titulo, Rotina, ColunaLi) ;
                    VALUES (loc_aComboTipo[loc_nI, 1], ;
                            loc_aComboTipo[loc_nI, 2], ;
                            loc_aComboTipo[loc_nI, 3])
            ENDIF
        ENDFOR

        SELECT ComboTipo
        GO TOP

        loc_oCombo = THIS.cnt_4c_planilha.cbo_4c_CmbTipos
        WITH loc_oCombo
            .RowSourceType = 6
            .RowSource     = "ComboTipo.Titulo,Rotina,ColunaLi"
            .Style         = 2
            .ColumnCount   = 1
        ENDWITH

        *-- Legado (fim de PreencheTipo): os dois blocos opcionais nascem
        *-- ocultos e so CompletaLista os exibe, conforme o tipo escolhido
        WITH THIS.cnt_4c_planilha
            .lbl_4c_Label5.Visible   = .F.
            .obj_4c_OptTipo.Visible  = .F.
            .lbl_4c_Label6.Visible   = .F.
            .obj_4c_OptPreco.Visible = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarTipo - Posiciona o cursor ComboTipo na rotina escolhida em
    * cmbTipos e carrega Rotina/ColunaLi no BO (sigprilaBO.CarregarDoCursor).
    *
    * O legado le ComboTipo.Titulo/Rotina/ColunaLi logo depois de um "Select
    * ComboTipo", contando com o ponteiro que o RowSourceType = 6 (Fields)
    * move ao escolher o item. Aqui o ponteiro eh CONFIRMADO por LOCATE sobre
    * o Titulo (que eh o .Value do combo, BoundColumn = 1): mesmo resultado do
    * legado, sem depender do efeito colateral do binding.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SelecionarTipo()
        LOCAL loc_cTitulo, loc_lAchou
        loc_lAchou = .F.

        IF USED("ComboTipo")
            loc_cTitulo = ALLTRIM(THIS.cnt_4c_planilha.cbo_4c_CmbTipos.Value)
            SELECT ComboTipo
            IF !EMPTY(loc_cTitulo)
                LOCATE FOR ALLTRIM(ComboTipo.Titulo) == loc_cTitulo
                loc_lAchou = FOUND()
            ENDIF
            IF !loc_lAchou AND !EOF("ComboTipo")
                loc_lAchou = .T.
            ENDIF
            IF loc_lAchou AND VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarDoCursor("ComboTipo")
            ENDIF
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * CompletaLista - Transcricao de SIGPRILA.CompletaLista (dump, linha 744).
    * Carrega em List1 a ordem de colunas da rotina escolhida e exibe/oculta
    * os dois blocos opcionais conforme o Titulo - os nomes testados no
    * INLIST sao os do legado, sem acento, e definem a regra:
    *   Validar (Say5/OptTipo)  -> Transferencia, Precificacao e os 4 Pedidos
    *   Preco   (Say6/OptPreco) -> somente os 4 Pedidos
    *--------------------------------------------------------------------------
    PROCEDURE CompletaLista()
        LOCAL loc_cTitulo, loc_oPnl

        IF !USED("ComboTipo")
            RETURN
        ENDIF

        THIS.SelecionarTipo()

        loc_oPnl    = THIS.cnt_4c_planilha
        loc_cTitulo = UPPER(ALLTRIM(ComboTipo.Titulo))

        loc_oPnl.obj_4c_List1.RowSourceType = 1
        loc_oPnl.obj_4c_List1.RowSource     = ALLTRIM(ComboTipo.ColunaLi)

        IF INLIST(loc_cTitulo, "TRANSFERENCIA", "PRECIFICACAO", "PEDIDO TERCEIRO", ;
                               "PEDIDO CONSIGNADO", "PEDIDO FABRICA", "PEDIDO ACESSORIO")
            loc_oPnl.lbl_4c_Label5.Visible  = .T.
            loc_oPnl.obj_4c_OptTipo.Visible = .T.
        ELSE
            loc_oPnl.lbl_4c_Label5.Visible  = .F.
            loc_oPnl.obj_4c_OptTipo.Visible = .F.
        ENDIF

        IF INLIST(loc_cTitulo, "PEDIDO TERCEIRO", "PEDIDO CONSIGNADO", ;
                               "PEDIDO FABRICA", "PEDIDO ACESSORIO")
            loc_oPnl.lbl_4c_Label6.Visible   = .T.
            loc_oPnl.obj_4c_OptPreco.Visible = .T.
        ELSE
            loc_oPnl.lbl_4c_Label6.Visible   = .F.
            loc_oPnl.obj_4c_OptPreco.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CriaPlanilha - Transcricao de SIGPRILA.CriaPlanilha (dump, linha 769).
    * Valida tipo e arquivo, monta TmpPlanilha com a estrutura da coluna 2 da
    * List1 (trocando "|" por ",") e importa o .xls com APPEND FROM ... TYPE
    * XL5. Descarta a 1a linha quando ChkCabecalho esta marcado.
    *
    * SET SAFETY eh salvo/desligado/restaurado em volta do CREATE TABLE: o
    * legado roda com SAFETY OFF do ambiente Fortyus e um dialogo de
    * sobrescrita travaria a tela (regra #6 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CriaPlanilha()
        LOCAL loc_lSucesso, loc_cComando, loc_nCnt, loc_cPasta, loc_cArquivo
        LOCAL loc_cSafety, loc_lLeu, loc_oErro, loc_oPnl
        loc_lSucesso = .F.
        loc_oPnl     = THIS.cnt_4c_planilha

        IF EMPTY(loc_oPnl.cbo_4c_CmbTipos.Value)
            MsgErro("Tipo Inv" + CHR(225) + "lido", "")
            loc_oPnl.cbo_4c_CmbTipos.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(loc_oPnl.txt_4c_Planilha.Value)
            MsgErro("Arquivo Inv" + CHR(225) + "lido", "")
            loc_oPnl.cmd_4c_Cmdgetp.SetFocus()
            RETURN .F.
        ENDIF

        IF USED("TmpPlanilha")
            USE IN TmpPlanilha
        ENDIF

        loc_cPasta = ADDBS(SYS(5) + SYS(2003))

        *-- Estrutura de TmpPlanilha: coluna 2 de cada item de List1
        loc_cComando = "CREATE TABLE TmpPlanilha ("
        FOR loc_nCnt = 1 TO loc_oPnl.obj_4c_List1.ListCount
            loc_cComando = loc_cComando + loc_oPnl.obj_4c_List1.List(loc_nCnt, 2) + ","
        ENDFOR

        IF RIGHT(loc_cComando, 1) = ","
            loc_cComando = SUBSTR(loc_cComando, 1, LEN(loc_cComando) - 1)
        ENDIF

        loc_cComando = loc_cComando + ")"
        loc_cComando = STRTRAN(loc_cComando, "|", ",")

        loc_cSafety = SET("Safety")
        SET SAFETY OFF

        loc_lLeu = .F.
        TRY
            *-- O DELETE FILE fica DENTRO do TRY: TmpPlanilha.dbf aberto por
            *-- outro processo (a propria planilha/sessao anterior) faz o
            *-- comando estourar "File access is denied", e o legado, que o
            *-- deixa solto, exibe nesse caso o Program Error cru do VFP. Aqui
            *-- a falha cai no CATCH e sai pela mensagem do proprio legado
            *-- ("Verifique se a planilha nao esta aberta..."), que descreve
            *-- exatamente essa situacao.
            IF FILE(loc_cPasta + "TmpPlanilha.dbf")
                DELETE FILE (loc_cPasta + "TmpPlanilha.dbf")
            ENDIF

            &loc_cComando

            SELECT TmpPlanilha
            loc_cArquivo = ALLTRIM(loc_oPnl.txt_4c_Planilha.Value)
            APPEND FROM (loc_cArquivo) TYPE XL5
            loc_lLeu = .T.
        CATCH TO loc_oErro
            loc_lLeu = .F.
        ENDTRY

        IF loc_cSafety = "ON"
            SET SAFETY ON
        ENDIF

        IF loc_lLeu
            SELECT TmpPlanilha
            IF loc_oPnl.chk_4c_ChkCabecalho.Value = 1
                GO TOP
                DELETE
            ENDIF
            loc_lSucesso = .T.
        ELSE
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o cursor tempor" + ;
                    CHR(225) + "rio." + CHR(13) + ;
                    "Verifique se a planilha n" + CHR(227) + "o est" + CHR(225) + ;
                    " aberta ou que esteja salva com o Formato :" + CHR(13) + ;
                    "Microsoft Excel 5.0/95 (.xls)", ;
                    "Problema na Leitura da Planilha")
            loc_lSucesso = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMetodoRotina - Traduz o nome da rotina do legado (ComboTipo.Rotina)
    * para o nome do metodo correspondente em sigprilaBO. O legado chama o
    * metodo por macro no PROPRIO form ("ThisForm." + Rotina + "()"); na
    * arquitetura em camadas a importacao eh regra de negocio e mora no BO,
    * com nomes proprios (PILAR 3). Rotina desconhecida devolve "".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterMetodoRotina(par_cRotina)
        LOCAL loc_cRotina, loc_cMetodo
        loc_cRotina = UPPER(ALLTRIM(IIF(VARTYPE(par_cRotina) = "C", par_cRotina, "")))
        loc_cMetodo = ""

        DO CASE
            CASE loc_cRotina == "LISTAPRECO"
                loc_cMetodo = "ImportarListaPreco"
            CASE loc_cRotina == "GERATRANSF"
                loc_cMetodo = "ImportarTransferencia"
            CASE loc_cRotina == "ATUAPRECO"
                loc_cMetodo = "ImportarPrecificacao"
            CASE loc_cRotina == "GERAPEDIDO"
                loc_cMetodo = "ImportarPedidoTerceiro"
            CASE loc_cRotina == "PEDIDOCONS"
                loc_cMetodo = "ImportarPedidoConsignado"
            CASE loc_cRotina == "PEDIDOFAB"
                loc_cMetodo = "ImportarPedidoFabrica"
            CASE loc_cRotina == "PEDACESSO"
                loc_cMetodo = "ImportarPedidoAcessorio"
        ENDCASE

        RETURN loc_cMetodo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidaCols - Transcricao de SIGPRILA.ValidaCols (dump, linha 2226):
    *     Lparameters pFrm, pPar
    *     Return (Vartype(pFrm.ReadMethod(pPar))=[C])
    * O legado pergunta "o objeto possui a rotina com este nome?" lendo o
    * fonte do metodo com ReadMethod (que so devolve Caractere quando o metodo
    * existe). O equivalente aqui eh PEMSTATUS sobre o objeto que hospeda a
    * rotina - o BO -, usando o nome traduzido por ObterMetodoRotina. Quando
    * devolve .F., Processamento exibe a MESMA mensagem do legado
    * ("Metodo <rotina> nao localizado"), que eh o ponto onde a falta de uma
    * rotina aparece ALTO para o usuario, exatamente como no original.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidaCols(par_oDestino, par_cRotina)
        LOCAL loc_cMetodo, loc_lOk
        loc_lOk     = .F.
        loc_cMetodo = THIS.ObterMetodoRotina(par_cRotina)

        IF !EMPTY(loc_cMetodo) AND VARTYPE(par_oDestino) = "O"
            loc_lOk = PEMSTATUS(par_oDestino, loc_cMetodo, 5)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarRotinaImportacao - Substitui a macro do legado
    *     lcRotina = 'ThisForm.'+Alltrim(ComboTipo.Rotina)+[()]
    *     &lcRotina
    * chamando o metodo correspondente em sigprilaBO. O nome so chega aqui
    * depois de ValidaCols confirmar que ele existe no BO, entao a chamada
    * por EVALUATE (regra #15 - leitura/chamada por nome montado) nao cai em
    * membro inexistente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarRotinaImportacao(par_cRotina)
        LOCAL loc_cMetodo, loc_oBO, loc_uRetorno, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cMetodo  = THIS.ObterMetodoRotina(par_cRotina)
        loc_oBO      = THIS.this_oBusinessObject

        IF !EMPTY(loc_cMetodo) AND VARTYPE(loc_oBO) = "O"
            TRY
                loc_uRetorno = EVALUATE("loc_oBO." + loc_cMetodo + "()")
                loc_lSucesso = IIF(VARTYPE(loc_uRetorno) = "L", loc_uRetorno, .T.)
            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Procedure: " + loc_oErro.Procedure, ;
                        "Erro na importa" + CHR(231) + CHR(227) + "o da planilha")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processamento - Transcricao de SIGPRILA.Processamento (dump, linha 2203):
    *   If ThisForm.CriaPlanilha()
    *       If ThisForm.ValidaCols(ThisForm, Alltrim(ComboTipo.Rotina))
    *           If MessageBox(<aviso de ordem das colunas>,4+64+256,'') = 6
    *               &('ThisForm.'+Rotina+'()')
    *           EndIf
    *       Else
    *           MessageBox('Metodo '+Rotina+' nao localizado',16,'')
    *       EndIf
    *   EndIf
    *   thisform.cntplanilha.getPlanilha.Value = ''
    *
    * O texto do aviso eh literal do legado (4+64+256 = Sim/Nao com default no
    * Nao -> MsgConfirma, que devolve LOGICAL, regra #7) e a limpeza final do
    * campo Planilha roda em QUALQUER caminho, igual ao dump.
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_cRotina, loc_cAviso

        *-- FormParaBO ANTES do CriaPlanilha (o legado nao tem este hook: le os
        *-- controles direto, em cada rotina). Transferir primeiro garante que o
        *-- BO espelhe a tela em TODO caminho - inclusive quando CriaPlanilha
        *-- recusa o tipo/arquivo -, o que o BOParaForm do fim depende para nao
        *-- devolver criterio de uma execucao ANTERIOR por cima do que o usuario
        *-- acabou de marcar. Nenhuma mudanca de comportamento: CriaPlanilha le
        *-- cbo_4c_CmbTipos/List1/txt_4c_Planilha, nao o ponteiro de ComboTipo.
        THIS.FormParaBO()

        IF THIS.CriaPlanilha()
            loc_cRotina = ALLTRIM(THIS.this_oBusinessObject.this_cRotina)

            IF THIS.ValidaCols(THIS.this_oBusinessObject, loc_cRotina)
                loc_cAviso = "Aten" + CHR(231) + CHR(227) + "o, a ordem das colunas " + ;
                             CHR(233) + " muito importante. Certifique-se que elas est" + ;
                             CHR(227) + "o corretas." + CHR(13) + ;
                             "Ordem incorreta resultar" + CHR(225) + " em uma importa" + ;
                             CHR(231) + CHR(227) + "o incorreta, e este processo " + ;
                             CHR(233) + " irrevers" + CHR(237) + "vel." + CHR(13) + ;
                             "Tem certeza que deseja continuar a importa" + CHR(231) + ;
                             CHR(227) + "o com a ordem selecionada"

                IF MsgConfirma(loc_cAviso, "")
                    THIS.ExecutarRotinaImportacao(loc_cRotina)
                ENDIF
            ELSE
                MsgErro("M" + CHR(233) + "todo " + loc_cRotina + " n" + CHR(227) + ;
                        "o localizado", "")
            ENDIF
        ENDIF

        *-- "thisform.cntplanilha.getPlanilha.Value = ''" do legado, em UM lugar
        *-- so: limpa a property e deixa o BOParaForm espelhar no campo. Antes a
        *-- limpeza era escrita DUAS vezes (campo e property), que eh a origem da
        *-- divergencia silenciosa entre tela e BO.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cArquivoPlanilha = ""
        ENDIF
        THIS.BOParaForm()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere o estado da tela para sigprilaBO antes de rodar a
    * rotina de importacao. PROTECTED EXPLICITO: FormBase declara este hook
    * como PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo.
    *
    * chk_4c_ChkCabecalho.Value eh NUMERICO (0/1) e vai para uma property
    * LOGICA do BO - a conversao eh explicita, nunca atribuicao direta.
    * OptionGroup.Value ja eh o INDICE 1-based das opcoes (OptTipo 1..3,
    * OptPreco 1..2), igual ao que o legado le em lnTipo/lnTpPre.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPnl, loc_oBO

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) = "O"
            *-- Rotina/ColunaLi vem da linha corrente de ComboTipo
            THIS.SelecionarTipo()

            loc_oPnl = THIS.cnt_4c_planilha
            loc_oBO.this_cArquivoPlanilha = ALLTRIM(loc_oPnl.txt_4c_Planilha.Value)
            loc_oBO.this_lIncluiCabecalho = (loc_oPnl.chk_4c_ChkCabecalho.Value = 1)
            loc_oBO.this_nTipoBusca       = loc_oPnl.obj_4c_OptTipo.Value
            loc_oBO.this_nTipoPreco       = loc_oPnl.obj_4c_OptPreco.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Caminho inverso do FormParaBO: devolve a tela o estado dos
    * criterios guardado em sigprilaBO. PROTECTED EXPLICITO: FormBase declara
    * este hook como PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo
    * (o mesmo motivo do FormParaBO acima).
    *
    * O legado nao tem este hook - cada rotina le os controles direto
    * (ThisForm.cntplanilha.OptTipo.Value, ...), entao tela e criterio sao a
    * MESMA coisa la. Na arquitetura em camadas o criterio mora no BO, e quem
    * o altera fora da tela precisa de um caminho de volta: eh o que o fim do
    * Processamento usa para reproduzir o "getPlanilha.Value = ''" do legado
    * sem escrever a limpeza duas vezes, e o que o InicializarForm usa para o
    * painel abrir no estado do BO.
    *
    * Conversoes espelhadas, nunca atribuicao direta (regras do CLAUDE.md):
    *   property LOGICA -> chk_4c_ChkCabecalho.Value, que eh NUMERICO (0/1);
    *   OptionGroup.Value eh INDICE 1-based - valor fora de faixa (0, vindo de
    *   property nao inicializada) atribuido a um OptionGroup deixa TODOS os
    *   botoes desmarcados, por isso o piso de 1 e o teto do ButtonCount.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPnl, loc_oBO, loc_nTipo, loc_nPreco

        loc_oBO = THIS.this_oBusinessObject
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        loc_oPnl = THIS.cnt_4c_planilha
        IF VARTYPE(loc_oPnl) != "O"
            RETURN
        ENDIF

        loc_oPnl.txt_4c_Planilha.Value = ALLTRIM(loc_oBO.this_cArquivoPlanilha)
        loc_oPnl.chk_4c_ChkCabecalho.Value = IIF(loc_oBO.this_lIncluiCabecalho, 1, 0)

        loc_nTipo = loc_oBO.this_nTipoBusca
        IF loc_nTipo < 1 OR loc_nTipo > loc_oPnl.obj_4c_OptTipo.ButtonCount
            loc_nTipo = 1
        ENDIF
        loc_oPnl.obj_4c_OptTipo.Value = loc_nTipo

        loc_nPreco = loc_oBO.this_nTipoPreco
        IF loc_nPreco < 1 OR loc_nPreco > loc_oPnl.obj_4c_OptPreco.ButtonCount
            loc_nPreco = 1
        ENDIF
        loc_oPnl.obj_4c_OptPreco.Value = loc_nPreco
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Legado: Grupo_Botao.cmdok.Click
    *     If Thisform.Planilha / ThisForm.ChecaPlanilha() / Else /
    *     ThisForm.Processamento() / EndIf
    *
    * O ramo .T. eh MORTO no legado: ThisForm.Planilha (espelhado em
    * sigprilaBO.this_lPlanilha) nasce .F. e nao eh atribuido em lugar nenhum
    * do dump, e o metodo ChecaPlanilha NAO EXISTE no SCX (nao aparece na
    * SECAO 3). Transcrever a chamada produziria exatamente o defeito da
    * regra #13 do CLAUDE.md - nome desconhecido compila limpo e estoura em
    * runtime procurando "checaplanilha.prg" -, entao so o caminho vivo
    * (Processamento) eh portado, com o estado morto preservado como
    * propriedade do BO para fidelidade de PILAR 1.
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_oErro

        TRY
            THIS.Processamento()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao processar a planilha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Legado: Grupo_Botao.cmdsair.Click -> thisform.Release
    * Fecha a tela. Tambem eh o destino do ESC (KeyPress do form), como no
    * legado, que chama "thisform.grupo_Botao.cmdsair.Click".
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGetPlanilhaClick - Legado: cntplanilha.cmdgetp.Click
    *     This.Parent.getPlanilha.Value = GetFile('xls','Planilha','Importar')
    * GETFILE devolve "" quando o usuario cancela - o legado grava esse vazio
    * no campo, limpando a selecao anterior, e esse comportamento eh mantido.
    *--------------------------------------------------------------------------
    PROCEDURE BtnGetPlanilhaClick()
        LOCAL loc_cArquivo, loc_oErro

        TRY
            loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
            THIS.cnt_4c_planilha.txt_4c_Planilha.Value = loc_cArquivo

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cArquivoPlanilha = ALLTRIM(loc_cArquivo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao selecionar a planilha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboTiposInteractiveChange - Legado: cntplanilha.cmbTipos.
    * InteractiveChange -> ThisForm.Completalista()
    *--------------------------------------------------------------------------
    PROCEDURE CboTiposInteractiveChange()
        LOCAL loc_oErro

        TRY
            THIS.CompletaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao trocar o tipo de importa" + ;
                    CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Legado: SIGPRILA.KeyPress
    *     LPARAMETERS nKeyCode, nShiftAltCtrl
    *     If nKeyCode = 27 / thisform.grupo_Botao.cmdsair.Click / EndIf
    * KeyPreview = .T. na classe garante que o FORM veja a tecla antes dos
    * controles - o SCX nao declara a propriedade (fica no default .F.), mas
    * sem ela o handler de ESC que o legado escreveu nunca dispararia com o
    * foco dentro do combo/lista/campo, e o ESC eh a saida que o usuario
    * espera desta tela (PILAR 1 - comportamento pretendido pelo legado).
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis apos
    * AddObject (que os cria com Visible = .F. por padrao).
    *
    * EXCECAO: lbl_4c_Label5/obj_4c_OptTipo/lbl_4c_Label6/obj_4c_OptPreco
    * nascem com Visible = .F. de proposito (ConfigurarCamposPlanilhaParte2 -
    * CompletaLista() do legado so os exibe para tipos de importacao
    * especificos). Pular a atribuicao de Visible para esses nomes, mas
    * continuar recursando dentro deles (caso de obj_4c_OptTipo/obj_4c_OptPreco,
    * que sao containers com Buttons filhos) para nao deixar os filhos
    * Visible = .F. quando a visibilidade do grupo for restaurada depois.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p, loc_lPularVisible

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                loc_lPularVisible = INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LABEL5", "OBJ_4C_OPTTIPO", ;
                    "LBL_4C_LABEL6", "OBJ_4C_OPTPRECO")

                IF !loc_lPularVisible AND PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Encerramento padrao (restauracao de menu herdada de FormBase)
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
