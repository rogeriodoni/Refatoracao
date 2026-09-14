# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_SAIDA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 1 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).
- [GRID-HEADER] Header Caption 'Variação Cto (%)' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Descrição, Venda Ant., Venda Atual, Variação (%), Custo Ant., Custo Atual. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2623 linhas total):

*-- Linhas 30 a 137:
30:     this_lAutomatico     = .F.
31: 
32:     *==========================================================================
33:     PROCEDURE Init(par_lAutomatico)
34:     *==========================================================================
35:         IF PCOUNT() > 0
36:             THIS.this_lAutomatico = par_lAutomatico
37:         ENDIF
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm
43:     *==========================================================================
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
48:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
49:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprccp.", "Erro")
50:             ELSE
51:                 *-- Configurar base visual do form (equivalente ao PageFrame em CRUD)
52:                 THIS.ConfigurarPageFrame()
53: 
54:                 *-- Inicializar cursores do BO
55:                 THIS.this_oBusinessObject.CarregarDadosAuxiliares()
56:                 THIS.this_oBusinessObject.CriarCursorDados()
57: 
58:                 *-- Construir interface
59:                 THIS.ConfigurarCabecalho()
60:                 THIS.ConfigurarFiltros()
61:                 THIS.ConfigurarOpcoes()
62:                 THIS.ConfigurarPaginaDados()
63:                 THIS.ConfigurarPaginaLista()
64:                 THIS.ConfigurarBotoes()
65:                 THIS.TornarControlesVisiveis()
66:                 THIS.ConfigurarBINDEVENTs()
67:                 THIS.InicializarValores()
68: 
69:                 *-- Modo automatico
70:                 IF THIS.this_lAutomatico
71:                     THIS.this_oBusinessObject.this_lAutomatico = .T.
72:                     THIS.this_oBusinessObject.ProcessaAutomatico()
73:                     THIS.grd_4c_Produto.Refresh
74:                 ENDIF
75: 
76:                 loc_lSucesso = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
80:         ENDTRY
81:         RETURN loc_lSucesso
82:     ENDPROC
83: 
84:     *==========================================================================
85:     * ConfigurarPageFrame - Configura a base visual do form
86:     * Form OPERACIONAL: layout FLAT (sem PageFrame). Este metodo configura
87:     * as propriedades base do form (Picture, BackColor, ClipControls) que em
88:     * um form CRUD estariam num PageFrame com Page1/Page2.
89:     *==========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame
91:         THIS.Picture     = gc_4c_CaminhoBase + "..\..\..\Framework\imagens\new_background.jpg"
92:         THIS.BackColor   = RGB(255, 255, 255)
93:         THIS.ClipControls = .F.
94:     ENDPROC
95: 
96:     *==========================================================================
97:     PROTECTED PROCEDURE ConfigurarCabecalho
98:     *==========================================================================
99:         LOCAL loc_oCnt
100:         THIS.AddObject("cnt_4c_Sombra", "Container")
101:         loc_oCnt = THIS.cnt_4c_Sombra
102:         WITH loc_oCnt
103:             .Top        = 0
104:             .Left       = 0
105:             .Width      = THIS.Width
106:             .Height     = 80
107:             .BorderWidth= 0
108:             .BackColor  = RGB(100,100,100)
109:             .Visible    = .T.
110:             .AddObject("lbl_4c_LblSombra", "Label")
111:             WITH .lbl_4c_LblSombra
112:                 .FontBold      = .T.
113:                 .FontName      = "Tahoma"
114:                 .FontSize      = 18
115:                 .FontUnderline = .F.
116:                 .WordWrap      = .T.
117:                 .Alignment     = 0
118:                 .AutoSize      = .F.
119:                 .BackStyle     = 0
120:                 .Caption       = THIS.Parent.Caption
121:                 .Height        = 40
122:                 .Left          = 10
123:                 .Top           = 18
124:                 .Width         = THIS.Width
125:                 .ForeColor     = RGB(0,0,0)
126:                 .Visible       = .T.
127:             ENDWITH
128:             .AddObject("lbl_4c_LblTitulo", "Label")
129:             WITH .lbl_4c_LblTitulo
130:                 .FontBold   = .T.
131:                 .FontName   = "Tahoma"
132:                 .FontSize   = 18
133:                 .WordWrap   = .T.
134:                 .Alignment  = 0
135:                 .AutoSize   = .F.
136:                 .BackStyle  = 0
137:                 .Caption    = THIS.Parent.Caption

*-- Linhas 146 a 189:
146:     ENDPROC
147: 
148:     *==========================================================================
149:     PROTECTED PROCEDURE ConfigurarFiltros
150:     *==========================================================================
151:         LOCAL loc_o
152: 
153:         *-- Label "Filtros" (titulo secao)
154:         THIS.AddObject("lbl_4c_SecFiltros", "Label")
155:         WITH THIS.lbl_4c_SecFiltros
156:             .FontBold  = .T.
157:             .FontName  = "Tahoma"
158:             .FontSize  = 12
159:             .BackStyle = 0
160:             .Caption   = "Filtros"
161:             .Height    = 21
162:             .Left      = 11
163:             .Top       = 94
164:             .AutoSize  = .T.
165:             .ForeColor = RGB(90,90,90)
166:             .Visible   = .T.
167:         ENDWITH
168: 
169:         *-- ----------------------------------------------------------------
170:         *-- ROW 1: Fornecedor (Top=88)
171:         *-- ----------------------------------------------------------------
172:         THIS.AddObject("lbl_4c_Fornecedor", "Label")
173:         WITH THIS.lbl_4c_Fornecedor
174:             .AutoSize  = .T.
175:             .FontName  = "Tahoma"
176:             .FontSize  = 8
177:             .BackStyle = 0
178:             .Caption   = "Fornecedor :"
179:             .Height    = 15
180:             .Left      = 79
181:             .Top       = 92
182:             .ForeColor = RGB(90,90,90)
183:             .Visible   = .T.
184:         ENDWITH
185: 
186:         THIS.AddObject("txt_4c_CFornecs", "TextBox")
187:         WITH THIS.txt_4c_CFornecs
188:             .FontName      = "Tahoma"
189:             .FontSize      = 8

