# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (55)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=11 vs migrado 'lbl_4c_Say17' Top=86 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=91 vs migrado 'lbl_4c_Say17' Left=247 (diff=156px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=38 vs migrado 'lbl_4c_Say26' Top=105 (diff=67px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=23 vs migrado 'lbl_4c_Say26' Left=311 (diff=288px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say29' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=33 vs migrado 'lbl_4c_Say29' Left=477 (diff=444px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=11 vs migrado 'lbl_4c_Say34' Top=278 (diff=267px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=393 vs migrado 'lbl_4c_Say34' Left=131 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=395 vs migrado 'lbl_4c_Say16' Top=60 (diff=335px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say16' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=69 vs migrado 'lbl_4c_Say16' Left=344 (diff=275px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=345 vs migrado 'lbl_4c_Say5' Top=164 (diff=181px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=105 vs migrado 'lbl_4c_Say47' Top=425 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=90 vs migrado 'lbl_4c_Say47' Left=820 (diff=730px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=157 vs migrado 'lbl_4c_Say10' Top=34 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say10' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=34 vs migrado 'lbl_4c_Say10' Left=84 (diff=50px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say14' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=104 vs migrado 'lbl_4c_Say14' Top=34 (diff=70px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say14' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=481 vs migrado 'lbl_4c_Say14' Left=344 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=157 vs migrado 'lbl_4c_Say12' Top=86 (diff=71px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say12' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=284 vs migrado 'lbl_4c_Say12' Left=125 (diff=159px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=183 vs migrado 'lbl_4c_Say6' Top=239 (diff=56px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=812 vs migrado 'lbl_4c_Say6' Left=115 (diff=697px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=267 vs migrado 'lbl_4c_Say8' Top=57 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=104 vs migrado 'lbl_4c_Say8' Left=477 (diff=373px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=267 vs migrado 'lbl_4c_Say7' Top=6 (diff=261px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=296 vs migrado 'lbl_4c_Say7' Left=15 (diff=281px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=293 vs migrado 'lbl_4c_Say15' Top=60 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say15' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=85 vs migrado 'lbl_4c_Say15' Left=247 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say35' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=343 vs migrado 'lbl_4c_Say35' Top=217 (diff=126px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say35' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=562 vs migrado 'lbl_4c_Say35' Left=18 (diff=544px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say34' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=319 vs migrado 'lbl_4c_Say34' Top=278 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say34' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=565 vs migrado 'lbl_4c_Say34' Left=131 (diff=434px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say33' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=295 vs migrado 'lbl_4c_Say33' Top=259 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say33' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=587 vs migrado 'lbl_4c_Say33' Left=121 (diff=466px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say30' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=269 vs migrado 'lbl_4c_Say30' Top=108 (diff=161px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say30' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=589 vs migrado 'lbl_4c_Say30' Left=523 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say18' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=371 vs migrado 'lbl_4c_Say18' Top=86 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say18' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=77 vs migrado 'lbl_4c_Say18' Left=344 (diff=267px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say38' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=246 vs migrado 'lbl_4c_Say38' Top=298 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say38' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=498 vs migrado 'lbl_4c_Say38' Left=69 (diff=429px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say17' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=319 vs migrado 'lbl_4c_Say17' Top=86 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say13' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=207 vs migrado 'lbl_4c_Say13' Top=34 (diff=173px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=102 vs migrado 'lbl_4c_Say11' Top=60 (diff=42px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say11' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=791 vs migrado 'lbl_4c_Say11' Left=136 (diff=655px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say21' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Top original=210 vs migrado 'lbl_4c_Say21' Top=31 (diff=179px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say21' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=652 vs migrado 'lbl_4c_Say21' Left=490 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say39' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page1): Left original=827 vs migrado 'lbl_4c_Say39' Left=106 (diff=721px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=132 vs migrado 'lbl_4c_Say17' Top=86 (diff=46px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=479 vs migrado 'lbl_4c_Say17' Left=247 (diff=232px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=156 vs migrado 'lbl_4c_Say26' Top=105 (diff=51px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=390 vs migrado 'lbl_4c_Say26' Left=311 (diff=79px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=112 vs migrado 'lbl_4c_Say34' Top=278 (diff=166px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=77 vs migrado 'lbl_4c_Say34' Left=131 (diff=54px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Top original=138 vs migrado 'lbl_4c_Say47' Top=425 (diff=287px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDCFO.Pagina.Dados.PagDados.Page2): Left original=69 vs migrado 'lbl_4c_Say47' Left=820 (diff=751px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4260 linhas total):

*-- Linhas 26 a 170:
26: 
27:     *==========================================================================
28:     * Init - Inicializa o formulario (APENAS DODEFAULT)
29:     * FormBase.Init() chama InicializarForm() automaticamente
30:     *==========================================================================
31:     PROCEDURE Init()
32:         LOCAL loc_lSucesso
33:         loc_lSucesso = .F.
34:         TRY
35:             loc_lSucesso = DODEFAULT()
36:         CATCH TO loException
37:             MostrarErro("Erro ao inicializar Formcfo:" + CHR(13) + loException.Message, "Erro")
38:             loc_lSucesso = .F.
39:         ENDTRY
40:         RETURN loc_lSucesso
41:     ENDPROC
42: 
43:     *==========================================================================
44:     * InicializarForm - Configura estrutura completa do formulario
45:     * Chamado automaticamente pelo FormBase.Init()
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             *-- Criar Business Object
53:             THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar o objeto de neg" + CHR(243) + "cio cfoBO.", "Erro")
57:                 loc_lSucesso = .F.
58:             ELSE
59:                 *-- Configurar estrutura visual
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 *-- Tornar pageframe visivel e ativar pagina inicial
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68: 
69:                 *-- Carregar lista inicial (pular se validando UI sem banco)
70:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
71:                     THIS.CarregarLista()
72:                 ENDIF
73: 
74:                 loc_lSucesso = .T.
75:             ENDIF
76: 
77:         CATCH TO loException
78:             MostrarErro("Erro ao inicializar formulario Formcfo:" + CHR(13) + ;
79:                         loException.Message, "Erro")
80:             loc_lSucesso = .F.
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *==========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
88:     * Top=-29 oculta abas, exigindo compensacao +29 em todos controles internos
89:     *==========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame()
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount  = 2
94:             .Top        = -29
95:             .Left       = 0
96:             .Width      = 1000
97:             .Height     = 629
98:             .Tabs       = .F.
99:             .Page1.Caption   = "Lista"
100:             .Page2.Caption   = "Dados"
101:             .Page1.BackColor = RGB(234, 232, 228)
102:             .Page2.BackColor = RGB(234, 232, 228)
103:         ENDWITH
104:     ENDPROC
105: 
106:     *==========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 completa:
108:     *   - Container cabecalho escuro com titulo
109:     *   - Container botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
110:     *   - Container saida (Encerrar)
111:     *   - Botoes XML (Exporta/Importa)
112:     *   - Grid grd_4c_Lista com 2 colunas (codigos, descricaos)
113:     * Compensacao PageFrame: Top original + 29
114:     *==========================================================================
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina, loc_oGrid
117: 
118:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
119: 
120:         *----------------------------------------------------------------------
121:         * Container Cabecalho (fundo escuro com titulo)
122:         * Top=31 = original 2 + compensacao PageFrame 29
123:         *----------------------------------------------------------------------
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 31
127:             .Left        = 0
128:             .Width       = 935
129:             .Height      = 85
130:             .BackColor   = RGB(53, 53, 53)
131:             .BackStyle   = 1
132:             .BorderWidth = 0
133:             .BorderStyle = 0
134:             .Visible     = .T.
135:         ENDWITH
136: 
137:         *-- Label sombra (efeito 3D no titulo)
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = "Cadastro de CFOP"
141:             .Top       = 15
142:             .Left      = 11
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .Alignment = 0
151:         ENDWITH
152: 
153:         *-- Label titulo (branco sobre fundo escuro)
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = "Cadastro de CFOP"
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(255, 255, 255)
165:             .BackStyle = 0
166:             .Alignment = 0
167:         ENDWITH
168: 
169:         *----------------------------------------------------------------------
170:         * Container Botoes CRUD (Grupo_Op - lado DIREITO)

