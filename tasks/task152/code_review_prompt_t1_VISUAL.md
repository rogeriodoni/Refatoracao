# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Rodape define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Rodape.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPDPNS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1004 linhas total):

*-- Linhas 111 a 145:
111:                         *-- Inicializar exibicao do rodape com o primeiro registro
112:                         *-- (replicando logica original do SelecionaDados apos carga)
113:                         IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
114:                             SELECT cursor_4c_Grade
115:                             GO TOP
116:                             THIS.grd_4c_Rodape.Column1.Text1.Value = ;
117:                                 "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
118:                             THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
119:                             THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
120:                         ENDIF
121: 
122:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
123:                             THIS.grd_4c_Dados.Refresh()
124:                         ENDIF
125:                         IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
126:                             THIS.grd_4c_Rodape.Refresh()
127:                         ENDIF
128:                         *-- Focar na primeira coluna do grid principal
129:                         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
130:                             THIS.grd_4c_Dados.Column1.SetFocus()
131:                         ENDIF
132:                     ENDIF
133:                 ENDIF
134: 
135:                 loc_lSucesso = .T.
136:             ENDIF
137: 
138:         CATCH TO loc_oErro
139:             THIS.this_cMensagemErro = loc_oErro.Message
140:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
141:         ENDTRY
142: 
143:         RETURN loc_lSucesso
144:     ENDPROC
145: 

*-- Linhas 185 a 233:
185:     PROTECTED PROCEDURE ConfigurarPageFrame()
186:         THIS.AddObject("cnt_4c_Sombra", "Container")
187:         WITH THIS.cnt_4c_Sombra
188:             .Top         = 0
189:             .Left        = 0
190:             .Width       = THIS.Width
191:             .Height      = 80
192:             .BackColor   = RGB(100, 100, 100)
193:             .BackStyle   = 1
194:             .BorderWidth = 0
195:             .Visible     = .T.
196: 
197:             .AddObject("lbl_4c_LblSombra", "Label")
198:             WITH .lbl_4c_LblSombra
199:                 .Top           = 25
200:                 .Left          = 10
201:                 .Width         = THIS.Width
202:                 .Height        = 40
203:                 .FontBold      = .T.
204:                 .FontName      = "Tahoma"
205:                 .FontSize      = 18
206:                 .FontUnderline = .F.
207:                 .BackStyle     = 0
208:                 .WordWrap      = .T.
209:                 .Alignment     = 0
210:                 .ForeColor     = RGB(0, 0, 0)
211:                 .Caption       = "Pendentes"
212:                 .Visible       = .T.
213:             ENDWITH
214: 
215:             .AddObject("lbl_4c_LblTitulo", "Label")
216:             WITH .lbl_4c_LblTitulo
217:                 .Top       = 24
218:                 .Left      = 10
219:                 .Width     = THIS.Width
220:                 .Height    = 46
221:                 .FontBold  = .T.
222:                 .FontName  = "Tahoma"
223:                 .FontSize  = 18
224:                 .BackStyle = 0
225:                 .WordWrap  = .T.
226:                 .Alignment = 0
227:                 .ForeColor = RGB(255, 255, 255)
228:                 .Caption   = "Pendentes"
229:                 .Visible   = .T.
230:             ENDWITH
231:         ENDWITH
232:     ENDPROC
233: 

*-- Linhas 249 a 263:
249:     * Cancel=.T. conforme original (ESC fecha o form)
250:     *==========================================================================
251:     PROTECTED PROCEDURE ConfigurarBotaoEncerrar()
252:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
253:         WITH THIS.cmd_4c_Encerrar
254:             .Top             = 3
255:             .Left            = 917
256:             .Height          = 75
257:             .Width           = 75
258:             .Caption         = "Encerrar"
259:             .Cancel          = .T.
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
261:             .FontName        = "Tahoma"
262:             .FontSize        = 8
263:             .FontBold        = .T.

