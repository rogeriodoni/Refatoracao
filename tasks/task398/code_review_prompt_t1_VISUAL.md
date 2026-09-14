# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 418: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 443: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDrs.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2061 linhas total):

*-- Linhas 5 a 13:
5: * Recebe par_cTits (C20) para identificar o tipo de ficha tecnica.
6: * Modelo: chave-valor em SigSyCrs (Tits+Cods = PK logica; Campos=campo; Resps=valor).
7: * Campos dinamicos definidos em SigSyCit; campos fixos: Emps, Dopes, Numes, Aprova, Datas, Baixa.
8: * Workflow: Aprovar/Desaprovar (cmd_4c_Aprovar) e Baixar/Canc Baixa (cmd_4c_Baixar).
9: *==============================================================================
10: 
11: DEFINE CLASS FormDrs AS FormBase
12: 
13:     *-- Propriedades visuais

*-- Linhas 67 a 77:
67:                     THIS.this_oBusinessObject.InicializarCursores()
68: 
69:                     THIS.ConfigurarPageFrame()
70:                     THIS.Caption = "Ficha T" + CHR(233) + "cnica - " + ALLTRIM(THIS.this_cTits)
71:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73:                     THIS.pgf_4c_Paginas.Visible    = .T.
74:                     THIS.pgf_4c_Paginas.ActivePage = 1
75:                     THIS.this_cModoAtual           = "LISTA"
76: 
77:                     IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 100 a 119:
100: 
101:         WITH THIS.pgf_4c_Paginas
102:             .PageCount = 2
103:             .Top       = -29
104:             .Left      = 0
105:             .Width     = THIS.Width
106:             .Height    = THIS.Height + 29
107:             .Tabs      = .F.
108:             .Visible   = .T.
109: 
110:             .Page1.Caption   = "Lista"
111:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page1.BackColor = RGB(255, 255, 255)
113: 
114:             .Page2.Caption   = "Dados"
115:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page2.BackColor = RGB(255, 255, 255)
117:         ENDWITH
118: 
119:         THIS.ConfigurarPaginaLista()

*-- Linhas 132 a 169:
132:         *-- Cabecalho cinza
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 31
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = 750
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = THIS.Caption
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = 750
166:             .Height    = 46
167:             .FontName  = "Tahoma"
168:             .FontSize  = 16
169:             .FontBold  = .T.

*-- Linhas 177 a 200:
177:         *-- Original grupo_op: Left=342, Top=-1. Compensado: Top=29
178:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
179:         WITH loc_oPagina.cnt_4c_Botoes
180:             .Top         = 29
181:             .Left        =  542
182:             .Width       = 390
183:             .Height      = 85
184:             .BackStyle   = 0
185:             .BorderWidth = 0
186:             .Visible     = .T.
187:         ENDWITH
188: 
189:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
190:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
191:             .Caption         = "Incluir"
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
193:             .PicturePosition = 13
194:             .Top             = 5
195:             .Left            = 5
196:             .Width           = 75
197:             .Height          = 75
198:             .FontName        = "Tahoma"
199:             .FontBold        = .T.
200:             .FontItalic      = .T.

*-- Linhas 208 a 224:
208:             .AutoSize        = .F.
209:             .Visible         = .T.
210:         ENDWITH
211:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
212: 
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .FontName        = "Tahoma"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.

*-- Linhas 232 a 248:
232:             .AutoSize        = .F.
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
239:             .Caption         = "Alterar"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 155
244:             .Width           = 75
245:             .Height          = 75
246:             .FontName        = "Tahoma"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.

*-- Linhas 256 a 272:
256:             .AutoSize        = .F.
257:             .Visible         = .T.
258:         ENDWITH
259:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
260: 
261:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
262:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
263:             .Caption         = "Excluir"
264:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
265:             .PicturePosition = 13
266:             .Top             = 5
267:             .Left            = 230
268:             .Width           = 75
269:             .Height          = 75
270:             .FontName        = "Tahoma"
271:             .FontBold        = .T.
272:             .FontItalic      = .T.

*-- Linhas 280 a 296:
280:             .AutoSize        = .F.
281:             .Visible         = .T.
282:         ENDWITH
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
284: 
285:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
287:             .Caption         = "Buscar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
289:             .PicturePosition = 13
290:             .Top             = 5
291:             .Left            = 305
292:             .Width           = 75
293:             .Height          = 75
294:             .FontName        = "Tahoma"
295:             .FontBold        = .T.
296:             .FontItalic      = .T.

*-- Linhas 304 a 332:
304:             .AutoSize        = .F.
305:             .Visible         = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
308: 
309:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
310:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
311:         WITH loc_oPagina.cnt_4c_Saida
312:             .Top         = 29
313:             .Left        = 917
314:             .Width       = 90
315:             .Height      = 85
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
322:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
323:             .Caption         = "Encerrar"
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .PicturePosition = 13
326:             .Top             = 5
327:             .Left            = 5
328:             .Width           = 75
329:             .Height          = 75
330:             .FontName        = "Tahoma"
331:             .FontBold        = .T.
332:             .FontItalic      = .T.

