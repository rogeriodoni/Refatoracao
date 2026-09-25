# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [ALINHAMENTO] Botao 'cmd_4c_Proximo' tem Top=319 mas grupo usa Top=308 (diferenca de 11px)
- [ALINHAMENTO] Botao 'cmd_4c_Proximo' tem Top=370 mas grupo usa Top=382 (diferenca de 12px)
- [ALINHAMENTO] Botao 'cmd_4c_BtnCadastros' tem Top=56 mas grupo usa Top=52 (diferenca de 4px)
- [ALINHAMENTO] Botao 'cmd_4c_Proximo' tem Top=394 mas grupo usa Top=400 (diferenca de 6px)
- [ALINHAMENTO] Botao 'cmd_4c_BotPendentes' tem Top=9 mas grupo usa Top=1 (diferenca de 8px)
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (7678 linhas total):

*-- Linhas 17 a 25:
17: * FASE 3/8: ESTRUTURA BASE - DEFINE CLASS + propriedades + Init/InicializarForm/
18: * Destroy + TODOS os containers estruturais de topo do legado, criados vazios
19: * com a geometria e o visual EXATOS do SCX:
20: *   lbl_4c_TxtCaption (barra de titulo flat), cnt_4c__Img4c, img_4c_FigJpg,
21: *   obj_4c_Timer1, cnt_4c__Consulta, cnt_4c_Item, cnt_4c_Financ,
22: *   cnt_4c__Credito, cnt_4c__Pendencia, cnt_4c__Identifica, cnt_4c__Fpagto,
23: *   cnt_4c_CancelaItem, cnt_4c_CaixaLivre, cnt_4c__Mensagem, cnt_4c_Mensagems,
24: *   cnt_4c_Barra_Botoes.
25: * ConfigurarPageFrame existe como ORQUESTRADOR de layout base (convencao dos

*-- Linhas 48 a 57:
48: *     grd_4c_Parcelas   (Cnt_Fpagto.Cnt_ChequepreTef.Grade)   -> xPar
49: *   Junto vao os dois containers que hospedam duas delas (cnt_4c__GrdBarra e
50: *   cnt_4c__ChequepreTef) e os QUATRO botoes de acao que o legado cola nas
51: *   grades: cmd_4c_Inserir (F2-Selec), cmd_4c_Excluir (F4-Excluir),
52: *   cmd_4c_OkBarra (F5-Barra) e cmd_4c_BotPend ([F3]Pend., pendencias do cliente).
53: *
54: *   OS CURSORES (CriarCursoresGrades): no legado os cinco ja existiam, criados
55: *   pela tela de movimentacao na datasession COMPARTILHADA - o SCX so fazia
56: *   "Set DataSession To pnDatSes" e os enxergava prontos. Como o form migrado
57: *   usa DataSession = 2 (isolado, como o proprio SCX declara), eles nascem

*-- Linhas 521 a 547:
521:     *--------------------------------------------------------------------------
522:     * ConfigurarCabecalho - barra de titulo flat no topo (equivalente ao
523:     * TxtCaption legado). Este form NAO usa o padrao cnt_4c_Cabecalho com
524:     * lbl_4c_Sombra+lbl_4c_Titulo dos forms CRUD (frmcadastro): o legado nao
525:     * tem PageFrame nem faixa decorativa dupla, so um label direto no form.
526:     * Original: TxtCaption Top=0 Left=-1 Width=1300 Height=19 BackColor=90,90,90
527:     * ForeColor=255,255,255 FontName="Tahoma" FontBold=.T. Caption="  Caixa".
528:     *--------------------------------------------------------------------------
529:     PROTECTED PROCEDURE ConfigurarCabecalho()
530:         THIS.AddObject("lbl_4c_TxtCaption", "Label")
531:         WITH THIS.lbl_4c_TxtCaption
532:             .Top       = 0
533:             .Left      = -1
534:             .Width     = THIS.Width
535:             .Height    = 19
536:             .FontName  = "Tahoma"
537:             .FontBold  = .T.
538:             .Alignment = 0
539:             .BackStyle = 1
540:             .BackColor = RGB(90, 90, 90)
541:             .ForeColor = RGB(255, 255, 255)
542:             .Caption   = "  " + THIS.Caption
543:             .Visible   = .T.
544:         ENDWITH
545:     ENDPROC
546: 
547:     *--------------------------------------------------------------------------

*-- Linhas 558 a 573:
558:     * Original: GrdCupom Top=127 Left=407 Width=340 Height=312 ColumnCount=1
559:     * Enabled=.F. GridLines=0 HeaderHeight=0 ReadOnly=.T. RecordMark=.F.
560:     * ScrollBars=0. Column1: FontName="Verdana" Width=345 Movable=.F.
561:     * ReadOnly=.T. ForeColor=0,0,255. Header1.Caption="Header1" (legado nao
562:     * troca - HeaderHeight=0 o esconde).
563:     *--------------------------------------------------------------------------
564:     PROTECTED PROCEDURE ConfigurarGridCupom()
565:         THIS.AddObject("grd_4c_Cupom", "Grid")
566:         WITH THIS.grd_4c_Cupom
567:             .Top           = 127
568:             .Left          = 407
569:             .Width         = 340
570:             .Height        = 312
571:             .ColumnCount   = 1
572:             .Enabled       = .F.
573:             .GridLines     = 0

*-- Linhas 586 a 594:
586:             .Column1.ReadOnly  = .T.
587:             .Column1.ForeColor = RGB(0, 0, 255)
588:             .Column1.Header1.FontSize = 8
589:             .Column1.Header1.Caption  = "Header1"
590:             .Column1.Text1.FontBold   = .F.
591:             .Column1.Text1.FontName   = "Verdana"
592:             .Column1.Text1.BorderStyle = 0
593:             .Column1.Text1.Enabled    = .F.
594:             .Column1.Text1.Margin     = 0

*-- Linhas 621 a 655:
621: 
622:         THIS.AddObject("cnt_4c_Barra_Botoes", "Container")
623:         WITH THIS.cnt_4c_Barra_Botoes
624:             .Top           = 20
625:             .Left          = 470
626:             .Width         = 831
627:             .Height        = 79
628:             .BackStyle = 1
629:             .BackColor = RGB(255, 255, 255)
630:             .BorderWidth   = 0
631:             .SpecialEffect = 0
632:             .TabIndex      = 8
633:             .Visible       = .T.
634:         ENDWITH
635: 
636:             *-- [F2] Itens - tela padrao de lancamento de itens.
637:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Itens", "CommandButton")
638:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens
639:                 .Top             = 1
640:                 .Left            = 2
641:                 .Width           = 75
642:                 .Height          = 75
643:                 .AutoSize        = .F.
644:                 .FontBold        = .T.
645:                 .FontItalic      = .T.
646:                 .FontName        = "Comic Sans MS"
647:                 .FontSize        = 8
648:                 .WordWrap        = .T.
649:                 .Picture         = loc_cIcones + "geral_palete_60.jpg"
650:                 .Caption         = "[F2]Itens"
651:                 .MousePointer    = 15
652:                 .TabIndex        = 1
653:                 .ToolTipText     = "[F2] Tela de Itens"
654:                 .SpecialEffect   = 0
655:                 .PicturePosition = 13

*-- Linhas 662 a 1037:
662:             ENDWITH
663: 
664:             *-- [F3] Alteraqtd - alterar quantidade do item corrente.
665:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Alteraqtd", "CommandButton")
666:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Alteraqtd
667:                 .Top             = 1
668:                 .Left            = 77
669:                 .Width           = 75
670:                 .Height          = 75
671:                 .FontBold        = .T.
672:                 .FontItalic      = .T.
673:                 .FontName        = "Comic Sans MS"
674:                 .FontSize        = 8
675:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
676:                 .Caption         = "[F3]Qtde"
677:                 .TabIndex        = 2
678:                 .ToolTipText     = "[F3] Quantidades"
679:                 .ForeColor          = RGB(90, 90, 90)
680:                 .BackColor          = RGB(255, 255, 255)
681:                 .DisabledForeColor  = RGB(109, 109, 109)
682:                 .DisabledBackColor  = RGB(240, 240, 240)
683:                 .Themes          = .F.
684:                 .Visible         = .T.
685:             ENDWITH
686: 
687:             *-- [F3] Desconto - desconto do item corrente (mesmo Left do
688:             *-- Alteraqtd - so um dos dois fica visivel por vez).
689:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Desconto", "CommandButton")
690:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Desconto
691:                 .Top             = 1
692:                 .Left            = 77
693:                 .Width           = 75
694:                 .Height          = 75
695:                 .FontBold        = .T.
696:                 .FontItalic      = .T.
697:                 .FontName        = "Comic Sans MS"
698:                 .FontSize        = 8
699:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
700:                 .Caption         = "[F3]Descon."
701:                 .TabIndex        = 3
702:                 .ToolTipText     = "[F3] Descontos"
703:                 .ForeColor          = RGB(90, 90, 90)
704:                 .BackColor          = RGB(255, 255, 255)
705:                 .DisabledForeColor  = RGB(109, 109, 109)
706:                 .DisabledBackColor  = RGB(240, 240, 240)
707:                 .Themes          = .F.
708:                 .Visible         = .T.
709:             ENDWITH
710: 
711:             *-- [Ctrl+F3] Acrescimo - acrescimo do item corrente (mesmo Left
712:             *-- do par Alteraqtd/Desconto).
713:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Acrescimo", "CommandButton")
714:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Acrescimo
715:                 .Top             = 1
716:                 .Left            = 77
717:                 .Width           = 75
718:                 .Height          = 75
719:                 .FontBold        = .T.
720:                 .FontItalic      = .T.
721:                 .FontName        = "Comic Sans MS"
722:                 .FontSize        = 8
723:                 .Picture         = loc_cIcones + "geral_datas_60.jpg"
724:                 .Caption         = "[Ctrl+F3] +"
725:                 .TabIndex        = 3
726:                 .ToolTipText     = "[Ctrl + F3] Acr" + CHR(233) + "scimos"
727:                 .ForeColor          = RGB(90, 90, 90)
728:                 .BackColor          = RGB(255, 255, 255)
729:                 .DisabledForeColor  = RGB(109, 109, 109)
730:                 .DisabledBackColor  = RGB(240, 240, 240)
731:                 .Themes          = .F.
732:                 .Visible         = .T.
733:             ENDWITH
734: 
735:             *-- [F4] CancPagto - cancelar forma de pagamento lancada.
736:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_CancPagto", "CommandButton")
737:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_CancPagto
738:                 .Top             = 1
739:                 .Left            = 152
740:                 .Width           = 75
741:                 .Height          = 75
742:                 .FontBold        = .T.
743:                 .FontItalic      = .T.
744:                 .FontName        = "Comic Sans MS"
745:                 .FontSize        = 8
746:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
747:                 .Caption         = "[F4]Canc"
748:                 .TabIndex        = 5
749:                 .ToolTipText     = "[F4] Cancelar Forma de Pagamento"
750:                 .ForeColor          = RGB(90, 90, 90)
751:                 .BackColor          = RGB(255, 255, 255)
752:                 .DisabledForeColor  = RGB(109, 109, 109)
753:                 .DisabledBackColor  = RGB(240, 240, 240)
754:                 .Themes          = .F.
755:                 .Visible         = .T.
756:             ENDWITH
757: 
758:             *-- [F4] Apaga - cancelar a operacao/venda inteira (mesmo Left do
759:             *-- CancPagto).
760:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Apaga", "CommandButton")
761:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga
762:                 .Top             = 1
763:                 .Left            = 152
764:                 .Width           = 75
765:                 .Height          = 75
766:                 .FontBold        = .T.
767:                 .FontItalic      = .T.
768:                 .FontName        = "Comic Sans MS"
769:                 .FontSize        = 8
770:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
771:                 .Caption         = "[F4]Canc"
772:                 .TabIndex        = 4
773:                 .ToolTipText     = "[F4] Cancelar Opera" + CHR(231) + CHR(227) + "o"
774:                 .ForeColor          = RGB(90, 90, 90)
775:                 .BackColor          = RGB(255, 255, 255)
776:                 .DisabledForeColor  = RGB(109, 109, 109)
777:                 .DisabledBackColor  = RGB(240, 240, 240)
778:                 .Themes          = .F.
779:                 .Visible         = .T.
780:             ENDWITH
781: 
782:             *-- [F5] AltPreco - alteracao de precos.
783:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_AltPreco", "CommandButton")
784:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_AltPreco
785:                 .Top             = 1
786:                 .Left            = 227
787:                 .Width           = 75
788:                 .Height          = 75
789:                 .FontBold        = .T.
790:                 .FontItalic      = .T.
791:                 .FontName        = "Comic Sans MS"
792:                 .FontSize        = 8
793:                 .WordWrap        = .T.
794:                 .Picture         = loc_cIcones + "geral_cambio_60.jpg"
795:                 .Caption         = "[F5]Alt.$"
796:                 .TabIndex        = 6
797:                 .ToolTipText     = "[F5] Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
798:                 .ForeColor          = RGB(90, 90, 90)
799:                 .BackColor          = RGB(255, 255, 255)
800:                 .DisabledForeColor  = RGB(109, 109, 109)
801:                 .DisabledBackColor  = RGB(240, 240, 240)
802:                 .Themes          = .F.
803:                 .Visible         = .T.
804:             ENDWITH
805: 
806:             *-- [F6] Identifica - identificacao de contas (Origem/Destino/
807:             *-- Vendedor/Responsavel).
808:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Identifica", "CommandButton")
809:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Identifica
810:                 .Top             = 1
811:                 .Left            = 302
812:                 .Width           = 75
813:                 .Height          = 75
814:                 .FontBold        = .T.
815:                 .FontItalic      = .T.
816:                 .FontName        = "Comic Sans MS"
817:                 .FontSize        = 8
818:                 .Picture         = loc_cIcones + "geral_contatos_60.jpg"
819:                 .Caption         = "[F6]Identif"
820:                 .TabIndex        = 7
821:                 .ToolTipText     = "[F6] Identifica" + CHR(231) + CHR(227) + "o de Contas"
822:                 .ForeColor          = RGB(90, 90, 90)
823:                 .BackColor          = RGB(255, 255, 255)
824:                 .DisabledForeColor  = RGB(109, 109, 109)
825:                 .DisabledBackColor  = RGB(240, 240, 240)
826:                 .Themes          = .F.
827:                 .Visible         = .T.
828:             ENDWITH
829: 
830:             *-- [F7] Credito - operacoes de credito/devolucao.
831:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Credito", "CommandButton")
832:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Credito
833:                 .Top             = 1
834:                 .Left            = 377
835:                 .Width           = 75
836:                 .Height          = 75
837:                 .FontBold        = .T.
838:                 .FontItalic      = .T.
839:                 .FontName        = "Comic Sans MS"
840:                 .FontSize        = 8
841:                 .Picture         = loc_cIcones + "cadastro_vizualizar_60.jpg"
842:                 .Caption         = "[F7]Cr" + CHR(233) + "d."
843:                 .TabIndex        = 8
844:                 .ToolTipText     = "[F7] Cr" + CHR(233) + "ditos"
845:                 .ForeColor          = RGB(90, 90, 90)
846:                 .BackColor          = RGB(255, 255, 255)
847:                 .DisabledForeColor  = RGB(109, 109, 109)
848:                 .DisabledBackColor  = RGB(240, 240, 240)
849:                 .Themes          = .F.
850:                 .Visible         = .T.
851:             ENDWITH
852: 
853:             *-- [F8] Financia - crediario (desligado por padrao no legado -
854:             *-- Visible=.F. - mesmo Left de Pendencia).
855:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Financia", "CommandButton")
856:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Financia
857:                 .Top             = 1
858:                 .Left            = 452
859:                 .Width           = 75
860:                 .Height          = 75
861:                 .FontBold        = .T.
862:                 .FontItalic      = .T.
863:                 .FontName        = "Comic Sans MS"
864:                 .FontSize        = 8
865:                 .Picture         = loc_cIcones + "geral_lapis_60.jpg"
866:                 .Caption         = "[F8]Crediario"
867:                 .TabIndex        = 9
868:                 .ForeColor          = RGB(90, 90, 90)
869:                 .BackColor          = RGB(255, 255, 255)
870:                 .DisabledForeColor  = RGB(109, 109, 109)
871:                 .DisabledBackColor  = RGB(240, 240, 240)
872:                 .Themes          = .F.
873:                 .Visible         = .F.
874:             ENDWITH
875: 
876:             *-- [F8] Pendencia - sub-niveis/pendencias (mesmo Left do
877:             *-- Financia).
878:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pendencia", "CommandButton")
879:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pendencia
880:                 .Top             = 1
881:                 .Left            = 452
882:                 .Width           = 75
883:                 .Height          = 75
884:                 .FontBold        = .T.
885:                 .FontItalic      = .T.
886:                 .FontName        = "Comic Sans MS"
887:                 .FontSize        = 8
888:                 .Picture         = loc_cIcones + "geral_adicao_60.jpg"
889:                 .Caption         = "[F8]Pend"
890:                 .TabIndex        = 9
891:                 .ToolTipText     = "[F8] Pend" + CHR(234) + "ncias"
892:                 .ForeColor          = RGB(90, 90, 90)
893:                 .BackColor          = RGB(255, 255, 255)
894:                 .DisabledForeColor  = RGB(109, 109, 109)
895:                 .DisabledBackColor  = RGB(240, 240, 240)
896:                 .Themes          = .F.
897:                 .Visible         = .T.
898:             ENDWITH
899: 
900:             *-- <Ctrl+P> VerPreco - abre o painel de consulta de preco
901:             *-- (mesmo Left do impfiscal).
902:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_VerPreco", "CommandButton")
903:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_VerPreco
904:                 .Top             = 1
905:                 .Left            = 527
906:                 .Width           = 75
907:                 .Height          = 75
908:                 .FontBold        = .T.
909:                 .FontItalic      = .T.
910:                 .FontName        = "Comic Sans MS"
911:                 .FontSize        = 8
912:                 .Picture         = loc_cIcones + "geral_lupa_60.jpg"
913:                 .Caption         = "<Ctrl+P>"
914:                 .TabIndex        = 11
915:                 .ForeColor          = RGB(90, 90, 90)
916:                 .BackColor          = RGB(255, 255, 255)
917:                 .DisabledForeColor  = RGB(109, 109, 109)
918:                 .DisabledBackColor  = RGB(240, 240, 240)
919:                 .Themes          = .F.
920:                 .Visible         = .T.
921:             ENDWITH
922: 
923:             *-- [F9] impfiscal - status/comandos da impressora fiscal (mesmo
924:             *-- Left do VerPreco).
925:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Impfiscal", "CommandButton")
926:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Impfiscal
927:                 .Top             = 1
928:                 .Left            = 527
929:                 .Width           = 75
930:                 .Height          = 75
931:                 .FontBold        = .T.
932:                 .FontItalic      = .T.
933:                 .FontName        = "Comic Sans MS"
934:                 .FontSize        = 8
935:                 .Picture         = loc_cIcones + "geral_boleto_60.jpg"
936:                 .Caption         = "[F9]Fiscal"
937:                 .TabIndex        = 10
938:                 .ToolTipText     = "[F9] Impressora Fiscal"
939:                 .ForeColor          = RGB(90, 90, 90)
940:                 .BackColor          = RGB(255, 255, 255)
941:                 .DisabledForeColor  = RGB(109, 109, 109)
942:                 .DisabledBackColor  = RGB(240, 240, 240)
943:                 .Themes          = .F.
944:                 .Visible         = .T.
945:             ENDWITH
946: 
947:             *-- [Ctrl+F11] MudaOpe - trocar operacao (mesmo Left do Pagto).
948:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_MudaOpe", "CommandButton")
949:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_MudaOpe
950:                 .Top             = 1
951:                 .Left            = 602
952:                 .Width           = 75
953:                 .Height          = 75
954:                 .FontBold        = .T.
955:                 .FontItalic      = .T.
956:                 .FontName        = "Comic Sans MS"
957:                 .FontSize        = 8
958:                 .Picture         = loc_cIcones + "cadastro_inserir_60.jpg"
959:                 .Caption         = "[Ctrl+F11]Op"
960:                 .TabIndex        = 11
961:                 .ToolTipText     = "[Ctrl + F11] Trocar Opera" + CHR(231) + CHR(227) + "o"
962:                 .ForeColor          = RGB(90, 90, 90)
963:                 .BackColor          = RGB(255, 255, 255)
964:                 .DisabledForeColor  = RGB(109, 109, 109)
965:                 .DisabledBackColor  = RGB(240, 240, 240)
966:                 .Themes          = .F.
967:                 .Visible         = .T.
968:             ENDWITH
969: 
970:             *-- [F11] Pagto - tela de formas de pagamento (mesmo Left do
971:             *-- MudaOpe - visivel por padrao no legado).
972:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Pagto", "CommandButton")
973:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Pagto
974:                 .Top             = 1
975:                 .Left            = 602
976:                 .Width           = 75
977:                 .Height          = 75
978:                 .FontBold        = .T.
979:                 .FontItalic      = .T.
980:                 .FontName        = "Comic Sans MS"
981:                 .FontSize        = 8
982:                 .WordWrap        = .F.
983:                 .Picture         = loc_cIcones + "geral_calculadora_60.jpg"
984:                 .Caption         = "[F11]Pagto"
985:                 .TabIndex        = 11
986:                 .ToolTipText     = "[F11] Tela de Formas de Pagamentos"
987:                 .ForeColor          = RGB(90, 90, 90)
988:                 .BackColor          = RGB(255, 255, 255)
989:                 .DisabledForeColor  = RGB(109, 109, 109)
990:                 .DisabledBackColor  = RGB(240, 240, 240)
991:                 .Themes          = .F.
992:                 .Visible         = .T.
993:             ENDWITH
994: 
995:             *-- Confirmar - confirma/finaliza a operacao corrente.
996:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Ok", "CommandButton")
997:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Ok
998:                 .Top             = 1
999:                 .Left            = 677
1000:                 .Width           = 75
1001:                 .Height          = 75
1002:                 .FontBold        = .T.
1003:                 .FontItalic      = .T.
1004:                 .FontName        = "Comic Sans MS"
1005:                 .FontSize        = 8
1006:                 .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
1007:                 .Caption         = "Confirmar"
1008:                 .TabIndex        = 13
1009:                 .ToolTipText     = "Confirmar"
1010:                 .PicturePosition = 13
1011:                 .ForeColor          = RGB(90, 90, 90)
1012:                 .BackColor          = RGB(255, 255, 255)
1013:                 .DisabledForeColor  = RGB(109, 109, 109)
1014:                 .DisabledBackColor  = RGB(240, 240, 240)
1015:                 .Themes          = .F.
1016:                 .Visible         = .T.
1017:             ENDWITH
1018: 
1019:             *-- Cancelar [ESC] - cancela a tela/passo corrente.
1020:             THIS.cnt_4c_Barra_Botoes.AddObject("cmd_4c_Cancela", "CommandButton")
1021:             WITH THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela
1022:                 .Top             = 1
1023:                 .Left            = 752
1024:                 .Width           = 75
1025:                 .Height          = 75
1026:                 .FontBold        = .T.
1027:                 .FontItalic      = .T.
1028:                 .FontName        = "Comic Sans MS"
1029:                 .FontSize        = 8
1030:                 .Picture         = loc_cIcones + "cadastro_cancelar_60.jpg"
1031:                 .Cancel          = .T.
1032:                 .Caption         = "Cancelar"
1033:                 .TabIndex        = 12
1034:                 .ToolTipText     = "[ESC] Cancelar"
1035:                 .PicturePosition = 13
1036:                 .ForeColor          = RGB(90, 90, 90)
1037:                 .BackColor          = RGB(255, 255, 255)

*-- Linhas 1066 a 1075:
1066:         *-- grupo com BackStyle=1 (opaco) no legado - os demais sao BackStyle=0.
1067:         THIS.AddObject("cnt_4c__Consulta", "Container")
1068:         WITH THIS.cnt_4c__Consulta
1069:             .Top           = 124
1070:             .Left          = 32
1071:             .Width         = 850
1072:             .Height        = 495
1073:             .BackStyle     = 1
1074:             .BorderWidth   = 0
1075:             .SpecialEffect = 2

*-- Linhas 1083 a 1092:
1083:         *-- iniciar a venda.
1084:         THIS.AddObject("cnt_4c_Item", "Container")
1085:         WITH THIS.cnt_4c_Item
1086:             .Top           = 124
1087:             .Left          = 32
1088:             .Width         = 850
1089:             .Height        = 494
1090:             .BackStyle     = 0
1091:             .BorderWidth   = 0
1092:             .SpecialEffect = 2

*-- Linhas 1099 a 1108:
1099:         *-- CntFinanc: crediario / codigos de barras (F8 Crediario).
1100:         THIS.AddObject("cnt_4c_Financ", "Container")
1101:         WITH THIS.cnt_4c_Financ
1102:             .Top           = 124
1103:             .Left          = 32
1104:             .Width         = 850
1105:             .Height        = 498
1106:             .BackStyle     = 0
1107:             .BorderWidth   = 0
1108:             .SpecialEffect = 2

*-- Linhas 1115 a 1124:
1115:         *-- Cnt_Credito: operacoes de credito/devolucao (F7 Cred.).
1116:         THIS.AddObject("cnt_4c__Credito", "Container")
1117:         WITH THIS.cnt_4c__Credito
1118:             .Top           = 124
1119:             .Left          = 32
1120:             .Width         = 850
1121:             .Height        = 494
1122:             .BackStyle = 1
1123:             .BorderWidth   = 0
1124:             .SpecialEffect = 2

*-- Linhas 1131 a 1140:
1131:         *-- Cnt_Pendencia: sub-niveis / pendencias (F8 Pend).
1132:         THIS.AddObject("cnt_4c__Pendencia", "Container")
1133:         WITH THIS.cnt_4c__Pendencia
1134:             .Top           = 124
1135:             .Left          = 32
1136:             .Width         = 850
1137:             .Height        = 497
1138:             .BackStyle = 1
1139:             .BorderWidth   = 0
1140:             .SpecialEffect = 2

*-- Linhas 1149 a 1158:
1149:         *-- Unico do grupo com SpecialEffect=0 no legado.
1150:         THIS.AddObject("cnt_4c__Identifica", "Container")
1151:         WITH THIS.cnt_4c__Identifica
1152:             .Top           = 124
1153:             .Left          = 32
1154:             .Width         = 850
1155:             .Height        = 496
1156:             .BackStyle     = 0
1157:             .BorderWidth   = 0
1158:             .SpecialEffect = 0

*-- Linhas 1166 a 1175:
1166:         *-- legado (os irmaos usam RGB(100,100,100)) - transcrito como esta.
1167:         THIS.AddObject("cnt_4c__Fpagto", "Container")
1168:         WITH THIS.cnt_4c__Fpagto
1169:             .Top           = 124
1170:             .Left          = 32
1171:             .Width         = 850
1172:             .Height        = 504
1173:             .BackStyle     = 0
1174:             .BorderWidth   = 0
1175:             .SpecialEffect = 2

*-- Linhas 1183 a 1192:
1183:         *-- a area central, fora do grupo dos sete acima.
1184:         THIS.AddObject("cnt_4c_CancelaItem", "Container")
1185:         WITH THIS.cnt_4c_CancelaItem
1186:             .Top           = 310
1187:             .Left          = 120
1188:             .Width         = 468
1189:             .Height        = 141
1190:             .BorderWidth   = 1
1191:             .SpecialEffect = 2
1192:             .TabIndex      = 2

*-- Linhas 1198 a 1207:
1198:         *-- andamento (ocupa a area da grade do cupom).
1199:         THIS.AddObject("cnt_4c_CaixaLivre", "Container")
1200:         WITH THIS.cnt_4c_CaixaLivre
1201:             .Top         = 126
1202:             .Left        = 407
1203:             .Width       = 475
1204:             .Height      = 447
1205:             .BackStyle   = 1
1206:             .BorderWidth = 0
1207:             .TabIndex    = 11

*-- Linhas 1220 a 1229:
1220:         *-- Cnt_Mensagem: faixa de status ("Aguarde... Reconfigurando", etc).
1221:         THIS.AddObject("cnt_4c__Mensagem", "Container")
1222:         WITH THIS.cnt_4c__Mensagem
1223:             .Top           = 620
1224:             .Left          = 31
1225:             .Width         = 1195
1226:             .Height        = 26
1227:             .BorderWidth   = 1
1228:             .SpecialEffect = 2
1229:             .TabIndex      = 9

*-- Linhas 1235 a 1244:
1235:         *-- mensagems: faixa de duas linhas com a descricao do item corrente.
1236:         THIS.AddObject("cnt_4c_Mensagems", "Container")
1237:         WITH THIS.cnt_4c_Mensagems
1238:             .Top           = 645
1239:             .Left          = 31
1240:             .Width         = 1195
1241:             .Height        = 46
1242:             .BackStyle     = 1
1243:             .BorderWidth   = 1
1244:             .SpecialEffect = 2

*-- Linhas 1268 a 1277:
1268:         *-- Cnt_Img4c: moldura do logotipo no canto superior esquerdo.
1269:         THIS.AddObject("cnt_4c__Img4c", "Container")
1270:         WITH THIS.cnt_4c__Img4c
1271:             .Top           = 21
1272:             .Left          = 34
1273:             .Width         = 291
1274:             .Height        = 101
1275:             .BackStyle     = 0
1276:             .BorderWidth   = 0
1277:             .SpecialEffect = 2

*-- Linhas 1284 a 1307:
1284:         *-- Legado: Stretch=1 BackStyle=1 Visible=.F.
1285:         THIS.AddObject("img_4c_FigJpg", "Image")
1286:         WITH THIS.img_4c_FigJpg
1287:             .Top       = 124
1288:             .Left      = 882
1289:             .Width     = 282
1290:             .Height    = 211
1291:             .Stretch   = 1
1292:             .BackStyle = 1
1293:             .Visible   = .F.
1294:         ENDWITH
1295: 
1296:         *-- Timer1: atualiza a barra de titulo (data/hora/operador) a cada 1s.
1297:         *-- O corpo do evento Timer e transcrito na fase de eventos; o objeto e
1298:         *-- estrutural e fica inerte ate la (Timer base sem codigo nao faz nada).
1299:         THIS.AddObject("obj_4c_Timer1", "Timer")
1300:         WITH THIS.obj_4c_Timer1
1301:             .Top      = 547
1302:             .Left     = 655
1303:             .Width    = 27
1304:             .Height   = 26
1305:             .Interval = 1000
1306:         ENDWITH
1307:     ENDPROC

*-- Linhas 1313 a 1324:
1313:     * coloca colados a elas:
1314:     *
1315:     *   cnt_4c_Financ.cnt_4c__GrdBarra        (Cnt_GrdBarra)
1316:     *       grd_4c_Barras   (grade)            + cmd_4c_Inserir / cmd_4c_Excluir
1317:     *                                          / cmd_4c_OkBarra
1318:     *   cnt_4c__Credito.grd_4c_Devolucao      (GradeDevol)
1319:     *   cnt_4c__Pendencia.grd_4c_SubNiveis    (GradeMultiSubN) + cmd_4c_BotPend
1320:     *   cnt_4c__Fpagto.cnt_4c__ChequepreTef   (Cnt_ChequepreTef)
1321:     *       grd_4c_Parcelas (Grade)
1322:     *
1323:     * Nomes DIFERENTES do generico "grd_4c_Dados" de mapeamento.json de
1324:     * proposito: o JSON mapeia as CINCO grades do legado para o mesmo nome, e

*-- Linhas 1342 a 1351:
1342:         THIS.cnt_4c_Financ.AddObject("cnt_4c__GrdBarra", "Container")
1343:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
1344:         WITH loc_oCnt
1345:             .Top           = 183
1346:             .Left          = 4
1347:             .Width         = 368
1348:             .Height        = 164
1349:             .BackStyle     = 1
1350:             .BorderWidth   = 1
1351:             .SpecialEffect = 2

*-- Linhas 1357 a 1425:
1357:         *-- Grade dos codigos de barras lidos (TmpBarFin).
1358:         loc_oCnt.AddObject("grd_4c_Barras", "Grid")
1359:         WITH loc_oCnt.grd_4c_Barras
1360:             .Top         = 4
1361:             .Left        = 2
1362:             .Width       = 364
1363:             .Height      = 129
1364:             .ColumnCount = 4
1365:             .RecordMark  = .F.
1366:             .DeleteMark  = .F.
1367:             .Visible     = .T.
1368:         ENDWITH
1369: 
1370:         *-- F2-Selec: posiciona na grade para digitar um novo par de barras
1371:         *-- (legado: Grade.Column1.SetFocus).
1372:         loc_oCnt.AddObject("cmd_4c_Inserir", "CommandButton")
1373:         WITH loc_oCnt.cmd_4c_Inserir
1374:             .Top             = 131
1375:             .Left            = 3
1376:             .Width           = 80
1377:             .Height          = 30
1378:             .FontBold        = .T.
1379:             .FontName        = "Tahoma"
1380:             .FontSize        = 8
1381:             .Picture         = loc_cIcones + "a_misc7.bmp"
1382:             .Caption         = "F2-\<Selec"
1383:             .TabIndex        = 77
1384:             .PicturePosition = 1
1385:             .ForeColor       = RGB(90, 90, 90)
1386:             .Visible         = .T.
1387:         ENDWITH
1388: 
1389:         *-- F4-Excluir: apaga a linha corrente de TmpBarFin.
1390:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
1391:         WITH loc_oCnt.cmd_4c_Excluir
1392:             .Top             = 131
1393:             .Left = 230
1394:             .Width           = 80
1395:             .Height          = 30
1396:             .FontBold        = .T.
1397:             .FontName        = "Tahoma"
1398:             .FontSize        = 8
1399:             .Picture         = loc_cIcones + "a_delete1.bmp"
1400:             .Caption         = "F4-\<Excluir"
1401:             .TabIndex        = 77
1402:             .PicturePosition = 1
1403:             .ForeColor       = RGB(90, 90, 90)
1404:             .Visible         = .T.
1405:         ENDWITH
1406: 
1407:         *-- F5-Barra: devolve o foco ao campo do primeiro codigo de barras.
1408:         *-- Nome do legado e "ok"; aqui cmd_4c_OkBarra, para nao colidir com os
1409:         *-- outros dois "ok" do form (Barra_Botoes.ok e CancelaItem.ok).
1410:         loc_oCnt.AddObject("cmd_4c_OkBarra", "CommandButton")
1411:         WITH loc_oCnt.cmd_4c_OkBarra
1412:             .Top             = 131
1413:             .Left            = 161
1414:             .Width           = 80
1415:             .Height          = 30
1416:             .FontBold        = .T.
1417:             .FontName        = "Tahoma"
1418:             .FontSize        = 8
1419:             .Picture         = loc_cIcones + "smmail.bmp"
1420:             .Caption         = "F5-\<Barra"
1421:             .TabIndex        = 40
1422:             .PicturePosition = 1
1423:             .ForeColor       = RGB(90, 90, 90)
1424:             .Visible         = .T.
1425:         ENDWITH

*-- Linhas 1433 a 1442:
1433:         THIS.cnt_4c__Credito.AddObject("grd_4c_Devolucao", "Grid")
1434:         loc_oGrd = THIS.cnt_4c__Credito.grd_4c_Devolucao
1435:         WITH loc_oGrd
1436:             .Top          = 64
1437:             .Left         = 10
1438:             .Width        = 355
1439:             .Height       = 325
1440:             .ColumnCount  = 3
1441:             .FontName     = "Courier New"
1442:             .HeaderHeight = 16

*-- Linhas 1469 a 1478:
1469:         *======================================================================
1470:         THIS.cnt_4c__Pendencia.AddObject("grd_4c_SubNiveis", "Grid")
1471:         WITH THIS.cnt_4c__Pendencia.grd_4c_SubNiveis
1472:             .Top          = 8
1473:             .Left         = 14
1474:             .Width        = 274
1475:             .Height       = 397
1476:             .ColumnCount  = 3
1477:             .FontName     = "Verdana"
1478:             .HeaderHeight = 16

*-- Linhas 1486 a 1508:
1486:             .Visible      = .T.
1487:         ENDWITH
1488: 
1489:         *-- [F3]Pend. - abre a tela de pendencias do cliente (SigOpPen no
1490:         *-- legado). Fica ao lado da grade, dentro do mesmo container.
1491:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_BotPendentes", "CommandButton")
1492:         WITH THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes
1493:             .Top         = 9
1494:             .Left        = 300
1495:             .Width       = 75
1496:             .Height      = 75
1497:             .FontBold    = .T.
1498:             .FontItalic  = .T.
1499:             .FontName    = "Comic Sans MS"
1500:             .FontSize    = 8
1501:             .WordWrap    = .T.
1502:             .Picture     = loc_cIcones + "date2.ico"
1503:             .Caption     = "[F3]Pend."
1504:             .TabIndex    = 4
1505:             .ToolTipText = "Abre Tela de Pend" + CHR(234) + "ncias"
1506:             .ForeColor   = RGB(90, 90, 90)
1507:             .BackColor   = RGB(255, 255, 255)
1508:             .RightToLeft = .T.

*-- Linhas 1516 a 1539:
1516:         THIS.cnt_4c__Fpagto.AddObject("cnt_4c__ChequepreTef", "Container")
1517:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef
1518:         WITH loc_oCnt
1519:             .Top           = 358
1520:             .Left          = 2
1521:             .Width         = 371
1522:             .Height        = 139
1523:             .BackStyle     = 1
1524:             .BorderWidth   = 1
1525:             .SpecialEffect = 2
1526:             .TabIndex      = 13
1527:             .BackColor     = RGB(255, 255, 255)
1528:             .Visible       = .F.
1529:         ENDWITH
1530: 
1531:         loc_oCnt.AddObject("grd_4c_Parcelas", "Grid")
1532:         WITH loc_oCnt.grd_4c_Parcelas
1533:             .Top          = 58
1534:             .Left         = 5
1535:             .Width        = 362
1536:             .Height       = 79
1537:             .ColumnCount  = 4
1538:             .FontName     = "Tahoma"
1539:             .FontSize     = 8

*-- Linhas 1772 a 1780:
1772:                 .Column1.Text1.Width     = 345
1773: 
1774:                 .Column1.Width = 345
1775:                 .Column1.Header1.Caption = ""
1776:             ENDWITH
1777: 
1778:             *-- DynamicForeColor do legado: a cor de cada linha do cupom vem do
1779:             *-- campo Cores (0 item, 1 totalizador, 2 forma de pagamento,
1780:             *-- 3 valor recebido, 4 troco/estorno). Montado em variavel para

*-- Linhas 1835 a 1855:
1835:                 .Column1.Header1.FontName  = "Verdana"
1836:                 .Column1.Header1.FontSize  = 8
1837:                 .Column1.Header1.Alignment = 2
1838:                 .Column1.Header1.Caption   = "Pend" + CHR(234) + "ncias"
1839: 
1840:                 .Column2.Header1.FontBold  = .T.
1841:                 .Column2.Header1.FontName  = "Verdana"
1842:                 .Column2.Header1.FontSize  = 8
1843:                 .Column2.Header1.Alignment = 2
1844:                 .Column2.Header1.Caption   = "Notas"
1845: 
1846:                 .Column3.Header1.FontBold  = .T.
1847:                 .Column3.Header1.FontName  = "Verdana"
1848:                 .Column3.Header1.FontSize  = 8
1849:                 .Column3.Header1.Alignment = 2
1850:                 .Column3.Header1.Caption   = "Valor"
1851:             ENDWITH
1852:         ENDIF
1853: 
1854:         *======================================================================
1855:         * Grade dos CREDITOS / devolucoes (TmpDevol)

*-- Linhas 1901 a 1919:
1901:                 .Column1.Header1.FontBold  = .T.
1902:                 .Column1.Header1.FontSize  = 8
1903:                 .Column1.Header1.Alignment = 2
1904:                 .Column1.Header1.Caption   = "Op. Cr" + CHR(233) + "dito"
1905: 
1906:                 .Column2.Header1.FontBold  = .T.
1907:                 .Column2.Header1.FontSize  = 8
1908:                 .Column2.Header1.Alignment = 2
1909:                 .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
1910: 
1911:                 .Column3.Header1.FontBold  = .T.
1912:                 .Column3.Header1.FontSize  = 8
1913:                 .Column3.Header1.Alignment = 2
1914:                 .Column3.Header1.Caption   = "Documento"
1915:             ENDWITH
1916:         ENDIF
1917: 
1918:         *======================================================================
1919:         * Grade dos CODIGOS DE BARRAS do crediario (TmpBarFin)

*-- Linhas 1950 a 1964:
1950:                 .Column4.Width = 80
1951: 
1952:                 .Column1.Header1.Alignment = 2
1953:                 .Column1.Header1.Caption   = "C" + CHR(243) + "digo de Barra"
1954:                 .Column2.Header1.Alignment = 2
1955:                 .Column2.Header1.Caption   = "Parcela"
1956:                 .Column3.Header1.Alignment = 2
1957:                 .Column3.Header1.Caption   = "Valor"
1958:                 .Column4.Header1.Alignment = 2
1959:                 .Column4.Header1.Caption   = "Vencimento"
1960:             ENDWITH
1961:         ENDIF
1962: 
1963:         *======================================================================
1964:         * Grade das PARCELAS / cheques pre-datados (xPar)

*-- Linhas 2039 a 2062:
2039:                 .Column1.Header1.FontName  = "Tahoma"
2040:                 .Column1.Header1.FontSize  = 8
2041:                 .Column1.Header1.Alignment = 2
2042:                 .Column1.Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o"
2043: 
2044:                 .Column2.Header1.FontName  = "Tahoma"
2045:                 .Column2.Header1.FontSize  = 8
2046:                 .Column2.Header1.Alignment = 2
2047:                 .Column2.Header1.Caption   = "Valor"
2048: 
2049:                 .Column3.Header1.FontName  = "Tahoma"
2050:                 .Column3.Header1.FontSize  = 8
2051:                 .Column3.Header1.Alignment = 2
2052:                 .Column3.Header1.Caption   = "Vencimento"
2053: 
2054:                 .Column4.Header1.FontName  = "Tahoma"
2055:                 .Column4.Header1.FontSize  = 8
2056:                 .Column4.Header1.Alignment = 2
2057:                 .Column4.Header1.Caption   = "Moe"
2058:             ENDWITH
2059:         ENDIF
2060:     ENDPROC
2061: 
2062:     *--------------------------------------------------------------------------

*-- Linhas 2315 a 2324:
2315:                     "CNT_4C__CHEQUEPRETEF", "CNT_4C__CHQ", ;
2316:                     "CNT_4C_ACRESCIMO", "CNT_4C_DESCONTO", ;
2317:                     "CBO_4C_CMBTOPERS", "CNT_4C_CANCELAITEM", "IMG_4C_FIGJPG", ;
2318:                     "OBJ_4C_GETOBS", "LBL_4C_OBS", "CMD_4C_FINANCIA", ;
2319:                     "CMD_4C_CMDENVIAPROD")
2320: 
2321:                 IF loc_lOculto
2322:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
2323:                         THIS.TornarControlesVisiveis(loc_oObjeto)
2324:                     ENDIF

