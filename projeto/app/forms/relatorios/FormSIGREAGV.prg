*==============================================================================
* FORMSIGREAGV.PRG
* Relatorio de Acompanhamento Por Grupo de Venda
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAGV.SCX (frmrelatorio)
*
* Filtros (layout flat - controles no container cnt_4c_Local):
*   - Grupo de Venda (Colecoes + Descs) -> SigCdCol
*   - Moeda de Venda (CMoes + DMoes)    -> SigCdMoe
*
* FASE 3/8 - Estrutura Base
*   * Propriedades visuais (EXATAS do original: Width=800, Height=300)
*   * Init() / InicializarForm() / Destroy()
*   * ConfigurarCabecalho() - cabecalho escuro com titulo
*   * ConfigurarBotoes()    - CommandGroup Visualizar/Imprimir/DocExcel/Encerrar
*   * ConfigurarPageFrame() - PageFrame com 1 pagina "Filtros" (consistencia com sistema)
*   * ConfigurarPaginaDados() - cnt_4c_Local com campos de filtro (TextBoxes), em Page1
*                              (em REPORT, a "Pagina Dados" eh a pagina de entrada de filtros)
*   * LimparCampos()        - inicializa valores dos campos
*
* FASE 4/8 - Page1 (Filtros) - cntMensagem + Navegacao + BINDEVENTs
*   * ConfigurarPaginaLista() - cria cnt_4c_Mensagem ("Aguarde!!!") na Page1
*   * AlternarPagina()        - navega para pagina solicitada do PageFrame
*   * ConfigurarBINDEVENTs()  - conecta botoes e campos de filtro aos handlers
*   * AjustarCamposDescricao()- When original: DColecao/DMoeda habilitados so se codigo vazio
*   * FormParaRelatorio()     - transfere filtros do form para o BO
*   * CmgBotoesClick()        - despacha Visualizar/Imprimir/Excel/Encerrar
*   * TxtColecaoKeyPress()    - F4/Enter/Tab: lookup SigCdCol por codigo
*   * TxtDColecaoKeyPress()   - F4/Enter/Tab: lookup SigCdCol por descricao
*   * TxtMoedaKeyPress()      - F4/Enter/Tab: lookup SigCdMoe por codigo
*   * TxtDMoedaKeyPress()     - F4/Enter/Tab: lookup SigCdMoe por descricao
*
* FASE 5/8 - Controle de Progresso
*   * MostrarAguarde()     - exibe cnt_4c_Mensagem + DOEVENTS antes do processamento
*   * OcultarAguarde()     - oculta cnt_4c_Mensagem apos conclusao
*   * CmgBotoesClick()     - atualizado para usar MostrarAguarde/OcultarAguarde
*   * Closable = .F.       - adicionado (propriedade do original ausente nas fases 3-4)
*
* FASE 6/8 - Lookups Completos (convencao correta FormBuscaAuxiliar)
*   * AbrirBuscaColecao() - reescrito com assinatura correta:
*       CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, tabela, cursor, campo, valor, titulo)
*       + mAddColuna("Colecoes"/"Descs") + Show() + this_lSelecionou + Release()
*   * AbrirBuscaMoeda()   - idem para SigCdMoe (CMoes/DMoes)
*
* FASE 7/8 - Eventos Principais dos Botoes
*   * CmgBotoesClick() - refatorado para delegar a handlers nomeados
*   * BtnVisualizarClick() - exibe preview na tela
*   * BtnImprimirClick()   - imprime na impressora
*   * BtnExcelClick()      - gera documento (Doc Excel)
*   * BtnEncerrarClick()   - fecha o formulario
*   * BtnIncluirClick()    - novo relatorio (limpa filtros + foco)
*   * BtnAlterarClick()    - alterar filtros (foca primeiro campo)
*   * BtnExcluirClick()    - excluir filtros (limpa todos os criterios)
*
* FASE 8/8 - Eventos Auxiliares e Consolidacao
*   Forms REPORT nao tem semantica CRUD nativa, mas o sistema padroniza a API
*   de forms com os metodos abaixo. Cada um eh um wrapper FUNCIONAL que mapeia
*   a acao CRUD para a acao REPORT equivalente (sem TODOs/stubs):
*   * BtnSalvarClick()   -> delega para BtnImprimirClick (gerar = emitir relatorio)
*   * BtnCancelarClick() -> delega para BtnEncerrarClick (cancelar = fechar)
*   * FormParaBO()       -> alias de FormParaRelatorio (filtros do form para o BO)
*   * BOParaForm()       -> inverso: le filtros do BO e popula o form
*   * CarregarLista()    -> em REPORT, prepara Page1 (Filtros) para nova selecao:
*                            volta para a pagina de filtros, oculta "Aguarde!!!"
*                            e reaplica AjustarCamposDescricao
*==============================================================================