*-- Linhas 795 a 999:
795:     ENDPROC
796: 
797:     *==========================================================================
798:     PROTECTED PROCEDURE ConfigurarOpcoes
799:     *==========================================================================
800:         *-- OptionGroup Ideal/Venda (fwoption1) em (Left=234, Top=211)
801:         THIS.AddObject("opg_4c_OpcaoM", "OptionGroup")
802:         WITH THIS.opg_4c_OpcaoM
803:             .ButtonCount = 2
804:             .Value       = 1
805:             .Height      = 26
806:             .Left        = 234
807:             .Top         = 211
808:             .Width       = 106
809:             .BackStyle   = 0
810:             .Visible     = .T.
811:             .Buttons(1).Caption     = "\<Ideal"
812:             .Buttons(1).Left        = 5
813:             .Buttons(1).Top         = 5
814:             .Buttons(1).AutoSize    = .T.
815:             .Buttons(1).Themes      = .F.
816:             .Buttons(2).Caption     = "\<Venda"
817:             .Buttons(2).Left        = 53
818:             .Buttons(2).Top         = 6
819:             .Buttons(2).AutoSize    = .T.
820:             .Buttons(2).Themes      = .F.
821:         ENDWITH
822: 
823:         *-- OptionGroup Situacao (Left=536, Top=214)
824:         THIS.AddObject("lbl_4c_Situacao", "Label")
825:         WITH THIS.lbl_4c_Situacao
826:             .FontName  = "Tahoma"
827:             .FontSize  = 8
828:             .BackStyle = 0
829:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
830:             .Left      = 486
831:             .Top       = 217
832:             .AutoSize  = .T.
833:             .ForeColor = RGB(90,90,90)
834:             .Visible   = .T.
835:         ENDWITH
836: 
837:         THIS.AddObject("opg_4c_Situacao", "OptionGroup")
838:         WITH THIS.opg_4c_Situacao
839:             .ButtonCount = 3
840:             .Value       = 3
841:             .Height      = 21
842:             .Left        = 536
843:             .Top         = 214
844:             .Width       = 189
845:             .BackStyle   = 0
846:             .Visible     = .T.
847:             .Buttons(1).Caption     = "\<Ativos"
848:             .Buttons(1).Left        = 5
849:             .Buttons(1).Top         = 3
850:             .Buttons(1).AutoSize    = .T.
851:             .Buttons(1).Themes      = .F.
852:             .Buttons(2).Caption     = "\<Inativos"
853:             .Buttons(2).Left        = 59
854:             .Buttons(2).Top         = 2
855:             .Buttons(2).AutoSize    = .F.
856:             .Buttons(2).Themes      = .F.
857:             .Buttons(3).FontName    = "Tahoma"
858:             .Buttons(3).FontSize    = 8
859:             .Buttons(3).Caption     = "\<Todos"
860:             .Buttons(3).Height      = 17
861:             .Buttons(3).Left        = 125
862:             .Buttons(3).Top         = 2
863:             .Buttons(3).Width       = 61
864:             .Buttons(3).AutoSize    = .F.
865:             .Buttons(3).ForeColor   = RGB(90,90,90)
866:             .Buttons(3).Themes      = .F.
867:         ENDWITH
868: 
869:         *-- OptionGroup Compra (Left=536, Top=234)
870:         THIS.AddObject("lbl_4c_Compra", "Label")
871:         WITH THIS.lbl_4c_Compra
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .BackStyle = 0
875:             .Caption   = "Compra :"
876:             .Left      = 490
877:             .Top       = 237
878:             .AutoSize  = .T.
879:             .ForeColor = RGB(90,90,90)
880:             .Visible   = .T.
881:         ENDWITH
882: 
883:         THIS.AddObject("opg_4c_Compra", "OptionGroup")
884:         WITH THIS.opg_4c_Compra
885:             .ButtonCount = 3
886:             .Value       = 3
887:             .Height      = 21
888:             .Left        = 536
889:             .Top         = 234
890:             .Width       = 204
891:             .BackStyle   = 0
892:             .Visible     = .T.
893:             .Buttons(1).Caption     = "\<Comprar"
894:             .Buttons(1).Left        = 5
895:             .Buttons(1).Top         = 3
896:             .Buttons(1).AutoSize    = .T.
897:             .Buttons(1).Themes      = .F.
898:             .Buttons(2).Caption     = "\<N" + CHR(227) + "o Comprar"
899:             .Buttons(2).Left        = 67
900:             .Buttons(2).Top         = 3
901:             .Buttons(2).AutoSize    = .T.
902:             .Buttons(2).Themes      = .F.
903:             .Buttons(3).FontName    = "Tahoma"
904:             .Buttons(3).FontSize    = 8
905:             .Buttons(3).Caption     = "\<Todos"
906:             .Buttons(3).Height      = 17
907:             .Buttons(3).Left        = 152
908:             .Buttons(3).Top         = 2
909:             .Buttons(3).Width       = 61
910:             .Buttons(3).ForeColor   = RGB(90,90,90)
911:             .Buttons(3).AutoSize    = .F.
912:             .Buttons(3).Themes      = .F.
913:         ENDWITH
914:     ENDPROC
915: 
916:     *==========================================================================
917:     PROTECTED PROCEDURE ConfigurarPaginaDados
918:     *==========================================================================
919:         *-- Linha separadora
920:         THIS.AddObject("lin_4c_Sep", "Line")
921:         WITH THIS.lin_4c_Sep
922:             .Height = 0
923:             .Left   = 13
924:             .Top    = 258
925:             .Width  = 738
926:             .Visible= .T.
927:         ENDWITH
928: 
929:         *-- Label "Dados" (titulo secao)
930:         THIS.AddObject("lbl_4c_SecDados", "Label")
931:         WITH THIS.lbl_4c_SecDados
932:             .FontBold  = .T.
933:             .FontName  = "Tahoma"
934:             .FontSize  = 12
935:             .BackStyle = 0
936:             .Caption   = "Dados"
937:             .Height    = 21
938:             .Left      = 12
939:             .Top       = 270
940:             .AutoSize  = .T.
941:             .ForeColor = RGB(90,90,90)
942:             .Visible   = .T.
943:         ENDWITH
944: 
945:         *-- Label "Recalcula :" e OptionGroup Recalc (8 opcoes)
946:         THIS.AddObject("lbl_4c_Recalcula", "Label")
947:         WITH THIS.lbl_4c_Recalcula
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8
950:             .BackStyle = 0
951:             .Caption   = "Recalcula :"
952:             .Left      = 89
953:             .Top       = 263
954:             .AutoSize  = .T.
955:             .ForeColor = RGB(90,90,90)
956:             .Visible   = .T.
957:         ENDWITH
958: 
959:         THIS.AddObject("opg_4c_Recalc", "OptionGroup")
960:         WITH THIS.opg_4c_Recalc
961:             .ButtonCount = 8
962:             .Value       = 1
963:             .Height      = 41
964:             .Left        = 142
965:             .Top         = 258
966:             .Width       = 439
967:             .BackStyle   = 0
968:             .Visible     = .T.
969:             *-- Row 1: Composicao, Custo Venda, Ambos, Peso Componentes
970:             .Buttons(1).FontName    = "Tahoma"
971:             .Buttons(1).FontSize    = 8
972:             .Buttons(1).Caption     = "\<Composi" + CHR(231) + CHR(227) + "o"
973:             .Buttons(1).Left        = 5
974:             .Buttons(1).Top         = 5
975:             .Buttons(1).AutoSize    = .T.
976:             .Buttons(1).ForeColor   = RGB(90,90,90)
977:             .Buttons(1).Themes      = .F.
978:             .Buttons(2).FontName    = "Tahoma"
979:             .Buttons(2).FontSize    = 8
980:             .Buttons(2).Caption     = "Custo \<Venda"
981:             .Buttons(2).Left        = 98
982:             .Buttons(2).Top         = 5
983:             .Buttons(2).AutoSize    = .T.
984:             .Buttons(2).ForeColor   = RGB(90,90,90)
985:             .Buttons(2).Themes      = .F.
986:             .Buttons(3).FontName    = "Tahoma"
987:             .Buttons(3).FontSize    = 8
988:             .Buttons(3).Caption     = "\<Ambos"
989:             .Buttons(3).Height      = 15
990:             .Buttons(3).Left        = 213
991:             .Buttons(3).Top         = 5
992:             .Buttons(3).Width       = 50
993:             .Buttons(3).AutoSize    = .T.
994:             .Buttons(3).ForeColor   = RGB(90,90,90)
995:             .Buttons(3).Themes      = .F.
996:             .Buttons(4).FontName    = "Tahoma"
997:             .Buttons(4).FontSize    = 8
998:             .Buttons(4).Caption     = "Peso Componentes"
999:             .Buttons(4).Height      = 15

*-- Linhas 1157 a 1200:
1157:             .Visible   = .T.
1158:         ENDWITH
1159: 
1160:         THIS.AddObject("opg_4c_PVen", "OptionGroup")
1161:         WITH THIS.opg_4c_PVen
1162:             .ButtonCount = 2
1163:             .Value       = 2
1164:             .Height      = 27
1165:             .Left        = 544
1166:             .Top         = 298
1167:             .Width       = 102
1168:             .BackStyle   = 0
1169:             .Visible     = .T.
1170:             .Buttons(1).Caption     = "\<Sim"
1171:             .Buttons(1).Left        = 5
1172:             .Buttons(1).Top         = 5
1173:             .Buttons(1).AutoSize    = .T.
1174:             .Buttons(1).Themes      = .F.
1175:             .Buttons(2).Caption     = "\<N" + CHR(227) + "o"
1176:             .Buttons(2).Height      = 17
1177:             .Buttons(2).Left        = 53
1178:             .Buttons(2).Top         = 5
1179:             .Buttons(2).Width       = 44
1180:             .Buttons(2).AutoSize    = .F.
1181:             .Buttons(2).Themes      = .F.
1182:         ENDWITH
1183: 
1184:         *-- Novo MKP code (Left=326, Top=326)
1185:         THIS.AddObject("lbl_4c_NewMkp", "Label")
1186:         WITH THIS.lbl_4c_NewMkp
1187:             .FontName  = "Tahoma"
1188:             .FontSize  = 8
1189:             .BackStyle = 0
1190:             .Caption   = "Novo MKP : "
1191:             .Height    = 15
1192:             .Left      = 264
1193:             .Top       = 330
1194:             .AutoSize  = .T.
1195:             .ForeColor = RGB(90,90,90)
1196:             .Visible   = .T.
1197:         ENDWITH
1198: 
1199:         THIS.AddObject("txt_4c_NewMkp", "TextBox")
1200:         WITH THIS.txt_4c_NewMkp

