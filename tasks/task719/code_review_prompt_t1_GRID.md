# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 592: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 732: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpDes.prg) - TRECHOS RELEVANTES PARA PASS GRID (2753 linhas total):

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

*-- Linhas 552 a 608:
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
582:             CREATE CURSOR cursor_4c_Cota ;
583:                 (Emps C(3), Valcota N(11,2), Valdes N(11,2), ;
584:                  Codigo C(10), Valmeta N(11,2))
585:         ENDIF
586: 
587:         THIS.AddObject("grd_4c_Cota", "Grid")
588:         loc_oGrdCota = THIS.grd_4c_Cota
589: 
590:         WITH loc_oGrdCota
591:             .ColumnCount  = 3
592:             .RecordSource = "cursor_4c_Cota"
593:             .Top          = 85
594:             .Left         = 25
595:             .Width        = 413
596:             .Height       = 39
597:             .FontName     = "Verdana"
598:             .FontSize     = 8
599:             .HeaderHeight = 22
600:             .RowHeight    = 16
601:             .ScrollBars   = 2
602:             .ReadOnly     = .T.
603:             .RecordMark   = .F.
604:             .DeleteMark   = .F.
605:             .TabIndex     = 1
606:             .Visible      = THIS.AcessoGradeCota()
607:         ENDWITH
608: 

*-- Linhas 624 a 695:
624:             .BackColor   = RGB(255, 255, 255)
625:             .Visible     = .T.
626:         ENDWITH
627:         WITH loc_oGrdCota.Column1.Header1
628:             .FontName  = "Verdana"
629:             .FontSize  = 8
630:             .Alignment = 2
631:             .Caption   = "Empresa"
632:         ENDWITH
633: 
634:         *-- Column2: Cota (crSigCdDes.valcota)
635:         WITH loc_oGrdCota.Column2
636:             .ControlSource = "cursor_4c_Cota.ValCota"
637:             .Width         = 145
638:             .ReadOnly      = .T.
639:             .Visible       = .T.
640:         ENDWITH
641:         WITH loc_oGrdCota.Column2.Text1
642:             .BorderStyle = 0
643:             .Format      = "999,999,999.99"
644:             .InputMask   = ""
645:             .Margin      = 0
646:             .ReadOnly    = .T.
647:             .ForeColor   = RGB(0, 0, 0)
648:             .BackColor   = RGB(255, 255, 255)
649:         ENDWITH
650:         WITH loc_oGrdCota.Column2.Header1
651:             .FontName  = "Verdana"
652:             .FontSize  = 8
653:             .Alignment = 2
654:             .Caption   = "Cota"
655:         ENDWITH
656: 
657:         *-- Column3: Utilizada (crSigCdDes.Valdes)
658:         WITH loc_oGrdCota.Column3
659:             .ControlSource = "cursor_4c_Cota.Valdes"
660:             .Width         = 169
661:             .ReadOnly      = .T.
662:             .Visible       = .T.
663:         ENDWITH
664:         WITH loc_oGrdCota.Column3.Text1
665:             .BorderStyle = 0
666:             .Margin      = 0
667:             .ReadOnly    = .T.
668:             .ForeColor   = RGB(0, 0, 0)
669:             .BackColor   = RGB(255, 255, 255)
670:         ENDWITH
671:         WITH loc_oGrdCota.Column3.Header1
672:             .FontName  = "Verdana"
673:             .FontSize  = 8
674:             .Alignment = 2
675:             .Caption   = "Utilizada"
676:         ENDWITH
677:     ENDPROC
678: 
679:     *==========================================================================
680:     * ConfigurarGrade - grd_4c_Dados (Grade do legado): grade principal de
681:     * tipos de desconto elegiveis (localDes no legado) - 4 colunas:
682:     * checkbox de selecao / descricao / % desconto / valor desconto.
683:     *
684:     * Column1 e' checkbox puro (regra CLAUDE.md #18 - Column.AddObject NAO
685:     * basta, precisa de CurrentControl + Sparse = .F.; regra "CheckBox
686:     * .Value SEMPRE NUMERICO" - Selecao e' NUMERIC(1,0) no legado, nao
687:     * logico). Geometria/InputMask/Format de cada coluna TRANSCRITOS do
688:     * dump (SIGOPDES.Grade.ColumnN) - regra CLAUDE.md #49 (Format/InputMask
689:     * nunca descartados).
690:     *
691:     * O cursor cursor_4c_Dados nasce vazio AQUI com os MESMOS campos que
692:     * SigOpDesBO.CarregarDescontos recria - placeholder e cursor real tem
693:     * de ter estrutura IDENTICA, porque o APPEND FROM da recarga casa as
694:     * colunas por NOME e coluna ausente de um dos lados nao viaja, sem
695:     * erro nenhum. Descos N(7,4) e Valdes N(9,2) acompanham as colunas de

