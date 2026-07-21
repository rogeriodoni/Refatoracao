# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Sub Grp' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGPRCOM.Pagina.Dados): Top original=100 vs migrado 'obj_4c_Opc_situacao' Top=5 (diff=95px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGPRCOM.Pagina.Dados): Left original=555 vs migrado 'obj_4c_Opc_situacao' Left=5 (diff=550px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2452 linhas total):

*-- Linhas 8 a 52:
8: *   Page2 (Dados) - Campos do produto + gradei (SigCdMax) para edicao de maximos
9: *
10: * CHAMADA EXTERNA:
11: *   CREATEOBJECT("Formsigprcom")                          -> modo normal (lista)
12: *   CREATEOBJECT("Formsigprcom", cCPros, "", cEsc, ...)  -> modo externo (produto fixo)
13: *==============================================================================
14: 
15: DEFINE CLASS Formsigprcom AS FormBase
16: 
17:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
18:     Height       = 675
19:     Width        = 1000
20:     Caption      = "Estoque Maximo"
21:     AutoCenter   = .T.
22:     ShowWindow   = 1
23:     WindowType   = 1
24:     ControlBox   = .F.
25:     Closable     = .F.
26:     MaxButton    = .F.
27:     TitleBar     = 0
28:     ClipControls = .F.
29:     Themes       = .F.
30:     BorderStyle  = 2
31:     FontName     = "Tahoma"
32:     ForeColor    = RGB(90, 90, 90)
33:     DataSession  = 2
34: 
35:     *-- Business Object e estado
36:     this_oBusinessObject = .NULL.
37:     this_cMensagemErro   = ""
38:     this_cModoAtual      = "LISTA"
39: 
40:     *-- Propriedades de chamada externa (equivalentes as propriedades legadas pProduto/pcExterno)
41:     this_cPProduto  = ""   && c" + CHR(243) + "digo do produto quando chamado externamente
42:     this_cPExterno  = ""   && identificador do chamador externo (pcEsc)
43:     this_cPCPros    = ""   && c" + CHR(243) + "digo do produto padded (14 chars)
44:     this_cPDPros    = ""   && descri" + CHR(231) + CHR(227) + "o do produto
45:     this_cPCGrus    = ""   && c" + CHR(243) + "digo do grupo
46:     this_cPIFors    = ""   && c" + CHR(243) + "digo do fornecedor
47:     this_cPReffs    = ""   && refer" + CHR(234) + "ncia do produto
48:     this_lPCancelar = .F.  && indica" + CHR(231) + CHR(227) + "o de cancelamento
49: 
50:     *-- Propriedades de controle de varia" + CHR(231) + CHR(245) + "es do produto
51:     this_lTemCor    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de cor
52:     this_lTemTam    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de tamanho

*-- Linhas 61 a 146:
61:     *--------------------------------------------------------------------------
62:     * Init - Inicializa form; suporta chamada externa com par" + CHR(226) + "metros de produto
63:     *--------------------------------------------------------------------------
64:     PROCEDURE Init()
65:         LOCAL loc_lSucesso
66:         loc_lSucesso = .F.
67: 
68:         LPARAMETERS par_cAcesso, par_cPcForm, par_cPcEsc, par_cPDPros, par_cPCGrus, par_cPIFors, par_cPReffs
69: 
70:         TRY
71:             *-- Capturar par" + CHR(226) + "metros de chamada externa ANTES de DODEFAULT
72:             IF TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
73:                 THIS.this_cPProduto = ALLTRIM(par_cAcesso)
74:                 THIS.this_cPCPros   = PADR(ALLTRIM(par_cAcesso), 14)
75:             ENDIF
76: 
77:             IF TYPE("par_cPcEsc") = "C" AND !EMPTY(par_cPcEsc) ;
78:                AND TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
79:                 THIS.this_cPExterno = par_cPcEsc
80:                 THIS.this_cPDPros   = TratarNulo(par_cPDPros, "C")
81:                 THIS.this_cPCGrus   = TratarNulo(par_cPCGrus, "C")
82:                 THIS.this_cPIFors   = TratarNulo(par_cPIFors, "C")
83:                 THIS.this_cPReffs   = TratarNulo(par_cPReffs, "C")
84:             ENDIF
85: 
86:             *-- DODEFAULT() chama FormBase.Init() que chama THIS.InicializarForm()
87:             loc_lSucesso = DODEFAULT()
88: 
89:         CATCH TO loc_oErro
90:             MsgErro("Erro em Formsigprcom.Init: " + loc_oErro.Message, "Erro")
91:             loc_lSucesso = .F.
92:         ENDTRY
93: 
94:         RETURN loc_lSucesso
95:     ENDPROC
96: 
97:     *--------------------------------------------------------------------------
98:     * InicializarForm - Configura" + CHR(231) + CHR(227) + "o inicial do formulario
99:     * Chamado automaticamente por FormBase.Init() via DODEFAULT()
100:     *--------------------------------------------------------------------------
101:     PROTECTED PROCEDURE InicializarForm()
102:         LOCAL loc_lSucesso
103:         loc_lSucesso = .F.
104: 
105:         TRY
106:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")
107: 
108:             IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ISNULL(THIS.this_oBusinessObject)
109:                 MostrarErro("Erro ao criar Business Object sigprcomBO", "Erro Cr" + CHR(237) + "tico")
110:             ELSE
111:                 *-- Corrigir Caption com acento (CHR nao pode ser usado em DEFINE CLASS)
112:                 THIS.Caption = "Estoque M" + CHR(225) + "ximo"
113: 
114:                 THIS.ConfigurarPageFrame()
115:                 THIS.ConfigurarPaginaLista()
116:                 THIS.ConfigurarPaginaDados()
117: 
118:                 *-- Propagar Caption para labels do cabe" + CHR(231) + "alho
119:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
120:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
121: 
122:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
123:                     *-- Modo externo: produto j" + CHR(225) + " definido, ir direto para Page2
124:                     IF !EMPTY(THIS.this_cPCPros)
125:                         THIS.this_cPCEscolha = "ALTERAR"
126:                         THIS.this_cModoAtual  = "DADOS"
127:                         THIS.pgf_4c_Paginas.Visible    = .T.
128:                         THIS.pgf_4c_Paginas.ActivePage = 2
129:                         *-- Fases 5-8 completam carga dos dados do produto no Dados
130:                     ELSE
131:                         *-- Modo normal: listar produtos na Page1
132:                         IF !THIS.CarregarLista()
133:                             *-- Falha ao carregar nao impede abertura
134:                         ENDIF
135:                         THIS.pgf_4c_Paginas.Visible    = .T.
136:                         THIS.pgf_4c_Paginas.ActivePage = 1
137:                         THIS.this_cModoAtual = "LISTA"
138:                     ENDIF
139:                 ELSE
140:                     THIS.pgf_4c_Paginas.Visible    = .T.
141:                     THIS.pgf_4c_Paginas.ActivePage = 1
142:                 ENDIF
143: 
144:                 loc_lSucesso = .T.
145:             ENDIF
146: 