*-- Linhas 205 a 917:
205:             .WordWrap        = .T.
206:             .AutoSize        = .F.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         *-- Botao Visualizar
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
213:             .Caption         = "Visualizar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 80
218:             .Width           = 75
219:             .Height          = 75
220:             .BackColor       = RGB(255, 255, 255)
221:             .ForeColor       = RGB(90, 90, 90)
222:             .FontName        = "Comic Sans MS"
223:             .FontSize        = 8
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .AutoSize        = .F.
231:         ENDWITH
232:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         *-- Botao Alterar
235:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
236:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
237:             .Caption         = "Alterar"
238:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
239:             .PicturePosition = 13
240:             .Top             = 5
241:             .Left            = 155
242:             .Width           = 75
243:             .Height          = 75
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .FontName        = "Comic Sans MS"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .Themes          = .F.
251:             .SpecialEffect   = 0
252:             .MousePointer    = 15
253:             .WordWrap        = .T.
254:             .AutoSize        = .F.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .BackColor       = RGB(255, 255, 255)
269:             .ForeColor       = RGB(90, 90, 90)
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .FontBold        = .T.
273:             .FontItalic      = .T.
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:         ENDWITH
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         *-- Botao Buscar
283:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
284:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .Top             = 5
289:             .Left            = 305
290:             .Width           = 75
291:             .Height          = 75
292:             .BackColor       = RGB(255, 255, 255)
293:             .ForeColor       = RGB(90, 90, 90)
294:             .FontName        = "Comic Sans MS"
295:             .FontSize        = 8
296:             .FontBold        = .T.
297:             .FontItalic      = .T.
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .MousePointer    = 15
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *----------------------------------------------------------------------
307:         * Container Saida (botao X - extremo direito)
308:         *----------------------------------------------------------------------
309:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
310:         WITH loc_oPagina.cnt_4c_Saida
311:             .Top         = 29
312:             .Left        = 935
313:             .Width       = 60
314:             .Height      = 85
315:             .BackColor   = RGB(53, 53, 53)
316:             .BackStyle   = 1
317:             .BorderWidth = 0
318:             .BorderStyle = 0
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         *-- Botao Encerrar
323:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
324:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
325:             .Caption         = "Encerrar"
326:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
327:             .PicturePosition = 13
328:             .Top             = 5
329:             .Left            = 5
330:             .Width           = 50
331:             .Height          = 75
332:             .BackColor       = RGB(255, 255, 255)
333:             .ForeColor       = RGB(90, 90, 90)
334:             .FontName        = "Comic Sans MS"
335:             .FontSize        = 8
336:             .FontBold        = .T.
337:             .FontItalic      = .T.
338:             .Themes          = .F.
339:             .SpecialEffect   = 0
340:             .MousePointer    = 15
341:             .WordWrap        = .T.
342:             .AutoSize        = .F.
343:         ENDWITH
344:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
345: 
346:         *----------------------------------------------------------------------
347:         * Botoes XML (Exporta/Importa)
348:         * Top=114 = original 85 + compensacao 29
349:         * Original: btnExpXML.Left=3, btnImpXML.Left=127
350:         *----------------------------------------------------------------------
351:         loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
352:         WITH loc_oPagina.cmd_4c_ExpXML
353:             .Caption       = "Exporta XML"
354:             .Top           = 114
355:             .Left          = 3
356:             .Width         = 120
357:             .Height        = 40
358:             .BackColor     = RGB(234, 232, 228)
359:             .ForeColor     = RGB(0, 0, 0)
360:             .FontName      = "Tahoma"
361:             .FontSize      = 8
362:             .Themes        = .F.
363:             .SpecialEffect = 0
364:             .MousePointer  = 15
365:         ENDWITH
366:         BINDEVENT(loc_oPagina.cmd_4c_ExpXML, "Click", THIS, "BtnExpXMLClick")
367: 
368:         loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
369:         WITH loc_oPagina.cmd_4c_ImpXML
370:             .Caption       = "Importa XML"
371:             .Top           = 114
372:             .Left          = 127
373:             .Width         = 120
374:             .Height        = 40
375:             .BackColor     = RGB(234, 232, 228)
376:             .ForeColor     = RGB(0, 0, 0)
377:             .FontName      = "Tahoma"
378:             .FontSize      = 8
379:             .Themes        = .F.
380:             .SpecialEffect = 0
381:             .MousePointer  = 15
382:         ENDWITH
383:         BINDEVENT(loc_oPagina.cmd_4c_ImpXML, "Click", THIS, "BtnImpXMLClick")
384: 
385:         *----------------------------------------------------------------------
386:         * Cursor placeholder para o Grid
387:         * cursor_4c_Dados: codigos C(10), descricaos C(60), situas N(1,0)
388:         * O BO usa ZAP+APPEND para preservar as colunas existentes do grid
389:         *----------------------------------------------------------------------
390:         IF USED("cursor_4c_Dados")
391:             USE IN cursor_4c_Dados
392:         ENDIF
393:         SET NULL ON
394:         CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
395:         SET NULL OFF
396: 
397:         *----------------------------------------------------------------------
398:         * Grid grd_4c_Lista
399:         * Top=164 = original 135 + compensacao 29
400:         * Width=971, Height=448 (do analise.json ajustado)
401:         * RecordSource e ColumnCount FORA de WITH para criar colunas imediatamente
402:         *----------------------------------------------------------------------
403:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
404:         loc_oGrid = loc_oPagina.grd_4c_Lista
405: 
406:         loc_oGrid.Top                 = 164
407:         loc_oGrid.Left                = 12
408:         loc_oGrid.Width               = 971
409:         loc_oGrid.Height              = 445
410:         loc_oGrid.FontName            = "Verdana"
411:         loc_oGrid.FontSize            = 8
412:         loc_oGrid.ForeColor           = RGB(90, 90, 90)
413:         loc_oGrid.BackColor           = RGB(255, 255, 255)
414:         loc_oGrid.GridLineColor       = RGB(238, 238, 238)
415:         loc_oGrid.GridLines           = 3
416:         loc_oGrid.HighlightBackColor  = RGB(255, 255, 255)
417:         loc_oGrid.HighlightForeColor  = RGB(15, 41, 104)
418:         loc_oGrid.HighlightStyle      = 2
419:         loc_oGrid.DeleteMark          = .F.
420:         loc_oGrid.RecordMark          = .F.
421:         loc_oGrid.RowHeight           = 16
422:         loc_oGrid.ScrollBars          = 2
423:         loc_oGrid.ReadOnly            = .T.
424:         *-- RecordSource + ColumnCount FORA do WITH (cria colunas imediatamente)
425:         loc_oGrid.RecordSource = "cursor_4c_Dados"
426:         loc_oGrid.ColumnCount  = 2
427:         *-- Configurar colunas APOS RecordSource
428:         loc_oGrid.Column1.ControlSource        = "cursor_4c_Dados.codigos"
429:         loc_oGrid.Column1.Width                = 80
430:         loc_oGrid.Column1.Header1.Caption      = "C" + CHR(243) + "digo"
431:         loc_oGrid.Column1.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
432:         loc_oGrid.Column2.ControlSource        = "cursor_4c_Dados.descricaos"
433:         loc_oGrid.Column2.Width                = 400
434:         loc_oGrid.Column2.Header1.Caption      = "Descri" + CHR(231) + CHR(227) + "o"
435:         loc_oGrid.Column2.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
436: 
437:         *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
438:         THIS.TornarControlesVisiveis(loc_oPagina)
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * ConfigurarPaginaDados - Configura Page2 (Formulario de dados do CFOP)
443:     * Contem: botoes Salvar/Cancelar + PageFrame interno com 2 sub-paginas fiscais
444:     * Os campos serao adicionados na Fase 5
445:     *==========================================================================
446:     PROTECTED PROCEDURE ConfigurarPaginaDados()
447:         LOCAL loc_oPagina
448:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
449: 
450:         *----------------------------------------------------------------------
451:         * Container Botoes Acao (Salvar/Cancelar - Grupo_Salva - lado direito)
452:         * Top=33 = original 4 + compensacao 29
453:         *----------------------------------------------------------------------
454:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
455:         WITH loc_oPagina.cnt_4c_BotoesAcao
456:             .Top         = 33
457:             .Left        = 837
458:             .Width       = 160
459:             .Height      = 85
460:             .BackStyle = 1
461:             .BackColor = RGB(53, 53, 53)
462:             .BorderStyle = 0
463:             .Visible     = .T.
464:         ENDWITH
465: 
466:         *-- Botao Confirmar (Salvar)
467:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
468:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
469:             .Caption         = "Confirmar"
470:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
471:             .PicturePosition = 13
472:             .Top             = 5
473:             .Left            = 5
474:             .Width           = 75
475:             .Height          = 75
476:             .BackColor       = RGB(255, 255, 255)
477:             .ForeColor       = RGB(90, 90, 90)
478:             .FontName        = "Comic Sans MS"
479:             .FontSize        = 8
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .Themes          = .F.
483:             .SpecialEffect   = 0
484:             .MousePointer    = 15
485:             .WordWrap        = .T.
486:             .AutoSize        = .F.
487:         ENDWITH
488:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
489: 
490:         *-- Botao Cancelar
491:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
492:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
493:             .Caption         = "Cancelar"
494:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
495:             .PicturePosition = 13
496:             .Top             = 5
497:             .Left            = 80
498:             .Width           = 75
499:             .Height          = 75
500:             .BackColor       = RGB(255, 255, 255)
501:             .ForeColor       = RGB(90, 90, 90)
502:             .FontName        = "Comic Sans MS"
503:             .FontSize        = 8
504:             .FontBold        = .T.
505:             .FontItalic      = .T.
506:             .Themes          = .F.
507:             .SpecialEffect   = 0
508:             .MousePointer    = 15
509:             .WordWrap        = .T.
510:             .AutoSize        = .F.
511:         ENDWITH
512:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
513: 
514:         *----------------------------------------------------------------------
515:         * PageFrame interno (PagDados) - 2 sub-paginas com campos fiscais
516:         * Top original=120, com compensacao +29 = 149
517:         * Page1: Dados Principais + Integracao Contabil/Fiscal
518:         * Page2: Integracao Contabil e Integracao Fiscal
519:         *----------------------------------------------------------------------
520:         loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
521:         WITH loc_oPagina.pgf_4c_PagDados
522:             .PageCount  = 2
523:             .Top        = 149
524:             .Left       = -1
525:             .Width      = 998
526:             .Height     = 476
527:             .Tabs       = .F.
528:             .Page1.Caption   = "DadosPrincipais"
529:             .Page2.Caption   = "Integracao"
530:             .Page1.BackColor = RGB(234, 232, 228)
531:             .Page2.BackColor = RGB(234, 232, 228)
532:         ENDWITH
533:         loc_oPagina.pgf_4c_PagDados.Visible = .T.
534: 
535:         *-- Configurar campos das sub-paginas de dados
536:         THIS.ConfigurarPaginaDadosPage1()
537:         THIS.ConfigurarPaginaDadosPage2()
538: 
539:         *-- Tornar controles visiveis
540:         THIS.TornarControlesVisiveis(loc_oPagina)
541:         *-- Fwcheckbox2 (SomaIcmFrete) tem Visible=.F. no original; reforcar
542:         THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.chk_4c_SomaIcmFrete.Visible = .F.
543:     ENDPROC
544: 
545:     *==========================================================================
546:     * CarregarLista - Carrega registros no grid da Page1
547:     * Chama BO.Buscar() que usa ZAP+APPEND para preservar colunas do grid,
548:     * depois re-vincula o grid ao cursor_4c_Dados atualizado.
549:     *==========================================================================
550:     PROCEDURE CarregarLista()
551:         LOCAL loc_lResultado, loc_oGrid
552:         loc_lResultado = .F.
553: 
554:         TRY
555:             *-- Pular se validando UI sem conexao
556:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
557:                 loc_lResultado = .T.
558:             ELSE
559:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
560:                     loc_lResultado = .F.
561:                 ELSE
562:                     IF THIS.this_oBusinessObject.Buscar("")
563:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
564:                         *-- RecordSource + ColumnCount FORA do WITH
565:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
566:                         loc_oGrid.ColumnCount  = 2
567:                         *-- ControlSource e Headers APOS RecordSource
568:                         loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
569:                         loc_oGrid.Column1.Width            = 80
570:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
571:                         loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
572:                         loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
573:                         loc_oGrid.Column2.Width            = 400
574:                         loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
575:                         loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
576:                         THIS.FormatarGridLista(loc_oGrid)
577:                         loc_lResultado = .T.
578:                     ELSE
579:                         loc_lResultado = .F.
580:                     ENDIF
581:                 ENDIF
582:             ENDIF
583:         CATCH TO loException
584:             MostrarErro("Erro ao carregar lista de CFOP:" + CHR(13) + loException.Message, "Erro")
585:             loc_lResultado = .F.
586:         ENDTRY
587: 
588:         RETURN loc_lResultado
589:     ENDPROC
590: 
591:     *==========================================================================
592:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
593:     *==========================================================================
594:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
595:         LOCAL loc_lResultado
596:         loc_lResultado = .F.
597: 
598:         TRY
599:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
600:                 MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Erro")
601:                 loc_lResultado = .F.
602:             ELSE
603:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
604:                 IF par_nPagina = 1
605:                     THIS.CarregarLista()
606:                 ENDIF
607:                 loc_lResultado = .T.
608:             ENDIF
609:         CATCH TO loException
610:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
611:             loc_lResultado = .F.
612:         ENDTRY
613: 
614:         RETURN loc_lResultado
615:     ENDPROC
616: 
617:     *==========================================================================
618:     * BtnIncluirClick - Novo registro CFOP
619:     *==========================================================================
620:     PROCEDURE BtnIncluirClick()
621:         TRY
622:             THIS.this_oBusinessObject.NovoRegistro()
623:             THIS.LimparCampos()
624:             THIS.this_cModoAtual = "INCLUIR"
625:             THIS.HabilitarCampos(.T.)
626:             THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
627:             THIS.AlternarPagina(2)
628:         CATCH TO loException
629:             MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, "Erro")
630:         ENDTRY
631:     ENDPROC
632: 
633:     *==========================================================================
634:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
635:     *==========================================================================
636:     PROCEDURE BtnVisualizarClick()
637:         LOCAL loc_cCodigo
638:         loc_cCodigo = ""
639: 
640:         TRY
641:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
642:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
643:             ELSE
644:                 SELECT cursor_4c_Dados
645:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
646:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
647:                     THIS.BOParaForm()
648:                     THIS.this_cModoAtual = "VISUALIZAR"
649:                     THIS.HabilitarCampos(.F.)
650:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
651:                     THIS.AlternarPagina(2)
652:                 ELSE
653:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
654:                 ENDIF
655:             ENDIF
656:         CATCH TO loException
657:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
658:         ENDTRY
659:     ENDPROC
660: 
661:     *==========================================================================
662:     * BtnAlterarClick - Alterar registro selecionado
663:     *==========================================================================
664:     PROCEDURE BtnAlterarClick()
665:         LOCAL loc_cCodigo
666:         loc_cCodigo = ""
667: 
668:         TRY
669:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
670:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
671:             ELSE
672:                 SELECT cursor_4c_Dados
673:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
674:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
675:                     THIS.this_oBusinessObject.EditarRegistro()
676:                     THIS.BOParaForm()
677:                     THIS.this_cModoAtual = "ALTERAR"
678:                     THIS.HabilitarCampos(.T.)
679:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
680:                     THIS.AlternarPagina(2)
681:                 ELSE
682:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
683:                 ENDIF
684:             ENDIF
685:         CATCH TO loException
686:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
687:         ENDTRY
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * BtnExcluirClick - Excluir registro selecionado
692:     *==========================================================================
693:     PROCEDURE BtnExcluirClick()
694:         LOCAL loc_cCodigo, loc_lConfirma
695:         loc_cCodigo   = ""
696:         loc_lConfirma = .F.
697: 
698:         TRY
699:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
700:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
701:             ELSE
702:                 SELECT cursor_4c_Dados
703:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
704: 
705:                 loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do CFOP [" + ;
706:                     loc_cCodigo + "]?", "Confirmar")
707: 
708:                 IF loc_lConfirma
709:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
710:                         IF THIS.this_oBusinessObject.Excluir()
711:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
712:                             THIS.CarregarLista()
713:                         ELSE
714:                             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Aviso")
715:                         ENDIF
716:                     ELSE
717:                         MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
718:                     ENDIF
719:                 ENDIF
720:             ENDIF
721:         CATCH TO loException
722:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
723:         ENDTRY
724:     ENDPROC
725: 
726:     *==========================================================================
727:     * BtnBuscarClick - Pesquisar CFOP via FormBuscaAuxiliar
728:     *==========================================================================
729:     PROCEDURE BtnBuscarClick()
730:         LOCAL loc_oBusca, loc_cCodigo
731:         loc_cCodigo = ""
732: 
733:         TRY
734:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
735:                 "SigCdCfo", "cursor_4c_BuscaCfop", "Codigos", "", ;
736:                 "Buscar CFOP")
737: 
738:             IF VARTYPE(loc_oBusca) = "O"
739:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
740:                 loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
741:                 loc_oBusca.Show()
742: 
743:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfop")
744:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfop.Codigos)
745:                     *-- Recarregar lista e posicionar no registro encontrado
746:                     THIS.CarregarLista()
747:                     IF USED("cursor_4c_Dados")
748:                         SELECT cursor_4c_Dados
749:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
750:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
751:                     ENDIF
752:                 ENDIF
753:                 loc_oBusca.Release()
754:             ENDIF
755:         CATCH TO loException
756:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
757:         ENDTRY
758: 
759:         IF USED("cursor_4c_BuscaCfop")
760:             USE IN cursor_4c_BuscaCfop
761:         ENDIF
762:     ENDPROC
763: 
764:     *==========================================================================
765:     * BtnEncerrarClick - Fechar formulario
766:     *==========================================================================
767:     PROCEDURE BtnEncerrarClick()
768:         TRY
769:             THIS.Release()
770:         CATCH TO loException
771:             MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "Erro")
772:         ENDTRY
773:     ENDPROC
774: 
775:     *==========================================================================
776:     * BtnSalvarClick - Salvar (Confirmar) alteracoes
777:     *==========================================================================
778:     PROCEDURE BtnSalvarClick()
779:         LOCAL loc_lResultado
780:         loc_lResultado = .F.
781: 
782:         *-- Validacoes FORA do TRY (para permitir RETURN normal)
783:         THIS.FormParaBO()
784: 
785:         TRY
786:             IF THIS.this_oBusinessObject.Salvar()
787:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
788:                 THIS.this_cModoAtual = "LISTA"
789:                 THIS.AlternarPagina(1)
790:                 loc_lResultado = .T.
791:             ELSE
792:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar o registro.", "Aviso")
793:                 loc_lResultado = .F.
794:             ENDIF
795:         CATCH TO loException
796:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
797:             loc_lResultado = .F.
798:         ENDTRY
799: 
800:         RETURN loc_lResultado
801:     ENDPROC
802: 
803:     *==========================================================================
804:     * BtnCancelarClick - Cancelar e voltar para lista
805:     *==========================================================================
806:     PROCEDURE BtnCancelarClick()
807:         TRY
808:             THIS.this_cModoAtual = "LISTA"
809:             THIS.AlternarPagina(1)
810:             THIS.CarregarLista()
811:         CATCH TO loException
812:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Erro")
813:         ENDTRY
814:     ENDPROC
815: 
816:     *==========================================================================
817:     * BtnExpXMLClick - Exportar XML do CFOP selecionado
818:     * Equivalente ao btnExpXML.Click do original
819:     *==========================================================================
820:     PROCEDURE BtnExpXMLClick()
821:         LOCAL loc_cCodigo, loc_lResultado
822:         loc_cCodigo   = ""
823:         loc_lResultado = .F.
824: 
825:         TRY
826:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
827:                 SELECT cursor_4c_Dados
828:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
829: 
830:                 IF !EMPTY(loc_cCodigo)
831:                     THIS.LockScreen = .T.
832:                     DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
833:                     THIS.CarregarLista()
834:                     IF USED("cursor_4c_Dados")
835:                         SELECT cursor_4c_Dados
836:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
837:                     ENDIF
838:                     THIS.LockScreen = .F.
839:                     loc_lResultado = .T.
840:                 ENDIF
841:             ELSE
842:                 MsgAviso("Selecione um CFOP para exportar.", "Aviso")
843:             ENDIF
844:         CATCH TO loException
845:             THIS.LockScreen = .F.
846:             MostrarErro("Erro ao exportar XML:" + CHR(13) + loException.Message, "Erro")
847:         ENDTRY
848: 
849:         RETURN loc_lResultado
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * BtnImpXMLClick - Importar XML de CFOP
854:     * Equivalente ao btnImpXML.Click do original
855:     *==========================================================================
856:     PROCEDURE BtnImpXMLClick()
857:         LOCAL loc_lResultado
858:         loc_lResultado = .F.
859: 
860:         TRY
861:             THIS.LockScreen = .T.
862:             DO FORM SigOpXml WITH THIS, "", "I", "CFOP", 10
863:             THIS.CarregarLista()
864:             THIS.LockScreen = .F.
865:             loc_lResultado = .T.
866:         CATCH TO loException
867:             THIS.LockScreen = .F.
868:             MostrarErro("Erro ao importar XML:" + CHR(13) + loException.Message, "Erro")
869:         ENDTRY
870: 
871:         RETURN loc_lResultado
872:     ENDPROC
873: 
874:     *==========================================================================
875:     * LimparCampos - Limpa todos os campos do formulario (Page2)
876:     *==========================================================================
877:     PROTECTED PROCEDURE LimparCampos()
878:         LOCAL loc_oPag1, loc_oPag2
879:         TRY
880:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
881:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
882: 
883:             *-- Page1: Dados Principais
884:             loc_oPag1.txt_4c_Codigo.Value      = ""
885:             loc_oPag1.txt_4c_Descricao.Value   = ""
886:             loc_oPag1.txt_4c_Desc2s.Value      = ""
887:             loc_oPag1.opg_4c_Situacao.Value    = 1
888:             loc_oPag1.cmb_4c_Operacao.ListIndex = 0
889:             loc_oPag1.cmb_4c_Tipo.ListIndex    = 0
890:             loc_oPag1.spn_4c_Ndigito.Value     = 0
891:             loc_oPag1.cmb_4c_Icms.ListIndex    = 0
892:             loc_oPag1.cmb_4c_SobreDesc.ListIndex   = 0
893:             loc_oPag1.cmb_4c_InclIcms.ListIndex    = 0
894:             loc_oPag1.cmb_4c_IpiIcms.ListIndex     = 0
895:             loc_oPag1.txt_4c_CfoST.Value       = ""
896:             loc_oPag1.txt_4c_CfoST60.Value     = ""
897:             loc_oPag1.txt_4c_CfoDest.Value     = ""
898:             loc_oPag1.txt_4c_BcST.Value        = 0
899:             loc_oPag1.cmb_4c_STRIB.ListIndex   = 0
900:             loc_oPag1.cmb_4c_CfoTransp.ListIndex = 0
901:             loc_oPag1.txt_4c_Sittricm.Value    = ""
902:             loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = 0
903:             loc_oPag1.cmb_4c_ContribNFe.ListIndex    = 0
904:             loc_oPag1.txt_4c_AliqIVCs.Value    = 0
905:             loc_oPag1.txt_4c_MotDeson.Value    = ""
906:             loc_oPag1.cmb_4c_UnitImp.ListIndex = 0
907:             loc_oPag1.chk_4c_FreteICM.Value    = 0
908:             loc_oPag1.chk_4c_SegICM.Value      = 0
909:             loc_oPag1.chk_4c_DespICM.Value     = 0
910:             loc_oPag1.chk_4c_IcmsNF.Value      = 0
911:             loc_oPag1.chk_4c_SomaIcmFrete.Value = 0
912:             loc_oPag1.cmb_4c_IPI.ListIndex     = 0
913:             loc_oPag1.cmb_4c_IpiI.ListIndex    = 0
914:             loc_oPag1.txt_4c_Aliqs.Value       = 0
915:             loc_oPag1.txt_4c_Gergia1.Value     = ""
916:             loc_oPag1.txt_4c_IPICST.Value      = ""
917:             loc_oPag1.txt_4c_PISCST.Value      = ""

