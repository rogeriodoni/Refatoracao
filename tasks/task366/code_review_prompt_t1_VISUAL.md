# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (7)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 169: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 238: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 261: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 296: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3903 linhas total):

*-- Linhas 72 a 88:
72:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
73:         WITH THIS.pgf_4c_Paginas
74:             .PageCount  = 2
75:             .Top        = -29
76:             .Left       = 0
77:             .Width      = THIS.Width
78:             .Height     = THIS.Height + 29
79:             .Tabs       = .F.
80:             .Visible    = .T.
81:             .Page1.Caption   = "Lista"
82:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
83:             .Page2.Caption   = "Dados"
84:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:             .Page1.BackColor = RGB(224, 223, 227)
86:             .Page2.BackColor = RGB(224, 223, 227)
87:         ENDWITH
88: 

*-- Linhas 102 a 139:
102:         *-- Container cabecalho cinza superior (cntSombra no legado)
103:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH loc_oPagina.cnt_4c_Cabecalho
105:             .Top         = 31
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackColor   = RGB(100, 100, 100)
110:             .BorderWidth = 0
111:             .SpecialEffect = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Caption   = "Cadastro de CFOP"
117:                 .Top       = 15
118:                 .Left      = 10
119:                 .Width     = THIS.Parent.Width - 20
120:                 .Height    = 40
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 16
123:                 .FontBold  = .T.
124:                 .ForeColor = RGB(0, 0, 0)
125:                 .BackStyle = 0
126:                 .AutoSize  = .F.
127:                 .Visible   = .T.
128:             ENDWITH
129: 
130:             .AddObject("lbl_4c_Titulo", "Label")
131:             WITH .lbl_4c_Titulo
132:                 .Caption   = "Cadastro de CFOP"
133:                 .Top       = 18
134:                 .Left      = 10
135:                 .Width     = THIS.Parent.Width - 20
136:                 .Height    = 46
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.

*-- Linhas 147 a 267:
147:         *-- Container botoes CRUD (Grupo_Op no legado)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 29
151:             .Left        = 542
152:             .Width       = 390
153:             .Height      = 85
154:             .BackStyle = 0
155:             .BorderWidth = 0
156:             .SpecialEffect = 0
157:             .Visible     = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
161:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
162:             .Caption         = "Incluir"
163:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
164:             .PicturePosition = 13
165:             .Top             = 5
166:             .Left            = 5
167:             .Width           = 75
168:             .Height          = 75
169:             .FontName        = "Comic Sans MS"
170:             .FontBold        = .T.
171:             .FontItalic      = .T.
172:             .FontSize        = 8
173:             .ForeColor       = RGB(90, 90, 90)
174:             .BackColor       = RGB(255, 255, 255)
175:             .Themes          = .F.
176:             .SpecialEffect   = 0
177:             .MousePointer    = 15
178:             .WordWrap        = .T.
179:             .AutoSize        = .F.
180:             .Visible         = .T.
181:         ENDWITH
182: 
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontBold        = .T.
194:             .FontItalic      = .T.
195:             .FontSize        = 8
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .Visible         = .T.
204:         ENDWITH
205: 
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
208:             .Caption         = "Alterar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 155
213:             .Width           = 75
214:             .Height          = 75
215:             .FontName        = "Comic Sans MS"
216:             .FontBold        = .T.
217:             .FontItalic      = .T.
218:             .FontSize        = 8
219:             .ForeColor       = RGB(90, 90, 90)
220:             .BackColor       = RGB(255, 255, 255)
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228: 
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
231:             .Caption         = "Excluir"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 230
236:             .Width           = 75
237:             .Height          = 75
238:             .FontName        = "Comic Sans MS"
239:             .FontBold        = .T.
240:             .FontItalic      = .T.
241:             .FontSize        = 8
242:             .ForeColor       = RGB(90, 90, 90)
243:             .BackColor       = RGB(255, 255, 255)
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .AutoSize        = .F.
249:             .Visible         = .T.
250:         ENDWITH
251: 
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
254:             .Caption         = "Buscar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 305
259:             .Width           = 75
260:             .Height          = 75
261:             .FontName        = "Comic Sans MS"
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .FontSize        = 8
265:             .ForeColor       = RGB(90, 90, 90)
266:             .BackColor       = RGB(255, 255, 255)
267:             .Themes          = .F.

*-- Linhas 275 a 302:
275:         *-- Container saida - padrao canonico (Grupo_Saida no legado)
276:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
277:         WITH loc_oPagina.cnt_4c_Saida
278:             .Top         = 29
279:             .Left        = 917
280:             .Width       = 90
281:             .Height      = 85
282:             .BackStyle   = 0
283:             .BorderWidth = 0
284:             .SpecialEffect = 0
285:             .Visible     = .T.
286: 
287:             .AddObject("cmd_4c_Encerrar", "CommandButton")
288:             WITH .cmd_4c_Encerrar
289:                 .Caption         = "Encerrar"
290:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
291:                 .PicturePosition = 13
292:                 .Top             = 5
293:                 .Left            = 917
294:                 .Width           = 90
295:                 .Height          = 75
296:                 .FontName        = "Comic Sans MS"
297:                 .FontBold        = .T.
298:                 .FontItalic      = .T.
299:                 .FontSize        = 8
300:                 .ForeColor       = RGB(90, 90, 90)
301:                 .BackColor       = RGB(255, 255, 255)
302:                 .SpecialEffect   = 0

*-- Linhas 308 a 320:
308:         ENDWITH
309: 
310:         *-- Botoes Exporta/Importa XML (legado: btnExpXML/btnImpXML top=82+29=111)
311:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
312:         WITH loc_oPagina.cmd_4c_ExpXML
313:             .Caption       = "Exporta XML"
314:             .Top           = 111
315:             .Left          = 681
316:             .Width         = 120
317:             .Height        = 40
318:             .FontName      = "Tahoma"
319:             .FontBold      = .F.
320:             .FontSize      = 8

*-- Linhas 327 a 339:
327:             .Visible       = .T.
328:         ENDWITH
329: 
330:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
331:         WITH loc_oPagina.cmd_4c_ImpXML
332:             .Caption       = "Importa XML"
333:             .Top           = 111
334:             .Left          = 801
335:             .Width         = 120
336:             .Height        = 40
337:             .FontName      = "Tahoma"
338:             .FontBold      = .F.
339:             .FontSize      = 8

*-- Linhas 349 a 358:
349:         *-- Grid de lista (Grade no legado) - top=127+29=156 com compensacao PageFrame
350:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
351:         WITH loc_oPagina.grd_4c_Lista
352:             .Top                = 156
353:             .Left               = 11
354:             .Width              = 972
355:             .Height             = 520
356:             .FontName           = "Verdana"
357:             .FontSize           = 8
358:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 372 a 387:
372:         ENDWITH
373: 
374:         *-- BINDEVENTs para botoes CRUD e auxiliares
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
377:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
378:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
379:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
380:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
381:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML,                   "Click", THIS, "BtnExpXMLClick")
382:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML,                   "Click", THIS, "BtnImpXMLClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *==========================================================================

*-- Linhas 396 a 433:
396:         *-- Cabecalho cinza (identico ao da Page1 Lista)
397:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
398:         WITH loc_oPagina.cnt_4c_Cabecalho
399:             .Top           = 29
400:             .Left          = 0
401:             .Width         = THIS.Width
402:             .Height        = 80
403:             .BackColor     = RGB(100, 100, 100)
404:             .BorderWidth   = 0
405:             .SpecialEffect = 0
406:             .Visible       = .T.
407: 
408:             .AddObject("lbl_4c_Sombra", "Label")
409:             WITH .lbl_4c_Sombra
410:                 .Caption   = "Cadastro de CFOP"
411:                 .Top       = 15
412:                 .Left      = 10
413:                 .Width     = THIS.Parent.Width - 20
414:                 .Height    = 40
415:                 .FontName  = "Tahoma"
416:                 .FontSize  = 16
417:                 .FontBold  = .T.
418:                 .ForeColor = RGB(0, 0, 0)
419:                 .BackStyle = 0
420:                 .AutoSize  = .F.
421:                 .Visible   = .T.
422:             ENDWITH
423: 
424:             .AddObject("lbl_4c_Titulo", "Label")
425:             WITH .lbl_4c_Titulo
426:                 .Caption   = "Cadastro de CFOP"
427:                 .Top       = 18
428:                 .Left      = 10
429:                 .Width     = THIS.Parent.Width - 20
430:                 .Height    = 46
431:                 .FontName  = "Tahoma"
432:                 .FontSize  = 16
433:                 .FontBold  = .T.

*-- Linhas 441 a 510:
441:         *-- Container salvar/cancelar (botoes adicionados na Fase 6)
442:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
443:         WITH loc_oPagina.cnt_4c_Salva
444:             .Top           = 33
445:             .Left          = 842
446:             .Width         = 160
447:             .Height        = 85
448:             .BackStyle     = 0
449:             .BorderWidth   = 0
450:             .SpecialEffect = 0
451:             .Visible       = .T.
452:         ENDWITH
453: 
454:         *-- Botao Salvar
455:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Salvar", "CommandButton")
456:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar
457:             .Caption         = "Salvar"
458:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
459:             .PicturePosition = 13
460:             .Width           = 75
461:             .Height          = 75
462:             .Left            = 5
463:             .Top             = 5
464:             .FontName        = "Tahoma"
465:             .FontSize        = 8
466:             .Themes          = .F.
467:             .SpecialEffect   = 0
468:             .BackColor       = RGB(255, 255, 255)
469:             .ForeColor       = RGB(90, 90, 90)
470:             .Visible         = .T.
471:         ENDWITH
472:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
473: 
474:         *-- Botao Cancelar / Encerrar edicao
475:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
479:             .PicturePosition = 13
480:             .Width           = 75
481:             .Height          = 75
482:             .Left            = 83
483:             .Top             = 5
484:             .FontName        = "Tahoma"
485:             .FontSize        = 8
486:             .Themes          = .F.
487:             .SpecialEffect   = 0
488:             .BackColor       = RGB(255, 255, 255)
489:             .ForeColor       = RGB(90, 90, 90)
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
493: 
494:         *-- PageFrame interno (PagDados no legado) - top=120+29=149
495:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
496:         WITH loc_oPagina.pgf_4c_PagDados
497:             .PageCount       = 2
498:             .Top             = 149
499:             .Left            = -1
500:             .Width           = 998
501:             .Height          = 730
502:             .Tabs            = .T.
503:             .Visible         = .T.
504:             .Page1.Caption   = "Dados CFOP"
505:             .Page2.Caption   = "Contabilidade"
506:             .Page1.BackColor = RGB(224, 223, 227)
507:             .Page2.BackColor = RGB(224, 223, 227)
508:         ENDWITH
509: 
510:         THIS.ConfigurarPgPage1()

