*==============================================================================
* FORMBUSCAAUXILIAR.PRG
* Classe para busca em tabelas auxiliares/relacionadas
*
* Replica funcionalidade do fwbuscaext do framework antigo
* Aparencia visual identica ao legado
*
* REGRAS APLICADAS:
* - Nomenclatura: loc_ para locais, par_ para parametros, this_ para classe
* - Controles: tipo_4c_Nome (grd_4c_, cmd_4c_)
* - Init() SEMPRE retorna .T. para garantir criacao do objeto
* - Usa Hide() em vez de Release() para permitir leitura de propriedades
* - Caller deve chamar Release() apos ler valores
*==============================================================================

DEFINE CLASS FormBuscaAuxiliar AS FormBase

    *-- Propriedades do form (baseado no fwbuscaext do framework legado)
    Height = 375
    Width = 374
    Caption = "Procura"
    AutoCenter = .T.
    BorderStyle = 2
    MaxButton = .F.
    MinButton = .F.
    WindowType = 1      && Modal
    ShowWindow = 1      && In Top-Level Form (compativel com modal)
    ControlBox = .F.    && Sem menu de controle (legado)
    TitleBar = 0        && Sem barra de titulo (legado)
    Themes = .F.        && Sem temas do Windows (legado)
    FontName = "Verdana"
    FontSize = 8

    *-- Propriedades de controle (nomenclatura: this_ + tipo)
    this_cTabela = ""
    this_cCursorDestino = ""
    this_cCampoBusca = ""
    this_cValorBusca = ""
    this_cTitulo = "Procura"

    *-- Propriedades de status
    this_lAchouRegistro = .F.
    this_lSelecionou = .F.

    *-- API DefinirCursor/Mostrar: campos de codigo e descricao + resultado
    this_cCampoCodigo     = ""
    this_cCampoDescricao  = ""
    cCodigoSelecionado    = ""
    cDescricaoSelecionada = ""

    *-- Array de colunas [nome, mascara, titulo]
    DIMENSION this_aColunas[1, 3]
    this_nColunas = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * REGRA: SEMPRE retorna .T. para garantir criacao do objeto
    * Use propriedades this_lAchouRegistro e this_lSelecionou para verificar status
    *
    * Parametros:
    *   par_nConn - Handle da conexao SQL
    *   par_cTabela - Nome da tabela
    *   par_cCursor - Nome do cursor de destino
    *   par_cCampo - Campo de busca
    *   par_cValor - Valor a buscar
    *   par_cTitulo - Titulo da janela
    *   par_lBuscaExata - Se .T., busca apenas exata (opcional, default .F.)
    *   par_lMostraGrid - Se .T., mostra grid imediatamente (opcional, default .F.)
    *   par_cFiltro - Filtro WHERE adicional (opcional, ex: "campo = 'X'")
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nConn, par_cTabela, par_cCursor, par_cCampo, par_cValor, par_cTitulo, par_lBuscaExata, par_lMostraGrid, par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_cIconPath, loc_cFiltro, loc_lBuscaExata

        loc_cIconPath = gc_4c_CaminhoIcones

        * Trata parametros opcionais com valores padrao
        loc_lBuscaExata = IIF(VARTYPE(par_lBuscaExata) = "L", par_lBuscaExata, .F.)
        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro), par_cFiltro, "")

        * Configura aparencia visual (legado)
        THIS.Picture = loc_cIconPath + "fundo_cadastro.jpg"

        * Cria controles dinamicamente
        THIS.CriarControles()

        *-- Se chamado sem parametros (modo setar propriedades manualmente), retornar
        IF VARTYPE(par_cTabela) != "C"
            RETURN .T.
        ENDIF

        * Guarda parametros
        THIS.this_cTabela = par_cTabela
        THIS.this_cCursorDestino = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "cursor_4c_Busca")
        THIS.this_cCampoBusca = IIF(VARTYPE(par_cCampo) = "C", par_cCampo, "")
        THIS.this_cValorBusca = IIF(VARTYPE(par_cValor) = "C", UPPER(ALLTRIM(par_cValor)), "")

        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            THIS.this_cTitulo = par_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo
        ENDIF

        * Monta clausula WHERE com filtro adicional
        LOCAL loc_cWhere
        loc_cWhere = ""
        IF !EMPTY(loc_cFiltro)
            loc_cWhere = " AND (" + loc_cFiltro + ")"
        ENDIF

        * Primeiro tenta busca exata - usa CAST para evitar erro de conversao
        loc_cSQL = "SELECT * FROM " + par_cTabela + " " + ;
                "WHERE CAST(" + par_cCampo + " AS VARCHAR(50)) = " + EscaparSQL(THIS.this_cValorBusca) + ;
                loc_cWhere

        loc_nResultado = SQLEXEC(par_nConn, loc_cSQL, par_cCursor)

        IF loc_nResultado > 0 AND RECCOUNT(par_cCursor) = 1
            * Encontrou registro exato
            THIS.this_lAchouRegistro = .T.
            THIS.this_lSelecionou = .T.
            RETURN .T.  && REGRA: Sempre .T. para criar objeto
        ENDIF

        * Nao encontrou exato, busca parcial
        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_cSQL = "SELECT * FROM " + par_cTabela + " " + ;
                "WHERE CAST(" + par_cCampo + " AS VARCHAR(50)) LIKE " + EscaparSQL(THIS.this_cValorBusca + "%") + ;
                loc_cWhere + " " + ;
                "ORDER BY " + par_cCampo

        loc_nResultado = SQLEXEC(par_nConn, loc_cSQL, par_cCursor)

        IF loc_nResultado < 0 OR RECCOUNT(par_cCursor) = 0
            THIS.this_lAchouRegistro = .F.
            THIS.this_lSelecionou = .F.
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            RETURN .T.  && REGRA: Sempre .T. para criar objeto
        ENDIF

        THIS.this_lAchouRegistro = .F.
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarControles - Cria controles com aparencia do fwbuscaext
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarControles()
        LOCAL loc_cIconPath
        loc_cIconPath = gc_4c_CaminhoIcones

        *-- Container do cabecalho (cntSombra do legado)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top = 0
            .Left = 0
            .Width = THIS.Width
            .Height = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra do titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption = THIS.this_cTitulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Left = 10
            .Top = 18
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Visible = .T.
        ENDWITH

        *-- Label titulo
        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption = THIS.this_cTitulo
            .FontName = "Tahoma"
            .FontSize = 18
            .FontBold = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Left = 10
            .Top = 17
            .AutoSize  = .F.
            .Width     = THIS.Width
            .Height    = 30
            .Visible = .T.
        ENDWITH

        *-- Grid de busca (GridProc do legado)
        THIS.AddObject("grd_4c_Lista", "Grid")
        WITH THIS.grd_4c_Lista
            .Left = 3
            .Top = 82
            .Width = THIS.Width - 6
            .Height = 224
            .FontName = "Tahoma"
            .FontSize = 8
            .RecordSourceType = 1
            .ReadOnly = .T.
            .DeleteMark = .F.
            .RecordMark = .F.
            .AllowHeaderSizing = .F.
            .AllowRowSizing = .F.
            .RowHeight = 16
            .ScrollBars = 2         && Somente vertical (legado)
            .GridLineColor = RGB(238, 238, 238)
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .HighlightStyle = 2
            .Visible = .T.
        ENDWITH

        *-- Container dos botoes (cmdGprocessa do legado)
        *-- Top=310 posiciona ABAIXO do grid (grid bottom = 82+224 = 306) evitando
        *-- sobreposicao. BackStyle=1 opaco previne ghost trails ao scrollar grid.
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top = 310
            .Left = 232
            .Width = 138
            .Height = 56
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Selecionar (cmdZoom do legado)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Selecionar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Selecionar
            .Caption = "Selecionar"
            .Left = 5
            .Top = 5
            .Width = 64
            .Height = 46
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Default = .T.
            .Visible = .T.
        ENDWITH

        *-- Botao Cancelar (cmdOk do legado - usado como cancelar)
        THIS.cnt_4c_Botoes.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH THIS.cnt_4c_Botoes.cmd_4c_Cancelar
            .Caption = "Cancelar"
            .Left = 69
            .Top = 5
            .Width = 64
            .Height = 46
            .FontName = "Tahoma"
            .FontSize = 8
            .FontBold = .T.
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Cancel = .T.
            .Visible = .T.
        ENDWITH

        *-- Bind events
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Selecionar, "Click", THIS, "BtnSelecionarClick")
        BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
        BINDEVENT(THIS.grd_4c_Lista, "DblClick", THIS, "GridDblClick")

        *-- Torna controles visiveis
        THIS.cnt_4c_Cabecalho.Visible = .T.
        THIS.cnt_4c_Botoes.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * mAddColuna - Adiciona coluna ao grid
    *--------------------------------------------------------------------------
    PROCEDURE mAddColuna(par_cCampo, par_cMascara, par_cTitulo)
        THIS.this_nColunas = THIS.this_nColunas + 1

        DIMENSION THIS.this_aColunas[THIS.this_nColunas, 3]
        THIS.this_aColunas[THIS.this_nColunas, 1] = par_cCampo
        THIS.this_aColunas[THIS.this_nColunas, 2] = par_cMascara
        THIS.this_aColunas[THIS.this_nColunas, 3] = par_cTitulo
    ENDPROC

    *--------------------------------------------------------------------------
    * Show - Exibe o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Show(par_nStyle)
        THIS.ConfigurarGrid()
        DODEFAULT(par_nStyle)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Configura colunas do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_nI, loc_cCampo, loc_cTitulo, loc_nLarguraTotal, loc_nLargura

        IF !USED(THIS.this_cCursorDestino)
            RETURN
        ENDIF

        WITH THIS.grd_4c_Lista
            .RecordSource = THIS.this_cCursorDestino
            .ColumnCount = THIS.this_nColunas

            * Calcula largura proporcional
            loc_nLarguraTotal = .Width - 20

            FOR loc_nI = 1 TO THIS.this_nColunas
                loc_cCampo = THIS.this_aColunas[loc_nI, 1]
                loc_cTitulo = THIS.this_aColunas[loc_nI, 3]

                * Primeira coluna menor, demais dividem o restante
                IF loc_nI = 1
                    loc_nLargura = 80
                ELSE
                    loc_nLargura = (loc_nLarguraTotal - 80) / (THIS.this_nColunas - 1)
                ENDIF

                .Columns(loc_nI).ControlSource = THIS.this_cCursorDestino + "." + loc_cCampo
                .Columns(loc_nI).Header1.Caption = loc_cTitulo
                .Columns(loc_nI).Width = loc_nLargura
            ENDFOR

            .Refresh()
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSelecionarClick - Usuario selecionou registro
    * REGRA: Usa Hide() para manter objeto acessivel para leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnSelecionarClick()
        THIS.this_lSelecionou = .T.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Usuario cancelou
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lSelecionou = .F.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * GridDblClick - Duplo clique seleciona
    *--------------------------------------------------------------------------
    PROCEDURE GridDblClick()
        THIS.this_lSelecionou = .T.
        THIS.Hide()
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Trata ESC
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 27
            THIS.this_lSelecionou = .F.
            THIS.Hide()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * QueryUnload - Trata fechamento pelo X
    *--------------------------------------------------------------------------
    PROCEDURE QueryUnload()
        THIS.this_lSelecionou = .F.
        THIS.Hide()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirCursor - Configura cursor pre-populado para exibicao na grid
    *   API alternativa ao Init: popula cursor via SQLEXEC antes, depois
    *   chama DefinirCursor(cursor, campoCod, campoDesc, titulo) + Mostrar()
    *--------------------------------------------------------------------------
    PROCEDURE DefinirCursor(par_cCursor, par_cCampoCod, par_cCampoDesc, par_cTitulo)
        THIS.this_cCursorDestino  = par_cCursor
        THIS.this_cCampoCodigo    = par_cCampoCod
        THIS.this_cCampoDescricao = par_cCampoDesc
        THIS.this_nColunas        = 0
        DIMENSION THIS.this_aColunas[1, 3]
        THIS.mAddColuna(par_cCampoCod,  "", par_cCampoCod)
        THIS.mAddColuna(par_cCampoDesc, "", par_cCampoDesc)
        IF VARTYPE(par_cTitulo) = "C" AND !EMPTY(par_cTitulo)
            THIS.this_cTitulo = par_cTitulo
            IF VARTYPE(THIS.cnt_4c_Cabecalho) = "O"
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = par_cTitulo
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Mostrar - Exibe form modal e retorna .T. se usuario selecionou
    *   Popula cCodigoSelecionado e cDescricaoSelecionada apos selecao.
    *--------------------------------------------------------------------------
    FUNCTION Mostrar()
        THIS.Show()
        IF THIS.this_lSelecionou AND USED(THIS.this_cCursorDestino)
            SELECT (THIS.this_cCursorDestino)
            THIS.cCodigoSelecionado    = ALLTRIM(EVALUATE(THIS.this_cCampoCodigo))
            THIS.cDescricaoSelecionada = ALLTRIM(EVALUATE(THIS.this_cCampoDescricao))
        ENDIF
        RETURN THIS.this_lSelecionou
    ENDFUNC

ENDDEFINE
