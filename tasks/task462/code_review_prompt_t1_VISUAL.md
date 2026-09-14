# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMda.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2604 linhas total):

*-- Linhas 39 a 57:
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.Caption = "Cadastro de Motivos de Desconto / Acr" + CHR(233) + "scimo"
43:             THIS.this_oBusinessObject = CREATEOBJECT("MdaBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar MdaBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormMda.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible  = .T.
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

*-- Linhas 116 a 153:
116:         *----------------------------------------------------------------------
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = THIS.Width - 10
134:             .Height    = 40
135:             .AutoSize  = .F.
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(0, 0, 0)
140:             .BackStyle = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = THIS.Width - 10
150:             .Height    = 46
151:             .AutoSize  = .F.
152:             .FontName  = "Tahoma"
153:             .FontSize  = 16

*-- Linhas 163 a 322:
163:         *----------------------------------------------------------------------
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .FontName        = "Comic Sans MS"
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontSize        = 8
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .MousePointer    = 15
193:             .WordWrap        = .T.
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197: 
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Comic Sans MS"
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .FontSize        = 8
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220: 
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
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .FontSize        = 8
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243: 
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
266: 
267:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
268:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
269:             .Caption         = "Buscar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .FontName        = "Comic Sans MS"
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .FontSize        = 8
280:             .ForeColor       = RGB(90, 90, 90)
281:             .BackColor       = RGB(255, 255, 255)
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .MousePointer    = 15
285:             .WordWrap        = .T.
286:             .AutoSize        = .F.
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
292:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *----------------------------------------------------------------------
297:         * Container Saida - PADRAO CANONICO (CLAUDE.md Regra #10)
298:         * Left=917, Top=29 (0+29 compensacao), Width=90, Height=85
299:         *----------------------------------------------------------------------
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         WITH loc_oPagina.cnt_4c_Saida
302:             .Top         = 29
303:             .Left        = 917
304:             .Width       = 90
305:             .Height      = 85
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .FontName        = "Tahoma"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.

*-- Linhas 331 a 352:
331:             .Visible         = .T.
332:         ENDWITH
333: 
334:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
335: 
336:         *----------------------------------------------------------------------
337:         * Grid de Lista - colunas: Codigos(80), Descrs(290), Tipos(40)
338:         * Top = 117 (88 padrao framework + 29 compensacao PageFrame)
339:         * ColumnCount e RecordSource FORA de WITH (Problema 36/48)
340:         *----------------------------------------------------------------------
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
343:         loc_oPagina.grd_4c_Lista.RecordSource = ""
344: 
345:         WITH loc_oPagina.grd_4c_Lista
346:             .Top                = 117
347:             .Left               = 26
348:             .Width              = 890
349:             .Height             = 498
350:             .FontName           = "Verdana"
351:             .FontSize           = 8
352:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 367 a 387:
367:         WITH loc_oPagina.grd_4c_Lista.Column1
368:             .Width     = 80
369:             .Alignment = 0
370:             .Header1.Caption = ""
371:         ENDWITH
372: 
373:         WITH loc_oPagina.grd_4c_Lista.Column2
374:             .Width     = 290
375:             .Alignment = 0
376:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
377:         ENDWITH
378: 
379:         WITH loc_oPagina.grd_4c_Lista.Column3
380:             .Width     = 40
381:             .Alignment = 2
382:             .Header1.Caption = ""
383:         ENDWITH
384: 
385:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
386: 
387:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 403 a 427:
403:         *----------------------------------------------------------------------
404:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao
406:             .Top         = 33
407:             .Left        = 842
408:             .Width       = 160
409:             .Height      = 85
410:             .BackStyle = 1
411:             .BackColor   = RGB(255, 255, 255)
412:             .BorderWidth = 0
413:             .Visible     = .T.
414:         ENDWITH
415: 
416:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
417:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
418:             .Caption         = "Confirmar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 5
423:             .Width           = 75
424:             .Height          = 75
425:             .FontName        = "Tahoma"
426:             .FontBold        = .T.
427:             .FontItalic      = .T.

*-- Linhas 436 a 450:
436:             .Visible         = .T.
437:         ENDWITH
438: 
439:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
440:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
441:             .Caption         = "Encerrar"
442:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
443:             .PicturePosition = 13
444:             .Top             = 5
445:             .Left            = 80
446:             .Width           = 75
447:             .Height          = 75
448:             .FontName        = "Tahoma"
449:             .FontBold        = .T.
450:             .FontItalic      = .T.

*-- Linhas 459 a 480:
459:             .Visible         = .T.
460:         ENDWITH
461: 
462:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
463:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *----------------------------------------------------------------------
466:         * FASE 5: Campos escalares da Page2
467:         * Tops = valor_original_SCX + 29 (compensacao PageFrame.Top=-29)
468:         *----------------------------------------------------------------------
469: 
470:         *-- Linha 1: Codigo (Top=121->150) + Tipos (Top=121->150)
471:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
472:         WITH loc_oPagina.lbl_4c_Label1
473:             .Caption   = "C" + CHR(243) + "digo :"
474:             .Top       = 153
475:             .Left      = 125
476:             .Width     = 42
477:             .Height    = 17
478:             .AutoSize  = .F.
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8

*-- Linhas 487 a 509:
487:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
488:         WITH loc_oPagina.txt_4c_Codigos
489:             .Value     = ""
490:             .Top       = 150
491:             .Left      = 171
492:             .Width     = 80
493:             .Height    = 23
494:             .MaxLength = 10
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
501:         WITH loc_oPagina.lbl_4c_Label3
502:             .Caption   = "Tipos :"
503:             .Top       = 153
504:             .Left      = 258
505:             .Width     = 34
506:             .Height    = 17
507:             .AutoSize  = .F.
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8

*-- Linhas 516 a 539:
516:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
517:         WITH loc_oPagina.txt_4c_Tipos
518:             .Value     = "D"
519:             .Top       = 150
520:             .Left      = 300
521:             .Width     = 17
522:             .Height    = 23
523:             .MaxLength = 1
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .Visible   = .T.
527:         ENDWITH
528:         BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
529: 
530:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
531:         WITH loc_oPagina.lbl_4c_Label4
532:             .Caption   = "< D >esconto  < A >cr" + CHR(233) + "scimo"
533:             .Top       = 147
534:             .Left      = 323
535:             .Width     = 85
536:             .Height    = 30
537:             .AutoSize  = .F.
538:             .WordWrap  = .T.
539:             .FontName  = "Tahoma"

*-- Linhas 545 a 557:
545:         ENDWITH
546: 
547:         *-- Linha 2: Descricao (Top=145->174)
548:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
549:         WITH loc_oPagina.lbl_4c_Label2
550:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
551:             .Top       = 177
552:             .Left      = 112
553:             .Width     = 60
554:             .Height    = 17
555:             .AutoSize  = .F.
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8

*-- Linhas 564 a 587:
564:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
565:         WITH loc_oPagina.txt_4c_Descrs
566:             .Value     = ""
567:             .Top       = 174
568:             .Left      = 171
569:             .Width     = 290
570:             .Height    = 23
571:             .MaxLength = 50
572:             .FontName  = "Tahoma"
573:             .FontSize  = 8
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         *-- Linha 3: Bloquear Desconto BIN - Optiongroup12 (Top=169->198)
578:         loc_oPagina.AddObject("lbl_4c_Label58", "Label")
579:         WITH loc_oPagina.lbl_4c_Label58
580:             .Caption   = "Bloquear Desconto BIN :"
581:             .Top       = 200
582:             .Left      = 48
583:             .Width     = 120
584:             .Height    = 17
585:             .AutoSize  = .F.
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8

*-- Linhas 594 a 641:
594:         loc_oPagina.AddObject("opt_4c_Optiongroup12", "OptionGroup")
595:         WITH loc_oPagina.opt_4c_Optiongroup12
596:             .ButtonCount = 2
597:             .Top         = 198
598:             .Left        = 171
599:             .Width       = 97
600:             .Height      = 20
601:             .BackStyle   = 0
602:             .BorderStyle = 0
603:             .Value       = 2
604:             .Visible     = .T.
605:         ENDWITH
606:         WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(1)
607:             .Caption   = "Sim"
608:             .Left      = 5
609:             .Top       = 1
610:             .Width     = 40
611:             .Height    = 17
612:             .AutoSize  = .F.
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .ForeColor = RGB(90, 90, 90)
616:             .BackStyle = 0
617:         ENDWITH
618:         WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(2)
619:             .Caption   = "N" + CHR(227) + "o"
620:             .Left      = 47
621:             .Top       = 1
622:             .Width     = 40
623:             .Height    = 17
624:             .AutoSize  = .F.
625:             .FontName  = "Tahoma"
626:             .FontSize  = 8
627:             .ForeColor = RGB(90, 90, 90)
628:             .BackStyle = 0
629:         ENDWITH
630: 
631:         *-- Linha 4: Nao Gerar Bonus - Optiongroup1 (Top=191->220)
632:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
633:         WITH loc_oPagina.lbl_4c_Label5
634:             .Caption   = "N" + CHR(227) + "o Gerar Bonus:"
635:             .Top       = 222
636:             .Left      = 80
637:             .Width     = 90
638:             .Height    = 17
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8

*-- Linhas 648 a 695:
648:         loc_oPagina.AddObject("opt_4c_Optiongroup1", "OptionGroup")
649:         WITH loc_oPagina.opt_4c_Optiongroup1
650:             .ButtonCount = 2
651:             .Top         = 220
652:             .Left        = 171
653:             .Width       = 97
654:             .Height      = 20
655:             .BackStyle   = 0
656:             .BorderStyle = 0
657:             .Value       = 2
658:             .Visible     = .T.
659:         ENDWITH
660:         WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(1)
661:             .Caption   = "Sim"
662:             .Left      = 5
663:             .Top       = 1
664:             .Width     = 40
665:             .Height    = 17
666:             .AutoSize  = .F.
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ForeColor = RGB(90, 90, 90)
670:             .BackStyle = 0
671:         ENDWITH
672:         WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(2)
673:             .Caption   = "N" + CHR(227) + "o"
674:             .Left      = 47
675:             .Top       = 1
676:             .Width     = 40
677:             .Height    = 17
678:             .AutoSize  = .F.
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .ForeColor = RGB(90, 90, 90)
682:             .BackStyle = 0
683:         ENDWITH
684: 
685:         *-- Linha 5: Bloquear Tab.Desconto - Optiongroup2 (Top=213->242)
686:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
687:         WITH loc_oPagina.lbl_4c_Label6
688:             .Caption   = "Bloquear Tab.Desconto :"
689:             .Top       = 244
690:             .Left      = 46
691:             .Width     = 125
692:             .Height    = 17
693:             .AutoSize  = .F.
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8

*-- Linhas 702 a 749:
702:         loc_oPagina.AddObject("opt_4c_Optiongroup2", "OptionGroup")
703:         WITH loc_oPagina.opt_4c_Optiongroup2
704:             .ButtonCount = 2
705:             .Top         = 242
706:             .Left        = 171
707:             .Width       = 97
708:             .Height      = 20
709:             .BackStyle   = 0
710:             .BorderStyle = 0
711:             .Value       = 2
712:             .Visible     = .T.
713:         ENDWITH
714:         WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(1)
715:             .Caption   = "Sim"
716:             .Left      = 5
717:             .Top       = 1
718:             .Width     = 40
719:             .Height    = 17
720:             .AutoSize  = .F.
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .ForeColor = RGB(90, 90, 90)
724:             .BackStyle = 0
725:         ENDWITH
726:         WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(2)
727:             .Caption   = "N" + CHR(227) + "o"
728:             .Left      = 47
729:             .Top       = 1
730:             .Width     = 40
731:             .Height    = 17
732:             .AutoSize  = .F.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .BackStyle = 0
737:         ENDWITH
738: 
739:         *-- Linha 6: Periodo (PerInis Top=235->264, PerFins Top=235->264)
740:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
741:         WITH loc_oPagina.lbl_4c_Label9
742:             .Caption   = "Per" + CHR(237) + "odo :"
743:             .Top       = 267
744:             .Left      = 122
745:             .Width     = 50
746:             .Height    = 17
747:             .AutoSize  = .F.
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8

*-- Linhas 756 a 778:
756:         loc_oPagina.AddObject("txt_4c_PerInis", "TextBox")
757:         WITH loc_oPagina.txt_4c_PerInis
758:             .Value    = {}
759:             .Top      = 264
760:             .Left     = 171
761:             .Width    = 80
762:             .Height   = 23
763:             .FontName = "Tahoma"
764:             .FontSize = 8
765:             .Visible  = .T.
766:         ENDWITH
767: 
768:         *-- Separador "a" entre PerInis e PerFins (Top=239->268)
769:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
770:         WITH loc_oPagina.lbl_4c_Label10
771:             .Caption   = "a"
772:             .Top       = 268
773:             .Left      = 257
774:             .Width     = 8
775:             .Height    = 17
776:             .AutoSize  = .F.
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8

*-- Linhas 785 a 807:
785:         loc_oPagina.AddObject("txt_4c_PerFins", "TextBox")
786:         WITH loc_oPagina.txt_4c_PerFins
787:             .Value    = {}
788:             .Top      = 264
789:             .Left     = 269
790:             .Width    = 80
791:             .Height   = 23
792:             .FontName = "Tahoma"
793:             .FontSize = 8
794:             .Visible  = .T.
795:         ENDWITH
796: 
797:         *-- Linha 7: Grande Grupo (Top=260->289) + SubGrupo (Top=260->289) com lookup
798:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
799:         WITH loc_oPagina.lbl_4c_Label11
800:             .Caption   = "Gde Grupo :"
801:             .Top       = 292
802:             .Left      = 107
803:             .Width     = 60
804:             .Height    = 17
805:             .AutoSize  = .F.
806:             .FontName  = "Tahoma"
807:             .FontSize  = 8

*-- Linhas 814 a 836:
814:         loc_oPagina.AddObject("txt_4c_GGrus", "TextBox")
815:         WITH loc_oPagina.txt_4c_GGrus
816:             .Value     = ""
817:             .Top       = 289
818:             .Left      = 171
819:             .Width     = 35
820:             .Height    = 23
821:             .MaxLength = 5
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .Visible   = .T.
825:         ENDWITH
826: 
827:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
828:         WITH loc_oPagina.lbl_4c_Label12
829:             .Caption   = "SubGrupo :"
830:             .Top       = 292
831:             .Left      = 226
832:             .Width     = 56
833:             .Height    = 17
834:             .AutoSize  = .F.
835:             .FontName  = "Tahoma"
836:             .FontSize  = 8

*-- Linhas 843 a 869:
843:         loc_oPagina.AddObject("txt_4c_SGrus", "TextBox")
844:         WITH loc_oPagina.txt_4c_SGrus
845:             .Value     = ""
846:             .Top       = 289
847:             .Left      = 294
848:             .Width     = 55
849:             .Height    = 23
850:             .MaxLength = 5
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         BINDEVENT(loc_oPagina.txt_4c_GGrus, "KeyPress", THIS, "ValidarGGrus")
857:         BINDEVENT(loc_oPagina.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")
858: 
859:         *-- Linha 8: Tipo de Desconto - OptTpDescs (Top=282->311)
860:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
861:         WITH loc_oPagina.lbl_4c_Label14
862:             .Caption   = "Tipo de Desconto :"
863:             .Top       = 315
864:             .Left      = 75
865:             .Width     = 95
866:             .Height    = 17
867:             .AutoSize  = .F.
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8

*-- Linhas 876 a 923:
876:         loc_oPagina.AddObject("opt_4c_OptTpDescs", "OptionGroup")
877:         WITH loc_oPagina.opt_4c_OptTpDescs
878:             .ButtonCount = 2
879:             .Top         = 311
880:             .Left        = 171
881:             .Width       = 152
882:             .Height      = 25
883:             .BackStyle   = 0
884:             .BorderStyle = 0
885:             .Value       = 1
886:             .Visible     = .T.
887:         ENDWITH
888:         WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(1)
889:             .Caption   = "Geral"
890:             .Left      = 5
891:             .Top       = 5
892:             .Width     = 43
893:             .Height    = 15
894:             .AutoSize  = .T.
895:             .FontName  = "Tahoma"
896:             .FontSize  = 8
897:             .ForeColor = RGB(90, 90, 90)
898:             .BackStyle = 0
899:         ENDWITH
900:         WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(2)
901:             .Caption   = "por Produto"
902:             .Left      = 67
903:             .Top       = 5
904:             .Width     = 75
905:             .Height    = 15
906:             .AutoSize  = .T.
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .ForeColor = RGB(90, 90, 90)
910:             .BackStyle = 0
911:         ENDWITH
912: 
913:         *-- Linha 9: Limite de Desconto (Top=307->336)
914:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
915:         WITH loc_oPagina.lbl_4c_Label15
916:             .Caption   = "Limite de Desconto :"
917:             .Top       = 339
918:             .Left      = 68
919:             .Width     = 99
920:             .Height    = 17
921:             .AutoSize  = .F.
922:             .FontName  = "Tahoma"
923:             .FontSize  = 8

*-- Linhas 930 a 954:
930:         loc_oPagina.AddObject("txt_4c_LimDescs", "TextBox")
931:         WITH loc_oPagina.txt_4c_LimDescs
932:             .Value     = 0
933:             .Top       = 336
934:             .Left      = 171
935:             .Width     = 55
936:             .Height    = 23
937:             .InputMask = "99.99"
938:             .MaxLength = 5
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         *-- Linha 10: Checar Dt. Aniversario - Optiongroup3 (Top=332->361)
945:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
946:         WITH loc_oPagina.lbl_4c_Label16
947:             .Caption   = "Checar Dt. Anivers" + CHR(225) + "rio :"
948:             .Top       = 363
949:             .Left      = 49
950:             .Width     = 125
951:             .Height    = 17
952:             .AutoSize  = .F.
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8

*-- Linhas 961 a 1010:
961:         loc_oPagina.AddObject("opt_4c_Optiongroup3", "OptionGroup")
962:         WITH loc_oPagina.opt_4c_Optiongroup3
963:             .ButtonCount = 2
964:             .Top         = 361
965:             .Left        = 171
966:             .Width       = 97
967:             .Height      = 20
968:             .BackStyle   = 0
969:             .BorderStyle = 0
970:             .Value       = 2
971:             .Visible     = .T.
972:         ENDWITH
973:         WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(1)
974:             .Caption   = "Sim"
975:             .Left      = 5
976:             .Top       = 1
977:             .Width     = 40
978:             .Height    = 17
979:             .AutoSize  = .F.
980:             .FontName  = "Tahoma"
981:             .FontSize  = 8
982:             .ForeColor = RGB(90, 90, 90)
983:             .BackStyle = 0
984:         ENDWITH
985:         WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(2)
986:             .Caption   = "N" + CHR(227) + "o"
987:             .Left      = 47
988:             .Top       = 1
989:             .Width     = 40
990:             .Height    = 17
991:             .AutoSize  = .F.
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .ForeColor = RGB(90, 90, 90)
995:             .BackStyle = 0
996:         ENDWITH
997: 
998:         *----------------------------------------------------------------------
999:         * Label "Operacoes" (Say8 legado: Top=124+29=153, Left=508)
1000:         *----------------------------------------------------------------------
1001:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1002:         WITH loc_oPagina.lbl_4c_Label8
1003:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es"
1004:             .Top       = 153
1005:             .Left      = 508
1006:             .Width     = 100
1007:             .Height    = 13
1008:             .AutoSize  = .F.
1009:             .FontName  = "Tahoma"
1010:             .FontSize  = 8

*-- Linhas 1017 a 1029:
1017:         *----------------------------------------------------------------------
1018:         * Label "Empresas" (Say7 legado: Top=359+29=388, Left=61)
1019:         *----------------------------------------------------------------------
1020:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1021:         WITH loc_oPagina.lbl_4c_Label7
1022:             .Caption   = "Empresas"
1023:             .Top       = 388
1024:             .Left      = 61
1025:             .Width     = 60
1026:             .Height    = 13
1027:             .AutoSize  = .F.
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8

*-- Linhas 1036 a 1048:
1036:         *----------------------------------------------------------------------
1037:         * Label "Composicao" (Say13 legado: Top=359+29=388, Left=431)
1038:         *----------------------------------------------------------------------
1039:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1040:         WITH loc_oPagina.lbl_4c_Label13
1041:             .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
1042:             .Top       = 388
1043:             .Left      = 431
1044:             .Width     = 80
1045:             .Height    = 13
1046:             .AutoSize  = .F.
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8

*-- Linhas 1054 a 1067:
1054: 
1055:         *----------------------------------------------------------------------
1056:         * Grid Operacoes (grdOpers legado: Top=141+29=170, Left=508, W=199, H=207)
1057:         * Col1: CheckBox/Imps (W=20), Col2: Text/Dopes (W=170)
1058:         *----------------------------------------------------------------------
1059:         loc_oPagina.AddObject("grd_4c_Opers", "Grid")
1060:         WITH loc_oPagina.grd_4c_Opers
1061:             .Top         = 170
1062:             .Left        = 508
1063:             .Width       = 199
1064:             .Height      = 207
1065:             .ColumnCount = 2
1066:             .FontName    = "Tahoma"
1067:             .FontSize    = 8

*-- Linhas 1075 a 1178:
1075:             .Visible     = .T.
1076:         ENDWITH
1077: 
1078:         *-- Column1: CheckBox para Imps (RecordSource/ControlSource set em CarregarRelacionados)
1079:         WITH loc_oPagina.grd_4c_Opers.Column1
1080:             .Width     = 20
1081:             .Movable   = .F.
1082:             .Resizable = .F.
1083:             .ReadOnly  = .F.
1084:             .Sparse    = .F.
1085:         ENDWITH
1086:         loc_oPagina.grd_4c_Opers.Column1.Header1.Caption   = ""
1087:         loc_oPagina.grd_4c_Opers.Column1.Header1.Alignment = 2
1088:         loc_oPagina.grd_4c_Opers.Column1.AddObject("Check1", "CheckBox")
1089:         WITH loc_oPagina.grd_4c_Opers.Column1.Check1
1090:             .Caption   = ""
1091:             .Alignment = 0
1092:             .ReadOnly  = .F.
1093:             .Visible   = .T.
1094:             .Top       = 9
1095:             .Left      = 2
1096:             .Height    = 17
1097:             .Width     = 22
1098:         ENDWITH
1099:         loc_oPagina.grd_4c_Opers.Column1.CurrentControl = "Check1"
1100: 
1101:         *-- Column2: Descricao da Operacao (Dopes) - ReadOnly
1102:         WITH loc_oPagina.grd_4c_Opers.Column2
1103:             .Width     = 170
1104:             .Movable   = .F.
1105:             .Resizable = .F.
1106:             .ReadOnly  = .T.
1107:         ENDWITH
1108:         loc_oPagina.grd_4c_Opers.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
1109: 
1110:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseDown", THIS, "OperCheckboxMouseDown")
1111:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseUp",   THIS, "OperCheckboxMouseUp")
1112:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "Click",     THIS, "OperCheckboxClick")
1113:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "KeyPress",  THIS, "OperCheckboxKeyPress")
1114: 
1115:         *----------------------------------------------------------------------
1116:         * Container botoes MarcaTodos/DesmarcaTodos Operacoes
1117:         * (Commandgroup1 legado: Top=157+29=186, Left=708, W=50, H=90)
1118:         *----------------------------------------------------------------------
1119:         loc_oPagina.AddObject("cnt_4c_CmdOpers", "Container")
1120:         WITH loc_oPagina.cnt_4c_CmdOpers
1121:             .Top         = 186
1122:             .Left        = 708
1123:             .Width       = 50
1124:             .Height      = 90
1125:             .BackStyle = 1
1126:             .BackColor = RGB(255, 255, 255)
1127:             .BorderWidth = 0
1128:             .Visible     = .T.
1129:         ENDWITH
1130: 
1131:         loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_MarcaOpers", "CommandButton")
1132:         WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers
1133:             .Caption         = ""
1134:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1135:             .PicturePosition = 13
1136:             .ToolTipText     = "Marcar todos"
1137:             .Top             = 5
1138:             .Left            = 5
1139:             .Width           = 40
1140:             .Height          = 40
1141:             .Themes          = .T.
1142:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1143:             .MousePointer    = 15
1144:             .Visible         = .T.
1145:         ENDWITH
1146: 
1147:         loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_DesmarcaOpers", "CommandButton")
1148:         WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers
1149:             .Caption         = ""
1150:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1151:             .PicturePosition = 13
1152:             .ToolTipText     = "Desmarcar todos"
1153:             .Top             = 45
1154:             .Left            = 5
1155:             .Width           = 40
1156:             .Height          = 40
1157:             .Themes          = .T.
1158:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1159:             .MousePointer    = 15
1160:             .Visible         = .T.
1161:         ENDWITH
1162: 
1163:         BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers,    "Click", THIS, "MarcaTodosOpersClick")
1164:         BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers, "Click", THIS, "DesmarcaTodosOpersClick")
1165: 
1166:         *----------------------------------------------------------------------
1167:         * Grid Empresas (grdEmps legado: Top=376+29=405, Left=59, W=276, H=207)
1168:         * Col1: CheckBox/Imps (W=20), Col2: Text/Emps (W=30), Col3: Text/Razas (W=200)
1169:         *----------------------------------------------------------------------
1170:         loc_oPagina.AddObject("grd_4c_Emps", "Grid")
1171:         WITH loc_oPagina.grd_4c_Emps
1172:             .Top         = 405
1173:             .Left        = 59
1174:             .Width       = 276
1175:             .Height      = 207
1176:             .ColumnCount = 3
1177:             .FontName    = "Tahoma"
1178:             .FontSize    = 8

