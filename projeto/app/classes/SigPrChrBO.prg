*============================================================================
* SigPrChrBO.prg - Business Object para Consulta/Cancelamento de Cheques
*
* Origem legado: SIGPRCHR.SCX
* Form OPERACIONAL (nao segue padrao CRUD Page1=Lista/Page2=Dados): tela de
* consulta de cheques emitidos por conta/periodo, com filtro por Grupo e
* Conta, impressao de cheque/documento/recibo, cancelamento de documento e
* exclusao fisica de cheque cancelado (Delete From SigCqChi Where cidchaves
* = ...). Tabela principal manipulada: SigCqChi (comportamento.json).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigPrChrBO AS BusinessBase

    *==========================================================================
    * Filtro de periodo - espelha Dt_Inicial/Dt_Final do legado. AntData* eh
    * o valor anterior do filtro (AntDtIni/AntDtFin), usado para saber se a
    * lista de cheques precisa ser recarregada quando o campo muda de valor.
    *==========================================================================
    this_dDataInicial    = {}    && Data inicial do periodo de busca (Dt_Inicial)
    this_dDataFinal      = {}    && Data final do periodo de busca (Dt_Final)
    this_dAntDataInicial = {}    && Valor anterior de this_dDataInicial (AntDtIni)
    this_dAntDataFinal   = {}    && Valor anterior de this_dDataFinal (AntDtFin)

    *==========================================================================
    * Filtro de Grupo de Contas - espelha GetCdGrupos/GetDsGrupos. Ant* guarda
    * o valor anterior para decidir se o cursor de cheques precisa ser
    * recarregado (Zap In CsSigCqChi quando o valor muda).
    *==========================================================================
    this_cCodGrupo     = ""      && Codigo do grupo de contas (GetCdGrupos)
    this_cDescGrupo    = ""      && Descricao do grupo de contas (GetDsGrupos)
    this_cAntCodGrupo  = ""      && Valor anterior de this_cCodGrupo (AntCdGrupo)
    this_cAntDescGrupo = ""      && Valor anterior de this_cDescGrupo (AntDsGrupo)

    *==========================================================================
    * Filtro de Conta - espelha getCdContas/getDsContas. Ant* guarda o valor
    * anterior para a mesma finalidade do bloco de Grupo.
    *==========================================================================
    this_cCodConta     = ""      && Codigo da conta (getCdContas)
    this_cDescConta    = ""      && Descricao/razao social da conta (getDsContas)
    this_cAntCodConta  = ""      && Valor anterior de this_cCodConta (AntCdConta)
    this_cAntDescConta = ""      && Valor anterior de this_cDescConta (AntDsConta)

    *==========================================================================
    * Favorecido do cheque selecionado na grade (TxtFavorecido, somente
    * leitura - espelha CsSigCqChi.favos do registro corrente).
    *==========================================================================
    this_cFavorecido = ""

    *==========================================================================
    * Flags de acesso do usuario logado (fChecaAcesso('SIGPRCHR', <operacao>)
    * no Init legado) - controlam Enabled dos botoes Excluir Documento e
    * Excluir Cheque.
    *==========================================================================
    this_lExcluirDocumento = .F.  && Acesso para excluir documento (ExcluirDocumento)
    this_lExcluirCheque    = .F.  && Acesso para excluir cheque cancelado (ExcluirCheque)

    *==========================================================================
    * Controle de fluxo da primeira exibicao da lista de cheques - MontaChq
    * recebe par_lPosiciona e, quando .F. (Inicial = .T. no legado), vai
    * direto para o Top do cursor em vez de reposicionar no ultimo cheque
    * selecionado.
    *==========================================================================
    this_lPrimeiraExibicao = .T.  && Inicial

    *==========================================================================
    * Leitor de codigo de barras do cheque (getBanco.KeyPress no legado):
    * this_lLeitorChequeAtivo indica se o usuario esta no meio de uma leitura
    * (tecla 60 inicia, tecla 58 finaliza) e this_cChequeLido acumula os
    * caracteres lidos (pcChqLido).
    *==========================================================================
    this_lLeitorChequeAtivo = .F. && plLeCheque
    this_cChequeLido        = ""  && pcChqLido

    *==========================================================================
    * Nomes dos cursores de trabalho, compartilhados entre os metodos do BO
    * e o Form (grids ligados via RecordSource/ControlSource).
    *==========================================================================
    this_cCursorCheques     = "cursor_4c_Cheques"      && CsSigCqChi (cheques do periodo/conta filtrados)
    this_cCursorContas      = "cursor_4c_Contas"        && CrContas (contas com emissao de cheque habilitada)
    this_cCursorImpressoras = "cursor_4c_Impressoras"   && CrSigCdmp (impressoras cadastradas)

    *==========================================================================
    * Cheque corrente - espelha 1:1 as colunas de SigCqChi (docs/schema.sql)
    * do registro selecionado na grade. Populado por CarregarDoCursor() e
    * usado por ObterChavePrimaria()/ExecutarExclusao() no cancelamento
    * fisico do cheque (Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado).
    *==========================================================================
    this_cCidchaves   = ""      && PK Fortyus (cidchaves)
    this_cAgencias    = ""      && agencias char(4)
    this_cBancos      = ""      && bancos char(3)
    this_lCancelas    = .F.     && cancelas bit -> cheque CANCELADO (ncancelas no legado)
    this_cContas      = ""      && contas char(10)
    this_dDatas       = {}      && datas datetime NULL - emissao do cheque
    this_cDopes       = ""      && dopes char(20) - documento de origem
    this_lEmitidos    = .F.     && emitidos bit (nemitidos no legado)
    this_cEmps        = ""      && emps char(3)
    this_cGrupos      = ""      && grupos char(10) - grupo de contas do cheque
    this_cNcheques    = ""      && ncheques char(6) - numero do cheque
    this_cNcontas     = ""      && ncontas char(10) - conta corrente
    this_nNcopias     = 0       && ncopias numeric(6,0)
    this_nNemissoes   = 0       && nemissoes numeric(2,0)
    this_nNumes       = 0       && numes numeric(6,0) - numero do documento (Dopes/Numes)
    this_nValors      = 0       && valors numeric(11,2)
    this_dVencs       = {}      && vencs datetime NULL - vencimento
    this_cVersos      = ""      && versos text - texto do verso do cheque
    this_cEmpDopNums  = ""      && empdopnums char(29) - chave posicional Emps+Dopes+Str(Numes,6)
    this_cJustCanc    = ""      && justcanc text - justificativa do cancelamento (get_justificativa)
    this_nImpVersos   = 0       && impversos numeric(1,0)

    *==========================================================================
    * Init - Business Object sem tabela unica de persistencia CRUD; a tabela
    * fisica manipulada (Delete no cancelamento de cheque) eh SigCqChi, e a
    * chave primaria eh cidchaves (cidchaves char - PK Fortyus, ver INSERT
    * do legado / regra #22 do CLAUDE.md).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigCqChi")
            THIS.this_cCampoChave = "cidchaves"

            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            THIS.this_dAntDataInicial = {}
            THIS.this_dAntDataFinal   = {}
            THIS.this_cAntCodGrupo    = ""
            THIS.this_cAntDescGrupo   = ""
            THIS.this_cAntCodConta    = ""
            THIS.this_cAntDescConta   = ""

            THIS.this_lExcluirDocumento = fChecaAcesso("SIGPRCHR", "EXCLUIR")
            THIS.this_lExcluirCheque    = fChecaAcesso("SIGPRCHR", "EXCLUIRCHQ")
            THIS.this_lPrimeiraExibicao = .T.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigCqChi (par_cAliasCursor
    * eh um cursor de UM cheque, populado por SQLEXEC com os nomes reais do
    * banco - docs/schema.sql) para as properties this_* do cheque corrente.
    * Usado pelo Form ao selecionar uma linha da grade, antes de acionar
    * Excluir() (cancelamento fisico do cheque ja cancelado).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
            THIS.this_cAgencias   = TratarNulo(agencias, "")
            THIS.this_cBancos     = TratarNulo(bancos, "")
            THIS.this_lCancelas   = ConverterParaLogico(cancelas)
            THIS.this_cContas     = TratarNulo(contas, "")
            THIS.this_dDatas      = ConverterParaData(datas)
            THIS.this_cDopes      = TratarNulo(dopes, "")
            THIS.this_lEmitidos   = ConverterParaLogico(emitidos)
            THIS.this_cEmps       = TratarNulo(emps, "")
            THIS.this_cFavorecido = TratarNulo(favos, "")
            THIS.this_cGrupos     = TratarNulo(grupos, "")
            THIS.this_cNcheques   = TratarNulo(ncheques, "")
            THIS.this_cNcontas    = TratarNulo(ncontas, "")
            THIS.this_nNcopias    = NVL(ncopias, 0)
            THIS.this_nNemissoes  = NVL(nemissoes, 0)
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = ConverterParaData(vencs)
            THIS.this_cVersos     = TratarNulo(versos, "")
            THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
            THIS.this_cJustCanc   = TratarNulo(justcanc, "")
            THIS.this_nImpVersos  = NVL(impversos, 0)

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCheques - Consulta os cheques do periodo/grupo/conta filtrados e
    * devolve o resultado em par_cCursorDestino (cursor TEMPORARIO - quem
    * transfere para o cursor da grade eh o Form, via ZAP + APPEND FROM DBF,
    * para nao destruir o binding do Grid).
    *
    * Transcricao 1:1 do SELECT do "PROCEDURE montachq" legado (duas variantes
    * conforme a Conta estar preenchida ou nao):
    *
    *   Sem conta : ...Where a.datas Between ?lcDtInicial And ?lcDtFinal And
    *                    [a.Grupos = '<grupo>' And]
    *                    a.Contas in (Select Distinct ContaDs From SigOpFp
    *                                  Where EmiChqs = 1)
    *   Com conta : ...Where datas Between ... And [Grupos = ... And]
    *                    Contas = '<conta>'
    *
    * O filtro de Grupo eh OPCIONAL no legado (Iif(Empty(lcCdGrupo), [], ...)) -
    * a ausencia dele NAO eh esquecimento de migracao.
    *
    * Os "Iif(Emitidos,1,0) as NEmitidos" / "Iif(Cancelas,1,0) as NCancelas"
    * que o legado faz no SELECT VFP sao resolvidos aqui no SQL Server (CASE
    * WHEN), porque emitidos/cancelas sao colunas "bit" (docs/schema.sql) e
    * chegam ao VFP ora como Logico ora como Numerico conforme o driver
    * (CLAUDE.md regra #13) - converter no servidor elimina a ambiguidade e
    * entrega numeric(1,0), que eh o tipo das colunas nemitidos/ncancelas do
    * cursor da grade.
    *
    * A ordenacao final eh a do SELECT VFP do legado (Order By Bancos,
    * Agencias, NContas, NCheques), que sobrepoe o Order By da query remota.
    *==========================================================================
    PROCEDURE CarregarCheques(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cCursor, loc_cSQL, loc_nResultado
        LOCAL loc_dIni, loc_dFim, loc_tIni, loc_tFim, loc_cGrupo, loc_cConta
        LOCAL loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND ;
                !EMPTY(par_cCursorDestino), par_cCursorDestino, "cursor_4c_ChequesTmp")

            *-- ConverterParaData: o filtro pode chegar como DATE (TextBox com
            *-- .Value = {}) ou como DATETIME (coluna do banco) - CLAUDE.md #16.
            loc_dIni = ConverterParaData(THIS.this_dDataInicial)
            loc_dFim = ConverterParaData(THIS.this_dDataFinal)

            IF EMPTY(loc_dIni) OR EMPTY(loc_dFim)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + ;
                    "o informado para a consulta de cheques."
            ELSE
                *-- fDtoSQL(Dt_Inicial.Value) / fDtoSQL(Dt_Final.Value,'23:59:59')
                loc_tIni = DTOT(loc_dIni)
                loc_tFim = DATETIME(YEAR(loc_dFim), MONTH(loc_dFim), DAY(loc_dFim), 23, 59, 59)

                loc_cGrupo = ALLTRIM(THIS.this_cCodGrupo)
                loc_cConta = ALLTRIM(THIS.this_cCodConta)

                loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.bancos, " + ;
                           "a.agencias, a.ncontas, a.ncheques, a.contas, a.valors, " + ;
                           "a.favos, a.ncopias, a.nemissoes, a.cidchaves, a.justcanc, " + ;
                           "CASE WHEN a.emitidos = 1 THEN 1 ELSE 0 END AS nemitidos, " + ;
                           "CASE WHEN a.cancelas = 1 THEN 1 ELSE 0 END AS ncancelas, " + ;
                           "0 AS nmarca1s " + ;
                           "FROM SigCqChi a " + ;
                           "WHERE a.datas BETWEEN " + FormatarDataSQL(loc_tIni) + ;
                               " AND " + FormatarDataSQL(loc_tFim) + " "

                IF !EMPTY(loc_cGrupo)
                    loc_cSQL = loc_cSQL + "AND a.grupos = " + EscaparSQL(loc_cGrupo) + " "
                ENDIF

                IF EMPTY(loc_cConta)
                    loc_cSQL = loc_cSQL + ;
                        "AND a.contas IN (SELECT DISTINCT ContaDs FROM SigOpFp " + ;
                        "WHERE EmiChqs = 1) "
                ELSE
                    loc_cSQL = loc_cSQL + "AND a.contas = " + EscaparSQL(loc_cConta) + " "
                ENDIF

                loc_cSQL = loc_cSQL + ;
                    "ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

                *-- Legado: If (SqlExecute(...) < 1) -> falha de conexao
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Falha ao selecionar os cheques do " + ;
                        "per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL()
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - PK Fortyus de SigCqChi eh cidchaves (char, ver
    * regra #22 do CLAUDE.md). Usado por RegistrarAuditoria() (BusinessBase)
    * no INSERT INTO LogAuditoria apos ExecutarExclusao().
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar() - o legado (SIGPRCHR.SCX) NAO grava nem altera
    * registros em SigCqChi: os cheques sao emitidos por outro modulo do
    * sistema (emissao de cheques). Esta tela apenas consulta cheques por
    * Grupo/Conta/Periodo (comportamento.json: Select .../CsSigCqChi, sem
    * nenhum Insert/Update em SigCqChi) e cancela fisicamente um documento
    * ja cancelado (Delete From SigCqChi Where cidchaves = ... no
    * cmdGok.Click legado, replicado em ExecutarExclusao() abaixo). O
    * comportamento padrao herdado de BusinessBase (recusar Inserir/
    * Atualizar) ja eh o correto para esta entidade neste form.
    *==========================================================================

    *==========================================================================
    * AntesDeExcluir - Replica o guard do legado antes do MessageBox de
    * confirmacao e do Delete: "If CsSigCqChi.ncancelas = 1 And
    * ThisForm.ExcluirCheque" (cmdGok.Click). So permite excluir um cheque
    * JA CANCELADO e quando o usuario tem o acesso ExcluirCheque
    * (fChecaAcesso('SIGPRCHR','EXCLUIRCHQ') calculado no Init).
    *==========================================================================
    PROTECTED PROCEDURE AntesDeExcluir()
        IF !THIS.this_lCancelas
            THIS.this_cMensagemErro = "Somente cheques CANCELADOS podem ser exclu" + CHR(237) + "dos."
            RETURN .F.
        ENDIF

        IF !THIS.this_lExcluirCheque
            THIS.this_cMensagemErro = "Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para excluir cheque cancelado."
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Delete From SigCqChi Where cidchaves = ... do
    * cmdGok.Click legado (exclusao fisica do cheque cancelado). Conexao
    * nasce em modo transacional manual (Transactions=2) - commit/rollback
    * explicitos.
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidchaves)
            THIS.this_cMensagemErro = "Cheque sem chave prim" + CHR(225) + "ria (cidchaves) para exclus" + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCqChi WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("EXCLUSAO")
                loc_lSucesso = .T.
            ELSE
                SQLROLLBACK(gnConnHandle)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o cheque cancelado:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            SQLROLLBACK(gnConnHandle)
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidos - Marca como emitidos (SQL Server + cursor de
    * trabalho) todos os cheques com nmarca1s = 1 no cursor informado.
    * Replica o "Update SigCqChi Set emitidos = 1 Where cidchaves = ..." dos
    * fluxos de impressao do legado (cmdImpchq/cmdchmat), um UPDATE por
    * cheque (cada cheque tem cidchaves proprio). Conexao em modo
    * transacional manual (Transactions=2) - commit/rollback explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidos(par_cCursor)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR nmarca1s = 1
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE cidchaves = " + EscaparSQL(cidchaves)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1, nmarca1s WITH 0
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequesComoEmitidosPorFaixa - Variante de MarcarChequesComoEmitidos
    * para o painel de impressao manual (cnt_4c_Impchmat/impchmat do legado):
    * marca como emitidos TODOS os cheques do cursor de trabalho que casam
    * com Banco + faixa de numero de cheque (nao pelo cidchaves de cada
    * linha marcada). Replica "Update SigCqChi Set emitidos = 1 Where bancos
    * = ... And ncheques = ..." do cmdimpri.Click legado, um UPDATE por
    * cheque da faixa. Conexao em modo transacional manual - commit/rollback
    * explicitos.
    *==========================================================================
    PROCEDURE MarcarChequesComoEmitidosPorFaixa(par_cCursor, par_cBanco, par_cChequeIni, par_cChequeFin)
        LOCAL loc_lSucesso, loc_lErro, loc_cSQL, loc_nResultado, loc_nRecno, loc_oErro

        loc_lSucesso = .F.

        IF VARTYPE(par_cCursor) = "C" AND USED(par_cCursor)
            loc_lErro  = .F.
            loc_nRecno = RECNO(par_cCursor)

            TRY
                SELECT (par_cCursor)
                SCAN FOR bancos = par_cBanco AND BETWEEN(ncheques, par_cChequeIni, par_cChequeFin) AND ncancelas = 0
                    loc_cSQL = "UPDATE SigCqChi SET emitidos = 1 WHERE bancos = " + EscaparSQL(bancos) + ;
                        " AND ncheques = " + EscaparSQL(ncheques)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_lErro = .T.
                        EXIT
                    ENDIF

                    REPLACE nemitidos WITH 1
                    SELECT (par_cCursor)
                ENDSCAN

                IF loc_lErro
                    SQLROLLBACK(gnConnHandle)
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel marcar o(s) cheque(s) como emitido(s):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    SQLCOMMIT(gnConnHandle)
                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                SQLROLLBACK(gnConnHandle)
                MsgErro(loc_oErro.Message, "Erro")
            ENDTRY

            IF USED(par_cCursor) AND BETWEEN(loc_nRecno, 1, RECCOUNT(par_cCursor))
                SELECT (par_cCursor)
                GOTO loc_nRecno
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta o cheque corrente (chamado por BusinessBase.Excluir
    * apos ExecutarExclusao() ter sucesso, e por NovoRegistro/CancelarEdicao).
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves  = ""
        THIS.this_cAgencias   = ""
        THIS.this_cBancos     = ""
        THIS.this_lCancelas   = .F.
        THIS.this_cContas     = ""
        THIS.this_dDatas      = {}
        THIS.this_cDopes      = ""
        THIS.this_lEmitidos   = .F.
        THIS.this_cEmps       = ""
        THIS.this_cFavorecido = ""
        THIS.this_cGrupos     = ""
        THIS.this_cNcheques   = ""
        THIS.this_cNcontas    = ""
        THIS.this_nNcopias    = 0
        THIS.this_nNemissoes  = 0
        THIS.this_nNumes      = 0
        THIS.this_nValors     = 0
        THIS.this_dVencs      = {}
        THIS.this_cVersos     = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_cJustCanc   = ""
        THIS.this_nImpVersos  = 0
    ENDPROC

ENDDEFINE
