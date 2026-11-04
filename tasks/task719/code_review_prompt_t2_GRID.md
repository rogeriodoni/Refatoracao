# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 594: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 736: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg) - TRECHOS RELEVANTES PARA PASS GRID (2757 linhas total):

*-- Linhas 39 a 69:
39: * A Fase 4 acrescentou, dentro dessa casca:
40: *
41: *   ConfigurarBotoes      cmg_4c_Botoes (cntBotoes) - Confirmar/Cancelar
42: *   ConfigurarGradeCota   grd_4c_Cota (GrdCota) - cota da empresa, 3
43: *                         colunas somente-leitura, exibida so com acesso
44: *                         GERENTE (AcessoGradeCota)
45: *   ConfigurarGrade       grd_4c_Dados (Grade) - a grade principal de
46: *                         descontos, 4 colunas: checkbox de selecao /
47: *                         descricao / % desconto / valor desconto
48: *   CarregarLista         carga das DUAS grades, delegando ao BO
49: *                         (SigOpDesBO.CarregarCota e .CarregarDescontos,
50: *                         que reproduzem o pipeline de cursores do Init
51: *                         legado: crDesc, crTipo, localDes e crSigCdDes)
52: *   MontaGrade            funil UNICO de repintura (Go Top + Refresh),
53: *                         com VincularGrade/VincularGradeCota para o
54: *                         rebind quando o RecordSource se perde
55: *
56: * A Fase 5 entregou a primeira metade dos totais (Say2/lnValor e
57: * Say4/lnTDesc).
58: *
59: * ESCOPO DA FASE 6/8 - CAMPOS RESTANTES E CELULAS DIGITAVEIS
60: * ----------------------------------------------------------
61: *   ConfigurarTotais        completado com Say1/lnSaldo, o terceiro par
62: *                           de total (o unico que faltava do dump)
63: *   InstalarCelulasGrade    as tres celulas da grade principal passam a
64: *                           ser subclasses de TextBox com o When/Valid
65: *                           do legado EMBUTIDO (regra CLAUDE.md #46), em
66: *                           Column2/3/4 via CurrentControl
67: *   ValidarPercentualDesconto / ValidarValorDesconto
68: *                           os dois PROCEDURE Valid do legado
69: *                           (Grade.Column3.Text1 e Grade.Column4.Text1),

*-- Linhas 77 a 95:
77: * NAO HA LOOKUP NESTA TELA, e isso foi medido, nao presumido: o dump
78: * SigOpDes_form_codigo_fonte.txt nao casa nenhum dos padroes de busca do
79: * legado - zero "fwbusca" (que cobre fwBuscaExt/fwBuscaSel/fwBuscaInt),
80: * zero "mAddColuna", zero "sigacess(" e zero "Acesso<X>(". A tela recebe
81: * a lista de descontos elegiveis JA resolvida pelo pipeline de
82: * elegibilidade do BO; o usuario nao digita codigo de tabela nenhuma -
83: * ele marca linhas e edita percentual/valor. Criar aqui um
84: * AbrirLookup*/AbrirBusca* significaria consultar uma tabela que o
85: * legado nunca consulta (viola o PILAR 1 e a regra "NUNCA inventar
86: * tabelas de lookup").
87: *
88: * O que ESTA fase cobre no lugar do lookup e' o par When/Valid dos
89: * campos DIGITAVEIS, que e' a outra metade do contrato da fase: a grade
90: * tem duas celulas que aceitam digitacao (% Desconto e Valor Desconto) e
91: * uma que o legado bloqueia por When (Descricao).
92: *
93: * ESCOPO DA FASE 7/8 - EVENTOS PRINCIPAIS
94: * ----------------------------------------
95: *   BtnCancelarClick / BtnConfirmarClick

*-- Linhas 105 a 123:
105: *                           autorizacao de gerente/supervisor/diretoria via
106: *                           DO FORM SigOpSen (FAIL-CLOSED - ver
107: *                           feedback_sigopsen_ausente_gate_autorizacao)
108: *   Header1Click            Grade.Column1.Header1.Click - selecionar/
109: *                           desmarcar TODAS as linhas de uma vez
110: *
111: * Os tres acionam CalcularTotais (Fase 6/8).
112: *
113: * ESCOPO DA FASE 8/8 - CONSOLIDACAO FINAL
114: * ----------------------------------------
115: *   FormParaBO              FONTE UNICA tela -> BO: o contexto do
116: *                           movimento/item/produto (que o Init recebeu por
117: *                           parametro) e os TRES totais lidos dos TextBox.
118: *                           Chamado por InicializarForm, CalcularTotais e
119: *                           ConfirmarSelecaoExec - antes, essas atribuicoes
120: *                           estavam espalhadas pelos tres (e o contexto era
121: *                           reatribuido DENTRO do SCAN de gravacao, uma vez
122: *                           por linha).
123: *   BOParaForm              FONTE UNICA BO -> tela: os mesmos tres totais.

*-- Linhas 150 a 168:
150: *                        e o handler dele e' BtnConfirmarClick. Inventar um
151: *                        segundo botao "Salvar" violaria o PILAR 1.
152: *   BtnBuscarClick       nao ha lookup nem busca nesta tela (zero "fwbusca",
153: *                        zero "mAddColuna", zero "sigacess(" no dump - ver a
154: *                        nota da Fase 6 acima). A lista de descontos
155: *                        elegiveis chega JA resolvida pelo pipeline do BO.
156: *   BtnEncerrarClick     "Encerrar" e' o nome canonico do botao de saida de
157: *                        form CRUD (cnt_4c_Saida/cmd_4c_Encerrar, regra
158: *                        CLAUDE.md #10). Aqui o botao de saida e' o Cancelar
159: *                        do proprio dump, ja entregue como BtnCancelarClick -
160: *                        um BtnEncerrarClick seria um segundo nome para o
161: *                        MESMO e unico caminho de fechar a tela.
162: *   HabilitarCampos      nao ha modo de edicao a habilitar/desabilitar. O
163: *                        que o legado controla por campo ele controla no
164: *                        When de cada celula (Column2.Text1.When -> .f.,
165: *                        Column3/4.Text1.When -> "localdes.selecao=1",
166: *                        lnValor/lnTDesc/lnSaldo.When -> .F., GrdCota
167: *                        inteiro ReadOnly), e esses When estao EMBUTIDOS nas
168: *                        subclasses de celula (Fase 6) e nas propriedades

*-- Linhas 552 a 610:
552:     ENDPROC
553: 
554:     *==========================================================================
555:     * ConfigurarGradeCota - grd_4c_Cota (GrdCota do legado): cota de desconto
556:     * acumulada da empresa, visivel SOMENTE para acesso GERENTE (legado:
557:     * "THIS.grdCota.Visible=fChecaAcesso('SIGCDDES','GERENTE')" no Init).
558:     *
559:     * 3 colunas somente-leitura (ReadOnly = .T. no grid inteiro, igual ao
560:     * dump): Empresa / Cota / Utilizada. O dump fisicamente tem 3 objetos
561:     * Column (ColumnCount = 3), com os 2 ultimos renomeados (.Name =
562:     * "Column3"/"Column4") por terem sobrado de um ColumnCount = 4 original
563:     * (a 2a coluna, ValMeta, esta comentada no Init - "*!*This.GrdCota.
564:     * Column2.ControlSource = [crSigCdDes.valmeta]") - aqui os 3 Column
565:     * ficam na ordem natural 1/2/3 (PILAR 3 nao exige preservar o
566:     * artefato de rename).
567:     *
568:     * O cursor cursor_4c_Cota e' criado vazio AQUI porque Column.ControlSource
569:     * exige que o cursor JA exista: atribuir ControlSource de cursor
570:     * inexistente estoura "Alias is not found" dentro do TRY do
571:     * InicializarForm, o CREATEOBJECT devolve .F. e o usuario aciona a tela
572:     * e nada acontece, sem erro visivel. Quem popula de verdade e'
573:     * SigOpDesBO.CarregarCota, chamada por CarregarLista.
574:     *==========================================================================
575:     PROTECTED PROCEDURE ConfigurarGradeCota()
576:         LOCAL loc_oGrdCota
577: 
578:         *-- Estrutura inicial com a MESMA lista de colunas que
579:         *-- SigOpDesBO.CarregarCota recria: APPEND FROM casa as colunas por
580:         *-- NOME, e coluna faltando aqui sumiria da grade em silencio.
581:         IF !USED("cursor_4c_Cota")
582:             SET NULL ON
583:             CREATE CURSOR cursor_4c_Cota ;
584:                 (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
585:                  Codigo C(10), Valmeta N(11,2))
586:             SET NULL OFF
587:         ENDIF
588: 
589:         THIS.AddObject("grd_4c_Cota", "Grid")
590:         loc_oGrdCota = THIS.grd_4c_Cota
591: 
592:         WITH loc_oGrdCota
593:             .ColumnCount  = 3
594:             .RecordSource = "cursor_4c_Cota"
595:             .Top          = 85
596:             .Left         = 25
597:             .Width        = 413
598:             .Height       = 39
599:             .FontName     = "Verdana"
600:             .FontSize     = 8
601:             .HeaderHeight = 22
602:             .RowHeight    = 16
603:             .ScrollBars   = 2
604:             .ReadOnly     = .T.
605:             .RecordMark   = .F.
606:             .DeleteMark   = .F.
607:             .TabIndex     = 1
608:             .Visible      = THIS.AcessoGradeCota()
609:         ENDWITH
610: 

*-- Linhas 626 a 697:
626:             .BackColor   = RGB(255, 255, 255)
627:             .Visible     = .T.
628:         ENDWITH
629:         WITH loc_oGrdCota.Column1.Header1
630:             .FontName  = "Verdana"
631:             .FontSize  = 8
632:             .Alignment = 2
633:             .Caption   = "Empresa"
634:         ENDWITH
635: 
636:         *-- Column2: Cota (crSigCdDes.valcota)
637:         WITH loc_oGrdCota.Column2
638:             .ControlSource = "cursor_4c_Cota.ValCota"
639:             .Width         = 145
640:             .ReadOnly      = .T.
641:             .Visible       = .T.
642:         ENDWITH
643:         WITH loc_oGrdCota.Column2.Text1
644:             .BorderStyle = 0
645:             .Format      = "999,999,999.99"
646:             .InputMask   = ""
647:             .Margin      = 0
648:             .ReadOnly    = .T.
649:             .ForeColor   = RGB(0, 0, 0)
650:             .BackColor   = RGB(255, 255, 255)
651:         ENDWITH
652:         WITH loc_oGrdCota.Column2.Header1
653:             .FontName  = "Verdana"
654:             .FontSize  = 8
655:             .Alignment = 2
656:             .Caption   = "Cota"
657:         ENDWITH
658: 
659:         *-- Column3: Utilizada (crSigCdDes.Valdes)
660:         WITH loc_oGrdCota.Column3
661:             .ControlSource = "cursor_4c_Cota.Valdes"
662:             .Width         = 169
663:             .ReadOnly      = .T.
664:             .Visible       = .T.
665:         ENDWITH
666:         WITH loc_oGrdCota.Column3.Text1
667:             .BorderStyle = 0
668:             .Margin      = 0
669:             .ReadOnly    = .T.
670:             .ForeColor   = RGB(0, 0, 0)
671:             .BackColor   = RGB(255, 255, 255)
672:         ENDWITH
673:         WITH loc_oGrdCota.Column3.Header1
674:             .FontName  = "Verdana"
675:             .FontSize  = 8
676:             .Alignment = 2
677:             .Caption   = "Utilizada"
678:         ENDWITH
679:     ENDPROC
680: 
681:     *==========================================================================
682:     * ConfigurarGrade - grd_4c_Dados (Grade do legado): grade principal de
683:     * tipos de desconto elegiveis (localDes no legado) - 4 colunas:
684:     * checkbox de selecao / descricao / % desconto / valor desconto.
685:     *
686:     * Column1 e' checkbox puro (regra CLAUDE.md #18 - Column.AddObject NAO
687:     * basta, precisa de CurrentControl + Sparse = .F.; regra "CheckBox
688:     * .Value SEMPRE NUMERICO" - Selecao e' NUMERIC(1,0) no legado, nao
689:     * logico). Geometria/InputMask/Format de cada coluna TRANSCRITOS do
690:     * dump (SIGOPDES.Grade.ColumnN) - regra CLAUDE.md #49 (Format/InputMask
691:     * nunca descartados).
692:     *
693:     * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
694:     * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
695:     * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
696:     * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
697:     * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de

*-- Linhas 705 a 752:
705:     * e' quem desenha e edita a celula a partir do CurrentControl.
706:     *
707:     * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
708:     * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
709:     * (Fase 7/8) ficam no fim do metodo.
710:     *==========================================================================
711:     PROTECTED PROCEDURE ConfigurarGrade()
712:         LOCAL loc_oGrade
713: 
714:         *-- Estrutura inicial com a MESMA lista de colunas que
715:         *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
716:         *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
717:         *-- tambem mantem em localDes e que os fluxos de validacao e de
718:         *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
719:         *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
720:         *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
721:         *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
722:         IF !USED("cursor_4c_Dados")
723:             SET NULL ON
724:             CREATE CURSOR cursor_4c_Dados ;
725:                 (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
726:                  Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
727:                  Descosmax N(7,4), Usuars C(10))
728:             SET NULL OFF
729:         ENDIF
730: 
731:         THIS.AddObject("grd_4c_Dados", "Grid")
732:         loc_oGrade = THIS.grd_4c_Dados
733: 
734:         WITH loc_oGrade
735:             .ColumnCount  = 4
736:             .RecordSource = "cursor_4c_Dados"
737:             .Top          = 131
738:             .Left         = 24
739:             .Width        = 748
740:             .Height       = 169
741:             .FontName     = "Verdana"
742:             .FontSize     = 8
743:             .HeaderHeight = 22
744:             .RowHeight    = 16
745:             .ScrollBars   = 2
746:             .ReadOnly     = .F.
747:             .RecordMark   = .F.
748:             .DeleteMark   = .F.
749:             .TabIndex     = 1
750:             .Visible      = .T.
751:         ENDWITH
752: 

*-- Linhas 781 a 857:
781:         ENDWITH
782:         loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
783: 
784:         WITH loc_oGrade.Column1.Header1
785:             .FontName  = "Verdana"
786:             .FontSize  = 8
787:             .Alignment = 2
788:             .Caption   = ""
789:             .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
790:         ENDWITH
791: 
792:         *-- BINDEVENT do checkbox de selecao (Fase 7/8) - regra CLAUDE.md
793:         *-- "CheckBox em coluna de Grid": o toggle nativo NAO e' confiavel
794:         *-- dentro de Column, entao Click/MouseDown so suprimem (NODEFAULT) e
795:         *-- MouseUp/KeyPress(Enter/Espaco) e' quem de fato alterna, via
796:         *-- ChkSelecaoToggle - que tambem carrega a logica de autorizacao do
797:         *-- legado (SigOpSen). BINDEVENT do Header1.Click (selecionar/
798:         *-- desmarcar tudo) fica aqui tambem, por serem da mesma coluna.
799:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "Click",     THIS, "ChkSelecaoClick")
800:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseDown", THIS, "ChkSelecaoMouseDown")
801:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseUp",   THIS, "ChkSelecaoMouseUp")
802:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "KeyPress",  THIS, "ChkSelecaoKeyPress")
803:         BINDEVENT(loc_oGrade.Column1.Header1,        "Click",     THIS, "Header1Click")
804: 
805:         *-- Column2: descricao do tipo de desconto (localDes.Descrs)
806:         WITH loc_oGrade.Column2
807:             .ControlSource = "cursor_4c_Dados.Descrs"
808:             .Width         = 500
809:             .Movable       = .F.
810:             .Resizable     = .F.
811:             .ReadOnly      = .F.
812:             .Visible       = .T.
813:         ENDWITH
814:         WITH loc_oGrade.Column2.Header1
815:             .FontName  = "Verdana"
816:             .FontSize  = 8
817:             .Alignment = 2
818:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
819:         ENDWITH
820: 
821:         *-- Column3: percentual de desconto (localDes.Descos)
822:         WITH loc_oGrade.Column3
823:             .ControlSource = "cursor_4c_Dados.Descos"
824:             .Width         = 88
825:             .ReadOnly      = .F.
826:             .Visible       = .T.
827:         ENDWITH
828:         WITH loc_oGrade.Column3.Header1
829:             .FontName  = "Verdana"
830:             .FontSize  = 8
831:             .Alignment = 2
832:             .Caption   = "% Desconto"
833:         ENDWITH
834: 
835:         *-- Column4: valor do desconto (localDes.Valdes)
836:         WITH loc_oGrade.Column4
837:             .ControlSource = "cursor_4c_Dados.Valdes"
838:             .Width         = 110
839:             .ReadOnly      = .F.
840:             .Visible       = .T.
841:         ENDWITH
842:         WITH loc_oGrade.Column4.Header1
843:             .FontName  = "Verdana"
844:             .FontSize  = 8
845:             .Alignment = 2
846:             .Caption   = "Valor Desconto"
847:         ENDWITH
848: 
849:         *-- Celulas digitaveis / bloqueadas das colunas 2, 3 e 4. Fica por
850:         *-- ULTIMO porque Column.ReadOnly tem de ser definido DEPOIS de
851:         *-- Grid.ReadOnly (o do grid propaga para as colunas e sobrescreve
852:         *-- o delas - regra CLAUDE.md #46).
853:         THIS.InstalarCelulasGrade(loc_oGrade)
854:     ENDPROC
855: 
856:     *==========================================================================
857:     * ConfigurarTotais - os TRES pares de total, filhos diretos do form:

*-- Linhas 870 a 888:
870:     * Return(.F.) do legado) e Label nao entra na tabulacao, logo o
871:     * TabIndex deles e' inerte - e atribuir TabIndex em runtime RENUMERA
872:     * os demais controles do form, o que mexeria na ordem de tabulacao
873:     * real (cmg_4c_Botoes = 2, grd_4c_Dados = 1) sem nenhum ganho.
874:     *
875:     * Os tres campos (lnValor/lnTDesc/lnSaldo) tem PROCEDURE When
876:     * Return(.F.) no legado - nunca recebem foco, sao so EXIBICAO. Aqui
877:     * isso vira ReadOnly = .T. + TabStop = .F. (equivalente: a celula nunca
878:     * entra em edicao e o Tab pula o controle), sem precisar de evento.
879:     *
880:     * Geometria/InputMask TRANSCRITOS do dump (SIGOPDES.Say2/lnValor/Say4/
881:     * lnTDesc) - regra CLAUDE.md #49 (Format/InputMask nunca descartados).
882:     * ForeColor dos labels e' RGB(90,90,90), EXPLICITO no dump (nao e' o
883:     * caso de "classe say sem ForeColor" da regra CLAUDE.md #12).
884:     *
885:     * lnValor.Value nasce de THIS.this_oBusinessObject.this_nValor - esse
886:     * valor ja foi igualado a this_nUnitOrigs em InicializarForm, que e'
887:     * exatamente o que o Init legado faz ("this.lnValor.value =
888:     * crTpmMvItn.unitorigs"). lnTDesc.Value nasce 0: o legado so o

*-- Linhas 1072 a 1090:
1072:     ENDPROC
1073: 
1074:     *==========================================================================
1075:     * AcessoGradeCota - responde se a grade de cota (grd_4c_Cota) deve
1076:     * aparecer. Legado: "THIS.grdCota.Visible = fChecaAcesso('SIGCDDES',
1077:     * 'GERENTE')" - so o acesso GERENTE ve a cota da empresa.
1078:     *
1079:     * A chamada de 2 argumentos e' a do legado e esta FIEL: os 3
1080:     * parametros restantes de fChecaAcesso tem fallback proprio dentro da
1081:     * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
1082:     *
1083:     * O guard de modo existe porque fChecaAcesso abre conexao propria
1084:     * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
1085:     * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
1086:     * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
1087:     * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
1088:     * cota nao teria o que mostrar de qualquer forma.
1089:     *==========================================================================
1090:     PROTECTED FUNCTION AcessoGradeCota()

