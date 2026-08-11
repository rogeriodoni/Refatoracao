# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 235: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormGrupo.prg) - TRECHOS RELEVANTES PARA PASS GRID (990 linhas total):

*-- Linhas 221 a 251:
221:     ENDPROC
222: 
223:     *==========================================================================
224:     * ConfigurarPaginaLista - Cria grid e botoes de acao do form operacional
225:     * Grid grd_4c_Dados: lista grupos editaveis da operacao (cursor_4c_Ope)
226:     * Botoes standalone: Inserir, Excluir, Confirmar, Cancelar
227:     *==========================================================================
228:     PROTECTED PROCEDURE ConfigurarPaginaLista()
229:         LOCAL loc_oErro
230: 
231:         TRY
232:             *-- Grid de grupos (GradeOpe do legado: Top=115, Left=236, W=264, H=274)
233:             THIS.AddObject("grd_4c_Dados", "Grid")
234:             THIS.grd_4c_Dados.ColumnCount  = 2
235:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Ope"
236:             WITH THIS.grd_4c_Dados
237:                 .Top          = 115
238:                 .Left         = 236
239:                 .Width        = 264
240:                 .Height       = 274
241:                 .RecordMark   = .F.
242:                 .DeleteMark   = .F.
243:                 .RowHeight    = 16
244:                 .ScrollBars   = 2
245:                 .FontName     = "Tahoma"
246:                 .FontSize     = 8
247:                 .ForeColor    = RGB(90,90,90)
248:                 .GridLineColor      = RGB(238,238,238)
249:                 .HighlightBackColor = RGB(255,255,255)
250:                 .HighlightForeColor = RGB(15,41,104)
251:                 .HighlightStyle     = 2

*-- Linhas 258 a 313:
258:                     .FontName      = "Tahoma"
259:                     .FontSize      = 8
260:                     .ForeColor     = RGB(90,90,90)
261:                     .Header1.Caption   = "Grupo"
262:                     .Header1.FontName  = "Tahoma"
263:                     .Header1.FontSize  = 8
264:                     .Header1.Alignment = 2
265:                     .Header1.ForeColor = RGB(36,84,155)
266:                     WITH .Text1
267:                         .BorderStyle = 0
268:                         .Margin      = 0
269:                         .ForeColor   = RGB(90,90,90)
270:                         .BackColor   = RGB(255,255,255)
271:                     ENDWITH
272:                 ENDWITH
273: 
274:                 WITH .Column2
275:                     .ControlSource = "cursor_4c_Ope.Dgrus"
276:                     .Width         = 180
277:                     .Movable       = .F.
278:                     .Resizable     = .F.
279:                     .ReadOnly      = .T.
280:                     .FontName      = "Tahoma"
281:                     .FontSize      = 8
282:                     .ForeColor     = RGB(90,90,90)
283:                     .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
284:                     .Header1.FontName  = "Tahoma"
285:                     .Header1.FontSize  = 8
286:                     .Header1.Alignment = 2
287:                     .Header1.ForeColor = RGB(36,84,155)
288:                     WITH .Text1
289:                         .BorderStyle = 0
290:                         .Margin      = 0
291:                         .ForeColor   = RGB(90,90,90)
292:                         .BackColor   = RGB(255,255,255)
293:                     ENDWITH
294:                 ENDWITH
295:             ENDWITH
296: 
297:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdOpeAfterRowColChange")
298:             BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtGrupoKeyPress")
299: 
300:             *-- Botao Inserir (cmdInserir do legado: Top=3, Left=500)
301:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
302:             WITH THIS.cmd_4c_Inserir
303:                 .Top             = 3
304:                 .Left            = 500
305:                 .Width           = 75
306:                 .Height          = 75
307:                 .Caption         = "\<Inserir"
308:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
309:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
310:                 .FontName        = "Tahoma"
311:                 .FontBold        = .T.
312:                 .FontItalic      = .T.
313:                 .FontSize        = 8