*-- Linhas 281 a 302:
281:     * Colunas em Courier New conforme legado (monospace para alinhamento numerico)
282:     *==========================================================================
283:     PROTECTED PROCEDURE ConfigurarGridDados()
284:         LOCAL loc_nI, loc_cCol
285: 
286:         THIS.AddObject("grd_4c_Dados", "Grid")
287:         WITH THIS.grd_4c_Dados
288:             .Top               = 153
289:             .Left              = 17
290:             .Width             = 885
291:             .Height            = 340
292:             .ColumnCount       = 8
293:             .RecordSource      = "cursor_4c_Grade"
294:             .DeleteMark        = .F.
295:             .RecordMark        = .F.
296:             .ReadOnly          = .T.
297:             .ScrollBars        = 2
298:             .AllowHeaderSizing = .F.
299:             .AllowRowSizing    = .F.
300:             .HeaderHeight      = 17
301:             .GridLineColor     = RGB(238, 238, 238)
302:             .FontName          = "Tahoma"

*-- Linhas 315 a 323:
315:             .Column1.Text1.ReadOnly  = .T.
316:             .Column1.Text1.ForeColor = RGB(0, 0, 0)
317:             .Column1.Text1.BackColor = RGB(255, 255, 255)
318:             .Column1.Header1.Caption   = "Emp"
319:             .Column1.Header1.FontName  = "Tahoma"
320:             .Column1.Header1.FontSize  = 8
321:             .Column1.Header1.Alignment = 2
322:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
323: 

*-- Linhas 334 a 342:
334:             .Column2.Text1.ReadOnly  = .T.
335:             .Column2.Text1.ForeColor = RGB(0, 0, 0)
336:             .Column2.Text1.BackColor = RGB(255, 255, 255)
337:             .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
338:             .Column2.Header1.FontName  = "Tahoma"
339:             .Column2.Header1.FontSize  = 8
340:             .Column2.Header1.Alignment = 2
341:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
342: 

*-- Linhas 353 a 361:
353:             .Column3.Text1.Margin    = 0
354:             .Column3.Text1.ForeColor = RGB(0, 0, 0)
355:             .Column3.Text1.BackColor = RGB(255, 255, 255)
356:             .Column3.Header1.Caption   = CHR(67) + CHR(243) + "digo"
357:             .Column3.Header1.FontName  = "Tahoma"
358:             .Column3.Header1.FontSize  = 8
359:             .Column3.Header1.Alignment = 2
360:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
361: 

*-- Linhas 372 a 380:
372:             .Column4.Text1.ReadOnly  = .T.
373:             .Column4.Text1.ForeColor = RGB(0, 0, 0)
374:             .Column4.Text1.BackColor = RGB(255, 255, 255)
375:             .Column4.Header1.Caption   = "Data"
376:             .Column4.Header1.FontName  = "Tahoma"
377:             .Column4.Header1.FontSize  = 8
378:             .Column4.Header1.Alignment = 2
379:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
380: 

*-- Linhas 391 a 399:
391:             .Column5.Text1.Alignment = 3
392:             .Column5.Text1.ForeColor = RGB(0, 0, 0)
393:             .Column5.Text1.BackColor = RGB(255, 255, 255)
394:             .Column5.Header1.Caption   = "Grupo"
395:             .Column5.Header1.FontName  = "Tahoma"
396:             .Column5.Header1.FontSize  = 8
397:             .Column5.Header1.Alignment = 2
398:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
399: 

*-- Linhas 410 a 418:
410:             .Column6.Text1.ReadOnly  = .T.
411:             .Column6.Text1.ForeColor = RGB(0, 0, 0)
412:             .Column6.Text1.BackColor = RGB(255, 255, 255)
413:             .Column6.Header1.Caption   = "Conta"
414:             .Column6.Header1.FontName  = "Tahoma"
415:             .Column6.Header1.FontSize  = 8
416:             .Column6.Header1.Alignment = 2
417:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
418: 

*-- Linhas 429 a 437:
429:             .Column7.Text1.ReadOnly  = .T.
430:             .Column7.Text1.ForeColor = RGB(0, 0, 0)
431:             .Column7.Text1.BackColor = RGB(255, 255, 255)
432:             .Column7.Header1.Caption   = "Data / Entrega"
433:             .Column7.Header1.FontName  = "Tahoma"
434:             .Column7.Header1.FontSize  = 8
435:             .Column7.Header1.Alignment = 2
436:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
437: 

