# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 218: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 305: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 387: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 410: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1468 linhas total):

*-- Linhas 73 a 92:
73:         THIS.pgf_4c_Paginas.PageCount = 2
74: 
75:         WITH THIS.pgf_4c_Paginas
76:             .Top     = -29
77:             .Left    = 0
78:             .Width   = THIS.Width
79:             .Height  = THIS.Height + 29
80:             .Tabs    = .F.
81:             .Visible = .T.
82: 
83:             .Page1.Caption   = "Lista"
84:             .Page1.BackColor = RGB(255, 255, 255)
85:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86: 
87:             .Page2.Caption   = "Dados"
88:             .Page2.BackColor = RGB(255, 255, 255)
89:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:         ENDWITH
91: 
92:         THIS.ConfigurarPaginaLista()

*-- Linhas 103 a 142:
103:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
104:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105: 
106:         *-- Container cabecalho escuro (Top: 2+29=31 - compensa PageFrame.Top=-29)
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 31
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116: 
117:             .AddObject("lbl_4c_Sombra", "Label")
118:             WITH .lbl_4c_Sombra
119:                 .Caption   = THIS.Caption
120:                 .Top       = 15
121:                 .Left      = 10
122:                 .Width     = THIS.Width
123:                 .Height    = 40
124:                 .FontName  = "Tahoma"
125:                 .FontSize  = 16
126:                 .FontBold  = .T.
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .BackStyle = 0
129:                 .AutoSize  = .F.
130:                 .Visible   = .T.
131:             ENDWITH
132: 
133:             .AddObject("lbl_4c_Titulo", "Label")
134:             WITH .lbl_4c_Titulo
135:                 .Caption   = THIS.Caption
136:                 .Top       = 18
137:                 .Left      = 10
138:                 .Width     = THIS.Width
139:                 .Height    = 46
140:                 .FontName  = "Tahoma"
141:                 .FontSize  = 16
142:                 .FontBold  = .T.

