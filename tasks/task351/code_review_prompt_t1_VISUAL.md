# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 481: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 505: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBlq.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1138 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible    = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual           = "LISTA"
68: 

*-- Linhas 89 a 106:
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 174:
115: 
116:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Cabecalho cinza (cntSombra.Top=1 + 29 compensacao = 30)
119:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
120:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
121:         WITH loc_oCab
122:             .Top           = 30
123:             .Left          = 0
124:             .Width         = THIS.Width
125:             .Height        = 80
126:             .BackColor     = RGB(100, 100, 100)
127:             .BorderWidth   = 0
128:             .SpecialEffect = 0
129:             .Visible       = .T.
130:         ENDWITH
131: 
132:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oCab.lbl_4c_Sombra
134:             .AutoSize  = .F.
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = THIS.Width
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oCab.lbl_4c_Titulo
150:             .AutoSize  = .F.
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = THIS.Width
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.
159:             .ForeColor = RGB(255, 255, 255)
160:             .BackStyle = 0
161:             .Visible   = .T.
162:         ENDWITH
163: 
164:         *-- Container botoes CRUD (Grupo_op.Left=538, Top=-1 + 29 = 28)
165:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
166:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
167:         WITH loc_oBotoes
168:             .Top           = 28
169:             .Left          =  542
170:             .Width         = 390
171:             .Height        = 85
172:             .BackStyle     = 1
173:             .BackColor     = RGB(53, 53, 53)
174:             .BorderWidth   = 0

*-- Linhas 180 a 350:
180:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
181:         loc_oSaida = loc_oPg1.cnt_4c_Saida
182:         WITH loc_oSaida
183:             .Top           = 29
184:             .Left          = 917
185:             .Width         = 90
186:             .Height        = 85
187:             .BackStyle     = 0
188:             .BorderWidth   = 0
189:             .SpecialEffect = 0
190:             .Visible       = .T.
191:         ENDWITH
192: 
193:         *-- Botoes dentro de cnt_4c_Botoes (Incluir, Visualizar, Alterar, Excluir, Buscar)
194:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
195:         WITH loc_oBotoes.cmd_4c_Incluir
196:             .Caption         = "Incluir"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 5
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
216:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
217: 
218:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
219:         WITH loc_oBotoes.cmd_4c_Visualizar
220:             .Caption         = "Visualizar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 80
225:             .Width           = 75
226:             .Height          = 75
227:             .FontName        = "Comic Sans MS"
228:             .FontBold        = .T.
229:             .FontItalic      = .T.
230:             .FontSize        = 8
231:             .ForeColor       = RGB(90, 90, 90)
232:             .BackColor       = RGB(255, 255, 255)
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
241: 
242:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
243:         WITH loc_oBotoes.cmd_4c_Alterar
244:             .Caption         = "Alterar"
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
246:             .PicturePosition = 13
247:             .Top             = 5
248:             .Left            = 155
249:             .Width           = 75
250:             .Height          = 75
251:             .FontName        = "Comic Sans MS"
252:             .FontBold        = .T.
253:             .FontItalic      = .T.
254:             .FontSize        = 8
255:             .ForeColor       = RGB(90, 90, 90)
256:             .BackColor       = RGB(255, 255, 255)
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .MousePointer    = 15
260:             .WordWrap        = .T.
261:             .AutoSize        = .F.
262:             .Visible         = .T.
263:         ENDWITH
264:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
265: 
266:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
267:         WITH loc_oBotoes.cmd_4c_Excluir
268:             .Caption         = "Excluir"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 230
273:             .Width           = 75
274:             .Height          = 75
275:             .FontName        = "Comic Sans MS"
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .FontSize        = 8
279:             .ForeColor       = RGB(90, 90, 90)
280:             .BackColor       = RGB(255, 255, 255)
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .MousePointer    = 15
284:             .WordWrap        = .T.
285:             .AutoSize        = .F.
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
289: 
290:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
291:         WITH loc_oBotoes.cmd_4c_Buscar
292:             .Caption         = "Buscar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 305
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Comic Sans MS"
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .FontSize        = 8
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:             .Visible         = .T.
311:         ENDWITH
312:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
313: 
314:         *-- Botao Encerrar no cnt_4c_Saida (canonico: Left=5, Top=5, Width=75, Height=75)
315:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
316:         WITH loc_oSaida.cmd_4c_Encerrar
317:             .Caption         = "Encerrar"
318:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
319:             .PicturePosition = 13
320:             .Top             = 5
321:             .Left            = 5
322:             .Width           = 75
323:             .Height          = 75
324:             .FontName        = "Comic Sans MS"
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .FontSize        = 8
328:             .ForeColor       = RGB(90, 90, 90)
329:             .BackColor       = RGB(255, 255, 255)
330:             .Themes          = .F.
331:             .SpecialEffect   = 0
332:             .MousePointer    = 15
333:             .WordWrap        = .T.
334:             .AutoSize        = .F.
335:             .Visible         = .T.
336:         ENDWITH
337:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
338: 
339:         *-- Grid de listagem (Top=117=88+29, Left=26, Width=890, Height=490)
340:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
341:         loc_oPg1.grd_4c_Lista.RecordSource = ""
342:         loc_oPg1.grd_4c_Lista.ColumnCount  = 5
343:         WITH loc_oPg1.grd_4c_Lista
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 490
348:             .FontName           = "Verdana"
349:             .FontSize           = 8
350:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 360 a 376:
360:             .GridLines          = 3
361:             .Visible            = .T.
362:             .Column1.Width           = 80
363:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
364:             .Column2.Width           = 74
365:             .Column2.Header1.Caption = "Data Inicial"
366:             .Column3.Width           = 74
367:             .Column3.Header1.Caption = "Data Final"
368:             .Column4.Width           = 80
369:             .Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
370:             .Column5.Width           = 52
371:             .Column5.Header1.Caption = "Inativo"
372:         ENDWITH
373:         BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
374: 
375:         THIS.TornarControlesVisiveis(loc_oPg1)
376:     ENDPROC

