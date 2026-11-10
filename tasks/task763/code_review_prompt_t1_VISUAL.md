# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ThisForm.GridSels define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.GridSels.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLoc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1099 linhas total):

*-- Linhas 41 a 67:
41: *   - Init() - ponto de entrada; delega ao FormBase.Init via DODEFAULT()
42: *   - InicializarForm() - fundo do form (Picture new_background.jpg),
43: *     criacao do Business Object e montagem da faixa do cabecalho
44: *   - ConfigurarCabecalho() - cnt_4c_Sombra + lbl_4c_LblSombra/lbl_4c_LblTitulo
45: *     (mapeamento.json: cntSombra -> cnt_4c_Sombra, lblSombra ->
46: *     lbl_4c_LblSombra, lblTitulo -> lbl_4c_LblTitulo)
47: *   - TornarControlesVisiveis() recursivo (AddObject cria tudo Visible = .F.)
48: *   - Destroy() - libera o BO e devolve o controle ao FormBase via DODEFAULT()
49: *
50: *   A faixa do cabecalho eh o PRIMEIRO AddObject do form (regra #11): o
51: *   cmd_4c_BtnSair, em Top = 3, fica DENTRO da area da faixa (Top 0..80) e
52: *   precisa ser criado depois dela para desenhar por cima.
53: *
54: * FASE 4/8 - GRADE E BOTOES (o que esta fase acrescenta)
55: *   O gate desta fase tem dois ramos. O PAGINADO (ConfigurarPaginaLista +
56: *   AlternarPagina) nao se aplica: o legado nao tem PageFrame (ver "LAYOUT FLAT"
57: *   acima), e inventar Page de Lista/Dados com os 6 botoes CRUD violaria o
58: *   PILAR 1. Vale o ramo FLAT, que cobra a superficie que o legado de fato tem -
59: *   grade, botoes e metodo de carga:
60: *     - ConfigurarGrade()          - grd_4c_Dados (GridSels), 337x165 em 192,132
61: *     - FormatarColunasGrade()     - as tres colunas, larguras 15/80/220
62: *     - GarantirCheckBoxMarcacao() - chk_4c_Check1 na Column1, IDEMPOTENTE
63: *     - ConfigurarBotoes()         - shp_4c_Shape2 + os tres CommandButton
64: *     - AjustarOrdemTabulacao()    - TabIndex dos focalizaveis
65: *     - CarregarDados()            - FUNIL: bind + GO TOP + Refresh
66: *     - ChkMarcacao{KeyPress,MouseUp,MouseDown,Click} - alternancia da linha
67: *

*-- Linhas 73 a 81:
73: *   codigo desta fase (scripts em automation\probe763.prg e
74: *   automation\probevcx763.prg) estao registradas no comentario de cada metodo:
75: *     1. Grid auto-liga ao alias CORRENTE quando ColumnCount eh definido;
76: *     2. AddObject de CheckBox em Column ligada a coluna de TEXTO estoura
77: *        "Data type mismatch"; ligada a Imps (bit -> Logico), funciona;
78: *     3. Column.Width aplicada depois de RecordSource fica (15/80/220);
79: *     4. Shape nao tem ForeColor nem ZOrderSet; fwbtnp = 40x40, fwbtng = 80x100.
80: *
81: * FASE 7/8 - EVENTOS PRINCIPAIS (o que esta fase acrescenta)

*-- Linhas 121 a 129:
121: *   (automation\MedirGateF8Task763.ps1, que reusa os helpers do proprio
122: *   orquestrador em vez de reimplementa-los):
123: *     temListaLegadoF8  = True   (BaseClass: grid no dump)
124: *     temCamposLegadoF8 = True   (BaseClass: checkbox/textbox no dump)
125: *     semCrudLegadoF8   = True   (sem frmcadastro, Grupo_Op, pcEscolha nem
126: *                                 botao com verbo Incluir/Alterar/Visualizar/Excluir)
127: *     legadoSemSalvar   = True   (sem btnSalvar/btnGravar/mGravaDados)
128: *     Test-LegadoSomenteLeitura = False  -> NAO eh visualizador/exibicao: a
129: *                                 caixa de marcacao da Column1 eh editavel

*-- Linhas 265 a 276:
265: 
266:                 *-- 4. Caption propagado para os dois labels da faixa, igual as
267:                 *--    duas ultimas linhas do Init legado:
268:                 *--      ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
269:                 *--      ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
270:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
271:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
272: 
273:                 *-- 5. Grade de ocorrencias (GridSels do legado). Vem DEPOIS da
274:                 *--    faixa do cabecalho e ANTES dos botoes, na ordem da arvore
275:                 *--    de objetos do SCX.
276:                 THIS.ConfigurarGrade()

*-- Linhas 322 a 331:
322:     * ConfigurarCabecalho - faixa cinza com o titulo da tela
323:     *
324:     * mapeamento.json: SIGOPLOC.cntSombra           -> cnt_4c_Sombra
325:     *                  SIGOPLOC.cntSombra.lblSombra -> lbl_4c_LblSombra
326:     *                  SIGOPLOC.cntSombra.lblTitulo -> lbl_4c_LblTitulo
327:     *
328:     * O container eh identificado pelo par BackColor = RGB(100,100,100) +
329:     * Height = 80 (regra #11 - nunca pelo nome). lblSombra eh a sombra PRETA
330:     * desenhada 1px abaixo do titulo BRANCO (lblTitulo): o branco aqui eh
331:     * legitimo porque os dois labels moram num container OPACO escuro

*-- Linhas 346 a 395:
346:         loc_oCnt = THIS.cnt_4c_Sombra
347: 
348:         WITH loc_oCnt
349:             .Top           = 0
350:             .Left          = 0
351:             .Width         = THIS.Width
352:             .Height        = 80
353:             .BorderWidth   = 0
354:             .BackStyle     = 1
355:             .BackColor     = RGB(100, 100, 100)
356:             .SpecialEffect = 0
357:             .Visible       = .T.
358:         ENDWITH
359: 
360:         loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
361:         WITH loc_oCnt.lbl_4c_LblSombra
362:             .FontBold      = .T.
363:             .FontName      = "Tahoma"
364:             .FontSize      = 18
365:             .FontUnderline = .F.
366:             .WordWrap      = .T.
367:             .Alignment     = 0
368:             .BackStyle     = 0
369:             .AutoSize      = .F.
370:             .Caption       = THIS.Caption
371:             .Top           = 18
372:             .Left          = 10
373:             .Width         = 769
374:             .Height        = 40
375:             .ForeColor     = RGB(0, 0, 0)
376:             .Visible       = .T.
377:         ENDWITH
378: 
379:         loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
380:         WITH loc_oCnt.lbl_4c_LblTitulo
381:             .FontBold    = .T.
382:             .FontName    = "Tahoma"
383:             .FontSize    = 18
384:             .WordWrap    = .T.
385:             .Alignment   = 0
386:             .BackStyle   = 0
387:             .AutoSize    = .F.
388:             .Caption     = THIS.Caption
389:             .Top         = 17
390:             .Left        = 10
391:             .Width       = 769
392:             .Height      = 46
393:             .ForeColor   = RGB(255, 255, 255)
394:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
395:             .Visible     = .T.

*-- Linhas 425 a 450:
425:     * ColumnCount eh definido. Com crSigOpOco selecionado o resultado medido foi
426:     *   RecordSource = [Crsigopoco] / Column1.ControlSource = [crsigopoco.codigos]
427:     * e codigos eh char(10) (1a coluna de SigOpOco no docs\schema.sql), de modo
428:     * que um Column1.AddObject("...", "CheckBox") ali estoura NO PROPRIO AddObject
429:     * com "Error with ... Value : Data type mismatch" - o .Value do CheckBox nasce
430:     * numerico e a coluna esta ligada a texto. Por isso o ColumnCount eh a ULTIMA
431:     * atribuicao deste metodo e a caixa de marcacao so nasce em
432:     * GarantirCheckBoxMarcacao(), depois de Column1.ControlSource apontar para
433:     * Imps (bit -> Logico), onde o mesmo AddObject foi medido OK.
434:     *
435:     * Sem PageFrame neste form, entao sem compensacao de +29 no Top.
436:     *==========================================================================
437:     PROTECTED PROCEDURE ConfigurarGrade()
438:         LOCAL loc_oGrade
439: 
440:         THIS.AddObject("grd_4c_Dados", "Grid")
441:         loc_oGrade = THIS.grd_4c_Dados
442: 
443:         WITH loc_oGrade
444:             .Top               = 132
445:             .Left              = 192
446:             .Width             = 337
447:             .Height            = 165
448:             .FontName          = "Tahoma"
449:             .HeaderHeight      = 0
450:             .RowHeight         = 18

*-- Linhas 548 a 556:
548:     ENDPROC
549: 
550:     *==========================================================================
551:     * GarantirCheckBoxMarcacao - cria (uma vez) a caixa de marcacao da Column1
552:     *
553:     * mapeamento.json: SIGOPLOC.GridSels.Column1.Check1 -> chk_4c_Check1
554:     *
555:     * Column.AddObject cria o objeto mas NAO o exibe: sem CurrentControl a coluna
556:     * continua desenhando o Text1 dela, e sem Sparse = .F. a caixa so aparece na

*-- Linhas 572 a 602:
572:     * automation\probe763.prg) com a Column1 ligada a Imps (bit -> Logico): a
573:     * caixa nasce com .Value LOGICO vindo da linha corrente (VARTYPE = "L"), e
574:     * atribuir .Value = 0 o converte para NUMERICO (VARTYPE = "N"), divergindo do
575:     * tipo da coluna. A regra geral "CheckBox .Value = 0 no AddObject" vale para
576:     * caixa SOLTA ou ligada a coluna numerica, nao para esta.
577:     *
578:     * AutoSize = .F. explicito: o Init legado faz ".Column1.Check1.AutoSize = .t.",
579:     * mas AutoSize eh no-op em controle criado por AddObject (regra #23), entao
580:     * Width e Height sao transcritos do dump (22x17). Num controle de Column o
581:     * Grid redimensiona o CurrentControl para a celula, de modo que Top/Left/
582:     * Width/Height do dump sao reproduzidos sem efeito colateral.
583:     *==========================================================================
584:     PROTECTED PROCEDURE GarantirCheckBoxMarcacao()
585:         LOCAL loc_oColuna
586:         loc_oColuna = THIS.grd_4c_Dados.Column1
587: 
588:         IF !PEMSTATUS(loc_oColuna, "chk_4c_Check1", 5)
589:             loc_oColuna.AddObject("chk_4c_Check1", "CheckBox")
590: 
591:             WITH loc_oColuna.chk_4c_Check1
592:                 .Caption   = ""
593:                 .FontName  = "Tahoma"
594:                 .Alignment = 0
595:                 .AutoSize  = .F.
596:                 .Top       = 9
597:                 .Left      = 2
598:                 .Width     = 22
599:                 .Height    = 17
600:                 .ReadOnly  = .F.
601:                 .Visible   = .T.
602:             ENDWITH

*-- Linhas 617 a 627:
617:     * ConfigurarBotoes - Shape2 e os tres CommandButton do legado
618:     *
619:     * mapeamento.json: SIGOPLOC.Shape2       -> shp_4c_Shape2
620:     *                  SIGOPLOC.DesmarcarEmp -> cmd_4c_DesmarcarEmp
621:     *                  SIGOPLOC.MarcarEmp    -> cmd_4c_MarcarEmp
622:     *                  SIGOPLOC.btnSair      -> cmd_4c_BtnSair
623:     *
624:     * ORDEM DE CRIACAO = ordem da arvore do SCX (Shape2, DesmarcarEmp, MarcarEmp,
625:     * btnSair). O Shape2 cobre a area dos dois botoes de marcacao e, criado
626:     * depois deles, ficaria por cima bloqueando o clique sem desenhar nada
627:     * (BackStyle = 0 + BorderStyle = 0) - ver regra #30.

*-- Linhas 635 a 643:
635:     *          ForeColor 90,90,90, BackColor 255,255,255
636:     * O Caption da classe ("Peq." / "Grande") eh sobrescrito pelo do SCX.
637:     *
638:     * DESVIO MEDIDO E CONSCIENTE: cmd_4c_BtnSair fica em Left 723 com os 80 de
639:     * largura da classe fwbtng, ou seja termina em 803 contra os 800 de largura
640:     * do form - os 3 pixels finais sao RECORTADOS. O recorte eh HERDADO do SCX
641:     * (regra #28): encolher o botao para caber mudaria a tela que o usuario ve
642:     * hoje. O canonico de 75x75 da regra #10 nao se aplica aqui - ele eh do bloco
643:     * cnt_4c_Saida dos cadastros de 1000px, que neste form de 800px ficaria fora

*-- Linhas 655 a 699:
655:     *
656:     * Commandgroup3 do legado continua FORA do migrado, pelo criterio registrado
657:     * no cabecalho deste arquivo. Omiti-lo tambem evita um risco: o grupo ocupa
658:     * Left 698..788 / Top 7..117 e engole a area de cmd_4c_BtnSair (723..803 /
659:     * 3..103), de modo que recria-lo sem botao nenhum poria um container inerte
660:     * sobre o unico botao de saida da tela.
661:     *==========================================================================
662:     PROTECTED PROCEDURE ConfigurarBotoes()
663: 
664:         *-- Shape2 - moldura dos dois botoes de marcacao. BackStyle = 0 e
665:         *-- BorderStyle = 0 vem do dump: no legado ela nao pinta fundo nem borda.
666:         *-- "ZOrderSet = 3" nao eh transcrito - medido no VFP9: Shape nao tem essa
667:         *-- propriedade (PEMSTATUS = .F.), nem ForeColor (regra #33).
668:         THIS.AddObject("shp_4c_Shape2", "Shape")
669:         WITH THIS.shp_4c_Shape2
670:             .Top           = 170
671:             .Left          = 536
672:             .Width         = 50
673:             .Height        = 90
674:             .BackStyle     = 0
675:             .BorderStyle   = 0
676:             .FillStyle     = 1
677:             .SpecialEffect = 0
678:             .ColorScheme   = 1
679:             .Visible       = .T.
680:         ENDWITH
681: 
682:         *-- DesmarcarEmp (fwbtnp 40x40) - desliga Imps em todas as linhas
683:         THIS.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
684:         WITH THIS.cmd_4c_DesmarcarEmp
685:             .Top             = 215
686:             .Left            = 541
687:             .Width           = 40
688:             .Height          = 40
689:             .FontBold        = .T.
690:             .FontItalic      = .T.
691:             .FontName        = "Comic Sans MS"
692:             .FontSize        = 8
693:             .WordWrap        = .T.
694:             .Caption         = ""
695:             .Picture         = gc_4c_CaminhoIcones + "onebit_33.ico"
696:             .DisabledPicture = gc_4c_CaminhoIcones + "onebit_33.ico"
697:             .ToolTipText     = "Desmarca Todas as Linhas de Produto"
698:             .ForeColor       = RGB(90, 90, 90)
699:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 705 a 764:
705:         *-- Evento do botao, registrado JUNTO do AddObject: BINDEVENT estoura no
706:         *-- proprio bind quando o delegate nao existe, entao o par
707:         *-- AddObject + BINDEVENT fica sempre no mesmo lugar.
708:         BINDEVENT(THIS.cmd_4c_DesmarcarEmp, "Click", THIS, "CmdDesmarcarEmpClick")
709: 
710:         *-- MarcarEmp (fwbtnp 40x40) - liga Imps em todas as linhas
711:         THIS.AddObject("cmd_4c_MarcarEmp", "CommandButton")
712:         WITH THIS.cmd_4c_MarcarEmp
713:             .Top             = 175
714:             .Left            = 541
715:             .Width           = 40
716:             .Height          = 40
717:             .FontBold        = .T.
718:             .FontItalic      = .T.
719:             .FontName        = "Comic Sans MS"
720:             .FontSize        = 8
721:             .WordWrap        = .T.
722:             .Caption         = ""
723:             .Picture         = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
724:             .DisabledPicture = gc_4c_CaminhoIcones + "to-do-list_checked2.ico"
725:             .ToolTipText     = "Marca Todas as Linhas de Produto"
726:             .ForeColor       = RGB(90, 90, 90)
727:             .BackColor       = RGB(255, 255, 255)
728:             .MousePointer    = 15
729:             .Themes          = .T.
730:             .Visible         = .T.
731:         ENDWITH
732: 
733:         BINDEVENT(THIS.cmd_4c_MarcarEmp, "Click", THIS, "CmdMarcarEmpClick")
734: 
735:         *-- btnSair (fwbtng 80x100) - unica saida da tela. Cancel = .T. vem do
736:         *-- dump: a tecla ESC aciona o Click deste botao.
737:         THIS.AddObject("cmd_4c_BtnSair", "CommandButton")
738:         WITH THIS.cmd_4c_BtnSair
739:             .Top             = 3
740:             .Left            = 723
741:             .Width           = 80
742:             .Height          = 100
743:             .FontBold        = .T.
744:             .FontItalic      = .T.
745:             .FontName        = "Comic Sans MS"
746:             .FontSize        = 8
747:             .WordWrap        = .T.
748:             .Caption         = "Encerrar"
749:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
750:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
751:             .Cancel          = .T.
752:             .ForeColor       = RGB(90, 90, 90)
753:             .BackColor       = RGB(255, 255, 255)
754:             .MousePointer    = 15
755:             .Themes          = .T.
756:             .Visible         = .T.
757:         ENDWITH
758: 
759:         BINDEVENT(THIS.cmd_4c_BtnSair, "Click", THIS, "CmdBtnSairClick")
760: 
761:         RETURN .T.
762:     ENDPROC
763: 
764:     *==========================================================================

*-- Linhas 779 a 789:
779:     *==========================================================================
780:     PROTECTED PROCEDURE AjustarOrdemTabulacao()
781:         THIS.grd_4c_Dados.TabIndex        = 1
782:         THIS.cmd_4c_DesmarcarEmp.TabIndex = 2
783:         THIS.cmd_4c_MarcarEmp.TabIndex    = 3
784:         THIS.cmd_4c_BtnSair.TabIndex      = 4
785: 
786:         RETURN .T.
787:     ENDPROC
788: 
789:     *==========================================================================

*-- Linhas 808 a 816:
808:     * inteira: SELECT, bind, caixa de marcacao, larguras, GO TOP e Refresh.
809:     *
810:     * Ordem interna NAO eh arbitraria (toda ela medida - ver ConfigurarGrade e
811:     * GarantirCheckBoxMarcacao):
812:     *   1. RecordSource e os tres ControlSource - a Column1 passa a apontar para
813:     *      Imps (bit -> Logico);
814:     *   2. SO ENTAO o AddObject da caixa de marcacao, que estouraria com a
815:     *      Column1 ligada a uma coluna de texto;
816:     *   3. as larguras por ultimo, porque RecordSource as devolve ao default 90.

*-- Linhas 841 a 849:
841:                 loc_oGrade.Column2.ControlSource = loc_cCursor + ".Codigos"
842:                 loc_oGrade.Column3.ControlSource = loc_cCursor + ".Descrs"
843: 
844:                 THIS.GarantirCheckBoxMarcacao()
845:                 THIS.FormatarColunasGrade()
846: 
847:                 SELECT (loc_cCursor)
848:                 GO TOP
849:                 loc_oGrade.Refresh()


### BO (C:\4c\projeto\app\classes\SigOpLocBO.prg):
*====================================================================
* SigOpLocBO.prg
*
* Business Object para FormSigOpLoc (Selecao de Ocorrencias Para
* Impressao)
* Tabela: SigOpOco
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLocBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigOpOco)
    this_cCodigos = ""    && codigos char(10) - PK
    this_cDescrs  = ""    && descrs  char(30)
    this_cGrupos  = ""    && grupos  char(10)
    this_cContas  = ""    && contas  char(10)
    this_cDcontas = ""    && dcontas char(50)
    this_cOpers   = ""    && opers   char(2)
    this_nContabs = 0     && contabs numeric(1,0)
    this_lImps    = .F.   && imps    bit
    this_nNotas   = 0     && notas   numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpOco"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "SigOpLocBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega as propriedades desta entidade a
    * partir da linha CORRENTE do cursor par_cAliasCursor (tipicamente
    * crSigOpOco, montado pelo FORM PAI antes de abrir este dialogo de
    * selecao - o PROCEDURE Init do dump legado comeca com
    * "Select crSigOpOco", pressupondo o cursor ja aberto pelo chamador).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigos = TratarNulo(Codigos, "")
            THIS.this_cDescrs  = TratarNulo(Descrs, "")

            IF TYPE("Grupos") != "U"
                THIS.this_cGrupos = TratarNulo(Grupos, "")
            ENDIF

            IF TYPE("Contas") != "U"
                THIS.this_cContas = TratarNulo(Contas, "")
            ENDIF

            IF TYPE("Dcontas") != "U"
                THIS.this_cDcontas = TratarNulo(Dcontas, "")
            ENDIF

            IF TYPE("Opers") != "U"
                THIS.this_cOpers = TratarNulo(Opers, "")
            ENDIF

            IF TYPE("Contabs") != "U"
                THIS.this_nContabs = NVL(Contabs, 0)
            ENDIF

            IF TYPE("Imps") = "L"
                THIS.this_lImps = Imps
            ELSE
                IF VARTYPE(Imps) = "L"
                    THIS.this_lImps = Imps
                ELSE
                    THIS.this_lImps = (NVL(Imps, 0) = 1)
                ENDIF
            ENDIF

            IF TYPE("Notas") != "U"
                THIS.this_nNotas = NVL(Notas, 0)
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria da entidade (coluna Codigos)
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *====================================================================
    * MarcarTodos - Marca TODAS as linhas de crSigOpOco para impressao.
    * Equivalente ao PROCEDURE Click de MarcarEmp no legado:
    *   Select crSigOpOco
    *   Replace All Imps with .t.
    *   Go Top
    *   ThisForm.GridSels.Refresh
    * (o Refresh da grade fica a cargo do Form, apos chamar este metodo)
    *====================================================================
    PROCEDURE MarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .T.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DesmarcarTodos - Desmarca TODAS as linhas de crSigOpOco.
    * Equivalente ao PROCEDURE Click de DesmarcarEmp no legado.
    *====================================================================
    PROCEDURE DesmarcarTodos()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco")
            SELECT crSigOpOco
            REPLACE ALL Imps WITH .F.
            GO TOP
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * AlternarSelecao - Inverte o flag Imps da linha CORRENTE de
    * crSigOpOco. Equivalente ao PROCEDURE KeyPress (Enter/Espaco) e ao
    * PROCEDURE MouseDown do Check1 no legado:
    *   m.Imps = (!SigOpOco.Imps)
    *   Select crSigOpOco
    *   Gather Memvar Fields Imps
    *====================================================================
    PROCEDURE AlternarSelecao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED("crSigOpOco") AND !EOF("crSigOpOco")
            SELECT crSigOpOco
            REPLACE Imps WITH !Imps
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DECISAO DE PROJETO - BO somente-leitura, sem Inserir()/Atualizar()
    * gravando em SQL Server
    *
    * O dump do legado (tasks\task763\SigOpLoc_form_codigo_fonte.txt) nao
    * tem AddCursor nem TableUpdate em lugar nenhum. Os unicos
    * "Insert Into"/"Replace"/"Update" do form (PROCEDURE Init, Click de
    * MarcarEmp/DesmarcarEmp, KeyPress/MouseDown do Check1) tem como alvo
    * exclusivo o cursor LOCAL crSigOpOco, montado pelo FORM PAI antes de
    * abrir este dialogo de selecao. Por isso este BO NAO sobrescreve
    * Inserir() nem Atualizar() - o comportamento padrao herdado de
    * BusinessBase ja e o correto, e CarregarDoCursor() acima e a fonte
    * unica de leitura das colunas de SigOpOco quando uma linha precisa
    * ser inspecionada por codigo.
    *====================================================================

ENDDEFINE