*-- Linhas 150 a 328:
150:         *-- Container botoes CRUD (Top: 0+29=29; Left=542 - lado direito)
151:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
152:         WITH loc_oPagina.cnt_4c_Botoes
153:             .Top         = 29
154:             .Left        = 542
155:             .Width       = 390
156:             .Height      = 85
157:             .BackStyle   = 1
158:             .BackColor   = RGB(53, 53, 53)
159:             .BorderWidth = 0
160:             .Visible     = .T.
161: 
162:             .AddObject("cmd_4c_Incluir", "CommandButton")
163:             WITH .cmd_4c_Incluir
164:                 .Caption         = "Incluir"
165:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
166:                 .PicturePosition = 13
167:                 .Top             = 5
168:                 .Left            =  542
169:                 .Width           = 75
170:                 .Height          = 75
171:                 .BackColor       = RGB(255, 255, 255)
172:                 .ForeColor       = RGB(90, 90, 90)
173:                 .FontName        = "Comic Sans MS"
174:                 .FontSize        = 8
175:                 .FontBold        = .T.
176:                 .FontItalic      = .T.
177:                 .SpecialEffect   = 0
178:                 .MousePointer    = 15
179:                 .WordWrap        = .T.
180:                 .AutoSize        = .F.
181:                 .Visible         = .T.
182:             ENDWITH
183: 
184:             .AddObject("cmd_4c_Visualizar", "CommandButton")
185:             WITH .cmd_4c_Visualizar
186:                 .Caption         = "Visualizar"
187:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
188:                 .PicturePosition = 13
189:                 .Top             = 5
190:                 .Left            =  542
191:                 .Width           = 75
192:                 .Height          = 75
193:                 .BackColor       = RGB(255, 255, 255)
194:                 .ForeColor       = RGB(90, 90, 90)
195:                 .FontName        = "Comic Sans MS"
196:                 .FontSize        = 8
197:                 .FontBold        = .T.
198:                 .FontItalic      = .T.
199:                 .Themes          = .F.
200:                 .SpecialEffect   = 0
201:                 .MousePointer    = 15
202:                 .WordWrap        = .T.
203:                 .AutoSize        = .F.
204:                 .Visible         = .T.
205:             ENDWITH
206: 
207:             .AddObject("cmd_4c_Alterar", "CommandButton")
208:             WITH .cmd_4c_Alterar
209:                 .Caption         = "Alterar"
210:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:                 .PicturePosition = 13
212:                 .Top             = 5
213:                 .Left            =  542
214:                 .Width           = 75
215:                 .Height          = 75
216:                 .BackColor       = RGB(255, 255, 255)
217:                 .ForeColor       = RGB(90, 90, 90)
218:                 .FontName        = "Comic Sans MS"
219:                 .FontSize        = 8
220:                 .FontBold        = .T.
221:                 .FontItalic      = .T.
222:                 .Themes          = .F.
223:                 .SpecialEffect   = 0
224:                 .MousePointer    = 15
225:                 .WordWrap        = .T.
226:                 .AutoSize        = .F.
227:                 .Visible         = .T.
228:             ENDWITH
229: 
230:             .AddObject("cmd_4c_Excluir", "CommandButton")
231:             WITH .cmd_4c_Excluir
232:                 .Caption         = "Excluir"
233:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
234:                 .PicturePosition = 13
235:                 .Top             = 5
236:                 .Left            =  542
237:                 .Width           = 75
238:                 .Height          = 75
239:                 .BackColor       = RGB(255, 255, 255)
240:                 .ForeColor       = RGB(90, 90, 90)
241:                 .FontName        = "Comic Sans MS"
242:                 .FontSize        = 8
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .Themes          = .F.
246:                 .SpecialEffect   = 0
247:                 .MousePointer    = 15
248:                 .WordWrap        = .T.
249:                 .AutoSize        = .F.
250:                 .Visible         = .T.
251:             ENDWITH
252: 
253:             .AddObject("cmd_4c_Buscar", "CommandButton")
254:             WITH .cmd_4c_Buscar
255:                 .Caption         = "Buscar"
256:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
257:                 .PicturePosition = 13
258:                 .Top             = 5
259:                 .Left            =  542
260:                 .Width           = 75
261:                 .Height          = 75
262:                 .BackColor       = RGB(255, 255, 255)
263:                 .ForeColor       = RGB(90, 90, 90)
264:                 .FontName        = "Comic Sans MS"
265:                 .FontSize        = 8
266:                 .FontBold        = .T.
267:                 .FontItalic      = .T.
268:                 .Themes          = .F.
269:                 .SpecialEffect   = 0
270:                 .MousePointer    = 15
271:                 .WordWrap        = .T.
272:                 .AutoSize        = .F.
273:                 .Visible         = .T.
274:             ENDWITH
275:         ENDWITH
276: 
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
278:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container saida (canonico: Left=917, Width=90)
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293: 
294:             .AddObject("cmd_4c_Encerrar", "CommandButton")
295:             WITH .cmd_4c_Encerrar
296:                 .Caption         = "Encerrar"
297:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:                 .PicturePosition = 13
299:                 .Top             = 5
300:                 .Left            = 917
301:                 .Width           = 75
302:                 .Height          = 75
303:                 .BackColor       = RGB(255, 255, 255)
304:                 .ForeColor       = RGB(90, 90, 90)
305:                 .FontName        = "Comic Sans MS"
306:                 .FontSize        = 8
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .SpecialEffect   = 0
310:                 .MousePointer    = 15
311:                 .WordWrap        = .T.
312:                 .AutoSize        = .F.
313:                 .Visible         = .T.
314:             ENDWITH
315:         ENDWITH
316: 
317:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
318: 
319:         *-- Grid de listagem (Top: 88+29=117; Width=890 nao sobrepoe cnt_4c_Saida)
320:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
321:         loc_oGrid = loc_oPagina.grd_4c_Dados
322:         loc_oGrid.Top         = 117
323:         loc_oGrid.Left        = 26
324:         loc_oGrid.Width       = 890
325:         loc_oGrid.Height      = 498
326:         loc_oGrid.ColumnCount = 2
327:         WITH loc_oGrid
328:             .FontName           = "Verdana"

*-- Linhas 341 a 353:
341:             .Visible            = .T.
342: 
343:             .Column1.Width           = 80
344:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
345:             .Column1.Alignment       = 0
346: 
347:             .Column2.Width           = 290
348:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
349:             .Column2.Alignment       = 0
350:         ENDWITH
351: 
352:         THIS.TornarControlesVisiveis(loc_oPagina)
353:     ENDPROC