*-- Linhas 340 a 391:
340:             .AutoSize        = .F.
341:             .Visible         = .T.
342:         ENDWITH
343:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
344: 
345:         *-- optFiltro: 3 opcoes (Todas / em aberto / baixadas)
346:         *-- Original: Left=35, Top=87. Compensado: Top=116 (87+29)
347:         loc_oPagina.AddObject("opt_4c_Filtro", "OptionGroup")
348:         WITH loc_oPagina.opt_4c_Filtro
349:             .ButtonCount  = 3
350:             .AutoSize     = .F.
351:             .Height       = 58
352:             .Left         = 35
353:             .Top          = 116
354:             .Width        = 82
355:             .BackStyle    = 0
356:             .BorderStyle  = 0
357:             .Value        = 1
358:             .Visible      = .T.
359: 
360:             WITH .Buttons(1)
361:                 .Caption   = "Todas"
362:                 .Height    = 17
363:                 .Left      = 3
364:                 .Top       = 3
365:                 .Width     = 74
366:                 .ForeColor = RGB(90, 90, 90)
367:                 .AutoSize  = .F.
368:             ENDWITH
369: 
370:             WITH .Buttons(2)
371:                 .Caption   = "Pendentes"
372:                 .Height    = 17
373:                 .Left      = 3
374:                 .Top       = 21
375:                 .Width     = 74
376:                 .FontName  = "Tahoma"
377:                 .FontSize  = 8
378:                 .ForeColor = RGB(90, 90, 90)
379:                 .AutoSize  = .F.
380:             ENDWITH
381: 
382:             WITH .Buttons(3)
383:                 .Caption   = "Baixadas"
384:                 .Height    = 17
385:                 .Left      = 3
386:                 .Top       = 39
387:                 .Width     = 74
388:                 .FontName  = "Tahoma"
389:                 .FontSize  = 8
390:                 .ForeColor = RGB(90, 90, 90)
391:                 .AutoSize  = .F.

*-- Linhas 397 a 470:
397:         *-- Original Commandgroup1: Left=115, Top=91. Compensado: Top=120 (91+29)
398:         loc_oPagina.AddObject("cnt_4c_Workflow", "Container")
399:         WITH loc_oPagina.cnt_4c_Workflow
400:             .Top         = 120
401:             .Left        = 122
402:             .Width       = 250
403:             .Height      = 55
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Aprovar", "CommandButton")
410:         WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
411:             .Caption         = "Aprovar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_32.jpg"
413:             .PicturePosition = 1
414:             .Top             = 5
415:             .Left            = 4
416:             .Width           = 115
417:             .Height          = 45
418:             .FontName        = "Comic Sans MS"
419:             .FontBold        = .T.
420:             .FontItalic      = .T.
421:             .FontSize        = 8
422:             .ForeColor       = RGB(90, 90, 90)
423:             .BackColor       = RGB(255, 255, 255)
424:             .Themes          = .T.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Enabled         = .F.
430:             .Visible         = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar, "Click", THIS, "BtnAprovarClick")
433: 
434:         loc_oPagina.cnt_4c_Workflow.AddObject("cmd_4c_Baixar", "CommandButton")
435:         WITH loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
436:             .Caption         = "Baixar"
437:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
438:             .PicturePosition = 1
439:             .Top             = 5
440:             .Left            = 127
441:             .Width           = 115
442:             .Height          = 45
443:             .FontName        = "Comic Sans MS"
444:             .FontBold        = .T.
445:             .FontItalic      = .T.
446:             .FontSize        = 8
447:             .ForeColor       = RGB(90, 90, 90)
448:             .BackColor       = RGB(255, 255, 255)
449:             .Themes          = .T.
450:             .SpecialEffect   = 0
451:             .MousePointer    = 15
452:             .WordWrap        = .T.
453:             .AutoSize        = .F.
454:             .Enabled         = .F.
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar, "Click", THIS, "BtnBaixarClick")
458: 
459:         *-- Grid de listagem (colunas montadas em MontarColunasGrid apos Buscar)
460:         *-- Original grade: Left=29, Top=142. Compensado Top: 175 (142+29+4)
461:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
462:         loc_oPagina.grd_4c_Lista.ColumnCount = 0
463:         WITH loc_oPagina.grd_4c_Lista
464:             .Top                = 180
465:             .Left               = 29
466:             .Width              = 880
467:             .Height             = 425
468:             .FontName           = "Verdana"
469:             .FontSize           = 8
470:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 499 a 523:
499:         *-- Original grupo_salva: Top=9. Compensado: Top=38 (9+29)
500:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
501:         WITH loc_oPagina.cnt_4c_BotoesAcao
502:             .Top         = 38
503:             .Left        = 840
504:             .Width       = 160
505:             .Height      = 85
506:             .BackStyle = 0
507:             .BackColor   = RGB(255, 255, 255)
508:             .BorderWidth = 0
509:             .Visible     = .T.
510:         ENDWITH
511: 
512:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
513:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
514:             .Caption         = "Confirmar"
515:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
516:             .PicturePosition = 13
517:             .Top             = 5
518:             .Left            = 5
519:             .Width           = 75
520:             .Height          = 75
521:             .FontName        = "Tahoma"
522:             .FontBold        = .T.
523:             .FontItalic      = .T.

*-- Linhas 531 a 547:
531:             .AutoSize        = .F.
532:             .Visible         = .T.
533:         ENDWITH
534:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
535: 
536:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
537:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
538:             .Caption         = "Encerrar"
539:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
540:             .PicturePosition = 13
541:             .Top             = 5
542:             .Left            = 83
543:             .Width           = 75
544:             .Height          = 75
545:             .FontName        = "Tahoma"
546:             .FontBold        = .T.
547:             .FontItalic      = .T.