*-- Linhas 412 a 458:
412:     *==========================================================================
413:     PROCEDURE BtnInserirClick()
414:         IF THIS.this_oBusinessObject.InserirLinhaGrid()
415:             THIS.grd_4c_Dados.Refresh()
416:             THIS.grd_4c_Dados.Column1.SetFocus
417:         ENDIF
418:     ENDPROC
419: 
420:     *==========================================================================
421:     * BtnExcluirClick - Remove linha corrente do grid de grupos
422:     * Replicado de cmdExcluir.Click do legado
423:     *==========================================================================
424:     PROCEDURE BtnExcluirClick()
425:         IF THIS.this_oBusinessObject.ExcluirLinhaGrid()
426:             THIS.grd_4c_Dados.Refresh()
427:             THIS.grd_4c_Dados.SetFocus
428:         ENDIF
429:     ENDPROC
430: 
431:     *==========================================================================
432:     * BtnIncluirClick - Insere nova linha em branco no grid de grupos
433:     * Equivalente CRUD de BtnInserirClick (delegacao para o metodo canonico)
434:     * Habilita gravacao e posiciona foco na coluna Cgrus para digitacao/lookup
435:     *==========================================================================
436:     PROCEDURE BtnIncluirClick()
437:         LOCAL loc_oErro
438: 
439:         TRY
440:             IF THIS.this_oBusinessObject.InserirLinhaGrid()
441:                 THIS.grd_4c_Dados.Refresh()
442:                 THIS.grd_4c_Dados.SetFocus
443:                 THIS.grd_4c_Dados.Column1.SetFocus
444:             ENDIF
445:         CATCH TO loc_oErro
446:             MsgErro(loc_oErro.Message + CHR(13) + ;
447:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
448:                     "Procedure: " + loc_oErro.Procedure, ;
449:                     "Erro em BtnIncluirClick")
450:         ENDTRY
451:     ENDPROC
452: 
453:     *==========================================================================
454:     * BtnAlterarClick - Ativa modo de edicao dos grupos ja carregados
455:     * Libera edicao na coluna Cgrus do grid, habilita campo Grande Grupo
456:     * e posiciona foco no primeiro registro para permitir alteracao
457:     *==========================================================================
458:     PROCEDURE BtnAlterarClick()

*-- Linhas 468 a 496:
468:             ENDIF
469: 
470:             *-- Habilita edicao (Cgrus editavel + campo Grande Grupo)
471:             THIS.grd_4c_Dados.Column1.ReadOnly = .F.
472:             THIS.grd_4c_Dados.Column1.Enabled  = .T.
473:             THIS.txt_4c_GdeGrps.Enabled        = .T.
474:             THIS.this_oBusinessObject.this_lGravaDados = .T.
475: 
476:             *-- Posiciona no primeiro registro para edicao
477:             SELECT cursor_4c_Ope
478:             GO TOP IN cursor_4c_Ope
479:             THIS.grd_4c_Dados.Refresh()
480:             THIS.grd_4c_Dados.SetFocus
481:             THIS.grd_4c_Dados.Column1.SetFocus
482: 
483:         CATCH TO loc_oErro
484:             MsgErro(loc_oErro.Message + CHR(13) + ;
485:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
486:                     "Procedure: " + loc_oErro.Procedure, ;
487:                     "Erro em BtnAlterarClick")
488:         ENDTRY
489:     ENDPROC
490: 
491:     *==========================================================================
492:     * BtnVisualizarClick - Ativa modo somente-leitura dos grupos carregados
493:     * Bloqueia edicao no grid e campos auxiliares (Grande Grupo + Carregar)
494:     * mantendo navegacao livre entre os registros ja gravados
495:     *==========================================================================
496:     PROCEDURE BtnVisualizarClick()

*-- Linhas 505 a 529:
505:             ENDIF
506: 
507:             *-- Bloqueia edicao (Cgrus read-only + desabilita auxiliares)
508:             THIS.grd_4c_Dados.Column1.ReadOnly = .T.
509:             THIS.txt_4c_GdeGrps.Enabled        = .F.
510: 
511:             SELECT cursor_4c_Ope
512:             GO TOP IN cursor_4c_Ope
513:             THIS.grd_4c_Dados.Refresh()
514:             THIS.grd_4c_Dados.SetFocus
515: 
516:         CATCH TO loc_oErro
517:             MsgErro(loc_oErro.Message + CHR(13) + ;
518:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
519:                     "Procedure: " + loc_oErro.Procedure, ;
520:                     "Erro em BtnVisualizarClick")
521:         ENDTRY
522:     ENDPROC
523: 
524:     *==========================================================================
525:     * BtnConfirmarClick - Valida duplicatas e salva no SQL Server, entao fecha
526:     * Replicado de cmdSair.Click do legado
527:     *==========================================================================
528:     PROCEDURE BtnConfirmarClick()
529:         IF THIS.this_oBusinessObject.this_lGravaDados