*-- Linhas 1186 a 1300:
1186:             .Visible     = .T.
1187:         ENDWITH
1188: 
1189:         *-- Column1: CheckBox para Imps
1190:         WITH loc_oPagina.grd_4c_Emps.Column1
1191:             .Width     = 20
1192:             .Movable   = .F.
1193:             .Resizable = .F.
1194:             .ReadOnly  = .F.
1195:             .Sparse    = .F.
1196:         ENDWITH
1197:         loc_oPagina.grd_4c_Emps.Column1.Header1.Caption   = ""
1198:         loc_oPagina.grd_4c_Emps.Column1.Header1.Alignment = 2
1199:         loc_oPagina.grd_4c_Emps.Column1.AddObject("check12", "CheckBox")
1200:         WITH loc_oPagina.grd_4c_Emps.Column1.check12
1201:             .Caption   = ""
1202:             .Alignment = 0
1203:             .ReadOnly  = .F.
1204:             .Visible   = .T.
1205:             .Top       = 9
1206:             .Left      = 2
1207:             .Height    = 17
1208:             .Width     = 22
1209:         ENDWITH
1210:         loc_oPagina.grd_4c_Emps.Column1.AddObject("check13", "CheckBox")
1211:         loc_oPagina.grd_4c_Emps.Column1.check13.Caption = ""
1212:         loc_oPagina.grd_4c_Emps.Column1.CurrentControl = "check13"
1213: 
1214:         *-- Column2: Codigo empresa (Emps) - ReadOnly
1215:         WITH loc_oPagina.grd_4c_Emps.Column2
1216:             .Width     = 30
1217:             .Movable   = .F.
1218:             .Resizable = .F.
1219:             .ReadOnly  = .T.
1220:         ENDWITH
1221:         loc_oPagina.grd_4c_Emps.Column2.Header1.Caption = "Emp."
1222: 
1223:         *-- Column3: Razao social (Razas) - ReadOnly
1224:         WITH loc_oPagina.grd_4c_Emps.Column3
1225:             .Width     = 200
1226:             .Movable   = .F.
1227:             .Resizable = .F.
1228:             .ReadOnly  = .T.
1229:         ENDWITH
1230:         loc_oPagina.grd_4c_Emps.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1231: 
1232:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckboxMouseDown")
1233:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckboxMouseUp")
1234:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckboxClick")
1235:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckboxKeyPress")
1236: 
1237:         *----------------------------------------------------------------------
1238:         * Container botoes MarcaTodos/DesmarcaTodos Empresas
1239:         * (cmdEmps legado: Top=391+29=420, Left=336, W=50, H=90)
1240:         *----------------------------------------------------------------------
1241:         loc_oPagina.AddObject("cnt_4c_CmdEmps", "Container")
1242:         WITH loc_oPagina.cnt_4c_CmdEmps
1243:             .Top         = 420
1244:             .Left        = 336
1245:             .Width       = 50
1246:             .Height      = 90
1247:             .BackStyle = 1
1248:             .BackColor = RGB(255, 255, 255)
1249:             .BorderWidth = 0
1250:             .Visible     = .T.
1251:         ENDWITH
1252: 
1253:         loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_MarcaEmps", "CommandButton")
1254:         WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps
1255:             .Caption         = ""
1256:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1257:             .PicturePosition = 13
1258:             .ToolTipText     = "Marcar todos"
1259:             .Top             = 5
1260:             .Left            = 5
1261:             .Width           = 40
1262:             .Height          = 40
1263:             .Themes          = .T.
1264:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1265:             .MousePointer    = 15
1266:             .Visible         = .T.
1267:         ENDWITH
1268: 
1269:         loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_DesmarcaEmps", "CommandButton")
1270:         WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps
1271:             .Caption         = ""
1272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1273:             .PicturePosition = 13
1274:             .ToolTipText     = "Desmarcar todos"
1275:             .Top             = 45
1276:             .Left            = 5
1277:             .Width           = 40
1278:             .Height          = 40
1279:             .Themes          = .T.
1280:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1281:             .MousePointer    = 15
1282:             .Visible         = .T.
1283:         ENDWITH
1284: 
1285:         BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps,    "Click", THIS, "MarcaTodosEmpsClick")
1286:         BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps, "Click", THIS, "DesmarcaTodosEmpsClick")
1287: 
1288:         *----------------------------------------------------------------------
1289:         * Grid Composicoes (GrdCompo legado: Top=376+29=405, Left=431, W=276, H=207)
1290:         * Col1: Text/Compos editavel (W=244) com lookup
1291:         *----------------------------------------------------------------------
1292:         loc_oPagina.AddObject("grd_4c_Compo", "Grid")
1293:         WITH loc_oPagina.grd_4c_Compo
1294:             .Top         = 405
1295:             .Left        = 431
1296:             .Width       = 276
1297:             .Height      = 207
1298:             .ColumnCount = 1
1299:             .FontName    = "Tahoma"
1300:             .FontSize    = 8

