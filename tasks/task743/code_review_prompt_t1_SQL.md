# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NGRUPOPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMESPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
Select Distinct Mes ;
  From crFinal ;
Select Distinct (Str(Ordem, 1) + Str(Ano, 4)) as cGrupos ;
  From crFinal ;
	.ControlSource = 'gGraficos'
	Select Graph
Select Distinct Mes ;
  From crFinal ;
Select Distinct (Str(Ordem, 1) + Str(Ano, 4)) as cGrupos ;
  From crFinal ;
Select crFinal
Select crFinal
	Select crFinal
Select CrFinal
	Select Graph
Select CrFinal
Select Graph
Select Graph
Select Graph

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPGRC.prg) - TRECHOS RELEVANTES PARA PASS SQL (1886 linhas total):

*-- Linhas 71 a 114:
71: *             checkbox|optiongroup|optionbutton|
72: *             spinner (campo de entrada) ........... 0 ocorrencias
73: *   .AddCursor / pColuna / RecordSource ............ 0 ocorrencias
74: *   .ControlSource ................................. 1, e eh o campo General
75: *                                                    do grafico
76: *                                                    (.ControlSource =
77: *                                                    'gGraficos' dentro do
78: *                                                    mostragrafico), nao
79: *                                                    coluna de lista
80: *
81: * Ou seja: nao ha o que LISTAR (sem grade) nem o que DIGITAR (sem campo). A
82: * arvore inteira do SCX sao 8 objetos: a faixa do cabecalho com 2 labels, um
83: * Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton.
84: *
85: * Inventar um PageFrame Lista/Dados com 6 botoes CRUD violaria o PILAR 1 e a
86: * regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina/
87: * Btn*Click que nao listam nada seria o "stub disfarcado" que a regra de
88: * completude proibe. Mesmo tratamento do gemeo FormSigOpGco (task739), que
89: * tambem nao tem lista nem campo.
90: *
91: * O que esta fase entrega, entao, eh a unica superficie de BOTAO que o legado
92: * REALMENTE tem, com comportamento completo:
93: *   ConfigurarBotoes()    cmd_4c_Sair (Encerrar) + cmd_4c_Imprimir, na ordem
94: *                         dos registros do SCX
95: *   ConfigurarEventos()   BINDEVENT dos dois Click (os 2 UNICOS eventos de
96: *                         controle do dump - nao ha mais evento a ligar)
97: *   CmdSairClick()        "Thisform.Release" do legado
98: *   CmdImprimirClick()    "Select Graph / Go Top / Report Form SigOpGrc To
99: *                         Printer Prompt NoConsole / Select Graph / Go Top /
100: *                         Thisform.Refresh" do legado
101: *   ExecutarReportForm()  helper canonico de REPORT FORM (guard de FILE no
102: *                         FRX + cursor vazio + isolamento de locale +
103: *                         reconstrucao do menu)
104: *
105: * FASE 5 - AREA DO GRAFICO E ORDEM DE TABULACAO (ENTREGUE)
106: * --------------------------------------------------------------------------
107: * A Fase 5 do pipeline pede "metade dos campos da Page2". Esta tela NAO TEM
108: * campo nenhum e NAO TEM Page nenhuma, e isso foi MEDIDO no dump, nao
109: * presumido: ZERO objeto de BaseClass textbox / editbox / combobox / listbox
110: * / checkbox / optiongroup / optionbutton / spinner, e ZERO pageframe. A
111: * arvore inteira do SCX sao 8 objetos (faixa do cabecalho com 2 labels, um
112: * Shape decorativo, o OleBoundControl do grafico e os 2 CommandButton) - a
113: * metade de zero campos eh zero. Inventar uma Page2 de Dados com TextBox
114: * violaria o PILAR 1 e a regra "NUNCA inventar"; escrever um

