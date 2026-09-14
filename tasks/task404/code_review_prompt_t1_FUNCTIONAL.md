# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_PAGE3, CNT_4C_PAGE4. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'OpcaoCPFCGC' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page1): Top original=137 vs migrado 'obj_4c_OpcaoCPFCGC' Top=0 (diff=137px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpcaoCPFCGC' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page1): Left original=269 vs migrado 'obj_4c_OpcaoCPFCGC' Left=0 (diff=269px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_comis' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=215 vs migrado 'obj_4c_Opc_comis' Top=0 (diff=215px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_comis' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=698 vs migrado 'obj_4c_Opc_comis' Left=0 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OPT_ALTTRANS' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=256 vs migrado 'obj_4c_OPT_ALTTRANS' Top=0 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OPT_ALTTRANS' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=698 vs migrado 'obj_4c_OPT_ALTTRANS' Left=0 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OPTCALCCUSTOS' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=235 vs migrado 'obj_4c_OPTCALCCUSTOS' Top=0 (diff=235px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OPTCALCCUSTOS' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=699 vs migrado 'obj_4c_OPTCALCCUSTOS' Left=0 (diff=699px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=270 vs migrado 'obj_4c_Optiongroup1' Top=0 (diff=270px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=698 vs migrado 'obj_4c_Optiongroup1' Left=0 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=201 vs migrado 'obj_4c_Optiongroup2' Top=0 (diff=201px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup2' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=698 vs migrado 'obj_4c_Optiongroup2' Left=0 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=295 vs migrado 'lbl_4c_Label5b' Top=473 (diff=178px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=508 vs migrado 'lbl_4c_Label5b' Left=300 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_blqdt' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Top original=291 vs migrado 'obj_4c_Op_blqdt' Top=0 (diff=291px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_blqdt' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page2): Left original=698 vs migrado 'obj_4c_Op_blqdt' Left=0 (diff=698px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkAnaVends' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page3): Top original=577 vs migrado 'chk_4c_ChkAnaVends' Top=266 (diff=311px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkAnaVends' (parent: SIGCDEMP.Pagina.Dados.PgDados.Page3): Left original=56 vs migrado 'chk_4c_ChkAnaVends' Left=646 (diff=590px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formemp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (6165 linhas total):

