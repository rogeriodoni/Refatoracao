*====================================================================
* sigprcpdBO.prg
*
* Business Object para Formsigprcpd (Capacidade Produtiva)
* Form OPERACIONAL (nao-CRUD): exibe, para um Envelope/Codigo de OP
* (SigCdPcz.codigos) em uma Fase/Setor e Unidade Produtiva, a capacidade
* de producao (minutos totais/utilizados/saldo, agregados a partir de
* SigCdPcp) e a grade de operacoes vinculadas (SigCdPco join SigCdCli),
* rateando o tempo de cada operacao pela proporcao apurada em SigCdPcg.
*
* Tabela principal para efeitos de ObterChavePrimaria/auditoria: SigCdPco
* (cidchaves char(20) - PK). Nao ha INSERT/UPDATE/DELETE no legado: o
* form apenas consulta e exibe - o comportamento padrao herdado de
* BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao) ja eh o
* correto para este BO.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros recebidos do form/menu chamador (equivalentes a
    *-- LPARAMETERS pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFases    = ""    && fases char(10) - Setor/Fase de producao
    this_cUniprdts = ""    && uniprdts char(10) - Unidade Produtiva (opcional)
    this_dDatas    = {}    && datas - Data de referencia da capacidade
    this_nCodigos  = 0     && codigos numeric(10,0) - Codigo do Envelope/OP (SigCdPcz)

    *-- Capacidade agregada (Container2: Capacidade/Utilizado/Saldo),
    *-- somada a partir de SigCdPcp para a Fase/Data/Unidade informadas
    this_nMinutos    = 0   && minutos numeric(9,1) - Capacidade total (minutos)
    this_nUtilizados = 0   && utilizados - minutos ja utilizados
    this_nSaldos     = 0   && saldos numeric(8,1) - Saldo disponivel (minutos)

    *-- Detalhe da linha corrente da grade (AfterRowColChange): dados do
    *-- produto e do cliente da operacao selecionada
    this_cCpros = ""    && cpros char(14) - codigo do produto da operacao
    this_cDpros = ""    && dpros - descricao do produto (SigCdPro.Dpros)
    this_nQtds  = 0     && qtds numeric(9,3) - quantidade da operacao
    this_cRclis = ""    && rclis - razao social do cliente (SigCdCli.Rclis)
    this_nTempU = 0     && tempU - tempo total do envelope (minutos)

    *-- Nome do cursor final que alimenta a grade (equivalente ao
    *-- zTmpPcpOp do legado)
    this_cCursorGrade = "cursor_4c_Grade"

    *-- Nome do cursor de detalhe do produto (equivalente ao CrTmpPro do
    *-- legado), populado por ObterDetalheProduto() a cada troca de linha
    this_cCursorProdutoDetalhe = "cursor_4c_ProdutoDetalhe"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPco"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcpdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDados - Carrega a capacidade produtiva e a grade de
    * operacoes de um Envelope/OP (SigCdPcz.codigos), para uma
    * Fase/Setor, Data e (opcionalmente) Unidade Produtiva.
    *
    * Equivalente ao PROCEDURE Init do form legado SIGPRCPD: 4 consultas
    * remotas (validacao do envelope, capacidade agregada, "peso" por
    * envelope/sequencia em SigCdPcg, detalhe das operacoes em SigCdPco
    * + SigCdCli) seguidas de um SELECT local que agrupa o tempo das
    * operacoes por Fase+Unidade+Envelope+Sequencia (restrito as
    * combinacoes que tem "peso" em SigCdPcg) e de um SELECT local final
    * que rateia o tempo total do envelope (SigCdPcg.Minutos) entre as
    * operacoes proporcionalmente ao peso de cada uma.
    *
    * Parametros:
    *   par_cFase    - fases char(10), Setor/Fase de producao (obrigatorio)
    *   par_cUnidade - uniprdts char(10), Unidade Produtiva (opcional)
    *   par_dData    - datas, data de referencia da capacidade (obrigatorio)
    *   par_nCodigo  - codigos numeric(10,0), codigo do Envelope/OP (obrigatorio)
    *
    * Popula: this_nMinutos/this_nUtilizados/this_nSaldos (Container2) e
    * o cursor this_cCursorGrade, com as colunas do legado (nenvs, nops,
    * ordems, cpros, uniprdts, priors, pedido, cliente, rclis, tempu,
    * tempoo, temporeal).
    *
    * Retorno: .T. se sucesso, .F. se falha (mensagem em this_cMensagemErro)
    *====================================================================
    FUNCTION CarregarDados(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cFiltroUnid, loc_cCursorGrade

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cFase) != "C" OR EMPTY(par_cFase) OR ;
                        VARTYPE(par_dData) != "D" OR EMPTY(par_dData) OR ;
                        VARTYPE(par_nCodigo) != "N" OR NVL(par_nCodigo, 0) <= 0
                    THIS.this_cMensagemErro = "Fase, Data e C" + CHR(243) + "digo do Envelope s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
                ELSE
                    THIS.this_cFases    = ALLTRIM(par_cFase)
                    THIS.this_cUniprdts = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
                    THIS.this_dDatas    = par_dData
                    THIS.this_nCodigos  = par_nCodigo

                    THIS.FecharCursoresTemporarios()

                    loc_cCursorGrade = THIS.this_cCursorGrade
                    loc_cFiltroUnid  = IIF(EMPTY(THIS.this_cUniprdts), "", " AND UniPrdts = " + EscaparSQL(THIS.this_cUniprdts))

                    *-- 1) Valida existencia do Envelope/OP (SigCdPcz)
                    loc_cSQL = "SELECT codigos FROM SigCdPcz WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcz")

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Envelope " + TRANSFORM(THIS.this_nCodigos) + " n" + CHR(227) + "o encontrado em SigCdPcz)"
                    ELSE
                        *-- 2) Capacidade agregada (SigCdPcp): Minutos/Utilizados/Saldos
                        loc_cSQL = "SELECT Codigos, SUM(minutos) AS Minutos, SUM(minutos - Saldos) AS Utilizados, SUM(saldos) AS Saldos " + ;
                            "FROM SigCdPcp " + ;
                            "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                            " AND Datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                            " AND Fases = " + EscaparSQL(THIS.this_cFases) + ;
                            loc_cFiltroUnid + ;
                            " GROUP BY Codigos"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpCap")

                        IF loc_nResultado < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Capacidade n" + CHR(227) + "o encontrada em SigCdPcp)"
                        ELSE
                            THIS.this_nMinutos    = NVL(cursor_4c_PcpCap.Minutos, 0)
                            THIS.this_nUtilizados = NVL(cursor_4c_PcpCap.Utilizados, 0)
                            THIS.this_nSaldos     = NVL(cursor_4c_PcpCap.Saldos, 0)

                            *-- 3) "Peso"/tempo total por envelope-sequencia (SigCdPcg)
                            loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                                "WHERE datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                                " AND fases = " + EscaparSQL(THIS.this_cFases) + ;
                                " AND codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                loc_cFiltroUnid + ;
                                " ORDER BY cidchaves"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcg")

                            IF loc_nResultado < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Programa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdPcg)"
                            ELSE
                                *-- 4) Detalhe das operacoes (SigCdPco + SigCdCli), com Pedido e
                                *-- Cliente ja concatenados no SQL Server (RTRIM no lugar do STR
                                *-- posicional do legado, que aqui so serve para exibicao)
                                loc_cSQL = "SELECT a.*, " + ;
                                    "RTRIM(a.dopes) + '-' + RIGHT('     ' + CONVERT(VARCHAR(6), a.numes), 6) AS Pedido, " + ;
                                    "RTRIM(a.contas) + '-' + RTRIM(b.rclis) AS Cliente, " + ;
                                    "RTRIM(b.rclis) AS Rclis " + ;
                                    "FROM SigCdPco a INNER JOIN SigCdCli b ON a.contas = b.iclis " + ;
                                    "WHERE a.codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                    " AND a.fases = " + EscaparSQL(THIS.this_cFases) + ;
                                    IIF(EMPTY(THIS.this_cUniprdts), "", " AND a.uniprdts = " + EscaparSQL(THIS.this_cUniprdts)) + ;
                                    " ORDER BY a.uniprdts, a.seqs, a.nenvs"
                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pco")

                                IF loc_nResultado < 1
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontradas em SigCdPco)"
                                ELSE
                                    *-- 5) Agrupa localmente o total de minutos por Fase+Unidade+
                                    *-- Envelope+Sequencia, restrito as combinacoes que existem em
                                    *-- SigCdPcg (equivalente ao zTmpPcpOp3 do legado). Chave
                                    *-- POSICIONAL: Fases/UniPrdts sao char(10) nos dois cursores e
                                    *-- STR() fixa a largura dos numericos - NAO fazer ALLTRIM aqui
                                    *-- (regra: chave posicional concatenada quebra em silencio).
                                    SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, SUM(a.Minutos) AS Minutos ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                        GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                                        INTO CURSOR cursor_4c_PcoAgrupado READWRITE

                                    *-- 6) Grade final: rateia o tempo total do envelope (b.Minutos)
                                    *-- proporcionalmente ao peso de cada operacao (a.Minutos/c.Minutos).
                                    *-- TempoReal transcreve fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60))
                                    *-- do legado (SIGFUNCS.PRG) via ConverterSegundosParaMinutos() -
                                    *-- ver comentario da funcao mais abaixo. Guard IIF(c.Minutos=0,...)
                                    *-- evita erro de divisao por zero que o legado nao previa.
                                    SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                                        ConverterSegundosParaMinutos(IIF(NVL(c.Minutos, 0) = 0, 0, (a.Minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60))) AS TempoReal ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b, cursor_4c_PcoAgrupado c ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                          AND a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            c.Fases + c.UniPrdts + STR(c.Nenvs, 10) + STR(c.Seqs, 2) ;
                                        ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                                        INTO CURSOR (loc_cCursorGrade) READWRITE

                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDetalheProduto - Busca descricao e imagem (base64) do produto
    * de uma linha da grade (SigCdPro), para exibicao ao trocar a linha
    * selecionada. Equivalente a parte de consulta do AfterRowColChange
    * do legado - decodificar o base64 e gravar o JPG em disco eh
    * responsabilidade do Form (camada de UI), nao do BO.
    *
    * Parametro: par_cCpros - cpros char(14), codigo do produto
    * Popula: cursor this_cCursorProdutoDetalhe (colunas Dpros, FigJpgs)
    * Retorno: .T. se encontrou o produto, .F. caso contrario
    *====================================================================
    FUNCTION ObterDetalheProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
                ELSE
                    IF USED(THIS.this_cCursorProdutoDetalhe)
                        USE IN (THIS.this_cCursorProdutoDetalhe)
                    ENDIF

                    loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProdutoDetalhe)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Produto " + ALLTRIM(par_cCpros) + " n" + CHR(227) + "o encontrado em SigCdPro."
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ObterDetalheProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega o detalhe da LINHA CORRENTE da grade
    * para as propriedades do BO. Equivalente a parte de LEITURA do
    * AfterRowColChange do form legado SIGPRCPD (dump, linhas 1231-1240):
    *     ThisForm.Get_descr.Value   = CrTmpPro.Dpros
    *     ThisForm.Get_qtde.Value    = zTmpPcpOp.Qtds
    *     ThisForm.Get_cliente.Value = zTmpPcpOp.Rclis
    *     ThisForm.Get_tEnv.Value    = zTmpPcpOp.TempU
    * O legado termina o handler com "Select zTmpPcpOp" - reproduzido aqui
    * pelo SELECT (loc_cAlias), para a area de trabalho corrente continuar
    * sendo a da grade quando o metodo retorna (o SQLEXEC do lookup de
    * produto troca a area corrente no meio do caminho).
    *
    * Metodo PUBLIC de proposito: quem chama eh o handler de
    * AfterRowColChange do Form, de FORA da classe. PROTECTED falharia em
    * runtime com "Property CARREGARDOCURSOR is not found", e o
    * PEMSTATUS(oBO, "CarregarDoCursor", 5) que costuma cercar a chamada
    * devolveria .T. sem proteger (so verifica existencia, nao escopo).
    *
    * Parametro: par_cAliasCursor - alias do cursor da grade. Omitido ou
    *            vazio, assume THIS.this_cCursorGrade.
    * Popula: this_cCpros, this_nQtds, this_cRclis, this_nTempU (da linha
    *         corrente da grade) e this_cDpros (lookup em SigCdPro).
    * Retorno: .T. se a linha foi lida - inclusive grade VAZIA, que apenas
    *          limpa o detalhe; .F. so se o cursor da grade nao existe.
    *
    * NOTA sobre retorno .T. com this_cMensagemErro preenchido: falha
    * APENAS no lookup da descricao do produto NAO invalida a leitura da
    * linha. Nesse caso this_cDpros fica vazio, a mensagem eh PRESERVADA
    * para o caller exibir se quiser, e o retorno continua .T.
    *====================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                ALLTRIM(par_cAliasCursor), THIS.this_cCursorGrade)

            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            ELSE
                SELECT (loc_cAlias)

                THIS.LimparDetalhe()

                IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
                    *-- Grade sem linha posicionada: o detalhe fica limpo. O
                    *-- legado nunca chega aqui, porque a grade so dispara
                    *-- AfterRowColChange com uma linha valida selecionada.
                    loc_lSucesso = .T.
                ELSE
                    *-- Leitura por EVALUATE com guarda de TYPE() != "U": coluna
                    *-- ausente no cursor estouraria "Variable X is not found"
                    *-- em RUNTIME, compilando limpo. TratarNulo cobre o valor
                    *-- NULL (2o argumento eh o valor PADRAO, nao codigo de tipo).
                    *-- Tipos conferidos em docs\schema.sql (SigCdPco):
                    *-- cpros char(14), qtds numeric(9,3); Rclis vem do
                    *-- RTRIM(b.rclis) e TempU do SigCdPcg.Minutos numeric(9,1).
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Qtds") != "U"
                        THIS.this_nQtds = TratarNulo(EVALUATE(loc_cAlias + ".Qtds"), 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Rclis") != "U"
                        THIS.this_cRclis = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".TempU") != "U"
                        THIS.this_nTempU = TratarNulo(EVALUATE(loc_cAlias + ".TempU"), 0)
                    ENDIF

                    *-- Descricao do produto (SigCdPro.Dpros), como o legado faz
                    *-- inline no AfterRowColChange. O cursor de detalhe fica
                    *-- disponivel para o Form ler FigJpgs e gerar o JPG (a
                    *-- decodificacao base64 eh responsabilidade da UI).
                    IF !EMPTY(THIS.this_cCpros)
                        IF THIS.ObterDetalheProduto(THIS.this_cCpros)
                            IF TYPE(THIS.this_cCursorProdutoDetalhe + ".Dpros") != "U"
                                THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorProdutoDetalhe + ".Dpros"), ""))
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Repoe a grade como area corrente (o SQLEXEC do lookup
                    *-- selecionou o cursor de detalhe) - "Select zTmpPcpOp".
                    IF USED(loc_cAlias)
                        SELECT (loc_cAlias)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * LimparDetalhe - Zera as propriedades de detalhe da linha (produto,
    * quantidade, cliente e tempo do envelope). Usado no inicio de
    * CarregarDoCursor e quando a grade nao tem linha posicionada, para o
    * painel inferior nao exibir o detalhe da linha ANTERIOR.
    *
    * PUBLIC de proposito: o Form tambem limpa o painel ao recarregar a
    * grade (chamada de FORA da classe - mesma razao de CarregarDoCursor).
    *====================================================================
    PROCEDURE LimparDetalhe()
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""
        THIS.this_nQtds  = 0
        THIS.this_cRclis = ""
        THIS.this_nTempU = 0
    ENDPROC

    *====================================================================
    * FecharCursoresTemporarios - Fecha os cursores intermediarios desta
    * consulta antes de recarregar (evita "Table buffer contains
    * uncommitted changes" numa segunda chamada a CarregarDados).
    *====================================================================
    PROTECTED PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Pcz,cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco," + ;
            "cursor_4c_PcoAgrupado," + THIS.this_cCursorGrade

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Este BO eh somente-consulta (form legado
    * SIGPRCPD nao tem INSERT/UPDATE/DELETE - o comportamento padrao
    * herdado de BusinessBase, que recusa Inserir/Atualizar/
    * ExecutarExclusao, ja eh o correto). Metodo mantido apenas por
    * padrao arquitetural; chave conceitual eh o codigo do Envelope/OP.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

ENDDEFINE

*====================================================================
* ConverterSegundosParaMinutos - Converte um valor em SEGUNDOS para o
* formato decimal Minutos.Segundos (ex.: 755 segundos -> 12.35, ou
* seja, 12 minutos e 35 segundos), usado na coluna "Minutos" da grade
* (Column4, InputMask "9999.99").
*
* Transcricao literal de Function fStoM(pHor) em SIGFUNCS.PRG (Framework
* legado Fortyus, C:\4install\FortyusMC\Fortyus\SIGFUNCS.PRG:188-190):
*   Return Round(Int(pHor/60) + Abs(pHor-(Int(pHor/60)*60))/100, 2)
* Nome novo por exigencia do PILAR 3 - contrato numerico identico ao
* original (mesma entrada/saida para qualquer valor).
*
* Funcao GLOBAL (fora do DEFINE CLASS) para poder ser chamada por nome
* dentro da lista de colunas de um SELECT VFP local, igual ao fStoM(...)
* do legado - config.prg carrega este .prg via ADIR (*BO.prg) e a torna
* disponivel no PATH de procedures do sistema.
*====================================================================
FUNCTION ConverterSegundosParaMinutos(par_nSegundos)
    LOCAL loc_nMinutos

    IF VARTYPE(par_nSegundos) != "N"
        RETURN 0
    ENDIF

    loc_nMinutos = INT(par_nSegundos / 60)
    RETURN ROUND(loc_nMinutos + ABS(par_nSegundos - (loc_nMinutos * 60)) / 100, 2)
ENDFUNC