*-- Linhas 2412 a 2421:
2412:     PROTECTED PROCEDURE ConfigurarCamposLogotipo()
2413:         THIS.cnt_4c__Img4c.AddObject("img_4c_Figjpg", "Image")
2414:         WITH THIS.cnt_4c__Img4c.img_4c_Figjpg
2415:             .Top         = -59
2416:             .Left        = -22
2417:             .Width       = 331
2418:             .Height      = 218
2419:             .Stretch     = 1
2420:             .BackStyle   = 1
2421:             .Picture     = gc_4c_CaminhoIcones + "4Control_logo2.png"

*-- Linhas 2440 a 2507:
2440:     * Height=26 Width=709).
2441:     *--------------------------------------------------------------------------
2442:     PROTECTED PROCEDURE ConfigurarCamposMensagens()
2443:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Mensagem", "Label")
2444:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Mensagem
2445:             .Top       = 2
2446:             .Left      = 3
2447:             .Width     = 2
2448:             .Height    = 18
2449:             .AutoSize  = .T.
2450:             .FontBold  = .T.
2451:             .FontName  = "Verdana"
2452:             .FontSize  = 10
2453:             .BackStyle = 0
2454:             .Caption   = ""
2455:             .ForeColor = RGB(36, 84, 155)
2456:             .Visible   = .T.
2457:         ENDWITH
2458: 
2459:         THIS.cnt_4c__Mensagem.AddObject("lbl_4c_Abertura", "Label")
2460:         WITH THIS.cnt_4c__Mensagem.lbl_4c_Abertura
2461:             .Top       = 3
2462:             .Left      = 317
2463:             .Width     = 55
2464:             .Height    = 19
2465:             .AutoSize  = .F.
2466:             .FontBold  = .T.
2467:             .FontName  = "Verdana"
2468:             .FontSize  = 10
2469:             .BackStyle = 0
2470:             .Caption   = ""
2471:             .ForeColor = RGB(36, 84, 155)
2472:             .Visible   = .T.
2473:         ENDWITH
2474: 
2475:         THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage1", "Label")
2476:         WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage1
2477:             .Top       = 1
2478:             .Left      = 6
2479:             .Width     = 709
2480:             .Height    = 23
2481:             .AutoSize  = .F.
2482:             .FontBold  = .T.
2483:             .FontName  = "Tahoma"
2484:             .FontSize  = 13
2485:             .BackStyle = 0
2486:             .Caption   = ""
2487:             .ForeColor = RGB(90, 90, 90)
2488:             .Visible   = .T.
2489:         ENDWITH
2490: 
2491:         THIS.cnt_4c_Mensagems.AddObject("lbl_4c_Mensage2", "Label")
2492:         WITH THIS.cnt_4c_Mensagems.lbl_4c_Mensage2
2493:             .Top       = 19
2494:             .Left      = 6
2495:             .Width     = 709
2496:             .Height    = 26
2497:             .AutoSize  = .F.
2498:             .FontBold  = .T.
2499:             .FontName  = "Tahoma"
2500:             .FontSize  = 16
2501:             .BackStyle = 0
2502:             .Caption   = ""
2503:             .ForeColor = RGB(90, 90, 90)
2504:             .Visible   = .T.
2505:         ENDWITH
2506:     ENDPROC
2507: 

