# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Lista' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ListaTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [NAVEGACAO-PAGINA] Metodo 'InicializarForm' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [LAYOUT-POSITION] Controle 'GeraSenha' (parent: SIGPRSDD): Left original=649 vs migrado 'cmd_4c_GeraSenha' Left=80 (diff=569px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Saida' (parent: SIGPRSDD): Left original=724 vs migrado 'cnt_4c_Saida' Left=917 (diff=193px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSdd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1673 linhas total):

*-- Linhas 74 a 85:
74:                 THIS.ConfigurarPaginaLista()
75:                 THIS.ConfigurarPaginaDados()
76: 
77:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81: 
82:                 THIS.TornarControlesVisiveis(THIS)
83: 
84:                 THIS.CarregarLista()
85:                 THIS.pgf_4c_Paginas.Visible = .T.

*-- Linhas 111 a 120:
111:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
112:         WITH THIS.pgf_4c_Paginas
113:             .PageCount   = 2
114:             .Top         = -29
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = THIS.Height + 29
118:             .Tabs        = .F.
119:             .BorderWidth = 0
120:             .Visible     = .T.

*-- Linhas 129 a 175:
129:         *-- Container Cabecalho (barra escura com titulo) - vazio nesta fase
130:         loc_oPag2.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH loc_oPag2.cnt_4c_Cabecalho
132:             .Top         = 29
133:             .Left        = 0
134:             .Width       = THIS.Width
135:             .Height      = 80
136:             .BackStyle   = 1
137:             .BackColor   = RGB(100, 100, 100)
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141: 
142:         *-- Container Botoes CRUD (lado direito do cabecalho) - vazio nesta fase
143:         loc_oPag2.AddObject("cnt_4c_Botoes", "Container")
144:         WITH loc_oPag2.cnt_4c_Botoes
145:             .Top         = 29
146:             .Left        = 542
147:             .Width       = 390
148:             .Height      = 85
149:             .BackStyle   = 0
150:             .BorderWidth = 0
151:             .Visible     = .T.
152:         ENDWITH
153: 
154:         *-- Container Saida/Encerrar (canto direito) - vazio nesta fase
155:         loc_oPag2.AddObject("cnt_4c_Saida", "Container")
156:         WITH loc_oPag2.cnt_4c_Saida
157:             .Top         = 29
158:             .Left        = 917
159:             .Width       = 90
160:             .Height      = 85
161:             .BackStyle   = 0
162:             .BorderWidth = 0
163:             .Visible     = .T.
164:         ENDWITH
165: 
166:         *-- Container Botoes de Acao especificos (Boleto/Gerar Senha) - vazio
167:         loc_oPag2.AddObject("cnt_4c_BotoesAcao", "Container")
168:         WITH loc_oPag2.cnt_4c_BotoesAcao
169:             .Top         = 29
170:             .Left        = 300
171:             .Width       = 240
172:             .Height      = 85
173:             .BackStyle   = 0
174:             .BorderWidth = 0
175:             .Visible     = .T.

*-- Linhas 217 a 289:
217:         *----------------------------------------------------------------------
218:         loc_oPag1.AddObject("cnt_4c_Cabecalho", "Container")
219:         WITH loc_oPag1.cnt_4c_Cabecalho
220:             .Top         = 29
221:             .Left        = 0
222:             .Width       = THIS.Width
223:             .Height      = 80
224:             .BackStyle   = 1
225:             .BackColor   = RGB(100, 100, 100)
226:             .BorderWidth = 0
227:             .Visible     = .T.
228:         ENDWITH
229:         loc_oCab = loc_oPag1.cnt_4c_Cabecalho
230: 
231:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
232:         WITH loc_oCab.lbl_4c_Sombra
233:             .AutoSize    = .F.
234:             .Width       = THIS.Width
235:             .FontBold    = .T.
236:             .FontName    = "Tahoma"
237:             .FontSize    = 16
238:             .BackStyle   = 0
239:             .Caption     = "Senha do Dia"
240:             .Height      = 40
241:             .Left        = 10
242:             .Top         = 15
243:             .ForeColor   = RGB(0, 0, 0)
244:             .Visible     = .T.
245:         ENDWITH
246: 
247:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
248:         WITH loc_oCab.lbl_4c_Titulo
249:             .AutoSize    = .F.
250:             .Width       = THIS.Width
251:             .FontBold    = .T.
252:             .FontName    = "Tahoma"
253:             .FontSize    = 16
254:             .BackStyle   = 0
255:             .Caption     = "Senha do Dia"
256:             .Height      = 46
257:             .Left        = 10
258:             .Top         = 18
259:             .ForeColor   = RGB(255, 255, 255)
260:             .Visible     = .T.
261:         ENDWITH
262: 
263:         *----------------------------------------------------------------------
264:         * Container de botoes CRUD (lado direito)
265:         *----------------------------------------------------------------------
266:         loc_oPag1.AddObject("cnt_4c_Botoes", "Container")
267:         WITH loc_oPag1.cnt_4c_Botoes
268:             .Top         = 29
269:             .Left        = 542
270:             .Width       = 390
271:             .Height      = 85
272:             .BackStyle   = 0
273:             .BorderWidth = 0
274:             .Visible     = .T.
275:         ENDWITH
276:         loc_oBotoes = loc_oPag1.cnt_4c_Botoes
277: 
278:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
279:         WITH loc_oBotoes.cmd_4c_Incluir
280:             .Left            = 5
281:             .Top             = 5
282:             .Width           = 75
283:             .Height          = 75
284:             .Caption         = "Gerar" + CHR(13) + "Senha"
285:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
286:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
287:             .FontName        = "Tahoma"
288:             .FontBold        = .T.
289:             .FontItalic      = .T.