*-- Linhas 452 a 486:
452:             .Column8.Text1.ReadOnly  = .T.
453:             .Column8.Text1.ForeColor = RGB(0, 0, 0)
454:             .Column8.Text1.BackColor = RGB(255, 255, 223)
455:             .Column8.Header1.Caption   = "Qtde"
456:             .Column8.Header1.FontName  = "Tahoma"
457:             .Column8.Header1.FontSize  = 8
458:             .Column8.Header1.Alignment = 2
459:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
460:         ENDWITH
461:     ENDPROC
462: 
463:     *==========================================================================
464:     * ConfigurarGridRodape - Grid rodape/totalizador (equivalente a grdRodape)
465:     * 3 colunas (Descrs, Usuars, Qtds), leitura somente, cursor_4c_Rodape
466:     * Posicoes escalonadas: Top=530 (453*600/513), Left=17, Width=885, Height=23
467:     * FontName=Arial conforme original; BackColor amarelado (255,255,223)
468:     *==========================================================================
469:     PROTECTED PROCEDURE ConfigurarGridRodape()
470:         THIS.AddObject("grd_4c_Rodape", "Grid")
471:         WITH THIS.grd_4c_Rodape
472:             .Top               = 530
473:             .Left              = 17
474:             .Width             = 885
475:             .Height            = 23
476:             .ColumnCount       = 3
477:             .RecordSource      = "cursor_4c_Rodape"
478:             .DeleteMark        = .F.
479:             .RecordMark        = .F.
480:             .ReadOnly          = .T.
481:             .ScrollBars        = 2
482:             .AllowHeaderSizing = .F.
483:             .AllowRowSizing    = .F.
484:             .HeaderHeight      = 4
485:             .FontName          = "Arial"
486:             .Visible           = .T.

*-- Linhas 499 a 507:
499:             .Column1.Text1.ReadOnly  = .T.
500:             .Column1.Text1.ForeColor = RGB(0, 0, 0)
501:             .Column1.Text1.BackColor = RGB(255, 255, 223)
502:             .Column1.Header1.Caption   = ""
503:             .Column1.Header1.FontName  = "Arial"
504:             .Column1.Header1.FontSize  = 8
505:             .Column1.Header1.Alignment = 2
506:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
507:             .Column1.Header1.BackColor = RGB(255, 255, 0)

*-- Linhas 522 a 530:
522:             .Column2.Text1.ReadOnly  = .T.
523:             .Column2.Text1.ForeColor = RGB(0, 0, 0)
524:             .Column2.Text1.BackColor = RGB(255, 255, 223)
525:             .Column2.Header1.Caption   = ""
526:             .Column2.Header1.FontName  = "Arial"
527:             .Column2.Header1.FontSize  = 8
528:             .Column2.Header1.Alignment = 2
529:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
530:             .Column2.Header1.BackColor = RGB(255, 255, 0)

*-- Linhas 546 a 574:
546:             .Column3.Text1.ReadOnly  = .T.
547:             .Column3.Text1.ForeColor = RGB(0, 0, 0)
548:             .Column3.Text1.BackColor = RGB(255, 255, 223)
549:             .Column3.Header1.Caption   = ""
550:             .Column3.Header1.FontSize  = 8
551:             .Column3.Header1.Alignment = 2
552:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
553:             .Column3.Header1.BackColor = RGB(255, 255, 0)
554:         ENDWITH
555:     ENDPROC
556: 
557:     *==========================================================================
558:     * ConfigurarCampoRClis - TextBox leitura somente exibindo RClis da linha
559:     * corrente do grd_4c_Dados (equivalente a getRClis do legado).
560:     * Enabled=.F. conforme original; atualizado via AfterRowColChange do grid.
561:     * Posicao escalonada: Top=557 (476*600/513), Left=17, Width=885, Height=20
562:     *==========================================================================
563:     PROTECTED PROCEDURE ConfigurarCampoRClis()
564:         THIS.AddObject("txt_4c_RClis", "TextBox")
565:         WITH THIS.txt_4c_RClis
566:             .Top             = 557
567:             .Left            = 17
568:             .Width           = 885
569:             .Height          = 20
570:             .Value           = ""
571:             .Enabled         = .F.
572:             .SpecialEffect   = 1
573:             .FontName        = "Tahoma"
574:             .FontSize        = 9