*-- Linhas 962 a 1005:
962:     *==========================================================================
963:     * HabilitarCampos - Habilita/desabilita campos conforme modo
964:     *==========================================================================
965:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
966:         LOCAL loc_oPag1, loc_oPag2, loc_lNovo
967:         TRY
968:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
969:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
970:             loc_lNovo = (THIS.this_cModoAtual = "INCLUIR")
971: 
972:             *-- getCodigo: apenas habilitado no modo Incluir
973:             loc_oPag1.txt_4c_Codigo.Enabled    = (par_lHabilitar AND loc_lNovo)
974:             loc_oPag1.txt_4c_Descricao.Enabled = par_lHabilitar
975:             loc_oPag1.txt_4c_Desc2s.Enabled    = par_lHabilitar
976:             loc_oPag1.opg_4c_Situacao.Enabled  = par_lHabilitar
977:             loc_oPag1.cmb_4c_Operacao.Enabled  = par_lHabilitar
978:             loc_oPag1.cmb_4c_Tipo.Enabled      = par_lHabilitar
979:             loc_oPag1.spn_4c_Ndigito.Enabled   = par_lHabilitar
980:             loc_oPag1.cmb_4c_Icms.Enabled      = par_lHabilitar
981:             loc_oPag1.cmb_4c_SobreDesc.Enabled = par_lHabilitar
982:             loc_oPag1.cmb_4c_InclIcms.Enabled  = par_lHabilitar
983:             loc_oPag1.cmb_4c_IpiIcms.Enabled   = par_lHabilitar
984:             loc_oPag1.txt_4c_CfoST.Enabled     = par_lHabilitar
985:             loc_oPag1.txt_4c_CfoST60.Enabled   = par_lHabilitar
986:             loc_oPag1.txt_4c_CfoDest.Enabled   = par_lHabilitar
987:             loc_oPag1.txt_4c_BcST.Enabled      = par_lHabilitar
988:             loc_oPag1.cmb_4c_STRIB.Enabled     = par_lHabilitar
989:             loc_oPag1.cmb_4c_CfoTransp.Enabled = par_lHabilitar
990:             loc_oPag1.txt_4c_Sittricm.Enabled  = par_lHabilitar
991:             loc_oPag1.cmb_4c_IcmsInclPreco.Enabled = par_lHabilitar
992:             loc_oPag1.cmb_4c_ContribNFe.Enabled    = par_lHabilitar
993:             loc_oPag1.txt_4c_AliqIVCs.Enabled  = par_lHabilitar
994:             loc_oPag1.txt_4c_MotDeson.Enabled  = par_lHabilitar
995:             loc_oPag1.cmb_4c_UnitImp.Enabled   = par_lHabilitar
996:             loc_oPag1.chk_4c_FreteICM.Enabled  = par_lHabilitar
997:             loc_oPag1.chk_4c_SegICM.Enabled    = par_lHabilitar
998:             loc_oPag1.chk_4c_DespICM.Enabled   = par_lHabilitar
999:             loc_oPag1.chk_4c_IcmsNF.Enabled    = par_lHabilitar
1000:             loc_oPag1.cmb_4c_IPI.Enabled       = par_lHabilitar
1001:             loc_oPag1.cmb_4c_IpiI.Enabled      = par_lHabilitar
1002:             loc_oPag1.txt_4c_Aliqs.Enabled     = par_lHabilitar
1003:             loc_oPag1.txt_4c_Gergia1.Enabled   = par_lHabilitar
1004:             loc_oPag1.txt_4c_IPICST.Enabled    = par_lHabilitar
1005:             loc_oPag1.txt_4c_PISCST.Enabled    = par_lHabilitar

*-- Linhas 1050 a 1093:
1050:     *==========================================================================
1051:     * BOParaForm - Carrega dados do BO para os campos visuais
1052:     *==========================================================================
1053:     PROTECTED PROCEDURE BOParaForm()
1054:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
1055:         TRY
1056:             loc_oBO   = THIS.this_oBusinessObject
1057:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1058:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
1059: 
1060:             *-- Page1: campos basicos
1061:             loc_oPag1.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cCodigos)
1062:             loc_oPag1.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cDescricaos)
1063:             loc_oPag1.txt_4c_Desc2s.Value    = ALLTRIM(loc_oBO.this_cDesc2s)
1064:             loc_oPag1.opg_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
1065:             loc_oPag1.spn_4c_Ndigito.Value   = loc_oBO.this_nNdigitos
1066: 
1067:             *-- Combos S/N bound to N(1,0): ListIndex=1?Sim(1), ListIndex=2?N?o(0)
1068:             loc_oPag1.cmb_4c_SobreDesc.ListIndex    = IIF(loc_oBO.this_nIcmsdscs = 1, 1, 2)
1069:             loc_oPag1.cmb_4c_InclIcms.ListIndex     = MAX(1, loc_oBO.this_nInclicms + 1)
1070:             loc_oPag1.cmb_4c_IpiIcms.ListIndex      = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpi_Icms)),1)="S",1,2)
1071:             loc_oPag1.cmb_4c_CfoTransp.ListIndex    = IIF(loc_oBO.this_nTransps = 1, 1, 2)
1072:             loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = IIF(loc_oBO.this_nIcmsincs = 1, 1, 2)
1073:             loc_oPag1.cmb_4c_NaoCreditado.ListIndex  = IIF(loc_oBO.this_nIpincreds = 1, 1, 2)
1074:             loc_oPag1.cmb_4c_RetiraIPI.ListIndex     = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpiom2s)),1)="S",1,2)
1075:             *-- Combo2 AcresDesc (C(1) ? Sim/N?o)
1076:             loc_oPag1.cmb_4c_AcresDesc.ListIndex     = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cAcresipis)),1)="S",1,2)
1077:             *-- cmbtipo: BoundColumn=2, ListIndex=this_nTipos
1078:             IF loc_oBO.this_nTipos >= 1 AND loc_oBO.this_nTipos <= 5
1079:                 loc_oPag1.cmb_4c_Tipo.ListIndex = loc_oBO.this_nTipos
1080:             ELSE
1081:                 loc_oPag1.cmb_4c_Tipo.ListIndex = 0
1082:             ENDIF
1083:             *-- cmbOperacao (C(1): E/S)
1084:             IF LEFT(UPPER(ALLTRIM(loc_oBO.this_cOperacaos)),1) = "E"
1085:                 loc_oPag1.cmb_4c_Operacao.ListIndex = 1
1086:             ELSE
1087:                 loc_oPag1.cmb_4c_Operacao.ListIndex = 2
1088:             ENDIF
1089:             *-- cmbIcms (C(1)): T=Tributado(1), I=Isento(2), O=Outros(3), N=N Tributa(4)
1090:             DO CASE
1091:                 CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "T"
1092:                     loc_oPag1.cmb_4c_Icms.ListIndex = 1
1093:                 CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "I"