*-- Linhas 406 a 418:
406:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtFinal"
407:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.UsuIncs"
408:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.inativo"
409:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
410:                     loc_oGrid.Column2.Header1.Caption = "Data Inicial"
411:                     loc_oGrid.Column3.Header1.Caption = "Data Final"
412:                     loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
413:                     loc_oGrid.Column5.Header1.Caption = "Inativo"
414:                     THIS.FormatarGridLista(loc_oGrid)
415:                     loc_lResultado = .T.
416:                 ENDIF
417:             CATCH TO loc_oErro
418:                 MsgErro(loc_oErro.Message, "FormBlq.CarregarLista")

*-- Linhas 456 a 531:
456: 
457:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
458: 
459:         *-- Container Confirmar/Cancelar (Grupo_Salva.Left=812, Top=24 + 29 = 53)
460:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
461:         loc_oSalva = loc_oPg2.cnt_4c_Salva
462:         WITH loc_oSalva
463:             .Top           = 53
464:             .Left          = 812
465:             .Width         = 160
466:             .Height        = 85
467:             .BackStyle     = 0
468:             .SpecialEffect = 0
469:             .Visible       = .T.
470:         ENDWITH
471: 
472:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
473:         WITH loc_oSalva.cmd_4c_Confirmar
474:             .Caption         = "Confirmar"
475:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
476:             .PicturePosition = 13
477:             .Top             = 5
478:             .Left            = 5
479:             .Width           = 75
480:             .Height          = 75
481:             .FontName        = "Comic Sans MS"
482:             .FontBold        = .T.
483:             .FontItalic      = .T.
484:             .FontSize        = 8
485:             .ForeColor       = RGB(90, 90, 90)
486:             .BackColor       = RGB(255, 255, 255)
487:             .Themes          = .F.
488:             .SpecialEffect   = 0
489:             .MousePointer    = 15
490:             .WordWrap        = .T.
491:             .AutoSize        = .F.
492:             .Visible         = .T.
493:         ENDWITH
494:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
495: 
496:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
497:         WITH loc_oSalva.cmd_4c_Cancelar
498:             .Caption         = "Encerrar"
499:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
500:             .PicturePosition = 13
501:             .Top             = 5
502:             .Left            = 80
503:             .Width           = 75
504:             .Height          = 75
505:             .FontName        = "Comic Sans MS"
506:             .FontBold        = .T.
507:             .FontItalic      = .T.
508:             .FontSize        = 8
509:             .ForeColor       = RGB(90, 90, 90)
510:             .BackColor       = RGB(255, 255, 255)
511:             .Themes          = .F.
512:             .SpecialEffect   = 0
513:             .MousePointer    = 15
514:             .WordWrap        = .T.
515:             .AutoSize        = .F.
516:             .Visible         = .T.
517:         ENDWITH
518:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
519: 
520:         *-- Say1: Label "C" + CHR(243) + "digo :"
521:         *-- Original: top=141, left=390 -> top+29=170
522:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
523:         WITH loc_oPg2.lbl_4c_Codigo
524:             .Caption   = "C" + CHR(243) + "digo :"
525:             .Top       = 170
526:             .Left      = 390
527:             .Width     = 45
528:             .Height    = 17
529:             .BackStyle = 0
530:             .ForeColor = RGB(90, 90, 90)
531:             .FontName  = "Tahoma"

