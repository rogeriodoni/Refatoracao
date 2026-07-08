# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=7 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [CARGA-DADOS] Metodo ValidarDadosCgru faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosLin faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCol faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosIfor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosTam faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCodFinP faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCodacb faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCProEq faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosClass faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosLocal faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCuni faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosCunip faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosMctotal faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosMpvenda faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] Metodo ValidarDadosMfvenda faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=28 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5761 linhas total):

*-- Linhas 7 a 386:
7: *
8: * ESTRUTURA PILAR 1 (UX FIDELITY):
9: *   Page1 (Lista): Filtros + Grade (7 colunas) + Botoes CRUD + Saida
10: *   Page2 (Dados): OptionGroup-nav (7 botoes) + pgf_4c_DadosInternos (7 sub-paginas)
11: *                  + Salvar/Cancelar
12: * PILAR 2 (DB): SigCdPro, campos cpros/dpros/cbars/cgrus/ifors/reffs/etc.
13: * PILAR 3 (CODE): FormBase > FormProduto | ProdutoBO
14: *==============================================================================
15: 
16: DEFINE CLASS FormProduto AS FormBase
17: 
18:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY - Width=1000, Height=600 do legado)
19:     Height       = 600
20:     Width        = 1000
21:     Caption      = "Cadastro de Produtos"
22:     AutoCenter   = .T.
23:     ShowWindow   = 1
24:     WindowType   = 1
25:     ControlBox   = .F.
26:     Closable     = .F.
27:     MaxButton    = .F.
28:     TitleBar     = 0
29:     ClipControls = .F.
30:     Themes       = .F.
31:     BorderStyle  = 2
32: 
33:     *-- Propriedades do formulario
34:     this_oBusinessObject = .NULL.
35:     this_cMensagemErro   = ""      && OBRIGATORIO - nao herdado de FormBase
36:     this_cModoAtual      = "LISTA"
37:     this_lNovoRegistro   = .F.
38: 
39:     *--------------------------------------------------------------------------
40:     * Init - Inicializacao do formulario
41:     *--------------------------------------------------------------------------
42:     PROCEDURE Init()
43:         *-- DODEFAULT() ja chama InicializarForm() via FormBase.Init()
44:         RETURN DODEFAULT()
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configuracao inicial: BO + estrutura visual
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lSucesso
52:         loc_lSucesso = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
56: 
57:             IF ISNULL(THIS.this_oBusinessObject)
58:                 MsgErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.ConfigurarPaginaLista()
62:                 THIS.ConfigurarPaginaDados()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
67:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
68:                     IF !THIS.CarregarLista()
69:                         *-- Falha ao carregar nao impede abertura do formulario
70:                     ENDIF
71:                 ENDIF
72: 
73:                 THIS.pgf_4c_Paginas.Visible   = .T.
74:                 THIS.pgf_4c_Paginas.ActivePage = 1
75:                 THIS.this_cModoAtual           = "LISTA"
76:                 loc_lSucesso                   = .T.
77:             ENDIF
78: 
79:         CATCH TO loc_oErro
80:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
81:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
82:                 loc_oErro.Message, "Erro")
83:         ENDTRY
84: 
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarPageFrame - PageFrame principal (Top=-29 oculta abas)
90:     * Legado: Pagina Width=1003, Height=600, PageCount=2
91:     *--------------------------------------------------------------------------
92:     PROTECTED PROCEDURE ConfigurarPageFrame()
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94: 
95:         WITH THIS.pgf_4c_Paginas
96:             .Top        = -29
97:             .Left       = 0
98:             .Width      = 1003
99:             .Height     = 600
100:             .PageCount  = 2
101:             .Tabs       = .F.
102:             .Visible    = .T.
103: 
104:             *-- Page1 - Lista
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108: 
109:             *-- Page2 - Dados
110:             .Page2.Caption   = "Dados"
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.BackColor = RGB(255, 255, 255)
113:         ENDWITH
114:     ENDPROC
115: 
116:     *--------------------------------------------------------------------------
117:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
118:     * Compensacao +29: Top legado -> Top migrado (+29px por PageFrame.Top=-29)
119:     * Grupo_op: Top=-1+29=28  | cntFiltros: Top=82+29=111 | Grade: Top=173+29=202
120:     *--------------------------------------------------------------------------
121:     PROTECTED PROCEDURE ConfigurarPaginaLista()
122:         LOCAL loc_oPagina
123:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
124: 
125:         *----------------------------------------------------------------------
126:         *-- Container cabecalho (novo padrao arquitetura - topo escuro)
127:         *----------------------------------------------------------------------
128:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
129:         WITH loc_oPagina.cnt_4c_Cabecalho
130:             .Top         = 29
131:             .Left        = 0
132:             .Width       = 1003
133:             .Height      = 80
134:             .BackStyle   = 1
135:             .BackColor   = RGB(53, 53, 53)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
142:             .Caption   = "Cadastro de Produtos"
143:             .Top       = 20
144:             .Left      = 20
145:             .Width     = 400
146:             .Height    = 30
147:             .FontName  = "Tahoma"
148:             .FontSize  = 14
149:             .FontBold  = .T.
150:             .BackStyle = 0
151:             .ForeColor = RGB(255, 255, 255)
152:             .Visible   = .T.
153:         ENDWITH
154: 
155:         *----------------------------------------------------------------------
156:         *-- Container botoes CRUD (Grupo_op: Left=542, Top=-1 -> 28)
157:         *----------------------------------------------------------------------
158:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
159:         WITH loc_oPagina.cnt_4c_Botoes
160:             .Top         = 28
161:             .Left        = 542
162:             .Width       = 390
163:             .Height      = 85
164:             .BackStyle = 1
165:             .BackColor = RGB(53, 53, 53)
166:             .BorderWidth = 0
167:             .Visible     = .T.
168:         ENDWITH
169: 
170:         *-- Botao Incluir (Inserir: Left=5)
171:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
172:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
173:             .Caption         = "Incluir"
174:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:             .PicturePosition = 13
176:             .Width           = 75
177:             .Height          = 75
178:             .Left            = 5
179:             .Top             = 5
180:             .FontName        = "Tahoma"
181:             .FontSize        = 8
182:             .Themes          = .F.
183:             .SpecialEffect   = 0
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .Visible         = .T.
187:         ENDWITH
188:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:         *-- Botao Visualizar (Consultar: Left=80)
191:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Width           = 75
197:             .Height          = 75
198:             .Left            = 80
199:             .Top             = 5
200:             .FontName        = "Tahoma"
201:             .FontSize        = 8
202:             .Themes          = .F.
203:             .SpecialEffect   = 0
204:             .BackColor       = RGB(255, 255, 255)
205:             .ForeColor       = RGB(90, 90, 90)
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
209: 
210:         *-- Botao Alterar (Left=155)
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
213:             .Caption         = "Alterar"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:             .PicturePosition = 13
216:             .Width           = 75
217:             .Height          = 75
218:             .Left            = 155
219:             .Top             = 5
220:             .FontName        = "Tahoma"
221:             .FontSize        = 8
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .BackColor       = RGB(255, 255, 255)
225:             .ForeColor       = RGB(90, 90, 90)
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
229: 
230:         *-- Botao Excluir (Left=230)
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Width           = 75
237:             .Height          = 75
238:             .Left            = 230
239:             .Top             = 5
240:             .FontName        = "Tahoma"
241:             .FontSize        = 8
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
249: 
250:         *-- Botao Buscar (Procurar: Left=305)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
253:             .Caption         = "Buscar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
255:             .PicturePosition = 13
256:             .Width           = 75
257:             .Height          = 75
258:             .Left            = 305
259:             .Top             = 5
260:             .FontName        = "Tahoma"
261:             .FontSize        = 8
262:             .Themes          = .F.
263:             .SpecialEffect   = 0
264:             .BackColor       = RGB(255, 255, 255)
265:             .ForeColor       = RGB(90, 90, 90)
266:             .Visible         = .T.
267:         ENDWITH
268:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
269: 
270:         *----------------------------------------------------------------------
271:         *-- Container saida (Grupo_Saida: Left=917, Top=-1 -> 28)
272:         *----------------------------------------------------------------------
273:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
274:         WITH loc_oPagina.cnt_4c_Saida
275:             .Top         = 28
276:             .Left        = 917
277:             .Width       = 90
278:             .Height      = 85
279:             .BackStyle = 1
280:             .BackColor = RGB(53, 53, 53)
281:             .BorderWidth = 0
282:             .Visible     = .T.
283:         ENDWITH
284: 
285:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
287:             .Caption         = "Encerrar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
289:             .PicturePosition = 13
290:             .Width           = 75
291:             .Height          = 75
292:             .Left            = 5
293:             .Top             = 5
294:             .FontName        = "Tahoma"
295:             .FontSize        = 8
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .Visible         = .T.
301:         ENDWITH
302:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
303: 
304:         *----------------------------------------------------------------------
305:         *-- Container filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
306:         *-- Conteudo: lblGrupo, getCgru, getDgru, lblData1, getDtIni, lblData2, getDtFim, optFilSituas
307:         *----------------------------------------------------------------------
308:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
309:         WITH loc_oPagina.cnt_4c_Filtros
310:             .Top         = 111
311:             .Left        = 0
312:             .Width       = 383
313:             .Height      = 87
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318: 
319:         *-- Label "Grupo de Produto :" (lblGrupo: Top=18, Left=21, W=94)
320:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
321:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
322:             .Caption   = "Grupo de Produto :"
323:             .Top       = 18
324:             .Left      = 21
325:             .Width     = 94
326:             .Height    = 15
327:             .FontName  = "Tahoma"
328:             .FontSize  = 8
329:             .BackStyle = 0
330:             .Visible   = .T.
331:         ENDWITH
332: 
333:         *-- Codigo grupo (getCgru: Top=14, Left=116, W=31, H=23) + F4 abre lookup
334:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Cgru", "TextBox")
335:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru
336:             .Value    = ""
337:             .Top      = 14
338:             .Left     = 116
339:             .Width    = 31
340:             .Height   = 23
341:             .FontName = "Tahoma"
342:             .FontSize = 8
343:             .Themes   = .F.
344:             .Visible  = .T.
345:         ENDWITH
346:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru, "KeyPress", THIS, "FiltroGrupoKeyPress")
347: 
348:         *-- Descricao grupo (getDgru: Top=14, Left=149, W=148, H=23 - somente leitura)
349:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Dgru", "TextBox")
350:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru
351:             .Value     = ""
352:             .Top       = 14
353:             .Left      = 149
354:             .Width     = 148
355:             .Height    = 23
356:             .FontName  = "Tahoma"
357:             .FontSize  = 8
358:             .ReadOnly  = .T.
359:             .Themes    = .F.
360:             .BackColor = RGB(240, 240, 240)
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         *-- Label "Ult. Alteracao :" (lblData1: Top=43, Left=28, W=87)
365:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
366:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
367:             .Caption   = CHR(218) + "lt. Altera" + CHR(231) + CHR(227) + "o :"
368:             .Top       = 43
369:             .Left      = 28
370:             .Width     = 87
371:             .Height    = 15
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .BackStyle = 0
375:             .Visible   = .T.
376:         ENDWITH
377: 
378:         *-- Data inicial (getDtIni: Top=39, Left=116, W=80, H=23)
379:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_DtIni", "TextBox")
380:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_DtIni
381:             .Value    = {^1900-01-01}
382:             .Format   = "D"
383:             .Top      = 39
384:             .Left     = 116
385:             .Width    = 80
386:             .Height   = 23

*-- Linhas 419 a 535:
419:             .Visible  = .T.
420:         ENDWITH
421: 
422:         *-- OptionGroup situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
423:         *-- Value=1 Todos, 2 Ativos (Situas=1), 3 Inativos (Situas=2)
424:         loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_Situa", "OptionGroup")
425:         WITH loc_oPagina.cnt_4c_Filtros.obj_4c_Situa
426:             .ButtonCount = 3
427:             .BorderStyle = 0
428:             .Value       = 1
429:             .Top         = 19
430:             .Left        = 303
431:             .Width       = 78
432:             .Height      = 46
433:             .AutoSize    = .F.
434: 
435:             WITH .Buttons(1)
436:                 .Caption   = "Todos"
437:                 .Left      = 2
438:                 .Top       = 2
439:                 .Width     = 74
440:                 .Height    = 14
441:                 .Themes    = .F.
442:                 .Visible   = .T.
443:             ENDWITH
444: 
445:             WITH .Buttons(2)
446:                 .Caption   = "Ativos"
447:                 .Left      = 2
448:                 .Top       = 17
449:                 .Width     = 74
450:                 .Height    = 14
451:                 .FontName  = "Tahoma"
452:                 .FontSize  = 8
453:                 .Themes    = .F.
454:                 .Visible   = .T.
455:             ENDWITH
456: 
457:             WITH .Buttons(3)
458:                 .Caption   = "Inativos"
459:                 .Left      = 2
460:                 .Top       = 32
461:                 .Width     = 74
462:                 .Height    = 14
463:                 .FontName  = "Tahoma"
464:                 .FontSize  = 8
465:                 .Themes    = .F.
466:                 .Visible   = .T.
467:             ENDWITH
468:         ENDWITH
469:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_Situa, "InteractiveChange", THIS, "FiltroSituaChange")
470: 
471:         *----------------------------------------------------------------------
472:         *-- Grid lista principal (Grade: Top=173+29=202, Left=38, W=922, H=409)
473:         *-- 7 colunas: cpros, dpros, cgrus, subgru, reffs, usuario, inativo(chk)
474:         *-- Conteudo detalhado (colunas, ControlSource): FASE 4
475:         *----------------------------------------------------------------------
476:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
477:         WITH loc_oPagina.grd_4c_Lista
478:             .Top             = 202
479:             .Left            = 38
480:             .Width           = 922
481:             .Height          = 409
482:             .FontName        = "Tahoma"
483:             .FontSize        = 8
484:             .GridLines       = 1
485:             .GridLineColor   = RGB(200, 200, 200)
486:             .HeaderHeight    = 23
487:             .RowHeight       = 20
488:             .DeleteMark      = .F.
489:             .RecordMark      = .F.
490:             .Themes          = .F.
491:             .ReadOnly        = .T.
492:             .ColumnCount     = 0
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdListaDblClick")
496: 
497:         *-- Criar cursor placeholder ANTES do RecordSource (evita auto-bind errado)
498:         *-- Campos: cpros, dpros, cgrus, sgrus, reffs, colecoes, ImpEtiqs(L), Situas(N)
499:         IF USED("cursor_4c_Lista")
500:             USE IN cursor_4c_Lista
501:         ENDIF
502:         SET NULL ON
503:         CREATE CURSOR cursor_4c_Lista ;
504:             (cpros C(25), dpros C(80), cgrus C(5), sgrus C(5), ;
505:              reffs C(25), colecoes C(20), ImpEtiqs L, Situas N(1,0))
506:         SET NULL OFF
507: 
508:         *-- RecordSource + ColumnCount OBRIGATORIAMENTE FORA do WITH (regra VFP9)
509:         LOCAL loc_oGrid
510:         loc_oGrid = loc_oPagina.grd_4c_Lista
511:         loc_oGrid.RecordSource = "cursor_4c_Lista"
512:         loc_oGrid.ColumnCount  = 7
513: 
514:         *-- Re-definir ControlSource de TODAS as colunas apos RecordSource (GRID-AUTOBIND)
515:         *-- VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior
516:         loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.cpros"
517:         loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.dpros"
518:         loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.cgrus"
519:         loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.sgrus"
520:         loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.reffs"
521:         loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.colecoes"
522:         *-- Column7 (CheckBox): ControlSource definido apos AddObject/CurrentControl abaixo
523: 
524:         *-- Coluna 1: Produto (CPros) - 100px
525:         WITH loc_oGrid.Column1
526:             .ControlSource   = "cursor_4c_Lista.cpros"
527:             .Width           = 100
528:             .ReadOnly        = .T.
529:             .Header1.Caption = "Produto"
530:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
531:         ENDWITH
532: 
533:         *-- Coluna 2: Descricao (DPros) - 305px
534:         WITH loc_oGrid.Column2
535:             .ControlSource   = "cursor_4c_Lista.dpros"

*-- Linhas 605 a 666:
605:             .Visible   = .T.
606:         ENDWITH
607: 
608:         THIS.TornarControlesVisiveis(loc_oPagina)
609:     ENDPROC
610: 
611:     *--------------------------------------------------------------------------
612:     * ConfigurarPaginaDados - Page2: OptionGroup-nav + pgf_4c_DadosInternos (7pp)
613:     *                         + Salvar/Cancelar
614:     * Compensacao +29 aplicada: Top legado -> Top migrado
615:     * Optiongroup1: Top=5+29=34 | Grupo_Salva: Top=5+29=34, Left=842
616:     * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, PageCount=7
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarPaginaDados()
619:         LOCAL loc_oPagina
620:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
621: 
622:         *----------------------------------------------------------------------
623:         *-- OptionGroup de navegacao entre sub-paginas
624:         *-- Optiongroup1: Left=5, Top=5+29=34, Width=535, Height=85, ButtonCount=7
625:         *----------------------------------------------------------------------
626:         loc_oPagina.AddObject("obj_4c_NavegacaoDados", "OptionGroup")
627:         WITH loc_oPagina.obj_4c_NavegacaoDados
628:             .ButtonCount   = 7
629:             .AutoSize      = .T.
630:             .BorderStyle   = 0
631:             .Value         = 1
632:             .Top           = 34
633:             .Left          = 5
634:             .Width         = 535
635:             .Height        = 85
636: 
637:             *-- Option 1: Principal (optDados)
638:             WITH .Buttons(1)
639:                 .Caption       = "\<Principal"
640:                 .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
641:                 .Height        = 75
642:                 .Width         = 75
643:                 .Left          = 5
644:                 .Top           = 5
645:                 .Style         = 1
646:                 .SpecialEffect = 0
647:                 .FontBold      = .T.
648:                 .FontItalic    = .T.
649:                 .ForeColor     = RGB(90, 90, 90)
650:                 .BackColor     = RGB(255, 255, 255)
651:                 .Themes        = .F.
652:                 .Visible       = .T.
653:             ENDWITH
654: 
655:             *-- Option 2: Componente (optComposicao) -> pgComposicao (PageOrder=2)
656:             WITH .Buttons(2)
657:                 .Caption       = "Componen\<te"
658:                 .Picture       = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
659:                 .Height        = 75
660:                 .Width         = 75
661:                 .Left          = 80
662:                 .Top           = 5
663:                 .Style         = 1
664:                 .SpecialEffect = 0
665:                 .FontBold      = .T.
666:                 .FontItalic    = .T.

*-- Linhas 772 a 870:
772:                 .Visible       = .T.
773:             ENDWITH
774:         ENDWITH
775:         BINDEVENT(loc_oPagina.obj_4c_NavegacaoDados, "InteractiveChange", THIS, "NavegacaoDadosChange")
776: 
777:         *----------------------------------------------------------------------
778:         *-- Container botoes Salvar/Cancelar
779:         *-- Grupo_Salva: Left=842, Top=5+29=34, Width=165, Height=85
780:         *----------------------------------------------------------------------
781:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
782:         WITH loc_oPagina.cnt_4c_Salva
783:             .Top         = 34
784:             .Left        = 842
785:             .Width       = 165
786:             .Height      = 85
787:             .BackStyle   = 0
788:             .BorderWidth = 0
789:             .Visible     = .T.
790:         ENDWITH
791: 
792:         *-- Botao Confirmar/Salvar (Salva: Left=5)
793:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
794:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
795:             .Caption         = "Confirmar"
796:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
797:             .PicturePosition = 13
798:             .Width           = 75
799:             .Height          = 75
800:             .Left            = 5
801:             .Top             = 5
802:             .FontName        = "Tahoma"
803:             .FontSize        = 8
804:             .Themes          = .F.
805:             .SpecialEffect   = 0
806:             .BackColor       = RGB(255, 255, 255)
807:             .ForeColor       = RGB(90, 90, 90)
808:             .Visible         = .T.
809:         ENDWITH
810:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
811: 
812:         *-- Botao Cancelar (Left=80)
813:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
814:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
815:             .Caption         = "Cancelar"
816:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
817:             .PicturePosition = 13
818:             .Width           = 75
819:             .Height          = 75
820:             .Left            = 80
821:             .Top             = 5
822:             .FontName        = "Tahoma"
823:             .FontSize        = 8
824:             .Themes          = .F.
825:             .SpecialEffect   = 0
826:             .BackColor       = RGB(255, 255, 255)
827:             .ForeColor       = RGB(90, 90, 90)
828:             .Visible         = .T.
829:         ENDWITH
830:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
831: 
832:         *----------------------------------------------------------------------
833:         *-- PageFrame interno com 7 sub-paginas (pgframeDados migrado)
834:         *-- Top=-54+29=-25, Left=-1, Width=1003, Height=656, PageCount=7
835:         *-- Tabs posicionados acima da area visivel; nav via obj_4c_NavegacaoDados
836:         *----------------------------------------------------------------------
837:         loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
838:         WITH loc_oPagina.pgf_4c_DadosInternos
839:             .Top        = -25
840:             .Left       = -1
841:             .Width      = 1003
842:             .Height     = 656
843:             .PageCount  = 7
844:             .Tabs       = .T.
845:             .Visible    = .T.
846: 
847:             *-- Page1: Dados Principais (pgDados - PageOrder=1)
848:             .Page1.Caption   = "Dados Principais"
849:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
850:             .Page1.BackColor = RGB(255, 255, 255)
851:             .Page1.FontBold  = .T.
852:             .Page1.ForeColor = RGB(36, 84, 155)
853: 
854:             *-- Page2: Custos - nome pgComposicao no legado (PageOrder=2)
855:             .Page2.Caption   = "Custos"
856:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
857:             .Page2.BackColor = RGB(255, 255, 255)
858:             .Page2.FontBold  = .T.
859:             .Page2.FontName  = "Verdana"
860:             .Page2.FontSize  = 8
861:             .Page2.ForeColor = RGB(36, 84, 155)
862: 
863:             *-- Page3: Dados Fiscais (pgDadosFiscais - PageOrder=3)
864:             .Page3.Caption   = "Dados Fiscais"
865:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
866:             .Page3.BackColor = RGB(255, 255, 255)
867:             .Page3.FontBold  = .T.
868:             .Page3.FontName  = "Verdana"
869:             .Page3.FontSize  = 8
870:             .Page3.ForeColor = RGB(36, 84, 155)