*-- Linhas 598 a 607:
598:     PROTECTED PROCEDURE ConfigurarShape1()
599:         THIS.AddObject("shp_4c_Shape1", "Shape")
600:         WITH THIS.shp_4c_Shape1
601:             .Top         = 7
602:             .Left        = 872
603:             .Height      = 110
604:             .Width       = 90
605:             .BackStyle   = 0
606:             .BorderStyle = 0
607:             .Visible     = .T.

*-- Linhas 634 a 662:
634:     *==========================================================================
635:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
636:         *-- Botao Encerrar
637:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
638: 
639:         *-- AfterRowColChange do grid principal: atualiza rodape e RClis
640:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
641: 
642:         *-- GotFocus do Column1.Text1 do grdRodape: redireciona foco para grid principal
643:         BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", THIS, "GrdRodapeCol1GotFocus")
644: 
645:         *-- GotFocus/LostFocus do Column2.Text1 do grdRodape: preserva valor via Tag
646:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus",   THIS, "GrdRodapeCol2GotFocus")
647:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "KeyPress",  THIS, "GrdRodapeCol2LostFocus")
648: 
649:         *-- When do txt_4c_RClis: sempre retorna .F. (campo nao recebe foco)
650:         BINDEVENT(THIS.txt_4c_RClis, "When", THIS, "TxtRClisWhen")
651:     ENDPROC
652: 
653:     *==========================================================================
654:     * BtnEncerrarClick - Fecha o formulario
655:     *==========================================================================
656:     PROCEDURE BtnEncerrarClick()
657:         THIS.Release()
658:     ENDPROC
659: 
660:     *==========================================================================
661:     * BtnIncluirClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
662:     *   Wrapper canonico para a auditoria do orquestrador.

*-- Linhas 677 a 712:
677:             WAIT CLEAR
678: 
679:             IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
680:                 SELECT cursor_4c_Grade
681:                 GO TOP
682:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ;
683:                     "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
684:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
685:                 THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
686:             ELSE
687:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ""
688:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ""
689:                 THIS.txt_4c_RClis.Value = ""
690:             ENDIF
691: 
692:             THIS.grd_4c_Dados.Refresh()
693:             THIS.grd_4c_Rodape.Refresh()
694:             THIS.txt_4c_RClis.Refresh()
695: 
696:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
697:                 THIS.grd_4c_Dados.Column1.SetFocus()
698:             ENDIF
699:         CATCH TO loc_oErro
700:             WAIT CLEAR
701:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
702:         ENDTRY
703:     ENDPROC
704: 
705:     *==========================================================================
706:     * BtnAlterarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
707:     *   Wrapper canonico para a auditoria do orquestrador.
708:     *   Acao real: reposiciona cursor_4c_Grade no primeiro movimento, sincroniza
709:     *   rodape/RClis com a linha topo (igual ao comportamento esperado apos
710:     *   carga inicial) e devolve foco a primeira coluna do grid principal.
711:     *==========================================================================
712:     PROCEDURE BtnAlterarClick()

*-- Linhas 724 a 754:
724:                 RETURN
725:             ENDIF
726: 
727:             GO TOP
728: 
729:             THIS.grd_4c_Rodape.Column1.Text1.Value = ;
730:                 "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
731:             THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
732:             THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
733: 
734:             THIS.grd_4c_Dados.Refresh()
735:             THIS.grd_4c_Rodape.Refresh()
736:             THIS.txt_4c_RClis.Refresh()
737: 
738:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
739:                 THIS.grd_4c_Dados.Column1.SetFocus()
740:             ENDIF
741:         CATCH TO loc_oErro
742:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
743:         ENDTRY
744:     ENDPROC
745: 
746:     *==========================================================================
747:     * BtnVisualizarClick - Form OPERACIONAL (sem CRUD - consulta somente leitura)
748:     *   Wrapper canonico para a auditoria do orquestrador.
749:     *   Acao real: expoe os dados do registro corrente do cursor_4c_Grade em
750:     *   uma janela de detalhamento (numero, data, empresa, RClis, qtde em aberto).
751:     *   Equivale ao "drill-down" implicito do form original ao ver os campos do
752:     *   rodape sincronizados com a linha selecionada.
753:     *==========================================================================
754:     PROCEDURE BtnVisualizarClick()

