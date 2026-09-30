# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2041 linhas total):

*-- Linhas 105 a 124:
105: 
106:         WITH THIS.pgf_4c_Paginas
107:             .PageCount = 2
108:             .Top       = -29
109:             .Left      = 0
110:             .Width     = THIS.Width
111:             .Height    = THIS.Height + 29
112:             .Tabs      = .F.
113:             .Visible   = .T.
114: 
115:             .Page1.Caption   = "Lista"
116:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page1.BackColor = RGB(255, 255, 255)
118: 
119:             .Page2.Caption   = "Dados"
120:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:             .Page2.BackColor = RGB(255, 255, 255)
122:         ENDWITH
123: 
124:         THIS.ConfigurarPaginaLista()

*-- Linhas 140 a 176:
140:         *-- Container Cabecalho (cntSombra no legado, herdado do frmcadastro)
141:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
142:         WITH loc_oPagina.cnt_4c_Cabecalho
143:             .Top         = 31
144:             .Left        = 0
145:             .Width       = THIS.Width
146:             .Height      = 80
147:             .BackColor   = RGB(100, 100, 100)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150: 
151:             .AddObject("lbl_4c_Sombra", "Label")
152:             WITH .lbl_4c_Sombra
153:                 .Caption   = THIS.Caption
154:                 .Top       = 15
155:                 .Left      = 10
156:                 .Width     = THIS.Width
157:                 .Height    = 40
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 16
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .BackStyle = 0
163:                 .AutoSize  = .F.
164:                 .Visible   = .T.
165:             ENDWITH
166: 
167:             .AddObject("lbl_4c_Titulo", "Label")
168:             WITH .lbl_4c_Titulo
169:                 .Caption   = THIS.Caption
170:                 .Top       = 18
171:                 .Left      = 10
172:                 .Width     = THIS.Width
173:                 .Height    = 46
174:                 .FontName  = "Tahoma"
175:                 .FontSize  = 16
176:                 .FontBold  = .T.

*-- Linhas 184 a 206:
184:         *-- Container Botoes CRUD (Grupo_op no legado)
185:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
186:         WITH loc_oPagina.cnt_4c_Botoes
187:             .Top         = 29
188:             .Left        = 542
189:             .Width       = 390
190:             .Height      = 85
191:             .BackStyle   = 0
192:             .BorderWidth = 0
193:             .Visible     = .T.
194: 
195:             .AddObject("cmd_4c_Incluir", "CommandButton")
196:             WITH .cmd_4c_Incluir
197:                 .Caption          = "Incluir"
198:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
199:                 .PicturePosition  = 13
200:                 .Top              = 5
201:                 .Left             = 5
202:                 .Width            = 75
203:                 .Height           = 75
204:                 .BackColor        = RGB(255, 255, 255)
205:                 .ForeColor        = RGB(90, 90, 90)
206:                 .FontName         = "Comic Sans MS"

*-- Linhas 213 a 227:
213:                 .AutoSize         = .F.
214:             ENDWITH
215: 
216:             .AddObject("cmd_4c_Visualizar", "CommandButton")
217:             WITH .cmd_4c_Visualizar
218:                 .Caption          = "Visualizar"
219:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
220:                 .PicturePosition  = 13
221:                 .Top              = 5
222:                 .Left             = 80
223:                 .Width            = 75
224:                 .Height           = 75
225:                 .BackColor        = RGB(255, 255, 255)
226:                 .ForeColor        = RGB(90, 90, 90)
227:                 .FontName         = "Comic Sans MS"

*-- Linhas 235 a 249:
235:                 .AutoSize         = .F.
236:             ENDWITH
237: 
238:             .AddObject("cmd_4c_Alterar", "CommandButton")
239:             WITH .cmd_4c_Alterar
240:                 .Caption          = "Alterar"
241:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
242:                 .PicturePosition  = 13
243:                 .Top              = 5
244:                 .Left             = 155
245:                 .Width            = 75
246:                 .Height           = 75
247:                 .BackColor        = RGB(255, 255, 255)
248:                 .ForeColor        = RGB(90, 90, 90)
249:                 .FontName         = "Comic Sans MS"

*-- Linhas 257 a 271:
257:                 .AutoSize         = .F.
258:             ENDWITH
259: 
260:             .AddObject("cmd_4c_Excluir", "CommandButton")
261:             WITH .cmd_4c_Excluir
262:                 .Caption          = "Excluir"
263:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
264:                 .PicturePosition  = 13
265:                 .Top              = 5
266:                 .Left             = 230
267:                 .Width            = 75
268:                 .Height           = 75
269:                 .BackColor        = RGB(255, 255, 255)
270:                 .ForeColor        = RGB(90, 90, 90)
271:                 .FontName         = "Comic Sans MS"

*-- Linhas 279 a 293:
279:                 .AutoSize         = .F.
280:             ENDWITH
281: 
282:             .AddObject("cmd_4c_Buscar", "CommandButton")
283:             WITH .cmd_4c_Buscar
284:                 .Caption          = "Buscar"
285:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:                 .PicturePosition  = 13
287:                 .Top              = 5
288:                 .Left             = 305
289:                 .Width            = 75
290:                 .Height           = 75
291:                 .BackColor        = RGB(255, 255, 255)
292:                 .ForeColor        = RGB(90, 90, 90)
293:                 .FontName         = "Comic Sans MS"