*-- Linhas 703 a 748:
703:     * e' quem desenha e edita a celula a partir do CurrentControl.
704:     *
705:     * O BINDEVENT do fwcheckbox1.Click (autorizacao de gerente/supervisor/
706:     * diretoria via SigOpSen) e o do Header1.Click de selecionar-tudo
707:     * (Fase 7/8) ficam no fim do metodo.
708:     *==========================================================================
709:     PROTECTED PROCEDURE ConfigurarGrade()
710:         LOCAL loc_oGrade
711: 
712:         *-- Estrutura inicial com a MESMA lista de colunas que
713:         *-- SigOpDesBO.CarregarDescontos recria (APPEND FROM casa por NOME).
714:         *-- Alem das 4 colunas exibidas, o cursor carrega as 4 que o legado
715:         *-- tambem mantem em localDes e que os fluxos de validacao e de
716:         *-- gravacao consomem: Codigos (SigOpTdz.codigos, que vai para
717:         *-- SigMvItd.cdesc), Tpdesc (regra de autorizacao por tipo),
718:         *-- Descosmax (teto que o Valid da coluna "% Desconto" cobra) e
719:         *-- Usuars (quem autorizou, gravado em SigMvItd.usuars).
720:         IF !USED("cursor_4c_Dados")
721:             CREATE CURSOR cursor_4c_Dados ;
722:                 (Selecao N(1,0), Descrs C(30), Descos N(7,4), ;
723:                  Valdes N(9,2), Codigos C(10), Tpdesc N(2,0), ;
724:                  Descosmax N(7,4), Usuars C(10))
725:         ENDIF
726: 
727:         THIS.AddObject("grd_4c_Dados", "Grid")
728:         loc_oGrade = THIS.grd_4c_Dados
729: 
730:         WITH loc_oGrade
731:             .ColumnCount  = 4
732:             .RecordSource = "cursor_4c_Dados"
733:             .Top          = 131
734:             .Left         = 24
735:             .Width        = 748
736:             .Height       = 169
737:             .FontName     = "Verdana"
738:             .FontSize     = 8
739:             .HeaderHeight = 22
740:             .RowHeight    = 16
741:             .ScrollBars   = 2
742:             .ReadOnly     = .F.
743:             .RecordMark   = .F.
744:             .DeleteMark   = .F.
745:             .TabIndex     = 1
746:             .Visible      = .T.
747:         ENDWITH
748: 

