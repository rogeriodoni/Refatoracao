# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 205: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 317: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 430: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOcb.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1531 linhas total):

*-- Linhas 48 a 57:
48:                     "FormOcb.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 80 a 99:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()

*-- Linhas 113 a 150:
113:         *-- Container Cabecalho (cntSombra no legado: Top=2+29=31)
114:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
115:         WITH loc_oPagina.cnt_4c_Cabecalho
116:             .Top         = 31
117:             .Left        = 0
118:             .Width       = THIS.Width
119:             .Height      = 80
120:             .BackColor   = RGB(100, 100, 100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
127:             .Caption   = THIS.Caption
128:             .Top       = 15
129:             .Left      = 10
130:             .Width     = 769
131:             .Height    = 40
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .AutoSize  = .F.
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption   = THIS.Caption
144:             .Top       = 18
145:             .Left      = 10
146:             .Width     = 769
147:             .Height    = 46
148:             .FontName  = "Tahoma"
149:             .FontSize  = 16
150:             .FontBold  = .T.

*-- Linhas 158 a 343:
158:         *-- Canonico: Left=542, Width=390
159:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
160:         WITH loc_oPagina.cnt_4c_Botoes
161:             .Top         = 28
162:             .Left        = 542
163:             .Width       = 390
164:             .Height      = 85
165:             .BackStyle   = 0
166:             .BorderWidth = 0
167:             .Visible     = .T.
168:         ENDWITH
169: 
170:         *-- Botao Incluir
171:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
172:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
173:             .Caption         = "Incluir"
174:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:             .PicturePosition = 13
176:             .Top             = 5
177:             .Left            = 5
178:             .Width           = 75
179:             .Height          = 75
180:             .FontName        = "Comic Sans MS"
181:             .FontSize        = 8
182:             .FontBold        = .T.
183:             .FontItalic      = .T.
184:             .ForeColor       = RGB(90, 90, 90)
185:             .BackColor       = RGB(255, 255, 255)
186:             .Themes          = .F.
187:             .SpecialEffect   = 0
188:             .MousePointer    = 15
189:             .WordWrap        = .T.
190:             .AutoSize        = .F.
191:             .Visible         = .T.
192:         ENDWITH
193:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
194: 
195:         *-- Botao Visualizar
196:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
197:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
198:             .Caption         = "Visualizar"
199:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:             .PicturePosition = 13
201:             .Top             = 5
202:             .Left            = 80
203:             .Width           = 75
204:             .Height          = 75
205:             .FontName        = "Comic Sans MS"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .ForeColor       = RGB(90, 90, 90)
210:             .BackColor       = RGB(255, 255, 255)
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .MousePointer    = 15
214:             .WordWrap        = .T.
215:             .AutoSize        = .F.
216:             .Visible         = .T.
217:         ENDWITH
218:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
219: 
220:         *-- Botao Alterar
221:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:         *-- Botao Excluir
246:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
247:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
248:             .Caption         = "Excluir"
249:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
250:             .PicturePosition = 13
251:             .Top             = 5
252:             .Left            = 230
253:             .Width           = 75
254:             .Height          = 75
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .ForeColor       = RGB(90, 90, 90)
260:             .BackColor       = RGB(255, 255, 255)
261:             .Themes          = .F.
262:             .SpecialEffect   = 0
263:             .MousePointer    = 15
264:             .WordWrap        = .T.
265:             .AutoSize        = .F.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         *-- Botao Buscar
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Comic Sans MS"
281:             .FontSize        = 8
282:             .FontBold        = .T.
283:             .FontItalic      = .T.
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Saida/Encerrar (canonico: Left=917, Top=28, Width=90, Height=85)
296:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
297:         WITH loc_oPagina.cnt_4c_Saida
298:             .Top         = 28
299:             .Left        = 917
300:             .Width       = 90
301:             .Height      = 85
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         *-- Botao Encerrar
308:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 5
315:             .Width           = 75
316:             .Height          = 75
317:             .FontName        = "Comic Sans MS"
318:             .FontSize        = 8
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .ForeColor       = RGB(90, 90, 90)
322:             .BackColor       = RGB(255, 255, 255)
323:             .Themes          = .F.
324:             .SpecialEffect   = 0
325:             .MousePointer    = 15
326:             .WordWrap        = .T.
327:             .AutoSize        = .F.
328:             .Visible         = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
331: 
332:         *-- Grid de lista (framework: Top=88+29=117, Left=26, Width=890)
333:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
334:         loc_oPagina.grd_4c_Lista.ColumnCount = 9
335: 
336:         WITH loc_oPagina.grd_4c_Lista
337:             .Top                = 117
338:             .Left               = 26
339:             .Width              = 890
340:             .Height             = 455
341:             .FontName           = "Verdana"
342:             .FontSize           = 8
343:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 369 a 475:
369: 
370:     *===========================================================================
371:     * ConfigurarPaginaDados - Configura Page2: botoes + primeira metade dos campos
372:     * Tops = valores originais (layout.json) + 29 (compensacao PageFrame.Top=-29)
373:     *===========================================================================
374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
375:         LOCAL loc_oPagina
376:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
377: 
378:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
379:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
380: 
381:         *-- Container BotoesAcao - Salvar/Cancelar (Grupo_Salva no legado)
382:         *-- Canonico: Top=33 (4+29), Left=842, Width=160, Height=85
383:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
384:         WITH loc_oPagina.cnt_4c_BotoesAcao
385:             .Top         = 33
386:             .Left        = 842
387:             .Width       = 160
388:             .Height      = 85
389:             .BackStyle = 1
390:             .BackColor = RGB(255, 255, 255)
391:             .BorderWidth = 0
392:             .Visible     = .T.
393:         ENDWITH
394: 
395:         *-- Botao Salvar (Confirmar)
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .FontName        = "Comic Sans MS"
406:             .FontSize        = 8
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .ForeColor       = RGB(90, 90, 90)
410:             .BackColor       = RGB(255, 255, 255)
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.
417:         ENDWITH
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
419: 
420:         *-- Botao Cancelar
421:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
422:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
423:             .Caption         = "Encerrar"
424:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
425:             .PicturePosition = 13
426:             .Top             = 5
427:             .Left            = 80
428:             .Width           = 75
429:             .Height          = 75
430:             .FontName        = "Comic Sans MS"
431:             .FontSize        = 8
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .ForeColor       = RGB(90, 90, 90)
435:             .BackColor       = RGB(255, 255, 255)
436:             .Themes          = .F.
437:             .SpecialEffect   = 0
438:             .MousePointer    = 15
439:             .WordWrap        = .T.
440:             .AutoSize        = .F.
441:             .Visible         = .T.
442:         ENDWITH
443:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- =====================================================================
446:         *-- CAMPOS - Primeira Metade (50%)
447:         *-- =====================================================================
448: 
449:         *-- Grupo 1: GetTipos (tipos char 1: O/J) - original Top=187 -> 187+29=216
450:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
451:         WITH loc_oPagina.lbl_4c_Label3
452:             .Caption   = "Tipos (O/J) :"
453:             .Top       = 219
454:             .Left      = 222
455:             .Width     = 62
456:             .Height    = 17
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .FontBold  = .F.
460:             .ForeColor = RGB(90, 90, 90)
461:             .BackStyle = 0
462:             .AutoSize  = .F.
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
467:         WITH loc_oPagina.lbl_4c_Label4
468:             .Caption   = "< O >corr" + CHR(234) + "ncia  < J >ustificativa"
469:             .Top       = 219
470:             .Left      = 316
471:             .Width     = 161
472:             .Height    = 17
473:             .FontName  = "Tahoma"
474:             .FontSize  = 8
475:             .FontBold  = .F.

*-- Linhas 482 a 506:
482:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
483:         WITH loc_oPagina.txt_4c_Tipos
484:             .Value     = ""
485:             .Top       = 216
486:             .Left      = 288
487:             .Width     = 17
488:             .Height    = 23
489:             .MaxLength = 1
490:             .FontName  = "Tahoma"
491:             .FontSize  = 8
492:             .Visible   = .T.
493:         ENDWITH
494:         BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
495: 
496:         *-- Grupo 2: getCodigos (codigos char 10) - original Top=213 -> 213+29=242
497:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
498:         WITH loc_oPagina.lbl_4c_Label1
499:             .Caption   = "C" + CHR(243) + "digo :"
500:             .Top       = 245
501:             .Left      = 242
502:             .Width     = 42
503:             .Height    = 17
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .FontBold  = .F.

*-- Linhas 513 a 536:
513:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
514:         WITH loc_oPagina.txt_4c_Codigos
515:             .Value     = ""
516:             .Top       = 242
517:             .Left      = 288
518:             .Width     = 80
519:             .Height    = 23
520:             .MaxLength = 10
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .Visible   = .T.
524:         ENDWITH
525: 
526:         *-- Grupo 3: getDescrs (descrs char 40) - original Top=239 -> 239+29=268
527:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
528:         WITH loc_oPagina.lbl_4c_Label2
529:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
530:             .Top       = 271
531:             .Left      = 229
532:             .Width     = 55
533:             .Height    = 17
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .FontBold  = .F.

*-- Linhas 543 a 582:
543:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
544:         WITH loc_oPagina.txt_4c_Descrs
545:             .Value     = ""
546:             .Top       = 268
547:             .Left      = 288
548:             .Width     = 290
549:             .Height    = 23
550:             .MaxLength = 40
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .Visible   = .T.
554:         ENDWITH
555: 
556:         *-- Grupo 4: Get_Apura (apuras char 1: S/N) - original Top=265 -> 265+29=294
557:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
558:         WITH loc_oPagina.lbl_4c_Label15
559:             .Caption   = "Apura" + CHR(231) + CHR(227) + "o :"
560:             .Top       = 297
561:             .Left      = 229
562:             .Width     = 55
563:             .Height    = 17
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .FontBold  = .F.
567:             .ForeColor = RGB(90, 90, 90)
568:             .BackStyle = 0
569:             .AutoSize  = .F.
570:             .Visible   = .T.
571:         ENDWITH
572: 
573:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
574:         WITH loc_oPagina.lbl_4c_Label14
575:             .Caption   = "<S>im  <N>" + CHR(227) + "o"
576:             .Top       = 298
577:             .Left      = 316
578:             .Width     = 75
579:             .Height    = 17
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .FontBold  = .F.

*-- Linhas 589 a 598:
589:         loc_oPagina.AddObject("txt_4c_Apura", "TextBox")
590:         WITH loc_oPagina.txt_4c_Apura
591:             .Value     = ""
592:             .Top       = 294
593:             .Left      = 288
594:             .Width     = 17
595:             .Height    = 23
596:             .MaxLength = 1
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8

*-- Linhas 605 a 633:
605:         *-- =====================================================================
606: 
607:         *-- Grupo 5: Get_Lanca (lancas char 1: S/N) - original Top=291 -> 291+29=320
608:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
609:         WITH loc_oPagina.lbl_4c_Label5
610:             .Caption   = "Lan" + CHR(231) + "a C/C :"
611:             .Top       = 323
612:             .Left      = 226
613:             .Width     = 58
614:             .Height    = 17
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8
617:             .FontBold  = .F.
618:             .ForeColor = RGB(90, 90, 90)
619:             .BackStyle = 0
620:             .AutoSize  = .F.
621:             .Visible   = .T.
622:         ENDWITH
623: 
624:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
625:         WITH loc_oPagina.lbl_4c_Label8
626:             .Caption   = "<S>im  <N>" + CHR(227) + "o"
627:             .Top       = 324
628:             .Left      = 316
629:             .Width     = 75
630:             .Height    = 17
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .FontBold  = .F.

*-- Linhas 640 a 681:
640:         loc_oPagina.AddObject("txt_4c_Lanca", "TextBox")
641:         WITH loc_oPagina.txt_4c_Lanca
642:             .Value     = ""
643:             .Top       = 320
644:             .Left      = 288
645:             .Width     = 17
646:             .Height    = 23
647:             .MaxLength = 1
648:             .FontName  = "Tahoma"
649:             .FontSize  = 8
650:             .Visible   = .T.
651:         ENDWITH
652:         BINDEVENT(loc_oPagina.txt_4c_Lanca, "KeyPress", THIS, "ValidarLanca")
653: 
654:         *-- Grupo 6: GetOper (opers char 2: DB/CR/DF/NL) - original Top=317 -> 317+29=346
655:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
656:         WITH loc_oPagina.lbl_4c_Label6
657:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
658:             .Top       = 349
659:             .Left      = 228
660:             .Width     = 56
661:             .Height    = 17
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .FontBold  = .F.
665:             .ForeColor = RGB(90, 90, 90)
666:             .BackStyle = 0
667:             .AutoSize  = .F.
668:             .Visible   = .T.
669:         ENDWITH
670: 
671:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
672:         WITH loc_oPagina.lbl_4c_Label7
673:             .Caption   = "<DB>D" + CHR(233) + "bito <CR>cr" + CHR(233) + ;
674:                          "dito <DF>Diferen" + CHR(231) + "a <NL>Nulo"
675:             .Top       = 349
676:             .Left      = 316
677:             .Width     = 258
678:             .Height    = 17
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .FontBold  = .F.

*-- Linhas 688 a 712:
688:         loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
689:         WITH loc_oPagina.txt_4c_Oper
690:             .Value     = ""
691:             .Top       = 346
692:             .Left      = 288
693:             .Width     = 27
694:             .Height    = 23
695:             .MaxLength = 2
696:             .FontName  = "Tahoma"
697:             .FontSize  = 8
698:             .Visible   = .T.
699:         ENDWITH
700:         BINDEVENT(loc_oPagina.txt_4c_Oper, "KeyPress", THIS, "ValidarOper")
701: 
702:         *-- Grupo 7: GetGrContabil (grupos char 10) - original Top=343 -> 343+29=372 - LOOKUP SigCdGcr
703:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
704:         WITH loc_oPagina.lbl_4c_Label9
705:             .Caption   = "Gr.Cont" + CHR(225) + "bil :"
706:             .Top       = 376
707:             .Left      = 221
708:             .Width     = 63
709:             .Height    = 17
710:             .FontName  = "Tahoma"
711:             .FontSize  = 8
712:             .FontBold  = .F.

*-- Linhas 719 a 761:
719:         loc_oPagina.AddObject("txt_4c_GrContabil", "TextBox")
720:         WITH loc_oPagina.txt_4c_GrContabil
721:             .Value     = ""
722:             .Top       = 372
723:             .Left      = 288
724:             .Width     = 80
725:             .Height    = 23
726:             .MaxLength = 10
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .Visible   = .T.
730:         ENDWITH
731:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress", THIS, "GrContabilLookupKeyPress")
732:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "DblClick", THIS, "GrContabilLookupDblClick")
733:         BINDEVENT(loc_oPagina.txt_4c_GrContabil, "KeyPress",    THIS, "ValidarGrContabil")
734: 
735:         *-- Grupo 8: GetAutos (autos char 1: S/N) - original Top=369 -> 369+29=398
736:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
737:         WITH loc_oPagina.lbl_4c_Label10
738:             .Caption   = "Autom" + CHR(225) + "tico :"
739:             .Top       = 401
740:             .Left      = 221
741:             .Width     = 63
742:             .Height    = 17
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .FontBold  = .F.
746:             .ForeColor = RGB(90, 90, 90)
747:             .BackStyle = 0
748:             .AutoSize  = .F.
749:             .Visible   = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
753:         WITH loc_oPagina.lbl_4c_Label11
754:             .Caption   = "<S>im  <N>" + CHR(227) + "o"
755:             .Top       = 402
756:             .Left      = 316
757:             .Width     = 75
758:             .Height    = 17
759:             .FontName  = "Tahoma"
760:             .FontSize  = 8
761:             .FontBold  = .F.

