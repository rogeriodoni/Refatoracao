*==============================================================================
* SIGMVTI2BO.PRG
* Business Object - Titulos Gerados (Processamento CMV) (SIGMVTI2)
* Consulta os titulos financeiros gerados pelo processamento de CMV
* (SigMvCcr), no periodo compreendido entre o momento da abertura do
* formulario e o final do dia, com joins para descricao do grupo de
* conta (SigCdGcr) e descricao da conta (SigCdCli).
* Heranca: BusinessBase
*
* NOTA IMPORTANTE (paridade com o legado): o SIGMVTIT/SIGMVTI2 eh um
* formulario de CONSULTA (grid de titulos recem-gerados) - o codigo fonte
* original (Init) faz SOMENTE um SELECT em SigMvCcr com Left Join em
* SigCdGcr/SigCdCli e Join em SigOpCdi. Nao existe, em lugar nenhum do
* legado, INSERT/UPDATE/DELETE em SigMvCcr disparado por este formulario -
* por isso Inserir()/Atualizar()/ExecutarExclusao() nao sao sobrescritos
* aqui: o comportamento padrao herdado de BusinessBase (recusar a
* operacao e reportar via ExibirFalha) ja eh o correto para um BO
* somente-leitura.
*==============================================================================

DEFINE CLASS SIGMVTI2BO AS BusinessBase

    *-- Filtro de periodo (espelha pDtI/pDtF do Init legado:
    *   pDtI = fDtoSQL(Datetime())                 -> momento atual
    *   pDtF = fDtoSQL(Datetime(), [23:59:59])      -> hoje as 23:59:59)
    this_dDtI = {}    && Data/hora inicial do filtro (SigMvCcr.datas between this_dDtI e this_dDtF)
    this_dDtF = {}    && Data/hora final do filtro

    *-- Dados do titulo selecionado no grid (SigMvCcr + joins SigCdGcr/SigCdCli)
    this_cTitulos    = ""   && SigMvCcr.titulos     char(10)      - codigo do titulo (PK logica)
    this_dVencs      = {}   && SigMvCcr.vencs       datetime      - data de vencimento
    this_nValors     = 0    && SigMvCcr.valors      numeric(11,2) - valor do titulo
    this_cMoedas     = ""   && SigMvCcr.moedas      char(3)       - codigo da moeda
    this_cHists      = ""   && SigMvCcr.hists       char(60)      - historico
    this_cGrupos     = ""   && SigMvCcr.grupos      char(10)      - grupo de conta (FK SigCdGcr.codigos)
    this_cDGrupos    = ""   && SigCdGcr.descrs                    - descricao do grupo (join b, alias DGrupos)
    this_cContas     = ""   && SigMvCcr.contas      char(10)      - conta (FK SigCdCli.IClis)
    this_cDContas    = ""   && SigCdCli.RClis                     - descricao da conta (join c, alias DContas)
    this_cEmpDopNums = ""   && SigMvCcr.empdopnums  char(29)      - chave Empresa+Operacao+Numero
    this_cOpers      = ""   && SigMvCcr.opers       char(1)       - tipo de operacao (D/C)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigMvCcr")

        THIS.this_cCampoChave = "cidchaves"

        * Periodo padrao: do momento atual ate o final do dia de hoje,
        * reproduzindo pDtI/pDtF do Init legado (fDtoSQL(Datetime()) e
        * fDtoSQL(Datetime(), [23:59:59]))
        THIS.this_dDtI = DATETIME()
        THIS.this_dDtF = DATETIME(YEAR(DATE()), MONTH(DATE()), DAY(DATE()), 23, 59, 59)

        THIS.this_cTitulos    = ""
        THIS.this_dVencs      = {}
        THIS.this_nValors     = 0
        THIS.this_cMoedas     = ""
        THIS.this_cHists      = ""
        THIS.this_cGrupos     = ""
        THIS.this_cDGrupos    = ""
        THIS.this_cContas     = ""
        THIS.this_cDContas    = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cOpers      = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTitulosGerados - Popula cursor_4c_Dados com os titulos gerados
    * pelo processamento de CMV no periodo THIS.this_dDtI / THIS.this_dDtF.
    * Transcricao literal da query do Init legado (SigMvCcr a + Left Join
    * SigCdGcr b + Left Join SigCdCli c + Join SigOpCdi d), trocando os
    * parametros ?pDtI/?pDtF por literais formatados (FormatarDataSQL) e o
    * cursor local LocalTits pelo cursor_4c_Dados do grid.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTitulosGerados()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        loc_cSQL = "SELECT a.Titulos, a.Vencs, a.Valors, a.Moedas, a.Hists, a.Grupos, " + ;
                   "b.Descrs AS DGrupos, a.Contas, c.RClis AS DContas, a.EmpDopNums, a.Opers " + ;
                   "FROM SigMvCcr a " + ;
                   "LEFT JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
                   "LEFT JOIN SigCdCli c ON a.Contas = c.IClis " + ;
                   "JOIN SigOpCdi d ON d.Dopes = a.Dopes " + ;
                   "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtI) + " AND " + FormatarDataSQL(THIS.this_dDtF) + " " + ;
                   "ORDER BY a.Vencs, a.Titulos, a.Grupos, a.Contas"

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

        IF loc_nResultado >= 0
            loc_lSucesso = .T.
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                GO TOP
            ENDIF
        ELSE
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL()
            MostrarErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o (T" + CHR(237) + "tulos Gerados)")
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades this_* a partir de UMA linha
    * do cursor_4c_Dados (mesmas colunas/alias de BuscarTitulosGerados),
    * reproduzindo o AfterRowColChange do grdTitulos legado (que lia
    * LocalTits.DGrupos/DContas/EmpDopNums direto para os GETs de rodape).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        THIS.this_cTitulos    = TratarNulo(Titulos, "")
        THIS.this_dVencs      = TratarNulo(Vencs, {})
        THIS.this_nValors     = TratarNulo(Valors, 0)
        THIS.this_cMoedas     = TratarNulo(Moedas, "")
        THIS.this_cHists      = TratarNulo(Hists, "")
        THIS.this_cGrupos     = TratarNulo(Grupos, "")
        THIS.this_cDGrupos    = TratarNulo(DGrupos, "")
        THIS.this_cContas     = TratarNulo(Contas, "")
        THIS.this_cDContas    = TratarNulo(DContas, "")
        THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "")
        THIS.this_cOpers      = TratarNulo(Opers, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identificador logico do titulo corrente (coluna
    * Titulos, chave usada pelo grid legado). cidchaves (PK fisica da
    * SigMvCcr) nao entra no SELECT desta consulta (o legado tambem nao a
    * le) - RegistrarAuditoria/ObterChavePrimaria so existem aqui por
    * completude de heranca, ja que este BO nao grava (ver nota no Init).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cTitulos
    ENDPROC

ENDDEFINE
