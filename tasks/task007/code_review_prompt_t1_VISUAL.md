# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4266 linhas total):

*-- Linhas 91 a 105:
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount  = 2
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1000
97:             .Height     = 629
98:             .Tabs       = .F.
99:             .Page1.Caption   = "Lista"
100:             .Page2.Caption   = "Dados"
101:             .Page1.BackColor = RGB(234, 232, 228)
102:             .Page2.BackColor = RGB(234, 232, 228)
103:         ENDWITH
104:     ENDPROC
105: 

*-- Linhas 123 a 163:
123:         *----------------------------------------------------------------------
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 31
127:             .Left        = 0
128:             .Width       = 935
129:             .Height      = 85
130:             .BackColor   = RGB(53, 53, 53)
131:             .BackStyle   = 1
132:             .BorderWidth = 0
133:             .BorderStyle = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         *-- Label sombra (efeito 3D no titulo)
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = "Cadastro de CFOP"
141:             .Top       = 15
142:             .Left      = 11
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .Alignment = 0
151:         ENDWITH
152: 
153:         *-- Label titulo (branco sobre fundo escuro)
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = "Cadastro de CFOP"
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.

*-- Linhas 172 a 198:
172:         *----------------------------------------------------------------------
173:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
174:         WITH loc_oPagina.cnt_4c_Botoes
175:             .Top         = 29
176:             .Left        = 542
177:             .Width       = 390
178:             .Height      = 85
179:             .BackColor   = RGB(53, 53, 53)
180:             .BackStyle   = 1
181:             .BorderWidth = 0
182:             .BorderStyle = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         *-- Botao Incluir
187:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
188:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
189:             .Caption         = "Incluir"
190:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
191:             .PicturePosition = 13
192:             .Top             = 5
193:             .Left            = 5
194:             .Width           = 75
195:             .Height          = 75
196:             .BackColor       = RGB(255, 255, 255)
197:             .ForeColor       = RGB(90, 90, 90)
198:             .FontName        = "Comic Sans MS"

*-- Linhas 205 a 222:
205:             .WordWrap        = .T.
206:             .AutoSize        = .F.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         *-- Botao Visualizar
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
213:             .Caption         = "Visualizar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 80
218:             .Width           = 75
219:             .Height          = 75
220:             .BackColor       = RGB(255, 255, 255)
221:             .ForeColor       = RGB(90, 90, 90)
222:             .FontName        = "Comic Sans MS"

*-- Linhas 229 a 246:
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .FontName        = "Comic Sans MS"

*-- Linhas 253 a 270:
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .BackColor       = RGB(255, 255, 255)
269:             .ForeColor       = RGB(90, 90, 90)
270:             .FontName        = "Comic Sans MS"

*-- Linhas 277 a 294:
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:         ENDWITH
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         *-- Botao Buscar
283:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
284:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .Top             = 5
289:             .Left            = 305
290:             .Width           = 75
291:             .Height          = 75
292:             .BackColor       = RGB(255, 255, 255)
293:             .ForeColor       = RGB(90, 90, 90)
294:             .FontName        = "Comic Sans MS"

*-- Linhas 301 a 334:
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *----------------------------------------------------------------------
307:         * Container Saida (botao X - extremo direito)
308:         *----------------------------------------------------------------------
309:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
310:         WITH loc_oPagina.cnt_4c_Saida
311:             .Top         = 29
312:             .Left        = 935
313:             .Width       = 60
314:             .Height      = 85
315:             .BackColor   = RGB(53, 53, 53)
316:             .BackStyle   = 1
317:             .BorderWidth = 0
318:             .BorderStyle = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         *-- Botao Encerrar
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 50
331:             .Height          = 75
332:             .BackColor       = RGB(255, 255, 255)
333:             .ForeColor       = RGB(90, 90, 90)
334:             .FontName        = "Comic Sans MS"

*-- Linhas 341 a 388:
341:             .WordWrap        = .T.
342:             .AutoSize        = .F.
343:         ENDWITH
344:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
345: 
346:         *----------------------------------------------------------------------
347:         * Botoes XML (Exporta/Importa)
348:         * Top=114 = original 85 + compensacao 29
349:         * Original: btnExpXML.Left=3, btnImpXML.Left=127
350:         *----------------------------------------------------------------------
351:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
352:         WITH loc_oPagina.cmd_4c_ExpXML
353:             .Caption       = "Exporta XML"
354:             .Top           = 114
355:             .Left          = 3
356:             .Width         = 120
357:             .Height        = 40
358:             .BackColor     = RGB(234, 232, 228)
359:             .ForeColor     = RGB(0, 0, 0)
360:             .FontName      = "Tahoma"
361:             .FontSize      = 8
362:             .Themes        = .F.
363:             .SpecialEffect = 0
364:             .MousePointer  = 15
365:         ENDWITH
366:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML, "Click", THIS, "BtnExpXMLClick")
367: 
368:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
369:         WITH loc_oPagina.cmd_4c_ImpXML
370:             .Caption       = "Importa XML"
371:             .Top           = 114
372:             .Left          = 127
373:             .Width         = 120
374:             .Height        = 40
375:             .BackColor     = RGB(234, 232, 228)
376:             .ForeColor     = RGB(0, 0, 0)
377:             .FontName      = "Tahoma"
378:             .FontSize      = 8
379:             .Themes        = .F.
380:             .SpecialEffect = 0
381:             .MousePointer  = 15
382:         ENDWITH
383:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML, "Click", THIS, "BtnImpXMLClick")
384: 
385:         *----------------------------------------------------------------------
386:         * Cursor placeholder para o Grid
387:         * cursor_4c_Dados: codigos C(10), descricaos C(60), situas N(1,0)
388:         * O BO usa ZAP+APPEND para preservar as colunas existentes do grid

*-- Linhas 403 a 412:
403:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
404:         loc_oGrid = loc_oPagina.grd_4c_Lista
405: 
406:         loc_oGrid.Top                 = 164
407:         loc_oGrid.Left                = 12
408:         loc_oGrid.Width               = 971
409:         loc_oGrid.Height              = 445
410:         loc_oGrid.FontName            = "Verdana"
411:         loc_oGrid.FontSize            = 8
412:         loc_oGrid.ForeColor           = RGB(90, 90, 90)

*-- Linhas 427 a 439:
427:         *-- Configurar colunas APOS RecordSource
428:         loc_oGrid.Column1.ControlSource        = "cursor_4c_Dados.codigos"
429:         loc_oGrid.Column1.Width                = 80
430:         loc_oGrid.Column1.Header1.Caption      = "C" + CHR(243) + "digo"
431:         loc_oGrid.Column1.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
432:         loc_oGrid.Column2.ControlSource        = "cursor_4c_Dados.descricaos"
433:         loc_oGrid.Column2.Width                = 400
434:         loc_oGrid.Column2.Header1.Caption      = "Descri" + CHR(231) + CHR(227) + "o"
435:         loc_oGrid.Column2.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
436: 
437:         *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
438:         THIS.TornarControlesVisiveis(loc_oPagina)
439:     ENDPROC

*-- Linhas 453 a 478:
453:         *----------------------------------------------------------------------
454:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
455:         WITH loc_oPagina.cnt_4c_BotoesAcao
456:             .Top         = 33
457:             .Left        = 837
458:             .Width       = 160
459:             .Height      = 85
460:             .BackStyle = 1
461:             .BackColor = RGB(53, 53, 53)
462:             .BorderStyle = 0
463:             .Visible     = .T.
464:         ENDWITH
465: 
466:         *-- Botao Confirmar (Salvar)
467:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
468:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
469:             .Caption         = "Confirmar"
470:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
471:             .PicturePosition = 13
472:             .Top             = 5
473:             .Left            = 5
474:             .Width           = 75
475:             .Height          = 75
476:             .BackColor       = RGB(255, 255, 255)
477:             .ForeColor       = RGB(90, 90, 90)
478:             .FontName        = "Comic Sans MS"

*-- Linhas 485 a 502:
485:             .WordWrap        = .T.
486:             .AutoSize        = .F.
487:         ENDWITH
488:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
489: 
490:         *-- Botao Cancelar
491:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
492:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
493:             .Caption         = "Cancelar"
494:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
495:             .PicturePosition = 13
496:             .Top             = 5
497:             .Left            = 80
498:             .Width           = 75
499:             .Height          = 75
500:             .BackColor       = RGB(255, 255, 255)
501:             .ForeColor       = RGB(90, 90, 90)
502:             .FontName        = "Comic Sans MS"

*-- Linhas 509 a 546:
509:             .WordWrap        = .T.
510:             .AutoSize        = .F.
511:         ENDWITH
512:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
513: 
514:         *----------------------------------------------------------------------
515:         * PageFrame interno (PagDados) - 2 sub-paginas com campos fiscais
516:         * Top original=120, com compensacao +29 = 149
517:         * Page1: Dados Principais + Integracao Contabil/Fiscal
518:         * Page2: Integracao Contabil e Integracao Fiscal
519:         *----------------------------------------------------------------------
520:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
521:         WITH loc_oPagina.pgf_4c_PagDados
522:             .PageCount  = 2
523:             .Top        = 149
524:             .Left       = -1
525:             .Width      = 998
526:             .Height     = 476
527:             .Tabs       = .F.
528:             .Page1.Caption   = "DadosPrincipais"
529:             .Page2.Caption   = "Integracao"
530:             .Page1.BackColor = RGB(234, 232, 228)
531:             .Page2.BackColor = RGB(234, 232, 228)
532:         ENDWITH
533:         loc_oPagina.pgf_4c_PagDados.Visible = .T.
534: 
535:         *-- Configurar campos das sub-paginas de dados
536:         THIS.ConfigurarPaginaDadosPage1()
537:         THIS.ConfigurarPaginaDadosPage2()
538: 
539:         *-- Tornar controles visiveis
540:         THIS.TornarControlesVisiveis(loc_oPagina)
541:         *-- Fwcheckbox2 (SomaIcmFrete) tem Visible=.F. no original; reforcar
542:         THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.chk_4c_SomaIcmFrete.Visible = .F.
543:     ENDPROC
544: 
545:     *==========================================================================
546:     * CarregarLista - Carrega registros no grid da Page1

*-- Linhas 567 a 579:
567:                         *-- ControlSource e Headers APOS RecordSource
568:                         loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
569:                         loc_oGrid.Column1.Width            = 80
570:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
571:                         loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
572:                         loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
573:                         loc_oGrid.Column2.Width            = 400
574:                         loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
575:                         loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
576:                         THIS.FormatarGridLista(loc_oGrid)
577:                         loc_lResultado = .T.
578:                     ELSE
579:                         loc_lResultado = .F.

*-- Linhas 1168 a 1176:
1168:             loc_oPag1.txt_4c_IPIEnq.Value   = ALLTRIM(loc_oBO.this_cIpienq)
1169:             loc_oPag1.txt_4c_MotDeson.Value = ALLTRIM(loc_oBO.this_cMotdeson)
1170: 
1171:             *-- CheckBoxes (N(1,0) ? 1/0)
1172:             loc_oPag1.chk_4c_FreteICM.Value  = loc_oBO.this_nFrticms
1173:             loc_oPag1.chk_4c_SegICM.Value    = loc_oBO.this_nSegicms
1174:             loc_oPag1.chk_4c_DespICM.Value   = loc_oBO.this_nDesicms
1175:             loc_oPag1.chk_4c_IcmsNF.Value    = loc_oBO.this_nIncicmnfs
1176:             loc_oPag1.chk_4c_SomaIcmFrete.Value = loc_oBO.this_nSomaicmfrete

*-- Linhas 1314 a 1322:
1314:             loc_oBO.this_cIpienq    = ALLTRIM(loc_oPag1.txt_4c_IPIEnq.Value)
1315:             loc_oBO.this_cMotdeson  = ALLTRIM(loc_oPag1.txt_4c_MotDeson.Value)
1316: 
1317:             *-- CheckBoxes ? N(1,0)
1318:             loc_oBO.this_nFrticms   = loc_oPag1.chk_4c_FreteICM.Value
1319:             loc_oBO.this_nSegicms   = loc_oPag1.chk_4c_SegICM.Value
1320:             loc_oBO.this_nDesicms   = loc_oPag1.chk_4c_DespICM.Value
1321:             loc_oBO.this_nIncicmnfs = loc_oPag1.chk_4c_IcmsNF.Value
1322:             loc_oBO.this_nSomaicmfrete = loc_oPag1.chk_4c_SomaIcmFrete.Value

