*============================================================================
* SIGOPRESBO.prg - Business Object para Estoque Estimado por Dia
*
* Legado  : SIGOPRES.SCX (form OPERACIONAL, modal, WindowType = 1)
* Operacao: dialogo de CONSULTA aberto a partir de uma operacao de venda /
*           locacao. Projeta, dia a dia, o estoque estimado de UM produto
*           dentro da janela que vai de hoje ate o prazo de entrega da
*           operacao, somando o que entra e subtraindo o que sai por conta
*           das reservas (operacao corrente e irmas) e das locacoes
*           (operacao PAI, SigCdOpe.copers = 1).
*
* Tabelas lidas (SOMENTE leitura - o legado nao grava em tabela nenhuma:
* cada Insert Into / Replace do SCX tem por destino um cursor LOCAL):
*   SigMvItn (a) PK cidchaves char(20) - itens de movimento: cpros char(14),
*                 dopes char(20), qtds numeric(9,3), qtbaixas numeric(9,3),
*                 empdopnums char(29)
*   SigMvCab (b) PK cidchaves char(20) - cabecalho: empdopnums char(29),
*                 datas datetime, prazoents datetime, dopes char(20),
*                 chksubn bit
*   SigCdOpe     PK dopes char(20)     - operacoes: nivels char(20),
*                 copers numeric(1,0)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*
* Mapeamento legado -> migrado (a logica entra na Fase 2):
*   Init / 1a query  (TmpReser) -> THIS.CarregarReservas()
*   Init / 2a query  (TmpOpe)   -> THIS.CarregarOperacaoPai()
*   Init / 3a query  (TmpLoca)  -> THIS.CarregarLocacoes()
*   Init / Create Cursor Tmpresul + os dois SCAN + o laco dos dias sem
*          movimentacao + o Select final por faixa de data
*                              -> THIS.CalcularEstoquePorDia()
*   Init / Seek(Ttod(TprMvCab.datas)) + thisform.nsaldo = TmpResul.estoque
*                              -> THIS.ObterSaldoNaData()
*
* O SCX NAO tem INSERT/UPDATE/DELETE remoto, por isso este BO mantem o
* comportamento herdado de BusinessBase para Inserir()/Atualizar()/
* ExecutarExclusao(), que ja eh o correto para uma tela de consulta.
*============================================================================

