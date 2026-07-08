*==============================================================================
* pgrBO.prg - Business Object de Lancamentos e Pagamentos (SigCdPgr)
* Herda de BusinessBase
* Tabela: SigCdPgr
* Fase 2/8: BO - Propriedades e Metodos CRUD
* Fase 5/8: Propriedades adicionais (datarcs, mascnum, obs, datalims)
*==============================================================================

DEFINE CLASS pgrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdPgr
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (Emps + Dopes + Str(Numes,6))
    this_cEmpdopnums = ""      && empdopnums char(29)

    *-- Conta e grupo
    this_cContas    = ""       && contas char(10)
    this_cGrupos    = ""       && grupos char(10)

    *-- Datas
    this_dDatas     = {}       && datas datetime (legado: datas)
    this_dDataRcs   = {}       && datarcs datetime - data do lancamento
    this_dDataLims  = {}       && datalims datetime - data limite

    *-- Identificacao
    this_cEmps      = ""       && emps char(3)
    this_cDopes     = ""       && dopes char(20)
    this_nNumes     = 0        && numes numeric(6,0)
    this_cMascNum   = ""       && mascnum char(6) - numero mascarado
    this_cUsuars    = ""       && usuars char(10)

    *-- Identificacao da operacao
    this_cNopers   = ""        && nopers char(7)
    this_cOpers    = ""        && opers char(1)

    *-- Forma de pagamento e moeda
    this_cFpags    = ""        && fpags char(12)
    this_cMoedas   = ""        && moedas char(3)

    *-- Observacao
    this_cObs      = ""        && obs text

    *-- Flags
    this_lAutos    = .F.       && autos bit
    this_lConcs    = .F.       && concs bit
    this_nCnotas   = 0         && cnotas numeric(1,0)

    *-- Chave do lancamento
    this_cCidchaves = ""       && cidchaves char(20)

    *==========================================================================
    * Init - Inicializa propriedades do BusinessBase
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPgr"
        THIS.this_cCampoChave = "empdopnums"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpdopnums)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega dados do cursor para as propriedades
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cEmpdopnums = empdopnums
        THIS.this_cContas     = contas
        THIS.this_cGrupos     = grupos
        THIS.this_cEmps       = emps
        THIS.this_cDopes      = dopes
        THIS.this_nNumes      = numes
        THIS.this_cMascNum    = mascnum
        THIS.this_cUsuars     = usuars
        THIS.this_dDatas      = datas
        THIS.this_dDataRcs    = datarcs
        THIS.this_dDataLims   = datalims
        THIS.this_cNopers     = nopers
        THIS.this_cOpers      = opers
        THIS.this_cFpags      = fpags
        THIS.this_cMoedas     = moedas
        THIS.this_cObs        = NVL(obs, "")
        IF VARTYPE(autos) = "L"
            THIS.this_lAutos = autos
        ELSE
            IF VARTYPE(autos) = "L"
                THIS.this_lAutos = autos
            ELSE
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    IF VARTYPE(autos) = "L"
                        THIS.this_lAutos = autos
                    ELSE
                        IF VARTYPE(autos) = "L"
                            THIS.this_lAutos = autos
                        ELSE
                            IF VARTYPE(autos) = "L"
                                THIS.this_lAutos = autos
                            ELSE
                                IF VARTYPE(autos) = "L"
                                    THIS.this_lAutos = autos
                                ELSE
                                    IF VARTYPE(autos) = "L"
                                        THIS.this_lAutos = autos
                                    ELSE
                                        IF VARTYPE(autos) = "L"
                                            THIS.this_lAutos = autos
                                        ELSE
                                            IF VARTYPE(autos) = "L"
                                                THIS.this_lAutos = autos
                                            ELSE
                                                IF VARTYPE(autos) = "L"
                                                    THIS.this_lAutos = autos
                                                ELSE
                                                    IF VARTYPE(autos) = "L"
                                                        THIS.this_lAutos = autos
                                                    ELSE
                                                        IF VARTYPE(autos) = "L"
                                                            THIS.this_lAutos = autos
                                                        ELSE
                                                            IF VARTYPE(autos) = "L"
                                                                THIS.this_lAutos = autos
                                                            ELSE
                                                                IF VARTYPE(autos) = "L"
                                                                    THIS.this_lAutos = autos
                                                                ELSE
                                                                    IF VARTYPE(autos) = "L"
                                                                        THIS.this_lAutos = autos
                                                                    ELSE
                                                                        IF VARTYPE(autos) = "L"
                                                                            THIS.this_lAutos = autos
                                                                        ELSE
                                                                            IF VARTYPE(autos) = "L"
                                                                                THIS.this_lAutos = autos
                                                                            ELSE
                                                                                IF VARTYPE(autos) = "L"
                                                                                    THIS.this_lAutos = autos
                                                                                ELSE
                                                                                    IF VARTYPE(autos) = "L"
                                                                                        THIS.this_lAutos = autos
                                                                                    ELSE
                                                                                        IF VARTYPE(autos) = "L"
                                                                                            THIS.this_lAutos = autos
                                                                                        ELSE
                                                                                            THIS.this_lAutos = (NVL(autos, 0) = 1)
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        IF VARTYPE(concs) = "L"
            THIS.this_lConcs = concs
        ELSE
            IF VARTYPE(concs) = "L"
                THIS.this_lConcs = concs
            ELSE
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    IF VARTYPE(concs) = "L"
                        THIS.this_lConcs = concs
                    ELSE
                        IF VARTYPE(concs) = "L"
                            THIS.this_lConcs = concs
                        ELSE
                            IF VARTYPE(concs) = "L"
                                THIS.this_lConcs = concs
                            ELSE
                                IF VARTYPE(concs) = "L"
                                    THIS.this_lConcs = concs
                                ELSE
                                    IF VARTYPE(concs) = "L"
                                        THIS.this_lConcs = concs
                                    ELSE
                                        IF VARTYPE(concs) = "L"
                                            THIS.this_lConcs = concs
                                        ELSE
                                            IF VARTYPE(concs) = "L"
                                                THIS.this_lConcs = concs
                                            ELSE
                                                IF VARTYPE(concs) = "L"
                                                    THIS.this_lConcs = concs
                                                ELSE
                                                    IF VARTYPE(concs) = "L"
                                                        THIS.this_lConcs = concs
                                                    ELSE
                                                        IF VARTYPE(concs) = "L"
                                                            THIS.this_lConcs = concs
                                                        ELSE
                                                            IF VARTYPE(concs) = "L"
                                                                THIS.this_lConcs = concs
                                                            ELSE
                                                                IF VARTYPE(concs) = "L"
                                                                    THIS.this_lConcs = concs
                                                                ELSE
                                                                    IF VARTYPE(concs) = "L"
                                                                        THIS.this_lConcs = concs
                                                                    ELSE
                                                                        IF VARTYPE(concs) = "L"
                                                                            THIS.this_lConcs = concs
                                                                        ELSE
                                                                            IF VARTYPE(concs) = "L"
                                                                                THIS.this_lConcs = concs
                                                                            ELSE
                                                                                IF VARTYPE(concs) = "L"
                                                                                    THIS.this_lConcs = concs
                                                                                ELSE
                                                                                    IF VARTYPE(concs) = "L"
                                                                                        THIS.this_lConcs = concs
                                                                                    ELSE
                                                                                        IF VARTYPE(concs) = "L"
                                                                                            THIS.this_lConcs = concs
                                                                                        ELSE
                                                                                            THIS.this_lConcs = (NVL(concs, 0) = 1)
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        THIS.this_nCnotas     = cnotas
        THIS.this_cCidchaves  = cidchaves
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros de SigPrCsh
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .T.
        loc_cSQL = "SELECT empdopnums, datas, nopers, opers, fpags, moedas, " + ;
                   "codigocsh, valorori, valorcsh, perccsh, grupocash, contacsh " + ;
                   "FROM SigPrCsh "
        IF !EMPTY(par_cFiltro)
            loc_cSQL = loc_cSQL + "WHERE " + par_cFiltro + " "
        ENDIF
        loc_cSQL = loc_cSQL + "ORDER BY datas DESC, empdopnums"
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                empdopnums C(29),    ;
                datas      T,        ;
                nopers     C(7),     ;
                opers      C(1),     ;
                fpags      C(12),    ;
                moedas     C(3),     ;
                codigocsh  C(3),     ;
                valorori   N(15,4),  ;
                valorcsh   N(15,4),  ;
                perccsh    N(6,2),   ;
                grupocash  C(10),    ;
                contacsh   C(10)     ;
            )
            SET NULL OFF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Erro ao buscar SigPrCsh"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo empdopnums
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "SELECT * FROM SigPrCsh WHERE empdopnums = " + ;
                   EscaparSQL(par_cChave)
        TRY
            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")
            IF loc_nRet > 0 AND !EMPTY("cursor_4c_Registro") AND ;
               RECCOUNT("cursor_4c_Registro") > 0
                THIS.CarregarDoCursor("cursor_4c_Registro")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF
            IF USED("cursor_4c_Registro")
                USE IN cursor_4c_Registro
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "INSERT INTO SigPrCsh " + ;
                   "(empdopnums, datas, validade, nopers, opers, fpags, moedas, " + ;
                   "codigocsh, valorori, cotacaos, perccsh, valorcsh, " + ;
                   "grupocash, contacsh, cidchaves) " + ;
                   "VALUES (" + ;
                   EscaparSQL(THIS.this_cEmpdopnums)   + ", " + ;
                   FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                   FormatarDataSQL(THIS.this_dValidade) + ", " + ;
                   EscaparSQL(THIS.this_cNopers)        + ", " + ;
                   EscaparSQL(THIS.this_cOpers)         + ", " + ;
                   EscaparSQL(THIS.this_cFpags)         + ", " + ;
                   EscaparSQL(THIS.this_cMoedas)        + ", " + ;
                   EscaparSQL(THIS.this_cCodigocsh)     + ", " + ;
                   FormatarNumeroSQL(THIS.this_nValorori)  + ", " + ;
                   FormatarNumeroSQL(THIS.this_nCotacaos)  + ", " + ;
                   FormatarNumeroSQL(THIS.this_nPerccsh)   + ", " + ;
                   FormatarNumeroSQL(THIS.this_nValorcsh)  + ", " + ;
                   EscaparSQL(THIS.this_cGrupocash)     + ", " + ;
                   EscaparSQL(THIS.this_cContacsh)      + ", " + ;
                   EscaparSQL(THIS.this_cCidchaves)     + ;
                   ")"
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir em SigPrCsh"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "UPDATE SigPrCsh SET " + ;
                   "datas = "      + FormatarDataSQL(THIS.this_dDatas)      + ", " + ;
                   "validade = "   + FormatarDataSQL(THIS.this_dValidade)   + ", " + ;
                   "nopers = "     + EscaparSQL(THIS.this_cNopers)          + ", " + ;
                   "opers = "      + EscaparSQL(THIS.this_cOpers)           + ", " + ;
                   "fpags = "      + EscaparSQL(THIS.this_cFpags)           + ", " + ;
                   "moedas = "     + EscaparSQL(THIS.this_cMoedas)          + ", " + ;
                   "codigocsh = "  + EscaparSQL(THIS.this_cCodigocsh)       + ", " + ;
                   "valorori = "   + FormatarNumeroSQL(THIS.this_nValorori)  + ", " + ;
                   "cotacaos = "   + FormatarNumeroSQL(THIS.this_nCotacaos)  + ", " + ;
                   "perccsh = "    + FormatarNumeroSQL(THIS.this_nPerccsh)   + ", " + ;
                   "valorcsh = "   + FormatarNumeroSQL(THIS.this_nValorcsh)  + ", " + ;
                   "grupocash = "  + EscaparSQL(THIS.this_cGrupocash)       + ", " + ;
                   "contacsh = "   + EscaparSQL(THIS.this_cContacsh)        + ", " + ;
                   "cidchaves = "  + EscaparSQL(THIS.this_cCidchaves)       + " " + ;
                   "WHERE empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums)
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar SigPrCsh"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.
        loc_cSQL = "DELETE FROM SigPrCsh WHERE empdopnums = " + ;
                   EscaparSQL(THIS.this_cEmpdopnums)
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir de SigPrCsh"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPendencias - Carrega titulos nao baixados de SigMvCcr
    * Popula cursor_4c_Pendencias para o grid ContaCorrente (Page1 SubPaginas)
    * Filtro: registros nao pagos vinculados ao lancamento atual
    *==========================================================================
    PROCEDURE CarregarPendencias()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Garantir cursor com estrutura correta (campo L obrigatorio para CheckBox)
            IF USED("cursor_4c_Pendencias")
                USE IN cursor_4c_Pendencias
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Pendencias ;
                (Flag L, Emps C(3), Datas D, Vencs D, ;
                 Valos N(13,2), Acerto N(13,2), Moedas C(3), ;
                 Nomes C(100), OrdCopChS N(4))
            SET NULL OFF

            IF EMPTY(THIS.this_cEmpdopnums)
                *-- Modo INSERIR: sem lancamento salvo - retorna cursor vazio
                *-- Sera populado por CarregarPendenciasFiltro() apos usuario definir grupo/conta
                loc_lResultado = .T.
            ELSE
                *-- Modo ALTERAR/VISUALIZAR: busca itens vinculados ao lancamento
                loc_cSQL = "SELECT " + ;
                           "CAST(0 AS BIT) AS Flag, " + ;
                           "LEFT(ISNULL(EmpCCs,'   '),3) AS Emps, " + ;
                           "CAST(Datas AS date) AS Datas, " + ;
                           "CAST(ISNULL(Vencs,Datas) AS date) AS Vencs, " + ;
                           "ISNULL(Valors,0) AS Valos, " + ;
                           "ISNULL(Acertos,0) AS Acerto, " + ;
                           "LEFT(ISNULL(Moedas,''),3) AS Moedas, " + ;
                           "LEFT(RTRIM(ISNULL(Titulos,'')),100) AS Nomes, " + ;
                           "ISNULL(Nopers,0) AS OrdCopChS " + ;
                           "FROM SigMvCcr " + ;
                           "WHERE EmpDopNcs = " + EscaparSQL(THIS.this_cEmpdopnums) + " " + ;
                           "ORDER BY Datas, Nopers"

                IF USED("cursor_4c_PendTemp")
                    USE IN cursor_4c_PendTemp
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendTemp")
                IF loc_nRet > 0
                    *-- CRITICO: SQLEXEC em cursor separado + APPEND INTO cursor do grid
                    *-- Evita "Unknown member COLUMN1" se RecordSource muda alias
                    IF !EOF("cursor_4c_PendTemp")
                        GO TOP IN cursor_4c_PendTemp
                        DO WHILE !EOF("cursor_4c_PendTemp")
                            INSERT INTO cursor_4c_Pendencias ;
                                (Flag, Emps, Datas, Vencs, Valos, Acerto, Moedas, Nomes, OrdCopChS) ;
                            VALUES ;
                                (.F., ;
                                 ALLTRIM(cursor_4c_PendTemp.Emps), ;
                                 cursor_4c_PendTemp.Datas, ;
                                 cursor_4c_PendTemp.Vencs, ;
                                 cursor_4c_PendTemp.Valos, ;
                                 cursor_4c_PendTemp.Acerto, ;
                                 ALLTRIM(cursor_4c_PendTemp.Moedas), ;
                                 ALLTRIM(cursor_4c_PendTemp.Nomes), ;
                                 cursor_4c_PendTemp.OrdCopChS)
                            SKIP IN cursor_4c_PendTemp
                        ENDDO
                    ENDIF
                    IF USED("cursor_4c_PendTemp")
                        USE IN cursor_4c_PendTemp
                    ENDIF
                    GO TOP IN cursor_4c_Pendencias
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar pendencias de SigMvCcr"
                    IF USED("cursor_4c_PendTemp")
                        USE IN cursor_4c_PendTemp
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            IF USED("cursor_4c_PendTemp")
                USE IN cursor_4c_PendTemp
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
