# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [BINDEVENT-PARAMS] Handler 'ValidarDopp' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDopp(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarTpop' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTpop(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCgru' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCgru(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDsGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDsGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarOpPad' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarOpPad(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGde' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGde(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDgrupos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDgrupos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaOrig' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDROP.Pagina.Dados): Top original=329 vs migrado 'lbl_4c_Say6' Top=360 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_gde_grupo' (parent: SIGCDROP.Pagina.Dados): Top original=204 vs migrado 'lbl_4c_Lbl_gde_grupo' Top=235 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDROP.Pagina.Dados): Top original=230 vs migrado 'lbl_4c_Say4' Top=261 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupo' (parent: SIGCDROP.Pagina.Dados): Top original=154 vs migrado 'lbl_4c_Lbl_grupo' Top=185 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say34' (parent: SIGCDROP.Pagina.Dados): Top original=255 vs migrado 'lbl_4c_Say34' Top=286 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDROP.Pagina.Dados): Top original=279 vs migrado 'lbl_4c_Say3' Top=310 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'opt_Exclusivo' (parent: SIGCDROP.Pagina.Dados): Top original=325 vs migrado 'obj_4c_Opt_Exclusivo' Top=356 (diff=31px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say42' (parent: SIGCDROP.Pagina.Dados): Top original=304 vs migrado 'lbl_4c_Say42' Top=335 (diff=31px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRop.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1958 linhas total):

*-- Linhas 29 a 149:
29:     *==========================================================================
30:     * Init - Ponto de entrada do formulário
31:     *==========================================================================
32:     PROCEDURE Init()
33:         LOCAL loc_lSucesso
34:         loc_lSucesso = .F.
35:         TRY
36:             loc_lSucesso = DODEFAULT()
37:         CATCH TO loc_oErro
38:             MsgErro("Erro ao inicializar FormRop:" + CHR(13) + loc_oErro.Message, "FormRop.Init")
39:         ENDTRY
40:         RETURN loc_lSucesso
41:     ENDPROC
42: 
43:     *==========================================================================
44:     * InicializarForm - Configura estrutura completa do formulário
45:     * Chamado automaticamente pelo FormBase.Init()
46:     *==========================================================================
47:     PROTECTED PROCEDURE InicializarForm()
48:         LOCAL loc_lSucesso
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.Caption = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
53: 
54:             THIS.this_oBusinessObject = CREATEOBJECT("RopBO")
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Erro ao criar RopBO.", "FormRop.InicializarForm")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 loc_lSucesso = .T.
68:             ENDIF
69:         CATCH TO loc_oErro
70:             MsgErro("Erro ao inicializar formulário:" + CHR(13) + loc_oErro.Message, "FormRop.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *==========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com 2 páginas (Lista e Dados)
78:     * Compensação: PageFrame.Top = -31, todos os controles precisam +31 no Top
79:     *==========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82:         THIS.pgf_4c_Paginas.PageCount = 2
83:         WITH THIS.pgf_4c_Paginas
84:             .Top    = -31
85:             .Left   = -2
86:             .Width  = THIS.Width + 4
87:             .Height = 631
88:             .Tabs   = .F.
89:             .Visible = .T.
90:         ENDWITH
91: 
92:         WITH THIS.pgf_4c_Paginas.Page1
93:             .Caption = "Lista"
94:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
95:         ENDWITH
96: 
97:         WITH THIS.pgf_4c_Paginas.Page2
98:             .Caption = "Dados"
99:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *==========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 com grid e botões CRUD completos
108:     *==========================================================================
109:     PROTECTED PROCEDURE ConfigurarPaginaLista()
110:         LOCAL loc_oPagina, loc_oGrid
111:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
112: 
113:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
114:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115: 
116:         *-- Container cabeçalho com título
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 32
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
130:             .Top      = 15
131:             .Left     = 10
132:             .Width    = THIS.Width - 20
133:             .Height   = 46
134:             .FontName = "Tahoma"
135:             .FontSize = 16
136:             .FontBold = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .Visible  = .T.
140:         ENDWITH
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
144:             .Top      = 18
145:             .Left     = 10
146:             .Width    = THIS.Width - 20
147:             .Height   = 46
148:             .FontName = "Tahoma"
149:             .FontSize = 16

*-- Linhas 187 a 583:
187:             .MousePointer    = 15
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         *-- Botão Visualizar
193:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
194:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
195:             .Caption         = "Visualizar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:             .PicturePosition = 13
198:             .Top             = 5
199:             .Left            = 80
200:             .Width           = 75
201:             .Height          = 75
202:             .BackColor       = RGB(255, 255, 255)
203:             .ForeColor       = RGB(90, 90, 90)
204:             .FontName        = "Comic Sans MS"
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .FontSize        = 8
208:             .WordWrap        = .T.
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
215: 
216:         *-- Botão Alterar
217:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
218:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
219:             .Caption         = "Alterar"
220:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
221:             .PicturePosition = 13
222:             .Top             = 5
223:             .Left            = 155
224:             .Width           = 75
225:             .Height          = 75
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .FontName        = "Comic Sans MS"
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .FontSize        = 8
232:             .WordWrap        = .T.
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Botão Excluir
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Comic Sans MS"
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .FontSize        = 8
256:             .WordWrap        = .T.
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .MousePointer    = 15
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
263: 
264:         *-- Botão Buscar
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
267:             .Caption         = "Buscar"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 305
272:             .Width           = 75
273:             .Height          = 75
274:             .BackColor       = RGB(255, 255, 255)
275:             .ForeColor       = RGB(90, 90, 90)
276:             .FontName        = "Comic Sans MS"
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .FontSize        = 8
280:             .WordWrap        = .T.
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .MousePointer    = 15
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container Encerrar (canônico Left=917, Width=90)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 31
292:             .Left        = 917
293:             .Width       = 90
294:             .Height      = 85
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301:             .Caption         = "Encerrar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303:             .PicturePosition = 13
304:             .Top             = 5
305:             .Left            = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .BackColor       = RGB(255, 255, 255)
309:             .ForeColor       = RGB(90, 90, 90)
310:             .FontName        = "Comic Sans MS"
311:             .FontBold        = .T.
312:             .FontItalic      = .T.
313:             .FontSize        = 8
314:             .WordWrap        = .T.
315:             .Themes          = .F.
316:             .SpecialEffect   = 0
317:             .MousePointer    = 15
318:             .Visible         = .T.
319:         ENDWITH
320:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
321: 
322:         *-- Grid de lista (Top=117 = 86+31 compensação PageFrame)
323:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
324:         loc_oGrid = loc_oPagina.grd_4c_Lista
325:         loc_oGrid.ColumnCount = 9
326:         WITH loc_oGrid
327:             .Top                = 117
328:             .Left               = 26
329:             .Width              = 890
330:             .Height             = 470
331:             .FontName           = "Verdana"
332:             .FontSize           = 8
333:             .ForeColor          = RGB(90, 90, 90)
334:             .BackColor          = RGB(255, 255, 255)
335:             .GridLineColor      = RGB(238, 238, 238)
336:             .GridLines          = 3
337:             .HighlightBackColor = RGB(255, 255, 255)
338:             .HighlightForeColor = RGB(15, 41, 104)
339:             .HighlightStyle     = 2
340:             .DeleteMark         = .F.
341:             .RecordMark         = .F.
342:             .RowHeight          = 16
343:             .ScrollBars         = 2
344:             .Visible            = .T.
345:         ENDWITH
346: 
347:         THIS.TornarControlesVisiveis(loc_oPagina)
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
352:     * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
353:     * Compensação PageFrame.Top=-31: todos os Tops somam +31
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarPaginaDados()
356:         LOCAL loc_oPagina
357:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
358: 
359:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
360:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
361: 
362:         *-- Container botões Confirmar/Cancelar (canônico: Top=51, Left=842)
363:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
364:         WITH loc_oPagina.cnt_4c_BotoesAcao
365:             .Top         = 51
366:             .Left        = 842
367:             .Width       = 160
368:             .Height      = 85
369:             .BackStyle   = 0
370:             .Visible     = .T.
371:         ENDWITH
372: 
373:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
374:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
375:             .Caption         = "Confirmar"
376:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
377:             .PicturePosition = 13
378:             .Top             = 5
379:             .Left            = 5
380:             .Width           = 75
381:             .Height          = 75
382:             .BackColor       = RGB(255, 255, 255)
383:             .ForeColor       = RGB(90, 90, 90)
384:             .FontName        = "Comic Sans MS"
385:             .FontBold        = .T.
386:             .FontItalic      = .T.
387:             .FontSize        = 8
388:             .WordWrap        = .T.
389:             .Themes          = .F.
390:             .SpecialEffect   = 0
391:             .MousePointer    = 15
392:             .Visible         = .T.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
395: 
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
398:             .Caption         = "Encerrar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 80
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Comic Sans MS"
408:             .FontBold        = .T.
409:             .FontItalic      = .T.
410:             .FontSize        = 8
411:             .WordWrap        = .T.
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .Visible         = .T.
416:         ENDWITH
417:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
418: 
419:         *====================================================================
420:         *-- CAMPO 1: Operação de Produção (Get_Dopp) - original top=98 -> 129
421:         *====================================================================
422:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
423:         WITH loc_oPagina.lbl_4c_Label2
424:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
425:             .Top       = 133
426:             .Left      = 242
427:             .Width     = 85
428:             .Height    = 15
429:             .BackStyle = 0
430:             .ForeColor = RGB(90, 90, 90)
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .Alignment = 1
434:             .Visible   = .T.
435:         ENDWITH
436: 
437:         loc_oPagina.AddObject("txt_4c_Dopp", "TextBox")
438:         WITH loc_oPagina.txt_4c_Dopp
439:             .Value       = ""
440:             .Top         = 129
441:             .Left        = 328
442:             .Width       = 150
443:             .Height      = 23
444:             .MaxLength   = 20
445:             .BackColor   = RGB(255, 255, 255)
446:             .ForeColor   = RGB(90, 90, 90)
447:             .FontName    = "Tahoma"
448:             .FontSize    = 8
449:             .BorderStyle = 1
450:             .Visible     = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oPagina.txt_4c_Dopp, "KeyPress", THIS, "ValidarDopp")
453:         BINDEVENT(loc_oPagina.txt_4c_Dopp, "KeyPress",  THIS, "TeclaPressionadaDopp")
454: 
455:         *====================================================================
456:         *-- CAMPO 2: Tipo de Material (Get_Tpop) - original top=124 -> 155
457:         *====================================================================
458:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
459:         WITH loc_oPagina.lbl_4c_Label1
460:             .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o :"
461:             .Top       = 159
462:             .Left      = 204
463:             .Width     = 120
464:             .Height    = 15
465:             .BackStyle = 0
466:             .ForeColor = RGB(90, 90, 90)
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .Alignment = 1
470:             .Visible   = .T.
471:         ENDWITH
472: 
473:         loc_oPagina.AddObject("txt_4c_Tpop", "TextBox")
474:         WITH loc_oPagina.txt_4c_Tpop
475:             .Value       = ""
476:             .Top         = 155
477:             .Left        = 328
478:             .Width       = 115
479:             .Height      = 23
480:             .MaxLength   = 15
481:             .BackColor   = RGB(255, 255, 255)
482:             .ForeColor   = RGB(90, 90, 90)
483:             .FontName    = "Tahoma"
484:             .FontSize    = 8
485:             .BorderStyle = 1
486:             .Visible     = .T.
487:         ENDWITH
488:         BINDEVENT(loc_oPagina.txt_4c_Tpop, "KeyPress", THIS, "ValidarTpop")
489:         BINDEVENT(loc_oPagina.txt_4c_Tpop, "KeyPress",  THIS, "TeclaPressionadaTpop")
490: 
491:         *====================================================================
492:         *-- CAMPO 3: Grupo de Produto - código (get_Cgru) + desc (get_ds_grupo)
493:         *-- original top=150 -> 181
494:         *====================================================================
495:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
496:         WITH loc_oPagina.lbl_4c_Lbl_grupo
497:             .Caption   = "Grupo de Produto :"
498:             .Top       = 185
499:             .Left      = 226
500:             .Width     = 94
501:             .Height    = 15
502:             .BackStyle = 0
503:             .ForeColor = RGB(90, 90, 90)
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .Alignment = 1
507:             .Visible   = .T.
508:         ENDWITH
509: 
510:         loc_oPagina.AddObject("txt_4c__Cgru", "TextBox")
511:         WITH loc_oPagina.txt_4c__Cgru
512:             .Value       = ""
513:             .Top         = 181
514:             .Left        = 328
515:             .Width       = 31
516:             .Height      = 23
517:             .MaxLength   = 3
518:             .BackColor   = RGB(255, 255, 255)
519:             .ForeColor   = RGB(90, 90, 90)
520:             .FontName    = "Tahoma"
521:             .FontSize    = 8
522:             .BorderStyle = 1
523:             .Visible     = .T.
524:         ENDWITH
525:         BINDEVENT(loc_oPagina.txt_4c__Cgru, "KeyPress", THIS, "ValidarCgru")
526:         BINDEVENT(loc_oPagina.txt_4c__Cgru, "KeyPress",  THIS, "TeclaPressionadaCgru")
527: 
528:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
529:         WITH loc_oPagina.txt_4c__ds_grupo
530:             .Value       = ""
531:             .Top         = 181
532:             .Left        = 361
533:             .Width       = 213
534:             .Height      = 23
535:             .MaxLength   = 50
536:             .BackColor   = RGB(255, 255, 255)
537:             .ForeColor   = RGB(90, 90, 90)
538:             .FontName    = "Tahoma"
539:             .FontSize    = 8
540:             .BorderStyle = 1
541:             .Visible     = .T.
542:         ENDWITH
543:         BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDsGrupo")
544: 
545:         *====================================================================
546:         *-- CAMPO 4: Operação Estoque E/S (Get_OpPad) - original top=177 -> 208
547:         *====================================================================
548:         loc_oPagina.AddObject("lbl_4c_Label39", "Label")
549:         WITH loc_oPagina.lbl_4c_Label39
550:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Estoque :"
551:             .Top       = 211
552:             .Left      = 222
553:             .Width     = 98
554:             .Height    = 15
555:             .BackStyle = 0
556:             .ForeColor = RGB(90, 90, 90)
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .Alignment = 1
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         loc_oPagina.AddObject("lbl_4c_Label40", "Label")
564:         WITH loc_oPagina.lbl_4c_Label40
565:             .Caption   = "(E / S)"
566:             .Top       = 211
567:             .Left      = 352
568:             .Width     = 32
569:             .Height    = 15
570:             .BackStyle = 0
571:             .ForeColor = RGB(90, 90, 90)
572:             .FontName  = "Tahoma"
573:             .FontSize  = 8
574:             .Alignment = 0
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         loc_oPagina.AddObject("txt_4c_OpPad", "TextBox")
579:         WITH loc_oPagina.txt_4c_OpPad
580:             .Value       = ""
581:             .Top         = 208
582:             .Left        = 328
583:             .Width       = 17