*-- Linhas 297 a 313:
297:             .WordWrap        = .T.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
301: 
302:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
303:         WITH loc_oBotoes.cmd_4c_Visualizar
304:             .Left            = 80
305:             .Top             = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .Caption         = "Visualizar"
309:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
310:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
311:             .FontName        = "Tahoma"
312:             .FontBold        = .T.
313:             .FontItalic      = .T.

*-- Linhas 321 a 337:
321:             .WordWrap        = .T.
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
325: 
326:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
327:         WITH loc_oBotoes.cmd_4c_Alterar
328:             .Left            = 155
329:             .Top             = 5
330:             .Width           = 75
331:             .Height          = 75
332:             .Caption         = "Alterar"
333:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
334:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
335:             .FontName        = "Tahoma"
336:             .FontBold        = .T.
337:             .FontItalic      = .T.

*-- Linhas 345 a 361:
345:             .WordWrap        = .T.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
349: 
350:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
351:         WITH loc_oBotoes.cmd_4c_Excluir
352:             .Left            = 230
353:             .Top             = 5
354:             .Width           = 75
355:             .Height          = 75
356:             .Caption         = "Excluir"
357:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
358:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
359:             .FontName        = "Tahoma"
360:             .FontBold        = .T.
361:             .FontItalic      = .T.

*-- Linhas 369 a 385:
369:             .WordWrap        = .T.
370:             .Visible         = .T.
371:         ENDWITH
372:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
373: 
374:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
375:         WITH loc_oBotoes.cmd_4c_Buscar
376:             .Left            = 305
377:             .Top             = 5
378:             .Width           = 75
379:             .Height          = 75
380:             .Caption         = "Buscar"
381:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
382:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
383:             .FontName        = "Tahoma"
384:             .FontBold        = .T.
385:             .FontItalic      = .T.

*-- Linhas 393 a 426:
393:             .WordWrap        = .T.
394:             .Visible         = .T.
395:         ENDWITH
396:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
397: 
398:         *----------------------------------------------------------------------
399:         * Container Saida/Encerrar - padrao canonico Left=917 W=90
400:         *----------------------------------------------------------------------
401:         loc_oPag1.AddObject("cnt_4c_Saida", "Container")
402:         WITH loc_oPag1.cnt_4c_Saida
403:             .Top         = 29
404:             .Left        = 917
405:             .Width       = 90
406:             .Height      = 85
407:             .BackStyle   = 0
408:             .BorderWidth = 0
409:             .Visible     = .T.
410:         ENDWITH
411:         loc_oSaida = loc_oPag1.cnt_4c_Saida
412: 
413:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
414:         WITH loc_oSaida.cmd_4c_Encerrar
415:             .Left            = 5
416:             .Top             = 5
417:             .Width           = 75
418:             .Height          = 75
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
421:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
422:             .Cancel          = .T.
423:             .FontName        = "Tahoma"
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .FontSize        = 8

*-- Linhas 433 a 449:
433:             .WordWrap        = .T.
434:             .Visible         = .T.
435:         ENDWITH
436:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
437: 
438:         *----------------------------------------------------------------------
439:         * Grid de lista de senhas geradas (SigPrSnd)
440:         *----------------------------------------------------------------------
441:         loc_oPag1.AddObject("grd_4c_Lista", "Grid")
442:         WITH loc_oPag1.grd_4c_Lista
443:             .Top                = 117
444:             .Left               = 5
445:             .Width              = 990
446:             .Height             = 450
447:             .FontName           = "Verdana"
448:             .FontSize           = 8
449:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 481 a 521:
481:             loc_cSQL = "SELECT TOP 500 " + ;
482:                        "cidchaves, datas, solicits, operas, docs, valors, senhads, tipos, emps " + ;
483:                        "FROM SigPrSnd " + ;
484:                        "ORDER BY datas DESC"
485: 
486:             IF USED("cursor_4c_Lista")
487:                 TABLEREVERT(.T., "cursor_4c_Lista")
488:                 USE IN cursor_4c_Lista
489:             ENDIF
490: 
491:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
492: 
493:             IF loc_nRet > 0 AND USED("cursor_4c_Lista")
494:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
495: 
496:                 loc_oGrid.ColumnCount  = 8
497:                 loc_oGrid.RecordSource = "cursor_4c_Lista"
498: 
499:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.datas"
500:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.solicits"
501:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.emps"
502:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.operas"
503:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.docs"
504:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.valors"
505:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Lista.senhads"
506:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Lista.tipos"
507: 
508:                 loc_oGrid.Column1.Header1.Caption = "Data/Hora"
509:                 loc_oGrid.Column2.Header1.Caption = "Solicitante"
510:                 loc_oGrid.Column3.Header1.Caption = "Empresa"
511:                 loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
512:                 loc_oGrid.Column5.Header1.Caption = "Documento"
513:                 loc_oGrid.Column6.Header1.Caption = "Valor"
514:                 loc_oGrid.Column7.Header1.Caption = "Senha"
515:                 loc_oGrid.Column8.Header1.Caption = "Tipo"
516: 
517:                 loc_oGrid.Column1.Width = 120
518:                 loc_oGrid.Column2.Width = 90
519:                 loc_oGrid.Column3.Width = 50
520:                 loc_oGrid.Column4.Width = 170
521:                 loc_oGrid.Column5.Width = 110