*-- Linhas 805 a 877:
805: 
806:         TRY
807:             IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade") AND !BOF("cursor_4c_Grade")
808:                 SELECT cursor_4c_Grade
809: 
810:                 THIS.grd_4c_Rodape.Column1.Text1.Value = ;
811:                     "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
812:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
813:                 THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
814: 
815:                 THIS.grd_4c_Rodape.Column1.Refresh()
816:                 THIS.grd_4c_Rodape.Column2.Refresh()
817:                 THIS.txt_4c_RClis.Refresh()
818:             ENDIF
819:         CATCH TO loc_oErro
820:             MsgErro(loc_oErro.Message, "Erro GrdDadosAfterRowColChange")
821:         ENDTRY
822:     ENDPROC
823: 
824:     *==========================================================================
825:     * GrdRodapeCol1GotFocus - Redireciona foco para grid principal
826:     * Equivalente ao GotFocus de grdRodape.Column1.Text1 no legado
827:     *==========================================================================
828:     PROCEDURE GrdRodapeCol1GotFocus()
829:         LOCAL loc_oErro
830:         TRY
831:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
832:                 THIS.grd_4c_Dados.Column1.SetFocus()
833:             ENDIF
834:         CATCH TO loc_oErro
835:             MsgErro(loc_oErro.Message, "Erro GrdRodapeCol1GotFocus")
836:         ENDTRY
837:     ENDPROC
838: 
839:     *==========================================================================
840:     * GrdRodapeCol2GotFocus - Preserva valor original em Tag antes de editar
841:     * Equivalente ao GotFocus de grdRodape.Column2.Text1: This.Tag = This.Value
842:     *==========================================================================
843:     PROCEDURE GrdRodapeCol2GotFocus()
844:         TRY
845:             IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
846:                 THIS.grd_4c_Rodape.Column2.Text1.Tag = ;
847:                     THIS.grd_4c_Rodape.Column2.Text1.Value
848:             ENDIF
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2GotFocus")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * GrdRodapeCol2LostFocus - Restaura valor original do Tag ao sair
856:     * Equivalente ao LostFocus de grdRodape.Column2.Text1: This.Value = This.Tag
857:     *==========================================================================
858:     PROCEDURE GrdRodapeCol2LostFocus(par_nKeyCode, par_nShiftAltCtrl)
859:         TRY
860:             IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
861:                 THIS.grd_4c_Rodape.Column2.Text1.Value = ;
862:                     THIS.grd_4c_Rodape.Column2.Text1.Tag
863:             ENDIF
864:         CATCH TO loc_oErro
865:             MsgErro(loc_oErro.Message, "Erro GrdRodapeCol2LostFocus")
866:         ENDTRY
867:     ENDPROC
868: 
869:     *==========================================================================
870:     * TxtRClisWhen - Impede que txt_4c_RClis receba foco
871:     * Equivalente ao When de getRClis no legado: Return .F.
872:     *==========================================================================
873:     PROCEDURE TxtRClisWhen()
874:         RETURN .F.
875:     ENDPROC
876: 
877:     *==========================================================================

*-- Linhas 921 a 943:
921: 
922:     *==========================================================================
923:     * LimparCampos - Limpa o rodape e o campo RClis do display
924:     *==========================================================================
925:     PROCEDURE LimparCampos()
926:         IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
927:             THIS.grd_4c_Rodape.Column1.Text1.Value = ""
928:             THIS.grd_4c_Rodape.Column2.Text1.Value = ""
929:         ENDIF
930:         IF PEMSTATUS(THIS, "txt_4c_RClis", 5)
931:             THIS.txt_4c_RClis.Value = ""
932:         ENDIF
933:     ENDPROC
934: 
935:     *==========================================================================
936:     * CarregarLista - Recarrega cursor_4c_Grade via BO.SelecionarDados
937:     * Equivalente ao MontaGrades + SelecionaDados do legado (fluxo completo)
938:     *==========================================================================
939:     PROCEDURE CarregarLista()
940:         LOCAL loc_lSucesso, loc_oErro
941:         loc_lSucesso = .F.
942: 
943:         TRY