*-- Linhas 1178 a 1269:
1178:             loc_oPag1.chk_4c_SegIPI.Value    = loc_oBO.this_nSegipis
1179:             loc_oPag1.chk_4c_DespIPI.Value   = loc_oBO.this_nDesipis
1180: 
1181:             *-- OptionGroups
1182:             *-- Fwoption1 CodTribISSQN: 0=Normal,1=Retida,2=Substituta,3=Isenta,4=NaoCalc
1183:             IF loc_oBO.this_nCtissqn >= 0 AND loc_oBO.this_nCtissqn <= 4
1184:                 loc_oPag1.opg_4c_CodTribISSQN.Value = loc_oBO.this_nCtissqn + 1
1185:             ELSE
1186:                 loc_oPag1.opg_4c_CodTribISSQN.Value = 1
1187:             ENDIF
1188:             *-- Fwoption2 RetTribs: 1=Sim, 2=N?o; BO stores 1=Sim, 0=N?o
1189:             loc_oPag1.opg_4c_RetTribs.Value = IIF(loc_oBO.this_nRettribs = 1, 1, 2)
1190: 
1191:             *-- Page2: Integracao Contabil
1192:             loc_oPag2.txt_4c_VrcDs.Value  = ALLTRIM(loc_oBO.this_cContvcds)
1193:             loc_oPag2.txt_4c_VrcCs.Value  = ALLTRIM(loc_oBO.this_cContvccs)
1194:             loc_oPag2.txt_4c_IcmDs.Value  = ALLTRIM(loc_oBO.this_cConticds)
1195:             loc_oPag2.txt_4c_IcmCs.Value  = ALLTRIM(loc_oBO.this_cConticcs)
1196:             loc_oPag2.txt_4c_IpiDs.Value  = ALLTRIM(loc_oBO.this_cContipds)
1197:             loc_oPag2.txt_4c_IpiCs.Value  = ALLTRIM(loc_oBO.this_cContipcs)
1198:             loc_oPag2.txt_4c_ContFrt.Value = ALLTRIM(loc_oBO.this_cContfrt)
1199:             loc_oPag2.txt_4c_ContSeg.Value = ALLTRIM(loc_oBO.this_cContseg)
1200:             loc_oPag2.txt_4c_ContDa.Value  = ALLTRIM(loc_oBO.this_cContda)
1201:             *-- Combo2 DescInteg: ListIndex=this_nPontedescs+1 (0=Sim-Desc,1=Nao-Nenhuma,2=Sim-Obs)
1202:             IF loc_oBO.this_nPontedescs >= 0 AND loc_oBO.this_nPontedescs <= 2
1203:                 loc_oPag2.cmb_4c_DescInteg.ListIndex = loc_oBO.this_nPontedescs + 1
1204:             ELSE
1205:                 loc_oPag2.cmb_4c_DescInteg.ListIndex = 1
1206:             ENDIF
1207:             *-- CmbFixa (C(1)): S->1, N->2, C->3
1208:             LOCAL loc_nCmbFixaIdx
1209:             loc_nCmbFixaIdx = AT(LEFT(UPPER(ALLTRIM(loc_oBO.this_cContconts)), 1), "SNC")
1210:             loc_oPag2.cmb_4c_CmbFixa.ListIndex = IIF(loc_nCmbFixaIdx > 0, loc_nCmbFixaIdx, 0)
1211:             *-- OptionGroups Page2 (N(1,0): 1=Sim, 2=Nao; BO stores 1/0)
1212:             loc_oPag2.opg_4c_Agrupas.Value   = IIF(loc_oBO.this_nAgrupas = 1, 1, 2)
1213:             loc_oPag2.opg_4c_Zeradas.Value   = IIF(loc_oBO.this_nZeradas = 1, 1, 2)
1214:             loc_oPag2.opg_4c_DtIntFis.Value  = IIF(loc_oBO.this_nDtintfis = 1, 1, 2)
1215:             loc_oPag2.opg_4c_UtilVars.Value  = IIF(loc_oBO.this_nUtilvars = 1, 1, 2)
1216:             loc_oPag2.opg_4c_IntVlrCont.Value = IIF(loc_oBO.this_nIntvlrcont = 1, 1, 2)
1217:             loc_oPag2.opg_4c_IntVlrIcms.Value = IIF(loc_oBO.this_nIntvlricms = 1, 1, 2)
1218:             loc_oPag2.opg_4c_IntVlrIpi.Value  = IIF(loc_oBO.this_nIntvlripi = 1, 1, 2)
1219:             loc_oPag2.opg_4c_IndMov.Value    = IIF(loc_oBO.this_nIndmov = 1, 1, 2)
1220:             loc_oPag2.opg_4c_IndPagto.Value  = IIF(loc_oBO.this_nIndpagto = 1, 1, 2)
1221:         CATCH TO loException
1222:             MostrarErro("Erro ao carregar BO para form:" + CHR(13) + loException.Message, "Erro")
1223:         ENDTRY
1224:     ENDPROC
1225: 
1226:     *==========================================================================
1227:     * FormParaBO - L? campos visuais e transfere para o BO
1228:     *==========================================================================
1229:     PROTECTED PROCEDURE FormParaBO()
1230:         LOCAL loc_oPag1, loc_oPag2, loc_oBO
1231:         TRY
1232:             loc_oBO   = THIS.this_oBusinessObject
1233:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1234:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
1235: 
1236:             *-- Campos basicos
1237:             loc_oBO.this_cCodigos    = ALLTRIM(loc_oPag1.txt_4c_Codigo.Value)
1238:             loc_oBO.this_cDescricaos = ALLTRIM(loc_oPag1.txt_4c_Descricao.Value)
1239:             loc_oBO.this_cDesc2s     = ALLTRIM(loc_oPag1.txt_4c_Desc2s.Value)
1240:             loc_oBO.this_nSituas     = IIF(loc_oPag1.opg_4c_Situacao.Value = 1, 1, 0)
1241:             loc_oBO.this_nNdigitos   = loc_oPag1.spn_4c_Ndigito.Value
1242: 
1243:             *-- cmbtipo: ListIndex=this_nTipos (1-5)
1244:             loc_oBO.this_nTipos = MAX(0, loc_oPag1.cmb_4c_Tipo.ListIndex)
1245: 
1246:             *-- cmbOperacao (C(1): E/S)
1247:             IF loc_oPag1.cmb_4c_Operacao.ListIndex = 1
1248:                 loc_oBO.this_cOperacaos = "E"
1249:             ELSE
1250:                 loc_oBO.this_cOperacaos = "S"
1251:             ENDIF
1252: 
1253:             *-- Combos N(1,0) Sim/N?o: ListIndex=1?1, ListIndex=2?0
1254:             loc_oBO.this_nIcmsdscs  = IIF(loc_oPag1.cmb_4c_SobreDesc.ListIndex = 1, 1, 0)
1255:             loc_oBO.this_nInclicms  = MAX(0, loc_oPag1.cmb_4c_InclIcms.ListIndex - 1)
1256:             loc_oBO.this_nTransps   = IIF(loc_oPag1.cmb_4c_CfoTransp.ListIndex = 1, 1, 0)
1257:             loc_oBO.this_nIcmsincs  = IIF(loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = 1, 1, 0)
1258:             loc_oBO.this_nIpincreds = IIF(loc_oPag1.cmb_4c_NaoCreditado.ListIndex = 1, 1, 0)
1259: 
1260:             *-- C(1) combos: store first char of selected text
1261:             IF loc_oPag1.cmb_4c_IpiIcms.ListIndex >= 1
1262:                 loc_oBO.this_cIpi_Icms  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiIcms.Value)), 1)
1263:             ENDIF
1264:             IF loc_oPag1.cmb_4c_Icms.ListIndex >= 1
1265:                 loc_oBO.this_cIcms      = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_Icms.Value)), 1)
1266:             ENDIF
1267:             IF loc_oPag1.cmb_4c_STRIB.ListIndex >= 1
1268:                 loc_oBO.this_cSubtribs  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_STRIB.Value)), 1)
1269:             ENDIF

*-- Linhas 1324 a 1470:
1324:             loc_oBO.this_nSegipis   = loc_oPag1.chk_4c_SegIPI.Value
1325:             loc_oBO.this_nDesipis   = loc_oPag1.chk_4c_DespIPI.Value
1326: 
1327:             *-- OptionGroups Page1
1328:             loc_oBO.this_nCtissqn   = MAX(0, loc_oPag1.opg_4c_CodTribISSQN.Value - 1)
1329:             loc_oBO.this_nRettribs  = IIF(loc_oPag1.opg_4c_RetTribs.Value = 1, 1, 0)
1330: 
1331:             *-- Page2
1332:             loc_oBO.this_cContvcds = ALLTRIM(loc_oPag2.txt_4c_VrcDs.Value)
1333:             loc_oBO.this_cContvccs = ALLTRIM(loc_oPag2.txt_4c_VrcCs.Value)
1334:             loc_oBO.this_cConticds = ALLTRIM(loc_oPag2.txt_4c_IcmDs.Value)
1335:             loc_oBO.this_cConticcs = ALLTRIM(loc_oPag2.txt_4c_IcmCs.Value)
1336:             loc_oBO.this_cContipds = ALLTRIM(loc_oPag2.txt_4c_IpiDs.Value)
1337:             loc_oBO.this_cContipcs = ALLTRIM(loc_oPag2.txt_4c_IpiCs.Value)
1338:             loc_oBO.this_cContfrt  = ALLTRIM(loc_oPag2.txt_4c_ContFrt.Value)
1339:             loc_oBO.this_cContseg  = ALLTRIM(loc_oPag2.txt_4c_ContSeg.Value)
1340:             loc_oBO.this_cContda   = ALLTRIM(loc_oPag2.txt_4c_ContDa.Value)
1341:             *-- Combo2 DescInteg: ListIndex-1=pontedescs
1342:             loc_oBO.this_nPontedescs = MAX(0, loc_oPag2.cmb_4c_DescInteg.ListIndex - 1)
1343:             *-- CmbFixa (C(1)): ListIndex=1->S, 2->N, 3->C
1344:             DO CASE
1345:                 CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 1
1346:                     loc_oBO.this_cContconts = "S"
1347:                 CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 2
1348:                     loc_oBO.this_cContconts = "N"
1349:                 CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 3
1350:                     loc_oBO.this_cContconts = "C"
1351:             ENDCASE
1352:             *-- OptionGroups Page2
1353:             loc_oBO.this_nAgrupas    = IIF(loc_oPag2.opg_4c_Agrupas.Value = 1, 1, 0)
1354:             loc_oBO.this_nZeradas    = IIF(loc_oPag2.opg_4c_Zeradas.Value = 1, 1, 0)
1355:             loc_oBO.this_nDtintfis   = IIF(loc_oPag2.opg_4c_DtIntFis.Value = 1, 1, 0)
1356:             loc_oBO.this_nUtilvars   = IIF(loc_oPag2.opg_4c_UtilVars.Value = 1, 1, 0)
1357:             loc_oBO.this_nIntvlrcont = IIF(loc_oPag2.opg_4c_IntVlrCont.Value = 1, 1, 0)
1358:             loc_oBO.this_nIntvlricms = IIF(loc_oPag2.opg_4c_IntVlrIcms.Value = 1, 1, 0)
1359:             loc_oBO.this_nIntvlripi  = IIF(loc_oPag2.opg_4c_IntVlrIpi.Value = 1, 1, 0)
1360:             loc_oBO.this_nIndmov     = IIF(loc_oPag2.opg_4c_IndMov.Value = 1, 1, 0)
1361:             loc_oBO.this_nIndpagto   = IIF(loc_oPag2.opg_4c_IndPagto.Value = 1, 1, 0)
1362:         CATCH TO loException
1363:             MostrarErro("Erro ao transferir form para BO:" + CHR(13) + loException.Message, "Erro")
1364:         ENDTRY
1365:     ENDPROC
1366: 
1367:     *==========================================================================
1368:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1369:     * AddObject() cria controles com Visible=.F. por padrao
1370:     *==========================================================================
1371:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1372:         LOCAL loc_nI, loc_oObjeto, loc_nP
1373: 
1374:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1375:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1376: 
1377:             IF VARTYPE(loc_oObjeto) = "O"
1378:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1379:                     loc_oObjeto.Visible = .T.
1380:                 ENDIF
1381: 
1382:                 *-- Trata PageFrame - itera Pages individualmente
1383:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1384:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1385:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1386:                     ENDFOR
1387:                 ENDIF
1388: 
1389:                 *-- Trata containers com ControlCount (recursivo)
1390:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1391:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1392:                 ENDIF
1393:             ENDIF
1394:         ENDFOR
1395:     ENDPROC
1396: 
1397:     *==========================================================================
1398:     * FormatarGridLista - Formata visual do grid da lista
1399:     *==========================================================================
1400:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1401:         TRY
1402:             par_oGrid.FontName = "Tahoma"
1403:             par_oGrid.FontSize = 8
1404:         CATCH TO loException
1405:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "Erro")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * Destroy - Libera recursos ao fechar o formulario
1411:     *==========================================================================
1412:     PROCEDURE Destroy()
1413:         TRY
1414:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1415:                 THIS.this_oBusinessObject = .NULL.
1416:             ENDIF
1417:             IF USED("cursor_4c_Dados")
1418:                 USE IN cursor_4c_Dados
1419:             ENDIF
1420:         CATCH TO loException
1421:             MostrarErro("Aviso Destroy Formcfo:" + CHR(13) + loException.Message, "Aviso")
1422:         ENDTRY
1423:         DODEFAULT()
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * ConfigurarPaginaDadosPage1 - Cria controles na Page1 (Dados Principais)
1428:     * Controls da PagDados.Page1 do formulario original sigcdcfo.scx
1429:     *==========================================================================
1430:     PROTECTED PROCEDURE ConfigurarPaginaDadosPage1()
1431:         LOCAL loc_oPag1, loc_oCtrl
1432:         TRY
1433:             loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1434: 
1435:             *-- Shapes (separadores horizontais/vertical)
1436:             loc_oPag1.AddObject("shp_4c_shp01", "Shape")
1437:             WITH loc_oPag1.shp_4c_shp01
1438:                 .Top = 92
1439:                 .Left = 3
1440:                 .Height = 1
1441:                 .Width = 984
1442:                 .BackStyle = 0
1443:                 .BorderStyle = 1
1444:                 .BorderWidth = 1
1445:                 .BorderColor = RGB(100,100,100)
1446:             ENDWITH
1447: 
1448:             loc_oPag1.AddObject("shp_4c_shp03", "Shape")
1449:             WITH loc_oPag1.shp_4c_shp03
1450:                 .Top = 236
1451:                 .Left = 3
1452:                 .Height = 1
1453:                 .Width = 984
1454:                 .BackStyle = 0
1455:                 .BorderStyle = 1
1456:                 .BorderWidth = 1
1457:                 .BorderColor = RGB(100,100,100)
1458:             ENDWITH
1459: 
1460:             loc_oPag1.AddObject("shp_4c_Shape1", "Shape")
1461:             WITH loc_oPag1.shp_4c_Shape1
1462:                 .Top = 243
1463:                 .Left = 488
1464:                 .Height = 206
1465:                 .Width = 0
1466:                 .BackStyle = 0
1467:                 .BorderStyle = 1
1468:                 .BorderWidth = 1
1469:             ENDWITH
1470: 

