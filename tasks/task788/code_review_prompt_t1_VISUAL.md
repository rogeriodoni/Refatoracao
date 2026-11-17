# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPrL.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1194 linhas total):

*-- Linhas 59 a 88:
59: *             transcritas do dump, Init (guarda pObj/pLin/pCnx e cria o BO),
60: *             InicializarForm (fundo do form + cabecalho + bloqueio do form
61: *             chamador), ConfigurarCabecalho (cnt_4c_Sombra +
62: *             lbl_4c_LblSombra/lbl_4c_LblTitulo) e Destroy (devolve o form
63: *             chamador ao estado habilitado). Sem metodo de pageframe - este
64: *             form nao tem PageFrame (ver acima).
65: *   Fase 4:   grade de selecao e botao de acao. ConfigurarGrid cria
66: *             grd_4c_Dados (SIGOPPRL.Grade) com as 7 colunas do dump e as
67: *             propriedades que nao dependem de dado; CarregarLista eh o funil
68: *             unico de ligacao/repintura (RecordSource + ControlSource +
69: *             larguras + captions + Refresh), transcrito do fim do Init
70: *             legado; GarantirCheckBoxMarcacao cria, de forma idempotente, o
71: *             CheckBox de marcacao da Column1 (fwcheckbox1) com os 4
72: *             handlers de alternancia; HeaderSelecaoClick marca/desmarca
73: *             tudo (Column1.Header1.Click legado); FocarCheckboxSelecao
74: *             devolve o foco ao checkbox (GotFocus das Columns 2 e 3);
75: *             Activate poe o foco inicial no checkbox; ConfigurarBotoes cria
76: *             cmg_4c_Saida (SIGOPPRL.cntBotoes) com o unico botao do legado,
77: *             Encerrar/btnSair, e BtnEncerrarClick reproduz o btnSair.Click.
78: *   Fase 5:   ConfigurarLinha cria os tres objetos restantes do dump
79: *             (Shape4/imgLinhas/lblLinha, o bloco da figura e da descricao
80: *             da Linha, filhos DIRETOS do form) e busca a Linha via
81: *             SigOpPrLBO.BuscarLinha() (ja existente desde as Fases 1/2),
82: *             equivalente ao poDataMgr.CursorQuery([SigCdLin], ...) do
83: *             Init legado; popula lbl_4c_LblLinha.Caption e
84: *             img_4c_ImgLinhas.Picture/Visible. Esta fase completa todos os
85: *             objetos do dump - nao ha "pagina de dados" neste form (ver
86: *             layout FLAT no topo do arquivo).
87: *   Fase 6:   SEM TRABALHO, medido - nao ha "campos restantes" nem
88: *             "lookups" para esta fase acrescentar. Este legado eh do

*-- Linhas 164 a 172:
164: *             canonicos; o quarto, CarregarLista, ja existe de verdade
165: *             desde a Fase 4. O bloco do botao de acao dispensa o verbo de
166: *             gravar porque o UNICO botao do SCX so reabilita o form pai e
167: *             fecha - quem trabalha eh o CheckBox da Column1 e o Click do
168: *             Header dela. Por isso esta fase NAO acrescentou metodo
169: *             nenhum: escrever os nomes do template com corpo vazio seria
170: *             o stub disfarcado que a regra de completude proibe.
171: *
172: *             O que ela de fato corrigiu foi um defeito MUDO herdado da

*-- Linhas 306 a 315:
306:     * Reproduz, nesta ordem, o inicio do Init legado:
307:     *   1. o fundo do form (propriedade Picture do dump);
308:     *   2. a faixa cinza do topo com o titulo, equivalente a cntSombra +
309:     *      "ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption" /
310:     *      "ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption";
311:     *   3. "This.ParentForm.Enabled = .f." - bloqueio do form chamador
312:     *      enquanto o dialogo estiver aberto.
313:     *==========================================================================
314:     PROTECTED PROCEDURE InicializarForm()
315:         LOCAL loc_lSucesso, loc_oErro