*-- Linhas 158 a 176:
158: *   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
159: *                               Class 'MsGraph.Chart' Data lcStrg"
160: *   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
161: *                               ControlSource + LockScreen + os 3 blocos
162: *   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
163: *   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
164: *   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
165: *   AplicarAreaPizza()          bloco "If m.lnConta1==2"
166: *   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
167: *   ObterOpcaoCotacaoDoPai()    "Thisform.ParentForm.OptCotacao.Value"
168: *                               (diferenca 2 do cabecalho - entrada que o
169: *                               gemeo FormSigOpGco nao tem)
170: *   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
171: *
172: * Os DOIS Click do SCX (Imprimir / Sair) ja tinham sido entregues na Fase 4,
173: * porque entregar botao com handler vazio seria o stub que a regra de
174: * completude proibe.
175: *
176: * NAO existem os quatro handlers de verbo CRUD de form de CADASTRO - um por

*-- Linhas 226 a 255:
226: *    a forma do legado, ".Points(<mes>).DataLabel".
227: *
228: * 3) ORDEM DOS GRUPOS (BO, CarregarDoCursor) - o "Order By 1" do
229: *    "Select Distinct ... as cGrupos" legado tinha sido descartado. Eh a
230: *    posicao da linha nesse cursor que vira o indice do GRUPO na matriz de
231: *    percentuais (o Ascan(laGrupos,...) do legado), lido depois pelo rotulo
232: *    de cada ponto: sem ordenacao garantida, o percentual podia sair na
233: *    serie errada, sem erro e sem log. Reposto.
234: *
235: * O QUE A FASE 8 PROVOU E O QUE NAO DEU PARA PROVAR
236: * --------------------------------------------------------------------------
237: * Medido no VFP9 desta estacao em 2026-11-06 (smoke test de escrita em
238: * arquivo passou antes, entao houve execucao de verdade, nao so geracao de
239: * .FXP): "CREATE CURSOR ... (gGraficos G(4))" eh aceito e o campo nasce com
240: * tipo G; "ORDER BY 1" sobre coluna de EXPRESSAO em SELECT ... INTO CURSOR eh
241: * aceito; o form compila sem .ERR (com controle negativo na mesma rodada).
242: *
243: * NAO deu para exercitar o desenho do grafico: "MsGraph.Chart" NAO esta
244: * registrado nesta estacao (CREATEOBJECT devolve "Class definition
245: * MSGRAPH.CHART is not found"). O caminho OLE - APPEND GENERAL, AutoFormat,
246: * eixos e rotulos - fica validado so por transcricao contra o dump, e o
247: * comportamento desta maquina eh exatamente o que AnexarGraficoAoCursor
248: * trata: apaga a linha em branco, deixa this_lGraficoGerado em .F. e manda
249: * GerarGrafico avisar o usuario, em vez de exibir grafico vazio como se
250: * fosse resultado valido.
251: *
252: * TRES ITENS DE CONFERENCIA QUE O GEMEO SO ACHOU NA FASE 8 DELE, e que esta
253: * entrega ja trazia da fase anterior, por serem o MESMO defeito em telas
254: * quase identicas:
255: *

*-- Linhas 267 a 285:
267: *    tela, porque este form entra na sessao do pai (ver Init). Ver Destroy.
268: * 3) O Imprimir ja tem o guard que MostrarGrafico tem (this_lGraficoGerado,
269: *    nao RECCOUNT): RECCOUNT() CONTA registro marcado como excluido com SET
270: *    DELETED OFF (o default), que eh exatamente o que sobra quando o
271: *    APPEND GENERAL falha e AnexarGraficoAoCursor apaga a linha em branco.
272: *    Ver CmdImprimirClick (ja entregue na Fase 4).
273: *
274: * ESTADO FINAL
275: * --------------------------------------------------------------------------
276: *   Migracao COMPLETA. O dump do SIGOPGRC esta TODO portado: os 8 objetos da
277: *   SECAO 1 (Fases 3-5) e os 5 metodos da SECAO 3 - mostragrafico e Init
278: *   (Fase 7), os 2 Click (Fase 4) e o Load, que nao gera metodo (fConfigGeral
279: *   eh funcao GLOBAL do Framework Fortyus; a configuracao global do sistema
280: *   novo ja acontece antes, em config.prg/main.prg). A Fase 8 fechou com a
281: *   revisao contra o dump e contra o FRX descrita acima.
282: *==============================================================================
283: 
284: DEFINE CLASS FormSIGOPGRC AS FormBase
285: 