*-- Linhas 303 a 335:
303: 
304:         ENDWITH
305: 
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
308:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
309:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
310:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
311: 
312:         *-- Container Saida (Grupo_Saida no legado) - padrao canonico do
313:         *-- sistema novo, prevalece sobre o PILAR 1 (regra #10 CLAUDE.md)
314:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
315:         WITH loc_oPagina.cnt_4c_Saida
316:             .Top         = 29
317:             .Left        = 917
318:             .Width       = 90
319:             .Height      = 85
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323: 
324:             .AddObject("cmd_4c_Encerrar", "CommandButton")
325:             WITH .cmd_4c_Encerrar
326:                 .Caption          = "Encerrar"
327:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
328:                 .PicturePosition  = 13
329:                 .Top              = 5
330:                 .Left             = 5
331:                 .Width            = 75
332:                 .Height           = 75
333:                 .BackColor        = RGB(255, 255, 255)
334:                 .ForeColor        = RGB(90, 90, 90)
335:                 .FontName         = "Comic Sans MS"

*-- Linhas 343 a 361:
343:             ENDWITH
344:         ENDWITH
345: 
346:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
347: 
348:         *-- Grid da Lista (Grade no legado) - somente leitura, mostra o
349:         *-- resumo do movimento (Origem/Destino/Doc.Op/Usuario/Status/EmpO/
350:         *-- EmpD) que o form pai ja selecionou. ControlSource/Header sao
351:         *-- (re)definidos em CarregarLista(), apos o RecordSource - regra
352:         *-- "Grade perde cabecalhos apos RecordSource" (FORMCOR_LICOES).
353:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top             = 150
356:             .Left            = 35
357:             .Width           = 944
358:             .Height          = 470
359:             .ColumnCount     = 11
360:             .ReadOnly        = .T.
361:             .DeleteMark      = .F.

*-- Linhas 384 a 400:
384:         *-- DEPOIS de TornarControlesVisiveis (regra "Problema 26" - senao a
385:         *-- rotina generica reexibe estes botoes).
386:         WITH loc_oPagina.cnt_4c_Botoes
387:             .cmd_4c_Incluir.Enabled = .F.
388:             .cmd_4c_Incluir.Visible = .F.
389:             .cmd_4c_Alterar.Enabled = .F.
390:             .cmd_4c_Alterar.Visible = .F.
391:             .cmd_4c_Excluir.Enabled = .F.
392:             .cmd_4c_Excluir.Visible = .F.
393:             .cmd_4c_Buscar.Enabled  = .F.
394:             .cmd_4c_Buscar.Visible  = .F.
395:             .cmd_4c_Visualizar.Left = 5
396:             .Width                  = 90
397:         ENDWITH
398:     ENDPROC
399: 
400:     *===========================================================================

*-- Linhas 410 a 446:
410:         *-- Cabecalho cinza (identico ao da pagina Lista - regra #11 CLAUDE.md)
411:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
412:         WITH loc_oPagina.cnt_4c_Cabecalho
413:             .Top         = 29
414:             .Left        = 0
415:             .Width       = THIS.Width
416:             .Height      = 80
417:             .BackColor   = RGB(100, 100, 100)
418:             .BorderWidth = 0
419:             .Visible     = .T.
420: 
421:             .AddObject("lbl_4c_Sombra", "Label")
422:             WITH .lbl_4c_Sombra
423:                 .Caption   = THIS.Caption
424:                 .Top       = 15
425:                 .Left      = 10
426:                 .Width     = THIS.Width
427:                 .Height    = 40
428:                 .FontName  = "Tahoma"
429:                 .FontSize  = 16
430:                 .FontBold  = .T.
431:                 .ForeColor = RGB(0, 0, 0)
432:                 .BackStyle = 0
433:                 .AutoSize  = .F.
434:                 .Visible   = .T.
435:             ENDWITH
436: 
437:             .AddObject("lbl_4c_Titulo", "Label")
438:             WITH .lbl_4c_Titulo
439:                 .Caption   = THIS.Caption
440:                 .Top       = 18
441:                 .Left      = 10
442:                 .Width     = THIS.Width
443:                 .Height    = 46
444:                 .FontName  = "Tahoma"
445:                 .FontSize  = 16
446:                 .FontBold  = .T.

*-- Linhas 454 a 463:
454:         *-- Container BotoesAcao (Grupo_Salva no legado)
455:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
456:         WITH loc_oPagina.cnt_4c_BotoesAcao
457:             .Top         = 33
458:             .Left        = 842
459:             .Width       = 160
460:             .Height      = 85
461:             .BackStyle   = 1
462:             .BackColor   = RGB(255, 255, 255)
463:             .BorderWidth = 0

*-- Linhas 470 a 484:
470:             *-- topo do Click ja intercepta o botao Procurar antes do Do
471:             *-- Case), entao Confirmar fica sempre desabilitado - transcrito
472:             *-- em AjustarBotoesPorModo(), nao aqui na criacao.
473:             .AddObject("cmd_4c_Confirmar", "CommandButton")
474:             WITH .cmd_4c_Confirmar
475:                 .Caption          = "Confirmar"
476:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
477:                 .PicturePosition  = 13
478:                 .Top              = 5
479:                 .Left             = 5
480:                 .Width            = 75
481:                 .Height           = 75
482:                 .BackColor        = RGB(255, 255, 255)
483:                 .ForeColor        = RGB(90, 90, 90)
484:                 .FontName         = "Comic Sans MS"

*-- Linhas 495 a 509:
495:             *-- (Cancelar.Click: DoDefault() + If ThisForm.plCancelar Then
496:             *-- mAtivapagina1 - plCancelar e property herdada do frmcadastro,
497:             *-- default .T. no Framework)
498:             .AddObject("cmd_4c_Cancelar", "CommandButton")
499:             WITH .cmd_4c_Cancelar
500:                 .Caption          = "Encerrar"
501:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
502:                 .PicturePosition  = 13
503:                 .Top              = 5
504:                 .Left             = 80
505:                 .Width            = 75
506:                 .Height           = 75
507:                 .BackColor        = RGB(255, 255, 255)
508:                 .ForeColor        = RGB(90, 90, 90)
509:                 .FontName         = "Comic Sans MS"

*-- Linhas 518 a 559:
518:             ENDWITH
519:         ENDWITH
520: 
521:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
522:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
523: 
524:         *-- FASE 5/8 - Campos principais (parte 1): bloco de cabecalho do
525:         *-- movimento (Codigo/Docto/Data/Prazo Entrega/OP/Status/Tb.Desconto)
526:         *-- e o container Origem/Destino/Representante. Todos os Top sao os
527:         *-- valores do SCX legado (Pagina.Dados.*) + 29 de compensacao do
528:         *-- PageFrame.Top=-29 (regra CLAUDE.md - "Compensacao PageFrame.Top").
529:         *-- Descricao do item (Get_descr), grades (fwgrade1/GradeOperacao),
530:         *-- imagem (FigJpg) e observacao geral (Container1) ficam para a
531:         *-- FASE 6/8 (segunda metade dos campos).
532: 
533:         *-- Botao "Entrega" (cmdEntrega no legado) - CommandGroup com 1
534:         *-- botao que abre "Do Form SigOpEnt" para alterar o Prazo de
535:         *-- Entrega (comportamento.json). Handler de Click fica para fase
536:         *-- posterior (chama form ainda nao migrado nesta tarefa).
537:         loc_oPagina.AddObject("cmg_4c_Entrega", "CommandGroup")
538:         WITH loc_oPagina.cmg_4c_Entrega
539:             .Top         = 36
540:             .Left        = 23
541:             .Width       = 90
542:             .Height      = 110
543:             .ButtonCount = 1
544:             .BackStyle   = 0
545:             .BorderStyle = 0
546:             .Themes      = .F.
547:             .Visible     = .T.
548:         ENDWITH
549:         WITH loc_oPagina.cmg_4c_Entrega.Buttons(1)
550:             .Top             = 5
551:             .Left            = 5
552:             .Width           = 75
553:             .Height          = 75
554:             .Caption         = "\<Entrega"
555:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
556:             .PicturePosition = 13
557:             .ToolTipText     = "Alterar Prazo de Entrega"
558:             .FontName        = "Comic Sans MS"
559:             .FontBold        = .T.

*-- Linhas 567 a 592:
567:         *-- documentado em sigpres2BO.this_cCodigoMascarado
568:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
569:         WITH loc_oPagina.txt_4c_Codigo
570:             .Top       = 60
571:             .Left      = 131
572:             .Width     = 61
573:             .Height    = 23
574:             .FontBold  = .T.
575:             .FontSize  = 10
576:             .MaxLength = 10
577:             .ReadOnly  = .T.
578:             .ForeColor = RGB(0, 0, 0)
579:             .BackColor = RGB(255, 255, 255)
580:             .Value     = ""
581:             .Visible   = .T.
582:         ENDWITH
583:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
584:         WITH loc_oPagina.lbl_4c_Codigo
585:             .Caption   = "C" + CHR(243) + "digo"
586:             .Top       = 43
587:             .Left      = 131
588:             .Width     = 60
589:             .Height    = 15
590:             .FontName  = "Tahoma"
591:             .FontSize  = 8
592:             .FontBold  = .T.

*-- Linhas 600 a 624:
600:         *-- Docto (Notas)
601:         loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
602:         WITH loc_oPagina.txt_4c_Nota
603:             .Top       = 107
604:             .Left      = 193
605:             .Width     = 66
606:             .Height    = 23
607:             .FontBold  = .T.
608:             .FontSize  = 10
609:             .MaxLength = 6
610:             .ForeColor = RGB(0, 0, 0)
611:             .BackColor = RGB(255, 255, 255)
612:             .Value     = ""
613:             .Visible   = .T.
614:         ENDWITH
615:         loc_oPagina.AddObject("lbl_4c_Nota", "Label")
616:         WITH loc_oPagina.lbl_4c_Nota
617:             .Caption   = "Docto"
618:             .Top       = 91
619:             .Left      = 193
620:             .Width     = 30
621:             .Height    = 15
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 631 a 652:
631:         *-- Data (Datas)
632:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
633:         WITH loc_oPagina.txt_4c_Data
634:             .Top       = 60
635:             .Left      = 201
636:             .Width     = 80
637:             .Height    = 23
638:             .ForeColor = RGB(0, 0, 0)
639:             .BackColor = RGB(255, 255, 255)
640:             .Value     = {}
641:             .Visible   = .T.
642:         ENDWITH
643:         loc_oPagina.AddObject("lbl_4c_Data", "Label")
644:         WITH loc_oPagina.lbl_4c_Data
645:             .Caption   = "Data"
646:             .Top       = 43
647:             .Left      = 201
648:             .Width     = 50
649:             .Height    = 15
650:             .FontName  = "Tahoma"
651:             .FontSize  = 8
652:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 659 a 680:
659:         *-- Prazo de Entrega (PrazoEnts)
660:         loc_oPagina.AddObject("txt_4c_PrazoEntrega", "TextBox")
661:         WITH loc_oPagina.txt_4c_PrazoEntrega
662:             .Top       = 60
663:             .Left      = 289
664:             .Width     = 80
665:             .Height    = 23
666:             .ForeColor = RGB(0, 0, 0)
667:             .BackColor = RGB(255, 255, 255)
668:             .Value     = {}
669:             .Visible   = .T.
670:         ENDWITH
671:         loc_oPagina.AddObject("lbl_4c_PrazoEntrega", "Label")
672:         WITH loc_oPagina.lbl_4c_PrazoEntrega
673:             .Caption   = "Prz Entrega"
674:             .Top       = 43
675:             .Left      = 289
676:             .Width     = 90
677:             .Height    = 15
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 688 a 728:
688:         *-- posterior, form ainda nao migrado nesta tarefa)
689:         loc_oPagina.AddObject("txt_4c_NumeroOP", "TextBox")
690:         WITH loc_oPagina.txt_4c_NumeroOP
691:             .Top        = 108
692:             .Left       = 131
693:             .Width      = 55
694:             .Height     = 23
695:             .InputMask  = "999999"
696:             .ForeColor  = RGB(0, 0, 0)
697:             .BackColor  = RGB(255, 255, 255)
698:             .Value      = 0
699:             .Visible    = .T.
700:         ENDWITH
701:         loc_oPagina.AddObject("lbl_4c_NumeroOP", "Label")
702:         WITH loc_oPagina.lbl_4c_NumeroOP
703:             .Caption   = "OP"
704:             .Top       = 91
705:             .Left      = 131
706:             .Width     = 40
707:             .Height    = 15
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(90, 90, 90)
711:             .BackStyle = 0
712:             .AutoSize  = .F.
713:             .Alignment = 0
714:             .Visible   = .T.
715:         ENDWITH
716: 
717:         loc_oPagina.AddObject("cmd_4c_SubNiveis", "CommandButton")
718:         WITH loc_oPagina.cmd_4c_SubNiveis
719:             .Top             = 154
720:             .Left            = 833
721:             .Width           = 137
722:             .Height          = 40
723:             .Caption         = "   \<Subn" + CHR(237) + "veis    "
724:             .Picture         = gc_4c_CaminhoIcones + "geral_subnivel_26.jpg"
725:             .PicturePosition = 1
726:             .ToolTipText     = "Subn" + CHR(237) + "veis"
727:             .FontName        = "Comic Sans MS"
728:             .FontItalic      = .T.