*-- Linhas 590 a 655:
590:             .BorderStyle = 1
591:             .Visible     = .T.
592:         ENDWITH
593:         BINDEVENT(loc_oPagina.txt_4c_OpPad, "KeyPress", THIS, "ValidarOpPad")
594: 
595:         *====================================================================
596:         *-- CAMPO 5: Grande Grupo (Get_gde) - original top=200 -> 231
597:         *-- Label lbl_gde_grupo: original top=204 -> 235
598:         *====================================================================
599:         loc_oPagina.AddObject("txt_4c_Gde", "TextBox")
600:         WITH loc_oPagina.txt_4c_Gde
601:             .Value       = ""
602:             .Top         = 231
603:             .Left        = 328
604:             .Width       = 33
605:             .Height      = 23
606:             .MaxLength   = 3
607:             .BackColor   = RGB(255, 255, 255)
608:             .ForeColor   = RGB(90, 90, 90)
609:             .FontName    = "Tahoma"
610:             .FontSize    = 8
611:             .BorderStyle = 1
612:             .Visible     = .T.
613:         ENDWITH
614:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress", THIS, "ValidarGde")
615:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress",  THIS, "TeclaPressionadaGde")
616: 
617:         loc_oPagina.AddObject("lbl_4c_Lbl_gde_grupo", "Label")
618:         WITH loc_oPagina.lbl_4c_Lbl_gde_grupo
619:             .Caption   = "Grande Grupo :"
620:             .Top       = 235
621:             .Left      = 244
622:             .Width     = 76
623:             .Height    = 15
624:             .BackStyle = 0
625:             .ForeColor = RGB(90, 90, 90)
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .Alignment = 1
629:             .Visible   = .T.
630:         ENDWITH
631: 
632:         *====================================================================
633:         *-- CAMPO 6: Grupo Contábil código (Get_Grupos) + desc (Get_Dgrupos)
634:         *-- original top=226 -> 257 | Say4 original top=230 -> 261
635:         *====================================================================
636:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
637:         WITH loc_oPagina.lbl_4c_Say4
638:             .Caption   = "Grupo :"
639:             .Top       = 261
640:             .Left      = 282
641:             .Width     = 43
642:             .Height    = 15
643:             .BackStyle = 0
644:             .ForeColor = RGB(90, 90, 90)
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .Alignment = 1
648:             .Visible   = .T.
649:         ENDWITH
650: 
651:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
652:         WITH loc_oPagina.txt_4c_Grupo
653:             .Value       = ""
654:             .Top         = 257
655:             .Left        = 328

*-- Linhas 663 a 901:
663:             .BorderStyle = 1
664:             .Visible     = .T.
665:         ENDWITH
666:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupos")
667:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "TeclaPressionadaGrupos")
668: 
669:         loc_oPagina.AddObject("txt_4c_Dgrupos", "TextBox")
670:         WITH loc_oPagina.txt_4c_Dgrupos
671:             .Value       = ""
672:             .Top         = 257
673:             .Left        = 411
674:             .Width       = 162
675:             .Height      = 23
676:             .MaxLength   = 50
677:             .BackColor   = RGB(255, 255, 255)
678:             .ForeColor   = RGB(90, 90, 90)
679:             .FontName    = "Tahoma"
680:             .FontSize    = 8
681:             .BorderStyle = 1
682:             .Visible     = .T.
683:         ENDWITH
684:         BINDEVENT(loc_oPagina.txt_4c_Dgrupos, "KeyPress", THIS, "ValidarDgrupos")
685: 
686:         *====================================================================
687:         *-- CAMPO 7: Conta Destino (Get_Conta) - original top=252 -> 283
688:         *-- Say34 original top=255 -> 286
689:         *====================================================================
690:         loc_oPagina.AddObject("lbl_4c_Say34", "Label")
691:         WITH loc_oPagina.lbl_4c_Say34
692:             .Caption   = "Conta Destino :"
693:             .Top       = 286
694:             .Left      = 243
695:             .Width     = 82
696:             .Height    = 15
697:             .BackStyle = 0
698:             .ForeColor = RGB(90, 90, 90)
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .Alignment = 1
702:             .Visible   = .T.
703:         ENDWITH
704: 
705:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
706:         WITH loc_oPagina.txt_4c_Conta
707:             .Value       = ""
708:             .Top         = 283
709:             .Left        = 328
710:             .Width       = 80
711:             .Height      = 21
712:             .MaxLength   = 10
713:             .BackColor   = RGB(255, 255, 255)
714:             .ForeColor   = RGB(90, 90, 90)
715:             .FontName    = "Tahoma"
716:             .FontSize    = 8
717:             .BorderStyle = 1
718:             .Visible     = .T.
719:         ENDWITH
720:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")
721:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "TeclaPressionadaConta")
722: 
723:         *====================================================================
724:         *-- CAMPO 8: Conta Origem (Get_ContaOrig) - original top=276 -> 307
725:         *-- Say3 original top=279 -> 310
726:         *====================================================================
727:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
728:         WITH loc_oPagina.lbl_4c_Say3
729:             .Caption   = "Conta Origem :"
730:             .Top       = 310
731:             .Left      = 245
732:             .Width     = 80
733:             .Height    = 15
734:             .BackStyle = 0
735:             .ForeColor = RGB(90, 90, 90)
736:             .FontName  = "Tahoma"
737:             .FontSize  = 8
738:             .Alignment = 1
739:             .Visible   = .T.
740:         ENDWITH
741: 
742:         loc_oPagina.AddObject("txt_4c_ContaOrig", "TextBox")
743:         WITH loc_oPagina.txt_4c_ContaOrig
744:             .Value       = ""
745:             .Top         = 307
746:             .Left        = 328
747:             .Width       = 80
748:             .Height      = 21
749:             .MaxLength   = 10
750:             .BackColor   = RGB(255, 255, 255)
751:             .ForeColor   = RGB(90, 90, 90)
752:             .FontName    = "Tahoma"
753:             .FontSize    = 8
754:             .BorderStyle = 1
755:             .Visible     = .T.
756:         ENDWITH
757:         BINDEVENT(loc_oPagina.txt_4c_ContaOrig, "KeyPress", THIS, "ValidarContaOrig")
758:         BINDEVENT(loc_oPagina.txt_4c_ContaOrig, "KeyPress",  THIS, "TeclaPressionadaContaOrig")
759: 
760:         *====================================================================
761:         *-- CAMPO 9: Cor (getCor/SigCdCor.Cods) - original top=300 -> 331
762:         *-- Say42 original top=304 -> 335
763:         *====================================================================
764:         loc_oPagina.AddObject("lbl_4c_Say42", "Label")
765:         WITH loc_oPagina.lbl_4c_Say42
766:             .Caption   = "Cor :"
767:             .Top       = 335
768:             .Left      = 294
769:             .Width     = 31
770:             .Height    = 15
771:             .BackStyle = 0
772:             .ForeColor = RGB(90, 90, 90)
773:             .FontName  = "Tahoma"
774:             .FontSize  = 8
775:             .Alignment = 1
776:             .Visible   = .T.
777:         ENDWITH
778: 
779:         loc_oPagina.AddObject("txt_4c_Cor", "TextBox")
780:         WITH loc_oPagina.txt_4c_Cor
781:             .Value       = ""
782:             .Top         = 331
783:             .Left        = 328
784:             .Width       = 38
785:             .Height      = 23
786:             .MaxLength   = 6
787:             .BackColor   = RGB(255, 255, 255)
788:             .ForeColor   = RGB(90, 90, 90)
789:             .FontName    = "Tahoma"
790:             .FontSize    = 8
791:             .BorderStyle = 1
792:             .Visible     = .T.
793:         ENDWITH
794:         BINDEVENT(loc_oPagina.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")
795:         BINDEVENT(loc_oPagina.txt_4c_Cor, "KeyPress",  THIS, "TeclaPressionadaCor")
796: 
797:         *====================================================================
798:         *-- CAMPO 10: Exclusivo (opt_Exclusivo) - original top=325 -> 356
799:         *-- Say6 original top=329 -> 360
800:         *====================================================================
801:         loc_oPagina.AddObject("lbl_4c_Say6", "Label")
802:         WITH loc_oPagina.lbl_4c_Say6
803:             .Caption   = "Exclusivo :"
804:             .Top       = 360
805:             .Left      = 267
806:             .Width     = 53
807:             .Height    = 15
808:             .BackStyle = 0
809:             .ForeColor = RGB(90, 90, 90)
810:             .FontName  = "Tahoma"
811:             .FontSize  = 8
812:             .Alignment = 1
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         loc_oPagina.AddObject("obj_4c_Opt_Exclusivo", "OptionGroup")
817:         WITH loc_oPagina.obj_4c_Opt_Exclusivo
818:             .Top         = 356
819:             .Left        = 326
820:             .Width       = 86
821:             .Height      = 23
822:             .ButtonCount = 2
823:             .BackStyle   = 0
824:             .BorderStyle = 0
825:             .Value       = 2
826:             .Visible     = .T.
827:         ENDWITH
828:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option1
829:             .Caption   = "Sim"
830:             .Left      = 2
831:             .Top       = 4
832:             .Width     = 34
833:             .Height    = 15
834:             .BackStyle = 0
835:             .ForeColor = RGB(90, 90, 90)
836:             .FontName  = "Tahoma"
837:             .FontSize  = 8
838:             .AutoSize  = .F.
839:             .Visible   = .T.
840:         ENDWITH
841:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option2
842:             .Caption   = "N" + CHR(227) + "o"
843:             .Left      = 44
844:             .Top       = 4
845:             .Width     = 37
846:             .Height    = 15
847:             .BackStyle = 0
848:             .ForeColor = RGB(90, 90, 90)
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .AutoSize  = .F.
852:             .Visible   = .T.
853:         ENDWITH
854: 
855:         THIS.TornarControlesVisiveis(loc_oPagina)
856:     ENDPROC
857: 
858:     *==========================================================================
859:     * CarregarLista - Carrega dados do BO no grid da Page1
860:     *==========================================================================
861:     PROCEDURE CarregarLista()
862:         LOCAL loc_lResultado, loc_oGrid
863:         loc_lResultado = .F.
864: 
865:         TRY
866:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
867:                 loc_lResultado = .T.
868:             ELSE
869:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
870: 
871:                 IF THIS.this_oBusinessObject.Buscar("")
872:                     loc_oGrid.ColumnCount = 9
873:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
874: 
875:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dopps"
876:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.tpops"
877:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
878:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.opers"
879:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.mercs"
880:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.grupos"
881:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.contas"
882:                     loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.contaorig"
883:                     loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.codcors"
884: 
885:                     loc_oGrid.Column1.Width = 150
886:                     loc_oGrid.Column2.Width = 120
887:                     loc_oGrid.Column3.Width = 80
888:                     loc_oGrid.Column4.Width = 60
889:                     loc_oGrid.Column5.Width = 80
890:                     loc_oGrid.Column6.Width = 80
891:                     loc_oGrid.Column7.Width = 100
892:                     loc_oGrid.Column8.Width = 100
893:                     loc_oGrid.Column9.Width = 60
894: 
895:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
896:                     loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
897:                     loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
898:                     loc_oGrid.Column4.Header1.Caption = "Op.Est."
899:                     loc_oGrid.Column5.Header1.Caption = "Grande Grp."
900:                     loc_oGrid.Column6.Header1.Caption = "Gr.Conta"
901:                     loc_oGrid.Column7.Header1.Caption = "Conta Dest."

*-- Linhas 916 a 1156:
916:     *==========================================================================
917:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
918:     *==========================================================================
919:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
920:         LOCAL loc_lResultado
921:         loc_lResultado = .F.
922: 
923:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
924:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
925:             IF par_nPagina = 1
926:                 THIS.CarregarLista()
927:                 THIS.this_cModoAtual = "LISTA"
928:             ENDIF
929:             loc_lResultado = .T.
930:         ENDIF
931: 
932:         RETURN loc_lResultado
933:     ENDPROC
934: 
935:     *==========================================================================
936:     * TornarControlesVisiveis - Torna todos os controles visíveis recursivamente
937:     *==========================================================================
938:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
939:         LOCAL loc_nI, loc_oObjeto
940: 
941:         FOR loc_nI = 1 TO par_oContainer.ControlCount
942:             loc_oObjeto = par_oContainer.Controls(loc_nI)
943: 
944:             IF VARTYPE(loc_oObjeto) = "O"
945:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
946:                     loc_oObjeto.Visible = .T.
947:                 ENDIF
948: 
949:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
950:                     LOCAL loc_nP
951:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
952:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
953:                     ENDFOR
954:                 ENDIF
955: 
956:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
957:                     THIS.TornarControlesVisiveis(loc_oObjeto)
958:                 ENDIF
959:             ENDIF
960:         ENDFOR
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * FormatarGridLista - Formata visual do grid da lista
965:     *==========================================================================
966:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
967:         WITH par_oGrid
968:             .FontName = "Tahoma"
969:             .FontSize = 8
970:         ENDWITH
971:     ENDPROC
972: 
973:     *==========================================================================
974:     * BtnIncluirClick - Inicia inclusão de novo registro
975:     *==========================================================================
976:     PROCEDURE BtnIncluirClick()
977:         THIS.this_oBusinessObject.NovoRegistro()
978:         THIS.this_cModoAtual = "INCLUIR"
979:         THIS.LimparCampos()
980:         THIS.HabilitarCampos(.T.)
981:         THIS.AjustarBotoesPorModo()
982:         THIS.AlternarPagina(2)
983:     ENDPROC
984: 
985:     *==========================================================================
986:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
987:     *==========================================================================
988:     PROCEDURE BtnVisualizarClick()
989:         LOCAL loc_cChave
990:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
991:             MsgAviso("Selecione um registro na lista.")
992:             RETURN
993:         ENDIF
994:         SELECT cursor_4c_Dados
995:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
996:         IF EMPTY(loc_cChave)
997:             MsgAviso("Selecione um registro na lista.")
998:             RETURN
999:         ENDIF
1000:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1001:             THIS.this_cModoAtual = "VISUALIZAR"
1002:             THIS.BOParaForm()
1003:             THIS.HabilitarCampos(.F.)
1004:             THIS.AjustarBotoesPorModo()
1005:             THIS.AlternarPagina(2)
1006:         ENDIF
1007:     ENDPROC
1008: 
1009:     *==========================================================================
1010:     * BtnAlterarClick - Abre registro selecionado para edição
1011:     *==========================================================================
1012:     PROCEDURE BtnAlterarClick()
1013:         LOCAL loc_cChave
1014:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1015:             MsgAviso("Selecione um registro na lista.")
1016:             RETURN
1017:         ENDIF
1018:         SELECT cursor_4c_Dados
1019:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1020:         IF EMPTY(loc_cChave)
1021:             MsgAviso("Selecione um registro na lista.")
1022:             RETURN
1023:         ENDIF
1024:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1025:             THIS.this_oBusinessObject.EditarRegistro()
1026:             THIS.this_cModoAtual = "ALTERAR"
1027:             THIS.BOParaForm()
1028:             THIS.HabilitarCampos(.T.)
1029:             THIS.AjustarBotoesPorModo()
1030:             THIS.AlternarPagina(2)
1031:         ENDIF
1032:     ENDPROC
1033: 
1034:     *==========================================================================
1035:     * BtnExcluirClick - Exclui registro selecionado após confirmação
1036:     *==========================================================================
1037:     PROCEDURE BtnExcluirClick()
1038:         LOCAL loc_cChave, loc_lConfirmado
1039:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1040:             MsgAviso("Selecione um registro na lista.")
1041:             RETURN
1042:         ENDIF
1043:         SELECT cursor_4c_Dados
1044:         loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1045:         IF EMPTY(loc_cChave)
1046:             MsgAviso("Selecione um registro na lista.")
1047:             RETURN
1048:         ENDIF
1049:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1050:         IF !loc_lConfirmado
1051:             RETURN
1052:         ENDIF
1053:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1054:             IF THIS.this_oBusinessObject.Excluir()
1055:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1056:                 THIS.CarregarLista()
1057:             ENDIF
1058:         ENDIF
1059:     ENDPROC
1060: 
1061:     *==========================================================================
1062:     * BtnBuscarClick - Recarrega lista (busca geral)
1063:     *==========================================================================
1064:     PROCEDURE BtnBuscarClick()
1065:         THIS.CarregarLista()
1066:     ENDPROC
1067: 
1068:     *==========================================================================
1069:     * BtnEncerrarClick - Fecha o formulário
1070:     *==========================================================================
1071:     PROCEDURE BtnEncerrarClick()
1072:         THIS.Release()
1073:     ENDPROC
1074: 
1075:     *==========================================================================
1076:     * BtnSalvarClick - Salva o registro atual (botão Confirmar)
1077:     *==========================================================================
1078:     PROCEDURE BtnSalvarClick()
1079:         THIS.FormParaBO()
1080:         IF THIS.this_oBusinessObject.Salvar()
1081:             MsgInfo("Registro salvo com sucesso!")
1082:             THIS.AlternarPagina(1)
1083:         ENDIF
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * BtnCancelarClick - Cancela edição e retorna para a lista
1088:     *==========================================================================
1089:     PROCEDURE BtnCancelarClick()
1090:         THIS.AlternarPagina(1)
1091:     ENDPROC
1092: 
1093:     *==========================================================================
1094:     * FormParaBO - Transfere valores do formulário para o Business Object
1095:     *==========================================================================
1096:     PROCEDURE FormParaBO()
1097:         LOCAL loc_oPagina
1098:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1099: 
1100:         THIS.this_oBusinessObject.this_cDopps    = ALLTRIM(loc_oPagina.txt_4c_Dopp.Value)
1101:         THIS.this_oBusinessObject.this_cTpops    = ALLTRIM(loc_oPagina.txt_4c_Tpop.Value)
1102:         THIS.this_oBusinessObject.this_cCgrus    = ALLTRIM(loc_oPagina.txt_4c__Cgru.Value)
1103:         THIS.this_oBusinessObject.this_cOpers    = ALLTRIM(loc_oPagina.txt_4c_OpPad.Value)
1104:         THIS.this_oBusinessObject.this_cMercs    = ALLTRIM(loc_oPagina.txt_4c_Gde.Value)
1105:         THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1106:         THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1107:         THIS.this_oBusinessObject.this_cContaorig = ALLTRIM(loc_oPagina.txt_4c_ContaOrig.Value)
1108:         THIS.this_oBusinessObject.this_cCodcors  = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)
1109:         THIS.this_oBusinessObject.this_nExclus   = ;
1110:             IIF(loc_oPagina.obj_4c_Opt_Exclusivo.Value = 1, 1, 2)
1111:     ENDPROC
1112: 
1113:     *==========================================================================
1114:     * BOParaForm - Transfere valores do Business Object para o formulário
1115:     *==========================================================================
1116:     PROCEDURE BOParaForm()
1117:         LOCAL loc_oPagina, loc_cSQL, loc_nResult
1118:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1119: 
1120:         loc_oPagina.txt_4c_Dopp.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cDopps)
1121:         loc_oPagina.txt_4c_Tpop.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTpops)
1122:         loc_oPagina.txt_4c__Cgru.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)
1123:         loc_oPagina.txt_4c_OpPad.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cOpers)
1124:         loc_oPagina.txt_4c_Gde.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cMercs)
1125:         loc_oPagina.txt_4c_Conta.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
1126:         loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(THIS.this_oBusinessObject.this_cContaorig)
1127:         loc_oPagina.txt_4c_Cor.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCodcors)
1128:         loc_oPagina.obj_4c_Opt_Exclusivo.Value = ;
1129:             IIF(THIS.this_oBusinessObject.this_nExclus = 1, 1, 2)
1130: 
1131:         *-- Carregar descrição do Grupo de Produto via SigCdGrp
1132:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus))
1133:             loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1134:                 EscaparSQL(THIS.this_oBusinessObject.this_cCgrus)
1135:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDesc")
1136:             IF loc_nResult >= 0 AND USED("cursor_4c_GrupoDesc") AND !EOF("cursor_4c_GrupoDesc")
1137:                 SELECT cursor_4c_GrupoDesc
1138:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GrupoDesc.DGrus)
1139:             ELSE
1140:                 loc_oPagina.txt_4c__ds_grupo.Value = ""
1141:             ENDIF
1142:             IF USED("cursor_4c_GrupoDesc")
1143:                 USE IN cursor_4c_GrupoDesc
1144:             ENDIF
1145:         ELSE
1146:             loc_oPagina.txt_4c__ds_grupo.Value = ""
1147:         ENDIF
1148: 
1149:         *-- Carregar descrição do Grupo Contábil via SigCdGcr
1150:         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
1151:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cGrupos))
1152:             loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
1153:                 EscaparSQL(THIS.this_oBusinessObject.this_cGrupos)
1154:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposDesc")
1155:             IF loc_nResult >= 0 AND USED("cursor_4c_GruposDesc") AND !EOF("cursor_4c_GruposDesc")
1156:                 SELECT cursor_4c_GruposDesc

