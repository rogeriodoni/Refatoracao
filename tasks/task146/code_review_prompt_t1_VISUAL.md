# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGPDMP5): Top original=185 vs migrado 'cnt_4c_Origem' Top=3 (diff=182px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Destino' (parent: SIGPDMP5): Top original=261 vs migrado 'cnt_4c_Destino' Top=3 (diff=258px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPDMP5): Top original=108 vs migrado 'cnt_4c_Container1' Top=3 (diff=105px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp5.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1398 linhas total):

*-- Linhas 52 a 87:
52:     ADD OBJECT img_4c_FigJpg AS Image WITH ;
53:         Stretch = 1, Height = 238, Left = 504, Top = 121, Width = 443, ;
54:         Visible = .F.
55: 
56:     *-- Container secao Movimentacao (Container1 no legado)
57:     ADD OBJECT cnt_4c_Container1 AS Container WITH ;
58:         Top = 108, Left = 13, Width = 482, Height = 68, ;
59:         SpecialEffect = 0, BackColor = RGB(255,255,255)
60: 
61:     *-- Container dados operacao corrente (Operacao no legado)
62:     ADD OBJECT cnt_4c_Operacao AS Container WITH ;
63:         Top = 142, Left = 21, Width = 282, Height = 26, ;
64:         BackStyle = 0, BorderWidth = 0, BackColor = RGB(255,255,255)
65: 
66:     *-- Container Origem - visibilidade controlada por crSigCdOpd.Origems
67:     ADD OBJECT cnt_4c_Origem AS Container WITH ;
68:         Top = 185, Left = 12, Width = 482, Height = 68, ;
69:         SpecialEffect = 0, BackColor = RGB(255,255,255), Visible = .F.
70: 
71:     *-- Container Destino - visibilidade controlada por crSigCdOpd.Destinos
72:     ADD OBJECT cnt_4c_Destino AS Container WITH ;
73:         Top = 261, Left = 12, Width = 482, Height = 68, ;
74:         SpecialEffect = 0, BackColor = RGB(255,255,255), Visible = .F.
75: 
76:     *==========================================================================
77:     * Init - Compartilha datasession com o form pai e inicializa
78:     *==========================================================================
79:     PROCEDURE Init(par_oFormPai, par_nDtS)
80:         IF VARTYPE(par_oFormPai) = "O"
81:             THIS.this_oFormPai = par_oFormPai
82:             IF TYPE("par_oFormPai.pcEscolha") = "C"
83:                 THIS.this_cEscolha = ALLTRIM(par_oFormPai.pcEscolha)
84:             ENDIF
85:             *-- Compartilha datasession do form pai: acesso a xMFas, xPesa, crSigCdOpd, TmpNens
86:             THIS.DataSessionId = par_oFormPai.DataSessionId
87:         ENDIF

*-- Linhas 105 a 124:
105:         TRY
106:             THIS.LockScreen = .T.
107: 
108:             THIS.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
109: 
110:             IF TYPE("gc_4c_CaminhoIcones") = "C"
111:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
112:             ENDIF
113: 
114:             *-- Layout (form OPERACIONAL: plano, sem PageFrame interno)
115:             THIS.ConfigurarPageFrame()
116: 
117:             THIS.ConfigurarCabecalho()
118:             THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
119:             THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
120:             THIS.ConfigurarContainer1()
121:             THIS.ConfigurarContainerOperacao()
122:             THIS.ConfigurarContainerOrigem()
123:             THIS.ConfigurarContainerDestino()
124:             THIS.ConfigurarBotaoSair()