*-- Linhas 739 a 761:
739:         *-- Tabela de Desconto (Tabds) + Status (PStatus)
740:         loc_oPagina.AddObject("txt_4c_TabelaDesconto", "TextBox")
741:         WITH loc_oPagina.txt_4c_TabelaDesconto
742:             .Top       = 108
743:             .Left      = 269
744:             .Width     = 80
745:             .Height    = 23
746:             .MaxLength = 10
747:             .ForeColor = RGB(0, 0, 0)
748:             .BackColor = RGB(255, 255, 255)
749:             .Value     = ""
750:             .Visible   = .T.
751:         ENDWITH
752:         loc_oPagina.AddObject("lbl_4c_TabelaDesconto", "Label")
753:         WITH loc_oPagina.lbl_4c_TabelaDesconto
754:             .Caption   = "Tb. Desconto"
755:             .Top       = 91
756:             .Left      = 269
757:             .Width     = 90
758:             .Height    = 15
759:             .FontName  = "Tahoma"
760:             .FontSize  = 8
761:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 767 a 790:
767: 
768:         loc_oPagina.AddObject("txt_4c_Status", "TextBox")
769:         WITH loc_oPagina.txt_4c_Status
770:             .Top       = 108
771:             .Left      = 358
772:             .Width     = 36
773:             .Height    = 23
774:             .Alignment = 2
775:             .MaxLength = 1
776:             .ForeColor = RGB(0, 0, 0)
777:             .BackColor = RGB(255, 255, 255)
778:             .Value     = ""
779:             .Visible   = .T.
780:         ENDWITH
781:         loc_oPagina.AddObject("lbl_4c_Status", "Label")
782:         WITH loc_oPagina.lbl_4c_Status
783:             .Caption   = "Status"
784:             .Top       = 91
785:             .Left      = 358
786:             .Width     = 50
787:             .Height    = 15
788:             .FontName  = "Tahoma"
789:             .FontSize  = 8
790:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 797 a 854:
797:         *-- Container Origem/Destino/Representante (Origem no legado)
798:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
799:         WITH loc_oPagina.cnt_4c_Origem
800:             .Top         = 202
801:             .Left        = 27
802:             .Width       = 582
803:             .Height      = 164
804:             .BackStyle   = 1
805:             .BackColor   = RGB(255, 255, 255)
806:             .BorderColor = RGB(136, 188, 189)
807:             .SpecialEffect = 0
808:             .Visible     = .T.
809: 
810:             *-- Titulos de secao
811:             .AddObject("lbl_4c_Origem", "Label")
812:             WITH .lbl_4c_Origem
813:                 .Caption   = "Origem"
814:                 .Top       = 5
815:                 .Left      = 5
816:                 .Width     = 100
817:                 .Height    = 15
818:                 .FontName  = "Tahoma"
819:                 .FontSize  = 8
820:                 .FontBold  = .T.
821:                 .ForeColor = RGB(90, 90, 90)
822:                 .BackStyle = 0
823:                 .AutoSize  = .F.
824:                 .Alignment = 0
825:                 .Visible   = .T.
826:             ENDWITH
827: 
828:             .AddObject("lbl_4c_Destino", "Label")
829:             WITH .lbl_4c_Destino
830:                 .Caption   = "Destino"
831:                 .Top       = 59
832:                 .Left      = 5
833:                 .Width     = 100
834:                 .Height    = 15
835:                 .FontName  = "Tahoma"
836:                 .FontSize  = 8
837:                 .FontBold  = .T.
838:                 .ForeColor = RGB(90, 90, 90)
839:                 .BackStyle = 0
840:                 .AutoSize  = .F.
841:                 .Alignment = 0
842:                 .Visible   = .T.
843:             ENDWITH
844: 
845:             .AddObject("lbl_4c_Representante", "Label")
846:             WITH .lbl_4c_Representante
847:                 .Caption   = "Representante"
848:                 .Top       = 113
849:                 .Left      = 5
850:                 .Width     = 120
851:                 .Height    = 15
852:                 .FontName  = "Tahoma"
853:                 .FontSize  = 8
854:                 .FontBold  = .T.