*-- Linhas 1441 a 2196:
1441:             *-- Shapes (separadores horizontais/vertical)
1442:             loc_oPag1.AddObject("shp_4c_shp01", "Shape")
1443:             WITH loc_oPag1.shp_4c_shp01
1444:                 .Top = 92
1445:                 .Left = 3
1446:                 .Height = 1
1447:                 .Width = 984
1448:                 .BackStyle = 0
1449:                 .BorderStyle = 1
1450:                 .BorderWidth = 1
1451:                 .BorderColor = RGB(100,100,100)
1452:             ENDWITH
1453: 
1454:             loc_oPag1.AddObject("shp_4c_shp03", "Shape")
1455:             WITH loc_oPag1.shp_4c_shp03
1456:                 .Top = 236
1457:                 .Left = 3
1458:                 .Height = 1
1459:                 .Width = 984
1460:                 .BackStyle = 0
1461:                 .BorderStyle = 1
1462:                 .BorderWidth = 1
1463:                 .BorderColor = RGB(100,100,100)
1464:             ENDWITH
1465: 
1466:             loc_oPag1.AddObject("shp_4c_Shape1", "Shape")
1467:             WITH loc_oPag1.shp_4c_Shape1
1468:                 .Top = 243
1469:                 .Left = 488
1470:                 .Height = 206
1471:                 .Width = 0
1472:                 .BackStyle = 0
1473:                 .BorderStyle = 1
1474:                 .BorderWidth = 1
1475:             ENDWITH
1476: 
1477:             *-- Labels
1478:             loc_oPag1.AddObject("lbl_4c_Say1", "Label")
1479:             WITH loc_oPag1.lbl_4c_Say1
1480:                 .Caption = "C" + CHR(243) + "digo :"
1481:                 .Top = 11
1482:                 .Left = 91
1483:                 .Height = 15
1484:                 .Width = 42
1485:                 .FontName = "Tahoma"
1486:                 .FontSize = 8
1487:                 .FontBold = .F.
1488:                 .ForeColor = RGB(90,90,90)
1489:                 .BackStyle = 0
1490:             ENDWITH
1491: 
1492:             loc_oPag1.AddObject("lbl_4c_Say2", "Label")
1493:             WITH loc_oPag1.lbl_4c_Say2
1494:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
1495:                 .Top = 38
1496:                 .Left = 23
1497:                 .Height = 15
1498:                 .Width = 110
1499:                 .FontName = "Tahoma"
1500:                 .FontSize = 8
1501:                 .FontBold = .F.
1502:                 .ForeColor = RGB(90,90,90)
1503:                 .BackStyle = 0
1504:             ENDWITH
1505: 
1506:             loc_oPag1.AddObject("lbl_4c_Say29", "Label")
1507:             WITH loc_oPag1.lbl_4c_Say29
1508:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
1509:                 .Top = 65
1510:                 .Left = 33
1511:                 .Height = 15
1512:                 .Width = 100
1513:                 .FontName = "Tahoma"
1514:                 .FontSize = 8
1515:                 .FontBold = .F.
1516:                 .ForeColor = RGB(90,90,90)
1517:                 .BackStyle = 0
1518:             ENDWITH
1519: 
1520:             loc_oPag1.AddObject("lbl_4c_Say24", "Label")
1521:             WITH loc_oPag1.lbl_4c_Say24
1522:                 .Caption = "Digitos Para NF :"
1523:                 .Top = 12
1524:                 .Left = 848
1525:                 .Width = 82
1526:                 .Height = 15
1527:                 .FontName = "Tahoma"
1528:                 .FontSize = 8
1529:                 .FontBold = .F.
1530:                 .ForeColor = RGB(90,90,90)
1531:                 .BackStyle = 0
1532:             ENDWITH
1533: 
1534:             loc_oPag1.AddObject("lbl_4c_Say37", "Label")
1535:             WITH loc_oPag1.lbl_4c_Say37
1536:                 .Caption = "Tipo :"
1537:                 .Top = 12
1538:                 .Left = 616
1539:                 .Width = 35
1540:                 .Height = 15
1541:                 .FontName = "Verdana"
1542:                 .FontSize = 8
1543:                 .FontBold = .F.
1544:                 .ForeColor = RGB(224,235,235)
1545:                 .BackStyle = 0
1546:             ENDWITH
1547: 
1548:             loc_oPag1.AddObject("lbl_4c_Say3", "Label")
1549:             WITH loc_oPag1.lbl_4c_Say3
1550:                 .Caption = "Opera" + CHR(231) + CHR(227) + "o :"
1551:                 .Top = 11
1552:                 .Left = 393
1553:                 .Height = 15
1554:                 .Width = 56
1555:                 .FontName = "Tahoma"
1556:                 .FontSize = 8
1557:                 .FontBold = .F.
1558:                 .ForeColor = RGB(90,90,90)
1559:                 .BackStyle = 0
1560:             ENDWITH
1561: 
1562:             loc_oPag1.AddObject("lbl_4c_Say49", "Label")
1563:             WITH loc_oPag1.lbl_4c_Say49
1564:                 .Caption = "CFOP ST60:"
1565:                 .Top = 102
1566:                 .Left = 614
1567:                 .Height = 15
1568:                 .Width = 60
1569:                 .FontName = "Tahoma"
1570:                 .FontSize = 8
1571:                 .FontBold = .F.
1572:                 .ForeColor = RGB(90,90,90)
1573:                 .BackStyle = 0
1574:             ENDWITH
1575: 
1576:             loc_oPag1.AddObject("lbl_4c_Say11", "Label")
1577:             WITH loc_oPag1.lbl_4c_Say11
1578:                 .Caption = "CFOP Subst.Trib.:"
1579:                 .Top = 102
1580:                 .Left = 791
1581:                 .Height = 15
1582:                 .Width = 89
1583:                 .FontName = "Tahoma"
1584:                 .FontSize = 8
1585:                 .FontBold = .F.
1586:                 .ForeColor = RGB(90,90,90)
1587:                 .BackStyle = 0
1588:             ENDWITH
1589: 
1590:             loc_oPag1.AddObject("lbl_4c_Say4", "Label")
1591:             WITH loc_oPag1.lbl_4c_Say4
1592:                 .Caption = "I C M S :"
1593:                 .Top = 105
1594:                 .Left = 90
1595:                 .Height = 15
1596:                 .Width = 43
1597:                 .FontName = "Tahoma"
1598:                 .FontSize = 8
1599:                 .FontBold = .F.
1600:                 .ForeColor = RGB(90,90,90)
1601:                 .BackStyle = 0
1602:             ENDWITH
1603: 
1604:             loc_oPag1.AddObject("lbl_4c_Say14", "Label")
1605:             WITH loc_oPag1.lbl_4c_Say14
1606:                 .Caption = "ICMS Sobre :"
1607:                 .Top = 104
1608:                 .Left = 481
1609:                 .Height = 15
1610:                 .Width = 65
1611:                 .FontName = "Tahoma"
1612:                 .FontSize = 8
1613:                 .FontBold = .F.
1614:                 .ForeColor = RGB(90,90,90)
1615:                 .BackStyle = 0
1616:             ENDWITH
1617: 
1618:             loc_oPag1.AddObject("lbl_4c_Say31", "Label")
1619:             WITH loc_oPag1.lbl_4c_Say31
1620:                 .Caption = "Sobre Desconto :"
1621:                 .Top = 131
1622:                 .Left = 48
1623:                 .Height = 15
1624:                 .Width = 85
1625:                 .FontName = "Tahoma"
1626:                 .FontSize = 8
1627:                 .FontBold = .F.
1628:                 .ForeColor = RGB(90,90,90)
1629:                 .BackStyle = 0
1630:             ENDWITH
1631: 
1632:             loc_oPag1.AddObject("lbl_4c_Say25", "Label")
1633:             WITH loc_oPag1.lbl_4c_Say25
1634:                 .Caption = "Inclui IPI na Base :"
1635:                 .Top = 132
1636:                 .Left = 285
1637:                 .Height = 15
1638:                 .Width = 92
1639:                 .FontName = "Tahoma"
1640:                 .FontSize = 8
1641:                 .FontBold = .F.
1642:                 .ForeColor = RGB(90,90,90)
1643:                 .BackStyle = 0
1644:             ENDWITH
1645: 
1646:             loc_oPag1.AddObject("lbl_4c_Say19", "Label")
1647:             WITH loc_oPag1.lbl_4c_Say19
1648:                 .Caption = "CFOP Destino :"
1649:                 .Top = 131
1650:                 .Left = 805
1651:                 .Height = 15
1652:                 .Width = 75
1653:                 .FontName = "Tahoma"
1654:                 .FontSize = 8
1655:                 .FontBold = .F.
1656:                 .ForeColor = RGB(90,90,90)
1657:                 .BackStyle = 0
1658:             ENDWITH
1659: 
1660:             loc_oPag1.AddObject("lbl_4c_Say10", "Label")
1661:             WITH loc_oPag1.lbl_4c_Say10
1662:                 .Caption = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
1663:                 .Top = 157
1664:                 .Left = 34
1665:                 .Height = 15
1666:                 .Width = 99
1667:                 .FontName = "Tahoma"
1668:                 .FontSize = 8
1669:                 .FontBold = .F.
1670:                 .ForeColor = RGB(90,90,90)
1671:                 .BackStyle = 0
1672:             ENDWITH
1673: 
1674:             loc_oPag1.AddObject("lbl_4c_Say12", "Label")
1675:             WITH loc_oPag1.lbl_4c_Say12
1676:                 .Caption = "Base Substitui" + CHR(231) + CHR(227) + "o :"
1677:                 .Top = 157
1678:                 .Left = 284
1679:                 .Height = 15
1680:                 .Width = 93
1681:                 .FontName = "Tahoma"
1682:                 .FontSize = 8
1683:                 .FontBold = .F.
1684:                 .ForeColor = RGB(90,90,90)
1685:             ENDWITH
1686: 
1687:             loc_oPag1.AddObject("lbl_4c_Say28", "Label")
1688:             WITH loc_oPag1.lbl_4c_Say28
1689:                 .Caption = "CFOP Transporte :"
1690:                 .Top = 157
1691:                 .Left = 788
1692:                 .Height = 15
1693:                 .Width = 92
1694:                 .FontName = "Tahoma"
1695:                 .FontSize = 8
1696:                 .FontBold = .F.
1697:                 .ForeColor = RGB(90,90,90)
1698:                 .BackStyle = 0
1699:             ENDWITH
1700: 
1701:             loc_oPag1.AddObject("lbl_4c_Say22", "Label")
1702:             WITH loc_oPag1.lbl_4c_Say22
1703:                 .Caption = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
1704:                 .Top = 183
1705:                 .Left = 51
1706:                 .Width = 82
1707:                 .Height = 15
1708:                 .FontName = "Tahoma"
1709:                 .FontSize = 8
1710:                 .FontBold = .F.
1711:                 .ForeColor = RGB(90,90,90)
1712:                 .BackStyle = 0
1713:             ENDWITH
1714: 
1715:             loc_oPag1.AddObject("lbl_4c_Say6", "Label")
1716:             WITH loc_oPag1.lbl_4c_Say6
1717:                 .Caption = "Contribuinte :"
1718:                 .Top = 183
1719:                 .Left = 812
1720:                 .Height = 15
1721:                 .Width = 68
1722:                 .FontName = "Tahoma"
1723:                 .FontSize = 8
1724:                 .FontBold = .F.
1725:                 .ForeColor = RGB(90,90,90)
1726:                 .BackStyle = 0
1727:             ENDWITH
1728: 
1729:             loc_oPag1.AddObject("lbl_4c_Say36", "Label")
1730:             WITH loc_oPag1.lbl_4c_Say36
1731:                 .Caption = "ICMS Incluso no Pre" + CHR(231) + "o:"
1732:                 .Top = 182
1733:                 .Left = 264
1734:                 .Height = 15
1735:                 .Width = 113
1736:                 .FontName = "Tahoma"
1737:                 .FontSize = 8
1738:                 .FontBold = .F.
1739:                 .ForeColor = RGB(90,90,90)
1740:                 .BackStyle = 0
1741:             ENDWITH
1742: 
1743:             loc_oPag1.AddObject("lbl_4c_Say23", "Label")
1744:             WITH loc_oPag1.lbl_4c_Say23
1745:                 .Caption = "Venda Consumidor :"
1746:                 .Top = 207
1747:                 .Left = 35
1748:                 .Height = 15
1749:                 .Width = 98
1750:                 .FontName = "Tahoma"
1751:                 .FontSize = 8
1752:                 .FontBold = .F.
1753:                 .ForeColor = RGB(90,90,90)
1754:             ENDWITH
1755: 
1756:             loc_oPag1.AddObject("lbl_4c_Say50", "Label")
1757:             WITH loc_oPag1.lbl_4c_Say50
1758:                 .Caption = "Mot Desoner" + CHR(231) + CHR(227) + "o ICMS :"
1759:                 .Top = 206
1760:                 .Left = 256
1761:                 .Width = 121
1762:                 .Height = 15
1763:                 .FontName = "Tahoma"
1764:                 .FontSize = 8
1765:                 .FontBold = .F.
1766:                 .ForeColor = RGB(90,90,90)
1767:                 .BackStyle = 0
1768:             ENDWITH
1769: 
1770:             loc_oPag1.AddObject("lbl_4c_Say21", "Label")
1771:             WITH loc_oPag1.lbl_4c_Say21
1772:                 .Caption = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
1773:                 .Top = 210
1774:                 .Left = 652
1775:                 .Height = 15
1776:                 .Width = 228
1777:                 .FontName = "Verdana"
1778:                 .FontSize = 8
1779:                 .FontBold = .F.
1780:                 .ForeColor = RGB(90,90,90)
1781:                 .BackStyle = 0
1782:             ENDWITH
1783: 
1784:             loc_oPag1.AddObject("lbl_4c_Say13", "Label")
1785:             WITH loc_oPag1.lbl_4c_Say13
1786:                 .Caption = "%"
1787:                 .Top = 207
1788:                 .Left = 219
1789:                 .Height = 15
1790:                 .Width = 13
1791:                 .FontName = "Tahoma"
1792:                 .FontSize = 8
1793:                 .FontBold = .F.
1794:                 .ForeColor = RGB(90,90,90)
1795:             ENDWITH
1796: 
1797:             loc_oPag1.AddObject("lbl_4c_Say38", "Label")
1798:             WITH loc_oPag1.lbl_4c_Say38
1799:                 .Caption = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1800:                 .Top = 246
1801:                 .Left = 498
1802:                 .Height = 15
1803:                 .Width = 167
1804:                 .FontName = "Verdana"
1805:                 .FontSize = 8
1806:                 .FontBold = .T.
1807:                 .ForeColor = RGB(90,90,90)
1808:                 .BackStyle = 0
1809:             ENDWITH
1810: 
1811:             loc_oPag1.AddObject("lbl_4c_Say8", "Label")
1812:             WITH loc_oPag1.lbl_4c_Say8
1813:                 .Caption = "I P I :"
1814:                 .Top = 267
1815:                 .Left = 104
1816:                 .Height = 15
1817:                 .Width = 29
1818:                 .FontName = "Tahoma"
1819:                 .FontSize = 8
1820:                 .FontBold = .F.
1821:                 .ForeColor = RGB(90,90,90)
1822:                 .BackStyle = 0
1823:             ENDWITH
1824: 
1825:             loc_oPag1.AddObject("lbl_4c_Say7", "Label")
1826:             WITH loc_oPag1.lbl_4c_Say7
1827:                 .Caption = "IPI Importa" + CHR(231) + CHR(227) + "o :"
1828:                 .Top = 267
1829:                 .Left = 296
1830:                 .Height = 15
1831:                 .Width = 81
1832:                 .FontName = "Tahoma"
1833:                 .FontSize = 8
1834:                 .FontBold = .F.
1835:                 .ForeColor = RGB(90,90,90)
1836:                 .BackStyle = 0
1837:             ENDWITH
1838: 
1839:             loc_oPag1.AddObject("lbl_4c_Say30", "Label")
1840:             WITH loc_oPag1.lbl_4c_Say30
1841:                 .Caption = "C" + CHR(243) + "digo IPI Sit. Trib.:"
1842:                 .Top = 269
1843:                 .Left = 589
1844:                 .Width = 100
1845:                 .Height = 15
1846:                 .FontName = "Tahoma"
1847:                 .FontSize = 8
1848:                 .FontBold = .F.
1849:                 .ForeColor = RGB(90,90,90)
1850:                 .BackStyle = 0
1851:             ENDWITH
1852: 
1853:             loc_oPag1.AddObject("lbl_4c_Say27", "Label")
1854:             WITH loc_oPag1.lbl_4c_Say27
1855:                 .Caption = "Destaca ICMS na Nota Fiscal (S/N) :"
1856:                 .Top = 270
1857:                 .Left = 769
1858:                 .Height = 15
1859:                 .Width = 174
1860:                 .FontName = "Tahoma"
1861:                 .FontSize = 8
1862:                 .FontBold = .F.
1863:                 .ForeColor = RGB(90,90,90)
1864:             ENDWITH
1865: 
1866:             loc_oPag1.AddObject("lbl_4c_Say15", "Label")
1867:             WITH loc_oPag1.lbl_4c_Say15
1868:                 .Caption = "Al" + CHR(237) + "quota :"
1869:                 .Top = 293
1870:                 .Left = 85
1871:                 .Height = 15
1872:                 .Width = 48
1873:                 .FontName = "Tahoma"
1874:                 .FontSize = 8
1875:                 .FontBold = .F.
1876:                 .ForeColor = RGB(90,90,90)
1877:                 .BackStyle = 0
1878:             ENDWITH
1879: 
1880:             loc_oPag1.AddObject("lbl_4c_Say32", "Label")
1881:             WITH loc_oPag1.lbl_4c_Say32
1882:                 .Caption = "Retira IPI do $ :"
1883:                 .Top = 293
1884:                 .Left = 298
1885:                 .Height = 15
1886:                 .Width = 79
1887:                 .FontName = "Tahoma"
1888:                 .FontSize = 8
1889:                 .FontBold = .F.
1890:                 .ForeColor = RGB(90,90,90)
1891:                 .BackStyle = 0
1892:             ENDWITH
1893: 
1894:             loc_oPag1.AddObject("lbl_4c_Say20", "Label")
1895:             WITH loc_oPag1.lbl_4c_Say20
1896:                 .Caption = "N" + CHR(227) + "o Creditado :"
1897:                 .Top = 319
1898:                 .Left = 55
1899:                 .Height = 15
1900:                 .Width = 78
1901:                 .FontName = "Tahoma"
1902:                 .FontSize = 8
1903:                 .FontBold = .F.
1904:                 .ForeColor = RGB(90,90,90)
1905:             ENDWITH
1906: 
1907:             loc_oPag1.AddObject("lbl_4c_Say17", "Label")
1908:             WITH loc_oPag1.lbl_4c_Say17
1909:                 .Caption = "Acres/Desc na Base :"
1910:                 .Top = 319
1911:                 .Left = 273
1912:                 .Height = 15
1913:                 .Width = 104
1914:                 .FontName = "Tahoma"
1915:                 .FontSize = 8
1916:                 .FontBold = .F.
1917:                 .ForeColor = RGB(90,90,90)
1918:                 .BackStyle = 0
1919:             ENDWITH
1920: 
1921:             loc_oPag1.AddObject("lbl_4c_Say33", "Label")
1922:             WITH loc_oPag1.lbl_4c_Say33
1923:                 .Caption = "C" + CHR(243) + "digo PIS Sit. Trib.:"
1924:                 .Top = 295
1925:                 .Left = 587
1926:                 .Width = 102
1927:                 .Height = 15
1928:                 .FontName = "Tahoma"
1929:                 .FontSize = 8
1930:                 .FontBold = .F.
1931:                 .ForeColor = RGB(90,90,90)
1932:                 .BackStyle = 0
1933:             ENDWITH
1934: 
1935:             loc_oPag1.AddObject("lbl_4c_Say34", "Label")
1936:             WITH loc_oPag1.lbl_4c_Say34
1937:                 .Caption = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
1938:                 .Top = 319
1939:                 .Left = 565
1940:                 .Width = 124
1941:                 .Height = 15
1942:                 .FontName = "Tahoma"
1943:                 .FontSize = 8
1944:                 .FontBold = .F.
1945:                 .ForeColor = RGB(90,90,90)
1946:                 .BackStyle = 0
1947:             ENDWITH
1948: 
1949:             loc_oPag1.AddObject("lbl_4c_Say39", "Label")
1950:             WITH loc_oPag1.lbl_4c_Say39
1951:                 .Caption = "Al" + CHR(237) + "quota do PIS :"
1952:                 .Top = 295
1953:                 .Left = 827
1954:                 .Height = 15
1955:                 .Width = 82
1956:                 .FontName = "Tahoma"
1957:                 .FontSize = 8
1958:                 .FontBold = .F.
1959:                 .ForeColor = RGB(90,90,90)
1960:                 .BackStyle = 0
1961:             ENDWITH
1962: 
1963:             loc_oPag1.AddObject("lbl_4c_Say40", "Label")
1964:             WITH loc_oPag1.lbl_4c_Say40
1965:                 .Caption = "%"
1966:                 .Top = 295
1967:                 .Left = 971
1968:                 .Height = 15
1969:                 .Width = 14
1970:                 .FontName = "Verdana"
1971:                 .FontSize = 8
1972:                 .FontBold = .F.
1973:                 .ForeColor = RGB(224,235,235)
1974:                 .BackStyle = 0
1975:             ENDWITH
1976: 
1977:             loc_oPag1.AddObject("lbl_4c_Say41", "Label")
1978:             WITH loc_oPag1.lbl_4c_Say41
1979:                 .Caption = "Al" + CHR(237) + "quota do COFINS :"
1980:                 .Top = 319
1981:                 .Left = 785
1982:                 .Height = 15
1983:                 .Width = 124
1984:                 .FontName = "Verdana"
1985:                 .FontSize = 8
1986:                 .FontBold = .F.
1987:                 .ForeColor = RGB(90,90,90)
1988:                 .BackStyle = 0
1989:             ENDWITH
1990: 
1991:             loc_oPag1.AddObject("lbl_4c_Say42", "Label")
1992:             WITH loc_oPag1.lbl_4c_Say42
1993:                 .Caption = "%"
1994:                 .Top = 319
1995:                 .Left = 971
1996:                 .Height = 15
1997:                 .Width = 14
1998:                 .FontName = "Verdana"
1999:                 .FontSize = 8
2000:                 .FontBold = .F.
2001:                 .ForeColor = RGB(224,235,235)
2002:                 .BackStyle = 0
2003:             ENDWITH
2004: 
2005:             loc_oPag1.AddObject("lbl_4c_Say5", "Label")
2006:             WITH loc_oPag1.lbl_4c_Say5
2007:                 .Caption = "Base de C" + CHR(225) + "lculo :"
2008:                 .Top = 345
2009:                 .Left = 49
2010:                 .Height = 15
2011:                 .Width = 84
2012:                 .FontName = "Tahoma"
2013:                 .FontSize = 8
2014:                 .FontBold = .F.
2015:                 .ForeColor = RGB(90,90,90)
2016:                 .BackStyle = 0
2017:             ENDWITH
2018: 
2019:             loc_oPag1.AddObject("lbl_4c_Say26", "Label")
2020:             WITH loc_oPag1.lbl_4c_Say26
2021:                 .Caption = "Incluir ICMS :"
2022:                 .Top = 105
2023:                 .Left = 311
2024:                 .Height = 15
2025:                 .Width = 66
2026:                 .FontName = "Tahoma"
2027:                 .FontSize = 8
2028:                 .FontBold = .F.
2029:                 .ForeColor = RGB(90,90,90)
2030:                 .BackStyle = 0
2031:             ENDWITH
2032: 
2033:             loc_oPag1.AddObject("lbl_4c_Say35", "Label")
2034:             WITH loc_oPag1.lbl_4c_Say35
2035:                 .Caption = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
2036:                 .Top = 343
2037:                 .Left = 562
2038:                 .Width = 127
2039:                 .Height = 15
2040:                 .FontName = "Tahoma"
2041:                 .FontSize = 8
2042:                 .FontBold = .F.
2043:                 .ForeColor = RGB(90,90,90)
2044:                 .BackStyle = 0
2045:             ENDWITH
2046: 
2047:             loc_oPag1.AddObject("lbl_4c_Say44", "Label")
2048:             WITH loc_oPag1.lbl_4c_Say44
2049:                 .Caption = "Al" + CHR(237) + "quota do ISSQN :"
2050:                 .Top = 343
2051:                 .Left = 792
2052:                 .Height = 15
2053:                 .Width = 117
2054:                 .FontName = "Verdana"
2055:                 .FontSize = 8
2056:                 .FontBold = .F.
2057:                 .ForeColor = RGB(90,90,90)
2058:                 .BackStyle = 0
2059:             ENDWITH
2060: 
2061:             loc_oPag1.AddObject("lbl_4c_Say45", "Label")
2062:             WITH loc_oPag1.lbl_4c_Say45
2063:                 .Caption = "%"
2064:                 .Top = 343
2065:                 .Left = 971
2066:                 .Height = 15
2067:                 .Width = 14
2068:                 .FontName = "Verdana"
2069:                 .FontSize = 8
2070:                 .FontBold = .F.
2071:                 .ForeColor = RGB(224,235,235)
2072:                 .BackStyle = 0
2073:             ENDWITH
2074: 
2075:             loc_oPag1.AddObject("lbl_4c_Say16", "Label")
2076:             WITH loc_oPag1.lbl_4c_Say16
2077:                 .Caption = "IPI Sobre :"
2078:                 .Top = 395
2079:                 .Left = 69
2080:                 .Height = 15
2081:                 .Width = 54
2082:                 .FontName = "Tahoma"
2083:                 .FontSize = 8
2084:                 .FontBold = .F.
2085:                 .ForeColor = RGB(90,90,90)
2086:                 .BackStyle = 0
2087:             ENDWITH
2088: 
2089:             loc_oPag1.AddObject("lbl_4c_Say18", "Label")
2090:             WITH loc_oPag1.lbl_4c_Say18
2091:                 .Caption = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
2092:                 .Top = 371
2093:                 .Left = 77
2094:                 .Height = 15
2095:                 .Width = 250
2096:                 .FontName = "Tahoma"
2097:                 .FontSize = 8
2098:                 .FontBold = .F.
2099:                 .ForeColor = RGB(90,90,90)
2100:                 .BackStyle = 0
2101:             ENDWITH
2102: 
2103:             loc_oPag1.AddObject("lbl_4c_Say9", "Label")
2104:             WITH loc_oPag1.lbl_4c_Say9
2105:                 .Caption = "C" + CHR(243) + "digo Enquadramento IPI:"
2106:                 .Top = 366
2107:                 .Left = 554
2108:                 .Width = 135
2109:                 .Height = 15
2110:                 .FontName = "Tahoma"
2111:                 .FontSize = 8
2112:                 .FontBold = .F.
2113:                 .ForeColor = RGB(90,90,90)
2114:                 .BackStyle = 0
2115:             ENDWITH
2116: 
2117:             loc_oPag1.AddObject("lbl_4c_Say43", "Label")
2118:             WITH loc_oPag1.lbl_4c_Say43
2119:                 .Caption = "C" + CHR(243) + "digo de Trib. do ISSQN:"
2120:                 .Top = 390
2121:                 .Left = 561
2122:                 .Width = 128
2123:                 .Height = 15
2124:                 .FontName = "Tahoma"
2125:                 .FontSize = 8
2126:                 .FontBold = .F.
2127:                 .ForeColor = RGB(90,90,90)
2128:                 .BackStyle = 0
2129:             ENDWITH
2130: 
2131:             loc_oPag1.AddObject("lbl_4c_Say46", "Label")
2132:             WITH loc_oPag1.lbl_4c_Say46
2133:                 .Caption = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
2134:                 .Top = 425
2135:                 .Left = 556
2136:                 .Width = 133
2137:                 .Height = 15
2138:                 .FontName = "Tahoma"
2139:                 .FontSize = 8
2140:                 .FontBold = .F.
2141:                 .ForeColor = RGB(90,90,90)
2142:                 .BackStyle = 0
2143:             ENDWITH
2144: 
2145:             loc_oPag1.AddObject("lbl_4c_Say47", "Label")
2146:             WITH loc_oPag1.lbl_4c_Say47
2147:                 .Caption = "Al" + CHR(237) + "quota do II :"
2148:                 .Top = 425
2149:                 .Left = 820
2150:                 .Height = 15
2151:                 .Width = 89
2152:                 .FontName = "Verdana"
2153:                 .FontSize = 8
2154:                 .FontBold = .F.
2155:                 .ForeColor = RGB(90,90,90)
2156:                 .BackStyle = 0
2157:             ENDWITH
2158: 
2159:             loc_oPag1.AddObject("lbl_4c_Say48", "Label")
2160:             WITH loc_oPag1.lbl_4c_Say48
2161:                 .Caption = "%"
2162:                 .Top = 420
2163:                 .Left = 971
2164:                 .Height = 15
2165:                 .Width = 14
2166:                 .FontName = "Verdana"
2167:                 .FontSize = 8
2168:                 .FontBold = .F.
2169:                 .ForeColor = RGB(224,235,235)
2170:                 .BackStyle = 0
2171:             ENDWITH
2172: 
2173:             *-- TextBoxes
2174:             loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
2175:             WITH loc_oPag1.txt_4c_Codigo
2176:                 .Top = 7
2177:                 .Left = 136
2178:                 .Height = 24
2179:                 .Width = 91
2180:                 .FontName = "Tahoma"
2181:                 .FontSize = 8
2182:                 .SpecialEffect = 1
2183:                 .ForeColor = RGB(90,90,90)
2184:                 .BorderColor = RGB(100,100,100)
2185:                 .Value = ""
2186:             ENDWITH
2187: 
2188:             loc_oPag1.AddObject("txt_4c_Descricao", "TextBox")
2189:             WITH loc_oPag1.txt_4c_Descricao
2190:                 .Top = 34
2191:                 .Left = 136
2192:                 .Height = 24
2193:                 .Width = 430
2194:                 .FontName = "Tahoma"
2195:                 .FontSize = 8
2196:                 .SpecialEffect = 1