*-- Linhas 768 a 810:
768:         loc_oPagina.AddObject("txt_4c_Autos", "TextBox")
769:         WITH loc_oPagina.txt_4c_Autos
770:             .Value     = ""
771:             .Top       = 398
772:             .Left      = 288
773:             .Width     = 17
774:             .Height    = 23
775:             .MaxLength = 1
776:             .FontName  = "Tahoma"
777:             .FontSize  = 8
778:             .Visible   = .T.
779:         ENDWITH
780:         BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "ValidarAutos")
781:         BINDEVENT(loc_oPagina.txt_4c_Autos, "KeyPress", THIS, "AutosLostFocus")
782: 
783:         *-- Grupo 9: GetOperac (operacaos char 1: E/S) - original Top=395 -> 395+29=424
784:         *-- When: habilitado apenas quando Autos = "S"
785:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
786:         WITH loc_oPagina.lbl_4c_Label12
787:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
788:             .Top       = 427
789:             .Left      = 228
790:             .Width     = 56
791:             .Height    = 17
792:             .FontName  = "Tahoma"
793:             .FontSize  = 8
794:             .FontBold  = .F.
795:             .ForeColor = RGB(90, 90, 90)
796:             .BackStyle = 0
797:             .AutoSize  = .F.
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
802:         WITH loc_oPagina.lbl_4c_Label13
803:             .Caption   = "<E>ntrada  <S>a" + CHR(237) + "da"
804:             .Top       = 428
805:             .Left      = 316
806:             .Width     = 104
807:             .Height    = 17
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .FontBold  = .F.

