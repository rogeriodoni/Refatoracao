*====================================================================
* PENBO.prg - Business Object para Penalidades de Comissao
* Migrado de: SIGCDPEN.SCX
* Tabela: SigCdPen (cidchaves, blqpags, grupos, contas, ddis, ddfs, penas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS PENBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento SigCdPen)
    this_cCidchaves = ""    && cidchaves char(20) - PK
    this_cGrupos    = ""    && grupos char(10) - codigo do grupo comissao
    this_cContas    = ""    && contas char(10) - codigo da conta corrente
    this_nDdis      = 0     && ddis numeric(4,0) - dias atraso inicio
    this_nDdfs      = 0     && ddfs numeric(4,0) - dias atraso fim
    this_nPenas     = 0     && penas numeric(5,2) - percentual penalidade
    this_cBlqpags   = "0"   && blqpags char(1) - bloqueado

    *====================================================================
    * Init - Inicializa BO
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPen"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro livre (WHERE clause)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.grupos, " + ;
                       "ISNULL(g.descs, '') as descgrupo, " + ;
                       "a.contas, a.ddis, a.ddfs, a.penas " + ;
                       "FROM SigCdPen a " + ;
                       "LEFT JOIN SigCdGpr g ON g.codigos = a.grupos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.ddis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF RECCOUNT("cursor_4c_DadosTemp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTemp")
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao buscar dados: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PENBO.Buscar")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PENBO.Buscar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor ativo
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAlias)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAlias)
            THIS.this_cCidchaves = ALLTRIM(cidchaves)
            THIS.this_cGrupos    = ALLTRIM(grupos)
            THIS.this_cContas    = ALLTRIM(contas)
            THIS.this_nDdis      = ddis
            THIS.this_nDdfs      = ddfs
            THIS.this_nPenas     = penas
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "PENBO.CarregarDoCursor")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir (PROTECTED) - INSERT INTO SigCdPen
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cPk, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cPk = LEFT(SYS(2015) + SYS(2015), 20)
            THIS.this_cCidchaves = loc_cPk

            loc_cSQL = "INSERT INTO SigCdPen " + ;
                "(cidchaves, blqpags, grupos, contas, ddis, ddfs, penas) " + ;
                "VALUES (" + ;
                EscaparSQL(loc_cPk) + ", " + ;
                EscaparSQL("0") + ", " + ;
                EscaparSQL(THIS.this_cGrupos) + ", " + ;
                EscaparSQL(THIS.this_cContas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDdfs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPenas, 2) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao inserir: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PENBO.Inserir")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PENBO.Inserir")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar (PROTECTED) - UPDATE SigCdPen
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPen SET " + ;
                "grupos = "  + EscaparSQL(THIS.this_cGrupos)               + ", " + ;
                "contas = "  + EscaparSQL(THIS.this_cContas)               + ", " + ;
                "ddis = "    + FormatarNumeroSQL(THIS.this_nDdis, 0)       + ", " + ;
                "ddfs = "    + FormatarNumeroSQL(THIS.this_nDdfs, 0)       + ", " + ;
                "penas = "   + FormatarNumeroSQL(THIS.this_nPenas, 2)      + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PENBO.Atualizar")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", "PENBO.Atualizar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao (PROTECTED) - DELETE FROM SigCdPen
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_aErro[1]
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPen WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                AERROR(loc_aErro)
                THIS.this_cMensagemErro = "Erro ao excluir: " + loc_aErro[1,2]
                MsgErro(THIS.this_cMensagemErro, "PENBO.ExecutarExclusao")
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " (Linha:" + TRANSFORM(loc_oErro.LineNo) + ")", ;
                "PENBO.ExecutarExclusao")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BuscarDescGrupo - Retorna descs de SigCdGpr dado codigos
    *====================================================================
    PROCEDURE BuscarDescGrupo(par_cCodigos)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(par_cCodigos), ;
                "cursor_4c_DescGrupo")
            IF loc_nResult > 0 AND USED("cursor_4c_DescGrupo") AND ;
               RECCOUNT("cursor_4c_DescGrupo") > 0 AND !EMPTY(cursor_4c_DescGrupo.descs)
                loc_cDesc = ALLTRIM(cursor_4c_DescGrupo.descs)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PENBO.BuscarDescGrupo")
        ENDTRY
        IF USED("cursor_4c_DescGrupo")
            USE IN cursor_4c_DescGrupo
        ENDIF
        RETURN loc_cDesc
    ENDPROC

    *====================================================================
    * BuscarDescConta - Retorna Descrs de SigCdCcr dado Codigos
    *====================================================================
    PROCEDURE BuscarDescConta(par_cCodigos)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdCcr WHERE Codigos = " + EscaparSQL(par_cCodigos), ;
                "cursor_4c_DescConta")
            IF loc_nResult > 0 AND USED("cursor_4c_DescConta") AND ;
               RECCOUNT("cursor_4c_DescConta") > 0 AND !EMPTY(cursor_4c_DescConta.Descrs)
                loc_cDesc = ALLTRIM(cursor_4c_DescConta.Descrs)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PENBO.BuscarDescConta")
        ENDTRY
        IF USED("cursor_4c_DescConta")
            USE IN cursor_4c_DescConta
        ENDIF
        RETURN loc_cDesc
    ENDPROC

ENDDEFINE
