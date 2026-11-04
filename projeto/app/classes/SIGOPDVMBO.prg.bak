*==============================================================================
* SIGOPDVMBO.prg
*
* Business Object para SIGOPDVM (Diferencas Vendas x Mapa Resumo)
*
* Este form NAO persiste em tabela propria: ele compara, para a empresa/data
* informados, os cursores ja carregados na data session do form pai
* (crCaixa, crCaixaI, crCaixaFIN, crSigFiMpi) e grava as diferencas no
* cursor crImpressao, que alimenta o Grid1.
*==============================================================================

DEFINE CLASS SIGOPDVMBO AS BusinessBase

    *-- Parametros recebidos do form pai (filtro da comparacao)
    this_cEmps = ""                 && Codigo da empresa (SigFiMpi.emps - char(3))
    this_dDatas = {}                && Data do movimento comparado

    *-- Propriedades do registro corrente de crImpressao (uma linha do Grid)
    this_cCaixas = ""               && Codigo do caixa (SigFiMpi.ncaixa - char(3))
    this_nValCxs = 0                && Valor apurado no caixa (crCaixa/crCaixaFIN)
    this_nValItens = 0              && Valor apurado nos itens (crCaixaI)
    this_nValMrs = 0                && Valor do mapa resumo (crSigFiMpi.VlContabil + Iss)
    this_nValNfs = 0                && Valor nao fiscal

    *-- Cursores de origem: aliases que o form/BO pai ja carregou na mesma
    *-- data session (crCaixa/crCaixaI/crCaixaFIN/crSigFiMpi no legado).
    *-- Ficam vazios por padrao - DefinirCursoresOrigem() os recebe do
    *-- chamador antes de GerarComparacao() rodar.
    this_cCursorCaixa = ""          && Totais por caixa  (Emps, Datas, Ecfs, Valos)
    this_cCursorCaixaItens = ""     && Totais por caixa, itens (mesmas 4 colunas)
    this_cCursorCaixaFin = ""       && Totais por caixa, financeiro (mesmas 4 colunas)
    this_cCursorMapaResumo = ""     && Mapa resumo fiscal (NCaixa, VlContabil, Iss, Isento)

    *-- Cursor de saida que alimenta o Grid1 (crImpressao no legado) -
    *-- este sim eh nosso, por isso tem nome e valor padrao proprios.
    this_cCursorDestino = "cursor_4c_Dados"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- Sem tabela persistida: a comparacao roda sobre cursores
        *-- ja presentes na data session do form pai.
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = "Caixas"

        RETURN .T.
    ENDPROC

    *====================================================================
    * FASE 2/8 - METODOS DE ACESSO AO REGISTRO E GERACAO DA COMPARACAO
    *
    * ESCOPO DESTA FASE NESTE BO
    * --------------------------
    * O trio canonico de um BO de cadastro eh CarregarDoCursor() para ler a
    * linha, Inserir() para o INSERT e Atualizar() para o UPDATE. Este BO
    * nao tem tabela propria (THIS.this_cTabela = "" no Init, de proposito):
    * conferido no dump tasks\task726\SIGOPDVM_form_codigo_fonte.txt, o SCX
    * legado nao tem UMA LINHA de gravacao - zero TABLEUPDATE(, zero
    * .AddCursor(, zero Insert/Update/Delete contra tabela do SQL Server. O
    * UNICO "Insert Into" do legado grava no cursor crImpressao, que eh
    * resultado de CALCULO (comparacao Caixa x Itens x Mapa Resumo), nao
    * persistencia de cadastro.
    *
    * Por isso:
    *   - Inserir(), Atualizar() e ExecutarExclusao() ficam SEM override: o
    *     comportamento herdado de BusinessBase (recusar a operacao e
    *     reportar pelo ExibirFalha do Salvar - regra #20) ja eh o correto,
    *     porque nao existe tabela de destino para gravar. Escrever um
    *     INSERT/UPDATE aqui exigiria adivinhar colunas de uma tabela que
    *     nao existe.
    *   - RegistrarAuditoria() segue herdado pelo mesmo motivo: a base so a
    *     chama em operacao de ESCRITA (Inserir/Atualizar/ExecutarExclusao),
    *     e esta tela nao executa nenhuma.
    *   - ObterChavePrimaria() EH sobrescrito, porque a linha corrente da
    *     grade tem identidade (o codigo do caixa).
    *   - GerarComparacao() EH o metodo que de fato produz dados nesta
    *     tela: transcricao literal do SCAN em dois passos do Init legado
    *     (regra de formula/logica legado - transcrever, nunca reescrever),
    *     substituindo as referencias a pcForm.Pagina.Dados... por
    *     THIS.this_cEmps/this_dDatas e os cursores literais crCaixa/
    *     crCaixaI/crCaixaFIN/crSigFiMpi pelos aliases recebidos via
    *     DefinirCursoresOrigem().
    *
    * ESCOPO DE CADA METODO
    * ---------------------
    *   DefinirCursoresOrigem   recebe os 4 aliases do chamador
    *   DefinirParametrosComparacao  recebe Empresa/Data do chamador
    *   GerarComparacao         transcricao do Init legado - popula o cursor
    *                           de destino com as linhas divergentes
    *   CarregarDoCursor        le a linha corrente do cursor de destino
    *   LimparDados             zera as 5 propriedades de linha
    *   ObterChavePrimaria      codigo do caixa da linha corrente
    *====================================================================

    *====================================================================
    * DefinirCursoresOrigem - recebe os aliases dos cursores de origem
    *
    * par_cCursorCaixa       - crCaixa no legado (Emps, Datas, Ecfs, Valos)
    * par_cCursorCaixaItens  - crCaixaI no legado (mesmas 4 colunas)
    * par_cCursorCaixaFin    - crCaixaFIN no legado (mesmas 4 colunas)
    * par_cCursorMapaResumo  - crSigFiMpi no legado (NCaixa, VlContabil,
    *                          Iss, Isento), ja filtrado por Empresa/Data
    *                          por quem o carregou - este BO so faz SCAN
    *                          nele, igual ao legado.
    *
    * Os 4 parametros sao OBRIGATORIOS (sem eles GerarComparacao nao tem o
    * que comparar). VARTYPE eh conferido porque um alias ausente chega
    * como .F. (logico), nunca como string vazia.
    *
    * Retorno: .T. quando os 4 vieram como texto nao vazio; .F. caso
    * contrario, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirCursoresOrigem(par_cCursorCaixa, par_cCursorCaixaItens, ;
            par_cCursorCaixaFin, par_cCursorMapaResumo)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cCursorCaixa = IIF(VARTYPE(par_cCursorCaixa) = "C", ;
            ALLTRIM(par_cCursorCaixa), "")
        THIS.this_cCursorCaixaItens = IIF(VARTYPE(par_cCursorCaixaItens) = "C", ;
            ALLTRIM(par_cCursorCaixaItens), "")
        THIS.this_cCursorCaixaFin = IIF(VARTYPE(par_cCursorCaixaFin) = "C", ;
            ALLTRIM(par_cCursorCaixaFin), "")
        THIS.this_cCursorMapaResumo = IIF(VARTYPE(par_cCursorMapaResumo) = "C", ;
            ALLTRIM(par_cCursorMapaResumo), "")

        IF EMPTY(THIS.this_cCursorCaixa) OR EMPTY(THIS.this_cCursorCaixaItens) OR ;
                EMPTY(THIS.this_cCursorCaixaFin) OR EMPTY(THIS.this_cCursorMapaResumo)
            THIS.this_cMensagemErro = "Os cursores de caixa, itens, financeiro e " + ;
                "mapa resumo s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DefinirParametrosComparacao - recebe Empresa e Data do chamador
    *
    * par_cEmps  - pcForm.Pagina.Dados.PageFrame1.Page1.Get_emps.Value no
    *              legado (char(3))
    * par_dDatas - pcForm.Pagina.Dados.PageFrame1.Page1.Get_datas.Value no
    *              legado (data do movimento comparado)
    *
    * VARTYPE eh conferido em par_cEmps porque TextBox.Value pode chegar
    * como .F. quando o controle nasceu sem inicializacao, e ALLTRIM de
    * logico dispara o erro 11 do VFP9. par_dDatas aceita DATE ou DATETIME
    * (ConverterParaData normaliza os dois - regra #16, TTOD so aceita
    * DATETIME).
    *
    * Retorno: .T. quando os dois vieram preenchidos; .F. caso contrario,
    * com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE DefinirParametrosComparacao(par_cEmps, par_dDatas)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        THIS.this_cEmps = IIF(VARTYPE(par_cEmps) = "C", ALLTRIM(par_cEmps), "")
        THIS.this_dDatas = ConverterParaData(par_dDatas)

        IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_dDatas)
            THIS.this_cMensagemErro = "Informe Empresa e Data antes de comparar " + ;
                "Vendas x Mapa Resumo."
        ELSE
            THIS.this_cMensagemErro = ""
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarComparacao - transcricao do Init legado (os dois SCAN)
    *
    * PASSO 1 (SCAN em crSigFiMpi): para cada caixa do mapa resumo, soma
    * Valos de crCaixa/crCaixaI/crCaixaFIN filtrados por Empresa + Data +
    * SUBSTR(Ecfs,1,3) = NCaixa. Se o total contabil (VlContabil + Iss +
    * Isento) nao bate com o total do caixa, OU o total do caixa nao bate
    * com o total dos itens, grava uma linha em crImpressao com
    * ValCxs = TotalCaixa - TotalFinanceiro (regra do legado: o financeiro
    * eh DESCONTADO do caixa, nao somado - regra #17, transcrever sem
    * reescrever).
    *
    * PASSO 2 (SCAN no total geral de crCaixa por caixa): cobre o caso
    * oposto - caixa com movimento mas SEM nenhuma linha no mapa resumo
    * (Locate For NCaixa = Caixa / Eof()). Aqui ValCxs eh o total do caixa
    * SEM descontar o financeiro (o legado nao desconta neste ramo - essa
    * assimetria eh regra de negocio, nao erro de transcricao) e ValMrs
    * fica 0.
    *
    * Os cursores de trabalho (equivalentes a crTotCaixa/crTotCaixaI/
    * crTotCaixaFIN do legado) usam sufixo _4c_ proprio e sao fechados no
    * fim do metodo - nao sao cursores que sobrevivem ao form.
    *
    * SELECT (loc_cMapa) + SCAN leem os campos pelo nome NU (NCaixa,
    * VlContabil, Iss, Isento) porque a area de trabalho corrente eh a do
    * cursor - a sintaxe campo nao existe em VFP9. Dentro das
    * SELECT...INTO CURSOR as variaveis locais entram com o prefixo "m."
    * (regra: SELECT VFP local referenciando var local sem "m." estoura
    * "Column ... is not found").
    *
    * Retorno: .T. quando a comparacao rodou (mesmo que zero linhas
    * divergentes tenham sido encontradas - lista vazia eh resultado
    * valido, nao erro); .F. quando faltou parametro/cursor de origem ou
    * SELECT/SCAN estourou, com this_cMensagemErro preenchido.
    *====================================================================
    PROCEDURE GerarComparacao()
        LOCAL loc_lSucesso, loc_cCaixa, loc_cItens, loc_cFin, loc_cMapa, loc_cDestino
        LOCAL loc_cAliasAnterior, loc_dData, loc_cEmps
        LOCAL loc_cCaixaAtual, loc_nVlContabil, loc_nIss, loc_nIsento
        LOCAL loc_nValCxs, loc_nValCxsFin, loc_nValItens
        LOCAL loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()

        loc_cCaixa   = ALLTRIM(THIS.this_cCursorCaixa)
        loc_cItens   = ALLTRIM(THIS.this_cCursorCaixaItens)
        loc_cFin     = ALLTRIM(THIS.this_cCursorCaixaFin)
        loc_cMapa    = ALLTRIM(THIS.this_cCursorMapaResumo)
        loc_cDestino = ALLTRIM(THIS.this_cCursorDestino)
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)
        loc_dData    = THIS.this_dDatas

        TRY
            DO CASE
                CASE EMPTY(loc_cEmps) OR EMPTY(loc_dData)
                    THIS.this_cMensagemErro = "Informe Empresa e Data antes de " + ;
                        "comparar Vendas x Mapa Resumo."

                CASE EMPTY(loc_cCaixa) OR !USED(loc_cCaixa) OR ;
                     EMPTY(loc_cItens) OR !USED(loc_cItens) OR ;
                     EMPTY(loc_cFin) OR !USED(loc_cFin) OR ;
                     EMPTY(loc_cMapa) OR !USED(loc_cMapa)
                    THIS.this_cMensagemErro = "Os cursores de caixa e mapa " + ;
                        "resumo n" + CHR(227) + "o foram recebidos da tela de origem."

                CASE EMPTY(loc_cDestino)
                    THIS.this_cMensagemErro = "Cursor de destino da compara" + ;
                        CHR(231) + CHR(227) + "o n" + CHR(227) + "o definido."

                OTHERWISE
                    *-- Select crImpressao / Zap do legado - recria se nao
                    *-- existir, esvazia se ja existir (mesma estrutura em
                    *-- cada ponto de criacao - regra de CREATE CURSOR).
                    IF USED(loc_cDestino)
                        SELECT (loc_cDestino)
                        ZAP
                    ELSE
                        CREATE CURSOR (loc_cDestino) ;
                            (Datas T, Emps C(3), Caixas C(3), ValCxs N(14,2), ;
                             ValItens N(14,2), ValMrs N(14,2), ValNfs N(14,2))
                    ENDIF

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    *-- PASSO 1 - Scan crSigFiMpi (legado: "Select crSigFiMpi / Scan")
                    SELECT (loc_cMapa)
                    SCAN
                        loc_cCaixaAtual = NCaixa
                        loc_nVlContabil = TratarNulo(VlContabil, 0)
                        loc_nIss = TratarNulo(Iss, 0)
                        loc_nIsento = TratarNulo(Isento, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cCaixa) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixa_4c READWRITE
                        loc_nValCxs = TratarNulo(crTotCaixa_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cItens) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaI_4c READWRITE
                        loc_nValItens = TratarNulo(crTotCaixaI_4c.Valos, 0)

                        SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                            FROM (loc_cFin) ;
                            WHERE Emps = m.loc_cEmps ;
                              AND Datas = m.loc_dData ;
                              AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                            GROUP BY 1 INTO CURSOR crTotCaixaFIN_4c READWRITE
                        loc_nValCxsFin = TratarNulo(crTotCaixaFIN_4c.Valos, 0)

                        IF ROUND(loc_nVlContabil, 2) + ROUND(loc_nIss, 2) + ;
                                ROUND(loc_nIsento, 2) <> ROUND(loc_nValCxs, 2) OR ;
                                ROUND(loc_nValCxs, 2) <> ROUND(loc_nValItens, 2)
                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs - loc_nValCxsFin, loc_nValItens, ;
                                    loc_nVlContabil + loc_nIss)
                        ENDIF

                        SELECT (loc_cMapa)
                    ENDSCAN

                    *-- PASSO 2 - total geral de crCaixa por caixa (legado repete
                    *-- o mesmo Select, sem o filtro de NCaixa, antes do 2o Scan)
                    SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                        FROM (loc_cCaixa) ;
                        WHERE Emps = m.loc_cEmps ;
                          AND Datas = m.loc_dData ;
                        GROUP BY 1 INTO CURSOR crTotCaixaGeral_4c READWRITE

                    SELECT crTotCaixaGeral_4c
                    SCAN
                        loc_cCaixaAtual = cCaixas
                        loc_nValCxs = TratarNulo(Valos, 0)

                        SELECT (loc_cMapa)
                        LOCATE FOR NCaixa = loc_cCaixaAtual

                        IF EOF()
                            SELECT SUBSTR(Ecfs, 1, 3) AS cCaixas, SUM(Valos) AS Valos ;
                                FROM (loc_cItens) ;
                                WHERE Emps = m.loc_cEmps ;
                                  AND Datas = m.loc_dData ;
                                  AND SUBSTR(Ecfs, 1, 3) = m.loc_cCaixaAtual ;
                                GROUP BY 1 INTO CURSOR crTotCaixaI2_4c READWRITE
                            loc_nValItens = TratarNulo(crTotCaixaI2_4c.Valos, 0)

                            INSERT INTO (loc_cDestino) ;
                                (Datas, Emps, Caixas, ValCxs, ValItens, ValMrs) ;
                                VALUES (loc_dData, loc_cEmps, loc_cCaixaAtual, ;
                                    loc_nValCxs, loc_nValItens, 0)
                        ENDIF

                        SELECT crTotCaixaGeral_4c
                    ENDSCAN

                    *-- Select crImpressao / Index On Caixas Tag Caixas / Go Top
                    SELECT (loc_cDestino)
                    IF TAGNO("Caixas", "", loc_cDestino) = 0
                        INDEX ON Caixas TAG Caixas
                    ENDIF
                    SET ORDER TO TAG Caixas
                    GO TOP

                    IF USED("crTotCaixa_4c")
                        USE IN crTotCaixa_4c
                    ENDIF
                    IF USED("crTotCaixaI_4c")
                        USE IN crTotCaixaI_4c
                    ENDIF
                    IF USED("crTotCaixaFIN_4c")
                        USE IN crTotCaixaFIN_4c
                    ENDIF
                    IF USED("crTotCaixaGeral_4c")
                        USE IN crTotCaixaGeral_4c
                    ENDIF
                    IF USED("crTotCaixaI2_4c")
                        USE IN crTotCaixaI2_4c
                    ENDIF

                    THIS.this_cMensagemErro = ""
                    loc_lSucesso = .T.
            ENDCASE
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GerarComparacao")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - le a linha corrente do cursor de destino
    *
    * par_cAliasCursor - alias a ler. Normalmente THIS.this_cCursorDestino,
    *                    mas fica parametrizado para manter a assinatura da
    *                    base (BusinessBase.CarregarDoCursor(pcCursor)).
    *
    * SELECT (alias) antes de tocar nos campos - a sintaxe campo
    * nao existe em VFP9. A area de trabalho anterior eh restaurada no fim
    * (sessao compartilhada com o chamador). A existencia de cada coluna eh
    * conferida com TYPE(alias + ".campo"), nunca com PEMSTATUS (que exige
    * objeto no 1o argumento e estoura com alias de cursor).
    *
    * Retorno: .T. quando havia linha e as 5 propriedades foram
    * preenchidas; .F. quando o alias nao existe, esta em EOF/BOF ou nao
    * tem a estrutura esperada - nesse caso as propriedades sao zeradas.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_cAliasAnterior, loc_oErro

        loc_lSucesso = .F.
        loc_cAliasAnterior = ALIAS()
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        IF EMPTY(loc_cAlias)
            loc_cAlias = ALLTRIM(THIS.this_cCursorDestino)
        ENDIF

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias) ;
                    AND TYPE(loc_cAlias + ".Caixas") != "U" ;
                    AND TYPE(loc_cAlias + ".ValCxs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValItens") != "U" ;
                    AND TYPE(loc_cAlias + ".ValMrs") != "U" ;
                    AND TYPE(loc_cAlias + ".ValNfs") != "U"

                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    THIS.this_cCaixas = ALLTRIM(TratarNulo(Caixas, ""))
                    THIS.this_nValCxs = TratarNulo(ValCxs, 0)
                    THIS.this_nValItens = TratarNulo(ValItens, 0)
                    THIS.this_nValMrs = TratarNulo(ValMrs, 0)
                    THIS.this_nValNfs = TratarNulo(ValNfs, 0)

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                *-- Sem linha para ler: zera, para a tela nao exibir o resto
                *-- de uma leitura anterior como se fosse a linha atual.
                THIS.this_cCaixas = ""
                THIS.this_nValCxs = 0
                THIS.this_nValItens = 0
                THIS.this_nValMrs = 0
                THIS.this_nValNfs = 0
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        *-- Devolve a area de trabalho de quem chamou (sessao compartilhada)
        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - zera as propriedades de linha
    *
    * DODEFAULT() limpa this_cMensagemErro na base. Os parametros da
    * comparacao (this_cEmps/this_dDatas) e os aliases dos cursores de
    * origem/destino NAO sao limpos aqui de proposito: eles identificam a
    * CONSULTA aberta na tela, nao a linha selecionada.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCaixas = ""
        THIS.this_nValCxs = 0
        THIS.this_nValItens = 0
        THIS.this_nValMrs = 0
        THIS.this_nValNfs = 0
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - identidade da linha corrente da grade
    *
    * Sobrescreve o hook de BusinessBase. Continua PROTECTED porque na base
    * ele eh PROTECTED: de fora ninguem chama este metodo (regra #51).
    *
    * A chave eh o codigo do caixa (coluna unica, nao composta - diferente
    * da regra #42 de chave posicional concatenada, que nao se aplica aqui
    * porque so ha UM campo).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCaixas)
    ENDPROC

ENDDEFINE