*-- Linhas 1169 a 1958:
1169:     *==========================================================================
1170:     * LimparCampos - Limpa todos os campos da Page2
1171:     *==========================================================================
1172:     PROCEDURE LimparCampos()
1173:         LOCAL loc_oPagina
1174:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1175: 
1176:         loc_oPagina.txt_4c_Dopp.Value          = ""
1177:         loc_oPagina.txt_4c_Tpop.Value          = ""
1178:         loc_oPagina.txt_4c__Cgru.Value         = ""
1179:         loc_oPagina.txt_4c__ds_grupo.Value     = ""
1180:         loc_oPagina.txt_4c_OpPad.Value         = ""
1181:         loc_oPagina.txt_4c_Gde.Value           = ""
1182:         loc_oPagina.txt_4c_Grupo.Value         = ""
1183:         loc_oPagina.txt_4c_Dgrupos.Value       = ""
1184:         loc_oPagina.txt_4c_Conta.Value         = ""
1185:         loc_oPagina.txt_4c_ContaOrig.Value     = ""
1186:         loc_oPagina.txt_4c_Cor.Value           = ""
1187:         loc_oPagina.obj_4c_Opt_Exclusivo.Value = 2
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * HabilitarCampos - Habilita ou desabilita campos de edição (Page2)
1192:     *==========================================================================
1193:     PROCEDURE HabilitarCampos(par_lHabilitar)
1194:         LOCAL loc_oPagina, loc_lReadOnly
1195:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1196:         loc_lReadOnly = !par_lHabilitar
1197: 
1198:         loc_oPagina.txt_4c_Dopp.ReadOnly          = loc_lReadOnly
1199:         loc_oPagina.txt_4c_Tpop.ReadOnly          = loc_lReadOnly
1200:         loc_oPagina.txt_4c__Cgru.ReadOnly         = loc_lReadOnly
1201:         loc_oPagina.txt_4c__ds_grupo.ReadOnly     = loc_lReadOnly
1202:         loc_oPagina.txt_4c_OpPad.ReadOnly         = loc_lReadOnly
1203:         loc_oPagina.txt_4c_Gde.ReadOnly           = loc_lReadOnly
1204:         loc_oPagina.txt_4c_Grupo.ReadOnly         = loc_lReadOnly
1205:         loc_oPagina.txt_4c_Dgrupos.ReadOnly       = loc_lReadOnly
1206:         loc_oPagina.txt_4c_Conta.ReadOnly         = loc_lReadOnly
1207:         loc_oPagina.txt_4c_ContaOrig.ReadOnly     = loc_lReadOnly
1208:         loc_oPagina.txt_4c_Cor.ReadOnly           = loc_lReadOnly
1209:         loc_oPagina.obj_4c_Opt_Exclusivo.Enabled  = par_lHabilitar
1210: 
1211:         *-- Confirmar habilitado em modo edição ou exclusão
1212:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1213:             par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
1214:     ENDPROC
1215: 
1216:     *==========================================================================
1217:     * ValidarDopp - Valida campo Operação ao perder foco
1218:     * Original Get_Dopp.Valid: Seek em TmpOpe (cursor SigCdRpo.Dopps)
1219:     *==========================================================================
1220:     PROCEDURE ValidarDopp(par_nKeyCode, par_nShiftAltCtrl)
1221:         LOCAL loc_cDopp
1222:         loc_cDopp = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value)
1223: 
1224:         IF EMPTY(loc_cDopp)
1225:             RETURN
1226:         ENDIF
1227: 
1228:         *-- Verificar em cursor_4c_Dados (já carregado) antes de abrir browse
1229:         IF USED("cursor_4c_Dados")
1230:             SELECT cursor_4c_Dados
1231:             LOCATE FOR UPPER(ALLTRIM(dopps)) = UPPER(loc_cDopp)
1232:             IF FOUND()
1233:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_Dados.dopps)
1234:                 RETURN
1235:             ENDIF
1236:         ENDIF
1237: 
1238:         THIS.AbrirBuscaDopp()
1239:     ENDPROC
1240: 
1241:     *==========================================================================
1242:     * TeclaPressionadaDopp - Captura F4 em txt_4c_Dopp para abrir busca
1243:     *==========================================================================
1244:     PROCEDURE TeclaPressionadaDopp(par_nKeyCode, par_nShiftAltCtrl)
1245:         IF par_nKeyCode = 63
1246:             THIS.AbrirBuscaDopp()
1247:         ENDIF
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * AbrirBuscaDopp - Abre FormBuscaAuxiliar para selecionar Operação
1252:     * Equivalente a fwBuscaSel em TmpOpe (distinct Dopps de SigCdRpo)
1253:     *==========================================================================
1254:     PROCEDURE AbrirBuscaDopp()
1255:         LOCAL loc_cSQL, loc_nResult, loc_oBusca
1256:         TRY
1257:             loc_cSQL = "SELECT DISTINCT RTRIM(Dopps) AS Dopps" + ;
1258:                 " FROM SigCdRpo ORDER BY Dopps"
1259:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaDopp")
1260: 
1261:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaDopp")
1262:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1263:                 IF VARTYPE(loc_oBusca) = "O"
1264:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaDopp"
1265:                     loc_oBusca.this_cTitulo = "Opera" + CHR(231) + CHR(245) + "es"
1266:                     loc_oBusca.mAddColuna("Dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
1267:                     loc_oBusca.Show()
1268:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDopp")
1269:                         SELECT cursor_4c_BuscaDopp
1270:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Dopp.Value = ALLTRIM(cursor_4c_BuscaDopp.Dopps)
1271:                     ENDIF
1272:                     loc_oBusca.Release()
1273:                 ENDIF
1274:             ELSE
1275:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
1276:                     CHR(13) + CapturarErroSQL(), "Erro SQL")
1277:             ENDIF
1278:         CATCH TO loc_oErro
1279:             MsgErro("Erro ao abrir busca de opera" + CHR(231) + CHR(245) + "es:" + ;
1280:                 CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaDopp")
1281:         ENDTRY
1282:         IF USED("cursor_4c_BuscaDopp")
1283:             USE IN cursor_4c_BuscaDopp
1284:         ENDIF
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * ValidarTpop - Valida campo Tipo de Material ao perder foco
1289:     * Original Get_Tpop.Valid: Seek em TmpOpt (SigOpOpt Where Not Situas=2)
1290:     *==========================================================================
1291:     PROCEDURE ValidarTpop(par_nKeyCode, par_nShiftAltCtrl)
1292:         LOCAL loc_cTpop, loc_cSQL, loc_nResult
1293:         loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)
1294: 
1295:         IF EMPTY(loc_cTpop)
1296:             RETURN
1297:         ENDIF
1298: 
1299:         TRY
1300:             loc_cSQL = "SELECT Cods FROM SigOpOpt" + ;
1301:                 " WHERE RTRIM(Cods) = " + EscaparSQL(loc_cTpop) + ;
1302:                 " AND NOT Situas = 2"
1303:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkTpop")
1304: 
1305:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkTpop")
1306:                 SELECT cursor_4c_ChkTpop
1307:                 IF !EOF("cursor_4c_ChkTpop")
1308:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_ChkTpop.Cods)
1309:                 ELSE
1310:                     USE IN cursor_4c_ChkTpop
1311:                     THIS.AbrirBuscaTpop()
1312:                 ENDIF
1313:                 IF USED("cursor_4c_ChkTpop")
1314:                     USE IN cursor_4c_ChkTpop
1315:                 ENDIF
1316:             ELSE
1317:                 MsgErro("Erro ao validar tipo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1318:             ENDIF
1319:         CATCH TO loc_oErro
1320:             MsgErro("Erro ao validar tipo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarTpop")
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * TeclaPressionadaTpop - Captura F4 em txt_4c_Tpop para abrir busca
1326:     *==========================================================================
1327:     PROCEDURE TeclaPressionadaTpop(par_nKeyCode, par_nShiftAltCtrl)
1328:         IF par_nKeyCode = 63
1329:             THIS.AbrirBuscaTpop()
1330:         ENDIF
1331:     ENDPROC
1332: 
1333:     *==========================================================================
1334:     * AbrirBuscaTpop - Abre FormBuscaAuxiliar para Tipo de Material
1335:     * Original: fwBuscaSel em TmpOpt (SigOpOpt Where Not Situas=2)
1336:     *==========================================================================
1337:     PROCEDURE AbrirBuscaTpop()
1338:         LOCAL loc_cTpop, loc_cSQL, loc_nResult, loc_oBusca
1339:         loc_cTpop = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value)
1340: 
1341:         TRY
1342:             loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt" + ;
1343:                 " WHERE NOT Situas = 2 ORDER BY Cods"
1344:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTpop")
1345: 
1346:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaTpop")
1347:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1348:                 IF VARTYPE(loc_oBusca) = "O"
1349:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaTpop"
1350:                     loc_oBusca.this_cTitulo = "Tipos de Opera" + CHR(231) + CHR(227) + "o"
1351:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
1352:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1353:                     loc_oBusca.Show()
1354:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTpop")
1355:                         SELECT cursor_4c_BuscaTpop
1356:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Tpop.Value = ALLTRIM(cursor_4c_BuscaTpop.Cods)
1357:                     ENDIF
1358:                     loc_oBusca.Release()
1359:                 ENDIF
1360:             ELSE
1361:                 MsgErro("Erro ao carregar tipos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1362:             ENDIF
1363:         CATCH TO loc_oErro
1364:             MsgErro("Erro ao abrir busca de tipos:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaTpop")
1365:         ENDTRY
1366:         IF USED("cursor_4c_BuscaTpop")
1367:             USE IN cursor_4c_BuscaTpop
1368:         ENDIF
1369:     ENDPROC
1370: 
1371:     *==========================================================================
1372:     * ValidarCgru - Valida código do Grupo de Produto ao perder foco
1373:     * Original get_Cgru.Valid: fwBuscaExt em SigCdGrp por CGrus
1374:     * Após seleção: atualiza txt_4c__ds_grupo com DGrus
1375:     *==========================================================================
1376:     PROCEDURE ValidarCgru(par_nKeyCode, par_nShiftAltCtrl)
1377:         LOCAL loc_cCgru
1378:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value)
1379: 
1380:         IF EMPTY(loc_cCgru)
1381:             THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1382:             RETURN
1383:         ENDIF
1384: 
1385:         THIS.AbrirBuscaCgru()
1386:     ENDPROC
1387: 
1388:     *==========================================================================
1389:     * TeclaPressionadaCgru - Captura F4 em txt_4c__Cgru para abrir busca
1390:     *==========================================================================
1391:     PROCEDURE TeclaPressionadaCgru(par_nKeyCode, par_nShiftAltCtrl)
1392:         IF par_nKeyCode = 63
1393:             THIS.AbrirBuscaCgru()
1394:         ENDIF
1395:     ENDPROC
1396: 
1397:     *==========================================================================
1398:     * AbrirBuscaCgru - Abre FormBuscaAuxiliar para Grupo de Produto
1399:     * Tabela: SigCdGrp | Código: CGrus | Descrição: DGrus
1400:     * Após seleção: preenche ambos txt_4c__Cgru e txt_4c__ds_grupo
1401:     *==========================================================================
1402:     PROCEDURE AbrirBuscaCgru()
1403:         LOCAL loc_cCgru, loc_oBusca
1404:         loc_cCgru = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value)
1405: 
1406:         TRY
1407:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1408:                 "SigCdGrp", "cursor_4c_BuscaCgru", "CGrus", loc_cCgru, ;
1409:                 "Grupos de Produto")
1410: 
1411:             IF VARTYPE(loc_oBusca) = "O"
1412:                 IF !loc_oBusca.this_lAchouRegistro
1413:                     loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1414:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1415:                     loc_oBusca.Show()
1416:                 ENDIF
1417: 
1418:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
1419:                     SELECT cursor_4c_BuscaCgru
1420:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
1421:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
1422:                 ELSE
1423:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = " "
1424:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1425:                 ENDIF
1426:                 loc_oBusca.Release()
1427:             ENDIF
1428:         CATCH TO loc_oErro
1429:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCgru")
1430:         ENDTRY
1431:         IF USED("cursor_4c_BuscaCgru")
1432:             USE IN cursor_4c_BuscaCgru
1433:         ENDIF
1434:     ENDPROC
1435: 
1436:     *==========================================================================
1437:     * ValidarDsGrupo - Valida descrição do Grupo de Produto ao perder foco
1438:     * Original get_ds_grupo.Valid: fwBuscaExt em SigCdGrp por DGrus (bidirecional)
1439:     * Após seleção: preenche txt_4c__Cgru com CGrus correspondente
1440:     *==========================================================================
1441:     PROCEDURE ValidarDsGrupo(par_nKeyCode, par_nShiftAltCtrl)
1442:         LOCAL loc_cDesc, loc_oBusca
1443:         loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value)
1444: 
1445:         IF EMPTY(loc_cDesc)
1446:             THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value = ""
1447:             RETURN
1448:         ENDIF
1449: 
1450:         TRY
1451:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1452:                 "SigCdGrp", "cursor_4c_BuscaDsGrp", "DGrus", loc_cDesc, ;
1453:                 "Grupos de Produto")
1454: 
1455:             IF VARTYPE(loc_oBusca) = "O"
1456:                 IF !loc_oBusca.this_lAchouRegistro
1457:                     loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1458:                     loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
1459:                     loc_oBusca.Show()
1460:                 ENDIF
1461: 
1462:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDsGrp")
1463:                     SELECT cursor_4c_BuscaDsGrp
1464:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ALLTRIM(cursor_4c_BuscaDsGrp.CGrus)
1465:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaDsGrp.DGrus)
1466:                 ELSE
1467:                     THIS.pgf_4c_Paginas.Page2.txt_4c__Cgru.Value     = ""
1468:                     THIS.pgf_4c_Paginas.Page2.txt_4c__ds_grupo.Value = ""
1469:                 ENDIF
1470:                 loc_oBusca.Release()
1471:             ENDIF
1472:         CATCH TO loc_oErro
1473:             MsgErro("Erro ao buscar grupo por descri" + CHR(231) + CHR(227) + "o:" + ;
1474:                 CHR(13) + loc_oErro.Message, "FormRop.ValidarDsGrupo")
1475:         ENDTRY
1476:         IF USED("cursor_4c_BuscaDsGrp")
1477:             USE IN cursor_4c_BuscaDsGrp
1478:         ENDIF
1479:     ENDPROC
1480: 
1481:     *==========================================================================
1482:     * ValidarOpPad - Valida campo Operação Estoque ao perder foco
1483:     * Original Get_OpPad.Valid: aceita apenas E, S ou espaço
1484:     *==========================================================================
1485:     PROCEDURE ValidarOpPad(par_nKeyCode, par_nShiftAltCtrl)
1486:         LOCAL loc_cOpPad
1487:         loc_cOpPad = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_OpPad.Value)
1488: 
1489:         IF !EMPTY(loc_cOpPad) AND !INLIST(UPPER(loc_cOpPad), "E", "S")
1490:             MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
1491:                 "Digite Apenas [E] ou [S] ou [ ] !!!")
1492:             THIS.pgf_4c_Paginas.Page2.txt_4c_OpPad.Value = ""
1493:         ENDIF
1494:     ENDPROC
1495: 
1496:     *==========================================================================
1497:     * ValidarGde - Valida campo Grande Grupo ao perder foco
1498:     * Original Get_gde.Valid: fwBuscaExt em SigCdGpr por codigos
1499:     *==========================================================================
1500:     PROCEDURE ValidarGde(par_nKeyCode, par_nShiftAltCtrl)
1501:         LOCAL loc_cGde
1502:         loc_cGde = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value)
1503: 
1504:         IF EMPTY(loc_cGde)
1505:             RETURN
1506:         ENDIF
1507: 
1508:         THIS.AbrirBuscaGde()
1509:     ENDPROC
1510: 
1511:     *==========================================================================
1512:     * TeclaPressionadaGde - Captura F4 em txt_4c_Gde para abrir busca
1513:     *==========================================================================
1514:     PROCEDURE TeclaPressionadaGde(par_nKeyCode, par_nShiftAltCtrl)
1515:         IF par_nKeyCode = 63
1516:             THIS.AbrirBuscaGde()
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * AbrirBuscaGde - Abre FormBuscaAuxiliar para Grande Grupo
1522:     * Tabela: SigCdGpr | Código: codigos | Descrição: descs
1523:     *==========================================================================
1524:     PROCEDURE AbrirBuscaGde()
1525:         LOCAL loc_cGde, loc_oBusca
1526:         loc_cGde = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value)
1527: 
1528:         TRY
1529:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1530:                 "SigCdGpr", "cursor_4c_BuscaGde", "codigos", loc_cGde, ;
1531:                 "Grandes Grupos")
1532: 
1533:             IF VARTYPE(loc_oBusca) = "O"
1534:                 IF !loc_oBusca.this_lAchouRegistro
1535:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1536:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1537:                     loc_oBusca.Show()
1538:                 ENDIF
1539: 
1540:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGde")
1541:                     SELECT cursor_4c_BuscaGde
1542:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ALLTRIM(cursor_4c_BuscaGde.codigos)
1543:                 ELSE
1544:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Gde.Value = ""
1545:                 ENDIF
1546:                 loc_oBusca.Release()
1547:             ENDIF
1548:         CATCH TO loc_oErro
1549:             MsgErro("Erro ao buscar grande grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGde")
1550:         ENDTRY
1551:         IF USED("cursor_4c_BuscaGde")
1552:             USE IN cursor_4c_BuscaGde
1553:         ENDIF
1554:     ENDPROC
1555: 
1556:     *==========================================================================
1557:     * ValidarGrupos - Valida código do Grupo Contábil ao perder foco
1558:     * Tabela: SigCdGcr | Código: Codigos | Descrição: Descrs
1559:     * Após seleção: preenche ambos txt_4c_Grupo e txt_4c_Dgrupos
1560:     *==========================================================================
1561:     PROCEDURE ValidarGrupos(par_nKeyCode, par_nShiftAltCtrl)
1562:         LOCAL loc_cGrupos, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
1563:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1564:         loc_cGrupos     = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1565:         loc_lAbriuBusca = .F.
1566: 
1567:         IF EMPTY(loc_cGrupos)
1568:             loc_oPagina.txt_4c_Dgrupos.Value = ""
1569:             RETURN
1570:         ENDIF
1571: 
1572:         TRY
1573:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + ;
1574:                 EscaparSQL(loc_cGrupos)
1575:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrupos")
1576:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkGrupos")
1577:                 SELECT cursor_4c_ChkGrupos
1578:                 IF !EOF("cursor_4c_ChkGrupos")
1579:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_ChkGrupos.Codigos)
1580:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_ChkGrupos.Descrs)
1581:                 ELSE
1582:                     loc_lAbriuBusca = .T.
1583:                 ENDIF
1584:                 IF USED("cursor_4c_ChkGrupos")
1585:                     USE IN cursor_4c_ChkGrupos
1586:                 ENDIF
1587:             ELSE
1588:                 MsgErro("Erro ao validar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1589:             ENDIF
1590:         CATCH TO loc_oErro
1591:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarGrupos")
1592:         ENDTRY
1593: 
1594:         IF loc_lAbriuBusca
1595:             THIS.AbrirBuscaGrupos()
1596:         ENDIF
1597:     ENDPROC
1598: 
1599:     *==========================================================================
1600:     * TeclaPressionadaGrupos - Captura F4 em txt_4c_Grupo para abrir busca
1601:     *==========================================================================
1602:     PROCEDURE TeclaPressionadaGrupos(par_nKeyCode, par_nShiftAltCtrl)
1603:         IF par_nKeyCode = 63
1604:             THIS.AbrirBuscaGrupos()
1605:         ENDIF
1606:     ENDPROC
1607: 
1608:     *==========================================================================
1609:     * AbrirBuscaGrupos - Abre FormBuscaAuxiliar para Grupo Contábil
1610:     * Tabela: SigCdGcr | Código: Codigos | Descrição: Descrs
1611:     * Após seleção: preenche txt_4c_Grupo e txt_4c_Dgrupos
1612:     *==========================================================================
1613:     PROCEDURE AbrirBuscaGrupos()
1614:         LOCAL loc_cGrupos, loc_oBusca, loc_oPagina
1615:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1616:         loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1617: 
1618:         TRY
1619:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1620:                 "SigCdGcr", "cursor_4c_BuscaGrupos", "Codigos", loc_cGrupos, ;
1621:                 "Grupos Cont" + CHR(225) + "beis")
1622: 
1623:             IF VARTYPE(loc_oBusca) = "O"
1624:                 IF !loc_oBusca.this_lAchouRegistro
1625:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1626:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1627:                     loc_oBusca.Show()
1628:                 ENDIF
1629: 
1630:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupos")
1631:                     SELECT cursor_4c_BuscaGrupos
1632:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaGrupos.Codigos)
1633:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaGrupos.Descrs)
1634:                 ELSE
1635:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1636:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1637:                 ENDIF
1638:                 loc_oBusca.Release()
1639:             ENDIF
1640:         CATCH TO loc_oErro
1641:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaGrupos")
1642:         ENDTRY
1643:         IF USED("cursor_4c_BuscaGrupos")
1644:             USE IN cursor_4c_BuscaGrupos
1645:         ENDIF
1646:     ENDPROC
1647: 
1648:     *==========================================================================
1649:     * ValidarDgrupos - Valida descrição do Grupo Contábil ao perder foco
1650:     * Busca bidirecional em SigCdGcr por Descrs; preenche txt_4c_Grupo com código
1651:     *==========================================================================
1652:     PROCEDURE ValidarDgrupos(par_nKeyCode, par_nShiftAltCtrl)
1653:         LOCAL loc_cDesc, loc_oBusca, loc_oPagina
1654:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1655:         loc_cDesc   = ALLTRIM(loc_oPagina.txt_4c_Dgrupos.Value)
1656: 
1657:         IF EMPTY(loc_cDesc)
1658:             loc_oPagina.txt_4c_Grupo.Value = ""
1659:             RETURN
1660:         ENDIF
1661: 
1662:         TRY
1663:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1664:                 "SigCdGcr", "cursor_4c_BuscaDgrupos", "Descrs", loc_cDesc, ;
1665:                 "Grupos Cont" + CHR(225) + "beis")
1666: 
1667:             IF VARTYPE(loc_oBusca) = "O"
1668:                 IF !loc_oBusca.this_lAchouRegistro
1669:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1670:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1671:                     loc_oBusca.Show()
1672:                 ENDIF
1673: 
1674:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDgrupos")
1675:                     SELECT cursor_4c_BuscaDgrupos
1676:                     loc_oPagina.txt_4c_Grupo.Value   = ALLTRIM(cursor_4c_BuscaDgrupos.Codigos)
1677:                     loc_oPagina.txt_4c_Dgrupos.Value = ALLTRIM(cursor_4c_BuscaDgrupos.Descrs)
1678:                 ELSE
1679:                     loc_oPagina.txt_4c_Grupo.Value   = ""
1680:                     loc_oPagina.txt_4c_Dgrupos.Value = ""
1681:                 ENDIF
1682:                 loc_oBusca.Release()
1683:             ENDIF
1684:         CATCH TO loc_oErro
1685:             MsgErro("Erro ao buscar grupo:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarDgrupos")
1686:         ENDTRY
1687:         IF USED("cursor_4c_BuscaDgrupos")
1688:             USE IN cursor_4c_BuscaDgrupos
1689:         ENDIF
1690:     ENDPROC
1691: 
1692:     *==========================================================================
1693:     * ValidarConta - Valida código de Conta Destino ao perder foco
1694:     * Tabela: SigCdCli | Código: IClis
1695:     *==========================================================================
1696:     PROCEDURE ValidarConta(par_nKeyCode, par_nShiftAltCtrl)
1697:         LOCAL loc_cConta, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
1698:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1699:         loc_cConta      = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1700:         loc_lAbriuBusca = .F.
1701: 
1702:         IF EMPTY(loc_cConta)
1703:             RETURN
1704:         ENDIF
1705: 
1706:         TRY
1707:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1708:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1709:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1710:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
1711:                 SELECT cursor_4c_ChkConta
1712:                 IF !EOF("cursor_4c_ChkConta")
1713:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_ChkConta.IClis)
1714:                 ELSE
1715:                     loc_lAbriuBusca = .T.
1716:                 ENDIF
1717:                 IF USED("cursor_4c_ChkConta")
1718:                     USE IN cursor_4c_ChkConta
1719:                 ENDIF
1720:             ELSE
1721:                 MsgErro("Erro ao validar conta:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1722:             ENDIF
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarConta")
1725:         ENDTRY
1726: 
1727:         IF loc_lAbriuBusca
1728:             THIS.AbrirBuscaConta()
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     *==========================================================================
1733:     * TeclaPressionadaConta - Captura F4 em txt_4c_Conta para abrir busca
1734:     *==========================================================================
1735:     PROCEDURE TeclaPressionadaConta(par_nKeyCode, par_nShiftAltCtrl)
1736:         IF par_nKeyCode = 63
1737:             THIS.AbrirBuscaConta()
1738:         ENDIF
1739:     ENDPROC
1740: 
1741:     *==========================================================================
1742:     * AbrirBuscaConta - Abre FormBuscaAuxiliar para Conta Destino
1743:     * Tabela: SigCdCli | Código: IClis | Descrição: Nomes
1744:     *==========================================================================
1745:     PROCEDURE AbrirBuscaConta()
1746:         LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_oPagina
1747:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1748: 
1749:         TRY
1750:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1751:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1752:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1753: 
1754:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaConta")
1755:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1756:                 IF VARTYPE(loc_oBusca) = "O"
1757:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaConta"
1758:                     loc_oBusca.this_cTitulo = "Contas"
1759:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1760:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1761:                     loc_oBusca.Show()
1762:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1763:                         SELECT cursor_4c_BuscaConta
1764:                         loc_oPagina.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.IClis)
1765:                     ENDIF
1766:                     loc_oBusca.Release()
1767:                 ENDIF
1768:             ELSE
1769:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1770:             ENDIF
1771:         CATCH TO loc_oErro
1772:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaConta")
1773:         ENDTRY
1774:         IF USED("cursor_4c_BuscaConta")
1775:             USE IN cursor_4c_BuscaConta
1776:         ENDIF
1777:     ENDPROC
1778: 
1779:     *==========================================================================
1780:     * ValidarContaOrig - Valida código de Conta Origem ao perder foco
1781:     * Tabela: SigCdCli | Código: IClis
1782:     *==========================================================================
1783:     PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
1784:         LOCAL loc_cConta, loc_cSQL, loc_nResult, loc_oPagina, loc_lAbriuBusca
1785:         loc_oPagina     = THIS.pgf_4c_Paginas.Page2
1786:         loc_cConta      = ALLTRIM(loc_oPagina.txt_4c_ContaOrig.Value)
1787:         loc_lAbriuBusca = .F.
1788: 
1789:         IF EMPTY(loc_cConta)
1790:             RETURN
1791:         ENDIF
1792: 
1793:         TRY
1794:             loc_cSQL = "SELECT IClis FROM SigCdCli WHERE RTRIM(IClis) = " + ;
1795:                 EscaparSQL(loc_cConta) + " AND Inativas = 0"
1796:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkContaOrig")
1797:             IF loc_nResult >= 0 AND USED("cursor_4c_ChkContaOrig")
1798:                 SELECT cursor_4c_ChkContaOrig
1799:                 IF !EOF("cursor_4c_ChkContaOrig")
1800:                     loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_ChkContaOrig.IClis)
1801:                 ELSE
1802:                     loc_lAbriuBusca = .T.
1803:                 ENDIF
1804:                 IF USED("cursor_4c_ChkContaOrig")
1805:                     USE IN cursor_4c_ChkContaOrig
1806:                 ENDIF
1807:             ELSE
1808:                 MsgErro("Erro ao validar conta origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1809:             ENDIF
1810:         CATCH TO loc_oErro
1811:             MsgErro("Erro ao validar conta origem:" + CHR(13) + loc_oErro.Message, "FormRop.ValidarContaOrig")
1812:         ENDTRY
1813: 
1814:         IF loc_lAbriuBusca
1815:             THIS.AbrirBuscaContaOrig()
1816:         ENDIF
1817:     ENDPROC
1818: 
1819:     *==========================================================================
1820:     * TeclaPressionadaContaOrig - Captura F4 em txt_4c_ContaOrig para abrir busca
1821:     *==========================================================================
1822:     PROCEDURE TeclaPressionadaContaOrig(par_nKeyCode, par_nShiftAltCtrl)
1823:         IF par_nKeyCode = 63
1824:             THIS.AbrirBuscaContaOrig()
1825:         ENDIF
1826:     ENDPROC
1827: 
1828:     *==========================================================================
1829:     * AbrirBuscaContaOrig - Abre FormBuscaAuxiliar para Conta Origem
1830:     * Tabela: SigCdCli | Código: IClis | Descrição: Nomes
1831:     *==========================================================================
1832:     PROCEDURE AbrirBuscaContaOrig()
1833:         LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_oPagina
1834:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1835: 
1836:         TRY
1837:             loc_cSQL = "SELECT TOP 500 RTRIM(IClis) AS IClis, RTRIM(Nomes) AS Nomes" + ;
1838:                 " FROM SigCdCli WHERE Inativas = 0 ORDER BY IClis"
1839:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaContaOrig")
1840: 
1841:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaContaOrig")
1842:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1843:                 IF VARTYPE(loc_oBusca) = "O"
1844:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaContaOrig"
1845:                     loc_oBusca.this_cTitulo = "Contas"
1846:                     loc_oBusca.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
1847:                     loc_oBusca.mAddColuna("Nomes",  "", "Nome")
1848:                     loc_oBusca.Show()
1849:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOrig")
1850:                         SELECT cursor_4c_BuscaContaOrig
1851:                         loc_oPagina.txt_4c_ContaOrig.Value = ALLTRIM(cursor_4c_BuscaContaOrig.IClis)
1852:                     ENDIF
1853:                     loc_oBusca.Release()
1854:                 ENDIF
1855:             ELSE
1856:                 MsgErro("Erro ao carregar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1857:             ENDIF
1858:         CATCH TO loc_oErro
1859:             MsgErro("Erro ao abrir busca de contas:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaContaOrig")
1860:         ENDTRY
1861:         IF USED("cursor_4c_BuscaContaOrig")
1862:             USE IN cursor_4c_BuscaContaOrig
1863:         ENDIF
1864:     ENDPROC
1865: 
1866:     *==========================================================================
1867:     * ValidarCor - Valida código de Cor ao perder foco
1868:     * Tabela: SigCdCor | Código: Cods
1869:     *==========================================================================
1870:     PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
1871:         LOCAL loc_cCor, loc_oPagina
1872:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1873:         loc_cCor    = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)
1874: 
1875:         IF EMPTY(loc_cCor)
1876:             RETURN
1877:         ENDIF
1878: 
1879:         THIS.AbrirBuscaCor()
1880:     ENDPROC
1881: 
1882:     *==========================================================================
1883:     * TeclaPressionadaCor - Captura F4 em txt_4c_Cor para abrir busca
1884:     *==========================================================================
1885:     PROCEDURE TeclaPressionadaCor(par_nKeyCode, par_nShiftAltCtrl)
1886:         IF par_nKeyCode = 63
1887:             THIS.AbrirBuscaCor()
1888:         ENDIF
1889:     ENDPROC
1890: 
1891:     *==========================================================================
1892:     * AbrirBuscaCor - Abre FormBuscaAuxiliar para Cor
1893:     * Tabela: SigCdCor | Código: Cods | Descrição: Descs
1894:     *==========================================================================
1895:     PROCEDURE AbrirBuscaCor()
1896:         LOCAL loc_cCor, loc_oBusca, loc_oPagina
1897:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1898:         loc_cCor    = ALLTRIM(loc_oPagina.txt_4c_Cor.Value)
1899: 
1900:         TRY
1901:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1902:                 "SigCdCor", "cursor_4c_BuscaCor", "Cods", loc_cCor, ;
1903:                 "Cores")
1904: 
1905:             IF VARTYPE(loc_oBusca) = "O"
1906:                 IF !loc_oBusca.this_lAchouRegistro
1907:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1908:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1909:                     loc_oBusca.Show()
1910:                 ENDIF
1911: 
1912:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
1913:                     SELECT cursor_4c_BuscaCor
1914:                     loc_oPagina.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
1915:                 ELSE
1916:                     loc_oPagina.txt_4c_Cor.Value = ""
1917:                 ENDIF
1918:                 loc_oBusca.Release()
1919:             ENDIF
1920:         CATCH TO loc_oErro
1921:             MsgErro("Erro ao buscar cor:" + CHR(13) + loc_oErro.Message, "FormRop.AbrirBuscaCor")
1922:         ENDTRY
1923:         IF USED("cursor_4c_BuscaCor")
1924:             USE IN cursor_4c_BuscaCor
1925:         ENDIF
1926:     ENDPROC
1927: 
1928:     *==========================================================================
1929:     * AjustarBotoesPorModo - Ajusta botões da Page2 conforme modo atual
1930:     *==========================================================================
1931:     PROCEDURE AjustarBotoesPorModo()
1932:         LOCAL loc_oPagina
1933:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1934: 
1935:         DO CASE
1936:             CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
1937:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1938:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1939:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1940:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1941:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1942:             OTHERWISE
1943:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1944:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1945:         ENDCASE
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     * Destroy - Libera recursos ao fechar o formulário
1950:     *==========================================================================
1951:     PROCEDURE Destroy()
1952:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1953:             THIS.this_oBusinessObject = .NULL.
1954:         ENDIF
1955:         DODEFAULT()
1956:     ENDPROC
1957: 
1958: ENDDEFINE


