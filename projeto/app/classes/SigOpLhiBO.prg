*==============================================================================
* SIGOPLHIBO.PRG
* Business Object para o dialogo de Lancamentos em Conta Corrente
* (SIGOPLHI - dialogo filho MODAL aberto pelo form pai SIGCDPGR via
*  "Do Form SigOpLhi With ThisForm", NAO acessivel direto pelo menu)
*
* Tabela de contexto : SigCdPgr (programacao de pagamento/recebimento)
* Chave Real (PK)    : cidchaves  CHAR(20)
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGCDPGR linhas 13197-13460):
*   O form PAI monta em memoria o cursor local TmpLanca com os lancamentos
*   que serao efetuados em Conta Corrente:
*
*     Create Cursor TmpLanca ( Grupos c(10), Contas c(10), Moeda c(3),
*                              Cotacaos n(14,4), GrupoC c(10), ContaC c(10),
*                              MoedaC c(3), CotacaoC n(14,4), Hists c(40),
*                              Valor n(12,2), ValPag n(12,2), Tipos c(1),
*                              ValorC n(12,2), ValPagC n(12,2), Hist2s c(40))
*     Index on Grupos + Contas + Moeda + Tipos + GrupoC + ContaC + MoedaC
*              + Hists + Hist2s Tag GruConMoe
*
*   e so entao abre este dialogo (somente quando !Eof() e
*   PgRecParam.MudaHists = 1). O usuario CONFERE a lista e pode EDITAR a
*   coluna Historico (Hists) - e a unica Column do grid sem ReadOnly = .T.
*   no SCX. Ao sair:
*     Confirma ("Ok")      -> ThisForm.Release (o pai segue e, quando
*                             crSigCdPac.UniHists = 1, le de volta
*                             ThisForm.HistoricoCliente = TmpLanca.Hists)
*     Cancela ("Encerrar") -> ThisForm.ParentForm.CanceladoExterno = .T.
*                             + ThisForm.Release (o pai aborta a baixa)
*
*   Portanto o destino de TODA escrita deste dialogo eh o CURSOR LOCAL do pai -
*   nao existe Insert Into / Update / Delete From / TableUpdate / AddCursor
*   sobre tabela do SQL Server em nenhum metodo do SIGOPLHI. O acesso remoto
*   do legado se resume a LEITURA de crSigCdPgr (Dopes + MascNum) para montar
*   o Caption. Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase (recusar
*   a operacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
*   inventar INSERT/UPDATE aqui violaria a regra #22 do CLAUDE.md (a lista de
*   colunas vem do schema, nunca de adivinhacao).
*
* CAPTION DO LEGADO (Init do SIGOPLHI):
*   'Lancamentos para ' + Alltrim(crSigCdPgr.Dopes) + ' - '
*                       + Alltrim(crSigCdPgr.MascNum)
*   e o mesmo texto vai para cntSombra.lblSombra.Caption e lblTitulo.Caption.
*
* ATENCAO AO DUMP DO SCX (divergencia herdada, confirmada no legado):
*   Grade.Column3.ControlSource       = "HISTS"  <- vale este (a Column manda)
*   Grade.Column3.Text1.ControlSource = "Nomes"  <- residuo: TmpLanca NAO tem
*                                                   coluna Nomes
*==============================================================================

