# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2175 linhas total):

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

*-- Linhas 765 a 808:
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
786:             *-- Coluna 1: CheckBox de selecao
787:             WITH .Column1
788:                 .Width      = 25
789:                 .Movable    = .F.
790:                 .Resizable  = .F.
791:                 .Sparse     = .F.
792:                 .AddObject("Check1", "CheckBox")
793:                 .Check1.Caption = ""
794:                 .Check1.Value   = 0
795:                 .CurrentControl = "Check1"
796:                 .ControlSource  = "cursor_4c_Produtos.lMarca"
797:                 WITH .Header1
798:                     .Caption = ""
799:                     .Tag     = "1"
800:                 ENDWITH
801:             ENDWITH
802: 
803:             *-- Coluna 2: Codigo do produto
804:             WITH .Column2
805:                 .Width         = 110
806:                 .Movable       = .F.
807:                 .Resizable     = .F.
808:                 .ReadOnly      = .T.

*-- Linhas 874 a 1224:
874:     ENDPROC
875: 
876:     *==========================================================================
877:     PROCEDURE Destroy()
878:     *==========================================================================
879:         LOCAL loc_aCursors(16), loc_i
880:         loc_aCursors(1)  = "cursor_4c_Produtos"
881:         loc_aCursors(2)  = "cursor_4c_TmpPro"
882:         loc_aCursors(3)  = "cursor_4c_SigCdGrp"
883:         loc_aCursors(4)  = "cursor_4c_TmpProSQL"
884:         loc_aCursors(5)  = "cursor_4c_FigTemp"
885:         loc_aCursors(6)  = "cursor_4c_BuscaPro"
886:         loc_aCursors(7)  = "cursor_4c_BuscaProSingle"
887:         loc_aCursors(8)  = "cursor_4c_BuscaMoe"
888:         loc_aCursors(9)  = "cursor_4c_BuscaGrp"
889:         loc_aCursors(10) = "cursor_4c_BuscaCol"
890:         loc_aCursors(11) = "cursor_4c_BuscaConta"
891:         loc_aCursors(12) = "cursor_4c_BuscaPromo"
892:         loc_aCursors(13) = "cursor_4c_BuscaFtio"
893:         loc_aCursors(14) = "cursor_4c_Selecionados"
894:         loc_aCursors(15) = "cursor_4c_SigCdPam"
895:         loc_aCursors(16) = "cursor_4c_SigCdPac"
896:         FOR loc_i = 1 TO 16
897:             IF USED(loc_aCursors(loc_i))
898:                 USE IN (loc_aCursors(loc_i))
899:             ENDIF
900:         NEXT
901:         DODEFAULT()
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * Transferencia Form <-> BO
906:     *==========================================================================
907:     PROCEDURE FormParaBO()
908:         WITH THIS.this_oBusinessObject
909:             .this_nTipo        = THIS.opt_4c_Tipo.Value
910:             .this_cGrupoInicio = ALLTRIM(THIS.txt_4c_GrupoIni.Value)
911:             .this_cGrupoFim    = ALLTRIM(THIS.txt_4c_GrupoFim.Value)
912:             .this_cColecao     = ALLTRIM(THIS.txt_4c_Colecao.Value)
913:             .this_cConta       = ALLTRIM(THIS.txt_4c_Conta.Value)
914:             .this_cDConta      = ALLTRIM(THIS.txt_4c_DConta.Value)
915:             .this_cPromo       = ALLTRIM(THIS.txt_4c_Promo.Value)
916:             .this_nVariacao    = THIS.txt_4c_Variacao.Value
917:             .this_cMoeda       = ALLTRIM(THIS.txt_4c_Moeda.Value)
918:             .this_nMarkUp1     = THIS.txt_4c_MarkUp1.Value
919:             .this_nMarkUp2     = THIS.txt_4c_MarkUp2.Value
920:             .this_nFator       = THIS.txt_4c_Fator.Value
921:             .this_cMoeCusto    = ALLTRIM(THIS.txt_4c_MoeCusto.Value)
922:             .this_cMoeCs       = ALLTRIM(THIS.txt_4c_MoeCs.Value)
923:             .this_cMoeCusFs    = ALLTRIM(THIS.txt_4c_MoeCusFs.Value)
924:             .this_cMoedas      = ALLTRIM(THIS.txt_4c_Moedas.Value)
925:             .this_cCFtios      = ALLTRIM(THIS.txt_4c_CFtios.Value)
926:             .this_cMoeVs       = ALLTRIM(THIS.txt_4c_MoeVs.Value)
927:             .this_nAuditado    = THIS.chk_4c_Auditado.Value
928:             .this_nLimpar      = THIS.chk_4c_Limpar.Value
929:             .this_nIncCusts    = THIS.chk_4c_IncCusts.Value
930:             .this_nIgnorar     = THIS.chk_4c_Ignorar.Value
931:         ENDWITH
932:     ENDPROC
933: 
934:     PROCEDURE BOParaForm()
935:         WITH THIS.this_oBusinessObject
936:             THIS.opt_4c_Tipo.Value     = .this_nTipo
937:             THIS.txt_4c_GrupoIni.Value = .this_cGrupoInicio
938:             THIS.txt_4c_GrupoFim.Value = .this_cGrupoFim
939:             THIS.txt_4c_Colecao.Value  = .this_cColecao
940:             THIS.txt_4c_Conta.Value    = .this_cConta
941:             THIS.txt_4c_DConta.Value   = .this_cDConta
942:             THIS.txt_4c_Promo.Value    = .this_cPromo
943:             THIS.txt_4c_Variacao.Value = .this_nVariacao
944:             THIS.txt_4c_Moeda.Value    = .this_cMoeda
945:             THIS.txt_4c_MarkUp1.Value  = .this_nMarkUp1
946:             THIS.txt_4c_MarkUp2.Value  = .this_nMarkUp2
947:             THIS.txt_4c_Fator.Value    = .this_nFator
948:             THIS.txt_4c_MoeCusto.Value = .this_cMoeCusto
949:             THIS.txt_4c_MoeCs.Value    = .this_cMoeCs
950:             THIS.txt_4c_MoeCusFs.Value = .this_cMoeCusFs
951:             THIS.txt_4c_Moedas.Value   = .this_cMoedas
952:             THIS.txt_4c_CFtios.Value   = .this_cCFtios
953:             THIS.txt_4c_MoeVs.Value    = .this_cMoeVs
954:         ENDWITH
955:     ENDPROC
956: 
957:     *==========================================================================
958:     * BtnProcessarClick - Calcula novos precos e preenche o grid
959:     *==========================================================================
960:     PROCEDURE BtnProcessarClick()
961:         LOCAL loc_lSucesso, loc_oErro
962:         loc_lSucesso = .F.
963: 
964:         TRY
965:             THIS.FormParaBO()
966:             loc_lSucesso = THIS.this_oBusinessObject.ProcessarReajuste()
967:             IF loc_lSucesso
968:                 THIS.grd_4c_Dados.ColumnCount = 3
969:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
970:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
971:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
972:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
973:                 THIS.grd_4c_Dados.Refresh()
974:                 THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
975:                 THIS.cmg_4c_Botoes.Refresh()
976:                 THIS.grd_4c_Dados.Column1.SetFocus()
977:             ENDIF
978:         CATCH TO loc_oErro
979:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
980:                     " PROC=" + loc_oErro.Procedure, "Erro BtnProcessarClick")
981:         ENDTRY
982:     ENDPROC
983: 
984:     *==========================================================================
985:     * BtnAtualizarClick - Grava alteracoes no banco de dados
986:     *==========================================================================
987:     PROCEDURE BtnAtualizarClick()
988:         LOCAL loc_llImpEtiq, loc_lSucesso, loc_oErro
989:         loc_lSucesso = .F.
990: 
991:         TRY
992:             IF MsgConfirma("Atualiza" + CHR(63), ;
993:                 "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
994: 
995:                 THIS.FormParaBO()
996: 
997:                 loc_llImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?", "")
998: 
999:                 loc_lSucesso = THIS.this_oBusinessObject.AtualizarPrecos(loc_llImpEtiq)
1000: 
1001:                 IF loc_lSucesso
1002:                     THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
1003:                     THIS.cmg_4c_Botoes.Refresh()
1004:                 ENDIF
1005:             ENDIF
1006:         CATCH TO loc_oErro
1007:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1008:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAtualizarClick")
1009:         ENDTRY
1010:     ENDPROC
1011: 
1012:     *==========================================================================
1013:     PROCEDURE BtnEncerrarClick()
1014:     *==========================================================================
1015:         THIS.Release()
1016:     ENDPROC
1017: 
1018:     *==========================================================================
1019:     * BtnSalvarClick - Persiste as alteracoes de preco no banco
1020:     * Form OPERACIONAL: delega para BtnAtualizarClick (equivalente ao "sair.Processa")
1021:     *==========================================================================
1022:     PROCEDURE BtnSalvarClick()
1023:         THIS.BtnAtualizarClick()
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * BtnCancelarClick - Descarta o pre-processamento e reinicia os filtros
1028:     * Form OPERACIONAL: limpa cursor de produtos, filtros e ajusta botoes
1029:     *==========================================================================
1030:     PROCEDURE BtnCancelarClick()
1031:         LOCAL loc_oErro
1032: 
1033:         TRY
1034:             THIS.LimparCampos()
1035:         CATCH TO loc_oErro
1036:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1037:                     " PROC=" + loc_oErro.Procedure, "Erro BtnCancelarClick")
1038:         ENDTRY
1039:     ENDPROC
1040: 
1041:     *==========================================================================
1042:     * BtnIncluirClick - Adiciona linha vazia ao grid para entrada manual
1043:     * (equivalente ao modo Auditado do legado - permite user digitar produto)
1044:     *==========================================================================
1045:     PROCEDURE BtnIncluirClick()
1046:         LOCAL loc_oErro
1047: 
1048:         TRY
1049:             IF !USED("cursor_4c_Produtos")
1050:                 SET NULL ON
1051:                 CREATE CURSOR cursor_4c_Produtos ( ;
1052:                     lMarca  N(1) NULL, ;
1053:                     CPros   C(14) NULL, ;
1054:                     DPros   C(40) NULL, ;
1055:                     ValAnt  N(14,4) NULL, ;
1056:                     ValAtu  N(14,4) NULL, ;
1057:                     fCustos N(9,4) NULL, ;
1058:                     MoePcs  C(3) NULL, ;
1059:                     CustoFs N(14,4) NULL, ;
1060:                     Manual  N(1) NULL)
1061:                 INDEX ON CPros TAG CPros
1062:                 SET NULL OFF
1063:             ENDIF
1064: 
1065:             INSERT INTO cursor_4c_Produtos ;
1066:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1067:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1068: 
1069:             SELECT cursor_4c_Produtos
1070:             SET ORDER TO
1071:             GO BOTTOM
1072: 
1073:             THIS.grd_4c_Dados.ColumnCount = 3
1074:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1075:             THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
1076:             THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
1077:             THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
1078:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1079:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1080:             THIS.grd_4c_Dados.Refresh()
1081:             THIS.grd_4c_Dados.SetFocus()
1082:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1083:         CATCH TO loc_oErro
1084:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1085:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1086:         ENDTRY
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1091:     * Delega para BtnProcessarClick que executa o processamento principal
1092:     *==========================================================================
1093:     PROCEDURE BtnAlterarClick()
1094:         LOCAL loc_oErro
1095: 
1096:         TRY
1097:             THIS.BtnProcessarClick()
1098:         CATCH TO loc_oErro
1099:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1100:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
1101:         ENDTRY
1102:     ENDPROC
1103: 
1104:     *==========================================================================
1105:     * BtnVisualizarClick - Exibe foto e detalhes do produto selecionado
1106:     * Refresca a linha atual do grid disparando a mesma logica de AfterRowColChange
1107:     *==========================================================================
1108:     PROCEDURE BtnVisualizarClick()
1109:         LOCAL loc_oErro
1110: 
1111:         TRY
1112:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1113:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1114:                         "Visualizar")
1115:             ELSE
1116:                 SELECT cursor_4c_Produtos
1117:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1118:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1119:                             "Visualizar")
1120:                 ELSE
1121:                     THIS.GrdAfterRowColChange(2)
1122:                     THIS.grd_4c_Dados.Refresh()
1123:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1124:                         THIS.img_4c_Foto.Refresh()
1125:                     ENDIF
1126:                 ENDIF
1127:             ENDIF
1128:         CATCH TO loc_oErro
1129:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1130:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1131:         ENDTRY
1132:     ENDPROC
1133: 
1134:     *==========================================================================
1135:     * BtnExcluirClick - Remove produtos marcados/selecionados do grid
1136:     * (nao exclui do banco - apenas remove do cursor de pre-processamento)
1137:     *==========================================================================
1138:     PROCEDURE BtnExcluirClick()
1139:         LOCAL loc_nRemovidos, loc_oErro
1140:         loc_nRemovidos = 0
1141: 
1142:         TRY
1143:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1144:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1145:             ELSE
1146:                 SELECT cursor_4c_Produtos
1147:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1148: 
1149:                 IF loc_nRemovidos = 0
1150:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1151:                             "Excluir")
1152:                         IF !EOF("cursor_4c_Produtos")
1153:                             DELETE
1154:                             PACK MEMO
1155:                             loc_nRemovidos = 1
1156:                         ENDIF
1157:                     ENDIF
1158:                 ELSE
1159:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1160:                             " produto(s) marcado(s) do grid?", "Excluir")
1161:                         DELETE FOR NVL(lMarca, 0) = 1
1162:                         PACK MEMO
1163:                     ELSE
1164:                         loc_nRemovidos = 0
1165:                     ENDIF
1166:                 ENDIF
1167: 
1168:                 IF loc_nRemovidos > 0
1169:                     SELECT cursor_4c_Produtos
1170:                     GO TOP
1171:                     THIS.grd_4c_Dados.Refresh()
1172:                     THIS.Refresh()
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1177:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1178:         ENDTRY
1179:     ENDPROC
1180: 
1181:     *==========================================================================
1182:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1183:     *==========================================================================
1184:     PROCEDURE OptTipoChange()
1185:         LOCAL loc_nTipo
1186:         loc_nTipo = THIS.opt_4c_Tipo.Value
1187: 
1188:         DO CASE
1189:         CASE loc_nTipo = 1
1190:             THIS.lbl_4c_Variacao.Visible  = .T.
1191:             THIS.txt_4c_Variacao.Visible  = .T.
1192:             THIS.lbl_4c_Pct.Visible       = .T.
1193:             THIS.chk_4c_IncCusts.Visible  = .T.
1194:             THIS.lbl_4c_Moeda.Visible     = .F.
1195:             THIS.txt_4c_Moeda.Visible     = .F.
1196:             THIS.lbl_4c_MarkUp.Visible    = .F.
1197:             THIS.txt_4c_MarkUp1.Visible   = .F.
1198:             THIS.lbl_4c_Para.Visible      = .F.
1199:             THIS.txt_4c_MarkUp2.Visible   = .F.
1200:             THIS.lbl_4c_FatorCusto.Visible = .F.
1201:             THIS.txt_4c_Fator.Visible     = .F.
1202:             THIS.txt_4c_MoeCusto.Visible  = .F.
1203:             THIS.lbl_4c_Moeda1.Visible    = .F.
1204:             THIS.txt_4c_MoeCs.Visible     = .F.
1205:             THIS.lbl_4c_Moeda2.Visible    = .F.
1206:             THIS.txt_4c_MoeCusFs.Visible  = .F.
1207:             THIS.lbl_4c_Moeda4.Visible    = .F.
1208:             THIS.txt_4c_Moedas.Visible    = .F.
1209:             THIS.lbl_4c_Moeda3.Visible    = .F.
1210:             THIS.txt_4c_CFtios.Visible    = .F.
1211:             THIS.lbl_4c_Moeda5.Visible    = .F.
1212:             THIS.txt_4c_MoeVs.Visible     = .F.
1213: 
1214:         CASE loc_nTipo = 2
1215:             THIS.lbl_4c_Variacao.Visible  = .F.
1216:             THIS.txt_4c_Variacao.Visible  = .F.
1217:             THIS.lbl_4c_Pct.Visible       = .F.
1218:             THIS.chk_4c_IncCusts.Visible  = .F.
1219:             THIS.lbl_4c_Moeda.Visible     = .T.
1220:             THIS.txt_4c_Moeda.Visible     = .T.
1221:             THIS.lbl_4c_MarkUp.Visible    = .T.
1222:             THIS.txt_4c_MarkUp1.Visible   = .T.
1223:             THIS.lbl_4c_Para.Visible      = .T.
1224:             THIS.txt_4c_MarkUp2.Visible   = .T.

