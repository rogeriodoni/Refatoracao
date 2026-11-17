# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Pendentes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPdt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2035 linhas total):

*-- Linhas 38 a 58:
38: * Herda de: FormBase          BO associado: SigOpPdtBO
39: * Criado em: Fase 3 - Estrutura base (classe, Init, cabecalho)
40: *
41: * Fase 3/8: estrutura base e o cabecalho (cntSombra + lblSombra + lblTitulo).
42: * Fase 4/8: a grade de 8 colunas (grd_4c_Dados) ligada a
43: *   this_oBusinessObject.this_cCursorPendentes ("cursor_4c_Pendentes"),
44: *   incluindo a coluna checkbox "seleciona" (Column.AddObject + CurrentControl
45: *   + Sparse = .F., regra CLAUDE.md #18).
46: *   A Fase 4 entregou tambem, junto com a grade, os tres botoes standalone
47: *   (SelTudo/apaga/ok) em ConfigurarBotoes e AjustarBotoesPorModo.
48: * Fase 5/8: Shape2/Shape1 (molduras decorativas, em ConfigurarMolduras) e
49: *   Say_Procura/Get_Procura (campo de busca por codigo, em
50: *   ConfigurarCamposBusca) - os dois ultimos blocos de controles que faltavam
51: *   para a superficie do form ficar completa em relacao ao dump do SCX.
52: * Fase 6/8: a VALIDACAO do unico campo digitavel da tela - os tres eventos
53: *   que o legado escreve em Get_Procura (Valid com o SEEK por Numes,
54: *   LostFocus devolvendo o foco a coluna de selecao da grade e When
55: *   zerando o campo na entrada), implementados em ValidarProcura /
56: *   ValidarProcuraExec / ProcuraGotFocus / FocarSelecaoGrade e ligados por
57: *   BINDEVENT em ConfigurarCamposBusca ("LostFocus" e "GotFocus" - em
58: *   TextBox o BINDEVENT de "Valid"/"When" nao dispara de forma confiavel,

*-- Linhas 84 a 114:
84: *     - apaga.Click    -> BtnApagaClick    (desmarca todas, via
85: *       SigOpPdtBO.DesmarcarPendencia)
86: *     - ok.Click       -> BtnOkClick       (reabilita o form pai e fecha)
87: *     - fwcheckbox1.InteractiveChange -> GradeSelecaoInteractiveChange
88: *       (marca/desmarca UMA linha - equivalente a ThisForm.Marca()/
89: *       ThisForm.Desmarca())
90: *     - fwcheckbox1.When -> gate de modo em AjustarBotoesPorModo
91: *       (Column1.ReadOnly) + o mesmo gate dentro do handler acima
92: *     - GotFocus do Text1 das 6 colunas de consulta ->
93: *       GradeColunaGotFocus, que devolve o foco a coluna de selecao
94: *   O religamento de tudo isso vive em VincularEventosGrade, chamado do fim
95: *   de VincularGrade, porque recarregar o cursor DESTROI as colunas (e com
96: *   elas o Check1 e os BINDEVENT) - ver o cabecalho daquele metodo.
97: * Fase 8/8: orquestracao do Init legado em InicializarForm - chamada a
98: *   this_oBusinessObject.CarregarPendencias() (ja implementado na Fase 2 do
99: *   BO) apos criar o cursor placeholder cursor_4c_Pendentes, e o fechamento
100: *   do dialogo em ok.Click (equivalente a "ThisForm.ParentForm.Enabled = .t.
101: *   / ThisForm.Release").
102: *   Fecha tambem a CAUDA do Marca() legado, que as fases anteriores havia
103: *   descartado: AtualizarFormPai devolve ao form PAI as tres razoes sociais
104: *   resolvidas (origem/destino/responsavel) e manda ele se repintar, o que
105: *   no legado era o bloco "With ThisForm.ParentForm.Pagina.Dados ...
106: *   .Refresh / Endwith" - ver o cabecalho daquele metodo. Chamado nos DOIS
107: *   caminhos que marcam pendencia (GradeSelecaoInteractiveChange, uma linha;
108: *   BtnSelTudoClick, a lista inteira) e em nenhum que desmarca, porque o
109: *   Desmarca() legado nao toca na pagina de Dados do pai.
110: *==============================================================================
111: 
112: DEFINE CLASS FormSigOpPdt AS FormBase
113: 
114:     *==========================================================================

*-- Linhas 192 a 200:
192: 
193:     *==========================================================================
194:     * this_lEmToggleSelecao - guarda de REENTRANCIA de
195:     * GradeSelecaoInteractiveChange (o toggle do checkbox da coluna de
196:     * selecao). MarcarPendencia exibe MsgAviso MODAL em cada regra de
197:     * bloqueio, e dialogo modal devolve o controle ao loop de eventos: sem a
198:     * guarda um segundo clique na grade reentraria no handler com o primeiro
199:     * ainda no meio da gravacao (regra CLAUDE.md #47). Ligada e liberada no
200:     * WRAPPER (GradeSelecaoInteractiveChange), nunca no corpo

*-- Linhas 206 a 214:
206: 
207:     *==========================================================================
208:     * this_lEmFocoGrade - guarda de REENTRANCIA de GradeColunaGotFocus (o
209:     * "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" que o legado tem no
210:     * GotFocus de TODA coluna de consulta). O handler MOVE o foco, e mover o
211:     * foco dentro da grade dispara GotFocus de outra celula: sem a guarda o
212:     * redirecionamento se chamaria em cascata. Mesmo padrao wrapper/corpo de
213:     * this_lEmValidacaoProcura.
214:     *==========================================================================

*-- Linhas 266 a 286:
266:     * de busca/botoes na ordem do dump do SCX), TornarControlesVisiveis e,
267:     * por fim, a CARGA da grade.
268:     *
269:     * A carga vai por CarregarLista, que orquestra
270:     * this_oBusinessObject.CarregarPendencias() (o SELECT que popula
271:     * cursor_4c_Pendentes) e religa a grade. O .F. dela equivale ao
272:     * "Return 0" do Init legado, que abortava a abertura da tela.
273:     *
274:     * AjustarBotoesPorModo fica DEPOIS de TornarControlesVisiveis de
275:     * proposito - ver o comentario no corpo.
276:     *==========================================================================
277:     PROTECTED PROCEDURE InicializarForm()
278:         LOCAL loc_lSucesso, loc_oErro
279:         loc_lSucesso = .F.
280: 
281:         TRY
282:             *-- Fundo do form (legado: Picture = ..\framework\imagens\new_background.jpg)
283:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
284: 
285:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpPdtBO")
286: 

*-- Linhas 353 a 416:
353:     * criado por AddObject e, com WordWrap, descarta a Height).
354:     *
355:     * Caption = THIS.Caption transcreve "ThisForm.cntSombra.lblSombra.Caption
356:     * = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption" do Init
357:     * legado (o dump mostra "Cadastro de Testes" por ser o valor congelado no
358:     * Form Designer - em runtime o Init sempre sobrescreve com o Caption do
359:     * form).
360:     *==========================================================================
361:     PROTECTED PROCEDURE ConfigurarCabecalho()
362:         LOCAL loc_oCab
363: 
364:         THIS.AddObject("cnt_4c_Sombra", "Container")
365:         loc_oCab = THIS.cnt_4c_Sombra
366:         WITH loc_oCab
367:             .Top         = 0
368:             .Left        = 0
369:             .Width       = THIS.Width
370:             .Height      = 80
371:             .BackStyle   = 1
372:             .BackColor   = RGB(100, 100, 100)
373:             .BorderWidth = 0
374:             .Visible     = .T.
375:         ENDWITH
376: 
377:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
378:         WITH loc_oCab.lbl_4c_LblSombra
379:             .AutoSize      = .F.
380:             .Top           = 18
381:             .Left          = 10
382:             .Width         = 769
383:             .Height        = 40
384:             .FontName      = "Tahoma"
385:             .FontSize      = 18
386:             .FontBold      = .T.
387:             .FontUnderline = .F.
388:             .WordWrap      = .T.
389:             .Alignment     = 0
390:             .BackStyle     = 0
391:             .ForeColor     = RGB(0, 0, 0)
392:             .Caption       = THIS.Caption
393:             .Visible       = .T.
394:         ENDWITH
395: 
396:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
397:         WITH loc_oCab.lbl_4c_LblTitulo
398:             .AutoSize    = .F.
399:             .Top         = 17
400:             .Left        = 10
401:             .Width       = 769
402:             .Height      = 46
403:             .FontName    = "Tahoma"
404:             .FontSize    = 18
405:             .FontBold    = .T.
406:             .WordWrap    = .T.
407:             .Alignment   = 0
408:             .BackStyle   = 0
409:             .ForeColor   = RGB(255, 255, 255)
410:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
411:             .Caption     = THIS.Caption
412:             .Visible     = .T.
413:         ENDWITH
414:     ENDPROC
415: 
416:     *==========================================================================

*-- Linhas 443 a 465:
443:             *-- Shape2 - moldura do bloco "Procurar Codigo" (rodape)
444:             THIS.AddObject("shp_4c_Shape2", "Shape")
445:             WITH THIS.shp_4c_Shape2
446:                 .Top         = 339
447:                 .Left        = 73
448:                 .Width       = 168
449:                 .Height      = 39
450:                 .BackStyle   = 0
451:                 .BorderStyle = 0
452:                 .BorderColor = RGB(136, 189, 188)
453:                 .Visible     = .T.
454:             ENDWITH
455: 
456:             *-- Shape1 - moldura da area do botao "ok" (topo direito)
457:             THIS.AddObject("shp_4c_Shape1", "Shape")
458:             WITH THIS.shp_4c_Shape1
459:                 .Top         = 7
460:                 .Left        = 672
461:                 .Width       = 27
462:                 .Height      = 41
463:                 .BackStyle   = 0
464:                 .BorderStyle = 0
465:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 495 a 504:
495:         TRY
496:             THIS.AddObject("grd_4c_Dados", "Grid")
497:             WITH THIS.grd_4c_Dados
498:                 .Top               = 180
499:                 .Left              = 72
500:                 .Width             = 622
501:                 .Height            = 148
502:                 .TabIndex          = 1
503:                 .FontName          = "Courier New"
504:                 .FontSize          = 8

*-- Linhas 521 a 554:
521:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrade")
522:         ENDTRY
523:     ENDPROC
524: 
525:     *==========================================================================
526:     * GarantirCursorGrade - garante que cursor_4c_Pendentes EXISTE antes de
527:     * qualquer Column.ControlSource apontar para ele (regra CLAUDE.md #41 -
528:     * Column.ControlSource de cursor que ainda nao existe derruba o Init: o
529:     * ALIAS inexistente estoura dentro do TRY de InicializarForm, que devolve
530:     * .F., CREATEOBJECT devolve .F. e o usuario clica no menu e nada
531:     * acontece, sem erro visivel).
532:     *
533:     * O cursor REAL (populado pelo SELECT em SigMvCab) so existe depois de
534:     * this_oBusinessObject.CarregarPendencias() rodar (Fase 8), e so pode
535:     * rodar com o form PAI (crSigMvCab/TmpOperacao) ja aberto - na abertura
536:     * por harness/probe ou ValidarUIFidelity esses cursores nao existem.
537:     *
538:     * Estrutura EXATA do cursor que SigOpPdtBO.CarregarPendencias monta
539:     * (CREATE CURSOR cursor_4c_Pendentes, ver o BO) - os nomes e os tipos sao
540:     * o que a grade consulta ao vincular; o BO SEMPRE recria este alias
541:     * inteiro (USE IN + CREATE CURSOR), nunca faz APPEND FROM dentro dele.
542:     *==========================================================================
543:     PROTECTED PROCEDURE GarantirCursorGrade()
544:         LOCAL loc_cAlias, loc_oErro
545: 
546:         TRY
547:             loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorPendentes)
548: 
549:             IF !EMPTY(loc_cAlias)
550:                 IF !USED(loc_cAlias)
551:                     CREATE CURSOR (loc_cAlias) ( ;
552:                         Flag    L,     ;
553:                         Emps    C(3),  ;
554:                         Dopes   C(20), ;

*-- Linhas 599 a 619:
599:     * WITH de cada Column fica FORA do WITH do grid (regra CLAUDE.md #44 -
600:     * WITH aninhado com .AddObject dentro ignora propriedades em silencio).
601:     *
602:     * Colunas (ordem visual = ordem do dump/layout.json, ver mapeamento.json
603:     * e o cabecalho de SigOpPdtBO.prg para a estrutura do alias
604:     * cursor_4c_Pendentes):
605:     *   1 "seleciona" (checkbox, Flag)       - unica coluna EDITAVEL; o
606:     *       toggle real (InteractiveChange -> Marcar/DesmarcarPendencia) fica
607:     *       em GradeSelecaoInteractiveChange, ligado por VincularEventosGrade
608:     *       no fim deste metodo; aqui a renderizacao (AddObject +
609:     *       CurrentControl + Sparse = .F., regra #18)
610:     *   2 "empresa" (Emps)        - "Emp"
611:     *   3 "operacao" (Dopes)      - "Opera" + CHR(231) + CHR(227) + "o"
612:     *   4 "codigo" (MascNum)      - "C" + CHR(243) + "d" - numero do
613:     *       documento FORMATADO para exibicao (TmpPends.MascNum no legado),
614:     *       nao o Numes cru (que eh so a chave de ordenacao)
615:     *   5 "data" (Datas)          - "Data"
616:     *   6 "Grupo" (Origem)        - "Origem"
617:     *   7 "Conta" (Destino)       - "Destino"
618:     *   8 "Column8" (Valos)       - "Valor"
619:     *

*-- Linhas 631 a 645:
631:     * "ReadOnly = .F." nelas (so Column8 eh .T.), mas o legado as torna
632:     * inacessiveis por COMPORTAMENTO, nao por propriedade - empresa/operacao/
633:     * data tem "PROCEDURE When / Return .f." no Text1, e TODAS redirecionam o
634:     * foco de volta ao checkbox no GotFocus ("ThisForm.Grade.Seleciona.
635:     * fwcheckbox1.SetFocus"). O redirecionamento de foco esta portado em
636:     * GradeColunaGotFocus (ligado por VincularEventosGrade), e o ReadOnly =
637:     * .T. aqui reproduz o "When / Return .f." - as duas metades do legado,
638:     * nao uma substituindo a outra: ReadOnly impede DIGITAR na celula e o
639:     * GotFocus impede PARAR nela. Resultado observavel igual ao legado: a
640:     * tela inteira eh de consulta e so o checkbox da coluna 1 eh editavel.
641:     *==========================================================================
642:     PROTECTED PROCEDURE VincularGrade()
643:         LOCAL loc_oGrid, loc_cAlias, loc_oErro
644: 
645:         TRY

*-- Linhas 659 a 675:
659:                 ENDIF
660:             ENDWITH
661: 
662:             *-- 1 - "seleciona" (checkbox) <- Flag
663:             *-- Propriedades do dump: Column1 Courier New 9, Width = 15,
664:             *-- Sparse = .F., ForeColor = 0,0,0; Header1 Arial, Alignment = 2,
665:             *-- Caption = ""; fwcheckbox1 Top = 31 / Left = 12 / Alignment = 0
666:             *-- / BackStyle = 0 / Caption = "" / ReadOnly = .F. (o resto vem da
667:             *-- classe fwcheckbox: 60x17, Tahoma 8, ForeColor 90,90,90,
668:             *-- Themes = .F.).
669:             *--
670:             *-- O dump declara AutoSize = .T. no checkbox: escrito como
671:             *-- AutoSize = .F. + Width/Height EXPLICITOS porque AutoSize eh
672:             *-- NO-OP em controle criado por AddObject (medido no VFP9) e,
673:             *-- junto com WordWrap, ainda descarta a Height - os numeros 60x17
674:             *-- sao os da propria classe, logo fixa-los eh reproducao fiel.
675:             *--

*-- Linhas 689 a 719:
689:                 .ForeColor     = RGB(0, 0, 0)
690: 
691:                 IF !PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
692:                     .AddObject("Check1", "CheckBox")
693:                 ENDIF
694: 
695:                 .Check1.Caption   = ""
696:                 .Check1.FontName  = "Tahoma"
697:                 .Check1.FontSize  = 8
698:                 .Check1.Alignment = 0
699:                 .Check1.BackStyle = 0
700:                 .Check1.ForeColor = RGB(90, 90, 90)
701:                 .Check1.Themes    = .F.
702:                 .Check1.ReadOnly  = .F.
703:                 .Check1.AutoSize  = .F.
704:                 .Check1.Top       = 31
705:                 .Check1.Left      = 12
706:                 .Check1.Width     = 60
707:                 .Check1.Height    = 17
708:                 .Check1.Visible   = .T.
709: 
710:                 .CurrentControl    = "Check1"
711:                 .ReadOnly          = .F.
712:                 .Header1.FontName  = "Arial"
713:                 .Header1.Alignment = 2
714:                 .Header1.Caption   = ""
715:                 .Width             = 15
716:             ENDWITH
717: 
718:             *-- 2 - "empresa" <- Emps
719:             WITH loc_oGrid.Column2

*-- Linhas 727 a 735:
727:                 .Header1.FontName  = "Arial"
728:                 .Header1.FontSize  = 8
729:                 .Header1.Alignment = 2
730:                 .Header1.Caption   = "Emp"
731:                 .Width             = 25
732:             ENDWITH
733: 
734:             *-- 3 - "operacao" <- Dopes
735:             WITH loc_oGrid.Column3

*-- Linhas 743 a 751:
743:                 .Header1.FontName  = "Arial"
744:                 .Header1.FontSize  = 8
745:                 .Header1.Alignment = 2
746:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
747:                 .Width             = 110
748:             ENDWITH
749: 
750:             *-- 4 - "codigo" <- MascNum (numero do documento FORMATADO)
751:             WITH loc_oGrid.Column4

*-- Linhas 759 a 767:
759:                 .Header1.FontName  = "Arial"
760:                 .Header1.FontSize  = 8
761:                 .Header1.Alignment = 2
762:                 .Header1.Caption   = "C" + CHR(243) + "d"
763:                 .Width             = 40
764:             ENDWITH
765: 
766:             *-- 5 - "data" <- Datas
767:             WITH loc_oGrid.Column5

*-- Linhas 776 a 784:
776:                 .Header1.FontSize  = 8
777:                 .Header1.Alignment = 2
778:                 .Header1.ForeColor = RGB(36, 84, 155)
779:                 .Header1.Caption   = "Data"
780:                 .Width             = 60
781:             ENDWITH
782: 
783:             *-- 6 - "Grupo" <- Origem
784:             WITH loc_oGrid.Column6

*-- Linhas 793 a 801:
793:                 .Header1.FontSize  = 8
794:                 .Header1.Alignment = 2
795:                 .Header1.ForeColor = RGB(36, 84, 155)
796:                 .Header1.Caption   = "Origem"
797:                 .Width             = 130
798:             ENDWITH
799: 
800:             *-- 7 - "Conta" <- Destino
801:             WITH loc_oGrid.Column7

*-- Linhas 810 a 818:
810:                 .Header1.FontSize  = 8
811:                 .Header1.Alignment = 2
812:                 .Header1.ForeColor = RGB(36, 84, 155)
813:                 .Header1.Caption   = "Destino"
814:                 .Width             = 130
815:             ENDWITH
816: 
817:             *-- 8 - "Column8" <- Valos
818:             *-- InputMask "999,999.99" transcrita do dump (a coluna eh a unica

*-- Linhas 830 a 867:
830:                 .Header1.FontSize  = 8
831:                 .Header1.Alignment = 2
832:                 .Header1.ForeColor = RGB(36, 84, 155)
833:                 .Header1.Caption   = "Valor"
834:                 .Width             = 75
835:             ENDWITH
836: 
837:             *-- Eventos das celulas + o gate de modo do checkbox. Tem de
838:             *-- rodar AQUI, no fim de VincularGrade, por DOIS motivos
839:             *-- medidos (ver o cabecalho de VincularEventosGrade).
840:             THIS.VincularEventosGrade()
841:         CATCH TO loc_oErro
842:             MsgErro(loc_oErro.Message + CHR(13) + ;
843:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
844:                 "Procedure: " + loc_oErro.Procedure, "Erro em VincularGrade")
845:         ENDTRY
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * VincularEventosGrade - liga os eventos das CELULAS da grade e reaplica o
850:     * gate de modo do checkbox de selecao. Chamado SO do fim de VincularGrade,
851:     * que por sua vez roda na montagem E depois de cada
852:     * SigOpPdtBO.CarregarPendencias().
853:     *
854:     * POR QUE no fim de VincularGrade, e nao em ConfigurarGrade (medido no
855:     * VFP9 em 2026-11-13):
856:     *
857:     *   1) O BO fecha o alias (USE IN + CREATE CURSOR) para refazer a grade, e
858:     *      FECHAR O ALIAS QUE EH RecordSource DERRUBA AS COLUNAS - no probe o
859:     *      ColumnCount caiu de 3 para 0 e Column1 virou "Unknown member".
860:     *      Logo o Check1 reconstruido por VincularGrade eh um objeto NOVO, e
861:     *      as ligacoes do anterior morreram com ele: sem religar aqui, o
862:     *      checkbox reaparece na tela e NAO alterna mais nada - o usuario ve
863:     *      a caixa, clica, e o vinculo nunca eh gravado (sem erro, sem log).
864:     *
865:     *   2) Grid.ReadOnly PROPAGA para Column.ReadOnly e SOBRESCREVE o que a
866:     *      coluna tinha (medido: Column2.ReadOnly = .T. volta a .F. depois de
867:     *      Grid.ReadOnly = .F.; regra CLAUDE.md #18/#46). VincularGrade

*-- Linhas 886 a 895:
886:         TRY
887:             loc_oGrid = THIS.grd_4c_Dados
888: 
889:             *-- (a) Toggle do checkbox da coluna de selecao - "PROCEDURE
890:             *-- InteractiveChange" de SIGOPPDT.Grade.seleciona.fwcheckbox1.
891:             *-- "InteractiveChange" (e nao o quarteto Click/MouseDown/MouseUp/
892:             *-- KeyPress com NODEFAULT da regra CLAUDE.md #46) porque o legado
893:             *-- ABRE com "=DoDefault()", ou seja ele CONTA com o toggle
894:             *-- NATIVO e so reage ao valor resultante. E o toggle nativo de
895:             *-- fato funciona neste caso, medido no VFP9: o alias eh

*-- Linhas 904 a 912:
904:             ENDIF
905: 
906:             *-- (b) "PROCEDURE GotFocus / ThisForm.Grade.Seleciona.
907:             *-- fwcheckbox1.SetFocus" de Text1 das colunas de CONSULTA
908:             *-- (empresa, operacao, data, Grupo, Conta e Column8 no dump - as
909:             *-- seis que o legado declara). O foco sempre volta para a coluna
910:             *-- de selecao, a unica editavel da tela.
911:             *--
912:             *-- A coluna 4 ("codigo") NAO entra: o dump nao declara GotFocus

*-- Linhas 934 a 942:
934:             ENDFOR
935: 
936:             *-- (c) "PROCEDURE When / Return (ThisForm.Op_Escolha =
937:             *-- 'INSERIR')" do fwcheckbox1, aplicado como Column1.ReadOnly
938:             *-- (ver AjustarBotoesPorModo). OBRIGATORIO aqui no fim, depois do
939:             *-- Grid.ReadOnly do topo de VincularGrade - motivo (2) do
940:             *-- cabecalho.
941:             THIS.AjustarBotoesPorModo()
942:         CATCH TO loc_oErro

*-- Linhas 958 a 966:
958:     * moldura shp_4c_Shape2 (339..378 x 73..241), criada antes em
959:     * ConfigurarMolduras.
960:     *
961:     * lbl_4c__Procura (Say_Procura): o dump declara AutoSize = .T., mas
962:     * AutoSize eh NO-OP em Label criado por AddObject (medido no VFP9: a
963:     * Width fica nos 100 do default) e, com WordWrap, ainda DESCARTA a
964:     * Height - por isso aqui vai AutoSize = .F. com a Width = 89 e a Height =
965:     * 15 do proprio dump (regra CLAUDE.md #23). Esses numeros JA SAO o
966:     * auto-size que o Form Designer calculou, logo fixa-los eh reproducao

*-- Linhas 998 a 1027:
998: 
999:         TRY
1000:             *-- Say_Procura - legenda "Procurar Codigo : "
1001:             THIS.AddObject("lbl_4c__Procura", "Label")
1002:             WITH THIS.lbl_4c__Procura
1003:                 .AutoSize  = .F.
1004:                 .Top       = 350
1005:                 .Left      = 83
1006:                 .Width     = 89
1007:                 .Height    = 15
1008:                 .FontName  = "Tahoma"
1009:                 .FontSize  = 8
1010:                 .BackStyle = 0
1011:                 .Alignment = 0
1012:                 .ForeColor = RGB(90, 90, 90)
1013:                 .TabIndex  = 6
1014:                 .Caption   = "Procurar C" + CHR(243) + "digo : "
1015:                 .Visible   = .T.
1016:             ENDWITH
1017: 
1018:             *-- Get_Procura - codigo procurado na grade (Numes, n(6))
1019:             THIS.AddObject("txt_4c_Procura", "TextBox")
1020:             WITH THIS.txt_4c_Procura
1021:                 .Top       = 347
1022:                 .Left      = 186
1023:                 .Width     = 48
1024:                 .Height    = 23
1025:                 .FontName  = "Tahoma"
1026:                 .FontSize  = 8
1027:                 .Alignment = 3

*-- Linhas 1084 a 1108:
1084:     * CorretorAutomatico) - sem isso o icone nao renderiza quando o botao
1085:     * esta desabilitado.
1086:     *
1087:     * cmd_4c_Ok termina em Left+Width = 723+80 = 803, 3px alem do Width = 800
1088:     * do form: a sobra eh RECORTADA. Isso eh HERDADO do SCX (o legado declara
1089:     * exatamente esses numeros) - nao se "corrige" inventando posicao nova
1090:     * (regras #28/#30).
1091:     *==========================================================================
1092:     PROTECTED PROCEDURE ConfigurarBotoes()
1093:         LOCAL loc_oErro
1094: 
1095:         TRY
1096:             *-- SelTudo - marca TODAS as pendencias ainda nao vinculadas
1097:             THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
1098:             WITH THIS.cmd_4c_SelTudo
1099:                 .Top              = 216
1100:                 .Left             = 704
1101:                 .Width            = 40
1102:                 .Height           = 40
1103:                 .Caption          = ""
1104:                 .FontName         = "Comic Sans MS"
1105:                 .FontSize         = 8
1106:                 .FontBold         = .T.
1107:                 .FontItalic       = .T.
1108:                 .WordWrap         = .T.

*-- Linhas 1117 a 1131:
1117:             ENDWITH
1118: 
1119:             *-- apaga - desmarca TODAS as pendencias ja vinculadas
1120:             THIS.AddObject("cmd_4c_Apaga", "CommandButton")
1121:             WITH THIS.cmd_4c_Apaga
1122:                 .Top              = 256
1123:                 .Left             = 704
1124:                 .Width            = 40
1125:                 .Height           = 40
1126:                 .Caption          = ""
1127:                 .FontName         = "Comic Sans MS"
1128:                 .FontSize         = 8
1129:                 .FontBold         = .T.
1130:                 .FontItalic       = .T.
1131:                 .WordWrap         = .T.

*-- Linhas 1143 a 1157:
1143:             *-- Cancel = .T. transcrito do dump: ESC aciona este botao (eh a
1144:             *-- UNICA saida da tela, que nao tem X nem barra de titulo -
1145:             *-- ControlBox = .F. / Closable = .F. / TitleBar = 0).
1146:             THIS.AddObject("cmd_4c_Ok", "CommandButton")
1147:             WITH THIS.cmd_4c_Ok
1148:                 .Top              = 4
1149:                 .Left             = 723
1150:                 .Width            = 80
1151:                 .Height           = 100
1152:                 .Caption          = "\<Ok"
1153:                 .Cancel           = .T.
1154:                 .FontName         = "Comic Sans MS"
1155:                 .FontSize         = 8
1156:                 .FontBold         = .T.
1157:                 .FontItalic       = .T.

*-- Linhas 1167 a 1177:
1167: 
1168:             *-- Handlers dos tres Click (PUBLIC - BINDEVENT falha em silencio
1169:             *-- com metodo PROTECTED, regra CLAUDE.md #3).
1170:             BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
1171:             BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnApagaClick")
1172:             BINDEVENT(THIS.cmd_4c_Ok,      "Click", THIS, "BtnOkClick")
1173:         CATCH TO loc_oErro
1174:             MsgErro(loc_oErro.Message + CHR(13) + ;
1175:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                 "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
1177:         ENDTRY

*-- Linhas 1213 a 1242:
1213: 
1214:         loc_lInserir = (UPPER(ALLTRIM(THIS.this_cOpEscolha)) == "INSERIR")
1215: 
1216:         IF PEMSTATUS(THIS, "cmd_4c_SelTudo", 5)
1217:             THIS.cmd_4c_SelTudo.Visible = loc_lInserir
1218:         ENDIF
1219: 
1220:         IF PEMSTATUS(THIS, "cmd_4c_Apaga", 5)
1221:             THIS.cmd_4c_Apaga.Visible = loc_lInserir
1222:         ENDIF
1223: 
1224:         IF PEMSTATUS(THIS, "lbl_4c__Procura", 5)
1225:             THIS.lbl_4c__Procura.Visible = loc_lInserir
1226:         ENDIF
1227: 
1228:         IF PEMSTATUS(THIS, "txt_4c_Procura", 5)
1229:             THIS.txt_4c_Procura.Visible = loc_lInserir
1230:         ENDIF
1231: 
1232:         IF PEMSTATUS(THIS, "cmd_4c_Ok", 5)
1233:             THIS.cmd_4c_Ok.Visible = .T.
1234:         ENDIF
1235: 
1236:         *-- "PROCEDURE When / Return (ThisForm.Op_Escolha = 'INSERIR')" do
1237:         *-- fwcheckbox1 da coluna de selecao: fora do modo INSERIR a celula
1238:         *-- nao aceita marcacao. Aplicado como Column1.ReadOnly porque, em
1239:         *-- VFP9, o ReadOnly da Column PROPAGA para o controle que ela
1240:         *-- desenha - medido: Column1.ReadOnly = .T. deixa Check1.ReadOnly em
1241:         *-- .T., e voltar a .F. destrava. Reproduz o When por PROPRIEDADE, e
1242:         *-- nao por BINDEVENT("When"), porque BINDEVENT DESCARTA o retorno do

*-- Linhas 1512 a 1532:
1512: 
1513:     *==========================================================================
1514:     * GradeSelecaoInteractiveChange - "PROCEDURE InteractiveChange" de
1515:     * SIGOPPDT.Grade.seleciona.fwcheckbox1, o evento que de fato VINCULA e
1516:     * DESVINCULA a pendencia marcada:
1517:     *
1518:     *   =DoDefault()
1519:     *   If Not This.Value
1520:     *       ThisForm.Desmarca
1521:     *   Else
1522:     *       This.Value = ThisForm.Marca()
1523:     *   EndIf
1524:     *
1525:     * Tres coisas que a transcricao precisa preservar:
1526:     *
1527:     *   - "=DoDefault()" significa que o toggle NATIVO do checkbox JA rodou
1528:     *     quando este codigo comeca; "This.Value" eh o valor DEPOIS do
1529:     *     clique, nao antes. Por isso o handler LE o estado em vez de
1530:     *     alterna-lo.
1531:     *   - "Marca()" sem argumento eh MarcarPendencia() sem argumento: o
1532:     *     llAutomatico do legado fica .F. e os MsgAviso de bloqueio APARECEM

*-- Linhas 1638 a 1646:
1638:                     THIS.ReposicionarPendencia(loc_cAlias, loc_nRec)
1639: 
1640:                     IF !loc_lAceito
1641:                         loc_oChk.Value = .F.
1642:                     ELSE
1643:                         *-- Cauda do Marca() legado: so roda quando a
1644:                         *-- pendencia foi ACEITA (o legado tambem nao chega
1645:                         *-- la nos ramos que dao "Return .f.").
1646:                         THIS.AtualizarFormPai()

*-- Linhas 1747 a 1755:
1747: 
1748:     *==========================================================================
1749:     * GradeColunaGotFocus - "PROCEDURE GotFocus / ThisForm.Grade.Seleciona.
1750:     * fwcheckbox1.SetFocus", que o legado declara no Text1 de SEIS colunas de
1751:     * consulta (empresa, operacao, data, Grupo, Conta e Column8): tentar
1752:     * entrar em qualquer coluna que nao seja a de selecao devolve o foco a
1753:     * coluna de selecao.
1754:     *
1755:     * Wrapper com guarda de reentrancia e corpo em FocarSelecaoGrade, mesmo

*-- Linhas 1781 a 1789:
1781:     *   If Not Empty(This.Value)              If (TmpPends.Numes == This.Value) ;
1782:     *       Select TmpPends                      Or (This.Value = 0)
1783:     *       Set Order To Numes                       ThisForm.Grade.Seleciona. ;
1784:     *       Set Near On                                  fwcheckbox1.SetFocus
1785:     *       Seek This.Value                   EndIf
1786:     *       Set Near Off
1787:     *       ThisForm.Refresh
1788:     *       If (This.Value == TmpPends.Numes)
1789:     *           This.Value = 0

*-- Linhas 1936 a 1944:
1936:     ENDPROC
1937: 
1938:     *==========================================================================
1939:     * FocarSelecaoGrade - "ThisForm.Grade.Seleciona.fwcheckbox1.SetFocus" do
1940:     * legado, que aparece no LostFocus de Get_Procura e no GotFocus de TODA
1941:     * coluna de consulta da grade (empresa/operacao/codigo/data/Grupo/Conta/
1942:     * Column8): o foco sempre volta para a coluna de SELECAO, a unica
1943:     * editavel da tela.
1944:     *


### BO (C:\4c\projeto\app\classes\SigOpPdtBO.prg):
*==============================================================================
* SigOpPdtBO.prg - Business Object para FormSigOpPdt (operacoes em aberto)
* Herda de BusinessBase
*
* Origem legado: tasks\task784\SigOpPdt.SCX (form SIGOPPDT, DataSession = 2,
* WindowType = 1 - dialogo MODAL aberto pela tela de movimentacao SigMvCab
* para marcar/desmarcar quais operacoes em aberto ficam vinculadas ao
* documento corrente).
*
* ATENCAO - ESTE DIALOGO NAO TEM TABELA PROPRIA NO SQL SERVER:
* o Init legado cria o cursor de exibicao TmpPends a partir de um SELECT em
* SigMvCab (armazenado em PendEest) e usa TRES cursores que pertencem ao
* FORM PAI (crSigMvCab, crLclMvItn, TmpOperacao - ver Init/Marca/Desmarca do
* dump legado). A gravacao da marcacao/desmarcacao eh um UPDATE direto em
* SigMvCab (coluna ChkSubn), nao um Inserir/Atualizar de registro proprio -
* por isso this_cTabela fica vazio (ver Init) e a persistencia real sera
* feita em metodos dedicados (fase 2), nao em Inserir()/Atualizar().
*
* Estrutura EXATA do cursor de exibicao (transcrita do Create Cursor legado):
*   TmpPends ( Flag l, Emps c(3), Dopes c(20), Numes n(6), MascNum c(6),
*              Datas t Null, TpFats c(3), Origem c(21), Destino c(21),
*              Valos n(12,2) )
*              Index on Emps + Dopes + Str(Numes, 6) Tag EmpDopNum
*              Index on Numes Tag Numes
*
* Chave de cada linha da grade (lcNivel no legado) = Emps + Dopes + Str(Numes,6),
* usada no WHERE EmpDopNums = '<lcNivel>' do UPDATE SigMvCab em Marca/Desmarca.
*
* Cursores do FORM PAI (SigMvCab), CONTRATO - nomes NAO renomeados:
*   crSigMvCab   - cabecalho do movimento corrente (Emps, Dopes, Numes,
*                  ContaOs, ContaDs, GrupoOs, GrupoDs, GrVends, Vends, Obses)
*   crLclMvItn   - cursor local de itens do movimento corrente
*   TmpOperacao  - cursor de controle (Codigos) com os niveis ja vinculados
*
* FASE 1/8: declaracao de TODAS as propriedades + Init.
* FASE 2/8: CarregarPendencias (reproduz o SELECT em SigMvCab + filtros de
* conta do Init legado), CarregarDoCursor (linha corrente -> propriedades),
* MarcarPendencia/DesmarcarPendencia (equivalentes a Marca/Desmarca) e
* ObterChavePrimaria. Inserir/Atualizar/ExecutarExclusao ficam com o default
* herdado - este dialogo nao insere nem exclui registro proprio nenhum.
*==============================================================================
DEFINE CLASS SigOpPdtBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da LINHA CORRENTE do cursor de exibicao (TmpPends), uma
    * para cada coluna da grade de 8 colunas do legado (seleciona, empresa,
    * operacao, codigo, data, Grupo=Origem, Conta=Destino, Column8=valor)
    *--------------------------------------------------------------------------
    this_lFlag     = .F.   && Flag      l       - pendencia esta marcada (vinculada)
    this_cEmps     = ""    && Emps      c(3)    - empresa do documento pendente
    this_cDopes    = ""    && Dopes     c(20)   - codigo da operacao (SigCdOpe.Dopes)
    this_nNumes    = 0     && Numes     n(6)    - numero do documento pendente
    this_cMascNum  = ""    && MascNum   c(6)    - numero do documento formatado p/ exibicao
    this_dDatas    = {}    && Datas     t       - data/hora do documento pendente
    this_cTpFats   = ""    && TpFats    c(3)    - tipo de fatura (nao exibido na grade,
                           && mas faz parte da estrutura do cursor legado)
    this_cOrigem   = ""    && Origem    c(21)   - "GrupoOs/ContaOs" resolvido no Init
    this_cDestino  = ""    && Destino   c(21)   - "GrupoDs/ContaDs" resolvido no Init
    this_nValos    = 0     && Valos     n(12,2) - valor do documento pendente

    *--------------------------------------------------------------------------
    * Variaveis de sessao do dialogo, calculadas UMA VEZ no Init legado a
    * partir de crSigMvCab.Dopes (consulta a SigCdOpe) e reaproveitadas
    * durante o ciclo de vida da tela - decidem como Origem/Destino sao
    * resolvidos e filtrados (equivalente a lcDopesNivel, lnPuxaOrigem,
    * lnPuxaDestino, lcNumeroNivel do Init; FixGOrigs/FixGDests/ConOSubs/
    * ConDSubs sao relidos em Marca a partir da operacao do documento
    * CORRENTE, mas com a MESMA semantica)
    *--------------------------------------------------------------------------
    this_cDopesNivel    = ""   && TempOpe.Nivels  - codigo de operacao "nivel" do documento
    this_cNumeroNivel   = ""   && Str(TempOpe.NDopes, 4) - numero sequencial da operacao nivel
    this_nPuxaOrigem    = 0    && TempOpe.ConOSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_nPuxaDestino   = 0    && TempOpe.ConDSubs - 0=nao puxa / 1=usa Origem / 2=usa Destino
    this_lFixGOrigs     = .F.  && TempOpe.FixGOrigs - grupo de origem fixo (nao sobrescrever)
    this_lFixGDests     = .F.  && TempOpe.FixGDests - grupo de destino fixo (nao sobrescrever)

    *--------------------------------------------------------------------------
    * Escolha operacional herdada do form pai (ThisForm.Op_Escolha =
    * ThisForm.Parentform.pcEscolha no legado). Controla se o checkbox de
    * marcacao esta habilitado (When = Op_Escolha = 'INSERIR') e se os
    * botoes SelTudo/Apaga agem (When = Inlist(Op_Escolha,'INSERIR','ALTERAR')).
    *--------------------------------------------------------------------------
    this_cOpEscolha = ""

    *--------------------------------------------------------------------------
    * Descricoes resolvidas (SigCdCli.RClis) apos Marcar/Desmarcar uma
    * pendencia - equivalente ao bloco final de Marca() do legado que
    * preenchia ThisForm.ParentForm.Pagina.Dados.Origem/Destino/Responsavel.
    * get_dconta.Value. Aqui ficam disponiveis como SAIDA de dados para o
    * FORM repassar ao form pai (BO nunca toca em controle de outro form).
    *--------------------------------------------------------------------------
    this_cOrigemDesc      = ""
    this_cDestinoDesc     = ""
    this_cResponsavelDesc = ""

    *--------------------------------------------------------------------------
    * Cursores proprios deste dialogo (nomenclatura nova - PILAR 3)
    *--------------------------------------------------------------------------
    this_cCursorPendentes = "cursor_4c_Pendentes"  && migrado de TmpPends (grade)
    this_cCursorPendEest  = "cursor_4c_PendEest"   && migrado de PendEest (SELECT em SigMvCab)
    this_cCursorTempOpe   = "cursor_4c_TempOpe"    && migrado de TempOpe (lookup SigCdOpe)
    this_cCursorCli       = "cursor_4c_Cli"        && migrado de crCli (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Cursores do FORM PAI (SigMvCab) - CONTRATO, nomes do legado preservados
    * de proposito (ver cabecalho do arquivo). Este dialogo entra na data
    * session do form pai (par_nDataSession recebido pelo Form) e LE/ESCREVE
    * nesses cursores sem recria-los.
    *--------------------------------------------------------------------------
    this_cCursorSigMvCab    = "crSigMvCab"
    this_cCursorLclMvItn    = "crLclMvItn"
    this_cCursorTmpOperacao = "TmpOperacao"

    *--------------------------------------------------------------------------
    * Tabelas do SQL Server consultadas/atualizadas por este dialogo
    *--------------------------------------------------------------------------
    this_cTabelaSigMvCab = "SigMvCab"
    this_cTabelaSigCdOpe = "SigCdOpe"
    this_cTabelaSigMvItn = "SigMvItn"
    this_cTabelaSigCdCli = "SigCdCli"

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *
    * this_cTabela fica VAZIO de proposito: este dialogo nao persiste um
    * registro proprio (ver cabecalho) - a gravacao eh um UPDATE direto em
    * SigMvCab.ChkSubn, feito por metodo dedicado na fase 2. O campo chave
    * eh Numes, que eh o indice usado pelo legado para localizar a pendencia
    * ao digitar o numero no campo de procura (Get_Procura.Valid faz
    * Set Order To Numes / Seek This.Value em TmpPends).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = DODEFAULT()

            IF loc_lResultado
                THIS.this_cTabela     = ""
                THIS.this_cCampoChave = "Numes"

                *-- Estado inicial da linha corrente - zerado aqui (e nao so na
                *-- declaracao) para que reusar a mesma instancia do BO numa
                *-- segunda abertura do dialogo nunca exiba dados da anterior.
                THIS.this_lFlag     = .F.
                THIS.this_cEmps     = ""
                THIS.this_cDopes    = ""
                THIS.this_nNumes    = 0
                THIS.this_cMascNum  = ""
                THIS.this_dDatas    = {}
                THIS.this_cTpFats   = ""
                THIS.this_cOrigem   = ""
                THIS.this_cDestino  = ""
                THIS.this_nValos    = 0

                THIS.this_cDopesNivel  = ""
                THIS.this_cNumeroNivel = ""
                THIS.this_nPuxaOrigem  = 0
                THIS.this_nPuxaDestino = 0
                THIS.this_lFixGOrigs   = .F.
                THIS.this_lFixGDests   = .F.

                THIS.this_cOpEscolha = ""

                THIS.this_cOrigemDesc      = ""
                THIS.this_cDestinoDesc     = ""
                THIS.this_cResponsavelDesc = ""

                THIS.this_cMensagemErro = ""
                THIS.this_lErroExibido  = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA CORRENTE de cursor_4c_Pendentes (o
    * cursor de exibicao, equivalente a TmpPends do legado) para as
    * propriedades this_* da linha. Chamado antes de Marcar/Desmarcar e pelo
    * Form sempre que precisar ler os dados da linha selecionada na grade.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF !EOF()
                    THIS.this_lFlag    = Flag
                    THIS.this_cEmps    = TratarNulo(Emps, "")
                    THIS.this_cDopes   = TratarNulo(Dopes, "")
                    THIS.this_nNumes   = TratarNulo(Numes, 0)
                    THIS.this_cMascNum = TratarNulo(MascNum, "")
                    THIS.this_dDatas   = TratarNulo(Datas, {})
                    THIS.this_cTpFats  = TratarNulo(TpFats, "")
                    THIS.this_cOrigem  = TratarNulo(Origem, "")
                    THIS.this_cDestino = TratarNulo(Destino, "")
                    THIS.this_nValos   = TratarNulo(Valos, 0)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Monta a chave POSICIONAL EmpDopNums (Emps char(3)
    * + Dopes char(20) + Str(Numes,6) = 29 chars) da LINHA CORRENTE, a partir
    * das propriedades carregadas por CarregarDoCursor. PADR explicito em
    * cada parte (regra #42) - NUNCA ALLTRIM nas partes internas, senao a
    * chave nunca casa com SigMvCab.EmpDopNums.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterDescricaoConta - Resolve a razao social (SigCdCli.RClis) de um
    * codigo de conta (IClis). Equivalente ao
    * "ThisForm.poDataMgr.CursorQuery('SigCdCli','crCli','IClis',<cod>,'RClis')
    * + If Not Eof('crCli') ... Else ''" repetido 3x no final de Marca().
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterDescricaoConta(par_cCodigo)
        LOCAL loc_cDescricao, loc_cSQL, loc_nResultado
        loc_cDescricao = ""

        TRY
            IF !EMPTY(par_cCodigo)
                IF USED("cursor_4c_Cli")
                    USE IN cursor_4c_Cli
                ENDIF

                loc_cSQL = "SELECT RClis FROM " + THIS.this_cTabelaSigCdCli + ;
                           " WHERE IClis = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cli")

                IF loc_nResultado > 0
                    IF !EOF("cursor_4c_Cli")
                        loc_cDescricao = TratarNulo(cursor_4c_Cli.RClis, "")
                    ENDIF
                    USE IN cursor_4c_Cli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cDescricao = ""
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendencias - Monta cursor_4c_Pendentes (grade de exibicao,
    * equivalente a TmpPends) a partir do movimento corrente (crSigMvCab,
    * cursor do FORM PAI). Transcricao literal do PROCEDURE Init do legado
    * (a parte de montagem de dados - o restante do Init, que cria o
    * FormSigOpPdt e configura a grade, fica na FASE 3/Form).
    *
    * Pre-requisitos (contrato do form pai, ver cabecalho do arquivo):
    *   - crSigMvCab posicionado no documento corrente
    *   - TmpOperacao aberto (cursor de niveis ja vinculados)
    *
    * Retorno: .T. com cursor_4c_Pendentes populado (GO TOP); .F. em falha,
    * com this_cMensagemErro preenchido.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPendencias()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_cDopesNivel, loc_cNumeroNivel, loc_nPuxaOrigem, loc_nPuxaDestino
        LOCAL loc_cEd1, loc_cEd2, loc_cOrigem, loc_cDestino, loc_lFlag, loc_nNivelAtual

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursor de controle do movimento (TmpOperacao) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_Pendentes")
                    USE IN cursor_4c_Pendentes
                ENDIF

                CREATE CURSOR cursor_4c_Pendentes ;
                    (Flag L, Emps C(3), Dopes C(20), Numes N(6), MascNum C(6), ;
                     Datas T, TpFats C(3), Origem C(21), Destino C(21), Valos N(12,2))
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum
                INDEX ON Numes TAG Numes

                SELECT TmpOperacao
                DELETE ALL FOR EMPTY(Codigos)

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT Nivels, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cDopesNivel  = TratarNulo(cursor_4c_TempOpe.Nivels, "")
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(loc_cDopesNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_cNumeroNivel = STR(TratarNulo(cursor_4c_TempOpe.NDopes, 0), 4)
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cEd1 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(0, 6)
                loc_cEd2 = PADR(go_4c_Sistema.cCodEmpresa, 3) + PADR(loc_cDopesNivel, 20) + STR(999999, 6)

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT Emps, Dopes, Numes, MascNum, Datas, Valos, ChkSubn, GrupoOs, GrupoDs, ContaOs, ContaDs" + ;
                           " FROM " + THIS.this_cTabelaSigMvCab + ;
                           " WHERE EmpDopNums BETWEEN " + EscaparSQL(loc_cEd1) + " AND " + EscaparSQL(loc_cEd2)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_PendEest
                SCAN
                    loc_nNivelAtual = VAL(loc_cNumeroNivel + TRANSFORM(cursor_4c_PendEest.Numes, "@L 999999"))

                    IF cursor_4c_PendEest.ChkSubn AND !SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")
                        LOOP
                    ENDIF

                    loc_cOrigem  = ""
                    loc_cDestino = ""

                    IF INLIST(loc_nPuxaOrigem, 1, 2)
                        IF loc_nPuxaOrigem = 1
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaOs) AND crSigMvCab.ContaOs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cOrigem = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cOrigem = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                    ENDIF

                    IF INLIST(loc_nPuxaDestino, 1, 2)
                        IF loc_nPuxaDestino = 1
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaOs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoOs + "/" + cursor_4c_PendEest.ContaOs
                        ELSE
                            IF !EMPTY(crSigMvCab.ContaDs) AND crSigMvCab.ContaDs <> cursor_4c_PendEest.ContaDs
                                LOOP
                            ENDIF
                            loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                        ENDIF
                    ELSE
                        loc_cDestino = cursor_4c_PendEest.GrupoDs + "/" + cursor_4c_PendEest.ContaDs
                    ENDIF

                    loc_lFlag = SEEK(loc_nNivelAtual, "TmpOperacao", "Codigos")

                    INSERT INTO cursor_4c_Pendentes (Flag, Emps, Dopes, Numes, MascNum, Datas, Origem, Destino, Valos) ;
                        VALUES (loc_lFlag, cursor_4c_PendEest.Emps, cursor_4c_PendEest.Dopes, cursor_4c_PendEest.Numes, ;
                                cursor_4c_PendEest.MascNum, cursor_4c_PendEest.Datas, loc_cOrigem, loc_cDestino, ;
                                cursor_4c_PendEest.Valos)
                ENDSCAN

                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                SELECT cursor_4c_Pendentes
                GO TOP

                THIS.this_cDopesNivel  = loc_cDopesNivel
                THIS.this_cNumeroNivel = loc_cNumeroNivel
                THIS.this_nPuxaOrigem  = loc_nPuxaOrigem
                THIS.this_nPuxaDestino = loc_nPuxaDestino

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPendencia - vincula a pendencia CORRENTE de cursor_4c_Pendentes
    * ao documento corrente (crSigMvCab), gravando o vinculo em
    * SigMvCab.ChkSubn. Equivalente ao PROCEDURE Marca() do legado - esta EH
    * a persistencia real deste dialogo (ver cabecalho do arquivo: nao ha
    * Inserir()/Atualizar() de registro proprio porque o dado gravado
    * pertence a SigMvCab, nao a uma tabela deste BO).
    *
    * par_lAutomatico (.T./.F.) suprime os MsgAviso de bloqueio - equivalente
    * a "llAutomatico" do legado, usado pelo botao "Selecionar Tudo".
    *
    * Apos marcar com sucesso, this_cOrigemDesc/this_cDestinoDesc/
    * this_cResponsavelDesc ficam com a razao social resolvida (SigCdCli)
    * das contas de Origem/Destino/Responsavel de crSigMvCab, para o FORM
    * repassar aos controles do form pai.
    *
    * Retorno: .T. se marcou com sucesso; .F. se bloqueado ou se falhou a
    * gravacao (mensagem em this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPendencia(par_lAutomatico)
        LOCAL loc_lResultado, loc_lProsseguir, loc_lAutomatico
        LOCAL loc_cNivel, loc_nNumNivel, loc_cSQL, loc_nResultado
        LOCAL loc_nPuxaOrigem, loc_nPuxaDestino, loc_lFixGOrigs, loc_lFixGDests
        LOCAL loc_nItens

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_lAutomatico = (par_lAutomatico = .T.)
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crLclMvItn") OR !USED("TmpOperacao")
                    THIS.this_cMensagemErro = "Cursores do movimento corrente (crLclMvItn/TmpOperacao) nao estao abertos."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                    IF !loc_lAutomatico
                        MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Digitada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                    THIS.this_cMensagemErro = "Movimentacao ja digitada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT FixGDests, FixGOrigs, ConOSubs, ConDSubs FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(crSigMvCab.Dopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nPuxaOrigem  = TratarNulo(cursor_4c_TempOpe.ConOSubs, 0)
                    loc_nPuxaDestino = TratarNulo(cursor_4c_TempOpe.ConDSubs, 0)
                    loc_lFixGOrigs   = cursor_4c_TempOpe.FixGOrigs
                    loc_lFixGDests   = cursor_4c_TempOpe.FixGDests
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_PendEest")
                    USE IN cursor_4c_PendEest
                ENDIF

                loc_cSQL = "SELECT ChkSubn, Obses, GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends FROM " + ;
                           THIS.this_cTabelaSigMvCab + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PendEest")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                DO CASE
                    CASE cursor_4c_PendEest.ChkSubn
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o J" + CHR(225) + " Utilizada Em Outra Opera" + CHR(231) + CHR(227) + "o!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao ja utilizada em outra operacao."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaDs) AND cursor_4c_PendEest.ContaDs <> crSigMvCab.ContaDs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.

                    CASE !EMPTY(crSigMvCab.ContaOs) AND cursor_4c_PendEest.ContaOs <> crSigMvCab.ContaOs
                        IF !loc_lAutomatico
                            MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o de Outra Conta!!!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        THIS.this_cMensagemErro = "Movimentacao de outra conta."
                        loc_lProsseguir = .F.
                ENDCASE
            ENDIF

            IF loc_lProsseguir
                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 1, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crLclMvItn
                DELETE ALL FOR EMPTY(Cpros)
                GO BOTTOM

                SELECT TmpOperacao
                INSERT INTO TmpOperacao (Codigos) VALUES (loc_nNumNivel)

                IF EMPTY(crSigMvCab.Obses)
                    REPLACE Obses WITH cursor_4c_PendEest.Obses IN crSigMvCab
                ENDIF

                IF INLIST(loc_nPuxaOrigem, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoOs) OR (EMPTY(crSigMvCab.ContaOs) AND !loc_lFixGOrigs)
                        REPLACE GrupoOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaOs)
                        REPLACE ContaOs WITH IIF(loc_nPuxaOrigem = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF INLIST(loc_nPuxaDestino, 1, 2)
                    IF EMPTY(crSigMvCab.GrupoDs) OR (EMPTY(crSigMvCab.ContaDs) AND !loc_lFixGDests)
                        REPLACE GrupoDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.GrupoOs, cursor_4c_PendEest.GrupoDs) IN crSigMvCab
                    ENDIF
                    IF EMPTY(crSigMvCab.ContaDs)
                        REPLACE ContaDs WITH IIF(loc_nPuxaDestino = 1, cursor_4c_PendEest.ContaOs, cursor_4c_PendEest.ContaDs) IN crSigMvCab
                    ENDIF
                ENDIF

                IF EMPTY(crSigMvCab.GrVends)
                    REPLACE GrVends WITH cursor_4c_PendEest.GrVends IN crSigMvCab
                ENDIF
                IF EMPTY(crSigMvCab.Vends)
                    IF crSigMvCab.GrVends = cursor_4c_PendEest.GrVends
                        REPLACE Vends WITH cursor_4c_PendEest.Vends IN crSigMvCab
                    ENDIF
                ENDIF

                USE IN cursor_4c_PendEest

                IF USED("cursor_4c_Itens")
                    USE IN cursor_4c_Itens
                ENDIF

                loc_cSQL = "SELECT * FROM " + THIS.this_cTabelaSigMvItn + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

                IF loc_nResultado >= 0
                    SELECT cursor_4c_Itens
                    SCAN
                        SCATTER MEMVAR MEMO
                        INSERT INTO crLclMvItn FROM MEMVAR
                    ENDSCAN

                    IF USED("cursor_4c_Itens")
                        USE IN cursor_4c_Itens
                    ENDIF
                ENDIF

                loc_nItens = 0
                SELECT crLclMvItn
                SET ORDER TO
                SCAN
                    IF EMPTY(Cpros)
                        LOOP
                    ENDIF
                    loc_nItens = loc_nItens + 1
                    REPLACE cItens WITH loc_nItens
                ENDSCAN

                GO TOP
                IF EOF()
                    INSERT INTO crLclMvItn (Emps, Dopes, Numes, cItens) ;
                        VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, loc_nItens + 1)
                ENDIF
                SET ORDER TO

                THIS.this_cOrigemDesc      = THIS.ObterDescricaoConta(crSigMvCab.ContaOs)
                THIS.this_cDestinoDesc     = THIS.ObterDescricaoConta(crSigMvCab.ContaDs)
                THIS.this_cResponsavelDesc = THIS.ObterDescricaoConta(crSigMvCab.Vends)

                THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_cTabela = ""

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarPendencia - desfaz o vinculo da pendencia CORRENTE de
    * cursor_4c_Pendentes com o documento corrente (crSigMvCab), gravando
    * SigMvCab.ChkSubn = 0. Equivalente ao PROCEDURE Desmarca() do legado.
    *
    * Retorno: .T. se desvinculou com sucesso; .F. em falha (mensagem em
    * this_cMensagemErro).
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarPendencia()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cNivel, loc_nNumNivel
        LOCAL loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        TRY
            IF loc_lProsseguir
                IF !USED("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("cursor_4c_Pendentes")
                    THIS.this_cMensagemErro = "Nenhuma pendencia selecionada."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta aberto."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF EOF("crSigMvCab")
                    THIS.this_cMensagemErro = "Cursor do movimento corrente (crSigMvCab) nao esta posicionado."
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.CarregarDoCursor("cursor_4c_Pendentes")
                loc_cNivel = THIS.ObterChavePrimaria()

                IF USED("cursor_4c_TempOpe")
                    USE IN cursor_4c_TempOpe
                ENDIF

                loc_cSQL = "SELECT NDopes FROM " + THIS.this_cTabelaSigCdOpe + ;
                           " WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempOpe")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    loc_nNumNivel = VAL(STR(cursor_4c_TempOpe.NDopes, 4) + TRANSFORM(THIS.this_nNumes, "@L 999999"))
                    USE IN cursor_4c_TempOpe
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF USED("crLclMvItn")
                    SELECT crLclMvItn
                    DELETE ALL FOR Dopes + STR(Numes, 6) = THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                ENDIF

                IF USED("TmpOperacao")
                    IF SEEK(loc_nNumNivel, "TmpOperacao", "Codigos")
                        SELECT TmpOperacao
                        DELETE
                    ENDIF
                ENDIF

                loc_cSQL = "UPDATE " + THIS.this_cTabelaSigMvCab + " SET ChkSubn = 0, DtAlts = GETDATE(), DtBaixas = " + ;
                           FormatarDataSQL(crSigMvCab.Datas) + " WHERE EmpDopNums = " + EscaparSQL(loc_cNivel)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_cTabela = THIS.this_cTabelaSigMvCab
                    THIS.RegistrarAuditoria("UPDATE")
                    THIS.this_cTabela = ""

                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir/Atualizar/ExecutarExclusao - PROPOSITALMENTE nao sobrescritos.
    *
    * Este dialogo nao grava um registro proprio (ver cabecalho do arquivo
    * e comentario do Init): a gravacao real e o UPDATE SigMvCab.ChkSubn,
    * feito por MarcarPendencia()/DesmarcarPendencia() acima - que SAO, na
    * pratica, o Inserir()/Atualizar() desta tela. O comportamento padrao
    * herdado de BusinessBase (recusar a operacao) ja eh o correto para
    * estes tres metodos.
    *--------------------------------------------------------------------------

ENDDEFINE