*-- Linhas 540 a 585:
540:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
541:         WITH loc_oPg2.txt_4c_Codigo
542:             .Value       = ""
543:             .Top         = 166
544:             .Left        = 435
545:             .Width       = 82
546:             .Height      = 23
547:             .FontName    = "Tahoma"
548:             .FontSize    = 8
549:             .ForeColor   = RGB(90, 90, 90)
550:             .BackColor   = RGB(255, 255, 255)
551:             .ReadOnly    = .T.
552:             .Enabled     = .T.
553:             .Visible     = .T.
554:         ENDWITH
555: 
556:         *-- Check1: CheckBox "Inativo"
557:         *-- Original: top=141, left=542, width=52, height=15 -> top+29=170
558:         loc_oPg2.AddObject("chk_4c_Check1", "CheckBox")
559:         WITH loc_oPg2.chk_4c_Check1
560:             .Caption   = "Inativo"
561:             .Value     = 0
562:             .Top       = 170
563:             .Left      = 542
564:             .Width     = 52
565:             .Height    = 15
566:             .BackStyle = 0
567:             .ForeColor = RGB(90, 90, 90)
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .Enabled   = .F.
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         *-- Say15: Label "Per" + CHR(237) + "odo :"
575:         *-- Original: top=167, left=387, width=45, height=13 -> top+29=196
576:         loc_oPg2.AddObject("lbl_4c_Periodo", "Label")
577:         WITH loc_oPg2.lbl_4c_Periodo
578:             .Caption   = "Per" + CHR(237) + "odo :"
579:             .Top       = 196
580:             .Left      = 387
581:             .Width     = 45
582:             .Height    = 13
583:             .BackStyle = 0
584:             .ForeColor = RGB(90, 90, 90)
585:             .FontName  = "Tahoma"

*-- Linhas 591 a 603:
591: 
592:         *-- Say2: Label "At" + CHR(233)
593:         *-- Original: top=167, left=508, width=19 -> top+29=196
594:         loc_oPg2.AddObject("lbl_4c_Ate", "Label")
595:         WITH loc_oPg2.lbl_4c_Ate
596:             .Caption   = "At" + CHR(233)
597:             .Top       = 196
598:             .Left      = 508
599:             .Width     = 19
600:             .Height    = 13
601:             .BackStyle = 0
602:             .ForeColor = RGB(90, 90, 90)
603:             .FontName  = "Tahoma"

