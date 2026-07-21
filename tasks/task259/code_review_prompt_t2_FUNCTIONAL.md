# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Produtos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2182 linhas total):

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

*-- Linhas 765 a 1231:
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
1057:                 SET NULL ON
1058:                 CREATE CURSOR cursor_4c_Produtos ( ;
1059:                     lMarca  N(1) NULL, ;
1060:                     CPros   C(14) NULL, ;
1061:                     DPros   C(40) NULL, ;
1062:                     ValAnt  N(14,4) NULL, ;
1063:                     ValAtu  N(14,4) NULL, ;
1064:                     fCustos N(9,4) NULL, ;
1065:                     MoePcs  C(3) NULL, ;
1066:                     CustoFs N(14,4) NULL, ;
1067:                     Manual  N(1) NULL)
1068:                 INDEX ON CPros TAG CPros
1069:                 SET NULL OFF
1070:             ENDIF
1071: 
1072:             INSERT INTO cursor_4c_Produtos ;
1073:                 (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1074:                 VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1075: 
1076:             SELECT cursor_4c_Produtos
1077:             SET ORDER TO
1078:             GO BOTTOM
1079: 
1080:             THIS.grd_4c_Dados.ColumnCount = 3
1081:             THIS.grd_4c_Dados.RecordSource            = "cursor_4c_Produtos"
1082:             THIS.grd_4c_Dados.Column1.ControlSource   = "cursor_4c_Produtos.lMarca"
1083:             THIS.grd_4c_Dados.Column2.ControlSource   = "cursor_4c_Produtos.CPros"
1084:             THIS.grd_4c_Dados.Column3.ControlSource   = "cursor_4c_Produtos.DPros"
1085:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1086:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1087:             THIS.grd_4c_Dados.Refresh()
1088:             THIS.grd_4c_Dados.SetFocus()
1089:             THIS.grd_4c_Dados.ActivateCell(RECNO("cursor_4c_Produtos"), 2)
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1092:                     " PROC=" + loc_oErro.Procedure, "Erro BtnIncluirClick")
1093:         ENDTRY
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * BtnAlterarClick - Recalcula precos (alterar base de calculo)
1098:     * Delega para BtnProcessarClick que executa o processamento principal
1099:     *==========================================================================
1100:     PROCEDURE BtnAlterarClick()
1101:         LOCAL loc_oErro
1102: 
1103:         TRY
1104:             THIS.BtnProcessarClick()
1105:         CATCH TO loc_oErro
1106:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1107:                     " PROC=" + loc_oErro.Procedure, "Erro BtnAlterarClick")
1108:         ENDTRY
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * BtnVisualizarClick - Exibe foto e detalhes do produto selecionado
1113:     * Refresca a linha atual do grid disparando a mesma logica de AfterRowColChange
1114:     *==========================================================================
1115:     PROCEDURE BtnVisualizarClick()
1116:         LOCAL loc_oErro
1117: 
1118:         TRY
1119:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1120:                 MsgAviso("Nenhum produto no grid para visualiza" + CHR(231) + CHR(227) + "o.", ;
1121:                         "Visualizar")
1122:             ELSE
1123:                 SELECT cursor_4c_Produtos
1124:                 IF EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1125:                     MsgAviso("Selecione um produto v" + CHR(225) + "lido no grid.", ;
1126:                             "Visualizar")
1127:                 ELSE
1128:                     THIS.GrdAfterRowColChange(2)
1129:                     THIS.grd_4c_Dados.Refresh()
1130:                     IF PEMSTATUS(THIS, "img_4c_Foto", 5)
1131:                         THIS.img_4c_Foto.Refresh()
1132:                     ENDIF
1133:                 ENDIF
1134:             ENDIF
1135:         CATCH TO loc_oErro
1136:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1137:                     " PROC=" + loc_oErro.Procedure, "Erro BtnVisualizarClick")
1138:         ENDTRY
1139:     ENDPROC
1140: 
1141:     *==========================================================================
1142:     * BtnExcluirClick - Remove produtos marcados/selecionados do grid
1143:     * (nao exclui do banco - apenas remove do cursor de pre-processamento)
1144:     *==========================================================================
1145:     PROCEDURE BtnExcluirClick()
1146:         LOCAL loc_nRemovidos, loc_oErro
1147:         loc_nRemovidos = 0
1148: 
1149:         TRY
1150:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
1151:                 MsgAviso("Nenhum produto no grid para exclus" + CHR(227) + "o.", "Excluir")
1152:             ELSE
1153:                 SELECT cursor_4c_Produtos
1154:                 COUNT FOR NVL(lMarca, 0) = 1 TO loc_nRemovidos
1155: 
1156:                 IF loc_nRemovidos = 0
1157:                     IF MsgConfirma("Nenhum produto marcado. Remover o produto atual do grid?", ;
1158:                             "Excluir")
1159:                         IF !EOF("cursor_4c_Produtos")
1160:                             DELETE
1161:                             PACK MEMO
1162:                             loc_nRemovidos = 1
1163:                         ENDIF
1164:                     ENDIF
1165:                 ELSE
1166:                     IF MsgConfirma("Remover " + TRANSFORM(loc_nRemovidos) + ;
1167:                             " produto(s) marcado(s) do grid?", "Excluir")
1168:                         DELETE FOR NVL(lMarca, 0) = 1
1169:                         PACK MEMO
1170:                     ELSE
1171:                         loc_nRemovidos = 0
1172:                     ENDIF
1173:                 ENDIF
1174: 
1175:                 IF loc_nRemovidos > 0
1176:                     SELECT cursor_4c_Produtos
1177:                     GO TOP
1178:                     THIS.grd_4c_Dados.Refresh()
1179:                     THIS.Refresh()
1180:                 ENDIF
1181:             ENDIF
1182:         CATCH TO loc_oErro
1183:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1184:                     " PROC=" + loc_oErro.Procedure, "Erro BtnExcluirClick")
1185:         ENDTRY
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * OptTipoChange - Controla visibilidade de campos por tipo de reajuste
1190:     *==========================================================================
1191:     PROCEDURE OptTipoChange()
1192:         LOCAL loc_nTipo
1193:         loc_nTipo = THIS.opt_4c_Tipo.Value
1194: 
1195:         DO CASE
1196:         CASE loc_nTipo = 1
1197:             THIS.lbl_4c_Variacao.Visible  = .T.
1198:             THIS.txt_4c_Variacao.Visible  = .T.
1199:             THIS.lbl_4c_Pct.Visible       = .T.
1200:             THIS.chk_4c_IncCusts.Visible  = .T.
1201:             THIS.lbl_4c_Moeda.Visible     = .F.
1202:             THIS.txt_4c_Moeda.Visible     = .F.
1203:             THIS.lbl_4c_MarkUp.Visible    = .F.
1204:             THIS.txt_4c_MarkUp1.Visible   = .F.
1205:             THIS.lbl_4c_Para.Visible      = .F.
1206:             THIS.txt_4c_MarkUp2.Visible   = .F.
1207:             THIS.lbl_4c_FatorCusto.Visible = .F.
1208:             THIS.txt_4c_Fator.Visible     = .F.
1209:             THIS.txt_4c_MoeCusto.Visible  = .F.
1210:             THIS.lbl_4c_Moeda1.Visible    = .F.
1211:             THIS.txt_4c_MoeCs.Visible     = .F.
1212:             THIS.lbl_4c_Moeda2.Visible    = .F.
1213:             THIS.txt_4c_MoeCusFs.Visible  = .F.
1214:             THIS.lbl_4c_Moeda4.Visible    = .F.
1215:             THIS.txt_4c_Moedas.Visible    = .F.
1216:             THIS.lbl_4c_Moeda3.Visible    = .F.
1217:             THIS.txt_4c_CFtios.Visible    = .F.
1218:             THIS.lbl_4c_Moeda5.Visible    = .F.
1219:             THIS.txt_4c_MoeVs.Visible     = .F.
1220: 
1221:         CASE loc_nTipo = 2
1222:             THIS.lbl_4c_Variacao.Visible  = .F.
1223:             THIS.txt_4c_Variacao.Visible  = .F.
1224:             THIS.lbl_4c_Pct.Visible       = .F.
1225:             THIS.chk_4c_IncCusts.Visible  = .F.
1226:             THIS.lbl_4c_Moeda.Visible     = .T.
1227:             THIS.txt_4c_Moeda.Visible     = .T.
1228:             THIS.lbl_4c_MarkUp.Visible    = .T.
1229:             THIS.txt_4c_MarkUp1.Visible   = .T.
1230:             THIS.lbl_4c_Para.Visible      = .T.
1231:             THIS.txt_4c_MarkUp2.Visible   = .T.

