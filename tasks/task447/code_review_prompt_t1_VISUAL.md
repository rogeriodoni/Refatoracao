# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 197: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 221: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 304: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 419: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 443: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormICM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1347 linhas total):

*-- Linhas 28 a 36:
28:         LOCAL loc_lResultado
29:         loc_lResultado = .F.
30:         TRY
31:             THIS.Caption = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
32:             loc_lResultado = DODEFAULT()
33:         CATCH TO loc_oErro
34:             MsgErro(loc_oErro.Message + CHR(13) + ;
35:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.Init")
36:         ENDTRY

*-- Linhas 72 a 92:
72:     PROTECTED PROCEDURE ConfigurarPageFrame()
73:     *==========================================================================
74:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
75:         THIS.pgf_4c_Paginas.Top       = -29
76:         THIS.pgf_4c_Paginas.Left      = 0
77:         THIS.pgf_4c_Paginas.Width     = THIS.Width
78:         THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
79:         THIS.pgf_4c_Paginas.PageCount = 2
80:         THIS.pgf_4c_Paginas.Tabs      = .F.
81:         THIS.pgf_4c_Paginas.Visible   = .T.
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .Page1.Caption    = "Lista"
85:             .Page1.BackColor  = RGB(100, 100, 100)
86:             .Page1.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Caption    = "Dados"
88:             .Page2.BackColor  = RGB(100, 100, 100)
89:             .Page2.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91: 
92:         THIS.ConfigurarPaginaLista()

*-- Linhas 105 a 142:
105:         *-- Cabecalho escuro com titulo (cntSombra no legado)
106:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
107:         WITH loc_oPagina.cnt_4c_Cabecalho
108:             .Top         = 31
109:             .Left        = 0
110:             .Width       = THIS.Width
111:             .Height      = 80
112:             .BackColor   = RGB(100, 100, 100)
113:             .BorderWidth = 0
114:             .Visible     = .T.
115:         ENDWITH
116: 
117:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
118:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
119:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
120:             .Top       = 15
121:             .Left      = 10
122:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
123:             .Height    = 40
124:             .FontName  = "Tahoma"
125:             .FontSize  = 16
126:             .FontBold  = .T.
127:             .ForeColor = RGB(0, 0, 0)
128:             .BackStyle = 0
129:             .AutoSize  = .F.
130:             .Visible   = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
135:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
136:             .Top       = 18
137:             .Left      = 10
138:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
139:             .Height    = 46
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.

*-- Linhas 149 a 325:
149:         *-- Container botoes CRUD (Grupo_op no legado)
150:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
151:         WITH loc_oPagina.cnt_4c_Botoes
152:             .Top         = 29
153:             .Left        = 542
154:             .Width       = 390
155:             .Height      = 85
156:             .BackStyle = 0
157:             .BorderWidth = 0
158:             .Visible     = .T.
159:         ENDWITH
160: 
161:         *-- Incluir
162:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
163:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
164:             .Caption         = "Incluir"
165:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
166:             .PicturePosition = 13
167:             .Top = 5
168:             .Left = 5
169:             .Width = 75
170:             .Height = 75
171:             .BackColor   = RGB(255, 255, 255)
172:             .ForeColor   = RGB(90, 90, 90)
173:             .FontName    = "Comic Sans MS"
174:             .FontSize    = 8
175:             .FontBold    = .T.
176:             .FontItalic  = .T.
177:             .Themes      = .F.
178:             .SpecialEffect = 0
179:             .WordWrap    = .T.
180:             .AutoSize    = .F.
181:             .MousePointer = 15
182:         ENDWITH
183:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
184: 
185:         *-- Visualizar
186:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
187:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
188:             .Caption         = "Visualizar"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
190:             .PicturePosition = 13
191:             .Top = 5
192:             .Left = 80
193:             .Width = 75
194:             .Height = 75
195:             .BackColor   = RGB(255, 255, 255)
196:             .ForeColor   = RGB(90, 90, 90)
197:             .FontName    = "Comic Sans MS"
198:             .FontSize    = 8
199:             .FontBold    = .T.
200:             .FontItalic  = .T.
201:             .Themes      = .F.
202:             .SpecialEffect = 0
203:             .WordWrap    = .T.
204:             .AutoSize    = .F.
205:             .MousePointer = 15
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
208: 
209:         *-- Alterar
210:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
211:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
212:             .Caption         = "Alterar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
214:             .PicturePosition = 13
215:             .Top = 5
216:             .Left = 155
217:             .Width = 75
218:             .Height = 75
219:             .BackColor   = RGB(255, 255, 255)
220:             .ForeColor   = RGB(90, 90, 90)
221:             .FontName    = "Comic Sans MS"
222:             .FontSize    = 8
223:             .FontBold    = .T.
224:             .FontItalic  = .T.
225:             .Themes      = .F.
226:             .SpecialEffect = 0
227:             .WordWrap    = .T.
228:             .AutoSize    = .F.
229:             .MousePointer = 15
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         *-- Excluir
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top = 5
240:             .Left = 230
241:             .Width = 75
242:             .Height = 75
243:             .BackColor   = RGB(255, 255, 255)
244:             .ForeColor   = RGB(90, 90, 90)
245:             .FontName    = "Comic Sans MS"
246:             .FontSize    = 8
247:             .FontBold    = .T.
248:             .FontItalic  = .T.
249:             .Themes      = .F.
250:             .SpecialEffect = 0
251:             .WordWrap    = .T.
252:             .AutoSize    = .F.
253:             .MousePointer = 15
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
256: 
257:         *-- Buscar
258:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
259:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
260:             .Caption         = "Buscar"
261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
262:             .PicturePosition = 13
263:             .Top = 5
264:             .Left = 305
265:             .Width = 75
266:             .Height = 75
267:             .BackColor   = RGB(255, 255, 255)
268:             .ForeColor   = RGB(90, 90, 90)
269:             .FontName    = "Comic Sans MS"
270:             .FontSize    = 8
271:             .FontBold    = .T.
272:             .FontItalic  = .T.
273:             .Themes      = .F.
274:             .SpecialEffect = 0
275:             .WordWrap    = .T.
276:             .AutoSize    = .F.
277:             .MousePointer = 15
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
280: 
281:         *-- Container Encerrar (padrao canonico)
282:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
283:         WITH loc_oPagina.cnt_4c_Saida
284:             .Top         = 29
285:             .Left        = 917
286:             .Width       = 90
287:             .Height      = 85
288:             .BackStyle   = 0
289:             .BorderWidth = 0
290:             .Visible     = .T.
291:         ENDWITH
292: 
293:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
294:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
295:             .Caption         = "Encerrar"
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .PicturePosition = 13
298:             .Top = 5
299:             .Left = 5
300:             .Width = 75
301:             .Height = 75
302:             .BackColor   = RGB(255, 255, 255)
303:             .ForeColor   = RGB(90, 90, 90)
304:             .FontName    = "Comic Sans MS"
305:             .FontSize    = 8
306:             .FontBold    = .T.
307:             .FontItalic  = .T.
308:             .Themes      = .F.
309:             .SpecialEffect = 0
310:             .WordWrap    = .T.
311:             .AutoSize    = .F.
312:             .MousePointer = 15
313:         ENDWITH
314:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
315: 
316:         *-- Grid de listagem (Grade no legado): Top=88+29, Left=12, Width=940
317:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
318:         loc_oGrid = loc_oPagina.grd_4c_Lista
319:         loc_oGrid.Top              = 117
320:         loc_oGrid.Left             = 12
321:         loc_oGrid.Width            = 940
322:         loc_oGrid.Height           = 470
323:         loc_oGrid.ColumnCount      = 9
324:         loc_oGrid.FontName         = "Verdana"
325:         loc_oGrid.FontSize         = 8

*-- Linhas 352 a 389:
352:         *-- Cabecalho escuro (igual Page1)
353:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
354:         WITH loc_oPagina.cnt_4c_Cabecalho
355:             .Top         = 31
356:             .Left        = 0
357:             .Width       = THIS.Width
358:             .Height      = 80
359:             .BackColor   = RGB(100, 100, 100)
360:             .BorderWidth = 0
361:             .Visible     = .T.
362:         ENDWITH
363: 
364:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
365:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
366:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
367:             .Top       = 15
368:             .Left      = 10
369:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
370:             .Height    = 40
371:             .FontName  = "Tahoma"
372:             .FontSize  = 16
373:             .FontBold  = .T.
374:             .ForeColor = RGB(0, 0, 0)
375:             .BackStyle = 0
376:             .AutoSize  = .F.
377:             .Visible   = .T.
378:         ENDWITH
379: 
380:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
381:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
382:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
383:             .Top       = 18
384:             .Left      = 10
385:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
386:             .Height    = 46
387:             .FontName  = "Tahoma"
388:             .FontSize  = 16
389:             .FontBold  = .T.

*-- Linhas 396 a 469:
396:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
397:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
398:         WITH loc_oPagina.cnt_4c_BotoesAcao
399:             .Top         = 33   && 4 + 29
400:             .Left        = 842
401:             .Width       = 160
402:             .Height      = 85
403:             .BackStyle   = 0
404:             .Visible     = .T.
405:         ENDWITH
406: 
407:         *-- Confirmar (Salvar)
408:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
409:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
410:             .Caption         = "Confirmar"
411:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
412:             .PicturePosition = 13
413:             .Top             = 5
414:             .Left            = 5
415:             .Width           = 75
416:             .Height          = 75
417:             .BackColor       = RGB(255, 255, 255)
418:             .ForeColor       = RGB(90, 90, 90)
419:             .FontName        = "Comic Sans MS"
420:             .FontSize        = 8
421:             .FontBold        = .T.
422:             .FontItalic      = .T.
423:             .Themes          = .F.
424:             .SpecialEffect   = 0
425:             .WordWrap        = .T.
426:             .AutoSize        = .F.
427:             .MousePointer    = 15
428:         ENDWITH
429:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
430: 
431:         *-- Cancelar
432:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
433:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
434:             .Caption         = "Encerrar"
435:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
436:             .PicturePosition = 13
437:             .Top             = 5
438:             .Left            = 80
439:             .Width           = 75
440:             .Height          = 75
441:             .BackColor       = RGB(255, 255, 255)
442:             .ForeColor       = RGB(90, 90, 90)
443:             .FontName        = "Comic Sans MS"
444:             .FontSize        = 8
445:             .FontBold        = .T.
446:             .FontItalic      = .T.
447:             .Themes          = .F.
448:             .SpecialEffect   = 0
449:             .WordWrap        = .T.
450:             .AutoSize        = .F.
451:             .MousePointer    = 15
452:         ENDWITH
453:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
454: 
455:         *--------------------------------------------------------------------------
456:         *-- CAMPOS PARTE 1: Empresa, Tabela de Desconto, Cargo
457:         *--------------------------------------------------------------------------
458: 
459:         *-- [Empresa] Label
460:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
461:         WITH loc_oPagina.lbl_4c_Label3
462:             .Caption   = "Empresa :"
463:             .Top       = 206   && 177 + 29
464:             .Left      = 145
465:             .Width     = 60
466:             .Height    = 17
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .FontBold  = .F.

*-- Linhas 478 a 487:
478:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
479:         WITH loc_oPagina.txt_4c_Empresa
480:             .Value       = ""
481:             .Top         = 203   && 174 + 29
482:             .Left        = 207
483:             .Width       = 31
484:             .Height      = 20
485:             .FontName    = "Tahoma"
486:             .FontSize    = 8
487:             .MaxLength   = 3

*-- Linhas 495 a 504:
495:         loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
496:         WITH loc_oPagina.txt_4c_DEmpresa
497:             .Value       = ""
498:             .Top         = 203   && 174 + 29
499:             .Left        = 240
500:             .Width       = 290
501:             .Height      = 20
502:             .FontName    = "Tahoma"
503:             .FontSize    = 8
504:             .MaxLength   = 60

*-- Linhas 510 a 522:
510:         ENDWITH
511: 
512:         *-- [Tabela de Desconto] Label
513:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
514:         WITH loc_oPagina.lbl_4c_Label5
515:             .Caption   = "Tabela de Desconto :"
516:             .Top       = 231   && 202 + 29
517:             .Left      = 91
518:             .Width     = 115
519:             .Height    = 17
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .FontBold  = .F.

*-- Linhas 531 a 540:
531:         loc_oPagina.AddObject("txt_4c_TabDes", "TextBox")
532:         WITH loc_oPagina.txt_4c_TabDes
533:             .Value       = ""
534:             .Top         = 228   && 199 + 29
535:             .Left        = 207
536:             .Width       = 80
537:             .Height      = 20
538:             .FontName    = "Tahoma"
539:             .FontSize    = 8
540:             .MaxLength   = 10

*-- Linhas 548 a 557:
548:         loc_oPagina.AddObject("txt_4c_DTabDes", "TextBox")
549:         WITH loc_oPagina.txt_4c_DTabDes
550:             .Value       = ""
551:             .Top         = 228   && 199 + 29
552:             .Left        = 289
553:             .Width       = 220
554:             .Height      = 20
555:             .FontName    = "Tahoma"
556:             .FontSize    = 8
557:             .MaxLength   = 40

*-- Linhas 563 a 575:
563:         ENDWITH
564: 
565:         *-- [Cargo] Label
566:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
567:         WITH loc_oPagina.lbl_4c_Label4
568:             .Caption   = "Cargo :"
569:             .Top       = 256   && 227 + 29
570:             .Left      = 157
571:             .Width     = 49
572:             .Height    = 17
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .FontBold  = .F.

*-- Linhas 584 a 593:
584:         loc_oPagina.AddObject("txt_4c_Cargo", "TextBox")
585:         WITH loc_oPagina.txt_4c_Cargo
586:             .Value       = ""
587:             .Top         = 253   && 224 + 29
588:             .Left        = 207
589:             .Width       = 80
590:             .Height      = 20
591:             .FontName    = "Tahoma"
592:             .FontSize    = 8
593:             .MaxLength   = 10

*-- Linhas 601 a 610:
601:         loc_oPagina.AddObject("txt_4c_DCargo", "TextBox")
602:         WITH loc_oPagina.txt_4c_DCargo
603:             .Value       = ""
604:             .Top         = 253   && 224 + 29
605:             .Left        = 289
606:             .Width       = 150
607:             .Height      = 20
608:             .FontName    = "Tahoma"
609:             .FontSize    = 8
610:             .MaxLength   = 40

*-- Linhas 616 a 628:
616:         ENDWITH
617: 
618:         *-- [Condição] Label
619:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
620:         WITH loc_oPagina.lbl_4c_Label7
621:             .Caption   = "Condi" + CHR(231) + CHR(227) + "o :"
622:             .Top       = 281   && 252 + 29
623:             .Left      = 142
624:             .Width     = 64
625:             .Height    = 17
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .FontBold  = .F.

*-- Linhas 637 a 663:
637:         loc_oPagina.AddObject("txt_4c_FPags", "TextBox")
638:         WITH loc_oPagina.txt_4c_FPags
639:             .Value       = ""
640:             .Top         = 278   && 249 + 29
641:             .Left        = 207
642:             .Width       = 94
643:             .Height      = 20
644:             .FontName    = "Tahoma"
645:             .FontSize    = 8
646:             .MaxLength   = 12
647:             .BackColor   = RGB(255, 255, 255)
648:             .ForeColor   = RGB(0, 0, 0)
649:             .Alignment   = 0
650:             .Visible     = .T.
651:         ENDWITH
652: 
653:         *-- [Comissão] Label
654:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
655:         WITH loc_oPagina.lbl_4c_Label6
656:             .Caption   = "Comiss" + CHR(227) + "o :"
657:             .Top       = 318   && 289 + 29
658:             .Left      = 141
659:             .Width     = 65
660:             .Height    = 17
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .FontBold  = .F.

*-- Linhas 669 a 681:
669:         ENDWITH
670: 
671:         *-- [Período] Label
672:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
673:         WITH loc_oPagina.lbl_4c_Label1
674:             .Caption   = "Per" + CHR(237) + "odo :"
675:             .Top       = 318   && 289 + 29
676:             .Left      = 285
677:             .Width     = 55
678:             .Height    = 17
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .FontBold  = .F.

*-- Linhas 687 a 699:
687:         ENDWITH
688: 
689:         *-- [à] Separador periodo
690:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
691:         WITH loc_oPagina.lbl_4c_Label2
692:             .Caption   = CHR(224)
693:             .Top       = 318   && 289 + 29
694:             .Left      = 430
695:             .Width     = 15
696:             .Height    = 17
697:             .FontName  = "Tahoma"
698:             .FontSize  = 8
699:             .FontBold  = .F.

*-- Linhas 708 a 717:
708:         loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
709:         WITH loc_oPagina.txt_4c_Comiss
710:             .Value       = 0
711:             .Top         = 315   && 286 + 29
712:             .Left        = 207
713:             .Width       = 45
714:             .Height      = 20
715:             .FontName    = "Tahoma"
716:             .FontSize    = 8
717:             .InputMask   = "99.99"

*-- Linhas 725 a 734:
725:         loc_oPagina.AddObject("txt_4c_DtIni", "TextBox")
726:         WITH loc_oPagina.txt_4c_DtIni
727:             .Value       = {}
728:             .Top         = 315   && 286 + 29
729:             .Left        = 340
730:             .Width       = 80
731:             .Height      = 20
732:             .FontName    = "Tahoma"
733:             .FontSize    = 8
734:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 741 a 750:
741:         loc_oPagina.AddObject("txt_4c_DtFin", "TextBox")
742:         WITH loc_oPagina.txt_4c_DtFin
743:             .Value       = {}
744:             .Top         = 315   && 286 + 29
745:             .Left        = 450
746:             .Width       = 80
747:             .Height      = 20
748:             .FontName    = "Tahoma"
749:             .FontSize    = 8
750:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 798 a 814:
798:                     loc_oGrid.Column8.Width      = 80
799:                     loc_oGrid.Column9.Width      = 55
800:                     loc_oGrid.Column9.Alignment  = 2
801:                     loc_oGrid.Column1.Header1.Caption = "Emp"
802:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
803:                     loc_oGrid.Column3.Header1.Caption = "Tb.Desconto"
804:                     loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Tabela"
805:                     loc_oGrid.Column5.Header1.Caption = "Cargo"
806:                     loc_oGrid.Column6.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
807:                     loc_oGrid.Column7.Header1.Caption = "Data Inicial"
808:                     loc_oGrid.Column8.Header1.Caption = "Data Final"
809:                     loc_oGrid.Column9.Header1.Caption = "Comiss.%"
810:                     THIS.FormatarGridLista(loc_oGrid)
811:                     loc_oGrid.Refresh()
812:                     loc_lResultado = .T.
813:                 ENDIF
814:             ENDIF

*-- Linhas 1068 a 1076:
1068:         loc_oPg2.txt_4c_DCargo.ReadOnly   = .T.
1069: 
1070:         *-- Botao Confirmar: habilitado somente em INCLUIR/ALTERAR
1071:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     PROTECTED PROCEDURE BOParaForm()
1076:     *==========================================================================

*-- Linhas 1323 a 1336:
1323:         TRY
1324:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1325:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
1326:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
1327:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1328:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
1329:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
1330:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
1331:             loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEmLista
1332:         CATCH TO loc_oErro
1333:             MsgErro(loc_oErro.Message + CHR(13) + ;
1334:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AjustarBotoesPorModo")
1335:         ENDTRY
1336:     ENDPROC


### BO (C:\4c\projeto\app\classes\ICMBO.prg):
*==============================================================================
* ICMBO.prg - Business Object: Cadastro de Indices de Comissao
* Tabela: SigCdCmi
* PK: cidchaves (char 20, gerado via fUniqueIds)
*==============================================================================

DEFINE CLASS ICMBO AS BusinessBase

    *-- Campos da tabela SigCdCmi
    this_cEmps      = ""    && char(3)  - Empresa
    this_cCargos    = ""    && char(10) - Cargo
    this_cFPags     = ""    && char(12) - Condicao de Pagamento
    this_cTabDes    = ""    && char(10) - Tabela de Desconto
    this_dDtInis    = {}    && datetime - Data Inicial do Periodo
    this_dDtFins    = {}    && datetime - Data Final do Periodo
    this_nComiss    = 0     && numeric(4,2) - Percentual de Comissao
    this_cIdChaves  = ""    && char(20) - Chave unica (PK, gerado por fUniqueIds)
    this_tDtAlts    = {}    && datetime - Data/hora ultima alteracao

    *-- Campos descricao (lookup, nao armazenados no banco)
    this_cDEmpresa  = ""    && Razao social da empresa (SigCdEmp.Razas)
    this_cDCargo    = ""    && Descricao do cargo (SigCdCrg.DCargs)
    this_cDTabDes   = ""    && Descricao da tabela de desconto (SigOpTdz.Descrs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCmi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ICMBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       loc_cWhere + ;
                       " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "ndices de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "ICMBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = ALLTRIM(TratarNulo(cidchaves,  "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps,       "C"))
            THIS.this_cTabDes    = ALLTRIM(TratarNulo(tabdes,     "C"))
            THIS.this_cCargos    = ALLTRIM(TratarNulo(cargos,     "C"))
            THIS.this_cFPags     = ALLTRIM(TratarNulo(fpags,      "C"))
            THIS.this_dDtInis    = TratarNulo(dtinis, "D")
            THIS.this_dDtFins    = TratarNulo(dtfins, "D")
            THIS.this_nComiss    = TratarNulo(comiss, "N")
            THIS.this_tDtAlts    = TratarNulo(dtalts, "D")
            IF TYPE(par_cAliasCursor + ".razas") != "U"
                THIS.this_cDEmpresa = ALLTRIM(TratarNulo(razas,         "C"))
                THIS.this_cDCargo   = ALLTRIM(TratarNulo(dcargs,        "C"))
                THIS.this_cDTabDes  = ALLTRIM(TratarNulo(descrs_tabdes, "C"))
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cId
        LOCAL loc_nResultDup, loc_cSQLDup, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade (Emps+Cargos+FPags+TabDes+DtInis+DtFins)
            loc_cSQLDup = "SELECT cidchaves FROM SigCdCmi" + ;
                          " WHERE emps = "   + EscaparSQL(THIS.this_cEmps)   + ;
                          " AND cargos = "   + EscaparSQL(THIS.this_cCargos) + ;
                          " AND fpags = "    + EscaparSQL(THIS.this_cFPags)  + ;
                          " AND tabdes = "   + EscaparSQL(THIS.this_cTabDes) + ;
                          " AND dtinis = "   + FormatarDataSQL(THIS.this_dDtInis) + ;
                          " AND dtfins = "   + FormatarDataSQL(THIS.this_dDtFins)

            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            loc_nResultDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupVerif")
            IF loc_nResultDup > 0 AND RECCOUNT("cursor_4c_DupVerif") > 0
                loc_lDuplicado = .T.
                MsgAviso("Dados j" + CHR(225) + " cadastrados para esta combina" + CHR(231) + CHR(227) + "o!", "")
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF

            IF !loc_lDuplicado
                *-- Gerar chave unica
                loc_cId = fUniqueIds()
                THIS.this_cIdChaves = loc_cId

                loc_cSQL = "INSERT INTO SigCdCmi (cidchaves, emps, tabdes, cargos, fpags," + ;
                           " dtinis, dtfins, comiss, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + ;
                           EscaparSQL(THIS.this_cEmps)   + ", " + ;
                           EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                           EscaparSQL(THIS.this_cCargos)  + ", " + ;
                           EscaparSQL(THIS.this_cFPags)   + ", " + ;
                           FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                           "GETDATE())"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Ins")
                    TABLEREVERT(.T., "cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    MsgErro("Erro ao inserir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCmi SET" + ;
                       " emps = "   + EscaparSQL(THIS.this_cEmps)   + ", " + ;
                       " tabdes = " + EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                       " cargos = " + EscaparSQL(THIS.this_cCargos)  + ", " + ;
                       " fpags = "  + EscaparSQL(THIS.this_cFPags)   + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                       " dtfins = " + FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                       " comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       " dtalts = GETDATE()" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult > 0
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                MsgErro("Erro ao atualizar " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult > 0
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                MsgErro("Erro ao excluir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