*-- Linhas 568 a 627:
568: 
569:     *==========================================================================
570:     * BtnVisualizarClick - Carrega registro selecionado em modo visualizacao
571:     *==========================================================================
572:     PROCEDURE BtnVisualizarClick()
573:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
574:             MsgAviso("Selecione um registro na lista.", "Aviso")
575:         ELSE
576:             THIS.this_cModoAtual = "VISUALIZAR"
577:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
578:             THIS.BOParaForm()
579:             THIS.HabilitarCampos("VISUALIZAR")
580:             THIS.AlternarPagina(2)
581:         ENDIF
582:     ENDPROC
583: 
584:     *==========================================================================
585:     * BtnAlterarClick - Carrega registro selecionado em modo edicao
586:     *==========================================================================
587:     PROCEDURE BtnAlterarClick()
588:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
589:             MsgAviso("Selecione um registro na lista.", "Aviso")
590:         ELSE
591:             THIS.this_cModoAtual = "ALTERAR"
592:             THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
593:             THIS.BOParaForm()
594:             THIS.HabilitarCampos("ALTERAR")
595:             THIS.AlternarPagina(2)
596:         ENDIF
597:     ENDPROC
598: 
599:     *==========================================================================
600:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
601:     *==========================================================================
602:     PROCEDURE BtnExcluirClick()
603:         LOCAL loc_lConfirma, loc_lSucesso, loc_oErro
604: 
605:         loc_lConfirma = .F.
606:         loc_lSucesso  = .F.
607: 
608:         IF !USED("cursor_4c_Lista") OR RECCOUNT("cursor_4c_Lista") = 0
609:             MsgAviso("Selecione um registro na lista.", "Aviso")
610:         ELSE
611:             TRY
612:                 THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Lista")
613:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Confirmar")
614:                 IF loc_lConfirma
615:                     loc_lSucesso = THIS.this_oBusinessObject.Excluir()
616:                     IF loc_lSucesso
617:                         THIS.CarregarLista()
618:                     ENDIF
619:                 ENDIF
620:             CATCH TO loc_oErro
621:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
622:                         " PROC=" + loc_oErro.Procedure, "Erro ao Excluir")
623:             ENDTRY
624:         ENDIF
625:     ENDPROC
626: 
627:     *==========================================================================

*-- Linhas 653 a 704:
653:         *----------------------------------------------------------------------
654:         loc_oCab = loc_oPag2.cnt_4c_Cabecalho
655: 
656:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
657:         WITH loc_oCab.lbl_4c_Sombra
658:             .AutoSize  = .F.
659:             .Width     = THIS.Width
660:             .FontBold  = .T.
661:             .FontName  = "Tahoma"
662:             .FontSize  = 18
663:             .BackStyle = 0
664:             .Caption   = "Senha do Dia"
665:             .Height    = 40
666:             .Left      = 10
667:             .Top       = 18
668:             .ForeColor = RGB(0, 0, 0)
669:             .Visible   = .T.
670:         ENDWITH
671: 
672:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
673:         WITH loc_oCab.lbl_4c_Titulo
674:             .AutoSize  = .F.
675:             .Width     = THIS.Width
676:             .FontBold  = .T.
677:             .FontName  = "Tahoma"
678:             .FontSize  = 18
679:             .BackStyle = 0
680:             .Caption   = "Senha do Dia"
681:             .Height    = 46
682:             .Left      = 10
683:             .Top       = 17
684:             .ForeColor = RGB(255, 255, 255)
685:             .Visible   = .T.
686:         ENDWITH
687: 
688:         *----------------------------------------------------------------------
689:         * Botoes de acao: Boleto e Gerar Senha (container criado em ConfigurarPageFrame)
690:         *----------------------------------------------------------------------
691:         loc_oBotoesAcao = loc_oPag2.cnt_4c_BotoesAcao
692: 
693:         loc_oBotoesAcao.AddObject("cmd_4c_Boleto", "CommandButton")
694:         WITH loc_oBotoesAcao.cmd_4c_Boleto
695:             .Left            = 5
696:             .Top             = 5
697:             .Width           = 75
698:             .Height          = 75
699:             .Caption         = "Boleto"
700:             .Picture         = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
701:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_boleto_60.jpg"
702:             .FontName        = "Tahoma"
703:             .FontBold        = .T.
704:             .FontItalic      = .T.