*-- Linhas 151 a 243:
151:         loc_cCaption = THIS.Caption
152: 
153:         WITH THIS.cnt_4c_Sombra
154:             .AddObject("lbl_4c_LblSombra", "Label")
155:             WITH .lbl_4c_LblSombra
156:                 .FontBold      = .T.
157:                 .FontName      = "Tahoma"
158:                 .FontSize      = 18
159:                 .FontUnderline = .F.
160:                 .WordWrap      = .T.
161:                 .Alignment     = 0
162:                 .BackStyle     = 0
163:                 .Caption       = loc_cCaption
164:                 .Height        = 40
165:                 .Left          = 10
166:                 .Top           = 18
167:                 .Width         = 769
168:                 .ForeColor     = RGB(0, 0, 0)
169:                 .Visible       = .T.
170:             ENDWITH
171: 
172:             .AddObject("lbl_4c_LblTitulo", "Label")
173:             WITH .lbl_4c_LblTitulo
174:                 .FontBold   = .T.
175:                 .FontName   = "Tahoma"
176:                 .FontSize   = 18
177:                 .WordWrap   = .T.
178:                 .Alignment  = 0
179:                 .BackStyle  = 0
180:                 .Caption    = loc_cCaption
181:                 .Height     = 46
182:                 .Left       = 10
183:                 .Top        = 17
184:                 .Width      = 769
185:                 .ForeColor  = RGB(255, 255, 255)
186:                 .Visible    = .T.
187:             ENDWITH
188:         ENDWITH
189: 
190:         THIS.cnt_4c_Sombra.Visible = .T.
191:     ENDPROC
192: 
193:     *==========================================================================
194:     * ConfigurarContainer1 - Titulo "Movimentacao" + linha separadora
195:     * Equivale ao Container1 do legado
196:     *==========================================================================
197:     PROTECTED PROCEDURE ConfigurarContainer1()
198:         WITH THIS.cnt_4c_Container1
199:             .AddObject("lbl_4c_TituloMov", "Label")
200:             WITH .lbl_4c_TituloMov
201:                 .FontBold  = .T.
202:                 .FontSize  = 8
203:                 .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
204:                 .Left      = 9
205:                 .Top       = 3
206:                 .AutoSize  = .T.
207:                 .BackStyle = 0
208:                 .Visible   = .T.
209:             ENDWITH
210: 
211:             .AddObject("lin_4c_LineContainer1", "Line")
212:             WITH .lin_4c_LineContainer1
213:                 .BorderWidth = 2
214:                 .Height      = 0
215:                 .Left        = 9
216:                 .Top         = 19
217:                 .Width       = 316
218:                 .BorderColor = RGB(90, 90, 90)
219:                 .Visible     = .T.
220:             ENDWITH
221:         ENDWITH
222: 
223:         THIS.cnt_4c_Container1.Visible = .T.
224:     ENDPROC
225: 
226:     *==========================================================================
227:     * ConfigurarContainerOperacao - Container dados da operacao corrente
228:     * Exibe empresa, descricao da operacao e numero do pedido (read-only)
229:     * Todos com ControlSource em TmpNens (datasession compartilhada com form pai)
230:     *==========================================================================
231:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
232:         WITH THIS.cnt_4c_Operacao
233:             *-- GetEmpresa: codigo da empresa (Left=2, Width=36)
234:             .AddObject("txt_4c_Empresa", "TextBox")
235:             WITH .txt_4c_Empresa
236:                 .ReadOnly          = .T.
237:                 .Left              = 2
238:                 .Top               = 2
239:                 .Width             = 36
240:                 .Height            = 23
241:                 .SpecialEffect     = 1
242:                 .ForeColor         = RGB(0, 0, 0)
243:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 250 a 259:
250:             .AddObject("txt_4c_Operacao", "TextBox")
251:             WITH .txt_4c_Operacao
252:                 .ReadOnly          = .T.
253:                 .Left              = 40
254:                 .Top               = 2
255:                 .Width             = 156
256:                 .Height            = 23
257:                 .SpecialEffect     = 1
258:                 .ForeColor         = RGB(0, 0, 0)
259:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 266 a 275:
266:             .AddObject("txt_4c_Codigo", "TextBox")
267:             WITH .txt_4c_Codigo
268:                 .ReadOnly          = .T.
269:                 .Left              = 198
270:                 .Top               = 2
271:                 .Width             = 81
272:                 .Height            = 23
273:                 .InputMask         = "9999999999"
274:                 .Format            = "L"
275:                 .SpecialEffect     = 1

