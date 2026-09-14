# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpPro' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecpe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1859 linhas total):

*-- Linhas 75 a 83:
75:         LOCAL loc_lSucesso
76:         loc_lSucesso = .F.
77:         TRY
78:             THIS.Caption = "Diverg" + CHR(234) + "ncias em estoques"
79: 
80:             IF TYPE("gc_4c_CaminhoIcones") = "U"
81:                 gc_4c_CaminhoIcones = ""
82:             ENDIF
83:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 103 a 112:
103:                 *-- Restaurar valores padr" + CHR(227) + "o dos filtros
104:                 THIS.LimparCampos()
105: 
106:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 *-- Vincular Click dos bot" + CHR(245) + "es de relat" + CHR(243) + "rio
110:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
111:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
112:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")

*-- Linhas 132 a 210:
132:     PROTECTED PROCEDURE ConfigurarCabecalho()
133:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH THIS.cnt_4c_Cabecalho
135:             .Top         = 0
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackStyle   = 1
140:             .BackColor   = RGB(100, 100, 100)
141:             .BorderWidth = 0
142:             .Visible     = .T.
143: 
144:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
145:             .AddObject("lbl_4c_Sombra", "Label")
146:             WITH .lbl_4c_Sombra
147:                 .Top       = 22
148:                 .Left      = 22
149:                 .Width     = THIS.Width
150:                 .Height    = 30
151:                 .Caption   = "Diverg" + CHR(234) + "ncias em estoques"
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 14
154:                 .FontBold  = .T.
155:                 .ForeColor = RGB(0, 0, 0)
156:                 .BackStyle = 0
157:                 .Visible   = .T.
158:             ENDWITH
159: 
160:             *-- T" + CHR(237) + "tulo em branco (sobre a sombra)
161:             .AddObject("lbl_4c_Titulo", "Label")
162:             WITH .lbl_4c_Titulo
163:                 .Top       = 20
164:                 .Left      = 20
165:                 .Width     = THIS.Width
166:                 .Height    = 30
167:                 .Caption   = "Diverg" + CHR(234) + "ncias em estoques"
168:                 .FontName  = "Tahoma"
169:                 .FontSize  = 14
170:                 .FontBold  = .T.
171:                 .ForeColor = RGB(255, 255, 255)
172:                 .BackStyle = 0
173:                 .Visible   = .T.
174:             ENDWITH
175:         ENDWITH
176:     ENDPROC
177: 
178:     *--------------------------------------------------------------------------
179:     * ConfigurarBotoes - CommandGroup de bot" + CHR(245) + "es do relat" + CHR(243) + "rio (btnReport area)
180:     *   Original: btnReport.Left=528, Top=3, Width=305, Height=85 (800px form)
181:     *   Novo sist: cmg_4c_Botoes.Left=529, Top=0, Width=273, Height=80 (1000px)
182:     *   Canonical: Visualizar(5), Imprimir(71), Excel(137), Encerrar(203) - W=65
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarBotoes()
185:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
186:         WITH THIS.cmg_4c_Botoes
187:             .Top           = 0
188:             .Left          = 529
189:             .Width         = 273
190:             .Height        = 80
191:             .ButtonCount   = 4
192:             .BackStyle     = 0
193:             .BorderStyle   = 0
194:             .BorderColor   = RGB(136, 189, 188)
195:             .SpecialEffect = 1
196:             .Themes        = .F.
197:             .Visible       = .T.
198: 
199:             *-- Visualizar (preview em tela)
200:             WITH .Buttons(1)
201:                 .Top             = 5
202:                 .Left            = 5
203:                 .Width           = 65
204:                 .Height          = 70
205:                 .Caption         = "Visualizar"
206:                 .FontBold        = .T.
207:                 .FontItalic      = .T.
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 218 a 230:
218: 
219:             *-- Imprimir (impressora com di" + CHR(225) + "logo de sele" + CHR(231) + CHR(227) + "o)
220:             WITH .Buttons(2)
221:                 .Top             = 5
222:                 .Left            = 71
223:                 .Width           = 65
224:                 .Height          = 70
225:                 .Caption         = "Imprimir"
226:                 .FontName        = "Tahoma"
227:                 .FontBold        = .T.
228:                 .FontItalic      = .T.
229:                 .FontSize        = 8
230:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 240 a 252:
240: 
241:             *-- Excel (exportar dados do cursor para planilha)
242:             WITH .Buttons(3)
243:                 .Top             = 5
244:                 .Left            = 137
245:                 .Width           = 65
246:                 .Height          = 70
247:                 .Caption         = "Excel"
248:                 .FontName        = "Tahoma"
249:                 .FontBold        = .T.
250:                 .FontItalic      = .T.
251:                 .FontSize        = 8
252:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 262 a 274:
262: 
263:             *-- Encerrar (fechar form - Cancel=.T. para ESC)
264:             WITH .Buttons(4)
265:                 .Top             = 5
266:                 .Left            = 203
267:                 .Width           = 65
268:                 .Height          = 70
269:                 .Caption         = "Encerrar"
270:                 .Cancel          = .T.
271:                 .FontName        = "Tahoma"
272:                 .FontBold        = .T.
273:                 .FontItalic      = .T.
274:                 .FontSize        = 8