*-- Linhas 712 a 759:
712:             .WordWrap        = .T.
713:             .Visible         = .T.
714:         ENDWITH
715:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
716: 
717:         loc_oBotoesAcao.AddObject("cmd_4c_GeraSenha", "CommandButton")
718:         WITH loc_oBotoesAcao.cmd_4c_GeraSenha
719:             .Left            = 80
720:             .Top             = 5
721:             .Width           = 75
722:             .Height          = 75
723:             .Caption         = "Gerar" + CHR(13) + "Senha"
724:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
725:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
726:             .FontName        = "Tahoma"
727:             .FontBold        = .T.
728:             .FontItalic      = .T.
729:             .FontSize        = 8
730:             .ForeColor       = RGB(90, 90, 90)
731:             .BackColor       = RGB(255, 255, 255)
732:             .Themes          = .F.
733:             .SpecialEffect   = 0
734:             .PicturePosition = 13
735:             .MousePointer    = 15
736:             .WordWrap        = .T.
737:             .Visible         = .T.
738:         ENDWITH
739:         BINDEVENT(loc_oBotoesAcao.cmd_4c_GeraSenha, "Click", THIS, "BtnGeraSenhaClick")
740: 
741:         *----------------------------------------------------------------------
742:         * Botao Encerrar (container cnt_4c_Saida criado em ConfigurarPageFrame)
743:         *----------------------------------------------------------------------
744:         loc_oSaida = loc_oPag2.cnt_4c_Saida
745: 
746:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
747:         WITH loc_oSaida.cmd_4c_Encerrar
748:             .Left            = 5
749:             .Top             = 5
750:             .Width           = 75
751:             .Height          = 75
752:             .Caption         = "Encerrar"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
754:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
755:             .Cancel          = .T.
756:             .FontName        = "Tahoma"
757:             .FontBold        = .T.
758:             .FontItalic      = .T.
759:             .FontSize        = 8