### BO (C:\4c\projeto\app\classes\RopBO.prg):
*==============================================================================
* RopBO.prg
*
* Business Object para Cadastro de Restricoes Por Operacao
* Tabela: SigCdRpo
* Herda de: BusinessBase
*
* Colunas da tabela SigCdRpo:
*   cidchaves  char(20)    PK - Chave unica gerada via NEWID
*   cgrus      char(3)     Grupo de Produto
*   dopps      char(20)    Operacao de Producao
*   doptpgrus  char(48)    Composto: Dopp+TpOp+Cgru+Mercs+Grupos
*   tpops      char(15)    Tipo de Material/Operacao
*   mercs      char(3)     Grande Grupo
*   opers      char(1)     Operacao Estoque (E/S)
*   grupos     char(10)    Grupo de Conta Contabil
*   exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
*   contas     char(10)    Conta Destino
*   codcors    char(4)     Codigo da Cor
*   contaorig  char(10)    Conta Origem
*==============================================================================

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdRpo)
    this_cCidChaves  = ""   && cidchaves  char(20)    PK
    this_cCgrus      = ""   && cgrus      char(3)     Grupo de Produto
    this_cDopps      = ""   && dopps      char(20)    Operacao
    this_cDoptpgrus  = ""   && doptpgrus  char(48)    Composto (auto-gerado)
    this_cTpops      = ""   && tpops      char(15)    Tipo de Material
    this_cMercs      = ""   && mercs      char(3)     Grande Grupo
    this_cOpers      = ""   && opers      char(1)     Op.Estoque E/S
    this_cGrupos     = ""   && grupos     char(10)    Grupo Conta
    this_nExclus     = 2    && exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
    this_cContas     = ""   && contas     char(10)    Conta Destino
    this_cCodcors    = ""   && codcors    char(4)     Cor
    this_cContaorig  = ""   && contaorig  char(10)    Conta Origem

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCgrus      = TratarNulo(cgrus,      "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_cDoptpgrus  = TratarNulo(doptpgrus,  "C")
                THIS.this_cTpops      = TratarNulo(tpops,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cOpers      = TratarNulo(opers,      "C")
                THIS.this_cGrupos     = TratarNulo(grupos,     "C")
                THIS.this_nExclus     = TratarNulo(exclus,     "N")
                THIS.this_cContas     = TratarNulo(contas,     "C")
                THIS.this_cCodcors    = TratarNulo(codcors,    "C")
                THIS.this_cContaorig  = TratarNulo(contaorig,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves  = ""
        THIS.this_cCgrus      = ""
        THIS.this_cDopps      = ""
        THIS.this_cDoptpgrus  = ""
        THIS.this_cTpops      = ""
        THIS.this_cMercs      = ""
        THIS.this_cOpers      = ""
        THIS.this_cGrupos     = ""
        THIS.this_nExclus     = 2
        THIS.this_cContas     = ""
        THIS.this_cCodcors    = ""
        THIS.this_cContaorig  = ""
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(THIS.this_cTpops) AND EMPTY(THIS.this_cCgrus) AND ;
               EMPTY(THIS.this_cMercs) AND EMPTY(THIS.this_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo de Material Ou " + ;
                    "Grupo de Produto Ou Grande Grupo Ou Grupo Conta")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite Apenas [E] ou [S] ou [ ] !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido
            IF THIS.VerificarDuplicidade()
                MsgAviso("Restri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica restricao ja cadastrada com mesmos campos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRpo" + ;
                " WHERE Dopps    = " + EscaparSQL(THIS.this_cDopps) + ;
                " AND   TpOps    = " + EscaparSQL(THIS.this_cTpops) + ;
                " AND   CGrus    = " + EscaparSQL(THIS.this_cCgrus) + ;
                " AND   Mercs    = " + EscaparSQL(THIS.this_cMercs) + ;
                " AND   Grupos   = " + EscaparSQL(THIS.this_cGrupos) + ;
                " AND   Contas   = " + EscaparSQL(THIS.this_cContas) + ;
                " AND   ContaOrig= " + EscaparSQL(THIS.this_cContaorig) + ;
                " AND   CodCors  = " + EscaparSQL(THIS.this_cCodcors) + ;
                " AND   cidchaves <> " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RopBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult, loc_cSQL
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RopBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RopBO.Inserir")
            ELSE
                THIS.this_cDoptpgrus = LEFT( ;
                    ALLTRIM(THIS.this_cDopps)  + ;
                    ALLTRIM(THIS.this_cTpops)  + ;
                    ALLTRIM(THIS.this_cCgrus)  + ;
                    ALLTRIM(THIS.this_cMercs)  + ;
                    ALLTRIM(THIS.this_cGrupos) + ;
                    SPACE(48), 48)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdRpo (
                        cidchaves, cgrus, dopps, doptpgrus, tpops,
                        mercs, opers, grupos, exclus, contas, codcors, contaorig
                    ) VALUES (
                        <<EscaparSQL(THIS.this_cCidChaves)>>,
                        <<EscaparSQL(THIS.this_cCgrus)>>,
                        <<EscaparSQL(THIS.this_cDopps)>>,
                        <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                        <<EscaparSQL(THIS.this_cTpops)>>,
                        <<EscaparSQL(THIS.this_cMercs)>>,
                        <<EscaparSQL(THIS.this_cOpers)>>,
                        <<EscaparSQL(THIS.this_cGrupos)>>,
                        <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                        <<EscaparSQL(THIS.this_cContas)>>,
                        <<EscaparSQL(THIS.this_cCodcors)>>,
                        <<EscaparSQL(THIS.this_cContaorig)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDoptpgrus = LEFT( ;
                ALLTRIM(THIS.this_cDopps)  + ;
                ALLTRIM(THIS.this_cTpops)  + ;
                ALLTRIM(THIS.this_cCgrus)  + ;
                ALLTRIM(THIS.this_cMercs)  + ;
                ALLTRIM(THIS.this_cGrupos) + ;
                SPACE(48), 48)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdRpo SET
                    cgrus      = <<EscaparSQL(THIS.this_cCgrus)>>,
                    dopps      = <<EscaparSQL(THIS.this_cDopps)>>,
                    doptpgrus  = <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                    tpops      = <<EscaparSQL(THIS.this_cTpops)>>,
                    mercs      = <<EscaparSQL(THIS.this_cMercs)>>,
                    opers      = <<EscaparSQL(THIS.this_cOpers)>>,
                    grupos     = <<EscaparSQL(THIS.this_cGrupos)>>,
                    exclus     = <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodcors)>>,
                    contaorig  = <<EscaparSQL(THIS.this_cContaorig)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas para o grid (ordem identica ao legado)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        dopps     C(20), ;
                        tpops     C(15), ;
                        cgrus     C(3),  ;
                        opers     C(1),  ;
                        mercs     C(3),  ;
                        grupos    C(10), ;
                        contas    C(10), ;
                        contaorig C(10), ;
                        codcors   C(4),  ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT dopps, tpops, cgrus, opers, mercs," + ;
                    " grupos, contas, contaorig, codcors, cidchaves" + ;
                    " FROM SigCdRpo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dopps, tpops, cgrus"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cgrus, dopps, doptpgrus, tpops," + ;
                " mercs, opers, grupos, exclus, contas, codcors, contaorig" + ;
                " FROM SigCdRpo WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

