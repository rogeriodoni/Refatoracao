*==============================================================================
* SIGPRCHRBO.PRG
* Business Object para Processamento de Cheques (SIGPRCHR)
* Tipo: OPERACIONAL - sem CRUD padrao de tabela unica
*==============================================================================

DEFINE CLASS SigPrChrBO AS BusinessBase

    *-- Identificacao (OPERACIONAL: sem tabela/chave primaria propria)
    this_cTabela      = ""
    this_cCampoChave  = ""

    *--------------------------------------------------------------------------
    * FILTROS ATIVOS (valores correntes dos campos de filtro do form)
    *--------------------------------------------------------------------------
    this_dDtInicial   = {}
    this_dDtFinal     = {}
    this_cCdGrupo     = ""
    this_cDsGrupo     = ""
    this_cCdConta     = ""
    this_cDsConta     = ""

    *--------------------------------------------------------------------------
    * RASTREAMENTO DE ALTERACOES (valores anteriores para detectar mudancas)
    * Equivalentes a AntDtIni, AntDtFin, AntCdGrupo, etc. do legado
    *--------------------------------------------------------------------------
    this_dAntDtIni    = {}
    this_dAntDtFin    = {}
    this_cAntCdGrupo  = ""
    this_cAntDsGrupo  = ""
    this_cAntCdConta  = ""
    this_cAntDsConta  = ""

    *--------------------------------------------------------------------------
    * PERMISSOES DE ACESSO (carregadas via fChecaAcesso no Init)
    *--------------------------------------------------------------------------
    this_lExcluirDocumento = .F.
    this_lExcluirCheque    = .F.

    *--------------------------------------------------------------------------
    * FLAGS DE ESTADO DA APLICACAO
    *--------------------------------------------------------------------------
    this_lInicial     = .T.   && .T. na primeira carga; .F. apos MontaChq
    this_lPlInicio    = .F.   && Controla exibicao do painel cntProcurar
    this_lPlLeCheque  = .F.   && Leitura de codigo de barras em andamento
    this_cPcChqLido   = ""    && Acumula caracteres lidos pelo leitor de codigo
    this_lPlLeitor    = .F.   && Indica que o valor veio do leitor (nao teclado)
    this_lChMatIni    = .F.   && Controla exibicao do painel impchmat

    *--------------------------------------------------------------------------
    * DADOS DA LINHA ATUAL DO GRID (cheque selecionado)
    * Usados em operacoes sobre o registro corrente do cursor csSigCqChi
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && Empresa (c3)
    this_cDopes       = ""    && Tipo de operacao (c20)
    this_cNumes       = ""    && Numero da operacao (c6)
    this_dDatas       = {}    && Data de emissao
    this_cBancos      = ""    && Codigo do banco (c3)
    this_cAgencias    = ""    && Agencia (c4)
    this_cNcontas     = ""    && Numero da conta corrente (c10)
    this_cNcheques    = ""    && Numero do cheque (c6)
    this_cContas      = ""    && IClis / conta do favorecido (c10)
    this_nValors      = 0     && Valor do cheque
    this_cFavos       = ""    && Nome do favorecido (c40)
    this_nNcopias     = 0     && Numero da copia
    this_nNemitidos   = 0     && 1 = emitido, 0 = nao emitido
    this_nNcancelas   = 0     && 1 = cancelado, 0 = ativo
    this_nNmarca1s    = 0     && 1 = marcado para impressao
    this_cCidchaves   = ""    && Chave unica do cheque (para DELETE)
    this_cEmpDopNums  = ""    && emps + dopes + STR(numes, 6) (c29)
    this_cJustCanc    = ""    && Justificativa do cancelamento
    this_cVersos      = ""    && Verso do cheque (text)
    this_cGrupos      = ""    && Grupo contabil (c10)
    this_nNemissoes   = 0     && Quantidade de emissoes
    this_dVencs       = {}    && Data de vencimento
    this_nImpVersos   = 0     && 1 = imprimir verso
    this_lEmitidos    = .F.   && emitidos BIT (para INSERT/UPDATE)
    this_lCancelas    = .F.   && cancelas BIT (para INSERT/UPDATE)
    this_cSituacao    = ""    && Descricao calculada: Emitido/Cancelado/etc.

    *--------------------------------------------------------------------------
    * PAINEL IMPRESSAO MATRICIAL (impchmat)
    * Campos preenchidos pelo usuario no painel de impressao matricial
    *--------------------------------------------------------------------------
    this_cBancoMat    = ""    && Banco selecionado para impressao matricial
    this_cChIniMat    = ""    && Cheque inicial (padLeft 0, 6 digitos)
    this_cChFinMat    = ""    && Cheque final   (padLeft 0, 6 digitos)

    *--------------------------------------------------------------------------
    * PAINEL PROCURAR (cntProcurar)
    * Campos preenchidos pelo usuario para localizar cheque especifico
    *--------------------------------------------------------------------------
    this_cBancoPrc    = ""    && Banco (c3)
    this_cAgenciaPrc  = ""    && Agencia (c4)
    this_cContaPrc    = ""    && Conta corrente (c10)
    this_cChequePrc   = ""    && Numero do cheque (c6)
    this_dEmissaoPrc  = {}    && Data de emissao para busca
    this_nValorPrc    = 0     && Valor para busca

    *--------------------------------------------------------------------------
    * INIT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()

        loc_lResultado = DODEFAULT()

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do cheque atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do CsSigCqChi para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmps       = NVL(emps,       "")
                THIS.this_cDopes      = NVL(dopes,      "")
                THIS.this_cNumes      = NVL(STR(numes, 6), "")
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_cBancos     = NVL(bancos,     "")
                THIS.this_cAgencias   = NVL(agencias,   "")
                THIS.this_cNcontas    = NVL(ncontas,    "")
                THIS.this_cNcheques   = NVL(ncheques,   "")
                THIS.this_cContas     = NVL(contas,     "")
                THIS.this_nValors     = NVL(valors,     0)
                THIS.this_cFavos      = NVL(favos,      "")
                THIS.this_nNcopias    = NVL(ncopias,    0)
                THIS.this_nNemitidos  = NVL(nemitidos,  0)
                THIS.this_nNcancelas  = NVL(ncancelas,  0)
                THIS.this_nNmarca1s   = NVL(nmarca1s,   0)
                THIS.this_cCidchaves  = NVL(cidchaves,  "")
                THIS.this_cJustCanc   = NVL(justcanc,   "")

                IF TYPE(par_cAliasCursor + ".grupos") != "U"
                    THIS.this_cGrupos = NVL(grupos, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".nemissoes") != "U"
                    THIS.this_nNemissoes = NVL(nemissoes, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".vencs") != "U"
                    THIS.this_dVencs = NVL(vencs, {})
                ENDIF
                IF TYPE(par_cAliasCursor + ".versos") != "U"
                    THIS.this_cVersos = NVL(versos, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".impversos") != "U"
                    THIS.this_nImpVersos = NVL(impversos, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".empdopnums") != "U"
                    THIS.this_cEmpDopNums = NVL(empdopnums, "")
                ELSE
                    THIS.this_cEmpDopNums = THIS.this_cEmps + THIS.this_cDopes + PADL(ALLTRIM(THIS.this_cNumes), 6, "0")
                ENDIF

                IF TYPE(par_cAliasCursor + ".emitidos") != "U"
                    IF VARTYPE(EVALUATE(par_cAliasCursor + ".emitidos")) = "L"
                        THIS.this_lEmitidos = NVL(EVALUATE(par_cAliasCursor + ".emitidos"), .F.)
                    ELSE
                        THIS.this_lEmitidos = (NVL(EVALUATE(par_cAliasCursor + ".emitidos"), 0) = 1)
                    ENDIF
                ELSE
                    THIS.this_lEmitidos = (THIS.this_nNemitidos = 1)
                ENDIF

                IF TYPE(par_cAliasCursor + ".cancelas") != "U"
                    IF VARTYPE(EVALUATE(par_cAliasCursor + ".cancelas")) = "L"
                        THIS.this_lCancelas = NVL(EVALUATE(par_cAliasCursor + ".cancelas"), .F.)
                    ELSE
                        THIS.this_lCancelas = (NVL(EVALUATE(par_cAliasCursor + ".cancelas"), 0) = 1)
                    ENDIF
                ELSE
                    THIS.this_lCancelas = (THIS.this_nNcancelas = 1)
                ENDIF

                THIS.this_cSituacao = IIF(THIS.this_nNcancelas = 1, ;
                    "Cancelado", ;
                    IIF(THIS.this_nNemitidos > 0, ;
                        "Emitido", ;
                        "N" + CHR(227) + "o Emitido"))

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override para operacoes de exclusao de cheque
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cDescricao

        TRY
            loc_cDescricao = ALLTRIM(THIS.this_cBancos) + "/" + ;
                             ALLTRIM(THIS.this_cAgencias) + "/" + ;
                             ALLTRIM(THIS.this_cNcontas) + "/" + ;
                             ALLTRIM(THIS.this_cNcheques)

            DODEFAULT(par_cOperacao)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida propriedades antes de INSERT/UPDATE em SigCqChi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lResultado

        loc_lResultado = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o informada."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cDopes))
            THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o informada."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cBancos))
            THIS.this_cMensagemErro = "Banco n" + CHR(227) + "o informado."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cAgencias))
            THIS.this_cMensagemErro = "Ag" + CHR(234) + "ncia n" + CHR(227) + "o informada."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cNcontas))
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da conta n" + CHR(227) + "o informado."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cNcheques))
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do cheque n" + CHR(227) + "o informado."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cContas))
            THIS.this_cMensagemErro = "Conta do favorecido n" + CHR(227) + "o informada."
            loc_lResultado = .F.
        ENDIF

        IF loc_lResultado AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cMensagemErro = "Chave " + CHR(250) + "nica do cheque n" + CHR(227) + "o informada."
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCqChi com todos os campos NOT NULL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cEmpDopNums
        LOCAL loc_cCancelas, loc_cEmitidos

        loc_lResultado = .F.
        loc_cCancelas  = IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0")
        loc_cEmitidos  = IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0")

        TRY
            loc_cEmpDopNums = IIF(EMPTY(ALLTRIM(THIS.this_cEmpDopNums)), ;
                ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + PADL(ALLTRIM(THIS.this_cNumes), 6, "0"), ;
                ALLTRIM(THIS.this_cEmpDopNums))

            loc_cSQL = "INSERT INTO SigCqChi ( " + ;
                       "agencias, bancos, cancelas, contas, datas, dopes, " + ;
                       "emitidos, emps, favos, grupos, ncheques, ncontas, " + ;
                       "ncopias, nemissoes, numes, valors, vencs, " + ;
                       "cidchaves, empdopnums, justcanc, impversos " + ;
                       ") VALUES ( "

            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cAgencias)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cBancos)) + ", "
            loc_cSQL = loc_cSQL + loc_cCancelas + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cContas)) + ", "
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", "

            loc_cSQL = loc_cSQL + loc_cEmitidos + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cFavos)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cNcheques)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cNcontas)) + ", "

            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNcopias) + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNemissoes) + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(VAL(THIS.this_cNumes)) + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors) + ", "
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ", "

            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cCidchaves)) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(loc_cEmpDopNums) + ", "
            loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(THIS.this_cJustCanc)) + ", "
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpVersos) + " )"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                THIS.this_cMensagemErro = "Falha ao inserir cheque na base de dados."
                loc_lResultado = .F.
            ENDIF

            SQLCOMMIT(gnConnHandle)

            THIS.RegistrarAuditoria("INSERT")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir cheque: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCqChi baseado em cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cCancelas, loc_cEmitidos

        loc_lResultado = .F.
        loc_cCancelas  = IIF(THIS.this_lCancelas OR THIS.this_nNcancelas = 1, "1", "0")
        loc_cEmitidos  = IIF(THIS.this_lEmitidos OR THIS.this_nNemitidos = 1, "1", "0")

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cMensagemErro = "Chave " + CHR(250) + "nica do cheque n" + CHR(227) + "o informada."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "agencias = "  + EscaparSQL(ALLTRIM(THIS.this_cAgencias)) + ", " + ;
                       "bancos = "    + EscaparSQL(ALLTRIM(THIS.this_cBancos))   + ", " + ;
                       "cancelas = "  + loc_cCancelas + ", " + ;
                       "contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas))   + ", " + ;
                       "datas = "     + FormatarDataSQL(THIS.this_dDatas)        + ", " + ;
                       "dopes = "     + EscaparSQL(ALLTRIM(THIS.this_cDopes))    + ", " + ;
                       "emitidos = "  + loc_cEmitidos + ", " + ;
                       "emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps))     + ", " + ;
                       "favos = "     + EscaparSQL(ALLTRIM(THIS.this_cFavos))    + ", " + ;
                       "grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos))   + ", " + ;
                       "ncheques = "  + EscaparSQL(ALLTRIM(THIS.this_cNcheques)) + ", " + ;
                       "ncontas = "   + EscaparSQL(ALLTRIM(THIS.this_cNcontas))  + ", " + ;
                       "ncopias = "   + FormatarNumeroSQL(THIS.this_nNcopias)    + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(THIS.this_nNemissoes)  + ", " + ;
                       "numes = "     + FormatarNumeroSQL(VAL(THIS.this_cNumes)) + ", " + ;
                       "valors = "    + FormatarNumeroSQL(THIS.this_nValors)     + ", " + ;
                       "vencs = "     + FormatarDataSQL(THIS.this_dVencs)        + ", " + ;
                       "justcanc = "  + EscaparSQL(ALLTRIM(THIS.this_cJustCanc)) + ", " + ;
                       "impversos = " + FormatarNumeroSQL(THIS.this_nImpVersos)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                THIS.this_cMensagemErro = "Falha ao atualizar cheque na base de dados."
                loc_lResultado = .F.
            ENDIF

            SQLCOMMIT(gnConnHandle)

            THIS.RegistrarAuditoria("UPDATE")

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar cheque: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCqChi baseado em cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cMensagemErro = "Chave " + CHR(250) + "nica do cheque n" + CHR(227) + "o informada."
                loc_lResultado = .F.
            ENDIF

            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                THIS.this_cMensagemErro = "Falha ao excluir cheque da base de dados."
                loc_lResultado = .F.
            ENDIF

            SQLCOMMIT(gnConnHandle)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir cheque: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorChave - Localiza cheque por cidchaves e carrega propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorChave(par_cCidChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCidChave))
                THIS.this_cMensagemErro = "Chave do cheque n" + CHR(227) + "o informada."
                loc_lResultado = .F.
            ENDIF

            IF USED("cursor_4c_ChequeTmp")
                USE IN cursor_4c_ChequeTmp
            ENDIF

            loc_cSQL = "SELECT agencias, bancos, cancelas, contas, datas, dopes, " + ;
                       "emitidos, emps, favos, grupos, ncheques, ncontas, " + ;
                       "ncopias, nemissoes, numes, valors, vencs, " + ;
                       "cidchaves, empdopnums, justcanc, impversos " + ;
                       "FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChequeTmp")
            IF loc_nRet < 1
                THIS.this_cMensagemErro = "Falha ao buscar cheque."
                loc_lResultado = .F.
            ENDIF

            IF !EOF("cursor_4c_ChequeTmp")
                SELECT cursor_4c_ChequeTmp
                THIS.CarregarDoCursor("cursor_4c_ChequeTmp")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cheque n" + CHR(227) + "o encontrado."
            ENDIF

            IF USED("cursor_4c_ChequeTmp")
                USE IN cursor_4c_ChequeTmp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cheque: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCursoresIniciais - Carrega CrSigCdmp, CrContas e esqueleto CsSigCqChi
    * Equivalente ao bloco de Init do form original
    *--------------------------------------------------------------------------
    FUNCTION CarregarCursoresIniciais()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            IF USED("CrSigCdmp")
                USE IN CrSigCdmp
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdmp"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdmp")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar configura" + CHR(231) + CHR(245) + "es de impress" + CHR(227) + "o.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT CrSigCdmp
            INDEX ON impres TAG impres
            GO TOP

            IF USED("CrContas")
                USE IN CrContas
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.IClis, b.RClis " + ;
                       "FROM SigOpFp a, SigCdCli b " + ;
                       "WHERE a.EmiChqs = 1 AND b.IClis = a.ContaDs " + ;
                       "ORDER BY IClis"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CrContas")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar contas.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT CrContas
            INDEX ON IClis TAG IClis
            INDEX ON RClis TAG RClis
            GO TOP

            IF USED("CsSigCqChi")
                USE IN CsSigCqChi
            ENDIF

            loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                       "a.agencias, a.ncontas, a.ncheques, a.contas, " + ;
                       "a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, " + ;
                       "a.cancelas, a.cidchaves, a.JustCanc, " + ;
                       "0 AS NEmitidos, 0 AS NCancelas, 0 AS NMarca1s " + ;
                       "FROM SigCqChi a WHERE 0 = 1"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "CsSigCqChi")
            IF loc_nRet < 1
                MsgErro("Falha ao inicializar cursor de cheques.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT CsSigCqChi
            INDEX ON ncopias                                              TAG NCopias
            INDEX ON NEmitidos                                            TAG NEmitidos
            INDEX ON NCancelas                                            TAG NCancelas
            INDEX ON NMarca1s                                             TAG NMarca1s
            INDEX ON ncheques                                             TAG NCheques
            INDEX ON datas                                                TAG Datas
            INDEX ON ncontas + ncheques                                   TAG Conta
            INDEX ON contas + STR(ncopias)                                TAG Contas
            INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques TAG Emissao
            INDEX ON STR(valors,12,2) + bancos + agencias + ncontas + ncheques TAG Valor
            INDEX ON bancos + agencias + ncontas + ncheques               TAG Cheque
            INDEX ON agencias + ncontas + ncheques                        TAG Agencia

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCheques - Carrega CsSigCqChi com cheques do periodo/conta/grupo
    * Equivalente a MontaChq do legado
    *--------------------------------------------------------------------------
    FUNCTION MontarCheques(par_lPosiciona)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        LOCAL loc_cDtInicial, loc_cDtFinal, loc_cCdGrupo, loc_cCdConta
        LOCAL loc_cBusca

        loc_lResultado = .F.
        par_lPosiciona = IIF(VARTYPE(par_lPosiciona) = "L", par_lPosiciona, .F.)

        TRY
            IF par_lPosiciona AND USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                SELECT CsSigCqChi
                loc_cBusca = bancos + agencias + ncontas + ncheques
            ELSE
                loc_cBusca = ""
            ENDIF

            loc_cDtInicial = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFinal   = FormatarDataSQL(THIS.this_dDtFinal)
            loc_cCdGrupo   = ALLTRIM(THIS.this_cCdGrupo)
            loc_cCdConta   = ALLTRIM(THIS.this_cCdConta)

            IF USED("CsSigCqChi")
                USE IN CsSigCqChi
            ENDIF

            IF EMPTY(loc_cCdConta)
                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, " + ;
                           "a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, " + ;
                           "a.cancelas, a.cidchaves, a.JustCanc " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal
                loc_cSQL = loc_cSQL + " AND a.Contas IN " + ;
                           "(SELECT DISTINCT ContaDs FROM SigOpFp WHERE EmiChqs = 1) " + ;
                           "ORDER BY a.emps, a.dopes, a.numes, a.datas, " + ;
                           "a.bancos, a.agencias, a.ncontas, a.ncheques, " + ;
                           "a.contas, a.valors, a.favos, a.ncopias, " + ;
                           "a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
            ELSE
                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, " + ;
                           "a.valors, a.favos, a.ncopias, a.emitidos, a.nemissoes, " + ;
                           "a.cancelas, a.cidchaves, a.JustCanc " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + loc_cDtInicial + " AND " + loc_cDtFinal
                loc_cSQL = loc_cSQL + " AND a.Contas = " + EscaparSQL(loc_cCdConta) + ;
                           " ORDER BY a.emps, a.dopes, a.numes, a.datas, " + ;
                           "a.bancos, a.agencias, a.ncontas, a.ncheques, " + ;
                           "a.contas, a.valors, a.favos, a.ncopias, " + ;
                           "a.emitidos, a.nemissoes, a.cancelas, a.cidchaves"
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpChi")
            IF loc_nRet < 1
                MsgErro("Falha ao selecionar cheques.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SET NULL ON
            SELECT Emps, Dopes, Numes, Datas, Bancos, Agencias, NContas, NCheques, ;
                   Contas, Valors, Favos, NCopias, NEmissoes, CIdChaves, JustCanc, ;
                   IIF(Emitidos, 1, 0) AS NEmitidos, ;
                   IIF(Cancelas, 1, 0) AS NCancelas, ;
                   0 AS NMarca1s ;
              FROM cursor_4c_TmpChi ;
             ORDER BY Bancos, Agencias, NContas, NCheques ;
              INTO CURSOR CsSigCqChi READWRITE
            SET NULL OFF

            IF USED("cursor_4c_TmpChi")
                USE IN cursor_4c_TmpChi
            ENDIF

            SELECT CsSigCqChi
            INDEX ON ncopias                                              TAG NCopias
            INDEX ON NEmitidos                                            TAG NEmitidos
            INDEX ON NCancelas                                            TAG NCancelas
            INDEX ON NMarca1s                                             TAG NMarca1s
            INDEX ON ncheques                                             TAG NCheques
            INDEX ON datas                                                TAG Datas
            INDEX ON ncontas + ncheques                                   TAG Conta
            INDEX ON contas + STR(ncopias)                                TAG Contas
            INDEX ON DTOS(datas) + bancos + agencias + ncontas + ncheques TAG Emissao
            INDEX ON STR(valors,12,2) + bancos + agencias + ncontas + ncheques TAG Valor
            INDEX ON bancos + agencias + ncontas + ncheques               TAG Cheque
            INDEX ON agencias + ncontas + ncheques                        TAG Agencia

            SET ORDER TO NCopias

            IF par_lPosiciona AND !EMPTY(loc_cBusca)
                IF !SEEK(loc_cBusca, "CsSigCqChi", "Cheque")
                    GO TOP IN CsSigCqChi
                ENDIF
            ELSE
                GO TOP IN CsSigCqChi
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExibirCheques - Reseta marcas e ajusta ordem do CsSigCqChi
    * Equivalente a mExibeCheques do legado
    *--------------------------------------------------------------------------
    PROCEDURE ExibirCheques(par_lSeek)
        TRY
            par_lSeek = IIF(VARTYPE(par_lSeek) = "L", par_lSeek, .F.)

            IF USED("CsSigCqChi")
                UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdConta))
                SELECT CsSigCqChi
                SET ORDER TO NCopias
                IF par_lSeek
                    SEEK CHR(255) IN CsSigCqChi ORDER NCopias ASCENDING
                ENDIF
            ELSE
                SELECT CsSigCqChi
                SET ORDER TO Contas
                SET KEY TO ALLTRIM(THIS.this_cCdConta)
                IF par_lSeek
                    SEEK ALLTRIM(THIS.this_cCdConta) + CHR(255) IN CsSigCqChi ORDER Contas ASCENDING
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarCheque - Alterna nMarca1s para cheque identificado pela chave
    * par_cChave = bancos + agencias + ncontas + ncheques
    *--------------------------------------------------------------------------
    PROCEDURE MarcarCheque(par_cChave)
        LOCAL loc_nRecno

        TRY
            IF USED("CsSigCqChi")
                loc_nRecno = RECNO("CsSigCqChi")
                UPDATE CsSigCqChi SET NMarca1s = IIF(NMarca1s = 1, 0, 1) ;
                    WHERE bancos + agencias + ncontas + ncheques = par_cChave ;
                    AND NEmitidos = 0 AND NCancelas = 0
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os cheques nao emitidos e nao cancelados
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_nRecno

        TRY
            IF USED("CsSigCqChi")
                loc_nRecno = RECNO("CsSigCqChi")
                UPDATE CsSigCqChi SET NMarca1s = 1 ;
                    WHERE NMarca1s = 0 AND NEmitidos = 0 AND NCancelas = 0
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Remove marcacao de todos os cheques marcados
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_nRecno

        TRY
            IF USED("CsSigCqChi")
                loc_nRecno = RECNO("CsSigCqChi")
                UPDATE CsSigCqChi SET NMarca1s = 0 WHERE NMarca1s = 1
                IF BETWEEN(loc_nRecno, 1, RECCOUNT("CsSigCqChi"))
                    GOTO loc_nRecno IN CsSigCqChi
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCdConta - Valida codigo de conta e retorna descricao
    * Equivalente a fAcessoContas('C', ...) do legado
    * Retorna: descricao (vazia = nao encontrado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCdConta(par_cCodigo)
        LOCAL loc_cDescricao

        loc_cDescricao = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo)) AND USED("CrContas")
                IF SEEK(ALLTRIM(par_cCodigo), "CrContas", "IClis")
                    loc_cDescricao = ALLTRIM(CrContas.RClis)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDsConta - Valida descricao de conta e retorna codigo
    * Equivalente a fAcessoContas('D', ...) do legado
    * Retorna: codigo (vazio = nao encontrado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDsConta(par_cDescricao)
        LOCAL loc_cCodigo

        loc_cCodigo = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cDescricao)) AND USED("CrContas")
                IF SEEK(ALLTRIM(par_cDescricao), "CrContas", "RClis")
                    loc_cCodigo = ALLTRIM(CrContas.IClis)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCdGrupo - Valida codigo de grupo contabil e retorna descricao
    * Equivalente a fAcessoContab('C', ...) do legado
    * Retorna: descricao (vazia = nao encontrado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCdGrupo(par_cCodigo)
        LOCAL loc_cDescricao, loc_cSQL, loc_nRet

        loc_cDescricao = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr " + ;
                           "WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmp")
                IF loc_nRet > 0 AND !EOF("cursor_4c_GrupoTmp")
                    SELECT cursor_4c_GrupoTmp
                    loc_cDescricao = ALLTRIM(descrs)
                ENDIF
                IF USED("cursor_4c_GrupoTmp")
                    USE IN cursor_4c_GrupoTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDsGrupo - Valida descricao de grupo e retorna codigo
    * Equivalente a fAcessoContab('D', ...) do legado
    * Retorna: codigo (vazio = nao encontrado)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDsGrupo(par_cDescricao)
        LOCAL loc_cCodigo, loc_cSQL, loc_nRet

        loc_cCodigo = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cDescricao))
                loc_cSQL = "SELECT TOP 1 codigos FROM SigCdGcr " + ;
                           "WHERE descrs = " + EscaparSQL(ALLTRIM(par_cDescricao))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmp")
                IF loc_nRet > 0 AND !EOF("cursor_4c_GrupoTmp")
                    SELECT cursor_4c_GrupoTmp
                    loc_cCodigo = ALLTRIM(codigos)
                ENDIF
                IF USED("cursor_4c_GrupoTmp")
                    USE IN cursor_4c_GrupoTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConta - Carrega TmpConta com dados da conta do cheque atual
    * Equivalente a carregaConta do legado - necessario para Documento/Recibo
    *--------------------------------------------------------------------------
    FUNCTION CarregarConta()
        LOCAL loc_lResultado, loc_cChave, loc_cSQL, loc_nRet
        LOCAL loc_cCursor

        loc_lResultado = .F.

        TRY
            IF !USED("CsSigCqChi") OR EOF("CsSigCqChi")
                loc_lResultado = .F.
            ENDIF

            SELECT CsSigCqChi
            loc_cChave = CsSigCqChi.emps + CsSigCqChi.dopes + STR(CsSigCqChi.numes, 6)

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpConta ;
                (grupos C(10) NULL, contas C(10) NULL, flag L NULL, ;
                 valos N(12,2) NULL, acerto N(12,2) NULL, moedas C(3) NULL, ;
                 datas D NULL, vencs D NULL, hists C(50) NULL, nomes C(50) NULL, ;
                 emps C(3) NULL, nopers N(9,0) NULL, dopes C(20) NULL, ;
                 numes N(6,0) NULL, tipos C(1) NULL, fpags C(12) NULL, ;
                 opers C(1) NULL, baixa N(12,2) NULL, baixaaut N(12,2) NULL, ;
                 cotacaos N(12,4) NULL, grupocs C(10) NULL, contacs C(10) NULL, ;
                 cotorigs N(12,4) NULL, moedacs C(3) NULL, cotacaocs N(12,4) NULL, ;
                 valocs N(12,2) NULL, empos C(3) NULL, OrdCopChs N(3,0) NULL)
            SET NULL OFF

            IF USED("TmpPrIt")
                USE IN TmpPrIt
            ENDIF

            loc_cSQL = "SELECT emps, dopes, numes, empos, grupos, contas, tipos, nopers, opers, " + ;
                       "acertos, cotacaos, valos, moedas, hists, vencs, datas " + ;
                       "FROM SigCdPit " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cChave) + ;
                       " ORDER BY emps, dopes, numes, grupos, contas, nopers"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPrIt")
            IF loc_nRet < 1
                MsgErro("Falha ao carregar itens da conta.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SELECT TmpPrIt
            GO TOP

            SCAN
                LOCAL loc_cGrupos, loc_cContas, loc_cTipos, loc_nNopers
                LOCAL loc_cOpers, loc_nAcertos, loc_nCotacaos, loc_nValos
                LOCAL loc_cMoedas, loc_cHists, loc_dVencs, loc_dDatas
                LOCAL loc_cEmpos, loc_lFlag, loc_cNomes, loc_nAcerto

                SELECT TmpPrIt
                loc_cGrupos  = NVL(grupos,  "")
                loc_cContas  = NVL(contas,  "")
                loc_cTipos   = NVL(tipos,   "")
                loc_nNopers  = NVL(nopers,  0)
                loc_cOpers   = NVL(opers,   "")
                loc_nAcertos = NVL(acertos, 0)
                loc_nCotacaos = NVL(cotacaos, 0)
                loc_nValos   = NVL(valos,   0)
                loc_cMoedas  = NVL(moedas,  "")
                loc_cHists   = NVL(hists,   "")
                loc_dVencs   = NVL(vencs,   {})
                loc_dDatas   = NVL(datas,   {})
                loc_cEmpos   = NVL(empos,   "")
                loc_lFlag    = .F.
                loc_cNomes   = ""
                loc_nAcerto  = loc_nAcertos

                IF USED("CrContas") AND SEEK(loc_cContas, "CrContas", "IClis")
                    loc_cNomes = ALLTRIM(CrContas.RClis)
                ENDIF

                DO CASE
                    CASE loc_cTipos = "M"
                        IF loc_nAcertos <> 0
                            loc_lFlag = .T.
                        ENDIF

                    CASE loc_cTipos = "C"
                        loc_lFlag = .T.
                        IF USED("TmpMccr")
                            USE IN TmpMccr
                        ENDIF
                        loc_cSQL = "SELECT emps, nopers, grupos, contas, valors, valpags FROM SigMvCcr " + ;
                                   "WHERE emps = " + EscaparSQL(loc_cEmpos) + ;
                                   " AND nopers = " + FormatarNumeroSQL(loc_nNopers)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "TmpMccr")
                        IF loc_nRet < 1
                            MsgErro("Falha ao carregar movimentos de conta corrente.", "Erro")
                            loc_lResultado = .F.
                        ENDIF
                        SELECT TmpMccr
                        GO TOP
                        IF loc_cGrupos <> ALLTRIM(NVL(TmpMccr.grupos,"")) OR ;
                           loc_cContas <> ALLTRIM(NVL(TmpMccr.contas,""))
                            SELECT TmpMccr
                            SKIP
                        ENDIF
                        loc_nValos = NVL(TmpMccr.valors,0) - NVL(TmpMccr.valpags,0) + loc_nAcertos

                    CASE loc_cTipos = "P"
                        loc_lFlag = .T.
                        IF USED("TmpPar")
                            USE IN TmpPar
                        ENDIF
                        loc_cSQL = "SELECT emps, nopers, moefpgs, fpags, vpags FROM SigMvPar " + ;
                                   "WHERE emps = " + EscaparSQL(loc_cEmpos) + ;
                                   " AND nopers = " + FormatarNumeroSQL(loc_nNopers)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "TmpPar")
                        IF loc_nRet < 1
                            MsgErro("Falha ao carregar movimentos de parcelas.", "Erro")
                            loc_lResultado = .F.
                        ENDIF
                        SELECT TmpPar
                        GO TOP
                        loc_nValos  = loc_nValos - NVL(TmpPar.vpags, 0) + loc_nAcertos
                        loc_cMoedas = NVL(TmpPar.moefpgs, "")
                        loc_cHists  = ALLTRIM(NVL(TmpPar.fpags,"")) + " " + ;
                                      loc_cEmpos + ALLTRIM(TmpPrIt.dopes) + " " + ;
                                      ALLTRIM(STR(TmpPrIt.numes, 9))
                ENDCASE

                SELECT TmpConta
                INSERT INTO TmpConta ;
                    (grupos, contas, flag, valos, acerto, moedas, datas, vencs, ;
                     hists, nomes, emps, nopers, dopes, numes, tipos, fpags, ;
                     opers, baixa, baixaaut, cotacaos, grupocs, contacs, ;
                     cotorigs, moedacs, cotacaocs, valocs, empos, OrdCopChs) ;
                    VALUES ;
                    (loc_cGrupos, loc_cContas, loc_lFlag, loc_nValos, loc_nAcerto, ;
                     loc_cMoedas, loc_dDatas, loc_dVencs, loc_cHists, loc_cNomes, ;
                     TmpPrIt.emps, TmpPrIt.nopers, TmpPrIt.dopes, TmpPrIt.numes, ;
                     loc_cTipos, "", loc_cOpers, 0, 0, loc_nCotacaos, ;
                     "", "", 0, "", 0, 0, loc_cEmpos, 0)
            ENDSCAN

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirChequeCancelado - Exclui cheque cancelado do SQL Server
    * par_cCidChave = cidchaves do cheque a excluir
    * par_cDescricao = texto descritivo para log de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ExcluirChequeCancelado(par_cCidChave, par_cDescricao)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCidChave))
                MsgAviso("Chave do cheque n" + CHR(227) + "o informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nRet < 1
                MsgErro("Falha ao excluir cheque.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SQLCOMMIT(gnConnHandle)

            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                SELECT CsSigCqChi
                DELETE
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarEmitido - Marca cheque como emitido por cidchaves
    *--------------------------------------------------------------------------
    FUNCTION AtualizarEmitido(par_cCidChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChave))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar emissao do cheque.", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("CsSigCqChi") AND !EOF("CsSigCqChi")
                SELECT CsSigCqChi
                REPLACE NEmitidos WITH 1
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarEmitidoPorBancoNcheque - Marca cheque emitido por banco+ncheque
    * Usado na impressao matricial (cmdchmat)
    *--------------------------------------------------------------------------
    FUNCTION AtualizarEmitidoPorBancoNcheque(par_cBancos, par_cNcheques)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 " + ;
                       "WHERE bancos = " + EscaparSQL(ALLTRIM(par_cBancos)) + ;
                       " AND ncheques = " + EscaparSQL(ALLTRIM(par_cNcheques))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar emissao do cheque.", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("CsSigCqChi")
                UPDATE CsSigCqChi SET NEmitidos = 1 ;
                    WHERE bancos = par_cBancos AND ncheques = par_cNcheques
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarChequeMatricial - Carrega CrCheque para impressao matricial
    * par_cBanco = codigo do banco (3 char)
    * par_cChIni = cheque inicial (6 char, padded com zeros)
    * par_cChFin = cheque final (6 char, padded com zeros)
    *--------------------------------------------------------------------------
    FUNCTION BuscarChequeMatricial(par_cBanco, par_cChIni, par_cChFin)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet

        loc_lResultado = .F.

        TRY
            IF USED("CrCheque")
                USE IN CrCheque
            ENDIF

            loc_cSQL = "SELECT bancos, valors, ncheques, datas, emitidos AS nemitidos, " + ;
                       "cancelas AS ncancelas, favos FROM SigCqChi " + ;
                       "WHERE bancos = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
                       " AND ncheques >= " + EscaparSQL(ALLTRIM(par_cChIni)) + ;
                       " AND ncheques <= " + EscaparSQL(ALLTRIM(par_cChFin)) + ;
                       " ORDER BY bancos, ncheques"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrChequeTmp")
            IF loc_nRet < 1
                MsgErro("Falha ao buscar cheques para impress" + CHR(227) + "o.", "Erro")
                loc_lResultado = .F.
            ENDIF

            SET NULL ON
            SELECT bancos, valors, ncheques, datas, nemitidos, ncancelas, favos ;
              FROM cursor_4c_CrChequeTmp ;
             ORDER BY bancos, ncheques ;
              INTO CURSOR CrCheque READWRITE
            SET NULL OFF

            IF USED("cursor_4c_CrChequeTmp")
                USE IN cursor_4c_CrChequeTmp
            ENDIF

            SELECT CrCheque
            GO TOP

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CommitTransacao - Confirma transacao SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CommitTransacao()
        TRY
            SQLCOMMIT(gnConnHandle)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LiberarCursores - Libera todos os cursores temporarios ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursores()
        TRY
            IF USED("CsSigCqChi")
                USE IN CsSigCqChi
            ENDIF
            IF USED("CrContas")
                USE IN CrContas
            ENDIF
            IF USED("CrSigCdmp")
                USE IN CrSigCdmp
            ENDIF
            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
            IF USED("TmpPrIt")
                USE IN TmpPrIt
            ENDIF
            IF USED("TmpMccr")
                USE IN TmpMccr
            ENDIF
            IF USED("TmpPar")
                USE IN TmpPar
            ENDIF
            IF USED("CrCheque")
                USE IN CrCheque
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE
