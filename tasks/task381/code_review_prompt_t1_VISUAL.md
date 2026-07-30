# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 178: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 316: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 399: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 424: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCor.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1200 linhas total):

*-- Linhas 77 a 96:
77: 
78:         WITH THIS.pgf_4c_Paginas
79:             .PageCount = 2
80:             .Top       = -29
81:             .Left      = 0
82:             .Width     = THIS.Width
83:             .Height    = THIS.Height + 29
84:             .Tabs      = .F.
85:             .Visible   = .T.
86: 
87:             .Page1.Caption   = "Lista"
88:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:             .Page1.BackColor = RGB(255, 255, 255)
90: 
91:             .Page2.Caption   = "Dados"
92:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page2.BackColor = RGB(255, 255, 255)
94:         ENDWITH
95: 
96:         THIS.ConfigurarPaginaLista()

*-- Linhas 111 a 148:
111:         *-- Original: Top=1. Com compensacao +29: Top=31
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 31
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121:         ENDWITH
122: 
123:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
124:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
125:             .Caption   = THIS.Caption
126:             .Top       = 15
127:             .Left      = 10
128:             .Width     = 769
129:             .Height    = 40
130:             .FontName  = "Tahoma"
131:             .FontSize  = 16
132:             .FontBold  = .T.
133:             .ForeColor = RGB(0, 0, 0)
134:             .BackStyle = 0
135:             .AutoSize  = .F.
136:             .Visible   = .T.
137:         ENDWITH
138: 
139:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Caption   = THIS.Caption
142:             .Top       = 18
143:             .Left      = 10
144:             .Width     = 769
145:             .Height    = 46
146:             .FontName  = "Tahoma"
147:             .FontSize  = 16
148:             .FontBold  = .T.

*-- Linhas 156 a 345:
156:         *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
157:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
158:         WITH loc_oPagina.cnt_4c_Botoes
159:             .Top         = 29
160:             .Left        = 542
161:             .Width       = 390
162:             .Height      = 85
163:             .BackStyle = 0
164:             .BorderWidth = 0
165:             .Visible     = .T.
166:         ENDWITH
167: 
168:         *-- Botao Incluir (Left=5)
169:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
170:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
171:             .Caption         = "Incluir"
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
173:             .PicturePosition = 13
174:             .Top             = 5
175:             .Left            = 5
176:             .Width           = 75
177:             .Height          = 75
178:             .FontName        = "Comic Sans MS"
179:             .FontBold        = .T.
180:             .FontItalic      = .T.
181:             .FontSize        = 8
182:             .ForeColor       = RGB(90, 90, 90)
183:             .BackColor       = RGB(255, 255, 255)
184:             .Themes          = .F.
185:             .SpecialEffect   = 0
186:             .MousePointer    = 15
187:             .WordWrap        = .T.
188:             .AutoSize        = .F.
189:             .Visible         = .T.
190:         ENDWITH
191:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
192: 
193:         *-- Botao Visualizar (Left=80)
194:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
195:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
196:             .Caption         = "Visualizar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 80
201:             .Width           = 75
202:             .Height          = 75
203:             .FontName        = "Comic Sans MS"
204:             .FontBold        = .T.
205:             .FontItalic      = .T.
206:             .FontSize        = 8
207:             .ForeColor       = RGB(90, 90, 90)
208:             .BackColor       = RGB(255, 255, 255)
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .WordWrap        = .T.
213:             .AutoSize        = .F.
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         *-- Botao Alterar (Left=155)
219:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
220:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
221:             .Caption         = "Alterar"
222:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:             .PicturePosition = 13
224:             .Top             = 5
225:             .Left            = 155
226:             .Width           = 75
227:             .Height          = 75
228:             .FontName        = "Comic Sans MS"
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .FontSize        = 8
232:             .ForeColor       = RGB(90, 90, 90)
233:             .BackColor       = RGB(255, 255, 255)
234:             .Themes          = .F.
235:             .SpecialEffect   = 0
236:             .MousePointer    = 15
237:             .WordWrap        = .T.
238:             .AutoSize        = .F.
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir (Left=230)
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Comic Sans MS"
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .FontSize        = 8
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:         *-- Botao Buscar (Left=305)
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
271:             .Caption         = "Buscar"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
273:             .PicturePosition = 13
274:             .Top             = 5
275:             .Left            = 305
276:             .Width           = 75
277:             .Height          = 75
278:             .FontName        = "Comic Sans MS"
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .FontSize        = 8
282:             .ForeColor       = RGB(90, 90, 90)
283:             .BackColor       = RGB(255, 255, 255)
284:             .Themes          = .F.
285:             .SpecialEffect   = 0
286:             .MousePointer    = 15
287:             .WordWrap        = .T.
288:             .AutoSize        = .F.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
294:         *-- Legado: Grupo_Saida.Left=918, Top=-1. Canonico: Left=917, Top=29, Width=90
295:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
296:         WITH loc_oPagina.cnt_4c_Saida
297:             .Top         = 29
298:             .Left        = 917
299:             .Width       = 90
300:             .Height      = 85
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
307:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
309:             .Caption         = "Encerrar"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
311:             .PicturePosition = 13
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .FontName        = "Comic Sans MS"
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontSize        = 8
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .MousePointer    = 15
325:             .WordWrap        = .T.
326:             .AutoSize        = .F.
327:             .Visible         = .T.
328:         ENDWITH
329:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
330: 
331:         *-- Grid de listagem de cores
332:         *-- Original: Grade.Top=121, Left=12, Width=940
333:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
334:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
335:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
336:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
337:         loc_oPagina.grd_4c_Lista.ColumnCount = 4
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 880
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 376 a 452:
376:         *-- Com compensacao PageFrame +29: Top=33 (4+29), Left=842
377:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
378:         WITH loc_oPagina.cnt_4c_BotoesAcao
379:             .Top         = 33
380:             .Left        = 842
381:             .Width       = 160
382:             .Height      = 85
383:             .BackStyle = 1
384:             .BackColor = RGB(255, 255, 255)
385:             .BorderWidth = 0
386:             .Visible     = .T.
387:         ENDWITH
388: 
389:         *-- Botao Confirmar (Salvar) - icone cadastro_salvar_60.jpg (Problema 16: NAO confirmar_60)
390:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 5
397:             .Width           = 75
398:             .Height          = 75
399:             .FontName        = "Comic Sans MS"
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .FontSize        = 8
403:             .ForeColor       = RGB(90, 90, 90)
404:             .BackColor       = RGB(255, 255, 255)
405:             .Themes          = .F.
406:             .SpecialEffect   = 0
407:             .MousePointer    = 15
408:             .WordWrap        = .T.
409:             .AutoSize        = .F.
410:             .Visible         = .T.
411:         ENDWITH
412:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
413: 
414:         *-- Botao Cancelar
415:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
416:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
417:             .Caption         = "Encerrar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 80
422:             .Width           = 75
423:             .Height          = 75
424:             .FontName        = "Comic Sans MS"
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .FontSize        = 8
428:             .ForeColor       = RGB(90, 90, 90)
429:             .BackColor       = RGB(255, 255, 255)
430:             .Themes          = .F.
431:             .SpecialEffect   = 0
432:             .MousePointer    = 15
433:             .WordWrap        = .T.
434:             .AutoSize        = .F.
435:             .Visible         = .T.
436:         ENDWITH
437:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
438: 
439:         *----------------------------------------------------------------------
440:         * CAMPO 1: Codigo (cods) - Say1.top=131+29=160, Getcods.top=127+29=156
441:         *   Say1: left=338; Getcods: left=387, width=41, height=24
442:         *----------------------------------------------------------------------
443:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
444:         WITH loc_oPagina.lbl_4c_Codigo
445:             .Caption   = "C" + CHR(243) + "digo : "
446:             .Top       = 160
447:             .Left      = 338
448:             .Width     = 49
449:             .Height    = 17
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .FontBold  = .F.

*-- Linhas 460 a 469:
460:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
461:         WITH loc_oPagina.txt_4c_Codigo
462:             .Value         = ""
463:             .Top           = 156
464:             .Left          = 387
465:             .Width         = 41
466:             .Height        = 24
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8
469:             .MaxLength     = 20

*-- Linhas 475 a 490:
475:         ENDWITH
476: 
477:         *----------------------------------------------------------------------
478:         * CAMPO 2: Descricao (descs) - Say2.top=158+29=187, Getdescs.top=154+29=183
479:         *   Say2: left=325; Getdescs: left=387, width=290, height=24
480:         *----------------------------------------------------------------------
481:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
482:         WITH loc_oPagina.lbl_4c_Descricao
483:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
484:             .Top       = 187
485:             .Left      = 325
486:             .Width     = 62
487:             .Height    = 17
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .FontBold  = .F.

*-- Linhas 498 a 507:
498:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
499:         WITH loc_oPagina.txt_4c_Descricao
500:             .Value         = ""
501:             .Top           = 183
502:             .Left          = 387
503:             .Width         = 290
504:             .Height        = 24
505:             .FontName      = "Tahoma"
506:             .FontSize      = 8
507:             .MaxLength     = 40

*-- Linhas 513 a 528:
513:         ENDWITH
514: 
515:         *----------------------------------------------------------------------
516:         * CAMPO 3: Variacao de Preco (varias) - Say3.top=185+29=214, Getvarias.top=181+29=210
517:         *   Say3: left=285; Getvarias: left=387, width=60, height=24
518:         *----------------------------------------------------------------------
519:         loc_oPagina.AddObject("lbl_4c_VariacaoPreco", "Label")
520:         WITH loc_oPagina.lbl_4c_VariacaoPreco
521:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o : "
522:             .Top       = 214
523:             .Left      = 285
524:             .Width     = 102
525:             .Height    = 17
526:             .FontName  = "Tahoma"
527:             .FontSize  = 8
528:             .FontBold  = .F.

*-- Linhas 536 a 545:
536:         loc_oPagina.AddObject("txt_4c_VariacaoPreco", "TextBox")
537:         WITH loc_oPagina.txt_4c_VariacaoPreco
538:             .Value         = 0
539:             .Top           = 210
540:             .Left          = 387
541:             .Width         = 60
542:             .Height        = 24
543:             .FontName      = "Tahoma"
544:             .FontSize      = 8
545:             .InputMask     = "99999.99"

*-- Linhas 551 a 566:
551:         ENDWITH
552: 
553:         *----------------------------------------------------------------------
554:         * CAMPO 4: Grupo (grupos/cgrus) - Say4.top=212+29=241, Get_Grupo.top=208+29=237
555:         *   Say4: left=342; Get_Grupo: left=387, width=80, height=24
556:         *----------------------------------------------------------------------
557:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
558:         WITH loc_oPagina.lbl_4c_Grupo
559:             .Caption   = "Grupo : "
560:             .Top       = 241
561:             .Left      = 342
562:             .Width     = 45
563:             .Height    = 17
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .FontBold  = .F.

*-- Linhas 574 a 583:
574:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
575:         WITH loc_oPagina.txt_4c_Grupo
576:             .Value         = ""
577:             .Top           = 237
578:             .Left          = 387
579:             .Width         = 80
580:             .Height        = 24
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .MaxLength     = 20

*-- Linhas 589 a 604:
589:         ENDWITH
590: 
591:         *----------------------------------------------------------------------
592:         * CAMPO 5: Variacao de Peso (Pesos) - Say5.top=239+29=268, Get_Peso.top=235+29=264
593:         *   Say5: left=289, "Variacao de Peso :"; Get_Peso: left=387, width=70, height=24
594:         *----------------------------------------------------------------------
595:         loc_oPagina.AddObject("lbl_4c_VariacaoPeso", "Label")
596:         WITH loc_oPagina.lbl_4c_VariacaoPeso
597:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Peso : "
598:             .Top       = 268
599:             .Left      = 289
600:             .Width     = 98
601:             .Height    = 17
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .FontBold  = .F.

*-- Linhas 612 a 621:
612:         loc_oPagina.AddObject("txt_4c_Peso", "TextBox")
613:         WITH loc_oPagina.txt_4c_Peso
614:             .Value         = 0
615:             .Top           = 264
616:             .Left          = 387
617:             .Width         = 70
618:             .Height        = 24
619:             .FontName      = "Tahoma"
620:             .FontSize      = 8
621:             .InputMask     = "9999999.99"

*-- Linhas 627 a 644:
627:         ENDWITH
628: 
629:         *----------------------------------------------------------------------
630:         * CAMPO 6: Tipo de Cor (tpCors) - Say7.top=266+29=295, Get_TpCor.top=262+29=291
631:         *   Say7: left=316, "Tipo de Cor :"; Get_TpCor: left=387, width=17
632:         *   Say9: "(S/N)", top=295, left=413
633:         *   Valid no legado: Return Inlist(This.Value,"S","N"," ") -> validar no LostFocus
634:         *----------------------------------------------------------------------
635:         loc_oPagina.AddObject("lbl_4c_TipoCor", "Label")
636:         WITH loc_oPagina.lbl_4c_TipoCor
637:             .Caption   = "Tipo de Cor : "
638:             .Top       = 295
639:             .Left      = 316
640:             .Width     = 71
641:             .Height    = 17
642:             .FontName  = "Tahoma"
643:             .FontSize  = 8
644:             .FontBold  = .F.

*-- Linhas 652 a 661:
652:         loc_oPagina.AddObject("txt_4c_TipoCor", "TextBox")
653:         WITH loc_oPagina.txt_4c_TipoCor
654:             .Value         = ""
655:             .Top           = 291
656:             .Left          = 387
657:             .Width         = 17
658:             .Height        = 24
659:             .FontName      = "Tahoma"
660:             .FontSize      = 8
661:             .MaxLength     = 1

*-- Linhas 667 a 700:
667:         ENDWITH
668:         BINDEVENT(loc_oPagina.txt_4c_TipoCor, "KeyPress", THIS, "ValidarTipoCor")
669: 
670:         loc_oPagina.AddObject("lbl_4c_TipoCorSN", "Label")
671:         WITH loc_oPagina.lbl_4c_TipoCorSN
672:             .Caption   = "(S/N)"
673:             .Top       = 295
674:             .Left      = 413
675:             .Width     = 35
676:             .Height    = 17
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .FontBold  = .F.
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackStyle = 0
682:             .AutoSize  = .F.
683:             .Visible   = .T.
684:         ENDWITH
685: 
686:         *----------------------------------------------------------------------
687:         * CAMPO 7: Dias Entrega (DiasEnts) - Say6.top=293+29=322, getDiasEnts.top=289+29=318
688:         *   Say6: left=274, "Adicionar na Entrega :"; getDiasEnts: left=386, width=31
689:         *   Say8: "Dias", top=322, left=422
690:         *----------------------------------------------------------------------
691:         loc_oPagina.AddObject("lbl_4c_DiasEntrega", "Label")
692:         WITH loc_oPagina.lbl_4c_DiasEntrega
693:             .Caption   = "Adicionar na Entrega :"
694:             .Top       = 322
695:             .Left      = 274
696:             .Width     = 113
697:             .Height    = 17
698:             .FontName  = "Tahoma"
699:             .FontSize  = 8
700:             .FontBold  = .F.

*-- Linhas 708 a 734:
708:         loc_oPagina.AddObject("txt_4c_DiasEntrega", "TextBox")
709:         WITH loc_oPagina.txt_4c_DiasEntrega
710:             .Value         = 0
711:             .Top           = 318
712:             .Left          = 386
713:             .Width         = 31
714:             .Height        = 24
715:             .FontName      = "Tahoma"
716:             .FontSize      = 8
717:             .InputMask     = "999"
718:             .BackColor     = RGB(255, 255, 255)
719:             .ForeColor     = RGB(0, 0, 0)
720:             .BorderStyle   = 1
721:             .SpecialEffect = 0
722:             .Visible       = .T.
723:         ENDWITH
724: 
725:         loc_oPagina.AddObject("lbl_4c_DiasLabel", "Label")
726:         WITH loc_oPagina.lbl_4c_DiasLabel
727:             .Caption   = "Dias"
728:             .Top       = 322
729:             .Left      = 422
730:             .Width     = 30
731:             .Height    = 17
732:             .FontName  = "Tahoma"
733:             .FontSize  = 8
734:             .FontBold  = .F.

*-- Linhas 776 a 787:
776:                 loc_oGrid.Column4.Width = 100
777: 
778:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
779:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
780:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
781:                 loc_oGrid.Column3.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Pre" + CHR(231) + "o"
782:                 loc_oGrid.Column4.Header1.Caption = "Varia" + CHR(231) + CHR(227) + "o Peso"
783: 
784:                 THIS.FormatarGridLista(loc_oGrid)
785:                 loc_lResultado = .T.
786:             ENDIF
787: 

*-- Linhas 1169 a 1181:
1169:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1170: 
1171:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1172:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1173:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1174:             ENDIF
1175:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1176:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1177:             ENDIF
1178:         ENDIF
1179:     ENDPROC
1180: 
1181:     *===========================================================================


### BO (C:\4c\projeto\app\classes\CorBO.prg):
*====================================================================
* CorBO.prg
*
* Business Object para Cadastro de Cores
* Tabela: SigCdCor
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CorBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCor)
    this_cCodigo        = ""    && cods char(4) - PK
    this_cDescricao     = ""    && descs char(40)
    this_nVariacaoPreco = 0     && varias numeric(6,2)
    this_cGrupo         = ""    && grupos char(10)
    this_nPeso          = 0     && pesos numeric(8,2)
    this_cTipoCor       = ""    && tpcors char(1) - S/N
    this_nDiasEntrega   = 0     && diasents numeric(3,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCor"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CorBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo        = TratarNulo(cods,     "C")
                THIS.this_cDescricao     = TratarNulo(descs,    "C")
                THIS.this_nVariacaoPreco = TratarNulo(varias,   "N")
                THIS.this_cGrupo         = TratarNulo(grupos,   "C")
                THIS.this_nPeso          = TratarNulo(Pesos,    "N")
                THIS.this_cTipoCor       = TratarNulo(tpCors,   "C")
                THIS.this_nDiasEntrega   = TratarNulo(DiasEnts, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CorBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !EMPTY(THIS.this_cTipoCor)
            IF !INLIST(THIS.this_cTipoCor, "S", "N", " ")
                MsgAviso("Tipo de Cor inv" + CHR(225) + "lido! Use S ou N.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCor" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CorBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdCor
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCor (cods, descs, varias, grupos, Pesos, tpCors, DiasEnts)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                    <<EscaparSQL(THIS.this_cTipoCor)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasEntrega, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CorBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdCor
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCor
                SET descs    = <<EscaparSQL(THIS.this_cDescricao)>>,
                    varias   = <<FormatarNumeroSQL(THIS.this_nVariacaoPreco, 2)>>,
                    grupos   = <<EscaparSQL(THIS.this_cGrupo)>>,
                    Pesos    = <<FormatarNumeroSQL(THIS.this_nPeso, 2)>>,
                    tpCors   = <<EscaparSQL(THIS.this_cTipoCor)>>,
                    DiasEnts = <<FormatarNumeroSQL(THIS.this_nDiasEntrega, 0)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CorBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdCor
    * Verifica uso em fichas tecnicas (SigPrPrr x SigCdPro) antes de excluir
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se cor esta sendo usada em fichas tecnicas
            loc_cSQL = "SELECT COUNT(*) AS nNreg1s" + ;
                " FROM SigPrPrr a INNER JOIN SigCdPro b ON b.cPros = a.cPros" + ;
                " WHERE a.CodCors = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCors")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCors")
                    SELECT cursor_4c_ChkCors
                    loc_nUso = NVL(cursor_4c_ChkCors.nNreg1s, 0)
                    USE IN cursor_4c_ChkCors
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Cor Sendo Utilizada Em Fichas T" + CHR(233) + "cnicas!!!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCor WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CorBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descs, varias, Pesos
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(20), descs C(40), varias N(6,2), Pesos N(8,2))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descs, varias, Pesos FROM SigCdCor"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar cores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar cores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CorBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs, varias, grupos, Pesos, tpCors, DiasEnts" + ;
                " FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Cor n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar cor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CorBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