*-- Linhas 157 a 239:
157:     * ConfigurarPageFrame - Configura PageFrame principal
158:     * PageFrame.Top=-29 para ocultar abas; controles compensam +29 no Top
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarPageFrame()
161:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
162: 
163:         WITH THIS.pgf_4c_Paginas
164:             .Top       = -29
165:             .Left      = 0
166:             .Width     = 1003
167:             .Height    = 704   && 675 (form.Height) + 29 (compensacao abas)
168:             .PageCount = 2
169:             .Tabs      = .F.
170:             .Visible   = .F.
171:         ENDWITH
172: 
173:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
174:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
175:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
176: 
177:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
178:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
179:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------
183:     * ConfigurarPaginaLista - Configura Page1 (Lista de produtos)
184:     * Fase 3: containers principais; Fase 4 adiciona grid e bot" + CHR(245) + "es CRUD
185:     *--------------------------------------------------------------------------
186:     PROTECTED PROCEDURE ConfigurarPaginaLista()
187:         LOCAL loc_oPagina
188:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
189: 
190:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
191:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
192: 
193:         *-- Cabe" + CHR(231) + "alho (equivalente ao cntSombra do legado)
194:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
195:         WITH loc_oPagina.cnt_4c_Cabecalho
196:             .Top         = 1 + 29   && compensacao PageFrame (cntSombra.Top=1)
197:             .Left        = -1
198:             .Width       = 1008
199:             .Height      = 80
200:             .BackColor   = RGB(100, 100, 100)
201:             .BorderWidth = 0
202:             .Visible     = .T.
203:         ENDWITH
204: 
205:         *-- Label sombra (offset 2px para efeito de sombra)
206:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
207:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
208:             .AutoSize  = .F.
209:             .Top       = 15
210:             .Left      = 12
211:             .Width     = 980
212:             .Height    = 40
213:             .Caption   = THIS.Caption
214:             .FontName  = "Tahoma"
215:             .FontSize  = 16
216:             .FontBold  = .T.
217:             .ForeColor = RGB(0, 0, 0)
218:             .BackStyle = 0
219:             .Visible   = .T.
220:         ENDWITH
221: 
222:         *-- Label titulo (branco sobre fundo escuro)
223:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
224:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
225:             .AutoSize  = .F.
226:             .Top       = 18
227:             .Left      = 10
228:             .Width     = 980
229:             .Height    = 46
230:             .Caption   = THIS.Caption
231:             .FontName  = "Tahoma"
232:             .FontSize  = 16
233:             .FontBold  = .T.
234:             .ForeColor = RGB(255, 255, 255)
235:             .BackStyle = 0
236:             .Visible   = .T.
237:         ENDWITH
238: 
239:         *-- Container de bot" + CHR(245) + "es CRUD (equivalente ao Grupo_op do legado)

*-- Linhas 805 a 875:
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         THIS.TornarControlesVisiveis(loc_oPagina)
809: 
810:         *-- ===== BINDEVENTs dos botoes CRUD (Page1) =====
811:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,    "Click", THIS, "BtnIncluirClick")
812:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
813:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
814:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
815:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
816:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
817:         BINDEVENT(loc_oPagina.cmd_4c_BtnCopiar,                "Click", THIS, "BtnCopiarClick")
818: 
819:         *-- BINDEVENTs dos botoes do painel de copia
820:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarCopiaClick")
821:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar,   "Click", THIS, "BtnConfirmarCopiaClick")
822:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair,     "Click", THIS, "BtnSairCopiaClick")
823:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar,      "Click", THIS, "BtnMarcarCopiaClick")
824:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar,   "Click", THIS, "BtnDesmarcarCopiaClick")
825: 
826:         *-- BINDEVENT para LostFocus de EmpOs (habilita EmpDs quando preenchido)
827:         BINDEVENT(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOsLostFocus")
828:     ENDPROC
829: 
830:     *--------------------------------------------------------------------------
831:     * ConfigurarPaginaDados - Configura Page2 (Dados do produto + grade de maximos)
832:     * Fase 5: botoes acao + labels + textboxes produto/grupo + optiongroup situacao
833:     * Fase 6: textboxes fornecedor/ref + botao excluir + gradei
834:     *--------------------------------------------------------------------------
835:     PROTECTED PROCEDURE ConfigurarPaginaDados()
836:         LOCAL loc_oPagina
837:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
838: 
839:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
840:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
841: 
842:         *-- Container de botoes de acao (Confirmar/Cancelar)
843:         *-- Grupo_Salva.Left=843, Grupo_Salva.Top=-3 + 29 = 26
844:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
845:         WITH loc_oPagina.cnt_4c_BotoesAcao
846:             .Top         = -3 + 29   && 26
847:             .Left        = 843
848:             .Width       = 160
849:             .Height      = 85
850:             .BackStyle   = 0
851:             .BorderWidth = 0
852:             .Visible     = .T.
853:         ENDWITH
854: 
855:         *-- Botao Confirmar (salva maximos e volta para lista)
856:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
857:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
858:             .Top             = 5
859:             .Left            = 5
860:             .Width           = 75
861:             .Height          = 75
862:             .Caption         = "Confirmar"
863:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
864:             .PicturePosition = 13
865:             .FontName        = "Tahoma"
866:             .FontSize        = 8
867:             .FontBold        = .T.
868:             .FontItalic      = .T.
869:             .ForeColor       = RGB(90, 90, 90)
870:             .BackColor       = RGB(255, 255, 255)
871:             .Themes          = .F.
872:             .SpecialEffect   = 0
873:             .WordWrap        = .T.
874:             .MousePointer    = 15
875:             .Visible         = .T.

*-- Linhas 1043 a 1088:
1043:             .Visible   = .T.
1044:         ENDWITH
1045: 
1046:         *-- ===== OPTIONGROUP Situacao (Opc_situacao) - somente leitura (When=.F. no legado) =====
1047:         *-- top=100+29=129, left=555, width=117, height=25; ButtonCount=2 (1=Ativo, 2=Inativo)
1048:         loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1049:         WITH loc_oPagina.obj_4c_Opc_situacao
1050:             .Top         = 100 + 29
1051:             .Left        = 555
1052:             .Width       = 117
1053:             .Height      = 25
1054:             .ButtonCount = 2
1055:             .BackStyle   = 0
1056:             .BorderStyle = 0
1057:             .Value       = 1
1058:             .Visible     = .T.
1059:             WITH .Buttons(1)
1060:                 .Caption   = "Ativo"
1061:                 .Left      = 5
1062:                 .Top       = 5
1063:                 .Width     = 50
1064:                 .AutoSize  = .T.
1065:                 .ForeColor = RGB(90, 90, 90)
1066:                 .Themes    = .F.
1067:             ENDWITH
1068:             WITH .Buttons(2)
1069:                 .Caption   = "Inativo"
1070:                 .Left      = 58
1071:                 .Top       = 5
1072:                 .Width     = 55
1073:                 .AutoSize  = .T.
1074:                 .FontName  = "Tahoma"
1075:                 .FontSize  = 8
1076:                 .ForeColor = RGB(90, 90, 90)
1077:                 .Themes    = .F.
1078:             ENDWITH
1079:         ENDWITH
1080: 
1081:         *-- ===== TEXTBOXES - FORNECEDOR/REFERENCIA (Fase 6) =====
1082:         *-- txt_4c_Ifor: codigo do fornecedor - somente leitura (top=130+29=159)
1083:         loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
1084:         WITH loc_oPagina.txt_4c_Ifor
1085:             .Top       = 130 + 29
1086:             .Left      = 309
1087:             .Width     = 80
1088:             .Height    = 23

*-- Linhas 1253 a 1318:
1253:             ENDWITH
1254:         ENDWITH
1255: 
1256:         THIS.TornarControlesVisiveis(loc_oPagina)
1257: 
1258:         *-- BINDEVENTs dos botoes de Page2
1259:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1260:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1261: 
1262:         *-- BINDEVENT para busca de produto via F4
1263:         BINDEVENT(loc_oPagina.txt_4c__produto, "KeyPress", THIS, "ProdutoKeyPress")
1264: 
1265:         *-- BINDEVENTs da grade de maximos (Fase 6)
1266:         BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir,             "Click",             THIS, "BtnExcluirGradeClick")
1267:         BINDEVENT(loc_oPagina.grd_4c_Gradei,                 "AfterRowColChange", THIS, "GradeIAfterRowColChange")
1268:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column2.Text1,   "KeyPress",         THIS, "QmaxsLostFocus")
1269:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column3.Text1,   "KeyPress",          THIS, "TamKeyPress")
1270:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column4.Text1,   "KeyPress",          THIS, "CorKeyPress")
1271:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",          THIS, "DptKeyPress")
1272:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",         THIS, "GradeICol5LostFocus")
1273:     ENDPROC
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * CarregarLista - Carrega cursor de produtos na Page1 e configura grid
1277:     *--------------------------------------------------------------------------
1278:     PROCEDURE CarregarLista()
1279:         LOCAL loc_lResultado, loc_oGrid
1280:         loc_lResultado = .F.
1281: 
1282:         TRY
1283:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1284:                 loc_lResultado = .T.
1285:             ELSE
1286:                 IF THIS.this_oBusinessObject.Buscar("")
1287:                     IF USED("cursor_4c_Dados")
1288:                         GO TOP IN cursor_4c_Dados
1289: 
1290:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1291: 
1292:                         *-- RecordSource FORA de WITH (Problema 36 - garante colunas existentes)
1293:                         *-- Estrutura identica ao legado: cpros, dpros, ifors, reffs, sgrus (5 colunas)
1294:                         loc_oGrid.ColumnCount = 5
1295:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1296: 
1297:                         *-- ControlSource de cada coluna (identico ao legado)
1298:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
1299:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
1300:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ifors"
1301:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.reffs"
1302:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.sgrus"
1303: 
1304:                         *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
1305:                         *-- Identicos ao legado (pColuna: Produto, Descricao, Fornecedor, Referencia, Sub Grp)
1306:                         loc_oGrid.Column1.Header1.Caption = "Produto"
1307:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1308:                         loc_oGrid.Column3.Header1.Caption = "Fornecedor"
1309:                         loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
1310:                         loc_oGrid.Column5.Header1.Caption = "Sub Grp"
1311: 
1312:                         THIS.FormatarGridLista(loc_oGrid)
1313:                         loc_lResultado = .T.
1314:                     ENDIF
1315:                 ENDIF
1316:             ENDIF
1317: 
1318:         CATCH TO loc_oErro