*-- Linhas 777 a 853:
777:         ENDWITH
778:         loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
779: 
780:         WITH loc_oGrade.Column1.Header1
781:             .FontName  = "Verdana"
782:             .FontSize  = 8
783:             .Alignment = 2
784:             .Caption   = ""
785:             .Picture   = gc_4c_CaminhoIcones + "CHECKBX.BMP"
786:         ENDWITH
787: 
788:         *-- BINDEVENT do checkbox de selecao (Fase 7/8) - regra CLAUDE.md
789:         *-- "CheckBox em coluna de Grid": o toggle nativo NAO e' confiavel
790:         *-- dentro de Column, entao Click/MouseDown so suprimem (NODEFAULT) e
791:         *-- MouseUp/KeyPress(Enter/Espaco) e' quem de fato alterna, via
792:         *-- ChkSelecaoToggle - que tambem carrega a logica de autorizacao do
793:         *-- legado (SigOpSen). BINDEVENT do Header1.Click (selecionar/
794:         *-- desmarcar tudo) fica aqui tambem, por serem da mesma coluna.
795:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "Click",     THIS, "ChkSelecaoClick")
796:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseDown", THIS, "ChkSelecaoMouseDown")
797:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "MouseUp",   THIS, "ChkSelecaoMouseUp")
798:         BINDEVENT(loc_oGrade.Column1.chk_4c_Selecao, "KeyPress",  THIS, "ChkSelecaoKeyPress")
799:         BINDEVENT(loc_oGrade.Column1.Header1,        "Click",     THIS, "Header1Click")
800: 
801:         *-- Column2: descricao do tipo de desconto (localDes.Descrs)
802:         WITH loc_oGrade.Column2
803:             .ControlSource = "cursor_4c_Dados.Descrs"
804:             .Width         = 500
805:             .Movable       = .F.
806:             .Resizable     = .F.
807:             .ReadOnly      = .F.
808:             .Visible       = .T.
809:         ENDWITH
810:         WITH loc_oGrade.Column2.Header1
811:             .FontName  = "Verdana"
812:             .FontSize  = 8
813:             .Alignment = 2
814:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o do Desconto"
815:         ENDWITH
816: 
817:         *-- Column3: percentual de desconto (localDes.Descos)
818:         WITH loc_oGrade.Column3
819:             .ControlSource = "cursor_4c_Dados.Descos"
820:             .Width         = 88
821:             .ReadOnly      = .F.
822:             .Visible       = .T.
823:         ENDWITH
824:         WITH loc_oGrade.Column3.Header1
825:             .FontName  = "Verdana"
826:             .FontSize  = 8
827:             .Alignment = 2
828:             .Caption   = "% Desconto"
829:         ENDWITH
830: 
831:         *-- Column4: valor do desconto (localDes.Valdes)
832:         WITH loc_oGrade.Column4
833:             .ControlSource = "cursor_4c_Dados.Valdes"
834:             .Width         = 110
835:             .ReadOnly      = .F.
836:             .Visible       = .T.
837:         ENDWITH
838:         WITH loc_oGrade.Column4.Header1
839:             .FontName  = "Verdana"
840:             .FontSize  = 8
841:             .Alignment = 2
842:             .Caption   = "Valor Desconto"
843:         ENDWITH
844: 
845:         *-- Celulas digitaveis / bloqueadas das colunas 2, 3 e 4. Fica por
846:         *-- ULTIMO porque Column.ReadOnly tem de ser definido DEPOIS de
847:         *-- Grid.ReadOnly (o do grid propaga para as colunas e sobrescreve
848:         *-- o delas - regra CLAUDE.md #46).
849:         THIS.InstalarCelulasGrade(loc_oGrade)
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * ConfigurarTotais - os TRES pares de total, filhos diretos do form:

*-- Linhas 866 a 884:
866:     * Return(.F.) do legado) e Label nao entra na tabulacao, logo o
867:     * TabIndex deles e' inerte - e atribuir TabIndex em runtime RENUMERA
868:     * os demais controles do form, o que mexeria na ordem de tabulacao
869:     * real (cmg_4c_Botoes = 2, grd_4c_Dados = 1) sem nenhum ganho.
870:     *
871:     * Os tres campos (lnValor/lnTDesc/lnSaldo) tem PROCEDURE When
872:     * Return(.F.) no legado - nunca recebem foco, sao so EXIBICAO. Aqui
873:     * isso vira ReadOnly = .T. + TabStop = .F. (equivalente: a celula nunca
874:     * entra em edicao e o Tab pula o controle), sem precisar de evento.
875:     *
876:     * Geometria/InputMask TRANSCRITOS do dump (SIGOPDES.Say2/lnValor/Say4/
877:     * lnTDesc) - regra CLAUDE.md #49 (Format/InputMask nunca descartados).
878:     * ForeColor dos labels e' RGB(90,90,90), EXPLICITO no dump (nao e' o
879:     * caso de "classe say sem ForeColor" da regra CLAUDE.md #12).
880:     *
881:     * lnValor.Value nasce de THIS.this_oBusinessObject.this_nValor - esse
882:     * valor ja foi igualado a this_nUnitOrigs em InicializarForm, que e'
883:     * exatamente o que o Init legado faz ("this.lnValor.value =
884:     * crTpmMvItn.unitorigs"). lnTDesc.Value nasce 0: o legado so o

*-- Linhas 1068 a 1086:
1068:     ENDPROC
1069: 
1070:     *==========================================================================
1071:     * AcessoGradeCota - responde se a grade de cota (grd_4c_Cota) deve
1072:     * aparecer. Legado: "THIS.grdCota.Visible = fChecaAcesso('SIGCDDES',
1073:     * 'GERENTE')" - so o acesso GERENTE ve a cota da empresa.
1074:     *
1075:     * A chamada de 2 argumentos e' a do legado e esta FIEL: os 3
1076:     * parametros restantes de fChecaAcesso tem fallback proprio dentro da
1077:     * funcao (pUsu cai na PUBLIC Usuar, pMsg ausente nao exibe aviso).
1078:     *
1079:     * O guard de modo existe porque fChecaAcesso abre conexao propria
1080:     * (CreateObject('fSqlConector') + SELECT em SigCdAcu): em validacao de
1081:     * UI e em modo de teste nao ha banco, e a chamada ficaria pendurada
1082:     * DENTRO do CREATEOBJECT do form, o que se le como "a tela nao
1083:     * instancia" sem haver defeito nenhum de tela. Sem banco a grade de
1084:     * cota nao teria o que mostrar de qualquer forma.
1085:     *==========================================================================
1086:     PROTECTED FUNCTION AcessoGradeCota()