*-- Linhas 2203 a 2212:
2203: 
2204:             loc_oPag1.AddObject("txt_4c_Desc2s", "TextBox")
2205:             WITH loc_oPag1.txt_4c_Desc2s
2206:                 .Top = 61
2207:                 .Left = 136
2208:                 .Height = 24
2209:                 .Width = 430
2210:                 .FontName = "Tahoma"
2211:                 .FontSize = 8
2212:                 .SpecialEffect = 1

*-- Linhas 2219 a 2270:
2219: 
2220:             loc_oPag1.AddObject("txt_4c_CfoST60", "TextBox")
2221:             WITH loc_oPag1.txt_4c_CfoST60
2222:                 .Top = 101
2223:                 .Left = 690
2224:                 .Height = 23
2225:                 .Width = 82
2226:                 .FontName = "Tahoma"
2227:                 .FontSize = 8
2228:                 .SpecialEffect = 1
2229:                 .ForeColor = RGB(90,90,90)
2230:                 .BorderColor = RGB(100,100,100)
2231:                 .Value = ""
2232:             ENDWITH
2233: 
2234:             loc_oPag1.AddObject("txt_4c_CfoST", "TextBox")
2235:             WITH loc_oPag1.txt_4c_CfoST
2236:                 .Top = 101
2237:                 .Left = 887
2238:                 .Height = 23
2239:                 .Width = 82
2240:                 .FontName = "Tahoma"
2241:                 .FontSize = 8
2242:                 .SpecialEffect = 1
2243:                 .ForeColor = RGB(90,90,90)
2244:                 .BorderColor = RGB(100,100,100)
2245:                 .Value = ""
2246:             ENDWITH
2247: 
2248:             loc_oPag1.AddObject("txt_4c_CfoDest", "TextBox")
2249:             WITH loc_oPag1.txt_4c_CfoDest
2250:                 .Top = 127
2251:                 .Left = 887
2252:                 .Height = 23
2253:                 .Width = 82
2254:                 .FontName = "Tahoma"
2255:                 .FontSize = 8
2256:                 .SpecialEffect = 1
2257:                 .ForeColor = RGB(90,90,90)
2258:                 .BorderColor = RGB(100,100,100)
2259:                 .Value = ""
2260:             ENDWITH
2261: 
2262:             loc_oPag1.AddObject("txt_4c_Sittricm", "TextBox")
2263:             WITH loc_oPag1.txt_4c_Sittricm
2264:                 .Top = 179
2265:                 .Left = 136
2266:                 .Height = 22
2267:                 .Width = 31
2268:                 .FontName = "Tahoma"
2269:                 .FontSize = 8
2270:                 .SpecialEffect = 1