*-- Linhas 525 a 1690:
525:         *-- Separadores horizontais
526:         loc_oPage1.AddObject("shp_4c_Shp01", "Shape")
527:         WITH loc_oPage1.shp_4c_Shp01
528:             .Top         = 92
529:             .Left        = 3
530:             .Width       = 984
531:             .Height      = 1
532:             .BackColor   = RGB(128, 128, 128)
533:             .BorderColor = RGB(128, 128, 128)
534:             .Visible     = .T.
535:         ENDWITH
536: 
537:         loc_oPage1.AddObject("shp_4c_Shp03", "Shape")
538:         WITH loc_oPage1.shp_4c_Shp03
539:             .Top         = 236
540:             .Left        = 3
541:             .Width       = 984
542:             .Height      = 1
543:             .BackColor   = RGB(128, 128, 128)
544:             .BorderColor = RGB(128, 128, 128)
545:             .Visible     = .T.
546:         ENDWITH
547: 
548:         *-- Separador vertical NF-e
549:         loc_oPage1.AddObject("shp_4c_Shape1", "Shape")
550:         WITH loc_oPage1.shp_4c_Shape1
551:             .Top         = 243
552:             .Left        = 488
553:             .Width       = 1
554:             .Height      = 206
555:             .BackColor   = RGB(128, 128, 128)
556:             .BorderColor = RGB(128, 128, 128)
557:             .Visible     = .T.
558:         ENDWITH
559: 
560:         *-- Label: Codigo
561:         loc_oPage1.AddObject("lbl_4c_Label1", "Label")
562:         WITH loc_oPage1.lbl_4c_Label1
563:             .Caption   = "C" + CHR(243) + "digo :"
564:             .Top       = 11
565:             .Left      = 90
566:             .Width     = 42
567:             .Height    = 15
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .BackStyle = 0
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         *-- txt_4c_Codigo (getCodigo) - codigos char(10)
575:         loc_oPage1.AddObject("txt_4c_Codigo", "TextBox")
576:         WITH loc_oPage1.txt_4c_Codigo
577:             .Top       = 7
578:             .Left      = 136
579:             .Width     = 91
580:             .Height    = 24
581:             .MaxLength = 10
582:             .Value     = ""
583:             .FontName  = "Tahoma"
584:             .FontSize  = 8
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         *-- opc_situacao - situas (0=Ativo 1=Inativo)
589:         loc_oPage1.AddObject("obj_4c_Opc_situacao", "OptionGroup")
590:         WITH loc_oPage1.obj_4c_Opc_situacao
591:             .Top         = 11
592:             .Left        = 243
593:             .Width       = 137
594:             .Height      = 17
595:             .ButtonCount = 2
596:             .BackStyle   = 0
597:             .Value       = 1
598:             .Visible     = .T.
599: 
600:             WITH .Buttons(1)
601:                 .Caption   = "Ativo"
602:                 .Width     = 65
603:                 .Height    = 17
604:                 .Left      = 0
605:                 .Top       = 0
606:                 .BackStyle = 0
607:                 .Visible   = .T.
608:             ENDWITH
609: 
610:             WITH .Buttons(2)
611:                 .Caption   = "Inativo"
612:                 .Width     = 65
613:                 .Height    = 17
614:                 .Left      = 67
615:                 .Top       = 0
616:                 .BackStyle = 0
617:                 .FontName  = "Tahoma"
618:                 .FontSize  = 8
619:                 .Visible   = .T.
620:             ENDWITH
621:         ENDWITH
622: 
623:         *-- Label: Operacao
624:         loc_oPage1.AddObject("lbl_4c_Label3", "Label")
625:         WITH loc_oPage1.lbl_4c_Label3
626:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
627:             .Top       = 11
628:             .Left      = 393
629:             .Width     = 56
630:             .Height    = 15
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .BackStyle = 0
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- cmbOperacao - operacaos char(1) E/S
638:         loc_oPage1.AddObject("cbo_4c_CmbOperacao", "ComboBox")
639:         WITH loc_oPage1.cbo_4c_CmbOperacao
640:             .Top           = 7
641:             .Left          = 459
642:             .Width         = 107
643:             .Height        = 24
644:             .RowSourceType = 1
645:             .RowSource     = "E,S"
646:             .Style         = 2
647:             .Value         = "E"
648:             .FontName      = "Tahoma"
649:             .FontSize      = 8
650:             .Visible       = .T.
651:         ENDWITH
652: 
653:         *-- Label: Tipo
654:         loc_oPage1.AddObject("lbl_4c_Label37", "Label")
655:         WITH loc_oPage1.lbl_4c_Label37
656:             .Caption   = "Tipo :"
657:             .Top       = 11
658:             .Left      = 620
659:             .Width     = 29
660:             .Height    = 15
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .BackStyle = 0
664:             .Visible   = .T.
665:         ENDWITH
666: 
667:         *-- cmbtipo - tipos numeric(1,0)
668:         loc_oPage1.AddObject("cbo_4c_Cmbtipo", "ComboBox")
669:         WITH loc_oPage1.cbo_4c_Cmbtipo
670:             .Top           = 7
671:             .Left          = 653
672:             .Width         = 151
673:             .Height        = 24
674:             .RowSourceType = 1
675:             .RowSource     = "0,1,2,3,4,5,6,7,8,9"
676:             .Style         = 2
677:             .Value         = "0"
678:             .FontName      = "Tahoma"
679:             .FontSize      = 8
680:             .Visible       = .T.
681:         ENDWITH
682: 
683:         *-- Label: Digitos Para NF
684:         loc_oPage1.AddObject("lbl_4c_Label24", "Label")
685:         WITH loc_oPage1.lbl_4c_Label24
686:             .Caption   = "D" + CHR(237) + "gitos Para NF :"
687:             .Top       = 12
688:             .Left      = 861
689:             .Width     = 82
690:             .Height    = 15
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .BackStyle = 0
694:             .Visible   = .T.
695:         ENDWITH
696: 
697:         *-- spn_4c_Ndigito - ndigitos numeric(2,0)
698:         loc_oPage1.AddObject("spn_4c_Ndigito", "Spinner")
699:         WITH loc_oPage1.spn_4c_Ndigito
700:             .Top              = 7
701:             .Left             = 947
702:             .Width            = 40
703:             .Height           = 24
704:             .SpinnerLowValue  = 0
705:             .SpinnerHighValue = 99
706:             .Value            = 0
707:             .FontName         = "Tahoma"
708:             .FontSize         = 8
709:             .Visible          = .T.
710:         ENDWITH
711: 
712:         *-- Label: Descricao Nota Fiscal
713:         loc_oPage1.AddObject("lbl_4c_Label2", "Label")
714:         WITH loc_oPage1.lbl_4c_Label2
715:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
716:             .Top       = 38
717:             .Left      = 22
718:             .Width     = 110
719:             .Height    = 15
720:             .FontName  = "Tahoma"
721:             .FontSize  = 8
722:             .BackStyle = 0
723:             .Visible   = .T.
724:         ENDWITH
725: 
726:         *-- txt_4c_Descricao - descricaos char(60)
727:         loc_oPage1.AddObject("txt_4c_Descricao", "TextBox")
728:         WITH loc_oPage1.txt_4c_Descricao
729:             .Top       = 34
730:             .Left      = 136
731:             .Width     = 430
732:             .Height    = 24
733:             .MaxLength = 60
734:             .Value     = ""
735:             .FontName  = "Tahoma"
736:             .FontSize  = 8
737:             .Visible   = .T.
738:         ENDWITH
739: 
740:         *-- Label: Descricao Consulta
741:         loc_oPage1.AddObject("lbl_4c_Label29", "Label")
742:         WITH loc_oPage1.lbl_4c_Label29
743:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
744:             .Top       = 65
745:             .Left      = 32
746:             .Width     = 100
747:             .Height    = 15
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .BackStyle = 0
751:             .Visible   = .T.
752:         ENDWITH
753: 
754:         *-- txt_4c_Desc2s - desc2s char(60)
755:         loc_oPage1.AddObject("txt_4c_Desc2s", "TextBox")
756:         WITH loc_oPage1.txt_4c_Desc2s
757:             .Top       = 61
758:             .Left      = 136
759:             .Width     = 430
760:             .Height    = 24
761:             .MaxLength = 60
762:             .Value     = ""
763:             .FontName  = "Tahoma"
764:             .FontSize  = 8
765:             .Visible   = .T.
766:         ENDWITH
767: 
768:         *-- === SECAO ICMS ===
769: 
770:         *-- Label: ICMS
771:         loc_oPage1.AddObject("lbl_4c_Label4", "Label")
772:         WITH loc_oPage1.lbl_4c_Label4
773:             .Caption   = "I C M S :"
774:             .Top       = 105
775:             .Left      = 88
776:             .Width     = 43
777:             .Height    = 15
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .BackStyle = 0
781:             .Visible   = .T.
782:         ENDWITH
783: 
784:         *-- cmbIcms - icms char(1) T/I/O/N
785:         loc_oPage1.AddObject("cbo_4c_CmbIcms", "ComboBox")
786:         WITH loc_oPage1.cbo_4c_CmbIcms
787:             .Top           = 101
788:             .Left          = 136
789:             .Width         = 82
790:             .Height        = 23
791:             .RowSourceType = 1
792:             .RowSource     = "T,I,O,N"
793:             .Style         = 2
794:             .Value         = "T"
795:             .FontName      = "Tahoma"
796:             .FontSize      = 8
797:             .Visible       = .T.
798:         ENDWITH
799: 
800:         *-- Label: Sobre Desconto (icmsincs)
801:         loc_oPage1.AddObject("lbl_4c_Label31", "Label")
802:         WITH loc_oPage1.lbl_4c_Label31
803:             .Caption   = "Sobre Desconto :"
804:             .Top       = 131
805:             .Left      = 46
806:             .Width     = 85
807:             .Height    = 15
808:             .FontName  = "Tahoma"
809:             .FontSize  = 8
810:             .BackStyle = 0
811:             .Visible   = .T.
812:         ENDWITH
813: 
814:         *-- Combo6 - icmsincs numeric(1,0)
815:         loc_oPage1.AddObject("cbo_4c_Combo6", "ComboBox")
816:         WITH loc_oPage1.cbo_4c_Combo6
817:             .Top           = 127
818:             .Left          = 136
819:             .Width         = 82
820:             .Height        = 23
821:             .RowSourceType = 1
822:             .RowSource     = "0,1"
823:             .Style         = 2
824:             .Value         = "0"
825:             .FontName      = "Tahoma"
826:             .FontSize      = 8
827:             .Visible       = .T.
828:         ENDWITH
829: 
830:         *-- Label: Incluir ICMS
831:         loc_oPage1.AddObject("lbl_4c_Label26", "Label")
832:         WITH loc_oPage1.lbl_4c_Label26
833:             .Caption   = "Incluir ICMS :"
834:             .Top       = 105
835:             .Left      = 309
836:             .Width     = 66
837:             .Height    = 15
838:             .FontName  = "Tahoma"
839:             .FontSize  = 8
840:             .BackStyle = 0
841:             .Visible   = .T.
842:         ENDWITH
843: 
844:         *-- Combo3 - inclicms numeric(1,0)
845:         loc_oPage1.AddObject("cbo_4c_Combo3", "ComboBox")
846:         WITH loc_oPage1.cbo_4c_Combo3
847:             .Top           = 101
848:             .Left          = 380
849:             .Width         = 82
850:             .Height        = 23
851:             .RowSourceType = 1
852:             .RowSource     = "0,1"
853:             .Style         = 2
854:             .Value         = "0"
855:             .FontName      = "Tahoma"
856:             .FontSize      = 8
857:             .Visible       = .T.
858:         ENDWITH
859: 
860:         *-- Label: Inclui IPI na Base
861:         loc_oPage1.AddObject("lbl_4c_Label25", "Label")
862:         WITH loc_oPage1.lbl_4c_Label25
863:             .Caption   = "Inclui IPI na Base :"
864:             .Top       = 131
865:             .Left      = 283
866:             .Width     = 92
867:             .Height    = 15
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:             .Visible   = .T.
872:         ENDWITH
873: 
874:         *-- Combo4 - inclipis numeric(1,0)
875:         loc_oPage1.AddObject("cbo_4c_Combo4", "ComboBox")
876:         WITH loc_oPage1.cbo_4c_Combo4
877:             .Top           = 127
878:             .Left          = 380
879:             .Width         = 82
880:             .Height        = 23
881:             .RowSourceType = 1
882:             .RowSource     = "0,1"
883:             .Style         = 2
884:             .Value         = "0"
885:             .FontName      = "Tahoma"
886:             .FontSize      = 8
887:             .Visible       = .T.
888:         ENDWITH
889: 
890:         *-- Label: ICMS Sobre
891:         loc_oPage1.AddObject("lbl_4c_Label14", "Label")
892:         WITH loc_oPage1.lbl_4c_Label14
893:             .Caption   = "ICMS Sobre :"
894:             .Top       = 104
895:             .Left      = 481
896:             .Width     = 65
897:             .Height    = 15
898:             .FontName  = "Tahoma"
899:             .FontSize  = 8
900:             .BackStyle = 0
901:             .Visible   = .T.
902:         ENDWITH
903: 
904:         *-- chk_4c_ObjFreteICM - frticms numeric(1,0)
905:         loc_oPage1.AddObject("chk_4c_ObjFreteICM", "CheckBox")
906:         WITH loc_oPage1.chk_4c_ObjFreteICM
907:             .Caption   = "Frete"
908:             .Top       = 102
909:             .Left      = 549
910:             .Width     = 44
911:             .Height    = 15
912:             .FontName  = "Tahoma"
913:             .FontSize  = 8
914:             .BackStyle = 0
915:             .Value     = 0
916:             .Visible   = .T.
917:         ENDWITH
918: 
919:         *-- chk_4c_ObjSegIcm - segicms numeric(1,0)
920:         loc_oPage1.AddObject("chk_4c_ObjSegIcm", "CheckBox")
921:         WITH loc_oPage1.chk_4c_ObjSegIcm
922:             .Caption   = "Seguro"
923:             .Top       = 117
924:             .Left      = 549
925:             .Width     = 52
926:             .Height    = 15
927:             .FontName  = "Tahoma"
928:             .FontSize  = 8
929:             .BackStyle = 0
930:             .Value     = 0
931:             .Visible   = .T.
932:         ENDWITH
933: 
934:         *-- chk_4c_ObjDespIcm - desicms numeric(1,0)
935:         loc_oPage1.AddObject("chk_4c_ObjDespIcm", "CheckBox")
936:         WITH loc_oPage1.chk_4c_ObjDespIcm
937:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
938:             .Top       = 132
939:             .Left      = 549
940:             .Width     = 118
941:             .Height    = 15
942:             .FontName  = "Tahoma"
943:             .FontSize  = 8
944:             .BackStyle = 0
945:             .Value     = 0
946:             .Visible   = .T.
947:         ENDWITH
948: 
949:         *-- chk_4c_Fwcheckbox1 - incicmnfs numeric(1,0)
950:         loc_oPage1.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
951:         WITH loc_oPage1.chk_4c_Fwcheckbox1
952:             .Caption   = "Incluir ICMS no Total da N.F."
953:             .Top       = 147
954:             .Left      = 549
955:             .Width     = 156
956:             .Height    = 15
957:             .FontName  = "Tahoma"
958:             .FontSize  = 8
959:             .BackStyle = 0
960:             .Value     = 0
961:             .Visible   = .T.
962:         ENDWITH
963: 
964:         *-- Label: CFOP ST60
965:         loc_oPage1.AddObject("lbl_4c_Label49", "Label")
966:         WITH loc_oPage1.lbl_4c_Label49
967:             .Caption   = "CFOP ST60:"
968:             .Top       = 104
969:             .Left      = 627
970:             .Width     = 60
971:             .Height    = 15
972:             .FontName  = "Tahoma"
973:             .FontSize  = 8
974:             .BackStyle = 0
975:             .Visible   = .T.
976:         ENDWITH
977: 
978:         *-- txt_4c_CfoST60 - cfost60s char(10)
979:         loc_oPage1.AddObject("txt_4c_CfoST60", "TextBox")
980:         WITH loc_oPage1.txt_4c_CfoST60
981:             .Top       = 101
982:             .Left      = 690
983:             .Width     = 82
984:             .Height    = 23
985:             .MaxLength = 10
986:             .Value     = ""
987:             .FontName  = "Tahoma"
988:             .FontSize  = 8
989:             .Visible   = .T.
990:         ENDWITH
991: 
992:         *-- Label: CFOP Subst.Trib.
993:         loc_oPage1.AddObject("lbl_4c_Label11", "Label")
994:         WITH loc_oPage1.lbl_4c_Label11
995:             .Caption   = "CFOP Subst.Trib.:"
996:             .Top       = 103
997:             .Left      = 794
998:             .Width     = 89
999:             .Height    = 15
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8
1002:             .BackStyle = 0
1003:             .Visible   = .T.
1004:         ENDWITH
1005: 
1006:         *-- txt_4c_CfoST - cfosts char(10)
1007:         loc_oPage1.AddObject("txt_4c_CfoST", "TextBox")
1008:         WITH loc_oPage1.txt_4c_CfoST
1009:             .Top       = 101
1010:             .Left      = 887
1011:             .Width     = 82
1012:             .Height    = 23
1013:             .MaxLength = 10
1014:             .Value     = ""
1015:             .FontName  = "Tahoma"
1016:             .FontSize  = 8
1017:             .Visible   = .T.
1018:         ENDWITH
1019: 
1020:         *-- Label: Substituicao Tributaria
1021:         loc_oPage1.AddObject("lbl_4c_Label10", "Label")
1022:         WITH loc_oPage1.lbl_4c_Label10
1023:             .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
1024:             .Top       = 157
1025:             .Left      = 32
1026:             .Width     = 99
1027:             .Height    = 15
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .BackStyle = 0
1031:             .Visible   = .T.
1032:         ENDWITH
1033: 
1034:         *-- CmbSTRIB - subtribs char(1) S/N
1035:         loc_oPage1.AddObject("cbo_4c_CmbSTRIB", "ComboBox")
1036:         WITH loc_oPage1.cbo_4c_CmbSTRIB
1037:             .Top           = 153
1038:             .Left          = 136
1039:             .Width         = 82
1040:             .Height        = 23
1041:             .RowSourceType = 1
1042:             .RowSource     = "S,N"
1043:             .Style         = 2
1044:             .Value         = "N"
1045:             .FontName      = "Tahoma"
1046:             .FontSize      = 8
1047:             .Visible       = .T.
1048:         ENDWITH
1049: 
1050:         *-- Label: Base Substituicao
1051:         loc_oPage1.AddObject("lbl_4c_Label12", "Label")
1052:         WITH loc_oPage1.lbl_4c_Label12
1053:             .Caption   = "Base Substitui" + CHR(231) + CHR(227) + "o :"
1054:             .Top       = 157
1055:             .Left      = 282
1056:             .Width     = 93
1057:             .Height    = 15
1058:             .FontName  = "Tahoma"
1059:             .FontSize  = 8
1060:             .BackStyle = 0
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         *-- txt_4c_Bcst - pbcsts numeric(5,2)
1065:         loc_oPage1.AddObject("txt_4c_Bcst", "TextBox")
1066:         WITH loc_oPage1.txt_4c_Bcst
1067:             .Top       = 153
1068:             .Left      = 380
1069:             .Width     = 82
1070:             .Height    = 23
1071:             .Value     = 0
1072:             .Format    = "N"
1073:             .InputMask = "999.99"
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:             .Visible   = .T.
1077:         ENDWITH
1078: 
1079:         *-- Label: CFOP Transporte
1080:         loc_oPage1.AddObject("lbl_4c_Label28", "Label")
1081:         WITH loc_oPage1.lbl_4c_Label28
1082:             .Caption   = "CFOP Transporte :"
1083:             .Top       = 158
1084:             .Left      = 791
1085:             .Width     = 92
1086:             .Height    = 15
1087:             .FontName  = "Tahoma"
1088:             .FontSize  = 8
1089:             .BackStyle = 0
1090:             .Visible   = .T.
1091:         ENDWITH
1092: 
1093:         *-- Combo5 - transps numeric(1,0)
1094:         loc_oPage1.AddObject("cbo_4c_Combo5", "ComboBox")
1095:         WITH loc_oPage1.cbo_4c_Combo5
1096:             .Top           = 153
1097:             .Left          = 887
1098:             .Width         = 82
1099:             .Height        = 23
1100:             .RowSourceType = 1
1101:             .RowSource     = "0,1"
1102:             .Style         = 2
1103:             .Value         = "0"
1104:             .FontName      = "Tahoma"
1105:             .FontSize      = 8
1106:             .Visible       = .T.
1107:         ENDWITH
1108: 
1109:         *-- Label: Situacao Tributaria
1110:         loc_oPage1.AddObject("lbl_4c_Label22", "Label")
1111:         WITH loc_oPage1.lbl_4c_Label22
1112:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
1113:             .Top       = 183
1114:             .Left      = 49
1115:             .Width     = 82
1116:             .Height    = 15
1117:             .FontName  = "Tahoma"
1118:             .FontSize  = 8
1119:             .BackStyle = 0
1120:             .Visible   = .T.
1121:         ENDWITH
1122: 
1123:         *-- txt_4c_Sittricm - sittribs char(3)
1124:         loc_oPage1.AddObject("txt_4c_Sittricm", "TextBox")
1125:         WITH loc_oPage1.txt_4c_Sittricm
1126:             .Top       = 179
1127:             .Left      = 136
1128:             .Width     = 31
1129:             .Height    = 22
1130:             .MaxLength = 3
1131:             .Value     = ""
1132:             .FontName  = "Tahoma"
1133:             .FontSize  = 8
1134:             .Visible   = .T.
1135:         ENDWITH
1136: 
1137:         *-- Label: ICMS Incluso no Preco
1138:         loc_oPage1.AddObject("lbl_4c_Label36", "Label")
1139:         WITH loc_oPage1.lbl_4c_Label36
1140:             .Caption   = "ICMS Incluso no Pre" + CHR(231) + "o:"
1141:             .Top       = 182
1142:             .Left      = 262
1143:             .Width     = 113
1144:             .Height    = 15
1145:             .FontName  = "Tahoma"
1146:             .FontSize  = 8
1147:             .BackStyle = 0
1148:             .Visible   = .T.
1149:         ENDWITH
1150: 
1151:         *-- Combo10 - icmsdscs numeric(1,0)
1152:         loc_oPage1.AddObject("cbo_4c_Combo10", "ComboBox")
1153:         WITH loc_oPage1.cbo_4c_Combo10
1154:             .Top           = 178
1155:             .Left          = 380
1156:             .Width         = 82
1157:             .Height        = 23
1158:             .RowSourceType = 1
1159:             .RowSource     = "0,1"
1160:             .Style         = 2
1161:             .Value         = "0"
1162:             .FontName      = "Tahoma"
1163:             .FontSize      = 8
1164:             .Visible       = .T.
1165:         ENDWITH
1166: 
1167:         *-- Label: Contribuinte
1168:         loc_oPage1.AddObject("lbl_4c_Label6", "Label")
1169:         WITH loc_oPage1.lbl_4c_Label6
1170:             .Caption   = "Contribuinte :"
1171:             .Top       = 184
1172:             .Left      = 815
1173:             .Width     = 68
1174:             .Height    = 15
1175:             .FontName  = "Tahoma"
1176:             .FontSize  = 8
1177:             .BackStyle = 0
1178:             .Visible   = .T.
1179:         ENDWITH
1180: 
1181:         *-- cmbContribuinte - contribs char(1) S/N/O
1182:         loc_oPage1.AddObject("cbo_4c_CmbContribuinte", "ComboBox")
1183:         WITH loc_oPage1.cbo_4c_CmbContribuinte
1184:             .Top           = 179
1185:             .Left          = 887
1186:             .Width         = 82
1187:             .Height        = 23
1188:             .RowSourceType = 1
1189:             .RowSource     = "S,N,O"
1190:             .Style         = 2
1191:             .Value         = "N"
1192:             .FontName      = "Tahoma"
1193:             .FontSize      = 8
1194:             .Visible       = .T.
1195:         ENDWITH
1196: 
1197:         *-- Label: Venda Consumidor
1198:         loc_oPage1.AddObject("lbl_4c_Label23", "Label")
1199:         WITH loc_oPage1.lbl_4c_Label23
1200:             .Caption   = "Venda Consumidor :"
1201:             .Top       = 207
1202:             .Left      = 33
1203:             .Width     = 98
1204:             .Height    = 15
1205:             .FontName  = "Tahoma"
1206:             .FontSize  = 8
1207:             .BackStyle = 0
1208:             .Visible   = .T.
1209:         ENDWITH
1210: 
1211:         *-- txt_4c_AliqIVCs - aliqivcs numeric(4,2)
1212:         loc_oPage1.AddObject("txt_4c_AliqIVCs", "TextBox")
1213:         WITH loc_oPage1.txt_4c_AliqIVCs
1214:             .Top       = 203
1215:             .Left      = 136
1216:             .Width     = 82
1217:             .Height    = 23
1218:             .Value     = 0
1219:             .Format    = "N"
1220:             .InputMask = "99.99"
1221:             .FontName  = "Tahoma"
1222:             .FontSize  = 8
1223:             .Visible   = .T.
1224:         ENDWITH
1225: 
1226:         *-- Label: % (aliqivcs)
1227:         loc_oPage1.AddObject("lbl_4c_Label13", "Label")
1228:         WITH loc_oPage1.lbl_4c_Label13
1229:             .Caption   = "%"
1230:             .Top       = 207
1231:             .Left      = 219
1232:             .Width     = 13
1233:             .Height    = 15
1234:             .FontName  = "Tahoma"
1235:             .FontSize  = 8
1236:             .BackStyle = 0
1237:             .Visible   = .T.
1238:         ENDWITH
1239: 
1240:         *-- Label: CFOP Destino
1241:         loc_oPage1.AddObject("lbl_4c_Label19", "Label")
1242:         WITH loc_oPage1.lbl_4c_Label19
1243:             .Caption   = "CFOP Destino :"
1244:             .Top       = 132
1245:             .Left      = 808
1246:             .Width     = 75
1247:             .Height    = 15
1248:             .FontName  = "Tahoma"
1249:             .FontSize  = 8
1250:             .BackStyle = 0
1251:             .Visible   = .T.
1252:         ENDWITH
1253: 
1254:         *-- txt_4c_Cfdest - coddests char(10)
1255:         loc_oPage1.AddObject("txt_4c_Cfdest", "TextBox")
1256:         WITH loc_oPage1.txt_4c_Cfdest
1257:             .Top       = 127
1258:             .Left      = 887
1259:             .Width     = 82
1260:             .Height    = 23
1261:             .MaxLength = 10
1262:             .Value     = ""
1263:             .FontName  = "Tahoma"
1264:             .FontSize  = 8
1265:             .Visible   = .T.
1266:         ENDWITH
1267: 
1268:         *-- Label: Inibe Valor Unitario NF Importacao
1269:         loc_oPage1.AddObject("lbl_4c_Label21", "Label")
1270:         WITH loc_oPage1.lbl_4c_Label21
1271:             .Caption   = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
1272:             .Top       = 211
1273:             .Left      = 694
1274:             .Width     = 189
1275:             .Height    = 15
1276:             .FontName  = "Tahoma"
1277:             .FontSize  = 8
1278:             .BackStyle = 0
1279:             .Visible   = .T.
1280:         ENDWITH
1281: 
1282:         *-- Combo9 - unitimps char(1) S/N
1283:         loc_oPage1.AddObject("cbo_4c_Combo9", "ComboBox")
1284:         WITH loc_oPage1.cbo_4c_Combo9
1285:             .Top           = 206
1286:             .Left          = 887
1287:             .Width         = 82
1288:             .Height        = 23
1289:             .RowSourceType = 1
1290:             .RowSource     = "S,N"
1291:             .Style         = 2
1292:             .Value         = "N"
1293:             .FontName      = "Tahoma"
1294:             .FontSize      = 8
1295:             .Visible       = .T.
1296:         ENDWITH
1297: 
1298:         *-- Label: Especificacoes Para NF-e
1299:         loc_oPage1.AddObject("lbl_4c_Label38", "Label")
1300:         WITH loc_oPage1.lbl_4c_Label38
1301:             .Caption   = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
1302:             .Top       = 246
1303:             .Left      = 498
1304:             .Width     = 140
1305:             .Height    = 15
1306:             .FontName  = "Tahoma"
1307:             .FontSize  = 8
1308:             .BackStyle = 0
1309:             .Visible   = .T.
1310:         ENDWITH
1311: 
1312:         *-- Label: Destaca ICMS na Nota Fiscal (S/N)
1313:         loc_oPage1.AddObject("lbl_4c_Label27", "Label")
1314:         WITH loc_oPage1.lbl_4c_Label27
1315:             .Caption   = "Destaca ICMS na Nota Fiscal (S/N) :"
1316:             .Top       = 270
1317:             .Left      = 771
1318:             .Width     = 174
1319:             .Height    = 15
1320:             .FontName  = "Tahoma"
1321:             .FontSize  = 8
1322:             .BackStyle = 0
1323:             .Visible   = .T.
1324:         ENDWITH
1325: 
1326:         *-- txt_4c_Gergia1 - cgergia1s char(1)
1327:         loc_oPage1.AddObject("txt_4c_Gergia1", "TextBox")
1328:         WITH loc_oPage1.txt_4c_Gergia1
1329:             .Top       = 265
1330:             .Left      = 948
1331:             .Width     = 20
1332:             .Height    = 23
1333:             .MaxLength = 1
1334:             .Value     = ""
1335:             .FontName  = "Tahoma"
1336:             .FontSize  = 8
1337:             .Visible   = .T.
1338:         ENDWITH
1339: 
1340:         *-- === SECAO IPI ===
1341: 
1342:         *-- Label: IPI
1343:         loc_oPage1.AddObject("lbl_4c_Label8", "Label")
1344:         WITH loc_oPage1.lbl_4c_Label8
1345:             .Caption   = "I P I :"
1346:             .Top       = 267
1347:             .Left      = 103
1348:             .Width     = 29
1349:             .Height    = 15
1350:             .FontName  = "Tahoma"
1351:             .FontSize  = 8
1352:             .BackStyle = 0
1353:             .Visible   = .T.
1354:         ENDWITH
1355: 
1356:         *-- cmbIpi - ipis char(1) T/I/O
1357:         loc_oPage1.AddObject("cbo_4c_CmbIpi", "ComboBox")
1358:         WITH loc_oPage1.cbo_4c_CmbIpi
1359:             .Top           = 263
1360:             .Left          = 136
1361:             .Width         = 82
1362:             .Height        = 23
1363:             .RowSourceType = 1
1364:             .RowSource     = "T,I,O"
1365:             .Style         = 2
1366:             .Value         = "T"
1367:             .FontName      = "Tahoma"
1368:             .FontSize      = 8
1369:             .Visible       = .T.
1370:         ENDWITH
1371: 
1372:         *-- Label: IPI Importacao
1373:         loc_oPage1.AddObject("lbl_4c_Label7", "Label")
1374:         WITH loc_oPage1.lbl_4c_Label7
1375:             .Caption   = "IPI Importa" + CHR(231) + CHR(227) + "o :"
1376:             .Top       = 267
1377:             .Left      = 296
1378:             .Width     = 81
1379:             .Height    = 15
1380:             .FontName  = "Tahoma"
1381:             .FontSize  = 8
1382:             .BackStyle = 0
1383:             .Visible   = .T.
1384:         ENDWITH
1385: 
1386:         *-- cmbIpiI - ipiimpors char(1) S/N
1387:         loc_oPage1.AddObject("cbo_4c_CmbIpiI", "ComboBox")
1388:         WITH loc_oPage1.cbo_4c_CmbIpiI
1389:             .Top           = 263
1390:             .Left          = 380
1391:             .Width         = 82
1392:             .Height        = 23
1393:             .RowSourceType = 1
1394:             .RowSource     = "S,N"
1395:             .Style         = 2
1396:             .Value         = "N"
1397:             .FontName      = "Tahoma"
1398:             .FontSize      = 8
1399:             .Visible       = .T.
1400:         ENDWITH
1401: 
1402:         *-- Label: Codigo IPI Sit. Trib.
1403:         loc_oPage1.AddObject("lbl_4c_Label30", "Label")
1404:         WITH loc_oPage1.lbl_4c_Label30
1405:             .Caption   = "C" + CHR(243) + "digo IPI Sit. Trib.:"
1406:             .Top       = 269
1407:             .Left      = 583
1408:             .Width     = 100
1409:             .Height    = 15
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .BackStyle = 0
1413:             .Visible   = .T.
1414:         ENDWITH
1415: 
1416:         *-- txt_4c_IPICST - ipicst char(2)
1417:         loc_oPage1.AddObject("txt_4c_IPICST", "TextBox")
1418:         WITH loc_oPage1.txt_4c_IPICST
1419:             .Top       = 266
1420:             .Left      = 691
1421:             .Width     = 26
1422:             .Height    = 23
1423:             .MaxLength = 2
1424:             .Value     = ""
1425:             .FontName  = "Tahoma"
1426:             .FontSize  = 8
1427:             .Visible   = .T.
1428:         ENDWITH
1429: 
1430:         *-- Label: Aliquota IPI
1431:         loc_oPage1.AddObject("lbl_4c_Label15", "Label")
1432:         WITH loc_oPage1.lbl_4c_Label15
1433:             .Caption   = "Al" + CHR(237) + "quota :"
1434:             .Top       = 293
1435:             .Left      = 84
1436:             .Width     = 48
1437:             .Height    = 15
1438:             .FontName  = "Tahoma"
1439:             .FontSize  = 8
1440:             .BackStyle = 0
1441:             .Visible   = .T.
1442:         ENDWITH
1443: 
1444:         *-- txt_4c_Aliqs - aliqipis numeric(4,2)
1445:         loc_oPage1.AddObject("txt_4c_Aliqs", "TextBox")
1446:         WITH loc_oPage1.txt_4c_Aliqs
1447:             .Top       = 289
1448:             .Left      = 136
1449:             .Width     = 82
1450:             .Height    = 23
1451:             .Value     = 0
1452:             .Format    = "N"
1453:             .InputMask = "99.99"
1454:             .FontName  = "Tahoma"
1455:             .FontSize  = 8
1456:             .Visible   = .T.
1457:         ENDWITH
1458: 
1459:         *-- Label: Retira IPI do Valor
1460:         loc_oPage1.AddObject("lbl_4c_Label32", "Label")
1461:         WITH loc_oPage1.lbl_4c_Label32
1462:             .Caption   = "Retira IPI do $ :"
1463:             .Top       = 293
1464:             .Left      = 298
1465:             .Width     = 79
1466:             .Height    = 15
1467:             .FontName  = "Tahoma"
1468:             .FontSize  = 8
1469:             .BackStyle = 0
1470:             .Visible   = .T.
1471:         ENDWITH
1472: 
1473:         *-- Combo7 - pontedescs numeric(1,0)
1474:         loc_oPage1.AddObject("cbo_4c_Combo7", "ComboBox")
1475:         WITH loc_oPage1.cbo_4c_Combo7
1476:             .Top           = 289
1477:             .Left          = 380
1478:             .Width         = 82
1479:             .Height        = 23
1480:             .RowSourceType = 1
1481:             .RowSource     = "0,1"
1482:             .Style         = 2
1483:             .Value         = "0"
1484:             .FontName      = "Tahoma"
1485:             .FontSize      = 8
1486:             .Visible       = .T.
1487:         ENDWITH
1488: 
1489:         *-- Label: Nao Creditado
1490:         loc_oPage1.AddObject("lbl_4c_Label20", "Label")
1491:         WITH loc_oPage1.lbl_4c_Label20
1492:             .Caption   = "N" + CHR(227) + "o Creditado :"
1493:             .Top       = 319
1494:             .Left      = 54
1495:             .Width     = 78
1496:             .Height    = 15
1497:             .FontName  = "Tahoma"
1498:             .FontSize  = 8
1499:             .BackStyle = 0
1500:             .Visible   = .T.
1501:         ENDWITH
1502: 
1503:         *-- Combo1 - ipincreds numeric(1,0)
1504:         loc_oPage1.AddObject("cbo_4c_Combo1", "ComboBox")
1505:         WITH loc_oPage1.cbo_4c_Combo1
1506:             .Top           = 315
1507:             .Left          = 136
1508:             .Width         = 82
1509:             .Height        = 23
1510:             .RowSourceType = 1
1511:             .RowSource     = "0,1"
1512:             .Style         = 2
1513:             .Value         = "0"
1514:             .FontName      = "Tahoma"
1515:             .FontSize      = 8
1516:             .Visible       = .T.
1517:         ENDWITH
1518: 
1519:         *-- Label: Acresc. na Base
1520:         loc_oPage1.AddObject("lbl_4c_Label17", "Label")
1521:         WITH loc_oPage1.lbl_4c_Label17
1522:             .Caption   = "Acr" + CHR(233) + "sc. na Base :"
1523:             .Top       = 319
1524:             .Left      = 291
1525:             .Width     = 86
1526:             .Height    = 15
1527:             .FontName  = "Tahoma"
1528:             .FontSize  = 8
1529:             .BackStyle = 0
1530:             .Visible   = .T.
1531:         ENDWITH
1532: 
1533:         *-- Combo2 - acresipis char(1) S/N
1534:         loc_oPage1.AddObject("cbo_4c_Combo2", "ComboBox")
1535:         WITH loc_oPage1.cbo_4c_Combo2
1536:             .Top           = 315
1537:             .Left          = 380
1538:             .Width         = 82
1539:             .Height        = 23
1540:             .RowSourceType = 1
1541:             .RowSource     = "S,N"
1542:             .Style         = 2
1543:             .Value         = "N"
1544:             .FontName      = "Tahoma"
1545:             .FontSize      = 8
1546:             .Visible       = .T.
1547:         ENDWITH
1548: 
1549:         *-- Label: Base de Calculo IPI
1550:         loc_oPage1.AddObject("lbl_4c_Label5", "Label")
1551:         WITH loc_oPage1.lbl_4c_Label5
1552:             .Caption   = "Base de C" + CHR(225) + "lculo :"
1553:             .Top       = 345
1554:             .Left      = 48
1555:             .Width     = 84
1556:             .Height    = 15
1557:             .FontName  = "Tahoma"
1558:             .FontSize  = 8
1559:             .BackStyle = 0
1560:             .Visible   = .T.
1561:         ENDWITH
1562: 
1563:         *-- CmbBIPI - bcipis char(1) (base calculo IPI)
1564:         loc_oPage1.AddObject("cbo_4c_CmbBIPI", "ComboBox")
1565:         WITH loc_oPage1.cbo_4c_CmbBIPI
1566:             .Top           = 341
1567:             .Left          = 136
1568:             .Width         = 196
1569:             .Height        = 24
1570:             .RowSourceType = 1
1571:             .RowSource     = "F,P,T,O"
1572:             .Style         = 2
1573:             .Value         = "P"
1574:             .FontName      = "Tahoma"
1575:             .FontSize      = 8
1576:             .Visible       = .T.
1577:         ENDWITH
1578: 
1579:         *-- Label: % (pbcipis)
1580:         loc_oPage1.AddObject("lbl_4c_Label9", "Label")
1581:         WITH loc_oPage1.lbl_4c_Label9
1582:             .Caption   = "%"
1583:             .Top       = 322
1584:             .Left      = 463
1585:             .Width     = 13
1586:             .Height    = 15
1587:             .FontName  = "Tahoma"
1588:             .FontSize  = 8
1589:             .BackStyle = 0
1590:             .Visible   = .T.
1591:         ENDWITH
1592: 
1593:         *-- txt_4c_BcIPI - pbcipis numeric(5,2)
1594:         loc_oPage1.AddObject("txt_4c_BcIPI", "TextBox")
1595:         WITH loc_oPage1.txt_4c_BcIPI
1596:             .Top       = 341
1597:             .Left      = 380
1598:             .Width     = 82
1599:             .Height    = 23
1600:             .Value     = 0
1601:             .Format    = "N"
1602:             .InputMask = "999.99"
1603:             .FontName  = "Tahoma"
1604:             .FontSize  = 8
1605:             .Visible   = .T.
1606:         ENDWITH
1607: 
1608:         *-- Label: IPI Sobre (frete/seguro/despesas)
1609:         loc_oPage1.AddObject("lbl_4c_Label16", "Label")
1610:         WITH loc_oPage1.lbl_4c_Label16
1611:             .Caption   = "IPI Sobre :"
1612:             .Top       = 395
1613:             .Left      = 75
1614:             .Width     = 54
1615:             .Height    = 15
1616:             .FontName  = "Tahoma"
1617:             .FontSize  = 8
1618:             .BackStyle = 0
1619:             .Visible   = .T.
1620:         ENDWITH
1621: 
1622:         *-- chk_4c_ObjFreteIPI - frtipis numeric(1,0)
1623:         loc_oPage1.AddObject("chk_4c_ObjFreteIPI", "CheckBox")
1624:         WITH loc_oPage1.chk_4c_ObjFreteIPI
1625:             .Caption   = "Frete"
1626:             .Top       = 395
1627:             .Left      = 137
1628:             .Width     = 44
1629:             .Height    = 15
1630:             .FontName  = "Tahoma"
1631:             .FontSize  = 8
1632:             .BackStyle = 0
1633:             .Value     = 0
1634:             .Visible   = .T.
1635:         ENDWITH
1636: 
1637:         *-- chk_4c_ObjSegIPI - segipis numeric(1,0)
1638:         loc_oPage1.AddObject("chk_4c_ObjSegIPI", "CheckBox")
1639:         WITH loc_oPage1.chk_4c_ObjSegIPI
1640:             .Caption   = "Seguro"
1641:             .Top       = 395
1642:             .Left      = 188
1643:             .Width     = 52
1644:             .Height    = 15
1645:             .FontName  = "Tahoma"
1646:             .FontSize  = 8
1647:             .BackStyle = 0
1648:             .Value     = 0
1649:             .Visible   = .T.
1650:         ENDWITH
1651: 
1652:         *-- chk_4c_ObjDespIPI - desipis numeric(1,0)
1653:         loc_oPage1.AddObject("chk_4c_ObjDespIPI", "CheckBox")
1654:         WITH loc_oPage1.chk_4c_ObjDespIPI
1655:             .Caption   = "Despesas Acess" + CHR(243) + "rias"
1656:             .Top       = 395
1657:             .Left      = 255
1658:             .Width     = 118
1659:             .Height    = 15
1660:             .FontName  = "Tahoma"
1661:             .FontSize  = 8
1662:             .BackStyle = 0
1663:             .Value     = 0
1664:             .Visible   = .T.
1665:         ENDWITH
1666: 
1667:         *-- Label: Calcula IPI Importacao Origem=2
1668:         loc_oPage1.AddObject("lbl_4c_Label18", "Label")
1669:         WITH loc_oPage1.lbl_4c_Label18
1670:             .Caption   = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
1671:             .Top       = 371
1672:             .Left      = 125
1673:             .Width     = 250
1674:             .Height    = 15
1675:             .FontName  = "Tahoma"
1676:             .FontSize  = 8
1677:             .BackStyle = 0
1678:             .Visible   = .T.
1679:         ENDWITH
1680: 
1681:         *-- Combo8 - ipiom2s char(1) S/N
1682:         loc_oPage1.AddObject("cbo_4c_Combo8", "ComboBox")
1683:         WITH loc_oPage1.cbo_4c_Combo8
1684:             .Top           = 367
1685:             .Left          = 380
1686:             .Width         = 82
1687:             .Height        = 23
1688:             .RowSourceType = 1
1689:             .RowSource     = "S,N"
1690:             .Style         = 2