*-- Linhas 2 a 160:
2: * Formemp.prg - Formulario de Cadastro de Empresas
3: * Migrado de: SIGCDEMP.SCX (frmcadastro)
4: * Estrutura especial: Page2 (Dados) contem 4 sub-containers controlados por
5: * opt_4c_Guia (OptionGroup como seletor visual de sub-paginas)
6: *==============================================================================
7: 
8: DEFINE CLASS Formemp AS FormBase
9: 
10:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
11:     Height      = 600
12:     Width       = 1000
13:     Caption     = "Cadastro de Empresas"
14:     AutoCenter  = .T.
15:     ShowWindow  = 1
16:     WindowType  = 1
17:     ControlBox  = .F.
18:     TitleBar    = 0
19:     Themes      = .F.
20:     BorderStyle = 2
21: 
22:     *-- Propriedades de estado
23:     this_oBusinessObject = .NULL.
24:     this_cModoAtual      = "LISTA"
25:     this_nSubPagina      = 1
26: 
27:     *===========================================================================
28:     * Init - Inicializa o formulario
29:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
30:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
31:     *===========================================================================
32:     PROCEDURE Init()
33:         RETURN DODEFAULT()
34:     ENDPROC
35: 
36:     *===========================================================================
37:     * InicializarForm - Configura estrutura completa
38:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
39:     *===========================================================================
40:     PROTECTED PROCEDURE InicializarForm()
41:         LOCAL loc_lSucesso
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.this_oBusinessObject = CREATEOBJECT("empBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar empBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "Formemp.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Visible = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 
66:         CATCH TO loException
67:             MostrarErro("Erro ao inicializar Formemp:" + CHR(13) + ;
68:                 loException.Message + CHR(13) + ;
69:                 "Linha: " + TRANSFORM(loException.LineNo), ;
70:                 "Formemp.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *===========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Top=-29 para esconder abas; controles compensam +29 no Top
79:     *===========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82: 
83:         WITH THIS.pgf_4c_Paginas
84:             .PageCount = 2
85:             .Top       = -29
86:             .Left      = 0
87:             .Width     = THIS.Width
88:             .Height    = THIS.Height + 29
89:             .Tabs      = .F.
90:             .Visible   = .T.
91: 
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(255, 255, 255)
95: 
96:             .Page2.Caption   = "Dados"
97:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page2.BackColor = RGB(255, 255, 255)
99:         ENDWITH
100: 
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *===========================================================================
106:     * ConfigurarPaginaLista - Configura Page1 com cabecalho, containers e saida
107:     * Grid e botoes CRUD adicionados na Fase 4
108:     *===========================================================================
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114: 
115:         *-- Container Cabecalho (cntSombra no legado)
116:         *-- Original Top=1; com compensacao +29: Top=31
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(255, 255, 255)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         *-- Container Botoes CRUD

*-- Linhas 192 a 412:
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Tahoma"
208:             .FontSize        = 8
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .FontName        = "Tahoma"
233:             .FontSize        = 8
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .ForeColor       = RGB(90, 90, 90)
237:             .BackColor       = RGB(255, 255, 255)
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .FontName        = "Tahoma"
258:             .FontSize        = 8
259:             .FontBold        = .T.
260:             .FontItalic      = .T.
261:             .ForeColor       = RGB(90, 90, 90)
262:             .BackColor       = RGB(255, 255, 255)
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         *-- Botao Buscar
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .FontName        = "Tahoma"
283:             .FontSize        = 8
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .ForeColor       = RGB(90, 90, 90)
287:             .BackColor       = RGB(255, 255, 255)
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .FontName        = "Tahoma"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .ForeColor       = RGB(90, 90, 90)
323:             .BackColor       = RGB(255, 255, 255)
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista de empresas
334:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
335:         WITH loc_oPagina.grd_4c_Lista
336:             .Top               = 127
337:             .Left              = 20
338:             .Width             = 939
339:             .Height            = 484
340:             .ColumnCount       = 6
341:             .RecordSourceType  = 1
342:             .ReadOnly          = .T.
343:             .DeleteMark        = .F.
344:             .RecordMark        = .F.
345:             .ScrollBars        = 3
346:             .GridLines         = 3
347:             .AllowHeaderSizing = .T.
348:             .FontName          = "Tahoma"
349:             .FontSize          = 8
350:             .GridLineColor     = RGB(238, 238, 238)
351:             .Visible           = .T.
352:         ENDWITH
353: 
354:         THIS.TornarControlesVisiveis(loc_oPagina)
355:     ENDPROC
356: 
357:     *===========================================================================
358:     * ConfigurarPaginaDados - Configura Page2: opt_4c_Guia + 4 sub-containers
359:     * Arquitetura especial: optGuia (OptionGroup 4 botoes) seleciona qual
360:     * sub-container (cnt_4c_Page1..4) fica visivel
361:     * Botoes CRUD de edicao e campos de dados adicionados nas Fases 4-6
362:     *===========================================================================
363:     PROTECTED PROCEDURE ConfigurarPaginaDados()
364:         LOCAL loc_oPagina
365:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
366: 
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- opt_4c_Guia - OptionGroup como seletor visual de sub-paginas
370:         *-- Original: optGuia.Top=-4, Left=24, Width=712, Height=85 (class=fwselpagina)
371:         *-- Com compensacao +29: Top=25
372:         loc_oPagina.AddObject("opt_4c_Guia", "OptionGroup")
373:         loc_oPagina.opt_4c_Guia.ButtonCount = 4
374:         WITH loc_oPagina.opt_4c_Guia
375:             .Top         = 25
376:             .Left        = 24
377:             .Width       = 712
378:             .Height      = 85
379:             .BackStyle   = 0
380:             .BorderStyle = 0
381:             .Value       = 1
382:             .Visible     = .T.
383:             WITH .Buttons(1)
384:                 .Caption       = "Dados"
385:                 .Left          = 0
386:                 .Top           = 0
387:                 .Width         = 178
388:                 .Height        = 85
389:                 .Themes        = .F.
390:                 .SpecialEffect = 0
391:                 .FontBold      = .T.
392:             ENDWITH
393:             WITH .Buttons(2)
394:                 .Caption       = "Operacional"
395:                 .Left          = 178
396:                 .Top           = 0
397:                 .Width         = 178
398:                 .Height        = 85
399:                 .Themes        = .F.
400:                 .SpecialEffect = 0
401:                 .FontName      = "Tahoma"
402:                 .FontSize      = 8
403:                 .FontBold      = .T.
404:             ENDWITH
405:             WITH .Buttons(3)
406:                 .Caption       = "Fiscal"
407:                 .Left          = 356
408:                 .Top           = 0
409:                 .Width         = 178
410:                 .Height        = 85
411:                 .Themes        = .F.
412:                 .SpecialEffect = 0

*-- Linhas 427 a 569:
427:                 .FontBold      = .T.
428:             ENDWITH
429:         ENDWITH
430:         BINDEVENT(loc_oPagina.opt_4c_Guia, "Click", THIS, "GuiaClick")
431: 
432:         *-- Container BotoesAcao (Confirmar/Cancelar)
433:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
434:         WITH loc_oPagina.cnt_4c_BotoesAcao
435:             .Top         = 29
436:             .Left        = 737
437:             .Width       = 178
438:             .Height      = 85
439:             .BackStyle = 0
440:             .BackColor   = RGB(255, 255, 255)
441:             .BorderWidth = 0
442:             .Visible     = .T.
443:         ENDWITH
444: 
445:         *-- Botao Confirmar
446:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
447:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
448:             .Caption         = "Confirmar"
449:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
450:             .PicturePosition = 13
451:             .Top             = 5
452:             .Left            = 5
453:             .Width           = 75
454:             .Height          = 75
455:             .FontName        = "Tahoma"
456:             .FontSize        = 8
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .ForeColor       = RGB(90, 90, 90)
460:             .BackColor       = RGB(255, 255, 255)
461:             .Themes          = .F.
462:             .SpecialEffect   = 0
463:             .MousePointer    = 15
464:             .WordWrap        = .T.
465:             .AutoSize        = .F.
466:             .Visible         = .T.
467:         ENDWITH
468:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
469: 
470:         *-- Botao Cancelar
471:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
472:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
473:             .Caption         = "Encerrar"
474:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
475:             .PicturePosition = 13
476:             .Top             = 5
477:             .Left            = 90
478:             .Width           = 75
479:             .Height          = 75
480:             .FontName        = "Tahoma"
481:             .FontSize        = 8
482:             .FontBold        = .T.
483:             .FontItalic      = .T.
484:             .ForeColor       = RGB(90, 90, 90)
485:             .BackColor       = RGB(255, 255, 255)
486:             .Themes          = .F.
487:             .SpecialEffect   = 0
488:             .MousePointer    = 15
489:             .WordWrap        = .T.
490:             .AutoSize        = .F.
491:             .Visible         = .T.
492:         ENDWITH
493:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
494: 
495:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
496:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
497:         WITH loc_oPagina.cnt_4c_Saida
498:             .Top         = 29
499:             .Left        = 917
500:             .Width       = 90
501:             .Height      = 85
502:             .BackStyle   = 0
503:             .BorderWidth = 0
504:             .Visible     = .T.
505:         ENDWITH
506: 
507:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
508:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
509:             .Caption         = "Encerrar"
510:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
511:             .PicturePosition = 13
512:             .Top             = 5
513:             .Left            = 5
514:             .Width           = 75
515:             .Height          = 75
516:             .FontName        = "Tahoma"
517:             .FontBold        = .T.
518:             .FontItalic      = .T.
519:             .FontSize        = 8
520:             .ForeColor       = RGB(90, 90, 90)
521:             .BackColor       = RGB(255, 255, 255)
522:             .Themes          = .F.
523:             .SpecialEffect   = 0
524:             .MousePointer    = 15
525:             .WordWrap        = .T.
526:             .AutoSize        = .F.
527:             .Visible         = .T.
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
530: 
531:         *-- Sub-containers mapeiam PgDados.Page1-4 do legado
532:         *-- opt_4c_Guia ocupa Top=25 a Top+Height=110
533:         *-- Containers comecam em Top=110 (Page2 interna tem 629px total)
534:         *-- Height=519 cobre Top=110 ate o final da Page2 (110+519=629)
535: 
536:         loc_oPagina.AddObject("cnt_4c_Page1", "Container")
537:         WITH loc_oPagina.cnt_4c_Page1
538:             .Top         = 110
539:             .Left        = 0
540:             .Width       = THIS.Width
541:             .Height      = 519
542:             .BackStyle   = 0
543:             .BorderWidth = 0
544:             .Visible     = .T.
545:         ENDWITH
546: 
547:         *-- Preencher cnt_4c_Page1 com campos da primeira metade (Fase 5)
548:         THIS.ConfigurarSubPage1(loc_oPagina)
549: 
550:         loc_oPagina.AddObject("cnt_4c_Page2", "Container")
551:         WITH loc_oPagina.cnt_4c_Page2
552:             .Top         = 110
553:             .Left        = 0
554:             .Width       = THIS.Width
555:             .Height      = 519
556:             .BackStyle   = 0
557:             .BorderWidth = 0
558:             .Visible     = .F.
559:         ENDWITH
560:         THIS.ConfigurarSubPage2(loc_oPagina)
561: 
562:         loc_oPagina.AddObject("cnt_4c_Page3", "Container")
563:         WITH loc_oPagina.cnt_4c_Page3
564:             .Top         = 110
565:             .Left        = 0
566:             .Width       = THIS.Width
567:             .Height      = 519
568:             .BackStyle   = 0
569:             .BorderWidth = 0

*-- Linhas 583 a 1038:
583:         ENDWITH
584:         THIS.ConfigurarSubPage4(loc_oPagina)
585: 
586:         THIS.TornarControlesVisiveis(loc_oPagina)
587: 
588:         *-- Garantir que apenas cnt_4c_Page1 fica visivel apos TornarControlesVisiveis
589:         *-- (TCV seta tudo Visible=.T.; restaurar estado correto dos sub-containers)
590:         THIS.AlternarSubPagina(1)
591:         IF PEMSTATUS(loc_oPagina, "opt_4c_Guia", 5)
592:             loc_oPagina.opt_4c_Guia.Value = 1
593:         ENDIF
594:     ENDPROC
595: 
596:     *===========================================================================
597:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
598:     *===========================================================================
599:     PROCEDURE AlternarPagina(par_nPagina)
600:         LOCAL loc_lResultado
601:         loc_lResultado = .F.
602: 
603:         TRY
604:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
605:                 MostrarErro("Par" + CHR(226) + "metro inv" + CHR(225) + "lido para AlternarPagina: " + ;
606:                     TRANSFORM(par_nPagina), "Formemp.AlternarPagina")
607:             ELSE
608:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
609:                 loc_lResultado = .T.
610:             ENDIF
611:         CATCH TO loException
612:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
613:                 loException.Message, "Formemp.AlternarPagina")
614:         ENDTRY
615: 
616:         RETURN loc_lResultado
617:     ENDPROC
618: 
619:     *===========================================================================
620:     * AlternarSubPagina - Mostra sub-container N (1-4) em Page2, esconde os demais
621:     * Chamado por GuiaClick e programaticamente na validacao
622:     *===========================================================================
623:     PROCEDURE AlternarSubPagina(par_nSubPagina)
624:         LOCAL loc_oPagina, loc_lResultado
625:         loc_lResultado = .F.
626: 
627:         TRY
628:             IF VARTYPE(par_nSubPagina) != "N" OR par_nSubPagina < 1 OR par_nSubPagina > 4
629:                 MostrarErro("Sub-p" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
630:                     TRANSFORM(par_nSubPagina), "Formemp.AlternarSubPagina")
631:             ELSE
632:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
633: 
634:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Page1", 5)
635:                     loc_oPagina.cnt_4c_Page1.Visible = (par_nSubPagina = 1)
636:                 ENDIF
637:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Page2", 5)
638:                     loc_oPagina.cnt_4c_Page2.Visible = (par_nSubPagina = 2)
639:                 ENDIF
640:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Page3", 5)
641:                     loc_oPagina.cnt_4c_Page3.Visible = (par_nSubPagina = 3)
642:                 ENDIF
643:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_Page4", 5)
644:                     loc_oPagina.cnt_4c_Page4.Visible = (par_nSubPagina = 4)
645:                 ENDIF
646: 
647:                 THIS.this_nSubPagina = par_nSubPagina
648:                 loc_lResultado = .T.
649:             ENDIF
650:         CATCH TO loException
651:             MostrarErro("Erro ao alternar sub-p" + CHR(225) + "gina:" + CHR(13) + ;
652:                 loException.Message, "Formemp.AlternarSubPagina")
653:         ENDTRY
654: 
655:         RETURN loc_lResultado
656:     ENDPROC
657: 
658:     *===========================================================================
659:     * GuiaClick - Handler do Click em opt_4c_Guia
660:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
661:     *===========================================================================
662:     PROCEDURE GuiaClick()
663:         LOCAL loc_oPagina, loc_nSub
664:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
665:         loc_nSub    = 1
666: 
667:         TRY
668:             IF PEMSTATUS(loc_oPagina, "opt_4c_Guia", 5)
669:                 loc_nSub = loc_oPagina.opt_4c_Guia.Value
670:                 IF VARTYPE(loc_nSub) != "N" OR loc_nSub < 1 OR loc_nSub > 4
671:                     loc_nSub = 1
672:                 ENDIF
673:                 THIS.AlternarSubPagina(loc_nSub)
674:             ENDIF
675:         CATCH TO loException
676:             MostrarErro("Erro ao selecionar guia:" + CHR(13) + loException.Message, ;
677:                 "Formemp.GuiaClick")
678:         ENDTRY
679:     ENDPROC
680: 
681:     *===========================================================================
682:     * CarregarLista - Executa query e vincula grid
683:     *===========================================================================
684:     PROCEDURE CarregarLista()
685:         LOCAL loc_lResultado, loc_oGrid
686:         loc_lResultado = .F.
687: 
688:         TRY
689:             IF !THIS.this_oBusinessObject.Buscar("")
690:                 MsgErro("Erro ao carregar lista de empresas.", "Formemp")
691:             ELSE
692:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
693: 
694:                 loc_oGrid.ColumnCount  = 6
695:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
696: 
697:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cemps"
698:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.nemps"
699:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.razsocs"
700:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.razas"
701:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cgcs"
702:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.ativas"
703: 
704:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
705:                 loc_oGrid.Column2.Header1.Caption = "N" + CHR(250) + "mero"
706:                 loc_oGrid.Column3.Header1.Caption = "Raz. Social"
707:                 loc_oGrid.Column4.Header1.Caption = "Nome Fantasia"
708:                 loc_oGrid.Column5.Header1.Caption = "CNPJ"
709:                 loc_oGrid.Column6.Header1.Caption = "Ativo"
710: 
711:                 THIS.FormatarGridLista(loc_oGrid)
712:                 loc_oGrid.Refresh()
713:                 loc_lResultado = .T.
714:             ENDIF
715:         CATCH TO loException
716:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
717:                 "Formemp.CarregarLista")
718:         ENDTRY
719: 
720:         RETURN loc_lResultado
721:     ENDPROC
722: 
723:     *===========================================================================
724:     * BtnEncerrarClick - Fecha o formulario
725:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md regra #3)
726:     *===========================================================================
727:     PROCEDURE BtnEncerrarClick()
728:         THIS.Release()
729:     ENDPROC
730: 
731:     *===========================================================================
732:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
733:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
734:     *===========================================================================
735:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
736:         LOCAL loc_nI, loc_oObjeto, loc_nP
737: 
738:         FOR loc_nI = 1 TO par_oContainer.ControlCount
739:             loc_oObjeto = par_oContainer.Controls(loc_nI)
740: 
741:             IF VARTYPE(loc_oObjeto) = "O"
742:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
743:                     loc_oObjeto.Visible = .T.
744:                 ENDIF
745: 
746:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
747:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
748:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
749:                     ENDFOR
750:                 ENDIF
751: 
752:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
753:                     THIS.TornarControlesVisiveis(loc_oObjeto)
754:                 ENDIF
755:             ENDIF
756:         ENDFOR
757:     ENDPROC
758: 
759:     *===========================================================================
760:     * FormatarGridLista - Formata visual do grid de lista
761:     *===========================================================================
762:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
763:         TRY
764:             WITH par_oGrid
765:                 .FontName     = "Tahoma"
766:                 .FontSize     = 8
767:                 .HeaderHeight = 22
768:                 .RowHeight    = 18
769:             ENDWITH
770: 
771:             WITH par_oGrid.Column1
772:                 .Width     = 50
773:                 .Alignment = 0
774:             ENDWITH
775:             WITH par_oGrid.Column2
776:                 .Width     = 60
777:                 .Alignment = 0
778:             ENDWITH
779:             WITH par_oGrid.Column3
780:                 .Width     = 150
781:                 .Alignment = 0
782:             ENDWITH
783:             WITH par_oGrid.Column4
784:                 .Width     = 340
785:                 .Alignment = 0
786:             ENDWITH
787:             WITH par_oGrid.Column5
788:                 .Width     = 130
789:                 .Alignment = 0
790:             ENDWITH
791:             WITH par_oGrid.Column6
792:                 .Width     = 60
793:                 .Alignment = 0
794:             ENDWITH
795: 
796:         CATCH TO loException
797:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
798:                 "Formemp.FormatarGridLista")
799:         ENDTRY
800:     ENDPROC
801: 
802:     *===========================================================================
803:     * CRUD Handlers - PUBLIC (BINDEVENT requer metodo publico, CLAUDE.md regra #3)
804:     *===========================================================================
805: 
806:     PROCEDURE BtnIncluirClick()
807:         TRY
808:             THIS.this_oBusinessObject.NovoRegistro()
809:             THIS.this_cModoAtual = "INCLUIR"
810:             THIS.LimparCampos()
811:             THIS.HabilitarCampos(.T.)
812:             THIS.AjustarBotoesPorModo()
813:             THIS.AlternarPagina(2)
814:         CATCH TO loc_oErro
815:             MsgErro(loc_oErro.Message, "Formemp.BtnIncluirClick")
816:         ENDTRY
817:     ENDPROC
818: 
819:     PROCEDURE BtnVisualizarClick()
820:         LOCAL loc_cCodigo
821:         TRY
822:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
823:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
824:             ELSE
825:                 SELECT cursor_4c_Dados
826:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cemps)
827:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
828:                     THIS.this_cModoAtual = "VISUALIZAR"
829:                     THIS.BOParaForm()
830:                     THIS.HabilitarCampos(.F.)
831:                     THIS.AjustarBotoesPorModo()
832:                     THIS.AlternarPagina(2)
833:                 ENDIF
834:             ENDIF
835:         CATCH TO loc_oErro
836:             MsgErro(loc_oErro.Message, "Formemp.BtnVisualizarClick")
837:         ENDTRY
838:     ENDPROC
839: 
840:     PROCEDURE BtnAlterarClick()
841:         LOCAL loc_cCodigo
842:         TRY
843:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
844:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
845:             ELSE
846:                 SELECT cursor_4c_Dados
847:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cemps)
848:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
849:                     THIS.this_oBusinessObject.EditarRegistro()
850:                     THIS.this_cModoAtual = "ALTERAR"
851:                     THIS.BOParaForm()
852:                     THIS.HabilitarCampos(.T.)
853:                     THIS.AjustarBotoesPorModo()
854:                     THIS.AlternarPagina(2)
855:                 ENDIF
856:             ENDIF
857:         CATCH TO loc_oErro
858:             MsgErro(loc_oErro.Message, "Formemp.BtnAlterarClick")
859:         ENDTRY
860:     ENDPROC
861: 
862:     PROCEDURE BtnExcluirClick()
863:         LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
864:         TRY
865:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
866:                 MsgAviso("Selecione uma empresa na lista.", "Aten" + CHR(231) + CHR(227) + "o")
867:             ELSE
868:                 SELECT cursor_4c_Dados
869:                 loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cemps)
870:                 loc_cDescricao = ALLTRIM(cursor_4c_Dados.razas)
871: 
872:                 IF loc_cCodigo == ALLTRIM(go_4c_Sistema.cCodEmpresa)
873:                     MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel excluir" + CHR(13) + ;
874:                         "a empresa corrente.", "Aten" + CHR(231) + CHR(227) + "o")
875:                 ELSE
876:                     loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da empresa" + CHR(13) + ;
877:                         loc_cCodigo + " - " + loc_cDescricao + "?", ;
878:                         "Confirmar Exclus" + CHR(227) + "o")
879: 
880:                     IF loc_lConfirma
881:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
882:                             IF THIS.this_oBusinessObject.Excluir()
883:                                 MsgInfo("Empresa exclu" + CHR(237) + "da com sucesso!", "Sucesso")
884:                                 THIS.CarregarLista()
885:                             ENDIF
886:                         ENDIF
887:                     ENDIF
888:                 ENDIF
889:             ENDIF
890:         CATCH TO loc_oErro
891:             MsgErro(loc_oErro.Message, "Formemp.BtnExcluirClick")
892:         ENDTRY
893:     ENDPROC
894: 
895:     PROCEDURE BtnBuscarClick()
896:         LOCAL loc_oBusca, loc_cFiltro, loc_oGrid
897:         TRY
898:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
899:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", "", "Buscar Empresa")
900: 
901:             IF VARTYPE(loc_oBusca) = "O"
902:                 loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
903:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
904:                 loc_oBusca.Show()
905: 
906:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
907:                     SELECT cursor_4c_BuscaEmp
908:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
909:                     loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
910:                     IF USED("cursor_4c_Dados")
911:                         SELECT cursor_4c_Dados
912:                         LOCATE FOR ALLTRIM(cemps) = loc_cFiltro
913:                         loc_oGrid.Refresh()
914:                     ENDIF
915:                 ENDIF
916: 
917:                 loc_oBusca.Release()
918:             ENDIF
919: 
920:             IF USED("cursor_4c_BuscaEmp")
921:                 USE IN cursor_4c_BuscaEmp
922:             ENDIF
923:         CATCH TO loc_oErro
924:             IF VARTYPE(loc_oBusca) = "O"
925:                 loc_oBusca.Release()
926:             ENDIF
927:             IF USED("cursor_4c_BuscaEmp")
928:                 USE IN cursor_4c_BuscaEmp
929:             ENDIF
930:             MsgErro(loc_oErro.Message, "Formemp.BtnBuscarClick")
931:         ENDTRY
932:     ENDPROC
933: 
934:     PROCEDURE BtnConfirmarClick()
935:         LOCAL loc_lResultado
936:         loc_lResultado = .F.
937:         TRY
938:             THIS.FormParaBO()
939: 
940:             IF THIS.this_oBusinessObject.Salvar()
941:                 IF THIS.this_cModoAtual = "INCLUIR"
942:                     MsgInfo("Empresa inclu" + CHR(237) + "da com sucesso!", "Sucesso")
943:                 ELSE
944:                     MsgInfo("Empresa atualizada com sucesso!", "Sucesso")
945:                 ENDIF
946:                 THIS.this_cModoAtual = "LISTA"
947:                 THIS.CarregarLista()
948:                 THIS.AlternarPagina(1)
949:                 loc_lResultado = .T.
950:             ELSE
951:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
952:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao salvar")
953:                 ENDIF
954:             ENDIF
955:         CATCH TO loc_oErro
956:             MsgErro(loc_oErro.Message, "Formemp.BtnConfirmarClick")
957:         ENDTRY
958:         RETURN loc_lResultado
959:     ENDPROC
960: 
961:     PROCEDURE BtnCancelarClick()
962:         TRY
963:             THIS.this_cModoAtual = "LISTA"
964:             THIS.AlternarPagina(1)
965:         CATCH TO loc_oErro
966:             MsgErro(loc_oErro.Message, "Formemp.BtnCancelarClick")
967:         ENDTRY
968:     ENDPROC
969: 
970:     PROCEDURE AjustarBotoesPorModo()
971:         LOCAL loc_oPg1, loc_oPg2, loc_lEmLista
972:         TRY
973:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
974:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
975:             loc_oPg2     = THIS.pgf_4c_Paginas.Page2
976: 
977:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
978:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
979:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
980:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
981:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
982:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
983:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
984:                 ENDIF
985:             ENDIF
986: 
987:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
988:                 IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
989:                     loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
990:                         INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
991:                 ENDIF
992:             ENDIF
993:         CATCH TO loc_oErro
994:             MsgErro(loc_oErro.Message, "Formemp.AjustarBotoesPorModo")
995:         ENDTRY
996:     ENDPROC
997: 
998:     PROTECTED PROCEDURE FormParaBO()
999:         LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4, loc_oBO
1000:         TRY
1001:             loc_oBO = THIS.this_oBusinessObject
1002:             loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
1003:             loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
1004:             loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
1005:             loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4
1006: 
1007:             *-- Page1: Identificacao
1008:             loc_oBO.this_cCodigo           = ALLTRIM(loc_oP1.txt_4c_Codigo.Value)
1009:             loc_oBO.this_nNumero           = ALLTRIM(loc_oP1.txt_4c_Numero.Value)
1010:             loc_oBO.this_nTipoCgc          = loc_oP1.obj_4c_OpcaoCPFCGC.Value
1011:             loc_oBO.this_cCgc              = ALLTRIM(loc_oP1.txt_4c_Cgc.Value)
1012:             loc_oBO.this_cIe               = ALLTRIM(loc_oP1.txt_4c_IES.Value)
1013:             loc_oBO.this_nSituacao         = loc_oP1.cbo_4c_FWCOMBO1.ListIndex
1014:             loc_oBO.this_cRazaoSocial      = ALLTRIM(loc_oP1.txt_4c_Razsoc.Value)
1015:             loc_oBO.this_cNomeReduzido     = ALLTRIM(loc_oP1.txt_4c_Empr.Value)
1016:             loc_oBO.this_cNomeFantasia     = ALLTRIM(loc_oP1.txt_4c_Nome.Value)
1017:             loc_oBO.this_cIm               = ALLTRIM(loc_oP1.txt_4c_IMS.Value)
1018:             loc_oBO.this_cCnae             = ALLTRIM(loc_oP1.txt_4c_CNAE.Value)
1019:             loc_oBO.this_cResponsavel      = ALLTRIM(loc_oP1.txt_4c_Resp.Value)
1020:             loc_oBO.this_cCargo            = ALLTRIM(loc_oP1.txt_4c_Cargo.Value)
1021:             loc_oBO.this_cPostoFiscal      = ALLTRIM(loc_oP1.txt_4c_Postofiscal.Value)
1022:             loc_oBO.this_cEan13            = ALLTRIM(loc_oP1.txt_4c_EAN13.Value)
1023:             loc_oBO.this_cCEstoque         = ALLTRIM(loc_oP1.txt_4c_CEstoque.Value)
1024:             loc_oBO.this_cGrupoCC          = ALLTRIM(loc_oP1.txt_4c__GRUPOC.Value)
1025:             loc_oBO.this_cContaC           = ALLTRIM(loc_oP1.txt_4c__CONTAC.Value)
1026:             loc_oBO.this_cContaArls        = ALLTRIM(loc_oP1.txt_4c_CONTARLS.Value)
1027:             loc_oBO.this_cCodEmpresa       = ALLTRIM(loc_oP1.txt_4c_CodEmpresa.Value)
1028:             loc_oBO.this_lAnaVends         = (loc_oP1.chk_4c_ChkAnaVends.Value = 1)
1029:             loc_oBO.this_cCodRepres        = ALLTRIM(loc_oP1.txt_4c_CodRepres.Value)
1030:             loc_oBO.this_cGrupoEmpresarial = ALLTRIM(loc_oP1.txt_4c_Grupo.Value)
1031:             loc_oBO.this_cClassificacaoEmp = ALLTRIM(loc_oP1.txt_4c_Class.Value)
1032:             loc_oBO.this_lEscritorio       = (loc_oP1.chk_4c_ChkEsc.Value = 1)
1033: 
1034:             *-- Page1: Endereco
1035:             loc_oBO.this_cCep              = ALLTRIM(loc_oP1.txt_4c_Cep.Value)
1036:             loc_oBO.this_cPais             = ALLTRIM(loc_oP1.txt_4c_Pais.Value)
1037:             loc_oBO.this_nFusoHorario      = ALLTRIM(loc_oP1.txt_4c_4.Value)
1038:             loc_oBO.this_cEndereco         = ALLTRIM(loc_oP1.txt_4c_End.Value)