*-- Linhas 302 a 317:
302:         loc_oPgf.PageCount = 1
303: 
304:         *-- Posicionamento: logo abaixo do cabe" + CHR(231) + "alho (80px) ate o fim do form
305:         loc_oPgf.Top    = 85
306:         loc_oPgf.Left   = -1
307:         loc_oPgf.Width  = THIS.Width + 2
308:         loc_oPgf.Height = THIS.Height - 85
309:         loc_oPgf.Tabs   = .F.
310: 
311:         *-- Configurar Page1 (FORA de qualquer WITH - usar refer" + CHR(234) + "ncia direta)
312:         loc_oPgf.Page1.Caption   = "Filtros"
313:         loc_oPgf.Page1.FontName  = "Tahoma"
314:         loc_oPgf.Page1.FontSize  = 8
315:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
316:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
317:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 633 a 1190:
633: 
634:             *-- ====== SECAO: Filtro de Produto (original top 139..280) ======
635: 
636:             loc_oPg.AddObject("lbl_4c_FiltProd", "Label")
637:             WITH loc_oPg.lbl_4c_FiltProd
638:                 .Top       = 54
639:                 .Left      = 195
640:                 .Width     = 107
641:                 .Height    = 16
642:                 .Caption   = "Filtro de Produto"
643:                 .FontName  = "Tahoma"
644:                 .FontSize  = 8
645:                 .FontBold  = .T.
646:                 .ForeColor = RGB(0, 0, 128)
647:                 .BackStyle = 0
648:                 .Visible   = .T.
649:             ENDWITH
650: 
651:             *-- Grupo (cgrus) inicial
652:             loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
653:             WITH loc_oPg.lbl_4c_LblGrupo
654:                 .Top      = 76
655:                 .Left     = 231
656:                 .Width    = 41
657:                 .Height   = 15
658:                 .Caption  = "Grupo : "
659:                 .FontName = "Tahoma"
660:                 .FontSize = 8
661:                 .BackStyle = 0
662:                 .Visible  = .T.
663:             ENDWITH
664: 
665:             loc_oPg.AddObject("txt_4c_Cgrui", "TextBox")
666:             WITH loc_oPg.txt_4c_Cgrui
667:                 .Top      = 71
668:                 .Left     = 276
669:                 .Width    = 31
670:                 .Height   = 23
671:                 .Value    = ""
672:                 .FontName = "Tahoma"
673:                 .FontSize = 8
674:                 .Visible  = .T.
675:             ENDWITH
676: 
677:             loc_oPg.AddObject("lbl_4c_Ate1", "Label")
678:             WITH loc_oPg.lbl_4c_Ate1
679:                 .Top      = 76
680:                 .Left     = 314
681:                 .Width    = 30
682:                 .Height   = 15
683:                 .Caption  = "at" + CHR(233) + " :"
684:                 .FontName = "Tahoma"
685:                 .FontSize = 8
686:                 .BackStyle = 0
687:                 .Visible  = .T.
688:             ENDWITH
689: 
690:             loc_oPg.AddObject("txt_4c_Cgruf", "TextBox")
691:             WITH loc_oPg.txt_4c_Cgruf
692:                 .Top      = 71
693:                 .Left     = 341
694:                 .Width    = 31
695:                 .Height   = 23
696:                 .Value    = ""
697:                 .FontName = "Tahoma"
698:                 .FontSize = 8
699:                 .Visible  = .T.
700:             ENDWITH
701: 
702:             *-- Unidade (cunis) inicial
703:             loc_oPg.AddObject("lbl_4c_LblUnidade", "Label")
704:             WITH loc_oPg.lbl_4c_LblUnidade
705:                 .Top      = 98
706:                 .Left     = 221
707:                 .Width    = 51
708:                 .Height   = 15
709:                 .Caption  = "Unidade : "
710:                 .FontName = "Tahoma"
711:                 .FontSize = 8
712:                 .BackStyle = 0
713:                 .Visible  = .T.
714:             ENDWITH
715: 
716:             loc_oPg.AddObject("txt_4c_Cunii", "TextBox")
717:             WITH loc_oPg.txt_4c_Cunii
718:                 .Top      = 95
719:                 .Left     = 276
720:                 .Width    = 31
721:                 .Height   = 23
722:                 .Value    = ""
723:                 .FontName = "Tahoma"
724:                 .FontSize = 8
725:                 .Visible  = .T.
726:             ENDWITH
727: 
728:             loc_oPg.AddObject("lbl_4c_Ate2", "Label")
729:             WITH loc_oPg.lbl_4c_Ate2
730:                 .Top      = 98
731:                 .Left     = 314
732:                 .Width    = 30
733:                 .Height   = 15
734:                 .Caption  = "at" + CHR(233) + " :"
735:                 .FontName = "Tahoma"
736:                 .FontSize = 8
737:                 .BackStyle = 0
738:                 .Visible  = .T.
739:             ENDWITH
740: 
741:             loc_oPg.AddObject("txt_4c_Cunif", "TextBox")
742:             WITH loc_oPg.txt_4c_Cunif
743:                 .Top      = 95
744:                 .Left     = 341
745:                 .Width    = 31
746:                 .Height   = 23
747:                 .Value    = ""
748:                 .FontName = "Tahoma"
749:                 .FontSize = 8
750:                 .Visible  = .T.
751:             ENDWITH
752: 
753:             *-- Linha (linhas) inicial
754:             loc_oPg.AddObject("lbl_4c_LblLinha", "Label")
755:             WITH loc_oPg.lbl_4c_LblLinha
756:                 .Top      = 122
757:                 .Left     = 235
758:                 .Width    = 37
759:                 .Height   = 15
760:                 .Caption  = "Linha : "
761:                 .FontName = "Tahoma"
762:                 .FontSize = 8
763:                 .BackStyle = 0
764:                 .Visible  = .T.
765:             ENDWITH
766: 
767:             loc_oPg.AddObject("txt_4c_Lini", "TextBox")
768:             WITH loc_oPg.txt_4c_Lini
769:                 .Top      = 119
770:                 .Left     = 276
771:                 .Width    = 80
772:                 .Height   = 23
773:                 .Value    = ""
774:                 .FontName = "Tahoma"
775:                 .FontSize = 8
776:                 .Visible  = .T.
777:             ENDWITH
778: 
779:             loc_oPg.AddObject("lbl_4c_Ate3", "Label")
780:             WITH loc_oPg.lbl_4c_Ate3
781:                 .Top      = 122
782:                 .Left     = 361
783:                 .Width    = 30
784:                 .Height   = 15
785:                 .Caption  = "at" + CHR(233) + " :"
786:                 .FontName = "Tahoma"
787:                 .FontSize = 8
788:                 .BackStyle = 0
789:                 .Visible  = .T.
790:             ENDWITH
791: 
792:             loc_oPg.AddObject("txt_4c_Linf", "TextBox")
793:             WITH loc_oPg.txt_4c_Linf
794:                 .Top      = 119
795:                 .Left     = 385
796:                 .Width    = 80
797:                 .Height   = 23
798:                 .Value    = ""
799:                 .FontName = "Tahoma"
800:                 .FontSize = 8
801:                 .Visible  = .T.
802:             ENDWITH
803: 
804:             *-- Grupo de Venda / Colecao (colecoes)
805:             loc_oPg.AddObject("lbl_4c_LblGrupoVenda", "Label")
806:             WITH loc_oPg.lbl_4c_LblGrupoVenda
807:                 .Top      = 146
808:                 .Left     = 195
809:                 .Width    = 77
810:                 .Height   = 15
811:                 .Caption  = "Grupo  Venda : "
812:                 .FontName = "Tahoma"
813:                 .FontSize = 8
814:                 .BackStyle = 0
815:                 .Visible  = .T.
816:             ENDWITH
817: 
818:             loc_oPg.AddObject("txt_4c_Coli", "TextBox")
819:             WITH loc_oPg.txt_4c_Coli
820:                 .Top      = 143
821:                 .Left     = 276
822:                 .Width    = 80
823:                 .Height   = 23
824:                 .Value    = ""
825:                 .FontName = "Tahoma"
826:                 .FontSize = 8
827:                 .Visible  = .T.
828:             ENDWITH
829: 
830:             loc_oPg.AddObject("lbl_4c_Ate4", "Label")
831:             WITH loc_oPg.lbl_4c_Ate4
832:                 .Top      = 146
833:                 .Left     = 361
834:                 .Width    = 30
835:                 .Height   = 15
836:                 .Caption  = "at" + CHR(233) + " :"
837:                 .FontName = "Tahoma"
838:                 .FontSize = 8
839:                 .BackStyle = 0
840:                 .Visible  = .T.
841:             ENDWITH
842: 
843:             loc_oPg.AddObject("txt_4c_Colf", "TextBox")
844:             WITH loc_oPg.txt_4c_Colf
845:                 .Top      = 143
846:                 .Left     = 385
847:                 .Width    = 80
848:                 .Height   = 23
849:                 .Value    = ""
850:                 .FontName = "Tahoma"
851:                 .FontSize = 8
852:                 .Visible  = .T.
853:             ENDWITH
854: 
855:             *-- Situacao
856:             loc_oPg.AddObject("lbl_4c_LblSituacao", "Label")
857:             WITH loc_oPg.lbl_4c_LblSituacao
858:                 .Top      = 170
859:                 .Left     = 219
860:                 .Width    = 60
861:                 .Height   = 15
862:                 .Caption  = "Situa" + CHR(231) + CHR(227) + "o : "
863:                 .FontName = "Tahoma"
864:                 .FontSize = 8
865:                 .BackStyle = 0
866:                 .Visible  = .T.
867:             ENDWITH
868: 
869:             loc_oPg.AddObject("opt_4c_Situacao", "OptionGroup")
870:             loc_oPg.opt_4c_Situacao.ButtonCount = 3
871:             WITH loc_oPg.opt_4c_Situacao
872:                 .Top         = 169
873:                 .Left        = 276
874:                 .Width       = 188
875:                 .Height      = 22
876:                 .BackStyle   = 0
877:                 .BorderStyle = 0
878:                 .Value       = 3
879:                 .Visible     = .T.
880:                 .Buttons(1).Caption  = "Ativos"
881:                 .Buttons(1).FontName = "Tahoma"
882:                 .Buttons(1).FontSize = 8
883:                 .Buttons(1).Width    = 62
884:                 .Buttons(2).Caption  = "Inativos"
885:                 .Buttons(2).FontName = "Tahoma"
886:                 .Buttons(2).FontSize = 8
887:                 .Buttons(2).Left     = 63
888:                 .Buttons(2).Width    = 62
889:                 .Buttons(3).Caption  = "Todos"
890:                 .Buttons(3).FontName = "Tahoma"
891:                 .Buttons(3).FontSize = 8
892:                 .Buttons(3).Left     = 126
893:                 .Buttons(3).Width    = 62
894:             ENDWITH
895: 
896:             *-- ====== SECAO: Estoque A (original top 282..355) ======
897: 
898:             loc_oPg.AddObject("lbl_4c_EstoqueA", "Label")
899:             WITH loc_oPg.lbl_4c_EstoqueA
900:                 .Top       = 197
901:                 .Left      = 195
902:                 .Width     = 65
903:                 .Height    = 16
904:                 .Caption   = "Estoque A"
905:                 .FontName  = "Tahoma"
906:                 .FontSize  = 8
907:                 .FontBold  = .T.
908:                 .ForeColor = RGB(0, 0, 128)
909:                 .BackStyle = 0
910:                 .Visible   = .T.
911:             ENDWITH
912: 
913:             loc_oPg.AddObject("lbl_4c_LblGrEstA", "Label")
914:             WITH loc_oPg.lbl_4c_LblGrEstA
915:                 .Top      = 221
916:                 .Left     = 192
917:                 .Width    = 95
918:                 .Height   = 16
919:                 .Caption  = "Grupo de Estoque :"
920:                 .FontName = "Tahoma"
921:                 .FontSize = 8
922:                 .BackStyle = 0
923:                 .Visible  = .T.
924:             ENDWITH
925: 
926:             loc_oPg.AddObject("txt_4c_CdGrEstoqueA", "TextBox")
927:             WITH loc_oPg.txt_4c_CdGrEstoqueA
928:                 .Top      = 216
929:                 .Left     = 300
930:                 .Width    = 80
931:                 .Height   = 25
932:                 .Value    = ""
933:                 .FontName = "Tahoma"
934:                 .FontSize = 8
935:                 .Visible  = .T.
936:             ENDWITH
937: 
938:             loc_oPg.AddObject("txt_4c_DsGrEstoqueA", "TextBox")
939:             WITH loc_oPg.txt_4c_DsGrEstoqueA
940:                 .Top      = 216
941:                 .Left     = 380
942:                 .Width    = 290
943:                 .Height   = 25
944:                 .Value    = ""
945:                 .FontName = "Tahoma"
946:                 .FontSize = 8
947:                 .ReadOnly = .T.
948:                 .Visible  = .T.
949:             ENDWITH
950: 
951:             loc_oPg.AddObject("lbl_4c_LblEstA", "Label")
952:             WITH loc_oPg.lbl_4c_LblEstA
953:                 .Top      = 246
954:                 .Left     = 246
955:                 .Width    = 48
956:                 .Height   = 16
957:                 .Caption  = "Estoque :"
958:                 .FontName = "Tahoma"
959:                 .FontSize = 8
960:                 .BackStyle = 0
961:                 .Visible  = .T.
962:             ENDWITH
963: 
964:             loc_oPg.AddObject("txt_4c_CdEstoqueA", "TextBox")
965:             WITH loc_oPg.txt_4c_CdEstoqueA
966:                 .Top      = 241
967:                 .Left     = 300
968:                 .Width    = 80
969:                 .Height   = 25
970:                 .Value    = ""
971:                 .FontName = "Tahoma"
972:                 .FontSize = 8
973:                 .Visible  = .T.
974:             ENDWITH
975: 
976:             loc_oPg.AddObject("txt_4c_DsEstoqueA", "TextBox")
977:             WITH loc_oPg.txt_4c_DsEstoqueA
978:                 .Top      = 241
979:                 .Left     = 380
980:                 .Width    = 290
981:                 .Height   = 25
982:                 .Value    = ""
983:                 .FontName = "Tahoma"
984:                 .FontSize = 8
985:                 .ReadOnly = .T.
986:                 .Visible  = .T.
987:             ENDWITH
988: 
989:             *-- ====== SECAO: Estoque B (original top 354..430) ======
990: 
991:             loc_oPg.AddObject("lbl_4c_EstoqueB", "Label")
992:             WITH loc_oPg.lbl_4c_EstoqueB
993:                 .Top       = 269
994:                 .Left      = 195
995:                 .Width     = 64
996:                 .Height    = 16
997:                 .Caption   = "Estoque B"
998:                 .FontName  = "Tahoma"
999:                 .FontSize  = 8
1000:                 .FontBold  = .T.
1001:                 .ForeColor = RGB(0, 0, 128)
1002:                 .BackStyle = 0
1003:                 .Visible   = .T.
1004:             ENDWITH
1005: 
1006:             loc_oPg.AddObject("lbl_4c_LblGrEstB", "Label")
1007:             WITH loc_oPg.lbl_4c_LblGrEstB
1008:                 .Top      = 293
1009:                 .Left     = 192
1010:                 .Width    = 95
1011:                 .Height   = 16
1012:                 .Caption  = "Grupo de Estoque :"
1013:                 .FontName = "Tahoma"
1014:                 .FontSize = 8
1015:                 .BackStyle = 0
1016:                 .Visible  = .T.
1017:             ENDWITH
1018: 
1019:             loc_oPg.AddObject("txt_4c_CdGrupoB", "TextBox")
1020:             WITH loc_oPg.txt_4c_CdGrupoB
1021:                 .Top      = 288
1022:                 .Left     = 300
1023:                 .Width    = 80
1024:                 .Height   = 25
1025:                 .Value    = ""
1026:                 .FontName = "Tahoma"
1027:                 .FontSize = 8
1028:                 .Visible  = .T.
1029:             ENDWITH
1030: 
1031:             loc_oPg.AddObject("txt_4c_DsGrupoB", "TextBox")
1032:             WITH loc_oPg.txt_4c_DsGrupoB
1033:                 .Top      = 288
1034:                 .Left     = 380
1035:                 .Width    = 290
1036:                 .Height   = 25
1037:                 .Value    = ""
1038:                 .FontName = "Tahoma"
1039:                 .FontSize = 8
1040:                 .ReadOnly = .T.
1041:                 .Visible  = .T.
1042:             ENDWITH
1043: 
1044:             loc_oPg.AddObject("lbl_4c_LblEstB", "Label")
1045:             WITH loc_oPg.lbl_4c_LblEstB
1046:                 .Top      = 318
1047:                 .Left     = 246
1048:                 .Width    = 48
1049:                 .Height   = 16
1050:                 .Caption  = "Estoque :"
1051:                 .FontName = "Tahoma"
1052:                 .FontSize = 8
1053:                 .BackStyle = 0
1054:                 .Visible  = .T.
1055:             ENDWITH
1056: 
1057:             loc_oPg.AddObject("txt_4c_CdContaB", "TextBox")
1058:             WITH loc_oPg.txt_4c_CdContaB
1059:                 .Top      = 313
1060:                 .Left     = 300
1061:                 .Width    = 80
1062:                 .Height   = 25
1063:                 .Value    = ""
1064:                 .FontName = "Tahoma"
1065:                 .FontSize = 8
1066:                 .Visible  = .T.
1067:             ENDWITH
1068: 
1069:             loc_oPg.AddObject("txt_4c_DsContaB", "TextBox")
1070:             WITH loc_oPg.txt_4c_DsContaB
1071:                 .Top      = 313
1072:                 .Left     = 380
1073:                 .Width    = 290
1074:                 .Height   = 25
1075:                 .Value    = ""
1076:                 .FontName = "Tahoma"
1077:                 .FontSize = 8
1078:                 .ReadOnly = .T.
1079:                 .Visible  = .T.
1080:             ENDWITH
1081: 
1082:             *-- ====== SECAO: Opcoes de Comparacao (original top 430..490) ======
1083: 
1084:             loc_oPg.AddObject("lbl_4c_LblCorTam", "Label")
1085:             WITH loc_oPg.lbl_4c_LblCorTam
1086:                 .Top      = 351
1087:                 .Left     = 219
1088:                 .Width    = 115
1089:                 .Height   = 16
1090:                 .Caption  = "Analisar Cor/Tamanho :"
1091:                 .FontName = "Tahoma"
1092:                 .FontSize = 8
1093:                 .BackStyle = 0
1094:                 .Visible  = .T.
1095:             ENDWITH
1096: 
1097:             loc_oPg.AddObject("opt_4c_CorTam", "OptionGroup")
1098:             loc_oPg.opt_4c_CorTam.ButtonCount = 2
1099:             WITH loc_oPg.opt_4c_CorTam
1100:                 .Top         = 345
1101:                 .Left        = 347
1102:                 .Width       = 97
1103:                 .Height      = 23
1104:                 .BackStyle   = 0
1105:                 .BorderStyle = 0
1106:                 .Value       = 2
1107:                 .Visible     = .T.
1108:                 .Buttons(1).Caption  = "Sim"
1109:                 .Buttons(1).FontName = "Tahoma"
1110:                 .Buttons(1).FontSize = 8
1111:                 .Buttons(1).Width    = 48
1112:                 .Buttons(2).Caption  = "N" + CHR(227) + "o"
1113:                 .Buttons(2).FontName = "Tahoma"
1114:                 .Buttons(2).FontSize = 8
1115:                 .Buttons(2).Left     = 49
1116:                 .Buttons(2).Width    = 48
1117:             ENDWITH
1118: 
1119:             loc_oPg.AddObject("lbl_4c_LblTipo", "Label")
1120:             WITH loc_oPg.lbl_4c_LblTipo
1121:                 .Top      = 371
1122:                 .Left     = 301
1123:                 .Width    = 43
1124:                 .Height   = 15
1125:                 .Caption  = "Analisar "
1126:                 .FontName = "Tahoma"
1127:                 .FontSize = 8
1128:                 .BackStyle = 0
1129:                 .Visible  = .T.
1130:             ENDWITH
1131: 
1132:             loc_oPg.AddObject("opt_4c_Tipo", "OptionGroup")
1133:             loc_oPg.opt_4c_Tipo.ButtonCount = 2
1134:             WITH loc_oPg.opt_4c_Tipo
1135:                 .Top         = 365
1136:                 .Left        = 347
1137:                 .Width       = 303
1138:                 .Height      = 25
1139:                 .BackStyle   = 0
1140:                 .BorderStyle = 0
1141:                 .Value       = 1
1142:                 .Visible     = .T.
1143:                 .Buttons(1).Caption  = "Estoque x Estoque"
1144:                 .Buttons(1).FontName = "Tahoma"
1145:                 .Buttons(1).FontSize = 8
1146:                 .Buttons(1).Width    = 150
1147:                 .Buttons(2).Caption  = "Produto x Estoque"
1148:                 .Buttons(2).FontName = "Tahoma"
1149:                 .Buttons(2).FontSize = 8
1150:                 .Buttons(2).Left     = 151
1151:                 .Buttons(2).Width    = 150
1152:             ENDWITH
1153: 
1154:             loc_oPg.AddObject("lbl_4c_LblReff", "Label")
1155:             WITH loc_oPg.lbl_4c_LblReff
1156:                 .Top      = 392
1157:                 .Left     = 189
1158:                 .Width    = 145
1159:                 .Height   = 16
1160:                 .Caption  = "Analisar por Ref.Fornecedor :"
1161:                 .FontName = "Tahoma"
1162:                 .FontSize = 8
1163:                 .BackStyle = 0
1164:                 .Visible  = .T.
1165:             ENDWITH
1166: 
1167:             loc_oPg.AddObject("opt_4c_Reff", "OptionGroup")
1168:             loc_oPg.opt_4c_Reff.ButtonCount = 2
1169:             WITH loc_oPg.opt_4c_Reff
1170:                 .Top         = 386
1171:                 .Left        = 347
1172:                 .Width       = 97
1173:                 .Height      = 23
1174:                 .BackStyle   = 0
1175:                 .BorderStyle = 0
1176:                 .Value       = 2
1177:                 .Visible     = .T.
1178:                 .Buttons(1).Caption  = "Sim"
1179:                 .Buttons(1).FontName = "Tahoma"
1180:                 .Buttons(1).FontSize = 8
1181:                 .Buttons(1).Width    = 48
1182:                 .Buttons(2).Caption  = "N" + CHR(227) + "o"
1183:                 .Buttons(2).FontName = "Tahoma"
1184:                 .Buttons(2).FontSize = 8
1185:                 .Buttons(2).Left     = 49
1186:                 .Buttons(2).Width    = 48
1187:             ENDWITH
1188: 
1189:             *-- ====== BINDEVENTS - KeyPress handlers (PUBLIC - contrato BINDEVENT) ======
1190: 