*-- Linhas 611 a 620:
611:         loc_oPg2.AddObject("txt_4c_Dtinicial", "TextBox")
612:         WITH loc_oPg2.txt_4c_Dtinicial
613:             .Value     = {}
614:             .Top       = 192
615:             .Left      = 435
616:             .Width     = 66
617:             .Height    = 23
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 628 a 637:
628:         loc_oPg2.AddObject("txt_4c_Dtfinal", "TextBox")
629:         WITH loc_oPg2.txt_4c_Dtfinal
630:             .Value     = {}
631:             .Top       = 192
632:             .Left      = 530
633:             .Width     = 66
634:             .Height    = 23
635:             .FontName  = "Tahoma"
636:             .FontSize  = 8
637:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 644 a 701:
644:         *-- Original: top=235, left=435, width=161, height=2 -> top+29=264
645:         loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
646:         WITH loc_oPg2.shp_4c_Shape3
647:             .Top         = 264
648:             .Left        = 435
649:             .Width       = 161
650:             .Height      = 2
651:             .ForeColor   = RGB(90, 90, 90)
652:             .BorderColor = RGB(90, 90, 90)
653:             .Visible     = .T.
654:         ENDWITH
655: 
656:         *-- Say20: Titulo da secao de auditoria "Data / Usuario"
657:         *-- Original: top=220, left=435, width=84 -> top+29=249
658:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
659:         WITH loc_oPg2.lbl_4c_Label20
660:             .Caption   = "Data / Usu" + CHR(225) + "rio"
661:             .Top       = 249
662:             .Left      = 435
663:             .Width     = 84
664:             .Height    = 17
665:             .BackStyle = 0
666:             .ForeColor = RGB(90, 90, 90)
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .FontBold  = .F.
670:             .Visible   = .T.
671:         ENDWITH
672: 
673:         *-- Say24: Label "Inclusao"
674:         *-- Original: top=239, left=435, width=42, height=15 -> top+29=268
675:         loc_oPg2.AddObject("lbl_4c_Label24", "Label")
676:         WITH loc_oPg2.lbl_4c_Label24
677:             .Caption   = "Inclus" + CHR(227) + "o"
678:             .Top       = 268
679:             .Left      = 435
680:             .Width     = 42
681:             .Height    = 15
682:             .BackStyle = 0
683:             .ForeColor = RGB(90, 90, 90)
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .FontBold  = .F.
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Say25: Label "Alteracao"
691:         *-- Original: top=239, left=515, width=48, height=15 -> top+29=268
692:         loc_oPg2.AddObject("lbl_4c_Label25", "Label")
693:         WITH loc_oPg2.lbl_4c_Label25
694:             .Caption   = "Altera" + CHR(231) + CHR(227) + "o"
695:             .Top       = 268
696:             .Left      = 515
697:             .Width     = 48
698:             .Height    = 15
699:             .BackStyle = 0
700:             .ForeColor = RGB(90, 90, 90)
701:             .FontName  = "Tahoma"

*-- Linhas 709 a 718:
709:         loc_oPg2.AddObject("txt_4c_DtIncs", "TextBox")
710:         WITH loc_oPg2.txt_4c_DtIncs
711:             .Value     = {}
712:             .Top       = 283
713:             .Left      = 435
714:             .Width     = 79
715:             .Height    = 23
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 727 a 736:
727:         loc_oPg2.AddObject("txt_4c_Usuario", "TextBox")
728:         WITH loc_oPg2.txt_4c_Usuario
729:             .Value     = ""
730:             .Top       = 308
731:             .Left      = 435
732:             .Width     = 79
733:             .Height    = 23
734:             .FontName  = "Tahoma"
735:             .FontSize  = 8
736:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 745 a 754:
745:         loc_oPg2.AddObject("txt_4c_DataAlts", "TextBox")
746:         WITH loc_oPg2.txt_4c_DataAlts
747:             .Value     = {}
748:             .Top       = 283
749:             .Left      = 515
750:             .Width     = 79
751:             .Height    = 23
752:             .FontName  = "Tahoma"
753:             .FontSize  = 8
754:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 763 a 772:
763:         loc_oPg2.AddObject("txt_4c_UsuaAlts", "TextBox")
764:         WITH loc_oPg2.txt_4c_UsuaAlts
765:             .Value     = ""
766:             .Top       = 308
767:             .Left      = 515
768:             .Width     = 79
769:             .Height    = 23
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 892 a 901:
892:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
893:         loc_oSalva = loc_oPg2.cnt_4c_Salva
894: 
895:         loc_oSalva.cmd_4c_Confirmar.Enabled = !INLIST(THIS.this_cModoAtual, "VISUALIZAR")
896:         loc_oSalva.cmd_4c_Cancelar.Enabled  = .T.
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
901:     *--------------------------------------------------------------------------

