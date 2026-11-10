*============================================================================
* SIGOPGRCBO.prg - Business Object para "Grafico Comparativo" (SIGOPGRC)
*
* Form OPERACIONAL (SIGOPGRC / FormSIGOPGRC): tela de EXIBICAO de grafico
* (MsGraph.Chart via OleBoundControl), aberta pelo form PAI, que ja processou
* e deixou pronto o cursor de origem:
*
*   crFinal - resultado agregado com as colunas Mes, Ordem, Ano, Grupos,
*             Total e npercs (series do grafico) e, ainda, dtini, dtfinal,
*             lcGrupo1, lcGrupo2 e lcMoe (usadas apenas como subtitulos).
*             Chega com os tags de ordenacao Grupom e imp - o Init legado faz
*             "Set order to Grupom" para varrer os meses e "Set order to imp"
*             para varrer os grupos.
*
* O SIGOPGRC NAO consulta o banco: ele apenas agrega/formata o que veio no
* cursor do pai, monta a matriz TAB/CRLF das series (uma coluna por mes, uma
* linha por grupo) e guarda o binario do grafico num cursor local com campo
* General (Create Cursor Graph (gGraficos Gen (4)) no legado).
*
* O modo de montagem depende do controle Comparativo do form pai
* (Thisform.Parentform.Comparativo.value): valendo 1, o grupo passa a ser
* Grupos + Ano e os percentuais (npercs) viram rotulo de ponto das series;
* valendo outro numero, o grupo eh so Grupos e nao ha rotulo de percentual.
*
* DIFERENCAS MEDIDAS CONTRA O GEMEO SIGOPGCO (task739 / SigOpGcoBO) - as duas
* telas sao quase identicas, e por isso estas tres divergencias precisam ficar
* escritas, para nenhuma fase seguinte copiar o irmao por reflexo:
*
*   1) NAO existe cursor "Cabecalho" aqui. O SIGOPGCO tira os subtitulos de
*      Cabecalho.pRelTitulo / Cabecalho.pPeriodo; o SIGOPGRC monta os tres
*      subtitulos a partir de colunas do PROPRIO crFinal mais a opcao de
*      cotacao do pai (mostragrafico legado):
*        lcStitulo  = dtoc(crFinal.dtini) + ' ate ' + dtoc(crFinal.dtfinal)
*        lcStitulo2 = alltrim(crFinal.lcGrupo1) + ' / ' + alltrim(crFinal.lcGrupo2)
*        lcStitulo3 = 'Moeda ' + Iif(ParentForm.OptCotacao.value=1,
*                     'Fechamento : ', 'Movimentacao : ') + crFinal.lcMoe
*      Logo o subtitulo 3 NAO eh a constante "Todas as Empresas" do SIGOPGCO.
*      (Os literais acentuados do legado estao transcritos via CHR() nas
*      propriedades abaixo - aqui no comentario ficam sem acento de proposito.)
*
*   2) Entrada extra vinda do pai: Thisform.ParentForm.OptCotacao.value, que
*      escolhe o rotulo de moeda do subtitulo 3 (this_nOpcaoCotacao).
*
*   3) O SIGOPGRC poe APENAS ".HasSeriesLines = .f." no ChartGroups(1). O
*      SIGOPGCO tem, adiante no mesmo metodo, um
*      ".chartgroups(1).hasserieslines = .t." que o SIGOPGRC NAO tem - aqui o
*      valor efetivo eh .F. (this_lSerieLinhas).
*
* O "Load" legado ("=fConfigGeral()") nao gera metodo neste BO: fConfigGeral
* era inicializacao GLOBAL da aplicacao Fortyus e na arquitetura nova isso ja
* acontece antes (config.prg / main.prg / cada BO com seus cursores). O
* wrapper projeto\app\utils\fconfiggeral.prg existe so para o p-code dos VCX
* legado, e em codigo nosso nao se chama essa funcao.
*
* Nao existe tabela proprietaria (this_cTabela fica vazio): este BO nao faz
* INSERT/UPDATE/DELETE contra o SQL Server, so agrega o cursor de origem.
*
* DOIS DEFEITOS CORRIGIDOS NA REVISAO DA FASE 8 (2026-11-06) - os dois
* compilavam limpo e so quebravam em runtime, no clique do usuario:
*
*   1) this_cCursorGrafico voltou a ser o alias "Graph" do LEGADO. Ele estava
*      como "cursor_4c_Grafico", seguindo a convencao de nome do projeto, mas
*      o SigOpGrc.frx cita [Graph.gGraficos] LITERALMENTE no registro do OLE
*      Bound Control (lido como DBF em 2026-11-06) - o Report Form do botao
*      Imprimir estouraria "Alias GRAPH is not found" e o grafico nunca
*      imprimiria. Alias que um FRX cita eh CONTRATO do relatorio, igual a
*      nome de coluna do banco: o PILAR 3 nao o renomeia. Ver a property.
*
*   2) CarregarDoCursor recuperou o "Order By 1" do Select Distinct dos
*      GRUPOS, que a migracao tinha descartado. A posicao da linha nesse
*      cursor eh o indice do grupo na matriz de percentuais (o
*      Ascan(laGrupos,...) do legado), lido depois pelo rotulo de cada ponto
*      da serie - sem ordenacao garantida o percentual podia sair na serie
*      errada, sem erro e sem log.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Revisado em: Fase 8 - Consolidacao final (os dois itens acima)
*============================================================================