*-- Linhas 1697 a 2112:
1697:         *-- === SECAO NF-e: PIS / COFINS / ISSQN / II ===
1698: 
1699:         *-- Label: Codigo PIS Sit. Trib.
1700:         loc_oPage1.AddObject("lbl_4c_Label33", "Label")
1701:         WITH loc_oPage1.lbl_4c_Label33
1702:             .Caption   = "C" + CHR(243) + "digo PIS Sit. Trib.:"
1703:             .Top       = 295
1704:             .Left      = 581
1705:             .Width     = 102
1706:             .Height    = 15
1707:             .FontName  = "Tahoma"
1708:             .FontSize  = 8
1709:             .BackStyle = 0
1710:             .Visible   = .T.
1711:         ENDWITH
1712: 
1713:         *-- txt_4c_PISCST - piscst char(2)
1714:         loc_oPage1.AddObject("txt_4c_PISCST", "TextBox")
1715:         WITH loc_oPage1.txt_4c_PISCST
1716:             .Top       = 291
1717:             .Left      = 691
1718:             .Width     = 26
1719:             .Height    = 23
1720:             .MaxLength = 2
1721:             .Value     = ""
1722:             .FontName  = "Tahoma"
1723:             .FontSize  = 8
1724:             .Visible   = .T.
1725:         ENDWITH
1726: 
1727:         *-- Label: Aliquota do PIS
1728:         loc_oPage1.AddObject("lbl_4c_Label39", "Label")
1729:         WITH loc_oPage1.lbl_4c_Label39
1730:             .Caption   = "Al" + CHR(237) + "quota do PIS :"
1731:             .Top       = 295
1732:             .Left      = 829
1733:             .Width     = 82
1734:             .Height    = 15
1735:             .FontName  = "Tahoma"
1736:             .FontSize  = 8
1737:             .BackStyle = 0
1738:             .Visible   = .T.
1739:         ENDWITH
1740: 
1741:         *-- txt_4c_AliqPIS - aliqpis numeric(5,2)
1742:         loc_oPage1.AddObject("txt_4c_AliqPIS", "TextBox")
1743:         WITH loc_oPage1.txt_4c_AliqPIS
1744:             .Top       = 291
1745:             .Left      = 916
1746:             .Width     = 52
1747:             .Height    = 23
1748:             .Value     = 0
1749:             .Format    = "N"
1750:             .InputMask = "999.99"
1751:             .FontName  = "Tahoma"
1752:             .FontSize  = 8
1753:             .Visible   = .T.
1754:         ENDWITH
1755: 
1756:         *-- Label: % (PIS)
1757:         loc_oPage1.AddObject("lbl_4c_Label40", "Label")
1758:         WITH loc_oPage1.lbl_4c_Label40
1759:             .Caption   = "%"
1760:             .Top       = 295
1761:             .Left      = 971
1762:             .Width     = 14
1763:             .Height    = 15
1764:             .FontName  = "Tahoma"
1765:             .FontSize  = 8
1766:             .BackStyle = 0
1767:             .Visible   = .T.
1768:         ENDWITH
1769: 
1770:         *-- Label: Codigo COFINS Sit. Trib.
1771:         loc_oPage1.AddObject("lbl_4c_Label34", "Label")
1772:         WITH loc_oPage1.lbl_4c_Label34
1773:             .Caption   = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
1774:             .Top       = 319
1775:             .Left      = 559
1776:             .Width     = 124
1777:             .Height    = 15
1778:             .FontName  = "Tahoma"
1779:             .FontSize  = 8
1780:             .BackStyle = 0
1781:             .Visible   = .T.
1782:         ENDWITH
1783: 
1784:         *-- txt_4c_COFCST - cofcst char(2)
1785:         loc_oPage1.AddObject("txt_4c_COFCST", "TextBox")
1786:         WITH loc_oPage1.txt_4c_COFCST
1787:             .Top       = 315
1788:             .Left      = 691
1789:             .Width     = 26
1790:             .Height    = 23
1791:             .MaxLength = 2
1792:             .Value     = ""
1793:             .FontName  = "Tahoma"
1794:             .FontSize  = 8
1795:             .Visible   = .T.
1796:         ENDWITH
1797: 
1798:         *-- Label: Aliquota do COFINS
1799:         loc_oPage1.AddObject("lbl_4c_Label41", "Label")
1800:         WITH loc_oPage1.lbl_4c_Label41
1801:             .Caption   = "Al" + CHR(237) + "quota do COFINS :"
1802:             .Top       = 319
1803:             .Left      = 807
1804:             .Width     = 104
1805:             .Height    = 15
1806:             .FontName  = "Tahoma"
1807:             .FontSize  = 8
1808:             .BackStyle = 0
1809:             .Visible   = .T.
1810:         ENDWITH
1811: 
1812:         *-- txt_4c_AliqCofins - aliqcofins numeric(5,2)
1813:         loc_oPage1.AddObject("txt_4c_AliqCofins", "TextBox")
1814:         WITH loc_oPage1.txt_4c_AliqCofins
1815:             .Top       = 315
1816:             .Left      = 916
1817:             .Width     = 52
1818:             .Height    = 23
1819:             .Value     = 0
1820:             .Format    = "N"
1821:             .InputMask = "999.99"
1822:             .FontName  = "Tahoma"
1823:             .FontSize  = 8
1824:             .Visible   = .T.
1825:         ENDWITH
1826: 
1827:         *-- Label: % (COFINS)
1828:         loc_oPage1.AddObject("lbl_4c_Label42", "Label")
1829:         WITH loc_oPage1.lbl_4c_Label42
1830:             .Caption   = "%"
1831:             .Top       = 319
1832:             .Left      = 971
1833:             .Width     = 14
1834:             .Height    = 15
1835:             .FontName  = "Tahoma"
1836:             .FontSize  = 8
1837:             .BackStyle = 0
1838:             .Visible   = .T.
1839:         ENDWITH
1840: 
1841:         *-- Label: Codigo ISSQN Lista Serv.
1842:         loc_oPage1.AddObject("lbl_4c_Label35", "Label")
1843:         WITH loc_oPage1.lbl_4c_Label35
1844:             .Caption   = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
1845:             .Top       = 343
1846:             .Left      = 556
1847:             .Width     = 127
1848:             .Height    = 15
1849:             .FontName  = "Tahoma"
1850:             .FontSize  = 8
1851:             .BackStyle = 0
1852:             .Visible   = .T.
1853:         ENDWITH
1854: 
1855:         *-- txt_4c_ISSQNL - issqnl char(5)
1856:         loc_oPage1.AddObject("txt_4c_ISSQNL", "TextBox")
1857:         WITH loc_oPage1.txt_4c_ISSQNL
1858:             .Top       = 339
1859:             .Left      = 691
1860:             .Width     = 40
1861:             .Height    = 23
1862:             .MaxLength = 5
1863:             .Value     = ""
1864:             .FontName  = "Tahoma"
1865:             .FontSize  = 8
1866:             .Visible   = .T.
1867:         ENDWITH
1868: 
1869:         *-- Label: Aliquota do ISSQN
1870:         loc_oPage1.AddObject("lbl_4c_Label44", "Label")
1871:         WITH loc_oPage1.lbl_4c_Label44
1872:             .Caption   = "Al" + CHR(237) + "quota do ISSQN :"
1873:             .Top       = 343
1874:             .Left      = 814
1875:             .Width     = 97
1876:             .Height    = 15
1877:             .FontName  = "Tahoma"
1878:             .FontSize  = 8
1879:             .BackStyle = 0
1880:             .Visible   = .T.
1881:         ENDWITH
1882: 
1883:         *-- txt_4c_AliqISSQN - aliqissqn numeric(5,2)
1884:         loc_oPage1.AddObject("txt_4c_AliqISSQN", "TextBox")
1885:         WITH loc_oPage1.txt_4c_AliqISSQN
1886:             .Top       = 339
1887:             .Left      = 916
1888:             .Width     = 52
1889:             .Height    = 23
1890:             .Value     = 0
1891:             .Format    = "N"
1892:             .InputMask = "999.99"
1893:             .FontName  = "Tahoma"
1894:             .FontSize  = 8
1895:             .Visible   = .T.
1896:         ENDWITH
1897: 
1898:         *-- Label: % (ISSQN)
1899:         loc_oPage1.AddObject("lbl_4c_Label45", "Label")
1900:         WITH loc_oPage1.lbl_4c_Label45
1901:             .Caption   = "%"
1902:             .Top       = 343
1903:             .Left      = 971
1904:             .Width     = 14
1905:             .Height    = 15
1906:             .FontName  = "Tahoma"
1907:             .FontSize  = 8
1908:             .BackStyle = 0
1909:             .Visible   = .T.
1910:         ENDWITH
1911: 
1912:         *-- Label: Codigo de Trib. do ISSQN
1913:         loc_oPage1.AddObject("lbl_4c_Label43", "Label")
1914:         WITH loc_oPage1.lbl_4c_Label43
1915:             .Caption   = "C" + CHR(243) + "digo de Trib. do ISSQN:"
1916:             .Top       = 369
1917:             .Left      = 555
1918:             .Width     = 128
1919:             .Height    = 15
1920:             .FontName  = "Tahoma"
1921:             .FontSize  = 8
1922:             .BackStyle = 0
1923:             .Visible   = .T.
1924:         ENDWITH
1925: 
1926:         *-- Fwoption1 - ctissqn numeric(1,0), 5 buttons (0-4)
1927:         loc_oPage1.AddObject("obj_4c_Fwoption1", "OptionGroup")
1928:         WITH loc_oPage1.obj_4c_Fwoption1
1929:             .Top         = 368
1930:             .Left        = 686
1931:             .Width       = 297
1932:             .Height      = 34
1933:             .ButtonCount = 5
1934:             .BackStyle   = 0
1935:             .Value       = 1
1936:             .Visible     = .T.
1937: 
1938:             WITH .Buttons(1)
1939:                 .Caption   = "0"
1940:                 .Width     = 55
1941:                 .Height    = 17
1942:                 .Left      = 0
1943:                 .Top       = 0
1944:                 .BackStyle = 0
1945:                 .Visible   = .T.
1946:             ENDWITH
1947: 
1948:             WITH .Buttons(2)
1949:                 .Caption   = "1"
1950:                 .Width     = 55
1951:                 .Height    = 17
1952:                 .Left      = 57
1953:                 .Top       = 0
1954:                 .BackStyle = 0
1955:                 .FontName  = "Tahoma"
1956:                 .FontSize  = 8
1957:                 .Visible   = .T.
1958:             ENDWITH
1959: 
1960:             WITH .Buttons(3)
1961:                 .Caption   = "2"
1962:                 .Width     = 55
1963:                 .Height    = 17
1964:                 .Left      = 114
1965:                 .Top       = 0
1966:                 .BackStyle = 0
1967:                 .FontName  = "Tahoma"
1968:                 .FontSize  = 8
1969:                 .Visible   = .T.
1970:             ENDWITH
1971: 
1972:             WITH .Buttons(4)
1973:                 .Caption   = "3"
1974:                 .Width     = 55
1975:                 .Height    = 17
1976:                 .Left      = 171
1977:                 .Top       = 0
1978:                 .BackStyle = 0
1979:                 .FontName  = "Tahoma"
1980:                 .FontSize  = 8
1981:                 .Visible   = .T.
1982:             ENDWITH
1983: 
1984:             WITH .Buttons(5)
1985:                 .Caption   = "4"
1986:                 .Width     = 55
1987:                 .Height    = 17
1988:                 .Left      = 228
1989:                 .Top       = 0
1990:                 .BackStyle = 0
1991:                 .FontName  = "Tahoma"
1992:                 .FontSize  = 8
1993:                 .Visible   = .T.
1994:             ENDWITH
1995:         ENDWITH
1996: 
1997:         *-- Label: Informa Retencao de Trib.
1998:         loc_oPage1.AddObject("lbl_4c_Label46", "Label")
1999:         WITH loc_oPage1.lbl_4c_Label46
2000:             .Caption   = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
2001:             .Top       = 404
2002:             .Left      = 550
2003:             .Width     = 133
2004:             .Height    = 15
2005:             .FontName  = "Tahoma"
2006:             .FontSize  = 8
2007:             .BackStyle = 0
2008:             .Visible   = .T.
2009:         ENDWITH
2010: 
2011:         *-- Fwoption2 - rettribs numeric(1,0), 2 buttons Sim/Nao
2012:         loc_oPage1.AddObject("obj_4c_Fwoption2", "OptionGroup")
2013:         WITH loc_oPage1.obj_4c_Fwoption2
2014:             .Top         = 399
2015:             .Left        = 686
2016:             .Width       = 95
2017:             .Height      = 25
2018:             .ButtonCount = 2
2019:             .BackStyle   = 0
2020:             .Value       = 2
2021:             .Visible     = .T.
2022: 
2023:             WITH .Buttons(1)
2024:                 .Caption   = "Sim"
2025:                 .Width     = 44
2026:                 .Height    = 17
2027:                 .Left      = 0
2028:                 .Top       = 0
2029:                 .BackStyle = 0
2030:                 .Visible   = .T.
2031:             ENDWITH
2032: 
2033:             WITH .Buttons(2)
2034:                 .Caption   = "N" + CHR(227) + "o"
2035:                 .Width     = 44
2036:                 .Height    = 17
2037:                 .Left      = 46
2038:                 .Top       = 0
2039:                 .BackStyle = 0
2040:                 .FontName  = "Tahoma"
2041:                 .FontSize  = 8
2042:                 .Visible   = .T.
2043:             ENDWITH
2044:         ENDWITH
2045: 
2046:         *-- Label: Aliquota do II
2047:         loc_oPage1.AddObject("lbl_4c_Label47", "Label")
2048:         WITH loc_oPage1.lbl_4c_Label47
2049:             .Caption   = "Al" + CHR(237) + "quota do II :"
2050:             .Top       = 404
2051:             .Left      = 839
2052:             .Width     = 74
2053:             .Height    = 15
2054:             .FontName  = "Tahoma"
2055:             .FontSize  = 8
2056:             .BackStyle = 0
2057:             .Visible   = .T.
2058:         ENDWITH
2059: 
2060:         *-- txt_4c_AliqII - aliqii numeric(5,2)
2061:         loc_oPage1.AddObject("txt_4c_AliqII", "TextBox")
2062:         WITH loc_oPage1.txt_4c_AliqII
2063:             .Top       = 400
2064:             .Left      = 916
2065:             .Width     = 52
2066:             .Height    = 23
2067:             .Value     = 0
2068:             .Format    = "N"
2069:             .InputMask = "999.99"
2070:             .FontName  = "Tahoma"
2071:             .FontSize  = 8
2072:             .Visible   = .T.
2073:         ENDWITH
2074: 
2075:         *-- Label: % (II)
2076:         loc_oPage1.AddObject("lbl_4c_Label48", "Label")
2077:         WITH loc_oPage1.lbl_4c_Label48
2078:             .Caption   = "%"
2079:             .Top       = 404
2080:             .Left      = 971
2081:             .Width     = 13
2082:             .Height    = 15
2083:             .FontName  = "Tahoma"
2084:             .FontSize  = 8
2085:             .BackStyle = 0
2086:             .Visible   = .T.
2087:         ENDWITH
2088: 
2089:         *-- Label: Enquadramento IPI
2090:         loc_oPage1.AddObject("lbl_4c_Label50", "Label")
2091:         WITH loc_oPage1.lbl_4c_Label50
2092:             .Caption   = "Enquadramento IPI:"
2093:             .Top       = 427
2094:             .Left      = 583
2095:             .Width     = 99
2096:             .Height    = 15
2097:             .FontName  = "Tahoma"
2098:             .FontSize  = 8
2099:             .BackStyle = 0
2100:             .Visible   = .T.
2101:         ENDWITH
2102: 
2103:         *-- txt_4c_Enqipi - ipienq char(3)
2104:         loc_oPage1.AddObject("txt_4c_Enqipi", "TextBox")
2105:         WITH loc_oPage1.txt_4c_Enqipi
2106:             .Top       = 424
2107:             .Left      = 691
2108:             .Width     = 26
2109:             .Height    = 23
2110:             .MaxLength = 3
2111:             .Value     = ""
2112:             .FontName  = "Tahoma"

