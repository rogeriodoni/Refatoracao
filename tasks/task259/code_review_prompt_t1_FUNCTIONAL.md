# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2177 linhas total):

*-- Linhas 25 a 199:
25:     this_cAntValue  = ""
26: 
27:     *==========================================================================
28:     PROCEDURE Init()
29:     *==========================================================================
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *==========================================================================
34:     PROTECTED PROCEDURE ConfigurarPageFrame()
35:     *==========================================================================
36:         THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
37:         THIS.ScrollBars = 0
38:         THIS.ShowTips   = .F.
39:     ENDPROC
40: 
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:     *==========================================================================
44:         LOCAL loc_lSucesso, loc_oErro
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.ConfigurarPageFrame()
49: 
50:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
51:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
52:                 MsgErro("Erro ao criar SigPrAprBO.", "Erro InicializarForm")
53:             ELSE
54:                 IF !THIS.this_oBusinessObject.CarregarDadosIniciais()
55:                 MsgErro("Falha ao carregar dados iniciais.", "Erro InicializarForm")
56:             ELSE
57:             THIS.this_lLibValAtu = THIS.this_oBusinessObject.this_lLibValAtu
58: 
59:             THIS.ConfigurarCabecalho()
60:             THIS.ConfigurarBotoes()
61:             THIS.ConfigurarFiltros()
62:             THIS.ConfigurarGrade()
63:             THIS.CarregarLista()
64: 
65:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
69:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
70:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
71: 
72:             BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoChange")
73:             BINDEVENT(THIS.chk_4c_Auditado, "Click",         THIS, "ChkAuditadoClick")
74: 
75:             BINDEVENT(THIS.txt_4c_GrupoIni,  "KeyPress", THIS, "TxtGrupoIniKeyPress")
76:             BINDEVENT(THIS.txt_4c_GrupoFim,  "KeyPress", THIS, "TxtGrupoFimKeyPress")
77:             BINDEVENT(THIS.txt_4c_Colecao,   "KeyPress", THIS, "TxtColecaoKeyPress")
78:             BINDEVENT(THIS.txt_4c_Conta,     "KeyPress", THIS, "TxtContaKeyPress")
79:             BINDEVENT(THIS.txt_4c_DConta,    "KeyPress", THIS, "TxtDContaKeyPress")
80:             BINDEVENT(THIS.txt_4c_Promo,     "KeyPress", THIS, "TxtPromoKeyPress")
81:             BINDEVENT(THIS.txt_4c_Moeda,     "KeyPress", THIS, "TxtMoedaKeyPress")
82:             BINDEVENT(THIS.txt_4c_MoeCs,     "KeyPress", THIS, "TxtMoeCsKeyPress")
83:             BINDEVENT(THIS.txt_4c_MoeCusFs,  "KeyPress", THIS, "TxtMoeCusFsKeyPress")
84:             BINDEVENT(THIS.txt_4c_Moedas,    "KeyPress", THIS, "TxtMoedasKeyPress")
85:             BINDEVENT(THIS.txt_4c_CFtios,    "KeyPress", THIS, "TxtCFtiosKeyPress")
86:             BINDEVENT(THIS.txt_4c_MoeVs,     "KeyPress", THIS, "TxtMoeVsKeyPress")
87:             BINDEVENT(THIS.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")
88: 
89:             BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdAfterRowColChange")
90:             BINDEVENT(THIS.grd_4c_Dados, "HeaderClick",       THIS, "GrdHeaderClick")
91:             BINDEVENT(THIS.grd_4c_Dados, "KeyPress",          THIS, "GrdKeyPress")
92: 
93:             THIS.TornarControlesVisiveis(THIS)
94: 
95:             THIS.opt_4c_Tipo.Value = 1
96:             THIS.OptTipoChange()
97: 
98:             THIS.AjustarBotoesPorModo()
99: 
100:             THIS.txt_4c_GrupoIni.SetFocus()
101: 
102:             loc_lSucesso = .T.
103:                 ENDIF
104:             ENDIF
105:         CATCH TO loc_oErro
106:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
107:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm FormSigPrApr")
108:         ENDTRY
109: 
110:         RETURN loc_lSucesso
111:     ENDPROC
112: 
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarCabecalho()
115:     *==========================================================================
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH THIS.cnt_4c_Cabecalho
118:             .Top         = 0
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackStyle   = 1
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125: 
126:             .AddObject("lbl_4c_Sombra", "Label")
127:             WITH .lbl_4c_Sombra
128:                 .Top       = 18
129:                 .Left      = 10
130:                 .Width     = THIS.Width
131:                 .Height    = 40
132:                 .AutoSize  = .F.
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 18
135:                 .FontBold  = .T.
136:                 .BackStyle = 0
137:                 .ForeColor = RGB(0, 0, 0)
138:                 .Caption   = THIS.Caption
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .Top       = 17
144:                 .Left      = 10
145:                 .Width     = THIS.Width
146:                 .Height    = 46
147:                 .AutoSize  = .F.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .FontBold  = .T.
151:                 .BackStyle = 0
152:                 .ForeColor = RGB(255, 255, 255)
153:                 .Caption   = THIS.Caption
154:             ENDWITH
155:         ENDWITH
156:     ENDPROC
157: 
158:     *==========================================================================
159:     PROTECTED PROCEDURE ConfigurarBotoes()
160:     *==========================================================================
161:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
162:         WITH THIS.cmg_4c_Botoes
163:             .ButtonCount   = 3
164:             .BackStyle     = 0
165:             .BorderStyle   = 0
166:             .SpecialEffect = 1
167:             .Themes        = .F.
168:             .Top           = 0
169:             .Left          = 765
170:             .Width         = 235
171:             .Height        = 85
172: 
173:             WITH .Buttons(1)
174:                 .Top        = 5
175:                 .Left       = 5
176:                 .Width      = 75
177:                 .Height     = 75
178:                 .FontBold   = .T.
179:                 .FontItalic = .T.
180:                 .Caption    = "Processar"
181:                 .FontName        = "Comic Sans MS"
182:                 .FontSize        = 8
183:                 .ForeColor  = RGB(90, 90, 90)
184:                 .BackColor  = RGB(255, 255, 255)
185:                 .Themes     = .F.
186:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
187:             ENDWITH
188: 
189:             WITH .Buttons(2)
190:                 .Top        = 5
191:                 .Left       = 80
192:                 .Width      = 75
193:                 .Height     = 75
194:                 .FontName   = "Comic Sans MS"
195:                 .FontSize   = 8
196:                 .FontBold   = .T.
197:                 .FontItalic = .T.
198:                 .Caption    = "Atualizar"
199:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 224 a 267:
224:     ENDPROC
225: 
226:     *==========================================================================
227:     PROTECTED PROCEDURE ConfigurarFiltros()
228:     *==========================================================================
229:         *-- Grupo de Produto (inicio/fim)
230:         THIS.AddObject("lbl_4c_GrupoP", "Label")
231:         WITH THIS.lbl_4c_GrupoP
232:             .Top      = 113
233:             .Left     = 69
234:             .Width    = 94
235:             .Height   = 15
236:             .FontName = "Tahoma"
237:             .FontSize = 8
238:             .BackStyle = 0
239:             .Caption  = "Grupo de Produto :"
240:         ENDWITH
241: 
242:         THIS.AddObject("txt_4c_GrupoIni", "TextBox")
243:         WITH THIS.txt_4c_GrupoIni
244:             .Top       = 109
245:             .Left      = 165
246:             .Width     = 31
247:             .Height    = 23
248:             .FontName  = "Tahoma"
249:             .FontSize  = 8
250:             .MaxLength = 3
251:             .InputMask = "XXX"
252:         ENDWITH
253: 
254:         THIS.AddObject("lbl_4c_GrupoAte", "Label")
255:         WITH THIS.lbl_4c_GrupoAte
256:             .Top      = 113
257:             .Left     = 203
258:             .Width    = 18
259:             .Height   = 15
260:             .FontName = "Tahoma"
261:             .FontSize = 8
262:             .BackStyle = 0
263:             .Caption  = "at" + CHR(233)
264:         ENDWITH
265: 
266:         THIS.AddObject("txt_4c_GrupoFim", "TextBox")
267:         WITH THIS.txt_4c_GrupoFim

*-- Linhas 289 a 345:
289:             .Value    = 0
290:         ENDWITH
291: 
292:         *-- Reajuste por: (label) + OptionGroup tipo
293:         THIS.AddObject("lbl_4c_ReajustePor", "Label")
294:         WITH THIS.lbl_4c_ReajustePor
295:             .Top      = 139
296:             .Left     = 92
297:             .Width    = 71
298:             .Height   = 15
299:             .FontName = "Tahoma"
300:             .FontSize = 8
301:             .BackStyle = 0
302:             .Caption  = "Reajuste por :"
303:         ENDWITH
304: 
305:         THIS.AddObject("opt_4c_Tipo", "OptionGroup")
306:         WITH THIS.opt_4c_Tipo
307:             .Top         = 134
308:             .Left        = 159
309:             .Width       = 208
310:             .Height      = 24
311:             .ButtonCount = 3
312:             .BackStyle   = 0
313:             .BorderStyle = 0
314:             .Value       = 1
315: 
316:             WITH .Buttons(1)
317:                 .Caption  = "Varia" + CHR(231) + CHR(227) + "o %"
318:                 .FontName        = "Comic Sans MS"
319:                 .FontSize        = 8
320:                 .Width    = 68
321:                 .Height   = 18
322:                 .Left     = 2
323:                 .Top      = 2
324:             ENDWITH
325:             WITH .Buttons(2)
326:                 .Caption  = "MarkUp"
327:                 .Width    = 62
328:                 .Height   = 18
329:                 .Left     = 72
330:                 .Top      = 2
331:                 .FontName = "Comic Sans MS"
332:                 .FontSize = 8
333:             ENDWITH
334:             WITH .Buttons(3)
335:                 .Caption  = "C" + CHR(226) + "mbio"
336:                 .WordWrap        = .T.
337:                 .Width    = 60
338:                 .Height   = 18
339:                 .Left     = 136
340:                 .Top      = 2
341:                 .FontName = "Comic Sans MS"
342:                 .FontSize = 8
343:             ENDWITH
344:         ENDWITH
345: 

*-- Linhas 765 a 1229:
765:     ENDPROC
766: 
767:     *==========================================================================
768:     PROTECTED PROCEDURE ConfigurarGrade()
769:     *==========================================================================
770:         THIS.AddObject("grd_4c_Dados", "Grid")
771:         WITH THIS.grd_4c_Dados
772:             .Top           = 307
773:             .Left          = 31
774:             .Width         = 725
775:             .Height        = 247
776:             .ColumnCount   = 5
777:             .FontName      = "Tahoma"
778:             .FontSize      = 8
779:             .DeleteMark    = .F.
780:             .RecordMark    = .F.
781:             .GridLines     = 3
782:             .GridLineWidth = 1
783:             .HeaderHeight  = 17
784:             .RowHeight     = 17
785:             .ScrollBars    = 3
786:             .RecordSource  = "cursor_4c_Produtos"
787:             .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
788:             .Column2.ControlSource = "cursor_4c_Produtos.CPros"
789:             .Column3.ControlSource = "cursor_4c_Produtos.DPros"
790:             .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
791:             .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
792: 
793:             *-- Coluna 1: CheckBox de selecao
794:             WITH .Column1
795:                 .Width      = 25
796:                 .Movable    = .F.
797:                 .Resizable  = .F.
798:                 .Sparse     = .F.
799:                 .AddObject("Check1", "CheckBox")
800:                 .Check1.Caption = ""
801:                 .Check1.Value   = 0
802:                 .CurrentControl = "Check1"
803:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
804:                 WITH .Header1
805:                     .Caption = ""
806:                     .Tag     = "1"
807:                 ENDWITH
808:             ENDWITH
809: 
810:             *-- Coluna 2: Codigo do produto
811:             WITH .Column2
812:                 .Width         = 110
813:                 .Movable       = .F.
814:                 .Resizable     = .F.
815:                 .ReadOnly      = .T.
816:                 .ControlSource = "cursor_4c_Produtos.CPros"
817:                 WITH .Header1
818:                     .Caption = "Produto"
819:                 ENDWITH
820:                 WITH .Text1
821:                     .FontName = "Verdana"
822:                     .FontSize = 8
823:                 ENDWITH
824:             ENDWITH
825: 
826:             *-- Coluna 3: Descricao (ReadOnly)
827:             WITH .Column3
828:                 .Width         = 260
829:                 .Movable       = .F.
830:                 .Resizable     = .F.
831:                 .ReadOnly      = .T.
832:                 .ControlSource = "cursor_4c_Produtos.DPros"
833:                 WITH .Header1
834:                     .Caption = "Descri" + CHR(231) + CHR(227) + "o"
835:                 ENDWITH
836:                 WITH .Text1
837:                     .FontName = "Verdana"
838:                     .FontSize = 8
839:                 ENDWITH
840:             ENDWITH
841: 
842:             *-- Coluna 4: Preco Anterior (ReadOnly)
843:             WITH .Column4
844:                 .Width         = 165
845:                 .Movable       = .F.
846:                 .Resizable     = .F.
847:                 .ReadOnly      = .T.
848:                 .ControlSource = "cursor_4c_Produtos.ValAnt"
849:                 .Alignment     = 3
850:                 WITH .Header1
851:                     .Caption = "Pre" + CHR(231) + "o Anterior"
852:                 ENDWITH
853:                 WITH .Text1
854:                     .FontName  = "Verdana"
855:                     .FontSize  = 8
856:                     .InputMask = "999,999.99"
857:                 ENDWITH
858:             ENDWITH
859: 
860:             *-- Coluna 5: Preco Atual (editavel se LibValAtu)
861:             WITH .Column5
862:                 .Width         = 165
863:                 .Movable       = .F.
864:                 .Resizable     = .F.
865:                 .ReadOnly      = !THIS.this_lLibValAtu
866:                 .ControlSource = "cursor_4c_Produtos.ValAtu"
867:                 .Alignment     = 3
868:                 WITH .Header1
869:                     .Caption = "Pre" + CHR(231) + "o Atual"
870:                     IF !THIS.this_lLibValAtu
871:                         .Picture = gc_4c_CaminhoIcones + "LOCK.BMP"
872:                     ENDIF
873:                 ENDWITH
874:                 WITH .Text1
875:                     .FontName  = "Verdana"
876:                     .FontSize  = 8
877:                     .InputMask = "999,999.99"
878:                 ENDWITH
879:             ENDWITH
880:         ENDWITH
881:     ENDPROC
882: 
883:     *==========================================================================
884:     PROCEDURE Destroy()
885:     *==========================================================================
886:         LOCAL loc_aCursors(16), loc_i
887:         loc_aCursors(1)  = "cursor_4c_Produtos"
888:         loc_aCursors(2)  = "cursor_4c_TmpPro"
889:         loc_aCursors(3)  = "cursor_4c_SigCdGrp"
890:         loc_aCursors(4)  = "cursor_4c_TmpProSQL"
891:         loc_aCursors(5)  = "cursor_4c_FigTemp"
892:         loc_aCursors(6)  = "cursor_4c_BuscaPro"
893:         loc_aCursors(7)  = "cursor_4c_BuscaProSingle"
894:         loc_aCursors(8)  = "cursor_4c_BuscaMoe"
895:         loc_aCursors(9)  = "cursor_4c_BuscaGrp"
896:         loc_aCursors(10) = "cursor_4c_BuscaCol"
897:         loc_aCursors(11) = "cursor_4c_BuscaConta"
898:         loc_aCursors(12) = "cursor_4c_BuscaPromo"
899:         loc_aCursors(13) = "cursor_4c_BuscaFtio"
900:         loc_aCursors(14) = "cursor_4c_Selecionados"
901:         loc_aCursors(15) = "cursor_4c_SigCdPam"
902:         loc_aCursors(16) = "cursor_4c_SigCdPac"
903:         FOR loc_i = 1 TO 16
904:             IF USED(loc_aCursors(loc_i))
905:                 USE IN (loc_aCursors(loc_i))
906:             ENDIF
907:         NEXT
908:         DODEFAULT()
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * Transferencia Form <-> BO
913:     *==========================================================================
914:     PROCEDURE FormParaBO()
915:         WITH THIS.this_oBusinessObject
916:             .this_nTipo        = THIS.opt_4c_Tipo.Value
917:             .this_cGrupoInicio = ALLTRIM(THIS.txt_4c_GrupoIni.Value)
918:             .this_cGrupoFim    = ALLTRIM(THIS.txt_4c_GrupoFim.Value)
919:             .this_cColecao     = ALLTRIM(THIS.txt_4c_Colecao.Value)
920:             .this_cConta       = ALLTRIM(THIS.txt_4c_Conta.Value)
921:             .this_cDConta      = ALLTRIM(THIS.txt_4c_DConta.Value)
922:             .this_cPromo       = ALLTRIM(THIS.txt_4c_Promo.Value)
923:             .this_nVariacao    = THIS.txt_4c_Variacao.Value
924:             .this_cMoeda       = ALLTRIM(THIS.txt_4c_Moeda.Value)
925:             .this_nMarkUp1     = THIS.txt_4c_MarkUp1.Value
926:             .this_nMarkUp2     = THIS.txt_4c_MarkUp2.Value
927:             .this_nFator       = THIS.txt_4c_Fator.Value
928:             .this_cMoeCusto    = ALLTRIM(THIS.txt_4c_MoeCusto.Value)
929:             .this_cMoeCs       = ALLTRIM(THIS.txt_4c_MoeCs.Value)
930:             .this_cMoeCusFs    = ALLTRIM(THIS.txt_4c_MoeCusFs.Value)
931:             .this_cMoedas      = ALLTRIM(THIS.txt_4c_Moedas.Value)
932:             .this_cCFtios      = ALLTRIM(THIS.txt_4c_CFtios.Value)
933:             .this_cMoeVs       = ALLTRIM(THIS.txt_4c_MoeVs.Value)
934:             .this_nAuditado    = THIS.chk_4c_Auditado.Value
935:             .this_nLimpar      = THIS.chk_4c_Limpar.Value
936:             .this_nIncCusts    = THIS.chk_4c_IncCusts.Value
937:             .this_nIgnorar     = THIS.chk_4c_Ignorar.Value
938:         ENDWITH
939:     ENDPROC
940: 
941:     PROCEDURE BOParaForm()
942:         WITH THIS.this_oBusinessObject
943:             THIS.opt_4c_Tipo.Value     = .this_nTipo
944:             THIS.txt_4c_GrupoIni.Value = .this_cGrupoInicio
945:             THIS.txt_4c_GrupoFim.Value = .this_cGrupoFim
946:             THIS.txt_4c_Colecao.Value  = .this_cColecao
947:             THIS.txt_4c_Conta.Value    = .this_cConta
948:             THIS.txt_4c_DConta.Value   = .this_cDConta
949:             THIS.txt_4c_Promo.Value    = .this_cPromo
950:             THIS.txt_4c_Variacao.Value = .this_nVariacao
951:             THIS.txt_4c_Moeda.Value    = .this_cMoeda
952:             THIS.txt_4c_MarkUp1.Value  = .this_nMarkUp1
953:             THIS.txt_4c_MarkUp2.Value  = .this_nMarkUp2
954:             THIS.txt_4c_Fator.Value    = .this_nFator
955:             THIS.txt_4c_MoeCusto.Value = .this_cMoeCusto
956:             THIS.txt_4c_MoeCs.Value    = .this_cMoeCs
957:             THIS.txt_4c_MoeCusFs.Value = .this_cMoeCusFs
958:             THIS.txt_4c_Moedas.Value   = .this_cMoedas
959:             THIS.txt_4c_CFtios.Value   = .this_cCFtios
960:             THIS.txt_4c_MoeVs.Value    = .this_cMoeVs
961:         ENDWITH
962:     ENDPROC
963: 
964:     *==========================================================================
965:     * BtnProcessarClick - Calcula novos precos e preenche o grid
966:     *==========================================================================
967:     PROCEDURE BtnProcessarClick()
968:         LOCAL loc_lSucesso, loc_oErro
969:         loc_lSucesso = .F.
970: 
971:         TRY
972:             THIS.FormParaBO()
973:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarReajuste()
974:             IF loc_lSucesso
975:                 THIS.grd_4c_Dados.ColumnCount = 3
976:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
977:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
978:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
979:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
980:                 THIS.grd_4c_Dados.Refresh()
981:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
982:                 THIS.cmg_4c_Botoes.Refresh()
983:                 THIS.grd_4c_Dados.Column1.SetFocus()
984:             ENDIF
985:         CATCH TO loc_oErro
986:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
987:                     " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
988:         ENDTRY
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * BtnAtualizarClick - Grava alteracoes no banco de dados
993:     *==========================================================================
994:     PROCEDURE BtnAtualizarClick()
995:         LOCAL loc_llImpEtiq, loc_lSucesso, loc_oErro
996:         loc_lSucesso = .F.
997: 
998:         TRY
999:             IF MsgConfirma("Atualiza" + CHR(63), ;
1000:                 "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
1001: 
1002:                 THIS.FormParaBO()
1003: 
1004:                 loc_llImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
1005: 
1006:                 loc_lSucesso = THIS.this_oBusinessObject.AtualizarPrecos(loc_llImpEtiq)
1007: 
1008:                 IF loc_lSucesso
1009:                     THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1010:                     THIS.cmg_4c_Botoes.Refresh()
1011:                 ENDIF
1012:             ENDIF
1013:         CATCH TO loc_oErro
1014:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1015:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAtualizarClick")
1016:         ENDTRY
1017:     ENDPROC
1018: 
1019:     *==========================================================================
1020:     PROCEDURE BtnEncerrarClick()
1021:     *==========================================================================
1022:         THIS.Release()
1023:     ENDPROC
1024: 
1025:     *==========================================================================
1026:     * BtnSalvarClick - Persiste as alteracoes de preco no banco
1027:     * Form OPERACIONAL: delega para BtnAtualizarClick (equivalente ao "sair.Processa")
1028:     *==========================================================================
1029:     PROCEDURE BtnSalvarClick()
1030:         THIS.BtnAtualizarClick()
1031:     ENDPROC
1032: 
1033:     *==========================================================================
1034:     * BtnCancelarClick - Descarta o pre-processamento e reinicia os filtros
1035:     * Form OPERACIONAL: limpa cursor de produtos, filtros e ajusta botoes
1036:     *==========================================================================
1037:     PROCEDURE BtnCancelarClick()
1038:         LOCAL loc_oErro
1039: 
1040:         TRY
1041:             THIS.LimparCampos()
1042:         CATCH TO loc_oErro
1043:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1044:                     " PROC=" + loc_oErro.Procedure, "Erro BtnCancelarClick")
1045:         ENDTRY
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     * BtnIncluirClick - Adiciona linha vazia ao grid para entrada manual
1050:     * (equivalente ao modo Auditado do legado - permite user digitar produto)
1051:     *==========================================================================
1052:     PROCEDURE BtnIncluirClick()
1053:         LOCAL loc_oErro
1054: 
1055:         TRY
1056:             IF !USED("cursor_4c_Produtos")
1057:                 CREATE CURSOR cursor_4c_Produtos ( ;
1058:                     lMarca  N(1) NULL, ;
1059:                     CPros   C(14) NULL, ;
1060:                     DPros   C(40) NULL, ;
1061:                     ValAnt  N(14,4) NULL, ;
1062:                     ValAtu  N(14,4) NULL, ;
1063:                     fCustos N(9,4) NULL, ;
1064:                     MoePcs  C(3) NULL, ;
1065:                     CustoFs N(14,4) NULL, ;
1066:                     Manual  N(1) NULL)
1067:                 INDEX ON CPros TAG CPros
1068:             ENDIF
1069: 
1070:             INSERT INTO cursor_4c_Produtos ;
1071:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1072:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1073: 
1074:             SELECT cursor_4c_Produtos
1075:             SET ORDER TO
1076:             GO BOTTOM
1077: 
1078:             THIS.grd_4c_Dados.ColumnCount = 3
1079:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1080:             THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
1081:             THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
1082:             THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
1083:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1084:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1085:             THIS.grd_4c_Dados.Refresh()
1086:             THIS.grd_4c_Dados.SetFocus()
1087:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1090:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1091:         ENDTRY
1092:     ENDPROC
1093: 
1094:     *==========================================================================
1095:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1096:     * Delega para BtnProcessarClick que executa o processamento principal
1097:     *==========================================================================
1098:     PROCEDURE BtnAlterarClick()
1099:         LOCAL loc_oErro
1100: 
1101:         TRY
1102:             THIS.BtnProcessarClick()
1103:         CATCH TO loc_oErro
1104:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1105:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
1106:         ENDTRY
1107:     ENDPROC
1108: 
1109:     *==========================================================================
1110:     * BtnVisualizarClick - Exibe foto e detalhes do produto selecionado
1111:     * Refresca a linha atual do grid disparando a mesma logica de AfterRowColChange
1112:     *==========================================================================
1113:     PROCEDURE BtnVisualizarClick()
1114:         LOCAL loc_oErro
1115: 
1116:         TRY
1117:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1118:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1119:                         "Visualizar")
1120:             ELSE
1121:                 SELECT cursor_4c_Produtos
1122:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1123:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1124:                             "Visualizar")
1125:                 ELSE
1126:                     THIS.GrdAfterRowColChange(2)
1127:                     THIS.grd_4c_Dados.Refresh()
1128:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1129:                         THIS.img_4c_Foto.Refresh()
1130:                     ENDIF
1131:                 ENDIF
1132:             ENDIF
1133:         CATCH TO loc_oErro
1134:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1135:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1136:         ENDTRY
1137:     ENDPROC
1138: 
1139:     *==========================================================================
1140:     * BtnExcluirClick - Remove produtos marcados/selecionados do grid
1141:     * (nao exclui do banco - apenas remove do cursor de pre-processamento)
1142:     *==========================================================================
1143:     PROCEDURE BtnExcluirClick()
1144:         LOCAL loc_nRemovidos, loc_oErro
1145:         loc_nRemovidos = 0
1146: 
1147:         TRY
1148:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1149:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1150:             ELSE
1151:                 SELECT cursor_4c_Produtos
1152:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1153: 
1154:                 IF loc_nRemovidos = 0
1155:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1156:                             "Excluir")
1157:                         IF !EOF("cursor_4c_Produtos")
1158:                             DELETE
1159:                             PACK MEMO
1160:                             loc_nRemovidos = 1
1161:                         ENDIF
1162:                     ENDIF
1163:                 ELSE
1164:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1165:                             " produto(s) marcado(s) do grid?", "Excluir")
1166:                         DELETE FOR NVL(lMarca, 0) = 1
1167:                         PACK MEMO
1168:                     ELSE
1169:                         loc_nRemovidos = 0
1170:                     ENDIF
1171:                 ENDIF
1172: 
1173:                 IF loc_nRemovidos > 0
1174:                     SELECT cursor_4c_Produtos
1175:                     GO TOP
1176:                     THIS.grd_4c_Dados.Refresh()
1177:                     THIS.Refresh()
1178:                 ENDIF
1179:             ENDIF
1180:         CATCH TO loc_oErro
1181:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1182:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1183:         ENDTRY
1184:     ENDPROC
1185: 
1186:     *==========================================================================
1187:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1188:     *==========================================================================
1189:     PROCEDURE OptTipoChange()
1190:         LOCAL loc_nTipo
1191:         loc_nTipo = THIS.opt_4c_Tipo.Value
1192: 
1193:         DO CASE
1194:         CASE loc_nTipo = 1
1195:             THIS.lbl_4c_Variacao.Visible  = .T.
1196:             THIS.txt_4c_Variacao.Visible  = .T.
1197:             THIS.lbl_4c_Pct.Visible       = .T.
1198:             THIS.chk_4c_IncCusts.Visible  = .T.
1199:             THIS.lbl_4c_Moeda.Visible     = .F.
1200:             THIS.txt_4c_Moeda.Visible     = .F.
1201:             THIS.lbl_4c_MarkUp.Visible    = .F.
1202:             THIS.txt_4c_MarkUp1.Visible   = .F.
1203:             THIS.lbl_4c_Para.Visible      = .F.
1204:             THIS.txt_4c_MarkUp2.Visible   = .F.
1205:             THIS.lbl_4c_FatorCusto.Visible = .F.
1206:             THIS.txt_4c_Fator.Visible     = .F.
1207:             THIS.txt_4c_MoeCusto.Visible  = .F.
1208:             THIS.lbl_4c_Moeda1.Visible    = .F.
1209:             THIS.txt_4c_MoeCs.Visible     = .F.
1210:             THIS.lbl_4c_Moeda2.Visible    = .F.
1211:             THIS.txt_4c_MoeCusFs.Visible  = .F.
1212:             THIS.lbl_4c_Moeda4.Visible    = .F.
1213:             THIS.txt_4c_Moedas.Visible    = .F.
1214:             THIS.lbl_4c_Moeda3.Visible    = .F.
1215:             THIS.txt_4c_CFtios.Visible    = .F.
1216:             THIS.lbl_4c_Moeda5.Visible    = .F.
1217:             THIS.txt_4c_MoeVs.Visible     = .F.
1218: 
1219:         CASE loc_nTipo = 2
1220:             THIS.lbl_4c_Variacao.Visible  = .F.
1221:             THIS.txt_4c_Variacao.Visible  = .F.
1222:             THIS.lbl_4c_Pct.Visible       = .F.
1223:             THIS.chk_4c_IncCusts.Visible  = .F.
1224:             THIS.lbl_4c_Moeda.Visible     = .T.
1225:             THIS.txt_4c_Moeda.Visible     = .T.
1226:             THIS.lbl_4c_MarkUp.Visible    = .T.
1227:             THIS.txt_4c_MarkUp1.Visible   = .T.
1228:             THIS.lbl_4c_Para.Visible      = .T.
1229:             THIS.txt_4c_MarkUp2.Visible   = .T.