*-- Linhas 289 a 361:
289:     * TextBoxes Get_grupo, Get_conta, Get_dconta adicionados nas Fases 5-6.
290:     * Visibilidade (Visible=.T./.F.) definida em CarregarDados conforme
291:     * crSigCdOpd.Origems. Permanece oculto ate o dado ser carregado.
292:     *==========================================================================
293:     PROTECTED PROCEDURE ConfigurarContainerOrigem()
294:         WITH THIS.cnt_4c_Origem
295:             .AddObject("lbl_4c_TituloOrigem", "Label")
296:             WITH .lbl_4c_TituloOrigem
297:                 .FontBold  = .T.
298:                 .FontSize  = 8
299:                 .Caption   = "Origem"
300:                 .Left      = 9
301:                 .Top       = 3
302:                 .AutoSize  = .T.
303:                 .BackStyle = 0
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             .AddObject("lin_4c_LineOrigem", "Line")
308:             WITH .lin_4c_LineOrigem
309:                 .BorderWidth = 2
310:                 .Height      = 0
311:                 .Left        = 9
312:                 .Top         = 19
313:                 .Width       = 316
314:                 .BorderColor = RGB(90, 90, 90)
315:                 .Visible     = .T.
316:             ENDWITH
317: 
318:             .AddObject("lbl_4c_LblGrupoO", "Label")
319:             WITH .lbl_4c_LblGrupoO
320:                 .FontSize  = 8
321:                 .Caption   = "Grupo"
322:                 .Left      = 9
323:                 .Top       = 22
324:                 .AutoSize  = .T.
325:                 .BackStyle = 0
326:                 .Visible   = .T.
327:             ENDWITH
328: 
329:             .AddObject("lbl_4c_LblContaO", "Label")
330:             WITH .lbl_4c_LblContaO
331:                 .FontSize  = 8
332:                 .Caption   = "Conta"
333:                 .Left      = 92
334:                 .Top       = 22
335:                 .AutoSize  = .T.
336:                 .BackStyle = 0
337:                 .Visible   = .T.
338:             ENDWITH
339: 
340:             .AddObject("lbl_4c_LblNomeO", "Label")
341:             WITH .lbl_4c_LblNomeO
342:                 .FontSize  = 8
343:                 .Caption   = "Nome"
344:                 .Left      = 175
345:                 .Top       = 22
346:                 .AutoSize  = .T.
347:                 .BackStyle = 0
348:                 .Visible   = .T.
349:             ENDWITH
350: 
351:             *-- txt_4c_GrupoO: grupo de origem (ControlSource = tmpnens.grupoos)
352:             .AddObject("txt_4c_GrupoO", "TextBox")
353:             WITH .txt_4c_GrupoO
354:                 .ReadOnly          = .T.
355:                 .Left              = 9
356:                 .Top               = 36
357:                 .Width             = 80
358:                 .Height            = 20
359:                 .SpecialEffect     = 1
360:                 .ForeColor         = RGB(0, 0, 0)
361:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 368 a 377:
368:             .AddObject("txt_4c_ContaO", "TextBox")
369:             WITH .txt_4c_ContaO
370:                 .ReadOnly          = .T.
371:                 .Left              = 92
372:                 .Top               = 36
373:                 .Width             = 80
374:                 .Height            = 20
375:                 .SpecialEffect     = 1
376:                 .ForeColor         = RGB(0, 0, 0)
377:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 384 a 393:
384:             .AddObject("txt_4c_Dconta", "TextBox")
385:             WITH .txt_4c_Dconta
386:                 .ReadOnly          = .T.
387:                 .Left              = 175
388:                 .Top               = 36
389:                 .Width             = 302
390:                 .Height            = 23
391:                 .SpecialEffect     = 1
392:                 .ForeColor         = RGB(0, 0, 0)
393:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 402 a 474:
402:     * ConfigurarContainerDestino - Labels do container Destino
403:     * TextBoxes Get_grupo, Get_conta, Get_dconta adicionados nas Fases 5-6.
404:     * Visibilidade definida em CarregarDados conforme crSigCdOpd.Destinos.
405:     *==========================================================================
406:     PROTECTED PROCEDURE ConfigurarContainerDestino()
407:         WITH THIS.cnt_4c_Destino
408:             .AddObject("lbl_4c_TituloDestino", "Label")
409:             WITH .lbl_4c_TituloDestino
410:                 .FontBold  = .T.
411:                 .FontSize  = 8
412:                 .Caption   = "Destino"
413:                 .Left      = 9
414:                 .Top       = 3
415:                 .AutoSize  = .T.
416:                 .BackStyle = 0
417:                 .Visible   = .T.
418:             ENDWITH
419: 
420:             .AddObject("lin_4c_LineDestino", "Line")
421:             WITH .lin_4c_LineDestino
422:                 .BorderWidth = 2
423:                 .Height      = 0
424:                 .Left        = 9
425:                 .Top         = 19
426:                 .Width       = 318
427:                 .BorderColor = RGB(90, 90, 90)
428:                 .Visible     = .T.
429:             ENDWITH
430: 
431:             .AddObject("lbl_4c_LblGrupoD", "Label")
432:             WITH .lbl_4c_LblGrupoD
433:                 .FontSize  = 8
434:                 .Caption   = "Grupo"
435:                 .Left      = 9
436:                 .Top       = 22
437:                 .AutoSize  = .T.
438:                 .BackStyle = 0
439:                 .Visible   = .T.
440:             ENDWITH
441: 
442:             .AddObject("lbl_4c_LblContaD", "Label")
443:             WITH .lbl_4c_LblContaD
444:                 .FontSize  = 8
445:                 .Caption   = "Conta"
446:                 .Left      = 92
447:                 .Top       = 22
448:                 .AutoSize  = .T.
449:                 .BackStyle = 0
450:                 .Visible   = .T.
451:             ENDWITH
452: 
453:             .AddObject("lbl_4c_LblNomeD", "Label")
454:             WITH .lbl_4c_LblNomeD
455:                 .FontSize  = 8
456:                 .Caption   = "Nome"
457:                 .Left      = 175
458:                 .Top       = 22
459:                 .AutoSize  = .T.
460:                 .BackStyle = 0
461:                 .Visible   = .T.
462:             ENDWITH
463: 
464:             *-- txt_4c_GrupoD: grupo de destino (ControlSource = tmpnens.grupods)
465:             .AddObject("txt_4c_GrupoD", "TextBox")
466:             WITH .txt_4c_GrupoD
467:                 .ReadOnly          = .T.
468:                 .Left              = 9
469:                 .Top               = 36
470:                 .Width             = 80
471:                 .Height            = 20
472:                 .SpecialEffect     = 1
473:                 .ForeColor         = RGB(0, 0, 0)
474:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 481 a 490:
481:             .AddObject("txt_4c_ContaD", "TextBox")
482:             WITH .txt_4c_ContaD
483:                 .ReadOnly          = .T.
484:                 .Left              = 92
485:                 .Top               = 36
486:                 .Width             = 80
487:                 .Height            = 20
488:                 .SpecialEffect     = 1
489:                 .ForeColor         = RGB(0, 0, 0)
490:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 497 a 506:
497:             .AddObject("txt_4c_Dconta", "TextBox")
498:             WITH .txt_4c_Dconta
499:                 .ReadOnly          = .T.
500:                 .Left              = 175
501:                 .Top               = 36
502:                 .Width             = 302
503:                 .Height            = 23
504:                 .SpecialEffect     = 1
505:                 .ForeColor         = RGB(0, 0, 0)
506:                 .DisabledBackColor = RGB(255, 255, 255)

*-- Linhas 517 a 531:
517:     * Click event adicionado nas Fases 7-8
518:     *==========================================================================
519:     PROTECTED PROCEDURE ConfigurarBotaoSair()
520:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
521:         WITH THIS.cmd_4c_Ok
522:             .Top             = 3
523:             .Left            = 925
524:             .Width           = 75
525:             .Height          = 75
526:             .Caption         = "Sair"
527:             .Cancel          = .T.
528:             .FontName        = "Tahoma"
529:             .FontBold        = .T.
530:             .FontItalic      = .T.
531:             .FontSize        = 8