*-- Linhas 2135 a 2966:
2135:         *-- Separador secoes
2136:         loc_oPg2.AddObject("shp_4c_Shp03", "Shape")
2137:         WITH loc_oPg2.shp_4c_Shp03
2138:             .Top         = 211
2139:             .Left        = 5
2140:             .Width       = 984
2141:             .Height      = 1
2142:             .BackColor   = RGB(128, 128, 128)
2143:             .BorderColor = RGB(128, 128, 128)
2144:             .Visible     = .T.
2145:         ENDWITH
2146: 
2147:         *-- Label: Integracao Contabil (titulo secao)
2148:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
2149:         WITH loc_oPg2.lbl_4c_Label7
2150:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
2151:             .Top       = 6
2152:             .Left      = 15
2153:             .Width     = 114
2154:             .Height    = 15
2155:             .FontName  = "Tahoma"
2156:             .FontSize  = 8
2157:             .FontBold  = .T.
2158:             .BackStyle = 0
2159:             .Visible   = .T.
2160:         ENDWITH
2161: 
2162:         *-- Label: Valor Contabil
2163:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
2164:         WITH loc_oPg2.lbl_4c_Label10
2165:             .Caption   = "Valor Cont" + CHR(225) + "bil :"
2166:             .Top       = 34
2167:             .Left      = 82
2168:             .Width     = 75
2169:             .Height    = 15
2170:             .FontName  = "Tahoma"
2171:             .FontSize  = 8
2172:             .BackStyle = 0
2173:             .Visible   = .T.
2174:         ENDWITH
2175: 
2176:         *-- Label: DB / CR (Valor Contabil)
2177:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
2178:         WITH loc_oPg2.lbl_4c_Label13
2179:             .Caption   = "DB"
2180:             .Top       = 34
2181:             .Left      = 243
2182:             .Width     = 15
2183:             .Height    = 15
2184:             .FontName  = "Tahoma"
2185:             .FontSize  = 8
2186:             .BackStyle = 0
2187:             .Visible   = .T.
2188:         ENDWITH
2189: 
2190:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
2191:         WITH loc_oPg2.lbl_4c_Label14
2192:             .Caption   = "CR"
2193:             .Top       = 34
2194:             .Left      = 344
2195:             .Width     = 16
2196:             .Height    = 15
2197:             .FontName  = "Tahoma"
2198:             .FontSize  = 8
2199:             .BackStyle = 0
2200:             .Visible   = .T.
2201:         ENDWITH
2202: 
2203:         *-- txt_4c_Vrcds - contvcds char(9)
2204:         loc_oPg2.AddObject("txt_4c_Vrcds", "TextBox")
2205:         WITH loc_oPg2.txt_4c_Vrcds
2206:             .Top       = 30
2207:             .Left      = 162
2208:             .Width     = 73
2209:             .Height    = 24
2210:             .MaxLength = 9
2211:             .Value     = ""
2212:             .FontName  = "Tahoma"
2213:             .FontSize  = 8
2214:             .Visible   = .T.
2215:         ENDWITH
2216: 
2217:         *-- txt_4c_Vrccs - contvccs char(9)
2218:         loc_oPg2.AddObject("txt_4c_Vrccs", "TextBox")
2219:         WITH loc_oPg2.txt_4c_Vrccs
2220:             .Top       = 30
2221:             .Left      = 265
2222:             .Width     = 73
2223:             .Height    = 24
2224:             .MaxLength = 9
2225:             .Value     = ""
2226:             .FontName  = "Tahoma"
2227:             .FontSize  = 8
2228:             .Visible   = .T.
2229:         ENDWITH
2230: 
2231:         *-- Label: IPI
2232:         loc_oPg2.AddObject("lbl_4c_Label11", "Label")
2233:         WITH loc_oPg2.lbl_4c_Label11
2234:             .Caption   = "IPI :"
2235:             .Top       = 60
2236:             .Left      = 134
2237:             .Width     = 23
2238:             .Height    = 15
2239:             .FontName  = "Tahoma"
2240:             .FontSize  = 8
2241:             .BackStyle = 0
2242:             .Visible   = .T.
2243:         ENDWITH
2244: 
2245:         *-- Label: DB / CR (IPI)
2246:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
2247:         WITH loc_oPg2.lbl_4c_Label15
2248:             .Caption   = "DB"
2249:             .Top       = 60
2250:             .Left      = 243
2251:             .Width     = 15
2252:             .Height    = 15
2253:             .FontName  = "Tahoma"
2254:             .FontSize  = 8
2255:             .BackStyle = 0
2256:             .Visible   = .T.
2257:         ENDWITH
2258: 
2259:         loc_oPg2.AddObject("lbl_4c_Label16", "Label")
2260:         WITH loc_oPg2.lbl_4c_Label16
2261:             .Caption   = "CR"
2262:             .Top       = 60
2263:             .Left      = 344
2264:             .Width     = 16
2265:             .Height    = 15
2266:             .FontName  = "Tahoma"
2267:             .FontSize  = 8
2268:             .BackStyle = 0
2269:             .Visible   = .T.
2270:         ENDWITH
2271: 
2272:         *-- txt_4c_Ipids - contipds char(9)
2273:         loc_oPg2.AddObject("txt_4c_Ipids", "TextBox")
2274:         WITH loc_oPg2.txt_4c_Ipids
2275:             .Top       = 56
2276:             .Left      = 162
2277:             .Width     = 73
2278:             .Height    = 24
2279:             .MaxLength = 9
2280:             .Value     = ""
2281:             .FontName  = "Tahoma"
2282:             .FontSize  = 8
2283:             .Visible   = .T.
2284:         ENDWITH
2285: 
2286:         *-- txt_4c_Ipics - contipcs char(9)
2287:         loc_oPg2.AddObject("txt_4c_Ipics", "TextBox")
2288:         WITH loc_oPg2.txt_4c_Ipics
2289:             .Top       = 56
2290:             .Left      = 265
2291:             .Width     = 73
2292:             .Height    = 24
2293:             .MaxLength = 9
2294:             .Value     = ""
2295:             .FontName  = "Tahoma"
2296:             .FontSize  = 8
2297:             .Visible   = .T.
2298:         ENDWITH
2299: 
2300:         *-- Label: ICMS
2301:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
2302:         WITH loc_oPg2.lbl_4c_Label12
2303:             .Caption   = "ICMS :"
2304:             .Top       = 86
2305:             .Left      = 123
2306:             .Width     = 34
2307:             .Height    = 15
2308:             .FontName  = "Tahoma"
2309:             .FontSize  = 8
2310:             .BackStyle = 0
2311:             .Visible   = .T.
2312:         ENDWITH
2313: 
2314:         *-- Label: DB / CR (ICMS)
2315:         loc_oPg2.AddObject("lbl_4c_Label17", "Label")
2316:         WITH loc_oPg2.lbl_4c_Label17
2317:             .Caption   = "DB"
2318:             .Top       = 86
2319:             .Left      = 243
2320:             .Width     = 15
2321:             .Height    = 15
2322:             .FontName  = "Tahoma"
2323:             .FontSize  = 8
2324:             .BackStyle = 0
2325:             .Visible   = .T.
2326:         ENDWITH
2327: 
2328:         loc_oPg2.AddObject("lbl_4c_Label18", "Label")
2329:         WITH loc_oPg2.lbl_4c_Label18
2330:             .Caption   = "CR"
2331:             .Top       = 86
2332:             .Left      = 344
2333:             .Width     = 16
2334:             .Height    = 15
2335:             .FontName  = "Tahoma"
2336:             .FontSize  = 8
2337:             .BackStyle = 0
2338:             .Visible   = .T.
2339:         ENDWITH
2340: 
2341:         *-- txt_4c_Icmds - conticds char(9)
2342:         loc_oPg2.AddObject("txt_4c_Icmds", "TextBox")
2343:         WITH loc_oPg2.txt_4c_Icmds
2344:             .Top       = 82
2345:             .Left      = 162
2346:             .Width     = 73
2347:             .Height    = 24
2348:             .MaxLength = 9
2349:             .Value     = ""
2350:             .FontName  = "Tahoma"
2351:             .FontSize  = 8
2352:             .Visible   = .T.
2353:         ENDWITH
2354: 
2355:         *-- txt_4c_Icmcs - conticcs char(9)
2356:         loc_oPg2.AddObject("txt_4c_Icmcs", "TextBox")
2357:         WITH loc_oPg2.txt_4c_Icmcs
2358:             .Top       = 82
2359:             .Left      = 265
2360:             .Width     = 73
2361:             .Height    = 24
2362:             .MaxLength = 9
2363:             .Value     = ""
2364:             .FontName  = "Tahoma"
2365:             .FontSize  = 8
2366:             .Visible   = .T.
2367:         ENDWITH
2368: 
2369:         *-- Label: Conta de Frete
2370:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
2371:         WITH loc_oPg2.lbl_4c_Label3
2372:             .Caption   = "Conta de Frete :"
2373:             .Top       = 112
2374:             .Left      = 75
2375:             .Width     = 82
2376:             .Height    = 15
2377:             .FontName  = "Tahoma"
2378:             .FontSize  = 8
2379:             .BackStyle = 0
2380:             .Visible   = .T.
2381:         ENDWITH
2382: 
2383:         *-- txt_4c_ContFrt - contfrt char(9)
2384:         loc_oPg2.AddObject("txt_4c_ContFrt", "TextBox")
2385:         WITH loc_oPg2.txt_4c_ContFrt
2386:             .Top       = 108
2387:             .Left      = 162
2388:             .Width     = 73
2389:             .Height    = 24
2390:             .MaxLength = 9
2391:             .Value     = ""
2392:             .FontName  = "Tahoma"
2393:             .FontSize  = 8
2394:             .Visible   = .T.
2395:         ENDWITH
2396: 
2397:         *-- Label: Conta de Seguro
2398:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
2399:         WITH loc_oPg2.lbl_4c_Label4
2400:             .Caption   = "Conta de Seguro :"
2401:             .Top       = 138
2402:             .Left      = 67
2403:             .Width     = 90
2404:             .Height    = 15
2405:             .FontName  = "Tahoma"
2406:             .FontSize  = 8
2407:             .BackStyle = 0
2408:             .Visible   = .T.
2409:         ENDWITH
2410: 
2411:         *-- txt_4c_ContSeg - contseg char(9)
2412:         loc_oPg2.AddObject("txt_4c_ContSeg", "TextBox")
2413:         WITH loc_oPg2.txt_4c_ContSeg
2414:             .Top       = 134
2415:             .Left      = 162
2416:             .Width     = 73
2417:             .Height    = 24
2418:             .MaxLength = 9
2419:             .Value     = ""
2420:             .FontName  = "Tahoma"
2421:             .FontSize  = 8
2422:             .Visible   = .T.
2423:         ENDWITH
2424: 
2425:         *-- Label: Conta de Despesas
2426:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
2427:         WITH loc_oPg2.lbl_4c_Label5
2428:             .Caption   = "Conta de Despesas :"
2429:             .Top       = 164
2430:             .Left      = 55
2431:             .Width     = 102
2432:             .Height    = 15
2433:             .FontName  = "Tahoma"
2434:             .FontSize  = 8
2435:             .BackStyle = 0
2436:             .Visible   = .T.
2437:         ENDWITH
2438: 
2439:         *-- txt_4c_ContDa - contda char(9)
2440:         loc_oPg2.AddObject("txt_4c_ContDa", "TextBox")
2441:         WITH loc_oPg2.txt_4c_ContDa
2442:             .Top       = 160
2443:             .Left      = 162
2444:             .Width     = 73
2445:             .Height    = 24
2446:             .MaxLength = 9
2447:             .Value     = ""
2448:             .FontName  = "Tahoma"
2449:             .FontSize  = 8
2450:             .Visible   = .T.
2451:         ENDWITH
2452: 
2453:         *-- Label: Descricao na Integracao
2454:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
2455:         WITH loc_oPg2.lbl_4c_Label21
2456:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
2457:             .Top       = 31
2458:             .Left      = 511
2459:             .Width     = 126
2460:             .Height    = 15
2461:             .FontName  = "Tahoma"
2462:             .FontSize  = 8
2463:             .BackStyle = 0
2464:             .Visible   = .T.
2465:         ENDWITH
2466: 
2467:         *-- cbo_4c_Combo2 - pontedescs numeric(1,0): ListIndex 1=Sim-Descricao, 2=Nao-Nenhuma, 3=Sim-Obs.
2468:         loc_oPg2.AddObject("cbo_4c_Combo2", "ComboBox")
2469:         WITH loc_oPg2.cbo_4c_Combo2
2470:             .Top           = 27
2471:             .Left          = 642
2472:             .Width         = 199
2473:             .Height        = 25
2474:             .RowSourceType = 1
2475:             .RowSource     = "Sim-Descri" + CHR(231) + CHR(227) + "o CFOP,N" + CHR(227) + "o-Nenhuma,Sim-Obs. Opera" + CHR(231) + CHR(227) + "o"
2476:             .Style         = 2
2477:             .Value         = "N" + CHR(227) + "o-Nenhuma"
2478:             .FontName      = "Tahoma"
2479:             .FontSize      = 8
2480:             .Visible       = .T.
2481:         ENDWITH
2482: 
2483:         *-- Label: Pega Conta Contabil da NF
2484:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
2485:         WITH loc_oPg2.lbl_4c_Label8
2486:             .Caption   = "Pega Conta Cont" + CHR(225) + "bil da NF :"
2487:             .Top       = 57
2488:             .Left      = 499
2489:             .Width     = 138
2490:             .Height    = 15
2491:             .FontName  = "Tahoma"
2492:             .FontSize  = 8
2493:             .BackStyle = 0
2494:             .Visible   = .T.
2495:         ENDWITH
2496: 
2497:         *-- cbo_4c_CmbFixa - contconts char(1): S=Sim(NF), N=Nao(CFOP), C=C.C.
2498:         loc_oPg2.AddObject("cbo_4c_CmbFixa", "ComboBox")
2499:         WITH loc_oPg2.cbo_4c_CmbFixa
2500:             .Top           = 53
2501:             .Left          = 642
2502:             .Width         = 132
2503:             .Height        = 25
2504:             .RowSourceType = 1
2505:             .RowSource     = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
2506:             .Style         = 2
2507:             .Value         = "N" + CHR(227) + "o (CFOP)"
2508:             .FontName      = "Tahoma"
2509:             .FontSize      = 8
2510:             .Visible       = .T.
2511:         ENDWITH
2512: 
2513:         *-- Label: Agrupa CFO na Integracao
2514:         loc_oPg2.AddObject("lbl_4c_Label29", "Label")
2515:         WITH loc_oPg2.lbl_4c_Label29
2516:             .Caption   = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
2517:             .Top       = 84
2518:             .Left      = 498
2519:             .Width     = 139
2520:             .Height    = 15
2521:             .FontName  = "Tahoma"
2522:             .FontSize  = 8
2523:             .BackStyle = 0
2524:             .Visible   = .T.
2525:         ENDWITH
2526: 
2527:         *-- obj_4c_OptAgrupas - agrupas numeric(1,0), 2 buttons Sim/Nao
2528:         loc_oPg2.AddObject("obj_4c_OptAgrupas", "OptionGroup")
2529:         WITH loc_oPg2.obj_4c_OptAgrupas
2530:             .Top         = 79
2531:             .Left        = 638
2532:             .Width       = 94
2533:             .Height      = 27
2534:             .ButtonCount = 2
2535:             .BackStyle   = 0
2536:             .Value       = 2
2537:             .Visible     = .T.
2538: 
2539:             WITH .Buttons(1)
2540:                 .Caption   = "Sim"
2541:                 .Width     = 43
2542:                 .Height    = 17
2543:                 .Left      = 0
2544:                 .Top       = 0
2545:                 .BackStyle = 0
2546:                 .Visible   = .T.
2547:             ENDWITH
2548: 
2549:             WITH .Buttons(2)
2550:                 .Caption   = "N" + CHR(227) + "o"
2551:                 .Width     = 43
2552:                 .Height    = 17
2553:                 .Left      = 45
2554:                 .Top       = 0
2555:                 .BackStyle = 0
2556:                 .FontName  = "Tahoma"
2557:                 .FontSize  = 8
2558:                 .Visible   = .T.
2559:             ENDWITH
2560:         ENDWITH
2561: 
2562:         *-- Label: Integracao Zerada
2563:         loc_oPg2.AddObject("lbl_4c_Label30", "Label")
2564:         WITH loc_oPg2.lbl_4c_Label30
2565:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
2566:             .Top       = 108
2567:             .Left      = 538
2568:             .Width     = 99
2569:             .Height    = 15
2570:             .FontName  = "Tahoma"
2571:             .FontSize  = 8
2572:             .BackStyle = 0
2573:             .Visible   = .T.
2574:         ENDWITH
2575: 
2576:         *-- obj_4c_OptZeradas - zeradas numeric(1,0), 2 buttons Sim/Nao
2577:         loc_oPg2.AddObject("obj_4c_OptZeradas", "OptionGroup")
2578:         WITH loc_oPg2.obj_4c_OptZeradas
2579:             .Top         = 103
2580:             .Left        = 638
2581:             .Width       = 94
2582:             .Height      = 27
2583:             .ButtonCount = 2
2584:             .BackStyle   = 0
2585:             .Value       = 2
2586:             .Visible     = .T.
2587: 
2588:             WITH .Buttons(1)
2589:                 .Caption   = "Sim"
2590:                 .Width     = 43
2591:                 .Height    = 17
2592:                 .Left      = 0
2593:                 .Top       = 0
2594:                 .BackStyle = 0
2595:                 .Visible   = .T.
2596:             ENDWITH
2597: 
2598:             WITH .Buttons(2)
2599:                 .Caption   = "N" + CHR(227) + "o"
2600:                 .Width     = 43
2601:                 .Height    = 17
2602:                 .Left      = 45
2603:                 .Top       = 0
2604:                 .BackStyle = 0
2605:                 .FontName  = "Tahoma"
2606:                 .FontSize  = 8
2607:                 .Visible   = .T.
2608:             ENDWITH
2609:         ENDWITH
2610: 
2611:         *-- Label: Data Lancamento Contabil
2612:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
2613:         WITH loc_oPg2.lbl_4c_Label1
2614:             .Caption   = "Data Lan" + CHR(231) + "amento Contabil :"
2615:             .Top       = 132
2616:             .Left      = 502
2617:             .Width     = 135
2618:             .Height    = 15
2619:             .FontName  = "Tahoma"
2620:             .FontSize  = 8
2621:             .BackStyle = 0
2622:             .Visible   = .T.
2623:         ENDWITH
2624: 
2625:         *-- obj_4c_Fwoption1 - dtintfis numeric(1,0): 1=Data Integracao, 2=Data N.F.
2626:         loc_oPg2.AddObject("obj_4c_Fwoption1", "OptionGroup")
2627:         WITH loc_oPg2.obj_4c_Fwoption1
2628:             .Top         = 127
2629:             .Left        = 638
2630:             .Width       = 192
2631:             .Height      = 25
2632:             .ButtonCount = 2
2633:             .BackStyle   = 0
2634:             .Value       = 1
2635:             .Visible     = .T.
2636: 
2637:             WITH .Buttons(1)
2638:                 .Caption   = "Data Integra" + CHR(231) + CHR(227) + "o"
2639:                 .Width     = 97
2640:                 .Height    = 17
2641:                 .Left      = 0
2642:                 .Top       = 0
2643:                 .BackStyle = 0
2644:                 .Visible   = .T.
2645:             ENDWITH
2646: 
2647:             WITH .Buttons(2)
2648:                 .Caption   = "Data N.F."
2649:                 .Width     = 65
2650:                 .Height    = 17
2651:                 .Left      = 122
2652:                 .Top       = 0
2653:                 .BackStyle = 0
2654:                 .FontName  = "Tahoma"
2655:                 .FontSize  = 8
2656:                 .Visible   = .T.
2657:             ENDWITH
2658:         ENDWITH
2659: 
2660:         *-- Label: Utilizar variacao de CFOP na Integracao
2661:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
2662:         WITH loc_oPg2.lbl_4c_Label2
2663:             .Caption   = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
2664:             .Top       = 156
2665:             .Left      = 427
2666:             .Width     = 210
2667:             .Height    = 15
2668:             .FontName  = "Tahoma"
2669:             .FontSize  = 8
2670:             .BackStyle = 0
2671:             .Visible   = .T.
2672:         ENDWITH
2673: 
2674:         *-- obj_4c_Optutilvars - utilvars numeric(1,0), 2 buttons Sim/Nao
2675:         loc_oPg2.AddObject("obj_4c_Optutilvars", "OptionGroup")
2676:         WITH loc_oPg2.obj_4c_Optutilvars
2677:             .Top         = 150
2678:             .Left        = 638
2679:             .Width       = 94
2680:             .Height      = 27
2681:             .ButtonCount = 2
2682:             .BackStyle   = 0
2683:             .Value       = 2
2684:             .Visible     = .T.
2685: 
2686:             WITH .Buttons(1)
2687:                 .Caption   = "Sim"
2688:                 .Width     = 43
2689:                 .Height    = 17
2690:                 .Left      = 0
2691:                 .Top       = 0
2692:                 .BackStyle = 0
2693:                 .Visible   = .T.
2694:             ENDWITH
2695: 
2696:             WITH .Buttons(2)
2697:                 .Caption   = "N" + CHR(227) + "o"
2698:                 .Width     = 43
2699:                 .Height    = 17
2700:                 .Left      = 45
2701:                 .Top       = 0
2702:                 .BackStyle = 0
2703:                 .FontName  = "Tahoma"
2704:                 .FontSize  = 8
2705:                 .Visible   = .T.
2706:             ENDWITH
2707:         ENDWITH
2708: 
2709:         *-- Label: Integracao Fiscal (titulo secao)
2710:         loc_oPg2.AddObject("lbl_4c_Label35", "Label")
2711:         WITH loc_oPg2.lbl_4c_Label35
2712:             .Caption   = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
2713:             .Top       = 217
2714:             .Left      = 18
2715:             .Width     = 99
2716:             .Height    = 15
2717:             .FontName  = "Tahoma"
2718:             .FontSize  = 8
2719:             .FontBold  = .T.
2720:             .BackStyle = 0
2721:             .Visible   = .T.
2722:         ENDWITH
2723: 
2724:         *-- Label: Integrar Valor Contabil
2725:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
2726:         WITH loc_oPg2.lbl_4c_Label6
2727:             .Caption   = "Integrar Valor Cont" + CHR(225) + "bil :"
2728:             .Top       = 239
2729:             .Left      = 114
2730:             .Width     = 118
2731:             .Height    = 15
2732:             .FontName  = "Tahoma"
2733:             .FontSize  = 8
2734:             .BackStyle = 0
2735:             .Visible   = .T.
2736:         ENDWITH
2737: 
2738:         *-- obj_4c_Fwoption2 - intvlrcont numeric(1,0), 2 buttons Sim/Nao
2739:         loc_oPg2.AddObject("obj_4c_Fwoption2", "OptionGroup")
2740:         WITH loc_oPg2.obj_4c_Fwoption2
2741:             .Top         = 233
2742:             .Left        = 231
2743:             .Width       = 94
2744:             .Height      = 27
2745:             .ButtonCount = 2
2746:             .BackStyle   = 0
2747:             .Value       = 2
2748:             .Visible     = .T.
2749: 
2750:             WITH .Buttons(1)
2751:                 .Caption   = "Sim"
2752:                 .Width     = 43
2753:                 .Height    = 17
2754:                 .Left      = 0
2755:                 .Top       = 0
2756:                 .BackStyle = 0
2757:                 .Visible   = .T.
2758:             ENDWITH
2759: 
2760:             WITH .Buttons(2)
2761:                 .Caption   = "N" + CHR(227) + "o"
2762:                 .Width     = 43
2763:                 .Height    = 17
2764:                 .Left      = 45
2765:                 .Top       = 0
2766:                 .BackStyle = 0
2767:                 .FontName  = "Tahoma"
2768:                 .FontSize  = 8
2769:                 .Visible   = .T.
2770:             ENDWITH
2771:         ENDWITH
2772: 
2773:         *-- Label: Integrar Valores Icms
2774:         loc_oPg2.AddObject("lbl_4c_Label33", "Label")
2775:         WITH loc_oPg2.lbl_4c_Label33
2776:             .Caption   = "Integrar Valores Icms :"
2777:             .Top       = 259
2778:             .Left      = 120
2779:             .Width     = 112
2780:             .Height    = 15
2781:             .FontName  = "Tahoma"
2782:             .FontSize  = 8
2783:             .BackStyle = 0
2784:             .Visible   = .T.
2785:         ENDWITH
2786: 
2787:         *-- obj_4c_Fwoption3 - intvlricms numeric(1,0), 2 buttons Sim/Nao
2788:         loc_oPg2.AddObject("obj_4c_Fwoption3", "OptionGroup")
2789:         WITH loc_oPg2.obj_4c_Fwoption3
2790:             .Top         = 253
2791:             .Left        = 231
2792:             .Width       = 94
2793:             .Height      = 27
2794:             .ButtonCount = 2
2795:             .BackStyle   = 0
2796:             .Value       = 2
2797:             .Visible     = .T.
2798: 
2799:             WITH .Buttons(1)
2800:                 .Caption   = "Sim"
2801:                 .Width     = 43
2802:                 .Height    = 17
2803:                 .Left      = 0
2804:                 .Top       = 0
2805:                 .BackStyle = 0
2806:                 .Visible   = .T.
2807:             ENDWITH
2808: 
2809:             WITH .Buttons(2)
2810:                 .Caption   = "N" + CHR(227) + "o"
2811:                 .Width     = 43
2812:                 .Height    = 17
2813:                 .Left      = 45
2814:                 .Top       = 0
2815:                 .BackStyle = 0
2816:                 .FontName  = "Tahoma"
2817:                 .FontSize  = 8
2818:                 .Visible   = .T.
2819:             ENDWITH
2820:         ENDWITH
2821: 
2822:         *-- Label: Integrar Valores Ipi
2823:         loc_oPg2.AddObject("lbl_4c_Label34", "Label")
2824:         WITH loc_oPg2.lbl_4c_Label34
2825:             .Caption   = "Integrar Valores Ipi :"
2826:             .Top       = 278
2827:             .Left      = 130
2828:             .Width     = 102
2829:             .Height    = 15
2830:             .FontName  = "Tahoma"
2831:             .FontSize  = 8
2832:             .BackStyle = 0
2833:             .Visible   = .T.
2834:         ENDWITH
2835: 
2836:         *-- obj_4c_Fwoption4 - intvlripi numeric(1,0), 2 buttons Sim/Nao
2837:         loc_oPg2.AddObject("obj_4c_Fwoption4", "OptionGroup")
2838:         WITH loc_oPg2.obj_4c_Fwoption4
2839:             .Top         = 272
2840:             .Left        = 231
2841:             .Width       = 94
2842:             .Height      = 27
2843:             .ButtonCount = 2
2844:             .BackStyle   = 0
2845:             .Value       = 2
2846:             .Visible     = .T.
2847: 
2848:             WITH .Buttons(1)
2849:                 .Caption   = "Sim"
2850:                 .Width     = 43
2851:                 .Height    = 17
2852:                 .Left      = 0
2853:                 .Top       = 0
2854:                 .BackStyle = 0
2855:                 .Visible   = .T.
2856:             ENDWITH
2857: 
2858:             WITH .Buttons(2)
2859:                 .Caption   = "N" + CHR(227) + "o"
2860:                 .Width     = 43
2861:                 .Height    = 17
2862:                 .Left      = 45
2863:                 .Top       = 0
2864:                 .BackStyle = 0
2865:                 .FontName  = "Tahoma"
2866:                 .FontSize  = 8
2867:                 .Visible   = .T.
2868:             ENDWITH
2869:         ENDWITH
2870: 
2871:         *-- Label: Movimentacao Fisica de Estoque
2872:         loc_oPg2.AddObject("lbl_4c_Label38", "Label")
2873:         WITH loc_oPg2.lbl_4c_Label38
2874:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
2875:             .Top       = 298
2876:             .Left      = 68
2877:             .Width     = 164
2878:             .Height    = 15
2879:             .FontName  = "Tahoma"
2880:             .FontSize  = 8
2881:             .BackStyle = 0
2882:             .Visible   = .T.
2883:         ENDWITH
2884: 
2885:         *-- obj_4c_Fwoption5 - indmov numeric(1,0), 2 buttons Sim/Nao
2886:         loc_oPg2.AddObject("obj_4c_Fwoption5", "OptionGroup")
2887:         WITH loc_oPg2.obj_4c_Fwoption5
2888:             .Top         = 292
2889:             .Left        = 231
2890:             .Width       = 94
2891:             .Height      = 27
2892:             .ButtonCount = 2
2893:             .BackStyle   = 0
2894:             .Value       = 2
2895:             .Visible     = .T.
2896: 
2897:             WITH .Buttons(1)
2898:                 .Caption   = "Sim"
2899:                 .Width     = 43
2900:                 .Height    = 17
2901:                 .Left      = 0
2902:                 .Top       = 0
2903:                 .BackStyle = 0
2904:                 .Visible   = .T.
2905:             ENDWITH
2906: 
2907:             WITH .Buttons(2)
2908:                 .Caption   = "N" + CHR(227) + "o"
2909:                 .Width     = 43
2910:                 .Height    = 17
2911:                 .Left      = 45
2912:                 .Top       = 0
2913:                 .BackStyle = 0
2914:                 .FontName  = "Tahoma"
2915:                 .FontSize  = 8
2916:                 .Visible   = .T.
2917:             ENDWITH
2918:         ENDWITH
2919: 
2920:         *-- Label: Indicacao de Pagamento
2921:         loc_oPg2.AddObject("lbl_4c_Label39", "Label")
2922:         WITH loc_oPg2.lbl_4c_Label39
2923:             .Caption   = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
2924:             .Top       = 318
2925:             .Left      = 105
2926:             .Width     = 127
2927:             .Height    = 15
2928:             .FontName  = "Tahoma"
2929:             .FontSize  = 8
2930:             .BackStyle = 0
2931:             .Visible   = .T.
2932:         ENDWITH
2933: 
2934:         *-- obj_4c_Fwoption6 - indpagto numeric(1,0), 2 buttons Sim/Nao
2935:         loc_oPg2.AddObject("obj_4c_Fwoption6", "OptionGroup")
2936:         WITH loc_oPg2.obj_4c_Fwoption6
2937:             .Top         = 312
2938:             .Left        = 231
2939:             .Width       = 94
2940:             .Height      = 27
2941:             .ButtonCount = 2
2942:             .BackStyle   = 0
2943:             .Value       = 2
2944:             .Visible     = .T.
2945: 
2946:             WITH .Buttons(1)
2947:                 .Caption   = "Sim"
2948:                 .Width     = 43
2949:                 .Height    = 17
2950:                 .Left      = 0
2951:                 .Top       = 0
2952:                 .BackStyle = 0
2953:                 .Visible   = .T.
2954:             ENDWITH
2955: 
2956:             WITH .Buttons(2)
2957:                 .Caption   = "N" + CHR(227) + "o"
2958:                 .Width     = 43
2959:                 .Height    = 17
2960:                 .Left      = 45
2961:                 .Top       = 0
2962:                 .BackStyle = 0
2963:                 .FontName  = "Tahoma"
2964:                 .FontSize  = 8
2965:                 .Visible   = .T.
2966:             ENDWITH

