# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAEG.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1325 linhas total):

*-- Linhas 54 a 62:
54:         loc_lSucesso   = .F.
55:         loc_lContinuar = .T.
56:         TRY
57:             THIS.Caption = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
58: 
59:             IF TYPE("gc_4c_CaminhoIcones") = "U"
60:                 gc_4c_CaminhoIcones = ""
61:             ENDIF
62:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 79 a 88:
79:                 *-- PageFrame com 2 paginas (padrao do sistema - Page1=Filtros, Page2=Dados)
80:                 THIS.ConfigurarPageFrame()
81: 
82:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
83:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
84: 
85:                 *-- ConfigurarPaginaLista: sem grid de selecao neste relatorio
86:                 THIS.ConfigurarPaginaLista()
87: 
88:                 *-- Campos de filtro: Empresa, Grande Grupo, Grupo/Conta Estoque, Periodo

*-- Linhas 111 a 148:
111:     PROTECTED PROCEDURE ConfigurarCabecalho()
112:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH THIS.cnt_4c_Cabecalho
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BackStyle   = 1
120:             .BorderWidth = 0
121:             .Visible     = .T.
122:         ENDWITH
123: 
124:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
125:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
126:             .Top       = 17
127:             .Left      = 12
128:             .AutoSize  = .T.
129:             .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
130:             .FontName  = "Tahoma"
131:             .FontSize  = 14
132:             .FontBold  = .T.
133:             .ForeColor = RGB(0, 0, 0)
134:             .BackStyle = 0
135:             .Visible   = .T.
136:         ENDWITH
137: 
138:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
139:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
140:             .Top       = 20
141:             .Left      = 10
142:             .AutoSize  = .T.
143:             .Caption   = "An" + CHR(225) + "lise de Estoque por Grande Grupo"
144:             .FontName  = "Tahoma"
145:             .FontSize  = 14
146:             .FontBold  = .T.
147:             .ForeColor = RGB(255, 255, 255)
148:             .BackStyle = 0

*-- Linhas 158 a 167:
158:     PROTECTED PROCEDURE ConfigurarBotoes()
159:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
160:         WITH THIS.cmg_4c_Botoes
161:             .Top           = 0
162:             .Left          = 529
163:             .Width         = 273
164:             .Height        = 80
165:             .ButtonCount   = 4
166:             .BackStyle     = 0
167:             .BorderStyle   = 0

*-- Linhas 173 a 252:
173: 
174:         *-- Botao 1: Visualizar
175:         WITH THIS.cmg_4c_Botoes.Buttons(1)
176:             .Top             = 5
177:             .Left            = 5
178:             .Width           = 65
179:             .Height          = 70
180:             .Caption         = "Visualizar"
181:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
182:             .PicturePosition = 13
183:             .FontName        = "Comic Sans MS"
184:             .FontBold        = .T.
185:             .FontItalic      = .T.
186:             .FontSize        = 8
187:             .BackColor       = RGB(255, 255, 255)
188:             .ForeColor       = RGB(90, 90, 90)
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .MousePointer    = 15
192:             .WordWrap        = .T.
193:         ENDWITH
194: 
195:         *-- Botao 2: Imprimir
196:         WITH THIS.cmg_4c_Botoes.Buttons(2)
197:             .Top             = 5
198:             .Left            = 71
199:             .Width           = 65
200:             .Height          = 70
201:             .Caption         = "Imprimir"
202:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
203:             .PicturePosition = 13
204:             .FontName        = "Comic Sans MS"
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .FontSize        = 8
208:             .BackColor       = RGB(255, 255, 255)
209:             .ForeColor       = RGB(90, 90, 90)
210:             .Themes          = .F.
211:             .SpecialEffect   = 0
212:             .MousePointer    = 15
213:             .WordWrap        = .T.
214:         ENDWITH
215: 
216:         *-- Botao 3: Excel
217:         WITH THIS.cmg_4c_Botoes.Buttons(3)
218:             .Top             = 5
219:             .Left            = 137
220:             .Width           = 65
221:             .Height          = 70
222:             .Caption         = "Excel"
223:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
224:             .PicturePosition = 13
225:             .FontName        = "Comic Sans MS"
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .FontSize        = 8
229:             .BackColor       = RGB(255, 255, 255)
230:             .ForeColor       = RGB(90, 90, 90)
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .MousePointer    = 15
234:             .WordWrap        = .T.
235:         ENDWITH
236: 
237:         *-- Botao 4: Encerrar (Cancel=.T. para ESC fechar)
238:         WITH THIS.cmg_4c_Botoes.Buttons(4)
239:             .Top             = 5
240:             .Left            = 203
241:             .Width           = 65
242:             .Height          = 70
243:             .Caption         = "Encerrar"
244:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
245:             .PicturePosition = 13
246:             .FontName        = "Comic Sans MS"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .Themes          = .F.

