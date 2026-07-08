# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarDescSgru()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDPRO.Pagina.Lista.cntMensagem): Top original=32 vs migrado 'lbl_4c_Label1' Top=473 (diff=441px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Top original=171 vs migrado 'cnt_4c_Botoes' Top=29 (diff=142px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Botoes' (parent: SIGCDPRO.Pagina.Lista): Left original=959 vs migrado 'cnt_4c_Botoes' Left=542 (diff=417px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Top original=5 vs migrado 'lbl_4c_Label8' Top=542 (diff=537px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDPRO.Pagina.Dados.CntQtMin): Left original=8 vs migrado 'lbl_4c_Label8' Left=161 (diff=153px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Top original=134 vs migrado 'lbl_4c_Label24' Top=542 (diff=408px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDPRO.Pagina.Dados.pgframeDados.pgDados): Left original=58 vs migrado 'lbl_4c_Label24' Left=324 (diff=266px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (13674 linhas total):

*-- Linhas 51 a 423:
51:     this_cUltTptribs        = ""    && Ultimo tptribs validado
52: 
53:     *-- Guardias para LostFocus de composicao e campos fiscais descritivos
54:     this_cUltimoTabCompo_DescLostFocusValidado    = ""
55:     this_cUltimoTabCompo_MatPLostFocusValidado    = ""
56:     this_cUltimoTabCompo_DesccpLostFocusValidado  = ""
57:     this_cUltimoTabCompo_MatsubLostFocusValidado  = ""
58:     this_cUltimoTabCompo_CmkpcLostFocusValidado   = ""
59:     this_cUltimoTabCompo_MoedaLostFocusValidado   = ""
60:     this_cUltimoTabCompo_FtioLostFocusValidado    = ""
61:     this_cUltimoTabCompo_MoepvLostFocusValidado   = ""
62:     this_cUltimoTabCompo_MoevLostFocusValidado    = ""
63:     this_cUltimoTabCompo_MoecLostFocusValidado    = ""
64:     this_cUltimoTabCompo_MoecusfLostFocusValidado = ""
65:     this_cUltimoValidarDgruccusValidado           = ""
66:     this_cUltimoValidarDcontaccusValidado         = ""
67:     this_cUltimoValidarDclfiscalValidado          = ""
68:     this_cUltimoValidarDorigmercValidado          = ""
69:     this_cUltimoValidarDsittricmsValidado         = ""
70: 
71:     *-- Guardias LostFocus para campos de codigo (evitar lookup repetido)
72:     this_cUltimoValidarGruccusValidado            = ""
73:     this_cUltimoValidarContaccusValidado          = ""
74:     this_cUltimoValidarClfiscalValidado           = ""
75:     this_cUltimoValidarOrigmercValidado           = ""
76:     this_cUltimoValidarSittricmsValidado          = ""
77:     this_cUltimoValidarCodServsValidado           = ""
78:     this_cUltimoValidarTptribsValidado            = ""
79:     this_cUltimoValidarMoedaEstimadaValidado      = ""
80: 
81:     *--------------------------------------------------------------------------
82:     * Init - Inicializacao do formulario
83:     *--------------------------------------------------------------------------
84:     PROCEDURE Init()
85:         RETURN DODEFAULT()
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * InicializarForm - Configuracao inicial do formulario
90:     *--------------------------------------------------------------------------
91:     PROTECTED PROCEDURE InicializarForm()
92:         LOCAL loc_lSucesso
93:         loc_lSucesso = .F.
94: 
95:         TRY
96:             *-- Guard: evitar loops de SQL durante validacao UI
97:             IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
98:                 gb_4c_ValidandoUI = .F.
99:             ENDIF
100: 
101:             *-- Criar instancia do Business Object
102:             THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")
103: 
104:             IF ISNULL(THIS.this_oBusinessObject)
105:                 MsgErro("Erro ao criar Business Object ProdutoBO", "FormProduto.InicializarForm")
106:                 loc_lSucesso = .F.
107:             ELSE
108:                 THIS.ConfigurarPageFrame()
109:                 THIS.ConfigurarPaginaLista()
110:                 THIS.ConfigurarPaginaDados()
111:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
114:                     IF !THIS.CarregarLista()
115:                         *-- Se falhar ao carregar, nao impede abertura
116:                     ENDIF
117:                 ENDIF
118: 
119:                 THIS.pgf_4c_Paginas.Visible    = .T.
120:                 THIS.pgf_4c_Paginas.ActivePage = 1
121:                 THIS.this_cModoAtual           = "LISTA"
122:                 loc_lSucesso = .T.
123:             ENDIF
124: 
125:         CATCH TO loc_oErro
126:             MsgErro("Erro ao inicializar FormProduto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.InicializarForm")
127:             loc_lSucesso = .F.
128:         ENDTRY
129: 
130:         RETURN loc_lSucesso
131:     ENDPROC
132: 
133:     *--------------------------------------------------------------------------
134:     * ConfigurarPageFrame - Configura o PageFrame principal (2 paginas)
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE ConfigurarPageFrame()
137:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
138: 
139:         WITH THIS.pgf_4c_Paginas
140:             .Top       = -29
141:             .Left      = 0
142:             .Width     = 1003
143:             .Height    = 660
144:             .PageCount = 2
145:             .Tabs      = .F.
146:             .Visible   = .T.
147: 
148:             .Page1.Caption  = "Lista"
149:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
150:             .Page1.BackColor = RGB(255, 255, 255)
151: 
152:             .Page2.Caption  = "Dados"
153:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
154:             .Page2.BackColor = RGB(255, 255, 255)
155:         ENDWITH
156:     ENDPROC
157: 
158:     *--------------------------------------------------------------------------
159:     * ConfigurarPaginaLista - Configura Page1 (Lista de Produtos)
160:     * Compensacao +29: Top_legado + 29
161:     * Grid legado: Grade top=173, left=38, width=922, height=409
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE ConfigurarPaginaLista()
164:         LOCAL loc_oPagina
165:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
166: 
167:         *-- Container cabecalho
168:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
169:         WITH loc_oPagina.cnt_4c_Cabecalho
170:             .Top         = 31
171:             .Left        = 0
172:             .Width       = 1020
173:             .Height      = 80
174:             .BackStyle   = 1
175:             .BackColor   = RGB(53, 53, 53)
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
181:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
182:             .Caption   = "Cadastro de Produtos"
183:             .Top       = 20
184:             .Left      = 20
185:             .Width     = 400
186:             .Height    = 30
187:             .FontName  = "Tahoma"
188:             .FontSize  = 14
189:             .FontBold  = .T.
190:             .BackStyle = 0
191:             .ForeColor = RGB(255, 255, 255)
192:             .Visible   = .T.
193:         ENDWITH
194: 
195:         *-- Container de botoes CRUD (Grupo_op: Left=542 no legado, Top=0 -> 29)
196:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
197:         WITH loc_oPagina.cnt_4c_Botoes
198:             .Top         = 29
199:             .Left        = 542
200:             .Width       = 380
201:             .Height      = 85
202:             .BackStyle = 1
203:             .BackColor = RGB(53, 53, 53)
204:             .BorderWidth = 0
205:             .Visible     = .T.
206:         ENDWITH
207: 
208:         *-- Botao Incluir (Left=5)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
211:             .Caption         = "Incluir"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
213:             .PicturePosition = 13
214:             .Width           = 75
215:             .Height          = 75
216:             .Left            = 5
217:             .Top             = 5
218:             .FontName        = "Tahoma"
219:             .FontSize        = 8
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
227: 
228:         *-- Botao Visualizar (Left=80)
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
231:             .Caption         = "Visualizar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
233:             .PicturePosition = 13
234:             .Width           = 75
235:             .Height          = 75
236:             .Left            = 80
237:             .Top             = 5
238:             .FontName        = "Tahoma"
239:             .FontSize        = 8
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .BackColor       = RGB(255, 255, 255)
243:             .ForeColor       = RGB(90, 90, 90)
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
247: 
248:         *-- Botao Alterar (Left=155)
249:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
250:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
251:             .Caption         = "Alterar"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
253:             .PicturePosition = 13
254:             .Width           = 75
255:             .Height          = 75
256:             .Left            = 155
257:             .Top             = 5
258:             .FontName        = "Tahoma"
259:             .FontSize        = 8
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .BackColor       = RGB(255, 255, 255)
263:             .ForeColor       = RGB(90, 90, 90)
264:             .Visible         = .T.
265:         ENDWITH
266:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
267: 
268:         *-- Botao Excluir (Left=230)
269:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
270:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
271:             .Caption         = "Excluir"
272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
273:             .PicturePosition = 13
274:             .Width           = 75
275:             .Height          = 75
276:             .Left            = 230
277:             .Top             = 5
278:             .FontName        = "Tahoma"
279:             .FontSize        = 8
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
287: 
288:         *-- Botao Buscar (Left=305)
289:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
290:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
291:             .Caption         = "Buscar"
292:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
293:             .PicturePosition = 13
294:             .Width           = 75
295:             .Height          = 75
296:             .Left            = 305
297:             .Top             = 5
298:             .FontName        = "Tahoma"
299:             .FontSize        = 8
300:             .Themes          = .F.
301:             .SpecialEffect   = 0
302:             .BackColor       = RGB(255, 255, 255)
303:             .ForeColor       = RGB(90, 90, 90)
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container de saida separado (Left=917, Top=29)
309:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
310:         WITH loc_oPagina.cnt_4c_Saida
311:             .Top         = 29
312:             .Left        = 917
313:             .Width       = 90
314:             .Height      = 85
315:             .BackStyle = 1
316:             .BackColor = RGB(53, 53, 53)
317:             .BorderWidth = 0
318:             .Visible     = .T.
319:         ENDWITH
320: 
321:         *-- Botao Encerrar
322:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
323:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
324:             .Caption         = "Encerrar"
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .PicturePosition = 13
327:             .Width           = 75
328:             .Height          = 75
329:             .Left            = 5
330:             .Top             = 5
331:             .FontName        = "Tahoma"
332:             .FontSize        = 8
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .BackColor       = RGB(255, 255, 255)
336:             .ForeColor       = RGB(90, 90, 90)
337:             .Visible         = .T.
338:         ENDWITH
339:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
340: 
341:         *-- Container de filtros (cntFiltros legado: continha getCgru/getDgru/getDtIni/Fim/optFilSituas)
342:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
343:         WITH loc_oPagina.cnt_4c_Filtros
344:             .Top         = 120
345:             .Left        = 12
346:             .Width       = 940
347:             .Height      = 55
348:             .BackStyle   = 0
349:             .BorderWidth = 0
350:             .Visible     = .T.
351:         ENDWITH
352: 
353:         *-- Filtro: Label Grupo
354:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
355:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
356:             .Caption   = "Grupo:"
357:             .Left      = 5
358:             .Top       = 8
359:             .Width     = 40
360:             .Height    = 15
361:             .FontName  = "Tahoma"
362:             .FontSize  = 8
363:             .BackStyle = 0
364:             .ForeColor = RGB(90, 90, 90)
365:             .Visible   = .T.
366:         ENDWITH
367: 
368:         *-- Filtro: Codigo do grupo
369:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroCgru", "TextBox")
370:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru
371:             .Value         = ""
372:             .Left          = 47
373:             .Top           = 3
374:             .Width         = 35
375:             .Height        = 22
376:             .FontName      = "Tahoma"
377:             .FontSize      = 8
378:             .SpecialEffect = 1
379:             .MaxLength     = 3
380:             .Visible       = .T.
381:         ENDWITH
382:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "KeyPress", THIS, "FiltroGrupo_KeyPress")
383:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroCgru, "LostFocus", THIS, "ValidarFiltroGrupo")
384: 
385:         *-- Filtro: Descricao do grupo (leitura)
386:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDgru", "TextBox")
387:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDgru
388:             .Value         = ""
389:             .Left          = 84
390:             .Top           = 3
391:             .Width         = 156
392:             .Height        = 22
393:             .FontName      = "Tahoma"
394:             .FontSize      = 8
395:             .SpecialEffect = 1
396:             .ReadOnly      = .T.
397:             .Enabled       = .F.
398:             .Visible       = .T.
399:         ENDWITH
400: 
401:         *-- Filtro: Label Ultima alteracao
402:         loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData", "Label")
403:         WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData
404:             .Caption   = "Ult. Alt.:"
405:             .Left      = 248
406:             .Top       = 8
407:             .Width     = 52
408:             .Height    = 15
409:             .FontName  = "Tahoma"
410:             .FontSize  = 8
411:             .BackStyle = 0
412:             .ForeColor = RGB(90, 90, 90)
413:             .Visible   = .T.
414:         ENDWITH
415: 
416:         *-- Filtro: Data Inicio
417:         loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FiltroDataIni", "TextBox")
418:         WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FiltroDataIni
419:             .Value         = {}
420:             .Left          = 302
421:             .Top           = 3
422:             .Width         = 80
423:             .Height        = 22

*-- Linhas 457 a 655:
457:         ENDWITH
458: 
459:         *-- Filtro: Situacao (Todos/Ativos/Inativos) - legado: optFilSituas
460:         loc_oPagina.cnt_4c_Filtros.AddObject("opt_4c_FiltraSituas", "OptionGroup")
461:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
462:             .Left        = 500
463:             .Top         = 3
464:             .Width       = 200
465:             .Height      = 25
466:             .ButtonCount = 3
467:             .BorderStyle = 0
468:             .Themes      = .F.
469:             .Value       = 1
470:             .Visible     = .T.
471:         ENDWITH
472:         WITH loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas
473:             .Buttons(1).Caption   = "Todos"
474:             .Buttons(1).Left      = 0
475:             .Buttons(1).Top       = 0
476:             .Buttons(1).AutoSize  = .T.
477:             .Buttons(1).Themes    = .F.
478:             .Buttons(1).FontName  = "Tahoma"
479:             .Buttons(1).FontSize  = 8
480:             .Buttons(2).Caption   = "Ativos"
481:             .Buttons(2).Left      = 65
482:             .Buttons(2).Top       = 0
483:             .Buttons(2).AutoSize  = .T.
484:             .Buttons(2).Themes    = .F.
485:             .Buttons(2).FontName  = "Tahoma"
486:             .Buttons(2).FontSize  = 8
487:             .Buttons(3).Caption   = "Inativos"
488:             .Buttons(3).Left      = 130
489:             .Buttons(3).Top       = 0
490:             .Buttons(3).AutoSize  = .T.
491:             .Buttons(3).Themes    = .F.
492:             .Buttons(3).FontName  = "Tahoma"
493:             .Buttons(3).FontSize  = 8
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_FiltraSituas, "InteractiveChange", THIS, "FiltroSituas_InteractiveChange")
496: 
497:         *-- Botao Pesquisar
498:         loc_oPagina.cnt_4c_Filtros.AddObject("cmd_4c_Pesquisar", "CommandButton")
499:         WITH loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar
500:             .Caption         = "Pesquisar"
501:             .Left            = 708
502:             .Top             = 2
503:             .Width           = 75
504:             .Height          = 22
505:             .FontName        = "Tahoma"
506:             .FontSize        = 8
507:             .Themes          = .F.
508:             .SpecialEffect   = 0
509:             .BackColor       = RGB(255, 255, 255)
510:             .ForeColor       = RGB(90, 90, 90)
511:             .Visible         = .T.
512:         ENDWITH
513:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cmd_4c_Pesquisar, "Click", THIS, "BtnPesquisarClick")
514: 
515:         *-- Label contador de produtos (legado: lblProdutos top=584)
516:         loc_oPagina.AddObject("lbl_4c_ContadorProdutos", "Label")
517:         WITH loc_oPagina.lbl_4c_ContadorProdutos
518:             .Caption   = "0 produto(s)"
519:             .Top       = 583
520:             .Left      = 38
521:             .Width     = 200
522:             .Height    = 15
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .BackStyle = 0
526:             .ForeColor = RGB(90, 90, 90)
527:             .Visible   = .T.
528:         ENDWITH
529: 
530:         *-- Grid de lista (Grade: top=173, left=38, width=922, height=409)
531:         *-- 7 colunas: cpros, dpros, cgrus, sgrus, reffs, usuaalts, situacao
532:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
533:         WITH loc_oPagina.grd_4c_Lista
534:             .Top               = 182
535:             .Left              = 12
536:             .Width             = 940
537:             .Height            = 395
538:             .ReadOnly          = .T.
539:             .DeleteMark        = .F.
540:             .RecordMark        = .F.
541:             .ScrollBars        = 3
542:             .GridLines         = 3
543:             .ColumnCount       = 7
544:             .AllowHeaderSizing = .T.
545:             .Visible           = .T.
546:         ENDWITH
547:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
548: 
549:         THIS.TornarControlesVisiveis(loc_oPagina)
550:     ENDPROC
551: 
552:     *--------------------------------------------------------------------------
553:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
554:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54
555:     *--------------------------------------------------------------------------
556:     PROTECTED PROCEDURE ConfigurarPaginaDados()
557:         LOCAL loc_oPagina
558:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
559: 
560:         *-- Container de botoes Salvar/Cancelar (Top=34, Left=819)
561:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
562:         WITH loc_oPagina.cnt_4c_BotoesDados
563:             .Top         = 34
564:             .Left        = 819
565:             .Width       = 165
566:             .Height      = 85
567:             .BackStyle = 1
568:             .BackColor = RGB(53, 53, 53)
569:             .BorderWidth = 0
570:             .Visible     = .T.
571:         ENDWITH
572: 
573:         *-- Botao Salvar (Left=7, Top=5)
574:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
575:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
576:             .Caption         = "Salvar"
577:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
578:             .PicturePosition = 13
579:             .Width           = 75
580:             .Height          = 75
581:             .Left            = 7
582:             .Top             = 5
583:             .FontName        = "Tahoma"
584:             .FontSize        = 8
585:             .Themes          = .F.
586:             .SpecialEffect   = 0
587:             .BackColor       = RGB(255, 255, 255)
588:             .ForeColor       = RGB(90, 90, 90)
589:             .Visible         = .T.
590:         ENDWITH
591:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
592: 
593:         *-- Botao Cancelar (Left=83, Top=5)
594:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
595:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
596:             .Caption         = "Cancelar"
597:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
598:             .PicturePosition = 13
599:             .Width           = 75
600:             .Height          = 75
601:             .Left            = 83
602:             .Top             = 5
603:             .FontName        = "Tahoma"
604:             .FontSize        = 8
605:             .Themes          = .F.
606:             .SpecialEffect   = 0
607:             .BackColor       = RGB(255, 255, 255)
608:             .ForeColor       = RGB(90, 90, 90)
609:             .Visible         = .T.
610:         ENDWITH
611:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
612: 
613:         *-- OptionGroup para navegacao entre abas internas
614:         *-- Legado: Optiongroup1 top=5->34, left=5, width=535, height=85, buttonCount=7
615:         loc_oPagina.AddObject("opt_4c_Abas", "OptionGroup")
616:         WITH loc_oPagina.opt_4c_Abas
617:             .Left        = 5
618:             .Top         = 34
619:             .Width       = 800
620:             .Height      = 85
621:             .ButtonCount = 7
622:             .BorderStyle = 0
623:             .Themes      = .F.
624:             .Value       = 1
625:             .Visible     = .T.
626:         ENDWITH
627:         WITH loc_oPagina.opt_4c_Abas
628:             .Buttons(1).Caption   = "Principal"
629:             .Buttons(1).Left      = 0
630:             .Buttons(1).Top       = 25
631:             .Buttons(1).Width     = 85
632:             .Buttons(1).Height    = 30
633:             .Buttons(1).Themes    = .F.
634:             .Buttons(1).FontName  = "Tahoma"
635:             .Buttons(1).FontSize  = 8
636:             .Buttons(1).ForeColor = RGB(50, 50, 50)
637:             .Buttons(2).Caption   = "Composi" + CHR(231) + CHR(227) + "o"
638:             .Buttons(2).Left      = 90
639:             .Buttons(2).Top       = 25
640:             .Buttons(2).Width     = 90
641:             .Buttons(2).Height    = 30
642:             .Buttons(2).Themes    = .F.
643:             .Buttons(2).FontName  = "Tahoma"
644:             .Buttons(2).FontSize  = 8
645:             .Buttons(2).ForeColor = RGB(50, 50, 50)
646:             .Buttons(3).Caption   = "Custos"
647:             .Buttons(3).Left      = 185
648:             .Buttons(3).Top       = 25
649:             .Buttons(3).Width     = 75
650:             .Buttons(3).Height    = 30
651:             .Buttons(3).Themes    = .F.
652:             .Buttons(3).FontName  = "Tahoma"
653:             .Buttons(3).FontSize  = 8
654:             .Buttons(3).ForeColor = RGB(50, 50, 50)
655:             .Buttons(4).Caption   = "Dados Fiscais"

*-- Linhas 689 a 781:
689:             .Buttons(7).FontSize  = 8
690:             .Buttons(7).ForeColor = RGB(50, 50, 50)
691:         ENDWITH
692:         BINDEVENT(loc_oPagina.opt_4c_Abas, "InteractiveChange", THIS, "OpcaoAbasChange")
693: 
694:         *-- PageFrame interno (pgframeDados legado: top=-54, left=-1, width=1003, height=656)
695:         *-- Tabs=.F. para ocultar abas (navegacao pelo OptionGroup)
696:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
697:         WITH loc_oPagina.pgf_4c_Dados
698:             .Top       = -54
699:             .Left      = -1
700:             .Width     = 1003
701:             .Height    = 685
702:             .PageCount = 7
703:             .Tabs      = .F.
704:             .Visible   = .T.
705: 
706:             .Page1.Caption  = "Principal"
707:             .Page1.BackColor = RGB(255, 255, 255)
708:             .Page2.Caption  = "Composicao"
709:             .Page2.BackColor = RGB(255, 255, 255)
710:             .Page3.Caption  = "Custos"
711:             .Page3.BackColor = RGB(255, 255, 255)
712:             .Page4.Caption  = "Dados Fiscais"
713:             .Page4.BackColor = RGB(255, 255, 255)
714:             .Page5.Caption  = "Designer"
715:             .Page5.BackColor = RGB(255, 255, 255)
716:             .Page6.Caption  = "Consulta"
717:             .Page6.BackColor = RGB(255, 255, 255)
718:             .Page7.Caption  = "Fases"
719:             .Page7.BackColor = RGB(255, 255, 255)
720:         ENDWITH
721: 
722:         *-- Configurar conteudo de cada aba
723:         THIS.ConfigurarTabPrincipal()
724:         THIS.ConfigurarTabComposicao()
725:         THIS.ConfigurarTabCustos()
726:         THIS.ConfigurarTabDadosFiscais()
727:         THIS.ConfigurarPgpgDadosFiscais()
728:         THIS.ConfigurarTabDesigner()
729:         THIS.ConfigurarPgpgDesigner()
730:         THIS.ConfigurarTabConsulta()
731:         THIS.ConfigurarTabFases()
732: 
733:         THIS.TornarControlesVisiveis(loc_oPagina)
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * ConfigurarTabPrincipal - Aba 1: Dados principais do produto (pgDados)
738:     * Legado: pgframeDados.pgDados (167 controles)
739:     * Posicoes direto do layout.json (sem compensacao - dentro de pgf_4c_Dados)
740:     *--------------------------------------------------------------------------
741:     PROTECTED PROCEDURE ConfigurarTabPrincipal()
742:         LOCAL loc_oPg
743:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
744: 
745:         *-- === CODIGO e DESCRICAO =============================================
746: 
747:         loc_oPg.AddObject("lbl_4c_LblCpros", "Label")
748:         WITH loc_oPg.lbl_4c_LblCpros
749:             .Caption = "Produto :"
750:             .Top = 134
751:             .Left = 58
752:             .Width = 53
753:             .Height = 15
754:             .FontName = "Tahoma"
755:             .FontSize = 8
756:             .BackStyle = 0
757:             .ForeColor = RGB(90,90,90)
758:         ENDWITH
759: 
760:         loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
761:         WITH loc_oPg.txt_4c_Cpros
762:             .Value = ""
763:             .Top = 130
764:             .Left = 113
765:             .Width = 108
766:             .Height = 23
767:             .FontName = "Tahoma"
768:             .FontSize = 8
769:             .SpecialEffect = 1
770:             .MaxLength = 14
771:         ENDWITH
772: 
773:         loc_oPg.AddObject("lbl_4c_LblDpros", "Label")
774:         WITH loc_oPg.lbl_4c_LblDpros
775:             .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
776:             .Top = 134
777:             .Left = 222
778:             .Width = 70
779:             .Height = 15
780:             .FontName = "Tahoma"
781:             .FontSize = 8

*-- Linhas 849 a 893:
849:             .SpecialEffect = 1
850:             .MaxLength = 3
851:         ENDWITH
852:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TabPrincipal_CgruKeyPress")
853:         BINDEVENT(loc_oPg.txt_4c_Cgrus, "LostFocus", THIS, "TabPrincipal_CgruLostFocus")
854: 
855:         loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
856:         WITH loc_oPg.txt_4c_Dgrus
857:             .Value = ""
858:             .Top = 178
859:             .Left = 145
860:             .Width = 171
861:             .Height = 23
862:             .FontName = "Tahoma"
863:             .FontSize = 8
864:             .SpecialEffect = 1
865:             .ReadOnly = .T.
866:             .Enabled = .F.
867:         ENDWITH
868: 
869:         loc_oPg.AddObject("lbl_4c_LblSgrus", "Label")
870:         WITH loc_oPg.lbl_4c_LblSgrus
871:             .Caption = "Subgrupo :"
872:             .Top = 206
873:             .Left = 56
874:             .Width = 55
875:             .Height = 15
876:             .FontName = "Tahoma"
877:             .FontSize = 8
878:             .BackStyle = 0
879:             .ForeColor = RGB(90,90,90)
880:         ENDWITH
881: 
882:         loc_oPg.AddObject("txt_4c_Csgrus", "TextBox")
883:         WITH loc_oPg.txt_4c_Csgrus
884:             .Value = ""
885:             .Top = 202
886:             .Left = 113
887:             .Width = 52
888:             .Height = 23
889:             .FontName = "Tahoma"
890:             .FontSize = 8
891:             .SpecialEffect = 1
892:             .MaxLength = 6
893:         ENDWITH

*-- Linhas 933 a 1063:
933:             .SpecialEffect = 1
934:             .MaxLength = 10
935:         ENDWITH
936:         BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "TabPrincipal_LinhasKeyPress")
937:         BINDEVENT(loc_oPg.txt_4c_Linhas, "LostFocus", THIS, "TabPrincipal_LinhasLostFocus")
938: 
939:         loc_oPg.AddObject("txt_4c_Dlinhas", "TextBox")
940:         WITH loc_oPg.txt_4c_Dlinhas
941:             .Value = ""
942:             .Top = 226
943:             .Left = 194
944:             .Width = 318
945:             .Height = 23
946:             .FontName = "Tahoma"
947:             .FontSize = 8
948:             .SpecialEffect = 1
949:             .ReadOnly = .T.
950:             .Enabled = .F.
951:         ENDWITH
952: 
953:         loc_oPg.AddObject("lbl_4c_LblColecoes", "Label")
954:         WITH loc_oPg.lbl_4c_LblColecoes
955:             .Caption = "Grupo de Venda :"
956:             .Top = 253
957:             .Left = 25
958:             .Width = 86
959:             .Height = 15
960:             .FontName = "Tahoma"
961:             .FontSize = 8
962:             .BackStyle = 0
963:             .ForeColor = RGB(90,90,90)
964:         ENDWITH
965: 
966:         loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
967:         WITH loc_oPg.txt_4c_Colecoes
968:             .Value = ""
969:             .Top = 250
970:             .Left = 113
971:             .Width = 80
972:             .Height = 23
973:             .FontName = "Tahoma"
974:             .FontSize = 8
975:             .SpecialEffect = 1
976:             .MaxLength = 10
977:         ENDWITH
978:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "TabPrincipal_ColecoesKeyPress")
979:         BINDEVENT(loc_oPg.txt_4c_Colecoes, "LostFocus", THIS, "TabPrincipal_ColecoesLostFocus")
980: 
981:         loc_oPg.AddObject("txt_4c_Dcolecoes", "TextBox")
982:         WITH loc_oPg.txt_4c_Dcolecoes
983:             .Value = ""
984:             .Top = 250
985:             .Left = 194
986:             .Width = 318
987:             .Height = 23
988:             .FontName = "Tahoma"
989:             .FontSize = 8
990:             .SpecialEffect = 1
991:             .ReadOnly = .T.
992:             .Enabled = .F.
993:         ENDWITH
994: 
995:         *-- === FORNECEDOR / REF ==============================================
996: 
997:         loc_oPg.AddObject("lbl_4c_LblIfors", "Label")
998:         WITH loc_oPg.lbl_4c_LblIfors
999:             .Caption = "Fornecedor :"
1000:             .Top = 278
1001:             .Left = 47
1002:             .Width = 64
1003:             .Height = 15
1004:             .FontName = "Tahoma"
1005:             .FontSize = 8
1006:             .BackStyle = 0
1007:             .ForeColor = RGB(90,90,90)
1008:         ENDWITH
1009: 
1010:         loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
1011:         WITH loc_oPg.txt_4c_Ifors
1012:             .Value = ""
1013:             .Top = 274
1014:             .Left = 113
1015:             .Width = 80
1016:             .Height = 23
1017:             .FontName = "Tahoma"
1018:             .FontSize = 8
1019:             .SpecialEffect = 1
1020:             .MaxLength = 10
1021:         ENDWITH
1022:         BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TabPrincipal_IforsKeyPress")
1023:         BINDEVENT(loc_oPg.txt_4c_Ifors, "LostFocus", THIS, "TabPrincipal_IforsLostFocus")
1024: 
1025:         loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
1026:         WITH loc_oPg.txt_4c_Dfors
1027:             .Value = ""
1028:             .Top = 274
1029:             .Left = 194
1030:             .Width = 318
1031:             .Height = 23
1032:             .FontName = "Tahoma"
1033:             .FontSize = 8
1034:             .SpecialEffect = 1
1035:             .ReadOnly = .T.
1036:             .Enabled = .F.
1037:         ENDWITH
1038: 
1039:         loc_oPg.AddObject("lbl_4c_LblReffs", "Label")
1040:         WITH loc_oPg.lbl_4c_LblReffs
1041:             .Caption = "Ref. Fornecedor :"
1042:             .Top = 301
1043:             .Left = 23
1044:             .Width = 88
1045:             .Height = 15
1046:             .FontName = "Tahoma"
1047:             .FontSize = 8
1048:             .BackStyle = 0
1049:             .ForeColor = RGB(90,90,90)
1050:         ENDWITH
1051: 
1052:         loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
1053:         WITH loc_oPg.txt_4c_Reffs
1054:             .Value = ""
1055:             .Top = 298
1056:             .Left = 113
1057:             .Width = 152
1058:             .Height = 23
1059:             .FontName = "Tahoma"
1060:             .FontSize = 8
1061:             .SpecialEffect = 1
1062:             .MaxLength = 40
1063:         ENDWITH

*-- Linhas 1169 a 1212:
1169:             .SpecialEffect = 1
1170:             .MaxLength = 14
1171:         ENDWITH
1172:         BINDEVENT(loc_oPg.txt_4c_Cproeqs, "KeyPress", THIS, "TabPrincipal_CproeqsKeyPress")
1173: 
1174:         loc_oPg.AddObject("lbl_4c_LblCbars", "Label")
1175:         WITH loc_oPg.lbl_4c_LblCbars
1176:             .Caption = "Barra :"
1177:             .Top = 157
1178:             .Left = 590
1179:             .Width = 35
1180:             .Height = 15
1181:             .FontName = "Tahoma"
1182:             .FontSize = 8
1183:             .BackStyle = 0
1184:             .ForeColor = RGB(90,90,90)
1185:         ENDWITH
1186: 
1187:         loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
1188:         WITH loc_oPg.txt_4c_Cbars
1189:             .Value = 0
1190:             .Top = 155
1191:             .Left = 626
1192:             .Width = 108
1193:             .Height = 21
1194:             .FontName = "Tahoma"
1195:             .FontSize = 8
1196:             .SpecialEffect = 1
1197:         ENDWITH
1198: 
1199:         loc_oPg.AddObject("lbl_4c_LblEan13", "Label")
1200:         WITH loc_oPg.lbl_4c_LblEan13
1201:             .Caption = "EAN/GTIN :"
1202:             .Top = 181
1203:             .Left = 568
1204:             .Width = 57
1205:             .Height = 15
1206:             .FontName = "Tahoma"
1207:             .FontSize = 8
1208:             .BackStyle = 0
1209:             .ForeColor = RGB(90,90,90)
1210:         ENDWITH
1211: 
1212:         loc_oPg.AddObject("txt_4c_Ean13", "TextBox")

*-- Linhas 1223 a 1293:
1223: 
1224:         *-- === SITUACAO / DATA SITUACAO ======================================
1225: 
1226:         loc_oPg.AddObject("opt_4c_Situas", "OptionGroup")
1227:         WITH loc_oPg.opt_4c_Situas
1228:             .Top = 130
1229:             .Left = 735
1230:             .Width = 142
1231:             .Height = 25
1232:             .ButtonCount = 2
1233:             .BorderStyle = 0
1234:             .Themes = .F.
1235:             .Value = 1
1236:         ENDWITH
1237:         WITH loc_oPg.opt_4c_Situas
1238:             .Buttons(1).Caption = "Ativo"
1239:             .Buttons(1).Left = 0
1240:             .Buttons(1).Top = 0
1241:             .Buttons(1).AutoSize = .T.
1242:             .Buttons(1).Themes = .F.
1243:             .Buttons(1).FontName = "Tahoma"
1244:             .Buttons(1).FontSize = 8
1245:             .Buttons(2).Caption = "Inativo"
1246:             .Buttons(2).Left = 60
1247:             .Buttons(2).Top = 0
1248:             .Buttons(2).AutoSize = .T.
1249:             .Buttons(2).Themes = .F.
1250:             .Buttons(2).FontName = "Tahoma"
1251:             .Buttons(2).FontSize = 8
1252:         ENDWITH
1253:         BINDEVENT(loc_oPg.opt_4c_Situas, "InteractiveChange", THIS, "OptSituasChange")
1254: 
1255:         loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
1256:         WITH loc_oPg.txt_4c_DtSituas
1257:             .Value = {}
1258:             .Top = 132
1259:             .Left = 878
1260:             .Width = 80
1261:             .Height = 21
1262:             .FontName = "Tahoma"
1263:             .FontSize = 8
1264:             .SpecialEffect = 1
1265:             .ReadOnly = .T.
1266:             .Enabled = .F.
1267:         ENDWITH
1268: 
1269:         *-- === LOTE MINIMO ===================================================
1270: 
1271:         loc_oPg.AddObject("lbl_4c_LblLtmins", "Label")
1272:         WITH loc_oPg.lbl_4c_LblLtmins
1273:             .Caption = "Lote M" + CHR(237) + "nimo :"
1274:             .Top = 157
1275:             .Left = 812
1276:             .Width = 65
1277:             .Height = 15
1278:             .FontName = "Tahoma"
1279:             .FontSize = 8
1280:             .BackStyle = 0
1281:             .ForeColor = RGB(90,90,90)
1282:         ENDWITH
1283: 
1284:         loc_oPg.AddObject("txt_4c_Ltminsv", "TextBox")
1285:         WITH loc_oPg.txt_4c_Ltminsv
1286:             .Value = 0
1287:             .Top = 154
1288:             .Left = 878
1289:             .Width = 80
1290:             .Height = 21
1291:             .FontName = "Tahoma"
1292:             .FontSize = 8
1293:             .SpecialEffect = 1

*-- Linhas 1585 a 1669:
1585:             .SpecialEffect = 1
1586:             .MaxLength = 3
1587:         ENDWITH
1588:         BINDEVENT(loc_oPg.txt_4c_Moecs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1589:         BINDEVENT(loc_oPg.txt_4c_Moecs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1590: 
1591:         loc_oPg.AddObject("lbl_4c_LblPvens", "Label")
1592:         WITH loc_oPg.lbl_4c_LblPvens
1593:             .Caption = "Valor de Venda :"
1594:             .Top = 400
1595:             .Left = 505
1596:             .Width = 120
1597:             .Height = 15
1598:             .FontName = "Tahoma"
1599:             .FontSize = 8
1600:             .BackStyle = 0
1601:             .ForeColor = RGB(90,90,90)
1602:         ENDWITH
1603: 
1604:         loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
1605:         WITH loc_oPg.txt_4c_Pvens
1606:             .Value = 0
1607:             .Top = 397
1608:             .Left = 626
1609:             .Width = 127
1610:             .Height = 21
1611:             .FontName = "Tahoma"
1612:             .FontSize = 8
1613:             .SpecialEffect = 1
1614:         ENDWITH
1615: 
1616:         loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
1617:         WITH loc_oPg.txt_4c_Moepvs
1618:             .Value = ""
1619:             .Top = 397
1620:             .Left = 754
1621:             .Width = 31
1622:             .Height = 21
1623:             .FontName = "Tahoma"
1624:             .FontSize = 8
1625:             .SpecialEffect = 1
1626:             .MaxLength = 3
1627:         ENDWITH
1628:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "KeyPress", THIS, "TabPrincipal_MoeKeyPress")
1629:         BINDEVENT(loc_oPg.txt_4c_Moepvs, "LostFocus", THIS, "TabPrincipal_MoeLostFocus")
1630: 
1631:         loc_oPg.AddObject("lbl_4c_LblFvendas", "Label")
1632:         WITH loc_oPg.lbl_4c_LblFvendas
1633:             .Caption = "Fator  de Venda :"
1634:             .Top = 422
1635:             .Left = 539
1636:             .Width = 86
1637:             .Height = 15
1638:             .FontName = "Tahoma"
1639:             .FontSize = 8
1640:             .BackStyle = 0
1641:             .ForeColor = RGB(90,90,90)
1642:         ENDWITH
1643: 
1644:         loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
1645:         WITH loc_oPg.txt_4c_Fvendas
1646:             .Value = 0
1647:             .Top = 419
1648:             .Left = 626
1649:             .Width = 127
1650:             .Height = 21
1651:             .FontName = "Tahoma"
1652:             .FontSize = 8
1653:             .SpecialEffect = 1
1654:         ENDWITH
1655: 
1656:         loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
1657:         WITH loc_oPg.txt_4c_Moevs
1658:             .Value = ""
1659:             .Top = 419
1660:             .Left = 754
1661:             .Width = 31
1662:             .Height = 21
1663:             .FontName = "Tahoma"
1664:             .FontSize = 8
1665:             .SpecialEffect = 1
1666:             .MaxLength = 3
1667:         ENDWITH
1668: 
1669:         *-- === AUDITORIA (ReadOnly) ==========================================

*-- Linhas 1790 a 1876:
1790:             .SpecialEffect = 1
1791:             .MaxLength = 3
1792:         ENDWITH
1793:         BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "TabPrincipal_CunisKeyPress")
1794:         BINDEVENT(loc_oPg.txt_4c_Cunis, "LostFocus", THIS, "TabPrincipal_CunisLostFocus")
1795: 
1796:         loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
1797:         WITH loc_oPg.txt_4c_Dunis
1798:             .Value = ""
1799:             .Top = 394
1800:             .Left = 145
1801:             .Width = 150
1802:             .Height = 23
1803:             .FontName = "Tahoma"
1804:             .FontSize = 8
1805:             .SpecialEffect = 1
1806:             .ReadOnly = .T.
1807:             .Enabled = .F.
1808:         ENDWITH
1809: 
1810:         loc_oPg.AddObject("lbl_4c_LblCunips", "Label")
1811:         WITH loc_oPg.lbl_4c_LblCunips
1812:             .Caption = "(2) :"
1813:             .Top = 398
1814:             .Left = 301
1815:             .Width = 23
1816:             .Height = 15
1817:             .FontName = "Tahoma"
1818:             .FontSize = 8
1819:             .BackStyle = 0
1820:             .ForeColor = RGB(90,90,90)
1821:         ENDWITH
1822: 
1823:         loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
1824:         WITH loc_oPg.txt_4c_Cunips
1825:             .Value = ""
1826:             .Top = 394
1827:             .Left = 330
1828:             .Width = 31
1829:             .Height = 23
1830:             .FontName = "Tahoma"
1831:             .FontSize = 8
1832:             .SpecialEffect = 1
1833:             .MaxLength = 3
1834:         ENDWITH
1835:         BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "TabPrincipal_CunipsKeyPress")
1836:         BINDEVENT(loc_oPg.txt_4c_Cunips, "LostFocus", THIS, "TabPrincipal_CunipsLostFocus")
1837: 
1838:         loc_oPg.AddObject("txt_4c_Dunips", "TextBox")
1839:         WITH loc_oPg.txt_4c_Dunips
1840:             .Value = ""
1841:             .Top = 394
1842:             .Left = 362
1843:             .Width = 150
1844:             .Height = 23
1845:             .FontName = "Tahoma"
1846:             .FontSize = 8
1847:             .SpecialEffect = 1
1848:             .ReadOnly = .T.
1849:             .Enabled = .F.
1850:         ENDWITH
1851: 
1852:         *-- === CLASSIFICACAO / MODELO / ACABAMENTO / LOCAL ===================
1853: 
1854:         loc_oPg.AddObject("lbl_4c_LblCclass", "Label")
1855:         WITH loc_oPg.lbl_4c_LblCclass
1856:             .Caption = "Classifica" + CHR(231) + CHR(227) + "o :"
1857:             .Top = 374
1858:             .Left = 7
1859:             .Width = 104
1860:             .Height = 15
1861:             .FontName = "Tahoma"
1862:             .FontSize = 8
1863:             .BackStyle = 0
1864:             .ForeColor = RGB(90,90,90)
1865:         ENDWITH
1866: 
1867:         loc_oPg.AddObject("txt_4c_Cclass", "TextBox")
1868:         WITH loc_oPg.txt_4c_Cclass
1869:             .Value = ""
1870:             .Top = 370
1871:             .Left = 113
1872:             .Width = 31
1873:             .Height = 23
1874:             .FontName = "Tahoma"
1875:             .FontSize = 8
1876:             .SpecialEffect = 1

*-- Linhas 1956 a 2000:
1956:             .SpecialEffect = 1
1957:             .MaxLength = 3
1958:         ENDWITH
1959:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "KeyPress", THIS, "TabPrincipal_CodacbsKeyPress")
1960:         BINDEVENT(loc_oPg.txt_4c_Codacbs, "LostFocus", THIS, "TabPrincipal_CodacbsLostFocus")
1961: 
1962:         loc_oPg.AddObject("txt_4c_Dcodacbs", "TextBox")
1963:         WITH loc_oPg.txt_4c_Dcodacbs
1964:             .Value = ""
1965:             .Top = 346
1966:             .Left = 145
1967:             .Width = 150
1968:             .Height = 23
1969:             .FontName = "Tahoma"
1970:             .FontSize = 8
1971:             .SpecialEffect = 1
1972:             .ReadOnly = .T.
1973:             .Enabled = .F.
1974:         ENDWITH
1975: 
1976:         loc_oPg.AddObject("lbl_4c_LblLocals", "Label")
1977:         WITH loc_oPg.lbl_4c_LblLocals
1978:             .Caption = "Local :"
1979:             .Top = 374
1980:             .Left = 364
1981:             .Width = 33
1982:             .Height = 15
1983:             .FontName = "Tahoma"
1984:             .FontSize = 8
1985:             .BackStyle = 0
1986:             .ForeColor = RGB(90,90,90)
1987:         ENDWITH
1988: 
1989:         loc_oPg.AddObject("txt_4c_Locals", "TextBox")
1990:         WITH loc_oPg.txt_4c_Locals
1991:             .Value = ""
1992:             .Top = 370
1993:             .Left = 401
1994:             .Width = 111
1995:             .Height = 23
1996:             .FontName = "Tahoma"
1997:             .FontSize = 8
1998:             .SpecialEffect = 1
1999:             .MaxLength = 10
2000:         ENDWITH

*-- Linhas 2076 a 2147:
2076:             .SpecialEffect = 1
2077:             .MaxLength = 4
2078:         ENDWITH
2079:         BINDEVENT(loc_oPg.txt_4c_Codcors, "KeyPress", THIS, "TabPrincipal_CodcorsKeyPress")
2080:         BINDEVENT(loc_oPg.txt_4c_Codcors, "LostFocus", THIS, "TabPrincipal_CodcorsLostFocus")
2081: 
2082:         loc_oPg.AddObject("lbl_4c_LblCodtams", "Label")
2083:         WITH loc_oPg.lbl_4c_LblCodtams
2084:             .Caption = "Tam:"
2085:             .Top = 302
2086:             .Left = 442
2087:             .Width = 30
2088:             .Height = 15
2089:             .FontName = "Tahoma"
2090:             .FontSize = 8
2091:             .BackStyle = 0
2092:             .ForeColor = RGB(90,90,90)
2093:         ENDWITH
2094: 
2095:         loc_oPg.AddObject("txt_4c_Codtams", "TextBox")
2096:         WITH loc_oPg.txt_4c_Codtams
2097:             .Value = ""
2098:             .Top = 298
2099:             .Left = 474
2100:             .Width = 38
2101:             .Height = 23
2102:             .FontName = "Tahoma"
2103:             .FontSize = 8
2104:             .SpecialEffect = 1
2105:             .MaxLength = 4
2106:         ENDWITH
2107:         BINDEVENT(loc_oPg.txt_4c_Codtams, "KeyPress", THIS, "TabPrincipal_CodtamsKeyPress")
2108: 
2109:         loc_oPg.AddObject("lbl_4c_LblCodident", "Label")
2110:         WITH loc_oPg.lbl_4c_LblCodident
2111:             .Caption = "Cod. Identidade :"
2112:             .Top = 422
2113:             .Left = 24
2114:             .Width = 87
2115:             .Height = 15
2116:             .FontName = "Tahoma"
2117:             .FontSize = 8
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(90,90,90)
2120:         ENDWITH
2121: 
2122:         loc_oPg.AddObject("txt_4c_Codident", "TextBox")
2123:         WITH loc_oPg.txt_4c_Codident
2124:             .Value = ""
2125:             .Top = 418
2126:             .Left = 113
2127:             .Width = 182
2128:             .Height = 23
2129:             .FontName = "Tahoma"
2130:             .FontSize = 8
2131:             .SpecialEffect = 1
2132:             .MaxLength = 20
2133:         ENDWITH
2134: 
2135:         *-- === GARANTIA / PRODUTO WEB / VARIACAO =============================
2136: 
2137:         loc_oPg.AddObject("lbl_4c_LblDiasgar", "Label")
2138:         WITH loc_oPg.lbl_4c_LblDiasgar
2139:             .Caption = "Garantia :"
2140:             .Top = 228
2141:             .Left = 827
2142:             .Width = 50
2143:             .Height = 15
2144:             .FontName = "Tahoma"
2145:             .FontSize = 8
2146:             .BackStyle = 0
2147:             .ForeColor = RGB(90,90,90)

*-- Linhas 2198 a 2324:
2198:             .ForeColor = RGB(90,90,90)
2199:         ENDWITH
2200: 
2201:         loc_oPg.AddObject("opt_4c_ProdWeb", "OptionGroup")
2202:         WITH loc_oPg.opt_4c_ProdWeb
2203:             .Top = 172
2204:             .Left = 879
2205:             .Width = 117
2206:             .Height = 42
2207:             .ButtonCount = 4
2208:             .BorderStyle = 0
2209:             .Themes = .F.
2210:             .Value = 1
2211:         ENDWITH
2212:         WITH loc_oPg.opt_4c_ProdWeb
2213:             .Buttons(1).Caption = "N" + CHR(227) + "o"
2214:             .Buttons(1).Left = 0 
2215:             .Buttons(1).Top = 0
2216:             .Buttons(1).AutoSize = .T.
2217:             .Buttons(1).Themes = .F.
2218:             .Buttons(1).FontName = "Tahoma"
2219:             .Buttons(1).FontSize = 8
2220:             .Buttons(2).Caption = "Sim"  
2221:             .Buttons(2).Left = 35
2222:             .Buttons(2).Top = 0
2223:             .Buttons(2).AutoSize = .T.
2224:             .Buttons(2).Themes = .F.
2225:             .Buttons(2).FontName = "Tahoma"
2226:             .Buttons(2).FontSize = 8
2227:             .Buttons(3).Caption = "Img"  
2228:             .Buttons(3).Left = 65
2229:             .Buttons(3).Top = 0
2230:             .Buttons(3).AutoSize = .T.
2231:             .Buttons(3).Themes = .F.
2232:             .Buttons(3).FontName = "Tahoma"
2233:             .Buttons(3).FontSize = 8
2234:             .Buttons(4).Caption = "Sim+Img"
2235:             .Buttons(4).Left = 0
2236:             .Buttons(4).Top = 22
2237:             .Buttons(4).AutoSize = .T.
2238:             .Buttons(4).Themes = .F.
2239:             .Buttons(4).FontName = "Tahoma"
2240:             .Buttons(4).FontSize = 8
2241:         ENDWITH
2242:         BINDEVENT(loc_oPg.opt_4c_ProdWeb, "InteractiveChange", THIS, "OptProdWebChange")
2243: 
2244:         loc_oPg.AddObject("lbl_4c_LblVariacao", "Label")
2245:         WITH loc_oPg.lbl_4c_LblVariacao
2246:             .Caption = "Varia" + CHR(231) + CHR(227) + "o :"
2247:             .Top = 207
2248:             .Left = 827
2249:             .Width = 50
2250:             .Height = 15
2251:             .FontName = "Tahoma"
2252:             .FontSize = 8
2253:             .BackStyle = 0
2254:             .ForeColor = RGB(90,90,90)
2255:         ENDWITH
2256: 
2257:         loc_oPg.AddObject("opt_4c_Varias", "OptionGroup")
2258:         WITH loc_oPg.opt_4c_Varias
2259:             .Top = 203
2260:             .Left = 874
2261:             .Width = 107
2262:             .Height = 22
2263:             .ButtonCount = 2
2264:             .BorderStyle = 0
2265:             .Themes = .F.
2266:             .Value = 2
2267:         ENDWITH
2268:         WITH loc_oPg.opt_4c_Varias
2269:             .Buttons(1).Caption = "Sim"        
2270:             .Buttons(1).Left = 0 
2271:             .Buttons(1).Top = 0
2272:             .Buttons(1).AutoSize = .T.
2273:             .Buttons(1).Themes = .F.
2274:             .Buttons(1).FontName = "Tahoma"
2275:             .Buttons(1).FontSize = 8
2276:             .Buttons(2).Caption = "N" + CHR(227) + "o"
2277:             .Buttons(2).Left = 42
2278:             .Buttons(2).Top = 0
2279:             .Buttons(2).AutoSize = .T.
2280:             .Buttons(2).Themes = .F.
2281:             .Buttons(2).FontName = "Tahoma"
2282:             .Buttons(2).FontSize = 8
2283:         ENDWITH
2284:         BINDEVENT(loc_oPg.opt_4c_Varias, "InteractiveChange", THIS, "OptVariasChange")
2285: 
2286:         *-- === DIMENSOES FINAS (altura/largura/diametro/espessura/comprimento) =
2287: 
2288:         loc_oPg.AddObject("lbl_4c_LblAltura", "Label")
2289:         WITH loc_oPg.lbl_4c_LblAltura
2290:             .Caption = "Altura :"
2291:             .Top = 474
2292:             .Left = 749
2293:             .Width = 38
2294:             .Height = 15
2295:             .FontName = "Tahoma"
2296:             .FontSize = 8
2297:             .BackStyle = 0
2298:             .ForeColor = RGB(90,90,90)
2299:         ENDWITH
2300:         loc_oPg.AddObject("txt_4c_Altura", "TextBox")
2301:         WITH loc_oPg.txt_4c_Altura
2302:             .Value = 0
2303:             .Top = 471
2304:             .Left = 791
2305:             .Width = 48
2306:             .Height = 21
2307:             .FontName = "Tahoma"
2308:             .FontSize = 8
2309:             .SpecialEffect = 1
2310:         ENDWITH
2311:         loc_oPg.AddObject("lbl_4c_MmAltura", "Label")
2312:         WITH loc_oPg.lbl_4c_MmAltura
2313:             .Caption = "MM"
2314:             .Top = 475
2315:             .Left = 844
2316:             .Width = 18
2317:             .Height = 15
2318:             .FontName = "Tahoma"
2319:             .FontSize = 8
2320:             .BackStyle = 0
2321:             .ForeColor = RGB(90,90,90)
2322:         ENDWITH
2323: 
2324:         loc_oPg.AddObject("lbl_4c_LblLargura", "Label")

*-- Linhas 2781 a 2824:
2781:     * ConfigurarTabComposicao - Aba 2: Composicao de materiais (pgComposicao)
2782:     * IMPLEMENTADO NA FASE 5
2783:     *--------------------------------------------------------------------------
2784:     PROTECTED PROCEDURE ConfigurarTabComposicao()
2785:         LOCAL loc_oPg
2786:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2787: 
2788:         *-- GradeGRUPO (top=34, left=582, width=229, height=107, 3 cols)
2789:         *-- Mostra totais por grupo de composicao
2790:         loc_oPg.AddObject("grd_4c_GrupoCompo", "Grid")
2791:         WITH loc_oPg.grd_4c_GrupoCompo
2792:             .Top         = 34
2793:             .Left        = 582
2794:             .Width       = 229
2795:             .Height      = 107
2796:             .ReadOnly    = .T.
2797:             .DeleteMark  = .F.
2798:             .RecordMark  = .F.
2799:             .ScrollBars  = 3
2800:             .GridLines   = 3
2801:             .ColumnCount = 3
2802:             .FontName    = "Verdana"
2803:             .FontSize    = 8
2804:             .Visible     = .T.
2805:         ENDWITH
2806:         WITH loc_oPg.grd_4c_GrupoCompo
2807:             .Column1.Header1.Caption = "Grupo"
2808:             .Column1.Width = 70
2809:             .Column2.Header1.Caption = "Total"
2810:             .Column2.Width = 95
2811:             .Column3.Header1.Caption = "Moe"
2812:             .Column3.Width = 50
2813:         ENDWITH
2814: 
2815:         *-- grdCompo - Composicao principal (top=148, left=6, width=943, height=147, 14 cols)
2816:         *-- Dados: SIGPRCPO - Material, Descricao, Unidade, Valor, Qtde, Total, Moeda, Obs, Etiq, Consumo, QtdCV, UnCV, Ordem, Compos
2817:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
2818:         WITH loc_oPg.grd_4c_Compo
2819:             .Top         = 148
2820:             .Left        = 6
2821:             .Width       = 943
2822:             .Height      = 147
2823:             .ReadOnly    = .T.
2824:             .DeleteMark  = .F.

*-- Linhas 3189 a 3355:
3189:             .ToolTipText     = "Incluir"
3190:             .Visible         = .T.
3191:         ENDWITH
3192:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoIncluir, "Click", THIS, "CmdCompoIncluirClick")
3193: 
3194:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoExcluir", "CommandButton")
3195:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir
3196:             .Caption         = "-"
3197:             .Top             = 42
3198:             .Left            = 0
3199:             .Width           = 50
3200:             .Height          = 42
3201:             .FontName        = "Tahoma"
3202:             .FontSize        = 14
3203:             .FontBold        = .T.
3204:             .Themes          = .F.
3205:             .SpecialEffect   = 0
3206:             .BackColor       = RGB(255,255,255)
3207:             .ForeColor       = RGB(180,0,0)
3208:             .ToolTipText     = "Excluir"
3209:             .Visible         = .T.
3210:         ENDWITH
3211:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoExcluir, "Click", THIS, "CmdCompoExcluirClick")
3212: 
3213:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoAtualizar", "CommandButton")
3214:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar
3215:             .Caption         = CHR(8635)
3216:             .Top             = 84
3217:             .Left            = 0
3218:             .Width           = 50
3219:             .Height          = 42
3220:             .FontName        = "Tahoma"
3221:             .FontSize        = 10
3222:             .Themes          = .F.
3223:             .SpecialEffect   = 0
3224:             .BackColor       = RGB(255,255,255)
3225:             .ForeColor       = RGB(0,0,180)
3226:             .ToolTipText     = "Atualizar Pre" + CHR(231) + "os"
3227:             .Visible         = .T.
3228:         ENDWITH
3229:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoAtualizar, "Click", THIS, "CmdCompoAtualizarClick")
3230: 
3231:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoPeso", "CommandButton")
3232:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso
3233:             .Caption         = "Kg"
3234:             .Top             = 126
3235:             .Left            = 0
3236:             .Width           = 50
3237:             .Height          = 42
3238:             .FontName        = "Tahoma"
3239:             .FontSize        = 8
3240:             .Themes          = .F.
3241:             .SpecialEffect   = 0
3242:             .BackColor       = RGB(255,255,255)
3243:             .ForeColor       = RGB(90,90,90)
3244:             .ToolTipText     = "Atualizar Pesos"
3245:             .Visible         = .T.
3246:         ENDWITH
3247:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoPeso, "Click", THIS, "CmdCompoAtuPesosClick")
3248: 
3249:         loc_oPg.obj_4c_CmdgCompo.AddObject("cmd_4c_CompoRecalc", "CommandButton")
3250:         WITH loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc
3251:             .Caption         = "="
3252:             .Top             = 168
3253:             .Left            = 0
3254:             .Width           = 50
3255:             .Height          = 42
3256:             .FontName        = "Tahoma"
3257:             .FontSize        = 14
3258:             .Themes          = .F.
3259:             .SpecialEffect   = 0
3260:             .BackColor       = RGB(255,255,255)
3261:             .ForeColor       = RGB(90,90,90)
3262:             .ToolTipText     = "Recalcular"
3263:             .Visible         = .T.
3264:         ENDWITH
3265:         BINDEVENT(loc_oPg.obj_4c_CmdgCompo.cmd_4c_CompoRecalc, "Click", THIS, "CmdCompoRecalcClick")
3266: 
3267:         *-- === COMANDOS PARA grdsubcp (Container com 2 botoes, top=345, left=947) ==========
3268:         loc_oPg.AddObject("obj_4c_CmdgSubCp", "Container")
3269:         WITH loc_oPg.obj_4c_CmdgSubCp
3270:             .Top         = 345
3271:             .Left        = 947
3272:             .Width       = 50
3273:             .Height      = 90
3274:             .BackStyle   = 0
3275:             .BorderWidth = 0
3276:             .Visible     = .T.
3277:         ENDWITH
3278: 
3279:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpIncluir", "CommandButton")
3280:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir
3281:             .Caption         = "+"
3282:             .Top             = 0
3283:             .Left            = 0
3284:             .Width           = 50
3285:             .Height          = 45
3286:             .FontName        = "Tahoma"
3287:             .FontSize        = 14
3288:             .FontBold        = .T.
3289:             .Themes          = .F.
3290:             .SpecialEffect   = 0
3291:             .BackColor       = RGB(255,255,255)
3292:             .ForeColor       = RGB(0,128,0)
3293:             .ToolTipText     = "Incluir Sub-Componente"
3294:             .Visible         = .T.
3295:         ENDWITH
3296:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpIncluir, "Click", THIS, "CmdSubCpIncluirClick")
3297: 
3298:         loc_oPg.obj_4c_CmdgSubCp.AddObject("cmd_4c_SubCpExcluir", "CommandButton")
3299:         WITH loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir
3300:             .Caption         = "-"
3301:             .Top             = 45
3302:             .Left            = 0
3303:             .Width           = 50
3304:             .Height          = 45
3305:             .FontName        = "Tahoma"
3306:             .FontSize        = 14
3307:             .FontBold        = .T.
3308:             .Themes          = .F.
3309:             .SpecialEffect   = 0
3310:             .BackColor       = RGB(255,255,255)
3311:             .ForeColor       = RGB(180,0,0)
3312:             .ToolTipText     = "Excluir Sub-Componente"
3313:             .Visible         = .T.
3314:         ENDWITH
3315:         BINDEVENT(loc_oPg.obj_4c_CmdgSubCp.cmd_4c_SubCpExcluir, "Click", THIS, "CmdSubCpExcluirClick")
3316: 
3317:         *-- === OBSERVACAO E DESCRICAO (entre grdCompo e grdsubcp, top=297-325) =============
3318:         loc_oPg.AddObject("lbl_4c_Label4", "Label")
3319:         WITH loc_oPg.lbl_4c_Label4
3320:             .Caption   = "Obs. da OF :"
3321:             .Top       = 300
3322:             .Left      = 36
3323:             .Width     = 64
3324:             .Height    = 15
3325:             .FontName  = "Tahoma"
3326:             .FontSize  = 8
3327:             .BackStyle = 0
3328:             .ForeColor = RGB(90,90,90)
3329:         ENDWITH
3330: 
3331:         loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
3332:         WITH loc_oPg.txt_4c_ObsOFs
3333:             .Value    = ""
3334:             .Top      = 297
3335:             .Left     = 99
3336:             .Width    = 850
3337:             .Height   = 21
3338:             .FontName = "Tahoma"
3339:             .FontSize = 8
3340:             .MaxLength = 100
3341:         ENDWITH
3342: 
3343:         loc_oPg.AddObject("lbl_4c_Label16", "Label")
3344:         WITH loc_oPg.lbl_4c_Label16
3345:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3346:             .Top       = 324
3347:             .Left      = 45
3348:             .Width     = 55
3349:             .Height    = 15
3350:             .FontName  = "Tahoma"
3351:             .FontSize  = 8
3352:             .BackStyle = 0
3353:             .ForeColor = RGB(90,90,90)
3354:         ENDWITH
3355: 

*-- Linhas 3363 a 3515:
3363:             .FontName = "Tahoma"
3364:             .FontSize = 8
3365:         ENDWITH
3366:         BINDEVENT(loc_oPg.txt_4c_Desc, "LostFocus", THIS, "TabCompo_DescLostFocus")
3367: 
3368:         loc_oPg.AddObject("lbl_4c_Label15", "Label")
3369:         WITH loc_oPg.lbl_4c_Label15
3370:             .Caption   = "Material Principal :"
3371:             .Top       = 324
3372:             .Left      = 421
3373:             .Width     = 89
3374:             .Height    = 15
3375:             .FontName  = "Tahoma"
3376:             .FontSize  = 8
3377:             .BackStyle = 0
3378:             .ForeColor = RGB(90,90,90)
3379:         ENDWITH
3380: 
3381:         loc_oPg.AddObject("txt_4c_MatP", "TextBox")
3382:         WITH loc_oPg.txt_4c_MatP
3383:             .Value    = ""
3384:             .Top      = 321
3385:             .Left     = 517
3386:             .Width    = 108
3387:             .Height   = 21
3388:             .FontName = "Tahoma"
3389:             .FontSize = 8
3390:         ENDWITH
3391:         BINDEVENT(loc_oPg.txt_4c_MatP, "LostFocus", THIS, "TabCompo_MatPLostFocus")
3392: 
3393:         *-- === CAMPOS SUB-COMPONENTE (abaixo de grdsubcp, top=432-435) =====================
3394:         loc_oPg.AddObject("lbl_4c_Label3", "Label")
3395:         WITH loc_oPg.lbl_4c_Label3
3396:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
3397:             .Top       = 435
3398:             .Left      = 39
3399:             .Width     = 55
3400:             .Height    = 15
3401:             .FontName  = "Tahoma"
3402:             .FontSize  = 8
3403:             .BackStyle = 0
3404:             .ForeColor = RGB(90,90,90)
3405:         ENDWITH
3406: 
3407:         loc_oPg.AddObject("txt_4c__desccp", "TextBox")
3408:         WITH loc_oPg.txt_4c__desccp
3409:             .Value    = ""
3410:             .Top      = 432
3411:             .Left     = 99
3412:             .Width    = 298
3413:             .Height   = 21
3414:             .FontName = "Tahoma"
3415:             .FontSize = 8
3416:         ENDWITH
3417:         BINDEVENT(loc_oPg.txt_4c__desccp, "LostFocus", THIS, "TabCompo_DesccpLostFocus")
3418: 
3419:         loc_oPg.AddObject("lbl_4c_Label5", "Label")
3420:         WITH loc_oPg.lbl_4c_Label5
3421:             .Caption   = "Substitui :"
3422:             .Top       = 435
3423:             .Left      = 465
3424:             .Width     = 50
3425:             .Height    = 15
3426:             .FontName  = "Tahoma"
3427:             .FontSize  = 8
3428:             .BackStyle = 0
3429:             .ForeColor = RGB(90,90,90)
3430:         ENDWITH
3431: 
3432:         loc_oPg.AddObject("txt_4c__matsub", "TextBox")
3433:         WITH loc_oPg.txt_4c__matsub
3434:             .Value    = ""
3435:             .Top      = 432
3436:             .Left     = 517
3437:             .Width    = 108
3438:             .Height   = 21
3439:             .FontName = "Tahoma"
3440:             .FontSize = 8
3441:         ENDWITH
3442:         BINDEVENT(loc_oPg.txt_4c__matsub, "LostFocus", THIS, "TabCompo_MatsubLostFocus")
3443: 
3444:         *-- === CHECKBOXES LIBERAR CUSTO / VENDA (top=458-459) ==============================
3445:         loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
3446:         WITH loc_oPg.chk_4c_ChkLiberaCusto
3447:             .Caption   = "Custo"
3448:             .Value     = .F.
3449:             .Top       = 458
3450:             .Left      = 9
3451:             .Width     = 39
3452:             .Height    = 38
3453:             .FontName  = "Tahoma"
3454:             .FontSize  = 8
3455:             .BackStyle = 0
3456:             .Themes    = .F.
3457:             .Visible   = .T.
3458:         ENDWITH
3459:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")
3460: 
3461:         loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
3462:         WITH loc_oPg.chk_4c_ChkLiberaVenda
3463:             .Caption   = "Venda"
3464:             .Value     = .F.
3465:             .Top       = 459
3466:             .Left      = 323
3467:             .Width     = 39
3468:             .Height    = 38
3469:             .FontName  = "Tahoma"
3470:             .FontSize  = 8
3471:             .BackStyle = 0
3472:             .Themes    = .F.
3473:             .Visible   = .T.
3474:         ENDWITH
3475:         BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")
3476: 
3477:         *-- === LABELS DIVISORES CUSTO/VENDA (top=473-474) ==================================
3478:         loc_oPg.AddObject("lbl_4c_Label1", "Label")
3479:         WITH loc_oPg.lbl_4c_Label1
3480:             .Caption   = " Custo "
3481:             .Top       = 473
3482:             .Left      = 47
3483:             .Width     = 46
3484:             .Height    = 16
3485:             .FontName  = "Tahoma"
3486:             .FontSize  = 8
3487:             .BackStyle = 1
3488:             .BackColor = RGB(220,220,220)
3489:             .ForeColor = RGB(50,50,50)
3490:         ENDWITH
3491: 
3492:         loc_oPg.AddObject("lbl_4c_Label2", "Label")
3493:         WITH loc_oPg.lbl_4c_Label2
3494:             .Caption   = " Venda "
3495:             .Top       = 474
3496:             .Left      = 361
3497:             .Width     = 48
3498:             .Height    = 16
3499:             .FontName  = "Tahoma"
3500:             .FontSize  = 8
3501:             .BackStyle = 1
3502:             .BackColor = RGB(220,220,220)
3503:             .ForeColor = RGB(50,50,50)
3504:         ENDWITH
3505: 
3506:         *-- === SHAPES DIVISORES VISUAIS (top=497-498) ======================================
3507:         loc_oPg.AddObject("shp_4c_Shape6", "Shape")
3508:         WITH loc_oPg.shp_4c_Shape6
3509:             .Top         = 497
3510:             .Left        = 9
3511:             .Width       = 158
3512:             .Height      = 2
3513:             .BackColor   = RGB(180,180,180)
3514:             .BackStyle   = 1
3515:             .BorderColor = RGB(180,180,180)

*-- Linhas 3613 a 3683:
3613:             .ToolTipText     = "Calcular Peso"
3614:             .Visible         = .T.
3615:         ENDWITH
3616:         BINDEVENT(loc_oPg.cmd_4c_CmdPesoM, "Click", THIS, "CmdPesoMClick")
3617: 
3618:         *-- Say22 "MKP" (top=542, left=9) - label para Get_cmkpc
3619:         loc_oPg.AddObject("lbl_4c_Label22", "Label")
3620:         WITH loc_oPg.lbl_4c_Label22
3621:             .Caption   = "MKP"
3622:             .Top       = 542
3623:             .Left      = 9
3624:             .Width     = 22
3625:             .Height    = 15
3626:             .FontName  = "Tahoma"
3627:             .FontSize  = 8
3628:             .BackStyle = 0
3629:             .ForeColor = RGB(90,90,90)
3630:         ENDWITH
3631: 
3632:         *-- Get_cmkpc (top=557, left=9, w=24): markup de custo
3633:         loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
3634:         WITH loc_oPg.txt_4c_Cmkpc
3635:             .Value    = ""
3636:             .Top      = 557
3637:             .Left     = 9
3638:             .Width    = 24
3639:             .Height   = 23
3640:             .FontName = "Tahoma"
3641:             .FontSize = 8
3642:         ENDWITH
3643:         BINDEVENT(loc_oPg.txt_4c_Cmkpc, "LostFocus", THIS, "TabCompo_CmkpcLostFocus")
3644: 
3645:         *-- lblValAdics (top=542, left=64): "Valor Adicional"
3646:         loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
3647:         WITH loc_oPg.lbl_4c_LblValAdics
3648:             .Caption   = "Valor Adicional"
3649:             .Top       = 542
3650:             .Left      = 64
3651:             .Width     = 71
3652:             .Height    = 15
3653:             .FontName  = "Tahoma"
3654:             .FontSize  = 8
3655:             .BackStyle = 0
3656:             .ForeColor = RGB(90,90,90)
3657:         ENDWITH
3658: 
3659:         *-- get_pftioc (top=557, left=64, w=94): valor adicional custo (read-only)
3660:         loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
3661:         WITH loc_oPg.txt_4c__pftioc
3662:             .Value    = 0
3663:             .Top      = 557
3664:             .Left     = 64
3665:             .Width    = 94
3666:             .Height   = 23
3667:             .FontName = "Tahoma"
3668:             .FontSize = 8
3669:             .ReadOnly = .T.
3670:         ENDWITH
3671: 
3672:         *-- chkPlanCus (top=556, left=36): planejamento custo
3673:         loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
3674:         WITH loc_oPg.chk_4c_ChkPlanCus
3675:             .Caption   = ""
3676:             .Value     = .F.
3677:             .Top       = 556
3678:             .Left      = 36
3679:             .Width     = 25
3680:             .Height    = 25
3681:             .BackStyle = 0
3682:             .Themes    = .F.
3683:             .Visible   = .T.

*-- Linhas 3709 a 3792:
3709:             .FontName = "Tahoma"
3710:             .FontSize = 8
3711:         ENDWITH
3712:         BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TabCompo_MargemLostFocus")
3713: 
3714:         *-- lblIdeal "Preco Ideal (Moeda 1)" (top=503, left=416)
3715:         loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
3716:         WITH loc_oPg.lbl_4c_LblIdeal
3717:             .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
3718:             .Top       = 503
3719:             .Left      = 416
3720:             .Width     = 111
3721:             .Height    = 15
3722:             .FontName  = "Tahoma"
3723:             .FontSize  = 8
3724:             .BackStyle = 0
3725:             .ForeColor = RGB(90,90,90)
3726:         ENDWITH
3727: 
3728:         *-- getPvideal (top=517, left=416, w=110): preco ideal (read-only)
3729:         loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
3730:         WITH loc_oPg.txt_4c_Pvideal
3731:             .Value    = 0
3732:             .Top      = 517
3733:             .Left     = 416
3734:             .Width    = 110
3735:             .Height   = 23
3736:             .FontName = "Tahoma"
3737:             .FontSize = 8
3738:             .ReadOnly = .T.
3739:         ENDWITH
3740: 
3741:         *-- getMoeda (top=517, left=529, w=31): moeda de venda (editable+lookup)
3742:         loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
3743:         WITH loc_oPg.txt_4c_Moeda
3744:             .Value    = ""
3745:             .Top      = 517
3746:             .Left     = 529
3747:             .Width    = 31
3748:             .Height   = 23
3749:             .FontName = "Tahoma"
3750:             .FontSize = 8
3751:         ENDWITH
3752:         BINDEVENT(loc_oPg.txt_4c_Moeda, "LostFocus", THIS, "TabCompo_MoedaLostFocus")
3753: 
3754:         *-- lblFIdeals "Fator Ideal" (top=503, left=563)
3755:         loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
3756:         WITH loc_oPg.lbl_4c_LblFIdeals
3757:             .Caption   = "Fator Ideal"
3758:             .Top       = 503
3759:             .Left      = 563
3760:             .Width     = 55
3761:             .Height    = 15
3762:             .FontName  = "Tahoma"
3763:             .FontSize  = 8
3764:             .BackStyle = 0
3765:             .ForeColor = RGB(90,90,90)
3766:         ENDWITH
3767: 
3768:         *-- getFIdeals (top=517, left=563, w=110): fator ideal (read-only)
3769:         loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
3770:         WITH loc_oPg.txt_4c_FIdeals
3771:             .Value    = 0
3772:             .Top      = 517
3773:             .Left     = 563
3774:             .Width    = 110
3775:             .Height   = 23
3776:             .FontName = "Tahoma"
3777:             .FontSize = 8
3778:             .ReadOnly = .T.
3779:         ENDWITH
3780: 
3781:         *-- Say14 "MKP" (top=542, left=360) - label para Getftio
3782:         loc_oPg.AddObject("lbl_4c_Label14", "Label")
3783:         WITH loc_oPg.lbl_4c_Label14
3784:             .Caption   = "MKP"
3785:             .Top       = 542
3786:             .Left      = 360
3787:             .Width     = 22
3788:             .Height    = 15
3789:             .FontName  = "Tahoma"
3790:             .FontSize  = 8
3791:             .BackStyle = 0
3792:             .ForeColor = RGB(90,90,90)

*-- Linhas 3803 a 3846:
3803:             .FontName = "Tahoma"
3804:             .FontSize = 8
3805:         ENDWITH
3806:         BINDEVENT(loc_oPg.txt_4c_Ftio, "LostFocus", THIS, "TabCompo_FtioLostFocus")
3807: 
3808:         *-- Say13 "Valor Adicional" (top=542, left=416)
3809:         loc_oPg.AddObject("lbl_4c_Label13", "Label")
3810:         WITH loc_oPg.lbl_4c_Label13
3811:             .Caption   = "Valor Adicional"
3812:             .Top       = 542
3813:             .Left      = 416
3814:             .Width     = 71
3815:             .Height    = 15
3816:             .FontName  = "Tahoma"
3817:             .FontSize  = 8
3818:             .BackStyle = 0
3819:             .ForeColor = RGB(90,90,90)
3820:         ENDWITH
3821: 
3822:         *-- Get_Pftio (top=557, left=416, w=110): valor adicional/preco com fiacao (read-only)
3823:         loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
3824:         WITH loc_oPg.txt_4c_Pftio
3825:             .Value    = 0
3826:             .Top      = 557
3827:             .Left     = 416
3828:             .Width    = 110
3829:             .Height   = 23
3830:             .FontName = "Tahoma"
3831:             .FontSize = 8
3832:             .ReadOnly = .T.
3833:         ENDWITH
3834: 
3835:         *-- Say12 "Fator" (top=542, left=563)
3836:         loc_oPg.AddObject("lbl_4c_Label12", "Label")
3837:         WITH loc_oPg.lbl_4c_Label12
3838:             .Caption   = "Fator"
3839:             .Top       = 542
3840:             .Left      = 563
3841:             .Width     = 28
3842:             .Height    = 15
3843:             .FontName  = "Tahoma"
3844:             .FontSize  = 8
3845:             .BackStyle = 0
3846:             .ForeColor = RGB(90,90,90)

*-- Linhas 3857 a 4023:
3857:             .FontName = "Tahoma"
3858:             .FontSize = 8
3859:         ENDWITH
3860:         BINDEVENT(loc_oPg.txt_4c_Fvenda, "LostFocus", THIS, "TabCompo_FvendaLostFocus")
3861: 
3862:         *-- getMoepv (top=557, left=677, w=31): moeda preco venda (editable+lookup)
3863:         loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
3864:         WITH loc_oPg.txt_4c_Moepv
3865:             .Value    = ""
3866:             .Top      = 557
3867:             .Left     = 677
3868:             .Width    = 31
3869:             .Height   = 23
3870:             .FontName = "Tahoma"
3871:             .FontSize = 8
3872:         ENDWITH
3873:         BINDEVENT(loc_oPg.txt_4c_Moepv, "LostFocus", THIS, "TabCompo_MoepvLostFocus")
3874: 
3875:         *-- Get_mftio (top=557, left=529, w=31): markup fiacao (read-only)
3876:         loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
3877:         WITH loc_oPg.txt_4c_Mftio
3878:             .Value    = 0
3879:             .Top      = 557
3880:             .Left     = 529
3881:             .Width    = 31
3882:             .Height   = 23
3883:             .FontName = "Tahoma"
3884:             .FontSize = 8
3885:             .ReadOnly = .T.
3886:         ENDWITH
3887: 
3888:         *-- Say24 "Sts" (top=542, left=324) - label para getStatus
3889:         loc_oPg.AddObject("lbl_4c_Label24", "Label")
3890:         WITH loc_oPg.lbl_4c_Label24
3891:             .Caption   = "Sts"
3892:             .Top       = 542
3893:             .Left      = 324
3894:             .Width     = 17
3895:             .Height    = 15
3896:             .FontName  = "Tahoma"
3897:             .FontSize  = 8
3898:             .BackStyle = 0
3899:             .ForeColor = RGB(90,90,90)
3900:         ENDWITH
3901: 
3902:         *-- getStatus (top=557, left=324, w=31): status composicao (editable+lookup)
3903:         loc_oPg.AddObject("txt_4c_Status", "TextBox")
3904:         WITH loc_oPg.txt_4c_Status
3905:             .Value    = ""
3906:             .Top      = 557
3907:             .Left     = 324
3908:             .Width    = 31
3909:             .Height   = 23
3910:             .FontName = "Tahoma"
3911:             .FontSize = 8
3912:         ENDWITH
3913:         BINDEVENT(loc_oPg.txt_4c_Status, "LostFocus", THIS, "TabCompo_StatusLostFocus")
3914: 
3915:         *-- chkPlanVen (top=556, left=387): planejamento venda
3916:         loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
3917:         WITH loc_oPg.chk_4c_ChkPlanVen
3918:             .Caption   = ""
3919:             .Value     = .F.
3920:             .Top       = 556
3921:             .Left      = 387
3922:             .Width     = 25
3923:             .Height    = 25
3924:             .BackStyle = 0
3925:             .Themes    = .F.
3926:             .Visible   = .T.
3927:         ENDWITH
3928: 
3929:         *-- Chk_Pvenda (top=595, left=387, w=25, h=25): usar preco ideal
3930:         loc_oPg.AddObject("chk_4c_ChkPvenda", "CheckBox")
3931:         WITH loc_oPg.chk_4c_ChkPvenda
3932:             .Caption   = ""
3933:             .Value     = .F.
3934:             .Top       = 595
3935:             .Left      = 387
3936:             .Width     = 25
3937:             .Height    = 25
3938:             .BackStyle = 0
3939:             .Themes    = .F.
3940:             .ToolTipText = "Usar Pre" + CHR(231) + "o Ideal"
3941:             .Visible   = .T.
3942:         ENDWITH
3943:         BINDEVENT(loc_oPg.chk_4c_ChkPvenda, "Click", THIS, "ChkPvendaClick")
3944: 
3945:         *-- lblVenda "Preco Atual (Moeda 2)" (top=581, left=416)
3946:         loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
3947:         WITH loc_oPg.lbl_4c_LblVenda
3948:             .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
3949:             .Top       = 581
3950:             .Left      = 416
3951:             .Width     = 115
3952:             .Height    = 15
3953:             .FontName  = "Tahoma"
3954:             .FontSize  = 8
3955:             .BackStyle = 0
3956:             .ForeColor = RGB(90,90,90)
3957:         ENDWITH
3958: 
3959:         *-- getPven (top=596, left=416, w=110): preco de venda atual (read-only)
3960:         loc_oPg.AddObject("txt_4c_Pven", "TextBox")
3961:         WITH loc_oPg.txt_4c_Pven
3962:             .Value    = 0
3963:             .Top      = 596
3964:             .Left     = 416
3965:             .Width    = 110
3966:             .Height   = 23
3967:             .FontName = "Tahoma"
3968:             .FontSize = 8
3969:             .ReadOnly = .T.
3970:         ENDWITH
3971: 
3972:         *-- getMoev (top=596, left=529, w=31): moeda valor venda (editable+lookup)
3973:         loc_oPg.AddObject("txt_4c_Moev", "TextBox")
3974:         WITH loc_oPg.txt_4c_Moev
3975:             .Value    = ""
3976:             .Top      = 596
3977:             .Left     = 529
3978:             .Width    = 31
3979:             .Height   = 23
3980:             .FontName = "Tahoma"
3981:             .FontSize = 8
3982:         ENDWITH
3983:         BINDEVENT(loc_oPg.txt_4c_Moev, "LostFocus", THIS, "TabCompo_MoevLostFocus")
3984: 
3985:         *-- lblFAtuals "Fator Atual" (top=581, left=563)
3986:         loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
3987:         WITH loc_oPg.lbl_4c_LblFAtuals
3988:             .Caption   = "Fator Atual"
3989:             .Top       = 581
3990:             .Left      = 563
3991:             .Width     = 56
3992:             .Height    = 15
3993:             .FontName  = "Tahoma"
3994:             .FontSize  = 8
3995:             .BackStyle = 0
3996:             .ForeColor = RGB(90,90,90)
3997:         ENDWITH
3998: 
3999:         *-- getFAtuals (top=596, left=563, w=110): fator atual (read-only)
4000:         loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
4001:         WITH loc_oPg.txt_4c_FAtuals
4002:             .Value    = 0
4003:             .Top      = 596
4004:             .Left     = 563
4005:             .Width    = 110
4006:             .Height   = 23
4007:             .FontName = "Tahoma"
4008:             .FontSize = 8
4009:             .ReadOnly = .T.
4010:         ENDWITH
4011: 
4012:         *-- Say25 "Financeiro" (top=581, left=678) - label para Get_Encarg
4013:         loc_oPg.AddObject("lbl_4c_Label25", "Label")
4014:         WITH loc_oPg.lbl_4c_Label25
4015:             .Caption   = "Financeiro"
4016:             .Top       = 581
4017:             .Left      = 678
4018:             .Width     = 51
4019:             .Height    = 15
4020:             .FontName  = "Tahoma"
4021:             .FontSize  = 8
4022:             .BackStyle = 0
4023:             .ForeColor = RGB(90,90,90)

*-- Linhas 4067 a 4118:
4067:             .ToolTipText     = "Calcular Valores"
4068:             .Visible         = .T.
4069:         ENDWITH
4070:         BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")
4071: 
4072:         *-- BINDEVENT para campos de moeda existentes (getMoec, getMoecusf)
4073:         BINDEVENT(loc_oPg.txt_4c_PcusMoe,  "LostFocus", THIS, "TabCompo_MoecLostFocus")
4074:         BINDEVENT(loc_oPg.txt_4c_MoecusFoe,"LostFocus", THIS, "TabCompo_MoecusfLostFocus")
4075: 
4076:         *-- BINDEVENT para AfterRowColChange dos grids
4077:         BINDEVENT(loc_oPg.grd_4c_Compo,    "AfterRowColChange", THIS, "CompoGrd_AfterRowColChange")
4078:         BINDEVENT(loc_oPg.grd_4c_SubCompo, "AfterRowColChange", THIS, "SubCompoGrd_AfterRowColChange")
4079: 
4080:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4081:         IF !USED("cursor_4c_Compo")
4082:             SET NULL ON
4083:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4084:             SET NULL OFF
4085:         ENDIF
4086:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4087:         WITH loc_oPg.grd_4c_Compo
4088:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4089:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4090:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4091:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4092:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4093:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4094:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4095:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4096:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4097:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4098:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4099:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4100:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4101:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4102:         ENDWITH
4103: 
4104:         IF !USED("cursor_4c_SubCompo")
4105:             SET NULL ON
4106:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4107:             SET NULL OFF
4108:         ENDIF
4109:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4110:         WITH loc_oPg.grd_4c_SubCompo
4111:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4112:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4113:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4114:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4115:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4116:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4117:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4118:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"

*-- Linhas 4141 a 4319:
4141:     *--------------------------------------------------------------------------
4142:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4143:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4144:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4145:     *--------------------------------------------------------------------------
4146:     PROTECTED PROCEDURE ConfigurarTabCustos()
4147:         LOCAL loc_oPg
4148:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4149: 
4150:         *-- Label "Tipo :" (top=159, left=112)
4151:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4152:         WITH loc_oPg.lbl_4c_TipoCusto
4153:             .Caption   = "Tipo :"
4154:             .Top       = 159
4155:             .Left      = 112
4156:             .Width     = 29
4157:             .Height    = 15
4158:             .FontName  = "Tahoma"
4159:             .FontSize  = 8
4160:             .BackStyle = 0
4161:             .ForeColor = RGB(90, 90, 90)
4162:         ENDWITH
4163: 
4164:         *-- ComboBox cmbTipos (top=154, left=143, width=187)
4165:         *-- Filtra o grid de custos por tipo de calculo de custo
4166:         loc_oPg.AddObject("cmb_4c_TiposCusto", "ComboBox")
4167:         WITH loc_oPg.cmb_4c_TiposCusto
4168:             .Top       = 154
4169:             .Left      = 143
4170:             .Width     = 187
4171:             .Height    = 23
4172:             .Style     = 2
4173:             .FontName  = "Tahoma"
4174:             .FontSize  = 8
4175:         ENDWITH
4176:         WITH loc_oPg.cmb_4c_TiposCusto
4177:             .AddItem("Todos")
4178:             .AddItem("Custo Completo")
4179:             .AddItem("Custo Parcial")
4180:             .AddItem("Custo Calculado")
4181:             .ListIndex = 1
4182:         ENDWITH
4183:         BINDEVENT(loc_oPg.cmb_4c_TiposCusto, "LostFocus", THIS, "CmbTiposCustoValid")
4184: 
4185:         *-- grdCompo - Grid de composicao de custo (top=178, left=34, width=813, height=230, 12 cols)
4186:         *-- Dados: SIGPRCPO filtrado por Tipos (tipo de calculo)
4187:         loc_oPg.AddObject("grd_4c_CompoCusto", "Grid")
4188:         WITH loc_oPg.grd_4c_CompoCusto
4189:             .Top         = 178
4190:             .Left        = 34
4191:             .Width       = 813
4192:             .Height      = 230
4193:             .ReadOnly    = .F.
4194:             .DeleteMark  = .F.
4195:             .RecordMark  = .F.
4196:             .ScrollBars  = 3
4197:             .GridLines   = 3
4198:             .ColumnCount = 12
4199:             .FontName    = "Verdana"
4200:             .FontSize    = 8
4201:             .Visible     = .T.
4202:         ENDWITH
4203:         WITH loc_oPg.grd_4c_CompoCusto
4204:             .Column1.Header1.Caption  = "Item"
4205:             .Column1.Width  = 80
4206:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4207:             .Column2.Width  = 180
4208:             .Column3.Header1.Caption  = "Un"
4209:             .Column3.Width  = 35
4210:             .Column4.Header1.Caption  = "Valor"
4211:             .Column4.Width  = 75
4212:             .Column5.Header1.Caption  = "Qtd"
4213:             .Column5.Width  = 60
4214:             .Column6.Header1.Caption  = "Total"
4215:             .Column6.Width  = 75
4216:             .Column7.Header1.Caption  = "Moe"
4217:             .Column7.Width  = 35
4218:             .Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4219:             .Column8.Width  = 75
4220:             .Column9.Header1.Caption  = "Etiq"
4221:             .Column9.Width  = 35
4222:             .Column10.Header1.Caption = "Consumo"
4223:             .Column10.Width = 70
4224:             .Column11.Header1.Caption = "Qtd"
4225:             .Column11.Width = 55
4226:             .Column12.Header1.Caption = "Un"
4227:             .Column12.Width = 35
4228:         ENDWITH
4229:         BINDEVENT(loc_oPg.grd_4c_CompoCusto, "AfterRowColChange", THIS, "CustosGrd_AfterRowColChange")
4230: 
4231:         *-- Botoes Incluir/Excluir para grid de custo
4232:         *-- Legado: cmdgCompo (CommandGroup) top=240, left=851, buttonCount=2
4233:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
4234:         WITH loc_oPg.cnt_4c_BotoesCusto
4235:             .Top         = 178
4236:             .Left        = 851
4237:             .Width       = 50
4238:             .Height      = 90
4239:             .BackStyle = 1
4240:             .BackColor = RGB(53, 53, 53)
4241:             .BorderWidth = 0
4242:             .Visible     = .T.
4243:         ENDWITH
4244: 
4245:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoIncluir", "CommandButton")
4246:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir
4247:             .Caption       = "+"
4248:             .Top           = 0
4249:             .Left          = 0
4250:             .Width         = 50
4251:             .Height        = 45
4252:             .FontName      = "Tahoma"
4253:             .FontSize      = 14
4254:             .FontBold      = .T.
4255:             .Themes        = .F.
4256:             .SpecialEffect = 0
4257:             .BackColor     = RGB(230, 255, 230)
4258:             .ForeColor     = RGB(0, 128, 0)
4259:             .Visible       = .T.
4260:         ENDWITH
4261:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoIncluir, "Click", THIS, "CmdCustoIncluirClick")
4262: 
4263:         loc_oPg.cnt_4c_BotoesCusto.AddObject("cmd_4c_CustoExcluir", "CommandButton")
4264:         WITH loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir
4265:             .Caption       = "-"
4266:             .Top           = 45
4267:             .Left          = 0
4268:             .Width         = 50
4269:             .Height        = 45
4270:             .FontName      = "Tahoma"
4271:             .FontSize      = 14
4272:             .FontBold      = .T.
4273:             .Themes        = .F.
4274:             .SpecialEffect = 0
4275:             .BackColor     = RGB(255, 230, 230)
4276:             .ForeColor     = RGB(192, 0, 0)
4277:             .Visible       = .T.
4278:         ENDWITH
4279:         BINDEVENT(loc_oPg.cnt_4c_BotoesCusto.cmd_4c_CustoExcluir, "Click", THIS, "CmdCustoExcluirClick")
4280: 
4281:         *-- Shape separador horizontal (Shape2: top=460, left=35, width=158, height=2)
4282:         loc_oPg.AddObject("shp_4c_SepCusto", "Shape")
4283:         WITH loc_oPg.shp_4c_SepCusto
4284:             .Top         = 460
4285:             .Left        = 35
4286:             .Width       = 158
4287:             .Height      = 2
4288:             .FillColor   = RGB(180, 180, 180)
4289:             .BackColor   = RGB(180, 180, 180)
4290:             .BorderColor = RGB(180, 180, 180)
4291:         ENDWITH
4292: 
4293:         *-- Label "Descricao :" (Say16: top=415, left=52)
4294:         loc_oPg.AddObject("lbl_4c_DescCusto", "Label")
4295:         WITH loc_oPg.lbl_4c_DescCusto
4296:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
4297:             .Top       = 415
4298:             .Left      = 52
4299:             .Width     = 62
4300:             .Height    = 15
4301:             .FontName  = "Tahoma"
4302:             .FontSize  = 8
4303:             .BackStyle = 0
4304:             .ForeColor = RGB(90, 90, 90)
4305:         ENDWITH
4306: 
4307:         *-- TextBox Get_Desc - mostra descricao do item selecionado (top=412, left=116, width=304)
4308:         loc_oPg.AddObject("txt_4c_DescCusto", "TextBox")
4309:         WITH loc_oPg.txt_4c_DescCusto
4310:             .Value    = ""
4311:             .Top      = 412
4312:             .Left     = 116
4313:             .Width    = 304
4314:             .Height   = 21
4315:             .FontName = "Tahoma"
4316:             .FontSize = 8
4317:             .ReadOnly = .T.
4318:         ENDWITH
4319: 

*-- Linhas 4424 a 4496:
4424:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4425:     * IMPLEMENTADO NA FASE 6
4426:     *--------------------------------------------------------------------------
4427:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4428:         LOCAL loc_oPg
4429:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4430: 
4431:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4432:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4433:         WITH loc_oPg.lbl_4c_Clfiscal
4434:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
4435:             .Top       = 216
4436:             .Left      = 102
4437:             .Width     = 99
4438:             .Height    = 15
4439:             .FontName  = "Tahoma"
4440:             .FontSize  = 8
4441:             .BackStyle = 0
4442:             .ForeColor = RGB(90,90,90)
4443:         ENDWITH
4444: 
4445:         loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
4446:         WITH loc_oPg.txt_4c_Clfiscal
4447:             .Value    = ""
4448:             .Top      = 211
4449:             .Left     = 206
4450:             .Width    = 94
4451:             .Height   = 23
4452:             .FontName = "Tahoma"
4453:             .FontSize = 8
4454:             .MaxLength = 10
4455:         ENDWITH
4456:         BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TabFiscal_ClfiscalKeyPress")
4457: 
4458:         loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
4459:         WITH loc_oPg.txt_4c_Dclfiscal
4460:             .Value    = ""
4461:             .Top      = 211
4462:             .Left     = 303
4463:             .Width    = 303
4464:             .Height   = 23
4465:             .FontName = "Tahoma"
4466:             .FontSize = 8
4467:             .ReadOnly = .T.
4468:         ENDWITH
4469: 
4470:         *-- Origem Mercadoria (top=236, left=206, width=17)
4471:         loc_oPg.AddObject("lbl_4c_Origmerc", "Label")
4472:         WITH loc_oPg.lbl_4c_Origmerc
4473:             .Caption   = "Origem da Mercadoria :"
4474:             .Top       = 241
4475:             .Left      = 87
4476:             .Width     = 114
4477:             .Height    = 15
4478:             .FontName  = "Tahoma"
4479:             .FontSize  = 8
4480:             .BackStyle = 0
4481:             .ForeColor = RGB(90,90,90)
4482:         ENDWITH
4483: 
4484:         loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
4485:         WITH loc_oPg.txt_4c_Origmerc
4486:             .Value    = ""
4487:             .Top      = 236
4488:             .Left     = 206
4489:             .Width    = 17
4490:             .Height   = 23
4491:             .FontName = "Tahoma"
4492:             .FontSize = 8
4493:             .MaxLength = 1
4494:         ENDWITH
4495: 
4496:         loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")

*-- Linhas 4702 a 4784:
4702:             .FontSize = 8
4703:             .MaxLength = 2
4704:         ENDWITH
4705:         BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TabFiscal_MetalKeyPress")
4706: 
4707:         loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
4708:         WITH loc_oPg.txt_4c_DesMetal
4709:             .Value    = ""
4710:             .Top      = 429
4711:             .Left     = 564
4712:             .Width    = 150
4713:             .Height   = 23
4714:             .FontName = "Tahoma"
4715:             .FontSize = 8
4716:             .ReadOnly = .T.
4717:         ENDWITH
4718: 
4719:         *-- Teor (top=454, left=537)
4720:         loc_oPg.AddObject("lbl_4c_Teor", "Label")
4721:         WITH loc_oPg.lbl_4c_Teor
4722:             .Caption   = "Teor :"
4723:             .Top       = 454
4724:             .Left      = 490
4725:             .Width     = 45
4726:             .Height    = 15
4727:             .FontName  = "Tahoma"
4728:             .FontSize  = 8
4729:             .BackStyle = 0
4730:             .ForeColor = RGB(90,90,90)
4731:         ENDWITH
4732: 
4733:         loc_oPg.AddObject("txt_4c_Teor", "TextBox")
4734:         WITH loc_oPg.txt_4c_Teor
4735:             .Value    = ""
4736:             .Top      = 454
4737:             .Left     = 537
4738:             .Width    = 24
4739:             .Height   = 23
4740:             .FontName = "Tahoma"
4741:             .FontSize = 8
4742:             .MaxLength = 2
4743:         ENDWITH
4744:         BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TabFiscal_TeorKeyPress")
4745: 
4746:         loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
4747:         WITH loc_oPg.txt_4c_DesTeor
4748:             .Value    = ""
4749:             .Top      = 454
4750:             .Left     = 564
4751:             .Width    = 150
4752:             .Height   = 23
4753:             .FontName = "Tahoma"
4754:             .FontSize = 8
4755:             .ReadOnly = .T.
4756:         ENDWITH
4757: 
4758:         *-- Descricao ECF (top=429, left=206, width=213)
4759:         loc_oPg.AddObject("lbl_4c_DescEcf", "Label")
4760:         WITH loc_oPg.lbl_4c_DescEcf
4761:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
4762:             .Top       = 433
4763:             .Left      = 124
4764:             .Width     = 77
4765:             .Height    = 15
4766:             .FontName  = "Tahoma"
4767:             .FontSize  = 8
4768:             .BackStyle = 0
4769:             .ForeColor = RGB(90,90,90)
4770:         ENDWITH
4771: 
4772:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4773:         WITH loc_oPg.txt_4c_DescEcfs
4774:             .Value    = ""
4775:             .Top      = 429
4776:             .Left     = 206
4777:             .Width    = 213
4778:             .Height   = 23
4779:             .FontName = "Tahoma"
4780:             .FontSize = 8
4781:             .MaxLength = 29
4782:         ENDWITH
4783: 
4784:         *-- Valor Estimado (top=454, left=206)

*-- Linhas 4821 a 5049:
4821: 
4822:     *--------------------------------------------------------------------------
4823:     * ConfigurarPgpgDadosFiscais - Completa Aba 4 Dados Fiscais
4824:     * Adiciona controles restantes + BINDEVENTs de todos os campos do tab fiscal
4825:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDadosFiscais()
4826:     *--------------------------------------------------------------------------
4827:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais()
4828:         LOCAL loc_oPg
4829:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4830: 
4831:         *-- === GRUPO C.C. (get_gruccus: top=161, left=206, width=80) ============
4832: 
4833:         loc_oPg.AddObject("lbl_4c_Gruccus", "Label")
4834:         WITH loc_oPg.lbl_4c_Gruccus
4835:             .Caption   = "Grupo C.C. :"
4836:             .Top       = 165
4837:             .Left      = 138
4838:             .Width     = 63
4839:             .Height    = 15
4840:             .FontName  = "Tahoma"
4841:             .FontSize  = 8
4842:             .BackStyle = 0
4843:             .ForeColor = RGB(90, 90, 90)
4844:         ENDWITH
4845: 
4846:         loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
4847:         WITH loc_oPg.txt_4c__gruccus
4848:             .Value         = ""
4849:             .Top           = 161
4850:             .Left          = 206
4851:             .Width         = 80
4852:             .Height        = 23
4853:             .FontName      = "Tahoma"
4854:             .FontSize      = 8
4855:             .MaxLength     = 10
4856:             .SpecialEffect = 1
4857:         ENDWITH
4858:         BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus", THIS, "ValidarGruccus")
4859: 
4860:         loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
4861:         WITH loc_oPg.txt_4c__dgruccus
4862:             .Value    = ""
4863:             .Top      = 161
4864:             .Left     = 288
4865:             .Width    = 318
4866:             .Height   = 23
4867:             .FontName = "Tahoma"
4868:             .FontSize = 8
4869:             .ReadOnly = .T.
4870:         ENDWITH
4871:         BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus", THIS, "ValidarDgruccus")
4872: 
4873:         *-- === CONTA C.C. (get_contaccus: top=186, left=206, width=80) ==========
4874: 
4875:         loc_oPg.AddObject("lbl_4c_Contaccus", "Label")
4876:         WITH loc_oPg.lbl_4c_Contaccus
4877:             .Caption   = "Conta C.C. :"
4878:             .Top       = 189
4879:             .Left      = 138
4880:             .Width     = 63
4881:             .Height    = 15
4882:             .FontName  = "Tahoma"
4883:             .FontSize  = 8
4884:             .BackStyle = 0
4885:             .ForeColor = RGB(90, 90, 90)
4886:         ENDWITH
4887: 
4888:         loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
4889:         WITH loc_oPg.txt_4c__contaccus
4890:             .Value         = ""
4891:             .Top           = 186
4892:             .Left          = 206
4893:             .Width         = 80
4894:             .Height        = 23
4895:             .FontName      = "Tahoma"
4896:             .FontSize      = 8
4897:             .MaxLength     = 10
4898:             .SpecialEffect = 1
4899:         ENDWITH
4900:         BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus", THIS, "ValidarContaccus")
4901: 
4902:         loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
4903:         WITH loc_oPg.txt_4c__dcontaccus
4904:             .Value    = ""
4905:             .Top      = 186
4906:             .Left     = 288
4907:             .Width    = 318
4908:             .Height   = 23
4909:             .FontName = "Tahoma"
4910:             .FontSize = 8
4911:             .ReadOnly = .T.
4912:         ENDWITH
4913:         BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus", THIS, "ValidarDcontaccus")
4914: 
4915:         *-- === ALIQUOTA IPI (Get_AliqIPI: top=311, left=425, width=45) ==========
4916: 
4917:         loc_oPg.AddObject("lbl_4c_AliqIPI", "Label")
4918:         WITH loc_oPg.lbl_4c_AliqIPI
4919:             .Caption   = "Al" + CHR(237) + "quota de IPI :"
4920:             .Top       = 316
4921:             .Left      = 327
4922:             .Width     = 90
4923:             .Height    = 15
4924:             .FontName  = "Tahoma"
4925:             .FontSize  = 8
4926:             .BackStyle = 0
4927:             .ForeColor = RGB(90, 90, 90)
4928:         ENDWITH
4929: 
4930:         loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
4931:         WITH loc_oPg.txt_4c_AliqIPI
4932:             .Value    = 0
4933:             .Top      = 311
4934:             .Left     = 425
4935:             .Width    = 45
4936:             .Height   = 25
4937:             .FontName = "Tahoma"
4938:             .FontSize = 8
4939:         ENDWITH
4940:         BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")
4941: 
4942:         *-- === EXCECAO DA TIPI/IPI (getextipi: top=311, left=601, width=35) ======
4943: 
4944:         loc_oPg.AddObject("lbl_4c_Extipi", "Label")
4945:         WITH loc_oPg.lbl_4c_Extipi
4946:             .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
4947:             .Top       = 316
4948:             .Left      = 495
4949:             .Width     = 98
4950:             .Height    = 15
4951:             .FontName  = "Tahoma"
4952:             .FontSize  = 8
4953:             .BackStyle = 0
4954:             .ForeColor = RGB(90, 90, 90)
4955:         ENDWITH
4956: 
4957:         loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
4958:         WITH loc_oPg.txt_4c_Extipi
4959:             .Value     = ""
4960:             .Top       = 311
4961:             .Left      = 601
4962:             .Width     = 35
4963:             .Height    = 25
4964:             .FontName  = "Tahoma"
4965:             .FontSize  = 8
4966:             .MaxLength = 3
4967:         ENDWITH
4968:         BINDEVENT(loc_oPg.txt_4c_Extipi, "GotFocus", THIS, "TabFiscal_ExtIpiGotFocus")
4969: 
4970:         *-- === IAT (getiat: top=286, left=589, width=17) ========================
4971: 
4972:         loc_oPg.AddObject("lbl_4c_Iat", "Label")
4973:         WITH loc_oPg.lbl_4c_Iat
4974:             .Caption   = "IAT :"
4975:             .Top       = 290
4976:             .Left      = 558
4977:             .Width     = 26
4978:             .Height    = 15
4979:             .FontName  = "Tahoma"
4980:             .FontSize  = 8
4981:             .BackStyle = 0
4982:             .ForeColor = RGB(90, 90, 90)
4983:         ENDWITH
4984: 
4985:         loc_oPg.AddObject("lbl_4c_IatDesc", "Label")
4986:         WITH loc_oPg.lbl_4c_IatDesc
4987:             .Caption   = "[A]rredondamento [T]runcamento"
4988:             .Top       = 290
4989:             .Left      = 609
4990:             .Width     = 165
4991:             .Height    = 15
4992:             .FontName  = "Tahoma"
4993:             .FontSize  = 8
4994:             .BackStyle = 0
4995:             .ForeColor = RGB(120, 120, 120)
4996:         ENDWITH
4997: 
4998:         loc_oPg.AddObject("txt_4c_Iat", "TextBox")
4999:         WITH loc_oPg.txt_4c_Iat
5000:             .Value     = ""
5001:             .Top       = 286
5002:             .Left      = 589
5003:             .Width     = 17
5004:             .Height    = 23
5005:             .FontName  = "Tahoma"
5006:             .FontSize  = 8
5007:             .MaxLength = 1
5008:         ENDWITH
5009:         BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")
5010: 
5011:         *-- === IPPT/CST (getIPPTCST: top=479, left=206, width=108) =============
5012:         *-- Campo de exibicao calculado: nao armazenado, somente leitura
5013: 
5014:         loc_oPg.AddObject("lbl_4c_IPPTCST", "Label")
5015:         WITH loc_oPg.lbl_4c_IPPTCST
5016:             .Caption   = "IPPT/CST :"
5017:             .Top       = 483
5018:             .Left      = 147
5019:             .Width     = 54
5020:             .Height    = 15
5021:             .FontName  = "Tahoma"
5022:             .FontSize  = 8
5023:             .BackStyle = 0
5024:             .ForeColor = RGB(90, 90, 90)
5025:         ENDWITH
5026: 
5027:         loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
5028:         WITH loc_oPg.txt_4c_IPPTCST
5029:             .Value    = ""
5030:             .Top      = 479
5031:             .Left     = 206
5032:             .Width    = 108
5033:             .Height   = 23
5034:             .FontName = "Tahoma"
5035:             .FontSize = 8
5036:             .ReadOnly = .T.
5037:         ENDWITH
5038: 
5039:         *-- === GRID CMV - Custo GR (grdCmv: top=338, left=754, width=223, h=141)
5040:         *-- 3 colunas: Periodo, Valor Custo GR, Moe
5041: 
5042:         loc_oPg.AddObject("lbl_4c_CmvTitulo", "Label")
5043:         WITH loc_oPg.lbl_4c_CmvTitulo
5044:             .Caption   = "Valor do Grama Produzido"
5045:             .Top       = 320
5046:             .Left      = 756
5047:             .Width     = 125
5048:             .Height    = 15
5049:             .FontName  = "Tahoma"

*-- Linhas 5106 a 5171:
5106:             .SpecialEffect   = 0
5107:             .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
5108:         ENDWITH
5109:         BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "BtnDescFisClick")
5110: 
5111:         *-- === BINDEVENTS para controles JA CRIADOS em ConfigurarTabDadosFiscais ==
5112:         *-- Adicionar LostFocus nos campos lookup existentes
5113: 
5114:         BINDEVENT(loc_oPg.txt_4c_Clfiscal,  "LostFocus", THIS, "ValidarClfiscal")
5115:         BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "LostFocus", THIS, "ValidarDclfiscal")
5116:         BINDEVENT(loc_oPg.txt_4c_Origmerc,  "LostFocus", THIS, "ValidarOrigmerc")
5117:         BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "LostFocus", THIS, "ValidarDorigmerc")
5118:         BINDEVENT(loc_oPg.txt_4c_Sittricms, "LostFocus", THIS, "ValidarSittricms")
5119:         BINDEVENT(loc_oPg.txt_4c_Dsittricms,"LostFocus", THIS, "ValidarDsittricms")
5120:         BINDEVENT(loc_oPg.txt_4c_CodServs,  "LostFocus", THIS, "ValidarCodServs")
5121:         BINDEVENT(loc_oPg.txt_4c_Tptribs,   "LostFocus", THIS, "ValidarTptribs")
5122:         BINDEVENT(loc_oPg.txt_4c_Metal,     "LostFocus", THIS, "ValidarMetal")
5123:         BINDEVENT(loc_oPg.txt_4c_Teor,      "LostFocus", THIS, "ValidarTeor")
5124:         BINDEVENT(loc_oPg.txt_4c_Moedas,    "LostFocus", THIS, "ValidarMoedaEstimada")
5125:     ENDPROC
5126: 
5127:     *--------------------------------------------------------------------------
5128:     * ConfigurarTabDesigner - Aba 5: Designer/arquivos (pgDesigner)
5129:     * IMPLEMENTADO NA FASE 7
5130:     *--------------------------------------------------------------------------
5131:     PROTECTED PROCEDURE ConfigurarTabDesigner()
5132:         LOCAL loc_oPg
5133:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5134: 
5135:         *-- grdDesigner (top=160, left=10, width=495, height=238, 4 cols)
5136:         *-- Dados: sigprtar - Data Inicio, Data Conclusao, Usuario, Tarefa
5137:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
5138:         WITH loc_oPg.grd_4c_Designer
5139:             .Top         = 160
5140:             .Left        = 10
5141:             .Width       = 495
5142:             .Height      = 238
5143:             .ReadOnly    = .T.
5144:             .DeleteMark  = .F.
5145:             .RecordMark  = .F.
5146:             .ScrollBars  = 3
5147:             .GridLines   = 3
5148:             .ColumnCount = 4
5149:             .FontName    = "Verdana"
5150:             .FontSize    = 8
5151:             .Visible     = .T.
5152:         ENDWITH
5153:         WITH loc_oPg.grd_4c_Designer
5154:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5155:             .Column1.Width = 110
5156:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5157:             .Column2.Width = 120
5158:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5159:             .Column3.Width = 100
5160:             .Column4.Header1.Caption = "Tarefa"
5161:             .Column4.Width = 160
5162:         ENDWITH
5163: 
5164:         *-- Observacao da Tarefa - EditBox (top=160, left=584, width=407, height=238)
5165:         loc_oPg.AddObject("lbl_4c_ObsTarefa", "Label")
5166:         WITH loc_oPg.lbl_4c_ObsTarefa
5167:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
5168:             .Top       = 144
5169:             .Left      = 583
5170:             .Width     = 130
5171:             .Height    = 15

*-- Linhas 5200 a 5418:
5200:             .Themes  = .F.
5201:             .Visible = .T.
5202:         ENDWITH
5203:         BINDEVENT(loc_oPg.cmd_4c_IniTarefa, "Click", THIS, "BtnIniTarefaClick")
5204: 
5205:         loc_oPg.AddObject("cmd_4c_FimTarefa", "CommandButton")
5206:         WITH loc_oPg.cmd_4c_FimTarefa
5207:             .Caption = "Fim"
5208:             .Top     = 203
5209:             .Left    = 509
5210:             .Width   = 42
5211:             .Height  = 42
5212:             .FontName = "Tahoma"
5213:             .FontSize = 7
5214:             .Themes  = .F.
5215:             .Visible = .T.
5216:         ENDWITH
5217:         BINDEVENT(loc_oPg.cmd_4c_FimTarefa, "Click", THIS, "BtnFimTarefaClick")
5218: 
5219:         *-- grdArquivos (top=415, left=10, width=495, height=202, 1 col)
5220:         *-- Dados: sigprarq - Arquivos do designer
5221:         loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
5222:         WITH loc_oPg.grd_4c_Arquivos
5223:             .Top         = 415
5224:             .Left        = 10
5225:             .Width       = 495
5226:             .Height      = 202
5227:             .ReadOnly    = .T.
5228:             .DeleteMark  = .F.
5229:             .RecordMark  = .F.
5230:             .ScrollBars  = 3
5231:             .GridLines   = 3
5232:             .ColumnCount = 1
5233:             .FontName    = "Verdana"
5234:             .FontSize    = 8
5235:             .Visible     = .T.
5236:         ENDWITH
5237:         WITH loc_oPg.grd_4c_Arquivos
5238:             .Column1.Header1.Caption = "Arquivos Para Designer"
5239:             .Column1.Width = 492
5240:         ENDWITH
5241: 
5242:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5243:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
5244:         WITH loc_oPg.cmd_4c_InsArqs
5245:             .Caption = "Inserir"
5246:             .Top     = 416
5247:             .Left    = 509
5248:             .Width   = 42
5249:             .Height  = 42
5250:             .FontName = "Tahoma"
5251:             .FontSize = 7
5252:             .Themes  = .F.
5253:             .Visible = .T.
5254:         ENDWITH
5255:         BINDEVENT(loc_oPg.cmd_4c_InsArqs, "Click", THIS, "BtnInsArqsClick")
5256: 
5257:         loc_oPg.AddObject("cmd_4c_ExcArqs", "CommandButton")
5258:         WITH loc_oPg.cmd_4c_ExcArqs
5259:             .Caption = "Excluir"
5260:             .Top     = 458
5261:             .Left    = 509
5262:             .Width   = 42
5263:             .Height  = 42
5264:             .FontName = "Tahoma"
5265:             .FontSize = 7
5266:             .Themes  = .F.
5267:             .Visible = .T.
5268:         ENDWITH
5269:         BINDEVENT(loc_oPg.cmd_4c_ExcArqs, "Click", THIS, "BtnExcArqsClick")
5270: 
5271:         loc_oPg.AddObject("cmd_4c_OpnArqs", "CommandButton")
5272:         WITH loc_oPg.cmd_4c_OpnArqs
5273:             .Caption = "Abrir"
5274:             .Top     = 500
5275:             .Left    = 509
5276:             .Width   = 42
5277:             .Height  = 42
5278:             .FontName = "Tahoma"
5279:             .FontSize = 7
5280:             .Themes  = .F.
5281:             .Visible = .T.
5282:         ENDWITH
5283:         BINDEVENT(loc_oPg.cmd_4c_OpnArqs, "Click", THIS, "BtnOpnArqsClick")
5284: 
5285:         *-- Criar cursors placeholder
5286:         IF !USED("cursor_4c_Designer")
5287:             SET NULL ON
5288:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5289:             SET NULL OFF
5290:         ENDIF
5291:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5292:         WITH loc_oPg.grd_4c_Designer
5293:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5294:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5295:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5296:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5297:         ENDWITH
5298: 
5299:         IF !USED("cursor_4c_Arquivos")
5300:             SET NULL ON
5301:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5302:             SET NULL OFF
5303:         ENDIF
5304:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5305:         WITH loc_oPg.grd_4c_Arquivos
5306:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5307:         ENDWITH
5308:     ENDPROC
5309: 
5310:     *--------------------------------------------------------------------------
5311:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5312:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5313:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5314:     *--------------------------------------------------------------------------
5315:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5316:         LOCAL loc_oPg
5317:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5318: 
5319:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5320:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5321:         loc_oPg.grd_4c_Designer.ReadOnly = .F.
5322: 
5323:         *-- Shape decorativo em volta da area de imagem (top=415, left=584, width=407, height=202)
5324:         loc_oPg.AddObject("shp_4c_Shape1", "Shape")
5325:         WITH loc_oPg.shp_4c_Shape1
5326:             .Top         = 415
5327:             .Left        = 584
5328:             .Width       = 407
5329:             .Height      = 202
5330:             .BorderColor = RGB(128, 128, 128)
5331:             .BorderWidth = 1
5332:             .BackStyle   = 0
5333:             .Visible     = .T.
5334:         ENDWITH
5335: 
5336:         *-- Imagem preview do arquivo selecionado (top=417, left=586, width=403, height=198)
5337:         loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
5338:         WITH loc_oPg.img_4c_ImgArqJpg
5339:             .Top     = 417
5340:             .Left    = 586
5341:             .Width   = 403
5342:             .Height  = 198
5343:             .Stretch = 2
5344:             .Visible = .F.
5345:         ENDWITH
5346:         BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")
5347: 
5348:         *-- BINDEVENTs para AfterRowColChange dos grids
5349:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "DesignerGrd_AfterRowColChange")
5350:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "ArquivosGrd_AfterRowColChange")
5351: 
5352:         *-- BINDEVENTs Colunas 1/2/3 do grd_4c_Designer (somente leitura sempre)
5353:         BINDEVENT(loc_oPg.grd_4c_Designer.Column1.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5354:         BINDEVENT(loc_oPg.grd_4c_Designer.Column2.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5355:         BINDEVENT(loc_oPg.grd_4c_Designer.Column3.Text1, "When", THIS, "GrdDesignerColReadOnlyWhen")
5356: 
5357:         *-- BINDEVENTs Coluna 4 do grd_4c_Designer (Tarefa: editavel condicionalmente)
5358:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "When",      THIS, "GrdDesignerCol4When")
5359:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "Valid",     THIS, "GrdDesignerCol4Valid")
5360:         BINDEVENT(loc_oPg.grd_4c_Designer.Column4.Text1, "LostFocus", THIS, "GrdDesignerCol4LostFocus")
5361: 
5362:         *-- BINDEVENT Column1 do grd_4c_Arquivos (editavel em INCLUIR/ALTERAR)
5363:         BINDEVENT(loc_oPg.grd_4c_Arquivos.Column1.Text1, "When", THIS, "GrdArquivosCol1When")
5364: 
5365:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5366:         IF !USED("cursor_4c_Tarefas")
5367:             SET NULL ON
5368:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5369:             SET NULL OFF
5370:         ENDIF
5371:     ENDPROC
5372: 
5373:     *--------------------------------------------------------------------------
5374:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5375:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5376:     * IMPLEMENTADO NA FASE 9
5377:     *--------------------------------------------------------------------------
5378:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5379:         LOCAL loc_oPg
5380:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5381: 
5382:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5383:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5384:         IF !USED("cursor_4c_Consulta")
5385:             SET NULL ON
5386:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5387:             SET NULL OFF
5388:         ENDIF
5389: 
5390:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5391:         IF !USED("cursor_4c_Temp")
5392:             SET NULL ON
5393:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5394:             SET NULL OFF
5395:         ENDIF
5396: 
5397:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5398:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5399:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5400:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5401:         WITH loc_oPg.grd_4c_Consulta
5402:             .Top         = 155
5403:             .Left        = 6
5404:             .Width       = 987
5405:             .Height      = 362
5406:             .ReadOnly    = .F.
5407:             .DeleteMark  = .F.
5408:             .RecordMark  = .F.
5409:             .ScrollBars  = 3
5410:             .GridLines   = 3
5411:             .ColumnCount = 9
5412:             .FontName    = "Verdana"
5413:             .FontSize    = 8
5414:             .Visible     = .T.
5415:         ENDWITH
5416:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5417:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5418:         WITH loc_oPg.grd_4c_Consulta

*-- Linhas 5449 a 5492:
5449:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5450:             .Column9.ReadOnly        = .T.
5451:         ENDWITH
5452:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5453: 
5454:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5455:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5456:         WITH loc_oPg.lbl_4c_QtdCpnt
5457:             .Caption   = "Qtde Componentes : "
5458:             .Top       = 523
5459:             .Left      = 25
5460:             .Width     = 115
5461:             .Height    = 15
5462:             .FontName  = "Tahoma"
5463:             .FontSize  = 8
5464:             .BackStyle = 0
5465:             .ForeColor = RGB(90, 90, 90)
5466:         ENDWITH
5467: 
5468:         *-- Getqtcpnt/txt_4c_QtdCpnt: quantidade de componentes (top=519, left=131, width=31)
5469:         loc_oPg.AddObject("txt_4c_QtdCpnt", "TextBox")
5470:         WITH loc_oPg.txt_4c_QtdCpnt
5471:             .Top           = 519
5472:             .Left          = 131
5473:             .Width         = 31
5474:             .Height        = 23
5475:             .Value         = 0
5476:             .ReadOnly      = .T.
5477:             .SpecialEffect = 1
5478:             .FontName      = "Tahoma"
5479:             .FontSize      = 8
5480:         ENDWITH
5481: 
5482:         *-- chkFund/chk_4c_ChkFund: "Nao Checar Cadastro de Fundicao" (top=544, left=10)
5483:         loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
5484:         WITH loc_oPg.chk_4c_ChkFund
5485:             .Caption  = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
5486:             .Top      = 544
5487:             .Left     = 10
5488:             .Width    = 200
5489:             .Height   = 15
5490:             .FontName = "Tahoma"
5491:             .FontSize = 8
5492:             .Value    = 0

*-- Linhas 5541 a 5584:
5541:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5542:     * IMPLEMENTADO NA FASE 7
5543:     *--------------------------------------------------------------------------
5544:     PROTECTED PROCEDURE ConfigurarTabFases()
5545:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5546:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5547: 
5548:         *-- Cursor placeholder para GradFase (SigCdPrf)
5549:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5550:         IF !USED("cursor_4c_Fases")
5551:             SET NULL ON
5552:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5553:             SET NULL OFF
5554:         ENDIF
5555: 
5556:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5557:         IF !USED("cursor_4c_Matrizes")
5558:             SET NULL ON
5559:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5560:             SET NULL OFF
5561:         ENDIF
5562: 
5563:         *======================================================
5564:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5565:         *======================================================
5566:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5567:         WITH loc_oPg.lbl_4c_Qmin
5568:             .Top      = 156
5569:             .Left     = 33
5570:             .Width    = 102
5571:             .Height   = 15
5572:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5573:             .AutoSize = .F.
5574:             .FontName = "Tahoma"
5575:             .FontSize = 8
5576:             .Visible  = .T.
5577:         ENDWITH
5578: 
5579:         *======================================================
5580:         *-- TEXTBOX: getQmin - Qtde minima fabricacao
5581:         *======================================================
5582:         loc_oPg.AddObject("txt_4c_Qminfab", "TextBox")
5583:         WITH loc_oPg.txt_4c_Qminfab
5584:             .Top           = 152

*-- Linhas 6017 a 6359:
6017:             .Stretch = 2
6018:             .Visible = .F.
6019:         ENDWITH
6020:         BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
6021: 
6022:         *======================================================
6023:         *-- BUTTON: cmd_4c_CmdFicha - Imprimir ficha da fase
6024:         *-- top=152, left=482
6025:         *======================================================
6026:         loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
6027:         WITH loc_oPg.cmd_4c_CmdFicha
6028:             .Caption       = "Ficha"
6029:             .Top           = 152
6030:             .Left          = 482
6031:             .Width         = 38
6032:             .Height        = 23
6033:             .FontName      = "Tahoma"
6034:             .FontSize      = 8
6035:             .Themes        = .F.
6036:             .SpecialEffect = 0
6037:             .BackColor     = RGB(255, 255, 255)
6038:             .ForeColor     = RGB(90, 90, 90)
6039:             .Visible       = .T.
6040:         ENDWITH
6041:         BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")
6042: 
6043:         *======================================================
6044:         *-- BUTTON: cmd_4c_CmdgFigura - Carregar imagem da fase (cmdgFigura)
6045:         *-- top=192, left=482
6046:         *======================================================
6047:         loc_oPg.AddObject("cmd_4c_CmdgFigura", "CommandButton")
6048:         WITH loc_oPg.cmd_4c_CmdgFigura
6049:             .Caption       = "..."
6050:             .Top           = 192
6051:             .Left          = 482
6052:             .Width         = 38
6053:             .Height        = 23
6054:             .FontName      = "Tahoma"
6055:             .FontSize      = 8
6056:             .Themes        = .F.
6057:             .SpecialEffect = 0
6058:             .BackColor     = RGB(255, 255, 255)
6059:             .ForeColor     = RGB(90, 90, 90)
6060:             .Visible       = .T.
6061:         ENDWITH
6062:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")
6063: 
6064:         *======================================================
6065:         *-- BUTTON: cmd_4c_CmdgFigCam - Camera para imagem de borracha (cmdgFigCam)
6066:         *-- top=232, left=482
6067:         *======================================================
6068:         loc_oPg.AddObject("cmd_4c_CmdgFigCam", "CommandButton")
6069:         WITH loc_oPg.cmd_4c_CmdgFigCam
6070:             .Caption       = "..."
6071:             .Top           = 232
6072:             .Left          = 482
6073:             .Width         = 38
6074:             .Height        = 23
6075:             .FontName      = "Tahoma"
6076:             .FontSize      = 8
6077:             .Themes        = .F.
6078:             .SpecialEffect = 0
6079:             .BackColor     = RGB(255, 255, 255)
6080:             .ForeColor     = RGB(90, 90, 90)
6081:             .Visible       = .T.
6082:         ENDWITH
6083:         BINDEVENT(loc_oPg.cmd_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")
6084: 
6085:         *======================================================
6086:         *-- BUTTON: cmd_4c_InserirFase - Inserir nova fase (inserir)
6087:         *-- top=152, left=950
6088:         *======================================================
6089:         loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
6090:         WITH loc_oPg.cmd_4c_InserirFase
6091:             .Caption       = "Inserir"
6092:             .Top           = 152
6093:             .Left          = 950
6094:             .Width         = 45
6095:             .Height        = 23
6096:             .FontName      = "Tahoma"
6097:             .FontSize      = 8
6098:             .Themes        = .F.
6099:             .SpecialEffect = 0
6100:             .BackColor     = RGB(255, 255, 255)
6101:             .ForeColor     = RGB(90, 90, 90)
6102:             .Visible       = .T.
6103:         ENDWITH
6104:         BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")
6105: 
6106:         *======================================================
6107:         *-- BUTTON: cmd_4c_ExcluirFase - Excluir fase (excluir)
6108:         *-- top=192, left=950
6109:         *======================================================
6110:         loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
6111:         WITH loc_oPg.cmd_4c_ExcluirFase
6112:             .Caption       = "Excluir"
6113:             .Top           = 192
6114:             .Left          = 950
6115:             .Width         = 45
6116:             .Height        = 23
6117:             .FontName      = "Tahoma"
6118:             .FontSize      = 8
6119:             .Themes        = .F.
6120:             .SpecialEffect = 0
6121:             .BackColor     = RGB(255, 255, 255)
6122:             .ForeColor     = RGB(90, 90, 90)
6123:             .Visible       = .T.
6124:         ENDWITH
6125:         BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")
6126: 
6127:         *======================================================
6128:         *-- BUTTON: cmd_4c_Alternativa - Alternativa de fase
6129:         *-- top=232, left=950
6130:         *======================================================
6131:         loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
6132:         WITH loc_oPg.cmd_4c_Alternativa
6133:             .Caption       = "Altern."
6134:             .Top           = 232
6135:             .Left          = 950
6136:             .Width         = 45
6137:             .Height        = 23
6138:             .FontName      = "Tahoma"
6139:             .FontSize      = 8
6140:             .Themes        = .F.
6141:             .SpecialEffect = 0
6142:             .BackColor     = RGB(255, 255, 255)
6143:             .ForeColor     = RGB(90, 90, 90)
6144:             .Visible       = .T.
6145:         ENDWITH
6146:         BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")
6147: 
6148:         *======================================================
6149:         *-- BUTTON: cmd_4c_BtnInsereMtx - Inserir linha na grade de matrizes
6150:         *-- top=380, left=258
6151:         *======================================================
6152:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
6153:         WITH loc_oPg.cmd_4c_BtnInsereMtx
6154:             .Caption       = "+"
6155:             .Top           = 380
6156:             .Left          = 258
6157:             .Width         = 23
6158:             .Height        = 23
6159:             .FontName      = "Tahoma"
6160:             .FontSize      = 10
6161:             .FontBold      = .T.
6162:             .Themes        = .F.
6163:             .SpecialEffect = 0
6164:             .BackColor     = RGB(255, 255, 255)
6165:             .ForeColor     = RGB(90, 90, 90)
6166:             .Visible       = .T.
6167:         ENDWITH
6168:         BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInserirMatrizClick")
6169: 
6170:         *======================================================
6171:         *-- BUTTON: cmd_4c_BtnExcluiMtz - Excluir linha da grade de matrizes
6172:         *-- top=420, left=258
6173:         *======================================================
6174:         loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
6175:         WITH loc_oPg.cmd_4c_BtnExcluiMtz
6176:             .Caption       = "-"
6177:             .Top           = 420
6178:             .Left          = 258
6179:             .Width         = 23
6180:             .Height        = 23
6181:             .FontName      = "Tahoma"
6182:             .FontSize      = 10
6183:             .FontBold      = .T.
6184:             .Themes        = .F.
6185:             .SpecialEffect = 0
6186:             .BackColor     = RGB(255, 255, 255)
6187:             .ForeColor     = RGB(90, 90, 90)
6188:             .Visible       = .T.
6189:         ENDWITH
6190:         BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluirMatrizClick")
6191: 
6192:         *======================================================
6193:         *-- SHAPE: shp_4c_ShpBorracha - Borda ao redor da imagem da borracha
6194:         *-- top=464, left=258, width=236, height=156
6195:         *======================================================
6196:         loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
6197:         WITH loc_oPg.shp_4c_ShpBorracha
6198:             .Top         = 464
6199:             .Left        = 258
6200:             .Width       = 236
6201:             .Height      = 156
6202:             .BorderColor = RGB(150, 150, 150)
6203:             .BorderWidth = 1
6204:             .FillStyle   = 1
6205:             .Curvature   = 0
6206:             .Visible     = .T.
6207:         ENDWITH
6208: 
6209:         *======================================================
6210:         *-- IMAGE: img_4c_ImgBorracha - Imagem da borracha (molde)
6211:         *-- top=465, left=260, width=232, height=154
6212:         *======================================================
6213:         loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
6214:         WITH loc_oPg.img_4c_ImgBorracha
6215:             .Top     = 465
6216:             .Left    = 260
6217:             .Width   = 232
6218:             .Height  = 154
6219:             .Stretch = 2
6220:             .Visible = .F.
6221:         ENDWITH
6222: 
6223:         *======================================================
6224:         *-- BINDEVENTs para grids (AfterRowColChange)
6225:         *======================================================
6226:         BINDEVENT(loc_oPg.grd_4c_Fases,    "AfterRowColChange", THIS, "GrdFasesAfterRowColChange")
6227:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
6228: 
6229:         *======================================================
6230:         *-- BINDEVENTs para lookups da aba Fases
6231:         *======================================================
6232:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "KeyPress", THIS, "TabFases_CodcorsKeyPress")
6233:         BINDEVENT(loc_oPg.txt_4c_CodcorsFas,  "LostFocus", THIS, "TabFases_CodcorsLostFocus")
6234:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "KeyPress", THIS, "TabFases_CodtamsKeyPress")
6235:         BINDEVENT(loc_oPg.txt_4c_CodtamsFas,  "LostFocus", THIS, "TabFases_CodtamsLostFocus")
6236:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "KeyPress", THIS, "TabFases_CodacbsKeyPress")
6237:         BINDEVENT(loc_oPg.txt_4c_CodacbsFas,  "LostFocus", THIS, "TabFases_CodacbsLostFocus")
6238:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "KeyPress", THIS, "TabFases_ConquilhaKeyPress")
6239:         BINDEVENT(loc_oPg.txt_4c_Conquilhas,  "LostFocus", THIS, "TabFases_ConquilhaLostFocus")
6240:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "KeyPress", THIS, "TabFases_GarraKeyPress")
6241:         BINDEVENT(loc_oPg.txt_4c_Codgarras,   "LostFocus", THIS, "TabFases_GarraLostFocus")
6242: 
6243:     ENDPROC
6244: 
6245:     *--------------------------------------------------------------------------
6246:     * OptSituasChange - OptionGroup Situacao muda Ativo/Inativo
6247:     *--------------------------------------------------------------------------
6248:     PROCEDURE OptSituasChange()
6249:         LOCAL loc_oPg
6250:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6251:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6252:             IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6253:                 IF loc_oPg.opt_4c_Situas.Value = 2
6254:                     loc_oPg.txt_4c_DtSituas.Value = DATE()
6255:                 ENDIF
6256:             ENDIF
6257:         ENDIF
6258:     ENDPROC
6259: 
6260:     *--------------------------------------------------------------------------
6261:     * OptProdWebChange - OptionGroup Produto Web muda valor
6262:     *--------------------------------------------------------------------------
6263:     PROCEDURE OptProdWebChange()
6264:         RETURN
6265:     ENDPROC
6266: 
6267:     *--------------------------------------------------------------------------
6268:     * OptVariasChange - OptionGroup Variacao muda valor
6269:     *--------------------------------------------------------------------------
6270:     PROCEDURE OptVariasChange()
6271:         RETURN
6272:     ENDPROC
6273: 
6274:     *--------------------------------------------------------------------------
6275:     * OpcaoAbasChange - Navegacao entre abas pelo OptionGroup
6276:     * Legado: Optiongroup1.InteractiveChange
6277:     *--------------------------------------------------------------------------
6278:     PROCEDURE OpcaoAbasChange()
6279:         LOCAL loc_nAba, loc_lTemProduto
6280:         loc_nAba      = THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value
6281:         loc_lTemProduto = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCpros))
6282: 
6283:         DO CASE
6284:             CASE loc_nAba = 1   && Principal
6285:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
6286:             CASE loc_nAba = 2   && Composicao
6287:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 2
6288:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6289:                     THIS.CarregarComposicao()
6290:                 ENDIF
6291:             CASE loc_nAba = 3   && Custos
6292:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 3
6293:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6294:                     THIS.CarregarCustos()
6295:                 ENDIF
6296:             CASE loc_nAba = 4   && Dados Fiscais
6297:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 4
6298:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6299:                     THIS.CarregarDadosFiscais()
6300:                 ENDIF
6301:             CASE loc_nAba = 5   && Designer
6302:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 5
6303:             CASE loc_nAba = 6   && Consulta P.
6304:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 6
6305:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6306:                     THIS.CarregarConsultaP()
6307:                 ENDIF
6308:             CASE loc_nAba = 7   && Fases
6309:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 7
6310:                 IF loc_lTemProduto AND !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
6311:                     THIS.CarregarFases()
6312:                 ENDIF
6313:         ENDCASE
6314:     ENDPROC
6315: 
6316:     *--------------------------------------------------------------------------
6317:     * CarregarLista - Busca e exibe lista de produtos no grid
6318:     *--------------------------------------------------------------------------
6319:     PROCEDURE CarregarLista()
6320:         LOCAL loc_oGrid, loc_lResultado, loc_cFiltro, loc_cWhere
6321:         LOCAL loc_cCgru, loc_dIni, loc_dFim, loc_nSit
6322:         loc_lResultado = .F.
6323: 
6324:         TRY
6325:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
6326: 
6327:             *-- Montar filtro a partir dos controles
6328:             loc_cWhere = ""
6329:             loc_cFiltro = ""
6330: 
6331:             *-- Filtro grupo
6332:             loc_cCgru = ""
6333:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6334:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru, "Value", 5)
6335:                     loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
6336:                 ENDIF
6337:             ENDIF
6338: 
6339:             IF !EMPTY(loc_cCgru)
6340:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6341:             ENDIF
6342: 
6343:             *-- Filtro situacao
6344:             loc_nSit = 1
6345:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6346:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6347:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6348:                 ENDIF
6349:             ENDIF
6350: 
6351:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6352:                 IF !EMPTY(loc_cFiltro)
6353:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6354:                 ELSE
6355:                     loc_cFiltro = "p.situas = 1"
6356:                 ENDIF
6357:             ENDIF
6358:             IF loc_nSit = 3   && Apenas inativos (situas=2)
6359:                 IF !EMPTY(loc_cFiltro)

*-- Linhas 6432 a 6475:
6432:     * FormParaBO - Transfere dados do formulario para o Business Object
6433:     * Todos os campos editaveis da aba Principal
6434:     *--------------------------------------------------------------------------
6435:     PROTECTED PROCEDURE FormParaBO()
6436:         LOCAL loc_oBO, loc_oPg
6437:         loc_oBO = THIS.this_oBusinessObject
6438:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6439: 
6440:         *-- Identificacao
6441:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6442:             loc_oBO.this_cCpros  = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
6443:         ENDIF
6444:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6445:             loc_oBO.this_cDpros  = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
6446:         ENDIF
6447:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6448:             loc_oBO.this_cDpro2s = ALLTRIM(loc_oPg.txt_4c_Dpro2s.Value)
6449:         ENDIF
6450: 
6451:         *-- Grupo / Subgrupo
6452:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6453:             loc_oBO.this_cCgrus  = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
6454:         ENDIF
6455:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6456:             loc_oBO.this_cSgrus  = ALLTRIM(loc_oPg.txt_4c_Csgrus.Value)
6457:         ENDIF
6458: 
6459:         *-- Linha / Colecao / Fornecedor / Referencia
6460:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6461:             loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
6462:         ENDIF
6463:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
6464:             loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
6465:         ENDIF
6466:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
6467:             loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
6468:         ENDIF
6469:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
6470:             loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
6471:         ENDIF
6472: 
6473:         *-- Tipo / Identificador / Conjunto / Equivalente
6474:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
6475:             loc_oBO.this_cMercs    = ALLTRIM(loc_oPg.txt_4c_Mercs.Value)

*-- Linhas 6492 a 6535:
6492:             loc_oBO.this_nEan13 = loc_oPg.txt_4c_Ean13.Value
6493:         ENDIF
6494: 
6495:         *-- Situacao (OptionGroup Value=1=Ativo, Value=2=Inativo -> nSituas)
6496:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6497:             loc_oBO.this_nSituas = loc_oPg.opt_4c_Situas.Value
6498:         ENDIF
6499: 
6500:         *-- Lote Minimo / Qtde
6501:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6502:             loc_oBO.this_nLtminsv = loc_oPg.txt_4c_Ltminsv.Value
6503:         ENDIF
6504:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6505:             loc_oBO.this_nQmins   = loc_oPg.txt_4c_Qmins.Value
6506:         ENDIF
6507:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6508:             loc_oBO.this_nQtped   = loc_oPg.txt_4c_Qtped.Value
6509:         ENDIF
6510: 
6511:         *-- Observacoes curtas
6512:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6513:             loc_oBO.this_cObsetqs = ALLTRIM(loc_oPg.txt_4c_Obsetqs.Value)
6514:         ENDIF
6515:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6516:             loc_oBO.this_cObspeds = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
6517:         ENDIF
6518:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6519:             loc_oBO.this_cObspes  = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
6520:         ENDIF
6521: 
6522:         *-- Custo / Moeda custo
6523:         IF PEMSTATUS(loc_oPg, "txt_4c_Custofs", 5)
6524:             loc_oBO.this_nCustofs = loc_oPg.txt_4c_Custofs.Value
6525:         ENDIF
6526:         IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
6527:             loc_oBO.this_cMoecs   = ALLTRIM(loc_oPg.txt_4c_Moecs.Value)
6528:         ENDIF
6529: 
6530:         *-- Preco / Moeda preco
6531:         IF PEMSTATUS(loc_oPg, "txt_4c_Pvens", 5)
6532:             loc_oBO.this_nPvens   = loc_oPg.txt_4c_Pvens.Value
6533:         ENDIF
6534:         IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
6535:             loc_oBO.this_cMoepvs  = ALLTRIM(loc_oPg.txt_4c_Moepvs.Value)

*-- Linhas 6740 a 6783:
6740:     * BOParaForm - Transfere dados do Business Object para o formulario
6741:     * Inclui carga de descricoes de campos lookup via SQL
6742:     *--------------------------------------------------------------------------
6743:     PROTECTED PROCEDURE BOParaForm()
6744:         LOCAL loc_oBO, loc_oPg
6745:         loc_oBO = THIS.this_oBusinessObject
6746:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
6747: 
6748:         *-- Identificacao
6749:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
6750:             loc_oPg.txt_4c_Cpros.Value  = loc_oBO.this_cCpros
6751:         ENDIF
6752:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
6753:             loc_oPg.txt_4c_Dpros.Value  = loc_oBO.this_cDpros
6754:         ENDIF
6755:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
6756:             loc_oPg.txt_4c_Dpro2s.Value = loc_oBO.this_cDpro2s
6757:         ENDIF
6758: 
6759:         *-- Grupo + descricao
6760:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
6761:             loc_oPg.txt_4c_Cgrus.Value = loc_oBO.this_cCgrus
6762:         ENDIF
6763:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
6764:             loc_oPg.txt_4c_Dgrus.Value = THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus")
6765:         ENDIF
6766: 
6767:         *-- Subgrupo + descricao
6768:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
6769:             loc_oPg.txt_4c_Csgrus.Value = loc_oBO.this_cSgrus
6770:         ENDIF
6771:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
6772:             loc_oPg.txt_4c_Dsgrus.Value = THIS.CarregarDescSgru(loc_oBO.this_cCgrus, loc_oBO.this_cSgrus)
6773:         ENDIF
6774: 
6775:         *-- Linha + descricao
6776:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
6777:             loc_oPg.txt_4c_Linhas.Value  = loc_oBO.this_cLinhas
6778:         ENDIF
6779:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
6780:             loc_oPg.txt_4c_Dlinhas.Value = THIS.CarregarDesc("SigCdLin", "Linhas", loc_oBO.this_cLinhas, "Descs")
6781:         ENDIF
6782: 
6783:         *-- Colecao + descricao

*-- Linhas 6823 a 6866:
6823:             loc_oPg.txt_4c_Ean13.Value = loc_oBO.this_nEan13
6824:         ENDIF
6825: 
6826:         *-- Situacao (nSituas 1=Ativo, 2=Inativo -> OptionGroup.Value)
6827:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
6828:             loc_oPg.opt_4c_Situas.Value = IIF(loc_oBO.this_nSituas >= 1, loc_oBO.this_nSituas, 1)
6829:         ENDIF
6830:         IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
6831:             loc_oPg.txt_4c_DtSituas.Value = NVL(loc_oBO.this_dDtsituas, {})
6832:         ENDIF
6833: 
6834:         *-- Lote Minimo / Qtde
6835:         IF PEMSTATUS(loc_oPg, "txt_4c_Ltminsv", 5)
6836:             loc_oPg.txt_4c_Ltminsv.Value = loc_oBO.this_nLtminsv
6837:         ENDIF
6838:         IF PEMSTATUS(loc_oPg, "txt_4c_Qmins", 5)
6839:             loc_oPg.txt_4c_Qmins.Value   = loc_oBO.this_nQmins
6840:         ENDIF
6841:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtped", 5)
6842:             loc_oPg.txt_4c_Qtped.Value   = loc_oBO.this_nQtped
6843:         ENDIF
6844: 
6845:         *-- Observacoes curtas
6846:         IF PEMSTATUS(loc_oPg, "txt_4c_Obsetqs", 5)
6847:             loc_oPg.txt_4c_Obsetqs.Value = loc_oBO.this_cObsetqs
6848:         ENDIF
6849:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspeds", 5)
6850:             loc_oPg.txt_4c_Obspeds.Value = loc_oBO.this_cObspeds
6851:         ENDIF
6852:         IF PEMSTATUS(loc_oPg, "txt_4c_Obspes", 5)
6853:             loc_oPg.txt_4c_Obspes.Value  = loc_oBO.this_cObspes
6854:         ENDIF
6855: 
6856:         *-- Ultima Compra (ReadOnly)
6857:         IF PEMSTATUS(loc_oPg, "txt_4c_Dtucp", 5)
6858:             loc_oPg.txt_4c_Dtucp.Value      = NVL(loc_oBO.this_dUltcomps, {})
6859:         ENDIF
6860:         IF PEMSTATUS(loc_oPg, "txt_4c_Vucp", 5)
6861:             loc_oPg.txt_4c_Vucp.Value       = loc_oBO.this_nVultcomps
6862:         ENDIF
6863:         IF PEMSTATUS(loc_oPg, "txt_4c_Mucp", 5)
6864:             loc_oPg.txt_4c_Mucp.Value       = loc_oBO.this_cMultcomps
6865:         ENDIF
6866:         IF PEMSTATUS(loc_oPg, "txt_4c_Qtdultcomp", 5)

*-- Linhas 7220 a 7263:
7220:     *--------------------------------------------------------------------------
7221:     * LimparCampos - Limpa todos os campos do formulario (aba Principal)
7222:     *--------------------------------------------------------------------------
7223:     PROTECTED PROCEDURE LimparCampos()
7224:         LOCAL loc_oPg
7225:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7226: 
7227:         *-- Identificacao
7228:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7229:             loc_oPg.txt_4c_Cpros.Value  = ""
7230:         ENDIF
7231:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7232:             loc_oPg.txt_4c_Dpros.Value  = ""
7233:         ENDIF
7234:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7235:             loc_oPg.txt_4c_Dpro2s.Value = ""
7236:         ENDIF
7237: 
7238:         *-- Grupo / Subgrupo
7239:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7240:             loc_oPg.txt_4c_Cgrus.Value  = ""
7241:         ENDIF
7242:         IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
7243:             loc_oPg.txt_4c_Dgrus.Value  = ""
7244:         ENDIF
7245:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7246:             loc_oPg.txt_4c_Csgrus.Value = ""
7247:         ENDIF
7248:         IF PEMSTATUS(loc_oPg, "txt_4c_Dsgrus", 5)
7249:             loc_oPg.txt_4c_Dsgrus.Value = ""
7250:         ENDIF
7251: 
7252:         *-- Linha / Colecao / Fornecedor / Ref
7253:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7254:             loc_oPg.txt_4c_Linhas.Value    = ""
7255:         ENDIF
7256:         IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
7257:             loc_oPg.txt_4c_Dlinhas.Value   = ""
7258:         ENDIF
7259:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7260:             loc_oPg.txt_4c_Colecoes.Value  = ""
7261:         ENDIF
7262:         IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
7263:             loc_oPg.txt_4c_Dcolecoes.Value = ""

*-- Linhas 7727 a 7770:
7727:     * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
7728:     * par_lHabilitar: .T. = edicao/inclusao, .F. = visualizacao
7729:     *--------------------------------------------------------------------------
7730:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
7731:         LOCAL loc_oPg, loc_lNovoReg
7732:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7733:         loc_lNovoReg = (THIS.this_cModoAtual = "INCLUIR")
7734: 
7735:         *-- Codigo: editavel SOMENTE na inclusao (PK nao se altera)
7736:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
7737:             loc_oPg.txt_4c_Cpros.ReadOnly = !loc_lNovoReg
7738:         ENDIF
7739: 
7740:         *-- Campos texto editaveis
7741:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpros", 5)
7742:             loc_oPg.txt_4c_Dpros.ReadOnly    = !par_lHabilitar
7743:         ENDIF
7744:         IF PEMSTATUS(loc_oPg, "txt_4c_Dpro2s", 5)
7745:             loc_oPg.txt_4c_Dpro2s.ReadOnly   = !par_lHabilitar
7746:         ENDIF
7747:         IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
7748:             loc_oPg.txt_4c_Cgrus.ReadOnly    = !par_lHabilitar
7749:         ENDIF
7750:         IF PEMSTATUS(loc_oPg, "txt_4c_Csgrus", 5)
7751:             loc_oPg.txt_4c_Csgrus.ReadOnly   = !par_lHabilitar
7752:         ENDIF
7753:         IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
7754:             loc_oPg.txt_4c_Linhas.ReadOnly   = !par_lHabilitar
7755:         ENDIF
7756:         IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
7757:             loc_oPg.txt_4c_Colecoes.ReadOnly = !par_lHabilitar
7758:         ENDIF
7759:         IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
7760:             loc_oPg.txt_4c_Ifors.ReadOnly    = !par_lHabilitar
7761:         ENDIF
7762:         IF PEMSTATUS(loc_oPg, "txt_4c_Reffs", 5)
7763:             loc_oPg.txt_4c_Reffs.ReadOnly    = !par_lHabilitar
7764:         ENDIF
7765:         IF PEMSTATUS(loc_oPg, "txt_4c_Mercs", 5)
7766:             loc_oPg.txt_4c_Mercs.ReadOnly    = !par_lHabilitar
7767:         ENDIF
7768:         IF PEMSTATUS(loc_oPg, "txt_4c_Idecpros", 5)
7769:             loc_oPg.txt_4c_Idecpros.ReadOnly  = !par_lHabilitar
7770:         ENDIF

*-- Linhas 7883 a 7926:
7883:             loc_oPg.txt_4c_Volumes.ReadOnly   = !par_lHabilitar
7884:         ENDIF
7885: 
7886:         *-- OptionGroups e CheckBoxes: Enabled
7887:         IF PEMSTATUS(loc_oPg, "opt_4c_Situas", 5)
7888:             loc_oPg.opt_4c_Situas.Enabled     = par_lHabilitar
7889:         ENDIF
7890:         IF PEMSTATUS(loc_oPg, "opt_4c_ProdWeb", 5)
7891:             loc_oPg.opt_4c_ProdWeb.Enabled    = par_lHabilitar
7892:         ENDIF
7893:         IF PEMSTATUS(loc_oPg, "opt_4c_Varias", 5)
7894:             loc_oPg.opt_4c_Varias.Enabled     = par_lHabilitar
7895:         ENDIF
7896:         IF PEMSTATUS(loc_oPg, "chk_4c_Chkgarvit", 5)
7897:             loc_oPg.chk_4c_Chkgarvit.Enabled  = par_lHabilitar
7898:         ENDIF
7899:         IF PEMSTATUS(loc_oPg, "chk_4c_Consigs", 5)
7900:             loc_oPg.chk_4c_Consigs.Enabled    = par_lHabilitar
7901:         ENDIF
7902:         IF PEMSTATUS(loc_oPg, "chk_4c_Fabrproprs", 5)
7903:             loc_oPg.chk_4c_Fabrproprs.Enabled = par_lHabilitar
7904:         ENDIF
7905:         IF PEMSTATUS(loc_oPg, "chk_4c_Encoms", 5)
7906:             loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar
7907:         ENDIF
7908: 
7909:         *-- EditBoxes (Memo)
7910:         IF PEMSTATUS(loc_oPg, "edt_4c_Dsccompras", 5)
7911:             loc_oPg.edt_4c_Dsccompras.ReadOnly = !par_lHabilitar
7912:         ENDIF
7913:         IF PEMSTATUS(loc_oPg, "edt_4c_Dpro3s", 5)
7914:             loc_oPg.edt_4c_Dpro3s.ReadOnly     = !par_lHabilitar
7915:         ENDIF
7916:         IF PEMSTATUS(loc_oPg, "edt_4c_Obscompras", 5)
7917:             loc_oPg.edt_4c_Obscompras.ReadOnly  = !par_lHabilitar
7918:         ENDIF
7919: 
7920:         *-- Tab 7: Fases - campos e botoes de operacao
7921:         LOCAL loc_oPg7
7922:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
7923: 
7924:         IF PEMSTATUS(loc_oPg7, "txt_4c_Qminfab", 5)
7925:             loc_oPg7.txt_4c_Qminfab.ReadOnly   = !par_lHabilitar
7926:         ENDIF

*-- Linhas 7988 a 9281:
7988:     *--------------------------------------------------------------------------
7989:     * BtnIncluirClick - Incluir novo produto
7990:     *--------------------------------------------------------------------------
7991:     PROCEDURE BtnIncluirClick()
7992:         THIS.this_oBusinessObject.NovoRegistro()
7993:         THIS.LimparCampos()
7994:         THIS.this_cModoAtual = "INCLUIR"
7995:         THIS.HabilitarCampos(.T.)
7996:         THIS.AjustarBotoesPorModo()
7997:         THIS.AlternarPagina(2)
7998:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7999:         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8000:     ENDPROC
8001: 
8002:     *--------------------------------------------------------------------------
8003:     * BtnVisualizarClick - Visualizar produto selecionado
8004:     *--------------------------------------------------------------------------
8005:     PROCEDURE BtnVisualizarClick()
8006:         LOCAL loc_cCodigo
8007: 
8008:         IF !USED("cursor_4c_Dados")
8009:             MsgAviso("Nenhum produto selecionado!")
8010:             RETURN
8011:         ENDIF
8012:         IF RECCOUNT("cursor_4c_Dados") = 0
8013:             MsgAviso("Nenhum produto selecionado!")
8014:             RETURN
8015:         ENDIF
8016: 
8017:         SELECT cursor_4c_Dados
8018:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8019: 
8020:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8021:             THIS.BOParaForm()
8022:             THIS.this_cModoAtual = "VISUALIZAR"
8023:             THIS.HabilitarCampos(.F.)
8024:             THIS.AjustarBotoesPorModo()
8025:             THIS.AlternarPagina(2)
8026:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8027:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8028:         ENDIF
8029:     ENDPROC
8030: 
8031:     *--------------------------------------------------------------------------
8032:     * BtnAlterarClick - Alterar produto selecionado
8033:     *--------------------------------------------------------------------------
8034:     PROCEDURE BtnAlterarClick()
8035:         LOCAL loc_cCodigo
8036: 
8037:         IF !USED("cursor_4c_Dados")
8038:             MsgAviso("Nenhum produto selecionado!")
8039:             RETURN
8040:         ENDIF
8041:         IF RECCOUNT("cursor_4c_Dados") = 0
8042:             MsgAviso("Nenhum produto selecionado!")
8043:             RETURN
8044:         ENDIF
8045: 
8046:         SELECT cursor_4c_Dados
8047:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8048: 
8049:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8050:             THIS.this_oBusinessObject.EditarRegistro()
8051:             THIS.BOParaForm()
8052:             THIS.this_cModoAtual = "ALTERAR"
8053:             THIS.HabilitarCampos(.T.)
8054:             THIS.AjustarBotoesPorModo()
8055:             THIS.AlternarPagina(2)
8056:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8057:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8058:         ENDIF
8059:     ENDPROC
8060: 
8061:     *--------------------------------------------------------------------------
8062:     * BtnExcluirClick - Excluir produto selecionado
8063:     * Legado: verifica se produto e usado em pedidos/fichas tecnicas
8064:     *--------------------------------------------------------------------------
8065:     PROCEDURE BtnExcluirClick()
8066:         LOCAL loc_cCodigo, loc_cSQL, loc_nResultado
8067: 
8068:         IF !USED("cursor_4c_Dados")
8069:             MsgAviso("Nenhum produto selecionado!")
8070:             RETURN
8071:         ENDIF
8072:         IF RECCOUNT("cursor_4c_Dados") = 0
8073:             MsgAviso("Nenhum produto selecionado!")
8074:             RETURN
8075:         ENDIF
8076: 
8077:         SELECT cursor_4c_Dados
8078:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8079: 
8080:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8081: 
8082:             *-- Verificar uso em itens de pedido (SigMvCIte)
8083:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8084:                 SELECT COUNT(*) AS nExiste
8085:                 FROM SigMvCIte
8086:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8087:             ENDTEXT
8088: 
8089:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8090: 
8091:             IF loc_nResultado < 0
8092:                 MsgErro("Falha ao verificar uso do produto!")
8093:                 IF USED("cursor_4c_VerPro")
8094:                     USE IN cursor_4c_VerPro
8095:                 ENDIF
8096:                 RETURN
8097:             ENDIF
8098: 
8099:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8100:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8101:                 IF USED("cursor_4c_VerPro")
8102:                     USE IN cursor_4c_VerPro
8103:                 ENDIF
8104:                 RETURN
8105:             ENDIF
8106: 
8107:             IF USED("cursor_4c_VerPro")
8108:                 USE IN cursor_4c_VerPro
8109:             ENDIF
8110: 
8111:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do produto '" + loc_cCodigo + "'?")
8112:                 IF THIS.this_oBusinessObject.Excluir()
8113:                     MsgSucesso("Produto exclu" + CHR(237) + "do com sucesso!")
8114:                     THIS.CarregarLista()
8115:                 ENDIF
8116:             ENDIF
8117:         ENDIF
8118:     ENDPROC
8119: 
8120:     *--------------------------------------------------------------------------
8121:     * BtnSalvarClick - Salvar produto
8122:     *--------------------------------------------------------------------------
8123:     PROCEDURE BtnSalvarClick()
8124:         LOCAL loc_oPg, loc_cCodNovo, loc_cSQLDup, loc_nDup
8125: 
8126:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8127: 
8128:         *-- Validacao: codigo obrigatorio
8129:         IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8130:             IF EMPTY(loc_oPg.txt_4c_Cpros.Value)
8131:                 MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o pode ficar em branco!")
8132:                 IF PEMSTATUS(loc_oPg.txt_4c_Cpros, "SetFocus", 5)
8133:                     loc_oPg.txt_4c_Cpros.SetFocus()
8134:                 ENDIF
8135:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8136:                 THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8137:                 RETURN
8138:             ENDIF
8139:         ENDIF
8140: 
8141:         *-- Validacao: codigo duplicado (apenas no modo INCLUIR)
8142:         IF THIS.this_cModoAtual = "INCLUIR"
8143:             IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8144:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8145: 
8146:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8147:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8148:                 ENDTEXT
8149: 
8150:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8151: 
8152:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8153:                     IF USED("cursor_4c_DupPro")
8154:                         USE IN cursor_4c_DupPro
8155:                     ENDIF
8156:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8157:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8158:                         loc_oPg.txt_4c_Cpros.SetFocus()
8159:                     ENDIF
8160:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8161:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8162:                     RETURN
8163:                 ENDIF
8164: 
8165:                 IF USED("cursor_4c_DupPro")
8166:                     USE IN cursor_4c_DupPro
8167:                 ENDIF
8168:             ENDIF
8169:         ENDIF
8170: 
8171:         THIS.FormParaBO()
8172: 
8173:         IF THIS.this_oBusinessObject.Salvar()
8174:             MsgSucesso("Produto salvo com sucesso!")
8175:             THIS.AlternarPagina(1)
8176:             THIS.CarregarLista()
8177:         ENDIF
8178:     ENDPROC
8179: 
8180:     *--------------------------------------------------------------------------
8181:     * BtnCancelarClick - Cancelar edicao
8182:     *--------------------------------------------------------------------------
8183:     PROCEDURE BtnCancelarClick()
8184:         THIS.this_cModoAtual = "LISTA"
8185:         THIS.AlternarPagina(1)
8186:         THIS.CarregarLista()
8187:     ENDPROC
8188: 
8189:     *--------------------------------------------------------------------------
8190:     * BtnBuscarClick - Abre FormBuscaAuxiliar para busca de produtos
8191:     *--------------------------------------------------------------------------
8192:     PROCEDURE BtnBuscarClick()
8193:         LOCAL loc_oBusca, loc_cCodigo
8194: 
8195:         TRY
8196:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Buscar Produto")
8197: 
8198:             loc_oBusca.mAddColuna("cpros", "", "Produto")
8199:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8200:             loc_oBusca.mAddColuna("cgrus", "", "Grupo")
8201: 
8202:             loc_oBusca.Show()
8203: 
8204:             IF loc_oBusca.this_lSelecionou
8205:                 IF USED("cursor_4c_Busca")
8206:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
8207: 
8208:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8209:                         THIS.BOParaForm()
8210:                         THIS.this_cModoAtual = "VISUALIZAR"
8211:                         THIS.HabilitarCampos(.F.)
8212:                         THIS.AjustarBotoesPorModo()
8213:                         THIS.AlternarPagina(2)
8214:                         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8215:                         THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8216:                     ENDIF
8217:                 ENDIF
8218:             ENDIF
8219: 
8220:             IF USED("cursor_4c_Busca")
8221:                 USE IN cursor_4c_Busca
8222:             ENDIF
8223:             loc_oBusca.Release()
8224: 
8225:         CATCH TO loc_oErro
8226:             MsgErro("Erro ao buscar produto:" + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + loc_oErro.Message, "FormProduto.BtnBuscarClick")
8227:         ENDTRY
8228:     ENDPROC
8229: 
8230:     *--------------------------------------------------------------------------
8231:     * BtnEncerrarClick - Fechar formulario
8232:     *--------------------------------------------------------------------------
8233:     PROCEDURE BtnEncerrarClick()
8234:         THIS.Release()
8235:     ENDPROC
8236: 
8237:     *--------------------------------------------------------------------------
8238:     * BtnPesquisarClick - Recarregar lista com filtros aplicados
8239:     *--------------------------------------------------------------------------
8240:     PROCEDURE BtnPesquisarClick()
8241:         THIS.CarregarLista()
8242:     ENDPROC
8243: 
8244:     *--------------------------------------------------------------------------
8245:     * GrdLista_DblClick - Duplo clique na grade abre visualizacao
8246:     *--------------------------------------------------------------------------
8247:     PROCEDURE GrdLista_DblClick()
8248:         THIS.BtnVisualizarClick()
8249:     ENDPROC
8250: 
8251:     *--------------------------------------------------------------------------
8252:     * FiltroGrupo_KeyPress - F4 no filtro de grupo abre lookup de grupos
8253:     *--------------------------------------------------------------------------
8254:     PROCEDURE FiltroGrupo_KeyPress
8255:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8256:         IF par_nKeyCode = 115    && F4=115 (VFP9)
8257:             THIS.AbrirLookupFiltroGrupo()
8258:         ENDIF
8259:     ENDPROC
8260: 
8261:     *--------------------------------------------------------------------------
8262:     * ValidarFiltroGrupo - LostFocus no filtro de grupo
8263:     *--------------------------------------------------------------------------
8264:     PROCEDURE ValidarFiltroGrupo()
8265:         LOCAL loc_cCgru, loc_cSQL, loc_nRes, loc_oBusca
8266:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8267: 
8268:         IF loc_cCgru == THIS.this_cUltFiltroGru
8269:             RETURN
8270:         ENDIF
8271:         THIS.this_cUltFiltroGru = loc_cCgru
8272: 
8273:         IF EMPTY(loc_cCgru)
8274:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8275:             RETURN
8276:         ENDIF
8277: 
8278:         TRY
8279:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8280:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8281:             ENDTEXT
8282: 
8283:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8284: 
8285:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8286:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8287:             ELSE
8288:                 *-- Codigo nao encontrado: abrir lookup
8289:                 THIS.AbrirLookupFiltroGrupo()
8290:             ENDIF
8291: 
8292:             IF USED("cursor_4c_VerGru")
8293:                 USE IN cursor_4c_VerGru
8294:             ENDIF
8295:         CATCH TO loc_oErro
8296:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8297:         ENDTRY
8298:     ENDPROC
8299: 
8300:     *--------------------------------------------------------------------------
8301:     * AbrirLookupFiltroGrupo - Lookup F4 no filtro de grupo
8302:     *--------------------------------------------------------------------------
8303:     PROTECTED PROCEDURE AbrirLookupFiltroGrupo()
8304:         LOCAL loc_oBusca, loc_cValor
8305:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value)
8306: 
8307:         TRY
8308:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Gru", "cgrus", loc_cValor, "Selecionar Grupo")
8309:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8310:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8311:             loc_oBusca.Show()
8312: 
8313:             IF loc_oBusca.this_lSelecionou
8314:                 IF USED("cursor_4c_Gru")
8315:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ALLTRIM(cursor_4c_Gru.cgrus)
8316:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_Gru.dgrus)
8317:                 ENDIF
8318:             ELSE
8319:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroCgru.Value = ""
8320:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ""
8321:             ENDIF
8322: 
8323:             IF USED("cursor_4c_Gru")
8324:                 USE IN cursor_4c_Gru
8325:             ENDIF
8326:             loc_oBusca.Release()
8327:         CATCH TO loc_oErro
8328:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFiltroGrupo")
8329:         ENDTRY
8330:     ENDPROC
8331: 
8332:     *--------------------------------------------------------------------------
8333:     * FiltroSituas_InteractiveChange - Mudar filtro de situacao
8334:     *--------------------------------------------------------------------------
8335:     PROCEDURE FiltroSituas_InteractiveChange()
8336:         THIS.CarregarLista()
8337:     ENDPROC
8338: 
8339:     *--------------------------------------------------------------------------
8340:     * FormatarGridLista - Formata visual do grid da lista
8341:     *--------------------------------------------------------------------------
8342:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
8343:         WITH par_oGrid
8344:             IF .ColumnCount > 0
8345:                 .FontName = "Tahoma"
8346:                 .FontSize = 8
8347:             ENDIF
8348:         ENDWITH
8349:     ENDPROC
8350: 
8351:     *--------------------------------------------------------------------------
8352:     * TornarControlesVisiveis - Torna todos os controles visiveis
8353:     * Filtra por nome para evitar tornar containers flutuantes visiveis
8354:     *--------------------------------------------------------------------------
8355:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
8356:         LOCAL loc_nI, loc_oObjeto, loc_cNome
8357: 
8358:         FOR loc_nI = 1 TO par_oContainer.ControlCount
8359:             loc_oObjeto = par_oContainer.Controls(loc_nI)
8360: 
8361:             IF VARTYPE(loc_oObjeto) = "O"
8362:                 loc_cNome = LOWER(loc_oObjeto.Name)
8363: 
8364:                 *-- Nao tornar visiveis containers flutuantes (Visible=.F. por design)
8365:                 IF INLIST(loc_cNome, "cntmensagem", "cntacabado", "cnt_4c_cabecalho")
8366:                     LOOP
8367:                 ENDIF
8368: 
8369:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
8370:                     loc_oObjeto.Visible = .T.
8371:                 ENDIF
8372: 
8373:                 *-- Trata PageFrame - itera Pages
8374:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
8375:                     LOCAL loc_nP
8376:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
8377:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
8378:                     ENDFOR
8379:                 ENDIF
8380: 
8381:                 *-- Trata containers com ControlCount
8382:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
8383:                     THIS.TornarControlesVisiveis(loc_oObjeto)
8384:                 ENDIF
8385:             ENDIF
8386:         ENDFOR
8387:     ENDPROC
8388: 
8389:     *--------------------------------------------------------------------------
8390:     * Destroy - Limpar recursos ao fechar
8391:     *--------------------------------------------------------------------------
8392:     PROCEDURE Destroy()
8393:         IF USED("cursor_4c_Dados")
8394:             USE IN cursor_4c_Dados
8395:         ENDIF
8396:         IF USED("cursor_4c_Busca")
8397:             USE IN cursor_4c_Busca
8398:         ENDIF
8399:         IF USED("cursor_4c_Registro")
8400:             USE IN cursor_4c_Registro
8401:         ENDIF
8402: 
8403:         IF !ISNULL(THIS.this_oBusinessObject)
8404:             THIS.this_oBusinessObject = .NULL.
8405:         ENDIF
8406: 
8407:         DODEFAULT()
8408:     ENDPROC
8409: 
8410:     *==========================================================================
8411:     * === METODOS PUBLICOS DE LOOKUP / VALIDACAO (Tab Principal) ==============
8412:     * BINDEVENT requer metodos PUBLIC
8413:     *==========================================================================
8414: 
8415:     *--------------------------------------------------------------------------
8416:     * TabPrincipal_CgruKeyPress - F4 no campo Grupo abre lookup
8417:     *--------------------------------------------------------------------------
8418:     PROCEDURE TabPrincipal_CgruKeyPress
8419:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8420:         IF par_nKeyCode = 115    && F4=115 em VFP9
8421:             THIS.AbrirLookupGrupo()
8422:         ENDIF
8423:     ENDPROC
8424: 
8425:     *--------------------------------------------------------------------------
8426:     * TabPrincipal_CgruLostFocus - LostFocus valida e carrega descricao do grupo
8427:     *--------------------------------------------------------------------------
8428:     PROCEDURE TabPrincipal_CgruLostFocus()
8429:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8430:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8431:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8432:             RETURN
8433:         ENDIF
8434:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
8435: 
8436:         IF loc_cCod == THIS.this_cUltCgrus
8437:             RETURN
8438:         ENDIF
8439:         THIS.this_cUltCgrus = loc_cCod
8440: 
8441:         IF EMPTY(loc_cCod)
8442:             IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8443:                 loc_oPg.txt_4c_Dgrus.Value = ""
8444:             ENDIF
8445:             RETURN
8446:         ENDIF
8447: 
8448:         TRY
8449:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8450:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8451:             ENDTEXT
8452:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8453:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8454:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8455:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8456:                 ENDIF
8457:             ELSE
8458:                 THIS.AbrirLookupGrupo()
8459:             ENDIF
8460:             IF USED("cursor_4c_VGrp")
8461:                 USE IN cursor_4c_VGrp
8462:             ENDIF
8463:         CATCH TO loc_oErro
8464:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8465:         ENDTRY
8466:     ENDPROC
8467: 
8468:     *--------------------------------------------------------------------------
8469:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para selecionar grupo de produto
8470:     *--------------------------------------------------------------------------
8471:     PROTECTED PROCEDURE AbrirLookupGrupo()
8472:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8473:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8474:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5), ALLTRIM(loc_oPg.txt_4c_Cgrus.Value), "")
8475: 
8476:         TRY
8477:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Grp", "cgrus", loc_cVal, "Selecionar Grupo")
8478:             loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
8479:             loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
8480:             loc_oBusca.Show()
8481: 
8482:             IF loc_oBusca.this_lSelecionou
8483:                 IF USED("cursor_4c_Grp")
8484:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8485:                         loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(cursor_4c_Grp.cgrus)
8486:                     ENDIF
8487:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8488:                         loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_Grp.dgrus)
8489:                     ENDIF
8490:                 ENDIF
8491:             ELSE
8492:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cgrus", 5)
8493:                     loc_oPg.txt_4c_Cgrus.Value = ""
8494:                 ENDIF
8495:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8496:                     loc_oPg.txt_4c_Dgrus.Value = ""
8497:                 ENDIF
8498:             ENDIF
8499: 
8500:             IF USED("cursor_4c_Grp")
8501:                 USE IN cursor_4c_Grp
8502:             ENDIF
8503:             loc_oBusca.Release()
8504:         CATCH TO loc_oErro
8505:             MsgErro("Erro no lookup de grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGrupo")
8506:         ENDTRY
8507:     ENDPROC
8508: 
8509:     *--------------------------------------------------------------------------
8510:     * TabPrincipal_LinhasKeyPress - F4 no campo Linha abre lookup
8511:     *--------------------------------------------------------------------------
8512:     PROCEDURE TabPrincipal_LinhasKeyPress
8513:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8514:         IF par_nKeyCode = 115
8515:             THIS.AbrirLookupLinha()
8516:         ENDIF
8517:     ENDPROC
8518: 
8519:     *--------------------------------------------------------------------------
8520:     * TabPrincipal_LinhasLostFocus - LostFocus valida e carrega descricao da linha
8521:     *--------------------------------------------------------------------------
8522:     PROCEDURE TabPrincipal_LinhasLostFocus()
8523:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8524:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8525:         IF !PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8526:             RETURN
8527:         ENDIF
8528:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
8529: 
8530:         IF loc_cCod == THIS.this_cUltLinhas
8531:             RETURN
8532:         ENDIF
8533:         THIS.this_cUltLinhas = loc_cCod
8534: 
8535:         IF EMPTY(loc_cCod)
8536:             IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8537:                 loc_oPg.txt_4c_Dlinhas.Value = ""
8538:             ENDIF
8539:             RETURN
8540:         ENDIF
8541: 
8542:         TRY
8543:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8544:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8545:             ENDTEXT
8546:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8547:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8548:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8549:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8550:                 ENDIF
8551:             ELSE
8552:                 THIS.AbrirLookupLinha()
8553:             ENDIF
8554:             IF USED("cursor_4c_VLin")
8555:                 USE IN cursor_4c_VLin
8556:             ENDIF
8557:         CATCH TO loc_oErro
8558:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8559:         ENDTRY
8560:     ENDPROC
8561: 
8562:     *--------------------------------------------------------------------------
8563:     * AbrirLookupLinha - Abre FormBuscaAuxiliar para selecionar linha de produto
8564:     *--------------------------------------------------------------------------
8565:     PROTECTED PROCEDURE AbrirLookupLinha()
8566:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8567:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8568:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5), ALLTRIM(loc_oPg.txt_4c_Linhas.Value), "")
8569: 
8570:         TRY
8571:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Lin", "Linhas", loc_cVal, "Selecionar Linha")
8572:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
8573:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
8574:             loc_oBusca.Show()
8575: 
8576:             IF loc_oBusca.this_lSelecionou
8577:                 IF USED("cursor_4c_Lin")
8578:                     IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8579:                         loc_oPg.txt_4c_Linhas.Value  = ALLTRIM(cursor_4c_Lin.Linhas)
8580:                     ENDIF
8581:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8582:                         loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_Lin.Descs)
8583:                     ENDIF
8584:                 ENDIF
8585:             ELSE
8586:                 IF PEMSTATUS(loc_oPg, "txt_4c_Linhas", 5)
8587:                     loc_oPg.txt_4c_Linhas.Value  = ""
8588:                 ENDIF
8589:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8590:                     loc_oPg.txt_4c_Dlinhas.Value = ""
8591:                 ENDIF
8592:             ENDIF
8593: 
8594:             IF USED("cursor_4c_Lin")
8595:                 USE IN cursor_4c_Lin
8596:             ENDIF
8597:             loc_oBusca.Release()
8598:         CATCH TO loc_oErro
8599:             MsgErro("Erro no lookup de linha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupLinha")
8600:         ENDTRY
8601:     ENDPROC
8602: 
8603:     *--------------------------------------------------------------------------
8604:     * TabPrincipal_ColecoesKeyPress - F4 no campo Grupo de Venda abre lookup
8605:     *--------------------------------------------------------------------------
8606:     PROCEDURE TabPrincipal_ColecoesKeyPress
8607:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8608:         IF par_nKeyCode = 115
8609:             THIS.AbrirLookupColecao()
8610:         ENDIF
8611:     ENDPROC
8612: 
8613:     *--------------------------------------------------------------------------
8614:     * TabPrincipal_ColecoesLostFocus - LostFocus valida e carrega descricao
8615:     *--------------------------------------------------------------------------
8616:     PROCEDURE TabPrincipal_ColecoesLostFocus()
8617:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8618:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8619:         IF !PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8620:             RETURN
8621:         ENDIF
8622:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
8623: 
8624:         IF loc_cCod == THIS.this_cUltColecoes
8625:             RETURN
8626:         ENDIF
8627:         THIS.this_cUltColecoes = loc_cCod
8628: 
8629:         IF EMPTY(loc_cCod)
8630:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8631:                 loc_oPg.txt_4c_Dcolecoes.Value = ""
8632:             ENDIF
8633:             RETURN
8634:         ENDIF
8635: 
8636:         TRY
8637:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8638:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8639:             ENDTEXT
8640:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8641:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8642:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8643:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8644:                 ENDIF
8645:             ELSE
8646:                 THIS.AbrirLookupColecao()
8647:             ENDIF
8648:             IF USED("cursor_4c_VCol")
8649:                 USE IN cursor_4c_VCol
8650:             ENDIF
8651:         CATCH TO loc_oErro
8652:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8653:         ENDTRY
8654:     ENDPROC
8655: 
8656:     *--------------------------------------------------------------------------
8657:     * AbrirLookupColecao - Abre FormBuscaAuxiliar para selecionar grupo de venda
8658:     *--------------------------------------------------------------------------
8659:     PROTECTED PROCEDURE AbrirLookupColecao()
8660:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8661:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8662:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5), ALLTRIM(loc_oPg.txt_4c_Colecoes.Value), "")
8663: 
8664:         TRY
8665:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Col", "Colecoes", loc_cVal, "Selecionar Grupo de Venda")
8666:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
8667:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
8668:             loc_oBusca.Show()
8669: 
8670:             IF loc_oBusca.this_lSelecionou
8671:                 IF USED("cursor_4c_Col")
8672:                     IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8673:                         loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(cursor_4c_Col.Colecoes)
8674:                     ENDIF
8675:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8676:                         loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_Col.Descs)
8677:                     ENDIF
8678:                 ENDIF
8679:             ELSE
8680:                 IF PEMSTATUS(loc_oPg, "txt_4c_Colecoes", 5)
8681:                     loc_oPg.txt_4c_Colecoes.Value  = ""
8682:                 ENDIF
8683:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8684:                     loc_oPg.txt_4c_Dcolecoes.Value = ""
8685:                 ENDIF
8686:             ENDIF
8687: 
8688:             IF USED("cursor_4c_Col")
8689:                 USE IN cursor_4c_Col
8690:             ENDIF
8691:             loc_oBusca.Release()
8692:         CATCH TO loc_oErro
8693:             MsgErro("Erro no lookup de cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupColecao")
8694:         ENDTRY
8695:     ENDPROC
8696: 
8697:     *--------------------------------------------------------------------------
8698:     * TabPrincipal_IforsKeyPress - F4 no campo Fornecedor abre lookup
8699:     *--------------------------------------------------------------------------
8700:     PROCEDURE TabPrincipal_IforsKeyPress
8701:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8702:         IF par_nKeyCode = 115
8703:             THIS.AbrirLookupFornecedor()
8704:         ENDIF
8705:     ENDPROC
8706: 
8707:     *--------------------------------------------------------------------------
8708:     * TabPrincipal_IforsLostFocus - LostFocus valida e carrega nome do fornecedor
8709:     *--------------------------------------------------------------------------
8710:     PROCEDURE TabPrincipal_IforsLostFocus()
8711:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8712:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8713:         IF !PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8714:             RETURN
8715:         ENDIF
8716:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
8717: 
8718:         IF loc_cCod == THIS.this_cUltIfors
8719:             RETURN
8720:         ENDIF
8721:         THIS.this_cUltIfors = loc_cCod
8722: 
8723:         IF EMPTY(loc_cCod)
8724:             IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8725:                 loc_oPg.txt_4c_Dfors.Value = ""
8726:             ENDIF
8727:             RETURN
8728:         ENDIF
8729: 
8730:         TRY
8731:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8732:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8733:             ENDTEXT
8734:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8735:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8736:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8737:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8738:                 ENDIF
8739:             ELSE
8740:                 THIS.AbrirLookupFornecedor()
8741:             ENDIF
8742:             IF USED("cursor_4c_VFor")
8743:                 USE IN cursor_4c_VFor
8744:             ENDIF
8745:         CATCH TO loc_oErro
8746:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8747:         ENDTRY
8748:     ENDPROC
8749: 
8750:     *--------------------------------------------------------------------------
8751:     * AbrirLookupFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
8752:     *--------------------------------------------------------------------------
8753:     PROTECTED PROCEDURE AbrirLookupFornecedor()
8754:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8755:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8756:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5), ALLTRIM(loc_oPg.txt_4c_Ifors.Value), "")
8757: 
8758:         TRY
8759:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_For", "IClis", loc_cVal, "Selecionar Fornecedor")
8760:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
8761:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
8762:             loc_oBusca.Show()
8763: 
8764:             IF loc_oBusca.this_lSelecionou
8765:                 IF USED("cursor_4c_For")
8766:                     IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8767:                         loc_oPg.txt_4c_Ifors.Value = ALLTRIM(cursor_4c_For.IClis)
8768:                     ENDIF
8769:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8770:                         loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_For.Rclis)
8771:                     ENDIF
8772:                 ENDIF
8773:             ELSE
8774:                 IF PEMSTATUS(loc_oPg, "txt_4c_Ifors", 5)
8775:                     loc_oPg.txt_4c_Ifors.Value = ""
8776:                 ENDIF
8777:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8778:                     loc_oPg.txt_4c_Dfors.Value = ""
8779:                 ENDIF
8780:             ENDIF
8781: 
8782:             IF USED("cursor_4c_For")
8783:                 USE IN cursor_4c_For
8784:             ENDIF
8785:             loc_oBusca.Release()
8786:         CATCH TO loc_oErro
8787:             MsgErro("Erro no lookup de fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupFornecedor")
8788:         ENDTRY
8789:     ENDPROC
8790: 
8791:     *--------------------------------------------------------------------------
8792:     * TabPrincipal_CproeqsKeyPress - F4 no campo Produto Equivalente
8793:     *--------------------------------------------------------------------------
8794:     PROCEDURE TabPrincipal_CproeqsKeyPress
8795:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8796:         IF par_nKeyCode = 115
8797:             THIS.AbrirLookupEquivalente()
8798:         ENDIF
8799:     ENDPROC
8800: 
8801:     *--------------------------------------------------------------------------
8802:     * AbrirLookupEquivalente - Abre FormBuscaAuxiliar para produto equivalente
8803:     *--------------------------------------------------------------------------
8804:     PROTECTED PROCEDURE AbrirLookupEquivalente()
8805:         LOCAL loc_oBusca, loc_oPg, loc_cVal
8806:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8807:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5), ALLTRIM(loc_oPg.txt_4c_Cproeqs.Value), "")
8808: 
8809:         TRY
8810:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Eq", "cpros", loc_cVal, "Selecionar Produto Equivalente")
8811:             loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
8812:             loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
8813:             loc_oBusca.Show()
8814: 
8815:             IF loc_oBusca.this_lSelecionou
8816:                 IF USED("cursor_4c_Eq")
8817:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8818:                         loc_oPg.txt_4c_Cproeqs.Value = ALLTRIM(cursor_4c_Eq.cpros)
8819:                     ENDIF
8820:                 ENDIF
8821:             ELSE
8822:                 IF PEMSTATUS(loc_oPg, "txt_4c_Cproeqs", 5)
8823:                     loc_oPg.txt_4c_Cproeqs.Value = ""
8824:                 ENDIF
8825:             ENDIF
8826: 
8827:             IF USED("cursor_4c_Eq")
8828:                 USE IN cursor_4c_Eq
8829:             ENDIF
8830:             loc_oBusca.Release()
8831:         CATCH TO loc_oErro
8832:             MsgErro("Erro no lookup de equivalente:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupEquivalente")
8833:         ENDTRY
8834:     ENDPROC
8835: 
8836:     *--------------------------------------------------------------------------
8837:     * TabPrincipal_MoeKeyPress - F4 nos campos de moeda abre lookup
8838:     *--------------------------------------------------------------------------
8839:     PROCEDURE TabPrincipal_MoeKeyPress
8840:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8841:         IF par_nKeyCode = 115
8842:             THIS.AbrirLookupMoeda()
8843:         ENDIF
8844:     ENDPROC
8845: 
8846:     *--------------------------------------------------------------------------
8847:     * TabPrincipal_MoeLostFocus - LostFocus nos campos de moeda (sem acao)
8848:     * Validacao de moeda ocorre no BO.Validar() ao salvar
8849:     *--------------------------------------------------------------------------
8850:     PROCEDURE TabPrincipal_MoeLostFocus()
8851:         RETURN
8852:     ENDPROC
8853: 
8854:     *--------------------------------------------------------------------------
8855:     * AbrirLookupMoeda - Abre FormBuscaAuxiliar para selecionar moeda
8856:     *--------------------------------------------------------------------------
8857:     PROTECTED PROCEDURE AbrirLookupMoeda()
8858:         LOCAL loc_oBusca, loc_oPg, loc_cMoeCod
8859:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8860: 
8861:         TRY
8862:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_Moe", "CMoes", "", "Selecionar Moeda")
8863:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
8864:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
8865:             loc_oBusca.Show()
8866: 
8867:             IF loc_oBusca.this_lSelecionou
8868:                 IF USED("cursor_4c_Moe")
8869:                     loc_cMoeCod = ALLTRIM(cursor_4c_Moe.CMoes)
8870:                     *-- Aplicar ao campo de moeda que nao estiver ReadOnly
8871:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moecs", 5)
8872:                         IF !loc_oPg.txt_4c_Moecs.ReadOnly
8873:                             loc_oPg.txt_4c_Moecs.Value = loc_cMoeCod
8874:                         ENDIF
8875:                     ENDIF
8876:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moepvs", 5)
8877:                         IF !loc_oPg.txt_4c_Moepvs.ReadOnly
8878:                             loc_oPg.txt_4c_Moepvs.Value = loc_cMoeCod
8879:                         ENDIF
8880:                     ENDIF
8881:                 ENDIF
8882:             ENDIF
8883: 
8884:             IF USED("cursor_4c_Moe")
8885:                 USE IN cursor_4c_Moe
8886:             ENDIF
8887:             loc_oBusca.Release()
8888:         CATCH TO loc_oErro
8889:             MsgErro("Erro no lookup de moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupMoeda")
8890:         ENDTRY
8891:     ENDPROC
8892: 
8893:     *--------------------------------------------------------------------------
8894:     * TabPrincipal_CunisKeyPress - F4 no campo Unidade 1 abre lookup
8895:     *--------------------------------------------------------------------------
8896:     PROCEDURE TabPrincipal_CunisKeyPress
8897:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8898:         IF par_nKeyCode = 115
8899:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8900:         ENDIF
8901:     ENDPROC
8902: 
8903:     *--------------------------------------------------------------------------
8904:     * TabPrincipal_CunisLostFocus - LostFocus valida unidade 1
8905:     *--------------------------------------------------------------------------
8906:     PROCEDURE TabPrincipal_CunisLostFocus()
8907:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8908:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8909:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunis", 5)
8910:             RETURN
8911:         ENDIF
8912:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
8913: 
8914:         IF loc_cCod == THIS.this_cUltCunis
8915:             RETURN
8916:         ENDIF
8917:         THIS.this_cUltCunis = loc_cCod
8918: 
8919:         IF EMPTY(loc_cCod)
8920:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8921:                 loc_oPg.txt_4c_Dunis.Value = ""
8922:             ENDIF
8923:             RETURN
8924:         ENDIF
8925: 
8926:         TRY
8927:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8928:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8929:             ENDTEXT
8930:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8931:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8932:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8933:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8934:                 ENDIF
8935:             ELSE
8936:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8937:             ENDIF
8938:             IF USED("cursor_4c_VUni")
8939:                 USE IN cursor_4c_VUni
8940:             ENDIF
8941:         CATCH TO loc_oErro
8942:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8943:         ENDTRY
8944:     ENDPROC
8945: 
8946:     *--------------------------------------------------------------------------
8947:     * TabPrincipal_CunipsKeyPress - F4 no campo Unidade 2 abre lookup
8948:     *--------------------------------------------------------------------------
8949:     PROCEDURE TabPrincipal_CunipsKeyPress
8950:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
8951:         IF par_nKeyCode = 115
8952:             THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8953:         ENDIF
8954:     ENDPROC
8955: 
8956:     *--------------------------------------------------------------------------
8957:     * TabPrincipal_CunipsLostFocus - LostFocus valida unidade 2
8958:     *--------------------------------------------------------------------------
8959:     PROCEDURE TabPrincipal_CunipsLostFocus()
8960:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
8961:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
8962:         IF !PEMSTATUS(loc_oPg, "txt_4c_Cunips", 5)
8963:             RETURN
8964:         ENDIF
8965:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunips.Value)
8966: 
8967:         IF loc_cCod == THIS.this_cUltCunips
8968:             RETURN
8969:         ENDIF
8970:         THIS.this_cUltCunips = loc_cCod
8971: 
8972:         IF EMPTY(loc_cCod)
8973:             IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8974:                 loc_oPg.txt_4c_Dunips.Value = ""
8975:             ENDIF
8976:             RETURN
8977:         ENDIF
8978: 
8979:         TRY
8980:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8981:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8982:             ENDTEXT
8983:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8984:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8985:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8986:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8987:                 ENDIF
8988:             ELSE
8989:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8990:             ENDIF
8991:             IF USED("cursor_4c_VUn2")
8992:                 USE IN cursor_4c_VUn2
8993:             ENDIF
8994:         CATCH TO loc_oErro
8995:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8996:         ENDTRY
8997:     ENDPROC
8998: 
8999:     *--------------------------------------------------------------------------
9000:     * AbrirLookupUnidade - Abre FormBuscaAuxiliar para selecionar unidade
9001:     * par_cKeyField: campo chave na SigCdUni
9002:     * par_cTxtCode: nome do TextBox de codigo na Page1
9003:     * par_cTxtDesc: nome do TextBox de descricao na Page1
9004:     *--------------------------------------------------------------------------
9005:     PROTECTED PROCEDURE AbrirLookupUnidade(par_cKeyField, par_cTxtCode, par_cTxtDesc)
9006:         LOCAL loc_oBusca, loc_oPg, loc_cVal, loc_cTxtCodeRef, loc_cTxtDescRef
9007:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9008:         loc_cVal = IIF(PEMSTATUS(loc_oPg, par_cTxtCode, 5), ALLTRIM(loc_oPg.&par_cTxtCode..Value), "")
9009: 
9010:         TRY
9011:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUni", "cursor_4c_Uni", par_cKeyField, loc_cVal, "Selecionar Unidade")
9012:             loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
9013:             loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
9014:             loc_oBusca.Show()
9015: 
9016:             IF loc_oBusca.this_lSelecionou
9017:                 IF USED("cursor_4c_Uni")
9018:                     IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
9019:                         loc_oPg.&par_cTxtCode..Value = ALLTRIM(cursor_4c_Uni.cunis)
9020:                     ENDIF
9021:                     IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
9022:                         loc_oPg.&par_cTxtDesc..Value = ALLTRIM(cursor_4c_Uni.dunis)
9023:                     ENDIF
9024:                 ENDIF
9025:             ELSE
9026:                 IF PEMSTATUS(loc_oPg, par_cTxtCode, 5)
9027:                     loc_oPg.&par_cTxtCode..Value = ""
9028:                 ENDIF
9029:                 IF PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
9030:                     loc_oPg.&par_cTxtDesc..Value = ""
9031:                 ENDIF
9032:             ENDIF
9033: 
9034:             IF USED("cursor_4c_Uni")
9035:                 USE IN cursor_4c_Uni
9036:             ENDIF
9037:             loc_oBusca.Release()
9038:         CATCH TO loc_oErro
9039:             MsgErro("Erro no lookup de unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupUnidade")
9040:         ENDTRY
9041:     ENDPROC
9042: 
9043:     *--------------------------------------------------------------------------
9044:     * TabPrincipal_CodacbsKeyPress - F4 no campo Acabamento abre lookup
9045:     *--------------------------------------------------------------------------
9046:     PROCEDURE TabPrincipal_CodacbsKeyPress
9047:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9048:         IF par_nKeyCode = 115
9049:             THIS.AbrirLookupAcabamento()
9050:         ENDIF
9051:     ENDPROC
9052: 
9053:     *--------------------------------------------------------------------------
9054:     * TabPrincipal_CodacbsLostFocus - LostFocus valida acabamento
9055:     *--------------------------------------------------------------------------
9056:     PROCEDURE TabPrincipal_CodacbsLostFocus()
9057:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9058:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9059:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9060:             RETURN
9061:         ENDIF
9062:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codacbs.Value)
9063: 
9064:         IF loc_cCod == THIS.this_cUltCodacbs
9065:             RETURN
9066:         ENDIF
9067:         THIS.this_cUltCodacbs = loc_cCod
9068: 
9069:         IF EMPTY(loc_cCod)
9070:             IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9071:                 loc_oPg.txt_4c_Dcodacbs.Value = ""
9072:             ENDIF
9073:             RETURN
9074:         ENDIF
9075: 
9076:         TRY
9077:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9078:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
9079:             ENDTEXT
9080:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
9081:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
9082:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9083:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
9084:                 ENDIF
9085:             ELSE
9086:                 THIS.AbrirLookupAcabamento()
9087:             ENDIF
9088:             IF USED("cursor_4c_VAcb")
9089:                 USE IN cursor_4c_VAcb
9090:             ENDIF
9091:         CATCH TO loc_oErro
9092:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9093:         ENDTRY
9094:     ENDPROC
9095: 
9096:     *--------------------------------------------------------------------------
9097:     * AbrirLookupAcabamento - Abre FormBuscaAuxiliar para selecionar acabamento
9098:     *--------------------------------------------------------------------------
9099:     PROTECTED PROCEDURE AbrirLookupAcabamento()
9100:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9101:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9102:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5), ALLTRIM(loc_oPg.txt_4c_Codacbs.Value), "")
9103: 
9104:         TRY
9105:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_Acb", "cods", loc_cVal, "Selecionar Acabamento")
9106:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
9107:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
9108:             loc_oBusca.Show()
9109: 
9110:             IF loc_oBusca.this_lSelecionou
9111:                 IF USED("cursor_4c_Acb")
9112:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9113:                         loc_oPg.txt_4c_Codacbs.Value  = ALLTRIM(cursor_4c_Acb.cods)
9114:                     ENDIF
9115:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9116:                         loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_Acb.descrs)
9117:                     ENDIF
9118:                 ENDIF
9119:             ELSE
9120:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codacbs", 5)
9121:                     loc_oPg.txt_4c_Codacbs.Value  = ""
9122:                 ENDIF
9123:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9124:                     loc_oPg.txt_4c_Dcodacbs.Value = ""
9125:                 ENDIF
9126:             ENDIF
9127: 
9128:             IF USED("cursor_4c_Acb")
9129:                 USE IN cursor_4c_Acb
9130:             ENDIF
9131:             loc_oBusca.Release()
9132:         CATCH TO loc_oErro
9133:             MsgErro("Erro no lookup de acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamento")
9134:         ENDTRY
9135:     ENDPROC
9136: 
9137:     *--------------------------------------------------------------------------
9138:     * TabPrincipal_CodcorsKeyPress - F4 no campo Cor abre lookup
9139:     *--------------------------------------------------------------------------
9140:     PROCEDURE TabPrincipal_CodcorsKeyPress
9141:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9142:         IF par_nKeyCode = 115
9143:             THIS.AbrirLookupCor()
9144:         ENDIF
9145:     ENDPROC
9146: 
9147:     *--------------------------------------------------------------------------
9148:     * TabPrincipal_CodcorsLostFocus - LostFocus valida cor
9149:     *--------------------------------------------------------------------------
9150:     PROCEDURE TabPrincipal_CodcorsLostFocus()
9151:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
9152:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9153:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9154:             RETURN
9155:         ENDIF
9156:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codcors.Value)
9157: 
9158:         IF loc_cCod == THIS.this_cUltCodcors
9159:             RETURN
9160:         ENDIF
9161:         THIS.this_cUltCodcors = loc_cCod
9162: 
9163:         IF EMPTY(loc_cCod)
9164:             RETURN
9165:         ENDIF
9166: 
9167:         TRY
9168:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9169:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9170:             ENDTEXT
9171:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9172:             IF loc_nR <= 0
9173:                 THIS.AbrirLookupCor()
9174:             ELSE
9175:                 IF EOF("cursor_4c_VCor")
9176:                     THIS.AbrirLookupCor()
9177:                 ENDIF
9178:             ENDIF
9179:             IF USED("cursor_4c_VCor")
9180:                 USE IN cursor_4c_VCor
9181:             ENDIF
9182:         CATCH TO loc_oErro
9183:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9184:         ENDTRY
9185:     ENDPROC
9186: 
9187:     *--------------------------------------------------------------------------
9188:     * AbrirLookupCor - Abre FormBuscaAuxiliar para selecionar cor
9189:     *--------------------------------------------------------------------------
9190:     PROTECTED PROCEDURE AbrirLookupCor()
9191:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9192:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9193:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5), ALLTRIM(loc_oPg.txt_4c_Codcors.Value), "")
9194: 
9195:         TRY
9196:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_Cor", "cods", loc_cVal, "Selecionar Cor")
9197:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
9198:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9199:             loc_oBusca.Show()
9200: 
9201:             IF loc_oBusca.this_lSelecionou
9202:                 IF USED("cursor_4c_Cor")
9203:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9204:                         loc_oPg.txt_4c_Codcors.Value = ALLTRIM(cursor_4c_Cor.cods)
9205:                     ENDIF
9206:                 ENDIF
9207:             ELSE
9208:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codcors", 5)
9209:                     loc_oPg.txt_4c_Codcors.Value = ""
9210:                 ENDIF
9211:             ENDIF
9212: 
9213:             IF USED("cursor_4c_Cor")
9214:                 USE IN cursor_4c_Cor
9215:             ENDIF
9216:             loc_oBusca.Release()
9217:         CATCH TO loc_oErro
9218:             MsgErro("Erro no lookup de cor:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCor")
9219:         ENDTRY
9220:     ENDPROC
9221: 
9222:     *--------------------------------------------------------------------------
9223:     * TabPrincipal_CodtamsKeyPress - F4 no campo Tamanho abre lookup
9224:     *--------------------------------------------------------------------------
9225:     PROCEDURE TabPrincipal_CodtamsKeyPress
9226:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9227:         IF par_nKeyCode = 115
9228:             THIS.AbrirLookupTamanho()
9229:         ENDIF
9230:     ENDPROC
9231: 
9232:     *--------------------------------------------------------------------------
9233:     * AbrirLookupTamanho - Abre FormBuscaAuxiliar para selecionar tamanho
9234:     *--------------------------------------------------------------------------
9235:     PROTECTED PROCEDURE AbrirLookupTamanho()
9236:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9237:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
9238:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5), ALLTRIM(loc_oPg.txt_4c_Codtams.Value), "")
9239: 
9240:         TRY
9241:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_Tam", "cods", loc_cVal, "Selecionar Tamanho")
9242:             loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
9243:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
9244:             loc_oBusca.Show()
9245: 
9246:             IF loc_oBusca.this_lSelecionou
9247:                 IF USED("cursor_4c_Tam")
9248:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9249:                         loc_oPg.txt_4c_Codtams.Value = ALLTRIM(cursor_4c_Tam.cods)
9250:                     ENDIF
9251:                 ENDIF
9252:             ELSE
9253:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codtams", 5)
9254:                     loc_oPg.txt_4c_Codtams.Value = ""
9255:                 ENDIF
9256:             ENDIF
9257: 
9258:             IF USED("cursor_4c_Tam")
9259:                 USE IN cursor_4c_Tam
9260:             ENDIF
9261:             loc_oBusca.Release()
9262:         CATCH TO loc_oErro
9263:             MsgErro("Erro no lookup de tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanho")
9264:         ENDTRY
9265:     ENDPROC
9266: 
9267:     *--------------------------------------------------------------------------
9268:     * CarregarDesc - Helper: carrega descricao de um campo lookup via SQL
9269:     * Retorna "" se nao encontrado ou valor vazio
9270:     *--------------------------------------------------------------------------
9271:     PROTECTED FUNCTION CarregarDesc(par_cTabela, par_cCampoChave, par_cValor, par_cCampoDesc)
9272:         LOCAL loc_cDesc, loc_cSQL, loc_nR, loc_cAliasField
9273:         loc_cDesc = ""
9274: 
9275:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9276:             TRY
9277:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9278:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9279:                 ENDTEXT
9280:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9281:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")

*-- Linhas 9297 a 9340:
9297:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9298:     * Tabela: SIGPRCPO JOIN SigCdPro
9299:     *--------------------------------------------------------------------------
9300:     PROTECTED PROCEDURE CarregarComposicao()
9301:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9302:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9303:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9304: 
9305:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9306:             RETURN
9307:         ENDIF
9308: 
9309:         TRY
9310:             *-- Composicao principal
9311:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9312:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9313:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9314:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9315:                 FROM SIGPRCPO c
9316:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9317:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9318:                 ORDER BY c.ordems
9319:             ENDTEXT
9320:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9321:             IF loc_nR > 0
9322:                 IF USED("cursor_4c_Compo")
9323:                     SELECT cursor_4c_Compo
9324:                     ZAP
9325:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9326:                 ENDIF
9327:                 IF USED("cursor_4c_CompoTmp")
9328:                     USE IN cursor_4c_CompoTmp
9329:                 ENDIF
9330:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9331:                     loc_oPg.grd_4c_Compo.Refresh()
9332:                 ENDIF
9333:             ENDIF
9334: 
9335:             *-- Sub-composicao
9336:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9337:                 SELECT sc.mats, m.dpros AS dcompos, sc.unicompos, sc.pcompos, sc.qtds,
9338:                        sc.totas, sc.moeds, sc.obscompos, sc.etiqs, sc.qtscons,
9339:                        sc.qtdcvs, sc.cunips, sc.ordems, sc.matsubs, sc.codtams
9340:                 FROM sigsubcp sc

*-- Linhas 9367 a 9410:
9367:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9368:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9369:     *--------------------------------------------------------------------------
9370:     PROTECTED PROCEDURE CarregarConsultaP()
9371:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9372:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9373:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9374: 
9375:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9376:             RETURN
9377:         ENDIF
9378: 
9379:         TRY
9380:             *-- Carregar componentes com descricao de fase e categoria
9381:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9382:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9383:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9384:                        c.ordems, c.qtscons, c.cats,
9385:                        ISNULL(cat.descs, '') AS dscgrp
9386:                 FROM SIGPRCPO c
9387:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9388:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9389:                 ORDER BY c.ordems, c.mats
9390:             ENDTEXT
9391:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9392:             IF loc_nR > 0
9393:                 IF USED("cursor_4c_Consulta")
9394:                     SELECT cursor_4c_Consulta
9395:                     ZAP
9396:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9397:                 ENDIF
9398:                 IF USED("cursor_4c_ConsultaTmp")
9399:                     USE IN cursor_4c_ConsultaTmp
9400:                 ENDIF
9401:                 *-- Atualizar contagem de componentes
9402:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9403:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9404:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9405:                 ENDIF
9406:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9407:                     loc_oPg.grd_4c_Consulta.Refresh()
9408:                 ENDIF
9409:             ENDIF
9410: 

*-- Linhas 9442 a 9485:
9442:     * CarregarCustos - Carrega grid de custo da composicao (Tab 3 - pgCusto)
9443:     * Tabela: SIGPRCPO filtrado por Tipos (tipo de calculo de custo)
9444:     *--------------------------------------------------------------------------
9445:     PROTECTED PROCEDURE CarregarCustos()
9446:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
9447:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9448:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
9449: 
9450:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9451:             RETURN
9452:         ENDIF
9453: 
9454:         TRY
9455:             *-- Obter tipo selecionado no combo (0=Todos, 1/2/3=tipo especifico)
9456:             loc_nTipo = 0
9457:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
9458:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1) - 1
9459:             ENDIF
9460: 
9461:             *-- Composicao de custo
9462:             IF loc_nTipo = 0
9463:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9464:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9465:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9466:                            c.qtdcvs, c.cunips
9467:                     FROM SIGPRCPO c
9468:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9469:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9470:                     AND c.tipos IS NOT NULL
9471:                     ORDER BY c.mats
9472:                 ENDTEXT
9473:             ELSE
9474:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9475:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9476:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9477:                            c.qtdcvs, c.cunips
9478:                     FROM SIGPRCPO c
9479:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9480:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9481:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9482:                     ORDER BY c.mats
9483:                 ENDTEXT
9484:             ENDIF
9485: 

*-- Linhas 9553 a 9596:
9553:     * CarregarFases - Carrega grid de fases (Tab 7)
9554:     * Tabela: SigCdPrf
9555:     *--------------------------------------------------------------------------
9556:     PROTECTED PROCEDURE CarregarFases()
9557:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_oBO
9558:         loc_oBO    = THIS.this_oBusinessObject
9559:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
9560:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9561: 
9562:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9563:             RETURN
9564:         ENDIF
9565: 
9566:         TRY
9567:             *-- Fases de producao
9568:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9569:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9570:                 FROM SigCdPrf
9571:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9572:                 ORDER BY ordems
9573:             ENDTEXT
9574:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9575:             IF loc_nR > 0
9576:                 IF USED("cursor_4c_Fases")
9577:                     SELECT cursor_4c_Fases
9578:                     ZAP
9579:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9580:                 ENDIF
9581:                 IF USED("cursor_4c_FasesTmp")
9582:                     USE IN cursor_4c_FasesTmp
9583:                 ENDIF
9584:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9585:                     loc_oPg.grd_4c_Fases.Refresh()
9586:                 ENDIF
9587:             ENDIF
9588: 
9589:             *-- Matrizes
9590:             THIS.CarregarMatrizes()
9591: 
9592:             *-- Preencher campos do BO nas textboxes da tab
9593:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9594:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs
9595:             ENDIF
9596:             IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)

*-- Linhas 9636 a 9679:
9636:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9637:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9638:     *--------------------------------------------------------------------------
9639:     PROTECTED PROCEDURE CarregarMatrizes()
9640:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9641:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9642:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9643: 
9644:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9645:             RETURN
9646:         ENDIF
9647: 
9648:         TRY
9649:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9650:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9651:                 FROM SigPrMtz a
9652:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9653:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9654:             ENDTEXT
9655:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9656:             IF loc_nR > 0
9657:                 IF USED("cursor_4c_Matrizes")
9658:                     SELECT cursor_4c_Matrizes
9659:                     ZAP
9660:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9661:                 ENDIF
9662:                 IF USED("cursor_4c_MatrizesTmp")
9663:                     USE IN cursor_4c_MatrizesTmp
9664:                 ENDIF
9665:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9666:                     loc_oPg.grd_4c_Matrizes.Refresh()
9667:                 ENDIF
9668:             ENDIF
9669: 
9670:         CATCH TO loc_oErro
9671:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9672:         ENDTRY
9673:     ENDPROC
9674: 
9675:     *--------------------------------------------------------------------------
9676:     * CarregarDescSgru - Carrega descricao do subgrupo (SigCdPsg com filtro grupo)
9677:     *--------------------------------------------------------------------------
9678:     PROTECTED FUNCTION CarregarDescSgru(par_cCgrus, par_cSgrus)
9679:         LOCAL loc_cDesc, loc_cSQL, loc_nR

*-- Linhas 9704 a 9866:
9704:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
9705:     * par_nPagina: 1=Lista, 2=Dados
9706:     *--------------------------------------------------------------------------
9707:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
9708:         LOCAL loc_lResultado
9709:         loc_lResultado = .F.
9710: 
9711:         TRY
9712:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
9713:                 loc_lResultado = .F.
9714:             ELSE
9715:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
9716: 
9717:                 IF par_nPagina = 1
9718:                     THIS.CarregarLista()
9719:                 ENDIF
9720: 
9721:                 loc_lResultado = .T.
9722:             ENDIF
9723: 
9724:         CATCH TO loc_oErro
9725:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormProduto.AlternarPagina")
9726:             loc_lResultado = .F.
9727:         ENDTRY
9728: 
9729:         RETURN loc_lResultado
9730:     ENDPROC
9731: 
9732:     *--------------------------------------------------------------------------
9733:     * TabFiscal_ClfiscalKeyPress - F4 no campo Classif. Fiscal abre lookup
9734:     *--------------------------------------------------------------------------
9735:     PROCEDURE TabFiscal_ClfiscalKeyPress
9736:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9737:         IF par_nKeyCode = 115
9738:             THIS.AbrirLookupClassFiscal()
9739:         ENDIF
9740:     ENDPROC
9741: 
9742:     *--------------------------------------------------------------------------
9743:     * AbrirLookupClassFiscal - Abre FormBuscaAuxiliar para Classif. Fiscal
9744:     * Tabela: SigCdClf | Chave: clfiscals | Desc: dclfiscals
9745:     *--------------------------------------------------------------------------
9746:     PROTECTED PROCEDURE AbrirLookupClassFiscal()
9747:         LOCAL loc_oBusca, loc_oPg, loc_cVal
9748:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9749:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5), ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "")
9750: 
9751:         TRY
9752:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_Clf", "clfiscals", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9753:             loc_oBusca.mAddColuna("clfiscals",  "", "C" + CHR(243) + "digo")
9754:             loc_oBusca.mAddColuna("dclfiscals", "", "Descri" + CHR(231) + CHR(227) + "o")
9755:             loc_oBusca.Show()
9756: 
9757:             IF loc_oBusca.this_lSelecionou
9758:                 IF USED("cursor_4c_Clf")
9759:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9760:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_Clf.clfiscals)
9761:                     ENDIF
9762:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9763:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_Clf.dclfiscals)
9764:                     ENDIF
9765:                 ENDIF
9766:             ELSE
9767:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9768:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9769:                 ENDIF
9770:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9771:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9772:                 ENDIF
9773:             ENDIF
9774: 
9775:             IF USED("cursor_4c_Clf")
9776:                 USE IN cursor_4c_Clf
9777:             ENDIF
9778:             loc_oBusca.Release()
9779:         CATCH TO loc_oErro
9780:             MsgErro("Erro no lookup de classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupClassFiscal")
9781:         ENDTRY
9782:     ENDPROC
9783: 
9784:     *--------------------------------------------------------------------------
9785:     * TabFiscal_MetalKeyPress - KeyPress no campo Metal (sem lookup auxiliar)
9786:     * Metal e Teor sao campos de classificacao IPI preenchidos manualmente
9787:     *--------------------------------------------------------------------------
9788:     PROCEDURE TabFiscal_MetalKeyPress
9789:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9790:         *-- Sem lookup: Metal e Teor sao codigos livres no contexto IPI
9791:     ENDPROC
9792: 
9793:     *--------------------------------------------------------------------------
9794:     * TabFiscal_TeorKeyPress - KeyPress no campo Teor (sem lookup auxiliar)
9795:     *--------------------------------------------------------------------------
9796:     PROCEDURE TabFiscal_TeorKeyPress
9797:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
9798:         *-- Sem lookup: Teor e codigo livre no contexto IPI
9799:     ENDPROC
9800: 
9801:     *--------------------------------------------------------------------------
9802:     * ValidarClfiscal - LostFocus no campo Classificacao Fiscal
9803:     * Tabela: SigCdClf | Chave: Codigos | Desc: Descricaos
9804:     * Ao selecionar, popula AliqIPI com aliqipis da classificacao
9805:     *--------------------------------------------------------------------------
9806:     PROCEDURE ValidarClfiscal()
9807:         LOCAL loc_oPg, loc_cVal
9808:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9809:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9810:             RETURN
9811:         ENDIF
9812:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
9813: 
9814:         IF loc_cVal == THIS.this_cUltimoValidarClfiscalValidado
9815:             RETURN
9816:         ENDIF
9817:         THIS.this_cUltimoValidarClfiscalValidado = loc_cVal
9818: 
9819:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltClassFiscal
9820:             RETURN
9821:         ENDIF
9822:         THIS.this_cUltClassFiscal = loc_cVal
9823: 
9824:         TRY
9825:             LOCAL loc_oBusca, loc_cSQL, loc_nR
9826:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfV", "Codigos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9827:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9828:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9829:             loc_oBusca.Show()
9830: 
9831:             IF loc_oBusca.this_lSelecionou
9832:                 IF USED("cursor_4c_ClfV")
9833:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9834:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfV.Codigos)
9835:                     ENDIF
9836:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9837:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfV.Descricaos)
9838:                     ENDIF
9839:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9840:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9841:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9842:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9843:                         ENDTEXT
9844:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9845:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9846:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9847:                         ENDIF
9848:                         IF USED("cursor_4c_ClfAliq")
9849:                             USE IN cursor_4c_ClfAliq
9850:                         ENDIF
9851:                     ENDIF
9852:                 ENDIF
9853:             ELSE
9854:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9855:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9856:                 ENDIF
9857:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9858:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9859:                 ENDIF
9860:                 THIS.this_cUltClassFiscal = ""
9861:             ENDIF
9862: 
9863:             IF USED("cursor_4c_ClfV")
9864:                 USE IN cursor_4c_ClfV
9865:             ENDIF
9866:             loc_oBusca.Release()

*-- Linhas 9877 a 10785:
9877:     * ValidarDclfiscal - LostFocus no campo Descricao Classificacao Fiscal
9878:     * Busca por descricao e preenche codigo
9879:     *--------------------------------------------------------------------------
9880:     PROCEDURE ValidarDclfiscal()
9881:         LOCAL loc_oPg, loc_cVal
9882:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9883:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9884:             RETURN
9885:         ENDIF
9886:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
9887: 
9888:         *-- So abre busca se o codigo estiver vazio (getDclfiscal.When logic)
9889:         IF EMPTY(loc_cVal)
9890:             RETURN
9891:         ENDIF
9892:         IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9893:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
9894:                 RETURN
9895:             ENDIF
9896:         ENDIF
9897:         IF loc_cVal == THIS.this_cUltimoValidarDclfiscalValidado
9898:             RETURN
9899:         ENDIF
9900:         THIS.this_cUltimoValidarDclfiscalValidado = loc_cVal
9901: 
9902:         TRY
9903:             LOCAL loc_oBusca
9904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", "cursor_4c_ClfD", "Descricaos", loc_cVal, "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
9905:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9906:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9907:             loc_oBusca.Show()
9908: 
9909:             IF loc_oBusca.this_lSelecionou
9910:                 IF USED("cursor_4c_ClfD")
9911:                     IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9912:                         loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_ClfD.Codigos)
9913:                     ENDIF
9914:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9915:                         loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfD.Descricaos)
9916:                     ENDIF
9917:                     THIS.this_cUltClassFiscal = ALLTRIM(cursor_4c_ClfD.Codigos)
9918:                 ENDIF
9919:             ELSE
9920:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9921:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9922:                 ENDIF
9923:             ENDIF
9924: 
9925:             IF USED("cursor_4c_ClfD")
9926:                 USE IN cursor_4c_ClfD
9927:             ENDIF
9928:             loc_oBusca.Release()
9929:         CATCH TO loc_oErro
9930:             MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o fiscal:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDclfiscal")
9931:         ENDTRY
9932:     ENDPROC
9933: 
9934:     *--------------------------------------------------------------------------
9935:     * ValidarOrigmerc - LostFocus no campo Origem Mercadoria
9936:     * Tabela: SigCdOrg | Chave: Codigos | Desc: Descricaos
9937:     *--------------------------------------------------------------------------
9938:     PROCEDURE ValidarOrigmerc()
9939:         LOCAL loc_oPg, loc_cVal
9940:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9941:         IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9942:             RETURN
9943:         ENDIF
9944:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
9945: 
9946:         IF loc_cVal == THIS.this_cUltimoValidarOrigmercValidado
9947:             RETURN
9948:         ENDIF
9949:         THIS.this_cUltimoValidarOrigmercValidado = loc_cVal
9950: 
9951:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltOrganizacao
9952:             RETURN
9953:         ENDIF
9954:         THIS.this_cUltOrganizacao = loc_cVal
9955: 
9956:         TRY
9957:             LOCAL loc_oBusca
9958:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_Org", "Codigos", loc_cVal, "Origem da Mercadoria")
9959:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
9960:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
9961:             loc_oBusca.Show()
9962: 
9963:             IF loc_oBusca.this_lSelecionou
9964:                 IF USED("cursor_4c_Org")
9965:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9966:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_Org.Codigos)
9967:                     ENDIF
9968:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9969:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_Org.Descricaos)
9970:                     ENDIF
9971:                 ENDIF
9972:             ELSE
9973:                 IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
9974:                     loc_oPg.txt_4c_Origmerc.Value  = ""
9975:                 ENDIF
9976:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9977:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
9978:                 ENDIF
9979:                 THIS.this_cUltOrganizacao = ""
9980:             ENDIF
9981: 
9982:             IF USED("cursor_4c_Org")
9983:                 USE IN cursor_4c_Org
9984:             ENDIF
9985:             loc_oBusca.Release()
9986:         CATCH TO loc_oErro
9987:             MsgErro("Erro ao validar origem da mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarOrigmerc")
9988:         ENDTRY
9989:     ENDPROC
9990: 
9991:     *--------------------------------------------------------------------------
9992:     * ValidarDorigmerc - LostFocus no campo Descricao Origem Mercadoria
9993:     * Busca por descricao, preenche codigo (so se codigo estiver vazio)
9994:     *--------------------------------------------------------------------------
9995:     PROCEDURE ValidarDorigmerc()
9996:         LOCAL loc_oPg, loc_cVal
9997:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9998:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
9999:             RETURN
10000:         ENDIF
10001:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
10002: 
10003:         IF EMPTY(loc_cVal)
10004:             RETURN
10005:         ENDIF
10006:         IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10007:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
10008:                 RETURN
10009:             ENDIF
10010:         ENDIF
10011:         IF loc_cVal == THIS.this_cUltimoValidarDorigmercValidado
10012:             RETURN
10013:         ENDIF
10014:         THIS.this_cUltimoValidarDorigmercValidado = loc_cVal
10015: 
10016:         TRY
10017:             LOCAL loc_oBusca
10018:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", "cursor_4c_OrgD", "Descricaos", loc_cVal, "Origem da Mercadoria")
10019:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10020:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10021:             loc_oBusca.Show()
10022: 
10023:             IF loc_oBusca.this_lSelecionou
10024:                 IF USED("cursor_4c_OrgD")
10025:                     IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
10026:                         loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_OrgD.Codigos)
10027:                     ENDIF
10028:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10029:                         loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgD.Descricaos)
10030:                     ENDIF
10031:                     THIS.this_cUltOrganizacao = ALLTRIM(cursor_4c_OrgD.Codigos)
10032:                 ENDIF
10033:             ELSE
10034:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
10035:                     loc_oPg.txt_4c_Dorigmerc.Value = ""
10036:                 ENDIF
10037:             ENDIF
10038: 
10039:             IF USED("cursor_4c_OrgD")
10040:                 USE IN cursor_4c_OrgD
10041:             ENDIF
10042:             loc_oBusca.Release()
10043:         CATCH TO loc_oErro
10044:             MsgErro("Erro ao buscar origem mercadoria:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDorigmerc")
10045:         ENDTRY
10046:     ENDPROC
10047: 
10048:     *--------------------------------------------------------------------------
10049:     * ValidarSittricms - LostFocus no campo Situacao Tributaria ICMS
10050:     * Tabela: SigCdIcm | Chave: Codigos | Desc: Descricaos
10051:     *--------------------------------------------------------------------------
10052:     PROCEDURE ValidarSittricms()
10053:         LOCAL loc_oPg, loc_cVal
10054:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10055:         IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10056:             RETURN
10057:         ENDIF
10058:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Sittricms.Value)
10059: 
10060:         IF loc_cVal == THIS.this_cUltimoValidarSittricmsValidado
10061:             RETURN
10062:         ENDIF
10063:         THIS.this_cUltimoValidarSittricmsValidado = loc_cVal
10064: 
10065:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10066:             RETURN
10067:         ENDIF
10068:         THIS.this_cUltIcm = loc_cVal
10069: 
10070:         TRY
10071:             LOCAL loc_oBusca
10072:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_Icm", "Codigos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10073:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10074:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10075:             loc_oBusca.Show()
10076: 
10077:             IF loc_oBusca.this_lSelecionou
10078:                 IF USED("cursor_4c_Icm")
10079:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10080:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_Icm.Codigos)
10081:                     ENDIF
10082:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10083:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_Icm.Descricaos)
10084:                     ENDIF
10085:                 ENDIF
10086:             ELSE
10087:                 IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10088:                     loc_oPg.txt_4c_Sittricms.Value  = ""
10089:                 ENDIF
10090:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10091:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10092:                 ENDIF
10093:                 THIS.this_cUltIcm = ""
10094:             ENDIF
10095: 
10096:             IF USED("cursor_4c_Icm")
10097:                 USE IN cursor_4c_Icm
10098:             ENDIF
10099:             loc_oBusca.Release()
10100:         CATCH TO loc_oErro
10101:             MsgErro("Erro ao validar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarSittricms")
10102:         ENDTRY
10103:     ENDPROC
10104: 
10105:     *--------------------------------------------------------------------------
10106:     * ValidarDsittricms - LostFocus no campo Descricao Situacao Tributaria ICMS
10107:     * Busca por descricao (so se codigo estiver vazio)
10108:     *--------------------------------------------------------------------------
10109:     PROCEDURE ValidarDsittricms()
10110:         LOCAL loc_oPg, loc_cVal
10111:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10112:         IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10113:             RETURN
10114:         ENDIF
10115:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Dsittricms.Value)
10116: 
10117:         IF EMPTY(loc_cVal)
10118:             RETURN
10119:         ENDIF
10120:         IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10121:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricms.Value))
10122:                 RETURN
10123:             ENDIF
10124:         ENDIF
10125:         IF loc_cVal == THIS.this_cUltimoValidarDsittricmsValidado
10126:             RETURN
10127:         ENDIF
10128:         THIS.this_cUltimoValidarDsittricmsValidado = loc_cVal
10129: 
10130:         TRY
10131:             LOCAL loc_oBusca
10132:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_IcmD", "Descricaos", loc_cVal, "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
10133:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10134:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10135:             loc_oBusca.Show()
10136: 
10137:             IF loc_oBusca.this_lSelecionou
10138:                 IF USED("cursor_4c_IcmD")
10139:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10140:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_IcmD.Codigos)
10141:                     ENDIF
10142:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10143:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_IcmD.Descricaos)
10144:                     ENDIF
10145:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_IcmD.Codigos)
10146:                 ENDIF
10147:             ELSE
10148:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10149:                     loc_oPg.txt_4c_Dsittricms.Value = ""
10150:                 ENDIF
10151:             ENDIF
10152: 
10153:             IF USED("cursor_4c_IcmD")
10154:                 USE IN cursor_4c_IcmD
10155:             ENDIF
10156:             loc_oBusca.Release()
10157:         CATCH TO loc_oErro
10158:             MsgErro("Erro ao buscar situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDsittricms")
10159:         ENDTRY
10160:     ENDPROC
10161: 
10162:     *--------------------------------------------------------------------------
10163:     * ValidarCodServs - LostFocus no campo Codigo de Servicos ICMS
10164:     * Tabela: SigCdIcm | tambem preenche getSittricm quando seleciona
10165:     *--------------------------------------------------------------------------
10166:     PROCEDURE ValidarCodServs()
10167:         LOCAL loc_oPg, loc_cVal
10168:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10169:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10170:             RETURN
10171:         ENDIF
10172:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_CodServs.Value)
10173: 
10174:         IF loc_cVal == THIS.this_cUltimoValidarCodServsValidado
10175:             RETURN
10176:         ENDIF
10177:         THIS.this_cUltimoValidarCodServsValidado = loc_cVal
10178: 
10179:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltIcm
10180:             RETURN
10181:         ENDIF
10182:         THIS.this_cUltIcm = loc_cVal
10183: 
10184:         TRY
10185:             LOCAL loc_oBusca
10186:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", "cursor_4c_CodServ", "Codigos", loc_cVal, "C" + CHR(243) + "digo Servi" + CHR(231) + "os ICMS")
10187:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
10188:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
10189:             loc_oBusca.Show()
10190: 
10191:             IF loc_oBusca.this_lSelecionou
10192:                 IF USED("cursor_4c_CodServ")
10193:                     IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10194:                         loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10195:                     ENDIF
10196:                     *-- Tambem preenche Sittricms (como no legado)
10197:                     IF PEMSTATUS(loc_oPg, "txt_4c_Sittricms", 5)
10198:                         loc_oPg.txt_4c_Sittricms.Value  = ALLTRIM(cursor_4c_CodServ.Codigos)
10199:                     ENDIF
10200:                     IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricms", 5)
10201:                         loc_oPg.txt_4c_Dsittricms.Value = ALLTRIM(cursor_4c_CodServ.Descricaos)
10202:                     ENDIF
10203:                     THIS.this_cUltIcm = ALLTRIM(cursor_4c_CodServ.Codigos)
10204:                 ENDIF
10205:             ELSE
10206:                 IF PEMSTATUS(loc_oPg, "txt_4c_CodServs", 5)
10207:                     loc_oPg.txt_4c_CodServs.Value = ""
10208:                 ENDIF
10209:             ENDIF
10210: 
10211:             IF USED("cursor_4c_CodServ")
10212:                 USE IN cursor_4c_CodServ
10213:             ENDIF
10214:             loc_oBusca.Release()
10215:         CATCH TO loc_oErro
10216:             MsgErro("Erro ao validar c" + CHR(243) + "digo de servi" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarCodServs")
10217:         ENDTRY
10218:     ENDPROC
10219: 
10220:     *--------------------------------------------------------------------------
10221:     * ValidarTptribs - LostFocus no campo Tipo de Tributacao
10222:     * Tabela: SigPrTri | Chave: Tipos | Desc: Descs
10223:     *--------------------------------------------------------------------------
10224:     PROCEDURE ValidarTptribs()
10225:         LOCAL loc_oPg, loc_cVal
10226:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10227:         IF !PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10228:             RETURN
10229:         ENDIF
10230:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Tptribs.Value)
10231: 
10232:         IF loc_cVal == THIS.this_cUltimoValidarTptribsValidado
10233:             RETURN
10234:         ENDIF
10235:         THIS.this_cUltimoValidarTptribsValidado = loc_cVal
10236: 
10237:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltTptribs
10238:             RETURN
10239:         ENDIF
10240:         THIS.this_cUltTptribs = loc_cVal
10241: 
10242:         TRY
10243:             LOCAL loc_oBusca
10244:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", "cursor_4c_TpTrib", "Tipos", loc_cVal, "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
10245:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
10246:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10247:             loc_oBusca.Show()
10248: 
10249:             IF loc_oBusca.this_lSelecionou
10250:                 IF USED("cursor_4c_TpTrib")
10251:                     IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10252:                         loc_oPg.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_TpTrib.Tipos)
10253:                     ENDIF
10254:                     THIS.this_cUltTptribs = ALLTRIM(cursor_4c_TpTrib.Tipos)
10255:                 ENDIF
10256:             ELSE
10257:                 IF PEMSTATUS(loc_oPg, "txt_4c_Tptribs", 5)
10258:                     loc_oPg.txt_4c_Tptribs.Value = ""
10259:                 ENDIF
10260:                 THIS.this_cUltTptribs = ""
10261:             ENDIF
10262: 
10263:             IF USED("cursor_4c_TpTrib")
10264:                 USE IN cursor_4c_TpTrib
10265:             ENDIF
10266:             loc_oBusca.Release()
10267:         CATCH TO loc_oErro
10268:             MsgErro("Erro ao validar tipo de tributa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarTptribs")
10269:         ENDTRY
10270:     ENDPROC
10271: 
10272:     *--------------------------------------------------------------------------
10273:     * ValidarIat - LostFocus no campo IAT
10274:     * Aceita apenas: 'A' (arredondamento), 'T' (truncamento) ou vazio
10275:     *--------------------------------------------------------------------------
10276:     PROCEDURE ValidarIat()
10277:         LOCAL loc_oPg, loc_cVal
10278:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10279:         IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10280:             RETURN
10281:         ENDIF
10282:         loc_cVal = UPPER(ALLTRIM(loc_oPg.txt_4c_Iat.Value))
10283: 
10284:         IF EMPTY(loc_cVal)
10285:             RETURN
10286:         ENDIF
10287: 
10288:         IF !INLIST(loc_cVal, "A", "T")
10289:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida. Digite [A] Arredondamento ou [T] Truncamento!", "IAT")
10290:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10291:                 loc_oPg.txt_4c_Iat.Value = ""
10292:             ENDIF
10293:         ELSE
10294:             IF PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
10295:                 loc_oPg.txt_4c_Iat.Value = loc_cVal
10296:             ENDIF
10297:         ENDIF
10298:     ENDPROC
10299: 
10300:     *--------------------------------------------------------------------------
10301:     * ValidarAliqIPI - LostFocus no campo Aliquota IPI
10302:     * Avisa se identica a aliquota da classificacao fiscal
10303:     *--------------------------------------------------------------------------
10304:     PROCEDURE ValidarAliqIPI()
10305:         LOCAL loc_oPg, loc_nVal, loc_cSQL, loc_nR, loc_nAliqClf
10306:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10307:         IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
10308:             RETURN
10309:         ENDIF
10310:         loc_nVal = loc_oPg.txt_4c_AliqIPI.Value
10311: 
10312:         IF loc_nVal = 0
10313:             RETURN
10314:         ENDIF
10315:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10316:             RETURN
10317:         ENDIF
10318:         IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
10319:             RETURN
10320:         ENDIF
10321: 
10322:         TRY
10323:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10324:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10325:             ENDTEXT
10326:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10327:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10328:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10329:                 IF loc_nVal = loc_nAliqClf
10330:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10331:                 ENDIF
10332:             ENDIF
10333:             IF USED("cursor_4c_ClfAliqV")
10334:                 USE IN cursor_4c_ClfAliqV
10335:             ENDIF
10336:         CATCH TO loc_oErro
10337:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10338:         ENDTRY
10339:         THIS.CarregarDadosFiscais()
10340:     ENDPROC
10341: 
10342:     *--------------------------------------------------------------------------
10343:     * ValidarMetal - LostFocus no campo Metal (codigo livre IPI)
10344:     *--------------------------------------------------------------------------
10345:     PROCEDURE ValidarMetal()
10346:         RETURN
10347:     ENDPROC
10348: 
10349:     *--------------------------------------------------------------------------
10350:     * ValidarTeor - LostFocus no campo Teor (codigo livre IPI)
10351:     *--------------------------------------------------------------------------
10352:     PROCEDURE ValidarTeor()
10353:         RETURN
10354:     ENDPROC
10355: 
10356:     *--------------------------------------------------------------------------
10357:     * ValidarMoedaEstimada - LostFocus no campo Moeda Valor Estimado
10358:     * Tabela: SigCdMoe | Chave: CMoes | Desc: DMoes
10359:     *--------------------------------------------------------------------------
10360:     PROCEDURE ValidarMoedaEstimada()
10361:         LOCAL loc_oPg, loc_cVal
10362:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10363:         IF !PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10364:             RETURN
10365:         ENDIF
10366:         loc_cVal = ALLTRIM(loc_oPg.txt_4c_Moedas.Value)
10367: 
10368:         IF loc_cVal == THIS.this_cUltimoValidarMoedaEstimadaValidado
10369:             RETURN
10370:         ENDIF
10371:         THIS.this_cUltimoValidarMoedaEstimadaValidado = loc_cVal
10372: 
10373:         IF EMPTY(loc_cVal) OR loc_cVal = THIS.this_cUltMoeda
10374:             RETURN
10375:         ENDIF
10376:         THIS.this_cUltMoeda = loc_cVal
10377: 
10378:         TRY
10379:             LOCAL loc_oBusca
10380:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", "cursor_4c_MoeEstim", "CMoes", loc_cVal, "Moeda")
10381:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
10382:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
10383:             loc_oBusca.Show()
10384: 
10385:             IF loc_oBusca.this_lSelecionou
10386:                 IF USED("cursor_4c_MoeEstim")
10387:                     IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10388:                         loc_oPg.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10389:                     ENDIF
10390:                     THIS.this_cUltMoeda = ALLTRIM(cursor_4c_MoeEstim.CMoes)
10391:                 ENDIF
10392:             ELSE
10393:                 IF PEMSTATUS(loc_oPg, "txt_4c_Moedas", 5)
10394:                     loc_oPg.txt_4c_Moedas.Value = ""
10395:                 ENDIF
10396:                 THIS.this_cUltMoeda = ""
10397:             ENDIF
10398: 
10399:             IF USED("cursor_4c_MoeEstim")
10400:                 USE IN cursor_4c_MoeEstim
10401:             ENDIF
10402:             loc_oBusca.Release()
10403:         CATCH TO loc_oErro
10404:             MsgErro("Erro ao validar moeda:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarMoedaEstimada")
10405:         ENDTRY
10406:     ENDPROC
10407: 
10408:     *--------------------------------------------------------------------------
10409:     * ValidarGruccus - LostFocus no campo Grupo Conta Corrente Custo
10410:     * Tabela: SigCdGcr | Chave: Codigos | Desc: Descrs
10411:     *--------------------------------------------------------------------------
10412:     PROCEDURE ValidarGruccus()
10413:         LOCAL loc_oPg, loc_cVal
10414:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10415:         IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10416:             RETURN
10417:         ENDIF
10418:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10419: 
10420:         IF loc_cVal == THIS.this_cUltimoValidarGruccusValidado
10421:             RETURN
10422:         ENDIF
10423:         THIS.this_cUltimoValidarGruccusValidado = loc_cVal
10424: 
10425:         IF EMPTY(loc_cVal)
10426:             IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10427:                 loc_oPg.txt_4c__dgruccus.Value  = ""
10428:             ENDIF
10429:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10430:                 loc_oPg.txt_4c__contaccus.Value = ""
10431:             ENDIF
10432:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10433:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10434:             ENDIF
10435:             THIS.this_cUltGrupoCC = ""
10436:             RETURN
10437:         ENDIF
10438: 
10439:         IF loc_cVal = THIS.this_cUltGrupoCC
10440:             RETURN
10441:         ENDIF
10442:         THIS.this_cUltGrupoCC = loc_cVal
10443: 
10444:         TRY
10445:             LOCAL loc_oBusca
10446:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_Gcr", "Codigos", loc_cVal, "Grupo Conta Corrente")
10447:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10448:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10449:             loc_oBusca.Show()
10450: 
10451:             IF loc_oBusca.this_lSelecionou
10452:                 IF USED("cursor_4c_Gcr")
10453:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10454:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_Gcr.Codigos)
10455:                     ENDIF
10456:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10457:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_Gcr.Descrs)
10458:                     ENDIF
10459:                 ENDIF
10460:             ELSE
10461:                 IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10462:                     loc_oPg.txt_4c__gruccus.Value  = ""
10463:                 ENDIF
10464:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10465:                     loc_oPg.txt_4c__dgruccus.Value = ""
10466:                 ENDIF
10467:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10468:                     loc_oPg.txt_4c__contaccus.Value = ""
10469:                 ENDIF
10470:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10471:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10472:                 ENDIF
10473:                 THIS.this_cUltGrupoCC = ""
10474:             ENDIF
10475: 
10476:             IF USED("cursor_4c_Gcr")
10477:                 USE IN cursor_4c_Gcr
10478:             ENDIF
10479:             loc_oBusca.Release()
10480:         CATCH TO loc_oErro
10481:             MsgErro("Erro ao validar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarGruccus")
10482:         ENDTRY
10483:     ENDPROC
10484: 
10485:     *--------------------------------------------------------------------------
10486:     * ValidarDgruccus - LostFocus na Descricao do Grupo Conta Corrente
10487:     * Busca por descricao (so se codigo estiver vazio)
10488:     *--------------------------------------------------------------------------
10489:     PROCEDURE ValidarDgruccus()
10490:         LOCAL loc_oPg, loc_cVal
10491:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10492:         IF !PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10493:             RETURN
10494:         ENDIF
10495:         loc_cVal = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
10496: 
10497:         IF EMPTY(loc_cVal)
10498:             RETURN
10499:         ENDIF
10500:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10501:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
10502:                 RETURN
10503:             ENDIF
10504:         ENDIF
10505:         IF loc_cVal == THIS.this_cUltimoValidarDgruccusValidado
10506:             RETURN
10507:         ENDIF
10508:         THIS.this_cUltimoValidarDgruccusValidado = loc_cVal
10509: 
10510:         TRY
10511:             LOCAL loc_oBusca
10512:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", "cursor_4c_GcrD", "Descrs", loc_cVal, "Grupo Conta Corrente")
10513:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10514:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10515:             loc_oBusca.Show()
10516: 
10517:             IF loc_oBusca.this_lSelecionou
10518:                 IF USED("cursor_4c_GcrD")
10519:                     IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10520:                         loc_oPg.txt_4c__gruccus.Value  = ALLTRIM(cursor_4c_GcrD.Codigos)
10521:                     ENDIF
10522:                     IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10523:                         loc_oPg.txt_4c__dgruccus.Value = ALLTRIM(cursor_4c_GcrD.Descrs)
10524:                     ENDIF
10525:                     THIS.this_cUltGrupoCC = ALLTRIM(cursor_4c_GcrD.Codigos)
10526:                 ENDIF
10527:             ELSE
10528:                 IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
10529:                     loc_oPg.txt_4c__dgruccus.Value = ""
10530:                 ENDIF
10531:             ENDIF
10532: 
10533:             IF USED("cursor_4c_GcrD")
10534:                 USE IN cursor_4c_GcrD
10535:             ENDIF
10536:             loc_oBusca.Release()
10537:         CATCH TO loc_oErro
10538:             MsgErro("Erro ao buscar grupo conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDgruccus")
10539:         ENDTRY
10540:     ENDPROC
10541: 
10542:     *--------------------------------------------------------------------------
10543:     * ValidarContaccus - LostFocus no campo Conta Corrente Custo
10544:     * Tabela: SigCdCli | Chave: IClis | Desc: Rclis
10545:     * So acessivel quando grupo gruccus preenchido
10546:     *--------------------------------------------------------------------------
10547:     PROCEDURE ValidarContaccus()
10548:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10549:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10550:         IF !PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10551:             RETURN
10552:         ENDIF
10553:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
10554:         loc_cGrupo = ""
10555:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10556:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10557:         ENDIF
10558: 
10559:         IF loc_cVal == THIS.this_cUltimoValidarContaccusValidado
10560:             RETURN
10561:         ENDIF
10562:         THIS.this_cUltimoValidarContaccusValidado = loc_cVal
10563: 
10564:         *-- Grupo obrigatorio para acessar conta
10565:         IF EMPTY(loc_cGrupo)
10566:             IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10567:                 loc_oPg.txt_4c__contaccus.Value = ""
10568:             ENDIF
10569:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10570:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10571:             ENDIF
10572:             RETURN
10573:         ENDIF
10574: 
10575:         IF EMPTY(loc_cVal)
10576:             IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10577:                 loc_oPg.txt_4c__dcontaccus.Value = ""
10578:             ENDIF
10579:             THIS.this_cUltContaCC = ""
10580:             RETURN
10581:         ENDIF
10582: 
10583:         IF loc_cVal = THIS.this_cUltContaCC
10584:             RETURN
10585:         ENDIF
10586:         THIS.this_cUltContaCC = loc_cVal
10587: 
10588:         TRY
10589:             LOCAL loc_oBusca
10590:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCC", "IClis", loc_cVal, "Conta Corrente")
10591:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10592:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10593:             loc_oBusca.Show()
10594: 
10595:             IF loc_oBusca.this_lSelecionou
10596:                 IF USED("cursor_4c_ContaCC")
10597:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10598:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCC.IClis)
10599:                     ENDIF
10600:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10601:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCC.Rclis)
10602:                     ENDIF
10603:                 ENDIF
10604:             ELSE
10605:                 IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10606:                     loc_oPg.txt_4c__contaccus.Value  = ""
10607:                 ENDIF
10608:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10609:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10610:                 ENDIF
10611:                 THIS.this_cUltContaCC = ""
10612:             ENDIF
10613: 
10614:             IF USED("cursor_4c_ContaCC")
10615:                 USE IN cursor_4c_ContaCC
10616:             ENDIF
10617:             loc_oBusca.Release()
10618:         CATCH TO loc_oErro
10619:             MsgErro("Erro ao validar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarContaccus")
10620:         ENDTRY
10621:     ENDPROC
10622: 
10623:     *--------------------------------------------------------------------------
10624:     * ValidarDcontaccus - LostFocus na Descricao Conta Corrente
10625:     * Busca por nome (so se codigo estiver vazio e grupo preenchido)
10626:     *--------------------------------------------------------------------------
10627:     PROCEDURE ValidarDcontaccus()
10628:         LOCAL loc_oPg, loc_cVal, loc_cGrupo
10629:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10630:         IF !PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10631:             RETURN
10632:         ENDIF
10633:         loc_cVal   = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
10634:         loc_cGrupo = ""
10635:         IF PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
10636:             loc_cGrupo = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
10637:         ENDIF
10638: 
10639:         IF EMPTY(loc_cVal) OR EMPTY(loc_cGrupo)
10640:             RETURN
10641:         ENDIF
10642:         IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10643:             IF !EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
10644:                 RETURN
10645:             ENDIF
10646:         ENDIF
10647:         IF loc_cVal == THIS.this_cUltimoValidarDcontaccusValidado
10648:             RETURN
10649:         ENDIF
10650:         THIS.this_cUltimoValidarDcontaccusValidado = loc_cVal
10651: 
10652:         TRY
10653:             LOCAL loc_oBusca
10654:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_ContaCCD", "Rclis", loc_cVal, "Conta Corrente")
10655:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10656:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10657:             loc_oBusca.Show()
10658: 
10659:             IF loc_oBusca.this_lSelecionou
10660:                 IF USED("cursor_4c_ContaCCD")
10661:                     IF PEMSTATUS(loc_oPg, "txt_4c__contaccus", 5)
10662:                         loc_oPg.txt_4c__contaccus.Value  = ALLTRIM(cursor_4c_ContaCCD.IClis)
10663:                     ENDIF
10664:                     IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10665:                         loc_oPg.txt_4c__dcontaccus.Value = ALLTRIM(cursor_4c_ContaCCD.Rclis)
10666:                     ENDIF
10667:                     THIS.this_cUltContaCC = ALLTRIM(cursor_4c_ContaCCD.IClis)
10668:                 ENDIF
10669:             ELSE
10670:                 IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
10671:                     loc_oPg.txt_4c__dcontaccus.Value = ""
10672:                 ENDIF
10673:             ENDIF
10674: 
10675:             IF USED("cursor_4c_ContaCCD")
10676:                 USE IN cursor_4c_ContaCCD
10677:             ENDIF
10678:             loc_oBusca.Release()
10679:         CATCH TO loc_oErro
10680:             MsgErro("Erro ao buscar conta corrente:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarDcontaccus")
10681:         ENDTRY
10682:     ENDPROC
10683: 
10684:     *--------------------------------------------------------------------------
10685:     * TabFiscal_ExtIpiGotFocus - GotFocus no campo Excecao da TIPI
10686:     * Verifica se campo deve estar habilitado (IpiProds = 'S' em SigCdClf)
10687:     *--------------------------------------------------------------------------
10688:     PROCEDURE TabFiscal_ExtIpiGotFocus()
10689:         LOCAL loc_oPg, loc_cClf, loc_cSQL, loc_nR, loc_lHabilitar
10690:         loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10691:         loc_lHabilitar = .F.
10692: 
10693:         IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
10694:             RETURN
10695:         ENDIF
10696:         loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
10697: 
10698:         IF EMPTY(loc_cClf)
10699:             RETURN
10700:         ENDIF
10701: 
10702:         TRY
10703:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10704:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10705:             ENDTEXT
10706:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10707:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10708:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10709:             ENDIF
10710:             IF USED("cursor_4c_ClfIpi")
10711:                 USE IN cursor_4c_ClfIpi
10712:             ENDIF
10713:         CATCH TO loc_oErro
10714:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10715:         ENDTRY
10716: 
10717:         IF !loc_lHabilitar
10718:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10719:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10720:             ENDIF
10721:         ENDIF
10722:     ENDPROC
10723: 
10724:     *--------------------------------------------------------------------------
10725:     * BtnDescFisClick - Gerar Descricao Fiscal automaticamente
10726:     * Equivalente ao legacy fGerDescFis - stub funcional
10727:     *--------------------------------------------------------------------------
10728:     PROCEDURE BtnDescFisClick()
10729:         LOCAL loc_oPg, loc_cCpros
10730:         loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10731:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10732: 
10733:         IF EMPTY(loc_cCpros)
10734:             MsgAviso("Selecione um produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10735:             RETURN
10736:         ENDIF
10737: 
10738:         MsgAviso("Funcionalidade de gera" + CHR(231) + CHR(227) + "o autom" + CHR(225) + "tica de descri" + CHR(231) + CHR(227) + "o fiscal n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o." + CHR(13) + "Edite a descri" + CHR(231) + CHR(227) + "o fiscal diretamente no campo.", "Descri" + CHR(231) + CHR(227) + "o Fiscal")
10739:     ENDPROC
10740: 
10741:     *--------------------------------------------------------------------------
10742:     * CarregarDadosFiscais - Carrega grid CMV (custos gramas) da aba Fiscal
10743:     * Tabela: SigCdCmv | Colunas: Datas, ValCuss, Moedas
10744:     *--------------------------------------------------------------------------
10745:     PROTECTED PROCEDURE CarregarDadosFiscais()
10746:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10747:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10748:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10749: 
10750:         IF EMPTY(loc_cCpros)
10751:             IF USED("cursor_4c_Cmv")
10752:                 ZAP IN cursor_4c_Cmv
10753:             ENDIF
10754:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10755:                 loc_oPg.grd_4c_Cmv.Refresh()
10756:             ENDIF
10757:             RETURN
10758:         ENDIF
10759: 
10760:         TRY
10761:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10762:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10763:                 FROM SigCdCmv
10764:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10765:                 ORDER BY Datas DESC
10766:             ENDTEXT
10767: 
10768:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10769: 
10770:             IF USED("cursor_4c_Cmv")
10771:                 ZAP IN cursor_4c_Cmv
10772:             ENDIF
10773: 
10774:             IF loc_nR > 0
10775:                 IF !USED("cursor_4c_Cmv")
10776:                     SET NULL ON
10777:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10778:                     SET NULL OFF
10779:                 ENDIF
10780:                 IF USED("cursor_4c_CmvTemp")
10781:                     SELECT cursor_4c_Cmv
10782:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10783:                 ENDIF
10784:             ENDIF
10785: 

*-- Linhas 10805 a 11000:
10805:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10806:     * Tabela: sigprtar (cpros, dtinis, usuars)
10807:     *--------------------------------------------------------------------------
10808:     PROCEDURE BtnIniTarefaClick()
10809:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10810:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10811: 
10812:         IF EMPTY(loc_cCpros)
10813:             MsgAviso("Selecione um produto antes de iniciar tarefa.", "Tarefa Designer")
10814:             RETURN
10815:         ENDIF
10816: 
10817:         TRY
10818:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10819:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10820:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10821:             ENDTEXT
10822:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10823:             IF loc_nR > 0
10824:                 THIS.CarregarDesigner()
10825:             ELSE
10826:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10827:             ENDIF
10828:         CATCH TO loc_oErro
10829:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10830:         ENDTRY
10831:     ENDPROC
10832: 
10833:     *--------------------------------------------------------------------------
10834:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10835:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10836:     *--------------------------------------------------------------------------
10837:     PROCEDURE BtnFimTarefaClick()
10838:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10839:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10840: 
10841:         IF EMPTY(loc_cCpros)
10842:             MsgAviso("Selecione um produto antes de finalizar tarefa.", "Tarefa Designer")
10843:             RETURN
10844:         ENDIF
10845: 
10846:         TRY
10847:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10848:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10849:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10850:             ENDTEXT
10851:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10852:             IF loc_nR > 0
10853:                 THIS.CarregarDesigner()
10854:             ELSE
10855:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10856:             ENDIF
10857:         CATCH TO loc_oErro
10858:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10859:         ENDTRY
10860:     ENDPROC
10861: 
10862:     *--------------------------------------------------------------------------
10863:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10864:     * Tabela: sigprarq (cpros, arquivos)
10865:     *--------------------------------------------------------------------------
10866:     PROCEDURE BtnInsArqsClick()
10867:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10868:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10869: 
10870:         IF EMPTY(loc_cCpros)
10871:             MsgAviso("Selecione um produto para inserir arquivo.", "Arquivos Designer")
10872:             RETURN
10873:         ENDIF
10874: 
10875:         loc_cArquivo = GETFILE("*.*", "Selecionar Arquivo para Designer")
10876:         IF EMPTY(loc_cArquivo)
10877:             RETURN
10878:         ENDIF
10879: 
10880:         TRY
10881:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10882:                 INSERT INTO sigprarq (cpros, arquivos)
10883:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10884:             ENDTEXT
10885:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10886:             IF loc_nR > 0
10887:                 THIS.CarregarDesigner()
10888:             ELSE
10889:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10890:             ENDIF
10891:         CATCH TO loc_oErro
10892:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10893:         ENDTRY
10894:     ENDPROC
10895: 
10896:     *--------------------------------------------------------------------------
10897:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10898:     *--------------------------------------------------------------------------
10899:     PROCEDURE BtnExcArqsClick()
10900:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR
10901:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10902: 
10903:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10904:             MsgAviso("Selecione um arquivo para excluir.", "Arquivos Designer")
10905:             RETURN
10906:         ENDIF
10907: 
10908:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10909: 
10910:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10911:             TRY
10912:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10913:                     DELETE FROM sigprarq
10914:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10915:                 ENDTEXT
10916:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10917:                 IF loc_nR > 0
10918:                     THIS.CarregarDesigner()
10919:                 ELSE
10920:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10921:                 ENDIF
10922:             CATCH TO loc_oErro
10923:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10924:             ENDTRY
10925:         ENDIF
10926:     ENDPROC
10927: 
10928:     *--------------------------------------------------------------------------
10929:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10930:     *--------------------------------------------------------------------------
10931:     PROCEDURE BtnOpnArqsClick()
10932:         LOCAL loc_cArquivo
10933: 
10934:         IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
10935:             MsgAviso("Selecione um arquivo para abrir.", "Arquivos Designer")
10936:             RETURN
10937:         ENDIF
10938: 
10939:         loc_cArquivo = ALLTRIM(cursor_4c_Arquivos.arquivos)
10940: 
10941:         IF EMPTY(loc_cArquivo)
10942:             MsgAviso("Caminho do arquivo n" + CHR(227) + "o informado.", "Arquivos Designer")
10943:             RETURN
10944:         ENDIF
10945: 
10946:         TRY
10947:             DECLARE INTEGER ShellExecute IN "Shell32.dll" ;
10948:                 INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
10949:                 STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
10950:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
10951:         CATCH TO loc_oErro
10952:             MsgErro("Erro ao abrir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnOpnArqsClick")
10953:         ENDTRY
10954:     ENDPROC
10955: 
10956:     *--------------------------------------------------------------------------
10957:     * CarregarDesigner - Carrega grids de tarefas e arquivos do Designer (Tab 5)
10958:     * Tabelas: sigprtar (tarefas), sigprarq (arquivos)
10959:     *--------------------------------------------------------------------------
10960:     PROTECTED PROCEDURE CarregarDesigner()
10961:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
10962:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
10963:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
10964: 
10965:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
10966:             RETURN
10967:         ENDIF
10968: 
10969:         TRY
10970:             *-- Tarefas do Designer
10971:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10972:                 SELECT dtinis, dtfims, usuars, tarefas
10973:                 FROM sigprtar
10974:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10975:                 ORDER BY dtinis DESC
10976:             ENDTEXT
10977:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10978:             IF loc_nR > 0
10979:                 IF USED("cursor_4c_Designer")
10980:                     SELECT cursor_4c_Designer
10981:                     ZAP
10982:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10983:                 ENDIF
10984:                 IF USED("cursor_4c_DesignerTmp")
10985:                     USE IN cursor_4c_DesignerTmp
10986:                 ENDIF
10987:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10988:                     loc_oPg.grd_4c_Designer.Refresh()
10989:                 ENDIF
10990:             ENDIF
10991: 
10992:             *-- Arquivos do Designer
10993:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10994:                 SELECT arquivos FROM sigprarq
10995:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10996:                 ORDER BY arquivos
10997:             ENDTEXT
10998:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10999:             IF loc_nR > 0
11000:                 IF USED("cursor_4c_Arquivos")

*-- Linhas 11039 a 12185:
11039:     * Salvar: habilitado apenas em INCLUIR e ALTERAR
11040:     * Cancelar: sempre habilitado em Page2
11041:     *--------------------------------------------------------------------------
11042:     PROCEDURE AjustarBotoesPorModo()
11043:         LOCAL loc_oBotoesDados, loc_lEmEdicao
11044:         loc_oBotoesDados = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
11045:         loc_lEmEdicao    = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11046: 
11047:         TRY
11048:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Salvar", 5)
11049:                 loc_oBotoesDados.cmd_4c_Salvar.Enabled = loc_lEmEdicao
11050:             ENDIF
11051:             IF PEMSTATUS(loc_oBotoesDados, "cmd_4c_Cancelar", 5)
11052:                 loc_oBotoesDados.cmd_4c_Cancelar.Enabled = .T.
11053:             ENDIF
11054:         CATCH TO loc_oErro
11055:             MsgErro(loc_oErro.Message, "FormProduto.AjustarBotoesPorModo")
11056:         ENDTRY
11057:     ENDPROC
11058: 
11059:     *--------------------------------------------------------------------------
11060:     * CompoGrd_AfterRowColChange - Grid composicao: ao mover linha/coluna
11061:     * Atualiza campos Get_Desc e getObsOFs com dados da linha atual
11062:     *--------------------------------------------------------------------------
11063:     PROCEDURE CompoGrd_AfterRowColChange(par_nColIndex)
11064:         LOCAL loc_oPg
11065:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11066: 
11067:         TRY
11068:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
11069:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11070:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(NVL(cursor_4c_Compo.dcompos, ""))
11071:                 ENDIF
11072:             ENDIF
11073:         CATCH TO loc_oErro
11074:             MsgErro(loc_oErro.Message, "FormProduto.CompoGrd_AfterRowColChange")
11075:         ENDTRY
11076:     ENDPROC
11077: 
11078:     *--------------------------------------------------------------------------
11079:     * SubCompoGrd_AfterRowColChange - Grid sub-componente: ao mover linha
11080:     * Atualiza campos get_desccp e get_matsub com dados da linha atual
11081:     *--------------------------------------------------------------------------
11082:     PROCEDURE SubCompoGrd_AfterRowColChange(par_nColIndex)
11083:         LOCAL loc_oPg
11084:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11085: 
11086:         TRY
11087:             IF USED("cursor_4c_SubCompo") AND !EOF("cursor_4c_SubCompo")
11088:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11089:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(NVL(cursor_4c_SubCompo.dcompos, ""))
11090:                 ENDIF
11091:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11092:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(NVL(cursor_4c_SubCompo.matsubs, ""))
11093:                 ENDIF
11094:             ENDIF
11095:         CATCH TO loc_oErro
11096:             MsgErro(loc_oErro.Message, "FormProduto.SubCompoGrd_AfterRowColChange")
11097:         ENDTRY
11098:     ENDPROC
11099: 
11100:     *--------------------------------------------------------------------------
11101:     * ChkLiberaCustoClick - Checkbox liberar custo: habilita/desabilita campos
11102:     *--------------------------------------------------------------------------
11103:     PROCEDURE ChkLiberaCustoClick()
11104:         LOCAL loc_oPg, loc_lLibera
11105:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11106:         loc_lLibera = .F.
11107: 
11108:         TRY
11109:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaCusto", 5)
11110:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1)
11111:             ENDIF
11112:             IF PEMSTATUS(loc_oPg, "txt_4c_Pcus", 5)
11113:                 loc_oPg.txt_4c_Pcus.ReadOnly     = !loc_lLibera
11114:             ENDIF
11115:             IF PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11116:                 loc_oPg.txt_4c_PcusMoe.ReadOnly  = !loc_lLibera
11117:             ENDIF
11118:             IF PEMSTATUS(loc_oPg, "txt_4c_Fcusto", 5)
11119:                 loc_oPg.txt_4c_Fcusto.ReadOnly   = !loc_lLibera
11120:             ENDIF
11121:             IF PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11122:                 loc_oPg.txt_4c_Cmkpc.ReadOnly    = !loc_lLibera
11123:             ENDIF
11124:         CATCH TO loc_oErro
11125:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaCustoClick")
11126:         ENDTRY
11127:     ENDPROC
11128: 
11129:     *--------------------------------------------------------------------------
11130:     * ChkLiberaVendaClick - Checkbox liberar venda: habilita/desabilita campos
11131:     *--------------------------------------------------------------------------
11132:     PROCEDURE ChkLiberaVendaClick()
11133:         LOCAL loc_oPg, loc_lLibera
11134:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11135:         loc_lLibera = .F.
11136: 
11137:         TRY
11138:             IF PEMSTATUS(loc_oPg, "chk_4c_ChkLiberaVenda", 5)
11139:                 loc_lLibera = (loc_oPg.chk_4c_ChkLiberaVenda.Value = 1)
11140:             ENDIF
11141:             IF PEMSTATUS(loc_oPg, "txt_4c_Margem", 5)
11142:                 loc_oPg.txt_4c_Margem.ReadOnly   = !loc_lLibera
11143:             ENDIF
11144:             IF PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11145:                 loc_oPg.txt_4c_Moeda.ReadOnly    = !loc_lLibera
11146:             ENDIF
11147:             IF PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11148:                 loc_oPg.txt_4c_Ftio.ReadOnly     = !loc_lLibera
11149:             ENDIF
11150:             IF PEMSTATUS(loc_oPg, "txt_4c_Fvenda", 5)
11151:                 loc_oPg.txt_4c_Fvenda.ReadOnly   = !loc_lLibera
11152:             ENDIF
11153:             IF PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11154:                 loc_oPg.txt_4c_Moepv.ReadOnly    = !loc_lLibera
11155:             ENDIF
11156:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11157:                 loc_oPg.txt_4c_Moev.ReadOnly     = !loc_lLibera
11158:             ENDIF
11159:         CATCH TO loc_oErro
11160:             MsgErro(loc_oErro.Message, "FormProduto.ChkLiberaVendaClick")
11161:         ENDTRY
11162:     ENDPROC
11163: 
11164:     *--------------------------------------------------------------------------
11165:     * ChkPvendaClick - Checkbox usar preco ideal: aplica preco ideal ao preco venda
11166:     *--------------------------------------------------------------------------
11167:     PROCEDURE ChkPvendaClick()
11168:         LOCAL loc_oPg, loc_nPvideal, loc_nEncarg
11169:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11170: 
11171:         TRY
11172:             IF PEMSTATUS(loc_oPg, "txt_4c_Pvideal", 5)
11173:                 loc_nPvideal = loc_oPg.txt_4c_Pvideal.Value
11174:             ELSE
11175:                 loc_nPvideal = 0
11176:             ENDIF
11177:             IF PEMSTATUS(loc_oPg, "txt_4c_Encarg", 5)
11178:                 loc_nEncarg = loc_oPg.txt_4c_Encarg.Value
11179:             ELSE
11180:                 loc_nEncarg = 1
11181:             ENDIF
11182:             IF loc_nEncarg = 0
11183:                 loc_nEncarg = 1
11184:             ENDIF
11185:             IF PEMSTATUS(loc_oPg, "txt_4c_Pven", 5)
11186:                 loc_oPg.txt_4c_Pven.Value = loc_nPvideal / loc_nEncarg
11187:             ENDIF
11188:             IF PEMSTATUS(loc_oPg, "txt_4c_Moev", 5) AND PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11189:                 loc_oPg.txt_4c_Moev.Value = loc_oPg.txt_4c_Moeda.Value
11190:             ENDIF
11191:         CATCH TO loc_oErro
11192:             MsgErro(loc_oErro.Message, "FormProduto.ChkPvendaClick")
11193:         ENDTRY
11194:     ENDPROC
11195: 
11196:     *--------------------------------------------------------------------------
11197:     * TabCompo_MoecLostFocus - LostFocus de txt_4c_PcusMoe (getMoec)
11198:     * Valida codigo de moeda de custo - lookup em SigCdMoe
11199:     *--------------------------------------------------------------------------
11200:     PROCEDURE TabCompo_MoecLostFocus()
11201:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11202:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11203:         loc_lResultado = .T.
11204: 
11205:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11206:             RETURN
11207:         ENDIF
11208: 
11209:         TRY
11210:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_PcusMoe", 5)
11211:                 RETURN
11212:             ENDIF
11213:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_PcusMoe.Value)
11214:             IF EMPTY(loc_cCod)
11215:                 RETURN
11216:             ENDIF
11217:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoecLostFocusValidado
11218:                 RETURN
11219:             ENDIF
11220:             THIS.this_cUltimoTabCompo_MoecLostFocusValidado = loc_cCod
11221: 
11222:             gb_4c_ValidandoUI = .T.
11223:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11224:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11225:             gb_4c_ValidandoUI = .F.
11226: 
11227:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11228:                 *-- Nao encontrou: abre lookup
11229:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11230:                 loc_oForm.Caption = "Moedas"
11231:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11232:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11233:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11234:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11235:                 loc_oForm.Show()
11236:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11237:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11238:                     USE IN cursor_4c_BuscaAux
11239:                 ELSE
11240:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11241:                 ENDIF
11242:                 loc_oForm.Release()
11243:             ENDIF
11244:             IF USED("cursor_4c_MoecTmp")
11245:                 USE IN cursor_4c_MoecTmp
11246:             ENDIF
11247:         CATCH TO loc_oErro
11248:             gb_4c_ValidandoUI = .F.
11249:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")
11250:         ENDTRY
11251:     ENDPROC
11252: 
11253:     *--------------------------------------------------------------------------
11254:     * TabCompo_MoecusfLostFocus - LostFocus de txt_4c_MoecusFoe (getMoecusf)
11255:     * Valida codigo de moeda de custo com feitio - lookup em SigCdMoe
11256:     *--------------------------------------------------------------------------
11257:     PROCEDURE TabCompo_MoecusfLostFocus()
11258:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11259:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11260: 
11261:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11262:             RETURN
11263:         ENDIF
11264: 
11265:         TRY
11266:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MoecusFoe", 5)
11267:                 RETURN
11268:             ENDIF
11269:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MoecusFoe.Value)
11270:             IF EMPTY(loc_cCod)
11271:                 RETURN
11272:             ENDIF
11273:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado
11274:                 RETURN
11275:             ENDIF
11276:             THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado = loc_cCod
11277: 
11278:             gb_4c_ValidandoUI = .T.
11279:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11280:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11281:             gb_4c_ValidandoUI = .F.
11282: 
11283:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11284:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11285:                 loc_oForm.Caption = "Moedas"
11286:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11287:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11288:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11289:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11290:                 loc_oForm.Show()
11291:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11292:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11293:                     USE IN cursor_4c_BuscaAux
11294:                 ELSE
11295:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11296:                 ENDIF
11297:                 loc_oForm.Release()
11298:             ENDIF
11299:             IF USED("cursor_4c_MoecusfTmp")
11300:                 USE IN cursor_4c_MoecusfTmp
11301:             ENDIF
11302:         CATCH TO loc_oErro
11303:             gb_4c_ValidandoUI = .F.
11304:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")
11305:         ENDTRY
11306:     ENDPROC
11307: 
11308:     *--------------------------------------------------------------------------
11309:     * TabCompo_MoedaLostFocus - LostFocus de txt_4c_Moeda (getMoeda)
11310:     * Valida moeda de venda - lookup em SigCdMoe
11311:     *--------------------------------------------------------------------------
11312:     PROCEDURE TabCompo_MoedaLostFocus()
11313:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11314:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11315: 
11316:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11317:             RETURN
11318:         ENDIF
11319: 
11320:         TRY
11321:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
11322:                 RETURN
11323:             ENDIF
11324:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
11325:             IF EMPTY(loc_cCod)
11326:                 RETURN
11327:             ENDIF
11328:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoedaLostFocusValidado
11329:                 RETURN
11330:             ENDIF
11331:             THIS.this_cUltimoTabCompo_MoedaLostFocusValidado = loc_cCod
11332: 
11333:             gb_4c_ValidandoUI = .T.
11334:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11335:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11336:             gb_4c_ValidandoUI = .F.
11337: 
11338:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11339:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11340:                 loc_oForm.Caption = "Moedas"
11341:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11342:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11343:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11344:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11345:                 loc_oForm.Show()
11346:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11347:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11348:                     USE IN cursor_4c_BuscaAux
11349:                 ELSE
11350:                     loc_oPg.txt_4c_Moeda.Value = ""
11351:                 ENDIF
11352:                 loc_oForm.Release()
11353:             ENDIF
11354:             IF USED("cursor_4c_MoedaTmp")
11355:                 USE IN cursor_4c_MoedaTmp
11356:             ENDIF
11357:         CATCH TO loc_oErro
11358:             gb_4c_ValidandoUI = .F.
11359:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")
11360:         ENDTRY
11361:     ENDPROC
11362: 
11363:     *--------------------------------------------------------------------------
11364:     * TabCompo_MoepvLostFocus - LostFocus de txt_4c_Moepv (getMoepv)
11365:     * Valida moeda do preco de venda - lookup em SigCdMoe
11366:     *--------------------------------------------------------------------------
11367:     PROCEDURE TabCompo_MoepvLostFocus()
11368:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11369:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11370: 
11371:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11372:             RETURN
11373:         ENDIF
11374: 
11375:         TRY
11376:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
11377:                 RETURN
11378:             ENDIF
11379:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
11380:             IF EMPTY(loc_cCod)
11381:                 RETURN
11382:             ENDIF
11383:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoepvLostFocusValidado
11384:                 RETURN
11385:             ENDIF
11386:             THIS.this_cUltimoTabCompo_MoepvLostFocusValidado = loc_cCod
11387: 
11388:             gb_4c_ValidandoUI = .T.
11389:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11390:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11391:             gb_4c_ValidandoUI = .F.
11392: 
11393:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11394:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11395:                 loc_oForm.Caption = "Moedas"
11396:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11397:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11398:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11399:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11400:                 loc_oForm.Show()
11401:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11402:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11403:                     USE IN cursor_4c_BuscaAux
11404:                 ELSE
11405:                     loc_oPg.txt_4c_Moepv.Value = ""
11406:                 ENDIF
11407:                 loc_oForm.Release()
11408:             ENDIF
11409:             IF USED("cursor_4c_MoepvTmp")
11410:                 USE IN cursor_4c_MoepvTmp
11411:             ENDIF
11412:         CATCH TO loc_oErro
11413:             gb_4c_ValidandoUI = .F.
11414:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")
11415:         ENDTRY
11416:     ENDPROC
11417: 
11418:     *--------------------------------------------------------------------------
11419:     * TabCompo_MoevLostFocus - LostFocus de txt_4c_Moev (getMoev)
11420:     * Valida moeda do valor de venda - lookup em SigCdMoe
11421:     *--------------------------------------------------------------------------
11422:     PROCEDURE TabCompo_MoevLostFocus()
11423:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11424:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11425: 
11426:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11427:             RETURN
11428:         ENDIF
11429: 
11430:         TRY
11431:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
11432:                 RETURN
11433:             ENDIF
11434:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
11435:             IF EMPTY(loc_cCod)
11436:                 RETURN
11437:             ENDIF
11438:             IF loc_cCod == THIS.this_cUltimoTabCompo_MoevLostFocusValidado
11439:                 RETURN
11440:             ENDIF
11441:             THIS.this_cUltimoTabCompo_MoevLostFocusValidado = loc_cCod
11442: 
11443:             gb_4c_ValidandoUI = .T.
11444:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11445:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11446:             gb_4c_ValidandoUI = .F.
11447: 
11448:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11449:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11450:                 loc_oForm.Caption = "Moedas"
11451:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11452:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11453:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11454:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11455:                 loc_oForm.Show()
11456:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11457:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11458:                     USE IN cursor_4c_BuscaAux
11459:                 ELSE
11460:                     loc_oPg.txt_4c_Moev.Value = ""
11461:                 ENDIF
11462:                 loc_oForm.Release()
11463:             ENDIF
11464:             IF USED("cursor_4c_MoevTmp")
11465:                 USE IN cursor_4c_MoevTmp
11466:             ENDIF
11467:         CATCH TO loc_oErro
11468:             gb_4c_ValidandoUI = .F.
11469:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")
11470:         ENDTRY
11471:     ENDPROC
11472: 
11473:     *--------------------------------------------------------------------------
11474:     * TabCompo_FtioLostFocus - LostFocus de txt_4c_Ftio (Getftio)
11475:     * Valida codigo de feitio de venda - lookup em SigPrFti (Tipos<>1)
11476:     *--------------------------------------------------------------------------
11477:     PROCEDURE TabCompo_FtioLostFocus()
11478:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11479:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11480: 
11481:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11482:             RETURN
11483:         ENDIF
11484: 
11485:         TRY
11486:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
11487:                 RETURN
11488:             ENDIF
11489:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
11490:             IF EMPTY(loc_cCod)
11491:                 THIS.CarregarComposicao()
11492:                 RETURN
11493:             ENDIF
11494:             IF loc_cCod == THIS.this_cUltimoTabCompo_FtioLostFocusValidado
11495:                 RETURN
11496:             ENDIF
11497:             THIS.this_cUltimoTabCompo_FtioLostFocusValidado = loc_cCod
11498: 
11499:             gb_4c_ValidandoUI = .T.
11500:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11501:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11502:             gb_4c_ValidandoUI = .F.
11503: 
11504:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11505:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11506:                 loc_oForm.Caption = "Feitios"
11507:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11508:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11509:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11510:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11511:                 loc_oForm.Show()
11512:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11513:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11514:                     USE IN cursor_4c_BuscaAux
11515:                 ELSE
11516:                     loc_oPg.txt_4c_Ftio.Value = ""
11517:                     IF USED("cursor_4c_FtioTmp")
11518:                         USE IN cursor_4c_FtioTmp
11519:                     ENDIF
11520:                     THIS.CarregarComposicao()
11521:                     RETURN
11522:                 ENDIF
11523:                 loc_oForm.Release()
11524:             ENDIF
11525:             IF USED("cursor_4c_FtioTmp")
11526:                 USE IN cursor_4c_FtioTmp
11527:             ENDIF
11528:             THIS.CarregarComposicao()
11529:         CATCH TO loc_oErro
11530:             gb_4c_ValidandoUI = .F.
11531:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FtioLostFocus")
11532:         ENDTRY
11533:     ENDPROC
11534: 
11535:     *--------------------------------------------------------------------------
11536:     * TabCompo_CmkpcLostFocus - LostFocus de txt_4c_Cmkpc (Get_cmkpc)
11537:     * Valida codigo de feitio de custo - lookup em SigPrFti (Tipos=1)
11538:     *--------------------------------------------------------------------------
11539:     PROCEDURE TabCompo_CmkpcLostFocus()
11540:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11541:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11542: 
11543:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11544:             RETURN
11545:         ENDIF
11546: 
11547:         TRY
11548:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
11549:                 RETURN
11550:             ENDIF
11551:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
11552:             IF EMPTY(loc_cCod)
11553:                 THIS.CarregarComposicao()
11554:                 RETURN
11555:             ENDIF
11556:             IF loc_cCod == THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado
11557:                 RETURN
11558:             ENDIF
11559:             THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado = loc_cCod
11560: 
11561:             gb_4c_ValidandoUI = .T.
11562:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11563:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11564:             gb_4c_ValidandoUI = .F.
11565: 
11566:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11567:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11568:                 loc_oForm.Caption = "Feitios de Custo"
11569:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11570:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11571:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11572:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11573:                 loc_oForm.Show()
11574:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11575:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11576:                     USE IN cursor_4c_BuscaAux
11577:                 ELSE
11578:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11579:                     IF USED("cursor_4c_CmkpcTmp")
11580:                         USE IN cursor_4c_CmkpcTmp
11581:                     ENDIF
11582:                     THIS.CarregarComposicao()
11583:                     RETURN
11584:                 ENDIF
11585:                 loc_oForm.Release()
11586:             ENDIF
11587:             IF USED("cursor_4c_CmkpcTmp")
11588:                 USE IN cursor_4c_CmkpcTmp
11589:             ENDIF
11590:             THIS.CarregarComposicao()
11591:         CATCH TO loc_oErro
11592:             gb_4c_ValidandoUI = .F.
11593:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_CmkpcLostFocus")
11594:         ENDTRY
11595:     ENDPROC
11596: 
11597:     *--------------------------------------------------------------------------
11598:     * TabCompo_StatusLostFocus - LostFocus de txt_4c_Status (getStatus)
11599:     * Atualiza composicao apos mudanca de status
11600:     *--------------------------------------------------------------------------
11601:     PROCEDURE TabCompo_StatusLostFocus()
11602:         TRY
11603:             THIS.CarregarComposicao()
11604:         CATCH TO loc_oErro
11605:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_StatusLostFocus")
11606:         ENDTRY
11607:     ENDPROC
11608: 
11609:     *--------------------------------------------------------------------------
11610:     * TabCompo_MargemLostFocus - LostFocus de txt_4c_Margem (getMargem)
11611:     * Recalcula preco de venda ao mudar margem/markup
11612:     *--------------------------------------------------------------------------
11613:     PROCEDURE TabCompo_MargemLostFocus()
11614:         TRY
11615:             THIS.CarregarComposicao()
11616:         CATCH TO loc_oErro
11617:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MargemLostFocus")
11618:         ENDTRY
11619:     ENDPROC
11620: 
11621:     *--------------------------------------------------------------------------
11622:     * TabCompo_FvendaLostFocus - LostFocus de txt_4c_Fvenda (getFvenda)
11623:     * Recalcula preco de venda ao mudar fator
11624:     *--------------------------------------------------------------------------
11625:     PROCEDURE TabCompo_FvendaLostFocus()
11626:         TRY
11627:             THIS.CarregarComposicao()
11628:         CATCH TO loc_oErro
11629:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_FvendaLostFocus")
11630:         ENDTRY
11631:     ENDPROC
11632: 
11633:     *--------------------------------------------------------------------------
11634:     * TabCompo_DescLostFocus - LostFocus de txt_4c_Desc (Get_Desc)
11635:     * Valida/atualiza descricao do material de composicao
11636:     *--------------------------------------------------------------------------
11637:     PROCEDURE TabCompo_DescLostFocus()
11638:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11639:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11640: 
11641:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11642:             RETURN
11643:         ENDIF
11644: 
11645:         TRY
11646:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11647:                 RETURN
11648:             ENDIF
11649:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Desc.Value)
11650:             IF EMPTY(loc_cDesc)
11651:                 RETURN
11652:             ENDIF
11653:             IF loc_cDesc == THIS.this_cUltimoTabCompo_DescLostFocusValidado
11654:                 RETURN
11655:             ENDIF
11656:             THIS.this_cUltimoTabCompo_DescLostFocusValidado = loc_cDesc
11657: 
11658:             gb_4c_ValidandoUI = .T.
11659:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11660:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11661:             gb_4c_ValidandoUI = .F.
11662: 
11663:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11664:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11665:                 loc_oForm.Caption = "Produtos"
11666:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11667:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11668:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11669:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11670:                 loc_oForm.Show()
11671:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11672:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11673:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11674:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11675:                     ENDIF
11676:                     USE IN cursor_4c_BuscaAux
11677:                 ELSE
11678:                     loc_oPg.txt_4c_Desc.Value = ""
11679:                 ENDIF
11680:                 loc_oForm.Release()
11681:             ELSE
11682:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11683:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11684:                 ENDIF
11685:             ENDIF
11686:             IF USED("cursor_4c_DescTmp")
11687:                 USE IN cursor_4c_DescTmp
11688:             ENDIF
11689:         CATCH TO loc_oErro
11690:             gb_4c_ValidandoUI = .F.
11691:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DescLostFocus")
11692:         ENDTRY
11693:     ENDPROC
11694: 
11695:     *--------------------------------------------------------------------------
11696:     * TabCompo_MatPLostFocus - LostFocus de txt_4c_MatP (Get_MatP)
11697:     * Valida codigo de material principal - lookup em SigCdPro
11698:     *--------------------------------------------------------------------------
11699:     PROCEDURE TabCompo_MatPLostFocus()
11700:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11701:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11702: 
11703:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11704:             RETURN
11705:         ENDIF
11706: 
11707:         TRY
11708:             IF NOT PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11709:                 RETURN
11710:             ENDIF
11711:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_MatP.Value)
11712:             IF EMPTY(loc_cCod)
11713:                 RETURN
11714:             ENDIF
11715:             IF loc_cCod == THIS.this_cUltimoTabCompo_MatPLostFocusValidado
11716:                 RETURN
11717:             ENDIF
11718:             THIS.this_cUltimoTabCompo_MatPLostFocusValidado = loc_cCod
11719: 
11720:             gb_4c_ValidandoUI = .T.
11721:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11722:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11723:             gb_4c_ValidandoUI = .F.
11724: 
11725:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11726:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11727:                 loc_oForm.Caption = "Material Principal"
11728:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11729:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11730:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11731:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11732:                 loc_oForm.Show()
11733:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11734:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11735:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11736:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11737:                     ENDIF
11738:                     USE IN cursor_4c_BuscaAux
11739:                 ELSE
11740:                     loc_oPg.txt_4c_MatP.Value = ""
11741:                 ENDIF
11742:                 loc_oForm.Release()
11743:             ELSE
11744:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11745:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11746:                 ENDIF
11747:             ENDIF
11748:             IF USED("cursor_4c_MatPTmp")
11749:                 USE IN cursor_4c_MatPTmp
11750:             ENDIF
11751:         CATCH TO loc_oErro
11752:             gb_4c_ValidandoUI = .F.
11753:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatPLostFocus")
11754:         ENDTRY
11755:     ENDPROC
11756: 
11757:     *--------------------------------------------------------------------------
11758:     * TabCompo_DesccpLostFocus - LostFocus de txt_4c__desccp (get_desccp)
11759:     * Valida descricao de sub-componente - lookup em SigCdPro
11760:     *--------------------------------------------------------------------------
11761:     PROCEDURE TabCompo_DesccpLostFocus()
11762:         LOCAL loc_oPg, loc_cDesc, loc_oForm, loc_nR, loc_cSQL
11763:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11764: 
11765:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11766:             RETURN
11767:         ENDIF
11768: 
11769:         TRY
11770:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11771:                 RETURN
11772:             ENDIF
11773:             loc_cDesc = ALLTRIM(loc_oPg.txt_4c__desccp.Value)
11774:             IF EMPTY(loc_cDesc)
11775:                 RETURN
11776:             ENDIF
11777:             IF loc_cDesc == THIS.this_cUltimoTabCompo_DesccpLostFocusValidado
11778:                 RETURN
11779:             ENDIF
11780:             THIS.this_cUltimoTabCompo_DesccpLostFocusValidado = loc_cDesc
11781: 
11782:             gb_4c_ValidandoUI = .T.
11783:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11784:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11785:             gb_4c_ValidandoUI = .F.
11786: 
11787:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11788:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11789:                 loc_oForm.Caption = "Sub-Componentes"
11790:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11791:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11792:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11793:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11794:                 loc_oForm.Show()
11795:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11796:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11797:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11798:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11799:                     ENDIF
11800:                     USE IN cursor_4c_BuscaAux
11801:                 ELSE
11802:                     loc_oPg.txt_4c__desccp.Value = ""
11803:                 ENDIF
11804:                 loc_oForm.Release()
11805:             ELSE
11806:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11807:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11808:                 ENDIF
11809:             ENDIF
11810:             IF USED("cursor_4c_DesccpTmp")
11811:                 USE IN cursor_4c_DesccpTmp
11812:             ENDIF
11813:         CATCH TO loc_oErro
11814:             gb_4c_ValidandoUI = .F.
11815:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_DesccpLostFocus")
11816:         ENDTRY
11817:     ENDPROC
11818: 
11819:     *--------------------------------------------------------------------------
11820:     * TabCompo_MatsubLostFocus - LostFocus de txt_4c__matsub (get_matsub)
11821:     * Valida codigo do substituto - lookup em SigCdPro
11822:     *--------------------------------------------------------------------------
11823:     PROCEDURE TabCompo_MatsubLostFocus()
11824:         LOCAL loc_oPg, loc_cCod, loc_oForm, loc_nR, loc_cSQL
11825:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11826: 
11827:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
11828:             RETURN
11829:         ENDIF
11830: 
11831:         TRY
11832:             IF NOT PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11833:                 RETURN
11834:             ENDIF
11835:             loc_cCod = ALLTRIM(loc_oPg.txt_4c__matsub.Value)
11836:             IF EMPTY(loc_cCod)
11837:                 RETURN
11838:             ENDIF
11839:             IF loc_cCod == THIS.this_cUltimoTabCompo_MatsubLostFocusValidado
11840:                 RETURN
11841:             ENDIF
11842:             THIS.this_cUltimoTabCompo_MatsubLostFocusValidado = loc_cCod
11843: 
11844:             gb_4c_ValidandoUI = .T.
11845:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11846:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11847:             gb_4c_ValidandoUI = .F.
11848: 
11849:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11850:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11851:                 loc_oForm.Caption = "Produto Substituto"
11852:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11853:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11854:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11855:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11856:                 loc_oForm.Show()
11857:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11858:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11859:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11860:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11861:                     ENDIF
11862:                     USE IN cursor_4c_BuscaAux
11863:                 ELSE
11864:                     loc_oPg.txt_4c__matsub.Value = ""
11865:                 ENDIF
11866:                 loc_oForm.Release()
11867:             ELSE
11868:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11869:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11870:                 ENDIF
11871:             ENDIF
11872:             IF USED("cursor_4c_MatsubTmp")
11873:                 USE IN cursor_4c_MatsubTmp
11874:             ENDIF
11875:         CATCH TO loc_oErro
11876:             gb_4c_ValidandoUI = .F.
11877:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MatsubLostFocus")
11878:         ENDTRY
11879:     ENDPROC
11880: 
11881:     *--------------------------------------------------------------------------
11882:     * CmdCompoIncluirClick - Botao incluir linha na composicao (grdCompo)
11883:     *--------------------------------------------------------------------------
11884:     PROCEDURE CmdCompoIncluirClick()
11885:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
11886:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11887:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11888: 
11889:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11890:             RETURN
11891:         ENDIF
11892:         IF EMPTY(loc_cCpros)
11893:             RETURN
11894:         ENDIF
11895: 
11896:         TRY
11897:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11898:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11899:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11900:             IF loc_nR > 0
11901:                 THIS.CarregarComposicao()
11902:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11903:                     loc_oPg.grd_4c_Compo.SetFocus()
11904:                 ENDIF
11905:             ELSE
11906:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11907:             ENDIF
11908:         CATCH TO loc_oErro
11909:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11910:         ENDTRY
11911:     ENDPROC
11912: 
11913:     *--------------------------------------------------------------------------
11914:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)
11915:     *--------------------------------------------------------------------------
11916:     PROCEDURE CmdCompoExcluirClick()
11917:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11918:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11919:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11920: 
11921:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11922:             RETURN
11923:         ENDIF
11924:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11925:             RETURN
11926:         ENDIF
11927: 
11928:         TRY
11929:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
11930:             IF EMPTY(loc_cMats)
11931:                 RETURN
11932:             ENDIF
11933:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11934:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11935:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11936:             IF loc_nR > 0
11937:                 THIS.CarregarComposicao()
11938:             ELSE
11939:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11940:             ENDIF
11941:         CATCH TO loc_oErro
11942:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11943:         ENDTRY
11944:     ENDPROC
11945: 
11946:     *--------------------------------------------------------------------------
11947:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11948:     *--------------------------------------------------------------------------
11949:     PROCEDURE CmdCompoAtualizarClick()
11950:         TRY
11951:             THIS.CarregarComposicao()
11952:         CATCH TO loc_oErro
11953:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtualizarClick")
11954:         ENDTRY
11955:     ENDPROC
11956: 
11957:     *--------------------------------------------------------------------------
11958:     * CmdCompoAtuPesosClick - Botao atualizar pesos da composicao
11959:     *--------------------------------------------------------------------------
11960:     PROCEDURE CmdCompoAtuPesosClick()
11961:         TRY
11962:             THIS.CarregarComposicao()
11963:         CATCH TO loc_oErro
11964:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoAtuPesosClick")
11965:         ENDTRY
11966:     ENDPROC
11967: 
11968:     *--------------------------------------------------------------------------
11969:     * CmdCompoRecalcClick - Botao recalcular todos os precos
11970:     *--------------------------------------------------------------------------
11971:     PROCEDURE CmdCompoRecalcClick()
11972:         TRY
11973:             THIS.CarregarComposicao()
11974:         CATCH TO loc_oErro
11975:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoRecalcClick")
11976:         ENDTRY
11977:     ENDPROC
11978: 
11979:     *--------------------------------------------------------------------------
11980:     * CmdSubCpIncluirClick - Botao incluir sub-componente (grdsubcp)
11981:     *--------------------------------------------------------------------------
11982:     PROCEDURE CmdSubCpIncluirClick()
11983:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg
11984:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
11985:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
11986: 
11987:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
11988:             RETURN
11989:         ENDIF
11990:         IF EMPTY(loc_cCpros)
11991:             RETURN
11992:         ENDIF
11993:         IF NOT USED("cursor_4c_Compo") OR EOF("cursor_4c_Compo")
11994:             MsgErro("Selecione um item na composi" + CHR(231) + CHR(227) + "o principal primeiro.", "FormProduto.CmdSubCpIncluirClick")
11995:             RETURN
11996:         ENDIF
11997: 
11998:         TRY
11999:             loc_cMats = ALLTRIM(NVL(cursor_4c_Compo.mats, ""))
12000:             IF EMPTY(loc_cMats)
12001:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
12002:                 RETURN
12003:             ENDIF
12004:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
12005:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
12006:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12007:             IF loc_nR > 0
12008:                 THIS.CarregarComposicao()
12009:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
12010:                     loc_oPg.grd_4c_SubCompo.SetFocus()
12011:                 ENDIF
12012:             ELSE
12013:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
12014:             ENDIF
12015:         CATCH TO loc_oErro
12016:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
12017:         ENDTRY
12018:     ENDPROC
12019: 
12020:     *--------------------------------------------------------------------------
12021:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)
12022:     *--------------------------------------------------------------------------
12023:     PROCEDURE CmdSubCpExcluirClick()
12024:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR
12025:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12026: 
12027:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12028:             RETURN
12029:         ENDIF
12030:         IF NOT USED("cursor_4c_SubCompo") OR EOF("cursor_4c_SubCompo")
12031:             RETURN
12032:         ENDIF
12033: 
12034:         TRY
12035:             loc_cMats = ALLTRIM(NVL(cursor_4c_SubCompo.mats, ""))
12036:             IF EMPTY(loc_cMats)
12037:                 RETURN
12038:             ENDIF
12039:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
12040:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
12041:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12042:             IF loc_nR > 0
12043:                 THIS.CarregarComposicao()
12044:             ELSE
12045:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
12046:             ENDIF
12047:         CATCH TO loc_oErro
12048:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
12049:         ENDTRY
12050:     ENDPROC
12051: 
12052:     *--------------------------------------------------------------------------
12053:     * CmdCalcValsClick - Botao calcular valores de preco/custo
12054:     *--------------------------------------------------------------------------
12055:     PROCEDURE CmdCalcValsClick()
12056:         TRY
12057:             THIS.CarregarComposicao()
12058:         CATCH TO loc_oErro
12059:             MsgErro(loc_oErro.Message, "FormProduto.CmdCalcValsClick")
12060:         ENDTRY
12061:     ENDPROC
12062: 
12063:     *--------------------------------------------------------------------------
12064:     * CmdPesoMClick - Botao calcular/atualizar peso medio
12065:     *--------------------------------------------------------------------------
12066:     PROCEDURE CmdPesoMClick()
12067:         LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_nR
12068:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
12069:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12070: 
12071:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12072:             RETURN
12073:         ENDIF
12074: 
12075:         TRY
12076:             *-- Busca peso calculado a partir da composicao
12077:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
12078:                        "FROM SIGPRCPO c " + ;
12079:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
12080:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
12081:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
12082:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
12083:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
12084:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
12085:                 ENDIF
12086:             ENDIF
12087:             IF USED("cursor_4c_PesoMTmp")
12088:                 USE IN cursor_4c_PesoMTmp
12089:             ENDIF
12090:         CATCH TO loc_oErro
12091:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
12092:         ENDTRY
12093:     ENDPROC
12094: 
12095:     *--------------------------------------------------------------------------
12096:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna
12097:     * Atualiza campos txt_4c_DescCusto e txt_4c_DGruCompos com dados do item
12098:     *--------------------------------------------------------------------------
12099:     PROCEDURE CustosGrd_AfterRowColChange(par_nColIndex)
12100:         LOCAL loc_oPg, loc_cMats, loc_cSQL, loc_nR
12101:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12102: 
12103:         TRY
12104:             IF USED("cursor_4c_CompoCusto") AND !EOF("cursor_4c_CompoCusto")
12105:                 *-- Atualizar campo Descricao
12106:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescCusto", 5)
12107:                     loc_oPg.txt_4c_DescCusto.Value = ALLTRIM(NVL(cursor_4c_CompoCusto.dcompos, ""))
12108:                 ENDIF
12109: 
12110:                 *-- Buscar descricao do grupo com base no material
12111:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12112:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12113:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
12114:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
12115:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
12116:                     gb_4c_ValidandoUI = .T.
12117:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
12118:                     gb_4c_ValidandoUI = .F.
12119:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
12120:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12121:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
12122:                         ENDIF
12123:                     ENDIF
12124:                     IF USED("cursor_4c_GrupoTmpC")
12125:                         USE IN cursor_4c_GrupoTmpC
12126:                     ENDIF
12127:                 ELSE
12128:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12129:                         loc_oPg.txt_4c_DGruCompos.Value = ""
12130:                     ENDIF
12131:                 ENDIF
12132:             ENDIF
12133:         CATCH TO loc_oErro
12134:             gb_4c_ValidandoUI = .F.
12135:             MsgErro(loc_oErro.Message, "FormProduto.CustosGrd_AfterRowColChange")
12136:         ENDTRY
12137:     ENDPROC
12138: 
12139:     *--------------------------------------------------------------------------
12140:     * ConsultaGrd_AfterRowColChange - Grid GrdCons consulta: ao sair de coluna
12141:     * Col4 (Fase/Grupos): busca descricao em SigCdPrf; se nao encontrado abre lookup
12142:     * Col5 (Descricao fase): busca grupos em SigCdPrf por descricao
12143:     * Col8 (Cat): busca descricao em SigCdCat; se nao encontrado abre lookup
12144:     *--------------------------------------------------------------------------
12145:     PROCEDURE ConsultaGrd_AfterRowColChange(par_nColIndex)
12146:         LOCAL loc_oPg, loc_cSQL, loc_nR, loc_cGrupos, loc_cCats, loc_cDcompos
12147:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12148: 
12149:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
12150:             RETURN
12151:         ENDIF
12152: 
12153:         IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12154:             RETURN
12155:         ENDIF
12156: 
12157:         TRY
12158:             DO CASE
12159: 
12160:             *-- Coluna 4 (Fase/Grupos): busca descricao da fase em SigCdPrf
12161:             CASE par_nColIndex = 4
12162:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12163:                 IF !EMPTY(loc_cGrupos)
12164:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
12165:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
12166:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
12167:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
12168:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12169:                             loc_oPg.grd_4c_Consulta.Refresh()
12170:                         ENDIF
12171:                     ELSE
12172:                         THIS.AbrirLookupConsultaFase()
12173:                     ENDIF
12174:                     IF USED("cursor_4c_PrfDesc")
12175:                         USE IN cursor_4c_PrfDesc
12176:                     ENDIF
12177:                 ENDIF
12178: 
12179:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
12180:             CASE par_nColIndex = 5
12181:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
12182:                 IF !EMPTY(loc_cDcompos)
12183:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
12184:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
12185:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")

*-- Linhas 12222 a 12455:
12222:     *--------------------------------------------------------------------------
12223:     * AbrirLookupConsultaFase - Abre lookup SigCdPrf para selecionar fase (col 4)
12224:     *--------------------------------------------------------------------------
12225:     PROCEDURE AbrirLookupConsultaFase()
12226:         LOCAL loc_oPg, loc_oBusca, loc_cGrupos, loc_cDescrs
12227: 
12228:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12229: 
12230:         TRY
12231:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12232:                 RETURN
12233:             ENDIF
12234: 
12235:             loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12236:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", "cursor_4c_PrfSel", "grupos", loc_cGrupos, "Selecionar Fase")
12237:             loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
12238:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12239:             loc_oBusca.Show()
12240: 
12241:             IF loc_oBusca.this_lSelecionou
12242:                 IF USED("cursor_4c_PrfSel")
12243:                     loc_cGrupos = ALLTRIM(NVL(cursor_4c_PrfSel.grupos, ""))
12244:                     loc_cDescrs = ALLTRIM(NVL(cursor_4c_PrfSel.descrs, ""))
12245:                     REPLACE cursor_4c_Consulta.grupos  WITH loc_cGrupos
12246:                     REPLACE cursor_4c_Consulta.dcompos WITH loc_cDescrs
12247:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12248:                         loc_oPg.grd_4c_Consulta.Refresh()
12249:                     ENDIF
12250:                 ENDIF
12251:             ELSE
12252:                 REPLACE cursor_4c_Consulta.grupos  WITH ""
12253:                 REPLACE cursor_4c_Consulta.dcompos WITH ""
12254:             ENDIF
12255: 
12256:             IF USED("cursor_4c_PrfSel")
12257:                 USE IN cursor_4c_PrfSel
12258:             ENDIF
12259:             loc_oBusca.Release()
12260:             loc_oBusca = .NULL.
12261: 
12262:         CATCH TO loc_oErro
12263:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaFase")
12264:         ENDTRY
12265:     ENDPROC
12266: 
12267:     *--------------------------------------------------------------------------
12268:     * AbrirLookupConsultaCat - Abre lookup SigCdCat para selecionar categoria (col 8)
12269:     *--------------------------------------------------------------------------
12270:     PROCEDURE AbrirLookupConsultaCat()
12271:         LOCAL loc_oPg, loc_oBusca, loc_cCods, loc_cDescs
12272: 
12273:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
12274: 
12275:         TRY
12276:             IF !USED("cursor_4c_Consulta") OR EOF("cursor_4c_Consulta")
12277:                 RETURN
12278:             ENDIF
12279: 
12280:             loc_cCods  = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12281:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", "cursor_4c_CatSel", "cods", loc_cCods, "Selecionar Categoria")
12282:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12283:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12284:             loc_oBusca.Show()
12285: 
12286:             IF loc_oBusca.this_lSelecionou
12287:                 IF USED("cursor_4c_CatSel")
12288:                     loc_cCods  = ALLTRIM(NVL(cursor_4c_CatSel.cods,  ""))
12289:                     loc_cDescs = ALLTRIM(NVL(cursor_4c_CatSel.descs, ""))
12290:                     REPLACE cursor_4c_Consulta.cats   WITH loc_cCods
12291:                     REPLACE cursor_4c_Consulta.dscgrp WITH loc_cDescs
12292:                     IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12293:                         loc_oPg.grd_4c_Consulta.Refresh()
12294:                     ENDIF
12295:                 ENDIF
12296:             ELSE
12297:                 REPLACE cursor_4c_Consulta.cats   WITH ""
12298:                 REPLACE cursor_4c_Consulta.dscgrp WITH ""
12299:             ENDIF
12300: 
12301:             IF USED("cursor_4c_CatSel")
12302:                 USE IN cursor_4c_CatSel
12303:             ENDIF
12304:             loc_oBusca.Release()
12305:             loc_oBusca = .NULL.
12306: 
12307:         CATCH TO loc_oErro
12308:             MsgErro(loc_oErro.Message, "FormProduto.AbrirLookupConsultaCat")
12309:         ENDTRY
12310:     ENDPROC
12311: 
12312:     *--------------------------------------------------------------------------
12313:     * CmbTiposCustoValid - ComboBox tipo custo: ao mudar selecao, recarrega grid
12314:     *--------------------------------------------------------------------------
12315:     PROCEDURE CmbTiposCustoValid()
12316:         TRY
12317:             THIS.CarregarCustos()
12318:         CATCH TO loc_oErro
12319:             MsgErro(loc_oErro.Message, "FormProduto.CmbTiposCustoValid")
12320:         ENDTRY
12321:     ENDPROC
12322: 
12323:     *--------------------------------------------------------------------------
12324:     * CmdCustoIncluirClick - Botao incluir linha no grid de custo
12325:     * Insere novo registro em SIGPRCPO com Tipos = valor selecionado no combo
12326:     *--------------------------------------------------------------------------
12327:     PROCEDURE CmdCustoIncluirClick()
12328:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg, loc_nTipo
12329:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12330:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12331: 
12332:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12333:             RETURN
12334:         ENDIF
12335:         IF EMPTY(loc_cCpros)
12336:             RETURN
12337:         ENDIF
12338: 
12339:         TRY
12340:             loc_nTipo = 1
12341:             IF PEMSTATUS(loc_oPg, "cmb_4c_TiposCusto", 5)
12342:                 loc_nTipo = NVL(loc_oPg.cmb_4c_TiposCusto.ListIndex, 1)
12343:                 *-- ListIndex 1=Todos: usar tipo 1; demais: usar o proprio valor
12344:                 IF loc_nTipo < 1
12345:                     loc_nTipo = 1
12346:                 ENDIF
12347:             ENDIF
12348: 
12349:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12350:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12351:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12352:             IF loc_nR > 0
12353:                 THIS.CarregarCustos()
12354:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12355:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12356:                 ENDIF
12357:             ELSE
12358:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12359:             ENDIF
12360:         CATCH TO loc_oErro
12361:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12362:         ENDTRY
12363:     ENDPROC
12364: 
12365:     *--------------------------------------------------------------------------
12366:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo
12367:     * Remove registro de SIGPRCPO com base no material selecionado
12368:     *--------------------------------------------------------------------------
12369:     PROCEDURE CmdCustoExcluirClick()
12370:         LOCAL loc_cCpros, loc_cMats, loc_cSQL, loc_nR, loc_oPg, loc_lConfirma
12371:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
12372:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12373: 
12374:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12375:             RETURN
12376:         ENDIF
12377:         IF NOT USED("cursor_4c_CompoCusto") OR EOF("cursor_4c_CompoCusto")
12378:             RETURN
12379:         ENDIF
12380: 
12381:         TRY
12382:             loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12383: 
12384:             IF EMPTY(loc_cMats)
12385:                 MsgAviso("Selecione um item para excluir.", "FormProduto")
12386:                 RETURN
12387:             ENDIF
12388: 
12389:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do item '" + loc_cMats + "'?", "FormProduto")
12390:             IF !loc_lConfirma
12391:                 RETURN
12392:             ENDIF
12393: 
12394:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12395:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12396:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12397:             IF loc_nR > 0
12398:                 THIS.CarregarCustos()
12399:             ELSE
12400:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12401:             ENDIF
12402:         CATCH TO loc_oErro
12403:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12404:         ENDTRY
12405:     ENDPROC
12406: 
12407:     *==========================================================================
12408:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12409:     *==========================================================================
12410: 
12411:     *--------------------------------------------------------------------------
12412:     * GrdFasesAfterRowColChange - Atualiza imagem + descricao ao navegar no grid
12413:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12414:     *--------------------------------------------------------------------------
12415:     PROCEDURE GrdFasesAfterRowColChange
12416:         LPARAMETERS par_nColIndex
12417:         LOCAL loc_oPg, loc_cCpros, loc_cGrupos, loc_cSQL, loc_nR, loc_cArquivo
12418:         LOCAL loc_nOrdems
12419: 
12420:         TRY
12421:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12422:             loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
12423: 
12424:             IF EMPTY(loc_cCpros) OR !USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
12425:                 RETURN
12426:             ENDIF
12427: 
12428:             loc_cGrupos  = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
12429:             loc_nOrdems  = NVL(cursor_4c_Fases.ordems, 0)
12430: 
12431:             *-- Limpar imagem anterior
12432:             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12433:                 loc_oPg.img_4c_ImgFigJpg.Picture = ""
12434:                 loc_oPg.img_4c_ImgFigJpg.Visible = .F.
12435:             ENDIF
12436: 
12437:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12438:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12439:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12440:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12441:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12442:                     AND ordems = <<loc_nOrdems>>
12443:                 ENDTEXT
12444:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12445:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12446:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12447:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12448:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12449:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12450:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12451:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12452:                             ENDIF
12453:                         ENDIF
12454:                     ENDIF
12455:                 ENDIF

*-- Linhas 12492 a 12537:
12492: 
12493:     *--------------------------------------------------------------------------
12494:     * GrdMatrizesAfterRowColChange - Atualiza imagem ao navegar no grid de matrizes
12495:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
12496:     *--------------------------------------------------------------------------
12497:     PROCEDURE GrdMatrizesAfterRowColChange
12498:         LPARAMETERS par_nColIndex
12499:         LOCAL loc_oPg, loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFigB64
12500: 
12501:         TRY
12502:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12503: 
12504:             *-- Limpar imagem anterior
12505:             IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5)
12506:                 loc_oPg.img_4c_ImgBorracha.Picture = ""
12507:                 loc_oPg.img_4c_ImgBorracha.Visible = .F.
12508:             ENDIF
12509: 
12510:             IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
12511:                 RETURN
12512:             ENDIF
12513: 
12514:             loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
12515:             IF EMPTY(loc_cCmats) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
12516:                 RETURN
12517:             ENDIF
12518: 
12519:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12520:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12521:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12522:             ENDTEXT
12523:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12524:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12525:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12526:                 IF !EMPTY(loc_cFigB64)
12527:                     *-- Converter de Base64 para binario
12528:                     LOCAL loc_cFigBin
12529:                     loc_cFigBin = STRCONV( ;
12530:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12531:                             "data:image/png;base64,", ""), ;
12532:                             "data:image/jpeg;base64,", ""), ;
12533:                             "data:image/jpg;base64,", ""), 14)
12534:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12535:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12536:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12537:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo

*-- Linhas 12552 a 13274:
12552:     *--------------------------------------------------------------------------
12553:     * ImgFigJpgClick - Clique na imagem da fase: abre zoom
12554:     *--------------------------------------------------------------------------
12555:     PROCEDURE ImgFigJpgClick()
12556:         LOCAL loc_oPg, loc_cArquivo
12557:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12558:         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
12559:             loc_cArquivo = loc_oPg.img_4c_ImgFigJpg.Picture
12560:             IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
12561:                 MsgInfo("Zoom de imagem: " + loc_cArquivo, "Imagem da Fase")
12562:             ENDIF
12563:         ENDIF
12564:     ENDPROC
12565: 
12566:     *--------------------------------------------------------------------------
12567:     * TabFases_CodcorsKeyPress - F4 no campo Cor (aba Fases) abre lookup
12568:     *--------------------------------------------------------------------------
12569:     PROCEDURE TabFases_CodcorsKeyPress
12570:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12571:         IF par_nKeyCode = 115
12572:             THIS.AbrirLookupCorFas()
12573:         ENDIF
12574:     ENDPROC
12575: 
12576:     *--------------------------------------------------------------------------
12577:     * TabFases_CodcorsLostFocus - LostFocus valida cor na aba Fases
12578:     *--------------------------------------------------------------------------
12579:     PROCEDURE TabFases_CodcorsLostFocus()
12580:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12581:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12582:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodcorsFas", 5)
12583:             RETURN
12584:         ENDIF
12585:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodcorsFas.Value)
12586:         IF loc_cCod == THIS.this_cUltCorFas
12587:             RETURN
12588:         ENDIF
12589:         THIS.this_cUltCorFas = loc_cCod
12590:         IF EMPTY(loc_cCod)
12591:             RETURN
12592:         ENDIF
12593:         TRY
12594:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12595:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12596:             ENDTEXT
12597:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12598:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12599:                 THIS.AbrirLookupCorFas()
12600:             ELSE
12601:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12602:             ENDIF
12603:             IF USED("cursor_4c_VCorFas")
12604:                 USE IN cursor_4c_VCorFas
12605:             ENDIF
12606:         CATCH TO loc_oErro
12607:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12608:         ENDTRY
12609:     ENDPROC
12610: 
12611:     *--------------------------------------------------------------------------
12612:     * AbrirLookupCorFas - Lookup Cor para a aba Fases
12613:     * Atualiza Page7 e Page1 (campos sincronizados)
12614:     *--------------------------------------------------------------------------
12615:     PROTECTED PROCEDURE AbrirLookupCorFas()
12616:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12617:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12618:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12619:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodcorsFas.Value), "")
12620: 
12621:         TRY
12622:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", "cursor_4c_CorFas", "cods", loc_cVal, "Selecionar Cor")
12623:             loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
12624:             loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12625:             loc_oBusca.Show()
12626: 
12627:             IF loc_oBusca.this_lSelecionou
12628:                 IF USED("cursor_4c_CorFas")
12629:                     LOCAL loc_cCodSel
12630:                     loc_cCodSel = ALLTRIM(cursor_4c_CorFas.cods)
12631:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12632:                         loc_oPg7.txt_4c_CodcorsFas.Value = loc_cCodSel
12633:                     ENDIF
12634:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codcors", 5)
12635:                         loc_oPg1.txt_4c_Codcors.Value = loc_cCodSel
12636:                     ENDIF
12637:                     THIS.this_oBusinessObject.this_cCodcors = loc_cCodSel
12638:                 ENDIF
12639:             ELSE
12640:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodcorsFas", 5)
12641:                     loc_oPg7.txt_4c_CodcorsFas.Value = ""
12642:                 ENDIF
12643:             ENDIF
12644: 
12645:             IF USED("cursor_4c_CorFas")
12646:                 USE IN cursor_4c_CorFas
12647:             ENDIF
12648:             loc_oBusca.Release()
12649:         CATCH TO loc_oErro
12650:             MsgErro("Erro no lookup de cor (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupCorFas")
12651:         ENDTRY
12652:     ENDPROC
12653: 
12654:     *--------------------------------------------------------------------------
12655:     * TabFases_CodtamsKeyPress - F4 no campo Tamanho (aba Fases) abre lookup
12656:     *--------------------------------------------------------------------------
12657:     PROCEDURE TabFases_CodtamsKeyPress
12658:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12659:         IF par_nKeyCode = 115
12660:             THIS.AbrirLookupTamanhoFas()
12661:         ENDIF
12662:     ENDPROC
12663: 
12664:     *--------------------------------------------------------------------------
12665:     * TabFases_CodtamsLostFocus - LostFocus valida tamanho na aba Fases
12666:     *--------------------------------------------------------------------------
12667:     PROCEDURE TabFases_CodtamsLostFocus()
12668:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12669:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12670:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodtamsFas", 5)
12671:             RETURN
12672:         ENDIF
12673:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodtamsFas.Value)
12674:         IF loc_cCod == THIS.this_cUltTamFas
12675:             RETURN
12676:         ENDIF
12677:         THIS.this_cUltTamFas = loc_cCod
12678:         IF EMPTY(loc_cCod)
12679:             RETURN
12680:         ENDIF
12681:         TRY
12682:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12683:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12684:             ENDTEXT
12685:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12686:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12687:                 THIS.AbrirLookupTamanhoFas()
12688:             ELSE
12689:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12690:             ENDIF
12691:             IF USED("cursor_4c_VTamFas")
12692:                 USE IN cursor_4c_VTamFas
12693:             ENDIF
12694:         CATCH TO loc_oErro
12695:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12696:         ENDTRY
12697:     ENDPROC
12698: 
12699:     *--------------------------------------------------------------------------
12700:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases
12701:     *--------------------------------------------------------------------------
12702:     PROTECTED PROCEDURE AbrirLookupTamanhoFas()
12703:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12704:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12705:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12706:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodtamsFas.Value), "")
12707: 
12708:         TRY
12709:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", "cursor_4c_TamFas", "Cods", loc_cVal, "Selecionar Tamanho")
12710:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
12711:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
12712:             loc_oBusca.Show()
12713: 
12714:             IF loc_oBusca.this_lSelecionou
12715:                 IF USED("cursor_4c_TamFas")
12716:                     LOCAL loc_cCodSel
12717:                     loc_cCodSel = ALLTRIM(cursor_4c_TamFas.Cods)
12718:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12719:                         loc_oPg7.txt_4c_CodtamsFas.Value = loc_cCodSel
12720:                     ENDIF
12721:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codtams", 5)
12722:                         loc_oPg1.txt_4c_Codtams.Value = loc_cCodSel
12723:                     ENDIF
12724:                     THIS.this_oBusinessObject.this_cCodtams = loc_cCodSel
12725:                 ENDIF
12726:             ELSE
12727:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodtamsFas", 5)
12728:                     loc_oPg7.txt_4c_CodtamsFas.Value = ""
12729:                 ENDIF
12730:             ENDIF
12731: 
12732:             IF USED("cursor_4c_TamFas")
12733:                 USE IN cursor_4c_TamFas
12734:             ENDIF
12735:             loc_oBusca.Release()
12736:         CATCH TO loc_oErro
12737:             MsgErro("Erro no lookup de tamanho (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupTamanhoFas")
12738:         ENDTRY
12739:     ENDPROC
12740: 
12741:     *--------------------------------------------------------------------------
12742:     * TabFases_CodacbsKeyPress - F4 no campo Acabamento (aba Fases) abre lookup
12743:     *--------------------------------------------------------------------------
12744:     PROCEDURE TabFases_CodacbsKeyPress
12745:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12746:         IF par_nKeyCode = 115
12747:             THIS.AbrirLookupAcabamentoFas()
12748:         ENDIF
12749:     ENDPROC
12750: 
12751:     *--------------------------------------------------------------------------
12752:     * TabFases_CodacbsLostFocus - LostFocus valida acabamento na aba Fases
12753:     *--------------------------------------------------------------------------
12754:     PROCEDURE TabFases_CodacbsLostFocus()
12755:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12756:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12757:         IF !PEMSTATUS(loc_oPg, "txt_4c_CodacbsFas", 5)
12758:             RETURN
12759:         ENDIF
12760:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodacbsFas.Value)
12761:         IF loc_cCod == THIS.this_cUltAcbFas
12762:             RETURN
12763:         ENDIF
12764:         THIS.this_cUltAcbFas = loc_cCod
12765:         IF EMPTY(loc_cCod)
12766:             IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12767:                 loc_oPg.txt_4c_DacbsFas.Value = ""
12768:             ENDIF
12769:             RETURN
12770:         ENDIF
12771:         TRY
12772:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12773:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12774:             ENDTEXT
12775:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12776:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12777:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12778:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12779:                 ENDIF
12780:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12781:             ELSE
12782:                 THIS.AbrirLookupAcabamentoFas()
12783:             ENDIF
12784:             IF USED("cursor_4c_VAcbFas")
12785:                 USE IN cursor_4c_VAcbFas
12786:             ENDIF
12787:         CATCH TO loc_oErro
12788:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12789:         ENDTRY
12790:     ENDPROC
12791: 
12792:     *--------------------------------------------------------------------------
12793:     * AbrirLookupAcabamentoFas - Lookup Acabamento para a aba Fases
12794:     *--------------------------------------------------------------------------
12795:     PROTECTED PROCEDURE AbrirLookupAcabamentoFas()
12796:         LOCAL loc_oBusca, loc_oPg7, loc_oPg1, loc_cVal
12797:         loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12798:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
12799:         loc_cVal = IIF(PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5), ALLTRIM(loc_oPg7.txt_4c_CodacbsFas.Value), "")
12800: 
12801:         TRY
12802:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", "cursor_4c_AcbFas", "cods", loc_cVal, "Selecionar Acabamento")
12803:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
12804:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
12805:             loc_oBusca.Show()
12806: 
12807:             IF loc_oBusca.this_lSelecionou
12808:                 IF USED("cursor_4c_AcbFas")
12809:                     LOCAL loc_cCodSel, loc_cDescSel
12810:                     loc_cCodSel  = ALLTRIM(cursor_4c_AcbFas.cods)
12811:                     loc_cDescSel = ALLTRIM(cursor_4c_AcbFas.descrs)
12812:                     IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12813:                         loc_oPg7.txt_4c_CodacbsFas.Value = loc_cCodSel
12814:                     ENDIF
12815:                     IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12816:                         loc_oPg7.txt_4c_DacbsFas.Value = loc_cDescSel
12817:                     ENDIF
12818:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Codacbs", 5)
12819:                         loc_oPg1.txt_4c_Codacbs.Value = loc_cCodSel
12820:                     ENDIF
12821:                     IF PEMSTATUS(loc_oPg1, "txt_4c_Dcodacbs", 5)
12822:                         loc_oPg1.txt_4c_Dcodacbs.Value = loc_cDescSel
12823:                     ENDIF
12824:                     THIS.this_oBusinessObject.this_cCodacbs = loc_cCodSel
12825:                 ENDIF
12826:             ELSE
12827:                 IF PEMSTATUS(loc_oPg7, "txt_4c_CodacbsFas", 5)
12828:                     loc_oPg7.txt_4c_CodacbsFas.Value = ""
12829:                 ENDIF
12830:                 IF PEMSTATUS(loc_oPg7, "txt_4c_DacbsFas", 5)
12831:                     loc_oPg7.txt_4c_DacbsFas.Value = ""
12832:                 ENDIF
12833:             ENDIF
12834: 
12835:             IF USED("cursor_4c_AcbFas")
12836:                 USE IN cursor_4c_AcbFas
12837:             ENDIF
12838:             loc_oBusca.Release()
12839:         CATCH TO loc_oErro
12840:             MsgErro("Erro no lookup de acabamento (Fases):" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupAcabamentoFas")
12841:         ENDTRY
12842:     ENDPROC
12843: 
12844:     *--------------------------------------------------------------------------
12845:     * TabFases_ConquilhaKeyPress - F4 no campo Conquilha abre lookup
12846:     *--------------------------------------------------------------------------
12847:     PROCEDURE TabFases_ConquilhaKeyPress
12848:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12849:         IF par_nKeyCode = 115
12850:             THIS.AbrirLookupConquilha()
12851:         ENDIF
12852:     ENDPROC
12853: 
12854:     *--------------------------------------------------------------------------
12855:     * TabFases_ConquilhaLostFocus - LostFocus valida conquilha
12856:     *--------------------------------------------------------------------------
12857:     PROCEDURE TabFases_ConquilhaLostFocus()
12858:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12859:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12860:         IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12861:             RETURN
12862:         ENDIF
12863:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
12864:         IF loc_cCod == THIS.this_cUltConquilha
12865:             RETURN
12866:         ENDIF
12867:         THIS.this_cUltConquilha = loc_cCod
12868:         IF EMPTY(loc_cCod)
12869:             RETURN
12870:         ENDIF
12871:         TRY
12872:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12873:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12874:             ENDTEXT
12875:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12876:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12877:                 THIS.AbrirLookupConquilha()
12878:             ELSE
12879:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12880:             ENDIF
12881:             IF USED("cursor_4c_VCnq")
12882:                 USE IN cursor_4c_VCnq
12883:             ENDIF
12884:         CATCH TO loc_oErro
12885:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12886:         ENDTRY
12887:     ENDPROC
12888: 
12889:     *--------------------------------------------------------------------------
12890:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)
12891:     *--------------------------------------------------------------------------
12892:     PROTECTED PROCEDURE AbrirLookupConquilha()
12893:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12894:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12895:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5), ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value), "")
12896: 
12897:         TRY
12898:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", "cursor_4c_Cnq", "conquilhas", loc_cVal, "Selecionar Conquilha")
12899:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
12900:             loc_oBusca.Show()
12901: 
12902:             IF loc_oBusca.this_lSelecionou
12903:                 IF USED("cursor_4c_Cnq")
12904:                     LOCAL loc_cCodSel
12905:                     loc_cCodSel = ALLTRIM(cursor_4c_Cnq.conquilhas)
12906:                     IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12907:                         loc_oPg.txt_4c_Conquilhas.Value = loc_cCodSel
12908:                     ENDIF
12909:                     THIS.this_oBusinessObject.this_cConquilhas = loc_cCodSel
12910:                 ENDIF
12911:             ELSE
12912:                 IF PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
12913:                     loc_oPg.txt_4c_Conquilhas.Value = ""
12914:                 ENDIF
12915:             ENDIF
12916: 
12917:             IF USED("cursor_4c_Cnq")
12918:                 USE IN cursor_4c_Cnq
12919:             ENDIF
12920:             loc_oBusca.Release()
12921:         CATCH TO loc_oErro
12922:             MsgErro("Erro no lookup de conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupConquilha")
12923:         ENDTRY
12924:     ENDPROC
12925: 
12926:     *--------------------------------------------------------------------------
12927:     * TabFases_GarraKeyPress - F4 no campo Garra abre lookup
12928:     *--------------------------------------------------------------------------
12929:     PROCEDURE TabFases_GarraKeyPress
12930:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
12931:         IF par_nKeyCode = 115
12932:             THIS.AbrirLookupGarra()
12933:         ENDIF
12934:     ENDPROC
12935: 
12936:     *--------------------------------------------------------------------------
12937:     * TabFases_GarraLostFocus - LostFocus valida garra
12938:     *--------------------------------------------------------------------------
12939:     PROCEDURE TabFases_GarraLostFocus()
12940:         LOCAL loc_oPg, loc_cCod, loc_cSQL, loc_nR
12941:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12942:         IF !PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12943:             RETURN
12944:         ENDIF
12945:         loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codgarras.Value)
12946:         IF loc_cCod == THIS.this_cUltGarra
12947:             RETURN
12948:         ENDIF
12949:         THIS.this_cUltGarra = loc_cCod
12950:         IF EMPTY(loc_cCod)
12951:             RETURN
12952:         ENDIF
12953:         TRY
12954:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12955:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12956:             ENDTEXT
12957:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12958:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12959:                 THIS.AbrirLookupGarra()
12960:             ELSE
12961:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12962:             ENDIF
12963:             IF USED("cursor_4c_VGar")
12964:                 USE IN cursor_4c_VGar
12965:             ENDIF
12966:         CATCH TO loc_oErro
12967:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12968:         ENDTRY
12969:     ENDPROC
12970: 
12971:     *--------------------------------------------------------------------------
12972:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)
12973:     *--------------------------------------------------------------------------
12974:     PROTECTED PROCEDURE AbrirLookupGarra()
12975:         LOCAL loc_oBusca, loc_oPg, loc_cVal
12976:         loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12977:         loc_cVal = IIF(PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5), ALLTRIM(loc_oPg.txt_4c_Codgarras.Value), "")
12978: 
12979:         TRY
12980:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGar", "cursor_4c_Gar", "codgarras", loc_cVal, "Selecionar Garra")
12981:             loc_oBusca.mAddColuna("codgarras", "", "C" + CHR(243) + "digo")
12982:             loc_oBusca.Show()
12983: 
12984:             IF loc_oBusca.this_lSelecionou
12985:                 IF USED("cursor_4c_Gar")
12986:                     LOCAL loc_cCodSel
12987:                     loc_cCodSel = ALLTRIM(cursor_4c_Gar.codgarras)
12988:                     IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12989:                         loc_oPg.txt_4c_Codgarras.Value = loc_cCodSel
12990:                     ENDIF
12991:                     THIS.this_oBusinessObject.this_cCodgarras = loc_cCodSel
12992:                 ENDIF
12993:             ELSE
12994:                 IF PEMSTATUS(loc_oPg, "txt_4c_Codgarras", 5)
12995:                     loc_oPg.txt_4c_Codgarras.Value = ""
12996:                 ENDIF
12997:             ENDIF
12998: 
12999:             IF USED("cursor_4c_Gar")
13000:                 USE IN cursor_4c_Gar
13001:             ENDIF
13002:             loc_oBusca.Release()
13003:         CATCH TO loc_oErro
13004:             MsgErro("Erro no lookup de garra:" + CHR(13) + loc_oErro.Message, "FormProduto.AbrirLookupGarra")
13005:         ENDTRY
13006:     ENDPROC
13007: 
13008:     *--------------------------------------------------------------------------
13009:     * BtnInserirFaseClick - Inserir nova fase de producao em SigCdPrf
13010:     *--------------------------------------------------------------------------
13011:     PROCEDURE BtnInserirFaseClick()
13012:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nProxOrdem, loc_nMaxOrdem
13013: 
13014:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13015:             MsgAviso("Salve ou edite o produto antes de inserir fases.", "FormProduto")
13016:             RETURN
13017:         ENDIF
13018: 
13019:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13020:         IF EMPTY(loc_cCpros)
13021:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
13022:             RETURN
13023:         ENDIF
13024: 
13025:         TRY
13026:             *-- Calcular proximo numero de ordem
13027:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13028:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13029:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13030:             ENDTEXT
13031:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
13032:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
13033:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
13034:             ELSE
13035:                 loc_nProxOrdem = 1
13036:             ENDIF
13037:             IF USED("cursor_4c_MaxOrdem")
13038:                 USE IN cursor_4c_MaxOrdem
13039:             ENDIF
13040: 
13041:             *-- Inserir nova fase
13042:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13043:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13044:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
13045:             ENDTEXT
13046:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13047:             IF loc_nR > 0
13048:                 THIS.CarregarFases()
13049:                 LOCAL loc_oPg7
13050:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13051:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
13052:                     loc_oPg7.grd_4c_Fases.SetFocus()
13053:                 ENDIF
13054:             ELSE
13055:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
13056:             ENDIF
13057:         CATCH TO loc_oErro
13058:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
13059:         ENDTRY
13060:     ENDPROC
13061: 
13062:     *--------------------------------------------------------------------------
13063:     * BtnExcluirFaseClick - Excluir fase de producao selecionada
13064:     *--------------------------------------------------------------------------
13065:     PROCEDURE BtnExcluirFaseClick()
13066:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_lConfirma
13067: 
13068:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13069:             RETURN
13070:         ENDIF
13071: 
13072:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases") OR BOF("cursor_4c_Fases")
13073:             MsgAviso("Selecione uma fase para excluir.", "FormProduto")
13074:             RETURN
13075:         ENDIF
13076: 
13077:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13078:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
13079: 
13080:         IF loc_nOrdems <= 0
13081:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida para excluir.", "FormProduto")
13082:             RETURN
13083:         ENDIF
13084: 
13085:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da fase " + TRANSFORM(loc_nOrdems) + "?", "FormProduto")
13086:         IF !loc_lConfirma
13087:             RETURN
13088:         ENDIF
13089: 
13090:         TRY
13091:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13092:                 DELETE FROM SigCdPrf
13093:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13094:                 AND ordems = <<loc_nOrdems>>
13095:             ENDTEXT
13096:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13097:             IF loc_nR > 0
13098:                 THIS.CarregarFases()
13099:             ELSE
13100:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
13101:             ENDIF
13102:         CATCH TO loc_oErro
13103:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
13104:         ENDTRY
13105:     ENDPROC
13106: 
13107:     *--------------------------------------------------------------------------
13108:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
13109:     *--------------------------------------------------------------------------
13110:     PROCEDURE BtnAlternativaFaseClick()
13111:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem
13112: 
13113:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13114:             MsgAviso("Salve ou edite o produto antes de inserir alternativas.", "FormProduto")
13115:             RETURN
13116:         ENDIF
13117: 
13118:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13119:         IF EMPTY(loc_cCpros)
13120:             MsgAviso("Produto n" + CHR(227) + "o identificado. Salve o produto primeiro.", "FormProduto")
13121:             RETURN
13122:         ENDIF
13123: 
13124:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
13125:             MsgAviso("Selecione uma fase base para criar a alternativa.", "FormProduto")
13126:             RETURN
13127:         ENDIF
13128: 
13129:         loc_cGrupoAtual = ALLTRIM(NVL(cursor_4c_Fases.grupos, ""))
13130:         IF EMPTY(loc_cGrupoAtual)
13131:             MsgAviso("A fase selecionada precisa ter um grupo definido.", "FormProduto")
13132:             RETURN
13133:         ENDIF
13134: 
13135:         TRY
13136:             *-- Calcular proximo numero de ordem
13137:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13138:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13139:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13140:             ENDTEXT
13141:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
13142:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
13143:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
13144:             ELSE
13145:                 loc_nProxOrdem = 1
13146:             ENDIF
13147:             IF USED("cursor_4c_MaxOrdAlt")
13148:                 USE IN cursor_4c_MaxOrdAlt
13149:             ENDIF
13150: 
13151:             *-- Inserir fase alternativa copiando o grupo da fase atual
13152:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13153:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13154:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
13155:             ENDTEXT
13156:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13157:             IF loc_nR > 0
13158:                 THIS.CarregarFases()
13159:             ELSE
13160:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
13161:             ENDIF
13162:         CATCH TO loc_oErro
13163:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
13164:         ENDTRY
13165:     ENDPROC
13166: 
13167:     *--------------------------------------------------------------------------
13168:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
13169:     *--------------------------------------------------------------------------
13170:     PROCEDURE CmdFichaClick()
13171:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO
13172: 
13173:         loc_oBO    = THIS.this_oBusinessObject
13174:         loc_cCpros = ALLTRIM(loc_oBO.this_cCpros)
13175: 
13176:         IF EMPTY(loc_cCpros)
13177:             MsgAviso("Nenhum produto selecionado.", "FormProduto")
13178:             RETURN
13179:         ENDIF
13180: 
13181:         TRY
13182:             *-- Criar cursor de cabecalho para o relatorio
13183:             IF USED("CsCabecalho")
13184:                 USE IN CsCabecalho
13185:             ENDIF
13186:             CREATE CURSOR CsCabecalho ( ;
13187:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
13188:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
13189:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
13190:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
13191: 
13192:             INSERT INTO CsCabecalho ;
13193:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
13194:                 VALUES( ;
13195:                     go_4c_Sistema.cEmpresa, ;
13196:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
13197:                     loc_cCpros, ;
13198:                     loc_oBO.this_cDpros, ;
13199:                     loc_oBO.this_cCgrus, ;
13200:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
13201:                     THIS.this_cModoAtual)
13202: 
13203:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
13204: 
13205:             IF USED("CsCabecalho")
13206:                 USE IN CsCabecalho
13207:             ENDIF
13208: 
13209:         CATCH TO loc_oErro
13210:             MsgErro("Erro ao gerar ficha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdFichaClick")
13211:         ENDTRY
13212:     ENDPROC
13213: 
13214:     *--------------------------------------------------------------------------
13215:     * CmdgFiguraClick - Carregar/remover imagem da fase selecionada (FigProcs)
13216:     *--------------------------------------------------------------------------
13217:     PROCEDURE CmdgFiguraClick()
13218:         LOCAL loc_cCpros, loc_nOrdems, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig
13219:         LOCAL loc_oPg, loc_lConfirma
13220: 
13221:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13222:             RETURN
13223:         ENDIF
13224: 
13225:         IF NOT USED("cursor_4c_Fases") OR EOF("cursor_4c_Fases")
13226:             MsgAviso("Selecione uma fase para carregar a imagem.", "FormProduto")
13227:             RETURN
13228:         ENDIF
13229: 
13230:         loc_cCpros  = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13231:         loc_nOrdems = NVL(cursor_4c_Fases.ordems, 0)
13232: 
13233:         IF loc_nOrdems <= 0
13234:             MsgAviso("Selecione uma fase v" + CHR(225) + "lida.", "FormProduto")
13235:             RETURN
13236:         ENDIF
13237: 
13238:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13239: 
13240:         TRY
13241:             *-- Verificar se ja tem imagem
13242:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13243:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13244:                 FROM SigCdPrf
13245:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13246:             ENDTEXT
13247:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13248:             LOCAL loc_lTemFig
13249:             loc_lTemFig = .F.
13250:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13251:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13252:             ENDIF
13253:             IF USED("cursor_4c_VerFig")
13254:                 USE IN cursor_4c_VerFig
13255:             ENDIF
13256: 
13257:             IF loc_lTemFig
13258:                 *-- Oferecer opcoes: substituir ou remover
13259:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13260:                 IF loc_lConfirma
13261:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13262:                         UPDATE SigCdPrf SET FigProcs = NULL
13263:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13264:                     ENDTEXT
13265:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13266:                     IF loc_nR > 0
13267:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13268:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13269:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13270:                         ENDIF
13271:                         MsgInfo("Imagem removida.", "FormProduto")
13272:                     ENDIF
13273:                     RETURN
13274:                 ENDIF

*-- Linhas 13314 a 13674:
13314:     * CmdgFigCamClick - Carregar/remover imagem de borracha (camera/molde)
13315:     * Equivalente ao cmdgFigCam do legado: camera para imagem da borracha
13316:     *--------------------------------------------------------------------------
13317:     PROCEDURE CmdgFigCamClick()
13318:         LOCAL loc_cCmats, loc_cSQL, loc_nR, loc_cArquivo, loc_cFig, loc_oPg
13319: 
13320:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13321:             RETURN
13322:         ENDIF
13323: 
13324:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
13325:             MsgAviso("Selecione uma matriz para carregar a imagem.", "FormProduto")
13326:             RETURN
13327:         ENDIF
13328: 
13329:         loc_cCmats = ALLTRIM(NVL(cursor_4c_Matrizes.cmats, ""))
13330:         IF EMPTY(loc_cCmats)
13331:             MsgAviso("Selecione uma matriz v" + CHR(225) + "lida.", "FormProduto")
13332:             RETURN
13333:         ENDIF
13334: 
13335:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13336: 
13337:         TRY
13338:             *-- Selecionar arquivo de imagem
13339:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Borracha:")
13340:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13341:                 RETURN
13342:             ENDIF
13343: 
13344:             *-- Converter para Base64 e salvar em SigCdPro.FigJpgs
13345:             LOCAL loc_cBinImg, loc_cB64
13346:             loc_cBinImg = FILETOSTR(loc_cFig)
13347:             IF EMPTY(loc_cBinImg)
13348:                 MsgErro("Falha ao ler arquivo de imagem.", "FormProduto.CmdgFigCamClick")
13349:                 RETURN
13350:             ENDIF
13351: 
13352:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13353: 
13354:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13355:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13356:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13357:             ENDTEXT
13358:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13359:             IF loc_nR > 0
13360:                 *-- Exibir imagem
13361:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13362:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13363:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13364:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13365:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13366:                 ENDIF
13367:             ELSE
13368:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13369:             ENDIF
13370: 
13371:         CATCH TO loc_oErro
13372:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13373:         ENDTRY
13374:     ENDPROC
13375: 
13376:     *--------------------------------------------------------------------------
13377:     * BtnInserirMatrizClick - Inserir nova linha na grade de matrizes (SigPrMtz)
13378:     *--------------------------------------------------------------------------
13379:     PROCEDURE BtnInserirMatrizClick()
13380:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
13381: 
13382:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13383:             MsgAviso("Salve ou edite o produto antes de inserir matrizes.", "FormProduto")
13384:             RETURN
13385:         ENDIF
13386: 
13387:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13388:         IF EMPTY(loc_cCpros)
13389:             MsgAviso("Produto n" + CHR(227) + "o identificado.", "FormProduto")
13390:             RETURN
13391:         ENDIF
13392: 
13393:         TRY
13394:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13395:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13396:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13397:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13398:             ENDTEXT
13399:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13400:             IF loc_nR > 0
13401:                 THIS.CarregarMatrizes()
13402:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13403:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13404:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13405:                 ENDIF
13406:             ELSE
13407:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13408:             ENDIF
13409:         CATCH TO loc_oErro
13410:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13411:         ENDTRY
13412:     ENDPROC
13413: 
13414:     *--------------------------------------------------------------------------
13415:     * BtnExcluirMatrizClick - Excluir linha selecionada da grade de matrizes
13416:     *--------------------------------------------------------------------------
13417:     PROCEDURE BtnExcluirMatrizClick()
13418:         LOCAL loc_cCpros, loc_cCidChaves, loc_cSQL, loc_nR, loc_lConfirma
13419: 
13420:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13421:             RETURN
13422:         ENDIF
13423: 
13424:         IF NOT USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes") OR BOF("cursor_4c_Matrizes")
13425:             MsgAviso("Selecione uma matriz para excluir.", "FormProduto")
13426:             RETURN
13427:         ENDIF
13428: 
13429:         loc_cCpros     = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
13430:         loc_cCidChaves = ALLTRIM(NVL(cursor_4c_Matrizes.cidchaves, ""))
13431: 
13432:         IF EMPTY(loc_cCidChaves)
13433:             MsgAviso("Selecione uma linha v" + CHR(225) + "lida para excluir.", "FormProduto")
13434:             RETURN
13435:         ENDIF
13436: 
13437:         loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o desta matriz?", "FormProduto")
13438:         IF !loc_lConfirma
13439:             RETURN
13440:         ENDIF
13441: 
13442:         TRY
13443:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13444:                 DELETE FROM SigPrMtz
13445:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13446:             ENDTEXT
13447:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13448:             IF loc_nR > 0
13449:                 THIS.CarregarMatrizes()
13450:             ELSE
13451:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13452:             ENDIF
13453:         CATCH TO loc_oErro
13454:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13455:         ENDTRY
13456:     ENDPROC
13457: 
13458:     *--------------------------------------------------------------------------
13459:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13460:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13461:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13462:     *--------------------------------------------------------------------------
13463:     PROCEDURE DesignerGrd_AfterRowColChange(par_nColIndex)
13464:         LOCAL loc_oPg, loc_cCodTarefa, loc_cDesTarefa
13465:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13466: 
13467:         TRY
13468:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13469:                 loc_cCodTarefa = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13470:                 loc_cDesTarefa = ""
13471: 
13472:                 *-- Buscar descricao no cursor de tarefas
13473:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13474:                     SELECT cursor_4c_Tarefas
13475:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13476:                     IF !EOF("cursor_4c_Tarefas")
13477:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13478:                     ENDIF
13479:                 ENDIF
13480: 
13481:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13482:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13483:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13484:                 ENDIF
13485:             ENDIF
13486:         CATCH TO loc_oErro
13487:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13488:         ENDTRY
13489:     ENDPROC
13490: 
13491:     *--------------------------------------------------------------------------
13492:     * ArquivosGrd_AfterRowColChange - Grid arquivos: ao navegar linha/coluna
13493:     * Exibe preview de imagem em img_4c_ImgArqJpg se arquivo for JPG/ICO/BMP/JPEG
13494:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13495:     *--------------------------------------------------------------------------
13496:     PROCEDURE ArquivosGrd_AfterRowColChange(par_nColIndex)
13497:         LOCAL loc_oPg, loc_cArq, loc_cExt
13498:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13499: 
13500:         TRY
13501:             IF !PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
13502:                 RETURN
13503:             ENDIF
13504: 
13505:             *-- Limpar preview
13506:             CLEAR RESOURCES
13507:             loc_oPg.img_4c_ImgArqJpg.Picture = ""
13508:             loc_oPg.img_4c_ImgArqJpg.Visible = .F.
13509: 
13510:             IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13511:                 loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13512: 
13513:                 IF !EMPTY(loc_cArq)
13514:                     loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
13515: 
13516:                     IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
13517:                         loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArq
13518:                         loc_oPg.img_4c_ImgArqJpg.Visible = .T.
13519:                     ENDIF
13520:                 ENDIF
13521:             ENDIF
13522:         CATCH TO loc_oErro
13523:             MsgErro(loc_oErro.Message, "FormProduto.ArquivosGrd_AfterRowColChange")
13524:         ENDTRY
13525:     ENDPROC
13526: 
13527:     *--------------------------------------------------------------------------
13528:     * GrdDesignerColReadOnlyWhen - Colunas 1/2/3 do grd_4c_Designer: sempre somente leitura
13529:     * Retorna .F. para bloquear edicao (original: Return .f.)
13530:     *--------------------------------------------------------------------------
13531:     PROCEDURE GrdDesignerColReadOnlyWhen()
13532:         RETURN .F.
13533:     ENDPROC
13534: 
13535:     *--------------------------------------------------------------------------
13536:     * GrdDesignerCol4When - Column4 do grd_4c_Designer (Tarefa): editavel condicionalmente
13537:     * Editavel apenas em INSERIR/ALTERAR, para o usuario atual, sem DtFims
13538:     * Original: Return InList(pcEscolha, INSERIR, ALTERAR) And Usuars=Usuar And IsEmpty(DtFims)
13539:     *--------------------------------------------------------------------------
13540:     PROCEDURE GrdDesignerCol4When()
13541:         LOCAL loc_lEditavel, loc_cUsuars, loc_cDtFims
13542: 
13543:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13544:             RETURN .F.
13545:         ENDIF
13546: 
13547:         IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13548:             loc_cUsuars = ALLTRIM(NVL(cursor_4c_Designer.usuars, ""))
13549:             loc_cDtFims = NVL(cursor_4c_Designer.dtfims, {})
13550: 
13551:             IF loc_cUsuars <> ALLTRIM(gc_4c_UsuarioLogado)
13552:                 RETURN .F.
13553:             ENDIF
13554: 
13555:             IF !EMPTY(loc_cDtFims)
13556:                 RETURN .F.
13557:             ENDIF
13558: 
13559:             RETURN .T.
13560:         ENDIF
13561: 
13562:         RETURN .F.
13563:     ENDPROC
13564: 
13565:     *--------------------------------------------------------------------------
13566:     * GrdDesignerCol4Valid - Column4 do grd_4c_Designer: valida/lookup de tarefa
13567:     * Se cursor_4c_Tarefas tem dados: valida codigo; se nao encontrado, limpa campo
13568:     * Se cursor_4c_Tarefas vazio (tabela SigPrTrf inexistente): aceita qualquer valor
13569:     * Original: fwBuscaInt em crTarefas (CodCads/DesCads)
13570:     *--------------------------------------------------------------------------
13571:     PROCEDURE GrdDesignerCol4Valid()
13572:         LOCAL loc_oPg, loc_cValor, loc_cCodTarefa, loc_cDesTarefa, loc_lEncontrou
13573:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13574: 
13575:         TRY
13576:             *-- Obter valor atual da celula via cursor_4c_Designer
13577:             loc_cValor = ""
13578:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13579:                 loc_cValor = ALLTRIM(NVL(cursor_4c_Designer.tarefas, ""))
13580:             ENDIF
13581: 
13582:             IF EMPTY(loc_cValor)
13583:                 loc_lResultado = .T.
13584:             ENDIF
13585: 
13586:             *-- Cursor de tarefas vazio: tabela mestre nao disponivel, aceitar qualquer valor
13587:             IF !USED("cursor_4c_Tarefas") OR RECCOUNT("cursor_4c_Tarefas") = 0
13588:                 loc_lResultado = .T.
13589:             ENDIF
13590: 
13591:             *-- Verificar se codigo existe no cursor de tarefas
13592:             loc_lEncontrou = .F.
13593:             loc_cCodTarefa = ""
13594:             loc_cDesTarefa = ""
13595: 
13596:             SELECT cursor_4c_Tarefas
13597:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13598:             IF !EOF("cursor_4c_Tarefas")
13599:                 loc_lEncontrou = .T.
13600:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13601:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13602:             ENDIF
13603: 
13604:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13605:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13606:                 IF loc_lEncontrou
13607:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13608:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13609:                     ENDIF
13610:                 ELSE
13611:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")
13612:                     REPLACE cursor_4c_Designer.tarefas WITH ""
13613:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13614:                         loc_oPg.txt_4c_ObsTarefas.Value = ""
13615:                     ENDIF
13616:                 ENDIF
13617:             ENDIF
13618: 
13619:         CATCH TO loc_oErro
13620:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4Valid")
13621:         ENDTRY
13622: 
13623:         RETURN .T.
13624:     ENDPROC
13625: 
13626:     *--------------------------------------------------------------------------
13627:     * GrdDesignerCol4LostFocus - Column4 perde foco: navega para txt_4c_ObsTarefas ao Enter
13628:     * Original: If Not Empty(This.Value) And (Lastkey()=13) -> getObsTarefas.SetFocus
13629:     *--------------------------------------------------------------------------
13630:     PROCEDURE GrdDesignerCol4LostFocus()
13631:         LOCAL loc_oPg
13632:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
13633: 
13634:         TRY
13635:             IF LASTKEY() = 13
13636:                 IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13637:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Designer.tarefas, "")))
13638:                         IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13639:                             loc_oPg.txt_4c_ObsTarefas.SetFocus()
13640:                         ENDIF
13641:                     ENDIF
13642:                 ENDIF
13643:             ENDIF
13644:         CATCH TO loc_oErro
13645:             MsgErro(loc_oErro.Message, "FormProduto.GrdDesignerCol4LostFocus")
13646:         ENDTRY
13647:     ENDPROC
13648: 
13649:     *--------------------------------------------------------------------------
13650:     * GrdArquivosCol1When - Column1 do grd_4c_Arquivos: editavel em INCLUIR/ALTERAR
13651:     * Original: Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
13652:     *--------------------------------------------------------------------------
13653:     PROCEDURE GrdArquivosCol1When()
13654:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
13655:     ENDPROC
13656: 
13657:     *--------------------------------------------------------------------------
13658:     * ImgArqJpgClick - Clique na imagem: exibe caminho do arquivo
13659:     * Original: Do Form SigOpZom (zoom view) - forma simplificada: exibe path
13660:     *--------------------------------------------------------------------------
13661:     PROCEDURE ImgArqJpgClick()
13662:         LOCAL loc_cArq
13663:         loc_cArq = ""
13664: 
13665:         IF USED("cursor_4c_Arquivos") AND !EOF("cursor_4c_Arquivos")
13666:             loc_cArq = ALLTRIM(NVL(cursor_4c_Arquivos.arquivos, ""))
13667:         ENDIF
13668: 
13669:         IF !EMPTY(loc_cArq)
13670:             MsgAviso(loc_cArq, "Arquivo Selecionado")
13671:         ENDIF
13672:     ENDPROC
13673: 
13674: ENDDEFINE

