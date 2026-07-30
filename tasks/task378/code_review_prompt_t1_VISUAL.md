# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 193: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 243: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 268: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 293: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 329: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 411: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 436: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1490 linhas total):

*-- Linhas 52 a 60:
52: 
53:         TRY
54:             *-- Caption com acentos via CHR()
55:             THIS.Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
56: 
57:             *-- Criar Business Object
58:             THIS.this_oBusinessObject = CREATEOBJECT("COCBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 93 a 109:
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94:         WITH THIS.pgf_4c_Paginas
95:             .PageCount = 2
96:             .Top = -29
97:             .Left = 0
98:             .Width = THIS.Width
99:             .Height = THIS.Height + 29
100:             .Tabs = .F.
101:             .Page1.Caption = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Visible = .T.
108:         ENDWITH
109: 

*-- Linhas 122 a 354:
122:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
123: 
124:         *-- Container cabecalho cinza (cntSombra no legado)
125:         *-- Top = 2 (original) + 29 (compensacao PageFrame.Top=-29) = 31
126:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH loc_oPagina.cnt_4c_Cabecalho
128:             .Top = 31
129:             .Left = 0
130:             .Width = THIS.Width
131:             .Height = 80
132:             .BackColor = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Top = 15
140:             .Left = 10
141:             .Width = 769
142:             .Height = 40
143:             .Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
144:             .FontName = "Tahoma"
145:             .FontSize = 16
146:             .FontBold = .T.
147:             .ForeColor = RGB(0, 0, 0)
148:             .BackStyle = 0
149:             .AutoSize = .F.
150:             .Visible = .T.
151:         ENDWITH
152: 
153:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Top = 18
156:             .Left = 10
157:             .Width = 769
158:             .Height = 46
159:             .Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
160:             .FontName = "Tahoma"
161:             .FontSize = 16
162:             .FontBold = .T.
163:             .ForeColor = RGB(255, 255, 255)
164:             .BackStyle = 0
165:             .AutoSize = .F.
166:             .Visible = .T.
167:         ENDWITH
168: 
169:         *-- Container botoes CRUD - lado direito (Grupo_Op no legado, Top=0+29=29)
170:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
171:         WITH loc_oPagina.cnt_4c_Botoes
172:             .Top = 29
173:             .Left = 542
174:             .Width = 390
175:             .Height = 85
176:             .BackStyle = 0
177:             .BorderWidth = 0
178:             .Visible = .T.
179:         ENDWITH
180: 
181:         *-- Botao Incluir
182:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
183:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
184:             .Caption         = "Incluir"
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
186:             .PicturePosition = 13
187:             .Top             = 5
188:             .Left            = 5
189:             .Width           = 75
190:             .Height          = 75
191:             .BackColor       = RGB(255, 255, 255)
192:             .ForeColor       = RGB(90, 90, 90)
193:             .FontName        = "Comic Sans MS"
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .FontSize        = 8
197:             .Themes          = .F.
198:             .SpecialEffect   = 0
199:             .WordWrap        = .T.
200:             .AutoSize        = .F.
201:             .MousePointer    = 15
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
205: 
206:         *-- Botao Visualizar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 80
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .MousePointer    = 15
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
230: 
231:         *-- Botao Alterar
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
234:             .Caption         = "Alterar"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
236:             .PicturePosition = 13
237:             .Top             = 5
238:             .Left            = 155
239:             .Width           = 75
240:             .Height          = 75
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .FontName        = "Comic Sans MS"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .MousePointer    = 15
252:             .Visible         = .T.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
255: 
256:         *-- Botao Excluir
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
259:             .Caption         = "Excluir"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .FontName        = "Comic Sans MS"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .MousePointer    = 15
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
280: 
281:         *-- Botao Buscar
282:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Comic Sans MS"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .Themes          = .F.
298:             .SpecialEffect   = 0
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .MousePointer    = 15
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top = 29
310:             .Left = 917
311:             .Width = 90
312:             .Height = 85
313:             .BackStyle = 0
314:             .BorderWidth = 0
315:             .Visible = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Comic Sans MS"
330:             .FontBold        = .T.
331:             .FontItalic      = .T.
332:             .FontSize        = 8
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .WordWrap        = .T.
336:             .AutoSize        = .F.
337:             .MousePointer    = 15
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid da lista: Codigos(80), Descrs(600), Opers(80)
343:         *-- Top = 121 (original) + 29 (compensacao PageFrame) = 150
344:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
345:         loc_oPagina.grd_4c_Lista.RecordSource = ""
346:         loc_oPagina.grd_4c_Lista.ColumnCount  = 3
347:         WITH loc_oPagina.grd_4c_Lista
348:             .Top                = 150
349:             .Left               = 12
350:             .Width              = 900
351:             .Height             = 474
352:             .FontName           = "Verdana"
353:             .FontSize           = 8
354:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 388 a 460:
388:         *-- Top = 9 (original) + 29 (compensacao) = 38; Left = 817 (original)
389:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
390:         WITH loc_oPagina.cnt_4c_BotoesAcao
391:             .Top         = 38
392:             .Left        = 817
393:             .Width       = 160
394:             .Height      = 85
395:             .BackStyle   = 0
396:             .Visible     = .T.
397:         ENDWITH
398: 
399:         *-- Botao Confirmar (Salva no legado)
400:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
402:             .Caption         = "Confirmar"
403:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
404:             .PicturePosition = 13
405:             .Top             = 5
406:             .Left            = 5
407:             .Width           = 75
408:             .Height          = 75
409:             .BackColor       = RGB(255, 255, 255)
410:             .ForeColor       = RGB(90, 90, 90)
411:             .FontName        = "Comic Sans MS"
412:             .FontBold        = .T.
413:             .FontItalic      = .T.
414:             .FontSize        = 8
415:             .Themes          = .F.
416:             .SpecialEffect   = 0
417:             .WordWrap        = .T.
418:             .AutoSize        = .F.
419:             .MousePointer    = 15
420:             .Visible         = .T.
421:         ENDWITH
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423: 
424:         *-- Botao Cancelar
425:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
426:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
427:             .Caption         = "Encerrar"
428:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
429:             .PicturePosition = 13
430:             .Top             = 5
431:             .Left            = 80
432:             .Width           = 75
433:             .Height          = 75
434:             .BackColor       = RGB(255, 255, 255)
435:             .ForeColor       = RGB(90, 90, 90)
436:             .FontName        = "Comic Sans MS"
437:             .FontBold        = .T.
438:             .FontItalic      = .T.
439:             .FontSize        = 8
440:             .Themes          = .F.
441:             .SpecialEffect   = 0
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .MousePointer    = 15
445:             .Visible         = .T.
446:         ENDWITH
447:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
448: 
449:         *-- Label Codigo
450:         *-- sayCodigo original: Top=109+29=138, Left=246
451:         loc_oPagina.AddObject("lbl_4c_SayCodigo", "Label")
452:         WITH loc_oPagina.lbl_4c_SayCodigo
453:             .Caption    = "C" + CHR(243) + "digo :"
454:             .Top        = 138
455:             .Left       = 246
456:             .Width      = 50
457:             .Height     = 17
458:             .FontName   = "Tahoma"
459:             .FontSize   = 8
460:             .FontBold   = .F.

*-- Linhas 470 a 479:
470:         *-- getCodigo original: Top=106+29=135, Left=293, Width=80
471:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
472:         WITH loc_oPagina.txt_4c_Codigo
473:             .Top               = 135
474:             .Left              = 293
475:             .Width             = 80
476:             .Height            = 20
477:             .InputMask         = "XXXXXXXXXX"
478:             .Format            = "!"
479:             .BorderStyle       = 1

*-- Linhas 489 a 501:
489: 
490:         *-- Label Descricao
491:         *-- sayDescricao original: Top=134+29=163, Left=233
492:         loc_oPagina.AddObject("lbl_4c_SayDescricao", "Label")
493:         WITH loc_oPagina.lbl_4c_SayDescricao
494:             .Caption    = "Descri" + CHR(231) + CHR(227) + "o :"
495:             .Top        = 163
496:             .Left       = 233
497:             .Width      = 58
498:             .Height     = 17
499:             .FontName   = "Tahoma"
500:             .FontSize   = 8
501:             .FontBold   = .F.

*-- Linhas 511 a 520:
511:         *-- getDescricao original: Top=131+29=160, Left=293, Width=220, Height=23
512:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
513:         WITH loc_oPagina.txt_4c_Descricao
514:             .Top           = 160
515:             .Left          = 293
516:             .Width         = 220
517:             .Height        = 23
518:             .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
519:             .Format        = "!"
520:             .BorderStyle   = 1

*-- Linhas 529 a 541:
529: 
530:         *-- Label Grupo
531:         *-- sayGrupo original: Top=159+29=188, Left=250
532:         loc_oPagina.AddObject("lbl_4c_SayGrupo", "Label")
533:         WITH loc_oPagina.lbl_4c_SayGrupo
534:             .Caption    = "Grupo :"
535:             .Top        = 188
536:             .Left       = 250
537:             .Width      = 41
538:             .Height     = 17
539:             .FontName   = "Tahoma"
540:             .FontSize   = 8
541:             .FontBold   = .F.

*-- Linhas 551 a 560:
551:         *-- Get_grupo original: Top=156+29=185, Left=293, Width=80
552:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
553:         WITH loc_oPagina.txt_4c_Grupo
554:             .Top           = 185
555:             .Left          = 293
556:             .Width         = 80
557:             .Height        = 20
558:             .BorderStyle   = 1
559:             .SpecialEffect = 1
560:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 569 a 581:
569: 
570:         *-- Label Conta
571:         *-- sayConta original: Top=184+29=213, Left=250
572:         loc_oPagina.AddObject("lbl_4c_SayConta", "Label")
573:         WITH loc_oPagina.lbl_4c_SayConta
574:             .Caption    = "Conta :"
575:             .Top        = 213
576:             .Left       = 250
577:             .Width      = 41
578:             .Height     = 17
579:             .FontName   = "Tahoma"
580:             .FontSize   = 8
581:             .FontBold   = .F.

*-- Linhas 591 a 600:
591:         *-- Get_conta original: Top=181+29=210, Left=293, Width=80
592:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
593:         WITH loc_oPagina.txt_4c_Conta
594:             .Top               = 210
595:             .Left              = 293
596:             .Width             = 80
597:             .Height            = 20
598:             .BorderStyle       = 1
599:             .SpecialEffect     = 1
600:             .ForeColor         = RGB(0, 0, 0)

*-- Linhas 612 a 621:
612:         *-- Habilitado apenas quando Conta estiver vazio (replicando When do legado)
613:         loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
614:         WITH loc_oPagina.txt_4c_Dconta
615:             .Top               = 210
616:             .Left              = 375
617:             .Width             = 250
618:             .Height            = 20
619:             .BorderStyle       = 1
620:             .SpecialEffect     = 1
621:             .ForeColor         = RGB(0, 0, 0)

*-- Linhas 631 a 643:
631: 
632:         *-- Label Movimento (Say1)
633:         *-- Say1 original: Top=212+29=241, Left=227
634:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
635:         WITH loc_oPagina.lbl_4c_Label1
636:             .Caption    = "Movimento :"
637:             .Top        = 241
638:             .Left       = 227
639:             .Width      = 63
640:             .Height     = 17
641:             .FontName   = "Tahoma"
642:             .FontSize   = 8
643:             .FontBold   = .F.

*-- Linhas 650 a 702:
650:         ENDWITH
651: 
652:         *-- OptionGroup OpcaoOcorrencia (Debito=1/Credito=2)
653:         *-- OpcaoOcorrencia original: Top=207+29=236, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
654:         loc_oPagina.AddObject("opt_4c_OpcaoOcorrencia", "OptionGroup")
655:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia
656:             .ButtonCount = 2
657:             .Top         = 236
658:             .Left        = 288
659:             .Width       = 142
660:             .Height      = 26
661:             .BackStyle   = 0
662:             .BorderStyle = 0
663:             .Value       = 1
664:             .Visible     = .T.
665:         ENDWITH
666:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(1)
667:             .Caption   = "D" + CHR(233) + "bito"
668:             .Left      = 5
669:             .Top       = 5
670:             .Width     = 60
671:             .AutoSize  = .T.
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .ForeColor = RGB(90, 90, 90)
676:             .Themes    = .F.
677:         ENDWITH
678:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(2)
679:             .Caption   = "Cr" + CHR(233) + "dito"
680:             .Left      = 72
681:             .Top       = 5
682:             .Width     = 60
683:             .AutoSize  = .T.
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .BackStyle = 0
687:             .ForeColor = RGB(90, 90, 90)
688:             .Themes    = .F.
689:         ENDWITH
690: 
691:         *-- Label Lanca Contabilidade (Say2)
692:         *-- Say2 original: Top=239+29=268, Left=183
693:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
694:         WITH loc_oPagina.lbl_4c_Label2
695:             .Caption    = "Lan" + CHR(231) + "a Contabilidade :"
696:             .Top        = 268
697:             .Left       = 183
698:             .Width      = 103
699:             .Height     = 17
700:             .FontName   = "Tahoma"
701:             .FontSize   = 8
702:             .FontBold   = .F.

*-- Linhas 709 a 761:
709:         ENDWITH
710: 
711:         *-- OptionGroup Opcaocontab (Sim=1 / Nao=2, padrao=2)
712:         *-- Opcaocontab original: Top=234+29=263, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
713:         loc_oPagina.AddObject("opt_4c_Opcaocontab", "OptionGroup")
714:         WITH loc_oPagina.opt_4c_Opcaocontab
715:             .ButtonCount = 2
716:             .Top         = 263
717:             .Left        = 288
718:             .Width       = 122
719:             .Height      = 26
720:             .BackStyle   = 0
721:             .BorderStyle = 0
722:             .Value       = 2
723:             .Visible     = .T.
724:         ENDWITH
725:         WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(1)
726:             .Caption   = "Sim"
727:             .Left      = 5
728:             .Top       = 5
729:             .Width     = 40
730:             .AutoSize  = .T.
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .BackStyle = 0
734:             .ForeColor = RGB(90, 90, 90)
735:             .Themes    = .F.
736:         ENDWITH
737:         WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(2)
738:             .Caption   = "N" + CHR(227) + "o"
739:             .Left      = 72
740:             .Top       = 5
741:             .Width     = 40
742:             .AutoSize  = .T.
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .BackStyle = 0
746:             .ForeColor = RGB(90, 90, 90)
747:             .Themes    = .F.
748:         ENDWITH
749: 
750:         *-- Label Opcao (Say3)
751:         *-- Say3 original: Top=264+29=293, Left=248
752:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
753:         WITH loc_oPagina.lbl_4c_Label3
754:             .Caption    = "Op" + CHR(231) + CHR(227) + "o :"
755:             .Top        = 293
756:             .Left       = 248
757:             .Width      = 41
758:             .Height     = 17
759:             .FontName   = "Tahoma"
760:             .FontSize   = 8
761:             .FontBold   = .F.

*-- Linhas 769 a 817:
769: 
770:         *-- OptionGroup OpcaoSNA (3 opcoes com captions de SigCdPac)
771:         *-- OpcaoSNA original: Top=260+29=289, Left=288, Width=197, Height=25
772:         *-- Buttons: Option1.Left=5, Option2.Left=73, Option3.Left=142
773:         loc_oPagina.AddObject("opt_4c_OpcaoSNA", "OptionGroup")
774:         WITH loc_oPagina.opt_4c_OpcaoSNA
775:             .ButtonCount = 3
776:             .Top         = 289
777:             .Left        = 288
778:             .Width       = 202
779:             .Height      = 25
780:             .BackStyle   = 0
781:             .BorderStyle = 0
782:             .Value       = 0
783:             .Visible     = .T.
784:         ENDWITH
785:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(1)
786:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcS
787:             .Left      = 5
788:             .Top       = 5
789:             .Width     = 34
790:             .AutoSize  = .T.
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .BackStyle = 0
794:             .ForeColor = RGB(90, 90, 90)
795:             .Themes    = .F.
796:         ENDWITH
797:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(2)
798:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcN
799:             .Left      = 73
800:             .Top       = 5
801:             .Width     = 37
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .BackStyle = 0
806:             .ForeColor = RGB(90, 90, 90)
807:             .Themes    = .F.
808:         ENDWITH
809:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(3)
810:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcA
811:             .Left      = 142
812:             .Top       = 5
813:             .Width     = 50
814:             .AutoSize  = .T.
815:             .FontName  = "Tahoma"
816:             .FontSize  = 8
817:             .BackStyle = 0

*-- Linhas 842 a 852:
842:                     .Column1.Width            = 80
843:                     .Column2.Width            = 600
844:                     .Column3.Width            = 80
845:                     .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
846:                     .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
847:                     .Column3.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
848:                     .Column1.Header1.FontBold = .T.
849:                     .Column2.Header1.FontBold = .T.
850:                     .Column3.Header1.FontBold = .T.
851:                 ENDWITH
852:                 THIS.FormatarGridLista(loc_oGrid)


### BO (C:\4c\projeto\app\classes\COCBO.prg):
*==============================================================================
* COCBO.prg - Business Object para Ocorrencias de Titulos (COC)
* Tabela: SigOpOco | PK: Codigos
* Schema: Codigos char(10), Descrs char(30), Grupos char, Contas char,
*         DContas char, Opers char(2), Contabs numeric, Notas numeric
*==============================================================================

DEFINE CLASS COCBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigOpOco)
    this_cCodigos  = ""    && Codigos  CHAR(10) - Codigo da Ocorrencia (PK)
    this_cDescrs   = ""    && Descrs   CHAR(30) - Descricao
    this_cGrupos   = ""    && Grupos   CHAR     - Codigo do Grupo (FK->SigCdGcr.Codigos)
    this_cContas   = ""    && Contas   CHAR     - Conta (FK->SigCdCli)
    this_cDContas  = ""    && DContas  CHAR     - Descricao da Conta (D-conta)
    this_cOpers    = ""    && Opers    CHAR(2)  - Tipo de Operacao ("DB"=Debito, "CR"=Credito)
    this_nContabs  = 0     && Contabs  NUMERIC  - Lanca Contabilidade (1=Sim, 2=Nao)
    this_nNotas    = 0     && Notas    NUMERIC  - Opcao SNA (1=Sim, 2=Nao, 3=Ambos)

    *-- Parametros de SigCdPac para captions do OpcaoSNA
    this_cTitOpcS  = "Sim"
    this_cTitOpcN  = "N" + CHR(227) + "o"
    this_cTitOpcA  = "Ambos"

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpOco"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de SigCdPac (captions OpcaoSNA)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"

            IF USED("cursor_4c_Params")
                TABLEREVERT(.T., "cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cTitOpcS = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcS, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcS, "C")), "Sim")
                THIS.this_cTitOpcN = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcN, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcN, "C")), "N" + CHR(227) + "o")
                THIS.this_cTitOpcA = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcA, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcA, "C")), "Ambos")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarParametros")
        ENDTRY

        IF USED("cursor_4c_Params")
            USE IN cursor_4c_Params
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            THIS.this_cGrupos  = TratarNulo(Grupos,  "C")
            THIS.this_cContas  = TratarNulo(Contas,  "C")
            THIS.this_cDContas = TratarNulo(DContas, "C")
            THIS.this_cOpers   = TratarNulo(Opers,   "C")
            THIS.this_nContabs = TratarNulo(Contabs, "N")
            THIS.this_nNotas   = TratarNulo(Notas,   "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupo - Valida/busca grupo em SigCdGcr pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaGrupo") > 0
            ELSE
                MostrarErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.BuscarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_ChkExiste")
                TABLEREVERT(.T., "cursor_4c_ChkExiste")
                USE IN cursor_4c_ChkExiste
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkExiste") > 0
                SELECT cursor_4c_ChkExiste
                loc_lExiste = (cursor_4c_ChkExiste.nExiste > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.VerificarCodigoExiste")
        ENDTRY

        IF USED("cursor_4c_ChkExiste")
            USE IN cursor_4c_ChkExiste
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpOco" + ;
                       " (Codigos, Descrs, Grupos, Contas, DContas, Opers, Contabs, Notas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOco SET" + ;
                       " Descrs  = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       " Grupos  = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       " Contas  = " + EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       " DContas = " + EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       " Opers   = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       " Contabs = " + FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       " Notas   = " + FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