*-- Linhas 1099 a 1143:
1099:             loc_oBO.this_nCalcCustos       = loc_oP2.obj_4c_OPTCALCCUSTOS.Value
1100:             loc_oBO.this_nAltTrans         = loc_oP2.obj_4c_OPT_ALTTRANS.Value
1101:             loc_oBO.this_lBlqDt            = (loc_oP2.obj_4c_Op_blqdt.Value = 1)
1102:             loc_oBO.this_nBriefing         = loc_oP2.obj_4c_Optiongroup1.Value
1103:             loc_oBO.this_nEcommerce        = loc_oP2.obj_4c_Optiongroup2.Value
1104: 
1105:             *-- Page2: Empresa OS / SEDEX / Sub
1106:             loc_oBO.this_cEmpBal           = ALLTRIM(loc_oP2.txt_4c_EmpBal.Value)
1107:             loc_oBO.this_nTempoSub         = ALLTRIM(loc_oP2.txt_4c_TempoSubn.Value)
1108:             loc_oBO.this_cDopInt           = ALLTRIM(loc_oP2.txt_4c_Dope_int.Value)
1109:             loc_oBO.this_cDac              = ALLTRIM(loc_oP2.txt_4c_DAC.Value)
1110:             loc_oBO.this_cBanco            = ALLTRIM(loc_oP2.txt_4c_Banco.Value)
1111:             loc_oBO.this_cAgencia          = ALLTRIM(loc_oP2.txt_4c_Agenc.Value)
1112:             loc_oBO.this_cConta            = ALLTRIM(loc_oP2.txt_4c_Conta.Value)
1113:             loc_oBO.this_cContratoDef      = ALLTRIM(loc_oP2.txt_4c_Contrato.Value)
1114:             loc_oBO.this_cAgenciaSedex     = ALLTRIM(loc_oP2.txt_4c_Agencia.Value)
1115:             loc_oBO.this_cCartaoSedex      = ALLTRIM(loc_oP2.txt_4c_Cartao.Value)
1116: 
1117:             *-- Page2: Email Padrao
1118:             loc_oBO.this_cSmtpEmail        = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.Value)
1119:             loc_oBO.this_nPortaEmail       = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.Value)
1120:             loc_oBO.this_cEmailPad         = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Email.Value)
1121:             loc_oBO.this_cSenhaEmail       = ALLTRIM(loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.Value)
1122: 
1123:             *-- Page2: Distribuicao / CDL
1124:             loc_oBO.this_cSaiCol           = ALLTRIM(loc_oP2.txt_4c_Saicol.Value)
1125:             loc_oBO.this_cCdlSenha         = ALLTRIM(loc_oP2.txt_4c_Cdlsenhas.Value)
1126: 
1127:             *-- Page3: CFOP / Moeda / Mrcf
1128:             loc_oBO.this_cMcTotal          = ALLTRIM(loc_oP3.txt_4c_Mctotal.Value)
1129:             loc_oBO.this_cCfoInt           = ALLTRIM(loc_oP3.txt_4c_Cfo_Int.Value)
1130:             loc_oBO.this_nMrcf             = ALLTRIM(loc_oP3.txt_4c_Mrcf.Value)
1131: 
1132:             *-- Page3: Grupos e Contas Contabeis (Orig)
1133:             loc_oBO.this_cGrupoIcmsOrig    = ALLTRIM(loc_oP3.txt_4c__GRUPOO.Value)
1134:             loc_oBO.this_cContaIcmsOrig    = ALLTRIM(loc_oP3.txt_4c__CONTAO.Value)
1135:             loc_oBO.this_cGrupoIcmsDeb     = ALLTRIM(loc_oP3.txt_4c__GRUICMO.Value)
1136:             loc_oBO.this_cContaIcmsDeb     = ALLTRIM(loc_oP3.txt_4c__CONICMO.Value)
1137:             loc_oBO.this_cGrupoIpi         = ALLTRIM(loc_oP3.txt_4c__GRUIPIO.Value)
1138:             loc_oBO.this_cContaIpi         = ALLTRIM(loc_oP3.txt_4c__CONIPIO.Value)
1139:             loc_oBO.this_cGrupoPis         = ALLTRIM(loc_oP3.txt_4c__GRUPISO.Value)
1140:             loc_oBO.this_cContaPis         = ALLTRIM(loc_oP3.txt_4c__CONPISO.Value)
1141:             loc_oBO.this_cGrupoCofins      = ALLTRIM(loc_oP3.txt_4c__GRUCONO.Value)
1142:             loc_oBO.this_cContaCofins      = ALLTRIM(loc_oP3.txt_4c__CONCONO.Value)
1143: 

*-- Linhas 1187 a 1230:
1187:         ENDTRY
1188:     ENDPROC
1189: 
1190:     PROTECTED PROCEDURE BOParaForm()
1191:         LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4, loc_oBO
1192:         TRY
1193:             loc_oBO = THIS.this_oBusinessObject
1194:             loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
1195:             loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
1196:             loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
1197:             loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4
1198: 
1199:             *-- Page1: Identificacao
1200:             loc_oP1.txt_4c_Codigo.Value          = loc_oBO.this_cCodigo
1201:             loc_oP1.txt_4c_Numero.Value          = TRANSFORM(loc_oBO.this_nNumero)
1202:             loc_oP1.obj_4c_OpcaoCPFCGC.Value     = IIF(loc_oBO.this_nTipoCgc = 0, 2, loc_oBO.this_nTipoCgc)
1203:             loc_oP1.txt_4c_Cgc.Value             = loc_oBO.this_cCgc
1204:             loc_oP1.txt_4c_IES.Value             = loc_oBO.this_cIe
1205:             loc_oP1.cbo_4c_FWCOMBO1.ListIndex    = loc_oBO.this_nSituacao
1206:             loc_oP1.txt_4c_Razsoc.Value          = loc_oBO.this_cRazaoSocial
1207:             loc_oP1.txt_4c_Empr.Value            = loc_oBO.this_cNomeReduzido
1208:             loc_oP1.txt_4c_Nome.Value            = loc_oBO.this_cNomeFantasia
1209:             loc_oP1.txt_4c_IMS.Value             = loc_oBO.this_cIm
1210:             loc_oP1.txt_4c_CNAE.Value            = loc_oBO.this_cCnae
1211:             loc_oP1.txt_4c_Resp.Value            = loc_oBO.this_cResponsavel
1212:             loc_oP1.txt_4c_Cargo.Value           = loc_oBO.this_cCargo
1213:             loc_oP1.txt_4c_Postofiscal.Value     = loc_oBO.this_cPostoFiscal
1214:             loc_oP1.txt_4c_EAN13.Value           = loc_oBO.this_cEan13
1215:             loc_oP1.txt_4c_CEstoque.Value        = loc_oBO.this_cCEstoque
1216:             loc_oP1.txt_4c__GRUPOC.Value         = loc_oBO.this_cGrupoCC
1217:             loc_oP1.txt_4c__CONTAC.Value         = loc_oBO.this_cContaC
1218:             loc_oP1.txt_4c_CONTARLS.Value        = loc_oBO.this_cContaArls
1219:             loc_oP1.txt_4c_CodEmpresa.Value      = loc_oBO.this_cCodEmpresa
1220:             loc_oP1.chk_4c_ChkAnaVends.Value     = IIF(loc_oBO.this_lAnaVends, 1, 0)
1221:             loc_oP1.txt_4c_CodRepres.Value       = loc_oBO.this_cCodRepres
1222:             loc_oP1.txt_4c_Grupo.Value           = loc_oBO.this_cGrupoEmpresarial
1223:             loc_oP1.txt_4c_Class.Value           = loc_oBO.this_cClassificacaoEmp
1224:             loc_oP1.chk_4c_ChkEsc.Value          = IIF(loc_oBO.this_lEscritorio, 1, 0)
1225: 
1226:             *-- Page1: Endereco
1227:             loc_oP1.txt_4c_Cep.Value             = loc_oBO.this_cCep
1228:             loc_oP1.txt_4c_Pais.Value            = loc_oBO.this_cPais
1229:             loc_oP1.txt_4c_4.Value               = TRANSFORM(loc_oBO.this_nFusoHorario)
1230:             loc_oP1.txt_4c_End.Value             = loc_oBO.this_cEndereco

*-- Linhas 1291 a 1335:
1291:             loc_oP2.obj_4c_OPTCALCCUSTOS.Value   = loc_oBO.this_nCalcCustos
1292:             loc_oP2.obj_4c_OPT_ALTTRANS.Value    = loc_oBO.this_nAltTrans
1293:             loc_oP2.obj_4c_Op_blqdt.Value        = IIF(loc_oBO.this_lBlqDt, 1, 2)
1294:             loc_oP2.obj_4c_Optiongroup1.Value    = loc_oBO.this_nBriefing
1295:             loc_oP2.obj_4c_Optiongroup2.Value    = loc_oBO.this_nEcommerce
1296: 
1297:             *-- Page2: Empresa OS / SEDEX / Sub
1298:             loc_oP2.txt_4c_EmpBal.Value          = loc_oBO.this_cEmpBal
1299:             loc_oP2.txt_4c_TempoSubn.Value       = TRANSFORM(loc_oBO.this_nTempoSub)
1300:             loc_oP2.txt_4c_Dope_int.Value        = loc_oBO.this_cDopInt
1301:             loc_oP2.txt_4c_DAC.Value             = loc_oBO.this_cDac
1302:             loc_oP2.txt_4c_Banco.Value           = loc_oBO.this_cBanco
1303:             loc_oP2.txt_4c_Agenc.Value           = loc_oBO.this_cAgencia
1304:             loc_oP2.txt_4c_Conta.Value           = loc_oBO.this_cConta
1305:             loc_oP2.txt_4c_Contrato.Value        = loc_oBO.this_cContratoDef
1306:             loc_oP2.txt_4c_Agencia.Value         = loc_oBO.this_cAgenciaSedex
1307:             loc_oP2.txt_4c_Cartao.Value          = loc_oBO.this_cCartaoSedex
1308: 
1309:             *-- Page2: Email Padrao
1310:             loc_oP2.cnt_4c_EmailPad.txt_4c_Servs.Value  = loc_oBO.this_cSmtpEmail
1311:             loc_oP2.cnt_4c_EmailPad.txt_4c_Porta.Value  = TRANSFORM(loc_oBO.this_nPortaEmail)
1312:             loc_oP2.cnt_4c_EmailPad.txt_4c_Email.Value  = loc_oBO.this_cEmailPad
1313:             loc_oP2.cnt_4c_EmailPad.txt_4c_Senhas.Value = loc_oBO.this_cSenhaEmail
1314: 
1315:             *-- Page2: Distribuicao / CDL
1316:             loc_oP2.txt_4c_Saicol.Value          = loc_oBO.this_cSaiCol
1317:             loc_oP2.txt_4c_Cdlsenhas.Value       = loc_oBO.this_cCdlSenha
1318: 
1319:             *-- Page3: CFOP / Moeda / Mrcf
1320:             loc_oP3.txt_4c_Mctotal.Value         = loc_oBO.this_cMcTotal
1321:             loc_oP3.txt_4c_Cfo_Int.Value         = loc_oBO.this_cCfoInt
1322:             loc_oP3.txt_4c_Mrcf.Value            = TRANSFORM(loc_oBO.this_nMrcf)
1323: 
1324:             *-- Page3: Grupos e Contas (Orig)
1325:             loc_oP3.txt_4c__GRUPOO.Value         = loc_oBO.this_cGrupoIcmsOrig
1326:             loc_oP3.txt_4c__CONTAO.Value         = loc_oBO.this_cContaIcmsOrig
1327:             loc_oP3.txt_4c__GRUICMO.Value        = loc_oBO.this_cGrupoIcmsDeb
1328:             loc_oP3.txt_4c__CONICMO.Value        = loc_oBO.this_cContaIcmsDeb
1329:             loc_oP3.txt_4c__GRUIPIO.Value        = loc_oBO.this_cGrupoIpi
1330:             loc_oP3.txt_4c__CONIPIO.Value        = loc_oBO.this_cContaIpi
1331:             loc_oP3.txt_4c__GRUPISO.Value        = loc_oBO.this_cGrupoPis
1332:             loc_oP3.txt_4c__CONPISO.Value        = loc_oBO.this_cContaPis
1333:             loc_oP3.txt_4c__GRUCONO.Value        = loc_oBO.this_cGrupoCofins
1334:             loc_oP3.txt_4c__CONCONO.Value        = loc_oBO.this_cContaCofins
1335: 

*-- Linhas 1377 a 1420:
1377:         ENDTRY
1378:     ENDPROC
1379: 
1380:     PROTECTED PROCEDURE LimparCampos()
1381:         LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4
1382:         TRY
1383:             loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
1384:             loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
1385:             loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
1386:             loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4
1387: 
1388:             *-- Page1
1389:             loc_oP1.txt_4c_Codigo.Value          = ""
1390:             loc_oP1.txt_4c_Numero.Value          = ""
1391:             loc_oP1.obj_4c_OpcaoCPFCGC.Value     = 2
1392:             loc_oP1.txt_4c_Cgc.Value             = ""
1393:             loc_oP1.txt_4c_IES.Value             = ""
1394:             loc_oP1.cbo_4c_FWCOMBO1.ListIndex    = 0
1395:             loc_oP1.txt_4c_Razsoc.Value          = ""
1396:             loc_oP1.txt_4c_Empr.Value            = ""
1397:             loc_oP1.txt_4c_Nome.Value            = ""
1398:             loc_oP1.txt_4c_IMS.Value             = ""
1399:             loc_oP1.txt_4c_CNAE.Value            = ""
1400:             loc_oP1.txt_4c_Resp.Value            = ""
1401:             loc_oP1.txt_4c_Cargo.Value           = ""
1402:             loc_oP1.txt_4c_Postofiscal.Value     = ""
1403:             loc_oP1.txt_4c_EAN13.Value           = ""
1404:             loc_oP1.txt_4c_CEstoque.Value        = ""
1405:             loc_oP1.txt_4c__GRUPOC.Value         = ""
1406:             loc_oP1.txt_4c__CONTAC.Value         = ""
1407:             loc_oP1.txt_4c_CONTARLS.Value        = ""
1408:             loc_oP1.txt_4c_CodEmpresa.Value      = ""
1409:             loc_oP1.chk_4c_ChkAnaVends.Value     = 0
1410:             loc_oP1.txt_4c_CodRepres.Value       = ""
1411:             loc_oP1.txt_4c_Grupo.Value           = ""
1412:             loc_oP1.txt_4c_Class.Value           = ""
1413:             loc_oP1.chk_4c_ChkEsc.Value          = 0
1414:             loc_oP1.txt_4c_Cep.Value             = ""
1415:             loc_oP1.txt_4c_Pais.Value            = ""
1416:             loc_oP1.txt_4c_4.Value               = ""
1417:             loc_oP1.txt_4c_End.Value             = ""
1418:             loc_oP1.txt_4c_3.Value               = ""
1419:             loc_oP1.txt_4c_Comp.Value            = ""
1420:             loc_oP1.txt_4c_Bairro.Value          = ""

*-- Linhas 1534 a 1577:
1534:         ENDTRY
1535:     ENDPROC
1536: 
1537:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1538:         LOCAL loc_oP1, loc_oP2, loc_oP3, loc_oP4
1539:         TRY
1540:             loc_oP1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
1541:             loc_oP2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
1542:             loc_oP3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
1543:             loc_oP4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page4
1544: 
1545:             *-- Page1
1546:             loc_oP1.txt_4c_Codigo.ReadOnly       = !par_lHabilitar
1547:             loc_oP1.txt_4c_Numero.ReadOnly       = !par_lHabilitar
1548:             loc_oP1.txt_4c_Cgc.ReadOnly          = !par_lHabilitar
1549:             loc_oP1.txt_4c_IES.ReadOnly          = !par_lHabilitar
1550:             loc_oP1.txt_4c_Razsoc.ReadOnly       = !par_lHabilitar
1551:             loc_oP1.txt_4c_Empr.ReadOnly         = !par_lHabilitar
1552:             loc_oP1.txt_4c_Nome.ReadOnly         = !par_lHabilitar
1553:             loc_oP1.txt_4c_IMS.ReadOnly          = !par_lHabilitar
1554:             loc_oP1.txt_4c_CNAE.ReadOnly         = !par_lHabilitar
1555:             loc_oP1.txt_4c_Resp.ReadOnly         = !par_lHabilitar
1556:             loc_oP1.txt_4c_Cargo.ReadOnly        = !par_lHabilitar
1557:             loc_oP1.txt_4c_Postofiscal.ReadOnly  = !par_lHabilitar
1558:             loc_oP1.txt_4c_EAN13.ReadOnly        = !par_lHabilitar
1559:             loc_oP1.txt_4c_CEstoque.ReadOnly     = !par_lHabilitar
1560:             loc_oP1.txt_4c__GRUPOC.ReadOnly      = !par_lHabilitar
1561:             loc_oP1.txt_4c__CONTAC.ReadOnly      = !par_lHabilitar
1562:             loc_oP1.txt_4c_CONTARLS.ReadOnly     = !par_lHabilitar
1563:             loc_oP1.txt_4c_CodEmpresa.ReadOnly   = !par_lHabilitar
1564:             loc_oP1.txt_4c_CodRepres.ReadOnly    = !par_lHabilitar
1565:             loc_oP1.txt_4c_Grupo.ReadOnly        = !par_lHabilitar
1566:             loc_oP1.txt_4c_Class.ReadOnly        = !par_lHabilitar
1567:             loc_oP1.txt_4c_Cep.ReadOnly          = !par_lHabilitar
1568:             loc_oP1.txt_4c_Pais.ReadOnly         = !par_lHabilitar
1569:             loc_oP1.txt_4c_4.ReadOnly            = !par_lHabilitar
1570:             loc_oP1.txt_4c_End.ReadOnly          = !par_lHabilitar
1571:             loc_oP1.txt_4c_3.ReadOnly            = !par_lHabilitar
1572:             loc_oP1.txt_4c_Comp.ReadOnly         = !par_lHabilitar
1573:             loc_oP1.txt_4c_Bairro.ReadOnly       = !par_lHabilitar
1574:             loc_oP1.txt_4c_Cid.ReadOnly          = !par_lHabilitar
1575:             loc_oP1.txt_4c_Est.ReadOnly          = !par_lHabilitar
1576:             loc_oP1.txt_4c_REGIAOS.ReadOnly      = !par_lHabilitar
1577:             loc_oP1.txt_4c_Tel1.ReadOnly         = !par_lHabilitar