*-- Linhas 1058 a 1070:
1058:                     loc_oGrid.Column3.ControlSource   = "cursor_4c_Dados.dtFinal"
1059:                     loc_oGrid.Column4.ControlSource   = "cursor_4c_Dados.UsuIncs"
1060:                     loc_oGrid.Column5.ControlSource   = "cursor_4c_Dados.inativo"
1061:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1062:                     loc_oGrid.Column2.Header1.Caption = "Data Inicial"
1063:                     loc_oGrid.Column3.Header1.Caption = "Data Final"
1064:                     loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
1065:                     loc_oGrid.Column5.Header1.Caption = "Inativo"
1066:                     THIS.FormatarGridLista(loc_oGrid)
1067:                 ENDIF
1068:             CATCH TO loc_oErro
1069:                 MsgErro(loc_oErro.Message, "FormBlq.BtnSalvarClick.Buscar")
1070:             ENDTRY


### BO (C:\4c\projeto\app\classes\BlqBO.prg):
*------------------------------------------------------------------------------
* BlqBO.prg - Business Object para Bloqueios por Periodo (SigCdBlq)
* Herda de: BusinessBase
* Tabela: SigCdBlq
*------------------------------------------------------------------------------
DEFINE CLASS BlqBO AS BusinessBase

    *-- Propriedades da tabela SigCdBlq
    this_cCodigos   = ""    && Codigos    CHAR(10) - C" + CHR(243) + "digo gerado por fGerUniqueKey('BLOQUEIO')
    this_cCidChaves = ""    && CidChaves  CHAR     - Chave " + CHR(250) + "nica interna (gerada por fUniqueIds)
    this_dDtInicial = {}    && dtInicial  DATE     - Data inicial do per" + CHR(237) + "odo de bloqueio
    this_dDtFinal   = {}    && dtFinal    DATE     - Data final do per" + CHR(237) + "odo de bloqueio
    this_lInativo   = .F.   && inativo    LOGICAL  - Flag de registro inativo
    this_cUsuIncs   = ""    && UsuIncs    CHAR     - Usu" + CHR(225) + "rio de inclus" + CHR(227) + "o (somente leitura)
    this_dDtIncs    = {}    && DtIncs     DATETIME - Data/hora de inclus" + CHR(227) + "o (somente leitura)
    this_cUsuAlts   = ""    && UsuAlts    CHAR     - Usu" + CHR(225) + "rio de altera" + CHR(231) + CHR(227) + "o (somente leitura)
    this_dDtAlts    = {}    && DtAlts     DATETIME - Data/hora de altera" + CHR(231) + CHR(227) + "o (somente leitura)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdBlq"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_dDtInicial = TratarNulo(dtInicial, "D")
            THIS.this_dDtFinal   = TratarNulo(dtFinal,   "D")
            THIS.this_lInativo   = ConverterParaLogico(inativo)
            THIS.this_cUsuIncs   = TratarNulo(UsuIncs,   "C")
            THIS.this_dDtIncs    = TratarNulo(DtIncs,    "D")
            THIS.this_cUsuAlts   = TratarNulo(UsuAlts,   "C")
            THIS.this_dDtAlts    = TratarNulo(DtAlts,    "D")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros da tabela (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, dtInicial, dtFinal, UsuIncs, DtIncs," + ;
                       " UsuAlts, DtAlts, inativo" + ;
                       " FROM SigCdBlq"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar bloqueios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       " UsuIncs, DtIncs, UsuAlts, DtAlts" + ;
                       " FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Inclui novo registro no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCodigos   = fGerMascara(fGerUniqueKey("BLOQUEIO"))
            THIS.this_cCidChaves = fUniqueIds()
            THIS.this_cUsuIncs   = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "INSERT INTO SigCdBlq" + ;
                       " (Codigos, CidChaves, dtInicial, dtFinal, inativo," + ;
                       "  UsuIncs, DtIncs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtInicial) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtFinal) + ", " + ;
                       IIF(THIS.this_lInativo, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cUsuIncs) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao incluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente no banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuAlts = ALLTRIM(gc_4c_UsuarioLogado)

            loc_cSQL = "UPDATE SigCdBlq SET" + ;
                       " dtInicial = " + FormatarDataSQL(THIS.this_dDtInicial) + "," + ;
                       " dtFinal   = " + FormatarDataSQL(THIS.this_dDtFinal) + "," + ;
                       " inativo   = " + IIF(THIS.this_lInativo, "1", "0") + "," + ;
                       " UsuAlts   = " + EscaparSQL(THIS.this_cUsuAlts) + "," + ;
                       " DtAlts    = GETDATE()" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro do banco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdBlq" + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir bloqueio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BlqBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