*-- Linhas 1273 a 1468:
1273:     *==========================================================================
1274:     * ChkAuditadoClick - Modo de edicao manual no grid
1275:     *==========================================================================
1276:     PROCEDURE ChkAuditadoClick()
1277:         IF THIS.chk_4c_Auditado.Value = 1
1278:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1279:             IF USED("cursor_4c_Produtos")
1280:                 INSERT INTO cursor_4c_Produtos ;
1281:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1282:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1283:                 SELECT cursor_4c_Produtos
1284:                 SET ORDER TO
1285:                 GO TOP
1286:             ENDIF
1287:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1288:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1289:             THIS.txt_4c_Colecao.Enabled               = .F.
1290:             THIS.txt_4c_Moeda.Enabled                 = .F.
1291:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1292:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1293:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1294:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1295:             THIS.grd_4c_Dados.Refresh()
1296:         ELSE
1297:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1298:             IF USED("cursor_4c_Produtos")
1299:                 DELETE FROM cursor_4c_Produtos
1300:                 SELECT cursor_4c_Produtos
1301:                 SET ORDER TO CPros
1302:                 GO TOP
1303:             ENDIF
1304:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1305:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1306:             THIS.txt_4c_Colecao.Enabled               = .T.
1307:             THIS.txt_4c_Moeda.Enabled                 = .T.
1308:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1309:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1310:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1311:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1312:             THIS.grd_4c_Dados.Refresh()
1313:             THIS.txt_4c_GrupoIni.SetFocus()
1314:         ENDIF
1315:         THIS.cmg_4c_Botoes.Refresh()
1316:     ENDPROC
1317: 
1318:     *==========================================================================
1319:     * GrdAfterRowColChange - foto do produto + rastrear edicao manual do preco
1320:     *==========================================================================
1321:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1322:         LOCAL loc_cArqFig, loc_cSQL, loc_cFoto, loc_oErro
1323: 
1324:         TRY
1325:             IF USED("cursor_4c_Produtos")
1326:                 SELECT cursor_4c_Produtos
1327:                 IF EOF("cursor_4c_Produtos")
1328:                     THIS.img_4c_Foto.Visible = .F.
1329:                     THIS.img_4c_Foto.Picture = ""
1330:                 ELSE
1331:                     *-- Rastrear edicao manual do preco (Column5)
1332:                     IF par_nColIndex = 5
1333:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1334:                     ELSE
1335:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1336:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1337:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1338:                         ENDIF
1339:                         THIS.this_cAntValue = ""
1340:                         ENDIF
1341:                     ENDIF
1342: 
1343:                     *-- Exibir foto do produto
1344:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1345:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1346:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1347:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1348:                         IF USED("cursor_4c_FigTemp")
1349:                             USE IN cursor_4c_FigTemp
1350:                         ENDIF
1351:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1352:                             SELECT cursor_4c_FigTemp
1353:                             THIS.img_4c_Foto.Visible = .F.
1354:                             THIS.img_4c_Foto.Picture = ""
1355:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1356:                                 CLEAR RESOURCES
1357:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1358:                                     "data:image/png;base64,", ""), ;
1359:                                     "data:image/jpeg;base64,", ""), ;
1360:                                     "data:image/jpg;base64,", ""), 14)
1361:                                 STRTOFILE(loc_cFoto, loc_cArqFig)
1362:                                 THIS.img_4c_Foto.Picture = loc_cArqFig
1363:                                 THIS.img_4c_Foto.Visible = .T.
1364:                             ENDIF
1365:                             USE IN cursor_4c_FigTemp
1366:                             SELECT cursor_4c_Produtos
1367:                         ELSE
1368:                             THIS.img_4c_Foto.Visible = .F.
1369:                             THIS.img_4c_Foto.Picture = ""
1370:                         ENDIF
1371:                     ELSE
1372:                         THIS.img_4c_Foto.Visible = .F.
1373:                         THIS.img_4c_Foto.Picture = ""
1374:                     ENDIF
1375:                 ENDIF
1376:             ENDIF
1377:         CATCH TO loc_oErro
1378:             IF USED("cursor_4c_FigTemp")
1379:                 USE IN cursor_4c_FigTemp
1380:             ENDIF
1381:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1382:                     " PROC=" + loc_oErro.Procedure, "Erro GrdAfterRowColChange")
1383:         ENDTRY
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * GrdHeaderClick - clicar no header da Column1 marca/desmarca todos
1388:     *==========================================================================
1389:     PROCEDURE GrdHeaderClick(par_nColIndex)
1390:         IF par_nColIndex != 1 OR !USED("cursor_4c_Produtos")
1391:             RETURN
1392:         ENDIF
1393:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1394:             UPDATE cursor_4c_Produtos SET lMarca = 1
1395:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1396:         ELSE
1397:             UPDATE cursor_4c_Produtos SET lMarca = 0
1398:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1399:         ENDIF
1400:         THIS.grd_4c_Dados.Refresh()
1401:         THIS.Refresh()
1402:     ENDPROC
1403: 
1404:     *==========================================================================
1405:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1406:     *==========================================================================
1407:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1408:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1409:             RETURN
1410:         ENDIF
1411:         IF THIS.chk_4c_Auditado.Value != 1
1412:             RETURN
1413:         ENDIF
1414:         IF THIS.grd_4c_Dados.ActiveColumn != 2
1415:             RETURN
1416:         ENDIF
1417:         LOCAL loc_cVal
1418:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
1419:         IF !EMPTY(loc_cVal)
1420:             THIS.AtualizarLinhaGrid(loc_cVal)
1421:         ENDIF
1422:     ENDPROC
1423: 
1424:     *==========================================================================
1425:     * AtualizarLinhaGrid - Calcula preco para produto e preenche linha do grid
1426:     * Chamado no modo Auditado quando usuario digita codigo de produto
1427:     *==========================================================================
1428:     PROTECTED PROCEDURE AtualizarLinhaGrid(par_cCPros)
1429:         LOCAL loc_oBO, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1430:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
1431:         LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_oErro
1432: 
1433:         TRY
1434:             loc_oBO       = THIS.this_oBusinessObject
1435:             loc_nTipo     = THIS.opt_4c_Tipo.Value
1436:             loc_nVariacao = THIS.txt_4c_Variacao.Value
1437:             loc_nMarkUp2  = THIS.txt_4c_MarkUp2.Value
1438: 
1439:             *-- Buscar produto no banco
1440:             IF USED("cursor_4c_BuscaProSingle")
1441:                 USE IN cursor_4c_BuscaProSingle
1442:             ENDIF
1443:             IF SQLEXEC(gnConnHandle, ;
1444:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1445:                 "cursor_4c_BuscaProSingle") >= 1 ;
1446:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1447: 
1448:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1449:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1450:                     SELECT cursor_4c_BuscaProSingle
1451:                     GO TOP
1452:                     SCATTER MEMVAR MEMO
1453:                     SELECT cursor_4c_TmpPro
1454:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1455:                     INDEX ON CPros TAG CPros
1456:                 ENDIF
1457: 
1458:                 *-- Posicionar TmpPro no produto e calcular preco
1459:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1460:                 SELECT cursor_4c_TmpPro
1461: 
1462:             *-- Calcular novo preco
1463:             DO CASE
1464:             CASE loc_nTipo = 1
1465:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1466:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1467:             CASE loc_nTipo = 2
1468:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)