*-- Linhas 2516 a 2564:
2516:     * Original CaixaLivre2: idem, Left=64 Top=120 ForeColor=0,64,183.
2517:     *--------------------------------------------------------------------------
2518:     PROTECTED PROCEDURE ConfigurarCamposCaixaLivre()
2519:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre", "Label")
2520:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre
2521:             .Top        = 117
2522:             .Left       = 67
2523:             .Width      = 336
2524:             .Height     = 216
2525:             .FontBold   = .T.
2526:             .FontItalic = .F.
2527:             .FontName   = "Tahoma"
2528:             .FontSize   = 60
2529:             .WordWrap   = .T.
2530:             .Alignment  = 2
2531:             .BackStyle  = 0
2532:             .Caption    = "CAIXA LIVRE"
2533:             .ForeColor  = RGB(255, 128, 64)
2534:             .Visible    = .T.
2535:         ENDWITH
2536: 
2537:         THIS.cnt_4c_CaixaLivre.AddObject("lbl_4c_CaixaLivre2", "Label")
2538:         WITH THIS.cnt_4c_CaixaLivre.lbl_4c_CaixaLivre2
2539:             .Top        = 120
2540:             .Left       = 64
2541:             .Width      = 336
2542:             .Height     = 216
2543:             .FontBold   = .T.
2544:             .FontItalic = .F.
2545:             .FontName   = "Tahoma"
2546:             .FontSize   = 60
2547:             .WordWrap   = .T.
2548:             .Alignment  = 2
2549:             .BackStyle  = 0
2550:             .Caption    = "CAIXA LIVRE"
2551:             .ForeColor  = RGB(0, 64, 183)
2552:             .Visible    = .T.
2553:         ENDWITH
2554:     ENDPROC
2555: 
2556:     *--------------------------------------------------------------------------
2557:     * ConfigurarCamposCancelaItem - conteudo do painel de cancelamento de item
2558:     * (cnt_4c_CancelaItem, container oculto criado na Fase 3 - acionado por
2559:     * cmd_4c_Apaga/cmd_4c_Excluir nas Fases 7-8). Mostra o item, produto,
2560:     * codigo de barras e descricao do item a cancelar; ok confirma e
2561:     * CancelaDisp desiste.
2562:     * Original (dump slim.txt, SIGMVITN.CancelaItem.*):
2563:     *   Label1 "CANCELAMENTO DE ITEM" Alignment=2 FontSize=10 Height=19 Left=1
2564:     *     Top=2 Width=467 ForeColor=255,255,255 BackColor=90,90,90

*-- Linhas 2581 a 2610:
2581:         loc_cIcones = gc_4c_CaminhoIcones
2582:         loc_oCnt    = THIS.cnt_4c_CancelaItem
2583: 
2584:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2585:         WITH loc_oCnt.lbl_4c_Label1
2586:             .Top            = 2
2587:             .Left           = 1
2588:             .Width          = 467
2589:             .Height         = 19
2590:             .FontBold       = .T.
2591:             .FontName       = "Tahoma"
2592:             .FontSize       = 10
2593:             .FontUnderline  = .F.
2594:             .Alignment      = 2
2595:             .BackStyle      = 1
2596:             .Caption        = "CANCELAMENTO DE ITEM"
2597:             .ForeColor      = RGB(255, 255, 255)
2598:             .BackColor      = RGB(90, 90, 90)
2599:             .Visible        = .T.
2600:         ENDWITH
2601: 
2602:         loc_oCnt.AddObject("txt_4c_Produto", "TextBox")
2603:         WITH loc_oCnt.txt_4c_Produto
2604:             .Top           = 56
2605:             .Left          = 78
2606:             .Width         = 105
2607:             .Height        = 23
2608:             .FontBold      = .T.
2609:             .FontName      = "Tahoma"
2610:             .FontSize      = 8

*-- Linhas 2618 a 2677:
2618:             .Visible       = .T.
2619:         ENDWITH
2620: 
2621:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
2622:         WITH loc_oCnt.lbl_4c_Label2
2623:             .Top       = 33
2624:             .Left      = 38
2625:             .Width     = 36
2626:             .Height    = 15
2627:             .AutoSize  = .T.
2628:             .FontBold  = .T.
2629:             .FontName  = "Tahoma"
2630:             .FontSize  = 8
2631:             .BackStyle = 0
2632:             .Caption   = "ITEM :"
2633:             .ForeColor = RGB(90, 90, 90)
2634:             .Visible   = .T.
2635:         ENDWITH
2636: 
2637:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
2638:         WITH loc_oCnt.lbl_4c_Label3
2639:             .Top       = 58
2640:             .Left      = 12
2641:             .Width     = 62
2642:             .Height    = 15
2643:             .AutoSize  = .T.
2644:             .FontBold  = .T.
2645:             .FontName  = "Tahoma"
2646:             .FontSize  = 8
2647:             .BackStyle = 0
2648:             .Caption   = "PRODUTO :"
2649:             .ForeColor = RGB(90, 90, 90)
2650:             .Visible   = .T.
2651:         ENDWITH
2652: 
2653:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
2654:         WITH loc_oCnt.lbl_4c_Label4
2655:             .Top       = 84
2656:             .Left      = 27
2657:             .Width     = 47
2658:             .Height    = 15
2659:             .AutoSize  = .T.
2660:             .FontBold  = .T.
2661:             .FontName  = "Tahoma"
2662:             .FontSize  = 8
2663:             .BackStyle = 0
2664:             .Caption   = "BARRA :"
2665:             .ForeColor = RGB(90, 90, 90)
2666:             .Visible   = .T.
2667:         ENDWITH
2668: 
2669:         loc_oCnt.AddObject("txt_4c_Item", "TextBox")
2670:         WITH loc_oCnt.txt_4c_Item
2671:             .Top           = 31
2672:             .Left          = 78
2673:             .Width         = 31
2674:             .Height        = 23
2675:             .FontBold      = .T.
2676:             .FontName      = "Tahoma"
2677:             .FontSize      = 8

*-- Linhas 2686 a 2695:
2686: 
2687:         loc_oCnt.AddObject("txt_4c_Cbarra", "TextBox")
2688:         WITH loc_oCnt.txt_4c_Cbarra
2689:             .Top           = 81
2690:             .Left          = 78
2691:             .Width         = 79
2692:             .Height        = 23
2693:             .FontBold      = .T.
2694:             .FontName      = "Tahoma"
2695:             .FontSize      = 8

*-- Linhas 2704 a 2776:
2704: 
2705:         loc_oCnt.AddObject("txt_4c__dpro", "TextBox")
2706:         WITH loc_oCnt.txt_4c__dpro
2707:             .Top           = 56
2708:             .Left          = 183
2709:             .Width         = 281
2710:             .Height        = 23
2711:             .FontBold      = .T.
2712:             .FontName      = "Tahoma"
2713:             .FontSize      = 8
2714:             .SpecialEffect = 1
2715:             .ForeColor     = RGB(90, 90, 90)
2716:             .BackColor     = RGB(255, 255, 185)
2717:             .Value         = ""
2718:             .Visible       = .T.
2719:         ENDWITH
2720: 
2721:         loc_oCnt.AddObject("cmd_4c_Ok", "CommandButton")
2722:         WITH loc_oCnt.cmd_4c_Ok
2723:             .Top         = 89
2724:             .Left        = 368
2725:             .Width       = 45
2726:             .Height      = 45
2727:             .FontBold    = .T.
2728:             .FontItalic  = .T.
2729:             .FontName    = "Comic Sans MS"
2730:             .FontSize    = 8
2731:             .Picture     = loc_cIcones + "mouse4.ico"
2732:             .Cancel      = .F.
2733:             .Caption     = ""
2734:             .ToolTipText = "Confirmar"
2735:             .ForeColor   = RGB(90, 90, 90)
2736:             .BackColor   = RGB(255, 255, 255)
2737:             .Themes      = .F.
2738:             .Visible     = .T.
2739:         ENDWITH
2740: 
2741:         loc_oCnt.AddObject("cmd_4c_CancelaDisp", "CommandButton")
2742:         WITH loc_oCnt.cmd_4c_CancelaDisp
2743:             .Top         = 89
2744:             .Left        = 414
2745:             .Width       = 45
2746:             .Height      = 45
2747:             .FontBold    = .T.
2748:             .FontItalic  = .T.
2749:             .FontName    = "Comic Sans MS"
2750:             .FontSize    = 8
2751:             .Picture     = loc_cIcones + "shut down.ico"
2752:             .Cancel      = .T.
2753:             .Caption     = ""
2754:             .ToolTipText = "Cancelar"
2755:             .ForeColor   = RGB(90, 90, 90)
2756:             .BackColor   = RGB(255, 255, 255)
2757:             .Themes      = .F.
2758:             .Visible     = .T.
2759:         ENDWITH
2760:     ENDPROC
2761: 
2762:     *--------------------------------------------------------------------------
2763:     * ConfigurarCamposConsulta - conteudo do painel de consulta de preco
2764:     * (cnt_4c__Consulta, container oculto - acionado por cmd_4c_VerPreco nas
2765:     * Fases 7-8). O usuario digita o codigo do produto, confirma e a tela
2766:     * mostra descricao + preco em cnt_4c__Resultado.
2767:     * Colisao de nome no mapeamento.json: Say1 ("Preco Unitario") e Label1
2768:     * ("Consulta Preco do Produto") sao FILHOS DIRETOS do mesmo container e o
2769:     * gerador automatico mapeou os dois para "lbl_4c_Label1" (colide com AS
2770:     * DUAS pattern SayN/LabelN -> LabelN). Resolvido aqui com lbl_4c_Say1 para
2771:     * o primeiro, lbl_4c_Label1 (nome do proprio legado) para o segundo.
2772:     * Original (dump slim.txt, SIGMVITN.Cnt_Consulta.*):
2773:     *   Say1 "Pre?o Unit?rio" FontSize=25 Left=34 Top=277 ForeColor=90,90,90
2774:     *   Cnt_Produto (Top=62 Left=7 W=361 H=64 BackStyle=1 BorderWidth=1
2775:     *     SpecialEffect=2 BackColor=255,255,255):
2776:     *       Get_Produto Format="K!" InputMask=13x"!" FontSize=15 Height=30

*-- Linhas 2792 a 2930:
2792:         loc_cIcones = gc_4c_CaminhoIcones
2793:         loc_oCnt    = THIS.cnt_4c__Consulta
2794: 
2795:         loc_oCnt.AddObject("lbl_4c_Say1", "Label")
2796:         WITH loc_oCnt.lbl_4c_Say1
2797:             .Top       = 277
2798:             .Left      = 34
2799:             .FontBold  = .T.
2800:             .FontName  = "Tahoma"
2801:             .FontSize  = 25
2802:             .Caption   = "Pre" + CHR(231) + "o Unit" + CHR(225) + "rio"
2803:             .ForeColor = RGB(90, 90, 90)
2804:             .Visible   = .T.
2805:         ENDWITH
2806: 
2807:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
2808:         loc_oSub = loc_oCnt.cnt_4c__Produto
2809:         WITH loc_oSub
2810:             .Top           = 62
2811:             .Left          = 7
2812:             .Width         = 361
2813:             .Height        = 64
2814:             .BackStyle     = 1
2815:             .BorderWidth   = 1
2816:             .SpecialEffect = 2
2817:             .BackColor     = RGB(255, 255, 255)
2818:             .Visible       = .T.
2819:         ENDWITH
2820: 
2821:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
2822:         WITH loc_oSub.txt_4c_Produto
2823:             .Top       = 28
2824:             .Left      = 39
2825:             .Width     = 178
2826:             .Height    = 30
2827:             .FontBold  = .T.
2828:             .FontName  = "Tahoma"
2829:             .FontSize  = 15
2830:             .Format    = "K!"
2831:             .InputMask = "!!!!!!!!!!!!!"
2832:             .MaxLength = 13
2833:             .Value     = ""
2834:             .Visible   = .T.
2835:         ENDWITH
2836: 
2837:         loc_oSub.AddObject("lbl_4c_Label7", "Label")
2838:         WITH loc_oSub.lbl_4c_Label7
2839:             .Top       = 4
2840:             .Left      = 40
2841:             .FontBold  = .T.
2842:             .FontName  = "Tahoma"
2843:             .FontSize  = 15
2844:             .Caption   = "Produto"
2845:             .ForeColor = RGB(90, 90, 90)
2846:             .Visible   = .T.
2847:         ENDWITH
2848: 
2849:         loc_oCnt.AddObject("cnt_4c__Resultado", "Container")
2850:         loc_oSub = loc_oCnt.cnt_4c__Resultado
2851:         WITH loc_oSub
2852:             .Top           = 142
2853:             .Left          = 7
2854:             .Width         = 361
2855:             .Height        = 123
2856:             .BackStyle     = 1
2857:             .BorderWidth   = 2
2858:             .SpecialEffect = 2
2859:             .BackColor     = RGB(255, 255, 255)
2860:             .Visible       = .T.
2861:         ENDWITH
2862: 
2863:         loc_oSub.AddObject("lbl_4c_Mensage1", "Label")
2864:         WITH loc_oSub.lbl_4c_Mensage1
2865:             .Top       = 6
2866:             .Left      = 4
2867:             .Width     = 353
2868:             .Height    = 31
2869:             .FontBold  = .T.
2870:             .FontName  = "Tahoma"
2871:             .FontSize  = 14
2872:             .BackStyle = 0
2873:             .Caption   = ""
2874:             .ForeColor = RGB(90, 90, 90)
2875:             .Visible   = .T.
2876:         ENDWITH
2877: 
2878:         loc_oSub.AddObject("lbl_4c_Mensage2", "Label")
2879:         WITH loc_oSub.lbl_4c_Mensage2
2880:             .Top       = 49
2881:             .Left      = 4
2882:             .Width     = 353
2883:             .Height    = 64
2884:             .FontBold  = .T.
2885:             .FontName  = "Tahoma"
2886:             .FontSize  = 16
2887:             .WordWrap  = .T.
2888:             .BackStyle = 0
2889:             .Caption   = ""
2890:             .ForeColor = RGB(90, 90, 90)
2891:             .Visible   = .T.
2892:         ENDWITH
2893: 
2894:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
2895:         WITH loc_oCnt.lbl_4c_Label1
2896:             .Top      = 14
2897:             .Left     = 32
2898:             .Width    = 281
2899:             .Height   = 27
2900:             .AutoSize = .T.
2901:             .FontBold = .T.
2902:             .FontItalic = .F.
2903:             .FontName = "Tahoma"
2904:             .FontSize = 16
2905:             .BackStyle = 0
2906:             .Caption  = "Consulta Pre" + CHR(231) + "o do Produto"
2907:             .ForeColor = RGB(90, 90, 90)
2908:             .Visible  = .T.
2909:         ENDWITH
2910: 
2911:         loc_oCnt.AddObject("cmd_4c_Command1", "CommandButton")
2912:         WITH loc_oCnt.cmd_4c_Command1
2913:             .Top     = 399
2914:             .Left    = 227
2915:             .Width   = 91
2916:             .Height  = 39
2917:             .Cancel  = .T.
2918:             .Caption = "Sair"
2919:             .Visible = .T.
2920:         ENDWITH
2921: 
2922:         loc_oCnt.AddObject("txt_4c_Unit", "TextBox")
2923:         WITH loc_oCnt.txt_4c_Unit
2924:             .Top           = 318
2925:             .Left          = 37
2926:             .Width         = 249
2927:             .Height        = 46
2928:             .FontBold      = .T.
2929:             .FontName      = "Tahoma"
2930:             .FontSize      = 23