*-- Linhas 555 a 572:
555:             .AutoSize        = .F.
556:             .Visible         = .T.
557:         ENDWITH
558:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
559: 
560:         *-- Label e TextBox de Codigo
561:         *-- Original Label1: Left=102, Top=137; getCods: Left=152, Top=134
562:         *-- Compensados: Top Label=166 (137+29), Top getCods=163 (134+29)
563:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
564:         WITH loc_oPagina.lbl_4c_Codigo
565:             .Caption   = "C" + CHR(243) + "digo :"
566:             .Top       = 166
567:             .Left      = 102
568:             .Height    = 16
569:             .FontName  = "Tahoma"
570:             .FontBold  = .T.
571:             .BackStyle = 0
572:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 578 a 601:
578:         WITH loc_oPagina.txt_4c_Cods
579:             .Value             = 0
580:             .Enabled           = .F.
581:             .Left              = 155
582:             .Top               = 163
583:             .Width             = 52
584:             .Height            = 20
585:             .DisabledBackColor = RGB(255, 255, 255)
586:             .FontName          = "Tahoma"
587:             .FontSize          = 8
588:             .Visible           = .T.
589:         ENDWITH
590: 
591:         *-- Container para campos dinamicos de SigSyCit + campos fixos de header
592:         *-- Original Shape1: Top=167, Height=309, Left=65, Width=670 -> compensado Top=196
593:         loc_oPagina.AddObject("cnt_4c_Campos", "Container")
594:         WITH loc_oPagina.cnt_4c_Campos
595:             .Top         = 196
596:             .Left        = 65
597:             .Width       = THIS.Width
598:             .Height      = 420
599:             .BackStyle   = 1
600:             .BackColor   = RGB(255, 255, 255)
601:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 674 a 682:
674:                 .ControlSource       = "crSigSyCrs.Cods"
675:                 .Width               = 60
676:                 .ReadOnly            = .T.
677:                 .Header1.Caption     = "C" + CHR(243) + "digo"
678:                 .Header1.FontName    = "Tahoma"
679:                 .Header1.FontBold    = .T.
680:                 .Header1.FontSize    = 8
681:             ENDWITH
682: 

*-- Linhas 703 a 711:
703:                             .ControlSource       = "crSigSyCrs." + loc_cCampo
704:                             .Width               = loc_nWidth
705:                             .ReadOnly            = .T.
706:                             .Header1.Caption     = loc_cHeader
707:                             .Header1.FontName    = "Tahoma"
708:                             .Header1.FontBold    = .T.
709:                             .Header1.FontSize    = 8
710:                         ENDWITH
711: 

*-- Linhas 748 a 761:
748:                     loc_cInputMask = ALLTRIM(crSigSyCit.Pictures)
749: 
750:                     *-- Label
751:                     loc_cLblName = "lbl_4c_F" + ALLTRIM(STR(loc_nOrdems, 3))
752:                     loc_oCnt.AddObject(loc_cLblName, "Label")
753:                     WITH loc_oCnt.&loc_cLblName.
754:                         .Caption   = PROPER(loc_cDescs)
755:                         .Top       = loc_nTop
756:                         .Left      = loc_nLef + 4
757:                         .FontName  = "Tahoma"
758:                         .FontBold  = .T.
759:                         .FontSize  = 8
760:                         .ForeColor = RGB(0, 0, 128)
761:                         .BackStyle = 0

*-- Linhas 776 a 785:
776:                             loc_nWidCtrl = IIF(EMPTY(loc_cInputMask), loc_nWid, MIN(loc_nWid, LEN(loc_cInputMask) * 8))
777:                             WITH loc_oCnt.&loc_cObjName.
778:                                 .Value             = ""
779:                                 .Top               = loc_nTop
780:                                 .Left              = loc_nLef
781:                                 .Width             = loc_nWidCtrl
782:                                 .Height            = loc_nHei
783:                                 .ReadOnly          = loc_lReadOnly
784:                                 .DisabledBackColor = RGB(255, 255, 255)
785:                                 .DisabledForeColor = RGB(0, 0, 128)

*-- Linhas 793 a 802:
793:                             WITH loc_oCnt.&loc_cObjName.
794:                                 .Value             = CTOD("")
795:                                 .InputMask         = "99/99/9999"
796:                                 .Top               = loc_nTop
797:                                 .Left              = loc_nLef
798:                                 .Width             = 80
799:                                 .Height            = loc_nHei
800:                                 .ReadOnly          = loc_lReadOnly
801:                                 .DisabledBackColor = RGB(255, 255, 255)
802:                                 .DisabledForeColor = RGB(0, 0, 128)

*-- Linhas 811 a 820:
811:                             WITH loc_oCnt.&loc_cObjName.
812:                                 .Value             = 0
813:                                 .InputMask         = IIF(EMPTY(loc_cInputMask), "999999999.99", loc_cInputMask)
814:                                 .Top               = loc_nTop
815:                                 .Left              = loc_nLef
816:                                 .Width             = loc_nWidCtrl
817:                                 .Height            = loc_nHei
818:                                 .ReadOnly          = loc_lReadOnly
819:                                 .DisabledBackColor = RGB(255, 255, 255)
820:                                 .DisabledForeColor = RGB(0, 0, 128)

*-- Linhas 829 a 838:
829:                             WITH loc_oCnt.&loc_cObjName.
830:                                 .Value             = ""
831:                                 .MaxLength         = IIF(EMPTY(loc_cInputMask), 200, LEN(loc_cInputMask))
832:                                 .Top               = loc_nTop
833:                                 .Left              = loc_nLef
834:                                 .Width             = loc_nWidCtrl
835:                                 .Height            = loc_nHei
836:                                 .ReadOnly          = loc_lReadOnly
837:                                 .DisabledBackColor = RGB(255, 255, 255)
838:                                 .DisabledForeColor = RGB(0, 0, 128)