*-- Linhas 862 a 903:
862:             *-- Linhas separadoras
863:             .AddObject("lin_4c_Line1", "Line")
864:             WITH .lin_4c_Line1
865:                 .Top         = 20
866:                 .Left        = 5
867:                 .Width       = 340
868:                 .Height      = 0
869:                 .BorderWidth = 2
870:                 .Visible     = .T.
871:             ENDWITH
872: 
873:             .AddObject("lin_4c_Line2", "Line")
874:             WITH .lin_4c_Line2
875:                 .Top         = 74
876:                 .Left        = 5
877:                 .Width       = 340
878:                 .Height      = 0
879:                 .BorderWidth = 2
880:                 .Visible     = .T.
881:             ENDWITH
882: 
883:             .AddObject("lin_4c_Line3", "Line")
884:             WITH .lin_4c_Line3
885:                 .Top         = 129
886:                 .Left        = 5
887:                 .Width       = 340
888:                 .Height      = 0
889:                 .BorderWidth = 2
890:                 .Visible     = .T.
891:             ENDWITH
892: 
893:             *-- Linha Origem: Grupo / Conta / Descricao da Conta
894:             .AddObject("lbl_4c_GrupoOrigem", "Label")
895:             WITH .lbl_4c_GrupoOrigem
896:                 .Caption   = "Grupo :"
897:                 .Top       = 30
898:                 .Left      = 19
899:                 .Width     = 40
900:                 .Height    = 15
901:                 .FontName  = "Tahoma"
902:                 .FontSize  = 8
903:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 909 a 933:
909: 
910:             .AddObject("txt_4c_GrupoOrigem", "TextBox")
911:             WITH .txt_4c_GrupoOrigem
912:                 .Top       = 27
913:                 .Left      = 61
914:                 .Width     = 80
915:                 .Height    = 21
916:                 .FontBold  = .T.
917:                 .MaxLength = 10
918:                 .ForeColor = RGB(0, 0, 0)
919:                 .DisabledBackColor = RGB(255, 255, 255)
920:                 .Value     = ""
921:                 .Visible   = .T.
922:             ENDWITH
923: 
924:             .AddObject("lbl_4c_ContaOrigem", "Label")
925:             WITH .lbl_4c_ContaOrigem
926:                 .Caption   = "Conta :"
927:                 .Top       = 30
928:                 .Left      = 154
929:                 .Width     = 40
930:                 .Height    = 15
931:                 .FontName  = "Tahoma"
932:                 .FontSize  = 8
933:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 939 a 976:
939: 
940:             .AddObject("txt_4c_ContaOrigem", "TextBox")
941:             WITH .txt_4c_ContaOrigem
942:                 .Top       = 27
943:                 .Left      = 197
944:                 .Width     = 80
945:                 .Height    = 21
946:                 .MaxLength = 10
947:                 .ForeColor = RGB(0, 0, 0)
948:                 .DisabledBackColor = RGB(255, 255, 255)
949:                 .Value     = ""
950:                 .Visible   = .T.
951:             ENDWITH
952: 
953:             .AddObject("txt_4c_DescContaOrigem", "TextBox")
954:             WITH .txt_4c_DescContaOrigem
955:                 .Top       = 27
956:                 .Left      = 277
957:                 .Width     = 267
958:                 .Height    = 21
959:                 .ReadOnly  = .T.
960:                 .ForeColor = RGB(0, 0, 0)
961:                 .DisabledBackColor = RGB(255, 255, 255)
962:                 .Value     = ""
963:                 .Visible   = .T.
964:             ENDWITH
965: 
966:             *-- Linha Destino: Grupo / Conta / Descricao da Conta
967:             .AddObject("lbl_4c_GrupoDestino", "Label")
968:             WITH .lbl_4c_GrupoDestino
969:                 .Caption   = "Grupo :"
970:                 .Top       = 85
971:                 .Left      = 19
972:                 .Width     = 40
973:                 .Height    = 15
974:                 .FontName  = "Tahoma"
975:                 .FontSize  = 8
976:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 982 a 1006:
982: 
983:             .AddObject("txt_4c_GrupoDestino", "TextBox")
984:             WITH .txt_4c_GrupoDestino
985:                 .Top       = 82
986:                 .Left      = 61
987:                 .Width     = 80
988:                 .Height    = 21
989:                 .FontBold  = .T.
990:                 .MaxLength = 10
991:                 .ForeColor = RGB(0, 0, 0)
992:                 .DisabledBackColor = RGB(255, 255, 255)
993:                 .Value     = ""
994:                 .Visible   = .T.
995:             ENDWITH
996: 
997:             .AddObject("lbl_4c_ContaDestino", "Label")
998:             WITH .lbl_4c_ContaDestino
999:                 .Caption   = "Conta :"
1000:                 .Top       = 85
1001:                 .Left      = 154
1002:                 .Width     = 40
1003:                 .Height    = 15
1004:                 .FontName  = "Tahoma"
1005:                 .FontSize  = 8
1006:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1012 a 1034:
1012: 
1013:             .AddObject("txt_4c_ContaDestino", "TextBox")
1014:             WITH .txt_4c_ContaDestino
1015:                 .Top       = 82
1016:                 .Left      = 196
1017:                 .Width     = 80
1018:                 .Height    = 21
1019:                 .MaxLength = 10
1020:                 .ForeColor = RGB(0, 0, 0)
1021:                 .DisabledBackColor = RGB(255, 255, 255)
1022:                 .Value     = ""
1023:                 .Visible   = .T.
1024:             ENDWITH
1025: 
1026:             .AddObject("txt_4c_DescContaDestino", "TextBox")
1027:             WITH .txt_4c_DescContaDestino
1028:                 .Top       = 82
1029:                 .Left      = 277
1030:                 .Width     = 267
1031:                 .Height    = 21
1032:                 .ReadOnly  = .T.
1033:                 .ForeColor = RGB(0, 0, 0)
1034:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1040 a 1071:
1040:             *-- Get_ContaD/txt_4c_ContaDestino no legado (comportamento.json).
1041:             *-- Handler de Click fica para fase posterior (Do Form SIGCDCTA,
1042:             *-- form ainda nao migrado nesta tarefa).
1043:             .AddObject("cmd_4c_BtnCadastros", "CommandButton")
1044:             WITH .cmd_4c_BtnCadastros
1045:                 .Top           = 79
1046:                 .Left          = 549
1047:                 .Width         = 27
1048:                 .Height        = 31
1049:                 .Caption       = ""
1050:                 .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
1051:                 .FontSize      = 7
1052:                 .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
1053:                 .SpecialEffect = 0
1054:                 .BackColor     = RGB(255, 255, 255)
1055:                 .Themes        = .F.
1056:                 .Visible       = .T.
1057:             ENDWITH
1058: 
1059:             *-- Linha Representante: Grupo / Conta / Descricao (Get_resps eh
1060:             *-- ReadOnly no legado - representante nao editavel diretamente
1061:             *-- nesta tela, so o grupo do representante)
1062:             .AddObject("lbl_4c_GrupoRepresentante", "Label")
1063:             WITH .lbl_4c_GrupoRepresentante
1064:                 .Caption   = "Grupo :"
1065:                 .Top       = 138
1066:                 .Left      = 19
1067:                 .Width     = 40
1068:                 .Height    = 15
1069:                 .FontName  = "Tahoma"
1070:                 .FontSize  = 8
1071:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1077 a 1101:
1077: 
1078:             .AddObject("txt_4c_GrupoRepresentante", "TextBox")
1079:             WITH .txt_4c_GrupoRepresentante
1080:                 .Top       = 135
1081:                 .Left      = 61
1082:                 .Width     = 80
1083:                 .Height    = 21
1084:                 .FontBold  = .T.
1085:                 .MaxLength = 10
1086:                 .ForeColor = RGB(0, 0, 0)
1087:                 .DisabledBackColor = RGB(255, 255, 255)
1088:                 .Value     = ""
1089:                 .Visible   = .T.
1090:             ENDWITH
1091: 
1092:             .AddObject("lbl_4c_ContaRepresentante", "Label")
1093:             WITH .lbl_4c_ContaRepresentante
1094:                 .Caption   = "Conta :"
1095:                 .Top       = 138
1096:                 .Left      = 154
1097:                 .Width     = 40
1098:                 .Height    = 15
1099:                 .FontName  = "Tahoma"
1100:                 .FontSize  = 8
1101:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1107 a 1130:
1107: 
1108:             .AddObject("txt_4c_Representante", "TextBox")
1109:             WITH .txt_4c_Representante
1110:                 .Top       = 135
1111:                 .Left      = 195
1112:                 .Width     = 80
1113:                 .Height    = 21
1114:                 .ReadOnly  = .T.
1115:                 .MaxLength = 10
1116:                 .ForeColor = RGB(0, 0, 0)
1117:                 .DisabledBackColor = RGB(255, 255, 255)
1118:                 .Value     = ""
1119:                 .Visible   = .T.
1120:             ENDWITH
1121: 
1122:             .AddObject("txt_4c_DescRepresentante", "TextBox")
1123:             WITH .txt_4c_DescRepresentante
1124:                 .Top       = 135
1125:                 .Left      = 277
1126:                 .Width     = 267
1127:                 .Height    = 21
1128:                 .ReadOnly  = .T.
1129:                 .ForeColor = RGB(0, 0, 0)
1130:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 1139 a 1147:
1139:         *-- (GradeOperacao/TmpOperacao) e observacao geral do cabecalho
1140:         *-- (Container1/fwmemo1 -> this_cObservacao, ja existente desde a
1141:         *-- Fase 1/2). Todos os Top sao os valores do SCX legado + 29 de
1142:         *-- compensacao do PageFrame.Top=-29 (exceto filhos de containers,
1143:         *-- relativos ao proprio container).
1144: 
1145:         *-- Grade de Itens (fwgrade1/xEestI no legado) - 10 colunas,
1146:         *-- somente leitura. RecordSource/ControlSource/Headers sao
1147:         *-- (re)definidos em CarregarItensGrid(), apos SQLEXEC popular