*-- Linhas 542 a 576:
542:             ENDIF
543:             .Visible = .T.
544:         ENDWITH
545:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
546:     ENDPROC
547: 
548:     *==========================================================================
549:     * TornarControlesVisiveis - Torna controles do container visiveis
550:     * IMPORTANTE: cnt_4c_Origem e cnt_4c_Destino sao containers flutuantes
551:     * cuja visibilidade e definida por CarregarDados conforme crSigCdOpd
552:     *==========================================================================
553:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
554:         LOCAL loc_i, loc_oControl
555:         IF VARTYPE(par_oContainer) <> "O"
556:             RETURN
557:         ENDIF
558:         FOR loc_i = 1 TO par_oContainer.ControlCount
559:             loc_oControl = par_oContainer.Controls(loc_i)
560:             IF UPPER(loc_oControl.Name) = "CNT_4C_ORIGEM" OR ;
561:                UPPER(loc_oControl.Name) = "CNT_4C_DESTINO"
562:                 LOOP
563:             ENDIF
564:             loc_oControl.Visible = .T.
565:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
566:                 THIS.TornarControlesVisiveis(loc_oControl)
567:             ENDIF
568:         ENDFOR
569:     ENDPROC
570: 
571:     *==========================================================================
572:     * ConfigurarPageFrame - Form OPERACIONAL: layout plano, sem PageFrame.
573:     * SIGPDMP5 original herda de `form` generico (NAO frmcadastro) e usa
574:     * Width=1000, Height=600, TitleBar=0 com Grade, containers Origem/Destino
575:     * e Operacao ancorados diretamente no form. Mantemos este metodo para
576:     * conformidade com a pipeline de migracao e como ponto de extensao.

*-- Linhas 596 a 605:
596:         loc_oGrid = THIS.grd_4c_Dados
597: 
598:         WITH loc_oGrid
599:             .Top               = 338
600:             .Left              = 12
601:             .Height            = 198
602:             .Width             = 482
603:             .ColumnCount       = 5
604:             .AllowHeaderSizing = .F.
605:             .HeaderHeight      = 16

*-- Linhas 616 a 624:
616:                 .FontName  = "Arial"
617:                 .InputMask = "9999999999"
618:                 WITH .Header1
619:                     .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
620:                     .FontName  = "Tahoma"
621:                     .FontSize  = 8
622:                     .Alignment = 2
623:                 ENDWITH
624:                 WITH .Text1

*-- Linhas 640 a 648:
640:                 .Format     = "KLZ"
641:                 .InputMask  = "9999999999"
642:                 WITH .Header1
643:                     .Caption   = "Pedido"
644:                     .FontName  = "Tahoma"
645:                     .FontSize  = 8
646:                     .Alignment = 2
647:                 ENDWITH
648:                 WITH .Text1

*-- Linhas 665 a 673:
665:                 .ReadOnly    = .T.
666:                 .InputMask   = "999,999.999"
667:                 WITH .Header1
668:                     .Caption   = "Quantidade"
669:                     .FontName  = "Tahoma"
670:                     .FontSize  = 8
671:                     .Alignment = 2
672:                 ENDWITH
673:                 WITH .Text1

*-- Linhas 686 a 694:
686:                 .Resizable   = .F.
687:                 .ReadOnly    = .T.
688:                 WITH .Header1
689:                     .Caption   = "Produto"
690:                     .FontName  = "Tahoma"
691:                     .FontSize  = 8
692:                     .Alignment = 2
693:                 ENDWITH
694:                 WITH .Text1

*-- Linhas 709 a 717:
709:                 .ReadOnly    = .T.
710:                 .InputMask   = "99999"
711:                 WITH .Header1
712:                     .Caption   = "Tempo/min"
713:                     .FontName  = "Tahoma"
714:                     .FontSize  = 8
715:                     .Alignment = 2
716:                 ENDWITH
717:                 WITH .Text1

*-- Linhas 733 a 772:
733:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GrdColumn5KeyPress")
734: 
735:         *-- Label "Descricao :" (Say2 no legado - Top=368, Left=503)
736:         THIS.AddObject("lbl_4c_LblDescricao", "Label")
737:         WITH THIS.lbl_4c_LblDescricao
738:             .FontSize  = 8
739:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
740:             .Left      = 503
741:             .Top       = 368
742:             .AutoSize  = .T.
743:             .BackStyle = 0
744:             .ForeColor = RGB(0,0,0)
745:             .Visible   = .T.
746:         ENDWITH
747: 
748:         *-- Label "Observacao :" (Say3 no legado - Top=414, Left=503)
749:         THIS.AddObject("lbl_4c_LblObservacao", "Label")
750:         WITH THIS.lbl_4c_LblObservacao
751:             .FontSize  = 8
752:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
753:             .Left      = 503
754:             .Top       = 414
755:             .AutoSize  = .T.
756:             .BackStyle = 0
757:             .ForeColor = RGB(0,0,0)
758:             .Visible   = .T.
759:         ENDWITH
760: 
761:         *-- TextBox descricao do produto - read-only, preenchido em GrdDadosAfterRowColChange
762:         THIS.AddObject("txt_4c_Descr", "TextBox")
763:         WITH THIS.txt_4c_Descr
764:             .FontSize    = 8
765:             .Height      = 23
766:             .Left        = 503
767:             .Top         = 384
768:             .Width       = 484
769:             .ForeColor   = RGB(0,0,0)
770:             .ReadOnly    = .T.
771:             .Value       = ""
772:             .BackColor   = RGB(255,255,255)