*-- Linhas 555 a 573:
555:                 IF THIS.this_oBusinessObject.ValidarGrupo(loc_cCgrus)
556:                     THIS.this_oBusinessObject.this_lGravaDados = .T.
557:                 ENDIF
558:                 THIS.grd_4c_Dados.Refresh()
559:             ENDIF
560:         ENDIF
561:     ENDPROC
562: 
563:     *==========================================================================
564:     * TxtGrupoKeyPress - Abre picker ao pressionar F4 em Column1 (Cgrus)
565:     * Replicado do Valid do legado: abria fwBuscaExt para SigCdGrp
566:     *==========================================================================
567:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
568:         IF par_nKeyCode != 115
569:             RETURN
570:         ENDIF
571:         THIS.AbrirBuscaGrupo()
572:     ENDPROC
573: 

*-- Linhas 583 a 626:
583:                                        "SigCdGrp", ;
584:                                        "cursor_4c_BuscaGrp", ;
585:                                        "Cgrus", ;
586:                                        ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value), ;
587:                                        "Grupo de Produto", ;
588:                                        .T., .T., "")
589: 
590:             IF VARTYPE(loc_oBusca) = "O"
591:                 loc_oBusca.mAddColuna("Cgrus", "", "Grupo")
592:                 loc_oBusca.mAddColuna("Dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
593:                 loc_oBusca.Show()
594: 
595:                 IF loc_oBusca.this_lSelecionou
596:                     IF USED("cursor_4c_BuscaGrp") AND !EOF("cursor_4c_BuscaGrp")
597:                         THIS.grd_4c_Dados.Column1.Text1.Value = ;
598:                             ALLTRIM(cursor_4c_BuscaGrp.Cgrus)
599:                         IF USED("cursor_4c_Ope") AND !EOF("cursor_4c_Ope")
600:                             REPLACE Dgrus WITH ALLTRIM(cursor_4c_BuscaGrp.Dgrus) ;
601:                                 IN cursor_4c_Ope
602:                         ENDIF
603:                         THIS.this_oBusinessObject.this_lGravaDados = .T.
604:                     ENDIF
605:                 ENDIF
606: 
607:                 IF USED("cursor_4c_BuscaGrp")
608:                     USE IN cursor_4c_BuscaGrp
609:                 ENDIF
610: 
611:                 THIS.grd_4c_Dados.Refresh()
612:             ENDIF
613: 
614:         CATCH TO loc_oErro
615:             MsgErro(loc_oErro.Message + CHR(13) + ;
616:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
617:                     "Procedure: " + loc_oErro.Procedure, ;
618:                     "Erro ao abrir busca de grupo")
619:         ENDTRY
620:     ENDPROC
621: 
622:     *==========================================================================
623:     * AlternarPagina - Navega entre as regioes logicas do form operacional
624:     * Form single-page (sem PageFrame): alterna foco entre grid e campo edicao
625:     *   par_nPagina = 1 -> foco no grid (view lista)
626:     *   par_nPagina = 2 -> foco na celula editavel do Cgrus (view edicao)

*-- Linhas 632 a 660:
632:             IF par_nPagina = 2
633:                 *-- Modo edicao: posiciona no Cgrus para digitar/lookup
634:                 IF USED("cursor_4c_Ope") AND RECCOUNT("cursor_4c_Ope") > 0
635:                     THIS.grd_4c_Dados.SetFocus
636:                     THIS.grd_4c_Dados.Column1.SetFocus
637:                 ELSE
638:                     *-- Sem registros: forca inserir uma linha em branco
639:                     THIS.BtnInserirClick()
640:                 ENDIF
641:             ELSE
642:                 *-- Modo lista (default): foco no grid
643:                 THIS.grd_4c_Dados.SetFocus
644:             ENDIF
645:             THIS.grd_4c_Dados.Refresh()
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message + CHR(13) + ;
648:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
649:                     "Procedure: " + loc_oErro.Procedure, ;
650:                     "Erro em AlternarPagina")
651:         ENDTRY
652:     ENDPROC
653: 
654:     *==========================================================================
655:     * ConfigurarPaginaDados - Adiciona Label e TextBox do Grande Grupo
656:     * Fase 5/8: primeira metade dos campos (label + textbox)
657:     * Corresponde a Say4 + getGdeGrps do legado
658:     * Campo habilita somente se parent form esta em modo INCLUIR/ALTERAR
659:     *==========================================================================
660:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 788 a 807:
788:                                        .T., .T., "")
789: 
790:             IF VARTYPE(loc_oBusca) = "O"
791:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
792:                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
793:                 loc_oBusca.Show()
794: 
795:                 IF loc_oBusca.this_lSelecionou
796:                     IF USED("cursor_4c_BuscaGde") AND !EOF("cursor_4c_BuscaGde")
797:                         THIS.txt_4c_GdeGrps.Value = ALLTRIM(cursor_4c_BuscaGde.Codigos)
798:                     ENDIF
799:                 ENDIF
800: 
801:                 IF USED("cursor_4c_BuscaGde")
802:                     USE IN cursor_4c_BuscaGde
803:                 ENDIF
804:             ENDIF
805: 
806:         CATCH TO loc_oErro
807:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 837 a 875:
837:             ENDIF
838: 
839:             IF THIS.this_oBusinessObject.CarregarGrandeGrupo(loc_cGde)
840:                 THIS.grd_4c_Dados.Refresh()
841:                 THIS.grd_4c_Dados.Column1.SetFocus
842:             ENDIF
843: 
844:         CATCH TO loc_oErro
845:             MsgErro(loc_oErro.Message + CHR(13) + ;
846:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
847:                     "Procedure: " + loc_oErro.Procedure, ;
848:                     "Erro em BtnCarregarClick")
849:         ENDTRY
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * CarregarLista - Recarrega cursor_4c_Ope do SQL Server descartando alteracoes
854:     *==========================================================================
855:     PROCEDURE CarregarLista()
856:         LOCAL loc_oErro
857: 
858:         TRY
859:             IF THIS.this_oBusinessObject.InicializarDados(THIS.this_oBusinessObject.this_cDopes)
860:                 THIS.grd_4c_Dados.Refresh()
861:             ENDIF
862: 
863:         CATCH TO loc_oErro
864:             MsgErro(loc_oErro.Message + CHR(13) + ;
865:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
866:                     "Procedure: " + loc_oErro.Procedure, ;
867:                     "Erro em CarregarLista")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *==========================================================================
872:     * FormParaBO - Mapeia estado do form para o Business Object
873:     *==========================================================================
874:     PROTECTED PROCEDURE FormParaBO()
875:         WITH THIS.this_oBusinessObject