*-- Linhas 2807 a 2851:
2807:                 .RowSource = "Sim,N" + CHR(227) + "o"
2808:             ENDWITH
2809: 
2810:             *-- OptionGroup Situacao (2 botoes: Ativo/Inativo)
2811:             loc_oPag1.AddObject("opg_4c_Situacao", "OptionGroup")
2812:             WITH loc_oPag1.opg_4c_Situacao
2813:                 .Top = 11
2814:                 .Left = 243
2815:                 .Height = 17
2816:                 .Width = 137
2817:                 .ButtonCount = 2
2818:                 .Buttons(1).Caption = "Ativo"
2819:                 .Buttons(1).Left = 4
2820:                 .Buttons(1).Top = 0
2821:                 .Buttons(1).AutoSize = .T.
2822:                 .Buttons(1).BackStyle = 0
2823:                 .Buttons(1).FontName = "Tahoma"
2824:                 .Buttons(1).FontSize = 8
2825:                 .Buttons(1).FontBold = .T.
2826:                 .Buttons(1).ForeColor = RGB(90,90,90)
2827:                 .Buttons(1).Themes = .F.
2828:                 .Buttons(2).Caption = "Inativo"
2829:                 .Buttons(2).Left = 64
2830:                 .Buttons(2).Top = 0
2831:                 .Buttons(2).AutoSize = .T.
2832:                 .Buttons(2).BackStyle = 0
2833:                 .Buttons(2).FontName = "Tahoma"
2834:                 .Buttons(2).FontSize = 8
2835:                 .Buttons(2).FontBold = .T.
2836:                 .Buttons(2).ForeColor = RGB(90,90,90)
2837:                 .Buttons(2).Themes = .F.
2838:             ENDWITH
2839: 
2840:             *-- CheckBoxes ICMS
2841:             loc_oPag1.AddObject("chk_4c_FreteICM", "CheckBox")
2842:             WITH loc_oPag1.chk_4c_FreteICM
2843:                 .Top = 102
2844:                 .Left = 549
2845:                 .Height = 15
2846:                 .Width = 44
2847:                 .Caption = "Frete"
2848:                 .FontName = "Tahoma"
2849:                 .FontSize = 8
2850:                 .FontBold = .F.
2851:                 .ForeColor = RGB(90,90,90)

*-- Linhas 2976 a 3020:
2976:                 .Value = 0
2977:             ENDWITH
2978: 
2979:             *-- OptionGroup CodTribISSQN (5 botoes: Normal/Retida/Substituta/Isenta/NaoCalcISSQN)
2980:             loc_oPag1.AddObject("opg_4c_CodTribISSQN", "OptionGroup")
2981:             WITH loc_oPag1.opg_4c_CodTribISSQN
2982:                 .Top = 389
2983:                 .Left = 686
2984:                 .Height = 34
2985:                 .Width = 297
2986:                 .ButtonCount = 5
2987:                 .Buttons(1).Caption = "Normal"
2988:                 .Buttons(1).Left = 4
2989:                 .Buttons(1).Top = 0
2990:                 .Buttons(1).AutoSize = .T.
2991:                 .Buttons(1).BackStyle = 0
2992:                 .Buttons(1).FontName = "Verdana"
2993:                 .Buttons(1).FontSize = 8
2994:                 .Buttons(1).FontBold = .F.
2995:                 .Buttons(1).ForeColor = RGB(90,90,90)
2996:                 .Buttons(1).Themes = .F.
2997:                 .Buttons(2).Caption = "Retida"
2998:                 .Buttons(2).Left = 72
2999:                 .Buttons(2).Top = 0
3000:                 .Buttons(2).AutoSize = .T.
3001:                 .Buttons(2).BackStyle = 0
3002:                 .Buttons(2).FontName = "Verdana"
3003:                 .Buttons(2).FontSize = 8
3004:                 .Buttons(2).FontBold = .F.
3005:                 .Buttons(2).ForeColor = RGB(90,90,90)
3006:                 .Buttons(2).Themes = .F.
3007:                 .Buttons(3).Caption = "Substituta"
3008:                 .Buttons(3).Left = 135
3009:                 .Buttons(3).Top = 1
3010:                 .Buttons(3).Width = 76
3011:                 .Buttons(3).AutoSize = .T.
3012:                 .Buttons(3).BackStyle = 0
3013:                 .Buttons(3).FontName = "Verdana"
3014:                 .Buttons(3).FontSize = 8
3015:                 .Buttons(3).FontBold = .F.
3016:                 .Buttons(3).ForeColor = RGB(90,90,90)
3017:                 .Buttons(3).Themes = .F.
3018:                 .Buttons(4).Caption = "Isenta"
3019:                 .Buttons(4).Left = 219
3020:                 .Buttons(4).Top = 1

*-- Linhas 3036 a 3133:
3036:                 .Buttons(5).Themes = .F.
3037:             ENDWITH
3038: 
3039:             *-- OptionGroup RetTribs (2 botoes: Sim/Nao)
3040:             loc_oPag1.AddObject("opg_4c_RetTribs", "OptionGroup")
3041:             WITH loc_oPag1.opg_4c_RetTribs
3042:                 .Top = 420
3043:                 .Left = 686
3044:                 .Height = 25
3045:                 .Width = 95
3046:                 .ButtonCount = 2
3047:                 .Buttons(1).Caption = "Sim"
3048:                 .Buttons(1).Left = 5
3049:                 .Buttons(1).Top = 5
3050:                 .Buttons(1).AutoSize = .T.
3051:                 .Buttons(1).BackStyle = 0
3052:                 .Buttons(1).FontName = "Tahoma"
3053:                 .Buttons(1).FontSize = 8
3054:                 .Buttons(1).FontBold = .F.
3055:                 .Buttons(1).ForeColor = RGB(90,90,90)
3056:                 .Buttons(1).Themes = .F.
3057:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3058:                 .Buttons(2).Left = 53
3059:                 .Buttons(2).Top = 5
3060:                 .Buttons(2).AutoSize = .T.
3061:                 .Buttons(2).BackStyle = 0
3062:                 .Buttons(2).FontName = "Tahoma"
3063:                 .Buttons(2).FontSize = 8
3064:                 .Buttons(2).FontBold = .F.
3065:                 .Buttons(2).ForeColor = RGB(90,90,90)
3066:                 .Buttons(2).Themes = .F.
3067:             ENDWITH
3068: 
3069:             *-- BINDEVENT: F4/F5=115/116 para lookups de CFOP e ICM
3070:             BINDEVENT(loc_oPag1.txt_4c_CfoST60, "KeyPress", THIS, "KeyPressCfoST60Handler")
3071:             BINDEVENT(loc_oPag1.txt_4c_CfoST,   "KeyPress", THIS, "KeyPressCfoSTHandler")
3072:             BINDEVENT(loc_oPag1.txt_4c_CfoDest,  "KeyPress", THIS, "KeyPressCfoDestHandler")
3073:             BINDEVENT(loc_oPag1.txt_4c_Sittricm, "KeyPress", THIS, "KeyPressSittricmHandler")
3074: 
3075:             *-- BINDEVENT: validacao CST (Enter=13 apos digitar 2 chars)
3076:             BINDEVENT(loc_oPag1.txt_4c_IPICST, "KeyPress", THIS, "ValidarIPICSTKeyPress")
3077:             BINDEVENT(loc_oPag1.txt_4c_PISCST, "KeyPress", THIS, "ValidarPISCSTKeyPress")
3078:             BINDEVENT(loc_oPag1.txt_4c_COFCST, "KeyPress", THIS, "ValidarCOFCSTKeyPress")
3079: 
3080:             *-- BINDEVENT: comportamento BIPI e IpiI
3081:             BINDEVENT(loc_oPag1.cmb_4c_BIPI, "InteractiveChange", THIS, "BipiChangeHandler")
3082:             BINDEVENT(loc_oPag1.cmb_4c_IpiI, "InteractiveChange", THIS, "IpiIChangeHandler")
3083: 
3084:         CATCH TO loException
3085:             MostrarErro("Erro ao criar controles Page1:" + CHR(13) + loException.Message, "Erro")
3086:         ENDTRY
3087:     ENDPROC
3088: 
3089:     *==========================================================================
3090:     * ConfigurarPaginaDadosPage2 - Cria controles na Page2 (Integracao)
3091:     * Controls da PagDados.Page2 do formulario original sigcdcfo.scx
3092:     *==========================================================================
3093:     PROTECTED PROCEDURE ConfigurarPaginaDadosPage2()
3094:         LOCAL loc_oPag2
3095:         TRY
3096:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
3097: 
3098:             *-- Shape separador
3099:             loc_oPag2.AddObject("shp_4c_shp03", "Shape")
3100:             WITH loc_oPag2.shp_4c_shp03
3101:                 .Top = 211
3102:                 .Left = 5
3103:                 .Height = 1
3104:                 .Width = 984
3105:                 .BackStyle = 0
3106:                 .BorderStyle = 1
3107:                 .BorderWidth = 1
3108:                 .BorderColor = RGB(100,100,100)
3109:             ENDWITH
3110: 
3111:             *-- Labels
3112:             loc_oPag2.AddObject("lbl_4c_Say7", "Label")
3113:             WITH loc_oPag2.lbl_4c_Say7
3114:                 .Caption = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
3115:                 .Top = 6
3116:                 .Left = 15
3117:                 .Height = 15
3118:                 .Width = 114
3119:                 .FontName = "Tahoma"
3120:                 .FontSize = 8
3121:                 .FontBold = .T.
3122:                 .ForeColor = RGB(90,90,90)
3123:                 .BackStyle = 0
3124:             ENDWITH
3125: 
3126:             loc_oPag2.AddObject("lbl_4c_Say10", "Label")
3127:             WITH loc_oPag2.lbl_4c_Say10
3128:                 .Caption = "Valor Cont" + CHR(225) + "bil :"
3129:                 .Top = 34
3130:                 .Left = 84
3131:                 .Height = 15
3132:                 .Width = 75
3133:                 .FontName = "Tahoma"