*-- Linhas 778 a 787:
778:         WITH THIS.edit_4c_MmObs
779:             .FontSize      = 8
780:             .Height        = 106
781:             .Left          = 503
782:             .Top           = 430
783:             .Width         = 484
784:             .ForeColor     = RGB(0,0,0)
785:             .ReadOnly      = .T.
786:             .ControlSource = "xmfas.obsps"
787:             .Visible       = .T.

*-- Linhas 794 a 805:
794:             .FontSize          = 8
795:             .Height            = 21
796:             .InputMask         = "999,999.999"
797:             .Left              = 312
798:             .MaxLength         = 11
799:             .ReadOnly          = .T.
800:             .Top               = 538
801:             .Width             = 90
802:             .Value             = 0
803:             .ForeColor         = RGB(0,0,0)
804:             .DisabledBackColor = RGB(255,255,255)
805:             .DisabledForeColor = RGB(0,0,128)

*-- Linhas 865 a 951:
865:             *-- Header Column2: titulo do form pai (ex: "Pedido", "NF", etc.)
866:             IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
867:                TYPE("THIS.this_oFormPai.Titulo") = "C"
868:                 loc_oGrid.Column2.Header1.Caption = THIS.this_oFormPai.Titulo
869:             ENDIF
870: 
871:             *-- Redefine headers apos RecordSource (obrigatorio - VFP reseta)
872:             loc_oGrid.Column1.Header1.Caption = "Industrializa" + CHR(231) + CHR(227) + "o"
873:             loc_oGrid.Column3.Header1.Caption = "Quantidade"
874:             loc_oGrid.Column4.Header1.Caption = "Produto"
875:             loc_oGrid.Column5.Header1.Caption = "Tempo/min"
876: 
877:             *-- Total de quantidade (Sum de todos os registros de xMFas)
878:             SELECT xMFas
879:             GO TOP
880:             SUM Qtds TO loc_nTotQt
881:             IF PEMSTATUS(THIS, "txt_4c_TotQt", 5)
882:                 THIS.txt_4c_TotQt.Value = NVL(loc_nTotQt, 0)
883:                 THIS.txt_4c_TotQt.Refresh()
884:             ENDIF
885:             GO TOP
886: 
887:             *-- Visibilidade de Origem/Destino conforme operacao corrente
888:             IF USED("crSigCdOpd") AND !EOF("crSigCdOpd")
889:                 THIS.cnt_4c_Origem.Visible  = crSigCdOpd.Origems
890:                 THIS.cnt_4c_Destino.Visible = crSigCdOpd.Destinos
891: 
892:                 *-- Column5 editavel: INSERIR/ALTERAR + TipoSubNivel=ENV + apontas=1
893:                 loc_lEditCol5 = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
894:                 IF loc_lEditCol5
895:                     IF VARTYPE(THIS.this_oFormPai) = "O" AND ;
896:                        PEMSTATUS(THIS.this_oFormPai, "TipoSubNivel", 5)
897:                         loc_lEditCol5 = ALLTRIM(THIS.this_oFormPai.TipoSubNivel) = "ENV"
898:                     ELSE
899:                         loc_lEditCol5 = .F.
900:                     ENDIF
901:                 ENDIF
902:                 IF loc_lEditCol5
903:                     loc_lEditCol5 = crSigCdOpd.apontas
904:                 ENDIF
905:                 loc_oGrid.Column5.ReadOnly = !loc_lEditCol5
906:             ENDIF
907: 
908:             *-- Preenche nome de Origem (SigCdCli por IClis = TmpNens.Contaos)
909:             IF USED("TmpNens") AND !EOF("TmpNens") AND THIS.cnt_4c_Origem.Visible
910:                 IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
911:                     IF USED("cursor_4c_CliO")
912:                         USE IN cursor_4c_CliO
913:                     ENDIF
914:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
915:                                FormatarNumeroSQL(TmpNens.Contaos)
916:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliO") > 0 AND ;
917:                        USED("cursor_4c_CliO") AND !EOF("cursor_4c_CliO")
918:                         THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_CliO.RClis, ""))
919:                     ENDIF
920:                     IF USED("cursor_4c_CliO")
921:                         USE IN cursor_4c_CliO
922:                     ENDIF
923:                 ENDIF
924:             ENDIF
925: 
926:             *-- Preenche nome de Destino (SigCdCli por IClis = TmpNens.Contads)
927:             IF USED("TmpNens") AND !EOF("TmpNens") AND THIS.cnt_4c_Destino.Visible
928:                 IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
929:                     IF USED("cursor_4c_CliD")
930:                         USE IN cursor_4c_CliD
931:                     ENDIF
932:                     loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
933:                                FormatarNumeroSQL(TmpNens.Contads)
934:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliD") > 0 AND ;
935:                        USED("cursor_4c_CliD") AND !EOF("cursor_4c_CliD")
936:                         THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_CliD.RClis, ""))
937:                     ENDIF
938:                     IF USED("cursor_4c_CliD")
939:                         USE IN cursor_4c_CliD
940:                     ENDIF
941:                 ENDIF
942:             ENDIF
943: 
944:             THIS.FormatarGridDados(loc_oGrid)
945: 
946:             IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
947:                 THIS.txt_4c_Descr.Value = ""
948:             ENDIF
949: 
950:             SELECT xMFas
951:             loc_oGrid.SetFocus()