*-- Linhas 1106 a 1129:
1106:     *
1107:     * Legado: o Init monta crDesc/crTipo/localDes e crSigCdDes e termina
1108:     * ligando cada grade ao seu cursor
1109:     * ("This.Grade.RecordSource = [localDes]" e
1110:     *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
1111:     * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
1112:     * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
1113:     * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
1114:     * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
1115:     *
1116:     * PUBLIC de proposito: o harness de teste automatizado chama
1117:     * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
1118:     * para metodo PROTECTED e a chamada real falharia em runtime).
1119:     *
1120:     * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
1121:     *==========================================================================
1122:     PROCEDURE CarregarLista()
1123:         LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro
1124: 
1125:         loc_lSucesso = .F.
1126: 
1127:         TRY
1128:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1129:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;

*-- Linhas 1180 a 1341:
1180:     * Por isso a repintura mora aqui e e' chamada por TODO caminho que
1181:     * popula os cursores.
1182:     *
1183:     * ColumnCount NAO e' reatribuido: qualquer atribuicao a ColumnCount
1184:     * recria os objetos Column e DESTRUIRIA o CheckBox posto por
1185:     * AddObject em Column1 (com ele, a coluna de selecao da grade).
1186:     *
1187:     * O rebind completo (RecordSource -> ControlSource -> Width ->
1188:     * Header1.Caption -> CurrentControl/Sparse) so roda quando o
1189:     * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
1190:     * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
1191:     * seria apagar o que ConfigurarGrade acabou de montar. Na carga
1192:     * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
1193:     * Refresh.
1194:     *==========================================================================
1195:     PROCEDURE MontaGrade()
1196:         LOCAL loc_oGrade, loc_oGrdCota, loc_oErro
1197: 
1198:         TRY
1199:             *-- Grade principal de descontos
1200:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1201:                 loc_oGrade = THIS.grd_4c_Dados
1202: 
1203:                 IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
1204:                     THIS.VincularGrade()
1205:                 ENDIF
1206: 
1207:                 SELECT cursor_4c_Dados
1208:                 GO TOP
1209:                 loc_oGrade.Refresh()
1210:             ENDIF
1211: 
1212:             *-- Grade da cota da empresa
1213:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
1214:                 loc_oGrdCota = THIS.grd_4c_Cota
1215: 
1216:                 IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
1217:                     THIS.VincularGradeCota()
1218:                 ENDIF
1219: 
1220:                 SELECT cursor_4c_Cota
1221:                 GO TOP
1222:                 loc_oGrdCota.Refresh()
1223:             ENDIF
1224: 
1225:             *-- Volta o alias corrente para a grade principal, que e' a
1226:             *-- que recebe o foco e de onde os eventos de celula leem.
1227:             IF USED("cursor_4c_Dados")
1228:                 SELECT cursor_4c_Dados
1229:             ENDIF
1230:         CATCH TO loc_oErro
1231:             MsgErro(loc_oErro.Message + CHR(13) + ;
1232:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1233:                     "Procedure: " + loc_oErro.Procedure, ;
1234:                     "Erro em MontaGrade")
1235:         ENDTRY
1236:     ENDPROC
1237: 
1238:     *==========================================================================
1239:     * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
1240:     * que a atribuicao de RecordSource reseta.
1241:     *
1242:     * Atribuir RecordSource devolve Column.Width ao default 90, limpa
1243:     * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
1244:     * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
1245:     * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
1246:     * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
1247:     * dump em ConfigurarGrade.
1248:     *
1249:     * ColumnCount fica de fora: reatribui-lo recriaria os Column e
1250:     * destruiria o CheckBox de Column1.
1251:     *==========================================================================
1252:     PROTECTED PROCEDURE VincularGrade()
1253:         LOCAL loc_oGrade
1254: 
1255:         loc_oGrade = THIS.grd_4c_Dados
1256: 
1257:         *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
1258:         *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
1259:         *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
1260:         *-- unico jeito de marcar a linha. Por isso, aqui:
1261:         *-- NAO reatribuir ColumnCount.
1262:         loc_oGrade.RecordSource = "cursor_4c_Dados"
1263: 
1264:         loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
1265:         loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1266:         loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
1267:         loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"
1268: 
1269:         loc_oGrade.Column1.Width = 23
1270:         loc_oGrade.Column2.Width = 500
1271:         loc_oGrade.Column3.Width = 88
1272:         loc_oGrade.Column4.Width = 110
1273: 
1274:         loc_oGrade.Column1.Header1.Caption = ""
1275:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
1276:                                              "o do Desconto"
1277:         loc_oGrade.Column3.Header1.Caption = "% Desconto"
1278:         loc_oGrade.Column4.Header1.Caption = "Valor Desconto"
1279: 
1280:         *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
1281:         *-- CheckBox de selecao, apesar de existir, nao aparece; sem
1282:         *-- Sparse = .F. ele apareceria so na linha ativa.
1283:         IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
1284:             loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
1285:         ENDIF
1286:         loc_oGrade.Column1.Sparse = .F.
1287: 
1288:         *-- As celulas de Column2/3/4 tambem se perdem no rebind
1289:         *-- (RecordSource derruba CurrentControl), e sem elas a coluna de
1290:         *-- descricao voltaria a aceitar digitacao e as duas colunas
1291:         *-- editaveis perderiam o When/Valid do legado. InstalarCelulasGrade
1292:         *-- e' idempotente: so chama AddObject quando o objeto nao existe.
1293:         THIS.InstalarCelulasGrade(loc_oGrade)
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
1298:     * que a atribuicao de RecordSource reseta (mesma regra de ordem de
1299:     * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
1300:     * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
1301:     * natural, com as larguras e captions do dump.
1302:     *
1303:     * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
1304:     * as colunas e sobrescreveria o das colunas.
1305:     *==========================================================================
1306:     PROTECTED PROCEDURE VincularGradeCota()
1307:         LOCAL loc_oGrdCota
1308: 
1309:         loc_oGrdCota = THIS.grd_4c_Cota
1310: 
1311:         *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
1312:         *-- larguras do dump sao montadas por ConfigurarGradeCota, e
1313:         *-- reatribuir ColumnCount as recriaria do zero.
1314:         loc_oGrdCota.RecordSource = "cursor_4c_Cota"
1315: 
1316:         loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
1317:         loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
1318:         loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"
1319: 
1320:         loc_oGrdCota.Column1.Width = 75
1321:         loc_oGrdCota.Column2.Width = 145
1322:         loc_oGrdCota.Column3.Width = 169
1323: 
1324:         loc_oGrdCota.Column1.Header1.Caption = "Empresa"
1325:         loc_oGrdCota.Column2.Header1.Caption = "Cota"
1326:         loc_oGrdCota.Column3.Header1.Caption = "Utilizada"
1327: 
1328:         loc_oGrdCota.ReadOnly         = .T.
1329:         loc_oGrdCota.Column1.ReadOnly = .T.
1330:         loc_oGrdCota.Column2.ReadOnly = .T.
1331:         loc_oGrdCota.Column3.ReadOnly = .T.
1332:     ENDPROC
1333: 
1334:     *==========================================================================
1335:     * InstalarCelulasGrade - poe em Column2/3/4 da grade principal a
1336:     * SUBCLASSE de TextBox que carrega o When/Valid daquela celula no
1337:     * legado, e liga cada uma por CurrentControl.
1338:     *
1339:     * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao
1340:     * de celula de grade mora no Valid do TextBox da coluna, e BINDEVENT
1341:     * em "Valid" de TextBox de Column nao e' confiavel - alem disso o

*-- Linhas 1363 a 1381:
1363:     * IDEMPOTENTE de proposito: AddObject duas vezes com o mesmo nome no
1364:     * mesmo alvo estoura "Object is already defined" e derrubaria o Init.
1365:     * VincularGrade chama este metodo depois de cada rebind, porque
1366:     * atribuir RecordSource derruba CurrentControl.
1367:     *==========================================================================
1368:     PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
1369:         IF VARTYPE(par_oGrade) != "O"
1370:             RETURN
1371:         ENDIF
1372: 
1373:         *-- Column2: descricao do tipo de desconto. O legado NAO usa
1374:         *-- ReadOnly aqui (o dump declara Column2.ReadOnly = .F.) - quem
1375:         *-- bloqueia a digitacao e' o "When / Return .f." do Text1, e e'
1376:         *-- esse o mecanismo reproduzido. Transcrever so o ReadOnly = .F.
1377:         *-- do dump e parar ai deixaria a descricao do desconto EDITAVEL.
1378:         IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelDescricao", 5)
1379:             par_oGrade.Column2.AddObject("txt_4c_CelDescricao", ;
1380:                                           "TextBoxCelDescricaoSigOpDes_4c")
1381:         ENDIF

*-- Linhas 1542 a 1560:
1542:     * deixaria de ser a linha corrente no meio do proprio Valid.
1543:     *
1544:     * PUBLIC: os eventos da Fase 7/8 (Click do checkbox de cada linha,
1545:     * Header1.Click de selecionar-tudo) acionam este metodo de fora.
1546:     *==========================================================================
1547:     PROCEDURE CalcularTotais()
1548:         LOCAL loc_nReg, loc_nSaldo, loc_nTDesc, loc_nTDescI, loc_nTDescM
1549:         LOCAL loc_nValor, loc_nBaseCota, loc_oErro
1550: 
1551:         TRY
1552:             IF !USED("cursor_4c_Dados")
1553:                 MsgErro("Cursor de descontos indispon" + CHR(237) + "vel " + ;
1554:                         "para calcular os totais.", "Erro em CalcularTotais")
1555:             ELSE
1556:                 loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
1557: 
1558:                 SELECT cursor_4c_Dados
1559: 
1560:                 *-- Linha corrente: desmarcada zera os dois campos, marcada

*-- Linhas 1788 a 1854:
1788:     ENDPROC
1789: 
1790:     *==========================================================================
1791:     * Header1Click - SIGOPDES.Grade.Column1.Header1.Click (selecionar/
1792:     * desmarcar TODAS as linhas da grade principal).
1793:     *
1794:     * Legado:
1795:     *
1796:     *   If (This.parent.Header1.Tag = [X])
1797:     *       This.parent.Header1.Tag = [ ]
1798:     *       Update localDes Set Selecao = 0
1799:     *   Else
1800:     *       This.parent.Header1.Tag = [X]
1801:     *       Update localDes Set Selecao = 1
1802:     *   EndIf
1803:     *   ThisForm.Grade.Refresh
1804:     *
1805:     * This.parent.Header1 e' o proprio Header1 (This.parent = Column1) - o
1806:     * Tag dele guarda o estado do toggle entre um clique e outro, igual ao
1807:     * que fica aqui em loc_oHeader.Tag (propriedade nativa, generica, de
1808:     * qualquer objeto VFP).
1809:     *
1810:     * NAO chama CalcularTotais - e' FIEL ao legado, que tambem so faz o
1811:     * Update + Refresh aqui. "Selecionar tudo" marca Selecao em TODAS as
1812:     * linhas sem passar pela autorizacao (SigOpSen) que o Click do checkbox
1813:     * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
1814:     * desta migracao.
1815:     *
1816:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1817:     *==========================================================================
1818:     PROCEDURE Header1Click()
1819:         LOCAL loc_oHeader, loc_oErro
1820: 
1821:         TRY
1822:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1823:                 loc_oHeader = THIS.grd_4c_Dados.Column1.Header1
1824: 
1825:                 IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
1826:                     loc_oHeader.Tag = ""
1827:                     UPDATE cursor_4c_Dados SET Selecao = 0
1828:                 ELSE
1829:                     loc_oHeader.Tag = "X"
1830:                     UPDATE cursor_4c_Dados SET Selecao = 1
1831:                 ENDIF
1832: 
1833:                 THIS.grd_4c_Dados.Refresh()
1834:             ENDIF
1835:         CATCH TO loc_oErro
1836:             MsgErro(loc_oErro.Message + CHR(13) + ;
1837:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1838:                     "Procedure: " + loc_oErro.Procedure, ;
1839:                     "Erro em Header1Click")
1840:         ENDTRY
1841:     ENDPROC
1842: 
1843:     *==========================================================================
1844:     * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
1845:     * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de
1846:     * Column1 (fwcheckbox1 do legado).
1847:     *
1848:     * Regra CLAUDE.md "CheckBox em coluna de Grid": o toggle nativo NAO e'
1849:     * confiavel dentro de Column (Column.AddObject + CurrentControl +
1850:     * Sparse = .F.), entao Click/MouseDown so suprimem (NODEFAULT) e
1851:     * MouseUp/KeyPress(Enter=13/Espaco=32) sao quem de fato aciona o
1852:     * ChkSelecaoToggle - equivalente ao "clicar no checkbox" do legado, cujo
1853:     * Click comeca com "=DoDefault()" (toggle nativo) e so DEPOIS reage ao
1854:     * this.Value resultante.

*-- Linhas 2006 a 2024:
2006:                 ENDIF
2007: 
2008:                 REPLACE Selecao WITH 0 IN cursor_4c_Dados
2009:                 THIS.grd_4c_Dados.Refresh()
2010:             ELSE
2011:                 REPLACE Usuars WITH SUBSTR(loc_cRetorno, 2) IN cursor_4c_Dados
2012:             ENDIF
2013:         ENDIF
2014: 
2015:         THIS.CalcularTotais()
2016:     ENDPROC
2017: 
2018:     *==========================================================================
2019:     * ValidarPercentualDesconto - o PROCEDURE Valid de
2020:     * SIGOPDES.Grade.Column3.Text1 (celula "% Desconto").
2021:     *
2022:     * Chamado pelo Valid da subclasse txt_4c_CelPercentual, que e' o
2023:     * CurrentControl da coluna. O retorno E' o mecanismo: .F. mantem o
2024:     * cursor na celula e recusa a saida; .T. libera.

*-- Linhas 2501 a 2572:
2501:     * Legado:
2502:     *
2503:     *   RELEASE pcChv, pcEDN, pcItem
2504:     *   This.Grade.RecordSource          = []
2505:     *   This.Grade.Column1.ControlSource = []
2506:     *   This.Grade.Column2.ControlSource = []
2507:     *   This.Grade.Column3.ControlSource = []
2508:     *   This.Grade.Column4.ControlSource = []
2509:     *   Use In localDes
2510:     *
2511:     * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
2512:     * contexto que elas carregavam entre o Init e os eventos vive em
2513:     * properties this_* do form e do BO, que morrem com os objetos - nao ha
2514:     * o que soltar do espaco global.
2515:     *
2516:     * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
2517:     * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
2518:     * deixa o Grid apontando para alias morto, e qualquer repintura posterior
2519:     * (o VFP repinta durante a propria destruicao da tela) acha alias
2520:     * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
2521:     * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
2522:     * grades sao nossas e os dois cursores tambem.
2523:     *
2524:     * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
2525:     * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
2526:     * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
2527:     * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
2528:     * buffer sujo.
2529:     *
2530:     * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
2531:     * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
2532:     * cadeia de heranca o menu do sistema aparece encolhido depois que este
2533:     * dialogo fecha.
2534:     *
2535:     * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
2536:     * destruicao por falha de limpeza deixaria o form pendurado.
2537:     *==========================================================================
2538:     PROCEDURE Destroy()
2539:         LOCAL loc_oErro
2540: 
2541:         TRY
2542:             *-- Solta a grade principal do cursor (legado: Grade.RecordSource
2543:             *-- e os quatro Column.ControlSource)
2544:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2545:                 WITH THIS.grd_4c_Dados
2546:                     .RecordSource          = ""
2547:                     .Column1.ControlSource = ""
2548:                     .Column2.ControlSource = ""
2549:                     .Column3.ControlSource = ""
2550:                     .Column4.ControlSource = ""
2551:                 ENDWITH
2552:             ENDIF
2553: 
2554:             *-- Solta a grade da cota (GrdCota, 3 colunas)
2555:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
2556:                 WITH THIS.grd_4c_Cota
2557:                     .RecordSource          = ""
2558:                     .Column1.ControlSource = ""
2559:                     .Column2.ControlSource = ""
2560:                     .Column3.ControlSource = ""
2561:                 ENDWITH
2562:             ENDIF
2563: 
2564:             *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
2565:             IF USED("cursor_4c_Dados")
2566:                 USE IN cursor_4c_Dados
2567:             ENDIF
2568: 
2569:             IF USED("cursor_4c_Cota")
2570:                 USE IN cursor_4c_Cota
2571:             ENDIF
2572:         CATCH TO loc_oErro

*-- Linhas 2586 a 2623:
2586:     * hoje - mantido pelo mesmo motivo do padrao canonico FormCor/FormCargo:
2587:     * um PageFrame acrescentado depois ja seria coberto.
2588:     *
2589:     * grd_4c_Cota e' EXCECAO: a visibilidade dele e' decidida pelo acesso
2590:     * GERENTE (ver AcessoGradeCota) e forcar Visible = .T. aqui exporia a
2591:     * cota de desconto da empresa para QUALQUER usuario, apagando em
2592:     * silencio a regra que o legado aplica. A recursao entra no objeto de
2593:     * qualquer forma, para os filhos dele nascerem visiveis quando o
2594:     * container voltar a ser exibido.
2595:     *==========================================================================
2596:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2597:         LOCAL loc_nI, loc_oObjeto, loc_nP
2598: 
2599:         IF VARTYPE(par_oContainer) != "O"
2600:             RETURN
2601:         ENDIF
2602: 
2603:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2604:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2605: 
2606:             IF VARTYPE(loc_oObjeto) = "O"
2607:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
2608:                    UPPER(loc_oObjeto.Name) != "GRD_4C_COTA"
2609:                     loc_oObjeto.Visible = .T.
2610:                 ENDIF
2611: 
2612:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2613:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2614:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2615:                     ENDFOR
2616:                 ENDIF
2617: 
2618:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2619:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2620:                 ENDIF
2621:             ENDIF
2622:         ENDFOR
2623:     ENDPROC