*-- Linhas 1314 a 1365:
1314:             .Resizable = .F.
1315:             .ReadOnly  = .F.
1316:         ENDWITH
1317:         loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
1318: 
1319:         BINDEVENT(loc_oPagina.grd_4c_Compo.Column1.Text1, "Valid", THIS, "CompoTextValid")
1320: 
1321:         *----------------------------------------------------------------------
1322:         * Botao Inserir Composicao (cmdInserir legado: Top=397+29=426, Left=712, 40x40)
1323:         *----------------------------------------------------------------------
1324:         loc_oPagina.AddObject("cmd_4c_InserirCompo", "CommandButton")
1325:         WITH loc_oPagina.cmd_4c_InserirCompo
1326:             .Caption         = ""
1327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1328:             .PicturePosition = 13
1329:             .ToolTipText     = "Inserir composi" + CHR(231) + CHR(227) + "o"
1330:             .Top             = 426
1331:             .Left            = 712
1332:             .Width           = 40
1333:             .Height          = 40
1334:             .Themes          = .T.
1335:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1336:             .MousePointer    = 15
1337:             .Visible         = .T.
1338:         ENDWITH
1339: 
1340:         *----------------------------------------------------------------------
1341:         * Botao Excluir Composicao (cmdExcluir legado: Top=437+29=466, Left=712, 40x40)
1342:         *----------------------------------------------------------------------
1343:         loc_oPagina.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
1344:         WITH loc_oPagina.cmd_4c_ExcluirCompo
1345:             .Caption         = ""
1346:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1347:             .PicturePosition = 13
1348:             .ToolTipText     = "Excluir composi" + CHR(231) + CHR(227) + "o"
1349:             .Top             = 466
1350:             .Left            = 712
1351:             .Width           = 40
1352:             .Height          = 40
1353:             .Themes          = .T.
1354:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1355:             .MousePointer    = 15
1356:             .Visible         = .T.
1357:         ENDWITH
1358: 
1359:         BINDEVENT(loc_oPagina.cmd_4c_InserirCompo, "Click", THIS, "CompoInserirClick")
1360:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirCompo, "Click", THIS, "CompoExcluirClick")
1361: 
1362:         THIS.TornarControlesVisiveis(loc_oPagina)
1363:     ENDPROC
1364: 
1365:     *===========================================================================