*-- Linhas 766 a 802:
766:             .WordWrap        = .T.
767:             .Visible         = .T.
768:         ENDWITH
769:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
770: 
771:         *----------------------------------------------------------------------
772:         * Solicitante (TabIndex=1) - Top original 83 + 29 = 112
773:         * Label original Top=86 + 29 = 115
774:         *----------------------------------------------------------------------
775:         loc_oPag2.AddObject("lbl_4c_Solicitante", "Label")
776:         WITH loc_oPag2.lbl_4c_Solicitante
777:             .AutoSize  = .T.
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .BackStyle = 0
781:             .Caption   = "Solicitante : "
782:             .Height    = 15
783:             .Left      = 81
784:             .Top       = 115
785:             .ForeColor = RGB(90, 90, 90)
786:             .Visible   = .T.
787:         ENDWITH
788: 
789:         loc_oPag2.AddObject("txt_4c_Solic", "TextBox")
790:         WITH loc_oPag2.txt_4c_Solic
791:             .FontName      = "Tahoma"
792:             .FontSize      = 8
793:             .Value         = ""
794:             .MaxLength     = 10
795:             .Height        = 23
796:             .Left          = 144
797:             .Top           = 112
798:             .Width         = 80
799:             .Format        = "K!"
800:             .SpecialEffect = 1
801:             .ForeColor     = RGB(90, 90, 90)
802:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 808 a 838:
808:         * Empresa - Codigo (TabIndex=2) e Nome (TabIndex=3)
809:         * Top original 108 + 29 = 137; label original Top=112 + 29 = 141
810:         *----------------------------------------------------------------------
811:         loc_oPag2.AddObject("lbl_4c_Empresa", "Label")
812:         WITH loc_oPag2.lbl_4c_Empresa
813:             .AutoSize  = .T.
814:             .FontName  = "Tahoma"
815:             .FontSize  = 8
816:             .BackStyle = 0
817:             .Caption   = "Empresa : "
818:             .Height    = 15
819:             .Left      = 89
820:             .Top       = 141
821:             .ForeColor = RGB(90, 90, 90)
822:             .Visible   = .T.
823:         ENDWITH
824: 
825:         loc_oPag2.AddObject("txt_4c_Cd_Empresa", "TextBox")
826:         WITH loc_oPag2.txt_4c_Cd_Empresa
827:             .FontName      = "Tahoma"
828:             .FontSize      = 8
829:             .Value         = ""
830:             .MaxLength     = 3
831:             .Height        = 25
832:             .Left          = 144
833:             .Top           = 137
834:             .Width         = 32
835:             .Format        = "K"
836:             .SpecialEffect = 1
837:             .ForeColor     = RGB(90, 90, 90)
838:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 847 a 856:
847:             .Value         = ""
848:             .MaxLength     = 40
849:             .Height        = 25
850:             .Left          = 178
851:             .Top           = 137
852:             .Width         = 290
853:             .Format        = "K"
854:             .SpecialEffect = 1
855:             .ForeColor     = RGB(90, 90, 90)
856:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 862 a 892:
862:         * Operacao (TabIndex=4) - Top original 135 + 29 = 164
863:         * Label original Top=140 + 29 = 169
864:         *----------------------------------------------------------------------
865:         loc_oPag2.AddObject("lbl_4c_Operacao", "Label")
866:         WITH loc_oPag2.lbl_4c_Operacao
867:             .AutoSize  = .T.
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o : "
872:             .Height    = 15
873:             .Left      = 83
874:             .Top       = 169
875:             .ForeColor = RGB(90, 90, 90)
876:             .Visible   = .T.
877:         ENDWITH
878: 
879:         loc_oPag2.AddObject("txt_4c_Operacao", "TextBox")
880:         WITH loc_oPag2.txt_4c_Operacao
881:             .FontName      = "Tahoma"
882:             .FontSize      = 8
883:             .Value         = ""
884:             .MaxLength     = 20
885:             .Height        = 25
886:             .Left          = 144
887:             .Top           = 164
888:             .Width         = 150
889:             .Format        = "K"
890:             .SpecialEffect = 1
891:             .ForeColor     = RGB(90, 90, 90)
892:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 898 a 928:
898:         * Documento (TabIndex=5) - Top original 162 + 29 = 191
899:         * Label original Top=165 + 29 = 194
900:         *----------------------------------------------------------------------
901:         loc_oPag2.AddObject("lbl_4c_Documento", "Label")
902:         WITH loc_oPag2.lbl_4c_Documento
903:             .AutoSize  = .T.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .BackStyle = 0
907:             .Caption   = "Documento : "
908:             .Height    = 15
909:             .Left      = 76
910:             .Top       = 194
911:             .ForeColor = RGB(90, 90, 90)
912:             .Visible   = .T.
913:         ENDWITH
914: 
915:         loc_oPag2.AddObject("txt_4c_Doc", "TextBox")
916:         WITH loc_oPag2.txt_4c_Doc
917:             .FontName      = "Tahoma"
918:             .FontSize      = 8
919:             .Value         = 0
920:             .InputMask     = "9999999999"
921:             .Height        = 23
922:             .Left          = 144
923:             .Top           = 191
924:             .Width         = 80
925:             .Format        = "K"
926:             .SpecialEffect = 1
927:             .ForeColor     = RGB(90, 90, 90)
928:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 934 a 964:
934:         * Cond. Pagto / Forma Pagamento (TabIndex=6) - Top original 187 + 29 = 216
935:         * Label original Top=192 + 29 = 221
936:         *----------------------------------------------------------------------
937:         loc_oPag2.AddObject("lbl_4c_CondPagto", "Label")
938:         WITH loc_oPag2.lbl_4c_CondPagto
939:             .AutoSize  = .T.
940:             .FontName  = "Tahoma"
941:             .FontSize  = 8
942:             .BackStyle = 0
943:             .Caption   = "Cond. Pagto : "
944:             .Height    = 15
945:             .Left      = 70
946:             .Top       = 221
947:             .ForeColor = RGB(90, 90, 90)
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         loc_oPag2.AddObject("txt_4c_Fpg", "TextBox")
952:         WITH loc_oPag2.txt_4c_Fpg
953:             .FontName      = "Tahoma"
954:             .FontSize      = 8
955:             .Value         = ""
956:             .MaxLength     = 12
957:             .Height        = 23
958:             .Left          = 144
959:             .Top           = 216
960:             .Width         = 94
961:             .Format        = "K"
962:             .SpecialEffect = 1
963:             .ForeColor     = RGB(90, 90, 90)
964:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 972 a 1002:
972:         * ReadOnly: When original retorna .F. (campo sempre bloqueado)
973:         * Label original Top=215 + 29 = 244
974:         *----------------------------------------------------------------------
975:         loc_oPag2.AddObject("lbl_4c_Data", "Label")
976:         WITH loc_oPag2.lbl_4c_Data
977:             .AutoSize  = .T.
978:             .FontName  = "Tahoma"
979:             .FontSize  = 8
980:             .BackStyle = 0
981:             .Caption   = "Data : "
982:             .Height    = 15
983:             .Left      = 107
984:             .Top       = 244
985:             .ForeColor = RGB(90, 90, 90)
986:             .Visible   = .T.
987:         ENDWITH
988: 
989:         loc_oPag2.AddObject("txt_4c_Data", "TextBox")
990:         WITH loc_oPag2.txt_4c_Data
991:             .FontName      = "Tahoma"
992:             .FontSize      = 8
993:             .Value         = DATETIME()
994:             .ReadOnly      = .T.
995:             .Height        = 23
996:             .Left          = 144
997:             .Top           = 241
998:             .Width         = 75
999:             .Format        = "K"
1000:             .SpecialEffect = 1
1001:             .ForeColor     = RGB(90, 90, 90)
1002:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1009 a 1039:
1009:         * Habilitado apenas em modo !Producao (When = Not Thisform.Producao)
1010:         * Label original Top=240 + 29 = 269
1011:         *----------------------------------------------------------------------
1012:         loc_oPag2.AddObject("lbl_4c_Valor", "Label")
1013:         WITH loc_oPag2.lbl_4c_Valor
1014:             .AutoSize  = .T.
1015:             .FontName  = "Tahoma"
1016:             .FontSize  = 8
1017:             .BackStyle = 0
1018:             .Caption   = "Valor : "
1019:             .Height    = 15
1020:             .Left      = 106
1021:             .Top       = 269
1022:             .ForeColor = RGB(90, 90, 90)
1023:             .Visible   = .T.
1024:         ENDWITH
1025: 
1026:         loc_oPag2.AddObject("txt_4c_Valor", "TextBox")
1027:         WITH loc_oPag2.txt_4c_Valor
1028:             .FontName      = "Tahoma"
1029:             .FontSize      = 8
1030:             .Value         = 0
1031:             .InputMask     = "999,999,999.99"
1032:             .Height        = 23
1033:             .Left          = 144
1034:             .Top           = 266
1035:             .Width         = 100
1036:             .Format        = "K"
1037:             .SpecialEffect = 1
1038:             .ForeColor     = RGB(90, 90, 90)
1039:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1046 a 1076:
1046:         * Motivo (TabIndex=9) - Top original 262 + 29 = 291
1047:         * Label original Top=265 + 29 = 294
1048:         *----------------------------------------------------------------------
1049:         loc_oPag2.AddObject("lbl_4c_Motivo", "Label")
1050:         WITH loc_oPag2.lbl_4c_Motivo
1051:             .AutoSize  = .T.
1052:             .FontName  = "Tahoma"
1053:             .FontSize  = 8
1054:             .BackStyle = 0
1055:             .Caption   = "Motivo : "
1056:             .Height    = 15
1057:             .Left      = 98
1058:             .Top       = 294
1059:             .ForeColor = RGB(90, 90, 90)
1060:             .Visible   = .T.
1061:         ENDWITH
1062: 
1063:         loc_oPag2.AddObject("txt_4c_Motivo", "TextBox")
1064:         WITH loc_oPag2.txt_4c_Motivo
1065:             .FontName      = "Tahoma"
1066:             .FontSize      = 8
1067:             .Value         = ""
1068:             .MaxLength     = 40
1069:             .Height        = 23
1070:             .Left          = 144
1071:             .Top           = 291
1072:             .Width         = 360
1073:             .Format        = "K!"
1074:             .SpecialEffect = 1
1075:             .ForeColor     = RGB(90, 90, 90)
1076:             .BorderColor   = RGB(100, 100, 100)