*-- Linhas 1324 a 1841:
1324:     ENDPROC
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * TornarControlesVisiveis - Torna todos os controles de um container visiveis
1328:     * Itera recursivamente Pages e Controls
1329:     *--------------------------------------------------------------------------
1330:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1331:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
1332:         loc_cNome = ""
1333: 
1334:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1335:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1336: 
1337:             IF VARTYPE(loc_oObjeto) = "O"
1338:                 loc_cNome = UPPER(loc_oObjeto.Name)
1339: 
1340:                 *-- Containers flutuantes/ocultos por design: recursar filhos mas NAO forcar Visible
1341:                 IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
1342:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1343:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1344:                     ENDIF
1345:                     LOOP
1346:                 ENDIF
1347: 
1348:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1349:                     loc_oObjeto.Visible = .T.
1350:                 ENDIF
1351: 
1352:                 *-- Tratar PageFrame: iterar Pages
1353:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1354:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1355:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1356:                     ENDFOR
1357:                 ENDIF
1358: 
1359:                 *-- Tratar containers com ControlCount
1360:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1361:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1362:                 ENDIF
1363:             ENDIF
1364:         ENDFOR
1365:     ENDPROC
1366: 
1367:     *--------------------------------------------------------------------------
1368:     * FormatarGridLista - Formata visual do grid da lista de produtos
1369:     *--------------------------------------------------------------------------
1370:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1371:         WITH par_oGrid
1372:             .FontName = "Tahoma"
1373:             .FontSize = 8
1374:         ENDWITH
1375:     ENDPROC
1376: 
1377:     *--------------------------------------------------------------------------
1378:     * Destroy - Libera recursos
1379:     *--------------------------------------------------------------------------
1380:     PROCEDURE Destroy()
1381:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1382:             THIS.this_oBusinessObject = .NULL.
1383:         ENDIF
1384: 
1385:         IF USED("cursor_4c_Dados")
1386:             USE IN cursor_4c_Dados
1387:         ENDIF
1388: 
1389:         IF USED("cursor_4c_Max")
1390:             USE IN cursor_4c_Max
1391:         ENDIF
1392: 
1393:         IF USED("cursor_4c_Copia")
1394:             USE IN cursor_4c_Copia
1395:         ENDIF
1396: 
1397:         DODEFAULT()
1398:     ENDPROC
1399: 
1400:     *--------------------------------------------------------------------------
1401:     * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
1402:     *--------------------------------------------------------------------------
1403:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1404:         TRY
1405:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1406:             IF par_nPagina = 1
1407:                 THIS.this_cModoAtual = "LISTA"
1408:             ELSE
1409:                 THIS.this_cModoAtual = "DADOS"
1410:                 THIS.AjustarCamposPorModo()
1411:             ENDIF
1412:         CATCH TO loc_oErro
1413:             MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * BtnIncluirClick - Navega para Page2 em modo INSERIR
1419:     *--------------------------------------------------------------------------
1420:     PROCEDURE BtnIncluirClick()
1421:         TRY
1422:             THIS.this_cPCEscolha = "INSERIR"
1423:             THIS.LimparCampos()
1424:             THIS.CarregarGradeMaximos("")
1425:             THIS.AlternarPagina(2)
1426:         CATCH TO loc_oErro
1427:             MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message, "Erro")
1428:         ENDTRY
1429:     ENDPROC
1430: 
1431:     *--------------------------------------------------------------------------
1432:     * BtnVisualizarClick - Visualiza produto selecionado em Page2
1433:     *--------------------------------------------------------------------------
1434:     PROCEDURE BtnVisualizarClick()
1435:         LOCAL loc_lResultado, loc_cCpros
1436:         loc_lResultado = .F.
1437:         loc_cCpros     = ""
1438: 
1439:         TRY
1440:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1441:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1442:                 IF EMPTY(loc_cCpros)
1443:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1444:                 ELSE
1445:                     THIS.this_cPCPros    = PADR(loc_cCpros, 14)
1446:                     THIS.this_cPCEscolha = "CONSULTAR"
1447:                     THIS.CarregarInfoProduto(loc_cCpros)
1448:                     THIS.AlternarPagina(2)
1449:                     loc_lResultado = .T.
1450:                 ENDIF
1451:             ELSE
1452:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1453:             ENDIF
1454:         CATCH TO loc_oErro
1455:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1456:         ENDTRY
1457: 
1458:         RETURN loc_lResultado
1459:     ENDPROC
1460: 
1461:     *--------------------------------------------------------------------------
1462:     * BtnAlterarClick - Abre produto selecionado para edicao em Page2
1463:     *--------------------------------------------------------------------------
1464:     PROCEDURE BtnAlterarClick()
1465:         LOCAL loc_lResultado, loc_cCpros
1466:         loc_lResultado = .F.
1467:         loc_cCpros     = ""
1468: 
1469:         TRY
1470:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1471:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1472:                 IF EMPTY(loc_cCpros)
1473:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1474:                 ELSE
1475:                     THIS.this_cPCPros    = PADR(loc_cCpros, 14)
1476:                     THIS.this_cPCEscolha = "ALTERAR"
1477:                     THIS.CarregarInfoProduto(loc_cCpros)
1478:                     THIS.AlternarPagina(2)
1479:                     loc_lResultado = .T.
1480:                 ENDIF
1481:             ELSE
1482:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1483:             ENDIF
1484:         CATCH TO loc_oErro
1485:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message, "Erro")
1486:         ENDTRY
1487: 
1488:         RETURN loc_lResultado
1489:     ENDPROC
1490: 
1491:     *--------------------------------------------------------------------------
1492:     * BtnExcluirClick - Exclui todos os maximos do produto selecionado
1493:     *--------------------------------------------------------------------------
1494:     PROCEDURE BtnExcluirClick()
1495:         LOCAL loc_lResultado, loc_cCpros, loc_nResult
1496:         loc_lResultado = .F.
1497:         loc_cCpros     = ""
1498:         loc_nResult    = 0
1499: 
1500:         TRY
1501:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1502:                 loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
1503:                 IF EMPTY(loc_cCpros)
1504:                     MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1505:                 ELSE
1506:                     IF MsgConfirma("Excluir todos os m" + CHR(225) + "ximos do produto " + loc_cCpros + "?", ;
1507:                             "Confirmar Exclus" + CHR(227) + "o")
1508:                         loc_nResult = SQLEXEC(gnConnHandle, ;
1509:                             "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(PADR(loc_cCpros, 14)))
1510:                         IF loc_nResult > 0
1511:                             MsgInfo("M" + CHR(225) + "ximos exclu" + CHR(237) + "dos com sucesso.", "Sucesso")
1512:                             THIS.CarregarLista()
1513:                             loc_lResultado = .T.
1514:                         ELSE
1515:                             MsgErro("Erro ao excluir m" + CHR(225) + "ximos do produto.", "Erro")
1516:                         ENDIF
1517:                     ENDIF
1518:                 ENDIF
1519:             ELSE
1520:                 MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1521:             ENDIF
1522:         CATCH TO loc_oErro
1523:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message, "Erro")
1524:         ENDTRY
1525: 
1526:         RETURN loc_lResultado
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * BtnBuscarClick - Navega para Page2 em modo PROCURAR
1531:     *--------------------------------------------------------------------------
1532:     PROCEDURE BtnBuscarClick()
1533:         TRY
1534:             THIS.this_cPCEscolha = "PROCURAR"
1535:             THIS.AlternarPagina(2)
1536:         CATCH TO loc_oErro
1537:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * BtnEncerrarClick - Fecha o formulario
1543:     *--------------------------------------------------------------------------
1544:     PROCEDURE BtnEncerrarClick()
1545:         TRY
1546:             THIS.Release()
1547:         CATCH TO loc_oErro
1548:             MsgErro("Erro em BtnEncerrarClick: " + loc_oErro.Message, "Erro")
1549:         ENDTRY
1550:     ENDPROC
1551: 
1552:     *--------------------------------------------------------------------------
1553:     * LimparCampos - Limpa campos de Page2 (primeira metade; Fase 6 completa restante)
1554:     *--------------------------------------------------------------------------
1555:     PROTECTED PROCEDURE LimparCampos()
1556:         LOCAL loc_oPagina
1557:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1558: 
1559:         TRY
1560:             loc_oPagina.txt_4c__produto.Value       = ""
1561:             loc_oPagina.txt_4c_Dpro.Value           = ""
1562:             loc_oPagina.txt_4c_Cgru.Value           = ""
1563:             loc_oPagina.txt_4c_Dgru.Value           = ""
1564:             loc_oPagina.obj_4c_Opc_situacao.Value   = 1
1565: 
1566:             loc_oPagina.txt_4c_Ifor.Value           = ""
1567:             loc_oPagina.txt_4c_Dfor.Value           = ""
1568:             loc_oPagina.txt_4c_Refs.Value           = ""
1569:             loc_oPagina.grd_4c_Gradei.RecordSource  = ""
1570: 
1571:             IF USED("cursor_4c_Max")
1572:                 USE IN cursor_4c_Max
1573:             ENDIF
1574: 
1575:             THIS.this_cPCPros    = ""
1576:             THIS.this_nTipoEstos = 0
1577:             THIS.this_lTemTam    = .F.
1578:             THIS.this_lTemCor    = .F.
1579:         CATCH TO loc_oErro
1580:             MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
1581:         ENDTRY
1582:     ENDPROC
1583: 
1584:     *--------------------------------------------------------------------------
1585:     * BtnCopiarClick - Exibe painel de copia entre empresas
1586:     *--------------------------------------------------------------------------
1587:     PROCEDURE BtnCopiarClick()
1588:         LOCAL loc_oPagina
1589:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1590: 
1591:         TRY
1592:             IF !THIS.this_lAcCopiar
1593:                 MsgAviso("Voc" + CHR(234) + " n" + CHR(227) + "o tem permiss" + CHR(227) + "o para copiar entre empresas.", "Acesso Negado")
1594:             ELSE
1595:                 loc_oPagina.grd_4c_Lista.Visible     = .F.
1596:                 loc_oPagina.cnt_4c_Botoes.Visible    = .F.
1597:                 loc_oPagina.cnt_4c_Saida.Visible     = .F.
1598:                 loc_oPagina.cmd_4c_BtnCopiar.Visible = .F.
1599: 
1600:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value   = ""
1601:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1602:                 loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value = ""
1603:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1604: 
1605:                 IF USED("cursor_4c_Copia")
1606:                     USE IN cursor_4c_Copia
1607:                 ENDIF
1608:                 loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
1609: 
1610:                 loc_oPagina.cnt_4c_Copia.Visible = .T.
1611:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.SetFocus()
1612:             ENDIF
1613:         CATCH TO loc_oErro
1614:             MsgErro("Erro em BtnCopiarClick: " + loc_oErro.Message, "Erro")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     *--------------------------------------------------------------------------
1619:     * EmpOsLostFocus - Habilita txt_4c_EmpDs quando EmpOs estiver preenchida
1620:     *--------------------------------------------------------------------------
1621:     PROCEDURE EmpOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1622:         LOCAL loc_oPagina, loc_cEmpOs
1623:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1624:         loc_cEmpOs  = ""
1625: 
1626:         TRY
1627:             loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1628:             IF EMPTY(loc_cEmpOs)
1629:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1630:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1631:             ELSE
1632:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .T.
1633:             ENDIF
1634:         CATCH TO loc_oErro
1635:             MsgErro("Erro em EmpOsLostFocus: " + loc_oErro.Message, "Erro")
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *--------------------------------------------------------------------------
1640:     * BtnProcessarCopiaClick - Processa e exibe itens disponiveis para copia
1641:     *--------------------------------------------------------------------------
1642:     PROCEDURE BtnProcessarCopiaClick()
1643:         LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs, loc_cProduto, loc_oGrid
1644:         loc_lResultado = .F.
1645:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1646:         loc_cEmpOs     = ""
1647:         loc_cEmpDs     = ""
1648:         loc_cProduto   = ""
1649: 
1650:         TRY
1651:             loc_cEmpOs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1652:             loc_cEmpDs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
1653:             loc_cProduto = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value)
1654: 
1655:             IF EMPTY(loc_cEmpOs)
1656:                 MsgAviso("Informe a Empresa Origem.", "Aten" + CHR(231) + CHR(227) + "o")
1657:             ELSE
1658:                 IF EMPTY(loc_cEmpDs)
1659:                     MsgAviso("Informe a Empresa Destino.", "Aten" + CHR(231) + CHR(227) + "o")
1660:                 ELSE
1661:                     IF THIS.this_oBusinessObject.CarregarCopiaParaCursor(PADR(loc_cProduto, 14), PADR(loc_cEmpOs, 3), PADR(loc_cEmpDs, 3))
1662:                         IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1663:                             loc_oGrid = loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
1664: 
1665:                             *-- RecordSource FORA de WITH (Problema 36)
1666:                             loc_oGrid.ColumnCount = 6
1667:                             loc_oGrid.RecordSource = "cursor_4c_Copia"
1668:                             loc_oGrid.Column1.ControlSource = "cursor_4c_Copia.marcas"
1669:                             loc_oGrid.Column2.ControlSource = "cursor_4c_Copia.cpros"
1670:                             loc_oGrid.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
1671:                             loc_oGrid.Column4.ControlSource = "cursor_4c_Copia.codtams"
1672:                             loc_oGrid.Column5.ControlSource = "cursor_4c_Copia.codcores"
1673:                             loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"
1674: 
1675:                             *-- Headers: re-setar apos RecordSource (VFP9 reseta)
1676:                             loc_oGrid.Column1.Header1.Caption = ""
1677:                             loc_oGrid.Column2.Header1.Caption = "Produto"
1678:                             loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1679:                             loc_oGrid.Column4.Header1.Caption = "Tam"
1680:                             loc_oGrid.Column5.Header1.Caption = "Cor"
1681:                             loc_oGrid.Column6.Header1.Caption = "Departamento"
1682: 
1683:                             GO TOP IN cursor_4c_Copia
1684:                             loc_lResultado = .T.
1685:                         ELSE
1686:                             MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")
1687:                         ENDIF
1688:                     ELSE
1689:                         MsgErro("Erro ao carregar dados: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1690:                     ENDIF
1691:                 ENDIF
1692:             ENDIF
1693:         CATCH TO loc_oErro
1694:             MsgErro("Erro em BtnProcessarCopiaClick: " + loc_oErro.Message, "Erro")
1695:         ENDTRY
1696: 
1697:         RETURN loc_lResultado
1698:     ENDPROC
1699: 
1700:     *--------------------------------------------------------------------------
1701:     * BtnConfirmarCopiaClick - Confirma e executa a copia entre empresas
1702:     *--------------------------------------------------------------------------
1703:     PROCEDURE BtnConfirmarCopiaClick()
1704:         LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs
1705:         loc_lResultado = .F.
1706:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1707:         loc_cEmpOs     = ""
1708:         loc_cEmpDs     = ""
1709: 
1710:         TRY
1711:             loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
1712:             loc_cEmpDs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
1713: 
1714:             IF !USED("cursor_4c_Copia") OR RECCOUNT("cursor_4c_Copia") = 0
1715:                 MsgAviso("Processe os dados antes de confirmar a c" + CHR(243) + "pia.", "Aten" + CHR(231) + CHR(227) + "o")
1716:             ELSE
1717:                 IF MsgConfirma("Confirmar c" + CHR(243) + "pia dos m" + CHR(225) + "ximos de " + ;
1718:                         loc_cEmpOs + " para " + loc_cEmpDs + "?", "Confirmar C" + CHR(243) + "pia")
1719:                     IF THIS.this_oBusinessObject.CopiarMaxEntreEmpresas(PADR(loc_cEmpDs, 3), "cursor_4c_Copia")
1720:                         MsgInfo("C" + CHR(243) + "pia realizada com sucesso.", "Sucesso")
1721:                         THIS.BtnSairCopiaClick()
1722:                         loc_lResultado = .T.
1723:                     ELSE
1724:                         MsgErro("Erro ao copiar m" + CHR(225) + "ximos: " + ;
1725:                             THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1726:                     ENDIF
1727:                 ENDIF
1728:             ENDIF
1729:         CATCH TO loc_oErro
1730:             MsgErro("Erro em BtnConfirmarCopiaClick: " + loc_oErro.Message, "Erro")
1731:         ENDTRY
1732: 
1733:         RETURN loc_lResultado
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * BtnSairCopiaClick - Fecha painel de copia e restaura controles principais
1738:     *--------------------------------------------------------------------------
1739:     PROCEDURE BtnSairCopiaClick()
1740:         LOCAL loc_oPagina
1741:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1742: 
1743:         TRY
1744:             loc_oPagina.cnt_4c_Copia.Visible     = .F.
1745:             loc_oPagina.grd_4c_Lista.Visible      = .T.
1746:             loc_oPagina.cnt_4c_Botoes.Visible     = .T.
1747:             loc_oPagina.cnt_4c_Saida.Visible      = .T.
1748:             loc_oPagina.cmd_4c_BtnCopiar.Visible  = .T.
1749: 
1750:             IF USED("cursor_4c_Copia")
1751:                 USE IN cursor_4c_Copia
1752:             ENDIF
1753:         CATCH TO loc_oErro
1754:             MsgErro("Erro em BtnSairCopiaClick: " + loc_oErro.Message, "Erro")
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * BtnMarcarCopiaClick - Marca todos os itens para copia
1760:     *--------------------------------------------------------------------------
1761:     PROCEDURE BtnMarcarCopiaClick()
1762:         TRY
1763:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1764:                 REPLACE ALL marcas WITH 1 IN cursor_4c_Copia
1765:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1766:             ENDIF
1767:         CATCH TO loc_oErro
1768:             MsgErro("Erro em BtnMarcarCopiaClick: " + loc_oErro.Message, "Erro")
1769:         ENDTRY
1770:     ENDPROC
1771: 
1772:     *--------------------------------------------------------------------------
1773:     * BtnDesmarcarCopiaClick - Desmarca todos os itens da copia
1774:     *--------------------------------------------------------------------------
1775:     PROCEDURE BtnDesmarcarCopiaClick()
1776:         TRY
1777:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
1778:                 REPLACE ALL marcas WITH 0 IN cursor_4c_Copia
1779:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
1780:             ENDIF
1781:         CATCH TO loc_oErro
1782:             MsgErro("Erro em BtnDesmarcarCopiaClick: " + loc_oErro.Message, "Erro")
1783:         ENDTRY
1784:     ENDPROC
1785: 
1786:     *--------------------------------------------------------------------------
1787:     * BtnSalvarClick - Confirma e salva os maximos do produto (Grupo_Salva.Confirmar)
1788:     * Logica: valida produto, limpa linhas vazias do cursor, salva via BO
1789:     *--------------------------------------------------------------------------
1790:     PROCEDURE BtnSalvarClick()
1791:         LOCAL loc_lResultado, loc_oPagina, loc_cCpros
1792:         loc_lResultado = .F.
1793:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1794:         loc_cCpros     = ""
1795: 
1796:         TRY
1797:             loc_cCpros = ALLTRIM(loc_oPagina.txt_4c__produto.Value)
1798: 
1799:             IF INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
1800:                 IF THIS.this_cPCEscolha = "INSERIR" AND EMPTY(loc_cCpros)
1801:                     MsgAviso("Produto inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
1802:                     loc_oPagina.txt_4c__produto.SetFocus()
1803:                 ELSE
1804:                     *-- Remover linhas com empresa vazia do cursor de maximos (limpeza antes de salvar)
1805:                     IF USED("cursor_4c_Max") AND RECCOUNT("cursor_4c_Max") > 0
1806:                         SELECT cursor_4c_Max
1807:                         GO TOP
1808:                         SCAN
1809:                             IF EMPTY(ALLTRIM(cursor_4c_Max.emps))
1810:                                 DELETE IN cursor_4c_Max
1811:                             ENDIF
1812:                         ENDSCAN
1813:                     ENDIF
1814: 
1815:                     IF THIS.this_oBusinessObject.SalvarGradeMax(PADR(loc_cCpros, 14))
1816:                         MsgInfo("M" + CHR(225) + "ximos salvos com sucesso.", "Sucesso")
1817:                         IF !EMPTY(THIS.this_cPExterno)
1818:                             THIS.Release()
1819:                         ELSE
1820:                             THIS.AlternarPagina(1)
1821:                             THIS.CarregarLista()
1822:                         ENDIF
1823:                         loc_lResultado = .T.
1824:                     ELSE
1825:                         MsgErro("Erro ao salvar m" + CHR(225) + "ximos: " + ;
1826:                             THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
1827:                     ENDIF
1828:                 ENDIF
1829:             ELSE
1830:                 *-- Modo CONSULTAR/PROCURAR: apenas navegar de volta
1831:                 IF !EMPTY(THIS.this_cPExterno)
1832:                     THIS.Release()
1833:                 ELSE
1834:                     THIS.AlternarPagina(1)
1835:                     THIS.CarregarLista()
1836:                 ENDIF
1837:                 loc_lResultado = .T.
1838:             ENDIF
1839: 
1840:         CATCH TO loc_oErro
1841:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message, "Erro")

*-- Linhas 1847 a 1955:
1847:     *--------------------------------------------------------------------------
1848:     * BtnCancelarClick - Cancela edicao e volta para lista
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE BtnCancelarClick()
1851:         TRY
1852:             THIS.this_lPCancelar = .T.
1853:             IF !EMPTY(THIS.this_cPExterno)
1854:                 THIS.Release()
1855:             ELSE
1856:                 THIS.AlternarPagina(1)
1857:                 THIS.CarregarLista()
1858:             ENDIF
1859:         CATCH TO loc_oErro
1860:             MsgErro("Erro em BtnCancelarClick: " + loc_oErro.Message, "Erro")
1861:         ENDTRY
1862:     ENDPROC
1863: 
1864:     *--------------------------------------------------------------------------
1865:     * ProdutoKeyPress - Handler de teclado para txt_4c__produto
1866:     * F4 (115): abre FormBuscaAuxiliar para busca de produto na SigCdPro
1867:     *--------------------------------------------------------------------------
1868:     PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1869:         LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCpros
1870:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1871:         loc_cCpros  = ""
1872: 
1873:         IF !INLIST(par_nKeyCode, 13, 9, 115)
1874:             RETURN
1875:         ENDIF
1876: 
1877:         IF par_nKeyCode = 115   && F4
1878:             TRY
1879:                 loc_cValor = ALLTRIM(loc_oPagina.txt_4c__produto.Value)
1880: 
1881:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1882:                     "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValor, "Produtos")
1883: 
1884:                 IF VARTYPE(loc_oBusca) = "O"
1885:                     IF !loc_oBusca.this_lAchouRegistro
1886:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1887:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1888:                         loc_oBusca.Show()
1889:                     ENDIF
1890: 
1891:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1892:                         loc_cCpros = ALLTRIM(cursor_4c_BuscaProd.cpros)
1893:                         loc_oPagina.txt_4c__produto.Value = loc_cCpros
1894:                         THIS.this_cPCPros = PADR(loc_cCpros, 14)
1895:                         THIS.CarregarInfoProduto(loc_cCpros)
1896:                     ENDIF
1897: 
1898:                     loc_oBusca.Release()
1899:                 ENDIF
1900: 
1901:                 IF USED("cursor_4c_BuscaProd")
1902:                     USE IN cursor_4c_BuscaProd
1903:                 ENDIF
1904:             CATCH TO loc_oErro
1905:                 MsgErro("Erro ao buscar produto: " + loc_oErro.Message, "Erro")
1906:             ENDTRY
1907:         ENDIF
1908:     ENDPROC
1909: 
1910:     *--------------------------------------------------------------------------
1911:     * CarregarInfoProduto - Carrega dados do produto na Page2
1912:     * Popula: cpros, dpros, cgrus, dgrus, situas, tiposestos (Fase 5)
1913:     *         ifors, rclis, reffs serao populados na Fase 6
1914:     *--------------------------------------------------------------------------
1915:     PROTECTED PROCEDURE CarregarInfoProduto(par_cCpros)
1916:         LOCAL loc_lResultado, loc_oPagina, loc_cSQL, loc_nResult
1917:         loc_lResultado = .F.
1918:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1919: 
1920:         IF EMPTY(ALLTRIM(par_cCpros))
1921:             RETURN .F.
1922:         ENDIF
1923: 
1924:         TRY
1925:             loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus," + ;
1926:                        " p.ifors, c.Rclis AS rclis, p.reffs, p.Situas, p.varias" + ;
1927:                        " FROM SigCdPro p" + ;
1928:                        " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
1929:                        " LEFT JOIN SigCdCli c ON c.Iclis = p.ifors" + ;
1930:                        " WHERE p.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
1931: 
1932:             IF USED("cursor_4c_ProdInfo")
1933:                 USE IN cursor_4c_ProdInfo
1934:             ENDIF
1935: 
1936:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")
1937: 
1938:             IF loc_nResult > 0 AND USED("cursor_4c_ProdInfo") AND RECCOUNT("cursor_4c_ProdInfo") > 0
1939:                 SELECT cursor_4c_ProdInfo
1940:                 GO TOP
1941: 
1942:                 loc_oPagina.txt_4c__produto.Value = ALLTRIM(cursor_4c_ProdInfo.cpros)
1943:                 loc_oPagina.txt_4c_Dpro.Value     = ALLTRIM(cursor_4c_ProdInfo.dpros)
1944:                 loc_oPagina.txt_4c_Cgru.Value     = ALLTRIM(cursor_4c_ProdInfo.cgrus)
1945:                 loc_oPagina.txt_4c_Dgru.Value     = TratarNulo(cursor_4c_ProdInfo.dgrus, "C")
1946: 
1947:                 THIS.this_nTipoEstos = NVL(cursor_4c_ProdInfo.varias, 0)
1948:                 THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 1, 3)
1949:                 THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 3)
1950: 
1951:                 loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(cursor_4c_ProdInfo.Situas, 1) = 2, 2, 1)
1952: 
1953:                 loc_oPagina.txt_4c_Ifor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.ifors, "C"))
1954:                 loc_oPagina.txt_4c_Dfor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.rclis, "C"))
1955:                 loc_oPagina.txt_4c_Refs.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.reffs, "C"))