*-- Linhas 2936 a 2957:
2936:             .BackColor     = RGB(255, 255, 255)
2937:             .BorderColor   = RGB(100, 100, 100)
2938:             .Visible       = .T.
2939:         ENDWITH
2940: 
2941:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
2942:         WITH loc_oCnt.cmd_4c_Proximo
2943:             .Top           = 319
2944:             .Left          = 319
2945:             .Width         = 45
2946:             .Height        = 45
2947:             .FontName      = "Verdana"
2948:             .FontSize      = 8
2949:             .Picture       = loc_cIcones + "b_arrow2.bmp"
2950:             .Caption       = ""
2951:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
2952:             .SpecialEffect = 0
2953:             .ForeColor     = RGB(36, 84, 155)
2954:             .BackColor     = RGB(255, 255, 255)
2955:             .Themes        = .F.
2956:             .Visible       = .T.
2957:         ENDWITH

*-- Linhas 2964 a 2974:
2964:     * item.
2965:     * Colisao de nome no mapeamento.json: CntItem tem DOIS "Say8" - um dentro
2966:     * de Cnt_Produto ("Quantidade") e outro filho direto do container
2967:     * ("TOTAL") - ambos mapeados para "lbl_4c_Label8". Resolvido aqui com
2968:     * lbl_4c_Label8 para o de dentro de Cnt_Produto (unico na sua sub-arvore)
2969:     * e lbl_4c_Total (nome descritivo) para o filho direto do container.
2970:     * Original (dump slim.txt, SIGMVITN.CntItem.*):
2971:     *   Get_total Alignment=3 Value=0 FontSize=22 InputMask="9,999,999.99"
2972:     *     Height=46 Left=62 Top=369 Width=249 BackColor=255,255,255
2973:     *   Cnt_Produto (Top=8 Left=7 W=360 H=92 BackStyle=1 BorderWidth=1
2974:     *     SpecialEffect=2 BackColor=255,255,255):

*-- Linhas 3017 a 3026:
3017: 
3018:         loc_oCnt.AddObject("txt_4c_Total", "TextBox")
3019:         WITH loc_oCnt.txt_4c_Total
3020:             .Top           = 369
3021:             .Left          = 62
3022:             .Width         = 249
3023:             .Height        = 46
3024:             .FontBold      = .T.
3025:             .FontName      = "Verdana"
3026:             .FontSize      = 22

*-- Linhas 3036 a 3058:
3036:         loc_oCnt.AddObject("cnt_4c__Produto", "Container")
3037:         loc_oSub = loc_oCnt.cnt_4c__Produto
3038:         WITH loc_oSub
3039:             .Top           = 8
3040:             .Left          = 7
3041:             .Width         = 360
3042:             .Height        = 92
3043:             .BackStyle     = 1
3044:             .BorderWidth   = 1
3045:             .SpecialEffect = 2
3046:             .BackColor     = RGB(255, 255, 255)
3047:             .Visible       = .T.
3048:         ENDWITH
3049: 
3050:         loc_oSub.AddObject("txt_4c_Produto", "TextBox")
3051:         WITH loc_oSub.txt_4c_Produto
3052:             .Top       = 26
3053:             .Left      = 24
3054:             .Width     = 178
3055:             .Height    = 30
3056:             .FontBold  = .T.
3057:             .FontName  = "Tahoma"
3058:             .FontSize  = 15

*-- Linhas 3066 a 3127:
3066: 
3067:         loc_oSub.AddObject("txt_4c_Qtds", "TextBox")
3068:         WITH loc_oSub.txt_4c_Qtds
3069:             .Top       = 26
3070:             .Left      = 203
3071:             .Width     = 104
3072:             .Height    = 30
3073:             .FontBold  = .T.
3074:             .FontName  = "Tahoma"
3075:             .FontSize  = 15
3076:             .Alignment = 3
3077:             .Value     = 0
3078:             .InputMask = "999.999"
3079:             .ForeColor = RGB(90, 90, 90)
3080:             .Visible   = .T.
3081:         ENDWITH
3082: 
3083:         loc_oSub.AddObject("lbl_4c_Label7", "Label")
3084:         WITH loc_oSub.lbl_4c_Label7
3085:             .Top       = 4
3086:             .Left      = 25
3087:             .FontBold  = .T.
3088:             .FontName  = "Tahoma"
3089:             .FontSize  = 13
3090:             .Caption   = "Produto"
3091:             .ForeColor = RGB(90, 90, 90)
3092:             .Visible   = .T.
3093:         ENDWITH
3094: 
3095:         loc_oSub.AddObject("lbl_4c_Label8", "Label")
3096:         WITH loc_oSub.lbl_4c_Label8
3097:             .Top       = 4
3098:             .Left      = 201
3099:             .FontBold  = .T.
3100:             .FontName  = "Tahoma"
3101:             .FontSize  = 13
3102:             .Caption   = "Quantidade"
3103:             .ForeColor = RGB(90, 90, 90)
3104:             .Visible   = .T.
3105:         ENDWITH
3106: 
3107:         *-- CmdEnviaProd: so aparece quando o legado exige confirmacao manual
3108:         *-- do produto identificado por codigo de barras (leitura ambigua) -
3109:         *-- nasce oculto, como no dump, e entra na skip-list de
3110:         *-- TornarControlesVisiveis.
3111:         loc_oSub.AddObject("cmd_4c_CmdEnviaProd", "CommandButton")
3112:         WITH loc_oSub.cmd_4c_CmdEnviaProd
3113:             .Top             = 58
3114:             .Left            = 203
3115:             .Width           = 104
3116:             .Height          = 29
3117:             .FontBold        = .T.
3118:             .FontItalic      = .T.
3119:             .FontName        = "Comic Sans MS"
3120:             .FontSize        = 8
3121:             .Picture         = loc_cIcones + "b_print2.bmp"
3122:             .Caption         = "\<Confirmar"
3123:             .ToolTipText     = "Confirma o Produto Informado"
3124:             .PicturePosition = 1
3125:             .ForeColor       = RGB(90, 90, 90)
3126:             .BackColor       = RGB(255, 255, 255)
3127:             .Themes          = .F.

*-- Linhas 3133 a 3408:
3133:         loc_oCnt.AddObject("cnt_4c__Subtotal", "Container")
3134:         loc_oSub = loc_oCnt.cnt_4c__Subtotal
3135:         WITH loc_oSub
3136:             .Top           = 266
3137:             .Left          = 7
3138:             .Width         = 360
3139:             .Height        = 46
3140:             .BorderWidth   = 1
3141:             .SpecialEffect = 2
3142:             .BackColor     = RGB(255, 255, 255)
3143:             .Visible       = .T.
3144:         ENDWITH
3145: 
3146:         loc_oSub.AddObject("txt_4c_Valor", "TextBox")
3147:         WITH loc_oSub.txt_4c_Valor
3148:             .Top       = 8
3149:             .Left      = 160
3150:             .Width     = 161
3151:             .Height    = 28
3152:             .FontBold  = .T.
3153:             .FontName  = "Tahoma"
3154:             .FontSize  = 15
3155:             .Alignment = 3
3156:             .Value     = 0
3157:             .InputMask = "9,999,999.99"
3158:             .ForeColor = RGB(90, 90, 90)
3159:             .Visible   = .T.
3160:         ENDWITH
3161: 
3162:         loc_oSub.AddObject("lbl_4c_Label11", "Label")
3163:         WITH loc_oSub.lbl_4c_Label11
3164:             .Top       = 11
3165:             .Left      = 37
3166:             .FontBold  = .T.
3167:             .FontName  = "Tahoma"
3168:             .FontSize  = 13
3169:             .Caption   = "Valor Unit" + CHR(225) + "rio"
3170:             .ForeColor = RGB(90, 90, 90)
3171:             .Visible   = .T.
3172:         ENDWITH
3173: 
3174:         *-- Cnt_Desconto: bloco Original / Desconto / Acrescimo, cada um com
3175:         *-- percentual e valor.
3176:         loc_oCnt.AddObject("cnt_4c__Desconto", "Container")
3177:         loc_oSub = loc_oCnt.cnt_4c__Desconto
3178:         WITH loc_oSub
3179:             .Top           = 106
3180:             .Left          = 7
3181:             .Width         = 360
3182:             .Height        = 154
3183:             .BackStyle     = 1
3184:             .BorderWidth   = 1
3185:             .SpecialEffect = 2
3186:             .BackColor     = RGB(255, 255, 255)
3187:             .Visible       = .T.
3188:         ENDWITH
3189: 
3190:         loc_oSub.AddObject("txt_4c_Unival", "TextBox")
3191:         WITH loc_oSub.txt_4c_Unival
3192:             .Top       = 4
3193:             .Left      = 160
3194:             .Width     = 161
3195:             .Height    = 28
3196:             .FontBold  = .T.
3197:             .FontName  = "Tahoma"
3198:             .FontSize  = 15
3199:             .Alignment = 3
3200:             .Value     = 0
3201:             .InputMask = "9999,999.99"
3202:             .ForeColor = RGB(90, 90, 90)
3203:             .Visible   = .T.
3204:         ENDWITH
3205: 
3206:         loc_oSub.AddObject("lbl_4c_Label12", "Label")
3207:         WITH loc_oSub.lbl_4c_Label12
3208:             .Top       = 6
3209:             .Left      = 87
3210:             .FontBold  = .T.
3211:             .FontName  = "Tahoma"
3212:             .FontSize  = 13
3213:             .Caption   = "Original"
3214:             .ForeColor = RGB(90, 90, 90)
3215:             .Visible   = .T.
3216:         ENDWITH
3217: 
3218:         loc_oSub.AddObject("txt_4c_Pvaldesc", "TextBox")
3219:         WITH loc_oSub.txt_4c_Pvaldesc
3220:             .Top       = 33
3221:             .Left      = 160
3222:             .Width     = 161
3223:             .Height    = 28
3224:             .FontBold  = .T.
3225:             .FontName  = "Tahoma"
3226:             .FontSize  = 15
3227:             .Alignment = 3
3228:             .Value     = 0
3229:             .InputMask = "99.99"
3230:             .ForeColor = RGB(90, 90, 90)
3231:             .Visible   = .T.
3232:         ENDWITH
3233: 
3234:         loc_oSub.AddObject("lbl_4c_Label1", "Label")
3235:         WITH loc_oSub.lbl_4c_Label1
3236:             .Top       = 40
3237:             .Left      = 324
3238:             .Width     = 26
3239:             .Height    = 16
3240:             .AutoSize  = .T.
3241:             .FontBold  = .T.
3242:             .FontName  = "Tahoma"
3243:             .BackStyle = 0
3244:             .Caption   = "(%)"
3245:             .ForeColor = RGB(90, 90, 90)
3246:             .Visible   = .T.
3247:         ENDWITH
3248: 
3249:         loc_oSub.AddObject("txt_4c_Valdesc", "TextBox")
3250:         WITH loc_oSub.txt_4c_Valdesc
3251:             .Top       = 62
3252:             .Left      = 160
3253:             .Width     = 161
3254:             .Height    = 28
3255:             .FontBold  = .T.
3256:             .FontName  = "Tahoma"
3257:             .FontSize  = 15
3258:             .Alignment = 3
3259:             .Value     = 0
3260:             .InputMask = "999,999.99"
3261:             .ForeColor = RGB(90, 90, 90)
3262:             .Visible   = .T.
3263:         ENDWITH
3264: 
3265:         loc_oSub.AddObject("lbl_4c_Label15", "Label")
3266:         WITH loc_oSub.lbl_4c_Label15
3267:             .Top       = 36
3268:             .Left      = 73
3269:             .FontBold  = .T.
3270:             .FontName  = "Tahoma"
3271:             .FontSize  = 13
3272:             .Caption   = "Desconto"
3273:             .ForeColor = RGB(90, 90, 90)
3274:             .Visible   = .T.
3275:         ENDWITH
3276: 
3277:         loc_oSub.AddObject("lbl_4c_Label2", "Label")
3278:         WITH loc_oSub.lbl_4c_Label2
3279:             .Top       = 67
3280:             .Left      = 324
3281:             .Width     = 20
3282:             .Height    = 16
3283:             .AutoSize  = .T.
3284:             .FontBold  = .T.
3285:             .FontName  = "Tahoma"
3286:             .BackStyle = 0
3287:             .Caption   = "($)"
3288:             .ForeColor = RGB(90, 90, 90)
3289:             .Visible   = .T.
3290:         ENDWITH
3291: 
3292:         loc_oSub.AddObject("txt_4c__pValAcre", "TextBox")
3293:         WITH loc_oSub.txt_4c__pValAcre
3294:             .Top       = 91
3295:             .Left      = 160
3296:             .Width     = 161
3297:             .Height    = 28
3298:             .FontBold  = .T.
3299:             .FontName  = "Tahoma"
3300:             .FontSize  = 15
3301:             .Alignment = 3
3302:             .Value     = 0
3303:             .InputMask = "99.99"
3304:             .ForeColor = RGB(90, 90, 90)
3305:             .Visible   = .T.
3306:         ENDWITH
3307: 
3308:         loc_oSub.AddObject("lbl_4c_Label4", "Label")
3309:         WITH loc_oSub.lbl_4c_Label4
3310:             .Top       = 97
3311:             .Left      = 324
3312:             .Width     = 26
3313:             .Height    = 16
3314:             .AutoSize  = .T.
3315:             .FontBold  = .T.
3316:             .FontName  = "Tahoma"
3317:             .BackStyle = 0
3318:             .Caption   = "(%)"
3319:             .ForeColor = RGB(90, 90, 90)
3320:             .Visible   = .T.
3321:         ENDWITH
3322: 
3323:         loc_oSub.AddObject("txt_4c_ValAcre", "TextBox")
3324:         WITH loc_oSub.txt_4c_ValAcre
3325:             .Top       = 120
3326:             .Left      = 160
3327:             .Width     = 161
3328:             .Height    = 28
3329:             .FontBold  = .T.
3330:             .FontName  = "Tahoma"
3331:             .FontSize  = 15
3332:             .Alignment = 3
3333:             .Value     = 0
3334:             .InputMask = "999,999.99"
3335:             .ForeColor = RGB(90, 90, 90)
3336:             .Visible   = .T.
3337:         ENDWITH
3338: 
3339:         loc_oSub.AddObject("lbl_4c_Say1", "Label")
3340:         WITH loc_oSub.lbl_4c_Say1
3341:             .Top       = 94
3342:             .Left      = 66
3343:             .FontBold  = .T.
3344:             .FontName  = "Tahoma"
3345:             .FontSize  = 13
3346:             .Caption   = "Acr" + CHR(233) + "scimo"
3347:             .ForeColor = RGB(90, 90, 90)
3348:             .Visible   = .T.
3349:         ENDWITH
3350: 
3351:         loc_oSub.AddObject("lbl_4c_Label3", "Label")
3352:         WITH loc_oSub.lbl_4c_Label3
3353:             .Top       = 126
3354:             .Left      = 324
3355:             .Width     = 20
3356:             .Height    = 16
3357:             .AutoSize  = .T.
3358:             .FontBold  = .T.
3359:             .FontName  = "Tahoma"
3360:             .BackStyle = 0
3361:             .Caption   = "($)"
3362:             .ForeColor = RGB(90, 90, 90)
3363:             .Visible   = .T.
3364:         ENDWITH
3365: 
3366:         *-- Proximo: avanca para a tela de pagamento.
3367:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3368:         WITH loc_oCnt.cmd_4c_Proximo
3369:             .Top           = 370
3370:             .Left          = 323
3371:             .Width         = 45
3372:             .Height        = 45
3373:             .FontName      = "Verdana"
3374:             .FontSize      = 8
3375:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3376:             .Caption       = ""
3377:             .ToolTipText   = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3378:             .SpecialEffect = 0
3379:             .ForeColor     = RGB(36, 84, 155)
3380:             .BackColor     = RGB(255, 255, 255)
3381:             .Themes        = .F.
3382:             .Visible       = .T.
3383:         ENDWITH
3384: 
3385:         *-- "TOTAL" (filho direto de CntItem - ver nota da colisao no
3386:         *-- cabecalho deste metodo).
3387:         loc_oCnt.AddObject("lbl_4c_Total", "Label")
3388:         WITH loc_oCnt.lbl_4c_Total
3389:             .Top       = 330
3390:             .Left      = 61
3391:             .FontBold  = .T.
3392:             .FontName  = "Tahoma"
3393:             .FontSize  = 25
3394:             .Caption   = "TOTAL"
3395:             .ForeColor = RGB(90, 90, 90)
3396:             .Visible   = .T.
3397:         ENDWITH
3398:     ENDPROC
3399: 
3400:     *--------------------------------------------------------------------------
3401:     * ConfigurarCamposFinanc - conteudo do painel de crediario / codigos de
3402:     * barras do carne (cnt_4c_Financ, container oculto - acionado por
3403:     * cmd_4c_Financia nas Fases 7-8). A grade e os tres botoes de acao
3404:     * (cnt_4c__GrdBarra) ja foram criados em ConfigurarGradesOperacao; aqui vao
3405:     * o restante: a faixa divisoria, o par de campos de codigo de barras e o
3406:     * total do carne.
3407:     * Original (dump slim.txt, SIGMVITN.CntFinanc.*):
3408:     *   Shape4 Top=349 Left=0 H=3 W=370 SpecialEffect=0

*-- Linhas 3435 a 3581:
3435: 
3436:         loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
3437:         WITH loc_oCnt.shp_4c_Shape4
3438:             .Top           = 349
3439:             .Left          = 0
3440:             .Width         = 370
3441:             .Height        = 3
3442:             .SpecialEffect = 0
3443:             .Visible       = .T.
3444:         ENDWITH
3445: 
3446:         loc_oCnt.AddObject("cnt_4c__Barras", "Container")
3447:         loc_oSub = loc_oCnt.cnt_4c__Barras
3448:         WITH loc_oSub
3449:             .Top           = 57
3450:             .Left          = 4
3451:             .Width         = 368
3452:             .Height        = 125
3453:             .BackStyle     = 1
3454:             .BorderWidth   = 1
3455:             .SpecialEffect = 2
3456:             .BackColor     = RGB(255, 255, 255)
3457:             .Visible       = .T.
3458:         ENDWITH
3459: 
3460:         loc_oSub.AddObject("img_4c_Image1", "Image")
3461:         WITH loc_oSub.img_4c_Image1
3462:             .Top       = 34
3463:             .Left      = 14
3464:             .Width     = 25
3465:             .Height    = 25
3466:             .Picture   = loc_cIcones + "b_arrow2.bmp"
3467:             .BackStyle = 0
3468:             .Visible   = .T.
3469:         ENDWITH
3470: 
3471:         loc_oSub.AddObject("img_4c_Image2", "Image")
3472:         WITH loc_oSub.img_4c_Image2
3473:             .Top       = 94
3474:             .Left      = 12
3475:             .Width     = 25
3476:             .Height    = 25
3477:             .Picture   = loc_cIcones + "b_arrow2.bmp"
3478:             .BackStyle = 0
3479:             .Visible   = .T.
3480:         ENDWITH
3481: 
3482:         loc_oSub.AddObject("lbl_4c_Label2", "Label")
3483:         WITH loc_oSub.lbl_4c_Label2
3484:             .Top      = 6
3485:             .Left     = 39
3486:             .FontBold = .T.
3487:             .FontSize = 15
3488:             .Caption  = "Primeiro C" + CHR(243) + "digo de Barras"
3489:             .Visible  = .T.
3490:         ENDWITH
3491: 
3492:         loc_oSub.AddObject("lbl_4c_Label3", "Label")
3493:         WITH loc_oSub.lbl_4c_Label3
3494:             .Top      = 65
3495:             .Left     = 39
3496:             .FontBold = .T.
3497:             .FontSize = 15
3498:             .Caption  = "Segundo C" + CHR(243) + "digo de Barras"
3499:             .Visible  = .T.
3500:         ENDWITH
3501: 
3502:         loc_oSub.AddObject("txt_4c_Barra_1", "TextBox")
3503:         WITH loc_oSub.txt_4c_Barra_1
3504:             .Top               = 31
3505:             .Left              = 38
3506:             .Width             = 240
3507:             .Height            = 30
3508:             .FontBold          = .T.
3509:             .FontSize          = 15
3510:             .SpecialEffect     = 1
3511:             .DisabledBackColor = RGB(128, 128, 128)
3512:             .Value             = ""
3513:             .Visible           = .T.
3514:         ENDWITH
3515: 
3516:         loc_oSub.AddObject("txt_4c_Barra_2", "TextBox")
3517:         WITH loc_oSub.txt_4c_Barra_2
3518:             .Top               = 91
3519:             .Left              = 38
3520:             .Width             = 240
3521:             .Height            = 30
3522:             .FontBold          = .T.
3523:             .FontSize          = 15
3524:             .SpecialEffect     = 1
3525:             .DisabledBackColor = RGB(128, 128, 128)
3526:             .Value             = ""
3527:             .Visible           = .T.
3528:         ENDWITH
3529: 
3530:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
3531:         WITH loc_oCnt.cmd_4c_Proximo
3532:             .Top           = 353
3533:             .Left          = 320
3534:             .Width         = 45
3535:             .Height        = 45
3536:             .FontName      = "Verdana"
3537:             .FontSize      = 8
3538:             .Picture       = loc_cIcones + "b_arrow2.bmp"
3539:             .Caption       = ""
3540:             .SpecialEffect = 0
3541:             .ForeColor     = RGB(36, 84, 155)
3542:             .BackColor     = RGB(255, 255, 255)
3543:             .Themes        = .F.
3544:             .Visible       = .T.
3545:         ENDWITH
3546: 
3547:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
3548:         WITH loc_oCnt.lbl_4c_Label1
3549:             .Top       = 11
3550:             .Left      = 134
3551:             .Width     = 97
3552:             .Height    = 27
3553:             .AutoSize  = .T.
3554:             .FontBold  = .T.
3555:             .FontName  = "Tahoma"
3556:             .FontSize  = 16
3557:             .BackStyle = 0
3558:             .Caption   = "Credi" + CHR(225) + "rio"
3559:             .ForeColor = RGB(90, 90, 90)
3560:             .Visible   = .T.
3561:         ENDWITH
3562: 
3563:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
3564:         WITH loc_oCnt.lbl_4c_Label2
3565:             .Top      = 360
3566:             .Left     = 8
3567:             .FontBold = .T.
3568:             .FontSize = 20
3569:             .Caption  = "Total"
3570:             .Visible  = .T.
3571:         ENDWITH
3572: 
3573:         loc_oCnt.AddObject("txt_4c_Total", "TextBox")
3574:         WITH loc_oCnt.txt_4c_Total
3575:             .Top           = 354
3576:             .Left          = 92
3577:             .Width         = 218
3578:             .Height        = 45
3579:             .FontBold      = .T.
3580:             .FontSize      = 20
3581:             .Alignment     = 3