*-- Linhas 2276 a 2285:
2276: 
2277:             loc_oPag1.AddObject("txt_4c_AliqIVCs", "TextBox")
2278:             WITH loc_oPag1.txt_4c_AliqIVCs
2279:                 .Top = 203
2280:                 .Left = 136
2281:                 .Height = 23
2282:                 .Width = 82
2283:                 .FontName = "Tahoma"
2284:                 .FontSize = 8
2285:                 .SpecialEffect = 1

*-- Linhas 2291 a 2300:
2291: 
2292:             loc_oPag1.AddObject("txt_4c_MotDeson", "TextBox")
2293:             WITH loc_oPag1.txt_4c_MotDeson
2294:                 .Top = 203
2295:                 .Left = 381
2296:                 .Height = 23
2297:                 .Width = 26
2298:                 .FontName = "Tahoma"
2299:                 .FontSize = 8
2300:                 .SpecialEffect = 1

*-- Linhas 2307 a 2316:
2307: 
2308:             loc_oPag1.AddObject("txt_4c_IPICST", "TextBox")
2309:             WITH loc_oPag1.txt_4c_IPICST
2310:                 .Top = 266
2311:                 .Left = 691
2312:                 .Height = 23
2313:                 .Width = 26
2314:                 .FontName = "Tahoma"
2315:                 .FontSize = 8
2316:                 .SpecialEffect = 1

*-- Linhas 2323 a 2332:
2323: 
2324:             loc_oPag1.AddObject("txt_4c_PISCST", "TextBox")
2325:             WITH loc_oPag1.txt_4c_PISCST
2326:                 .Top = 291
2327:                 .Left = 691
2328:                 .Height = 23
2329:                 .Width = 26
2330:                 .FontName = "Tahoma"
2331:                 .FontSize = 8
2332:                 .SpecialEffect = 1

*-- Linhas 2339 a 2348:
2339: 
2340:             loc_oPag1.AddObject("txt_4c_COFCST", "TextBox")
2341:             WITH loc_oPag1.txt_4c_COFCST
2342:                 .Top = 315
2343:                 .Left = 691
2344:                 .Height = 23
2345:                 .Width = 26
2346:                 .FontName = "Tahoma"
2347:                 .FontSize = 8
2348:                 .SpecialEffect = 1

*-- Linhas 2355 a 2364:
2355: 
2356:             loc_oPag1.AddObject("txt_4c_ISSQNL", "TextBox")
2357:             WITH loc_oPag1.txt_4c_ISSQNL
2358:                 .Top = 339
2359:                 .Left = 691
2360:                 .Height = 23
2361:                 .Width = 42
2362:                 .FontName = "Tahoma"
2363:                 .FontSize = 8
2364:                 .SpecialEffect = 1

*-- Linhas 2371 a 2380:
2371: 
2372:             loc_oPag1.AddObject("txt_4c_IPIEnq", "TextBox")
2373:             WITH loc_oPag1.txt_4c_IPIEnq
2374:                 .Top = 363
2375:                 .Left = 691
2376:                 .Height = 23
2377:                 .Width = 26
2378:                 .FontName = "Tahoma"
2379:                 .FontSize = 8
2380:                 .SpecialEffect = 1

*-- Linhas 2386 a 2395:
2386: 
2387:             loc_oPag1.AddObject("txt_4c_Aliqs", "TextBox")
2388:             WITH loc_oPag1.txt_4c_Aliqs
2389:                 .Top = 289
2390:                 .Left = 136
2391:                 .Height = 23
2392:                 .Width = 82
2393:                 .FontName = "Tahoma"
2394:                 .FontSize = 8
2395:                 .SpecialEffect = 1

*-- Linhas 2401 a 2410:
2401: 
2402:             loc_oPag1.AddObject("txt_4c_BcST", "TextBox")
2403:             WITH loc_oPag1.txt_4c_BcST
2404:                 .Top = 153
2405:                 .Left = 380
2406:                 .Height = 23
2407:                 .Width = 82
2408:                 .FontName = "Tahoma"
2409:                 .FontSize = 8
2410:                 .SpecialEffect = 1

*-- Linhas 2416 a 2425:
2416: 
2417:             loc_oPag1.AddObject("txt_4c_BcIPI", "TextBox")
2418:             WITH loc_oPag1.txt_4c_BcIPI
2419:                 .Top = 341
2420:                 .Left = 380
2421:                 .Height = 23
2422:                 .Width = 82
2423:                 .FontName = "Tahoma"
2424:                 .FontSize = 8
2425:                 .SpecialEffect = 1

*-- Linhas 2431 a 2440:
2431: 
2432:             loc_oPag1.AddObject("txt_4c_AliqPIS", "TextBox")
2433:             WITH loc_oPag1.txt_4c_AliqPIS
2434:                 .Top = 291
2435:                 .Left = 916
2436:                 .Height = 23
2437:                 .Width = 52
2438:                 .FontName = "Tahoma"
2439:                 .FontSize = 8
2440:                 .SpecialEffect = 1

*-- Linhas 2446 a 2455:
2446: 
2447:             loc_oPag1.AddObject("txt_4c_AliqCofins", "TextBox")
2448:             WITH loc_oPag1.txt_4c_AliqCofins
2449:                 .Top = 315
2450:                 .Left = 916
2451:                 .Height = 23
2452:                 .Width = 52
2453:                 .FontName = "Tahoma"
2454:                 .FontSize = 8
2455:                 .SpecialEffect = 1

*-- Linhas 2461 a 2470:
2461: 
2462:             loc_oPag1.AddObject("txt_4c_AliqISSQN", "TextBox")
2463:             WITH loc_oPag1.txt_4c_AliqISSQN
2464:                 .Top = 339
2465:                 .Left = 916
2466:                 .Height = 23
2467:                 .Width = 52
2468:                 .FontName = "Tahoma"
2469:                 .FontSize = 8
2470:                 .SpecialEffect = 1

*-- Linhas 2476 a 2485:
2476: 
2477:             loc_oPag1.AddObject("txt_4c_AliqII", "TextBox")
2478:             WITH loc_oPag1.txt_4c_AliqII
2479:                 .Top = 421
2480:                 .Left = 916
2481:                 .Height = 23
2482:                 .Width = 52
2483:                 .FontName = "Tahoma"
2484:                 .FontSize = 8
2485:                 .SpecialEffect = 1

*-- Linhas 2491 a 2500:
2491: 
2492:             loc_oPag1.AddObject("txt_4c_Gergia1", "TextBox")
2493:             WITH loc_oPag1.txt_4c_Gergia1
2494:                 .Top = 265
2495:                 .Left = 948
2496:                 .Height = 23
2497:                 .Width = 20
2498:                 .FontName = "Tahoma"
2499:                 .FontSize = 8
2500:                 .SpecialEffect = 1

*-- Linhas 2508 a 2517:
2508:             *-- Spinner (Ndigito)
2509:             loc_oPag1.AddObject("spn_4c_Ndigito", "Spinner")
2510:             WITH loc_oPag1.spn_4c_Ndigito
2511:                 .Top = 7
2512:                 .Left = 947
2513:                 .Height = 24
2514:                 .Width = 40
2515:                 .FontName = "Tahoma"
2516:                 .FontSize = 8
2517:                 .SpecialEffect = 1

*-- Linhas 2527 a 2536:
2527:             *-- ComboBoxes
2528:             loc_oPag1.AddObject("cmb_4c_Operacao", "ComboBox")
2529:             WITH loc_oPag1.cmb_4c_Operacao
2530:                 .Top = 7
2531:                 .Left = 459
2532:                 .Height = 24
2533:                 .Width = 107
2534:                 .FontName = "Tahoma"
2535:                 .FontSize = 8
2536:                 .SpecialEffect = 1

*-- Linhas 2543 a 2552:
2543: 
2544:             loc_oPag1.AddObject("cmb_4c_Tipo", "ComboBox")
2545:             WITH loc_oPag1.cmb_4c_Tipo
2546:                 .Top = 7
2547:                 .Left = 653
2548:                 .Height = 24
2549:                 .Width = 151
2550:                 .FontName = "Tahoma"
2551:                 .FontSize = 8
2552:                 .SpecialEffect = 1

*-- Linhas 2559 a 2568:
2559: 
2560:             loc_oPag1.AddObject("cmb_4c_Icms", "ComboBox")
2561:             WITH loc_oPag1.cmb_4c_Icms
2562:                 .Top = 101
2563:                 .Left = 136
2564:                 .Height = 23
2565:                 .Width = 82
2566:                 .FontName = "Tahoma"
2567:                 .FontSize = 8
2568:                 .SpecialEffect = 1

*-- Linhas 2575 a 2584:
2575: 
2576:             loc_oPag1.AddObject("cmb_4c_SobreDesc", "ComboBox")
2577:             WITH loc_oPag1.cmb_4c_SobreDesc
2578:                 .Top = 127
2579:                 .Left = 136
2580:                 .Height = 23
2581:                 .Width = 82
2582:                 .FontName = "Tahoma"
2583:                 .FontSize = 8
2584:                 .SpecialEffect = 1

*-- Linhas 2591 a 2600:
2591: 
2592:             loc_oPag1.AddObject("cmb_4c_IpiIcms", "ComboBox")
2593:             WITH loc_oPag1.cmb_4c_IpiIcms
2594:                 .Top = 127
2595:                 .Left = 380
2596:                 .Height = 23
2597:                 .Width = 82
2598:                 .FontName = "Tahoma"
2599:                 .FontSize = 8
2600:                 .SpecialEffect = 1

*-- Linhas 2607 a 2616:
2607: 
2608:             loc_oPag1.AddObject("cmb_4c_STRIB", "ComboBox")
2609:             WITH loc_oPag1.cmb_4c_STRIB
2610:                 .Top = 153
2611:                 .Left = 136
2612:                 .Height = 23
2613:                 .Width = 82
2614:                 .FontName = "Tahoma"
2615:                 .FontSize = 8
2616:                 .SpecialEffect = 1

*-- Linhas 2623 a 2632:
2623: 
2624:             loc_oPag1.AddObject("cmb_4c_InclIcms", "ComboBox")
2625:             WITH loc_oPag1.cmb_4c_InclIcms
2626:                 .Top = 101
2627:                 .Left = 380
2628:                 .Height = 23
2629:                 .Width = 82
2630:                 .FontName = "Tahoma"
2631:                 .FontSize = 8
2632:                 .SpecialEffect = 1

*-- Linhas 2639 a 2648:
2639: 
2640:             loc_oPag1.AddObject("cmb_4c_ContribNFe", "ComboBox")
2641:             WITH loc_oPag1.cmb_4c_ContribNFe
2642:                 .Top = 179
2643:                 .Left = 887
2644:                 .Height = 23
2645:                 .Width = 82
2646:                 .FontName = "Tahoma"
2647:                 .FontSize = 8
2648:                 .SpecialEffect = 1

*-- Linhas 2655 a 2664:
2655: 
2656:             loc_oPag1.AddObject("cmb_4c_IcmsInclPreco", "ComboBox")
2657:             WITH loc_oPag1.cmb_4c_IcmsInclPreco
2658:                 .Top = 178
2659:                 .Left = 380
2660:                 .Height = 23
2661:                 .Width = 82
2662:                 .FontName = "Tahoma"
2663:                 .FontSize = 8
2664:                 .SpecialEffect = 1

*-- Linhas 2671 a 2680:
2671: 
2672:             loc_oPag1.AddObject("cmb_4c_CfoTransp", "ComboBox")
2673:             WITH loc_oPag1.cmb_4c_CfoTransp
2674:                 .Top = 153
2675:                 .Left = 887
2676:                 .Height = 23
2677:                 .Width = 82
2678:                 .FontName = "Tahoma"
2679:                 .FontSize = 8
2680:                 .SpecialEffect = 1

*-- Linhas 2687 a 2696:
2687: 
2688:             loc_oPag1.AddObject("cmb_4c_UnitImp", "ComboBox")
2689:             WITH loc_oPag1.cmb_4c_UnitImp
2690:                 .Top = 206
2691:                 .Left = 887
2692:                 .Height = 23
2693:                 .Width = 82
2694:                 .FontName = "Tahoma"
2695:                 .FontSize = 8
2696:                 .SpecialEffect = 1

*-- Linhas 2703 a 2712:
2703: 
2704:             loc_oPag1.AddObject("cmb_4c_IPI", "ComboBox")
2705:             WITH loc_oPag1.cmb_4c_IPI
2706:                 .Top = 263
2707:                 .Left = 136
2708:                 .Height = 23
2709:                 .Width = 82
2710:                 .FontName = "Tahoma"
2711:                 .FontSize = 8
2712:                 .SpecialEffect = 1

*-- Linhas 2719 a 2728:
2719: 
2720:             loc_oPag1.AddObject("cmb_4c_IpiI", "ComboBox")
2721:             WITH loc_oPag1.cmb_4c_IpiI
2722:                 .Top = 263
2723:                 .Left = 380
2724:                 .Height = 23
2725:                 .Width = 82
2726:                 .FontName = "Tahoma"
2727:                 .FontSize = 8
2728:                 .SpecialEffect = 1

