# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 212: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 281: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 316: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 415: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1613 linhas total):

*-- Linhas 55 a 69:
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
57:             ELSE
58:                 THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
59: 
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
67:                     IF !THIS.CarregarLista()
68:                         *-- Falha ao carregar nao impede abertura do formulario
69:                     ENDIF

*-- Linhas 91 a 111:
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
93:         WITH THIS.pgf_4c_Paginas
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1003
97:             .Height     = 629
98:             .PageCount  = 2
99:             .Tabs       = .F.
100:             .Visible    = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110:     ENDPROC
111: 

*-- Linhas 121 a 159:
121:         *-- Container cabecalho escuro (cntSombra: Top=2+29=31)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = 1020
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BackStyle   = 1
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width
140:             .Height    = 40
141:             .AutoSize  = .F.
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .BackStyle = 0
146:             .ForeColor = RGB(0, 0, 0)
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width
156:             .Height    = 46
157:             .AutoSize  = .F.
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16

*-- Linhas 166 a 338:
166:         *-- Container botoes CRUD (Left=542, Top=29 - 5 botoes: Incluir Visualizar Alterar Excluir Buscar)
167:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
168:         WITH loc_oPagina.cnt_4c_Botoes
169:             .Top         = 29
170:             .Left        = 542
171:             .Width       = 385
172:             .Height      = 85
173:             .BackStyle   = 0
174:             .BorderWidth = 0
175:             .Visible     = .T.
176:         ENDWITH
177: 
178:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
179:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
180:             .Caption         = "Incluir"
181:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
182:             .PicturePosition = 13
183:             .Top             = 5
184:             .Left            = 5
185:             .Width           = 75
186:             .Height          = 75
187:             .BackColor       = RGB(255, 255, 255)
188:             .ForeColor       = RGB(90, 90, 90)
189:             .FontName        = "Comic Sans MS"
190:             .FontSize        = 8
191:             .FontBold        = .T.
192:             .FontItalic      = .T.
193:             .Themes          = .F.
194:             .SpecialEffect   = 0
195:             .MousePointer    = 15
196:             .WordWrap        = .T.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .BackColor       = RGB(255, 255, 255)
211:             .ForeColor       = RGB(90, 90, 90)
212:             .FontName        = "Comic Sans MS"
213:             .FontSize        = 8
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .Visible         = .T.
221:         ENDWITH
222:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
223: 
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .BackColor       = RGB(255, 255, 255)
257:             .ForeColor       = RGB(90, 90, 90)
258:             .FontName        = "Comic Sans MS"
259:             .FontSize        = 8
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .MousePointer    = 15
265:             .WordWrap        = .T.
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
269: 
270:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
272:             .Caption         = "Buscar"
273:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
274:             .PicturePosition = 13
275:             .Top             = 5
276:             .Left            = 305
277:             .Width           = 75
278:             .Height          = 75
279:             .BackColor       = RGB(255, 255, 255)
280:             .ForeColor       = RGB(90, 90, 90)
281:             .FontName        = "Comic Sans MS"
282:             .FontSize        = 8
283:             .FontBold        = .T.
284:             .FontItalic      = .T.
285:             .Themes          = .F.
286:             .SpecialEffect   = 0
287:             .MousePointer    = 15
288:             .WordWrap        = .T.
289:             .Visible         = .T.
290:         ENDWITH
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
292: 
293:         *-- Container saida canonico (Left=917, Width=90, cmd_4c_Encerrar 75x75)
294:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
295:         WITH loc_oPagina.cnt_4c_Saida
296:             .Top         = 29
297:             .Left        = 917
298:             .Width       = 90
299:             .Height      = 85
300:             .BackStyle   = 0
301:             .BorderWidth = 0
302:             .Visible     = .T.
303:         ENDWITH
304: 
305:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
306:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
307:             .Caption         = "Encerrar"
308:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:             .PicturePosition = 13
310:             .Top             = 5
311:             .Left            = 5
312:             .Width           = 75
313:             .Height          = 75
314:             .BackColor       = RGB(255, 255, 255)
315:             .ForeColor       = RGB(90, 90, 90)
316:             .FontName        = "Comic Sans MS"
317:             .FontSize        = 8
318:             .FontBold        = .T.
319:             .FontItalic      = .T.
320:             .Themes          = .F.
321:             .SpecialEffect   = 0
322:             .MousePointer    = 15
323:             .WordWrap        = .T.
324:             .Visible         = .T.
325:         ENDWITH
326:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
327: 
328:         *-- Grid de lancamentos: Grupos/Contas distintos de SigClLan
329:         *-- Top=117 (abaixo do cabecalho h=80 em top=31, com margem)
330:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
331:         WITH loc_oPagina.grd_4c_Lista
332:             .Top                = 117
333:             .Left               = 2
334:             .Width              = 950
335:             .Height             = 452
336:             .ColumnCount        = 2
337:             .FontName           = "Verdana"
338:             .FontSize           = 8