*-- Linhas 2997 a 3006:
2997:                     loc_oGrid.Column1.Width = 80
2998:                     loc_oGrid.Column2.Width = 400
2999: 
3000:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3001:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3002: 
3003:                     *-- situas=1 Ativo (preto), situas!=1 Inativo (vermelho)
3004:                     loc_oGrid.SetAll("DynamicForeColor", ;
3005:                         "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(255,0,0))", "Column")
3006: 

*-- Linhas 3252 a 3260:
3252:             loc_oBO.this_nInclicms   = ALLTRIM(loc_oPage1.cbo_4c_Combo3.Value)
3253:             loc_oBO.this_nIcmsdscs   = ALLTRIM(loc_oPage1.cbo_4c_Combo10.Value)
3254:             loc_oBO.this_nIcmsincs   = ALLTRIM(loc_oPage1.cbo_4c_Combo6.Value)
3255:             loc_oBO.this_nIncicmnfs  = IIF(loc_oPage1.chk_4c_Fwcheckbox1.Value, 1, 0)
3256:             loc_oBO.this_cCgergia1s  = ALLTRIM(loc_oPage1.txt_4c_Gergia1.Value)
3257:             loc_oBO.this_nFrticms    = IIF(loc_oPage1.chk_4c_ObjFreteICM.Value, 1, 0)
3258:             loc_oBO.this_nSegicms    = IIF(loc_oPage1.chk_4c_ObjSegIcm.Value, 1, 0)
3259:             loc_oBO.this_nDesicms    = IIF(loc_oPage1.chk_4c_ObjDespIcm.Value, 1, 0)
3260: 