*-- Linhas 1268 a 1356:
1268:     *==========================================================================
1269:     * ChkAuditadoClick - Modo de edicao manual no grid
1270:     *==========================================================================
1271:     PROCEDURE ChkAuditadoClick()
1272:         IF THIS.chk_4c_Auditado.Value = 1
1273:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1274:             IF USED("cursor_4c_Produtos")
1275:                 INSERT INTO cursor_4c_Produtos ;
1276:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1277:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1278:                 SELECT cursor_4c_Produtos
1279:                 SET ORDER TO
1280:                 GO TOP
1281:             ENDIF
1282:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1283:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1284:             THIS.txt_4c_Colecao.Enabled               = .F.
1285:             THIS.txt_4c_Moeda.Enabled                 = .F.
1286:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1287:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1288:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1289:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1290:             THIS.grd_4c_Dados.Refresh()
1291:         ELSE
1292:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1293:             IF USED("cursor_4c_Produtos")
1294:                 DELETE FROM cursor_4c_Produtos
1295:                 SELECT cursor_4c_Produtos
1296:                 SET ORDER TO CPros
1297:                 GO TOP
1298:             ENDIF
1299:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1300:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1301:             THIS.txt_4c_Colecao.Enabled               = .T.
1302:             THIS.txt_4c_Moeda.Enabled                 = .T.
1303:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1304:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1305:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1306:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1307:             THIS.grd_4c_Dados.Refresh()
1308:             THIS.txt_4c_GrupoIni.SetFocus()
1309:         ENDIF
1310:         THIS.cmg_4c_Botoes.Refresh()
1311:     ENDPROC
1312: 
1313:     *==========================================================================
1314:     * GrdAfterRowColChange - foto do produto + rastrear edicao manual do preco
1315:     *==========================================================================
1316:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1317:         LOCAL loc_cArqFig, loc_cSQL, loc_cFoto, loc_oErro
1318: 
1319:         TRY
1320:             IF USED("cursor_4c_Produtos")
1321:                 SELECT cursor_4c_Produtos
1322:                 IF EOF("cursor_4c_Produtos")
1323:                     THIS.img_4c_Foto.Visible = .F.
1324:                     THIS.img_4c_Foto.Picture = ""
1325:                 ELSE
1326:                     *-- Rastrear edicao manual do preco (Column5)
1327:                     IF par_nColIndex = 5
1328:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1329:                     ELSE
1330:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1331:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1332:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1333:                         ENDIF
1334:                         THIS.this_cAntValue = ""
1335:                         ENDIF
1336:                     ENDIF
1337: 
1338:                     *-- Exibir foto do produto
1339:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1340:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1341:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1342:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1343:                         IF USED("cursor_4c_FigTemp")
1344:                             USE IN cursor_4c_FigTemp
1345:                         ENDIF
1346:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1347:                             SELECT cursor_4c_FigTemp
1348:                             THIS.img_4c_Foto.Visible = .F.
1349:                             THIS.img_4c_Foto.Picture = ""
1350:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1351:                                 CLEAR RESOURCES
1352:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1353:                                     "data:image/png;base64,", ""), ;
1354:                                     "data:image/jpeg;base64,", ""), ;
1355:                                     "data:image/jpg;base64,", ""), 14)
1356:                                 STRTOFILE(loc_cFoto, loc_cArqFig)