*-- Linhas 1974 a 2044:
1974:     *--------------------------------------------------------------------------
1975:     * AjustarCamposPorModo - Habilita/desabilita campos e grade conforme modo
1976:     *--------------------------------------------------------------------------
1977:     PROCEDURE AjustarCamposPorModo()
1978:         LOCAL loc_oPagina, loc_lEditar
1979:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1980:         loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
1981: 
1982:         TRY
1983:             *-- Produto editavel apenas em INSERIR
1984:             loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR")
1985:             loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR", ;
1986:                 RGB(255, 255, 255), RGB(220, 220, 220))
1987: 
1988:             *-- Grade editavel em INSERIR/ALTERAR; botao excluir visivel idem
1989:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
1990:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
1991: 
1992:             *-- Colunas de variacao somente se produto tem a caracteristica
1993:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
1994:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
1995:         CATCH TO loc_oErro
1996:             MsgErro("Erro em AjustarCamposPorModo: " + loc_oErro.Message, "Erro")
1997:         ENDTRY
1998:     ENDPROC
1999: 
2000:     *--------------------------------------------------------------------------
2001:     * CarregarGradeMaximos - Carrega cursor_4c_Max e vincula a grd_4c_Gradei
2002:     * par_cCpros vazio = modo INSERIR (cursor vazio)
2003:     *--------------------------------------------------------------------------
2004:     PROTECTED PROCEDURE CarregarGradeMaximos(par_cCpros)
2005:         LOCAL loc_lResultado, loc_oPagina, loc_oGrid
2006:         loc_lResultado = .F.
2007:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
2008: 
2009:         TRY
2010:             IF !EMPTY(ALLTRIM(par_cCpros))
2011:                 IF THIS.this_oBusinessObject.CarregarMaxPorProduto(par_cCpros)
2012:                     loc_lResultado = .T.
2013:                 ELSE
2014:                     THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
2015:                 ENDIF
2016:             ELSE
2017:                 *-- Modo INSERIR: criar cursor vazio editavel
2018:                 IF USED("cursor_4c_Max")
2019:                     USE IN cursor_4c_Max
2020:                 ENDIF
2021:                 SET NULL ON
2022:                 CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
2023:                     codtams C(4), codcores C(4), deptos C(10), ordems C(1))
2024:                 SET NULL OFF
2025:                 loc_lResultado = .T.
2026:             ENDIF
2027: 
2028:             IF loc_lResultado AND USED("cursor_4c_Max")
2029:                 loc_oGrid = loc_oPagina.grd_4c_Gradei
2030: 
2031:                 *-- RecordSource e ControlSources FORA de WITH (Problema 36)
2032:                 loc_oGrid.ColumnCount = 5
2033:                 loc_oGrid.RecordSource               = "cursor_4c_Max"
2034:                 loc_oGrid.Column1.ControlSource      = "cursor_4c_Max.emps"
2035:                 loc_oGrid.Column2.ControlSource      = "cursor_4c_Max.qmaxs"
2036:                 loc_oGrid.Column3.ControlSource      = "cursor_4c_Max.codtams"
2037:                 loc_oGrid.Column4.ControlSource      = "cursor_4c_Max.codcores"
2038:                 loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"
2039: 
2040:                 *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
2041:                 loc_oGrid.Column1.Header1.Caption = "Emp"
2042:                 loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
2043:                 loc_oGrid.Column3.Header1.Caption = "Tamanho"
2044:                 loc_oGrid.Column4.Header1.Caption = "Cor"