*-- Linhas 1214 a 1263:
1214:     * ConfigurarPaginaLista - Layout operacional (substitui Page1 do CRUD)
1215:     * Form OPERACIONAL flat: grid de resultados + imagem de produto
1216:     *==========================================================================
1217:     PROTECTED PROCEDURE ConfigurarPaginaLista
1218:         THIS.ConfigurarGrid()
1219:         THIS.ConfigurarImagem()
1220:     ENDPROC
1221: 
1222:     *==========================================================================
1223:     PROTECTED PROCEDURE ConfigurarGrid
1224:     *==========================================================================
1225:         LOCAL loc_oGrd
1226:         THIS.AddObject("grd_4c_Produto", "Grid")
1227:         loc_oGrd = THIS.grd_4c_Produto
1228:         WITH loc_oGrd
1229:             .ColumnCount   = 9
1230:             .FontName      = "Tahoma"
1231:             .FontSize      = 8
1232:             .Height        = 244
1233:             .Left          = 12
1234:             .RowHeight     = 16
1235:             .ScrollBars    = 2
1236:             .Top           = 351
1237:             .Width         = 935
1238:             .RecordSource  = "cursor_4c_Dados"
1239:             .RecordMark    = .F.
1240:             .DeleteMark    = .F.
1241:             .Visible       = .T.
1242: 
1243:             *-- Column1: Checkbox (lMarca)
1244:             .Column1.Alignment     = 3
1245:             .Column1.Width         = 17
1246:             .Column1.Movable       = .F.
1247:             .Column1.Resizable     = .F.
1248:             .Column1.Sparse        = .F.
1249:             .Column1.Header1.Caption   = ""
1250:             .Column1.Header1.Alignment = 2
1251:             .Column1.Header1.ForeColor = RGB(36,84,155)
1252:             .Column1.RemoveObject("Text1")
1253:             .Column1.AddObject("chk_4c_Marca", "CheckBox")
1254:             WITH .Column1.chk_4c_Marca
1255:                 .Caption = ""
1256:                 .Width   = 17
1257:                 .Height  = 17
1258:                 .Value   = 0
1259:                 .Visible = .T.
1260:             ENDWITH
1261:             .Column1.CurrentControl = "chk_4c_Marca"
1262:             .Column1.ControlSource  = "cursor_4c_Dados.lMarca"
1263: 

*-- Linhas 1402 a 1459:
1402:     ENDPROC
1403: 
1404:     *==========================================================================
1405:     PROTECTED PROCEDURE ConfigurarImagem
1406:     *==========================================================================
1407:         THIS.AddObject("img_4c_FigJpg", "Image")
1408:         WITH THIS.img_4c_FigJpg
1409:             .Stretch = 1
1410:             .Height  = 190
1411:             .Left    = 764
1412:             .Top     = 128
1413:             .Width   = 223
1414:             .Visible = .F.
1415:         ENDWITH
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     PROTECTED PROCEDURE ConfigurarBotoes
1420:     *==========================================================================
1421:         LOCAL loc_cIco
1422: 
1423:         loc_cIco = gc_4c_CaminhoIcones
1424: 
1425:         *-- Botao Imprimir (Left=700, Top=3)
1426:         THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
1427:         WITH THIS.cmd_4c_Imprimir
1428:             .Top        = 3
1429:             .Left       = 700
1430:             .Height     = 75
1431:             .Width      = 60
1432:             .FontBold   = .T.
1433:             .FontItalic = .T.
1434:             .FontName   = "Comic Sans MS"
1435:             .FontSize   = 8
1436:             .WordWrap   = .T.
1437:             .Picture    = loc_cIco + "geral_impressora_normal_60.jpg"
1438:             .Caption    = "\<Imprimir"
1439:             .ForeColor  = RGB(90,90,90)
1440:             .BackColor  = RGB(255,255,255)
1441:             .Themes     = .T.
1442:             .Enabled    = .F.
1443:             .Visible    = fChecaAcesso("SigPrCcp", "IMPRIMIR")
1444:         ENDWITH
1445: 
1446:         *-- Botao Processar (Left=767, Top=5)
1447:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
1448:         WITH THIS.cmd_4c_Processar
1449:             .Top        = 5
1450:             .Left       = 767
1451:             .Height     = 75
1452:             .Width      = 75
1453:             .FontBold   = .T.
1454:             .FontItalic = .T.
1455:             .FontName   = "Comic Sans MS"
1456:             .FontSize   = 8
1457:             .WordWrap   = .T.
1458:             .Picture    = loc_cIco + "geral_processar_60.jpg"
1459:             .Caption    = "\<Processar"

