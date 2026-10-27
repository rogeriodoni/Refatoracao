# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [METODO-INEXISTENTE] Metodo 'THIS.PodeConsultarBanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AfterRowColChange()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Historico' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Movimento' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Qtd()' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, O, Emp, Movimentação, Código, Valor, Qtde, Pesos, Grupo, Conta, Cor, Tam, Qtd, Produto, Peso, Usuário, Moe, Cotacao. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3021 linhas total):

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
1662:         CREATE CURSOR cursor_4c_Historico ;
1663:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1664:              datas D, grupos C(10), estos C(10), opers C(1), codcors C(4), ;
1665:              codtams C(4), valor N(12,2), Qtds N(9,3), Pesos N(9,3), OriDopNums C(29))
1666: 
1667:         INDEX ON emps + dopes + STR(numes, 6) TAG EmpDopNum
1668:         INDEX ON OriDopNums TAG OriDopNums
1669:         INDEX ON DTOS(datas) TAG DtOpers
1670: 
1671:         *-- Grade de Movimento (CsMovimento no legado)
1672:         IF USED("cursor_4c_Movimento")
1673:             USE IN cursor_4c_Movimento
1674:         ENDIF
1675: 
1676:         CREATE CURSOR cursor_4c_Movimento ;
1677:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1678:              datas D, opers C(1), valor N(12,2), Qtds N(12,3), Pesos N(12,3), ;
1679:              OriDopNums C(29))
1680: 
1681:         INDEX ON DTOS(datas) TAG DtOpers
1682: 
1683:         *-- Grade de Devolucao (crSigOpexi no legado).
1684:         *-- SET NULL ON eh obrigatorio: SigOpExi.datas aceita NULL no banco e o
1685:         *-- APPEND FROM do BO falharia num campo declarado NOT NULL.
1686:         *-- Desvio documentado: datas aqui eh DATE e no legado era o datetime
1687:         *-- cru do SQL Server. A coluna da grade tem 70px (nao cabe a hora) e as
1688:         *-- duas grades irmas usam DATE no mesmo campo "Data".
1689:         IF USED("cursor_4c_Devolucao")
1690:             USE IN cursor_4c_Devolucao
1691:         ENDIF
1692: 
1693:         SET NULL ON
1694:         CREATE CURSOR cursor_4c_Devolucao ;
1695:             (datas D NULL, opers C(1) NULL, emps C(3) NULL, dopes C(20) NULL, ;
1696:              numes N(10) NULL, OriDopNums C(29) NULL, valors N(11,2) NULL)

*-- Linhas 1736 a 1808:
1736:     * legado: com Habvalor mostra "valor" (caption "Valor"); sem Habvalor
1737:     * mostra "Pesos" e mantem o caption desenhado no SCX.
1738:     *==================================================================
1739:     PROTECTED PROCEDURE VincularGrades()
1740:         LOCAL loc_oGrd, loc_lHabValor
1741: 
1742:         loc_lHabValor = .F.
1743:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1744:             loc_lHabValor = THIS.this_oBusinessObject.this_lHabilitaValor
1745:         ENDIF
1746: 
1747:         *-- Grade de Historico
1748:         loc_oGrd = THIS.grd_4c_Historico
1749:         loc_oGrd.ColumnCount = 11
1750:         loc_oGrd.RecordSource = "cursor_4c_Historico"
1751: 
1752:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Historico.datas"
1753:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.opers"
1754:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Historico.emps"
1755:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Historico.dopes"
1756:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Historico.numes"
1757:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Historico.grupos"
1758:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Historico.estos"
1759:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Historico.codcors"
1760:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Historico.codtams"
1761:         loc_oGrd.Column10.ControlSource = "cursor_4c_Historico.Qtds"
1762: 
1763:         IF loc_lHabValor
1764:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.valor"
1765:         ELSE
1766:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.Pesos"
1767:         ENDIF
1768: 
1769:         THIS.ConfigurarColunaGrade(loc_oGrd, 1,  69,  "Data")
1770:         THIS.ConfigurarColunaGrade(loc_oGrd, 2,  15,  "O")
1771:         THIS.ConfigurarColunaGrade(loc_oGrd, 3,  28,  "Emp")
1772:         THIS.ConfigurarColunaGrade(loc_oGrd, 4,  203, "Movimenta" + CHR(231) + CHR(227) + "o")
1773:         THIS.ConfigurarColunaGrade(loc_oGrd, 5,  50,  "C" + CHR(243) + "digo")
1774:         THIS.ConfigurarColunaGrade(loc_oGrd, 6,  75,  "Grupo")
1775:         THIS.ConfigurarColunaGrade(loc_oGrd, 7,  75,  "Conta")
1776:         THIS.ConfigurarColunaGrade(loc_oGrd, 8,  32,  "Cor")
1777:         THIS.ConfigurarColunaGrade(loc_oGrd, 9,  32,  "Tam")
1778:         THIS.ConfigurarColunaGrade(loc_oGrd, 10, 70,  "Qtd")
1779:         THIS.ConfigurarColunaGrade(loc_oGrd, 11, 70,  IIF(loc_lHabValor, "Valor", "Qtd"))
1780: 
1781:         *-- Grade de Movimento
1782:         loc_oGrd = THIS.grd_4c_Movimento
1783:         loc_oGrd.ColumnCount = 8
1784:         loc_oGrd.RecordSource = "cursor_4c_Movimento"
1785: 
1786:         loc_oGrd.Column1.ControlSource = "cursor_4c_Movimento.datas"
1787:         loc_oGrd.Column2.ControlSource = "cursor_4c_Movimento.opers"
1788:         loc_oGrd.Column3.ControlSource = "cursor_4c_Movimento.emps"
1789:         loc_oGrd.Column4.ControlSource = "cursor_4c_Movimento.dopes"
1790:         loc_oGrd.Column5.ControlSource = "cursor_4c_Movimento.numes"
1791:         loc_oGrd.Column6.ControlSource = "cursor_4c_Movimento.valor"
1792:         loc_oGrd.Column7.ControlSource = "cursor_4c_Movimento.Qtds"
1793:         loc_oGrd.Column8.ControlSource = "cursor_4c_Movimento.Pesos"
1794: 
1795:         THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70,  "Data")
1796:         THIS.ConfigurarColunaGrade(loc_oGrd, 2, 15,  "O")
1797:         THIS.ConfigurarColunaGrade(loc_oGrd, 3, 28,  "Emp")
1798:         THIS.ConfigurarColunaGrade(loc_oGrd, 4, 145, "Movimenta" + CHR(231) + CHR(227) + "o")
1799:         THIS.ConfigurarColunaGrade(loc_oGrd, 5, 50,  "C" + CHR(243) + "digo")
1800:         THIS.ConfigurarColunaGrade(loc_oGrd, 6, 80,  "Valor")
1801:         THIS.ConfigurarColunaGrade(loc_oGrd, 7, 70,  "Qtde")
1802:         THIS.ConfigurarColunaGrade(loc_oGrd, 8, 70,  "Pesos")
1803: 
1804:         *-- Grade de Devolucao
1805:         loc_oGrd = THIS.grd_4c_Devolucao
1806:         loc_oGrd.ColumnCount = 6
1807:         loc_oGrd.RecordSource = "cursor_4c_Devolucao"
1808: 