DEFINE CLASS SigOpLhiBO AS BusinessBase

    *--------------------------------------------------------------------------
    * CONTEXTO - SigCdPgr (crSigCdPgr no legado)
    * Somente leitura: alimenta o Caption / titulo do dialogo.
    * O sufixo "Pgr" existe porque SigCdPgr TAMBEM tem as colunas grupos e
    * contas, que colidiriam com as colunas homonimas de TmpLanca abaixo.
    *--------------------------------------------------------------------------
    this_cDopes             = ""   && dopes      CHAR(20)      - tipo de documento
    this_cMascNum           = ""   && mascnum    CHAR(6)       - numero mascarado
    this_cCidChaves         = ""   && cidchaves  CHAR(20)      - chave primaria real
    this_cEmps              = ""   && emps       CHAR(3)       - empresa
    this_nNumes             = 0    && numes      NUMERIC(6,0)  - numero do documento
    this_cGruposPgr         = ""   && grupos     CHAR(10)      - grupo da programacao
    this_cContasPgr         = ""   && contas     CHAR(10)      - conta da programacao
    this_cEmpDopNums        = ""   && empdopnums CHAR(29)      - chave posicional

    *--------------------------------------------------------------------------
    * LINHA CORRENTE DO CURSOR DE LANCAMENTOS (TmpLanca)
    * Nomes espelhados coluna a coluna para eliminar divergencia de
    * nomenclatura entre Form e BO (CLAUDE.md / Pattern #177).
    * As colunas sem sufixo sao o lado principal do lancamento; as terminadas
    * em "C" sao a contrapartida.
    *--------------------------------------------------------------------------
    this_cGrupos            = ""   && Grupos     CHAR(10)      - grupo da conta (grid "Grupo")
    this_cContas            = ""   && Contas     CHAR(10)      - conta (grid "Conta")
    this_cMoeda             = ""   && Moeda      CHAR(3)       - moeda (grid "Moe")
    this_nCotacaos          = 0    && Cotacaos   NUMERIC(14,4) - cotacao da moeda
    this_cGrupoC            = ""   && GrupoC     CHAR(10)      - grupo da contrapartida
    this_cContaC            = ""   && ContaC     CHAR(10)      - conta da contrapartida
    this_cMoedaC            = ""   && MoedaC     CHAR(3)       - moeda da contrapartida
    this_nCotacaoC          = 0    && CotacaoC   NUMERIC(14,4) - cotacao da contrapartida
    this_cHists             = ""   && Hists      CHAR(40)      - historico (grid, EDITAVEL)
    this_cHist2s            = ""   && Hist2s     CHAR(40)      - historico complementar
    this_nValor             = 0    && Valor      NUMERIC(12,2) - valor (grid "Valor")
    this_nValPag            = 0    && ValPag     NUMERIC(12,2) - valor pago
    this_cTipos             = ""   && Tipos      CHAR(1)       - tipo do lancamento
    this_nValorC            = 0    && ValorC     NUMERIC(12,2) - valor da contrapartida
    this_nValPagC           = 0    && ValPagC    NUMERIC(12,2) - valor pago da contrapartida

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    * this_cCursorLancamentos : alias migrado de TmpLanca. O cursor eh criado e
    *   populado pelo form PAI; este dialogo apenas o exibe e edita o Hists.
    * this_lCanceladoExterno  : espelha ThisForm.ParentForm.CanceladoExterno do
    *   legado - .T. quando o usuario saiu pelo botao Encerrar (Cancela).
    *--------------------------------------------------------------------------
    this_cCursorLancamentos = "cursor_4c_Lancamentos"
    this_cTituloDialogo     = ""
    this_lCanceladoExterno  = .F.
    this_nTotalLancamentos  = 0

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este dialogo
    * nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de CONTEXTO, lida para montar o
    * titulo do dialogo.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPgr"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela de contexto (cidchaves).
    * PROTECTED por contrato da BusinessBase (CLAUDE.md regra #51): nunca
    * chamar de fora do BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia o cursor de CONTEXTO (SigCdPgr, crSigCdPgr no
    * legado) para as propriedades this_c*/this_n* que identificam o registro
    * pai e alimentam o titulo do dialogo. Chamado pelo Form a partir do
    * cursor de contexto que o form PAI ja mantem aberto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cDopes      = TratarNulo(dopes, "")
        THIS.this_cMascNum    = TratarNulo(mascnum, "")
        THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
        THIS.this_cEmps       = TratarNulo(emps, "")
        THIS.this_nNumes      = TratarNulo(numes, 0)
        THIS.this_cGruposPgr  = TratarNulo(grupos, "")
        THIS.this_cContasPgr  = TratarNulo(contas, "")
        THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")

        THIS.MontarTitulo()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarTitulo - Reproduz o Caption do Init legado:
    *   'Lancamentos para ' + Alltrim(Dopes) + ' - ' + Alltrim(MascNum)
    * Alimenta this_cTituloDialogo, usado pelo Form no Caption do form e nos
    * dois labels do cabecalho (lbl_4c_Sombra / lbl_4c_Titulo).
    *--------------------------------------------------------------------------
    PROCEDURE MontarTitulo()
        THIS.this_cTituloDialogo = "Lan" + CHR(231) + "amentos para " + ;
            ALLTRIM(THIS.this_cDopes) + " - " + ALLTRIM(THIS.this_cMascNum)

        RETURN THIS.this_cTituloDialogo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLinhaAtual - Copia a linha CORRENTE do cursor de lancamentos
    * (TmpLanca no legado) para as propriedades this_* da linha. O Grid
    * continua ligado DIRETO ao cursor via ControlSource - este metodo existe
    * para o Form consultar/validar a linha corrente fora do Grid (regra #46:
    * validacao de celula vai no Valid do TextBox da coluna, nunca em
    * AfterRowColChange).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLinhaAtual(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)

        THIS.this_cGrupos   = TratarNulo(Grupos, "")
        THIS.this_cContas   = TratarNulo(Contas, "")
        THIS.this_cMoeda    = TratarNulo(Moeda, "")
        THIS.this_nCotacaos = TratarNulo(Cotacaos, 0)
        THIS.this_cGrupoC   = TratarNulo(GrupoC, "")
        THIS.this_cContaC   = TratarNulo(ContaC, "")
        THIS.this_cMoedaC   = TratarNulo(MoedaC, "")
        THIS.this_nCotacaoC = TratarNulo(CotacaoC, 0)
        THIS.this_cHists    = TratarNulo(Hists, "")
        THIS.this_cHist2s   = TratarNulo(Hist2s, "")
        THIS.this_nValor    = TratarNulo(Valor, 0)
        THIS.this_nValPag   = TratarNulo(ValPag, 0)
        THIS.this_cTipos    = TratarNulo(Tipos, "")
        THIS.this_nValorC   = TratarNulo(ValorC, 0)
        THIS.this_nValPagC  = TratarNulo(ValPagC, 0)

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarHistorico - Grava o novo texto de Historico na linha CORRENTE do
    * cursor de lancamentos. Eh a UNICA coluna editavel do grid no legado
    * (Grade.Column3 sem ReadOnly = .T. no SCX) - Grupo/Conta/Valor/Moe sao
    * somente leitura (Column1/2/4/5 com ReadOnly = .T.).
    *--------------------------------------------------------------------------
    PROCEDURE GravarHistorico(par_cAliasLancamentos, par_cNovoHistorico)
        LOCAL loc_cAlias, loc_cValor

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)
        loc_cValor = IIF(VARTYPE(par_cNovoHistorico) = "C", par_cNovoHistorico, "")

        IF !USED(loc_cAlias) OR EOF(loc_cAlias)
            RETURN .F.
        ENDIF

        REPLACE Hists WITH loc_cValor IN (loc_cAlias)
        THIS.this_cHists = loc_cValor

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ContarLancamentos - Total de linhas do cursor de lancamentos. O form PAI
    * so abre este dialogo quando !Eof() (ver cabecalho) - o Form usa este
    * metodo para confirmar que ha o que exibir antes de tornar o grid ativo.
    *--------------------------------------------------------------------------
    PROCEDURE ContarLancamentos(par_cAliasLancamentos)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasLancamentos) = "C" AND !EMPTY(par_cAliasLancamentos), ;
            par_cAliasLancamentos, THIS.this_cCursorLancamentos)

        IF !USED(loc_cAlias)
            THIS.this_nTotalLancamentos = 0
        ELSE
            THIS.this_nTotalLancamentos = RECCOUNT(loc_cAlias)
        ENDIF

        RETURN THIS.this_nTotalLancamentos
    ENDPROC

ENDDEFINE