*-- Linhas 1688 a 1731:
1688:     *        Responsavel, PostoFiscal, ClassificacaoEmp, Cargo, EAN13, CEstoque,
1689:     *        GrupoCOTEP, ContaCOTEP, ContaXEmp, CodInterno, AnaVends, CodRegional
1690:     *===========================================================================
1691:     PROCEDURE ConfigurarSubPage1(par_oPagina)
1692:         LOCAL loc_oCnt
1693:         loc_oCnt = par_oPagina.cnt_4c_Page1
1694: 
1695:         *-- CheckBox Escritorio
1696:         loc_oCnt.AddObject("chk_4c_ChkEsc", "CheckBox")
1697:         WITH loc_oCnt.chk_4c_ChkEsc
1698:             .Top      = 118
1699:             .Left     = 911
1700:             .Width    = 65
1701:             .Height   = 15
1702:             .Caption  = "Escrit" + CHR(243) + "rio"
1703:             .Value    = 0
1704:             .FontName = "Tahoma"
1705:             .FontSize = 8
1706:             .Visible  = .T.
1707:         ENDWITH
1708: 
1709:         *-- Linha 1: Codigo / Numero / CPF-CNPJ / CGC / IE / Situacao
1710:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
1711:         WITH loc_oCnt.lbl_4c_Label1
1712:             .Top      = 139
1713:             .Left     = 95
1714:             .Width    = 42
1715:             .Height   = 15
1716:             .AutoSize = .F.
1717:             .Caption  = "C" + CHR(243) + "digo :"
1718:             .FontName = "Tahoma"
1719:             .FontSize = 8
1720:             .Visible  = .T.
1721:         ENDWITH
1722: 
1723:         loc_oCnt.AddObject("txt_4c_Codigo", "TextBox")
1724:         WITH loc_oCnt.txt_4c_Codigo
1725:             .Top      = 135
1726:             .Left     = 139
1727:             .Width    = 31
1728:             .Height   = 22
1729:             .FontName = "Tahoma"
1730:             .FontSize = 8
1731:             .Visible  = .T.

*-- Linhas 1755 a 1798:
1755:             .Visible  = .T.
1756:         ENDWITH
1757: 
1758:         loc_oCnt.AddObject("obj_4c_OpcaoCPFCGC", "OptionGroup")
1759:         WITH loc_oCnt.obj_4c_OpcaoCPFCGC
1760:             .Top         = 137
1761:             .Left        = 269
1762:             .Width       = 99
1763:             .Height      = 20
1764:             .ButtonCount = 2
1765:             .Value       = 2
1766:             .BackStyle   = 0
1767:             .BorderStyle = 0
1768:             .Visible     = .T.
1769:             WITH .Buttons(1)
1770:                 .Caption  = "CPF"
1771:                 .Value    = 0
1772:                 .Top      = 0
1773:                 .Left     = 0
1774:                 .Width    = 47
1775:                 .Height   = 20
1776:             ENDWITH
1777:             WITH .Buttons(2)
1778:                 .Caption  = "CNPJ"
1779:                 .Value    = 1
1780:                 .Top      = 0
1781:                 .Left     = 49
1782:                 .Width    = 50
1783:                 .Height   = 20
1784:                 .FontName = "Tahoma"
1785:                 .FontSize = 8
1786:             ENDWITH
1787:         ENDWITH
1788: 
1789:         loc_oCnt.AddObject("txt_4c_Cgc", "TextBox")
1790:         WITH loc_oCnt.txt_4c_Cgc
1791:             .Top      = 135
1792:             .Left     = 367
1793:             .Width    = 132
1794:             .Height   = 22
1795:             .FontName = "Tahoma"
1796:             .FontSize = 8
1797:             .Visible  = .T.
1798:         ENDWITH

*-- Linhas 1992 a 2035:
1992:             .FontSize = 8
1993:             .Visible  = .T.
1994:         ENDWITH
1995:         BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "KeyPressGrupoEmp")
1996: 
1997:         *-- Linha 4: Responsavel / Posto Fiscal / Classificacao Empresarial
1998:         loc_oCnt.AddObject("lbl_4c_Label3", "Label")
1999:         WITH loc_oCnt.lbl_4c_Label3
2000:             .Top      = 213
2001:             .Left     = 67
2002:             .Width    = 70
2003:             .Height   = 15
2004:             .AutoSize = .F.
2005:             .Caption  = "Respons" + CHR(225) + "vel :"
2006:             .FontName = "Tahoma"
2007:             .FontSize = 8
2008:             .Visible  = .T.
2009:         ENDWITH
2010: 
2011:         loc_oCnt.AddObject("txt_4c_Resp", "TextBox")
2012:         WITH loc_oCnt.txt_4c_Resp
2013:             .Top      = 210
2014:             .Left     = 139
2015:             .Width    = 360
2016:             .Height   = 22
2017:             .FontName = "Tahoma"
2018:             .FontSize = 8
2019:             .Visible  = .T.
2020:         ENDWITH
2021: 
2022:         loc_oCnt.AddObject("lbl_4c_Label25", "Label")
2023:         WITH loc_oCnt.lbl_4c_Label25
2024:             .Top      = 216
2025:             .Left     = 521
2026:             .Width    = 65
2027:             .Height   = 15
2028:             .AutoSize = .F.
2029:             .Caption  = "Posto Fiscal :"
2030:             .FontName = "Tahoma"
2031:             .FontSize = 8
2032:             .Visible  = .T.
2033:         ENDWITH
2034: 
2035:         loc_oCnt.AddObject("txt_4c_Postofiscal", "TextBox")

*-- Linhas 2066 a 2109:
2066:             .FontSize = 8
2067:             .Visible  = .T.
2068:         ENDWITH
2069:         BINDEVENT(loc_oCnt.txt_4c_Class, "KeyPress", THIS, "KeyPressClassEmp")
2070: 
2071:         *-- Linha 5: Cargo Responsavel / EAN13 / Conta Estoque / CmdCtaCtg
2072:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
2073:         WITH loc_oCnt.lbl_4c_Label4
2074:             .Top      = 239
2075:             .Left     = 35
2076:             .Width    = 102
2077:             .Height   = 15
2078:             .AutoSize = .F.
2079:             .Caption  = "Cargo Respons" + CHR(225) + "vel :"
2080:             .FontName = "Tahoma"
2081:             .FontSize = 8
2082:             .Visible  = .T.
2083:         ENDWITH
2084: 
2085:         loc_oCnt.AddObject("txt_4c_Cargo", "TextBox")
2086:         WITH loc_oCnt.txt_4c_Cargo
2087:             .Top      = 235
2088:             .Left     = 139
2089:             .Width    = 360
2090:             .Height   = 22
2091:             .FontName = "Tahoma"
2092:             .FontSize = 8
2093:             .Visible  = .T.
2094:         ENDWITH
2095: 
2096:         loc_oCnt.AddObject("lbl_4c_Label27", "Label")
2097:         WITH loc_oCnt.lbl_4c_Label27
2098:             .Top      = 241
2099:             .Left     = 545
2100:             .Width    = 41
2101:             .Height   = 15
2102:             .AutoSize = .F.
2103:             .Caption  = "EAN13 :"
2104:             .FontName = "Tahoma"
2105:             .FontSize = 8
2106:             .Visible  = .T.
2107:         ENDWITH
2108: 
2109:         loc_oCnt.AddObject("txt_4c_EAN13", "TextBox")

*-- Linhas 2153 a 2272:
2153:             .Themes       = .T.
2154:             .Visible      = .T.
2155:         ENDWITH
2156:         BINDEVENT(loc_oCnt.cmd_4c_CmdCtaCtg, "Click", THIS, "CmdCtaCtgClick")
2157: 
2158:         *-- Linha 6: Grupo/Conta COTEP / Conta x Emp / Cod Interno / Regional
2159:         loc_oCnt.AddObject("lbl_4c_Label32", "Label")
2160:         WITH loc_oCnt.lbl_4c_Label32
2161:             .Top      = 264
2162:             .Left     = 30
2163:             .Width    = 107
2164:             .Height   = 15
2165:             .AutoSize = .F.
2166:             .Caption  = "Grupo/Conta COTEP :"
2167:             .FontName = "Tahoma"
2168:             .FontSize = 8
2169:             .Visible  = .T.
2170:         ENDWITH
2171: 
2172:         loc_oCnt.AddObject("txt_4c__GRUPOC", "TextBox")
2173:         WITH loc_oCnt.txt_4c__GRUPOC
2174:             .Top      = 260
2175:             .Left     = 139
2176:             .Width    = 87
2177:             .Height   = 22
2178:             .FontName = "Tahoma"
2179:             .FontSize = 8
2180:             .Visible  = .T.
2181:         ENDWITH
2182:         BINDEVENT(loc_oCnt.txt_4c__GRUPOC, "KeyPress", THIS, "KeyPressGrupoCC")
2183: 
2184:         loc_oCnt.AddObject("lbl_4c_Label21", "Label")
2185:         WITH loc_oCnt.lbl_4c_Label21
2186:             .Top      = 264
2187:             .Left     = 228
2188:             .Width    = 8
2189:             .Height   = 15
2190:             .AutoSize = .F.
2191:             .Caption  = "/"
2192:             .FontName = "Tahoma"
2193:             .FontSize = 8
2194:             .Visible  = .T.
2195:         ENDWITH
2196: 
2197:         loc_oCnt.AddObject("txt_4c__CONTAC", "TextBox")
2198:         WITH loc_oCnt.txt_4c__CONTAC
2199:             .Top      = 260
2200:             .Left     = 236
2201:             .Width    = 87
2202:             .Height   = 22
2203:             .FontName = "Tahoma"
2204:             .FontSize = 8
2205:             .Visible  = .T.
2206:         ENDWITH
2207:         BINDEVENT(loc_oCnt.txt_4c__CONTAC, "KeyPress", THIS, "KeyPressContaC")
2208: 
2209:         loc_oCnt.AddObject("lbl_4c_Label6", "Label")
2210:         WITH loc_oCnt.lbl_4c_Label6
2211:             .Top      = 264
2212:             .Left     = 328
2213:             .Width    = 70
2214:             .Height   = 15
2215:             .AutoSize = .F.
2216:             .Caption  = "Conta x Emp :"
2217:             .FontName = "Tahoma"
2218:             .FontSize = 8
2219:             .Visible  = .T.
2220:         ENDWITH
2221: 
2222:         loc_oCnt.AddObject("txt_4c_CONTARLS", "TextBox")
2223:         WITH loc_oCnt.txt_4c_CONTARLS
2224:             .Top      = 260
2225:             .Left     = 412
2226:             .Width    = 87
2227:             .Height   = 22
2228:             .FontName = "Tahoma"
2229:             .FontSize = 8
2230:             .Visible  = .T.
2231:         ENDWITH
2232:         BINDEVENT(loc_oCnt.txt_4c_CONTARLS, "KeyPress", THIS, "KeyPressContarls")
2233: 
2234:         loc_oCnt.AddObject("lbl_4c_Label46", "Label")
2235:         WITH loc_oCnt.lbl_4c_Label46
2236:             .Top      = 266
2237:             .Left     = 521
2238:             .Width    = 65
2239:             .Height   = 15
2240:             .AutoSize = .F.
2241:             .Caption  = "Cod Interno :"
2242:             .FontName = "Tahoma"
2243:             .FontSize = 8
2244:             .Visible  = .T.
2245:         ENDWITH
2246: 
2247:         loc_oCnt.AddObject("txt_4c_CodEmpresa", "TextBox")
2248:         WITH loc_oCnt.txt_4c_CodEmpresa
2249:             .Top      = 262
2250:             .Left     = 588
2251:             .Width    = 53
2252:             .Height   = 22
2253:             .FontName = "Tahoma"
2254:             .FontSize = 8
2255:             .Visible  = .T.
2256:         ENDWITH
2257: 
2258:         loc_oCnt.AddObject("chk_4c_ChkAnaVends", "CheckBox")
2259:         WITH loc_oCnt.chk_4c_ChkAnaVends
2260:             .Top      = 266
2261:             .Left     = 646
2262:             .Width    = 97
2263:             .Height   = 15
2264:             .Caption  = "Entra no Oficial1"
2265:             .Value    = 0
2266:             .FontName = "Tahoma"
2267:             .FontSize = 8
2268:             .Visible  = .T.
2269:         ENDWITH
2270: 
2271:         loc_oCnt.AddObject("lbl_4c_Label53", "Label")
2272:         WITH loc_oCnt.lbl_4c_Label53

*-- Linhas 2512 a 2580:
2512:             .FontSize  = 8
2513:             .Visible   = .T.
2514:         ENDWITH
2515:         BINDEVENT(loc_oCnt.txt_4c_Est, "KeyPress", THIS, "KeyPressUF")
2516: 
2517:         loc_oCnt.AddObject("lbl_4c_Label38", "Label")
2518:         WITH loc_oCnt.lbl_4c_Label38
2519:             .Top      = 368
2520:             .Left     = 567
2521:             .Width    = 42
2522:             .Height   = 15
2523:             .AutoSize = .F.
2524:             .Caption  = "Regi" + CHR(227) + "o :"
2525:             .FontName = "Tahoma"
2526:             .FontSize = 8
2527:             .Visible  = .T.
2528:         ENDWITH
2529: 
2530:         loc_oCnt.AddObject("txt_4c_REGIAOS", "TextBox")
2531:         WITH loc_oCnt.txt_4c_REGIAOS
2532:             .Top      = 364
2533:             .Left     = 611
2534:             .Width    = 80
2535:             .Height   = 22
2536:             .FontName = "Tahoma"
2537:             .FontSize = 8
2538:             .Visible  = .T.
2539:         ENDWITH
2540:         BINDEVENT(loc_oCnt.txt_4c_REGIAOS, "KeyPress", THIS, "KeyPressRegiao")
2541: 
2542:         *-- Linha 11: Telefones
2543:         loc_oCnt.AddObject("lbl_4c_Label13", "Label")
2544:         WITH loc_oCnt.lbl_4c_Label13
2545:             .Top      = 391
2546:             .Left     = 81
2547:             .Width    = 56
2548:             .Height   = 15
2549:             .AutoSize = .F.
2550:             .Caption  = "Telefones :"
2551:             .FontName = "Tahoma"
2552:             .FontSize = 8
2553:             .Visible  = .T.
2554:         ENDWITH
2555: 
2556:         loc_oCnt.AddObject("txt_4c_Tel1", "TextBox")
2557:         WITH loc_oCnt.txt_4c_Tel1
2558:             .Top      = 388
2559:             .Left     = 139
2560:             .Width    = 183
2561:             .Height   = 22
2562:             .FontName = "Tahoma"
2563:             .FontSize = 8
2564:             .Visible  = .T.
2565:         ENDWITH
2566: 
2567:         loc_oCnt.AddObject("txt_4c_Tel2", "TextBox")
2568:         WITH loc_oCnt.txt_4c_Tel2
2569:             .Top      = 388
2570:             .Left     = 324
2571:             .Width    = 182
2572:             .Height   = 22
2573:             .FontName = "Tahoma"
2574:             .FontSize = 8
2575:             .Visible  = .T.
2576:         ENDWITH
2577: 
2578:         loc_oCnt.AddObject("txt_4c_Fax", "TextBox")
2579:         WITH loc_oCnt.txt_4c_Fax
2580:             .Top      = 388