*-- Linhas 905 a 1008:
905: 
906:         THIS.ConfigurarPgDados1()
907:         THIS.ConfigurarPgDados1b()
908:         THIS.TornarControlesVisiveis(loc_oPagina)
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * ConfigurarPgDados1 - Page1 dos Dados Internos (pgDados) - Parte 1/2
913:     * Campos: identificacao, grupos, fornecedor, codigos, status, EAN, Cor, Tam
914:     * Top values: FROM layout.json AS-IS (sem compensacao - pageframe interno)
915:     *--------------------------------------------------------------------------
916:     PROTECTED PROCEDURE ConfigurarPgDados1()
917:         LOCAL loc_oPg1
918:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
919: 
920:         *----------------------------------------------------------------------
921:         *-- ROW 1 (Top=130): Produto + Descricao + Status + DtSituas
922:         *----------------------------------------------------------------------
923:         *-- Label "Produto:" (top=134, left=58, w=53)
924:         loc_oPg1.AddObject("lbl_4c_LblProduto", "Label")
925:         WITH loc_oPg1.lbl_4c_LblProduto
926:             .Caption   = "Produto :"
927:             .Top       = 134
928:             .Left      = 58
929:             .Width     = 53
930:             .Height    = 15
931:             .FontName  = "Tahoma"
932:             .FontSize  = 8
933:             .BackStyle = 0
934:             .Visible   = .T.
935:         ENDWITH
936: 
937:         *-- getCpro -> txt_4c_Cpro (top=130, left=113, w=108, h=23)
938:         loc_oPg1.AddObject("txt_4c_Cpro", "TextBox")
939:         WITH loc_oPg1.txt_4c_Cpro
940:             .Value    = ""
941:             .Top      = 130
942:             .Left     = 113
943:             .Width    = 108
944:             .Height   = 23
945:             .FontName = "Tahoma"
946:             .FontSize = 8
947:             .Themes   = .F.
948:             .Visible  = .T.
949:         ENDWITH
950:         BINDEVENT(loc_oPg1.txt_4c_Cpro, "KeyPress", THIS, "DadosCproKeyPress")
951: 
952:         *-- getDpro -> txt_4c_Dpro (top=130, left=222, w=290, h=23)
953:         loc_oPg1.AddObject("txt_4c_Dpro", "TextBox")
954:         WITH loc_oPg1.txt_4c_Dpro
955:             .Value    = ""
956:             .Top      = 130
957:             .Left     = 222
958:             .Width    = 290
959:             .Height   = 23
960:             .FontName = "Tahoma"
961:             .FontSize = 8
962:             .Themes   = .F.
963:             .Visible  = .T.
964:         ENDWITH
965: 
966:         *-- opc_situacao -> obj_4c_OpcSituacao (top=130, left=735, w=142, h=25)
967:         *-- Situas: 1=Ativo, 2=Inativo
968:         loc_oPg1.AddObject("obj_4c_OpcSituacao", "OptionGroup")
969:         WITH loc_oPg1.obj_4c_OpcSituacao
970:             .ButtonCount = 2
971:             .BorderStyle = 0
972:             .Value       = 1
973:             .Top         = 130
974:             .Left        = 735
975:             .Width       = 142
976:             .Height      = 25
977:             WITH .Buttons(1)
978:                 .Caption  = "Ativo"
979:                 .Left     = 2
980:                 .Top      = 4
981:                 .Width    = 55
982:                 .Height   = 14
983:                 .Themes   = .F.
984:                 .Visible  = .T.
985:             ENDWITH
986:             WITH .Buttons(2)
987:                 .Caption  = "Inativo"
988:                 .Left     = 60
989:                 .Top      = 4
990:                 .Width    = 75
991:                 .Height   = 14
992:                 .FontName = "Tahoma"
993:                 .FontSize = 8
994:                 .Themes   = .F.
995:                 .Visible  = .T.
996:             ENDWITH
997:         ENDWITH
998: 
999:         *-- getDtSituas -> txt_4c_DtSituas (top=132, left=878, w=80, h=21) - data do status
1000:         loc_oPg1.AddObject("txt_4c_DtSituas", "TextBox")
1001:         WITH loc_oPg1.txt_4c_DtSituas
1002:             .Value     = {^2000-01-01}
1003:             .Format    = "D"
1004:             .Top       = 132
1005:             .Left      = 878
1006:             .Width     = 80
1007:             .Height    = 21
1008:             .FontName  = "Tahoma"

*-- Linhas 1071 a 1114:
1071:             .Themes   = .F.
1072:             .Visible  = .T.
1073:         ENDWITH
1074:         BINDEVENT(loc_oPg1.txt_4c_CProEq, "KeyPress", THIS, "DadosCProEqKeyPress")
1075: 
1076:         *-- Label "Barra:" (top=157, left=590, w=35)
1077:         loc_oPg1.AddObject("lbl_4c_LblCbar", "Label")
1078:         WITH loc_oPg1.lbl_4c_LblCbar
1079:             .Caption   = "Barra :"
1080:             .Top       = 157
1081:             .Left      = 590
1082:             .Width     = 35
1083:             .Height    = 15
1084:             .FontName  = "Tahoma"
1085:             .FontSize  = 8
1086:             .BackStyle = 0
1087:             .Visible   = .T.
1088:         ENDWITH
1089: 
1090:         *-- getCbar -> txt_4c_Cbar (top=155, left=626, w=108, h=21) - numeric
1091:         loc_oPg1.AddObject("txt_4c_Cbar", "TextBox")
1092:         WITH loc_oPg1.txt_4c_Cbar
1093:             .Value    = 0
1094:             .Top      = 155
1095:             .Left     = 626
1096:             .Width    = 108
1097:             .Height   = 21
1098:             .FontName = "Tahoma"
1099:             .FontSize = 8
1100:             .Themes   = .F.
1101:             .Visible  = .T.
1102:         ENDWITH
1103: 
1104:         *-- Label "Lote M" + CHR(237) + "nimo:" (top=157, left=812, w=65)
1105:         loc_oPg1.AddObject("lbl_4c_LblLtMins", "Label")
1106:         WITH loc_oPg1.lbl_4c_LblLtMins
1107:             .Caption   = "Lote M" + CHR(237) + "nimo :"
1108:             .Top       = 157
1109:             .Left      = 812
1110:             .Width     = 65
1111:             .Height    = 15
1112:             .FontName  = "Tahoma"
1113:             .FontSize  = 8
1114:             .BackStyle = 0

*-- Linhas 1159 a 1202:
1159:             .Themes   = .F.
1160:             .Visible  = .T.
1161:         ENDWITH
1162:         BINDEVENT(loc_oPg1.txt_4c_Cgru, "KeyPress", THIS, "DadosCgruKeyPress")
1163: 
1164:         *-- getDgru -> txt_4c_Dgru (top=178, left=145, w=171, h=23) - somente leitura
1165:         loc_oPg1.AddObject("txt_4c_Dgru", "TextBox")
1166:         WITH loc_oPg1.txt_4c_Dgru
1167:             .Value     = ""
1168:             .Top       = 178
1169:             .Left      = 145
1170:             .Width     = 171
1171:             .Height    = 23
1172:             .FontName  = "Tahoma"
1173:             .FontSize  = 8
1174:             .ReadOnly  = .T.
1175:             .BackColor = RGB(240, 240, 240)
1176:             .Themes    = .F.
1177:             .Visible   = .T.
1178:         ENDWITH
1179: 
1180:         *-- getMerc -> txt_4c_Merc (top=178, left=318, w=31, h=23) - no label in layout
1181:         loc_oPg1.AddObject("txt_4c_Merc", "TextBox")
1182:         WITH loc_oPg1.txt_4c_Merc
1183:             .Value    = ""
1184:             .Top      = 178
1185:             .Left     = 318
1186:             .Width    = 31
1187:             .Height   = 23
1188:             .FontName = "Tahoma"
1189:             .FontSize = 8
1190:             .Themes   = .F.
1191:             .Visible  = .T.
1192:         ENDWITH
1193: 
1194:         *-- Label "Identificador:" (top=182, left=408, w=70)
1195:         loc_oPg1.AddObject("lbl_4c_LblIdeCPros", "Label")
1196:         WITH loc_oPg1.lbl_4c_LblIdeCPros
1197:             .Caption   = "Identificador :"
1198:             .Top       = 182
1199:             .Left      = 408
1200:             .Width     = 70
1201:             .Height    = 15
1202:             .FontName  = "Tahoma"

*-- Linhas 1263 a 1306:
1263: 
1264:         *-- Fwoption1 -> obj_4c_ProdWeb (top=172, left=879, w=117, h=42, 4 botoes)
1265:         *-- Varias field mapeado: 0=Nenhum, 1=Sim, 2=Nao, 3=Destaque
1266:         loc_oPg1.AddObject("obj_4c_ProdWeb", "OptionGroup")
1267:         WITH loc_oPg1.obj_4c_ProdWeb
1268:             .ButtonCount = 4
1269:             .BorderStyle = 0
1270:             .Value       = 1
1271:             .Top         = 172
1272:             .Left        = 879
1273:             .Width       = 117
1274:             .Height      = 42
1275:             WITH .Buttons(1)
1276:                 .Caption  = "Nenhum"
1277:                 .Left     = 2
1278:                 .Top      = 2
1279:                 .Width    = 55
1280:                 .Height   = 14
1281:                 .Themes   = .F.
1282:                 .Visible  = .T.
1283:             ENDWITH
1284:             WITH .Buttons(2)
1285:                 .Caption  = "Sim"
1286:                 .Left     = 60
1287:                 .Top      = 2
1288:                 .Width    = 55
1289:                 .Height   = 14
1290:                 .FontName = "Tahoma"
1291:                 .FontSize = 8
1292:                 .Themes   = .F.
1293:                 .Visible  = .T.
1294:             ENDWITH
1295:             WITH .Buttons(3)
1296:                 .Caption  = "N" + CHR(227) + "o"
1297:                 .Left     = 2
1298:                 .Top      = 18
1299:                 .Width    = 55
1300:                 .Height   = 14
1301:                 .FontName = "Tahoma"
1302:                 .FontSize = 8
1303:                 .Themes   = .F.
1304:                 .Visible  = .T.
1305:             ENDWITH
1306:             WITH .Buttons(4)

*-- Linhas 1380 a 1423:
1380: 
1381:         *-- Fwoption2 -> obj_4c_Variacao (top=203, left=874, w=107, h=22, 2 botoes)
1382:         *-- 0=Nenhum / 1=Cor-Tam (mapeado em Varias de SigCdPro)
1383:         loc_oPg1.AddObject("obj_4c_Variacao", "OptionGroup")
1384:         WITH loc_oPg1.obj_4c_Variacao
1385:             .ButtonCount = 2
1386:             .BorderStyle = 0
1387:             .Value       = 1
1388:             .Top         = 203
1389:             .Left        = 874
1390:             .Width       = 107
1391:             .Height      = 22
1392:             WITH .Buttons(1)
1393:                 .Caption  = "Nenhum"
1394:                 .Left     = 2
1395:                 .Top      = 4
1396:                 .Width    = 50
1397:                 .Height   = 14
1398:                 .Themes   = .F.
1399:                 .Visible  = .T.
1400:             ENDWITH
1401:             WITH .Buttons(2)
1402:                 .Caption  = "Cor-Tam"
1403:                 .Left     = 55
1404:                 .Top      = 4
1405:                 .Width    = 50
1406:                 .Height   = 14
1407:                 .FontName = "Tahoma"
1408:                 .FontSize = 8
1409:                 .Themes   = .F.
1410:                 .Visible  = .T.
1411:             ENDWITH
1412:         ENDWITH
1413: 
1414:         *----------------------------------------------------------------------
1415:         *-- ROW 5 (Top=226): Linha + QtPed + Garantia + ChkGarVit
1416:         *----------------------------------------------------------------------
1417:         *-- Label "Linha:" (top=230, left=77, w=34)
1418:         loc_oPg1.AddObject("lbl_4c_LblLin", "Label")
1419:         WITH loc_oPg1.lbl_4c_LblLin
1420:             .Caption   = "Linha :"
1421:             .Top       = 230
1422:             .Left      = 77
1423:             .Width     = 34

*-- Linhas 1441 a 1484:
1441:             .Themes   = .F.
1442:             .Visible  = .T.
1443:         ENDWITH
1444:         BINDEVENT(loc_oPg1.txt_4c_Lin, "KeyPress", THIS, "DadosLinKeyPress")
1445: 
1446:         *-- GetDLin -> txt_4c_DLin (top=226, left=194, w=318, h=23) - somente leitura
1447:         loc_oPg1.AddObject("txt_4c_DLin", "TextBox")
1448:         WITH loc_oPg1.txt_4c_DLin
1449:             .Value     = ""
1450:             .Top       = 226
1451:             .Left      = 194
1452:             .Width     = 318
1453:             .Height    = 23
1454:             .FontName  = "Tahoma"
1455:             .FontSize  = 8
1456:             .ReadOnly  = .T.
1457:             .BackColor = RGB(240, 240, 240)
1458:             .Themes    = .F.
1459:             .Visible   = .T.
1460:         ENDWITH
1461: 
1462:         *-- Label "Garantia:" (top=228, left=827, w=50)
1463:         loc_oPg1.AddObject("lbl_4c_LblDiasGar", "Label")
1464:         WITH loc_oPg1.lbl_4c_LblDiasGar
1465:             .Caption   = "Garantia :"
1466:             .Top       = 228
1467:             .Left      = 827
1468:             .Width     = 50
1469:             .Height    = 15
1470:             .FontName  = "Tahoma"
1471:             .FontSize  = 8
1472:             .BackStyle = 0
1473:             .Visible   = .T.
1474:         ENDWITH
1475: 
1476:         *-- getDiasGar -> txt_4c_DiasGar (top=224, left=880, w=34, h=21)
1477:         loc_oPg1.AddObject("txt_4c_DiasGar", "TextBox")
1478:         WITH loc_oPg1.txt_4c_DiasGar
1479:             .Value    = 0
1480:             .Top      = 224
1481:             .Left     = 880
1482:             .Width    = 34
1483:             .Height   = 21
1484:             .FontName = "Tahoma"

*-- Linhas 1547 a 1590:
1547:             .Themes   = .F.
1548:             .Visible  = .T.
1549:         ENDWITH
1550:         BINDEVENT(loc_oPg1.txt_4c_Col, "KeyPress", THIS, "DadosColKeyPress")
1551: 
1552:         *-- GetDCol -> txt_4c_DCol (top=250, left=194, w=318, h=23) - somente leitura
1553:         loc_oPg1.AddObject("txt_4c_DCol", "TextBox")
1554:         WITH loc_oPg1.txt_4c_DCol
1555:             .Value     = ""
1556:             .Top       = 250
1557:             .Left      = 194
1558:             .Width     = 318
1559:             .Height    = 23
1560:             .FontName  = "Tahoma"
1561:             .FontSize  = 8
1562:             .ReadOnly  = .T.
1563:             .BackColor = RGB(240, 240, 240)
1564:             .Themes    = .F.
1565:             .Visible   = .T.
1566:         ENDWITH
1567: 
1568:         *-- Label "Obs. Componente:" (top=247, left=529, w=96)
1569:         loc_oPg1.AddObject("lbl_4c_LblObsComp", "Label")
1570:         WITH loc_oPg1.lbl_4c_LblObsComp
1571:             .Caption   = "Obs. Componente :"
1572:             .Top       = 247
1573:             .Left      = 529
1574:             .Width     = 96
1575:             .Height    = 15
1576:             .FontName  = "Tahoma"
1577:             .FontSize  = 8
1578:             .BackStyle = 0
1579:             .Visible   = .T.
1580:         ENDWITH
1581: 
1582:         *-- GetObs3 -> txt_4c_Obs3 (top=243, left=626, w=80, h=21) -> obsetqs
1583:         loc_oPg1.AddObject("txt_4c_Obs3", "TextBox")
1584:         WITH loc_oPg1.txt_4c_Obs3
1585:             .Value    = ""
1586:             .Top      = 243
1587:             .Left     = 626
1588:             .Width    = 80
1589:             .Height   = 21
1590:             .FontName = "Tahoma"

*-- Linhas 1623 a 1666:
1623:             .Themes   = .F.
1624:             .Visible  = .T.
1625:         ENDWITH
1626:         BINDEVENT(loc_oPg1.txt_4c_Ifor, "KeyPress", THIS, "DadosIforKeyPress")
1627: 
1628:         *-- getDfor -> txt_4c_Dfor (top=274, left=194, w=318, h=23) - somente leitura
1629:         loc_oPg1.AddObject("txt_4c_Dfor", "TextBox")
1630:         WITH loc_oPg1.txt_4c_Dfor
1631:             .Value     = ""
1632:             .Top       = 274
1633:             .Left      = 194
1634:             .Width     = 318
1635:             .Height    = 23
1636:             .FontName  = "Tahoma"
1637:             .FontSize  = 8
1638:             .ReadOnly  = .T.
1639:             .BackColor = RGB(240, 240, 240)
1640:             .Themes    = .F.
1641:             .Visible   = .T.
1642:         ENDWITH
1643: 
1644:         *-- Label "Observacao:" (top=269, left=558, w=67)
1645:         loc_oPg1.AddObject("lbl_4c_LblObs1", "Label")
1646:         WITH loc_oPg1.lbl_4c_LblObs1
1647:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1648:             .Top       = 269
1649:             .Left      = 558
1650:             .Width     = 67
1651:             .Height    = 15
1652:             .FontName  = "Tahoma"
1653:             .FontSize  = 8
1654:             .BackStyle = 0
1655:             .Visible   = .T.
1656:         ENDWITH
1657: 
1658:         *-- getObs1 -> txt_4c_Obs1 (top=265, left=626, w=220, h=21) -> obspeds
1659:         loc_oPg1.AddObject("txt_4c_Obs1", "TextBox")
1660:         WITH loc_oPg1.txt_4c_Obs1
1661:             .Value    = ""
1662:             .Top      = 265
1663:             .Left     = 626
1664:             .Width    = 220
1665:             .Height   = 21
1666:             .FontName = "Tahoma"

*-- Linhas 1755 a 1931:
1755:             .Themes   = .F.
1756:             .Visible  = .T.
1757:         ENDWITH
1758:         BINDEVENT(loc_oPg1.txt_4c_Cor, "KeyPress", THIS, "DadosCorKeyPress")
1759: 
1760:         *-- Label "Tam:" (top=302, left=442)
1761:         loc_oPg1.AddObject("lbl_4c_LblTam", "Label")
1762:         WITH loc_oPg1.lbl_4c_LblTam
1763:             .Caption   = "Tam:"
1764:             .Top       = 302
1765:             .Left      = 442
1766:             .Width     = 30
1767:             .Height    = 15
1768:             .FontName  = "Tahoma"
1769:             .FontSize  = 8
1770:             .BackStyle = 0
1771:             .Visible   = .T.
1772:         ENDWITH
1773: 
1774:         *-- getTam -> txt_4c_Tam (top=298, left=474, w=38) -> codtams
1775:         loc_oPg1.AddObject("txt_4c_Tam", "TextBox")
1776:         WITH loc_oPg1.txt_4c_Tam
1777:             .Value    = ""
1778:             .Top      = 298
1779:             .Left     = 474
1780:             .Width    = 38
1781:             .Height   = 23
1782:             .FontName = "Tahoma"
1783:             .FontSize = 8
1784:             .Themes   = .F.
1785:             .Visible  = .T.
1786:         ENDWITH
1787:         BINDEVENT(loc_oPg1.txt_4c_Tam, "KeyPress", THIS, "DadosTamKeyPress")
1788: 
1789:         *----------------------------------------------------------------------
1790:         *-- ROW 9 (Top=322): Modelo (getCodFinP)
1791:         *----------------------------------------------------------------------
1792:         *-- Label "Modelo:" (top=326, left=7, w=104)
1793:         loc_oPg1.AddObject("lbl_4c_LblModelo", "Label")
1794:         WITH loc_oPg1.lbl_4c_LblModelo
1795:             .Caption   = "Modelo :"
1796:             .Top       = 326
1797:             .Left      = 7
1798:             .Width     = 104
1799:             .Height    = 15
1800:             .FontName  = "Tahoma"
1801:             .FontSize  = 8
1802:             .BackStyle = 0
1803:             .Visible   = .T.
1804:         ENDWITH
1805: 
1806:         *-- getCodFinP -> txt_4c_CodFinP (top=322, left=113, w=31, h=23)
1807:         loc_oPg1.AddObject("txt_4c_CodFinP", "TextBox")
1808:         WITH loc_oPg1.txt_4c_CodFinP
1809:             .Value    = ""
1810:             .Top      = 322
1811:             .Left     = 113
1812:             .Width    = 31
1813:             .Height   = 23
1814:             .FontName = "Tahoma"
1815:             .FontSize = 8
1816:             .Themes   = .F.
1817:             .Visible  = .T.
1818:         ENDWITH
1819:         BINDEVENT(loc_oPg1.txt_4c_CodFinP, "KeyPress", THIS, "DadosCodFinPKeyPress")
1820: 
1821:         *-- getDesFinP -> txt_4c_DesFinP (top=322, left=145, w=150, h=23) - somente leitura
1822:         loc_oPg1.AddObject("txt_4c_DesFinP", "TextBox")
1823:         WITH loc_oPg1.txt_4c_DesFinP
1824:             .Value     = ""
1825:             .Top       = 322
1826:             .Left      = 145
1827:             .Width     = 150
1828:             .Height    = 23
1829:             .FontName  = "Tahoma"
1830:             .FontSize  = 8
1831:             .ReadOnly  = .T.
1832:             .BackColor = RGB(240, 240, 240)
1833:             .Themes    = .F.
1834:             .Visible   = .T.
1835:         ENDWITH
1836: 
1837:         *----------------------------------------------------------------------
1838:         *-- ROW 10 (Top=346): Acabamento (get_codacb)
1839:         *----------------------------------------------------------------------
1840:         *-- Label "Acabamento:" (top=350, left=7, w=104)
1841:         loc_oPg1.AddObject("lbl_4c_LblAcabamento", "Label")
1842:         WITH loc_oPg1.lbl_4c_LblAcabamento
1843:             .Caption   = "Acabamento :"
1844:             .Top       = 350
1845:             .Left      = 7
1846:             .Width     = 104
1847:             .Height    = 15
1848:             .FontName  = "Tahoma"
1849:             .FontSize  = 8
1850:             .BackStyle = 0
1851:             .Visible   = .T.
1852:         ENDWITH
1853: 
1854:         *-- get_codacb -> txt_4c_Codacb (top=346, left=113, w=31, h=23) -> codacbs
1855:         loc_oPg1.AddObject("txt_4c_Codacb", "TextBox")
1856:         WITH loc_oPg1.txt_4c_Codacb
1857:             .Value    = ""
1858:             .Top      = 346
1859:             .Left     = 113
1860:             .Width    = 31
1861:             .Height   = 23
1862:             .FontName = "Tahoma"
1863:             .FontSize = 8
1864:             .Themes   = .F.
1865:             .Visible  = .T.
1866:         ENDWITH
1867:         BINDEVENT(loc_oPg1.txt_4c_Codacb, "KeyPress", THIS, "DadosCodacbKeyPress")
1868: 
1869:         *-- get_Dacb -> txt_4c_Dacb (top=346, left=145, w=150, h=23) - somente leitura
1870:         loc_oPg1.AddObject("txt_4c_Dacb", "TextBox")
1871:         WITH loc_oPg1.txt_4c_Dacb
1872:             .Value     = ""
1873:             .Top       = 346
1874:             .Left      = 145
1875:             .Width     = 150
1876:             .Height    = 23
1877:             .FontName  = "Tahoma"
1878:             .FontSize  = 8
1879:             .ReadOnly  = .T.
1880:             .BackColor = RGB(240, 240, 240)
1881:             .Themes    = .F.
1882:             .Visible   = .T.
1883:         ENDWITH
1884: 
1885:     ENDPROC
1886: 
1887:     *--------------------------------------------------------------------------
1888:     * ConfigurarPgDados1b - Page1 dos Dados Internos (pgDados) - Parte 2/2
1889:     * Campos: unidades, local, classe, precos, auditoria, dimensoes, checkboxes, memos
1890:     *--------------------------------------------------------------------------
1891:     PROTECTED PROCEDURE ConfigurarPgDados1b()
1892:         LOCAL loc_oPg1
1893:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
1894: 
1895:         *----------------------------------------------------------------------
1896:         *-- ROW 4 adicoes (Top=199-202): getConjunto + getQmin + CmdQtMin
1897:         *----------------------------------------------------------------------
1898:         *-- Label "Conjunto :" (top=206, left=408, w=53)
1899:         loc_oPg1.AddObject("lbl_4c_LblConjunto", "Label")
1900:         WITH loc_oPg1.lbl_4c_LblConjunto
1901:             .Caption   = "Conjunto :"
1902:             .Top       = 206
1903:             .Left      = 408
1904:             .Width     = 53
1905:             .Height    = 15
1906:             .FontName  = "Tahoma"
1907:             .FontSize  = 8
1908:             .BackStyle = 0
1909:             .Visible   = .T.
1910:         ENDWITH
1911: 
1912:         *-- getConjunto -> txt_4c_Conjunto (top=202, left=460, w=52, h=23)
1913:         loc_oPg1.AddObject("txt_4c_Conjunto", "TextBox")
1914:         WITH loc_oPg1.txt_4c_Conjunto
1915:             .Value    = ""
1916:             .Top      = 202
1917:             .Left     = 460
1918:             .Width    = 52
1919:             .Height   = 23
1920:             .FontName = "Tahoma"
1921:             .FontSize = 8
1922:             .Themes   = .F.
1923:             .Visible  = .T.
1924:         ENDWITH
1925: 
1926:         *-- Label "Qtde. Minima :" (top=203, left=553, w=72)
1927:         loc_oPg1.AddObject("lbl_4c_LblQmin", "Label")
1928:         WITH loc_oPg1.lbl_4c_LblQmin
1929:             .Caption   = "Qtde. M" + CHR(237) + "nima :"
1930:             .Top       = 203
1931:             .Left      = 553

