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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPPP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1310 linhas total):

*-- Linhas 192 a 218:
192:     *                     CommandGroup com o unico botao "Encerrar", so
193:     *                     estrutura visual - o Click entra na Fase 7-8),
194:     *                     ConfigurarDecoracaoOperacoes()/
195:     *                     ConfigurarDecoracaoItens() (shp_4c_*/lbl_4c_*) e
196:     *                     as duas grades: ConfigurarGridOperacoes()
197:     *                     (grd_4c_Operacoes, MESTRE - SigMvCab) e
198:     *                     ConfigurarGridItens() (grd_4c_Itens, DETALHE -
199:     *                     SigMvItn+SigCdPro). As duas grades nascem ligadas
200:     *                     aos cursores do BO (cursor_4c_Operacoes/
201:     *                     cursor_4c_Itens, garantidos antes do RecordSource
202:     *                     - regra #41) e CarregarLista()/RepintarGrades()
203:     *                     fazem a carga inicial a partir do cursor que o
204:     *                     form pai deixou pronto (TprMvCab).
205:     *   Fase 5 (feita)  - campos de exibicao somente-leitura, metade 1:
206:     *                     ConfigurarCampoConta() (shp_4c_Shp_cliente_periodo
207:     *                     - moldura que cobre tambem a linha de Periodo -,
208:     *                     lbl_4c_Lbl_cliente, txt_4c__cliente,
209:     *                     txt_4c__cliente_desc) e ConfigurarCampoPeriodo()
210:     *                     (lbl_4c_Lbl_periodo, txt_4c__dt_inicial,
211:     *                     txt_4c__dt_final, lbl_4c_Lbl_periodo_a). So
212:     *                     estrutura visual, ainda SEM popular .Value.
213:     *   Fase 6 (esta)   - ConfigurarCampoGrupo() (lbl_4c_Label4/
214:     *                     txt_4c_Grupo - dump: Say4/Get_grupo), fechando
215:     *                     os 5 campos de exibicao, mais
216:     *                     CarregarFiltrosDoFormPai() (chamado em
217:     *                     InicializarForm, antes de CarregarLista), que le
218:     *                     THIS.this_oFormPai.this_oBusinessObject

*-- Linhas 305 a 352:
305:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
306:             loc_oCnt = THIS.cnt_4c_Cabecalho
307:             WITH loc_oCnt
308:                 .Top         = 0
309:                 .Left        = 0
310:                 .Width       = THIS.Width
311:                 .Height      = 80
312:                 .BorderWidth = 0
313:                 .BackColor   = RGB(100, 100, 100)
314:                 .Visible     = .T.
315:             ENDWITH
316: 
317:             loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
318:             WITH loc_oCnt.lbl_4c_Sombra
319:                 .FontBold  = .T.
320:                 .FontName  = "Tahoma"
321:                 .FontSize  = 16
322:                 .WordWrap  = .T.
323:                 .Alignment = 0
324:                 .BackStyle = 0
325:                 .AutoSize  = .F.
326:                 .Caption   = THIS.Caption
327:                 .Height    = 40
328:                 .Left      = 10
329:                 .Top       = 15
330:                 .Width     = 769
331:                 .ForeColor = RGB(0, 0, 0)
332:                 .Visible   = .T.
333:             ENDWITH
334: 
335:             loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
336:             WITH loc_oCnt.lbl_4c_Titulo
337:                 .FontBold  = .T.
338:                 .FontName  = "Tahoma"
339:                 .FontSize  = 16
340:                 .WordWrap  = .T.
341:                 .Alignment = 0
342:                 .BackStyle = 0
343:                 .AutoSize  = .F.
344:                 .Caption   = THIS.Caption
345:                 .Height    = 46
346:                 .Left      = 10
347:                 .Top       = 18
348:                 .Width     = 769
349:                 .ForeColor = RGB(255, 255, 255)
350:                 .Visible   = .T.
351:             ENDWITH
352:         CATCH TO loc_oErro

*-- Linhas 378 a 428:
378:         TRY
379:             THIS.AddObject("shp_4c_Shp_cliente_periodo", "Shape")
380:             WITH THIS.shp_4c_Shp_cliente_periodo
381:                 .Top           = 108
382:                 .Left          = 132
383:                 .Width         = 484
384:                 .Height        = 90
385:                 .BackStyle     = 0
386:                 .SpecialEffect = 1
387:                 .Visible       = .T.
388:             ENDWITH
389: 
390:             THIS.AddObject("lbl_4c_Lbl_cliente", "Label")
391:             WITH THIS.lbl_4c_Lbl_cliente
392:                 .Top       = 174
393:                 .Left      = 152
394:                 .Width     = 41
395:                 .Height    = 17
396:                 .AutoSize  = .F.
397:                 .Alignment = 0
398:                 .BackStyle = 0
399:                 .FontName  = "Tahoma"
400:                 .FontSize  = 8
401:                 .ForeColor = RGB(90, 90, 90)
402:                 .TabIndex  = 7
403:                 .Caption   = "Conta :"
404:                 .Visible   = .T.
405:             ENDWITH
406: 
407:             THIS.AddObject("txt_4c__cliente", "TextBox")
408:             WITH THIS.txt_4c__cliente
409:                 .Top       = 169
410:                 .Left      = 197
411:                 .Width     = 80
412:                 .FontName  = "Courier New"
413:                 .ReadOnly  = .T.
414:                 .TabStop   = .F.
415:                 .TabIndex  = 4
416:                 .Value     = ""
417:                 .Visible   = .T.
418:             ENDWITH
419: 
420:             THIS.AddObject("txt_4c__cliente_desc", "TextBox")
421:             WITH THIS.txt_4c__cliente_desc
422:                 .Top       = 169
423:                 .Left      = 279
424:                 .Width     = 290
425:                 .ReadOnly  = .T.
426:                 .TabStop   = .F.
427:                 .TabIndex  = 5
428:                 .Value     = ""

*-- Linhas 451 a 513:
451:         LOCAL loc_oErro
452: 
453:         TRY
454:             THIS.AddObject("lbl_4c_Lbl_periodo", "Label")
455:             WITH THIS.lbl_4c_Lbl_periodo
456:                 .Top       = 121
457:                 .Left      = 143
458:                 .Width     = 50
459:                 .Height    = 17
460:                 .AutoSize  = .F.
461:                 .Alignment = 0
462:                 .BackStyle = 0
463:                 .FontName  = "Tahoma"
464:                 .FontSize  = 8
465:                 .ForeColor = RGB(90, 90, 90)
466:                 .TabIndex  = 8
467:                 .Caption   = "Per" + CHR(237) + "odo :"
468:                 .Visible   = .T.
469:             ENDWITH
470: 
471:             THIS.AddObject("txt_4c__dt_inicial", "TextBox")
472:             WITH THIS.txt_4c__dt_inicial
473:                 .Top       = 116
474:                 .Left      = 197
475:                 .Width     = 80
476:                 .ReadOnly  = .T.
477:                 .TabStop   = .F.
478:                 .TabIndex  = 1
479:                 .Value     = {}
480:                 .Visible   = .T.
481:             ENDWITH
482: 
483:             THIS.AddObject("txt_4c__dt_final", "TextBox")
484:             WITH THIS.txt_4c__dt_final
485:                 .Top       = 116
486:                 .Left      = 290
487:                 .Width     = 80
488:                 .ReadOnly  = .T.
489:                 .TabStop   = .F.
490:                 .TabIndex  = 2
491:                 .Value     = {}
492:                 .Visible   = .T.
493:             ENDWITH
494: 
495:             THIS.AddObject("lbl_4c_Lbl_periodo_a", "Label")
496:             WITH THIS.lbl_4c_Lbl_periodo_a
497:                 .Top       = 121
498:                 .Left      = 280
499:                 .Width     = 10
500:                 .Height    = 17
501:                 .AutoSize  = .F.
502:                 .Alignment = 0
503:                 .BackStyle = 0
504:                 .FontName  = "Tahoma"
505:                 .FontSize  = 8
506:                 .ForeColor = RGB(90, 90, 90)
507:                 .TabIndex  = 9
508:                 .Caption   = CHR(224)
509:                 .Visible   = .T.
510:             ENDWITH
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message + CHR(13) + ;
513:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 535 a 563:
535:         LOCAL loc_oErro
536: 
537:         TRY
538:             THIS.AddObject("lbl_4c_Label4", "Label")
539:             WITH THIS.lbl_4c_Label4
540:                 .Top       = 147
541:                 .Left      = 151
542:                 .Width     = 41
543:                 .Height    = 17
544:                 .AutoSize  = .F.
545:                 .Alignment = 0
546:                 .BackStyle = 0
547:                 .FontName  = "Tahoma"
548:                 .FontSize  = 8
549:                 .ForeColor = RGB(90, 90, 90)
550:                 .TabIndex  = 6
551:                 .Caption   = "Grupo :"
552:                 .Visible   = .T.
553:             ENDWITH
554: 
555:             THIS.AddObject("txt_4c_Grupo", "TextBox")
556:             WITH THIS.txt_4c_Grupo
557:                 .Top       = 144
558:                 .Left      = 197
559:                 .Width     = 80
560:                 .Height    = 23
561:                 .ReadOnly  = .T.
562:                 .TabStop   = .F.
563:                 .TabIndex  = 3

*-- Linhas 588 a 621:
588:         TRY
589:             THIS.AddObject("cmg_4c_Grp_operacao", "CommandGroup")
590:             WITH THIS.cmg_4c_Grp_operacao
591:                 .Top           = -2
592:                 .Left          = 717
593:                 .Width         = 85
594:                 .Height        = 85
595:                 .ButtonCount   = 1
596:                 .BackStyle     = 0
597:                 .BorderStyle   = 0
598:                 .SpecialEffect = 1
599:                 .BorderColor   = RGB(136, 188, 189)
600:                 .Themes        = .F.
601:                 .Visible       = .T.
602:             ENDWITH
603: 
604:             WITH THIS.cmg_4c_Grp_operacao.Buttons(1)
605:                 .Top               = 5
606:                 .Left              = 5
607:                 .Width             = 75
608:                 .Height            = 75
609:                 .FontBold          = .T.
610:                 .FontItalic        = .T.
611:                 .FontName          = "Comic Sans MS"
612:                 .FontSize          = 8
613:                 .WordWrap          = .T.
614:                 .Picture           = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
615:                 .Cancel            = .T.
616:                 .Caption           = "Encerrar"
617:                 .ToolTipText       = "[ESC] - Encerrar"
618:                 .ForeColor         = RGB(90, 90, 90)
619:                 .BackColor         = RGB(255, 255, 255)
620:                 .DisabledBackColor = RGB(255, 255, 255)
621:                 .Themes            = .F.

*-- Linhas 644 a 673:
644:         TRY
645:             THIS.AddObject("shp_4c_Operacoes", "Shape")
646:             WITH THIS.shp_4c_Operacoes
647:                 .Top           = 224
648:                 .Left          = 133
649:                 .Width         = 484
650:                 .Height        = 112
651:                 .BackStyle     = 0
652:                 .SpecialEffect = 1
653:                 .Visible       = .T.
654:             ENDWITH
655: 
656:             THIS.AddObject("lbl_4c_Operacoes", "Label")
657:             WITH THIS.lbl_4c_Operacoes
658:                 .Top       = 210
659:                 .Left      = 143
660:                 .Width     = 92
661:                 .Height    = 15
662:                 .AutoSize  = .F.
663:                 .FontBold  = .T.
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .BackStyle = 0
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
669:                 .Visible   = .T.
670:             ENDWITH
671:         CATCH TO loc_oErro
672:             MsgErro(loc_oErro.Message + CHR(13) + ;
673:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 686 a 715:
686:         TRY
687:             THIS.AddObject("shp_4c_Itens", "Shape")
688:             WITH THIS.shp_4c_Itens
689:                 .Top           = 354
690:                 .Left          = 133
691:                 .Width         = 511
692:                 .Height        = 127
693:                 .BackStyle     = 0
694:                 .SpecialEffect = 1
695:                 .Visible       = .T.
696:             ENDWITH
697: 
698:             THIS.AddObject("lbl_4c_Itens", "Label")
699:             WITH THIS.lbl_4c_Itens
700:                 .Top       = 339
701:                 .Left      = 143
702:                 .Width     = 38
703:                 .Height    = 15
704:                 .AutoSize  = .F.
705:                 .FontBold  = .T.
706:                 .FontName  = "Tahoma"
707:                 .FontSize  = 8
708:                 .BackStyle = 0
709:                 .ForeColor = RGB(90, 90, 90)
710:                 .Caption   = " " + CHR(205) + "tens "
711:                 .Visible   = .T.
712:             ENDWITH
713:         CATCH TO loc_oErro
714:             MsgErro(loc_oErro.Message + CHR(13) + ;
715:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 740 a 749:
740:             loc_oGrid = THIS.grd_4c_Operacoes
741: 
742:             WITH loc_oGrid
743:                 .Top         = 234
744:                 .Left        = 140
745:                 .Width       = 469
746:                 .Height      = 94
747:                 .FontName    = "Arial"
748:                 .FontSize    = 8
749:                 .DeleteMark  = .F.

*-- Linhas 770 a 778:
770:                 .Header1.FontSize  = 8
771:                 .Header1.Alignment = 2
772:                 .Header1.ForeColor = RGB(90, 90, 90)
773:                 .Header1.Caption   = "Emp."
774:                 .Text1.FontName    = "Courier New"
775:                 .Text1.BorderStyle = 0
776:                 .Text1.Margin      = 0
777:                 .Text1.ReadOnly    = .T.
778:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 789 a 797:
789:                 .Header1.FontSize  = 8
790:                 .Header1.Alignment = 2
791:                 .Header1.ForeColor = RGB(90, 90, 90)
792:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
793:                 .Text1.FontName    = "Courier New"
794:                 .Text1.BorderStyle = 0
795:                 .Text1.Margin      = 0
796:                 .Text1.ReadOnly    = .T.
797:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 808 a 816:
808:                 .Header1.FontSize  = 8
809:                 .Header1.Alignment = 2
810:                 .Header1.ForeColor = RGB(90, 90, 90)
811:                 .Header1.Caption   = "N" + CHR(250) + "mero"
812:                 .Text1.FontName    = "Courier New"
813:                 .Text1.BorderStyle = 0
814:                 .Text1.Margin      = 0
815:                 .Text1.ReadOnly    = .T.
816:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 827 a 835:
827:                 .Header1.FontSize  = 8
828:                 .Header1.Alignment = 2
829:                 .Header1.ForeColor = RGB(90, 90, 90)
830:                 .Header1.Caption   = "Data"
831:                 .Text1.FontName    = "Courier New"
832:                 .Text1.BorderStyle = 0
833:                 .Text1.Margin      = 0
834:                 .Text1.ReadOnly    = .T.
835:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 847 a 855:
847:                 .Header1.FontSize  = 8
848:                 .Header1.Alignment = 2
849:                 .Header1.ForeColor = RGB(90, 90, 90)
850:                 .Header1.Caption   = "Valor"
851:                 .Text1.FontName    = "Courier New"
852:                 .Text1.BorderStyle = 0
853:                 .Text1.Margin      = 0
854:                 .Text1.ReadOnly    = .T.
855:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 883 a 892:
883:             loc_oGrid = THIS.grd_4c_Itens
884: 
885:             WITH loc_oGrid
886:                 .Top         = 363
887:                 .Left        = 140
888:                 .Width       = 497
889:                 .Height      = 112
890:                 .FontName    = "Tahoma"
891:                 .FontSize    = 8
892:                 .DeleteMark  = .F.

*-- Linhas 911 a 919:
911:                 .Header1.FontSize  = 8
912:                 .Header1.Alignment = 2
913:                 .Header1.ForeColor = RGB(90, 90, 90)
914:                 .Header1.Caption   = "Produto"
915:                 .Text1.FontName    = "Tahoma"
916:                 .Text1.BorderStyle = 0
917:                 .Text1.Margin      = 0
918:                 .Text1.ReadOnly    = .T.
919:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 930 a 938:
930:                 .Header1.FontSize  = 8
931:                 .Header1.Alignment = 2
932:                 .Header1.ForeColor = RGB(90, 90, 90)
933:                 .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
934:                 .Text1.FontName    = "Tahoma"
935:                 .Text1.BorderStyle = 0
936:                 .Text1.Margin      = 0
937:                 .Text1.ReadOnly    = .T.
938:                 .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 949 a 957:
949:                 .Header1.FontSize  = 8
950:                 .Header1.Alignment = 2
951:                 .Header1.ForeColor = RGB(90, 90, 90)
952:                 .Header1.Caption   = "Qtde."
953:                 .Text1.FontName    = "Tahoma"
954:                 .Text1.BorderStyle = 0
955:                 .Text1.Margin      = 0
956:                 .Text1.ReadOnly    = .T.
957:                 .Text1.ForeColor   = RGB(0, 0, 0)


### BO (C:\4c\projeto\app\classes\SIGPRPPPBO.prg):
*====================================================================
* SIGPRPPPBO.prg
*
* Business Object do SIGPRPPP - "Pesquisa de Produtos por Conta".
*
* Formulario OPERACIONAL de CONSULTA (drill-down), aberto como tela
* FILHA pelo FormSigPrPpc: o pai ja validou Grupo/Conta/Periodo,
* executou a consulta em SigMvCab e deixou o resultado no cursor
* TprMvCab (SigPrPpcBO.ConsultarMovimentacoes preserva esse nome
* EXATAMENTE para esta tela consumir). Aqui a grade de cima lista
* essas movimentacoes e a grade de baixo mostra os itens (SigMvItn)
* da movimentacao selecionada, com a descricao do produto lida AO
* VIVO do cadastro (SigCdPro).
*
* Sobre a ausencia de CRUD neste BO
* ---------------------------------
* O dump legado (tasks\task666\SIGPRPPP_form_codigo_fonte.txt) nao
* tem gravacao de dado de negocio. O unico acesso de escrita remota
* do legado eh ANDAIME de consulta: ele monta a lista de chaves
* Emps+Dopes+Numes na tabela de rascunho SigTempC (Insert Into
* crSigTempC + poDataTmp.Update + Commit), usa essa lista como lado
* esquerdo de um JOIN contra SigMvItn e, logo em seguida, APAGA as
* proprias linhas com fSqlApagarTmp. Era a forma de o Fortyus mandar
* uma lista de chaves ao servidor a partir de um cursor local.
*
* Na arquitetura nova a conexao eh direta ao SQL Server, entao o
* JOIN eh feito na propria consulta dos itens e a SigTempC deixa de
* ser necessaria - nao ha o que gravar. Por isso este BO NAO
* sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
* comportamento herdado de BusinessBase (recusar a operacao e
* reportar pelo ExibirFalha do Salvar) ja eh o correto, e escrever
* um INSERT/UPDATE aqui significaria inventar tabela e colunas, o
* que o PILAR 2 proibe. Pela mesma razao RegistrarAuditoria() nunca
* eh acionado nesta tela: auditoria registra gravacao, e gravacao
* nao existe aqui.
*
* Metodos publicos usados pelo formulario:
*   CarregarOperacoes()               - popula a grade de movimentacoes
*   CarregarDoCursor(par_cAlias)      - le a linha corrente p/ as props
*   CarregarItensDaOperacaoCorrente() - AfterRowColChange da grade
*   CarregarItensPorChave(E, D, N)    - itens de uma movimentacao
*   MontarChaveEmpDopNums(E, D, N)    - chave posicional char(29)
*====================================================================

DEFINE CLASS SIGPRPPPBO AS BusinessBase

	*-- Filtros recebidos do formulario chamador (equivalentes as
	*   PRIVATE pcGrupo/pcConta/pcContaDesc/pdInicial/pdFinal que o
	*   legado le no Init). Aqui servem so para exibicao nos campos
	*   somente-leitura do cabecalho - quem filtrou foi o pai.
	this_cGrupo = ""
	this_cConta = ""
	this_cContaDesc = ""
	this_dDataInicial = {}
	this_dDataFinal = {}

	*-- Cursor de ORIGEM das movimentacoes, populado pelo form pai
	*   (SigPrPpcBO.ConsultarMovimentacoes). Equivale ao TprMvCab que
	*   o legado recebia pronto na mesma DataSession.
	this_cCursorOrigem = "TprMvCab"

	*-- Cursores das duas grades (equivalem a dbOperacao e dbItens do
	*   DataEnvironment legado)
	this_cCursorOperacoes = "cursor_4c_Operacoes"
	this_cCursorItens = "cursor_4c_Itens"

	*-- Linha CORRENTE da grade de movimentacoes. Os nomes espelham as
	*   colunas de SigMvCab (emps, dopes, numes, datas, valos) para nao
	*   haver divergencia de nome entre BO e Form.
	this_cEmps = ""
	this_cDopes = ""
	this_nNumes = 0
	this_dDatas = {}
	this_nValos = 0

	*====================================================================
	* Init - Inicializa o Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- Tabela de leitura da tela. A chave de negocio eh COMPOSTA
		*   (Emps + Dopes + Numes) e existe materializada em SigMvCab e
		*   SigMvItn como empdopnums char(29) - ver MontarChaveEmpDopNums.
		THIS.this_cTabela = "SigMvCab"
		THIS.this_cCampoChave = "empdopnums"

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cCursorOrigem = "TprMvCab"
		THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
		THIS.this_cCursorItens = "cursor_4c_Itens"

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		RETURN .T.
	ENDPROC

	*====================================================================
	* GarantirCursorOperacoes - Cria o cursor da grade de movimentacoes
	* se ele ainda nao existir.
	*
	* A estrutura eh declarada em UM UNICO lugar (usado tanto na carga
	* quanto na limpeza) porque cursor de grade criado com ordem de
	* campos diferente em pontos diferentes quebra o APPEND FROM, que
	* casa os campos por NOME. Tipos copiados do schema:
	*   SigMvCab.emps  char(3)  / dopes char(20) / numes numeric(6,0)
	*   SigMvCab.datas datetime / valos numeric(11,2)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridOperacoes() (Fase 4), antes de CarregarOperacoes()
	* existir (Fase 7-8), para o cursor ja estar criado quando o Grid
	* recebe RecordSource/ControlSource - regra #41 (ControlSource de
	* cursor ainda inexistente derruba o Init).
	*====================================================================
	PROCEDURE GarantirCursorOperacoes()
		IF !USED(THIS.this_cCursorOperacoes)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorOperacoes) ( ;
				emps C(3) NULL, ;
				dopes C(20) NULL, ;
				numes N(6,0) NULL, ;
				datas T NULL, ;
				valos N(11,2) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* GarantirCursorItens - Cria o cursor da grade de itens se ele ainda
	* nao existir. Tipos copiados do schema:
	*   SigMvItn.cpros char(14) / qtds numeric(9,3)
	*   SigCdPro.dpros char(65)
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe em
	* ConfigurarGridItens() (Fase 4) - mesmo motivo de GarantirCursorOperacoes.
	*====================================================================
	PROCEDURE GarantirCursorItens()
		IF !USED(THIS.this_cCursorItens)
			SET NULL ON
			CREATE CURSOR (THIS.this_cCursorItens) ( ;
				cpros C(14) NULL, ;
				dpros C(65) NULL, ;
				qtds N(9,3) NULL)
			SET NULL OFF
		ENDIF
	ENDPROC

	*====================================================================
	* CarregarOperacoes - Popula a grade de movimentacoes a partir do
	* cursor que o form PAI deixou pronto (this_cCursorOrigem).
	*
	* Equivale a este trecho do Init legado:
	*     Zap In dbOperacao
	*     Select TprMvCab
	*     Scan
	*         Scatter MemVar
	*         Insert Into dbOperacao From MemVar
	*     EndScan
	*     Select dbOperacao
	*     Go Top
	* ... seguido da carga dos itens da PRIMEIRA linha (o legado popula
	* dbItens logo apos o Go Top; o AfterRowColChange so entra em acao
	* quando o usuario muda de linha).
	*
	* NAO re-executa a consulta em SigMvCab: o WHERE do legado vive no
	* form PAI (SigPrPpcBO.ConsultarMovimentacoes - periodo mais os
	* pares GrupoOs/GrupoDs e ContaOs/ContaDs com OR nos DOIS lados,
	* mais Dopes e Emps opcionais). Refazer a consulta aqui com um
	* filtro adivinhado faria esta grade mostrar um conjunto DIFERENTE
	* do que o usuario pediu, sem erro nenhum na tela.
	*
	* O cursor da grade nunca eh fechado nem recriado: ZAP + APPEND
	* FROM preserva estrutura, RecordSource e ControlSource das colunas.
	*====================================================================
	FUNCTION CarregarOperacoes()
		LOCAL loc_lSucesso, loc_cOrigem, loc_oErro

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido = .F.
		loc_lSucesso = .F.
		loc_cOrigem = ALLTRIM(THIS.this_cCursorOrigem)

		TRY
			THIS.GarantirCursorOperacoes()
			THIS.GarantirCursorItens()

			IF !USED(loc_cOrigem)
				THIS.this_cMensagemErro = "O resultado da consulta (" + loc_cOrigem + ;
					") n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + ;
					"vel. Refa" + CHR(231) + "a a pesquisa na tela anterior."
			ELSE
				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				*-- So as colunas que a grade exibe; o legado copiava o
				*   registro inteiro porque dbOperacao era um DBF com a
				*   mesma estrutura de SigMvCab.
				SELECT emps, dopes, numes, datas, valos ;
					FROM (loc_cOrigem) ;
					ORDER BY emps, dopes, numes ;
					INTO CURSOR cursor_4c_OperacoesTmp READWRITE

				SELECT (THIS.this_cCursorOperacoes)
				ZAP
				APPEND FROM DBF("cursor_4c_OperacoesTmp")

				IF USED("cursor_4c_OperacoesTmp")
					USE IN cursor_4c_OperacoesTmp
				ENDIF

				SELECT (THIS.this_cCursorOperacoes)
				GO TOP

				IF EOF()
					*-- Universo vazio nao eh erro: so deixa a grade de
					*   itens vazia e coerente com a de movimentacoes.
					SELECT (THIS.this_cCursorItens)
					ZAP

					THIS.this_cEmps = ""
					THIS.this_cDopes = ""
					THIS.this_nNumes = 0
					THIS.this_dDatas = {}
					THIS.this_nValos = 0

					loc_lSucesso = .T.
				ELSE
					*-- O resultado da carga dos itens EH o resultado desta
					*   carga: se a consulta dos itens falhar, a tela fica
					*   com a grade de baixo vazia sem motivo aparente, e
					*   devolver .T. aqui esconderia a falha do chamador
					*   (que leria this_cMensagemErro ja preenchido).
					loc_lSucesso = THIS.CarregarItensDaOperacaoCorrente()
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarOperacoes")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Le a linha CORRENTE do cursor informado para as
	* propriedades da movimentacao selecionada.
	*
	* Padrao canonico: SELECT (par_cAliasCursor) ANTES de acessar os
	* campos, acesso aos campos SEM prefixo de alias, e cada campo
	* protegido por TYPE() porque o mesmo metodo atende tanto o cursor
	* da grade (5 colunas) quanto o cursor de origem TprMvCab, que eh um
	* SELECT * de SigMvCab com 158 colunas.
	*
	* PUBLICO de proposito: o Form chama este metodo de fora da classe, e
	* metodo PROTECTED chamado de fora estoura "Property ... is not
	* found" em runtime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso, loc_cAlias, loc_oErro

		loc_lSucesso = .F.
		loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), ;
			ALLTRIM(THIS.this_cCursorOperacoes))

		TRY
			IF USED(loc_cAlias)
				SELECT (loc_cAlias)

				IF !EOF() AND !BOF()
					IF TYPE(loc_cAlias + ".emps") != "U"
						THIS.this_cEmps = TratarNulo(emps, "")
					ENDIF
					IF TYPE(loc_cAlias + ".dopes") != "U"
						THIS.this_cDopes = TratarNulo(dopes, "")
					ENDIF
					IF TYPE(loc_cAlias + ".numes") != "U"
						THIS.this_nNumes = TratarNulo(numes, 0)
					ENDIF
					IF TYPE(loc_cAlias + ".datas") != "U"
						THIS.this_dDatas = TratarNulo(datas, {})
					ENDIF
					IF TYPE(loc_cAlias + ".valos") != "U"
						THIS.this_nValos = TratarNulo(valos, 0)
					ENDIF

					loc_lSucesso = .T.
				ELSE
					THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + ;
						"o selecionada."
				ENDIF
			ELSE
				THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
					"o est" + CHR(225) + " aberto."
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message + CHR(13) + ;
				"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
				"Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
			THIS.this_lErroExibido = .T.
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItensDaOperacaoCorrente - Le a linha corrente da grade de
	* movimentacoes e recarrega a grade de itens com os produtos daquela
	* movimentacao.
	*
	* Equivale ao grd_operacoes.AfterRowColChange do legado (Zap In
	* dbItens, Seek na chave da linha corrente de dbOperacao e Scan
	* While a chave bater). Publico porque quem dispara eh o handler do
	* proprio Grid, no Form.
	*====================================================================
	FUNCTION CarregarItensDaOperacaoCorrente()
		LOCAL loc_lSucesso

		loc_lSucesso = .F.

		IF THIS.CarregarDoCursor(THIS.this_cCursorOperacoes)
			loc_lSucesso = THIS.CarregarItensPorChave(THIS.this_cEmps, ;
				THIS.this_cDopes, THIS.this_nNumes)
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarItensPorChave - Popula a grade de itens com os produtos
	* (SigMvItn) da movimentacao Emps + Dopes + Numes informada.
	*
	* A descricao do produto vem SEMPRE do cadastro atual (SigCdPro),
	* nunca da descricao historica gravada no item. Eh exatamente o que
	* o legado faz:
	*     poDataMgr.CursorQuery("SigCdPro", "crSigCdPro", "CPros", ...)
	*     m.DPros = Iif(Eof("crSigCdPro"), "", crSigCdPro.DPros)
	* ou seja, produto que saiu do cadastro aparece com a descricao EM
	* BRANCO. O LEFT JOIN com ISNULL(b.dpros, "") reproduz os dois casos
	* (ISNULL aqui eh a funcao do SQL Server, dentro da string SQL).
	*
	* As tres colunas sao comparadas SEPARADAMENTE, e nao pela chave
	* concatenada empdopnums char(29) que o legado usava: char no SQL
	* Server compara com preenchimento de brancos, entao a igualdade por
	* coluna eh equivalente e dispensa reproduzir o alinhamento
	* posicional 3 + 20 + 6 - onde um ALLTRIM a mais devolveria zero
	* linha em silencio.
	*====================================================================
	FUNCTION CarregarItensPorChave(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lProsseguir, loc_oErro

		THIS.this_cMensagemErro = ""
		loc_lSucesso = .F.
		loc_lProsseguir = .T.

		IF VARTYPE(par_cEmps) != "C" OR VARTYPE(par_cDopes) != "C" OR ;
		   VARTYPE(par_nNumes) != "N"
			THIS.this_cMensagemErro = "Chave da movimenta" + CHR(231) + CHR(227) + ;
				"o inv" + CHR(225) + "lida."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir AND (TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0)
			THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
				CHR(227) + "o dispon" + CHR(237) + "vel."
			loc_lProsseguir = .F.
		ENDIF

		IF loc_lProsseguir
			TRY
				THIS.GarantirCursorItens()

				loc_cSQL = "SELECT a.cpros, ISNULL(b.dpros, '') AS dpros, a.qtds" + ;
					" FROM SigMvItn a" + ;
					" LEFT JOIN SigCdPro b ON b.cpros = a.cpros" + ;
					" WHERE a.emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ;
					" AND a.dopes = " + EscaparSQL(ALLTRIM(par_cDopes)) + ;
					" AND a.numes = " + FormatarNumeroSQL(par_nNumes, 0) + ;
					" ORDER BY a.cpros"

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF

				*-- SQLEXEC sempre em cursor TEMPORARIO: executado sobre o
				*   alias da grade, ele fecharia e recriaria esse alias,
				*   zerando ColumnCount/RecordSource e deixando a grade
				*   como um retangulo branco pelo resto da vida do form.
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

				IF loc_nResultado < 0
					THIS.this_cMensagemErro = "Erro ao buscar os itens da movimenta" + ;
						CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
					MsgErro(THIS.this_cMensagemErro, "Erro SQL")
					THIS.this_lErroExibido = .T.
				ELSE
					SELECT (THIS.this_cCursorItens)
					ZAP
					APPEND FROM DBF("cursor_4c_ItensTmp")

					SELECT (THIS.this_cCursorItens)
					GO TOP

					loc_lSucesso = .T.
				ENDIF

				IF USED("cursor_4c_ItensTmp")
					USE IN cursor_4c_ItensTmp
				ENDIF
			CATCH TO loc_oErro
				THIS.this_cMensagemErro = loc_oErro.Message
				MsgErro(loc_oErro.Message + CHR(13) + ;
					"Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
					"Procedure: " + loc_oErro.Procedure, "Erro em CarregarItensPorChave")
				THIS.this_lErroExibido = .T.
				loc_lSucesso = .F.
			ENDTRY
		ENDIF

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres que o
	* sistema materializa na coluna empdopnums char(29) de SigMvCab e
	* SigMvItn, e que o legado monta como
	*     TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes, 6)
	*
	* O preenchimento FAZ PARTE da chave: emps char(3) + dopes char(20)
	* + Str(numes, 6) = 29. Usar ALLTRIM nas partes encurtaria a chave e
	* ela nunca casaria - a consulta rodaria sem erro e devolveria zero
	* linha. Por isso o PADR explicito, com as larguras do schema.
	*====================================================================
	FUNCTION MontarChaveEmpDopNums(par_cEmps, par_cDopes, par_nNumes)
		LOCAL loc_cEmps, loc_cDopes, loc_nNumes

		loc_cEmps = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
		loc_cDopes = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
		loc_nNumes = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)

		RETURN PADR(loc_cEmps, 3) + PADR(loc_cDopes, 20) + STR(loc_nNumes, 6)
	ENDFUNC

	*====================================================================
	* ObterChavePrimaria - Chave da movimentacao selecionada, no mesmo
	* formato da coluna empdopnums char(29).
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, ;
			THIS.this_nNumes)
	ENDPROC

	*====================================================================
	* LimparDados - Zera filtros, linha selecionada e as duas grades. As
	* grades sao esvaziadas com ZAP (nunca fechadas), para o Grid nao
	* perder RecordSource nem ControlSource.
	*====================================================================
	PROCEDURE LimparDados()
		DODEFAULT()

		THIS.this_cGrupo = ""
		THIS.this_cConta = ""
		THIS.this_cContaDesc = ""
		THIS.this_dDataInicial = {}
		THIS.this_dDataFinal = {}

		THIS.this_cEmps = ""
		THIS.this_cDopes = ""
		THIS.this_nNumes = 0
		THIS.this_dDatas = {}
		THIS.this_nValos = 0

		THIS.GarantirCursorOperacoes()
		SELECT (THIS.this_cCursorOperacoes)
		ZAP

		THIS.GarantirCursorItens()
		SELECT (THIS.this_cCursorItens)
		ZAP

		RETURN .T.
	ENDPROC

	*====================================================================
	* Destroy - Fecha os cursores criados por ESTE BO. O cursor de
	* origem (TprMvCab) pertence ao form pai e eh fechado por ele.
	*====================================================================
	PROCEDURE Destroy()
		IF USED("cursor_4c_OperacoesTmp")
			USE IN cursor_4c_OperacoesTmp
		ENDIF
		IF USED("cursor_4c_ItensTmp")
			USE IN cursor_4c_ItensTmp
		ENDIF
		IF USED(THIS.this_cCursorItens)
			USE IN (THIS.this_cCursorItens)
		ENDIF
		IF USED(THIS.this_cCursorOperacoes)
			USE IN (THIS.this_cCursorOperacoes)
		ENDIF

		DODEFAULT()
	ENDPROC

ENDDEFINE

