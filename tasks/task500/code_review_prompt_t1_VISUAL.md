# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 425: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 447: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPMC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1328 linhas total):

*-- Linhas 48 a 56:
48:         loc_lResultado = .F.
49: 
50:         TRY
51:             THIS.Caption = "Tabela de promo" + CHR(231) + CHR(245) + "es por per" + CHR(237) + "odo"
52: 
53:             THIS.this_oBusinessObject = CREATEOBJECT("PMCBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Erro ao criar PMCBO!" + CHR(13) + ;

*-- Linhas 63 a 75:
63:                 *-- Propagar caption para labels de titulo da Page1
64:                 loc_oCab = THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
65:                 IF VARTYPE(loc_oCab) = "O"
66:                     IF VARTYPE(loc_oCab.lbl_4c_Sombra) = "O"
67:                         loc_oCab.lbl_4c_Sombra.Caption = THIS.Caption
68:                     ENDIF
69:                     IF VARTYPE(loc_oCab.lbl_4c_Titulo) = "O"
70:                         loc_oCab.lbl_4c_Titulo.Caption = THIS.Caption
71:                     ENDIF
72:                 ENDIF
73: 
74:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
75:                     THIS.CarregarLista()

*-- Linhas 93 a 162:
93: 
94:     *==========================================================================
95:     * ConfigurarPageFrame - Cria pgf_4c_Paginas com Page1 (Lista) e Page2 (Dados)
96:     * PageFrame.Top = -29 esconde abas; controles dentro das Pages compensam +29px
97:     *==========================================================================
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100:         WITH THIS.pgf_4c_Paginas
101:             .Top       = -29
102:             .Left      = 0
103:             .Width     = THIS.Width
104:             .Height    = THIS.Height + 29
105:             .PageCount = 2
106:             .Tabs      = .F.
107:             .Page1.Caption = "Lista"
108:             .Page2.Caption = "Dados"
109:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Visible   = .T.
112:         ENDWITH
113:     ENDPROC
114: 
115:     *==========================================================================
116:     * ConfigurarPaginaLista - Page1: Cabecalho + containers botoes + Saida
117:     * Legado: cntSombra.Top=1, Grupo_op.Left=538 Top=-1, Grupo_Saida.Left=918 Top=-1
118:     * Compensacao +29px em todos os controles (PageFrame.Top=-29)
119:     *==========================================================================
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPagina
122:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
123: 
124:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
125:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126: 
127:         *-- Cabecalho escuro com titulo (cntSombra: Top=1+29=30, Left=0)
128:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH loc_oPagina.cnt_4c_Cabecalho
130:             .Top         = 30
131:             .Left        = 0
132:             .Width       = THIS.Width
133:             .Height      = 80
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137: 
138:             .AddObject("lbl_4c_Sombra", "Label")
139:             WITH .lbl_4c_Sombra
140:                 .Caption   = THIS.Caption
141:                 .Top       = 15
142:                 .Left      = 10
143:                 .Width     = THIS.Width
144:                 .Height    = 40
145:                 .FontName  = "Tahoma"
146:                 .FontSize  = 16
147:                 .FontBold  = .T.
148:                 .ForeColor = RGB(0, 0, 0)
149:                 .BackStyle = 0
150:                 .Visible   = .T.
151:             ENDWITH
152: 
153:             .AddObject("lbl_4c_Titulo", "Label")
154:             WITH .lbl_4c_Titulo
155:                 .Caption   = THIS.Caption
156:                 .Top       = 18
157:                 .Left      = 10
158:                 .Width     = THIS.Width
159:                 .Height    = 46
160:                 .FontName  = "Tahoma"
161:                 .FontSize  = 16
162:                 .FontBold  = .T.

*-- Linhas 169 a 288:
169:         *-- Container botoes CRUD (Grupo_op: Left=538, Top=-1+29=28; canonico Left=542, Top=29)
170:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
171:         WITH loc_oPagina.cnt_4c_Botoes
172:             .Top         = 29
173:             .Left        = 542
174:             .Width       = 390
175:             .Height      = 85
176:             .BackStyle   = 1
177:             .BackColor   = RGB(53, 53, 53)
178:             .BorderWidth = 0
179:             .Visible     = .T.
180: 
181:             .AddObject("cmd_4c_Incluir", "CommandButton")
182:             WITH .cmd_4c_Incluir
183:                 .Caption         = "Incluir"
184:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:                 .PicturePosition = 13
186:                 .Top             = 5
187:                 .Left            =  542
188:                 .Width           = 75
189:                 .Height          = 75
190:                 .BackColor       = RGB(255, 255, 255)
191:                 .ForeColor       = RGB(90, 90, 90)
192:                 .FontName        = "Comic Sans MS"
193:                 .FontSize        = 8
194:                 .FontBold        = .T.
195:                 .FontItalic      = .T.
196:                 .SpecialEffect   = 0
197:                 .MousePointer    = 15
198:                 .WordWrap        = .T.
199:                 .AutoSize        = .F.
200:                 .Visible         = .T.
201:             ENDWITH
202: 
203:             .AddObject("cmd_4c_Visualizar", "CommandButton")
204:             WITH .cmd_4c_Visualizar
205:                 .Caption         = "Visualizar"
206:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
207:                 .PicturePosition = 13
208:                 .Top             = 5
209:                 .Left            =  542
210:                 .Width           = 75
211:                 .Height          = 75
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .FontName        = "Comic Sans MS"
215:                 .FontSize        = 8
216:                 .FontBold        = .T.
217:                 .FontItalic      = .T.
218:                 .Themes          = .F.
219:                 .SpecialEffect   = 0
220:                 .MousePointer    = 15
221:                 .WordWrap        = .T.
222:                 .AutoSize        = .F.
223:                 .Visible         = .T.
224:             ENDWITH
225: 
226:             .AddObject("cmd_4c_Alterar", "CommandButton")
227:             WITH .cmd_4c_Alterar
228:                 .Caption         = "Alterar"
229:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:                 .PicturePosition = 13
231:                 .Top             = 5
232:                 .Left            =  542
233:                 .Width           = 75
234:                 .Height          = 75
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .FontName        = "Comic Sans MS"
238:                 .FontSize        = 8
239:                 .FontBold        = .T.
240:                 .FontItalic      = .T.
241:                 .Themes          = .F.
242:                 .SpecialEffect   = 0
243:                 .MousePointer    = 15
244:                 .WordWrap        = .T.
245:                 .AutoSize        = .F.
246:                 .Visible         = .T.
247:             ENDWITH
248: 
249:             .AddObject("cmd_4c_Excluir", "CommandButton")
250:             WITH .cmd_4c_Excluir
251:                 .Caption         = "Excluir"
252:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:                 .PicturePosition = 13
254:                 .Top             = 5
255:                 .Left            =  542
256:                 .Width           = 75
257:                 .Height          = 75
258:                 .BackColor       = RGB(255, 255, 255)
259:                 .ForeColor       = RGB(90, 90, 90)
260:                 .FontName        = "Comic Sans MS"
261:                 .FontSize        = 8
262:                 .FontBold        = .T.
263:                 .FontItalic      = .T.
264:                 .Themes          = .F.
265:                 .SpecialEffect   = 0
266:                 .MousePointer    = 15
267:                 .WordWrap        = .T.
268:                 .AutoSize        = .F.
269:                 .Visible         = .T.
270:             ENDWITH
271: 
272:             .AddObject("cmd_4c_Buscar", "CommandButton")
273:             WITH .cmd_4c_Buscar
274:                 .Caption         = "Buscar"
275:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:                 .PicturePosition = 13
277:                 .Top             = 5
278:                 .Left            =  542
279:                 .Width           = 75
280:                 .Height          = 75
281:                 .BackColor       = RGB(255, 255, 255)
282:                 .ForeColor       = RGB(90, 90, 90)
283:                 .FontName        = "Comic Sans MS"
284:                 .FontSize        = 8
285:                 .FontBold        = .T.
286:                 .FontItalic      = .T.
287:                 .Themes          = .F.
288:                 .SpecialEffect   = 0

*-- Linhas 297 a 324:
297:         *-- Grupo_Saida legado: Left=918, Top=-1 -> +29 compensacao = Top=28; canonico Top=29
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307: 
308:             .AddObject("cmd_4c_Encerrar", "CommandButton")
309:             WITH .cmd_4c_Encerrar
310:                 .Caption         = "Encerrar"
311:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:                 .PicturePosition = 13
313:                 .Top             = 5
314:                 .Left            = 917
315:                 .Width           = 90
316:                 .Height          = 75
317:                 .BackColor       = RGB(255, 255, 255)
318:                 .ForeColor       = RGB(90, 90, 90)
319:                 .FontName        = "Comic Sans MS"
320:                 .FontSize        = 8
321:                 .FontBold        = .T.
322:                 .FontItalic      = .T.
323:                 .SpecialEffect   = 0
324:                 .MousePointer    = 15

*-- Linhas 333 a 342:
333:         loc_oPagina.grd_4c_Lista.RecordSource = ""
334:         loc_oPagina.grd_4c_Lista.ColumnCount  = 8
335:         WITH loc_oPagina.grd_4c_Lista
336:             .Top                = 150
337:             .Left               = 12
338:             .Width              = 890
339:             .Height             = 460
340:             .FontName           = "Verdana"
341:             .FontSize           = 8
342:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 354 a 453:
354:             .Visible            = .T.
355:             .Column1.Width      = 80
356:             .Column1.ReadOnly   = .T.
357:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
358:             .Column2.Width      = 150
359:             .Column2.ReadOnly   = .T.
360:             .Column2.Header1.Caption = "Produto"
361:             .Column3.Width      = 80
362:             .Column3.ReadOnly   = .T.
363:             .Column3.Header1.Caption = "Tipo"
364:             .Column4.Width      = 100
365:             .Column4.ReadOnly   = .T.
366:             .Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
367:             .Column5.Width      = 90
368:             .Column5.ReadOnly   = .T.
369:             .Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
370:             .Column6.Width      = 90
371:             .Column6.ReadOnly   = .T.
372:             .Column6.Header1.Caption = "Dt final"
373:             .Column7.Width      = 80
374:             .Column7.ReadOnly   = .T.
375:             .Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
376:             .Column8.Width      = 90
377:             .Column8.ReadOnly   = .T.
378:             .Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
379:         ENDWITH
380: 
381:         *-- BINDEVENTs botoes Page1 (handlers PUBLIC para funcionar com BINDEVENT)
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
388: 
389:         THIS.TornarControlesVisiveis(loc_oPagina)
390:     ENDPROC
391: 
392:     *==========================================================================
393:     * ConfigurarPaginaDados - Page2: Container BotoesAcao
394:     * Legado: Grupo_Salva.Left=819, Top=9 -> +29 compensacao = Top=38
395:     * TextBoxes/Labels adicionados nas Fases 5-6
396:     *==========================================================================
397:     PROTECTED PROCEDURE ConfigurarPaginaDados()
398:         LOCAL loc_oPagina
399:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
400: 
401:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
402:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
403: 
404:         *-- Container botoes Salvar/Cancelar (Grupo_Salva: Left=819, Top=9+29=38)
405:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
406:         WITH loc_oPagina.cnt_4c_BotoesAcao
407:             .Top         = 38
408:             .Left        = 819
409:             .Width       = 160
410:             .Height      = 85
411:             .BackStyle   = 0
412:             .BorderWidth = 0
413:             .Visible     = .T.
414: 
415:             .AddObject("cmd_4c_Confirmar", "CommandButton")
416:             WITH .cmd_4c_Confirmar
417:                 .Caption         = "Confirmar"
418:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
419:                 .PicturePosition = 13
420:                 .Top             = 5
421:                 .Left            = 5
422:                 .Width           = 75
423:                 .Height          = 75
424:                 .BackColor       = RGB(255, 255, 255)
425:                 .ForeColor       = RGB(90, 90, 90)
426:                 .FontName        = "Comic Sans MS"
427:                 .FontSize        = 8
428:                 .FontBold        = .T.
429:                 .FontItalic      = .T.
430:                 .SpecialEffect   = 0
431:                 .MousePointer    = 15
432:                 .WordWrap        = .T.
433:                 .AutoSize        = .F.
434:                 .Visible         = .T.
435:             ENDWITH
436: 
437:             .AddObject("cmd_4c_Cancelar", "CommandButton")
438:             WITH .cmd_4c_Cancelar
439:                 .Caption         = "Encerrar"
440:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
441:                 .PicturePosition = 13
442:                 .Top             = 5
443:                 .Left            = 80
444:                 .Width           = 75
445:                 .Height          = 75
446:                 .BackColor       = RGB(255, 255, 255)
447:                 .ForeColor       = RGB(90, 90, 90)
448:                 .FontName        = "Comic Sans MS"
449:                 .FontSize        = 8
450:                 .FontBold        = .T.
451:                 .FontItalic      = .T.
452:                 .Themes          = .F.
453:                 .SpecialEffect   = 0

*-- Linhas 460 a 484:
460: 
461:         *-- Label + TextBox: Codigo (getcodigo: Top=151+29=180, Left=387, ReadOnly)
462:         *-- Legado: When=RETURN .F. -> sempre ReadOnly; TabIndex=1
463:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
464:         WITH loc_oPagina.lbl_4c_Codigo
465:             .Caption   = "C" + CHR(243) + "digo :"
466:             .Top       = 185
467:             .Left      = 343
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .ForeColor = RGB(90, 90, 90)
471:             .BackStyle = 0
472:             .Visible   = .T.
473:         ENDWITH
474: 
475:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
476:         WITH loc_oPagina.txt_4c_Codigo
477:             .Value         = ""
478:             .Top           = 180
479:             .Left          = 387
480:             .Width         = 80
481:             .Height        = 24
482:             .FontName      = "Tahoma"
483:             .FontSize      = 8
484:             .InputMask     = "!!!!!!!!!!"

*-- Linhas 491 a 547:
491: 
492:         *-- Label + TextBox: Produto (getCpros: Top=178+29=207, Left=387, MaxLength=14)
493:         *-- Legado: When=INLIST(INSERIR); Valid abre fwbuscaext em SigCdPro
494:         loc_oPagina.AddObject("lbl_4c_Produto", "Label")
495:         WITH loc_oPagina.lbl_4c_Produto
496:             .Caption   = "Produto :"
497:             .Top       = 210
498:             .Left      = 338
499:             .Width     = 47
500:             .AutoSize  = .T.
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8
503:             .ForeColor = RGB(90, 90, 90)
504:             .BackStyle = 0
505:             .Visible   = .T.
506:         ENDWITH
507: 
508:         loc_oPagina.AddObject("txt_4c_Cpros", "TextBox")
509:         WITH loc_oPagina.txt_4c_Cpros
510:             .Value         = ""
511:             .Top           = 207
512:             .Left          = 387
513:             .Width         = 108
514:             .Height        = 21
515:             .MaxLength     = 14
516:             .FontName      = "Tahoma"
517:             .FontSize      = 8
518:             .SpecialEffect = 1
519:             .Themes        = .F.
520:             .Visible       = .T.
521:         ENDWITH
522: 
523:         *-- Label + ComboBox: Tipo de Promocao (cmbTpDesc: Top=202+29=231, Left=387)
524:         *-- Legado: RowSourceType=1, RowSource="1-Brinde"; When=INLIST(INSERIR)
525:         loc_oPagina.AddObject("lbl_4c_TipoPromocao", "Label")
526:         WITH loc_oPagina.lbl_4c_TipoPromocao
527:             .Caption   = "Tipo de Promo" + CHR(231) + CHR(227) + "o :"
528:             .Top       = 234
529:             .Left      = 291
530:             .Width     = 94
531:             .Height    = 15
532:             .FontName  = "Tahoma"
533:             .FontSize  = 8
534:             .ForeColor = RGB(90, 90, 90)
535:             .BackStyle = 0
536:             .Visible   = .T.
537:         ENDWITH
538: 
539:         loc_oPagina.AddObject("cbo_4c_CmbTpDesc", "ComboBox")
540:         WITH loc_oPagina.cbo_4c_CmbTpDesc
541:             .Top           = 231
542:             .Left          = 387
543:             .Width         = 221
544:             .Height        = 21
545:             .FontName      = "Tahoma"
546:             .FontSize      = 8
547:             .RowSourceType = 1

*-- Linhas 553 a 635:
553: 
554:         *-- Label + TextBox: Data Inicial (getDtini: Top=227+29=256, Left=387, Width=80)
555:         *-- Legado: When=INLIST(INSERIR); Alignment=3; editavel apenas no INSERIR
556:         loc_oPagina.AddObject("lbl_4c_DataInicial", "Label")
557:         WITH loc_oPagina.lbl_4c_DataInicial
558:             .Caption   = "Data Inicial :"
559:             .Top       = 261
560:             .Left      = 323
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .ForeColor = RGB(90, 90, 90)
564:             .BackStyle = 0
565:             .Visible   = .T.
566:         ENDWITH
567: 
568:         loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
569:         WITH loc_oPagina.txt_4c_Dtini
570:             .Value         = {}
571:             .Top           = 256
572:             .Left          = 387
573:             .Width         = 80
574:             .Height        = 24
575:             .Alignment     = 3
576:             .FontName      = "Tahoma"
577:             .FontSize      = 8
578:             .SpecialEffect = 1
579:             .Themes        = .F.
580:             .Visible       = .T.
581:         ENDWITH
582: 
583:         *-- Label + TextBox: Data Final (GetDtfin: Top=254+29=283, Left=387, Width=80)
584:         *-- Legado: When=INLIST(INSERIR); Alignment=3; editavel apenas no INSERIR
585:         loc_oPagina.AddObject("lbl_4c_DataFinal", "Label")
586:         WITH loc_oPagina.lbl_4c_DataFinal
587:             .Caption   = "Data Final :"
588:             .Top       = 288
589:             .Left      = 328
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .ForeColor = RGB(90, 90, 90)
593:             .BackStyle = 0
594:             .Visible   = .T.
595:         ENDWITH
596: 
597:         loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
598:         WITH loc_oPagina.txt_4c_Dtfin
599:             .Value         = {}
600:             .Top           = 283
601:             .Left          = 387
602:             .Width         = 80
603:             .Height        = 24
604:             .Alignment     = 3
605:             .FontName      = "Tahoma"
606:             .FontSize      = 8
607:             .SpecialEffect = 1
608:             .Themes        = .F.
609:             .Visible       = .T.
610:         ENDWITH
611: 
612:         *-- Label + TextBox: Valor Minimo (GetValmin: Top=282+29=311, Left=387, Width=126)
613:         *-- Legado: InputMask="99,999,999.99"; Alignment=3; editavel em INSERIR e ALTERAR
614:         loc_oPagina.AddObject("lbl_4c_ValorMin", "Label")
615:         WITH loc_oPagina.lbl_4c_ValorMin
616:             .Caption   = "Valor Min :"
617:             .Top       = 316
618:             .Left      = 333
619:             .FontName  = "Tahoma"
620:             .FontSize  = 8
621:             .ForeColor = RGB(90, 90, 90)
622:             .BackStyle = 0
623:             .Visible   = .T.
624:         ENDWITH
625: 
626:         loc_oPagina.AddObject("txt_4c_Valmin", "TextBox")
627:         WITH loc_oPagina.txt_4c_Valmin
628:             .Value         = 0
629:             .Top           = 311
630:             .Left          = 387
631:             .Width         = 126
632:             .Height        = 24
633:             .Alignment     = 3
634:             .InputMask     = "99,999,999.99"
635:             .FontName      = "Tahoma"

*-- Linhas 645 a 654:
645:         BINDEVENT(loc_oPagina.txt_4c_Cpros, "KeyPress", THIS, "ValidarProduto")
646: 
647:         *-- BINDEVENTs botoes Page2
648:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
649:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
650: 
651:         THIS.TornarControlesVisiveis(loc_oPagina)
652:     ENDPROC
653: 
654:     *==========================================================================

*-- Linhas 678 a 693:
678:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
679:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
680:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
681:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
682:                         loc_oGrid.Column2.Header1.Caption = "Produto"
683:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
684:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
685:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
686:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
687:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
688:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
689:                         THIS.FormatarGridLista(loc_oGrid)
690:                     ENDIF
691:                     loc_lResultado = .T.
692:                 ENDIF
693:             ENDIF

*-- Linhas 933 a 948:
933:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.dtfin"
934:                         loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usualts"
935:                         loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtalts"
936:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
937:                         loc_oGrid.Column2.Header1.Caption = "Produto"
938:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
939:                         loc_oGrid.Column4.Header1.Caption = "Valor M" + CHR(237) + "nimo"
940:                         loc_oGrid.Column5.Header1.Caption = "Dt In" + CHR(237) + "cio"
941:                         loc_oGrid.Column6.Header1.Caption = "Dt final"
942:                         loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
943:                         loc_oGrid.Column8.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
944:                         THIS.FormatarGridLista(loc_oGrid)
945:                     ENDIF
946:                 ENDIF
947:             ELSE
948:                 THIS.CarregarLista()

*-- Linhas 1198 a 1217:
1198: 
1199:         DO CASE
1200:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1201:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
1202:                     loc_oBtns.cmd_4c_Confirmar.Enabled = .T.
1203:                 ENDIF
1204:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
1205:                     loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
1206:                 ENDIF
1207:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1208:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Confirmar", 5)
1209:                     loc_oBtns.cmd_4c_Confirmar.Enabled = .F.
1210:                 ENDIF
1211:                 IF PEMSTATUS(loc_oBtns, "cmd_4c_Cancelar", 5)
1212:                     loc_oBtns.cmd_4c_Cancelar.Enabled = .T.
1213:                 ENDIF
1214:         ENDCASE
1215:     ENDPROC
1216: 
1217:     *==========================================================================


### BO (C:\4c\projeto\app\classes\PMCBO.prg):
*==============================================================================
* PMCBO.prg - Business Object: Tabela de Promo??es por Per?odo
* Tabela: SigCdPmc (PK: codigo)
* Schema:
*   codigo   char(10)     PK  auto-gerado PMC+AAMM+SEQ
*   cpros    char(14)     FK SigCdPro.CPros
*   tppro    numeric(2,0) tipo (1=Brinde)
*   dtini    datetime     data inicial
*   dtfin    datetime     data final
*   valmin   numeric(9,2) valor minimo
*   usualts  char(10)     usuario ultima alteracao
*   dtalts   datetime     data/hora ultima alteracao
*==============================================================================
DEFINE CLASS PMCBO AS BusinessBase

    *-- Chave prim?ria
    this_cCodigo   = ""

    *-- Produto (FK SigCdPro.CPros)
    this_cCpros    = ""

    *-- Tipo de promo??o: 1=Brinde
    this_nTppro    = 0

    *-- Per?odo de vig?ncia
    this_tDtini    = {}
    this_tDtfin    = {}

    *-- Valor m?nimo da venda para conceder o brinde
    this_nValmin   = 0

    *-- Auditoria
    this_cUsualts  = ""
    this_tDtalts   = {}

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPmc"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "")
            THIS.this_cCpros    = TratarNulo(cpros,    "")
            THIS.this_nTppro    = TratarNulo(tppro,    0)
            THIS.this_tDtini    = TratarNulo(dtini,    {})
            THIS.this_tDtfin    = TratarNulo(dtfin,    {})
            THIS.this_nValmin   = TratarNulo(valmin,   0)
            THIS.this_cUsualts  = TratarNulo(usualts,  "")
            THIS.this_tDtalts   = TratarNulo(dtalts,   {})
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT lista para o grid
    * par_cFiltro: condi??o SQL adicional (sem WHERE), ou "" para todos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + loc_cWhere + ;
                       " ORDER BY codigo"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar promo??es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Buscar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo c?digo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, cpros, tppro, valmin, dtini, dtfin," + ;
                       " usualts, dtalts" + ;
                       " FROM SigCdPmc" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.CarregarPorCodigo:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera c?digo auto no formato PMC+AAMM+SEQ (ex: PMC2608001)
    * Replica l?gica original: 'PMC'+SUBSTR(STR(YEAR),3)+PADL(MONTH,2,'0')+SEQ
    *==========================================================================
    PROCEDURE GerarCodigo()
    *==========================================================================
        LOCAL loc_cPrefixo, loc_cSQL, loc_nResult, loc_cCodigo, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCodigo  = ""

        TRY
            loc_cPrefixo = "PMC" + SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                           PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                       " WHERE codigo LIKE " + EscaparSQL(loc_cPrefixo + "%")

            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")

            IF loc_nResult >= 0
                SELECT cursor_4c_Seq
                loc_nSeq    = cursor_4c_Seq.qtd + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
                USE IN cursor_4c_Seq
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao gerar c?digo PMC:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_Seq")
                    USE IN cursor_4c_Seq
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.GerarCodigo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF loc_lSucesso
            THIS.this_cCodigo = loc_cCodigo
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDtIniFim - Valida que dtini <= dtfin e que o per?odo n?o existe
    * Retorna "" se OK, ou mensagem de erro
    *==========================================================================
    PROCEDURE ValidarPeriodo()
    *==========================================================================
        LOCAL loc_cMsg, loc_cSQL, loc_nResult, loc_cDtIni, loc_cDtFin, loc_lSucesso
        loc_cMsg     = ""
        loc_lSucesso = .T.

        TRY
            *-- Validar campos obrigat?rios
            IF EMPTY(THIS.this_cCpros)
                loc_lSucesso = "Produto n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtini)
                loc_lSucesso = "Data Inicial n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF EMPTY(THIS.this_tDtfin)
                loc_lSucesso = "Data final n" + CHR(227) + "o pode ficar em branco!"
            ENDIF
            IF THIS.this_tDtini > THIS.this_tDtfin
                loc_lSucesso = "As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!"
            ENDIF

            *-- Verificar sobreposi??o de per?odo para o mesmo produto (s? no INSERT)
            IF THIS.this_lNovoRegistro
                loc_cDtIni = FormatarDataSQL(THIS.this_tDtini)
                loc_cDtFin = FormatarDataSQL(THIS.this_tDtfin)

                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPmc" + ;
                           " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                           " AND (" + ;
                           "  " + loc_cDtIni + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           " OR " + ;
                           "  " + loc_cDtFin + " BETWEEN" + ;
                           "    LEFT(CONVERT(VARCHAR, dtini, 120), 10)" + ;
                           "    AND LEFT(CONVERT(VARCHAR, dtfin, 120), 10)" + ;
                           ")"

                IF USED("cursor_4c_Val")
                    USE IN cursor_4c_Val
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Val")

                IF loc_nResult >= 0
                    SELECT cursor_4c_Val
                    IF cursor_4c_Val.qtd > 0
                        loc_cMsg = "Esse intervalo j" + CHR(225) + " est" + CHR(225) + ;
                                   " cadastrado para esse produto!"
                    ENDIF
                    USE IN cursor_4c_Val
                ELSE
                    MsgErro("Erro ao validar per?odo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    IF USED("cursor_4c_Val")
                        USE IN cursor_4c_Val
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ValidarPeriodo:" + CHR(13) + loException.Message, "Erro")
            loc_cMsg = "Erro interno ao validar per?odo."
        ENDTRY

        RETURN loc_cMsg
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPmc" + ;
                       " (codigo, cpros, tppro, dtini, dtfin, valmin, usualts, dtalts)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo)            + ", " + ;
                       EscaparSQL(THIS.this_cCpros)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTppro)       + ", " + ;
                       FormatarDataSQL(THIS.this_tDtini)         + ", " + ;
                       FormatarDataSQL(THIS.this_tDtfin)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValmin)      + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)           + ", " + ;
                       FormatarDataSQL(THIS.this_tDtalts)        + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Inserir:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPmc SET" + ;
                       " cpros   = " + EscaparSQL(THIS.this_cCpros)          + ", " + ;
                       " tppro   = " + FormatarNumeroSQL(THIS.this_nTppro)   + ", " + ;
                       " dtini   = " + FormatarDataSQL(THIS.this_tDtini)     + ", " + ;
                       " dtfin   = " + FormatarDataSQL(THIS.this_tDtfin)     + ", " + ;
                       " valmin  = " + FormatarNumeroSQL(THIS.this_nValmin)  + ", " + ;
                       " usualts = " + EscaparSQL(THIS.this_cUsualts)        + ", " + ;
                       " dtalts  = " + FormatarDataSQL(THIS.this_tDtalts)    + ;
                       " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.Atualizar:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPmc WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir promo??o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em PMCBO.ExecutarExclusao:" + CHR(13) + loException.Message + ;
                    CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