*-- Linhas 1965 a 2008:
1965:             .SpecialEffect = 0
1966:             .Visible       = .T.
1967:         ENDWITH
1968:         BINDEVENT(loc_oPg1.cmd_4c_QtMin, "Click", THIS, "CmdQtMinClick")
1969: 
1970:         *----------------------------------------------------------------------
1971:         *-- ROW 5 adicoes (Top=221): getQtPed
1972:         *----------------------------------------------------------------------
1973:         *-- Label "Qtde. Pedido :" (top=225, left=553, w=72)
1974:         loc_oPg1.AddObject("lbl_4c_LblQtPed", "Label")
1975:         WITH loc_oPg1.lbl_4c_LblQtPed
1976:             .Caption   = "Qtde. Pedido :"
1977:             .Top       = 225
1978:             .Left      = 553
1979:             .Width     = 72
1980:             .Height    = 15
1981:             .FontName  = "Tahoma"
1982:             .FontSize  = 8
1983:             .BackStyle = 0
1984:             .Visible   = .T.
1985:         ENDWITH
1986: 
1987:         *-- getQtPed -> txt_4c_QtPed (top=221, left=626, w=80, h=21)
1988:         loc_oPg1.AddObject("txt_4c_QtPed", "TextBox")
1989:         WITH loc_oPg1.txt_4c_QtPed
1990:             .Value    = 0.000
1991:             .Top      = 221
1992:             .Left     = 626
1993:             .Width    = 80
1994:             .Height   = 21
1995:             .FontName = "Tahoma"
1996:             .FontSize = 8
1997:             .Themes   = .F.
1998:             .Visible  = .T.
1999:         ENDWITH
2000: 
2001:         *----------------------------------------------------------------------
2002:         *-- DIMENSOES FISICAS - lado direito (left=923, top=247-335)
2003:         *-- Campos: altura, largura, diametro, espessura, comprimento
2004:         *----------------------------------------------------------------------
2005:         *-- Label "Altura :" (top=474, left=749, w=38)
2006:         loc_oPg1.AddObject("lbl_4c_LblAltura", "Label")
2007:         WITH loc_oPg1.lbl_4c_LblAltura
2008:             .Caption   = "Altura :"

*-- Linhas 2449 a 2537:
2449:             .Themes   = .F.
2450:             .Visible  = .T.
2451:         ENDWITH
2452:         BINDEVENT(loc_oPg1.txt_4c_Class, "KeyPress", THIS, "DadosClassKeyPress")
2453: 
2454:         *-- Get_DClass -> txt_4c_DClass (top=370, left=145, w=150, h=23) - somente leitura
2455:         loc_oPg1.AddObject("txt_4c_DClass", "TextBox")
2456:         WITH loc_oPg1.txt_4c_DClass
2457:             .Value     = ""
2458:             .Top       = 370
2459:             .Left      = 145
2460:             .Width     = 150
2461:             .Height    = 23
2462:             .FontName  = "Tahoma"
2463:             .FontSize  = 8
2464:             .ReadOnly  = .T.
2465:             .BackColor = RGB(240, 240, 240)
2466:             .Themes    = .F.
2467:             .Visible   = .T.
2468:         ENDWITH
2469: 
2470:         *-- Label "Local :" (top=374, left=364, w=33)
2471:         loc_oPg1.AddObject("lbl_4c_LblLocal", "Label")
2472:         WITH loc_oPg1.lbl_4c_LblLocal
2473:             .Caption   = "Local :"
2474:             .Top       = 374
2475:             .Left      = 364
2476:             .Width     = 33
2477:             .Height    = 15
2478:             .FontName  = "Tahoma"
2479:             .FontSize  = 8
2480:             .BackStyle = 0
2481:             .Visible   = .T.
2482:         ENDWITH
2483: 
2484:         *-- Get_Local -> txt_4c_Local (top=370, left=401, w=111, h=23) -> SigPrLcl: codigos/descricaos
2485:         loc_oPg1.AddObject("txt_4c_Local", "TextBox")
2486:         WITH loc_oPg1.txt_4c_Local
2487:             .Value    = ""
2488:             .Top      = 370
2489:             .Left     = 401
2490:             .Width    = 111
2491:             .Height   = 23
2492:             .FontName = "Tahoma"
2493:             .FontSize = 8
2494:             .Themes   = .F.
2495:             .Visible  = .T.
2496:         ENDWITH
2497:         BINDEVENT(loc_oPg1.txt_4c_Local, "KeyPress", THIS, "DadosLocalKeyPress")
2498: 
2499:         *----------------------------------------------------------------------
2500:         *-- PRECOS E CUSTOS (Top=375-419) - direita
2501:         *-- Custo total (top=375): getCtotal + getMctotal
2502:         *-- Preco venda (top=397): getPvenda + getMpvenda
2503:         *-- Fator venda (top=419): getFvenda + getMfvenda
2504:         *----------------------------------------------------------------------
2505:         *-- Label "Valor de Custo :" (top=379, left=546, w=79)
2506:         loc_oPg1.AddObject("lbl_4c_LblCtotal", "Label")
2507:         WITH loc_oPg1.lbl_4c_LblCtotal
2508:             .Caption   = "Valor de Custo :"
2509:             .Top       = 379
2510:             .Left      = 546
2511:             .Width     = 79
2512:             .Height    = 15
2513:             .FontName  = "Tahoma"
2514:             .FontSize  = 8
2515:             .BackStyle = 0
2516:             .Visible   = .T.
2517:         ENDWITH
2518: 
2519:         *-- getCtotal -> txt_4c_Ctotal (top=375, left=626, w=127, h=21) - read-only
2520:         loc_oPg1.AddObject("txt_4c_Ctotal", "TextBox")
2521:         WITH loc_oPg1.txt_4c_Ctotal
2522:             .Value     = 0.00000
2523:             .Top       = 375
2524:             .Left      = 626
2525:             .Width     = 127
2526:             .Height    = 21
2527:             .FontName  = "Tahoma"
2528:             .FontSize  = 8
2529:             .ReadOnly  = .T.
2530:             .BackColor = RGB(240, 240, 240)
2531:             .Themes    = .F.
2532:             .Visible   = .T.
2533:         ENDWITH
2534: 
2535:         *-- getMctotal -> txt_4c_Mctotal (top=375, left=754, w=31, h=21) -> SigCdMoe: cmoes/dmoes
2536:         loc_oPg1.AddObject("txt_4c_Mctotal", "TextBox")
2537:         WITH loc_oPg1.txt_4c_Mctotal

*-- Linhas 2545 a 2751:
2545:             .Themes   = .F.
2546:             .Visible  = .T.
2547:         ENDWITH
2548:         BINDEVENT(loc_oPg1.txt_4c_Mctotal, "KeyPress", THIS, "DadosMctotalKeyPress")
2549: 
2550:         *-- Label "Valor de Venda :" (top=400, left=505, w=120)
2551:         loc_oPg1.AddObject("lbl_4c_LblPvenda", "Label")
2552:         WITH loc_oPg1.lbl_4c_LblPvenda
2553:             .Caption   = "Valor de Venda :"
2554:             .Top       = 400
2555:             .Left      = 505
2556:             .Width     = 120
2557:             .Height    = 15
2558:             .FontName  = "Tahoma"
2559:             .FontSize  = 8
2560:             .BackStyle = 0
2561:             .Visible   = .T.
2562:         ENDWITH
2563: 
2564:         *-- getPvenda -> txt_4c_Pvenda (top=397, left=626, w=127, h=21)
2565:         loc_oPg1.AddObject("txt_4c_Pvenda", "TextBox")
2566:         WITH loc_oPg1.txt_4c_Pvenda
2567:             .Value    = 0.00000
2568:             .Top      = 397
2569:             .Left     = 626
2570:             .Width    = 127
2571:             .Height   = 21
2572:             .FontName = "Tahoma"
2573:             .FontSize = 8
2574:             .Themes   = .F.
2575:             .Visible  = .T.
2576:         ENDWITH
2577: 
2578:         *-- getMpvenda -> txt_4c_Mpvenda (top=397, left=754, w=31, h=21) -> SigCdMoe
2579:         loc_oPg1.AddObject("txt_4c_Mpvenda", "TextBox")
2580:         WITH loc_oPg1.txt_4c_Mpvenda
2581:             .Value    = ""
2582:             .Top      = 397
2583:             .Left     = 754
2584:             .Width    = 31
2585:             .Height   = 21
2586:             .FontName = "Tahoma"
2587:             .FontSize = 8
2588:             .Themes   = .F.
2589:             .Visible  = .T.
2590:         ENDWITH
2591:         BINDEVENT(loc_oPg1.txt_4c_Mpvenda, "KeyPress", THIS, "DadosMpvendaKeyPress")
2592: 
2593:         *-- Label "Fator de Venda :" (top=422, left=539, w=86)
2594:         loc_oPg1.AddObject("lbl_4c_LblFvenda", "Label")
2595:         WITH loc_oPg1.lbl_4c_LblFvenda
2596:             .Caption   = "Fator  de Venda :"
2597:             .Top       = 422
2598:             .Left      = 539
2599:             .Width     = 86
2600:             .Height    = 15
2601:             .FontName  = "Tahoma"
2602:             .FontSize  = 8
2603:             .BackStyle = 0
2604:             .Visible   = .T.
2605:         ENDWITH
2606: 
2607:         *-- getFvenda -> txt_4c_Fvenda (top=419, left=626, w=127, h=21)
2608:         loc_oPg1.AddObject("txt_4c_Fvenda", "TextBox")
2609:         WITH loc_oPg1.txt_4c_Fvenda
2610:             .Value    = 1.000
2611:             .Top      = 419
2612:             .Left     = 626
2613:             .Width    = 127
2614:             .Height   = 21
2615:             .FontName = "Tahoma"
2616:             .FontSize = 8
2617:             .Themes   = .F.
2618:             .Visible  = .T.
2619:         ENDWITH
2620: 
2621:         *-- getMfvenda -> txt_4c_Mfvenda (top=419, left=754, w=31, h=21) -> SigCdMoe
2622:         loc_oPg1.AddObject("txt_4c_Mfvenda", "TextBox")
2623:         WITH loc_oPg1.txt_4c_Mfvenda
2624:             .Value    = ""
2625:             .Top      = 419
2626:             .Left     = 754
2627:             .Width    = 31
2628:             .Height   = 21
2629:             .FontName = "Tahoma"
2630:             .FontSize = 8
2631:             .Themes   = .F.
2632:             .Visible  = .T.
2633:         ENDWITH
2634:         BINDEVENT(loc_oPg1.txt_4c_Mfvenda, "KeyPress", THIS, "DadosMfvendaKeyPress")
2635: 
2636:         *----------------------------------------------------------------------
2637:         *-- ROW 12 - NEW (Top=394): Unidade (1) + Unidade (2)
2638:         *----------------------------------------------------------------------
2639:         *-- Label "Unidades (1) :" (top=398, left=41, w=70)
2640:         loc_oPg1.AddObject("lbl_4c_LblCuni", "Label")
2641:         WITH loc_oPg1.lbl_4c_LblCuni
2642:             .Caption   = "Unidades (1) :"
2643:             .Top       = 398
2644:             .Left      = 41
2645:             .Width     = 70
2646:             .Height    = 15
2647:             .FontName  = "Tahoma"
2648:             .FontSize  = 8
2649:             .BackStyle = 0
2650:             .Visible   = .T.
2651:         ENDWITH
2652: 
2653:         *-- Get_Cuni -> txt_4c_Cuni (top=394, left=113, w=31, h=23) -> SigCdUni: CUnis/DUnis
2654:         loc_oPg1.AddObject("txt_4c_Cuni", "TextBox")
2655:         WITH loc_oPg1.txt_4c_Cuni
2656:             .Value    = ""
2657:             .Top      = 394
2658:             .Left     = 113
2659:             .Width    = 31
2660:             .Height   = 23
2661:             .FontName = "Tahoma"
2662:             .FontSize = 8
2663:             .Themes   = .F.
2664:             .Visible  = .T.
2665:         ENDWITH
2666:         BINDEVENT(loc_oPg1.txt_4c_Cuni, "KeyPress", THIS, "DadosCuniKeyPress")
2667: 
2668:         *-- Get_Duni -> txt_4c_Duni (top=394, left=145, w=150, h=23) - somente leitura
2669:         loc_oPg1.AddObject("txt_4c_Duni", "TextBox")
2670:         WITH loc_oPg1.txt_4c_Duni
2671:             .Value     = ""
2672:             .Top       = 394
2673:             .Left      = 145
2674:             .Width     = 150
2675:             .Height    = 23
2676:             .FontName  = "Tahoma"
2677:             .FontSize  = 8
2678:             .ReadOnly  = .T.
2679:             .BackColor = RGB(240, 240, 240)
2680:             .Themes    = .F.
2681:             .Visible   = .T.
2682:         ENDWITH
2683: 
2684:         *-- Label "(2) :" (top=398, left=301, w=23)
2685:         loc_oPg1.AddObject("lbl_4c_LblCunip", "Label")
2686:         WITH loc_oPg1.lbl_4c_LblCunip
2687:             .Caption   = "(2) :"
2688:             .Top       = 398
2689:             .Left      = 301
2690:             .Width     = 23
2691:             .Height    = 15
2692:             .FontName  = "Tahoma"
2693:             .FontSize  = 8
2694:             .BackStyle = 0
2695:             .Visible   = .T.
2696:         ENDWITH
2697: 
2698:         *-- Get_cunip -> txt_4c_Cunip (top=394, left=330, w=31, h=23) -> SigCdUni
2699:         loc_oPg1.AddObject("txt_4c_Cunip", "TextBox")
2700:         WITH loc_oPg1.txt_4c_Cunip
2701:             .Value    = ""
2702:             .Top      = 394
2703:             .Left     = 330
2704:             .Width    = 31
2705:             .Height   = 23
2706:             .FontName = "Tahoma"
2707:             .FontSize = 8
2708:             .Themes   = .F.
2709:             .Visible  = .T.
2710:         ENDWITH
2711:         BINDEVENT(loc_oPg1.txt_4c_Cunip, "KeyPress", THIS, "DadosCunipKeyPress")
2712: 
2713:         *-- get_dunip -> txt_4c_Dunip (top=394, left=362, w=150, h=23) - somente leitura
2714:         loc_oPg1.AddObject("txt_4c_Dunip", "TextBox")
2715:         WITH loc_oPg1.txt_4c_Dunip
2716:             .Value     = ""
2717:             .Top       = 394
2718:             .Left      = 362
2719:             .Width     = 150
2720:             .Height    = 23
2721:             .FontName  = "Tahoma"
2722:             .FontSize  = 8
2723:             .ReadOnly  = .T.
2724:             .BackColor = RGB(240, 240, 240)
2725:             .Themes    = .F.
2726:             .Visible   = .T.
2727:         ENDWITH
2728: 
2729:         *----------------------------------------------------------------------
2730:         *-- AUDITORIA (read-only, Top=397-419): DtIncs/Usuario/DataAlts/UsuaAlts
2731:         *----------------------------------------------------------------------
2732:         *-- Label "Data / Usuario" (top=365, left=833, w=84)
2733:         loc_oPg1.AddObject("lbl_4c_LblDtUsu", "Label")
2734:         WITH loc_oPg1.lbl_4c_LblDtUsu
2735:             .Caption   = "Data / Usu" + CHR(225) + "rio"
2736:             .Top       = 365
2737:             .Left      = 833
2738:             .Width     = 84
2739:             .Height    = 15
2740:             .FontName  = "Tahoma"
2741:             .FontSize  = 8
2742:             .BackStyle = 0
2743:             .Visible   = .T.
2744:         ENDWITH
2745: 
2746:         *-- Label "Inclusao" (top=384, left=833, w=42)
2747:         loc_oPg1.AddObject("lbl_4c_LblIncs", "Label")
2748:         WITH loc_oPg1.lbl_4c_LblIncs
2749:             .Caption   = "Inclus" + CHR(227) + "o"
2750:             .Top       = 384
2751:             .Left      = 833

*-- Linhas 3171 a 3251:
3171:     ENDPROC
3172: 
3173:     *--------------------------------------------------------------------------
3174:     * NavegacaoDadosChange - Troca sub-pagina ativa via OptionGroup (BINDEVENT)
3175:     * Mapeamento: Value 1=Dados(p1), 2=Componente(p2), 3=Fiscal(p3),
3176:     *             4=Processo(p4), 5=Consumo(p5), 6=Custo(p6), 7=Designer(p7)
3177:     * NOTA: Legado mapeava Value=3 -> pgCusto(PageOrder=6), Value=4 -> pgDadosFiscais(3)
3178:     *       Aqui os botoes foram reordenados para sequencia logica (1..7 = pagina 1..7)
3179:     *--------------------------------------------------------------------------
3180:     PROCEDURE NavegacaoDadosChange()
3181:         LOCAL loc_nValor, loc_nPagina
3182:         loc_nValor  = THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value
3183:         loc_nPagina = 1
3184: 
3185:         DO CASE
3186:             CASE loc_nValor = 1    && Principal -> pgDados (PageOrder=1)
3187:                 loc_nPagina = 1
3188:             CASE loc_nValor = 2    && Componente -> pgComposicao (PageOrder=2)
3189:                 loc_nPagina = 2
3190:             CASE loc_nValor = 3    && Fiscal -> pgDadosFiscais (PageOrder=3)
3191:                 loc_nPagina = 3
3192:             CASE loc_nValor = 4    && Processo -> PgDadosFaseP (PageOrder=4)
3193:                 loc_nPagina = 4
3194:             CASE loc_nValor = 5    && Consumo -> PgDadosConsP (PageOrder=5)
3195:                 loc_nPagina = 5
3196:             CASE loc_nValor = 6    && Custo -> pgCusto (PageOrder=6)
3197:                 loc_nPagina = 6
3198:             CASE loc_nValor = 7    && Designer -> pgDesigner (PageOrder=7)
3199:                 loc_nPagina = 7
3200:         ENDCASE
3201: 
3202:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = loc_nPagina
3203:     ENDPROC
3204: 
3205:     *--------------------------------------------------------------------------
3206:     * CarregarLista - Carrega grid da pagina Lista com dados do SQL Server
3207:     * Filtros: getCgru (grupo), getDtIni/getDtFim (DataAlts), optFilSituas (Situas)
3208:     * Situacao: Situas=1 Ativo(verde/preto), Situas=2 Inativo(vermelho)
3209:     * Padrao SQLEXEC: query em temp ? ZAP cursor_4c_Lista ? APPEND FROM DBF
3210:     *--------------------------------------------------------------------------
3211:     PROCEDURE CarregarLista()
3212:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCgru, loc_dIni, loc_dFim
3213:         LOCAL loc_nStI, loc_nStF, loc_cFiltroGrupo, loc_cFiltroSitua, loc_oGrid, loc_oPg1
3214:         LOCAL loc_aErros(1)
3215:         loc_lSucesso = .F.
3216: 
3217:         TRY
3218:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
3219:                 loc_lSucesso = .T.
3220:             ELSE
3221:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3222: 
3223:                 *-- Ler filtros com defaults seguros
3224:                 loc_cCgru = ""
3225:                 loc_dIni  = {^1900-01-01}
3226:                 loc_dFim  = {^2900-12-31}
3227:                 loc_nStI  = 1
3228:                 loc_nStF  = 2
3229: 
3230:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Filtros", 5)
3231:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Cgru", 5)
3232:                         loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
3233:                     ENDIF
3234:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtIni", 5)
3235:                         IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value)
3236:                             loc_dIni = loc_oPg1.cnt_4c_Filtros.txt_4c_DtIni.Value
3237:                         ENDIF
3238:                     ENDIF
3239:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_DtFim", 5)
3240:                         IF !EMPTY(loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value)
3241:                             loc_dFim = loc_oPg1.cnt_4c_Filtros.txt_4c_DtFim.Value
3242:                         ENDIF
3243:                     ENDIF
3244:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "obj_4c_Situa", 5)
3245:                         LOCAL loc_nSitua
3246:                         loc_nSitua = loc_oPg1.cnt_4c_Filtros.obj_4c_Situa.Value
3247:                         *-- Value=1 Todos: IN(1,2) | Value=2 Ativos: IN(1,1) | Value=3 Inativos: IN(2,2)
3248:                         loc_nStI = IIF(loc_nSitua = 3, 2, 1)
3249:                         loc_nStF = IIF(loc_nSitua = 2, 1, 2)
3250:                     ENDIF
3251:                 ENDIF