*-- Linhas 855 a 933:
855:                 *-- Separador antes dos campos fixos de header
856:                 loc_oCnt.AddObject("shp_4c_Sep1", "Shape")
857:                 WITH loc_oCnt.shp_4c_Sep1
858:                     .Top           = loc_nTop
859:                     .Left          = 1
860:                     .Width         = loc_nWid + 9
861:                     .Height        = 2
862:                     .SpecialEffect = 0
863:                     .Visible       = .T.
864:                 ENDWITH
865:                 loc_nTop = loc_nTop + 6
866: 
867:                 *-- Labels dos campos fixos (mesma linha)
868:                 loc_oCnt.AddObject("lbl_4c_FEmps", "Label")
869:                 WITH loc_oCnt.lbl_4c_FEmps
870:                     .Caption   = "Empresa"
871:                     .Top       = loc_nTop
872:                     .Left      = loc_nLef + 4
873:                     .FontName  = "Tahoma"
874:                     .FontBold  = .T.
875:                     .FontSize  = 8
876:                     .ForeColor = RGB(0, 0, 128)
877:                     .BackStyle = 0
878:                     .AutoSize  = .T.
879:                     .Visible   = .T.
880:                 ENDWITH
881: 
882:                 loc_oCnt.AddObject("lbl_4c_FDopes", "Label")
883:                 WITH loc_oCnt.lbl_4c_FDopes
884:                     .Caption   = "Opera" + CHR(231) + CHR(227) + "o"
885:                     .Top       = loc_nTop
886:                     .Left      = loc_nLef + 41
887:                     .FontName  = "Tahoma"
888:                     .FontBold  = .T.
889:                     .FontSize  = 8
890:                     .ForeColor = RGB(0, 0, 128)
891:                     .BackStyle = 0
892:                     .AutoSize  = .T.
893:                     .Visible   = .T.
894:                 ENDWITH
895: 
896:                 loc_oCnt.AddObject("lbl_4c_FNumes", "Label")
897:                 WITH loc_oCnt.lbl_4c_FNumes
898:                     .Caption   = "N" + CHR(250) + "mero"
899:                     .Top       = loc_nTop
900:                     .Left      = loc_nLef + 196
901:                     .FontName  = "Tahoma"
902:                     .FontBold  = .T.
903:                     .FontSize  = 8
904:                     .ForeColor = RGB(0, 0, 128)
905:                     .BackStyle = 0
906:                     .AutoSize  = .T.
907:                     .Visible   = .T.
908:                 ENDWITH
909: 
910:                 loc_oCnt.AddObject("lbl_4c_FAprova", "Label")
911:                 WITH loc_oCnt.lbl_4c_FAprova
912:                     .Caption   = "Aprovador"
913:                     .Top       = loc_nTop
914:                     .Left      = loc_nLef + 252
915:                     .FontName  = "Tahoma"
916:                     .FontBold  = .T.
917:                     .FontSize  = 8
918:                     .ForeColor = RGB(0, 0, 128)
919:                     .BackStyle = 0
920:                     .AutoSize  = .T.
921:                     .Visible   = .T.
922:                 ENDWITH
923: 
924:                 loc_oCnt.AddObject("lbl_4c_FDatas", "Label")
925:                 WITH loc_oCnt.lbl_4c_FDatas
926:                     .Caption   = "Data Aprov."
927:                     .Top       = loc_nTop
928:                     .Left      = loc_nLef + 335
929:                     .FontName  = "Tahoma"
930:                     .FontBold  = .T.
931:                     .FontSize  = 8
932:                     .ForeColor = RGB(0, 0, 128)
933:                     .BackStyle = 0

*-- Linhas 942 a 951:
942:                 WITH loc_oCnt.txt_4c_FEmps
943:                     .Value             = ""
944:                     .MaxLength         = 3
945:                     .Top               = loc_nTop
946:                     .Left              = loc_nLef
947:                     .Width             = 35
948:                     .Height            = 23
949:                     .ReadOnly          = loc_lReadOnly
950:                     .DisabledBackColor = RGB(255, 255, 255)
951:                     .FontName          = "Tahoma"

*-- Linhas 957 a 966:
957:                 WITH loc_oCnt.txt_4c_FDopes
958:                     .Value             = ""
959:                     .MaxLength         = 20
960:                     .Top               = loc_nTop
961:                     .Left              = loc_nLef + 37
962:                     .Width             = 155
963:                     .Height            = 23
964:                     .ReadOnly          = loc_lReadOnly
965:                     .DisabledBackColor = RGB(255, 255, 255)
966:                     .FontName          = "Tahoma"

*-- Linhas 972 a 981:
972:                 WITH loc_oCnt.txt_4c_FNumes
973:                     .Value             = ""
974:                     .MaxLength         = 6
975:                     .Top               = loc_nTop
976:                     .Left              = loc_nLef + 194
977:                     .Width             = 54
978:                     .Height            = 23
979:                     .ReadOnly          = loc_lReadOnly
980:                     .DisabledBackColor = RGB(255, 255, 255)
981:                     .FontName          = "Tahoma"

*-- Linhas 987 a 996:
987:                 WITH loc_oCnt.txt_4c_FAprova
988:                     .Value             = ""
989:                     .MaxLength         = 10
990:                     .Top               = loc_nTop
991:                     .Left              = loc_nLef + 250
992:                     .Width             = 80
993:                     .Height            = 23
994:                     .ReadOnly          = .T.
995:                     .DisabledBackColor = RGB(255, 255, 255)
996:                     .FontName          = "Tahoma"

*-- Linhas 1002 a 1011:
1002:                 WITH loc_oCnt.txt_4c_FDatas
1003:                     .Value             = ""
1004:                     .MaxLength         = 20
1005:                     .Top               = loc_nTop
1006:                     .Left              = loc_nLef + 332
1007:                     .Width             = 122
1008:                     .Height            = 23
1009:                     .ReadOnly          = .T.
1010:                     .DisabledBackColor = RGB(255, 255, 255)
1011:                     .FontName          = "Tahoma"

*-- Linhas 1038 a 1060:
1038: 
1039:                 FOR loc_nIdx = 1 TO THIS.this_nNroControles
1040:                     loc_cNome = THIS.laControles[loc_nIdx, 1]
1041:                     loc_cLbl  = STRTRAN(loc_cNome, "txt_4c_F", "lbl_4c_F")
1042:                     IF TYPE("loc_oCnt.&loc_cNome.") = "O"
1043:                         loc_oCnt.RemoveObject(loc_cNome)
1044:                     ENDIF
1045:                     IF TYPE("loc_oCnt.&loc_cLbl.") = "O"
1046:                         loc_oCnt.RemoveObject(loc_cLbl)
1047:                     ENDIF
1048:                 ENDFOR
1049: 
1050:                 loc_aFixos[1]  = "shp_4c_Sep1"
1051:                 loc_aFixos[2]  = "lbl_4c_FEmps"
1052:                 loc_aFixos[3]  = "lbl_4c_FDopes"
1053:                 loc_aFixos[4]  = "lbl_4c_FNumes"
1054:                 loc_aFixos[5]  = "lbl_4c_FAprova"
1055:                 loc_aFixos[6]  = "lbl_4c_FDatas"
1056:                 loc_aFixos[7]  = "txt_4c_FEmps"
1057:                 loc_aFixos[8]  = "txt_4c_FDopes"
1058:                 loc_aFixos[9]  = "txt_4c_FNumes"
1059:                 loc_aFixos[10] = "txt_4c_FAprova"
1060:                 loc_aFixos[11] = "txt_4c_FDatas"