*-- Linhas 3192 a 3394:
3192:     *===========================================================================
3193:     * KeyPressGrupoEmp - F4/F5: lookup Grupo Empresarial (SigCdGre.grupo)
3194:     *===========================================================================
3195:     PROCEDURE KeyPressGrupoEmp(par_nKeyCode, par_nShiftAltCtrl)
3196:         LOCAL loc_oCnt, loc_oForm
3197:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
3198:             TRY
3199:                 loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
3200:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
3201:                     "SigCdGre", "grupo", "gruclass", ;
3202:                     "Grupo Empresarial", "", ;
3203:                     ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
3204:                 IF VARTYPE(loc_oForm) = "O"
3205:                     loc_oForm.Show()
3206:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
3207:                         loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
3208:                     ENDIF
3209:                 ENDIF
3210:             CATCH TO loc_oErro
3211:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoEmp")
3212:             ENDTRY
3213:             par_nKeyCode = 0
3214:         ENDIF
3215:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
3216:             KEYBOARD CHR(9)
3217:         ENDIF
3218:     ENDPROC
3219: 
3220:     *===========================================================================
3221:     * KeyPressClassEmp - F4/F5: lookup Classificacao Empresarial (SigCdGre.class)
3222:     *===========================================================================
3223:     PROCEDURE KeyPressClassEmp(par_nKeyCode, par_nShiftAltCtrl)
3224:         LOCAL loc_oCnt, loc_oForm
3225:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
3226:             TRY
3227:                 loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
3228:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
3229:                     "SigCdGre", "class", "gruclass", ;
3230:                     "Classifica" + CHR(231) + CHR(227) + "o Empresarial", "", ;
3231:                     ALLTRIM(loc_oCnt.txt_4c_Class.Value))
3232:                 IF VARTYPE(loc_oForm) = "O"
3233:                     loc_oForm.Show()
3234:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
3235:                         loc_oCnt.txt_4c_Class.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
3236:                     ENDIF
3237:                 ENDIF
3238:             CATCH TO loc_oErro
3239:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressClassEmp")
3240:             ENDTRY
3241:             par_nKeyCode = 0
3242:         ENDIF
3243:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
3244:             KEYBOARD CHR(9)
3245:         ENDIF
3246:     ENDPROC
3247: 
3248:     *===========================================================================
3249:     * KeyPressGrupoCC - F4/F5: lookup Grupo COTEP (SigCdGcr.Codigos)
3250:     *===========================================================================
3251:     PROCEDURE KeyPressGrupoCC(par_nKeyCode, par_nShiftAltCtrl)
3252:         LOCAL loc_oCnt, loc_oForm
3253:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
3254:             TRY
3255:                 loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
3256:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
3257:                     "SigCdGcr", "Codigos", "descrs", ;
3258:                     "Grupo COTEP", "", ;
3259:                     ALLTRIM(loc_oCnt.txt_4c__GRUPOC.Value))
3260:                 IF VARTYPE(loc_oForm) = "O"
3261:                     loc_oForm.Show()
3262:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
3263:                         loc_oCnt.txt_4c__GRUPOC.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
3264:                     ENDIF
3265:                 ENDIF
3266:             CATCH TO loc_oErro
3267:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoCC")
3268:             ENDTRY
3269:             par_nKeyCode = 0
3270:         ENDIF
3271:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
3272:             KEYBOARD CHR(9)
3273:         ENDIF
3274:     ENDPROC
3275: 
3276:     *===========================================================================
3277:     * KeyPressContaC - F4/F5: lookup Conta COTEP (SIGSYACC.cdcontas)
3278:     *===========================================================================
3279:     PROCEDURE KeyPressContaC(par_nKeyCode, par_nShiftAltCtrl)
3280:         LOCAL loc_oCnt, loc_oForm
3281:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
3282:             TRY
3283:                 loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
3284:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
3285:                     "SIGSYACC", "cdcontas", "grcontas", ;
3286:                     "Conta COTEP", "", ;
3287:                     ALLTRIM(loc_oCnt.txt_4c__CONTAC.Value))
3288:                 IF VARTYPE(loc_oForm) = "O"
3289:                     loc_oForm.Show()
3290:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
3291:                         loc_oCnt.txt_4c__CONTAC.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
3292:                     ENDIF
3293:                 ENDIF
3294:             CATCH TO loc_oErro
3295:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressContaC")
3296:             ENDTRY
3297:             par_nKeyCode = 0
3298:         ENDIF
3299:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
3300:             KEYBOARD CHR(9)
3301:         ENDIF
3302:     ENDPROC
3303: 
3304:     *===========================================================================
3305:     * KeyPressContarls - F4/F5: lookup Conta x Emp (SIGSYACC.cdcontas)
3306:     *===========================================================================
3307:     PROCEDURE KeyPressContarls(par_nKeyCode, par_nShiftAltCtrl)
3308:         LOCAL loc_oCnt, loc_oForm
3309:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
3310:             TRY
3311:                 loc_oCnt  = THIS.pgf_4c_Paginas.Pages(2).cnt_4c_Page1
3312:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
3313:                     "SIGSYACC", "cdcontas", "grcontas", ;
3314:                     "Conta x Emp", "", ;
3315:                     ALLTRIM(loc_oCnt.txt_4c_CONTARLS.Value))
3316:                 IF VARTYPE(loc_oForm) = "O"
3317:                     loc_oForm.Show()
3318:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
3319:                         loc_oCnt.txt_4c_CONTARLS.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
3320:                     ENDIF
3321:                 ENDIF
3322:             CATCH TO loc_oErro
3323:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressContarls")
3324:             ENDTRY
3325:             par_nKeyCode = 0
3326:         ENDIF
3327:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
3328:             KEYBOARD CHR(9)
3329:         ENDIF
3330:     ENDPROC
3331: 
3332:     *===========================================================================
3333:     * CmdCtaCtgClick - Abre cadastro de contas contabeis (SigCtCtg)
3334:     *===========================================================================
3335:     PROCEDURE CmdCtaCtgClick
3336:         LOCAL loc_oCnt, loc_cCodEmp
3337:         TRY
3338:             loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
3339:             loc_cCodEmp = ALLTRIM(loc_oCnt.txt_4c_Codigo.Value)
3340:             IF EMPTY(loc_cCodEmp)
3341:                 MsgAviso("Selecione uma empresa antes de abrir Contas Cont" + CHR(225) + "beis.")
3342:             ELSE
3343:                 MsgAviso("Cadastro de Contas Cont" + CHR(225) + "beis n" + CHR(227) + "o migrado ainda." + CHR(13) + ;
3344:                     "Empresa: " + loc_cCodEmp)
3345:             ENDIF
3346:         CATCH TO loc_oErro
3347:             MsgErro(loc_oErro.Message, "Formemp.CmdCtaCtgClick")
3348:         ENDTRY
3349:     ENDPROC
3350: 
3351:     *===========================================================================
3352:     * ConfigurarSubPage2 - Aba Operacional: impressora, boleto, PinPad, etc.
3353:     *===========================================================================
3354:     PROCEDURE ConfigurarSubPage2(par_oPagina)
3355:         LOCAL loc_oCnt
3356:         loc_oCnt = par_oPagina.cnt_4c_Page2
3357: 
3358:         *-- Imprime Carne / Numeracao Automatica
3359:         loc_oCnt.AddObject("lbl_4c_Label17", "Label")
3360:         WITH loc_oCnt.lbl_4c_Label17
3361:             .Top      = 95
3362:             .Left     = 116
3363:             .Width    = 79
3364:             .Height   = 15
3365:             .AutoSize = .F.
3366:             .Caption  = "Imprime Carn" + CHR(233) + " :"
3367:             .FontName = "Tahoma"
3368:             .FontSize = 8
3369:             .Visible  = .T.
3370:         ENDWITH
3371: 
3372:         loc_oCnt.AddObject("txt_4c_Impc", "TextBox")
3373:         WITH loc_oCnt.txt_4c_Impc
3374:             .Top       = 91
3375:             .Left      = 197
3376:             .Width     = 15
3377:             .Height    = 24
3378:             .MaxLength = 1
3379:             .FontName  = "Tahoma"
3380:             .FontSize  = 8
3381:             .Visible   = .T.
3382:         ENDWITH
3383: 
3384:         loc_oCnt.AddObject("lbl_4c_Label18", "Label")
3385:         WITH loc_oCnt.lbl_4c_Label18
3386:             .Top      = 96
3387:             .Left     = 216
3388:             .Width    = 30
3389:             .Height   = 15
3390:             .AutoSize = .F.
3391:             .Caption  = "[S/N]"
3392:             .FontName = "Tahoma"
3393:             .FontSize = 8
3394:             .Visible  = .T.

*-- Linhas 3608 a 3651:
3608:             .FontSize = 8
3609:             .Visible  = .T.
3610:         ENDWITH
3611:         BINDEVENT(loc_oCnt.txt_4c__CodServs, "KeyPress", THIS, "KeyPressCodServs")
3612: 
3613:         loc_oCnt.AddObject("txt_4c_Dservs", "TextBox")
3614:         WITH loc_oCnt.txt_4c_Dservs
3615:             .Top      = 169
3616:             .Left     = 512
3617:             .Width    = 411
3618:             .Height   = 24
3619:             .ReadOnly = .T.
3620:             .FontName = "Tahoma"
3621:             .FontSize = 8
3622:             .Visible  = .T.
3623:         ENDWITH
3624: 
3625:         *-- Estoque / Diferenca Pesagem / Adicional
3626:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
3627:         WITH loc_oCnt.lbl_4c_Label5
3628:             .Top      = 199
3629:             .Left     = 147
3630:             .Width    = 48
3631:             .Height   = 15
3632:             .AutoSize = .F.
3633:             .Caption  = "Estoque :"
3634:             .FontName = "Tahoma"
3635:             .FontSize = 8
3636:             .Visible  = .T.
3637:         ENDWITH
3638: 
3639:         loc_oCnt.AddObject("txt_4c_Estoque", "TextBox")
3640:         WITH loc_oCnt.txt_4c_Estoque
3641:             .Top       = 196
3642:             .Left      = 197
3643:             .Width     = 15
3644:             .Height    = 23
3645:             .MaxLength = 1
3646:             .FontName  = "Tahoma"
3647:             .FontSize  = 8
3648:             .Visible   = .T.
3649:         ENDWITH
3650: 
3651:         loc_oCnt.AddObject("lbl_4c_Label20", "Label")

*-- Linhas 3836 a 3879:
3836:             .FontSize = 8
3837:             .Visible  = .T.
3838:         ENDWITH
3839:         BINDEVENT(loc_oCnt.txt_4c__TpTrans, "KeyPress", THIS, "KeyPressTpTrans")
3840: 
3841:         *-- Credito de Bonus
3842:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
3843:         WITH loc_oCnt.lbl_4c_Label1
3844:             .Top      = 250
3845:             .Left     = 338
3846:             .Width    = 90
3847:             .Height   = 15
3848:             .AutoSize = .F.
3849:             .Caption  = "Cr" + CHR(233) + "dito de B" + CHR(244) + "nus :"
3850:             .FontName = "Tahoma"
3851:             .FontSize = 8
3852:             .Visible  = .T.
3853:         ENDWITH
3854: 
3855:         loc_oCnt.AddObject("txt_4c_PercCreds", "TextBox")
3856:         WITH loc_oCnt.txt_4c_PercCreds
3857:             .Top      = 246
3858:             .Left     = 430
3859:             .Width    = 52
3860:             .Height   = 23
3861:             .FontName = "Tahoma"
3862:             .FontSize = 8
3863:             .Visible  = .T.
3864:         ENDWITH
3865: 
3866:         loc_oCnt.AddObject("lbl_4c_Label35", "Label")
3867:         WITH loc_oCnt.lbl_4c_Label35
3868:             .Top      = 250
3869:             .Left     = 485
3870:             .Width    = 15
3871:             .Height   = 15
3872:             .AutoSize = .F.
3873:             .Caption  = "%"
3874:             .FontName = "Tahoma"
3875:             .FontSize = 8
3876:             .Visible  = .T.
3877:         ENDWITH
3878: 
3879:         *-- Comissao de Vendedores / %

*-- Linhas 3914 a 4101:
3914:             .Visible  = .T.
3915:         ENDWITH
3916: 
3917:         *-- Calculo de Custo (OptionGroup)
3918:         loc_oCnt.AddObject("lbl_4c_Label11", "Label")
3919:         WITH loc_oCnt.lbl_4c_Label11
3920:             .Top      = 239
3921:             .Left     = 610
3922:             .Width    = 89
3923:             .Height   = 15
3924:             .AutoSize = .F.
3925:             .Caption  = "C" + CHR(225) + "lculo de Custo :"
3926:             .FontName = "Tahoma"
3927:             .FontSize = 8
3928:             .Visible  = .T.
3929:         ENDWITH
3930: 
3931:         loc_oCnt.AddObject("obj_4c_OPTCALCCUSTOS", "OptionGroup")
3932:         WITH loc_oCnt.obj_4c_OPTCALCCUSTOS
3933:             .Top         = 235
3934:             .Left        = 699
3935:             .Width       = 214
3936:             .Height      = 23
3937:             .ButtonCount = 2
3938:             .Value       = 1
3939:             .BackStyle   = 0
3940:             .BorderStyle = 0
3941:             .Visible     = .T.
3942:             WITH .Buttons(1)
3943:                 .Caption = "Tabela"
3944:                 .Value   = 0
3945:                 .Top     = 0
3946:                 .Left    = 0
3947:                 .Width   = 107
3948:                 .Height  = 23
3949:             ENDWITH
3950:             WITH .Buttons(2)
3951:                 .Caption = "M" + CHR(233) + "dia"
3952:                 .Value   = 0
3953:                 .Top     = 0
3954:                 .Left    = 107
3955:                 .Width   = 107
3956:                 .Height  = 23
3957:             ENDWITH
3958:         ENDWITH
3959: 
3960:         *-- Comissao por (OptionGroup)
3961:         loc_oCnt.AddObject("lbl_4c_Label27", "Label")
3962:         WITH loc_oCnt.lbl_4c_Label27
3963:             .Top      = 220
3964:             .Left     = 626
3965:             .Width    = 73
3966:             .Height   = 15
3967:             .AutoSize = .F.
3968:             .Caption  = "Comiss" + CHR(227) + "o por :"
3969:             .FontName = "Tahoma"
3970:             .FontSize = 8
3971:             .Visible  = .T.
3972:         ENDWITH
3973: 
3974:         loc_oCnt.AddObject("obj_4c_Opc_comis", "OptionGroup")
3975:         WITH loc_oCnt.obj_4c_Opc_comis
3976:             .Top         = 215
3977:             .Left        = 698
3978:             .Width       = 222
3979:             .Height      = 25
3980:             .ButtonCount = 2
3981:             .Value       = 1
3982:             .BackStyle   = 0
3983:             .BorderStyle = 0
3984:             .Visible     = .T.
3985:             WITH .Buttons(1)
3986:                 .Caption = "Venda"
3987:                 .Value   = 0
3988:                 .Top     = 0
3989:                 .Left    = 0
3990:                 .Width   = 111
3991:                 .Height  = 25
3992:             ENDWITH
3993:             WITH .Buttons(2)
3994:                 .Caption = "Recebimento"
3995:                 .Value   = 0
3996:                 .Top     = 0
3997:                 .Left    = 111
3998:                 .Width   = 111
3999:                 .Height  = 25
4000:             ENDWITH
4001:         ENDWITH
4002: 
4003:         *-- Agrupar MRCF (OptionGroup)
4004:         loc_oCnt.AddObject("lbl_4c_Label28", "Label")
4005:         WITH loc_oCnt.lbl_4c_Label28
4006:             .Top      = 257
4007:             .Left     = 620
4008:             .Width    = 79
4009:             .Height   = 15
4010:             .AutoSize = .F.
4011:             .Caption  = "Agrupar MRCF :"
4012:             .FontName = "Tahoma"
4013:             .FontSize = 8
4014:             .Visible  = .T.
4015:         ENDWITH
4016: 
4017:         loc_oCnt.AddObject("obj_4c_OPT_ALTTRANS", "OptionGroup")
4018:         WITH loc_oCnt.obj_4c_OPT_ALTTRANS
4019:             .Top         = 256
4020:             .Left        = 698
4021:             .Width       = 120
4022:             .Height      = 15
4023:             .ButtonCount = 2
4024:             .Value       = 1
4025:             .BackStyle   = 0
4026:             .BorderStyle = 0
4027:             .Visible     = .T.
4028:             WITH .Buttons(1)
4029:                 .Caption = "Sim"
4030:                 .Value   = 0
4031:                 .Top     = 0
4032:                 .Left    = 0
4033:                 .Width   = 60
4034:                 .Height  = 15
4035:             ENDWITH
4036:             WITH .Buttons(2)
4037:                 .Caption = "N" + CHR(227) + "o"
4038:                 .Value   = 0
4039:                 .Top     = 0
4040:                 .Left    = 60
4041:                 .Width   = 60
4042:                 .Height  = 15
4043:             ENDWITH
4044:         ENDWITH
4045: 
4046:         *-- Empresa na Tela de Briefing (OptionGroup 5 botoes)
4047:         loc_oCnt.AddObject("lbl_4c_Label40", "Label")
4048:         WITH loc_oCnt.lbl_4c_Label40
4049:             .Top      = 275
4050:             .Left     = 557
4051:             .Width    = 142
4052:             .Height   = 15
4053:             .AutoSize = .F.
4054:             .Caption  = "Empresa na Tela de Briefing :"
4055:             .FontName = "Tahoma"
4056:             .FontSize = 8
4057:             .Visible  = .T.
4058:         ENDWITH
4059: 
4060:         loc_oCnt.AddObject("obj_4c_Optiongroup1", "OptionGroup")
4061:         WITH loc_oCnt.obj_4c_Optiongroup1
4062:             .Top         = 270
4063:             .Left        = 698
4064:             .Width       = 313
4065:             .Height      = 23
4066:             .ButtonCount = 5
4067:             .Value       = 1
4068:             .BackStyle   = 0
4069:             .BorderStyle = 0
4070:             .Visible     = .T.
4071:             WITH .Buttons(1)
4072:                 .Caption = "N" + CHR(227) + "o"
4073:                 .Value   = 0
4074:                 .Top     = 0
4075:                 .Left    = 0
4076:                 .Width   = 62
4077:                 .Height  = 23
4078:             ENDWITH
4079:             WITH .Buttons(2)
4080:                 .Caption = "1"
4081:                 .Value   = 0
4082:                 .Top     = 0
4083:                 .Left    = 62
4084:                 .Width   = 62
4085:                 .Height  = 23
4086:             ENDWITH
4087:             WITH .Buttons(3)
4088:                 .Caption = "2"
4089:                 .Value   = 0
4090:                 .Top     = 0
4091:                 .Left    = 124
4092:                 .Width   = 63
4093:                 .Height  = 23
4094:             ENDWITH
4095:             WITH .Buttons(4)
4096:                 .Caption = "3"
4097:                 .Value   = 0
4098:                 .Top     = 0
4099:                 .Left    = 187
4100:                 .Width   = 63
4101:                 .Height  = 23

