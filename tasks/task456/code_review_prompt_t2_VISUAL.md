# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Entrada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Situação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Dt. Entrada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Situação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formlch.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (4983 linhas total):

*-- Linhas 56 a 65:
56:                 MsgErro("Falha ao criar lchBO", "Erro")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Visible    = .T.
62:                 THIS.pgf_4c_Paginas.ActivePage = 1
63:                 THIS.this_cModoAtual = "LISTA"
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                     THIS.CarregarLista()

*-- Linhas 81 a 415:
81:         loc_oPgf = THIS.pgf_4c_Paginas
82:         WITH loc_oPgf
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.BackColor = RGB(100, 100, 100)
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page2.Caption   = "Dados"
94:             .Page2.BackColor = RGB(100, 100, 100)
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97:         THIS.ConfigurarPaginaLista()
98:         THIS.ConfigurarPaginaDados()
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
103:     * +29 em todos os Top pelo PageFrame.Top=-29
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
107:         LOCAL loc_oCnt, loc_oCntP
108: 
109:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Cabecalho cinza
112:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
113:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
114:         WITH loc_oCab
115:             .Top = 29
116:             .Left = 0
117:             .Width = THIS.Width
118:             .Height = 80
119:             .BackColor = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible = .T.
122:         ENDWITH
123: 
124:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
125:         WITH loc_oCab.lbl_4c_Sombra
126:             .Caption = THIS.Caption
127:             .AutoSize = .F.
128:             .Width = THIS.Width
129:             .Height = 40
130:             .Top = 15
131:             .Left = 10
132:             .FontName = "Tahoma"
133:             .FontSize = 16
134:             .FontBold = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .Visible = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oCab.lbl_4c_Titulo
142:             .Caption = THIS.Caption
143:             .AutoSize = .F.
144:             .Width = THIS.Width
145:             .Height = 46
146:             .Top = 18
147:             .Left = 10
148:             .FontName = "Tahoma"
149:             .FontSize = 16
150:             .FontBold = .T.
151:             .ForeColor = RGB(255, 255, 255)
152:             .BackStyle = 0
153:             .Visible = .T.
154:         ENDWITH
155: 
156:         *-- Botoes CRUD
157:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
158:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
159:         WITH loc_oBotoes
160:             .Top = 29
161:             .Left = 542
162:             .Width = 385
163:             .Height = 85
164:             .BackStyle = 1
165:             .BackColor = RGB(53, 53, 53)
166:             .BorderWidth = 0
167:             .Visible = .T.
168:         ENDWITH
169: 
170:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
171:         WITH loc_oBotoes.cmd_4c_Incluir
172:             .Top = 5
173:             .Left = 5
174:             .Width = 75
175:             .Height = 75
176:             .Caption = "Incluir"
177:             .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .FontName = "Tahoma"
180:             .FontBold = .T.
181:             .FontItalic = .T.
182:             .FontSize = 8
183:             .ForeColor = RGB(90, 90, 90)
184:             .BackColor = RGB(255, 255, 255)
185:             .Themes = .F.
186:             .SpecialEffect = 0
187:             .Visible = .T.
188:         ENDWITH
189:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
190: 
191:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oBotoes.cmd_4c_Visualizar
193:             .Top = 5
194:             .Left = 80
195:             .Width = 75
196:             .Height = 75
197:             .Caption = "Visualizar"
198:             .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
199:             .PicturePosition = 13
200:             .FontName = "Tahoma"
201:             .FontBold = .T.
202:             .FontItalic = .T.
203:             .FontSize = 8
204:             .ForeColor = RGB(90, 90, 90)
205:             .BackColor = RGB(255, 255, 255)
206:             .Themes = .F.
207:             .SpecialEffect = 0
208:             .Visible = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
211: 
212:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
213:         WITH loc_oBotoes.cmd_4c_Alterar
214:             .Top = 5
215:             .Left = 155
216:             .Width = 75
217:             .Height = 75
218:             .Caption = "Alterar"
219:             .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .FontName = "Tahoma"
222:             .FontBold = .T.
223:             .FontItalic = .T.
224:             .FontSize = 8
225:             .ForeColor = RGB(90, 90, 90)
226:             .BackColor = RGB(255, 255, 255)
227:             .Themes = .F.
228:             .SpecialEffect = 0
229:             .Visible = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
234:         WITH loc_oBotoes.cmd_4c_Excluir
235:             .Top = 5
236:             .Left = 230
237:             .Width = 75
238:             .Height = 75
239:             .Caption = "Excluir"
240:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:             .PicturePosition = 13
242:             .FontName = "Tahoma"
243:             .FontBold = .T.
244:             .FontItalic = .T.
245:             .FontSize = 8
246:             .ForeColor = RGB(90, 90, 90)
247:             .BackColor = RGB(255, 255, 255)
248:             .Themes = .F.
249:             .SpecialEffect = 0
250:             .Visible = .T.
251:         ENDWITH
252:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
253: 
254:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
255:         WITH loc_oBotoes.cmd_4c_Buscar
256:             .Top = 5
257:             .Left = 305
258:             .Width = 75
259:             .Height = 75
260:             .Caption = "Buscar"
261:             .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
262:             .PicturePosition = 13
263:             .FontName = "Tahoma"
264:             .FontBold = .T.
265:             .FontItalic = .T.
266:             .FontSize = 8
267:             .ForeColor = RGB(90, 90, 90)
268:             .BackColor = RGB(255, 255, 255)
269:             .Themes = .F.
270:             .SpecialEffect = 0
271:             .Visible = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
274: 
275:         *-- Saida canonico (Left=917)
276:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
277:         loc_oSaida = loc_oPg1.cnt_4c_Saida
278:         WITH loc_oSaida
279:             .Top = 29
280:             .Left = 917
281:             .Width = 90
282:             .Height = 85
283:             .BackStyle = 0
284:             .BorderWidth = 0
285:             .Visible = .T.
286:         ENDWITH
287: 
288:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
289:         WITH loc_oSaida.cmd_4c_Encerrar
290:             .Top = 5
291:             .Left = 5
292:             .Width = 75
293:             .Height = 75
294:             .Caption = "Encerrar"
295:             .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .PicturePosition = 13
297:             .FontName = "Tahoma"
298:             .FontBold = .T.
299:             .FontItalic = .T.
300:             .FontSize = 8
301:             .ForeColor = RGB(90, 90, 90)
302:             .BackColor = RGB(255, 255, 255)
303:             .Themes = .F.
304:             .SpecialEffect = 0
305:             .Visible = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
308: 
309:         *-- Filtro de periodo (cntFiltros > cnt__periodo > Dt_inicial/Dt_final)
310:         *-- original top=86+29=115
311:         loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
312:         loc_oCnt = loc_oPg1.cnt_4c_Filtros
313:         WITH loc_oCnt
314:             .Top = 115
315:             .Left = 5
316:             .Width = 267
317:             .Height = 46
318:             .BackStyle = 0
319:             .BorderWidth = 0
320:             .Visible = .T.
321:         ENDWITH
322: 
323:         loc_oCnt.AddObject("cnt_4c__periodo", "Container")
324:         loc_oCntP = loc_oCnt.cnt_4c__periodo
325:         WITH loc_oCntP
326:             .Top = 3
327:             .Left = 0
328:             .Width = 267
329:             .Height = 40
330:             .BackStyle = 0
331:             .BorderWidth = 0
332:             .Visible = .T.
333:         ENDWITH
334: 
335:         loc_oCntP.AddObject("lbl_4c_LblPeriodo", "Label")
336:         WITH loc_oCntP.lbl_4c_LblPeriodo
337:             .Caption = "Per" + CHR(237) + "odo : "
338:             .Top = 6
339:             .Left = 23
340:             .Width = 48
341:             .Height = 15
342:             .AutoSize = .F.
343:             .FontName = "Tahoma"
344:             .FontSize = 8
345:             .ForeColor = RGB(255, 255, 255)
346:             .BackStyle = 0
347:             .Visible = .T.
348:         ENDWITH
349: 
350:         loc_oCntP.AddObject("txt_4c_Dt_inicial", "TextBox")
351:         WITH loc_oCntP.txt_4c_Dt_inicial
352:             .Top = 2
353:             .Left = 70
354:             .Width = 80
355:             .Height = 21
356:             .Value = {}
357:             .InputMask = "@D"
358:             .FontName = "Tahoma"
359:             .FontSize = 8
360:             .Visible = .T.
361:         ENDWITH
362: 
363:         loc_oCntP.AddObject("lbl_4c_Sep", "Label")
364:         WITH loc_oCntP.lbl_4c_Sep
365:             .Caption = CHR(224)
366:             .Top = 6
367:             .Left = 152
368:             .Width = 10
369:             .Height = 15
370:             .AutoSize = .F.
371:             .FontName = "Tahoma"
372:             .FontSize = 8
373:             .ForeColor = RGB(255, 255, 255)
374:             .BackStyle = 0
375:             .Visible = .T.
376:         ENDWITH
377: 
378:         loc_oCntP.AddObject("txt_4c_Dt_final", "TextBox")
379:         WITH loc_oCntP.txt_4c_Dt_final
380:             .Top = 2
381:             .Left = 167
382:             .Width = 80
383:             .Height = 21
384:             .Value = {}
385:             .InputMask = "@D"
386:             .FontName = "Tahoma"
387:             .FontSize = 8
388:             .Visible = .T.
389:         ENDWITH
390: 
391:         *-- Situacao (Cmb_Concilia) - top=113+29=142
392:         loc_oPg1.AddObject("lbl_4c_Situacao", "Label")
393:         WITH loc_oPg1.lbl_4c_Situacao
394:             .Caption = "Situa" + CHR(231) + CHR(227) + "o :"
395:             .Top = 146
396:             .Left = 39
397:             .Width = 55
398:             .Height = 15
399:             .AutoSize = .F.
400:             .FontName = "Tahoma"
401:             .FontSize = 8
402:             .ForeColor = RGB(255, 255, 255)
403:             .BackStyle = 0
404:             .Visible = .T.
405:         ENDWITH
406: 
407:         loc_oPg1.AddObject("cbo_4c_Cmb_Concilia", "ComboBox")
408:         WITH loc_oPg1.cbo_4c_Cmb_Concilia
409:             .Top = 142
410:             .Left = 96
411:             .Width = 178
412:             .Height = 24
413:             .RowSourceType = 1
414:             .RowSource = "Todos,Conciliados,Pendentes,Ambos"
415:             .Style = 2

*-- Linhas 421 a 472:
421:         BINDEVENT(loc_oPg1.cbo_4c_Cmb_Concilia, "InteractiveChange", THIS, "CboConcilaChange")
422: 
423:         *-- Botao Limpar Data - top=86+29=115, left=271
424:         loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
425:         WITH loc_oPg1.cmd_4c_LimpaDT
426:             .Top = 115
427:             .Left = 271
428:             .Width = 75
429:             .Height = 75
430:             .Caption = "Limpar Data"
431:             .FontName = "Tahoma"
432:             .FontBold = .F.
433:             .FontSize = 8
434:             .ForeColor = RGB(90, 90, 90)
435:             .BackColor = RGB(255, 255, 255)
436:             .Themes = .F.
437:             .SpecialEffect = 0
438:             .Visible = .T.
439:         ENDWITH
440:         BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")
441: 
442:         *-- Botao Conciliacao - top=86+29=115, left=347
443:         loc_oPg1.AddObject("cmd_4c_Conciliacao", "CommandButton")
444:         WITH loc_oPg1.cmd_4c_Conciliacao
445:             .Top = 115
446:             .Left = 347
447:             .Width = 75
448:             .Height = 75
449:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o"
450:             .FontName = "Tahoma"
451:             .FontBold = .F.
452:             .FontSize = 8
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackColor = RGB(255, 255, 255)
455:             .Themes = .F.
456:             .SpecialEffect = 0
457:             .Visible = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPg1.cmd_4c_Conciliacao, "Click", THIS, "BtnConciliacaoClick")
460: 
461:         *-- Grid lista de lotes - top=193, left=5
462:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
463:         loc_oGrid = loc_oPg1.grd_4c_Dados
464:         loc_oGrid.ColumnCount = 6
465:         WITH loc_oGrid
466:             .Top = 193
467:             .Left = 5
468:             .Width = 990
469:             .Height = 435
470:             .FontName = "Verdana"
471:             .FontSize = 8
472:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 484 a 520:
484:         ENDWITH
485:         WITH loc_oGrid.Column1
486:             .Width = 60
487:             .Header1.Caption = "Lote"
488:         ENDWITH
489:         WITH loc_oGrid.Column2
490:             .Width = 80
491:             .Header1.Caption = "Emp"
492:         ENDWITH
493:         WITH loc_oGrid.Column3
494:             .Width = 90
495:             .Header1.Caption = "Dt. Entrada"
496:         ENDWITH
497:         WITH loc_oGrid.Column4
498:             .Width = 100
499:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
500:         ENDWITH
501:         WITH loc_oGrid.Column5
502:             .Width = 110
503:             .Header1.Caption = "Valor"
504:         ENDWITH
505:         WITH loc_oGrid.Column6
506:             .Width = 80
507:             .Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
508:         ENDWITH
509: 
510:         THIS.TornarControlesVisiveis(loc_oPg1)
511:     ENDPROC
512: 
513:     *--------------------------------------------------------------------------
514:     * ConfigurarPaginaDados - Page2: todos os containers e campos de edicao
515:     * Posicoes: layout.json + 29 (compensacao PageFrame.Top=-29)
516:     *--------------------------------------------------------------------------
517:     PROTECTED PROCEDURE ConfigurarPaginaDados()
518:         LOCAL loc_oPg2, loc_oSalva, loc_oInf, loc_oOrig, loc_oDes
519:         LOCAL loc_oDst, loc_oCC, loc_oCart, loc_oProc, loc_oEmiss
520:         LOCAL loc_oGrd, loc_oChe, loc_oEmp, loc_oCnt, loc_oFil