*-- Linhas 3607 a 3682:
3607:     *--------------------------------------------------------------------------
3608:     * ConfigurarCamposCreditoPendencia - labels/botoes remanescentes de
3609:     * Cnt_Credito e Cnt_Pendencia. As grades (grd_4c_Devolucao/grd_4c_SubNiveis)
3610:     * e o cmd_4c_BotPend ja foram criados na Fase 4
3611:     * (ConfigurarGradesOperacao) - aqui so falta o botao "Proximo" (navegacao
3612:     * ENTER) e o label de instrucao de cada container.
3613:     *--------------------------------------------------------------------------
3614:     PROTECTED PROCEDURE ConfigurarCamposCreditoPendencia()
3615:         LOCAL loc_cIcones
3616:         loc_cIcones = gc_4c_CaminhoIcones
3617: 
3618:         THIS.cnt_4c__Credito.AddObject("cmd_4c_Proximo", "CommandButton")
3619:         WITH THIS.cnt_4c__Credito.cmd_4c_Proximo
3620:             .Top         = 394
3621:             .Left        = 325
3622:             .Width       = 45
3623:             .Height      = 45
3624:             .FontName    = "Verdana"
3625:             .FontSize    = 8
3626:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3627:             .Caption     = ""
3628:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3629:             .ForeColor   = RGB(36, 84, 155)
3630:             .BackColor   = RGB(255, 255, 255)
3631:             .Themes      = .F.
3632:             .Visible     = .T.
3633:         ENDWITH
3634: 
3635:         THIS.cnt_4c__Credito.AddObject("lbl_4c_Label2", "Label")
3636:         WITH THIS.cnt_4c__Credito.lbl_4c_Label2
3637:             .Top       = 422
3638:             .Left      = 194
3639:             .Width     = 135
3640:             .Height    = 16
3641:             .AutoSize  = .T.
3642:             .FontBold  = .T.
3643:             .FontName  = "Tahoma"
3644:             .BackStyle = 0
3645:             .Caption   = "[ENTER] Muda de Tela"
3646:             .ForeColor = RGB(90, 90, 90)
3647:             .Visible   = .T.
3648:         ENDWITH
3649: 
3650:         THIS.cnt_4c__Pendencia.AddObject("cmd_4c_Proximo", "CommandButton")
3651:         WITH THIS.cnt_4c__Pendencia.cmd_4c_Proximo
3652:             .Top         = 382
3653:             .Left        = 311
3654:             .Width       = 45
3655:             .Height      = 45
3656:             .FontName    = "Verdana"
3657:             .FontSize    = 8
3658:             .Picture     = loc_cIcones + "b_arrow2.bmp"
3659:             .Caption     = ""
3660:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
3661:             .ForeColor   = RGB(36, 84, 155)
3662:             .BackColor   = RGB(255, 255, 255)
3663:             .Themes      = .F.
3664:             .Visible     = .T.
3665:         ENDWITH
3666: 
3667:         THIS.cnt_4c__Pendencia.AddObject("lbl_4c_Label2", "Label")
3668:         WITH THIS.cnt_4c__Pendencia.lbl_4c_Label2
3669:             .Top       = 413
3670:             .Left      = 168
3671:             .Width     = 135
3672:             .Height    = 16
3673:             .AutoSize  = .T.
3674:             .FontBold  = .T.
3675:             .FontName  = "Tahoma"
3676:             .BackStyle = 0
3677:             .Caption   = "[ENTER] Muda de Tela"
3678:             .ForeColor = RGB(90, 90, 90)
3679:             .Visible   = .T.
3680:         ENDWITH
3681:     ENDPROC
3682: 

*-- Linhas 3709 a 3818:
3709:         loc_oCnt.AddObject("cnt_4c_Destino", "Container")
3710:         loc_oSub = loc_oCnt.cnt_4c_Destino
3711:         WITH loc_oSub
3712:             .Top           = 168
3713:             .Left          = 2
3714:             .Width         = 371
3715:             .Height        = 94
3716:             .BackStyle     = 1
3717:             .BorderWidth   = 1
3718:             .SpecialEffect = 2
3719:             .TabIndex      = 4
3720:             .BackColor     = RGB(255, 255, 255)
3721:             .Visible       = .T.
3722:         ENDWITH
3723: 
3724:         loc_oSub.AddObject("lbl_4c_Label4", "Label")
3725:         WITH loc_oSub.lbl_4c_Label4
3726:             .Top       = 2
3727:             .Left      = 10
3728:             .Width     = 45
3729:             .Height    = 15
3730:             .FontBold  = .T.
3731:             .FontName  = "Tahoma"
3732:             .FontSize  = 8
3733:             .BackStyle = 0
3734:             .Caption   = "Destino"
3735:             .ForeColor = RGB(90, 90, 90)
3736:             .TabIndex  = 26
3737:             .Visible   = .T.
3738:         ENDWITH
3739: 
3740:         loc_oSub.AddObject("lin_4c_Line1", "Line")
3741:         WITH loc_oSub.lin_4c_Line1
3742:             .Top         = 17
3743:             .Left        = 10
3744:             .Width       = 323
3745:             .Height      = 0
3746:             .BorderWidth = 2
3747:             .Visible     = .T.
3748:         ENDWITH
3749: 
3750:         loc_oSub.AddObject("lbl_4c_Label8", "Label")
3751:         WITH loc_oSub.lbl_4c_Label8
3752:             .Top       = 18
3753:             .Left      = 10
3754:             .FontBold  = .T.
3755:             .FontName  = "Tahoma"
3756:             .FontSize  = 8
3757:             .BackStyle = 0
3758:             .Caption   = "Grupo"
3759:             .ForeColor = RGB(90, 90, 90)
3760:             .TabIndex  = 7
3761:             .Visible   = .T.
3762:         ENDWITH
3763: 
3764:         loc_oSub.AddObject("lbl_4c_Label2", "Label")
3765:         WITH loc_oSub.lbl_4c_Label2
3766:             .Top       = 18
3767:             .Left      = 93
3768:             .FontBold  = .F.
3769:             .FontName  = "Tahoma"
3770:             .FontSize  = 8
3771:             .BackStyle = 0
3772:             .Caption   = "Conta"
3773:             .ForeColor = RGB(90, 90, 90)
3774:             .TabIndex  = 8
3775:             .Visible   = .T.
3776:         ENDWITH
3777: 
3778:         loc_oSub.AddObject("lbl_4c__CPF", "Label")
3779:         WITH loc_oSub.lbl_4c__CPF
3780:             .Top       = 18
3781:             .Left      = 176
3782:             .Width     = 56
3783:             .Height    = 15
3784:             .FontBold  = .F.
3785:             .FontName  = "Tahoma"
3786:             .FontSize  = 8
3787:             .BackStyle = 0
3788:             .Caption   = "CPF / CNPJ"
3789:             .ForeColor = RGB(90, 90, 90)
3790:             .TabIndex  = 9
3791:             .Visible   = .T.
3792:         ENDWITH
3793: 
3794:         loc_oSub.AddObject("lbl_4c__dConta", "Label")
3795:         WITH loc_oSub.lbl_4c__dConta
3796:             .Top       = 51
3797:             .Left      = 10
3798:             .Width     = 29
3799:             .Height    = 15
3800:             .FontBold  = .F.
3801:             .FontName  = "Tahoma"
3802:             .FontSize  = 8
3803:             .BackStyle = 0
3804:             .Caption   = "Nome"
3805:             .ForeColor = RGB(90, 90, 90)
3806:             .TabIndex  = 6
3807:             .Visible   = .T.
3808:         ENDWITH
3809: 
3810:         loc_oSub.AddObject("txt_4c_Grupo", "TextBox")
3811:         WITH loc_oSub.txt_4c_Grupo
3812:             .Top               = 32
3813:             .Left              = 10
3814:             .Width             = 80
3815:             .Height            = 21
3816:             .FontBold          = .T.
3817:             .FontName          = "Tahoma"
3818:             .Alignment         = 1

*-- Linhas 3827 a 3836:
3827: 
3828:         loc_oSub.AddObject("txt_4c_Conta", "TextBox")
3829:         WITH loc_oSub.txt_4c_Conta
3830:             .Top               = 32
3831:             .Left              = 93
3832:             .Width             = 80
3833:             .Height            = 21
3834:             .FontName          = "Tahoma"
3835:             .Margin            = 0
3836:             .SpecialEffect     = 1

*-- Linhas 3843 a 3852:
3843: 
3844:         loc_oSub.AddObject("txt_4c_Dconta", "TextBox")
3845:         WITH loc_oSub.txt_4c_Dconta
3846:             .Top               = 65
3847:             .Left              = 10
3848:             .Width             = 304
3849:             .Height            = 21
3850:             .FontName          = "Tahoma"
3851:             .Margin            = 0
3852:             .SpecialEffect     = 1

*-- Linhas 3859 a 3892:
3859: 
3860:         loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
3861:         WITH loc_oSub.txt_4c_Cpf
3862:             .Top               = 32
3863:             .Left              = 176
3864:             .Width             = 139
3865:             .Height            = 21
3866:             .FontName          = "Tahoma"
3867:             .Margin            = 0
3868:             .SpecialEffect     = 1
3869:             .TabIndex          = 3
3870:             .ForeColor         = RGB(90, 90, 90)
3871:             .DisabledBackColor = RGB(255, 255, 255)
3872:             .Value             = ""
3873:             .Visible           = .T.
3874:         ENDWITH
3875: 
3876:         loc_oSub.AddObject("cmd_4c_BtnCadastros", "CommandButton")
3877:         WITH loc_oSub.cmd_4c_BtnCadastros
3878:             .Top           = 56
3879:             .Left          = 325
3880:             .Width         = 34
3881:             .Height        = 32
3882:             .FontName      = "Tahoma"
3883:             .FontSize      = 7
3884:             .Picture       = gc_4c_CaminhoIcones + "binder03.ico"
3885:             .Caption       = ""
3886:             .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
3887:             .SpecialEffect = 2
3888:             .ForeColor     = RGB(90, 90, 90)
3889:             .TabIndex      = 5
3890:             .Visible       = .T.
3891:         ENDWITH
3892: 

*-- Linhas 3901 a 4010:
3901:         loc_oCnt.AddObject("cnt_4c_Responsavel", "Container")
3902:         loc_oSub = loc_oCnt.cnt_4c_Responsavel
3903:         WITH loc_oSub
3904:             .Top           = 356
3905:             .Left          = 2
3906:             .Width         = 371
3907:             .Height        = 94
3908:             .BackStyle     = 1
3909:             .BorderWidth   = 1
3910:             .SpecialEffect = 2
3911:             .TabIndex      = 6
3912:             .BackColor     = RGB(255, 255, 255)
3913:             .Visible       = .T.
3914:         ENDWITH
3915: 
3916:         loc_oSub.AddObject("lbl_4c_label42", "Label")
3917:         WITH loc_oSub.lbl_4c_label42
3918:             .Top       = 2
3919:             .Left      = 10
3920:             .Width     = 74
3921:             .Height    = 15
3922:             .FontBold  = .T.
3923:             .FontName  = "Tahoma"
3924:             .FontSize  = 8
3925:             .BackStyle = 0
3926:             .Caption   = "Respons" + CHR(225) + "vel"
3927:             .ForeColor = RGB(90, 90, 90)
3928:             .TabIndex  = 26
3929:             .Visible   = .T.
3930:         ENDWITH
3931: 
3932:         loc_oSub.AddObject("lin_4c_line12", "Line")
3933:         WITH loc_oSub.lin_4c_line12
3934:             .Top         = 17
3935:             .Left        = 10
3936:             .Width       = 320
3937:             .Height      = 0
3938:             .BorderWidth = 2
3939:             .Visible     = .T.
3940:         ENDWITH
3941: 
3942:         loc_oSub.AddObject("lbl_4c_label82", "Label")
3943:         WITH loc_oSub.lbl_4c_label82
3944:             .Top       = 18
3945:             .Left      = 10
3946:             .FontBold  = .T.
3947:             .FontName  = "Tahoma"
3948:             .FontSize  = 8
3949:             .BackStyle = 0
3950:             .Caption   = "Grupo"
3951:             .ForeColor = RGB(90, 90, 90)
3952:             .TabIndex  = 5
3953:             .Visible   = .T.
3954:         ENDWITH
3955: 
3956:         loc_oSub.AddObject("lbl_4c_label22", "Label")
3957:         WITH loc_oSub.lbl_4c_label22
3958:             .Top       = 18
3959:             .Left      = 93
3960:             .FontBold  = .F.
3961:             .FontName  = "Tahoma"
3962:             .FontSize  = 8
3963:             .BackStyle = 0
3964:             .Caption   = "Conta"
3965:             .ForeColor = RGB(90, 90, 90)
3966:             .TabIndex  = 6
3967:             .Visible   = .T.
3968:         ENDWITH
3969: 
3970:         loc_oSub.AddObject("lbl_4c__cpf2", "Label")
3971:         WITH loc_oSub.lbl_4c__cpf2
3972:             .Top       = 18
3973:             .Left      = 176
3974:             .Width     = 56
3975:             .Height    = 15
3976:             .FontBold  = .F.
3977:             .FontName  = "Tahoma"
3978:             .FontSize  = 8
3979:             .BackStyle = 0
3980:             .Caption   = "CPF / CNPJ"
3981:             .ForeColor = RGB(90, 90, 90)
3982:             .TabIndex  = 7
3983:             .Visible   = .T.
3984:         ENDWITH
3985: 
3986:         loc_oSub.AddObject("lbl_4c__dconta2", "Label")
3987:         WITH loc_oSub.lbl_4c__dconta2
3988:             .Top       = 51
3989:             .Left      = 10
3990:             .Width     = 29
3991:             .Height    = 15
3992:             .FontBold  = .F.
3993:             .FontName  = "Tahoma"
3994:             .FontSize  = 8
3995:             .BackStyle = 0
3996:             .Caption   = "Nome"
3997:             .ForeColor = RGB(90, 90, 90)
3998:             .TabIndex  = 8
3999:             .Visible   = .T.
4000:         ENDWITH
4001: 
4002:         loc_oSub.AddObject("txt_4c_grupo2", "TextBox")
4003:         WITH loc_oSub.txt_4c_grupo2
4004:             .Top               = 32
4005:             .Left              = 10
4006:             .Width             = 80
4007:             .Height            = 21
4008:             .FontBold          = .T.
4009:             .FontName          = "Tahoma"
4010:             .Alignment         = 1

*-- Linhas 4019 a 4028:
4019: 
4020:         loc_oSub.AddObject("txt_4c_conta2", "TextBox")
4021:         WITH loc_oSub.txt_4c_conta2
4022:             .Top               = 32
4023:             .Left              = 93
4024:             .Width             = 80
4025:             .Height            = 21
4026:             .FontName          = "Tahoma"
4027:             .Margin            = 0
4028:             .SpecialEffect     = 1

*-- Linhas 4035 a 4044:
4035: 
4036:         loc_oSub.AddObject("txt_4c_dconta2", "TextBox")
4037:         WITH loc_oSub.txt_4c_dconta2
4038:             .Top               = 65
4039:             .Left              = 10
4040:             .Width             = 305
4041:             .Height            = 21
4042:             .FontName          = "Tahoma"
4043:             .Margin            = 0
4044:             .SpecialEffect     = 1

*-- Linhas 4051 a 4060:
4051: 
4052:         loc_oSub.AddObject("txt_4c_cpf2", "TextBox")
4053:         WITH loc_oSub.txt_4c_cpf2
4054:             .Top               = 32
4055:             .Left              = 176
4056:             .Width             = 139
4057:             .Height            = 21
4058:             .FontName          = "Tahoma"
4059:             .Margin            = 0
4060:             .SpecialEffect     = 1

*-- Linhas 4076 a 4185:
4076:         loc_oCnt.AddObject("cnt_4c_Vendedor", "Container")
4077:         loc_oSub = loc_oCnt.cnt_4c_Vendedor
4078:         WITH loc_oSub
4079:             .Top           = 262
4080:             .Left          = 2
4081:             .Width         = 371
4082:             .Height        = 94
4083:             .BackStyle     = 1
4084:             .BorderWidth   = 1
4085:             .SpecialEffect = 2
4086:             .TabIndex      = 5
4087:             .BackColor     = RGB(255, 255, 255)
4088:             .Visible       = .T.
4089:         ENDWITH
4090: 
4091:         loc_oSub.AddObject("lbl_4c_label43", "Label")
4092:         WITH loc_oSub.lbl_4c_label43
4093:             .Top       = 2
4094:             .Left      = 10
4095:             .Width     = 56
4096:             .Height    = 15
4097:             .FontBold  = .T.
4098:             .FontName  = "Tahoma"
4099:             .FontSize  = 8
4100:             .BackStyle = 0
4101:             .Caption   = "Vendedor"
4102:             .ForeColor = RGB(90, 90, 90)
4103:             .TabIndex  = 26
4104:             .Visible   = .T.
4105:         ENDWITH
4106: 
4107:         loc_oSub.AddObject("lin_4c_line13", "Line")
4108:         WITH loc_oSub.lin_4c_line13
4109:             .Top         = 17
4110:             .Left        = 10
4111:             .Width       = 315
4112:             .Height      = 0
4113:             .BorderWidth = 2
4114:             .Visible     = .T.
4115:         ENDWITH
4116: 
4117:         loc_oSub.AddObject("lbl_4c_label83", "Label")
4118:         WITH loc_oSub.lbl_4c_label83
4119:             .Top       = 18
4120:             .Left      = 10
4121:             .FontBold  = .T.
4122:             .FontName  = "Tahoma"
4123:             .FontSize  = 8
4124:             .BackStyle = 0
4125:             .Caption   = "Grupo"
4126:             .ForeColor = RGB(90, 90, 90)
4127:             .TabIndex  = 9
4128:             .Visible   = .T.
4129:         ENDWITH
4130: 
4131:         loc_oSub.AddObject("lbl_4c_label23", "Label")
4132:         WITH loc_oSub.lbl_4c_label23
4133:             .Top       = 18
4134:             .Left      = 93
4135:             .FontBold  = .F.
4136:             .FontName  = "Tahoma"
4137:             .FontSize  = 8
4138:             .BackStyle = 0
4139:             .Caption   = "Conta"
4140:             .ForeColor = RGB(90, 90, 90)
4141:             .TabIndex  = 8
4142:             .Visible   = .T.
4143:         ENDWITH
4144: 
4145:         loc_oSub.AddObject("lbl_4c__cpf3", "Label")
4146:         WITH loc_oSub.lbl_4c__cpf3
4147:             .Top       = 18
4148:             .Left      = 176
4149:             .Width     = 56
4150:             .Height    = 15
4151:             .FontBold  = .F.
4152:             .FontName  = "Tahoma"
4153:             .FontSize  = 8
4154:             .BackStyle = 0
4155:             .Caption   = "CPF / CNPJ"
4156:             .ForeColor = RGB(90, 90, 90)
4157:             .TabIndex  = 7
4158:             .Visible   = .T.
4159:         ENDWITH
4160: 
4161:         loc_oSub.AddObject("lbl_4c__dconta3", "Label")
4162:         WITH loc_oSub.lbl_4c__dconta3
4163:             .Top       = 51
4164:             .Left      = 10
4165:             .Width     = 29
4166:             .Height    = 15
4167:             .FontBold  = .F.
4168:             .FontName  = "Tahoma"
4169:             .FontSize  = 8
4170:             .BackStyle = 0
4171:             .Caption   = "Nome"
4172:             .ForeColor = RGB(90, 90, 90)
4173:             .TabIndex  = 6
4174:             .Visible   = .T.
4175:         ENDWITH
4176: 
4177:         loc_oSub.AddObject("txt_4c_grupo3", "TextBox")
4178:         WITH loc_oSub.txt_4c_grupo3
4179:             .Top               = 32
4180:             .Left              = 10
4181:             .Width             = 80
4182:             .Height            = 21
4183:             .FontBold          = .T.
4184:             .FontName          = "Tahoma"
4185:             .Alignment         = 1