*-- Linhas 4110 a 4210:
4110:             ENDWITH
4111:         ENDWITH
4112: 
4113:         *-- Ignorar no E-Commerce (OptionGroup)
4114:         loc_oCnt.AddObject("lbl_4c_Label39", "Label")
4115:         WITH loc_oCnt.lbl_4c_Label39
4116:             .Top      = 202
4117:             .Left     = 576
4118:             .Width    = 123
4119:             .Height   = 15
4120:             .AutoSize = .F.
4121:             .Caption  = "Ignorar no E-Commerce :"
4122:             .FontName = "Tahoma"
4123:             .FontSize = 8
4124:             .Visible  = .T.
4125:         ENDWITH
4126: 
4127:         loc_oCnt.AddObject("obj_4c_Optiongroup2", "OptionGroup")
4128:         WITH loc_oCnt.obj_4c_Optiongroup2
4129:             .Top         = 201
4130:             .Left        = 698
4131:             .Width       = 120
4132:             .Height      = 15
4133:             .ButtonCount = 2
4134:             .Value       = 2
4135:             .BackStyle   = 0
4136:             .BorderStyle = 0
4137:             .Visible     = .T.
4138:             WITH .Buttons(1)
4139:                 .Caption = "Sim"
4140:                 .Value   = 0
4141:                 .Top     = 0
4142:                 .Left    = 0
4143:                 .Width   = 60
4144:                 .Height  = 15
4145:             ENDWITH
4146:             WITH .Buttons(2)
4147:                 .Caption = "N" + CHR(227) + "o"
4148:                 .Value   = 0
4149:                 .Top     = 0
4150:                 .Left    = 60
4151:                 .Width   = 60
4152:                 .Height  = 15
4153:             ENDWITH
4154:         ENDWITH
4155: 
4156:         *-- Permite Alterar Data da Movimentacao (OptionGroup)
4157:         loc_oCnt.AddObject("lbl_4c_label52", "Label")
4158:         WITH loc_oCnt.lbl_4c_label52
4159:             .Top      = 295
4160:             .Left     = 508
4161:             .Width    = 191
4162:             .Height   = 15
4163:             .AutoSize = .F.
4164:             .Caption  = "Permite Alterar Data da Movimenta" + CHR(231) + CHR(227) + "o:"
4165:             .FontName = "Tahoma"
4166:             .FontSize = 8
4167:             .Visible  = .T.
4168:         ENDWITH
4169: 
4170:         loc_oCnt.AddObject("obj_4c_Op_blqdt", "OptionGroup")
4171:         WITH loc_oCnt.obj_4c_Op_blqdt
4172:             .Top         = 291
4173:             .Left        = 698
4174:             .Width       = 209
4175:             .Height      = 21
4176:             .ButtonCount = 2
4177:             .Value       = 2
4178:             .BackStyle   = 0
4179:             .BorderStyle = 0
4180:             .Visible     = .T.
4181:             WITH .Buttons(1)
4182:                 .Caption = "Sim"
4183:                 .Value   = 0
4184:                 .Top     = 0
4185:                 .Left    = 0
4186:                 .Width   = 104
4187:                 .Height  = 21
4188:             ENDWITH
4189:             WITH .Buttons(2)
4190:                 .Caption = "N" + CHR(227) + "o"
4191:                 .Value   = 0
4192:                 .Top     = 0
4193:                 .Left    = 104
4194:                 .Width   = 105
4195:                 .Height  = 21
4196:             ENDWITH
4197:         ENDWITH
4198: 
4199:         *-- Invoice CBD / SISPAG (Banco/Agencia/Conta/DAC)
4200:         loc_oCnt.AddObject("lbl_4c_Label4", "Label")
4201:         WITH loc_oCnt.lbl_4c_Label4
4202:             .Top      = 346
4203:             .Left     = 353
4204:             .Width    = 113
4205:             .Height   = 15
4206:             .AutoSize = .F.
4207:             .Caption  = "Invoice CBD / SISPAG :"
4208:             .FontName = "Tahoma"
4209:             .FontSize = 8
4210:             .Visible  = .T.

*-- Linhas 4330 a 4373:
4330:             .FontSize = 8
4331:             .Visible  = .T.
4332:         ENDWITH
4333:         BINDEVENT(loc_oCnt.txt_4c_Dope_int, "KeyPress", THIS, "KeyPressDopEInt")
4334: 
4335:         *-- SEDEX
4336:         loc_oCnt.AddObject("lbl_4c_Label29", "Label")
4337:         WITH loc_oCnt.lbl_4c_Label29
4338:             .Top      = 328
4339:             .Left     = 17
4340:             .Width    = 36
4341:             .Height   = 15
4342:             .AutoSize = .F.
4343:             .Caption  = "SEDEX"
4344:             .FontName = "Tahoma"
4345:             .FontSize = 8
4346:             .Visible  = .T.
4347:         ENDWITH
4348: 
4349:         loc_oCnt.AddObject("lbl_4c_Label31", "Label")
4350:         WITH loc_oCnt.lbl_4c_Label31
4351:             .Top      = 341
4352:             .Left     = 76
4353:             .Width    = 67
4354:             .Height   = 15
4355:             .AutoSize = .F.
4356:             .Caption  = "N" + CHR(186) + " Contrato :"
4357:             .FontName = "Tahoma"
4358:             .FontSize = 8
4359:             .Visible  = .T.
4360:         ENDWITH
4361: 
4362:         loc_oCnt.AddObject("txt_4c_Contrato", "TextBox")
4363:         WITH loc_oCnt.txt_4c_Contrato
4364:             .Top      = 338
4365:             .Left     = 145
4366:             .Width    = 157
4367:             .Height   = 23
4368:             .FontName = "Tahoma"
4369:             .FontSize = 8
4370:             .Visible  = .T.
4371:         ENDWITH
4372: 
4373:         loc_oCnt.AddObject("lbl_4c_Label32", "Label")

*-- Linhas 4565 a 4706:
4565:             .FontSize = 8
4566:             .Visible  = .T.
4567:         ENDWITH
4568:         BINDEVENT(loc_oCnt.txt_4c_Saicol, "KeyPress", THIS, "KeyPressSaicol")
4569: 
4570:         loc_oCnt.AddObject("lbl_4c_Label53", "Label")
4571:         WITH loc_oCnt.lbl_4c_Label53
4572:             .Top      = 522
4573:             .Left     = 488
4574:             .Width    = 87
4575:             .Height   = 15
4576:             .AutoSize = .F.
4577:             .Caption  = "Senha do CDL Rio"
4578:             .FontName = "Tahoma"
4579:             .FontSize = 8
4580:             .Visible  = .T.
4581:         ENDWITH
4582: 
4583:         loc_oCnt.AddObject("txt_4c_Cdlsenhas", "TextBox")
4584:         WITH loc_oCnt.txt_4c_Cdlsenhas
4585:             .Top      = 538
4586:             .Left     = 488
4587:             .Width    = 120
4588:             .Height   = 23
4589:             .FontName = "Tahoma"
4590:             .FontSize = 8
4591:             .Visible  = .T.
4592:         ENDWITH
4593:     ENDPROC
4594: 
4595:     *===========================================================================
4596:     * ConfigurarSubPage3 - Aba Fiscal: grupos/contas contabeis, NFe, config fiscal
4597:     *===========================================================================
4598:     PROCEDURE ConfigurarSubPage3(par_oPagina)
4599:         LOCAL loc_oCnt
4600:         loc_oCnt = par_oPagina.cnt_4c_Page3
4601: 
4602:         *-- Header: Lancamentos Fiscais
4603:         loc_oCnt.AddObject("lbl_4c_Label20", "Label")
4604:         WITH loc_oCnt.lbl_4c_Label20
4605:             .Top      = 130
4606:             .Left     = 18
4607:             .Width    = 130
4608:             .Height   = 15
4609:             .AutoSize = .F.
4610:             .Caption  = "Lan" + CHR(231) + "amentos Fiscais"
4611:             .FontName = "Tahoma"
4612:             .FontSize = 8
4613:             .FontBold = .T.
4614:             .Visible  = .T.
4615:         ENDWITH
4616: 
4617:         *-- Moeda / CFOP
4618:         loc_oCnt.AddObject("lbl_4c_Label12", "Label")
4619:         WITH loc_oCnt.lbl_4c_Label12
4620:             .Top      = 130
4621:             .Left     = 178
4622:             .Width    = 46
4623:             .Height   = 15
4624:             .AutoSize = .F.
4625:             .Caption  = "Moeda :"
4626:             .FontName = "Tahoma"
4627:             .FontSize = 8
4628:             .Visible  = .T.
4629:         ENDWITH
4630: 
4631:         loc_oCnt.AddObject("txt_4c_Mctotal", "TextBox")
4632:         WITH loc_oCnt.txt_4c_Mctotal
4633:             .Top      = 126
4634:             .Left     = 226
4635:             .Width    = 31
4636:             .Height   = 23
4637:             .FontName = "Tahoma"
4638:             .FontSize = 8
4639:             .Visible  = .T.
4640:         ENDWITH
4641:         BINDEVENT(loc_oCnt.txt_4c_Mctotal, "KeyPress", THIS, "KeyPressMctotal")
4642: 
4643:         loc_oCnt.AddObject("lbl_4c_Label25", "Label")
4644:         WITH loc_oCnt.lbl_4c_Label25
4645:             .Top      = 130
4646:             .Left     = 297
4647:             .Width    = 41
4648:             .Height   = 15
4649:             .AutoSize = .F.
4650:             .Caption  = "CFOP :"
4651:             .FontName = "Tahoma"
4652:             .FontSize = 8
4653:             .Visible  = .T.
4654:         ENDWITH
4655: 
4656:         loc_oCnt.AddObject("txt_4c_Cfo_Int", "TextBox")
4657:         WITH loc_oCnt.txt_4c_Cfo_Int
4658:             .Top      = 126
4659:             .Left     = 340
4660:             .Width    = 91
4661:             .Height   = 23
4662:             .FontName = "Tahoma"
4663:             .FontSize = 8
4664:             .Visible  = .T.
4665:         ENDWITH
4666:         BINDEVENT(loc_oCnt.txt_4c_Cfo_Int, "KeyPress", THIS, "KeyPressCfoInt")
4667: 
4668:         *-- Cabecalhos da tabela contabil
4669:         loc_oCnt.AddObject("lbl_4c_Label5", "Label")
4670:         WITH loc_oCnt.lbl_4c_Label5
4671:             .Top      = 155
4672:             .Left     = 16
4673:             .Width    = 40
4674:             .Height   = 15
4675:             .AutoSize = .F.
4676:             .Caption  = "Valor"
4677:             .FontName = "Tahoma"
4678:             .FontSize = 8
4679:             .FontBold = .T.
4680:             .Visible  = .T.
4681:         ENDWITH
4682: 
4683:         loc_oCnt.AddObject("lbl_4c_Label11", "Label")
4684:         WITH loc_oCnt.lbl_4c_Label11
4685:             .Top      = 156
4686:             .Left     = 67
4687:             .Width    = 40
4688:             .Height   = 15
4689:             .AutoSize = .F.
4690:             .Caption  = "D" + CHR(233) + "bito"
4691:             .FontName = "Tahoma"
4692:             .FontSize = 8
4693:             .FontBold = .T.
4694:             .Visible  = .T.
4695:         ENDWITH
4696: 
4697:         loc_oCnt.AddObject("lbl_4c_Label10", "Label")
4698:         WITH loc_oCnt.lbl_4c_Label10
4699:             .Top      = 156
4700:             .Left     = 370
4701:             .Width    = 40
4702:             .Height   = 15
4703:             .AutoSize = .F.
4704:             .Caption  = "Cr" + CHR(233) + "dito"
4705:             .FontName = "Tahoma"
4706:             .FontSize = 8