*-- Linhas 3327 a 3370:
3327:     * BOParaForm - Transfere dados do BO para os campos do formulario
3328:     * FASE 5: Implementar apos adicionar campos em ConfigurarPaginaDados
3329:     *--------------------------------------------------------------------------
3330:     PROTECTED PROCEDURE BOParaForm()
3331:         LOCAL loc_oPg1, loc_oBO
3332:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3333:         loc_oBO  = THIS.this_oBusinessObject
3334: 
3335:         *-- ROW 1: Produto + Descricao + Status + DtSituas
3336:         loc_oPg1.txt_4c_Cpro.Value        = ALLTRIM(loc_oBO.this_cCpros)
3337:         loc_oPg1.txt_4c_Dpro.Value        = ALLTRIM(loc_oBO.this_cDpros)
3338:         loc_oPg1.obj_4c_OpcSituacao.Value = IIF(loc_oBO.this_nSituas = 2, 2, 1)
3339:         IF !EMPTY(loc_oBO.this_dDatas)
3340:             loc_oPg1.txt_4c_DtSituas.Value = loc_oBO.this_dDatas
3341:         ELSE
3342:             loc_oPg1.txt_4c_DtSituas.Value = DATE()
3343:         ENDIF
3344: 
3345:         *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
3346:         loc_oPg1.txt_4c_DPro2s.Value      = ALLTRIM(loc_oBO.this_cDpro2s)
3347:         loc_oPg1.txt_4c_CProEq.Value      = ALLTRIM(loc_oBO.this_cCproeqs)
3348:         loc_oPg1.txt_4c_Cbar.Value        = loc_oBO.this_nCbars
3349:         loc_oPg1.txt_4c_LtMinsV.Value     = loc_oBO.this_nLtminsv
3350: 
3351:         *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
3352:         loc_oPg1.txt_4c_Cgru.Value        = ALLTRIM(loc_oBO.this_cCgrus)
3353:         loc_oPg1.txt_4c_Dgru.Value        = ""
3354:         loc_oPg1.txt_4c_Merc.Value        = ALLTRIM(loc_oBO.this_cMercs)
3355:         loc_oPg1.txt_4c_IdeCPros.Value    = ALLTRIM(loc_oBO.this_cIdecpros)
3356:         loc_oPg1.txt_4c_EAN13.Value       = loc_oBO.this_nEan13
3357:         loc_oPg1.obj_4c_ProdWeb.Value     = loc_oBO.this_nWebpros + 1
3358: 
3359:         *-- ROW 4: Subgrupo + Variacao
3360:         loc_oPg1.txt_4c_CSGru.Value       = ALLTRIM(loc_oBO.this_cSgrus)
3361:         loc_oPg1.txt_4c_DsGru.Value       = ""
3362:         loc_oPg1.obj_4c_Variacao.Value    = IIF(loc_oBO.this_nVarias = 1, 2, 1)
3363: 
3364:         *-- ROW 5: Linha + Garantia
3365:         loc_oPg1.txt_4c_Lin.Value         = ALLTRIM(loc_oBO.this_cLinhas)
3366:         loc_oPg1.txt_4c_DLin.Value        = ""
3367:         loc_oPg1.txt_4c_DiasGar.Value     = loc_oBO.this_nDiasinas
3368:         loc_oPg1.chk_4c_GarVit.Value      = 0
3369: 
3370:         *-- ROW 6: Colecao/Grupo de Venda + Obs3

*-- Linhas 3469 a 3512:
3469:     *--------------------------------------------------------------------------
3470:     * FormParaBO - Transfere dados dos campos para o BO
3471:     *--------------------------------------------------------------------------
3472:     PROTECTED PROCEDURE FormParaBO()
3473:         LOCAL loc_oPg1, loc_oBO
3474:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3475:         loc_oBO  = THIS.this_oBusinessObject
3476: 
3477:         *-- ROW 1: Produto + Descricao + Status + DtSituas
3478:         loc_oBO.this_cCpros    = ALLTRIM(loc_oPg1.txt_4c_Cpro.Value)
3479:         loc_oBO.this_cDpros    = ALLTRIM(loc_oPg1.txt_4c_Dpro.Value)
3480:         loc_oBO.this_nSituas   = loc_oPg1.obj_4c_OpcSituacao.Value
3481:         IF !EMPTY(loc_oPg1.txt_4c_DtSituas.Value)
3482:             loc_oBO.this_dDatas = loc_oPg1.txt_4c_DtSituas.Value
3483:         ELSE
3484:             loc_oBO.this_dDatas = DATE()
3485:         ENDIF
3486: 
3487:         *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
3488:         loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPg1.txt_4c_DPro2s.Value)
3489:         loc_oBO.this_cCproeqs  = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
3490:         loc_oBO.this_nCbars    = loc_oPg1.txt_4c_Cbar.Value
3491:         loc_oBO.this_nLtminsv  = loc_oPg1.txt_4c_LtMinsV.Value
3492: 
3493:         *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
3494:         loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
3495:         loc_oBO.this_cMercs    = ALLTRIM(loc_oPg1.txt_4c_Merc.Value)
3496:         loc_oBO.this_cIdecpros = ALLTRIM(loc_oPg1.txt_4c_IdeCPros.Value)
3497:         loc_oBO.this_nEan13    = loc_oPg1.txt_4c_EAN13.Value
3498:         loc_oBO.this_nWebpros  = loc_oPg1.obj_4c_ProdWeb.Value - 1
3499: 
3500:         *-- ROW 4: Subgrupo + Variacao
3501:         loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg1.txt_4c_CSGru.Value)
3502:         loc_oBO.this_nVarias   = IIF(loc_oPg1.obj_4c_Variacao.Value = 2, 1, 0)
3503: 
3504:         *-- ROW 5: Linha + Garantia
3505:         loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
3506:         loc_oBO.this_nDiasinas = loc_oPg1.txt_4c_DiasGar.Value
3507: 
3508:         *-- ROW 6: Colecao/Grupo de Venda + Obs3
3509:         loc_oBO.this_cColecoes = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
3510:         loc_oBO.this_cObsetqs  = ALLTRIM(loc_oPg1.txt_4c_Obs3.Value)
3511: 
3512:         *-- ROW 7: Fornecedor + Obs1 + Obs2

*-- Linhas 3557 a 3600:
3557:     * par_lHabilitar: .T.=editar, .F.=somente leitura (VISUALIZAR)
3558:     * par_lHabilitarCodigo: .T.=codigo editavel (INCLUIR), .F.=codigo bloqueado (ALTERAR)
3559:     *--------------------------------------------------------------------------
3560:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar, par_lHabilitarCodigo)
3561:         LOCAL loc_oPg1
3562:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3563: 
3564:         *-- Codigo produto: editavel apenas em INCLUIR
3565:         loc_oPg1.txt_4c_Cpro.ReadOnly      = !par_lHabilitarCodigo
3566:         loc_oPg1.txt_4c_Cpro.BackColor     = IIF(par_lHabilitarCodigo, RGB(255,255,255), RGB(240,240,240))
3567: 
3568:         *-- Campos editaveis (ROW1-ROW10 exceto os ReadOnly permanentes)
3569:         loc_oPg1.txt_4c_Dpro.ReadOnly      = !par_lHabilitar
3570:         loc_oPg1.txt_4c_Dpro.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3571: 
3572:         loc_oPg1.obj_4c_OpcSituacao.Enabled = par_lHabilitar
3573: 
3574:         loc_oPg1.txt_4c_DPro2s.ReadOnly    = !par_lHabilitar
3575:         loc_oPg1.txt_4c_DPro2s.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3576: 
3577:         loc_oPg1.txt_4c_CProEq.ReadOnly    = !par_lHabilitar
3578:         loc_oPg1.txt_4c_CProEq.BackColor   = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3579: 
3580:         loc_oPg1.txt_4c_Cbar.ReadOnly      = !par_lHabilitar
3581:         loc_oPg1.txt_4c_Cbar.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3582: 
3583:         loc_oPg1.txt_4c_LtMinsV.ReadOnly   = !par_lHabilitar
3584:         loc_oPg1.txt_4c_LtMinsV.BackColor  = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3585: 
3586:         loc_oPg1.txt_4c_Cgru.ReadOnly      = !par_lHabilitar
3587:         loc_oPg1.txt_4c_Cgru.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3588: 
3589:         loc_oPg1.txt_4c_Merc.ReadOnly      = !par_lHabilitar
3590:         loc_oPg1.txt_4c_Merc.BackColor     = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3591: 
3592:         loc_oPg1.txt_4c_IdeCPros.ReadOnly  = !par_lHabilitar
3593:         loc_oPg1.txt_4c_IdeCPros.BackColor = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3594: 
3595:         loc_oPg1.txt_4c_EAN13.ReadOnly     = !par_lHabilitar
3596:         loc_oPg1.txt_4c_EAN13.BackColor    = IIF(par_lHabilitar, RGB(255,255,255), RGB(240,240,240))
3597: 
3598:         loc_oPg1.obj_4c_ProdWeb.Enabled    = par_lHabilitar
3599: 
3600:         loc_oPg1.txt_4c_CSGru.ReadOnly     = !par_lHabilitar

