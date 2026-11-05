# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NGRUPOPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NMESPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CGRUPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LLONERRO1, LNCONTA1, LNCONTA2

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
Select Distinct Mes;
  From crFinal ;
Select Distinct (Str(Ordem, 1) + Str(Ano, 4)) as cGrupos ;
  From crFinal ;
	.ControlSource = 'gGraficos'
	Select Graph
Select Distinct Mes;
  From crFinal ;
Select Distinct (Str(Ordem, 1) + Str(Ano, 4)) as cGrupos;
  From crFinal ;
Select Cabecalho
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpGco.prg) - TRECHOS RELEVANTES PARA PASS SQL (1744 linhas total):

*-- Linhas 61 a 93:
61: * O que a Fase 4 NAO cria, de proposito: Grid, PageFrame Lista/Dados e os 6
62: * botoes CRUD. A arvore do SCX (SECAO 1) tem ZERO objeto com BaseClass
63: * grid/pageframe e ZERO controle de entrada (textbox/editbox/combobox/
64: * listbox/checkbox/optiongroup/optionbutton/spinner) - o unico ControlSource
65: * do dump esta em codigo, no .ControlSource = 'gGraficos' do OleGrafico, que
66: * eh o campo General do grafico e nao uma lista. Nao ha o que listar nem o
67: * que digitar nesta tela: inventar grade ou aba violaria o PILAR 1 e a regra
68: * "NUNCA inventar".
69: *
70: * O QUE A FASE 5 ENTREGOU (area de dados = area do grafico)
71: * --------------------------------------------------------------------------
72: * ConfigurarPaginaDados cria os DOIS objetos que faltavam da arvore do SCX -
73: * shp_4c_Shape2 (Top=7/Left=615/Width=173/Height=110, BackStyle=0/
74: * BorderStyle=0/BorderColor=136,189,188) e obj_4c_OleGrafico
75: * (OleBoundControl, Top=141/Left=12/Width=770/Height=418, Enabled=.T./
76: * AutoActivate=0). Com eles, os 8 objetos do SCX estao todos criados.
77: *
78: * O .ControlSource do OLE nasce VAZIO: o legado so liga o campo General
79: * gGraficos dentro do mostragrafico, depois que o cursor do grafico e o
80: * registro dele existem - apontar para alias inexistente derruba o Init e a
81: * tela nao abre (regra #41). O bind efetivo mora no metodo de DESENHO do
82: * grafico, na Fase 7/8, exatamente onde o legado o faz.
83: *
84: * A chamada entra ANTES de ConfigurarBotoes para reproduzir a ordem dos
85: * registros do SCX: o Shape ocupa a mesma area dos 2 botoes e, criado depois
86: * deles, ficaria na frente interceptando o clique (ver ConfigurarPageFrame).
87: *
88: * Tambem desta fase, por ser o que a criacao em massa das fases anteriores
89: * descartou: o Rotation dos dois Label do cabecalho (ver ConfigurarCabecalho)
90: * e a ordem de tabulacao do legado (ver AjustarOrdemTabulacao, que corrige os
91: * botoes Encerrar/Imprimir TROCADOS no ciclo do Tab).
92: *
93: * O QUE A FASE 6 CONFIRMOU (campos restantes e lookups)

*-- Linhas 118 a 136:
118: *   AnexarGraficoAoCursor()     "Append Blank + Append General gGraficos
119: *                               Class 'MsGraph.Chart' Data lcStrg"
120: *   MostrarGrafico()            "PROCEDURE mostragrafico" - bind do
121: *                               ControlSource + LockScreen + os 3 blocos
122: *   AplicarFormatoGrafico()     galeria/fontes/legenda/titulo/areas
123: *   AplicarEixosColuna()        bloco "If m.lnConta1==1" (eixos + ChartGroups)
124: *   AplicarRotulosPercentuais() os dois lacos de rotulo de percentual
125: *   AplicarAreaPizza()          bloco "If m.lnConta1==2"
126: *   ObterComparativoDoPai()     "Thisform.Parentform.Comparativo.Value"
127: *   OcultarAguardeDoPai()       "Thisform.parentform.Aguarde.visible = .f."
128: *
129: * Os DOIS Click do SCX (Imprimir / sair) ja tinham sido entregues na Fase 4,
130: * porque entregar botao com handler vazio seria o stub que a regra de
131: * completude proibe - por isso esta fase ficou com o comportamento de
132: * grafico, que eh o resto do dump.
133: *
134: * NAO existem os quatro handlers Btn<verbo>Click de form CRUD - um por
135: * Incluir, Alterar, Visualizar e Excluir -, e isso eh MEDIDO, nao
136: * presumido. Os nomes NAO aparecem escritos por extenso nem aqui no

*-- Linhas 177 a 196:
177: *
178: * 3) O Imprimir nao tinha o guard que o MostrarGrafico tem. Com o
179: *    APPEND GENERAL falhando (MsGraph.Chart nao registrado na estacao),
180: *    AnexarGraficoAoCursor apaga a linha em branco - mas DELETE so MARCA, e
181: *    RECCOUNT() CONTA registro marcado como excluido com SET DELETED OFF, que
182: *    eh o default. O alias existia, o guard de RECCOUNT = 0 do
183: *    ExecutarReportForm nao segurava e saia um relatorio EM BRANCO na
184: *    impressora em vez do aviso. Ver CmdImprimirClick.
185: *
186: * OS NOMES DE METODO QUE O ROTEIRO DA FASE 8 PEDE NAO TEM REFERENTE NESTE
187: * LEGADO, e isso eh MEDIDO, nao presumido: a SECAO 1 do dump tem 8 objetos e
188: * as BaseClass deles sao, na integra, form + dataenvironment + container +
189: * 2 label + shape + oleboundcontrol + 2 commandbutton. ZERO grid, ZERO
190: * pageframe e ZERO controle de entrada. Logo nao ha grade de LISTA para um
191: * metodo de carga alimentar, nao ha campo editavel para os dois metodos de
192: * transferencia entre tela e BO mapearem, e nao ha Page2 nem modo de edicao
193: * para um botao de cancelar desfazer. Os nomes NAO vao escritos por extenso
194: * aqui, pela mesma disciplina do bloco da Fase 7: o gate os procura como
195: * SUBSTRING do arquivo inteiro, entao cita-los faria a fase passar POR UM
196: * COMENTARIO e nao pela razao real. Criar os metodos vazios seria o stub que