*-- Linhas 4836 a 5216:
4836:             .FontSize = 8
4837:             .Visible  = .T.
4838:         ENDWITH
4839:         BINDEVENT(loc_oCnt.txt_4c__GRUPOO, "KeyPress", THIS, "KeyPressGrupoContabil")
4840: 
4841:         loc_oCnt.AddObject("txt_4c__CONTAO", "TextBox")
4842:         WITH loc_oCnt.txt_4c__CONTAO
4843:             .Top      = 193
4844:             .Left     = 147
4845:             .Width    = 78
4846:             .Height   = 21
4847:             .FontName = "Tahoma"
4848:             .FontSize = 8
4849:             .Visible  = .T.
4850:         ENDWITH
4851:         BINDEVENT(loc_oCnt.txt_4c__CONTAO, "KeyPress", THIS, "KeyPressContaContabil")
4852: 
4853:         loc_oCnt.AddObject("txt_4c_Dcontao", "TextBox")
4854:         WITH loc_oCnt.txt_4c_Dcontao
4855:             .Top      = 193
4856:             .Left     = 227
4857:             .Width    = 134
4858:             .Height   = 21
4859:             .ReadOnly = .T.
4860:             .FontName = "Tahoma"
4861:             .FontSize = 8
4862:             .Visible  = .T.
4863:         ENDWITH
4864: 
4865:         loc_oCnt.AddObject("txt_4c__GRUICMO", "TextBox")
4866:         WITH loc_oCnt.txt_4c__GRUICMO
4867:             .Top      = 216
4868:             .Left     = 64
4869:             .Width    = 78
4870:             .Height   = 21
4871:             .FontName = "Tahoma"
4872:             .FontSize = 8
4873:             .Visible  = .T.
4874:         ENDWITH
4875:         BINDEVENT(loc_oCnt.txt_4c__GRUICMO, "KeyPress", THIS, "KeyPressGrupoContabil")
4876: 
4877:         loc_oCnt.AddObject("txt_4c__CONICMO", "TextBox")
4878:         WITH loc_oCnt.txt_4c__CONICMO
4879:             .Top      = 216
4880:             .Left     = 147
4881:             .Width    = 78
4882:             .Height   = 21
4883:             .FontName = "Tahoma"
4884:             .FontSize = 8
4885:             .Visible  = .T.
4886:         ENDWITH
4887:         BINDEVENT(loc_oCnt.txt_4c__CONICMO, "KeyPress", THIS, "KeyPressContaContabil")
4888: 
4889:         loc_oCnt.AddObject("txt_4c_DconIcmo", "TextBox")
4890:         WITH loc_oCnt.txt_4c_DconIcmo
4891:             .Top      = 216
4892:             .Left     = 227
4893:             .Width    = 134
4894:             .Height   = 21
4895:             .ReadOnly = .T.
4896:             .FontName = "Tahoma"
4897:             .FontSize = 8
4898:             .Visible  = .T.
4899:         ENDWITH
4900: 
4901:         loc_oCnt.AddObject("txt_4c__GRUIPIO", "TextBox")
4902:         WITH loc_oCnt.txt_4c__GRUIPIO
4903:             .Top      = 239
4904:             .Left     = 64
4905:             .Width    = 78
4906:             .Height   = 21
4907:             .FontName = "Tahoma"
4908:             .FontSize = 8
4909:             .Visible  = .T.
4910:         ENDWITH
4911:         BINDEVENT(loc_oCnt.txt_4c__GRUIPIO, "KeyPress", THIS, "KeyPressGrupoContabil")
4912: 
4913:         loc_oCnt.AddObject("txt_4c__CONIPIO", "TextBox")
4914:         WITH loc_oCnt.txt_4c__CONIPIO
4915:             .Top      = 239
4916:             .Left     = 147
4917:             .Width    = 78
4918:             .Height   = 21
4919:             .FontName = "Tahoma"
4920:             .FontSize = 8
4921:             .Visible  = .T.
4922:         ENDWITH
4923:         BINDEVENT(loc_oCnt.txt_4c__CONIPIO, "KeyPress", THIS, "KeyPressContaContabil")
4924: 
4925:         loc_oCnt.AddObject("txt_4c_DconIpio", "TextBox")
4926:         WITH loc_oCnt.txt_4c_DconIpio
4927:             .Top      = 239
4928:             .Left     = 227
4929:             .Width    = 134
4930:             .Height   = 21
4931:             .ReadOnly = .T.
4932:             .FontName = "Tahoma"
4933:             .FontSize = 8
4934:             .Visible  = .T.
4935:         ENDWITH
4936: 
4937:         loc_oCnt.AddObject("txt_4c__GRUPISO", "TextBox")
4938:         WITH loc_oCnt.txt_4c__GRUPISO
4939:             .Top      = 262
4940:             .Left     = 64
4941:             .Width    = 78
4942:             .Height   = 21
4943:             .FontName = "Tahoma"
4944:             .FontSize = 8
4945:             .Visible  = .T.
4946:         ENDWITH
4947:         BINDEVENT(loc_oCnt.txt_4c__GRUPISO, "KeyPress", THIS, "KeyPressGrupoContabil")
4948: 
4949:         loc_oCnt.AddObject("txt_4c__CONPISO", "TextBox")
4950:         WITH loc_oCnt.txt_4c__CONPISO
4951:             .Top      = 262
4952:             .Left     = 147
4953:             .Width    = 78
4954:             .Height   = 21
4955:             .FontName = "Tahoma"
4956:             .FontSize = 8
4957:             .Visible  = .T.
4958:         ENDWITH
4959:         BINDEVENT(loc_oCnt.txt_4c__CONPISO, "KeyPress", THIS, "KeyPressContaContabil")
4960: 
4961:         loc_oCnt.AddObject("txt_4c_DconPiso", "TextBox")
4962:         WITH loc_oCnt.txt_4c_DconPiso
4963:             .Top      = 262
4964:             .Left     = 227
4965:             .Width    = 134
4966:             .Height   = 21
4967:             .ReadOnly = .T.
4968:             .FontName = "Tahoma"
4969:             .FontSize = 8
4970:             .Visible  = .T.
4971:         ENDWITH
4972: 
4973:         loc_oCnt.AddObject("txt_4c__GRUCONO", "TextBox")
4974:         WITH loc_oCnt.txt_4c__GRUCONO
4975:             .Top      = 285
4976:             .Left     = 64
4977:             .Width    = 78
4978:             .Height   = 21
4979:             .FontName = "Tahoma"
4980:             .FontSize = 8
4981:             .Visible  = .T.
4982:         ENDWITH
4983:         BINDEVENT(loc_oCnt.txt_4c__GRUCONO, "KeyPress", THIS, "KeyPressGrupoContabil")
4984: 
4985:         loc_oCnt.AddObject("txt_4c__CONCONO", "TextBox")
4986:         WITH loc_oCnt.txt_4c__CONCONO
4987:             .Top      = 285
4988:             .Left     = 147
4989:             .Width    = 78
4990:             .Height   = 21
4991:             .FontName = "Tahoma"
4992:             .FontSize = 8
4993:             .Visible  = .T.
4994:         ENDWITH
4995:         BINDEVENT(loc_oCnt.txt_4c__CONCONO, "KeyPress", THIS, "KeyPressContaContabil")
4996: 
4997:         loc_oCnt.AddObject("txt_4c_DconCono", "TextBox")
4998:         WITH loc_oCnt.txt_4c_DconCono
4999:             .Top      = 285
5000:             .Left     = 227
5001:             .Width    = 134
5002:             .Height   = 21
5003:             .ReadOnly = .T.
5004:             .FontName = "Tahoma"
5005:             .FontSize = 8
5006:             .Visible  = .T.
5007:         ENDWITH
5008: 
5009:         *-- Grupo/Conta Contabil Dev (Contabil / ICMS / IPI / PIS / COFINS)
5010:         loc_oCnt.AddObject("txt_4c__GRUPOD", "TextBox")
5011:         WITH loc_oCnt.txt_4c__GRUPOD
5012:             .Top      = 193
5013:             .Left     = 366
5014:             .Width    = 78
5015:             .Height   = 21
5016:             .FontName = "Tahoma"
5017:             .FontSize = 8
5018:             .Visible  = .T.
5019:         ENDWITH
5020:         BINDEVENT(loc_oCnt.txt_4c__GRUPOD, "KeyPress", THIS, "KeyPressGrupoContabil")
5021: 
5022:         loc_oCnt.AddObject("txt_4c__CONTAD", "TextBox")
5023:         WITH loc_oCnt.txt_4c__CONTAD
5024:             .Top      = 193
5025:             .Left     = 449
5026:             .Width    = 78
5027:             .Height   = 21
5028:             .FontName = "Tahoma"
5029:             .FontSize = 8
5030:             .Visible  = .T.
5031:         ENDWITH
5032:         BINDEVENT(loc_oCnt.txt_4c__CONTAD, "KeyPress", THIS, "KeyPressContaContabil")
5033: 
5034:         loc_oCnt.AddObject("txt_4c_Dcontad", "TextBox")
5035:         WITH loc_oCnt.txt_4c_Dcontad
5036:             .Top      = 193
5037:             .Left     = 530
5038:             .Width    = 149
5039:             .Height   = 21
5040:             .ReadOnly = .T.
5041:             .FontName = "Tahoma"
5042:             .FontSize = 8
5043:             .Visible  = .T.
5044:         ENDWITH
5045: 
5046:         loc_oCnt.AddObject("txt_4c__GRUICMD", "TextBox")
5047:         WITH loc_oCnt.txt_4c__GRUICMD
5048:             .Top      = 216
5049:             .Left     = 366
5050:             .Width    = 78
5051:             .Height   = 21
5052:             .FontName = "Tahoma"
5053:             .FontSize = 8
5054:             .Visible  = .T.
5055:         ENDWITH
5056:         BINDEVENT(loc_oCnt.txt_4c__GRUICMD, "KeyPress", THIS, "KeyPressGrupoContabil")
5057: 
5058:         loc_oCnt.AddObject("txt_4c__CONICMD", "TextBox")
5059:         WITH loc_oCnt.txt_4c__CONICMD
5060:             .Top      = 216
5061:             .Left     = 450
5062:             .Width    = 78
5063:             .Height   = 21
5064:             .FontName = "Tahoma"
5065:             .FontSize = 8
5066:             .Visible  = .T.
5067:         ENDWITH
5068:         BINDEVENT(loc_oCnt.txt_4c__CONICMD, "KeyPress", THIS, "KeyPressContaContabil")
5069: 
5070:         loc_oCnt.AddObject("txt_4c_DconIcmd", "TextBox")
5071:         WITH loc_oCnt.txt_4c_DconIcmd
5072:             .Top      = 216
5073:             .Left     = 530
5074:             .Width    = 149
5075:             .Height   = 21
5076:             .ReadOnly = .T.
5077:             .FontName = "Tahoma"
5078:             .FontSize = 8
5079:             .Visible  = .T.
5080:         ENDWITH
5081: 
5082:         loc_oCnt.AddObject("txt_4c__GRUIPID", "TextBox")
5083:         WITH loc_oCnt.txt_4c__GRUIPID
5084:             .Top      = 239
5085:             .Left     = 366
5086:             .Width    = 78
5087:             .Height   = 21
5088:             .FontName = "Tahoma"
5089:             .FontSize = 8
5090:             .Visible  = .T.
5091:         ENDWITH
5092:         BINDEVENT(loc_oCnt.txt_4c__GRUIPID, "KeyPress", THIS, "KeyPressGrupoContabil")
5093: 
5094:         loc_oCnt.AddObject("txt_4c__CONIPID", "TextBox")
5095:         WITH loc_oCnt.txt_4c__CONIPID
5096:             .Top      = 239
5097:             .Left     = 450
5098:             .Width    = 78
5099:             .Height   = 21
5100:             .FontName = "Tahoma"
5101:             .FontSize = 8
5102:             .Visible  = .T.
5103:         ENDWITH
5104:         BINDEVENT(loc_oCnt.txt_4c__CONIPID, "KeyPress", THIS, "KeyPressContaContabil")
5105: 
5106:         loc_oCnt.AddObject("txt_4c_Dconipid", "TextBox")
5107:         WITH loc_oCnt.txt_4c_Dconipid
5108:             .Top      = 239
5109:             .Left     = 530
5110:             .Width    = 149
5111:             .Height   = 21
5112:             .ReadOnly = .T.
5113:             .FontName = "Tahoma"
5114:             .FontSize = 8
5115:             .Visible  = .T.
5116:         ENDWITH
5117: 
5118:         loc_oCnt.AddObject("txt_4c__GRUPISD", "TextBox")
5119:         WITH loc_oCnt.txt_4c__GRUPISD
5120:             .Top      = 262
5121:             .Left     = 366
5122:             .Width    = 78
5123:             .Height   = 21
5124:             .FontName = "Tahoma"
5125:             .FontSize = 8
5126:             .Visible  = .T.
5127:         ENDWITH
5128:         BINDEVENT(loc_oCnt.txt_4c__GRUPISD, "KeyPress", THIS, "KeyPressGrupoContabil")
5129: 
5130:         loc_oCnt.AddObject("txt_4c__CONPISD", "TextBox")
5131:         WITH loc_oCnt.txt_4c__CONPISD
5132:             .Top      = 262
5133:             .Left     = 450
5134:             .Width    = 78
5135:             .Height   = 21
5136:             .FontName = "Tahoma"
5137:             .FontSize = 8
5138:             .Visible  = .T.
5139:         ENDWITH
5140:         BINDEVENT(loc_oCnt.txt_4c__CONPISD, "KeyPress", THIS, "KeyPressContaContabil")
5141: 
5142:         loc_oCnt.AddObject("txt_4c_DconPisd", "TextBox")
5143:         WITH loc_oCnt.txt_4c_DconPisd
5144:             .Top      = 262
5145:             .Left     = 530
5146:             .Width    = 149
5147:             .Height   = 21
5148:             .ReadOnly = .T.
5149:             .FontName = "Tahoma"
5150:             .FontSize = 8
5151:             .Visible  = .T.
5152:         ENDWITH
5153: 
5154:         loc_oCnt.AddObject("txt_4c__GRUCOND", "TextBox")
5155:         WITH loc_oCnt.txt_4c__GRUCOND
5156:             .Top      = 285
5157:             .Left     = 366
5158:             .Width    = 78
5159:             .Height   = 21
5160:             .FontName = "Tahoma"
5161:             .FontSize = 8
5162:             .Visible  = .T.
5163:         ENDWITH
5164:         BINDEVENT(loc_oCnt.txt_4c__GRUCOND, "KeyPress", THIS, "KeyPressGrupoContabil")
5165: 
5166:         loc_oCnt.AddObject("txt_4c__CONCOND", "TextBox")
5167:         WITH loc_oCnt.txt_4c__CONCOND
5168:             .Top      = 285
5169:             .Left     = 450
5170:             .Width    = 78
5171:             .Height   = 21
5172:             .FontName = "Tahoma"
5173:             .FontSize = 8
5174:             .Visible  = .T.
5175:         ENDWITH
5176:         BINDEVENT(loc_oCnt.txt_4c__CONCOND, "KeyPress", THIS, "KeyPressContaContabil")
5177: 
5178:         loc_oCnt.AddObject("txt_4c_DconCond", "TextBox")
5179:         WITH loc_oCnt.txt_4c_DconCond
5180:             .Top      = 285
5181:             .Left     = 530
5182:             .Width    = 149
5183:             .Height   = 21
5184:             .ReadOnly = .T.
5185:             .FontName = "Tahoma"
5186:             .FontSize = 8
5187:             .Visible  = .T.
5188:         ENDWITH
5189: 
5190:         *-- Aliq (PORCPIS / PORCCONS)
5191:         loc_oCnt.AddObject("lbl_4c_Label16", "Label")
5192:         WITH loc_oCnt.lbl_4c_Label16
5193:             .Top      = 155
5194:             .Left     = 696
5195:             .Width    = 30
5196:             .Height   = 15
5197:             .AutoSize = .F.
5198:             .Caption  = "Aliq"
5199:             .FontName = "Tahoma"
5200:             .FontSize = 8
5201:             .FontBold = .T.
5202:             .Visible  = .T.
5203:         ENDWITH
5204: 
5205:         loc_oCnt.AddObject("txt_4c__PORCPIS", "TextBox")
5206:         WITH loc_oCnt.txt_4c__PORCPIS
5207:             .Top      = 262
5208:             .Left     = 684
5209:             .Width    = 42
5210:             .Height   = 21
5211:             .FontName = "Tahoma"
5212:             .FontSize = 8
5213:             .Visible  = .T.
5214:         ENDWITH
5215: 
5216:         loc_oCnt.AddObject("txt_4c__PORCCONS", "TextBox")

*-- Linhas 5711 a 5754:
5711:     *===========================================================================
5712:     * ConfigurarSubPage4 - Aba NFC-e: chaves parceiro/contribuinte e CSC
5713:     *===========================================================================
5714:     PROCEDURE ConfigurarSubPage4(par_oPagina)
5715:         LOCAL loc_oCnt
5716:         loc_oCnt = par_oPagina.cnt_4c_Page4
5717: 
5718:         loc_oCnt.AddObject("cmd_4c_ConfGne", "CommandButton")
5719:         WITH loc_oCnt.cmd_4c_ConfGne
5720:             .Top      = 132
5721:             .Left     = 358
5722:             .Width    = 115
5723:             .Height   = 24
5724:             .Caption  = "Configura GNE"
5725:             .FontName = "Tahoma"
5726:             .FontSize = 8
5727:             .Visible  = .T.
5728:         ENDWITH
5729: 
5730:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
5731:         WITH loc_oCnt.lbl_4c_Label1
5732:             .Top      = 161
5733:             .Left     = 91
5734:             .Width    = 97
5735:             .Height   = 15
5736:             .AutoSize = .F.
5737:             .Caption  = "Chave do parceiro :"
5738:             .FontName = "Tahoma"
5739:             .FontSize = 8
5740:             .Visible  = .T.
5741:         ENDWITH
5742: 
5743:         loc_oCnt.AddObject("txt_4c__chavep", "TextBox")
5744:         WITH loc_oCnt.txt_4c__chavep
5745:             .Top      = 157
5746:             .Left     = 190
5747:             .Width    = 283
5748:             .Height   = 22
5749:             .FontName = "Tahoma"
5750:             .FontSize = 8
5751:             .Visible  = .T.
5752:         ENDWITH
5753: 
5754:         loc_oCnt.AddObject("lbl_4c_Label2", "Label")