*-- Linhas 277 a 298:
277:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
278:         loc_oPgf.PageCount = 2
279: 
280:         loc_oPgf.Top    = 85
281:         loc_oPgf.Left   = -1
282:         loc_oPgf.Width  = THIS.Width + 2
283:         loc_oPgf.Height = THIS.Height - 85
284:         loc_oPgf.Tabs   = .F.
285: 
286:         loc_oPgf.Page1.Caption   = "Filtros"
287:         loc_oPgf.Page1.FontName  = "Tahoma"
288:         loc_oPgf.Page1.FontSize  = 8
289:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
290:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
291:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
292: 
293:         loc_oPgf.Page2.Caption   = "Dados"
294:         loc_oPgf.Page2.FontName  = "Tahoma"
295:         loc_oPgf.Page2.FontSize  = 8
296:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
297:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
298:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

*-- Linhas 357 a 381:
357:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
358: 
359:         *-- EMPRESA (original Say5 top=123->38, getEmpresa top=120->35, getDesEmpresa top=120->35)
360:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
361:         WITH loc_oPagina.lbl_4c_Empresa
362:             .Top       = 38
363:             .Left      = 224
364:             .AutoSize  = .T.
365:             .Caption   = "Empresa :"
366:             .FontName  = "Tahoma"
367:             .FontSize  = 8
368:             .ForeColor = RGB(90, 90, 90)
369:             .BackStyle = 0
370:             .Visible   = .T.
371:         ENDWITH
372: 
373:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
374:         WITH loc_oPagina.txt_4c_Empresa
375:             .Top       = 35
376:             .Left      = 279
377:             .Width     = 31
378:             .Height    = 23
379:             .MaxLength = 3
380:             .Value     = ""
381:             .FontName  = "Tahoma"

*-- Linhas 387 a 425:
387: 
388:         loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
389:         WITH loc_oPagina.txt_4c_DesEmpresa
390:             .Top       = 35
391:             .Left      = 312
392:             .Width     = 290
393:             .Height    = 23
394:             .MaxLength = 40
395:             .Value     = ""
396:             .FontName  = "Tahoma"
397:             .FontSize  = 8
398:             .BackColor = RGB(255, 255, 255)
399:             .ForeColor = RGB(90, 90, 90)
400:             .Visible   = .T.
401:         ENDWITH
402: 
403:         *-- GRANDE GRUPO (original lbl_codigo top=150->65, get_cd_ggrupo top=145->60, get_ds_ggrupo top=145->60)
404:         loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
405:         WITH loc_oPagina.lbl_4c_GGrupo
406:             .Top       = 65
407:             .Left      = 198
408:             .AutoSize  = .T.
409:             .Caption   = "Grande Grupo :"
410:             .FontName  = "Tahoma"
411:             .FontSize  = 8
412:             .ForeColor = RGB(90, 90, 90)
413:             .BackStyle = 0
414:             .Visible   = .T.
415:         ENDWITH
416: 
417:         loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
418:         WITH loc_oPagina.txt_4c_CdGGrupo
419:             .Top       = 60
420:             .Left      = 279
421:             .Width     = 31
422:             .Height    = 23
423:             .MaxLength = 3
424:             .Value     = ""
425:             .FontName  = "Tahoma"