*-- Linhas 2735 a 2744:
2735: 
2736:             loc_oPag1.AddObject("cmb_4c_InclIPI", "ComboBox")
2737:             WITH loc_oPag1.cmb_4c_InclIPI
2738:                 .Top = 289
2739:                 .Left = 380
2740:                 .Height = 23
2741:                 .Width = 82
2742:                 .FontName = "Tahoma"
2743:                 .FontSize = 8
2744:                 .SpecialEffect = 1

*-- Linhas 2751 a 2760:
2751: 
2752:             loc_oPag1.AddObject("cmb_4c_NaoCreditado", "ComboBox")
2753:             WITH loc_oPag1.cmb_4c_NaoCreditado
2754:                 .Top = 315
2755:                 .Left = 136
2756:                 .Height = 23
2757:                 .Width = 82
2758:                 .FontName = "Tahoma"
2759:                 .FontSize = 8
2760:                 .SpecialEffect = 1

*-- Linhas 2767 a 2776:
2767: 
2768:             loc_oPag1.AddObject("cmb_4c_AcresDesc", "ComboBox")
2769:             WITH loc_oPag1.cmb_4c_AcresDesc
2770:                 .Top = 315
2771:                 .Left = 380
2772:                 .Height = 23
2773:                 .Width = 82
2774:                 .FontName = "Tahoma"
2775:                 .FontSize = 8
2776:                 .SpecialEffect = 1

*-- Linhas 2783 a 2792:
2783: 
2784:             loc_oPag1.AddObject("cmb_4c_BIPI", "ComboBox")
2785:             WITH loc_oPag1.cmb_4c_BIPI
2786:                 .Top = 341
2787:                 .Left = 136
2788:                 .Height = 24
2789:                 .Width = 196
2790:                 .FontName = "Tahoma"
2791:                 .FontSize = 8
2792:                 .SpecialEffect = 1

*-- Linhas 2799 a 2808:
2799: 
2800:             loc_oPag1.AddObject("cmb_4c_RetiraIPI", "ComboBox")
2801:             WITH loc_oPag1.cmb_4c_RetiraIPI
2802:                 .Top = 367
2803:                 .Left = 380
2804:                 .Height = 23
2805:                 .Width = 82
2806:                 .FontName = "Tahoma"
2807:                 .FontSize = 8
2808:                 .SpecialEffect = 1

*-- Linhas 2816 a 2979:
2816:             *-- OptionGroup Situacao (2 botoes: Ativo/Inativo)
2817:             loc_oPag1.AddObject("opg_4c_Situacao", "OptionGroup")
2818:             WITH loc_oPag1.opg_4c_Situacao
2819:                 .Top = 11
2820:                 .Left = 243
2821:                 .Height = 17
2822:                 .Width = 137
2823:                 .ButtonCount = 2
2824:                 .Buttons(1).Caption = "Ativo"
2825:                 .Buttons(1).Left = 4
2826:                 .Buttons(1).Top = 0
2827:                 .Buttons(1).AutoSize = .T.
2828:                 .Buttons(1).BackStyle = 0
2829:                 .Buttons(1).FontName = "Tahoma"
2830:                 .Buttons(1).FontSize = 8
2831:                 .Buttons(1).FontBold = .T.
2832:                 .Buttons(1).ForeColor = RGB(90,90,90)
2833:                 .Buttons(1).Themes = .F.
2834:                 .Buttons(2).Caption = "Inativo"
2835:                 .Buttons(2).Left = 64
2836:                 .Buttons(2).Top = 0
2837:                 .Buttons(2).AutoSize = .T.
2838:                 .Buttons(2).BackStyle = 0
2839:                 .Buttons(2).FontName = "Tahoma"
2840:                 .Buttons(2).FontSize = 8
2841:                 .Buttons(2).FontBold = .T.
2842:                 .Buttons(2).ForeColor = RGB(90,90,90)
2843:                 .Buttons(2).Themes = .F.
2844:             ENDWITH
2845: 
2846:             *-- CheckBoxes ICMS
2847:             loc_oPag1.AddObject("chk_4c_FreteICM", "CheckBox")
2848:             WITH loc_oPag1.chk_4c_FreteICM
2849:                 .Top = 102
2850:                 .Left = 549
2851:                 .Height = 15
2852:                 .Width = 44
2853:                 .Caption = "Frete"
2854:                 .FontName = "Tahoma"
2855:                 .FontSize = 8
2856:                 .FontBold = .F.
2857:                 .ForeColor = RGB(90,90,90)
2858:                 .BackStyle = 0
2859:                 .AutoSize = .T.
2860:                 .SpecialEffect = 1
2861:                 .Value = 0
2862:             ENDWITH
2863: 
2864:             loc_oPag1.AddObject("chk_4c_SegICM", "CheckBox")
2865:             WITH loc_oPag1.chk_4c_SegICM
2866:                 .Top = 117
2867:                 .Left = 549
2868:                 .Height = 15
2869:                 .Width = 52
2870:                 .Caption = "Seguro"
2871:                 .FontName = "Tahoma"
2872:                 .FontSize = 8
2873:                 .FontBold = .F.
2874:                 .ForeColor = RGB(90,90,90)
2875:                 .BackStyle = 0
2876:                 .AutoSize = .T.
2877:                 .SpecialEffect = 1
2878:                 .Value = 0
2879:             ENDWITH
2880: 
2881:             loc_oPag1.AddObject("chk_4c_DespICM", "CheckBox")
2882:             WITH loc_oPag1.chk_4c_DespICM
2883:                 .Top = 132
2884:                 .Left = 549
2885:                 .Height = 15
2886:                 .Width = 118
2887:                 .Caption = "Despesas Acess" + CHR(243) + "rias"
2888:                 .FontName = "Tahoma"
2889:                 .FontSize = 8
2890:                 .FontBold = .F.
2891:                 .ForeColor = RGB(90,90,90)
2892:                 .BackStyle = 0
2893:                 .AutoSize = .T.
2894:                 .SpecialEffect = 1
2895:                 .Value = 0
2896:             ENDWITH
2897: 
2898:             loc_oPag1.AddObject("chk_4c_IcmsNF", "CheckBox")
2899:             WITH loc_oPag1.chk_4c_IcmsNF
2900:                 .Top = 147
2901:                 .Left = 549
2902:                 .Height = 15
2903:                 .Width = 156
2904:                 .Caption = "Incluir ICMS no Total da N.F."
2905:                 .FontName = "Tahoma"
2906:                 .FontSize = 8
2907:                 .FontBold = .F.
2908:                 .ForeColor = RGB(90,90,90)
2909:                 .BackStyle = 0
2910:                 .AutoSize = .T.
2911:                 .SpecialEffect = 1
2912:                 .Value = 0
2913:             ENDWITH
2914: 
2915:             loc_oPag1.AddObject("chk_4c_SomaIcmFrete", "CheckBox")
2916:             WITH loc_oPag1.chk_4c_SomaIcmFrete
2917:                 .Top = 163
2918:                 .Left = 549
2919:                 .Height = 15
2920:                 .Width = 180
2921:                 .Caption = "Soma ICMS frete no Total da N.F."
2922:                 .FontName = "Tahoma"
2923:                 .FontSize = 8
2924:                 .FontBold = .F.
2925:                 .ForeColor = RGB(90,90,90)
2926:                 .BackStyle = 0
2927:                 .AutoSize = .T.
2928:                 .SpecialEffect = 1
2929:                 .Value = 0
2930:                 .Visible = .F.
2931:             ENDWITH
2932: 
2933:             *-- CheckBoxes IPI
2934:             loc_oPag1.AddObject("chk_4c_FreteIPI", "CheckBox")
2935:             WITH loc_oPag1.chk_4c_FreteIPI
2936:                 .Top = 395
2937:                 .Left = 137
2938:                 .Height = 15
2939:                 .Width = 44
2940:                 .Caption = "Frete"
2941:                 .FontName = "Tahoma"
2942:                 .FontSize = 8
2943:                 .FontBold = .F.
2944:                 .ForeColor = RGB(90,90,90)
2945:                 .BackStyle = 0
2946:                 .AutoSize = .T.
2947:                 .SpecialEffect = 1
2948:                 .Value = 0
2949:             ENDWITH
2950: 
2951:             loc_oPag1.AddObject("chk_4c_SegIPI", "CheckBox")
2952:             WITH loc_oPag1.chk_4c_SegIPI
2953:                 .Top = 395
2954:                 .Left = 188
2955:                 .Height = 15
2956:                 .Width = 52
2957:                 .Caption = "Seguro"
2958:                 .FontName = "Tahoma"
2959:                 .FontSize = 8
2960:                 .FontBold = .F.
2961:                 .ForeColor = RGB(90,90,90)
2962:                 .BackStyle = 0
2963:                 .AutoSize = .T.
2964:                 .SpecialEffect = 1
2965:                 .Value = 0
2966:             ENDWITH
2967: 
2968:             loc_oPag1.AddObject("chk_4c_DespIPI", "CheckBox")
2969:             WITH loc_oPag1.chk_4c_DespIPI
2970:                 .Top = 395
2971:                 .Left = 255
2972:                 .Height = 15
2973:                 .Width = 118
2974:                 .Caption = "Despesas Acess" + CHR(243) + "rias"
2975:                 .FontName = "Tahoma"
2976:                 .FontSize = 8
2977:                 .FontBold = .F.
2978:                 .ForeColor = RGB(90,90,90)
2979:                 .BackStyle = 0

*-- Linhas 2985 a 3039:
2985:             *-- OptionGroup CodTribISSQN (5 botoes: Normal/Retida/Substituta/Isenta/NaoCalcISSQN)
2986:             loc_oPag1.AddObject("opg_4c_CodTribISSQN", "OptionGroup")
2987:             WITH loc_oPag1.opg_4c_CodTribISSQN
2988:                 .Top = 389
2989:                 .Left = 686
2990:                 .Height = 34
2991:                 .Width = 297
2992:                 .ButtonCount = 5
2993:                 .Buttons(1).Caption = "Normal"
2994:                 .Buttons(1).Left = 4
2995:                 .Buttons(1).Top = 0
2996:                 .Buttons(1).AutoSize = .T.
2997:                 .Buttons(1).BackStyle = 0
2998:                 .Buttons(1).FontName = "Verdana"
2999:                 .Buttons(1).FontSize = 8
3000:                 .Buttons(1).FontBold = .F.
3001:                 .Buttons(1).ForeColor = RGB(90,90,90)
3002:                 .Buttons(1).Themes = .F.
3003:                 .Buttons(2).Caption = "Retida"
3004:                 .Buttons(2).Left = 72
3005:                 .Buttons(2).Top = 0
3006:                 .Buttons(2).AutoSize = .T.
3007:                 .Buttons(2).BackStyle = 0
3008:                 .Buttons(2).FontName = "Verdana"
3009:                 .Buttons(2).FontSize = 8
3010:                 .Buttons(2).FontBold = .F.
3011:                 .Buttons(2).ForeColor = RGB(90,90,90)
3012:                 .Buttons(2).Themes = .F.
3013:                 .Buttons(3).Caption = "Substituta"
3014:                 .Buttons(3).Left = 135
3015:                 .Buttons(3).Top = 1
3016:                 .Buttons(3).Width = 76
3017:                 .Buttons(3).AutoSize = .T.
3018:                 .Buttons(3).BackStyle = 0
3019:                 .Buttons(3).FontName = "Verdana"
3020:                 .Buttons(3).FontSize = 8
3021:                 .Buttons(3).FontBold = .F.
3022:                 .Buttons(3).ForeColor = RGB(90,90,90)
3023:                 .Buttons(3).Themes = .F.
3024:                 .Buttons(4).Caption = "Isenta"
3025:                 .Buttons(4).Left = 219
3026:                 .Buttons(4).Top = 1
3027:                 .Buttons(4).Width = 52
3028:                 .Buttons(4).AutoSize = .T.
3029:                 .Buttons(4).BackStyle = 0
3030:                 .Buttons(4).ForeColor = RGB(90,90,90)
3031:                 .Buttons(4).Themes = .F.
3032:                 .Buttons(5).Caption = "N" + CHR(227) + "o Calcula ISSQN"
3033:                 .Buttons(5).Left = 4
3034:                 .Buttons(5).Top = 17
3035:                 .Buttons(5).Width = 129
3036:                 .Buttons(5).AutoSize = .T.
3037:                 .Buttons(5).BackStyle = 0
3038:                 .Buttons(5).FontName = "Verdana"
3039:                 .Buttons(5).FontSize = 8

*-- Linhas 3045 a 3070:
3045:             *-- OptionGroup RetTribs (2 botoes: Sim/Nao)
3046:             loc_oPag1.AddObject("opg_4c_RetTribs", "OptionGroup")
3047:             WITH loc_oPag1.opg_4c_RetTribs
3048:                 .Top = 420
3049:                 .Left = 686
3050:                 .Height = 25
3051:                 .Width = 95
3052:                 .ButtonCount = 2
3053:                 .Buttons(1).Caption = "Sim"
3054:                 .Buttons(1).Left = 5
3055:                 .Buttons(1).Top = 5
3056:                 .Buttons(1).AutoSize = .T.
3057:                 .Buttons(1).BackStyle = 0
3058:                 .Buttons(1).FontName = "Tahoma"
3059:                 .Buttons(1).FontSize = 8
3060:                 .Buttons(1).FontBold = .F.
3061:                 .Buttons(1).ForeColor = RGB(90,90,90)
3062:                 .Buttons(1).Themes = .F.
3063:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3064:                 .Buttons(2).Left = 53
3065:                 .Buttons(2).Top = 5
3066:                 .Buttons(2).AutoSize = .T.
3067:                 .Buttons(2).BackStyle = 0
3068:                 .Buttons(2).FontName = "Tahoma"
3069:                 .Buttons(2).FontSize = 8
3070:                 .Buttons(2).FontBold = .F.