*-- Linhas 951 a 983:
951: 
952:             IF loc_lSucesso
953:                 IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
954:                     SELECT cursor_4c_Grade
955:                     GO TOP
956:                     THIS.grd_4c_Rodape.Column1.Text1.Value = ;
957:                         "Empresa Destino : " + ALLTRIM(NVL(EmpDs, ""))
958:                     THIS.grd_4c_Rodape.Column2.Text1.Value = ALLTRIM(NVL(Usuars, ""))
959:                     THIS.txt_4c_RClis.Value = ALLTRIM(NVL(RClis, ""))
960:                 ELSE
961:                     THIS.LimparCampos()
962:                 ENDIF
963: 
964:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
965:                     THIS.grd_4c_Dados.Refresh()
966:                 ENDIF
967:                 IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
968:                     THIS.grd_4c_Rodape.Refresh()
969:                 ENDIF
970:             ENDIF
971:         CATCH TO loc_oErro
972:             WAIT CLEAR
973:             MsgErro(loc_oErro.Message, "Erro CarregarLista")
974:         ENDTRY
975: 
976:         RETURN loc_lSucesso
977:     ENDPROC
978: 
979:     *==========================================================================
980:     * AjustarBotoesPorModo - Nao aplicavel (form somente leitura, sem modos CRUD)
981:     *==========================================================================
982:     PROCEDURE AjustarBotoesPorModo()
983:         RETURN


