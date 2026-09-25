*==============================================================================
* sigmvtitBO.prg
*
* Business Object para Formsigmvtit (Titulos Gerados - Movimentacao)
* Tabela principal: SigMvCcr (contas a receber/pagar geradas por movimento)
* Joins: SigCdGcr (descricao do grupo), SigCdCli (descricao da conta)
*
* Form OPERACIONAL de CONSULTA: exibe, por Empresa+Operacao+Numero (chave
* EmpDopNums) e Opers, os titulos gerados na movimentacao. Nao ha
* Inserir/Atualizar/Excluir no legado (SIGMVTIT.SCX so consulta e imprime).
*==============================================================================

DEFINE CLASS sigmvtitBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (LParameters pEDN, pOpe do legado)
    this_cEmpresa    = ""    && Empresa: Alltrim(Substr(pEDN, 01, 03))
    this_cOperacao   = ""    && Operacao (Dopes): Alltrim(Substr(pEDN, 04, 20))
    this_cNumero     = ""    && Numero: Alltrim(Substr(pEDN, 24, 06))
    this_cEmpDopNums = ""    && pEDN completo - char(29), usado no WHERE a.EmpDopNums =
    this_cOpers      = ""    && pOpe - char(1), usado no WHERE a.Opers =

    *-- Propriedades de dados do registro corrente da grade (SigMvCcr + joins)
    this_cTitulos  = ""      && SigMvCcr.titulos char(10)
    this_dVencs    = {}      && SigMvCcr.vencs datetime -> exibido via Ttod()
    this_nValors   = 0       && SigMvCcr.valors numeric(11,2)
    this_cMoedas   = ""      && SigMvCcr.moedas char(3)
    this_cHists    = ""      && SigMvCcr.hists char(60)
    this_cGrupos   = ""      && SigMvCcr.grupos char(10)
    this_cDGrupos  = ""      && SigCdGcr.descrs char(40) (Left Join por Grupos = Codigos)
    this_cContas   = ""      && SigMvCcr.contas char(10)
    this_cDContas  = ""      && SigCdCli.rclis char(50) (Left Join por Contas = Iclis)
    this_cDopcs    = ""      && SigMvCcr.dopcs char(20) (usado no botao de impressao - iDoc)
    this_nNumcs    = 0       && SigMvCcr.numcs numeric(6,0) (usado no botao de impressao - iDoc)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        THIS.this_cTabela = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Buscar - Popula cursor_4c_Dados com os titulos gerados na movimentacao
    *
    * Espelha literalmente a query do Init do legado (SIGMVTIT.SCX):
    *   Select a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos,
    *          b.Descrs as DGrupos, a.Contas, c.RClis as DContas, a.Dopcs, a.Numcs
    *   From SigMvCcr a
    *   Left Join SigCdGcr b On a.Grupos = b.Codigos
    *   Left Join SigCdCli c On a.Contas = c.IClis
    *   Where a.EmpDopNums = ?pEDN And a.Opers = ?pOpe
    *   Order By a.Vencs, a.Titulos, a.Grupos, a.Contas
    *
    * par_cEmpDopNums: chave POSICIONAL char(29) ja montada pelo form CHAMADOR
    * (Empresa char(3) + Operacao char(20) + Numero str(6)). NUNCA aplicar
    * ALLTRIM nela - o padding faz parte da chave (mesma familia do Erro177).
    *==========================================================================
    PROCEDURE Buscar(par_cEmpDopNums, par_cOpers)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    *-- vencs eh T (datetime), NAO D: SigMvCcr.vencs eh
                    *-- datetime no schema, e a grade liga a coluna via
                    *-- ControlSource = "TTOD(cursor_4c_Dados.vencs)". Com D
                    *-- aqui o TTOD receberia um DATE e estouraria o erro 11
                    *-- em runtime (regra CLAUDE.md #16) - o fallback tem de
                    *-- ter a MESMA estrutura que o SQLEXEC produz.
                    CREATE CURSOR cursor_4c_Dados (titulos C(10), vencs T, valors N(11,2), ;
                        moedas C(3), hists C(60), grupos C(10), dgrupos C(40), ;
                        contas C(10), dcontas C(50), dopcs C(20), numcs N(6,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT a.titulos, a.vencs, a.valors, a.moedas, a.hists, a.grupos, " + ;
                    "b.descrs AS dgrupos, a.contas, c.rclis AS dcontas, a.dopcs, a.numcs " + ;
                    "FROM SigMvCcr a " + ;
                    "LEFT JOIN SigCdGcr b ON a.grupos = b.codigos " + ;
                    "LEFT JOIN SigCdCli c ON a.contas = c.iclis " + ;
                    "WHERE a.empdopnums = " + EscaparSQL(par_cEmpDopNums) + " " + ;
                    "AND a.opers = " + EscaparSQL(par_cOpers) + " " + ;
                    "ORDER BY a.vencs, a.titulos, a.grupos, a.contas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        GO TOP
                    ENDIF
                ELSE
                    MostrarErro("Erro ao buscar t" + CHR(237) + "tulos gerados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvtitBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do registro corrente de
    * cursor_4c_Dados (equivalente ao AfterRowColChange do legado, que
    * espelhava LocalTits.DGrupos/DContas nos GETs de descricao)
    *
    * PUBLIC de proposito: BusinessBase.CarregarDoCursor eh PUBLIC e o form
    * chama este metodo de FORA da classe (AtualizarDescricoes). Declarar
    * PROTECTED aqui estreitaria a visibilidade da base e a chamada falharia em
    * RUNTIME com "Property CARREGARDOCURSOR is not found" - mesma armadilha da
    * regra CLAUDE.md #3 (PEMSTATUS so verifica existencia, nao escopo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF !EOF()
                    THIS.this_cTitulos  = TratarNulo(titulos,  "")
                    THIS.this_dVencs    = ConverterParaData(vencs)
                    THIS.this_nValors   = TratarNulo(valors,   0)
                    THIS.this_cMoedas   = TratarNulo(moedas,   "")
                    THIS.this_cHists    = TratarNulo(hists,    "")
                    THIS.this_cGrupos   = TratarNulo(grupos,   "")
                    THIS.this_cDGrupos  = TratarNulo(dgrupos,  "")
                    THIS.this_cContas   = TratarNulo(contas,   "")
                    THIS.this_cDContas  = TratarNulo(dcontas,  "")
                    THIS.this_cDopcs    = TratarNulo(dopcs,    "")
                    THIS.this_nNumcs    = TratarNulo(numcs,    0)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigmvtitBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Identificador do registro corrente da grade, usado
    * apenas se algum dia a base chamar RegistrarAuditoria (form eh consulta,
    * nao grava nada por conta propria)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGMVTIT eh um form de CONSULTA
    * (visualizador de titulos gerados na movimentacao, aberto via DO FORM
    * com Empresa/Operacao/Numero). O legado (SIGMVTIT.SCX) nao tem nenhum
    * INSERT/UPDATE/DELETE - so exibe a grade e imprime (botao iDoc chama
    * outro form, SigReIdt). O comportamento padrao herdado de BusinessBase
    * (recusar a operacao) ja eh o correto - nao ha necessidade de
    * sobrescrever esses tres metodos aqui.
    *==========================================================================

ENDDEFINE