*-- Linhas 3715 a 5153:
3715:     *--------------------------------------------------------------------------
3716:     * DadosCproKeyPress - Handler KeyPress no txt_4c_Cpro (codigo produto)
3717:     *--------------------------------------------------------------------------
3718:     PROCEDURE DadosCproKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3719:         IF par_nKeyCode = 115
3720:             THIS.AbrirLookupDadosCpro()
3721:         ENDIF
3722:     ENDPROC
3723: 
3724:     *--------------------------------------------------------------------------
3725:     * AbrirLookupDadosCpro - Lookup produto pelo codigo (F4 em txt_4c_Cpro)
3726:     *--------------------------------------------------------------------------
3727:     PROCEDURE AbrirLookupDadosCpro()
3728:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
3729:         loc_oBusca = .NULL.
3730:         loc_cCod   = ""
3731:         TRY
3732:             IF USED("cursor_4c_Busca")
3733:                 USE IN cursor_4c_Busca
3734:             ENDIF
3735:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3736:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
3737:             ENDIF
3738:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3739:             IF !ISNULL(loc_oBusca)
3740:                 loc_oBusca.this_cTabela        = "SigCdPro"
3741:                 loc_oBusca.this_cCampoChave    = "cpros"
3742:                 loc_oBusca.this_cCampoBusca    = "cpros"
3743:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3744:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
3745:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3746:                 loc_oBusca.Caption = "Buscar Produto"
3747:                 loc_oBusca.Show()
3748:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3749:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
3750:                 ENDIF
3751:                 IF USED("cursor_4c_Busca")
3752:                     USE IN cursor_4c_Busca
3753:                 ENDIF
3754:                 loc_oBusca.Release()
3755:             ENDIF
3756:         CATCH TO loc_oErro
3757:             MsgErro("Erro na busca de produto:" + CHR(13) + loc_oErro.Message, "Erro")
3758:         ENDTRY
3759:         loc_oBusca = .NULL.
3760:         IF !EMPTY(loc_cCod)
3761:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3762:             loc_oPg1.txt_4c_Cpro.Value = loc_cCod
3763:         ENDIF
3764:     ENDPROC
3765: 
3766:     *--------------------------------------------------------------------------
3767:     * DadosCgruKeyPress - Handler KeyPress no txt_4c_Cgru (grupo)
3768:     *--------------------------------------------------------------------------
3769:     PROCEDURE DadosCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3770:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3771:             THIS.ValidarDadosCgru()
3772:         ENDIF
3773:         IF par_nKeyCode = 115
3774:             THIS.AbrirLookupDadosCgru()
3775:         ENDIF
3776:     ENDPROC
3777: 
3778:     *--------------------------------------------------------------------------
3779:     * DadosLinKeyPress - Handler KeyPress no txt_4c_Lin (linha)
3780:     *--------------------------------------------------------------------------
3781:     PROCEDURE DadosLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3782:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3783:             THIS.ValidarDadosLin()
3784:         ENDIF
3785:         IF par_nKeyCode = 115
3786:             THIS.AbrirLookupDadosLin()
3787:         ENDIF
3788:     ENDPROC
3789: 
3790:     *--------------------------------------------------------------------------
3791:     * DadosColKeyPress - Handler KeyPress no txt_4c_Col (colecao/grupo de venda)
3792:     *--------------------------------------------------------------------------
3793:     PROCEDURE DadosColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3794:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3795:             THIS.ValidarDadosCol()
3796:         ENDIF
3797:         IF par_nKeyCode = 115
3798:             THIS.AbrirLookupDadosCol()
3799:         ENDIF
3800:     ENDPROC
3801: 
3802:     *--------------------------------------------------------------------------
3803:     * DadosIforKeyPress - Handler KeyPress no txt_4c_Ifor (fornecedor)
3804:     *--------------------------------------------------------------------------
3805:     PROCEDURE DadosIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3806:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3807:             THIS.ValidarDadosIfor()
3808:         ENDIF
3809:         IF par_nKeyCode = 115
3810:             THIS.AbrirLookupDadosIfor()
3811:         ENDIF
3812:     ENDPROC
3813: 
3814:     *--------------------------------------------------------------------------
3815:     * DadosCorKeyPress - Handler KeyPress no txt_4c_Cor (cor)
3816:     *--------------------------------------------------------------------------
3817:     PROCEDURE DadosCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3818:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3819:             THIS.ValidarDadosCor()
3820:         ENDIF
3821:         IF par_nKeyCode = 115
3822:             THIS.AbrirLookupDadosCor()
3823:         ENDIF
3824:     ENDPROC
3825: 
3826:     *--------------------------------------------------------------------------
3827:     * DadosTamKeyPress - Handler KeyPress no txt_4c_Tam (tamanho)
3828:     *--------------------------------------------------------------------------
3829:     PROCEDURE DadosTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3830:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3831:             THIS.ValidarDadosTam()
3832:         ENDIF
3833:         IF par_nKeyCode = 115
3834:             THIS.AbrirLookupDadosTam()
3835:         ENDIF
3836:     ENDPROC
3837: 
3838:     *--------------------------------------------------------------------------
3839:     * DadosCodFinPKeyPress - Handler KeyPress no txt_4c_CodFinP (modelo)
3840:     *--------------------------------------------------------------------------
3841:     PROCEDURE DadosCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3842:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3843:             THIS.ValidarDadosCodFinP()
3844:         ENDIF
3845:         IF par_nKeyCode = 115
3846:             THIS.AbrirLookupDadosCodFinP()
3847:         ENDIF
3848:     ENDPROC
3849: 
3850:     *--------------------------------------------------------------------------
3851:     * DadosCodacbKeyPress - Handler KeyPress no txt_4c_Codacb (acabamento)
3852:     *--------------------------------------------------------------------------
3853:     PROCEDURE DadosCodacbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3854:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3855:             THIS.ValidarDadosCodacb()
3856:         ENDIF
3857:         IF par_nKeyCode = 115
3858:             THIS.AbrirLookupDadosCodacb()
3859:         ENDIF
3860:     ENDPROC
3861: 
3862:     *--------------------------------------------------------------------------
3863:     * DadosCProEqKeyPress - Handler KeyPress no txt_4c_CProEq (produto equivalente)
3864:     *--------------------------------------------------------------------------
3865:     PROCEDURE DadosCProEqKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3866:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3867:             THIS.ValidarDadosCProEq()
3868:         ENDIF
3869:         IF par_nKeyCode = 115
3870:             THIS.AbrirLookupDadosCProEq()
3871:         ENDIF
3872:     ENDPROC
3873: 
3874:     *--------------------------------------------------------------------------
3875:     * CmdQtMinClick - Handler botao "..." para QtMin por empresa
3876:     *--------------------------------------------------------------------------
3877:     PROCEDURE CmdQtMinClick()
3878:         MsgInfo("Funcionalidade de estoque m" + CHR(237) + "nimo por empresa n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Informa" + CHR(231) + CHR(227) + "o")
3879:     ENDPROC
3880: 
3881:     *--------------------------------------------------------------------------
3882:     * DadosClassKeyPress - Handler KeyPress no txt_4c_Class (classificacao)
3883:     *--------------------------------------------------------------------------
3884:     PROCEDURE DadosClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3885:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3886:             THIS.ValidarDadosClass()
3887:         ENDIF
3888:         IF par_nKeyCode = 115
3889:             THIS.AbrirLookupDadosClass()
3890:         ENDIF
3891:     ENDPROC
3892: 
3893:     *--------------------------------------------------------------------------
3894:     * DadosLocalKeyPress - Handler KeyPress no txt_4c_Local (local de estoque)
3895:     *--------------------------------------------------------------------------
3896:     PROCEDURE DadosLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3897:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3898:             THIS.ValidarDadosLocal()
3899:         ENDIF
3900:         IF par_nKeyCode = 115
3901:             THIS.AbrirLookupDadosLocal()
3902:         ENDIF
3903:     ENDPROC
3904: 
3905:     *--------------------------------------------------------------------------
3906:     * DadosMctotalKeyPress - Handler KeyPress no txt_4c_Mctotal (moeda custo)
3907:     *--------------------------------------------------------------------------
3908:     PROCEDURE DadosMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3909:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3910:             THIS.ValidarDadosMctotal()
3911:         ENDIF
3912:         IF par_nKeyCode = 115
3913:             THIS.AbrirLookupDadosMctotal()
3914:         ENDIF
3915:     ENDPROC
3916: 
3917:     *--------------------------------------------------------------------------
3918:     * DadosMpvendaKeyPress - Handler KeyPress no txt_4c_Mpvenda (moeda preco venda)
3919:     *--------------------------------------------------------------------------
3920:     PROCEDURE DadosMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3921:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3922:             THIS.ValidarDadosMpvenda()
3923:         ENDIF
3924:         IF par_nKeyCode = 115
3925:             THIS.AbrirLookupDadosMpvenda()
3926:         ENDIF
3927:     ENDPROC
3928: 
3929:     *--------------------------------------------------------------------------
3930:     * DadosMfvendaKeyPress - Handler KeyPress no txt_4c_Mfvenda (moeda fator venda)
3931:     *--------------------------------------------------------------------------
3932:     PROCEDURE DadosMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3933:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3934:             THIS.ValidarDadosMfvenda()
3935:         ENDIF
3936:         IF par_nKeyCode = 115
3937:             THIS.AbrirLookupDadosMfvenda()
3938:         ENDIF
3939:     ENDPROC
3940: 
3941:     *--------------------------------------------------------------------------
3942:     * DadosCuniKeyPress - Handler KeyPress no txt_4c_Cuni (unidade)
3943:     *--------------------------------------------------------------------------
3944:     PROCEDURE DadosCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3945:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3946:             THIS.ValidarDadosCuni()
3947:         ENDIF
3948:         IF par_nKeyCode = 115
3949:             THIS.AbrirLookupDadosCuni()
3950:         ENDIF
3951:     ENDPROC
3952: 
3953:     *--------------------------------------------------------------------------
3954:     * DadosCunipKeyPress - Handler KeyPress no txt_4c_Cunip (unidade pauta)
3955:     *--------------------------------------------------------------------------
3956:     PROCEDURE DadosCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3957:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
3958:             THIS.ValidarDadosCunip()
3959:         ENDIF
3960:         IF par_nKeyCode = 115
3961:             THIS.AbrirLookupDadosCunip()
3962:         ENDIF
3963:     ENDPROC
3964: 
3965:     *==========================================================================
3966:     *-- VALIDACAO - Valida codigo e carrega descricao (ENTER/TAB)
3967:     *==========================================================================
3968: 
3969:     *--------------------------------------------------------------------------
3970:     * ValidarDadosCgru - Valida grupo (SigCdGrp: cgrus/dgrus)
3971:     *--------------------------------------------------------------------------
3972:     PROTECTED PROCEDURE ValidarDadosCgru()
3973:         LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
3974:         loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
3975:         loc_cCgru = ALLTRIM(loc_oPg1.txt_4c_Cgru.Value)
3976:         IF EMPTY(loc_cCgru)
3977:             loc_oPg1.txt_4c_Dgru.Value = ""
3978:         ELSE
3979:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3980:                 loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
3981:                               "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3982:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruD")
3983:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruD") > 0
3984:                     loc_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruD.DGrus)
3985:                 ELSE
3986:                     loc_oPg1.txt_4c_Dgru.Value = ""
3987:                     loc_oPg1.txt_4c_Cgru.Value = ""
3988:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCgru, "Aviso")
3989:                 ENDIF
3990:                 IF USED("cursor_4c_GruD")
3991:                     USE IN cursor_4c_GruD
3992:                 ENDIF
3993:             ENDIF
3994:         ENDIF
3995:     ENDPROC
3996: 
3997:     *--------------------------------------------------------------------------
3998:     * ValidarDadosLin - Valida linha (SigCdLin: linhas/descs)
3999:     *--------------------------------------------------------------------------
4000:     PROTECTED PROCEDURE ValidarDadosLin()
4001:         LOCAL loc_oPg1, loc_cLin, loc_cSQL, loc_nResult
4002:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4003:         loc_cLin = ALLTRIM(loc_oPg1.txt_4c_Lin.Value)
4004:         IF EMPTY(loc_cLin)
4005:             loc_oPg1.txt_4c_DLin.Value = ""
4006:         ELSE
4007:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4008:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
4009:                               "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
4010:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinD")
4011:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinD") > 0
4012:                     loc_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinD.Descs)
4013:                 ELSE
4014:                     loc_oPg1.txt_4c_DLin.Value = ""
4015:                     loc_oPg1.txt_4c_Lin.Value  = ""
4016:                     MsgAviso("Linha n" + CHR(227) + "o encontrada: " + loc_cLin, "Aviso")
4017:                 ENDIF
4018:                 IF USED("cursor_4c_LinD")
4019:                     USE IN cursor_4c_LinD
4020:                 ENDIF
4021:             ENDIF
4022:         ENDIF
4023:     ENDPROC
4024: 
4025:     *--------------------------------------------------------------------------
4026:     * ValidarDadosCol - Valida colecao/grupo de venda (SIGCDCOL: colecoes/descs)
4027:     *--------------------------------------------------------------------------
4028:     PROTECTED PROCEDURE ValidarDadosCol()
4029:         LOCAL loc_oPg1, loc_cCol, loc_cSQL, loc_nResult
4030:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4031:         loc_cCol = ALLTRIM(loc_oPg1.txt_4c_Col.Value)
4032:         IF EMPTY(loc_cCol)
4033:             loc_oPg1.txt_4c_DCol.Value = ""
4034:         ELSE
4035:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4036:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
4037:                               "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
4038:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColD")
4039:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColD") > 0
4040:                     loc_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColD.Descs)
4041:                 ELSE
4042:                     loc_oPg1.txt_4c_DCol.Value = ""
4043:                     loc_oPg1.txt_4c_Col.Value  = ""
4044:                     MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCol, "Aviso")
4045:                 ENDIF
4046:                 IF USED("cursor_4c_ColD")
4047:                     USE IN cursor_4c_ColD
4048:                 ENDIF
4049:             ENDIF
4050:         ENDIF
4051:     ENDPROC
4052: 
4053:     *--------------------------------------------------------------------------
4054:     * ValidarDadosIfor - Valida fornecedor (SIGCDCLI: iclis/rclis)
4055:     *--------------------------------------------------------------------------
4056:     PROTECTED PROCEDURE ValidarDadosIfor()
4057:         LOCAL loc_oPg1, loc_cIfor, loc_cSQL, loc_nResult
4058:         loc_oPg1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4059:         loc_cIfor = ALLTRIM(loc_oPg1.txt_4c_Ifor.Value)
4060:         IF EMPTY(loc_cIfor)
4061:             loc_oPg1.txt_4c_Dfor.Value = ""
4062:         ELSE
4063:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4064:                 loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
4065:                               "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
4066:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforD")
4067:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforD") > 0
4068:                     loc_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforD.RClis)
4069:                 ELSE
4070:                     loc_oPg1.txt_4c_Dfor.Value = ""
4071:                     loc_oPg1.txt_4c_Ifor.Value = ""
4072:                     MsgAviso("Fornecedor n" + CHR(227) + "o encontrado: " + loc_cIfor, "Aviso")
4073:                 ENDIF
4074:                 IF USED("cursor_4c_IforD")
4075:                     USE IN cursor_4c_IforD
4076:                 ENDIF
4077:             ENDIF
4078:         ENDIF
4079:     ENDPROC
4080: 
4081:     *--------------------------------------------------------------------------
4082:     * ValidarDadosCor - Valida cor (SigCdCor: cods/descs)
4083:     *--------------------------------------------------------------------------
4084:     PROTECTED PROCEDURE ValidarDadosCor()
4085:         LOCAL loc_oPg1, loc_cCor, loc_cSQL, loc_nResult
4086:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4087:         loc_cCor = ALLTRIM(loc_oPg1.txt_4c_Cor.Value)
4088:         IF EMPTY(loc_cCor)
4089:             *-- Cor vazia e valida (produto sem cor padrao)
4090:         ELSE
4091:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4092:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdCor " + ;
4093:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCor, 4))
4094:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorD")
4095:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_CorD") > 0
4096:                     IF cursor_4c_CorD.nExiste = 0
4097:                         loc_oPg1.txt_4c_Cor.Value = ""
4098:                         MsgAviso("Cor n" + CHR(227) + "o encontrada: " + loc_cCor, "Aviso")
4099:                     ENDIF
4100:                 ENDIF
4101:                 IF USED("cursor_4c_CorD")
4102:                     USE IN cursor_4c_CorD
4103:                 ENDIF
4104:             ENDIF
4105:         ENDIF
4106:     ENDPROC
4107: 
4108:     *--------------------------------------------------------------------------
4109:     * ValidarDadosTam - Valida tamanho (SigCdTam: cods/descs)
4110:     *--------------------------------------------------------------------------
4111:     PROTECTED PROCEDURE ValidarDadosTam()
4112:         LOCAL loc_oPg1, loc_cTam, loc_cSQL, loc_nResult
4113:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4114:         loc_cTam = ALLTRIM(loc_oPg1.txt_4c_Tam.Value)
4115:         IF EMPTY(loc_cTam)
4116:             *-- Tamanho vazio e valido (produto sem tamanho padrao)
4117:         ELSE
4118:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4119:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdTam " + ;
4120:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cTam, 4))
4121:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamD")
4122:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TamD") > 0
4123:                     IF cursor_4c_TamD.nExiste = 0
4124:                         loc_oPg1.txt_4c_Tam.Value = ""
4125:                         MsgAviso("Tamanho n" + CHR(227) + "o encontrado: " + loc_cTam, "Aviso")
4126:                     ENDIF
4127:                 ENDIF
4128:                 IF USED("cursor_4c_TamD")
4129:                     USE IN cursor_4c_TamD
4130:                 ENDIF
4131:             ENDIF
4132:         ENDIF
4133:     ENDPROC
4134: 
4135:     *--------------------------------------------------------------------------
4136:     * ValidarDadosCodFinP - Valida modelo (sigcdmod: pkchave/descs)
4137:     *--------------------------------------------------------------------------
4138:     PROTECTED PROCEDURE ValidarDadosCodFinP()
4139:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4140:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4141:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CodFinP.Value)
4142:         IF EMPTY(loc_cCod)
4143:             loc_oPg1.txt_4c_DesFinP.Value = ""
4144:         ELSE
4145:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4146:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
4147:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
4148:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModD")
4149:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModD") > 0
4150:                     loc_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModD.Descs)
4151:                 ELSE
4152:                     loc_oPg1.txt_4c_DesFinP.Value = ""
4153:                     loc_oPg1.txt_4c_CodFinP.Value = ""
4154:                     MsgAviso("Modelo n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4155:                 ENDIF
4156:                 IF USED("cursor_4c_ModD")
4157:                     USE IN cursor_4c_ModD
4158:                 ENDIF
4159:             ENDIF
4160:         ENDIF
4161:     ENDPROC
4162: 
4163:     *--------------------------------------------------------------------------
4164:     * ValidarDadosCodacb - Valida acabamento (SigCdAca: cods/descrs)
4165:     *--------------------------------------------------------------------------
4166:     PROTECTED PROCEDURE ValidarDadosCodacb()
4167:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4168:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4169:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Codacb.Value)
4170:         IF EMPTY(loc_cCod)
4171:             loc_oPg1.txt_4c_Dacb.Value = ""
4172:         ELSE
4173:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4174:                 loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
4175:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4176:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaD")
4177:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaD") > 0
4178:                     loc_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaD.Descrs)
4179:                 ELSE
4180:                     loc_oPg1.txt_4c_Dacb.Value = ""
4181:                     loc_oPg1.txt_4c_Codacb.Value = ""
4182:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4183:                 ENDIF
4184:                 IF USED("cursor_4c_AcaD")
4185:                     USE IN cursor_4c_AcaD
4186:                 ENDIF
4187:             ENDIF
4188:         ENDIF
4189:     ENDPROC
4190: 
4191:     *--------------------------------------------------------------------------
4192:     * ValidarDadosCProEq - Valida produto equivalente (SigCdPro: cpros/dpros)
4193:     *--------------------------------------------------------------------------
4194:     PROTECTED PROCEDURE ValidarDadosCProEq()
4195:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4196:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4197:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_CProEq.Value)
4198:         IF EMPTY(loc_cCod)
4199:             *-- Equivalente vazio e valido
4200:         ELSE
4201:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4202:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdPro " + ;
4203:                               "WHERE CPros = " + EscaparSQL(PADR(loc_cCod, 14))
4204:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EqD")
4205:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EqD") > 0
4206:                     IF cursor_4c_EqD.nExiste = 0
4207:                         loc_oPg1.txt_4c_CProEq.Value = ""
4208:                         MsgAviso("Produto equivalente n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4209:                     ENDIF
4210:                 ENDIF
4211:                 IF USED("cursor_4c_EqD")
4212:                     USE IN cursor_4c_EqD
4213:                 ENDIF
4214:             ENDIF
4215:         ENDIF
4216:     ENDPROC
4217: 
4218:     *--------------------------------------------------------------------------
4219:     * ValidarDadosClass - Valida classificacao (SigCdCls: Cods/Descs)
4220:     *--------------------------------------------------------------------------
4221:     PROTECTED PROCEDURE ValidarDadosClass()
4222:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4223:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4224:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Class.Value)
4225:         IF EMPTY(loc_cCod)
4226:             loc_oPg1.txt_4c_DClass.Value = ""
4227:         ELSE
4228:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4229:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
4230:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4231:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsD")
4232:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsD") > 0
4233:                     loc_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsD.Descs)
4234:                 ELSE
4235:                     loc_oPg1.txt_4c_DClass.Value = ""
4236:                     loc_oPg1.txt_4c_Class.Value  = ""
4237:                     MsgAviso("Classifica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4238:                 ENDIF
4239:                 IF USED("cursor_4c_ClsD")
4240:                     USE IN cursor_4c_ClsD
4241:                 ENDIF
4242:             ENDIF
4243:         ENDIF
4244:     ENDPROC
4245: 
4246:     *--------------------------------------------------------------------------
4247:     * ValidarDadosLocal - Valida local de estoque (SigPrLcl: Codigos/Descricaos)
4248:     *--------------------------------------------------------------------------
4249:     PROTECTED PROCEDURE ValidarDadosLocal()
4250:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4251:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4252:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
4253:         IF !EMPTY(loc_cCod)
4254:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4255:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigPrLcl " + ;
4256:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 10))
4257:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclD")
4258:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LclD") > 0
4259:                     IF cursor_4c_LclD.nExiste = 0
4260:                         loc_oPg1.txt_4c_Local.Value = ""
4261:                         MsgAviso("Local de estoque n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4262:                     ENDIF
4263:                 ENDIF
4264:                 IF USED("cursor_4c_LclD")
4265:                     USE IN cursor_4c_LclD
4266:                 ENDIF
4267:             ENDIF
4268:         ENDIF
4269:     ENDPROC
4270: 
4271:     *--------------------------------------------------------------------------
4272:     * ValidarDadosCuni - Valida unidade (SigCdUni: CUnis/DUnis)
4273:     *--------------------------------------------------------------------------
4274:     PROTECTED PROCEDURE ValidarDadosCuni()
4275:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4276:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4277:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cuni.Value)
4278:         IF EMPTY(loc_cCod)
4279:             loc_oPg1.txt_4c_Duni.Value = ""
4280:         ELSE
4281:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4282:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4283:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4284:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniD")
4285:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniD") > 0
4286:                     loc_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniD.DUnis)
4287:                 ELSE
4288:                     loc_oPg1.txt_4c_Duni.Value = ""
4289:                     loc_oPg1.txt_4c_Cuni.Value = ""
4290:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4291:                 ENDIF
4292:                 IF USED("cursor_4c_UniD")
4293:                     USE IN cursor_4c_UniD
4294:                 ENDIF
4295:             ENDIF
4296:         ENDIF
4297:     ENDPROC
4298: 
4299:     *--------------------------------------------------------------------------
4300:     * ValidarDadosCunip - Valida unidade de pauta (SigCdUni: CUnis/DUnis)
4301:     *--------------------------------------------------------------------------
4302:     PROTECTED PROCEDURE ValidarDadosCunip()
4303:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4304:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4305:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Cunip.Value)
4306:         IF EMPTY(loc_cCod)
4307:             loc_oPg1.txt_4c_Dunip.Value = ""
4308:         ELSE
4309:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4310:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4311:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4312:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipD")
4313:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipD") > 0
4314:                     loc_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipD.DUnis)
4315:                 ELSE
4316:                     loc_oPg1.txt_4c_Dunip.Value = ""
4317:                     loc_oPg1.txt_4c_Cunip.Value = ""
4318:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4319:                 ENDIF
4320:                 IF USED("cursor_4c_UnipD")
4321:                     USE IN cursor_4c_UnipD
4322:                 ENDIF
4323:             ENDIF
4324:         ENDIF
4325:     ENDPROC
4326: 
4327:     *--------------------------------------------------------------------------
4328:     * ValidarDadosMctotal - Valida moeda custo (SigCdMoe: CMoes/DMoes)
4329:     *--------------------------------------------------------------------------
4330:     PROTECTED PROCEDURE ValidarDadosMctotal()
4331:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4332:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4333:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
4334:         IF !EMPTY(loc_cCod)
4335:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4336:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4337:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4338:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCtD")
4339:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeCtD") > 0
4340:                     IF cursor_4c_MoeCtD.nExiste = 0
4341:                         loc_oPg1.txt_4c_Mctotal.Value = ""
4342:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4343:                     ENDIF
4344:                 ENDIF
4345:                 IF USED("cursor_4c_MoeCtD")
4346:                     USE IN cursor_4c_MoeCtD
4347:                 ENDIF
4348:             ENDIF
4349:         ENDIF
4350:     ENDPROC
4351: 
4352:     *--------------------------------------------------------------------------
4353:     * ValidarDadosMpvenda - Valida moeda preco venda (SigCdMoe: CMoes/DMoes)
4354:     *--------------------------------------------------------------------------
4355:     PROTECTED PROCEDURE ValidarDadosMpvenda()
4356:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4357:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4358:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
4359:         IF !EMPTY(loc_cCod)
4360:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4361:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4362:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4363:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePvD")
4364:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoePvD") > 0
4365:                     IF cursor_4c_MoePvD.nExiste = 0
4366:                         loc_oPg1.txt_4c_Mpvenda.Value = ""
4367:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4368:                     ENDIF
4369:                 ENDIF
4370:                 IF USED("cursor_4c_MoePvD")
4371:                     USE IN cursor_4c_MoePvD
4372:                 ENDIF
4373:             ENDIF
4374:         ENDIF
4375:     ENDPROC
4376: 
4377:     *--------------------------------------------------------------------------
4378:     * ValidarDadosMfvenda - Valida moeda fator venda (SigCdMoe: CMoes/DMoes)
4379:     *--------------------------------------------------------------------------
4380:     PROTECTED PROCEDURE ValidarDadosMfvenda()
4381:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4382:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4383:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mfvenda.Value)
4384:         IF !EMPTY(loc_cCod)
4385:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4386:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4387:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4388:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeFvD")
4389:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeFvD") > 0
4390:                     IF cursor_4c_MoeFvD.nExiste = 0
4391:                         loc_oPg1.txt_4c_Mfvenda.Value = ""
4392:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4393:                     ENDIF
4394:                 ENDIF
4395:                 IF USED("cursor_4c_MoeFvD")
4396:                     USE IN cursor_4c_MoeFvD
4397:                 ENDIF
4398:             ENDIF
4399:         ENDIF
4400:     ENDPROC
4401: 
4402:     *==========================================================================
4403:     *-- LOOKUPS - Abertura de FormBuscaAuxiliar (F4)
4404:     *==========================================================================
4405: 
4406:     *--------------------------------------------------------------------------
4407:     * AbrirLookupDadosCgru - Lookup grupo (SigCdGrp: cgrus/dgrus)
4408:     *--------------------------------------------------------------------------
4409:     PROCEDURE AbrirLookupDadosCgru()
4410:         LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
4411:         loc_oBusca = .NULL.
4412:         loc_cCgru  = ""
4413:         loc_cDgru  = ""
4414:         TRY
4415:             IF USED("cursor_4c_Busca")
4416:                 USE IN cursor_4c_Busca
4417:             ENDIF
4418:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4419:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
4420:             ENDIF
4421:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4422:             IF !ISNULL(loc_oBusca)
4423:                 loc_oBusca.this_cTabela        = "SigCdGrp"
4424:                 loc_oBusca.this_cCampoChave    = "cgrus"
4425:                 loc_oBusca.this_cCampoBusca    = "cgrus"
4426:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4427:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
4428:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4429:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
4430:                 loc_oBusca.Show()
4431:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4432:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
4433:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
4434:                 ENDIF
4435:                 IF USED("cursor_4c_Busca")
4436:                     USE IN cursor_4c_Busca
4437:                 ENDIF
4438:                 loc_oBusca.Release()
4439:             ENDIF
4440:         CATCH TO loc_oErro
4441:             MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
4442:         ENDTRY
4443:         loc_oBusca = .NULL.
4444:         IF !EMPTY(loc_cCgru)
4445:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4446:             loc_oPg1.txt_4c_Cgru.Value = loc_cCgru
4447:             loc_oPg1.txt_4c_Dgru.Value = loc_cDgru
4448:         ENDIF
4449:     ENDPROC
4450: 
4451:     *--------------------------------------------------------------------------
4452:     * AbrirLookupDadosLin - Lookup linha (SigCdLin: linhas/descs)
4453:     *--------------------------------------------------------------------------
4454:     PROCEDURE AbrirLookupDadosLin()
4455:         LOCAL loc_oBusca, loc_cLin, loc_cDLin, loc_oPg1
4456:         loc_oBusca = .NULL.
4457:         loc_cLin   = ""
4458:         loc_cDLin  = ""
4459:         TRY
4460:             IF USED("cursor_4c_Busca")
4461:                 USE IN cursor_4c_Busca
4462:             ENDIF
4463:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4464:                 SQLEXEC(gnConnHandle, "SELECT Linhas AS linhas, Descs AS descs FROM SigCdLin ORDER BY Linhas", "cursor_4c_Busca")
4465:             ENDIF
4466:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4467:             IF !ISNULL(loc_oBusca)
4468:                 loc_oBusca.this_cTabela        = "SigCdLin"
4469:                 loc_oBusca.this_cCampoChave    = "linhas"
4470:                 loc_oBusca.this_cCampoBusca    = "linhas"
4471:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4472:                 loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
4473:                 loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4474:                 loc_oBusca.Caption = "Buscar Linha"
4475:                 loc_oBusca.Show()
4476:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4477:                     loc_cLin  = ALLTRIM(cursor_4c_Busca.linhas)
4478:                     loc_cDLin = ALLTRIM(cursor_4c_Busca.descs)
4479:                 ENDIF
4480:                 IF USED("cursor_4c_Busca")
4481:                     USE IN cursor_4c_Busca
4482:                 ENDIF
4483:                 loc_oBusca.Release()
4484:             ENDIF
4485:         CATCH TO loc_oErro
4486:             MsgErro("Erro na busca de linha:" + CHR(13) + loc_oErro.Message, "Erro")
4487:         ENDTRY
4488:         loc_oBusca = .NULL.
4489:         IF !EMPTY(loc_cLin)
4490:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4491:             loc_oPg1.txt_4c_Lin.Value  = loc_cLin
4492:             loc_oPg1.txt_4c_DLin.Value = loc_cDLin
4493:         ENDIF
4494:     ENDPROC
4495: 
4496:     *--------------------------------------------------------------------------
4497:     * AbrirLookupDadosCol - Lookup colecao/grupo de venda (SIGCDCOL: colecoes/descs)
4498:     *--------------------------------------------------------------------------
4499:     PROCEDURE AbrirLookupDadosCol()
4500:         LOCAL loc_oBusca, loc_cCol, loc_cDCol, loc_oPg1
4501:         loc_oBusca = .NULL.
4502:         loc_cCol   = ""
4503:         loc_cDCol  = ""
4504:         TRY
4505:             IF USED("cursor_4c_Busca")
4506:                 USE IN cursor_4c_Busca
4507:             ENDIF
4508:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4509:                 SQLEXEC(gnConnHandle, "SELECT Colecoes AS colecoes, Descs AS descs FROM SIGCDCOL ORDER BY Colecoes", "cursor_4c_Busca")
4510:             ENDIF
4511:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4512:             IF !ISNULL(loc_oBusca)
4513:                 loc_oBusca.this_cTabela        = "SIGCDCOL"
4514:                 loc_oBusca.this_cCampoChave    = "colecoes"
4515:                 loc_oBusca.this_cCampoBusca    = "colecoes"
4516:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4517:                 loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
4518:                 loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4519:                 loc_oBusca.Caption = "Buscar Grupo de Venda"
4520:                 loc_oBusca.Show()
4521:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4522:                     loc_cCol  = ALLTRIM(cursor_4c_Busca.colecoes)
4523:                     loc_cDCol = ALLTRIM(cursor_4c_Busca.descs)
4524:                 ENDIF
4525:                 IF USED("cursor_4c_Busca")
4526:                     USE IN cursor_4c_Busca
4527:                 ENDIF
4528:                 loc_oBusca.Release()
4529:             ENDIF
4530:         CATCH TO loc_oErro
4531:             MsgErro("Erro na busca de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
4532:         ENDTRY
4533:         loc_oBusca = .NULL.
4534:         IF !EMPTY(loc_cCol)
4535:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4536:             loc_oPg1.txt_4c_Col.Value  = loc_cCol
4537:             loc_oPg1.txt_4c_DCol.Value = loc_cDCol
4538:         ENDIF
4539:     ENDPROC
4540: 
4541:     *--------------------------------------------------------------------------
4542:     * AbrirLookupDadosIfor - Lookup fornecedor (SIGCDCLI: iclis/rclis)
4543:     *--------------------------------------------------------------------------
4544:     PROCEDURE AbrirLookupDadosIfor()
4545:         LOCAL loc_oBusca, loc_cIfor, loc_cDfor, loc_oPg1
4546:         loc_oBusca = .NULL.
4547:         loc_cIfor  = ""
4548:         loc_cDfor  = ""
4549:         TRY
4550:             IF USED("cursor_4c_Busca")
4551:                 USE IN cursor_4c_Busca
4552:             ENDIF
4553:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4554:                 SQLEXEC(gnConnHandle, "SELECT IClis AS iclis, RClis AS rclis FROM SIGCDCLI ORDER BY IClis", "cursor_4c_Busca")
4555:             ENDIF
4556:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4557:             IF !ISNULL(loc_oBusca)
4558:                 loc_oBusca.this_cTabela        = "SIGCDCLI"
4559:                 loc_oBusca.this_cCampoChave    = "iclis"
4560:                 loc_oBusca.this_cCampoBusca    = "iclis"
4561:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4562:                 loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
4563:                 loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
4564:                 loc_oBusca.Caption = "Buscar Fornecedor"
4565:                 loc_oBusca.Show()
4566:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4567:                     loc_cIfor = ALLTRIM(cursor_4c_Busca.iclis)
4568:                     loc_cDfor = ALLTRIM(cursor_4c_Busca.rclis)
4569:                 ENDIF
4570:                 IF USED("cursor_4c_Busca")
4571:                     USE IN cursor_4c_Busca
4572:                 ENDIF
4573:                 loc_oBusca.Release()
4574:             ENDIF
4575:         CATCH TO loc_oErro
4576:             MsgErro("Erro na busca de fornecedor:" + CHR(13) + loc_oErro.Message, "Erro")
4577:         ENDTRY
4578:         loc_oBusca = .NULL.
4579:         IF !EMPTY(loc_cIfor)
4580:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4581:             loc_oPg1.txt_4c_Ifor.Value = loc_cIfor
4582:             loc_oPg1.txt_4c_Dfor.Value = loc_cDfor
4583:         ENDIF
4584:     ENDPROC
4585: 
4586:     *--------------------------------------------------------------------------
4587:     * AbrirLookupDadosCor - Lookup cor (SigCdCor: cods/descs)
4588:     *--------------------------------------------------------------------------
4589:     PROCEDURE AbrirLookupDadosCor()
4590:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4591:         loc_oBusca = .NULL.
4592:         loc_cCod   = ""
4593:         TRY
4594:             IF USED("cursor_4c_Busca")
4595:                 USE IN cursor_4c_Busca
4596:             ENDIF
4597:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4598:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdCor ORDER BY Cods", "cursor_4c_Busca")
4599:             ENDIF
4600:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4601:             IF !ISNULL(loc_oBusca)
4602:                 loc_oBusca.this_cTabela        = "SigCdCor"
4603:                 loc_oBusca.this_cCampoChave    = "cods"
4604:                 loc_oBusca.this_cCampoBusca    = "cods"
4605:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4606:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
4607:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4608:                 loc_oBusca.Caption = "Buscar Cor"
4609:                 loc_oBusca.Show()
4610:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4611:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4612:                 ENDIF
4613:                 IF USED("cursor_4c_Busca")
4614:                     USE IN cursor_4c_Busca
4615:                 ENDIF
4616:                 loc_oBusca.Release()
4617:             ENDIF
4618:         CATCH TO loc_oErro
4619:             MsgErro("Erro na busca de cor:" + CHR(13) + loc_oErro.Message, "Erro")
4620:         ENDTRY
4621:         loc_oBusca = .NULL.
4622:         IF !EMPTY(loc_cCod)
4623:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4624:             loc_oPg1.txt_4c_Cor.Value = loc_cCod
4625:         ENDIF
4626:     ENDPROC
4627: 
4628:     *--------------------------------------------------------------------------
4629:     * AbrirLookupDadosTam - Lookup tamanho (SigCdTam: cods/descs)
4630:     *--------------------------------------------------------------------------
4631:     PROCEDURE AbrirLookupDadosTam()
4632:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4633:         loc_oBusca = .NULL.
4634:         loc_cCod   = ""
4635:         TRY
4636:             IF USED("cursor_4c_Busca")
4637:                 USE IN cursor_4c_Busca
4638:             ENDIF
4639:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4640:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdTam ORDER BY Cods", "cursor_4c_Busca")
4641:             ENDIF
4642:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4643:             IF !ISNULL(loc_oBusca)
4644:                 loc_oBusca.this_cTabela        = "SigCdTam"
4645:                 loc_oBusca.this_cCampoChave    = "cods"
4646:                 loc_oBusca.this_cCampoBusca    = "cods"
4647:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4648:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
4649:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4650:                 loc_oBusca.Caption = "Buscar Tamanho"
4651:                 loc_oBusca.Show()
4652:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4653:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4654:                 ENDIF
4655:                 IF USED("cursor_4c_Busca")
4656:                     USE IN cursor_4c_Busca
4657:                 ENDIF
4658:                 loc_oBusca.Release()
4659:             ENDIF
4660:         CATCH TO loc_oErro
4661:             MsgErro("Erro na busca de tamanho:" + CHR(13) + loc_oErro.Message, "Erro")
4662:         ENDTRY
4663:         loc_oBusca = .NULL.
4664:         IF !EMPTY(loc_cCod)
4665:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4666:             loc_oPg1.txt_4c_Tam.Value = loc_cCod
4667:         ENDIF
4668:     ENDPROC
4669: 
4670:     *--------------------------------------------------------------------------
4671:     * AbrirLookupDadosCodFinP - Lookup modelo (sigcdmod: pkchave/descs)
4672:     *--------------------------------------------------------------------------
4673:     PROCEDURE AbrirLookupDadosCodFinP()
4674:         LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
4675:         loc_oBusca = .NULL.
4676:         loc_cCod   = ""
4677:         loc_cDes   = ""
4678:         TRY
4679:             IF USED("cursor_4c_Busca")
4680:                 USE IN cursor_4c_Busca
4681:             ENDIF
4682:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4683:                 SQLEXEC(gnConnHandle, "SELECT pkchave, Descs AS descs FROM sigcdmod ORDER BY pkchave", "cursor_4c_Busca")
4684:             ENDIF
4685:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4686:             IF !ISNULL(loc_oBusca)
4687:                 loc_oBusca.this_cTabela        = "sigcdmod"
4688:                 loc_oBusca.this_cCampoChave    = "pkchave"
4689:                 loc_oBusca.this_cCampoBusca    = "pkchave"
4690:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4691:                 loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
4692:                 loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4693:                 loc_oBusca.Caption = "Buscar Modelo"
4694:                 loc_oBusca.Show()
4695:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4696:                     loc_cCod = ALLTRIM(cursor_4c_Busca.pkchave)
4697:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descs)
4698:                 ENDIF
4699:                 IF USED("cursor_4c_Busca")
4700:                     USE IN cursor_4c_Busca
4701:                 ENDIF
4702:                 loc_oBusca.Release()
4703:             ENDIF
4704:         CATCH TO loc_oErro
4705:             MsgErro("Erro na busca de modelo:" + CHR(13) + loc_oErro.Message, "Erro")
4706:         ENDTRY
4707:         loc_oBusca = .NULL.
4708:         IF !EMPTY(loc_cCod)
4709:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4710:             loc_oPg1.txt_4c_CodFinP.Value  = loc_cCod
4711:             loc_oPg1.txt_4c_DesFinP.Value  = loc_cDes
4712:         ENDIF
4713:     ENDPROC
4714: 
4715:     *--------------------------------------------------------------------------
4716:     * AbrirLookupDadosCodacb - Lookup acabamento (SigCdAca: cods/descrs)
4717:     *--------------------------------------------------------------------------
4718:     PROCEDURE AbrirLookupDadosCodacb()
4719:         LOCAL loc_oBusca, loc_cCod, loc_cDes, loc_oPg1
4720:         loc_oBusca = .NULL.
4721:         loc_cCod   = ""
4722:         loc_cDes   = ""
4723:         TRY
4724:             IF USED("cursor_4c_Busca")
4725:                 USE IN cursor_4c_Busca
4726:             ENDIF
4727:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4728:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descrs AS descrs FROM SigCdAca ORDER BY Cods", "cursor_4c_Busca")
4729:             ENDIF
4730:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4731:             IF !ISNULL(loc_oBusca)
4732:                 loc_oBusca.this_cTabela        = "SigCdAca"
4733:                 loc_oBusca.this_cCampoChave    = "cods"
4734:                 loc_oBusca.this_cCampoBusca    = "cods"
4735:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4736:                 loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
4737:                 loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4738:                 loc_oBusca.Caption = "Buscar Acabamento"
4739:                 loc_oBusca.Show()
4740:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4741:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4742:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descrs)
4743:                 ENDIF
4744:                 IF USED("cursor_4c_Busca")
4745:                     USE IN cursor_4c_Busca
4746:                 ENDIF
4747:                 loc_oBusca.Release()
4748:             ENDIF
4749:         CATCH TO loc_oErro
4750:             MsgErro("Erro na busca de acabamento:" + CHR(13) + loc_oErro.Message, "Erro")
4751:         ENDTRY
4752:         loc_oBusca = .NULL.
4753:         IF !EMPTY(loc_cCod)
4754:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4755:             loc_oPg1.txt_4c_Codacb.Value = loc_cCod
4756:             loc_oPg1.txt_4c_Dacb.Value   = loc_cDes
4757:         ENDIF
4758:     ENDPROC
4759: 
4760:     *--------------------------------------------------------------------------
4761:     * AbrirLookupDadosCProEq - Lookup produto equivalente (SigCdPro: cpros/dpros)
4762:     *--------------------------------------------------------------------------
4763:     PROCEDURE AbrirLookupDadosCProEq()
4764:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4765:         loc_oBusca = .NULL.
4766:         loc_cCod   = ""
4767:         TRY
4768:             IF USED("cursor_4c_Busca")
4769:                 USE IN cursor_4c_Busca
4770:             ENDIF
4771:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4772:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
4773:             ENDIF
4774:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4775:             IF !ISNULL(loc_oBusca)
4776:                 loc_oBusca.this_cTabela        = "SigCdPro"
4777:                 loc_oBusca.this_cCampoChave    = "cpros"
4778:                 loc_oBusca.this_cCampoBusca    = "cpros"
4779:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4780:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
4781:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4782:                 loc_oBusca.Caption = "Buscar Produto Equivalente"
4783:                 loc_oBusca.Show()
4784:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4785:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
4786:                 ENDIF
4787:                 IF USED("cursor_4c_Busca")
4788:                     USE IN cursor_4c_Busca
4789:                 ENDIF
4790:                 loc_oBusca.Release()
4791:             ENDIF
4792:         CATCH TO loc_oErro
4793:             MsgErro("Erro na busca de produto equivalente:" + CHR(13) + loc_oErro.Message, "Erro")
4794:         ENDTRY
4795:         loc_oBusca = .NULL.
4796:         IF !EMPTY(loc_cCod)
4797:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4798:             loc_oPg1.txt_4c_CProEq.Value = loc_cCod
4799:         ENDIF
4800:     ENDPROC
4801: 
4802:     *--------------------------------------------------------------------------
4803:     * AbrirLookupDadosClass - Lookup classificacao (SigCdCls: Cods/Descs)
4804:     *--------------------------------------------------------------------------
4805:     PROCEDURE AbrirLookupDadosClass()
4806:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4807:         loc_oBusca = .NULL.
4808:         loc_cCod   = ""
4809:         loc_cDesc  = ""
4810:         TRY
4811:             IF USED("cursor_4c_Busca")
4812:                 USE IN cursor_4c_Busca
4813:             ENDIF
4814:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4815:                 SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods", "cursor_4c_Busca")
4816:             ENDIF
4817:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4818:             IF !ISNULL(loc_oBusca)
4819:                 loc_oBusca.this_cTabela        = "SigCdCls"
4820:                 loc_oBusca.this_cCampoChave    = "Cods"
4821:                 loc_oBusca.this_cCampoBusca    = "Cods"
4822:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4823:                 loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
4824:                 loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4825:                 loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
4826:                 loc_oBusca.Show()
4827:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4828:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.Cods)
4829:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.Descs)
4830:                 ENDIF
4831:                 IF USED("cursor_4c_Busca")
4832:                     USE IN cursor_4c_Busca
4833:                 ENDIF
4834:                 loc_oBusca.Release()
4835:             ENDIF
4836:         CATCH TO loc_oErro
4837:             MsgErro("Erro na busca de classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
4838:         ENDTRY
4839:         loc_oBusca = .NULL.
4840:         IF !EMPTY(loc_cCod)
4841:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4842:             loc_oPg1.txt_4c_Class.Value  = loc_cCod
4843:             loc_oPg1.txt_4c_DClass.Value = loc_cDesc
4844:         ENDIF
4845:     ENDPROC
4846: 
4847:     *--------------------------------------------------------------------------
4848:     * AbrirLookupDadosLocal - Lookup local de estoque (SigPrLcl: Codigos/Descricaos)
4849:     *--------------------------------------------------------------------------
4850:     PROCEDURE AbrirLookupDadosLocal()
4851:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4852:         loc_oBusca = .NULL.
4853:         loc_cCod   = ""
4854:         TRY
4855:             IF USED("cursor_4c_Busca")
4856:                 USE IN cursor_4c_Busca
4857:             ENDIF
4858:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4859:                 SQLEXEC(gnConnHandle, "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos", "cursor_4c_Busca")
4860:             ENDIF
4861:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4862:             IF !ISNULL(loc_oBusca)
4863:                 loc_oBusca.this_cTabela        = "SigPrLcl"
4864:                 loc_oBusca.this_cCampoChave    = "Codigos"
4865:                 loc_oBusca.this_cCampoBusca    = "Codigos"
4866:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4867:                 loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
4868:                 loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4869:                 loc_oBusca.Caption = "Buscar Local de Estoque"
4870:                 loc_oBusca.Show()
4871:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4872:                     loc_cCod = ALLTRIM(cursor_4c_Busca.Codigos)
4873:                 ENDIF
4874:                 IF USED("cursor_4c_Busca")
4875:                     USE IN cursor_4c_Busca
4876:                 ENDIF
4877:                 loc_oBusca.Release()
4878:             ENDIF
4879:         CATCH TO loc_oErro
4880:             MsgErro("Erro na busca de local de estoque:" + CHR(13) + loc_oErro.Message, "Erro")
4881:         ENDTRY
4882:         loc_oBusca = .NULL.
4883:         IF !EMPTY(loc_cCod)
4884:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4885:             loc_oPg1.txt_4c_Local.Value = loc_cCod
4886:         ENDIF
4887:     ENDPROC
4888: 
4889:     *--------------------------------------------------------------------------
4890:     * AbrirLookupDadosCuni - Lookup unidade (SigCdUni: CUnis/DUnis)
4891:     *--------------------------------------------------------------------------
4892:     PROCEDURE AbrirLookupDadosCuni()
4893:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4894:         loc_oBusca = .NULL.
4895:         loc_cCod   = ""
4896:         loc_cDesc  = ""
4897:         TRY
4898:             IF USED("cursor_4c_Busca")
4899:                 USE IN cursor_4c_Busca
4900:             ENDIF
4901:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4902:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4903:             ENDIF
4904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4905:             IF !ISNULL(loc_oBusca)
4906:                 loc_oBusca.this_cTabela        = "SigCdUni"
4907:                 loc_oBusca.this_cCampoChave    = "CUnis"
4908:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4909:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4910:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4911:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4912:                 loc_oBusca.Caption = "Buscar Unidade"
4913:                 loc_oBusca.Show()
4914:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4915:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4916:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4917:                 ENDIF
4918:                 IF USED("cursor_4c_Busca")
4919:                     USE IN cursor_4c_Busca
4920:                 ENDIF
4921:                 loc_oBusca.Release()
4922:             ENDIF
4923:         CATCH TO loc_oErro
4924:             MsgErro("Erro na busca de unidade:" + CHR(13) + loc_oErro.Message, "Erro")
4925:         ENDTRY
4926:         loc_oBusca = .NULL.
4927:         IF !EMPTY(loc_cCod)
4928:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4929:             loc_oPg1.txt_4c_Cuni.Value = loc_cCod
4930:             loc_oPg1.txt_4c_Duni.Value = loc_cDesc
4931:         ENDIF
4932:     ENDPROC
4933: 
4934:     *--------------------------------------------------------------------------
4935:     * AbrirLookupDadosCunip - Lookup unidade pauta (SigCdUni: CUnis/DUnis)
4936:     *--------------------------------------------------------------------------
4937:     PROCEDURE AbrirLookupDadosCunip()
4938:         LOCAL loc_oBusca, loc_cCod, loc_cDesc, loc_oPg1
4939:         loc_oBusca = .NULL.
4940:         loc_cCod   = ""
4941:         loc_cDesc  = ""
4942:         TRY
4943:             IF USED("cursor_4c_Busca")
4944:                 USE IN cursor_4c_Busca
4945:             ENDIF
4946:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4947:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4948:             ENDIF
4949:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4950:             IF !ISNULL(loc_oBusca)
4951:                 loc_oBusca.this_cTabela        = "SigCdUni"
4952:                 loc_oBusca.this_cCampoChave    = "CUnis"
4953:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4954:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4955:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4956:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4957:                 loc_oBusca.Caption = "Buscar Unidade de Pauta"
4958:                 loc_oBusca.Show()
4959:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4960:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4961:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4962:                 ENDIF
4963:                 IF USED("cursor_4c_Busca")
4964:                     USE IN cursor_4c_Busca
4965:                 ENDIF
4966:                 loc_oBusca.Release()
4967:             ENDIF
4968:         CATCH TO loc_oErro
4969:             MsgErro("Erro na busca de unidade de pauta:" + CHR(13) + loc_oErro.Message, "Erro")
4970:         ENDTRY
4971:         loc_oBusca = .NULL.
4972:         IF !EMPTY(loc_cCod)
4973:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4974:             loc_oPg1.txt_4c_Cunip.Value = loc_cCod
4975:             loc_oPg1.txt_4c_Dunip.Value = loc_cDesc
4976:         ENDIF
4977:     ENDPROC
4978: 
4979:     *--------------------------------------------------------------------------
4980:     * AbrirLookupDadosMctotal - Lookup moeda custo (SigCdMoe: CMoes/DMoes)
4981:     *--------------------------------------------------------------------------
4982:     PROCEDURE AbrirLookupDadosMctotal()
4983:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
4984:         loc_oBusca = .NULL.
4985:         loc_cCod   = ""
4986:         TRY
4987:             IF USED("cursor_4c_Busca")
4988:                 USE IN cursor_4c_Busca
4989:             ENDIF
4990:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4991:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
4992:             ENDIF
4993:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4994:             IF !ISNULL(loc_oBusca)
4995:                 loc_oBusca.this_cTabela        = "SigCdMoe"
4996:                 loc_oBusca.this_cCampoChave    = "CMoes"
4997:                 loc_oBusca.this_cCampoBusca    = "CMoes"
4998:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4999:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5000:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5001:                 loc_oBusca.Caption = "Buscar Moeda (Custo)"
5002:                 loc_oBusca.Show()
5003:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5004:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5005:                 ENDIF
5006:                 IF USED("cursor_4c_Busca")
5007:                     USE IN cursor_4c_Busca
5008:                 ENDIF
5009:                 loc_oBusca.Release()
5010:             ENDIF
5011:         CATCH TO loc_oErro
5012:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5013:         ENDTRY
5014:         loc_oBusca = .NULL.
5015:         IF !EMPTY(loc_cCod)
5016:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5017:             loc_oPg1.txt_4c_Mctotal.Value = loc_cCod
5018:         ENDIF
5019:     ENDPROC
5020: 
5021:     *--------------------------------------------------------------------------
5022:     * AbrirLookupDadosMpvenda - Lookup moeda preco venda (SigCdMoe: CMoes/DMoes)
5023:     *--------------------------------------------------------------------------
5024:     PROCEDURE AbrirLookupDadosMpvenda()
5025:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
5026:         loc_oBusca = .NULL.
5027:         loc_cCod   = ""
5028:         TRY
5029:             IF USED("cursor_4c_Busca")
5030:                 USE IN cursor_4c_Busca
5031:             ENDIF
5032:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5033:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5034:             ENDIF
5035:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5036:             IF !ISNULL(loc_oBusca)
5037:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5038:                 loc_oBusca.this_cCampoChave    = "CMoes"
5039:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5040:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5041:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5042:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5043:                 loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
5044:                 loc_oBusca.Show()
5045:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5046:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5047:                 ENDIF
5048:                 IF USED("cursor_4c_Busca")
5049:                     USE IN cursor_4c_Busca
5050:                 ENDIF
5051:                 loc_oBusca.Release()
5052:             ENDIF
5053:         CATCH TO loc_oErro
5054:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5055:         ENDTRY
5056:         loc_oBusca = .NULL.
5057:         IF !EMPTY(loc_cCod)
5058:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5059:             loc_oPg1.txt_4c_Mpvenda.Value = loc_cCod
5060:         ENDIF
5061:     ENDPROC
5062: 
5063:     *--------------------------------------------------------------------------
5064:     * AbrirLookupDadosMfvenda - Lookup moeda fator venda (SigCdMoe: CMoes/DMoes)
5065:     *--------------------------------------------------------------------------
5066:     PROCEDURE AbrirLookupDadosMfvenda()
5067:         LOCAL loc_oBusca, loc_cCod, loc_oPg1
5068:         loc_oBusca = .NULL.
5069:         loc_cCod   = ""
5070:         TRY
5071:             IF USED("cursor_4c_Busca")
5072:                 USE IN cursor_4c_Busca
5073:             ENDIF
5074:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5075:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5076:             ENDIF
5077:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5078:             IF !ISNULL(loc_oBusca)
5079:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5080:                 loc_oBusca.this_cCampoChave    = "CMoes"
5081:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5082:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5083:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5084:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5085:                 loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
5086:                 loc_oBusca.Show()
5087:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5088:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5089:                 ENDIF
5090:                 IF USED("cursor_4c_Busca")
5091:                     USE IN cursor_4c_Busca
5092:                 ENDIF
5093:                 loc_oBusca.Release()
5094:             ENDIF
5095:         CATCH TO loc_oErro
5096:             MsgErro("Erro na busca de moeda:" + CHR(13) + loc_oErro.Message, "Erro")
5097:         ENDTRY
5098:         loc_oBusca = .NULL.
5099:         IF !EMPTY(loc_cCod)
5100:             loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5101:             loc_oPg1.txt_4c_Mfvenda.Value = loc_cCod
5102:         ENDIF
5103:     ENDPROC
5104: 
5105:     *==========================================================================
5106:     *-- AUXILIAR - Carrega descricoes lookup ao abrir registro
5107:     *==========================================================================
5108: 
5109:     *--------------------------------------------------------------------------
5110:     * CarregarDescricoesForm - Carrega descricoes dos campos lookup na pagina Dados
5111:     * Chamado por BOParaForm quando gnConnHandle esta disponivel
5112:     *--------------------------------------------------------------------------
5113:     PROTECTED PROCEDURE CarregarDescricoesForm(par_oPg1)
5114:         LOCAL loc_cSQL, loc_nResult, loc_cCgru, loc_cLin, loc_cCol, loc_cIfor
5115:         LOCAL loc_cCodFinP, loc_cCodacb
5116: 
5117:         *-- Grupo
5118:         loc_cCgru = ALLTRIM(par_oPg1.txt_4c_Cgru.Value)
5119:         IF !EMPTY(loc_cCgru)
5120:             loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5121:                           "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5122:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBof")
5123:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruBof") > 0
5124:                 par_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruBof.DGrus)
5125:             ENDIF
5126:             IF USED("cursor_4c_GruBof")
5127:                 USE IN cursor_4c_GruBof
5128:             ENDIF
5129:         ENDIF
5130: 
5131:         *-- Linha
5132:         loc_cLin = ALLTRIM(par_oPg1.txt_4c_Lin.Value)
5133:         IF !EMPTY(loc_cLin)
5134:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
5135:                           "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
5136:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinBof")
5137:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinBof") > 0
5138:                 par_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinBof.Descs)
5139:             ENDIF
5140:             IF USED("cursor_4c_LinBof")
5141:                 USE IN cursor_4c_LinBof
5142:             ENDIF
5143:         ENDIF
5144: 
5145:         *-- Colecao/Grupo de Venda
5146:         loc_cCol = ALLTRIM(par_oPg1.txt_4c_Col.Value)
5147:         IF !EMPTY(loc_cCol)
5148:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
5149:                           "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
5150:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColBof")
5151:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColBof") > 0
5152:                 par_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColBof.Descs)
5153:             ENDIF