*-- Linhas 817 a 826:
817:         loc_oPagina.AddObject("txt_4c_Operac", "TextBox")
818:         WITH loc_oPagina.txt_4c_Operac
819:             .Value     = ""
820:             .Top       = 424
821:             .Left      = 288
822:             .Width     = 17
823:             .Height    = 23
824:             .MaxLength = 1
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8

*-- Linhas 859 a 875:
859:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.operacaos"
860:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.grupos"
861: 
862:                     loc_oGrid.Column1.Header1.Caption = "Tipo"
863:                     loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
864:                     loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
865:                     loc_oGrid.Column4.Header1.Caption = "Apura" + CHR(231) + CHR(227) + "o"
866:                     loc_oGrid.Column5.Header1.Caption = "Lan" + CHR(231) + "a C/C"
867:                     loc_oGrid.Column6.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
868:                     loc_oGrid.Column7.Header1.Caption = "Autom" + CHR(225) + "tico"
869:                     loc_oGrid.Column8.Header1.Caption = "Op."
870:                     loc_oGrid.Column9.Header1.Caption = "Gr.Cont" + CHR(225) + "bil"
871: 
872:                     THIS.FormatarGridLista(loc_oGrid)
873:                     loc_lSucesso = .T.
874:                 ENDIF
875:             ENDIF

