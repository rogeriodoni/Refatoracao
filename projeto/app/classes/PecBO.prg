*==============================================================================
* PecBO.prg - Business Object para Posicao Empresarial
* Tabela principal: SigCdPec | PK: pkchaves
* Tabela detalhe:  SigCdPeI | FK: fkchaves -> SigCdPec.pkchaves
*==============================================================================

DEFINE CLASS PecBO AS BusinessBase

    *-- Propriedades da tabela principal SigCdPec
    this_cPkChaves  = ""    && pkchaves  CHAR(20) - Chave prim" + CHR(225) + "ria
    this_cDescs     = ""    && descs     CHAR(40) - Nome do Relat" + CHR(243) + "rio/Descri" + CHR(231) + CHR(227) + "o
    this_cEmps      = ""    && emps      CHAR(3)  - C" + CHR(243) + "digo da Empresa
    this_cUsuars    = ""    && usuars    CHAR(10) - Usu" + CHR(225) + "rio de Inclus" + CHR(227) + "o
    this_tDtIncs    = {}    && dtincs    DATETIME - Data/Hora de Inclus" + CHR(227) + "o
    this_cUsualts   = ""    && usualts   CHAR(10) - Usu" + CHR(225) + "rio de Altera" + CHR(231) + CHR(227) + "o
    this_tDtalts    = {}    && dtalts    DATETIME - Data/Hora de Altera" + CHR(231) + CHR(227) + "o

    *-- Propriedades de item de detalhe corrente (SigCdPeI)
    this_cPeiPkChaves   = ""    && pkchaves  CHAR(20) - PK do item
    this_cPeiFkChaves   = ""    && fkchaves  CHAR(20) - FK para SigCdPec.pkchaves
    this_nPeiMarcas     = 0     && marcas    NUM(1)   - Marca de selecao (0=N, 1=S)
    this_cPeiGrupos     = ""    && grupos    CHAR(10) - Grupo de Conta Corrente
    this_cPeiCodigos    = ""    && codigos   CHAR(50) - C" + CHR(243) + "digo auxiliar
    this_cPeiContas     = ""    && contas    CHAR(10) - Conta do cliente
    this_cPeiOpers      = "+"   && opers     CHAR(1)  - Opera" + CHR(231) + CHR(227) + "o (+ / -)
    this_nPeiOrdems     = 0     && ordems    NUM(4)   - Ordem de exibi" + CHR(231) + CHR(227) + "o

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPec"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT SigCdPec com filtro opcional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT pkchaves, descs, emps, usuars, dtincs, usualts, dtalts" + ;
                    " FROM SigCdPec" + ;
                    " ORDER BY descs"
            ELSE
                loc_cSQL = "SELECT pkchaves, descs, emps, usuars, dtincs, usualts, dtalts" + ;
                    " FROM SigCdPec" + ;
                    " WHERE " + par_cFiltro + ;
                    " ORDER BY descs"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo pkchaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT pkchaves, descs, emps, usuars, dtincs, usualts, dtalts" + ;
                " FROM SigCdPec" + ;
                " WHERE pkchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar registro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves  = TratarNulo(pkchaves, "C")
                THIS.this_cDescs     = TratarNulo(descs,    "C")
                THIS.this_cEmps      = TratarNulo(emps,     "C")
                THIS.this_cUsuars    = TratarNulo(usuars,   "C")
                THIS.this_tDtIncs    = TratarNulo(dtincs,   "T")
                THIS.this_cUsualts   = TratarNulo(usualts,  "C")
                THIS.this_tDtalts    = TratarNulo(dtalts,   "T")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdPec + SigCdPeI
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigCdPec" + ;
                " (pkchaves, descs, emps, usuars, dtincs, usualts, dtalts)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                EscaparSQL(THIS.this_cDescs)    + ", " + ;
                EscaparSQL(THIS.this_cEmps)     + ", " + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                "GETDATE(), " + ;
                "'', " + ;
                "NULL)"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.SalvarItens(THIS.this_cPkChaves)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdPec + DELETE/INSERT SigCdPeI
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPec SET" + ;
                " descs   = " + EscaparSQL(THIS.this_cDescs)     + ", " + ;
                " emps    = " + EscaparSQL(THIS.this_cEmps)      + ", " + ;
                " usualts = " + EscaparSQL(gc_4c_UsuarioLogado)  + ", " + ;
                " dtalts  = GETDATE()" + ;
                " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigCdPeI WHERE fkchaves = " + ;
                    EscaparSQL(THIS.this_cPkChaves)
                SQLEXEC(gnConnHandle, loc_cSQL)

                THIS.SalvarItens(THIS.this_cPkChaves)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdPeI + DELETE SigCdPec
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPeI WHERE fkchaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigCdPec WHERE pkchaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir Posi" + CHR(231) + CHR(227) + "o Empresarial:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDescsUnico - Verifica se descs ja esta cadastrado (para INSERT)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDescsUnico(par_cDescs)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_ValidaDescs")
                USE IN cursor_4c_ValidaDescs
            ENDIF

            loc_cSQL = "SELECT pkchaves FROM SigCdPec" + ;
                " WHERE descs = " + EscaparSQL(par_cDescs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaDescs")

            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_ValidaDescs") > 0)
                USE IN cursor_4c_ValidaDescs
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao validar nome:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega SigCdGcr para o grid de grupos
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarItensParaDestinos - Carrega SigCdPeI + detalhes no cursor csDestinos
    * par_cPkChaves: pkchaves do SigCdPec
    *--------------------------------------------------------------------------
    FUNCTION CarregarItensParaDestinos(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT PEC.descs, PEC.pkchaves," + ;
                " PEI.codigos, PEI.fkchaves, PEI.grupos, PEI.contas, PEI.ordems," + ;
                " GCR.descrs AS descrsgrupo, CLI.iclis, CLI.rclis, PEI.Opers" + ;
                " FROM SigCdPec PEC" + ;
                " LEFT OUTER JOIN SigCdPei PEI ON PEI.fkchaves = " + EscaparSQL(par_cPkChaves) + ;
                " LEFT OUTER JOIN SigCdCli CLI ON CLI.iclis = PEI.contas" + ;
                " LEFT OUTER JOIN SigCdGcr GCR ON GCR.codigos = PEI.grupos" + ;
                " WHERE PEC.pkchaves = " + EscaparSQL(par_cPkChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                IF USED("csDestinos")
                    ZAP IN csDestinos
                ENDIF

                IF RECCOUNT("cursor_4c_Itens") > 0
                    SELECT cursor_4c_Itens
                    GO TOP

                    SCAN
                        IF USED("csDestinos")
                            INSERT INTO csDestinos ;
                                (PkChaves, FkChaves, Marcas, Grupos, Codigos, ;
                                 DescontaG, ContaG, Opers, Ordems) ;
                            VALUES ;
                                (cursor_4c_Itens.pkchaves, cursor_4c_Itens.fkchaves, ;
                                 1, cursor_4c_Itens.grupos, cursor_4c_Itens.codigos, ;
                                 cursor_4c_Itens.rclis, cursor_4c_Itens.contas, ;
                                 cursor_4c_Itens.Opers, cursor_4c_Itens.ordems)
                        ENDIF
                        SELECT cursor_4c_Itens
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                IF USED("csDestinos")
                    SELECT csDestinos
                    INDEX ON Ordems TAG Ordems
                    GO TOP
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarItens - Salva csDestinos (marcados) no SigCdPeI via SQL
    * par_cPkChaves: pkchaves do registro pai
    *--------------------------------------------------------------------------
    FUNCTION SalvarItens(par_cPkChaves)
        LOCAL loc_cSQL, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("csDestinos")
                loc_lSucesso = .T.
            ELSE
                loc_nSeq = 0
                SELECT csDestinos
                SET ORDER TO Ordems
                DELETE FROM csDestinos WHERE Marcas = 0
                GO TOP

                SCAN
                    loc_nSeq = loc_nSeq + 1
                    loc_cSQL = "INSERT INTO SigCdPeI" + ;
                        " (pkchaves, fkchaves, marcas, grupos, codigos, opers, ordems, contas)" + ;
                        " VALUES (" + ;
                        EscaparSQL(fUniqueIds())        + ", " + ;
                        EscaparSQL(par_cPkChaves)       + ", " + ;
                        TRANSFORM(csDestinos.Marcas)    + ", " + ;
                        EscaparSQL(csDestinos.Grupos)   + ", " + ;
                        EscaparSQL(csDestinos.Codigos)  + ", " + ;
                        EscaparSQL(csDestinos.Opers)    + ", " + ;
                        TRANSFORM(loc_nSeq)             + ", " + ;
                        EscaparSQL(csDestinos.ContaG)   + ")"

                    SQLEXEC(gnConnHandle, loc_cSQL)
                    SELECT csDestinos
                ENDSCAN

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao salvar itens:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarExpansaoGrupo - UNION query para CmdExpandir (busca grupo+contas)
    * par_cGrupo: codigo do grupo selecionado no grdGrupos
    * Resulta em cursor_4c_ExpGrupo com: Codigos, Descrs, iclis, rclis
    *--------------------------------------------------------------------------
    FUNCTION BuscarExpansaoGrupo(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ExpGrupo")
                USE IN cursor_4c_ExpGrupo
            ENDIF

            loc_cSQL = "Select distinct GCR.codigos, GCR.descrs, CLI.iclis, CLI.rclis" + ;
                " From SigCdGcr GCR" + ;
                " inner join SigCdCli CLI on GCR.codigos = CLI.Grupos" + ;
                " where CLI.grupos = " + EscaparSQL(par_cGrupo) + ;
                " UNION" + ;
                " Select distinct CCR.grupos as codigos, GCR.descrs, CCR.contas as iclis, CLI.rclis" + ;
                " From SigMvCCR CCR" + ;
                " inner join SigCdCli CLI on CCR.contas = CLI.iclis" + ;
                " left outer join SigCdGcr GCR on CCR.grupos = GCR.codigos" + ;
                " where CCR.grupos = " + EscaparSQL(par_cGrupo) + ;
                " order by 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExpGrupo")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao expandir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao expandir grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarGrupos - Sincroniza SigCdPeI com grupos/contas (atualizagrupos)
    * par_cPkChaves: pkchaves do registro pai
    * Busca todos grupos+contas e insere no crSigCdPeI os que nao existem ainda
    *--------------------------------------------------------------------------
    FUNCTION AtualizarGrupos(par_cPkChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nProx
        LOCAL loc_cCodigos, loc_cContas, loc_cGrupos
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GruposCli")
                USE IN cursor_4c_GruposCli
            ENDIF

            loc_cSQL = "Select distinct GCR.codigos, GCR.descrs, CLI.iclis, CLI.rclis" + ;
                " From SigCdGcr GCR" + ;
                " inner join SigCdCli CLI on GCR.codigos = CLI.Grupos" + ;
                " UNION" + ;
                " Select distinct CCR.grupos as codigos, GCR.descrs, CCR.contas as iclis, CLI.rclis" + ;
                " From SigMvCCR CCR" + ;
                " inner join SigCdCli CLI on CCR.contas = CLI.iclis" + ;
                " left outer join SigCdGcr GCR on CCR.grupos = GCR.codigos" + ;
                " where CCR.grupos <> ''" + ;
                " order by 1"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposCli")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_MaxOrd")
                    USE IN cursor_4c_MaxOrd
                ENDIF
                loc_cSQL = "SELECT MAX(ordems) AS nProx FROM SigCdPeI WHERE fkchaves = " + ;
                    EscaparSQL(par_cPkChaves)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrd")
                SELECT cursor_4c_MaxOrd
                loc_nProx = NVL(nProx, 0)
                USE IN cursor_4c_MaxOrd

                SELECT cursor_4c_GruposCli
                GO TOP

                SCAN
                    loc_cCodigos = ALLTRIM(cursor_4c_GruposCli.codigos)
                    loc_cContas  = ALLTRIM(cursor_4c_GruposCli.iclis)
                    loc_cGrupos  = ALLTRIM(cursor_4c_GruposCli.codigos)

                    IF USED("cursor_4c_ChkItem")
                        USE IN cursor_4c_ChkItem
                    ENDIF
                    loc_cSQL = "SELECT pkchaves FROM SigCdPeI" + ;
                        " WHERE fkchaves = " + EscaparSQL(par_cPkChaves) + ;
                        " AND grupos = " + EscaparSQL(loc_cGrupos) + ;
                        " AND contas = " + EscaparSQL(loc_cContas)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkItem")

                    IF RECCOUNT("cursor_4c_ChkItem") = 0
                        loc_nProx = loc_nProx + 1
                        loc_cSQL = "INSERT INTO SigCdPeI" + ;
                            " (pkchaves, fkchaves, marcas, grupos, codigos, opers, ordems, contas)" + ;
                            " VALUES (" + ;
                            EscaparSQL(fUniqueIds())     + ", " + ;
                            EscaparSQL(par_cPkChaves)    + ", 0, " + ;
                            EscaparSQL(loc_cGrupos)      + ", '', '+', " + ;
                            TRANSFORM(loc_nProx)         + ", " + ;
                            EscaparSQL(loc_cContas)      + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF

                    IF USED("cursor_4c_ChkItem")
                        USE IN cursor_4c_ChkItem
                    ENDIF

                    SELECT cursor_4c_GruposCli
                ENDSCAN

                IF USED("cursor_4c_GruposCli")
                    USE IN cursor_4c_GruposCli
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
