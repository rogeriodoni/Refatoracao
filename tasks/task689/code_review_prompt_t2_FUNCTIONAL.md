# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.PodeConsultarBanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Titulo' (parent: SIGOPCGB.grdCot): Top original=7 vs migrado 'lbl_4c_TituloDadosProduto' Top=130 (diff=123px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3026 linhas total):

*-- Linhas 11 a 58:
11: *
12: * Parametro Init: par_nCodBarra (opcional) - codigo de barras pre-selecionado
13: *
14: * Fase 3/8: Estrutura base (DEFINE CLASS, Init/InicializarForm, cabecalho)
15: * Fase 4/8: Grades de resultado (Historico/Movimento/Devolucao) ligadas aos
16: * seus cursores, botoes de acao (Imprimir/Visualizar/Movimento/
17: * Rastreabilidade/Etiquetas/Encerrar) com visibilidade por permissao, e a
18: * carga de dados (CarregarDados), que reproduz a parte do PROCEDURE
19: * Processamento do legado referente as grades.
20: * Form OPERACIONAL sem PageFrame (regra CLAUDE.md) - grades e botoes vao
21: * direto em THIS, nao em Page1/Page2. ATENCAO: o mapeamento.json gerado
22: * automaticamente colide as 3 grades no mesmo nome "grd_4c_Dados" - aqui
23: * cada grade recebe nome distinto (grd_4c_Historico/Movimento/Devolucao).
24: *
25: * Fase 5/8: Campos principais parte 1/2 (ConfigurarCamposPrincipais) - o
26: * campo de pesquisa do codigo de barras (txt_4c_Barras, equivalente ao
27: * getBarras legado, dentro do Shape1) e o bloco "Dados do Produto"
28: * (Shape2): produto/fornecedor/referencia/origem/colecao/categoria/precos
29: * encontrados pela pesquisa. Todos SOMENTE EXIBICAO (TabStop = .F.,
30: * equivalente ao Return(.F.) do When legado), exceto txt_4c_Barras. A
31: * fiacao do evento de pesquisa e o preenchimento destes campos a partir
32: * do BO ficam para fase posterior - esta fase cobre so o layout.
33: *
34: * Fase 7/8: Eventos principais dos botoes de acao, que ate aqui so tinham
35: * .Enabled controlado mas NENHUM Click ligado: Encerrar (obj_4c_CmdBtnForm,
36: * legado cmdBtnForm.btnSair.Click = ThisForm.Release), Imprimir/Visualizar
37: * (legado: Imagem('I')/Imagem('V') - cabecalho da etiqueta + REPORT FORM),
38: * Documento (legado: localiza o documento em SigMvCab/SigCdNec e abre
39: * FormSigMvExp/FormSigMvPdt), Rastreabilidade (legado: Do Form SigReCgr -
40: * ainda nao migrada, mesmo guard do BtnLocalClick) e o painel flutuante de
41: * correcao de etiquetas (legado: Botao_de_Correcao - cnt_4c_Correcao +
42: * grd_4c_Correcao, criados aqui porque so existiam no legado dentro deste
43: * Click). O SIGOPCGB nao tem Incluir/Alterar/Excluir - eh form de PESQUISA,
44: * sem CRUD de entidade propria (ver sigopcgbBO.prg, bloco final).
45: *
46: * Fase 8/8: eventos AUXILIARES e consolidacao. Os 53 eventos do dump legado
47: * passam a estar todos cobertos; faltavam QUATRO, todos do ciclo do campo de
48: * barras, e sem eles o form nao se comporta como o legado:
49: *   getBarras.GotFocus  -> BarrasGotFocus  (guard "peantvalue", this_nBarrasAnterior)
50: *   getBarras.LostFocus -> BarrasLostFocus (Valid + armar o timer de foco)
51: *   tmAux.Timer         -> TimerFocoBarras (devolve o foco e se DESARMA)
52: *   foca                -> FocarBarras
53: * O timer NAO eh enfeite: em VFP9 nao se devolve o foco a um controle de
54: * dentro do LostFocus dele, e o legado resolve exatamente com esse timer de
55: * 200ms - eh o que faz o leitor de codigo de barras funcionar em sequencia.
56: * Junto vieram tres acertos de fidelidade medidos contra o dump:
57: *   (a) o Valid legado so pesquisa quando o codigo MUDOU - sem esse guard a
58: *       pesquisa inteira (3 SELECT + 3 cursores) repetia a cada saida do campo,