*-- Linhas 366 a 437:
366:         *-- Container botoes de acao (Grupo_Salva: Left=844, Top=-3+29=26 -> canonico 38)
367:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
368:         WITH loc_oPagina.cnt_4c_BotoesAcao
369:             .Top         = 38
370:             .Left        = 819
371:             .Width       = 165
372:             .Height      = 85
373:             .BackStyle = 1
374:             .BackColor   = RGB(255, 255, 255)
375:             .BorderWidth = 0
376:             .Visible     = .T.
377:         ENDWITH
378: 
379:         *-- Botao Salvar (Grupo_Salva.Salva: Left=5, Top=5)
380:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
381:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
382:             .Caption         = "Salvar"
383:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
384:             .PicturePosition = 13
385:             .Top             = 5
386:             .Left            = 5
387:             .Width           = 75
388:             .Height          = 75
389:             .BackColor       = RGB(255, 255, 255)
390:             .ForeColor       = RGB(90, 90, 90)
391:             .FontName        = "Comic Sans MS"
392:             .FontSize        = 8
393:             .FontBold        = .T.
394:             .FontItalic      = .T.
395:             .Themes          = .F.
396:             .SpecialEffect   = 0
397:             .MousePointer    = 15
398:             .WordWrap        = .T.
399:             .Visible         = .T.
400:         ENDWITH
401:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
402: 
403:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
404:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
406:             .Caption         = "Encerrar"
407:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
408:             .PicturePosition = 13
409:             .Top             = 5
410:             .Left            = 80
411:             .Width           = 75
412:             .Height          = 75
413:             .BackColor       = RGB(255, 255, 255)
414:             .ForeColor       = RGB(90, 90, 90)
415:             .FontName        = "Comic Sans MS"
416:             .FontSize        = 8
417:             .FontBold        = .T.
418:             .FontItalic      = .T.
419:             .Themes          = .F.
420:             .SpecialEffect   = 0
421:             .MousePointer    = 15
422:             .WordWrap        = .T.
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
426: 
427:         *-- Label "Grupo : " (Say2: Top=130+29=159, Left=257)
428:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
429:         WITH loc_oPagina.lbl_4c_Label2
430:             .Caption   = "Grupo : "
431:             .Top       = 159
432:             .Left      = 257
433:             .Width     = 80
434:             .Height    = 18
435:             .AutoSize  = .F.
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8

*-- Linhas 445 a 454:
445:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
446:         WITH loc_oPagina.txt_4c_Grupo
447:             .Value         = ""
448:             .Top           = 156
449:             .Left          = 300
450:             .Width         = 80
451:             .Height        = 23
452:             .FontName      = "Tahoma"
453:             .FontSize      = 8
454:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 464 a 490:
464:         loc_oPagina.AddObject("txt_4c_Desc_Gru", "TextBox")
465:         WITH loc_oPagina.txt_4c_Desc_Gru
466:             .Value         = ""
467:             .Top           = 156
468:             .Left          = 382
469:             .Width         = 360
470:             .Height        = 23
471:             .FontName      = "Tahoma"
472:             .FontSize      = 8
473:             .ForeColor     = RGB(0, 0, 0)
474:             .BorderColor   = RGB(100, 100, 100)
475:             .SpecialEffect = 1
476:             .ReadOnly      = .T.
477:             .Visible       = .T.
478:         ENDWITH
479: 
480:         *-- Label "Conta : " (Say3: Top=155+29=184, Left=257)
481:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
482:         WITH loc_oPagina.lbl_4c_Label3
483:             .Caption   = "Conta : "
484:             .Top       = 184
485:             .Left      = 257
486:             .Width     = 80
487:             .Height    = 18
488:             .AutoSize  = .F.
489:             .FontName  = "Tahoma"
490:             .FontSize  = 8