### BO (C:\4c\projeto\app\classes\sigrecpeBO.prg):
*==============================================================================
* sigrecpeBO.prg
* Business Object para relatorio: Divergencias em Estoques
* Herda de: RelatorioBase
*==============================================================================

DEFINE CLASS sigrecpeBO AS RelatorioBase

    *-- Cursor de resultado do relatorio
    this_cCursorDados    = "cursor_4c_Dados"

    *-- Estoque A - Grupo e Conta
    this_cCdGrEstoqueA   = ""
    this_cDsGrEstoqueA   = ""
    this_cCdEstoqueA     = ""
    this_cDsEstoqueA     = ""

    *-- Estoque B - Grupo e Conta
    this_cCdGrupoB       = ""
    this_cDsGrupoB       = ""
    this_cCdContaB       = ""
    this_cDsContaB       = ""

    *-- Opcoes de comparacao (valores default iguais ao legado)
    this_nTipo           = 1
    this_nCorTam         = 2
    this_nReff           = 2
    this_nSituacao       = 3

    *-- Filtros de produto (intervalo inicial/final)
    this_cCgrui          = ""
    this_cCgruf          = ""
    this_cCunii          = ""
    this_cCunif          = ""
    this_cLini           = ""
    this_cLinf           = ""
    this_cColi           = ""
    this_cColf           = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de um cursor de preset
    * Para BO de relatorio: permite reaplicar parametros salvos previamente
    * par_cAliasCursor: nome do alias com colunas de filtro (formato preset)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                EXIT
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                EXIT
            ENDIF

            *-- SCATTER MEMVAR para acessar colunas dinamicamente
            SCATTER MEMVAR

            *-- Estoque A
            IF TYPE("m.cCdGrEstoqueA") = "C"
                THIS.this_cCdGrEstoqueA = ALLTRIM(m.cCdGrEstoqueA)
            ENDIF
            IF TYPE("m.cDsGrEstoqueA") = "C"
                THIS.this_cDsGrEstoqueA = ALLTRIM(m.cDsGrEstoqueA)
            ENDIF
            IF TYPE("m.cCdEstoqueA") = "C"
                THIS.this_cCdEstoqueA = ALLTRIM(m.cCdEstoqueA)
            ENDIF
            IF TYPE("m.cDsEstoqueA") = "C"
                THIS.this_cDsEstoqueA = ALLTRIM(m.cDsEstoqueA)
            ENDIF

            *-- Estoque B
            IF TYPE("m.cCdGrupoB") = "C"
                THIS.this_cCdGrupoB = ALLTRIM(m.cCdGrupoB)
            ENDIF
            IF TYPE("m.cDsGrupoB") = "C"
                THIS.this_cDsGrupoB = ALLTRIM(m.cDsGrupoB)
            ENDIF
            IF TYPE("m.cCdContaB") = "C"
                THIS.this_cCdContaB = ALLTRIM(m.cCdContaB)
            ENDIF
            IF TYPE("m.cDsContaB") = "C"
                THIS.this_cDsContaB = ALLTRIM(m.cDsContaB)
            ENDIF

            *-- Opcoes de comparacao
            IF TYPE("m.nTipo") = "N"
                THIS.this_nTipo = m.nTipo
            ENDIF
            IF TYPE("m.nCorTam") = "N"
                THIS.this_nCorTam = m.nCorTam
            ENDIF
            IF TYPE("m.nReff") = "N"
                THIS.this_nReff = m.nReff
            ENDIF
            IF TYPE("m.nSituacao") = "N"
                THIS.this_nSituacao = m.nSituacao
            ENDIF

            *-- Filtros de produto
            IF TYPE("m.cCgrui") = "C"
                THIS.this_cCgrui = ALLTRIM(m.cCgrui)
            ENDIF
            IF TYPE("m.cCgruf") = "C"
                THIS.this_cCgruf = ALLTRIM(m.cCgruf)
            ENDIF
            IF TYPE("m.cCunii") = "C"
                THIS.this_cCunii = ALLTRIM(m.cCunii)
            ENDIF
            IF TYPE("m.cCunif") = "C"
                THIS.this_cCunif = ALLTRIM(m.cCunif)
            ENDIF
            IF TYPE("m.cLini") = "C"
                THIS.this_cLini = ALLTRIM(m.cLini)
            ENDIF
            IF TYPE("m.cLinf") = "C"
                THIS.this_cLinf = ALLTRIM(m.cLinf)
            ENDIF
            IF TYPE("m.cColi") = "C"
                THIS.this_cColi = ALLTRIM(m.cColi)
            ENDIF
            IF TYPE("m.cColf") = "C"
                THIS.this_cColf = ALLTRIM(m.cColf)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o relatorio enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida filtros obrigatorios, delega para Imprimir() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para gerar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Imprimir()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("IMPRESSAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o relatorio em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Valida filtros obrigatorios, delega para Visualizar() e registra auditoria
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF EMPTY(THIS.this_cCdGrupoB) OR EMPTY(THIS.this_cCdContaB)
                    THIS.this_cMensagemErro = "Estoque B (Grupo e Conta) " + ;
                                              CHR(233) + " obrigat" + CHR(243) + "rio para visualizar relat" + ;
                                              CHR(243) + "rio"
                    EXIT
                ENDIF
                IF THIS.this_nTipo = 1
                    IF EMPTY(THIS.this_cCdGrEstoqueA) OR EMPTY(THIS.this_cCdEstoqueA)
                        THIS.this_cMensagemErro = "Estoque A (Grupo e Conta) " + ;
                                                  CHR(233) + " obrigat" + CHR(243) + "rio no tipo Estoque vs Estoque"
                        EXIT
                    ENDIF
                ENDIF

                loc_lSucesso = THIS.Visualizar()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("VISUALIZACAO")
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros (para auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TP="    + ALLTRIM(STR(THIS.this_nTipo,1)) + ;
                     ";GA="   + ALLTRIM(THIS.this_cCdGrEstoqueA) + ;
                     ";EA="   + ALLTRIM(THIS.this_cCdEstoqueA) + ;
                     ";GB="   + ALLTRIM(THIS.this_cCdGrupoB) + ;
                     ";EB="   + ALLTRIM(THIS.this_cCdContaB) + ;
                     ";CT="   + ALLTRIM(STR(THIS.this_nCorTam,1)) + ;
                     ";RF="   + ALLTRIM(STR(THIS.this_nReff,1)) + ;
                     ";SIT="  + ALLTRIM(STR(THIS.this_nSituacao,1)) + ;
                     ";GRU="  + ALLTRIM(THIS.this_cCgrui) + "-" + ALLTRIM(THIS.this_cCgruf) + ;
                     ";UNI="  + ALLTRIM(THIS.this_cCunii) + "-" + ALLTRIM(THIS.this_cCunif) + ;
                     ";LIN="  + ALLTRIM(THIS.this_cLini)  + "-" + ALLTRIM(THIS.this_cLinf) + ;
                     ";COL="  + ALLTRIM(THIS.this_cColi)  + "-" + ALLTRIM(THIS.this_cColf)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: IMPRESSAO, VISUALIZACAO, EXCEL
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpE") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            *-- Falha de auditoria nao deve impedir geracao do relatorio
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cGrupoA, loc_cEstoqA, loc_cGrupoB, loc_cEstoqB
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2
        LOCAL loc_cEmps

        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cEmps   = go_4c_Sistema.cCodEmpresa
                loc_cGrupoA = PADR(THIS.this_cCdGrEstoqueA, 10)
                loc_cEstoqA = PADR(THIS.this_cCdEstoqueA,   10)
                loc_cGrupoB = PADR(THIS.this_cCdGrupoB,     10)
                loc_cEstoqB = PADR(THIS.this_cCdContaB,     10)

                *-- Obter nome da empresa
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar empresa"
                    EXIT
                ENDIF
                SELECT cursor_4c_TmpEmp
                loc_cNomeEmpresa = IIF(!EOF(), ALLTRIM(Razas), "")
                USE IN cursor_4c_TmpEmp

                *-- Montar titulos do relatorio (CHR: 234=e-circunflex)
                loc_cRelTitulo  = "Diverg" + CHR(234) + "ncias entre Estoque"
                loc_cRelTitulo2 = "Estoque A :" + loc_cGrupoA + "/" + loc_cEstoqA + ;
                                  " - Estoque B :" + loc_cGrupoB + "/" + loc_cEstoqB

                *-- Criar cursor de cabecalho para o FRX
                IF USED("cscabecalho")
                    USE IN cscabecalho
                ENDIF
                CREATE CURSOR cscabecalho (NomeEmpresa C(80), RelTitulo C(80), RelTitulo2 C(80))
                INSERT INTO cscabecalho (NomeEmpresa, RelTitulo, RelTitulo2) ;
                    VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitulo2)

                *-- Carregar movimentos de estoque do SQL Server
                IF USED("cursor_4c_LocalEst")
                    USE IN cursor_4c_LocalEst
                ENDIF
                loc_cSQL = "SELECT * FROM SigMvEst WHERE Emps = " + EscaparSQL(loc_cEmps) + " AND Sqtds > 0"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEst")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar movimentos de estoque"
                    EXIT
                ENDIF

                *-- Carregar cadastro de produtos do SQL Server
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros, cproEqs, Reffs, cgrus, dpros, " + ;
                           "Cunis, Linhas, Colecoes, situas FROM SigCdPro"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao carregar produtos"
                    EXIT
                ENDIF

                *-- Fechar cursor resultado anterior
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                *-- Executar comparacao conforme tipo selecionado
                IF THIS.this_nTipo = 1
                    THIS.ExecutarComparacaoEstoqueAvsB(loc_cGrupoA, loc_cEstoqA, ;
                        loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ELSE
                    THIS.ExecutarComparacaoProdutosVsB(loc_cGrupoB, loc_cEstoqB, loc_cEmps)
                ENDIF

                SELECT cursor_4c_Dados
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoEstoqueAvsB - Tipo 1: itens do Estoque A ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoEstoqueAvsB(par_cGrupoA, par_cEstoqA, ;
                                                       par_cGrupoB, par_cEstoqB, ;
                                                       par_cEmps)
        IF THIS.this_nCorTam = 1
            *-- Analisa por Cor/Tamanho: chave composta Cpros+CodCors+CodTams
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros + a.CodCors + a.CodTams NOT IN ;
                      (SELECT Cpros + CodCors + CodTams FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ELSE
            *-- Analisa somente por produto (Cpros)
            SELECT a.*, b.Dpros ;
                FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                WHERE a.Grupos = par_cGrupoA AND a.Estos = par_cEstoqA ;
                  AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                  AND a.Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND a.Cpros = b.Cpros ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY a.Cpros, a.CodCors, a.CodTams
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarComparacaoProdutosVsB - Tipo 2: produtos filtrados ausentes no B
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarComparacaoProdutosVsB(par_cGrupoB, par_cEstoqB, par_cEmps)
        LOCAL loc_cWhere, loc_cInicio, loc_cFinal

        *-- Montar clausula WHERE para filtros de produto
        loc_cWhere = ".T."

        *-- Filtro de Grupo (cgrus)
        loc_cInicio = ALLTRIM(THIS.this_cCgrui)
        loc_cFinal  = ALLTRIM(THIS.this_cCgruf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND cgrus >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND cgrus <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Unidade (Cunis)
        loc_cInicio = ALLTRIM(THIS.this_cCunii)
        loc_cFinal  = ALLTRIM(THIS.this_cCunif)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Cunis >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Cunis <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Linha (Linhas)
        loc_cInicio = ALLTRIM(THIS.this_cLini)
        loc_cFinal  = ALLTRIM(THIS.this_cLinf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Linhas >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Linhas <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de Colecao (Colecoes)
        loc_cInicio = ALLTRIM(THIS.this_cColi)
        loc_cFinal  = ALLTRIM(THIS.this_cColf)
        IF !EMPTY(loc_cInicio) AND !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes Between "' + loc_cInicio + '" And "' + loc_cFinal + '"'
        ELSE
            IF !EMPTY(loc_cInicio)
            loc_cWhere = loc_cWhere + ' AND Colecoes >= "' + loc_cInicio + '"'
        ELSE
            IF !EMPTY(loc_cFinal)
            loc_cWhere = loc_cWhere + ' AND Colecoes <= "' + loc_cFinal + '"'
            ENDIF
            ENDIF
        ENDIF

        *-- Filtro de situacao (Ativos=1, Inativos=2, Todos=3 = sem filtro)
        IF THIS.this_nSituacao = 1 OR THIS.this_nSituacao = 2
            loc_cWhere = loc_cWhere + " AND situas = " + TRANSFORM(THIS.this_nSituacao)
        ENDIF

        *-- Criar cursor com produtos filtrados (sem CodCors/CodTams reais ainda)
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               "    " AS CodCors, "  " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE &loc_cWhere. ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Criar cursor TmpPro indexado por Cpros para SEEK de equivalentes
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        CREATE CURSOR cursor_4c_TmpPro ;
            (Cpros C(10), cproeqs C(10), dpros C(40), ;
             CodCors C(4), CodTams C(2), Sqtds N(12,2), ;
             Reffs C(40), Reff2s C(40))
        INDEX ON Cpros TAG Cpros
        SELECT cursor_4c_TmpPro
        APPEND FROM DBF("cursor_4c_TmpPro2")

        *-- Buscar produtos equivalentes (cproEqs aponta para outro Cpros)
        SELECT Cpros, cproEqs, Reffs, cgrus, dpros, ;
               " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
            FROM cursor_4c_LocalPro ;
            WHERE !EMPTY(cproEqs) ;
              AND cproEqs IN (SELECT Cpros FROM cursor_4c_TmpPro) ;
            INTO CURSOR cursor_4c_TmpPro2 READWRITE

        *-- Preencher Reff2s em TmpPro com referencia do produto equivalente
        SELECT cursor_4c_TmpPro2
        SCAN
            IF SEEK(cproEqs, "cursor_4c_TmpPro", "Cpros")
                REPLACE cursor_4c_TmpPro.cproEqs WITH cursor_4c_TmpPro2.Cpros, ;
                        cursor_4c_TmpPro.Reff2s  WITH cursor_4c_TmpPro2.Reffs ;
                        IN cursor_4c_TmpPro
            ENDIF
        ENDSCAN

        *-- Gerar resultado conforme opcao de referencia de fornecedor
        IF THIS.this_nReff = 1
            *-- Agrupar por Reffs e comparar via referencia de fornecedor
            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
            SELECT Reffs, MAX(Reff2s) AS Reff2s ;
                FROM cursor_4c_TmpPro ;
                GROUP BY Reffs ;
                INTO CURSOR cursor_4c_TmpProx READWRITE

            SELECT DISTINCT PADR(Reffs, 10) AS Cpros, SPACE(40) AS dpros, ;
                            " " AS CodCors, " " AS CodTams, 0 AS Sqtds ;
                FROM cursor_4c_TmpProx ;
                WHERE !EMPTY(Reffs) ;
                  AND Reffs NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros) ;
                  AND (EMPTY(Reff2s) OR Reff2s NOT IN ;
                      (SELECT b.Reffs ;
                       FROM cursor_4c_LocalEst a, cursor_4c_LocalPro b ;
                       WHERE a.Grupos = par_cGrupoB AND a.Estos = par_cEstoqB ;
                         AND a.Emps = par_cEmps AND a.Sqtds > 0 ;
                         AND a.Cpros = b.Cpros)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY 1

            IF USED("cursor_4c_TmpProx")
                USE IN cursor_4c_TmpProx
            ENDIF
        ELSE
            *-- Comparar diretamente por Cpros e produto equivalente
            SELECT * ;
                FROM cursor_4c_TmpPro ;
                WHERE Cpros NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0) ;
                  AND (EMPTY(cproEqs) OR cproEqs NOT IN ;
                      (SELECT Cpros FROM cursor_4c_LocalEst ;
                       WHERE Grupos = par_cGrupoB AND Estos = par_cEstoqB ;
                         AND Emps = par_cEmps AND Sqtds > 0)) ;
                INTO CURSOR cursor_4c_Dados READWRITE ;
                ORDER BY Cpros
        ENDIF

        *-- Limpar cursores temporarios
        IF USED("cursor_4c_TmpPro2")
            USE IN cursor_4c_TmpPro2
        ENDIF
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigrecpe.frx") ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