*-- Linhas 3104 a 3589:
3104:             *-- Shape separador
3105:             loc_oPag2.AddObject("shp_4c_shp03", "Shape")
3106:             WITH loc_oPag2.shp_4c_shp03
3107:                 .Top = 211
3108:                 .Left = 5
3109:                 .Height = 1
3110:                 .Width = 984
3111:                 .BackStyle = 0
3112:                 .BorderStyle = 1
3113:                 .BorderWidth = 1
3114:                 .BorderColor = RGB(100,100,100)
3115:             ENDWITH
3116: 
3117:             *-- Labels
3118:             loc_oPag2.AddObject("lbl_4c_Say7", "Label")
3119:             WITH loc_oPag2.lbl_4c_Say7
3120:                 .Caption = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
3121:                 .Top = 6
3122:                 .Left = 15
3123:                 .Height = 15
3124:                 .Width = 114
3125:                 .FontName = "Tahoma"
3126:                 .FontSize = 8
3127:                 .FontBold = .T.
3128:                 .ForeColor = RGB(90,90,90)
3129:                 .BackStyle = 0
3130:             ENDWITH
3131: 
3132:             loc_oPag2.AddObject("lbl_4c_Say10", "Label")
3133:             WITH loc_oPag2.lbl_4c_Say10
3134:                 .Caption = "Valor Cont" + CHR(225) + "bil :"
3135:                 .Top = 34
3136:                 .Left = 84
3137:                 .Height = 15
3138:                 .Width = 75
3139:                 .FontName = "Tahoma"
3140:                 .FontSize = 8
3141:                 .FontBold = .F.
3142:                 .ForeColor = RGB(90,90,90)
3143:                 .BackStyle = 0
3144:             ENDWITH
3145: 
3146:             loc_oPag2.AddObject("lbl_4c_Say13", "Label")
3147:             WITH loc_oPag2.lbl_4c_Say13
3148:                 .Caption = "DB"
3149:                 .Top = 34
3150:                 .Left = 247
3151:                 .Height = 15
3152:                 .Width = 15
3153:                 .FontName = "Tahoma"
3154:                 .FontSize = 8
3155:                 .FontBold = .F.
3156:                 .ForeColor = RGB(90,90,90)
3157:                 .BackStyle = 0
3158:             ENDWITH
3159: 
3160:             loc_oPag2.AddObject("lbl_4c_Say14", "Label")
3161:             WITH loc_oPag2.lbl_4c_Say14
3162:                 .Caption = "CR"
3163:                 .Top = 34
3164:                 .Left = 344
3165:                 .Height = 15
3166:                 .Width = 16
3167:                 .FontName = "Tahoma"
3168:                 .FontSize = 8
3169:                 .FontBold = .F.
3170:                 .ForeColor = RGB(90,90,90)
3171:                 .BackStyle = 0
3172:             ENDWITH
3173: 
3174:             loc_oPag2.AddObject("lbl_4c_Say11", "Label")
3175:             WITH loc_oPag2.lbl_4c_Say11
3176:                 .Caption = "IPI :"
3177:                 .Top = 60
3178:                 .Left = 136
3179:                 .Height = 15
3180:                 .Width = 23
3181:                 .FontName = "Tahoma"
3182:                 .FontSize = 8
3183:                 .FontBold = .F.
3184:                 .ForeColor = RGB(90,90,90)
3185:                 .BackStyle = 0
3186:             ENDWITH
3187: 
3188:             loc_oPag2.AddObject("lbl_4c_Say15", "Label")
3189:             WITH loc_oPag2.lbl_4c_Say15
3190:                 .Caption = "DB"
3191:                 .Top = 60
3192:                 .Left = 247
3193:                 .Height = 15
3194:                 .Width = 15
3195:                 .FontName = "Tahoma"
3196:                 .FontSize = 8
3197:                 .FontBold = .F.
3198:                 .ForeColor = RGB(90,90,90)
3199:                 .BackStyle = 0
3200:             ENDWITH
3201: 
3202:             loc_oPag2.AddObject("lbl_4c_Say16", "Label")
3203:             WITH loc_oPag2.lbl_4c_Say16
3204:                 .Caption = "CR"
3205:                 .Top = 60
3206:                 .Left = 344
3207:                 .Height = 15
3208:                 .Width = 16
3209:                 .FontName = "Tahoma"
3210:                 .FontSize = 8
3211:                 .FontBold = .F.
3212:                 .ForeColor = RGB(90,90,90)
3213:                 .BackStyle = 0
3214:             ENDWITH
3215: 
3216:             loc_oPag2.AddObject("lbl_4c_Say12", "Label")
3217:             WITH loc_oPag2.lbl_4c_Say12
3218:                 .Caption = "ICMS :"
3219:                 .Top = 86
3220:                 .Left = 125
3221:                 .Height = 15
3222:                 .Width = 34
3223:                 .FontName = "Tahoma"
3224:                 .FontSize = 8
3225:                 .FontBold = .F.
3226:                 .ForeColor = RGB(90,90,90)
3227:                 .BackStyle = 0
3228:             ENDWITH
3229: 
3230:             loc_oPag2.AddObject("lbl_4c_Say17", "Label")
3231:             WITH loc_oPag2.lbl_4c_Say17
3232:                 .Caption = "DB"
3233:                 .Top = 86
3234:                 .Left = 247
3235:                 .Height = 15
3236:                 .Width = 15
3237:                 .FontName = "Tahoma"
3238:                 .FontSize = 8
3239:                 .FontBold = .F.
3240:                 .ForeColor = RGB(90,90,90)
3241:                 .BackStyle = 0
3242:             ENDWITH
3243: 
3244:             loc_oPag2.AddObject("lbl_4c_Say18", "Label")
3245:             WITH loc_oPag2.lbl_4c_Say18
3246:                 .Caption = "CR"
3247:                 .Top = 86
3248:                 .Left = 344
3249:                 .Height = 15
3250:                 .Width = 16
3251:                 .FontName = "Tahoma"
3252:                 .FontSize = 8
3253:                 .FontBold = .F.
3254:                 .ForeColor = RGB(90,90,90)
3255:                 .BackStyle = 0
3256:             ENDWITH
3257: 
3258:             loc_oPag2.AddObject("lbl_4c_Say3", "Label")
3259:             WITH loc_oPag2.lbl_4c_Say3
3260:                 .Caption = "Conta de Frete :"
3261:                 .Top = 112
3262:                 .Left = 77
3263:                 .Height = 15
3264:                 .Width = 82
3265:                 .FontName = "Tahoma"
3266:                 .FontSize = 8
3267:                 .FontBold = .F.
3268:                 .ForeColor = RGB(90,90,90)
3269:                 .BackStyle = 0
3270:             ENDWITH
3271: 
3272:             loc_oPag2.AddObject("lbl_4c_Say4", "Label")
3273:             WITH loc_oPag2.lbl_4c_Say4
3274:                 .Caption = "Conta de Seguro :"
3275:                 .Top = 138
3276:                 .Left = 69
3277:                 .Height = 15
3278:                 .Width = 90
3279:                 .FontName = "Tahoma"
3280:                 .FontSize = 8
3281:                 .FontBold = .F.
3282:                 .ForeColor = RGB(90,90,90)
3283:                 .BackStyle = 0
3284:             ENDWITH
3285: 
3286:             loc_oPag2.AddObject("lbl_4c_Say5", "Label")
3287:             WITH loc_oPag2.lbl_4c_Say5
3288:                 .Caption = "Conta de Despesas :"
3289:                 .Top = 164
3290:                 .Left = 57
3291:                 .Height = 15
3292:                 .Width = 102
3293:                 .FontName = "Tahoma"
3294:                 .FontSize = 8
3295:                 .FontBold = .F.
3296:                 .ForeColor = RGB(90,90,90)
3297:                 .BackStyle = 0
3298:             ENDWITH
3299: 
3300:             loc_oPag2.AddObject("lbl_4c_Say21", "Label")
3301:             WITH loc_oPag2.lbl_4c_Say21
3302:                 .Caption = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
3303:                 .Top = 31
3304:                 .Left = 490
3305:                 .Height = 15
3306:                 .Width = 151
3307:                 .FontName = "Verdana"
3308:                 .FontSize = 8
3309:                 .FontBold = .F.
3310:                 .ForeColor = RGB(90,90,90)
3311:                 .BackStyle = 0
3312:             ENDWITH
3313: 
3314:             loc_oPag2.AddObject("lbl_4c_Say8", "Label")
3315:             WITH loc_oPag2.lbl_4c_Say8
3316:                 .Caption = "Pega Conta Cont" + CHR(225) + "bil da NF :"
3317:                 .Top = 57
3318:                 .Left = 477
3319:                 .Height = 15
3320:                 .Width = 164
3321:                 .FontName = "Verdana"
3322:                 .FontSize = 8
3323:                 .FontBold = .F.
3324:                 .ForeColor = RGB(90,90,90)
3325:                 .BackStyle = 0
3326:             ENDWITH
3327: 
3328:             loc_oPag2.AddObject("lbl_4c_Say29", "Label")
3329:             WITH loc_oPag2.lbl_4c_Say29
3330:                 .Caption = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
3331:                 .Top = 84
3332:                 .Left = 477
3333:                 .Height = 15
3334:                 .Width = 164
3335:                 .FontName = "Verdana"
3336:                 .FontSize = 8
3337:                 .FontBold = .F.
3338:                 .ForeColor = RGB(90,90,90)
3339:                 .BackStyle = 0
3340:             ENDWITH
3341: 
3342:             loc_oPag2.AddObject("lbl_4c_Say30", "Label")
3343:             WITH loc_oPag2.lbl_4c_Say30
3344:                 .Caption = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
3345:                 .Top = 108
3346:                 .Left = 523
3347:                 .Height = 15
3348:                 .Width = 118
3349:                 .FontName = "Verdana"
3350:                 .FontSize = 8
3351:                 .FontBold = .F.
3352:                 .ForeColor = RGB(90,90,90)
3353:                 .BackStyle = 0
3354:             ENDWITH
3355: 
3356:             loc_oPag2.AddObject("lbl_4c_Say1", "Label")
3357:             WITH loc_oPag2.lbl_4c_Say1
3358:                 .Caption = "Data Lan" + CHR(231) + "amento Contabil :"
3359:                 .Top = 132
3360:                 .Left = 479
3361:                 .Height = 15
3362:                 .Width = 162
3363:                 .FontName = "Verdana"
3364:                 .FontSize = 8
3365:                 .FontBold = .F.
3366:                 .ForeColor = RGB(90,90,90)
3367:                 .BackStyle = 0
3368:             ENDWITH
3369: 
3370:             loc_oPag2.AddObject("lbl_4c_Say2", "Label")
3371:             WITH loc_oPag2.lbl_4c_Say2
3372:                 .Caption = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
3373:                 .Top = 156
3374:                 .Left = 390
3375:                 .Height = 15
3376:                 .Width = 251
3377:                 .FontName = "Verdana"
3378:                 .FontSize = 8
3379:                 .FontBold = .F.
3380:                 .ForeColor = RGB(90,90,90)
3381:                 .BackStyle = 0
3382:             ENDWITH
3383: 
3384:             loc_oPag2.AddObject("lbl_4c_Say35", "Label")
3385:             WITH loc_oPag2.lbl_4c_Say35
3386:                 .Caption = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
3387:                 .Top = 217
3388:                 .Left = 18
3389:                 .Height = 15
3390:                 .Width = 99
3391:                 .FontName = "Tahoma"
3392:                 .FontSize = 8
3393:                 .FontBold = .T.
3394:                 .ForeColor = RGB(90,90,90)
3395:                 .BackStyle = 0
3396:             ENDWITH
3397: 
3398:             loc_oPag2.AddObject("lbl_4c_Say6", "Label")
3399:             WITH loc_oPag2.lbl_4c_Say6
3400:                 .Caption = "Integrar Valor Cont" + CHR(225) + "bil :"
3401:                 .Top = 239
3402:                 .Left = 115
3403:                 .Height = 15
3404:                 .Width = 118
3405:                 .FontName = "Tahoma"
3406:                 .FontSize = 8
3407:                 .FontBold = .F.
3408:                 .ForeColor = RGB(90,90,90)
3409:                 .BackStyle = 0
3410:             ENDWITH
3411: 
3412:             loc_oPag2.AddObject("lbl_4c_Say33", "Label")
3413:             WITH loc_oPag2.lbl_4c_Say33
3414:                 .Caption = "Integrar Valores Icms :"
3415:                 .Top = 259
3416:                 .Left = 121
3417:                 .Height = 15
3418:                 .Width = 112
3419:                 .FontName = "Tahoma"
3420:                 .FontSize = 8
3421:                 .FontBold = .F.
3422:                 .ForeColor = RGB(90,90,90)
3423:                 .BackStyle = 0
3424:             ENDWITH
3425: 
3426:             loc_oPag2.AddObject("lbl_4c_Say34", "Label")
3427:             WITH loc_oPag2.lbl_4c_Say34
3428:                 .Caption = "Integrar Valores Ipi :"
3429:                 .Top = 278
3430:                 .Left = 131
3431:                 .Height = 15
3432:                 .Width = 102
3433:                 .FontName = "Tahoma"
3434:                 .FontSize = 8
3435:                 .FontBold = .F.
3436:                 .ForeColor = RGB(90,90,90)
3437:                 .BackStyle = 0
3438:             ENDWITH
3439: 
3440:             loc_oPag2.AddObject("lbl_4c_Say38", "Label")
3441:             WITH loc_oPag2.lbl_4c_Say38
3442:                 .Caption = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
3443:                 .Top = 298
3444:                 .Left = 69
3445:                 .Height = 15
3446:                 .Width = 164
3447:                 .FontName = "Tahoma"
3448:                 .FontSize = 8
3449:                 .FontBold = .F.
3450:                 .ForeColor = RGB(90,90,90)
3451:                 .BackStyle = 0
3452:             ENDWITH
3453: 
3454:             loc_oPag2.AddObject("lbl_4c_Say39", "Label")
3455:             WITH loc_oPag2.lbl_4c_Say39
3456:                 .Caption = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
3457:                 .Top = 318
3458:                 .Left = 106
3459:                 .Height = 15
3460:                 .Width = 127
3461:                 .FontName = "Tahoma"
3462:                 .FontSize = 8
3463:                 .FontBold = .F.
3464:                 .ForeColor = RGB(90,90,90)
3465:                 .BackStyle = 0
3466:             ENDWITH
3467: 
3468:             *-- TextBoxes Integracao Contabil
3469:             loc_oPag2.AddObject("txt_4c_VrcDs", "TextBox")
3470:             WITH loc_oPag2.txt_4c_VrcDs
3471:                 .Top = 30
3472:                 .Left = 162
3473:                 .Height = 24
3474:                 .Width = 73
3475:                 .FontName = "Tahoma"
3476:                 .FontSize = 8
3477:                 .SpecialEffect = 1
3478:                 .ForeColor = RGB(90,90,90)
3479:                 .BorderColor = RGB(100,100,100)
3480:                 .Value = ""
3481:             ENDWITH
3482: 
3483:             loc_oPag2.AddObject("txt_4c_VrcCs", "TextBox")
3484:             WITH loc_oPag2.txt_4c_VrcCs
3485:                 .Top = 30
3486:                 .Left = 265
3487:                 .Height = 24
3488:                 .Width = 73
3489:                 .FontName = "Tahoma"
3490:                 .FontSize = 8
3491:                 .SpecialEffect = 1
3492:                 .ForeColor = RGB(90,90,90)
3493:                 .BorderColor = RGB(100,100,100)
3494:                 .Value = ""
3495:             ENDWITH
3496: 
3497:             loc_oPag2.AddObject("txt_4c_IpiDs", "TextBox")
3498:             WITH loc_oPag2.txt_4c_IpiDs
3499:                 .Top = 56
3500:                 .Left = 162
3501:                 .Height = 24
3502:                 .Width = 73
3503:                 .FontName = "Tahoma"
3504:                 .FontSize = 8
3505:                 .SpecialEffect = 1
3506:                 .ForeColor = RGB(90,90,90)
3507:                 .BorderColor = RGB(100,100,100)
3508:                 .Value = ""
3509:             ENDWITH
3510: 
3511:             loc_oPag2.AddObject("txt_4c_IpiCs", "TextBox")
3512:             WITH loc_oPag2.txt_4c_IpiCs
3513:                 .Top = 56
3514:                 .Left = 265
3515:                 .Height = 24
3516:                 .Width = 73
3517:                 .FontName = "Tahoma"
3518:                 .FontSize = 8
3519:                 .SpecialEffect = 1
3520:                 .ForeColor = RGB(90,90,90)
3521:                 .BorderColor = RGB(100,100,100)
3522:                 .Value = ""
3523:             ENDWITH
3524: 
3525:             loc_oPag2.AddObject("txt_4c_IcmDs", "TextBox")
3526:             WITH loc_oPag2.txt_4c_IcmDs
3527:                 .Top = 82
3528:                 .Left = 162
3529:                 .Height = 24
3530:                 .Width = 73
3531:                 .FontName = "Tahoma"
3532:                 .FontSize = 8
3533:                 .SpecialEffect = 1
3534:                 .ForeColor = RGB(90,90,90)
3535:                 .BorderColor = RGB(100,100,100)
3536:                 .Value = ""
3537:             ENDWITH
3538: 
3539:             loc_oPag2.AddObject("txt_4c_IcmCs", "TextBox")
3540:             WITH loc_oPag2.txt_4c_IcmCs
3541:                 .Top = 82
3542:                 .Left = 265
3543:                 .Height = 24
3544:                 .Width = 73
3545:                 .FontName = "Tahoma"
3546:                 .FontSize = 8
3547:                 .SpecialEffect = 1
3548:                 .ForeColor = RGB(90,90,90)
3549:                 .BorderColor = RGB(100,100,100)
3550:                 .Value = ""
3551:             ENDWITH
3552: 
3553:             loc_oPag2.AddObject("txt_4c_ContFrt", "TextBox")
3554:             WITH loc_oPag2.txt_4c_ContFrt
3555:                 .Top = 108
3556:                 .Left = 162
3557:                 .Height = 24
3558:                 .Width = 73
3559:                 .FontName = "Tahoma"
3560:                 .FontSize = 8
3561:                 .SpecialEffect = 1
3562:                 .ForeColor = RGB(90,90,90)
3563:                 .BorderColor = RGB(100,100,100)
3564:                 .Value = ""
3565:             ENDWITH
3566: 
3567:             loc_oPag2.AddObject("txt_4c_ContSeg", "TextBox")
3568:             WITH loc_oPag2.txt_4c_ContSeg
3569:                 .Top = 134
3570:                 .Left = 162
3571:                 .Height = 24
3572:                 .Width = 73
3573:                 .FontName = "Tahoma"
3574:                 .FontSize = 8
3575:                 .SpecialEffect = 1
3576:                 .ForeColor = RGB(90,90,90)
3577:                 .BorderColor = RGB(100,100,100)
3578:                 .Value = ""
3579:             ENDWITH
3580: 
3581:             loc_oPag2.AddObject("txt_4c_ContDa", "TextBox")
3582:             WITH loc_oPag2.txt_4c_ContDa
3583:                 .Top = 160
3584:                 .Left = 162
3585:                 .Height = 24
3586:                 .Width = 73
3587:                 .FontName = "Tahoma"
3588:                 .FontSize = 8
3589:                 .SpecialEffect = 1