*-- Linhas 1546 a 1723:
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     PROTECTED PROCEDURE TornarControlesVisiveis
1550:     *==========================================================================
1551:         LOCAL loc_i, loc_oCtrl
1552:         FOR loc_i = 1 TO THIS.ControlCount
1553:             loc_oCtrl = THIS.Controls(loc_i)
1554:             IF VARTYPE(loc_oCtrl) = "O" AND PEMSTATUS(loc_oCtrl, "Visible", 5)
1555:                 IF UPPER(loc_oCtrl.Name) != "IMG_4C_FIGJPG"
1556:                     loc_oCtrl.Visible = .T.
1557:                 ENDIF
1558:             ENDIF
1559:         ENDFOR
1560:     ENDPROC
1561: 
1562:     *==========================================================================
1563:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
1564:     *==========================================================================
1565:         *-- Botoes de acao
1566:         BINDEVENT(THIS.cmd_4c_Processar, "Click",  THIS, "BtnProcessarClick")
1567:         BINDEVENT(THIS.cmd_4c_Atualizar, "Click",  THIS, "BtnAtualizarClick")
1568:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1569:         BINDEVENT(THIS.cmd_4c_Imprimir,  "Click",  THIS, "BtnImprimirClick")
1570:         BINDEVENT(THIS.cmd_4c_SelTudo,   "Click",  THIS, "BtnSelTudoClick")
1571:         BINDEVENT(THIS.cmd_4c_Desmarcar, "Click",  THIS, "BtnDesmarcarClick")
1572: 
1573:         *-- Grid
1574:         BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")
1575: 
1576:         *-- Imagem
1577:         BINDEVENT(THIS.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")
1578: 
1579:         *-- Opc Recalc (para atualizar estado dos campos)
1580:         BINDEVENT(THIS.opg_4c_Recalc, "InteractiveChange", THIS, "OpcRecalcMudou")
1581: 
1582:         *-- Fornecedor lookup
1583:         BINDEVENT(THIS.txt_4c_CFornecs, "DblClick",   THIS, "AbrirBuscaFornecedor")
1584:         BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",   THIS, "TeclaFornecedor")
1585:         BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress",  THIS, "ValidarFornecedor")
1586: 
1587:         *-- Grande Grupo lookup
1588:         BINDEVENT(THIS.txt_4c_MercI, "DblClick",  THIS, "AbrirBuscaMercI")
1589:         BINDEVENT(THIS.txt_4c_MercI, "KeyPress",  THIS, "TeclaMercI")
1590:         BINDEVENT(THIS.txt_4c_MercF, "DblClick",  THIS, "AbrirBuscaMercF")
1591:         BINDEVENT(THIS.txt_4c_MercF, "KeyPress",  THIS, "TeclaMercF")
1592: 
1593:         *-- Grupo lookup
1594:         BINDEVENT(THIS.txt_4c_CGrui, "DblClick",  THIS, "AbrirBuscaCGrui")
1595:         BINDEVENT(THIS.txt_4c_CGrui, "KeyPress",  THIS, "TeclaCGrui")
1596:         BINDEVENT(THIS.txt_4c_CGruf, "DblClick",  THIS, "AbrirBuscaCGruf")
1597:         BINDEVENT(THIS.txt_4c_CGruf, "KeyPress",  THIS, "TeclaCGruf")
1598: 
1599:         *-- Subgrupo lookup
1600:         BINDEVENT(THIS.txt_4c_SGruI, "DblClick",  THIS, "AbrirBuscaSGruI")
1601:         BINDEVENT(THIS.txt_4c_SGruI, "KeyPress",  THIS, "TeclaSGruI")
1602:         BINDEVENT(THIS.txt_4c_SGruF, "DblClick",  THIS, "AbrirBuscaSGruF")
1603:         BINDEVENT(THIS.txt_4c_SGruF, "KeyPress",  THIS, "TeclaSGruF")
1604: 
1605:         *-- Unidade lookup
1606:         BINDEVENT(THIS.txt_4c_CUniI, "DblClick",  THIS, "AbrirBuscaCUniI")
1607:         BINDEVENT(THIS.txt_4c_CUniI, "KeyPress",  THIS, "TeclaCUniI")
1608:         BINDEVENT(THIS.txt_4c_CUnif, "DblClick",  THIS, "AbrirBuscaCUnif")
1609:         BINDEVENT(THIS.txt_4c_CUnif, "KeyPress",  THIS, "TeclaCUnif")
1610: 
1611:         *-- Moeda lookup
1612:         BINDEVENT(THIS.txt_4c_MoeI, "DblClick",  THIS, "AbrirBuscaMoeI")
1613:         BINDEVENT(THIS.txt_4c_MoeI, "KeyPress",  THIS, "TeclaMoeI")
1614:         BINDEVENT(THIS.txt_4c_MoeF, "DblClick",  THIS, "AbrirBuscaMoeF")
1615:         BINDEVENT(THIS.txt_4c_MoeF, "KeyPress",  THIS, "TeclaMoeF")
1616: 
1617:         *-- Linha lookup
1618:         BINDEVENT(THIS.txt_4c_LinhI, "DblClick",  THIS, "AbrirBuscaLinhI")
1619:         BINDEVENT(THIS.txt_4c_LinhI, "KeyPress",  THIS, "TeclaLinhI")
1620:         BINDEVENT(THIS.txt_4c_LinhF, "DblClick",  THIS, "AbrirBuscaLinhF")
1621:         BINDEVENT(THIS.txt_4c_LinhF, "KeyPress",  THIS, "TeclaLinhF")
1622: 
1623:         *-- Colecao lookup
1624:         BINDEVENT(THIS.txt_4c_ColI, "DblClick",  THIS, "AbrirBuscaColI")
1625:         BINDEVENT(THIS.txt_4c_ColI, "KeyPress",  THIS, "TeclaColI")
1626:         BINDEVENT(THIS.txt_4c_ColF, "DblClick",  THIS, "AbrirBuscaColF")
1627:         BINDEVENT(THIS.txt_4c_ColF, "KeyPress",  THIS, "TeclaColF")
1628: 
1629:         *-- Feitio lookup
1630:         BINDEVENT(THIS.txt_4c_Feitio,  "DblClick",  THIS, "AbrirBuscaFeitio")
1631:         BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress",  THIS, "TeclaFeitio")
1632:         BINDEVENT(THIS.txt_4c_NewMkp,  "DblClick",  THIS, "AbrirBuscaNewMkp")
1633:         BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress",  THIS, "TeclaNewMkp")
1634: 
1635:         *-- Validacoes mutuas Reajuste/NMrk/Variacao
1636:         BINDEVENT(THIS.txt_4c_Reajuste, "KeyPress", THIS, "ValidarReajuste")
1637:         BINDEVENT(THIS.txt_4c_NMrk,     "KeyPress", THIS, "ValidarNMrk")
1638:         BINDEVENT(THIS.txt_4c_Variacao,  "KeyPress", THIS, "ValidarVariacao")
1639:         BINDEVENT(THIS.txt_4c_Encargo,   "KeyPress", THIS, "ValidarEncargo")
1640:     ENDPROC
1641: 
1642:     *==========================================================================
1643:     PROTECTED PROCEDURE InicializarValores
1644:     *==========================================================================
1645:         THIS.AtualizarEstadoCampos()
1646:     ENDPROC
1647: 
1648:     *==========================================================================
1649:     * Atualiza Enabled dos campos conforme estado atual
1650:     *==========================================================================
1651:     PROCEDURE AtualizarEstadoCampos
1652:         LOCAL loc_lRecalc2, loc_lReajZero
1653:         loc_lRecalc2  = (THIS.opg_4c_Recalc.Value = 2)
1654:         loc_lReajZero = (THIS.txt_4c_Reajuste.Value = 0)
1655: 
1656:         THIS.txt_4c_Reajuste.Enabled = !loc_lRecalc2
1657:         THIS.txt_4c_NMrk.Enabled    = (!loc_lRecalc2) AND loc_lReajZero
1658:         THIS.txt_4c_Variacao.Enabled = (!loc_lRecalc2) AND loc_lReajZero
1659:         THIS.txt_4c_NewMkp.Enabled   = INLIST(THIS.opg_4c_Recalc.Value, 7, 8)
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * HANDLERS - Botoes
1664:     *==========================================================================
1665:     PROCEDURE BtnProcessarClick
1666:         LOCAL loc_lSucesso, loc_nVaria, loc_oBO
1667:         loc_oBO = THIS.this_oBusinessObject
1668: 
1669:         *-- Verificar reprocessamento
1670:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1671:             IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
1672:                 RETURN
1673:             ENDIF
1674:         ENDIF
1675: 
1676:         *-- Limpar dados anteriores
1677:         IF USED("cursor_4c_Dados")
1678:             ZAP IN cursor_4c_Dados
1679:         ENDIF
1680: 
1681:         *-- Validar NewMkp para opcoes 7 e 8
1682:         IF INLIST(THIS.opg_4c_Recalc.Value, 7, 8) AND EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
1683:             MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", "Aten" + CHR(231) + CHR(227) + "o")
1684:             THIS.txt_4c_NewMkp.SetFocus()
1685:             RETURN
1686:         ENDIF
1687: 
1688:         *-- Copiar valores do form para o BO
1689:         loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
1690:         loc_oBO.this_cMercI    = ALLTRIM(THIS.txt_4c_MercI.Value)
1691:         loc_oBO.this_cMercF    = ALLTRIM(THIS.txt_4c_MercF.Value)
1692:         loc_oBO.this_cGruI     = ALLTRIM(THIS.txt_4c_CGrui.Value)
1693:         loc_oBO.this_cGruF     = ALLTRIM(THIS.txt_4c_CGruf.Value)
1694:         loc_oBO.this_cSGruI    = ALLTRIM(THIS.txt_4c_SGruI.Value)
1695:         loc_oBO.this_cSGruF    = ALLTRIM(THIS.txt_4c_SGruF.Value)
1696:         loc_oBO.this_cCuniI    = ALLTRIM(THIS.txt_4c_CUniI.Value)
1697:         loc_oBO.this_cCuniF    = ALLTRIM(THIS.txt_4c_CUnif.Value)
1698:         loc_oBO.this_cLinI     = ALLTRIM(THIS.txt_4c_LinhI.Value)
1699:         loc_oBO.this_cLinF     = ALLTRIM(THIS.txt_4c_LinhF.Value)
1700:         loc_oBO.this_cColI     = ALLTRIM(THIS.txt_4c_ColI.Value)
1701:         loc_oBO.this_cColF     = ALLTRIM(THIS.txt_4c_ColF.Value)
1702:         loc_oBO.this_cMoeI     = ALLTRIM(THIS.txt_4c_MoeI.Value)
1703:         loc_oBO.this_cMoeF     = ALLTRIM(THIS.txt_4c_MoeF.Value)
1704:         loc_oBO.this_nMrkI     = THIS.txt_4c_MrkI.Value
1705:         loc_oBO.this_nMrkF     = THIS.txt_4c_MrkF.Value
1706:         loc_oBO.this_nEncI     = THIS.txt_4c_EncI.Value
1707:         loc_oBO.this_nEncF     = THIS.txt_4c_EncF.Value
1708:         loc_oBO.this_cFeitio   = ALLTRIM(THIS.txt_4c_Feitio.Value)
1709:         loc_oBO.this_nSituacao = THIS.opg_4c_Situacao.Value
1710:         loc_oBO.this_nCompra   = THIS.opg_4c_Compra.Value
1711:         loc_oBO.this_nFoption1 = THIS.opg_4c_OpcaoM.Value
1712:         loc_oBO.this_nRecalc   = THIS.opg_4c_Recalc.Value
1713:         loc_oBO.this_nReajuste = THIS.txt_4c_Reajuste.Value
1714:         loc_oBO.this_nNMrk     = THIS.txt_4c_NMrk.Value
1715:         loc_oBO.this_nEncargo  = THIS.txt_4c_Encargo.Value
1716:         loc_oBO.this_nPven     = THIS.opg_4c_PVen.Value
1717:         loc_oBO.this_cNewMkp   = ALLTRIM(THIS.txt_4c_NewMkp.Value)
1718: 
1719:         *-- Processar
1720:         IF loc_oBO.Processar()
1721:             *-- Filtrar por variacao
1722:             loc_nVaria = THIS.txt_4c_Variacao.Value
1723:             IF USED("cursor_4c_Dados")

*-- Linhas 1737 a 2367:
1737:         ENDIF
1738:     ENDPROC
1739: 
1740:     PROCEDURE BtnAtualizarClick
1741:         THIS.this_oBusinessObject.AtualizarPrecos(.F.)
1742:     ENDPROC
1743: 
1744:     PROCEDURE BtnEncerrarClick
1745:         THIS.Release()
1746:     ENDPROC
1747: 
1748:     PROCEDURE BtnImprimirClick
1749:         DO FORM SigPrCcr
1750:     ENDPROC
1751: 
1752:     PROCEDURE BtnSelTudoClick
1753:         IF USED("cursor_4c_Dados")
1754:             UPDATE cursor_4c_Dados SET lMarca = 1
1755:             THIS.grd_4c_Produto.Refresh
1756:         ENDIF
1757:     ENDPROC
1758: 
1759:     PROCEDURE BtnDesmarcarClick
1760:         IF USED("cursor_4c_Dados")
1761:             UPDATE cursor_4c_Dados SET lMarca = 0
1762:             THIS.grd_4c_Produto.Refresh
1763:         ENDIF
1764:     ENDPROC
1765: 
1766:     *==========================================================================
1767:     * HANDLER - OpcRecalc mudou
1768:     *==========================================================================
1769:     PROCEDURE OpcRecalcMudou
1770:         THIS.AtualizarEstadoCampos()
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * HANDLER - Grid AfterRowColChange
1775:     *==========================================================================
1776:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1777:         LOCAL loc_cCodPro, loc_cSql, loc_cArq, loc_cFoto
1778:         loc_cCodPro = ""
1779: 
1780:         IF USED("cursor_4c_Dados")
1781:             SELECT cursor_4c_Dados
1782:             loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
1783:         ENDIF
1784: 
1785:         THIS.img_4c_FigJpg.Visible  = .F.
1786:         THIS.img_4c_FigJpg.Picture  = ""
1787: 
1788:         IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
1789:             loc_cSql = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
1790:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigTemp") >= 1
1791:                 IF RECCOUNT("cursor_4c_FigTemp") > 0
1792:                     SELECT cursor_4c_FigTemp
1793:                     GO TOP
1794:                     IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1795:                         loc_cArq  = SYS(2023) + "\TempCj.jpg"
1796:                         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1797:                                     "data:image/png;base64,", ""), ;
1798:                                     "data:image/jpeg;base64,", ""), ;
1799:                                     "data:image/jpg;base64,", ""), 14)
1800:                         STRTOFILE(loc_cFoto, loc_cArq, 0)
1801:                         THIS.img_4c_FigJpg.Picture = loc_cArq
1802:                         THIS.img_4c_FigJpg.Visible = .T.
1803:                     ENDIF
1804:                 ENDIF
1805:                 IF USED("cursor_4c_FigTemp")
1806:                     USE IN cursor_4c_FigTemp
1807:                 ENDIF
1808:             ENDIF
1809:         ENDIF
1810:     ENDPROC
1811: 
1812:     *==========================================================================
1813:     * HANDLER - Imagem DblClick (zoom)
1814:     *==========================================================================
1815:     PROCEDURE ImgFigJpgDblClick
1816:         LOCAL loc_cArq, loc_cCodPro, loc_cSql, loc_cFoto
1817:         loc_cArq    = SYS(2023) + "\" + SYS(2015) + ".Jpg"
1818:         loc_cCodPro = ""
1819: 
1820:         IF USED("cursor_4c_Dados")
1821:             SELECT cursor_4c_Dados
1822:             loc_cCodPro = ALLTRIM(NVL(cursor_4c_Dados.CPros, ""))
1823:         ENDIF
1824: 
1825:         IF !EMPTY(loc_cCodPro) AND gnConnHandle > 0
1826:             loc_cSql = "SELECT cpros, FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
1827:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FigZoom") >= 1
1828:                 IF RECCOUNT("cursor_4c_FigZoom") > 0
1829:                     SELECT cursor_4c_FigZoom
1830:                     GO TOP
1831:                     IF !EMPTY(cursor_4c_FigZoom.FigJpgs) AND !ISNULL(cursor_4c_FigZoom.FigJpgs)
1832:                         loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigZoom.FigJpgs, ;
1833:                                     "data:image/png;base64,", ""), ;
1834:                                     "data:image/jpeg;base64,", ""), ;
1835:                                     "data:image/jpg;base64,", ""), 14)
1836:                         STRTOFILE(loc_cFoto, loc_cArq, 0)
1837:                         IF FILE(loc_cArq)
1838:                             DO FORM SigOpZom WITH loc_cArq, ;
1839:                                 "Produto : " + loc_cCodPro + " - " + ALLTRIM(NVL(cursor_4c_FigZoom.cpros, "")), ;
1840:                                 " "
1841:                             DELETE FILE (loc_cArq)
1842:                         ENDIF
1843:                     ENDIF
1844:                 ENDIF
1845:                 IF USED("cursor_4c_FigZoom")
1846:                     USE IN cursor_4c_FigZoom
1847:                 ENDIF
1848:             ENDIF
1849:         ENDIF
1850:     ENDPROC
1851: 
1852:     *==========================================================================
1853:     * VALIDADORES
1854:     *==========================================================================
1855:     PROCEDURE ValidarReajuste
1856:         IF THIS.txt_4c_Reajuste.Value > 0
1857:             THIS.txt_4c_NMrk.Value = 0
1858:             THIS.txt_4c_NMrk.Refresh
1859:         ENDIF
1860:         THIS.AtualizarEstadoCampos()
1861:     ENDPROC
1862: 
1863:     PROCEDURE ValidarNMrk
1864:         IF THIS.txt_4c_NMrk.Value > 0
1865:             THIS.txt_4c_Reajuste.Value = 0
1866:             THIS.txt_4c_Reajuste.Refresh
1867:         ENDIF
1868:         THIS.AtualizarEstadoCampos()
1869:     ENDPROC
1870: 
1871:     PROCEDURE ValidarVariacao
1872:         IF THIS.txt_4c_Variacao.Value > 0
1873:             THIS.txt_4c_Reajuste.Value = 0
1874:             THIS.txt_4c_Reajuste.Refresh
1875:         ENDIF
1876:         THIS.AtualizarEstadoCampos()
1877:     ENDPROC
1878: 
1879:     PROCEDURE ValidarEncargo
1880:         IF THIS.txt_4c_Encargo.Value < 0
1881:             MsgAviso("Valor Inv" + CHR(225) + "lido!!!", "Aten" + CHR(231) + CHR(227) + "o")
1882:             THIS.txt_4c_Encargo.Value = 0
1883:             THIS.txt_4c_Encargo.SetFocus()
1884:         ENDIF
1885:     ENDPROC
1886: 
1887:     PROCEDURE ValidarFornecedor
1888:         LOCAL loc_cCod, loc_cDesc, loc_cSql
1889:         loc_cCod  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
1890:         loc_cDesc = ""
1891: 
1892:         IF !EMPTY(loc_cCod)
1893:             IF !fAcessoContas(gc_4c_UsuarioLogado, "", "C", loc_cCod, .NULL., .NULL.)
1894:                 MsgAviso("Acesso Negado...", "Aten" + CHR(231) + CHR(227) + "o")
1895:                 THIS.txt_4c_CFornecs.Value = ""
1896:                 THIS.txt_4c_DFornecs.Value = ""
1897:                 RETURN
1898:             ENDIF
1899:             *-- Buscar descricao
1900:             IF gnConnHandle > 0
1901:                 loc_cSql = "SELECT Nomes FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cCod)
1902:                 IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FornTmp") >= 1
1903:                     IF RECCOUNT("cursor_4c_FornTmp") > 0
1904:                         SELECT cursor_4c_FornTmp
1905:                         GO TOP
1906:                         loc_cDesc = ALLTRIM(NVL(cursor_4c_FornTmp.Nomes, ""))
1907:                     ENDIF
1908:                     IF USED("cursor_4c_FornTmp")
1909:                         USE IN cursor_4c_FornTmp
1910:                     ENDIF
1911:                 ENDIF
1912:             ENDIF
1913:             THIS.txt_4c_DFornecs.Value = loc_cDesc
1914:         ELSE
1915:             THIS.txt_4c_CFornecs.Value = ""
1916:             THIS.txt_4c_DFornecs.Value = ""
1917:         ENDIF
1918:     ENDPROC
1919: 
1920:     *==========================================================================
1921:     * LOOKUPS - Metodos helper interno
1922:     *==========================================================================
1923:     PROTECTED PROCEDURE AbrirBuscaGenerica(par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo, par_oCampo)
1924:         LOCAL loc_oForm, loc_cDesc
1925:         loc_cDesc = ""
1926: 
1927:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1928:             par_cTabela, par_cAlias, par_cChave, par_cValor, par_cTitulo)
1929: 
1930:         IF VARTYPE(loc_oForm) != "O"
1931:             RETURN
1932:         ENDIF
1933: 
1934:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1935:             IF USED(par_cAlias)
1936:                 par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
1937:             ENDIF
1938:         ELSE
1939:             IF !loc_oForm.this_lAchouRegistro
1940:             loc_oForm.mAddColuna(par_cChave, "", "C" + CHR(243) + "digo")
1941:             IF USED(par_cAlias)
1942:                 SELECT (par_cAlias)
1943:                 IF FCOUNT() > 1
1944:                     loc_oForm.mAddColuna(FIELD(2), "", "Descri" + CHR(231) + CHR(227) + "o")
1945:                 ENDIF
1946:             ENDIF
1947:             loc_oForm.Show()
1948:             IF loc_oForm.this_lSelecionou AND USED(par_cAlias)
1949:                 par_oCampo.Value = ALLTRIM(EVALUATE(par_cAlias + "." + par_cChave))
1950:             ENDIF
1951:             ENDIF
1952:         ENDIF
1953: 
1954:         IF USED(par_cAlias)
1955:             USE IN (par_cAlias)
1956:         ENDIF
1957:         loc_oForm.Release()
1958:     ENDPROC
1959: 
1960:     *==========================================================================
1961:     * LOOKUPS - Fornecedor
1962:     *==========================================================================
1963:     PROCEDURE AbrirBuscaFornecedor
1964:         LOCAL loc_cVal
1965:         loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
1966:         THIS.AbrirBuscaGenerica("SigCdCli", "cursor_4c_FornBus", "Iclis", loc_cVal, ;
1967:             "Fornecedor", THIS.txt_4c_CFornecs)
1968:         THIS.ValidarFornecedor()
1969:     ENDPROC
1970: 
1971:     PROCEDURE TeclaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
1972:         IF INLIST(par_nKeyCode, 115, 116)
1973:             THIS.AbrirBuscaFornecedor()
1974:         ENDIF
1975:     ENDPROC
1976: 
1977:     *==========================================================================
1978:     * LOOKUPS - Grande Grupo
1979:     *==========================================================================
1980:     PROCEDURE AbrirBuscaMercI
1981:         THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
1982:             ALLTRIM(THIS.txt_4c_MercI.Value), "Grande Grupo", THIS.txt_4c_MercI)
1983:     ENDPROC
1984: 
1985:     PROCEDURE TeclaMercI(par_nKeyCode, par_nShiftAltCtrl)
1986:         IF INLIST(par_nKeyCode, 115, 116)
1987:             THIS.AbrirBuscaMercI()
1988:         ENDIF
1989:     ENDPROC
1990: 
1991:     PROCEDURE AbrirBuscaMercF
1992:         THIS.AbrirBuscaGenerica("SigCdGpr", "cursor_4c_MercBus", "Codigos", ;
1993:             ALLTRIM(THIS.txt_4c_MercF.Value), "Grande Grupo", THIS.txt_4c_MercF)
1994:     ENDPROC
1995: 
1996:     PROCEDURE TeclaMercF(par_nKeyCode, par_nShiftAltCtrl)
1997:         IF INLIST(par_nKeyCode, 115, 116)
1998:             THIS.AbrirBuscaMercF()
1999:         ENDIF
2000:     ENDPROC
2001: 
2002:     *==========================================================================
2003:     * LOOKUPS - Grupo
2004:     *==========================================================================
2005:     PROCEDURE AbrirBuscaCGrui
2006:         THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
2007:             ALLTRIM(THIS.txt_4c_CGrui.Value), "Grupo", THIS.txt_4c_CGrui)
2008:     ENDPROC
2009: 
2010:     PROCEDURE TeclaCGrui(par_nKeyCode, par_nShiftAltCtrl)
2011:         IF INLIST(par_nKeyCode, 115, 116)
2012:             THIS.AbrirBuscaCGrui()
2013:         ENDIF
2014:     ENDPROC
2015: 
2016:     PROCEDURE AbrirBuscaCGruf
2017:         THIS.AbrirBuscaGenerica("SigCdGrp", "cursor_4c_GrpBus", "CGrus", ;
2018:             ALLTRIM(THIS.txt_4c_CGruf.Value), "Grupo", THIS.txt_4c_CGruf)
2019:     ENDPROC
2020: 
2021:     PROCEDURE TeclaCGruf(par_nKeyCode, par_nShiftAltCtrl)
2022:         IF INLIST(par_nKeyCode, 115, 116)
2023:             THIS.AbrirBuscaCGruf()
2024:         ENDIF
2025:     ENDPROC
2026: 
2027:     *==========================================================================
2028:     * LOOKUPS - Subgrupo
2029:     *==========================================================================
2030:     PROCEDURE AbrirBuscaSGruI
2031:         THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
2032:             ALLTRIM(THIS.txt_4c_SGruI.Value), "Subgrupo", THIS.txt_4c_SGruI)
2033:     ENDPROC
2034: 
2035:     PROCEDURE TeclaSGruI(par_nKeyCode, par_nShiftAltCtrl)
2036:         IF INLIST(par_nKeyCode, 115, 116)
2037:             THIS.AbrirBuscaSGruI()
2038:         ENDIF
2039:     ENDPROC
2040: 
2041:     PROCEDURE AbrirBuscaSGruF
2042:         THIS.AbrirBuscaGenerica("SigCdPsg", "cursor_4c_SgrBus", "Codigos", ;
2043:             ALLTRIM(THIS.txt_4c_SGruF.Value), "Subgrupo", THIS.txt_4c_SGruF)
2044:     ENDPROC
2045: 
2046:     PROCEDURE TeclaSGruF(par_nKeyCode, par_nShiftAltCtrl)
2047:         IF INLIST(par_nKeyCode, 115, 116)
2048:             THIS.AbrirBuscaSGruF()
2049:         ENDIF
2050:     ENDPROC
2051: 
2052:     *==========================================================================
2053:     * LOOKUPS - Unidade
2054:     *==========================================================================
2055:     PROCEDURE AbrirBuscaCUniI
2056:         THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
2057:             ALLTRIM(THIS.txt_4c_CUniI.Value), "Unidade", THIS.txt_4c_CUniI)
2058:     ENDPROC
2059: 
2060:     PROCEDURE TeclaCUniI(par_nKeyCode, par_nShiftAltCtrl)
2061:         IF INLIST(par_nKeyCode, 115, 116)
2062:             THIS.AbrirBuscaCUniI()
2063:         ENDIF
2064:     ENDPROC
2065: 
2066:     PROCEDURE AbrirBuscaCUnif
2067:         THIS.AbrirBuscaGenerica("SigCdUni", "cursor_4c_UniBus", "CUnis", ;
2068:             ALLTRIM(THIS.txt_4c_CUnif.Value), "Unidade", THIS.txt_4c_CUnif)
2069:     ENDPROC
2070: 
2071:     PROCEDURE TeclaCUnif(par_nKeyCode, par_nShiftAltCtrl)
2072:         IF INLIST(par_nKeyCode, 115, 116)
2073:             THIS.AbrirBuscaCUnif()
2074:         ENDIF
2075:     ENDPROC
2076: 
2077:     *==========================================================================
2078:     * LOOKUPS - Linha
2079:     *==========================================================================
2080:     PROCEDURE AbrirBuscaLinhI
2081:         THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
2082:             ALLTRIM(THIS.txt_4c_LinhI.Value), "Linha", THIS.txt_4c_LinhI)
2083:     ENDPROC
2084: 
2085:     PROCEDURE TeclaLinhI(par_nKeyCode, par_nShiftAltCtrl)
2086:         IF INLIST(par_nKeyCode, 115, 116)
2087:             THIS.AbrirBuscaLinhI()
2088:         ENDIF
2089:     ENDPROC
2090: 
2091:     PROCEDURE AbrirBuscaLinhF
2092:         THIS.AbrirBuscaGenerica("SigCdLin", "cursor_4c_LinBus", "Linhas", ;
2093:             ALLTRIM(THIS.txt_4c_LinhF.Value), "Linha", THIS.txt_4c_LinhF)
2094:     ENDPROC
2095: 
2096:     PROCEDURE TeclaLinhF(par_nKeyCode, par_nShiftAltCtrl)
2097:         IF INLIST(par_nKeyCode, 115, 116)
2098:             THIS.AbrirBuscaLinhF()
2099:         ENDIF
2100:     ENDPROC
2101: 
2102:     *==========================================================================
2103:     * LOOKUPS - Colecao
2104:     *==========================================================================
2105:     PROCEDURE AbrirBuscaColI
2106:         THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
2107:             ALLTRIM(THIS.txt_4c_ColI.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColI)
2108:     ENDPROC
2109: 
2110:     PROCEDURE TeclaColI(par_nKeyCode, par_nShiftAltCtrl)
2111:         IF INLIST(par_nKeyCode, 115, 116)
2112:             THIS.AbrirBuscaColI()
2113:         ENDIF
2114:     ENDPROC
2115: 
2116:     PROCEDURE AbrirBuscaColF
2117:         THIS.AbrirBuscaGenerica("SigCdCol", "cursor_4c_ColBus", "Colecoes", ;
2118:             ALLTRIM(THIS.txt_4c_ColF.Value), "Cole" + CHR(231) + CHR(227) + "o", THIS.txt_4c_ColF)
2119:     ENDPROC
2120: 
2121:     PROCEDURE TeclaColF(par_nKeyCode, par_nShiftAltCtrl)
2122:         IF INLIST(par_nKeyCode, 115, 116)
2123:             THIS.AbrirBuscaColF()
2124:         ENDIF
2125:     ENDPROC
2126: 
2127:     *==========================================================================
2128:     * LOOKUPS - Moeda
2129:     *==========================================================================
2130:     PROCEDURE AbrirBuscaMoeI
2131:         THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
2132:             ALLTRIM(THIS.txt_4c_MoeI.Value), "Moeda", THIS.txt_4c_MoeI)
2133:     ENDPROC
2134: 
2135:     PROCEDURE TeclaMoeI(par_nKeyCode, par_nShiftAltCtrl)
2136:         IF INLIST(par_nKeyCode, 115, 116)
2137:             THIS.AbrirBuscaMoeI()
2138:         ENDIF
2139:     ENDPROC
2140: 
2141:     PROCEDURE AbrirBuscaMoeF
2142:         THIS.AbrirBuscaGenerica("SigCdMoe", "cursor_4c_MoeBus", "CMoes", ;
2143:             ALLTRIM(THIS.txt_4c_MoeF.Value), "Moeda", THIS.txt_4c_MoeF)
2144:     ENDPROC
2145: 
2146:     PROCEDURE TeclaMoeF(par_nKeyCode, par_nShiftAltCtrl)
2147:         IF INLIST(par_nKeyCode, 115, 116)
2148:             THIS.AbrirBuscaMoeF()
2149:         ENDIF
2150:     ENDPROC
2151: 
2152:     *==========================================================================
2153:     * LOOKUPS - Feitio (MKP atual)
2154:     *==========================================================================
2155:     PROCEDURE AbrirBuscaFeitio
2156:         LOCAL loc_oForm, loc_cVal, loc_cSql
2157:         loc_cVal = ALLTRIM(THIS.txt_4c_Feitio.Value)
2158: 
2159:         IF gnConnHandle > 0
2160:             loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti"
2161:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_FtiBus") >= 1
2162:                 IF !USED("cursor_4c_FtiBus")
2163:                     RETURN
2164:                 ENDIF
2165:                 SELECT cursor_4c_FtiBus
2166:                 INDEX ON Cods TAG Cods ADDITIVE
2167: 
2168:                 IF !SEEK(loc_cVal, "cursor_4c_FtiBus", "Cods")
2169:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2170:                         "SigPrFti", "cursor_4c_FtiBus2", "Cods", loc_cVal, "Feitios")
2171:                     IF !ISNULL(loc_oForm)
2172:                         loc_oForm.mAddColuna("Cods",  "", "Cod")
2173:                         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2174:                         loc_oForm.Show()
2175:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_FtiBus2")
2176:                             THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus2.Cods)
2177:                         ENDIF
2178:                         IF USED("cursor_4c_FtiBus2")
2179:                             USE IN cursor_4c_FtiBus2
2180:                         ENDIF
2181:                         loc_oForm.Release()
2182:                     ENDIF
2183:                 ELSE
2184:                     THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_FtiBus.Cods)
2185:                 ENDIF
2186: 
2187:                 IF USED("cursor_4c_FtiBus")
2188:                     USE IN cursor_4c_FtiBus
2189:                 ENDIF
2190:             ENDIF
2191:         ENDIF
2192:     ENDPROC
2193: 
2194:     PROCEDURE TeclaFeitio(par_nKeyCode, par_nShiftAltCtrl)
2195:         IF INLIST(par_nKeyCode, 115, 116)
2196:             THIS.AbrirBuscaFeitio()
2197:         ENDIF
2198:     ENDPROC
2199: 
2200:     *==========================================================================
2201:     * LOOKUPS - Novo MKP (opcoes 7 e 8)
2202:     *==========================================================================
2203:     PROCEDURE AbrirBuscaNewMkp
2204:         LOCAL loc_oForm, loc_cVal, loc_cSql
2205:         loc_cVal = ALLTRIM(THIS.txt_4c_NewMkp.Value)
2206: 
2207:         IF gnConnHandle > 0
2208:             loc_cSql = "SELECT Cods, Descs, Moedas, Acrescs FROM SigPrFti WHERE Tipos = 1"
2209:             IF SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_MkpBus") >= 1
2210:                 IF !USED("cursor_4c_MkpBus")
2211:                     RETURN
2212:                 ENDIF
2213:                 SELECT cursor_4c_MkpBus
2214:                 INDEX ON Cods TAG Cods ADDITIVE
2215: 
2216:                 IF !SEEK(loc_cVal, "cursor_4c_MkpBus", "Cods")
2217:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2218:                         "SigPrFti", "cursor_4c_MkpBus2", "Cods", loc_cVal, "Feitios")
2219:                     IF !ISNULL(loc_oForm)
2220:                         loc_oForm.mAddColuna("Cods",  "", "Cod")
2221:                         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2222:                         loc_oForm.Show()
2223:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_MkpBus2")
2224:                             THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus2.Cods)
2225:                         ENDIF
2226:                         IF USED("cursor_4c_MkpBus2")
2227:                             USE IN cursor_4c_MkpBus2
2228:                         ENDIF
2229:                         loc_oForm.Release()
2230:                     ENDIF
2231:                 ELSE
2232:                     THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_MkpBus.Cods)
2233:                 ENDIF
2234: 
2235:                 IF USED("cursor_4c_MkpBus")
2236:                     USE IN cursor_4c_MkpBus
2237:                 ENDIF
2238:             ENDIF
2239:         ENDIF
2240:     ENDPROC
2241: 
2242:     PROCEDURE TeclaNewMkp(par_nKeyCode, par_nShiftAltCtrl)
2243:         IF INLIST(par_nKeyCode, 115, 116)
2244:             THIS.AbrirBuscaNewMkp()
2245:         ENDIF
2246:     ENDPROC
2247: 
2248:     *==========================================================================
2249:     * Overrides de FormBase: CRUD nao se aplica a este form OPERACIONAL.
2250:     * Estes metodos existem para evitar "file not found" se FormBase os
2251:     * chamar via KeyPreview (F2/F3/F4/F5).
2252:     *==========================================================================
2253:     PROCEDURE BtnIncluirClick
2254:         RETURN
2255:     ENDPROC
2256: 
2257:     PROCEDURE BtnAlterarClick
2258:         RETURN
2259:     ENDPROC
2260: 
2261:     PROCEDURE BtnVisualizarClick
2262:         RETURN
2263:     ENDPROC
2264: 
2265:     PROCEDURE BtnExcluirClick
2266:         RETURN
2267:     ENDPROC
2268: 
2269:     *==========================================================================
2270:     * AlternarPagina - Form OPERACIONAL com layout flat, sem paginacao
2271:     *==========================================================================
2272:     PROCEDURE AlternarPagina(par_nPagina)
2273:         RETURN
2274:     ENDPROC
2275: 
2276:     *==========================================================================
2277:     * BtnBuscarClick - Override de FormBase (form OPERACIONAL nao tem Buscar)
2278:     *==========================================================================
2279:     PROCEDURE BtnBuscarClick
2280:         RETURN
2281:     ENDPROC
2282: 
2283:     *==========================================================================
2284:     * BtnSalvarClick - Override de FormBase. Em OPERACIONAL o "salvar" equivale
2285:     * a aplicar as alteracoes de preco calculadas (AtualizarPrecos).
2286:     *==========================================================================
2287:     PROCEDURE BtnSalvarClick
2288:         THIS.this_oBusinessObject.AtualizarPrecos(.F.)
2289:     ENDPROC
2290: 
2291:     *==========================================================================
2292:     * BtnCancelarClick - Override de FormBase. Cancela: limpa cursor, zera
2293:     * campos calculados e volta ao estado inicial de captura.
2294:     *==========================================================================
2295:     PROCEDURE BtnCancelarClick
2296:         IF USED("cursor_4c_Dados")
2297:             SELECT cursor_4c_Dados
2298:             ZAP
2299:             THIS.grd_4c_Produto.Refresh
2300:         ENDIF
2301:         THIS.this_oBusinessObject.this_lProcessado = .F.
2302:         THIS.cmd_4c_Atualizar.Enabled = .F.
2303:         THIS.cmd_4c_Imprimir.Enabled  = .F.
2304:     ENDPROC
2305: 
2306:     *==========================================================================
2307:     * CarregarLista - Override de FormBase (form OPERACIONAL nao tem lista CRUD)
2308:     *==========================================================================
2309:     PROCEDURE CarregarLista
2310:         RETURN
2311:     ENDPROC
2312: 
2313:     *==========================================================================
2314:     * AjustarBotoesPorModo - Override de FormBase. Em OPERACIONAL o controle
2315:     * de estado dos botoes eh feito por AtualizarEstadoCampos() em funcao do
2316:     * flag this_lProcessado do BO.
2317:     *==========================================================================
2318:     PROCEDURE AjustarBotoesPorModo
2319:         THIS.AtualizarEstadoCampos()
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * HabilitarCampos - Habilita/desabilita TODOS os campos de captura em
2324:     * funcao do estado do processamento. Enquanto lProcessado = .F., filtros
2325:     * e opcoes ficam habilitados para permitir configurar antes de "Processar".
2326:     *==========================================================================
2327:     PROCEDURE HabilitarCampos(par_lHabilitar)
2328:         LOCAL loc_lEnabled
2329: 
2330:         IF PCOUNT() < 1
2331:             loc_lEnabled = .T.
2332:         ELSE
2333:             loc_lEnabled = par_lHabilitar
2334:         ENDIF
2335: 
2336:         *-- Fornecedor
2337:         THIS.txt_4c_CFornecs.Enabled = loc_lEnabled
2338:         THIS.txt_4c_DFornecs.Enabled = .F.  && sempre readonly (descricao)
2339: 
2340:         *-- Grande Grupo (MercI/MercF)
2341:         THIS.txt_4c_MercI.Enabled = loc_lEnabled
2342:         THIS.txt_4c_MercF.Enabled = loc_lEnabled
2343: 
2344:         *-- Grupo
2345:         THIS.txt_4c_CGrui.Enabled = loc_lEnabled
2346:         THIS.txt_4c_CGruf.Enabled = loc_lEnabled
2347: 
2348:         *-- Subgrupo
2349:         THIS.txt_4c_SGruI.Enabled = loc_lEnabled
2350:         THIS.txt_4c_SGruF.Enabled = loc_lEnabled
2351: 
2352:         *-- Unidade
2353:         THIS.txt_4c_CUniI.Enabled = loc_lEnabled
2354:         THIS.txt_4c_CUnif.Enabled = loc_lEnabled
2355: 
2356:         *-- Linha
2357:         THIS.txt_4c_LinhI.Enabled = loc_lEnabled
2358:         THIS.txt_4c_LinhF.Enabled = loc_lEnabled
2359: 
2360:         *-- Colecao
2361:         THIS.txt_4c_ColI.Enabled = loc_lEnabled
2362:         THIS.txt_4c_ColF.Enabled = loc_lEnabled
2363: 
2364:         *-- Moeda
2365:         THIS.txt_4c_MoeI.Enabled = loc_lEnabled
2366:         THIS.txt_4c_MoeF.Enabled = loc_lEnabled
2367: 

