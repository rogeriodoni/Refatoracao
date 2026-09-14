# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (28)
- [CARGA-DADOS] OptionGroup 'opt_4c_Situacao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_ProdutoWeb' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Variacao' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label18' Top=481 (diff=449px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Left original=72 vs migrado 'lbl_4c_Label18' Left=301 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=0 (diff=959px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Top original=18 vs migrado 'lbl_4c_LblGrupo' Top=265 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblGrupo' (parent: SIGCDPRO.Pagina.Lista.cntFiltros): Left original=21 vs migrado 'lbl_4c_LblGrupo' Left=73 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label2' Top=217 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label10' Top=534 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'lbl_4c_Label9' Top=534 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'CmdQtMin' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=199 vs migrado 'cmd_4c_CmdQtMin' Top=282 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblClassificacao' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=374 vs migrado 'lbl_4c_LblClassificacao' Top=457 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblModelo' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=326 vs migrado 'lbl_4c_LblModelo' Top=409 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget3' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=470 vs migrado 'txt_4c_Fwget3' Top=553 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget6' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=470 vs migrado 'txt_4c_Fwget6' Top=553 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblProfundidade' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblProfundidade' Top=557 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAltura' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblAltura' Top=557 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblComprimento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=474 vs migrado 'lbl_4c_LblComprimento' Top=557 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget4' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=470 vs migrado 'txt_4c_Fwget4' Top=553 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget5' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=470 vs migrado 'txt_4c_Fwget5' Top=553 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'get_Consig' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'chk_4c_Get_Consig' Top=534 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkFabrProprs' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'chk_4c_ChkFabrProprs' Top=534 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAcabamento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=350 vs migrado 'lbl_4c_LblAcabamento' Top=433 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkEncoms' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=451 vs migrado 'chk_4c_ChkEncoms' Top=534 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ChkGarVit' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=228 vs migrado 'chk_4c_ChkGarVit' Top=311 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lblAcabamento' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP): Top original=356 vs migrado 'lbl_4c_LblAcabamento' Top=433 (diff=77px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4071 linhas total):

*-- Linhas 30 a 327:
30:     *--------------------------------------------------------------------------
31:     * Init - Inicializacao do formulario
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *--------------------------------------------------------------------------
39:     * InicializarForm - Configuracao inicial do formulario
40:     *--------------------------------------------------------------------------
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             *-- Criar instancia do Business Object
47:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
48: 
49:             IF ISNULL(THIS.this_oBusinessObject)
50:                 MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
51:                 loc_lSucesso = .F.
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54:                 THIS.ConfigurarPaginaLista()
55:                 THIS.ConfigurarPaginaDados()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     IF !THIS.CarregarLista()
61:                         *-- Se falhar ao carregar, nao impede abertura
62:                     ENDIF
63:                 ENDIF
64: 
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68:                 loc_lSucesso = .T.
69:             ENDIF
70: 
71:         CATCH TO loException
72:             MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
73:             loc_lSucesso = .F.
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Configura o PageFrame principal
81:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 600
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             *-- Page1 - Lista
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             *-- Page2 - Dados
101:             .Page2.Caption   = "Dados"
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:         ENDWITH
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------
108:     * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
109:     * Compensacao +29 aplicada a todos os controles da Page
110:     * Pilar 1: UX fiel ao legado SIGCDPRO
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina, loc_oFiltros
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Container de cabecalho escuro (Top=2 na tela -> Top=31 na Page)
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = 1003
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(53, 53, 53)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
131:             .Caption   = "Cadastro de Produtos"
132:             .Top       = 20
133:             .Left      = 20
134:             .Width     = 400
135:             .Height    = 30
136:             .FontName  = "Tahoma"
137:             .FontSize  = 14
138:             .FontBold  = .T.
139:             .BackStyle = 0
140:             .ForeColor = RGB(255, 255, 255)
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         *-- Container de botoes CRUD (sobrepoem o cabecalho escuro)
145:         *-- Top=0 no legado -> Top=29 (compensa PageFrame.Top=-29)
146:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
147:         WITH loc_oPagina.cnt_4c_Botoes
148:             .Top         = 29
149:             .Left        = 0
150:             .Width       = 540
151:             .Height      = 85
152:             .BackStyle   = 0
153:             .BorderWidth = 0
154:             .Visible     = .T.
155:         ENDWITH
156: 
157:         *-- Botao Incluir
158:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
159:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
160:             .Caption         = "Incluir"
161:             .Width           = 75
162:             .Height          = 75
163:             .Left            = 5
164:             .Top             = 5
165:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
166:             .PicturePosition = 13
167:             .FontName        = "Tahoma"
168:             .FontSize        = 8
169:             .Themes          = .F.
170:             .SpecialEffect   = 0
171:             .BackColor       = RGB(255, 255, 255)
172:             .ForeColor       = RGB(90, 90, 90)
173:             .Visible         = .T.
174:         ENDWITH
175:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
176: 
177:         *-- Botao Visualizar
178:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
179:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
180:             .Caption         = "Visualizar"
181:             .Width           = 75
182:             .Height          = 75
183:             .Left            = 80
184:             .Top             = 5
185:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
186:             .PicturePosition = 13
187:             .FontName        = "Tahoma"
188:             .FontSize        = 8
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .BackColor       = RGB(255, 255, 255)
192:             .ForeColor       = RGB(90, 90, 90)
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
196: 
197:         *-- Botao Alterar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
200:             .Caption         = "Alterar"
201:             .Width           = 75
202:             .Height          = 75
203:             .Left            = 155
204:             .Top             = 5
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
206:             .PicturePosition = 13
207:             .FontName        = "Tahoma"
208:             .FontSize        = 8
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .Visible         = .T.
214:         ENDWITH
215:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
216: 
217:         *-- Botao Excluir
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
220:             .Caption         = "Excluir"
221:             .Width           = 75
222:             .Height          = 75
223:             .Left            = 230
224:             .Top             = 5
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
226:             .PicturePosition = 13
227:             .FontName        = "Tahoma"
228:             .FontSize        = 8
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
236: 
237:         *-- Botao Buscar (aplica filtro da cnt_4c_Filtros)
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
240:             .Caption         = "Buscar"
241:             .Width           = 75
242:             .Height          = 75
243:             .Left            = 305
244:             .Top             = 5
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
246:             .PicturePosition = 13
247:             .FontName        = "Tahoma"
248:             .FontSize        = 8
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .BackColor       = RGB(255, 255, 255)
252:             .ForeColor       = RGB(90, 90, 90)
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
256: 
257:         *-- Container de saida (Encerrar, alinhado a direita)
258:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
259:         WITH loc_oPagina.cnt_4c_Saida
260:             .Top         = 29
261:             .Left        = 917
262:             .Width       = 90
263:             .Height      = 85
264:             .BackStyle   = 0
265:             .BorderWidth = 0
266:             .Visible     = .T.
267:         ENDWITH
268: 
269:         *-- Botao Encerrar
270:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
271:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
272:             .Caption         = "Encerrar"
273:             .Width           = 75
274:             .Height          = 75
275:             .Left            = 5
276:             .Top             = 5
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
278:             .PicturePosition = 13
279:             .FontName        = "Tahoma"
280:             .FontSize        = 8
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .BackColor       = RGB(255, 255, 255)
284:             .ForeColor       = RGB(90, 90, 90)
285:             .Visible         = .T.
286:         ENDWITH
287:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
288: 
289:         *-- Container de filtros (Grupo, Data ultima alteracao, Situacao)
290:         *-- Legado: cntFiltros
291:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
292:         loc_oFiltros = loc_oPagina.cnt_4c_Filtros
293:         WITH loc_oFiltros
294:             .Top         = 114
295:             .Left        = 0
296:             .Width       = 1003
297:             .Height      = 70
298:             .BackStyle   = 1
299:             .BackColor   = RGB(240, 240, 240)
300:             .BorderWidth = 0
301:             .Visible     = .T.
302:         ENDWITH
303: 
304:         *-- Linha 1: Grupo de Produto
305:         loc_oFiltros.AddObject("lbl_4c_Grupo", "Label")
306:         WITH loc_oFiltros.lbl_4c_Grupo
307:             .Caption   = "Grupo de Produto :"
308:             .Top       = 18
309:             .Left      = 21
310:             .Width     = 94
311:             .Height    = 15
312:             .FontName  = "Tahoma"
313:             .FontSize  = 8
314:             .BackStyle = 0
315:             .ForeColor = RGB(0, 0, 0)
316:             .Visible   = .T.
317:         ENDWITH
318: 
319:         loc_oFiltros.AddObject("txt_4c_Cgru", "TextBox")
320:         WITH loc_oFiltros.txt_4c_Cgru
321:             .Value     = ""
322:             .Top       = 14
323:             .Left      = 116
324:             .Width     = 31
325:             .Height    = 23
326:             .FontName  = "Tahoma"
327:             .FontSize  = 8

*-- Linhas 343 a 421:
343:         ENDWITH
344: 
345:         *-- Situacao: Todos / Ativos / Inativos
346:         loc_oFiltros.AddObject("opt_4c_Situas", "OptionGroup")
347:         WITH loc_oFiltros.opt_4c_Situas
348:             .Top         = 10
349:             .Left        = 315
350:             .Width       = 156
351:             .Height      = 22
352:             .ButtonCount = 3
353:             .Value       = 1
354:             .Themes      = .F.
355:             .Visible     = .T.
356:             .Buttons(1).Caption   = "Todos"
357:             .Buttons(1).Left      = 0
358:             .Buttons(1).Top       = 0
359:             .Buttons(1).Width     = 50
360:             .Buttons(1).Height    = 22
361:             .Buttons(1).AutoSize  = .F.
362:             .Buttons(1).ForeColor = RGB(0, 0, 0)
363:             .Buttons(1).Themes    = .F.
364:             .Buttons(2).Caption   = "Ativos"
365:             .Buttons(2).Left      = 52
366:             .Buttons(2).Top       = 0
367:             .Buttons(2).Width     = 50
368:             .Buttons(2).Height    = 22
369:             .Buttons(2).AutoSize  = .F.
370:             .Buttons(2).ForeColor = RGB(0, 0, 0)
371:             .Buttons(2).Themes    = .F.
372:             .Buttons(3).Caption   = "Inativos"
373:             .Buttons(3).Left      = 104
374:             .Buttons(3).Top       = 0
375:             .Buttons(3).Width     = 52
376:             .Buttons(3).Height    = 22
377:             .Buttons(3).AutoSize  = .F.
378:             .Buttons(3).ForeColor = RGB(0, 0, 0)
379:             .Buttons(3).Themes    = .F.
380:         ENDWITH
381:         BINDEVENT(loc_oFiltros.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
382: 
383:         *-- Linha 2: Data ultima alteracao
384:         loc_oFiltros.AddObject("lbl_4c_DtAlt", "Label")
385:         WITH loc_oFiltros.lbl_4c_DtAlt
386:             .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
387:             .Top       = 43
388:             .Left      = 28
389:             .Width     = 87
390:             .Height    = 15
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .BackStyle = 0
394:             .ForeColor = RGB(0, 0, 0)
395:             .Visible   = .T.
396:         ENDWITH
397: 
398:         loc_oFiltros.AddObject("txt_4c_DtIni", "TextBox")
399:         WITH loc_oFiltros.txt_4c_DtIni
400:             .Value     = {}
401:             .Top       = 39
402:             .Left      = 116
403:             .Width     = 84
404:             .Height    = 23
405:             .FontName  = "Tahoma"
406:             .FontSize  = 8
407:             .Visible   = .T.
408:         ENDWITH
409: 
410:         loc_oFiltros.AddObject("lbl_4c_Ate", "Label")
411:         WITH loc_oFiltros.lbl_4c_Ate
412:             .Caption   = "at" + CHR(233)
413:             .Top       = 43
414:             .Left      = 202
415:             .Width     = 18
416:             .Height    = 15
417:             .FontName  = "Tahoma"
418:             .FontSize  = 8
419:             .BackStyle = 0
420:             .ForeColor = RGB(0, 0, 0)
421:             .Visible   = .T.

*-- Linhas 478 a 584:
478:         loc_oPagina.grd_4c_Dados.Column7.Sparse = .F.
479: 
480:         *-- Tornar controles visiveis
481:         THIS.TornarControlesVisiveis(loc_oPagina)
482:     ENDPROC
483: 
484:     *--------------------------------------------------------------------------
485:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
486:     * Estrutura: BotoesAcao + AbasNavegacao + pgf_4c_DadosPrd (7 paginas)
487:     * Fase 5: infra Page2 completa + primeiro 50% dos campos pgDados
488:     *--------------------------------------------------------------------------
489:     PROTECTED PROCEDURE ConfigurarPaginaDados()
490:         LOCAL loc_oPagina
491:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
492: 
493:         *-- Container de botoes de acao (Salvar, Cancelar)
494:         *-- Legado: Grupo_Salva.Top=9 na tela -> Top=38 na Page2
495:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
496:         WITH loc_oPagina.cnt_4c_BotoesAcao
497:             .Top         = 38
498:             .Left        = 819
499:             .Width       = 165
500:             .Height      = 85
501:             .BackStyle   = 0
502:             .BorderWidth = 0
503:             .Visible     = .T.
504:         ENDWITH
505: 
506:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
507:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
508:             .Caption         = "Salvar"
509:             .Width           = 75
510:             .Height          = 75
511:             .Left            = 5
512:             .Top             = 5
513:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
514:             .PicturePosition = 13
515:             .FontName        = "Tahoma"
516:             .FontSize        = 8
517:             .Themes          = .F.
518:             .SpecialEffect   = 0
519:             .BackColor       = RGB(255, 255, 255)
520:             .ForeColor       = RGB(90, 90, 90)
521:         ENDWITH
522:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
523: 
524:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
525:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
526:             .Caption         = "Cancelar"
527:             .Width           = 75
528:             .Height          = 75
529:             .Left            = 80
530:             .Top             = 5
531:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
532:             .PicturePosition = 13
533:             .FontName        = "Tahoma"
534:             .FontSize        = 8
535:             .Themes          = .F.
536:             .SpecialEffect   = 0
537:             .BackColor       = RGB(255, 255, 255)
538:             .ForeColor       = RGB(90, 90, 90)
539:         ENDWITH
540:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:         *-- OptionGroup navegacao de abas (7 abas, simula tabs do pgframeDados oculto)
543:         *-- Legado: Optiongroup1.Top=5 na tela -> Top=34 na Page2, Width=535, Height=85
544:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
545:         WITH loc_oPagina.opt_4c_Abas
546:             .Top         = 34
547:             .Left        = 5
548:             .Width       = 535
549:             .Height      = 85
550:             .ButtonCount = 7
551:             .Value       = 1
552:             .Themes      = .F.
553:             .Buttons(1).Caption   = "Dados"
554:             .Buttons(1).Left      = 0
555:             .Buttons(1).Top       = 0
556:             .Buttons(1).Width     = 75
557:             .Buttons(1).Height    = 85
558:             .Buttons(1).AutoSize  = .F.
559:             .Buttons(1).FontName  = "Tahoma"
560:             .Buttons(1).FontSize  = 8
561:             .Buttons(1).ForeColor = RGB(0, 0, 0)
562:             .Buttons(1).Themes    = .F.
563:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
564:             .Buttons(2).Left      = 76
565:             .Buttons(2).Top       = 0
566:             .Buttons(2).Width     = 75
567:             .Buttons(2).Height    = 85
568:             .Buttons(2).AutoSize  = .F.
569:             .Buttons(2).FontName  = "Tahoma"
570:             .Buttons(2).FontSize  = 8
571:             .Buttons(2).ForeColor = RGB(0, 0, 0)
572:             .Buttons(2).Themes    = .F.
573:             .Buttons(3).Caption   = "Fiscal"
574:             .Buttons(3).Left      = 152
575:             .Buttons(3).Top       = 0
576:             .Buttons(3).Width     = 75
577:             .Buttons(3).Height    = 85
578:             .Buttons(3).AutoSize  = .F.
579:             .Buttons(3).FontName  = "Tahoma"
580:             .Buttons(3).FontSize  = 8
581:             .Buttons(3).ForeColor = RGB(0, 0, 0)
582:             .Buttons(3).Themes    = .F.
583:             .Buttons(4).Caption   = "Fases P."
584:             .Buttons(4).Left      = 228

*-- Linhas 621 a 701:
621:             .Buttons(7).ForeColor = RGB(0, 0, 0)
622:             .Buttons(7).Themes    = .F.
623:         ENDWITH
624:         BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OptAbasChange")
625: 
626:         *-- Inner PageFrame (pgframeDados: Top=-54, Left=-1 na Page2, 7 paginas sem abas)
627:         loc_oPagina.AddObject("pgf_4c_DadosPrd", "PageFrame")
628:         WITH loc_oPagina.pgf_4c_DadosPrd
629:             .Top       = -54
630:             .Left      = -1
631:             .Width     = 1003
632:             .Height    = 656
633:             .PageCount = 7
634:             .Tabs      = .F.
635:             .Page1.Caption = "Dados"
636:             .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
637:             .Page3.Caption = "Fiscal"
638:             .Page4.Caption = "Fases P."
639:             .Page5.Caption = "Cons. P."
640:             .Page6.Caption = "Custo"
641:             .Page7.Caption = "Designer"
642:         ENDWITH
643: 
644:         *-- Configurar controles da aba Dados (pgDados = Page1 do pgf_4c_DadosPrd)
645:         THIS.ConfigurarPgDados()
646: 
647:         *-- Garantir visibilidade do inner PageFrame e aba inicial
648:         loc_oPagina.pgf_4c_DadosPrd.Visible     = .T.
649:         loc_oPagina.pgf_4c_DadosPrd.ActivePage  = 1
650: 
651:         *-- Tornar controles visiveis na Page2 e na pgDados
652:         THIS.TornarControlesVisiveis(loc_oPagina)
653:         THIS.TornarControlesVisiveis(loc_oPagina.pgf_4c_DadosPrd.Page1)
654:     ENDPROC
655: 
656:     *--------------------------------------------------------------------------
657:     * ConfigurarPgDados - Configura controles da aba Dados (pgDados = Page1)
658:     * Coordenadas: layout.json form-abs + 83 (29 outer PageFrame + 54 pgframeDados)
659:     * Fase 5: primeiro 50% dos campos (Top form-abs ate ~331 -> +83 = ~414)
660:     *--------------------------------------------------------------------------
661:     PROTECTED PROCEDURE ConfigurarPgDados()
662:         LOCAL loc_oPgDados
663:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
664: 
665:         *-- Botoes de imagem do produto (form-abs Top=33 -> 116)
666:         loc_oPgDados.AddObject("cmd_4c_Produto", "CommandButton")
667:         WITH loc_oPgDados.cmd_4c_Produto
668:             .Caption       = "Foto"
669:             .Top           = 116
670:             .Left          = 623
671:             .Width         = 85
672:             .Height        = 85
673:             .FontName      = "Tahoma"
674:             .FontSize      = 8
675:             .Themes        = .F.
676:             .SpecialEffect = 0
677:             .BackColor     = RGB(240, 240, 240)
678:             .ForeColor     = RGB(90, 90, 90)
679:         ENDWITH
680: 
681:         loc_oPgDados.AddObject("cmd_4c_Arquivos", "CommandButton")
682:         WITH loc_oPgDados.cmd_4c_Arquivos
683:             .Caption       = "Arquivos"
684:             .Top           = 116
685:             .Left          = 698
686:             .Width         = 85
687:             .Height        = 85
688:             .FontName      = "Tahoma"
689:             .FontSize      = 8
690:             .Themes        = .F.
691:             .SpecialEffect = 0
692:             .BackColor     = RGB(240, 240, 240)
693:             .ForeColor     = RGB(90, 90, 90)
694:         ENDWITH
695: 
696:         *-- === Codigo / Descricao / Situacao (form-abs Top=130 -> 213) ===
697:         loc_oPgDados.AddObject("lbl_4c_Label2", "Label")
698:         WITH loc_oPgDados.lbl_4c_Label2
699:             .Caption   = "Produto :"
700:             .Top       = 217
701:             .Left      = 58

*-- Linhas 727 a 772:
727:             .FontName = "Tahoma"
728:             .FontSize = 8
729:             .Value    = ""
730:         ENDWITH
731: 
732:         loc_oPgDados.AddObject("opt_4c_Situacao", "OptionGroup")
733:         WITH loc_oPgDados.opt_4c_Situacao
734:             .Top         = 213
735:             .Left        = 735
736:             .Width       = 142
737:             .Height      = 25
738:             .ButtonCount = 2
739:             .Value       = 1
740:             .Themes      = .F.
741:             .Buttons(1).Caption   = "Ativo"
742:             .Buttons(1).Left      = 0
743:             .Buttons(1).Top       = 0
744:             .Buttons(1).Width     = 70
745:             .Buttons(1).Height    = 25
746:             .Buttons(1).AutoSize  = .F.
747:             .Buttons(1).ForeColor = RGB(0, 0, 0)
748:             .Buttons(1).Themes    = .F.
749:             .Buttons(2).Caption   = "Inativo"
750:             .Buttons(2).Left      = 71
751:             .Buttons(2).Top       = 0
752:             .Buttons(2).Width     = 71
753:             .Buttons(2).Height    = 25
754:             .Buttons(2).AutoSize  = .F.
755:             .Buttons(2).ForeColor = RGB(0, 0, 0)
756:             .Buttons(2).Themes    = .F.
757:         ENDWITH
758: 
759:         loc_oPgDados.AddObject("txt_4c_DtSituas", "TextBox")
760:         WITH loc_oPgDados.txt_4c_DtSituas
761:             .Top       = 215
762:             .Left      = 878
763:             .Width     = 80
764:             .Height    = 21
765:             .FontName  = "Tahoma"
766:             .FontSize  = 8
767:             .Value     = {}
768:             .ReadOnly  = .T.
769:             .BackColor = RGB(240, 240, 240)
770:         ENDWITH
771: 
772:         *-- Equivalente (form-abs Top=133/137 -> 216/220)

*-- Linhas 793 a 836:
793:             .FontSize = 8
794:             .Value    = ""
795:         ENDWITH
796:         BINDEVENT(loc_oPgDados.txt_4c_CProEq, "KeyPress", THIS, "KeyPressEquivalente")
797: 
798:         *-- === Descritivo / Lote Minimo / Barra (form-abs Top=154-155 -> 237-238) ===
799:         loc_oPgDados.AddObject("lbl_4c_LblDesc2", "Label")
800:         WITH loc_oPgDados.lbl_4c_LblDesc2
801:             .Caption   = "Descritivo :"
802:             .Top       = 240
803:             .Left      = 55
804:             .Width     = 56
805:             .Height    = 15
806:             .FontName  = "Tahoma"
807:             .FontSize  = 8
808:             .BackStyle = 0
809:             .ForeColor = RGB(0, 0, 0)
810:         ENDWITH
811: 
812:         loc_oPgDados.AddObject("txt_4c_DPro2s", "TextBox")
813:         WITH loc_oPgDados.txt_4c_DPro2s
814:             .Top      = 237
815:             .Left     = 113
816:             .Width    = 399
817:             .Height   = 23
818:             .FontName = "Tahoma"
819:             .FontSize = 8
820:             .Value    = ""
821:         ENDWITH
822: 
823:         loc_oPgDados.AddObject("lbl_4c_LblLtMins", "Label")
824:         WITH loc_oPgDados.lbl_4c_LblLtMins
825:             .Caption   = "Lote M" + CHR(237) + "nimo :"
826:             .Top       = 240
827:             .Left      = 812
828:             .Width     = 65
829:             .Height    = 15
830:             .FontName  = "Tahoma"
831:             .FontSize  = 8
832:             .BackStyle = 0
833:             .ForeColor = RGB(0, 0, 0)
834:         ENDWITH
835: 
836:         loc_oPgDados.AddObject("txt_4c_LtMinsV", "TextBox")

*-- Linhas 868 a 925:
868:             .Value    = ""
869:         ENDWITH
870: 
871:         *-- Produto Web OptionGroup (form-abs Top=172/176 -> 255/259, 4 botoes)
872:         loc_oPgDados.AddObject("lbl_4c_LblProdWeb", "Label")
873:         WITH loc_oPgDados.lbl_4c_LblProdWeb
874:             .Caption   = "Produto Web :"
875:             .Top       = 259
876:             .Left      = 805
877:             .Width     = 72
878:             .Height    = 15
879:             .FontName  = "Tahoma"
880:             .FontSize  = 8
881:             .BackStyle = 0
882:             .ForeColor = RGB(0, 0, 0)
883:         ENDWITH
884: 
885:         loc_oPgDados.AddObject("opt_4c_ProdutoWeb", "OptionGroup")
886:         WITH loc_oPgDados.opt_4c_ProdutoWeb
887:             .Top         = 255
888:             .Left        = 879
889:             .Width       = 117
890:             .Height      = 42
891:             .ButtonCount = 4
892:             .Value       = 1
893:             .Themes      = .F.
894:             .Buttons(1).Caption   = "N"
895:             .Buttons(1).Left      = 0
896:             .Buttons(1).Top       = 0
897:             .Buttons(1).Width     = 29
898:             .Buttons(1).Height    = 42
899:             .Buttons(1).AutoSize  = .F.
900:             .Buttons(1).ForeColor = RGB(0, 0, 0)
901:             .Buttons(1).Themes    = .F.
902:             .Buttons(2).Caption   = "S"
903:             .Buttons(2).Left      = 30
904:             .Buttons(2).Top       = 0
905:             .Buttons(2).Width     = 29
906:             .Buttons(2).Height    = 42
907:             .Buttons(2).AutoSize  = .F.
908:             .Buttons(2).ForeColor = RGB(0, 0, 0)
909:             .Buttons(2).Themes    = .F.
910:             .Buttons(3).Caption   = "D"
911:             .Buttons(3).Left      = 60
912:             .Buttons(3).Top       = 0
913:             .Buttons(3).Width     = 29
914:             .Buttons(3).Height    = 42
915:             .Buttons(3).AutoSize  = .F.
916:             .Buttons(3).ForeColor = RGB(0, 0, 0)
917:             .Buttons(3).Themes    = .F.
918:             .Buttons(4).Caption   = "I"
919:             .Buttons(4).Left      = 90
920:             .Buttons(4).Top       = 0
921:             .Buttons(4).Width     = 27
922:             .Buttons(4).Height    = 42
923:             .Buttons(4).AutoSize  = .F.
924:             .Buttons(4).ForeColor = RGB(0, 0, 0)
925:             .Buttons(4).Themes    = .F.

*-- Linhas 973 a 1016:
973:             .FontSize = 8
974:             .Value    = ""
975:         ENDWITH
976:         BINDEVENT(loc_oPgDados.txt_4c_Cgru, "KeyPress", THIS, "KeyPressCgru")
977: 
978:         loc_oPgDados.AddObject("txt_4c_Dgru", "TextBox")
979:         WITH loc_oPgDados.txt_4c_Dgru
980:             .Top       = 261
981:             .Left      = 145
982:             .Width     = 171
983:             .Height    = 23
984:             .FontName  = "Tahoma"
985:             .FontSize  = 8
986:             .ReadOnly  = .T.
987:             .BackColor = RGB(240, 240, 240)
988:             .Value     = ""
989:         ENDWITH
990: 
991:         loc_oPgDados.AddObject("txt_4c_Merc", "TextBox")
992:         WITH loc_oPgDados.txt_4c_Merc
993:             .Top      = 261
994:             .Left     = 318
995:             .Width    = 31
996:             .Height   = 23
997:             .FontName = "Tahoma"
998:             .FontSize = 8
999:             .Value    = ""
1000:         ENDWITH
1001: 
1002:         loc_oPgDados.AddObject("lbl_4c_LblIdent", "Label")
1003:         WITH loc_oPgDados.lbl_4c_LblIdent
1004:             .Caption   = "Identificador :"
1005:             .Top       = 265
1006:             .Left      = 408
1007:             .Width     = 70
1008:             .Height    = 15
1009:             .FontName  = "Tahoma"
1010:             .FontSize  = 8
1011:             .BackStyle = 0
1012:             .ForeColor = RGB(0, 0, 0)
1013:         ENDWITH
1014: 
1015:         loc_oPgDados.AddObject("txt_4c_IdeCPros", "TextBox")
1016:         WITH loc_oPgDados.txt_4c_IdeCPros

*-- Linhas 1046 a 1181:
1046:             .FontName = "Tahoma"
1047:             .FontSize = 8
1048:             .Value    = 0
1049:         ENDWITH
1050: 
1051:         loc_oPgDados.AddObject("cmd_4c_CmdQtMin", "CommandButton")
1052:         WITH loc_oPgDados.cmd_4c_CmdQtMin
1053:             .Caption       = ". . ."
1054:             .Top           = 282
1055:             .Left          = 709
1056:             .Width         = 25
1057:             .Height        = 23
1058:             .FontName      = "Tahoma"
1059:             .FontSize      = 8
1060:             .Themes        = .F.
1061:             .SpecialEffect = 0
1062:         ENDWITH
1063:         BINDEVENT(loc_oPgDados.cmd_4c_CmdQtMin, "Click", THIS, "BtnQtMinClick")
1064: 
1065:         loc_oPgDados.AddObject("lbl_4c_LblSubgrp", "Label")
1066:         WITH loc_oPgDados.lbl_4c_LblSubgrp
1067:             .Caption   = "Subgrupo :"
1068:             .Top       = 286
1069:             .Left      = 56
1070:             .Width     = 55
1071:             .Height    = 15
1072:             .FontName  = "Tahoma"
1073:             .FontSize  = 8
1074:             .BackStyle = 0
1075:             .ForeColor = RGB(0, 0, 0)
1076:         ENDWITH
1077: 
1078:         loc_oPgDados.AddObject("txt_4c_CSGru", "TextBox")
1079:         WITH loc_oPgDados.txt_4c_CSGru
1080:             .Top      = 285
1081:             .Left     = 113
1082:             .Width    = 52
1083:             .Height   = 23
1084:             .FontName = "Tahoma"
1085:             .FontSize = 8
1086:             .Value    = ""
1087:         ENDWITH
1088:         BINDEVENT(loc_oPgDados.txt_4c_CSGru, "KeyPress", THIS, "KeyPressCSGru")
1089: 
1090:         loc_oPgDados.AddObject("txt_4c_DsGru", "TextBox")
1091:         WITH loc_oPgDados.txt_4c_DsGru
1092:             .Top       = 285
1093:             .Left      = 166
1094:             .Width     = 150
1095:             .Height    = 23
1096:             .FontName  = "Tahoma"
1097:             .FontSize  = 8
1098:             .ReadOnly  = .T.
1099:             .BackColor = RGB(240, 240, 240)
1100:             .Value     = ""
1101:         ENDWITH
1102: 
1103:         loc_oPgDados.AddObject("lbl_4c_LblConj", "Label")
1104:         WITH loc_oPgDados.lbl_4c_LblConj
1105:             .Caption   = "Conjunto :"
1106:             .Top       = 289
1107:             .Left      = 408
1108:             .Width     = 53
1109:             .Height    = 15
1110:             .FontName  = "Tahoma"
1111:             .FontSize  = 8
1112:             .BackStyle = 0
1113:             .ForeColor = RGB(0, 0, 0)
1114:         ENDWITH
1115: 
1116:         loc_oPgDados.AddObject("txt_4c_Conjunto", "TextBox")
1117:         WITH loc_oPgDados.txt_4c_Conjunto
1118:             .Top      = 285
1119:             .Left     = 460
1120:             .Width    = 52
1121:             .Height   = 23
1122:             .FontName = "Tahoma"
1123:             .FontSize = 8
1124:             .Value    = ""
1125:         ENDWITH
1126:         BINDEVENT(loc_oPgDados.txt_4c_Conjunto, "KeyPress", THIS, "KeyPressConjunto")
1127: 
1128:         loc_oPgDados.AddObject("lbl_4c_LblVariacao", "Label")
1129:         WITH loc_oPgDados.lbl_4c_LblVariacao
1130:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
1131:             .Top       = 290
1132:             .Left      = 827
1133:             .Width     = 50
1134:             .Height    = 15
1135:             .FontName  = "Tahoma"
1136:             .FontSize  = 8
1137:             .BackStyle = 0
1138:             .ForeColor = RGB(0, 0, 0)
1139:         ENDWITH
1140: 
1141:         loc_oPgDados.AddObject("opt_4c_Variacao", "OptionGroup")
1142:         WITH loc_oPgDados.opt_4c_Variacao
1143:             .Top         = 286
1144:             .Left        = 874
1145:             .Width       = 107
1146:             .Height      = 22
1147:             .ButtonCount = 2
1148:             .Value       = 1
1149:             .Themes      = .F.
1150:             .Buttons(1).Caption   = "Normal"
1151:             .Buttons(1).Left      = 0
1152:             .Buttons(1).Top       = 0
1153:             .Buttons(1).Width     = 53
1154:             .Buttons(1).Height    = 22
1155:             .Buttons(1).AutoSize  = .F.
1156:             .Buttons(1).ForeColor = RGB(0, 0, 0)
1157:             .Buttons(1).Themes    = .F.
1158:             .Buttons(2).Caption   = "Varia" + CHR(231) + CHR(227) + "o"
1159:             .Buttons(2).Left      = 54
1160:             .Buttons(2).Top       = 0
1161:             .Buttons(2).Width     = 53
1162:             .Buttons(2).Height    = 22
1163:             .Buttons(2).AutoSize  = .F.
1164:             .Buttons(2).ForeColor = RGB(0, 0, 0)
1165:             .Buttons(2).Themes    = .F.
1166:         ENDWITH
1167: 
1168:         *-- === Qtde Pedido / Linha / Garantia (form-abs 221-230 -> 304-313) ===
1169:         loc_oPgDados.AddObject("lbl_4c_LblQtPed", "Label")
1170:         WITH loc_oPgDados.lbl_4c_LblQtPed
1171:             .Caption   = "Qtde. Pedido :"
1172:             .Top       = 308
1173:             .Left      = 553
1174:             .Width     = 72
1175:             .Height    = 15
1176:             .FontName  = "Tahoma"
1177:             .FontSize  = 8
1178:             .BackStyle = 0
1179:             .ForeColor = RGB(0, 0, 0)
1180:         ENDWITH
1181: 

*-- Linhas 1265 a 1308:
1265:             .FontSize = 8
1266:             .Value    = ""
1267:         ENDWITH
1268:         BINDEVENT(loc_oPgDados.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")
1269: 
1270:         loc_oPgDados.AddObject("txt_4c_DLin", "TextBox")
1271:         WITH loc_oPgDados.txt_4c_DLin
1272:             .Top       = 309
1273:             .Left      = 194
1274:             .Width     = 318
1275:             .Height    = 23
1276:             .FontName  = "Tahoma"
1277:             .FontSize  = 8
1278:             .ReadOnly  = .T.
1279:             .BackColor = RGB(240, 240, 240)
1280:             .Value     = ""
1281:         ENDWITH
1282: 
1283:         *-- === Obs.Comp / Altura / Col.Venda (form-abs 243-253 -> 326-336) ===
1284:         loc_oPgDados.AddObject("lbl_4c_LblObsComp", "Label")
1285:         WITH loc_oPgDados.lbl_4c_LblObsComp
1286:             .Caption   = "Obs. Comp. :"
1287:             .Top       = 330
1288:             .Left      = 529
1289:             .Width     = 72
1290:             .Height    = 15
1291:             .FontName  = "Tahoma"
1292:             .FontSize  = 8
1293:             .BackStyle = 0
1294:             .ForeColor = RGB(0, 0, 0)
1295:         ENDWITH
1296: 
1297:         loc_oPgDados.AddObject("txt_4c_Obs3", "TextBox")
1298:         WITH loc_oPgDados.txt_4c_Obs3
1299:             .Top      = 326
1300:             .Left     = 626
1301:             .Width    = 80
1302:             .Height   = 21
1303:             .FontName = "Tahoma"
1304:             .FontSize = 8
1305:             .Value    = ""
1306:         ENDWITH
1307: 
1308:         loc_oPgDados.AddObject("lbl_4c_LblAltMM", "Label")

*-- Linhas 1365 a 1408:
1365:             .FontSize = 8
1366:             .Value    = ""
1367:         ENDWITH
1368:         BINDEVENT(loc_oPgDados.txt_4c_Col, "KeyPress", THIS, "KeyPressCol")
1369: 
1370:         loc_oPgDados.AddObject("txt_4c_DCol", "TextBox")
1371:         WITH loc_oPgDados.txt_4c_DCol
1372:             .Top       = 333
1373:             .Left      = 194
1374:             .Width     = 318
1375:             .Height    = 23
1376:             .FontName  = "Tahoma"
1377:             .FontSize  = 8
1378:             .ReadOnly  = .T.
1379:             .BackColor = RGB(240, 240, 240)
1380:             .Value     = ""
1381:         ENDWITH
1382: 
1383:         *-- === Obs1 / Largura (form-abs 265-269 -> 348-352) ===
1384:         loc_oPgDados.AddObject("lbl_4c_LblObs1", "Label")
1385:         WITH loc_oPgDados.lbl_4c_LblObs1
1386:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1387:             .Top       = 352
1388:             .Left      = 558
1389:             .Width     = 67
1390:             .Height    = 15
1391:             .FontName  = "Tahoma"
1392:             .FontSize  = 8
1393:             .BackStyle = 0
1394:             .ForeColor = RGB(0, 0, 0)
1395:         ENDWITH
1396: 
1397:         loc_oPgDados.AddObject("txt_4c_Obs1", "TextBox")
1398:         WITH loc_oPgDados.txt_4c_Obs1
1399:             .Top      = 348
1400:             .Left     = 626
1401:             .Width    = 220
1402:             .Height   = 21
1403:             .FontName = "Tahoma"
1404:             .FontSize = 8
1405:             .Value    = ""
1406:         ENDWITH
1407: 
1408:         loc_oPgDados.AddObject("lbl_4c_LblLargMM", "Label")

*-- Linhas 1466 a 1536:
1466:             .FontSize = 8
1467:             .Value    = 0
1468:         ENDWITH
1469:         BINDEVENT(loc_oPgDados.txt_4c_Ifor, "KeyPress", THIS, "KeyPressFornecedor")
1470: 
1471:         loc_oPgDados.AddObject("txt_4c_Dfor", "TextBox")
1472:         WITH loc_oPgDados.txt_4c_Dfor
1473:             .Top       = 357
1474:             .Left      = 194
1475:             .Width     = 318
1476:             .Height    = 23
1477:             .FontName  = "Tahoma"
1478:             .FontSize  = 8
1479:             .ReadOnly  = .T.
1480:             .BackColor = RGB(240, 240, 240)
1481:             .Value     = ""
1482:         ENDWITH
1483: 
1484:         loc_oPgDados.AddObject("cmd_4c_BotFornecedor", "CommandButton")
1485:         WITH loc_oPgDados.cmd_4c_BotFornecedor
1486:             .Caption       = "..."
1487:             .Top           = 382
1488:             .Left          = 266
1489:             .Width         = 32
1490:             .Height        = 22
1491:             .FontName      = "Tahoma"
1492:             .FontSize      = 8
1493:             .Themes        = .F.
1494:             .SpecialEffect = 0
1495:         ENDWITH
1496:         BINDEVENT(loc_oPgDados.cmd_4c_BotFornecedor, "Click", THIS, "BtnFornecedorClick")
1497: 
1498:         loc_oPgDados.AddObject("lbl_4c_LblObs2", "Label")
1499:         WITH loc_oPgDados.lbl_4c_LblObs2
1500:             .Caption   = "Complemento :"
1501:             .Top       = 373
1502:             .Left      = 551
1503:             .Width     = 74
1504:             .Height    = 15
1505:             .FontName  = "Tahoma"
1506:             .FontSize  = 8
1507:             .BackStyle = 0
1508:             .ForeColor = RGB(0, 0, 0)
1509:         ENDWITH
1510: 
1511:         loc_oPgDados.AddObject("txt_4c_Obs2", "TextBox")
1512:         WITH loc_oPgDados.txt_4c_Obs2
1513:             .Top      = 370
1514:             .Left     = 626
1515:             .Width    = 220
1516:             .Height   = 21
1517:             .FontName = "Tahoma"
1518:             .FontSize = 8
1519:             .Value    = ""
1520:         ENDWITH
1521: 
1522:         loc_oPgDados.AddObject("lbl_4c_LblDiam", "Label")
1523:         WITH loc_oPgDados.lbl_4c_LblDiam
1524:             .Caption   = "Di" + CHR(226) + "metro :"
1525:             .Top       = 376
1526:             .Left      = 867
1527:             .Width     = 52
1528:             .Height    = 15
1529:             .FontName  = "Tahoma"
1530:             .FontSize  = 8
1531:             .BackStyle = 0
1532:             .ForeColor = RGB(0, 0, 0)
1533:         ENDWITH
1534: 
1535:         loc_oPgDados.AddObject("txt_4c_Diametro", "TextBox")
1536:         WITH loc_oPgDados.txt_4c_Diametro

*-- Linhas 1604 a 1685:
1604:             .FontSize = 8
1605:             .Value    = ""
1606:         ENDWITH
1607:         BINDEVENT(loc_oPgDados.txt_4c_Cor, "KeyPress", THIS, "KeyPressCor")
1608: 
1609:         loc_oPgDados.AddObject("lbl_4c_LblTam", "Label")
1610:         WITH loc_oPgDados.lbl_4c_LblTam
1611:             .Caption   = "Tam:"
1612:             .Top       = 385
1613:             .Left      = 442
1614:             .Width     = 26
1615:             .Height    = 15
1616:             .FontName  = "Tahoma"
1617:             .FontSize  = 8
1618:             .BackStyle = 0
1619:             .ForeColor = RGB(0, 0, 0)
1620:         ENDWITH
1621: 
1622:         loc_oPgDados.AddObject("txt_4c_Tam", "TextBox")
1623:         WITH loc_oPgDados.txt_4c_Tam
1624:             .Top      = 381
1625:             .Left     = 474
1626:             .Width    = 38
1627:             .Height   = 23
1628:             .FontName = "Tahoma"
1629:             .FontSize = 8
1630:             .Value    = ""
1631:         ENDWITH
1632: 
1633:         loc_oPgDados.AddObject("cmd_4c_CmdTamanho", "CommandButton")
1634:         WITH loc_oPgDados.cmd_4c_CmdTamanho
1635:             .Caption       = "..."
1636:             .Top           = 377
1637:             .Left          = 513
1638:             .Width         = 32
1639:             .Height        = 29
1640:             .FontName      = "Tahoma"
1641:             .FontSize      = 8
1642:             .Themes        = .F.
1643:             .SpecialEffect = 0
1644:         ENDWITH
1645:         BINDEVENT(loc_oPgDados.cmd_4c_CmdTamanho, "Click", THIS, "BtnTamanhoClick")
1646: 
1647:         loc_oPgDados.AddObject("lbl_4c_LblUltCmp", "Label")
1648:         WITH loc_oPgDados.lbl_4c_LblUltCmp
1649:             .Caption   = CHR(218) + "lt.Compra :"
1650:             .Top       = 396
1651:             .Left      = 562
1652:             .Width     = 63
1653:             .Height    = 15
1654:             .FontName  = "Tahoma"
1655:             .FontSize  = 8
1656:             .BackStyle = 0
1657:             .ForeColor = RGB(0, 0, 0)
1658:         ENDWITH
1659: 
1660:         loc_oPgDados.AddObject("txt_4c__Dtucp", "TextBox")
1661:         WITH loc_oPgDados.txt_4c__Dtucp
1662:             .Top       = 392
1663:             .Left      = 626
1664:             .Width     = 79
1665:             .Height    = 21
1666:             .FontName  = "Tahoma"
1667:             .FontSize  = 8
1668:             .ReadOnly  = .T.
1669:             .BackColor = RGB(240, 240, 240)
1670:             .Value     = {}
1671:         ENDWITH
1672: 
1673:         loc_oPgDados.AddObject("txt_4c_Vucp", "TextBox")
1674:         WITH loc_oPgDados.txt_4c_Vucp
1675:             .Top       = 392
1676:             .Left      = 706
1677:             .Width     = 106
1678:             .Height    = 21
1679:             .FontName  = "Tahoma"
1680:             .FontSize  = 8
1681:             .ReadOnly  = .T.
1682:             .BackColor = RGB(240, 240, 240)
1683:             .Value     = 0
1684:         ENDWITH
1685: 

*-- Linhas 1757 a 1800:
1757:             .FontSize = 8
1758:             .Value    = ""
1759:         ENDWITH
1760:         BINDEVENT(loc_oPgDados.txt_4c_CodFinP, "KeyPress", THIS, "KeyPressModelo")
1761: 
1762:         loc_oPgDados.AddObject("txt_4c_DesFinP", "TextBox")
1763:         WITH loc_oPgDados.txt_4c_DesFinP
1764:             .Top       = 405
1765:             .Left      = 145
1766:             .Width     = 150
1767:             .Height    = 23
1768:             .FontName  = "Tahoma"
1769:             .FontSize  = 8
1770:             .ReadOnly  = .T.
1771:             .BackColor = RGB(240, 240, 240)
1772:             .Value     = ""
1773:         ENDWITH
1774: 
1775:         loc_oPgDados.AddObject("lbl_4c_LblPesoBruto", "Label")
1776:         WITH loc_oPgDados.lbl_4c_LblPesoBruto
1777:             .Caption   = "Peso Bruto :"
1778:             .Top       = 409
1779:             .Left      = 336
1780:             .Width     = 61
1781:             .Height    = 15
1782:             .FontName  = "Tahoma"
1783:             .FontSize  = 8
1784:             .BackStyle = 0
1785:             .ForeColor = RGB(0, 0, 0)
1786:         ENDWITH
1787: 
1788:         loc_oPgDados.AddObject("txt_4c_Peso", "TextBox")
1789:         WITH loc_oPgDados.txt_4c_Peso
1790:             .Top      = 405
1791:             .Left     = 401
1792:             .Width    = 111
1793:             .Height   = 23
1794:             .FontName = "Tahoma"
1795:             .FontSize = 8
1796:             .Value    = 0
1797:         ENDWITH
1798: 
1799:         loc_oPgDados.AddObject("lbl_4c_LblQtdUltCmp", "Label")
1800:         WITH loc_oPgDados.lbl_4c_LblQtdUltCmp

*-- Linhas 1886 a 1929:
1886:             .FontSize = 8
1887:             .Value    = ""
1888:         ENDWITH
1889:         BINDEVENT(loc_oPgDados.txt_4c__codacb, "KeyPress", THIS, "KeyPressAcabamento")
1890: 
1891:         loc_oPgDados.AddObject("txt_4c__Dacb", "TextBox")
1892:         WITH loc_oPgDados.txt_4c__Dacb
1893:             .Top       = 429
1894:             .Left      = 145
1895:             .Width     = 150
1896:             .Height    = 23
1897:             .FontName  = "Tahoma"
1898:             .FontSize  = 8
1899:             .ReadOnly  = .T.
1900:             .BackColor = RGB(240, 240, 240)
1901:             .Value     = ""
1902:         ENDWITH
1903: 
1904:         loc_oPgDados.AddObject("lbl_4c_Label34", "Label")
1905:         WITH loc_oPgDados.lbl_4c_Label34
1906:             .Caption   = "Peso L" + CHR(237) + "quido :"
1907:             .Top       = 433
1908:             .Left      = 329
1909:             .Width     = 68
1910:             .Height    = 15
1911:             .FontName  = "Tahoma"
1912:             .FontSize  = 8
1913:             .BackStyle = 0
1914:             .ForeColor = RGB(0, 0, 0)
1915:         ENDWITH
1916: 
1917:         loc_oPgDados.AddObject("txt_4c_Pmedio", "TextBox")
1918:         WITH loc_oPgDados.txt_4c_Pmedio
1919:             .Top      = 429
1920:             .Left     = 401
1921:             .Width    = 111
1922:             .Height   = 23
1923:             .FontName = "Tahoma"
1924:             .FontSize = 8
1925:             .Value    = 0
1926:         ENDWITH
1927: 
1928:         loc_oPgDados.AddObject("lbl_4c_Label28", "Label")
1929:         WITH loc_oPgDados.lbl_4c_Label28

*-- Linhas 2015 a 2096:
2015:             .FontSize = 8
2016:             .Value    = ""
2017:         ENDWITH
2018:         BINDEVENT(loc_oPgDados.txt_4c_Class, "KeyPress", THIS, "KeyPressClassificacao")
2019: 
2020:         loc_oPgDados.AddObject("txt_4c_DClass", "TextBox")
2021:         WITH loc_oPgDados.txt_4c_DClass
2022:             .Top       = 453
2023:             .Left      = 145
2024:             .Width     = 150
2025:             .Height    = 23
2026:             .FontName  = "Tahoma"
2027:             .FontSize  = 8
2028:             .ReadOnly  = .T.
2029:             .BackColor = RGB(240, 240, 240)
2030:             .Value     = ""
2031:         ENDWITH
2032: 
2033:         loc_oPgDados.AddObject("lbl_4c_Label5", "Label")
2034:         WITH loc_oPgDados.lbl_4c_Label5
2035:             .Caption   = "Local :"
2036:             .Top       = 457
2037:             .Left      = 364
2038:             .Width     = 33
2039:             .Height    = 15
2040:             .FontName  = "Tahoma"
2041:             .FontSize  = 8
2042:             .BackStyle = 0
2043:             .ForeColor = RGB(0, 0, 0)
2044:         ENDWITH
2045: 
2046:         loc_oPgDados.AddObject("txt_4c_Local", "TextBox")
2047:         WITH loc_oPgDados.txt_4c_Local
2048:             .Top      = 453
2049:             .Left     = 401
2050:             .Width    = 111
2051:             .Height   = 23
2052:             .FontName = "Tahoma"
2053:             .FontSize = 8
2054:             .Value    = ""
2055:         ENDWITH
2056:         BINDEVENT(loc_oPgDados.txt_4c_Local, "KeyPress", THIS, "KeyPressLocal")
2057: 
2058:         loc_oPgDados.AddObject("lbl_4c_Label3", "Label")
2059:         WITH loc_oPgDados.lbl_4c_Label3
2060:             .Caption   = "Valor de Custo :"
2061:             .Top       = 462
2062:             .Left      = 546
2063:             .Width     = 79
2064:             .Height    = 15
2065:             .FontName  = "Tahoma"
2066:             .FontSize  = 8
2067:             .BackStyle = 0
2068:             .ForeColor = RGB(0, 0, 0)
2069:         ENDWITH
2070: 
2071:         loc_oPgDados.AddObject("txt_4c_Ctotal", "TextBox")
2072:         WITH loc_oPgDados.txt_4c_Ctotal
2073:             .Top       = 458
2074:             .Left      = 626
2075:             .Width     = 127
2076:             .Height    = 21
2077:             .FontName  = "Tahoma"
2078:             .FontSize  = 8
2079:             .ReadOnly  = .T.
2080:             .BackColor = RGB(240, 240, 240)
2081:             .Value     = 0
2082:         ENDWITH
2083: 
2084:         loc_oPgDados.AddObject("txt_4c_Mctotal", "TextBox")
2085:         WITH loc_oPgDados.txt_4c_Mctotal
2086:             .Top       = 458
2087:             .Left      = 754
2088:             .Width     = 31
2089:             .Height    = 21
2090:             .FontName  = "Tahoma"
2091:             .FontSize  = 8
2092:             .ReadOnly  = .T.
2093:             .BackColor = RGB(240, 240, 240)
2094:             .Value     = ""
2095:         ENDWITH
2096: 

*-- Linhas 2153 a 2234:
2153:             .FontSize = 8
2154:             .Value    = ""
2155:         ENDWITH
2156:         BINDEVENT(loc_oPgDados.txt_4c_Cuni, "KeyPress", THIS, "KeyPressUnidade")
2157: 
2158:         loc_oPgDados.AddObject("txt_4c_Duni", "TextBox")
2159:         WITH loc_oPgDados.txt_4c_Duni
2160:             .Top       = 477
2161:             .Left      = 145
2162:             .Width     = 150
2163:             .Height    = 23
2164:             .FontName  = "Tahoma"
2165:             .FontSize  = 8
2166:             .ReadOnly  = .T.
2167:             .BackColor = RGB(240, 240, 240)
2168:             .Value     = ""
2169:         ENDWITH
2170: 
2171:         loc_oPgDados.AddObject("lbl_4c_Label18", "Label")
2172:         WITH loc_oPgDados.lbl_4c_Label18
2173:             .Caption   = "(2) :"
2174:             .Top       = 481
2175:             .Left      = 301
2176:             .Width     = 23
2177:             .Height    = 15
2178:             .FontName  = "Tahoma"
2179:             .FontSize  = 8
2180:             .BackStyle = 0
2181:             .ForeColor = RGB(0, 0, 0)
2182:         ENDWITH
2183: 
2184:         loc_oPgDados.AddObject("txt_4c_Cunip", "TextBox")
2185:         WITH loc_oPgDados.txt_4c_Cunip
2186:             .Top      = 477
2187:             .Left     = 330
2188:             .Width    = 31
2189:             .Height   = 23
2190:             .FontName = "Tahoma"
2191:             .FontSize = 8
2192:             .Value    = ""
2193:         ENDWITH
2194:         BINDEVENT(loc_oPgDados.txt_4c_Cunip, "KeyPress", THIS, "KeyPressUnidade2")
2195: 
2196:         loc_oPgDados.AddObject("txt_4c__dunip", "TextBox")
2197:         WITH loc_oPgDados.txt_4c__dunip
2198:             .Top       = 477
2199:             .Left      = 362
2200:             .Width     = 150
2201:             .Height    = 23
2202:             .FontName  = "Tahoma"
2203:             .FontSize  = 8
2204:             .ReadOnly  = .T.
2205:             .BackColor = RGB(240, 240, 240)
2206:             .Value     = ""
2207:         ENDWITH
2208: 
2209:         loc_oPgDados.AddObject("txt_4c_DtIncs", "TextBox")
2210:         WITH loc_oPgDados.txt_4c_DtIncs
2211:             .Top       = 480
2212:             .Left      = 833
2213:             .Width     = 79
2214:             .Height    = 21
2215:             .FontName  = "Tahoma"
2216:             .FontSize  = 8
2217:             .ReadOnly  = .T.
2218:             .BackColor = RGB(240, 240, 240)
2219:             .Value     = {}
2220:         ENDWITH
2221: 
2222:         loc_oPgDados.AddObject("txt_4c_DataAlts", "TextBox")
2223:         WITH loc_oPgDados.txt_4c_DataAlts
2224:             .Top       = 480
2225:             .Left      = 914
2226:             .Width     = 79
2227:             .Height    = 21
2228:             .FontName  = "Tahoma"
2229:             .FontSize  = 8
2230:             .ReadOnly  = .T.
2231:             .BackColor = RGB(240, 240, 240)
2232:             .Value     = {}
2233:         ENDWITH
2234: 

*-- Linhas 2490 a 2544:
2490:             .BackStyle = 0
2491:             .ForeColor = RGB(0, 0, 0)
2492:         ENDWITH
2493: 
2494:         *-- === Dimensoes / Volumes (form-abs 470-474 -> 553-557) ===
2495:         loc_oPgDados.AddObject("txt_4c_Fwget6", "TextBox")
2496:         WITH loc_oPgDados.txt_4c_Fwget6
2497:             .Top      = 553
2498:             .Left     = 601
2499:             .Width    = 58
2500:             .Height   = 23
2501:             .FontName = "Tahoma"
2502:             .FontSize = 8
2503:             .Value    = 0
2504:         ENDWITH
2505: 
2506:         loc_oPgDados.AddObject("txt_4c_Fwget5", "TextBox")
2507:         WITH loc_oPgDados.txt_4c_Fwget5
2508:             .Top      = 553
2509:             .Left     = 688
2510:             .Width    = 58
2511:             .Height   = 23
2512:             .FontName = "Tahoma"
2513:             .FontSize = 8
2514:             .Value    = 0
2515:         ENDWITH
2516: 
2517:         loc_oPgDados.AddObject("txt_4c_Fwget4", "TextBox")
2518:         WITH loc_oPgDados.txt_4c_Fwget4
2519:             .Top      = 553
2520:             .Left     = 776
2521:             .Width    = 58
2522:             .Height   = 23
2523:             .FontName = "Tahoma"
2524:             .FontSize = 8
2525:             .Value    = 0
2526:         ENDWITH
2527: 
2528:         loc_oPgDados.AddObject("txt_4c_Fwget3", "TextBox")
2529:         WITH loc_oPgDados.txt_4c_Fwget3
2530:             .Top      = 553
2531:             .Left     = 934
2532:             .Width    = 31
2533:             .Height   = 23
2534:             .FontName = "Tahoma"
2535:             .FontSize = 8
2536:             .Value    = 0
2537:         ENDWITH
2538: 
2539:         loc_oPgDados.AddObject("lbl_4c_Label27", "Label")
2540:         WITH loc_oPgDados.lbl_4c_Label27
2541:             .Caption   = "Dimens" + CHR(227) + "o :"
2542:             .Top       = 557
2543:             .Left      = 543
2544:             .Width     = 55

*-- Linhas 2782 a 2825:
2782:     * Colunas: cpros(100), dpros(260), cgrus(70), sgrus(80), reffs(180),
2783:     *          usuaalts(100), chkInstalas(40)
2784:     *--------------------------------------------------------------------------
2785:     PROCEDURE CarregarLista()
2786:         LOCAL loc_oGrid, loc_oFiltros, loc_cFiltro, loc_nSituas
2787:         LOCAL loc_cCgru, loc_dDtIni, loc_dDtFim, loc_lSucesso
2788:         loc_lSucesso = .F.
2789: 
2790:         TRY
2791:             loc_oGrid    = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
2792:             loc_oFiltros = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros
2793: 
2794:             *-- Ler valores do filtro
2795:             loc_cCgru   = ALLTRIM(loc_oFiltros.txt_4c_Cgru.Value)
2796:             loc_nSituas = loc_oFiltros.opt_4c_Situas.Value
2797:             loc_dDtIni  = loc_oFiltros.txt_4c_DtIni.Value
2798:             loc_dDtFim  = loc_oFiltros.txt_4c_DtFim.Value
2799: 
2800:             *-- Montar WHERE clause
2801:             loc_cFiltro = "1=1"
2802: 
2803:             IF !EMPTY(loc_cCgru)
2804:                 loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
2805:             ENDIF
2806: 
2807:             IF loc_nSituas = 2
2808:                 loc_cFiltro = loc_cFiltro + " AND situas = 1"
2809:             ELSE
2810:                 IF loc_nSituas = 3
2811:                     loc_cFiltro = loc_cFiltro + " AND situas = 0"
2812:                 ENDIF
2813:             ENDIF
2814: 
2815:             IF VARTYPE(loc_dDtIni) = "D" AND !EMPTY(loc_dDtIni)
2816:                 loc_cFiltro = loc_cFiltro + " AND DataAlts >= " + FormatarDataSQL(loc_dDtIni)
2817:             ENDIF
2818: 
2819:             IF VARTYPE(loc_dDtFim) = "D" AND !EMPTY(loc_dDtFim)
2820:                 loc_cFiltro = loc_cFiltro + " AND DataAlts <= " + FormatarDataSQL(loc_dDtFim)
2821:             ENDIF
2822: 
2823:             *-- Buscar dados via BO
2824:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2825:                 loc_lSucesso = .F.

*-- Linhas 2865 a 3074:
2865:     ENDPROC
2866: 
2867:     *--------------------------------------------------------------------------
2868:     * TornarControlesVisiveis - Torna visiveis apenas controles esperados
2869:     * IMPORTANTE: Filtrar por nome para nao tornar containers flutuantes visiveis
2870:     *--------------------------------------------------------------------------
2871:     PROCEDURE TornarControlesVisiveis(par_oPagina)
2872:         LOCAL loc_i
2873:         FOR loc_i = 1 TO par_oPagina.ControlCount
2874:             IF SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "cnt_" OR ;
2875:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "grd_" OR ;
2876:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "lbl_" OR ;
2877:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "txt_" OR ;
2878:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "cmd_" OR ;
2879:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "pgf_" OR ;
2880:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "opt_" OR ;
2881:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "chk_" OR ;
2882:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "edt_" OR ;
2883:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "shp_" OR ;
2884:                SUBSTR(par_oPagina.Controls(loc_i).Name, 1, 4) = "img_"
2885:                 par_oPagina.Controls(loc_i).Visible = .T.
2886:             ENDIF
2887:         ENDFOR
2888:     ENDPROC
2889: 
2890:     *--------------------------------------------------------------------------
2891:     * FormatarGridLista - Formata visual do grid da lista
2892:     *--------------------------------------------------------------------------
2893:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2894:         WITH par_oGrid
2895:             IF .ColumnCount > 0
2896:                 .FontName = "Tahoma"
2897:                 .FontSize = 8
2898:             ENDIF
2899:         ENDWITH
2900:     ENDPROC
2901: 
2902:     *--------------------------------------------------------------------------
2903:     * OptSituasChange - Recarrega lista ao mudar situacao (BINDEVENT)
2904:     *--------------------------------------------------------------------------
2905:     PROCEDURE OptSituasChange()
2906:         THIS.CarregarLista()
2907:     ENDPROC
2908: 
2909:     *--------------------------------------------------------------------------
2910:     * BtnIncluirClick - Incluir novo produto
2911:     *--------------------------------------------------------------------------
2912:     PROCEDURE BtnIncluirClick()
2913:         THIS.this_oBusinessObject.NovoRegistro()
2914:         THIS.LimparCampos()
2915:         THIS.this_cModoAtual = "INCLUIR"
2916:         THIS.HabilitarCampos(.T.)
2917:         THIS.AjustarBotoesPorModo()
2918:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
2919:         THIS.AlternarPagina(2)
2920:     ENDPROC
2921: 
2922:     *--------------------------------------------------------------------------
2923:     * BtnVisualizarClick - Visualizar produto selecionado
2924:     *--------------------------------------------------------------------------
2925:     PROCEDURE BtnVisualizarClick()
2926:         LOCAL loc_cCpros
2927:         loc_cCpros = ""
2928: 
2929:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2930:             MsgAviso("Nenhum produto selecionado!")
2931:             RETURN
2932:         ENDIF
2933: 
2934:         loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
2935: 
2936:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
2937:             THIS.BOParaForm()
2938:             THIS.this_cModoAtual = "VISUALIZAR"
2939:             THIS.HabilitarCampos(.F.)
2940:             THIS.AjustarBotoesPorModo()
2941:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
2942:             THIS.AlternarPagina(2)
2943:         ENDIF
2944:     ENDPROC
2945: 
2946:     *--------------------------------------------------------------------------
2947:     * BtnAlterarClick - Alterar produto selecionado
2948:     *--------------------------------------------------------------------------
2949:     PROCEDURE BtnAlterarClick()
2950:         LOCAL loc_cCpros
2951:         loc_cCpros = ""
2952: 
2953:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2954:             MsgAviso("Nenhum produto selecionado!")
2955:             RETURN
2956:         ENDIF
2957: 
2958:         loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
2959: 
2960:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
2961:             THIS.this_oBusinessObject.EditarRegistro()
2962:             THIS.BOParaForm()
2963:             THIS.this_cModoAtual = "ALTERAR"
2964:             THIS.HabilitarCampos(.T.)
2965:             THIS.AjustarBotoesPorModo()
2966:             THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = 1
2967:             THIS.AlternarPagina(2)
2968:         ENDIF
2969:     ENDPROC
2970: 
2971:     *--------------------------------------------------------------------------
2972:     * BtnExcluirClick - Excluir produto selecionado
2973:     *--------------------------------------------------------------------------
2974:     PROCEDURE BtnExcluirClick()
2975:         LOCAL loc_cCpros
2976:         loc_cCpros = ""
2977: 
2978:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2979:             MsgAviso("Nenhum produto selecionado!")
2980:             RETURN
2981:         ENDIF
2982: 
2983:         loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
2984: 
2985:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCpros + "'?")
2986:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCpros)
2987:                 IF THIS.this_oBusinessObject.Excluir()
2988:                     MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
2989:                     THIS.CarregarLista()
2990:                 ELSE
2991:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao excluir")
2992:                 ENDIF
2993:             ENDIF
2994:         ENDIF
2995:     ENDPROC
2996: 
2997:     *--------------------------------------------------------------------------
2998:     * BtnBuscarClick - Aplicar filtro e recarregar lista
2999:     *--------------------------------------------------------------------------
3000:     PROCEDURE BtnBuscarClick()
3001:         THIS.CarregarLista()
3002:     ENDPROC
3003: 
3004:     *--------------------------------------------------------------------------
3005:     * BtnEncerrarClick - Fechar formulario
3006:     *--------------------------------------------------------------------------
3007:     PROCEDURE BtnEncerrarClick()
3008:         THIS.Release()
3009:     ENDPROC
3010: 
3011:     *--------------------------------------------------------------------------
3012:     * BOParaForm - Transfere dados do BO para os campos da pgDados (Phase 5)
3013:     *--------------------------------------------------------------------------
3014:     PROTECTED PROCEDURE BOParaForm()
3015:         LOCAL loc_oPgDados, loc_oBO
3016:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3017:         loc_oBO      = THIS.this_oBusinessObject
3018: 
3019:         TRY
3020:             loc_oPgDados.txt_4c_Cpro.Value     = ALLTRIM(loc_oBO.this_cCpros)
3021:             loc_oPgDados.txt_4c_Dgru.Value     = ALLTRIM(loc_oBO.this_cDgrus)
3022:             loc_oPgDados.txt_4c_Cgru.Value     = ALLTRIM(loc_oBO.this_cCgrus)
3023:             loc_oPgDados.txt_4c_Dpro.Value     = ALLTRIM(loc_oBO.this_cDpros)
3024:             loc_oPgDados.txt_4c_DPro2s.Value   = ALLTRIM(loc_oBO.this_cDpro2s)
3025:             loc_oPgDados.txt_4c_CSGru.Value    = ALLTRIM(loc_oBO.this_cCSGrus)
3026:             loc_oPgDados.txt_4c_DsGru.Value    = ALLTRIM(loc_oBO.this_cDsGrus)
3027:             loc_oPgDados.txt_4c_Lin.Value      = ALLTRIM(loc_oBO.this_cLins)
3028:             loc_oPgDados.txt_4c_DLin.Value     = ALLTRIM(loc_oBO.this_cDLins)
3029:             loc_oPgDados.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCols)
3030:             loc_oPgDados.txt_4c_DCol.Value     = ALLTRIM(loc_oBO.this_cDCols)
3031:             loc_oPgDados.txt_4c_Ifor.Value     = loc_oBO.this_nIfor
3032:             loc_oPgDados.txt_4c_Dfor.Value     = ALLTRIM(loc_oBO.this_cDfor)
3033:             loc_oPgDados.txt_4c_Refs.Value     = ALLTRIM(loc_oBO.this_cReffs)
3034:             loc_oPgDados.txt_4c_Cbar.Value     = ALLTRIM(loc_oBO.this_cCbars)
3035:             loc_oPgDados.txt_4c_EAN13.Value    = ALLTRIM(loc_oBO.this_cEAN13s)
3036:             loc_oPgDados.txt_4c_CProEq.Value   = ALLTRIM(loc_oBO.this_cCProEqs)
3037:             loc_oPgDados.txt_4c_Merc.Value     = ALLTRIM(loc_oBO.this_cMercs)
3038:             loc_oPgDados.txt_4c_IdeCPros.Value = ALLTRIM(loc_oBO.this_cIdeCPros)
3039:             loc_oPgDados.txt_4c_Qmin.Value     = loc_oBO.this_nQmins
3040:             loc_oPgDados.txt_4c_QtPed.Value    = loc_oBO.this_nQtPeds
3041:             loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(loc_oBO.this_cConjuntos)
3042:             loc_oPgDados.txt_4c_DiasGar.Value  = loc_oBO.this_nDiasGar
3043:             loc_oPgDados.chk_4c_ChkGarVit.Value = IIF(loc_oBO.this_nChkGarVit = 1, 1, 0)
3044:             loc_oPgDados.txt_4c_Obs1.Value     = ALLTRIM(loc_oBO.this_cObs1s)
3045:             loc_oPgDados.txt_4c_Obs2.Value     = ALLTRIM(loc_oBO.this_cObs2s)
3046:             loc_oPgDados.txt_4c_Obs3.Value     = ALLTRIM(loc_oBO.this_cObs3s)
3047:             loc_oPgDados.txt_4c_Cor.Value      = ALLTRIM(loc_oBO.this_cCors)
3048:             loc_oPgDados.txt_4c_Tam.Value      = ALLTRIM(loc_oBO.this_cTams)
3049:             loc_oPgDados.txt_4c_LtMinsV.Value  = loc_oBO.this_nLtMinsV
3050:             loc_oPgDados.txt_4c_Peso.Value     = loc_oBO.this_nPesoBs
3051:             loc_oPgDados.txt_4c_CodFinP.Value  = ALLTRIM(loc_oBO.this_cCodFinP)
3052:             loc_oPgDados.txt_4c_DesFinP.Value  = ALLTRIM(loc_oBO.this_cDesFinP)
3053:             loc_oPgDados.txt_4c_Altura.Value   = loc_oBO.this_nAltura
3054:             loc_oPgDados.txt_4c_Largura.Value  = loc_oBO.this_nLargura
3055:             loc_oPgDados.txt_4c_Diametro.Value = loc_oBO.this_nDiametro
3056:             loc_oPgDados.txt_4c_Espessura.Value= loc_oBO.this_nEspessura
3057:             loc_oPgDados.opt_4c_Situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
3058:             loc_oPgDados.opt_4c_ProdutoWeb.Value = IIF(loc_oBO.this_nProdWeb >= 1, loc_oBO.this_nProdWeb, 1)
3059:             loc_oPgDados.opt_4c_Variacao.Value = IIF(loc_oBO.this_nVariacao >= 1, loc_oBO.this_nVariacao, 1)
3060:             *-- Fase 6
3061:             loc_oPgDados.txt_4c_Compriment.Value   = loc_oBO.this_nCompriment
3062:             loc_oPgDados.txt_4c__codacb.Value       = ALLTRIM(loc_oBO.this_c_codacb)
3063:             loc_oPgDados.txt_4c__Dacb.Value         = ALLTRIM(loc_oBO.this_c_Dacb)
3064:             loc_oPgDados.txt_4c_Pmedio.Value        = loc_oBO.this_nPmedio
3065:             loc_oPgDados.txt_4c_Class.Value         = ALLTRIM(loc_oBO.this_cClass)
3066:             loc_oPgDados.txt_4c_DClass.Value        = ALLTRIM(loc_oBO.this_cDClass)
3067:             loc_oPgDados.txt_4c_Local.Value         = ALLTRIM(loc_oBO.this_cLocal)
3068:             loc_oPgDados.txt_4c_Cuni.Value          = ALLTRIM(loc_oBO.this_cCuni)
3069:             loc_oPgDados.txt_4c_Duni.Value          = ALLTRIM(loc_oBO.this_cDuni)
3070:             loc_oPgDados.txt_4c_Cunip.Value         = ALLTRIM(loc_oBO.this_cCunip)
3071:             loc_oPgDados.txt_4c__dunip.Value        = ALLTRIM(loc_oBO.this_c_dunip)
3072:             loc_oPgDados.txt_4c_DtIncs.Value        = loc_oBO.this_dDtIncs
3073:             loc_oPgDados.txt_4c_DataAlts.Value      = loc_oBO.this_dDataAlts
3074:             loc_oPgDados.txt_4c_Pvenda.Value        = loc_oBO.this_nPvenda

*-- Linhas 3081 a 3239:
3081:             loc_oPgDados.txt_4c_TEnts.Value         = loc_oBO.this_nTEnts
3082:             loc_oPgDados.edt_4c_DscCompras.Value    = loc_oBO.this_cDscCompras
3083:             loc_oPgDados.chk_4c_Get_Consig.Value    = IIF(loc_oBO.this_nConsig = 1, 1, 0)
3084:             loc_oPgDados.chk_4c_ChkFabrProprs.Value = IIF(loc_oBO.this_nFabrProprs = 1, 1, 0)
3085:             loc_oPgDados.chk_4c_ChkEncoms.Value     = IIF(loc_oBO.this_nEncoms = 1, 1, 0)
3086:             loc_oPgDados.txt_4c_Fwget6.Value        = loc_oBO.this_nFwget6
3087:             loc_oPgDados.txt_4c_Fwget5.Value        = loc_oBO.this_nFwget5
3088:             loc_oPgDados.txt_4c_Fwget4.Value        = loc_oBO.this_nFwget4
3089:             loc_oPgDados.txt_4c_Fwget3.Value        = loc_oBO.this_nFwget3
3090:             loc_oPgDados.edt_4c_DPro3s.Value        = loc_oBO.this_cDPro3s
3091:             loc_oPgDados.edt_4c_ObsCompras.Value    = loc_oBO.this_cObsCompras
3092:             *-- Campos somente-leitura (exibicao)
3093:             loc_oPgDados.txt_4c_DtSituas.Value      = loc_oBO.this_dDtSituas
3094:             loc_oPgDados.txt_4c_Estoques.Value      = TRANSFORM(loc_oBO.this_nEstoques)
3095:             loc_oPgDados.txt_4c_QtdEsts.Value       = loc_oBO.this_nQtdEsts
3096:             loc_oPgDados.txt_4c_Ctotal.Value        = loc_oBO.this_nCtotal
3097:             loc_oPgDados.txt_4c_Mctotal.Value       = ALLTRIM(loc_oBO.this_cMctotal)
3098:         CATCH TO loc_oErro
3099:             MsgErro("Erro ao carregar campos:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro BOParaForm")
3100:         ENDTRY
3101:     ENDPROC
3102: 
3103:     *--------------------------------------------------------------------------
3104:     * FormParaBO - Transfere dados dos campos (pgDados) para o BO
3105:     *--------------------------------------------------------------------------
3106:     PROTECTED PROCEDURE FormParaBO()
3107:         LOCAL loc_oPgDados, loc_oBO
3108:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3109:         loc_oBO      = THIS.this_oBusinessObject
3110: 
3111:         TRY
3112:             loc_oBO.this_cCpros    = ALLTRIM(loc_oPgDados.txt_4c_Cpro.Value)
3113:             loc_oBO.this_cDpros    = ALLTRIM(loc_oPgDados.txt_4c_Dpro.Value)
3114:             loc_oBO.this_cDpro2s   = ALLTRIM(loc_oPgDados.txt_4c_DPro2s.Value)
3115:             loc_oBO.this_cCgrus    = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
3116:             loc_oBO.this_cDgrus    = ALLTRIM(loc_oPgDados.txt_4c_Dgru.Value)
3117:             loc_oBO.this_cCSGrus   = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
3118:             loc_oBO.this_cDsGrus   = ALLTRIM(loc_oPgDados.txt_4c_DsGru.Value)
3119:             loc_oBO.this_cLins     = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
3120:             loc_oBO.this_cDLins    = ALLTRIM(loc_oPgDados.txt_4c_DLin.Value)
3121:             loc_oBO.this_cCols     = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
3122:             loc_oBO.this_cDCols    = ALLTRIM(loc_oPgDados.txt_4c_DCol.Value)
3123:             loc_oBO.this_nIfor     = loc_oPgDados.txt_4c_Ifor.Value
3124:             loc_oBO.this_cDfor     = ALLTRIM(loc_oPgDados.txt_4c_Dfor.Value)
3125:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPgDados.txt_4c_Refs.Value)
3126:             loc_oBO.this_cCbars    = ALLTRIM(loc_oPgDados.txt_4c_Cbar.Value)
3127:             loc_oBO.this_cEAN13s   = ALLTRIM(loc_oPgDados.txt_4c_EAN13.Value)
3128:             loc_oBO.this_cCProEqs  = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
3129:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPgDados.txt_4c_Merc.Value)
3130:             loc_oBO.this_cIdeCPros = ALLTRIM(loc_oPgDados.txt_4c_IdeCPros.Value)
3131:             loc_oBO.this_nQmins    = loc_oPgDados.txt_4c_Qmin.Value
3132:             loc_oBO.this_nQtPeds   = loc_oPgDados.txt_4c_QtPed.Value
3133:             loc_oBO.this_cConjuntos = ALLTRIM(loc_oPgDados.txt_4c_Conjunto.Value)
3134:             loc_oBO.this_nDiasGar  = loc_oPgDados.txt_4c_DiasGar.Value
3135:             loc_oBO.this_nChkGarVit = loc_oPgDados.chk_4c_ChkGarVit.Value
3136:             loc_oBO.this_cObs1s    = ALLTRIM(loc_oPgDados.txt_4c_Obs1.Value)
3137:             loc_oBO.this_cObs2s    = ALLTRIM(loc_oPgDados.txt_4c_Obs2.Value)
3138:             loc_oBO.this_cObs3s    = ALLTRIM(loc_oPgDados.txt_4c_Obs3.Value)
3139:             loc_oBO.this_cCors     = ALLTRIM(loc_oPgDados.txt_4c_Cor.Value)
3140:             loc_oBO.this_cTams     = ALLTRIM(loc_oPgDados.txt_4c_Tam.Value)
3141:             loc_oBO.this_nLtMinsV  = loc_oPgDados.txt_4c_LtMinsV.Value
3142:             loc_oBO.this_nPesoBs   = loc_oPgDados.txt_4c_Peso.Value
3143:             loc_oBO.this_cCodFinP  = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
3144:             loc_oBO.this_cDesFinP  = ALLTRIM(loc_oPgDados.txt_4c_DesFinP.Value)
3145:             loc_oBO.this_nAltura   = loc_oPgDados.txt_4c_Altura.Value
3146:             loc_oBO.this_nLargura  = loc_oPgDados.txt_4c_Largura.Value
3147:             loc_oBO.this_nDiametro = loc_oPgDados.txt_4c_Diametro.Value
3148:             loc_oBO.this_nEspessura= loc_oPgDados.txt_4c_Espessura.Value
3149:             loc_oBO.this_nSituas   = IIF(loc_oPgDados.opt_4c_Situacao.Value = 1, 1, 0)
3150:             loc_oBO.this_nProdWeb  = loc_oPgDados.opt_4c_ProdutoWeb.Value
3151:             loc_oBO.this_nVariacao = loc_oPgDados.opt_4c_Variacao.Value
3152:             *-- Fase 6
3153:             loc_oBO.this_nCompriment  = loc_oPgDados.txt_4c_Compriment.Value
3154:             loc_oBO.this_c_codacb     = ALLTRIM(loc_oPgDados.txt_4c__codacb.Value)
3155:             loc_oBO.this_nPmedio      = loc_oPgDados.txt_4c_Pmedio.Value
3156:             loc_oBO.this_cClass       = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
3157:             loc_oBO.this_cLocal       = ALLTRIM(loc_oPgDados.txt_4c_Local.Value)
3158:             loc_oBO.this_cCuni        = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
3159:             loc_oBO.this_cCunip       = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
3160:             loc_oBO.this_cCodIdent    = ALLTRIM(loc_oPgDados.txt_4c_CodIdent.Value)
3161:             loc_oBO.this_nTEnts       = loc_oPgDados.txt_4c_TEnts.Value
3162:             loc_oBO.this_cDscCompras  = loc_oPgDados.edt_4c_DscCompras.Value
3163:             loc_oBO.this_nConsig      = loc_oPgDados.chk_4c_Get_Consig.Value
3164:             loc_oBO.this_nFabrProprs  = loc_oPgDados.chk_4c_ChkFabrProprs.Value
3165:             loc_oBO.this_nEncoms      = loc_oPgDados.chk_4c_ChkEncoms.Value
3166:             loc_oBO.this_nFwget6      = loc_oPgDados.txt_4c_Fwget6.Value
3167:             loc_oBO.this_nFwget5      = loc_oPgDados.txt_4c_Fwget5.Value
3168:             loc_oBO.this_nFwget4      = loc_oPgDados.txt_4c_Fwget4.Value
3169:             loc_oBO.this_nFwget3      = loc_oPgDados.txt_4c_Fwget3.Value
3170:             loc_oBO.this_cDPro3s      = loc_oPgDados.edt_4c_DPro3s.Value
3171:             loc_oBO.this_cObsCompras  = loc_oPgDados.edt_4c_ObsCompras.Value
3172:         CATCH TO loc_oErro
3173:             MsgErro("Erro ao salvar campos:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "Erro FormParaBO")
3174:         ENDTRY
3175:     ENDPROC
3176: 
3177:     *--------------------------------------------------------------------------
3178:     * LimparCampos - Limpa todos os campos da pgDados (Phase 5)
3179:     *--------------------------------------------------------------------------
3180:     PROTECTED PROCEDURE LimparCampos()
3181:         LOCAL loc_oPgDados
3182:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3183: 
3184:         TRY
3185:             loc_oPgDados.txt_4c_Cpro.Value      = ""
3186:             loc_oPgDados.txt_4c_Dpro.Value      = ""
3187:             loc_oPgDados.txt_4c_DPro2s.Value    = ""
3188:             loc_oPgDados.txt_4c_Cgru.Value      = ""
3189:             loc_oPgDados.txt_4c_Dgru.Value      = ""
3190:             loc_oPgDados.txt_4c_CSGru.Value     = ""
3191:             loc_oPgDados.txt_4c_DsGru.Value     = ""
3192:             loc_oPgDados.txt_4c_Lin.Value       = ""
3193:             loc_oPgDados.txt_4c_DLin.Value      = ""
3194:             loc_oPgDados.txt_4c_Col.Value       = ""
3195:             loc_oPgDados.txt_4c_DCol.Value      = ""
3196:             loc_oPgDados.txt_4c_Ifor.Value      = 0
3197:             loc_oPgDados.txt_4c_Dfor.Value      = ""
3198:             loc_oPgDados.txt_4c_Refs.Value      = ""
3199:             loc_oPgDados.txt_4c_Cbar.Value      = ""
3200:             loc_oPgDados.txt_4c_EAN13.Value     = ""
3201:             loc_oPgDados.txt_4c_CProEq.Value    = ""
3202:             loc_oPgDados.txt_4c_Merc.Value      = ""
3203:             loc_oPgDados.txt_4c_IdeCPros.Value  = ""
3204:             loc_oPgDados.txt_4c_Qmin.Value      = 0
3205:             loc_oPgDados.txt_4c_QtPed.Value     = 0
3206:             loc_oPgDados.txt_4c_Conjunto.Value  = ""
3207:             loc_oPgDados.txt_4c_DiasGar.Value   = 0
3208:             loc_oPgDados.chk_4c_ChkGarVit.Value = 0
3209:             loc_oPgDados.txt_4c_Obs1.Value      = ""
3210:             loc_oPgDados.txt_4c_Obs2.Value      = ""
3211:             loc_oPgDados.txt_4c_Obs3.Value      = ""
3212:             loc_oPgDados.txt_4c_Cor.Value       = ""
3213:             loc_oPgDados.txt_4c_Tam.Value       = ""
3214:             loc_oPgDados.txt_4c_LtMinsV.Value   = 0
3215:             loc_oPgDados.txt_4c_Peso.Value      = 0
3216:             loc_oPgDados.txt_4c_CodFinP.Value   = ""
3217:             loc_oPgDados.txt_4c_DesFinP.Value   = ""
3218:             loc_oPgDados.txt_4c_Altura.Value    = 0
3219:             loc_oPgDados.txt_4c_Largura.Value   = 0
3220:             loc_oPgDados.txt_4c_Diametro.Value  = 0
3221:             loc_oPgDados.txt_4c_Espessura.Value = 0
3222:             loc_oPgDados.opt_4c_Situacao.Value  = 1
3223:             loc_oPgDados.opt_4c_ProdutoWeb.Value = 1
3224:             loc_oPgDados.opt_4c_Variacao.Value  = 1
3225:             *-- Fase 6
3226:             loc_oPgDados.txt_4c_Compriment.Value   = 0
3227:             loc_oPgDados.txt_4c__codacb.Value       = ""
3228:             loc_oPgDados.txt_4c__Dacb.Value         = ""
3229:             loc_oPgDados.txt_4c_Pmedio.Value        = 0
3230:             loc_oPgDados.txt_4c_Class.Value         = ""
3231:             loc_oPgDados.txt_4c_DClass.Value        = ""
3232:             loc_oPgDados.txt_4c_Local.Value         = ""
3233:             loc_oPgDados.txt_4c_Cuni.Value          = ""
3234:             loc_oPgDados.txt_4c_Duni.Value          = ""
3235:             loc_oPgDados.txt_4c_Cunip.Value         = ""
3236:             loc_oPgDados.txt_4c__dunip.Value        = ""
3237:             loc_oPgDados.txt_4c_DtIncs.Value        = {}
3238:             loc_oPgDados.txt_4c_DataAlts.Value      = {}
3239:             loc_oPgDados.txt_4c_Pvenda.Value        = 0

*-- Linhas 3246 a 4071:
3246:             loc_oPgDados.txt_4c_TEnts.Value         = 0
3247:             loc_oPgDados.edt_4c_DscCompras.Value    = ""
3248:             loc_oPgDados.chk_4c_Get_Consig.Value    = 0
3249:             loc_oPgDados.chk_4c_ChkFabrProprs.Value = 0
3250:             loc_oPgDados.chk_4c_ChkEncoms.Value     = 0
3251:             loc_oPgDados.txt_4c_Fwget6.Value        = 0
3252:             loc_oPgDados.txt_4c_Fwget5.Value        = 0
3253:             loc_oPgDados.txt_4c_Fwget4.Value        = 0
3254:             loc_oPgDados.txt_4c_Fwget3.Value        = 0
3255:             loc_oPgDados.edt_4c_DPro3s.Value        = ""
3256:             loc_oPgDados.edt_4c_ObsCompras.Value    = ""
3257:             *-- Campos somente-leitura (exibicao)
3258:             loc_oPgDados.txt_4c_DtSituas.Value      = {}
3259:             loc_oPgDados.txt_4c__Dtucp.Value        = {}
3260:             loc_oPgDados.txt_4c_Vucp.Value          = 0
3261:             loc_oPgDados.txt_4c_Mucp.Value          = ""
3262:             loc_oPgDados.txt_4c_Qtdultcomp.Value    = 0
3263:             loc_oPgDados.txt_4c_Estoques.Value      = ""
3264:             loc_oPgDados.txt_4c_QtdEsts.Value       = 0
3265:             loc_oPgDados.txt_4c_Ctotal.Value        = 0
3266:             loc_oPgDados.txt_4c_Mctotal.Value       = ""
3267:         CATCH TO loc_oErro
3268:             MsgErro("Erro ao limpar campos:" + CHR(13) + loc_oErro.Message, "Erro LimparCampos")
3269:         ENDTRY
3270:     ENDPROC
3271: 
3272:     *--------------------------------------------------------------------------
3273:     * HabilitarCampos - Habilita/desabilita campos da pgDados (Phase 5)
3274:     *--------------------------------------------------------------------------
3275:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3276:         LOCAL loc_oPgDados
3277:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3278: 
3279:         TRY
3280:             loc_oPgDados.txt_4c_Cpro.Enabled      = par_lHabilitar
3281:             loc_oPgDados.txt_4c_Dpro.Enabled      = par_lHabilitar
3282:             loc_oPgDados.txt_4c_DPro2s.Enabled    = par_lHabilitar
3283:             loc_oPgDados.txt_4c_Cgru.Enabled      = par_lHabilitar
3284:             loc_oPgDados.txt_4c_CSGru.Enabled     = par_lHabilitar
3285:             loc_oPgDados.txt_4c_Lin.Enabled       = par_lHabilitar
3286:             loc_oPgDados.txt_4c_Col.Enabled       = par_lHabilitar
3287:             loc_oPgDados.txt_4c_Ifor.Enabled      = par_lHabilitar
3288:             loc_oPgDados.txt_4c_Refs.Enabled      = par_lHabilitar
3289:             loc_oPgDados.txt_4c_Cbar.Enabled      = par_lHabilitar
3290:             loc_oPgDados.txt_4c_EAN13.Enabled     = par_lHabilitar
3291:             loc_oPgDados.txt_4c_CProEq.Enabled    = par_lHabilitar
3292:             loc_oPgDados.txt_4c_Merc.Enabled      = par_lHabilitar
3293:             loc_oPgDados.txt_4c_IdeCPros.Enabled  = par_lHabilitar
3294:             loc_oPgDados.txt_4c_Qmin.Enabled      = par_lHabilitar
3295:             loc_oPgDados.txt_4c_QtPed.Enabled     = par_lHabilitar
3296:             loc_oPgDados.txt_4c_Conjunto.Enabled  = par_lHabilitar
3297:             loc_oPgDados.txt_4c_DiasGar.Enabled   = par_lHabilitar
3298:             loc_oPgDados.chk_4c_ChkGarVit.Enabled = par_lHabilitar
3299:             loc_oPgDados.txt_4c_Obs1.Enabled      = par_lHabilitar
3300:             loc_oPgDados.txt_4c_Obs2.Enabled      = par_lHabilitar
3301:             loc_oPgDados.txt_4c_Obs3.Enabled      = par_lHabilitar
3302:             loc_oPgDados.txt_4c_Cor.Enabled       = par_lHabilitar
3303:             loc_oPgDados.txt_4c_Tam.Enabled       = par_lHabilitar
3304:             loc_oPgDados.txt_4c_LtMinsV.Enabled   = par_lHabilitar
3305:             loc_oPgDados.txt_4c_Peso.Enabled      = par_lHabilitar
3306:             loc_oPgDados.txt_4c_CodFinP.Enabled   = par_lHabilitar
3307:             loc_oPgDados.txt_4c_Altura.Enabled    = par_lHabilitar
3308:             loc_oPgDados.txt_4c_Largura.Enabled   = par_lHabilitar
3309:             loc_oPgDados.txt_4c_Diametro.Enabled  = par_lHabilitar
3310:             loc_oPgDados.txt_4c_Espessura.Enabled = par_lHabilitar
3311:             loc_oPgDados.opt_4c_Situacao.Enabled  = par_lHabilitar
3312:             loc_oPgDados.cmd_4c_BotFornecedor.Enabled = par_lHabilitar
3313:             loc_oPgDados.cmd_4c_CmdQtMin.Enabled  = par_lHabilitar
3314:             loc_oPgDados.cmd_4c_CmdTamanho.Enabled = par_lHabilitar
3315:             *-- Fase 6
3316:             loc_oPgDados.txt_4c_Compriment.Enabled   = par_lHabilitar
3317:             loc_oPgDados.txt_4c__codacb.Enabled       = par_lHabilitar
3318:             loc_oPgDados.txt_4c_Pmedio.Enabled        = par_lHabilitar
3319:             loc_oPgDados.txt_4c_Class.Enabled         = par_lHabilitar
3320:             loc_oPgDados.txt_4c_Local.Enabled         = par_lHabilitar
3321:             loc_oPgDados.txt_4c_Cuni.Enabled          = par_lHabilitar
3322:             loc_oPgDados.txt_4c_Cunip.Enabled         = par_lHabilitar
3323:             loc_oPgDados.txt_4c_CodIdent.Enabled      = par_lHabilitar
3324:             loc_oPgDados.txt_4c_TEnts.Enabled         = par_lHabilitar
3325:             loc_oPgDados.edt_4c_DscCompras.Enabled    = par_lHabilitar
3326:             loc_oPgDados.chk_4c_Get_Consig.Enabled    = par_lHabilitar
3327:             loc_oPgDados.chk_4c_ChkFabrProprs.Enabled = par_lHabilitar
3328:             loc_oPgDados.chk_4c_ChkEncoms.Enabled     = par_lHabilitar
3329:             loc_oPgDados.txt_4c_Fwget6.Enabled        = par_lHabilitar
3330:             loc_oPgDados.txt_4c_Fwget5.Enabled        = par_lHabilitar
3331:             loc_oPgDados.txt_4c_Fwget4.Enabled        = par_lHabilitar
3332:             loc_oPgDados.txt_4c_Fwget3.Enabled        = par_lHabilitar
3333:             loc_oPgDados.edt_4c_DPro3s.Enabled        = par_lHabilitar
3334:             loc_oPgDados.edt_4c_ObsCompras.Enabled    = par_lHabilitar
3335:         CATCH TO loc_oErro
3336:             MsgErro("Erro ao habilitar campos:" + CHR(13) + loc_oErro.Message, "Erro HabilitarCampos")
3337:         ENDTRY
3338:     ENDPROC
3339: 
3340:     *--------------------------------------------------------------------------
3341:     * OptAbasChange - Muda aba ativa do pgf_4c_DadosPrd
3342:     *--------------------------------------------------------------------------
3343:     PROCEDURE OptAbasChange()
3344:         THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.ActivePage = ;
3345:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
3346:     ENDPROC
3347: 
3348:     *--------------------------------------------------------------------------
3349:     * BtnSalvarClick - Salva registro (Inserir ou Atualizar)
3350:     *--------------------------------------------------------------------------
3351:     PROCEDURE BtnSalvarClick()
3352:         THIS.FormParaBO()
3353:         IF THIS.this_oBusinessObject.Salvar()
3354:             MsgSucesso("Produto salvo com sucesso!")
3355:             THIS.CarregarLista()
3356:             THIS.AlternarPagina(1)
3357:         ELSE
3358:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao salvar")
3359:         ENDIF
3360:     ENDPROC
3361: 
3362:     *--------------------------------------------------------------------------
3363:     * BtnCancelarClick - Cancela edicao e volta para lista
3364:     *--------------------------------------------------------------------------
3365:     PROCEDURE BtnCancelarClick()
3366:         THIS.LimparCampos()
3367:         THIS.AlternarPagina(1)
3368:     ENDPROC
3369: 
3370:     *--------------------------------------------------------------------------
3371:     * KeyPressCgru - F4/F5 abre lookup de Grupo de Produto
3372:     *--------------------------------------------------------------------------
3373:     PROCEDURE KeyPressCgru(par_nKeyCode, par_nShiftAltCtrl)
3374:         IF INLIST(par_nKeyCode, 115, 116)
3375:             THIS.AbrirLookupGrupo()
3376:         ENDIF
3377:     ENDPROC
3378: 
3379:     *--------------------------------------------------------------------------
3380:     * AbrirLookupGrupo - Lookup de Grupos (SigCdGrp: cgrus / dgrus)
3381:     *--------------------------------------------------------------------------
3382:     PROCEDURE AbrirLookupGrupo()
3383:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3384:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3385:             RETURN
3386:         ENDIF
3387:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3388:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
3389:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3390:             "SigCdGrp", "cursor_4c_Busca", "cgrus", loc_cValor, ;
3391:             "Grupos de Produto")
3392:         IF VARTYPE(loc_oBusca) = "O"
3393:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3394:                 loc_oPgDados.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_Busca.cgrus)
3395:                 loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_Busca.dgrus)
3396:             ELSE
3397:                 IF !loc_oBusca.this_lAchouRegistro
3398:                 loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
3399:                 loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
3400:                 loc_oBusca.Show()
3401:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3402:                     loc_oPgDados.txt_4c_Cgru.Value = ALLTRIM(cursor_4c_Busca.cgrus)
3403:                     loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_Busca.dgrus)
3404:                 ENDIF
3405:                 ENDIF
3406:             ENDIF
3407:             loc_oBusca.Release()
3408:         ENDIF
3409:         IF USED("cursor_4c_Busca")
3410:             USE IN cursor_4c_Busca
3411:         ENDIF
3412:     ENDPROC
3413: 
3414:     *--------------------------------------------------------------------------
3415:     * KeyPressCSGru - F4/F5 abre lookup de Subgrupo
3416:     *--------------------------------------------------------------------------
3417:     PROCEDURE KeyPressCSGru(par_nKeyCode, par_nShiftAltCtrl)
3418:         IF INLIST(par_nKeyCode, 115, 116)
3419:             THIS.AbrirLookupSubgrupo()
3420:         ENDIF
3421:     ENDPROC
3422: 
3423:     *--------------------------------------------------------------------------
3424:     * AbrirLookupSubgrupo - Lookup de Subgrupos (SigCdPsg filtrado por cgrus)
3425:     *--------------------------------------------------------------------------
3426:     PROCEDURE AbrirLookupSubgrupo()
3427:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor, loc_cGrupo
3428:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3429:             RETURN
3430:         ENDIF
3431:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3432:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value)
3433:         loc_cGrupo   = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
3434:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3435:             "SigCdPsg", "cursor_4c_Busca", "codigos", loc_cValor, ;
3436:             "Subgrupos")
3437:         IF VARTYPE(loc_oBusca) = "O"
3438:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3439:                 loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_Busca.codigos)
3440:                 loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_Busca.descricaos)
3441:             ELSE
3442:                 IF !loc_oBusca.this_lAchouRegistro
3443:                 loc_oBusca.mAddColuna("codigos",     "", "C" + CHR(243) + "digo")
3444:                 loc_oBusca.mAddColuna("descricaos",  "", "Descri" + CHR(231) + CHR(227) + "o")
3445:                 loc_oBusca.Show()
3446:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3447:                     loc_oPgDados.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_Busca.codigos)
3448:                     loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_Busca.descricaos)
3449:                 ENDIF
3450:                 ENDIF
3451:             ENDIF
3452:             loc_oBusca.Release()
3453:         ENDIF
3454:         IF USED("cursor_4c_Busca")
3455:             USE IN cursor_4c_Busca
3456:         ENDIF
3457:     ENDPROC
3458: 
3459:     *--------------------------------------------------------------------------
3460:     * KeyPressLin - F4/F5 abre lookup de Linha
3461:     *--------------------------------------------------------------------------
3462:     PROCEDURE KeyPressLin(par_nKeyCode, par_nShiftAltCtrl)
3463:         IF INLIST(par_nKeyCode, 115, 116)
3464:             THIS.AbrirLookupLinha()
3465:         ENDIF
3466:     ENDPROC
3467: 
3468:     *--------------------------------------------------------------------------
3469:     * AbrirLookupLinha - Lookup de Linhas (SigCdLin: codigos / descrs)
3470:     *--------------------------------------------------------------------------
3471:     PROCEDURE AbrirLookupLinha()
3472:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3473:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3474:             RETURN
3475:         ENDIF
3476:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3477:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Lin.Value)
3478:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3479:             "SigCdLin", "cursor_4c_Busca", "codigos", loc_cValor, ;
3480:             "Linhas de Produto")
3481:         IF VARTYPE(loc_oBusca) = "O"
3482:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3483:                 loc_oPgDados.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_Busca.codigos)
3484:                 loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(cursor_4c_Busca.descrs)
3485:             ELSE
3486:                 IF !loc_oBusca.this_lAchouRegistro
3487:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3488:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3489:                 loc_oBusca.Show()
3490:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3491:                     loc_oPgDados.txt_4c_Lin.Value  = ALLTRIM(cursor_4c_Busca.codigos)
3492:                     loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(cursor_4c_Busca.descrs)
3493:                 ENDIF
3494:                 ENDIF
3495:             ENDIF
3496:             loc_oBusca.Release()
3497:         ENDIF
3498:         IF USED("cursor_4c_Busca")
3499:             USE IN cursor_4c_Busca
3500:         ENDIF
3501:     ENDPROC
3502: 
3503:     *--------------------------------------------------------------------------
3504:     * KeyPressCol - F4/F5 abre lookup de Colecao (Grupo de Venda)
3505:     *--------------------------------------------------------------------------
3506:     PROCEDURE KeyPressCol(par_nKeyCode, par_nShiftAltCtrl)
3507:         IF INLIST(par_nKeyCode, 115, 116)
3508:             THIS.AbrirLookupColecao()
3509:         ENDIF
3510:     ENDPROC
3511: 
3512:     *--------------------------------------------------------------------------
3513:     * AbrirLookupColecao - Lookup de Colecoes (SigCdCol: codigos / descrs)
3514:     *--------------------------------------------------------------------------
3515:     PROCEDURE AbrirLookupColecao()
3516:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3517:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3518:             RETURN
3519:         ENDIF
3520:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3521:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Col.Value)
3522:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3523:             "SigCdCol", "cursor_4c_Busca", "codigos", loc_cValor, ;
3524:             "Cole" + CHR(231) + CHR(245) + "es")
3525:         IF VARTYPE(loc_oBusca) = "O"
3526:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3527:                 loc_oPgDados.txt_4c_Col.Value  = ALLTRIM(cursor_4c_Busca.codigos)
3528:                 loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(cursor_4c_Busca.descrs)
3529:             ELSE
3530:                 IF !loc_oBusca.this_lAchouRegistro
3531:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
3532:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3533:                 loc_oBusca.Show()
3534:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3535:                     loc_oPgDados.txt_4c_Col.Value  = ALLTRIM(cursor_4c_Busca.codigos)
3536:                     loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(cursor_4c_Busca.descrs)
3537:                 ENDIF
3538:                 ENDIF
3539:             ENDIF
3540:             loc_oBusca.Release()
3541:         ENDIF
3542:         IF USED("cursor_4c_Busca")
3543:             USE IN cursor_4c_Busca
3544:         ENDIF
3545:     ENDPROC
3546: 
3547:     *--------------------------------------------------------------------------
3548:     * KeyPressFornecedor - F4/F5 abre lookup de Fornecedor
3549:     *--------------------------------------------------------------------------
3550:     PROCEDURE KeyPressFornecedor(par_nKeyCode, par_nShiftAltCtrl)
3551:         IF INLIST(par_nKeyCode, 115, 116)
3552:             THIS.AbrirLookupFornecedor()
3553:         ENDIF
3554:     ENDPROC
3555: 
3556:     *--------------------------------------------------------------------------
3557:     * BtnFornecedorClick - Botao "..." abre lookup de Fornecedor
3558:     *--------------------------------------------------------------------------
3559:     PROCEDURE BtnFornecedorClick()
3560:         THIS.AbrirLookupFornecedor()
3561:     ENDPROC
3562: 
3563:     *--------------------------------------------------------------------------
3564:     * AbrirLookupFornecedor - Lookup de Fornecedores (SIGCDCLI: iclis / nomes)
3565:     *--------------------------------------------------------------------------
3566:     PROCEDURE AbrirLookupFornecedor()
3567:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3568:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3569:             RETURN
3570:         ENDIF
3571:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3572:         loc_cValor   = TRANSFORM(loc_oPgDados.txt_4c_Ifor.Value)
3573:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3574:             "SIGCDCLI", "cursor_4c_Busca", "iclis", loc_cValor, ;
3575:             "Fornecedores")
3576:         IF VARTYPE(loc_oBusca) = "O"
3577:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3578:                 loc_oPgDados.txt_4c_Ifor.Value = cursor_4c_Busca.iclis
3579:                 loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_Busca.nomes)
3580:             ELSE
3581:                 IF !loc_oBusca.this_lAchouRegistro
3582:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
3583:                 loc_oBusca.mAddColuna("nomes",  "", "Nome")
3584:                 loc_oBusca.Show()
3585:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3586:                     loc_oPgDados.txt_4c_Ifor.Value = cursor_4c_Busca.iclis
3587:                     loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_Busca.nomes)
3588:                 ENDIF
3589:                 ENDIF
3590:             ENDIF
3591:             loc_oBusca.Release()
3592:         ENDIF
3593:         IF USED("cursor_4c_Busca")
3594:             USE IN cursor_4c_Busca
3595:         ENDIF
3596:     ENDPROC
3597: 
3598:     *--------------------------------------------------------------------------
3599:     * BtnQtMinClick - Abre dialogo de estoque minimo por empresa
3600:     *--------------------------------------------------------------------------
3601:     PROCEDURE BtnQtMinClick()
3602:         MsgInfo("Estoque m" + CHR(237) + "nimo por empresa: funcionalidade na Fase 8.")
3603:     ENDPROC
3604: 
3605:     *--------------------------------------------------------------------------
3606:     * BtnTamanhoClick - Abre lookup de Tamanho
3607:     *--------------------------------------------------------------------------
3608:     PROCEDURE BtnTamanhoClick()
3609:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3610:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3611:             RETURN
3612:         ENDIF
3613:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3614:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Tam.Value)
3615:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3616:             "SigCdTam", "cursor_4c_Busca", "cods", loc_cValor, ;
3617:             "Tamanhos")
3618:         IF VARTYPE(loc_oBusca) = "O"
3619:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3620:                 loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_Busca.cods)
3621:             ELSE
3622:                 IF !loc_oBusca.this_lAchouRegistro
3623:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
3624:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3625:                 loc_oBusca.Show()
3626:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3627:                     loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_Busca.cods)
3628:                 ENDIF
3629:                 ENDIF
3630:             ENDIF
3631:             loc_oBusca.Release()
3632:         ENDIF
3633:         IF USED("cursor_4c_Busca")
3634:             USE IN cursor_4c_Busca
3635:         ENDIF
3636:     ENDPROC
3637: 
3638:     *--------------------------------------------------------------------------
3639:     * KeyPressModelo - F4/F5 abre lookup de Modelo (CodFinP)
3640:     *--------------------------------------------------------------------------
3641:     PROCEDURE KeyPressModelo(par_nKeyCode, par_nShiftAltCtrl)
3642:         IF INLIST(par_nKeyCode, 115, 116)
3643:             THIS.AbrirLookupModelo()
3644:         ENDIF
3645:     ENDPROC
3646: 
3647:     *--------------------------------------------------------------------------
3648:     * AbrirLookupModelo - Lookup de Modelos (SigCdFin: cods / descs ou similar)
3649:     *--------------------------------------------------------------------------
3650:     PROCEDURE AbrirLookupModelo()
3651:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3652:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3653:             RETURN
3654:         ENDIF
3655:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3656:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value)
3657:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3658:             "SIGCDFIP", "cursor_4c_Busca", "cods", loc_cValor, ;
3659:             "Modelos")
3660:         IF VARTYPE(loc_oBusca) = "O"
3661:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3662:                 loc_oPgDados.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_Busca.cods)
3663:                 loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_Busca.descs)
3664:             ELSE
3665:                 IF !loc_oBusca.this_lAchouRegistro
3666:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
3667:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3668:                 loc_oBusca.Show()
3669:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3670:                     loc_oPgDados.txt_4c_CodFinP.Value = ALLTRIM(cursor_4c_Busca.cods)
3671:                     loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_Busca.descs)
3672:                 ENDIF
3673:                 ENDIF
3674:             ENDIF
3675:             loc_oBusca.Release()
3676:         ENDIF
3677:         IF USED("cursor_4c_Busca")
3678:             USE IN cursor_4c_Busca
3679:         ENDIF
3680:     ENDPROC
3681: 
3682:     *--------------------------------------------------------------------------
3683:     * KeyPressAcabamento - F4/F5 abre lookup de Acabamento
3684:     *--------------------------------------------------------------------------
3685:     PROCEDURE KeyPressAcabamento(par_nKeyCode, par_nShiftAltCtrl)
3686:         IF INLIST(par_nKeyCode, 115, 116)
3687:             THIS.AbrirLookupAcabamento()
3688:         ENDIF
3689:     ENDPROC
3690: 
3691:     *--------------------------------------------------------------------------
3692:     * AbrirLookupAcabamento - Lookup de Acabamentos (SigCdAca: cods / descrs)
3693:     *--------------------------------------------------------------------------
3694:     PROCEDURE AbrirLookupAcabamento()
3695:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3696:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3697:             RETURN
3698:         ENDIF
3699:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3700:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c__codacb.Value)
3701:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3702:             "SigCdAca", "cursor_4c_Busca", "cods", loc_cValor, ;
3703:             "Acabamentos")
3704:         IF VARTYPE(loc_oBusca) = "O"
3705:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3706:                 loc_oPgDados.txt_4c__codacb.Value = ALLTRIM(cursor_4c_Busca.cods)
3707:                 loc_oPgDados.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_Busca.descrs)
3708:             ELSE
3709:                 IF !loc_oBusca.this_lAchouRegistro
3710:                 loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
3711:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
3712:                 loc_oBusca.Show()
3713:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3714:                     loc_oPgDados.txt_4c__codacb.Value = ALLTRIM(cursor_4c_Busca.cods)
3715:                     loc_oPgDados.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_Busca.descrs)
3716:                 ENDIF
3717:                 ENDIF
3718:             ENDIF
3719:             loc_oBusca.Release()
3720:         ENDIF
3721:         IF USED("cursor_4c_Busca")
3722:             USE IN cursor_4c_Busca
3723:         ENDIF
3724:     ENDPROC
3725: 
3726:     *--------------------------------------------------------------------------
3727:     * KeyPressClassificacao - F4/F5 abre lookup de Classificacao
3728:     *--------------------------------------------------------------------------
3729:     PROCEDURE KeyPressClassificacao(par_nKeyCode, par_nShiftAltCtrl)
3730:         IF INLIST(par_nKeyCode, 115, 116)
3731:             THIS.AbrirLookupClassificacao()
3732:         ENDIF
3733:     ENDPROC
3734: 
3735:     *--------------------------------------------------------------------------
3736:     * AbrirLookupClassificacao - Lookup de Classificacao (SIGCDCLS: cods / descs)
3737:     *--------------------------------------------------------------------------
3738:     PROCEDURE AbrirLookupClassificacao()
3739:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3740:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3741:             RETURN
3742:         ENDIF
3743:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3744:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Class.Value)
3745:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3746:             "SIGCDCLS", "cursor_4c_Busca", "cods", loc_cValor, ;
3747:             "Classifica" + CHR(231) + CHR(245) + "es")
3748:         IF VARTYPE(loc_oBusca) = "O"
3749:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3750:                 loc_oPgDados.txt_4c_Class.Value  = ALLTRIM(cursor_4c_Busca.cods)
3751:                 loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(cursor_4c_Busca.descs)
3752:             ELSE
3753:                 IF !loc_oBusca.this_lAchouRegistro
3754:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
3755:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3756:                 loc_oBusca.Show()
3757:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3758:                     loc_oPgDados.txt_4c_Class.Value  = ALLTRIM(cursor_4c_Busca.cods)
3759:                     loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(cursor_4c_Busca.descs)
3760:                 ENDIF
3761:                 ENDIF
3762:             ENDIF
3763:             loc_oBusca.Release()
3764:         ENDIF
3765:         IF USED("cursor_4c_Busca")
3766:             USE IN cursor_4c_Busca
3767:         ENDIF
3768:     ENDPROC
3769: 
3770:     *--------------------------------------------------------------------------
3771:     * KeyPressUnidade - F4/F5 abre lookup de Unidade (1)
3772:     *--------------------------------------------------------------------------
3773:     PROCEDURE KeyPressUnidade(par_nKeyCode, par_nShiftAltCtrl)
3774:         IF INLIST(par_nKeyCode, 115, 116)
3775:             THIS.AbrirLookupUnidade()
3776:         ENDIF
3777:     ENDPROC
3778: 
3779:     *--------------------------------------------------------------------------
3780:     * AbrirLookupUnidade - Lookup de Unidade (SigCdUni: cunis / dunis)
3781:     *--------------------------------------------------------------------------
3782:     PROCEDURE AbrirLookupUnidade()
3783:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3784:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3785:             RETURN
3786:         ENDIF
3787:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3788:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value)
3789:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3790:             "SigCdUni", "cursor_4c_Busca", "cunis", loc_cValor, ;
3791:             "Unidades")
3792:         IF VARTYPE(loc_oBusca) = "O"
3793:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3794:                 loc_oPgDados.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_Busca.cunis)
3795:                 loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(cursor_4c_Busca.dunis)
3796:             ELSE
3797:                 IF !loc_oBusca.this_lAchouRegistro
3798:                 loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
3799:                 loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
3800:                 loc_oBusca.Show()
3801:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3802:                     loc_oPgDados.txt_4c_Cuni.Value = ALLTRIM(cursor_4c_Busca.cunis)
3803:                     loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(cursor_4c_Busca.dunis)
3804:                 ENDIF
3805:                 ENDIF
3806:             ENDIF
3807:             loc_oBusca.Release()
3808:         ENDIF
3809:         IF USED("cursor_4c_Busca")
3810:             USE IN cursor_4c_Busca
3811:         ENDIF
3812:     ENDPROC
3813: 
3814:     *--------------------------------------------------------------------------
3815:     * KeyPressUnidade2 - F4/F5 abre lookup de Unidade (2)
3816:     *--------------------------------------------------------------------------
3817:     PROCEDURE KeyPressUnidade2(par_nKeyCode, par_nShiftAltCtrl)
3818:         IF INLIST(par_nKeyCode, 115, 116)
3819:             THIS.AbrirLookupUnidade2()
3820:         ENDIF
3821:     ENDPROC
3822: 
3823:     *--------------------------------------------------------------------------
3824:     * AbrirLookupUnidade2 - Lookup de Unidade 2 (SigCdUni: cunis / dunis)
3825:     *--------------------------------------------------------------------------
3826:     PROCEDURE AbrirLookupUnidade2()
3827:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3828:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3829:             RETURN
3830:         ENDIF
3831:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3832:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value)
3833:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3834:             "SigCdUni", "cursor_4c_Busca", "cunis", loc_cValor, ;
3835:             "Unidades (2)")
3836:         IF VARTYPE(loc_oBusca) = "O"
3837:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3838:                 loc_oPgDados.txt_4c_Cunip.Value  = ALLTRIM(cursor_4c_Busca.cunis)
3839:                 loc_oPgDados.txt_4c__dunip.Value = ALLTRIM(cursor_4c_Busca.dunis)
3840:             ELSE
3841:                 IF !loc_oBusca.this_lAchouRegistro
3842:                 loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
3843:                 loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
3844:                 loc_oBusca.Show()
3845:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3846:                     loc_oPgDados.txt_4c_Cunip.Value  = ALLTRIM(cursor_4c_Busca.cunis)
3847:                     loc_oPgDados.txt_4c__dunip.Value = ALLTRIM(cursor_4c_Busca.dunis)
3848:                 ENDIF
3849:                 ENDIF
3850:             ENDIF
3851:             loc_oBusca.Release()
3852:         ENDIF
3853:         IF USED("cursor_4c_Busca")
3854:             USE IN cursor_4c_Busca
3855:         ENDIF
3856:     ENDPROC
3857: 
3858:     *--------------------------------------------------------------------------
3859:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
3860:     *--------------------------------------------------------------------------
3861:     PROCEDURE AlternarPagina(par_nPagina)
3862:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
3863:     ENDPROC
3864: 
3865:     *--------------------------------------------------------------------------
3866:     * KeyPressEquivalente - F4/F5 abre lookup de Produto Equivalente
3867:     *--------------------------------------------------------------------------
3868:     PROCEDURE KeyPressEquivalente(par_nKeyCode, par_nShiftAltCtrl)
3869:         IF INLIST(par_nKeyCode, 115, 116)
3870:             THIS.AbrirLookupEquivalente()
3871:         ENDIF
3872:     ENDPROC
3873: 
3874:     *--------------------------------------------------------------------------
3875:     * AbrirLookupEquivalente - Lookup de Produto Equivalente (SigCdPro: cpros/dpros)
3876:     *--------------------------------------------------------------------------
3877:     PROCEDURE AbrirLookupEquivalente()
3878:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3879:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3880:             RETURN
3881:         ENDIF
3882:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3883:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value)
3884:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3885:             "SigCdPro", "cursor_4c_Busca", "cpros", loc_cValor, ;
3886:             "Produto Equivalente")
3887:         IF VARTYPE(loc_oBusca) = "O"
3888:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3889:                 loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_Busca.cpros)
3890:             ELSE
3891:                 IF !loc_oBusca.this_lAchouRegistro
3892:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
3893:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
3894:                 loc_oBusca.Show()
3895:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3896:                     loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_Busca.cpros)
3897:                 ENDIF
3898:                 ENDIF
3899:             ENDIF
3900:             loc_oBusca.Release()
3901:         ENDIF
3902:         IF USED("cursor_4c_Busca")
3903:             USE IN cursor_4c_Busca
3904:         ENDIF
3905:     ENDPROC
3906: 
3907:     *--------------------------------------------------------------------------
3908:     * KeyPressCor - F4/F5 abre lookup de Cor
3909:     *--------------------------------------------------------------------------
3910:     PROCEDURE KeyPressCor(par_nKeyCode, par_nShiftAltCtrl)
3911:         IF INLIST(par_nKeyCode, 115, 116)
3912:             THIS.AbrirLookupCor()
3913:         ENDIF
3914:     ENDPROC
3915: 
3916:     *--------------------------------------------------------------------------
3917:     * AbrirLookupCor - Lookup de Cores (SigCdCor: cods / descs)
3918:     *--------------------------------------------------------------------------
3919:     PROCEDURE AbrirLookupCor()
3920:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3921:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3922:             RETURN
3923:         ENDIF
3924:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3925:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Cor.Value)
3926:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3927:             "SigCdCor", "cursor_4c_Busca", "cods", loc_cValor, ;
3928:             "Cores")
3929:         IF VARTYPE(loc_oBusca) = "O"
3930:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3931:                 loc_oPgDados.txt_4c_Cor.Value = ALLTRIM(cursor_4c_Busca.cods)
3932:             ELSE
3933:                 IF !loc_oBusca.this_lAchouRegistro
3934:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
3935:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3936:                 loc_oBusca.Show()
3937:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3938:                     loc_oPgDados.txt_4c_Cor.Value = ALLTRIM(cursor_4c_Busca.cods)
3939:                 ENDIF
3940:                 ENDIF
3941:             ENDIF
3942:             loc_oBusca.Release()
3943:         ENDIF
3944:         IF USED("cursor_4c_Busca")
3945:             USE IN cursor_4c_Busca
3946:         ENDIF
3947:     ENDPROC
3948: 
3949:     *--------------------------------------------------------------------------
3950:     * KeyPressLocal - F4/F5 abre lookup de Localizacao
3951:     *--------------------------------------------------------------------------
3952:     PROCEDURE KeyPressLocal(par_nKeyCode, par_nShiftAltCtrl)
3953:         IF INLIST(par_nKeyCode, 115, 116)
3954:             THIS.AbrirLookupLocal()
3955:         ENDIF
3956:     ENDPROC
3957: 
3958:     *--------------------------------------------------------------------------
3959:     * AbrirLookupLocal - Lookup de Localizacao (SigPrLcl: codigos / descricaos)
3960:     *--------------------------------------------------------------------------
3961:     PROCEDURE AbrirLookupLocal()
3962:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
3963:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3964:             RETURN
3965:         ENDIF
3966:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
3967:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Local.Value)
3968:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3969:             "SigPrLcl", "cursor_4c_Busca", "codigos", loc_cValor, ;
3970:             "Localiza" + CHR(231) + CHR(227) + "o")
3971:         IF VARTYPE(loc_oBusca) = "O"
3972:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
3973:                 loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_Busca.codigos)
3974:             ELSE
3975:                 IF !loc_oBusca.this_lAchouRegistro
3976:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
3977:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
3978:                 loc_oBusca.Show()
3979:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3980:                     loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_Busca.codigos)
3981:                 ENDIF
3982:                 ENDIF
3983:             ENDIF
3984:             loc_oBusca.Release()
3985:         ENDIF
3986:         IF USED("cursor_4c_Busca")
3987:             USE IN cursor_4c_Busca
3988:         ENDIF
3989:     ENDPROC
3990: 
3991:     *--------------------------------------------------------------------------
3992:     * KeyPressConjunto - F4/F5 abre lookup de Conjunto
3993:     *--------------------------------------------------------------------------
3994:     PROCEDURE KeyPressConjunto(par_nKeyCode, par_nShiftAltCtrl)
3995:         IF INLIST(par_nKeyCode, 115, 116)
3996:             THIS.AbrirLookupConjunto()
3997:         ENDIF
3998:     ENDPROC
3999: 
4000:     *--------------------------------------------------------------------------
4001:     * AbrirLookupConjunto - Lookup de Conjuntos (SigCdPro: conjuntos)
4002:     *--------------------------------------------------------------------------
4003:     PROCEDURE AbrirLookupConjunto()
4004:         LOCAL loc_oBusca, loc_oPgDados, loc_cValor
4005:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
4006:             RETURN
4007:         ENDIF
4008:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosPrd.Page1
4009:         loc_cValor   = ALLTRIM(loc_oPgDados.txt_4c_Conjunto.Value)
4010:         loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4011:             "SigCdPro", "cursor_4c_Busca", "conjuntos", loc_cValor, ;
4012:             "Conjuntos")
4013:         IF VARTYPE(loc_oBusca) = "O"
4014:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4015:                 loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_Busca.conjuntos)
4016:             ELSE
4017:                 IF !loc_oBusca.this_lAchouRegistro
4018:                 loc_oBusca.mAddColuna("conjuntos", "", "Conjunto")
4019:                 loc_oBusca.Show()
4020:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4021:                     loc_oPgDados.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_Busca.conjuntos)
4022:                 ENDIF
4023:                 ENDIF
4024:             ENDIF
4025:             loc_oBusca.Release()
4026:         ENDIF
4027:         IF USED("cursor_4c_Busca")
4028:             USE IN cursor_4c_Busca
4029:         ENDIF
4030:     ENDPROC
4031: 
4032:     *--------------------------------------------------------------------------
4033:     * AjustarBotoesPorModo - Ajusta estado dos botoes Salvar/Cancelar
4034:     * conforme modo atual (INCLUIR/ALTERAR/VISUALIZAR)
4035:     *--------------------------------------------------------------------------
4036:     PROCEDURE AjustarBotoesPorModo()
4037:         LOCAL loc_oBotoes, loc_cModo
4038:         loc_cModo   = THIS.this_cModoAtual
4039:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
4040: 
4041:         TRY
4042:             DO CASE
4043:             CASE loc_cModo = "VISUALIZAR"
4044:                 loc_oBotoes.cmd_4c_Salvar.Enabled    = .F.
4045:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
4046:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Voltar"
4047: 
4048:             CASE loc_cModo = "INCLUIR" OR loc_cModo = "ALTERAR"
4049:                 loc_oBotoes.cmd_4c_Salvar.Enabled    = .T.
4050:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
4051:                 loc_oBotoes.cmd_4c_Cancelar.Caption  = "Cancelar"
4052:             ENDCASE
4053:         CATCH TO loc_oErro
4054:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
4055:         ENDTRY
4056:     ENDPROC
4057: 
4058:     *--------------------------------------------------------------------------
4059:     * DESTROY - Destrutor
4060:     *--------------------------------------------------------------------------
4061:     PROCEDURE Destroy()
4062:         IF !ISNULL(THIS.this_oBusinessObject)
4063:             THIS.this_oBusinessObject = .NULL.
4064:         ENDIF
4065:         IF USED("cursor_4c_Dados")
4066:             USE IN cursor_4c_Dados
4067:         ENDIF
4068:         DODEFAULT()
4069:     ENDPROC
4070: 
4071: ENDDEFINE