*-- Linhas 1176 a 1197:
1176:     *==========================================================================
1177:     PROCEDURE Destroy()
1178:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1179:             THIS.this_oBusinessObject = .NULL.
1180:         ENDIF
1181:         IF USED("cursor_4c_Lista")
1182:             USE IN cursor_4c_Lista
1183:         ENDIF
1184:         DODEFAULT()
1185:     ENDPROC
1186: 
1187:     *==========================================================================
1188:     * BOParaForm - Popula campos do formulario a partir das propriedades do BO
1189:     * Usado em Visualizar/Alterar apos CarregarDoCursor
1190:     *==========================================================================
1191:     PROCEDURE BOParaForm()
1192:         LOCAL loc_oPag2, loc_oBO, loc_cSQL, loc_nRet, loc_oErro
1193: 
1194:         TRY
1195:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1196:             loc_oBO   = THIS.this_oBusinessObject
1197: 

*-- Linhas 1644 a 1671:
1644:     *==========================================================================
1645:     PROCEDURE AjustarBotoesPorModo()
1646:         LOCAL loc_oPag1, loc_lTemRegistro
1647: 
1648:         loc_oPag1        = THIS.pgf_4c_Paginas.Page1
1649:         loc_lTemRegistro = USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
1650: 
1651:         IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
1652:             WITH loc_oPag1.cnt_4c_Botoes
1653:                 IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
1654:                     .cmd_4c_Incluir.Enabled    = .T.
1655:                 ENDIF
1656:                 IF PEMSTATUS(.cmd_4c_Visualizar, "Enabled", 5)
1657:                     .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1658:                 ENDIF
1659:                 IF PEMSTATUS(.cmd_4c_Alterar, "Enabled", 5)
1660:                     .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1661:                 ENDIF
1662:                 IF PEMSTATUS(.cmd_4c_Excluir, "Enabled", 5)
1663:                     .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1664:                 ENDIF
1665:                 IF PEMSTATUS(.cmd_4c_Buscar, "Enabled", 5)
1666:                     .cmd_4c_Buscar.Enabled     = .T.
1667:                 ENDIF
1668:                 .Visible     = .T.
1669:             ENDWITH
1670:         ENDIF
1671:     ENDPROC


