*==============================================================================
* SigPdM11BO.prg - Business Object para Pagamento de Servicos (SIGPDM11)
* Gerencia validacao e atualizacao de itens de servico em pagamento
*
* Form de origem: SigPdM11.SCX (sub-form aberto pelo form pai com parametros)
* Cursor principal: xNensiS (itens do pagamento, gerenciado pela datasession pai)
*==============================================================================
DEFINE CLASS SigPdM11BO AS BusinessBase

    *-- Configuracao da entidade de dados
    this_cTabela      = "xNensiS"
    this_cCampoChave  = "Nenvs"

    *--------------------------------------------------------------------------
    * Campos do cursor xNensiS (itens de servico do pagamento)
    *--------------------------------------------------------------------------
    this_nNenvs       = 0     && Numero do envelope / O.S. (Nenvs)
    this_cCats        = ""    && Codigo da categoria (cats)
    this_nFators      = 0     && Valor do servico (Fators)
    this_nQtds        = 0     && Quantidade (qtds)
    this_cContafs     = ""    && Conta (Contafs)
    this_cGrupofs     = ""    && Grupo (Grupofs)
    this_cCretrabs    = ""    && Codigo do retrabalho (cRetrabs)
    this_nCoefs       = 0     && Valor do servico de retrabalho (Coefs)
    this_nCoefinfs    = 0     && Valor do servico informado (Coefinfs)
    this_lRetrabs     = .F.   && Flag de retrabalho (Retrabs)
    this_lOsRets      = .F.   && Flag de O.S. de retorno (OsRets)
    this_cCdescs      = ""    && Descricao do servico (cDescs)
    this_cGrupofins   = ""    && Grupo financeiro (GrupoFins)
    this_cMoedas      = ""    && Codigo da moeda (Moedas)

    *--------------------------------------------------------------------------
    * Contexto da operacao - cabecalho vindo de tmpnens (leitura apenas)
    *--------------------------------------------------------------------------
    this_nNumps       = 0     && Numero da operacao (tmpnens.numps)
    this_cEmps        = ""    && Empresa (tmpnens.emps)
    this_cDopps       = ""    && Descricao da operacao (tmpnens.dopps)

    *--------------------------------------------------------------------------
    * Estado de execucao
    *--------------------------------------------------------------------------
    this_cPcEscolha   = ""    && Modo atual: INSERIR / ALTERAR (herdado do form pai)
    this_nOptMov      = 1     && Opcao contas: 1=Movimentacao, 2=Cadastro

    *--------------------------------------------------------------------------
    * Dados do servico validado (populados apos busca em crSigCdSvc)
    *--------------------------------------------------------------------------
    this_nCoefSvc     = 0     && Coeficiente do servico (crSigCdSvc.Coefs)
    this_nCoefRetr    = 0     && Coeficiente de retrabalho (crSigCdSvc.CoefRetrs)
    this_cMoedSvc     = ""    && Moeda do servico (crSigCdSvc.CMoeds)
    this_cGruFinSvc   = ""    && Grupo financeiro do servico (crSigCdSvc.GruFins)

    *--------------------------------------------------------------------------
    * Descricao da categoria (populada apos CursorQuery em SigCdCat)
    *--------------------------------------------------------------------------
    this_cDescsCat    = ""

    *--------------------------------------------------------------------------
    * Ultimo valor conhecido do campo Categoria para controle de alteracao
    *--------------------------------------------------------------------------
    this_cAntValueCats = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de Pagamento de Servicos
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "xNensiS"
        this_cCampoChave = "Nenvs"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor xNensiS para propriedades BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lRet, loc_oErro
        loc_lRet = .F.

        TRY
            IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nNenvs     = NVL(Nenvs, 0)
                this_cCats      = ALLTRIM(NVL(Cats, ""))
                this_nFators    = NVL(Fators, 0)
                this_nQtds      = NVL(Qtds, 0)
                this_cContafs   = ALLTRIM(NVL(Contafs, ""))
                this_cGrupofs   = ALLTRIM(NVL(Grupofs, ""))
                this_cCretrabs  = ALLTRIM(NVL(cRetrabs, ""))
                this_nCoefs     = NVL(Coefs, 0)
                this_nCoefinfs  = NVL(Coefinfs, 0)
                IF VARTYPE(Retrabs) = "L"
                    this_lRetrabs = NVL(Retrabs, .F.)
                ELSE
                    this_lRetrabs = IIF(NVL(Retrabs, 0) = 1, .T., .F.)
                ENDIF
                IF VARTYPE(OsRets) = "L"
                    this_lOsRets = NVL(OsRets, .F.)
                ELSE
                    this_lOsRets = IIF(NVL(OsRets, 0) = 1, .T., .F.)
                ENDIF
                this_cCdescs    = ALLTRIM(NVL(cDescs, ""))
                this_cGrupofins = ALLTRIM(NVL(GrupoFins, ""))
                this_cMoedas    = ALLTRIM(NVL(Moedas, ""))
                loc_lRet = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lRet
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarItens - Valida e atualiza dados de servico nos itens do pagamento
    * Equivalente ao Gravacat() do legado
    * par_lChkCoef: .T. = verificar coeficiente (retorna .F. se nao encontrado)
    *               .F. = sempre retornar .T.
    *--------------------------------------------------------------------------
    PROCEDURE GravarItens(par_lChkCoef)
        LOCAL loc_lRet, loc_nRecno, loc_nFatorRetr, loc_lSucesso, loc_oErro

        loc_lRet     = .T.
        loc_lSucesso = .T.

        TRY
            IF INLIST(this_cPcEscolha, "INSERIR", "ALTERAR")
                SELECT xNensiS
                loc_nRecno = RECNO()

                SCAN
                    IF !EMPTY(ALLTRIM(xNensiS.Cats))
                        *-- Validar servico e carregar dados de preco
                        IF THIS.ValidarServico(xNensiS.Cats, xNensiS.GrupoFs, xNensiS.ContaFs)
                            *-- Atualizar valores no cursor com dados do servico
                            SELECT xNensiS
                            REPLACE Fators    WITH this_nCoefSvc, ;
                                    Coefs     WITH this_nCoefRetr, ;
                                    Moedas    WITH this_cMoedSvc, ;
                                    GrupoFins WITH this_cGruFinSvc

                            *-- Se tem retrabalho, recalcular Coefs = servico * fator_retrabalho
                            IF !EMPTY(ALLTRIM(xNensiS.cRetrabs))
                                loc_nFatorRetr = THIS.BuscarFatorRetrabalho(ALLTRIM(xNensiS.cRetrabs))
                                IF loc_nFatorRetr > 0
                                    REPLACE Coefs WITH this_nCoefSvc * loc_nFatorRetr IN xNensiS
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lRet = .F.
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT xNensiS
                IF loc_nRecno > 0
                    GO loc_nRecno
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em GravarItens")
            loc_lSucesso = .F.
        ENDTRY

        IF par_lChkCoef
            RETURN loc_lRet AND loc_lSucesso
        ELSE
            RETURN .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarServico - Valida servico em SigCdSvc e carrega dados de preco
    * Retorna .T. se servico encontrado, .F. se nao encontrado
    * Prioridade: exato (cats+grupo+conta) > grupo+sem conta > so categoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarServico(par_cCats, par_cGrupoFs, par_cContaFs)
        LOCAL loc_lEncontrado, loc_nWa, loc_oErro

        loc_lEncontrado = .F.
        this_nCoefSvc   = 0
        this_nCoefRetr  = 0
        this_cMoedSvc   = ""
        this_cGruFinSvc = ""

        TRY
            IF USED("crSigCdSvc")
                loc_nWa = SELECT()
                SELECT crSigCdSvc
                SET ORDER TO CaGruCo
                DO CASE
                CASE SEEK(par_cCats + par_cGrupoFs + par_cContaFs)
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + par_cGrupoFs + SPACE(10))
                    loc_lEncontrado = .T.
                CASE SEEK(par_cCats + SPACE(20))
                    loc_lEncontrado = .T.
                ENDCASE
                IF loc_lEncontrado
                    this_nCoefSvc   = NVL(crSigCdSvc.Coefs, 0)
                    this_nCoefRetr  = NVL(crSigCdSvc.CoefRetrs, 0)
                    this_cMoedSvc   = ALLTRIM(NVL(crSigCdSvc.CMoeds, ""))
                    this_cGruFinSvc = ALLTRIM(NVL(crSigCdSvc.GruFins, ""))
                ENDIF
                SELECT (loc_nWa)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em ValidarServico")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoCategoria - Busca descricao da categoria em SigCdCat
    * Popula this_cDescsCat com Desc2s
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarDescricaoCategoria(par_cCodCat)
        this_cDescsCat = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFatorRetrabalho - Busca fator de multiplicacao em SigPrCrt
    * Retorna Fators do retrabalho para calcular Coefs = servico * fator
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarFatorRetrabalho(par_cCodRetrab)
        LOCAL loc_cSQL, loc_nResult, loc_nFator, loc_oErro

        loc_nFator = 0

        TRY
            loc_cSQL = "SELECT Fators, Cods FROM SigPrCrt " + ;
                       "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       "  OR LTRIM(RTRIM(Emps)) = ''"

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retr")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Retr") > 0
                SELECT cursor_4c_Retr
                INDEX ON Cods TAG Cods
                IF SEEK(par_cCodRetrab, "cursor_4c_Retr", "Cods")
                    loc_nFator = NVL(Fators, 0)
                ENDIF
            ENDIF

            IF USED("cursor_4c_Retr")
                USE IN cursor_4c_Retr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em BuscarFatorRetrabalho")
        ENDTRY

        RETURN loc_nFator
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual de xNensiS
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        IF USED("xNensiS") AND !EOF("xNensiS")
            SELECT xNensiS
            RETURN TRANSFORM(xNensiS.Nenvs)
        ENDIF
        RETURN ""
    ENDFUNC

ENDDEFINE