*-- Linhas 625 a 646:
625:     * do preenchimento eh FillColor (CLAUDE.md regra #33 - conferido na
626:     * tabela real de propriedades, automation\propriedades_baseclasses.txt).
627:     *
628:     * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
629:     * General na criacao do controle: ele liga dentro do mostragrafico
630:     * (atribui 'gGraficos' ao ControlSource), depois que o binario do grafico
631:     * ja foi gravado no cursor. Apontar o ControlSource para um alias que
632:     * ainda nao existe estouraria "Alias ... is not found" DENTRO do TRY do
633:     * InicializarForm, que devolveria .F., o CREATEOBJECT devolveria .F. e a
634:     * tela NAO ABRIRIA, sem erro visivel (CLAUDE.md regra #41). O "" explicito
635:     * garante que o controle nasce desligado; quem liga eh o metodo de
636:     * DESENHO do grafico (Fases 7-8), no mesmo ponto em que o legado liga.
637:     * Mesmo tratamento do gemeo FormSigOpGco.obj_4c_OleGrafico e de
638:     * FormSigPrGf2, a outra tela de grafico do projeto.
639:     *
640:     * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
641:     * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
642:     * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um
643:     * valor que o objeto nunca guarda. A ordem efetiva esta reproduzida em
644:     * AjustarOrdemTabulacao.
645:     *
646:     * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o

*-- Linhas 674 a 692:
674:                 .Enabled       = .T.
675:                 .AutoActivate  = 0
676:                 *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
677:                 .ControlSource = ""
678:                 .Visible       = .T.
679:             ENDWITH
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message + CHR(13) + ;
682:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
683:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.ConfigurarPaginaDados")
684:         ENDTRY
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * AjustarOrdemTabulacao - Fixa a ordem de tabulacao do SCX legado.
689:     *
690:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
691:     * tem relacao nenhuma com a do legado. Divergencia aqui nao da erro, nao
692:     * entra em log e nao aparece em screenshot: so o Tab andando na ordem

*-- Linhas 990 a 1030:
990:     *==========================================================================
991:     * CmdImprimirClick - Click do botao "Imprimir". Transcricao do legado:
992:     *
993:     *     Select Graph
994:     *     Go Top
995:     *     Report Form SigOpGrc To Printer Prompt NoConsole
996:     *     Select Graph
997:     *     Go Top
998:     *     Thisform.Refresh
999:     *
1000:     * "Graph" eh o cursor do campo General que guarda o binario do
1001:     * MsGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
1002:     * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico e o FRX eh
1003:     * this_cRelatorio ("SigOpGrc") - os dois nomes moram no BO e NAO sao
1004:     * reescritos aqui. O alias continua sendo o "Graph" do legado porque o
1005:     * SigOpGrc.frx cita Graph.gGraficos literalmente (ver a property no BO).
1006:     *
1007:     * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
1008:     * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
1009:     * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
1010:     * repintaria o grafico com registro nenhum.
1011:     *
1012:     * O guard eh pelo FLAG this_lGraficoGerado do BO, e nao so por USED()/
1013:     * RECCOUNT: quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
1014:     * estacao), a linha em branco do cursor eh APAGADA - mas DELETE so MARCA, e
1015:     * RECCOUNT() CONTA registro marcado como excluido, porque SET DELETED esta
1016:     * OFF por default. Sem o flag o alias existe, o guard de RECCOUNT = 0 do
1017:     * ExecutarReportForm nao segura, e o usuario manda para a impressora um
1018:     * relatorio EM BRANCO em vez de receber o aviso. Ate a Fase 7 criar o
1019:     * grafico esse flag fica em .F. e o clique avisa que ainda nao ha o que
1020:     * imprimir - que eh a resposta correta, nao um remendo.
1021:     *
1022:     * O REPORT FORM nao vai cru: passa pelo helper ExecutarReportForm, que tem
1023:     * o guard de FILE() no FRX, o isolamento de locale (sem ele os campos
1024:     * numericos dos FRX Fortyus saem como ******) e a reconstrucao do menu
1025:     * principal que o _MREPORT corrompe.
1026:     *==========================================================================
1027:     PROCEDURE CmdImprimirClick()
1028:         LOCAL loc_cCursor, loc_cRelatorio, loc_lProsseguir, loc_oErro
1029: 
1030:         loc_cCursor     = ""

