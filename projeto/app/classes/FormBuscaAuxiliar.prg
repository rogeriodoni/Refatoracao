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
    *-- fwbuscaext do legado: 374 x 319. O migrado estava com 375 de altura,
    *-- 56 a mais, o que deixava uma faixa morta embaixo da grade.
    Height = 319
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

    *-- Array de colunas [nome, mascara, titulo, largura]
    DIMENSION this_aColunas[1, 4]
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

        *-- par_cCampo tem de ser CARACTER: ele entra CRU na concatenacao do SELECT
        *-- logo abaixo. Chamada com argumentos deslocados (regra #36) deixava-o
        *-- em .F. e o "+" estourava Operator/operand type mismatch (erro391).
        IF VARTYPE(par_cCampo) != "C" OR EMPTY(par_cCampo)
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
            *-- a sombra tem de acompanhar o titulo: sem isto ficava "Procura" por
            *-- tras e o cabecalho mostrava texto sobreposto ("Seriesra", erro382)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = par_cTitulo
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
            *-- Fallback SHOW-ALL (Erro114 2026-08-13): busca parcial retornou 0
            *   rows (ou erro). Antes o cursor era FECHADO e o picker abria vazio.
            *   Agora: re-consulta SEM filtro do campo para exibir todos os
            *   registros disponiveis (respeitando par_cFiltro adicional).
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            LOCAL loc_cWhereAll
            loc_cWhereAll = ""
            IF !EMPTY(loc_cFiltro)
                loc_cWhereAll = " WHERE (" + loc_cFiltro + ")"
            ENDIF
            loc_cSQL = "SELECT * FROM " + par_cTabela + " " + loc_cWhereAll + ;
                       " ORDER BY " + par_cCampo
            loc_nResultado = SQLEXEC(par_nConn, loc_cSQL, par_cCursor)
            THIS.this_lAchouRegistro = .F.
            THIS.this_lSelecionou = .F.
            IF loc_nResultado < 0 OR !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
                *-- Tabela realmente vazia (ou erro): fecha cursor
                IF USED(par_cCursor)
                    USE IN (par_cCursor)
                ENDIF
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
            *-- 82 + 168 = 250; botoes em 254..310; form 319 (legado)
            .Height = 168
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
        *-- Fica ABAIXO da grade (bottom = 82+168 = 250), sem sobrepor.
        *-- BackStyle=1 opaco previne ghost trails ao scrollar a grade.
        *-- Largura 149 (nao os 138 do legado): la o 1o botao era "Zoom", aqui eh
        *-- "Selecionar", que mede 59px em Tahoma 8 bold e nao cabia em 64.
        THIS.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.cnt_4c_Botoes
            .Top = 254
            .Left = THIS.Width - 153
            .Width = 149
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
            .Width = 75
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
            .Left = 80
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
    * par_nLargura eh OPCIONAL: o legado declara a largura de cada coluna no
    * mAddColuna dele (ex.: Dopes 150, Cemps 31, Razas 290). Sem ela, a largura
    * continua sendo calculada por ConfigurarGrid. NAO passar mais de 4
    * argumentos: VFP9 estoura "Must specify additional parameters".
    PROCEDURE mAddColuna(par_cCampo, par_cMascara, par_cTitulo, par_nLargura)
        THIS.this_nColunas = THIS.this_nColunas + 1

        DIMENSION THIS.this_aColunas[THIS.this_nColunas, 4]
        THIS.this_aColunas[THIS.this_nColunas, 1] = par_cCampo
        THIS.this_aColunas[THIS.this_nColunas, 2] = par_cMascara
        THIS.this_aColunas[THIS.this_nColunas, 3] = par_cTitulo
        THIS.this_aColunas[THIS.this_nColunas, 4] = IIF(VARTYPE(par_nLargura) = "N" ;
                                                       AND par_nLargura > 0, par_nLargura, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Show - Exibe o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Show(par_nStyle)
        *-- No modo "reusar cursor ja populado" o chamador seta this_cTitulo DEPOIS
        *-- do Init (que foi quem pintou o cabecalho), entao o dialogo saia com o
        *-- default "Procura". Reaplicar aqui cobre os dois modos de uso.
        IF !EMPTY(THIS.this_cTitulo)
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_cTitulo
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_cTitulo
        ENDIF
        THIS.ConfigurarGrid()
        DODEFAULT(par_nStyle)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Configura colunas do grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_nI, loc_cCampo, loc_cTitulo, loc_nLarguraTotal, loc_nLargura
        LOCAL loc_nSoma, loc_nLarguraGrade

        IF !USED(THIS.this_cCursorDestino)
            RETURN
        ENDIF

        *-- CLAUDE.md regra #21a: posicionar no 1o registro ANTES de ligar a grade.
        *-- No modo "reusar cursor ja populado" o chamador costuma ter feito um LOCATE
        *-- que FALHOU (eh por isso que esta abrindo o picker), deixando o ponteiro
        *-- em EOF - e a grade abria rolada no ultimo registro (erro391).
        SELECT (THIS.this_cCursorDestino)
        GO TOP

        WITH THIS.grd_4c_Lista
            .RecordSource = THIS.this_cCursorDestino
            .ColumnCount = THIS.this_nColunas

            * Calcula largura proporcional sobre a largura MAXIMA da grade
            loc_nLarguraGrade = THIS.Width - 6
            .Width = loc_nLarguraGrade
            loc_nLarguraTotal = loc_nLarguraGrade - 20
            loc_nSoma = 0

            FOR loc_nI = 1 TO THIS.this_nColunas
                loc_cCampo = THIS.this_aColunas[loc_nI, 1]
                loc_cTitulo = THIS.this_aColunas[loc_nI, 3]

                * 1o) a largura DECLARADA no mAddColuna (a do legado) manda.
                * 2o) sem declaracao: com UMA coluna ela fica com a largura toda
                *     (fixar em 80 cortava o texto em tabela de coluna unica, ex.
                *     SigCdOpe.Dopes); com varias, a 1a fica com 80 e as demais
                *     dividem o restante.
                loc_nLargura = THIS.this_aColunas[loc_nI, 4]
                IF loc_nLargura <= 0
                    IF THIS.this_nColunas = 1
                        loc_nLargura = loc_nLarguraTotal
                    ELSE
                        IF loc_nI = 1
                            loc_nLargura = 80
                        ELSE
                            loc_nLargura = (loc_nLarguraTotal - 80) / (THIS.this_nColunas - 1)
                        ENDIF
                    ENDIF
                ENDIF

                .Columns(loc_nI).ControlSource = THIS.this_cCursorDestino + "." + loc_cCampo
                .Columns(loc_nI).Header1.Caption = loc_cTitulo
                .Columns(loc_nI).Width = loc_nLargura
                *-- Alignment nasce 3 (Automatic) e deixava o texto colado na borda
                *-- direita; coluna de picker eh sempre texto -> alinhar a ESQUERDA.
                .Columns(loc_nI).Alignment = 0
                .Columns(loc_nI).Text1.Alignment = 0
                loc_nSoma = loc_nSoma + loc_nLargura
            ENDFOR

            *-- Com larguras DECLARADAS a soma costuma ser menor que a grade, e
            *-- sobrava uma area quadriculada vazia a direita parecendo coluna que
            *-- faltou. O legado redimensiona a GridProc para o conteudo (a classe
            *-- declara Width = 40, ajustado em runtime) - fazer o mesmo.
            IF loc_nSoma + 20 < loc_nLarguraGrade
                .Width = loc_nSoma + 20
            ENDIF
            loc_nLarguraGrade = .Width

            .Refresh()
        ENDWITH

        THIS.AjustarLarguraAoConteudo(loc_nLarguraGrade)
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarLarguraAoConteudo - encolhe o dialogo quando as colunas declaradas
    * ocupam menos que a largura padrao (374 do fwbuscaext legado). Nunca ALARGA,
    * e respeita um piso MEDIDO: o titulo e a barra de botoes tem de caber.
    * Picker que nao declara largura de coluna preenche os 374 e nao muda nada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarLarguraAoConteudo(par_nLarguraGrade)
        LOCAL loc_nIdeal, loc_nPisoTitulo, loc_nPisoBotoes, loc_nPiso, loc_nNova

        loc_nIdeal = par_nLarguraGrade + 6

        *-- piso 1: o titulo do cabecalho (Tahoma 18 bold, Left 10)
        loc_nPisoTitulo = TXTWIDTH(THIS.this_cTitulo, "Tahoma", 18, "B") * ;
                          FONTMETRIC(6, "Tahoma", 18, "B") + 20

        *-- piso 2: a barra de botoes (Width do container + folga das duas bordas)
        loc_nPisoBotoes = THIS.cnt_4c_Botoes.Width + 8

        loc_nPiso = MAX(loc_nPisoTitulo, loc_nPisoBotoes)
        loc_nNova = MAX(loc_nIdeal, loc_nPiso)

        IF loc_nNova < THIS.Width
            THIS.Width = loc_nNova
            THIS.cnt_4c_Cabecalho.Width = loc_nNova
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Width = loc_nNova
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Width = loc_nNova
            THIS.cnt_4c_Botoes.Left = loc_nNova - THIS.cnt_4c_Botoes.Width - 4
        ENDIF
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
                IF VARTYPE(THIS.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = par_cTitulo
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