*-- Linhas 365 a 435:
365:         *-- Container botoes Confirmar/Cancelar (grupo_salva: Top=-4+29=25; Left=841)
366:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
367:         WITH loc_oPagina.cnt_4c_BotoesAcao
368:             .Top         = 25
369:             .Left        = 841
370:             .Width       = 160
371:             .Height      = 85
372:             .BackStyle   = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
377:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
378:             .Caption         = "Confirmar"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
380:             .PicturePosition = 13
381:             .Top             = 5
382:             .Left            = 7
383:             .Width           = 75
384:             .Height          = 75
385:             .BackColor       = RGB(255, 255, 255)
386:             .ForeColor       = RGB(90, 90, 90)
387:             .FontName        = "Comic Sans MS"
388:             .FontSize        = 8
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .Themes          = .F.
392:             .SpecialEffect   = 0
393:             .MousePointer    = 15
394:             .WordWrap        = .T.
395:             .AutoSize        = .F.
396:             .Visible         = .T.
397:         ENDWITH
398: 
399:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
400:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
401:             .Caption         = "Encerrar"
402:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
403:             .PicturePosition = 13
404:             .Top             = 5
405:             .Left            = 82
406:             .Width           = 75
407:             .Height          = 75
408:             .BackColor       = RGB(255, 255, 255)
409:             .ForeColor       = RGB(90, 90, 90)
410:             .FontName        = "Comic Sans MS"
411:             .FontSize        = 8
412:             .FontBold        = .T.
413:             .FontItalic      = .T.
414:             .Themes          = .F.
415:             .SpecialEffect   = 0
416:             .MousePointer    = 15
417:             .WordWrap        = .T.
418:             .AutoSize        = .F.
419:             .Visible         = .T.
420:         ENDWITH
421: 
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
424: 
425:         *-- Label + TextBox: Codigo (getcodigos Top=133->162; Left=361/405; W=42/80; MaxLen=10)
426:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
427:         WITH loc_oPagina.lbl_4c_Codigo
428:             .Caption   = "C" + CHR(243) + "digo :"
429:             .Top       = 166
430:             .Left      = 361
431:             .Width     = 42
432:             .Height    = 15
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .FontBold  = .F.

*-- Linhas 442 a 451:
442:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
443:         WITH loc_oPagina.txt_4c_Codigos
444:             .Value         = ""
445:             .Top           = 162
446:             .Left          = 405
447:             .Width         = 80
448:             .Height        = 21
449:             .MaxLength     = 10
450:             .Format        = "K!"
451:             .SpecialEffect = 1

*-- Linhas 457 a 469:
457:         ENDWITH
458: 
459:         *-- Label + TextBox: Descricao (getDescricaos Top=158->187; Left=348/405; W=55/290; H=23)
460:         loc_oPagina.AddObject("lbl_4c_Descricaos", "Label")
461:         WITH loc_oPagina.lbl_4c_Descricaos
462:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
463:             .Top       = 189
464:             .Left      = 348
465:             .Width     = 55
466:             .Height    = 15
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .FontBold  = .F.

*-- Linhas 476 a 485:
476:         loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
477:         WITH loc_oPagina.txt_4c_Descricaos
478:             .Value         = ""
479:             .Top           = 187
480:             .Left          = 405
481:             .Width         = 290
482:             .Height        = 23
483:             .MaxLength     = 40
484:             .Format        = "K!"
485:             .SpecialEffect = 1

*-- Linhas 492 a 504:
492: 
493:         *-- Label + TextBox: Diretor (getDiretores Top=183->212; Left=361/405; W=42/80; H=23)
494:         *-- Lookup: F4 abre FormBuscaAuxiliar em SigCdUsu (Usuarios, NComps)
495:         loc_oPagina.AddObject("lbl_4c_Diretor", "Label")
496:         WITH loc_oPagina.lbl_4c_Diretor
497:             .Caption   = "Diretor :"
498:             .Top       = 214
499:             .Left      = 361
500:             .Width     = 42
501:             .Height    = 15
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8
504:             .FontBold  = .F.

*-- Linhas 511 a 520:
511:         loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
512:         WITH loc_oPagina.txt_4c_Diretores
513:             .Value         = ""
514:             .Top           = 212
515:             .Left          = 405
516:             .Width         = 80
517:             .Height        = 23
518:             .MaxLength     = 10
519:             .Format        = "K!"
520:             .SpecialEffect = 1

*-- Linhas 528 a 540:
528:         BINDEVENT(loc_oPagina.txt_4c_Diretores, "KeyPress", THIS, "DiretorKeyPress")
529: 
530:         *-- Label4 + opt_4c_SubclaEnc (Optiongroup1: nchksubs; Top=210->239; Left=249/400)
531:         loc_oPagina.AddObject("lbl_4c_SubclaEnc", "Label")
532:         WITH loc_oPagina.lbl_4c_SubclaEnc
533:             .Caption   = "Obriga Subclas. Encerramento :"
534:             .Top       = 239
535:             .Left      = 249
536:             .Width     = 154
537:             .Height    = 15
538:             .FontName  = "Tahoma"
539:             .FontSize  = 8
540:             .FontBold  = .F.

