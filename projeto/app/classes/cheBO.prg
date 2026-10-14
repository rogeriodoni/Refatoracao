DEFINE CLASS cheBO AS BusinessBase

    *-- SigCqLcm - cabecalho do lote
    this_nNumLote  = 0
    this_cOperL    = ""
    this_dData     = {}
    this_dDtMovs   = {}
    this_cOpera    = ""
    this_cLimCart  = ""

    *-- Moeda / conversao
    this_cMoeda    = ""
    this_nCotacao  = 0
    this_nValConv  = 0

    *-- Totais (Valtots, Valtjuros, calc TLiq)
    this_nValor    = 0
    this_nTJuros   = 0
    this_nTLiq     = 0

    *-- Taxas
    this_nTaxaDia  = 0
    this_nTaxaIof  = 0
    this_nTaxaMes  = 0

    *-- Grupo / Conta Destino
    this_cGrupoDs  = ""
    this_cDGrupoDs = ""
    this_cContaDs  = ""
    this_cDContaDs = ""

    *-- Grupo / Conta Origem
    this_cGrupoOs  = ""
    this_cDGrupoOs = ""
    this_cContaOs  = ""
    this_cDContaOs = ""

    *-- Grupo / Conta Terceiro
    this_cGrupoT   = ""
    this_cDGrupoT  = ""

    *-- Grupo / Conta Juros
    this_cGruJuro  = ""
    this_cDGruJuro = ""
    this_cConJuro  = ""
    this_cDJuro    = ""

    *-- Chave interna (GUID - cidchaves)
    this_cCidChave  = ""

    *-- Parametros da carteira (SigCdPam, tabela SINGLE-ROW)
    this_cGruCart   = ""
    this_cConCart   = ""
    this_cMoedaCheq = ""

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCqLcm"
        THIS.this_cCampoChave = "NumLotes"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_nNumLote
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de lotes da carteira de cheques
    * par_cFiltro: WHERE adicional (ex: "AND datas BETWEEN '...' AND '...'")
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numlotes"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega lote pelo numlotes
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_nNumLote)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.datas, a.dtmovs, a.codigos," + ;
                " a.operas, a.tipos, a.moeds, a.cotas, a.valtots," + ;
                " a.valtjuros, a.valconvs, a.grupoos, a.contaos," + ;
                " a.grupods, a.contads, a.grupocx, a.contacx," + ;
                " a.grujuros, a.conjuros, a.taxcarts, a.taxdias, a.taxiofs," + ;
                " a.emps, a.usuarios, a.datatrans, a.cidchaves" + ;
                " FROM SigCqLcm a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLote)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLote   = TratarNulo(numlotes,  "N")
            THIS.this_cCidChave  = TratarNulo(cidchaves, "C")
            THIS.this_dData      = TratarNulo(datas,     "D")
            THIS.this_dDtMovs    = TratarNulo(dtmovs,    "D")
            THIS.this_cOperL     = TratarNulo(codigos,   "C")
            THIS.this_cOpera     = TratarNulo(operas,    "C")
            THIS.this_cLimCart   = TratarNulo(tipos,     "C")
            THIS.this_cMoeda     = TratarNulo(moeds,     "C")
            THIS.this_nCotacao   = TratarNulo(cotas,     "N")
            THIS.this_nValConv   = TratarNulo(valconvs,  "N")
            THIS.this_nValor     = TratarNulo(valtots,   "N")
            THIS.this_nTJuros    = TratarNulo(valtjuros, "N")
            THIS.this_nTLiq      = THIS.this_nValor - THIS.this_nTJuros
            THIS.this_nTaxaDia   = TratarNulo(taxdias,   "N")
            THIS.this_nTaxaIof   = TratarNulo(taxiofs,   "N")
            THIS.this_nTaxaMes   = TratarNulo(taxcarts,  "N")
            THIS.this_cGrupoDs   = TratarNulo(grupods,   "C")
            THIS.this_cContaDs   = TratarNulo(contads,   "C")
            THIS.this_cGrupoOs   = TratarNulo(grupoos,   "C")
            THIS.this_cContaOs   = TratarNulo(contaos,   "C")
            THIS.this_cGrupoT    = TratarNulo(grupocx,   "C")
            THIS.this_cGruJuro   = TratarNulo(grujuros,  "C")
            THIS.this_cConJuro   = TratarNulo(conjuros,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProximoLote - Retorna proximo numlotes disponivel
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigCqLcm" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo, loc_cCidChave
        loc_lSucesso = .F.

        TRY
            loc_nProximo  = THIS.ObterProximoLote()
            loc_cCidChave = LEFT(go_4c_Sistema.cCodEmpresa + ;
                PADL(TRANSFORM(loc_nProximo), 17, "0"), 20)

            THIS.this_nNumLote  = loc_nProximo
            THIS.this_cCidChave = loc_cCidChave

            loc_cSQL = "INSERT INTO SigCqLcm (" + ;
                " numlotes, cidchaves, datas, dtmovs, codigos, operas, tipos," + ;
                " moeds, cotas, valtots, valtjuros, valconvs," + ;
                " grupoos, contaos, grupods, contads, grupocx, contacx," + ;
                " grujuros, conjuros, taxcarts, taxdias, taxiofs," + ;
                " emps, usuarios, dtsis, autos, locals, ntrans," + ;
                " nalineas, empdopnums, custodia)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLote) + "," + ;
                EscaparSQL(THIS.this_cCidChave) + "," + ;
                FormatarDataSQL(THIS.this_dData) + "," + ;
                FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                "''," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                "GETDATE()," + ;
                "0,'',0,0,'','')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Os cheques da grade tambem fazem parte do registro
                IF THIS.GravarCheques()
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCqLcm
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqLcm SET" + ;
                " datas = "     + FormatarDataSQL(THIS.this_dData) + "," + ;
                " dtmovs = "    + FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                " operas = "    + EscaparSQL(ALLTRIM(THIS.this_cOpera)) + "," + ;
                " tipos = "     + EscaparSQL(ALLTRIM(THIS.this_cLimCart)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotacao) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValor) + "," + ;
                " valtjuros = " + FormatarNumeroSQL(THIS.this_nTJuros) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConv) + "," + ;
                " grupoos = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                " contaos = "   + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                " grupods = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                " contads = "   + EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                " grupocx = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoT)) + "," + ;
                " grujuros = "  + EscaparSQL(ALLTRIM(THIS.this_cGruJuro)) + "," + ;
                " conjuros = "  + EscaparSQL(ALLTRIM(THIS.this_cConJuro)) + "," + ;
                " taxcarts = "  + FormatarNumeroSQL(THIS.this_nTaxaMes) + "," + ;
                " taxdias = "   + FormatarNumeroSQL(THIS.this_nTaxaDia) + "," + ;
                " taxiofs = "   + FormatarNumeroSQL(THIS.this_nTaxaIof) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLote)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF THIS.GravarCheques()
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametrosCarteira - Grucarts/Concarts/MoedaCheqs de SigCdPam.
    *   SigCdPam eh SINGLE-ROW: nunca filtrar por emps (nao tem a coluna).
    *   Guarda o resultado nas properties para o SCAN nao reconsultar por linha.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarParametrosCarteira()
        LOCAL loc_nRet, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_PamCart")
            USE IN cursor_4c_PamCart
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 Grucarts, Concarts, MoedaCheqs FROM SigCdPam", ;
            "cursor_4c_PamCart")

        IF loc_nRet > 0 AND USED("cursor_4c_PamCart") AND RECCOUNT("cursor_4c_PamCart") > 0
            SELECT cursor_4c_PamCart
            GO TOP
            THIS.this_cGruCart   = ALLTRIM(cursor_4c_PamCart.Grucarts)
            THIS.this_cConCart   = ALLTRIM(cursor_4c_PamCart.Concarts)
            THIS.this_cMoedaCheq = ALLTRIM(cursor_4c_PamCart.MoedaCheqs)
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_PamCart")
            USE IN cursor_4c_PamCart
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNumCheque - numero interno (nums) de um cheque JA cadastrado em
    *   SigChe, procurado pela chave fisica bancos+agencias+ncontas+ncheques.
    *   Devolve "" quando o cheque ainda nao existe - quem chama decide entre
    *   UPDATE (achou) e INSERT com nums novo (nao achou). nums eh a PK de
    *   SigChe, entao reinserir com um nums existente violaria a chave.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterNumCheque(par_cBanco, par_cAgencia, par_cConta, par_cCheque)
        LOCAL loc_nRet, loc_cNum
        loc_cNum = ""

        IF USED("cursor_4c_CheExiste")
            USE IN cursor_4c_CheExiste
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT TOP 1 nums FROM SigChe" + ;
            " WHERE bancos = "   + EscaparSQL(par_cBanco) + ;
            " AND agencias = "   + EscaparSQL(par_cAgencia) + ;
            " AND ncontas = "    + EscaparSQL(par_cConta) + ;
            " AND ncheques = "   + EscaparSQL(par_cCheque), ;
            "cursor_4c_CheExiste")

        IF loc_nRet > 0 AND USED("cursor_4c_CheExiste") AND RECCOUNT("cursor_4c_CheExiste") > 0
            SELECT cursor_4c_CheExiste
            GO TOP
            loc_cNum = ALLTRIM(cursor_4c_CheExiste.nums)
        ENDIF

        IF USED("cursor_4c_CheExiste")
            USE IN cursor_4c_CheExiste
        ENDIF

        RETURN loc_cNum
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarCheques - Persiste as linhas de TempChq do form.
    *   Transcrito do PROCEDURE inserir do SCX legado (blocos crSigChe e
    *   crInsSigCcChm). Chamado por Inserir() e por Atualizar().
    *
    *   Antes NADA disto existia: Inserir/Atualizar gravavam SO o cabecalho
    *   SigCqLcm e os cheques digitados na grade eram descartados - por isso
    *   ao reabrir o lote em Alterar a grade voltava vazia (Erro207).
    *
    *   SigCcChm eh regravada por lote (DELETE + INSERT), o mesmo ciclo de vida
    *   que ExecutarExclusao ja usava, logo eh idempotente no Alterar.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarCheques()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL, loc_cNum, loc_nNumOs, loc_cCidChave
        LOCAL loc_nRecAtual, loc_cTipo, loc_cMoedaChq, loc_nCotaChq, loc_nJuros, loc_lCheNovo
        loc_lSucesso = .T.

        TRY
            IF !USED("TempChq")
                THIS.this_cMensagemErro = "Cursor TempChq indispon" + CHR(237) + "vel."
                loc_lSucesso = .F.
            ENDIF

            IF loc_lSucesso
                THIS.CarregarParametrosCarteira()

                *-- tipos: 'DB' na saida, 'CR' na entrada (legado crSigCqChm)
                loc_cTipo = IIF(ALLTRIM(THIS.this_cOpera) == "S", "DB", "CR")

                *-- Os ITENS do lote sao regravados do zero (idempotente no
                *-- Alterar). SigChe NAO entra aqui: eh o cadastro permanente do
                *-- cheque, chaveado por nums, e recebe UPDATE ou INSERT abaixo.
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCcChm WHERE numlotes = " + ;
                    FormatarNumeroSQL(THIS.this_nNumLote))

                IF loc_nRet < 0
                    MsgErro("Erro ao limpar itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                SELECT TempChq
                loc_nRecAtual = RECNO("TempChq")
                GO TOP

                SCAN
                    *-- Linha em branco da grade nao vira registro
                    IF EMPTY(ALLTRIM(TempChq.Bancos)) AND EMPTY(ALLTRIM(TempChq.Agencias)) ;
                            AND EMPTY(ALLTRIM(TempChq.NContas)) AND EMPTY(ALLTRIM(TempChq.NCheques))
                        LOOP
                    ENDIF

                    loc_cNum      = THIS.ObterNumCheque(ALLTRIM(TempChq.Bancos), ;
                                        ALLTRIM(TempChq.Agencias), ALLTRIM(TempChq.NContas), ;
                                        ALLTRIM(TempChq.NCheques))
                    loc_lCheNovo  = EMPTY(loc_cNum)
                    IF loc_lCheNovo
                        loc_cNum = TRANSFORM(fGerUniqueKey("busnum"), "@L 99999999")
                    ENDIF
                    loc_nNumOs    = fGerUniqueKey("SigMvCcr")
                    loc_cCidChave = fUniqueIds()
                    loc_nJuros    = TempChq.ValJuros

                    *-- Legado: na ENTRADA a moeda/cotacao do cheque prevalece;
                    *-- na SAIDA usa a do lote quando o cheque nao traz moeda.
                    loc_cMoedaChq = IIF(ALLTRIM(THIS.this_cOpera) == "E", ALLTRIM(TempChq.moeds), ;
                        IIF(EMPTY(ALLTRIM(TempChq.moeds)) OR ALLTRIM(TempChq.moeds) == "R", ;
                            ALLTRIM(THIS.this_cMoeda), ALLTRIM(TempChq.moeds)))
                    loc_nCotaChq  = IIF(ALLTRIM(THIS.this_cOpera) == "E", TempChq.cotas, THIS.this_nCotacao)

                    IF EMPTY(loc_cMoedaChq)
                        loc_cMoedaChq = ALLTRIM(THIS.this_cMoedaCheq)
                    ENDIF
                    IF loc_nCotaChq = 0
                        loc_nCotaChq = 1
                    ENDIF

                    *-- Registro do cheque (SigChe). Cheque ja cadastrado eh
                    *-- ATUALIZADO (nums eh a PK); so o inedito vira INSERT.
                    *-- No INSERT, toda coluna NOT NULL sem property recebe
                    *-- vazio/zero e datetime sem valor usa a sentinela
                    *-- '19000101' (regra #22).
                    IF !loc_lCheNovo
                        loc_cSQL = "UPDATE SigChe SET" + ;
                            " datas = "    + FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                            " vencs = "    + FormatarDataSQL(TempChq.Vencs) + "," + ;
                            " grupos = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                            " contas = "   + EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                            " grclis = "   + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                            " iclis = "    + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                            " gruorigs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                            " conorigs = " + EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                            " grupot = "   + EscaparSQL(ALLTRIM(TempChq.grupoT)) + "," + ;
                            " contat = "   + EscaparSQL(ALLTRIM(TempChq.contaT)) + "," + ;
                            " grucarts = " + EscaparSQL(THIS.this_cGruCart) + "," + ;
                            " concarts = " + EscaparSQL(THIS.this_cConCart) + "," + ;
                            " numos = "    + FormatarNumeroSQL(loc_nNumOs) + "," + ;
                            " umovs = "    + EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                            " valors = "   + FormatarNumeroSQL(TempChq.Valors, 2) + "," + ;
                            " moeds = "    + EscaparSQL(loc_cMoedaChq) + "," + ;
                            " cotas = "    + FormatarNumeroSQL(loc_nCotaChq, 4) + "," + ;
                            " dtalts = GETDATE()" + ;
                            " WHERE nums = " + EscaparSQL(loc_cNum)

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            MsgErro("Erro ao atualizar cheque " + ALLTRIM(TempChq.NCheques) + ":" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    IF loc_lCheNovo
                        loc_cSQL = "INSERT INTO SigChe (" + ;
                        " bancos, agencias, ncontas, ncheques, datas, vencs, emps," + ;
                        " grupos, contas, grclis, iclis, gruorigs, conorigs," + ;
                        " grupot, contat, grucarts, concarts, numos, nums, umovs," + ;
                        " valors, valpags, moeds, cotas, dtalts, dtemis," + ;
                        " autos, conres, grures, copchs, fpags, grvends, vends," + ;
                        " leituras, locals, nalineas, notas, ntrans, numeros," + ;
                        " numolds, protocolos, tipoblq, custodia)" + ;
                        " VALUES (" + ;
                        EscaparSQL(ALLTRIM(TempChq.Bancos)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.Agencias)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.NContas)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.NCheques)) + "," + ;
                        FormatarDataSQL(THIS.this_dDtMovs) + "," + ;
                        FormatarDataSQL(TempChq.Vencs) + "," + ;
                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.grupoT)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.contaT)) + "," + ;
                        EscaparSQL(THIS.this_cGruCart) + "," + ;
                        EscaparSQL(THIS.this_cConCart) + "," + ;
                        FormatarNumeroSQL(loc_nNumOs) + "," + ;
                        EscaparSQL(loc_cNum) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cOperL)) + "," + ;
                        FormatarNumeroSQL(TempChq.Valors, 2) + "," + ;
                        FormatarNumeroSQL(0, 2) + "," + ;
                        EscaparSQL(loc_cMoedaChq) + "," + ;
                        FormatarNumeroSQL(loc_nCotaChq, 4) + "," + ;
                        "GETDATE(),'19000101'," + ;
                        "0,'','','','','',''," + ;
                        EscaparSQL(ALLTRIM(TempChq.leituras)) + ",'',0,'',0,''," + ;
                        "''," + EscaparSQL(ALLTRIM(TempChq.Protocolos)) + ",0,'')"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nRet < 0
                            MsgErro("Erro ao gravar cheque " + ALLTRIM(TempChq.NCheques) + ":" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    *-- Item da carteira (SigCcChm) - eh o que a grade do form le
                    loc_cSQL = "INSERT INTO SigCcChm (" + ;
                        " numlotes, cidchaves, nums, numos, tipos, usuarios, dtsis," + ;
                        " datas, datatrans, vencs, emps, moeds, cotas," + ;
                        " valtots, valconvs, valors, valjuros," + ;
                        " bancos, agencias, ncontas, ncheques, obss," + ;
                        " grupos, contas, grclis, iclis, grupot, contat," + ;
                        " grucarts, concarts, autos, locals, notas, ntrans," + ;
                        " protocolos, empdopnums)" + ;
                        " VALUES (" + ;
                        FormatarNumeroSQL(THIS.this_nNumLote) + "," + ;
                        EscaparSQL(loc_cCidChave) + "," + ;
                        EscaparSQL(loc_cNum) + "," + ;
                        FormatarNumeroSQL(loc_nNumOs) + "," + ;
                        EscaparSQL(loc_cTipo) + "," + ;
                        EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                        "GETDATE()," + ;
                        FormatarDataSQL(THIS.this_dData) + ",'19000101'," + ;
                        FormatarDataSQL(TempChq.Vencs) + "," + ;
                        EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cMoeda)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nCotacao, 4) + "," + ;
                        FormatarNumeroSQL(THIS.this_nValor, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nValConv, 2) + "," + ;
                        FormatarNumeroSQL(TempChq.Valors, 2) + "," + ;
                        FormatarNumeroSQL(loc_nJuros, 2) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.Bancos)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.Agencias)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.NContas)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.NCheques)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.Obss)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoDs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaDs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cGrupoOs)) + "," + ;
                        EscaparSQL(ALLTRIM(THIS.this_cContaOs)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.grupoT)) + "," + ;
                        EscaparSQL(ALLTRIM(TempChq.contaT)) + "," + ;
                        EscaparSQL(THIS.this_cGruCart) + "," + ;
                        EscaparSQL(THIS.this_cConCart) + "," + ;
                        "0,'','',0," + ;
                        EscaparSQL(ALLTRIM(TempChq.Protocolos)) + ",'')"

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nRet < 0
                        MsgErro("Erro ao gravar item do lote " + ALLTRIM(TempChq.NCheques) + ":" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_nRecAtual > 0 AND loc_nRecAtual <= RECCOUNT("TempChq")
                    GO loc_nRecAtual IN TempChq
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.GravarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCcChm (cheques) e SigCqLcm (lote)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            *-- So os ITENS do lote. SigChe eh o cadastro permanente do cheque
            *-- (PK nums) e pode ser referenciado por outros lotes - o legado
            *-- tambem nao apaga essa tabela ao excluir o lote.
            loc_cSQL = "DELETE FROM SigCcChm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigCqLcm WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLote)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em cheBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