*-- Linhas 1054 a 1063:
1054:     * visita ao pressionar Tab apos editar Tempo/min.
1055:     *==========================================================================
1056:     PROCEDURE GrdColumn5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1057:         IF par_nKeyCode = 9 AND PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1058:             THIS.cmd_4c_Ok.SetFocus()
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *==========================================================================
1063:     * FormatarGridDados - Formata visual da grade

*-- Linhas 1133 a 1143:
1133:     PROCEDURE AjustarBotoesPorModo()
1134:         LOCAL loc_lSomenteLeitura
1135: 
1136:         *-- cmd_4c_Ok (Sair) permanece sempre habilitado
1137:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1138:             THIS.cmd_4c_Ok.Enabled = .T.
1139:         ENDIF
1140: 
1141:         *-- Column5 (Tempo/min): editavel somente em INSERIR/ALTERAR + ENV + apontas=1
1142:         loc_lSomenteLeitura = .T.
1143:         IF INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")

*-- Linhas 1171 a 1214:
1171:         IF PEMSTATUS(THIS, "edit_4c_MmObs", 5)
1172:             THIS.edit_4c_MmObs.ReadOnly = .T.
1173:         ENDIF
1174: 
1175:         *-- Containers Origem/Destino: campos internos sempre read-only
1176:         IF PEMSTATUS(THIS, "cnt_4c_Origem", 5)
1177:             WITH THIS.cnt_4c_Origem
1178:                 IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_GrupoO", 5)
1179:                     THIS.cnt_4c_Origem.txt_4c_GrupoO.ReadOnly = .T.
1180:                 ENDIF
1181:                 IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_ContaO", 5)
1182:                     THIS.cnt_4c_Origem.txt_4c_ContaO.ReadOnly = .T.
1183:                 ENDIF
1184:                 IF PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
1185:                     THIS.cnt_4c_Origem.txt_4c_Dconta.ReadOnly = .T.
1186:                 ENDIF
1187:                 .Visible     = .T.
1188:             ENDWITH
1189:         ENDIF
1190: 
1191:         IF PEMSTATUS(THIS, "cnt_4c_Destino", 5)
1192:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_GrupoD", 5)
1193:                 THIS.cnt_4c_Destino.txt_4c_GrupoD.ReadOnly = .T.
1194:             ENDIF
1195:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_ContaD", 5)
1196:                 THIS.cnt_4c_Destino.txt_4c_ContaD.ReadOnly = .T.
1197:             ENDIF
1198:             IF PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
1199:                 THIS.cnt_4c_Destino.txt_4c_Dconta.ReadOnly = .T.
1200:             ENDIF
1201:         ENDIF
1202: 
1203:         *-- Column5 depende do modo (delegado para AjustarBotoesPorModo)
1204:         THIS.AjustarBotoesPorModo()
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * LimparCampos - Limpa campos de exibicao (nao afeta cursores do form pai)
1209:     * Os cursores xMFas/xPesa/TmpNens/crSigCdOpd sao gerenciados pelo form pai
1210:     *==========================================================================
1211:     PROCEDURE LimparCampos()
1212:         IF PEMSTATUS(THIS, "txt_4c_Descr", 5)
1213:             THIS.txt_4c_Descr.Value = ""
1214:         ENDIF

*-- Linhas 1281 a 1319:
1281:             THIS.txt_4c_TotQt.Value = THIS.this_oBusinessObject.this_nTotQt
1282:             THIS.txt_4c_TotQt.Refresh()
1283:         ENDIF
1284: 
1285:         *-- Nome da conta de origem
1286:         IF PEMSTATUS(THIS, "cnt_4c_Origem", 5) AND ;
1287:            PEMSTATUS(THIS.cnt_4c_Origem, "txt_4c_Dconta", 5)
1288:             THIS.cnt_4c_Origem.txt_4c_Dconta.Value = ;
1289:                 THIS.this_oBusinessObject.this_cDcontaOs
1290:         ENDIF
1291: 
1292:         *-- Nome da conta de destino
1293:         IF PEMSTATUS(THIS, "cnt_4c_Destino", 5) AND ;
1294:            PEMSTATUS(THIS.cnt_4c_Destino, "txt_4c_Dconta", 5)
1295:             THIS.cnt_4c_Destino.txt_4c_Dconta.Value = ;
1296:                 THIS.this_oBusinessObject.this_cDcontaDs
1297:         ENDIF
1298: 
1299:         *-- Visibilidade de Origem/Destino conforme flags do BO
1300:         IF PEMSTATUS(THIS, "cnt_4c_Origem", 5)
1301:             THIS.cnt_4c_Origem.Visible = (THIS.this_oBusinessObject.this_nOrigems = 1)
1302:         ENDIF
1303:         IF PEMSTATUS(THIS, "cnt_4c_Destino", 5)
1304:             THIS.cnt_4c_Destino.Visible = (THIS.this_oBusinessObject.this_nDestinos = 1)
1305:         ENDIF
1306:     ENDPROC
1307: 
1308:     *==========================================================================
1309:     * BtnBuscarClick - Recarrega o grid com dados atuais do cursor xMFas
1310:     * Equivalente a pressionar F5 em forms CRUD; aqui: refresh da grade
1311:     *==========================================================================
1312:     PROCEDURE BtnBuscarClick()
1313:         THIS.FormParaBO()
1314:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1315:             THIS.this_oBusinessObject.CalcularTotalQtds("xMFas")
1316:         ENDIF
1317:         THIS.CarregarGrade()
1318:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1319:             THIS.grd_4c_Dados.SetFocus()