*-- Linhas 550 a 594:
550:             .BackStyle   = 0
551:             .BorderStyle = 0
552:             .Value       = 1
553:             .Top         = 238
554:             .Left        = 400
555:             .Width       = 109
556:             .Height      = 24
557:             .Visible     = .T.
558:             WITH .Buttons(1)
559:                 .Caption   = "Sim"
560:                 .BackStyle = 0
561:                 .ForeColor = RGB(90, 90, 90)
562:                 .Height    = 17
563:                 .Left      = 5
564:                 .Top       = 3
565:                 .Width     = 61
566:                 .AutoSize  = .F.
567:                 .Themes    = .F.
568:             ENDWITH
569:             WITH .Buttons(2)
570:                 .Caption   = "N" + CHR(227) + "o"
571:                 .FontName  = "Tahoma"
572:                 .FontSize  = 8
573:                 .BackStyle = 0
574:                 .ForeColor = RGB(90, 90, 90)
575:                 .Height    = 17
576:                 .Left      = 61
577:                 .Top       = 3
578:                 .Width     = 61
579:                 .AutoSize  = .F.
580:                 .Themes    = .F.
581:             ENDWITH
582:         ENDWITH
583: 
584:         *-- Label5 + opt_4c_Tipo (Optiongroup2: nchktipos; Top=232->261; Left=374/400)
585:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
586:         WITH loc_oPagina.lbl_4c_Tipo
587:             .Caption   = "Tipo :"
588:             .Top       = 261
589:             .Left      = 374
590:             .Width     = 29
591:             .Height    = 15
592:             .FontName  = "Tahoma"
593:             .FontSize  = 8
594:             .FontBold  = .F.

*-- Linhas 604 a 649:
604:             .BackStyle   = 0
605:             .BorderStyle = 0
606:             .Value       = 1
607:             .Top         = 257
608:             .Left        = 400
609:             .Width       = 109
610:             .Height      = 24
611:             .Visible     = .T.
612:             WITH .Buttons(1)
613:                 .Caption   = "Sim"
614:                 .BackStyle = 0
615:                 .ForeColor = RGB(90, 90, 90)
616:                 .Height    = 17
617:                 .Left      = 5
618:                 .Top       = 3
619:                 .Width     = 61
620:                 .AutoSize  = .F.
621:                 .Themes    = .F.
622:             ENDWITH
623:             WITH .Buttons(2)
624:                 .Caption   = "N" + CHR(227) + "o"
625:                 .FontName  = "Tahoma"
626:                 .FontSize  = 8
627:                 .BackStyle = 0
628:                 .ForeColor = RGB(90, 90, 90)
629:                 .Height    = 17
630:                 .Left      = 61
631:                 .Top       = 3
632:                 .Width     = 61
633:                 .AutoSize  = .F.
634:                 .Themes    = .F.
635:             ENDWITH
636:         ENDWITH
637: 
638:         *-- Label6 + opt_4c_Autos (optAutos: autos; Top=251->280; Left=343/400)
639:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
640:         loc_oPagina.AddObject("lbl_4c_Autos", "Label")
641:         WITH loc_oPagina.lbl_4c_Autos
642:             .Caption   = "Autom" + CHR(225) + "tico:"
643:             .Top       = 280
644:             .Left      = 343
645:             .Width     = 60
646:             .Height    = 15
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .FontBold  = .F.

*-- Linhas 659 a 705:
659:             .BackStyle   = 0
660:             .BorderStyle = 0
661:             .Value       = 2
662:             .Top         = 276
663:             .Left        = 400
664:             .Width       = 109
665:             .Height      = 24
666:             .Visible     = .T.
667:             WITH .Buttons(1)
668:                 .Caption   = "Sim"
669:                 .BackStyle = 0
670:                 .ForeColor = RGB(90, 90, 90)
671:                 .Height    = 17
672:                 .Left      = 5
673:                 .Top       = 3
674:                 .Width     = 61
675:                 .AutoSize  = .F.
676:                 .Themes    = .F.
677:             ENDWITH
678:             WITH .Buttons(2)
679:                 .Caption   = "N" + CHR(227) + "o"
680:                 .FontName  = "Tahoma"
681:                 .FontSize  = 8
682:                 .BackStyle = 0
683:                 .ForeColor = RGB(90, 90, 90)
684:                 .Height    = 17
685:                 .Left      = 61
686:                 .Top       = 3
687:                 .Width     = 61
688:                 .AutoSize  = .F.
689:                 .Themes    = .F.
690:             ENDWITH
691:         ENDWITH
692: 
693:         *-- Label7 + opt_4c_UtiLacto (Optiongroup3: UtiLacto; Top=271->300; Left=241/400)
694:         *-- Convencao invertida: Sim=Option1.Value=0, Nao=Option2.Value=1; default Value=2(Nao)
695:         *-- UtiLacto: campo de UI apenas (nao persistido no banco - SigCdDpt nao tem coluna)
696:         loc_oPagina.AddObject("lbl_4c_UtiLacto", "Label")
697:         WITH loc_oPagina.lbl_4c_UtiLacto
698:             .Caption   = "Utiliza nos dados de lan" + CHR(231) + "amento :"
699:             .Top       = 300
700:             .Left      = 241
701:             .Width     = 162
702:             .Height    = 15
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .FontBold  = .F.