*-- Linhas 1374 a 1463:
1374:                 USE IN cursor_4c_FigTemp
1375:             ENDIF
1376:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1377:                     " PROC=" + loc_oErro.Procedure, "Erro GrdAfterRowColChange")
1378:         ENDTRY
1379:     ENDPROC
1380: 
1381:     *==========================================================================
1382:     * GrdHeaderClick - clicar no header da Column1 marca/desmarca todos
1383:     *==========================================================================
1384:     PROCEDURE GrdHeaderClick(par_nColIndex)
1385:         IF par_nColIndex != 1 OR !USED("cursor_4c_Produtos")
1386:             RETURN
1387:         ENDIF
1388:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1389:             UPDATE cursor_4c_Produtos SET lMarca = 1
1390:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1391:         ELSE
1392:             UPDATE cursor_4c_Produtos SET lMarca = 0
1393:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1394:         ENDIF
1395:         THIS.grd_4c_Dados.Refresh()
1396:         THIS.Refresh()
1397:     ENDPROC
1398: 
1399:     *==========================================================================
1400:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1401:     *==========================================================================
1402:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1403:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1404:             RETURN
1405:         ENDIF
1406:         IF THIS.chk_4c_Auditado.Value != 1
1407:             RETURN
1408:         ENDIF
1409:         IF THIS.grd_4c_Dados.ActiveColumn != 2
1410:             RETURN
1411:         ENDIF
1412:         LOCAL loc_cVal
1413:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
1414:         IF !EMPTY(loc_cVal)
1415:             THIS.AtualizarLinhaGrid(loc_cVal)
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * AtualizarLinhaGrid - Calcula preco para produto e preenche linha do grid
1421:     * Chamado no modo Auditado quando usuario digita codigo de produto
1422:     *==========================================================================
1423:     PROTECTED PROCEDURE AtualizarLinhaGrid(par_cCPros)
1424:         LOCAL loc_oBO, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1425:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
1426:         LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_oErro
1427: 
1428:         TRY
1429:             loc_oBO       = THIS.this_oBusinessObject
1430:             loc_nTipo     = THIS.opt_4c_Tipo.Value
1431:             loc_nVariacao = THIS.txt_4c_Variacao.Value
1432:             loc_nMarkUp2  = THIS.txt_4c_MarkUp2.Value
1433: 
1434:             *-- Buscar produto no banco
1435:             IF USED("cursor_4c_BuscaProSingle")
1436:                 USE IN cursor_4c_BuscaProSingle
1437:             ENDIF
1438:             IF SQLEXEC(gnConnHandle, ;
1439:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1440:                 "cursor_4c_BuscaProSingle") >= 1 ;
1441:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1442: 
1443:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1444:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1445:                     SELECT cursor_4c_BuscaProSingle
1446:                     GO TOP
1447:                     SCATTER MEMVAR MEMO
1448:                     SELECT cursor_4c_TmpPro
1449:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1450:                     INDEX ON CPros TAG CPros
1451:                 ENDIF
1452: 
1453:                 *-- Posicionar TmpPro no produto e calcular preco
1454:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1455:                 SELECT cursor_4c_TmpPro
1456: 
1457:             *-- Calcular novo preco
1458:             DO CASE
1459:             CASE loc_nTipo = 1
1460:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1461:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1462:             CASE loc_nTipo = 2
1463:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)