### BO (C:\4c\projeto\app\classes\SigPrSddBO.prg):
*==============================================================================
* SigPrSddBO.prg - Business Object para Senha do Dia
* Herda de BusinessBase
* Tabela principal: SigPrSnd
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SigPrSddBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigPrSnd"
    this_cCampoChave = "cIdChaves"

    *--------------------------------------------------------------------------
    * Propriedades de dados - SigPrSnd (todas as colunas)
    *--------------------------------------------------------------------------
    this_cIdChaves   = ""  && cidchaves  char(20)  PK
    this_dDatas      = {}  && datas      datetime  NULL
    this_nDocs       = 0   && docs       numeric(10,0)
    this_cHoras      = ""  && horas      char(8)
    this_cMotivos    = ""  && motivos    char(40)
    this_cOperas     = ""  && operas     char(20)
    this_cSenhads    = ""  && senhads    char(6)
    this_cSolicits   = ""  && solicits   char(10)
    this_cUsuars     = ""  && usuars     char(10)
    this_nValors     = 0   && valors     numeric(11,2)
    this_nTipos      = 0   && tipos      numeric(1,0)
    this_cEmps       = ""  && emps       char(3)
    this_cFpags      = ""  && fpags      char(12)
    this_cEmpdopnums = ""  && empdopnums char(29)
    this_nPerlimite  = 0   && perlimite  numeric(5,2)

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (nao persistidas em SigPrSnd)
    *--------------------------------------------------------------------------
    this_lProducao   = .F. && modo producao (parametro recebido pelo form)
    this_lSenhDEmps  = .F. && flag SigCdPac.senhdemps (bit -> logical)
    this_cDsEmpresa  = ""  && descricao empresa (SigCdEmp.Razas, exibida em Get_Ds_Empresa)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "SigPrSnd"
            THIS.this_cCampoChave = "cIdChaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrSddBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves como chave primaria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN RTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * par_cAliasCursor: alias do cursor com dados de SigPrSnd
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cIdChaves   = TratarNulo(cidchaves,   "C")
                THIS.this_dDatas      = IIF(VARTYPE(datas) = "T", datas, IIF(VARTYPE(datas) = "D", DATETIME(YEAR(datas), MONTH(datas), DAY(datas)), DATETIME()))
                THIS.this_nDocs       = TratarNulo(docs,        "N")
                THIS.this_cHoras      = TratarNulo(horas,       "C")
                THIS.this_cMotivos    = TratarNulo(motivos,     "C")
                THIS.this_cOperas     = TratarNulo(operas,      "C")
                THIS.this_cSenhads    = TratarNulo(senhads,     "C")
                THIS.this_cSolicits   = TratarNulo(solicits,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,      "C")
                THIS.this_nValors     = TratarNulo(valors,      "N")
                THIS.this_nTipos      = TratarNulo(tipos,       "N")
                THIS.this_cEmps       = TratarNulo(emps,        "C")
                THIS.this_cFpags      = TratarNulo(fpags,       "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums,  "C")
                THIS.this_nPerlimite  = TratarNulo(perlimite,   "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_cMensagem

        loc_cMensagem = ""

        IF EMPTY(ALLTRIM(THIS.this_cSolicits))
            loc_cMensagem = "Informe o Nome do Solicitante."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cEmps))
            loc_cMensagem = "Informe a Empresa."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cOperas))
            loc_cMensagem = "Informe a Opera" + CHR(231) + CHR(227) + "o."
        ENDIF
        IF EMPTY(loc_cMensagem) AND THIS.this_nDocs = 0
            loc_cMensagem = "Informe o N" + CHR(250) + "mero do Documento."
        ENDIF
        IF EMPTY(loc_cMensagem) AND !THIS.this_lProducao AND THIS.this_nValors = 0
            loc_cMensagem = "Informe o Valor."
        ENDIF
        IF EMPTY(loc_cMensagem) AND EMPTY(ALLTRIM(THIS.this_cMotivos))
            loc_cMensagem = "Informe o Motivo."
        ENDIF

        THIS.this_cMensagemErro = loc_cMensagem
        RETURN EMPTY(loc_cMensagem)
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigPrSnd
    * Chamado apos GeraSenha preencher cIdChaves, Senhads e Horas
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrSnd " + ;
                       "(cidchaves, datas, docs, horas, motivos, operas, senhads, " + ;
                       " solicits, usuars, valors, tipos, emps, fpags, empdopnums, perlimite) " + ;
                       "VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves,   20)) + ", " + ;
                       "GETDATE(), " + ;
                       FormatarNumeroSQL(THIS.this_nDocs,     0)   + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Inserir Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigPrSnd por cIdChaves
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSnd SET " + ;
                       "datas        = GETDATE(), " + ;
                       "docs         = " + FormatarNumeroSQL(THIS.this_nDocs,     0) + ", " + ;
                       "horas        = " + EscaparSQL(LEFT(THIS.this_cHoras,       8)) + ", " + ;
                       "motivos      = " + EscaparSQL(LEFT(THIS.this_cMotivos,    40)) + ", " + ;
                       "operas       = " + EscaparSQL(LEFT(THIS.this_cOperas,     20)) + ", " + ;
                       "senhads      = " + EscaparSQL(LEFT(THIS.this_cSenhads,     6)) + ", " + ;
                       "solicits     = " + EscaparSQL(LEFT(THIS.this_cSolicits,   10)) + ", " + ;
                       "usuars       = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado,   10)) + ", " + ;
                       "valors       = " + FormatarNumeroSQL(THIS.this_nValors,    2)  + ", " + ;
                       "tipos        = " + FormatarNumeroSQL(THIS.this_nTipos,     0)  + ", " + ;
                       "emps         = " + EscaparSQL(LEFT(THIS.this_cEmps,        3)) + ", " + ;
                       "fpags        = " + EscaparSQL(LEFT(THIS.this_cFpags,      12)) + ", " + ;
                       "empdopnums   = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ", " + ;
                       "perlimite    = " + FormatarNumeroSQL(THIS.this_nPerlimite, 2)  + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cIdChaves, 20))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro ao Atualizar Senha do Dia")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - Registra operacao na LogAuditoria
    * par_cOperacao: "I" inserir, "A" alterar, "E" excluir
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nRet

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigPrSnd")                           + ", " + ;
                       EscaparSQL(par_cOperacao)                        + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cIdChaves, 20))        + ", " + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 50))        + ", " + ;
                       "GETDATE()" + ;
                       ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            && auditoria nao pode bloquear operacao principal
        ENDTRY
    ENDPROC

    *==========================================================================
    * GeraSenha - Gera senha diaria e persiste em SigPrSnd
    * Retorna a senha gerada ou "" em caso de erro
    * Deve ser chamado apos ValidarDados() retornar .T.
    *==========================================================================
    FUNCTION GeraSenha()
        LOCAL loc_lSucesso, loc_lSenhDEmps, loc_nNum, loc_cSenha, loc_lValido

        loc_lSucesso   = .F.
        loc_lSenhDEmps = .F.
        loc_lValido    = .F.
        loc_nNum       = 0
        loc_cSenha     = ""

        TRY
            loc_lValido = THIS.ValidarDados()

            IF loc_lValido
                loc_lSenhDEmps = THIS.BuscarSenhDEmps()

                IF loc_lSenhDEmps
                    loc_nNum = THIS.BuscarNumeroEmpresa()
                    loc_nNum = loc_nNum + THIS.BuscarNumeroFpag()
                    loc_nNum = loc_nNum + (THIS.this_nValors * 100)
                ENDIF

                *-- Gerar senha pelo algoritmo legado
                loc_cSenha = fGerPswDiario(THIS.this_nDocs, THIS.this_dDatas, loc_nNum)

                *-- Preencher campos gerados antes de inserir
                THIS.this_cSenhads    = LEFT(loc_cSenha, 6)
                THIS.this_cHoras      = LEFT(TIME(), 8)
                THIS.this_cIdChaves   = fUniqueIds()
                THIS.this_nTipos      = IIF(THIS.this_lProducao, 1, 0)
                THIS.this_cEmpdopnums = SPACE(29)
                THIS.this_nPerlimite  = 0
                THIS.this_cUsuars     = LEFT(gc_4c_UsuarioLogado, 10)

                IF THIS.Inserir()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro GeraSenha")
            loc_cSenha = ""
        ENDTRY

        RETURN IIF(loc_lSucesso, loc_cSenha, "")
    ENDFUNC

    *==========================================================================
    * BuscarSenhDEmps - Consulta flag SigCdPac.senhdemps
    * Retorna .T. se a senha depende de empresa+pagamento
    *==========================================================================
    PROTECTED FUNCTION BuscarSenhDEmps()
        LOCAL loc_lSenhDEmps, loc_nRet

        loc_lSenhDEmps = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "SELECT senhdemps FROM SigCdPac", "cursor_4c_Pac")
            IF loc_nRet > 0 AND USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                SELECT cursor_4c_Pac
                loc_lSenhDEmps = cursor_4c_Pac.senhdemps
            ENDIF
            IF USED("cursor_4c_Pac")
                USE IN cursor_4c_Pac
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarSenhDEmps")
        ENDTRY

        RETURN loc_lSenhDEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroEmpresa - Busca SigCdEmp.nemps pelo codigo da empresa
    * Retorna valor numerico de nemps (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroEmpresa()
        LOCAL loc_nEmps, loc_nRet, loc_cSQL

        loc_nEmps = 0

        TRY
            loc_cSQL = "SELECT nemps FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3))

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp")
            IF loc_nRet > 0 AND USED("cursor_4c_Emp") AND !EOF("cursor_4c_Emp")
                SELECT cursor_4c_Emp
                loc_nEmps = NVL(cursor_4c_Emp.nemps, 0)
            ENDIF
            IF USED("cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroEmpresa")
        ENDTRY

        RETURN loc_nEmps
    ENDFUNC

    *==========================================================================
    * BuscarNumeroFpag - Busca SigOpFp.nfpags pelo codigo de pagamento
    * Retorna valor numerico de nfpags (0 se nao encontrar)
    *==========================================================================
    PROTECTED FUNCTION BuscarNumeroFpag()
        LOCAL loc_nFpags, loc_nRet, loc_cSQL

        loc_nFpags = 0

        TRY
            IF !EMPTY(ALLTRIM(THIS.this_cFpags))
                loc_cSQL = "SELECT nfpags FROM SigOpFp WHERE Fpags = " + ;
                           EscaparSQL(LEFT(THIS.this_cFpags, 12))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fpag")
                IF loc_nRet > 0 AND USED("cursor_4c_Fpag") AND !EOF("cursor_4c_Fpag")
                    SELECT cursor_4c_Fpag
                    loc_nFpags = NVL(cursor_4c_Fpag.nfpags, 0)
                ENDIF
                IF USED("cursor_4c_Fpag")
                    USE IN cursor_4c_Fpag
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro BuscarNumeroFpag")
        ENDTRY

        RETURN loc_nFpags
    ENDFUNC

ENDDEFINE