*-- Linhas 1102 a 1125:
1102:     *
1103:     * Legado: o Init monta crDesc/crTipo/localDes e crSigCdDes e termina
1104:     * ligando cada grade ao seu cursor
1105:     * ("This.Grade.RecordSource = [localDes]" e
1106:     *  "This.GrdCota.RecordSource = [crSigCdDes]") seguido de
1107:     * "This.Refresh". Aqui as consultas vivem no BO (SigOpDesBO.
1108:     * CarregarDescontos / CarregarCota), que recarrega cursor_4c_Dados e
1109:     * cursor_4c_Cota com ZAP + APPEND FROM DBF() - a estrutura, o
1110:     * RecordSource e os ControlSource sobrevivem - e o form apenas repinta.
1111:     *
1112:     * PUBLIC de proposito: o harness de teste automatizado chama
1113:     * THIS.oForm.CarregarLista() de FORA da classe (PEMSTATUS devolve .T.
1114:     * para metodo PROTECTED e a chamada real falharia em runtime).
1115:     *
1116:     * RETURN fica FORA do TRY/CATCH - o resultado passa pela flag.
1117:     *==========================================================================
1118:     PROCEDURE CarregarLista()
1119:         LOCAL loc_lSucesso, loc_lCota, loc_lDescontos, loc_oErro
1120: 
1121:         loc_lSucesso = .F.
1122: 
1123:         TRY
1124:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1125:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;