*-- Linhas 498 a 507:
498:         loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
499:         WITH loc_oPagina.txt_4c_Contas
500:             .Value         = ""
501:             .Top           = 181
502:             .Left          = 300
503:             .Width         = 80
504:             .Height        = 23
505:             .FontName      = "Tahoma"
506:             .FontSize      = 8
507:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 517 a 545:
517:         loc_oPagina.AddObject("txt_4c_Desc_Con", "TextBox")
518:         WITH loc_oPagina.txt_4c_Desc_Con
519:             .Value         = ""
520:             .Top           = 181
521:             .Left          = 382
522:             .Width         = 360
523:             .Height        = 23
524:             .FontName      = "Tahoma"
525:             .FontSize      = 8
526:             .ForeColor     = RGB(0, 0, 0)
527:             .BorderColor   = RGB(100, 100, 100)
528:             .SpecialEffect = 1
529:             .ReadOnly      = .T.
530:             .Visible       = .T.
531:         ENDWITH
532: 
533:         *-- Botao Inserir Ocorrencia (inserir: Top=335+29=364, Left=629, 40x40)
534:         loc_oPagina.AddObject("cmd_4c_InserirOco", "CommandButton")
535:         WITH loc_oPagina.cmd_4c_InserirOco
536:             .Caption         = ""
537:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
538:             .PicturePosition = 7
539:             .Top             = 364
540:             .Left            = 629
541:             .Width           = 40
542:             .Height          = 40
543:             .FontName        = "Arial"
544:             .FontSize        = 9
545:             .FontBold        = .T.

*-- Linhas 551 a 568:
551:             .ToolTipText     = "Inserir"
552:             .Visible         = .T.
553:         ENDWITH
554:         BINDEVENT(loc_oPagina.cmd_4c_InserirOco, "Click", THIS, "BtnInserirOcoClick")
555: 
556:         *-- Botao Excluir Ocorrencia (excluir: Top=375+29=404, Left=629, 40x40)
557:         loc_oPagina.AddObject("cmd_4c_ExcluirOco", "CommandButton")
558:         WITH loc_oPagina.cmd_4c_ExcluirOco
559:             .Caption         = ""
560:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
561:             .PicturePosition = 7
562:             .Top             = 404
563:             .Left            = 629
564:             .Width           = 40
565:             .Height          = 40
566:             .FontName        = "Arial"
567:             .FontSize        = 9
568:             .FontBold        = .T.

*-- Linhas 574 a 593:
574:             .ToolTipText     = "Excluir"
575:             .Visible         = .T.
576:         ENDWITH
577:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirOco, "Click", THIS, "BtnExcluirOcoClick")
578: 
579:         *-- Grid de Ocorrencias (Gradeoco: Top=181+29=210, Left=300, Width=324, Height=403)
580:         LOCAL loc_oGrid
581:         loc_oPagina.AddObject("grd_4c_Ocorrencias", "Grid")
582:         loc_oGrid = loc_oPagina.grd_4c_Ocorrencias
583:         loc_oGrid.ColumnCount = 3
584:         loc_oGrid.RecordSource = "cursor_4c_OcoLocal"
585:         loc_oGrid.ColumnCount  = 2
586:         WITH loc_oGrid
587:             .Top                = 210
588:             .Left               = 300
589:             .Width              = 324
590:             .Height             = 403
591:             .FontName           = "Verdana"
592:             .FontSize           = 8
593:             .Panel              = 1

