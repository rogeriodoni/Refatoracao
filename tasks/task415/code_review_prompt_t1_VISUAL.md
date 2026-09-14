# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 182: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 247: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 441: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 462: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFct.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1982 linhas total):

*-- Linhas 32 a 44:
32:             THIS.this_nTipo = IIF(TYPE("pcTipo") <> "C", 0, IIF(pcTipo == "C", 1, 2))
33:             DO CASE
34:             CASE THIS.this_nTipo = 1
35:                 THIS.Caption = "Cadastro de Perfil de Contas"
36:             CASE THIS.this_nTipo = 2
37:                 THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o"
38:             OTHERWISE
39:                 THIS.Caption = "Cadastro de Ficha T" + CHR(233) + "cnica"
40:             ENDCASE
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro("Erro ao inicializar FormFct:" + CHR(13) + loc_oErro.Message, "Erro")
44:         ENDTRY

*-- Linhas 100 a 116:
100:         TRY
101:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
102:             WITH THIS.pgf_4c_Paginas
103:                 .Top       = -29
104:                 .Left      = 0
105:                 .Width     = THIS.Width
106:                 .Height    = THIS.Height + 29
107:                 .Tabs      = .F.
108:                 .PageCount = 2
109:                 .Page1.Caption = "Lista"
110:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:                 .Page2.Caption = "Dados"
112:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:                 .Visible   = .T.
114:             ENDWITH
115:             THIS.ConfigurarPaginaLista()
116:             THIS.ConfigurarPaginaDados()

*-- Linhas 131 a 275:
131: 
132:             loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
133:             WITH loc_oPag.cnt_4c_Cabecalho
134:                 .Top       = 30
135:                 .Left      = 0
136:                 .Width     = THIS.Width
137:                 .Height    = 30
138:                 .BackStyle = 1
139:                 .BackColor = RGB(64, 64, 64)
140:                 .Visible   = .T.
141:                 .AddObject("lbl_4c_Titulo", "Label")
142:                 WITH .lbl_4c_Titulo
143:                     .Top       = 0
144:                     .Left      = 0
145:                     .Width     = THIS.Width
146:                     .Height    = 30
147:                     .AutoSize  = .F.
148:                     .BackStyle = 0
149:                     .ForeColor = RGB(255, 255, 255)
150:                     .FontSize  = 12
151:                     .FontBold  = .T.
152:                     DO CASE
153:                     CASE THIS.this_nTipo = 1
154:                         .Caption = "  Perfis de Contas"
155:                     CASE THIS.this_nTipo = 2
156:                         .Caption = "  Movimenta" + CHR(231) + CHR(227) + "o"
157:                     OTHERWISE
158:                         .Caption = "  Fichas T" + CHR(233) + "cnicas de Produtos"
159:                     ENDCASE
160:                     .Visible   = .T.
161:                 ENDWITH
162:             ENDWITH
163: 
164:             loc_oPag.AddObject("cnt_4c_Botoes", "Container")
165:             WITH loc_oPag.cnt_4c_Botoes
166:                 .Top       = 29
167:                 .Left      =  542
168:                 .Width     = 390
169:                 .Height    = 85
170:                 .BackStyle = 1
171:                 .BackColor = RGB(53, 53, 53)
172:                 .Visible   = .T.
173:                 .AddObject("cmd_4c_Incluir", "CommandButton")
174:                 WITH .cmd_4c_Incluir
175:                     .Top             = 5
176:                     .Left            =  542
177:                     .Width           = 75
178:                     .Height          = 75
179:                     .Caption         = "Incluir"
180:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
181:                     .PicturePosition = 13
182:                     .FontName        = "Comic Sans MS"
183:                     .FontBold        = .T.
184:                     .FontItalic      = .T.
185:                     .FontSize        = 8
186:                     .ForeColor       = RGB(90, 90, 90)
187:                     .BackColor       = RGB(255, 255, 255)
188:                     .SpecialEffect   = 0
189:                     .MousePointer    = 15
190:                     .WordWrap        = .T.
191:                     .AutoSize        = .F.
192:                     .Visible         = .T.
193:                 ENDWITH
194:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
195:                 WITH .cmd_4c_Visualizar
196:                     .Top             = 5
197:                     .Left            =  542
198:                     .Width           = 75
199:                     .Height          = 75
200:                     .Caption         = "Visualizar"
201:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:                     .PicturePosition = 13
203:                     .FontName        = "Comic Sans MS"
204:                     .FontBold        = .T.
205:                     .FontItalic      = .T.
206:                     .FontSize        = 8
207:                     .ForeColor       = RGB(90, 90, 90)
208:                     .BackColor       = RGB(255, 255, 255)
209:                     .Themes          = .F.
210:                     .SpecialEffect   = 0
211:                     .MousePointer    = 15
212:                     .WordWrap        = .T.
213:                     .AutoSize        = .F.
214:                     .Visible         = .T.
215:                 ENDWITH
216:                 .AddObject("cmd_4c_Alterar", "CommandButton")
217:                 WITH .cmd_4c_Alterar
218:                     .Top             = 5
219:                     .Left            =  542
220:                     .Width           = 75
221:                     .Height          = 75
222:                     .Caption         = "Alterar"
223:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
224:                     .PicturePosition = 13
225:                     .FontName        = "Comic Sans MS"
226:                     .FontBold        = .T.
227:                     .FontItalic      = .T.
228:                     .FontSize        = 8
229:                     .ForeColor       = RGB(90, 90, 90)
230:                     .BackColor       = RGB(255, 255, 255)
231:                     .Themes          = .F.
232:                     .SpecialEffect   = 0
233:                     .MousePointer    = 15
234:                     .WordWrap        = .T.
235:                     .AutoSize        = .F.
236:                     .Visible         = .T.
237:                 ENDWITH
238:                 .AddObject("cmd_4c_Excluir", "CommandButton")
239:                 WITH .cmd_4c_Excluir
240:                     .Top             = 5
241:                     .Left            =  542
242:                     .Width           = 75
243:                     .Height          = 75
244:                     .Caption         = "Excluir"
245:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:                     .PicturePosition = 13
247:                     .FontName        = "Comic Sans MS"
248:                     .FontBold        = .T.
249:                     .FontItalic      = .T.
250:                     .FontSize        = 8
251:                     .ForeColor       = RGB(90, 90, 90)
252:                     .BackColor       = RGB(255, 255, 255)
253:                     .Themes          = .F.
254:                     .SpecialEffect   = 0
255:                     .MousePointer    = 15
256:                     .WordWrap        = .T.
257:                     .AutoSize        = .F.
258:                     .Visible         = .T.
259:                 ENDWITH
260:                 .AddObject("cmd_4c_Buscar", "CommandButton")
261:                 WITH .cmd_4c_Buscar
262:                     .Top             = 5
263:                     .Left            =  542
264:                     .Width           = 75
265:                     .Height          = 75
266:                     .Caption         = "Buscar"
267:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
268:                     .PicturePosition = 13
269:                     .FontName        = "Comic Sans MS"
270:                     .FontBold        = .T.
271:                     .FontItalic      = .T.
272:                     .FontSize        = 8
273:                     .ForeColor       = RGB(90, 90, 90)
274:                     .BackColor       = RGB(255, 255, 255)
275:                     .Themes          = .F.

*-- Linhas 283 a 307:
283: 
284:             loc_oPag.AddObject("cnt_4c_Saida", "Container")
285:             WITH loc_oPag.cnt_4c_Saida
286:                 .Top       = 29
287:                 .Left      = 917
288:                 .Width     = 90
289:                 .Height    = 85
290:                 .BackStyle = 0
291:                 .Visible   = .T.
292:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
293:                 WITH .cmd_4c_Encerrar
294:                     .Top             = 5
295:                     .Left            = 917
296:                     .Width           = 90
297:                     .Height          = 75
298:                     .Caption         = "Encerrar"
299:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:                     .PicturePosition = 13
301:                     .FontName        = "Comic Sans MS"
302:                     .FontBold        = .T.
303:                     .FontItalic      = .T.
304:                     .FontSize        = 8
305:                     .ForeColor       = RGB(90, 90, 90)
306:                     .BackColor       = RGB(255, 255, 255)
307:                     .SpecialEffect   = 0