DEFINE CLASS SIGOPRESBO AS BusinessBase

    *==========================================================================
    * Entrada recebida do form chamador
    *
    * O Init legado le o produto da area de trabalho corrente
    * (lcAlias = Upper(Alias()) seguido de lcproduto = <alias>.CPros) e os
    * dados do cabecalho do cursor TprMvCab do chamador (datas, prazoents,
    * dopes, empdopnums). Na arquitetura nova esses valores chegam por
    * parametro e ficam guardados aqui.
    *==========================================================================
    this_cProduto      = ""    && char(14) SigMvItn.cpros      - produto consultado (CPros do item corrente)
    this_cOperacao     = ""    && char(20) SigMvCab.dopes      - operacao da venda/locacao (TprMvCab.dopes)
    this_cEmpDopNums   = ""    && char(29) SigMvCab.empdopnums - chave da operacao CORRENTE (TprMvCab.empdopnums)
    this_nSaldoInicial = 0     && numeric(11,3) - saldo de estoque recebido do chamador (parametro __saldo do legado)

    *==========================================================================
    * Janela de datas da projecao
    *
    * Legado: dtini = Dtot(Date())
    *         dtfin = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *                     TprMvCab.datas, TprMvCab.prazoents)
    *         dtfin = fDtoSQL(dtfin, 23:59:59)
    *
    * Guardadas como DATE (regra #16 do CLAUDE.md - o mesmo campo chega ora
    * DATE ora DATETIME conforme o caminho, por isso a normalizacao eh feita
    * com ConverterParaData e o limite de hora 23:59:59 do dtfin eh aplicado
    * somente na montagem da query).
    *==========================================================================
    this_dDataMovimento = {}   && SigMvCab.datas      - data da operacao (TprMvCab.datas)
    this_dPrazoEntrega  = {}   && SigMvCab.prazoents  - prazo de entrega da operacao (TprMvCab.prazoents)
    this_dDataInicial   = {}   && dtini do legado - DATE() na abertura da tela
    this_dDataFinal     = {}   && dtfin do legado - prazoents quando preenchido, senao datas

    *==========================================================================
    * Operacao PAI (locacoes)
    *
    * Legado: select dopes from SigCdOpe where nivels = <operacao> and copers = 1
    *         lcoper = tmpOpe.dopes
    * A MESMA query das reservas eh reexecutada com essa operacao para montar
    * TmpLoca. Quando SigCdOpe nao devolve linha, o legado le tmpOpe.dopes em
    * EOF e recebe BRANCOS: a consulta das locacoes fica sem resultado, que eh
    * o comportamento reproduzido na Fase 2 a partir destas duas properties.
    *==========================================================================
    this_cOperacaoPai      = ""   && char(20) SigCdOpe.dopes - operacao pai (nivels = this_cOperacao e copers = 1)
    this_lAchouOperacaoPai = .F.  && .T. quando SigCdOpe devolveu a operacao pai

    *==========================================================================
    * Resultado devolvido ao chamador
    *
    * Legado: thisform.nsaldo (property custom do form, RESERVED3 do SCX) eh
    * carregado com TmpResul.estoque da data da operacao e devolvido no Click
    * do botao Encerrar (__saldo = thisform.nsaldo).
    *==========================================================================
    this_nSaldo = 0            && numeric(11,3) - estoque estimado na data da operacao (nsaldo do legado)

    *==========================================================================
    * Cursores de trabalho (PILAR 3 - nomes novos, cursor_4c_*)
    *
    *   TmpReser -> this_cCursorReservas      (itens reservados na janela)
    *   TmpOpe   -> this_cCursorOperacaoPai   (operacao pai vinda de SigCdOpe)
    *   TmpLoca  -> this_cCursorLocacoes      (itens locados na janela)
    *   Tmpresul -> this_cCursorDados         (projecao dia a dia - grade)
    *   Tmpdata  -> this_cCursorDatas         (auxiliar dos Select Max/Min)
    *
    * this_cCursorDados eh o cursor ligado ao Grid; os demais sao
    * intermediarios. Na Fase 2 todo SQLEXEC vai para cursor TEMPORARIO
    * proprio, para nunca derrubar o alias da grade.
    *==========================================================================
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorReservas    = "cursor_4c_Reservas"
    this_cCursorLocacoes    = "cursor_4c_Locacoes"
    this_cCursorOperacaoPai = "cursor_4c_OperacaoPai"
    this_cCursorDatas       = "cursor_4c_Datas"

    *==========================================================================
    * Estado da carga
    *==========================================================================
    this_lDadosCarregados = .F.  && .T. depois que a projecao dia a dia foi montada
    this_nTotalDias       = 0    && quantidade de linhas da projecao (RECCOUNT do cursor da grade)

    *==========================================================================
    * Init - Configura tabela e chave primaria do BO
    *
    * A entidade lida eh SigMvItn (tabela "a" do JOIN que alimenta tanto as
    * reservas quanto as locacoes), cuja chave primaria eh cidchaves char(20).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"

            *-- A janela de datas comeca sempre em DATE(), como o dtini do legado
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarCalculo - Funil unico que reproduz o Init legado por completo.
    *
    * Chamado pelo Form (FormSIGOPRES) depois de preencher os parametros
    * recebidos do chamador (this_cProduto/this_cOperacao/this_cEmpDopNums/
    * this_nSaldoInicial/this_dDataMovimento/this_dPrazoEntrega). Repete, na
    * mesma ordem do Init do SCX, as 3 consultas remotas + a projecao dia a
    * dia + o saldo na data da operacao.
    *
    * PUBLIC - regra #51 do CLAUDE.md (metodo chamado de fora do BO nunca
    * pode ser PROTECTED em nenhum nivel da heranca).
    *==========================================================================
    FUNCTION ExecutarCalculo()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF THIS.CarregarReservas() AND THIS.CarregarOperacaoPai()
            IF THIS.CarregarLocacoes() AND THIS.CalcularEstoquePorDia()
                loc_lResultado = THIS.ObterSaldoNaData()
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarReservas - 1a query do Init legado (TmpReser)
    *
    * Legado:
    *   lcoper = TprMvCab.dopes
    *   lcquery = [select b.empdopnums, b.datas, b.prazoents, a.qtds,
    *              a.qtbaixas, 000000.000 as qtdests from SigMvItn a
    *              inner join SigMvCab b on a.empdopnums = b.empdopnums
    *              where cpros = ?lcproduto and a.dopes = ?lcoper and
    *              (b.datas between ?dtini and ?dtfin or
    *               b.prazoents >= ?dtini) and b.chksubn = 0
    *              order by b.datas, b.prazoents]
    *   ocnx.sqlexecute(lcquery,[TmpReser])
    *==========================================================================
    PROTECTED FUNCTION CarregarReservas()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarQueryMovimento(THIS.this_cOperacao)

            IF USED(THIS.this_cCursorReservas)
                USE IN (THIS.this_cCursorReservas)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorReservas)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar reservas: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarOperacaoPai - 2a query do Init legado (TmpOpe)
    *
    * Legado:
    *   lcquery2 = [select dopes from SigCdOpe where nivels = '] + lcoper +
    *              [' and copers = 1]
    *   ocnx.sqlexecute(lcquery2,[TmpOpe])
    *   lcoper = tmpOpe.dopes
    *
    * Quando SigCdOpe NAO devolve linha (a operacao nao tem pai de locacao),
    * o legado le tmpOpe.dopes com o cursor em EOF e recebe BRANCOS - lcoper
    * fica vazio e a consulta seguinte (TmpLoca) nao casa com registro nenhum,
    * porque dopes char(20) nunca eh branco num movimento real. Ou seja: sem
    * operacao pai, nao ha locacao a descontar.
    *
    * Por isso this_cOperacaoPai recebe "" nesse caso, e NAO this_cOperacao:
    * repetir a operacao original faria a consulta das locacoes devolver
    * exatamente as mesmas linhas das reservas, e cada movimento seria
    * aplicado DUAS vezes sobre a projecao - numero errado, sem erro na tela
    * (regra #17 do CLAUDE.md: a formula/consulta do legado se transcreve,
    * nao se reinventa).
    *==========================================================================
    PROTECTED FUNCTION CarregarOperacaoPai()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopes FROM SigCdOpe " + ;
                       "WHERE nivels = " + EscaparSQL(THIS.this_cOperacao) + " " + ;
                       "AND copers = 1"

            IF USED(THIS.this_cCursorOperacaoPai)
                USE IN (THIS.this_cCursorOperacaoPai)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacaoPai)

            IF loc_nResultado >= 0
                IF RECCOUNT(THIS.this_cCursorOperacaoPai) > 0
                    SELECT (THIS.this_cCursorOperacaoPai)
                    GO TOP
                    THIS.this_cOperacaoPai      = TratarNulo(dopes, "")
                    THIS.this_lAchouOperacaoPai = .T.
                ELSE
                    *-- Legado: lcoper = tmpOpe.dopes com TmpOpe vazio = BRANCOS
                    THIS.this_cOperacaoPai      = ""
                    THIS.this_lAchouOperacaoPai = .F.
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar opera" + CHR(231) + CHR(227) + "o pai: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarLocacoes - 3a query do Init legado (TmpLoca)
    *
    * Legado: ocnx.sqlexecute(lcquery,[TmpLoca]) - a MESMA lcquery da 1a
    * consulta, reexecutada com lcoper agora valendo this_cOperacaoPai.
    *==========================================================================
    PROTECTED FUNCTION CarregarLocacoes()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarQueryMovimento(THIS.this_cOperacaoPai)

            IF USED(THIS.this_cCursorLocacoes)
                USE IN (THIS.this_cCursorLocacoes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorLocacoes)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar loca" + CHR(231) + CHR(245) + "es: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * MontarQueryMovimento - texto da lcquery do legado, parametrizado pela
    * operacao (this_cOperacao para reservas, this_cOperacaoPai para
    * locacoes - regra #42 do CLAUDE.md: montagem de chave/filtro eh
    * transcrita, nao reinventada).
    *
    * dtfin ganha hora 23:59:59 (fDtoSQL(dtfin,'23:59:59') do legado) porque
    * b.datas/b.prazoents sao DATETIME no SQL Server - sem a hora, o filtro
    * perderia os registros do ultimo dia da janela que tem hora != 00:00:00.
    *==========================================================================
    PROTECTED FUNCTION MontarQueryMovimento(par_cOperacao)
        LOCAL loc_cSQL, loc_cDtIni, loc_cDtFin

        loc_cDtIni = FormatarDataSQL(THIS.this_dDataInicial)

        loc_cDtFin = FormatarDataSQL(THIS.this_dDataFinal)
        loc_cDtFin = LEFT(loc_cDtFin, LEN(loc_cDtFin) - 1) + " 23:59:59'"

        loc_cSQL = "SELECT b.empdopnums, b.datas, b.prazoents, a.qtds, a.qtbaixas, " + ;
                   "0.000 AS qtdests " + ;
                   "FROM SigMvItn a " + ;
                   "INNER JOIN SigMvCab b ON a.empdopnums = b.empdopnums " + ;
                   "WHERE a.cpros = " + EscaparSQL(THIS.this_cProduto) + " " + ;
                   "AND a.dopes = " + EscaparSQL(par_cOperacao) + " " + ;
                   "AND (b.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFin + " " + ;
                   "OR b.prazoents >= " + loc_cDtIni + ") " + ;
                   "AND b.chksubn = 0 " + ;
                   "ORDER BY b.datas, b.prazoents"

        RETURN loc_cSQL
    ENDFUNC

    *==========================================================================
    * CalcularEstoquePorDia - Create Cursor Tmpresul + os dois SCAN
    * (TmpReser/TmpLoca) + o laco dos dias sem movimentacao + o Select final
    * por faixa de data, todos do Init legado.
    *==========================================================================
    PROTECTED FUNCTION CalcularEstoquePorDia()
        LOCAL loc_lResultado, loc_dIni, loc_dFim
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorDados) (datas D, estoque N(11,3))
            INDEX ON datas TAG datas

            *-- Legado: Insert into Tmpresul(datas,estoque) values (Date(), __saldo)
            INSERT INTO (THIS.this_cCursorDados) (datas, estoque) ;
                VALUES (DATE(), THIS.this_nSaldoInicial)

            *-- Legado: Select TmpReser / Scan ... EndScan
            *
            *   O SELECT de volta DENTRO do laco eh obrigatorio: INSERT INTO e
            *   os Select ... INTO CURSOR dos helpers de saldo trocam a area de
            *   trabalho corrente, e o ENDSCAN precisa do cursor de origem
            *   selecionado para avancar o ponteiro.
            IF USED(THIS.this_cCursorReservas)
                SELECT (THIS.this_cCursorReservas)
                SCAN
                    THIS.AplicarMovimentoReserva(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorReservas)
                ENDSCAN
            ENDIF

            *-- Legado: Select TmpLoca / Scan ... EndScan
            IF USED(THIS.this_cCursorLocacoes)
                SELECT (THIS.this_cCursorLocacoes)
                SCAN
                    THIS.AplicarMovimentoLocacao(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorLocacoes)
                ENDSCAN
            ENDIF

            *-- Legado: insere estoque nos dias que nao tiveram movimentacao
            THIS.PreencherDiasSemMovimento(THIS.this_cCursorDados)

            *-- Legado: Select * from Tmpresul where datas between dtini and
            *-- dtfin into cursor Tmpresul order by datas (aqui num cursor
            *-- temporario, para depois substituir o cursor_4c_Dados)
            loc_dIni = THIS.this_dDataInicial
            loc_dFim = THIS.this_dDataFinal

            SELECT * FROM (THIS.this_cCursorDados) ;
                WHERE datas >= m.loc_dIni AND datas <= m.loc_dFim ;
                ORDER BY datas ;
                INTO CURSOR cursor_4c_EstoqueFiltrado READWRITE

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            SELECT * FROM cursor_4c_EstoqueFiltrado INTO CURSOR (THIS.this_cCursorDados) READWRITE

            IF USED("cursor_4c_EstoqueFiltrado")
                USE IN cursor_4c_EstoqueFiltrado
            ENDIF

            SELECT (THIS.this_cCursorDados)
            INDEX ON datas TAG datas
            GO TOP

            THIS.this_lDadosCarregados = .T.
            THIS.this_nTotalDias       = RECCOUNT(THIS.this_cCursorDados)

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AplicarMovimentoReserva - um "passo" do Scan TmpReser do legado,
    * aplicado ao registro CORRENTE de this_cCursorReservas.
    *
    * Legado (datas - inicio da reserva):
    *   =Seek(Ttod(Tmpreser.datas),'TmpResul','datas')
    *   If !Eof('TmpResul')
    *       If TprMvCab.empdopnums = tmpreser.empdopnums
    *           replace estoque with estoque + (qtds-qtbaixas) for datas >= ... in TmpResul
    *       Else
    *           replace estoque with estoque - (qtds-qtbaixas) for datas >= ... in TmpResul
    *       EndIf
    *   Else
    *       dmax = Max(Ttod(dtini),TmpReser.datas)
    *       <saldo ate dmax> ...
    *       Insert ... values (data, saldo +/- qtde)
    *   EndIf
    *
    * Legado (prazoents - fim da reserva, sempre DEVOLVE a quantidade):
    *   =Seek(Ttod(TmpReser.prazoents),'TmpResul','datas')
    *   If !Eof('TmpResul')
    *       replace estoque with estoque + (qtds-qtbaixas) for datas >= ... in TmpResul
    *   Else
    *       <saldo no intervalo [datas, prazoents]> ...
    *       Insert ... values (prazoents, saldo + qtde)
    *   EndIf
    *==========================================================================
    PROTECTED PROCEDURE AplicarMovimentoReserva(par_cCursorResultado)
        LOCAL loc_dDataInicioMov, loc_dDataFimMov, loc_nQtdeLiquida, loc_lMesmaOperacao
        LOCAL loc_dMax, loc_nSaldo

        loc_dDataInicioMov = ConverterParaData(datas)
        loc_dDataFimMov    = ConverterParaData(prazoents)
        loc_nQtdeLiquida   = qtds - qtbaixas
        loc_lMesmaOperacao = (THIS.this_cEmpDopNums = empdopnums)

        *-- 1) Movimento na data de inicio da reserva
        IF SEEK(loc_dDataInicioMov, par_cCursorResultado, "datas")
            IF loc_lMesmaOperacao
                REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                    FOR datas >= loc_dDataInicioMov IN (par_cCursorResultado)
            ELSE
                REPLACE estoque WITH estoque - loc_nQtdeLiquida ;
                    FOR datas >= loc_dDataInicioMov IN (par_cCursorResultado)
            ENDIF
        ELSE
            loc_dMax   = MAX(THIS.this_dDataInicial, loc_dDataInicioMov)
            loc_nSaldo = THIS.ObterSaldoAteData(par_cCursorResultado, loc_dMax)
            IF loc_lMesmaOperacao
                INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                    VALUES (loc_dDataInicioMov, loc_nSaldo + loc_nQtdeLiquida)
            ELSE
                INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                    VALUES (loc_dDataInicioMov, loc_nSaldo - loc_nQtdeLiquida)
            ENDIF
        ENDIF

        *-- 2) Movimento na data do prazo de entrega da reserva (devolve a quantidade)
        IF SEEK(loc_dDataFimMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                FOR datas >= loc_dDataFimMov IN (par_cCursorResultado)
        ELSE
            loc_nSaldo = THIS.ObterSaldoNoIntervalo(par_cCursorResultado, loc_dDataInicioMov, loc_dDataFimMov)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataFimMov, loc_nSaldo + loc_nQtdeLiquida)
        ENDIF
    ENDPROC

    *==========================================================================
    * AplicarMovimentoLocacao - um "passo" do Scan TmpLoca do legado,
    * aplicado ao registro CORRENTE de this_cCursorLocacoes.
    *
    * Diferenca em relacao a reserva: na data de INICIO da locacao, a
    * retirada de estoque so vale ATE dtini (for datas >= ... and
    * datas < dtini) - a partir de hoje quem manda eh a janela calculada,
    * nao mais o item locado.
    *==========================================================================
    PROTECTED PROCEDURE AplicarMovimentoLocacao(par_cCursorResultado)
        LOCAL loc_dDataInicioMov, loc_dDataFimMov, loc_nQtdeLiquida
        LOCAL loc_dMax, loc_nSaldo

        loc_dDataInicioMov = ConverterParaData(datas)
        loc_dDataFimMov    = ConverterParaData(prazoents)
        loc_nQtdeLiquida   = qtds - qtbaixas

        *-- 1) Retirada do estoque na data da locacao, limitada ao inicio da janela
        IF SEEK(loc_dDataInicioMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque - loc_nQtdeLiquida ;
                FOR datas >= loc_dDataInicioMov AND datas < THIS.this_dDataInicial ;
                IN (par_cCursorResultado)
        ELSE
            loc_dMax   = MAX(THIS.this_dDataInicial, loc_dDataInicioMov)
            loc_nSaldo = THIS.ObterSaldoAteData(par_cCursorResultado, loc_dMax)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataInicioMov, loc_nSaldo - loc_nQtdeLiquida)
        ENDIF

        *-- 2) Devolucao do estoque na data do prazo de entrega da locacao
        IF SEEK(loc_dDataFimMov, par_cCursorResultado, "datas")
            REPLACE estoque WITH estoque + loc_nQtdeLiquida ;
                FOR datas >= loc_dDataFimMov IN (par_cCursorResultado)
        ELSE
            loc_nSaldo = THIS.ObterSaldoNoIntervalo(par_cCursorResultado, loc_dDataInicioMov, loc_dDataFimMov)
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (loc_dDataFimMov, loc_nSaldo + loc_nQtdeLiquida)
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterSaldoAteData - "Select Max(datas) ... where datas <= dmax" do
    * legado, seguido do Seek + leitura do estoque (ou __saldo se nao achar).
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoAteData(par_cCursorResultado, par_dDataLimite)
        LOCAL loc_nSaldo, loc_dDataMax

        loc_nSaldo = THIS.this_nSaldoInicial

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MAX(datas) AS datas FROM (par_cCursorResultado) ;
            WHERE datas <= m.par_dDataLimite ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dDataMax = datas

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        IF !ISNULL(loc_dDataMax)
            IF SEEK(loc_dDataMax, par_cCursorResultado, "datas")
                SELECT (par_cCursorResultado)
                IF !EOF(par_cCursorResultado)
                    loc_nSaldo = estoque
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_nSaldo
    ENDFUNC

    *==========================================================================
    * ObterSaldoNoIntervalo - "Select Max(datas) ... where datas between X
    * and Y" do legado (usado no lado "prazoents" das reservas/locacoes),
    * seguido do Seek + leitura do estoque (ou __saldo se nao achar).
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoNoIntervalo(par_cCursorResultado, par_dDataIni, par_dDataFim)
        LOCAL loc_nSaldo, loc_dDataMax

        loc_nSaldo = THIS.this_nSaldoInicial

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MAX(datas) AS datas FROM (par_cCursorResultado) ;
            WHERE datas >= m.par_dDataIni AND datas <= m.par_dDataFim ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dDataMax = datas

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        IF !ISNULL(loc_dDataMax)
            IF SEEK(loc_dDataMax, par_cCursorResultado, "datas")
                SELECT (par_cCursorResultado)
                IF !EOF(par_cCursorResultado)
                    loc_nSaldo = estoque
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_nSaldo
    ENDFUNC

    *==========================================================================
    * PreencherDiasSemMovimento - "Insere estoque nos dias que nao tiveram
    * movimentacao" do legado.
    *
    * Legado:
    *   Select Min(datas) as dtini, Max(datas) as dtfin from TmpResul into cursor TmpData
    *   nsaldoant = __saldo
    *   If Reccount('TmpResul') > 0
    *       For x = 0 to (TmpData.dtfin - TmpData.dtini)
    *           =Seek(TmpData.dtini+x,'Tmpresul','datas')
    *           If !Eof('Tmpresul')
    *               nsaldoant = Tmpresul.estoque
    *           Else
    *               Insert into Tmpresul(datas,estoque) values (TmpData.dtini+x, nsaldoant)
    *           EndIf
    *       Next
    *   Else
    *       Insert into Tmpresul(datas,estoque) values (Ttod(TprMvCab.datas), nsaldoant)
    *   EndIf
    *==========================================================================
    PROTECTED PROCEDURE PreencherDiasSemMovimento(par_cCursorResultado)
        LOCAL loc_dMin, loc_dMax, loc_nSaldoAnterior, loc_nX

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        SELECT MIN(datas) AS dtini, MAX(datas) AS dtfin FROM (par_cCursorResultado) ;
            INTO CURSOR (THIS.this_cCursorDatas)

        SELECT (THIS.this_cCursorDatas)
        loc_dMin = dtini
        loc_dMax = dtfin

        IF USED(THIS.this_cCursorDatas)
            USE IN (THIS.this_cCursorDatas)
        ENDIF

        loc_nSaldoAnterior = THIS.this_nSaldoInicial

        IF RECCOUNT(par_cCursorResultado) > 0
            FOR loc_nX = 0 TO (loc_dMax - loc_dMin)
                IF SEEK(loc_dMin + loc_nX, par_cCursorResultado, "datas")
                    SELECT (par_cCursorResultado)
                    loc_nSaldoAnterior = estoque
                ELSE
                    INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                        VALUES (loc_dMin + loc_nX, loc_nSaldoAnterior)
                ENDIF
            ENDFOR
        ELSE
            INSERT INTO (par_cCursorResultado) (datas, estoque) ;
                VALUES (ConverterParaData(THIS.this_dDataMovimento), loc_nSaldoAnterior)
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterSaldoNaData - localiza o saldo projetado na data da operacao e
    * devolve em this_nSaldo (nsaldo do legado).
    *
    * Legado:
    *   Select Tmpresul
    *   index on datas to datas
    *   Set near On
    *   =Seek(Ttod(TprMvCab.datas),'Tmpresul','datas')
    *   Set Near Off
    *   If Bof() or Eof()
    *       Go bottom
    *   EndIf
    *   thisform.nsaldo = TmpResul.estoque
    *==========================================================================
    PROTECTED FUNCTION ObterSaldoNaData()
        LOCAL loc_lResultado, loc_dData
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorDados)
                loc_dData = ConverterParaData(THIS.this_dDataMovimento)

                SET NEAR ON
                =SEEK(loc_dData, THIS.this_cCursorDados, "datas")
                SET NEAR OFF

                SELECT (THIS.this_cCursorDados)

                IF BOF() OR EOF()
                    GO BOTTOM
                ENDIF

                THIS.this_nSaldo = NVL(estoque, 0)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de resultado n" + CHR(227) + "o foi carregado"
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - le do cursor do CHAMADOR os parametros de entrada da
    * projecao, reproduzindo o bloco de leitura que abre o Init legado.
    *
    * Legado:
    *   lcAlias   = Upper(Alias())
    *   lcproduto = &lcAlias..CPros                    && item corrente
    *   lcoper    = TprMvCab.dopes                     && cabecalho
    *   dtini     = Dtot(Date())
    *   dtfin     = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *                   TprMvCab.datas, TprMvCab.prazoents)
    *   ... e TprMvCab.empdopnums, usado na comparacao de cada reserva.
    *
    * No legado esses valores vem de DOIS cursores do chamador: o produto sai
    * da area de trabalho corrente (o ITEM) e o resto sai do cabecalho
    * TprMvCab. Por isso cada coluna eh procurada com TYPE() antes de ser
    * lida - o mesmo metodo atende os dois cursores, e o Form pode chama-lo
    * uma vez para cada um. Coluna ausente simplesmente nao sobrescreve a
    * property, que continua com o valor ja recebido.
    *
    * PEMSTATUS NAO serve aqui: o 1o argumento dele tem de ser OBJETO, e
    * passar nome de cursor estoura "Function argument value, type, or count
    * is invalid." A deteccao de coluna em cursor eh com TYPE(alias + ".col").
    *
    * PUBLIC (sem modificador, como na BusinessBase) - regra #51 do CLAUDE.md:
    * metodo chamado de fora do BO nunca pode ser PROTECTED.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                *-- Produto consultado (CPros do item corrente no legado)
                IF TYPE(loc_cAlias + ".cpros") = "C"
                    THIS.this_cProduto = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".cpros"), ""))
                ENDIF

                *-- Operacao da venda/locacao (TprMvCab.dopes)
                IF TYPE(loc_cAlias + ".dopes") = "C"
                    THIS.this_cOperacao = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".dopes"), ""))
                ENDIF

                *-- Chave da operacao CORRENTE (TprMvCab.empdopnums)
                IF TYPE(loc_cAlias + ".empdopnums") = "C"
                    THIS.this_cEmpDopNums = TratarNulo(EVALUATE(loc_cAlias + ".empdopnums"), "")
                ENDIF

                *-- Data da operacao (TprMvCab.datas)
                IF INLIST(TYPE(loc_cAlias + ".datas"), "D", "T")
                    THIS.this_dDataMovimento = ConverterParaData(EVALUATE(loc_cAlias + ".datas"))
                ENDIF

                *-- Prazo de entrega da operacao (TprMvCab.prazoents)
                IF INLIST(TYPE(loc_cAlias + ".prazoents"), "D", "T")
                    THIS.this_dPrazoEntrega = ConverterParaData(EVALUATE(loc_cAlias + ".prazoents"))
                ENDIF

                *-- Janela da projecao - dtini / dtfin do legado
                THIS.AtualizarJanelaDatas()

                *-- Parametros novos invalidam a projecao ja calculada
                THIS.this_lDadosCarregados = .F.
                THIS.this_nTotalDias       = 0

                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + ;
                                          "o est" + CHR(225) + " aberto: [" + loc_cAlias + "]"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarJanelaDatas - dtini / dtfin do Init legado.
    *
    *   dtini = Dtot(Date())
    *   dtfin = Iif(IsNull(TprMvCab.prazoents) or Empty(TprMvCab.prazoents),
    *               TprMvCab.datas, TprMvCab.prazoents)
    *
    * Fica num metodo proprio porque o Form tambem precisa recalcular a janela
    * quando preenche this_dDataMovimento / this_dPrazoEntrega por parametro,
    * sem passar por um cursor. PUBLIC pelo mesmo motivo (regra #51).
    *==========================================================================
    PROCEDURE AtualizarJanelaDatas()
        THIS.this_dDataInicial = DATE()

        IF EMPTY(THIS.this_dPrazoEntrega)
            THIS.this_dDataFinal = THIS.this_dDataMovimento
        ELSE
            THIS.this_dDataFinal = THIS.this_dPrazoEntrega
        ENDIF

        *-- Sem cabecalho nenhum (chamada direta de teste), a janela degenera
        *-- em um unico dia - DATE() -, que eh o que o legado produz quando
        *-- TprMvCab.datas tambem esta vazio.
        IF EMPTY(THIS.this_dDataFinal)
            THIS.this_dDataFinal = THIS.this_dDataInicial
        ENDIF

        RETURN
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - identifica o registro de SigMvItn em que a
    * projecao esta ancorada.
    *
    * SigMvItn tem PK cidchaves char(20), mas o legado nunca posiciona esta
    * tela por cidchaves: ele recebe o item pela area de trabalho corrente e
    * identifica a linha pelo par (produto, operacao) dentro da chave da
    * operacao corrente. Eh essa a identificacao devolvida aqui - a mesma que
    * o RegistrarAuditoria herdado gravaria, e a que aparece no texto de erro
    * do ExibirFalha quando alguem tenta gravar por este BO.
    *
    * PROTECTED (como na BusinessBase - regra #51: nunca chamado de fora).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave

        loc_cChave = ALLTRIM(THIS.this_cEmpDopNums) + "|" + ;
                     ALLTRIM(THIS.this_cProduto)    + "|" + ;
                     ALLTRIM(THIS.this_cOperacao)

        RETURN loc_cChave
    ENDPROC

ENDDEFINE