*-- Linhas 1395 a 1405:
1395:                         loc_oGrid.Column3.Alignment = 2
1396: 
1397:                         *-- Headers OBRIGATORIO apos RecordSource (Problema 6/32)
1398:                         loc_oGrid.Column1.Header1.Caption = ""
1399:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1400:                         loc_oGrid.Column3.Header1.Caption = ""
1401: 
1402:                         THIS.FormatarGridLista(loc_oGrid)
1403:                         loc_oGrid.Refresh()
1404:                         loc_lResultado = .T.
1405:                     ENDIF

*-- Linhas 1666 a 1676:
1666:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1667:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1668:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1669:                 loc_oGrid.Column1.Header1.Caption = ""
1670:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1671:                 loc_oGrid.Column3.Header1.Caption = ""
1672:                 loc_oGrid.Refresh()
1673:             ENDIF
1674:         ELSE
1675:             THIS.CarregarLista()
1676:         ENDIF

*-- Linhas 1825 a 1849:
1825: 
1826:         *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
1827:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1828:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1829:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1830:             ENDIF
1831:         ENDIF
1832: 
1833:         *-- Grids e botoes de relacionados: editaveis apenas em INCLUIR/ALTERAR
1834:         IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdOpers", 5)
1835:             loc_oPagina.cnt_4c_CmdOpers.Enabled = loc_lEditar
1836:         ENDIF
1837:         IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdEmps", 5)
1838:             loc_oPagina.cnt_4c_CmdEmps.Enabled = loc_lEditar
1839:         ENDIF
1840:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirCompo", 5)
1841:             loc_oPagina.cmd_4c_InserirCompo.Enabled = loc_lEditar
1842:         ENDIF
1843:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirCompo", 5)
1844:             loc_oPagina.cmd_4c_ExcluirCompo.Enabled = loc_lEditar
1845:         ENDIF
1846:         IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
1847:             loc_oPagina.grd_4c_Compo.ReadOnly = !loc_lEditar
1848:         ENDIF
1849:     ENDPROC