*-- Linhas 314 a 348:
314: 
315:             loc_oPag.AddObject("shp_4c_Legenda", "Shape")
316:             WITH loc_oPag.shp_4c_Legenda
317:                 .Top         = 123
318:                 .Left        = 696
319:                 .Width       = 20
320:                 .Height      = 16
321:                 .BackStyle   = 1
322:                 .BackColor   = RGB(255, 255, 187)
323:                 .BorderStyle = 1
324:                 .Visible     = .T.
325:             ENDWITH
326: 
327:             loc_oPag.AddObject("lbl_4c_LegendaFicha", "Label")
328:             WITH loc_oPag.lbl_4c_LegendaFicha
329:                 .Top       = 126
330:                 .Left      = 719
331:                 .Width     = 200
332:                 .Height    = 18
333:                 .AutoSize  = .F.
334:                 .BackStyle = 0
335:                 .Caption   = "Ficha T" + CHR(233) + "cnica Criada"
336:                 .Visible   = .T.
337:             ENDWITH
338: 
339:             loc_oPag.AddObject("grd_4c_Lista", "Grid")
340:             loc_oPag.grd_4c_Lista.ColumnCount = 4
341:             WITH loc_oPag.grd_4c_Lista
342:                 .Top          = 152
343:                 .Left         = 11
344:                 .Width        = 941
345:                 .Height       = 470
346:                 .RecordSource = "crDados"
347:                 .ReadOnly     = .T.
348:                 .GridLines    = 1