*-- Linhas 1246 a 1256:
1246:         loc_oPagina.txt_4c_Operac.ReadOnly = loc_lReadOnly
1247: 
1248:         *-- Salvar desabilitado em VISUALIZAR
1249:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled   = ;
1250:             par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR"
1251:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1252:     ENDPROC
1253: 
1254:     *===========================================================================
1255:     * ValidarTipos - Handler Valid do txt_4c_Tipos (O=Ocorrencia J=Justificativa)
1256:     *===========================================================================

*-- Linhas 1509 a 1521:
1509:                            !EOF("cursor_4c_Dados")
1510: 
1511:         WITH loc_oPagina.cnt_4c_Botoes
1512:             .cmd_4c_Incluir.Enabled    = .T.
1513:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1514:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1515:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1516:             .cmd_4c_Buscar.Enabled     = loc_lTemRegistro
1517:             .Visible     = .T.
1518:         ENDWITH
1519:     ENDPROC
1520: 
1521:     *===========================================================================


### BO (C:\4c\projeto\app\classes\OcbBO.prg):
*==============================================================================
* OcbBO.prg - Business Object para Ocorrencias do Balanco
* Tabela: SigBaOco
*==============================================================================

DEFINE CLASS OcbBO AS BusinessBase

    *-- Propriedades da entidade (mapeadas de SigBaOco)
    this_cCodigos   = ""    && codigos   char(10) - PK
    this_cDescrs    = ""    && descrs    char(40)
    this_cTipos     = ""    && tipos     char(1) - "O" ou "J"
    this_cApuras    = ""    && apuras    char(1) - "S" ou "N"
    this_cLancas    = ""    && lancas    char(1) - "S" ou "N"
    this_cOpers     = ""    && opers     char(2) - "DB","CR","DF","NL"
    this_cAutos     = ""    && autos     char(1) - "S" ou "N"
    this_cOperacaos = ""    && operacaos char(1) - "E" ou "S"
    this_cGrupos    = ""    && grupos    char(10) - FK SigCdGcr

    *==========================================================================
    * Init - Inicializa o Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigBaOco"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * Buscar - SELECT com filtro opcional (cursor_4c_Dados)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pelo PK
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, apuras, lancas," + ;
                       " opers, autos, operacaos, grupos" + ;
                       " FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_cTipos      = TratarNulo(tipos,      "C")
            THIS.this_cApuras     = TratarNulo(apuras,     "C")
            THIS.this_cLancas     = TratarNulo(lancas,     "C")
            THIS.this_cOpers      = TratarNulo(opers,      "C")
            THIS.this_cAutos      = TratarNulo(autos,      "C")
            THIS.this_cOperacaos  = TratarNulo(operacaos,  "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT INTO SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigBaOco" + ;
                       " (codigos, descrs, tipos, apuras, lancas," + ;
                       "  opers, autos, operacaos, grupos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)    + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE SigBaOco (PROTECTED - chamado por Salvar)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigBaOco SET" + ;
                       " descrs    = " + EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       " tipos     = " + EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       " apuras    = " + EscaparSQL(THIS.this_cApuras)    + ", " + ;
                       " lancas    = " + EscaparSQL(THIS.this_cLancas)    + ", " + ;
                       " opers     = " + EscaparSQL(THIS.this_cOpers)     + ", " + ;
                       " autos     = " + EscaparSQL(THIS.this_cAutos)     + ", " + ;
                       " operacaos = " + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                       " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigBaOco (PROTECTED - chamado por Excluir)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigBaOco" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