*-- Linhas 1276 a 1300:
1276:         LOCAL loc_oPagina, loc_oAprovar, loc_oBaixar
1277:         TRY
1278:             loc_oPagina  = THIS.pgf_4c_Paginas.Page1
1279:             loc_oAprovar = loc_oPagina.cnt_4c_Workflow.cmd_4c_Aprovar
1280:             loc_oBaixar  = loc_oPagina.cnt_4c_Workflow.cmd_4c_Baixar
1281: 
1282:             IF USED("crSigSyCrs") AND !EOF("crSigSyCrs")
1283:                 IF crSigSyCrs.ChkSubn
1284:                     loc_oAprovar.Enabled = .F.
1285:                     loc_oAprovar.Caption = "Aprovar"
1286:                     loc_oBaixar.Caption  = "Canc Baixa"
1287:                     loc_oBaixar.Enabled  = .T.
1288:                 ELSE
1289:                     loc_oAprovar.Enabled = .T.
1290:                     loc_oBaixar.Enabled  = .T.
1291:                     loc_oBaixar.Caption  = "Baixar"
1292:                     IF crSigSyCrs.ChkApro
1293:                         loc_oAprovar.Caption = "Desaprovar"
1294:                     ELSE
1295:                         loc_oAprovar.Caption = "Aprovar"
1296:                     ENDIF
1297:                 ENDIF
1298:             ELSE
1299:                 loc_oAprovar.Enabled = .F.
1300:                 loc_oBaixar.Enabled  = .F.

*-- Linhas 1594 a 1625:
1594:                 RETURN
1595:             ENDIF
1596: 
1597:             loc_oAprovar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Aprovar
1598: 
1599:             IF !crSigSyCrs.ChkApro
1600:                 loc_lConfirma = MsgConfirma("Confirma Aprova" + CHR(231) + CHR(227) + "o?", ;
1601:                     "Fichas T" + CHR(233) + "cnicas")
1602:                 IF loc_lConfirma
1603:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1604:                     IF THIS.this_oBusinessObject.Aprovar(ALLTRIM(gc_4c_UsuarioLogado))
1605:                         SELECT crSigSyCrs
1606:                         REPLACE crSigSyCrs.ChkApro WITH .T.
1607:                         loc_oAprovar.Caption = "Desaprovar"
1608:                         THIS.AtualizarBotoesWorkflow()
1609:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1610:                     ENDIF
1611:                 ENDIF
1612:             ELSE
1613:                 loc_lConfirma = MsgConfirma("Confirma Desaprova" + CHR(231) + CHR(227) + "o?", ;
1614:                     "Fichas T" + CHR(233) + "cnicas")
1615:                 IF loc_lConfirma
1616:                     THIS.this_oBusinessObject.this_nCods = crSigSyCrs.Cods
1617:                     IF THIS.this_oBusinessObject.Desaprovar()
1618:                         SELECT crSigSyCrs
1619:                         REPLACE crSigSyCrs.ChkApro WITH .F.
1620:                         loc_oAprovar.Caption = "Aprovar"
1621:                         THIS.AtualizarBotoesWorkflow()
1622:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1623:                     ENDIF
1624:                 ENDIF
1625:             ENDIF

*-- Linhas 1639 a 1647:
1639:                 RETURN
1640:             ENDIF
1641: 
1642:             loc_oBaixar = THIS.pgf_4c_Paginas.Page1.cnt_4c_Workflow.cmd_4c_Baixar
1643: 
1644:             IF !crSigSyCrs.ChkSubn
1645:                 *-- Baixar: exige aprovacao previa
1646:                 IF !crSigSyCrs.ChkApro
1647:                     MsgAviso("Baixa n" + CHR(227) + "o Aprovada!", "Fichas T" + CHR(233) + "cnicas")

*-- Linhas 1667 a 1675:
1667:                     IF THIS.this_oBusinessObject.CancelarBaixa(crSigSyCrs.Cods)
1668:                         SELECT crSigSyCrs
1669:                         REPLACE crSigSyCrs.ChkSubn WITH .F.
1670:                         loc_oBaixar.Caption = "Baixar"
1671:                         THIS.AtualizarBotoesWorkflow()
1672:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1673:                     ENDIF
1674:                 ENDIF
1675:             ENDIF

*-- Linhas 2008 a 2040:
2008: 
2009:             DO CASE
2010:                 CASE loc_cModo = "LISTA"
2011:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .T.
2012:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .T.
2013:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .T.
2014:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .T.
2015:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .T.
2016:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
2017:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .F.
2018: 
2019:                 CASE INLIST(loc_cModo, "INSERIR", "ALTERAR")
2020:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
2021:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
2022:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
2023:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
2024:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
2025:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .T.
2026:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.
2027: 
2028:                 CASE loc_cModo = "VISUALIZAR"
2029:                     loc_oCrud.cmd_4c_Incluir.Enabled    = .F.
2030:                     loc_oCrud.cmd_4c_Visualizar.Enabled = .F.
2031:                     loc_oCrud.cmd_4c_Alterar.Enabled    = .F.
2032:                     loc_oCrud.cmd_4c_Excluir.Enabled    = .F.
2033:                     loc_oCrud.cmd_4c_Buscar.Enabled     = .F.
2034:                     loc_oAcao.cmd_4c_Confirmar.Enabled  = .F.
2035:                     loc_oAcao.cmd_4c_Cancelar.Enabled   = .T.
2036:             ENDCASE
2037:         CATCH TO loc_oErro
2038:             MsgErro(loc_oErro.Message, "FormDrs.AjustarBotoesPorModo")
2039:         ENDTRY
2040:     ENDPROC


