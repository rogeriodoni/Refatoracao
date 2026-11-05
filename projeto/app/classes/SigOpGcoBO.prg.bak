*============================================================================
* SigOpGcoBO.prg - Business Object para "Grafico Comparativo" (SIGOPGCO)
*
* Form OPERACIONAL (SIGOPGCO / FormSigOpGco): tela de EXIBICAO de grafico
* (MSGraph.Chart via OleBoundControl), aberta pelo form PAI, que ja processou
* e deixou prontos dois cursores:
*
*   crFinal   - resultado agregado com as colunas Mes, Ordem, Ano, Grupos,
*               Total e npercs, com os tags de ordenacao Grupom e Imp
*               (o Init legado faz "Set order to Grupom" e "Set Order To Imp")
*   Cabecalho - uma linha com pRelTitulo e pPeriodo, usados como subtitulos
*               do grafico (lcStitulo / lcStitulo2 do mostragrafico legado)
*
* O SIGOPGCO NAO consulta o banco: ele apenas agrega/formata o que veio nos
* cursores do pai, monta a matriz TAB/CRLF das series (uma coluna por mes,
* uma linha por grupo) e guarda o binario do grafico num cursor local com
* campo General (Create Cursor Graph (gGraficos Gen(4)) no legado).
*
* O modo de montagem depende do controle Comparativo do form pai
* (Thisform.Parentform.Comparativo.Value): valendo 1, o grupo passa a ser
* Grupos + Ano e os rotulos de percentual (laPerc) sao aplicados as series;
* valendo outro numero, o grupo eh so Grupos e nao ha rotulo de percentual.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega os cursores de origem.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS SigOpGcoBO AS BusinessBase

    *==========================================================================
    * CURSORES DE ORIGEM (fornecidos pelo form PAI - este BO so os consulta)
    *==========================================================================

    *-- crFinal do legado: agregado com Mes, Ordem, Ano, Grupos, Total, npercs
    this_cCursorOrigem = ""

    *-- Cabecalho do legado: uma linha com pRelTitulo e pPeriodo
    this_cCursorCabecalho = ""

    *-- Tags de ordenacao que o Init legado usa sobre o cursor de origem:
    *-- Grupom para varrer os meses e Imp para varrer os grupos na montagem
    this_cOrdemMeses  = ""
    this_cOrdemGrupos = ""

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Cursor Graph do legado (gGraficos Gen(4)): guarda o binario do
    *-- MSGraph.Chart gerado pelo Append General. Eh tambem o alias que o
    *-- OleBoundControl consome via ControlSource e que o Imprimir seleciona
    *-- antes do Report Form.
    this_cCursorGrafico = ""

    *-- Nome do campo General dentro de this_cCursorGrafico. O legado usa
    *-- ControlSource = 'gGraficos', entao o nome eh contrato com o
    *-- OleBoundControl e com o FRX de impressao.
    this_cCampoGeral = ""

    *-- Substitutos dos arrays laMeses e laGrupos do legado (Select Distinct
    *-- ... Into Array). Usamos cursor em vez de ARRAY para nao depender de
    *-- escopo de m.array entre BO e Form.
    this_cCursorMeses  = ""
    this_cCursorGrupos = ""

    *-- Substituto da matriz laPerc(lnNgrupos, lnNmeses) do legado: guarda o
    *-- percentual (npercs) de cada cruzamento grupo x mes, que vira rotulo
    *-- de ponto da serie quando o modo comparativo esta ligado.
    this_cCursorPercentuais = ""

    *==========================================================================
    * CLASSE OLE E RELATORIO
    *==========================================================================

    *-- Classe do Append General do legado: Class 'MsGraph.Chart'
    this_cClasseOLE = ""

    *-- Report Form SigOpGrc To Printer Prompt NoConsole (Click do Imprimir)
    this_cRelatorio = ""

    *==========================================================================
    * TITULOS DO GRAFICO (lcTitulo / lcStitulo / lcStitulo2 / lcStitulo3 e os
    * titulos de eixo lcTitulod / lcTitulov do mostragrafico legado). O
    * charttitle.text concatena os quatro primeiros separados por CHR(13).
    *==========================================================================
    this_cTitulo      = ""
    this_cSubTitulo1  = ""
    this_cSubTitulo2  = ""
    this_cSubTitulo3  = ""
    this_cTituloEixoX = ""
    this_cTituloEixoY = ""

    *==========================================================================
    * TIPO DE GRAFICO - a tabela laTpgra1(2,3) do legado tem duas linhas
    * fixas: COLUNA (-4100, 4) e PIZZA (-4102, 7). O indice vem de
    * lnConta1 = ((At(AllTrim(lcTpReg),'COLUNAPIZZA ')+5)/6), ou seja
    * 1 para COLUNA e 2 para PIZZA.
    *==========================================================================

    *-- lcTpReg do legado, fixo em 'COLUNA' no Init e no mostragrafico
    this_cTipoGrafico = ""

    *-- lnConta1: 1 = COLUNA, 2 = PIZZA
    this_nIndiceTipoGrafico = 1

    *-- Linha 1 da tabela: COLUNA
    this_nGaleriaColuna = -4100
    this_nFormatoColuna = 4

    *-- Linha 2 da tabela: PIZZA
    this_nGaleriaPizza = -4102
    this_nFormatoPizza = 7

    *-- Par efetivamente passado ao autoformat do OleBoundControl, resolvido a
    *-- partir de this_nIndiceTipoGrafico
    this_nGaleriaAtual = -4100
    this_nFormatoAtual = 4

    *==========================================================================
    * CONTAGENS E MODO
    *==========================================================================

    *-- lnNmeses  = Alen(laMeses, 1)  - colunas do grafico
    this_nTotalMeses = 0

    *-- lnNgrupos = Alen(laGrupos, 1) - series do grafico
    this_nTotalGrupos = 0

    *-- lnTmX do legado: tamanho do maior rotulo do eixo X. Passando de 5, o
    *-- mostragrafico gira os rotulos em 90 graus
    *-- (.axes(1).ticklabels.orientation = Iif((lnTmX>5),90,0)).
    this_nTamanhoRotuloX = 0

    *-- Thisform.Parentform.Comparativo.Value: valendo 1, agrupa por
    *-- Grupos + Ano e aplica os rotulos de percentual nas series
    this_nComparativo = 0

    *==========================================================================
    * DADOS DAS SERIES - lcStrg do legado, a matriz inteira que o
    * Append General recebe em Data(). A primeira linha traz os nomes dos
    * meses separados por TAB; cada linha seguinte traz o nome do grupo e os
    * totais, tambem separados por TAB, terminando em CRLF.
    *==========================================================================
    this_cDadosGrafico = ""

    *-- Primeira linha de this_cDadosGrafico, guardada a parte para quem
    *-- precisar so dos rotulos de mes
    this_cLinhaMeses = ""

    *==========================================================================
    * FLAGS DE ESTADO
    *==========================================================================

    *-- .T. quando a montagem produziu matriz nao vazia (If Not Empty(lcStrg)
    *-- do Init legado, que eh o guard do Append General)
    this_lDadosValidos = .F.

    *-- .T. quando o binario do MSGraph.Chart foi gravado no cursor de grafico
    this_lGraficoGerado = .F.

    *==========================================================================
    * Init - Nao ha tabela proprietaria (a tela so exibe/agrega o que o form
    * pai processou), entao this_cTabela e this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho, os titulos fixos
    * e a tabela de tipos de grafico do legado.
    *
    * Init de BO que devolve .F. destroi o objeto e faz o Form abortar o
    * proprio Init, entao aqui nao ha carga de dados: so atribuicao de
    * propriedades, que nao depende de conexao nem de cursor do pai.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Sem tabela proprietaria: este BO nao grava no SQL Server
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            *-- Cursores de origem (crFinal e Cabecalho do legado). O form pai
            *-- pode sobrescrever estes nomes antes de mandar montar o grafico.
            THIS.this_cCursorOrigem    = "crFinal"
            THIS.this_cCursorCabecalho = "Cabecalho"
            THIS.this_cOrdemMeses      = "Grupom"
            THIS.this_cOrdemGrupos     = "Imp"

            *-- Cursores de trabalho criados por este BO
            THIS.this_cCursorGrafico     = "cursor_4c_Grafico"
            THIS.this_cCampoGeral        = "gGraficos"
            THIS.this_cCursorMeses       = "cursor_4c_Meses"
            THIS.this_cCursorGrupos      = "cursor_4c_Grupos"
            THIS.this_cCursorPercentuais = "cursor_4c_Percentuais"

            *-- Classe OLE do Append General e FRX do botao Imprimir
            THIS.this_cClasseOLE = "MsGraph.Chart"
            THIS.this_cRelatorio = "SigOpGrc"

            *-- Titulos fixos do mostragrafico legado. Os subtitulos 1 e 2 vem
            *-- do cursor Cabecalho e sao preenchidos na montagem.
            THIS.this_cTitulo      = "Gr" + CHR(225) + "fico Comparativo"
            THIS.this_cSubTitulo1  = ""
            THIS.this_cSubTitulo2  = ""
            THIS.this_cSubTitulo3  = "Todas as Empresas"
            THIS.this_cTituloEixoX = ""
            THIS.this_cTituloEixoY = "Desempenho"

            *-- Tabela de tipos do legado e o tipo corrente (lcTpReg = 'COLUNA',
            *-- logo lnConta1 = 1 e o par ativo eh o da linha COLUNA)
            THIS.this_cTipoGrafico       = "COLUNA"
            THIS.this_nGaleriaColuna     = -4100
            THIS.this_nFormatoColuna     = 4
            THIS.this_nGaleriaPizza      = -4102
            THIS.this_nFormatoPizza      = 7
            THIS.this_nIndiceTipoGrafico = 1
            THIS.this_nGaleriaAtual      = THIS.this_nGaleriaColuna
            THIS.this_nFormatoAtual      = THIS.this_nFormatoColuna

            *-- Contagens e modo comecam zerados; a montagem os resolve a partir
            *-- dos cursores do pai
            THIS.this_nTotalMeses     = 0
            THIS.this_nTotalGrupos    = 0
            THIS.this_nTamanhoRotuloX = 0
            THIS.this_nComparativo    = 0

            *-- Series ainda sem conteudo
            THIS.this_cDadosGrafico = ""
            THIS.this_cLinhaMeses   = ""

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FASE 2 - METODOS CRUD: decisao de projeto (BO somente-leitura)
    *
    * O dump do legado (SigOpGco_form_codigo_fonte.txt) nao tem nenhum
    * TABLEUPDATE(, nenhum .AddCursor( e nenhum "Insert Into"/"Update "/
    * "Delete From" contra tabela remota - o unico alvo de escrita e o
    * cursor LOCAL "Graph" (Create Cursor Graph (gGraficos Gen(4)) seguido
    * de Append Blank + Append General), que aqui vira
    * this_cCursorGrafico/cursor_4c_Grafico. Este BO so LE crFinal e
    * Cabecalho (preenchidos pelo form PAI) e agrega.
    *
    * Por isso o trabalho real desta fase fica concentrado em
    * CarregarDoCursor() (agregacao de crFinal + Cabecalho nos cursores de
    * trabalho e na matriz this_cDadosGrafico), e Inserir()/Atualizar()
    * NAO sao sobrescritos aqui: o comportamento herdado de BusinessBase
    * (recusar a operacao com mensagem de erro) ja eh o correto para uma
    * tela que nunca grava registro em tabela do SQL Server.
    * ObterChavePrimaria() tambem fica herdado (devolve "") porque nao ha
    * chave primaria - a tela nao representa uma linha de tabela, entao
    * RegistrarAuditoria() nunca chega a ser chamado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Agrega os cursores do form pai (crFinal + Cabecalho)
    * e monta a matriz TAB/CRLF que o Append General do grafico espera
    * (lcStrg do legado), alem dos cursores de trabalho de meses/grupos e
    * da matriz de percentuais.
    *
    * Nao ha "registro" para carregar (este BO nao representa uma linha de
    * tabela): par_cCursorOrigem/par_cCursorCabecalho substituem os nomes
    * padrao this_cCursorOrigem/this_cCursorCabecalho quando o form pai
    * usar outro alias. THIS.this_nComparativo deve ser atribuido pelo
    * Form ANTES de chamar este metodo - eh o equivalente a
    * Thisform.Parentform.Comparativo.Value do legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorOrigem, par_cCursorCabecalho)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrigem, loc_cCabecalho
        LOCAL loc_nMes, loc_cMesNome, loc_cLinhaMeses, loc_cStrg
        LOCAL loc_cGrupoAtual, loc_nMesPos, loc_nGrupoPos
        loc_lResultado = .F.

        TRY
            loc_cOrigem    = IIF(EMPTY(par_cCursorOrigem), THIS.this_cCursorOrigem, par_cCursorOrigem)
            loc_cCabecalho = IIF(EMPTY(par_cCursorCabecalho), THIS.this_cCursorCabecalho, par_cCursorCabecalho)

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            IF !USED(loc_cOrigem) OR !USED(loc_cCabecalho)
                THIS.this_cMensagemErro = "Cursores de origem n" + CHR(227) + "o encontrados."
                loc_lResultado = .F.
            ELSE
                THIS.this_cCursorOrigem    = loc_cOrigem
                THIS.this_cCursorCabecalho = loc_cCabecalho

                *-- Subtitulos (lcStitulo/lcStitulo2 do legado - Cabecalho.
                *-- pRelTitulo / Cabecalho.pPeriodo, uma linha so)
                SELECT (loc_cCabecalho)
                GO TOP
                THIS.this_cSubTitulo1 = TratarNulo(EVALUATE(loc_cCabecalho + ".pRelTitulo"), "")
                THIS.this_cSubTitulo2 = TratarNulo(EVALUATE(loc_cCabecalho + ".pPeriodo"), "")

                *-- lnTmX do legado: nunca foi atribuido antes deste ponto,
                *-- entao Iif(Type('lnTmX')=='N',lnTmX,0) sempre resolve 0
                THIS.this_nTamanhoRotuloX = 0

                *-- Meses distintos (Select Distinct Mes From crFinal Into
                *-- Array laMeses do legado - aqui, cursor em vez de array)
                IF USED(THIS.this_cCursorMeses)
                    USE IN (THIS.this_cCursorMeses)
                ENDIF
                SELECT DISTINCT Mes FROM (loc_cOrigem) ORDER BY Mes INTO CURSOR (THIS.this_cCursorMeses)

                *-- Grupos distintos (Select Distinct Str(Ordem,1)+Str(Ano,4)
                *-- As cGrupos do legado)
                IF USED(THIS.this_cCursorGrupos)
                    USE IN (THIS.this_cCursorGrupos)
                ENDIF
                SELECT DISTINCT (STR(Ordem, 1) + STR(Ano, 4)) AS cGrupos ;
                    FROM (loc_cOrigem) ;
                    INTO CURSOR (THIS.this_cCursorGrupos)

                THIS.this_nTotalMeses  = RECCOUNT(THIS.this_cCursorMeses)
                THIS.this_nTotalGrupos = RECCOUNT(THIS.this_cCursorGrupos)

                *-- Matriz de percentuais (laPerc(nGrupos,nMeses) do legado) -
                *-- um cursor com uma linha por cruzamento grupo x mes, no
                *-- lugar do array bidimensional
                IF USED(THIS.this_cCursorPercentuais)
                    USE IN (THIS.this_cCursorPercentuais)
                ENDIF
                CREATE CURSOR (THIS.this_cCursorPercentuais) ;
                    (nGrupoPos N(6,0), nMesPos N(6,0), nPercentual N(20,0))

                *-- Linha 1 da matriz: nomes dos meses, varrendo crFinal
                *-- ordenado por this_cOrdemMeses (tag Grupom do legado)
                SELECT (loc_cOrigem)
                IF TAGNO(THIS.this_cOrdemMeses, "", loc_cOrigem) > 0
                    SET ORDER TO TAG (THIS.this_cOrdemMeses) IN (loc_cOrigem)
                ENDIF
                GO TOP IN (loc_cOrigem)

                loc_cLinhaMeses = ""
                loc_nMes = EVALUATE(loc_cOrigem + ".Mes")
                SCAN
                    DO CASE
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 1
                            loc_cMesNome = "Janeiro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 2
                            loc_cMesNome = "Fevereiro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 3
                            loc_cMesNome = "Mar" + CHR(231) + "o"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 4
                            loc_cMesNome = "Abril"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 5
                            loc_cMesNome = "Maio"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 6
                            loc_cMesNome = "Junho"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 7
                            loc_cMesNome = "Julho"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 8
                            loc_cMesNome = "Agosto"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 9
                            loc_cMesNome = "Setembro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 10
                            loc_cMesNome = "Outubro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 11
                            loc_cMesNome = "Novembro"
                        CASE EVALUATE(loc_cOrigem + ".Mes") = 12
                            loc_cMesNome = "Dezembro"
                        OTHERWISE
                            loc_cMesNome = ""
                    ENDCASE
                    loc_cLinhaMeses = loc_cLinhaMeses + CHR(9) + ALLTRIM(loc_cMesNome)
                    DO WHILE EVALUATE(loc_cOrigem + ".Mes") = loc_nMes AND !EOF(loc_cOrigem)
                        IF !EOF(loc_cOrigem)
                            SKIP IN (loc_cOrigem)
                        ENDIF
                    ENDDO
                    loc_nMes = EVALUATE(loc_cOrigem + ".Mes")
                ENDSCAN
                loc_cStrg = loc_cLinhaMeses + CHR(13) + CHR(10)
                THIS.this_cLinhaMeses = loc_cLinhaMeses

                *-- Linhas seguintes: uma por grupo, varrendo crFinal
                *-- ordenado por this_cOrdemGrupos (tag Imp do legado)
                SELECT (loc_cOrigem)
                IF TAGNO(THIS.this_cOrdemGrupos, "", loc_cOrigem) > 0
                    SET ORDER TO TAG (THIS.this_cOrdemGrupos) IN (loc_cOrigem)
                ENDIF
                GO TOP IN (loc_cOrigem)

                DO WHILE !EOF(loc_cOrigem)
                    IF THIS.this_nComparativo = 1
                        *-- CHAVE do grupo: concatenacao CRUA, com o padding
                        *-- do char(20) - eh ela que o SCAN WHILE compara,
                        *-- posicao por posicao (legado: lcgrupo =
                        *-- crFinal.Grupos + str(crFinal.ano,4)).
                        loc_cGrupoAtual = EVALUATE(loc_cOrigem + ".Grupos") + STR(EVALUATE(loc_cOrigem + ".Ano"), 4)

                        *-- ROTULO da serie: o legado ALLTRIMa so a coluna
                        *-- Grupos e DEPOIS cola o ano
                        *--   lcStrg + ALLTRIM(crFinal.Grupos) + str(crFinal.ano,4)
                        *-- ALLTRIM na concatenacao INTEIRA nao eh o mesmo:
                        *-- ele so tira as pontas e deixa os espacos do
                        *-- meio, entao a legenda do grafico sairia
                        *-- "LOJA A              2025" (os 14 brancos do
                        *-- char(20)) em vez de "LOJA A2025". Compila limpo
                        *-- e so aparece na legenda do chart.
                        loc_cStrg = loc_cStrg + ALLTRIM(EVALUATE(loc_cOrigem + ".Grupos")) + ;
                            STR(EVALUATE(loc_cOrigem + ".Ano"), 4)
                        SCAN WHILE EVALUATE(loc_cOrigem + ".Grupos") + STR(EVALUATE(loc_cOrigem + ".Ano"), 4) = loc_cGrupoAtual
                            loc_cStrg = loc_cStrg + CHR(9) + STR(EVALUATE(loc_cOrigem + ".Total"))

                            loc_nMesPos   = THIS.ObterPosicaoMes(EVALUATE(loc_cOrigem + ".Mes"))
                            loc_nGrupoPos = THIS.ObterPosicaoGrupo(STR(EVALUATE(loc_cOrigem + ".Ordem"), 1) + STR(EVALUATE(loc_cOrigem + ".Ano"), 4))

                            IF loc_nMesPos > 0 AND loc_nGrupoPos > 0
                                INSERT INTO (THIS.this_cCursorPercentuais) (nGrupoPos, nMesPos, nPercentual) ;
                                    VALUES (loc_nGrupoPos, loc_nMesPos, EVALUATE(loc_cOrigem + ".npercs"))
                            ENDIF
                        ENDSCAN
                    ELSE
                        loc_cGrupoAtual = EVALUATE(loc_cOrigem + ".Grupos")
                        loc_cStrg = loc_cStrg + ALLTRIM(loc_cGrupoAtual)
                        SCAN WHILE EVALUATE(loc_cOrigem + ".Grupos") = loc_cGrupoAtual
                            loc_cStrg = loc_cStrg + CHR(9) + STR(EVALUATE(loc_cOrigem + ".Total"))
                        ENDSCAN
                    ENDIF
                    loc_cStrg = loc_cStrg + CHR(13) + CHR(10)
                    SELECT (loc_cOrigem)
                ENDDO

                SELECT (loc_cOrigem)
                GO TOP

                THIS.this_cDadosGrafico = loc_cStrg
                THIS.this_lDadosValidos = !EMPTY(loc_cStrg)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPosicaoMes - Equivalente a Ascan(laMeses, <mes>) do legado: devolve
    * a posicao (1-based) do mes dentro de this_cCursorMeses, ou 0 se nao
    * achar. Usado para localizar a coluna da matriz de percentuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterPosicaoMes(par_nMes)
        LOCAL loc_nPos, loc_nAreaAnterior
        loc_nPos = 0

        IF USED(THIS.this_cCursorMeses)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorMeses)
            LOCATE FOR Mes = par_nMes
            IF FOUND()
                loc_nPos = RECNO()
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPos
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPercentual - Leitura da matriz de percentuais pela posicao
    * (grupo, mes). Equivalente a m.laPerc(lnGrupopos, lnMespos) do legado,
    * que o mostragrafico le para montar o Caption do rotulo de cada ponto.
    *
    * PUBLIC de proposito: quem le eh o FORM, porque o rotulo eh propriedade
    * de objeto OLE e OLE nao entra no BO (PILAR 3). Metodo que o form chama
    * de fora NUNCA pode ser PROTECTED em nivel nenhum da heranca
    * (CLAUDE.md regra #51) - PROTECTED aqui estouraria
    * "Property OBTERPERCENTUAL is not found" em runtime, ao desenhar.
    *
    * Devolve 0 quando o cruzamento nao existe, que eh o mesmo valor com que
    * o legado inicializa o array inteiro ("m.laPerc = 0").
    *
    * Repoe area de trabalho E RECNO: o cursor de percentuais eh lido em laco
    * pelo form (um ponto por mes, para cada grupo) e mover o ponteiro sem
    * repor faria quem chama perder o lugar.
    *--------------------------------------------------------------------------
    PROCEDURE ObterPercentual(par_nGrupoPos, par_nMesPos)
        LOCAL loc_nPercentual, loc_nAreaAnterior, loc_nRecnoAnterior
        loc_nPercentual = 0

        IF USED(THIS.this_cCursorPercentuais)
            loc_nAreaAnterior  = SELECT()
            SELECT (THIS.this_cCursorPercentuais)
            loc_nRecnoAnterior = RECNO()

            LOCATE FOR nGrupoPos = par_nGrupoPos AND nMesPos = par_nMesPos
            IF FOUND()
                loc_nPercentual = NVL(nPercentual, 0)
            ENDIF

            IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT())
                GO loc_nRecnoAnterior
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPercentual
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterPosicaoGrupo - Equivalente a Ascan(laGrupos, <chave>) do legado:
    * devolve a posicao (1-based) do grupo (Str(Ordem,1)+Str(Ano,4)) dentro
    * de this_cCursorGrupos, ou 0 se nao achar. Usado para localizar a linha
    * da matriz de percentuais.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterPosicaoGrupo(par_cChaveGrupo)
        LOCAL loc_nPos, loc_nAreaAnterior
        loc_nPos = 0

        IF USED(THIS.this_cCursorGrupos)
            loc_nAreaAnterior = SELECT()
            SELECT (THIS.this_cCursorGrupos)
            LOCATE FOR cGrupos = par_cChaveGrupo
            IF FOUND()
                loc_nPos = RECNO()
            ENDIF
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_nPos
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores de trabalho que ESTE BO cria em
    * CarregarDoCursor (Meses, Grupos e Percentuais).
    *
    * ACRESCENTADO NA FASE 8, porque a limpeza nao existia em lugar nenhum: o
    * Destroy do FormSigOpGco afirmava, em comentario, que "o BO fecha os
    * cursores de trabalho que ele mesmo cria", e nao havia nem Destroy nem
    * metodo de limpeza aqui. Os tres aliases ficavam ABERTOS depois que a tela
    * fechava - e, como aquele form entra na data session do form PAI quando ha
    * pai, o vazamento nem morria com a tela: ficava pendurado na sessao de quem
    * abriu, ate o PAI ser fechado.
    *
    * NAO fecha o cursor do GRAFICO (this_cCursorGrafico): quem o cria eh o
    * Form (CREATE CURSOR ... (gGraficos G(4)) em GerarGrafico), porque ele eh
    * consumido por objeto OLE - e OLE nao entra no BO (PILAR 3). Quem cria,
    * fecha: o Destroy do Form cuida dele, logo antes de chamar este metodo.
    *
    * NAO fecha crFinal nem Cabecalho: sao do form PAI, que os processou antes
    * de abrir o grafico e pode precisar deles depois - derruba-los daqui
    * tiraria o chao de quem chamou.
    *
    * PUBLIC (sem PROTECTED): quem chama eh o Form, de FORA da classe. Metodo
    * chamado de fora NUNCA pode ser PROTECTED em nivel nenhum da heranca
    * (CLAUDE.md regra #51) - PROTECTED aqui estouraria
    * "Property LIMPARCURSORES is not found" ao fechar a tela.
    *
    * Guard por BUFFERING e nao so por USED(): sem buffering o TABLEREVERT nao
    * eh no-op, dispara o erro 1586 (CLAUDE.md regra #52). Cursor de
    * CREATE CURSOR e de SELECT ... INTO CURSOR nasce com Buffering = 1, entao
    * na pratica o TABLEREVERT eh pulado e o USE IN fecha o alias de qualquer
    * forma - o ramo existe para o caso de alguem ligar buffering depois.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        LOCAL ARRAY loc_aCursores[3]
        LOCAL loc_nI, loc_cAlias, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        loc_aCursores[1] = THIS.this_cCursorMeses
        loc_aCursores[2] = THIS.this_cCursorGrupos
        loc_aCursores[3] = THIS.this_cCursorPercentuais

        TRY
            FOR loc_nI = 1 TO ALEN(loc_aCursores, 1)
                loc_cAlias = IIF(VARTYPE(loc_aCursores[loc_nI]) = "C", ;
                    ALLTRIM(loc_aCursores[loc_nI]), "")

                IF !EMPTY(loc_cAlias)
                    IF USED(loc_cAlias)
                        IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                            TABLEREVERT(.T., loc_cAlias)
                        ENDIF
                        USE IN (loc_cAlias)
                    ENDIF
                ENDIF
            ENDFOR

            *-- O conteudo agregado morre junto com os cursores: deixar as
            *-- contagens e a matriz de series de pe faria um GerarGrafico
            *-- seguinte achar que ja ha dado valido sem ter recarregado nada.
            THIS.this_nTotalMeses    = 0
            THIS.this_nTotalGrupos   = 0
            THIS.this_cDadosGrafico  = ""
            THIS.this_cLinhaMeses    = ""
            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpGcoBO.LimparCursores")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