*-- Linhas 2397 a 2440:
2397:     *==========================================================================
2398:     * LimparCampos - Zera todos os campos de captura e o cursor de resultados.
2399:     *==========================================================================
2400:     PROCEDURE LimparCampos
2401:         *-- Fornecedor
2402:         THIS.txt_4c_CFornecs.Value = ""
2403:         THIS.txt_4c_DFornecs.Value = ""
2404: 
2405:         *-- Grande Grupo
2406:         THIS.txt_4c_MercI.Value = ""
2407:         THIS.txt_4c_MercF.Value = ""
2408: 
2409:         *-- Grupo
2410:         THIS.txt_4c_CGrui.Value = ""
2411:         THIS.txt_4c_CGruf.Value = ""
2412: 
2413:         *-- Subgrupo
2414:         THIS.txt_4c_SGruI.Value = ""
2415:         THIS.txt_4c_SGruF.Value = ""
2416: 
2417:         *-- Unidade
2418:         THIS.txt_4c_CUniI.Value = ""
2419:         THIS.txt_4c_CUnif.Value = ""
2420: 
2421:         *-- Linha
2422:         THIS.txt_4c_LinhI.Value = ""
2423:         THIS.txt_4c_LinhF.Value = ""
2424: 
2425:         *-- Colecao
2426:         THIS.txt_4c_ColI.Value = ""
2427:         THIS.txt_4c_ColF.Value = ""
2428: 
2429:         *-- Moeda
2430:         THIS.txt_4c_MoeI.Value = ""
2431:         THIS.txt_4c_MoeF.Value = ""
2432: 
2433:         *-- Markup
2434:         THIS.txt_4c_MrkI.Value = 0
2435:         THIS.txt_4c_MrkF.Value = 0
2436: 
2437:         *-- Encargo (filtro)
2438:         THIS.txt_4c_EncI.Value = 0
2439:         THIS.txt_4c_EncF.Value = 0
2440: 