*-- Linhas 715 a 759:
715:             .BackStyle   = 0
716:             .BorderStyle = 0
717:             .Value       = 2
718:             .Top         = 296
719:             .Left        = 400
720:             .Width       = 109
721:             .Height      = 24
722:             .Visible     = .T.
723:             WITH .Buttons(1)
724:                 .Caption   = "Sim"
725:                 .BackStyle = 0
726:                 .ForeColor = RGB(90, 90, 90)
727:                 .Height    = 17
728:                 .Left      = 5
729:                 .Top       = 3
730:                 .Width     = 61
731:                 .AutoSize  = .F.
732:                 .Themes    = .F.
733:             ENDWITH
734:             WITH .Buttons(2)
735:                 .Caption   = "N" + CHR(227) + "o"
736:                 .FontName  = "Tahoma"
737:                 .FontSize  = 8
738:                 .BackStyle = 0
739:                 .ForeColor = RGB(90, 90, 90)
740:                 .Height    = 17
741:                 .Left      = 61
742:                 .Top       = 3
743:                 .Width     = 61
744:                 .AutoSize  = .F.
745:                 .Themes    = .F.
746:             ENDWITH
747:         ENDWITH
748: 
749:         *-- Say44 (lbl_4c_GdeGrupo; Top=292->321; Left=339)
750:         loc_oPagina.AddObject("lbl_4c_GdeGrupo", "Label")
751:         WITH loc_oPagina.lbl_4c_GdeGrupo
752:             .Caption   = "Gde. Grupo :"
753:             .Top       = 321
754:             .Left      = 339
755:             .Width     = 64
756:             .Height    = 15
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8
759:             .FontBold  = .F.

*-- Linhas 768 a 777:
768:         loc_oPagina.AddObject("grd_4c_GruposGG", "Grid")
769:         WITH loc_oPagina.grd_4c_GruposGG
770:             .ColumnCount   = 2
771:             .Top           = 323
772:             .Left          = 405
773:             .Width         = 262
774:             .Height        = 222
775:             .DeleteMark    = .F.
776:             .GridLines     = 3
777:             .GridLineColor = RGB(238, 238, 238)

*-- Linhas 783 a 815:
783: 
784:             .Column1.Width    = 65
785:             .Column1.FontSize = 8
786:             .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
787:             .Column1.Header1.FontName = "Tahoma"
788:             .Column1.Header1.FontSize = 8
789:             .Column1.Header1.FontBold = .F.
790: 
791:             .Column2.Width    = 165
792:             .Column2.FontSize = 8
793:             .Column2.ReadOnly = .T.
794:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
795:             .Column2.Header1.FontName = "Tahoma"
796:             .Column2.Header1.FontSize = 8
797:             .Column2.Header1.FontBold = .F.
798:         ENDWITH
799: 
800:         BINDEVENT(loc_oPagina.grd_4c_GruposGG, "AfterRowColChange", THIS, "GruposGGAfterRowColChange")
801: 
802:         *-- Command1 / cmd_4c_AdicionarGrupo (Top=356->385; Left=671; W=45; H=45)
803:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar (icone some); guard no click handler
804:         loc_oPagina.AddObject("cmd_4c_AdicionarGrupo", "CommandButton")
805:         WITH loc_oPagina.cmd_4c_AdicionarGrupo
806:             .Caption       = ""
807:             .Picture       = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
808:             .ToolTipText   = "Inserir"
809:             .Top           = 385
810:             .Left          = 671
811:             .Width         = 45
812:             .Height        = 45
813:             .BackColor     = RGB(255, 255, 255)
814:             .ForeColor     = RGB(0, 128, 0)
815:             .FontName      = "Arial"

*-- Linhas 821 a 839:
821:             .Visible       = .T.
822:         ENDWITH
823: 
824:         BINDEVENT(loc_oPagina.cmd_4c_AdicionarGrupo, "Click", THIS, "BtnAdicionarGrupoClick")
825: 
826:         *-- Command2 / cmd_4c_RemoverGrupo (Top=400->429; Left=671; W=45; H=45)
827:         *-- Icone-only: Themes=.T. obrigatorio; nao desabilitar; guard no click handler
828:         loc_oPagina.AddObject("cmd_4c_RemoverGrupo", "CommandButton")
829:         WITH loc_oPagina.cmd_4c_RemoverGrupo
830:             .Caption       = ""
831:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
832:             .ToolTipText   = "Excluir"
833:             .Top           = 429
834:             .Left          = 671
835:             .Width         = 45
836:             .Height        = 45
837:             .BackColor     = RGB(255, 255, 255)
838:             .ForeColor     = RGB(255, 0, 0)
839:             .FontName      = "Arial"