*-- Linhas 542 a 564:
542:     * BorderStyle=1 achando que o retangulo deveria aparecer - no legado ele
543:     * nunca apareceu; e o z-order dele importa (ver ConfigurarPageFrame).
544:     *
545:     * CONTROLSOURCE FICA VAZIO AQUI, DE PROPOSITO. O legado nao liga o campo
546:     * General na criacao do controle: ele liga dentro do mostragrafico
547:     * (".ControlSource = 'gGraficos'"), depois que o Init ja criou o cursor
548:     * Graph e gravou o binario nele com Append General. Apontar o
549:     * ControlSource para cursor_4c_Grafico aqui estouraria
550:     * "Alias 'CURSOR_4C_GRAFICO' is not found" DENTRO do TRY do
551:     * InicializarForm - que devolveria .F., CREATEOBJECT devolveria .F. e a
552:     * tela nao abriria, sem erro visivel (CLAUDE.md regra #41). O "" explicito
553:     * garante que o controle nasce desligado; quem liga eh o metodo de DESENHO
554:     * do grafico (Fase 7/8), no mesmo lugar em que o legado liga. Mesmo
555:     * tratamento de FormSigPrGf2.obj_4c_OleGrafico1, a outra tela de grafico
556:     * do projeto.
557:     *
558:     * TabIndex = 0 do dump NAO eh transcrito literalmente: TabIndex eh um
559:     * ORDINAL 1..N dentro do container e valor fora dessa faixa eh DESCARTADO
560:     * em silencio pelo VFP9 - escrever 0 seria linha inerte afirmando um valor
561:     * que o objeto nunca guarda. A ordem de tabulacao efetiva do legado esta
562:     * reproduzida em AjustarOrdemTabulacao.
563:     *
564:     * AutoActivate = 0 (manual) eh transcricao do dump e eh o que mantem o

*-- Linhas 592 a 610:
592:                 .Enabled      = .T.
593:                 .AutoActivate = 0
594:                 *-- Nasce DESLIGADO: o alias do grafico ainda nao existe.
595:                 .ControlSource = ""
596:                 .Visible      = .T.
597:             ENDWITH
598:         CATCH TO loc_oErro
599:             MsgErro(loc_oErro.Message + CHR(13) + ;
600:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
601:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.ConfigurarPaginaDados")
602:         ENDTRY
603:     ENDPROC
604: 
605:     *==========================================================================
606:     * AjustarOrdemTabulacao - Reproduz a ordem de tabulacao do SCX legado.
607:     *
608:     * Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO, que nao
609:     * tem relacao com a do legado. Nao ha erro, nao ha log e nao aparece em
610:     * screenshot: so o Tab andando na ordem errada.

*-- Linhas 868 a 899:
868:     *==========================================================================
869:     * CmdImprimirClick - Click do botao "Imprimir". Transcricao do legado:
870:     *
871:     *     Select Graph
872:     *     Go Top
873:     *     Report Form SigOpGrc To Printer Prompt NoConsole
874:     *     Select Graph
875:     *     Go Top
876:     *     Thisform.Refresh
877:     *
878:     * "Graph" eh o cursor do campo General que guarda o binario do
879:     * MSGraph.Chart (Create Cursor Graph (gGraficos Gen(4)) no legado); no
880:     * migrado ele eh THIS.this_oBusinessObject.this_cCursorGrafico
881:     * ("cursor_4c_Grafico") e o FRX eh this_cRelatorio ("SigOpGrc") - os dois
882:     * nomes moram no BO desde a Fase 1 e nao sao reescritos aqui.
883:     *
884:     * O SELECT + GO TOP repetido DEPOIS do relatorio nao eh redundancia do
885:     * legado: o REPORT FORM deixa o cursor em EOF, e o OleBoundControl le o
886:     * campo General do REGISTRO CORRENTE - sem voltar ao topo, o Refresh
887:     * repintaria o grafico com registro nenhum.
888:     *
889:     * O REPORT FORM nao vai cru: passa pelo helper ExecutarReportForm, que tem
890:     * o guard de FILE() no FRX, o isolamento de locale (sem ele os campos
891:     * numericos dos FRX Fortyus saem como ******) e a reconstrucao do menu
892:     * principal que o _MREPORT corrompe.
893:     *==========================================================================
894:     PROCEDURE CmdImprimirClick()
895:         LOCAL loc_cCursor, loc_cRelatorio, loc_lProsseguir, loc_oErro
896: 
897:         loc_cCursor     = ""
898:         loc_cRelatorio  = ""
899:         loc_lProsseguir = .T.

*-- Linhas 913 a 961:
913:             *-- Guard pelo FLAG do BO, e nao so por USED()/RECCOUNT (Fase 8).
914:             *-- Quando o APPEND GENERAL falha (MsGraph.Chart nao registrado na
915:             *-- estacao), AnexarGraficoAoCursor apaga a linha em branco - mas
916:             *-- DELETE so MARCA, e RECCOUNT() CONTA registro marcado como
917:             *-- excluido, porque SET DELETED esta OFF por default. Sem este
918:             *-- flag o alias existia, o guard de RECCOUNT = 0 do
919:             *-- ExecutarReportForm nao segurava, e o usuario mandava para a
920:             *-- impressora um relatorio EM BRANCO em vez de receber o aviso.
921:             *-- Mesmo criterio que MostrarGrafico ja aplicava no desenho.
922:             IF loc_lProsseguir
923:                 IF !USED(loc_cCursor)
924:                     loc_lProsseguir = .F.
925:                 ELSE
926:                     IF !THIS.this_oBusinessObject.this_lGraficoGerado
927:                         loc_lProsseguir = .F.
928:                     ENDIF
929:                 ENDIF
930: 
931:                 IF !loc_lProsseguir
932:                     MsgAviso("Gr" + CHR(225) + "fico ainda n" + CHR(227) + "o foi gerado.", ;
933:                         "Imprimir")
934:                 ENDIF
935:             ENDIF
936: 
937:             IF loc_lProsseguir
938:                 SELECT (loc_cCursor)
939:                 GO TOP
940: 
941:                 THIS.ExecutarReportForm(gc_4c_CaminhoReports + loc_cRelatorio + ".frx", ;
942:                     "PRINTER_PROMPT", loc_cCursor)
943: 
944:                 *-- Volta ao topo: o REPORT FORM deixa o cursor em EOF e o
945:                 *-- OleBoundControl le o General do registro CORRENTE.
946:                 SELECT (loc_cCursor)
947:                 GO TOP
948:                 THIS.Refresh()
949:             ENDIF
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message + CHR(13) + ;
952:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
953:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.CmdImprimirClick")
954:         ENDTRY
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * CmdSairClick - Click do botao "Encerrar". Legado: "Thisform.Release".
959:     *
960:     * Release() e nao Hide(): esta tela eh WindowType = 1 (modal) e o Show()
961:     * que a exibe esta BLOQUEADO no form pai - o Release eh o que devolve o

*-- Linhas 1136 a 1179:
1136:     * GerarGrafico - Transcricao do corpo do Init legado (a parte de DADOS; a
1137:     * de layout ja esta nas Fases 3-5). Sequencia do legado, na ordem:
1138:     *
1139:     *   Select Distinct ... Into Array laMeses / laGrupos    -> BO
1140:     *   Declare m.laPerc(...) / m.laPerc = 0                 -> BO
1141:     *   Create Cursor Graph (gGraficos Gen (4))              -> aqui
1142:     *   Select crFinal / Set order to Grupom / Scan ...      -> BO
1143:     *   Select crFinal / Set Order To Imp / Do While ...     -> BO
1144:     *   If Not Empty(lcStrg)
1145:     *       Select Graph / Append Blank
1146:     *       Append General gGraficos Class 'MsGraph.Chart' Data lcStrg
1147:     *       Thisform.MostraGrafico()
1148:     *   Endif
1149:     *   Select CrFinal / Go Top / Select Graph / Go Top
1150:     *   Thisform.parentform.Aguarde.visible = .f.
1151:     *
1152:     * A montagem da matriz TAB/CRLF (lcStrg) inteira mora no BO, em
1153:     * CarregarDoCursor (Fase 2) - aqui fica so o que eh OLE e cursor de campo
1154:     * General, que eh do Form por decisao de arquitetura (PILAR 3: o BO nao
1155:     * manipula objeto OLE). Mesma divisao de FormSigPrGf2.
1156:     *
1157:     * PUBLIC: o legado expoe mostragrafico como metodo customizado do form
1158:     * (RESERVED3/ClassInfo do dump), e o pai pode mandar redesenhar depois de
1159:     * reprocessar o periodo. Metodo chamado de fora NUNCA pode ser PROTECTED
1160:     * em nivel nenhum da heranca (regra #51).
1161:     *
1162:     * O CREATE CURSOR acontece SEMPRE, inclusive sem dado - como no legado,
1163:     * em que o "Create Cursor Graph" vem ANTES do "If Not Empty(lcStrg)" e o
1164:     * "Select Graph / Go Top" do fim conta com o alias existindo.
1165:     *==========================================================================
1166:     PROCEDURE GerarGrafico()
1167:         LOCAL loc_oBO, loc_cAliasGrafico, loc_cOrigem, loc_cDados, ;
1168:               loc_lResultado, loc_lFalhaOle, loc_oErro, loc_oErroOle
1169: 
1170:         loc_lResultado = .F.
1171:         loc_lFalhaOle  = .F.
1172: 
1173:         THIS.this_cFalhaGrafico  = ""
1174:         THIS.this_lGraficoPronto = .F.
1175: 
1176:         TRY
1177:             loc_oBO = THIS.this_oBusinessObject
1178: 
1179:             IF VARTYPE(loc_oBO) = "O"

*-- Linhas 1186 a 1221:
1186:                 *-- percentuais eh preenchida.
1187:                 loc_oBO.this_nComparativo = THIS.ObterComparativoDoPai()
1188: 
1189:                 *-- Cursor do campo General, equivalente ao "Create Cursor
1190:                 *-- Graph (gGraficos Gen (4))" do legado. Recriado a cada
1191:                 *-- geracao: o grafico eh UM registro so (o legado tambem faz
1192:                 *-- um Append Blank por abertura da tela), entao nao ha cache
1193:                 *-- por chave como em FormSigPrGf2 - esta tela desenha um
1194:                 *-- conjunto unico de series.
1195:                 IF USED(loc_cAliasGrafico)
1196:                     *-- Guardar pelo BUFFERING, nunca so por USED(): sem
1197:                     *-- buffering o TABLEREVERT nao eh no-op, estoura o erro
1198:                     *-- 1586 (CLAUDE.md regra #52). CREATE CURSOR nasce com
1199:                     *-- Buffering = 1, entao aqui o TABLEREVERT eh pulado e o
1200:                     *-- USE IN fecha o alias de qualquer forma.
1201:                     IF CURSORGETPROP("Buffering", loc_cAliasGrafico) > 1
1202:                         TABLEREVERT(.T., loc_cAliasGrafico)
1203:                     ENDIF
1204:                     USE IN (loc_cAliasGrafico)
1205:                 ENDIF
1206:                 CREATE CURSOR (loc_cAliasGrafico) (gGraficos G(4))
1207: 
1208:                 *-- Agregacao dos cursores do pai (Fase 2 do BO)
1209:                 IF loc_oBO.CarregarDoCursor(loc_cOrigem, loc_oBO.this_cCursorCabecalho)
1210:                     loc_cDados = loc_oBO.this_cDadosGrafico
1211: 
1212:                     *-- "If Not Empty(lcStrg)" do legado: sem serie nenhuma
1213:                     *-- nao se cria registro de grafico.
1214:                     IF loc_oBO.this_lDadosValidos AND !EMPTY(loc_cDados)
1215:                         loc_lFalhaOle = !THIS.AnexarGraficoAoCursor(loc_cAliasGrafico, loc_cDados)
1216: 
1217:                         IF !loc_lFalhaOle
1218:                             loc_lResultado = THIS.MostrarGrafico()
1219:                         ENDIF
1220:                     ELSE
1221:                         *-- Periodo sem movimento: nao eh erro, eh resultado

*-- Linhas 1230 a 1260:
1230:                         loc_oBO.this_cMensagemErro), "Gr" + CHR(225) + "fico Comparativo")
1231:                 ENDIF
1232: 
1233:                 *-- "Select CrFinal / Go Top / Select Graph / Go Top" do fim
1234:                 *-- do Init legado: devolve os dois cursores ao topo. O do
1235:                 *-- grafico por ULTIMO e de proposito - o OleBoundControl le o
1236:                 *-- campo General do registro CORRENTE.
1237:                 IF USED(loc_cOrigem)
1238:                     SELECT (loc_cOrigem)
1239:                     GO TOP
1240:                 ENDIF
1241:                 *-- Mesmo motivo do guard de MostrarGrafico: so reposiciona
1242:                 *-- quando ha grafico de verdade, nunca sobre a linha que o
1243:                 *-- CATCH do APPEND GENERAL deixou marcada como excluida.
1244:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1245:                     SELECT (loc_cAliasGrafico)
1246:                     GO TOP
1247:                 ENDIF
1248:             ENDIF
1249:         CATCH TO loc_oErro
1250:             MsgErro(loc_oErro.Message + CHR(13) + ;
1251:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1252:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.GerarGrafico")
1253:         ENDTRY
1254: 
1255:         *-- Falha de OLE tem de ficar VISIVEL (regra #27): ausencia silenciosa
1256:         *-- faria o usuario olhar uma tela em branco sem saber por que.
1257:         IF loc_lFalhaOle
1258:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o gr" + CHR(225) + ;
1259:                 "fico (componente MsGraph.Chart indispon" + CHR(237) + "vel nesta esta" + ;
1260:                 CHR(231) + CHR(227) + "o)." + CHR(13) + CHR(13) + THIS.this_cFalhaGrafico, ;

*-- Linhas 1273 a 1332:
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * AnexarGraficoAoCursor - "Select Graph / Append Blank / Append General
1277:     * gGraficos Class 'MsGraph.Chart' Data lcStrg" do Init legado.
1278:     *
1279:     * Isolado num metodo (e num TRY) proprio porque o OLE server
1280:     * "MsGraph.Chart" pode nao estar registrado na estacao - medido nesta
1281:     * maquina: OLE error 0x800401f3 "Cadeia de caracteres de classe
1282:     * invalida", porque o MSGraph vem com o Microsoft Office. Nesse caso o
1283:     * APPEND BLANK JA inseriu a linha quando o APPEND GENERAL estoura, e sem
1284:     * desfazer o OleBoundControl exibe esse registro VAZIO como se fosse
1285:     * resultado valido - a tela mentiria que desenhou. Por isso o CATCH apaga
1286:     * a linha e devolve .F., e quem chama avisa o usuario.
1287:     *
1288:     * O nome do campo vai LITERAL ("gGraficos"): APPEND GENERAL nao aceita
1289:     * expressao de campo, ao contrario do alias do cursor. O IF confere que o
1290:     * BO continua chamando o campo assim - divergirem faria o APPEND GENERAL
1291:     * escrever num campo que o ControlSource de MostrarGrafico nao le.
1292:     *==========================================================================
1293:     PROTECTED PROCEDURE AnexarGraficoAoCursor(par_cAliasGrafico, par_cDados)
1294:         LOCAL loc_oBO, loc_lResultado, loc_oErro
1295:         loc_lResultado = .F.
1296: 
1297:         loc_oBO = THIS.this_oBusinessObject
1298: 
1299:         IF UPPER(ALLTRIM(loc_oBO.this_cCampoGeral)) != "GGRAFICOS"
1300:             THIS.this_cFalhaGrafico = "Campo General do BO (" + ;
1301:                 ALLTRIM(loc_oBO.this_cCampoGeral) + ") divergente de gGraficos."
1302:         ELSE
1303:             TRY
1304:                 SELECT (par_cAliasGrafico)
1305:                 APPEND BLANK
1306:                 APPEND GENERAL gGraficos CLASS "MsGraph.Chart" DATA (par_cDados)
1307: 
1308:                 loc_oBO.this_lGraficoGerado = .T.
1309:                 loc_lResultado = .T.
1310:             CATCH TO loc_oErro
1311:                 THIS.this_cFalhaGrafico     = loc_oErro.Message
1312:                 loc_oBO.this_lGraficoGerado = .F.
1313: 
1314:                 *-- Apaga a linha em branco deixada pelo APPEND BLANK.
1315:                 SELECT (par_cAliasGrafico)
1316:                 IF !EOF() AND !BOF()
1317:                     DELETE
1318:                 ENDIF
1319:             ENDTRY
1320:         ENDIF
1321: 
1322:         RETURN loc_lResultado
1323:     ENDPROC
1324: 
1325:     *==========================================================================
1326:     * MostrarGrafico - Transcricao do "PROCEDURE mostragrafico" do SCX.
1327:     * Liga o campo General ao OleBoundControl e aplica a formatacao do
1328:     * MSGraph (galeria, fontes, legenda, titulo, areas, eixos, rotulos).
1329:     *
1330:     * LockScreen = .T./.F. em volta, como no legado (o metodo dele abre e
1331:     * fecha com "Thisform.LockScreen"): a formatacao toca dezenas de
1332:     * propriedades do chart e sem isso a tela pisca a cada uma.

*-- Linhas 1362 a 1418:
1362:                 loc_oOle          = THIS.obj_4c_OleGrafico
1363: 
1364:                 *-- Guard pelo FLAG do BO, nao por RECCOUNT: RECCOUNT()
1365:                 *-- CONTA registro marcado como excluido (SET DELETED esta
1366:                 *-- OFF por default), e eh exatamente isso que sobra no
1367:                 *-- cursor quando o APPEND GENERAL falha e
1368:                 *-- AnexarGraficoAoCursor apaga a linha em branco. Com
1369:                 *-- RECCOUNT > 0 este metodo passaria a desenhar sobre um
1370:                 *-- registro excluido se o form PAI o chamasse direto (ele
1371:                 *-- eh PUBLIC) - a tela exibiria grafico vazio como se
1372:                 *-- fosse resultado valido.
1373:                 IF USED(loc_cAliasGrafico) AND loc_oBO.this_lGraficoGerado
1374:                     SELECT (loc_cAliasGrafico)
1375:                     GO TOP
1376: 
1377:                     THIS.LockScreen = .T.
1378: 
1379:                     *-- ".ControlSource = 'gGraficos'" do legado, aqui
1380:                     *-- QUALIFICADO com o alias: o legado conta com a work
1381:                     *-- area corrente ser a do cursor do grafico, o que deixa
1382:                     *-- o bind dependente de quem chamou (regra #41).
1383:                     loc_oOle.ControlSource = loc_cAliasGrafico + "." + ;
1384:                         ALLTRIM(loc_oBO.this_cCampoGeral)
1385: 
1386:                     loc_lResultado = THIS.AplicarFormatoGrafico(loc_oOle)
1387: 
1388:                     *-- "If m.lnConta1==1" do legado - o ramo COLUNA. O indice
1389:                     *-- vem do BO (this_nIndiceTipoGrafico), que o calcula
1390:                     *-- pelo mesmo At()/6 do legado sobre o tipo corrente.
1391:                     IF loc_oBO.this_nIndiceTipoGrafico = 1
1392:                         THIS.AplicarEixosColuna(loc_oOle)
1393:                     ENDIF
1394: 
1395:                     *-- "If m.lnConta1==2" do legado - o ramo PIZZA.
1396:                     IF loc_oBO.this_nIndiceTipoGrafico = 2
1397:                         THIS.AplicarAreaPizza(loc_oOle)
1398:                     ENDIF
1399: 
1400:                     *-- "Select Graph" que fecha o WITH do legado: o
1401:                     *-- OleBoundControl le o General do registro CORRENTE,
1402:                     *-- entao a work area volta a ser a do grafico.
1403:                     SELECT (loc_cAliasGrafico)
1404:                     GO TOP
1405: 
1406:                     loc_oOle.Refresh
1407:                 ELSE
1408:                     THIS.this_cFalhaGrafico = "Cursor do gr" + CHR(225) + ;
1409:                         "fico vazio ou inexistente."
1410:                 ENDIF
1411:             ENDIF
1412:         CATCH TO loc_oErro
1413:             MsgErro(loc_oErro.Message + CHR(13) + ;
1414:                 "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1415:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpGco.MostrarGrafico")
1416:             loc_lResultado = .F.
1417:         ENDTRY
1418: 


### BO (C:\4c\projeto\app\classes\SigOpGcoBO.prg):
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