*-- Linhas 1925 a 1934:
1925:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1926: 
1927:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1928:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1929:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1930:             ENDIF
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *===========================================================================

*-- Linhas 2157 a 2190:
2157:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Opers.Imps"
2158:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Opers.Dopes"
2159:                 *-- Headers OBRIGATORIO apos RecordSource (Problema 32)
2160:                 loc_oGrd.Column1.Header1.Caption = ""
2161:                 loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
2162:                 loc_oGrd.Refresh()
2163:             ENDIF
2164: 
2165:             *-- Grid Empresas
2166:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5) AND USED("cursor_4c_Emps")
2167:                 loc_oGrd = loc_oPagina.grd_4c_Emps
2168:                 loc_oGrd.ColumnCount = 3
2169:                 loc_oGrd.RecordSource          = "cursor_4c_Emps"
2170:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Emps.Imps"
2171:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Emps.Emps"
2172:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Emps.Razas"
2173:                 loc_oGrd.Column1.Header1.Caption = ""
2174:                 loc_oGrd.Column2.Header1.Caption = "Emp."
2175:                 loc_oGrd.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2176:                 loc_oGrd.Refresh()
2177:             ENDIF
2178: 
2179:             *-- Grid Composicoes
2180:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5) AND USED("cursor_4c_Compos")
2181:                 loc_oGrd = loc_oPagina.grd_4c_Compo
2182:                 loc_oGrd.ColumnCount = 1
2183:                 loc_oGrd.RecordSource          = "cursor_4c_Compos"
2184:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Compos.Compos"
2185:                 loc_oGrd.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2186:                 loc_oGrd.Refresh()
2187:             ENDIF
2188: 
2189:             loc_lResultado = .T.
2190: 

