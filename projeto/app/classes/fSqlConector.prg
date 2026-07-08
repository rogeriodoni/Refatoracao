*==============================================================================
* fSqlConector.prg - Classe de Compatibilidade
*==============================================================================
* Wrapper de compatibilidade para codigo legado que usa fSqlConector
* Utiliza a conexao global gnConnHandle existente
*
* IMPORTANTE: Esta classe existe APENAS para manter compatibilidade com
*             formularios migrados que ainda usam o padrao legado.
*             Novos formularios devem usar DataAccess ou SQLEXEC direto.
*
* Data: 2026-02-06
*==============================================================================

DEFINE CLASS fSqlConector AS Custom

    *-- Propriedades de conexao
    pnIdconn = 0          && Handle da conexao SQL
    this_cNomeTabela = "" && Nome da tabela principal

    *--------------------------------------------------------------------------
    * Init - Inicializa conexao usando gnConnHandle global
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cTabela)
        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.pnIdconn = gnConnHandle
        ELSE
            THIS.pnIdconn = 0
        ENDIF

        IF TYPE("par_cTabela") = "C"
            THIS.this_cNomeTabela = par_cTabela
        ENDIF

        RETURN THIS.pnIdconn > 0
    ENDPROC

    *--------------------------------------------------------------------------
    * CursorQuery - Carrega tabela inteira para cursor
    * par_cTabela: Nome da tabela
    * par_cAlias: Nome do cursor destino
    * par_lIndex: Criar indice (opcional)
    * par_lReadOnly: Somente leitura (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE CursorQuery(par_cTabela, par_cAlias, par_lIndex, par_lReadOnly)
        LOCAL loc_cSQL, loc_nResultado

        IF THIS.pnIdconn <= 0
            RETURN -1
        ENDIF

        loc_cSQL = "SELECT * FROM " + par_cTabela

        loc_nResultado = SQLEXEC(THIS.pnIdconn, loc_cSQL, par_cAlias)

        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SqlExecute - Executa query SQL
    * par_cSQL: Comando SQL
    * par_cAlias: Nome do cursor destino
    *--------------------------------------------------------------------------
    PROCEDURE SqlExecute(par_cSQL, par_cAlias)
        LOCAL loc_nResultado

        IF THIS.pnIdconn <= 0
            RETURN -1
        ENDIF

        IF EMPTY(par_cAlias)
            par_cAlias = "crResultado"
        ENDIF

        loc_nResultado = SQLEXEC(THIS.pnIdconn, par_cSQL, par_cAlias)

        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Release - Libera recursos (nao desconecta gnConnHandle global)
    *--------------------------------------------------------------------------
    PROCEDURE Release()
        *-- NAO desconecta gnConnHandle pois eh global e compartilhado
        *-- Apenas limpa referencia local
        THIS.pnIdconn = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.Release()
    ENDPROC

ENDDEFINE