*-- Linhas 608 a 616:
608:             .Column1.Resizable         = .F.
609:             .Column1.Visible           = .T.
610:             .Column1.Sparse            = .F.
611:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
612:             .Column1.Header1.FontName  = "Tahoma"
613:             .Column1.Header1.FontSize  = 8
614:             .Column1.Header1.Alignment = 2
615:             .Column1.Text1.FontName    = "Verdana"
616:             .Column1.Text1.FontSize    = 8

*-- Linhas 623 a 631:
623:             .Column2.Resizable         = .F.
624:             .Column2.ReadOnly          = .T.
625:             .Column2.Visible           = .T.
626:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
627:             .Column2.Header1.FontName  = "Tahoma"
628:             .Column2.Header1.FontSize  = 8
629:             .Column2.Header1.Alignment = 2
630:             .Column2.Text1.FontName    = "Verdana"
631:             .Column2.Text1.FontSize    = 8

*-- Linhas 660 a 672:
660:                     WITH loc_oGrid
661:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
662:                         .Column1.Width           = 200
663:                         .Column1.Header1.Caption = "Ocorr" + CHR(234) + "ncia"
664: 
665:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
666:                         .Column2.Width           = 200
667:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
668:                     ENDWITH
669: 
670:                     THIS.FormatarGridLista(loc_oGrid)
671:                     THIS.AjustarBotoesPorModo()
672:                     loc_lSucesso = .T.

*-- Linhas 1199 a 1211:
1199:         ENDIF
1200: 
1201:         *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
1202:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
1203:             loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
1204:         ENDIF
1205:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
1206:             loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
1207:         ENDIF
1208:     ENDPROC
1209: 
1210:     *--------------------------------------------------------------------------
1211:     * GradeAfterRowColChange - Valida ocorrencia (Cocos) ao mover na grade

*-- Linhas 1583 a 1604:
1583:             RETURN
1584:         ENDIF
1585: 
1586:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1587:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
1588:         ENDIF
1589:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1590:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1591:         ENDIF
1592:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1593:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1594:         ENDIF
1595:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1596:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1597:         ENDIF
1598:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1599:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
1600:         ENDIF
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * Destroy - Libera o Business Object e chama destruicao da classe pai