*-- Linhas 2197 a 2208:
2197:     ENDPROC
2198: 
2199:     *===========================================================================
2200:     * OperCheckboxMouseDown - Toggle Imps em cursor_4c_Opers via mouse
2201:     * PUBLIC: BINDEVENT requer metodo publico
2202:     *===========================================================================
2203:     PROCEDURE OperCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2204:         IF THIS.this_cModoAtual = "VISUALIZAR"
2205:             NODEFAULT
2206:             RETURN
2207:         ENDIF
2208:         IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")

*-- Linhas 2216 a 2243:
2216:     ENDPROC
2217: 
2218:     *===========================================================================
2219:     * OperCheckboxMouseUp - Suprime comportamento padrao
2220:     * PUBLIC: BINDEVENT requer metodo publico
2221:     *===========================================================================
2222:     PROCEDURE OperCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2223:         NODEFAULT
2224:     ENDPROC
2225: 
2226:     *===========================================================================
2227:     * OperCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2228:     * PUBLIC: BINDEVENT requer metodo publico
2229:     *===========================================================================
2230:     PROCEDURE OperCheckboxClick()
2231:         NODEFAULT
2232:     ENDPROC
2233: 
2234:     *===========================================================================
2235:     * OperCheckboxKeyPress - Toggle Imps em cursor_4c_Opers via teclado
2236:     * PUBLIC: BINDEVENT requer metodo publico
2237:     *===========================================================================
2238:     PROCEDURE OperCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2239:         IF THIS.this_cModoAtual = "VISUALIZAR"
2240:             NODEFAULT
2241:             RETURN
2242:         ENDIF
2243:         IF INLIST(par_nKeyCode, 13, 32)