*-- Linhas 2063 a 2452:
2063:     *--------------------------------------------------------------------------
2064:     * GradeINovaLinha - Insere linha vazia no cursor_4c_Max e posiciona grade
2065:     *--------------------------------------------------------------------------
2066:     PROCEDURE GradeINovaLinha()
2067:         LOCAL loc_cEmps
2068:         loc_cEmps = ""
2069: 
2070:         TRY
2071:             IF !USED("cursor_4c_Max")
2072:                 RETURN
2073:             ENDIF
2074: 
2075:             loc_cEmps = IIF(!EMPTY(ALLTRIM(go_4c_Sistema.cCodEmpresa)), ;
2076:                 PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3), SPACE(3))
2077: 
2078:             INSERT INTO cursor_4c_Max ;
2079:                 (cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems) ;
2080:                 VALUES (SPACE(20), loc_cEmps, 0, SPACE(4), SPACE(4), SPACE(10), SPACE(1))
2081: 
2082:             GO BOTTOM IN cursor_4c_Max
2083:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2084:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.SetFocus()
2085:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.DoScroll(2)
2086:         CATCH TO loc_oErro
2087:             MsgErro("Erro em GradeINovaLinha: " + loc_oErro.Message, "Erro")
2088:         ENDTRY
2089:     ENDPROC
2090: 
2091:     *--------------------------------------------------------------------------
2092:     * GradeIAfterRowColChange - Ajusta colunas de variacao; adiciona linha ao final
2093:     *--------------------------------------------------------------------------
2094:     PROCEDURE GradeIAfterRowColChange(par_nColIndex)
2095:         TRY
2096:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
2097:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
2098: 
2099:             IF USED("cursor_4c_Max") AND INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
2100:                 SELECT cursor_4c_Max
2101:                 IF EOF()
2102:                     THIS.GradeINovaLinha()
2103:                 ENDIF
2104:             ENDIF
2105:         CATCH TO loc_oErro
2106:             MsgErro("Erro em GradeIAfterRowColChange: " + loc_oErro.Message, "Erro")
2107:         ENDTRY
2108:     ENDPROC
2109: 
2110:     *--------------------------------------------------------------------------
2111:     * QmaxsLostFocus - Valida quantidade maxima (nao pode ser negativa)
2112:     *--------------------------------------------------------------------------
2113:     PROCEDURE QmaxsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2114:         TRY
2115:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2116:                 SELECT cursor_4c_Max
2117:                 IF NVL(cursor_4c_Max.qmaxs, 0) < 0
2118:                     REPLACE cursor_4c_Max.qmaxs WITH 0
2119:                 ENDIF
2120:             ENDIF
2121:         CATCH TO loc_oErro
2122:             MsgErro("Erro em QmaxsLostFocus: " + loc_oErro.Message, "Erro")
2123:         ENDTRY
2124:     ENDPROC
2125: 
2126:     *--------------------------------------------------------------------------
2127:     * TamKeyPress - F4 abre lookup SigCdTam para coluna de tamanho
2128:     *--------------------------------------------------------------------------
2129:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2130:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2131:             RETURN
2132:         ENDIF
2133:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2134:             THIS.AbrirLookupTamanho()
2135:         ENDIF
2136:     ENDPROC
2137: 
2138:     *--------------------------------------------------------------------------
2139:     * AbrirLookupTamanho - FormBuscaAuxiliar para SigCdTam (ctams/dtams)
2140:     *--------------------------------------------------------------------------
2141:     PROCEDURE AbrirLookupTamanho()
2142:         LOCAL loc_oBusca, loc_cValor
2143:         loc_cValor = ""
2144: 
2145:         TRY
2146:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2147:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codtams, "C"))
2148:             ENDIF
2149: 
2150:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2151:                 "SigCdTam", "cursor_4c_BuscaTam", "ctams", loc_cValor, "Tamanhos")
2152: 
2153:             IF VARTYPE(loc_oBusca) = "O"
2154:                 IF !loc_oBusca.this_lAchouRegistro
2155:                     loc_oBusca.mAddColuna("ctams", "", "C" + CHR(243) + "digo")
2156:                     loc_oBusca.mAddColuna("dtams", "", "Descri" + CHR(231) + CHR(227) + "o")
2157:                     loc_oBusca.Show()
2158:                 ENDIF
2159: 
2160:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
2161:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2162:                         SELECT cursor_4c_Max
2163:                         REPLACE codtams WITH PADR(ALLTRIM(cursor_4c_BuscaTam.ctams), 4)
2164:                     ENDIF
2165:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2166:                 ENDIF
2167: 
2168:                 loc_oBusca.Release()
2169:             ENDIF
2170: 
2171:             IF USED("cursor_4c_BuscaTam")
2172:                 USE IN cursor_4c_BuscaTam
2173:             ENDIF
2174:         CATCH TO loc_oErro
2175:             MsgErro("Erro ao buscar tamanho: " + loc_oErro.Message, "Erro")
2176:         ENDTRY
2177:     ENDPROC
2178: 
2179:     *--------------------------------------------------------------------------
2180:     * CorKeyPress - F4 abre lookup SigCdCor para coluna de cor
2181:     *--------------------------------------------------------------------------
2182:     PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2183:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2184:             RETURN
2185:         ENDIF
2186:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2187:             THIS.AbrirLookupCor()
2188:         ENDIF
2189:     ENDPROC
2190: 
2191:     *--------------------------------------------------------------------------
2192:     * AbrirLookupCor - FormBuscaAuxiliar para SigCdCor (ccors/dcors)
2193:     *--------------------------------------------------------------------------
2194:     PROCEDURE AbrirLookupCor()
2195:         LOCAL loc_oBusca, loc_cValor
2196:         loc_cValor = ""
2197: 
2198:         TRY
2199:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2200:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codcores, "C"))
2201:             ENDIF
2202: 
2203:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2204:                 "SigCdCor", "cursor_4c_BuscaCor", "ccors", loc_cValor, "Cores")
2205: 
2206:             IF VARTYPE(loc_oBusca) = "O"
2207:                 IF !loc_oBusca.this_lAchouRegistro
2208:                     loc_oBusca.mAddColuna("ccors", "", "C" + CHR(243) + "digo")
2209:                     loc_oBusca.mAddColuna("dcors", "", "Descri" + CHR(231) + CHR(227) + "o")
2210:                     loc_oBusca.Show()
2211:                 ENDIF
2212: 
2213:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2214:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2215:                         SELECT cursor_4c_Max
2216:                         REPLACE codcores WITH PADR(ALLTRIM(cursor_4c_BuscaCor.ccors), 4)
2217:                     ENDIF
2218:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2219:                 ENDIF
2220: 
2221:                 loc_oBusca.Release()
2222:             ENDIF
2223: 
2224:             IF USED("cursor_4c_BuscaCor")
2225:                 USE IN cursor_4c_BuscaCor
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             MsgErro("Erro ao buscar cor: " + loc_oErro.Message, "Erro")
2229:         ENDTRY
2230:     ENDPROC
2231: 
2232:     *--------------------------------------------------------------------------
2233:     * DptKeyPress - F4 abre lookup SigCdDpt para coluna de departamento
2234:     *--------------------------------------------------------------------------
2235:     PROCEDURE DptKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2236:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2237:             RETURN
2238:         ENDIF
2239:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2240:             THIS.AbrirLookupDepto()
2241:         ENDIF
2242:     ENDPROC
2243: 
2244:     *--------------------------------------------------------------------------
2245:     * AbrirLookupDepto - FormBuscaAuxiliar para SigCdDpt (codigos/descricaos)
2246:     *--------------------------------------------------------------------------
2247:     PROCEDURE AbrirLookupDepto()
2248:         LOCAL loc_oBusca, loc_cValor
2249:         loc_cValor = ""
2250: 
2251:         TRY
2252:             IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2253:                 loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.deptos, "C"))
2254:             ENDIF
2255: 
2256:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2257:                 "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValor, "Departamentos")
2258: 
2259:             IF VARTYPE(loc_oBusca) = "O"
2260:                 IF !loc_oBusca.this_lAchouRegistro
2261:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2262:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2263:                     loc_oBusca.Show()
2264:                 ENDIF
2265: 
2266:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
2267:                     IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
2268:                         SELECT cursor_4c_Max
2269:                         REPLACE deptos WITH PADR(ALLTRIM(cursor_4c_BuscaDpt.codigos), 10)
2270:                     ENDIF
2271:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2272:                 ENDIF
2273: 
2274:                 loc_oBusca.Release()
2275:             ENDIF
2276: 
2277:             IF USED("cursor_4c_BuscaDpt")
2278:                 USE IN cursor_4c_BuscaDpt
2279:             ENDIF
2280:         CATCH TO loc_oErro
2281:             MsgErro("Erro ao buscar departamento: " + loc_oErro.Message, "Erro")
2282:         ENDTRY
2283:     ENDPROC
2284: 
2285:     *--------------------------------------------------------------------------
2286:     * GradeICol5LostFocus - Refresh da grade ao sair da coluna departamento
2287:     *--------------------------------------------------------------------------
2288:     PROCEDURE GradeICol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2289:         TRY
2290:             IF USED("cursor_4c_Max")
2291:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2292:             ENDIF
2293:         CATCH TO loc_oErro
2294:             MsgErro("Erro em GradeICol5LostFocus: " + loc_oErro.Message, "Erro")
2295:         ENDTRY
2296:     ENDPROC
2297: 
2298:     *--------------------------------------------------------------------------
2299:     * BtnExcluirGradeClick - Exclui todas as linhas da empresa corrente no cursor
2300:     *--------------------------------------------------------------------------
2301:     PROCEDURE BtnExcluirGradeClick()
2302:         LOCAL loc_cEmps
2303:         loc_cEmps = ""
2304: 
2305:         TRY
2306:             IF !USED("cursor_4c_Max") OR RECCOUNT("cursor_4c_Max") = 0
2307:                 RETURN
2308:             ENDIF
2309: 
2310:             IF !MsgConfirma("Excluir todos os m" + CHR(225) + "ximos desta empresa?", ;
2311:                     "Confirmar Exclus" + CHR(227) + "o")
2312:                 RETURN
2313:             ENDIF
2314: 
2315:             SELECT cursor_4c_Max
2316:             IF !EOF() AND !BOF()
2317:                 loc_cEmps = ALLTRIM(TratarNulo(cursor_4c_Max.emps, "C"))
2318:             ENDIF
2319: 
2320:             IF EMPTY(loc_cEmps)
2321:                 loc_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
2322:             ENDIF
2323: 
2324:             SELECT cursor_4c_Max
2325:             GO TOP
2326:             SCAN
2327:                 IF ALLTRIM(cursor_4c_Max.emps) = loc_cEmps
2328:                     DELETE
2329:                 ENDIF
2330:             ENDSCAN
2331:             PACK
2332: 
2333:             IF RECCOUNT("cursor_4c_Max") = 0
2334:                 THIS.GradeINovaLinha()
2335:             ENDIF
2336: 
2337:             THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
2338:         CATCH TO loc_oErro
2339:             MsgErro("Erro em BtnExcluirGradeClick: " + loc_oErro.Message, "Erro")
2340:         ENDTRY
2341:     ENDPROC
2342: 
2343:     *--------------------------------------------------------------------------
2344:     * FormParaBO - Transfere valores do Form para o Business Object
2345:     * Campos de display (dpros, dgrus, rclis) sao read-only; apenas cpros e
2346:     * derivados sao transferidos porque o BO os usa em SalvarGradeMax
2347:     *--------------------------------------------------------------------------
2348:     PROTECTED PROCEDURE FormParaBO()
2349:         LOCAL loc_oPagina
2350:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2351: 
2352:         TRY
2353:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2354:                 THIS.this_oBusinessObject.this_cCPros  = PADR(ALLTRIM(loc_oPagina.txt_4c__produto.Value), 14)
2355:                 THIS.this_oBusinessObject.this_cDPros  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
2356:                 THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(loc_oPagina.txt_4c_Cgru.Value)
2357:                 THIS.this_oBusinessObject.this_cDGrus  = ALLTRIM(loc_oPagina.txt_4c_Dgru.Value)
2358:                 THIS.this_oBusinessObject.this_cIFors  = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
2359:                 THIS.this_oBusinessObject.this_cRClis  = ALLTRIM(loc_oPagina.txt_4c_Dfor.Value)
2360:                 THIS.this_oBusinessObject.this_cReffs  = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
2361:                 THIS.this_oBusinessObject.this_nSituas = loc_oPagina.obj_4c_Opc_situacao.Value
2362:             ENDIF
2363:         CATCH TO loc_oErro
2364:             MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
2365:         ENDTRY
2366:     ENDPROC
2367: 
2368:     *--------------------------------------------------------------------------
2369:     * BOParaForm - Transfere valores do Business Object para o Form
2370:     * Popula campos de display da Page2 a partir das propriedades do BO
2371:     *--------------------------------------------------------------------------
2372:     PROTECTED PROCEDURE BOParaForm()
2373:         LOCAL loc_oPagina
2374:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2375: 
2376:         TRY
2377:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2378:                 loc_oPagina.txt_4c__produto.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCPros)
2379:                 loc_oPagina.txt_4c_Dpro.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDPros)
2380:                 loc_oPagina.txt_4c_Cgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cCGrus)
2381:                 loc_oPagina.txt_4c_Dgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDGrus)
2382:                 loc_oPagina.txt_4c_Ifor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cIFors)
2383:                 loc_oPagina.txt_4c_Dfor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cRClis)
2384:                 loc_oPagina.txt_4c_Refs.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cReffs)
2385:                 loc_oPagina.obj_4c_Opc_situacao.Value   = IIF(THIS.this_oBusinessObject.this_nSituas = 2, 2, 1)
2386: 
2387:                 THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
2388:                 THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
2389:                 THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
2390:             ENDIF
2391:         CATCH TO loc_oErro
2392:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
2393:         ENDTRY
2394:     ENDPROC
2395: 
2396:     *--------------------------------------------------------------------------
2397:     * HabilitarCampos - Habilita ou desabilita controles editaveis da Page2
2398:     * par_lHabilitar=.T. habilita conforme modo; .F. bloqueia tudo (VISUALIZAR)
2399:     *--------------------------------------------------------------------------
2400:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2401:         LOCAL loc_oPagina, loc_lEditar
2402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2403:         loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR") AND par_lHabilitar
2404: 
2405:         TRY
2406:             *-- Produto: editavel apenas em INSERIR
2407:             loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar)
2408:             loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar, ;
2409:                 RGB(255, 255, 255), RGB(220, 220, 220))
2410: 
2411:             *-- Grade: editavel apenas em INSERIR/ALTERAR
2412:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
2413:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
2414: 
2415:             *-- Colunas de variacao: habilitadas conforme caracteristica do produto
2416:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam OR !loc_lEditar
2417:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor OR !loc_lEditar
2418: 
2419:             *-- Botoes de acao Page2
2420:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
2421:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
2422:         CATCH TO loc_oErro
2423:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
2424:         ENDTRY
2425:     ENDPROC
2426: 
2427:     *--------------------------------------------------------------------------
2428:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1 (lista)
2429:     * Chamado apos CarregarLista para refletir se ha registros selecionaveis
2430:     *--------------------------------------------------------------------------
2431:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2432:         LOCAL loc_oPg1, loc_lTemSelecao
2433:         loc_oPg1        = THIS.pgf_4c_Paginas.Page1
2434:         loc_lTemSelecao = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2435: 
2436:         TRY
2437:             WITH loc_oPg1.cnt_4c_Botoes
2438:                 .cmd_4c_Inserir.Enabled    = .T.
2439:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
2440:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
2441:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
2442:                 .cmd_4c_Buscar.Enabled     = .T.
2443:                 .Visible     = .T.
2444:             ENDWITH
2445: 
2446:             loc_oPg1.cmd_4c_BtnCopiar.Enabled = THIS.this_lAcCopiar
2447:         CATCH TO loc_oErro
2448:             MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
2449:         ENDTRY
2450:     ENDPROC
2451: 
2452: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF
            IF USED("cursor_4c_CopiaTemp")
                USE IN cursor_4c_CopiaTemp
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopiaTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                *-- Necessario para permitir REPLACE ALL marcas no form
                SET NULL ON
                CREATE CURSOR cursor_4c_Copia (cpros C(14), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), existes N(1,0), marcas N(1,0))
                SET NULL OFF

                IF USED("cursor_4c_CopiaTemp") AND RECCOUNT("cursor_4c_CopiaTemp") > 0
                    APPEND FROM DBF("cursor_4c_CopiaTemp")
                ENDIF

                IF USED("cursor_4c_CopiaTemp")
                    USE IN cursor_4c_CopiaTemp
                ENDIF

                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