*-- Linhas 1176 a 1337:
1176:     * Por isso a repintura mora aqui e e' chamada por TODO caminho que
1177:     * popula os cursores.
1178:     *
1179:     * ColumnCount NAO e' reatribuido: qualquer atribuicao a ColumnCount
1180:     * recria os objetos Column e DESTRUIRIA o CheckBox posto por
1181:     * AddObject em Column1 (com ele, a coluna de selecao da grade).
1182:     *
1183:     * O rebind completo (RecordSource -> ControlSource -> Width ->
1184:     * Header1.Caption -> CurrentControl/Sparse) so roda quando o
1185:     * RecordSource se perdeu, porque atribuir RecordSource RESETA Width,
1186:     * Header1.Caption, Sparse e CurrentControl - refaze-lo a cada carga
1187:     * seria apagar o que ConfigurarGrade acabou de montar. Na carga
1188:     * normal (ZAP + APPEND FROM, que preserva o alias) basta o GO TOP +
1189:     * Refresh.
1190:     *==========================================================================
1191:     PROCEDURE MontaGrade()
1192:         LOCAL loc_oGrade, loc_oGrdCota, loc_oErro
1193: 
1194:         TRY
1195:             *-- Grade principal de descontos
1196:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1197:                 loc_oGrade = THIS.grd_4c_Dados
1198: 
1199:                 IF UPPER(ALLTRIM(loc_oGrade.RecordSource)) != "CURSOR_4C_DADOS"
1200:                     THIS.VincularGrade()
1201:                 ENDIF
1202: 
1203:                 SELECT cursor_4c_Dados
1204:                 GO TOP
1205:                 loc_oGrade.Refresh()
1206:             ENDIF
1207: 
1208:             *-- Grade da cota da empresa
1209:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5) AND USED("cursor_4c_Cota")
1210:                 loc_oGrdCota = THIS.grd_4c_Cota
1211: 
1212:                 IF UPPER(ALLTRIM(loc_oGrdCota.RecordSource)) != "CURSOR_4C_COTA"
1213:                     THIS.VincularGradeCota()
1214:                 ENDIF
1215: 
1216:                 SELECT cursor_4c_Cota
1217:                 GO TOP
1218:                 loc_oGrdCota.Refresh()
1219:             ENDIF
1220: 
1221:             *-- Volta o alias corrente para a grade principal, que e' a
1222:             *-- que recebe o foco e de onde os eventos de celula leem.
1223:             IF USED("cursor_4c_Dados")
1224:                 SELECT cursor_4c_Dados
1225:             ENDIF
1226:         CATCH TO loc_oErro
1227:             MsgErro(loc_oErro.Message + CHR(13) + ;
1228:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1229:                     "Procedure: " + loc_oErro.Procedure, ;
1230:                     "Erro em MontaGrade")
1231:         ENDTRY
1232:     ENDPROC
1233: 
1234:     *==========================================================================
1235:     * VincularGrade - religa grd_4c_Dados a cursor_4c_Dados e repoe TUDO
1236:     * que a atribuicao de RecordSource reseta.
1237:     *
1238:     * Atribuir RecordSource devolve Column.Width ao default 90, limpa
1239:     * Header1.Caption, zera Sparse e derruba CurrentControl - entao a
1240:     * ordem obrigatoria e' RecordSource -> ControlSource -> Width ->
1241:     * Header1.Caption, e so DEPOIS o par CurrentControl/Sparse da coluna
1242:     * do CheckBox. Os valores repostos aqui sao os MESMOS transcritos do
1243:     * dump em ConfigurarGrade.
1244:     *
1245:     * ColumnCount fica de fora: reatribui-lo recriaria os Column e
1246:     * destruiria o CheckBox de Column1.
1247:     *==========================================================================
1248:     PROTECTED PROCEDURE VincularGrade()
1249:         LOCAL loc_oGrade
1250: 
1251:         loc_oGrade = THIS.grd_4c_Dados
1252: 
1253:         *-- Atribuir ColumnCount recria os objetos Column e DESTRUIRIA o
1254:         *-- chk_4c_Selecao posto por AddObject em Column1: a coluna de
1255:         *-- selecao voltaria a desenhar o Text1 dela e o usuario perderia o
1256:         *-- unico jeito de marcar a linha. Por isso, aqui:
1257:         *-- NAO reatribuir ColumnCount.
1258:         loc_oGrade.RecordSource = "cursor_4c_Dados"
1259: 
1260:         loc_oGrade.Column1.ControlSource = "cursor_4c_Dados.Selecao"
1261:         loc_oGrade.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1262:         loc_oGrade.Column3.ControlSource = "cursor_4c_Dados.Descos"
1263:         loc_oGrade.Column4.ControlSource = "cursor_4c_Dados.Valdes"
1264: 
1265:         loc_oGrade.Column1.Width = 23
1266:         loc_oGrade.Column2.Width = 500
1267:         loc_oGrade.Column3.Width = 88
1268:         loc_oGrade.Column4.Width = 110
1269: 
1270:         loc_oGrade.Column1.Header1.Caption = ""
1271:         loc_oGrade.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + ;
1272:                                              "o do Desconto"
1273:         loc_oGrade.Column3.Header1.Caption = "% Desconto"
1274:         loc_oGrade.Column4.Header1.Caption = "Valor Desconto"
1275: 
1276:         *-- Sem CurrentControl a coluna volta a desenhar o Text1 dela e o
1277:         *-- CheckBox de selecao, apesar de existir, nao aparece; sem
1278:         *-- Sparse = .F. ele apareceria so na linha ativa.
1279:         IF PEMSTATUS(loc_oGrade.Column1, "chk_4c_Selecao", 5)
1280:             loc_oGrade.Column1.CurrentControl = "chk_4c_Selecao"
1281:         ENDIF
1282:         loc_oGrade.Column1.Sparse = .F.
1283: 
1284:         *-- As celulas de Column2/3/4 tambem se perdem no rebind
1285:         *-- (RecordSource derruba CurrentControl), e sem elas a coluna de
1286:         *-- descricao voltaria a aceitar digitacao e as duas colunas
1287:         *-- editaveis perderiam o When/Valid do legado. InstalarCelulasGrade
1288:         *-- e' idempotente: so chama AddObject quando o objeto nao existe.
1289:         THIS.InstalarCelulasGrade(loc_oGrade)
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * VincularGradeCota - religa grd_4c_Cota a cursor_4c_Cota e repoe o
1294:     * que a atribuicao de RecordSource reseta (mesma regra de ordem de
1295:     * VincularGrade). Legado: GrdCota.Column1/3/4.ControlSource apontam
1296:     * emps / valcota / Valdes de crSigCdDes - aqui nas 3 Column em ordem
1297:     * natural, com as larguras e captions do dump.
1298:     *
1299:     * Column.ReadOnly vai DEPOIS de Grid.ReadOnly: o do grid propaga para
1300:     * as colunas e sobrescreveria o das colunas.
1301:     *==========================================================================
1302:     PROTECTED PROCEDURE VincularGradeCota()
1303:         LOCAL loc_oGrdCota
1304: 
1305:         loc_oGrdCota = THIS.grd_4c_Cota
1306: 
1307:         *-- NAO reatribuir ColumnCount aqui: as 3 Column desta grade e as
1308:         *-- larguras do dump sao montadas por ConfigurarGradeCota, e
1309:         *-- reatribuir ColumnCount as recriaria do zero.
1310:         loc_oGrdCota.RecordSource = "cursor_4c_Cota"
1311: 
1312:         loc_oGrdCota.Column1.ControlSource = "cursor_4c_Cota.Emps"
1313:         loc_oGrdCota.Column2.ControlSource = "cursor_4c_Cota.Valcota"
1314:         loc_oGrdCota.Column3.ControlSource = "cursor_4c_Cota.Valdes"
1315: 
1316:         loc_oGrdCota.Column1.Width = 75
1317:         loc_oGrdCota.Column2.Width = 145
1318:         loc_oGrdCota.Column3.Width = 169
1319: 
1320:         loc_oGrdCota.Column1.Header1.Caption = "Empresa"
1321:         loc_oGrdCota.Column2.Header1.Caption = "Cota"
1322:         loc_oGrdCota.Column3.Header1.Caption = "Utilizada"
1323: 
1324:         loc_oGrdCota.ReadOnly         = .T.
1325:         loc_oGrdCota.Column1.ReadOnly = .T.
1326:         loc_oGrdCota.Column2.ReadOnly = .T.
1327:         loc_oGrdCota.Column3.ReadOnly = .T.
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * InstalarCelulasGrade - poe em Column2/3/4 da grade principal a
1332:     * SUBCLASSE de TextBox que carrega o When/Valid daquela celula no
1333:     * legado, e liga cada uma por CurrentControl.
1334:     *
1335:     * POR QUE SUBCLASSE E NAO BINDEVENT (regra CLAUDE.md #46): a validacao
1336:     * de celula de grade mora no Valid do TextBox da coluna, e BINDEVENT
1337:     * em "Valid" de TextBox de Column nao e' confiavel - alem disso o

*-- Linhas 1359 a 1377:
1359:     * IDEMPOTENTE de proposito: AddObject duas vezes com o mesmo nome no
1360:     * mesmo alvo estoura "Object is already defined" e derrubaria o Init.
1361:     * VincularGrade chama este metodo depois de cada rebind, porque
1362:     * atribuir RecordSource derruba CurrentControl.
1363:     *==========================================================================
1364:     PROTECTED PROCEDURE InstalarCelulasGrade(par_oGrade)
1365:         IF VARTYPE(par_oGrade) != "O"
1366:             RETURN
1367:         ENDIF
1368: 
1369:         *-- Column2: descricao do tipo de desconto. O legado NAO usa
1370:         *-- ReadOnly aqui (o dump declara Column2.ReadOnly = .F.) - quem
1371:         *-- bloqueia a digitacao e' o "When / Return .f." do Text1, e e'
1372:         *-- esse o mecanismo reproduzido. Transcrever so o ReadOnly = .F.
1373:         *-- do dump e parar ai deixaria a descricao do desconto EDITAVEL.
1374:         IF !PEMSTATUS(par_oGrade.Column2, "txt_4c_CelDescricao", 5)
1375:             par_oGrade.Column2.AddObject("txt_4c_CelDescricao", ;
1376:                                           "TextBoxCelDescricaoSigOpDes_4c")
1377:         ENDIF

*-- Linhas 1538 a 1556:
1538:     * deixaria de ser a linha corrente no meio do proprio Valid.
1539:     *
1540:     * PUBLIC: os eventos da Fase 7/8 (Click do checkbox de cada linha,
1541:     * Header1.Click de selecionar-tudo) acionam este metodo de fora.
1542:     *==========================================================================
1543:     PROCEDURE CalcularTotais()
1544:         LOCAL loc_nReg, loc_nSaldo, loc_nTDesc, loc_nTDescI, loc_nTDescM
1545:         LOCAL loc_nValor, loc_nBaseCota, loc_oErro
1546: 
1547:         TRY
1548:             IF !USED("cursor_4c_Dados")
1549:                 MsgErro("Cursor de descontos indispon" + CHR(237) + "vel " + ;
1550:                         "para calcular os totais.", "Erro em CalcularTotais")
1551:             ELSE
1552:                 loc_nValor = THIS.ValorNumerico(THIS.txt_4c_LnValor.Value)
1553: 
1554:                 SELECT cursor_4c_Dados
1555: 
1556:                 *-- Linha corrente: desmarcada zera os dois campos, marcada

*-- Linhas 1784 a 1850:
1784:     ENDPROC
1785: 
1786:     *==========================================================================
1787:     * Header1Click - SIGOPDES.Grade.Column1.Header1.Click (selecionar/
1788:     * desmarcar TODAS as linhas da grade principal).
1789:     *
1790:     * Legado:
1791:     *
1792:     *   If (This.parent.Header1.Tag = [X])
1793:     *       This.parent.Header1.Tag = [ ]
1794:     *       Update localDes Set Selecao = 0
1795:     *   Else
1796:     *       This.parent.Header1.Tag = [X]
1797:     *       Update localDes Set Selecao = 1
1798:     *   EndIf
1799:     *   ThisForm.Grade.Refresh
1800:     *
1801:     * This.parent.Header1 e' o proprio Header1 (This.parent = Column1) - o
1802:     * Tag dele guarda o estado do toggle entre um clique e outro, igual ao
1803:     * que fica aqui em loc_oHeader.Tag (propriedade nativa, generica, de
1804:     * qualquer objeto VFP).
1805:     *
1806:     * NAO chama CalcularTotais - e' FIEL ao legado, que tambem so faz o
1807:     * Update + Refresh aqui. "Selecionar tudo" marca Selecao em TODAS as
1808:     * linhas sem passar pela autorizacao (SigOpSen) que o Click do checkbox
1809:     * individual cobra - e' o mesmo comportamento do legado, nao uma lacuna
1810:     * desta migracao.
1811:     *
1812:     * PUBLIC: alvo de BINDEVENT (regra CLAUDE.md #3).
1813:     *==========================================================================
1814:     PROCEDURE Header1Click()
1815:         LOCAL loc_oHeader, loc_oErro
1816: 
1817:         TRY
1818:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
1819:                 loc_oHeader = THIS.grd_4c_Dados.Column1.Header1
1820: 
1821:                 IF ALLTRIM(NVL(loc_oHeader.Tag, "")) == "X"
1822:                     loc_oHeader.Tag = ""
1823:                     UPDATE cursor_4c_Dados SET Selecao = 0
1824:                 ELSE
1825:                     loc_oHeader.Tag = "X"
1826:                     UPDATE cursor_4c_Dados SET Selecao = 1
1827:                 ENDIF
1828: 
1829:                 THIS.grd_4c_Dados.Refresh()
1830:             ENDIF
1831:         CATCH TO loc_oErro
1832:             MsgErro(loc_oErro.Message + CHR(13) + ;
1833:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1834:                     "Procedure: " + loc_oErro.Procedure, ;
1835:                     "Erro em Header1Click")
1836:         ENDTRY
1837:     ENDPROC
1838: 
1839:     *==========================================================================
1840:     * ChkSelecaoClick / ChkSelecaoMouseDown / ChkSelecaoMouseUp /
1841:     * ChkSelecaoKeyPress - os quatro handlers do checkbox de selecao de
1842:     * Column1 (fwcheckbox1 do legado).
1843:     *
1844:     * Regra CLAUDE.md "CheckBox em coluna de Grid": o toggle nativo NAO e'
1845:     * confiavel dentro de Column (Column.AddObject + CurrentControl +
1846:     * Sparse = .F.), entao Click/MouseDown so suprimem (NODEFAULT) e
1847:     * MouseUp/KeyPress(Enter=13/Espaco=32) sao quem de fato aciona o
1848:     * ChkSelecaoToggle - equivalente ao "clicar no checkbox" do legado, cujo
1849:     * Click comeca com "=DoDefault()" (toggle nativo) e so DEPOIS reage ao
1850:     * this.Value resultante.

*-- Linhas 2002 a 2020:
2002:                 ENDIF
2003: 
2004:                 REPLACE Selecao WITH 0 IN cursor_4c_Dados
2005:                 THIS.grd_4c_Dados.Refresh()
2006:             ELSE
2007:                 REPLACE Usuars WITH SUBSTR(loc_cRetorno, 2) IN cursor_4c_Dados
2008:             ENDIF
2009:         ENDIF
2010: 
2011:         THIS.CalcularTotais()
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * ValidarPercentualDesconto - o PROCEDURE Valid de
2016:     * SIGOPDES.Grade.Column3.Text1 (celula "% Desconto").
2017:     *
2018:     * Chamado pelo Valid da subclasse txt_4c_CelPercentual, que e' o
2019:     * CurrentControl da coluna. O retorno E' o mecanismo: .F. mantem o
2020:     * cursor na celula e recusa a saida; .T. libera.

*-- Linhas 2497 a 2568:
2497:     * Legado:
2498:     *
2499:     *   RELEASE pcChv, pcEDN, pcItem
2500:     *   This.Grade.RecordSource          = []
2501:     *   This.Grade.Column1.ControlSource = []
2502:     *   This.Grade.Column2.ControlSource = []
2503:     *   This.Grade.Column3.ControlSource = []
2504:     *   This.Grade.Column4.ControlSource = []
2505:     *   Use In localDes
2506:     *
2507:     * As tres variaveis PUBLIC (pcChv/pcEDN/pcItem) nao tem equivalente: o
2508:     * contexto que elas carregavam entre o Init e os eventos vive em
2509:     * properties this_* do form e do BO, que morrem com os objetos - nao ha
2510:     * o que soltar do espaco global.
2511:     *
2512:     * O resto e' transcrito: SOLTAR a grade do cursor ANTES de fechar o
2513:     * cursor. A ordem importa - fechar o alias com a grade ainda ligada a ele
2514:     * deixa o Grid apontando para alias morto, e qualquer repintura posterior
2515:     * (o VFP repinta durante a propria destruicao da tela) acha alias
2516:     * inexistente. cursor_4c_Cota recebe o mesmo tratamento: o legado nao
2517:     * fechava crSigCdDes porque era cursor GLOBAL do chamador; aqui as duas
2518:     * grades sao nossas e os dois cursores tambem.
2519:     *
2520:     * NAO HA TABLEREVERT antes do USE IN (regra CLAUDE.md #52): os dois
2521:     * cursores nascem de CREATE CURSOR, ou seja Buffering = 1, e TABLEREVERT
2522:     * sem buffering nao e' no-op - estoura erro 1586 "Function requires row
2523:     * or table buffering mode". USE IN fecha o alias sozinho, inclusive com
2524:     * buffer sujo.
2525:     *
2526:     * DODEFAULT() na ULTIMA linha e' obrigatorio: FormBase.Destroy refaz os
2527:     * popups do menu principal (RELEASE POPUP + CriarMenuPrincipal), e sem a
2528:     * cadeia de heranca o menu do sistema aparece encolhido depois que este
2529:     * dialogo fecha.
2530:     *
2531:     * SEM RETURN: Destroy nao devolve valor, e o CATCH so reporta - abortar a
2532:     * destruicao por falha de limpeza deixaria o form pendurado.
2533:     *==========================================================================
2534:     PROCEDURE Destroy()
2535:         LOCAL loc_oErro
2536: 
2537:         TRY
2538:             *-- Solta a grade principal do cursor (legado: Grade.RecordSource
2539:             *-- e os quatro Column.ControlSource)
2540:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2541:                 WITH THIS.grd_4c_Dados
2542:                     .RecordSource          = ""
2543:                     .Column1.ControlSource = ""
2544:                     .Column2.ControlSource = ""
2545:                     .Column3.ControlSource = ""
2546:                     .Column4.ControlSource = ""
2547:                 ENDWITH
2548:             ENDIF
2549: 
2550:             *-- Solta a grade da cota (GrdCota, 3 colunas)
2551:             IF PEMSTATUS(THIS, "grd_4c_Cota", 5)
2552:                 WITH THIS.grd_4c_Cota
2553:                     .RecordSource          = ""
2554:                     .Column1.ControlSource = ""
2555:                     .Column2.ControlSource = ""
2556:                     .Column3.ControlSource = ""
2557:                 ENDWITH
2558:             ENDIF
2559: 
2560:             *-- E so ENTAO fecha os cursores (legado: "Use In localDes")
2561:             IF USED("cursor_4c_Dados")
2562:                 USE IN cursor_4c_Dados
2563:             ENDIF
2564: 
2565:             IF USED("cursor_4c_Cota")
2566:                 USE IN cursor_4c_Cota
2567:             ENDIF
2568:         CATCH TO loc_oErro

*-- Linhas 2582 a 2619:
2582:     * hoje - mantido pelo mesmo motivo do padrao canonico FormCor/FormCargo:
2583:     * um PageFrame acrescentado depois ja seria coberto.
2584:     *
2585:     * grd_4c_Cota e' EXCECAO: a visibilidade dele e' decidida pelo acesso
2586:     * GERENTE (ver AcessoGradeCota) e forcar Visible = .T. aqui exporia a
2587:     * cota de desconto da empresa para QUALQUER usuario, apagando em
2588:     * silencio a regra que o legado aplica. A recursao entra no objeto de
2589:     * qualquer forma, para os filhos dele nascerem visiveis quando o
2590:     * container voltar a ser exibido.
2591:     *==========================================================================
2592:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2593:         LOCAL loc_nI, loc_oObjeto, loc_nP
2594: 
2595:         IF VARTYPE(par_oContainer) != "O"
2596:             RETURN
2597:         ENDIF
2598: 
2599:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2600:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2601: 
2602:             IF VARTYPE(loc_oObjeto) = "O"
2603:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND ;
2604:                    UPPER(loc_oObjeto.Name) != "GRD_4C_COTA"
2605:                     loc_oObjeto.Visible = .T.
2606:                 ENDIF
2607: 
2608:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2609:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2610:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2611:                     ENDFOR
2612:                 ENDIF
2613: 
2614:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2615:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2616:                 ENDIF
2617:             ENDIF
2618:         ENDFOR
2619:     ENDPROC

