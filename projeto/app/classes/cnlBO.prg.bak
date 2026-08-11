*===========================================================================
* cnlBO.prg - Business Object para Contagem de Produtos por Localizacao
* Tabela principal: SigCdCnL (cabecalho da contagem)
* Tabela detalhe  : SigCdCnI (itens / localizacoes)
* Criado em: 2026-07-29
*===========================================================================

DEFINE CLASS cnlBO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela     = "SigCdCnL"
    this_cCampoChave = "Cods"

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCnL (schema: sigcdcnl)
    *--------------------------------------------------------------------------

    *-- Chave de negocio (cods char 10) - usada em WHERE das operacoes
    this_cCodigo     = ""

    *-- Chave tecnica interna (cidchaves char 20) - PK fisica
    this_cCidChaves  = ""

    *-- Empresa (emps char 3)
    this_cEmps       = ""

    *-- Vendedor responsavel (vends char 10 - FK SigCdCli.Iclis)
    this_cVends      = ""

    *-- Localizacao principal (locals char 10 - FK SigPrLcl.codigos)
    this_cLocals     = ""

    *-- Data da contagem (datas datetime)
    this_dDatas      = {}

    *-- Ordenacao do grid (qtds numeric 5,0): 0/1=Base, 2=Nvl2, 3=Nvl3, 4=Nvl4
    this_nQtds       = 0

    *-- Status (conferido numeric 1,0): 0=aberta, 1=encerrada
    this_nConferido  = 0

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (resultado de JOINs na query Buscar)
    *--------------------------------------------------------------------------

    *-- Descricao do vendedor (alias desvends = SigCdCli.Rclis)
    this_cDesVends   = ""

    *-- Descricao da localizacao (alias dlocals = SigPrLcl.descricaos)
    this_cDLocals    = ""

    *--------------------------------------------------------------------------
    * Nomes dos cursores de trabalho
    *--------------------------------------------------------------------------

    *-- Cursor de itens criado pelo form (csSigCdCnI)
    this_cCursorItens = "csSigCdCnI"

    *-- Cursor principal da lista (Buscar)
    this_cCursorDados = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnL"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega lista de contagens com JOINs
    * par_cFiltro: condicao SQL adicional (opcional)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.datas DESC, a.cods"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de contagens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigCdCnL pelo Cods
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND a.emps = " + EscaparSQL(loc_cEmpresa)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor posicionado
    * REGRA: SEMPRE SELECT (alias) antes de acessar campos
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(cods,       "C")
            THIS.this_nConferido  = TratarNulo(conferido,  "N")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cLocals     = TratarNulo(locals,     "C")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")
            THIS.this_cVends      = TratarNulo(vends,      "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cDesVends   = TratarNulo(desvends,   "C")
            THIS.this_cDLocals    = TratarNulo(dlocals,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigCdCnL (chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = THIS.ObterNovoCidChaves()
            IF !EMPTY(loc_cCidChaves)
                loc_cCodigo = THIS.ObterProximoCodigo()
                IF !EMPTY(loc_cCodigo)
                    THIS.this_cCidChaves = loc_cCidChaves
                    THIS.this_cCodigo    = loc_cCodigo
                    THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                    THIS.this_nConferido = 0

                    loc_cSQL = "INSERT INTO sigcdcnl" + ;
                               " (cidchaves, cods, conferido, datas, locals, qtds, vends, emps)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                               FormatarNumeroSQL(THIS.this_nConferido) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(THIS.this_cLocals) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                               EscaparSQL(THIS.this_cVends) + ", " + ;
                               EscaparSQL(THIS.this_cEmps)  + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir contagem: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar chave interna da contagem.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCdCnL (vends, locals, qtds)
    * O legado fazia delete+reinsert via cursor; aqui usamos UPDATE direto.
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET" + ;
                       " vends  = " + EscaparSQL(THIS.this_cVends)  + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " qtds   = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " datas  = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de SigCdCnI (itens) + SigCdCnL (cabecalho)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM sigcdcnl" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                           " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir contagem: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SalvarItens - Salva itens do cursor csSigCdCnI em SigCdCnI
    * par_cCursorItens: nome do cursor com colunas Locals, QtdCtg, Qtde
    * par_cCodigo: Cods do cabecalho (SigCdCnL.cods)
    * Mapeamento: sigcdcni.qtds <- csSigCdCnI.QtdCtg (contagem)
    *             sigcdcni.estoque <- csSigCdCnI.Qtde (estoque)
    *==========================================================================
    FUNCTION SalvarItens(par_cCursorItens, par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_nResultado
        LOCAL loc_cLocals, loc_nQtdCtg, loc_nQtde
        loc_lSucesso = .F.

        IF !USED(par_cCursorItens)
            MsgErro("Cursor de itens n" + CHR(227) + "o encontrado: " + par_cCursorItens, "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Limpar itens existentes para este codigo
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- Inserir itens do cursor
                SELECT (par_cCursorItens)
                GO TOP
                loc_lSucesso = .T.

                SCAN WHILE loc_lSucesso
                    *-- Capturar campos ANTES de chamar ObterNovoCidChaves (muda SELECT)
                    loc_cLocals  = ALLTRIM(locals)
                    loc_nQtdCtg  = qtdctg
                    loc_nQtde    = qtde

                    loc_cCidChaves = THIS.ObterNovoCidChaves()
                    IF EMPTY(loc_cCidChaves)
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO sigcdcni" + ;
                                   " (cidchaves, cods, locals, qtds, estoque, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCodigo)    + ", " + ;
                                   EscaparSQL(loc_cLocals)    + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCtg) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtde)   + ", " + ;
                                   EscaparSQL("") + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir item [" + loc_cLocals + "]: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF

                    *-- Restaurar selecao para proxima iteracao do SCAN
                    SELECT (par_cCursorItens)
                ENDSCAN
            ELSE
                MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarItens: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega itens de SigCdCnI para um cursor
    * par_cCodigo: Cods do cabecalho
    * par_cCursorDestino: nome do cursor destino (default: crSigCdCnI)
    *==========================================================================
    FUNCTION CarregarItens(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "crSigCdCnI", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cods, locals, qtds, estoque, mercs" + ;
                       " FROM sigcdcni" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY locals"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FecharContagem - Define Conferido=1 (encerra a contagem)
    *==========================================================================
    FUNCTION FecharContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 1" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao fechar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FecharContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ReobrirContagem - Define Conferido=0 (reabre a contagem encerrada)
    *==========================================================================
    FUNCTION ReobrirContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 0" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao reabrir contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ReobrirContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametrosVendedor - Carrega SigCdPam para obter GrPadVens
    * Replica CursorQuery([SigCdPam], [LocalPam], ...)
    * par_cCursorDestino: nome do cursor destino (default: cursor_4c_LocalPam)
    *==========================================================================
    FUNCTION CarregarParametrosVendedor(par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_LocalPam", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                IF !EOF()
                    loc_lSucesso = !EMPTY(ALLTRIM(GrPadVens))
                ENDIF
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros de vendedor: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametrosVendedor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarVendedores - Carrega vendedores validos para lookup
    * Replica a query dos eventos Valid de getConta/getDConta
    * par_cFiltro    : usuario logado ou valor digitado no campo
    * par_cGrPadVens : grupo padrao de vendedores (de SigCdPam)
    * par_cCursorDestino: cursor de resultado (default: cursor_4c_Vendedores)
    *==========================================================================
    FUNCTION BuscarVendedores(par_cFiltro, par_cGrPadVens, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Vendedores", par_cCursorDestino)
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs," + ;
                       " a.inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce ace ON a.Iclis = ace.Usuarios" + ;
                       " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
                       " AND a.IClis NOT IN" + ;
                       " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
                       " WHERE c.Jobs NOT IN" + ;
                       " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
                       " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND ace.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                       " ORDER BY a.iclis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar vendedores: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarVendedores: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoesNivel - Carrega SigLcNv1/2/3/4 para cursor local
    * par_nNivel: 1, 2, 3 ou 4
    * par_cCursorDestino: cursor destino (ex: "csNivel1")
    *==========================================================================
    FUNCTION CarregarLocalizacoesNivel(par_nNivel, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cTabela, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "csNivel" + LTRIM(STR(par_nNivel)), par_cCursorDestino)

        TRY
            DO CASE
            CASE par_nNivel = 1
                loc_cTabela = "SigLcNv1"
            CASE par_nNivel = 2
                loc_cTabela = "SigLcNv2"
            CASE par_nNivel = 3
                loc_cTabela = "SigLcNv3"
            CASE par_nNivel = 4
                loc_cTabela = "SigLcNv4"
            OTHERWISE
                MsgErro("N" + CHR(237) + "vel inv" + CHR(225) + "lido: " + ;
                        LTRIM(STR(par_nNivel)), "Erro")
                loc_lSucesso = .F.
            ENDCASE

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT * FROM " + loc_cTabela

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar " + loc_cTabela + ": " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLocalizacoesNivel: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterNovoCidChaves - Gera novo cidchaves unico (char 20) via NEWID()
    *==========================================================================
    PROTECTED FUNCTION ObterNovoCidChaves()
        LOCAL loc_cChave, loc_lSucesso
        loc_cChave   = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()),'-',''), 20) AS nova_chave", ;
                "cursor_4c_NovaChave") > 0
            IF loc_lSucesso
                SELECT cursor_4c_NovaChave
                loc_cChave = ALLTRIM(nova_chave)
            ELSE
                MsgErro("Erro ao gerar chave interna: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterNovoCidChaves: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NovaChave")
            USE IN cursor_4c_NovaChave
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterProximoCodigo - Gera proximo Cods numerico disponivel em SigCdCnL
    *==========================================================================
    PROTECTED FUNCTION ObterProximoCodigo()
        LOCAL loc_cCodigo, loc_lSucesso
        loc_cCodigo  = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(CAST(cods AS bigint)), 0) + 1 AS proximo FROM sigcdcnl", ;
                "cursor_4c_ProxCod") > 0
            IF loc_lSucesso
                SELECT cursor_4c_ProxCod
                loc_cCodigo = ALLTRIM(STR(cursor_4c_ProxCod.proximo, 10))
            ELSE
                MsgErro("Erro ao obter pr" + CHR(243) + "ximo c" + CHR(243) + "digo: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterProximoCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE
