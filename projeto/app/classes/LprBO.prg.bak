*------------------------------------------------------------------------------
* LprBO.prg - Business Object para Listas de Precificacao
* Tabela principal: SigCdLpc (cabecalho da lista)
* Tabela detalhe  : SigCdLpi (itens da lista)
* Herda de        : BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS LprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades SigCdLpc - campo a campo conforme schema.sql
    *--------------------------------------------------------------------------
    this_cLprecos    = ""    && c(30) PK  - codigo da lista de precos
    this_cFpags      = ""    && c(12)     - condicao de pagamento (FK SigOpFp)
    this_nFormulas   = 0     && n(1,0)    - tipo formula de calculo
    this_nComiss     = 0     && n(1,0)    - tipo calculo comissao
    this_nNvencs     = 0     && n(1,0)    - tipo vencimento
    this_cContas     = ""    && c(10)     - conta (modo compra: fornecedor)
    this_lFlags      = .F.   && bit       - ja atualizada no sistema
    this_cTipos      = ""    && c(1)      - tipo: "C"=compra, " "=venda
    this_dVencis     = {}    && datetime  - data vencimento inicial
    this_nAplictabds = 0     && n(1,0)    - aplica tabela de desconto
    this_cCidchaves  = ""    && c(20)     - chave unica
    this_nDescos     = 0     && n(5,2)    - percentual de desconto
    this_cTabds      = ""    && c(10)     - codigo tabela desconto (FK SigOpTdz)
    this_nCodigos    = 0     && n(6,0)    - codigo sequencial (gerado por fGerUniqueKey)
    this_cEmps       = ""    && c(3)      - empresa (FK SigCdEmp)
    this_nNqtdes     = 0     && n(5,0)    - quantidade minima

    *--------------------------------------------------------------------------
    * Propriedades auxiliares - descricoes (nao persistidas no banco)
    *--------------------------------------------------------------------------
    this_cDfpags     = ""    && descricao da condicao de pagamento
    this_cDtabds     = ""    && descricao da tabela de desconto
    this_cDemps      = ""    && razao social da empresa
    this_cDcontas    = ""    && descricao da conta (modo compra)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLpc"
        THIS.this_cCampoChave = "lprecos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLprecos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista cabecalhos SigCdLpc filtrados por empresa e tipo
    * par_cFiltro: "C"=compra, " "=venda (vazio = venda)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTipos
        loc_lSucesso = .F.

        TRY
            loc_cTipos = IIF(VARTYPE(par_cFiltro) = "C" AND ALLTRIM(par_cFiltro) = "C", "C", " ")

            loc_cSQL = "SELECT DISTINCT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " INNER JOIN SigCdLpi b ON a.lprecos = b.lprecos" + ;
                       " WHERE a.Tipos = " + EscaparSQL(loc_cTipos) + ;
                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.lprecos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de precifica" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar listas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um SigCdLpc pela PK lprecos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " WHERE a.lprecos = " + EscaparSQL(par_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cLprecos     = TratarNulo(lprecos,     "C")
            THIS.this_cFpags       = TratarNulo(fpags,       "C")
            THIS.this_nFormulas    = TratarNulo(formulas,    "N")
            THIS.this_nComiss      = TratarNulo(ncomiss,     "N")
            THIS.this_nNvencs      = TratarNulo(nvencs,      "N")
            THIS.this_cContas      = TratarNulo(contas,      "C")
            THIS.this_lFlags       = (TratarNulo(flags, "N") = 1)
            THIS.this_cTipos       = TratarNulo(tipos,       "C")
            THIS.this_dVencis      = TratarNulo(vencis,      "D")
            THIS.this_nAplictabds  = TratarNulo(aplictabds,  "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_nDescos      = TratarNulo(descos,      "N")
            THIS.this_cTabds       = TratarNulo(tabds,       "C")
            THIS.this_nCodigos     = TratarNulo(codigos,     "N")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_nNqtdes      = TratarNulo(nqtdes,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdLpc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLpc" + ;
                       " (lprecos, fpags, formulas, ncomiss, nvencs, contas," + ;
                       " flags, tipos, vencis, aplictabds, cidchaves, descos," + ;
                       " tabds, codigos, emps, nqtdes)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLprecos) + "," + ;
                       EscaparSQL(THIS.this_cFpags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       EscaparSQL(THIS.this_cTabds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNqtdes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdLpc (lprecos eh PK, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET" + ;
                       " fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                       " formulas = " + FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       " ncomiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " nvencs = " + FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " flags = " + IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       " tipos = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       " vencis = " + FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       " aplictabds = " + FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       " descos = " + FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " codigos = " + FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " nqtdes = " + FormatarNumeroSQL(THIS.this_nNqtdes) + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi (itens) e SigCdLpc (cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (FK)
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + ;
                       EscaparSQL(THIS.this_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdLpc WHERE lprecos = " + ;
                           EscaparSQL(THIS.this_cLprecos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega SigCdLpi de uma lista no cursor_4c_Itens
    * par_cLprecos: codigo da lista de precos
    * par_cTipos  : "C"=compra, " "=venda (determina colunas do grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cLprecos, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLprecos))
            RETURN .F.
        ENDIF

        TRY

            IF VARTYPE(par_cTipos) != "C"
                par_cTipos = " "
            ENDIF

            IF ALLTRIM(par_cTipos) = "C"
                *-- Modo compra: colunas cpros, dpros, reffs, ean13, pcuss, moevs + custo novo
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.reffs, a.ean13, a.pcuss, a.moevs," + ;
                           " a.pvens, a.vencis, a.vencfs, a.comiss," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ELSE
                *-- Modo venda: colunas cpros, dpros, pvens, moevs, comiss, vencis, vencfs
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.pvens, a.moevs, a.comiss, a.vencis, a.vencfs," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles," + ;
                           " a.ean13, a.pcuss, a.reffs, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarItens - Persiste cursor_4c_Itens no SQL Server via DELETE+INSERT
    * par_cLprecos: codigo da lista de precos
    * Estrategia: DELETE todos do lprecos + INSERT dos nao-deletados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarItens(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroItem
        LOCAL loc_cCidchave, loc_cCpros, loc_cDpros, loc_cMoevs
        LOCAL loc_nPvens, loc_nComiss, loc_dVencis, loc_dVencfs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13, loc_nPcuss
        LOCAL loc_nPrecode, loc_nOrdems
        loc_lSucesso = .F.
        loc_lErroItem = .F.

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        TRY
            *-- Excluir todos os itens existentes para este lprecos
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Inserir todos os itens nao-deletados do cursor
                SELECT cursor_4c_Itens
                GO TOP
                DO WHILE !EOF("cursor_4c_Itens") AND !loc_lErroItem
                    IF !DELETED("cursor_4c_Itens")
                        loc_cCpros   = ALLTRIM(TratarNulo(cpros,  "C"))
                        loc_cDpros   = ALLTRIM(TratarNulo(dpros,  "C"))
                        loc_cMoevs   = ALLTRIM(TratarNulo(moevs,  "C"))
                        loc_nPvens   = TratarNulo(pvens,   "N")
                        loc_nComiss  = TratarNulo(comiss,  "N")
                        loc_dVencis  = TratarNulo(vencis,  "D")
                        loc_dVencfs  = TratarNulo(vencfs,  "D")
                        loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,  "C"))
                        loc_cReffs   = ALLTRIM(TratarNulo(reffs,  "C"))
                        loc_nEan13   = TratarNulo(ean13,   "N")
                        loc_nPcuss   = TratarNulo(pcuss,   "N")
                        loc_nPrecode = TratarNulo(precode, "N")
                        loc_nOrdems  = TratarNulo(ordems, "N")

                        *-- Gerar cidchaves unico se vazio
                        loc_cCidchave = ALLTRIM(TratarNulo(cidchaves, "C"))
                        IF EMPTY(loc_cCidchave)
                            loc_cCidchave = THIS.GerarCidchave()
                        ENDIF

                        IF !EMPTY(loc_cCpros)
                            loc_cSQL = "INSERT INTO SigCdLpi" + ;
                                       " (cidchaves, lprecos, cpros, dpros, moevs," + ;
                                       " pvens, comiss, vencis, vencfs, cgrus," + ;
                                       " reffs, ean13, pcuss, precode, ordems," + ;
                                       " flagutabs, ccontroles)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidchave) + "," + ;
                                       EscaparSQL(par_cLprecos) + "," + ;
                                       EscaparSQL(loc_cCpros) + "," + ;
                                       EscaparSQL(loc_cDpros) + "," + ;
                                       EscaparSQL(loc_cMoevs) + "," + ;
                                       FormatarNumeroSQL(loc_nPvens) + "," + ;
                                       FormatarNumeroSQL(loc_nComiss) + "," + ;
                                       FormatarDataSQL(loc_dVencis) + "," + ;
                                       FormatarDataSQL(loc_dVencfs) + "," + ;
                                       EscaparSQL(loc_cCgrus) + "," + ;
                                       EscaparSQL(loc_cReffs) + "," + ;
                                       FormatarNumeroSQL(loc_nEan13) + "," + ;
                                       FormatarNumeroSQL(loc_nPcuss) + "," + ;
                                       FormatarNumeroSQL(loc_nPrecode) + "," + ;
                                       FormatarNumeroSQL(loc_nOrdems) + "," + ;
                                       "0,'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir item [" + loc_cCpros + "]:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lErroItem = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Itens
                    SKIP
                ENDDO

                IF !loc_lErroItem
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidchave - Gera chave unica para SigCdLpi.cidchaves (char 20)
    * Formato: emps(3) + lprecos(8) + cpros(5) + seq(4)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidchave()
        LOCAL loc_cChave, loc_nSeq, loc_cSQL, loc_nResult
        loc_nSeq = 0

        TRY
            loc_cSQL = "SELECT COUNT(1) AS nTotal FROM SigCdLpi" + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Seq")
                loc_nSeq = TratarNulo(cursor_4c_Seq.nTotal, "N")
            ENDIF
            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar, loc_nSeq = 0
        ENDTRY

        loc_cChave = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                     PADR(LEFT(ALLTRIM(THIS.this_cLprecos), 8), 8) + ;
                     TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS")
        loc_cChave = LEFT(ALLTRIM(loc_cChave) + TRANSFORM(loc_nSeq), 20)

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChecaGrpVenda - Verifica se produto pertence a grupo permitido para venda
    * Consulta SigCdPam.GrPadFors para obter grupo padrao e valida no produto
    * Retorna .T. se pode alterar preco, .F. se grupo bloqueado
    *--------------------------------------------------------------------------
    PROCEDURE ChecaGrpVenda(par_cCpros)
        LOCAL loc_cSQL, loc_nResult, loc_lPode, loc_cGrPadFors, loc_cCgrus
        loc_lPode = .T.

        TRY
            *-- Ler grupo padrao de fornecedores em SigCdPam
            loc_cSQL = "SELECT GrPadFors FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Pam") AND !EMPTY(ALLTRIM(cursor_4c_Pam.GrPadFors))
                loc_cGrPadFors = ALLTRIM(cursor_4c_Pam.GrPadFors)
            ELSE
                loc_cGrPadFors = ""
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF EMPTY(loc_cGrPadFors) OR EMPTY(ALLTRIM(par_cCpros))
                loc_lPode = .T.
            ELSE
                *-- Verificar grupo do produto
                loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResult >= 0 AND !EOF("cursor_4c_Pro")
                    loc_cCgrus = ALLTRIM(cursor_4c_Pro.cgrus)
                    IF loc_cCgrus = loc_cGrPadFors
                        MsgAviso("Produto do grupo " + loc_cGrPadFors + " n" + CHR(227) + "o pode ter pre" + ;
                                 CHR(231) + "o alterado nesta lista!", "Aviso")
                        loc_lPode = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFlags - Marca SigCdLpc.flags=1 (lista atualizada no sistema)
    * e persiste os itens de SigCdLpi via SalvarItens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFlags(par_cLprecos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET flags = 1" + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lFlags = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar flags:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlterarVencimentos - Altera vencfs de todos os itens de uma lista
    * Equivalente ao cmdSalva do cntVencimentos no legado
    *--------------------------------------------------------------------------
    PROCEDURE AlterarVencimentos(par_cLprecos, par_dVencfs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_dVencfs)
            MsgErro("Data de vencimento inv" + CHR(225) + "lida!", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdLpi SET vencfs = " + FormatarDataSQL(par_dVencfs) + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
                MsgInfo("Vencimentos alterados para " + DTOC(par_dVencfs) + "!", "")
            ELSE
                MsgErro("Erro ao alterar vencimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar vencimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