*-- Linhas 1275 a 1470:
1275:     *==========================================================================
1276:     * ChkAuditadoClick - Modo de edicao manual no grid
1277:     *==========================================================================
1278:     PROCEDURE ChkAuditadoClick()
1279:         IF THIS.chk_4c_Auditado.Value = 1
1280:             *-- Modo Auditado ON: adicionar linha vazia para entrada manual
1281:             IF USED("cursor_4c_Produtos")
1282:                 INSERT INTO cursor_4c_Produtos ;
1283:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1284:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1285:                 SELECT cursor_4c_Produtos
1286:                 SET ORDER TO
1287:                 GO TOP
1288:             ENDIF
1289:             THIS.txt_4c_GrupoIni.Enabled              = .F.
1290:             THIS.txt_4c_GrupoFim.Enabled              = .F.
1291:             THIS.txt_4c_Colecao.Enabled               = .F.
1292:             THIS.txt_4c_Moeda.Enabled                 = .F.
1293:             THIS.txt_4c_MarkUp1.Enabled               = .F.
1294:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .F.
1295:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .T.
1296:             THIS.grd_4c_Dados.Column2.ReadOnly        = .F.
1297:             THIS.grd_4c_Dados.Refresh()
1298:         ELSE
1299:             *-- Modo Auditado OFF: limpar grid e restaurar filtros
1300:             IF USED("cursor_4c_Produtos")
1301:                 DELETE FROM cursor_4c_Produtos
1302:                 SELECT cursor_4c_Produtos
1303:                 SET ORDER TO CPros
1304:                 GO TOP
1305:             ENDIF
1306:             THIS.txt_4c_GrupoIni.Enabled              = .T.
1307:             THIS.txt_4c_GrupoFim.Enabled              = .T.
1308:             THIS.txt_4c_Colecao.Enabled               = .T.
1309:             THIS.txt_4c_Moeda.Enabled                 = .T.
1310:             THIS.txt_4c_MarkUp1.Enabled               = .T.
1311:             THIS.cmg_4c_Botoes.Buttons(1).Enabled     = .T.
1312:             THIS.grd_4c_Dados.Column1.Check1.ReadOnly = .F.
1313:             THIS.grd_4c_Dados.Column2.ReadOnly        = .T.
1314:             THIS.grd_4c_Dados.Refresh()
1315:             THIS.txt_4c_GrupoIni.SetFocus()
1316:         ENDIF
1317:         THIS.cmg_4c_Botoes.Refresh()
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * GrdAfterRowColChange - foto do produto + rastrear edicao manual do preco
1322:     *==========================================================================
1323:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1324:         LOCAL loc_cArqFig, loc_cSQL, loc_cFoto, loc_oErro
1325: 
1326:         TRY
1327:             IF USED("cursor_4c_Produtos")
1328:                 SELECT cursor_4c_Produtos
1329:                 IF EOF("cursor_4c_Produtos")
1330:                     THIS.img_4c_Foto.Visible = .F.
1331:                     THIS.img_4c_Foto.Picture = ""
1332:                 ELSE
1333:                     *-- Rastrear edicao manual do preco (Column5)
1334:                     IF par_nColIndex = 5
1335:                         THIS.this_cAntValue = TRANSFORM(cursor_4c_Produtos.ValAtu)
1336:                     ELSE
1337:                         IF THIS.this_lLibValAtu AND !EMPTY(THIS.this_cAntValue)
1338:                         IF THIS.this_cAntValue != TRANSFORM(cursor_4c_Produtos.ValAtu)
1339:                             REPLACE Manual WITH 1 IN cursor_4c_Produtos
1340:                         ENDIF
1341:                         THIS.this_cAntValue = ""
1342:                         ENDIF
1343:                     ENDIF
1344: 
1345:                     *-- Exibir foto do produto
1346:                     IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1347:                         loc_cArqFig = SYS(2023) + "\" + SYS(2015) + ".jpg"
1348:                         loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
1349:                                        EscaparSQL(ALLTRIM(cursor_4c_Produtos.CPros))
1350:                         IF USED("cursor_4c_FigTemp")
1351:                             USE IN cursor_4c_FigTemp
1352:                         ENDIF
1353:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigTemp") >= 1
1354:                             SELECT cursor_4c_FigTemp
1355:                             THIS.img_4c_Foto.Visible = .F.
1356:                             THIS.img_4c_Foto.Picture = ""
1357:                             IF !ISNULL(cursor_4c_FigTemp.FigJpgs) AND !EMPTY(cursor_4c_FigTemp.FigJpgs)
1358:                                 CLEAR RESOURCES
1359:                                 loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_FigTemp.FigJpgs, ;
1360:                                     "data:image/png;base64,", ""), ;
1361:                                     "data:image/jpeg;base64,", ""), ;
1362:                                     "data:image/jpg;base64,", ""), 14)
1363:                                 STRTOFILE(loc_cFoto, loc_cArqFig)
1364:                                 THIS.img_4c_Foto.Picture = loc_cArqFig
1365:                                 THIS.img_4c_Foto.Visible = .T.
1366:                             ENDIF
1367:                             USE IN cursor_4c_FigTemp
1368:                             SELECT cursor_4c_Produtos
1369:                         ELSE
1370:                             THIS.img_4c_Foto.Visible = .F.
1371:                             THIS.img_4c_Foto.Picture = ""
1372:                         ENDIF
1373:                     ELSE
1374:                         THIS.img_4c_Foto.Visible = .F.
1375:                         THIS.img_4c_Foto.Picture = ""
1376:                     ENDIF
1377:                 ENDIF
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             IF USED("cursor_4c_FigTemp")
1381:                 USE IN cursor_4c_FigTemp
1382:             ENDIF
1383:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1384:                     " PROC=" + loc_oErro.Procedure, "Erro GrdAfterRowColChange")
1385:         ENDTRY
1386:     ENDPROC
1387: 
1388:     *==========================================================================
1389:     * GrdHeaderClick - clicar no header da Column1 marca/desmarca todos
1390:     *==========================================================================
1391:     PROCEDURE GrdHeaderClick(par_nColIndex)
1392:         IF par_nColIndex != 1 OR !USED("cursor_4c_Produtos")
1393:             RETURN
1394:         ENDIF
1395:         IF THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1396:             UPDATE cursor_4c_Produtos SET lMarca = 1
1397:             THIS.grd_4c_Dados.Column1.Header1.Tag = "1"
1398:         ELSE
1399:             UPDATE cursor_4c_Produtos SET lMarca = 0
1400:             THIS.grd_4c_Dados.Column1.Header1.Tag = "0"
1401:         ENDIF
1402:         THIS.grd_4c_Dados.Refresh()
1403:         THIS.Refresh()
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * GrdKeyPress - Em modo Auditado, dispara lookup de produto ao Enter/Tab/F4
1408:     *==========================================================================
1409:     PROCEDURE GrdKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1410:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1411:             RETURN
1412:         ENDIF
1413:         IF THIS.chk_4c_Auditado.Value != 1
1414:             RETURN
1415:         ENDIF
1416:         IF THIS.grd_4c_Dados.ActiveColumn != 2
1417:             RETURN
1418:         ENDIF
1419:         LOCAL loc_cVal
1420:         loc_cVal = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
1421:         IF !EMPTY(loc_cVal)
1422:             THIS.AtualizarLinhaGrid(loc_cVal)
1423:         ENDIF
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * AtualizarLinhaGrid - Calcula preco para produto e preenche linha do grid
1428:     * Chamado no modo Auditado quando usuario digita codigo de produto
1429:     *==========================================================================
1430:     PROTECTED PROCEDURE AtualizarLinhaGrid(par_cCPros)
1431:         LOCAL loc_oBO, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1432:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPven
1433:         LOCAL loc_cMoePcs, loc_nFCustos, loc_nCustoFs, loc_oErro
1434: 
1435:         TRY
1436:             loc_oBO       = THIS.this_oBusinessObject
1437:             loc_nTipo     = THIS.opt_4c_Tipo.Value
1438:             loc_nVariacao = THIS.txt_4c_Variacao.Value
1439:             loc_nMarkUp2  = THIS.txt_4c_MarkUp2.Value
1440: 
1441:             *-- Buscar produto no banco
1442:             IF USED("cursor_4c_BuscaProSingle")
1443:                 USE IN cursor_4c_BuscaProSingle
1444:             ENDIF
1445:             IF SQLEXEC(gnConnHandle, ;
1446:                 "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(par_cCPros), ;
1447:                 "cursor_4c_BuscaProSingle") >= 1 ;
1448:                AND RECCOUNT("cursor_4c_BuscaProSingle") > 0
1449: 
1450:                 *-- Inserir no buffer TmpPro se nao existir (para CalcPreco poder ler)
1451:                 IF !SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1452:                     SELECT cursor_4c_BuscaProSingle
1453:                     GO TOP
1454:                     SCATTER MEMVAR MEMO
1455:                     SELECT cursor_4c_TmpPro
1456:                     INSERT INTO cursor_4c_TmpPro FROM MEMVAR
1457:                     INDEX ON CPros TAG CPros
1458:                 ENDIF
1459: 
1460:                 *-- Posicionar TmpPro no produto e calcular preco
1461:                 IF SEEK(par_cCPros, "cursor_4c_TmpPro", "CPros")
1462:                 SELECT cursor_4c_TmpPro
1463: 
1464:             *-- Calcular novo preco
1465:             DO CASE
1466:             CASE loc_nTipo = 1
1467:                 loc_nValAtu = cursor_4c_TmpPro.PVens + ;
1468:                     ((cursor_4c_TmpPro.PVens * loc_nVariacao) / 100)
1469:             CASE loc_nTipo = 2
1470:                 loc_nValAtu = loc_oBO.CalcPreco(loc_nMarkUp2)