*-- Linhas 355 a 409:
355:                     DO CASE
356:                     CASE THIS.this_nTipo = 1
357:                         .Width           = 100
358:                         .Header1.Caption = "Grupo"
359:                     CASE THIS.this_nTipo = 2
360:                         .Width           = 100
361:                         .Header1.Caption = "Grupo"
362:                     OTHERWISE
363:                         .Width           = 80
364:                         .Header1.Caption = "Grupo"
365:                     ENDCASE
366:                     .ReadOnly = .T.
367:                 ENDWITH
368:                 WITH .Column2
369:                     .ControlSource   = "crDados.SGrus"
370:                     .Width           = IIF(THIS.this_nTipo = 0, 100, 0)
371:                     .Header1.Caption = "Subgrupo"
372:                     .ReadOnly        = .T.
373:                 ENDWITH
374:                 WITH .Column3
375:                     .ControlSource = "crDados.DGrus"
376:                     DO CASE
377:                     CASE THIS.this_nTipo = 1
378:                         .Width           = 641
379:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
380:                     CASE THIS.this_nTipo = 2
381:                         .Width           = 641
382:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
383:                     OTHERWISE
384:                         .Width           = 403
385:                         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Grupo"
386:                     ENDCASE
387:                     .ReadOnly = .T.
388:                 ENDWITH
389:                 WITH .Column4
390:                     .ControlSource   = "crDados.DSGru"
391:                     .Width           = IIF(THIS.this_nTipo = 0, 358, 0)
392:                     .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Subgrupo"
393:                     .ReadOnly        = .T.
394:                 ENDWITH
395:             ENDWITH
396:             loc_oPag.grd_4c_Lista.SetAll("DynamicBackColor", ;
397:                 "IIF(EMPTY(crDados.TemDados), RGB(255,255,255), RGB(255,255,187))", "Column")
398: 
399:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
400:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
401:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
402:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
403:             BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
404:             BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
405:             BINDEVENT(loc_oPag.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
406: 
407:             THIS.TornarControlesVisiveis(loc_oPag)
408:             loc_lResultado = .T.
409:         CATCH TO loc_oErro

*-- Linhas 422 a 468:
422: 
423:             loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
424:             WITH loc_oPag.cnt_4c_BotoesAcao
425:                 .Top       = 38
426:                 .Left      = 820
427:                 .Width     = 160
428:                 .Height    = 85
429:                 .BackStyle = 1
430:                 .BackColor = RGB(255, 255, 255)
431:                 .Visible   = .T.
432:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
433:                 WITH .cmd_4c_Confirmar
434:                     .Top             = 5
435:                     .Left            = 5
436:                     .Width           = 70
437:                     .Height          = 75
438:                     .Caption         = "Confirmar"
439:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
440:                     .PicturePosition = 13
441:                     .FontName        = "Comic Sans MS"
442:                     .FontBold        = .T.
443:                     .FontItalic      = .T.
444:                     .FontSize        = 8
445:                     .ForeColor       = RGB(90, 90, 90)
446:                     .BackColor       = RGB(255, 255, 255)
447:                     .SpecialEffect   = 0
448:                     .MousePointer    = 15
449:                     .WordWrap        = .T.
450:                     .AutoSize        = .F.
451:                     .Visible         = .T.
452:                 ENDWITH
453:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
454:                 WITH .cmd_4c_Cancelar
455:                     .Top             = 5
456:                     .Left            = 80
457:                     .Width           = 75
458:                     .Height          = 75
459:                     .Caption         = "Encerrar"
460:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
461:                     .PicturePosition = 13
462:                     .FontName        = "Comic Sans MS"
463:                     .FontBold        = .T.
464:                     .FontItalic      = .T.
465:                     .FontSize        = 8
466:                     .ForeColor       = RGB(90, 90, 90)
467:                     .BackColor       = RGB(255, 255, 255)
468:                     .Themes          = .F.

*-- Linhas 476 a 499:
476: 
477:             loc_oPag.AddObject("pgf_4c_SubPaginas", "PageFrame")
478:             WITH loc_oPag.pgf_4c_SubPaginas
479:                 .Top       = 152
480:                 .Left      = 0
481:                 .Width     = THIS.Width
482:                 .Height    = 477
483:                 .Tabs      = .T.
484:                 .PageCount = 2
485:                 .Page1.Caption = "Ficha T" + CHR(233) + "cnica"
486:                 .Page2.Caption = "Complementos"
487:                 .Visible   = .T.
488:             ENDWITH
489: 
490:             THIS.ConfigurarPgFicha()
491:             THIS.ConfigurarPgCompl()
492: 
493:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
494:             BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
495: 
496:             THIS.TornarControlesVisiveis(loc_oPag)
497:             loc_lResultado = .T.
498:         CATCH TO loc_oErro
499:             MsgErro("Erro em ConfigurarPaginaDados:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 509 a 903:
509:         TRY
510:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
511: 
512:             loc_oPg.AddObject("lbl_4c_LabelGrupo", "Label")
513:             WITH loc_oPg.lbl_4c_LabelGrupo
514:                 .Top      = 20
515:                 .Left     = 55
516:                 .Width    = 40
517:                 .Height   = 18
518:                 .AutoSize = .F.
519:                 .Caption  = "Grupo :"
520:                 .Visible  = .T.
521:             ENDWITH
522: 
523:             loc_oPg.AddObject("txt_4c_CGrus", "TextBox")
524:             WITH loc_oPg.txt_4c_CGrus
525:                 .Top           = 17
526:                 .Left          = 98
527:                 .Width         = 80
528:                 .Height        = 20
529:                 .Enabled       = .F.
530:                 .ControlSource = "crFichaCab.CGrus"
531:                 .Visible       = .T.
532:             ENDWITH
533: 
534:             loc_oPg.AddObject("txt_4c_DGrus", "TextBox")
535:             WITH loc_oPg.txt_4c_DGrus
536:                 .Top           = 17
537:                 .Left          = 180
538:                 .Width         = 290
539:                 .Height        = 20
540:                 .Enabled       = .F.
541:                 .ControlSource = "crFichaCab.DGrus"
542:                 .Visible       = .T.
543:             ENDWITH
544: 
545:             loc_oPg.AddObject("lbl_4c_LabelSGrus", "Label")
546:             WITH loc_oPg.lbl_4c_LabelSGrus
547:                 .Top      = 45
548:                 .Left     = 25
549:                 .Width    = 70
550:                 .Height   = 18
551:                 .AutoSize = .F.
552:                 .Caption  = "Sub-grupo :"
553:                 .Visible  = (THIS.this_nTipo = 0)
554:             ENDWITH
555: 
556:             loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
557:             WITH loc_oPg.txt_4c_SGrus
558:                 .Top           = 42
559:                 .Left          = 98
560:                 .Width         = 80
561:                 .Height        = 20
562:                 .Enabled       = .F.
563:                 .ControlSource = "crFichaCab.SGrus"
564:                 .Visible       = (THIS.this_nTipo = 0)
565:             ENDWITH
566: 
567:             loc_oPg.AddObject("txt_4c_DSGru", "TextBox")
568:             WITH loc_oPg.txt_4c_DSGru
569:                 .Top           = 42
570:                 .Left          = 180
571:                 .Width         = 290
572:                 .Height        = 20
573:                 .Enabled       = .F.
574:                 .ControlSource = "crFichaCab.DSGru"
575:                 .Visible       = (THIS.this_nTipo = 0)
576:             ENDWITH
577: 
578:             loc_oPg.AddObject("lbl_4c_LabelChkDims", "Label")
579:             WITH loc_oPg.lbl_4c_LabelChkDims
580:                 .Top      = 10
581:                 .Left     = 620
582:                 .Width    = 105
583:                 .Height   = 18
584:                 .AutoSize = .F.
585:                 .Caption  = "Dimens" + CHR(245) + "es :"
586:                 .Visible  = (THIS.this_nTipo = 0)
587:             ENDWITH
588: 
589:             loc_oPg.AddObject("opt_4c_NChkDims", "OptionGroup")
590:             WITH loc_oPg.opt_4c_NChkDims
591:                 .Top           = 10
592:                 .Left          = 729
593:                 .Width         = 180
594:                 .Height        = 16
595:                 .ButtonCount   = 2
596:                 .Value         = 1
597:                 .ControlSource = "crFichaCab.nChkDims"
598:                 .Visible       = (THIS.this_nTipo = 0)
599:                 WITH .Buttons(1)
600:                     .Caption   = "Sim"
601:                     .Width     = 50
602:                     .BackStyle = 0
603:                 ENDWITH
604:                 WITH .Buttons(2)
605:                     .Caption   = "N" + CHR(227) + "o"
606:                     .Left      = 55
607:                     .Width     = 60
608:                     .BackStyle = 0
609:                 ENDWITH
610:             ENDWITH
611: 
612:             loc_oPg.AddObject("lbl_4c_LabelChkTems", "Label")
613:             WITH loc_oPg.lbl_4c_LabelChkTems
614:                 .Top      = 29
615:                 .Left     = 620
616:                 .Width    = 105
617:                 .Height   = 18
618:                 .AutoSize = .F.
619:                 .Caption  = "Tempos :"
620:                 .Visible  = (THIS.this_nTipo = 0)
621:             ENDWITH
622: 
623:             loc_oPg.AddObject("opt_4c_NChkTems", "OptionGroup")
624:             WITH loc_oPg.opt_4c_NChkTems
625:                 .Top           = 29
626:                 .Left          = 729
627:                 .Width         = 180
628:                 .Height        = 16
629:                 .ButtonCount   = 2
630:                 .Value         = 1
631:                 .ControlSource = "crFichaCab.nChkTems"
632:                 .Visible       = (THIS.this_nTipo = 0)
633:                 WITH .Buttons(1)
634:                     .Caption   = "Sim"
635:                     .Width     = 50
636:                     .BackStyle = 0
637:                 ENDWITH
638:                 WITH .Buttons(2)
639:                     .Caption   = "N" + CHR(227) + "o"
640:                     .Left      = 55
641:                     .Width     = 60
642:                     .BackStyle = 0
643:                 ENDWITH
644:             ENDWITH
645: 
646:             loc_oPg.AddObject("lbl_4c_LabelChkPess", "Label")
647:             WITH loc_oPg.lbl_4c_LabelChkPess
648:                 .Top      = 49
649:                 .Left     = 620
650:                 .Width    = 105
651:                 .Height   = 18
652:                 .AutoSize = .F.
653:                 .Caption  = "Pessoas :"
654:                 .Visible  = (THIS.this_nTipo = 0)
655:             ENDWITH
656: 
657:             loc_oPg.AddObject("opt_4c_NChkPess", "OptionGroup")
658:             WITH loc_oPg.opt_4c_NChkPess
659:                 .Top           = 49
660:                 .Left          = 729
661:                 .Width         = 180
662:                 .Height        = 16
663:                 .ButtonCount   = 2
664:                 .Value         = 1
665:                 .ControlSource = "crFichaCab.nChkPess"
666:                 .Visible       = (THIS.this_nTipo = 0)
667:                 WITH .Buttons(1)
668:                     .Caption   = "Sim"
669:                     .Width     = 50
670:                     .BackStyle = 0
671:                 ENDWITH
672:                 WITH .Buttons(2)
673:                     .Caption   = "N" + CHR(227) + "o"
674:                     .Left      = 55
675:                     .Width     = 60
676:                     .BackStyle = 0
677:                 ENDWITH
678:             ENDWITH
679: 
680:             loc_oPg.AddObject("grd_4c_Fichas", "Grid")
681:             loc_oPg.grd_4c_Fichas.ColumnCount = 9
682:             WITH loc_oPg.grd_4c_Fichas
683:                 .Top          = 75
684:                 .Left         = 12
685:                 .Width        = 933
686:                 .Height       = 309
687:                 .HeaderHeight = 18
688:                 .RecordSource = "crFichaTec"
689:                 .ReadOnly     = .F.
690:                 .GridLines    = 1
691:                 .DeleteMark   = .F.
692:                 .RecordMark   = .F.
693:                 .Visible      = .T.
694:                 WITH .Column1
695:                     .Width           = 200
696:                     .ControlSource   = "crFichaTec.CCars"
697:                     .Header1.Caption = "Grupo Caracter" + CHR(237) + "sticas"
698:                 ENDWITH
699:                 WITH .Column2
700:                     .Width           = 200
701:                     .ControlSource   = "crFichaTec.CTits"
702:                     .Header1.Caption = "T" + CHR(237) + "tulo Caracter" + CHR(237) + "sticas"
703:                 ENDWITH
704:                 WITH .Column3
705:                     .Width           = 50
706:                     .ControlSource   = "crFichaTec.COrds"
707:                     .Header1.Caption = "Ordem"
708:                     .Text1.InputMask = "999"
709:                 ENDWITH
710:                 WITH .Column4
711:                     .Width           = 50
712:                     .ControlSource   = "crFichaTec.CLins"
713:                     .Header1.Caption = "Linhas"
714:                     .Text1.InputMask = "99"
715:                 ENDWITH
716:                 WITH .Column5
717:                     .Width           = 50
718:                     .ControlSource   = "crFichaTec.Maxs"
719:                     .Header1.Caption = "M" + CHR(225) + "ximo"
720:                 ENDWITH
721:                 WITH .Column6
722:                     .Width           = 50
723:                     .ControlSource   = "crFichaTec.Mins"
724:                     .Header1.Caption = "M" + CHR(237) + "nimo"
725:                 ENDWITH
726:                 WITH .Column7
727:                     .Width          = 243
728:                     .ControlSource  = "crFichaTec.nChkCxas"
729:                     .Header1.Caption = "Digita" + CHR(231) + CHR(227) + "o"
730:                     .Sparse         = .F.
731:                     .CurrentControl = "opt_4c_NChkCxas"
732:                     .AddObject("opt_4c_NChkCxas", "OptionGroup")
733:                     WITH .opt_4c_NChkCxas
734:                         .ButtonCount = 3
735:                         .Value       = 1
736:                         .Height      = 16
737:                         .Width       = 241
738:                         WITH .Buttons(1)
739:                             .Caption   = "Maiusculo"
740:                             .Width     = 74
741:                             .BackStyle = 0
742:                         ENDWITH
743:                         WITH .Buttons(2)
744:                             .Caption   = "Minusculo"
745:                             .Left      = 80
746:                             .Width     = 74
747:                             .BackStyle = 0
748:                         ENDWITH
749:                         WITH .Buttons(3)
750:                             .Caption   = "Livre"
751:                             .Left      = 160
752:                             .BackStyle = 0
753:                         ENDWITH
754:                     ENDWITH
755:                 ENDWITH
756:                 WITH .Column8
757:                     .Width           = 25
758:                     .ControlSource   = "crFichaTec.cSelecaos"
759:                     .Header1.Caption = "S"
760:                 ENDWITH
761:                 WITH .Column9
762:                     .Width           = 25
763:                     .ControlSource   = "crFichaTec.cTpDados"
764:                     .Header1.Caption = "T"
765:                 ENDWITH
766:             ENDWITH
767: 
768:             loc_oPg.AddObject("cmd_4c_ApagarLinha", "CommandButton")
769:             WITH loc_oPg.cmd_4c_ApagarLinha
770:                 .Top     = 235
771:                 .Left    = 949
772:                 .Width   = 40
773:                 .Height  = 40
774:                 .Caption = ""
775:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
776:                 .Themes  = .T.
777:                 .Visible = .F.
778:             ENDWITH
779: 
780:             loc_oPg.AddObject("cmd_4c_Respostas", "CommandButton")
781:             WITH loc_oPg.cmd_4c_Respostas
782:                 .Top     = 194
783:                 .Left    = 949
784:                 .Width   = 40
785:                 .Height  = 40
786:                 .Caption = ""
787:                 .Picture = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
788:                 .Themes  = .T.
789:                 .Visible = (THIS.this_nTipo = 0)
790:             ENDWITH
791: 
792:             loc_oPg.AddObject("cmd_4c_CopiaFicha", "CommandButton")
793:             WITH loc_oPg.cmd_4c_CopiaFicha
794:                 .Top     = 392
795:                 .Left    = 29
796:                 .Width   = 40
797:                 .Height  = 40
798:                 .Caption = ""
799:                 .Picture = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
800:                 .Themes  = .T.
801:                 .Visible = .F.
802:             ENDWITH
803: 
804:             loc_oPg.AddObject("cnt_4c_CopiarAcesso", "Container")
805:             WITH loc_oPg.cnt_4c_CopiarAcesso
806:                 .Top       = 389
807:                 .Left      = 8
808:                 .Width     = 409
809:                 .Height    = 58
810:                 .BackStyle = 0
811:                 .Visible   = .F.
812:                 .AddObject("lbl_4c_CpyGrupo", "Label")
813:                 WITH .lbl_4c_CpyGrupo
814:                     .Top      = 7
815:                     .Left     = 34
816:                     .Width    = 40
817:                     .Height   = 18
818:                     .AutoSize = .F.
819:                     .Caption  = "Grupo :"
820:                     .Visible  = .T.
821:                 ENDWITH
822:                 .AddObject("lbl_4c_CpySubgrupo", "Label")
823:                 WITH .lbl_4c_CpySubgrupo
824:                     .Top      = 32
825:                     .Left     = 17
826:                     .Width    = 60
827:                     .Height   = 18
828:                     .AutoSize = .F.
829:                     .Caption  = "Sub-grupo :"
830:                     .Visible  = (THIS.this_nTipo = 0)
831:                 ENDWITH
832:                 .AddObject("txt_4c_CpyCGrus", "TextBox")
833:                 WITH .txt_4c_CpyCGrus
834:                     .Top     = 5
835:                     .Left    = 76
836:                     .Width   = 80
837:                     .Height  = 20
838:                     .Visible = .T.
839:                 ENDWITH
840:                 .AddObject("txt_4c_CpyDGrus", "TextBox")
841:                 WITH .txt_4c_CpyDGrus
842:                     .Top     = 5
843:                     .Left    = 158
844:                     .Width   = 150
845:                     .Height  = 20
846:                     .Enabled = .F.
847:                     .Visible = .T.
848:                 ENDWITH
849:                 .AddObject("txt_4c_CpySGrus", "TextBox")
850:                 WITH .txt_4c_CpySGrus
851:                     .Top     = 30
852:                     .Left    = 76
853:                     .Width   = 80
854:                     .Height  = 20
855:                     .Visible = (THIS.this_nTipo = 0)
856:                 ENDWITH
857:                 .AddObject("txt_4c_CpyDSGru", "TextBox")
858:                 WITH .txt_4c_CpyDSGru
859:                     .Top     = 30
860:                     .Left    = 158
861:                     .Width   = 150
862:                     .Height  = 20
863:                     .Enabled = .F.
864:                     .Visible = (THIS.this_nTipo = 0)
865:                 ENDWITH
866:                 .AddObject("cmd_4c_ConfirmarCopia", "CommandButton")
867:                 WITH .cmd_4c_ConfirmarCopia
868:                     .Top     = 10
869:                     .Left    = 316
870:                     .Width   = 40
871:                     .Height  = 40
872:                     .Caption = ""
873:                     .Picture = gc_4c_CaminhoIcones + "geral_duplicar_26.jpg"
874:                     .Themes  = .T.
875:                     .Visible = .T.
876:                 ENDWITH
877:                 .AddObject("cmd_4c_CancelarCopia", "CommandButton")
878:                 WITH .cmd_4c_CancelarCopia
879:                     .Top     = 10
880:                     .Left    = 356
881:                     .Width   = 40
882:                     .Height  = 40
883:                     .Caption = ""
884:                     .Picture = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
885:                     .Themes  = .T.
886:                     .Visible = .T.
887:                 ENDWITH
888:             ENDWITH
889: 
890:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column1.Text1, "Valid",    THIS, "ValidCCarsGrid")
891:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column2.Text1, "Valid",    THIS, "ValidCTitsGrid")
892:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "KeyPress", THIS, "KeyPressCTpDados")
893:             BINDEVENT(loc_oPg.cmd_4c_ApagarLinha,  "Click", THIS, "BtnApagarLinhaClick")
894:             BINDEVENT(loc_oPg.cmd_4c_Respostas,    "Click", THIS, "BtnRespostasClick")
895:             BINDEVENT(loc_oPg.cmd_4c_CopiaFicha,   "Click", THIS, "BtnCopiaFichaClick")
896:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpyCGrus,      "KeyPress", THIS, "ValidCpyCGrus")
897:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_ConfirmarCopia, "Click", THIS, "BtnConfirmarCopiaClick")
898:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.cmd_4c_CancelarCopia,  "Click", THIS, "BtnCancelarCopiaClick")
899:             BINDEVENT(loc_oPg.cnt_4c_CopiarAcesso.txt_4c_CpySGrus,      "KeyPress", THIS, "ValidCpySGrus")
900:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column8.Text1, "Valid", THIS, "ValidCSelecaos")
901:             BINDEVENT(loc_oPg.grd_4c_Fichas.Column9.Text1, "Valid", THIS, "ValidCTpDados")
902: 
903:             THIS.TornarControlesVisiveis(loc_oPg)