*-- Linhas 1153 a 1162:
1153:         *-- com os headers estaticos do SCX (layout.json).
1154:         loc_oPagina.AddObject("grd_4c_Itens", "Grid")
1155:         WITH loc_oPagina.grd_4c_Itens
1156:             .Top             = 379
1157:             .Left            = 23
1158:             .Width           = 732
1159:             .Height          = 191
1160:             .ColumnCount     = 10
1161:             .ReadOnly        = .T.
1162:             .DeleteMark      = .F.

*-- Linhas 1180 a 1203:
1180:         *-- Descricao do item selecionado (Get_descr -> xEestI.DPros)
1181:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
1182:         WITH loc_oPagina.txt_4c_Descr
1183:             .Top       = 591
1184:             .Left      = 23
1185:             .Width     = 454
1186:             .Height    = 23
1187:             .ReadOnly  = .T.
1188:             .MaxLength = 65
1189:             .ForeColor = RGB(0, 0, 0)
1190:             .BackColor = RGB(255, 255, 255)
1191:             .Value     = ""
1192:             .Visible   = .T.
1193:         ENDWITH
1194:         loc_oPagina.AddObject("lbl_4c_Descr", "Label")
1195:         WITH loc_oPagina.lbl_4c_Descr
1196:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1197:             .Top       = 575
1198:             .Left      = 23
1199:             .Width     = 200
1200:             .Height    = 15
1201:             .FontName  = "Tahoma"
1202:             .FontSize  = 8
1203:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1210 a 1232:
1210:         *-- Observacao do item selecionado (Get_obs -> xEestI.OBS)
1211:         loc_oPagina.AddObject("edt_4c_ObservacaoItem", "EditBox")
1212:         WITH loc_oPagina.edt_4c_ObservacaoItem
1213:             .Top       = 590
1214:             .Left      = 496
1215:             .Width     = 454
1216:             .Height    = 24
1217:             .ReadOnly  = .T.
1218:             .ForeColor = RGB(0, 0, 0)
1219:             .BackColor = RGB(255, 255, 255)
1220:             .Value     = ""
1221:             .Visible   = .T.
1222:         ENDWITH
1223:         loc_oPagina.AddObject("lbl_4c_ObservacaoItem", "Label")
1224:         WITH loc_oPagina.lbl_4c_ObservacaoItem
1225:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do item"
1226:             .Top       = 573
1227:             .Left      = 496
1228:             .Width     = 200
1229:             .Height    = 15
1230:             .FontName  = "Tahoma"
1231:             .FontSize  = 8
1232:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1240 a 1272:
1240:         *-- ate o usuario selecionar um item na grade (AtualizarItemSelecionado)
1241:         loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
1242:         WITH loc_oPagina.shp_4c_Shape4
1243:             .Top          = 394
1244:             .Left         = 761
1245:             .Width        = 226
1246:             .Height       = 163
1247:             .BorderColor  = RGB(0, 0, 0)
1248:             .Visible      = .F.
1249:         ENDWITH
1250: 
1251:         loc_oPagina.AddObject("img_4c_FigJpg", "Image")
1252:         WITH loc_oPagina.img_4c_FigJpg
1253:             .Top       = 394
1254:             .Left      = 762
1255:             .Width     = 225
1256:             .Height    = 163
1257:             .Stretch   = 1
1258:             .Visible   = .F.
1259:         ENDWITH
1260: 
1261:         *-- Grade de Operacoes vinculadas (GradeOperacao/TmpOperacao) -
1262:         *-- somente leitura, 1 coluna, fonte Courier New (transcricao
1263:         *-- literal do Column1.FontName do SCX legado).
1264:         loc_oPagina.AddObject("grd_4c_Operacoes", "Grid")
1265:         WITH loc_oPagina.grd_4c_Operacoes
1266:             .Top         = 39
1267:             .Left        = 679
1268:             .Width       = 112
1269:             .Height      = 148
1270:             .ColumnCount = 1
1271:             .ReadOnly    = .T.
1272:             .DeleteMark  = .F.