*-- Linhas 2253 a 2264:
2253:     ENDPROC
2254: 
2255:     *===========================================================================
2256:     * EmpCheckboxMouseDown - Toggle Imps em cursor_4c_Emps via mouse
2257:     * PUBLIC: BINDEVENT requer metodo publico
2258:     *===========================================================================
2259:     PROCEDURE EmpCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2260:         IF THIS.this_cModoAtual = "VISUALIZAR"
2261:             NODEFAULT
2262:             RETURN
2263:         ENDIF
2264:         IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")

*-- Linhas 2272 a 2299:
2272:     ENDPROC
2273: 
2274:     *===========================================================================
2275:     * EmpCheckboxMouseUp - Suprime comportamento padrao
2276:     * PUBLIC: BINDEVENT requer metodo publico
2277:     *===========================================================================
2278:     PROCEDURE EmpCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2279:         NODEFAULT
2280:     ENDPROC
2281: 
2282:     *===========================================================================
2283:     * EmpCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2284:     * PUBLIC: BINDEVENT requer metodo publico
2285:     *===========================================================================
2286:     PROCEDURE EmpCheckboxClick()
2287:         NODEFAULT
2288:     ENDPROC
2289: 
2290:     *===========================================================================
2291:     * EmpCheckboxKeyPress - Toggle Imps em cursor_4c_Emps via teclado
2292:     * PUBLIC: BINDEVENT requer metodo publico
2293:     *===========================================================================
2294:     PROCEDURE EmpCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2295:         IF THIS.this_cModoAtual = "VISUALIZAR"
2296:             NODEFAULT
2297:             RETURN
2298:         ENDIF
2299:         IF INLIST(par_nKeyCode, 13, 32)

*-- Linhas 2426 a 2434:
2426:                 loc_oPagina.grd_4c_Compo.ColumnCount = 1
2427:                 loc_oPagina.grd_4c_Compo.RecordSource          = "cursor_4c_Compos"
2428:                 loc_oPagina.grd_4c_Compo.Column1.ControlSource = "cursor_4c_Compos.Compos"
2429:                 loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2430:                 loc_oPagina.grd_4c_Compo.Refresh()
2431:             ENDIF
2432: 
2433:         CATCH TO loException
2434:             MostrarErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;


### BO (C:\4c\projeto\app\classes\MdaBO.prg):
*==============================================================================
* MdaBO.prg - Business Object para Motivos de Desconto / Acrescimo
* Tabela principal: SigCdFs
* Tabelas relacionadas: SigCdFsi (empresas), SigCdFso (operacoes), SigCdFsc (composicoes)
*==============================================================================