*-- Linhas 3619 a 4260:
3619:                 .RowSource = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
3620:             ENDWITH
3621: 
3622:             *-- OptionGroups Sim/Nao (Integracao Contabil)
3623:             loc_oPag2.AddObject("opg_4c_Agrupas", "OptionGroup")
3624:             WITH loc_oPag2.opg_4c_Agrupas
3625:                 .Top = 79
3626:                 .Left = 638
3627:                 .Height = 27
3628:                 .Width = 94
3629:                 .ButtonCount = 2
3630:                 .BorderStyle = 0
3631:                 .Buttons(1).Caption = "Sim"
3632:                 .Buttons(1).Left = 5
3633:                 .Buttons(1).Top = 5
3634:                 .Buttons(1).Width = 40
3635:                 .Buttons(1).Height = 17
3636:                 .Buttons(1).AutoSize = .F.
3637:                 .Buttons(1).BackStyle = 0
3638:                 .Buttons(1).FontName = "Tahoma"
3639:                 .Buttons(1).FontSize = 8
3640:                 .Buttons(1).ForeColor = RGB(90,90,90)
3641:                 .Buttons(1).Themes = .F.
3642:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3643:                 .Buttons(2).Left = 51
3644:                 .Buttons(2).Top = 5
3645:                 .Buttons(2).Width = 40
3646:                 .Buttons(2).Height = 17
3647:                 .Buttons(2).AutoSize = .F.
3648:                 .Buttons(2).BackStyle = 0
3649:                 .Buttons(2).FontName = "Tahoma"
3650:                 .Buttons(2).FontSize = 8
3651:                 .Buttons(2).ForeColor = RGB(90,90,90)
3652:                 .Buttons(2).Themes = .F.
3653:             ENDWITH
3654: 
3655:             loc_oPag2.AddObject("opg_4c_Zeradas", "OptionGroup")
3656:             WITH loc_oPag2.opg_4c_Zeradas
3657:                 .Top = 103
3658:                 .Left = 638
3659:                 .Height = 27
3660:                 .Width = 94
3661:                 .ButtonCount = 2
3662:                 .BorderStyle = 0
3663:                 .Buttons(1).Caption = "Sim"
3664:                 .Buttons(1).Left = 5
3665:                 .Buttons(1).Top = 5
3666:                 .Buttons(1).Width = 40
3667:                 .Buttons(1).Height = 17
3668:                 .Buttons(1).AutoSize = .F.
3669:                 .Buttons(1).BackStyle = 0
3670:                 .Buttons(1).FontName = "Tahoma"
3671:                 .Buttons(1).FontSize = 8
3672:                 .Buttons(1).ForeColor = RGB(90,90,90)
3673:                 .Buttons(1).Themes = .F.
3674:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3675:                 .Buttons(2).Left = 51
3676:                 .Buttons(2).Top = 5
3677:                 .Buttons(2).Width = 40
3678:                 .Buttons(2).Height = 17
3679:                 .Buttons(2).AutoSize = .F.
3680:                 .Buttons(2).BackStyle = 0
3681:                 .Buttons(2).FontName = "Tahoma"
3682:                 .Buttons(2).FontSize = 8
3683:                 .Buttons(2).ForeColor = RGB(90,90,90)
3684:                 .Buttons(2).Themes = .F.
3685:             ENDWITH
3686: 
3687:             loc_oPag2.AddObject("opg_4c_DtIntFis", "OptionGroup")
3688:             WITH loc_oPag2.opg_4c_DtIntFis
3689:                 .Top = 127
3690:                 .Left = 638
3691:                 .Height = 27
3692:                 .Width = 192
3693:                 .ButtonCount = 2
3694:                 .BorderStyle = 0
3695:                 .Buttons(1).Caption = "Data Integra" + CHR(231) + CHR(227) + "o"
3696:                 .Buttons(1).Left = 5
3697:                 .Buttons(1).Top = 5
3698:                 .Buttons(1).Width = 97
3699:                 .Buttons(1).AutoSize = .T.
3700:                 .Buttons(1).BackStyle = 0
3701:                 .Buttons(1).FontName = "Tahoma"
3702:                 .Buttons(1).FontSize = 8
3703:                 .Buttons(1).ForeColor = RGB(90,90,90)
3704:                 .Buttons(1).Themes = .F.
3705:                 .Buttons(2).Caption = "Data N.F."
3706:                 .Buttons(2).Left = 122
3707:                 .Buttons(2).Top = 7
3708:                 .Buttons(2).Width = 65
3709:                 .Buttons(2).AutoSize = .T.
3710:                 .Buttons(2).BackStyle = 0
3711:                 .Buttons(2).FontName = "Tahoma"
3712:                 .Buttons(2).FontSize = 8
3713:                 .Buttons(2).ForeColor = RGB(90,90,90)
3714:                 .Buttons(2).Themes = .F.
3715:             ENDWITH
3716: 
3717:             loc_oPag2.AddObject("opg_4c_UtilVars", "OptionGroup")
3718:             WITH loc_oPag2.opg_4c_UtilVars
3719:                 .Top = 150
3720:                 .Left = 638
3721:                 .Height = 27
3722:                 .Width = 94
3723:                 .ButtonCount = 2
3724:                 .BorderStyle = 0
3725:                 .Buttons(1).Caption = "Sim"
3726:                 .Buttons(1).Left = 5
3727:                 .Buttons(1).Top = 5
3728:                 .Buttons(1).Width = 40
3729:                 .Buttons(1).Height = 17
3730:                 .Buttons(1).AutoSize = .F.
3731:                 .Buttons(1).BackStyle = 0
3732:                 .Buttons(1).FontName = "Tahoma"
3733:                 .Buttons(1).FontSize = 8
3734:                 .Buttons(1).ForeColor = RGB(90,90,90)
3735:                 .Buttons(1).Themes = .F.
3736:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3737:                 .Buttons(2).Left = 51
3738:                 .Buttons(2).Top = 5
3739:                 .Buttons(2).Width = 40
3740:                 .Buttons(2).Height = 17
3741:                 .Buttons(2).AutoSize = .F.
3742:                 .Buttons(2).BackStyle = 0
3743:                 .Buttons(2).FontName = "Tahoma"
3744:                 .Buttons(2).FontSize = 8
3745:                 .Buttons(2).ForeColor = RGB(90,90,90)
3746:                 .Buttons(2).Themes = .F.
3747:             ENDWITH
3748: 
3749:             *-- OptionGroups Sim/Nao (Integracao Fiscal)
3750:             loc_oPag2.AddObject("opg_4c_IntVlrCont", "OptionGroup")
3751:             WITH loc_oPag2.opg_4c_IntVlrCont
3752:                 .Top = 233
3753:                 .Left = 231
3754:                 .Height = 27
3755:                 .Width = 94
3756:                 .ButtonCount = 2
3757:                 .BorderStyle = 0
3758:                 .Buttons(1).Caption = "Sim"
3759:                 .Buttons(1).Left = 5
3760:                 .Buttons(1).Top = 5
3761:                 .Buttons(1).Width = 40
3762:                 .Buttons(1).Height = 17
3763:                 .Buttons(1).AutoSize = .F.
3764:                 .Buttons(1).BackStyle = 0
3765:                 .Buttons(1).FontName = "Tahoma"
3766:                 .Buttons(1).FontSize = 8
3767:                 .Buttons(1).ForeColor = RGB(90,90,90)
3768:                 .Buttons(1).Themes = .F.
3769:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3770:                 .Buttons(2).Left = 51
3771:                 .Buttons(2).Top = 5
3772:                 .Buttons(2).Width = 40
3773:                 .Buttons(2).Height = 17
3774:                 .Buttons(2).AutoSize = .F.
3775:                 .Buttons(2).BackStyle = 0
3776:                 .Buttons(2).FontName = "Tahoma"
3777:                 .Buttons(2).FontSize = 8
3778:                 .Buttons(2).ForeColor = RGB(90,90,90)
3779:                 .Buttons(2).Themes = .F.
3780:             ENDWITH
3781: 
3782:             loc_oPag2.AddObject("opg_4c_IntVlrIcms", "OptionGroup")
3783:             WITH loc_oPag2.opg_4c_IntVlrIcms
3784:                 .Top = 253
3785:                 .Left = 231
3786:                 .Height = 27
3787:                 .Width = 94
3788:                 .ButtonCount = 2
3789:                 .BorderStyle = 0
3790:                 .Buttons(1).Caption = "Sim"
3791:                 .Buttons(1).Left = 5
3792:                 .Buttons(1).Top = 5
3793:                 .Buttons(1).Width = 40
3794:                 .Buttons(1).Height = 17
3795:                 .Buttons(1).AutoSize = .F.
3796:                 .Buttons(1).BackStyle = 0
3797:                 .Buttons(1).FontName = "Tahoma"
3798:                 .Buttons(1).FontSize = 8
3799:                 .Buttons(1).ForeColor = RGB(90,90,90)
3800:                 .Buttons(1).Themes = .F.
3801:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3802:                 .Buttons(2).Left = 51
3803:                 .Buttons(2).Top = 5
3804:                 .Buttons(2).Width = 40
3805:                 .Buttons(2).Height = 17
3806:                 .Buttons(2).AutoSize = .F.
3807:                 .Buttons(2).BackStyle = 0
3808:                 .Buttons(2).FontName = "Tahoma"
3809:                 .Buttons(2).FontSize = 8
3810:                 .Buttons(2).ForeColor = RGB(90,90,90)
3811:                 .Buttons(2).Themes = .F.
3812:             ENDWITH
3813: 
3814:             loc_oPag2.AddObject("opg_4c_IntVlrIpi", "OptionGroup")
3815:             WITH loc_oPag2.opg_4c_IntVlrIpi
3816:                 .Top = 272
3817:                 .Left = 231
3818:                 .Height = 27
3819:                 .Width = 94
3820:                 .ButtonCount = 2
3821:                 .BorderStyle = 0
3822:                 .Buttons(1).Caption = "Sim"
3823:                 .Buttons(1).Left = 5
3824:                 .Buttons(1).Top = 5
3825:                 .Buttons(1).Width = 40
3826:                 .Buttons(1).Height = 17
3827:                 .Buttons(1).AutoSize = .F.
3828:                 .Buttons(1).BackStyle = 0
3829:                 .Buttons(1).FontName = "Tahoma"
3830:                 .Buttons(1).FontSize = 8
3831:                 .Buttons(1).ForeColor = RGB(90,90,90)
3832:                 .Buttons(1).Themes = .F.
3833:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3834:                 .Buttons(2).Left = 51
3835:                 .Buttons(2).Top = 5
3836:                 .Buttons(2).Width = 40
3837:                 .Buttons(2).Height = 17
3838:                 .Buttons(2).AutoSize = .F.
3839:                 .Buttons(2).BackStyle = 0
3840:                 .Buttons(2).FontName = "Tahoma"
3841:                 .Buttons(2).FontSize = 8
3842:                 .Buttons(2).ForeColor = RGB(90,90,90)
3843:                 .Buttons(2).Themes = .F.
3844:             ENDWITH
3845: 
3846:             loc_oPag2.AddObject("opg_4c_IndMov", "OptionGroup")
3847:             WITH loc_oPag2.opg_4c_IndMov
3848:                 .Top = 292
3849:                 .Left = 231
3850:                 .Height = 27
3851:                 .Width = 94
3852:                 .ButtonCount = 2
3853:                 .BorderStyle = 0
3854:                 .Buttons(1).Caption = "Sim"
3855:                 .Buttons(1).Left = 5
3856:                 .Buttons(1).Top = 5
3857:                 .Buttons(1).Width = 40
3858:                 .Buttons(1).Height = 17
3859:                 .Buttons(1).AutoSize = .F.
3860:                 .Buttons(1).BackStyle = 0
3861:                 .Buttons(1).FontName = "Tahoma"
3862:                 .Buttons(1).FontSize = 8
3863:                 .Buttons(1).ForeColor = RGB(90,90,90)
3864:                 .Buttons(1).Themes = .F.
3865:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3866:                 .Buttons(2).Left = 51
3867:                 .Buttons(2).Top = 5
3868:                 .Buttons(2).Width = 40
3869:                 .Buttons(2).Height = 17
3870:                 .Buttons(2).AutoSize = .F.
3871:                 .Buttons(2).BackStyle = 0
3872:                 .Buttons(2).FontName = "Tahoma"
3873:                 .Buttons(2).FontSize = 8
3874:                 .Buttons(2).ForeColor = RGB(90,90,90)
3875:                 .Buttons(2).Themes = .F.
3876:             ENDWITH
3877: 
3878:             loc_oPag2.AddObject("opg_4c_IndPagto", "OptionGroup")
3879:             WITH loc_oPag2.opg_4c_IndPagto
3880:                 .Top = 312
3881:                 .Left = 231
3882:                 .Height = 27
3883:                 .Width = 94
3884:                 .ButtonCount = 2
3885:                 .BorderStyle = 0
3886:                 .Buttons(1).Caption = "Sim"
3887:                 .Buttons(1).Left = 5
3888:                 .Buttons(1).Top = 5
3889:                 .Buttons(1).Width = 40
3890:                 .Buttons(1).Height = 17
3891:                 .Buttons(1).AutoSize = .F.
3892:                 .Buttons(1).BackStyle = 0
3893:                 .Buttons(1).FontName = "Tahoma"
3894:                 .Buttons(1).FontSize = 8
3895:                 .Buttons(1).ForeColor = RGB(90,90,90)
3896:                 .Buttons(1).Themes = .F.
3897:                 .Buttons(2).Caption = "N" + CHR(227) + "o"
3898:                 .Buttons(2).Left = 51
3899:                 .Buttons(2).Top = 5
3900:                 .Buttons(2).Width = 40
3901:                 .Buttons(2).Height = 17
3902:                 .Buttons(2).AutoSize = .F.
3903:                 .Buttons(2).BackStyle = 0
3904:                 .Buttons(2).FontName = "Tahoma"
3905:                 .Buttons(2).FontSize = 8
3906:                 .Buttons(2).ForeColor = RGB(90,90,90)
3907:                 .Buttons(2).Themes = .F.
3908:             ENDWITH
3909: 
3910:             *-- BINDEVENT: Enter=13 para validar contas contra SigCdCli
3911:             BINDEVENT(loc_oPag2.txt_4c_ContFrt, "KeyPress", THIS, "ValidarContFrtKeyPress")
3912:             BINDEVENT(loc_oPag2.txt_4c_ContSeg, "KeyPress", THIS, "ValidarContSegKeyPress")
3913:             BINDEVENT(loc_oPag2.txt_4c_ContDa,  "KeyPress", THIS, "ValidarContDaKeyPress")
3914: 
3915:         CATCH TO loException
3916:             MostrarErro("Erro ao criar controles Page2:" + CHR(13) + loException.Message, "Erro")
3917:         ENDTRY
3918:     ENDPROC
3919: 
3920:     *==========================================================================
3921:     * KeyPressCfoST60Handler - F4 abre lookup CFOP para txt_4c_CfoST60
3922:     *==========================================================================
3923:     PROCEDURE KeyPressCfoST60Handler(par_nKeyCode, par_nShiftAltCtrl)
3924:         IF INLIST(par_nKeyCode, 115, 116)
3925:             THIS.AbrirLookupCfoST60()
3926:         ENDIF
3927:     ENDPROC
3928: 
3929:     PROCEDURE AbrirLookupCfoST60()
3930:         LOCAL loc_oForm, loc_oPag1, loc_cValor
3931:         TRY
3932:             loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3933:             loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoST60.Value)
3934:             loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3935:                 "SigCdCfo", "cursor_4c_BuscaCfoST60", "Codigos", loc_cValor, ;
3936:                 "Buscar CFOP")
3937:             IF !ISNULL(loc_oForm)
3938:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
3939:                     loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.Codigos)
3940:                 ELSE
3941:                     loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
3942:                     loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3943:                     loc_oForm.Show()
3944:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
3945:                         loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.Codigos)
3946:                     ENDIF
3947:                 ENDIF
3948:                 IF USED("cursor_4c_BuscaCfoST60")
3949:                     USE IN cursor_4c_BuscaCfoST60
3950:                 ENDIF
3951:                 loc_oForm.Release()
3952:             ENDIF
3953:         CATCH TO loException
3954:             MostrarErro("Erro no lookup CfoST60:" + CHR(13) + loException.Message, "Erro")
3955:         ENDTRY
3956:     ENDPROC
3957: 
3958:     *==========================================================================
3959:     * KeyPressCfoSTHandler - F4 abre lookup CFOP para txt_4c_CfoST
3960:     *==========================================================================
3961:     PROCEDURE KeyPressCfoSTHandler(par_nKeyCode, par_nShiftAltCtrl)
3962:         IF INLIST(par_nKeyCode, 115, 116)
3963:             THIS.AbrirLookupCfoST()
3964:         ENDIF
3965:     ENDPROC
3966: 
3967:     PROCEDURE AbrirLookupCfoST()
3968:         LOCAL loc_oForm, loc_oPag1, loc_cValor
3969:         TRY
3970:             loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
3971:             loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoST.Value)
3972:             loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3973:                 "SigCdCfo", "cursor_4c_BuscaCfoST", "Codigos", loc_cValor, ;
3974:                 "Buscar CFOP")
3975:             IF !ISNULL(loc_oForm)
3976:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
3977:                     loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.Codigos)
3978:                 ELSE
3979:                     loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
3980:                     loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3981:                     loc_oForm.Show()
3982:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
3983:                         loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.Codigos)
3984:                     ENDIF
3985:                 ENDIF
3986:                 IF USED("cursor_4c_BuscaCfoST")
3987:                     USE IN cursor_4c_BuscaCfoST
3988:                 ENDIF
3989:                 loc_oForm.Release()
3990:             ENDIF
3991:         CATCH TO loException
3992:             MostrarErro("Erro no lookup CfoST:" + CHR(13) + loException.Message, "Erro")
3993:         ENDTRY
3994:     ENDPROC
3995: 
3996:     *==========================================================================
3997:     * KeyPressCfoDestHandler - F4 abre lookup CFOP para txt_4c_CfoDest
3998:     *==========================================================================
3999:     PROCEDURE KeyPressCfoDestHandler(par_nKeyCode, par_nShiftAltCtrl)
4000:         IF INLIST(par_nKeyCode, 115, 116)
4001:             THIS.AbrirLookupCfoDest()
4002:         ENDIF
4003:     ENDPROC
4004: 
4005:     PROCEDURE AbrirLookupCfoDest()
4006:         LOCAL loc_oForm, loc_oPag1, loc_cValor
4007:         TRY
4008:             loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4009:             loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoDest.Value)
4010:             loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4011:                 "SigCdCfo", "cursor_4c_BuscaCfoDest", "Codigos", loc_cValor, ;
4012:                 "Buscar CFOP")
4013:             IF !ISNULL(loc_oForm)
4014:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
4015:                     loc_oPag1.txt_4c_CfoDest.Value = ALLTRIM(cursor_4c_BuscaCfoDest.Codigos)
4016:                 ELSE
4017:                     loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4018:                     loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4019:                     loc_oForm.Show()
4020:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoDest")
4021:                         loc_oPag1.txt_4c_CfoDest.Value = ALLTRIM(cursor_4c_BuscaCfoDest.Codigos)
4022:                     ENDIF
4023:                 ENDIF
4024:                 IF USED("cursor_4c_BuscaCfoDest")
4025:                     USE IN cursor_4c_BuscaCfoDest
4026:                 ENDIF
4027:                 loc_oForm.Release()
4028:             ENDIF
4029:         CATCH TO loException
4030:             MostrarErro("Erro no lookup CfoDest:" + CHR(13) + loException.Message, "Erro")
4031:         ENDTRY
4032:     ENDPROC
4033: 
4034:     *==========================================================================
4035:     * KeyPressSittricmHandler - F4 abre lookup SigCdIcm para txt_4c_Sittricm
4036:     *==========================================================================
4037:     PROCEDURE KeyPressSittricmHandler(par_nKeyCode, par_nShiftAltCtrl)
4038:         IF INLIST(par_nKeyCode, 115, 116)
4039:             THIS.AbrirLookupSittricm()
4040:         ENDIF
4041:     ENDPROC
4042: 
4043:     PROCEDURE AbrirLookupSittricm()
4044:         LOCAL loc_oForm, loc_oPag1, loc_cValor
4045:         TRY
4046:             loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4047:             loc_cValor = ALLTRIM(loc_oPag1.txt_4c_Sittricm.Value)
4048:             loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4049:                 "SigCdIcm", "cursor_4c_BuscaSittricm", "Codigos", loc_cValor, ;
4050:                 "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
4051:             IF !ISNULL(loc_oForm)
4052:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
4053:                     loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
4054:                 ELSE
4055:                     loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4056:                     loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4057:                     loc_oForm.Show()
4058:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
4059:                         loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
4060:                     ENDIF
4061:                 ENDIF
4062:                 IF USED("cursor_4c_BuscaSittricm")
4063:                     USE IN cursor_4c_BuscaSittricm
4064:                 ENDIF
4065:                 loc_oForm.Release()
4066:             ENDIF
4067:         CATCH TO loException
4068:             MostrarErro("Erro no lookup Sittricm:" + CHR(13) + loException.Message, "Erro")
4069:         ENDTRY
4070:     ENDPROC
4071: 
4072:     *==========================================================================
4073:     * ValidarIPICSTKeyPress - Valida CST IPI ao pressionar Enter
4074:     * Codigos validos: 00-05, 49-55, 99
4075:     *==========================================================================
4076:     PROCEDURE ValidarIPICSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4077:         LOCAL loc_cVal, loc_oPag1
4078:         IF par_nKeyCode = 13
4079:             TRY
4080:                 loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4081:                 loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_IPICST.Value)
4082:                 IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "00","01","02","03","04","05","49","50","51","52","53","54","55","99")
4083:                     MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para IPI CST:" + CHR(13) + ;
4084:                              "00-Entrada com recupera" + CHR(231) + CHR(227) + "o de cr" + CHR(233) + "dito" + CHR(13) + ;
4085:                              "01 a 05-Entrada (tributada/isenta/nao-trib/imune/suspensao)" + CHR(13) + ;
4086:                              "49-Outras entradas" + CHR(13) + ;
4087:                              "50-Sa" + CHR(237) + "da tributada" + CHR(13) + ;
4088:                              "51 a 55-Sa" + CHR(237) + "da (aliq zero/isenta/nao-trib/imune/suspensao)" + CHR(13) + ;
4089:                              "99-Outras sa" + CHR(237) + "das", "Aten" + CHR(231) + CHR(227) + "o")
4090:                 ENDIF
4091:             CATCH TO loException
4092:                 MostrarErro("Erro validacao IPICST:" + CHR(13) + loException.Message, "Erro")
4093:             ENDTRY
4094:         ENDIF
4095:     ENDPROC
4096: 
4097:     *==========================================================================
4098:     * ValidarPISCSTKeyPress - Valida CST PIS ao pressionar Enter
4099:     * Codigos validos: 01-04, 06-09, 49, 50, 70, 99
4100:     *==========================================================================
4101:     PROCEDURE ValidarPISCSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4102:         LOCAL loc_cVal, loc_oPag1
4103:         IF par_nKeyCode = 13
4104:             TRY
4105:                 loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4106:                 loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_PISCST.Value)
4107:                 IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "01","02","03","04","06","07","08","09","49","50","70","99")
4108:                     MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para PIS CST:" + CHR(13) + ;
4109:                              "01-04: Opera" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "vel" + CHR(13) + ;
4110:                              "06: Opera" + CHR(231) + CHR(227) + "o Al" + CHR(237) + "quota Zero" + CHR(13) + ;
4111:                              "07: Opera" + CHR(231) + CHR(227) + "o Isenta" + CHR(13) + ;
4112:                              "08: Sem Incid" + CHR(234) + "ncia" + CHR(13) + ;
4113:                              "09: Com Suspens" + CHR(227) + "o" + CHR(13) + ;
4114:                              "49: Sa" + CHR(237) + "das n" + CHR(227) + "o representativas de receita" + CHR(13) + ;
4115:                              "50: Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
4116:                              "70: Sem Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
4117:                              "99: Outras Opera" + CHR(231) + CHR(245) + "es", "Aten" + CHR(231) + CHR(227) + "o")
4118:                 ENDIF
4119:             CATCH TO loException
4120:                 MostrarErro("Erro validacao PISCST:" + CHR(13) + loException.Message, "Erro")
4121:             ENDTRY
4122:         ENDIF
4123:     ENDPROC
4124: 
4125:     *==========================================================================
4126:     * ValidarCOFCSTKeyPress - Valida CST COFINS ao pressionar Enter
4127:     * Codigos validos: 01-04, 06-09, 49, 50, 70, 99
4128:     *==========================================================================
4129:     PROCEDURE ValidarCOFCSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4130:         LOCAL loc_cVal, loc_oPag1
4131:         IF par_nKeyCode = 13
4132:             TRY
4133:                 loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4134:                 loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_COFCST.Value)
4135:                 IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "01","02","03","04","06","07","08","09","49","50","70","99")
4136:                     MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para COFINS CST:" + CHR(13) + ;
4137:                              "01-04: Opera" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "vel" + CHR(13) + ;
4138:                              "06: Opera" + CHR(231) + CHR(227) + "o Al" + CHR(237) + "quota Zero" + CHR(13) + ;
4139:                              "07: Opera" + CHR(231) + CHR(227) + "o Isenta" + CHR(13) + ;
4140:                              "08: Sem Incid" + CHR(234) + "ncia" + CHR(13) + ;
4141:                              "09: Com Suspens" + CHR(227) + "o" + CHR(13) + ;
4142:                              "49: Sa" + CHR(237) + "das n" + CHR(227) + "o representativas de receita" + CHR(13) + ;
4143:                              "50: Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
4144:                              "70: Sem Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
4145:                              "99: Outras Opera" + CHR(231) + CHR(245) + "es", "Aten" + CHR(231) + CHR(227) + "o")
4146:                 ENDIF
4147:             CATCH TO loException
4148:                 MostrarErro("Erro validacao COFCST:" + CHR(13) + loException.Message, "Erro")
4149:             ENDTRY
4150:         ENDIF
4151:     ENDPROC
4152: 
4153:     *==========================================================================
4154:     * ValidarContFrtKeyPress - Valida conta de frete contra SigCdCli ao Enter
4155:     *==========================================================================
4156:     PROCEDURE ValidarContFrtKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4157:         LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
4158:         IF par_nKeyCode = 13
4159:             TRY
4160:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4161:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContFrt.Value)
4162:                 IF !EMPTY(loc_cVal)
4163:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
4164:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4165:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4166:                         IF cursor_4c_ChkConta.nExiste = 0
4167:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4168:                         ENDIF
4169:                         USE IN cursor_4c_ChkConta
4170:                     ENDIF
4171:                 ENDIF
4172:             CATCH TO loException
4173:                 MostrarErro("Erro validacao ContFrt:" + CHR(13) + loException.Message, "Erro")
4174:             ENDTRY
4175:         ENDIF
4176:     ENDPROC
4177: 
4178:     *==========================================================================
4179:     * ValidarContSegKeyPress - Valida conta de seguro contra SigCdCli ao Enter
4180:     *==========================================================================
4181:     PROCEDURE ValidarContSegKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4182:         LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
4183:         IF par_nKeyCode = 13
4184:             TRY
4185:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4186:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContSeg.Value)
4187:                 IF !EMPTY(loc_cVal)
4188:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
4189:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4190:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4191:                         IF cursor_4c_ChkConta.nExiste = 0
4192:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4193:                         ENDIF
4194:                         USE IN cursor_4c_ChkConta
4195:                     ENDIF
4196:                 ENDIF
4197:             CATCH TO loException
4198:                 MostrarErro("Erro validacao ContSeg:" + CHR(13) + loException.Message, "Erro")
4199:             ENDTRY
4200:         ENDIF
4201:     ENDPROC
4202: 
4203:     *==========================================================================
4204:     * ValidarContDaKeyPress - Valida conta de despesas contra SigCdCli ao Enter
4205:     *==========================================================================
4206:     PROCEDURE ValidarContDaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4207:         LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
4208:         IF par_nKeyCode = 13
4209:             TRY
4210:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4211:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContDa.Value)
4212:                 IF !EMPTY(loc_cVal)
4213:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
4214:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4215:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4216:                         IF cursor_4c_ChkConta.nExiste = 0
4217:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4218:                         ENDIF
4219:                         USE IN cursor_4c_ChkConta
4220:                     ENDIF
4221:                 ENDIF
4222:             CATCH TO loException
4223:                 MostrarErro("Erro validacao ContDa:" + CHR(13) + loException.Message, "Erro")
4224:             ENDTRY
4225:         ENDIF
4226:     ENDPROC
4227: 
4228:     *==========================================================================
4229:     * BipiChangeHandler - Se base IPI nao for F ou P, zera percentual BcIPI
4230:     * Original: CmbBIPI.LostFocus
4231:     *==========================================================================
4232:     PROCEDURE BipiChangeHandler()
4233:         LOCAL loc_oPag1, loc_cPrimeiro
4234:         TRY
4235:             loc_oPag1    = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4236:             loc_cPrimeiro = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_BIPI.Value)), 1)
4237:             IF !INLIST(loc_cPrimeiro, "F", "P")
4238:                 loc_oPag1.txt_4c_BcIPI.Value = 0
4239:             ENDIF
4240:         CATCH TO loException
4241:             MostrarErro("Erro BipiChangeHandler:" + CHR(13) + loException.Message, "Erro")
4242:         ENDTRY
4243:     ENDPROC
4244: 
4245:     *==========================================================================
4246:     * IpiIChangeHandler - Habilita/desabilita cmb_4c_RetiraIPI conforme cmbIpiI
4247:     * Original: cmbIpiI.Valid - Se "Sim" habilita RetiraIPI; senao desabilita
4248:     *==========================================================================
4249:     PROCEDURE IpiIChangeHandler()
4250:         LOCAL loc_oPag1, loc_cPrimeiro
4251:         TRY
4252:             loc_oPag1    = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4253:             loc_cPrimeiro = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiI.Value)), 1)
4254:             loc_oPag1.cmb_4c_RetiraIPI.Enabled = (loc_cPrimeiro = "S")
4255:         CATCH TO loException
4256:             MostrarErro("Erro IpiIChangeHandler:" + CHR(13) + loException.Message, "Erro")
4257:         ENDTRY
4258:     ENDPROC
4259: 
4260: ENDDEFINE


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*============================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal)
* Tabela: SigCdCfo | PK: codigos
*============================================================
DEFINE CLASS cfoBO AS BusinessBase

    *-- Propriedades char - SigCdCfo
    this_cCodigos     = ""  && char(10) - PK
    this_cDescricaos  = ""  && char(60)
    this_cDesc2s      = ""  && char(60)
    this_cContconts   = ""  && char(1)
    this_cContribs    = ""  && char(1)
    this_cIcms        = ""  && char(1)
    this_cIpis        = ""  && char(1)
    this_cOperacaos   = ""  && char(1)
    this_cContvcds    = ""  && char(9)
    this_cContvccs    = ""  && char(9)
    this_cContipcs    = ""  && char(9)
    this_cContipds    = ""  && char(9)
    this_cConticcs    = ""  && char(9)
    this_cConticds    = ""  && char(9)
    this_cCoddests    = ""  && char(10)
    this_cSittribs    = ""  && char(3)
    this_cIpi_Icms    = ""  && char(1)
    this_cCgergia1s   = ""  && char(1)
    this_cBcipis      = ""  && char(1)
    this_cCfosts      = ""  && char(10)
    this_cSubtribs    = ""  && char(1)
    this_cAcresipis   = ""  && char(1)
    this_cIpiimpors   = ""  && char(1)
    this_cIpiom2s     = ""  && char(1)
    this_cUnitimps    = ""  && char(1)
    this_cContda      = ""  && char(9)
    this_cContfrt     = ""  && char(9)
    this_cContseg     = ""  && char(9)
    this_cIpicst      = ""  && char(2)
    this_cPiscst      = ""  && char(2)
    this_cCofcst      = ""  && char(2)
    this_cIssqnl      = ""  && char(5)
    this_cCfost60s    = ""  && char(10)
    this_cIpienq      = ""  && char(3)
    this_cMotdeson    = ""  && char(2)

    *-- Propriedades numeric - SigCdCfo
    this_nAliqipis    = 0   && numeric(4,2)
    this_nIpincreds   = 0   && numeric(1,0)
    this_nPontedescs  = 0   && numeric(1,0)
    this_nAliqivcs    = 0   && numeric(4,2)
    this_nNdigitos    = 0   && numeric(2,0)
    this_nInclicms    = 0   && numeric(1,0)
    this_nTransps     = 0   && numeric(1,0)
    this_nAgrupas     = 0   && numeric(1,0)
    this_nZeradas     = 0   && numeric(1,0)
    this_nIcmsdscs    = 0   && numeric(1,0)
    this_nInclipis    = 0   && numeric(1,0)
    this_nSituas      = 0   && numeric(1,0)
    this_nDesicms     = 0   && numeric(1,0)
    this_nDesipis     = 0   && numeric(1,0)
    this_nFrticms     = 0   && numeric(1,0)
    this_nFrtipis     = 0   && numeric(1,0)
    this_nPbcipis     = 0   && numeric(5,2)
    this_nPbcsts      = 0   && numeric(5,2)
    this_nSegicms     = 0   && numeric(1,0)
    this_nSegipis     = 0   && numeric(1,0)
    this_nDtintfis    = 0   && numeric(1,0)
    this_nIntvlrcont  = 0   && numeric(1,0)
    this_nIntvlricms  = 0   && numeric(1,0)
    this_nIntvlripi   = 0   && numeric(1,0)
    this_nIcmsincs    = 0   && numeric(1,0)
    this_nIncicmnfs   = 0   && numeric(1,0)
    this_nTipos       = 0   && numeric(1,0)
    this_nUtilvars    = 0   && numeric(1,0)
    this_nIndmov      = 0   && numeric(1,0)
    this_nIndpagto    = 0   && numeric(1,0)
    this_nTiporecs    = 0   && numeric(1,0)
    this_nAliqcofins  = 0   && numeric(5,2)
    this_nAliqpis     = 0   && numeric(5,2)
    this_nAliqissqn   = 0   && numeric(5,2)
    this_nCtissqn     = 0   && numeric(1,0)
    this_nRettribs    = 0   && numeric(1,0)
    this_nAliqii      = 0   && numeric(5,2)
    this_nObspads     = 0   && numeric(3,0)
    this_nSomaicmfrete = 0  && numeric(1,0)

    *============================================================
    PROCEDURE Init()
    *============================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIpi_Icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCfo (
                    codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                    icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                    conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                    aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                    agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                    desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                    segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                    ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                    icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                    indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                    aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                    cfost60s, obspads, ipienq, somaicmfrete, motdeson
                ) VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cContconts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    <<EscaparSQL(THIS.this_cContribs)>>,
                    <<EscaparSQL(THIS.this_cDescricaos)>>,
                    <<EscaparSQL(THIS.this_cDesc2s)>>,
                    <<EscaparSQL(THIS.this_cIcms)>>,
                    <<EscaparSQL(THIS.this_cIpis)>>,
                    <<EscaparSQL(THIS.this_cOperacaos)>>,
                    <<EscaparSQL(THIS.this_cContvcds)>>,
                    <<EscaparSQL(THIS.this_cContvccs)>>,
                    <<EscaparSQL(THIS.this_cContipcs)>>,
                    <<EscaparSQL(THIS.this_cContipds)>>,
                    <<EscaparSQL(THIS.this_cConticcs)>>,
                    <<EscaparSQL(THIS.this_cConticds)>>,
                    <<EscaparSQL(THIS.this_cCoddests)>>,
                    <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    <<EscaparSQL(THIS.this_cSittribs)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cBcipis)>>,
                    <<EscaparSQL(THIS.this_cCfosts)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    <<EscaparSQL(THIS.this_cSubtribs)>>,
                    <<EscaparSQL(THIS.this_cAcresipis)>>,
                    <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    <<EscaparSQL(THIS.this_cUnitimps)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    <<EscaparSQL(THIS.this_cContda)>>,
                    <<EscaparSQL(THIS.this_cContfrt)>>,
                    <<EscaparSQL(THIS.this_cContseg)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    <<EscaparSQL(THIS.this_cIpicst)>>,
                    <<EscaparSQL(THIS.this_cPiscst)>>,
                    <<EscaparSQL(THIS.this_cCofcst)>>,
                    <<EscaparSQL(THIS.this_cIssqnl)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    <<EscaparSQL(THIS.this_cCfost60s)>>,
                    <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    <<EscaparSQL(THIS.this_cIpienq)>>,
                    <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    <<EscaparSQL(THIS.this_cMotdeson)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCfo SET
                    contconts    = <<EscaparSQL(THIS.this_cContconts)>>,
                    aliqipis     = <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    contribs     = <<EscaparSQL(THIS.this_cContribs)>>,
                    descricaos   = <<EscaparSQL(THIS.this_cDescricaos)>>,
                    desc2s       = <<EscaparSQL(THIS.this_cDesc2s)>>,
                    icms         = <<EscaparSQL(THIS.this_cIcms)>>,
                    ipis         = <<EscaparSQL(THIS.this_cIpis)>>,
                    operacaos    = <<EscaparSQL(THIS.this_cOperacaos)>>,
                    contvcds     = <<EscaparSQL(THIS.this_cContvcds)>>,
                    contvccs     = <<EscaparSQL(THIS.this_cContvccs)>>,
                    contipcs     = <<EscaparSQL(THIS.this_cContipcs)>>,
                    contipds     = <<EscaparSQL(THIS.this_cContipds)>>,
                    conticcs     = <<EscaparSQL(THIS.this_cConticcs)>>,
                    conticds     = <<EscaparSQL(THIS.this_cConticds)>>,
                    coddests     = <<EscaparSQL(THIS.this_cCoddests)>>,
                    ipincreds    = <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    pontedescs   = <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    sittribs     = <<EscaparSQL(THIS.this_cSittribs)>>,
                    aliqivcs     = <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    ndigitos     = <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    ipi_icms     = <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    inclicms     = <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    cgergia1s    = <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    transps      = <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    agrupas      = <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    zeradas      = <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    icmsdscs     = <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    inclipis     = <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    situas       = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    bcipis       = <<EscaparSQL(THIS.this_cBcipis)>>,
                    cfosts       = <<EscaparSQL(THIS.this_cCfosts)>>,
                    desicms      = <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    desipis      = <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    frticms      = <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    frtipis      = <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    pbcipis      = <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    pbcsts       = <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    segicms      = <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    segipis      = <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    subtribs     = <<EscaparSQL(THIS.this_cSubtribs)>>,
                    acresipis    = <<EscaparSQL(THIS.this_cAcresipis)>>,
                    ipiimpors    = <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    dtintfis     = <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    ipiom2s      = <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    unitimps     = <<EscaparSQL(THIS.this_cUnitimps)>>,
                    intvlrcont   = <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    intvlricms   = <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    intvlripi    = <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    icmsincs     = <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    incicmnfs    = <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    tipos        = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    utilvars     = <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    contda       = <<EscaparSQL(THIS.this_cContda)>>,
                    contfrt      = <<EscaparSQL(THIS.this_cContfrt)>>,
                    contseg      = <<EscaparSQL(THIS.this_cContseg)>>,
                    indmov       = <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    indpagto     = <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    tiporecs     = <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    ipicst       = <<EscaparSQL(THIS.this_cIpicst)>>,
                    piscst       = <<EscaparSQL(THIS.this_cPiscst)>>,
                    cofcst       = <<EscaparSQL(THIS.this_cCofcst)>>,
                    issqnl       = <<EscaparSQL(THIS.this_cIssqnl)>>,
                    aliqcofins   = <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    aliqissqn    = <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    ctissqn      = <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    rettribs     = <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    aliqii       = <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    cfost60s     = <<EscaparSQL(THIS.this_cCfost60s)>>,
                    obspads      = <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    ipienq       = <<EscaparSQL(THIS.this_cIpienq)>>,
                    somaicmfrete = <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    motdeson     = <<EscaparSQL(THIS.this_cMotdeson)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCfo WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid (codigos, descricaos, situas)
    * DynamicForeColor usa situas para destacar registros inativos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, situas FROM SigCdCfo"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                       icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                       conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                       aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                       agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                       desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                       segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                       ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                       icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                       indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                       aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                       cfost60s, obspads, ipienq, somaicmfrete, motdeson
                FROM SigCdCfo
                WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCfo")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCfo")
                SELECT cursor_4c_ChkCfo
                loc_lExiste = (cursor_4c_ChkCfo.nExiste > 0)
                USE IN cursor_4c_ChkCfo
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "cfoBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