*-- Linhas 109 a 176:
109:     this_lEmPesquisa      = .F.
110: 
111:     *==================================================================
112:     * Init - Armazena parametro antes de DODEFAULT (que chama InicializarForm)
113:     *==================================================================
114:     PROCEDURE Init(par_nCodBarra)
115:         LOCAL loc_lResultado
116:         loc_lResultado = .F.
117: 
118:         THIS.this_nCodBarraInicial = IIF(VARTYPE(par_nCodBarra) = "N", par_nCodBarra, 0)
119: 
120:         loc_lResultado = DODEFAULT()
121:         RETURN loc_lResultado
122:     ENDPROC
123: 
124:     *==================================================================
125:     * InicializarForm - Cria o Business Object e monta o cabecalho
126:     *==================================================================
127:     PROTECTED PROCEDURE InicializarForm()
128:         LOCAL loc_lSucesso
129:         loc_lSucesso = .F.
130: 
131:         TRY
132:             THIS.this_oBusinessObject = CREATEOBJECT("sigopcgbBO")
133: 
134:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
135:                 MsgErro("Erro ao criar sigopcgbBO. VARTYPE retornou: " + ;
136:                     VARTYPE(THIS.this_oBusinessObject), "Formsigopcgb.InicializarForm")
137:             ELSE
138:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
139:                 THIS.Caption = "Pesquisa Global de C" + CHR(243) + "digo de Barras"
140: 
141:                 THIS.ConfigurarCabecalho()
142:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
143:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
144: 
145:                 *-- Parametros que o Init legado le ANTES de montar as grades:
146:                 *-- Habvalor decide a 11a coluna do Historico (Valor x Peso) e
147:                 *-- o controle de lotes decide a visibilidade do Rastreabilidade.
148:                 IF THIS.PodeConsultarBanco()
149:                     THIS.this_oBusinessObject.CarregarParametrosIniciais()
150:                 ENDIF
151: 
152:                 *-- Botoes de acao DEPOIS do cabecalho (flutuam por cima dele,
153:                 *-- mesma regra do cnt_4c_Saida canonico - regra #11/CLAUDE.md)
154:                 THIS.ConfigurarBotoesAcao()
155:                 THIS.ConfigurarCamposPrincipais()
156:                 THIS.ConfigurarCamposComplementares()
157:                 THIS.ConfigurarPainelCorrecao()
158:                 THIS.ConfigurarGrids()
159:                 THIS.ConfigurarTimerFoco()
160: 
161:                 *-- Cursores ANTES do bind: ControlSource de cursor inexistente
162:                 *-- derruba o Init e a tela nao abre (regra #41/CLAUDE.md).
163:                 THIS.CriarCursoresGrades()
164:                 THIS.VincularGrades()
165:                 THIS.ConfigurarBindings()
166: 
167:                 THIS.AplicarAcessoBotoes()
168:                 THIS.AtualizarEstadoBotoes(THIS.this_nCodBarraInicial)
169: 
170:                 *-- Legado: If (Type([pBar])=[N]) And (GetBarras.Value > 0) ->
171:                 *-- ThisForm.Processamento. Sem conexao (validacao de UI/teste
172:                 *-- automatizado) nao ha o que consultar. Passa pelo mesmo
173:                 *-- funil da digitacao manual (ValidarBarras), que tambem
174:                 *-- carrega Produto/Posicao Atual, nao so as grades.
175:                 IF THIS.this_nCodBarraInicial > 0 AND THIS.PodeConsultarBanco()
176:                     THIS.txt_4c_Barras.Value = THIS.this_nCodBarraInicial

*-- Linhas 194 a 248:
194:         CATCH TO loc_oErro
195:             MsgErro(loc_oErro.Message + CHR(13) + ;
196:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
197:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.InicializarForm")
198:         ENDTRY
199: 
200:         RETURN loc_lSucesso
201:     ENDPROC
202: 
203:     *==================================================================
204:     * ConfigurarCabecalho - Container cinza escuro com titulo do form
205:     * (equivalente ao cntSombra do legado: Top=0, Left=0, Height=80,
206:     * BackColor=RGB(100,100,100) - criado direto no form, sem PageFrame)
207:     *==================================================================
208:     PROTECTED PROCEDURE ConfigurarCabecalho()
209:         LOCAL loc_oCnt
210: 
211:         THIS.AddObject("cnt_4c_Sombra", "Container")
212:         loc_oCnt = THIS.cnt_4c_Sombra
213:         WITH loc_oCnt
214:             .Top         = 0
215:             .Left        = 0
216:             .Width       = THIS.Width
217:             .Height      = 80
218:             .BorderWidth = 0
219:             .BackColor   = RGB(100, 100, 100)
220:             .Visible     = .T.
221:         ENDWITH
222: 
223:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
224:         WITH loc_oCnt.lbl_4c_Sombra
225:             .FontBold      = .T.
226:             .FontName      = "Tahoma"
227:             .FontSize      = 18
228:             .FontUnderline = .F.
229:             .WordWrap      = .T.
230:             .Alignment     = 0
231:             .BackStyle     = 0
232:             .AutoSize      = .F.
233:             .Caption       = THIS.Caption
234:             .Height        = 40
235:             .Left          = 10
236:             .Top           = 18
237:             .Width         = 769
238:             .ForeColor     = RGB(0, 0, 0)
239:             .Visible       = .T.
240:         ENDWITH
241: 
242:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
243:         WITH loc_oCnt.lbl_4c_Titulo
244:             .FontBold  = .T.
245:             .FontName  = "Tahoma"
246:             .FontSize  = 18
247:             .WordWrap  = .T.
248:             .Alignment = 0

*-- Linhas 274 a 317:
274:     * por isso levam Themes = .T. + DisabledPicture. O botao do
275:     * CommandGroup mantem Themes = .F. (padrao canonico do grupo).
276:     *==================================================================
277:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
278:         LOCAL loc_oGrp
279: 
280:         *-- obj_4c_CmdBtnForm (CommandGroup, 1 botao: Encerrar/Sair)
281:         THIS.AddObject("obj_4c_CmdBtnForm", "CommandGroup")
282:         loc_oGrp = THIS.obj_4c_CmdBtnForm
283:         WITH loc_oGrp
284:             .Top           = -2
285:             .Left          = 920
286:             .Width         = 85
287:             .Height        = 85
288:             .ButtonCount   = 1
289:             .BackStyle     = 0
290:             .BorderStyle   = 0
291:             .SpecialEffect = 1
292:             .Themes        = .F.
293:             .Visible       = .T.
294:         ENDWITH
295: 
296:         WITH loc_oGrp.Buttons(1)
297:             .Top       = 5
298:             .Left      = 5
299:             .Width     = 75
300:             .Height    = 75
301:             .FontBold  = .T.
302:             .FontItalic = .T.
303:             .FontName  = "Comic Sans MS"
304:             .FontSize  = 8
305:             .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:             .Cancel    = .T.
307:             .Caption   = "Encerrar"
308:             .ForeColor = RGB(90, 90, 90)
309:             .BackColor = RGB(255, 255, 255)
310:             .Themes    = .F.
311:         ENDWITH
312: 
313:         *-- cmd_4c_BtnImprimir
314:         THIS.AddObject("cmd_4c_BtnImprimir", "CommandButton")
315:         WITH THIS.cmd_4c_BtnImprimir
316:             .Top        = 3
317:             .Left       = 550

*-- Linhas 426 a 480:
426:     * encontrado pela pesquisa (TmpPro no legado).
427:     *
428:     * Os campos deste bloco sao SOMENTE EXIBICAO: no legado todos tem
429:     * PROCEDURE When Return(.F.) (nunca recebem foco), exceto getBarras,
430:     * que eh a UNICA entrada editavel - reproduzido aqui com .TabStop = .F.
431:     * nos campos de exibicao. A fiacao do evento de pesquisa (KeyPress de
432:     * txt_4c_Barras) e o preenchimento destes campos a partir do BO ficam
433:     * para fase posterior (wiring), nao fazem parte desta fase (so layout).
434:     *
435:     * Posicoes/Caption/Width transcritos LITERALMENTE do dump do SCX
436:     * (regra CLAUDE.md #23/#28). Label sem Width no dump (classe say sem
437:     * override) recebe Width calculado = Left do campo vizinho - Left do
438:     * label - folga de ~3px (AutoSize=.T. eh no-op em Label por AddObject).
439:     *==================================================================
440:     PROTECTED PROCEDURE ConfigurarCamposPrincipais()
441: 
442:         *-- Shape1 - moldura do campo de pesquisa do codigo de barras
443:         THIS.AddObject("shp_4c_Shape1", "Shape")
444:         WITH THIS.shp_4c_Shape1
445:             .Top         = 88
446:             .Left        = 761
447:             .Width       = 232
448:             .Height      = 31
449:             .BackStyle   = 0
450:             .FillStyle   = 1
451:             .ColorScheme = 1
452:             .BorderColor = RGB(90, 90, 90)
453:             .Visible     = .T.
454:         ENDWITH
455: 
456:         *-- Say1 / getBarras - entrada do codigo de barras (UNICO campo
457:         *-- editavel deste metodo; os demais sao somente exibicao)
458:         THIS.AddObject("lbl_4c_CodBarra", "Label")
459:         WITH THIS.lbl_4c_CodBarra
460:             .FontName  = "Tahoma"
461:             .FontSize  = 8
462:             .BackStyle = 0
463:             .Alignment = 0
464:             .Caption   = "C" + CHR(243) + "digo de Barra :"
465:             .Left      = 782
466:             .Top        = 96
467:             .Width      = 86
468:             .Height     = 15
469:             .ForeColor = RGB(90, 90, 90)
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         THIS.AddObject("txt_4c_Barras", "TextBox")
474:         WITH THIS.txt_4c_Barras
475:             .FontName      = "Tahoma"
476:             .FontSize      = 8
477:             .Alignment     = 3
478:             .Format        = "Z"
479:             .Height        = 23
480:             .Left          = 870

*-- Linhas 873 a 916:
873:     * de pesquisa (ValidarBarras/AtualizarCamposEtiqueta/AtualizarCamposProduto),
874:     * nao por ControlSource - igual ao padrao da fase anterior.
875:     *==================================================================
876:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
877: 
878:         *-- Shape7 - moldura "Posicao Atual do Codigo de Barras"
879:         THIS.AddObject("shp_4c_Shape7", "Shape")
880:         WITH THIS.shp_4c_Shape7
881:             .Top         = 144
882:             .Left        = 648
883:             .Width       = 344
884:             .Height      = 106
885:             .BackStyle   = 0
886:             .BorderStyle = 6
887:             .FillStyle   = 1
888:             .ColorScheme = 1
889:             .BorderColor = RGB(90, 90, 90)
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         THIS.AddObject("lbl_4c_PosicaoAtual", "Label")
894:         WITH THIS.lbl_4c_PosicaoAtual
895:             .FontBold  = .T.
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:             .BackStyle = 0
899:             .Alignment = 0
900:             .Caption   = "Posi" + CHR(231) + CHR(227) + "o Atual do C" + CHR(243) + "digo de Barras"
901:             .Left      = 648
902:             .Top       = 130
903:             .Width     = 193
904:             .Height    = 15
905:             .ForeColor = RGB(90, 90, 90)
906:             .Visible   = .T.
907:         ENDWITH
908: 
909:         *-- Linha 1: Empresa
910:         THIS.AddObject("lbl_4c_Emp", "Label")
911:         WITH THIS.lbl_4c_Emp
912:             .FontName  = "Tahoma"
913:             .FontSize  = 8
914:             .BackStyle = 0
915:             .Alignment = 0
916:             .Caption   = "Emp :"

*-- Linhas 1374 a 1417:
1374:     * legado ((ThisForm.Height / 2) - (.Height / 2)) - o valor aqui eh so o
1375:     * ponto de partida (.Left/.Width/.Height do dump).
1376:     *==================================================================
1377:     PROTECTED PROCEDURE ConfigurarPainelCorrecao()
1378:         THIS.AddObject("cnt_4c_Correcao", "Container")
1379:         WITH THIS.cnt_4c_Correcao
1380:             .Top           = 322
1381:             .Left          = 252
1382:             .Width         = 556
1383:             .Height        = 182
1384:             .SpecialEffect = 1
1385:             .BackColor     = RGB(255, 255, 255)
1386:             .BorderColor   = RGB(90, 90, 90)
1387:             .Visible       = .F.
1388:         ENDWITH
1389: 
1390:         THIS.cnt_4c_Correcao.AddObject("lbl_4c_TituloCorrecao", "Label")
1391:         WITH THIS.cnt_4c_Correcao.lbl_4c_TituloCorrecao
1392:             .FontBold  = .T.
1393:             .FontName  = "Tahoma"
1394:             .FontSize  = 8
1395:             .BackStyle = 0
1396:             .Alignment = 0
1397:             .Caption   = "Corre" + CHR(231) + CHR(245) + "es do C" + CHR(243) + "digo de Barras"
1398:             .Left      = 2
1399:             .Top       = 5
1400:             .Width     = 423
1401:             .Height    = 17
1402:             .ForeColor = RGB(90, 90, 90)
1403:             .Visible   = .T.
1404:         ENDWITH
1405: 
1406:         THIS.cnt_4c_Correcao.AddObject("obj_4c_CmdCorrecao", "CommandGroup")
1407:         WITH THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao
1408:             .Top         = -1
1409:             .Left        = 471
1410:             .Width       = 85
1411:             .Height      = 85
1412:             .ButtonCount = 1
1413:             .BackStyle   = 0
1414:             .BorderStyle = 0
1415:             .Themes      = .F.
1416:             .Visible     = .T.
1417:         ENDWITH

*-- Linhas 1447 a 1696:
1447:     * roda depois de CriarCursoresGrades - ControlSource de cursor que ainda
1448:     * nao existe derruba o Init e a tela nao abre (regra CLAUDE.md #41).
1449:     *==================================================================
1450:     PROTECTED PROCEDURE ConfigurarGrids()
1451:         THIS.CriarGradeHistorico()
1452:         THIS.CriarGradeMovimento()
1453:         THIS.CriarGradeDevolucao()
1454:         THIS.CriarGradeCotacoes()
1455:         THIS.CriarGradeCorrecao()
1456:     ENDPROC
1457: 
1458:     *==================================================================
1459:     * ConfigurarTimerFoco - tmr_4c_FocoBarras (legado: tmAux, Timer com
1460:     * Interval = 200).
1461:     *
1462:     * NAO eh enfeite: em VFP9 nao se pode devolver o foco a um controle de
1463:     * DENTRO do LostFocus dele - a chamada eh ignorada. O legado resolve
1464:     * exatamente assim, armando um timer de 200ms no LostFocus; o Timer
1465:     * chama ThisForm.foca() (que faz getBarras.SetFocus) e se DESARMA
1466:     * (This.Enabled = .F.), ou seja eh um "one-shot".
1467:     *
1468:     * Nasce DESARMADO: em VFP9 Timer.Enabled tem default .T., e um timer
1469:     * armado no Init roubaria o foco do primeiro controle da tela a cada
1470:     * 200ms antes de qualquer digitacao.
1471:     *==================================================================
1472:     PROTECTED PROCEDURE ConfigurarTimerFoco()
1473:         THIS.AddObject("tmr_4c_FocoBarras", "Timer")
1474: 
1475:         WITH THIS.tmr_4c_FocoBarras
1476:             .Interval = 200
1477:             .Enabled  = .F.
1478:         ENDWITH
1479:     ENDPROC
1480: 
1481:     *--------------------------------------------------------------------------
1482:     * CriarGradeHistorico - grd_4c_Historico (legado: grdHistorico, 11 colunas)
1483:     *--------------------------------------------------------------------------
1484:     PROTECTED PROCEDURE CriarGradeHistorico()
1485:         LOCAL loc_oGrd
1486: 
1487:         THIS.AddObject("grd_4c_Historico", "Grid")
1488:         loc_oGrd = THIS.grd_4c_Historico
1489:         WITH loc_oGrd
1490:             .Top         = 276
1491:             .Left        = 15
1492:             .Width       = 750
1493:             .Height      = 166
1494:             .FontName    = "Tahoma"
1495:             .FontSize    = 8
1496:             .ColumnCount = 11
1497:             .DeleteMark  = .F.
1498:             .RecordMark  = .F.
1499:             .ReadOnly    = .T.
1500:             .Visible     = .T.
1501:         ENDWITH
1502: 
1503:     ENDPROC
1504: 
1505:     *--------------------------------------------------------------------------
1506:     * CriarGradeMovimento - grd_4c_Movimento (legado: grdMovimento, 8 colunas)
1507:     *--------------------------------------------------------------------------
1508:     PROTECTED PROCEDURE CriarGradeMovimento()
1509:         LOCAL loc_oGrd
1510: 
1511:         THIS.AddObject("grd_4c_Movimento", "Grid")
1512:         loc_oGrd = THIS.grd_4c_Movimento
1513:         WITH loc_oGrd
1514:             .Top         = 474
1515:             .Left        = 14
1516:             .Width       = 544
1517:             .Height      = 94
1518:             .FontName    = "Tahoma"
1519:             .FontSize    = 8
1520:             .ColumnCount = 8
1521:             .DeleteMark  = .F.
1522:             .RecordMark  = .F.
1523:             .ReadOnly    = .T.
1524:             .Visible     = .T.
1525:         ENDWITH
1526: 
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * CriarGradeDevolucao - grd_4c_Devolucao (legado: grddevolucao, 6 colunas)
1531:     *--------------------------------------------------------------------------
1532:     PROTECTED PROCEDURE CriarGradeDevolucao()
1533:         LOCAL loc_oGrd
1534: 
1535:         THIS.AddObject("grd_4c_Devolucao", "Grid")
1536:         loc_oGrd = THIS.grd_4c_Devolucao
1537:         WITH loc_oGrd
1538:             .Top         = 474
1539:             .Left        = 568
1540:             .Width       = 414
1541:             .Height      = 94
1542:             .FontName    = "Tahoma"
1543:             .FontSize    = 8
1544:             .ColumnCount = 6
1545:             .DeleteMark  = .F.
1546:             .RecordMark  = .F.
1547:             .ReadOnly    = .T.
1548:             .Visible     = .T.
1549:         ENDWITH
1550: 
1551:     ENDPROC
1552: 
1553:     *--------------------------------------------------------------------------
1554:     * CriarGradeCotacoes - grd_4c_Cotacoes (legado: grdCot.grade_Cot, 2
1555:     * colunas), dentro do container cnt_4c_GrdCot (que ja foi criado em
1556:     * ConfigurarCamposComplementares - a grade PRECISA do container pai).
1557:     *--------------------------------------------------------------------------
1558:     PROTECTED PROCEDURE CriarGradeCotacoes()
1559:         LOCAL loc_oGrd
1560: 
1561:         THIS.cnt_4c_GrdCot.AddObject("grd_4c_Cotacoes", "Grid")
1562:         loc_oGrd = THIS.cnt_4c_GrdCot.grd_4c_Cotacoes
1563:         WITH loc_oGrd
1564:             .Top           = 26
1565:             .Left          = 6
1566:             .Width         = 164
1567:             .Height        = 147
1568:             .FontName      = "Tahoma"
1569:             .FontSize      = 8
1570:             .ColumnCount   = 2
1571:             .DeleteMark    = .F.
1572:             .RecordMark    = .F.
1573:             .ReadOnly      = .T.
1574:             .RowHeight     = 16
1575:             .ScrollBars    = 2
1576:             .GridLineColor = RGB(238, 238, 238)
1577:             .Visible       = .T.
1578:         ENDWITH
1579:     ENDPROC
1580: 
1581:     *--------------------------------------------------------------------------
1582:     * CriarGradeCorrecao - grd_4c_Correcao (legado: Cnt_Correcao.GrdCorrecao,
1583:     * 6 colunas), dentro do container cnt_4c_Correcao (criado em
1584:     * ConfigurarPainelCorrecao - a grade PRECISA do container pai).
1585:     *--------------------------------------------------------------------------
1586:     PROTECTED PROCEDURE CriarGradeCorrecao()
1587:         LOCAL loc_oGrd
1588: 
1589:         THIS.cnt_4c_Correcao.AddObject("grd_4c_Correcao", "Grid")
1590:         loc_oGrd = THIS.cnt_4c_Correcao.grd_4c_Correcao
1591:         WITH loc_oGrd
1592:             .Top         = 27
1593:             .Left        = 6
1594:             .Width       = 447
1595:             .Height      = 146
1596:             .FontName    = "Tahoma"
1597:             .FontSize    = 8
1598:             .ColumnCount = 6
1599:             .DeleteMark  = .F.
1600:             .RecordMark  = .F.
1601:             .ReadOnly    = .T.
1602:             .Visible     = .T.
1603:         ENDWITH
1604:     ENDPROC
1605: 
1606:     *--------------------------------------------------------------------------
1607:     * ConfigurarColunaGrade - aplica Width/Header1.Caption/estilo de coluna
1608:     * comum as 3 grades (Tahoma 8, Alignment=2 no header - direita - igual
1609:     * ao dump; Text1 BorderStyle=0/Margin=0/ReadOnly=.T. - sem coluna
1610:     * editavel nestas grades de resultado).
1611:     *--------------------------------------------------------------------------
1612:     PROTECTED PROCEDURE ConfigurarColunaGrade(par_oGrd, par_nCol, par_nWidth, par_cCaption)
1613:         LOCAL loc_oCol
1614:         loc_oCol = par_oGrd.Columns(par_nCol)
1615: 
1616:         WITH loc_oCol
1617:             .Width     = par_nWidth
1618:             .Movable   = .F.
1619:             .Resizable = .F.
1620:             .ReadOnly  = .T.
1621:         ENDWITH
1622: 
1623:         WITH loc_oCol.Header1
1624:             .FontName  = "Tahoma"
1625:             .FontSize  = 8
1626:             .Alignment = 2
1627:             .Caption   = par_cCaption
1628:         ENDWITH
1629: 
1630:         WITH loc_oCol.Text1
1631:             .BorderStyle = 0
1632:             .Margin      = 0
1633:             .ReadOnly    = .T.
1634:             .ForeColor   = RGB(0, 0, 0)
1635:             .BackColor   = RGB(255, 255, 255)
1636:         ENDWITH
1637:     ENDPROC
1638: 
1639:     *==================================================================
1640:     * CriarCursoresGrades - Cria os cursores que alimentam as 3 grades.
1641:     *
1642:     * Estrutura de cursor_4c_Historico e cursor_4c_Movimento transcrita
1643:     * literalmente do Init legado (CsHistorico/CsMovimento), com os MESMOS
1644:     * indices - EmpDopNum e OriDopNums sao usados por SEEK no BO para decidir
1645:     * se o movimento ja tem historico, e DtOpers eh a ordem de exibicao.
1646:     *
1647:     * Os tres cursores sao criados UMA UNICA VEZ, aqui, e so sao esvaziados
1648:     * (ZAP) e repopulados pelo BO - nunca derrubados por SQLEXEC, que zeraria
1649:     * o ColumnCount das grades ligadas a eles.
1650:     *
1651:     * cursor_4c_Devolucao nao existe no legado como cursor proprio: la o
1652:     * SQLEXEC das barras devolvidas ia DIRETO para o alias da grade. As
1653:     * colunas abaixo tem os nomes EXATOS dos aliases daquele SELECT, porque
1654:     * o APPEND FROM do BO casa por NOME.
1655:     *==================================================================
1656:     PROTECTED PROCEDURE CriarCursoresGrades()
1657:         *-- Grade de Historico (CsHistorico no legado)
1658:         IF USED("cursor_4c_Historico")
1659:             USE IN cursor_4c_Historico
1660:         ENDIF
1661: 
1662:         SET NULL ON
1663:         CREATE CURSOR cursor_4c_Historico ;
1664:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1665:              datas D, grupos C(10), estos C(10), opers C(1), codcors C(4), ;
1666:              codtams C(4), valor N(12,2), Qtds N(9,3), Pesos N(9,3), OriDopNums C(29))
1667:         SET NULL OFF
1668: 
1669:         INDEX ON emps + dopes + STR(numes, 6) TAG EmpDopNum
1670:         INDEX ON OriDopNums TAG OriDopNums
1671:         INDEX ON DTOS(datas) TAG DtOpers
1672: 
1673:         *-- Grade de Movimento (CsMovimento no legado)
1674:         IF USED("cursor_4c_Movimento")
1675:             USE IN cursor_4c_Movimento
1676:         ENDIF
1677: 
1678:         SET NULL ON
1679:         CREATE CURSOR cursor_4c_Movimento ;
1680:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1681:              datas D, opers C(1), valor N(12,2), Qtds N(12,3), Pesos N(12,3), ;
1682:              OriDopNums C(29))
1683:         SET NULL OFF
1684: 
1685:         INDEX ON DTOS(datas) TAG DtOpers
1686: 
1687:         *-- Grade de Devolucao (crSigOpexi no legado).
1688:         *-- SET NULL ON eh obrigatorio: SigOpExi.datas aceita NULL no banco e o
1689:         *-- APPEND FROM do BO falharia num campo declarado NOT NULL.
1690:         *-- Desvio documentado: datas aqui eh DATE e no legado era o datetime
1691:         *-- cru do SQL Server. A coluna da grade tem 70px (nao cabe a hora) e as
1692:         *-- duas grades irmas usam DATE no mesmo campo "Data".
1693:         IF USED("cursor_4c_Devolucao")
1694:             USE IN cursor_4c_Devolucao
1695:         ENDIF
1696: 

*-- Linhas 1740 a 1783:
1740:     * legado: com Habvalor mostra "valor" (caption "Valor"); sem Habvalor
1741:     * mostra "Pesos" e mantem o caption desenhado no SCX.
1742:     *==================================================================
1743:     PROTECTED PROCEDURE VincularGrades()
1744:         LOCAL loc_oGrd, loc_lHabValor
1745: 
1746:         loc_lHabValor = .F.
1747:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1748:             loc_lHabValor = THIS.this_oBusinessObject.this_lHabilitaValor
1749:         ENDIF
1750: 
1751:         *-- Grade de Historico
1752:         loc_oGrd = THIS.grd_4c_Historico
1753:         loc_oGrd.ColumnCount = 11
1754:         loc_oGrd.RecordSource = "cursor_4c_Historico"
1755: 
1756:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Historico.datas"
1757:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.opers"
1758:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Historico.emps"
1759:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Historico.dopes"
1760:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Historico.numes"
1761:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Historico.grupos"
1762:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Historico.estos"
1763:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Historico.codcors"
1764:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Historico.codtams"
1765:         loc_oGrd.Column10.ControlSource = "cursor_4c_Historico.Qtds"
1766: 
1767:         IF loc_lHabValor
1768:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.valor"
1769:         ELSE
1770:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.Pesos"
1771:         ENDIF
1772: 
1773:         THIS.ConfigurarColunaGrade(loc_oGrd, 1,  69,  "Data")
1774:         THIS.ConfigurarColunaGrade(loc_oGrd, 2,  15,  "O")
1775:         THIS.ConfigurarColunaGrade(loc_oGrd, 3,  28,  "Emp")
1776:         THIS.ConfigurarColunaGrade(loc_oGrd, 4,  203, "Movimenta" + CHR(231) + CHR(227) + "o")
1777:         THIS.ConfigurarColunaGrade(loc_oGrd, 5,  50,  "C" + CHR(243) + "digo")
1778:         THIS.ConfigurarColunaGrade(loc_oGrd, 6,  75,  "Grupo")
1779:         THIS.ConfigurarColunaGrade(loc_oGrd, 7,  75,  "Conta")
1780:         THIS.ConfigurarColunaGrade(loc_oGrd, 8,  32,  "Cor")
1781:         THIS.ConfigurarColunaGrade(loc_oGrd, 9,  32,  "Tam")
1782:         THIS.ConfigurarColunaGrade(loc_oGrd, 10, 70,  "Qtd")
1783:         THIS.ConfigurarColunaGrade(loc_oGrd, 11, 70,  IIF(loc_lHabValor, "Valor", "Qtd"))

*-- Linhas 1860 a 2267:
1860: 
1861:     *==================================================================
1862:     * CarregarDados - Monta as 3 grades para um codigo de barras.
1863:     * Equivalente a parte do PROCEDURE Processamento do legado que diz
1864:     * respeito as grades; os campos do produto/etiqueta sao preenchidos
1865:     * pelos metodos da pagina de dados.
1866:     *
1867:     * par_nCodBarras: codigo de barras a pesquisar. Zero/invalido apenas
1868:     * limpa as grades (nenhuma consulta eh disparada).
1869:     *==================================================================
1870:     PROCEDURE CarregarDados(par_nCodBarras)
1871:         LOCAL loc_nCodBarras, loc_lSucesso
1872: 
1873:         loc_lSucesso  = .F.
1874:         loc_nCodBarras = IIF(VARTYPE(par_nCodBarras) = "N", par_nCodBarras, 0)
1875: 
1876:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1877:             RETURN .F.
1878:         ENDIF
1879: 
1880:         IF loc_nCodBarras <= 0
1881:             THIS.LimparGrades()
1882:             RETURN .F.
1883:         ENDIF
1884: 
1885:         TRY
1886:             IF THIS.this_oBusinessObject.CarregarGradesPorCodBarras(loc_nCodBarras)
1887:                 IF THIS.this_oBusinessObject.CarregarDevolucaoPorCodBarras(loc_nCodBarras)
1888:                     loc_lSucesso = .T.
1889:                 ENDIF
1890:             ENDIF
1891: 
1892:             THIS.this_oBusinessObject.LiberarCursoresConsulta()
1893: 
1894:             *-- Ordem de exibicao do legado: Set Order To DtOpers nas duas grades
1895:             THIS.RepintarGrades()
1896:             THIS.AtualizarEstadoBotoes(loc_nCodBarras)
1897:         CATCH TO loc_oErro
1898:             MsgErro(loc_oErro.Message + CHR(13) + ;
1899:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1900:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.CarregarDados")
1901:         ENDTRY
1902: 
1903:         RETURN loc_lSucesso
1904:     ENDPROC
1905: 
1906:     *==================================================================
1907:     * LimparGrades - Esvazia os 3 cursores e repinta. Usado quando o
1908:     * codigo de barras eh apagado/invalido: as grades tem de ficar vazias
1909:     * em vez de manter o resultado da pesquisa anterior.
1910:     *==================================================================
1911:     PROCEDURE LimparGrades()
1912:         IF USED("cursor_4c_Historico")
1913:             ZAP IN cursor_4c_Historico
1914:         ENDIF
1915:         IF USED("cursor_4c_Movimento")
1916:             ZAP IN cursor_4c_Movimento
1917:         ENDIF
1918:         IF USED("cursor_4c_Devolucao")
1919:             ZAP IN cursor_4c_Devolucao
1920:         ENDIF
1921: 
1922:         THIS.RepintarGrades()
1923:         THIS.AtualizarEstadoBotoes(0)
1924: 
1925:         RETURN .T.
1926:     ENDPROC
1927: 
1928:     *==================================================================
1929:     * RepintarGrades - FUNIL unico de repintura. Popular o cursor NAO faz a
1930:     * grade redesenhar: sem reposicionar o ponteiro + Refresh a grade aparece
1931:     * vazia com o cursor cheio.
1932:     *
1933:     * O legado fecha o Processamento assim, e eh isso que se reproduz:
1934:     *   Select CsMovimento / Set Order To DtOpers / AfterRowColChange / Go Bottom
1935:     *   Select CsHistorico / Set Order To DtOpers / AfterRowColChange / Go Bottom
1936:     * ou seja GO BOTTOM (ultimo movimento, o mais recente), NAO Go Top. A grade
1937:     * de devolucao nao eh reordenada nem reposicionada pelo legado.
1938:     *
1939:     * Chamado em TODO caminho que popula ou esvazia os cursores.
1940:     *==================================================================
1941:     PROCEDURE RepintarGrades()
1942:         IF USED("cursor_4c_Historico")
1943:             SELECT cursor_4c_Historico
1944:             SET ORDER TO TAG DtOpers
1945:             GO BOTTOM
1946:             THIS.grd_4c_Historico.Refresh()
1947:         ENDIF
1948: 
1949:         IF USED("cursor_4c_Movimento")
1950:             SELECT cursor_4c_Movimento
1951:             SET ORDER TO TAG DtOpers
1952:             GO BOTTOM
1953:             THIS.grd_4c_Movimento.Refresh()
1954:         ENDIF
1955: 
1956:         IF USED("cursor_4c_Devolucao")
1957:             SELECT cursor_4c_Devolucao
1958:             GO TOP
1959:             THIS.grd_4c_Devolucao.Refresh()
1960:         ENDIF
1961: 
1962:         *-- O legado deixa CsHistorico selecionado quando CsMovimento esta vazio
1963:         *-- (If RecCount('CsMovimento') < 1 / Select CsHistorico).
1964:         IF USED("cursor_4c_Movimento") AND RECCOUNT("cursor_4c_Movimento") < 1
1965:             IF USED("cursor_4c_Historico")
1966:                 SELECT cursor_4c_Historico
1967:             ENDIF
1968:         ENDIF
1969: 
1970:         RETURN .T.
1971:     ENDPROC
1972: 
1973:     *==================================================================
1974:     * AplicarAcessoBotoes - Visibilidade dos botoes por permissao, como no
1975:     * Init legado:
1976:     *   .BtnDocumento.Visible      = fChecaAcesso('SIGOPCGB','BTNDOC')
1977:     *   .BtnImprimir.Visible       = fChecaAcesso('SIGOPCGB','IMPRIMIR')
1978:     *   .BtnVisualizar.Visible     = fChecaAcesso('SIGOPCGB','VISUALIZAR')
1979:     *   .Bot_Rastro.Visible        = fChecaAcesso('SIGOPCGB','RASTRO') And !Eof('TmpOpe')
1980:     *   .Botao_de_Correcao.Visible = fChecaAcesso('SIGOPCGB','CORRECAO')
1981:     * O !Eof('TmpOpe') eh o this_lControlaLotes do BO (existe SigCdOpe com
1982:     * ctrllotes 1 ou 2).
1983:     *==================================================================
1984:     PROTECTED PROCEDURE AplicarAcessoBotoes()
1985:         LOCAL loc_oBO, loc_lLotes
1986: 
1987:         loc_oBO    = THIS.this_oBusinessObject
1988:         loc_lLotes = .F.
1989: 
1990:         IF VARTYPE(loc_oBO) = "O"
1991:             loc_oBO.this_lAcessoDocumento  = fChecaAcesso("SIGOPCGB", "BTNDOC")
1992:             loc_oBO.this_lAcessoImprimir   = fChecaAcesso("SIGOPCGB", "IMPRIMIR")
1993:             loc_oBO.this_lAcessoVisualizar = fChecaAcesso("SIGOPCGB", "VISUALIZAR")
1994:             loc_oBO.this_lAcessoRastro     = fChecaAcesso("SIGOPCGB", "RASTRO")
1995:             loc_oBO.this_lAcessoCorrecao   = fChecaAcesso("SIGOPCGB", "CORRECAO")
1996:             loc_oBO.this_lAcessoFornecedor = fChecaAcesso("SIGOPCGB", "FORNECEDOR")
1997:             loc_oBO.this_lAcessoFollowUp   = fChecaAcesso("SIGOPCGB", "FOLLOWUP")
1998: 
1999:             loc_lLotes = loc_oBO.this_lControlaLotes
2000: 
2001:             THIS.cmd_4c_BtnDocumento.Visible  = loc_oBO.this_lAcessoDocumento
2002:             THIS.cmd_4c_BtnImprimir.Visible   = loc_oBO.this_lAcessoImprimir
2003:             THIS.cmd_4c_BtnVisualizar.Visible = loc_oBO.this_lAcessoVisualizar
2004:             THIS.cmd_4c_BotRastro.Visible     = (loc_oBO.this_lAcessoRastro AND loc_lLotes)
2005:             THIS.cmd_4c_BotaoCorrecao.Visible = loc_oBO.this_lAcessoCorrecao
2006:         ENDIF
2007: 
2008:         RETURN .T.
2009:     ENDPROC
2010: 
2011:     *==================================================================
2012:     * AtualizarEstadoBotoes - Reproduz o When dos botoes de acao do legado
2013:     * (Return(!Empty(ThisForm.GetBarras.Value))): sem codigo de barras
2014:     * pesquisado, nenhuma das acoes faz sentido e os botoes ficam
2015:     * desabilitados. O Encerrar NUNCA eh desabilitado - eh a saida da tela.
2016:     *
2017:     * Chamado pelo FUNIL de carga (CarregarDados/LimparGrades), nao por cada
2018:     * botao: quem desabilita tem de reabilitar no caminho de volta.
2019:     *==================================================================
2020:     PROCEDURE AtualizarEstadoBotoes(par_nCodBarras)
2021:         LOCAL loc_lAtivo
2022: 
2023:         loc_lAtivo = (VARTYPE(par_nCodBarras) = "N" AND par_nCodBarras > 0)
2024: 
2025:         THIS.cmd_4c_BtnImprimir.Enabled   = loc_lAtivo
2026:         THIS.cmd_4c_BtnVisualizar.Enabled = loc_lAtivo
2027:         THIS.cmd_4c_BtnDocumento.Enabled  = loc_lAtivo
2028:         THIS.cmd_4c_BotRastro.Enabled     = loc_lAtivo
2029:         THIS.cmd_4c_BotaoCorrecao.Enabled = loc_lAtivo
2030:         THIS.cmd_4c_BtnLocal.Enabled      = loc_lAtivo
2031: 
2032:         *-- As 3 grades tambem tem o MESMO When no legado
2033:         *-- (grdHistorico/grdMovimento/grddevolucao: "Return(!Empty(
2034:         *-- ThisForm.GetBarras.Value))"): sem codigo pesquisado elas estao
2035:         *-- vazias e nao devem aceitar foco/navegacao.
2036:         THIS.grd_4c_Historico.Enabled = loc_lAtivo
2037:         THIS.grd_4c_Movimento.Enabled = loc_lAtivo
2038:         THIS.grd_4c_Devolucao.Enabled = loc_lAtivo
2039: 
2040:         RETURN .T.
2041:     ENDPROC
2042: 
2043:     *==================================================================
2044:     * ConfigurarBindings - BINDEVENT dos campos/botoes interativos desta
2045:     * fase (Fase 6/8 - campos restantes e "lookups"). O unico lookup real
2046:     * deste form OPERACIONAL eh a pesquisa por codigo de barras (nao ha
2047:     * FormBuscaAuxiliar aqui: txt_4c_Barras EH a busca).
2048:     *==================================================================
2049:     PROTECTED PROCEDURE ConfigurarBindings()
2050:         BINDEVENT(THIS.txt_4c_Barras, "KeyPress", THIS, "BarrasKeyPress")
2051: 
2052:         *-- Fase 8/8 - os tres eventos auxiliares do getBarras legado que
2053:         *-- faltavam, e sem os quais o campo de barras nao se comporta como
2054:         *-- no legado:
2055:         *--   GotFocus  = "This.peantvalue = This.Value" (guard de valor nao
2056:         *--               mudado, consumido pelo Valid)
2057:         *--   LostFocus = arma o tmAux (devolucao do foco) - aqui tambem
2058:         *--               dispara a pesquisa, que no legado eh o Valid: os
2059:         *--               dois rodam ao SAIR do campo, e BINDEVENT em "Valid"
2060:         *--               nao dispara de forma confiavel em TextBox (regra
2061:         *--               CLAUDE.md #3/#35), entao o Valid vive no LostFocus.
2062:         *--   Timer     = devolve o foco ao campo e se desarma
2063:         BINDEVENT(THIS.txt_4c_Barras, "GotFocus", THIS, "BarrasGotFocus")
2064:         BINDEVENT(THIS.txt_4c_Barras, "LostFocus", THIS, "BarrasLostFocus")
2065:         BINDEVENT(THIS.tmr_4c_FocoBarras, "Timer", THIS, "TimerFocoBarras")
2066: 
2067:         BINDEVENT(THIS.cmd_4c_BtnLocal, "Click", THIS, "BtnLocalClick")
2068:         BINDEVENT(THIS.chk_4c_BotCotacoes, "Click", THIS, "BotCotacoesClick")
2069: 
2070:         *-- AfterRowColChange para mostrar o produto/imagem da LINHA
2071:         *-- corrente (uso legitimo de AfterRowColChange - regra #46/CLAUDE.md,
2072:         *-- "carregar detalhe da linha corrente" - diferente de validar
2073:         *-- celula editavel, que este form nao tem: as 3 grades sao ReadOnly).
2074:         BINDEVENT(THIS.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
2075:         BINDEVENT(THIS.grd_4c_Movimento, "AfterRowColChange", THIS, "GradeMovimentoAfterRowColChange")
2076: 
2077:         *-- Legado: grdHistorico.Click delega para o handler nativo de
2078:         *-- AfterRowColChange (reforca a
2079:         *-- repintura ao clicar na MESMA celula ja focada) e
2080:         *-- grddevolucao.AfterRowColChange so marca a grade selecionada
2081:         *-- (this_nGradeSel), usado por BtnDocumentoClick/BotRastroClick.
2082:         BINDEVENT(THIS.grd_4c_Historico, "Click", THIS, "GradeHistoricoClick")
2083:         BINDEVENT(THIS.grd_4c_Devolucao, "AfterRowColChange", THIS, "GradeDevolucaoAfterRowColChange")
2084: 
2085:         *-- Botoes de acao (Fase 7/8 - eventos principais).
2086:         BINDEVENT(THIS.obj_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnEncerrarClick")
2087:         BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2088:         BINDEVENT(THIS.cmd_4c_BtnVisualizar, "Click", THIS, "BtnVisualizarClick")
2089:         BINDEVENT(THIS.cmd_4c_BtnDocumento, "Click", THIS, "BtnDocumentoClick")
2090:         BINDEVENT(THIS.cmd_4c_BotRastro, "Click", THIS, "BotRastroClick")
2091:         BINDEVENT(THIS.cmd_4c_BotaoCorrecao, "Click", THIS, "BotaoCorrecaoClick")
2092:         BINDEVENT(THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao.Buttons(1), "Click", THIS, "PainelCorrecaoEncerrarClick")
2093:     ENDPROC
2094: 
2095:     *==================================================================
2096:     * BarrasKeyPress - txt_4c_Barras (equivalente ao getBarras do legado).
2097:     * ENTER/TAB pesquisa sem esperar a saida do campo, que eh o uso real do
2098:     * leitor de codigo de barras (o scanner emite o codigo e um ENTER).
2099:     * A pesquisa ao SAIR do campo por qualquer outro meio (clicar num botao,
2100:     * por exemplo) fica no BarrasLostFocus, que eh onde mora o Valid legado.
2101:     *==================================================================
2102:     PROCEDURE BarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2103:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2104:             THIS.ValidarBarras()
2105:         ENDIF
2106:     ENDPROC
2107: 
2108:     *==================================================================
2109:     * BarrasGotFocus - legado: getBarras.GotFocus = "This.peantvalue =
2110:     * This.Value". Guarda o valor na ENTRADA do campo; o funil de pesquisa
2111:     * compara com ele para nao repetir a consulta quando o usuario entra e
2112:     * sai do campo sem mudar o codigo.
2113:     *==================================================================
2114:     PROCEDURE BarrasGotFocus()
2115:         THIS.this_nBarrasAnterior = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "N", ;
2116:             THIS.txt_4c_Barras.Value, 0)
2117:     ENDPROC
2118: 
2119:     *==================================================================
2120:     * BarrasLostFocus - reune os DOIS eventos que o legado dispara ao sair
2121:     * do campo de barras:
2122:     *
2123:     *   getBarras.Valid     - pesquisa o codigo (guard "peantvalue # Value").
2124:     *                         Vive aqui porque BINDEVENT em "Valid" nao
2125:     *                         dispara de forma confiavel em TextBox
2126:     *                         (regra CLAUDE.md #3/#35).
2127:     *   getBarras.LostFocus - "If InList(LastKey(), 13, 48..57, 9) /
2128:     *                         ThisForm.Tpbusca = 1 / tmAux.Enabled = .T."
2129:     *                         isto eh: saiu por ENTER, TAB ou digitando um
2130:     *                         digito -> arma o timer que devolve o foco ao
2131:     *                         campo, para a leitura seguinte.
2132:     *
2133:     * Tpbusca NAO eh migrada de proposito: no legado ela eh escrita em tres
2134:     * lugares (Init, LostFocus e o proprio Init com pBar) e NUNCA lida -
2135:     * estado morto. Migra-la seria criar propriedade que ninguem consulta.
2136:     *==================================================================
2137:     PROCEDURE BarrasLostFocus()
2138:         LOCAL loc_nUltimaTecla
2139: 
2140:         *-- Guard do legado: so pesquisa se o codigo MUDOU desde o GotFocus.
2141:         *-- Tambem eh o que impede a pesquisa de rodar de novo quando o
2142:         *-- MsgErro dela rouba o foco e o LostFocus redispara.
2143:         *-- IF ANINHADO, nao AND encadeado: VFP9 nao faz short-circuit, entao
2144:         *-- "VARTYPE(x) = 'N' AND x > 0" avaliaria "x > 0" mesmo com x
2145:         *-- Caractere e estouraria "Operator/operand type mismatch".
2146:         IF VARTYPE(THIS.txt_4c_Barras.Value) = "N"
2147:             IF THIS.txt_4c_Barras.Value > 0 AND ;
2148:                THIS.txt_4c_Barras.Value != THIS.this_nBarrasAnterior
2149:                 THIS.ValidarBarras()
2150:             ENDIF
2151:         ENDIF
2152: 
2153:         *-- Devolucao do foco ao campo: so quando a saida foi por ENTER (13),
2154:         *-- TAB (9) ou digito (48..57), igual ao InList do legado. Sair
2155:         *-- clicando com o mouse NAO rearma o foco - senao o usuario nao
2156:         *-- conseguiria clicar em nenhum botao da tela.
2157:         loc_nUltimaTecla = LASTKEY()
2158: 
2159:         IF loc_nUltimaTecla = 13 OR loc_nUltimaTecla = 9 OR ;
2160:            BETWEEN(loc_nUltimaTecla, 48, 57)
2161:             IF THIS.txt_4c_Barras.Enabled
2162:                 THIS.tmr_4c_FocoBarras.Enabled = .T.
2163:             ENDIF
2164:         ENDIF
2165:     ENDPROC
2166: 
2167:     *==================================================================
2168:     * TimerFocoBarras - legado: tmAux.Timer = "ThisForm.foca() /
2169:     * Keyboard(Chr(3)) / This.Enabled = .F."
2170:     *
2171:     * ORDEM e CONTEUDO transcritos do legado. O Keyboard(Chr(3)) vai junto
2172:     * por fidelidade (PILAR 1): com o foco no campo de barras ele age sobre
2173:     * a selecao do proprio campo, e o KeyPress deste form so reage a 13/9,
2174:     * entao nao dispara pesquisa nenhuma.
2175:     *
2176:     * O "This.Enabled = .F." eh o que faz o timer ser ONE-SHOT: sem ele o
2177:     * foco voltaria ao campo de barras a cada 200ms e a tela ficaria
2178:     * inutilizavel. THIS aqui eh o FORM (o handler eh metodo do form), por
2179:     * isso o alvo eh escrito por extenso.
2180:     *==================================================================
2181:     PROCEDURE TimerFocoBarras()
2182:         THIS.FocarBarras()
2183:         KEYBOARD CHR(3)
2184:         THIS.tmr_4c_FocoBarras.Enabled = .F.
2185:     ENDPROC
2186: 
2187:     *==================================================================
2188:     * FocarBarras - legado: PROCEDURE foca = "ThisForm.getBarras.SetFocus".
2189:     * Metodo proprio (e nao SetFocus embutido no Timer) porque no legado
2190:     * tambem eh metodo do form, chamado pelo Timer.
2191:     *==================================================================
2192:     PROCEDURE FocarBarras()
2193:         IF THIS.txt_4c_Barras.Enabled AND THIS.txt_4c_Barras.Visible
2194:             THIS.txt_4c_Barras.SetFocus()
2195:         ENDIF
2196:     ENDPROC
2197: 
2198:     *==================================================================
2199:     * ValidarBarras - FUNIL da pesquisa por codigo de barras (equivalente
2200:     * a getBarras.Valid + Processamento do legado): resolve a etiqueta (ou
2201:     * o produto, no fallback por SigCdPro), carrega os dados do produto e
2202:     * as 3 grades, e atualiza todos os campos de exibicao da tela.
2203:     *
2204:     * WRAPPER FINO do guard de reentrancia: o corpo fica em
2205:     * ValidarBarrasExec porque ele tem RETURN antecipado, e flag
2206:     * setada/limpa no proprio corpo ficaria TRAVADA ligada nesses caminhos -
2207:     * matando a pesquisa pelo resto da vida do form (regra CLAUDE.md #47).
2208:     *==================================================================
2209:     PROCEDURE ValidarBarras()
2210:         LOCAL loc_lSucesso
2211: 
2212:         IF THIS.this_lEmPesquisa
2213:             RETURN .F.
2214:         ENDIF
2215: 
2216:         THIS.this_lEmPesquisa = .T.
2217:         loc_lSucesso = THIS.ValidarBarrasExec()
2218:         THIS.this_lEmPesquisa = .F.
2219: 
2220:         RETURN loc_lSucesso
2221:     ENDPROC
2222: 
2223:     *==================================================================
2224:     * ValidarBarrasExec - corpo do funil de pesquisa. Chamado SO por
2225:     * ValidarBarras, que garante o guard de reentrancia.
2226:     *==================================================================
2227:     PROCEDURE ValidarBarrasExec()
2228:         LOCAL loc_nCodBarras, loc_lSucesso, loc_lProdutoAchado
2229: 
2230:         loc_lSucesso   = .F.
2231:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2232: 
2233:         IF VARTYPE(loc_nCodBarras) != "N" OR loc_nCodBarras <= 0
2234:             RETURN .F.
2235:         ENDIF
2236: 
2237:         IF !THIS.PodeConsultarBanco()
2238:             RETURN .F.
2239:         ENDIF
2240: 
2241:         TRY
2242:             IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
2243:                 *-- O codigo pode ter sido RENUMERADO (cbars_old -> cbars_new);
2244:                 *-- o campo de busca sempre mostra o codigo ATUAL.
2245:                 THIS.txt_4c_Barras.Value = THIS.this_oBusinessObject.this_nCodBarras
2246:                 THIS.txt_4c_Barra.Value  = THIS.this_oBusinessObject.this_nCodBarraAnterior
2247: 
2248:                 *-- Sincroniza o guard do GotFocus com o codigo RESOLVIDO (que
2249:                 *-- pode diferir do digitado, se a etiqueta foi renumerada):
2250:                 *-- sem isto o LostFocus seguinte veria "valor mudou" e
2251:                 *-- repetiria a pesquisa inteira.
2252:                 THIS.this_nBarrasAnterior = THIS.this_oBusinessObject.this_nCodBarras
2253: 
2254:                 THIS.AtualizarCamposEtiqueta()
2255: 
2256:                 loc_lProdutoAchado = THIS.this_oBusinessObject.CarregarDadosProduto(THIS.this_oBusinessObject.this_cCodProduto)
2257:                 THIS.AtualizarCamposProduto(loc_lProdutoAchado)
2258: 
2259:                 THIS.CarregarDados(THIS.this_oBusinessObject.this_nCodBarras)
2260: 
2261:                 *-- Legado: ao final do Processamento, as duas grades sao
2262:                 *-- reposicionadas e o AfterRowColChange disparado NA MAO
2263:                 *-- (Go Bottom + ThisForm.grdXxx.AfterRowColChange()).
2264:                 THIS.GradeHistoricoAfterRowColChange()
2265:                 THIS.GradeMovimentoAfterRowColChange()
2266: 
2267:                 loc_lSucesso = .T.

*-- Linhas 2274 a 2362:
2274:         CATCH TO loc_oErro
2275:             MsgErro(loc_oErro.Message + CHR(13) + ;
2276:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2277:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.ValidarBarrasExec")
2278:         ENDTRY
2279: 
2280:         RETURN loc_lSucesso
2281:     ENDPROC
2282: 
2283:     *==================================================================
2284:     * AtualizarCamposEtiqueta - Espelha os dados da etiqueta (BO) nos
2285:     * campos do bloco "Posicao Atual do Codigo de Barras" + Local.
2286:     * GetCProSHis/GetDProSHis sao zerados aqui, igual ao legado - so voltam
2287:     * a ser preenchidos se a linha corrente de Movimento tiver um produto
2288:     * DIFERENTE do pesquisado (GradeMovimentoAfterRowColChange).
2289:     *==================================================================
2290:     PROTECTED PROCEDURE AtualizarCamposEtiqueta()
2291:         LOCAL loc_oBO
2292:         loc_oBO = THIS.this_oBusinessObject
2293: 
2294:         THIS.txt_4c_Origem.Value  = loc_oBO.this_cOrigem
2295:         THIS.txt_4c_Empresa.Value = loc_oBO.this_cEmpresaOp
2296:         THIS.txt_4c_Grupo.Value   = loc_oBO.this_cGrupoOp
2297:         THIS.txt_4c_Conta.Value   = loc_oBO.this_cContaOp
2298:         THIS.txt_4c_Qtde.Value    = loc_oBO.this_nQtdeOp
2299:         THIS.txt_4c_Peso.Value    = loc_oBO.this_nPesoOp
2300:         THIS.txt_4c_Local.Value   = loc_oBO.this_cLocalizacao
2301: 
2302:         THIS.txt_4c_CProdutoSemHistorico.Value = ""
2303:         THIS.txt_4c_DProdutoSemHistorico.Value = ""
2304: 
2305:         THIS.txt_4c_Origem.Refresh()
2306:         THIS.txt_4c_Empresa.Refresh()
2307:         THIS.txt_4c_Grupo.Refresh()
2308:         THIS.txt_4c_Conta.Refresh()
2309:         THIS.txt_4c_Qtde.Refresh()
2310:         THIS.txt_4c_Peso.Refresh()
2311:         THIS.txt_4c_Local.Refresh()
2312:     ENDPROC
2313: 
2314:     *==================================================================
2315:     * AtualizarCamposProduto - Espelha os dados do produto (BO, carregados
2316:     * por CarregarDadosProduto) no bloco "Dados do Produto" + ajusta os
2317:     * captions de Qtd(1)/Qtd(2) e do cabecalho da 10a/11a coluna da grade de
2318:     * Historico pela unidade do produto (igual ao Processamento legado).
2319:     * par_lAchou: resultado de CarregarDadosProduto - produto nao encontrado
2320:     * limpa os campos (ramo Else do TmpPro legado).
2321:     *==================================================================
2322:     PROTECTED PROCEDURE AtualizarCamposProduto(par_lAchou)
2323:         LOCAL loc_oBO, loc_cUnidade, loc_cUnidadePeso
2324: 
2325:         loc_oBO = THIS.this_oBusinessObject
2326: 
2327:         IF par_lAchou
2328:             THIS.txt_4c_CProduto.Value    = loc_oBO.this_cCodProduto
2329:             THIS.txt_4c_DProduto.Value    = loc_oBO.this_cDescProduto
2330:             THIS.txt_4c_CFornecedor.Value = loc_oBO.this_cCodFornecedor
2331:             THIS.txt_4c_DFornecedor.Value = loc_oBO.this_cDescFornecedor
2332:             THIS.txt_4c_Referencia.Value  = loc_oBO.this_cReferencia
2333:             THIS.txt_4c_Colecoes.Value    = loc_oBO.this_cColecao
2334:             THIS.txt_4c_PVenda.Value      = loc_oBO.this_nPrecoVenda
2335:             THIS.txt_4c_PrecoDe.Value     = loc_oBO.this_nPrecoDe
2336:             THIS.txt_4c_Cat.Value         = loc_oBO.this_cCategoria
2337: 
2338:             loc_cUnidade     = ALLTRIM(loc_oBO.this_cUnidade)
2339:             loc_cUnidadePeso = ALLTRIM(loc_oBO.this_cUnidadePeso)
2340: 
2341:             THIS.lbl_4c_Qtd1.Caption = IIF(EMPTY(loc_cUnidade), "Qtd", "Qtd(" + loc_cUnidade + ")")
2342:             THIS.lbl_4c_Qtd2.Caption = IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")
2343: 
2344:             THIS.grd_4c_Historico.Column10.Header1.Caption = IIF(EMPTY(loc_cUnidade), "Qtd", "Qtd(" + loc_cUnidade + ")")
2345:             IF !loc_oBO.this_lHabilitaValor
2346:                 THIS.grd_4c_Historico.Column11.Header1.Caption = ;
2347:                     IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")
2348:             ENDIF
2349:         ELSE
2350:             THIS.txt_4c_CProduto.Value    = ""
2351:             THIS.txt_4c_DProduto.Value    = ""
2352:             THIS.txt_4c_CFornecedor.Value = ""
2353:             THIS.txt_4c_DFornecedor.Value = ""
2354:             THIS.txt_4c_Referencia.Value  = ""
2355:             THIS.txt_4c_Colecoes.Value    = ""
2356:             THIS.txt_4c_PVenda.Value      = 0
2357:             THIS.txt_4c_Barra.Value       = 0
2358:         ENDIF
2359: 
2360:         THIS.ExibirImagemProduto(loc_oBO.this_cFigJpgBase64)
2361: 
2362:         THIS.txt_4c_CProduto.Refresh()

*-- Linhas 2376 a 2673:
2376:     * nem produto pelo fallback) - a tela nao deve manter dados da busca
2377:     * anterior depois de um resultado negativo.
2378:     *==================================================================
2379:     PROTECTED PROCEDURE LimparCamposProduto()
2380:         THIS.txt_4c_Origem.Value  = ""
2381:         THIS.txt_4c_Empresa.Value = ""
2382:         THIS.txt_4c_Grupo.Value   = ""
2383:         THIS.txt_4c_Conta.Value   = ""
2384:         THIS.txt_4c_Qtde.Value    = 0
2385:         THIS.txt_4c_Peso.Value    = 0
2386:         THIS.txt_4c_Local.Value   = ""
2387: 
2388:         THIS.txt_4c_CProdutoSemHistorico.Value = ""
2389:         THIS.txt_4c_DProdutoSemHistorico.Value = ""
2390: 
2391:         THIS.txt_4c_CProduto.Value    = ""
2392:         THIS.txt_4c_DProduto.Value    = ""
2393:         THIS.txt_4c_CFornecedor.Value = ""
2394:         THIS.txt_4c_DFornecedor.Value = ""
2395:         THIS.txt_4c_Referencia.Value  = ""
2396:         THIS.txt_4c_Colecoes.Value    = ""
2397:         THIS.txt_4c_PVenda.Value      = 0
2398:         THIS.txt_4c_PrecoDe.Value     = 0
2399:         THIS.txt_4c_Cat.Value         = ""
2400:         THIS.txt_4c_Barra.Value       = 0
2401: 
2402:         THIS.ExibirImagemProduto("")
2403: 
2404:         THIS.Refresh()
2405:     ENDPROC
2406: 
2407:     *==================================================================
2408:     * ExibirImagemProduto - Decodifica o FigJpgs (base64, com os prefixos
2409:     * data:image/... removidos pelo proprio legado) e exibe em img_4c_FigJpg.
2410:     * STRCONV(...,14) roda UMA UNICA VEZ (decode simples, nao duplo - regra
2411:     * CLAUDE.md "STRCONV double decode imagem"). Padrao canonico do projeto
2412:     * (FormSigMvSbn.AtualizarImagemProduto).
2413:     *==================================================================
2414:     PROTECTED PROCEDURE ExibirImagemProduto(par_cFigJpgBase64)
2415:         LOCAL loc_cFoto, loc_cArquivo
2416: 
2417:         THIS.img_4c_FigJpg.Visible = .F.
2418:         THIS.img_4c_FigJpg.Picture = ""
2419: 
2420:         loc_cFoto = TratarNulo(par_cFigJpgBase64, "")
2421:         IF !EMPTY(loc_cFoto)
2422:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
2423:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2424:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
2425:             loc_cFoto = STRCONV(loc_cFoto, 14)
2426: 
2427:             loc_cArquivo = SYS(2023) + "\SIGOPCGB.jpg"
2428:             IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
2429:                 THIS.img_4c_FigJpg.Picture = loc_cArquivo
2430:                 THIS.img_4c_FigJpg.Visible = .T.
2431:             ENDIF
2432:         ENDIF
2433:     ENDPROC
2434: 
2435:     *==================================================================
2436:     * GradeHistoricoAfterRowColChange - legado: recarrega a imagem do
2437:     * PRODUTO PESQUISADO (nao ha lookup por linha aqui - todo o Historico
2438:     * pertence ao mesmo produto) e atualiza a grade de cotacoes (chamada
2439:     * incondicional no legado, independente do checkbox estar marcado).
2440:     *==================================================================
2441:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2442:         THIS.this_nGradeSel = 1
2443: 
2444:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2445:             THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgBase64)
2446:         ENDIF
2447: 
2448:         THIS.AtualizarGradeCotacoes()
2449:     ENDPROC
2450: 
2451:     *==================================================================
2452:     * GradeMovimentoAfterRowColChange - legado: se o produto da linha de
2453:     * Movimento CORRENTE for DIFERENTE do produto pesquisado, busca
2454:     * (SigCdPro) e exibe o codigo/descricao/imagem desse OUTRO produto nos
2455:     * campos "Codigos de Barras Sem Historico" (GetCProSHis/GetDProSHis).
2456:     * Se for o MESMO produto, nao faz nada - os campos ficam como
2457:     * AtualizarCamposEtiqueta os deixou (vazios).
2458:     *==================================================================
2459:     PROCEDURE GradeMovimentoAfterRowColChange(par_nColIndex)
2460:         LOCAL loc_cCodProdutoLinha
2461: 
2462:         THIS.this_nGradeSel = 2
2463: 
2464:         IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
2465:             loc_cCodProdutoLinha = TratarNulo(cursor_4c_Movimento.cpros, "")
2466:         ELSE
2467:             loc_cCodProdutoLinha = ""
2468:         ENDIF
2469: 
2470:         IF !EMPTY(loc_cCodProdutoLinha) AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
2471:                 AND loc_cCodProdutoLinha != THIS.this_oBusinessObject.this_cCodProduto
2472:             THIS.this_oBusinessObject.CarregarProdutoResumido(loc_cCodProdutoLinha)
2473:             THIS.txt_4c_CProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cCodProdutoHist
2474:             THIS.txt_4c_DProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cDescProdutoHist
2475:             THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgProdutoHist)
2476:         ENDIF
2477:     ENDPROC
2478: 
2479:     *==================================================================
2480:     * GradeDevolucaoAfterRowColChange - legado: grddevolucao.AfterRowColChange
2481:     * so marca qual grade esta selecionada - usado por BtnDocumentoClick/
2482:     * BotRastroClick para saber de qual grade ler a linha corrente.
2483:     *==================================================================
2484:     PROCEDURE GradeDevolucaoAfterRowColChange(par_nColIndex)
2485:         THIS.this_nGradeSel = 3
2486:     ENDPROC
2487: 
2488:     *==================================================================
2489:     * GradeHistoricoClick - legado: grdHistorico.Click delega para o handler
2490:     * nativo de AfterRowColChange. Reforca a repintura da imagem/cotacoes ao clicar na MESMA celula ja
2491:     * focada (o AfterRowColChange nativo so dispara ao TROCAR de celula).
2492:     *==================================================================
2493:     PROCEDURE GradeHistoricoClick()
2494:         THIS.GradeHistoricoAfterRowColChange()
2495:     ENDPROC
2496: 
2497:     *==================================================================
2498:     * DesabilitarControlesPrincipais / ReabilitarControlesPrincipais - funil
2499:     * unico da lista de controles que o legado desabilita/reabilita enquanto
2500:     * um form ou painel filho esta aberto (BtnLocalClick/BotaoCorrecaoClick -
2501:     * mesma lista nos dois: GetBarras/CmdBtnForm.BtnSair/GrdMovimento/
2502:     * GrdHistorico/BtnDocumento/BtnImprimir/BtnVisualizar/BtnLocal).
2503:     *==================================================================
2504:     PROTECTED PROCEDURE DesabilitarControlesPrincipais()
2505:         THIS.txt_4c_Barras.Enabled                = .F.
2506:         THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .F.
2507:         THIS.grd_4c_Movimento.Enabled              = .F.
2508:         THIS.grd_4c_Historico.Enabled               = .F.
2509:         THIS.cmd_4c_BtnDocumento.Enabled           = .F.
2510:         THIS.cmd_4c_BtnImprimir.Enabled            = .F.
2511:         THIS.cmd_4c_BtnVisualizar.Enabled          = .F.
2512:         THIS.cmd_4c_BtnLocal.Enabled               = .F.
2513:     ENDPROC
2514: 
2515:     PROTECTED PROCEDURE ReabilitarControlesPrincipais()
2516:         THIS.txt_4c_Barras.Enabled                = .T.
2517:         THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .T.
2518:         THIS.grd_4c_Movimento.Enabled               = .T.
2519:         THIS.grd_4c_Historico.Enabled                = .T.
2520:         THIS.AtualizarEstadoBotoes(THIS.txt_4c_Barras.Value)
2521:     ENDPROC
2522: 
2523:     *==================================================================
2524:     * BtnLocalClick - abre a tela de correcao de localizacao da etiqueta
2525:     * (legado: Do Form SigOpCgl With lnCodBars), desabilitando os demais
2526:     * controles enquanto ela estiver aberta - igual ao legado. SigOpCgl
2527:     * ainda nao foi migrado para a nova arquitetura; o guard evita
2528:     * "Class SIGOPCGL is not found" e avisa o usuario.
2529:     *==================================================================
2530:     PROCEDURE BtnLocalClick()
2531:         LOCAL loc_nCodBarras, loc_oForm
2532: 
2533:         IF !THIS.cmd_4c_BtnLocal.Enabled
2534:             RETURN
2535:         ENDIF
2536: 
2537:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2538: 
2539:         THIS.DesabilitarControlesPrincipais()
2540: 
2541:         loc_oForm = .NULL.
2542:         TRY
2543:             loc_oForm = CREATEOBJECT("FormSigOpCgl", loc_nCodBarras)
2544:         CATCH TO loc_oErro
2545:             loc_oForm = .NULL.
2546:         ENDTRY
2547: 
2548:         IF VARTYPE(loc_oForm) = "O"
2549:             loc_oForm.Show()
2550:         ELSE
2551:             MsgAviso("Tela de corre" + CHR(231) + CHR(227) + "o de localiza" + CHR(231) + CHR(227) + ;
2552:                 "o (SigOpCgl) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
2553:         ENDIF
2554: 
2555:         *-- Ao voltar, a localizacao pode ter sido alterada na tela de
2556:         *-- correcao - reconsulta a etiqueta para refletir o valor atual.
2557:         IF THIS.PodeConsultarBanco() AND VARTYPE(loc_nCodBarras) = "N" AND loc_nCodBarras > 0
2558:             IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
2559:                 THIS.AtualizarCamposEtiqueta()
2560:             ENDIF
2561:         ENDIF
2562: 
2563:         THIS.ReabilitarControlesPrincipais()
2564:     ENDPROC
2565: 
2566:     *==================================================================
2567:     * BtnEncerrarClick - Encerrar (obj_4c_CmdBtnForm.Buttons(1), legado:
2568:     * cmdBtnForm.btnSair.Click = ThisForm.Release).
2569:     *==================================================================
2570:     PROCEDURE BtnEncerrarClick()
2571:         THIS.Release()
2572:     ENDPROC
2573: 
2574:     *==================================================================
2575:     * BtnImprimirClick / BtnVisualizarClick - disparam a mesma rotina do
2576:     * legado (ThisForm.Imagem('I') / ThisForm.Imagem('V')), precedida pelo
2577:     * SetFocus na grade de Historico que o legado tambem faz antes de
2578:     * chamar Imagem.
2579:     *==================================================================
2580:     PROCEDURE BtnImprimirClick()
2581:         IF !THIS.cmd_4c_BtnImprimir.Enabled
2582:             RETURN
2583:         ENDIF
2584:         THIS.grd_4c_Historico.Column1.SetFocus()
2585:         THIS.ImprimirOuVisualizarEtiqueta("I")
2586:     ENDPROC
2587: 
2588:     PROCEDURE BtnVisualizarClick()
2589:         IF !THIS.cmd_4c_BtnVisualizar.Enabled
2590:             RETURN
2591:         ENDIF
2592:         THIS.grd_4c_Historico.Column1.SetFocus()
2593:         THIS.ImprimirOuVisualizarEtiqueta("V")
2594:     ENDPROC
2595: 
2596:     *==================================================================
2597:     * ImprimirOuVisualizarEtiqueta - equivalente ao PROCEDURE imagem do
2598:     * legado: monta o cabecalho da etiqueta (empresa logada, codigo de
2599:     * barras, produto, fornecedor, referencia), garante o .jpg que o FRX
2600:     * carrega e aciona o REPORT FORM SigOpCgb - To Printer Prompt
2601:     * (par_cTipo = "I") ou Preview (par_cTipo = "V").
2602:     *
2603:     * O ALIAS DO CURSOR E CONTRATO DO FRX, NAO NOME ESCOLHIDO AQUI.
2604:     * O SigOpCgb.frx legado le csCabecalho.CodBarras / .CPros / .DPros /
2605:     * .Fornecedor / .Referencia / .empresa - entao o cursor TEM de se
2606:     * chamar csCabecalho, como no legado. Rebatiza-lo para
2607:     * cursor_4c_Etiqueta (PILAR 3) faz o relatorio estourar com
2608:     * "Alias CSCABECALHO is not found": aqui o nome do alias e dado do
2609:     * relatorio, igual a nome de coluna do banco (PILAR 2), e o PILAR 3
2610:     * nao se aplica.
2611:     *
2612:     * A IMAGEM TEM NOME FIXO, TAMBEM POR CONTRATO DO FRX: a expressao do
2613:     * Image do FRX e "Sys(2023) + '\SigOpCgb.Jpg'". Gravar num nome
2614:     * aleatorio (SYS(2015)) escreve um arquivo que o relatorio nunca le e
2615:     * imprime a FOTO DO PRODUTO ANTERIOR, que ficou no nome fixo. Sem
2616:     * foto, o legado grava o fundo BRANCO (BrJpg.JPG) exatamente para
2617:     * nao arrastar a imagem anterior - reproduzido com vbmp\brjpg.jpg.
2618:     *==================================================================
2619:     PROTECTED PROCEDURE ImprimirOuVisualizarEtiqueta(par_cTipo)
2620:         LOCAL loc_oBO, loc_cEmpresa, loc_cArquivoImg, loc_cBranco, loc_cFoto
2621: 
2622:         loc_oBO = THIS.this_oBusinessObject
2623: 
2624:         IF EMPTY(THIS.txt_4c_CProduto.Value)
2625:             MsgAviso("Nenhum produto localizado para a etiqueta pesquisada.", "Aviso")
2626:             RETURN
2627:         ENDIF
2628: 
2629:         *-- Legado: "If !File(lcBrJpg) / MessageBox('Esta Faltando .JPG
2630:         *-- Branco !!!') / Return 0" - sem o fundo branco ele ABORTA.
2631:         loc_cBranco = FULLPATH(gc_4c_CaminhoIcones + "brjpg.jpg")
2632:         IF !FILE(loc_cBranco)
2633:             MsgAviso("Est" + CHR(225) + " faltando o .JPG branco (brjpg.jpg).", "Aviso")
2634:             RETURN
2635:         ENDIF
2636: 
2637:         loc_cEmpresa = TRIM(loc_oBO.this_cCodEmpresa) + ;
2638:             IIF(!EMPTY(loc_oBO.this_cRazaoEmpresa), " - " + TRIM(loc_oBO.this_cRazaoEmpresa), "")
2639: 
2640:         IF USED("csCabecalho")
2641:             USE IN csCabecalho
2642:         ENDIF
2643:         CREATE CURSOR csCabecalho ;
2644:             (empresa C(80), codbarras N(14), cpros C(14), dpros C(40), fornecedor C(10), referencia C(10))
2645:         INSERT INTO csCabecalho (empresa, codbarras, cpros, dpros, fornecedor, referencia) ;
2646:             VALUES (loc_cEmpresa, THIS.txt_4c_Barras.Value, THIS.txt_4c_CProduto.Value, ;
2647:                     THIS.txt_4c_DProduto.Value, THIS.txt_4c_CFornecedor.Value, THIS.txt_4c_Referencia.Value)
2648: 
2649:         *-- Nome FIXO, igual a expressao do Image no FRX.
2650:         loc_cArquivoImg = SYS(2023) + "\SigOpCgb.Jpg"
2651:         loc_cFoto = TratarNulo(loc_oBO.this_cFigJpgBase64, "")
2652:         IF !EMPTY(loc_cFoto)
2653:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
2654:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2655:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
2656:             loc_cFoto = STRCONV(loc_cFoto, 14)
2657:             STRTOFILE(loc_cFoto, loc_cArquivoImg)
2658:         ELSE
2659:             *-- Sem foto: fundo BRANCO, para nao imprimir a do produto anterior.
2660:             COPY FILE (loc_cBranco) TO (loc_cArquivoImg)
2661:         ENDIF
2662: 
2663:         *-- CLEAR RESOURCES: sem isso o VFP reusa o .jpg CACHEADO e a
2664:         *-- etiqueta sai com a imagem anterior (o legado faz o mesmo).
2665:         CLEAR RESOURCES
2666: 
2667:         THIS.ExecutarReportForm(gc_4c_CaminhoReports + "SigOpCgb.frx", ;
2668:             IIF(par_cTipo = "I", "PRINTER_PROMPT", "PREVIEW"), "csCabecalho")
2669: 
2670:         IF USED("csCabecalho")
2671:             USE IN csCabecalho
2672:         ENDIF
2673:     ENDPROC

*-- Linhas 2687 a 3026:
2687:     *
2688:     * par_cModo: "PREVIEW" | "PRINTER" | "PRINTER_PROMPT"
2689:     *==================================================================
2690:     PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
2691:         LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, loc_lProsseguir
2692: 
2693:         loc_cPonto     = SET("POINT")
2694:         loc_cSeparador = SET("SEPARATOR")
2695:         loc_nBehavior  = SET("REPORTBEHAVIOR")
2696:         loc_lResultado = .F.
2697:         loc_lProsseguir = .T.
2698: 
2699:         IF !FILE(FULLPATH(par_cFRXPath))
2700:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
2701:                 CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
2702:             loc_lProsseguir = .F.
2703:         ENDIF
2704: 
2705:         IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
2706:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2707:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
2708:                     CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
2709:                 loc_lProsseguir = .F.
2710:             ENDIF
2711:         ENDIF
2712: 
2713:         IF loc_lProsseguir
2714:             TRY
2715:                 SET POINT TO "."
2716:                 SET SEPARATOR TO ","
2717:                 SET REPORTBEHAVIOR 80
2718: 
2719:                 DO CASE
2720:                 CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
2721:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
2722:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
2723:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
2724:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
2725:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
2726:                 OTHERWISE
2727:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
2728:                 ENDCASE
2729: 
2730:                 loc_lResultado = .T.
2731:             CATCH TO loc_oErro
2732:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2733:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2734:                     "Procedure: " + loc_oErro.Procedure, "ExecutarReportForm")
2735:             ENDTRY
2736: 
2737:             SET POINT TO loc_cPonto
2738:             SET SEPARATOR TO loc_cSeparador
2739:             SET REPORTBEHAVIOR loc_nBehavior
2740: 
2741:             *-- Restaura o menu principal que o _MREPORT do preview corrompe.
2742:             TRY
2743:                 SET SYSMENU TO DEFAULT
2744:                 RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
2745:                     popRelatorios, popFerramentas, popAjuda
2746:                 CriarMenuPrincipal()
2747:             CATCH TO loc_oErroMenu
2748:                 MsgErro(loc_oErroMenu.Message, "ExecutarReportForm")
2749:             ENDTRY
2750:         ENDIF
2751: 
2752:         RETURN loc_lResultado
2753:     ENDPROC
2754: 
2755:     *==================================================================
2756:     * BtnDocumentoClick - abre o documento de movimento da linha CORRENTE
2757:     * da grade ativa (Historico/Movimento/Devolucao - this_nGradeSel),
2758:     * igual ao legado: localiza o documento em SigMvCab (CongBEest);
2759:     * achando, abre FormSigMvExp; nao achando, confere SigCdNec (EmpDnPs) e
2760:     * abre FormSigMvPdt; sem nenhum dos dois, avisa que a operacao nao foi
2761:     * encontrada.
2762:     *==================================================================
2763:     PROCEDURE BtnDocumentoClick()
2764:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEDN, loc_oForm, loc_oBO
2765: 
2766:         IF !THIS.cmd_4c_BtnDocumento.Enabled
2767:             RETURN
2768:         ENDIF
2769: 
2770:         loc_cEmps  = ""
2771:         loc_cDopes = ""
2772:         loc_nNumes = 0
2773:         loc_cEDN   = ""
2774: 
2775:         DO CASE
2776:         CASE THIS.this_nGradeSel = 2 AND USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
2777:             loc_cEmps  = TratarNulo(cursor_4c_Movimento.emps, "")
2778:             loc_cDopes = TratarNulo(cursor_4c_Movimento.dopes, "")
2779:             loc_nNumes = NVL(cursor_4c_Movimento.numes, 0)
2780:             loc_cEDN   = TratarNulo(cursor_4c_Movimento.OriDopNums, "")
2781:         CASE THIS.this_nGradeSel = 3 AND USED("cursor_4c_Devolucao") AND !EOF("cursor_4c_Devolucao")
2782:             loc_cEmps  = TratarNulo(cursor_4c_Devolucao.emps, "")
2783:             loc_cDopes = TratarNulo(cursor_4c_Devolucao.dopes, "")
2784:             loc_nNumes = NVL(cursor_4c_Devolucao.numes, 0)
2785:             loc_cEDN   = TratarNulo(cursor_4c_Devolucao.OriDopNums, "")
2786:         OTHERWISE
2787:             IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
2788:                 loc_cEmps  = TratarNulo(cursor_4c_Historico.emps, "")
2789:                 loc_cDopes = TratarNulo(cursor_4c_Historico.dopes, "")
2790:                 loc_nNumes = NVL(cursor_4c_Historico.numes, 0)
2791:                 loc_cEDN   = TratarNulo(cursor_4c_Historico.OriDopNums, "")
2792:             ENDIF
2793:         ENDCASE
2794: 
2795:         IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR loc_nNumes = 0
2796:             MsgAviso("Selecione uma Etiqueta em uma das listas para visualizar o Documento!", "Aviso")
2797:             RETURN
2798:         ENDIF
2799: 
2800:         IF !THIS.PodeConsultarBanco()
2801:             RETURN
2802:         ENDIF
2803: 
2804:         loc_oBO   = THIS.this_oBusinessObject
2805:         loc_oForm = .NULL.
2806: 
2807:         IF loc_oBO.LocalizarDocumentoPorChave(loc_cEDN)
2808:             TRY
2809:                 loc_oForm = CREATEOBJECT("FormSigMvExp", loc_oBO.this_cDopesDocto, "C", ;
2810:                     loc_oBO.this_nNumesDocto, loc_oBO.this_cEmpsDocto, .T.)
2811:             CATCH TO loc_oErro
2812:                 loc_oForm = .NULL.
2813:             ENDTRY
2814: 
2815:             IF VARTYPE(loc_oForm) = "O"
2816:                 loc_oForm.Show()
2817:             ELSE
2818:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
2819:                     "Movimenta" + CHR(231) + CHR(227) + "o (SigMvExp).", "Aviso")
2820:             ENDIF
2821:         ELSE
2822:             IF loc_oBO.ExisteNecessidadePorChave(loc_cEmps, loc_cDopes, loc_nNumes)
2823:                 TRY
2824:                     loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
2825:                 CATCH TO loc_oErro
2826:                     loc_oForm = .NULL.
2827:                 ENDTRY
2828: 
2829:                 IF VARTYPE(loc_oForm) = "O"
2830:                     loc_oForm.Show()
2831:                 ELSE
2832:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
2833:                         "Pedido (SigMvPdt).", "Aviso")
2834:                 ENDIF
2835:             ELSE
2836:                 MsgErro("A opera" + CHR(231) + CHR(227) + "o selecionada n" + CHR(227) + ;
2837:                     "o pode ser encontrada!" + CHR(13) + ;
2838:                     "Posicione em uma opera" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
2839:                     "lida na lista!", "Documento")
2840:             ENDIF
2841:         ENDIF
2842:     ENDPROC
2843: 
2844:     *==================================================================
2845:     * BotRastroClick - abre a tela de rastreabilidade (legado: Do Form
2846:     * SigReCgr With 1, ThisForm.GetBarras.Value, ThisForm). SigReCgr ainda
2847:     * nao foi migrada - mesmo guard do BtnLocalClick (CREATEOBJECT dentro
2848:     * do TRY, Show() FORA - regra CLAUDE.md #29).
2849:     *==================================================================
2850:     PROCEDURE BotRastroClick()
2851:         LOCAL loc_nCodBarras, loc_oForm
2852: 
2853:         IF !THIS.cmd_4c_BotRastro.Enabled
2854:             RETURN
2855:         ENDIF
2856: 
2857:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2858:         loc_oForm = .NULL.
2859: 
2860:         TRY
2861:             loc_oForm = CREATEOBJECT("FormSigReCgr", 1, loc_nCodBarras, THIS)
2862:         CATCH TO loc_oErro
2863:             loc_oForm = .NULL.
2864:         ENDTRY
2865: 
2866:         IF VARTYPE(loc_oForm) = "O"
2867:             loc_oForm.Show()
2868:         ELSE
2869:             MsgAviso("Tela de rastreabilidade (SigReCgr) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
2870:         ENDIF
2871: 
2872:         *-- Legado: devolve o foco para a grade ativa (Movimento ou Historico)
2873:         IF THIS.this_nGradeSel = 2
2874:             THIS.grd_4c_Movimento.Column1.SetFocus()
2875:         ELSE
2876:             THIS.grd_4c_Historico.Column1.SetFocus()
2877:         ENDIF
2878:     ENDPROC
2879: 
2880:     *==================================================================
2881:     * BotaoCorrecaoClick - abre o painel de correcao de etiquetas (legado:
2882:     * Botao_de_Correcao.Click), desabilitando os demais controles (mesma
2883:     * lista do BtnLocalClick) e carregando o historico de correcoes da
2884:     * etiqueta (SigEtHst) na grade grd_4c_Correcao.
2885:     *==================================================================
2886:     PROCEDURE BotaoCorrecaoClick()
2887:         LOCAL loc_nCodBarras
2888: 
2889:         IF !THIS.cmd_4c_BotaoCorrecao.Enabled
2890:             RETURN
2891:         ENDIF
2892: 
2893:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2894: 
2895:         THIS.DesabilitarControlesPrincipais()
2896: 
2897:         IF THIS.PodeConsultarBanco()
2898:             THIS.this_oBusinessObject.CarregarCorrecaoPorCodBarras(loc_nCodBarras)
2899:         ENDIF
2900: 
2901:         WITH THIS.cnt_4c_Correcao
2902:             .Top     = (THIS.Height / 2) - (.Height / 2)
2903:             .Visible = .T.
2904:             .Refresh()
2905:             .grd_4c_Correcao.Refresh()
2906:             .grd_4c_Correcao.Column1.SetFocus()
2907:         ENDWITH
2908:     ENDPROC
2909: 
2910:     *==================================================================
2911:     * PainelCorrecaoEncerrarClick - fecha o painel de correcao (legado:
2912:     * Cnt_Correcao.cmdBtnForm.btnSair.Click) e reabilita os demais
2913:     * controles - NAO fecha o form (eh so o painel flutuante).
2914:     *==================================================================
2915:     PROCEDURE PainelCorrecaoEncerrarClick()
2916:         THIS.ReabilitarControlesPrincipais()
2917:         THIS.cnt_4c_Correcao.Visible = .F.
2918:     ENDPROC
2919: 
2920:     *==================================================================
2921:     * BotCotacoesClick - chk_4c_BotCotacoes: liga/desliga o painel de
2922:     * cotacoes (legado: This.Parent.grdCot.Visible = This.Value), atualizando
2923:     * a grade so quando o checkbox eh marcado.
2924:     *==================================================================
2925:     PROCEDURE BotCotacoesClick()
2926:         LOCAL loc_lMostrar
2927: 
2928:         loc_lMostrar = (THIS.chk_4c_BotCotacoes.Value = 1)
2929: 
2930:         IF loc_lMostrar
2931:             THIS.AtualizarGradeCotacoes()
2932:         ENDIF
2933: 
2934:         THIS.cnt_4c_GrdCot.Visible = loc_lMostrar
2935:         THIS.cnt_4c_GrdCot.Refresh()
2936:     ENDPROC
2937: 
2938:     *==================================================================
2939:     * AtualizarGradeCotacoes - recarrega cursor_4c_Cotacoes com a cotacao de
2940:     * cada moeda na data do registro CORRENTE da grade de Historico (legado:
2941:     * fBuscarCotacao(TmpCot.cmoes, csHistorico.Datas, ...)).
2942:     *==================================================================
2943:     PROTECTED PROCEDURE AtualizarGradeCotacoes()
2944:         LOCAL loc_dData
2945: 
2946:         loc_dData = {}
2947:         IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
2948:             loc_dData = ConverterParaData(cursor_4c_Historico.datas)
2949:         ENDIF
2950: 
2951:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.PodeConsultarBanco()
2952:             THIS.this_oBusinessObject.CarregarCotacoesPorData(loc_dData)
2953:             THIS.cnt_4c_GrdCot.lbl_4c_TituloCotacoes.Caption = "Cota" + CHR(231) + CHR(245) + "es na Data"
2954:             THIS.cnt_4c_GrdCot.grd_4c_Cotacoes.Refresh()
2955:         ENDIF
2956:     ENDPROC
2957: 
2958:     *==================================================================
2959:     * FecharCursoresGrades - Fecha os cursores das grades. Chamado pelo
2960:     * Destroy: as grades morrem com o form, mas os aliases sao globais a
2961:     * data session e ficariam abertos.
2962:     *==================================================================
2963:     PROTECTED PROCEDURE FecharCursoresGrades()
2964:         IF USED("cursor_4c_Historico")
2965:             USE IN cursor_4c_Historico
2966:         ENDIF
2967:         IF USED("cursor_4c_Movimento")
2968:             USE IN cursor_4c_Movimento
2969:         ENDIF
2970:         IF USED("cursor_4c_Devolucao")
2971:             USE IN cursor_4c_Devolucao
2972:         ENDIF
2973:         IF USED("cursor_4c_Cotacoes")
2974:             USE IN cursor_4c_Cotacoes
2975:         ENDIF
2976:         IF USED("cursor_4c_Correcao")
2977:             USE IN cursor_4c_Correcao
2978:         ENDIF
2979: 
2980:         RETURN .T.
2981:     ENDPROC
2982: 
2983:     *==================================================================
2984:     * PodeConsultarBanco - .T. quando ha conexao real E o form nao esta
2985:     * sendo instanciado por validacao de UI / teste automatizado (onde
2986:     * nao existe banco para consultar).
2987:     *==================================================================
2988:     FUNCTION PodeConsultarBanco()
2989:         LOCAL loc_lPode
2990: 
2991:         loc_lPode = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2992: 
2993:         IF loc_lPode AND TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2994:             loc_lPode = .F.
2995:         ENDIF
2996: 
2997:         IF loc_lPode AND TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
2998:             loc_lPode = .F.
2999:         ENDIF
3000: 
3001:         RETURN loc_lPode
3002:     ENDFUNC
3003: 
3004:     *==================================================================
3005:     * Destroy - Fecha os cursores das grades, libera o Business Object e
3006:     * chama DODEFAULT (FormBase.Destroy, que reconstroi o menu principal)
3007:     *==================================================================
3008:     PROCEDURE Destroy()
3009:         *-- Desarma o timer de foco ANTES de derrubar o resto: timer armado
3010:         *-- disparando durante o teardown chamaria SetFocus num controle que
3011:         *-- ja esta sendo destruido.
3012:         IF PEMSTATUS(THIS, "tmr_4c_FocoBarras", 5)
3013:             THIS.tmr_4c_FocoBarras.Enabled = .F.
3014:         ENDIF
3015: 
3016:         THIS.FecharCursoresGrades()
3017: 
3018:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3019:             THIS.this_oBusinessObject.LiberarCursoresConsulta()
3020:             THIS.this_oBusinessObject = .NULL.
3021:         ENDIF
3022: 
3023:         DODEFAULT()
3024:     ENDPROC
3025: 
3026: ENDDEFINE