*-- Linhas 1284 a 1303:
1284:         *-- existente desde a Fase 1/2)
1285:         loc_oPagina.AddObject("cnt_4c_Observacao", "Container")
1286:         WITH loc_oPagina.cnt_4c_Observacao
1287:             .Top       = 202
1288:             .Left      = 614
1289:             .Width     = 373
1290:             .Height    = 164
1291:             .BackStyle = 0
1292:             .Visible   = .T.
1293: 
1294:             .AddObject("lbl_4c_Observacao", "Label")
1295:             WITH .lbl_4c_Observacao
1296:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
1297:                 .Top       = 3
1298:                 .Left      = 7
1299:                 .Width     = 100
1300:                 .Height    = 15
1301:                 .FontName  = "Tahoma"
1302:                 .FontSize  = 8
1303:                 .FontBold  = .T.

*-- Linhas 1310 a 1319:
1310: 
1311:             .AddObject("edt_4c_Observacao", "EditBox")
1312:             WITH .edt_4c_Observacao
1313:                 .Top       = 20
1314:                 .Left      = 7
1315:                 .Width     = 359
1316:                 .Height    = 138
1317:                 .ReadOnly  = .T.
1318:                 .ForeColor = RGB(0, 0, 0)
1319:                 .BackColor = RGB(255, 255, 255)

*-- Linhas 1333 a 1341:
1333:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrigem, "LostFocus", THIS, "ValidarGrupoOrigem")
1334:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrigem, "LostFocus", THIS, "ValidarContaOrigem")
1335:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaDestino, "LostFocus", THIS, "ValidarContaDestino")
1336:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosClick")
1337: 
1338:         THIS.TornarControlesVisiveis(loc_oPagina)
1339:     ENDPROC
1340: 
1341:     *===========================================================================

*-- Linhas 1437 a 1455:
1437:                     loc_oGrid.Column10.Width = 50
1438:                     loc_oGrid.Column11.Width = 50
1439: 
1440:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
1441:                     loc_oGrid.Column2.Header1.Caption  = "Data"
1442:                     loc_oGrid.Column3.Header1.Caption  = "Grupo"
1443:                     loc_oGrid.Column4.Header1.Caption  = "Origem"
1444:                     loc_oGrid.Column5.Header1.Caption  = "Grupo"
1445:                     loc_oGrid.Column6.Header1.Caption  = "Destino"
1446:                     loc_oGrid.Column7.Header1.Caption  = "Doc.Op"
1447:                     loc_oGrid.Column8.Header1.Caption  = "Usu" + CHR(225) + "rio"
1448:                     loc_oGrid.Column9.Header1.Caption  = "Status"
1449:                     loc_oGrid.Column10.Header1.Caption = "EmpO"
1450:                     loc_oGrid.Column11.Header1.Caption = "EmpD"
1451: 
1452:                     THIS.FormatarGridLista(loc_oGrid)
1453:                     loc_oGrid.Refresh()
1454: 
1455:                     loc_lResultado = .T.

*-- Linhas 1482 a 1512:
1482:     *===========================================================================
1483:     * BtnIncluirClick - Equivalente ao Grupo_op.Click(Opcao=1) do legado: este
1484:     * dialogo NAO permite Incluir sobre o movimento ja selecionado pelo form
1485:     * pai. AcertaBotoes (ConfigurarPaginaLista) ja deixa cmd_4c_Incluir com
1486:     * Enabled=.F./Visible=.F. - este metodo transcreve o proprio "Inlist(
1487:     * This.Value, 1, 3, 4, 5)" do legado, que apenas volta para a Pagina 1
1488:     * (ThisForm.mAtivaPagina1), sem abrir a Pagina de Dados (regra #17
1489:     * CLAUDE.md - regra de negocio, nao PILAR 1).
1490:     *===========================================================================
1491:     PROCEDURE BtnIncluirClick()
1492:         THIS.AlternarPagina(1)
1493:     ENDPROC
1494: 
1495:     *===========================================================================
1496:     * BtnAlterarClick - Equivalente ao Grupo_op.Click(Opcao=3) do legado: mesma
1497:     * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Alterar ja esta
1498:     * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Alterar
1499:     * o movimento.
1500:     *===========================================================================
1501:     PROCEDURE BtnAlterarClick()
1502:         THIS.AlternarPagina(1)
1503:     ENDPROC
1504: 
1505:     *===========================================================================
1506:     * BtnExcluirClick - Equivalente ao Grupo_op.Click(Opcao=4) do legado: mesma
1507:     * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Excluir ja esta
1508:     * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Excluir
1509:     * o movimento.
1510:     *===========================================================================
1511:     PROCEDURE BtnExcluirClick()
1512:         THIS.AlternarPagina(1)

*-- Linhas 1523 a 1544:
1523:     *===========================================================================
1524:     * BtnBuscarClick - Equivalente ao Grupo_op.Click(Opcao=5) do legado (botao
1525:     * "procurar"): mesma transcricao do "Inlist(This.Value, 1, 3, 4, 5)" -
1526:     * cmd_4c_Buscar ja esta Enabled=.F./Visible=.F. via AcertaBotoes (o ramo
1527:     * 'PROCURAR' do Do Case abaixo do Inlist e codigo morto no legado - o
1528:     * proprio Inlist ja intercepta Value=5 antes de chegar la). Este dialogo
1529:     * NAO permite Buscar/Procurar sobre o movimento ja selecionado.
1530:     *===========================================================================
1531:     PROCEDURE BtnBuscarClick()
1532:         THIS.AlternarPagina(1)
1533:     ENDPROC
1534: 
1535:     *===========================================================================
1536:     * BtnSalvarClick - Equivalente a Grupo_Salva.Salva.Click do legado
1537:     * (=DoDefault() + Thisform.mAtivapagina1): nenhuma gravacao acontece -
1538:     * o Salva.Click do legado nao chama SQL nenhum, so volta para a Lista.
1539:     * Na pratica cmd_4c_Confirmar fica sempre desabilitado (ver
1540:     * AjustarBotoesPorModo), pois pcEscolha so chega a 'CONSULTAR' neste
1541:     * dialogo; o metodo e implementado por completude/fidelidade ao evento
1542:     * do legado, nao porque seja alcancavel pela UI.
1543:     *===========================================================================
1544:     PROCEDURE BtnSalvarClick()