*-- Linhas 4194 a 4203:
4194: 
4195:         loc_oSub.AddObject("txt_4c_conta3", "TextBox")
4196:         WITH loc_oSub.txt_4c_conta3
4197:             .Top               = 32
4198:             .Left              = 93
4199:             .Width             = 80
4200:             .Height            = 21
4201:             .FontName          = "Tahoma"
4202:             .Margin            = 0
4203:             .SpecialEffect     = 1

*-- Linhas 4210 a 4219:
4210: 
4211:         loc_oSub.AddObject("txt_4c_dconta3", "TextBox")
4212:         WITH loc_oSub.txt_4c_dconta3
4213:             .Top               = 65
4214:             .Left              = 10
4215:             .Width             = 304
4216:             .Height            = 21
4217:             .FontName          = "Tahoma"
4218:             .Margin            = 0
4219:             .SpecialEffect     = 1

*-- Linhas 4226 a 4235:
4226: 
4227:         loc_oSub.AddObject("txt_4c_cpf3", "TextBox")
4228:         WITH loc_oSub.txt_4c_cpf3
4229:             .Top               = 32
4230:             .Left              = 176
4231:             .Width             = 139
4232:             .Height            = 21
4233:             .FontName          = "Tahoma"
4234:             .Margin            = 0
4235:             .SpecialEffect     = 1

*-- Linhas 4251 a 4288:
4251:         loc_oCnt.AddObject("cnt_4c_TabDesconto", "Container")
4252:         loc_oSub = loc_oCnt.cnt_4c_TabDesconto
4253:         WITH loc_oSub
4254:             .Top           = 33
4255:             .Left          = 2
4256:             .Width         = 371
4257:             .Height        = 41
4258:             .BackStyle     = 1
4259:             .BorderWidth   = 1
4260:             .SpecialEffect = 2
4261:             .TabIndex      = 2
4262:             .BackColor     = RGB(255, 255, 255)
4263:             .Visible       = .T.
4264:         ENDWITH
4265: 
4266:         loc_oSub.AddObject("lbl_4c_Label1", "Label")
4267:         WITH loc_oSub.lbl_4c_Label1
4268:             .Top       = 4
4269:             .Left      = 10
4270:             .FontBold  = .T.
4271:             .FontName  = "Tahoma"
4272:             .FontSize  = 8
4273:             .BackStyle = 0
4274:             .Caption   = "Tab. Desconto"
4275:             .ForeColor = RGB(90, 90, 90)
4276:             .TabIndex  = 4
4277:             .Visible   = .T.
4278:         ENDWITH
4279: 
4280:         loc_oSub.AddObject("txt_4c_Tabd", "TextBox")
4281:         WITH loc_oSub.txt_4c_Tabd
4282:             .Top           = 18
4283:             .Left          = 10
4284:             .Width         = 80
4285:             .Height        = 20
4286:             .FontName      = "Tahoma"
4287:             .Margin        = 0
4288:             .SpecialEffect = 1

*-- Linhas 4294 a 4303:
4294: 
4295:         loc_oSub.AddObject("txt_4c_ListaPreco", "TextBox")
4296:         WITH loc_oSub.txt_4c_ListaPreco
4297:             .Top           = 17
4298:             .Left          = 123
4299:             .Width         = 220
4300:             .Height        = 20
4301:             .FontName      = "Tahoma"
4302:             .Format        = "K"
4303:             .Margin        = 0

*-- Linhas 4309 a 4325:
4309:             .Visible       = .T.
4310:         ENDWITH
4311: 
4312:         loc_oSub.AddObject("lbl_4c__ListaPreco", "Label")
4313:         WITH loc_oSub.lbl_4c__ListaPreco
4314:             .Top       = 5
4315:             .Left      = 124
4316:             .FontBold  = .T.
4317:             .FontName  = "Tahoma"
4318:             .FontSize  = 8
4319:             .BackStyle = 0
4320:             .Caption   = "Lista de Pre" + CHR(231) + "os"
4321:             .ForeColor = RGB(90, 90, 90)
4322:             .TabIndex  = 3
4323:             .Visible   = .T.
4324:         ENDWITH
4325: 

*-- Linhas 4332 a 4368:
4332:         loc_oCnt.AddObject("cnt_4c_CodOperacao", "Container")
4333:         loc_oSub = loc_oCnt.cnt_4c_CodOperacao
4334:         WITH loc_oSub
4335:             .Top           = 2
4336:             .Left          = 2
4337:             .Width         = 371
4338:             .Height        = 31
4339:             .BorderWidth   = 1
4340:             .SpecialEffect = 2
4341:             .TabIndex      = 2
4342:             .BackColor     = RGB(255, 255, 255)
4343:             .Visible       = .T.
4344:         ENDWITH
4345: 
4346:         loc_oSub.AddObject("lbl_4c_label12", "Label")
4347:         WITH loc_oSub.lbl_4c_label12
4348:             .Top       = 8
4349:             .Left      = 9
4350:             .FontBold  = .T.
4351:             .FontName  = "Tahoma"
4352:             .FontSize  = 8
4353:             .BackStyle = 0
4354:             .Caption   = "Documento : "
4355:             .ForeColor = RGB(90, 90, 90)
4356:             .TabIndex  = 4
4357:             .Visible   = .T.
4358:         ENDWITH
4359: 
4360:         loc_oSub.AddObject("txt_4c_Codigo", "TextBox")
4361:         WITH loc_oSub.txt_4c_Codigo
4362:             .Top           = 4
4363:             .Left          = 94
4364:             .Width         = 61
4365:             .Height        = 23
4366:             .FontBold      = .T.
4367:             .FontName      = "Tahoma"
4368:             .FontSize      = 10

*-- Linhas 4374 a 4399:
4374:             .Visible       = .T.
4375:         ENDWITH
4376: 
4377:         loc_oSub.AddObject("lbl_4c_label24", "Label")
4378:         WITH loc_oSub.lbl_4c_label24
4379:             .Top       = 8
4380:             .Left      = 160
4381:             .FontBold  = .T.
4382:             .FontName  = "Tahoma"
4383:             .FontSize  = 8
4384:             .BackStyle = 0
4385:             .Caption   = "Pedido Cliente: "
4386:             .ForeColor = RGB(90, 90, 90)
4387:             .TabIndex  = 4
4388:             .Visible   = .T.
4389:         ENDWITH
4390: 
4391:         loc_oSub.AddObject("txt_4c_PedCli", "TextBox")
4392:         WITH loc_oSub.txt_4c_PedCli
4393:             .Top           = 4
4394:             .Left          = 260
4395:             .Width         = 80
4396:             .Height        = 23
4397:             .FontBold      = .T.
4398:             .FontName      = "Tahoma"
4399:             .FontSize      = 10

*-- Linhas 4411 a 4523:
4411:         loc_oCnt.AddObject("cnt_4c_Origem", "Container")
4412:         loc_oSub = loc_oCnt.cnt_4c_Origem
4413:         WITH loc_oSub
4414:             .Top           = 74
4415:             .Left          = 2
4416:             .Width         = 371
4417:             .Height        = 94
4418:             .BackStyle     = 1
4419:             .BorderWidth   = 1
4420:             .SpecialEffect = 2
4421:             .TabIndex      = 3
4422:             .BackColor     = RGB(255, 255, 255)
4423:             .Visible       = .T.
4424:         ENDWITH
4425: 
4426:         loc_oSub.AddObject("lbl_4c_label44", "Label")
4427:         WITH loc_oSub.lbl_4c_label44
4428:             .Top       = 2
4429:             .Left      = 10
4430:             .Width     = 43
4431:             .Height    = 15
4432:             .FontBold  = .T.
4433:             .FontName  = "Tahoma"
4434:             .FontSize  = 8
4435:             .BackStyle = 0
4436:             .Caption   = "Origem"
4437:             .ForeColor = RGB(90, 90, 90)
4438:             .TabIndex  = 26
4439:             .Visible   = .T.
4440:         ENDWITH
4441: 
4442:         loc_oSub.AddObject("lin_4c_line14", "Line")
4443:         WITH loc_oSub.lin_4c_line14
4444:             .Top         = 17
4445:             .Left        = 10
4446:             .Width       = 321
4447:             .Height      = 0
4448:             .BorderWidth = 2
4449:             .Visible     = .T.
4450:         ENDWITH
4451: 
4452:         loc_oSub.AddObject("lbl_4c_label84", "Label")
4453:         WITH loc_oSub.lbl_4c_label84
4454:             .Top       = 18
4455:             .Left      = 10
4456:             .FontBold  = .T.
4457:             .FontName  = "Tahoma"
4458:             .FontSize  = 8
4459:             .BackStyle = 0
4460:             .Caption   = "Grupo"
4461:             .ForeColor = RGB(90, 90, 90)
4462:             .TabIndex  = 7
4463:             .Visible   = .T.
4464:         ENDWITH
4465: 
4466:         loc_oSub.AddObject("lbl_4c_label25", "Label")
4467:         WITH loc_oSub.lbl_4c_label25
4468:             .Top       = 18
4469:             .Left      = 93
4470:             .FontBold  = .F.
4471:             .FontName  = "Tahoma"
4472:             .FontSize  = 8
4473:             .BackStyle = 0
4474:             .Caption   = "Conta"
4475:             .ForeColor = RGB(90, 90, 90)
4476:             .TabIndex  = 8
4477:             .Visible   = .T.
4478:         ENDWITH
4479: 
4480:         *-- Say3 e o label REAL de "CPF / CNPJ" no legado (Say_CPF de Origem e
4481:         *-- um placeholder degenerado com Caption=" " - nao tem conteudo nem
4482:         *-- funcao visual e foi omitido).
4483:         loc_oSub.AddObject("lbl_4c_Label3", "Label")
4484:         WITH loc_oSub.lbl_4c_Label3
4485:             .Top       = 18
4486:             .Left      = 176
4487:             .Width     = 56
4488:             .Height    = 15
4489:             .FontBold  = .F.
4490:             .FontName  = "Tahoma"
4491:             .FontSize  = 8
4492:             .BackStyle = 0
4493:             .Caption   = "CPF / CNPJ"
4494:             .ForeColor = RGB(90, 90, 90)
4495:             .TabIndex  = 10
4496:             .Visible   = .T.
4497:         ENDWITH
4498: 
4499:         loc_oSub.AddObject("lbl_4c__dconta4", "Label")
4500:         WITH loc_oSub.lbl_4c__dconta4
4501:             .Top       = 51
4502:             .Left      = 10
4503:             .Width     = 29
4504:             .Height    = 15
4505:             .FontBold  = .F.
4506:             .FontName  = "Tahoma"
4507:             .FontSize  = 8
4508:             .BackStyle = 0
4509:             .Caption   = "Nome"
4510:             .ForeColor = RGB(90, 90, 90)
4511:             .TabIndex  = 5
4512:             .Visible   = .T.
4513:         ENDWITH
4514: 
4515:         loc_oSub.AddObject("txt_4c_grupo4", "TextBox")
4516:         WITH loc_oSub.txt_4c_grupo4
4517:             .Top               = 32
4518:             .Left              = 10
4519:             .Width             = 80
4520:             .Height            = 21
4521:             .FontBold          = .T.
4522:             .FontName          = "Tahoma"
4523:             .Alignment         = 1

*-- Linhas 4532 a 4541:
4532: 
4533:         loc_oSub.AddObject("txt_4c_conta4", "TextBox")
4534:         WITH loc_oSub.txt_4c_conta4
4535:             .Top               = 32
4536:             .Left              = 93
4537:             .Width             = 80
4538:             .Height            = 21
4539:             .FontName          = "Tahoma"
4540:             .Margin            = 0
4541:             .SpecialEffect     = 1

*-- Linhas 4548 a 4557:
4548: 
4549:         loc_oSub.AddObject("txt_4c_dconta4", "TextBox")
4550:         WITH loc_oSub.txt_4c_dconta4
4551:             .Top               = 65
4552:             .Left              = 10
4553:             .Width             = 304
4554:             .Height            = 21
4555:             .FontName          = "Tahoma"
4556:             .Margin            = 0
4557:             .SpecialEffect     = 1

*-- Linhas 4564 a 4620:
4564: 
4565:         loc_oSub.AddObject("txt_4c_cpf4", "TextBox")
4566:         WITH loc_oSub.txt_4c_cpf4
4567:             .Top               = 32
4568:             .Left              = 176
4569:             .Width             = 139
4570:             .Height            = 21
4571:             .FontName          = "Tahoma"
4572:             .Margin            = 0
4573:             .SpecialEffect     = 1
4574:             .TabIndex          = 3
4575:             .ForeColor         = RGB(90, 90, 90)
4576:             .DisabledBackColor = RGB(255, 255, 255)
4577:             .Value             = ""
4578:             .Visible           = .T.
4579:         ENDWITH
4580: 
4581:         loc_oSub.AddObject("cmd_4c_btncadastros2", "CommandButton")
4582:         WITH loc_oSub.cmd_4c_btncadastros2
4583:             .Top           = 52
4584:             .Left          = 325
4585:             .Width         = 34
4586:             .Height        = 32
4587:             .FontSize      = 7
4588:             .Picture       = gc_4c_CaminhoIcones + "binder03.ico"
4589:             .Caption       = ""
4590:             .ToolTipText   = "<F2> Acessa o Cadastro Desta Conta"
4591:             .SpecialEffect = 2
4592:             .TabIndex      = 6
4593:             .Visible       = .T.
4594:         ENDWITH
4595: 
4596:         BINDEVENT(loc_oSub.txt_4c_Grupo, "KeyPress", THIS, "GrpOrigKeyPress")
4597:         BINDEVENT(loc_oSub.txt_4c_Conta, "KeyPress", THIS, "CtaOrigKeyPress")
4598:         BINDEVENT(loc_oSub.txt_4c_Dconta, "KeyPress", THIS, "DctOrigKeyPress")
4599:         BINDEVENT(loc_oSub.txt_4c_Cpf, "KeyPress", THIS, "CpfOrigKeyPress")
4600: 
4601:         *======================================================================
4602:         * Proximo (navegacao ENTER, filho direto de Cnt_Identifica)
4603:         *======================================================================
4604:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
4605:         WITH loc_oCnt.cmd_4c_Proximo
4606:             .Top         = 400
4607:             .Left        = 324
4608:             .Width       = 45
4609:             .Height      = 45
4610:             .FontName    = "Verdana"
4611:             .FontSize    = 8
4612:             .Picture     = gc_4c_CaminhoIcones + "b_arrow2.bmp"
4613:             .Caption     = ""
4614:             .ForeColor   = RGB(36, 84, 155)
4615:             .BackColor   = RGB(255, 255, 255)
4616:             .Themes      = .F.
4617:             .Visible     = .T.
4618:         ENDWITH
4619:     ENDPROC
4620: 

*-- Linhas 4641 a 4663:
4641:         loc_oCnt.AddObject("cnt_4c_Acrescimo", "Container")
4642:         loc_oSub = loc_oCnt.cnt_4c_Acrescimo
4643:         WITH loc_oSub
4644:             .Top         = 31
4645:             .Left        = 17
4646:             .Width       = 303
4647:             .Height      = 52
4648:             .BackStyle   = 1
4649:             .BorderWidth = 1
4650:             .TabIndex    = 3
4651:             .BackColor   = RGB(255, 255, 255)
4652:             .Visible     = .F.
4653:         ENDWITH
4654: 
4655:         loc_oSub.AddObject("txt_4c_TotVariacao", "TextBox")
4656:         WITH loc_oSub.txt_4c_TotVariacao
4657:             .Top           = 25
4658:             .Left          = 117
4659:             .Width         = 185
4660:             .Height        = 24
4661:             .FontBold      = .T.
4662:             .FontName      = "Tahoma"
4663:             .FontSize      = 14

*-- Linhas 4672 a 4698:
4672:             .Visible       = .T.
4673:         ENDWITH
4674: 
4675:         loc_oSub.AddObject("lbl_4c_Label20", "Label")
4676:         WITH loc_oSub.lbl_4c_Label20
4677:             .Top       = 1
4678:             .Left      = 8
4679:             .Width     = 85
4680:             .Height    = 23
4681:             .FontName  = "Tahoma"
4682:             .FontSize  = 13
4683:             .BackStyle = 0
4684:             .Caption   = "Acr" + CHR(233) + "scimo:"
4685:             .ForeColor = RGB(90, 90, 90)
4686:             .TabIndex  = 55
4687:             .Visible   = .T.
4688:         ENDWITH
4689: 
4690:         loc_oSub.AddObject("txt_4c_PorcVariacao", "TextBox")
4691:         WITH loc_oSub.txt_4c_PorcVariacao
4692:             .Top           = 0
4693:             .Left          = 178
4694:             .Width         = 124
4695:             .Height        = 24
4696:             .FontBold      = .T.
4697:             .FontName      = "Tahoma"
4698:             .FontSize      = 14

*-- Linhas 4706 a 4766:
4706:             .Visible       = .T.
4707:         ENDWITH
4708: 
4709:         loc_oSub.AddObject("lbl_4c_Label1", "Label")
4710:         WITH loc_oSub.lbl_4c_Label1
4711:             .Top       = 4
4712:             .Left      = 96
4713:             .Width     = 25
4714:             .Height    = 15
4715:             .AutoSize  = .T.
4716:             .FontBold  = .T.
4717:             .FontName  = "Tahoma"
4718:             .FontSize  = 8
4719:             .BackStyle = 0
4720:             .Caption   = "(%)"
4721:             .ForeColor = RGB(90, 90, 90)
4722:             .Visible   = .T.
4723:         ENDWITH
4724: 
4725:         loc_oSub.AddObject("lbl_4c_Label2", "Label")
4726:         WITH loc_oSub.lbl_4c_Label2
4727:             .Top       = 29
4728:             .Left      = 96
4729:             .Width     = 19
4730:             .Height    = 15
4731:             .AutoSize  = .T.
4732:             .FontBold  = .T.
4733:             .FontName  = "Tahoma"
4734:             .FontSize  = 8
4735:             .BackStyle = 0
4736:             .Caption   = "($)"
4737:             .ForeColor = RGB(90, 90, 90)
4738:             .Visible   = .T.
4739:         ENDWITH
4740: 
4741:         *======================================================================
4742:         * Desconto (Visible=.F. no legado)
4743:         *======================================================================
4744:         loc_oCnt.AddObject("cnt_4c_Desconto", "Container")
4745:         loc_oSub = loc_oCnt.cnt_4c_Desconto
4746:         WITH loc_oSub
4747:             .Top         = 31
4748:             .Left        = 17
4749:             .Width       = 303
4750:             .Height      = 52
4751:             .BackStyle   = 1
4752:             .BorderWidth = 1
4753:             .TabIndex    = 2
4754:             .BackColor   = RGB(255, 255, 255)
4755:             .Visible     = .F.
4756:         ENDWITH
4757: 
4758:         loc_oSub.AddObject("txt_4c_totvariacao2", "TextBox")
4759:         WITH loc_oSub.txt_4c_totvariacao2
4760:             .Top           = 25
4761:             .Left          = 116
4762:             .Width         = 185
4763:             .Height        = 24
4764:             .FontBold      = .T.
4765:             .FontName      = "Tahoma"
4766:             .FontSize      = 14

*-- Linhas 4775 a 4801:
4775:             .Visible       = .T.
4776:         ENDWITH
4777: 
4778:         loc_oSub.AddObject("lbl_4c_label202", "Label")
4779:         WITH loc_oSub.lbl_4c_label202
4780:             .Top       = 1
4781:             .Left      = 8
4782:             .Width     = 78
4783:             .Height    = 23
4784:             .FontName  = "Tahoma"
4785:             .FontSize  = 13
4786:             .BackStyle = 0
4787:             .Caption   = "Desconto:"
4788:             .ForeColor = RGB(90, 90, 90)
4789:             .TabIndex  = 55
4790:             .Visible   = .T.
4791:         ENDWITH
4792: 
4793:         loc_oSub.AddObject("txt_4c_porcvariacao2", "TextBox")
4794:         WITH loc_oSub.txt_4c_porcvariacao2
4795:             .Top           = 0
4796:             .Left          = 177
4797:             .Width         = 124
4798:             .Height        = 24
4799:             .FontBold      = .T.
4800:             .FontName      = "Tahoma"
4801:             .FontSize      = 14