*-- Linhas 3595 a 3604:
3595:             *-- ComboBoxes
3596:             loc_oPag2.AddObject("cmb_4c_DescInteg", "ComboBox")
3597:             WITH loc_oPag2.cmb_4c_DescInteg
3598:                 .Top = 27
3599:                 .Left = 642
3600:                 .Height = 25
3601:                 .Width = 199
3602:                 .FontName = "Tahoma"
3603:                 .FontSize = 8
3604:                 .SpecialEffect = 1

*-- Linhas 3611 a 3620:
3611: 
3612:             loc_oPag2.AddObject("cmb_4c_CmbFixa", "ComboBox")
3613:             WITH loc_oPag2.cmb_4c_CmbFixa
3614:                 .Top = 53
3615:                 .Left = 642
3616:                 .Height = 25
3617:                 .Width = 132
3618:                 .FontName = "Tahoma"
3619:                 .FontSize = 8
3620:                 .SpecialEffect = 1

*-- Linhas 3628 a 3749:
3628:             *-- OptionGroups Sim/Nao (Integracao Contabil)
3629:             loc_oPag2.AddObject("opg_4c_Agrupas", "OptionGroup")
3630:             WITH loc_oPag2.opg_4c_Agrupas
3631:                 .Top = 79
3632:                 .Left = 638
3633:                 .Height = 27
3634:                 .Width = 94
3635:                 .ButtonCount = 2
3636:                 .BorderStyle = 0
3637:                 .Buttons(1).Caption = "Sim"
3638:                 .Buttons(1).Left = 5
3639:                 .Buttons(1).Top = 5
3640:                 .Buttons(1).Width = 40
3641:                 .Buttons(1).Height = 17
3642:                 .Buttons(1).AutoSize = .F.
3643:                 .Buttons(1).BackStyle = 0
3644:                 .Buttons(1).FontName = "Tahoma"
3645:                 .Buttons(1).FontSize = 8
3646:                 .Buttons(1).ForeColor = RGB(90,90,90)
3647:                 .Buttons(1).Themes = .F.
3648:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3649:                 .Buttons(2).Left = 51
3650:                 .Buttons(2).Top = 5
3651:                 .Buttons(2).Width = 40
3652:                 .Buttons(2).Height = 17
3653:                 .Buttons(2).AutoSize = .F.
3654:                 .Buttons(2).BackStyle = 0
3655:                 .Buttons(2).FontName = "Tahoma"
3656:                 .Buttons(2).FontSize = 8
3657:                 .Buttons(2).ForeColor = RGB(90,90,90)
3658:                 .Buttons(2).Themes = .F.
3659:             ENDWITH
3660: 
3661:             loc_oPag2.AddObject("opg_4c_Zeradas", "OptionGroup")
3662:             WITH loc_oPag2.opg_4c_Zeradas
3663:                 .Top = 103
3664:                 .Left = 638
3665:                 .Height = 27
3666:                 .Width = 94
3667:                 .ButtonCount = 2
3668:                 .BorderStyle = 0
3669:                 .Buttons(1).Caption = "Sim"
3670:                 .Buttons(1).Left = 5
3671:                 .Buttons(1).Top = 5
3672:                 .Buttons(1).Width = 40
3673:                 .Buttons(1).Height = 17
3674:                 .Buttons(1).AutoSize = .F.
3675:                 .Buttons(1).BackStyle = 0
3676:                 .Buttons(1).FontName = "Tahoma"
3677:                 .Buttons(1).FontSize = 8
3678:                 .Buttons(1).ForeColor = RGB(90,90,90)
3679:                 .Buttons(1).Themes = .F.
3680:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3681:                 .Buttons(2).Left = 51
3682:                 .Buttons(2).Top = 5
3683:                 .Buttons(2).Width = 40
3684:                 .Buttons(2).Height = 17
3685:                 .Buttons(2).AutoSize = .F.
3686:                 .Buttons(2).BackStyle = 0
3687:                 .Buttons(2).FontName = "Tahoma"
3688:                 .Buttons(2).FontSize = 8
3689:                 .Buttons(2).ForeColor = RGB(90,90,90)
3690:                 .Buttons(2).Themes = .F.
3691:             ENDWITH
3692: 
3693:             loc_oPag2.AddObject("opg_4c_DtIntFis", "OptionGroup")
3694:             WITH loc_oPag2.opg_4c_DtIntFis
3695:                 .Top = 127
3696:                 .Left = 638
3697:                 .Height = 27
3698:                 .Width = 192
3699:                 .ButtonCount = 2
3700:                 .BorderStyle = 0
3701:                 .Buttons(1).Caption = "Data Integra" + CHR(231) + CHR(227) + "o"
3702:                 .Buttons(1).Left = 5
3703:                 .Buttons(1).Top = 5
3704:                 .Buttons(1).Width = 97
3705:                 .Buttons(1).AutoSize = .T.
3706:                 .Buttons(1).BackStyle = 0
3707:                 .Buttons(1).FontName = "Tahoma"
3708:                 .Buttons(1).FontSize = 8
3709:                 .Buttons(1).ForeColor = RGB(90,90,90)
3710:                 .Buttons(1).Themes = .F.
3711:                 .Buttons(2).Caption = "Data N.F."
3712:                 .Buttons(2).Left = 122
3713:                 .Buttons(2).Top = 7
3714:                 .Buttons(2).Width = 65
3715:                 .Buttons(2).AutoSize = .T.
3716:                 .Buttons(2).BackStyle = 0
3717:                 .Buttons(2).FontName = "Tahoma"
3718:                 .Buttons(2).FontSize = 8
3719:                 .Buttons(2).ForeColor = RGB(90,90,90)
3720:                 .Buttons(2).Themes = .F.
3721:             ENDWITH
3722: 
3723:             loc_oPag2.AddObject("opg_4c_UtilVars", "OptionGroup")
3724:             WITH loc_oPag2.opg_4c_UtilVars
3725:                 .Top = 150
3726:                 .Left = 638
3727:                 .Height = 27
3728:                 .Width = 94
3729:                 .ButtonCount = 2
3730:                 .BorderStyle = 0
3731:                 .Buttons(1).Caption = "Sim"
3732:                 .Buttons(1).Left = 5
3733:                 .Buttons(1).Top = 5
3734:                 .Buttons(1).Width = 40
3735:                 .Buttons(1).Height = 17
3736:                 .Buttons(1).AutoSize = .F.
3737:                 .Buttons(1).BackStyle = 0
3738:                 .Buttons(1).FontName = "Tahoma"
3739:                 .Buttons(1).FontSize = 8
3740:                 .Buttons(1).ForeColor = RGB(90,90,90)
3741:                 .Buttons(1).Themes = .F.
3742:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3743:                 .Buttons(2).Left = 51
3744:                 .Buttons(2).Top = 5
3745:                 .Buttons(2).Width = 40
3746:                 .Buttons(2).Height = 17
3747:                 .Buttons(2).AutoSize = .F.
3748:                 .Buttons(2).BackStyle = 0
3749:                 .Buttons(2).FontName = "Tahoma"