*-- Linhas 845 a 853:
845:             .Visible       = .T.
846:         ENDWITH
847: 
848:         BINDEVENT(loc_oPagina.cmd_4c_RemoverGrupo, "Click", THIS, "BtnRemoverGrupoClick")
849: 
850:         THIS.TornarControlesVisiveis(loc_oPagina)
851:     ENDPROC
852: 
853:     *--------------------------------------------------------------------------

*-- Linhas 870 a 879:
870:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
871: 
872:                     *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta)
873:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
874:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
875: 
876:                     THIS.FormatarGridLista(loc_oGrid)
877:                     loc_lResultado = .T.
878:                 ENDIF
879:             ENDIF

*-- Linhas 1033 a 1042:
1033:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1034:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
1035: 
1036:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1037:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1038: 
1039:                 THIS.FormatarGridLista(loc_oGrid)
1040: 
1041:                 IF RECCOUNT("cursor_4c_Dados") = 0
1042:                     MsgAviso("Nenhum departamento encontrado.", "Buscar")

*-- Linhas 1177 a 1186:
1177:                 loc_oPagina.grd_4c_GruposGG.RecordSource = "cursor_4c_DptGg"
1178:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1179:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1180:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1181:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1182:                 GO TOP IN cursor_4c_DptGg
1183:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1184:             ENDIF
1185:         ENDIF
1186:     ENDPROC

*-- Linhas 1215 a 1224:
1215:         ENDIF
1216:         *-- Icones-only: Enabled=.F. faz icone sumir (VFP9 bug); guard no click handler
1217: 
1218:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1219:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1220:     ENDPROC
1221: 
1222:     *--------------------------------------------------------------------------
1223:     * LimparCampos - Limpa os valores dos campos da Page2
1224:     * Defaults dos OptionGroups seguem os defaults originais do legado