*-- Linhas 1517 a 2175:
1517:                     ENDIF
1518:                 ENDIF
1519:             ELSE
1520:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1521:                 IF USED("cursor_4c_BuscaProSingle")
1522:                     USE IN cursor_4c_BuscaProSingle
1523:                 ENDIF
1524:             ENDIF
1525:         CATCH TO loc_oErro
1526:             IF USED("cursor_4c_BuscaProSingle")
1527:                 USE IN cursor_4c_BuscaProSingle
1528:             ENDIF
1529:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1530:                     " PROC=" + loc_oErro.Procedure, "Erro AtualizarLinhaGrid")
1531:         ENDTRY
1532:     ENDPROC
1533: 
1534:     *==========================================================================
1535:     * Lookup handlers - Grupo
1536:     *==========================================================================
1537:     PROCEDURE TxtGrupoIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1538:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1539:             RETURN
1540:         ENDIF
1541:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoIni, THIS.txt_4c_GrupoFim)
1542:     ENDPROC
1543: 
1544:     PROCEDURE TxtGrupoFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1545:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1546:             RETURN
1547:         ENDIF
1548:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoFim, .NULL.)
1549:     ENDPROC
1550: 
1551:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_oTxtAlvo, par_oTxtFim)
1552:         LOCAL loc_cVal, loc_oBA, loc_oErro
1553:         loc_cVal = ALLTRIM(par_oTxtAlvo.Value)
1554:         IF !EMPTY(loc_cVal)
1555:             IF USED("cursor_4c_BuscaGrp")
1556:                 USE IN cursor_4c_BuscaGrp
1557:             ENDIF
1558:             IF SQLEXEC(gnConnHandle, ;
1559:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1560:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1561:                 SELECT cursor_4c_BuscaGrp
1562:                 GO TOP
1563:                 IF !EOF("cursor_4c_BuscaGrp")
1564:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1565:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1566:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1567:                     ENDIF
1568:                     USE IN cursor_4c_BuscaGrp
1569:                     RETURN
1570:                 ENDIF
1571:                 USE IN cursor_4c_BuscaGrp
1572:             ENDIF
1573:         ENDIF
1574:         TRY
1575:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1576:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1577:                 "Grupos de Produto", .T., .T., "")
1578:             IF VARTYPE(loc_oBA) = "O"
1579:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1580:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1581:                 loc_oBA.Show()
1582:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1583:                     SELECT cursor_4c_BuscaGrp
1584:                     GO TOP
1585:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1586:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1587:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1588:                     ENDIF
1589:                 ELSE
1590:                     par_oTxtAlvo.Value = ""
1591:                 ENDIF
1592:                 IF USED("cursor_4c_BuscaGrp")
1593:                     USE IN cursor_4c_BuscaGrp
1594:                 ENDIF
1595:             ENDIF
1596:         CATCH TO loc_oErro
1597:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1598:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")
1599:         ENDTRY
1600:     ENDPROC
1601: 
1602:     *==========================================================================
1603:     * Lookup Colecao
1604:     *==========================================================================
1605:     PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1606:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1607:             RETURN
1608:         ENDIF
1609:         LOCAL loc_cVal, loc_oBA, loc_oErro
1610:         loc_cVal = ALLTRIM(THIS.txt_4c_Colecao.Value)
1611:         IF !EMPTY(loc_cVal)
1612:             IF USED("cursor_4c_BuscaCol")
1613:                 USE IN cursor_4c_BuscaCol
1614:             ENDIF
1615:             IF SQLEXEC(gnConnHandle, ;
1616:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1617:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1618:                 SELECT cursor_4c_BuscaCol
1619:                 GO TOP
1620:                 IF !EOF("cursor_4c_BuscaCol")
1621:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1622:                     USE IN cursor_4c_BuscaCol
1623:                     RETURN
1624:                 ENDIF
1625:                 USE IN cursor_4c_BuscaCol
1626:             ENDIF
1627:         ENDIF
1628:         TRY
1629:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1630:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1631:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1632:             IF VARTYPE(loc_oBA) = "O"
1633:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1634:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1635:                 loc_oBA.Show()
1636:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1637:                     SELECT cursor_4c_BuscaCol
1638:                     GO TOP
1639:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1640:                 ELSE
1641:                     THIS.txt_4c_Colecao.Value = ""
1642:                 ENDIF
1643:                 IF USED("cursor_4c_BuscaCol")
1644:                     USE IN cursor_4c_BuscaCol
1645:                 ENDIF
1646:             ENDIF
1647:         CATCH TO loc_oErro
1648:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1649:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1650:         ENDTRY
1651:     ENDPROC
1652: 
1653:     *==========================================================================
1654:     * Lookup Fornecedor por codigo
1655:     *==========================================================================
1656:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1657:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1658:             RETURN
1659:         ENDIF
1660:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1661:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1662:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1663:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1664: 
1665:         IF !EMPTY(loc_cVal)
1666:             IF USED("cursor_4c_BuscaConta")
1667:                 USE IN cursor_4c_BuscaConta
1668:             ENDIF
1669:             IF SQLEXEC(gnConnHandle, ;
1670:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1671:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1672:                 SELECT cursor_4c_BuscaConta
1673:                 GO TOP
1674:                 IF !EOF("cursor_4c_BuscaConta")
1675:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1676:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1677:                     USE IN cursor_4c_BuscaConta
1678:                     RETURN
1679:                 ENDIF
1680:                 USE IN cursor_4c_BuscaConta
1681:             ENDIF
1682:         ENDIF
1683:         TRY
1684:             LOCAL loc_cFiltroBA
1685:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1686:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1687:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1688:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1689:             IF VARTYPE(loc_oBA) = "O"
1690:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1691:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1692:                 loc_oBA.Show()
1693:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1694:                     SELECT cursor_4c_BuscaConta
1695:                     GO TOP
1696:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1697:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1698:                 ELSE
1699:                     THIS.txt_4c_Conta.Value  = ""
1700:                     THIS.txt_4c_DConta.Value = ""
1701:                 ENDIF
1702:                 IF USED("cursor_4c_BuscaConta")
1703:                     USE IN cursor_4c_BuscaConta
1704:                 ENDIF
1705:             ENDIF
1706:         CATCH TO loc_oErro
1707:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1708:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1709:         ENDTRY
1710:     ENDPROC
1711: 
1712:     *==========================================================================
1713:     * Lookup Fornecedor por nome (somente quando Conta vazio)
1714:     *==========================================================================
1715:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1716:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1717:             RETURN
1718:         ENDIF
1719:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1720:             RETURN
1721:         ENDIF
1722:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1723:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1724:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1725:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1726: 
1727:         IF !EMPTY(loc_cVal)
1728:             IF USED("cursor_4c_BuscaConta")
1729:                 USE IN cursor_4c_BuscaConta
1730:             ENDIF
1731:             IF SQLEXEC(gnConnHandle, ;
1732:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1733:                 EscaparSQL(loc_cVal + "%") + ;
1734:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1735:                 "cursor_4c_BuscaConta") > 0
1736:                 SELECT cursor_4c_BuscaConta
1737:                 GO TOP
1738:                 IF !EOF("cursor_4c_BuscaConta")
1739:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1740:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1741:                     USE IN cursor_4c_BuscaConta
1742:                     RETURN
1743:                 ENDIF
1744:                 USE IN cursor_4c_BuscaConta
1745:             ENDIF
1746:         ENDIF
1747:         TRY
1748:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1749:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1750:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1751:             IF VARTYPE(loc_oBA) = "O"
1752:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1753:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1754:                 loc_oBA.Show()
1755:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1756:                     SELECT cursor_4c_BuscaConta
1757:                     GO TOP
1758:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1759:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1760:                 ELSE
1761:                     THIS.txt_4c_DConta.Value = ""
1762:                 ENDIF
1763:                 IF USED("cursor_4c_BuscaConta")
1764:                     USE IN cursor_4c_BuscaConta
1765:                 ENDIF
1766:             ENDIF
1767:         CATCH TO loc_oErro
1768:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1769:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     *==========================================================================
1774:     * Lookup Promocao
1775:     *==========================================================================
1776:     PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1777:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1778:             RETURN
1779:         ENDIF
1780:         LOCAL loc_cVal, loc_oBA, loc_oErro
1781:         loc_cVal = ALLTRIM(THIS.txt_4c_Promo.Value)
1782:         IF !EMPTY(loc_cVal)
1783:             IF USED("cursor_4c_BuscaPromo")
1784:                 USE IN cursor_4c_BuscaPromo
1785:             ENDIF
1786:             IF SQLEXEC(gnConnHandle, ;
1787:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1788:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1789:                 SELECT cursor_4c_BuscaPromo
1790:                 GO TOP
1791:                 IF !EOF("cursor_4c_BuscaPromo")
1792:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1793:                     USE IN cursor_4c_BuscaPromo
1794:                     RETURN
1795:                 ENDIF
1796:                 USE IN cursor_4c_BuscaPromo
1797:             ENDIF
1798:         ENDIF
1799:         TRY
1800:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1801:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1802:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1803:             IF VARTYPE(loc_oBA) = "O"
1804:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1805:                 loc_oBA.Show()
1806:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1807:                     SELECT cursor_4c_BuscaPromo
1808:                     GO TOP
1809:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1810:                 ELSE
1811:                     THIS.txt_4c_Promo.Value = ""
1812:                 ENDIF
1813:                 IF USED("cursor_4c_BuscaPromo")
1814:                     USE IN cursor_4c_BuscaPromo
1815:                 ENDIF
1816:             ENDIF
1817:         CATCH TO loc_oErro
1818:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1819:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1820:         ENDTRY
1821:     ENDPROC
1822: 
1823:     *==========================================================================
1824:     * Lookup generico de Moeda (reutilizado por varios campos)
1825:     *==========================================================================
1826:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_oTxt)
1827:         LOCAL loc_cVal, loc_oBA, loc_oErro
1828:         loc_cVal = ALLTRIM(par_oTxt.Value)
1829:         IF !EMPTY(loc_cVal)
1830:             IF USED("cursor_4c_BuscaMoe")
1831:                 USE IN cursor_4c_BuscaMoe
1832:             ENDIF
1833:             IF SQLEXEC(gnConnHandle, ;
1834:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1835:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1836:                 SELECT cursor_4c_BuscaMoe
1837:                 GO TOP
1838:                 IF !EOF("cursor_4c_BuscaMoe")
1839:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1840:                     USE IN cursor_4c_BuscaMoe
1841:                     RETURN
1842:                 ENDIF
1843:                 USE IN cursor_4c_BuscaMoe
1844:             ENDIF
1845:         ENDIF
1846:         TRY
1847:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1848:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1849:             IF VARTYPE(loc_oBA) = "O"
1850:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1851:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1852:                 loc_oBA.Show()
1853:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1854:                     SELECT cursor_4c_BuscaMoe
1855:                     GO TOP
1856:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1857:                 ELSE
1858:                     par_oTxt.Value = ""
1859:                 ENDIF
1860:                 IF USED("cursor_4c_BuscaMoe")
1861:                     USE IN cursor_4c_BuscaMoe
1862:                 ENDIF
1863:             ENDIF
1864:         CATCH TO loc_oErro
1865:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1866:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1867:         ENDTRY
1868:     ENDPROC
1869: 
1870:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1871:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1872:             RETURN
1873:         ENDIF
1874:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moeda)
1875:     ENDPROC
1876: 
1877:     PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1878:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1879:             RETURN
1880:         ENDIF
1881:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCs)
1882:     ENDPROC
1883: 
1884:     PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1885:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1886:             RETURN
1887:         ENDIF
1888:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusFs)
1889:     ENDPROC
1890: 
1891:     PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1892:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1893:             RETURN
1894:         ENDIF
1895:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moedas)
1896:     ENDPROC
1897: 
1898:     PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1899:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1900:             RETURN
1901:         ENDIF
1902:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeVs)
1903:     ENDPROC
1904: 
1905:     PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1906:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1907:             RETURN
1908:         ENDIF
1909:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusto)
1910:     ENDPROC
1911: 
1912:     *==========================================================================
1913:     * Lookup Feitio
1914:     *==========================================================================
1915:     PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1916:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1917:             RETURN
1918:         ENDIF
1919:         LOCAL loc_cVal, loc_oBA, loc_oErro
1920:         loc_cVal = ALLTRIM(THIS.txt_4c_CFtios.Value)
1921:         IF !EMPTY(loc_cVal)
1922:             IF USED("cursor_4c_BuscaFtio")
1923:                 USE IN cursor_4c_BuscaFtio
1924:             ENDIF
1925:             IF SQLEXEC(gnConnHandle, ;
1926:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1927:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1928:                 SELECT cursor_4c_BuscaFtio
1929:                 GO TOP
1930:                 IF !EOF("cursor_4c_BuscaFtio")
1931:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1932:                     USE IN cursor_4c_BuscaFtio
1933:                     RETURN
1934:                 ENDIF
1935:                 USE IN cursor_4c_BuscaFtio
1936:             ENDIF
1937:         ENDIF
1938:         TRY
1939:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1940:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1941:             IF VARTYPE(loc_oBA) = "O"
1942:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1943:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1944:                 loc_oBA.Show()
1945:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1946:                     SELECT cursor_4c_BuscaFtio
1947:                     GO TOP
1948:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1949:                 ELSE
1950:                     THIS.txt_4c_CFtios.Value = ""
1951:                 ENDIF
1952:                 IF USED("cursor_4c_BuscaFtio")
1953:                     USE IN cursor_4c_BuscaFtio
1954:                 ENDIF
1955:             ENDIF
1956:         CATCH TO loc_oErro
1957:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1958:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1959:         ENDTRY
1960:     ENDPROC
1961: 
1962:     *==========================================================================
1963:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1964:     *==========================================================================
1965:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1966:         LOCAL loc_i, loc_oControl
1967:         IF VARTYPE(par_oContainer) # "O"
1968:             RETURN
1969:         ENDIF
1970:         FOR loc_i = 1 TO par_oContainer.ControlCount
1971:             loc_oControl = par_oContainer.Controls(loc_i)
1972:             IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
1973:                 LOOP
1974:             ENDIF
1975:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1976:                 THIS.TornarControlesVisiveis(loc_oControl)
1977:             ENDIF
1978:             loc_oControl.Visible = .T.
1979:         ENDFOR
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * ConfigurarPaginaLista - Form OPERACIONAL: consolida cabecalho, botoes,
1984:     * filtros e grade num unico layout (equivalente da "Page1 - Lista" dos CRUD)
1985:     *==========================================================================
1986:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1987:         LOCAL loc_lJaConfigurado
1988: 
1989:         loc_lJaConfigurado = PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5) ;
1990:                          AND PEMSTATUS(THIS, "cmg_4c_Botoes", 5) ;
1991:                          AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1992: 
1993:         IF !loc_lJaConfigurado
1994:             THIS.ConfigurarCabecalho()
1995:             THIS.ConfigurarBotoes()
1996:             THIS.ConfigurarFiltros()
1997:             THIS.ConfigurarGrade()
1998:         ENDIF
1999: 
2000:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
2001:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
2002:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
2003:         ENDIF
2004: 
2005:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2006:             SELECT cursor_4c_Produtos
2007:             GO TOP
2008:             THIS.grd_4c_Dados.Refresh()
2009:         ENDIF
2010:     ENDPROC
2011: 
2012:     *==========================================================================
2013:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2014:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2015:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2016:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2017:     *==========================================================================
2018:     PROCEDURE AlternarPagina(par_nPagina)
2019:         LOCAL loc_nPagina
2020: 
2021:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2022: 
2023:         DO CASE
2024:         CASE loc_nPagina = 1
2025:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2026:                 THIS.txt_4c_GrupoIni.SetFocus()
2027:             ENDIF
2028:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2029:                 SELECT cursor_4c_Produtos
2030:                 GO TOP
2031:                 THIS.grd_4c_Dados.Refresh()
2032:             ENDIF
2033:         CASE loc_nPagina = 2
2034:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2035:                 THIS.grd_4c_Dados.SetFocus()
2036:             ENDIF
2037:         ENDCASE
2038: 
2039:         RETURN .T.
2040:     ENDPROC
2041: 
2042:     *==========================================================================
2043:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2044:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.
2045:     *==========================================================================
2046:     PROCEDURE CarregarLista()
2047:         LOCAL loc_lSucesso, loc_oErro
2048:         loc_lSucesso = .F.
2049: 
2050:         TRY
2051:             SET NULL ON
2052:             IF USED("cursor_4c_Produtos")
2053:                 IF TABLEREVERT(.T., "cursor_4c_Produtos")
2054:                 ENDIF
2055:                 USE IN cursor_4c_Produtos
2056:             ENDIF
2057: 
2058:             CREATE CURSOR cursor_4c_Produtos ( ;
2059:                 lMarca  N(1) NULL, ;
2060:                 CPros   C(14) NULL, ;
2061:                 DPros   C(40) NULL, ;
2062:                 ValAnt  N(14,4) NULL, ;
2063:                 ValAtu  N(14,4) NULL, ;
2064:                 fCustos N(9,4) NULL, ;
2065:                 MoePcs  C(3) NULL, ;
2066:                 CustoFs N(14,4) NULL, ;
2067:                 Manual  N(1) NULL)
2068:             INDEX ON CPros TAG CPros
2069:             SET NULL OFF
2070: 
2071:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2072:                 THIS.grd_4c_Dados.ColumnCount = 5
2073:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2074:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
2075:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
2076:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
2077:                 THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
2078:                 THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
2079:                 THIS.grd_4c_Dados.Refresh()
2080:             ENDIF
2081: 
2082:             THIS.AjustarBotoesPorModo()
2083: 
2084:             loc_lSucesso = .T.
2085:         CATCH TO loc_oErro
2086:             SET NULL OFF
2087:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2088:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2089:         ENDTRY
2090: 
2091:         RETURN loc_lSucesso
2092:     ENDPROC
2093: 
2094:     *==========================================================================
2095:     * LimparCampos - Reseta todos os campos de filtro e esvazia o grid
2096:     *==========================================================================
2097:     PROCEDURE LimparCampos()
2098:         THIS.txt_4c_GrupoIni.Value  = ""
2099:         THIS.txt_4c_GrupoFim.Value  = ""
2100:         THIS.txt_4c_Colecao.Value   = ""
2101:         THIS.txt_4c_Conta.Value     = ""
2102:         THIS.txt_4c_DConta.Value    = ""
2103:         THIS.txt_4c_Promo.Value     = ""
2104:         THIS.txt_4c_Variacao.Value  = 0
2105:         THIS.txt_4c_Moeda.Value     = ""
2106:         THIS.txt_4c_MarkUp1.Value   = 0
2107:         THIS.txt_4c_MarkUp2.Value   = 0
2108:         THIS.txt_4c_Fator.Value     = 0
2109:         THIS.txt_4c_MoeCusto.Value  = ""
2110:         THIS.txt_4c_MoeCs.Value     = ""
2111:         THIS.txt_4c_MoeCusFs.Value  = ""
2112:         THIS.txt_4c_Moedas.Value    = ""
2113:         THIS.txt_4c_CFtios.Value    = ""
2114:         THIS.txt_4c_MoeVs.Value     = ""
2115:         THIS.chk_4c_IncCusts.Value  = 0
2116:         THIS.chk_4c_Limpar.Value    = 0
2117:         THIS.chk_4c_Ignorar.Value   = 0
2118:         THIS.chk_4c_Auditado.Value  = 0
2119: 
2120:         THIS.opt_4c_Tipo.Value = 1
2121:         THIS.OptTipoChange()
2122: 
2123:         IF PEMSTATUS(THIS, "img_4c_Foto", 5)
2124:             THIS.img_4c_Foto.Visible = .F.
2125:             THIS.img_4c_Foto.Picture = ""
2126:         ENDIF
2127: 
2128:         THIS.CarregarLista()
2129: 
2130:         THIS.txt_4c_GrupoIni.SetFocus()
2131:     ENDPROC
2132: 
2133:     *==========================================================================
2134:     * HabilitarCampos - Habilita ou desabilita campos de filtro
2135:     * par_lHabilitar: .T. = habilitar filtros (estado inicial / pos-Atualizar)
2136:     *                 .F. = desabilitar filtros (durante modo Auditado)
2137:     *==========================================================================
2138:     PROCEDURE HabilitarCampos(par_lHabilitar)
2139:         LOCAL loc_lHab
2140:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2141: 
2142:         THIS.txt_4c_GrupoIni.Enabled = loc_lHab
2143:         THIS.txt_4c_GrupoFim.Enabled = loc_lHab
2144:         THIS.txt_4c_Colecao.Enabled  = loc_lHab
2145:         THIS.txt_4c_Moeda.Enabled    = loc_lHab
2146:         THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
2147:         THIS.opt_4c_Tipo.Enabled     = loc_lHab
2148: 
2149:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2150:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
2151:         ENDIF
2152: 
2153:         THIS.Refresh()
2154:     ENDPROC
2155: 
2156:     *==========================================================================
2157:     * AjustarBotoesPorModo - Controla estados dos botoes baseado no grid
2158:     * Processar: sempre habilitado (a menos que em modo Auditado)
2159:     * Atualizar: habilitado somente quando ha produtos processados no grid
2160:     *==========================================================================
2161:     PROCEDURE AjustarBotoesPorModo()
2162:         LOCAL loc_lTemProdutos, loc_lModoAuditado
2163: 
2164:         loc_lTemProdutos  = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2165:         loc_lModoAuditado = PEMSTATUS(THIS, "chk_4c_Auditado", 5) ;
2166:                         AND THIS.chk_4c_Auditado.Value = 1
2167: 
2168:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2169:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = !loc_lModoAuditado
2170:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lTemProdutos
2171:             THIS.cmg_4c_Botoes.Refresh()
2172:         ENDIF
2173:     ENDPROC
2174: 
2175: ENDDEFINE