### BO (C:\4c\projeto\app\classes\SIGPRLNCBO.prg):
*==============================================================================
* SIGPRLNCBO.prg - Business Object para Lancamentos de Conta Corrente
* Tabela: SigClLan (grupos, contas, cocos, cidchaves, grucontas)
* Auxiliar: SIGCCCCO (cods, descs) - descricoes de ocorrencias
*==============================================================================
DEFINE CLASS SIGPRLNCBO AS BusinessBase

    *-- Campos de SigClLan
    this_cGrupos    = ""    && char(10) - Grupo da conta corrente
    this_cContas    = ""    && char(10) - Conta corrente
    this_cCocos     = ""    && char(2)  - Codigo da ocorrencia
    this_cCidChaves = ""    && char(20) - Chave primaria (gerada por fUniqueIds)
    this_cGruContas = ""    && char(20) - Concatenacao grupos+contas (indice)

    *-- Campo auxiliar (descricao da ocorrencia, vem de SIGCCCCO)
    this_cDescs     = ""    && char(30) - Descricao da ocorrencia (SIGCCCCO.descs)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigClLan"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor existente
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos    = TratarNulo(grupos,    "C")
            THIS.this_cContas    = TratarNulo(contas,    "C")
            THIS.this_cCocos     = TratarNulo(cocos,     "C")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cGruContas = TratarNulo(grucontas, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista todos os registros agrupados de SigClLan
    * Retorna cursor cursor_4c_Dados com grupos, contas e uma ocorrencia por linha
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT a.grupos, a.contas, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " ORDER BY a.grupos, a.contas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOcorrencias - Busca ocorrencias para um grupo+conta especifico
    * par_cGruContas = grupos(10) + contas(10) concatenados
    * Retorna cursor cursor_4c_Ocorrencias
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOcorrencias(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves," + ;
                       " a.grucontas, b.descs" + ;
                       " FROM SigClLan a LEFT JOIN SIGCCCCO b ON b.cods = a.cocos" + ;
                       " WHERE a.grucontas = " + EscaparSQL(par_cGruContas) + ;
                       " ORDER BY a.cocos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorrencias")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.BuscarOcorrencias: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoOcorrencia - Busca descricao de uma ocorrencia pelo codigo
    * Retorna string com descricao ou vazio se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoOcorrencia(par_cCodOco)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao
        loc_cDescricao = ""

        TRY
            IF USED("cursor_4c_DescOco")
                USE IN cursor_4c_DescOco
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SIGCCCCO" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodOco)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescOco")

            IF loc_nResultado >= 0 AND USED("cursor_4c_DescOco") AND RECCOUNT("cursor_4c_DescOco") > 0
                SELECT cursor_4c_DescOco
                loc_cDescricao = ALLTRIM(descs)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarDescricaoOcorrencia: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DescOco")
            USE IN cursor_4c_DescOco
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves  = ALLTRIM(fUniqueIds())
            THIS.this_cGruContas  = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                    PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                       EscaparSQL(THIS.this_cGruContas)                    + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigClLan (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruContas = PADR(ALLTRIM(THIS.this_cGrupos), 10) + ;
                                   PADR(ALLTRIM(THIS.this_cContas), 10)

            loc_cSQL = "UPDATE SigClLan SET" + ;
                       " grupos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10)) + ;
                       ", contas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10)) + ;
                       ", cocos    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))   + ;
                       ", grucontas= " + EscaparSQL(THIS.this_cGruContas)                 + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigClLan (PROTECTED - chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir lan" + CHR(231) + "amento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirPorGruContas - Remove TODOS os lancamentos de um grupo+conta
    * Usado ao salvar conjunto de ocorrencias (limpa e re-insere)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirPorGruContas(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE grucontas = " + ;
                       EscaparSQL(par_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir lan" + CHR(231) + "amentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.ExcluirPorGruContas: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarOcorrencias - Salva lista de ocorrencias do cursor local para SQL Server
    * par_cGrupos    = codigo do grupo (char 10)
    * par_cContas    = codigo da conta (char 10)
    * par_cCursorOco = nome do cursor VFP com a lista de ocorrencias (campo cocos)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarOcorrencias(par_cGrupos, par_cContas, par_cCursorOco)
        LOCAL loc_cGruContas, loc_lSucesso, loc_cCocos, loc_lAbortar
        LOCAL loc_cSQLIns, loc_nResIns
        loc_lSucesso = .F.
        loc_lAbortar = .F.

        TRY
            loc_cGruContas = PADR(ALLTRIM(par_cGrupos), 10) + PADR(ALLTRIM(par_cContas), 10)

            IF !THIS.ExcluirPorGruContas(loc_cGruContas)
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                IF !USED(par_cCursorOco) OR RECCOUNT(par_cCursorOco) = 0
                    loc_lSucesso = .T.
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT (par_cCursorOco)
                GO TOP

                DO WHILE !EOF() AND !loc_lAbortar
                    SELECT (par_cCursorOco)
                    loc_cCocos = ALLTRIM(cocos)

                    IF !EMPTY(loc_cCocos)
                        THIS.this_cGrupos    = par_cGrupos
                        THIS.this_cContas    = par_cContas
                        THIS.this_cCocos     = loc_cCocos
                        THIS.this_cGruContas = loc_cGruContas
                        THIS.this_cCidChaves = ALLTRIM(fUniqueIds())

                        loc_cSQLIns = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                                      EscaparSQL(THIS.this_cCidChaves)                    + ", " + ;
                                      EscaparSQL(THIS.this_cGruContas)                    + ;
                                      ")"

                        loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)

                        IF loc_nResIns < 0
                            MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia '" + loc_cCocos + "': " + CapturarErroSQL(), "Erro SQL")
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortar
                        SELECT (par_cCursorOco)
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.SalvarOcorrencias: " + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