*-- Linhas 3360 a 3368:
3360:             loc_oPage1.cbo_4c_Combo3.Value       = LTRIM(STR(loc_oBO.this_nInclicms, 1))
3361:             loc_oPage1.cbo_4c_Combo10.Value      = LTRIM(STR(loc_oBO.this_nIcmsdscs, 1))
3362:             loc_oPage1.cbo_4c_Combo6.Value       = LTRIM(STR(loc_oBO.this_nIcmsincs, 1))
3363:             loc_oPage1.chk_4c_Fwcheckbox1.Value  = IIF(loc_oBO.this_nIncicmnfs = 1, 1, 0)
3364:             loc_oPage1.txt_4c_Gergia1.Value      = loc_oBO.this_cCgergia1s
3365:             loc_oPage1.chk_4c_ObjFreteICM.Value  = IIF(loc_oBO.this_nFrticms = 1, 1, 0)
3366:             loc_oPage1.chk_4c_ObjSegIcm.Value    = IIF(loc_oBO.this_nSegicms = 1, 1, 0)
3367:             loc_oPage1.chk_4c_ObjDespIcm.Value   = IIF(loc_oBO.this_nDesicms = 1, 1, 0)
3368: 

*-- Linhas 3526 a 3534:
3526:                 CASE VARTYPE(loc_oCtrl.Value) = "N"
3527:                     loc_oCtrl.Value = 0
3528:                 CASE VARTYPE(loc_oCtrl.Value) = "L"
3529:                     loc_oCtrl.Value = .F.
3530:                 CASE VARTYPE(loc_oCtrl.Value) = "D"
3531:                     loc_oCtrl.Value = {}
3532:                 ENDCASE
3533:             ENDIF
3534:             IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "ControlCount", 5)

