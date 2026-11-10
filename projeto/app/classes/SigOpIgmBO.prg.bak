*==============================================================================
* SIGOPIGMBO.prg
*
* Business Object para SIGOPIGM (Impressao Global de Movimentacoes)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* chamado por outro form (poform) para autenticar/imprimir em lote um
* conjunto de movimentacoes de uma mesma Operacao (Dopes) que ainda nao
* foram impressas. O legado monta a chave composta
* EmpDnCrds = Emps + Dopes + Str(Numes,6) a partir dos parametros recebidos
* e consulta SigMvCab/SigCdOpe/SigOpCdc para popular um cursor local
* (csPgto) com uma linha por movimentacao a autenticar - o usuario marca
* (checkbox) quais quer processar e aciona Imprimir (documentos) ou Boleto
* (impressao de boleto bancario).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria;
* csPgto e um CURSOR local criado em memoria, nao uma tabela do SQL Server)
*
* SOMENTE LEITURA - por que Inserir()/Atualizar()/ExecutarExclusao() NAO sao
* sobrescritos aqui: todo acesso remoto do legado e Select. O unico
* "Insert Into" do dump tem por destino csPgto, que e CURSOR LOCAL
* (Create Cursor no Load), e o unico Replace tambem (csPgto.marca /
* csPgto.Printed). Nao ha TableUpdate nem .AddCursor em lugar nenhum do
* dump, isto e, nada volta para o banco. Escrever um INSERT/UPDATE aqui
* significaria INVENTAR a lista de colunas, o que a regra #22 do CLAUDE.md
* proibe (a lista vem do schema, nunca de adivinhacao). O comportamento
* padrao herdado de BusinessBase (recusar a operacao e reportar pelo
* ExibirFalha do Salvar) ja e o correto.
*
* Parametros recebidos do form chamador (Init legado: Parameters poform,
* _pEmps, _pDopes, _pNumes, _pChkImpDoc, _pBol), espelhados nas properties
* abaixo:
*   - this_cEmps           : _pEmps  - Codigo da Empresa
*   - this_cDopes          : _pDopes - Codigo da Operacao (= property
*     "movimentacao" do form legado, que recebe o MESMO valor de _pDopes)
*   - this_nNumes          : _pNumes - Numero da Movimentacao de origem
*   - this_lChkImpDoc      : _pChkImpDoc - repassado para SigPrIdc/SigReIfx
*     na impressao de documentos (controla se confirma impressao por doc)
*   - this_nBoleto         : _pBol - Tipo/flag de boleto (Iif(Type=N,
*     valor, 0) no legado - Boleto > 0 troca o Caption do form para
*     "Impressao Global de Boletos")
*
* poForm (referencia ao form chamador) e oModem (ThisForm.Parentform.
* oModemEest, repassado para SigPrIdc) NAO entram neste BO - mesma decisao
* arquitetural de SigOpIboBO.prg/SigOpCtdBO.prg ("ONDE FICA O poForm"):
* guardar referencia a objeto de UI aqui fecharia um ciclo de referencias.
* Ficam no Form, e o unico metodo deste BO que precisa do form
* (ImprimirDocumentoDaLinha, por causa do 12o argumento do SigPrIdc
* legado) recebe a referencia como PARAMETRO.
*
* CHAVE POSICIONAL (regra CLAUDE.md #42) - MontarChaveEmpDnCrds monta
* lcEDN = Emps + Dopes + Str(Numes,6) com PADR EXPLICITO nas partes:
*   SigMvCab.emps      char(3)
*   SigMvCab.dopes     char(20)
*   Str(numes, 6)           6
*   ------------------------------
*   SigMvCab.empdncrds char(29)   <- a soma 3+20+6 = 29 PROVA a montagem
* O padding FAZ PARTE da chave: ALLTRIM em qualquer parte INTERIOR encurta
* a chave, ela nunca casa, o SELECT roda SEM ERRO e devolve ZERO linhas - e
* a grade aparece vazia sem nenhuma mensagem.
*
* Divisao de responsabilidade com o Form (o Form chama, o BO decide):
*   CriarCursorMovimentacoes()      Create Cursor csPgto do Load legado
*   MontarChaveEmpDnCrds()          lcEDN posicional
*   CarregarMovimentacoes()         Select + Scan/Insert do Init legado
*   CarregarConfiguracaoOperacao()  os CursorQuery de SigOpCdc/SigCdOpe/SigOpCdd
*   DeveExibirBotaoBoleto()         Inlist(crSigOpCdc.VenBols, 1, 3)
*   ResolverTipoBoleto()            o Do Case inteiro do btnBoleto.Click
*   CarregarDoCursor()              linha corrente da grade -> properties
*   ContarMarcadas()                quantas linhas o usuario marcou
*   ImprimirDocumentoDaLinha()      Do SigPrIdc with ... (Docus = 1)
*   MarcarLinhaComoImpressa()       Replace marca .F., Printed .T.
* As duas aberturas de form filho do legado (Do Form SigReIfx, quando
* Docus esta em (3,4), e Do Form SigOpIbo, no botao Boleto) ficam no Form,
* que e quem tem a referencia ao form chamador que elas exigem.
*==============================================================================

DEFINE CLASS SigOpIgmBO AS BusinessBase

    *-- Nome do cursor local da grade (csPgto no legado). Property para o
    *-- Form nao repetir string literal.
    this_cCursorGrade = "cursor_4c_Pgto"

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPIGM)
    this_cEmps = ""                && _pEmps - Codigo da Empresa
    this_cDopes = ""               && _pDopes - Codigo da Operacao (= "movimentacao" do legado)
    this_nNumes = 0                && _pNumes - Numero da Movimentacao de origem
    this_lChkImpDoc = .F.          && _pChkImpDoc - repassado a SigPrIdc/SigReIfx
    this_nBoleto = 0               && _pBol - Tipo/flag de boleto (Boleto > 0 muda o Caption)

    *-- Derivados de consulta SQL
    this_cChaveEmpDnCrds = ""      && lcEDN - Emps + Dopes + Str(Numes,6) (chave posicional)
    this_lExibirBotaoBoleto = .F.  && Inlist(crSigOpCdc.VenBols, 1, 3)
    this_nQtdMovimentacoes = 0     && Reccount() do cursor da grade apos a carga

    *-- Linha CORRENTE da grade (csPgto), carregada por CarregarDoCursor.
    *-- Nomes com o infixo "Linha" para nao colidir com os parametros acima:
    *-- os parametros sao a movimentacao de ORIGEM (que monta a chave), estas
    *-- sao a movimentacao da linha selecionada (que sera impressa).
    this_lLinhaMarca = .F.         && csPgto.Marca   - checkbox da coluna 1
    this_cLinhaObs = ""            && csPgto.Obs     - Dopes + " " + Str(Numes,6)
    this_lLinhaPrinted = .F.       && csPgto.Printed - linha ja processada
    this_nLinhaValos = 0           && csPgto.Valos
    this_cLinhaEmps = ""           && csPgto.Emps
    this_cLinhaDopes = ""          && csPgto.Dopes
    this_nLinhaNumes = 0           && csPgto.Numes
    this_nLinhaValdevs = 0         && csPgto.Valdevs
    this_nLinhaDocus = 0           && csPgto.Docus - 1 = SigPrIdc, 3 ou 4 = SigReIfx

    *-- Configuracao da Operacao (SigOpCdc), carregada por
    *-- CarregarConfiguracaoOperacao. Todas as colunas sao numeric no schema.
    this_nVenBols = 0              && SigOpCdc.venbols   numeric(1,0)
    this_nQtdDocs = 0              && SigOpCdc.qtddocs   numeric(2,0)
    this_nTpImpDocs = 0            && SigOpCdc.tpimpdocs numeric(1,0)
    this_nBolItes = 0              && SigOpCdc.bolites   numeric(2,0)
    this_nQvias = 0                && SigOpCdc.qvias     numeric(6,0)
    this_nQtdBols = 0              && SigOpCdc.qtdbols   numeric(2,0)

    *-- SigCdOpe.docus da Operacao (o CursorQuery('SigCdOpe', ...) que o
    *-- Imprimir.Click legado faz antes do SigPrIdc)
    this_nDocusOperacao = 0        && SigCdOpe.docus numeric(2,0)

    *-- SigOpCdd.configgers char(250) - o 1o Case do btnBoleto.Click le
    *-- Substr(ConfigGers, 233, 2)
    this_cConfigGers = ""          && SigOpCdd.configgers char(250)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_cEmps = ""
        THIS.this_cDopes = ""
        THIS.this_nNumes = 0
        THIS.this_lChkImpDoc = .F.
        THIS.this_nBoleto = 0

        THIS.this_cChaveEmpDnCrds = ""
        THIS.this_lExibirBotaoBoleto = .F.
        THIS.this_nQtdMovimentacoes = 0

        THIS.LimparLinha()
        THIS.LimparConfiguracaoOperacao()

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirParametros - Recebe os cinco parametros de dados do Init
    * legado, na MESMA ORDEM (Parameters poform, _pEmps, _pDopes, _pNumes,
    * _pChkImpDoc, _pBol - poform fica no Form, ver cabecalho).
    *
    * As guardas de tipo reproduzem o legado: ele so testa o tipo de _pBol
    * (Iif(Type([_pBol])=[N], _pBol, 0)) porque e o unico parametro que o
    * chamador costuma omitir. Aqui todos tem guarda, para o harness de
    * teste poder instanciar o BO sem argumento nenhum.
    *
    * NAO usar ALLTRIM nas partes da chave: elas sao gravadas com o padding
    * das colunas char (ver CHAVE POSICIONAL no cabecalho). O PADR fica em
    * MontarChaveEmpDnCrds, que e quem conhece as larguras do schema.
    *====================================================================
    PROCEDURE DefinirParametros(par_cEmps, par_cDopes, par_nNumes, ;
            par_lChkImpDoc, par_nBol)

        THIS.this_cEmps      = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        THIS.this_cDopes     = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_nNumes     = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
        THIS.this_lChkImpDoc = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)
        THIS.this_nBoleto    = IIF(VARTYPE(par_nBol) = "N", par_nBol, 0)

        THIS.this_cChaveEmpDnCrds = THIS.MontarChaveEmpDnCrds(THIS.this_cEmps, ;
            THIS.this_cDopes, THIS.this_nNumes)

        RETURN .T.
    ENDPROC

    *====================================================================
    * MontarChaveEmpDnCrds - lcEDN = _pEmps + _pDopes + Str(_pNumes,6)
    *
    * Legado (Init): lcEDN = _pEmps + _pDopes + Str(_pNumes,6)
    *
    * Chave POSICIONAL (regra CLAUDE.md #42): o padding das colunas char
    * FAZ PARTE da chave, por isso PADR EXPLICITO com a largura do schema
    * em vez de confiar no padding que a variavel por acaso trouxe. A soma
    * 3 + 20 + 6 = 29 e exatamente SigMvCab.empdncrds char(29) - e essa
    * conta que confere a montagem.
    *
    * ALLTRIM em qualquer parte INTERIOR produz uma chave curta que nunca
    * casa: o SELECT roda SEM ERRO e devolve ZERO linhas, a grade fica
    * vazia e nada aparece no log.
    *====================================================================
    PROCEDURE MontarChaveEmpDnCrds(par_cEmps, par_cDopes, par_nNumes)
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes

        loc_cEmps  = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

        RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
    ENDPROC

    *====================================================================
    * CriarCursorMovimentacoes - Create Cursor csPgto do PROCEDURE Load
    * legado, com a MESMA ORDEM e os MESMOS tipos de campo:
    *
    *   Create Cursor csPgto (Marca L, Obs C(27), Printed L, Valos n(12,2),
    *       Emps c(3), Dopes c(20), Numes n(6), Valdevs n(12,2), Docus n(1))
    *
    * A ordem dos campos e a MESMA em todos os lugares que criam o cursor
    * (aqui e so neste metodo), e os nomes sao exatamente os que o Grid usa
    * em ControlSource (csPgto.marca / csPgto.Obs / csPgto.Valos).
    *
    * Obs C(27) = dopes char(20) + 1 espaco + Str(numes,6) = 27 - a largura
    * do campo CONFERE a montagem do texto feita em CarregarMovimentacoes.
    *
    * CREATE CURSOR nasce READWRITE e com Buffering = 1, que e o que a
    * coluna de checkbox da grade precisa para aceitar o REPLACE (o cursor
    * NUNCA vem de SQLEXEC direto, justamente por isso).
    *
    * Idempotente: se o cursor ja existe, apenas esvazia. Recriar fecharia
    * o alias e ZERARIA o ColumnCount do Grid ligado a ele.
    *
    * O ZAP vai cercado de SET SAFETY OFF porque SET SAFETY e ESCOPADO POR
    * DATA SESSION: num form com DataSession = 2 ele vale ON mesmo depois
    * do SET SAFETY OFF do main.prg, e o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" que CONGELA a tela esperando um clique que
    * ninguem ve (num teste headless isso aparece como timeout sem erro).
    *====================================================================
    PROCEDURE CriarCursorMovimentacoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSafety

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF
            ELSE
                CREATE CURSOR (THIS.this_cCursorGrade) ( ;
                    Marca L, ;
                    Obs C(27), ;
                    Printed L, ;
                    Valos N(12,2), ;
                    Emps C(3), ;
                    Dopes C(20), ;
                    Numes N(6), ;
                    Valdevs N(12,2), ;
                    Docus N(1))
            ENDIF

            loc_lSucesso = USED(THIS.this_cCursorGrade)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel criar o cursor da grade:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarMovimentacoes - Select + Scan/Insert do Init legado
    *
    * Legado (Init):
    *   lcSql = [Select a.Emps, a.Dopes, a.Numes, a.EmpDopNums, a.Valos,
    *            a.ValDevs, b.Docus, c.VenBols ]
    *         + [From SigMvCab a, SigCdOpe b, SigOpCdc c ]
    *         + [Where EmpDnCrds = ']+lcEDN+[' And a.Dopes = b.Dopes
    *            And a.Dopes = c.Dopes And b.Docus in(1,3,4)]
    *   If ...Sqlexecute(lcSql,'CrTprMvCab') > 0
    *       Select CrTprMvCab
    *       Scan
    *           Scatter Memvar
    *           m.Obs   = CrTprMvCab.dopes+' '+Str(CrTprMvCab.Numes,6)
    *           m.Marca = .t.
    *           Printed = .f.
    *           Insert into csPgto from Memvar
    *       EndScan
    *   EndIf
    *   Select csPgto / Go Top / If Reccount() = 0 ... Return .F.
    *
    * EmpDnCrds fica QUALIFICADO com o alias "a" (so SigMvCab tem essa
    * coluna entre as tres tabelas - conferido no schema canonico), o que
    * e a mesma semantica do legado sem depender de resolucao implicita.
    *
    * O Scatter Memvar do legado traz EmpDopNums e VenBols, que csPgto NAO
    * tem - o Insert From Memvar simplesmente os ignora. Aqui as colunas do
    * INSERT sao explicitas, por isso as duas ficam de fora (VenBols e lido
    * de SigOpCdc em CarregarConfiguracaoOperacao, que e de onde a
    * visibilidade do botao Boleto depende de verdade).
    *
    * "Printed = .f." no legado cria uma variavel privada (Scatter Memvar
    * nao a declara, porque CrTprMvCab nao tem essa coluna) que o Insert
    * From Memvar casa pelo nome com o campo Printed de csPgto - ou seja,
    * toda linha nasce NAO impressa. Aqui isso e o literal .F. no INSERT.
    *
    * SQLEXEC vai para cursor TEMPORARIO e o cursor da grade e recarregado
    * com ZAP + INSERT: SQLEXEC sobre o alias ligado ao Grid FECHA e RECRIA
    * o alias, e o Grid cai para ColumnCount = 0 (retangulo branco sem
    * cabecalho, sem erro e sem log).
    *
    * Retorna .F. quando nada foi encontrado - o legado faz
    * "If Reccount() = 0 / ThisForm.Release / Return .F.", isto e, o
    * dialogo nem abre. Quem decide fechar e o Form; aqui so informamos.
    *====================================================================
    PROCEDURE CarregarMovimentacoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        LOCAL loc_cChave, loc_cCursorTmp

        loc_lSucesso   = .F.
        loc_cCursorTmp = "cursor_4c_TprMvCab"
        THIS.this_nQtdMovimentacoes = 0

        TRY
            loc_cChave = THIS.MontarChaveEmpDnCrds(THIS.this_cEmps, ;
                THIS.this_cDopes, THIS.this_nNumes)
            THIS.this_cChaveEmpDnCrds = loc_cChave

            IF !THIS.CriarCursorMovimentacoes()
                THIS.this_cMensagemErro = "Cursor da grade indispon" + CHR(237) + "vel."
            ELSE
                IF USED(loc_cCursorTmp)
                    USE IN (loc_cCursorTmp)
                ENDIF

                loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.ValDevs, b.Docus, c.VenBols " + ;
                           "FROM SigMvCab a, SigCdOpe b, SigOpCdc c " + ;
                           "WHERE a.EmpDnCrds = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND a.Dopes = b.Dopes " + ;
                           "AND a.Dopes = c.Dopes " + ;
                           "AND b.Docus IN (1, 3, 4)"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTmp)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao buscar as movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    SELECT (loc_cCursorTmp)
                    SCAN
                        INSERT INTO (THIS.this_cCursorGrade) ;
                            (Marca, Obs, Printed, Valos, Emps, Dopes, Numes, Valdevs, Docus) ;
                            VALUES ( ;
                                .T., ;
                                PADR(THIS.LerColunaTexto(loc_cCursorTmp, "Dopes"), 20) + " " + ;
                                    STR(THIS.LerColunaNumerica(loc_cCursorTmp, "Numes"), 6), ;
                                .F., ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Valos"), ;
                                THIS.LerColunaTexto(loc_cCursorTmp, "Emps"), ;
                                THIS.LerColunaTexto(loc_cCursorTmp, "Dopes"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Numes"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "ValDevs"), ;
                                THIS.LerColunaNumerica(loc_cCursorTmp, "Docus"))
                    ENDSCAN

                    IF USED(loc_cCursorTmp)
                        USE IN (loc_cCursorTmp)
                    ENDIF

                    SELECT (THIS.this_cCursorGrade)
                    GO TOP

                    *-- RECCOUNT conta registro marcado para exclusao; aqui o
                    *-- cursor acabou de ser esvaziado com ZAP, entao nao ha
                    *-- nenhum. A contagem usada para decidir "abre ou nao
                    *-- abre" e a mesma do legado (Reccount()).
                    THIS.this_nQtdMovimentacoes = RECCOUNT(THIS.this_cCursorGrade)

                    IF THIS.this_nQtdMovimentacoes = 0
                        THIS.this_cMensagemErro = "N" + CHR(227) + "o existem movimenta" + ;
                            CHR(231) + CHR(245) + "es a serem autenticadas"
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarMovimentacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarConfiguracaoOperacao - os CursorQuery que o legado faz por
    * Dopes, reunidos num metodo so.
    *
    * Legado (Init):
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    * Legado (Imprimir.Click, por linha do Scan):
    *   =...cursorquery('SigCdOpe','CrSigCdOpe','dopes', <Dopes da linha>)
    *   =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes', <Dopes da linha>)
    * Legado (btnBoleto.Click, por linha do Scan):
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    *   + Substr(crSigOpCdd.ConfigGers,233,2)
    *
    * crSigOpCdd NAO e carregado por nenhum CursorQuery do SIGOPIGM - no
    * Fortyus ele vinha pre-aberto pelo form chamador. No sistema novo nada
    * pre-abre cursor global, entao SigOpCdd entra aqui, filtrado pelo
    * MESMO Dopes (regra CLAUDE.md #27: funcao/cursor global do legado que
    * nao existe mais tem de ser reproduzido, nunca ignorado - senao o 1o
    * Case do Do Case do boleto nunca e avaliado e o tipo de boleto sai
    * errado em silencio).
    *
    * Comparacao de char no SQL Server e com blank-padding ANSI, por isso o
    * ALLTRIM aqui e inofensivo - diferente das PARTES de uma chave
    * posicional concatenada (regra #42), que nunca podem ser trimadas.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cDopes, loc_cSQL, loc_nResultado, loc_oErro
        LOCAL loc_cCurCdc, loc_cCurOpe, loc_cCurCdd

        loc_lSucesso = .F.
        loc_cCurCdc  = "cursor_4c_SigOpCdc"
        loc_cCurOpe  = "cursor_4c_SigCdOpe"
        loc_cCurCdd  = "cursor_4c_SigOpCdd"

        loc_cDopes = IIF(VARTYPE(par_cDopes) = "C" AND !EMPTY(par_cDopes), ;
            par_cDopes, THIS.this_cDopes)

        THIS.LimparConfiguracaoOperacao()

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco indispon" + ;
                    CHR(237) + "vel."
            ELSE
                *-- SigOpCdc: VenBols / QtdDocs / TpImpDocs / BolItes / Qvias / QtdBols
                IF USED(loc_cCurCdc)
                    USE IN (loc_cCurCdc)
                ENDIF
                loc_cSQL = "SELECT * FROM SigOpCdc " + ;
                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurCdc)

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Erro ao ler a configura" + CHR(231) + CHR(227) + "o da opera" + ;
                        CHR(231) + CHR(227) + "o (SigOpCdc):" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
                ELSE
                    IF RECCOUNT(loc_cCurCdc) > 0
                        SELECT (loc_cCurCdc)
                        GO TOP
                        THIS.this_nVenBols   = THIS.LerColunaNumerica(loc_cCurCdc, "VenBols")
                        THIS.this_nQtdDocs   = THIS.LerColunaNumerica(loc_cCurCdc, "QtdDocs")
                        THIS.this_nTpImpDocs = THIS.LerColunaNumerica(loc_cCurCdc, "TpImpDocs")
                        THIS.this_nBolItes   = THIS.LerColunaNumerica(loc_cCurCdc, "BolItes")
                        THIS.this_nQvias     = THIS.LerColunaNumerica(loc_cCurCdc, "Qvias")
                        THIS.this_nQtdBols   = THIS.LerColunaNumerica(loc_cCurCdc, "QtdBols")
                    ENDIF

                    *-- SigCdOpe: Docus (o cursorquery do Imprimir.Click legado)
                    IF USED(loc_cCurOpe)
                        USE IN (loc_cCurOpe)
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigCdOpe " + ;
                               "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurOpe)

                    IF loc_nResultado >= 0 AND RECCOUNT(loc_cCurOpe) > 0
                        SELECT (loc_cCurOpe)
                        GO TOP
                        THIS.this_nDocusOperacao = THIS.LerColunaNumerica(loc_cCurOpe, "Docus")
                    ENDIF

                    *-- SigOpCdd: ConfigGers (Substr(...,233,2) do Do Case do boleto)
                    IF USED(loc_cCurCdd)
                        USE IN (loc_cCurCdd)
                    ENDIF
                    loc_cSQL = "SELECT * FROM SigOpCdd " + ;
                               "WHERE Dopes = " + EscaparSQL(ALLTRIM(loc_cDopes))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCurCdd)

                    IF loc_nResultado >= 0 AND RECCOUNT(loc_cCurCdd) > 0
                        SELECT (loc_cCurCdd)
                        GO TOP
                        THIS.this_cConfigGers = THIS.LerColunaTexto(loc_cCurCdd, "ConfigGers")
                    ENDIF

                    THIS.this_lExibirBotaoBoleto = THIS.DeveExibirBotaoBoleto()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarConfiguracaoOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LerColunaNumerica - Le coluna numerica de cursor por NOME, tolerando
    * os tipos com que o driver ODBC entrega a mesma coluna.
    *
    * Coluna numeric(1,0) do SQL Server chega ora como Numerico, ora como
    * Logico (.T./.F.) conforme o driver - comparar Logico com 1 estoura
    * "Operator/operand type mismatch". Por isso o VARTYPE vem ANTES da
    * comparacao (regra CLAUDE.md #13).
    *
    * Acesso ao campo por EVALUATE (LEITURA): o nome do cursor e do campo
    * vem em variavel, e "campo" nao e sintaxe valida em VFP9.
    * TYPE() - nunca PEMSTATUS, que exige OBJETO no 1o argumento - confere
    * se a coluna existe antes de ler.
    *====================================================================
    PROTECTED PROCEDURE LerColunaNumerica(par_cCursor, par_cColuna)
        LOCAL loc_nValor, loc_uBruto, loc_cExpr

        loc_nValor = 0
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            DO CASE
                CASE ISNULL(loc_uBruto)
                    loc_nValor = 0
                CASE VARTYPE(loc_uBruto) = "N"
                    loc_nValor = loc_uBruto
                CASE VARTYPE(loc_uBruto) = "L"
                    loc_nValor = IIF(loc_uBruto, 1, 0)
                CASE VARTYPE(loc_uBruto) = "C"
                    loc_nValor = VAL(loc_uBruto)
                OTHERWISE
                    loc_nValor = 0
            ENDCASE
        ENDIF

        RETURN loc_nValor
    ENDPROC

    *====================================================================
    * LerColunaTexto - Le coluna CHAR de cursor por NOME, com guarda de
    * NULL e de tipo. O valor volta CRU (sem ALLTRIM): Emps e Dopes sao
    * partes de chave posicional e o padding tem de sobreviver.
    *====================================================================
    PROTECTED PROCEDURE LerColunaTexto(par_cCursor, par_cColuna)
        LOCAL loc_cValor, loc_uBruto, loc_cExpr

        loc_cValor = ""
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            IF !ISNULL(loc_uBruto) AND VARTYPE(loc_uBruto) = "C"
                loc_cValor = loc_uBruto
            ENDIF
        ENDIF

        RETURN loc_cValor
    ENDPROC

    *====================================================================
    * LerColunaLogica - Le coluna LOGICA de cursor por NOME. Marca e
    * Printed sao L no Create Cursor legado, mas a mesma leitura serve se
    * a coluna chegar Numerica (0/1) ou "S"/"N".
    *====================================================================
    PROTECTED PROCEDURE LerColunaLogica(par_cCursor, par_cColuna)
        LOCAL loc_lValor, loc_uBruto, loc_cExpr

        loc_lValor = .F.
        loc_cExpr  = par_cCursor + "." + par_cColuna

        IF USED(par_cCursor) AND TYPE(loc_cExpr) != "U"
            loc_uBruto = EVALUATE(loc_cExpr)

            DO CASE
                CASE ISNULL(loc_uBruto)
                    loc_lValor = .F.
                CASE VARTYPE(loc_uBruto) = "L"
                    loc_lValor = loc_uBruto
                CASE VARTYPE(loc_uBruto) = "N"
                    loc_lValor = (loc_uBruto != 0)
                CASE VARTYPE(loc_uBruto) = "C"
                    loc_lValor = INLIST(UPPER(LEFT(ALLTRIM(loc_uBruto), 1)), "S", "1", "T", "Y")
                OTHERWISE
                    loc_lValor = .F.
            ENDCASE
        ENDIF

        RETURN loc_lValor
    ENDPROC

    *====================================================================
    * DeveExibirBotaoBoleto - Inlist(crSigOpCdc.VenBols, 1, 3)
    *
    * Legado (Init):
    *   ThisForm.btnBoleto.Visible = Inlist(crSigOpCdc.VenBols, 1, 3)
    *
    * Depende de CarregarConfiguracaoOperacao ter rodado (ela alimenta
    * this_nVenBols). Sem configuracao lida, VenBols fica 0 e o botao nao
    * aparece - mesmo resultado pratico do legado quando o CursorQuery nao
    * acha a Operacao.
    *====================================================================
    PROCEDURE DeveExibirBotaoBoleto()
        RETURN INLIST(THIS.this_nVenBols, 1, 3)
    ENDPROC

    *====================================================================
    * ResolverTipoBoleto - o Do Case INTEIRO do btnBoleto.Click legado
    *
    * Legado (btnBoleto.Click, dentro do Scan):
    *   lnTpB = 0
    *   =...CursorQuery('SigOpCdc','crSigOpCdc','Dopes',ThisForm.Movimentacao)
    *   Do Case
    *       Case !EMPTY(substr(crSigOpCdd.ConfigGers,233,2))
    *           lnTpB = VAL(substr(crSigOpCdd.ConfigGers,233,2))
    *       Case (crSigOpCdc.BolItes = 3) && SubNiveis
    *           lnTpB = 11
    *       Case (crSigOpCdc.BolItes = 4) && Detalhado
    *           lnTpB = 13
    *       Case (crSigOpCdc.BolItes = 5) && Romaneio
    *           lnTpB = 14
    *       Case (crSigOpCdc.BolItes = 7) && Controle Interno
    *           lnTpB = 17
    *       Case (crSigOpCdc.BolItes = 6) && Vendedor
    *           lnTpB = 16
    *       Case (crSigOpCdc.BolItes = 8) && Duplicata/Carne
    *           lnTpB = 18
    *       Otherwise && Sim / Nao
    *           lnTpB = 3
    *   EndCase
    *
    * TRANSCRITO, nao reescrito (regra CLAUDE.md #17): a ORDEM dos Case e
    * regra de negocio - o ConfigGers tem precedencia sobre BolItes, e os
    * valores 7 e 6 aparecem nessa ordem invertida no legado, o que nao
    * muda o resultado mas se mantem para a comparacao ficar linha a linha.
    * Os numeros (11, 13, 14, 17, 16, 18, 3) sao os tipos de boleto que
    * SigOpIbo espera e NAO se renumeram.
    *
    * Substr(ConfigGers, 233, 2) sobre char(250) le as posicoes 233-234.
    * A guarda de tipo e de tamanho esta aqui porque this_cConfigGers fica
    * "" quando SigOpCdd nao tem linha para a Operacao - e no legado isso
    * seria um erro de alias, nao um Case verdadeiro.
    *====================================================================
    PROCEDURE ResolverTipoBoleto()
        LOCAL loc_nTpB, loc_cConfig

        loc_nTpB = 0

        loc_cConfig = ""
        IF VARTYPE(THIS.this_cConfigGers) = "C" AND LEN(THIS.this_cConfigGers) >= 234
            loc_cConfig = SUBSTR(THIS.this_cConfigGers, 233, 2)
        ENDIF

        DO CASE
            CASE !EMPTY(loc_cConfig)
                loc_nTpB = VAL(loc_cConfig)

            CASE THIS.this_nBolItes = 3      && SubNiveis
                loc_nTpB = 11

            CASE THIS.this_nBolItes = 4      && Detalhado
                loc_nTpB = 13

            CASE THIS.this_nBolItes = 5      && Romaneio
                loc_nTpB = 14

            CASE THIS.this_nBolItes = 7      && Controle Interno
                loc_nTpB = 17

            CASE THIS.this_nBolItes = 6      && Vendedor
                loc_nTpB = 16

            CASE THIS.this_nBolItes = 8      && Duplicata/Carne
                loc_nTpB = 18

            OTHERWISE                        && Sim / Nao
                loc_nTpB = 3
        ENDCASE

        RETURN loc_nTpB
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega a linha CORRENTE do cursor da grade
    * (csPgto) para as properties this_*Linha*.
    *
    * Padrao obrigatorio: SELECT (par_cAliasCursor) ANTES de acessar
    * campos - "campo" NAO e sintaxe valida em VFP9.
    *
    * Guarda de EOF/BOF: cursor sem linha posicionada devolve .F. em vez de
    * ler lixo.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorGrade)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + ;
                CHR(225) + " aberto."
        ELSE
            TRY
                *-- CRITICO: SELECT antes de acessar campos
                SELECT (loc_cAlias)

                IF EOF() OR RECCOUNT() = 0
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada na grade."
                    THIS.LimparLinha()
                ELSE
                    THIS.this_lLinhaMarca   = THIS.LerColunaLogica(loc_cAlias, "Marca")
                    THIS.this_lLinhaPrinted = THIS.LerColunaLogica(loc_cAlias, "Printed")
                    THIS.this_nLinhaValos   = THIS.LerColunaNumerica(loc_cAlias, "Valos")
                    THIS.this_nLinhaNumes   = THIS.LerColunaNumerica(loc_cAlias, "Numes")
                    THIS.this_nLinhaValdevs = THIS.LerColunaNumerica(loc_cAlias, "Valdevs")
                    THIS.this_nLinhaDocus   = THIS.LerColunaNumerica(loc_cAlias, "Docus")
                    THIS.this_cLinhaObs     = THIS.LerColunaTexto(loc_cAlias, "Obs")
                    THIS.this_cLinhaEmps    = THIS.LerColunaTexto(loc_cAlias, "Emps")
                    THIS.this_cLinhaDopes   = THIS.LerColunaTexto(loc_cAlias, "Dopes")

                    loc_lSucesso = .T.
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ContarMarcadas - Quantas linhas o usuario marcou no checkbox.
    *
    * O legado nao conta: ele so faz Scan / If csPgto.marca. A contagem
    * existe aqui para o Form poder avisar antes de comecar um lote vazio,
    * e e feita com COUNT FOR, que ignora registro marcado para exclusao -
    * ao contrario de RECCOUNT.
    *
    * COUNT move o ponteiro, por isso o RECNO e salvo e reposto: a linha
    * corrente da grade nao pode mudar so porque alguem contou.
    *====================================================================
    PROCEDURE ContarMarcadas()
        LOCAL loc_nTotal, loc_nRecno, loc_oErro

        loc_nTotal = 0

        IF USED(THIS.this_cCursorGrade)
            TRY
                SELECT (THIS.this_cCursorGrade)
                loc_nRecno = RECNO()

                COUNT FOR Marca TO loc_nTotal

                IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT()
                    GO loc_nRecno
                ELSE
                    GO TOP
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message, "Erro em ContarMarcadas")
                loc_nTotal = 0
            ENDTRY
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *====================================================================
    * ImprimirDocumentoDaLinha - Do SigPrIdc with ... do Imprimir.Click
    *
    * Legado (Imprimir.Click, dentro do Scan, quando CsPgto.docus = 1):
    *   =...cursorquery('SigCdOpe','CrSigCdOpe','dopes',TprMvCab.Dopes)
    *   =...CursorQuery('SigOpCdc','CrSigOpCdc','Dopes',TprMvCab.Dopes)
    *   DO SigPrIdc with CsPgto.Emps, CsPgto.Dopes, CsPgto.Numes,
    *       CsPgto.valdevs, crSigOpCdc.QtdDocs, .F., .F., .F., .F.,
    *       crSigOpCdc.TpImpDocs, .F., Thisform, ThisForm.pChkImpDoc
    *
    * DIVERGENCIA DELIBERADA, de UMA coisa so: os dois CursorQuery do
    * legado filtram por "TprMvCab.Dopes", e TprMvCab NAO EXISTE - o
    * cursor da consulta do Init chama-se CrTprMvCab. No Fortyus essa
    * linha so nao derruba a tela quando o form chamador por acaso tem um
    * alias TprMvCab aberto. Aqui o filtro usa o Dopes da LINHA que esta
    * sendo processada (this_cLinhaDopes), que e o valor que aquela
    * expressao pretendia alcancar - o proprio Scan e sobre csPgto, e
    * csPgto.Dopes veio de CrTprMvCab.Dopes da mesma linha. Reproduzir o
    * defeito seria reproduzir um erro de alias, nao um comportamento.
    *
    * SigPrIdc e PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
    * veio no acervo (regra CLAUDE.md #27) - nao ha fonte para reproduzir o
    * layout do documento. A chamada fica dentro de TRY/CATCH que exibe a
    * falha com MsgErro (regra #9, CATCH nunca silencioso): a ausencia fica
    * VISIVEL ao usuario, em vez de um stub que finge imprimir. Mesmo
    * tratamento que SigOpIboBO.ExecutarImpressao da ao Do SigBlBol.
    *
    * par_oForm e o 12o argumento do legado (Thisform). Vem como PARAMETRO
    * porque o BO nao guarda referencia a objeto de UI (ver cabecalho).
    *====================================================================
    PROCEDURE ImprimirDocumentoDaLinha(par_oForm)
        LOCAL loc_lSucesso, loc_oErro, loc_oForm

        loc_lSucesso = .F.
        loc_oForm = IIF(PCOUNT() >= 1 AND VARTYPE(par_oForm) = "O", par_oForm, .NULL.)

        *-- Recarrega SigCdOpe/SigOpCdc pelo Dopes DESTA linha, como os dois
        *-- cursorquery que o legado faz imediatamente antes do SigPrIdc
        THIS.CarregarConfiguracaoOperacao(THIS.this_cLinhaDopes)

        TRY
            DO SigPrIdc WITH THIS.this_cLinhaEmps, THIS.this_cLinhaDopes, ;
                THIS.this_nLinhaNumes, THIS.this_nLinhaValdevs, ;
                THIS.this_nQtdDocs, .F., .F., .F., .F., ;
                THIS.this_nTpImpDocs, .F., loc_oForm, THIS.this_lChkImpDoc
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel imprimir o documento da movimenta" + ;
                CHR(231) + CHR(227) + "o " + ALLTRIM(THIS.this_cLinhaObs) + ":" + CHR(13) + ;
                loc_oErro.Message, "Erro ao Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MarcarLinhaComoImpressa - Replace do fim do Scan do Imprimir.Click
    *
    * Legado (Imprimir.Click):
    *   Select csPgto
    *   Replace csPgto.marca with .f., csPgto.Printed with .t.
    *
    * Desmarca a linha e registra que ela ja foi processada - e o que faz o
    * Click do checkbox legado ("if !(csPgto.printed) / This.value = .t.")
    * deixar de marca-la outra vez.
    *
    * O cursor da grade vem de CREATE CURSOR, que nasce READWRITE: por isso
    * o REPLACE funciona. Cursor de SQLEXEC direto seria SOMENTE-LEITURA e
    * a celula nunca entraria em edicao.
    *====================================================================
    PROCEDURE MarcarLinhaComoImpressa()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorGrade)
            THIS.this_cMensagemErro = "Cursor da grade n" + CHR(227) + "o est" + CHR(225) + " aberto."
        ELSE
            TRY
                SELECT (THIS.this_cCursorGrade)

                IF !EOF() AND RECCOUNT() > 0
                    REPLACE Marca WITH .F., Printed WITH .T.
                    THIS.this_lLinhaMarca   = .F.
                    THIS.this_lLinhaPrinted = .T.
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada na grade."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message, "Erro em MarcarLinhaComoImpressa")
                loc_lSucesso = .F.
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparLinha - Zera as properties da linha corrente da grade
    *====================================================================
    PROCEDURE LimparLinha()
        THIS.this_lLinhaMarca   = .F.
        THIS.this_cLinhaObs     = ""
        THIS.this_lLinhaPrinted = .F.
        THIS.this_nLinhaValos   = 0
        THIS.this_cLinhaEmps    = ""
        THIS.this_cLinhaDopes   = ""
        THIS.this_nLinhaNumes   = 0
        THIS.this_nLinhaValdevs = 0
        THIS.this_nLinhaDocus   = 0

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparConfiguracaoOperacao - Zera as properties lidas de
    * SigOpCdc/SigCdOpe/SigOpCdd
    *====================================================================
    PROCEDURE LimparConfiguracaoOperacao()
        THIS.this_nVenBols       = 0
        THIS.this_nQtdDocs       = 0
        THIS.this_nTpImpDocs     = 0
        THIS.this_nBolItes       = 0
        THIS.this_nQvias         = 0
        THIS.this_nQtdBols       = 0
        THIS.this_nDocusOperacao = 0
        THIS.this_cConfigGers    = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * LimparDados - Hook de BusinessBase: zera tudo o que a tela mostra
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cChaveEmpDnCrds = ""
        THIS.this_lExibirBotaoBoleto = .F.
        THIS.this_nQtdMovimentacoes = 0

        THIS.LimparLinha()
        THIS.LimparConfiguracaoOperacao()

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave do registro para a auditoria herdada
    *
    * PROTECTED porque e hook de BusinessBase: NUNCA chamar de fora do BO
    * (regra CLAUDE.md #51). Devolve a chave POSICIONAL da linha corrente
    * (3 + 20 + 6 = 29 chars), que e o unico identificador que este
    * dialogo tem - ele nao grava em tabela nenhuma.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.MontarChaveEmpDnCrds(THIS.this_cLinhaEmps, ;
            THIS.this_cLinhaDopes, THIS.this_nLinhaNumes)
    ENDPROC

    *====================================================================
    * Buscar - Carga da grade pela interface herdada de BusinessBase
    *
    * O filtro recebido e o Dopes da Operacao, para o Form poder chamar
    * Buscar() sem conhecer os nomes internos. Quando vem vazio, vale o
    * this_cDopes que DefinirParametros guardou - exatamente como o legado,
    * que usa sempre ThisForm.Movimentacao (= _pDopes).
    *====================================================================
    PROCEDURE Buscar(par_cFiltro, par_cOrdenacao, par_cCampos)
        LOCAL loc_lSucesso

        IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
            THIS.this_cDopes = par_cFiltro
        ENDIF

        loc_lSucesso = THIS.CarregarMovimentacoes()

        IF loc_lSucesso
            THIS.CarregarConfiguracaoOperacao(THIS.this_cDopes)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Guarda do lote de impressao
    *
    * Legado (Imprimir.Click e btnBoleto.Click, as duas primeiras linhas):
    *   If Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   EndIf
    *
    * A mensagem fica com o texto do legado (inclusive a grafia
    * "auteticadas", que e do original) - trocar texto de mensagem seria
    * desvio do PILAR 1. Quem move o foco para o botao Sair e o Form.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF !USED(THIS.this_cCursorGrade) OR RECCOUNT(THIS.this_cCursorGrade) <= 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o existem observa" + CHR(231) + ;
                CHR(245) + "es a serem auteticadas"
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Destroy - Fecha os cursores que este BO abriu
    *
    * USE IN fecha o alias mesmo com buffer sujo, e por isso NAO se usa
    * TABLEREVERT antes: sem buffering ligado (CREATE CURSOR nasce com
    * Buffering = 1) ele dispara o erro 1586 em vez de ser inocuo
    * (regra CLAUDE.md #52).
    *====================================================================
    PROCEDURE Destroy()
        LOCAL loc_nI, loc_aCursores[5]

        loc_aCursores[1] = THIS.this_cCursorGrade
        loc_aCursores[2] = "cursor_4c_TprMvCab"
        loc_aCursores[3] = "cursor_4c_SigOpCdc"
        loc_aCursores[4] = "cursor_4c_SigCdOpe"
        loc_aCursores[5] = "cursor_4c_SigOpCdd"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF !EMPTY(loc_aCursores[loc_nI]) AND USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE
