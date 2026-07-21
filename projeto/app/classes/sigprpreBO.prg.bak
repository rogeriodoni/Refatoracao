*=============================================================================
* sigprpreBO.prg - Business Object para Alteracao de Precos
* Herda de: BusinessBase
* Tabela: sigprpre (PK: cidchaves)
* Campos: cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant,
*         usuals, ckatusite
* JOIN display: dpros, cgrus (de SigCdPro)
*=============================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Campos da tabela sigprpre
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCPros      = ""   && cpros char(14) NOT NULL - Codigo do produto
    this_dDatas      = {}   && datas datetime NULL - Data da alteracao
    this_cMoevs      = ""   && moevs char(3) NOT NULL - Moeda atual
    this_cMoevsAnt   = ""   && moevsant char(3) NOT NULL - Moeda anterior
    this_nPVens      = 0    && pvens numeric(11,5) NOT NULL - Preco de venda atual
    this_nPVensAnt   = 0    && pvensant numeric(11,5) NOT NULL - Preco de venda anterior
    this_cUsuals     = ""   && usuals nvarchar(20) NULL - Usuario
    this_nCKAtuSite  = 0    && ckatusite numeric(1,0) NOT NULL - Flag atualizacao site

    *-- Campos auxiliares de exibicao (JOIN com SigCdPro)
    this_cDPros      = ""   && dpros - Descricao do produto
    this_cCGrus      = ""   && cgrus - Codigo do grupo do produto

    *-- Filtros de consulta (usados em Buscar)
    this_dDataInicio = {}   && Data de inicio do periodo
    this_dDataFim    = {}   && Data de fim do periodo
    this_cFiltroCPro = ""   && Filtro por codigo de produto
    this_cFiltroGru  = ""   && Filtro por codigo de grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprpre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCPros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cMoevs      = TratarNulo(moevs,      "C")
            THIS.this_cMoevsAnt   = TratarNulo(moevsant,   "C")
            THIS.this_nPVens      = TratarNulo(pvens,      "N")
            THIS.this_nPVensAnt   = TratarNulo(pvensant,   "N")
            THIS.this_cUsuals     = TratarNulo(usuals,     "C")
            THIS.this_nCKAtuSite  = TratarNulo(ckatusite,  "N")
            IF TYPE("dpros") != "U"
                THIS.this_cDPros  = TratarNulo(dpros,      "C")
            ENDIF
            IF TYPE("cgrus") != "U"
                THIS.this_cCGrus  = TratarNulo(cgrus,      "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtros de periodo, produto e grupo
    * Cursor resultante: crSigPrPre (nome legado preservado para binding do grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFim
        LOCAL loc_cProdF, loc_cGruF, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Calcular limites para filtros "entre" (padrao do legado)
            IF EMPTY(THIS.this_cFiltroCPro)
                loc_cProdF = "zzzzzzzzzzzzzz"
            ELSE
                loc_cProdF = ALLTRIM(THIS.this_cFiltroCPro)
            ENDIF
            IF EMPTY(THIS.this_cFiltroGru)
                loc_cGruF = "zzz"
            ELSE
                loc_cGruF = ALLTRIM(THIS.this_cFiltroGru)
            ENDIF

            *-- Formatar datas
            IF EMPTY(THIS.this_dDataInicio)
                loc_cDataIni = FormatarDataSQL(DATE())
            ELSE
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicio)
            ENDIF
            IF EMPTY(THIS.this_dDataFim)
                loc_cDataFim = "'" + LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()),5,2) + "-" + RIGHT(DTOS(DATE()),2) + " 23:59:59'"
            ELSE
                loc_cDataFim = "'" + LEFT(DTOS(THIS.this_dDataFim), 4) + "-" + SUBSTR(DTOS(THIS.this_dDataFim),5,2) + "-" + RIGHT(DTOS(THIS.this_dDataFim),2) + " 23:59:59'"
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.cpros BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroCPro)) + ;
                       " AND " + EscaparSQL(loc_cProdF) + ;
                       " AND b.cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroGru)) + ;
                       " AND " + EscaparSQL(loc_cGruF) + ;
                       " ORDER BY a.datas DESC, a.cpros"

            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista") > 0
                IF USED("cursor_4c_Lista")
                    SELECT cursor_4c_Lista
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar registro."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cChaveNova
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica para cidchaves (char 20)
            IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChaveNova = LEFT(ALLTRIM(nid), 20)
                USE IN cursor_4c_NewId
            ELSE
                loc_cChaveNova = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF
            THIS.this_cCidChaves = loc_cChaveNova

            loc_cSQL = "INSERT INTO sigprpre" + ;
                       " (cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant, usuals, ckatusite)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCPros)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs)     + ", " + ;
                       EscaparSQL(THIS.this_cMoevsAnt)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVens)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVensAnt) + ", " + ;
                       EscaparSQL(THIS.this_cUsuals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCKAtuSite) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprpre SET" + ;
                       " cpros    = " + EscaparSQL(THIS.this_cCPros)          + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " moevs    = " + EscaparSQL(THIS.this_cMoevs)          + ", " + ;
                       " moevsant = " + EscaparSQL(THIS.this_cMoevsAnt)       + ", " + ;
                       " pvens    = " + FormatarNumeroSQL(THIS.this_nPVens)   + ", " + ;
                       " pvensant = " + FormatarNumeroSQL(THIS.this_nPVensAnt)+ ", " + ;
                       " usuals   = " + EscaparSQL(THIS.this_cUsuals)         + ", " + ;
                       " ckatusite= " + FormatarNumeroSQL(THIS.this_nCKAtuSite) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprpre WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