*-- Linhas 431 a 469:
431: 
432:         loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
433:         WITH loc_oPagina.txt_4c_DsGGrupo
434:             .Top       = 60
435:             .Left      = 312
436:             .Width     = 290
437:             .Height    = 23
438:             .MaxLength = 40
439:             .Value     = ""
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .BackColor = RGB(255, 255, 255)
443:             .ForeColor = RGB(90, 90, 90)
444:             .Visible   = .T.
445:         ENDWITH
446: 
447:         *-- GRUPO DE ESTOQUE (original Say2 top=177->92, get_Cd_GrEstoque top=172->87, get_Ds_GrEstoque top=172->87)
448:         loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
449:         WITH loc_oPagina.lbl_4c_GrEstoque
450:             .Top       = 92
451:             .Left      = 179
452:             .AutoSize  = .T.
453:             .Caption   = "Grupo de Estoque :"
454:             .FontName  = "Tahoma"
455:             .FontSize  = 8
456:             .ForeColor = RGB(90, 90, 90)
457:             .BackStyle = 0
458:             .Visible   = .T.
459:         ENDWITH
460: 
461:         loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
462:         WITH loc_oPagina.txt_4c_CdGrEstoque
463:             .Top       = 87
464:             .Left      = 279
465:             .Width     = 80
466:             .Height    = 23
467:             .MaxLength = 10
468:             .Value     = ""
469:             .FontName  = "Tahoma"

*-- Linhas 475 a 513:
475: 
476:         loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
477:         WITH loc_oPagina.txt_4c_DsGrEstoque
478:             .Top       = 87
479:             .Left      = 361
480:             .Width     = 290
481:             .Height    = 23
482:             .MaxLength = 20
483:             .Value     = ""
484:             .FontName  = "Tahoma"
485:             .FontSize  = 8
486:             .BackColor = RGB(255, 255, 255)
487:             .ForeColor = RGB(90, 90, 90)
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         *-- CONTA DE ESTOQUE (original lbl_estoque top=204->119, get_cd_estoque top=199->114, get_ds_estoque top=199->114)
492:         loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
493:         WITH loc_oPagina.lbl_4c_Estoque
494:             .Top       = 119
495:             .Left      = 179
496:             .AutoSize  = .T.
497:             .Caption   = "Conta de Estoque :"
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .ForeColor = RGB(90, 90, 90)
501:             .BackStyle = 0
502:             .Visible   = .T.
503:         ENDWITH
504: 
505:         loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
506:         WITH loc_oPagina.txt_4c_CdEstoque
507:             .Top       = 114
508:             .Left      = 279
509:             .Width     = 80
510:             .Height    = 23
511:             .MaxLength = 10
512:             .Value     = ""
513:             .FontName  = "Tahoma"

*-- Linhas 519 a 585:
519: 
520:         loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
521:         WITH loc_oPagina.txt_4c_DsEstoque
522:             .Top       = 114
523:             .Left      = 361
524:             .Width     = 290
525:             .Height    = 23
526:             .MaxLength = 40
527:             .Value     = ""
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .BackColor = RGB(255, 255, 255)
531:             .ForeColor = RGB(90, 90, 90)
532:             .Visible   = .T.
533:         ENDWITH
534: 
535:         *-- PERIODO (original lbl_periodo top=231->146, get_dt_inicial top=226->141, get_dt_final top=226->141)
536:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
537:         WITH loc_oPagina.lbl_4c_Periodo
538:             .Top       = 146
539:             .Left      = 229
540:             .AutoSize  = .T.
541:             .Caption   = "Per" + CHR(237) + "odo :"
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .ForeColor = RGB(90, 90, 90)
545:             .BackStyle = 0
546:             .Visible   = .T.
547:         ENDWITH
548: 
549:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
550:         WITH loc_oPagina.txt_4c_DtInicial
551:             .Top       = 141
552:             .Left      = 279
553:             .Width     = 80
554:             .Height    = 23
555:             .Value     = {}
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .BackColor = RGB(255, 255, 255)
559:             .ForeColor = RGB(0, 0, 0)
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         *-- Separador "a" entre datas (original lbl_periodo_a top=231->146, left=364)
564:         loc_oPagina.AddObject("lbl_4c_PeriodoA", "Label")
565:         WITH loc_oPagina.lbl_4c_PeriodoA
566:             .Top       = 146
567:             .Left      = 364
568:             .AutoSize  = .T.
569:             .Caption   = CHR(224)
570:             .FontName  = "Tahoma"
571:             .FontSize  = 8
572:             .ForeColor = RGB(90, 90, 90)
573:             .BackStyle = 0
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
578:         WITH loc_oPagina.txt_4c_DtFinal
579:             .Top       = 141
580:             .Left      = 376
581:             .Width     = 80
582:             .Height    = 23
583:             .Value     = {}
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8