### BO (C:\4c\projeto\app\classes\SIGPDPNSBO.prg):
*==============================================================================
* SIGPDPNSBO.prg - BO de movimentos em aberto aguardando confirmacao (SIGPDPNS)
* Herda de BusinessBase
* Tabela principal: SigMvCab (movimentos em aberto filtrados por chave de sessao)
* Form OPERACIONAL: exibe movimentos em aberto filtrados por chave de sessao (this_cKey)
*==============================================================================
DEFINE CLASS SIGPDPNSBO AS BusinessBase

    *-- Chave de filtro recebida pelo form (equivalente a lpKey do legado)
    this_cKey            = ""

    *-- Campos da linha corrente em cursor_4c_Grade (equiv. crGrade)
    *-- cursor_4c_Grade: Emps c(3), Dopes c(20), Numes n(6), GrupoDs c(10),
    *--                  ContaDs c(10), Usuars c(10), Datas d, PrazoEnts d,
    *--                  Qtds n(10,3), EmpDs c(3), RClis c(50)
    this_cEmps           = ""
    this_cEmpDs          = ""
    this_cDopes          = ""
    this_nNumes          = 0
    this_cGrupoDs        = ""
    this_cContaDs        = ""
    this_cUsuars         = ""
    this_dDatas          = {}
    this_dPrazoEnts      = {}
    this_nPendentes      = 0
    this_cRClis          = ""

    *-- Totalizador de quantidade exibido em cursor_4c_Rodape (campo Qtds)
    this_nTotalPendentes = 0

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMvCab"
        this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir da linha corrente do cursor
    * Chamado pelo form ao navegar em grd_4c_Dados (AfterRowColChange)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            THIS.this_cEmpDs     = TratarNulo(EmpDs,     "C")
            THIS.this_cDopes     = TratarNulo(Dopes,     "C")
            THIS.this_nNumes     = TratarNulo(Numes,     "N")
            THIS.this_cGrupoDs   = TratarNulo(GrupoDs,   "C")
            THIS.this_cContaDs   = TratarNulo(ContaDs,   "C")
            THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
            THIS.this_dDatas     = TratarNulo(Datas,     "D")
            THIS.this_dPrazoEnts = TratarNulo(PrazoEnts, "D")
            THIS.this_nPendentes = TratarNulo(Pendentes, "N")
            THIS.this_cRClis     = TratarNulo(RClis,     "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Popula cursor_4c_Grade e cursor_4c_Rodape
    * Equivale a SelecionaDados do legado (SIGPDPNS.selecionadados)
    * Pre-requisitos:
    *   - cursor_4c_Grade e cursor_4c_Rodape ja criados pelo form
    *   - crSigMvEstPd em scope com campos EmpDopNums, Qtds, Fk_chave
    *   - this_cKey preenchido com a chave de filtro da sessao
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_lPodeProsseguir
        LOCAL loc_cSQL, loc_nTotal, loc_oErro

        loc_lSucesso        = .F.
        loc_lPodeProsseguir = .T.

        TRY
            IF !USED("crSigMvEstPd")
                MsgErro("Cursor crSigMvEstPd n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND !USED("cursor_4c_Grade")
                MsgErro("Cursor cursor_4c_Grade n" + CHR(227) + "o encontrado.", ;
                        "Erro ao Selecionar Dados")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                *-- Limpar cursores de destino
                SELECT cursor_4c_Grade
                ZAP
                IF USED("cursor_4c_Rodape")
                    SELECT cursor_4c_Rodape
                    ZAP
                ENDIF

                *-- Obter EmpDopNums distintos filtrados pela chave da sessao
                SELECT DISTINCT EmpDopNums, SUM(Qtds) AS Qtds ;
                  FROM crSigMvEstPd ;
                 WHERE Fk_chave = THIS.this_cKey ;
                 GROUP BY EmpDopNums ;
                 ORDER BY EmpDopNums ;
                  INTO CURSOR cursor_4c_LocalEstPd

                *-- Para cada grupo EmpDopNums, buscar movimentos no SQL Server
                SELECT cursor_4c_LocalEstPd
                SCAN
                    loc_cSQL = "SELECT a.Emps, a.EmpDs, a.Dopes, a.Numes, " + ;
                               "a.GrupoDs, a.ContaDs, b.RClis, a.Usuars, " + ;
                               "a.Datas, a.PrazoEnts " + ;
                               "FROM SigMvCab a, SigCdCli b " + ;
                               "WHERE a.EmpDopNums = '" + ;
                               ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums) + ;
                               "' AND a.ContaDs = b.IClis"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest") >= 1
                        SELECT cursor_4c_LocalEest
                        SCAN
                            INSERT INTO cursor_4c_Grade ;
                                (Emps, Dopes, Numes, GrupoDs, ContaDs, ;
                                 RClis, Usuars, Datas, PrazoEnts, EmpDs, Pendentes) ;
                            VALUES ;
                                (cursor_4c_LocalEest.Emps, ;
                                 cursor_4c_LocalEest.Dopes, ;
                                 cursor_4c_LocalEest.Numes, ;
                                 cursor_4c_LocalEest.GrupoDs, ;
                                 cursor_4c_LocalEest.ContaDs, ;
                                 cursor_4c_LocalEest.RClis, ;
                                 cursor_4c_LocalEest.Usuars, ;
                                 IIF(ISNULL(cursor_4c_LocalEest.Datas), {}, ;
                                     TTOD(cursor_4c_LocalEest.Datas)), ;
                                 IIF(ISNULL(cursor_4c_LocalEest.PrazoEnts), {}, ;
                                     TTOD(cursor_4c_LocalEest.PrazoEnts)), ;
                                 cursor_4c_LocalEest.EmpDs, ;
                                 cursor_4c_LocalEstPd.Qtds)
                        ENDSCAN
                        USE IN cursor_4c_LocalEest
                    ELSE
                        MsgErro("Falha ao carregar movimentos: " + ;
                                ALLTRIM(cursor_4c_LocalEstPd.EmpDopNums), ;
                                "Erro SQL")
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_LocalEstPd")
                    USE IN cursor_4c_LocalEstPd
                ENDIF

                *-- Calcular total de quantidades em aberto
                loc_nTotal = 0
                SELECT SUM(Pendentes) AS nTotalPs ;
                  FROM cursor_4c_Grade ;
                  INTO CURSOR cursor_4c_TotalPs

                IF USED("cursor_4c_TotalPs")
                    SELECT cursor_4c_TotalPs
                    GO TOP
                    IF !EOF()
                        loc_nTotal = NVL(nTotalPs, 0)
                    ENDIF
                    USE IN cursor_4c_TotalPs
                ENDIF

                THIS.this_nTotalPendentes = loc_nTotal

                *-- Inserir totalizador no rodape
                IF USED("cursor_4c_Rodape")
                    INSERT INTO cursor_4c_Rodape (Pendentes) VALUES (loc_nTotal)
                ENDIF

                *-- Posicionar no inicio para exibicao no grid
                IF USED("cursor_4c_Grade") AND !EOF("cursor_4c_Grade")
                    GO TOP IN cursor_4c_Grade
                ENDIF
                IF USED("cursor_4c_Rodape") AND !EOF("cursor_4c_Rodape")
                    GO TOP IN cursor_4c_Rodape
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Selecionar Dados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave de filtro da sessao (this_cKey)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cKey)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveEmpDopNum - Concatena Emps + Dopes + Numes no formato legado
    * Usado para localizar a linha de SigMvCab da operacao corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarChaveEmpDopNum()
        RETURN ALLTRIM(THIS.this_cEmps) + ;
               ALLTRIM(THIS.this_cDopes) + ;
               PADL(ALLTRIM(STR(THIS.this_nNumes, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigMvCab com os campos rastreados pelo BO
    * Os demais campos NOT NULL recebem defaults seguros para que o INSERT
    * passe na validacao do schema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNum vazia: " + ;
                                          "Emps/Dopes/Numes nao preenchidos."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigMvCab " + ;
                       "(cidchaves, emps, empds, dopes, numes, grupods, " + ;
                       " contads, usuars, datas, prazoents, " + ;
                       " npedclis, acres, antecs, chksubn, codpeds, contaos, " + ;
                       " desc2s, descs, devols, grresps, grupoos, grupos, " + ;
                       " grvends, iclis, ifors, locals, lotechqs, lprecos, " + ;
                       " mascnum, ncarnecs, nemps, nops, notas, nrcons, " + ;
                       " ntrans, numolds, opers, resps, tabds, tpfats, " + ;
                       " transps, usuals, usulibs, valacres, valdes2s, " + ;
                       " valdescs, valdevs, valencs, valinis, valos, " + ;
                       " valservs, valvars, vars, vends, cotusus, espes, " + ;
                       " qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs, " + ;
                       " codobs, dgopes, trfisicos, utilizados, valndevs, " + ;
                       " valobxs, noforms, auditors, usuconfs) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(loc_cChave, 20)) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                       EscaparSQL(THIS.this_cDopes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoEnts) + ", " + ;
                       "0, 0, '', 0, 0, '', " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "'', '', '', '', 0, '', " + ;
                       "'', '', '', 0, '', '', " + ;
                       "0, 0, '', '', '', '', " + ;
                       "0, '', '', 0, 0, " + ;
                       "0, 0, 0, 0, 0, " + ;
                       "0, 0, 0, '', '', '', " + ;
                       "0, 0, 0, 0, 0, '', " + ;
                       "0, '', 0, 0, 0, " + ;
                       "0, '', '', '')"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Inserir: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvCab com os campos rastreados pelo BO
    * Filtra por EmpDopNums (chave primaria composta, equivalente ao original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_oErro, loc_cChave

        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.MontarChaveEmpDopNum()

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave EmpDopNums vazia para UPDATE."
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET " + ;
                       " empds    = " + EscaparSQL(THIS.this_cEmpDs)   + ", " + ;
                       " grupods  = " + EscaparSQL(THIS.this_cGrupoDs) + ", " + ;
                       " contads  = " + EscaparSQL(THIS.this_cContaDs) + ", " + ;
                       " usuars   = " + EscaparSQL(THIS.this_cUsuars)  + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " prazoents= " + FormatarDataSQL(THIS.this_dPrazoEnts) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar registro em SigMvCab"
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro Atualizar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