DEFINE CLASS MdaBO AS BusinessBase

    *-- Propriedades da tabela SigCdFs
    this_cCodigos    = ""    && codigos char(10) PK
    this_cDescrs     = ""    && descrs char(40)
    this_cTipos      = ""    && tipos char(1) - "D"=Desconto, "A"=Acrescimo
    this_nBlqbonus   = 0     && blqbonus numeric(1,0) - nao gerar bonus (1=Sim, 0=Nao)
    this_nBlqtabds   = 0     && blqtabds numeric(1,0) - bloquear tab.desconto
    this_nChkbins    = 0     && chkbins numeric(1,0) - bloquear desconto BIN
    this_nChkdtanivs = 0     && chkdtanivs numeric(1,0) - checar data aniversario
    this_cGgrus      = ""    && ggrus char(3) - grande grupo
    this_nLimdescs   = 0     && limdescs numeric(5,2) - limite de desconto
    this_dPerfins    = {}    && perfins datetime NULL - periodo fim
    this_dPerinis    = {}    && perinis datetime NULL - periodo inicio
    this_cSgrus      = ""    && sgrus char(6) - sub-grupo
    this_nTpdescs    = 0     && tpdescs numeric(1,0) - tipo desconto (0=Geral, 1=por Produto)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFs"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    SELECT 0 FROM cursor_4c_Dados WHERE .F. INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar motivos de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       " chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       " perinis, sgrus, tpdescs" + ;
                       " FROM SigCdFs" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos,    "C"))
            THIS.this_cDescrs     = ALLTRIM(TratarNulo(descrs,     "C"))
            THIS.this_cTipos      = ALLTRIM(TratarNulo(tipos,      "C"))
            THIS.this_nBlqbonus   = TratarNulo(blqbonus,   "N")
            THIS.this_nBlqtabds   = TratarNulo(blqtabds,   "N")
            THIS.this_nChkbins    = TratarNulo(chkbins,    "N")
            THIS.this_nChkdtanivs = TratarNulo(chkdtanivs, "N")
            THIS.this_cGgrus      = ALLTRIM(TratarNulo(ggrus,  "C"))
            THIS.this_nLimdescs   = TratarNulo(limdescs,   "N")
            THIS.this_dPerfins    = TratarNulo(perfins,    "D")
            THIS.this_dPerinis    = TratarNulo(perinis,    "D")
            THIS.this_cSgrus      = ALLTRIM(TratarNulo(sgrus,  "C"))
            THIS.this_nTpdescs    = TratarNulo(tpdescs,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdFs" + ;
                       " (codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       "  chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       "  perinis, sgrus, tpdescs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqbonus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkdtanivs) + ", " + ;
                       EscaparSQL(THIS.this_cGgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimdescs) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + ", " + ;
                       EscaparSQL(THIS.this_cSgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdFs SET" + ;
                       "  descrs      = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       "  tipos       = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       "  blqbonus    = " + FormatarNumeroSQL(THIS.this_nBlqbonus) + "," + ;
                       "  blqtabds    = " + FormatarNumeroSQL(THIS.this_nBlqtabds) + "," + ;
                       "  chkbins     = " + FormatarNumeroSQL(THIS.this_nChkbins) + "," + ;
                       "  chkdtanivs  = " + FormatarNumeroSQL(THIS.this_nChkdtanivs) + "," + ;
                       "  ggrus       = " + EscaparSQL(THIS.this_cGgrus) + "," + ;
                       "  limdescs    = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
                       "  perfins     = " + IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + "," + ;
                       "  perinis     = " + IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + "," + ;
                       "  sgrus       = " + EscaparSQL(THIS.this_cSgrus) + "," + ;
                       "  tpdescs     = " + FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se motivo esta em uso em SigCdCmt/SigCdClc
            loc_cSQL = "SELECT b.Grupos, b.Codigos" + ;
                       " FROM SigCdCmt a, SigCdClc b" + ;
                       " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                       " AND a.fkChaves = b.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifUso")
            IF loc_nResult < 0
                MsgErro("Erro ao verificar uso do motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN cursor_4c_VerifUso
                IF !EOF("cursor_4c_VerifUso")
                    MsgErro("O Motivo Est" + CHR(225) + " Em Uso No Cadastro de Classifica" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + ;
                            "Grupo : " + ALLTRIM(cursor_4c_VerifUso.Grupos) + ;
                            " - C" + CHR(243) + "digo : " + ALLTRIM(cursor_4c_VerifUso.Codigos), ;
                            "Exclus" + CHR(227) + "o N" + CHR(227) + "o Permitida!!!")
                ELSE
                    *-- Excluir registros relacionados primeiro
                    loc_lSucesso = THIS.ExcluirRelacionados()
                    IF loc_lSucesso
                        loc_cSQL = "DELETE FROM SigCdFs WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
                        IF loc_nResult >= 0
                            THIS.RegistrarAuditoria("DELETE")
                        ELSE
                            MsgErro("Erro ao excluir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Delete")
                            USE IN cursor_4c_Delete
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_VerifUso")
            USE IN cursor_4c_VerifUso
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRelacionados - Salva empresas, operacoes e composicoes do motivo
    * Par: par_cCodigos - codigo do motivo
    * Par: par_cCursorEmps - cursor com empresas selecionadas (csSigCdEmp)
    * Par: par_cCursorOpes - cursor com operacoes selecionadas (csSigCdOpe)
    * Par: par_cCursorCompo - cursor com composicoes (csSigPrCp)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarRelacionados(par_cCodigos, par_cCursorEmps, par_cCursorOpes, par_cCursorCompo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            *-- Deletar relacionamentos anteriores
            loc_lSucesso = THIS.ExcluirRelacionados()

            IF loc_lSucesso
                *-- Inserir empresas selecionadas em SigCdFsi
                IF USED(par_cCursorEmps)
                    SELECT (par_cCursorEmps)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsi (cIdChaves, Codigos, Emps)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Emps)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsEmp")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsEmp")
                                USE IN cursor_4c_InsEmp
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir operacoes selecionadas em SigCdFso
                IF loc_lSucesso AND USED(par_cCursorOpes)
                    SELECT (par_cCursorOpes)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFso (cIdChaves, Codigos, Dopes)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Dopes)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOpe")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsOpe")
                                USE IN cursor_4c_InsOpe
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir composicoes em SigCdFsc
                IF loc_lSucesso AND USED(par_cCursorCompo)
                    SELECT (par_cCursorCompo)
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(Compos))
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsc (cIdChaves, Codigos, Compos)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Compos)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsCompo")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsCompo")
                                USE IN cursor_4c_InsCompo
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.SalvarRelacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirRelacionados - Deleta SigCdFsi/SigCdFso/SigCdFsc pelo codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExcluirRelacionados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFsi WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsi")
            IF USED("cursor_4c_DelFsi")
                USE IN cursor_4c_DelFsi
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFso WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFso")
                IF USED("cursor_4c_DelFso")
                    USE IN cursor_4c_DelFso
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFsc WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsc")
                IF USED("cursor_4c_DelFsc")
                    USE IN cursor_4c_DelFsc
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relacionamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExcluirRelacionados: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Emps com: Imps L, Emps C(3), Razas C(...)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, Cemps AS Emps, Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE NOT Ativas = 2" + ;
                       " ORDER BY Cemps"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")
            IF loc_nResult >= 0
                *-- Marcar empresas vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Emps FROM SigCdFsi WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVinc") >= 0
                        SELECT cursor_4c_EmpsVinc
                        SCAN
                            UPDATE cursor_4c_Emps SET Imps = .T. WHERE Emps = ALLTRIM(cursor_4c_EmpsVinc.Emps)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_EmpsVinc")
                        USE IN cursor_4c_EmpsVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Emps
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarEmpresas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Opers com: Imps L, Dopes C(20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, a.Dopes" + ;
                       " FROM SigCdOpe a INNER JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                       " WHERE b.OpeInatvs <> 1" + ;
                       " ORDER BY a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opers")
            IF loc_nResult >= 0
                *-- Marcar operacoes vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Dopes FROM SigCdFso WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpesVinc") >= 0
                        SELECT cursor_4c_OpesVinc
                        SCAN
                            UPDATE cursor_4c_Opers SET Imps = .T. WHERE Dopes = ALLTRIM(cursor_4c_OpesVinc.Dopes)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_OpesVinc")
                        USE IN cursor_4c_OpesVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Opers
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarOperacoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicoes - Carrega composicoes vinculadas ao motivo para edicao
    * Popula cursor_4c_Compos (readwrite) com: Compos C(30)
    * Par: par_cCodigos - codigo do motivo (vazio = cursor vazio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Compos")
                USE IN cursor_4c_Compos
            ENDIF

            IF EMPTY(par_cCodigos)
                *-- Cursor vazio para inclusao
                SET NULL ON
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Compos FROM SigCdFsc WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " ORDER BY Compos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Compos")
                IF loc_nResult >= 0
                    GO TOP IN cursor_4c_Compos
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarComposicoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicoesProdutos - Cursor de composicoes de SigCdPro para lookup
    * Popula cursor_4c_CsCompos com: Compos C(30)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicoesProdutos()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT Compos FROM SigCdPro ORDER BY Compos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsCompos")
            IF loc_nResult >= 0
                GO TOP IN cursor_4c_CsCompos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es de produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.BuscarComposicoesProdutos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        IF USED("cursor_4c_Opers")
            USE IN cursor_4c_Opers
        ENDIF
        IF USED("cursor_4c_Compos")
            USE IN cursor_4c_Compos
        ENDIF
        IF USED("cursor_4c_CsCompos")
            USE IN cursor_4c_CsCompos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