*-- Linhas 916 a 1007:
916:         TRY
917:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
918: 
919:             loc_oPg.AddObject("lbl_4c_LabelImagem", "Label")
920:             WITH loc_oPg.lbl_4c_LabelImagem
921:                 .Top      = 63
922:                 .Left     = 328
923:                 .Width    = 200
924:                 .Height   = 18
925:                 .AutoSize = .F.
926:                 .Caption  = "Imagem da Impress" + CHR(227) + "o :"
927:                 .Visible  = (THIS.this_nTipo = 0)
928:             ENDWITH
929: 
930:             loc_oPg.AddObject("opt_4c_NChkImps", "OptionGroup")
931:             WITH loc_oPg.opt_4c_NChkImps
932:                 .Top           = 58
933:                 .Left          = 442
934:                 .Width         = 165
935:                 .Height        = 16
936:                 .ButtonCount   = 2
937:                 .Value         = 1
938:                 .ControlSource = "crFichaCab.nChkImps"
939:                 .Visible       = (THIS.this_nTipo = 0)
940:                 WITH .Buttons(1)
941:                     .Caption   = "Produtos"
942:                     .Width     = 70
943:                     .BackStyle = 0
944:                 ENDWITH
945:                 WITH .Buttons(2)
946:                     .Caption   = "Ficha T" + CHR(233) + "cnica"
947:                     .Left      = 75
948:                     .Width     = 90
949:                     .BackStyle = 0
950:                 ENDWITH
951:             ENDWITH
952: 
953:             loc_oPg.AddObject("chk_4c_NFixFigs", "CheckBox")
954:             WITH loc_oPg.chk_4c_NFixFigs
955:                 .Top           = 50
956:                 .Left          = 617
957:                 .Width         = 40
958:                 .Height        = 40
959:                 .Style         = 1
960:                 .Caption       = ""
961:                 .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
962:                 .ControlSource = "crFichaCab.nFixFigs"
963:                 .Themes        = .T.
964:                 .Visible       = (THIS.this_nTipo = 0)
965:             ENDWITH
966: 
967:             loc_oPg.AddObject("img_4c_FigTec", "Image")
968:             WITH loc_oPg.img_4c_FigTec
969:                 .Top     = 94
970:                 .Left    = 301
971:                 .Width   = 334
972:                 .Height  = 228
973:                 .Stretch = 1
974:                 .Visible = .F.
975:             ENDWITH
976: 
977:             loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")
978:             WITH loc_oPg.cmd_4c_Figura
979:                 .Top     = 326
980:                 .Left    = 592
981:                 .Width   = 40
982:                 .Height  = 40
983:                 .Caption = ""
984:                 .Picture = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
985:                 .Themes  = .T.
986:                 .Visible = .F.
987:             ENDWITH
988: 
989:             loc_oPg.AddObject("cmd_4c_VoltarFicha", "CommandButton")
990:             WITH loc_oPg.cmd_4c_VoltarFicha
991:                 .Top     = 326
992:                 .Left    = 634
993:                 .Width   = 40
994:                 .Height  = 40
995:                 .Caption = ""
996:                 .Picture = gc_4c_CaminhoIcones + "a_arrow1.bmp"
997:                 .Themes  = .T.
998:                 .Visible = .T.
999:             ENDWITH
1000: 
1001:             BINDEVENT(loc_oPg.cmd_4c_Figura,      "Click", THIS, "BtnFiguraClick")
1002:             BINDEVENT(loc_oPg.cmd_4c_VoltarFicha, "Click", THIS, "BtnVoltarFichaClick")
1003: 
1004:             THIS.TornarControlesVisiveis(loc_oPg)
1005:             loc_lResultado = .T.
1006:         CATCH TO loc_oErro
1007:             MsgErro("Erro em ConfigurarPgCompl:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1090 a 1103:
1090:             THIS.HabilitarCampos(!loc_lReadOnly)
1091:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page1
1092:             loc_oPg.grd_4c_Fichas.ReadOnly     = loc_lReadOnly
1093:             loc_oPg.cmd_4c_ApagarLinha.Visible  = (par_cModo = "ALTERAR")
1094:             loc_oPg.cmd_4c_CopiaFicha.Visible   = (par_cModo = "ALTERAR")
1095:             loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1096: 
1097:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1098:             loc_oPg2.cmd_4c_Figura.Visible = (par_cModo = "ALTERAR")
1099: 
1100:             IF USED("crFichaCab") AND !EOF("crFichaCab")
1101:                 IF !EMPTY(crFichaCab.mFicTecs)
1102:                     loc_cArqTemp = SYS(2023) + "\FigTec_" + SYS(3) + ".jpg"
1103:                     STRTOFILE(crFichaCab.mFicTecs, loc_cArqTemp)

*-- Linhas 1784 a 1793:
1784:             loc_cNome = UPPER(ALLTRIM(loc_oCtrl.Name))
1785:             *-- Paineis flutuantes: preservar Visible=.F. mas processar filhos internos
1786:             IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_COPIARACESSO", ;
1787:                     "CMD_4C_APAGARLINHA", "CMD_4C_COPIAFICHA", ;
1788:                     "IMG_4C_FIGTEC", "CMD_4C_FIGURA")
1789:                 IF PEMSTATUS(loc_oCtrl, "PageCount", 5)
1790:                     FOR loc_nP = 1 TO loc_oCtrl.PageCount
1791:                         THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
1792:                     ENDFOR
1793:                 ELSE