### BO (C:\4c\projeto\app\classes\SigPdMp5BO.prg):
*==============================================================================
* SigPdMp5BO.prg - Business Object para Movimenta" + CHR(231) + CHR(227) + "o (OPERACIONAL)
* Data: 2026-06-19
* Form auxiliar (sub-dialog) aberto pelo form pai de movimenta" + CHR(231) + CHR(227) + "o de produ" + CHR(231) + CHR(227) + "o.
* Cursor principal: xMFas (grid de linhas de fabrica" + CHR(231) + CHR(227) + "o)
* Cursores auxiliares: xPesa, crSigCdOpd, crSigCdPro, crSigCdCli, TmpNens
*==============================================================================

DEFINE CLASS SigPdMp5BO AS BusinessBase

    *-- Linha selecionada no grid (xMFas)
    this_nNops    = 0     && xMfas.Nops     - N" + CHR(250) + "mero da industrializa" + CHR(231) + CHR(227) + "o (PK da linha)
    this_nNenvs   = 0     && xMfas.Nenvs    - N" + CHR(250) + "mero do pedido/envio
    this_nQtds    = 0     && xMfas.Qtds     - Quantidade
    this_cCodPds  = ""    && xMfas.CodPds   - C" + CHR(243) + "digo do produto
    this_nTmpMins = 0     && xMfas.TmpMins  - Tempo em minutos
    this_cObsps   = ""    && xMfas.obsps    - Observa" + CHR(231) + CHR(227) + "o da linha

    *-- Opera" + CHR(231) + CHR(227) + "o corrente (cursor TmpNens - container Opera" + CHR(231) + CHR(227) + "o)
    this_cEmps   = ""     && tmpnens.emps   - Empresa
    this_cDopps  = ""     && tmpnens.dopps  - Descri" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + CHR(227) + "o
    this_nNumps  = 0      && tmpnens.numps  - N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o

    *-- Contas de origem (cursor TmpNens - container Origem)
    this_cGrupoos = ""    && tmpnens.grupoos - Grupo da conta de origem
    this_cContaos = ""    && tmpnens.contaos - Conta de origem

    *-- Contas de destino (cursor TmpNens - container Destino)
    this_cGrupods = ""    && tmpnens.grupods - Grupo da conta de destino
    this_cContads = ""    && tmpnens.contads - Conta de destino

    *-- Valores derivados/display (n" + CHR(227) + "o persistidos)
    this_cDcontaOs = ""   && crSigCdCli.Rclis para conta de origem
    this_cDcontaDs = ""   && crSigCdCli.Rclis para conta de destino
    this_cDpros    = ""   && crSigCdPro.Dpros  - Descri" + CHR(231) + CHR(227) + "o do produto
    this_cFigJpgs  = ""   && crSigCdPro.FigJpgs - Figura base64 do produto
    this_nTotQt    = 0    && Soma de xMfas.Qtds (exibida em TotQt)

    *-- Flags de estado derivados de crSigCdOpd
    this_nImagems  = 0    && crSigCdOpd.Imagems  - Exibir imagem do produto (0/1)
    this_nOrigems  = 0    && crSigCdOpd.Origems  - Exibir container Origem (0/1)
    this_nDestinos = 0    && crSigCdOpd.Destinos - Exibir container Destino (0/1)
    this_nApontas  = 0    && crSigCdOpd.apontas  - Column5 (TmpMins) edit" + CHR(225) + "vel (0/1)

    *-- Contexto do form pai
    this_cPcEscolha    = ""  && pcEscolha do form pai (INSERIR/ALTERAR/VISUALIZAR)
    this_cTipoSubNivel = ""  && TipoSubNivel do form pai (ex: 'ENV')

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega linha selecionada do grid (xMFas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nNops    = TratarNulo(Nops,    "N")
                THIS.this_nNenvs   = TratarNulo(Nenvs,   "N")
                THIS.this_nQtds    = TratarNulo(Qtds,    "N")
                THIS.this_cCodPds  = TratarNulo(CodPds,  "C")
                THIS.this_nTmpMins = TratarNulo(TmpMins, "N")
                THIS.this_cObsps   = TratarNulo(obsps,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar linha do grid:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacao - Carrega dados de opera" + CHR(231) + CHR(227) + "o do cursor TmpNens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacao(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps   = TratarNulo(emps,   "C")
                THIS.this_cDopps  = TratarNulo(dopps,  "C")
                THIS.this_nNumps  = TratarNulo(numps,  "N")
                THIS.this_cGrupoos = TratarNulo(grupoos, "C")
                THIS.this_cContaos = TratarNulo(contaos, "C")
                THIS.this_cGrupods = TratarNulo(grupods, "C")
                THIS.this_cContads = TratarNulo(contads, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFlagsOperacao - Carrega flags de visibilidade do crSigCdOpd
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFlagsOperacao(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF VARTYPE(Imagems) = "N"
                    THIS.this_nImagems = NVL(Imagems, 0)
                ELSE
                    THIS.this_nImagems = IIF(NVL(Imagems, .F.), 1, 0)
                ENDIF
                IF VARTYPE(Origems) = "N"
                    THIS.this_nOrigems = NVL(Origems, 0)
                ELSE
                    THIS.this_nOrigems = IIF(NVL(Origems, .F.), 1, 0)
                ENDIF
                IF VARTYPE(Destinos) = "N"
                    THIS.this_nDestinos = NVL(Destinos, 0)
                ELSE
                    THIS.this_nDestinos = IIF(NVL(Destinos, .F.), 1, 0)
                ENDIF
                IF VARTYPE(apontas) = "N"
                    THIS.this_nApontas = NVL(apontas, 0)
                ELSE
                    THIS.this_nApontas = IIF(NVL(apontas, .F.), 1, 0)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar flags:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CarregarFlagsOperacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoProduto - Busca descri" + CHR(231) + CHR(227) + "o e imagem do produto via SQLEXEC
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDescricaoProduto(par_cCodPds)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDpros   = ""
            THIS.this_cFigJpgs = ""

            IF EMPTY(par_cCodPds)
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "SELECT DPros, FigJpgs FROM SigCdPro" + ;
                       " WHERE CPros = " + EscaparSQL(par_cCodPds)

            IF USED("cursor_4c_ProdInfo")
                USE IN cursor_4c_ProdInfo
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")

            IF loc_nRet > 0 AND !EOF("cursor_4c_ProdInfo")
                SELECT cursor_4c_ProdInfo
                THIS.this_cDpros   = TratarNulo(DPros,   "C")
                THIS.this_cFigJpgs = TratarNulo(FigJpgs, "C")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ProdInfo")
                USE IN cursor_4c_ProdInfo
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar produto:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.BuscarDescricaoProduto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNomeConta - Busca raz" + CHR(227) + "o social do cliente/conta via SQLEXEC
    * par_cContaId: c" + CHR(243) + "digo da conta (IClis)
    * par_cTipo: "O" para Origem, "D" para Destino
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNomeConta(par_cContaId, par_cTipo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cNome
        loc_lSucesso = .F.

        TRY
            loc_cNome = ""

            IF !EMPTY(par_cContaId)
                loc_cSQL = "SELECT RClis FROM SigCdCli" + ;
                           " WHERE IClis = " + EscaparSQL(par_cContaId)

                IF USED("cursor_4c_ContaInfo")
                    USE IN cursor_4c_ContaInfo
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaInfo")

                IF loc_nRet > 0 AND !EOF("cursor_4c_ContaInfo")
                    SELECT cursor_4c_ContaInfo
                    loc_cNome = TratarNulo(RClis, "C")
                ENDIF

                IF USED("cursor_4c_ContaInfo")
                    USE IN cursor_4c_ContaInfo
                ENDIF
            ENDIF

            IF UPPER(par_cTipo) = "O"
                THIS.this_cDcontaOs = loc_cNome
            ELSE
                THIS.this_cDcontaDs = loc_cNome
            ENDIF
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar conta:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.BuscarNomeConta")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularTotalQtds - Soma Qtds do cursor xMFas e armazena em this_nTotQt
    *--------------------------------------------------------------------------
    PROCEDURE CalcularTotalQtds(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_nTotal
        loc_lSucesso = .F.

        TRY
            loc_nTotal = 0

            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                SUM Qtds TO loc_nTotal
                THIS.this_nTotQt = loc_nTotal
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao calcular total:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.CalcularTotalQtds")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarQtdPesa - Atualiza Qtds em xPesa para o Nops corrente
    * Replicado do legado: SEEK(xMFas.Nops, 'xPesa', 'Nops') + REPLACE Qtds
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarQtdPesa(par_nNops, par_nQtds)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("xPesa")
                IF SEEK(par_nNops, "xPesa", "Nops")
                    REPLACE xPesa.Qtds WITH par_nQtds IN xPesa
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar pesagem:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.AtualizarQtdPesa")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave da linha atual (Nops)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNops)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de aplicar altera" + CHR(231) + CHR(245) + "es no cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF THIS.this_nQtds < 0
            THIS.this_cErro = "Quantidade n" + CHR(227) + "o pode ser negativa."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - N" + CHR(227) + "o aplic" + CHR(225) + "vel neste sub-dialog.
    * As linhas de xMFas s" + CHR(227) + "o pr" + CHR(233) + "-carregadas pelo form pai; este dialog
    * apenas exibe e permite edi" + CHR(231) + CHR(227) + "o de Qtds/TmpMins. A persist" + CHR(234) + "ncia
    * no SQL Server " + CHR(233) + " responsabilidade do form pai ao fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF
            THIS.RegistrarAuditoria("I")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao registrar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Sincroniza xPesa com a quantidade editada em xMFas
    * Replicado da l" + CHR(243) + "gica do legado: Column3.Text1.Valid fazia SEEK+REPLACE
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.AtualizarQtdPesa(THIS.this_nNops, THIS.this_nQtds)

            IF loc_lSucesso
                THIS.RegistrarAuditoria("A")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar quantidade:" + CHR(13) + loc_oErro.Message, "SigPdMp5BO.Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