*-- Linhas 1558 a 1578:
1558:     ENDPROC
1559: 
1560:     *===========================================================================
1561:     * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/Cancelar de
1562:     * cnt_4c_BotoesAcao. Transcricao de Grupo_op.Click: "loGBotaosalva.Salva.
1563:     * Enabled = (Not .pcEscolha = 'CONSULTAR')". Como pcEscolha so assume
1564:     * 'CONSULTAR' neste dialogo (regra #17 CLAUDE.md - so a formula, sem
1565:     * reinterpretar: o ramo 'PROCURAR' e inalcancavel, ver BtnBuscarClick),
1566:     * a formula colapsa em constante: Confirmar SEMPRE desabilitado.
1567:     *===========================================================================
1568:     PROCEDURE AjustarBotoesPorModo()
1569:         LOCAL loc_oBotoesAcao
1570:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1571: 
1572:         loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1573:         loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1574:     ENDPROC
1575: 
1576:     *===========================================================================
1577:     * HabilitarCampos - Transcricao de ".mObjEnabled(.Pagina.Dados, .t.)"
1578:     * chamado em Grupo_op.Click antes de exibir a Pagina de Dados. Alcanca os

*-- Linhas 1684 a 1701:
1684:                     loc_oGrid.Column9.Width  = 60
1685:                     loc_oGrid.Column10.Width = 60
1686: 
1687:                     loc_oGrid.Column1.Header1.Caption  = "Produto"
1688:                     loc_oGrid.Column2.Header1.Caption  = "Produzido"
1689:                     loc_oGrid.Column3.Header1.Caption  = "Qtd."
1690:                     loc_oGrid.Column4.Header1.Caption  = "Saldo"
1691:                     loc_oGrid.Column5.Header1.Caption  = "Qtd.Baixa"
1692:                     loc_oGrid.Column6.Header1.Caption  = "Produzir"
1693:                     loc_oGrid.Column7.Header1.Caption  = ""
1694:                     loc_oGrid.Column8.Header1.Caption  = "Peso"
1695:                     loc_oGrid.Column9.Header1.Caption  = "%Ent."
1696:                     loc_oGrid.Column10.Header1.Caption = "Tam."
1697: 
1698:                     loc_oGrid.FontName = "Tahoma"
1699:                     loc_oGrid.FontSize = 8
1700:                     loc_oGrid.Refresh()
1701: 

*-- Linhas 1737 a 1745:
1737:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1738:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Operacoes.codigos"
1739:                     loc_oGrid.Column1.Width          = 100
1740:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1741:                     loc_oGrid.Column1.FontName        = "Courier New"
1742:                     loc_oGrid.Refresh()
1743: 
1744:                     loc_lResultado = .T.
1745:                 ENDIF