DEFINE CLASS SIGOPGRCBO AS BusinessBase

    *==========================================================================
    * CURSOR DE ORIGEM (fornecido pelo form PAI - este BO so o consulta)
    *==========================================================================

    *-- crFinal do legado: agregado com Mes, Ordem, Ano, Grupos, Total e
    *-- npercs para as series, mais dtini, dtfinal, lcGrupo1, lcGrupo2 e lcMoe
    *-- para os subtitulos do grafico
    this_cCursorOrigem = ""

    *-- Tags de ordenacao que o Init legado usa sobre o cursor de origem:
    *-- Grupom para varrer os meses e imp para varrer os grupos na montagem
    this_cOrdemMeses  = ""
    this_cOrdemGrupos = ""

    *==========================================================================
    * CURSORES DE TRABALHO (criados por este BO)
    *==========================================================================

    *-- Cursor Graph do legado (gGraficos Gen (4)): guarda o binario do
    *-- MsGraph.Chart gerado pelo Append General. Eh tambem o alias que o
    *-- OleBoundControl consome via ControlSource e que o Imprimir seleciona
    *-- antes do Report Form.
    *--
    *-- O ALIAS DESTE CURSOR EH CONTRATO DO FRX - o PILAR 3 nao o renomeia.
    *-- Medido em 2026-11-06 lendo o SigOpGrc.frx como DBF: o registro 5
    *-- (ObjType = 17, OLE Bound Control) tem Name = [Graph.gGraficos], ou
    *-- seja o relatorio cita o alias LITERAL "Graph" do legado. Batiza-lo
    *-- "cursor_4c_Grafico" seguindo a convencao de nome do projeto faz o
    *-- Report Form do botao Imprimir estourar "Alias GRAPH is not found" -
    *-- compila limpo e so quebra quando o usuario aciona Imprimir. Mesma
    *-- natureza de nome de coluna do banco (PILAR 2): eh dado do
    *-- relatorio, nao nome escolhido pelo migrador.
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

    *-- Report form SigOpGrc to printer prompt noconsole (Click do Imprimir)
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
    * LITERAIS DOS SUBTITULOS - transcritos do mostragrafico legado. Ficam em
    * propriedade (e nao soltos no meio da montagem) porque sao as unicas
    * partes FIXAS das tres formulas de subtitulo do SIGOPGRC, e eh por elas
    * que esta tela difere do gemeo SIGOPGCO.
    *==========================================================================

    *-- " at" + CHR(233) + " " : separador do periodo (dtini / dtfinal)
    this_cSeparadorPeriodo = ""

    *-- " / " : separador entre lcGrupo1 e lcGrupo2
    this_cSeparadorGrupos = ""

    *-- "Moeda " : prefixo do subtitulo 3, antes do rotulo de cotacao
    this_cPrefixoMoeda = ""

    *-- Os dois rotulos de cotacao do Iif legado. O teste do legado eh
    *-- "OptCotacao.value = 1": valendo 1 sai Fechamento, qualquer outro
    *-- valor sai Movimentacao. Os espacos antes dos dois-pontos fazem parte
    *-- do literal do legado e nao se "arrumam".
    this_cRotuloCotacaoFechamento   = ""
    this_cRotuloCotacaoMovimentacao = ""

    *==========================================================================
    * TIPO DE GRAFICO - a tabela laTpgra1(2,3) do legado tem duas linhas
    * fixas: COLUNA (-4100, 4) e PIZZA (-4102, 7). O indice vem de
    * lnConta1 = ((At(AllTrim(lcTpReg),'COLUNAPIZZA ')+5)/6), ou seja
    * 1 para COLUNA e 2 para PIZZA.
    *==========================================================================

    *-- lcTpReg do legado, fixo em "COLUNA" no Init e no mostragrafico
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

    *-- lnNmeses = Alen(laMeses,1) - colunas do grafico
    this_nTotalMeses = 0

    *-- lnNgrupos = Alen(laGrupos,1) - series do grafico
    this_nTotalGrupos = 0

    *-- lnTmX do legado: tamanho do maior rotulo do eixo X. Passando de 5, o
    *-- mostragrafico gira os rotulos em 90 graus
    *-- (.axes(1).ticklabels.orientation = Iif((lnTmX>5),90,0)).
    this_nTamanhoRotuloX = 0

    *-- Thisform.Parentform.Comparativo.value: valendo 1, agrupa por
    *-- Grupos + Ano e aplica os rotulos de percentual nas series
    this_nComparativo = 0

    *-- Thisform.ParentForm.OptCotacao.value: valendo 1, o subtitulo 3 sai com
    *-- this_cRotuloCotacaoFechamento; qualquer outro valor sai com
    *-- this_cRotuloCotacaoMovimentacao. Entrada que o SIGOPGCO nao tem.
    this_nOpcaoCotacao = 0

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

    *-- ChartGroups(1).HasSeriesLines. No SIGOPGRC o legado poe .f. e NAO tem
    *-- o ".chartgroups(1).hasserieslines = .t." que o SIGOPGCO tem adiante no
    *-- mesmo metodo - por isso o valor efetivo aqui eh .F.
    this_lSerieLinhas = .F.

    *-- .T. quando a montagem produziu matriz nao vazia (If !IsEmpty(lcStrg)
    *-- do Init legado, que eh o guard do Append General)
    this_lDadosValidos = .F.

    *-- .T. quando o binario do MsGraph.Chart foi gravado no cursor de grafico
    this_lGraficoGerado = .F.

    *==========================================================================
    * Init - Nao ha tabela proprietaria (a tela so exibe/agrega o que o form
    * pai processou), entao this_cTabela e this_cCampoChave ficam vazios.
    * Inicializa os nomes canonicos dos cursores de trabalho, os titulos e
    * literais fixos e a tabela de tipos de grafico do legado.
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

            *-- Cursor de origem (crFinal do legado) e seus dois tags. O form
            *-- pai pode sobrescrever estes nomes antes de mandar montar o
            *-- grafico. Nao ha cursor Cabecalho nesta tela.
            THIS.this_cCursorOrigem = "crFinal"
            THIS.this_cOrdemMeses   = "Grupom"
            THIS.this_cOrdemGrupos  = "imp"

            *-- Cursores de trabalho criados por este BO
            *-- "Graph" e nao "cursor_4c_Grafico": o SigOpGrc.frx cita
            *-- Graph.gGraficos literalmente (ver a property la em cima)
            THIS.this_cCursorGrafico     = "Graph"
            THIS.this_cCampoGeral        = "gGraficos"
            THIS.this_cCursorMeses       = "cursor_4c_Meses"
            THIS.this_cCursorGrupos      = "cursor_4c_Grupos"
            THIS.this_cCursorPercentuais = "cursor_4c_Percentuais"

            *-- Classe OLE do Append General e FRX do botao Imprimir
            THIS.this_cClasseOLE = "MsGraph.Chart"
            THIS.this_cRelatorio = "SigOpGrc"

            *-- Titulos do mostragrafico legado. Dos quatro, so o titulo e o
            *-- titulo do eixo Y sao fixos; os tres subtitulos sao montados a
            *-- partir de crFinal e de this_nOpcaoCotacao, e o titulo do eixo
            *-- X eh vazio no legado (lcTitulod = '').
            THIS.this_cTitulo      = "Gr" + CHR(225) + "fico Comparativo"
            THIS.this_cSubTitulo1  = ""
            THIS.this_cSubTitulo2  = ""
            THIS.this_cSubTitulo3  = ""
            THIS.this_cTituloEixoX = ""
            THIS.this_cTituloEixoY = "Desempenho"

            *-- Literais fixos das formulas dos subtitulos, transcritos do
            *-- legado: " ate ", " / ", "Moeda ", "Fechamento : " e
            *-- "Movimentacao : " (acentos via CHR(), regra #4)
            THIS.this_cSeparadorPeriodo = " at" + CHR(233) + " "
            THIS.this_cSeparadorGrupos  = " / "
            THIS.this_cPrefixoMoeda     = "Moeda "

            THIS.this_cRotuloCotacaoFechamento   = "Fechamento : "
            THIS.this_cRotuloCotacaoMovimentacao = "Movimenta" + CHR(231) + CHR(227) + "o : "

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
            *-- do cursor do pai. this_nComparativo e this_nOpcaoCotacao sao
            *-- atribuidos pelo Form, que le os dois controles do form pai.
            THIS.this_nTotalMeses     = 0
            THIS.this_nTotalGrupos    = 0
            THIS.this_nTamanhoRotuloX = 0
            THIS.this_nComparativo    = 0
            THIS.this_nOpcaoCotacao   = 0

            *-- Series ainda sem conteudo
            THIS.this_cDadosGrafico = ""
            THIS.this_cLinhaMeses   = ""

            *-- O legado desta tela nunca liga as linhas de serie
            THIS.this_lSerieLinhas = .F.

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
    * O dump do legado (SIGOPGRC_form_codigo_fonte.txt) nao tem nenhum
    * TABLEUPDATE(, nenhum .AddCursor( e nenhum "Insert Into"/"Update "/
    * "Delete From" contra tabela remota - o unico alvo de escrita e o
    * cursor LOCAL "Graph" (Create Cursor Graph (gGraficos Gen (4)) seguido
    * de Append Blank + Append General), que aqui vira
    * this_cCursorGrafico e MANTEM o alias "Graph" do legado, porque o
    * SigOpGrc.frx o cita literalmente. Esse cursor e o Append General
    * sao criados pelo FORM (OLE nao entra no BO - PILAR 3), nao por este
    * BO. Este BO so LE crFinal (preenchido pelo form PAI) e agrega.
    *
    * Por isso o trabalho real desta fase fica concentrado em
    * CarregarDoCursor() (agregacao de crFinal nos cursores de trabalho e
    * na matriz this_cDadosGrafico), e Inserir()/Atualizar() NAO sao
    * sobrescritos aqui: o comportamento herdado de BusinessBase (recusar a
    * operacao com mensagem de erro) ja eh o correto para uma tela que
    * nunca grava registro em tabela do SQL Server. ObterChavePrimaria()
    * tambem fica herdado (devolve "") porque nao ha chave primaria - a
    * tela nao representa uma linha de tabela, entao RegistrarAuditoria()
    * nunca chega a ser chamado.
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Agrega o cursor do form pai (crFinal) e monta a
    * matriz TAB/CRLF que o Append General do grafico espera (lcStrg do
    * legado), alem dos cursores de trabalho de meses/grupos e da matriz de
    * percentuais.
    *
    * Nao ha "registro" para carregar (este BO nao representa uma linha de
    * tabela): par_cCursorOrigem substitui o nome padrao
    * this_cCursorOrigem quando o form pai usar outro alias.
    * THIS.this_nComparativo e THIS.this_nOpcaoCotacao devem ser atribuidos
    * pelo Form ANTES de chamar este metodo - sao o equivalente a
    * Thisform.Parentform.Comparativo.Value e
    * Thisform.ParentForm.OptCotacao.Value do legado.
    *
    * Nao ha cursor Cabecalho nesta tela (diferenca 1 do cabecalho do
    * arquivo): os tres subtitulos vem de colunas do PROPRIO crFinal
    * (dtini/dtfinal/lcGrupo1/lcGrupo2/lcMoe) mais this_nOpcaoCotacao.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorOrigem)
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cOrigem
        LOCAL loc_nMes, loc_cMesNome, loc_cLinhaMeses, loc_cStrg
        LOCAL loc_cGrupoAtual, loc_nMesPos, loc_nGrupoPos
        loc_lResultado = .F.

        TRY
            loc_cOrigem = IIF(EMPTY(par_cCursorOrigem), THIS.this_cCursorOrigem, par_cCursorOrigem)

            THIS.this_lDadosValidos  = .F.
            THIS.this_lGraficoGerado = .F.

            IF !USED(loc_cOrigem)
                THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + "o encontrado."
                loc_lResultado = .F.
            ELSE
                THIS.this_cCursorOrigem = loc_cOrigem

                *-- Subtitulos (lcStitulo/lcStitulo2/lcStitulo3 do legado),
                *-- tirados do PROPRIO crFinal e da opcao de cotacao do pai
                SELECT (loc_cOrigem)
                GO TOP
                THIS.this_cSubTitulo1 = DTOC(EVALUATE(loc_cOrigem + ".dtini")) + ;
                    THIS.this_cSeparadorPeriodo + DTOC(EVALUATE(loc_cOrigem + ".dtfinal"))
                THIS.this_cSubTitulo2 = ALLTRIM(EVALUATE(loc_cOrigem + ".lcGrupo1")) + ;
                    THIS.this_cSeparadorGrupos + ALLTRIM(EVALUATE(loc_cOrigem + ".lcGrupo2"))
                *-- lcMoe NAO eh alltrim no legado ('...+crFinal.lcMoe') -
                *-- transcrito literal (regra #17: formula/literal do legado
                *-- nao se "arruma").
                THIS.this_cSubTitulo3 = THIS.this_cPrefixoMoeda + ;
                    IIF(THIS.this_nOpcaoCotacao = 1, THIS.this_cRotuloCotacaoFechamento, THIS.this_cRotuloCotacaoMovimentacao) + ;
                    EVALUATE(loc_cOrigem + ".lcMoe")

                *-- lnTmX do legado: nunca foi atribuido antes deste ponto,
                *-- entao Iif(Type('lnTmX')=='N',lnTmX,0) sempre resolve 0
                THIS.this_nTamanhoRotuloX = 0

                *-- Meses distintos (Select Distinct Mes From crFinal Order
                *-- By Mes Into Array laMeses do legado - aqui, cursor em vez
                *-- de array)
                IF USED(THIS.this_cCursorMeses)
                    USE IN (THIS.this_cCursorMeses)
                ENDIF
                SELECT DISTINCT Mes FROM (loc_cOrigem) ORDER BY Mes INTO CURSOR (THIS.this_cCursorMeses)

                *-- Grupos distintos (Select Distinct Str(Ordem,1)+Str(Ano,4)
                *-- As cGrupos From crFinal Order By 1 Into Array laGrupos do
                *-- legado)
                IF USED(THIS.this_cCursorGrupos)
                    USE IN (THIS.this_cCursorGrupos)
                ENDIF
                *-- O "Order By 1" do legado eh OBRIGATORIO: eh a posicao da
                *-- linha neste cursor que vira o indice do GRUPO na matriz de
                *-- percentuais (Ascan(laGrupos,...) do legado), lido depois
                *-- pelo rotulo de cada ponto da serie. Sem ORDER BY a ordem
                *-- do DISTINCT nao eh garantida e o percentual pode sair na
                *-- serie errada - sem erro e sem log. Medido no VFP9 em
                *-- 2026-11-06: "ORDER BY 1" (numero de coluna) eh aceito em
                *-- SELECT ... INTO CURSOR sobre coluna de EXPRESSAO, ao
                *-- contrario de repetir a expressao no ORDER BY.
                SELECT DISTINCT (STR(Ordem, 1) + STR(Ano, 4)) AS cGrupos ;
                    FROM (loc_cOrigem) ;
                    ORDER BY 1 ;
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
                *-- ordenado por this_cOrdemGrupos (tag imp do legado)
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
                        *-- meio, entao a legenda do grafico sairia com os
                        *-- brancos do char(20) no meio. Compila limpo e so
                        *-- aparece na legenda do chart.
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
    * LimparCursores - Fecha os tres cursores de trabalho criados por
    * CarregarDoCursor (Meses/Grupos/Percentuais) e zera as contagens e a
    * matriz de series.
    *
    * Sem isto os tres VAZARIAM na data session do form PAI: FormSIGOPGRC
    * entra na sessao de dados dele (Init), entao os cursores sobreviveriam
    * ao fechamento da tela se ninguem os fechasse explicitamente. Chamado
    * pelo Destroy do form - mesmo papel do LimparCursores do gemeo
    * SigOpGcoBO.
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
                "Procedure: " + loc_oErro.Procedure, "Erro em SIGOPGRCBO.LimparCursores")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