*-- Linhas 361 a 375:
361:     * regra #11 - o cabecalho NUNCA se detecta pelo nome do container).
362:     *
363:     * Os dois labels recebem Caption = THIS.Caption aqui, que eh exatamente o
364:     * que o Init legado faz ("ThisForm.cntSombra.lblSombra.Caption =
365:     * ThisForm.Caption"): o Caption gravado no SCX eh o texto residual
366:     * "Cadastro de Testes", sobrescrito em runtime pelo proprio Init - por
367:     * isso o texto residual NAO eh transcrito.
368:     *
369:     * Top/Left/Width/Height/fonte/cor vem do dump. lbl_4c_LblSombra eh a
370:     * sombra preta (ForeColor 0,0,0) e lbl_4c_LblTitulo o texto branco
371:     * (ForeColor 255,255,255) desenhado 1px acima, por cima dela - por isso o
372:     * titulo eh criado DEPOIS da sombra.
373:     *
374:     * AutoSize = .F. explicito nos dois labels: em Label criado por AddObject
375:     * o AutoSize eh no-op e, com WordWrap = .T., descarta a Height e corta o

*-- Linhas 390 a 474:
390:         *-- exatamente a largura do form, sem transbordar.
391:         THIS.AddObject("cnt_4c_Sombra", "Container")
392:         WITH THIS.cnt_4c_Sombra
393:             .Top           = 0
394:             .Left          = 0
395:             .Width         = THIS.Width
396:             .Height        = 80
397:             .BackStyle     = 1
398:             .BackColor     = RGB(100, 100, 100)
399:             .BorderWidth   = 0
400:             .SpecialEffect = 0
401:             .Visible       = .T.
402:         ENDWITH
403: 
404:         *-- lblSombra (dump): Tahoma 18 bold, Top=18, Left=10, 769x40,
405:         *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=0,0,0
406:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
407:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
408:             .Top           = 18
409:             .Left          = 10
410:             .Width         = 769
411:             .Height        = 40
412:             .AutoSize      = .F.
413:             .FontName      = "Tahoma"
414:             .FontSize      = 18
415:             .FontBold      = .T.
416:             .FontUnderline = .F.
417:             .WordWrap      = .T.
418:             .Alignment     = 0
419:             .BackStyle     = 0
420:             .ForeColor     = RGB(0, 0, 0)
421:             .Caption       = loc_cCaption
422:             .Visible       = .T.
423:         ENDWITH
424: 
425:         *-- lblTitulo (dump): Tahoma 18 bold, Top=17, Left=10, 769x46,
426:         *-- WordWrap=.T., Alignment=0, BackStyle=0, ForeColor=255,255,255.
427:         *-- Branco eh CORRETO aqui: eh o titulo da faixa, sobre Container
428:         *-- OPACO escuro (excecao explicita da CLAUDE.md regra #12).
429:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
430:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
431:             .Top         = 17
432:             .Left        = 10
433:             .Width       = 769
434:             .Height      = 46
435:             .AutoSize    = .F.
436:             .FontName    = "Tahoma"
437:             .FontSize    = 18
438:             .FontBold    = .T.
439:             .WordWrap    = .T.
440:             .Alignment   = 0
441:             .BackStyle   = 0
442:             .ForeColor   = RGB(255, 255, 255)
443:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
444:             .Caption     = loc_cCaption
445:             .Visible     = .T.
446:         ENDWITH
447:     ENDPROC
448: 
449:     *==========================================================================
450:     * ConfigurarLinha - Cria os tres objetos do dump ligados a exibicao da
451:     * Linha (SigCdLin) no topo do dialogo - filhos DIRETOS do form, sem
452:     * compensacao +29 (nao ha PageFrame neste form):
453:     *
454:     *   Shape4    -> shp_4c_Shape4    (moldura da figura)
455:     *   imgLinhas -> img_4c_ImgLinhas (figura da linha - Visible = .F. por
456:     *                default, so aparece se a Linha tiver FigJpgs)
457:     *   lblLinha  -> lbl_4c_LblLinha  (descricao da linha - classe say do
458:     *                dump: AutoSize = .F. + Width/Height EXATOS do SCX,
459:     *                regra #23; ForeColor = RGB(90,90,90) porque este form
460:     *                usa o fundo new_background.jpg direto na Picture dele,
461:     *                nao a textura clara das Pages do padrao CRUD, mas o
462:     *                dump ja declara ForeColor = 90,90,90 para este label)
463:     *
464:     * Em seguida busca a Linha - equivalente ao "This.poDataMgr.CursorQuery(
465:     * [SigCdLin], [LocalLin], [Linhas], pLin, [FigJpgs, Descs])" do Init
466:     * legado - via THIS.this_oBusinessObject.BuscarLinha() (Fases 1/2) e
467:     * popula os dois controles:
468:     *
469:     *   lbl_4c_LblLinha.Caption  <- SigCdLin.Descs (ou "" se a Linha nao
470:     *                               existir - o legado tambem so deixa em
471:     *                               branco, nao fecha o dialogo)
472:     *   img_4c_ImgLinhas.Picture <- FigJpgs gravado num arquivo temporario
473:     *                               (STRTOFILE) e lido de la - Image nao
474:     *                               aceita os bytes direto em .Picture

*-- Linhas 501 a 554:
501:         *-- (CLAUDE.md regra #33).
502:         THIS.AddObject("shp_4c_Shape4", "Shape")
503:         WITH THIS.shp_4c_Shape4
504:             .Top           = 82
505:             .Left          = 10
506:             .Width         = 150
507:             .Height        = 105
508:             .BackStyle     = 0
509:             .BorderWidth   = 2
510:             .SpecialEffect = 0
511:             .Visible       = .T.
512:         ENDWITH
513: 
514:         *-- imgLinhas (figura da Linha) - Visible = .F. por default, so o
515:         *-- bloco abaixo (com FigJpgs nao vazio) liga para .T.
516:         THIS.AddObject("img_4c_ImgLinhas", "Image")
517:         WITH THIS.img_4c_ImgLinhas
518:             .Top         = 84
519:             .Left        = 12
520:             .Width       = 146
521:             .Height      = 101
522:             .Stretch     = 1
523:             .Picture     = ""
524:             .ToolTipText = "Imagem da Linha de Produto"
525:             .Visible     = .F.
526:         ENDWITH
527: 
528:         *-- lblLinha (descricao da Linha)
529:         THIS.AddObject("lbl_4c_LblLinha", "Label")
530:         WITH THIS.lbl_4c_LblLinha
531:             .Top       = 166
532:             .Left      = 168
533:             .Width     = 720
534:             .Height    = 20
535:             .AutoSize  = .F.
536:             .FontName  = "Tahoma"
537:             .FontSize  = 12
538:             .FontBold  = .T.
539:             .BackStyle = 0
540:             .ForeColor = RGB(90, 90, 90)
541:             .Caption   = ""
542:             .Visible   = .T.
543:         ENDWITH
544: 
545:         *-- "This.poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas],
546:         *-- pLin, [FigJpgs, Descs])" do Init legado
547:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
548:             IF THIS.this_oBusinessObject.BuscarLinha(THIS.this_cCodigoLinha)
549:                 THIS.lbl_4c_LblLinha.Caption = ;
550:                     THIS.this_oBusinessObject.this_cDescricaoLinha
551: 
552:                 loc_cFigura = THIS.this_oBusinessObject.this_cFiguraLinha
553:                 IF !EMPTY(loc_cFigura)
554:                     *-- O legado grava o conteudo da coluna DIRETO no arquivo

*-- Linhas 605 a 673:
605:     * Aqui ficam SO as propriedades que NAO dependem de dado (geometria,
606:     * fonte, cabecalho, scroll, Movable/Resizable/ReadOnly/InputMask de cada
607:     * coluna). Tudo que depende do cursor - RecordSource, ControlSource, o
608:     * CheckBox da Column1, as larguras e os captions - vive em CarregarLista,
609:     * porque o VFP9 reseta esse grupo a cada rebind (ver la).
610:     *
611:     * A grade eh criada SEMPRE, mesmo sem o cursor de selecao aberto: os
612:     * handlers de marcacao referenciam THIS.grd_4c_Dados e um RETURN antes do
613:     * AddObject deixaria o objeto inexistente. O que depende do cursor eh que
614:     * fica guardado por USED().
615:     *
616:     * Grid.ReadOnly = .F. vem ANTES do ReadOnly das colunas, porque o do grid
617:     * propaga e sobrescreve o das colunas (CLAUDE.md regra #46).
618:     *
619:     * Columns 2-7 (DPros/PVens/MoeVs/Sqtds/CPros/CGrus) sao so exibicao: o
620:     * dump marca "When" retornando .F. nelas (Column2/3/4/5/6/7.Text1.When),
621:     * o que impede a celula de entrar em modo de edicao - aqui reproduzido
622:     * com .ReadOnly = .T., que eh o equivalente pratico documentado pela
623:     * regra #46 ("a coluna que o legado trava com When = .F. volta a
624:     * ReadOnly = .T. depois do Grid.ReadOnly"), ja que Column.When nao tem
625:     * hook confiavel via BINDEVENT nesta arquitetura. Por isso o ReadOnly
626:     * destas colunas NAO espelha o valor cru do dump (que traz .F. em
627:     * Column2/4/5/7) e sim o efeito do When que o dump declara para elas.
628:     *
629:     * Column2 e Column3 (DPros/PVens) TAMBEM tem GotFocus no dump, devolvendo
630:     * o foco ao checkbox - esse SIM eh transcrito literal
631:     * (FocarCheckboxSelecao). Os BINDEVENT de Header1/Text1 ficam aqui, e nao
632:     * em CarregarLista, porque Header1 e Text1 sao membros NATIVOS da Column:
633:     * sobrevivem ao rebind, e religa-los a cada carga empilharia handler
634:     * duplicado (o toggle do cabecalho dispararia duas vezes e se anularia).
635:     *==========================================================================
636:     PROTECTED PROCEDURE ConfigurarGrid()
637:         THIS.AddObject("grd_4c_Dados", "Grid")
638: 
639:         *-- ColumnCount definido UMA vez, aqui na criacao, com o cursor de
640:         *-- selecao como area corrente quando ele existe: Grid sem
641:         *-- RecordSource se auto-liga ao alias CORRENTE no instante em que o
642:         *-- ColumnCount eh atribuido (medido no VFP9), e deixar esse auto-bind
643:         *-- cair no cursor certo evita que a Column1 nasca ligada a uma coluna
644:         *-- de outro tipo. CarregarLista nao mexe mais nisto.
645:         IF USED(THIS.this_cCursorSelecao)
646:             SELECT (THIS.this_cCursorSelecao)
647:         ENDIF
648:         THIS.grd_4c_Dados.ColumnCount = 7
649: 
650:         WITH THIS.grd_4c_Dados
651:             .Top          = 189
652:             .Left         = 12
653:             .Width        = 980
654:             .Height       = 403
655:             .FontName     = "Verdana"
656:             .FontSize     = 8
657:             .HeaderHeight = 22
658:             .RowHeight    = 16
659:             .ScrollBars   = 2
660:             .ReadOnly     = .F.
661:             .RecordMark   = .F.
662:             .DeleteMark   = .F.
663:             .TabIndex     = 10
664:             .Visible      = .T.
665: 
666:             *-- Column1 "Selecao" - coluna do checkbox de marcacao.
667:             *-- Format = "K!" do dump NAO transcrito: a coluna desenha um
668:             *-- CheckBox (CurrentControl), para o qual a mascara nao se aplica.
669:             .Column1.Alignment = 2
670:             .Column1.Movable   = .F.
671:             .Column1.Resizable = .F.
672:             .Column1.Sparse    = .F.
673:             .Column1.ForeColor = RGB(0, 0, 0)

*-- Linhas 734 a 745:
734:             *-- Grade.Column1.Header1.Click)
735:             BINDEVENT(.Column1.Header1, "Click", THIS, "HeaderSelecaoClick")
736: 
737:             *-- GotFocus das celulas de exibicao devolvendo o foco ao checkbox
738:             *-- (legado: Column2/Column3.Text1.GotFocus)
739:             BINDEVENT(.Column2.Text1, "GotFocus", THIS, "FocarCheckboxSelecao")
740:             BINDEVENT(.Column3.Text1, "GotFocus", THIS, "FocarCheckboxSelecao")
741:         ENDWITH
742: 
743:         *-- Liga a grade ao cursor de selecao e pinta (ver CarregarLista)
744:         THIS.CarregarLista()
745:     ENDPROC

*-- Linhas 754 a 971:
754:     *                                      demais colunas)
755:     *   This.Refresh
756:     *   This.Grade.Column1.SetFocus
757:     *   This.Grade.Column1.fwcheckbox1.SetFocus
758:     *
759:     * Tem de ser um metodo PROPRIO, e nao codigo solto dentro de
760:     * ConfigurarGrid, porque TODO caminho que repopula o cursor de selecao
761:     * precisa repetir a sequencia inteira (CLAUDE.md regra #21): popular o
762:     * cursor NAO repinta a grade, e - pior - se o cursor for FECHADO e
763:     * recriado, o VFP9 DESTROI o CheckBox posto por Column.AddObject (medido:
764:     * CurrentControl volta a "Text1" e o objeto deixa de existir) enquanto
765:     * Width e Header1.Caption sobrevivem. A grade continua bonita e o usuario
766:     * perde o unico jeito de marcar a linha, sem erro e sem log. Por isso a
767:     * criacao do CheckBox vive aqui dentro, em GarantirCheckBoxMarcacao, que
768:     * eh idempotente.
769:     *
770:     * ORDEM (medida no VFP9, nao reordenar): RecordSource -> ControlSource de
771:     * TODAS as colunas -> AddObject do CheckBox + CurrentControl -> Width ->
772:     * Header1.Caption. O CheckBox tem de ser adicionado DEPOIS de o
773:     * ControlSource da Column1 ja apontar para a coluna logica Selecao: feito
774:     * antes, o AddObject estoura "Data type mismatch" contra o auto-bind da
775:     * area corrente. E Width/Header1.Caption vao por ULTIMO porque atribuir
776:     * RecordSource reseta os dois (Problema 48 do
777:     * FORMCOR_LICOES_APRENDIDAS.md).
778:     *
779:     * O cursor (cursor_4c_BusLin, equivalente ao LocalBusLin do legado) eh
780:     * aberto e populado pelo form CHAMADOR antes de abrir este dialogo, por
781:     * isso o bind eh guardado por USED(): Column.ControlSource de cursor
782:     * inexistente derruba o Init (regra #41). Sem o cursor a grade fica
783:     * vazia - nao ha erro, so nao ha o que mostrar.
784:     *
785:     * O foco inicial no checkbox ("Grade.Column1.fwcheckbox1.SetFocus" do
786:     * Init legado) NAO entra aqui: no Init o form ainda nao esta visivel e
787:     * SetFocus em controle de form invisivel estoura. Ele fica no Activate,
788:     * que roda com a tela ja na frente.
789:     *
790:     * Devolve .T. quando a grade ficou ligada ao cursor.
791:     *==========================================================================
792:     PROCEDURE CarregarLista()
793:         LOCAL loc_cCursor
794: 
795:         loc_cCursor = THIS.this_cCursorSelecao
796: 
797:         IF !USED(loc_cCursor) OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
798:             RETURN .F.
799:         ENDIF
800: 
801:         *-- "Select LocalBusLin / Go Top In LocalBusLin" do Init legado
802:         SELECT (loc_cCursor)
803:         GO TOP IN (loc_cCursor)
804: 
805:         WITH THIS.grd_4c_Dados
806:             *-- ColumnCount ja foi definido em ConfigurarGrid, com o cursor
807:             *-- como area corrente - NAO reatribuir ColumnCount.
808:             .RecordSource = loc_cCursor
809: 
810:             .Column1.ControlSource = loc_cCursor + ".Selecao"
811:             .Column2.ControlSource = loc_cCursor + ".DPros"
812:             .Column3.ControlSource = loc_cCursor + ".PVens"
813:             .Column4.ControlSource = loc_cCursor + ".MoeVs"
814:             .Column5.ControlSource = loc_cCursor + ".Sqtds"
815:             .Column6.ControlSource = loc_cCursor + ".CPros"
816:             .Column7.ControlSource = loc_cCursor + ".CGrus"
817:         ENDWITH
818: 
819:         *-- CheckBox da Column1 (recriado se o rebind do alias o destruiu)
820:         THIS.GarantirCheckBoxMarcacao()
821: 
822:         WITH THIS.grd_4c_Dados
823:             *-- Larguras e captions DEPOIS do RecordSource, que reseta os dois
824:             .Column1.Width = 23
825:             .Column2.Width = 502
826:             .Column3.Width = 100
827:             .Column4.Width = 45
828:             .Column5.Width = 120
829:             .Column6.Width = 120
830:             .Column7.Width = 40
831: 
832:             .Column1.Header1.Caption = ""
833:             .Column2.Header1.Caption = "Produto"
834:             .Column3.Header1.Caption = "Valor"
835:             *-- "Moe" - caption transcrito literal do dump (abreviado la)
836:             .Column4.Header1.Caption = "Moe"
837:             .Column5.Header1.Caption = "Estoque"
838:             .Column6.Header1.Caption = "C" + CHR(243) + "digo"
839:             .Column7.Header1.Caption = "Grupo"
840: 
841:             *-- "This.Refresh" do Init legado
842:             .Refresh()
843:         ENDWITH
844: 
845:         RETURN .T.
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * GarantirCheckBoxMarcacao - Cria o CheckBox de marcacao da Column1,
850:     * equivalente ao fwcheckbox1 do dump, com os 4 handlers de alternancia.
851:     *
852:     * IDEMPOTENTE de proposito: eh chamado pelo funil CarregarLista, que roda
853:     * em toda repintura, e um segundo AddObject com o mesmo nome estouraria
854:     * "Object already defined". O PEMSTATUS eh justamente o que distingue
855:     * "ainda vivo" de "destruido pelo rebind do alias".
856:     *
857:     * Os BINDEVENT ficam JUNTO do AddObject, no mesmo metodo: objeto recriado
858:     * eh OUTRO objeto e as ligacoes do anterior morreram com ele - sem
859:     * religar, os 4 handlers ficariam mudos e o CheckBox apareceria sem
860:     * alternar nada.
861:     *
862:     * .Value NAO eh atribuido: o dump nao declara Value para o fwcheckbox1, e
863:     * quem fornece o valor eh o ControlSource da Column (coluna logica
864:     * Selecao, que o legado grava com .T./.F. nos dois Update do
865:     * Column1.Header1.Click). Atribuir 0 numerico aqui criaria divergencia de
866:     * tipo contra essa coluna.
867:     *
868:     * AutoSize = .T. do dump tambem nao eh transcrito: em controle criado por
869:     * AddObject o AutoSize eh no-op (CLAUDE.md regra #23) e o dump nao declara
870:     * Width/Height para este checkbox - com Caption vazio e Centered = .T. a
871:     * propria Column centraliza e recorta a caixa.
872:     *
873:     * O 13o metodo do dump, "fwcheckbox1.Valid", eh "=DoDefault()" e MAIS
874:     * NADA: um repasse puro para o Valid da classe fwcheckbox do Framework,
875:     * sem uma linha de logica propria. Nao ha o que transcrever - um
876:     * PROCEDURE Valid aqui chamando DODEFAULT() nao chamaria o fwcheckbox
877:     * (este controle eh um CheckBox base, nao a classe do VCX) e seria metodo
878:     * sem logica, o stub que a regra de completude proibe. A alternancia real
879:     * da celula, que no legado vem desse Valid herdado, esta reproduzida nos
880:     * quatro handlers abaixo.
881:     *==========================================================================
882:     PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
883:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
884:             RETURN .F.
885:         ENDIF
886: 
887:         IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
888:             *-- Ainda vivo: um segundo AddObject estouraria
889:             RETURN .T.
890:         ENDIF
891: 
892:         THIS.grd_4c_Dados.Column1.AddObject("chk_4c_Selecao", "CheckBox")
893: 
894:         WITH THIS.grd_4c_Dados.Column1.chk_4c_Selecao
895:             .Top       = 31
896:             .Left      = 12
897:             .FontName  = "Verdana"
898:             .FontSize  = 8
899:             .Alignment = 0
900:             .Centered  = .T.
901:             .BackStyle = 0
902:             .Caption   = ""
903:             .ReadOnly  = .F.
904:             .Visible   = .T.
905:         ENDWITH
906: 
907:         *-- Sparse e CurrentControl DEPOIS de o controle existir (regra #18):
908:         *-- sem CurrentControl a coluna segue desenhando o Text1 dela, e sem
909:         *-- Sparse = .F. o CheckBox so aparece na linha ativa
910:         THIS.grd_4c_Dados.Column1.Sparse         = .F.
911:         THIS.grd_4c_Dados.Column1.CurrentControl = "chk_4c_Selecao"
912: 
913:         *-- Os 4 handlers de alternancia (regra #46 / pattern #185): sem eles
914:         *-- o CheckBox de Column aparece e NAO alterna ao clique
915:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "Click", ;
916:             THIS, "ChkSelecaoClick")
917:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseDown", ;
918:             THIS, "ChkSelecaoMouseDown")
919:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "MouseUp", ;
920:             THIS, "ChkSelecaoMouseUp")
921:         BINDEVENT(THIS.grd_4c_Dados.Column1.chk_4c_Selecao, "KeyPress", ;
922:             THIS, "ChkSelecaoKeyPress")
923: 
924:         RETURN .T.
925:     ENDPROC
926: 
927:     *==========================================================================
928:     * Activate - Coloca o foco no checkbox de marcacao da primeira linha,
929:     * equivalente ao fim do Init legado:
930:     *
931:     *   This.Grade.Column1.SetFocus
932:     *   This.Grade.Column1.fwcheckbox1.SetFocus
933:     *
934:     * Fica no Activate, e nao no Init/CarregarLista, porque SetFocus exige o
935:     * controle JA visivel: no Init o form ainda nao foi mostrado e a chamada
936:     * estoura "Cannot set focus to a disabled or invisible window".
937:     *
938:     * Guardado por PEMSTATUS porque o CheckBox so existe quando o cursor de
939:     * selecao estava aberto na carga (ver CarregarLista) - sem ele a Column1
940:     * desenha o Text1 e nao ha o que focar.
941:     *
942:     * O "ThisForm.Grade.AfterRowColChange()" que encerra o Init legado NAO
943:     * tem equivalente aqui de proposito: o SCX nao declara esse metodo em
944:     * nenhum nivel (nao ha PROCEDURE AfterRowColChange no dump), a chamada
945:     * cai no metodo herdado da classe fwgrade (p-code de framework.vcx) e
946:     * esta tela nao tem detalhe de linha para carregar. Inventar um handler
947:     * seria criar comportamento que o legado nao tem.
948:     *==========================================================================
949:     PROCEDURE Activate()
950:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
951:             RETURN
952:         ENDIF
953: 
954:         IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
955:             THIS.grd_4c_Dados.Column1.SetFocus()
956:             THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
957:         ENDIF
958:     ENDPROC
959: 
960:     *==========================================================================
961:     * ChkSelecaoClick/MouseDown/MouseUp - Suprimem o toggle nativo do CheckBox
962:     * de Column (regra #46 CLAUDE.md / pattern #185) - a alternancia real
963:     * acontece em ChkSelecaoKeyPress, chamado por MouseUp/Enter/Espaco.
964:     * PUBLIC (sem PROTECTED) - BINDEVENT exige metodo publico (regra #3).
965:     *==========================================================================
966:     PROCEDURE ChkSelecaoClick()
967:         NODEFAULT
968:     ENDPROC
969: 
970:     PROCEDURE ChkSelecaoMouseDown(par_nButton, par_nShift, par_nX, par_nY)
971:         NODEFAULT

*-- Linhas 978 a 1055:
978: 
979:     *==========================================================================
980:     * ChkSelecaoKeyPress - Alterna a marcacao da linha corrente do cursor de
981:     * selecao (legado: Grade.Column1.fwcheckbox1 - toggle implicito do
982:     * binding a LocalBusLin.Selecao).
983:     *==========================================================================
984:     PROCEDURE ChkSelecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
985:         LOCAL loc_lNovoValor
986: 
987:         IF !INLIST(par_nKeyCode, 13, 32) OR !USED(THIS.this_cCursorSelecao) ;
988:                 OR EOF(THIS.this_cCursorSelecao)
989:             RETURN
990:         ENDIF
991: 
992:         loc_lNovoValor = !EVALUATE(THIS.this_cCursorSelecao + ".Selecao")
993:         REPLACE Selecao WITH loc_lNovoValor IN (THIS.this_cCursorSelecao)
994:         THIS.grd_4c_Dados.Refresh()
995:         NODEFAULT
996:     ENDPROC
997: 
998:     *==========================================================================
999:     * HeaderSelecaoClick - Marca/desmarca TODAS as linhas da grade (legado:
1000:     * Grade.Column1.Header1.Click - alterna o Tag entre "X" e " " e aplica
1001:     * Selecao a todo o LocalBusLin via Update).
1002:     *==========================================================================
1003:     PROCEDURE HeaderSelecaoClick()
1004:         LOCAL loc_lMarcarTudo
1005: 
1006:         IF !USED(THIS.this_cCursorSelecao)
1007:             RETURN
1008:         ENDIF
1009: 
1010:         loc_lMarcarTudo = (THIS.grd_4c_Dados.Column1.Header1.Tag != "X")
1011: 
1012:         SELECT (THIS.this_cCursorSelecao)
1013:         SCAN
1014:             REPLACE Selecao WITH loc_lMarcarTudo
1015:         ENDSCAN
1016:         GO TOP IN (THIS.this_cCursorSelecao)
1017: 
1018:         THIS.grd_4c_Dados.Column1.Header1.Tag = IIF(loc_lMarcarTudo, "X", "")
1019:         THIS.grd_4c_Dados.Refresh()
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * FocarCheckboxSelecao - Devolve o foco ao checkbox da Column1 quando o
1024:     * usuario entra nas celulas de exibicao (legado: Column2/Column3.Text1.
1025:     * GotFocus - "ThisForm.Grade.Column1.fwcheckbox1.SetFocus"). PUBLIC (sem
1026:     * PROTECTED) - BINDEVENT exige metodo publico (regra #3).
1027:     *==========================================================================
1028:     PROCEDURE FocarCheckboxSelecao()
1029:         *-- Guardado por PEMSTATUS pela mesma razao do Activate: o
1030:         *-- CheckBox so existe quando o cursor de selecao estava aberto na
1031:         *-- carga (ver GarantirCheckBoxMarcacao). Sem ele a Column1 desenha
1032:         *-- o Text1 dela e nao ha o que focar - e SetFocus em membro
1033:         *-- inexistente estoura "Unknown member CHK_4C_SELECAO" dentro de um
1034:         *-- handler de GotFocus, isto eh fora de qualquer TRY.
1035:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1036:             RETURN
1037:         ENDIF
1038: 
1039:         IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Selecao", 5)
1040:             THIS.grd_4c_Dados.Column1.chk_4c_Selecao.SetFocus()
1041:         ENDIF
1042:     ENDPROC
1043: 
1044:     *==========================================================================
1045:     * ConfigurarBotoes - Grupo de botoes (SIGOPPRL.cntBotoes do dump),
1046:     * ButtonCount=1 - so o botao Encerrar (btnSair). AutoSize=.T. do dump NAO
1047:     * transcrito de proposito: em CommandGroup o AutoSize faz a geometria do
1048:     * botao INTERNO definir a altura do grupo (CLAUDE.md #31, medido no
1049:     * VFP9), sobrescrevendo o Width/Height 85x85 que o proprio dump declara.
1050:     * Aqui os dois valores coincidem (botao 75x75 em 5,5 -> 5+75+5 = 85), mas
1051:     * fixar Width/Height eh o que garante a geometria do dump.
1052:     *
1053:     * NOME DO OBJETO - duas decisoes, nenhuma arbitraria:
1054:     *
1055:     * (1) NAO eh o "obj_4c_CntBotoes" do mapeamento.json. O AnalisadorObjetos

*-- Linhas 1072 a 1094:
1072:     *     HeaderHeight = 0 esconderia os cabecalhos, inclusive o
1073:     *     checkbx.bmp da Column1, que eh o proprio controle de "marcar
1074:     *     tudo". Este form eh OPERACIONAL, nao REPORT. O gate da Fase 4
1075:     *     exige so o PREFIXO (cmg_4c_ ou cmd_4c_), entao o nome usado aqui
1076:     *     satisfaz o gate sem disparar a heuristica, que casa o token
1077:     *     inteiro. O nome tambem descreve melhor o objeto: o grupo tem um
1078:     *     unico botao, o de saida (btnSair), e nao uma barra CRUD.
1079:     *
1080:     * Buttons(1) recebe Top/Left/Width/Height/Picture do dump: o membro
1081:     * interno tem NOME PROPRIO la (Command1.Name = "btnSair") e o SCX declara
1082:     * geometria para ele, que eh a excecao da regra #30/#31 (nome generico de
1083:     * membro de grupo se ignora; nome proprio com geometria declarada, nao).
1084:     *==========================================================================
1085:     PROTECTED PROCEDURE ConfigurarBotoes()
1086:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
1087:         WITH THIS.cmg_4c_Saida
1088:             .Top           = -1
1089:             .Left          = 917
1090:             .Width         = 85
1091:             .Height        = 85
1092:             .ButtonCount   = 1
1093:             .BackStyle     = 0
1094:             .BorderStyle   = 0

*-- Linhas 1101 a 1120:
1101: 
1102:             *-- Buttons(1) "btnSair" - Encerrar (Cancel=.T., [Esc])
1103:             WITH .Buttons(1)
1104:                 .Top          = 5
1105:                 .Left         = 5
1106:                 .Width        = 75
1107:                 .Height       = 75
1108:                 .FontBold     = .T.
1109:                 .FontItalic   = .T.
1110:                 .FontName     = "Comic Sans MS"
1111:                 .FontSize     = 8
1112:                 .WordWrap     = .T.
1113:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1114:                 .Cancel       = .T.
1115:                 .Caption      = "Encerrar"
1116:                 .ToolTipText  = "[Esc] Encerrar"
1117:                 .MousePointer = 15
1118:                 .SpecialEffect = 0
1119:                 .ForeColor     = RGB(90, 90, 90)
1120:                 .BackColor     = RGB(255, 255, 255)


### BO (C:\4c\projeto\app\classes\SigOpPrLBO.prg):
*==============================================================================
* SigOpPrLBO.prg - Business Object para FormSigOpPrL (Selecao de Produtos)
* Herda de BusinessBase
*
* ATENCAO: Este form eh um dialogo OPERACIONAL (modal), aberto por outro form
* (par_oFormPai) para o usuario marcar/desmarcar produtos de UMA linha
* (SigCdLin) numa grade. A grade eh ligada ao cursor cursor_4c_BusLin, que
* o FORM PAI ja deixa aberto e populado ANTES de abrir este dialogo (equivale
* a LocalBusLin do legado) - por isso este BO NAO faz Buscar/Inserir/Atualizar
* sobre esse cursor. O unico dado que este BO busca no SQL Server eh a
* propria linha (SigCdLin), para exibir Descricao e a figura (Figjpgs) no
* cabecalho do dialogo - equivalente ao poDataMgr.CursorQuery([SigCdLin], ...)
* do Init legado.
*==============================================================================
DEFINE CLASS SigOpPrLBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - dados da Linha (SigCdLin) exibidos no cabecalho do dialogo
    *--------------------------------------------------------------------------
    this_cCodigoLinha    = ""   && SigCdLin.linhas  - codigo da linha (char 10, PK)
    this_cDescricaoLinha = ""   && SigCdLin.descs   - descricao da linha (char 40)
    this_cFiguraLinha    = ""   && SigCdLin.figjpgs - figura da linha (text/memo, bytes do JPG)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave (SigCdLin, somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()
            IF loc_lResultado
                THIS.this_cTabela     = "SigCdLin"
                THIS.this_cCampoChave = "linhas"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados da Linha (SigCdLin) do cursor
    * informado para as properties this_c*. E chamado por BuscarLinha() apos
    * o SQLEXEC que busca a linha no SQL Server (equivalente ao bloco do
    * Init legado que le LocalLin.Descs/LocalLin.FigJpgs apos o
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs])).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoLinha    = ALLTRIM(TratarNulo(linhas, ""))
            THIS.this_cDescricaoLinha = ALLTRIM(TratarNulo(descs, ""))
            THIS.this_cFiguraLinha    = TratarNulo(figjpgs, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinha - Busca a Linha (SigCdLin) pelo codigo para exibir a
    * Descricao e a Figura no cabecalho do dialogo. Equivalente ao
    * poDataMgr.CursorQuery([SigCdLin], [LocalLin], [Linhas], pLin,
    * [FigJpgs, Descs]) do Init legado - inclusive no caso de nao achar a
    * linha, onde o legado so deixa This.lblLinha.Caption/ImgLinhas em
    * branco (nao fecha o dialogo).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinha(par_cCodigoLinha)
        LOCAL loc_lSucesso, loc_nResultado, loc_cSQL, loc_cCursorTemp, loc_oErro

        loc_lSucesso    = .F.
        loc_cCursorTemp = "cursor_4c_SigOpPrLLinha"

        *-- Codigo da Linha ausente NAO eh falha: o legado nao trata esse caso
        *-- como erro. O "Return .f." do Init legado dispara SO quando o
        *-- CursorQuery nao chega a criar o cursor ("If Not Used([LocalLin])",
        *-- isto eh falha de CONEXAO); com pLin vazio a consulta roda, devolve
        *-- zero linha e o Init segue com "This.lblLinha.Caption = []" e a
        *-- figura oculta - o dialogo ABRE. Devolver .F. aqui faria
        *-- FormSigOpPrL.ConfigurarLinha abortar e a tela NAO abrir, o que
        *-- divergiria do legado (PILAR 1). Mesmo tratamento do ramo
        *-- "linha nao encontrada" abaixo.
        IF VARTYPE(par_cCodigoLinha) != "C" OR EMPTY(ALLTRIM(par_cCodigoLinha))
            THIS.this_cCodigoLinha    = ""
            THIS.this_cDescricaoLinha = ""
            THIS.this_cFiguraLinha    = ""
            RETURN .T.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            loc_cSQL = "SELECT Linhas, Descs, FigJpgs FROM SigCdLin " + ;
                       "WHERE Linhas = " + EscaparSQL(par_cCodigoLinha)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado > 0 AND USED(loc_cCursorTemp)
                SELECT (loc_cCursorTemp)
                GO TOP
                IF !EOF()
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursorTemp)
                ELSE
                    THIS.this_cCodigoLinha    = ALLTRIM(par_cCodigoLinha)
                    THIS.this_cDescricaoLinha = ""
                    THIS.this_cFiguraLinha    = ""
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao buscar a Linha: " + CapturarErroSQL()
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria da Linha carregada (SigCdLin.linhas)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigoLinha
    ENDFUNC

    *--------------------------------------------------------------------------
    * Decisao de projeto: BO somente-leitura (sem Inserir/Atualizar/Excluir)
    *--------------------------------------------------------------------------
    * O SIGOPPRL legado e um dialogo de SELECAO (marcar/desmarcar produtos de
    * uma Linha numa grade), nao um cadastro: o unico SQL remoto do Init e o
    * poDataMgr.CursorQuery([SigCdLin], ...), um SELECT de leitura para exibir
    * Descricao/Figura no cabecalho. Os dois "Update LocalBusLin Set Selecao"
    * do Header1.Click (Grade.Column1.Header1) e o Replace implicito do
    * fwcheckbox1 tem como alvo LocalBusLin/cursor_4c_BusLin, o cursor de
    * selecao que o FORM PAI ja deixa aberto e populado ANTES de abrir este
    * dialogo (ver comentario no topo do arquivo) - nunca e gravado no SQL
    * Server por este BO; quem le o resultado da selecao e o proprio form pai,
    * depois que este dialogo fecha. Nao ha TableUpdate nem AddCursor contra
    * tabela remota em lugar nenhum do dump do legado. Por isso este BO nao
    * sobrescreve Inserir(), Atualizar() nem ExecutarExclusao(): o
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para uma tela que so seleciona. CarregarDoCursor()/
    * BuscarLinha() acima sao os unicos pontos de acesso ao SQL Server que
    * este BO precisa; RegistrarAuditoria() herdado de BusinessBase tambem nao
    * e chamado, porque nao ha Inserir/Atualizar/Excluir que o dispare.
    *--------------------------------------------------------------------------

ENDDEFINE