*-- Linhas 1965 a 1987:
1965:         loc_oOrigem = loc_oPg2.cnt_4c_Origem
1966: 
1967:         WITH THIS.this_oBusinessObject
1968:             loc_oPg2.txt_4c_Codigo.Value           = .this_cCodigoMascarado
1969:             loc_oPg2.txt_4c_Nota.Value             = .this_cDocumento
1970:             loc_oPg2.txt_4c_Data.Value              = .this_dData
1971:             loc_oPg2.txt_4c_PrazoEntrega.Value     = .this_dPrazoEntrega
1972:             loc_oPg2.txt_4c_NumeroOP.Value          = .this_nNumeroOP
1973:             loc_oPg2.txt_4c_TabelaDesconto.Value    = .this_cTabelaDesconto
1974:             loc_oPg2.txt_4c_Status.Value             = .this_cStatus
1975:             loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value = .this_cObservacao
1976: 
1977:             loc_oOrigem.txt_4c_GrupoOrigem.Value        = .this_cGrupoOrigem
1978:             loc_oOrigem.txt_4c_ContaOrigem.Value        = .this_cContaOrigem
1979:             loc_oOrigem.txt_4c_GrupoDestino.Value       = .this_cGrupoDestino
1980:             loc_oOrigem.txt_4c_ContaDestino.Value       = .this_cContaDestino
1981:             loc_oOrigem.txt_4c_Representante.Value      = .this_cRepresentante
1982:             loc_oOrigem.txt_4c_GrupoRepresentante.Value = .this_cGrupoRepresentante
1983:         ENDWITH
1984:     ENDPROC
1985: 
1986:     *===========================================================================
1987:     * TornarControlesVisiveis - Torna todos os controles visiveis


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* SIGPRES2BO.PRG
* Business Object para o dialogo de Origem/Destino/Representante de Movimento
* (SIGPRES2 - dialogo filho aberto por um form OPERACIONAL pai via
*  "Do Form SigPrEs2 With ThisForm, ...", NAO acessivel direto pelo menu)
*
* Tabela Principal : SigMvCab (cabecalho de movimentacao)
* Chave Real (PK)  : CidChaves    CHAR(20)
* Chave Posicional : EmpDopNums   CHAR(29) = Emps CHAR(3) + Dopes CHAR(20) + Str(Numes, 6)
*                     (NUNCA usar ALLTRIM nas partes - ver CLAUDE.md regra #42)
*
* Logica do legado: o form pai ja populou um cursor local (csTemporario) com o
* registro (ou lote de registros) de SigMvCab a editar; o SIGPRES2 apenas edita
* os campos de cabecalho abaixo (Origem/Destino/Representante/Status/Prazo) e
* delega o commit ao TableUpdate do buffer do framework (Grupo_Salva.Salva.Click
* so chama DoDefault() + mAtivapagina1 - nao ha INSERT/UPDATE/DELETE proprios no
* codigo fonte do SIGPRES2). Os campos de item (grid fwgrade1/xEestI, vindos de
* SigMvItn/SigMvIts) e a grade de operacoes (TmpOperacao/SigMvPec) sao
* somente-leitura e pertencem a um cursor de detalhe, nao a properties escalares
* deste BO.
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento (SigMvCab)
    this_cEmpresa            = ""   && Emps        CHAR(3)  - Empresa (parte da chave posicional)
    this_cTipoDocumento      = ""   && Dopes        CHAR(20) - Tipo de documento (parte da chave posicional)
    this_nNumero             = 0    && Numes        NUMERIC(6,0) - Numero do documento (parte da chave posicional)
    this_cEmpresaDestino     = ""   && Empds        CHAR(3)  - Empresa de destino (grid Lista, coluna "EmpD")
    this_cChaveMovimento     = ""   && EmpDopNums   CHAR(29) - Chave posicional (Emps+Dopes+Str(Numes,6))
    this_cCidChave           = ""   && CidChaves    CHAR(20) - Chave primaria real da tabela

    *-- Origem / Destino / Representante (container "Origem" da Pagina Dados)
    this_cGrupoOrigem        = ""   && Grupoos      CHAR(10)
    this_cContaOrigem        = ""   && Contaos      CHAR(10)
    this_cGrupoDestino       = ""   && Grupods      CHAR(10)
    this_cContaDestino       = ""   && Contads      CHAR(10)
    this_cRepresentante      = ""   && Vends        CHAR(10)
    this_cGrupoRepresentante = ""   && Grvends      CHAR(10)

    *-- Demais campos de cabecalho editaveis na Pagina Dados
    this_cTabelaDesconto     = ""   && Tabds        CHAR(10)
    this_cStatus             = ""   && PStatus      CHAR(1)
    this_cUsuario            = ""   && Usuars       CHAR(10) - usuario do movimento (grid Lista, coluna "Usuario")
    this_nNumeroOP           = 0    && Nops         NUMERIC(10,0)
    this_dPrazoEntrega       = {}   && PrazoEnts    DATETIME
    this_cCodigoMascarado    = ""   && MascNum      CHAR(10) - exibicao formatada (Get_codigo), somente leitura
    this_cDocumento          = ""   && Notas        CHAR(6)  - numero do documento/nota (Get_nota)
    this_dData               = {}   && Datas        DATETIME
    this_cObservacao         = ""   && Obses        TEXT (memo)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela (CidChaves), usada por
    * RegistrarAuditoria() e pela clausula WHERE de Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigMvCab que este dialogo edita
    * (Origem/Destino/Representante/cabecalho) para as properties do BO.
    * SELECT (par_cAliasCursor) ANTES de acessar os campos (regra #8 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpresa            = TratarNulo(emps, "")
                THIS.this_cTipoDocumento      = TratarNulo(dopes, "")
                THIS.this_nNumero             = TratarNulo(numes, 0)
                THIS.this_cEmpresaDestino     = TratarNulo(empds, "")
                THIS.this_cChaveMovimento     = TratarNulo(empdopnums, "")
                THIS.this_cCidChave           = TratarNulo(cidchaves, "")

                THIS.this_cGrupoOrigem        = TratarNulo(grupoos, "")
                THIS.this_cContaOrigem        = TratarNulo(contaos, "")
                THIS.this_cGrupoDestino       = TratarNulo(grupods, "")
                THIS.this_cContaDestino       = TratarNulo(contads, "")
                THIS.this_cRepresentante      = TratarNulo(vends, "")
                THIS.this_cGrupoRepresentante = TratarNulo(grvends, "")

                THIS.this_cTabelaDesconto     = TratarNulo(tabds, "")
                THIS.this_cStatus             = TratarNulo(pstatus, "")
                THIS.this_cUsuario            = TratarNulo(usuars, "")
                THIS.this_nNumeroOP           = TratarNulo(nops, 0)
                THIS.this_dPrazoEntrega       = TratarNulo(prazoents, {})
                THIS.this_cCodigoMascarado    = TratarNulo(mascnum, "")
                THIS.this_cDocumento          = TratarNulo(notas, "")
                THIS.this_dData               = TratarNulo(datas, {})
                THIS.this_cObservacao         = TratarNulo(obses, "")

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega o movimento pela chave real (CidChaves).
    * SELECT * (como no legado, que abre o registro inteiro via csTemporario)
    * para que CarregarDoCursor sempre encontre as colunas que le.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigpres2BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE parcial em SigMvCab, restrito aos campos que este
    * dialogo de fato edita (Origem/Destino/Representante/Status/Prazo/
    * Documento/Data/Observacao). Equivalente ao TableUpdate() do buffer
    * otimista do framework legado: Grupo_Salva.Salva.Click do SIGPRES2 nao
    * tem SQL proprio (so DoDefault() + mAtivapagina1 - ver cabecalho do
    * arquivo), mas o buffer so envia ao SQL Server as colunas realmente
    * alteradas na tela - por isso o UPDATE aqui cobre so essas colunas,
    * nunca a linha inteira (colunas de identificacao como Emps/Dopes/Numes/
    * EmpDopNums/MascNum sao somente leitura nesta tela e ficam de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " grupoos = "   + EscaparSQL(LEFT(THIS.this_cGrupoOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = "   + EscaparSQL(LEFT(THIS.this_cContaOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = "   + EscaparSQL(LEFT(THIS.this_cGrupoDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " contads = "   + EscaparSQL(LEFT(THIS.this_cContaDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " vends = "     + EscaparSQL(LEFT(THIS.this_cRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = "   + EscaparSQL(LEFT(THIS.this_cGrupoRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = "     + EscaparSQL(LEFT(THIS.this_cTabelaDesconto, 10)) + ","
            loc_cSQL = loc_cSQL + " pstatus = "   + EscaparSQL(LEFT(THIS.this_cStatus, 1)) + ","
            loc_cSQL = loc_cSQL + " nops = "      + FormatarNumeroSQL(THIS.this_nNumeroOP, 0) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoEntrega) + ","
            loc_cSQL = loc_cSQL + " notas = "     + EscaparSQL(LEFT(THIS.this_cDocumento, 6)) + ","
            loc_cSQL = loc_cSQL + " datas = "     + FormatarDataSQL(THIS.this_dData) + ","
            loc_cSQL = loc_cSQL + " obses = "     + EscaparSQL(THIS.this_cObservacao)
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir() e ExecutarExclusao() permanecem com o comportamento herdado
    * de BusinessBase (recusar a operacao): no fonte legado do SIGPRES2 nao
    * ha Append/Delete contra SigMvCab - o dialogo so edita um registro que
    * o form pai ja havia populado em csTemporario antes de abri-lo (ver
    * cabecalho do arquivo). Este BO nunca cria nem exclui movimentos.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega os itens do movimento (grid fwgrade1/xEestI do
    * legado) em cursor_4c_Itens. Fonte: SigMvItn (a) LEFT JOIN SigMvIts (b)
    * por EmpDopNums+Cpros+CItens (mesma juncao do PROCEDURE Init legado -
    * regra #42 CLAUDE.md, nunca ALLTRIM na chave posicional). Saldo =
    * Qtds - QtBaixas ja calculado no SELECT (equivalente ao
    * Column4.ControlSource legado 'xEestI.Qtds - xEestI.QtBaixas', ramo
    * Else de montagrades - o ramo If(gcTpInstalas='V') nao foi portado:
    * essa global de configuracao nao existe na nova arquitetura, e o ramo
    * Else e o que bate com os headers estaticos do SCX/layout.json).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.qtds, a.qtprods," + ;
                " a.qtbaixas, a.qtbxprods, a.citens, a.tpesos," + ;
                " a.descvals, ISNULL(b.codtams, '') AS codtams," + ;
                " a.obs, (a.qtds - a.qtbaixas) AS saldo" + ;
                " FROM sigmvitn a" + ;
                " LEFT JOIN sigmvits b ON b.empdopnums = a.empdopnums" + ;
                " AND b.cpros = a.cpros AND b.citens = a.citens" + ;
                " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY a.citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigpres2BO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega os codigos de operacao vinculados ao
    * movimento (grid GradeOperacao/TmpOperacao do legado). Fonte: SigMvPec
    * filtrado por EmpDopNums (mesmo filtro do legado
    * CursorQuery('SigMvPec', 'TmpOperacao', 'EmpDopNums', pEdn)).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos FROM sigmvpec" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "sigpres2BO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