*-- Linhas 1061 a 1087:
1061:             ENDIF
1062: 
1063:             IF loc_lProsseguir
1064:                 SELECT (loc_cCursor)
1065:                 GO TOP
1066: 
1067:                 THIS.ExecutarReportForm(gc_4c_CaminhoReports + loc_cRelatorio + ".frx", ;
1068:                     "PRINTER_PROMPT", loc_cCursor)
1069: 
1070:                 *-- Volta ao topo: o REPORT FORM deixa o cursor em EOF e o
1071:                 *-- OleBoundControl le o General do registro CORRENTE.
1072:                 SELECT (loc_cCursor)
1073:                 GO TOP
1074:                 THIS.Refresh()
1075:             ENDIF
1076:         CATCH TO loc_oErro
1077:             MsgErro(loc_oErro.Message + CHR(13) + ;
1078:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1079:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.CmdImprimirClick")
1080:         ENDTRY
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * ExecutarReportForm - Helper canonico de REPORT FORM (CorretorAutomatico
1085:     * #117/#147). Nenhum REPORT FORM do projeto roda cru:
1086:     *   - guard de FILE() no FRX, com o caminho na mensagem;
1087:     *   - guard de cursor vazio, para o relatorio nao sair em branco;

*-- Linhas 1271 a 1320:
1271:     * GerarGrafico - Transcricao do corpo do Init legado (a parte de DADOS; a
1272:     * de layout ja esta nas Fases 3-5). Sequencia do legado, na ordem:
1273:     *
1274:     *   Select Distinct ... Into Array laMeses / laGrupos    -> BO
1275:     *   Declare m.laPerc(...) / m.laPerc = 0                 -> BO
1276:     *   Create Cursor Graph (gGraficos Gen (4))              -> aqui
1277:     *   Select crFinal / Set order to Grupom / Scan ...      -> BO
1278:     *   Select crFinal / Set Order To Imp / Do While ...     -> BO
1279:     *   If Not Empty(lcStrg)
1280:     *       Select Graph / Append Blank
1281:     *       Append General gGraficos Class 'MsGraph.Chart' Data lcStrg
1282:     *       Thisform.MostraGrafico()
1283:     *   Endif
1284:     *   Select CrFinal / Go Top / Select Graph / Go Top
1285:     *   Thisform.parentform.Aguarde.visible = .f.
1286:     *
1287:     * A montagem da matriz TAB/CRLF (lcStrg) inteira mora no BO, em
1288:     * CarregarDoCursor (Fase 2) - aqui fica so o que eh OLE e cursor de campo
1289:     * General, que eh do Form por decisao de arquitetura (PILAR 3: o BO nao
1290:     * manipula objeto OLE). Mesma divisao do gemeo FormSigOpGco.
1291:     *
1292:     * O modo de agrupamento E a opcao de cotacao sao lidos do PAI e
1293:     * atribuidos ao BO ANTES do CarregarDoCursor: o primeiro decide se a
1294:     * chave de grupo leva o Ano e se a matriz de percentuais eh preenchida; o
1295:     * segundo decide o rotulo do subtitulo 3 (diferenca 2 do cabecalho do
1296:     * SIGOPGRCBO - entrada que o gemeo nao tem).
1297:     *
1298:     * PUBLIC: o legado expoe mostragrafico como metodo customizado do form
1299:     * (RESERVED3/ClassInfo do dump), e o pai pode mandar redesenhar depois de
1300:     * reprocessar o periodo. Metodo chamado de fora NUNCA pode ser PROTECTED
1301:     * em nivel nenhum da heranca (regra #51).
1302:     *
1303:     * O CREATE CURSOR acontece SEMPRE, inclusive sem dado - como no legado,
1304:     * em que o "Create Cursor Graph" vem ANTES do "If Not Empty(lcStrg)" e o
1305:     * "Select Graph / Go Top" do fim conta com o alias existindo.
1306:     *==========================================================================
1307:     PROCEDURE GerarGrafico()
1308:         LOCAL loc_oBO, loc_cAliasGrafico, loc_cOrigem, loc_cDados, ;
1309:               loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
1310: 
1311:         loc_lResultado = .F.
1312:         loc_lFalhaOle  = .F.
1313: 
1314:         THIS.this_cFalhaGrafico  = ""
1315:         THIS.this_lGraficoPronto = .F.
1316: 
1317:         TRY
1318:             loc_oBO = THIS.this_oBusinessObject
1319: 
1320:             IF VARTYPE(loc_oBO) = "O"

*-- Linhas 1328 a 1361:
1328:                 loc_oBO.this_nComparativo  = THIS.ObterComparativoDoPai()
1329:                 loc_oBO.this_nOpcaoCotacao = THIS.ObterOpcaoCotacaoDoPai()
1330: 
1331:                 *-- Cursor do campo General, equivalente ao "Create Cursor
1332:                 *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
1333:                 *-- geracao: o grafico eh UM registro so (o legado tambem faz
1334:                 *-- um Append Blank por abertura da tela).
1335:                 IF USED(loc_cAliasGrafico)
1336:                     *-- Guardar pelo BUFFERING, nunca so por USED(): sem
1337:                     *-- buffering o TABLEREVERT nao eh no-op, estoura o erro
1338:                     *-- 1586 (CLAUDE.md regra #52). CREATE CURSOR nasce com
1339:                     *-- Buffering = 1, entao aqui o TABLEREVERT eh pulado e o
1340:                     *-- USE IN fecha o alias de qualquer forma.
1341:                     IF CURSORGETPROP("Buffering", loc_cAliasGrafico) > 1
1342:                         TABLEREVERT(.T., loc_cAliasGrafico)
1343:                     ENDIF
1344:                     USE IN (loc_cAliasGrafico)
1345:                 ENDIF
1346:                 CREATE CURSOR (loc_cAliasGrafico) (gGraficos G(4))
1347: 
1348:                 *-- Agregacao do cursor do pai (Fase 2 do BO)
1349:                 IF loc_oBO.CarregarDoCursor(loc_cOrigem)
1350:                     loc_cDados = loc_oBO.this_cDadosGrafico
1351: 
1352:                     *-- "If Not Empty(lcStrg)" do legado: sem serie nenhuma
1353:                     *-- nao se cria registro de grafico.
1354:                     IF loc_oBO.this_lDadosValidos AND !EMPTY(loc_cDados)
1355:                         loc_lFalhaOle = !THIS.AnexarGraficoAoCursor(loc_cAliasGrafico, loc_cDados)
1356: 
1357:                         IF !loc_lFalhaOle
1358:                             loc_lResultado = THIS.MostrarGrafico()
1359:                         ENDIF
1360:                     ELSE
1361:                         *-- Periodo sem movimento: nao eh erro, eh resultado

*-- Linhas 1370 a 1400:
1370:                         loc_oBO.this_cMensagemErro), "Gr" + CHR(225) + "fico Comparativo")
1371:                 ENDIF
1372: 
1373:                 *-- "Select CrFinal / Go Top / Select Graph / Go Top" do fim
1374:                 *-- do Init legado: devolve os dois cursores ao topo. O do
1375:                 *-- grafico por ULTIMO e de proposito - o OleBoundControl le o
1376:                 *-- campo General do registro CORRENTE.
1377:                 IF USED(loc_cOrigem)
1378:                     SELECT (loc_cOrigem)
1379:                     GO TOP
1380:                 ENDIF
1381:                 *-- Mesmo motivo do guard de MostrarGrafico: so reposiciona
1382:                 *-- quando ha grafico de verdade, nunca sobre a linha que o
1383:                 *-- CATCH do APPEND GENERAL deixou marcada como excluida.
1384:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1385:                     SELECT (loc_cAliasGrafico)
1386:                     GO TOP
1387:                 ENDIF
1388:             ENDIF
1389:         CATCH TO loc_oErro
1390:             MsgErro(loc_oErro.Message + CHR(13) + ;
1391:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1392:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.GerarGrafico")
1393:         ENDTRY
1394: 
1395:         *-- Falha de OLE tem de ficar VISIVEL (regra #27): ausencia silenciosa
1396:         *-- faria o usuario olhar uma tela em branco sem saber por que.
1397:         IF loc_lFalhaOle
1398:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o gr" + CHR(225) + ;
1399:                 "fico (componente MsGraph.Chart indispon" + CHR(237) + "vel nesta esta" + ;
1400:                 CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, ;

*-- Linhas 1413 a 1470:
1413:     ENDPROC
1414: 
1415:     *==========================================================================
1416:     * AnexarGraficoAoCursor - "Select Graph / Append Blank / Append General
1417:     * gGraficos Class 'MsGraph.Chart' Data lcStrg" do Init legado.
1418:     *
1419:     * Isolado num metodo (e num TRY) proprio porque o OLE server
1420:     * "MsGraph.Chart" pode nao estar registrado na estacao. Nesse caso o
1421:     * APPEND BLANK JA inseriu a linha quando o APPEND GENERAL estoura, e sem
1422:     * desfazer o OleBoundControl exibe esse registro VAZIO como se fosse
1423:     * resultado valido - a tela mentiria que desenhou. Por isso o CATCH apaga
1424:     * a linha e devolve .F., e quem chama avisa o usuario.
1425:     *
1426:     * O nome do campo vai LITERAL ("gGraficos"): APPEND GENERAL nao aceita
1427:     * expressao de campo, ao contrario do alias do cursor. O IF confere que o
1428:     * BO continua chamando o campo assim - divergirem faria o APPEND GENERAL
1429:     * escrever num campo que o ControlSource de MostrarGrafico nao le.
1430:     *==========================================================================
1431:     PROTECTED PROCEDURE AnexarGraficoAoCursor(par_cAliasGrafico, par_cDados)
1432:         LOCAL loc_oBO, loc_lResultado, loc_oErro
1433:         loc_lResultado = .F.
1434: 
1435:         loc_oBO = THIS.this_oBusinessObject
1436: 
1437:         IF UPPER(ALLTRIM(loc_oBO.this_cCampoGeral)) != "GGRAFICOS"
1438:             THIS.this_cFalhaGrafico = "Campo General do BO (" + ;
1439:                 ALLTRIM(loc_oBO.this_cCampoGeral) + ") divergente de gGraficos."
1440:         ELSE
1441:             TRY
1442:                 SELECT (par_cAliasGrafico)
1443:                 APPEND BLANK
1444:                 APPEND GENERAL gGraficos CLASS "MsGraph.Chart" DATA (par_cDados)
1445: 
1446:                 loc_oBO.this_lGraficoGerado = .T.
1447:                 loc_lResultado = .T.
1448:             CATCH TO loc_oErro
1449:                 THIS.this_cFalhaGrafico     = loc_oErro.Message
1450:                 loc_oBO.this_lGraficoGerado = .F.
1451: 
1452:                 *-- Apaga a linha em branco deixada pelo APPEND BLANK.
1453:                 SELECT (par_cAliasGrafico)
1454:                 IF !EOF() AND !BOF()
1455:                     DELETE
1456:                 ENDIF
1457:             ENDTRY
1458:         ENDIF
1459: 
1460:         RETURN loc_lResultado
1461:     ENDPROC
1462: 
1463:     *==========================================================================
1464:     * MostrarGrafico - Transcricao do "PROCEDURE mostragrafico" do SCX.
1465:     * Liga o campo General ao OleBoundControl e aplica a formatacao do
1466:     * MSGraph (galeria, fontes, legenda, titulo, areas, eixos, rotulos).
1467:     *
1468:     * LockScreen = .T./.F. em volta, como no legado (o metodo dele abre e
1469:     * fecha com "Thisform.LockScreen"): a formatacao toca dezenas de
1470:     * propriedades do chart e sem isso a tela pisca a cada uma.

*-- Linhas 1500 a 1556:
1500:                 loc_oOle          = THIS.obj_4c_OleGrafico
1501: 
1502:                 *-- Guard pelo FLAG do BO, nao por RECCOUNT: RECCOUNT()
1503:                 *-- CONTA registro marcado como excluido (SET DELETED esta
1504:                 *-- OFF por default), e eh exatamente isso que sobra no
1505:                 *-- cursor quando o APPEND GENERAL falha e
1506:                 *-- AnexarGraficoAoCursor apaga a linha em branco. Com
1507:                 *-- RECCOUNT > 0 este metodo passaria a desenhar sobre um
1508:                 *-- registro excluido se o form PAI o chamasse direto (ele
1509:                 *-- eh PUBLIC) - a tela exibiria grafico vazio como se
1510:                 *-- fosse resultado valido.
1511:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1512:                     SELECT (loc_cAliasGrafico)
1513:                     GO TOP
1514: 
1515:                     THIS.LockScreen = .T.
1516: 
1517:                     *-- ".ControlSource = 'gGraficos'" do legado, aqui
1518:                     *-- QUALIFICADO com o alias: o legado conta com a work
1519:                     *-- area corrente ser a do cursor do grafico, o que deixa
1520:                     *-- o bind dependente de quem chamou (regra #41).
1521:                     loc_oOle.ControlSource = loc_cAliasGrafico + "." + ;
1522:                         ALLTRIM(loc_oBO.this_cCampoGeral)
1523: 
1524:                     loc_lResultado = THIS.AplicarFormatoGrafico(loc_oOle)
1525: 
1526:                     *-- "If m.lnConta1==1" do legado - o ramo COLUNA. O indice
1527:                     *-- vem do BO (this_nIndiceTipoGrafico), que o calcula
1528:                     *-- pelo mesmo At()/6 do legado sobre o tipo corrente.
1529:                     IF loc_oBO.this_nIndiceTipoGrafico = 1
1530:                         THIS.AplicarEixosColuna(loc_oOle)
1531:                     ENDIF
1532: 
1533:                     *-- "If m.lnConta1==2" do legado - o ramo PIZZA.
1534:                     IF loc_oBO.this_nIndiceTipoGrafico = 2
1535:                         THIS.AplicarAreaPizza(loc_oOle)
1536:                     ENDIF
1537: 
1538:                     *-- "Select Graph" que fecha o WITH do legado: o
1539:                     *-- OleBoundControl le o General do registro CORRENTE,
1540:                     *-- entao a work area volta a ser a do grafico.
1541:                     SELECT (loc_cAliasGrafico)
1542:                     GO TOP
1543: 
1544:                     loc_oOle.Refresh
1545:                 ELSE
1546:                     THIS.this_cFalhaGrafico = "Cursor do gr" + CHR(225) + ;
1547:                         "fico vazio ou inexistente."
1548:                 ENDIF
1549:             ENDIF
1550:         CATCH TO loc_oErro
1551:             MsgErro(loc_oErro.Message + CHR(13) + ;
1552:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1553:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSIGOPGRC.MostrarGrafico")
1554:             loc_lResultado = .F.
1555:         ENDTRY
1556: 


### BO (C:\4c\projeto\app\classes\SIGOPGRCBO.prg):
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