*-- Linhas 5803 a 6165:
5803:     *===========================================================================
5804:     * KeyPressUF - F4/F5: limita a 2 letras e converte para maiusculo
5805:     *===========================================================================
5806:     PROCEDURE KeyPressUF(par_nKeyCode, par_nShiftAltCtrl)
5807:         LOCAL loc_oCnt
5808:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5809:             TRY
5810:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
5811:                 IF PEMSTATUS(loc_oCnt, "txt_4c_Est", 5)
5812:                     loc_oCnt.txt_4c_Est.Value = UPPER(ALLTRIM(loc_oCnt.txt_4c_Est.Value))
5813:                 ENDIF
5814:             CATCH TO loc_oErro
5815:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressUF")
5816:             ENDTRY
5817:             par_nKeyCode = 0
5818:         ENDIF
5819:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5820:             KEYBOARD CHR(9)
5821:         ENDIF
5822:     ENDPROC
5823: 
5824:     *===========================================================================
5825:     * KeyPressRegiao - F4/F5: lookup Regiao (SigCdReg.Regiaos)
5826:     *===========================================================================
5827:     PROCEDURE KeyPressRegiao(par_nKeyCode, par_nShiftAltCtrl)
5828:         LOCAL loc_oCnt, loc_oForm
5829:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5830:             TRY
5831:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page1
5832:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5833:                     "SigCdReg", "cursor_4c_BuscaReg", "Regiaos", ;
5834:                     ALLTRIM(loc_oCnt.txt_4c_REGIAOS.Value), ;
5835:                     "Regi" + CHR(227) + "o")
5836:                 IF VARTYPE(loc_oForm) = "O"
5837:                     loc_oForm.mAddColuna("Regiaos", "!!!!!!!!", "C" + CHR(243) + "d.")
5838:                     loc_oForm.mAddColuna("descs", "@!!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
5839:                     loc_oForm.Show()
5840:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaReg")
5841:                         SELECT cursor_4c_BuscaReg
5842:                         loc_oCnt.txt_4c_REGIAOS.Value = ALLTRIM(cursor_4c_BuscaReg.Regiaos)
5843:                     ENDIF
5844:                     IF USED("cursor_4c_BuscaReg")
5845:                         USE IN cursor_4c_BuscaReg
5846:                     ENDIF
5847:                     loc_oForm.Release()
5848:                 ENDIF
5849:             CATCH TO loc_oErro
5850:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressRegiao")
5851:             ENDTRY
5852:             par_nKeyCode = 0
5853:         ENDIF
5854:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5855:             KEYBOARD CHR(9)
5856:         ENDIF
5857:     ENDPROC
5858: 
5859:     *===========================================================================
5860:     * KeyPressCodServs - F4/F5: lookup Cod. Servico Saida (SigCdOpe.Dopes)
5861:     *===========================================================================
5862:     PROCEDURE KeyPressCodServs(par_nKeyCode, par_nShiftAltCtrl)
5863:         LOCAL loc_oCnt, loc_oForm
5864:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5865:             TRY
5866:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
5867:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5868:                     "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", ;
5869:                     ALLTRIM(loc_oCnt.txt_4c__CodServs.Value), ;
5870:                     "C" + CHR(243) + "d. Servi" + CHR(231) + "o Sa" + CHR(237) + "da")
5871:                 IF VARTYPE(loc_oForm) = "O"
5872:                     loc_oForm.mAddColuna("Dopes", "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Opera" + CHR(231) + CHR(227) + "o")
5873:                     loc_oForm.Show()
5874:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
5875:                         SELECT cursor_4c_BuscaOpe
5876:                         loc_oCnt.txt_4c__CodServs.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
5877:                         loc_oCnt.txt_4c_Dservs.Value    = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
5878:                     ENDIF
5879:                     IF USED("cursor_4c_BuscaOpe")
5880:                         USE IN cursor_4c_BuscaOpe
5881:                     ENDIF
5882:                     loc_oForm.Release()
5883:                 ENDIF
5884:             CATCH TO loc_oErro
5885:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressCodServs")
5886:             ENDTRY
5887:             par_nKeyCode = 0
5888:         ENDIF
5889:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5890:             KEYBOARD CHR(9)
5891:         ENDIF
5892:     ENDPROC
5893: 
5894:     *===========================================================================
5895:     * KeyPressTpTrans - F4/F5: lookup Tipo Transporte (SigPrTrn.Codigos)
5896:     *===========================================================================
5897:     PROCEDURE KeyPressTpTrans(par_nKeyCode, par_nShiftAltCtrl)
5898:         LOCAL loc_oCnt, loc_oForm
5899:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5900:             TRY
5901:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
5902:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5903:                     "SigPrTrn", "cursor_4c_BuscaTtp", "Codigos", ;
5904:                     ALLTRIM(loc_oCnt.txt_4c__TpTrans.Value), ;
5905:                     "Tipo Transporte")
5906:                 IF VARTYPE(loc_oForm) = "O"
5907:                     loc_oForm.mAddColuna("Codigos",  "XXXXXX", "C" + CHR(243) + "d.")
5908:                     loc_oForm.mAddColuna("Descrs",   "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
5909:                     loc_oForm.Show()
5910:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaTtp")
5911:                         SELECT cursor_4c_BuscaTtp
5912:                         loc_oCnt.txt_4c__TpTrans.Value = ALLTRIM(cursor_4c_BuscaTtp.Codigos)
5913:                     ENDIF
5914:                     IF USED("cursor_4c_BuscaTtp")
5915:                         USE IN cursor_4c_BuscaTtp
5916:                     ENDIF
5917:                     loc_oForm.Release()
5918:                 ENDIF
5919:             CATCH TO loc_oErro
5920:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressTpTrans")
5921:             ENDTRY
5922:             par_nKeyCode = 0
5923:         ENDIF
5924:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5925:             KEYBOARD CHR(9)
5926:         ENDIF
5927:     ENDPROC
5928: 
5929:     *===========================================================================
5930:     * KeyPressDopEInt - F4/F5: lookup Operacao Cupom Fiscal (SigCdOpe.Dopes)
5931:     *===========================================================================
5932:     PROCEDURE KeyPressDopEInt(par_nKeyCode, par_nShiftAltCtrl)
5933:         LOCAL loc_oCnt, loc_oForm
5934:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5935:             TRY
5936:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
5937:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5938:                     "SigCdOpe", "cursor_4c_BuscaDop", "Dopes", ;
5939:                     ALLTRIM(loc_oCnt.txt_4c_Dope_int.Value), ;
5940:                     "Opera" + CHR(231) + CHR(227) + "o Cupom Fiscal")
5941:                 IF VARTYPE(loc_oForm) = "O"
5942:                     loc_oForm.mAddColuna("Dopes", "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Opera" + CHR(231) + CHR(227) + "o")
5943:                     loc_oForm.Show()
5944:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaDop")
5945:                         SELECT cursor_4c_BuscaDop
5946:                         loc_oCnt.txt_4c_Dope_int.Value = ALLTRIM(cursor_4c_BuscaDop.Dopes)
5947:                     ENDIF
5948:                     IF USED("cursor_4c_BuscaDop")
5949:                         USE IN cursor_4c_BuscaDop
5950:                     ENDIF
5951:                     loc_oForm.Release()
5952:                 ENDIF
5953:             CATCH TO loc_oErro
5954:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressDopEInt")
5955:             ENDTRY
5956:             par_nKeyCode = 0
5957:         ENDIF
5958:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5959:             KEYBOARD CHR(9)
5960:         ENDIF
5961:     ENDPROC
5962: 
5963:     *===========================================================================
5964:     * KeyPressSaicol - F4/F5: lookup Distribuicao de Estoque (SigCdEmp.Cemps)
5965:     *===========================================================================
5966:     PROCEDURE KeyPressSaicol(par_nKeyCode, par_nShiftAltCtrl)
5967:         LOCAL loc_oCnt, loc_oForm
5968:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
5969:             TRY
5970:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page2
5971:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5972:                     "SigCdEmp", "cursor_4c_BuscaSai", "Cemps", ;
5973:                     ALLTRIM(loc_oCnt.txt_4c_Saicol.Value), ;
5974:                     "Distribui" + CHR(231) + CHR(227) + "o de Estoque")
5975:                 IF VARTYPE(loc_oForm) = "O"
5976:                     loc_oForm.mAddColuna("Cemps",    "!!!", "C" + CHR(243) + "d.")
5977:                     loc_oForm.mAddColuna("razsocs",  "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Raz" + CHR(227) + "o Social")
5978:                     loc_oForm.Show()
5979:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSai")
5980:                         SELECT cursor_4c_BuscaSai
5981:                         loc_oCnt.txt_4c_Saicol.Value = ALLTRIM(cursor_4c_BuscaSai.Cemps)
5982:                     ENDIF
5983:                     IF USED("cursor_4c_BuscaSai")
5984:                         USE IN cursor_4c_BuscaSai
5985:                     ENDIF
5986:                     loc_oForm.Release()
5987:                 ENDIF
5988:             CATCH TO loc_oErro
5989:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressSaicol")
5990:             ENDTRY
5991:             par_nKeyCode = 0
5992:         ENDIF
5993:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
5994:             KEYBOARD CHR(9)
5995:         ENDIF
5996:     ENDPROC
5997: 
5998:     *===========================================================================
5999:     * KeyPressMctotal - F4/F5: lookup Moeda (SigCdMoe.Cmoes)
6000:     *===========================================================================
6001:     PROCEDURE KeyPressMctotal(par_nKeyCode, par_nShiftAltCtrl)
6002:         LOCAL loc_oCnt, loc_oForm
6003:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
6004:             TRY
6005:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
6006:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6007:                     "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", ;
6008:                     ALLTRIM(loc_oCnt.txt_4c_Mctotal.Value), ;
6009:                     "Moeda")
6010:                 IF VARTYPE(loc_oForm) = "O"
6011:                     loc_oForm.mAddColuna("CMoes",  "!!", "C" + CHR(243) + "d.")
6012:                     loc_oForm.mAddColuna("DMoes",  "@!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
6013:                     loc_oForm.Show()
6014:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
6015:                         SELECT cursor_4c_BuscaMoe
6016:                         loc_oCnt.txt_4c_Mctotal.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
6017:                     ENDIF
6018:                     IF USED("cursor_4c_BuscaMoe")
6019:                         USE IN cursor_4c_BuscaMoe
6020:                     ENDIF
6021:                     loc_oForm.Release()
6022:                 ENDIF
6023:             CATCH TO loc_oErro
6024:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressMctotal")
6025:             ENDTRY
6026:             par_nKeyCode = 0
6027:         ENDIF
6028:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
6029:             KEYBOARD CHR(9)
6030:         ENDIF
6031:     ENDPROC
6032: 
6033:     *===========================================================================
6034:     * KeyPressCfoInt - F4/F5: lookup CFOP (SigCdCfo.Codigos)
6035:     *===========================================================================
6036:     PROCEDURE KeyPressCfoInt(par_nKeyCode, par_nShiftAltCtrl)
6037:         LOCAL loc_oCnt, loc_oForm
6038:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
6039:             TRY
6040:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
6041:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6042:                     "SigCdCfo", "cursor_4c_BuscaCfo", "Codigos", ;
6043:                     ALLTRIM(loc_oCnt.txt_4c_Cfo_Int.Value), ;
6044:                     "CFOP")
6045:                 IF VARTYPE(loc_oForm) = "O"
6046:                     loc_oForm.mAddColuna("Codigos",    "XXXXXXXXX", "CFOP")
6047:                     loc_oForm.mAddColuna("descricaos", "@!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!", "Descri" + CHR(231) + CHR(227) + "o")
6048:                     loc_oForm.Show()
6049:                     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
6050:                         SELECT cursor_4c_BuscaCfo
6051:                         loc_oCnt.txt_4c_Cfo_Int.Value = ALLTRIM(cursor_4c_BuscaCfo.Codigos)
6052:                     ENDIF
6053:                     IF USED("cursor_4c_BuscaCfo")
6054:                         USE IN cursor_4c_BuscaCfo
6055:                     ENDIF
6056:                     loc_oForm.Release()
6057:                 ENDIF
6058:             CATCH TO loc_oErro
6059:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressCfoInt")
6060:             ENDTRY
6061:             par_nKeyCode = 0
6062:         ENDIF
6063:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
6064:             KEYBOARD CHR(9)
6065:         ENDIF
6066:     ENDPROC
6067: 
6068:     *===========================================================================
6069:     * KeyPressGrupoContabil - F4/F5: lookup Grupo Contabil (SIGSYACC.grcontas)
6070:     * Handler generico para todos os campos GRUxxx na Page3
6071:     *===========================================================================
6072:     PROCEDURE KeyPressGrupoContabil(par_nKeyCode, par_nShiftAltCtrl)
6073:         LOCAL loc_oCnt, loc_oForm, loc_oCtrl
6074:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
6075:             TRY
6076:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
6077:                 loc_oCtrl = THIS.ActiveControl
6078:                 IF VARTYPE(loc_oCtrl) = "O"
6079:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6080:                         "SIGSYACC", "cursor_4c_BuscaGrp", "grcontas", ;
6081:                         ALLTRIM(loc_oCtrl.Value), ;
6082:                         "Grupo Cont" + CHR(225) + "bil")
6083:                     IF VARTYPE(loc_oForm) = "O"
6084:                         loc_oForm.mAddColuna("grcontas",  "!!!!!!!!!!", "Grupo Cont" + CHR(225) + "bil")
6085:                         loc_oForm.mAddColuna("cdcontas",  "!!!!!!!!!!!", "Conta")
6086:                         loc_oForm.Show()
6087:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
6088:                             SELECT cursor_4c_BuscaGrp
6089:                             loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaGrp.grcontas)
6090:                         ENDIF
6091:                         IF USED("cursor_4c_BuscaGrp")
6092:                             USE IN cursor_4c_BuscaGrp
6093:                         ENDIF
6094:                         loc_oForm.Release()
6095:                     ENDIF
6096:                 ENDIF
6097:             CATCH TO loc_oErro
6098:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressGrupoContabil")
6099:             ENDTRY
6100:             par_nKeyCode = 0
6101:         ENDIF
6102:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
6103:             KEYBOARD CHR(9)
6104:         ENDIF
6105:     ENDPROC
6106: 
6107:     *===========================================================================
6108:     * KeyPressContaContabil - F4/F5: lookup Conta Contabil (SIGSYACC.cdcontas)
6109:     * Handler generico para todos os campos CONxxx na Page3
6110:     *===========================================================================
6111:     PROCEDURE KeyPressContaContabil(par_nKeyCode, par_nShiftAltCtrl)
6112:         LOCAL loc_oCnt, loc_oForm, loc_oCtrl
6113:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
6114:             TRY
6115:                 loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Page3
6116:                 loc_oCtrl = THIS.ActiveControl
6117:                 IF VARTYPE(loc_oCtrl) = "O"
6118:                     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6119:                         "SIGSYACC", "cursor_4c_BuscaCon", "cdcontas", ;
6120:                         ALLTRIM(loc_oCtrl.Value), ;
6121:                         "Conta Cont" + CHR(225) + "bil")
6122:                     IF VARTYPE(loc_oForm) = "O"
6123:                         loc_oForm.mAddColuna("cdcontas",  "!!!!!!!!!!!!!", "Conta")
6124:                         loc_oForm.mAddColuna("grcontas",  "!!!!!!!!!!!", "Grupo")
6125:                         loc_oForm.Show()
6126:                         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCon")
6127:                             SELECT cursor_4c_BuscaCon
6128:                             loc_oCtrl.Value = ALLTRIM(cursor_4c_BuscaCon.cdcontas)
6129:                         ENDIF
6130:                         IF USED("cursor_4c_BuscaCon")
6131:                             USE IN cursor_4c_BuscaCon
6132:                         ENDIF
6133:                         loc_oForm.Release()
6134:                     ENDIF
6135:                 ENDIF
6136:             CATCH TO loc_oErro
6137:                 MsgErro(loc_oErro.Message, "Formemp.KeyPressContaContabil")
6138:             ENDTRY
6139:             par_nKeyCode = 0
6140:         ENDIF
6141:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
6142:             KEYBOARD CHR(9)
6143:         ENDIF
6144:     ENDPROC
6145: 
6146:     *===========================================================================
6147:     * Destroy - Libera recursos ao fechar o formulario
6148:     *===========================================================================
6149:     PROCEDURE Destroy()
6150:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
6151:             THIS.this_oBusinessObject = .NULL.
6152:         ENDIF
6153: 
6154:         IF USED("cursor_4c_Dados")
6155:             USE IN cursor_4c_Dados
6156:         ENDIF
6157: 
6158:         IF USED("cursor_4c_Busca")
6159:             USE IN cursor_4c_Busca
6160:         ENDIF
6161: 
6162:         DODEFAULT()
6163:     ENDPROC
6164: 
6165: ENDDEFINE