*-- Linhas 529 a 667:
529:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
530:         loc_oSalva = loc_oPg2.cnt_4c_Salva
531:         WITH loc_oSalva
532:             .Top = 29
533:             .Left = 853
534:             .Width = 160
535:             .Height = 85
536:             .BackStyle = 0
537:             .BorderWidth = 0
538:             .Visible = .T.
539:         ENDWITH
540: 
541:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
542:         WITH loc_oSalva.cmd_4c_Confirmar
543:             .Top = 5
544:             .Left = 5
545:             .Width = 75
546:             .Height = 75
547:             .Caption = "Confirmar"
548:             .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
549:             .PicturePosition = 13
550:             .FontName = "Tahoma"
551:             .FontBold = .T.
552:             .FontItalic = .T.
553:             .FontSize = 8
554:             .ForeColor = RGB(90, 90, 90)
555:             .BackColor = RGB(255, 255, 255)
556:             .Themes = .F.
557:             .SpecialEffect = 0
558:             .Visible = .T.
559:         ENDWITH
560:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
561: 
562:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
563:         WITH loc_oSalva.cmd_4c_Cancelar
564:             .Top = 5
565:             .Left = 80
566:             .Width = 75
567:             .Height = 75
568:             .Caption = "Encerrar"
569:             .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:             .PicturePosition = 13
571:             .FontName = "Tahoma"
572:             .FontBold = .T.
573:             .FontItalic = .T.
574:             .FontSize = 8
575:             .ForeColor = RGB(90, 90, 90)
576:             .BackColor = RGB(255, 255, 255)
577:             .Themes = .F.
578:             .SpecialEffect = 0
579:             .Visible = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
582: 
583:         *=====================================================================
584:         *-- Linha 1: Usuario / Lote / Data
585:         *-- original: top=9+29=38 (textboxes), top=12+29=41 (labels)
586:         *=====================================================================
587:         loc_oPg2.AddObject("lbl_4c_Usuar", "Label")
588:         WITH loc_oPg2.lbl_4c_Usuar
589:             .Caption = "Usu" + CHR(225) + "rio :"
590:             .Top = 41
591:             .Left = 36
592:             .Width = 52
593:             .Height = 18
594:             .AutoSize = .F.
595:             .FontName = "Tahoma"
596:             .FontSize = 8
597:             .ForeColor = RGB(255, 255, 255)
598:             .BackStyle = 0
599:             .Visible = .T.
600:         ENDWITH
601: 
602:         loc_oPg2.AddObject("txt_4c_Usuar", "TextBox")
603:         WITH loc_oPg2.txt_4c_Usuar
604:             .Top = 38
605:             .Left = 86
606:             .Width = 80
607:             .Height = 21
608:             .MaxLength = 15
609:             .Value = ""
610:             .ReadOnly = .T.
611:             .FontName = "Tahoma"
612:             .FontSize = 8
613:             .Visible = .T.
614:         ENDWITH
615: 
616:         loc_oPg2.AddObject("lbl_4c_Lote", "Label")
617:         WITH loc_oPg2.lbl_4c_Lote
618:             .Caption = "Lote :"
619:             .Top = 41
620:             .Left = 181
621:             .Width = 32
622:             .Height = 18
623:             .AutoSize = .F.
624:             .FontName = "Tahoma"
625:             .FontSize = 8
626:             .ForeColor = RGB(255, 255, 255)
627:             .BackStyle = 0
628:             .Visible = .T.
629:         ENDWITH
630: 
631:         loc_oPg2.AddObject("txt_4c_Lote", "TextBox")
632:         WITH loc_oPg2.txt_4c_Lote
633:             .Top = 38
634:             .Left = 215
635:             .Width = 70
636:             .Height = 21
637:             .Value = 0
638:             .ReadOnly = .T.
639:             .FontName = "Tahoma"
640:             .FontSize = 8
641:             .Visible = .T.
642:         ENDWITH
643: 
644:         loc_oPg2.AddObject("lbl_4c_DataEnt", "Label")
645:         WITH loc_oPg2.lbl_4c_DataEnt
646:             .Caption = "Data :"
647:             .Top = 41
648:             .Left = 300
649:             .Width = 35
650:             .Height = 18
651:             .AutoSize = .F.
652:             .FontName = "Tahoma"
653:             .FontSize = 8
654:             .ForeColor = RGB(255, 255, 255)
655:             .BackStyle = 0
656:             .Visible = .T.
657:         ENDWITH
658: 
659:         loc_oPg2.AddObject("txt_4c_Data", "TextBox")
660:         WITH loc_oPg2.txt_4c_Data
661:             .Top = 38
662:             .Left = 337
663:             .Width = 85
664:             .Height = 21
665:             .Value = {}
666:             .InputMask = "@D"
667:             .FontName = "Tahoma"

*-- Linhas 673 a 732:
673:         *-- original: top=30+29=59, left=209
674:         loc_oPg2.AddObject("opt_4c_SNA", "OptionGroup")
675:         WITH loc_oPg2.opt_4c_SNA
676:             .Top = 59
677:             .Left = 209
678:             .Width = 153
679:             .Height = 25
680:             .ButtonCount = 3
681:             .BackStyle = 0
682:             .Value = 1
683:             .Visible = .T.
684:             .Buttons(1).Caption  = "Todos"
685:             .Buttons(1).Left     = 0
686:             .Buttons(1).Top      = 0
687:             .Buttons(1).Width    = 51
688:             .Buttons(1).AutoSize = .F.
689:             .Buttons(1).ForeColor = RGB(255, 255, 255)
690:             .Buttons(1).Themes   = .F.
691:             .Buttons(2).Caption  = "Pend."
692:             .Buttons(2).Left     = 51
693:             .Buttons(2).Top      = 0
694:             .Buttons(2).Width    = 51
695:             .Buttons(2).AutoSize = .F.
696:             .Buttons(2).ForeColor = RGB(255, 255, 255)
697:             .Buttons(2).Themes   = .F.
698:             .Buttons(3).Caption  = "Concil."
699:             .Buttons(3).Left     = 102
700:             .Buttons(3).Top      = 0
701:             .Buttons(3).Width    = 51
702:             .Buttons(3).AutoSize = .F.
703:             .Buttons(3).ForeColor = RGB(255, 255, 255)
704:             .Buttons(3).Themes   = .F.
705:         ENDWITH
706:         BINDEVENT(loc_oPg2.opt_4c_SNA, "InteractiveChange", THIS, "OptSNAChange")
707: 
708:         *-- Movimento / Operacao - original: top=32+29=61 (txt), top=35+29=64 (lbl)
709:         loc_oPg2.AddObject("lbl_4c_Movimento", "Label")
710:         WITH loc_oPg2.lbl_4c_Movimento
711:             .Caption = "Movimento :"
712:             .Top = 64
713:             .Left = 23
714:             .Width = 62
715:             .Height = 18
716:             .AutoSize = .F.
717:             .FontName = "Tahoma"
718:             .FontSize = 8
719:             .ForeColor = RGB(255, 255, 255)
720:             .BackStyle = 0
721:             .Visible = .T.
722:         ENDWITH
723: 
724:         loc_oPg2.AddObject("txt_4c_Oper", "TextBox")
725:         WITH loc_oPg2.txt_4c_Oper
726:             .Top = 61
727:             .Left = 86
728:             .Width = 117
729:             .Height = 21
730:             .MaxLength = 15
731:             .Value = ""
732:             .FontName = "Tahoma"