*-- Linhas 1484 a 2177:
1484:             loc_nFCustos = IIF(THIS.txt_4c_Fator.Value > 0 AND !EMPTY(loc_cMoePcs), ;
1485:                 THIS.txt_4c_Fator.Value, cursor_4c_TmpPro.fCustos)
1486:             loc_nCustoFs = cursor_4c_TmpPro.CustoFs
1487: 
1488:             *-- Atualizar linha corrente no grid
1489:             SELECT cursor_4c_Produtos
1490:             REPLACE lMarca   WITH 1,                              ;
1491:                     CPros    WITH par_cCPros,                     ;
1492:                     DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
1493:                     ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
1494:                     ValAtu   WITH loc_nValAtu,                     ;
1495:                     fCustos  WITH loc_nFCustos,                   ;
1496:                     MoePcs   WITH loc_cMoePcs,                    ;
1497:                     CustoFs  WITH loc_nCustoFs,                   ;
1498:                     Manual   WITH 0
1499: 
1500:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1501:             THIS.cmg_4c_Botoes.Refresh()
1502: 
1503:             *-- Adicionar linha vazia para o proximo produto
1504:             SELECT cursor_4c_Produtos
1505:             SET ORDER TO
1506:             GO BOTTOM
1507:             IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1508:                 INSERT INTO cursor_4c_Produtos ;
1509:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1510:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1511:             ENDIF
1512:             SELECT cursor_4c_Produtos
1513:             THIS.grd_4c_Dados.Refresh()
1514:             KEYBOARD "{DNARROW}"
1515: 
1516:                     IF USED("cursor_4c_BuscaProSingle")
1517:                         USE IN cursor_4c_BuscaProSingle
1518:                     ENDIF
1519:                 ELSE
1520:                     IF USED("cursor_4c_BuscaProSingle")
1521:                         USE IN cursor_4c_BuscaProSingle
1522:                     ENDIF
1523:                 ENDIF
1524:             ELSE
1525:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1526:                 IF USED("cursor_4c_BuscaProSingle")
1527:                     USE IN cursor_4c_BuscaProSingle
1528:                 ENDIF
1529:             ENDIF
1530:         CATCH TO loc_oErro
1531:             IF USED("cursor_4c_BuscaProSingle")
1532:                 USE IN cursor_4c_BuscaProSingle
1533:             ENDIF
1534:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1535:                     " PROC=" + loc_oErro.Procedure, "Erro AtualizarLinhaGrid")
1536:         ENDTRY
1537:     ENDPROC
1538: 
1539:     *==========================================================================
1540:     * Lookup handlers - Grupo
1541:     *==========================================================================
1542:     PROCEDURE TxtGrupoIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1543:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1544:             RETURN
1545:         ENDIF
1546:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoIni, THIS.txt_4c_GrupoFim)
1547:     ENDPROC
1548: 
1549:     PROCEDURE TxtGrupoFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1550:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1551:             RETURN
1552:         ENDIF
1553:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoFim, .NULL.)
1554:     ENDPROC
1555: 
1556:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_oTxtAlvo, par_oTxtFim)
1557:         LOCAL loc_cVal, loc_oBA, loc_oErro
1558:         loc_cVal = ALLTRIM(par_oTxtAlvo.Value)
1559:         IF !EMPTY(loc_cVal)
1560:             IF USED("cursor_4c_BuscaGrp")
1561:                 USE IN cursor_4c_BuscaGrp
1562:             ENDIF
1563:             IF SQLEXEC(gnConnHandle, ;
1564:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1565:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1566:                 SELECT cursor_4c_BuscaGrp
1567:                 GO TOP
1568:                 IF !EOF("cursor_4c_BuscaGrp")
1569:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1570:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1571:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1572:                     ENDIF
1573:                     USE IN cursor_4c_BuscaGrp
1574:                     RETURN
1575:                 ENDIF
1576:                 USE IN cursor_4c_BuscaGrp
1577:             ENDIF
1578:         ENDIF
1579:         TRY
1580:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1581:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1582:                 "Grupos de Produto", .T., .T., "")
1583:             IF VARTYPE(loc_oBA) = "O"
1584:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1585:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1586:                 loc_oBA.Show()
1587:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1588:                     SELECT cursor_4c_BuscaGrp
1589:                     GO TOP
1590:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1591:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1592:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1593:                     ENDIF
1594:                 ELSE
1595:                     par_oTxtAlvo.Value = ""
1596:                 ENDIF
1597:                 IF USED("cursor_4c_BuscaGrp")
1598:                     USE IN cursor_4c_BuscaGrp
1599:                 ENDIF
1600:             ENDIF
1601:         CATCH TO loc_oErro
1602:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1603:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")
1604:         ENDTRY
1605:     ENDPROC
1606: 
1607:     *==========================================================================
1608:     * Lookup Colecao
1609:     *==========================================================================
1610:     PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1611:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1612:             RETURN
1613:         ENDIF
1614:         LOCAL loc_cVal, loc_oBA, loc_oErro
1615:         loc_cVal = ALLTRIM(THIS.txt_4c_Colecao.Value)
1616:         IF !EMPTY(loc_cVal)
1617:             IF USED("cursor_4c_BuscaCol")
1618:                 USE IN cursor_4c_BuscaCol
1619:             ENDIF
1620:             IF SQLEXEC(gnConnHandle, ;
1621:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1622:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1623:                 SELECT cursor_4c_BuscaCol
1624:                 GO TOP
1625:                 IF !EOF("cursor_4c_BuscaCol")
1626:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1627:                     USE IN cursor_4c_BuscaCol
1628:                     RETURN
1629:                 ENDIF
1630:                 USE IN cursor_4c_BuscaCol
1631:             ENDIF
1632:         ENDIF
1633:         TRY
1634:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1635:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1636:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1637:             IF VARTYPE(loc_oBA) = "O"
1638:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1639:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1640:                 loc_oBA.Show()
1641:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1642:                     SELECT cursor_4c_BuscaCol
1643:                     GO TOP
1644:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1645:                 ELSE
1646:                     THIS.txt_4c_Colecao.Value = ""
1647:                 ENDIF
1648:                 IF USED("cursor_4c_BuscaCol")
1649:                     USE IN cursor_4c_BuscaCol
1650:                 ENDIF
1651:             ENDIF
1652:         CATCH TO loc_oErro
1653:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1654:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1655:         ENDTRY
1656:     ENDPROC
1657: 
1658:     *==========================================================================
1659:     * Lookup Fornecedor por codigo
1660:     *==========================================================================
1661:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1662:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1663:             RETURN
1664:         ENDIF
1665:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1666:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1667:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1668:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1669: 
1670:         IF !EMPTY(loc_cVal)
1671:             IF USED("cursor_4c_BuscaConta")
1672:                 USE IN cursor_4c_BuscaConta
1673:             ENDIF
1674:             IF SQLEXEC(gnConnHandle, ;
1675:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1676:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1677:                 SELECT cursor_4c_BuscaConta
1678:                 GO TOP
1679:                 IF !EOF("cursor_4c_BuscaConta")
1680:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1681:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1682:                     USE IN cursor_4c_BuscaConta
1683:                     RETURN
1684:                 ENDIF
1685:                 USE IN cursor_4c_BuscaConta
1686:             ENDIF
1687:         ENDIF
1688:         TRY
1689:             LOCAL loc_cFiltroBA
1690:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1691:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1692:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1693:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1694:             IF VARTYPE(loc_oBA) = "O"
1695:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1696:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1697:                 loc_oBA.Show()
1698:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1699:                     SELECT cursor_4c_BuscaConta
1700:                     GO TOP
1701:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1702:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1703:                 ELSE
1704:                     THIS.txt_4c_Conta.Value  = ""
1705:                     THIS.txt_4c_DConta.Value = ""
1706:                 ENDIF
1707:                 IF USED("cursor_4c_BuscaConta")
1708:                     USE IN cursor_4c_BuscaConta
1709:                 ENDIF
1710:             ENDIF
1711:         CATCH TO loc_oErro
1712:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1713:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1714:         ENDTRY
1715:     ENDPROC
1716: 
1717:     *==========================================================================
1718:     * Lookup Fornecedor por nome (somente quando Conta vazio)
1719:     *==========================================================================
1720:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1721:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1722:             RETURN
1723:         ENDIF
1724:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1725:             RETURN
1726:         ENDIF
1727:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1728:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1729:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1730:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1731: 
1732:         IF !EMPTY(loc_cVal)
1733:             IF USED("cursor_4c_BuscaConta")
1734:                 USE IN cursor_4c_BuscaConta
1735:             ENDIF
1736:             IF SQLEXEC(gnConnHandle, ;
1737:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1738:                 EscaparSQL(loc_cVal + "%") + ;
1739:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1740:                 "cursor_4c_BuscaConta") > 0
1741:                 SELECT cursor_4c_BuscaConta
1742:                 GO TOP
1743:                 IF !EOF("cursor_4c_BuscaConta")
1744:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1745:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1746:                     USE IN cursor_4c_BuscaConta
1747:                     RETURN
1748:                 ENDIF
1749:                 USE IN cursor_4c_BuscaConta
1750:             ENDIF
1751:         ENDIF
1752:         TRY
1753:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1754:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1755:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1756:             IF VARTYPE(loc_oBA) = "O"
1757:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1758:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1759:                 loc_oBA.Show()
1760:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1761:                     SELECT cursor_4c_BuscaConta
1762:                     GO TOP
1763:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1764:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1765:                 ELSE
1766:                     THIS.txt_4c_DConta.Value = ""
1767:                 ENDIF
1768:                 IF USED("cursor_4c_BuscaConta")
1769:                     USE IN cursor_4c_BuscaConta
1770:                 ENDIF
1771:             ENDIF
1772:         CATCH TO loc_oErro
1773:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1774:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1775:         ENDTRY
1776:     ENDPROC
1777: 
1778:     *==========================================================================
1779:     * Lookup Promocao
1780:     *==========================================================================
1781:     PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1782:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1783:             RETURN
1784:         ENDIF
1785:         LOCAL loc_cVal, loc_oBA, loc_oErro
1786:         loc_cVal = ALLTRIM(THIS.txt_4c_Promo.Value)
1787:         IF !EMPTY(loc_cVal)
1788:             IF USED("cursor_4c_BuscaPromo")
1789:                 USE IN cursor_4c_BuscaPromo
1790:             ENDIF
1791:             IF SQLEXEC(gnConnHandle, ;
1792:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1793:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1794:                 SELECT cursor_4c_BuscaPromo
1795:                 GO TOP
1796:                 IF !EOF("cursor_4c_BuscaPromo")
1797:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1798:                     USE IN cursor_4c_BuscaPromo
1799:                     RETURN
1800:                 ENDIF
1801:                 USE IN cursor_4c_BuscaPromo
1802:             ENDIF
1803:         ENDIF
1804:         TRY
1805:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1806:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1807:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1808:             IF VARTYPE(loc_oBA) = "O"
1809:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1810:                 loc_oBA.Show()
1811:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1812:                     SELECT cursor_4c_BuscaPromo
1813:                     GO TOP
1814:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1815:                 ELSE
1816:                     THIS.txt_4c_Promo.Value = ""
1817:                 ENDIF
1818:                 IF USED("cursor_4c_BuscaPromo")
1819:                     USE IN cursor_4c_BuscaPromo
1820:                 ENDIF
1821:             ENDIF
1822:         CATCH TO loc_oErro
1823:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1824:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1825:         ENDTRY
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * Lookup generico de Moeda (reutilizado por varios campos)
1830:     *==========================================================================
1831:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_oTxt)
1832:         LOCAL loc_cVal, loc_oBA, loc_oErro
1833:         loc_cVal = ALLTRIM(par_oTxt.Value)
1834:         IF !EMPTY(loc_cVal)
1835:             IF USED("cursor_4c_BuscaMoe")
1836:                 USE IN cursor_4c_BuscaMoe
1837:             ENDIF
1838:             IF SQLEXEC(gnConnHandle, ;
1839:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1840:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1841:                 SELECT cursor_4c_BuscaMoe
1842:                 GO TOP
1843:                 IF !EOF("cursor_4c_BuscaMoe")
1844:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1845:                     USE IN cursor_4c_BuscaMoe
1846:                     RETURN
1847:                 ENDIF
1848:                 USE IN cursor_4c_BuscaMoe
1849:             ENDIF
1850:         ENDIF
1851:         TRY
1852:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1853:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1854:             IF VARTYPE(loc_oBA) = "O"
1855:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1856:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1857:                 loc_oBA.Show()
1858:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1859:                     SELECT cursor_4c_BuscaMoe
1860:                     GO TOP
1861:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1862:                 ELSE
1863:                     par_oTxt.Value = ""
1864:                 ENDIF
1865:                 IF USED("cursor_4c_BuscaMoe")
1866:                     USE IN cursor_4c_BuscaMoe
1867:                 ENDIF
1868:             ENDIF
1869:         CATCH TO loc_oErro
1870:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1871:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1872:         ENDTRY
1873:     ENDPROC
1874: 
1875:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1876:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1877:             RETURN
1878:         ENDIF
1879:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moeda)
1880:     ENDPROC
1881: 
1882:     PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1883:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1884:             RETURN
1885:         ENDIF
1886:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCs)
1887:     ENDPROC
1888: 
1889:     PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1890:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1891:             RETURN
1892:         ENDIF
1893:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusFs)
1894:     ENDPROC
1895: 
1896:     PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1897:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1898:             RETURN
1899:         ENDIF
1900:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moedas)
1901:     ENDPROC
1902: 
1903:     PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1904:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1905:             RETURN
1906:         ENDIF
1907:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeVs)
1908:     ENDPROC
1909: 
1910:     PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1911:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1912:             RETURN
1913:         ENDIF
1914:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusto)
1915:     ENDPROC
1916: 
1917:     *==========================================================================
1918:     * Lookup Feitio
1919:     *==========================================================================
1920:     PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1921:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1922:             RETURN
1923:         ENDIF
1924:         LOCAL loc_cVal, loc_oBA, loc_oErro
1925:         loc_cVal = ALLTRIM(THIS.txt_4c_CFtios.Value)
1926:         IF !EMPTY(loc_cVal)
1927:             IF USED("cursor_4c_BuscaFtio")
1928:                 USE IN cursor_4c_BuscaFtio
1929:             ENDIF
1930:             IF SQLEXEC(gnConnHandle, ;
1931:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1932:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1933:                 SELECT cursor_4c_BuscaFtio
1934:                 GO TOP
1935:                 IF !EOF("cursor_4c_BuscaFtio")
1936:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1937:                     USE IN cursor_4c_BuscaFtio
1938:                     RETURN
1939:                 ENDIF
1940:                 USE IN cursor_4c_BuscaFtio
1941:             ENDIF
1942:         ENDIF
1943:         TRY
1944:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1945:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1946:             IF VARTYPE(loc_oBA) = "O"
1947:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1948:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1949:                 loc_oBA.Show()
1950:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1951:                     SELECT cursor_4c_BuscaFtio
1952:                     GO TOP
1953:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1954:                 ELSE
1955:                     THIS.txt_4c_CFtios.Value = ""
1956:                 ENDIF
1957:                 IF USED("cursor_4c_BuscaFtio")
1958:                     USE IN cursor_4c_BuscaFtio
1959:                 ENDIF
1960:             ENDIF
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1963:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1964:         ENDTRY
1965:     ENDPROC
1966: 
1967:     *==========================================================================
1968:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1969:     *==========================================================================
1970:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1971:         LOCAL loc_i, loc_oControl
1972:         IF VARTYPE(par_oContainer) # "O"
1973:             RETURN
1974:         ENDIF
1975:         FOR loc_i = 1 TO par_oContainer.ControlCount
1976:             loc_oControl = par_oContainer.Controls(loc_i)
1977:             loc_oControl.Visible = .T.
1978:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1979:                 THIS.TornarControlesVisiveis(loc_oControl)
1980:             ENDIF
1981:         ENDFOR
1982:     ENDPROC
1983: 
1984:     *==========================================================================
1985:     * ConfigurarPaginaLista - Form OPERACIONAL: consolida cabecalho, botoes,
1986:     * filtros e grade num unico layout (equivalente da "Page1 - Lista" dos CRUD)
1987:     *==========================================================================
1988:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1989:         LOCAL loc_lJaConfigurado
1990: 
1991:         loc_lJaConfigurado = PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5) ;
1992:                          AND PEMSTATUS(THIS, "cmg_4c_Botoes", 5) ;
1993:                          AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1994: 
1995:         IF !loc_lJaConfigurado
1996:             THIS.ConfigurarCabecalho()
1997:             THIS.ConfigurarBotoes()
1998:             THIS.ConfigurarFiltros()
1999:             THIS.ConfigurarGrade()
2000:         ENDIF
2001: 
2002:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
2003:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
2004:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
2005:         ENDIF
2006: 
2007:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2008:             SELECT cursor_4c_Produtos
2009:             GO TOP
2010:             THIS.grd_4c_Dados.Refresh()
2011:         ENDIF
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2016:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2017:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2018:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2019:     *==========================================================================
2020:     PROCEDURE AlternarPagina(par_nPagina)
2021:         LOCAL loc_nPagina
2022: 
2023:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2024: 
2025:         DO CASE
2026:         CASE loc_nPagina = 1
2027:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2028:                 THIS.txt_4c_GrupoIni.SetFocus()
2029:             ENDIF
2030:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2031:                 SELECT cursor_4c_Produtos
2032:                 GO TOP
2033:                 THIS.grd_4c_Dados.Refresh()
2034:             ENDIF
2035:         CASE loc_nPagina = 2
2036:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2037:                 THIS.grd_4c_Dados.SetFocus()
2038:             ENDIF
2039:         ENDCASE
2040: 
2041:         RETURN .T.
2042:     ENDPROC
2043: 
2044:     *==========================================================================
2045:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2046:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.
2047:     *==========================================================================
2048:     PROCEDURE CarregarLista()
2049:         LOCAL loc_lSucesso, loc_oErro
2050:         loc_lSucesso = .F.
2051: 
2052:         TRY
2053:             SET NULL ON
2054:             IF USED("cursor_4c_Produtos")
2055:                 IF TABLEREVERT(.T., "cursor_4c_Produtos")
2056:                 ENDIF
2057:                 USE IN cursor_4c_Produtos
2058:             ENDIF
2059: 
2060:             CREATE CURSOR cursor_4c_Produtos ( ;
2061:                 lMarca  N(1) NULL, ;
2062:                 CPros   C(14) NULL, ;
2063:                 DPros   C(40) NULL, ;
2064:                 ValAnt  N(14,4) NULL, ;
2065:                 ValAtu  N(14,4) NULL, ;
2066:                 fCustos N(9,4) NULL, ;
2067:                 MoePcs  C(3) NULL, ;
2068:                 CustoFs N(14,4) NULL, ;
2069:                 Manual  N(1) NULL)
2070:             INDEX ON CPros TAG CPros
2071:             SET NULL OFF
2072: 
2073:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2074:                 THIS.grd_4c_Dados.ColumnCount = 5
2075:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2076:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
2077:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
2078:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
2079:                 THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
2080:                 THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
2081:                 THIS.grd_4c_Dados.Refresh()
2082:             ENDIF
2083: 
2084:             THIS.AjustarBotoesPorModo()
2085: 
2086:             loc_lSucesso = .T.
2087:         CATCH TO loc_oErro
2088:             SET NULL OFF
2089:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2090:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2091:         ENDTRY
2092: 
2093:         RETURN loc_lSucesso
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * LimparCampos - Reseta todos os campos de filtro e esvazia o grid
2098:     *==========================================================================
2099:     PROCEDURE LimparCampos()
2100:         THIS.txt_4c_GrupoIni.Value  = ""
2101:         THIS.txt_4c_GrupoFim.Value  = ""
2102:         THIS.txt_4c_Colecao.Value   = ""
2103:         THIS.txt_4c_Conta.Value     = ""
2104:         THIS.txt_4c_DConta.Value    = ""
2105:         THIS.txt_4c_Promo.Value     = ""
2106:         THIS.txt_4c_Variacao.Value  = 0
2107:         THIS.txt_4c_Moeda.Value     = ""
2108:         THIS.txt_4c_MarkUp1.Value   = 0
2109:         THIS.txt_4c_MarkUp2.Value   = 0
2110:         THIS.txt_4c_Fator.Value     = 0
2111:         THIS.txt_4c_MoeCusto.Value  = ""
2112:         THIS.txt_4c_MoeCs.Value     = ""
2113:         THIS.txt_4c_MoeCusFs.Value  = ""
2114:         THIS.txt_4c_Moedas.Value    = ""
2115:         THIS.txt_4c_CFtios.Value    = ""
2116:         THIS.txt_4c_MoeVs.Value     = ""
2117:         THIS.chk_4c_IncCusts.Value  = 0
2118:         THIS.chk_4c_Limpar.Value    = 0
2119:         THIS.chk_4c_Ignorar.Value   = 0
2120:         THIS.chk_4c_Auditado.Value  = 0
2121: 
2122:         THIS.opt_4c_Tipo.Value = 1
2123:         THIS.OptTipoChange()
2124: 
2125:         IF PEMSTATUS(THIS, "img_4c_Foto", 5)
2126:             THIS.img_4c_Foto.Visible = .F.
2127:             THIS.img_4c_Foto.Picture = ""
2128:         ENDIF
2129: 
2130:         THIS.CarregarLista()
2131: 
2132:         THIS.txt_4c_GrupoIni.SetFocus()
2133:     ENDPROC
2134: 
2135:     *==========================================================================
2136:     * HabilitarCampos - Habilita ou desabilita campos de filtro
2137:     * par_lHabilitar: .T. = habilitar filtros (estado inicial / pos-Atualizar)
2138:     *                 .F. = desabilitar filtros (durante modo Auditado)
2139:     *==========================================================================
2140:     PROCEDURE HabilitarCampos(par_lHabilitar)
2141:         LOCAL loc_lHab
2142:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2143: 
2144:         THIS.txt_4c_GrupoIni.Enabled = loc_lHab
2145:         THIS.txt_4c_GrupoFim.Enabled = loc_lHab
2146:         THIS.txt_4c_Colecao.Enabled  = loc_lHab
2147:         THIS.txt_4c_Moeda.Enabled    = loc_lHab
2148:         THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
2149:         THIS.opt_4c_Tipo.Enabled     = loc_lHab
2150: 
2151:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2152:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
2153:         ENDIF
2154: 
2155:         THIS.Refresh()
2156:     ENDPROC
2157: 
2158:     *==========================================================================
2159:     * AjustarBotoesPorModo - Controla estados dos botoes baseado no grid
2160:     * Processar: sempre habilitado (a menos que em modo Auditado)
2161:     * Atualizar: habilitado somente quando ha produtos processados no grid
2162:     *==========================================================================
2163:     PROCEDURE AjustarBotoesPorModo()
2164:         LOCAL loc_lTemProdutos, loc_lModoAuditado
2165: 
2166:         loc_lTemProdutos  = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2167:         loc_lModoAuditado = PEMSTATUS(THIS, "chk_4c_Auditado", 5) ;
2168:                         AND THIS.chk_4c_Auditado.Value = 1
2169: 
2170:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2171:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = !loc_lModoAuditado
2172:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lTemProdutos
2173:             THIS.cmg_4c_Botoes.Refresh()
2174:         ENDIF
2175:     ENDPROC
2176: 
2177: ENDDEFINE