*-- Linhas 4809 a 4881:
4809:             .Visible       = .T.
4810:         ENDWITH
4811: 
4812:         loc_oSub.AddObject("lbl_4c_label12", "Label")
4813:         WITH loc_oSub.lbl_4c_label12
4814:             .Top       = 4
4815:             .Left      = 89
4816:             .Width     = 25
4817:             .Height    = 15
4818:             .AutoSize  = .T.
4819:             .FontBold  = .T.
4820:             .FontName  = "Tahoma"
4821:             .FontSize  = 8
4822:             .BackStyle = 0
4823:             .Caption   = "(%)"
4824:             .ForeColor = RGB(90, 90, 90)
4825:             .Visible   = .T.
4826:         ENDWITH
4827: 
4828:         loc_oSub.AddObject("lbl_4c_label22", "Label")
4829:         WITH loc_oSub.lbl_4c_label22
4830:             .Top       = 28
4831:             .Left      = 89
4832:             .Width     = 19
4833:             .Height    = 15
4834:             .AutoSize  = .T.
4835:             .FontBold  = .T.
4836:             .FontName  = "Tahoma"
4837:             .FontSize  = 8
4838:             .BackStyle = 0
4839:             .Caption   = "($)"
4840:             .ForeColor = RGB(90, 90, 90)
4841:             .Visible   = .T.
4842:         ENDWITH
4843: 
4844:         *======================================================================
4845:         * Campos soltos de Cnt_Fpagto (filhos diretos)
4846:         *======================================================================
4847:         loc_oCnt.AddObject("lbl_4c_Label9", "Label")
4848:         WITH loc_oCnt.lbl_4c_Label9
4849:             .Top       = 339
4850:             .Left      = 55
4851:             .FontName  = "Verdana"
4852:             .FontSize  = 8
4853:             .BackStyle = 0
4854:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
4855:             .ForeColor = RGB(36, 84, 155)
4856:             .TabIndex  = 16
4857:             .Visible   = .T.
4858:         ENDWITH
4859: 
4860:         loc_oCnt.AddObject("txt_4c_OBS", "TextBox")
4861:         WITH loc_oCnt.txt_4c_OBS
4862:             .Top           = 337
4863:             .Left          = 130
4864:             .Width         = 150
4865:             .Height        = 20
4866:             .SpecialEffect = 1
4867:             .TabIndex      = 12
4868:             .BorderColor   = RGB(36, 84, 155)
4869:             .Value         = ""
4870:             .Visible       = .T.
4871:         ENDWITH
4872: 
4873:         loc_oCnt.AddObject("txt_4c_Fpg", "TextBox")
4874:         WITH loc_oCnt.txt_4c_Fpg
4875:             .Top           = 191
4876:             .Left          = 134
4877:             .Width         = 185
4878:             .Height        = 29
4879:             .FontBold      = .T.
4880:             .FontName      = "Tahoma"
4881:             .FontSize      = 15

*-- Linhas 4890 a 4899:
4890: 
4891:         loc_oCnt.AddObject("txt_4c_Npar", "TextBox")
4892:         WITH loc_oCnt.txt_4c_Npar
4893:             .Top           = 221
4894:             .Left          = 134
4895:             .Width         = 41
4896:             .Height        = 29
4897:             .FontBold      = .T.
4898:             .FontName      = "Tahoma"
4899:             .FontSize      = 15

*-- Linhas 4908 a 4917:
4908: 
4909:         loc_oCnt.AddObject("txt_4c_Vpar", "TextBox")
4910:         WITH loc_oCnt.txt_4c_Vpar
4911:             .Top           = 251
4912:             .Left          = 134
4913:             .Width         = 185
4914:             .Height        = 29
4915:             .FontBold      = .T.
4916:             .FontName      = "Tahoma"
4917:             .FontSize      = 15

*-- Linhas 4927 a 4936:
4927: 
4928:         loc_oCnt.AddObject("txt_4c_Fweditdata_venc", "TextBox")
4929:         WITH loc_oCnt.txt_4c_Fweditdata_venc
4930:             .Top           = 281
4931:             .Left          = 134
4932:             .Width         = 138
4933:             .Height        = 29
4934:             .FontBold      = .T.
4935:             .FontName      = "Tahoma"
4936:             .FontSize      = 15

*-- Linhas 4942 a 4992:
4942:             .Visible       = .T.
4943:         ENDWITH
4944: 
4945:         loc_oCnt.AddObject("lbl_4c_Label23", "Label")
4946:         WITH loc_oCnt.lbl_4c_Label23
4947:             .Top       = 134
4948:             .Left      = 34
4949:             .FontName  = "Tahoma"
4950:             .FontSize  = 13
4951:             .BackStyle = 0
4952:             .Caption   = "Pagamentos:"
4953:             .ForeColor = RGB(90, 90, 90)
4954:             .TabIndex  = 23
4955:             .Visible   = .T.
4956:         ENDWITH
4957: 
4958:         loc_oCnt.AddObject("lbl_4c_Label15", "Label")
4959:         WITH loc_oCnt.lbl_4c_Label15
4960:             .Top       = 108
4961:             .Left      = 40
4962:             .FontName  = "Tahoma"
4963:             .FontSize  = 13
4964:             .BackStyle = 0
4965:             .Caption   = "Saldo Final :"
4966:             .ForeColor = RGB(90, 90, 90)
4967:             .TabIndex  = 24
4968:             .Visible   = .T.
4969:         ENDWITH
4970: 
4971:         loc_oCnt.AddObject("lbl_4c_Label24", "Label")
4972:         WITH loc_oCnt.lbl_4c_Label24
4973:             .Top       = 6
4974:             .Left      = 77
4975:             .FontName  = "Tahoma"
4976:             .FontSize  = 13
4977:             .BackStyle = 0
4978:             .Caption   = "Total : "
4979:             .ForeColor = RGB(90, 90, 90)
4980:             .TabIndex  = 17
4981:             .Visible   = .T.
4982:         ENDWITH
4983: 
4984:         loc_oCnt.AddObject("txt_4c_Valinic", "TextBox")
4985:         WITH loc_oCnt.txt_4c_Valinic
4986:             .Top           = 5
4987:             .Left          = 134
4988:             .Width         = 185
4989:             .Height        = 25
4990:             .FontBold      = .T.
4991:             .FontName      = "Tahoma"
4992:             .FontSize      = 14

*-- Linhas 5003 a 5038:
5003: 
5004:         loc_oCnt.AddObject("obj_4c_GetObs", "EditBox")
5005:         WITH loc_oCnt.obj_4c_GetObs
5006:             .Top           = 321
5007:             .Left          = 2
5008:             .Width         = 314
5009:             .Height        = 38
5010:             .SpecialEffect = 1
5011:             .TabIndex      = 14
5012:             .Visible       = .F.
5013:         ENDWITH
5014: 
5015:         loc_oCnt.AddObject("lbl_4c_Obs", "Label")
5016:         WITH loc_oCnt.lbl_4c_Obs
5017:             .Top       = 308
5018:             .Left      = 5
5019:             .Width     = 60
5020:             .Height    = 15
5021:             .FontName  = "Tahoma"
5022:             .FontSize  = 8
5023:             .BackStyle = 0
5024:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
5025:             .ForeColor = RGB(90, 90, 90)
5026:             .TabIndex  = 15
5027:             .Visible   = .F.
5028:         ENDWITH
5029: 
5030:         loc_oCnt.AddObject("txt_4c_TotLiquido", "TextBox")
5031:         WITH loc_oCnt.txt_4c_TotLiquido
5032:             .Top           = 107
5033:             .Left          = 134
5034:             .Width         = 185
5035:             .Height        = 25
5036:             .FontBold      = .T.
5037:             .FontName      = "Tahoma"
5038:             .FontSize      = 14

*-- Linhas 5049 a 5058:
5049: 
5050:         loc_oCnt.AddObject("txt_4c_Saldo", "TextBox")
5051:         WITH loc_oCnt.txt_4c_Saldo
5052:             .Top           = 159
5053:             .Left          = 134
5054:             .Width         = 185
5055:             .Height        = 25
5056:             .FontBold      = .T.
5057:             .FontName      = "Tahoma"
5058:             .FontSize      = 14

*-- Linhas 5070 a 5079:
5070: 
5071:         loc_oCnt.AddObject("txt_4c_TotForma", "TextBox")
5072:         WITH loc_oCnt.txt_4c_TotForma
5073:             .Top           = 133
5074:             .Left          = 134
5075:             .Width         = 185
5076:             .Height        = 25
5077:             .FontBold      = .T.
5078:             .FontName      = "Tahoma"
5079:             .FontSize      = 14

*-- Linhas 5089 a 5144:
5089:             .Visible       = .T.
5090:         ENDWITH
5091: 
5092:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
5093:         WITH loc_oCnt.lbl_4c_Label1
5094:             .Top       = 160
5095:             .Left      = 62
5096:             .FontName  = "Tahoma"
5097:             .FontSize  = 13
5098:             .BackStyle = 0
5099:             .Caption   = "A Pagar :"
5100:             .ForeColor = RGB(90, 90, 90)
5101:             .TabIndex  = 22
5102:             .Visible   = .T.
5103:         ENDWITH
5104: 
5105:         loc_oCnt.AddObject("cmd_4c_Proximo", "CommandButton")
5106:         WITH loc_oCnt.cmd_4c_Proximo
5107:             .Top         = 308
5108:             .Left        = 324
5109:             .Width       = 45
5110:             .Height      = 45
5111:             .FontName    = "Verdana"
5112:             .FontSize    = 8
5113:             .Picture     = gc_4c_CaminhoIcones + "b_arrow1.bmp"
5114:             .Caption     = ""
5115:             .ToolTipText = "Avan" + CHR(231) + "a Para a Pr" + CHR(243) + "xima Tela"
5116:             .TabIndex    = 26
5117:             .ForeColor   = RGB(36, 84, 155)
5118:             .BackColor   = RGB(255, 255, 255)
5119:             .Themes      = .F.
5120:             .Visible     = .T.
5121:         ENDWITH
5122: 
5123:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")
5124:         WITH loc_oCnt.lbl_4c_Label2
5125:             .Top       = 82
5126:             .Left      = 40
5127:             .FontName  = "Tahoma"
5128:             .FontSize  = 13
5129:             .BackStyle = 0
5130:             .Caption   = "Desc.Prom.:"
5131:             .ForeColor = RGB(90, 90, 90)
5132:             .TabIndex  = 25
5133:             .Visible   = .T.
5134:         ENDWITH
5135: 
5136:         loc_oCnt.AddObject("txt_4c_Tvariacao", "TextBox")
5137:         WITH loc_oCnt.txt_4c_Tvariacao
5138:             .Top           = 81
5139:             .Left          = 134
5140:             .Width         = 185
5141:             .Height        = 25
5142:             .FontBold      = .T.
5143:             .FontName      = "Tahoma"
5144:             .FontSize      = 14

*-- Linhas 5153 a 5216:
5153:             .Visible       = .T.
5154:         ENDWITH
5155: 
5156:         loc_oCnt.AddObject("lbl_4c_Label18", "Label")
5157:         WITH loc_oCnt.lbl_4c_Label18
5158:             .Top       = 284
5159:             .Left      = 33
5160:             .FontName  = "Tahoma"
5161:             .FontSize  = 13
5162:             .BackStyle = 0
5163:             .Caption   = "Vencimento :"
5164:             .ForeColor = RGB(90, 90, 90)
5165:             .TabIndex  = 21
5166:             .Visible   = .T.
5167:         ENDWITH
5168: 
5169:         loc_oCnt.AddObject("lbl_4c_Label13", "Label")
5170:         WITH loc_oCnt.lbl_4c_Label13
5171:             .Top       = 224
5172:             .Left      = 58
5173:             .FontName  = "Tahoma"
5174:             .FontSize  = 13
5175:             .BackStyle = 0
5176:             .Caption   = "Parcelas :"
5177:             .ForeColor = RGB(90, 90, 90)
5178:             .TabIndex  = 19
5179:             .Visible   = .T.
5180:         ENDWITH
5181: 
5182:         loc_oCnt.AddObject("lbl_4c_Label17", "Label")
5183:         WITH loc_oCnt.lbl_4c_Label17
5184:             .Top       = 254
5185:             .Left      = 82
5186:             .FontName  = "Tahoma"
5187:             .FontSize  = 13
5188:             .BackStyle = 0
5189:             .Caption   = "Valor :"
5190:             .ForeColor = RGB(90, 90, 90)
5191:             .TabIndex  = 20
5192:             .Visible   = .T.
5193:         ENDWITH
5194: 
5195:         loc_oCnt.AddObject("lbl_4c_Label12", "Label")
5196:         WITH loc_oCnt.lbl_4c_Label12
5197:             .Top       = 194
5198:             .Left      = 31
5199:             .FontName  = "Tahoma"
5200:             .FontSize  = 13
5201:             .BackStyle = 0
5202:             .Caption   = "Forma Pagto:"
5203:             .ForeColor = RGB(90, 90, 90)
5204:             .TabIndex  = 18
5205:             .Visible   = .T.
5206:         ENDWITH
5207: 
5208:         loc_oCnt.AddObject("shp_4c_Shape4", "Shape")
5209:         WITH loc_oCnt.shp_4c_Shape4
5210:             .Top           = 186
5211:             .Left          = 2
5212:             .Width         = 369
5213:             .Height        = 2
5214:             .BorderWidth   = 1
5215:             .SpecialEffect = 1
5216:             .Visible       = .T.

*-- Linhas 5225 a 5299:
5225:         loc_oChq.AddObject("cnt_4c__Chq", "Container")
5226:         loc_oSub = loc_oChq.cnt_4c__Chq
5227:         WITH loc_oSub
5228:             .Top         = 0
5229:             .Left        = 0
5230:             .Width       = 371
5231:             .Height      = 60
5232:             .BackStyle   = 1
5233:             .BorderWidth = 1
5234:             .SpecialEffect = 2
5235:             .TabIndex    = 13
5236:             .BackColor   = RGB(255, 255, 255)
5237:             .Visible     = .F.
5238:         ENDWITH
5239: 
5240:         loc_oSub.AddObject("cmd_4c_TefChq", "CommandButton")
5241:         WITH loc_oSub.cmd_4c_TefChq
5242:             .Top         = 5
5243:             .Left        = 259
5244:             .Width       = 108
5245:             .Height      = 20
5246:             .FontBold    = .T.
5247:             .FontItalic  = .T.
5248:             .FontName    = "Comic Sans MS"
5249:             .FontSize    = 8
5250:             .WordWrap    = .T.
5251:             .Caption     = "Consulta C\<heque"
5252:             .TabIndex    = 12
5253:             .TabStop     = .F.
5254:             .ToolTipText = "Verifica e Confirma se a numera" + CHR(231) + CHR(227) + "o dos cheques est" + CHR(225) + " OK."
5255:             .ForeColor   = RGB(90, 90, 90)
5256:             .BackColor   = RGB(255, 255, 255)
5257:             .Themes      = .F.
5258:             .Visible     = .T.
5259:         ENDWITH
5260: 
5261:         loc_oSub.AddObject("obj_4c_Opc_cpf", "OptionGroup")
5262:         WITH loc_oSub.obj_4c_Opc_cpf
5263:             .Top         = 5
5264:             .Left        = 3
5265:             .Width       = 108
5266:             .Height      = 17
5267:             .ButtonCount = 2
5268:             .Value       = 1
5269:             .BackStyle   = 0
5270:             .BorderStyle = 0
5271:             .TabIndex    = 18
5272:             .BorderColor = RGB(192, 192, 192)
5273:             .Visible     = .T.
5274:             WITH .Buttons(1)
5275:                 .BackStyle = 0
5276:                 .Caption   = "CPF"
5277:                 .Height    = 17
5278:                 .Left      = 5
5279:                 .Top       = 1
5280:                 .Width     = 44
5281:             ENDWITH
5282:             WITH .Buttons(2)
5283:                 .FontSize  = 8
5284:                 .BackStyle = 0
5285:                 .Caption   = "CNPJ"
5286:                 .Left      = 57
5287:                 .Top       = 1
5288:             ENDWITH
5289:         ENDWITH
5290: 
5291:         loc_oSub.AddObject("txt_4c_Cpf", "TextBox")
5292:         WITH loc_oSub.txt_4c_Cpf
5293:             .Top               = 4
5294:             .Left              = 112
5295:             .Width             = 140
5296:             .Height            = 20
5297:             .FontName          = "Tahoma"
5298:             .Margin            = 0
5299:             .MaxLength         = 20

*-- Linhas 5305 a 5419:
5305:             .Visible           = .T.
5306:         ENDWITH
5307: 
5308:         loc_oSub.AddObject("lbl_4c_label23", "Label")
5309:         WITH loc_oSub.lbl_4c_label23
5310:             .Top       = 25
5311:             .Left      = 40
5312:             .FontName  = "Tahoma"
5313:             .FontSize  = 7
5314:             .Caption   = "Banco"
5315:             .ForeColor = RGB(90, 90, 90)
5316:             .TabIndex  = 14
5317:             .Visible   = .T.
5318:         ENDWITH
5319: 
5320:         loc_oSub.AddObject("lbl_4c_Label3", "Label")
5321:         WITH loc_oSub.lbl_4c_Label3
5322:             .Top       = 25
5323:             .Left      = 72
5324:             .FontName  = "Tahoma"
5325:             .FontSize  = 7
5326:             .Caption   = "Agencia  Dv"
5327:             .ForeColor = RGB(90, 90, 90)
5328:             .TabIndex  = 15
5329:             .Visible   = .T.
5330:         ENDWITH
5331: 
5332:         loc_oSub.AddObject("lbl_4c_Label5", "Label")
5333:         WITH loc_oSub.lbl_4c_Label5
5334:             .Top       = 25
5335:             .Left      = 134
5336:             .FontName  = "Tahoma"
5337:             .FontSize  = 7
5338:             .Caption   = "Conta                            Dv"
5339:             .ForeColor = RGB(90, 90, 90)
5340:             .TabIndex  = 17
5341:             .Visible   = .T.
5342:         ENDWITH
5343: 
5344:         loc_oSub.AddObject("txt_4c_Age", "TextBox")
5345:         WITH loc_oSub.txt_4c_Age
5346:             .Top           = 36
5347:             .Left          = 73
5348:             .Width         = 36
5349:             .Height        = 22
5350:             .FontName      = "Tahoma"
5351:             .SpecialEffect = 1
5352:             .TabIndex      = 4
5353:             .ForeColor     = RGB(0, 0, 0)
5354:             .Value         = ""
5355:             .Visible       = .T.
5356:         ENDWITH
5357: 
5358:         loc_oSub.AddObject("txt_4c_Bco", "TextBox")
5359:         WITH loc_oSub.txt_4c_Bco
5360:             .Top           = 36
5361:             .Left          = 40
5362:             .Width         = 32
5363:             .Height        = 22
5364:             .FontName      = "Tahoma"
5365:             .BackStyle     = 1
5366:             .SpecialEffect = 1
5367:             .TabIndex      = 3
5368:             .ForeColor     = RGB(0, 0, 0)
5369:             .Value         = ""
5370:             .Visible       = .T.
5371:         ENDWITH
5372: 
5373:         loc_oSub.AddObject("lbl_4c_Label4", "Label")
5374:         WITH loc_oSub.lbl_4c_Label4
5375:             .Top       = 25
5376:             .Left      = 241
5377:             .FontName  = "Tahoma"
5378:             .FontSize  = 7
5379:             .Caption   = "N.Cheque     Dv"
5380:             .ForeColor = RGB(90, 90, 90)
5381:             .TabIndex  = 16
5382:             .Visible   = .T.
5383:         ENDWITH
5384: 
5385:         loc_oSub.AddObject("txt_4c_Num", "TextBox")
5386:         WITH loc_oSub.txt_4c_Num
5387:             .Top           = 36
5388:             .Left          = 237
5389:             .Width         = 52
5390:             .Height        = 22
5391:             .FontName      = "Tahoma"
5392:             .SpecialEffect = 1
5393:             .TabIndex      = 8
5394:             .ForeColor     = RGB(0, 0, 0)
5395:             .Value         = ""
5396:             .Visible       = .T.
5397:         ENDWITH
5398: 
5399:         loc_oSub.AddObject("lbl_4c_label13", "Label")
5400:         WITH loc_oSub.lbl_4c_label13
5401:             .Top       = 25
5402:             .Left      = 5
5403:             .FontName  = "Tahoma"
5404:             .FontSize  = 7
5405:             .Caption   = "Pca"
5406:             .ForeColor = RGB(90, 90, 90)
5407:             .TabIndex  = 13
5408:             .Visible   = .T.
5409:         ENDWITH
5410: 
5411:         loc_oSub.AddObject("txt_4c_Pca", "TextBox")
5412:         WITH loc_oSub.txt_4c_Pca
5413:             .Top           = 36
5414:             .Left          = 5
5415:             .Width         = 34
5416:             .Height        = 22
5417:             .FontName      = "Tahoma"
5418:             .BackStyle     = 1
5419:             .MaxLength     = 34