### BO (C:\4c\projeto\app\classes\DrsBO.prg):
*===============================================================================
* DrsBO.prg - Business Object para Fichas Tecnicas (SigSyCrs)
* Herda de BusinessBase
*
* Tabela principal: SigSyCrs
* Tabela config: SigSyCit
*
* MODELO DE DADOS (key-value store):
*   SigSyCrs (Tits C20, Cods N, Campos C10, Resps M, Pergs C, cIdChaves C,
*             ChkApro L, ChkSubn L)
*   SigSyCit (Tits C20, Campos C10, Descs C, Tipos C1, Ordems N, Listas N,
*             Linhas N, Files C, Fields C, Chaves C, cIdChaves C, CampoOAs C,
*             CampoDAs C, Associados C, Cadeado N, Vinculados C,
*             Obrigatorios L, Pictures C)
*
* Um "registro logico" = conjunto de rows em SigSyCrs com mesmo (Tits, Cods).
* Cada row armazena um campo: Campos=nome, Resps=valor, Pergs=rotulo.
* cIdChaves e a PK fisica de cada row individual.
*===============================================================================

DEFINE CLASS DrsBO AS BusinessBase

    *---------------------------------------------------------------------------
    * Identificacao do registro logico (Tits + Cods formam a PK logica)
    *---------------------------------------------------------------------------
    this_cTits   = ""   && Tipo de ficha C(20) - identifica o formulario/processo
    this_nCods   = 0    && Codigo do registro (PK logica dentro do Tits)

    *---------------------------------------------------------------------------
    * Status do workflow de aprovacao/baixa
    *---------------------------------------------------------------------------
    this_lChkApro  = .F.    && Aprovado
    this_lChkSubn  = .F.    && Baixado/Encerrado (ChkSubn)

    *---------------------------------------------------------------------------
    * Campos fixos de cabecalho (armazenados como key-value em SigSyCrs)
    * Campos = 'Emps', 'Dopes', 'Numes', 'Aprova', 'Datas', 'Baixa'
    *---------------------------------------------------------------------------
    this_cEmps   = ""   && Empresa (C3) - referencia SigCdEmp.CEmps
    this_cDopes  = ""   && Operacao (C20) - referencia SigCdOpe.Dopes
    this_cNumes  = ""   && Numero da operacao (C6)
    this_cAprova = ""   && Aprovador - usuario que aprovou (C10)
    this_cDatas  = ""   && Data de aprovacao como string (C20)
    this_cBaixa  = ""   && Usuario que registrou baixa (C10)

    *---------------------------------------------------------------------------
    * Nomes dos cursores de trabalho (mantidos como constantes aqui para
    * referencia cruzada com o Form)
    *---------------------------------------------------------------------------
    this_cCursorRs    = "crGrvCadRs"    && Cursor escrita SigSyCrs (key=cIdChaves)
    this_cCursorLista = "crSigSyCrs"    && Cursor lista SigSyCrs (key=Cods)
    this_cCursorCit   = "crSigSyCit"    && Cursor config SigSyCit
    this_cCursorLocal = "LocalCadRs"    && Cursor local de respostas (key=CodCampos)

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigSyCrs"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Destroy - Fecha cursores ao destruir o BO
    *===========================================================================
    PROCEDURE Destroy()
        THIS.FecharCursores()
        DODEFAULT()
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave para auditoria
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN EscaparSQL(ALLTRIM(THIS.this_cTits)) + ", " + ;
               FormatarNumeroSQL(THIS.this_nCods)
    ENDFUNC

    *===========================================================================
    * FecharCursores - Fecha todos os cursores de trabalho
    *===========================================================================
    PROCEDURE FecharCursores()
        IF USED("crSigSyCrs")
            USE IN crSigSyCrs
        ENDIF
        IF USED("LocalCadRs")
            USE IN LocalCadRs
        ENDIF
        IF USED("crSigSyCit")
            USE IN crSigSyCit
        ENDIF
        IF USED("crGrvCadRs")
            USE IN crGrvCadRs
        ENDIF
    ENDPROC

    *===========================================================================
    * InicializarCursores - Cria cursor de escrita crGrvCadRs
    *===========================================================================
    FUNCTION InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crGrvCadRs")
                USE IN crGrvCadRs
            ENDIF
            SET NULL ON
            CREATE CURSOR crGrvCadRs ( ;
                Tits      C(20),  ;
                Campos    C(10),  ;
                Cods      N(10,0), ;
                cIdChaves C(38),  ;
                Resps     M,      ;
                Pergs     C(200), ;
                ChkApro   L,      ;
                ChkSubn   L )
            SET NULL OFF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarSigSyCit - Carrega definicoes de campos de SigSyCit para este Tits
    *===========================================================================
    FUNCTION CarregarSigSyCit()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crSigSyCit")
                USE IN crSigSyCit
            ENDIF

            *-- Test mode without DB: create empty cursor so form can initialize
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCit (Tits C(20), Campos C(10), Descs C(60), Tipos C(1), ;
                    Ordems N(3,0), Listas N(1,0), Linhas N(3,0), Files C(200), Fields C(200), ;
                    Chaves C(100), cIdChaves C(38), CampoOAs C(20), CampoDAs C(20), ;
                    Associados C(100), Cadeado N(1,0), Vinculados C(100), ;
                    Obrigatorios N(1,0), Pictures C(50))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE

            loc_cSQL = "SELECT Tits, Campos, Descs, Tipos, Ordems, Listas, Linhas, Files," + ;
                       " Fields, Chaves, cIdChaves, CampoOAs, CampoDAs, Associados, Cadeado," + ;
                       " Vinculados, Obrigatorios, Pictures FROM SigSyCit" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + " ORDER BY Ordems"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCit")
            IF loc_nResult > 0
                IF RECCOUNT("crSigSyCit") > 0
                    SELECT crSigSyCit
                    INDEX ON STR(Ordems, 2) TAG Ordems ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar SigSyCit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && gnConnHandle
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ApanhaRespostas - Carrega todas as respostas de SigSyCrs em LocalCadRs indexado
    *===========================================================================
    FUNCTION ApanhaRespostas()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("LocalCadRs")
                USE IN LocalCadRs
            ENDIF
            loc_cSQL = "SELECT Cods, Campos, CAST(Resps AS VARCHAR(8000)) AS Resps" + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " ORDER BY Cods, Campos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "LocalCadRs")
            IF loc_nResult > 0
                IF RECCOUNT("LocalCadRs") > 0
                    SELECT LocalCadRs
                    INDEX ON STR(Cods, 6) + Campos TAG CodCampos ADDITIVE
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar respostas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * AlimentaLista - Preenche colunas dinamicas de crSigSyCrs via LocalCadRs
    *===========================================================================
    PROCEDURE AlimentaLista()
        LOCAL loc_cCpo
        TRY
            IF USED("crSigSyCrs") AND USED("LocalCadRs") AND USED("crSigSyCit") ;
                    AND RECCOUNT("crSigSyCrs") > 0 AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCrs
                SCAN
                    SELECT crSigSyCit
                    SCAN
                        IF crSigSyCit.Listas = 1
                            loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                            IF SEEK(STR(crSigSyCrs.Cods, 6) + crSigSyCit.Campos, ;
                                    "LocalCadRs", "CodCampos")
                                IF crSigSyCit.Tipos = "N"
                                    REPLACE &loc_cCpo. WITH VAL(LocalCadRs.Resps) IN crSigSyCrs
                                ELSE
                                    REPLACE &loc_cCpo. WITH LocalCadRs.Resps IN crSigSyCrs
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN
                    SELECT crSigSyCrs
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista registros em crSigSyCrs com colunas dinamicas de SigSyCit
    * par_cFiltro: aceita "TODAS"/"" (sem filtro), status=0 (em aberto) ou "BAIXADAS" (ChkSubn=1)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lResultado, loc_cCpo
        loc_lResultado = .F.
        IF VARTYPE(par_cFiltro) <> "C"
            par_cFiltro = ""
        ENDIF
        TRY
            IF !USED("crSigSyCit")
                THIS.CarregarSigSyCit()
            ENDIF
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            DO CASE
                CASE UPPER(ALLTRIM(par_cFiltro)) = "PENDENTES"
                    loc_cWhere = " AND ChkSubn = 0"
                CASE UPPER(ALLTRIM(par_cFiltro)) = "BAIXADAS"
                    loc_cWhere = " AND ChkSubn = 1"
                OTHERWISE
                    loc_cWhere = ""
            ENDCASE
            loc_cSQL = "SELECT DISTINCT ChkSubn, ChkApro, Cods"
            IF USED("crSigSyCit") AND RECCOUNT("crSigSyCit") > 0
                SELECT crSigSyCit
                SCAN
                    IF crSigSyCit.Listas = 1
                        loc_cCpo = ALLTRIM(crSigSyCit.Campos)
                        DO CASE
                            CASE crSigSyCit.Tipos = "N"
                                loc_cSQL = loc_cSQL + ;
                                           ", CAST(9999999999.99 AS DECIMAL(14,2)) AS " + loc_cCpo
                            CASE crSigSyCit.Tipos = "M"
                                loc_cSQL = loc_cSQL + ", SPACE(50) AS " + loc_cCpo
                            OTHERWISE
                                loc_cSQL = loc_cSQL + ", SPACE(12) AS " + loc_cCpo
                        ENDCASE
                    ENDIF
                ENDSCAN
            ENDIF
            loc_cSQL = loc_cSQL + ;
                       " FROM SigSyCrs WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       loc_cWhere + " ORDER BY Cods"
            IF USED("crSigSyCrs")
                USE IN crSigSyCrs
            ENDIF
            *-- Test mode without DB: create empty cursor
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                SET NULL ON
                CREATE CURSOR crSigSyCrs (ChkSubn L, ChkApro L, Cods N(10,0))
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigSyCrs")
                IF loc_nResult > 0
                    THIS.AlimentaLista()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * GerarNovoCods - Gera proximo Cods disponivel para este Tits
    *===========================================================================
    FUNCTION GerarNovoCods()
        LOCAL loc_cSQL, loc_nCods, loc_nResult
        loc_nCods = 0
        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Cods), 0) + 1 AS NextCods FROM SigSyCrs" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_NextCods")
                TABLEREVERT(.T., "cursor_4c_NextCods")
                USE IN cursor_4c_NextCods
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextCods")
            IF loc_nResult > 0 AND !EOF("cursor_4c_NextCods")
                loc_nCods = cursor_4c_NextCods.NextCods
                USE IN cursor_4c_NextCods
            ELSE
                MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_NextCods")
                    USE IN cursor_4c_NextCods
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_nCods
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *===========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCods    = TratarNulo(Cods, "N")
                THIS.this_lChkApro = (TratarNulo(ChkApro, "N") <> 0)
                THIS.this_lChkSubn = (TratarNulo(ChkSubn, "N") <> 0)
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega propriedades do BO para um Cods especifico
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF !USED("LocalCadRs")
                THIS.ApanhaRespostas()
            ENDIF
            IF USED("LocalCadRs")
                THIS.this_nCods = par_nCods
                IF SEEK(STR(par_nCods, 6) + PADR("Emps", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cEmps = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cEmps = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Dopes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDopes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDopes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Numes", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cNumes = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cNumes = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Aprova", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cAprova = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cAprova = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Datas", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cDatas = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cDatas = ""
                ENDIF
                IF SEEK(STR(par_nCods, 6) + PADR("Baixa", 10), "LocalCadRs", "CodCampos")
                    THIS.this_cBaixa = ALLTRIM(LocalCadRs.Resps)
                ELSE
                    THIS.this_cBaixa = ""
                ENDIF
            ENDIF
            IF USED("crSigSyCrs")
                SELECT crSigSyCrs
                LOCATE FOR Cods = par_nCods
                IF !EOF("crSigSyCrs")
                    THIS.this_lChkApro = crSigSyCrs.ChkApro
                    THIS.this_lChkSubn = crSigSyCrs.ChkSubn
                    loc_lResultado = .T.
                ENDIF
            ELSE
                loc_cSQL = "SELECT TOP 1 ChkApro, ChkSubn FROM SigSyCrs" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(par_nCods)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CarregaFlags")
                    TABLEREVERT(.T., "cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFlags")
                IF loc_nResult > 0 AND !EOF("cursor_4c_CarregaFlags")
                    THIS.this_lChkApro = (cursor_4c_CarregaFlags.ChkApro <> 0)
                    THIS.this_lChkSubn = (cursor_4c_CarregaFlags.ChkSubn <> 0)
                    loc_lResultado = .T.
                ENDIF
                IF USED("cursor_4c_CarregaFlags")
                    USE IN cursor_4c_CarregaFlags
                ENDIF
            ENDIF
            IF loc_lResultado
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * SalvarCampos - PRIVADO - Executa DELETE+INSERT de crGrvCadRs em SigSyCrs
    * Retorna .T. se salvou com sucesso
    *===========================================================================
    PROTECTED FUNCTION SalvarCampos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_lTransacao
        loc_lResultado = .F.
        loc_lTransacao = .F.
        TRY
            IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 0
                loc_lTransacao = .T.
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            IF loc_lTransacao
                loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                           EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao excluir registros anteriores:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
            IF loc_lTransacao AND USED("crGrvCadRs") AND RECCOUNT("crGrvCadRs") > 0
                SELECT crGrvCadRs
                SCAN WHILE loc_lTransacao
                    loc_cSQL = "INSERT INTO SigSyCrs" + ;
                               " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                               " VALUES (" + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Tits)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Campos)) + ", " + ;
                               FormatarNumeroSQL(crGrvCadRs.Cods) + ", " + ;
                               "CAST(NEWID() AS VARCHAR(38)), " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Resps)) + ", " + ;
                               EscaparSQL(ALLTRIM(crGrvCadRs.Pergs)) + ", " + ;
                               IIF(crGrvCadRs.ChkApro, "1", "0") + ", " + ;
                               IIF(crGrvCadRs.ChkSubn, "1", "0") + ;
                               ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir campo '" + ALLTRIM(crGrvCadRs.Campos) + ;
                                "':" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lTransacao = .F.
                    ENDIF
                ENDSCAN
            ENDIF
            IF loc_lTransacao
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacao = .F.
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro no commit:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransacao = .F.
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - Salva novo registro (chamado por BusinessBase.Salvar)
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Atualizar - Atualiza registro existente (chamado por BusinessBase.Salvar)
    * Usa padrao delete-insert identico ao original
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.SalvarCampos()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - Exclui todos os campos de um registro logico (Tits+Cods)
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Aprovar - Aprova o registro atual (seta ChkApro=.T., grava Aprova/Datas)
    * par_cUsuario: nome do usuario que esta aprovando
    *===========================================================================
    FUNCTION Aprovar(par_cUsuario)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cDataHora
        loc_lResultado = .F.
        TRY
            loc_cDataHora = TTOC(DATETIME())
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "INSERT INTO SigSyCrs" + ;
                       " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cTits) + ", 'Aprova', " + ;
                       FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                       "CAST(NEWID() AS VARCHAR(38)), " + ;
                       EscaparSQL(ALLTRIM(par_cUsuario)) + ", 'Aprovado', 1, 0)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_cSQL = "INSERT INTO SigSyCrs" + ;
                           " (Tits, Campos, Cods, cIdChaves, Resps, Pergs, ChkApro, ChkSubn)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cTits) + ", 'Datas', " + ;
                           FormatarNumeroSQL(THIS.this_nCods) + ", " + ;
                           "CAST(NEWID() AS VARCHAR(38)), " + ;
                           EscaparSQL(loc_cDataHora) + ", 'Data', 1, 0)"
                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 1" + ;
                           " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                           " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult >= 0
                    THIS.this_lChkApro = .T.
                    THIS.this_cAprova  = ALLTRIM(par_cUsuario)
                    THIS.this_cDatas   = loc_cDataHora
                    THIS.ApanhaRespostas()
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao aprovar registro:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gravar aprovador:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Desaprovar - Remove aprovacao do registro atual (seta ChkApro=.F.)
    *===========================================================================
    FUNCTION Desaprovar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods) + ;
                       " AND Campos IN ('Aprova', 'Datas')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkApro = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(THIS.this_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkApro = .F.
                THIS.this_cAprova  = ""
                THIS.this_cDatas   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao desaprovar registro:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CancelarBaixa - Cancela baixa do registro (seta ChkSubn=.F., remove campos de baixa)
    *===========================================================================
    FUNCTION CancelarBaixa(par_nCods)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigSyCrs WHERE Tits = " + ;
                       EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods) + ;
                       " AND Campos IN ('Emps', 'Dopes', 'Numes', 'Baixa')"
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "UPDATE SigSyCrs SET ChkSubn = 0" + ;
                       " WHERE Tits = " + EscaparSQL(THIS.this_cTits) + ;
                       " AND Cods = " + FormatarNumeroSQL(par_nCods)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lChkSubn = .F.
                THIS.this_cEmps    = ""
                THIS.this_cDopes   = ""
                THIS.this_cNumes   = ""
                THIS.this_cBaixa   = ""
                THIS.ApanhaRespostas()
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao cancelar baixa:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