*-- Linhas 5246 a 5663:
5246:     *--------------------------------------------------------------------------
5247:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes por modo atual
5248:     *--------------------------------------------------------------------------
5249:     PROTECTED PROCEDURE AjustarBotoesPorModo()
5250:         LOCAL loc_oPg1, loc_oPg2, loc_lEditing
5251:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1
5252:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
5253:         loc_lEditing = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
5254: 
5255:         *-- Botoes CRUD habilitados apenas em modo LISTA
5256:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
5257:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
5258:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = (THIS.this_cModoAtual = "LISTA")
5259:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = (THIS.this_cModoAtual = "LISTA")
5260:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = (THIS.this_cModoAtual = "LISTA")
5261:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = (THIS.this_cModoAtual = "LISTA")
5262:         ENDIF
5263: 
5264:         *-- Botoes Confirmar/Cancelar
5265:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
5266:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
5267:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
5268:         ENDIF
5269:     ENDPROC
5270: 
5271:     *--------------------------------------------------------------------------
5272:     * ObterCodigoSelecionado - Retorna codigo do registro selecionado no grid
5273:     *--------------------------------------------------------------------------
5274:     PROTECTED PROCEDURE ObterCodigoSelecionado()
5275:         IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
5276:             SELECT cursor_4c_Lista
5277:             RETURN ALLTRIM(cursor_4c_Lista.cpros)
5278:         ENDIF
5279:         RETURN ""
5280:     ENDPROC
5281: 
5282:     *==========================================================================
5283:     *-- HANDLERS DE BOTOES - Page1 (Lista)
5284:     *==========================================================================
5285: 
5286:     *--------------------------------------------------------------------------
5287:     * BtnIncluirClick - Modo INCLUIR: prepara formulario para novo registro
5288:     *--------------------------------------------------------------------------
5289:     PROCEDURE BtnIncluirClick()
5290:         THIS.this_cModoAtual   = "INCLUIR"
5291:         THIS.this_lNovoRegistro = .T.
5292:         THIS.this_oBusinessObject.NovoRegistro()
5293:         THIS.LimparCampos()
5294:         THIS.HabilitarCampos(.T., .T.)
5295:         THIS.AlternarPagina(2)
5296:     ENDPROC
5297: 
5298:     *--------------------------------------------------------------------------
5299:     * BtnVisualizarClick - Modo VISUALIZAR: abre registro selecionado somente leitura
5300:     *--------------------------------------------------------------------------
5301:     PROCEDURE BtnVisualizarClick()
5302:         LOCAL loc_cCodigo
5303:         loc_cCodigo = THIS.ObterCodigoSelecionado()
5304:         IF EMPTY(loc_cCodigo)
5305:             MsgAviso("Selecione um produto na lista.", "Aviso")
5306:             RETURN
5307:         ENDIF
5308:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5309:             THIS.this_cModoAtual   = "VISUALIZAR"
5310:             THIS.this_lNovoRegistro = .F.
5311:             THIS.BOParaForm()
5312:             THIS.HabilitarCampos(.F., .F.)
5313:             THIS.AlternarPagina(2)
5314:         ELSE
5315:             MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
5316:         ENDIF
5317:     ENDPROC
5318: 
5319:     *--------------------------------------------------------------------------
5320:     * BtnAlterarClick - Modo ALTERAR: abre registro para edicao
5321:     *--------------------------------------------------------------------------
5322:     PROCEDURE BtnAlterarClick()
5323:         LOCAL loc_cCodigo
5324:         loc_cCodigo = THIS.ObterCodigoSelecionado()
5325:         IF EMPTY(loc_cCodigo)
5326:             MsgAviso("Selecione um produto na lista.", "Aviso")
5327:             RETURN
5328:         ENDIF
5329:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5330:             THIS.this_cModoAtual   = "ALTERAR"
5331:             THIS.this_lNovoRegistro = .F.
5332:             THIS.this_oBusinessObject.EditarRegistro()
5333:             THIS.BOParaForm()
5334:             THIS.HabilitarCampos(.T., .F.)
5335:             THIS.AlternarPagina(2)
5336:         ELSE
5337:             MsgErro("Produto n" + CHR(227) + "o encontrado.", "Erro")
5338:         ENDIF
5339:     ENDPROC
5340: 
5341:     *--------------------------------------------------------------------------
5342:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
5343:     *--------------------------------------------------------------------------
5344:     PROCEDURE BtnExcluirClick()
5345:         LOCAL loc_cCodigo, loc_lConfirmado
5346:         loc_cCodigo     = THIS.ObterCodigoSelecionado()
5347:         loc_lConfirmado = .F.
5348:         IF EMPTY(loc_cCodigo)
5349:             MsgAviso("Selecione um produto na lista.", "Aviso")
5350:             RETURN
5351:         ENDIF
5352:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + ALLTRIM(loc_cCodigo) + "?", "Confirmar Exclus" + CHR(227) + "o")
5353:         IF loc_lConfirmado
5354:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5355:                 IF !THIS.this_oBusinessObject.Excluir()
5356:                     MsgErro("Erro ao excluir produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
5357:                 ELSE
5358:                     THIS.CarregarLista()
5359:                 ENDIF
5360:             ENDIF
5361:         ENDIF
5362:     ENDPROC
5363: 
5364:     *--------------------------------------------------------------------------
5365:     * BtnBuscarClick - Abre busca auxiliar de produtos
5366:     *--------------------------------------------------------------------------
5367:     PROCEDURE BtnBuscarClick()
5368:         LOCAL loc_oBusca, loc_cCodigo
5369:         loc_oBusca  = .NULL.
5370:         loc_cCodigo = ""
5371:         TRY
5372:             IF USED("cursor_4c_Busca")
5373:                 USE IN cursor_4c_Busca
5374:             ENDIF
5375:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5376:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros, CGrus AS cgrus FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
5377:             ENDIF
5378:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5379:             IF !ISNULL(loc_oBusca)
5380:                 loc_oBusca.this_cTabela        = "SigCdPro"
5381:                 loc_oBusca.this_cCampoChave    = "cpros"
5382:                 loc_oBusca.this_cCampoBusca    = "cpros"
5383:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5384:                 loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
5385:                 loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5386:                 loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
5387:                 loc_oBusca.Caption = "Buscar Produto"
5388:                 loc_oBusca.Show()
5389:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5390:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
5391:                 ENDIF
5392:                 IF USED("cursor_4c_Busca")
5393:                     USE IN cursor_4c_Busca
5394:                 ENDIF
5395:                 loc_oBusca.Release()
5396:             ENDIF
5397:         CATCH TO loc_oErro
5398:             MsgErro("Erro na busca de produtos:" + CHR(13) + loc_oErro.Message, "Erro")
5399:         ENDTRY
5400:         loc_oBusca = .NULL.
5401:         IF !EMPTY(loc_cCodigo)
5402:             THIS.CarregarLista()
5403:         ENDIF
5404:     ENDPROC
5405: 
5406:     *--------------------------------------------------------------------------
5407:     * BtnEncerrarClick - Encerra o formulario
5408:     *--------------------------------------------------------------------------
5409:     PROCEDURE BtnEncerrarClick()
5410:         THIS.Release()
5411:     ENDPROC
5412: 
5413:     *==========================================================================
5414:     *-- HANDLERS DE BOTOES - Page2 (Dados)
5415:     *==========================================================================
5416: 
5417:     *--------------------------------------------------------------------------
5418:     * BtnConfirmarClick - Salva registro (Inserir ou Atualizar)
5419:     * FASE 5: Implementar FormParaBO() + chamada ao BO
5420:     *--------------------------------------------------------------------------
5421:     PROCEDURE BtnConfirmarClick()
5422:         LOCAL loc_lSucesso
5423:         loc_lSucesso = .F.
5424:         TRY
5425:             THIS.FormParaBO()
5426:             IF THIS.this_lNovoRegistro
5427:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
5428:             ELSE
5429:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
5430:             ENDIF
5431:             IF loc_lSucesso
5432:                 THIS.this_cModoAtual = "LISTA"
5433:                 THIS.AlternarPagina(1)
5434:                 THIS.CarregarLista()
5435:             ELSE
5436:                 MsgErro("Erro ao salvar produto: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
5437:             ENDIF
5438:         CATCH TO loc_oErro
5439:             MsgErro("Erro ao confirmar produto:" + CHR(13) + loc_oErro.Message, "Erro")
5440:         ENDTRY
5441:     ENDPROC
5442: 
5443:     *--------------------------------------------------------------------------
5444:     * BtnCancelarClick - Cancela edicao e retorna para Lista
5445:     *--------------------------------------------------------------------------
5446:     PROCEDURE BtnCancelarClick()
5447:         THIS.this_cModoAtual = "LISTA"
5448:         THIS.AlternarPagina(1)
5449:     ENDPROC
5450: 
5451:     *--------------------------------------------------------------------------
5452:     * GrdListaDblClick - Duplo clique no grid abre registro para visualizacao
5453:     *--------------------------------------------------------------------------
5454:     PROCEDURE GrdListaDblClick()
5455:         THIS.BtnVisualizarClick()
5456:     ENDPROC
5457: 
5458:     *--------------------------------------------------------------------------
5459:     * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
5460:     * par_nPagina: 1=Lista, 2=Dados
5461:     *--------------------------------------------------------------------------
5462:     PROCEDURE AlternarPagina(par_nPagina)
5463:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
5464:         IF par_nPagina = 2
5465:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.ActivePage = 1
5466:             THIS.pgf_4c_Paginas.Page2.obj_4c_NavegacaoDados.Value      = 1
5467:         ENDIF
5468:         THIS.AjustarBotoesPorModo()
5469:     ENDPROC
5470: 
5471:     *--------------------------------------------------------------------------
5472:     * FiltroGrupoKeyPress - Handler KeyPress no txt_4c_Cgru
5473:     * ENTER(13) ou TAB(9): valida e recarrega lista
5474:     * F4(115): abre lookup de grupos
5475:     *--------------------------------------------------------------------------
5476:     PROCEDURE FiltroGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5477:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
5478:             THIS.ValidarGrupoFiltro()
5479:         ENDIF
5480:         IF par_nKeyCode = 115
5481:             THIS.AbrirLookupGrupo()
5482:         ENDIF
5483:     ENDPROC
5484: 
5485:     *--------------------------------------------------------------------------
5486:     * FiltroSituaChange - Handler InteractiveChange no obj_4c_Situa
5487:     * Recarrega lista quando usuario altera filtro de situacao
5488:     *--------------------------------------------------------------------------
5489:     PROCEDURE FiltroSituaChange()
5490:         THIS.CarregarLista()
5491:     ENDPROC
5492: 
5493:     *--------------------------------------------------------------------------
5494:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
5495:     * Chama SigCdGrp (cgrus, dgrus)
5496:     *--------------------------------------------------------------------------
5497:     PROCEDURE AbrirLookupGrupo()
5498:         LOCAL loc_oBusca, loc_cCgru, loc_cDgru, loc_oPg1
5499:         loc_oBusca = .NULL.
5500:         loc_cCgru  = ""
5501:         loc_cDgru  = ""
5502:         TRY
5503:             IF USED("cursor_4c_Busca")
5504:                 USE IN cursor_4c_Busca
5505:             ENDIF
5506:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5507:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
5508:             ENDIF
5509:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5510:             IF !ISNULL(loc_oBusca)
5511:                 loc_oBusca.this_cTabela        = "SigCdGrp"
5512:                 loc_oBusca.this_cCampoChave    = "cgrus"
5513:                 loc_oBusca.this_cCampoBusca    = "cgrus"
5514:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5515:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
5516:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5517:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
5518:                 loc_oBusca.Show()
5519:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5520:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
5521:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
5522:                 ENDIF
5523:                 IF USED("cursor_4c_Busca")
5524:                     USE IN cursor_4c_Busca
5525:                 ENDIF
5526:                 loc_oBusca.Release()
5527:             ENDIF
5528:         CATCH TO loc_oErro
5529:             MsgErro("Erro na busca de grupo:" + CHR(13) + loc_oErro.Message, "Erro")
5530:         ENDTRY
5531:         loc_oBusca = .NULL.
5532:         IF !EMPTY(loc_cCgru)
5533:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
5534:             loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = loc_cCgru
5535:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = loc_cDgru
5536:             THIS.CarregarLista()
5537:         ENDIF
5538:     ENDPROC
5539: 
5540:     *--------------------------------------------------------------------------
5541:     * ValidarGrupoFiltro - Valida codigo de grupo e carrega descricao + lista
5542:     * Chamado em ENTER/TAB no txt_4c_Cgru
5543:     *--------------------------------------------------------------------------
5544:     PROTECTED PROCEDURE ValidarGrupoFiltro()
5545:         LOCAL loc_oPg1, loc_cCgru, loc_cSQL, loc_nResult
5546:         loc_oPg1  = THIS.pgf_4c_Paginas.Page1
5547:         loc_cCgru = ALLTRIM(loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value)
5548:         IF EMPTY(loc_cCgru)
5549:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5550:         ELSE
5551:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5552:                 loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5553:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5554:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFiltro")
5555:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruFiltro") > 0
5556:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruFiltro.DGrus)
5557:                 ELSE
5558:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5559:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
5560:                 ENDIF
5561:                 IF USED("cursor_4c_GruFiltro")
5562:                     USE IN cursor_4c_GruFiltro
5563:                 ENDIF
5564:             ENDIF
5565:         ENDIF
5566:         THIS.CarregarLista()
5567:     ENDPROC
5568: 
5569:     *==========================================================================
5570:     *-- METODOS AUXILIARES
5571:     *==========================================================================
5572: 
5573:     *--------------------------------------------------------------------------
5574:     * FormatarGridLista - Formata visual do grid de lista
5575:     *--------------------------------------------------------------------------
5576:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
5577:         WITH par_oGrid
5578:             IF .ColumnCount > 0
5579:                 .FontName = "Tahoma"
5580:                 .FontSize = 8
5581:             ENDIF
5582:         ENDWITH
5583:     ENDPROC
5584: 
5585:     *--------------------------------------------------------------------------
5586:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
5587:     * Filtro por nome evita tornar visiveis containers flutuantes (Visible=.F.)
5588:     *--------------------------------------------------------------------------
5589:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
5590:         LOCAL loc_nI, loc_oObjeto
5591: 
5592:         FOR loc_nI = 1 TO par_oContainer.ControlCount
5593:             loc_oObjeto = par_oContainer.Controls(loc_nI)
5594: 
5595:             IF VARTYPE(loc_oObjeto) = "O"
5596:                 *-- Nao tornar visiveis containers flutuantes (iniciam com cnt_4c_Float)
5597:                 IF LEFT(LOWER(loc_oObjeto.Name), 13) != "cnt_4c_float_"
5598:                     IF PEMSTATUS(loc_oObjeto, "Visible", 5)
5599:                         loc_oObjeto.Visible = .T.
5600:                     ENDIF
5601:                 ENDIF
5602: 
5603:                 *-- Trata PageFrame - itera Pages
5604:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
5605:                     LOCAL loc_nP
5606:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
5607:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
5608:                     ENDFOR
5609:                 ENDIF
5610: 
5611:                 *-- Trata containers com ControlCount
5612:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
5613:                     THIS.TornarControlesVisiveis(loc_oObjeto)
5614:                 ENDIF
5615:             ENDIF
5616:         ENDFOR
5617:     ENDPROC
5618: 
5619:     *--------------------------------------------------------------------------
5620:     * LimparCampos - Limpa todos os campos do formulario (Page2/pgDados)
5621:     * Chamado ao entrar em modo INCLUIR para garantir campos zerados
5622:     *--------------------------------------------------------------------------
5623:     PROTECTED PROCEDURE LimparCampos()
5624:         LOCAL loc_oPg1
5625:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
5626: 
5627:         TRY
5628:             *-- ROW 1: Produto + Descricao + Status
5629:             loc_oPg1.txt_4c_Cpro.Value          = ""
5630:             loc_oPg1.txt_4c_Dpro.Value          = ""
5631:             loc_oPg1.obj_4c_OpcSituacao.Value   = 1
5632:             loc_oPg1.txt_4c_DtSituas.Value      = DATE()
5633: 
5634:             *-- ROW 2: Descritivo + CProEq + Cbar + LtMinsV
5635:             loc_oPg1.txt_4c_DPro2s.Value        = ""
5636:             loc_oPg1.txt_4c_CProEq.Value        = ""
5637:             loc_oPg1.txt_4c_Cbar.Value          = 0
5638:             loc_oPg1.txt_4c_LtMinsV.Value       = 0
5639: 
5640:             *-- ROW 3: Grupo + Merc + IdeCPros + EAN13 + ProdWeb
5641:             loc_oPg1.txt_4c_Cgru.Value          = ""
5642:             loc_oPg1.txt_4c_Dgru.Value          = ""
5643:             loc_oPg1.txt_4c_Merc.Value          = ""
5644:             loc_oPg1.txt_4c_IdeCPros.Value      = ""
5645:             loc_oPg1.txt_4c_EAN13.Value         = 0
5646:             loc_oPg1.obj_4c_ProdWeb.Value       = 1
5647: 
5648:             *-- ROW 4: Subgrupo + Variacao
5649:             loc_oPg1.txt_4c_CSGru.Value         = ""
5650:             loc_oPg1.txt_4c_DsGru.Value         = ""
5651:             loc_oPg1.obj_4c_Variacao.Value      = 1
5652: 
5653:             *-- ROW 5: Linha + Garantia
5654:             loc_oPg1.txt_4c_Lin.Value           = ""
5655:             loc_oPg1.txt_4c_DLin.Value          = ""
5656:             loc_oPg1.txt_4c_DiasGar.Value       = 0
5657:             loc_oPg1.chk_4c_GarVit.Value        = 0
5658: 
5659:             *-- ROW 6: Colecao/Grupo de Venda + Obs3
5660:             loc_oPg1.txt_4c_Col.Value           = ""
5661:             loc_oPg1.txt_4c_DCol.Value          = ""
5662:             loc_oPg1.txt_4c_Obs3.Value          = ""
5663: 

*-- Linhas 5745 a 5761:
5745:     *--------------------------------------------------------------------------
5746:     * Destroy - Limpeza ao fechar formulario
5747:     *--------------------------------------------------------------------------
5748:     PROCEDURE Destroy()
5749:         IF USED("cursor_4c_Lista")
5750:             USE IN cursor_4c_Lista
5751:         ENDIF
5752:         IF USED("cursor_4c_Dados")
5753:             USE IN cursor_4c_Dados
5754:         ENDIF
5755:         IF !ISNULL(THIS.this_oBusinessObject)
5756:             THIS.this_oBusinessObject = .NULL.
5757:         ENDIF
5758:         DODEFAULT()
5759:     ENDPROC
5760: 
5761: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros (C14)
* Data: 2026-04-09
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros     = ""   && C(14) - Codigo do produto (PK)
    this_cDpros     = ""   && C(65) - Descricao principal
    this_cDpro2s    = ""   && C(45) - Descricao secundaria (descritivo)

    *-- Classificacao/grupo
    this_cCgrus     = ""   && C(3)  - Grupo
    this_cSgrus     = ""   && C(6)  - Subgrupo
    this_cLinhas    = ""   && C(10) - Linha
    this_cColecoes  = ""   && C(10) - Colecao / Grupo de Venda
    this_cMercs     = ""   && C(3)  - Mercado
    this_cIdecpros  = ""   && C(3)  - Identificador
    this_cCclass    = ""   && C(3)  - Classificacao

    *-- Fornecedor
    this_cIfors     = ""   && C(10) - Codigo do fornecedor
    this_cReffs     = ""   && C(40) - Referencia do fornecedor

    *-- Codigos produto
    this_cCodfinp   = ""   && C(3)  - Codigo do modelo (finishing product)
    this_cCodacbs   = ""   && C(3)  - Codigo do acabamento
    this_cCodcors   = ""   && C(4)  - Codigo da cor
    this_cCodtams   = ""   && C(4)  - Codigo do tamanho
    this_cCproeqs   = ""   && C(14) - Produto equivalente

    *-- Status e datas
    this_nSituas    = 1    && N(1)  - Status: 1=Ativo, 2=Inativo
    this_dDatas     = {}   && Date  - Data do status
    this_dDtincs    = {}   && Date  - Data de inclusao (read-only)
    this_cUsuincs   = ""   && C(10) - Usuario de inclusao

    *-- Codigos de barra
    this_nCbars     = 0    && N(14,0) - Codigo de barra
    this_nEan13     = 0    && N(13,0) - EAN13/GTIN

    *-- Quantidades e lotes
    this_nLtminsv   = 0    && N(9,3) - Lote minimo de venda
    this_nQmins     = 0    && N(9,3) - Quantidade minima
    this_nQtped     = 0    && N(9,3) - Quantidade de pedido

    *-- Unidades
    this_cCunis     = ""   && C(3)  - Unidade (1)
    this_cCunips    = ""   && C(3)  - Unidade (2)

    *-- Pesos e dimensoes
    this_nPesobs    = 0    && N(7,3) - Peso bruto
    this_nPesoms    = 0    && N(8,3) - Peso medio/liquido

    *-- Localizacao
    this_cLocals    = ""   && C(10) - Local

    *-- Precos e custos
    this_nPvens     = 0    && N(11,5) - Preco de venda
    this_nFvendas   = 0    && N(7,3)  - Fator de venda
    this_nPcuss     = 0    && N(11,5) - Preco de custo
    this_cMoecs     = ""   && C(3)   - Moeda de custo
    this_cMoepvs    = ""   && C(3)   - Moeda de venda

    *-- Ultima compra
    this_dUltcomps  = {}   && Date  - Data da ultima compra
    this_nVultcomps = 0    && N(11,2) - Valor da ultima compra
    this_cMultcomps = ""   && C(3)   - Moeda da ultima compra
    this_nQultcomp  = 0    && N(9,3) - Qtde da ultima compra

    *-- Dias de garantia
    this_nDiasinas  = 0    && N(5,0) - Dias de garantia/inatividade

    *-- Checkboxes
    this_nConsigs   = 0    && N(1) - Consignado
    this_nFabrproprs= 0    && N(1) - Fabricacao propria
    this_nEncoms    = 0    && N(1) - Encomenda
    this_nChkfunds  = 0    && N(1) - Fundo

    *-- Observacoes
    this_cObspeds   = ""   && C(30) - Observacao 1
    this_cObspes    = ""   && C(30) - Observacao 2
    this_cObsetqs   = ""   && C(10) - Observacao componente

    *-- Memos (text fields)
    this_cDpro3s    = ""   && text  - Descricao completa
    this_cDsccompras= ""   && text  - Descricao compra
    this_cObscompras= ""   && text  - Observacao compra

    *-- Variacao e web
    this_nVarias    = 0    && N(1) - Variacao (0=nenhum, 1=cor-tam)
    this_nWebpros   = 0    && N(1) - Produto web (0=nenhum, 1=sim, 2=nao, 3=destaque)

    *-- Dimensoes
    this_nTamhs     = 0    && N(5,2) - Altura
    this_nTamls     = 0    && N(5,2) - Largura
    this_nTamps     = 0    && N(5,2) - Profundidade
    this_nVolumes   = 0    && N(3,0) - Volumes
    this_nTents     = 0    && N(3,0) - Entradas

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Limpa propriedades para inclusao
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCpros      = ""
        THIS.this_cDpros      = ""
        THIS.this_cDpro2s     = ""
        THIS.this_cCgrus      = ""
        THIS.this_cSgrus      = ""
        THIS.this_cLinhas     = ""
        THIS.this_cColecoes   = ""
        THIS.this_cMercs      = ""
        THIS.this_cIdecpros   = ""
        THIS.this_cCclass     = ""
        THIS.this_cIfors      = ""
        THIS.this_cReffs      = ""
        THIS.this_cCodfinp    = ""
        THIS.this_cCodacbs    = ""
        THIS.this_cCodcors    = ""
        THIS.this_cCodtams    = ""
        THIS.this_cCproeqs    = ""
        THIS.this_nSituas     = 1
        THIS.this_dDatas      = DATE()
        THIS.this_dDtincs     = DATE()
        THIS.this_cUsuincs    = gc_4c_UsuarioLogado
        THIS.this_nCbars      = 0
        THIS.this_nEan13      = 0
        THIS.this_nLtminsv    = 0
        THIS.this_nQmins      = 0
        THIS.this_nQtped      = 0
        THIS.this_cCunis      = ""
        THIS.this_cCunips     = ""
        THIS.this_nPesobs     = 0
        THIS.this_nPesoms     = 0
        THIS.this_cLocals     = ""
        THIS.this_nPvens      = 0
        THIS.this_nFvendas    = 1
        THIS.this_nPcuss      = 0
        THIS.this_cMoecs      = ""
        THIS.this_cMoepvs     = ""
        THIS.this_dUltcomps   = {}
        THIS.this_nVultcomps  = 0
        THIS.this_cMultcomps  = ""
        THIS.this_nQultcomp   = 0
        THIS.this_nDiasinas   = 0
        THIS.this_nConsigs    = 0
        THIS.this_nFabrproprs = 0
        THIS.this_nEncoms     = 0
        THIS.this_nChkfunds   = 0
        THIS.this_cObspeds    = ""
        THIS.this_cObspes     = ""
        THIS.this_cObsetqs    = ""
        THIS.this_cDpro3s     = ""
        THIS.this_cDsccompras = ""
        THIS.this_cObscompras = ""
        THIS.this_nVarias     = 0
        THIS.this_nWebpros    = 0
        THIS.this_nTamhs      = 0
        THIS.this_nTamls      = 0
        THIS.this_nTamps      = 0
        THIS.this_nVolumes    = 0
        THIS.this_nTents      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao (dados ja carregados via CarregarPorCodigo)
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cursor_4c_Dados com registros conforme filtro
    * par_cFiltro: "" = todos | "WHERE ..." = com filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "ISNULL(Datas,GETDATE()) AS datas, " + ;
                    "ISNULL(DtIncs,GETDATE()) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "ISNULL(UltComps,NULL)  AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(DPro3s,'')      AS dpro3s, " + ;
                    "ISNULL(DscCompras,'')  AS dsccompras, " + ;
                    "ISNULL(ObsCompras,'')  AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + par_cFiltro + " ORDER BY CPros"

                IF USED("cursor_4c_Temp_Dados")
                    USE IN cursor_4c_Temp_Dados
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Dados")

                IF loc_nRet > 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SELECT cursor_4c_Temp_Dados
                    IF RECCOUNT() > 0
                        SELECT * FROM cursor_4c_Temp_Dados INTO CURSOR cursor_4c_Dados READWRITE
                        SELECT cursor_4c_Dados
                    ELSE
                        SET NULL ON
                        CREATE CURSOR cursor_4c_Dados ;
                            (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), ;
                             linhas C(10), colecoes C(10), mercs C(3), idecpros C(3), cclass C(3), ;
                             ifors C(10), reffs C(40), codfinp C(3), codacbs C(3), codcors C(4), ;
                             codtams C(4), cproeqs C(14), situas N(1,0), datas D, dtincs D, ;
                             usuincs C(10), cbars N(14,0), ean13 N(13,0), ltminsv N(9,3), ;
                             qmins N(9,3), qtped N(9,3), locals C(10), cunis C(3), cunips C(3), ;
                             pesobs N(7,3), pesoms N(8,3), pvens N(11,5), fvendas N(7,3), ;
                             pcuss N(11,5), moecs C(3), moepvs C(3), ultcomps D, ;
                             vultcomps N(11,2), multcomps C(3), qultcomp N(9,3), ;
                             diasinas N(5,0), consigs N(1,0), fabrproprs N(1,0), ;
                             encoms N(1,0), chkfunds N(1,0), obspeds C(30), obspes C(30), ;
                             obsetqs C(10), dpro3s C(254), dsccompras C(254), obscompras C(254), ;
                             varias N(1,0), webpros N(1,0), tamhs N(5,2), tamls N(5,2), ;
                             tamps N(5,2), volumes N(3,0), tents N(3,0))
                        SET NULL OFF
                    ENDIF
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    AERROR(loc_aErros)
                    THIS.this_cMensagemErro = "Erro SQL ao buscar produtos: " + TRANSFORM(loc_aErros(1,2))
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de um produto pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "CONVERT(date,ISNULL(Datas,GETDATE())) AS datas, " + ;
                    "CONVERT(date,ISNULL(DtIncs,GETDATE())) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "CONVERT(date,ISNULL(UltComps,NULL)) AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(CONVERT(varchar(2000),DPro3s),'')     AS dpro3s, " + ;
                    "ISNULL(CONVERT(varchar(2000),DscCompras),'') AS dsccompras, " + ;
                    "ISNULL(CONVERT(varchar(2000),ObsCompras),'') AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaPro")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_CarregaPro") > 0
                    THIS.CarregarDoCursor("cursor_4c_CarregaPro")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(cpros)
        THIS.this_cDpros      = ALLTRIM(dpros)
        THIS.this_cDpro2s     = ALLTRIM(dpro2s)
        THIS.this_cCgrus      = ALLTRIM(cgrus)
        THIS.this_cSgrus      = ALLTRIM(sgrus)
        THIS.this_cLinhas     = ALLTRIM(linhas)
        THIS.this_cColecoes   = ALLTRIM(colecoes)
        THIS.this_cMercs      = ALLTRIM(mercs)
        THIS.this_cIdecpros   = ALLTRIM(idecpros)
        THIS.this_cCclass     = ALLTRIM(cclass)
        THIS.this_cIfors      = ALLTRIM(ifors)
        THIS.this_cReffs      = ALLTRIM(reffs)
        THIS.this_cCodfinp    = ALLTRIM(codfinp)
        THIS.this_cCodacbs    = ALLTRIM(codacbs)
        THIS.this_cCodcors    = ALLTRIM(codcors)
        THIS.this_cCodtams    = ALLTRIM(codtams)
        THIS.this_cCproeqs    = ALLTRIM(cproeqs)
        THIS.this_nSituas     = NVL(situas, 1)
        THIS.this_dDatas      = IIF(EMPTY(datas), DATE(), datas)
        THIS.this_dDtincs     = IIF(EMPTY(dtincs), DATE(), dtincs)
        THIS.this_cUsuincs    = ALLTRIM(usuincs)
        THIS.this_nCbars      = NVL(cbars, 0)
        THIS.this_nEan13      = NVL(ean13, 0)
        THIS.this_nLtminsv    = NVL(ltminsv, 0)
        THIS.this_nQmins      = NVL(qmins, 0)
        THIS.this_nQtped      = NVL(qtped, 0)
        THIS.this_cLocals     = ALLTRIM(locals)
        THIS.this_cCunis      = ALLTRIM(cunis)
        THIS.this_cCunips     = ALLTRIM(cunips)
        THIS.this_nPesobs     = NVL(pesobs, 0)
        THIS.this_nPesoms     = NVL(pesoms, 0)
        THIS.this_nPvens      = NVL(pvens, 0)
        THIS.this_nFvendas    = NVL(fvendas, 1)
        THIS.this_nPcuss      = NVL(pcuss, 0)
        THIS.this_cMoecs      = ALLTRIM(moecs)
        THIS.this_cMoepvs     = ALLTRIM(moepvs)
        THIS.this_dUltcomps   = IIF(EMPTY(ultcomps), {}, ultcomps)
        THIS.this_nVultcomps  = NVL(vultcomps, 0)
        THIS.this_cMultcomps  = ALLTRIM(multcomps)
        THIS.this_nQultcomp   = NVL(qultcomp, 0)
        THIS.this_nDiasinas   = NVL(diasinas, 0)
        THIS.this_nConsigs    = NVL(consigs, 0)
        THIS.this_nFabrproprs = NVL(fabrproprs, 0)
        THIS.this_nEncoms     = NVL(encoms, 0)
        THIS.this_nChkfunds   = NVL(chkfunds, 0)
        THIS.this_cObspeds    = ALLTRIM(obspeds)
        THIS.this_cObspes     = ALLTRIM(obspes)
        THIS.this_cObsetqs    = ALLTRIM(obsetqs)
        THIS.this_cDpro3s     = ALLTRIM(dpro3s)
        THIS.this_cDsccompras = ALLTRIM(dsccompras)
        THIS.this_cObscompras = ALLTRIM(obscompras)
        THIS.this_nVarias     = NVL(varias, 0)
        THIS.this_nWebpros    = NVL(webpros, 0)
        THIS.this_nTamhs      = NVL(tamhs, 0)
        THIS.this_nTamls      = NVL(tamls, 0)
        THIS.this_nTamps      = NVL(tamps, 0)
        THIS.this_nVolumes    = NVL(volumes, 0)
        THIS.this_nTents      = NVL(tents, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            *-- Verificar codigo duplicado
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                LOCAL loc_nExiste
                loc_nExiste = 0
                SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(THIS.this_cCpros), "cursor_4c_ChkPro")
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nExiste = nExiste
                    USE IN cursor_4c_ChkPro
                ENDIF
                IF loc_nExiste > 0
                    THIS.this_cMensagemErro = "Produto j" + CHR(225) + " existe: " + ALLTRIM(THIS.this_cCpros)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarSQL_INSERT()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao inserir produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarSQL_UPDATE()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao atualizar produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove produto (chamado por Excluir() da BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(THIS.this_cCpros))
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_INSERT - Gera SQL de insercao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_INSERT()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdPro " + ;
            "(CPros, DPros, DPro2s, CGrus, SGrus, Linhas, Colecoes, Mercs, IdeCPros, CClass, " + ;
            " IFors, Reffs, CodFinP, CodAcbs, CodCors, CodTams, CProEqs, Situas, Datas, DtIncs, " + ;
            " UsuIncs, CBars, EAN13, LtMinsV, QMins, QtPed, Locals, CUnis, CUniPs, PesoBS, PesoMs, " + ;
            " PVens, FVendas, PCuss, MoECs, MoePVs, UltComps, VultComps, MultComps, qtdultcomp, " + ;
            " DiasINas, ConSigs, FabrProprs, EnComs, ChkFunds, ObsPeds, ObsPes, " + ;
            " ObsEtqs, DPro3s, DscCompras, ObsCompras, Varias, prodwebs, TamHs, TamLs, TamPs, " + ;
            " Volumes, TEnts) " + ;
            "VALUES (" + ;
            EscaparSQL(THIS.this_cCpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpro2s)                    + ", " + ;
            EscaparSQL(PADR(THIS.this_cCgrus,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cSgrus,6))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cLinhas,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cColecoes,10))         + ", " + ;
            EscaparSQL(PADR(THIS.this_cMercs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cIdecpros,3))          + ", " + ;
            EscaparSQL(PADR(THIS.this_cCclass,3))            + ", " + ;
            EscaparSQL(PADR(THIS.this_cIfors,10))            + ", " + ;
            EscaparSQL(THIS.this_cReffs)                     + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodfinp,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodacbs,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodcors,4))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodtams,4))           + ", " + ;
            EscaparSQL(THIS.this_cCproeqs)                   + ", " + ;
            FormatarNumeroSQL(THIS.this_nSituas)              + ", " + ;
            FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
            FormatarDataSQL(DATE())                           + ", " + ;
            EscaparSQL(gc_4c_UsuarioLogado)                  + ", " + ;
            FormatarNumeroSQL(THIS.this_nCbars)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nEan13)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nLtminsv)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nQmins)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nQtped)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cLocals,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunis,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunips,3))            + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesobs)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPvens)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nFvendas)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nPcuss)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoecs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoepvs,3))            + ", " + ;
            FormatarDataSQL(THIS.this_dUltcomps)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nVultcomps)           + ", " + ;
            EscaparSQL(PADR(THIS.this_cMultcomps,3))          + ", " + ;
            FormatarNumeroSQL(THIS.this_nQultcomp)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nDiasinas)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nConsigs)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nFabrproprs)          + ", " + ;
            FormatarNumeroSQL(THIS.this_nEncoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nChkfunds)            + ", " + ;
            EscaparSQL(THIS.this_cObspeds)                   + ", " + ;
            EscaparSQL(THIS.this_cObspes)                    + ", " + ;
            EscaparSQL(THIS.this_cObsetqs)                   + ", " + ;
            EscaparSQL(THIS.this_cDpro3s)                    + ", " + ;
            EscaparSQL(THIS.this_cDsccompras)                + ", " + ;
            EscaparSQL(THIS.this_cObscompras)                + ", " + ;
            FormatarNumeroSQL(THIS.this_nVarias)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nWebpros)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamhs)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamls)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamps)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nVolumes)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTents)               + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_UPDATE - Gera SQL de atualizacao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_UPDATE()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdPro SET " + ;
            "DPros = "       + EscaparSQL(THIS.this_cDpros)              + ", " + ;
            "DPro2s = "      + EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
            "CGrus = "       + EscaparSQL(PADR(THIS.this_cCgrus,3))      + ", " + ;
            "SGrus = "       + EscaparSQL(PADR(THIS.this_cSgrus,6))      + ", " + ;
            "Linhas = "      + EscaparSQL(PADR(THIS.this_cLinhas,10))    + ", " + ;
            "Colecoes = "    + EscaparSQL(PADR(THIS.this_cColecoes,10))  + ", " + ;
            "Mercs = "       + EscaparSQL(PADR(THIS.this_cMercs,3))      + ", " + ;
            "IdeCPros = "    + EscaparSQL(PADR(THIS.this_cIdecpros,3))   + ", " + ;
            "CClass = "      + EscaparSQL(PADR(THIS.this_cCclass,3))     + ", " + ;
            "IFors = "       + EscaparSQL(PADR(THIS.this_cIfors,10))     + ", " + ;
            "Reffs = "       + EscaparSQL(THIS.this_cReffs)              + ", " + ;
            "CodFinP = "     + EscaparSQL(PADR(THIS.this_cCodfinp,3))    + ", " + ;
            "CodAcbs = "     + EscaparSQL(PADR(THIS.this_cCodacbs,3))    + ", " + ;
            "CodCors = "     + EscaparSQL(PADR(THIS.this_cCodcors,4))    + ", " + ;
            "CodTams = "     + EscaparSQL(PADR(THIS.this_cCodtams,4))    + ", " + ;
            "CProEqs = "     + EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
            "Situas = "      + FormatarNumeroSQL(THIS.this_nSituas)       + ", " + ;
            "Datas = "       + FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
            "CBars = "       + FormatarNumeroSQL(THIS.this_nCbars)        + ", " + ;
            "EAN13 = "       + FormatarNumeroSQL(THIS.this_nEan13)        + ", " + ;
            "LtMinsV = "     + FormatarNumeroSQL(THIS.this_nLtminsv)      + ", " + ;
            "QMins = "       + FormatarNumeroSQL(THIS.this_nQmins)        + ", " + ;
            "QtPed = "       + FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
            "Locals = "      + EscaparSQL(PADR(THIS.this_cLocals,10))    + ", " + ;
            "CUnis = "       + EscaparSQL(PADR(THIS.this_cCunis,3))      + ", " + ;
            "CUniPs = "      + EscaparSQL(PADR(THIS.this_cCunips,3))     + ", " + ;
            "PesoBS = "      + FormatarNumeroSQL(THIS.this_nPesobs)       + ", " + ;
            "PesoMs = "      + FormatarNumeroSQL(THIS.this_nPesoms)       + ", " + ;
            "PVens = "       + FormatarNumeroSQL(THIS.this_nPvens)        + ", " + ;
            "FVendas = "     + FormatarNumeroSQL(THIS.this_nFvendas)      + ", " + ;
            "PCuss = "       + FormatarNumeroSQL(THIS.this_nPcuss)        + ", " + ;
            "MoECs = "       + EscaparSQL(PADR(THIS.this_cMoecs,3))      + ", " + ;
            "MoePVs = "      + EscaparSQL(PADR(THIS.this_cMoepvs,3))     + ", " + ;
            "UltComps = "    + FormatarDataSQL(THIS.this_dUltcomps)       + ", " + ;
            "VultComps = "   + FormatarNumeroSQL(THIS.this_nVultcomps)    + ", " + ;
            "MultComps = "   + EscaparSQL(PADR(THIS.this_cMultcomps,3))   + ", " + ;
            "qtdultcomp = "  + FormatarNumeroSQL(THIS.this_nQultcomp)     + ", " + ;
            "DiasINas = "    + FormatarNumeroSQL(THIS.this_nDiasinas)     + ", " + ;
            "ConSigs = "     + FormatarNumeroSQL(THIS.this_nConsigs)      + ", " + ;
            "FabrProprs = "  + FormatarNumeroSQL(THIS.this_nFabrproprs)   + ", " + ;
            "EnComs = "      + FormatarNumeroSQL(THIS.this_nEncoms)       + ", " + ;
            "ChkFunds = "    + FormatarNumeroSQL(THIS.this_nChkfunds)    + ", " + ;
            "ObsPeds = "     + EscaparSQL(THIS.this_cObspeds)            + ", " + ;
            "ObsPes = "      + EscaparSQL(THIS.this_cObspes)             + ", " + ;
            "ObsEtqs = "     + EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
            "DPro3s = "      + EscaparSQL(THIS.this_cDpro3s)             + ", " + ;
            "DscCompras = "  + EscaparSQL(THIS.this_cDsccompras)         + ", " + ;
            "ObsCompras = "  + EscaparSQL(THIS.this_cObscompras)         + ", " + ;
            "Varias = "      + FormatarNumeroSQL(THIS.this_nVarias)       + ", " + ;
            "prodwebs = "    + FormatarNumeroSQL(THIS.this_nWebpros)      + ", " + ;
            "TamHs = "       + FormatarNumeroSQL(THIS.this_nTamhs)        + ", " + ;
            "TamLs = "       + FormatarNumeroSQL(THIS.this_nTamls)        + ", " + ;
            "TamPs = "       + FormatarNumeroSQL(THIS.this_nTamps)        + ", " + ;
            "Volumes = "     + FormatarNumeroSQL(THIS.this_nVolumes)      + ", " + ;
            "TEnts = "       + FormatarNumeroSQL(THIS.this_nTents)        + " " + ;
            "WHERE CPros = " + EscaparSQL(THIS.this_cCpros)

        RETURN loc_cSQL
    ENDPROC

ENDDEFINE

