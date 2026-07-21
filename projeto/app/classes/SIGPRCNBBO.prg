*==============================================================================
* SIGPRCNBBO.prg - Business Object para Geracao de Arquivos CNAB
* Herda de: BusinessBase
* Tabela principal: SigPcOoL
* Chave primaria: cidchaves
*==============================================================================

DEFINE CLASS SIGPRCNBBO AS BusinessBase

    *-- Configuracao da tabela principal
    this_cTabela          = "SigPcOoL"
    this_cCampoChave      = "cidchaves"

    *--------------------------------------------------------------------------
    * Filtros da pagina pgfiltro
    *--------------------------------------------------------------------------
    this_cEmps            = ""    && Empresa selecionada char(3)
    this_cDsEmpresa       = ""    && Razao social da empresa char(40)
    this_dDatIni          = {}    && Data inicial do periodo
    this_dDatFim          = {}    && Data final do periodo
    this_cCdCarConta      = ""    && Codigo da conta bancaria char(10)
    this_cDsCarConta      = ""    && Descricao da conta bancaria char(40)
    this_cTitBan          = ""    && Titulo banco char(12)
    this_lNaoProcessadas  = .T.   && .T.=Nao processadas, .F.=Ja processadas
    this_nPeriodo         = 1     && 1=Vencimento, 2=Emissao
    this_nDiasProt        = 5     && Dias para protesto (spinner spndias)

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigPcOoL (schema confirmado)
    *--------------------------------------------------------------------------
    this_cTipos           = ""    && char(10) - tipo do processo ex: SIGPRCNB
    this_cDopes           = ""    && char(20) - codigo da operacao
    this_nNumes           = 0     && numeric(6,0) - numero do titulo
    this_cEmpDs           = ""    && char(3) - empresa destino
    this_cDopeDs          = ""    && char(20) - titulo/nosso numero (dopeds)
    this_nNumeDs          = 0     && numeric(11,0) - nosso numero sequencial (numeds)
    this_dDatas           = {}    && datetime NULL - data/hora do processamento
    this_cUsuars          = ""    && char(10) - usuario que processou
    this_cProdutos        = ""    && text NULL - conteudo do arquivo CNAB gerado
    this_cCidChaves       = ""    && char(20) PK - chave unica do registro
    this_cEdnDests        = ""    && char(29) - endereco destino
    this_cEmpDopNums      = ""    && char(29) - emps+dopes+numes (chave composta)
    this_cProcessos       = ""    && char(20) - tipo de arquivo ex: CNAB
    this_nNopers          = 0     && numeric(9,0) - numero da operacao

    *--------------------------------------------------------------------------
    * INIT - Configura tabela e chave; delega ao BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPcOoL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN DODEFAULT("SigPcOoL")
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK do registro corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor de dados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cTipos      = NVL(tipos,      "")
                THIS.this_cEmps       = NVL(emps,       "")
                THIS.this_cDopes      = NVL(dopes,      "")
                THIS.this_nNumes      = NVL(numes,      0)
                THIS.this_cEmpDs      = NVL(empds,      "")
                THIS.this_cDopeDs     = NVL(dopeds,     "")
                THIS.this_nNumeDs     = NVL(numeds,     0)
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_cUsuars     = NVL(usuars,     "")
                THIS.this_cProdutos   = NVL(produtos,   "")
                THIS.this_cCidChaves  = NVL(cidchaves,  "")
                THIS.this_cEdnDests   = NVL(edndests,   "")
                THIS.this_cEmpDopNums = NVL(empdopnums, "")
                THIS.this_cProcessos  = NVL(processos,  "")
                THIS.this_nNopers     = NVL(nopers,     0)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cDopes)
            MsgAviso("Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(THIS.this_cEmpDopNums)
            MsgAviso("C" + CHR(243) + "digo do t" + CHR(237) + "tulo obrigat" + CHR(243) + "rio.")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                IF EMPTY(THIS.this_cCidChaves)
                    THIS.this_cCidChaves = fUniqueIds()
                ENDIF
                loc_cSQL = "INSERT INTO SigPcOoL "
                loc_cSQL = loc_cSQL + "(tipos, emps, dopes, numes, empds, dopeds, numeds, datas, usuars, "
                loc_cSQL = loc_cSQL + "produtos, cidchaves, edndests, empdopnums, processos, nopers) "
                loc_cSQL = loc_cSQL + "VALUES ("
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cTipos)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmps)          + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopes)         + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes)  + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDs)         + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDopeDs)        + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumeDs) + ", "
                loc_cSQL = loc_cSQL + "GETDATE(), "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuars)        + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProdutos)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cCidChaves)     + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEdnDests)      + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpDopNums)    + ", "
                loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cProcessos)     + ", "
                loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de processamento na tabela SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigPcOoL SET "
                loc_cSQL = loc_cSQL + "tipos = "      + EscaparSQL(THIS.this_cTipos)          + ", "
                loc_cSQL = loc_cSQL + "emps = "       + EscaparSQL(THIS.this_cEmps)           + ", "
                loc_cSQL = loc_cSQL + "dopes = "      + EscaparSQL(THIS.this_cDopes)          + ", "
                loc_cSQL = loc_cSQL + "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)   + ", "
                loc_cSQL = loc_cSQL + "empds = "      + EscaparSQL(THIS.this_cEmpDs)          + ", "
                loc_cSQL = loc_cSQL + "dopeds = "     + EscaparSQL(THIS.this_cDopeDs)         + ", "
                loc_cSQL = loc_cSQL + "numeds = "     + FormatarNumeroSQL(THIS.this_nNumeDs)  + ", "
                loc_cSQL = loc_cSQL + "datas = GETDATE(), "
                loc_cSQL = loc_cSQL + "usuars = "     + EscaparSQL(THIS.this_cUsuars)         + ", "
                loc_cSQL = loc_cSQL + "produtos = "   + EscaparSQL(THIS.this_cProdutos)       + ", "
                loc_cSQL = loc_cSQL + "edndests = "   + EscaparSQL(THIS.this_cEdnDests)       + ", "
                loc_cSQL = loc_cSQL + "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)     + ", "
                loc_cSQL = loc_cSQL + "processos = "  + EscaparSQL(THIS.this_cProcessos)      + ", "
                loc_cSQL = loc_cSQL + "nopers = "     + FormatarNumeroSQL(THIS.this_nNopers)
                loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigPcOoL (chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPcOoL WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes bancarias para grid de filtro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            loc_cSQL = "SELECT dopes, CAST(0 AS bit) AS marca "
            loc_cSQL = loc_cSQL + "FROM SigCdOpe "
            loc_cSQL = loc_cSQL + "WHERE parcontas = 1 AND valpends = 1 "
            loc_cSQL = loc_cSQL + "ORDER BY dopes"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFormasPagto - Carrega formas de pagamento bancarias (SigOpFp)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFormasPagto()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_FormaPagto")
                USE IN cursor_4c_FormaPagto
            ENDIF
            loc_cSQL = "SELECT fpags, descrs, infos, situas, nbancos "
            loc_cSQL = loc_cSQL + "FROM SigOpFp "
            loc_cSQL = loc_cSQL + "WHERE situas IN ('R','A') AND infos = 'K' "
            loc_cSQL = loc_cSQL + "ORDER BY fpags"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FormaPagto") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulos - Busca titulos a cobrar para geracao do arquivo CNAB
    * par_cOpCodes: codigos de operacao p/ IN clause ex: "'OP1','OP2'"
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulos(par_cOpCodes)
        LOCAL loc_lResultado, loc_cSQL, loc_cPeriodo, loc_cMarca
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Filtro")
                USE IN cursor_4c_Filtro
            ENDIF
            IF THIS.this_nPeriodo = 1
                loc_cPeriodo = "SigMvPar.vencs BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ELSE
                loc_cPeriodo = "SigMvCcr.dtemis BETWEEN " + ;
                    FormatarDataSQL(THIS.this_dDatIni) + " AND " + ;
                    FormatarDataSQL(THIS.this_dDatFim)
            ENDIF
            IF THIS.this_lNaoProcessadas
                loc_cMarca = "NOT EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ELSE
                loc_cMarca = "EXISTS (SELECT 1 FROM SigPcOoL "
                loc_cMarca = loc_cMarca + "WHERE SigPcOoL.empdopnums = SigMvPar.empdopnums "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.nopers = SigMvPar.nopers "
                loc_cMarca = loc_cMarca + "AND SigPcOoL.processos = 'CNAB')"
            ENDIF
            loc_cSQL = "SELECT SigMvPar.empdopnums, SigMvPar.emps, SigMvPar.dopes, "
            loc_cSQL = loc_cSQL + "SigMvPar.numes, SigMvPar.vencs, SigMvPar.valos, "
            loc_cSQL = loc_cSQL + "SigMvPar.fpags, SigMvPar.nopers, "
            loc_cSQL = loc_cSQL + "SigMvCcr.titulos, SigMvCcr.titbans, SigMvCcr.dtemis, SigMvCcr.opers, "
            loc_cSQL = loc_cSQL + "SigMvCab.contads, "
            loc_cSQL = loc_cSQL + "SigCdCli.iclis, SigCdCli.rclis, SigCdCli.razaos, SigCdCli.grupos, "
            loc_cSQL = loc_cSQL + "SigCdCli.endes, SigCdCli.cidas, SigCdCli.estas, SigCdCli.nums, "
            loc_cSQL = loc_cSQL + "SigCdCli.compls, SigCdCli.bairs, SigCdCli.ceps, SigCdCli.cpfs, "
            loc_cSQL = loc_cSQL + "SigCdCli.endcobs, SigCdCli.cepcobs, SigCdCli.estcobs, "
            loc_cSQL = loc_cSQL + "SigCdCli.baicobs, SigCdCli.cidcobs, "
            loc_cSQL = loc_cSQL + "CAST(0 AS bit) AS marca, CAST(0 AS bit) AS EnvErro "
            loc_cSQL = loc_cSQL + "FROM SigMvPar "
            loc_cSQL = loc_cSQL + "INNER JOIN SigOpFp ON SigOpFp.fpags = SigMvPar.fpags "
            loc_cSQL = loc_cSQL + "INNER JOIN SigMvCab ON SigMvCab.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "INNER JOIN SigCdCli ON SigCdCli.iclis = SigMvCab.contads "
            loc_cSQL = loc_cSQL + "LEFT JOIN SigMvCcr ON SigMvCcr.empdopnums = SigMvPar.empdopnums "
            loc_cSQL = loc_cSQL + "AND SigMvCcr.nopers = SigMvPar.nopers "
            loc_cSQL = loc_cSQL + "WHERE SigMvPar.emps = " + EscaparSQL(THIS.this_cEmps)
            loc_cSQL = loc_cSQL + " AND SigMvPar.dopes IN (" + par_cOpCodes + ")"
            loc_cSQL = loc_cSQL + " AND SigOpFp.infos = 'K'"
            loc_cSQL = loc_cSQL + " AND " + loc_cPeriodo
            loc_cSQL = loc_cSQL + " AND " + loc_cMarca
            loc_cSQL = loc_cSQL + " ORDER BY SigMvPar.vencs, SigCdCli.rclis"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Filtro") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresa - Carrega dados da empresa para cabecalho do arquivo CNAB
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresa(par_cEmps)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Empresa")
                USE IN cursor_4c_Empresa
            ENDIF
            loc_cSQL = "SELECT cemps, razsocs, cgcs, tel1s, ceps, endes, "
            loc_cSQL = loc_cSQL + "numeros, bairs, cidas, estas, compls "
            loc_cSQL = loc_cSQL + "FROM SigCdEmp "
            loc_cSQL = loc_cSQL + "WHERE cemps = " + EscaparSQL(par_cEmps)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresa") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientePorConta - Retorna dados do cliente pela conta (iclis)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarClientePorConta(par_cConta)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_ClienteConta")
                USE IN cursor_4c_ClienteConta
            ENDIF
            loc_cSQL = "SELECT iclis, grupos, rclis "
            loc_cSQL = loc_cSQL + "FROM SigCdCli "
            loc_cSQL = loc_cSQL + "WHERE iclis = " + EscaparSQL(par_cConta)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClienteConta") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConvenio - Carrega convenio bancario da conta selecionada no filtro
    * par_cGrupo: SigCdCli.grupos do cliente
    * par_cConta: codigo da conta bancaria selecionada
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConvenio(par_cGrupo, par_cConta)
        LOCAL loc_lResultado, loc_cSQL, loc_cGruContas
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Convenio")
                USE IN cursor_4c_Convenio
            ENDIF
            loc_cGruContas = par_cGrupo + par_cConta
            loc_cSQL = "SELECT agencias, bancos, nagencias, nbancos, digiagen, "
            loc_cSQL = loc_cSQL + "contas, convenios, grucontas, diasprots, instrus, "
            loc_cSQL = loc_cSQL + "moras, bcoimprime, tpctarqs, tpctbols, arqcnabs "
            loc_cSQL = loc_cSQL + "FROM SIGCDCEB "
            loc_cSQL = loc_cSQL + "WHERE grucontas = " + EscaparSQL(loc_cGruContas)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Convenio") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTituloBanco - Retorna titulo e nosso numero do titulo no banco
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTituloBanco(par_cEmpDopNums, par_nNopers)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_TitBan")
                USE IN cursor_4c_TitBan
            ENDIF
            loc_cSQL = "SELECT titulos, titbans "
            loc_cSQL = loc_cSQL + "FROM SigMvCcr "
            loc_cSQL = loc_cSQL + "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TitBan") > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTituloBanco - Grava nosso numero do titulo no banco (titbans)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTituloBanco(par_cEmpDopNums, par_nNopers, par_cTitBan)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigMvCcr SET titbans = " + EscaparSQL(par_cTitBan)
            loc_cSQL = loc_cSQL + " WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)
            loc_cSQL = loc_cSQL + " AND nopers = " + FormatarNumeroSQL(par_nNopers)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirRegistroCNAB - Insere registro de processamento CNAB em SigPcOoL
    *--------------------------------------------------------------------------
    PROCEDURE InserirRegistroCNAB
        LPARAMETERS par_cEmpDopNums, par_cEmps, par_cDopes, par_nNumes, ;
                    par_cUsuars, par_cCidChaves, par_cDopeDs, par_nNumeDs, ;
                    par_cProcessos, par_cProdutos
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO SigPcOoL "
            loc_cSQL = loc_cSQL + "(empdopnums, emps, dopes, numes, usuars, tipos, "
            loc_cSQL = loc_cSQL + "processos, produtos, datas, cidchaves, dopeds, numeds) "
            loc_cSQL = loc_cSQL + "VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmpDopNums)         + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cEmps)               + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopes)              + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumes)       + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cUsuars)             + ", "
            loc_cSQL = loc_cSQL + "'SIGPRCNB', "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProcessos)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cProdutos)           + ", "
            loc_cSQL = loc_cSQL + "GETDATE(), "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cCidChaves)          + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(par_cDopeDs)             + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(par_nNumeDs)      + ")"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CommitAlteracoes - Confirma transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CommitAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLCOMMIT(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RollbackAlteracoes - Desfaz transacao no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE RollbackAlteracoes()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF SQLROLLBACK(gnConnHandle) > 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