*-- Linhas 3755 a 3910:
3755:             *-- OptionGroups Sim/Nao (Integracao Fiscal)
3756:             loc_oPag2.AddObject("opg_4c_IntVlrCont", "OptionGroup")
3757:             WITH loc_oPag2.opg_4c_IntVlrCont
3758:                 .Top = 233
3759:                 .Left = 231
3760:                 .Height = 27
3761:                 .Width = 94
3762:                 .ButtonCount = 2
3763:                 .BorderStyle = 0
3764:                 .Buttons(1).Caption = "Sim"
3765:                 .Buttons(1).Left = 5
3766:                 .Buttons(1).Top = 5
3767:                 .Buttons(1).Width = 40
3768:                 .Buttons(1).Height = 17
3769:                 .Buttons(1).AutoSize = .F.
3770:                 .Buttons(1).BackStyle = 0
3771:                 .Buttons(1).FontName = "Tahoma"
3772:                 .Buttons(1).FontSize = 8
3773:                 .Buttons(1).ForeColor = RGB(90,90,90)
3774:                 .Buttons(1).Themes = .F.
3775:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3776:                 .Buttons(2).Left = 51
3777:                 .Buttons(2).Top = 5
3778:                 .Buttons(2).Width = 40
3779:                 .Buttons(2).Height = 17
3780:                 .Buttons(2).AutoSize = .F.
3781:                 .Buttons(2).BackStyle = 0
3782:                 .Buttons(2).FontName = "Tahoma"
3783:                 .Buttons(2).FontSize = 8
3784:                 .Buttons(2).ForeColor = RGB(90,90,90)
3785:                 .Buttons(2).Themes = .F.
3786:             ENDWITH
3787: 
3788:             loc_oPag2.AddObject("opg_4c_IntVlrIcms", "OptionGroup")
3789:             WITH loc_oPag2.opg_4c_IntVlrIcms
3790:                 .Top = 253
3791:                 .Left = 231
3792:                 .Height = 27
3793:                 .Width = 94
3794:                 .ButtonCount = 2
3795:                 .BorderStyle = 0
3796:                 .Buttons(1).Caption = "Sim"
3797:                 .Buttons(1).Left = 5
3798:                 .Buttons(1).Top = 5
3799:                 .Buttons(1).Width = 40
3800:                 .Buttons(1).Height = 17
3801:                 .Buttons(1).AutoSize = .F.
3802:                 .Buttons(1).BackStyle = 0
3803:                 .Buttons(1).FontName = "Tahoma"
3804:                 .Buttons(1).FontSize = 8
3805:                 .Buttons(1).ForeColor = RGB(90,90,90)
3806:                 .Buttons(1).Themes = .F.
3807:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3808:                 .Buttons(2).Left = 51
3809:                 .Buttons(2).Top = 5
3810:                 .Buttons(2).Width = 40
3811:                 .Buttons(2).Height = 17
3812:                 .Buttons(2).AutoSize = .F.
3813:                 .Buttons(2).BackStyle = 0
3814:                 .Buttons(2).FontName = "Tahoma"
3815:                 .Buttons(2).FontSize = 8
3816:                 .Buttons(2).ForeColor = RGB(90,90,90)
3817:                 .Buttons(2).Themes = .F.
3818:             ENDWITH
3819: 
3820:             loc_oPag2.AddObject("opg_4c_IntVlrIpi", "OptionGroup")
3821:             WITH loc_oPag2.opg_4c_IntVlrIpi
3822:                 .Top = 272
3823:                 .Left = 231
3824:                 .Height = 27
3825:                 .Width = 94
3826:                 .ButtonCount = 2
3827:                 .BorderStyle = 0
3828:                 .Buttons(1).Caption = "Sim"
3829:                 .Buttons(1).Left = 5
3830:                 .Buttons(1).Top = 5
3831:                 .Buttons(1).Width = 40
3832:                 .Buttons(1).Height = 17
3833:                 .Buttons(1).AutoSize = .F.
3834:                 .Buttons(1).BackStyle = 0
3835:                 .Buttons(1).FontName = "Tahoma"
3836:                 .Buttons(1).FontSize = 8
3837:                 .Buttons(1).ForeColor = RGB(90,90,90)
3838:                 .Buttons(1).Themes = .F.
3839:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3840:                 .Buttons(2).Left = 51
3841:                 .Buttons(2).Top = 5
3842:                 .Buttons(2).Width = 40
3843:                 .Buttons(2).Height = 17
3844:                 .Buttons(2).AutoSize = .F.
3845:                 .Buttons(2).BackStyle = 0
3846:                 .Buttons(2).FontName = "Tahoma"
3847:                 .Buttons(2).FontSize = 8
3848:                 .Buttons(2).ForeColor = RGB(90,90,90)
3849:                 .Buttons(2).Themes = .F.
3850:             ENDWITH
3851: 
3852:             loc_oPag2.AddObject("opg_4c_IndMov", "OptionGroup")
3853:             WITH loc_oPag2.opg_4c_IndMov
3854:                 .Top = 292
3855:                 .Left = 231
3856:                 .Height = 27
3857:                 .Width = 94
3858:                 .ButtonCount = 2
3859:                 .BorderStyle = 0
3860:                 .Buttons(1).Caption = "Sim"
3861:                 .Buttons(1).Left = 5
3862:                 .Buttons(1).Top = 5
3863:                 .Buttons(1).Width = 40
3864:                 .Buttons(1).Height = 17
3865:                 .Buttons(1).AutoSize = .F.
3866:                 .Buttons(1).BackStyle = 0
3867:                 .Buttons(1).FontName = "Tahoma"
3868:                 .Buttons(1).FontSize = 8
3869:                 .Buttons(1).ForeColor = RGB(90,90,90)
3870:                 .Buttons(1).Themes = .F.
3871:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3872:                 .Buttons(2).Left = 51
3873:                 .Buttons(2).Top = 5
3874:                 .Buttons(2).Width = 40
3875:                 .Buttons(2).Height = 17
3876:                 .Buttons(2).AutoSize = .F.
3877:                 .Buttons(2).BackStyle = 0
3878:                 .Buttons(2).FontName = "Tahoma"
3879:                 .Buttons(2).FontSize = 8
3880:                 .Buttons(2).ForeColor = RGB(90,90,90)
3881:                 .Buttons(2).Themes = .F.
3882:             ENDWITH
3883: 
3884:             loc_oPag2.AddObject("opg_4c_IndPagto", "OptionGroup")
3885:             WITH loc_oPag2.opg_4c_IndPagto
3886:                 .Top = 312
3887:                 .Left = 231
3888:                 .Height = 27
3889:                 .Width = 94
3890:                 .ButtonCount = 2
3891:                 .BorderStyle = 0
3892:                 .Buttons(1).Caption = "Sim"
3893:                 .Buttons(1).Left = 5
3894:                 .Buttons(1).Top = 5
3895:                 .Buttons(1).Width = 40
3896:                 .Buttons(1).Height = 17
3897:                 .Buttons(1).AutoSize = .F.
3898:                 .Buttons(1).BackStyle = 0
3899:                 .Buttons(1).FontName = "Tahoma"
3900:                 .Buttons(1).FontSize = 8
3901:                 .Buttons(1).ForeColor = RGB(90,90,90)
3902:                 .Buttons(1).Themes = .F.
3903:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3904:                 .Buttons(2).Left = 51
3905:                 .Buttons(2).Top = 5
3906:                 .Buttons(2).Width = 40
3907:                 .Buttons(2).Height = 17
3908:                 .Buttons(2).AutoSize = .F.
3909:                 .Buttons(2).BackStyle = 0
3910:                 .Buttons(2).FontName = "Tahoma"


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*============================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal)
* Tabela: SigCdCfo | PK: codigos
*============================================================
DEFINE CLASS cfoBO AS BusinessBase

    *-- Propriedades char - SigCdCfo
    this_cCodigos     = ""  && char(10) - PK
    this_cDescricaos  = ""  && char(60)
    this_cDesc2s      = ""  && char(60)
    this_cContconts   = ""  && char(1)
    this_cContribs    = ""  && char(1)
    this_cIcms        = ""  && char(1)
    this_cIpis        = ""  && char(1)
    this_cOperacaos   = ""  && char(1)
    this_cContvcds    = ""  && char(9)
    this_cContvccs    = ""  && char(9)
    this_cContipcs    = ""  && char(9)
    this_cContipds    = ""  && char(9)
    this_cConticcs    = ""  && char(9)
    this_cConticds    = ""  && char(9)
    this_cCoddests    = ""  && char(10)
    this_cSittribs    = ""  && char(3)
    this_cIpi_Icms    = ""  && char(1)
    this_cCgergia1s   = ""  && char(1)
    this_cBcipis      = ""  && char(1)
    this_cCfosts      = ""  && char(10)
    this_cSubtribs    = ""  && char(1)
    this_cAcresipis   = ""  && char(1)
    this_cIpiimpors   = ""  && char(1)
    this_cIpiom2s     = ""  && char(1)
    this_cUnitimps    = ""  && char(1)
    this_cContda      = ""  && char(9)
    this_cContfrt     = ""  && char(9)
    this_cContseg     = ""  && char(9)
    this_cIpicst      = ""  && char(2)
    this_cPiscst      = ""  && char(2)
    this_cCofcst      = ""  && char(2)
    this_cIssqnl      = ""  && char(5)
    this_cCfost60s    = ""  && char(10)
    this_cIpienq      = ""  && char(3)
    this_cMotdeson    = ""  && char(2)

    *-- Propriedades numeric - SigCdCfo
    this_nAliqipis    = 0   && numeric(4,2)
    this_nIpincreds   = 0   && numeric(1,0)
    this_nPontedescs  = 0   && numeric(1,0)
    this_nAliqivcs    = 0   && numeric(4,2)
    this_nNdigitos    = 0   && numeric(2,0)
    this_nInclicms    = 0   && numeric(1,0)
    this_nTransps     = 0   && numeric(1,0)
    this_nAgrupas     = 0   && numeric(1,0)
    this_nZeradas     = 0   && numeric(1,0)
    this_nIcmsdscs    = 0   && numeric(1,0)
    this_nInclipis    = 0   && numeric(1,0)
    this_nSituas      = 0   && numeric(1,0)
    this_nDesicms     = 0   && numeric(1,0)
    this_nDesipis     = 0   && numeric(1,0)
    this_nFrticms     = 0   && numeric(1,0)
    this_nFrtipis     = 0   && numeric(1,0)
    this_nPbcipis     = 0   && numeric(5,2)
    this_nPbcsts      = 0   && numeric(5,2)
    this_nSegicms     = 0   && numeric(1,0)
    this_nSegipis     = 0   && numeric(1,0)
    this_nDtintfis    = 0   && numeric(1,0)
    this_nIntvlrcont  = 0   && numeric(1,0)
    this_nIntvlricms  = 0   && numeric(1,0)
    this_nIntvlripi   = 0   && numeric(1,0)
    this_nIcmsincs    = 0   && numeric(1,0)
    this_nIncicmnfs   = 0   && numeric(1,0)
    this_nTipos       = 0   && numeric(1,0)
    this_nUtilvars    = 0   && numeric(1,0)
    this_nIndmov      = 0   && numeric(1,0)
    this_nIndpagto    = 0   && numeric(1,0)
    this_nTiporecs    = 0   && numeric(1,0)
    this_nAliqcofins  = 0   && numeric(5,2)
    this_nAliqpis     = 0   && numeric(5,2)
    this_nAliqissqn   = 0   && numeric(5,2)
    this_nCtissqn     = 0   && numeric(1,0)
    this_nRettribs    = 0   && numeric(1,0)
    this_nAliqii      = 0   && numeric(5,2)
    this_nObspads     = 0   && numeric(3,0)
    this_nSomaicmfrete = 0  && numeric(1,0)

    *============================================================
    PROCEDURE Init()
    *============================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIpi_Icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCfo (
                    codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                    icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                    conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                    aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                    agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                    desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                    segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                    ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                    icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                    indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                    aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                    cfost60s, obspads, ipienq, somaicmfrete, motdeson
                ) VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cContconts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    <<EscaparSQL(THIS.this_cContribs)>>,
                    <<EscaparSQL(THIS.this_cDescricaos)>>,
                    <<EscaparSQL(THIS.this_cDesc2s)>>,
                    <<EscaparSQL(THIS.this_cIcms)>>,
                    <<EscaparSQL(THIS.this_cIpis)>>,
                    <<EscaparSQL(THIS.this_cOperacaos)>>,
                    <<EscaparSQL(THIS.this_cContvcds)>>,
                    <<EscaparSQL(THIS.this_cContvccs)>>,
                    <<EscaparSQL(THIS.this_cContipcs)>>,
                    <<EscaparSQL(THIS.this_cContipds)>>,
                    <<EscaparSQL(THIS.this_cConticcs)>>,
                    <<EscaparSQL(THIS.this_cConticds)>>,
                    <<EscaparSQL(THIS.this_cCoddests)>>,
                    <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    <<EscaparSQL(THIS.this_cSittribs)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cBcipis)>>,
                    <<EscaparSQL(THIS.this_cCfosts)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    <<EscaparSQL(THIS.this_cSubtribs)>>,
                    <<EscaparSQL(THIS.this_cAcresipis)>>,
                    <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    <<EscaparSQL(THIS.this_cUnitimps)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    <<EscaparSQL(THIS.this_cContda)>>,
                    <<EscaparSQL(THIS.this_cContfrt)>>,
                    <<EscaparSQL(THIS.this_cContseg)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    <<EscaparSQL(THIS.this_cIpicst)>>,
                    <<EscaparSQL(THIS.this_cPiscst)>>,
                    <<EscaparSQL(THIS.this_cCofcst)>>,
                    <<EscaparSQL(THIS.this_cIssqnl)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    <<EscaparSQL(THIS.this_cCfost60s)>>,
                    <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    <<EscaparSQL(THIS.this_cIpienq)>>,
                    <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    <<EscaparSQL(THIS.this_cMotdeson)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCfo SET
                    contconts    = <<EscaparSQL(THIS.this_cContconts)>>,
                    aliqipis     = <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    contribs     = <<EscaparSQL(THIS.this_cContribs)>>,
                    descricaos   = <<EscaparSQL(THIS.this_cDescricaos)>>,
                    desc2s       = <<EscaparSQL(THIS.this_cDesc2s)>>,
                    icms         = <<EscaparSQL(THIS.this_cIcms)>>,
                    ipis         = <<EscaparSQL(THIS.this_cIpis)>>,
                    operacaos    = <<EscaparSQL(THIS.this_cOperacaos)>>,
                    contvcds     = <<EscaparSQL(THIS.this_cContvcds)>>,
                    contvccs     = <<EscaparSQL(THIS.this_cContvccs)>>,
                    contipcs     = <<EscaparSQL(THIS.this_cContipcs)>>,
                    contipds     = <<EscaparSQL(THIS.this_cContipds)>>,
                    conticcs     = <<EscaparSQL(THIS.this_cConticcs)>>,
                    conticds     = <<EscaparSQL(THIS.this_cConticds)>>,
                    coddests     = <<EscaparSQL(THIS.this_cCoddests)>>,
                    ipincreds    = <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    pontedescs   = <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    sittribs     = <<EscaparSQL(THIS.this_cSittribs)>>,
                    aliqivcs     = <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    ndigitos     = <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    ipi_icms     = <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    inclicms     = <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    cgergia1s    = <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    transps      = <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    agrupas      = <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    zeradas      = <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    icmsdscs     = <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    inclipis     = <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    situas       = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    bcipis       = <<EscaparSQL(THIS.this_cBcipis)>>,
                    cfosts       = <<EscaparSQL(THIS.this_cCfosts)>>,
                    desicms      = <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    desipis      = <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    frticms      = <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    frtipis      = <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    pbcipis      = <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    pbcsts       = <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    segicms      = <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    segipis      = <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    subtribs     = <<EscaparSQL(THIS.this_cSubtribs)>>,
                    acresipis    = <<EscaparSQL(THIS.this_cAcresipis)>>,
                    ipiimpors    = <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    dtintfis     = <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    ipiom2s      = <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    unitimps     = <<EscaparSQL(THIS.this_cUnitimps)>>,
                    intvlrcont   = <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    intvlricms   = <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    intvlripi    = <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    icmsincs     = <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    incicmnfs    = <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    tipos        = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    utilvars     = <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    contda       = <<EscaparSQL(THIS.this_cContda)>>,
                    contfrt      = <<EscaparSQL(THIS.this_cContfrt)>>,
                    contseg      = <<EscaparSQL(THIS.this_cContseg)>>,
                    indmov       = <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    indpagto     = <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    tiporecs     = <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    ipicst       = <<EscaparSQL(THIS.this_cIpicst)>>,
                    piscst       = <<EscaparSQL(THIS.this_cPiscst)>>,
                    cofcst       = <<EscaparSQL(THIS.this_cCofcst)>>,
                    issqnl       = <<EscaparSQL(THIS.this_cIssqnl)>>,
                    aliqcofins   = <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    aliqissqn    = <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    ctissqn      = <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    rettribs     = <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    aliqii       = <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    cfost60s     = <<EscaparSQL(THIS.this_cCfost60s)>>,
                    obspads      = <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    ipienq       = <<EscaparSQL(THIS.this_cIpienq)>>,
                    somaicmfrete = <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    motdeson     = <<EscaparSQL(THIS.this_cMotdeson)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCfo WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid (codigos, descricaos, situas)
    * DynamicForeColor usa situas para destacar registros inativos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, situas FROM SigCdCfo"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                       icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                       conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                       aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                       agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                       desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                       segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                       ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                       icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                       indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                       aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                       cfost60s, obspads, ipienq, somaicmfrete, motdeson
                FROM SigCdCfo
                WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCfo")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCfo")
                SELECT cursor_4c_ChkCfo
                loc_lExiste = (cursor_4c_ChkCfo.nExiste > 0)
                USE IN cursor_4c_ChkCfo
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "cfoBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