*-- Linhas 3560 a 3568:
3560:             loc_oCtrl = par_oContainer.Controls(loc_nI)
3561:             IF VARTYPE(loc_oCtrl) = "O"
3562:                 loc_cBase = UPPER(loc_oCtrl.BaseClass)
3563:                 IF INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", ;
3564:                         "SPINNER", "OPTIONGROUP")
3565:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
3566:                         loc_oCtrl.Enabled = par_lHabilitar
3567:                     ENDIF
3568:                 ENDIF

*-- Linhas 3799 a 3807:
3799:             loc_oCntSalva  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
3800:             loc_lEditavel  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3801:             IF VARTYPE(loc_oCntSalva) = "O"
3802:                 loc_oCntSalva.cmd_4c_Salvar.Enabled = loc_lEditavel
3803:             ENDIF
3804:         CATCH TO loc_oErro
3805:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
3806:         ENDTRY
3807:     ENDPROC


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*==============================================================================
* cfoBO.prg - Business Object para Cadastro de CFOP
* Tabela: SigCdCfo
* Chave: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdCfo (mapeados diretamente do schema)
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCodigos    = ""    && codigos     char(10)  PK
    this_cDescricaos = ""    && descricaos  char(60)  Descricao nota fiscal
    this_cDesc2s     = ""    && desc2s      char(60)  Descricao consulta

    *-- Operacao e tipo
    this_cOperacaos  = ""    && operacaos   char(1)   E=Entrada S=Saida
    this_nTipos      = 0     && tipos       numeric(1,0)
    this_nNdigitos   = 0     && ndigitos    numeric(2,0)  Digitos para NF

    *-- ICMS
    this_cIcms       = ""    && icms        char(1)   T=Tributado I=Isento O=Outros N=N.Tributa
    this_cSittribs   = ""    && sittribs    char(3)   Situacao tributaria ICMS
    this_nAliqivcs   = 0     && aliqivcs    numeric(4,2)  Aliquota venda consumidor
    this_nInclicms   = 0     && inclicms    numeric(1,0)  Incluir ICMS na base
    this_nIcmsdscs   = 0     && icmsdscs    numeric(1,0)  ICMS incluso no preco
    this_nIcmsincs   = 0     && icmsincs    numeric(1,0)  Integrar valores ICMS
    this_nIncicmnfs  = 0     && incicmnfs   numeric(1,0)  Incluir ICMS no total da NF
    this_cCgergia1s  = ""    && cgergia1s   char(1)   Destaca ICMS na NF S/N
    this_nFrticms    = 0     && frticms     numeric(1,0)  Frete compoe base ICMS
    this_nSegicms    = 0     && segicms     numeric(1,0)  Seguro compoe base ICMS
    this_nDesicms    = 0     && desicms     numeric(1,0)  Despesas compoe base ICMS

    *-- Substituicao tributaria ICMS
    this_cSubtribs   = ""    && subtribs    char(1)   Substituicao tributaria S/N
    this_nPbcsts     = 0     && pbcsts      numeric(5,2)  % base ST
    this_cCfosts     = ""    && cfosts      char(10)  CFOP subst. tributaria
    this_cCoddests   = ""    && coddests    char(10)  CFOP destino
    this_nTransps    = 0     && transps     numeric(1,0)  CFOP transporte

    *-- IPI
    this_cIpis       = ""    && ipis        char(1)   T=Tributado I=Isento O=Outros
    this_cIpi_icms   = ""    && ipi_icms    char(1)   IPI sobre ICMS
    this_nInclipis   = 0     && inclipis    numeric(1,0)  Incluir IPI na base
    this_nPbcipis    = 0     && pbcipis     numeric(5,2)  % base IPI
    this_cBcipis     = ""    && bcipis      char(1)   Base de calculo IPI
    this_nAliqipis   = 0     && aliqipis    numeric(4,2)  Aliquota IPI
    this_cAcresipis  = ""    && acresipis   char(1)   Acrescenta na base
    this_cIpiimpors  = ""    && ipiimpors   char(1)   IPI importacao
    this_cIpiom2s    = ""    && ipiom2s     char(1)   IPI calc. p/ origem mercadoria=2
    this_nFrtipis    = 0     && frtipis     numeric(1,0)  Frete compoe base IPI
    this_nSegipis    = 0     && segipis     numeric(1,0)  Seguro compoe base IPI
    this_nDesipis    = 0     && desipis     numeric(1,0)  Despesas compoe base IPI
    this_nIpincreds  = 0     && ipincreds   numeric(1,0)  IPI nao creditado
    this_nPontedescs = 0     && pontedescs  numeric(1,0)  Retira IPI do valor
    this_cIpicst     = ""    && ipicst      char(2)   Codigo IPI sit. tributaria NF-e
    this_cIpienq     = ""    && ipienq      char(3)   Enquadramento IPI
    this_cUnitimps   = ""    && unitimps    char(1)   Inibe valor unitario NF importacao

    *-- PIS / COFINS / ISSQN / II
    this_cPiscst     = ""    && piscst      char(2)   Codigo PIS sit. tributaria
    this_cCofcst     = ""    && cofcst      char(2)   Codigo COFINS sit. tributaria
    this_cIssqnl     = ""    && issqnl      char(5)   Codigo ISSQN lista servicos
    this_nAliqpis    = 0     && aliqpis     numeric(5,2)  Aliquota PIS
    this_nAliqcofins = 0     && aliqcofins  numeric(5,2)  Aliquota COFINS
    this_nAliqissqn  = 0     && aliqissqn   numeric(5,2)  Aliquota ISSQN
    this_nAliqii     = 0     && aliqii      numeric(5,2)  Aliquota II
    this_nCtissqn    = 0     && ctissqn     numeric(1,0)  Codigo tributacao ISSQN
    this_nRettribs   = 0     && rettribs    numeric(1,0)  Informa retencao de tributos

    *-- Contribuinte / Situacao
    this_cContribs   = ""    && contribs    char(1)   S=Sim N=Nao O=Outros
    this_nSituas     = 0     && situas      numeric(1,0)  0=Ativo 1=Inativo
    this_cCfost60s   = ""    && cfost60s    char(10)  CFOP ST60
    this_nSomaicmfrete = 0   && somaicmfrete numeric(1,0)
    this_cMotdeson   = ""    && motdeson    char(2)   Motivo desoneracao ICMS

    *-- Integracao Contabil - Contas DB/CR
    this_cContconts  = ""    && contconts   char(1)   Pega conta contabil da NF
    this_cContvcds   = ""    && contvcds    char(9)   Conta valor contabil DB
    this_cContvccs   = ""    && contvccs    char(9)   Conta valor contabil CR
    this_cContipds   = ""    && contipds    char(9)   Conta IPI DB
    this_cContipcs   = ""    && contipcs    char(9)   Conta IPI CR
    this_cConticds   = ""    && conticds    char(9)   Conta ICMS DB
    this_cConticcs   = ""    && conticcs    char(9)   Conta ICMS CR
    this_cContfrt    = ""    && contfrt     char(9)   Conta frete
    this_cContseg    = ""    && contseg     char(9)   Conta seguro
    this_cContda     = ""    && contda      char(9)   Conta despesas acessorias

    *-- Integracao Contabil - Opcoes
    this_nAgrupas    = 0     && agrupas     numeric(1,0)  Agrupa CFO na integracao
    this_nZeradas    = 0     && zeradas     numeric(1,0)  Integracao zerada
    this_nIntvlrcont = 0     && intvlrcont  numeric(1,0)  Integrar valor contabil
    this_nIntvlricms = 0     && intvlricms  numeric(1,0)  Integrar valores ICMS
    this_nIntvlripi  = 0     && intvlripi   numeric(1,0)  Integrar valores IPI
    this_nUtilvars   = 0     && utilvars    numeric(1,0)  Utilizar variacao CFOP
    this_nIndmov     = 0     && indmov      numeric(1,0)  Movimentacao fisica estoque
    this_nIndpagto   = 0     && indpagto    numeric(1,0)  Indicacao pagamento
    this_nTiporecs   = 0     && tiporecs    numeric(1,0)  Data lancamento contabil
    this_nObspads    = 0     && obspads     numeric(3,0)  Observacao padrao
    this_nDtintfis   = 0     && dtintfis    numeric(1,0)  Integracao fiscal

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
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
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cIpi_icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cCols, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cCols = "codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis"

            loc_cVals = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "INSERT INTO SigCdCfo (" + loc_cCols + ") VALUES (" + loc_cVals + ")"

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
        LOCAL loc_cSQL, loc_cSet, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSet = "descricaos = "  + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s = "             + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "operacaos = "          + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "tipos = "              + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "ndigitos = "           + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms = "               + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "sittribs = "           + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "aliqivcs = "           + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "inclicms = "           + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsdscs = "           + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "icmsincs = "           + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "incicmnfs = "          + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "cgergia1s = "          + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "frticms = "            + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms = "            + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "desicms = "            + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "subtribs = "           + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "pbcsts = "             + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "cfosts = "             + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests = "           + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "transps = "            + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "ipis = "               + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "ipi_icms = "           + EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                "inclipis = "           + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "pbcipis = "            + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "bcipis = "             + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "aliqipis = "           + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "acresipis = "          + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors = "          + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s = "            + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "frtipis = "            + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis = "            + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "desipis = "            + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "ipincreds = "          + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "pontedescs = "         + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "ipicst = "             + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "ipienq = "             + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "unitimps = "           + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "piscst = "             + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst = "             + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl = "             + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis = "            + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins = "         + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn = "          + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "aliqii = "             + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ctissqn = "            + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs = "           + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "contribs = "           + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "situas = "             + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "cfost60s = "           + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "somaicmfrete = "       + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "motdeson = "           + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "contconts = "          + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "contvcds = "           + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs = "           + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "contipds = "           + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs = "           + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "conticds = "           + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs = "           + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contfrt = "            + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg = "            + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda = "             + EscaparSQL(THIS.this_cContda) + ", " + ;
                "agrupas = "            + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas = "            + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "intvlrcont = "         + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms = "         + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi = "          + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "utilvars = "           + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "indmov = "             + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto = "           + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "tiporecs = "           + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads = "            + FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                "dtintfis = "           + FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "UPDATE SigCdCfo SET " + loc_cSet + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

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
            loc_cSQL = "DELETE FROM SigCdCfo WHERE codigos = " + ;
                EscaparSQL(THIS.this_cCodigos)

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
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, desc2s, operacaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, situas" + ;
                " FROM SigCdCfo"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

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
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
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
            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                " FROM SigCdCfo WHERE codigos = " + EscaparSQL(par_cCodigo)

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
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da nota fiscal obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