*-- Linhas 5426 a 5435:
5426: 
5427:         loc_oSub.AddObject("txt_4c_Agendc", "TextBox")
5428:         WITH loc_oSub.txt_4c_Agendc
5429:             .Top           = 36
5430:             .Left          = 110
5431:             .Width         = 22
5432:             .Height        = 22
5433:             .FontName      = "Tahoma"
5434:             .MaxLength     = 1
5435:             .SpecialEffect = 1

*-- Linhas 5441 a 5450:
5441: 
5442:         loc_oSub.AddObject("txt_4c_Contadc", "TextBox")
5443:         WITH loc_oSub.txt_4c_Contadc
5444:             .Top           = 36
5445:             .Left          = 213
5446:             .Width         = 23
5447:             .Height        = 22
5448:             .FontName      = "Tahoma"
5449:             .MaxLength     = 1
5450:             .SpecialEffect = 1

*-- Linhas 5456 a 5465:
5456: 
5457:         loc_oSub.AddObject("txt_4c_Numdc", "TextBox")
5458:         WITH loc_oSub.txt_4c_Numdc
5459:             .Top           = 36
5460:             .Left          = 290
5461:             .Width         = 22
5462:             .Height        = 22
5463:             .FontName      = "Tahoma"
5464:             .MaxLength     = 1
5465:             .SpecialEffect = 1

*-- Linhas 5471 a 5502:
5471: 
5472:         loc_oSub.AddObject("txt_4c_Conta", "TextBox")
5473:         WITH loc_oSub.txt_4c_Conta
5474:             .Top           = 36
5475:             .Left          = 133
5476:             .Width         = 79
5477:             .Height        = 22
5478:             .FontName      = "Tahoma"
5479:             .SpecialEffect = 1
5480:             .TabIndex      = 6
5481:             .ForeColor     = RGB(0, 0, 0)
5482:             .Value         = ""
5483:             .Visible       = .T.
5484:         ENDWITH
5485: 
5486:         loc_oSub.AddObject("cmd_4c_Ins", "CommandButton")
5487:         WITH loc_oSub.cmd_4c_Ins
5488:             .Top         = 36
5489:             .Left        = 330
5490:             .Width       = 37
5491:             .Height      = 22
5492:             .FontBold    = .T.
5493:             .FontItalic  = .T.
5494:             .FontName    = "Comic Sans MS"
5495:             .FontSize    = 8
5496:             .WordWrap    = .T.
5497:             .Caption     = "Ins"
5498:             .Enabled     = .T.
5499:             .TabIndex    = 10
5500:             .TabStop     = .F.
5501:             .ToolTipText = "insere a sequencia dos numeros dos cheques e mostra na grade"
5502:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 5508 a 5524:
5508: 
5509:     *--------------------------------------------------------------------------
5510:     * ConfigurarComboOperacao - cmbTOpers (troca rapida de operacao, disparado
5511:     * pelo cmd_4c_MudaOpe da barra de botoes). Original RowSourceType=1
5512:     * (Value); a lista de itens e populada em runtime (Fase 7-8, junto do
5513:     * evento de Click de cmd_4c_MudaOpe que a alimenta) - aqui so a moldura.
5514:     *--------------------------------------------------------------------------
5515:     PROTECTED PROCEDURE ConfigurarComboOperacao()
5516:         THIS.AddObject("cbo_4c_CmbTOpers", "ComboBox")
5517:         WITH THIS.cbo_4c_CmbTOpers
5518:             .Top            = 594
5519:             .Left           = 39
5520:             .Width          = 277
5521:             .Height         = 22
5522:             .FontName       = "Verdana"
5523:             .RowSourceType  = 1
5524:             .SpecialEffect  = 1

*-- Linhas 5745 a 5814:
5745: 
5746:         *-- Barra de botoes principal.
5747:         loc_oCnt = THIS.cnt_4c_Barra_Botoes
5748:         BINDEVENT(loc_oCnt.cmd_4c_Itens,      "Click", THIS, "CmdItensClick")
5749:         BINDEVENT(loc_oCnt.cmd_4c_Alteraqtd,  "Click", THIS, "CmdAlteraqtdClick")
5750:         BINDEVENT(loc_oCnt.cmd_4c_Desconto,   "Click", THIS, "CmdDescontoClick")
5751:         BINDEVENT(loc_oCnt.cmd_4c_Acrescimo,  "Click", THIS, "CmdAcrescimoClick")
5752:         BINDEVENT(loc_oCnt.cmd_4c_CancPagto,  "Click", THIS, "CmdCancPagtoClick")
5753:         BINDEVENT(loc_oCnt.cmd_4c_Apaga,      "Click", THIS, "CmdApagaClick")
5754:         BINDEVENT(loc_oCnt.cmd_4c_AltPreco,   "Click", THIS, "CmdAltPrecoClick")
5755:         BINDEVENT(loc_oCnt.cmd_4c_Identifica, "Click", THIS, "CmdIdentificaClick")
5756:         BINDEVENT(loc_oCnt.cmd_4c_Credito,    "Click", THIS, "CmdCreditoClick")
5757:         BINDEVENT(loc_oCnt.cmd_4c_Financia,   "Click", THIS, "CmdFinanciaClick")
5758:         BINDEVENT(loc_oCnt.cmd_4c_Pendencia,  "Click", THIS, "CmdPendenciaClick")
5759:         BINDEVENT(loc_oCnt.cmd_4c_VerPreco,   "Click", THIS, "CmdVerPrecoClick")
5760:         BINDEVENT(loc_oCnt.cmd_4c_Impfiscal,  "Click", THIS, "CmdImpfiscalClick")
5761:         BINDEVENT(loc_oCnt.cmd_4c_MudaOpe,    "Click", THIS, "CmdMudaOpeClick")
5762:         BINDEVENT(loc_oCnt.cmd_4c_Pagto,      "Click", THIS, "CmdPagtoClick")
5763:         BINDEVENT(loc_oCnt.cmd_4c_Ok,         "Click", THIS, "BtnConfirmarClick")
5764:         BINDEVENT(loc_oCnt.cmd_4c_Cancela,    "Click", THIS, "BtnCancelarClick")
5765: 
5766:         *-- Grade de codigos de barras do crediario (CntFinanc).
5767:         loc_oCnt = THIS.cnt_4c_Financ.cnt_4c__GrdBarra
5768:         BINDEVENT(loc_oCnt.cmd_4c_Inserir, "Click", THIS, "CmdInserirBarraClick")
5769:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "CmdExcluirBarraClick")
5770:         BINDEVENT(loc_oCnt.cmd_4c_OkBarra, "Click", THIS, "CmdOkBarraClick")
5771: 
5772:         *-- Sub-niveis/pendencias.
5773:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_BotPendentes, "Click", THIS, "CmdBotPendentesClick")
5774: 
5775:         *-- Painel de cancelamento de item.
5776:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_Ok,          "Click", THIS, "CancelaItemOkClick")
5777:         BINDEVENT(THIS.cnt_4c_CancelaItem.cmd_4c_CancelaDisp, "Click", THIS, "CancelaItemCancelaDispClick")
5778: 
5779:         *-- Painel de consulta de preco.
5780:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Command1, "Click", THIS, "ConsultaCommand1Click")
5781:         BINDEVENT(THIS.cnt_4c__Consulta.cmd_4c_Proximo,  "Click", THIS, "ConsultaProximoClick")
5782:         BINDEVENT(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto, "KeyPress", THIS, "ConsultaProdutoKeyPress")
5783: 
5784:         *-- Setas "Proximo" de cada tela.
5785:         BINDEVENT(THIS.cnt_4c_Item.cmd_4c_Proximo,        "Click", THIS, "ItemProximoClick")
5786:         BINDEVENT(THIS.cnt_4c_Financ.cmd_4c_Proximo,      "Click", THIS, "FinancProximoClick")
5787:         BINDEVENT(THIS.cnt_4c__Credito.cmd_4c_Proximo,    "Click", THIS, "CreditoProximoClick")
5788:         BINDEVENT(THIS.cnt_4c__Pendencia.cmd_4c_Proximo,  "Click", THIS, "PendenciaProximoClick")
5789:         BINDEVENT(THIS.cnt_4c__Identifica.cmd_4c_Proximo, "Click", THIS, "IdentificaProximoClick")
5790:         BINDEVENT(THIS.cnt_4c__Fpagto.cmd_4c_Proximo,     "Click", THIS, "FpagtoProximoClick")
5791: 
5792:         *-- Confirmacao manual do item (CntItem.Cnt_Produto.CmdEnviaProd) - so
5793:         *-- fica visivel quando o legado exige confirmar o preco alterado.
5794:         BINDEVENT(THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd, "Click", THIS, "CmdEnviaProdClick")
5795: 
5796:         *-- Atalho para o Cadastro de Contas a partir dos blocos Origem/Destino
5797:         *-- (btnCadastros de cada um).
5798:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Destino.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosDestinoClick")
5799:         BINDEVENT(THIS.cnt_4c__Identifica.cnt_4c_Origem.cmd_4c_BtnCadastros,  "Click", THIS, "BtnCadastrosOrigemClick")
5800: 
5801:         *-- Conferencia de cheque pre-datado (Cnt_ChequepreTef.Cnt_Chq).
5802:         loc_oCnt = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
5803:         BINDEVENT(loc_oCnt.cmd_4c_TefChq, "Click", THIS, "CmdTefChqClick")
5804:         BINDEVENT(loc_oCnt.cmd_4c_Ins,    "Click", THIS, "CmdInsChequeClick")
5805: 
5806:         *-- Combo de troca de operacao (Ctrl+F11).
5807:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress",  THIS, "CmbTOpersKeyPress")
5808:         BINDEVENT(THIS.cbo_4c_CmbTOpers, "KeyPress", THIS, "CmbTOpersLostFocus")
5809:     ENDPROC
5810: 
5811:     *--------------------------------------------------------------------------
5812:     * AlternarTelaOperacao - mostra EXATAMENTE um dos seis containers de
5813:     * operacao e esconde os outros cinco. No legado cada Click de
5814:     * identifica/credito/pendencia/Financia/Itens comeca zerando a

*-- Linhas 5955 a 5963:
5955:             .cnt_4c_Desconto.Visible   = .T.
5956:             .cnt_4c_Desconto.Enabled   = .T.
5957:             .txt_4c_TotLiquido.Visible = .T.
5958:             .lbl_4c_Label15.Visible    = .T.
5959:         ENDWITH
5960: 
5961:         THIS.AlternarTelaOperacao("FPAGTO")
5962:         THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Desconto.txt_4c_PorcVariacao)
5963:     ENDPROC

*-- Linhas 5985 a 5993:
5985:                 .cnt_4c_Acrescimo.Visible  = .T.
5986:                 .cnt_4c_Acrescimo.Enabled  = .T.
5987:                 .txt_4c_TotLiquido.Visible = .T.
5988:                 .lbl_4c_Label15.Visible    = .T.
5989:             ENDWITH
5990: 
5991:             THIS.AlternarTelaOperacao("FPAGTO")
5992:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cnt_4c_Acrescimo.txt_4c_PorcVariacao)
5993:         ENDIF

*-- Linhas 6139 a 6148:
6139:                 .ZOrder(0)
6140:             ENDIF
6141:             .cnt_4c__Produto.txt_4c_Produto.Value       = ""
6142:             .cnt_4c__Resultado.lbl_4c_Mensage1.Caption  = ""
6143:             .cnt_4c__Resultado.lbl_4c_Mensage2.Caption  = ""
6144:             .txt_4c_Unit.Value                          = 0
6145:         ENDWITH
6146: 
6147:         THIS.FocarControle(THIS.cnt_4c__Consulta.cnt_4c__Produto.txt_4c_Produto)
6148:     ENDPROC

*-- Linhas 6249 a 6257:
6249:         THIS.FocarControle(THIS.cnt_4c__Fpagto.txt_4c_Fpg)
6250:     ENDPROC
6251: 
6252:     *-- Confirmar (cmd_4c_Ok) - legado (Barra_Botoes.ok.Click, 25 linhas):
6253:     *-- valida sub-nivel/pagamento e chama AcioSalva() no ParentForm, que
6254:     *-- gravava o cursor de itens inteiro com TableUpdate na datasession
6255:     *-- COMPARTILHADA e fechava o cupom fiscal.
6256:     *--
6257:     *-- Aqui: sem item lancado, so fecha o Caixa; havendo itens, exige forma de

*-- Linhas 6306 a 6314:
6306:         THIS.Release()
6307:     ENDPROC
6308: 
6309:     *-- Cancelar (cmd_4c_Cancela, ESC) - encerra o Caixa e devolve o controle
6310:     *-- ao form pai (Destroy() ja reabilita this_oParentForm).
6311:     PROCEDURE BtnCancelarClick()
6312:         IF MsgConfirma("Deseja realmente cancelar e encerrar o Caixa?", "Cancelar")
6313:             THIS.Release()
6314:         ENDIF

*-- Linhas 6470 a 6485:
6470: 
6471:                 SELECT cursor_4c_ConsultaPreco
6472:                 GO TOP
6473:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6474:                     ALLTRIM(NVL(cursor_4c_ConsultaPreco.dpros, ""))
6475:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6476:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = NVL(cursor_4c_ConsultaPreco.pvens, 0)
6477:             ELSE
6478:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage1.Caption = ;
6479:                     "Produto n" + CHR(227) + "o encontrado."
6480:                 THIS.cnt_4c__Consulta.cnt_4c__Resultado.lbl_4c_Mensage2.Caption = ""
6481:                 THIS.cnt_4c__Consulta.txt_4c_Unit.Value = 0
6482:             ENDIF
6483: 
6484:             IF USED("cursor_4c_ConsultaPreco")
6485:                 USE IN cursor_4c_ConsultaPreco

*-- Linhas 6859 a 6897:
6859:             THIS.ExcluirItemCorrente()
6860:             THIS.LimparCntItem(.T.)
6861:         ELSE
6862:             THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = "Imprimindo Itens..."
6863: 
6864:             IF USED("crTpmMvItn") AND !EOF("crTpmMvItn")
6865:                 SELECT crTpmMvItn
6866:                 REPLACE ImpCupFis WITH .T.
6867:             ENDIF
6868: 
6869:             *-- Legado: "ThisForm.Barra_Botoes.Apaga.Enabled = .T."
6870:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Apaga.Enabled = .T.
6871: 
6872:             THIS.MontarLinhasCupom()
6873:             THIS.AtualizarGrades()
6874:             THIS.LimparCntItem(.T.)
6875:         ENDIF
6876: 
6877:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
6878:         THIS.LimparCntItem(.F.)
6879: 
6880:         THIS.cnt_4c_Item.cnt_4c__Produto.cmd_4c_CmdEnviaProd.Visible = .F.
6881:         THIS.FocarControle(THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto)
6882:     ENDPROC
6883: 
6884:     *--------------------------------------------------------------------------
6885:     * IdentificaProximoClick - seta "Proximo" da tela de Identificacao.
6886:     * Legado (Cnt_Identifica.Proximo.Click): "If Barra_Botoes.Itens.Visible /
6887:     * Itens.Click() ... Else / Pagto.SetFocus + Pagto.Click()". A troca de
6888:     * imagem da seta (GotFocus/LostFocus) e so visual e nao tem efeito de
6889:     * negocio.
6890:     *--------------------------------------------------------------------------
6891:     PROCEDURE IdentificaProximoClick()
6892:         IF THIS.cnt_4c_Barra_Botoes.cmd_4c_Itens.Visible
6893:             THIS.CmdItensClick()
6894:         ELSE
6895:             THIS.CmdPagtoClick()
6896:         ENDIF
6897:     ENDPROC

*-- Linhas 7107 a 7115:
7107: 
7108:         loc_oChq = THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.cnt_4c__Chq
7109: 
7110:         THIS.cnt_4c__Mensagem.lbl_4c_Mensagem.Caption = ""
7111:         THIS.this_lNoklostche = .T.
7112: 
7113:         IF !THIS.ValidarChequesLancados()
7114:             *-- Legado: "MessageBox('Cheque Invalido!!!',0+48,'')" + limpa +
7115:             *-- "Replace xPar.nidcheps with 0" + "Get_pca.SetFocus".

*-- Linhas 7137 a 7158:
7137:         THIS.cnt_4c__Fpagto.cnt_4c__ChequepreTef.Refresh()
7138: 
7139:         IF loc_nTotLiquido = loc_nTotForma AND loc_nTotLiquido != 0 AND loc_nTotForma != 0
7140:             THIS.cnt_4c_Barra_Botoes.cmd_4c_Cancela.Enabled = .T.
7141:             THIS.BtnConfirmarClick()
7142:         ELSE
7143:             THIS.FocarControle(THIS.cnt_4c__Fpagto.cmd_4c_Proximo)
7144:         ENDIF
7145:     ENDPROC
7146: 
7147:     *--------------------------------------------------------------------------
7148:     * CmdInsChequeClick - botao "Ins" do painel de cheque. ToolTipText do
7149:     * legado: "insere a sequencia dos numeros dos cheques e mostra na grade".
7150:     *
7151:     * Legado (Cnt_Chq.ins.Click): guarda os dados do cheque da linha CORRENTE
7152:     * de xPar (banco/agencia/conta/digitos/CPF/praca/numero), pula para a linha
7153:     * seguinte, limpa os campos de numero na tela e, da linha seguinte ate o
7154:     * fim, replica esses dados incrementando o numero do cheque de 1 em 1
7155:     * (Transform(...,'@L 999999')); no fim reordena, volta ao topo, refaz o
7156:     * bind da grade e poe o foco na coluna Valor.
7157:     *
7158:     * O SetAll('DynamicForeColor',...) do legado pinta a linha conforme

*-- Linhas 7648 a 7678:
7648:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Value, "")))
7649: 
7650:         *-- Navegacao entre telas - travada com o cheque pre-datado aberto.
7651:         loc_oCnt.cmd_4c_Itens.Enabled      = !loc_lChequeAberto
7652:         loc_oCnt.cmd_4c_Identifica.Enabled = (!loc_lChequeAberto AND ;
7653:             (loc_lInicia OR THIS.this_lLiberaident))
7654:         loc_oCnt.cmd_4c_Credito.Enabled    = (!loc_lChequeAberto AND loc_lInicia)
7655:         loc_oCnt.cmd_4c_Pendencia.Enabled  = (!loc_lChequeAberto AND loc_lInicia)
7656:         loc_oCnt.cmd_4c_Financia.Enabled   = (!loc_lChequeAberto AND loc_lInicia)
7657:         loc_oCnt.cmd_4c_Pagto.Enabled      = !loc_lChequeAberto
7658: 
7659:         *-- Acoes sobre o item corrente - so com o painel de Itens na frente e
7660:         *-- nenhum produto em digitacao.
7661:         loc_oCnt.cmd_4c_Apaga.Enabled     = (loc_lSemProduto AND loc_lItensVisivel)
7662:         loc_oCnt.cmd_4c_Alteraqtd.Enabled = (loc_lSemProduto AND loc_lItensVisivel AND ;
7663:             THIS.cnt_4c_Item.cnt_4c__Produto.txt_4c_Produto.Enabled)
7664: 
7665:         *-- Cancelamento de forma de pagamento - so na tela de Pagamento.
7666:         loc_oCnt.cmd_4c_CancPagto.Enabled = (loc_lFpagtoVisivel AND !loc_lChequeAberto)
7667: 
7668:         *-- Impressora fiscal.
7669:         loc_oCnt.cmd_4c_Impfiscal.Enabled = (loc_lSemProduto AND !loc_lChequeAberto)
7670: 
7671:         *-- Confirmar: no legado "Return (ThisForm.Inicia)". Cancelar fica
7672:         *-- SEMPRE disponivel (Cancel = .T. no SCX) - a saida da tela nunca
7673:         *-- pode ficar bloqueada.
7674:         loc_oCnt.cmd_4c_Ok.Enabled      = loc_lInicia
7675:         loc_oCnt.cmd_4c_Cancela.Enabled = .T.
7676:     ENDPROC
7677: 
7678: ENDDEFINE