*-- Linhas 2480 a 2523:
2480:     * FormParaBO - Copia TODOS os valores dos controles do form para o BO
2481:     * antes de qualquer operacao (Processar, AtualizarPrecos).
2482:     *==========================================================================
2483:     PROCEDURE FormParaBO
2484:         LOCAL loc_oBO
2485:         loc_oBO = THIS.this_oBusinessObject
2486: 
2487:         *-- Fornecedor
2488:         loc_oBO.this_cFornecs  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
2489:         loc_oBO.this_cDFornecs = ALLTRIM(THIS.txt_4c_DFornecs.Value)
2490: 
2491:         *-- Grande Grupo (MercI/MercF)
2492:         loc_oBO.this_cMercI = ALLTRIM(THIS.txt_4c_MercI.Value)
2493:         loc_oBO.this_cMercF = ALLTRIM(THIS.txt_4c_MercF.Value)
2494: 
2495:         *-- Grupo
2496:         loc_oBO.this_cGruI = ALLTRIM(THIS.txt_4c_CGrui.Value)
2497:         loc_oBO.this_cGruF = ALLTRIM(THIS.txt_4c_CGruf.Value)
2498: 
2499:         *-- Subgrupo
2500:         loc_oBO.this_cSGruI = ALLTRIM(THIS.txt_4c_SGruI.Value)
2501:         loc_oBO.this_cSGruF = ALLTRIM(THIS.txt_4c_SGruF.Value)
2502: 
2503:         *-- Unidade
2504:         loc_oBO.this_cCuniI = ALLTRIM(THIS.txt_4c_CUniI.Value)
2505:         loc_oBO.this_cCuniF = ALLTRIM(THIS.txt_4c_CUnif.Value)
2506: 
2507:         *-- Linha
2508:         loc_oBO.this_cLinI = ALLTRIM(THIS.txt_4c_LinhI.Value)
2509:         loc_oBO.this_cLinF = ALLTRIM(THIS.txt_4c_LinhF.Value)
2510: 
2511:         *-- Colecao
2512:         loc_oBO.this_cColI = ALLTRIM(THIS.txt_4c_ColI.Value)
2513:         loc_oBO.this_cColF = ALLTRIM(THIS.txt_4c_ColF.Value)
2514: 
2515:         *-- Moeda
2516:         loc_oBO.this_cMoeI = ALLTRIM(THIS.txt_4c_MoeI.Value)
2517:         loc_oBO.this_cMoeF = ALLTRIM(THIS.txt_4c_MoeF.Value)
2518: 
2519:         *-- Markup
2520:         loc_oBO.this_nMrkI = THIS.txt_4c_MrkI.Value
2521:         loc_oBO.this_nMrkF = THIS.txt_4c_MrkF.Value
2522: 
2523:         *-- Encargo (filtro)

