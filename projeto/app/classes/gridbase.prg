*==============================================================================
* GRIDBASE.PRG
* Classe base para grids da aplicação
* Responsabilidade: configuração e comportamentos padrão de grids
*==============================================================================

DEFINE CLASS GridBase AS Grid

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_cCursorOrigem = ""         && Nome do cursor que alimenta o grid
    this_lPermiteSelecao = .T.      && Permite seleção de linha
    this_lPermiteOrdenacao = .T.    && Permite ordenação por clique no header

    *-- Configurações visuais padrão (baseado no frmcadastro do framework legado)
    AllowHeaderSizing = .T.
    AllowRowSizing = .F.
    DeleteMark = .F.
    GridLines = 3              && Horizontal e Vertical
    HeaderHeight = 20          && Altura do cabecalho (legado = 20)
    HighLight = .T.
    RecordMark = .F.
    RecordSourceType = 1       && Alias
    RowHeight = 16             && Altura da linha (legado = 16)
    ScrollBars = 2             && SOMENTE VERTICAL (legado = 2, NAO 3)
    SplitBar = .F.

    *-- Cores do grid (baseado no frmcadastro do framework legado)
    GridLineColor = RGB(238, 238, 238)   && Cinza claro para linhas
    ForeColor = RGB(90, 90, 90)          && Texto cinza escuro
    BackColor = RGB(255, 255, 255)       && Fundo branco
    HighlightBackColor = RGB(255, 255, 255)
    HighlightForeColor = RGB(15, 41, 104) && Azul escuro
    HighlightStyle = 2

    *--------------------------------------------------------------------------
    * INIT - Inicialização do grid
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        * Configura fonte padrão (baseado no frmcadastro do framework legado)
        THIS.FontName = "Verdana"
        THIS.FontSize = 8

        * Chama inicialização específica
        THIS.InicializarGrid()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarGrid - Hook para inicialização específica
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarGrid()
        * Subclasses podem implementar inicializações específicas
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarColunas - Configura colunas do grid
    * Parâmetros:
    *   paConfig: array com configurações das colunas
    *   Estrutura: [n, 1] = Nome do campo
    *              [n, 2] = Caption (título)
    *              [n, 3] = Largura
    *              [n, 4] = Alinhamento (opcional: 0=Esq, 1=Dir, 2=Centro)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarColunas(paConfig)
        LOCAL lnI, lnColunas, loColuna, loHeader, lcCampo, lcCaption, lnLargura, lnAlign

        IF VARTYPE(paConfig) != "A"
            RETURN .F.
        ENDIF

        lnColunas = ALEN(paConfig, 1)

        * Remove todas as colunas existentes
        THIS.ColumnCount = -1

        * Define número de colunas do grid
        THIS.ColumnCount = lnColunas

        * Configura cada coluna
        FOR lnI = 1 TO lnColunas
            loColuna = THIS.Columns(lnI)

            * Obtém configurações
            lcCampo = paConfig[lnI, 1]
            lcCaption = IIF(ALEN(paConfig, 2) >= 2, paConfig[lnI, 2], lcCampo)
            lnLargura = IIF(ALEN(paConfig, 2) >= 3, paConfig[lnI, 3], 100)
            lnAlign = IIF(ALEN(paConfig, 2) >= 4, paConfig[lnI, 4], 0)

            * Configura source da coluna (sem alias se não há cursor ainda)
            IF !EMPTY(THIS.this_cCursorOrigem)
                loColuna.ControlSource = THIS.this_cCursorOrigem + "." + lcCampo
            ELSE
                loColuna.ControlSource = lcCampo
            ENDIF

            * Configura header (verifica se existe)
            IF PEMSTATUS(loColuna, "Header1", 5)
                loHeader = loColuna.Header1
                loHeader.Caption = lcCaption
                loHeader.FontBold = .T.
            ENDIF

            * Configura largura
            loColuna.Width = lnLargura

            * Configura alinhamento (verifica se Text1 existe)
            IF PEMSTATUS(loColuna, "Text1", 5)
                loColuna.CurrentControl = "Text1"
                loColuna.Text1.Alignment = lnAlign
            ENDIF
        ENDFOR

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularCursor - Vincula grid a um cursor
    *--------------------------------------------------------------------------
    PROCEDURE VincularCursor(pcCursor)
        IF VARTYPE(pcCursor) != "C" OR EMPTY(pcCursor)
            RETURN .F.
        ENDIF

        IF !USED(pcCursor)
            RETURN .F.
        ENDIF

        THIS.this_cCursorOrigem = ALLTRIM(pcCursor)
        THIS.RecordSource = THIS.this_cCursorOrigem
        THIS.Refresh()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterValorColunaAtual - Retorna valor da coluna da linha atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterValorColunaAtual(pcColuna)
        LOCAL lcCursor, lcCampo

        IF EMPTY(THIS.this_cCursorOrigem) OR !USED(THIS.this_cCursorOrigem)
            RETURN .NULL.
        ENDIF

        IF RECCOUNT(THIS.this_cCursorOrigem) = 0
            RETURN .NULL.
        ENDIF

        lcCursor = THIS.this_cCursorOrigem
        lcCampo = ALLTRIM(pcColuna)

        * Seleciona o cursor e retorna o valor
        SELECT (lcCursor)
        RETURN EVALUATE(lcCursor + "." + lcCampo)
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarNoRegistro - Posiciona grid em um registro específico
    *--------------------------------------------------------------------------
    PROCEDURE PosicionarNoRegistro(pnRecno)
        LOCAL lcCursor

        IF EMPTY(THIS.this_cCursorOrigem) OR !USED(THIS.this_cCursorOrigem)
            RETURN .F.
        ENDIF

        lcCursor = THIS.this_cCursorOrigem
        SELECT (lcCursor)

        IF BETWEEN(pnRecno, 1, RECCOUNT())
            GO pnRecno IN (lcCursor)
            THIS.Refresh()
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarDados - Atualiza dados do grid
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarDados()
        IF !EMPTY(THIS.this_cCursorOrigem) AND USED(THIS.this_cCursorOrigem)
            THIS.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTotalRegistros - Retorna total de registros no cursor
    *--------------------------------------------------------------------------
    PROCEDURE ObterTotalRegistros()
        IF EMPTY(THIS.this_cCursorOrigem) OR !USED(THIS.this_cCursorOrigem)
            RETURN 0
        ENDIF

        RETURN RECCOUNT(THIS.this_cCursorOrigem)
    ENDPROC

    *--------------------------------------------------------------------------
    * TemRegistros - Verifica se há registros no cursor
    *--------------------------------------------------------------------------
    PROCEDURE TemRegistros()
        RETURN THIS.ObterTotalRegistros() > 0
    ENDPROC

    *--------------------------------------------------------------------------
    * AfterRowColChange - Evento após mudança de linha/coluna
    *--------------------------------------------------------------------------
    PROCEDURE AfterRowColChange()
        LPARAMETERS nColIndex

        * Hook para processamento nas subclasses
        THIS.AoMudarSelecao()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoMudarSelecao - Hook para quando a seleção muda
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AoMudarSelecao()
        * Subclasses podem implementar ações ao mudar seleção
    ENDPROC

    *--------------------------------------------------------------------------
    * DblClick - Evento de duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE DblClick()
        * Hook para processamento nas subclasses
        THIS.AoDuploClique()
    ENDPROC

    *--------------------------------------------------------------------------
    * AoDuploClique - Hook para duplo clique
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AoDuploClique()
        * Subclasses podem implementar ações ao dar duplo clique
        * Ex: abrir tela de detalhes, editar registro, etc.
    ENDPROC

    *--------------------------------------------------------------------------
    * NOTA: Ordenação por clique no header foi removida
    * Para implementar ordenação, use BINDEVENT nos headers após criar as colunas
    * Exemplo no ConfigurarColunas:
    *   FOR lnI = 1 TO lnColunas
    *       BINDEVENT(THIS.Columns(lnI).Header1, "Click", THIS, "OrdenarPorColuna")
    *   ENDFOR
    *--------------------------------------------------------------------------

ENDDEFINE