*-- Linhas 1257 a 1266:
1257:                 loc_oPagina.grd_4c_GruposGG.RecordSource          = "cursor_4c_DptGg"
1258:                 loc_oPagina.grd_4c_GruposGG.Column1.ControlSource = "cursor_4c_DptGg.CodGrupo"
1259:                 loc_oPagina.grd_4c_GruposGG.Column2.ControlSource = "cursor_4c_DptGg.descs"
1260:                 loc_oPagina.grd_4c_GruposGG.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1261:                 loc_oPagina.grd_4c_GruposGG.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1262:                 loc_oPagina.grd_4c_GruposGG.Refresh()
1263:             ENDIF
1264:         ENDIF
1265:     ENDPROC
1266: 


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*============================================================================
* DepartamentoBO.prg - Business Object: Cadastro de Departamentos
* Migrado de: SIGCDDPT.SCX
* Tabela principal : SigCdDpt  (chave: codigos)
* Tabela relacionada: sigdptgg (grupos do departamento)
*============================================================================
DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Propriedades: SigCdDpt
    this_cCodigo       = ""   && codigos     C(10) - Chave Primaria
    this_cDescricao    = ""   && descricaos  C(40) - Descricao do departamento
    this_cDiretor      = ""   && diretors    C(10) - FK SigCdUsu.Usuarios
    this_nSubclaEncerr = 0    && nchksubs    N(1)  - Obriga Subclas. Encerramento (1=Sim 2=Nao)
    this_nTipo         = 0    && nchktipos   N(1)  - Tipo do departamento (1=Sim 2=Nao)
    this_nAutomatico   = 0    && autos       N(1)  - Automatico (1=Sim 2=Nao)
    this_nUtilizaLanc  = 0    && UtiLacto - campo exibido no form (nao existe no schema atual)

    *-- Nome do cursor de grupos (sigdptgg)
    this_cCursorGrupos = "cursor_4c_DptGg"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os departamentos (filtro opcional por descricao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors" + ;
                       " FROM SigCdDpt"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + ;
                    " WHERE UPPER(descricaos) LIKE UPPER(" + ;
                    EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar departamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT registro por chave primaria + grupos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors," + ;
                       " nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo       = ALLTRIM(TratarNulo(codigos, "C"))
                THIS.this_cDescricao    = ALLTRIM(TratarNulo(descricaos, "C"))
                THIS.this_cDiretor      = ALLTRIM(TratarNulo(diretors, "C"))
                THIS.this_nSubclaEncerr = TratarNulo(nchksubs, "N")
                THIS.this_nTipo         = TratarNulo(nchktipos, "N")
                THIS.this_nAutomatico   = TratarNulo(autos, "N")
                THIS.this_nUtilizaLanc  = 0
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdDpt + salvar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdDpt" + ;
                       " (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSubclaEncerr) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutomatico) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento inserido mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao inserir departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdDpt + reprocessar grupos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdDpt SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " diretors   = " + EscaparSQL(THIS.this_cDiretor)   + "," + ;
                       " nchksubs   = " + FormatarNumeroSQL(THIS.this_nSubclaEncerr) + "," + ;
                       " nchktipos  = " + FormatarNumeroSQL(THIS.this_nTipo)         + "," + ;
                       " autos      = " + FormatarNumeroSQL(THIS.this_nAutomatico)   + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = THIS.SalvarGrupos(THIS.this_cCodigo)
                IF !loc_lResultado
                    MsgErro("Departamento atualizado mas erro ao salvar grupos.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao atualizar departamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigdptgg + DELETE SigCdDpt
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Remove grupos relacionados primeiro
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(THIS.this_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGg")
                TABLEREVERT(.T., "cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGg")
            IF USED("cursor_4c_DelGg")
                USE IN cursor_4c_DelGg
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Remove o registro principal
                loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + ;
                           EscaparSQL(THIS.this_cCodigo)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir departamento:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ExecutarExclusao:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do dpto no cursor_4c_DptGg (para o grid)
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aDepto[1], loc_aGrupo[1], loc_aDescs[1]
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrupos)
                USE IN (THIS.this_cCursorGrupos)
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_DptGg (CodDepto C(10), CodGrupo C(3), descs C(40))
            SET NULL OFF

            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT a.coddepto, a.codgrupo, b.descs" + ;
                           " FROM sigdptgg a" + ;
                           " JOIN SigCdGpr b ON a.codgrupo = b.codigos" + ;
                           " WHERE a.coddepto = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                           " ORDER BY a.codgrupo"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_DptGgTmp")
                    TABLEREVERT(.T., "cursor_4c_DptGgTmp")
                    USE IN cursor_4c_DptGgTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptGgTmp")
                IF loc_nResultado >= 0
                    loc_nTotal = RECCOUNT("cursor_4c_DptGgTmp")
                    IF loc_nTotal > 0
                        DIMENSION loc_aDepto[loc_nTotal]
                        DIMENSION loc_aGrupo[loc_nTotal]
                        DIMENSION loc_aDescs[loc_nTotal]
                        SELECT cursor_4c_DptGgTmp
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aDepto[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.coddepto)
                            loc_aGrupo[loc_nI] = ALLTRIM(cursor_4c_DptGgTmp.codgrupo)
                            loc_aDescs[loc_nI]  = ALLTRIM(cursor_4c_DptGgTmp.descs)
                            IF !EOF("cursor_4c_DptGgTmp")
                                SKIP IN cursor_4c_DptGgTmp
                            ENDIF
                        ENDFOR
                        FOR loc_nI = 1 TO loc_nTotal
                            SELECT cursor_4c_DptGg
                            APPEND BLANK
                            REPLACE CodDepto WITH loc_aDepto[loc_nI], ;
                                    CodGrupo WITH loc_aGrupo[loc_nI], ;
                                    descs    WITH loc_aDescs[loc_nI]
                        ENDFOR
                    ENDIF
                    IF USED("cursor_4c_DptGgTmp")
                        USE IN cursor_4c_DptGgTmp
                    ENDIF
                ELSE
                    MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            *-- Garante linha em branco para o grid poder receber entrada
            IF RECCOUNT("cursor_4c_DptGg") = 0
                SELECT cursor_4c_DptGg
                APPEND BLANK
            ENDIF

            GO TOP IN cursor_4c_DptGg
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.CarregarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Persiste cursor_4c_DptGg em sigdptgg
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SalvarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_nTotal, loc_nI, loc_aGrupos[1]
        loc_lResultado = .F.

        TRY
            *-- Remove todos os grupos existentes para este departamento
            loc_cSQL = "DELETE FROM sigdptgg WHERE coddepto = " + ;
                       EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_DelGrp")
                TABLEREVERT(.T., "cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelGrp")
            IF USED("cursor_4c_DelGrp")
                USE IN cursor_4c_DelGrp
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.

                *-- Coleta grupos nao-vazios do cursor numa array
                IF USED(THIS.this_cCursorGrupos)
                    loc_nTotal = RECCOUNT(THIS.this_cCursorGrupos)
                    IF loc_nTotal > 0
                        DIMENSION loc_aGrupos[loc_nTotal]
                        SELECT (THIS.this_cCursorGrupos)
                        GO TOP
                        FOR loc_nI = 1 TO loc_nTotal
                            loc_aGrupos[loc_nI] = ALLTRIM(cursor_4c_DptGg.CodGrupo)
                            IF !EOF("cursor_4c_DptGg")
                                SKIP IN cursor_4c_DptGg
                            ENDIF
                        ENDFOR

                        *-- Insere os grupos via SQL
                        FOR loc_nI = 1 TO loc_nTotal
                            IF !EMPTY(loc_aGrupos[loc_nI])
                                loc_cSQL = "INSERT INTO sigdptgg (pkchave, coddepto, codgrupo)" + ;
                                           " VALUES (" + ;
                                           "LEFT(REPLACE(CONVERT(VARCHAR(36),NEWID()),'-',''),20)," + ;
                                           EscaparSQL(ALLTRIM(par_cCodigo)) + "," + ;
                                           EscaparSQL(LEFT(loc_aGrupos[loc_nI], 3)) + ")"
                                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                                IF USED("cursor_4c_InsGrp")
                                    TABLEREVERT(.T., "cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsGrp")
                                IF USED("cursor_4c_InsGrp")
                                    USE IN cursor_4c_InsGrp
                                ENDIF
                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_aGrupos[loc_nI] + ;
                                             ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                ENDIF
                            ENDIF
                        ENDFOR
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.SalvarGrupos:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGruposDuplicados - Verifica se ha codigos de grupo repetidos
    *--------------------------------------------------------------------------
    FUNCTION ValidarGruposDuplicados()
        LOCAL loc_lValido, loc_nDuplic
        loc_lValido = .T.

        TRY
            IF USED(THIS.this_cCursorGrupos) AND RECCOUNT(THIS.this_cCursorGrupos) > 0
                SELECT CodGrupo FROM cursor_4c_DptGg ;
                       WHERE !EMPTY(CodGrupo) ;
                       GROUP BY CodGrupo ;
                       HAVING COUNT(*) > 1 ;
                       INTO CURSOR cursor_4c_Duplicas

                loc_nDuplic = RECCOUNT("cursor_4c_Duplicas")
                IF USED("cursor_4c_Duplicas")
                    USE IN cursor_4c_Duplicas
                ENDIF

                IF loc_nDuplic > 0
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarGruposDuplicados:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAutomatico - Verifica se ja existe outro departamento automatico
    * par_cCodIgnorar: codigo do registro atual (para excluir da verificacao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarAutomatico(par_cCodIgnorar)
        LOCAL loc_lValido, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lValido = .T.

        TRY
            IF THIS.this_nAutomatico = 1
                loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt WHERE autos = 1"
                IF VARTYPE(par_cCodIgnorar) = "C" AND !EMPTY(par_cCodIgnorar)
                    loc_cSQL = loc_cSQL + ;
                        " AND codigos <> " + EscaparSQL(ALLTRIM(par_cCodIgnorar))
                ENDIF

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_AutoChk")
                    TABLEREVERT(.T., "cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AutoChk")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_AutoChk
                    loc_nTotal = cursor_4c_AutoChk.Total
                    IF loc_nTotal > 0
                        loc_lValido = .F.
                    ENDIF
                ELSE
                    MsgErro("Erro ao verificar automatico:" + CHR(13) + ;
                             CapturarErroSQL(), "Erro SQL")
                    loc_lValido = .F.
                ENDIF

                IF USED("cursor_4c_AutoChk")
                    USE IN cursor_4c_AutoChk
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarAutomatico:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDepartamentoEmUso - Verifica se o depto esta vinculado a usuarios
    *--------------------------------------------------------------------------
    FUNCTION ValidarDepartamentoEmUso(par_cCodigo)
        LOCAL loc_lEmUso, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lEmUso = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdUsu" + ;
                       " WHERE deptos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_UsoChk")
                TABLEREVERT(.T., "cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsoChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_UsoChk
                loc_nTotal = cursor_4c_UsoChk.Total
                IF loc_nTotal > 0
                    loc_lEmUso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar uso do departamento:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_UsoChk")
                USE IN cursor_4c_UsoChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarDepartamentoEmUso:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoExistente - Verifica se o codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nTotal
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdDpt" + ;
                       " WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_CodChk")
                TABLEREVERT(.T., "cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CodChk")
            IF loc_nResultado >= 0
                SELECT cursor_4c_CodChk
                loc_nTotal = cursor_4c_CodChk.Total
                IF loc_nTotal > 0
                    loc_lExiste = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao verificar codigo:" + CHR(13) + ;
                         CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CodChk")
                USE IN cursor_4c_CodChk
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em DepartamentoBO.ValidarCodigoExistente:" + CHR(13) + ;
                     loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