*-- Linhas 742 a 904:
742:         loc_oPg2.AddObject("cnt_4c_Infos", "Container")
743:         loc_oInf = loc_oPg2.cnt_4c_Infos
744:         WITH loc_oInf
745:             .Top = 81
746:             .Left = 6
747:             .Width = 464
748:             .Height = 53
749:             .BackStyle = 1
750:             .BackColor = RGB(235, 235, 235)
751:             .BorderWidth = 1
752:             .Visible = .T.
753:         ENDWITH
754: 
755:         loc_oInf.AddObject("lbl_4c_Cheques", "Label")
756:         WITH loc_oInf.lbl_4c_Cheques
757:             .Caption = "Cheques :"
758:             .Top = 6
759:             .Left = 27
760:             .Width = 52
761:             .Height = 15
762:             .AutoSize = .F.
763:             .FontName = "Tahoma"
764:             .FontSize = 8
765:             .BackStyle = 0
766:             .Visible = .T.
767:         ENDWITH
768: 
769:         loc_oInf.AddObject("txt_4c_Qtde", "TextBox")
770:         WITH loc_oInf.txt_4c_Qtde
771:             .Top = 3
772:             .Left = 80
773:             .Width = 70
774:             .Height = 21
775:             .Value = 0
776:             .ReadOnly = .T.
777:             .FontName = "Tahoma"
778:             .FontSize = 8
779:             .Visible = .T.
780:         ENDWITH
781: 
782:         loc_oInf.AddObject("lbl_4c_Moeda", "Label")
783:         WITH loc_oInf.lbl_4c_Moeda
784:             .Caption = "Moeda :"
785:             .Top = 6
786:             .Left = 159
787:             .Width = 42
788:             .Height = 15
789:             .AutoSize = .F.
790:             .FontName = "Tahoma"
791:             .FontSize = 8
792:             .BackStyle = 0
793:             .Visible = .T.
794:         ENDWITH
795: 
796:         loc_oInf.AddObject("txt_4c_Moeda", "TextBox")
797:         WITH loc_oInf.txt_4c_Moeda
798:             .Top = 3
799:             .Left = 202
800:             .Width = 32
801:             .Height = 21
802:             .MaxLength = 5
803:             .Value = ""
804:             .FontName = "Tahoma"
805:             .FontSize = 8
806:             .Visible = .T.
807:         ENDWITH
808:         BINDEVENT(loc_oInf.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
809: 
810:         loc_oInf.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
811:         WITH loc_oInf.cmd_4c_AlteraCotacao
812:             .Top = 1
813:             .Left = 236
814:             .Width = 24
815:             .Height = 23
816:             .Caption = "$"
817:             .FontName = "Tahoma"
818:             .FontBold = .T.
819:             .FontSize = 10
820:             .BackColor = RGB(255, 255, 255)
821:             .Themes = .T.
822:             .SpecialEffect = 0
823:             .Visible = .T.
824:         ENDWITH
825:         BINDEVENT(loc_oInf.cmd_4c_AlteraCotacao, "Click", THIS, "BtnAlteraCotacaoClick")
826: 
827:         loc_oInf.AddObject("lbl_4c_Cotacao", "Label")
828:         WITH loc_oInf.lbl_4c_Cotacao
829:             .Caption = "Cota" + CHR(231) + CHR(227) + "o :"
830:             .Top = 6
831:             .Left = 281
832:             .Width = 50
833:             .Height = 15
834:             .AutoSize = .F.
835:             .FontName = "Tahoma"
836:             .FontSize = 8
837:             .BackStyle = 0
838:             .Visible = .T.
839:         ENDWITH
840: 
841:         loc_oInf.AddObject("txt_4c_Cotacao", "TextBox")
842:         WITH loc_oInf.txt_4c_Cotacao
843:             .Top = 3
844:             .Left = 332
845:             .Width = 108
846:             .Height = 21
847:             .Value = 0
848:             .InputMask = "99999999.9999"
849:             .FontName = "Tahoma"
850:             .FontSize = 8
851:             .Visible = .T.
852:         ENDWITH
853: 
854:         loc_oInf.AddObject("lbl_4c_Valor", "Label")
855:         WITH loc_oInf.lbl_4c_Valor
856:             .Caption = "Valor :"
857:             .Top = 29
858:             .Left = 45
859:             .Width = 35
860:             .Height = 15
861:             .AutoSize = .F.
862:             .FontName = "Tahoma"
863:             .FontSize = 8
864:             .BackStyle = 0
865:             .Visible = .T.
866:         ENDWITH
867: 
868:         loc_oInf.AddObject("txt_4c_Valor", "TextBox")
869:         WITH loc_oInf.txt_4c_Valor
870:             .Top = 26
871:             .Left = 80
872:             .Width = 154
873:             .Height = 21
874:             .Value = 0
875:             .ReadOnly = .T.
876:             .InputMask = "999999999.99"
877:             .FontName = "Tahoma"
878:             .FontSize = 8
879:             .Visible = .T.
880:         ENDWITH
881: 
882:         loc_oInf.AddObject("lbl_4c_ValConv", "Label")
883:         WITH loc_oInf.lbl_4c_ValConv
884:             .Caption = "Convertido :"
885:             .Top = 29
886:             .Left = 268
887:             .Width = 62
888:             .Height = 15
889:             .AutoSize = .F.
890:             .FontName = "Tahoma"
891:             .FontSize = 8
892:             .BackStyle = 0
893:             .Visible = .T.
894:         ENDWITH
895: 
896:         loc_oInf.AddObject("txt_4c_ValConv", "TextBox")
897:         WITH loc_oInf.txt_4c_ValConv
898:             .Top = 26
899:             .Left = 332
900:             .Width = 108
901:             .Height = 21
902:             .Value = 0
903:             .ReadOnly = .T.
904:             .InputMask = "999999999.99"

*-- Linhas 913 a 1031:
913:         loc_oPg2.AddObject("cnt_4c_Origem", "Container")
914:         loc_oOrig = loc_oPg2.cnt_4c_Origem
915:         WITH loc_oOrig
916:             .Top = 135
917:             .Left = 6
918:             .Width = 464
919:             .Height = 58
920:             .BackStyle = 1
921:             .BackColor = RGB(235, 235, 235)
922:             .BorderWidth = 1
923:             .Visible = .T.
924:         ENDWITH
925: 
926:         loc_oOrig.AddObject("lbl_4c_TitOrigem", "Label")
927:         WITH loc_oOrig.lbl_4c_TitOrigem
928:             .Caption = "Origem"
929:             .Top = 0
930:             .Left = 4
931:             .Width = 60
932:             .Height = 14
933:             .AutoSize = .F.
934:             .FontName = "Tahoma"
935:             .FontSize = 8
936:             .FontBold = .T.
937:             .BackStyle = 0
938:             .Visible = .T.
939:         ENDWITH
940: 
941:         loc_oOrig.AddObject("lbl_4c_GruOrig", "Label")
942:         WITH loc_oOrig.lbl_4c_GruOrig
943:             .Caption = "Grupo :"
944:             .Top = 15
945:             .Left = 18
946:             .Width = 42
947:             .Height = 15
948:             .AutoSize = .F.
949:             .FontName = "Tahoma"
950:             .FontSize = 8
951:             .BackStyle = 0
952:             .Visible = .T.
953:         ENDWITH
954: 
955:         loc_oOrig.AddObject("txt_4c_GruOrig", "TextBox")
956:         WITH loc_oOrig.txt_4c_GruOrig
957:             .Top = 12
958:             .Left = 61
959:             .Width = 79
960:             .Height = 21
961:             .MaxLength = 10
962:             .Value = ""
963:             .FontName = "Tahoma"
964:             .FontSize = 8
965:             .Visible = .T.
966:         ENDWITH
967:         BINDEVENT(loc_oOrig.txt_4c_GruOrig, "KeyPress", THIS, "ValidarGrupoOrig")
968: 
969:         loc_oOrig.AddObject("txt_4c_DGruOrig", "TextBox")
970:         WITH loc_oOrig.txt_4c_DGruOrig
971:             .Top = 12
972:             .Left = 142
973:             .Width = 319
974:             .Height = 21
975:             .Value = ""
976:             .ReadOnly = .T.
977:             .FontName = "Tahoma"
978:             .FontSize = 8
979:             .Visible = .T.
980:         ENDWITH
981: 
982:         loc_oOrig.AddObject("lbl_4c_ConOrig", "Label")
983:         WITH loc_oOrig.lbl_4c_ConOrig
984:             .Caption = "Conta :"
985:             .Top = 38
986:             .Left = 18
987:             .Width = 42
988:             .Height = 15
989:             .AutoSize = .F.
990:             .FontName = "Tahoma"
991:             .FontSize = 8
992:             .BackStyle = 0
993:             .Visible = .T.
994:         ENDWITH
995: 
996:         loc_oOrig.AddObject("txt_4c_ConOrig", "TextBox")
997:         WITH loc_oOrig.txt_4c_ConOrig
998:             .Top = 35
999:             .Left = 61
1000:             .Width = 79
1001:             .Height = 21
1002:             .MaxLength = 10
1003:             .Value = ""
1004:             .FontName = "Tahoma"
1005:             .FontSize = 8
1006:             .Visible = .T.
1007:         ENDWITH
1008:         BINDEVENT(loc_oOrig.txt_4c_ConOrig, "KeyPress", THIS, "ValidarContaOrig")
1009: 
1010:         loc_oOrig.AddObject("txt_4c_CpfOrig", "TextBox")
1011:         WITH loc_oOrig.txt_4c_CpfOrig
1012:             .Top = 35
1013:             .Left = 142
1014:             .Width = 115
1015:             .Height = 21
1016:             .MaxLength = 14
1017:             .Value = ""
1018:             .FontName = "Tahoma"
1019:             .FontSize = 8
1020:             .Visible = .T.
1021:         ENDWITH
1022: 
1023:         loc_oOrig.AddObject("txt_4c_DConOrig", "TextBox")
1024:         WITH loc_oOrig.txt_4c_DConOrig
1025:             .Top = 35
1026:             .Left = 259
1027:             .Width = 202
1028:             .Height = 21
1029:             .Value = ""
1030:             .ReadOnly = .T.
1031:             .FontName = "Tahoma"

*-- Linhas 1039 a 1157:
1039:         loc_oPg2.AddObject("cnt_4c_Despesa", "Container")
1040:         loc_oDes = loc_oPg2.cnt_4c_Despesa
1041:         WITH loc_oDes
1042:             .Top = 135
1043:             .Left = 497
1044:             .Width = 464
1045:             .Height = 58
1046:             .BackStyle = 1
1047:             .BackColor = RGB(235, 235, 235)
1048:             .BorderWidth = 1
1049:             .Visible = .T.
1050:         ENDWITH
1051: 
1052:         loc_oDes.AddObject("lbl_4c_TitDespesa", "Label")
1053:         WITH loc_oDes.lbl_4c_TitDespesa
1054:             .Caption = "Despesa"
1055:             .Top = 0
1056:             .Left = 4
1057:             .Width = 60
1058:             .Height = 14
1059:             .AutoSize = .F.
1060:             .FontName = "Tahoma"
1061:             .FontSize = 8
1062:             .FontBold = .T.
1063:             .BackStyle = 0
1064:             .Visible = .T.
1065:         ENDWITH
1066: 
1067:         loc_oDes.AddObject("lbl_4c_GruEmts", "Label")
1068:         WITH loc_oDes.lbl_4c_GruEmts
1069:             .Caption = "Grupo :"
1070:             .Top = 15
1071:             .Left = 18
1072:             .Width = 42
1073:             .Height = 15
1074:             .AutoSize = .F.
1075:             .FontName = "Tahoma"
1076:             .FontSize = 8
1077:             .BackStyle = 0
1078:             .Visible = .T.
1079:         ENDWITH
1080: 
1081:         loc_oDes.AddObject("txt_4c_GruEmts", "TextBox")
1082:         WITH loc_oDes.txt_4c_GruEmts
1083:             .Top = 12
1084:             .Left = 61
1085:             .Width = 79
1086:             .Height = 21
1087:             .MaxLength = 10
1088:             .Value = ""
1089:             .FontName = "Tahoma"
1090:             .FontSize = 8
1091:             .Visible = .T.
1092:         ENDWITH
1093:         BINDEVENT(loc_oDes.txt_4c_GruEmts, "KeyPress", THIS, "ValidarGrupoEmts")
1094: 
1095:         loc_oDes.AddObject("txt_4c_DGruEmts", "TextBox")
1096:         WITH loc_oDes.txt_4c_DGruEmts
1097:             .Top = 12
1098:             .Left = 142
1099:             .Width = 319
1100:             .Height = 21
1101:             .Value = ""
1102:             .ReadOnly = .T.
1103:             .FontName = "Tahoma"
1104:             .FontSize = 8
1105:             .Visible = .T.
1106:         ENDWITH
1107: 
1108:         loc_oDes.AddObject("lbl_4c_ConEmts", "Label")
1109:         WITH loc_oDes.lbl_4c_ConEmts
1110:             .Caption = "Conta :"
1111:             .Top = 38
1112:             .Left = 18
1113:             .Width = 42
1114:             .Height = 15
1115:             .AutoSize = .F.
1116:             .FontName = "Tahoma"
1117:             .FontSize = 8
1118:             .BackStyle = 0
1119:             .Visible = .T.
1120:         ENDWITH
1121: 
1122:         loc_oDes.AddObject("txt_4c_ConEmts", "TextBox")
1123:         WITH loc_oDes.txt_4c_ConEmts
1124:             .Top = 35
1125:             .Left = 61
1126:             .Width = 79
1127:             .Height = 21
1128:             .MaxLength = 10
1129:             .Value = ""
1130:             .FontName = "Tahoma"
1131:             .FontSize = 8
1132:             .Visible = .T.
1133:         ENDWITH
1134:         BINDEVENT(loc_oDes.txt_4c_ConEmts, "KeyPress", THIS, "ValidarContaEmts")
1135: 
1136:         loc_oDes.AddObject("txt_4c_CpfEmts", "TextBox")
1137:         WITH loc_oDes.txt_4c_CpfEmts
1138:             .Top = 35
1139:             .Left = 142
1140:             .Width = 115
1141:             .Height = 21
1142:             .MaxLength = 14
1143:             .Value = ""
1144:             .FontName = "Tahoma"
1145:             .FontSize = 8
1146:             .Visible = .T.
1147:         ENDWITH
1148: 
1149:         loc_oDes.AddObject("txt_4c_DConEmts", "TextBox")
1150:         WITH loc_oDes.txt_4c_DConEmts
1151:             .Top = 35
1152:             .Left = 259
1153:             .Width = 202
1154:             .Height = 21
1155:             .Value = ""
1156:             .ReadOnly = .T.
1157:             .FontName = "Tahoma"

*-- Linhas 1165 a 1283:
1165:         loc_oPg2.AddObject("cnt_4c_Destino", "Container")
1166:         loc_oDst = loc_oPg2.cnt_4c_Destino
1167:         WITH loc_oDst
1168:             .Top = 195
1169:             .Left = 6
1170:             .Width = 464
1171:             .Height = 58
1172:             .BackStyle = 1
1173:             .BackColor = RGB(235, 235, 235)
1174:             .BorderWidth = 1
1175:             .Visible = .T.
1176:         ENDWITH
1177: 
1178:         loc_oDst.AddObject("lbl_4c_TitDestino", "Label")
1179:         WITH loc_oDst.lbl_4c_TitDestino
1180:             .Caption = "Destino"
1181:             .Top = 0
1182:             .Left = 4
1183:             .Width = 60
1184:             .Height = 14
1185:             .AutoSize = .F.
1186:             .FontName = "Tahoma"
1187:             .FontSize = 8
1188:             .FontBold = .T.
1189:             .BackStyle = 0
1190:             .Visible = .T.
1191:         ENDWITH
1192: 
1193:         loc_oDst.AddObject("lbl_4c_GruDest", "Label")
1194:         WITH loc_oDst.lbl_4c_GruDest
1195:             .Caption = "Grupo :"
1196:             .Top = 15
1197:             .Left = 17
1198:             .Width = 42
1199:             .Height = 15
1200:             .AutoSize = .F.
1201:             .FontName = "Tahoma"
1202:             .FontSize = 8
1203:             .BackStyle = 0
1204:             .Visible = .T.
1205:         ENDWITH
1206: 
1207:         loc_oDst.AddObject("txt_4c_Grupo", "TextBox")
1208:         WITH loc_oDst.txt_4c_Grupo
1209:             .Top = 12
1210:             .Left = 60
1211:             .Width = 79
1212:             .Height = 21
1213:             .MaxLength = 10
1214:             .Value = ""
1215:             .FontName = "Tahoma"
1216:             .FontSize = 8
1217:             .Visible = .T.
1218:         ENDWITH
1219:         BINDEVENT(loc_oDst.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")
1220: 
1221:         loc_oDst.AddObject("txt_4c_DGrupo", "TextBox")
1222:         WITH loc_oDst.txt_4c_DGrupo
1223:             .Top = 12
1224:             .Left = 141
1225:             .Width = 320
1226:             .Height = 21
1227:             .Value = ""
1228:             .ReadOnly = .T.
1229:             .FontName = "Tahoma"
1230:             .FontSize = 8
1231:             .Visible = .T.
1232:         ENDWITH
1233: 
1234:         loc_oDst.AddObject("lbl_4c_ConDest", "Label")
1235:         WITH loc_oDst.lbl_4c_ConDest
1236:             .Caption = "Conta :"
1237:             .Top = 38
1238:             .Left = 17
1239:             .Width = 42
1240:             .Height = 15
1241:             .AutoSize = .F.
1242:             .FontName = "Tahoma"
1243:             .FontSize = 8
1244:             .BackStyle = 0
1245:             .Visible = .T.
1246:         ENDWITH
1247: 
1248:         loc_oDst.AddObject("txt_4c_Conta", "TextBox")
1249:         WITH loc_oDst.txt_4c_Conta
1250:             .Top = 35
1251:             .Left = 60
1252:             .Width = 79
1253:             .Height = 21
1254:             .MaxLength = 10
1255:             .Value = ""
1256:             .FontName = "Tahoma"
1257:             .FontSize = 8
1258:             .Visible = .T.
1259:         ENDWITH
1260:         BINDEVENT(loc_oDst.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")
1261: 
1262:         loc_oDst.AddObject("txt_4c_CpfDest", "TextBox")
1263:         WITH loc_oDst.txt_4c_CpfDest
1264:             .Top = 35
1265:             .Left = 141
1266:             .Width = 115
1267:             .Height = 21
1268:             .MaxLength = 14
1269:             .Value = ""
1270:             .FontName = "Tahoma"
1271:             .FontSize = 8
1272:             .Visible = .T.
1273:         ENDWITH
1274: 
1275:         loc_oDst.AddObject("txt_4c_DConta", "TextBox")
1276:         WITH loc_oDst.txt_4c_DConta
1277:             .Top = 35
1278:             .Left = 258
1279:             .Width = 203
1280:             .Height = 21
1281:             .Value = ""
1282:             .ReadOnly = .T.
1283:             .FontName = "Tahoma"

*-- Linhas 1292 a 1410:
1292:         loc_oPg2.AddObject("cnt_4c_CCusto", "Container")
1293:         loc_oCC = loc_oPg2.cnt_4c_CCusto
1294:         WITH loc_oCC
1295:             .Top = 195
1296:             .Left = 497
1297:             .Width = 464
1298:             .Height = 58
1299:             .BackStyle = 1
1300:             .BackColor = RGB(235, 235, 235)
1301:             .BorderWidth = 1
1302:             .Visible = .T.
1303:         ENDWITH
1304: 
1305:         loc_oCC.AddObject("lbl_4c_TitCC", "Label")
1306:         WITH loc_oCC.lbl_4c_TitCC
1307:             .Caption = "Centro de Custo"
1308:             .Top = 0
1309:             .Left = 4
1310:             .Width = 100
1311:             .Height = 14
1312:             .AutoSize = .F.
1313:             .FontName = "Tahoma"
1314:             .FontSize = 8
1315:             .FontBold = .T.
1316:             .BackStyle = 0
1317:             .Visible = .T.
1318:         ENDWITH
1319: 
1320:         loc_oCC.AddObject("lbl_4c_GruCC", "Label")
1321:         WITH loc_oCC.lbl_4c_GruCC
1322:             .Caption = "Grupo :"
1323:             .Top = 15
1324:             .Left = 17
1325:             .Width = 42
1326:             .Height = 15
1327:             .AutoSize = .F.
1328:             .FontName = "Tahoma"
1329:             .FontSize = 8
1330:             .BackStyle = 0
1331:             .Visible = .T.
1332:         ENDWITH
1333: 
1334:         loc_oCC.AddObject("txt_4c_GrupoCcs", "TextBox")
1335:         WITH loc_oCC.txt_4c_GrupoCcs
1336:             .Top = 12
1337:             .Left = 60
1338:             .Width = 79
1339:             .Height = 21
1340:             .MaxLength = 10
1341:             .Value = ""
1342:             .FontName = "Tahoma"
1343:             .FontSize = 8
1344:             .Visible = .T.
1345:         ENDWITH
1346:         BINDEVENT(loc_oCC.txt_4c_GrupoCcs, "KeyPress", THIS, "ValidarGrupoCC")
1347: 
1348:         loc_oCC.AddObject("txt_4c_DGrupoCcs", "TextBox")
1349:         WITH loc_oCC.txt_4c_DGrupoCcs
1350:             .Top = 12
1351:             .Left = 141
1352:             .Width = 320
1353:             .Height = 21
1354:             .Value = ""
1355:             .ReadOnly = .T.
1356:             .FontName = "Tahoma"
1357:             .FontSize = 8
1358:             .Visible = .T.
1359:         ENDWITH
1360: 
1361:         loc_oCC.AddObject("lbl_4c_ConCC", "Label")
1362:         WITH loc_oCC.lbl_4c_ConCC
1363:             .Caption = "Conta :"
1364:             .Top = 38
1365:             .Left = 17
1366:             .Width = 42
1367:             .Height = 15
1368:             .AutoSize = .F.
1369:             .FontName = "Tahoma"
1370:             .FontSize = 8
1371:             .BackStyle = 0
1372:             .Visible = .T.
1373:         ENDWITH
1374: 
1375:         loc_oCC.AddObject("txt_4c_ContaCcs", "TextBox")
1376:         WITH loc_oCC.txt_4c_ContaCcs
1377:             .Top = 35
1378:             .Left = 60
1379:             .Width = 79
1380:             .Height = 21
1381:             .MaxLength = 10
1382:             .Value = ""
1383:             .FontName = "Tahoma"
1384:             .FontSize = 8
1385:             .Visible = .T.
1386:         ENDWITH
1387:         BINDEVENT(loc_oCC.txt_4c_ContaCcs, "KeyPress", THIS, "ValidarContaCC")
1388: 
1389:         loc_oCC.AddObject("txt_4c_CpfCCs", "TextBox")
1390:         WITH loc_oCC.txt_4c_CpfCCs
1391:             .Top = 35
1392:             .Left = 141
1393:             .Width = 115
1394:             .Height = 21
1395:             .MaxLength = 14
1396:             .Value = ""
1397:             .FontName = "Tahoma"
1398:             .FontSize = 8
1399:             .Visible = .T.
1400:         ENDWITH
1401: 
1402:         loc_oCC.AddObject("txt_4c_DContaCcs", "TextBox")
1403:         WITH loc_oCC.txt_4c_DContaCcs
1404:             .Top = 35
1405:             .Left = 258
1406:             .Width = 203
1407:             .Height = 21
1408:             .Value = ""
1409:             .ReadOnly = .T.
1410:             .FontName = "Tahoma"

*-- Linhas 1418 a 1523:
1418:         loc_oPg2.AddObject("cnt_4c_Carteira", "Container")
1419:         loc_oCart = loc_oPg2.cnt_4c_Carteira
1420:         WITH loc_oCart
1421:             .Top = 254
1422:             .Left = 6
1423:             .Width = 464
1424:             .Height = 58
1425:             .BackStyle = 1
1426:             .BackColor = RGB(235, 235, 235)
1427:             .BorderWidth = 1
1428:             .Visible = .T.
1429:         ENDWITH
1430: 
1431:         loc_oCart.AddObject("lbl_4c_TitCart", "Label")
1432:         WITH loc_oCart.lbl_4c_TitCart
1433:             .Caption = "Carteira"
1434:             .Top = 0
1435:             .Left = 4
1436:             .Width = 60
1437:             .Height = 14
1438:             .AutoSize = .F.
1439:             .FontName = "Tahoma"
1440:             .FontSize = 8
1441:             .FontBold = .T.
1442:             .BackStyle = 0
1443:             .Visible = .T.
1444:         ENDWITH
1445: 
1446:         loc_oCart.AddObject("lbl_4c_GruCart", "Label")
1447:         WITH loc_oCart.lbl_4c_GruCart
1448:             .Caption = "Grupo :"
1449:             .Top = 15
1450:             .Left = 17
1451:             .Width = 42
1452:             .Height = 15
1453:             .AutoSize = .F.
1454:             .FontName = "Tahoma"
1455:             .FontSize = 8
1456:             .BackStyle = 0
1457:             .Visible = .T.
1458:         ENDWITH
1459: 
1460:         loc_oCart.AddObject("txt_4c_GruCart", "TextBox")
1461:         WITH loc_oCart.txt_4c_GruCart
1462:             .Top = 12
1463:             .Left = 60
1464:             .Width = 80
1465:             .Height = 21
1466:             .MaxLength = 10
1467:             .Value = ""
1468:             .FontName = "Tahoma"
1469:             .FontSize = 8
1470:             .Visible = .T.
1471:         ENDWITH
1472:         BINDEVENT(loc_oCart.txt_4c_GruCart, "KeyPress", THIS, "ValidarGrupoCart")
1473: 
1474:         loc_oCart.AddObject("txt_4c_DGruCart", "TextBox")
1475:         WITH loc_oCart.txt_4c_DGruCart
1476:             .Top = 12
1477:             .Left = 142
1478:             .Width = 319
1479:             .Height = 21
1480:             .Value = ""
1481:             .ReadOnly = .T.
1482:             .FontName = "Tahoma"
1483:             .FontSize = 8
1484:             .Visible = .T.
1485:         ENDWITH
1486: 
1487:         loc_oCart.AddObject("lbl_4c_ConCart", "Label")
1488:         WITH loc_oCart.lbl_4c_ConCart
1489:             .Caption = "Conta :"
1490:             .Top = 38
1491:             .Left = 17
1492:             .Width = 42
1493:             .Height = 15
1494:             .AutoSize = .F.
1495:             .FontName = "Tahoma"
1496:             .FontSize = 8
1497:             .BackStyle = 0
1498:             .Visible = .T.
1499:         ENDWITH
1500: 
1501:         loc_oCart.AddObject("txt_4c_ConCart", "TextBox")
1502:         WITH loc_oCart.txt_4c_ConCart
1503:             .Top = 35
1504:             .Left = 60
1505:             .Width = 80
1506:             .Height = 21
1507:             .MaxLength = 10
1508:             .Value = ""
1509:             .FontName = "Tahoma"
1510:             .FontSize = 8
1511:             .Visible = .T.
1512:         ENDWITH
1513:         BINDEVENT(loc_oCart.txt_4c_ConCart, "KeyPress", THIS, "ValidarContaCart")
1514: 
1515:         loc_oCart.AddObject("txt_4c_DConCart", "TextBox")
1516:         WITH loc_oCart.txt_4c_DConCart
1517:             .Top = 35
1518:             .Left = 142
1519:             .Width = 319
1520:             .Height = 21
1521:             .Value = ""
1522:             .ReadOnly = .T.
1523:             .FontName = "Tahoma"

*-- Linhas 1532 a 1704:
1532:         loc_oPg2.AddObject("cnt_4c_Processa", "Container")
1533:         loc_oProc = loc_oPg2.cnt_4c_Processa
1534:         WITH loc_oProc
1535:             .Top = 254
1536:             .Left = 497
1537:             .Width = 480
1538:             .Height = 58
1539:             .BackStyle = 1
1540:             .BackColor = RGB(235, 235, 235)
1541:             .BorderWidth = 1
1542:             .Visible = .T.
1543:         ENDWITH
1544: 
1545:         loc_oProc.AddObject("lbl_4c_LblPeriodo", "Label")
1546:         WITH loc_oProc.lbl_4c_LblPeriodo
1547:             .Caption = "Per" + CHR(237) + "odo :"
1548:             .Top = 8
1549:             .Left = 21
1550:             .Width = 46
1551:             .Height = 15
1552:             .AutoSize = .F.
1553:             .FontName = "Tahoma"
1554:             .FontSize = 8
1555:             .BackStyle = 0
1556:             .Visible = .T.
1557:         ENDWITH
1558: 
1559:         loc_oProc.AddObject("txt_4c_FweditdataIni", "TextBox")
1560:         WITH loc_oProc.txt_4c_FweditdataIni
1561:             .Top = 5
1562:             .Left = 68
1563:             .Width = 80
1564:             .Height = 21
1565:             .Value = {}
1566:             .InputMask = "@D"
1567:             .FontName = "Tahoma"
1568:             .FontSize = 8
1569:             .Visible = .T.
1570:         ENDWITH
1571: 
1572:         loc_oProc.AddObject("lbl_4c_SepProc", "Label")
1573:         WITH loc_oProc.lbl_4c_SepProc
1574:             .Caption = CHR(224)
1575:             .Top = 9
1576:             .Left = 152
1577:             .Width = 10
1578:             .Height = 15
1579:             .AutoSize = .F.
1580:             .FontName = "Tahoma"
1581:             .FontSize = 8
1582:             .BackStyle = 0
1583:             .Visible = .T.
1584:         ENDWITH
1585: 
1586:         loc_oProc.AddObject("txt_4c_FweditdataFin", "TextBox")
1587:         WITH loc_oProc.txt_4c_FweditdataFin
1588:             .Top = 5
1589:             .Left = 165
1590:             .Width = 80
1591:             .Height = 21
1592:             .Value = {}
1593:             .InputMask = "@D"
1594:             .FontName = "Tahoma"
1595:             .FontSize = 8
1596:             .Visible = .T.
1597:         ENDWITH
1598: 
1599:         loc_oProc.AddObject("lbl_4c_LblEmpProc", "Label")
1600:         WITH loc_oProc.lbl_4c_LblEmpProc
1601:             .Caption = "Empresa :"
1602:             .Top = 34
1603:             .Left = 17
1604:             .Width = 50
1605:             .Height = 15
1606:             .AutoSize = .F.
1607:             .FontName = "Tahoma"
1608:             .FontSize = 8
1609:             .BackStyle = 0
1610:             .Visible = .T.
1611:         ENDWITH
1612: 
1613:         loc_oProc.AddObject("txt_4c_EmpProc", "TextBox")
1614:         WITH loc_oProc.txt_4c_EmpProc
1615:             .Top = 31
1616:             .Left = 68
1617:             .Width = 31
1618:             .Height = 21
1619:             .MaxLength = 3
1620:             .Value = ""
1621:             .FontName = "Tahoma"
1622:             .FontSize = 8
1623:             .Visible = .T.
1624:         ENDWITH
1625: 
1626:         loc_oProc.AddObject("lbl_4c_LblLoteProc", "Label")
1627:         WITH loc_oProc.lbl_4c_LblLoteProc
1628:             .Caption = "Lote :"
1629:             .Top = 34
1630:             .Left = 131
1631:             .Width = 35
1632:             .Height = 15
1633:             .AutoSize = .F.
1634:             .FontName = "Tahoma"
1635:             .FontSize = 8
1636:             .BackStyle = 0
1637:             .Visible = .T.
1638:         ENDWITH
1639: 
1640:         loc_oProc.AddObject("txt_4c_LoteProc", "TextBox")
1641:         WITH loc_oProc.txt_4c_LoteProc
1642:             .Top = 31
1643:             .Left = 165
1644:             .Width = 52
1645:             .Height = 21
1646:             .Value = 0
1647:             .FontName = "Tahoma"
1648:             .FontSize = 8
1649:             .Visible = .T.
1650:         ENDWITH
1651: 
1652:         loc_oProc.AddObject("lbl_4c_LblPlanilha", "Label")
1653:         WITH loc_oProc.lbl_4c_LblPlanilha
1654:             .Caption = "Planilha :"
1655:             .Top = 34
1656:             .Left = 237
1657:             .Width = 48
1658:             .Height = 15
1659:             .AutoSize = .F.
1660:             .FontName = "Tahoma"
1661:             .FontSize = 8
1662:             .BackStyle = 0
1663:             .Visible = .T.
1664:         ENDWITH
1665: 
1666:         loc_oProc.AddObject("txt_4c_Planilha", "TextBox")
1667:         WITH loc_oProc.txt_4c_Planilha
1668:             .Top = 31
1669:             .Left = 285
1670:             .Width = 120
1671:             .Height = 21
1672:             .MaxLength = 250
1673:             .Value = ""
1674:             .FontName = "Tahoma"
1675:             .FontSize = 8
1676:             .Visible = .T.
1677:         ENDWITH
1678: 
1679:         loc_oProc.AddObject("cmd_4c_Sel_Planilha", "CommandButton")
1680:         WITH loc_oProc.cmd_4c_Sel_Planilha
1681:             .Top = 29
1682:             .Left = 406
1683:             .Width = 24
1684:             .Height = 24
1685:             .Caption = "..."
1686:             .FontName = "Tahoma"
1687:             .FontSize = 8
1688:             .BackColor = RGB(255, 255, 255)
1689:             .Themes = .F.
1690:             .SpecialEffect = 0
1691:             .Visible = .T.
1692:         ENDWITH
1693:         BINDEVENT(loc_oProc.cmd_4c_Sel_Planilha, "Click", THIS, "BtnSelPlanilhaClick")
1694: 
1695:         loc_oProc.AddObject("lbl_4c_Mensagem", "Label")
1696:         WITH loc_oProc.lbl_4c_Mensagem
1697:             .Caption = ""
1698:             .Top = 133
1699:             .Left = 13
1700:             .Width = 2
1701:             .Height = 15
1702:             .AutoSize = .T.
1703:             .FontName = "Tahoma"
1704:             .FontSize = 8

*-- Linhas 1713 a 1831:
1713:         loc_oPg2.AddObject("cnt_4c_Emissor", "Container")
1714:         loc_oEmiss = loc_oPg2.cnt_4c_Emissor
1715:         WITH loc_oEmiss
1716:             .Top = 313
1717:             .Left = 6
1718:             .Width = 464
1719:             .Height = 58
1720:             .BackStyle = 1
1721:             .BackColor = RGB(235, 235, 235)
1722:             .BorderWidth = 1
1723:             .Visible = .T.
1724:         ENDWITH
1725: 
1726:         loc_oEmiss.AddObject("lbl_4c_TitEmissor", "Label")
1727:         WITH loc_oEmiss.lbl_4c_TitEmissor
1728:             .Caption = "Emissor"
1729:             .Top = 0
1730:             .Left = 4
1731:             .Width = 60
1732:             .Height = 14
1733:             .AutoSize = .F.
1734:             .FontName = "Tahoma"
1735:             .FontSize = 8
1736:             .FontBold = .T.
1737:             .BackStyle = 0
1738:             .Visible = .T.
1739:         ENDWITH
1740: 
1741:         loc_oEmiss.AddObject("lbl_4c_GruEmiss", "Label")
1742:         WITH loc_oEmiss.lbl_4c_GruEmiss
1743:             .Caption = "Grupo :"
1744:             .Top = 15
1745:             .Left = 18
1746:             .Width = 42
1747:             .Height = 15
1748:             .AutoSize = .F.
1749:             .FontName = "Tahoma"
1750:             .FontSize = 8
1751:             .BackStyle = 0
1752:             .Visible = .T.
1753:         ENDWITH
1754: 
1755:         loc_oEmiss.AddObject("txt_4c_GruEmiss", "TextBox")
1756:         WITH loc_oEmiss.txt_4c_GruEmiss
1757:             .Top = 12
1758:             .Left = 61
1759:             .Width = 79
1760:             .Height = 21
1761:             .MaxLength = 10
1762:             .Value = ""
1763:             .FontName = "Tahoma"
1764:             .FontSize = 8
1765:             .Visible = .T.
1766:         ENDWITH
1767:         BINDEVENT(loc_oEmiss.txt_4c_GruEmiss, "KeyPress", THIS, "ValidarGrupoEmiss")
1768: 
1769:         loc_oEmiss.AddObject("txt_4c_DGruEmiss", "TextBox")
1770:         WITH loc_oEmiss.txt_4c_DGruEmiss
1771:             .Top = 12
1772:             .Left = 142
1773:             .Width = 319
1774:             .Height = 21
1775:             .Value = ""
1776:             .ReadOnly = .T.
1777:             .FontName = "Tahoma"
1778:             .FontSize = 8
1779:             .Visible = .T.
1780:         ENDWITH
1781: 
1782:         loc_oEmiss.AddObject("lbl_4c_ConEmiss", "Label")
1783:         WITH loc_oEmiss.lbl_4c_ConEmiss
1784:             .Caption = "Conta :"
1785:             .Top = 38
1786:             .Left = 18
1787:             .Width = 42
1788:             .Height = 15
1789:             .AutoSize = .F.
1790:             .FontName = "Tahoma"
1791:             .FontSize = 8
1792:             .BackStyle = 0
1793:             .Visible = .T.
1794:         ENDWITH
1795: 
1796:         loc_oEmiss.AddObject("txt_4c_ConEmiss", "TextBox")
1797:         WITH loc_oEmiss.txt_4c_ConEmiss
1798:             .Top = 35
1799:             .Left = 61
1800:             .Width = 79
1801:             .Height = 21
1802:             .MaxLength = 10
1803:             .Value = ""
1804:             .FontName = "Tahoma"
1805:             .FontSize = 8
1806:             .Visible = .T.
1807:         ENDWITH
1808:         BINDEVENT(loc_oEmiss.txt_4c_ConEmiss, "KeyPress", THIS, "ValidarContaEmiss")
1809: 
1810:         loc_oEmiss.AddObject("txt_4c_CpfEmiss", "TextBox")
1811:         WITH loc_oEmiss.txt_4c_CpfEmiss
1812:             .Top = 35
1813:             .Left = 142
1814:             .Width = 115
1815:             .Height = 21
1816:             .MaxLength = 14
1817:             .Value = ""
1818:             .FontName = "Tahoma"
1819:             .FontSize = 8
1820:             .Visible = .T.
1821:         ENDWITH
1822: 
1823:         loc_oEmiss.AddObject("txt_4c_DConEmiss", "TextBox")
1824:         WITH loc_oEmiss.txt_4c_DConEmiss
1825:             .Top = 35
1826:             .Left = 259
1827:             .Width = 202
1828:             .Height = 21
1829:             .Value = ""
1830:             .ReadOnly = .T.
1831:             .FontName = "Tahoma"

*-- Linhas 1837 a 1863:
1837:         *-- Observacao (fwmemo1) - EditBox
1838:         *-- original: top=288+29=317, left=581, width=391, height=48
1839:         *=====================================================================
1840:         loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
1841:         WITH loc_oPg2.lbl_4c_Observacao
1842:             .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
1843:             .Top = 319
1844:             .Left = 509
1845:             .Width = 70
1846:             .Height = 15
1847:             .AutoSize = .F.
1848:             .FontName = "Tahoma"
1849:             .FontSize = 8
1850:             .ForeColor = RGB(255, 255, 255)
1851:             .BackStyle = 0
1852:             .Visible = .T.
1853:         ENDWITH
1854: 
1855:         loc_oPg2.AddObject("edt_4c_Obs", "EditBox")
1856:         WITH loc_oPg2.edt_4c_Obs
1857:             .Top = 317
1858:             .Left = 581
1859:             .Width = 391
1860:             .Height = 48
1861:             .Value = ""
1862:             .FontName = "Tahoma"
1863:             .FontSize = 8

*-- Linhas 1871 a 1893:
1871:         *=====================================================================
1872:         loc_oPg2.AddObject("cnt_4c_Grade", "Container")
1873:         WITH loc_oPg2.cnt_4c_Grade
1874:             .Top = 374
1875:             .Left = 5
1876:             .Width = 759
1877:             .Height = 94
1878:             .BackStyle = 0
1879:             .BorderWidth = 0
1880:             .Visible = .T.
1881:         ENDWITH
1882: 
1883:         loc_oPg2.cnt_4c_Grade.AddObject("grd_4c_Cheques", "Grid")
1884:         loc_oGrid = loc_oPg2.cnt_4c_Grade.grd_4c_Cheques
1885:         loc_oGrid.ColumnCount = 12
1886:         WITH loc_oGrid
1887:             .Top = 0
1888:             .Left = 0
1889:             .Width = 759
1890:             .Height = 93
1891:             .FontName = "Verdana"
1892:             .FontSize = 7
1893:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1905 a 2140:
1905:         ENDWITH
1906:         WITH loc_oGrid.Column1
1907:             .Width = 30
1908:             .Header1.Caption = "Bco"
1909:         ENDWITH
1910:         WITH loc_oGrid.Column2
1911:             .Width = 38
1912:             .Header1.Caption = "Agen"
1913:         ENDWITH
1914:         WITH loc_oGrid.Column3
1915:             .Width = 70
1916:             .Header1.Caption = "N" + CHR(176) + " Conta"
1917:         ENDWITH
1918:         WITH loc_oGrid.Column4
1919:             .Width = 65
1920:             .Header1.Caption = "N" + CHR(176) + " Chq"
1921:         ENDWITH
1922:         WITH loc_oGrid.Column5
1923:             .Width = 75
1924:             .Header1.Caption = "Valor"
1925:         ENDWITH
1926:         WITH loc_oGrid.Column6
1927:             .Width = 75
1928:             .Header1.Caption = "Vencimento"
1929:         ENDWITH
1930:         WITH loc_oGrid.Column7
1931:             .Width = 40
1932:             .Header1.Caption = "Al" + CHR(237) + "nea"
1933:         ENDWITH
1934:         WITH loc_oGrid.Column8
1935:             .Width = 30
1936:             .Header1.Caption = "Emp"
1937:         ENDWITH
1938:         WITH loc_oGrid.Column9
1939:             .Width = 80
1940:             .Header1.Caption = "C" + CHR(243) + "digo Cliente"
1941:         ENDWITH
1942:         WITH loc_oGrid.Column10
1943:             .Width = 70
1944:             .Header1.Caption = "Protocolo"
1945:         ENDWITH
1946:         WITH loc_oGrid.Column11
1947:             .Width = 75
1948:             .Header1.Caption = "Dt. Emiss" + CHR(227) + "o"
1949:         ENDWITH
1950:         *-- Coluna Sel (checkbox marca)
1951:         WITH loc_oGrid.Column12
1952:             .Width = 30
1953:             .Header1.Caption = "Sel"
1954:             .Sparse = .F.
1955:             .AddObject("Check1", "CheckBox")
1956:             WITH .Check1
1957:                 .Caption = ""
1958:                 .Alignment = 0
1959:                 .ReadOnly = .F.
1960:                 .Visible = .T.
1961:                 .Top = 9
1962:                 .Left = 2
1963:                 .Height = 17
1964:                 .Width = 22
1965:             ENDWITH
1966:         ENDWITH
1967: 
1968:         *=====================================================================
1969:         *-- Botao Marcar cheque na grade - top=349+29=378, left=767
1970:         *=====================================================================
1971:         loc_oPg2.AddObject("cmd_4c_BtnMarca", "CommandButton")
1972:         WITH loc_oPg2.cmd_4c_BtnMarca
1973:             .Top = 378
1974:             .Left = 767
1975:             .Width = 40
1976:             .Height = 40
1977:             .Caption = "Marca"
1978:             .FontName = "Tahoma"
1979:             .FontSize = 7
1980:             .BackColor = RGB(255, 255, 255)
1981:             .Themes = .F.
1982:             .SpecialEffect = 0
1983:             .Visible = .T.
1984:         ENDWITH
1985:         BINDEVENT(loc_oPg2.cmd_4c_BtnMarca, "Click", THIS, "BtnMarcaClick")
1986: 
1987:         *-- Botao Excluir cheque da grade - top=390+29=419, left=767
1988:         loc_oPg2.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1989:         WITH loc_oPg2.cmd_4c_BtnExcluir
1990:             .Top = 419
1991:             .Left = 767
1992:             .Width = 40
1993:             .Height = 40
1994:             .Caption = "Excluir"
1995:             .FontName = "Tahoma"
1996:             .FontSize = 7
1997:             .BackColor = RGB(255, 255, 255)
1998:             .Themes = .F.
1999:             .SpecialEffect = 0
2000:             .Visible = .T.
2001:         ENDWITH
2002:         BINDEVENT(loc_oPg2.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirChequeClick")
2003: 
2004:         *=====================================================================
2005:         *-- Botoes leitora + FollowUp (coluna direita)
2006:         *-- Chk_FollowUp: top=364+29=393, left=826
2007:         *-- CmdExcCheque: top=364+29=393, left=901
2008:         *-- Comm_Ini:     top=441+29=470, left=826
2009:         *-- Comm_Fim:     top=441+29=470, left=901
2010:         *=====================================================================
2011:         loc_oPg2.AddObject("chk_4c_FollowUp", "CheckBox")
2012:         WITH loc_oPg2.chk_4c_FollowUp
2013:             .Top = 393
2014:             .Left = 826
2015:             .Width = 75
2016:             .Height = 75
2017:             .Caption = "Repetir Followup"
2018:             .Value = 0
2019:             .FontName = "Tahoma"
2020:             .FontSize = 8
2021:             .BackStyle = 0
2022:             .Visible = .T.
2023:         ENDWITH
2024: 
2025:         loc_oPg2.AddObject("cmd_4c_CmdExcCheque", "CommandButton")
2026:         WITH loc_oPg2.cmd_4c_CmdExcCheque
2027:             .Top = 393
2028:             .Left = 901
2029:             .Width = 75
2030:             .Height = 75
2031:             .Caption = "Excluir Cheque"
2032:             .FontName = "Tahoma"
2033:             .FontBold = .T.
2034:             .FontItalic = .T.
2035:             .FontSize = 8
2036:             .BackColor = RGB(255, 255, 255)
2037:             .Themes = .F.
2038:             .SpecialEffect = 0
2039:             .Visible = .T.
2040:         ENDWITH
2041:         BINDEVENT(loc_oPg2.cmd_4c_CmdExcCheque, "Click", THIS, "BtnCmdExcChequeClick")
2042: 
2043:         loc_oPg2.AddObject("cmd_4c_Comm_Ini", "CommandButton")
2044:         WITH loc_oPg2.cmd_4c_Comm_Ini
2045:             .Top = 470
2046:             .Left = 826
2047:             .Width = 75
2048:             .Height = 75
2049:             .Caption = "Acionar Leitora"
2050:             .FontName = "Tahoma"
2051:             .FontBold = .T.
2052:             .FontItalic = .T.
2053:             .FontSize = 8
2054:             .BackColor = RGB(255, 255, 255)
2055:             .Themes = .F.
2056:             .SpecialEffect = 0
2057:             .Visible = .T.
2058:         ENDWITH
2059:         BINDEVENT(loc_oPg2.cmd_4c_Comm_Ini, "Click", THIS, "BtnCommIniClick")
2060: 
2061:         loc_oPg2.AddObject("cmd_4c_Comm_Fim", "CommandButton")
2062:         WITH loc_oPg2.cmd_4c_Comm_Fim
2063:             .Top = 470
2064:             .Left = 901
2065:             .Width = 75
2066:             .Height = 75
2067:             .Caption = "Encerrar Leitora"
2068:             .FontName = "Tahoma"
2069:             .FontBold = .T.
2070:             .FontItalic = .T.
2071:             .FontSize = 8
2072:             .BackColor = RGB(255, 255, 255)
2073:             .Themes = .F.
2074:             .SpecialEffect = 0
2075:             .Visible = .T.
2076:         ENDWITH
2077:         BINDEVENT(loc_oPg2.cmd_4c_Comm_Fim, "Click", THIS, "BtnCommFimClick")
2078: 
2079:         *=====================================================================
2080:         *-- Indicadores de porta + totalizadores
2081:         *-- top=440+29=469
2082:         *=====================================================================
2083:         loc_oPg2.AddObject("lbl_4c_AvisoPortaS", "Label")
2084:         WITH loc_oPg2.lbl_4c_AvisoPortaS
2085:             .Caption = "S"
2086:             .Top = 469
2087:             .Left = 7
2088:             .Width = 21
2089:             .Height = 26
2090:             .AutoSize = .F.
2091:             .FontName = "Tahoma"
2092:             .FontSize = 10
2093:             .FontBold = .T.
2094:             .ForeColor = RGB(180, 180, 180)
2095:             .BackStyle = 0
2096:             .Visible = .T.
2097:         ENDWITH
2098: 
2099:         loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
2100:         WITH loc_oPg2.lbl_4c_AvisoPortaM
2101:             .Caption = "M"
2102:             .Top = 469
2103:             .Left = 30
2104:             .Width = 21
2105:             .Height = 26
2106:             .AutoSize = .F.
2107:             .FontName = "Tahoma"
2108:             .FontSize = 10
2109:             .FontBold = .T.
2110:             .ForeColor = RGB(180, 180, 180)
2111:             .BackStyle = 0
2112:             .Visible = .T.
2113:         ENDWITH
2114: 
2115:         loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
2116:         WITH loc_oPg2.lbl_4c_AvisoPortaT
2117:             .Caption = "T"
2118:             .Top = 469
2119:             .Left = 53
2120:             .Width = 21
2121:             .Height = 26
2122:             .AutoSize = .F.
2123:             .FontName = "Tahoma"
2124:             .FontSize = 10
2125:             .FontBold = .T.
2126:             .ForeColor = RGB(180, 180, 180)
2127:             .BackStyle = 0
2128:             .Visible = .T.
2129:         ENDWITH
2130: 
2131:         loc_oPg2.AddObject("lbl_4c_AvisoPortaP", "Label")
2132:         WITH loc_oPg2.lbl_4c_AvisoPortaP
2133:             .Caption = "P"
2134:             .Top = 469
2135:             .Left = 76
2136:             .Width = 21
2137:             .Height = 26
2138:             .AutoSize = .F.
2139:             .FontName = "Tahoma"
2140:             .FontSize = 10

*-- Linhas 2146 a 2182:
2146: 
2147:         loc_oPg2.AddObject("txt_4c_QtdeChqs", "TextBox")
2148:         WITH loc_oPg2.txt_4c_QtdeChqs
2149:             .Top = 469
2150:             .Left = 173
2151:             .Width = 52
2152:             .Height = 23
2153:             .Value = 0
2154:             .ReadOnly = .T.
2155:             .FontName = "Tahoma"
2156:             .FontSize = 8
2157:             .Visible = .T.
2158:         ENDWITH
2159: 
2160:         loc_oPg2.AddObject("txt_4c_ValorTotal", "TextBox")
2161:         WITH loc_oPg2.txt_4c_ValorTotal
2162:             .Top = 469
2163:             .Left = 226
2164:             .Width = 122
2165:             .Height = 23
2166:             .Value = 0
2167:             .ReadOnly = .T.
2168:             .InputMask = "999999999.99"
2169:             .FontName = "Tahoma"
2170:             .FontSize = 8
2171:             .Visible = .T.
2172:         ENDWITH
2173: 
2174:         loc_oPg2.AddObject("txt_4c_CondPagto", "TextBox")
2175:         WITH loc_oPg2.txt_4c_CondPagto
2176:             .Top = 469
2177:             .Left = 489
2178:             .Width = 116
2179:             .Height = 23
2180:             .MaxLength = 20
2181:             .Value = ""
2182:             .FontName = "Tahoma"

*-- Linhas 2191 a 2455:
2191:         loc_oPg2.AddObject("cnt_4c_Cheque", "Container")
2192:         loc_oChe = loc_oPg2.cnt_4c_Cheque
2193:         WITH loc_oChe
2194:             .Top = 497
2195:             .Left = 6
2196:             .Width = 735
2197:             .Height = 39
2198:             .BackStyle = 1
2199:             .BackColor = RGB(235, 235, 235)
2200:             .BorderWidth = 1
2201:             .Visible = .T.
2202:         ENDWITH
2203: 
2204:         loc_oChe.AddObject("lbl_4c_Lbl_ProtB", "Label")
2205:         WITH loc_oChe.lbl_4c_Lbl_ProtB
2206:             .Caption = "Protocolo"
2207:             .Top = 4
2208:             .Left = 18
2209:             .Width = 55
2210:             .Height = 12
2211:             .AutoSize = .F.
2212:             .FontName = "Tahoma"
2213:             .FontSize = 7
2214:             .BackStyle = 0
2215:             .Visible = .T.
2216:         ENDWITH
2217: 
2218:         loc_oChe.AddObject("txt_4c_ProtL", "TextBox")
2219:         WITH loc_oChe.txt_4c_ProtL
2220:             .Top = 16
2221:             .Left = 5
2222:             .Width = 66
2223:             .Height = 21
2224:             .MaxLength = 20
2225:             .Value = ""
2226:             .FontName = "Tahoma"
2227:             .FontSize = 8
2228:             .Visible = .T.
2229:         ENDWITH
2230: 
2231:         loc_oChe.AddObject("txt_4c_ProtB", "TextBox")
2232:         WITH loc_oChe.txt_4c_ProtB
2233:             .Top = 16
2234:             .Left = 41
2235:             .Width = 66
2236:             .Height = 21
2237:             .MaxLength = 20
2238:             .Value = ""
2239:             .FontName = "Tahoma"
2240:             .FontSize = 8
2241:             .Visible = .T.
2242:         ENDWITH
2243: 
2244:         loc_oChe.AddObject("lbl_4c_Lbl_Bco", "Label")
2245:         WITH loc_oChe.lbl_4c_Lbl_Bco
2246:             .Caption = "Bco"
2247:             .Top = 4
2248:             .Left = 118
2249:             .Width = 25
2250:             .Height = 12
2251:             .AutoSize = .F.
2252:             .FontName = "Tahoma"
2253:             .FontSize = 7
2254:             .BackStyle = 0
2255:             .Visible = .T.
2256:         ENDWITH
2257: 
2258:         loc_oChe.AddObject("txt_4c_Bco", "TextBox")
2259:         WITH loc_oChe.txt_4c_Bco
2260:             .Top = 16
2261:             .Left = 108
2262:             .Width = 36
2263:             .Height = 21
2264:             .MaxLength = 5
2265:             .Value = ""
2266:             .FontName = "Tahoma"
2267:             .FontSize = 8
2268:             .Visible = .T.
2269:         ENDWITH
2270: 
2271:         loc_oChe.AddObject("lbl_4c_Lbl_Age", "Label")
2272:         WITH loc_oChe.lbl_4c_Lbl_Age
2273:             .Caption = "Agen."
2274:             .Top = 4
2275:             .Left = 153
2276:             .Width = 35
2277:             .Height = 12
2278:             .AutoSize = .F.
2279:             .FontName = "Tahoma"
2280:             .FontSize = 7
2281:             .BackStyle = 0
2282:             .Visible = .T.
2283:         ENDWITH
2284: 
2285:         loc_oChe.AddObject("txt_4c_Age", "TextBox")
2286:         WITH loc_oChe.txt_4c_Age
2287:             .Top = 16
2288:             .Left = 145
2289:             .Width = 40
2290:             .Height = 21
2291:             .MaxLength = 10
2292:             .Value = ""
2293:             .FontName = "Tahoma"
2294:             .FontSize = 8
2295:             .Visible = .T.
2296:         ENDWITH
2297: 
2298:         loc_oChe.AddObject("lbl_4c_Lbl_Conta", "Label")
2299:         WITH loc_oChe.lbl_4c_Lbl_Conta
2300:             .Caption = "Conta"
2301:             .Top = 4
2302:             .Left = 213
2303:             .Width = 35
2304:             .Height = 12
2305:             .AutoSize = .F.
2306:             .FontName = "Tahoma"
2307:             .FontSize = 7
2308:             .BackStyle = 0
2309:             .Visible = .T.
2310:         ENDWITH
2311: 
2312:         loc_oChe.AddObject("txt_4c_ContaChe", "TextBox")
2313:         WITH loc_oChe.txt_4c_ContaChe
2314:             .Top = 16
2315:             .Left = 186
2316:             .Width = 82
2317:             .Height = 21
2318:             .MaxLength = 20
2319:             .Value = ""
2320:             .FontName = "Tahoma"
2321:             .FontSize = 8
2322:             .Visible = .T.
2323:         ENDWITH
2324: 
2325:         loc_oChe.AddObject("lbl_4c_Lbl_Numero", "Label")
2326:         WITH loc_oChe.lbl_4c_Lbl_Numero
2327:             .Caption = "Numero"
2328:             .Top = 4
2329:             .Left = 279
2330:             .Width = 40
2331:             .Height = 12
2332:             .AutoSize = .F.
2333:             .FontName = "Tahoma"
2334:             .FontSize = 7
2335:             .BackStyle = 0
2336:             .Visible = .T.
2337:         ENDWITH
2338: 
2339:         loc_oChe.AddObject("txt_4c_NumChe", "TextBox")
2340:         WITH loc_oChe.txt_4c_NumChe
2341:             .Top = 16
2342:             .Left = 269
2343:             .Width = 54
2344:             .Height = 21
2345:             .MaxLength = 20
2346:             .Value = ""
2347:             .FontName = "Tahoma"
2348:             .FontSize = 8
2349:             .Visible = .T.
2350:         ENDWITH
2351: 
2352:         loc_oChe.AddObject("lbl_4c_Lbl_Valor", "Label")
2353:         WITH loc_oChe.lbl_4c_Lbl_Valor
2354:             .Caption = "Valor"
2355:             .Top = 4
2356:             .Left = 361
2357:             .Width = 35
2358:             .Height = 12
2359:             .AutoSize = .F.
2360:             .FontName = "Tahoma"
2361:             .FontSize = 7
2362:             .BackStyle = 0
2363:             .Visible = .T.
2364:         ENDWITH
2365: 
2366:         loc_oChe.AddObject("txt_4c_ValorChe", "TextBox")
2367:         WITH loc_oChe.txt_4c_ValorChe
2368:             .Top = 16
2369:             .Left = 324
2370:             .Width = 104
2371:             .Height = 21
2372:             .Value = 0
2373:             .InputMask = "999999999.99"
2374:             .FontName = "Tahoma"
2375:             .FontSize = 8
2376:             .Visible = .T.
2377:         ENDWITH
2378: 
2379:         loc_oChe.AddObject("lbl_4c_Lbl_Venc", "Label")
2380:         WITH loc_oChe.lbl_4c_Lbl_Venc
2381:             .Caption = "Vencimento"
2382:             .Top = 4
2383:             .Left = 438
2384:             .Width = 65
2385:             .Height = 12
2386:             .AutoSize = .F.
2387:             .FontName = "Tahoma"
2388:             .FontSize = 7
2389:             .BackStyle = 0
2390:             .Visible = .T.
2391:         ENDWITH
2392: 
2393:         loc_oChe.AddObject("txt_4c_VencChe", "TextBox")
2394:         WITH loc_oChe.txt_4c_VencChe
2395:             .Top = 16
2396:             .Left = 429
2397:             .Width = 82
2398:             .Height = 21
2399:             .Value = {}
2400:             .InputMask = "@D"
2401:             .FontName = "Tahoma"
2402:             .FontSize = 8
2403:             .Visible = .T.
2404:         ENDWITH
2405: 
2406:         loc_oChe.AddObject("lbl_4c_Lbl_Alinea", "Label")
2407:         WITH loc_oChe.lbl_4c_Lbl_Alinea
2408:             .Caption = "Alinea"
2409:             .Top = 4
2410:             .Left = 514
2411:             .Width = 35
2412:             .Height = 12
2413:             .AutoSize = .F.
2414:             .FontName = "Tahoma"
2415:             .FontSize = 7
2416:             .BackStyle = 0
2417:             .Visible = .T.
2418:         ENDWITH
2419: 
2420:         loc_oChe.AddObject("txt_4c_AlineaChe", "TextBox")
2421:         WITH loc_oChe.txt_4c_AlineaChe
2422:             .Top = 16
2423:             .Left = 512
2424:             .Width = 31
2425:             .Height = 21
2426:             .MaxLength = 5
2427:             .Value = ""
2428:             .FontName = "Tahoma"
2429:             .FontSize = 8
2430:             .Visible = .T.
2431:         ENDWITH
2432: 
2433:         loc_oChe.AddObject("lbl_4c_Lbl_DtEmiss", "Label")
2434:         WITH loc_oChe.lbl_4c_Lbl_DtEmiss
2435:             .Caption = "Dt Emis Cheque"
2436:             .Top = 4
2437:             .Left = 550
2438:             .Width = 90
2439:             .Height = 12
2440:             .AutoSize = .F.
2441:             .FontName = "Tahoma"
2442:             .FontSize = 7
2443:             .BackStyle = 0
2444:             .Visible = .T.
2445:         ENDWITH
2446: 
2447:         loc_oChe.AddObject("txt_4c_DtEmissChe", "TextBox")
2448:         WITH loc_oChe.txt_4c_DtEmissChe
2449:             .Top = 16
2450:             .Left = 544
2451:             .Width = 82
2452:             .Height = 21
2453:             .Value = {}
2454:             .InputMask = "@D"
2455:             .FontName = "Tahoma"

*-- Linhas 2463 a 2512:
2463:         loc_oPg2.AddObject("cnt_4c_Empresa", "Container")
2464:         loc_oEmp = loc_oPg2.cnt_4c_Empresa
2465:         WITH loc_oEmp
2466:             .Top = 537
2467:             .Left = 42
2468:             .Width = 698
2469:             .Height = 24
2470:             .BackStyle = 0
2471:             .BorderWidth = 0
2472:             .Visible = .T.
2473:         ENDWITH
2474: 
2475:         loc_oEmp.AddObject("lbl_4c_LblEmpresa", "Label")
2476:         WITH loc_oEmp.lbl_4c_LblEmpresa
2477:             .Caption = "Empresa :"
2478:             .Top = 4
2479:             .Left = 11
2480:             .Width = 50
2481:             .Height = 15
2482:             .AutoSize = .F.
2483:             .FontName = "Tahoma"
2484:             .FontSize = 8
2485:             .ForeColor = RGB(255, 255, 255)
2486:             .BackStyle = 0
2487:             .Visible = .T.
2488:         ENDWITH
2489: 
2490:         loc_oEmp.AddObject("txt_4c_Emps", "TextBox")
2491:         WITH loc_oEmp.txt_4c_Emps
2492:             .Top = 1
2493:             .Left = 63
2494:             .Width = 31
2495:             .Height = 21
2496:             .MaxLength = 3
2497:             .Value = ""
2498:             .FontName = "Tahoma"
2499:             .FontSize = 8
2500:             .Visible = .T.
2501:         ENDWITH
2502:         BINDEVENT(loc_oEmp.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpresa")
2503: 
2504:         loc_oEmp.AddObject("txt_4c_DEmps", "TextBox")
2505:         WITH loc_oEmp.txt_4c_DEmps
2506:             .Top = 1
2507:             .Left = 96
2508:             .Width = 290
2509:             .Height = 21
2510:             .Value = ""
2511:             .ReadOnly = .T.
2512:             .FontName = "Tahoma"

*-- Linhas 2521 a 2583:
2521:         loc_oPg2.AddObject("cnt_4c_Conta", "Container")
2522:         loc_oCnt = loc_oPg2.cnt_4c_Conta
2523:         WITH loc_oCnt
2524:             .Top = 560
2525:             .Left = 52
2526:             .Width = 648
2527:             .Height = 23
2528:             .BackStyle = 0
2529:             .BorderWidth = 0
2530:             .Visible = .T.
2531:         ENDWITH
2532: 
2533:         loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
2534:         WITH loc_oCnt.lbl_4c_LblConta
2535:             .Caption = "Conta :"
2536:             .Top = 4
2537:             .Left = 13
2538:             .Width = 38
2539:             .Height = 15
2540:             .AutoSize = .F.
2541:             .FontName = "Tahoma"
2542:             .FontSize = 8
2543:             .ForeColor = RGB(255, 255, 255)
2544:             .BackStyle = 0
2545:             .Visible = .T.
2546:         ENDWITH
2547: 
2548:         loc_oCnt.AddObject("txt_4c_ContaIclis", "TextBox")
2549:         WITH loc_oCnt.txt_4c_ContaIclis
2550:             .Top = 0
2551:             .Left = 53
2552:             .Width = 79
2553:             .Height = 21
2554:             .MaxLength = 10
2555:             .Value = ""
2556:             .FontName = "Tahoma"
2557:             .FontSize = 8
2558:             .Visible = .T.
2559:         ENDWITH
2560:         BINDEVENT(loc_oCnt.txt_4c_ContaIclis, "KeyPress", THIS, "ValidarContaIclis")
2561: 
2562:         loc_oCnt.AddObject("txt_4c_CpfIclis", "TextBox")
2563:         WITH loc_oCnt.txt_4c_CpfIclis
2564:             .Top = 0
2565:             .Left = 133
2566:             .Width = 150
2567:             .Height = 21
2568:             .MaxLength = 14
2569:             .Value = ""
2570:             .FontName = "Tahoma"
2571:             .FontSize = 8
2572:             .Visible = .T.
2573:         ENDWITH
2574: 
2575:         loc_oCnt.AddObject("txt_4c_NomeIclis", "TextBox")
2576:         WITH loc_oCnt.txt_4c_NomeIclis
2577:             .Top = 0
2578:             .Left = 285
2579:             .Width = 360
2580:             .Height = 21
2581:             .Value = ""
2582:             .ReadOnly = .T.
2583:             .FontName = "Tahoma"

*-- Linhas 2592 a 2681:
2592:         loc_oPg2.AddObject("cnt_4c_Filtro", "Container")
2593:         loc_oFil = loc_oPg2.cnt_4c_Filtro
2594:         WITH loc_oFil
2595:             .Top = 560
2596:             .Left = 699
2597:             .Width = 296
2598:             .Height = 60
2599:             .BackStyle = 1
2600:             .BackColor = RGB(235, 235, 235)
2601:             .BorderWidth = 1
2602:             .Visible = .T.
2603:         ENDWITH
2604: 
2605:         loc_oFil.AddObject("lbl_4c_LblFiltroVenc", "Label")
2606:         WITH loc_oFil.lbl_4c_LblFiltroVenc
2607:             .Caption = "Filtro Vencimento :"
2608:             .Top = 8
2609:             .Left = 29
2610:             .Width = 92
2611:             .Height = 15
2612:             .AutoSize = .F.
2613:             .FontName = "Tahoma"
2614:             .FontSize = 8
2615:             .BackStyle = 0
2616:             .Visible = .T.
2617:         ENDWITH
2618: 
2619:         loc_oFil.AddObject("txt_4c_DataI", "TextBox")
2620:         WITH loc_oFil.txt_4c_DataI
2621:             .Top = 5
2622:             .Left = 122
2623:             .Width = 79
2624:             .Height = 21
2625:             .Value = {}
2626:             .InputMask = "@D"
2627:             .FontName = "Tahoma"
2628:             .FontSize = 8
2629:             .Visible = .T.
2630:         ENDWITH
2631: 
2632:         loc_oFil.AddObject("lbl_4c_SepFil", "Label")
2633:         WITH loc_oFil.lbl_4c_SepFil
2634:             .Caption = CHR(224)
2635:             .Top = 8
2636:             .Left = 203
2637:             .Width = 8
2638:             .Height = 15
2639:             .AutoSize = .F.
2640:             .FontName = "Tahoma"
2641:             .FontSize = 8
2642:             .BackStyle = 0
2643:             .Visible = .T.
2644:         ENDWITH
2645: 
2646:         loc_oFil.AddObject("txt_4c_DataF", "TextBox")
2647:         WITH loc_oFil.txt_4c_DataF
2648:             .Top = 5
2649:             .Left = 212
2650:             .Width = 79
2651:             .Height = 21
2652:             .Value = {}
2653:             .InputMask = "@D"
2654:             .FontName = "Tahoma"
2655:             .FontSize = 8
2656:             .Visible = .T.
2657:         ENDWITH
2658: 
2659:         loc_oFil.AddObject("lbl_4c_LblClasemp", "Label")
2660:         WITH loc_oFil.lbl_4c_LblClasemp
2661:             .Caption = "Classe Empresarial :"
2662:             .Top = 34
2663:             .Left = 22
2664:             .Width = 98
2665:             .Height = 15
2666:             .AutoSize = .F.
2667:             .FontName = "Tahoma"
2668:             .FontSize = 8
2669:             .BackStyle = 0
2670:             .Visible = .T.
2671:         ENDWITH
2672: 
2673:         loc_oFil.AddObject("txt_4c_Clasemp", "TextBox")
2674:         WITH loc_oFil.txt_4c_Clasemp
2675:             .Top = 31
2676:             .Left = 122
2677:             .Width = 115
2678:             .Height = 21
2679:             .MaxLength = 10
2680:             .Value = ""
2681:             .FontName = "Tahoma"

*-- Linhas 2689 a 2767:
2689:         loc_oPg2.AddObject("cnt_4c_Responsavel", "Container")
2690:         loc_oRes = loc_oPg2.cnt_4c_Responsavel
2691:         WITH loc_oRes
2692:             .Top = 582
2693:             .Left = 19
2694:             .Width = 681
2695:             .Height = 24
2696:             .BackStyle = 0
2697:             .BorderWidth = 0
2698:             .Visible = .T.
2699:         ENDWITH
2700: 
2701:         loc_oRes.AddObject("lbl_4c_LblResp", "Label")
2702:         WITH loc_oRes.lbl_4c_LblResp
2703:             .Caption = "Respons" + CHR(225) + "vel :"
2704:             .Top = 5
2705:             .Left = 14
2706:             .Width = 68
2707:             .Height = 15
2708:             .AutoSize = .F.
2709:             .FontName = "Tahoma"
2710:             .FontSize = 8
2711:             .ForeColor = RGB(255, 255, 255)
2712:             .BackStyle = 0
2713:             .Visible = .T.
2714:         ENDWITH
2715: 
2716:         loc_oRes.AddObject("txt_4c_GruRes", "TextBox")
2717:         WITH loc_oRes.txt_4c_GruRes
2718:             .Top = 0
2719:             .Left = 86
2720:             .Width = 79
2721:             .Height = 21
2722:             .MaxLength = 10
2723:             .Value = ""
2724:             .FontName = "Tahoma"
2725:             .FontSize = 8
2726:             .Visible = .T.
2727:         ENDWITH
2728:         BINDEVENT(loc_oRes.txt_4c_GruRes, "KeyPress", THIS, "ValidarGrupoRes")
2729: 
2730:         loc_oRes.AddObject("lbl_4c_SepRes", "Label")
2731:         WITH loc_oRes.lbl_4c_SepRes
2732:             .Caption = "/"
2733:             .Top = 3
2734:             .Left = 168
2735:             .Width = 8
2736:             .Height = 15
2737:             .AutoSize = .F.
2738:             .FontName = "Tahoma"
2739:             .FontSize = 8
2740:             .ForeColor = RGB(255, 255, 255)
2741:             .BackStyle = 0
2742:             .Visible = .T.
2743:         ENDWITH
2744: 
2745:         loc_oRes.AddObject("txt_4c_ConRes", "TextBox")
2746:         WITH loc_oRes.txt_4c_ConRes
2747:             .Top = 0
2748:             .Left = 178
2749:             .Width = 79
2750:             .Height = 21
2751:             .MaxLength = 10
2752:             .Value = ""
2753:             .FontName = "Tahoma"
2754:             .FontSize = 8
2755:             .Visible = .T.
2756:         ENDWITH
2757:         BINDEVENT(loc_oRes.txt_4c_ConRes, "KeyPress", THIS, "ValidarContaRes")
2758: 
2759:         loc_oRes.AddObject("txt_4c_DConRes", "TextBox")
2760:         WITH loc_oRes.txt_4c_DConRes
2761:             .Top = 0
2762:             .Left = 259
2763:             .Width = 419
2764:             .Height = 21
2765:             .Value = ""
2766:             .ReadOnly = .T.
2767:             .FontName = "Tahoma"

*-- Linhas 2775 a 2810:
2775:         loc_oPg2.AddObject("cnt_4c_FollowUp", "Container")
2776:         loc_oFol = loc_oPg2.cnt_4c_FollowUp
2777:         WITH loc_oFol
2778:             .Top = 603
2779:             .Left = 41
2780:             .Width = 658
2781:             .Height = 25
2782:             .BackStyle = 0
2783:             .BorderWidth = 0
2784:             .Visible = .T.
2785:         ENDWITH
2786: 
2787:         loc_oFol.AddObject("lbl_4c_LblFollowUp", "Label")
2788:         WITH loc_oFol.lbl_4c_LblFollowUp
2789:             .Caption = "Followup :"
2790:             .Top = 3
2791:             .Left = 12
2792:             .Width = 50
2793:             .Height = 15
2794:             .AutoSize = .F.
2795:             .FontName = "Tahoma"
2796:             .FontSize = 8
2797:             .ForeColor = RGB(255, 255, 255)
2798:             .BackStyle = 0
2799:             .Visible = .T.
2800:         ENDWITH
2801: 
2802:         loc_oFol.AddObject("txt_4c_Obs", "TextBox")
2803:         WITH loc_oFol.txt_4c_Obs
2804:             .Top = 1
2805:             .Left = 64
2806:             .Width = 592
2807:             .Height = 21
2808:             .MaxLength = 200
2809:             .Value = ""
2810:             .FontName = "Tahoma"

*-- Linhas 2885 a 2898:
2885:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.valtots"
2886:                         loc_oGrid.Column6.ControlSource = ;
2887:                             "IIF(cursor_4c_Dados.concs=1,'Conciliado','Pendente')"
2888:                         loc_oGrid.Column1.Header1.Caption = "Lote"
2889:                         loc_oGrid.Column2.Header1.Caption = "Emp"
2890:                         loc_oGrid.Column3.Header1.Caption = "Dt. Entrada"
2891:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2892:                         loc_oGrid.Column5.Header1.Caption = "Valor"
2893:                         loc_oGrid.Column6.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
2894:                         THIS.FormatarGridLista(loc_oGrid)
2895:                     ENDIF
2896:                     loc_lResultado = .T.
2897:                 ENDIF
2898:             ENDIF

*-- Linhas 3543 a 3577:
3543:         WITH THIS.this_oBusinessObject
3544:             *-- Campos principais (readonly)
3545:             IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"
3546:                 loc_oPg2.txt_4c_Lote.Value = .this_nNumLotes
3547:             ENDIF
3548:             IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"
3549:                 loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(.this_cUsuar)
3550:             ENDIF
3551:             IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3552:                 loc_oPg2.txt_4c_Data.Value = .this_dDtEnts
3553:             ENDIF
3554:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3555:                 loc_oPg2.txt_4c_Oper.Value = ALLTRIM(.this_cCodigos)
3556:             ENDIF
3557: 
3558:             *-- Infos financeiras
3559:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"
3560:                 loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value = .this_nQtdeCheqs
3561:             ENDIF
3562:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3563:                 loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ALLTRIM(.this_cMoeds)
3564:             ENDIF
3565:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
3566:                 loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = .this_nCotas
3567:             ENDIF
3568:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"
3569:                 loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value = .this_nValTots
3570:             ENDIF
3571:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O"
3572:                 loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = .this_nValConvs
3573:             ENDIF
3574: 
3575:             *-- Origem
3576:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
3577:                 loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value = ALLTRIM(.this_cGruOrig)

*-- Linhas 3971 a 3997:
3971:         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
3972:             loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Enabled = loc_lEdicao
3973:         ENDIF
3974:         IF VARTYPE(loc_oPg2.cmd_4c_BtnExcluir) = "O"
3975:             loc_oPg2.cmd_4c_BtnExcluir.Enabled             = loc_lEdicao
3976:         ENDIF
3977:         IF VARTYPE(loc_oPg2.cmd_4c_BtnMarca) = "O"
3978:             loc_oPg2.cmd_4c_BtnMarca.Enabled               = loc_lEdicao
3979:         ENDIF
3980:         IF VARTYPE(loc_oPg2.cmd_4c_CmdExcCheque) = "O"
3981:             loc_oPg2.cmd_4c_CmdExcCheque.Enabled           = loc_lEdicao
3982:         ENDIF
3983:         IF VARTYPE(loc_oPg2.cmd_4c_Comm_Ini) = "O"
3984:             loc_oPg2.cmd_4c_Comm_Ini.Enabled               = loc_lEdicao
3985:         ENDIF
3986:         IF VARTYPE(loc_oPg2.cmd_4c_Comm_Fim) = "O"
3987:             loc_oPg2.cmd_4c_Comm_Fim.Enabled               = loc_lEdicao
3988:         ENDIF
3989: 
3990:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
3991:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
3992:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
3993:             ENDIF
3994:         ENDIF
3995:     ENDPROC
3996: 
3997:     *--------------------------------------------------------------------------

*-- Linhas 4004 a 4031:
4004:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
4005: 
4006:         IF VARTYPE(loc_oBotoes) = "O"
4007:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
4008:                 loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
4009:             ENDIF
4010:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
4011:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
4012:             ENDIF
4013:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
4014:                 loc_oBotoes.cmd_4c_Alterar.Enabled    = .T.
4015:             ENDIF
4016:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
4017:                 loc_oBotoes.cmd_4c_Excluir.Enabled    = .T.
4018:             ENDIF
4019:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
4020:                 loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
4021:             ENDIF
4022:         ENDIF
4023: 
4024:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
4025:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
4026:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
4027:             ENDIF
4028:         ENDIF
4029:     ENDPROC
4030: 
4031:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\lchBO.prg):
*==============================================================================
* lchBO.prg - Business Object para Lote de Cheques
* Herda de BusinessBase
* Tabela Principal : SigChLcq
* Chave Primaria   : NumLotes (numeric)
* Cursor de Dados  : cursor_4c_Dados
* Form relacionado : Formlch.prg
*==============================================================================

DEFINE CLASS lchBO AS BusinessBase

    *==========================================================================
    * PROPRIEDADES - TABELA SigChLcq (campos diretos)
    *==========================================================================

    *-- Identificacao do Lote
    this_nNumLotes    = 0      && PK - Numero do Lote
    this_nNumLoteFPs  = 0      && Numero do Lote de Parcelas vinculado

    *-- Operacao e configuracao
    this_cCodigos     = ""     && Codigo da Operacao (SigCdOpt.Operacao)
    this_cEmps        = ""     && Empresa C(3)
    this_cUsuar       = ""     && Usuario que criou/alterou

    *-- Moeda e valores financeiros
    this_cMoeds       = ""     && Codigo da Moeda
    this_nCotas       = 0      && Cotacao da Moeda
    this_cCotUsus     = ""     && Cotacao definida pelo Usuario (char(10) em SigChLcq)
    this_nValTots     = 0      && Valor Total em Moeda Original
    this_nValConvs    = 0      && Valor Total Convertido (ValTots / Cotas)

    *-- Datas
    this_dDtEnts      = {}     && Data de Entrada do Lote
    this_dDataTrans   = {}     && Data de Transporte (nullable em SigChLcq)

    *-- Grupo e Conta Destino (campos da tabela SigChLcq)
    this_cGrupos      = ""     && Grupo de Destino
    this_cContas      = ""     && Conta de Destino

    *-- Cliente Emissor (vinculo com SigCdCli)
    this_cIclis       = ""     && Codigo do Cliente Emissor
    this_cGrclis      = ""     && Grupo do Cliente Emissor

    *-- Quantidade e identificadores auxiliares
    this_nQtdeCheqs   = 0      && Quantidade de Cheques no Lote
    this_nOrdens      = 0      && Tipo de Ordens (de SigCdOpt.Ordens)

    *-- Observacoes e follow up
    this_cObss        = ""     && Observacoes gerais do Lote
    this_cFollowUp    = ""     && Texto do Follow Up
    this_lFollowUp    = .F.    && Flag Repetir Follow Up

    *==========================================================================
    * PROPRIEDADES - DESTINO (com descricoes para a UI)
    * Campos do container CntDestino (Page2)
    *==========================================================================

    this_cGruDest     = ""     && Grupo Destino (Get_Grupo em CntDestino)
    this_cConDest     = ""     && Conta Destino (Get_Conta em CntDestino)
    this_cDGruDest    = ""     && Descricao do Grupo Destino
    this_cDConDest    = ""     && Descricao da Conta Destino
    this_cCpfDest     = ""     && CPF quando destino e pessoa fisica

    *==========================================================================
    * PROPRIEDADES - ORIGEM
    * Campos do container CntOrigem (Page2)
    *==========================================================================

    this_cGruOrig     = ""     && Grupo de Origem (Get_GruOrig)
    this_cConOrig     = ""     && Conta de Origem (Get_ConOrig)
    this_cDGruOrig    = ""     && Descricao do Grupo de Origem
    this_cDConOrig    = ""     && Descricao da Conta de Origem
    this_cCpfOrig     = ""     && CPF da Origem

    *==========================================================================
    * PROPRIEDADES - CARTEIRA
    * Campos do container CntCarteira (Page2)
    *==========================================================================

    this_cGruCart     = ""     && Grupo de Carteira (Get_GruCart)
    this_cConCart     = ""     && Conta de Carteira (Get_ConCart)
    this_cDGruCart    = ""     && Descricao do Grupo de Carteira
    this_cDConCart    = ""     && Descricao da Conta de Carteira

    *==========================================================================
    * PROPRIEDADES - EMISSOR
    * Campos do container CntEmissor (Page2)
    *==========================================================================

    this_cGruEmiss    = ""     && Grupo do Emissor (Get_GruEmiss)
    this_cConEmiss    = ""     && Conta do Emissor (Get_ConEmiss)
    this_cDGruEmiss   = ""     && Descricao do Grupo do Emissor
    this_cDConEmiss   = ""     && Descricao da Conta do Emissor
    this_cCpfEmiss    = ""     && CPF do Emissor (Get_Cpf em CntEmissor)
    this_cNomeEmiss   = ""     && Nome do Emissor (Rclis de SigCdCli)

    *==========================================================================
    * PROPRIEDADES - DESPESA
    * Campos do container cntDespesa (Page2)
    *==========================================================================

    this_cGruEmts     = ""     && Grupo de Despesa (Get_GruEmts)
    this_cConEmts     = ""     && Conta de Despesa (Get_ConEmts)
    this_cDGruEmts    = ""     && Descricao do Grupo de Despesa
    this_cDConEmts    = ""     && Descricao da Conta de Despesa
    this_cCpfEmts     = ""     && CPF da Despesa

    *==========================================================================
    * PROPRIEDADES - CENTRO DE CUSTO
    * Campos do container CntCCusto (Page2)
    *==========================================================================

    this_cGruCCs      = ""     && Grupo de Centro de Custo (Get_GrupoCcs)
    this_cConCCs      = ""     && Conta de Centro de Custo (Get_ContaCcs)
    this_cDGruCCs     = ""     && Descricao do Grupo CC
    this_cDConCCs     = ""     && Descricao da Conta CC
    this_cCpfCCs      = ""     && CPF do Centro de Custo

    *==========================================================================
    * PROPRIEDADES - RESPONSAVEL
    * Campos do container CntResponsavel (Page2)
    *==========================================================================

    this_cGruRes      = ""     && Grupo do Responsavel (Get_GruRes)
    this_cConRes      = ""     && Conta do Responsavel (Get_ConRes)
    this_cDConRes     = ""     && Descricao da Conta do Responsavel

    *==========================================================================
    * PROPRIEDADES - EMPRESA (descricao para exibicao)
    *==========================================================================

    this_cDEmps       = ""     && Razao Social / Descricao da Empresa

    *==========================================================================
    * PROPRIEDADES - CONTA DO CLIENTE/EMISSOR (CntConta)
    * Container na parte inferior da Page2 para identificacao do emissor
    *==========================================================================

    this_cContaIclis  = ""     && Conta/Iclis do Emissor (Get_Conta em CntConta)
    this_cCpfIclis    = ""     && CPF do Emissor (Get_CPF em CntConta)
    this_cNomeIclis   = ""     && Nome do Emissor (Get_Nome em CntConta)

    *==========================================================================
    * PROPRIEDADES - PROCESSAMENTO EM LOTE
    * Campos do container CntProcessa (Page2) - processamento automatico
    *==========================================================================

    this_dDtIniProc   = {}     && Data Inicial do Processamento
    this_dDtFimProc   = {}     && Data Final do Processamento
    this_nLoteProc    = 0      && Numero do Lote para Processamento
    this_cEmpProc     = ""     && Empresa para Processamento em Lote
    this_cPlanilha    = ""     && Caminho completo da Planilha Excel (.XLS)

    *==========================================================================
    * PROPRIEDADES - FILTROS DE LISTAGEM (Page1)
    * Campos do cntFiltros na Page1 (lista de lotes)
    *==========================================================================

    this_dDataFiltroI = {}     && Data Inicial do Filtro (Dt_inicial)
    this_dDataFiltroF = {}     && Data Final do Filtro (Dt_final)
    this_nFiltroConc  = 0      && Filtro Conciliacao: 0=Todos, 1=Conciliados, 2=Pendentes, 3=Ambos
    this_cFiltClasemp = ""     && Filtro por Classe Empresarial (Get_Clasemp)

    *==========================================================================
    * PROPRIEDADES - CURSOR DE DADOS
    *==========================================================================

    this_cCursorDados = "cursor_4c_Dados"   && Cursor principal para listagem de lotes

    *==========================================================================
    * INIT - Configuracao da tabela principal
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChLcq"
            THIS.this_cCampoChave = "NumLotes"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar lchBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNumLotes, 10))
    ENDFUNC

    *==========================================================================
    * Buscar - Lista lotes de cheques com filtros opcionais
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.dtents >= '2024-01-01'")
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.codigos, a.emps, a.dtents, a.datas," + ;
                " a.datatrans, a.moeds, a.cotas, a.valtots, a.valconvs," + ;
                " a.grupos, a.contas, a.gruorigs, a.conorigs," + ;
                " a.grucarts, a.concarts, a.iclis, a.grclis, a.usuarios," + ;
                " a.concs, a.numloteFps, a.cotusus," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.obs" + ;
                " FROM SigChLcq a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.dtents DESC, a.numlotes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega lote pelo numlotes (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.numloteFps, a.codigos, a.emps, a.usuarios," + ;
                " a.moeds, a.cotas, a.cotusus, a.valtots, a.valconvs," + ;
                " a.dtents, a.datatrans, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.iclis, a.grclis, a.concs, a.obs," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.tipos, a.nums," + ;
                " a.numdopes, a.dopes, a.empdopnums, a.cnotas, a.locals, a.ntrans" + ;
                " FROM SigChLcq a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLotes)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLotes    = TratarNulo(numlotes,   "N")
            THIS.this_nNumLoteFPs  = TratarNulo(numloteFps, "N")
            THIS.this_cCodigos     = TratarNulo(codigos,    "C")
            THIS.this_cEmps        = TratarNulo(emps,       "C")
            THIS.this_cUsuar       = TratarNulo(usuarios,   "C")
            THIS.this_cMoeds       = TratarNulo(moeds,      "C")
            THIS.this_nCotas       = TratarNulo(cotas,      "N")
            THIS.this_cCotUsus     = TratarNulo(cotusus,    "C")
            THIS.this_nValTots     = TratarNulo(valtots,    "N")
            THIS.this_nValConvs    = TratarNulo(valconvs,   "N")
            THIS.this_dDtEnts      = TratarNulo(dtents,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,  "D")
            THIS.this_cGrupos      = TratarNulo(grupos,     "C")
            THIS.this_cContas      = TratarNulo(contas,     "C")
            THIS.this_cIclis       = TratarNulo(iclis,      "C")
            THIS.this_cGrclis      = TratarNulo(grclis,     "C")
            THIS.this_cObss        = TratarNulo(obs,        "C")
            THIS.this_cGruCart     = TratarNulo(grucarts,   "C")
            THIS.this_cConCart     = TratarNulo(concarts,   "C")
            THIS.this_cGruOrig     = TratarNulo(gruorigs,   "C")
            THIS.this_cConOrig     = TratarNulo(conorigs,   "C")
            THIS.this_cGruCCs      = TratarNulo(grupoccs,   "C")
            THIS.this_cConCCs      = TratarNulo(contaccs,   "C")
            THIS.this_cGruEmts     = TratarNulo(grupems,    "C")
            THIS.this_cConEmts     = TratarNulo(contems,    "C")
            THIS.this_cGruRes      = TratarNulo(gratends,   "C")
            THIS.this_cConRes      = TratarNulo(atends,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarCheques - Carrega cheques do lote em cursor_4c_Cheques (grid Page2)
    *==========================================================================
    FUNCTION BuscarCheques(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.nums, a.bancos, a.agencias, a.ncontas, a.ncheques," + ;
                " a.valors, a.valpags, a.vencs, a.datas, a.dtemis, a.nalineas," + ;
                " a.emps, a.iclis, a.grclis, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.grures, a.conres, a.protocolos, a.leituras, a.numeros" + ;
                " FROM SIGCHE a" + ;
                " WHERE a.numos = " + FormatarNumeroSQL(par_nNumLotes) + ;
                " ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

            IF USED("cursor_4c_Cheques")
                USE IN cursor_4c_Cheques
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cheques")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar cheques do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.this_nQtdeCheqs = RECCOUNT("cursor_4c_Cheques")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.BuscarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProximoLote - Retorna proximo numlotes disponivel para a empresa
    *==========================================================================
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigChLcq" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo
        loc_lSucesso = .F.

        TRY
            loc_nProximo = THIS.ObterProximoLote()
            THIS.this_nNumLotes = loc_nProximo

            loc_cSQL = "INSERT INTO SigChLcq (" + ;
                " numlotes, numloteFps, codigos, emps, usuarios, moeds, cotas, cotusus," + ;
                " valtots, valconvs, dtents, datatrans, grupos, contas," + ;
                " iclis, grclis, obs, concs, grucarts, concarts," + ;
                " gruorigs, conorigs, grupoccs, contaccs, grupems, contems," + ;
                " gratends, atends, autos, tipos, nums, numdopes, dopes," + ;
                " empdopnums, cnotas, locals, ntrans, dtsis)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLotes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumLoteFPs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                "0," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConRes)) + "," + ;
                "0,'','',0,'','',0,0,GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigChLcq SET" + ;
                " codigos = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                " emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                " cotusus = "   + EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                " dtents = "    + FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                " datatrans = " + IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                " grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                " contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                " iclis = "     + EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                " grclis = "    + EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                " obs = "       + EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                " grucarts = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                " concarts = "  + EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                " gruorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                " conorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                " grupoccs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                " contaccs = "  + EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                " grupems = "   + EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                " contems = "   + EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                " gratends = "  + EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                " atends = "    + EscaparSQL(ALLTRIM(THIS.this_cConRes)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLotes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de cheques (SIGCHE) e do lote (SigChLcq)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigChLcq WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