*-- Linhas 1856 a 2262:
1856: 
1857:     *==================================================================
1858:     * CarregarDados - Monta as 3 grades para um codigo de barras.
1859:     * Equivalente a parte do PROCEDURE Processamento do legado que diz
1860:     * respeito as grades; os campos do produto/etiqueta sao preenchidos
1861:     * pelos metodos da pagina de dados.
1862:     *
1863:     * par_nCodBarras: codigo de barras a pesquisar. Zero/invalido apenas
1864:     * limpa as grades (nenhuma consulta eh disparada).
1865:     *==================================================================
1866:     PROCEDURE CarregarDados(par_nCodBarras)
1867:         LOCAL loc_nCodBarras, loc_lSucesso
1868: 
1869:         loc_lSucesso  = .F.
1870:         loc_nCodBarras = IIF(VARTYPE(par_nCodBarras) = "N", par_nCodBarras, 0)
1871: 
1872:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1873:             RETURN .F.
1874:         ENDIF
1875: 
1876:         IF loc_nCodBarras <= 0
1877:             THIS.LimparGrades()
1878:             RETURN .F.
1879:         ENDIF
1880: 
1881:         TRY
1882:             IF THIS.this_oBusinessObject.CarregarGradesPorCodBarras(loc_nCodBarras)
1883:                 IF THIS.this_oBusinessObject.CarregarDevolucaoPorCodBarras(loc_nCodBarras)
1884:                     loc_lSucesso = .T.
1885:                 ENDIF
1886:             ENDIF
1887: 
1888:             THIS.this_oBusinessObject.LiberarCursoresConsulta()
1889: 
1890:             *-- Ordem de exibicao do legado: Set Order To DtOpers nas duas grades
1891:             THIS.RepintarGrades()
1892:             THIS.AtualizarEstadoBotoes(loc_nCodBarras)
1893:         CATCH TO loc_oErro
1894:             MsgErro(loc_oErro.Message + CHR(13) + ;
1895:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1896:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.CarregarDados")
1897:         ENDTRY
1898: 
1899:         RETURN loc_lSucesso
1900:     ENDPROC
1901: 
1902:     *==================================================================
1903:     * LimparGrades - Esvazia os 3 cursores e repinta. Usado quando o
1904:     * codigo de barras eh apagado/invalido: as grades tem de ficar vazias
1905:     * em vez de manter o resultado da pesquisa anterior.
1906:     *==================================================================
1907:     PROCEDURE LimparGrades()
1908:         IF USED("cursor_4c_Historico")
1909:             ZAP IN cursor_4c_Historico
1910:         ENDIF
1911:         IF USED("cursor_4c_Movimento")
1912:             ZAP IN cursor_4c_Movimento
1913:         ENDIF
1914:         IF USED("cursor_4c_Devolucao")
1915:             ZAP IN cursor_4c_Devolucao
1916:         ENDIF
1917: 
1918:         THIS.RepintarGrades()
1919:         THIS.AtualizarEstadoBotoes(0)
1920: 
1921:         RETURN .T.
1922:     ENDPROC
1923: 
1924:     *==================================================================
1925:     * RepintarGrades - FUNIL unico de repintura. Popular o cursor NAO faz a
1926:     * grade redesenhar: sem reposicionar o ponteiro + Refresh a grade aparece
1927:     * vazia com o cursor cheio.
1928:     *
1929:     * O legado fecha o Processamento assim, e eh isso que se reproduz:
1930:     *   Select CsMovimento / Set Order To DtOpers / AfterRowColChange / Go Bottom
1931:     *   Select CsHistorico / Set Order To DtOpers / AfterRowColChange / Go Bottom
1932:     * ou seja GO BOTTOM (ultimo movimento, o mais recente), NAO Go Top. A grade
1933:     * de devolucao nao eh reordenada nem reposicionada pelo legado.
1934:     *
1935:     * Chamado em TODO caminho que popula ou esvazia os cursores.
1936:     *==================================================================
1937:     PROCEDURE RepintarGrades()
1938:         IF USED("cursor_4c_Historico")
1939:             SELECT cursor_4c_Historico
1940:             SET ORDER TO TAG DtOpers
1941:             GO BOTTOM
1942:             THIS.grd_4c_Historico.Refresh()
1943:         ENDIF
1944: 
1945:         IF USED("cursor_4c_Movimento")
1946:             SELECT cursor_4c_Movimento
1947:             SET ORDER TO TAG DtOpers
1948:             GO BOTTOM
1949:             THIS.grd_4c_Movimento.Refresh()
1950:         ENDIF
1951: 
1952:         IF USED("cursor_4c_Devolucao")
1953:             SELECT cursor_4c_Devolucao
1954:             GO TOP
1955:             THIS.grd_4c_Devolucao.Refresh()
1956:         ENDIF
1957: 
1958:         *-- O legado deixa CsHistorico selecionado quando CsMovimento esta vazio
1959:         *-- (If RecCount('CsMovimento') < 1 / Select CsHistorico).
1960:         IF USED("cursor_4c_Movimento") AND RECCOUNT("cursor_4c_Movimento") < 1
1961:             IF USED("cursor_4c_Historico")
1962:                 SELECT cursor_4c_Historico
1963:             ENDIF
1964:         ENDIF
1965: 
1966:         RETURN .T.
1967:     ENDPROC
1968: 
1969:     *==================================================================
1970:     * AplicarAcessoBotoes - Visibilidade dos botoes por permissao, como no
1971:     * Init legado:
1972:     *   .BtnDocumento.Visible      = fChecaAcesso('SIGOPCGB','BTNDOC')
1973:     *   .BtnImprimir.Visible       = fChecaAcesso('SIGOPCGB','IMPRIMIR')
1974:     *   .BtnVisualizar.Visible     = fChecaAcesso('SIGOPCGB','VISUALIZAR')
1975:     *   .Bot_Rastro.Visible        = fChecaAcesso('SIGOPCGB','RASTRO') And !Eof('TmpOpe')
1976:     *   .Botao_de_Correcao.Visible = fChecaAcesso('SIGOPCGB','CORRECAO')
1977:     * O !Eof('TmpOpe') eh o this_lControlaLotes do BO (existe SigCdOpe com
1978:     * ctrllotes 1 ou 2).
1979:     *==================================================================
1980:     PROTECTED PROCEDURE AplicarAcessoBotoes()
1981:         LOCAL loc_oBO, loc_lLotes
1982: 
1983:         loc_oBO    = THIS.this_oBusinessObject
1984:         loc_lLotes = .F.
1985: 
1986:         IF VARTYPE(loc_oBO) = "O"
1987:             loc_oBO.this_lAcessoDocumento  = fChecaAcesso("SIGOPCGB", "BTNDOC")
1988:             loc_oBO.this_lAcessoImprimir   = fChecaAcesso("SIGOPCGB", "IMPRIMIR")
1989:             loc_oBO.this_lAcessoVisualizar = fChecaAcesso("SIGOPCGB", "VISUALIZAR")
1990:             loc_oBO.this_lAcessoRastro     = fChecaAcesso("SIGOPCGB", "RASTRO")
1991:             loc_oBO.this_lAcessoCorrecao   = fChecaAcesso("SIGOPCGB", "CORRECAO")
1992:             loc_oBO.this_lAcessoFornecedor = fChecaAcesso("SIGOPCGB", "FORNECEDOR")
1993:             loc_oBO.this_lAcessoFollowUp   = fChecaAcesso("SIGOPCGB", "FOLLOWUP")
1994: 
1995:             loc_lLotes = loc_oBO.this_lControlaLotes
1996: 
1997:             THIS.cmd_4c_BtnDocumento.Visible  = loc_oBO.this_lAcessoDocumento
1998:             THIS.cmd_4c_BtnImprimir.Visible   = loc_oBO.this_lAcessoImprimir
1999:             THIS.cmd_4c_BtnVisualizar.Visible = loc_oBO.this_lAcessoVisualizar
2000:             THIS.cmd_4c_BotRastro.Visible     = (loc_oBO.this_lAcessoRastro AND loc_lLotes)
2001:             THIS.cmd_4c_BotaoCorrecao.Visible = loc_oBO.this_lAcessoCorrecao
2002:         ENDIF
2003: 
2004:         RETURN .T.
2005:     ENDPROC
2006: 
2007:     *==================================================================
2008:     * AtualizarEstadoBotoes - Reproduz o When dos botoes de acao do legado
2009:     * (Return(!Empty(ThisForm.GetBarras.Value))): sem codigo de barras
2010:     * pesquisado, nenhuma das acoes faz sentido e os botoes ficam
2011:     * desabilitados. O Encerrar NUNCA eh desabilitado - eh a saida da tela.
2012:     *
2013:     * Chamado pelo FUNIL de carga (CarregarDados/LimparGrades), nao por cada
2014:     * botao: quem desabilita tem de reabilitar no caminho de volta.
2015:     *==================================================================
2016:     PROCEDURE AtualizarEstadoBotoes(par_nCodBarras)
2017:         LOCAL loc_lAtivo
2018: 
2019:         loc_lAtivo = (VARTYPE(par_nCodBarras) = "N" AND par_nCodBarras > 0)
2020: 
2021:         THIS.cmd_4c_BtnImprimir.Enabled   = loc_lAtivo
2022:         THIS.cmd_4c_BtnVisualizar.Enabled = loc_lAtivo
2023:         THIS.cmd_4c_BtnDocumento.Enabled  = loc_lAtivo
2024:         THIS.cmd_4c_BotRastro.Enabled     = loc_lAtivo
2025:         THIS.cmd_4c_BotaoCorrecao.Enabled = loc_lAtivo
2026:         THIS.cmd_4c_BtnLocal.Enabled      = loc_lAtivo
2027: 
2028:         *-- As 3 grades tambem tem o MESMO When no legado
2029:         *-- (grdHistorico/grdMovimento/grddevolucao: "Return(!Empty(
2030:         *-- ThisForm.GetBarras.Value))"): sem codigo pesquisado elas estao
2031:         *-- vazias e nao devem aceitar foco/navegacao.
2032:         THIS.grd_4c_Historico.Enabled = loc_lAtivo
2033:         THIS.grd_4c_Movimento.Enabled = loc_lAtivo
2034:         THIS.grd_4c_Devolucao.Enabled = loc_lAtivo
2035: 
2036:         RETURN .T.
2037:     ENDPROC
2038: 
2039:     *==================================================================
2040:     * ConfigurarBindings - BINDEVENT dos campos/botoes interativos desta
2041:     * fase (Fase 6/8 - campos restantes e "lookups"). O unico lookup real
2042:     * deste form OPERACIONAL eh a pesquisa por codigo de barras (nao ha
2043:     * FormBuscaAuxiliar aqui: txt_4c_Barras EH a busca).
2044:     *==================================================================
2045:     PROTECTED PROCEDURE ConfigurarBindings()
2046:         BINDEVENT(THIS.txt_4c_Barras, "KeyPress", THIS, "BarrasKeyPress")
2047: 
2048:         *-- Fase 8/8 - os tres eventos auxiliares do getBarras legado que
2049:         *-- faltavam, e sem os quais o campo de barras nao se comporta como
2050:         *-- no legado:
2051:         *--   GotFocus  = "This.peantvalue = This.Value" (guard de valor nao
2052:         *--               mudado, consumido pelo Valid)
2053:         *--   LostFocus = arma o tmAux (devolucao do foco) - aqui tambem
2054:         *--               dispara a pesquisa, que no legado eh o Valid: os
2055:         *--               dois rodam ao SAIR do campo, e BINDEVENT em "Valid"
2056:         *--               nao dispara de forma confiavel em TextBox (regra
2057:         *--               CLAUDE.md #3/#35), entao o Valid vive no LostFocus.
2058:         *--   Timer     = devolve o foco ao campo e se desarma
2059:         BINDEVENT(THIS.txt_4c_Barras, "GotFocus", THIS, "BarrasGotFocus")
2060:         BINDEVENT(THIS.txt_4c_Barras, "LostFocus", THIS, "BarrasLostFocus")
2061:         BINDEVENT(THIS.tmr_4c_FocoBarras, "Timer", THIS, "TimerFocoBarras")
2062: 
2063:         BINDEVENT(THIS.cmd_4c_BtnLocal, "Click", THIS, "BtnLocalClick")
2064:         BINDEVENT(THIS.chk_4c_BotCotacoes, "Click", THIS, "BotCotacoesClick")
2065: 
2066:         *-- AfterRowColChange para mostrar o produto/imagem da LINHA
2067:         *-- corrente (uso legitimo de AfterRowColChange - regra #46/CLAUDE.md,
2068:         *-- "carregar detalhe da linha corrente" - diferente de validar
2069:         *-- celula editavel, que este form nao tem: as 3 grades sao ReadOnly).
2070:         BINDEVENT(THIS.grd_4c_Historico, "AfterRowColChange", THIS, "GradeHistoricoAfterRowColChange")
2071:         BINDEVENT(THIS.grd_4c_Movimento, "AfterRowColChange", THIS, "GradeMovimentoAfterRowColChange")
2072: 
2073:         *-- Legado: grdHistorico.Click = This.AfterRowColChange() (reforca a
2074:         *-- repintura ao clicar na MESMA celula ja focada) e
2075:         *-- grddevolucao.AfterRowColChange so marca a grade selecionada
2076:         *-- (this_nGradeSel), usado por BtnDocumentoClick/BotRastroClick.
2077:         BINDEVENT(THIS.grd_4c_Historico, "Click", THIS, "GradeHistoricoClick")
2078:         BINDEVENT(THIS.grd_4c_Devolucao, "AfterRowColChange", THIS, "GradeDevolucaoAfterRowColChange")
2079: 
2080:         *-- Botoes de acao (Fase 7/8 - eventos principais).
2081:         BINDEVENT(THIS.obj_4c_CmdBtnForm.Buttons(1), "Click", THIS, "BtnEncerrarClick")
2082:         BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
2083:         BINDEVENT(THIS.cmd_4c_BtnVisualizar, "Click", THIS, "BtnVisualizarClick")
2084:         BINDEVENT(THIS.cmd_4c_BtnDocumento, "Click", THIS, "BtnDocumentoClick")
2085:         BINDEVENT(THIS.cmd_4c_BotRastro, "Click", THIS, "BotRastroClick")
2086:         BINDEVENT(THIS.cmd_4c_BotaoCorrecao, "Click", THIS, "BotaoCorrecaoClick")
2087:         BINDEVENT(THIS.cnt_4c_Correcao.obj_4c_CmdCorrecao.Buttons(1), "Click", THIS, "PainelCorrecaoEncerrarClick")
2088:     ENDPROC
2089: 
2090:     *==================================================================
2091:     * BarrasKeyPress - txt_4c_Barras (equivalente ao getBarras do legado).
2092:     * ENTER/TAB pesquisa sem esperar a saida do campo, que eh o uso real do
2093:     * leitor de codigo de barras (o scanner emite o codigo e um ENTER).
2094:     * A pesquisa ao SAIR do campo por qualquer outro meio (clicar num botao,
2095:     * por exemplo) fica no BarrasLostFocus, que eh onde mora o Valid legado.
2096:     *==================================================================
2097:     PROCEDURE BarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2098:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
2099:             THIS.ValidarBarras()
2100:         ENDIF
2101:     ENDPROC
2102: 
2103:     *==================================================================
2104:     * BarrasGotFocus - legado: getBarras.GotFocus = "This.peantvalue =
2105:     * This.Value". Guarda o valor na ENTRADA do campo; o funil de pesquisa
2106:     * compara com ele para nao repetir a consulta quando o usuario entra e
2107:     * sai do campo sem mudar o codigo.
2108:     *==================================================================
2109:     PROCEDURE BarrasGotFocus()
2110:         THIS.this_nBarrasAnterior = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "N", ;
2111:             THIS.txt_4c_Barras.Value, 0)
2112:     ENDPROC
2113: 
2114:     *==================================================================
2115:     * BarrasLostFocus - reune os DOIS eventos que o legado dispara ao sair
2116:     * do campo de barras:
2117:     *
2118:     *   getBarras.Valid     - pesquisa o codigo (guard "peantvalue # Value").
2119:     *                         Vive aqui porque BINDEVENT em "Valid" nao
2120:     *                         dispara de forma confiavel em TextBox
2121:     *                         (regra CLAUDE.md #3/#35).
2122:     *   getBarras.LostFocus - "If InList(LastKey(), 13, 48..57, 9) /
2123:     *                         ThisForm.Tpbusca = 1 / tmAux.Enabled = .T."
2124:     *                         isto eh: saiu por ENTER, TAB ou digitando um
2125:     *                         digito -> arma o timer que devolve o foco ao
2126:     *                         campo, para a leitura seguinte.
2127:     *
2128:     * Tpbusca NAO eh migrada de proposito: no legado ela eh escrita em tres
2129:     * lugares (Init, LostFocus e o proprio Init com pBar) e NUNCA lida -
2130:     * estado morto. Migra-la seria criar propriedade que ninguem consulta.
2131:     *==================================================================
2132:     PROCEDURE BarrasLostFocus()
2133:         LOCAL loc_nUltimaTecla
2134: 
2135:         *-- Guard do legado: so pesquisa se o codigo MUDOU desde o GotFocus.
2136:         *-- Tambem eh o que impede a pesquisa de rodar de novo quando o
2137:         *-- MsgErro dela rouba o foco e o LostFocus redispara.
2138:         *-- IF ANINHADO, nao AND encadeado: VFP9 nao faz short-circuit, entao
2139:         *-- "VARTYPE(x) = 'N' AND x > 0" avaliaria "x > 0" mesmo com x
2140:         *-- Caractere e estouraria "Operator/operand type mismatch".
2141:         IF VARTYPE(THIS.txt_4c_Barras.Value) = "N"
2142:             IF THIS.txt_4c_Barras.Value > 0 AND ;
2143:                THIS.txt_4c_Barras.Value != THIS.this_nBarrasAnterior
2144:                 THIS.ValidarBarras()
2145:             ENDIF
2146:         ENDIF
2147: 
2148:         *-- Devolucao do foco ao campo: so quando a saida foi por ENTER (13),
2149:         *-- TAB (9) ou digito (48..57), igual ao InList do legado. Sair
2150:         *-- clicando com o mouse NAO rearma o foco - senao o usuario nao
2151:         *-- conseguiria clicar em nenhum botao da tela.
2152:         loc_nUltimaTecla = LASTKEY()
2153: 
2154:         IF loc_nUltimaTecla = 13 OR loc_nUltimaTecla = 9 OR ;
2155:            BETWEEN(loc_nUltimaTecla, 48, 57)
2156:             IF THIS.txt_4c_Barras.Enabled
2157:                 THIS.tmr_4c_FocoBarras.Enabled = .T.
2158:             ENDIF
2159:         ENDIF
2160:     ENDPROC
2161: 
2162:     *==================================================================
2163:     * TimerFocoBarras - legado: tmAux.Timer = "ThisForm.foca() /
2164:     * Keyboard(Chr(3)) / This.Enabled = .F."
2165:     *
2166:     * ORDEM e CONTEUDO transcritos do legado. O Keyboard(Chr(3)) vai junto
2167:     * por fidelidade (PILAR 1): com o foco no campo de barras ele age sobre
2168:     * a selecao do proprio campo, e o KeyPress deste form so reage a 13/9,
2169:     * entao nao dispara pesquisa nenhuma.
2170:     *
2171:     * O "This.Enabled = .F." eh o que faz o timer ser ONE-SHOT: sem ele o
2172:     * foco voltaria ao campo de barras a cada 200ms e a tela ficaria
2173:     * inutilizavel. THIS aqui eh o FORM (o handler eh metodo do form), por
2174:     * isso o alvo eh escrito por extenso.
2175:     *==================================================================
2176:     PROCEDURE TimerFocoBarras()
2177:         THIS.FocarBarras()
2178:         KEYBOARD CHR(3)
2179:         THIS.tmr_4c_FocoBarras.Enabled = .F.
2180:     ENDPROC
2181: 
2182:     *==================================================================
2183:     * FocarBarras - legado: PROCEDURE foca = "ThisForm.getBarras.SetFocus".
2184:     * Metodo proprio (e nao SetFocus embutido no Timer) porque no legado
2185:     * tambem eh metodo do form, chamado pelo Timer.
2186:     *==================================================================
2187:     PROCEDURE FocarBarras()
2188:         IF THIS.txt_4c_Barras.Enabled AND THIS.txt_4c_Barras.Visible
2189:             THIS.txt_4c_Barras.SetFocus()
2190:         ENDIF
2191:     ENDPROC
2192: 
2193:     *==================================================================
2194:     * ValidarBarras - FUNIL da pesquisa por codigo de barras (equivalente
2195:     * a getBarras.Valid + Processamento do legado): resolve a etiqueta (ou
2196:     * o produto, no fallback por SigCdPro), carrega os dados do produto e
2197:     * as 3 grades, e atualiza todos os campos de exibicao da tela.
2198:     *
2199:     * WRAPPER FINO do guard de reentrancia: o corpo fica em
2200:     * ValidarBarrasExec porque ele tem RETURN antecipado, e flag
2201:     * setada/limpa no proprio corpo ficaria TRAVADA ligada nesses caminhos -
2202:     * matando a pesquisa pelo resto da vida do form (regra CLAUDE.md #47).
2203:     *==================================================================
2204:     PROCEDURE ValidarBarras()
2205:         LOCAL loc_lSucesso
2206: 
2207:         IF THIS.this_lEmPesquisa
2208:             RETURN .F.
2209:         ENDIF
2210: 
2211:         THIS.this_lEmPesquisa = .T.
2212:         loc_lSucesso = THIS.ValidarBarrasExec()
2213:         THIS.this_lEmPesquisa = .F.
2214: 
2215:         RETURN loc_lSucesso
2216:     ENDPROC
2217: 
2218:     *==================================================================
2219:     * ValidarBarrasExec - corpo do funil de pesquisa. Chamado SO por
2220:     * ValidarBarras, que garante o guard de reentrancia.
2221:     *==================================================================
2222:     PROCEDURE ValidarBarrasExec()
2223:         LOCAL loc_nCodBarras, loc_lSucesso, loc_lProdutoAchado
2224: 
2225:         loc_lSucesso   = .F.
2226:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2227: 
2228:         IF VARTYPE(loc_nCodBarras) != "N" OR loc_nCodBarras <= 0
2229:             RETURN .F.
2230:         ENDIF
2231: 
2232:         IF !THIS.PodeConsultarBanco()
2233:             RETURN .F.
2234:         ENDIF
2235: 
2236:         TRY
2237:             IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
2238:                 *-- O codigo pode ter sido RENUMERADO (cbars_old -> cbars_new);
2239:                 *-- o campo de busca sempre mostra o codigo ATUAL.
2240:                 THIS.txt_4c_Barras.Value = THIS.this_oBusinessObject.this_nCodBarras
2241:                 THIS.txt_4c_Barra.Value  = THIS.this_oBusinessObject.this_nCodBarraAnterior
2242: 
2243:                 *-- Sincroniza o guard do GotFocus com o codigo RESOLVIDO (que
2244:                 *-- pode diferir do digitado, se a etiqueta foi renumerada):
2245:                 *-- sem isto o LostFocus seguinte veria "valor mudou" e
2246:                 *-- repetiria a pesquisa inteira.
2247:                 THIS.this_nBarrasAnterior = THIS.this_oBusinessObject.this_nCodBarras
2248: 
2249:                 THIS.AtualizarCamposEtiqueta()
2250: 
2251:                 loc_lProdutoAchado = THIS.this_oBusinessObject.CarregarDadosProduto(THIS.this_oBusinessObject.this_cCodProduto)
2252:                 THIS.AtualizarCamposProduto(loc_lProdutoAchado)
2253: 
2254:                 THIS.CarregarDados(THIS.this_oBusinessObject.this_nCodBarras)
2255: 
2256:                 *-- Legado: ao final do Processamento, as duas grades sao
2257:                 *-- reposicionadas e o AfterRowColChange disparado NA MAO
2258:                 *-- (Go Bottom + ThisForm.grdXxx.AfterRowColChange()).
2259:                 THIS.GradeHistoricoAfterRowColChange()
2260:                 THIS.GradeMovimentoAfterRowColChange()
2261: 
2262:                 loc_lSucesso = .T.

*-- Linhas 2269 a 2357:
2269:         CATCH TO loc_oErro
2270:             MsgErro(loc_oErro.Message + CHR(13) + ;
2271:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2272:                 "Procedure: " + loc_oErro.Procedure, "Erro em Formsigopcgb.ValidarBarrasExec")
2273:         ENDTRY
2274: 
2275:         RETURN loc_lSucesso
2276:     ENDPROC
2277: 
2278:     *==================================================================
2279:     * AtualizarCamposEtiqueta - Espelha os dados da etiqueta (BO) nos
2280:     * campos do bloco "Posicao Atual do Codigo de Barras" + Local.
2281:     * GetCProSHis/GetDProSHis sao zerados aqui, igual ao legado - so voltam
2282:     * a ser preenchidos se a linha corrente de Movimento tiver um produto
2283:     * DIFERENTE do pesquisado (GradeMovimentoAfterRowColChange).
2284:     *==================================================================
2285:     PROTECTED PROCEDURE AtualizarCamposEtiqueta()
2286:         LOCAL loc_oBO
2287:         loc_oBO = THIS.this_oBusinessObject
2288: 
2289:         THIS.txt_4c_Origem.Value  = loc_oBO.this_cOrigem
2290:         THIS.txt_4c_Empresa.Value = loc_oBO.this_cEmpresaOp
2291:         THIS.txt_4c_Grupo.Value   = loc_oBO.this_cGrupoOp
2292:         THIS.txt_4c_Conta.Value   = loc_oBO.this_cContaOp
2293:         THIS.txt_4c_Qtde.Value    = loc_oBO.this_nQtdeOp
2294:         THIS.txt_4c_Peso.Value    = loc_oBO.this_nPesoOp
2295:         THIS.txt_4c_Local.Value   = loc_oBO.this_cLocalizacao
2296: 
2297:         THIS.txt_4c_CProdutoSemHistorico.Value = ""
2298:         THIS.txt_4c_DProdutoSemHistorico.Value = ""
2299: 
2300:         THIS.txt_4c_Origem.Refresh()
2301:         THIS.txt_4c_Empresa.Refresh()
2302:         THIS.txt_4c_Grupo.Refresh()
2303:         THIS.txt_4c_Conta.Refresh()
2304:         THIS.txt_4c_Qtde.Refresh()
2305:         THIS.txt_4c_Peso.Refresh()
2306:         THIS.txt_4c_Local.Refresh()
2307:     ENDPROC
2308: 
2309:     *==================================================================
2310:     * AtualizarCamposProduto - Espelha os dados do produto (BO, carregados
2311:     * por CarregarDadosProduto) no bloco "Dados do Produto" + ajusta os
2312:     * captions de Qtd(1)/Qtd(2) e do cabecalho da 10a/11a coluna da grade de
2313:     * Historico pela unidade do produto (igual ao Processamento legado).
2314:     * par_lAchou: resultado de CarregarDadosProduto - produto nao encontrado
2315:     * limpa os campos (ramo Else do TmpPro legado).
2316:     *==================================================================
2317:     PROTECTED PROCEDURE AtualizarCamposProduto(par_lAchou)
2318:         LOCAL loc_oBO, loc_cUnidade, loc_cUnidadePeso
2319: 
2320:         loc_oBO = THIS.this_oBusinessObject
2321: 
2322:         IF par_lAchou
2323:             THIS.txt_4c_CProduto.Value    = loc_oBO.this_cCodProduto
2324:             THIS.txt_4c_DProduto.Value    = loc_oBO.this_cDescProduto
2325:             THIS.txt_4c_CFornecedor.Value = loc_oBO.this_cCodFornecedor
2326:             THIS.txt_4c_DFornecedor.Value = loc_oBO.this_cDescFornecedor
2327:             THIS.txt_4c_Referencia.Value  = loc_oBO.this_cReferencia
2328:             THIS.txt_4c_Colecoes.Value    = loc_oBO.this_cColecao
2329:             THIS.txt_4c_PVenda.Value      = loc_oBO.this_nPrecoVenda
2330:             THIS.txt_4c_PrecoDe.Value     = loc_oBO.this_nPrecoDe
2331:             THIS.txt_4c_Cat.Value         = loc_oBO.this_cCategoria
2332: 
2333:             loc_cUnidade     = ALLTRIM(loc_oBO.this_cUnidade)
2334:             loc_cUnidadePeso = ALLTRIM(loc_oBO.this_cUnidadePeso)
2335: 
2336:             THIS.lbl_4c_Qtd1.Caption = "Qtd(" + loc_cUnidade + ")"
2337:             THIS.lbl_4c_Qtd2.Caption = IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")
2338: 
2339:             THIS.grd_4c_Historico.Column10.Header1.Caption = "Qtd(" + loc_cUnidade + ")"
2340:             IF !loc_oBO.this_lHabilitaValor
2341:                 THIS.grd_4c_Historico.Column11.Header1.Caption = ;
2342:                     IIF(EMPTY(loc_cUnidadePeso), "Peso", "Qtd(" + loc_cUnidadePeso + ")")
2343:             ENDIF
2344:         ELSE
2345:             THIS.txt_4c_CProduto.Value    = ""
2346:             THIS.txt_4c_DProduto.Value    = ""
2347:             THIS.txt_4c_CFornecedor.Value = ""
2348:             THIS.txt_4c_DFornecedor.Value = ""
2349:             THIS.txt_4c_Referencia.Value  = ""
2350:             THIS.txt_4c_Colecoes.Value    = ""
2351:             THIS.txt_4c_PVenda.Value      = 0
2352:             THIS.txt_4c_Barra.Value       = 0
2353:         ENDIF
2354: 
2355:         THIS.ExibirImagemProduto(loc_oBO.this_cFigJpgBase64)
2356: 
2357:         THIS.txt_4c_CProduto.Refresh()

*-- Linhas 2371 a 2668:
2371:     * nem produto pelo fallback) - a tela nao deve manter dados da busca
2372:     * anterior depois de um resultado negativo.
2373:     *==================================================================
2374:     PROTECTED PROCEDURE LimparCamposProduto()
2375:         THIS.txt_4c_Origem.Value  = ""
2376:         THIS.txt_4c_Empresa.Value = ""
2377:         THIS.txt_4c_Grupo.Value   = ""
2378:         THIS.txt_4c_Conta.Value   = ""
2379:         THIS.txt_4c_Qtde.Value    = 0
2380:         THIS.txt_4c_Peso.Value    = 0
2381:         THIS.txt_4c_Local.Value   = ""
2382: 
2383:         THIS.txt_4c_CProdutoSemHistorico.Value = ""
2384:         THIS.txt_4c_DProdutoSemHistorico.Value = ""
2385: 
2386:         THIS.txt_4c_CProduto.Value    = ""
2387:         THIS.txt_4c_DProduto.Value    = ""
2388:         THIS.txt_4c_CFornecedor.Value = ""
2389:         THIS.txt_4c_DFornecedor.Value = ""
2390:         THIS.txt_4c_Referencia.Value  = ""
2391:         THIS.txt_4c_Colecoes.Value    = ""
2392:         THIS.txt_4c_PVenda.Value      = 0
2393:         THIS.txt_4c_PrecoDe.Value     = 0
2394:         THIS.txt_4c_Cat.Value         = ""
2395:         THIS.txt_4c_Barra.Value       = 0
2396: 
2397:         THIS.ExibirImagemProduto("")
2398: 
2399:         THIS.Refresh()
2400:     ENDPROC
2401: 
2402:     *==================================================================
2403:     * ExibirImagemProduto - Decodifica o FigJpgs (base64, com os prefixos
2404:     * data:image/... removidos pelo proprio legado) e exibe em img_4c_FigJpg.
2405:     * STRCONV(...,14) roda UMA UNICA VEZ (decode simples, nao duplo - regra
2406:     * CLAUDE.md "STRCONV double decode imagem"). Padrao canonico do projeto
2407:     * (FormSigMvSbn.AtualizarImagemProduto).
2408:     *==================================================================
2409:     PROTECTED PROCEDURE ExibirImagemProduto(par_cFigJpgBase64)
2410:         LOCAL loc_cFoto, loc_cArquivo
2411: 
2412:         THIS.img_4c_FigJpg.Visible = .F.
2413:         THIS.img_4c_FigJpg.Picture = ""
2414: 
2415:         loc_cFoto = TratarNulo(par_cFigJpgBase64, "")
2416:         IF !EMPTY(loc_cFoto)
2417:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
2418:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2419:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
2420:             loc_cFoto = STRCONV(loc_cFoto, 14)
2421: 
2422:             loc_cArquivo = SYS(2023) + "\SIGOPCGB.jpg"
2423:             IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
2424:                 THIS.img_4c_FigJpg.Picture = loc_cArquivo
2425:                 THIS.img_4c_FigJpg.Visible = .T.
2426:             ENDIF
2427:         ENDIF
2428:     ENDPROC
2429: 
2430:     *==================================================================
2431:     * GradeHistoricoAfterRowColChange - legado: recarrega a imagem do
2432:     * PRODUTO PESQUISADO (nao ha lookup por linha aqui - todo o Historico
2433:     * pertence ao mesmo produto) e atualiza a grade de cotacoes (chamada
2434:     * incondicional no legado, independente do checkbox estar marcado).
2435:     *==================================================================
2436:     PROCEDURE GradeHistoricoAfterRowColChange(par_nColIndex)
2437:         THIS.this_nGradeSel = 1
2438: 
2439:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2440:             THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgBase64)
2441:         ENDIF
2442: 
2443:         THIS.AtualizarGradeCotacoes()
2444:     ENDPROC
2445: 
2446:     *==================================================================
2447:     * GradeMovimentoAfterRowColChange - legado: se o produto da linha de
2448:     * Movimento CORRENTE for DIFERENTE do produto pesquisado, busca
2449:     * (SigCdPro) e exibe o codigo/descricao/imagem desse OUTRO produto nos
2450:     * campos "Codigos de Barras Sem Historico" (GetCProSHis/GetDProSHis).
2451:     * Se for o MESMO produto, nao faz nada - os campos ficam como
2452:     * AtualizarCamposEtiqueta os deixou (vazios).
2453:     *==================================================================
2454:     PROCEDURE GradeMovimentoAfterRowColChange(par_nColIndex)
2455:         LOCAL loc_cCodProdutoLinha
2456: 
2457:         THIS.this_nGradeSel = 2
2458: 
2459:         IF USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
2460:             loc_cCodProdutoLinha = TratarNulo(cursor_4c_Movimento.cpros, "")
2461:         ELSE
2462:             loc_cCodProdutoLinha = ""
2463:         ENDIF
2464: 
2465:         IF !EMPTY(loc_cCodProdutoLinha) AND VARTYPE(THIS.this_oBusinessObject) = "O" ;
2466:                 AND loc_cCodProdutoLinha != THIS.this_oBusinessObject.this_cCodProduto
2467:             THIS.this_oBusinessObject.CarregarProdutoResumido(loc_cCodProdutoLinha)
2468:             THIS.txt_4c_CProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cCodProdutoHist
2469:             THIS.txt_4c_DProdutoSemHistorico.Value = THIS.this_oBusinessObject.this_cDescProdutoHist
2470:             THIS.ExibirImagemProduto(THIS.this_oBusinessObject.this_cFigJpgProdutoHist)
2471:         ENDIF
2472:     ENDPROC
2473: 
2474:     *==================================================================
2475:     * GradeDevolucaoAfterRowColChange - legado: grddevolucao.AfterRowColChange
2476:     * so marca qual grade esta selecionada - usado por BtnDocumentoClick/
2477:     * BotRastroClick para saber de qual grade ler a linha corrente.
2478:     *==================================================================
2479:     PROCEDURE GradeDevolucaoAfterRowColChange(par_nColIndex)
2480:         THIS.this_nGradeSel = 3
2481:     ENDPROC
2482: 
2483:     *==================================================================
2484:     * GradeHistoricoClick - legado: grdHistorico.Click = This.AfterRowColChange().
2485:     * Reforca a repintura da imagem/cotacoes ao clicar na MESMA celula ja
2486:     * focada (o AfterRowColChange nativo so dispara ao TROCAR de celula).
2487:     *==================================================================
2488:     PROCEDURE GradeHistoricoClick()
2489:         THIS.GradeHistoricoAfterRowColChange()
2490:     ENDPROC
2491: 
2492:     *==================================================================
2493:     * DesabilitarControlesPrincipais / ReabilitarControlesPrincipais - funil
2494:     * unico da lista de controles que o legado desabilita/reabilita enquanto
2495:     * um form ou painel filho esta aberto (BtnLocalClick/BotaoCorrecaoClick -
2496:     * mesma lista nos dois: GetBarras/CmdBtnForm.BtnSair/GrdMovimento/
2497:     * GrdHistorico/BtnDocumento/BtnImprimir/BtnVisualizar/BtnLocal).
2498:     *==================================================================
2499:     PROTECTED PROCEDURE DesabilitarControlesPrincipais()
2500:         THIS.txt_4c_Barras.Enabled                = .F.
2501:         THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .F.
2502:         THIS.grd_4c_Movimento.Enabled              = .F.
2503:         THIS.grd_4c_Historico.Enabled               = .F.
2504:         THIS.cmd_4c_BtnDocumento.Enabled           = .F.
2505:         THIS.cmd_4c_BtnImprimir.Enabled            = .F.
2506:         THIS.cmd_4c_BtnVisualizar.Enabled          = .F.
2507:         THIS.cmd_4c_BtnLocal.Enabled               = .F.
2508:     ENDPROC
2509: 
2510:     PROTECTED PROCEDURE ReabilitarControlesPrincipais()
2511:         THIS.txt_4c_Barras.Enabled                = .T.
2512:         THIS.obj_4c_CmdBtnForm.Buttons(1).Enabled = .T.
2513:         THIS.grd_4c_Movimento.Enabled               = .T.
2514:         THIS.grd_4c_Historico.Enabled                = .T.
2515:         THIS.AtualizarEstadoBotoes(THIS.txt_4c_Barras.Value)
2516:     ENDPROC
2517: 
2518:     *==================================================================
2519:     * BtnLocalClick - abre a tela de correcao de localizacao da etiqueta
2520:     * (legado: Do Form SigOpCgl With lnCodBars), desabilitando os demais
2521:     * controles enquanto ela estiver aberta - igual ao legado. SigOpCgl
2522:     * ainda nao foi migrado para a nova arquitetura; o guard evita
2523:     * "Class SIGOPCGL is not found" e avisa o usuario.
2524:     *==================================================================
2525:     PROCEDURE BtnLocalClick()
2526:         LOCAL loc_nCodBarras, loc_oForm
2527: 
2528:         IF !THIS.cmd_4c_BtnLocal.Enabled
2529:             RETURN
2530:         ENDIF
2531: 
2532:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2533: 
2534:         THIS.DesabilitarControlesPrincipais()
2535: 
2536:         loc_oForm = .NULL.
2537:         TRY
2538:             loc_oForm = CREATEOBJECT("FormSigOpCgl", loc_nCodBarras)
2539:         CATCH TO loc_oErro
2540:             loc_oForm = .NULL.
2541:         ENDTRY
2542: 
2543:         IF VARTYPE(loc_oForm) = "O"
2544:             loc_oForm.Show()
2545:         ELSE
2546:             MsgAviso("Tela de corre" + CHR(231) + CHR(227) + "o de localiza" + CHR(231) + CHR(227) + ;
2547:                 "o (SigOpCgl) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
2548:         ENDIF
2549: 
2550:         *-- Ao voltar, a localizacao pode ter sido alterada na tela de
2551:         *-- correcao - reconsulta a etiqueta para refletir o valor atual.
2552:         IF THIS.PodeConsultarBanco() AND VARTYPE(loc_nCodBarras) = "N" AND loc_nCodBarras > 0
2553:             IF THIS.this_oBusinessObject.BuscarEtiquetaPorCodBarras(loc_nCodBarras)
2554:                 THIS.AtualizarCamposEtiqueta()
2555:             ENDIF
2556:         ENDIF
2557: 
2558:         THIS.ReabilitarControlesPrincipais()
2559:     ENDPROC
2560: 
2561:     *==================================================================
2562:     * BtnEncerrarClick - Encerrar (obj_4c_CmdBtnForm.Buttons(1), legado:
2563:     * cmdBtnForm.btnSair.Click = ThisForm.Release).
2564:     *==================================================================
2565:     PROCEDURE BtnEncerrarClick()
2566:         THIS.Release()
2567:     ENDPROC
2568: 
2569:     *==================================================================
2570:     * BtnImprimirClick / BtnVisualizarClick - disparam a mesma rotina do
2571:     * legado (ThisForm.Imagem('I') / ThisForm.Imagem('V')), precedida pelo
2572:     * SetFocus na grade de Historico que o legado tambem faz antes de
2573:     * chamar Imagem.
2574:     *==================================================================
2575:     PROCEDURE BtnImprimirClick()
2576:         IF !THIS.cmd_4c_BtnImprimir.Enabled
2577:             RETURN
2578:         ENDIF
2579:         THIS.grd_4c_Historico.Column1.SetFocus()
2580:         THIS.ImprimirOuVisualizarEtiqueta("I")
2581:     ENDPROC
2582: 
2583:     PROCEDURE BtnVisualizarClick()
2584:         IF !THIS.cmd_4c_BtnVisualizar.Enabled
2585:             RETURN
2586:         ENDIF
2587:         THIS.grd_4c_Historico.Column1.SetFocus()
2588:         THIS.ImprimirOuVisualizarEtiqueta("V")
2589:     ENDPROC
2590: 
2591:     *==================================================================
2592:     * ImprimirOuVisualizarEtiqueta - equivalente ao PROCEDURE imagem do
2593:     * legado: monta o cabecalho da etiqueta (empresa logada, codigo de
2594:     * barras, produto, fornecedor, referencia), garante o .jpg que o FRX
2595:     * carrega e aciona o REPORT FORM SigOpCgb - To Printer Prompt
2596:     * (par_cTipo = "I") ou Preview (par_cTipo = "V").
2597:     *
2598:     * O ALIAS DO CURSOR E CONTRATO DO FRX, NAO NOME ESCOLHIDO AQUI.
2599:     * O SigOpCgb.frx legado le csCabecalho.CodBarras / .CPros / .DPros /
2600:     * .Fornecedor / .Referencia / .empresa - entao o cursor TEM de se
2601:     * chamar csCabecalho, como no legado. Rebatiza-lo para
2602:     * cursor_4c_Etiqueta (PILAR 3) faz o relatorio estourar com
2603:     * "Alias CSCABECALHO is not found": aqui o nome do alias e dado do
2604:     * relatorio, igual a nome de coluna do banco (PILAR 2), e o PILAR 3
2605:     * nao se aplica.
2606:     *
2607:     * A IMAGEM TEM NOME FIXO, TAMBEM POR CONTRATO DO FRX: a expressao do
2608:     * Image do FRX e "Sys(2023) + '\SigOpCgb.Jpg'". Gravar num nome
2609:     * aleatorio (SYS(2015)) escreve um arquivo que o relatorio nunca le e
2610:     * imprime a FOTO DO PRODUTO ANTERIOR, que ficou no nome fixo. Sem
2611:     * foto, o legado grava o fundo BRANCO (BrJpg.JPG) exatamente para
2612:     * nao arrastar a imagem anterior - reproduzido com vbmp\brjpg.jpg.
2613:     *==================================================================
2614:     PROTECTED PROCEDURE ImprimirOuVisualizarEtiqueta(par_cTipo)
2615:         LOCAL loc_oBO, loc_cEmpresa, loc_cArquivoImg, loc_cBranco, loc_cFoto
2616: 
2617:         loc_oBO = THIS.this_oBusinessObject
2618: 
2619:         IF EMPTY(THIS.txt_4c_CProduto.Value)
2620:             MsgAviso("Nenhum produto localizado para a etiqueta pesquisada.", "Aviso")
2621:             RETURN
2622:         ENDIF
2623: 
2624:         *-- Legado: "If !File(lcBrJpg) / MessageBox('Esta Faltando .JPG
2625:         *-- Branco !!!') / Return 0" - sem o fundo branco ele ABORTA.
2626:         loc_cBranco = FULLPATH(gc_4c_CaminhoIcones + "brjpg.jpg")
2627:         IF !FILE(loc_cBranco)
2628:             MsgAviso("Est" + CHR(225) + " faltando o .JPG branco (brjpg.jpg).", "Aviso")
2629:             RETURN
2630:         ENDIF
2631: 
2632:         loc_cEmpresa = TRIM(loc_oBO.this_cCodEmpresa) + ;
2633:             IIF(!EMPTY(loc_oBO.this_cRazaoEmpresa), " - " + TRIM(loc_oBO.this_cRazaoEmpresa), "")
2634: 
2635:         IF USED("csCabecalho")
2636:             USE IN csCabecalho
2637:         ENDIF
2638:         CREATE CURSOR csCabecalho ;
2639:             (empresa C(80), codbarras N(14), cpros C(14), dpros C(40), fornecedor C(10), referencia C(10))
2640:         INSERT INTO csCabecalho (empresa, codbarras, cpros, dpros, fornecedor, referencia) ;
2641:             VALUES (loc_cEmpresa, THIS.txt_4c_Barras.Value, THIS.txt_4c_CProduto.Value, ;
2642:                     THIS.txt_4c_DProduto.Value, THIS.txt_4c_CFornecedor.Value, THIS.txt_4c_Referencia.Value)
2643: 
2644:         *-- Nome FIXO, igual a expressao do Image no FRX.
2645:         loc_cArquivoImg = SYS(2023) + "\SigOpCgb.Jpg"
2646:         loc_cFoto = TratarNulo(loc_oBO.this_cFigJpgBase64, "")
2647:         IF !EMPTY(loc_cFoto)
2648:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
2649:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2650:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
2651:             loc_cFoto = STRCONV(loc_cFoto, 14)
2652:             STRTOFILE(loc_cFoto, loc_cArquivoImg)
2653:         ELSE
2654:             *-- Sem foto: fundo BRANCO, para nao imprimir a do produto anterior.
2655:             COPY FILE (loc_cBranco) TO (loc_cArquivoImg)
2656:         ENDIF
2657: 
2658:         *-- CLEAR RESOURCES: sem isso o VFP reusa o .jpg CACHEADO e a
2659:         *-- etiqueta sai com a imagem anterior (o legado faz o mesmo).
2660:         CLEAR RESOURCES
2661: 
2662:         THIS.ExecutarReportForm(gc_4c_CaminhoReports + "SigOpCgb.frx", ;
2663:             IIF(par_cTipo = "I", "PRINTER_PROMPT", "PREVIEW"), "csCabecalho")
2664: 
2665:         IF USED("csCabecalho")
2666:             USE IN csCabecalho
2667:         ENDIF
2668:     ENDPROC

*-- Linhas 2682 a 3021:
2682:     *
2683:     * par_cModo: "PREVIEW" | "PRINTER" | "PRINTER_PROMPT"
2684:     *==================================================================
2685:     PROCEDURE ExecutarReportForm(par_cFRXPath, par_cModo, par_cCursorDados)
2686:         LOCAL loc_cPonto, loc_cSeparador, loc_nBehavior, loc_lResultado, loc_lProsseguir
2687: 
2688:         loc_cPonto     = SET("POINT")
2689:         loc_cSeparador = SET("SEPARATOR")
2690:         loc_nBehavior  = SET("REPORTBEHAVIOR")
2691:         loc_lResultado = .F.
2692:         loc_lProsseguir = .T.
2693: 
2694:         IF !FILE(FULLPATH(par_cFRXPath))
2695:             MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
2696:                 CHR(13) + par_cFRXPath, "Relat" + CHR(243) + "rio")
2697:             loc_lProsseguir = .F.
2698:         ENDIF
2699: 
2700:         IF loc_lProsseguir AND VARTYPE(par_cCursorDados) = "C" AND !EMPTY(par_cCursorDados)
2701:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2702:                 MsgAviso("Nenhum dado dispon" + CHR(237) + "vel para o relat" + ;
2703:                     CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
2704:                 loc_lProsseguir = .F.
2705:             ENDIF
2706:         ENDIF
2707: 
2708:         IF loc_lProsseguir
2709:             TRY
2710:                 SET POINT TO "."
2711:                 SET SEPARATOR TO ","
2712:                 SET REPORTBEHAVIOR 80
2713: 
2714:                 DO CASE
2715:                 CASE UPPER(ALLTRIM(par_cModo)) = "PREVIEW"
2716:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
2717:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER_PROMPT"
2718:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER PROMPT
2719:                 CASE UPPER(ALLTRIM(par_cModo)) = "PRINTER"
2720:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE TO PRINTER
2721:                 OTHERWISE
2722:                     REPORT FORM (FULLPATH(par_cFRXPath)) NOCONSOLE PREVIEW
2723:                 ENDCASE
2724: 
2725:                 loc_lResultado = .T.
2726:             CATCH TO loc_oErro
2727:                 MsgErro(loc_oErro.Message + CHR(13) + ;
2728:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2729:                     "Procedure: " + loc_oErro.Procedure, "ExecutarReportForm")
2730:             ENDTRY
2731: 
2732:             SET POINT TO loc_cPonto
2733:             SET SEPARATOR TO loc_cSeparador
2734:             SET REPORTBEHAVIOR loc_nBehavior
2735: 
2736:             *-- Restaura o menu principal que o _MREPORT do preview corrompe.
2737:             TRY
2738:                 SET SYSMENU TO DEFAULT
2739:                 RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
2740:                     popRelatorios, popFerramentas, popAjuda
2741:                 CriarMenuPrincipal()
2742:             CATCH TO loc_oErroMenu
2743:                 MsgErro(loc_oErroMenu.Message, "ExecutarReportForm")
2744:             ENDTRY
2745:         ENDIF
2746: 
2747:         RETURN loc_lResultado
2748:     ENDPROC
2749: 
2750:     *==================================================================
2751:     * BtnDocumentoClick - abre o documento de movimento da linha CORRENTE
2752:     * da grade ativa (Historico/Movimento/Devolucao - this_nGradeSel),
2753:     * igual ao legado: localiza o documento em SigMvCab (CongBEest);
2754:     * achando, abre FormSigMvExp; nao achando, confere SigCdNec (EmpDnPs) e
2755:     * abre FormSigMvPdt; sem nenhum dos dois, avisa que a operacao nao foi
2756:     * encontrada.
2757:     *==================================================================
2758:     PROCEDURE BtnDocumentoClick()
2759:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEDN, loc_oForm, loc_oBO
2760: 
2761:         IF !THIS.cmd_4c_BtnDocumento.Enabled
2762:             RETURN
2763:         ENDIF
2764: 
2765:         loc_cEmps  = ""
2766:         loc_cDopes = ""
2767:         loc_nNumes = 0
2768:         loc_cEDN   = ""
2769: 
2770:         DO CASE
2771:         CASE THIS.this_nGradeSel = 2 AND USED("cursor_4c_Movimento") AND !EOF("cursor_4c_Movimento")
2772:             loc_cEmps  = TratarNulo(cursor_4c_Movimento.emps, "")
2773:             loc_cDopes = TratarNulo(cursor_4c_Movimento.dopes, "")
2774:             loc_nNumes = NVL(cursor_4c_Movimento.numes, 0)
2775:             loc_cEDN   = TratarNulo(cursor_4c_Movimento.OriDopNums, "")
2776:         CASE THIS.this_nGradeSel = 3 AND USED("cursor_4c_Devolucao") AND !EOF("cursor_4c_Devolucao")
2777:             loc_cEmps  = TratarNulo(cursor_4c_Devolucao.emps, "")
2778:             loc_cDopes = TratarNulo(cursor_4c_Devolucao.dopes, "")
2779:             loc_nNumes = NVL(cursor_4c_Devolucao.numes, 0)
2780:             loc_cEDN   = TratarNulo(cursor_4c_Devolucao.OriDopNums, "")
2781:         OTHERWISE
2782:             IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
2783:                 loc_cEmps  = TratarNulo(cursor_4c_Historico.emps, "")
2784:                 loc_cDopes = TratarNulo(cursor_4c_Historico.dopes, "")
2785:                 loc_nNumes = NVL(cursor_4c_Historico.numes, 0)
2786:                 loc_cEDN   = TratarNulo(cursor_4c_Historico.OriDopNums, "")
2787:             ENDIF
2788:         ENDCASE
2789: 
2790:         IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR loc_nNumes = 0
2791:             MsgAviso("Selecione uma Etiqueta em uma das listas para visualizar o Documento!", "Aviso")
2792:             RETURN
2793:         ENDIF
2794: 
2795:         IF !THIS.PodeConsultarBanco()
2796:             RETURN
2797:         ENDIF
2798: 
2799:         loc_oBO   = THIS.this_oBusinessObject
2800:         loc_oForm = .NULL.
2801: 
2802:         IF loc_oBO.LocalizarDocumentoPorChave(loc_cEDN)
2803:             TRY
2804:                 loc_oForm = CREATEOBJECT("FormSigMvExp", loc_oBO.this_cDopesDocto, "C", ;
2805:                     loc_oBO.this_nNumesDocto, loc_oBO.this_cEmpsDocto, .T.)
2806:             CATCH TO loc_oErro
2807:                 loc_oForm = .NULL.
2808:             ENDTRY
2809: 
2810:             IF VARTYPE(loc_oForm) = "O"
2811:                 loc_oForm.Show()
2812:             ELSE
2813:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
2814:                     "Movimenta" + CHR(231) + CHR(227) + "o (SigMvExp).", "Aviso")
2815:             ENDIF
2816:         ELSE
2817:             IF loc_oBO.ExisteNecessidadePorChave(loc_cEmps, loc_cDopes, loc_nNumes)
2818:                 TRY
2819:                     loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
2820:                 CATCH TO loc_oErro
2821:                     loc_oForm = .NULL.
2822:                 ENDTRY
2823: 
2824:                 IF VARTYPE(loc_oForm) = "O"
2825:                     loc_oForm.Show()
2826:                 ELSE
2827:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel abrir a tela de " + ;
2828:                         "Pedido (SigMvPdt).", "Aviso")
2829:                 ENDIF
2830:             ELSE
2831:                 MsgErro("A opera" + CHR(231) + CHR(227) + "o selecionada n" + CHR(227) + ;
2832:                     "o pode ser encontrada!" + CHR(13) + ;
2833:                     "Posicione em uma opera" + CHR(231) + CHR(227) + "o v" + CHR(225) + ;
2834:                     "lida na lista!", "Documento")
2835:             ENDIF
2836:         ENDIF
2837:     ENDPROC
2838: 
2839:     *==================================================================
2840:     * BotRastroClick - abre a tela de rastreabilidade (legado: Do Form
2841:     * SigReCgr With 1, ThisForm.GetBarras.Value, ThisForm). SigReCgr ainda
2842:     * nao foi migrada - mesmo guard do BtnLocalClick (CREATEOBJECT dentro
2843:     * do TRY, Show() FORA - regra CLAUDE.md #29).
2844:     *==================================================================
2845:     PROCEDURE BotRastroClick()
2846:         LOCAL loc_nCodBarras, loc_oForm
2847: 
2848:         IF !THIS.cmd_4c_BotRastro.Enabled
2849:             RETURN
2850:         ENDIF
2851: 
2852:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2853:         loc_oForm = .NULL.
2854: 
2855:         TRY
2856:             loc_oForm = CREATEOBJECT("FormSigReCgr", 1, loc_nCodBarras, THIS)
2857:         CATCH TO loc_oErro
2858:             loc_oForm = .NULL.
2859:         ENDTRY
2860: 
2861:         IF VARTYPE(loc_oForm) = "O"
2862:             loc_oForm.Show()
2863:         ELSE
2864:             MsgAviso("Tela de rastreabilidade (SigReCgr) ainda n" + CHR(227) + "o foi migrada.", "Aviso")
2865:         ENDIF
2866: 
2867:         *-- Legado: devolve o foco para a grade ativa (Movimento ou Historico)
2868:         IF THIS.this_nGradeSel = 2
2869:             THIS.grd_4c_Movimento.Column1.SetFocus()
2870:         ELSE
2871:             THIS.grd_4c_Historico.Column1.SetFocus()
2872:         ENDIF
2873:     ENDPROC
2874: 
2875:     *==================================================================
2876:     * BotaoCorrecaoClick - abre o painel de correcao de etiquetas (legado:
2877:     * Botao_de_Correcao.Click), desabilitando os demais controles (mesma
2878:     * lista do BtnLocalClick) e carregando o historico de correcoes da
2879:     * etiqueta (SigEtHst) na grade grd_4c_Correcao.
2880:     *==================================================================
2881:     PROCEDURE BotaoCorrecaoClick()
2882:         LOCAL loc_nCodBarras
2883: 
2884:         IF !THIS.cmd_4c_BotaoCorrecao.Enabled
2885:             RETURN
2886:         ENDIF
2887: 
2888:         loc_nCodBarras = THIS.txt_4c_Barras.Value
2889: 
2890:         THIS.DesabilitarControlesPrincipais()
2891: 
2892:         IF THIS.PodeConsultarBanco()
2893:             THIS.this_oBusinessObject.CarregarCorrecaoPorCodBarras(loc_nCodBarras)
2894:         ENDIF
2895: 
2896:         WITH THIS.cnt_4c_Correcao
2897:             .Top     = (THIS.Height / 2) - (.Height / 2)
2898:             .Visible = .T.
2899:             .Refresh()
2900:             .grd_4c_Correcao.Refresh()
2901:             .grd_4c_Correcao.Column1.SetFocus()
2902:         ENDWITH
2903:     ENDPROC
2904: 
2905:     *==================================================================
2906:     * PainelCorrecaoEncerrarClick - fecha o painel de correcao (legado:
2907:     * Cnt_Correcao.cmdBtnForm.btnSair.Click) e reabilita os demais
2908:     * controles - NAO fecha o form (eh so o painel flutuante).
2909:     *==================================================================
2910:     PROCEDURE PainelCorrecaoEncerrarClick()
2911:         THIS.ReabilitarControlesPrincipais()
2912:         THIS.cnt_4c_Correcao.Visible = .F.
2913:     ENDPROC
2914: 
2915:     *==================================================================
2916:     * BotCotacoesClick - chk_4c_BotCotacoes: liga/desliga o painel de
2917:     * cotacoes (legado: This.Parent.grdCot.Visible = This.Value), atualizando
2918:     * a grade so quando o checkbox eh marcado.
2919:     *==================================================================
2920:     PROCEDURE BotCotacoesClick()
2921:         LOCAL loc_lMostrar
2922: 
2923:         loc_lMostrar = (THIS.chk_4c_BotCotacoes.Value = 1)
2924: 
2925:         IF loc_lMostrar
2926:             THIS.AtualizarGradeCotacoes()
2927:         ENDIF
2928: 
2929:         THIS.cnt_4c_GrdCot.Visible = loc_lMostrar
2930:         THIS.cnt_4c_GrdCot.Refresh()
2931:     ENDPROC
2932: 
2933:     *==================================================================
2934:     * AtualizarGradeCotacoes - recarrega cursor_4c_Cotacoes com a cotacao de
2935:     * cada moeda na data do registro CORRENTE da grade de Historico (legado:
2936:     * fBuscarCotacao(TmpCot.cmoes, csHistorico.Datas, ...)).
2937:     *==================================================================
2938:     PROTECTED PROCEDURE AtualizarGradeCotacoes()
2939:         LOCAL loc_dData
2940: 
2941:         loc_dData = {}
2942:         IF USED("cursor_4c_Historico") AND !EOF("cursor_4c_Historico")
2943:             loc_dData = ConverterParaData(cursor_4c_Historico.datas)
2944:         ENDIF
2945: 
2946:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND THIS.PodeConsultarBanco()
2947:             THIS.this_oBusinessObject.CarregarCotacoesPorData(loc_dData)
2948:             THIS.cnt_4c_GrdCot.lbl_4c_TituloCotacoes.Caption = "Cota" + CHR(231) + CHR(245) + "es na Data"
2949:             THIS.cnt_4c_GrdCot.grd_4c_Cotacoes.Refresh()
2950:         ENDIF
2951:     ENDPROC
2952: 
2953:     *==================================================================
2954:     * FecharCursoresGrades - Fecha os cursores das grades. Chamado pelo
2955:     * Destroy: as grades morrem com o form, mas os aliases sao globais a
2956:     * data session e ficariam abertos.
2957:     *==================================================================
2958:     PROTECTED PROCEDURE FecharCursoresGrades()
2959:         IF USED("cursor_4c_Historico")
2960:             USE IN cursor_4c_Historico
2961:         ENDIF
2962:         IF USED("cursor_4c_Movimento")
2963:             USE IN cursor_4c_Movimento
2964:         ENDIF
2965:         IF USED("cursor_4c_Devolucao")
2966:             USE IN cursor_4c_Devolucao
2967:         ENDIF
2968:         IF USED("cursor_4c_Cotacoes")
2969:             USE IN cursor_4c_Cotacoes
2970:         ENDIF
2971:         IF USED("cursor_4c_Correcao")
2972:             USE IN cursor_4c_Correcao
2973:         ENDIF
2974: 
2975:         RETURN .T.
2976:     ENDPROC
2977: 
2978:     *==================================================================
2979:     * PodeConsultarBanco - .T. quando ha conexao real E o form nao esta
2980:     * sendo instanciado por validacao de UI / teste automatizado (onde
2981:     * nao existe banco para consultar).
2982:     *==================================================================
2983:     FUNCTION PodeConsultarBanco()
2984:         LOCAL loc_lPode
2985: 
2986:         loc_lPode = (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2987: 
2988:         IF loc_lPode AND TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2989:             loc_lPode = .F.
2990:         ENDIF
2991: 
2992:         IF loc_lPode AND TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
2993:             loc_lPode = .F.
2994:         ENDIF
2995: 
2996:         RETURN loc_lPode
2997:     ENDFUNC
2998: 
2999:     *==================================================================
3000:     * Destroy - Fecha os cursores das grades, libera o Business Object e
3001:     * chama DODEFAULT (FormBase.Destroy, que reconstroi o menu principal)
3002:     *==================================================================
3003:     PROCEDURE Destroy()
3004:         *-- Desarma o timer de foco ANTES de derrubar o resto: timer armado
3005:         *-- disparando durante o teardown chamaria SetFocus num controle que
3006:         *-- ja esta sendo destruido.
3007:         IF PEMSTATUS(THIS, "tmr_4c_FocoBarras", 5)
3008:             THIS.tmr_4c_FocoBarras.Enabled = .F.
3009:         ENDIF
3010: 
3011:         THIS.FecharCursoresGrades()
3012: 
3013:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
3014:             THIS.this_oBusinessObject.LiberarCursoresConsulta()
3015:             THIS.this_oBusinessObject = .NULL.
3016:         ENDIF
3017: 
3018:         DODEFAULT()
3019:     ENDPROC
3020: 
3021: ENDDEFINE