*-- Linhas 2548 a 2591:
2548:     * BOParaForm - Reflete TODAS as propriedades do BO nos controles do form.
2549:     * Usado apos carga de configuracao inicial (crSigCdCcp do legado).
2550:     *==========================================================================
2551:     PROCEDURE BOParaForm
2552:         LOCAL loc_oBO
2553:         loc_oBO = THIS.this_oBusinessObject
2554: 
2555:         *-- Fornecedor
2556:         THIS.txt_4c_CFornecs.Value = loc_oBO.this_cFornecs
2557:         THIS.txt_4c_DFornecs.Value = loc_oBO.this_cDFornecs
2558: 
2559:         *-- Grande Grupo
2560:         THIS.txt_4c_MercI.Value = loc_oBO.this_cMercI
2561:         THIS.txt_4c_MercF.Value = loc_oBO.this_cMercF
2562: 
2563:         *-- Grupo
2564:         THIS.txt_4c_CGrui.Value = loc_oBO.this_cGruI
2565:         THIS.txt_4c_CGruf.Value = loc_oBO.this_cGruF
2566: 
2567:         *-- Subgrupo
2568:         THIS.txt_4c_SGruI.Value = loc_oBO.this_cSGruI
2569:         THIS.txt_4c_SGruF.Value = loc_oBO.this_cSGruF
2570: 
2571:         *-- Unidade
2572:         THIS.txt_4c_CUniI.Value = loc_oBO.this_cCuniI
2573:         THIS.txt_4c_CUnif.Value = loc_oBO.this_cCuniF
2574: 
2575:         *-- Linha
2576:         THIS.txt_4c_LinhI.Value = loc_oBO.this_cLinI
2577:         THIS.txt_4c_LinhF.Value = loc_oBO.this_cLinF
2578: 
2579:         *-- Colecao
2580:         THIS.txt_4c_ColI.Value = loc_oBO.this_cColI
2581:         THIS.txt_4c_ColF.Value = loc_oBO.this_cColF
2582: 
2583:         *-- Moeda
2584:         THIS.txt_4c_MoeI.Value = loc_oBO.this_cMoeI
2585:         THIS.txt_4c_MoeF.Value = loc_oBO.this_cMoeF
2586: 
2587:         *-- Markup
2588:         THIS.txt_4c_MrkI.Value = loc_oBO.this_nMrkI
2589:         THIS.txt_4c_MrkF.Value = loc_oBO.this_nMrkF
2590: 
2591:         *-- Encargo (filtro)

*-- Linhas 2615 a 2623:
2615:     ENDPROC
2616: 
2617:     *==========================================================================
2618:     PROCEDURE Destroy
2619:     *==========================================================================
2620:         DODEFAULT()
2621:     ENDPROC
2622: 
2623: ENDDEFINE

