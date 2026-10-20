*==============================================================================
* FormSigOpArq.prg - Formulario de Geracao/Exportacao de Arquivos
*
* Tipo: OPERACIONAL - layout customizado, NAO segue padrao CRUD Page1/Page2
* Legado: SIGOPARQ.SCX (dialogo originalmente filho de outro form via
*         Lparameters poForm, operando sobre o cursor crGerArq compartilhado
*         por DataSession com o form pai). Migrado standalone, com BO proprio
*         (SigOpArqBO) que busca os itens exportaveis (Linhas/Grupos de
*         Produto, conforme Optiongroup1) direto do SQL Server para
*         cursor_4c_Dados.
*
* Fase 3/8: estrutura base (DEFINE CLASS, Init, InicializarForm, cabecalho,
* Destroy, TornarControlesVisiveis).
*
* Fase 4/8: Grid1 (grd_4c_Dados, 3 colunas: marca/arquivo/descricao) e
* Commandgroup1 (cmg_4c_Botoes: Gerar/Encerrar) + CarregarLista(). Este
* form NAO eh CRUD - nao tem Page1=Lista/Page2=Dados nem botoes
* Incluir/Alterar/Excluir (o legado SIGOPARQ.SCX nao os tem).
*
* Fase 5/8: Optiongroup1 (obj_4c_Optiongroup1: Linha / Grupo de Produto) e
* Label1 (lbl_4c_Label1: "Exportacao do Setor :"). Sao os dois unicos
* objetos visuais que faltavam no legado (ja cobre 100% da arvore do
* dump).
*
* Fase 6/8: fiacao dos eventos interativos que faltavam. Este form NAO tem
* nenhum TextBox de campo digitavel (os Text1 das Columns2/3 sao so
* leitura) e o dump nao contem fwBuscaExt/fwBuscaSel/sigacess em lugar
* nenhum - NAO HA lookup F4/F5 para implementar (analise.json.lookups = []).
* O trabalho real desta fase eh completar os 4 PROCEDUREs do
* comportamento.json ainda sem handler no migrado:
*   - Grid1.Column1.Check1.InteractiveChange -> chk_4c_Marca (toggle manual
*     via KeyPress/MouseUp/MouseDown/Click + NODEFAULT, regra do projeto
*     para CheckBox dentro de Column de Grid nao alternar pelo binding
*     nativo quando a coluna destino eh NUMERIC)
*   - Optiongroup1.InteractiveChange -> obj_4c_Optiongroup1
*   - Commandgroup1.Command1.Click (Gerar) -> Buttons(1)
*   - Commandgroup1.Command2.Click (Encerrar) -> Buttons(2)
*
* A cadeia de validacao do destino que o legado embutia no proprio
* InteractiveChange (destino vazio -> pasta invalida -> nome ja informado)
* fica em ValidarArquivoDestino(), metodo nomeado e PUBLIC: eh o
* equivalente, neste layout flat sem Page2 de Dados, do Valid de celula
* que os forms com campo digitavel tem. A marcacao do item e as duas
* ultimas checagens continuam com FONTE UNICA no BO.
*
* Fase 7/8: eventos principais dos botoes - CONFIRMADO completo. O legado
* SIGOPARQ.SCX nao tem Incluir/Alterar/Visualizar/Excluir (nao eh CRUD);
* os unicos botoes de acao do form sao Commandgroup1.Command1 ("Gerar") e
* Commandgroup1.Command2 ("Encerrar"), e os dois ja tem handler completo
* (BtnGerarClick/BtnEncerrarClick, fiados na Fase 6 junto com o toggle do
* Check1 e o InteractiveChange do Optiongroup1). Nenhum evento principal
* adicional a implementar nesta fase.
*
* Fase 8/8: eventos auxiliares e consolidacao final. Entregas desta fase:
*   - FormParaBO()/BOParaForm(): os dois hooks canonicos, com conteudo REAL.
*     O unico campo editavel da tela (Optiongroup1 "Exportacao do Setor") vai
*     para SigOpArqBO.this_nTipos e volta dele - o destino que no legado era
*     ThisForm.ParentForm.pnTipos. FormParaBO virou a FONTE UNICA dessa
*     transferencia (OptTiposInteractiveChange e BtnConfirmarClick passam por
*     ele); BOParaForm roda na abertura, refletindo o this_nTipos = 1 com que
*     o BO nasce (o "ParentForm.pnTipos = 1" do Init legado).
*   - BtnConfirmarClick()/BtnCancelarClick(): o CORPO de cada um dos dois
*     Click do Commandgroup1, sem o fechamento da janela, devolvendo .T./.F.
*     Os handlers fiados no BINDEVENT continuam nomeados pelo botao do legado
*     (BtnGerarClick/BtnEncerrarClick, Captions "Gerar"/"Encerrar" intactos -
*     PILAR 1) e apenas decidem fechar conforme o resultado. O Command2 do
*     legado nao eh um "sair" puro: antes do Release Windows ele faz
*     "Replace All nMarcas With 0", isto eh, CANCELA a selecao da grade - dai
*     o nome canonico ter conteudo de verdade aqui.
*
* Conferencia contra comportamento.json (6 metodos do dump legado):
*   1) SIGOPARQ.Procedure (=fConfigGeral())  -> no-op global via
*      utils\fconfiggeral.prg (regra do projeto: so para p-code legado
*      compilado; FormBase AS form nosso nao herda VCX nenhum, entao este
*      form nem chega a chamar fConfigGeral - nao se aplica aqui).
*   2) SIGOPARQ.Init (Lparameters poForm / captions / DataSessionId /
*      ParentForm.pnTipos=1 / crGerArq Go Top) -> standalone no migrado
*      (sem ParentForm/crGerArq compartilhado): captions em
*      ConfigurarPageFrame(), this_nTipos=1 no Init do BO,
*      cursor_4c_Dados.Go Top em CarregarLista().
*   3) Grid1.Column1.Check1.InteractiveChange -> ChkMarca* (KeyPress/
*      MouseUp/MouseDown/Click) + ValidarArquivoDestino() + ChkMarcaToggleExec().
*   4) Commandgroup1.Command1.Click (Gerar)    -> BtnConfirmarClick()
*      (validar + confirmar) + BtnGerarClick() (fechar).
*   5) Commandgroup1.Command2.Click (Encerrar) -> BtnCancelarClick()
*      (confirmar + Replace All) + BtnEncerrarClick() (fechar).
*   6) Optiongroup1.InteractiveChange -> OptTiposInteractiveChange().
*
* O que NAO se aplica a este layout, e por que: este form OPERACIONAL eh um
* dialogo de 1 tela (grid + checkbox + optiongroup + 2 botoes) sem Page1=
* Lista/Page2=Dados, sem modo INCLUIR/ALTERAR/VISUALIZAR e sem campos de
* cadastro. O dump legado nao tem botao de busca, nem botao de gravar, nem
* troca de modo - logo BtnBuscarClick, BtnSalvarClick, HabilitarCampos,
* LimparCampos e AjustarBotoesPorModo nao tem a que se referir aqui.
* Cria-los seria inventar funcionalidade ausente no original (viola o
* PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
* CarregarLista() existe desde a Fase 4 e cobre o papel de popular a grade.
*==============================================================================

DEFINE CLASS FormSigOpArq AS FormBase

    *-- Layout (pixel-perfect do legado SIGOPARQ.SCX)
    Width       = 800
    Height      = 200
    AutoCenter  = .T.
    BorderStyle = 2
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 1
    ShowWindow  = 1
    Themes      = .F.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro    = ""

    *==========================================================================
    * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Construcao completa do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Cria Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpArqBO")
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Arquivos"

            *-- Constroi os controles visuais (cabecalho + Grid + botoes de
            *-- acao nesta fase; OptionGroup/Label entram na Fase 5-6)
            THIS.ConfigurarControles()

            *-- Torna visiveis os controles ja criados
            THIS.TornarControlesVisiveis(THIS)

            *-- Estado inicial do BO (SigOpArqBO.Init faz this_nTipos = 1, o
            *-- mesmo "ThisForm.ParentForm.pnTipos = 1" do Init legado) refletido
            *-- no unico campo editavel da tela. Chamado DEPOIS de
            *-- ConfigurarControles porque o Optiongroup1 so existe a partir dela.
            THIS.BOParaForm()

            *-- Popula a grade (pulado em validacao de UI/teste automatizado,
            *-- que nao tem conexao SQL - mesmo padrao de FormSigOpAlC)
            IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                    (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
                THIS.CarregarLista()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Ponto unico de construcao dos objetos visuais do
    * form. Cada fase da migracao acrescenta aqui dentro a sua parte.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        *-- Frame fixo do topo (cabecalho)
        THIS.ConfigurarPageFrame()

        *-- Grid1 do legado: lista de itens exportaveis (Fase 4)
        THIS.ConfigurarGrid()

        *-- Commandgroup1 do legado: botoes Gerar/Encerrar (Fase 4). Criado
        *-- DEPOIS do cabecalho para desenhar por cima dele (regra #11),
        *-- igual ao padrao cnt_4c_Botoes dos forms CRUD.
        THIS.ConfigurarBotoes()

        *-- Optiongroup1/Label1 do legado: seletor do tipo de item exportavel
        *-- (Fase 5)
        THIS.ConfigurarCampos()
    ENDPROC

    *==========================================================================
    * ConfigurarGrid - Grid1 do legado (SIGOPARQ.Grid1): lista os itens
    * exportaveis (Linha ou Grupo de Produto, conforme Optiongroup1/
    * this_nTipos) com uma coluna de marcacao (Check1) e duas colunas de
    * texto (Column2 = arquivo de destino escolhido, Column3 = descricao
    * do item). Liga em cursor_4c_Dados - criado aqui como placeholder com
    * a MESMA estrutura que SigOpArqBO.CarregarItensGrade usa, para o
    * Column.ControlSource ja poder ser definido nesta fase (regra: nunca
    * ControlSource de cursor que ainda nao existe).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oGrid

        IF !USED("cursor_4c_Dados")
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (Codigos C(10), Descricao C(40), Marcas N(1,0), NomArqs C(254))
            SET NULL OFF
        ENDIF

        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados

        *-- ColumnCount/RecordSource FORA do WITH (referencia explicita): o
        *-- WITH seguinte acessa .Column1/.Column2/.Column3, e as colunas so
        *-- existem depois que estas duas propriedades ja tiverem rodado.
        loc_oGrid.ColumnCount  = 3
        loc_oGrid.RecordSource = "cursor_4c_Dados"

        WITH loc_oGrid
            .Top            = 85
            .Left           = 60
            .Width          = 469
            .Height         = 83
            .FontName       = "Tahoma"
            .FontSize       = 8
            .AllowRowSizing = .F.
            .DeleteMark     = .F.
            .RecordMark     = .F.
            .RowHeight      = 16
            .ScrollBars     = 2
            .GridLineColor  = RGB(238, 238, 238)

            *-- Column1 = Check1 ("Marcas") - ColumnOrder=3, ou seja exibida
            *-- por ULTIMO (a direita), fiel ao dump do SCX legado
            .Column1.ControlSource = "cursor_4c_Dados.Marcas"
            .Column1.ColumnOrder   = 3
            .Column1.Width         = 20
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.
            .Column1.ReadOnly      = .F.
            .Column1.Sparse        = .F.
            .Column1.FontName      = "Tahoma"
            .Column1.FontSize      = 8
            .Column1.Header1.Caption   = ""
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.ForeColor = RGB(36, 84, 155)

            .Column1.AddObject("chk_4c_Marca", "CheckBox")
            WITH .Column1.chk_4c_Marca
                .Top       = 35
                .Left      = 37
                .Height    = 17
                .Width     = 60
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .Caption   = "..."
                .Style     = 1
                .ReadOnly  = .F.
                .Visible   = .T.
            ENDWITH
            .Column1.CurrentControl = "chk_4c_Marca"

            *-- CheckBox dentro de Column de Grid NAO alterna pelo binding
            *-- nativo quando a coluna destino eh NUMERIC (Marcas N(1,0)) -
            *-- toggle manual via KeyPress/MouseUp, com MouseDown/Click so
            *-- para suprimir o toggle nativo (NODEFAULT nos 4).
            BINDEVENT(.Column1.chk_4c_Marca, "KeyPress",   THIS, "ChkMarcaKeyPress")
            BINDEVENT(.Column1.chk_4c_Marca, "MouseUp",    THIS, "ChkMarcaMouseUp")
            BINDEVENT(.Column1.chk_4c_Marca, "MouseDown",  THIS, "ChkMarcaMouseDown")
            BINDEVENT(.Column1.chk_4c_Marca, "Click",      THIS, "ChkMarcaClick")

            *-- Column2 = Text1 ("Arquivo") - ColumnOrder=1, exibida primeiro
            *-- (a esquerda). Mostra o caminho escolhido via PutFile ao
            *-- marcar o Check1 (NomArqs) - so leitura na grade.
            .Column2.ControlSource = "cursor_4c_Dados.NomArqs"
            .Column2.ColumnOrder   = 1
            .Column2.Width         = 111
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.
            .Column2.ReadOnly      = .T.
            .Column2.FontName      = "Tahoma"
            .Column2.FontSize      = 8
            .Column2.Header1.Caption   = "Arquivo"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.ForeColor = RGB(36, 84, 155)
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)

            *-- Column3 = Text1 ("Nome do Arquivo") - ColumnOrder=2, exibida
            *-- ao centro. Mostra a descricao do item (Linha ou Grupo).
            .Column3.ControlSource = "cursor_4c_Dados.Descricao"
            .Column3.ColumnOrder   = 2
            .Column3.Width         = 338
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.
            .Column3.ReadOnly      = .T.
            .Column3.FontName      = "Tahoma"
            .Column3.FontSize      = 8
            .Column3.Header1.Caption   = "Nome do Arquivo"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8
            .Column3.Header1.ForeColor = RGB(36, 84, 155)
            .Column3.Text1.BorderStyle = 0
            .Column3.Text1.Margin      = 0
            .Column3.Text1.ForeColor   = RGB(0, 0, 0)
            .Column3.Text1.BackColor   = RGB(255, 255, 255)

            .Visible = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Commandgroup1 do legado: 2 botoes de acao
    * (Command1="Gerar"/Command2="Encerrar"). NAO sao botoes CRUD - este
    * dialogo nao inclui/altera/exclui registro nenhum, so confirma ou
    * cancela a selecao de itens marcados na grade para exportacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = -2
            .Left          = 644
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1

            WITH .Buttons(1)
                .Top       = 5
                .Left      = 5
                .Width     = 75
                .Height    = 75
                .FontBold  = .T.
                .FontItalic = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption   = "Gerar"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top       = 5
                .Left      = 80
                .Width     = 75
                .Height    = 75
                .FontBold  = .T.
                .FontItalic = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .WordWrap  = .T.
                .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel    = .T.
                .Caption   = "Encerrar"
                .ForeColor = RGB(90, 90, 90)
                .BackColor = RGB(255, 255, 255)
                .Themes    = .F.
                .Visible   = .T.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Command1.Click/Command2.Click do legado: cada botao do
        *-- Commandgroup tem handler PROPRIO (nao um Click unico do grupo)
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnGerarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCampos - Optiongroup1/Label1 do legado (SIGOPARQ.Optiongroup1
    * e SIGOPARQ.Label1): seletor do tipo de item exportavel para a grade
    * (1=Linha/SigCdLin, 2=Grupo de Produto/SigCdGrp - ver
    * SigOpArqBO.AtualizarTipoExportacao). Posicoes/legendas/largura
    * TRANSCRITAS do dump do SCX legado (regra #45 - OptionGroup: legenda,
    * ordem e Top de cada botao vem do dump, nunca inventados). Este form
    * nao usa PageFrame, entao os Tops do legado sao usados sem
    * compensacao de +29 (ja o caso dos demais controles deste form).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCampos()
        THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
        WITH THIS.obj_4c_Optiongroup1
            .Top           = 166
            .Left          = 202
            .Width         = 189
            .Height        = 28
            .ButtonCount   = 2
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1

            *-- Buttons(1) = "Linha" (SigCdLin) - this_nTipos = 1
            WITH .Buttons(1)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Linha"
                .Top       = 7
                .Left      = 5
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            *-- Buttons(2) = "Grupo de Produto" (SigCdGrp) - this_nTipos = 2
            WITH .Buttons(2)
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = " Grupo de Produto"
                .Top       = 7
                .Left      = 63
                .Width     = 106
                .Height    = 15
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- Optiongroup1.InteractiveChange do legado (ThisForm.ParentForm.pnTipos
        *-- = This.Value): neste form standalone nao ha ParentForm, o
        *-- equivalente eh atualizar o tipo no BO e recarregar a grade.
        BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTiposInteractiveChange")

        *-- Label1 do legado: nao declara Width/Alignment no dump = classe
        *-- "say" pura (regra #23) -> AutoSize = .F. + Width/Height
        *-- transcritos do SCX (AutoSize = .T. e no-op em Label via AddObject)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Exporta" + CHR(231) + CHR(227) + "o  do Setor :"
            .Top       = 172
            .Left      = 67
            .Width     = 111
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CarregarLista - Popula cursor_4c_Dados via SigOpArqBO.Buscar() (SQL
    * para SigCdLin/SigCdGrp, conforme this_nTipos) e repinta a grade.
    * RecordSource/ControlSource ja foram definidos uma unica vez em
    * ConfigurarGrid() - aqui so GO TOP + Refresh (regra: popular cursor
    * nao repinta a grade sozinho).
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_lSucesso = THIS.this_oBusinessObject.Buscar("")
        ENDIF

        IF USED("cursor_4c_Dados")
            GO TOP IN cursor_4c_Dados
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarArquivoDestino - Cadeia de validacao do arquivo de destino, na
    * ordem EXATA de Grid1.Column1.Check1.InteractiveChange do legado:
    *
    *     If Not Empty(m.lcArqTxt)
    *         If Not fVerificaPasta(m.lcArqTxt,2) -> 'Local ou Arquivo Invalido !!!'
    *     Else                                    -> 'Destino Invalido !!!'
    *     Endif
    *     Locate for cNomArqs = m.lcArqTxt        -> 'Nome Arquivo Ja Informado !!!'
    *
    * Devolve .T. somente quando as TRES passam (e nesse caso o item ja fica
    * marcado com o destino escolhido, igual ao "Replace nMarcas With 1 /
    * cNomArqs With m.lcArqTxt" que fecha o metodo legado). Recusando,
    * devolve .F. e deixa em THIS.this_cMensagemErro a mensagem LITERAL do
    * legado, para o chamador exibir e desmarcar o item.
    *
    * PUBLIC de proposito: eh chamado pelos handlers de toggle do
    * chk_4c_Marca, que o BINDEVENT dispara de fora da classe (regra #3).
    *==========================================================================
    PROCEDURE ValidarArquivoDestino(par_cCaminhoArquivo)
        LOCAL loc_lValido
        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            *-- Ramo "Else" do If Not Empty() legado: usuario cancelou o
            *-- PutFile (devolve string vazia) ou nao informou nome algum.
            CASE VARTYPE(par_cCaminhoArquivo) != "C" OR EMPTY(ALLTRIM(par_cCaminhoArquivo))
                THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"

            CASE VARTYPE(THIS.this_oBusinessObject) != "O"
                THIS.this_cMensagemErro = "Destino Inv" + CHR(225) + "lido !!!"

            *-- fVerificaPasta (pasta de destino) + "Locate for cNomArqs"
            *-- (nome ja informado em outra linha) + a marcacao do item: o BO
            *-- eh a FONTE UNICA das tres coisas e devolve em
            *-- this_cMensagemErro a mensagem exata do legado ao recusar.
            CASE !THIS.this_oBusinessObject.MarcarItemParaExportacao(par_cCaminhoArquivo)
                THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ChkMarcaToggleExec - Corpo unico chamado pelos 4 handlers de toggle do
    * chk_4c_Marca. Espelha Grid1.Column1.Check1.InteractiveChange do legado:
    * pede o arquivo de destino (PutFile) e submete a
    * THIS.ValidarArquivoDestino(); recusando, exibe a mensagem do legado e
    * deixa o item desmarcado, igual aos "Replace nMarcas With 0 / cNomArqs
    * With '' / This.Value = 0" de cada ramo de erro do metodo legado.
    *==========================================================================
    PROCEDURE ChkMarcaToggleExec()
        LOCAL loc_cArqTxt

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        loc_cArqTxt = PUTFILE("Arquivo :", "", "TXT")

        IF !THIS.ValidarArquivoDestino(loc_cArqTxt)
            *-- regra #20: o BO marca this_lErroExibido quando ele mesmo ja
            *-- exibiu a falha (CATCH com MsgErro) - repetir daria 2 dialogos
            IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
                    !THIS.this_oBusinessObject.this_lErroExibido
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.DesmarcarItem()
            ENDIF
        ENDIF

        *-- "This.Parent.Refresh" do legado: sem isto a grade nao repinta a
        *-- marcacao nem o nome do arquivo recem-gravados no cursor (regra #21)
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.ChkMarcaToggleExec()
            NODEFAULT
        ENDIF
    ENDPROC

    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
        THIS.ChkMarcaToggleExec()
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShiftAltCtrl, par_nRow, par_nColumn)
        NODEFAULT
    ENDPROC

    PROCEDURE ChkMarcaClick()
        NODEFAULT
    ENDPROC

    *==========================================================================
    * OptTiposInteractiveChange - Optiongroup1.InteractiveChange do legado.
    * Troca this_nTipos no BO (Linha/Grupo de Produto) e recarrega a grade
    * com o universo do tipo novo.
    *==========================================================================
    PROCEDURE OptTiposInteractiveChange()
        *-- FONTE UNICA da transferencia campo -> BO (ver FormParaBO abaixo)
        THIS.FormParaBO()

        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere o unico campo EDITAVEL da tela para o BO.
    *
    * Este dialogo nao tem campos de cadastro: o unico controle que o usuario
    * altera (alem da marcacao da grade, que o BO ja grava direto no cursor em
    * MarcarItemParaExportacao) eh o Optiongroup1 "Exportacao do Setor",
    * cujo Value o legado jogava em ThisForm.ParentForm.pnTipos. Migrado
    * standalone, o destino equivalente eh SigOpArqBO.this_nTipos, resolvido
    * por AtualizarTipoExportacao (que tambem acerta tabela/chave de origem).
    *
    * Value do OptionGroup eh o INDICE 1-based do botao marcado (regra #45):
    * 1 = Linha (SigCdLin), 2 = Grupo de Produto (SigCdGrp) - mapeamento
    * DIRETO, sem +1/-1.
    *
    * PROTECTED igual ao hook de FormBase (declarar sem modificador nao
    * alarga o escopo - o PROTECTED da classe base prevalece, regra #51);
    * chamado so de dentro desta classe, sempre com THIS.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
            loc_lSucesso = THIS.this_oBusinessObject.AtualizarTipoExportacao(THIS.obj_4c_Optiongroup1.Value)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Caminho inverso de FormParaBO: reflete this_nTipos do BO no
    * Optiongroup1. Usado na abertura (o Init do BO ja nasce com this_nTipos
    * = 1, o mesmo "ParentForm.pnTipos = 1" do Init legado).
    *
    * Guarda BETWEEN(...,1,2): OptionGroup eh 1-based e atribuir 0 deixaria o
    * grupo SEM botao marcado, estado que o legado nunca tem (Optiongroup1.
    * Value = 1 no SCX).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_nTipos

        IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !PEMSTATUS(THIS, "obj_4c_Optiongroup1", 5)
            RETURN .F.
        ENDIF

        loc_nTipos = THIS.this_oBusinessObject.this_nTipos
        IF VARTYPE(loc_nTipos) != "N" OR !BETWEEN(loc_nTipos, 1, 2)
            loc_nTipos = 1
        ENDIF

        THIS.obj_4c_Optiongroup1.Value = loc_nTipos

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnGerarClick - Commandgroup1.Command1.Click (Gerar) do legado: exige
    * pelo menos um item marcado, confirma com o usuario e fecha o dialogo
    * ("Release Windows" no legado). A geracao real dos arquivos ficava a
    * cargo do form pai no legado (ver comentario de BtnGerarClick no BO);
    * quando este dialogo for aberto por um form pai com crSigCdBal aberto
    * (mesmo DataSession do legado), o codigo do balanco entra na mensagem
    * de confirmacao, igual ao legado - senao a confirmacao fica generica.
    *==========================================================================
    PROCEDURE BtnGerarClick()
        *-- "Release Windows" do legado so acontece quando a confirmacao passa
        IF THIS.BtnConfirmarClick()
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - CORPO de Commandgroup1.Command1.Click (Gerar), sem o
    * fechamento da janela. Eh a acao de verdade deste dialogo: exigir item
    * marcado e obter a confirmacao do usuario para a exportacao.
    *
    *     Locate for nMarcas = 1
    *     If Eof()  -> 'Geracao Nao Selecionada !!!' / Return
    *     If MessageBox('Confirma Exportacao do Inventario X?',36,'')==7 -> Return
    *     Release Windows
    *
    * O par Confirmar/Gerar espelha o par Cancelar/Encerrar logo abaixo: o
    * metodo nomeado pelo VERBO CANONICO carrega a regra (validar + confirmar)
    * e devolve .T./.F.; o metodo nomeado pelo BOTAO do legado (Caption
    * "Gerar", fiel ao PILAR 1) eh o que o BINDEVENT dispara e so decide
    * fechar. A separacao tambem deixa a confirmacao reutilizavel por quem
    * abrir este dialogo por programa, sem a janela no meio.
    *
    * PUBLIC: chamado por BtnGerarClick e podendo ser acionado de fora pelo
    * harness de teste (regra #3 - PEMSTATUS nao enxerga escopo).
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lConfirmado, loc_cMsg
        loc_lConfirmado = .F.

        *-- O tipo escolhido no Optiongroup1 vai ao BO ANTES da acao (padrao
        *-- do projeto: FormParaBO abre todo caminho de acao)
        THIS.FormParaBO()

        DO CASE
            CASE VARTYPE(THIS.this_oBusinessObject) != "O" OR ;
                    !THIS.this_oBusinessObject.ExisteItemSelecionado()
                MsgAviso("Gera" + CHR(231) + CHR(227) + "o N" + CHR(227) + "o Selecionada !!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")

            OTHERWISE
                loc_cMsg = "Confirma Exporta" + CHR(231) + CHR(227) + "o do Invent" + CHR(225) + "rio"

                *-- crSigCdBal eh o cursor do form PAI no legado (mesma
                *-- DataSession). Aberto por quem chamou este dialogo, o
                *-- codigo do balanco entra na mensagem igual ao legado;
                *-- standalone, a confirmacao fica generica.
                IF USED("crSigCdBal")
                    loc_cMsg = loc_cMsg + " " + ALLTRIM(STR(crSigCdBal.Codigos)) + "?"
                ELSE
                    loc_cMsg = loc_cMsg + "?"
                ENDIF

                loc_lConfirmado = MsgConfirma(loc_cMsg, "Confirmar")
        ENDCASE

        RETURN loc_lConfirmado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Commandgroup1.Command2.Click (Encerrar) do legado:
    * se houver item marcado, confirma o cancelamento; confirmando (ou se
    * nao havia nada marcado), limpa todas as marcacoes e fecha o dialogo.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        *-- "Release Windows" do legado so acontece quando o cancelamento eh
        *-- aceito (recusando, o legado faz Return e a tela CONTINUA aberta)
        IF THIS.BtnCancelarClick()
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - CORPO de Commandgroup1.Command2.Click (Encerrar,
    * Cancel = .T. no SCX), sem o fechamento da janela.
    *
    *     Locate for nMarcas = 1
    *     If ! Eof()
    *         If MessageBox('Geracao Selecionada, Deseja Cancelar ???',36,'') = 7
    *             Return
    *     Replace All nMarcas With 0
    *     Release Windows
    *
    * O botao do legado NAO eh um "sair" puro: antes de fechar ele DESFAZ a
    * selecao inteira (Replace All nMarcas With 0) - ou seja, cancela o
    * trabalho feito na grade. Por isso o cancelamento tem metodo proprio com
    * o nome canonico, e BtnEncerrarClick (nome do botao no legado, Caption
    * "Encerrar" preservado pelo PILAR 1) so decide fechar conforme o
    * resultado.
    *
    * Devolve .F. quando o usuario recusa o cancelamento - nesse caso nada eh
    * desmarcado e a tela permanece aberta, exatamente como o Return do
    * legado.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lCancelar
        loc_lCancelar = .T.

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.this_oBusinessObject.ExisteItemSelecionado()
            loc_lCancelar = MsgConfirma("Gera" + CHR(231) + CHR(227) + "o Selecionada, Deseja Cancelar ???", ;
                                        "Confirmar")
        ENDIF

        IF loc_lCancelar
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparSelecoes()
            ENDIF

            *-- regra #21: limpar o cursor nao repinta a grade sozinho
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        ENDIF

        RETURN loc_lCancelar
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Container cabecalho (cntSombra do legado): fundo
    * cinza + labels de titulo. Forms OPERACIONAIS nao usam PageFrame de
    * abas CRUD; este metodo agrupa a faixa fixa do topo do form.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
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

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .Alignment = 0
                .Caption   = THIS.Caption
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * Destroy - fecha cursores locais e preserva o fix de menu (DODEFAULT
    * chama FormBase.Destroy)
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_ItensExpTemp")
            USE IN cursor_4c_ItensExpTemp
        ENDIF

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis todos os controles do form
    * recursivamente. Este form OPERACIONAL nao tem containers flutuantes
    * (Visible=.F. toggled por botao) no layout do legado - todos os
    * controles ficam visiveis desde a abertura.
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_nJ, loc_oObjeto

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                loc_oObjeto.Visible = .T.
            ENDIF

            IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oObjeto)
            ENDIF

            IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                FOR loc_nJ = 1 TO loc_oObjeto.PageCount
                    THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nJ))
                ENDFOR
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