*-- Linhas 1812 a 1820:
1812: 
1813:     *--------------------------------------------------------------------------
1814:     * FormParaBO - Consolida dados dos controles bound ao BO/cursor
1815:     *   Os TextBox/OptionGroup/CheckBox estao com ControlSource direto para
1816:     *   crFichaCab/crFichaTec (padrao SCX legado). Este metodo garante que
1817:     *   o registro corrente esteja gravado no cursor antes de operacoes.
1818:     *--------------------------------------------------------------------------
1819:     PROTECTED PROCEDURE FormParaBO()
1820:         LOCAL loc_lResultado

*-- Linhas 1947 a 1977:
1947:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_SubPaginas.Page2
1948: 
1949:             *-- Botoes de manipulacao da grade so aparecem em ALTERAR
1950:             IF PEMSTATUS(loc_oPg, "cmd_4c_ApagarLinha", 5)
1951:                 loc_oPg.cmd_4c_ApagarLinha.Visible = loc_lAlterar
1952:             ENDIF
1953:             IF PEMSTATUS(loc_oPg, "cmd_4c_CopiaFicha", 5)
1954:                 loc_oPg.cmd_4c_CopiaFicha.Visible = loc_lAlterar
1955:             ENDIF
1956: 
1957:             *-- Botao de figura na pagina complementar
1958:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Figura", 5)
1959:                 loc_oPg2.cmd_4c_Figura.Visible = loc_lAlterar
1960:             ENDIF
1961: 
1962:             *-- Grade em modo leitura quando visualiza/exclui
1963:             IF PEMSTATUS(loc_oPg, "grd_4c_Fichas", 5)
1964:                 loc_oPg.grd_4c_Fichas.ReadOnly = loc_lLeitura OR !loc_lAlterar
1965:             ENDIF
1966: 
1967:             *-- Fecha painel de copia
1968:             IF PEMSTATUS(loc_oPg, "cnt_4c_CopiarAcesso", 5)
1969:                 loc_oPg.cnt_4c_CopiarAcesso.Visible = .F.
1970:             ENDIF
1971: 
1972:             *-- Habilita/desabilita campos de configuracao (OptionGroups + CheckBox)
1973:             THIS.HabilitarCampos(loc_lAlterar)
1974: 
1975:             loc_lResultado = .T.
1976:         CATCH TO loc_oErro
1977:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\FctBO.prg):
*==============================================================================
* FctBO.prg - Business Object para Cadastro de Ficha Tecnica / Perfis
* Tabela principal: SigCdFtc (linhas de ficha tecnica por CGrus+SGrus)
* Cabecalho do grupo: SigCdGrp (pnTipo=0), SigCdGcr (pnTipo=1), SigCdOpe (pnTipo=2)
*==============================================================================
DEFINE CLASS FctBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao do grupo selecionado (cabecalho da ficha tecnica)
    *--------------------------------------------------------------------------
    this_cCGrus    = ""   && Codigo do grupo (chave 1)
    this_cDGrus    = ""   && Descricao do grupo
    this_cSGrus    = ""   && Codigo do subgrupo (chave 2)
    this_cDSGru    = ""   && Descricao do subgrupo

    *--------------------------------------------------------------------------
    * Flags do cabecalho (vem de SigCdGrp quando pnTipo=0)
    * nChkDims: Dimensoes Obrigatorias (1=Sim, 2=Nao)
    * nChkPess: Peso Obrigatorio        (1=Sim, 2=Nao)
    * nChkTems: Tempo Instal Obrigatorio (1=Sim, 2=Nao)
    * nChkImps: Impressao (1=Produtos, 2=Ficha Tecnica)
    * nFixFigs: Figuras Fixas (0/1)
    *--------------------------------------------------------------------------
    this_nChkDims  = 1    && Dimensoes Obrigatorias
    this_nChkPess  = 1    && Peso Obrigatorio
    this_nChkTems  = 1    && Tempo de Instalacao Obrigatorio
    this_nChkImps  = 1    && Tipo de impressao
    this_nFixFigs  = 0    && Figuras fixas (checkbox)
    this_mFicTecs  = ""   && Imagem tecnica (memo/binario)

    *--------------------------------------------------------------------------
    * Tipo de formulario
    * 0 = Ficha Tecnica de Produtos (SigCdGrp/SigCdPsg)
    * 1 = Perfil de Contas           (SigCdGcr)
    * 2 = Configuracao de Movimentacao (SigCdOpe)
    *--------------------------------------------------------------------------
    this_nTipo     = 0    && Tipo (0=Produtos, 1=Contas, 2=Movimentacoes)

    *--------------------------------------------------------------------------
    * Controle de cursor principal do grid (SigCdFtc)
    *--------------------------------------------------------------------------
    this_cCursorDados = "crFichaTec"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = "SigCdFtc"
                THIS.this_cCampoChave = "cIdChaves"
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar FctBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao destruir FctBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CriarCursores - Cria os cursores de trabalho necessarios
    *==========================================================================
    PROCEDURE CriarCursores()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("crDados")
                USE IN crDados
            ENDIF
            IF USED("crFichaCab")
                USE IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                USE IN crFichaTec
            ENDIF
            IF USED("crSigCdFtc")
                USE IN crSigCdFtc
            ENDIF
            IF USED("crSigCdGrp")
                USE IN crSigCdGrp
            ENDIF

            SET NULL ON
            CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
            INDEX ON CGrus + SGrus TAG Col1
            INDEX ON SGrus + CGrus TAG Col2
            INDEX ON DGrus + CGrus TAG Col3
            INDEX ON DSGru + SGrus TAG Col4
            SET ORDER TO Col1 IN crDados

            CREATE CURSOR crFichaCab (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), ;
                nChkDims N(1), nChkPess N(1), nChkTems N(1), nChkImps N(1), ;
                nFixFigs N(1), mFicTecs M NULL)

            CREATE CURSOR crFichaTec (CGrus C(20), SGrus C(6), CCars C(20), CTits C(20), ;
                COrds N(3), CLins N(2), Maxs N(3), Mins N(3), ;
                nChkCxas N(1), cSelecaos C(1), cTpDados C(1))

            CREATE CURSOR crSigCdGrp (CGrus C(20), DGrus C(30), Mercs C(3), ;
                Margems N(9,6), Apagar C(1))
            SET NULL OFF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao criar cursores:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a lista de grupos/contas/movimentacoes na grade principal
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("crDados")
                    SET NULL ON
                    CREATE CURSOR crDados (CGrus C(20), DGrus C(30), SGrus C(6), DSGru C(20), TemDados C(20))
                    SET NULL OFF
                ENDIF
                loc_lResultado = .T.
            ENDIF

            IF USED("crDados")
                ZAP IN crDados
            ELSE
                THIS.CriarCursores()
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, FTecSubs" + ;
                    " FROM SigCdGrp" + ;
                    " ORDER BY CGrus, DGrus"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos, Descrs, 0 AS FTecSubs" + ;
                    " FROM SigCdGcr WHERE FichaTecs = 1" + ;
                    " ORDER BY Codigos, Descrs"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes, a.TitOpes, 0 AS FTecSubs" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON a.Dopes = b.Dopes" + ;
                    " WHERE b.OpeInatvs IN (0,2)" + ;
                    " ORDER BY a.Dopes, a.TitOpes"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGru")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crLocalGru
                SCAN
                    LOCAL loc_cGrupo, loc_cDescGrupo, loc_nFTecSubs
                    loc_cGrupo    = ALLTRIM(crLocalGru.CGrus)
                    loc_cDescGrupo = ""
                    loc_nFTecSubs  = 0

                    DO CASE
                    CASE THIS.this_nTipo = 0
                        loc_cDescGrupo = ALLTRIM(crLocalGru.DGrus)
                        loc_nFTecSubs  = NVL(crLocalGru.FTecSubs, 0)
                    CASE THIS.this_nTipo = 1
                        loc_cGrupo     = ALLTRIM(crLocalGru.Codigos)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.Descrs)
                    CASE THIS.this_nTipo = 2
                        loc_cGrupo     = ALLTRIM(crLocalGru.Dopes)
                        loc_cDescGrupo = ALLTRIM(crLocalGru.TitOpes)
                    ENDCASE

                    INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                        VALUES (loc_cGrupo, loc_cDescGrupo, "", "", "")

                    loc_nResult = SQLEXEC(gnConnHandle, ;
                        "SELECT DISTINCT CGrus FROM SigCdFtc" + ;
                        " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                        " AND SGrus = SPACE(6) AND nTipos = " + ;
                        FormatarNumeroSQL(THIS.this_nTipo), "crTmpFtc")
                    IF loc_nResult >= 1
                        GO TOP IN crTmpFtc
                        IF !EOF("crTmpFtc")
                            SELECT crDados
                            GO BOTTOM IN crDados
                            REPLACE TemDados WITH loc_cGrupo IN crDados
                        ENDIF
                        IF USED("crTmpFtc")
                            USE IN crTmpFtc
                        ENDIF
                    ENDIF

                    IF THIS.this_nTipo = 0 AND loc_nFTecSubs = 1
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT CGrus, Codigos, Descricaos FROM SigCdPsg" + ;
                            " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                            " ORDER BY CGrus, Codigos, Descricaos", "crLocalSGru")
                        IF loc_nResult >= 1
                            SELECT crLocalSGru
                            SCAN
                                INSERT INTO crDados (CGrus, DGrus, SGrus, DSGru, TemDados) ;
                                    VALUES (loc_cGrupo, loc_cDescGrupo, ;
                                        ALLTRIM(crLocalSGru.Codigos), ;
                                        ALLTRIM(crLocalSGru.Descricaos), "")

                                loc_nResult = SQLEXEC(gnConnHandle, ;
                                    "SELECT DISTINCT CGrus, SGrus FROM SigCdFtc" + ;
                                    " WHERE CGrus = " + EscaparSQL(loc_cGrupo) + ;
                                    " AND SGrus = " + EscaparSQL(ALLTRIM(crLocalSGru.Codigos)) + ;
                                    " AND nTipos = 0", "crTmpSGru")
                                IF loc_nResult >= 1
                                    GO TOP IN crTmpSGru
                                    IF !EOF("crTmpSGru")
                                        SELECT crDados
                                        GO BOTTOM IN crDados
                                        REPLACE TemDados WITH ;
                                            loc_cGrupo + ALLTRIM(crLocalSGru.Codigos) IN crDados
                                    ENDIF
                                    IF USED("crTmpSGru")
                                        USE IN crTmpSGru
                                    ENDIF
                                ENDIF
                            ENDSCAN
                            IF USED("crLocalSGru")
                                USE IN crLocalSGru
                            ENDIF
                        ENDIF
                    ENDIF

                    SELECT crLocalGru
                ENDSCAN

                IF USED("crLocalGru")
                    USE IN crLocalGru
                ENDIF

                GO TOP IN crDados
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFicha - Carrega crFichaCab e crFichaTec para um grupo/subgrupo
    * par_cCGrus  - Codigo do grupo
    * par_cSGrus  - Codigo do subgrupo (vazio para grupo raiz)
    * par_cDGrus  - Descricao do grupo
    * par_cDSGru  - Descricao do subgrupo
    * par_cModo   - "ALTERAR" / "VISUALIZAR" / "EXCLUIR"
    *==========================================================================
    FUNCTION CarregarFicha(par_cCGrus, par_cSGrus, par_cDGrus, par_cDSGru, par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nOrd
        loc_lResultado = .F.

        TRY
            IF USED("crFichaCab")
                ZAP IN crFichaCab
            ENDIF
            IF USED("crFichaTec")
                ZAP IN crFichaTec
            ENDIF

            THIS.this_cCGrus = ALLTRIM(par_cCGrus)
            THIS.this_cSGrus = ALLTRIM(par_cSGrus)
            THIS.this_cDGrus = ALLTRIM(par_cDGrus)
            THIS.this_cDSGru = ALLTRIM(par_cDSGru)

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT a.CGrus, a.nChkDims, a.nChkPess, a.nChkTems," + ;
                    " a.nChkImps, a.nFixFigs, a.mFicTecs" + ;
                    " FROM SigCdGrp a" + ;
                    " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT a.Codigos AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdGcr a" + ;
                    " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCGrus)

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT a.Dopes AS CGrus, 2 AS nChkDims, 2 AS nChkPess," + ;
                    " 2 AS nChkTems, 2 AS nChkImps, 2 AS nFixFigs, '' AS mFicTecs" + ;
                    " FROM SigCdOpe a" + ;
                    " WHERE a.Dopes = " + EscaparSQL(THIS.this_cCGrus)
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalGruFicha")
            IF loc_nResult < 1
                MsgErro("Erro ao acessar cadastro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN crLocalGruFicha
                IF EOF("crLocalGruFicha")
                    MsgAviso("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " n" + CHR(227) + "o foi encontrado!" + CHR(13) + ;
                        "O grupo pode ter sido exclu" + CHR(237) + "do. Reinicie a opera" + ;
                        CHR(231) + CHR(227) + "o.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    INSERT INTO crFichaCab (CGrus, DGrus, SGrus, DSGru, nChkDims, ;
                        nChkPess, nChkTems, nChkImps, nFixFigs, mFicTecs) ;
                        VALUES (THIS.this_cCGrus, THIS.this_cDGrus, THIS.this_cSGrus, ;
                        THIS.this_cDSGru, NVL(crLocalGruFicha.nChkDims, 1), ;
                        NVL(crLocalGruFicha.nChkPess, 1), ;
                        NVL(crLocalGruFicha.nChkTems, 1), ;
                        NVL(crLocalGruFicha.nChkImps, 1), ;
                        NVL(crLocalGruFicha.nFixFigs, 0), ;
                        NVL(crLocalGruFicha.mFicTecs, ""))

                    THIS.this_nChkDims = NVL(crLocalGruFicha.nChkDims, 1)
                    THIS.this_nChkPess = NVL(crLocalGruFicha.nChkPess, 1)
                    THIS.this_nChkTems = NVL(crLocalGruFicha.nChkTems, 1)
                    THIS.this_nChkImps = NVL(crLocalGruFicha.nChkImps, 1)
                    THIS.this_nFixFigs = NVL(crLocalGruFicha.nFixFigs, 0)
                    THIS.this_mFicTecs = NVL(crLocalGruFicha.mFicTecs, "")

                    loc_cSQL = "SELECT a.*" + ;
                        " FROM SigCdFtc a" + ;
                        " WHERE a.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                        " AND a.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                        " ORDER BY a.COrds"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crLocalCFTec")
                    IF loc_nResult < 1
                        MsgErro("Erro ao carregar ficha t" + CHR(233) + "cnica:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        loc_nOrd = 1
                        SELECT crLocalCFTec
                        SCAN
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus, CCars, CTits, ;
                                CLins, Maxs, Mins, nChkCxas, cSelecaos, cTpDados) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus, ;
                                NVL(crLocalCFTec.CCars, ""), NVL(crLocalCFTec.CTits, ""), ;
                                NVL(crLocalCFTec.CLins, 0), NVL(crLocalCFTec.Maxs, 0), ;
                                NVL(crLocalCFTec.Mins, 0), NVL(crLocalCFTec.nChkCxas, 0), ;
                                NVL(crLocalCFTec.cSelecaos, " "), ;
                                NVL(crLocalCFTec.cTpDados, " "))
                            loc_nOrd = loc_nOrd + 1
                        ENDSCAN

                        IF USED("crLocalCFTec")
                            USE IN crLocalCFTec
                        ENDIF

                        IF ALLTRIM(par_cModo) == "ALTERAR"
                            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                                VALUES (loc_nOrd, THIS.this_cCGrus, THIS.this_cSGrus)
                        ENDIF

                        GO TOP IN crFichaCab
                        GO TOP IN crFichaTec
                        GO BOTTOM IN crFichaTec

                        loc_lResultado = .T.
                    ENDIF
                ENDIF

                IF USED("crLocalGruFicha")
                    USE IN crLocalGruFicha
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarFiltroGrupos - Carrega crSigCdGrpFilter para lookup no container de copia
    *==========================================================================
    FUNCTION CarregarFiltroGrupos()
    *==========================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("crSigCdGrpFilter")
                USE IN crSigCdGrpFilter
            ENDIF

            DO CASE
            CASE THIS.this_nTipo = 0
                loc_cSQL = "SELECT CGrus, DGrus, Mercs, Margems, 'S' AS Apagar" + ;
                    " FROM SigCdGrp"

            CASE THIS.this_nTipo = 1
                loc_cSQL = "SELECT Codigos AS CGrus, Descrs AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdGcr"

            CASE THIS.this_nTipo = 2
                loc_cSQL = "SELECT Dopes AS CGrus, TitOpes AS DGrus," + ;
                    " '   ' AS Mercs, 0 AS Margems, 'S' AS Apagar FROM SigCdOpe"
            ENDCASE

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrpFilter")
            IF loc_nResult < 1
                MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                SELECT crSigCdGrpFilter
                IF RECCOUNT("crSigCdGrpFilter") > 0
                    INDEX ON CGrus TAG CGrus
                    INDEX ON DGrus TAG DGrus
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar filtro de grupos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AdicionarLinhaFicha - Adiciona linha em branco no final do crFichaTec
    *==========================================================================
    FUNCTION AdicionarLinhaFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nProxOrd
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec") OR !USED("crFichaCab")
                loc_lResultado = .F.
            ENDIF

            loc_nProxOrd = RECCOUNT("crFichaTec") + 1

            SELECT crFichaTec
            GO BOTTOM IN crFichaTec
            IF !EOF("crFichaTec")
                loc_nProxOrd = NVL(crFichaTec.COrds, 0) + 1
            ENDIF

            INSERT INTO crFichaTec (COrds, CGrus, SGrus) ;
                VALUES (loc_nProxOrd, THIS.this_cCGrus, THIS.this_cSGrus)

            GO BOTTOM IN crFichaTec
            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao adicionar linha:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarFichaTec - Valida o conteudo da grade antes de gravar
    *==========================================================================
    FUNCTION ValidarFichaTec()
    *==========================================================================
        LOCAL loc_lResultado, loc_cMensagem
        loc_lResultado = .F.

        TRY
            IF !USED("crFichaTec")
                MsgErro("Cursor de ficha t" + CHR(233) + "cnica n" + CHR(227) + ;
                    "o encontrado!", "Erro")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc")
                ZAP IN crSigCdFtc
            ELSE
                SET NULL ON
                CREATE CURSOR crSigCdFtc (COrds N(3), CGrus C(20), SGrus C(6), ;
                    CCars C(20), CTits C(20), CLins N(2), Maxs N(3), Mins N(3), ;
                    nChkCxas N(1), cSelecaos C(1), cIdChaves C(50), ;
                    nTipos N(1), cTpDados C(1))
                SET NULL OFF
            ENDIF

            SELECT crFichaTec
            SCAN
                IF !EMPTY(ALLTRIM(crFichaTec.CCars)) AND ;
                   !EMPTY(ALLTRIM(crFichaTec.CTits)) AND ;
                   crFichaTec.CLins >= 1
                    INSERT INTO crSigCdFtc (COrds, CGrus, SGrus, CCars, CTits, ;
                        CLins, Maxs, Mins, nChkCxas, cSelecaos, cIdChaves, ;
                        nTipos, cTpDados) ;
                        VALUES (crFichaTec.COrds, crFichaTec.CGrus, crFichaTec.SGrus, ;
                        crFichaTec.CCars, crFichaTec.CTits, crFichaTec.CLins, ;
                        crFichaTec.Maxs, crFichaTec.Mins, crFichaTec.nChkCxas, ;
                        NVL(crFichaTec.cSelecaos, " "), ;
                        LEFT(SYS(2015) + SYS(2015) + PADL(TRANSFORM(crFichaTec.COrds),5,"0"), 50), ;
                        THIS.this_nTipo, ;
                        NVL(crFichaTec.cTpDados, " "))
                ENDIF
            ENDSCAN

            IF RECCOUNT("crSigCdFtc") < 1
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + ;
                    " nenhum registro v" + CHR(225) + "lido na grade de ficha t" + ;
                    CHR(233) + "cnica!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            SELECT CCars, CTits, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY CCars, CTits ;
                INTO CURSOR csItensCheck

            SELECT csItensCheck
            SCAN
                IF csItensCheck.Totas > 1
                    MsgAviso("O Grupo e o T" + CHR(237) + "tulo " + CHR(34) + ;
                        ALLTRIM(csItensCheck.CCars) + " / " + ;
                        ALLTRIM(csItensCheck.CTits) + CHR(34) + ;
                        " est" + CHR(225) + " duplicado!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csItensCheck")
                        USE IN csItensCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csItensCheck")
                USE IN csItensCheck
            ENDIF

            SELECT COrds, SUM(1) AS Totas ;
                FROM crSigCdFtc ;
                GROUP BY COrds ;
                INTO CURSOR csOrdsCheck

            SELECT csOrdsCheck
            SCAN
                IF csOrdsCheck.Totas > 1
                    MsgAviso("A ordem de apresenta" + CHR(231) + CHR(227) + "o " + ;
                        CHR(34) + ALLTRIM(STR(csOrdsCheck.COrds)) + CHR(34) + ;
                        " est" + CHR(225) + " duplicada!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                    IF USED("csOrdsCheck")
                        USE IN csOrdsCheck
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
            ENDSCAN
            IF USED("csOrdsCheck")
                USE IN csOrdsCheck
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao validar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * VerificarExcluirFicha - Verifica se e possivel excluir a ficha tecnica
    *==========================================================================
    FUNCTION VerificarExcluirFicha()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .T.

        TRY
            IF !USED("crSigCdFtc") OR RECCOUNT("crSigCdFtc") < 1
                loc_lResultado = .T.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus), "crVerFtc")

            IF loc_nResult >= 1
                SELECT crVerFtc
                SCAN
                    LOCAL loc_cCCars, loc_cCTits, loc_cMsgProd
                    loc_cCCars = ALLTRIM(crVerFtc.CCars)
                    loc_cCTits = ALLTRIM(crVerFtc.CTits)

                    IF !EMPTY(loc_cCCars) AND !EMPTY(loc_cCTits)
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "SELECT DISTINCT a.CPros FROM SigCdPft a, SigCdPro b" + ;
                            " WHERE a.CCars = " + EscaparSQL(loc_cCCars) + ;
                            " AND a.CTits = " + EscaparSQL(loc_cCTits) + ;
                            " AND a.CPros = b.CPros" + ;
                            " AND b.CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                            " AND b.SGrus = " + EscaparSQL(THIS.this_cSGrus) + ;
                            " ORDER BY a.CPros", "crVerProd")
                        IF loc_nResult >= 1 AND RECCOUNT("crVerProd") > 0
                            GO TOP IN crVerProd
                            IF RECCOUNT("crVerProd") = 1
                                loc_cMsgProd = "O produto " + CHR(34) + ;
                                    ALLTRIM(crVerProd.CPros) + CHR(34) + " est" + CHR(225) + " "
                            ELSE
                                loc_cMsgProd = "Existem produtos que est" + CHR(227) + "o "
                            ENDIF
                            loc_cMsgProd = loc_cMsgProd + "utilizando o" + CHR(13) + ;
                                "Grupo de Caracter" + CHR(237) + "sticas: " + loc_cCCars + ;
                                " e o T" + CHR(237) + "tulo: " + loc_cCTits + "."
                            MsgErro(loc_cMsgProd, "Imposs" + CHR(237) + "vel Excluir")
                            IF USED("crVerProd")
                                USE IN crVerProd
                            ENDIF
                            loc_lResultado = .F.
                        ENDIF
                        IF USED("crVerProd")
                            USE IN crVerProd
                        ENDIF

                        IF loc_lResultado
                            loc_nResult = SQLEXEC(gnConnHandle, ;
                                "SELECT DISTINCT GruCarTits FROM SigCdFtr" + ;
                                " WHERE GruCarTits = " + ;
                                EscaparSQL(THIS.this_cCGrus + THIS.this_cSGrus + loc_cCCars + loc_cCTits), ;
                                "crVerResp")
                            IF loc_nResult >= 1 AND RECCOUNT("crVerResp") > 0
                                MsgErro("A Caracter" + CHR(237) + "stica " + CHR(34) + ;
                                    loc_cCCars + CHR(34) + " com o T" + CHR(237) + ;
                                    "tulo " + CHR(34) + loc_cCTits + CHR(34) + CHR(13) + ;
                                    "possui respostas cadastradas! Exclua as respostas primeiro!", ;
                                    "Imposs" + CHR(237) + "vel Excluir")
                                IF USED("crVerResp")
                                    USE IN crVerResp
                                ENDIF
                                loc_lResultado = .F.
                            ENDIF
                            IF USED("crVerResp")
                                USE IN crVerResp
                            ENDIF
                        ENDIF
                    ENDIF

                    IF !loc_lResultado
                        GO BOTTOM IN crVerFtc
                    ENDIF
                ENDSCAN
                IF USED("crVerFtc")
                    USE IN crVerFtc
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarGrupoFicha - Atualiza flags do grupo e salva ficha tecnica
    * par_cModo - "ALTERAR" ou "EXCLUIR"
    *==========================================================================
    FUNCTION AtualizarGrupoFicha(par_cModo)
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        IF !INLIST(ALLTRIM(par_cModo), "ALTERAR", "EXCLUIR")
            MsgErro("Modo inv" + CHR(225) + "lido: " + ALLTRIM(par_cModo), "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF ALLTRIM(par_cModo) == "ALTERAR"
                loc_lResultado = THIS.Atualizar()
            ELSE
                loc_lResultado = THIS.ExecutarExclusao()
            ENDIF

            IF loc_lResultado
                IF USED("crDados")
                    SELECT crDados
                    IF ALLTRIM(par_cModo) == "ALTERAR"
                        REPLACE TemDados WITH THIS.this_cCGrus + THIS.this_cSGrus IN crDados
                    ELSE
                        REPLACE TemDados WITH "" IN crDados
                    ENDIF
                ENDIF
                THIS.RegistrarAuditoria(par_cModo)
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao atualizar ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN ALLTRIM(THIS.this_cCGrus) + "/" + ALLTRIM(THIS.this_cSGrus)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCGrus   = ALLTRIM(TratarNulo(CGrus, "C"))
                THIS.this_cDGrus   = ALLTRIM(TratarNulo(DGrus, "C"))
                THIS.this_cSGrus   = ALLTRIM(TratarNulo(SGrus, "C"))
                THIS.this_cDSGru   = ALLTRIM(TratarNulo(DSGru, "C"))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Atualizar - Salva a ficha tecnica no banco:
    *   1. DELETE registros antigos de SigCdFtc
    *   2. Se pnTipo=0: UPDATE flags em SigCdGrp
    *   3. INSERT novos registros de crSigCdFtc em SigCdFtc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult, loc_cSQL
        loc_lResultado = .F.

        TRY
            IF THIS.this_nTipo = 0
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdGrp WHERE CGrus = " + ;
                    EscaparSQL(THIS.this_cCGrus), "crLocalGruUpd")
                IF loc_nResult < 1 OR EOF("crLocalGruUpd")
                    MsgErro("O grupo " + CHR(34) + THIS.this_cCGrus + CHR(34) + ;
                        " foi exclu" + CHR(237) + "do durante o processo. Reinicie!", "Erro")
                    IF USED("crLocalGruUpd")
                        USE IN crLocalGruUpd
                    ENDIF
                    loc_lResultado = .F.
                ENDIF
                IF USED("crLocalGruUpd")
                    USE IN crLocalGruUpd
                ENDIF

                IF !USED("crFichaCab")
                    MsgErro("Cursor de cabe" + CHR(231) + "alho n" + CHR(227) + "o encontrado!", "Erro")
                    loc_lResultado = .F.
                ENDIF

                GO TOP IN crFichaCab
                loc_cSQL = "UPDATE SigCdGrp SET" + ;
                    " nChkDims = " + FormatarNumeroSQL(crFichaCab.nChkDims) + "," + ;
                    " nChkPess = " + FormatarNumeroSQL(crFichaCab.nChkPess) + "," + ;
                    " nChkTems = " + FormatarNumeroSQL(crFichaCab.nChkTems) + "," + ;
                    " nChkImps = " + FormatarNumeroSQL(crFichaCab.nChkImps) + "," + ;
                    " nFixFigs = " + FormatarNumeroSQL(crFichaCab.nFixFigs) + "," + ;
                    " mFicTecs = " + IIF(EMPTY(crFichaCab.mFicTecs), "NULL", ;
                        EscaparSQL(crFichaCab.mFicTecs)) + ;
                    " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 1
                    MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha anterior:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF

            IF USED("crSigCdFtc") AND RECCOUNT("crSigCdFtc") > 0
                SELECT crSigCdFtc
                SCAN
                    loc_cSQL = "INSERT INTO SigCdFtc" + ;
                        " (COrds, CGrus, SGrus, CCars, CTits, CLins, Maxs, Mins," + ;
                        " nChkCxas, cSelecaos, cIdChaves, nTipos, cTpDados) VALUES (" + ;
                        FormatarNumeroSQL(crSigCdFtc.COrds) + ", " + ;
                        EscaparSQL(crSigCdFtc.CGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.SGrus) + ", " + ;
                        EscaparSQL(crSigCdFtc.CCars) + ", " + ;
                        EscaparSQL(crSigCdFtc.CTits) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.CLins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Maxs) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.Mins) + ", " + ;
                        FormatarNumeroSQL(crSigCdFtc.nChkCxas) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cSelecaos, " ")) + ", " + ;
                        "CONVERT(VARCHAR(50), NEWID()), " + ;
                        FormatarNumeroSQL(crSigCdFtc.nTipos) + ", " + ;
                        EscaparSQL(NVL(crSigCdFtc.cTpDados, " ")) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 1
                        MsgErro("Erro ao inserir linha da ficha:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                        loc_lResultado = .F.
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lResultado = .T.

        CATCH TO loException
            MsgErro("Erro ao salvar ficha t" + CHR(233) + "cnica:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *==========================================================================
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdFtc" + ;
                " WHERE CGrus = " + EscaparSQL(THIS.this_cCGrus) + ;
                " AND SGrus = " + EscaparSQL(THIS.this_cSGrus))
            IF loc_nResult < 1
                MsgErro("Erro ao excluir ficha t" + CHR(233) + "cnica:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao excluir ficha:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