*-- Linhas 1486 a 2182:
1486:             loc_nFCustos = IIF(THIS.txt_4c_Fator.Value > 0 AND !EMPTY(loc_cMoePcs), ;
1487:                 THIS.txt_4c_Fator.Value, cursor_4c_TmpPro.fCustos)
1488:             loc_nCustoFs = cursor_4c_TmpPro.CustoFs
1489: 
1490:             *-- Atualizar linha corrente no grid
1491:             SELECT cursor_4c_Produtos
1492:             REPLACE lMarca   WITH 1,                              ;
1493:                     CPros    WITH par_cCPros,                     ;
1494:                     DPros    WITH ALLTRIM(cursor_4c_TmpPro.DPros), ;
1495:                     ValAnt   WITH cursor_4c_TmpPro.PVens,          ;
1496:                     ValAtu   WITH loc_nValAtu,                     ;
1497:                     fCustos  WITH loc_nFCustos,                   ;
1498:                     MoePcs   WITH loc_cMoePcs,                    ;
1499:                     CustoFs  WITH loc_nCustoFs,                   ;
1500:                     Manual   WITH 0
1501: 
1502:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
1503:             THIS.cmg_4c_Botoes.Refresh()
1504: 
1505:             *-- Adicionar linha vazia para o proximo produto
1506:             SELECT cursor_4c_Produtos
1507:             SET ORDER TO
1508:             GO BOTTOM
1509:             IF !EMPTY(ALLTRIM(cursor_4c_Produtos.CPros))
1510:                 INSERT INTO cursor_4c_Produtos ;
1511:                     (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1512:                     VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, "   ", 0, 0)
1513:             ENDIF
1514:             SELECT cursor_4c_Produtos
1515:             THIS.grd_4c_Dados.Refresh()
1516:             KEYBOARD "{DNARROW}"
1517: 
1518:                     IF USED("cursor_4c_BuscaProSingle")
1519:                         USE IN cursor_4c_BuscaProSingle
1520:                     ENDIF
1521:                 ELSE
1522:                     IF USED("cursor_4c_BuscaProSingle")
1523:                         USE IN cursor_4c_BuscaProSingle
1524:                     ENDIF
1525:                 ENDIF
1526:             ELSE
1527:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + par_cCPros, "Produto")
1528:                 IF USED("cursor_4c_BuscaProSingle")
1529:                     USE IN cursor_4c_BuscaProSingle
1530:                 ENDIF
1531:             ENDIF
1532:         CATCH TO loc_oErro
1533:             IF USED("cursor_4c_BuscaProSingle")
1534:                 USE IN cursor_4c_BuscaProSingle
1535:             ENDIF
1536:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1537:                     " PROC=" + loc_oErro.Procedure, "Erro AtualizarLinhaGrid")
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     *==========================================================================
1542:     * Lookup handlers - Grupo
1543:     *==========================================================================
1544:     PROCEDURE TxtGrupoIniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1545:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1546:             RETURN
1547:         ENDIF
1548:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoIni, THIS.txt_4c_GrupoFim)
1549:     ENDPROC
1550: 
1551:     PROCEDURE TxtGrupoFimKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1552:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1553:             RETURN
1554:         ENDIF
1555:         THIS.AbrirBuscaGrupo(THIS.txt_4c_GrupoFim, .NULL.)
1556:     ENDPROC
1557: 
1558:     PROTECTED PROCEDURE AbrirBuscaGrupo(par_oTxtAlvo, par_oTxtFim)
1559:         LOCAL loc_cVal, loc_oBA, loc_oErro
1560:         loc_cVal = ALLTRIM(par_oTxtAlvo.Value)
1561:         IF !EMPTY(loc_cVal)
1562:             IF USED("cursor_4c_BuscaGrp")
1563:                 USE IN cursor_4c_BuscaGrp
1564:             ENDIF
1565:             IF SQLEXEC(gnConnHandle, ;
1566:                 "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
1567:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaGrp") > 0
1568:                 SELECT cursor_4c_BuscaGrp
1569:                 GO TOP
1570:                 IF !EOF("cursor_4c_BuscaGrp")
1571:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1572:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1573:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1574:                     ENDIF
1575:                     USE IN cursor_4c_BuscaGrp
1576:                     RETURN
1577:                 ENDIF
1578:                 USE IN cursor_4c_BuscaGrp
1579:             ENDIF
1580:         ENDIF
1581:         TRY
1582:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1583:                 "cursor_4c_BuscaGrp", "CGrus", loc_cVal, ;
1584:                 "Grupos de Produto", .T., .T., "")
1585:             IF VARTYPE(loc_oBA) = "O"
1586:                 loc_oBA.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1587:                 loc_oBA.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1588:                 loc_oBA.Show()
1589:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1590:                     SELECT cursor_4c_BuscaGrp
1591:                     GO TOP
1592:                     par_oTxtAlvo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1593:                     IF VARTYPE(par_oTxtFim) = "O" AND EMPTY(ALLTRIM(par_oTxtFim.Value))
1594:                         par_oTxtFim.Value = par_oTxtAlvo.Value
1595:                     ENDIF
1596:                 ELSE
1597:                     par_oTxtAlvo.Value = ""
1598:                 ENDIF
1599:                 IF USED("cursor_4c_BuscaGrp")
1600:                     USE IN cursor_4c_BuscaGrp
1601:                 ENDIF
1602:             ENDIF
1603:         CATCH TO loc_oErro
1604:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1605:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaGrupo")
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * Lookup Colecao
1611:     *==========================================================================
1612:     PROCEDURE TxtColecaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1613:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1614:             RETURN
1615:         ENDIF
1616:         LOCAL loc_cVal, loc_oBA, loc_oErro
1617:         loc_cVal = ALLTRIM(THIS.txt_4c_Colecao.Value)
1618:         IF !EMPTY(loc_cVal)
1619:             IF USED("cursor_4c_BuscaCol")
1620:                 USE IN cursor_4c_BuscaCol
1621:             ENDIF
1622:             IF SQLEXEC(gnConnHandle, ;
1623:                 "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
1624:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaCol") > 0
1625:                 SELECT cursor_4c_BuscaCol
1626:                 GO TOP
1627:                 IF !EOF("cursor_4c_BuscaCol")
1628:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1629:                     USE IN cursor_4c_BuscaCol
1630:                     RETURN
1631:                 ENDIF
1632:                 USE IN cursor_4c_BuscaCol
1633:             ENDIF
1634:         ENDIF
1635:         TRY
1636:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", ;
1637:                 "cursor_4c_BuscaCol", "Colecoes", loc_cVal, ;
1638:                 "Cole" + CHR(231) + CHR(245) + "es", .T., .T., "")
1639:             IF VARTYPE(loc_oBA) = "O"
1640:                 loc_oBA.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
1641:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1642:                 loc_oBA.Show()
1643:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1644:                     SELECT cursor_4c_BuscaCol
1645:                     GO TOP
1646:                     THIS.txt_4c_Colecao.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1647:                 ELSE
1648:                     THIS.txt_4c_Colecao.Value = ""
1649:                 ENDIF
1650:                 IF USED("cursor_4c_BuscaCol")
1651:                     USE IN cursor_4c_BuscaCol
1652:                 ENDIF
1653:             ENDIF
1654:         CATCH TO loc_oErro
1655:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1656:                     " PROC=" + loc_oErro.Procedure, "Erro TxtColecaoKeyPress")
1657:         ENDTRY
1658:     ENDPROC
1659: 
1660:     *==========================================================================
1661:     * Lookup Fornecedor por codigo
1662:     *==========================================================================
1663:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1664:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1665:             RETURN
1666:         ENDIF
1667:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltro, loc_oBA, loc_oErro
1668:         loc_cVal   = ALLTRIM(THIS.txt_4c_Conta.Value)
1669:         loc_cGrupo = THIS.this_oBusinessObject.this_cGrPadFors
1670:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), "")
1671: 
1672:         IF !EMPTY(loc_cVal)
1673:             IF USED("cursor_4c_BuscaConta")
1674:                 USE IN cursor_4c_BuscaConta
1675:             ENDIF
1676:             IF SQLEXEC(gnConnHandle, ;
1677:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1678:                 EscaparSQL(loc_cVal) + loc_cFiltro, "cursor_4c_BuscaConta") > 0
1679:                 SELECT cursor_4c_BuscaConta
1680:                 GO TOP
1681:                 IF !EOF("cursor_4c_BuscaConta")
1682:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1683:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1684:                     USE IN cursor_4c_BuscaConta
1685:                     RETURN
1686:                 ENDIF
1687:                 USE IN cursor_4c_BuscaConta
1688:             ENDIF
1689:         ENDIF
1690:         TRY
1691:             LOCAL loc_cFiltroBA
1692:             loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1693:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1694:                 "cursor_4c_BuscaConta", "IClis", loc_cVal, ;
1695:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1696:             IF VARTYPE(loc_oBA) = "O"
1697:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1698:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1699:                 loc_oBA.Show()
1700:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1701:                     SELECT cursor_4c_BuscaConta
1702:                     GO TOP
1703:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1704:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1705:                 ELSE
1706:                     THIS.txt_4c_Conta.Value  = ""
1707:                     THIS.txt_4c_DConta.Value = ""
1708:                 ENDIF
1709:                 IF USED("cursor_4c_BuscaConta")
1710:                     USE IN cursor_4c_BuscaConta
1711:                 ENDIF
1712:             ENDIF
1713:         CATCH TO loc_oErro
1714:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1715:                     " PROC=" + loc_oErro.Procedure, "Erro TxtContaKeyPress")
1716:         ENDTRY
1717:     ENDPROC
1718: 
1719:     *==========================================================================
1720:     * Lookup Fornecedor por nome (somente quando Conta vazio)
1721:     *==========================================================================
1722:     PROCEDURE TxtDContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1723:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1724:             RETURN
1725:         ENDIF
1726:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
1727:             RETURN
1728:         ENDIF
1729:         LOCAL loc_cVal, loc_cGrupo, loc_cFiltroBA, loc_oBA, loc_oErro
1730:         loc_cVal    = ALLTRIM(THIS.txt_4c_DConta.Value)
1731:         loc_cGrupo  = THIS.this_oBusinessObject.this_cGrPadFors
1732:         loc_cFiltroBA = IIF(!EMPTY(loc_cGrupo), "CGrus = " + EscaparSQL(loc_cGrupo), "")
1733: 
1734:         IF !EMPTY(loc_cVal)
1735:             IF USED("cursor_4c_BuscaConta")
1736:                 USE IN cursor_4c_BuscaConta
1737:             ENDIF
1738:             IF SQLEXEC(gnConnHandle, ;
1739:                 "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE RTRIM(RClis) LIKE " + ;
1740:                 EscaparSQL(loc_cVal + "%") + ;
1741:                 IIF(!EMPTY(loc_cGrupo), " AND CGrus = " + EscaparSQL(loc_cGrupo), ""), ;
1742:                 "cursor_4c_BuscaConta") > 0
1743:                 SELECT cursor_4c_BuscaConta
1744:                 GO TOP
1745:                 IF !EOF("cursor_4c_BuscaConta")
1746:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1747:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1748:                     USE IN cursor_4c_BuscaConta
1749:                     RETURN
1750:                 ENDIF
1751:                 USE IN cursor_4c_BuscaConta
1752:             ENDIF
1753:         ENDIF
1754:         TRY
1755:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1756:                 "cursor_4c_BuscaConta", "RClis", loc_cVal, ;
1757:                 "Sele" + CHR(231) + CHR(227) + "o de Fornecedor", .T., .T., loc_cFiltroBA)
1758:             IF VARTYPE(loc_oBA) = "O"
1759:                 loc_oBA.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1760:                 loc_oBA.mAddColuna("RClis", "", "Nome")
1761:                 loc_oBA.Show()
1762:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1763:                     SELECT cursor_4c_BuscaConta
1764:                     GO TOP
1765:                     THIS.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaConta.IClis)
1766:                     THIS.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaConta.RClis)
1767:                 ELSE
1768:                     THIS.txt_4c_DConta.Value = ""
1769:                 ENDIF
1770:                 IF USED("cursor_4c_BuscaConta")
1771:                     USE IN cursor_4c_BuscaConta
1772:                 ENDIF
1773:             ENDIF
1774:         CATCH TO loc_oErro
1775:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1776:                     " PROC=" + loc_oErro.Procedure, "Erro TxtDContaKeyPress")
1777:         ENDTRY
1778:     ENDPROC
1779: 
1780:     *==========================================================================
1781:     * Lookup Promocao
1782:     *==========================================================================
1783:     PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1784:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1785:             RETURN
1786:         ENDIF
1787:         LOCAL loc_cVal, loc_oBA, loc_oErro
1788:         loc_cVal = ALLTRIM(THIS.txt_4c_Promo.Value)
1789:         IF !EMPTY(loc_cVal)
1790:             IF USED("cursor_4c_BuscaPromo")
1791:                 USE IN cursor_4c_BuscaPromo
1792:             ENDIF
1793:             IF SQLEXEC(gnConnHandle, ;
1794:                 "SELECT TOP 1 Promos FROM SigPrPmc WHERE Promos = " + ;
1795:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaPromo") > 0
1796:                 SELECT cursor_4c_BuscaPromo
1797:                 GO TOP
1798:                 IF !EOF("cursor_4c_BuscaPromo")
1799:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1800:                     USE IN cursor_4c_BuscaPromo
1801:                     RETURN
1802:                 ENDIF
1803:                 USE IN cursor_4c_BuscaPromo
1804:             ENDIF
1805:         ENDIF
1806:         TRY
1807:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrPmc", ;
1808:                 "cursor_4c_BuscaPromo", "Promos", loc_cVal, ;
1809:                 "Promo" + CHR(231) + CHR(227) + "o", .T., .T., "")
1810:             IF VARTYPE(loc_oBA) = "O"
1811:                 loc_oBA.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
1812:                 loc_oBA.Show()
1813:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaPromo")
1814:                     SELECT cursor_4c_BuscaPromo
1815:                     GO TOP
1816:                     THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPromo.Promos)
1817:                 ELSE
1818:                     THIS.txt_4c_Promo.Value = ""
1819:                 ENDIF
1820:                 IF USED("cursor_4c_BuscaPromo")
1821:                     USE IN cursor_4c_BuscaPromo
1822:                 ENDIF
1823:             ENDIF
1824:         CATCH TO loc_oErro
1825:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1826:                     " PROC=" + loc_oErro.Procedure, "Erro TxtPromoKeyPress")
1827:         ENDTRY
1828:     ENDPROC
1829: 
1830:     *==========================================================================
1831:     * Lookup generico de Moeda (reutilizado por varios campos)
1832:     *==========================================================================
1833:     PROTECTED PROCEDURE AbrirBuscaMoeda(par_oTxt)
1834:         LOCAL loc_cVal, loc_oBA, loc_oErro
1835:         loc_cVal = ALLTRIM(par_oTxt.Value)
1836:         IF !EMPTY(loc_cVal)
1837:             IF USED("cursor_4c_BuscaMoe")
1838:                 USE IN cursor_4c_BuscaMoe
1839:             ENDIF
1840:             IF SQLEXEC(gnConnHandle, ;
1841:                 "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1842:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaMoe") > 0
1843:                 SELECT cursor_4c_BuscaMoe
1844:                 GO TOP
1845:                 IF !EOF("cursor_4c_BuscaMoe")
1846:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1847:                     USE IN cursor_4c_BuscaMoe
1848:                     RETURN
1849:                 ENDIF
1850:                 USE IN cursor_4c_BuscaMoe
1851:             ENDIF
1852:         ENDIF
1853:         TRY
1854:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1855:                 "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas", .T., .T., "")
1856:             IF VARTYPE(loc_oBA) = "O"
1857:                 loc_oBA.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1858:                 loc_oBA.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1859:                 loc_oBA.Show()
1860:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1861:                     SELECT cursor_4c_BuscaMoe
1862:                     GO TOP
1863:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1864:                 ELSE
1865:                     par_oTxt.Value = ""
1866:                 ENDIF
1867:                 IF USED("cursor_4c_BuscaMoe")
1868:                     USE IN cursor_4c_BuscaMoe
1869:                 ENDIF
1870:             ENDIF
1871:         CATCH TO loc_oErro
1872:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1873:                     " PROC=" + loc_oErro.Procedure, "Erro AbrirBuscaMoeda")
1874:         ENDTRY
1875:     ENDPROC
1876: 
1877:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1878:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1879:             RETURN
1880:         ENDIF
1881:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moeda)
1882:     ENDPROC
1883: 
1884:     PROCEDURE TxtMoeCsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1885:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1886:             RETURN
1887:         ENDIF
1888:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCs)
1889:     ENDPROC
1890: 
1891:     PROCEDURE TxtMoeCusFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1892:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1893:             RETURN
1894:         ENDIF
1895:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusFs)
1896:     ENDPROC
1897: 
1898:     PROCEDURE TxtMoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1899:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1900:             RETURN
1901:         ENDIF
1902:         THIS.AbrirBuscaMoeda(THIS.txt_4c_Moedas)
1903:     ENDPROC
1904: 
1905:     PROCEDURE TxtMoeVsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1906:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1907:             RETURN
1908:         ENDIF
1909:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeVs)
1910:     ENDPROC
1911: 
1912:     PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1913:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1914:             RETURN
1915:         ENDIF
1916:         THIS.AbrirBuscaMoeda(THIS.txt_4c_MoeCusto)
1917:     ENDPROC
1918: 
1919:     *==========================================================================
1920:     * Lookup Feitio
1921:     *==========================================================================
1922:     PROCEDURE TxtCFtiosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1923:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1924:             RETURN
1925:         ENDIF
1926:         LOCAL loc_cVal, loc_oBA, loc_oErro
1927:         loc_cVal = ALLTRIM(THIS.txt_4c_CFtios.Value)
1928:         IF !EMPTY(loc_cVal)
1929:             IF USED("cursor_4c_BuscaFtio")
1930:                 USE IN cursor_4c_BuscaFtio
1931:             ENDIF
1932:             IF SQLEXEC(gnConnHandle, ;
1933:                 "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
1934:                 EscaparSQL(loc_cVal), "cursor_4c_BuscaFtio") > 0
1935:                 SELECT cursor_4c_BuscaFtio
1936:                 GO TOP
1937:                 IF !EOF("cursor_4c_BuscaFtio")
1938:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1939:                     USE IN cursor_4c_BuscaFtio
1940:                     RETURN
1941:                 ENDIF
1942:                 USE IN cursor_4c_BuscaFtio
1943:             ENDIF
1944:         ENDIF
1945:         TRY
1946:             loc_oBA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrFti", ;
1947:                 "cursor_4c_BuscaFtio", "Cods", loc_cVal, "Feitio", .T., .T., "")
1948:             IF VARTYPE(loc_oBA) = "O"
1949:                 loc_oBA.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
1950:                 loc_oBA.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1951:                 loc_oBA.Show()
1952:                 IF loc_oBA.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
1953:                     SELECT cursor_4c_BuscaFtio
1954:                     GO TOP
1955:                     THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
1956:                 ELSE
1957:                     THIS.txt_4c_CFtios.Value = ""
1958:                 ENDIF
1959:                 IF USED("cursor_4c_BuscaFtio")
1960:                     USE IN cursor_4c_BuscaFtio
1961:                 ENDIF
1962:             ENDIF
1963:         CATCH TO loc_oErro
1964:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1965:                     " PROC=" + loc_oErro.Procedure, "Erro TxtCFtiosKeyPress")
1966:         ENDTRY
1967:     ENDPROC
1968: 
1969:     *==========================================================================
1970:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1971:     *==========================================================================
1972:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1973:         LOCAL loc_i, loc_oControl
1974:         IF VARTYPE(par_oContainer) # "O"
1975:             RETURN
1976:         ENDIF
1977:         FOR loc_i = 1 TO par_oContainer.ControlCount
1978:             loc_oControl = par_oContainer.Controls(loc_i)
1979:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1980:                 THIS.TornarControlesVisiveis(loc_oControl)
1981:             ENDIF
1982:             IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
1983:                 LOOP
1984:             ENDIF
1985:             loc_oControl.Visible = .T.
1986:         ENDFOR
1987:     ENDPROC
1988: 
1989:     *==========================================================================
1990:     * ConfigurarPaginaLista - Form OPERACIONAL: consolida cabecalho, botoes,
1991:     * filtros e grade num unico layout (equivalente da "Page1 - Lista" dos CRUD)
1992:     *==========================================================================
1993:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1994:         LOCAL loc_lJaConfigurado
1995: 
1996:         loc_lJaConfigurado = PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5) ;
1997:                          AND PEMSTATUS(THIS, "cmg_4c_Botoes", 5) ;
1998:                          AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1999: 
2000:         IF !loc_lJaConfigurado
2001:             THIS.ConfigurarCabecalho()
2002:             THIS.ConfigurarBotoes()
2003:             THIS.ConfigurarFiltros()
2004:             THIS.ConfigurarGrade()
2005:         ENDIF
2006: 
2007:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
2008:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
2009:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
2010:         ENDIF
2011: 
2012:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2013:             SELECT cursor_4c_Produtos
2014:             GO TOP
2015:             THIS.grd_4c_Dados.Refresh()
2016:         ENDIF
2017:     ENDPROC
2018: 
2019:     *==========================================================================
2020:     * AlternarPagina - Form OPERACIONAL nao usa PageFrame com Page1/Page2.
2021:     * Todos os controles (filtros + grade + botoes) convivem no mesmo layout.
2022:     * O metodo mantem a assinatura padrao do pipeline reposicionando o foco
2023:     * no primeiro controle relevante (filtro ou grade) conforme par_nPagina.
2024:     *==========================================================================
2025:     PROCEDURE AlternarPagina(par_nPagina)
2026:         LOCAL loc_nPagina
2027: 
2028:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
2029: 
2030:         DO CASE
2031:         CASE loc_nPagina = 1
2032:             IF PEMSTATUS(THIS, "txt_4c_GrupoIni", 5) AND THIS.txt_4c_GrupoIni.Enabled
2033:                 THIS.txt_4c_GrupoIni.SetFocus()
2034:             ENDIF
2035:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Produtos")
2036:                 SELECT cursor_4c_Produtos
2037:                 GO TOP
2038:                 THIS.grd_4c_Dados.Refresh()
2039:             ENDIF
2040:         CASE loc_nPagina = 2
2041:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.grd_4c_Dados.Enabled
2042:                 THIS.grd_4c_Dados.SetFocus()
2043:             ENDIF
2044:         ENDCASE
2045: 
2046:         RETURN .T.
2047:     ENDPROC
2048: 
2049:     *==========================================================================
2050:     * CarregarLista - Inicializa o cursor do grid com estrutura vazia
2051:     * Form OPERACIONAL: dados sao populados via BtnProcessarClick, nao aqui.
2052:     *==========================================================================
2053:     PROCEDURE CarregarLista()
2054:         LOCAL loc_lSucesso, loc_oErro
2055:         loc_lSucesso = .F.
2056: 
2057:         TRY
2058:             SET NULL ON
2059:             IF USED("cursor_4c_Produtos")
2060:                 IF TABLEREVERT(.T., "cursor_4c_Produtos")
2061:                 ENDIF
2062:                 USE IN cursor_4c_Produtos
2063:             ENDIF
2064: 
2065:             CREATE CURSOR cursor_4c_Produtos ( ;
2066:                 lMarca  N(1) NULL, ;
2067:                 CPros   C(14) NULL, ;
2068:                 DPros   C(40) NULL, ;
2069:                 ValAnt  N(14,4) NULL, ;
2070:                 ValAtu  N(14,4) NULL, ;
2071:                 fCustos N(9,4) NULL, ;
2072:                 MoePcs  C(3) NULL, ;
2073:                 CustoFs N(14,4) NULL, ;
2074:                 Manual  N(1) NULL)
2075:             INDEX ON CPros TAG CPros
2076:             SET NULL OFF
2077: 
2078:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2079:                 THIS.grd_4c_Dados.ColumnCount = 5
2080:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Produtos"
2081:                 THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Produtos.lMarca"
2082:                 THIS.grd_4c_Dados.Column2.ControlSource = "cursor_4c_Produtos.CPros"
2083:                 THIS.grd_4c_Dados.Column3.ControlSource = "cursor_4c_Produtos.DPros"
2084:                 THIS.grd_4c_Dados.Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
2085:                 THIS.grd_4c_Dados.Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
2086:                 THIS.grd_4c_Dados.Refresh()
2087:             ENDIF
2088: 
2089:             THIS.AjustarBotoesPorModo()
2090: 
2091:             loc_lSucesso = .T.
2092:         CATCH TO loc_oErro
2093:             SET NULL OFF
2094:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
2095:                     " PROC=" + loc_oErro.Procedure, "Erro CarregarLista FormSigPrApr")
2096:         ENDTRY
2097: 
2098:         RETURN loc_lSucesso
2099:     ENDPROC
2100: 
2101:     *==========================================================================
2102:     * LimparCampos - Reseta todos os campos de filtro e esvazia o grid
2103:     *==========================================================================
2104:     PROCEDURE LimparCampos()
2105:         THIS.txt_4c_GrupoIni.Value  = ""
2106:         THIS.txt_4c_GrupoFim.Value  = ""
2107:         THIS.txt_4c_Colecao.Value   = ""
2108:         THIS.txt_4c_Conta.Value     = ""
2109:         THIS.txt_4c_DConta.Value    = ""
2110:         THIS.txt_4c_Promo.Value     = ""
2111:         THIS.txt_4c_Variacao.Value  = 0
2112:         THIS.txt_4c_Moeda.Value     = ""
2113:         THIS.txt_4c_MarkUp1.Value   = 0
2114:         THIS.txt_4c_MarkUp2.Value   = 0
2115:         THIS.txt_4c_Fator.Value     = 0
2116:         THIS.txt_4c_MoeCusto.Value  = ""
2117:         THIS.txt_4c_MoeCs.Value     = ""
2118:         THIS.txt_4c_MoeCusFs.Value  = ""
2119:         THIS.txt_4c_Moedas.Value    = ""
2120:         THIS.txt_4c_CFtios.Value    = ""
2121:         THIS.txt_4c_MoeVs.Value     = ""
2122:         THIS.chk_4c_IncCusts.Value  = 0
2123:         THIS.chk_4c_Limpar.Value    = 0
2124:         THIS.chk_4c_Ignorar.Value   = 0
2125:         THIS.chk_4c_Auditado.Value  = 0
2126: 
2127:         THIS.opt_4c_Tipo.Value = 1
2128:         THIS.OptTipoChange()
2129: 
2130:         IF PEMSTATUS(THIS, "img_4c_Foto", 5)
2131:             THIS.img_4c_Foto.Visible = .F.
2132:             THIS.img_4c_Foto.Picture = ""
2133:         ENDIF
2134: 
2135:         THIS.CarregarLista()
2136: 
2137:         THIS.txt_4c_GrupoIni.SetFocus()
2138:     ENDPROC
2139: 
2140:     *==========================================================================
2141:     * HabilitarCampos - Habilita ou desabilita campos de filtro
2142:     * par_lHabilitar: .T. = habilitar filtros (estado inicial / pos-Atualizar)
2143:     *                 .F. = desabilitar filtros (durante modo Auditado)
2144:     *==========================================================================
2145:     PROCEDURE HabilitarCampos(par_lHabilitar)
2146:         LOCAL loc_lHab
2147:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2148: 
2149:         THIS.txt_4c_GrupoIni.Enabled = loc_lHab
2150:         THIS.txt_4c_GrupoFim.Enabled = loc_lHab
2151:         THIS.txt_4c_Colecao.Enabled  = loc_lHab
2152:         THIS.txt_4c_Moeda.Enabled    = loc_lHab
2153:         THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
2154:         THIS.opt_4c_Tipo.Enabled     = loc_lHab
2155: 
2156:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2157:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab
2158:         ENDIF
2159: 
2160:         THIS.Refresh()
2161:     ENDPROC
2162: 
2163:     *==========================================================================
2164:     * AjustarBotoesPorModo - Controla estados dos botoes baseado no grid
2165:     * Processar: sempre habilitado (a menos que em modo Auditado)
2166:     * Atualizar: habilitado somente quando ha produtos processados no grid
2167:     *==========================================================================
2168:     PROCEDURE AjustarBotoesPorModo()
2169:         LOCAL loc_lTemProdutos, loc_lModoAuditado
2170: 
2171:         loc_lTemProdutos  = USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2172:         loc_lModoAuditado = PEMSTATUS(THIS, "chk_4c_Auditado", 5) ;
2173:                         AND THIS.chk_4c_Auditado.Value = 1
2174: 
2175:         IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2176:             THIS.cmg_4c_Botoes.Buttons(1).Enabled = !loc_lModoAuditado
2177:             THIS.cmg_4c_Botoes.Buttons(2).Enabled = loc_lTemProdutos
2178:             THIS.cmg_4c_Botoes.Refresh()
2179:         ENDIF
2180:     ENDPROC
2181: 
2182: ENDDEFINE