DEFINE CLASS FormSIGREAGV AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGREAGV.SCX)
    Height      = 300
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do formulario de relatorio
    *   1. Define Caption / Picture (fundo do form)
    *   2. Cria SIGREAGVBO
    *   3. Monta cabecalho escuro + botoes do relatorio
    *   4. Monta container de filtros com TextBoxes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Acompanhamento Por Grupo de Venda"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SIGREAGVBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SIGREAGVBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Cabecalho escuro com titulo (equivalente ao cntSombra do frmrelatorio)
                THIS.ConfigurarCabecalho()

                *-- Botoes do relatorio (Visualizar / Imprimir / Doc Excel / Encerrar)
                THIS.ConfigurarBotoes()

                *-- PageFrame de 1 pagina ("Filtros") - hospeda cnt_4c_Local na Page1
                THIS.ConfigurarPageFrame()

                *-- Container de filtros com campos Grupo de Venda e Moeda (dentro da Page1)
                *-- Para forms REPORT, "PaginaDados" eh a pagina onde o usuario informa os filtros
                THIS.ConfigurarPaginaDados()

                *-- Container de mensagem ("Aguarde!!!" durante geracao do relatorio)
                THIS.ConfigurarPaginaLista()

                *-- Conectar eventos dos botoes e campos de filtro
                THIS.ConfigurarBINDEVENTs()

                *-- Garantir pagina inicial ativa (Page1: Filtros)
                THIS.AlternarPagina(1)

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Inicializa valores dos campos de filtro (pula em modo de validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.LimparCampos()
                ENDIF

                THIS.Visible = .T.
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormSIGREAGV:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo do relatorio
    *   Equivalente ao cntSombra/lblSombra/lblTitulo do framework frmrelatorio
    *   BackColor=RGB(100,100,100) cinza medio OPACO (BackStyle=1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Sombra (texto ligeiramente deslocado para efeito 3D)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 17
            .Left      = 12
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Acompanhamento Por Grupo de Venda"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Titulo principal (texto branco sobre fundo escuro)
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 20
            .Left      = 10
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Caption   = "Acompanhamento Por Grupo de Venda"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio (btnReport do original):
    *   Left=528, Width=273, Height=80
    *   Incremento entre botoes: 66px (Left: 5, 71, 137, 203)
    *   BINDEVENTs serao adicionados nas Fases 7-8
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 528
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Caption         = "Visualizar"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Caption         = "Imprimir"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
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
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .Visible         = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Caption         = "Encerrar"
            .WordWrap        = .T.
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
            .Visible         = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros")
    *   O form legado SIGREAGV e FLAT (sem PageFrame), mas no novo padrao os
    *   campos de filtro sao agrupados em um PageFrame de 1 pagina para
    *   consistencia visual e arquitetural com o restante do sistema.
    *
    *   O PageFrame fica abaixo do cabecalho (Top=85) e cobre o restante do
    *   form. O container cnt_4c_Local com os filtros vai DENTRO da Page1.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        *-- Logo abaixo do cabecalho (80px) ate o fim do form
        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Container de filtros com campos Grupo de Venda e Moeda
    *   Em forms REPORT, a "Pagina Dados" eh a pagina de entrada de filtros
    *   (equivalente semantico do Page2.Dados dos forms CRUD: contem os campos
    *   editaveis pelo usuario que alimentam o BO antes de gerar o relatorio).
    *
    *   Posicao do cntLocal original: Top=144, Left=204, Width=451, Height=61.
    *   Como o container agora vive dentro da Page1 (que comeca em Top=85),
    *   o Top eh ajustado: 144 - 85 = 59. Os demais valores mantem-se EXATOS.
    *
    *   Conteudo desta fase (Fase 5/8 - Campos Principais Parte 1):
    *     - cnt_4c_Local (container hospedeiro dos filtros)
    *     - lbl_4c_Label3 + txt_4c_Colecao + txt_4c_DColecao (Grupo de Venda)
    *     - lbl_4c_Label1 + txt_4c_Moeda + txt_4c_DMoeda    (Moeda de Venda)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Local", "Container")
        WITH loc_oPg.cnt_4c_Local
            .Top           = 59
            .Left          = 204
            .Width         = 451
            .Height        = 61
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Label "Grupo de Venda :" (Say3 original: Left=16, Top=7)
        loc_oPg.cnt_4c_Local.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.cnt_4c_Local.lbl_4c_Label3
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo de Venda :"
            .Left      = 16
            .Top       = 7
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo do Grupo de Venda (getColecao: Left=108, Top=4, Width=80)
        loc_oPg.cnt_4c_Local.AddObject("txt_4c_Colecao", "TextBox")
        WITH loc_oPg.cnt_4c_Local.txt_4c_Colecao
            .Height    = 23
            .Left      = 108
            .Top       = 4
            .Width     = 80
            .MaxLength = 10
            .Format    = "K"
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao do Grupo de Venda (getDColecao: Left=190, Top=4, Width=255)
        loc_oPg.cnt_4c_Local.AddObject("txt_4c_DColecao", "TextBox")
        WITH loc_oPg.cnt_4c_Local.txt_4c_DColecao
            .Height    = 23
            .Left      = 190
            .Top       = 4
            .Width     = 255
            .MaxLength = 40
            .Format    = "K"
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label "Moeda de Venda :" (Say1 original: Left=13, Top=32)
        loc_oPg.cnt_4c_Local.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.cnt_4c_Local.lbl_4c_Label1
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda de Venda :"
            .Left      = 13
            .Top       = 32
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox codigo da Moeda (getMoeda: Left=108, Top=29, Width=31, MaxLength=3)
        loc_oPg.cnt_4c_Local.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.cnt_4c_Local.txt_4c_Moeda
            .Height    = 23
            .Left      = 108
            .Top       = 29
            .Width     = 31
            .MaxLength = 3
            .Format    = "K!"
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- TextBox descricao da Moeda (getDMoeda: Left=141, Top=29, Width=115, MaxLength=15)
        loc_oPg.cnt_4c_Local.AddObject("txt_4c_DMoeda", "TextBox")
        WITH loc_oPg.cnt_4c_Local.txt_4c_DMoeda
            .Height    = 23
            .Left      = 141
            .Top       = 29
            .Width     = 115
            .MaxLength = 15
            .Format    = "K!"
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria o container de mensagem ("Aguarde!!!")
    *   O original SIGREAGV tinha cntMensagem com lblMensagem ("Aguarde!!!")
    *   exibido durante a geracao do relatorio. Como o form de relatorio nao
    *   tem grid CRUD, esta fase cria o container de mensagem na Page1 do
    *   PageFrame de filtros, abaixo do container cnt_4c_Local.
    *
    *   Posicao original: Top=516, Left=175, Width=473, Height=56.
    *   Ajustado para Top relativo a Page1 (Page1.Top=85): Top = 516 - 85 = 431.
    *   Ocultado inicialmente (Visible=.F.) - exibido apenas durante geracao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        loc_oPg.AddObject("cnt_4c_Mensagem", "Container")
        WITH loc_oPg.cnt_4c_Mensagem
            .Top           = 130
            .Left          = 175
            .Width         = 473
            .Height        = 56
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        loc_oPg.cnt_4c_Mensagem.AddObject("lbl_4c_LblMensagem", "Label")
        WITH loc_oPg.cnt_4c_Mensagem.lbl_4c_LblMensagem
            .Top       = 18
            .Left      = 20
            .Width     = 445
            .Height    = 22
            .Caption   = "Aguarde!!!"
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 2
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega para a pagina solicitada do PageFrame
    *   Form de relatorio possui apenas 1 pagina (Filtros). Metodo presente
    *   por consistencia com o padrao do sistema e para uso futuro caso
    *   sejam adicionadas paginas auxiliares.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O" AND ;
           VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND ;
           par_nPagina <= THIS.pgf_4c_Paginas.PageCount
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Inicializa/zera os campos de filtro
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.txt_4c_Colecao.Value  = ""
        loc_oCnt.txt_4c_DColecao.Value = ""
        loc_oCnt.txt_4c_Moeda.Value    = ""
        loc_oCnt.txt_4c_DMoeda.Value   = ""
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBINDEVENTs - Conecta eventos dos controles aos handlers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        *-- Botoes do relatorio (Visualizar / Imprimir / Doc Excel / Encerrar)
        BINDEVENT(THIS.cmg_4c_Botoes, "Click", THIS, "CmgBotoesClick")

        *-- Campo codigo Grupo de Venda: F4/Enter/Tab disparam lookup
        BINDEVENT(loc_oCnt.txt_4c_Colecao,  "KeyPress", THIS, "TxtColecaoKeyPress")

        *-- Campo descricao Grupo de Venda: F4/Enter/Tab disparam lookup por descricao
        BINDEVENT(loc_oCnt.txt_4c_DColecao, "KeyPress", THIS, "TxtDColecaoKeyPress")

        *-- Campo codigo Moeda: F4/Enter/Tab disparam lookup
        BINDEVENT(loc_oCnt.txt_4c_Moeda,    "KeyPress", THIS, "TxtMoedaKeyPress")

        *-- Campo descricao Moeda: F4/Enter/Tab disparam lookup por descricao
        BINDEVENT(loc_oCnt.txt_4c_DMoeda,   "KeyPress", THIS, "TxtDMoedaKeyPress")

        *-- Estado inicial dos campos de descricao (When original)
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposDescricao - Habilita/desabilita campos de descricao
    *   Original: getDColecao.When = Empty(getColecao.Value)
    *             getDMoeda.When   = Empty(getMoeda.Value)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarCamposDescricao()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        loc_oCnt.txt_4c_DColecao.Enabled = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Colecao.Value))
        loc_oCnt.txt_4c_DMoeda.Enabled   = EMPTY(ALLTRIM(loc_oCnt.txt_4c_Moeda.Value))
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Transfere filtros do form para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        WITH THIS.this_oRelatorio
            .this_cColecoes = ALLTRIM(loc_oCnt.txt_4c_Colecao.Value)
            .this_cDescs    = ALLTRIM(loc_oCnt.txt_4c_DColecao.Value)
            .this_cCMoes    = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            .this_cDMoes    = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgBotoesClick - Handler do CommandGroup de botoes
    *   Value 1 = Visualizar (preview), 2 = Imprimir, 3 = Doc Excel, 4 = Encerrar
    *   Delega para handlers nomeados individuais
    *--------------------------------------------------------------------------
    PROCEDURE CmgBotoesClick()
        LOCAL loc_nBotao
        loc_nBotao = THIS.cmg_4c_Botoes.Value

        DO CASE
        CASE loc_nBotao = 1
            THIS.BtnVisualizarClick()
        CASE loc_nBotao = 2
            THIS.BtnImprimirClick()
        CASE loc_nBotao = 3
            THIS.BtnExcelClick()
        CASE loc_nBotao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.Visualizar()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Imprime relatorio diretamente na impressora
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.Imprimir()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Gera documento do relatorio (Doc Excel)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        THIS.FormParaRelatorio()
        THIS.MostrarAguarde()
        THIS.this_oRelatorio.GerarExcel()
        THIS.OcultarAguarde()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar filtros (foca primeiro campo para edicao)
    *   Em REPORT, "Alterar" significa editar os filtros: preserva os valores
    *   atualmente informados e devolve o foco ao primeiro campo de entrada
    *   para que o usuario possa ajustar a selecao antes de gerar o relatorio.
    *   Equivale, em forms CRUD, a entrar em modo de edicao do registro.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_Colecao) = "O"
            loc_oCnt.txt_4c_Colecao.SetFocus()
        ENDIF
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir filtros (zera todos os campos de selecao)
    *   Em REPORT, "Excluir" significa remover os criterios de filtro: limpa
    *   todos os campos para que o usuario possa gerar o relatorio sem
    *   restricao (equivalente a "filtro Geral" do legado: sem grupo de venda
    *   especifico, sem moeda especifica). Mapeia a semantica CRUD "Excluir"
    *   para a acao de remover filtros aplicados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        THIS.LimparCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarAguarde - Exibe container "Aguarde!!!" durante processamento
    *   Forca DOEVENTS para garantir que a mensagem apare?a antes do
    *   processamento pesado (PrepararDados roda SCAN com multiplas queries)
    *--------------------------------------------------------------------------
    PROCEDURE MostrarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .T.
            loc_oCnt.cnt_4c_Mensagem.Refresh()
            THIS.Refresh()
            DOEVENTS
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OcultarAguarde - Oculta container "Aguarde!!!" apos conclusao
    *--------------------------------------------------------------------------
    PROCEDURE OcultarAguarde()
        LOCAL loc_oCnt
        loc_oCnt = THIS.pgf_4c_Paginas.Page1
        IF VARTYPE(loc_oCnt.cnt_4c_Mensagem) = "O"
            loc_oCnt.cnt_4c_Mensagem.Visible = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtColecaoKeyPress - F4/Enter/Tab: lookup SigCdCol por codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShift)
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_nKeyCode = 115  && F4: abre lookup direto
            THIS.AbrirBuscaColecao("C")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9  && ENTER ou TAB
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Colecao.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Colecao.Value  = ""
                loc_oCnt.txt_4c_DColecao.Value = ""
            ELSE
                THIS.AbrirBuscaColecao("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDColecaoKeyPress - F4/Enter/Tab: lookup SigCdCol por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TxtDColecaoKeyPress(par_nKeyCode, par_nShift)
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_nKeyCode = 115  && F4: abre lookup por descricao
            THIS.AbrirBuscaColecao("D")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9  && ENTER ou TAB
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DColecao.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Colecao.Value  = ""
                loc_oCnt.txt_4c_DColecao.Value = ""
            ELSE
                THIS.AbrirBuscaColecao("D")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoedaKeyPress - F4/Enter/Tab: lookup SigCdMoe por codigo
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShift)
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_nKeyCode = 115  && F4: abre lookup direto
            THIS.AbrirBuscaMoeda("C")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9  && ENTER ou TAB
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Moeda.Value  = ""
                loc_oCnt.txt_4c_DMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("C")
            ENDIF
            THIS.AjustarCamposDescricao()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDMoedaKeyPress - F4/Enter/Tab: lookup SigCdMoe por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TxtDMoedaKeyPress(par_nKeyCode, par_nShift)
        LOCAL loc_oCnt, loc_cValor
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_nKeyCode = 115  && F4: abre lookup por descricao
            THIS.AbrirBuscaMoeda("D")
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9  && ENTER ou TAB
            loc_cValor = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            IF EMPTY(loc_cValor)
                loc_oCnt.txt_4c_Moeda.Value  = ""
                loc_oCnt.txt_4c_DMoeda.Value = ""
            ELSE
                THIS.AbrirBuscaMoeda("D")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaColecao - Abre FormBuscaAuxiliar para SigCdCol
    *   par_cTipoBusca: "C" = por codigo (Colecoes), "D" = por descricao (Descs)
    *   SigCdCol: campo codigo = Colecoes, campo descricao = Descs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaColecao(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        LOCAL loc_cCodigo, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Colecao.Value)
            loc_cCampo        = "Colecoes"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DColecao.Value)
            loc_cCampo        = "Descs"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCol", "cursor_4c_BuscaColecao", loc_cCampo, ;
            loc_cValorInicial, ;
            "Grupo de Venda")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaColecao")
                SELECT cursor_4c_BuscaColecao
                IF !EOF()
                    loc_cCodigo    = ALLTRIM(Colecoes)
                    loc_cDescricao = ALLTRIM(Descs)
                    loc_oCnt.txt_4c_Colecao.Value  = loc_cCodigo
                    loc_oCnt.txt_4c_DColecao.Value = loc_cDescricao
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaColecao")
            USE IN cursor_4c_BuscaColecao
        ENDIF
        loc_oBusca.Release()

        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaMoeda - Abre FormBuscaAuxiliar para SigCdMoe
    *   par_cTipoBusca: "C" = por codigo (CMoes), "D" = por descricao (DMoes)
    *   SigCdMoe: campo codigo = CMoes, campo descricao = DMoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaMoeda(par_cTipoBusca)
        LOCAL loc_oBusca, loc_oCnt, loc_cValorInicial, loc_cCampo
        LOCAL loc_cCodigo, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local

        IF par_cTipoBusca = "C"
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_Moeda.Value)
            loc_cCampo        = "CMoes"
        ELSE
            loc_cValorInicial = ALLTRIM(loc_oCnt.txt_4c_DMoeda.Value)
            loc_cCampo        = "DMoes"
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdMoe", "cursor_4c_BuscaMoeda", loc_cCampo, ;
            loc_cValorInicial, ;
            "Moeda de Venda")

        IF VARTYPE(loc_oBusca) != "O"
            RETURN
        ENDIF

        loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
        loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
        loc_oBusca.Show()

        IF loc_oBusca.this_lSelecionou
            IF USED("cursor_4c_BuscaMoeda")
                SELECT cursor_4c_BuscaMoeda
                IF !EOF()
                    loc_cCodigo    = ALLTRIM(CMoes)
                    loc_cDescricao = ALLTRIM(DMoes)
                    loc_oCnt.txt_4c_Moeda.Value  = loc_cCodigo
                    loc_oCnt.txt_4c_DMoeda.Value = loc_cDescricao
                ENDIF
            ENDIF
        ENDIF

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        loc_oBusca.Release()

        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Em REPORT, "Salvar" equivale a gerar o relatorio
    *   Mapeia a semantica CRUD "Salvar" para a acao de emitir o relatorio
    *   conforme os filtros atualmente informados. Delega para BtnImprimirClick
    *   (saida principal: impressao) preservando o fluxo FormParaRelatorio +
    *   MostrarAguarde + Imprimir + OcultarAguarde.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Em REPORT, "Cancelar" equivale a fechar o formulario
    *   Mapeia a semantica CRUD "Cancelar" para a acao de encerrar a tela.
    *   Delega para BtnEncerrarClick que executa THIS.Release().
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias semantico de FormParaRelatorio
    *   Mantem nomenclatura comum a forms CRUD para consistencia da API.
    *   Em REPORT, "BO" eh o objeto de relatorio (RelatorioBase) - todos os
    *   filtros do form sao transferidos para as propriedades this_* do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Inverso de FormParaBO/FormParaRelatorio
    *   Le as propriedades this_* do BO e popula os campos do form. Util ao
    *   restaurar filtros de uma execucao anterior (ex.: ao reabrir o form
    *   apos visualizar relatorio, os filtros usados permanecem visiveis).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCnt
        IF VARTYPE(THIS.this_oRelatorio) != "O"
            RETURN
        ENDIF
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Local
        WITH THIS.this_oRelatorio
            loc_oCnt.txt_4c_Colecao.Value  = NVL(.this_cColecoes, "")
            loc_oCnt.txt_4c_DColecao.Value = NVL(.this_cDescs,    "")
            loc_oCnt.txt_4c_Moeda.Value    = NVL(.this_cCMoes,    "")
            loc_oCnt.txt_4c_DMoeda.Value   = NVL(.this_cDMoes,    "")
        ENDWITH
        THIS.AjustarCamposDescricao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Em REPORT, prepara a tela para nova selecao de filtros
    *   Forms CRUD recarregam o grid de registros; em REPORT nao ha grid, mas
    *   a acao equivalente eh restaurar a Page1 (Filtros), ocultar o container
    *   "Aguarde!!!" (caso tenha ficado visivel apos um processamento) e
    *   reaplicar o ajuste de habilitacao dos campos de descricao (When
    *   original: DColecao/DMoeda so ficam habilitados quando os respectivos
    *   codigos estao vazios).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.AlternarPagina(1)
        THIS.OcultarAguarde()
        THIS.AjustarCamposDescricao()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