*-- Linhas 893 a 924:
893:         THIS.cmd_4c_Inserir.Enabled        = par_lHabilitar
894:         THIS.cmd_4c_Excluir.Enabled        = par_lHabilitar
895:         THIS.cmd_4c_Confirmar.Enabled      = par_lHabilitar
896:         THIS.grd_4c_Dados.Column1.ReadOnly = !par_lHabilitar
897:     ENDPROC
898: 
899:     *==========================================================================
900:     * LimparCampos - Limpa o campo Grande Grupo e esvazia o grid local
901:     *==========================================================================
902:     PROCEDURE LimparCampos()
903:         THIS.txt_4c_GdeGrps.Value                   = ""
904:         THIS.this_oBusinessObject.this_cGdeGrps     = ""
905:         THIS.this_oBusinessObject.this_lGravaDados  = .F.
906:         IF USED("cursor_4c_Ope")
907:             SELECT cursor_4c_Ope
908:             ZAP
909:             THIS.grd_4c_Dados.Refresh()
910:         ENDIF
911:     ENDPROC
912: 
913:     *==========================================================================
914:     * AjustarBotoesPorModo - Habilita/desabilita controles conforme modo do pai
915:     * Replica logica When do legado: InList(ParentForm.pcEscolha, INSERIR, ALTERAR)
916:     *==========================================================================
917:     PROCEDURE AjustarBotoesPorModo()
918:         LOCAL loc_lHabilitado
919: 
920:         loc_lHabilitado = .T.
921: 
922:         IF VARTYPE(THIS.this_oParentForm) = "O" AND ;
923:            PEMSTATUS(THIS.this_oParentForm, "this_cModoAtual", 5)
924:             loc_lHabilitado = INLIST(THIS.this_oParentForm.this_cModoAtual, ;

