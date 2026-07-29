# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BINDEVENT-PARAMS] Handler 'ValidarVendedor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarVendedor(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Vend' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome Vendedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição Local' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Status' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Localização, Qtde., Estoque. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcnl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1966 linhas total):

*-- Linhas 6 a 176:
6: *
7: * ESTRUTURA DO FORM:
8: *   Page1 (Lista): grid de contagens + botoes CRUD + botoes especiais
9: *   Page2 (Dados): campos do cabecalho + grid de itens (GrdLoc) + OptionGroup
10: *===========================================================================
11: 
12: DEFINE CLASS Formcnl AS FormBase
13: 
14:     *-- Propriedades visuais (PILAR 1 - UX Fidelity)
15:     Height      = 600
16:     Width       = 1000
17:     Caption     = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
18:     AutoCenter  = .T.
19:     ShowWindow  = 1
20:     WindowType  = 1
21:     ControlBox  = .F.
22:     TitleBar    = 0
23:     Themes      = .F.
24:     BorderStyle = 2
25: 
26:     *-- Propriedades de estado
27:     this_oBusinessObject = .NULL.
28:     this_cModoAtual      = "LISTA"
29: 
30:     *==========================================================================
31:     * Init - Inicializa o formulario
32:     * DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
33:     *==========================================================================
34:     PROCEDURE Init()
35:         LOCAL loc_lSucesso, loc_oErro
36:         loc_lSucesso = .F.
37: 
38:         TRY
39:             loc_lSucesso = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro("Erro ao inicializar Formcnl:" + CHR(13) + ;
42:                     loc_oErro.Message, "Erro")
43:         ENDTRY
44: 
45:         RETURN loc_lSucesso
46:     ENDPROC
47: 
48:     *==========================================================================
49:     * InicializarForm - Configura estrutura completa do formulario
50:     * Chamado automaticamente pelo FormBase.Init()
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lSucesso, loc_oErro
54:         loc_lSucesso = .F.
55: 
56:         TRY
57:             *-- Instanciar Business Object
58:             THIS.this_oBusinessObject = CREATEOBJECT("cnlBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Erro ao criar Business Object cnlBO", ;
62:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
63:             ELSE
64:                 *-- Configurar estrutura de paginas
65:                 THIS.ConfigurarPageFrame()
66: 
67:                 *-- Carregar lista inicial (pular se validando UI)
68:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
69:                     THIS.CarregarLista()
70:                 ENDIF
71: 
72:                 THIS.pgf_4c_Paginas.Visible = .T.
73:                 THIS.pgf_4c_Paginas.ActivePage = 1
74:                 THIS.this_cModoAtual = "LISTA"
75:                 loc_lSucesso = .T.
76:             ENDIF
77: 
78:         CATCH TO loc_oErro
79:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + ;
80:                     loc_oErro.Message, "Erro")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *==========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista + Dados)
88:     * PageFrame.Top = -29 oculta as abas (Tabs=.F.)
89:     * Todos os controles nas Pages precisam compensar +29 no Top
90:     *==========================================================================
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:         LOCAL loc_oErro
93: 
94:         TRY
95:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
96: 
97:             WITH THIS.pgf_4c_Paginas
98:                 .Top       = -29
99:                 .Left      = 0
100:                 .Width     = 1000
101:                 .Height    = 629
102:                 .PageCount = 2
103:                 .Tabs      = .F.
104:                 .Visible   = .T.
105: 
106:                 *-- Page1: Lista de contagens
107:                 .Page1.Caption   = "Lista"
108:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:                 .Page1.BackColor = RGB(100, 100, 100)
110: 
111:                 *-- Page2: Dados da contagem (cabecalho + itens)
112:                 .Page2.Caption   = "Dados"
113:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:                 .Page2.BackColor = RGB(100, 100, 100)
115:             ENDWITH
116: 
117:             *-- Imagens de fundo das paginas
118:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:             *-- Configurar conteudo das paginas
122:             THIS.ConfigurarPaginaLista()
123:             THIS.ConfigurarPaginaDados()
124: 
125:         CATCH TO loc_oErro
126:             MsgErro("Erro ao configurar PageFrame:" + CHR(13) + ;
127:                     loc_oErro.Message, "Erro")
128:         ENDTRY
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD,
133:     *   botoes especiais (Espelho/Fechar/Abrir) e grid de listagem
134:     * TOPS compensados (+29 por PageFrame.Top=-29)
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarPaginaLista()
137:         LOCAL loc_oPagina, loc_oErro
138:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
139: 
140:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
141:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
142: 
143:         TRY
144:             *--------------------------------------------------------------
145:             * Container Cabecalho cinza (cntSombra no legado)
146:             * Original: Top=2 -> Compensado: Top=31
147:             *--------------------------------------------------------------
148:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
149:             WITH loc_oPagina.cnt_4c_Cabecalho
150:                 .Top         = 31
151:                 .Left        = 0
152:                 .Width       = THIS.Width
153:                 .Height      = 80
154:                 .BackColor   = RGB(100, 100, 100)
155:                 .BorderWidth = 0
156:                 .Visible     = .T.
157:             ENDWITH
158: 
159:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
160:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
161:                 .Top       = 15
162:                 .Left      = 10
163:                 .Width     = 769
164:                 .Height    = 40
165:                 .Caption   = "Contagem de Produtos por Localiza" + CHR(231) + CHR(227) + "o"
166:                 .FontName  = "Tahoma"
167:                 .FontSize  = 16
168:                 .FontBold  = .T.
169:                 .ForeColor = RGB(0, 0, 0)
170:                 .BackStyle = 0
171:                 .AutoSize  = .F.
172:                 .Visible   = .T.
173:             ENDWITH
174: 
175:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
176:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo

*-- Linhas 226 a 580:
226:                 .AutoSize        = .F.
227:                 .Visible         = .T.
228:             ENDWITH
229:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
230: 
231:             *-- Visualizar
232:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
233:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
234:                 .Caption         = "Visualizar"
235:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
236:                 .PicturePosition = 13
237:                 .Top             = 5
238:                 .Left            = 80
239:                 .Width           = 75
240:                 .Height          = 75
241:                 .BackColor       = RGB(255, 255, 255)
242:                 .ForeColor       = RGB(90, 90, 90)
243:                 .FontName        = "Comic Sans MS"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.
246:                 .FontSize        = 8
247:                 .Themes          = .F.
248:                 .SpecialEffect   = 0
249:                 .MousePointer    = 15
250:                 .WordWrap        = .T.
251:                 .AutoSize        = .F.
252:                 .Visible         = .T.
253:             ENDWITH
254:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
255: 
256:             *-- Alterar
257:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
258:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
259:                 .Caption         = "Alterar"
260:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
261:                 .PicturePosition = 13
262:                 .Top             = 5
263:                 .Left            = 155
264:                 .Width           = 75
265:                 .Height          = 75
266:                 .BackColor       = RGB(255, 255, 255)
267:                 .ForeColor       = RGB(90, 90, 90)
268:                 .FontName        = "Comic Sans MS"
269:                 .FontBold        = .T.
270:                 .FontItalic      = .T.
271:                 .FontSize        = 8
272:                 .Themes          = .F.
273:                 .SpecialEffect   = 0
274:                 .MousePointer    = 15
275:                 .WordWrap        = .T.
276:                 .AutoSize        = .F.
277:                 .Visible         = .T.
278:             ENDWITH
279:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
280: 
281:             *-- Excluir
282:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
283:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
284:                 .Caption         = "Excluir"
285:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
286:                 .PicturePosition = 13
287:                 .Top             = 5
288:                 .Left            = 230
289:                 .Width           = 75
290:                 .Height          = 75
291:                 .BackColor       = RGB(255, 255, 255)
292:                 .ForeColor       = RGB(90, 90, 90)
293:                 .FontName        = "Comic Sans MS"
294:                 .FontBold        = .T.
295:                 .FontItalic      = .T.
296:                 .FontSize        = 8
297:                 .Themes          = .F.
298:                 .SpecialEffect   = 0
299:                 .MousePointer    = 15
300:                 .WordWrap        = .T.
301:                 .AutoSize        = .F.
302:                 .Visible         = .T.
303:             ENDWITH
304:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
305: 
306:             *-- Buscar
307:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
308:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
309:                 .Caption         = "Buscar"
310:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
311:                 .PicturePosition = 13
312:                 .Top             = 5
313:                 .Left            = 305
314:                 .Width           = 75
315:                 .Height          = 75
316:                 .BackColor       = RGB(255, 255, 255)
317:                 .ForeColor       = RGB(90, 90, 90)
318:                 .FontName        = "Comic Sans MS"
319:                 .FontBold        = .T.
320:                 .FontItalic      = .T.
321:                 .FontSize        = 8
322:                 .Themes          = .F.
323:                 .SpecialEffect   = 0
324:                 .MousePointer    = 15
325:                 .WordWrap        = .T.
326:                 .AutoSize        = .F.
327:                 .Visible         = .T.
328:             ENDWITH
329:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
330: 
331:             *--------------------------------------------------------------
332:             * Container Saida - padrao canonico (PREVALECE SOBRE PILAR 1)
333:             *--------------------------------------------------------------
334:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
335:             WITH loc_oPagina.cnt_4c_Saida
336:                 .Top         = 29
337:                 .Left        = 917
338:                 .Width       = 90
339:                 .Height      = 85
340:                 .BackStyle   = 0
341:                 .BorderWidth = 0
342:                 .Visible     = .T.
343:             ENDWITH
344: 
345:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
346:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
347:                 .Caption         = "Encerrar"
348:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
349:                 .PicturePosition = 13
350:                 .Top             = 5
351:                 .Left            = 5
352:                 .Width           = 75
353:                 .Height          = 75
354:                 .BackColor       = RGB(255, 255, 255)
355:                 .ForeColor       = RGB(90, 90, 90)
356:                 .FontName        = "Comic Sans MS"
357:                 .FontBold        = .T.
358:                 .FontItalic      = .T.
359:                 .FontSize        = 8
360:                 .Themes          = .F.
361:                 .SpecialEffect   = 0
362:                 .MousePointer    = 15
363:                 .WordWrap        = .T.
364:                 .AutoSize        = .F.
365:                 .Visible         = .T.
366:             ENDWITH
367:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
368: 
369:             *--------------------------------------------------------------
370:             * Botoes especiais do legado: Espelho / Fechar / Abrir
371:             * Original: Top=82 -> Compensado: Top=111
372:             * Posicoes: Left=14, 119, 224 (direto na Page1)
373:             *--------------------------------------------------------------
374:             loc_oPagina.AddObject("cmd_4c_Espelho", "CommandButton")
375:             WITH loc_oPagina.cmd_4c_Espelho
376:                 .Caption       = "Espelho"
377:                 .Top           = 111
378:                 .Left          = 14
379:                 .Width         = 105
380:                 .Height        = 40
381:                 .BackColor     = RGB(200, 200, 200)
382:                 .ForeColor     = RGB(90, 90, 90)
383:                 .FontName      = "Tahoma"
384:                 .FontSize      = 8
385:                 .FontBold      = .F.
386:                 .Themes        = .F.
387:                 .SpecialEffect = 0
388:                 .Visible       = .T.
389:             ENDWITH
390:             BINDEVENT(loc_oPagina.cmd_4c_Espelho, "Click", THIS, "BtnEspelhoClick")
391: 
392:             loc_oPagina.AddObject("cmd_4c_Fechar", "CommandButton")
393:             WITH loc_oPagina.cmd_4c_Fechar
394:                 .Caption       = "Encerrar"
395:                 .Top           = 111
396:                 .Left          = 119
397:                 .Width         = 75
398:                 .Height        = 75
399:                 .BackColor     = RGB(200, 200, 200)
400:                 .ForeColor     = RGB(90, 90, 90)
401:                 .FontName      = "Tahoma"
402:                 .FontSize      = 8
403:                 .FontBold      = .F.
404:                 .Themes        = .F.
405:                 .SpecialEffect = 0
406:                 .Visible       = .T.
407:             ENDWITH
408:             BINDEVENT(loc_oPagina.cmd_4c_Fechar, "Click", THIS, "BtnFecharContagemClick")
409: 
410:             loc_oPagina.AddObject("cmd_4c_Abrir", "CommandButton")
411:             WITH loc_oPagina.cmd_4c_Abrir
412:                 .Caption       = "Abrir"
413:                 .Top           = 111
414:                 .Left          = 224
415:                 .Width         = 105
416:                 .Height        = 40
417:                 .BackColor     = RGB(200, 200, 200)
418:                 .ForeColor     = RGB(90, 90, 90)
419:                 .FontName      = "Tahoma"
420:                 .FontSize      = 8
421:                 .FontBold      = .F.
422:                 .Themes        = .F.
423:                 .SpecialEffect = 0
424:                 .Visible       = .T.
425:             ENDWITH
426:             BINDEVENT(loc_oPagina.cmd_4c_Abrir, "Click", THIS, "BtnAbrirContagemClick")
427: 
428:             *--------------------------------------------------------------
429:             * Grid de listagem de contagens
430:             * Abaixo dos botoes especiais: 111+40+4=155 -> Top=155
431:             * Width=900 para nao sobrepor cnt_4c_Saida (Left=917)
432:             *--------------------------------------------------------------
433:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
434:             loc_oPagina.grd_4c_Dados.RecordSource = ""
435:             loc_oPagina.grd_4c_Dados.ColumnCount  = 7
436: 
437:             WITH loc_oPagina.grd_4c_Dados
438:                 .Top                = 155
439:                 .Left               = 12
440:                 .Width              = 900
441:                 .Height             = 440
442:                 .FontName           = "Verdana"
443:                 .FontSize           = 8
444:                 .ForeColor          = RGB(90, 90, 90)
445:                 .BackColor          = RGB(255, 255, 255)
446:                 .GridLineColor      = RGB(238, 238, 238)
447:                 .HighlightBackColor = RGB(255, 255, 255)
448:                 .HighlightForeColor = RGB(15, 41, 104)
449:                 .HighlightStyle     = 2
450:                 .DeleteMark         = .F.
451:                 .RecordMark         = .F.
452:                 .RowHeight          = 18
453:                 .ScrollBars         = 3
454:                 .GridLines          = 3
455:                 .Visible            = .T.
456:             ENDWITH
457: 
458:             THIS.TornarControlesVisiveis(loc_oPagina)
459: 
460:         CATCH TO loc_oErro
461:             MsgErro("Erro ao configurar P" + CHR(225) + "gina Lista:" + CHR(13) + ;
462:                     loc_oErro.Message, "Erro")
463:         ENDTRY
464:     ENDPROC
465: 
466:     *==========================================================================
467:     * ConfigurarPaginaDados - Configura Page2: botoes, campos cabecalho (Fase 5)
468:     * TOPS compensados (+29 por PageFrame.Top=-29)
469:     *==========================================================================
470:     PROTECTED PROCEDURE ConfigurarPaginaDados()
471:         LOCAL loc_oPagina, loc_oErro
472:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
473: 
474:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
475:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
476: 
477:         TRY
478:             *--------------------------------------------------------------
479:             * Container Botoes de Acao (Salvar/Cancelar) - Grupo_Salva no legado
480:             * Original: Top=4 -> Compensado: Top=33
481:             *--------------------------------------------------------------
482:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
483:             WITH loc_oPagina.cnt_4c_BotoesAcao
484:                 .Top         = 33
485:                 .Left        = 842
486:                 .Width       = 160
487:                 .Height      = 85
488:                 .BackStyle   = 0
489:                 .Visible     = .T.
490:             ENDWITH
491: 
492:             *-- Confirmar (Salvar)
493:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
495:                 .Caption         = "Confirmar"
496:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
497:                 .PicturePosition = 13
498:                 .Top             = 5
499:                 .Left            = 5
500:                 .Width           = 75
501:                 .Height          = 75
502:                 .BackColor       = RGB(255, 255, 255)
503:                 .ForeColor       = RGB(90, 90, 90)
504:                 .FontName        = "Comic Sans MS"
505:                 .FontBold        = .T.
506:                 .FontItalic      = .T.
507:                 .FontSize        = 8
508:                 .Themes          = .F.
509:                 .SpecialEffect   = 0
510:                 .MousePointer    = 15
511:                 .WordWrap        = .T.
512:                 .AutoSize        = .F.
513:                 .Visible         = .T.
514:             ENDWITH
515:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
516: 
517:             *-- Cancelar
518:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
519:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
520:                 .Caption         = "Encerrar"
521:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
522:                 .PicturePosition = 13
523:                 .Top             = 5
524:                 .Left            = 80
525:                 .Width           = 75
526:                 .Height          = 75
527:                 .BackColor       = RGB(255, 255, 255)
528:                 .ForeColor       = RGB(90, 90, 90)
529:                 .FontName        = "Comic Sans MS"
530:                 .FontBold        = .T.
531:                 .FontItalic      = .T.
532:                 .FontSize        = 8
533:                 .Themes          = .F.
534:                 .SpecialEffect   = 0
535:                 .MousePointer    = 15
536:                 .WordWrap        = .T.
537:                 .AutoSize        = .F.
538:                 .Visible         = .T.
539:             ENDWITH
540:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
541: 
542:             *--------------------------------------------------------------
543:             * Shape1 - elemento visual decorativo da area de niveis
544:             * Original: Top=169, Left=626 -> Compensado: Top=198
545:             *--------------------------------------------------------------
546:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
547:             WITH loc_oPagina.shp_4c_Shape1
548:                 .Top         = 198
549:                 .Left        = 626
550:                 .Width       = 364
551:                 .Height      = 144
552:                 .BackStyle   = 0
553:                 .BorderWidth = 1
554:                 .BorderColor = RGB(128, 128, 128)
555:                 .Visible     = .T.
556:             ENDWITH
557: 
558:             *--------------------------------------------------------------
559:             * Label4 "Codigo :" + txt_4c_Codigo (getCods - somente leitura)
560:             * Original: Label4.Top=99, getCods.Top=94 -> Compensados: +29
561:             *--------------------------------------------------------------
562:             loc_oPagina.AddObject("lbl_4c_Label4", "Label")
563:             WITH loc_oPagina.lbl_4c_Label4
564:                 .Caption   = "C" + CHR(243) + "digo : "
565:                 .Top       = 128
566:                 .Left      = 301
567:                 .Width     = 45
568:                 .Height    = 15
569:                 .FontName  = "Tahoma"
570:                 .FontSize  = 8
571:                 .ForeColor = RGB(90, 90, 90)
572:                 .BackStyle = 0
573:                 .Visible   = .T.
574:             ENDWITH
575: 
576:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
577:             WITH loc_oPagina.txt_4c_Codigo
578:                 .Value         = ""
579:                 .Top           = 123
580:                 .Left          = 349

*-- Linhas 628 a 711:
628:                 .Enabled       = .T.
629:                 .Visible       = .T.
630:             ENDWITH
631:             BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarVendedor")
632:             BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress",  THIS, "TeclaContaKeyPress")
633: 
634:             loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
635:             WITH loc_oPagina.txt_4c_DConta
636:                 .Value         = ""
637:                 .Top           = 151
638:                 .Left          = 431
639:                 .Width         = 290
640:                 .Height        = 24
641:                 .FontName      = "Tahoma"
642:                 .FontSize      = 8
643:                 .ForeColor     = RGB(90, 90, 90)
644:                 .BackColor     = RGB(255, 255, 255)
645:                 .BorderStyle   = 1
646:                 .SpecialEffect = 0
647:                 .ReadOnly      = .T.
648:                 .Enabled       = .F.
649:                 .Visible       = .T.
650:             ENDWITH
651: 
652:             *--------------------------------------------------------------
653:             * Label9 "Ordenacao :" + opt_4c_OptOrdem (4 opcoes)
654:             * Original: Label9.Top=150, OptOrdem.Top=145 -> Compensados: +29
655:             * Opcoes: Local / Nv.2 / Nv.3 / Nv.4  (muda ordem do GrdLoc)
656:             *--------------------------------------------------------------
657:             loc_oPagina.AddObject("lbl_4c_Label9", "Label")
658:             WITH loc_oPagina.lbl_4c_Label9
659:                 .Caption   = "Ordena" + CHR(231) + CHR(227) + "o :"
660:                 .Top       = 179
661:                 .Left      = 284
662:                 .Width     = 62
663:                 .Height    = 15
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .ForeColor = RGB(90, 90, 90)
667:                 .BackStyle = 0
668:                 .Visible   = .T.
669:             ENDWITH
670: 
671:             loc_oPagina.AddObject("opt_4c_OptOrdem", "OptionGroup")
672:             WITH loc_oPagina.opt_4c_OptOrdem
673:                 .ButtonCount = 4
674:                 .Top         = 174
675:                 .Left        = 346
676:                 .Width       = 355
677:                 .Height      = 25
678:                 .BackStyle   = 0
679:                 .BorderStyle = 0
680:                 .Value       = 1
681:                 .Visible     = .T.
682:             ENDWITH
683:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(1)
684:                 .Caption   = "Local"
685:                 .BackStyle = 0
686:                 .Left      = 5
687:                 .Top       = 3
688:                 .Width     = 60
689:                 .AutoSize  = .T.
690:                 .FontName  = "Tahoma"
691:                 .FontSize  = 8
692:                 .ForeColor = RGB(90, 90, 90)
693:                 .Themes    = .F.
694:             ENDWITH
695:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(2)
696:                 .Caption   = "Nv. 2"
697:                 .BackStyle = 0
698:                 .Left      = 90
699:                 .Top       = 3
700:                 .Width     = 60
701:                 .AutoSize  = .T.
702:                 .FontName  = "Tahoma"
703:                 .FontSize  = 8
704:                 .ForeColor = RGB(90, 90, 90)
705:                 .Themes    = .F.
706:             ENDWITH
707:             WITH loc_oPagina.opt_4c_OptOrdem.Buttons(3)
708:                 .Caption   = "Nv. 3"
709:                 .BackStyle = 0
710:                 .Left      = 180
711:                 .Top       = 3

*-- Linhas 728 a 771:
728:                 .ForeColor = RGB(90, 90, 90)
729:                 .Themes    = .F.
730:             ENDWITH
731:             BINDEVENT(loc_oPagina.opt_4c_OptOrdem, "InteractiveChange", THIS, "OptOrdemChanged")
732: 
733:             *--------------------------------------------------------------
734:             * Label1 "Local :" - cabecalho da area do GrdLoc
735:             * Original: Top=172 -> Compensado: Top=201
736:             *--------------------------------------------------------------
737:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
738:             WITH loc_oPagina.lbl_4c_Label1
739:                 .Caption   = "Local : "
740:                 .Top       = 201
741:                 .Left      = 310
742:                 .Width     = 36
743:                 .Height    = 15
744:                 .FontName  = "Tahoma"
745:                 .FontSize  = 8
746:                 .ForeColor = RGB(90, 90, 90)
747:                 .BackStyle = 0
748:                 .Visible   = .T.
749:             ENDWITH
750: 
751:             *--------------------------------------------------------------
752:             * GrdLoc - grid de itens (localizacoes + quantidades contadas)
753:             * Original: Top=169, Left=349, Width=263, Height=419 -> Top=198
754:             * Column1: Locals (readonly), Column2: QtdCtg (editavel), Column3: Qtde (readonly)
755:             *--------------------------------------------------------------
756:             loc_oPagina.AddObject("grd_4c_GrdLoc", "Grid")
757:             loc_oPagina.grd_4c_GrdLoc.RecordSource = ""
758:             loc_oPagina.grd_4c_GrdLoc.ColumnCount  = 3
759: 
760:             WITH loc_oPagina.grd_4c_GrdLoc
761:                 .Top                = 198
762:                 .Left               = 349
763:                 .Width              = 263
764:                 .Height             = 419
765:                 .FontName           = "Verdana"
766:                 .FontSize           = 8
767:                 .ForeColor          = RGB(90, 90, 90)
768:                 .BackColor          = RGB(255, 255, 255)
769:                 .GridLineColor      = RGB(238, 238, 238)
770:                 .HighlightBackColor = RGB(255, 255, 255)
771:                 .HighlightForeColor = RGB(15, 41, 104)

*-- Linhas 792 a 835:
792:                 .ReadOnly = .T.
793:                 .Header1.Caption = "Estoque"
794:             ENDWITH
795:             BINDEVENT(loc_oPagina.grd_4c_GrdLoc, "AfterRowColChange", THIS, "GrdLocAfterRowColChange")
796: 
797:             *--------------------------------------------------------------
798:             * Painel direito: codigos e descricoes de cada nivel de localizacao
799:             * Todos dentro da area do Shape1 (Top=198, Left=626, Width=364, Height=144)
800:             * Label7 "Base :" / Label6 "Segundo Nivel :" / Label5 "Terceiro Nivel :" / Label3 "Quarto Nivel :"
801:             *--------------------------------------------------------------
802: 
803:             *-- Label7 "Base :"  Original: Top=192 -> Compensado: Top=221
804:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
805:             WITH loc_oPagina.lbl_4c_Label7
806:                 .Caption   = "Base :"
807:                 .Top       = 221
808:                 .Left      = 707
809:                 .Width     = 32
810:                 .Height    = 15
811:                 .FontName  = "Tahoma"
812:                 .FontSize  = 8
813:                 .ForeColor = RGB(90, 90, 90)
814:                 .BackStyle = 0
815:                 .Visible   = .T.
816:             ENDWITH
817: 
818:             *-- txt_4c_Base (getBase) - somente leitura; preenchido por GrdLocAfterRowColChange
819:             loc_oPagina.AddObject("txt_4c_Base", "TextBox")
820:             WITH loc_oPagina.txt_4c_Base
821:                 .Value         = ""
822:                 .Top           = 216
823:                 .Left          = 743
824:                 .Width         = 54
825:                 .Height        = 24
826:                 .FontName      = "Tahoma"
827:                 .FontSize      = 8
828:                 .ForeColor     = RGB(90, 90, 90)
829:                 .BackColor     = RGB(255, 255, 255)
830:                 .BorderStyle   = 1
831:                 .SpecialEffect = 0
832:                 .ReadOnly      = .T.
833:                 .Enabled       = .F.
834:                 .Visible       = .T.
835:             ENDWITH

*-- Linhas 1012 a 1067:
1012:                 .Visible       = .T.
1013:             ENDWITH
1014: 
1015:             THIS.TornarControlesVisiveis(loc_oPagina)
1016: 
1017:         CATCH TO loc_oErro
1018:             MsgErro("Erro ao configurar P" + CHR(225) + "gina Dados:" + CHR(13) + ;
1019:                     loc_oErro.Message, "Erro")
1020:         ENDTRY
1021:     ENDPROC
1022: 
1023:     *==========================================================================
1024:     * CarregarLista - Carrega dados no Grid da Page1 e configura colunas
1025:     * Colunas: Cods, Datas, Vends, DesVends, Locals, DLocals, Conferido
1026:     *==========================================================================
1027:     PROCEDURE CarregarLista()
1028:         LOCAL loc_lResultado, loc_oErro, loc_oGrid, loc_cCursor
1029:         loc_lResultado = .F.
1030: 
1031:         TRY
1032:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1033:                 loc_lResultado = .T.
1034:             ELSE
1035:                 IF THIS.this_oBusinessObject.Buscar("")
1036:                     loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1037:                     loc_oGrid   = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1038: 
1039:                     loc_oGrid.RecordSource = loc_cCursor
1040:                     loc_oGrid.ColumnCount  = 7
1041: 
1042:                     loc_oGrid.Column1.ControlSource = loc_cCursor + ".cods"
1043:                     loc_oGrid.Column2.ControlSource = loc_cCursor + ".datas"
1044:                     loc_oGrid.Column3.ControlSource = loc_cCursor + ".vends"
1045:                     loc_oGrid.Column4.ControlSource = loc_cCursor + ".desvends"
1046:                     loc_oGrid.Column5.ControlSource = loc_cCursor + ".locals"
1047:                     loc_oGrid.Column6.ControlSource = loc_cCursor + ".dlocals"
1048:                     loc_oGrid.Column7.ControlSource = loc_cCursor + ".conferido"
1049: 
1050:                     loc_oGrid.Column1.Width = 80
1051:                     loc_oGrid.Column2.Width = 90
1052:                     loc_oGrid.Column3.Width = 70
1053:                     loc_oGrid.Column4.Width = 200
1054:                     loc_oGrid.Column5.Width = 80
1055:                     loc_oGrid.Column6.Width = 200
1056:                     loc_oGrid.Column7.Width = 60
1057: 
1058:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1059:                     loc_oGrid.Column2.Header1.Caption = "Data"
1060:                     loc_oGrid.Column3.Header1.Caption = "Vend"
1061:                     loc_oGrid.Column4.Header1.Caption = "Nome Vendedor"
1062:                     loc_oGrid.Column5.Header1.Caption = "Local"
1063:                     loc_oGrid.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Local"
1064:                     loc_oGrid.Column7.Header1.Caption = "Status"
1065: 
1066:                     THIS.FormatarGridLista(loc_oGrid)
1067:                     loc_lResultado = .T.

*-- Linhas 1080 a 1508:
1080:     *==========================================================================
1081:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1082:     *==========================================================================
1083:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1084:         LOCAL loc_lResultado, loc_oErro
1085:         loc_lResultado = .F.
1086: 
1087:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1088:             RETURN .F.
1089:         ENDIF
1090: 
1091:         TRY
1092:             IF par_nPagina = 1
1093:                 THIS.this_cModoAtual = "LISTA"
1094:             ENDIF
1095: 
1096:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1097: 
1098:             IF par_nPagina = 1
1099:                 THIS.CarregarLista()
1100:             ENDIF
1101: 
1102:             THIS.AjustarBotoesPorModo()
1103: 
1104:             loc_lResultado = .T.
1105: 
1106:         CATCH TO loc_oErro
1107:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
1108:                     loc_oErro.Message, "Erro")
1109:         ENDTRY
1110: 
1111:         RETURN loc_lResultado
1112:     ENDPROC
1113: 
1114:     *==========================================================================
1115:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1116:     * Itera Controls de containers E Pages de PageFrames
1117:     *==========================================================================
1118:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1119:         LOCAL loc_nI, loc_oObjeto, loc_nP
1120: 
1121:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1122:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1123: 
1124:             IF VARTYPE(loc_oObjeto) = "O"
1125:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1126:                     loc_oObjeto.Visible = .T.
1127:                 ENDIF
1128: 
1129:                 *-- PageFrame: iterar Pages
1130:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1131:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1132:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1133:                     ENDFOR
1134:                 ENDIF
1135: 
1136:                 *-- Container/Page: iterar controles filhos
1137:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1138:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1139:                 ENDIF
1140:             ENDIF
1141:         ENDFOR
1142:     ENDPROC
1143: 
1144:     *==========================================================================
1145:     * FormatarGridLista - Formata visual do grid da lista (fonte padrao)
1146:     *==========================================================================
1147:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1148:         WITH par_oGrid
1149:             .FontName = "Verdana"
1150:             .FontSize = 8
1151:         ENDWITH
1152:     ENDPROC
1153: 
1154:     *==========================================================================
1155:     * BtnIncluirClick - Inclui nova contagem
1156:     *==========================================================================
1157:     PROCEDURE BtnIncluirClick()
1158:         LOCAL loc_oErro, loc_oPg2
1159: 
1160:         TRY
1161:             THIS.this_oBusinessObject.NovoRegistro()
1162:             THIS.this_cModoAtual = "INCLUIR"
1163:             THIS.LimparCampos()
1164: 
1165:             *-- Criar cursor vazio para novo registro (colunas que SalvarItens espera)
1166:             IF USED("csSigCdCnI")
1167:                 USE IN csSigCdCnI
1168:             ENDIF
1169:             CREATE CURSOR csSigCdCnI (Locals C(10), QtdCtg N(5,0), Qtde N(10,2))
1170: 
1171:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1172:             IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1173:                 loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1174:                 loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1175:                 loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1176:                 loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1177:                 loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1178:                 loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.
1179:                 loc_oPg2.grd_4c_GrdLoc.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
1180:                 loc_oPg2.grd_4c_GrdLoc.Column2.Header1.Caption = "Qtde."
1181:                 loc_oPg2.grd_4c_GrdLoc.Column3.Header1.Caption = "Estoque"
1182:                 loc_oPg2.grd_4c_GrdLoc.Refresh()
1183:             ENDIF
1184: 
1185:             THIS.HabilitarCampos(.T.)
1186:             THIS.AlternarPagina(2)
1187:         CATCH TO loc_oErro
1188:             MsgErro("Erro ao incluir:" + CHR(13) + loc_oErro.Message, "Erro")
1189:         ENDTRY
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     * BtnVisualizarClick - Visualiza contagem selecionada (somente leitura)
1194:     *==========================================================================
1195:     PROCEDURE BtnVisualizarClick()
1196:         LOCAL loc_cCodigo, loc_oErro
1197:         loc_cCodigo = ""
1198: 
1199:         TRY
1200:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1201:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1202:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1203:                 loc_cCodigo = ALLTRIM(cods)
1204:             ENDIF
1205: 
1206:             IF EMPTY(loc_cCodigo)
1207:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1208:             ELSE
1209:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1210:                     THIS.this_cModoAtual = "VISUALIZAR"
1211:                     THIS.BOParaForm()
1212:                     THIS.HabilitarCampos(.F.)
1213:                     THIS.AlternarPagina(2)
1214:                 ENDIF
1215:             ENDIF
1216:         CATCH TO loc_oErro
1217:             MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, "Erro")
1218:         ENDTRY
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * BtnAlterarClick - Altera contagem selecionada
1223:     *==========================================================================
1224:     PROCEDURE BtnAlterarClick()
1225:         LOCAL loc_cCodigo, loc_oErro
1226:         loc_cCodigo = ""
1227: 
1228:         TRY
1229:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1230:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1231:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1232:                 loc_cCodigo = ALLTRIM(cods)
1233:             ENDIF
1234: 
1235:             IF EMPTY(loc_cCodigo)
1236:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1237:             ELSE
1238:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1239:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1240:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1241:                     ELSE
1242:                         THIS.this_oBusinessObject.EditarRegistro()
1243:                         THIS.this_cModoAtual = "ALTERAR"
1244:                         THIS.BOParaForm()
1245:                         THIS.HabilitarCampos(.T.)
1246:                         THIS.AlternarPagina(2)
1247:                     ENDIF
1248:                 ENDIF
1249:             ENDIF
1250:         CATCH TO loc_oErro
1251:             MsgErro("Erro ao alterar:" + CHR(13) + loc_oErro.Message, "Erro")
1252:         ENDTRY
1253:     ENDPROC
1254: 
1255:     *==========================================================================
1256:     * BtnExcluirClick - Exclui contagem selecionada
1257:     *==========================================================================
1258:     PROCEDURE BtnExcluirClick()
1259:         LOCAL loc_cCodigo, loc_oErro
1260:         loc_cCodigo = ""
1261: 
1262:         TRY
1263:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1264:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1265:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1266:                 loc_cCodigo = ALLTRIM(cods)
1267:             ENDIF
1268: 
1269:             IF EMPTY(loc_cCodigo)
1270:                 MsgAviso("Selecione uma contagem para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1271:             ELSE
1272:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1273:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1274:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada - n" + CHR(227) + "o pode excluir.", ;
1275:                                  "Aten" + CHR(231) + CHR(227) + "o")
1276:                     ELSE
1277:                         IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da contagem [" + ;
1278:                                        ALLTRIM(loc_cCodigo) + "] ?", "Exclus" + CHR(227) + "o")
1279:                             IF THIS.this_oBusinessObject.Excluir()
1280:                                 MsgSucesso("Contagem exclu" + CHR(237) + "da com sucesso!", "Sucesso")
1281:                                 THIS.CarregarLista()
1282:                             ENDIF
1283:                         ENDIF
1284:                     ENDIF
1285:                 ENDIF
1286:             ENDIF
1287:         CATCH TO loc_oErro
1288:             MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "Erro")
1289:         ENDTRY
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * BtnBuscarClick - Abre busca de contagens por codigo
1294:     *==========================================================================
1295:     PROCEDURE BtnBuscarClick()
1296:         LOCAL loc_oBusca, loc_cCodigo, loc_oErro
1297:         loc_cCodigo = ""
1298: 
1299:         TRY
1300:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1301:                 "sigcdcnl", "cursor_4c_BuscaCnl", "cods", "", ;
1302:                 "Buscar Contagem")
1303: 
1304:             IF VARTYPE(loc_oBusca) = "O"
1305:                 loc_oBusca.mAddColuna("cods",      "", "C" + CHR(243) + "digo")
1306:                 loc_oBusca.mAddColuna("conferido", "", "Status")
1307:                 loc_oBusca.Show()
1308: 
1309:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnl")
1310:                     SELECT cursor_4c_BuscaCnl
1311:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaCnl.cods)
1312:                 ENDIF
1313: 
1314:                 loc_oBusca.Release()
1315:             ENDIF
1316: 
1317:             IF USED("cursor_4c_BuscaCnl")
1318:                 USE IN cursor_4c_BuscaCnl
1319:             ENDIF
1320: 
1321:             IF !EMPTY(loc_cCodigo)
1322:                 THIS.CarregarLista()
1323:                 IF USED(THIS.this_oBusinessObject.this_cCursorDados)
1324:                     SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1325:                     LOCATE FOR ALLTRIM(cods) == loc_cCodigo
1326:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1327:                 ENDIF
1328:             ENDIF
1329: 
1330:         CATCH TO loc_oErro
1331:             IF USED("cursor_4c_BuscaCnl")
1332:                 USE IN cursor_4c_BuscaCnl
1333:             ENDIF
1334:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
1335:         ENDTRY
1336:     ENDPROC
1337: 
1338:     *==========================================================================
1339:     * BtnEncerrarClick - Fecha o formulario
1340:     *==========================================================================
1341:     PROCEDURE BtnEncerrarClick()
1342:         THIS.Release()
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * BtnEspelhoClick - Gera espelho do inventario por localizacao
1347:     * Replica logica de cmdEspelho.Click do legado
1348:     *==========================================================================
1349:     PROCEDURE BtnEspelhoClick()
1350:         LOCAL loc_cSQL, loc_oErro, loc_cEmpresa
1351:         loc_cEmpresa = go_4c_Sistema.cCodEmpresa
1352: 
1353:         TRY
1354:             IF USED("cursor_4c_Espelho")
1355:                 USE IN cursor_4c_Espelho
1356:             ENDIF
1357: 
1358:             loc_cSQL = "SELECT localizas AS Locals, grupos, contas, empos," + ;
1359:                        " SUM(Qtde) AS qtde, CONVERT(numeric(5,0),0) AS QtdCtg," + ;
1360:                        " SPACE(100) AS Descr" + ;
1361:                        " FROM (" + ;
1362:                        " SELECT localizas, SPACE(10) AS grupos, SPACE(10) AS contas, a.empos," + ;
1363:                        " COUNT(1) AS Qtde" + ;
1364:                        " FROM SigOpEtq A" + ;
1365:                        " LEFT JOIN (SELECT Cpros, Cgrus, Mercs, Colecoes, SGrus" + ;
1366:                        " FROM SigCdPro) B ON b.cpros = a.cpros" + ;
1367:                        " WHERE a.empos = " + EscaparSQL(loc_cEmpresa) + ;
1368:                        " AND a.contas NOT IN ('15000','15001','15002','15003')" + ;
1369:                        " GROUP BY localizas, a.empos" + ;
1370:                        " ) AS dados" + ;
1371:                        " GROUP BY localizas, grupos, contas, empos" + ;
1372:                        " ORDER BY localizas"
1373: 
1374:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Espelho") > 0
1375:                 MsgInfo("Espelho gerado com " + LTRIM(STR(RECCOUNT("cursor_4c_Espelho"))) + ;
1376:                         " localiza" + CHR(231) + CHR(245) + "es.", "Espelho")
1377:             ELSE
1378:                 MsgErro("Erro ao gerar espelho: " + CapturarErroSQL(), "Erro SQL")
1379:             ENDIF
1380: 
1381:         CATCH TO loc_oErro
1382:             MsgErro("Erro ao gerar espelho:" + CHR(13) + loc_oErro.Message, "Erro")
1383:         ENDTRY
1384: 
1385:         IF USED("cursor_4c_Espelho")
1386:             USE IN cursor_4c_Espelho
1387:         ENDIF
1388:     ENDPROC
1389: 
1390:     *==========================================================================
1391:     * BtnFecharContagemClick - Encerra contagem selecionada (Fecha no legado)
1392:     * Legado: Conferido=1 -> Update -> Commit
1393:     *==========================================================================
1394:     PROCEDURE BtnFecharContagemClick()
1395:         LOCAL loc_cCodigo, loc_oErro
1396:         loc_cCodigo = ""
1397: 
1398:         TRY
1399:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1400:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1401:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1402:                 loc_cCodigo = ALLTRIM(cods)
1403:             ENDIF
1404: 
1405:             IF EMPTY(loc_cCodigo)
1406:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1407:             ELSE
1408:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1409:                     IF THIS.this_oBusinessObject.this_nConferido = 1
1410:                         MsgAviso("Contagem J" + CHR(225) + " Encerrada !!!", "Aten" + CHR(231) + CHR(227) + "o")
1411:                     ELSE
1412:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Finalizada," + ;
1413:                                        " Deseja encerrar a Contagem ???", ;
1414:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1415:                             IF THIS.this_oBusinessObject.FecharContagem(loc_cCodigo)
1416:                                 THIS.CarregarLista()
1417:                             ENDIF
1418:                         ENDIF
1419:                     ENDIF
1420:                 ENDIF
1421:             ENDIF
1422:         CATCH TO loc_oErro
1423:             MsgErro("Erro ao fechar contagem:" + CHR(13) + loc_oErro.Message, "Erro")
1424:         ENDTRY
1425:     ENDPROC
1426: 
1427:     *==========================================================================
1428:     * BtnAbrirContagemClick - Reabre contagem encerrada (Abre no legado)
1429:     * Legado: Conferido=0 -> Update -> Commit
1430:     *==========================================================================
1431:     PROCEDURE BtnAbrirContagemClick()
1432:         LOCAL loc_cCodigo, loc_oErro
1433:         loc_cCodigo = ""
1434: 
1435:         TRY
1436:             IF USED(THIS.this_oBusinessObject.this_cCursorDados) AND ;
1437:                !EOF(THIS.this_oBusinessObject.this_cCursorDados)
1438:                 SELECT (THIS.this_oBusinessObject.this_cCursorDados)
1439:                 loc_cCodigo = ALLTRIM(cods)
1440:             ENDIF
1441: 
1442:             IF EMPTY(loc_cCodigo)
1443:                 MsgAviso("Selecione uma contagem na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1444:             ELSE
1445:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1446:                     IF THIS.this_oBusinessObject.this_nConferido = 0
1447:                         MsgAviso("Contagem N" + CHR(227) + "o est" + CHR(225) + " Encerrada !!!", ;
1448:                                  "Aten" + CHR(231) + CHR(227) + "o")
1449:                     ELSE
1450:                         IF MsgConfirma("Este Contagem ser" + CHR(225) + " Aberta Novamente," + ;
1451:                                        " Deseja Continuar a Contagem ???", ;
1452:                                        "ATEN" + CHR(199) + CHR(195) + "O !!!")
1453:                             IF THIS.this_oBusinessObject.ReobrirContagem(loc_cCodigo)
1454:                                 THIS.CarregarLista()
1455:                             ENDIF
1456:                         ENDIF
1457:                     ENDIF
1458:                 ENDIF
1459:             ENDIF
1460:         CATCH TO loc_oErro
1461:             MsgErro("Erro ao reabrir contagem:" + CHR(13) + loc_oErro.Message, "Erro")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *==========================================================================
1466:     * BOParaForm - Transfere propriedades do BO para os campos do formulario
1467:     *==========================================================================
1468:     PROTECTED PROCEDURE BOParaForm()
1469:         LOCAL loc_oErro, loc_oPg2
1470: 
1471:         TRY
1472:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1473: 
1474:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1475:                 loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1476:             ENDIF
1477:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1478:                 loc_oPg2.txt_4c_Conta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cVends)
1479:             ENDIF
1480:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1481:                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesVends)
1482:             ENDIF
1483: 
1484:             *-- Resetar ordenacao ao carregar registro
1485:             IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
1486:                 loc_oPg2.opt_4c_OptOrdem.Value = 1
1487:             ENDIF
1488: 
1489:             *-- Carregar itens (csSigCdCnI) via SQL com aliasing correto para SalvarItens
1490:             IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cCodigo))
1491:                 LOCAL loc_cSQLItens
1492:                 loc_cSQLItens = "SELECT locals AS Locals, qtds AS QtdCtg, estoque AS Qtde" + ;
1493:                                 " FROM sigcdcni WHERE cods = " + ;
1494:                                 EscaparSQL(THIS.this_oBusinessObject.this_cCodigo) + ;
1495:                                 " ORDER BY locals"
1496:                 IF USED("csSigCdCnI")
1497:                     USE IN csSigCdCnI
1498:                 ENDIF
1499:                 IF SQLEXEC(gnConnHandle, loc_cSQLItens, "csSigCdCnI") > 0
1500:                     SELECT csSigCdCnI
1501:                     GO TOP
1502:                     IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1503:                         loc_oPg2.grd_4c_GrdLoc.RecordSource = "csSigCdCnI"
1504:                         loc_oPg2.grd_4c_GrdLoc.Column1.Width = 80
1505:                         loc_oPg2.grd_4c_GrdLoc.Column2.Width = 60
1506:                         loc_oPg2.grd_4c_GrdLoc.Column3.Width = 60
1507:                         loc_oPg2.grd_4c_GrdLoc.Column1.ReadOnly = .T.
1508:                         loc_oPg2.grd_4c_GrdLoc.Column3.ReadOnly = .T.

*-- Linhas 1522 a 1631:
1522:     *==========================================================================
1523:     * FormParaBO - Transfere valores dos campos do formulario para o BO
1524:     *==========================================================================
1525:     PROTECTED PROCEDURE FormParaBO()
1526:         LOCAL loc_oErro, loc_oPg2
1527: 
1528:         TRY
1529:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1530: 
1531:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1532:                 THIS.this_oBusinessObject.this_cVends = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1533:             ENDIF
1534:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1535:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(loc_oPg2.txt_4c_DConta.Value)
1536:             ENDIF
1537: 
1538:         CATCH TO loc_oErro
1539:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1540:         ENDTRY
1541:     ENDPROC
1542: 
1543:     *==========================================================================
1544:     * HabilitarCampos - Habilita/desabilita campos editaveis por modo
1545:     * getCods  : sempre somente leitura (codigo gerado automaticamente)
1546:     * getConta : habilitado apenas em INCLUIR (When legado: INSERIR ou CONSULTAR)
1547:     * getDConta: sempre somente leitura (descricao preenchida pelo lookup)
1548:     * OptOrdem : habilitado em INCLUIR e ALTERAR
1549:     *==========================================================================
1550:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1551:         LOCAL loc_oErro, loc_oPg2, loc_lModoIncluir, loc_lModoEdicao
1552: 
1553:         TRY
1554:             loc_oPg2        = THIS.pgf_4c_Paginas.Page2
1555:             loc_lModoIncluir = (THIS.this_cModoAtual = "INCLUIR")
1556:             loc_lModoEdicao  = (THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR")
1557: 
1558:             *-- Codigo: sempre desabilitado (gerado pelo sistema)
1559:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1560:                 loc_oPg2.txt_4c_Codigo.Enabled = .F.
1561:             ENDIF
1562: 
1563:             *-- Vendedor: apenas em INCLUIR (conforme When legado)
1564:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1565:                 loc_oPg2.txt_4c_Conta.Enabled = (par_lHabilitar AND loc_lModoIncluir)
1566:             ENDIF
1567: 
1568:             *-- Descricao vendedor: sempre somente leitura
1569:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1570:                 loc_oPg2.txt_4c_DConta.Enabled = .F.
1571:             ENDIF
1572: 
1573:             *-- Ordenacao: habilitada em edicao quando ha itens carregados
1574:             IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
1575:                 loc_oPg2.opt_4c_OptOrdem.Enabled = (par_lHabilitar AND loc_lModoEdicao)
1576:             ENDIF
1577: 
1578:             *-- Grid de localizacoes: coluna Qtde. editavel apenas em INCLUIR/ALTERAR
1579:             IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1580:                 loc_oPg2.grd_4c_GrdLoc.Column2.ReadOnly = !(par_lHabilitar AND loc_lModoEdicao)
1581:             ENDIF
1582: 
1583:         CATCH TO loc_oErro
1584:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1585:         ENDTRY
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     * LimparCampos - Limpa valores dos campos do formulario
1590:     *==========================================================================
1591:     PROTECTED PROCEDURE LimparCampos()
1592:         LOCAL loc_oErro, loc_oPg2
1593: 
1594:         TRY
1595:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1596: 
1597:             IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
1598:                 loc_oPg2.txt_4c_Codigo.Value = ""
1599:             ENDIF
1600:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1601:                 loc_oPg2.txt_4c_Conta.Value = ""
1602:             ENDIF
1603:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1604:                 loc_oPg2.txt_4c_DConta.Value = ""
1605:             ENDIF
1606:             IF PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
1607:                 loc_oPg2.opt_4c_OptOrdem.Value = 1
1608:             ENDIF
1609: 
1610:             *-- Campos de nivel de localizacao (painel direito)
1611:             IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
1612:                 loc_oPg2.txt_4c_Base.Value = ""
1613:             ENDIF
1614:             IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
1615:                 loc_oPg2.txt_4c_DBase.Value = ""
1616:             ENDIF
1617:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
1618:                 loc_oPg2.txt_4c_Nvl2.Value = ""
1619:             ENDIF
1620:             IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
1621:                 loc_oPg2.txt_4c_DNvl2.Value = ""
1622:             ENDIF
1623:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)
1624:                 loc_oPg2.txt_4c_Nvl3.Value = ""
1625:             ENDIF
1626:             IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl3", 5)
1627:                 loc_oPg2.txt_4c_DNvl3.Value = ""
1628:             ENDIF
1629:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl4", 5)
1630:                 loc_oPg2.txt_4c_Nvl4.Value = ""
1631:             ENDIF

*-- Linhas 1642 a 1879:
1642:     * BtnSalvarClick - Salva a contagem (Confirmar)
1643:     * Valida campos obrigatorios fora do TRY conforme regra critica
1644:     *==========================================================================
1645:     PROCEDURE BtnSalvarClick()
1646:         LOCAL loc_oErro, loc_oPg2, loc_cVend
1647: 
1648:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1649:         loc_cVend = ""
1650: 
1651:         IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1652:             loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1653:         ENDIF
1654: 
1655:         IF EMPTY(loc_cVend)
1656:             MsgAviso("Vendedor obrigat" + CHR(243) + "rio!", ;
1657:                      "Valida" + CHR(231) + CHR(227) + "o")
1658:             IF PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1659:                 loc_oPg2.txt_4c_Conta.SetFocus()
1660:             ENDIF
1661:             RETURN
1662:         ENDIF
1663: 
1664:         TRY
1665:             THIS.FormParaBO()
1666:             IF THIS.this_oBusinessObject.Salvar()
1667:                 *-- Salvar itens de localizacao (csSigCdCnI) apos cabecalho
1668:                 IF USED("csSigCdCnI")
1669:                     THIS.this_oBusinessObject.SalvarItens("csSigCdCnI", ;
1670:                         THIS.this_oBusinessObject.this_cCodigo)
1671:                 ENDIF
1672:                 MsgSucesso("Contagem salva com sucesso!", "Sucesso")
1673:                 THIS.this_cModoAtual = "LISTA"
1674:                 THIS.AlternarPagina(1)
1675:                 THIS.CarregarLista()
1676:             ENDIF
1677:         CATCH TO loc_oErro
1678:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1679:         ENDTRY
1680:     ENDPROC
1681: 
1682:     *==========================================================================
1683:     * BtnCancelarClick - Cancela edicao e volta para lista
1684:     *==========================================================================
1685:     PROCEDURE BtnCancelarClick()
1686:         LOCAL loc_oErro
1687: 
1688:         TRY
1689:             IF USED("csSigCdCnI")
1690:                 USE IN csSigCdCnI
1691:             ENDIF
1692:             THIS.this_cModoAtual = "LISTA"
1693:             THIS.AlternarPagina(1)
1694:             THIS.CarregarLista()
1695:         CATCH TO loc_oErro
1696:             MsgErro("Erro ao cancelar:" + CHR(13) + loc_oErro.Message, "Erro")
1697:         ENDTRY
1698:     ENDPROC
1699: 
1700:     *==========================================================================
1701:     * OptOrdemChanged - Muda ordenacao do GrdLoc ao trocar opcao no OptionGroup
1702:     * Replica OptOrdem.Valid do legado: SET ORDER TO {Locals/Nivel2s/Nivel3s/Nivel4s}
1703:     *==========================================================================
1704:     PROCEDURE OptOrdemChanged()
1705:         LOCAL loc_oErro, loc_nOrdem, loc_oPg2
1706: 
1707:         TRY
1708:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1709: 
1710:             IF !PEMSTATUS(loc_oPg2, "opt_4c_OptOrdem", 5)
1711:                 RETURN
1712:             ENDIF
1713: 
1714:             loc_nOrdem = loc_oPg2.opt_4c_OptOrdem.Value
1715: 
1716:             IF USED("csSigCdCnI")
1717:                 SELECT csSigCdCnI
1718:                 SET ORDER TO
1719:                 DO CASE
1720:                 CASE loc_nOrdem = 1
1721:                     SET ORDER TO Locals
1722:                 CASE loc_nOrdem = 2
1723:                     SET ORDER TO Nivel2s
1724:                 CASE loc_nOrdem = 3
1725:                     SET ORDER TO Nivel3s
1726:                 CASE loc_nOrdem = 4
1727:                     SET ORDER TO Nivel4s
1728:                 ENDCASE
1729:                 GO TOP IN csSigCdCnI
1730: 
1731:                 *-- Atualizar grid de itens (adicionado na Fase 6)
1732:                 IF PEMSTATUS(loc_oPg2, "grd_4c_GrdLoc", 5)
1733:                     loc_oPg2.grd_4c_GrdLoc.Refresh()
1734:                 ENDIF
1735:             ENDIF
1736: 
1737:         CATCH TO loc_oErro
1738:             MsgErro("Erro ao ordenar itens:" + CHR(13) + loc_oErro.Message, "Erro")
1739:         ENDTRY
1740:     ENDPROC
1741: 
1742:     *==========================================================================
1743:     * ValidarVendedor - Valida campo getConta (Vendedor) via SQL + lookup
1744:     * Replica getConta.Valid do legado (busca em SigCdCli)
1745:     * Preenche txt_4c_DConta com nome do vendedor encontrado
1746:     *==========================================================================
1747:     PROCEDURE ValidarVendedor(par_nKeyCode, par_nShiftAltCtrl)
1748:         LOCAL loc_oErro, loc_oPg2, loc_cVend, loc_cSQL, loc_oBusca
1749:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1750: 
1751:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Conta", 5)
1752:             RETURN
1753:         ENDIF
1754: 
1755:         loc_cVend = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1756: 
1757:         IF EMPTY(loc_cVend)
1758:             IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1759:                 loc_oPg2.txt_4c_DConta.Value = ""
1760:             ENDIF
1761:             RETURN
1762:         ENDIF
1763: 
1764:         TRY
1765:             loc_cSQL = "SELECT a.iclis, a.rclis, a.Emps" + ;
1766:                        " FROM SigCdCli a" + ;
1767:                        " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
1768:                        " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
1769:                        " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1770:                        " AND a.iclis = " + EscaparSQL(loc_cVend)
1771: 
1772:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidVend") > 0 AND ;
1773:                RECCOUNT("cursor_4c_ValidVend") > 0
1774:                 SELECT cursor_4c_ValidVend
1775:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1776:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ValidVend.rclis)
1777:                 ENDIF
1778:                 THIS.this_oBusinessObject.this_cVends    = loc_cVend
1779:                 THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_ValidVend.rclis)
1780:             ELSE
1781:                 *-- Nao encontrado: abrir FormBuscaAuxiliar para selecao
1782:                 IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1783:                     loc_oPg2.txt_4c_DConta.Value = ""
1784:                 ENDIF
1785: 
1786:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1787:                     "SigCdCli", "cursor_4c_BuscaVend", "iclis", loc_cVend, ;
1788:                     "Vendedor")
1789: 
1790:                 IF VARTYPE(loc_oBusca) = "O"
1791:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1792:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1793:                     loc_oBusca.Show()
1794: 
1795:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVend")
1796:                         SELECT cursor_4c_BuscaVend
1797:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaVend.iclis)
1798:                         IF PEMSTATUS(loc_oPg2, "txt_4c_DConta", 5)
1799:                             loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaVend.rclis)
1800:                         ENDIF
1801:                         THIS.this_oBusinessObject.this_cVends    = ALLTRIM(cursor_4c_BuscaVend.iclis)
1802:                         THIS.this_oBusinessObject.this_cDesVends = ALLTRIM(cursor_4c_BuscaVend.rclis)
1803:                     ELSE
1804:                         loc_oPg2.txt_4c_Conta.Value = ""
1805:                     ENDIF
1806:                     loc_oBusca.Release()
1807:                 ENDIF
1808: 
1809:                 IF USED("cursor_4c_BuscaVend")
1810:                     USE IN cursor_4c_BuscaVend
1811:                 ENDIF
1812:             ENDIF
1813: 
1814:             IF USED("cursor_4c_ValidVend")
1815:                 USE IN cursor_4c_ValidVend
1816:             ENDIF
1817: 
1818:         CATCH TO loc_oErro
1819:             IF USED("cursor_4c_ValidVend")
1820:                 USE IN cursor_4c_ValidVend
1821:             ENDIF
1822:             MsgErro("Erro ao validar vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
1823:         ENDTRY
1824:     ENDPROC
1825: 
1826:     *==========================================================================
1827:     * TeclaContaKeyPress - Intercepta F4 em txt_4c_Conta para abrir lookup
1828:     *==========================================================================
1829:     PROCEDURE TeclaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1830:         IF par_nKeyCode = 115
1831:             THIS.ValidarVendedor()
1832:         ENDIF
1833:     ENDPROC
1834: 
1835:     *==========================================================================
1836:     * GrdLocAfterRowColChange - Atualiza painel de niveis ao navegar no GrdLoc
1837:     * Parseia Locals (10 chars) em 4 niveis: Base(1,2) Nvl2(3,2) Nvl3(5,2) Nvl4(7,3)
1838:     *==========================================================================
1839:     PROCEDURE GrdLocAfterRowColChange(par_nColIndex)
1840:         LOCAL loc_oErro, loc_oPg2, loc_cLocal, loc_cBase, loc_cNvl2, loc_cNvl3, loc_cNvl4
1841: 
1842:         TRY
1843:             IF !USED("csSigCdCnI") OR EOF("csSigCdCnI")
1844:                 RETURN
1845:             ENDIF
1846: 
1847:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1848:             loc_cLocal = ALLTRIM(csSigCdCnI.Locals)
1849:             loc_cBase  = ""
1850:             loc_cNvl2  = ""
1851:             loc_cNvl3  = ""
1852:             loc_cNvl4  = ""
1853: 
1854:             IF LEN(loc_cLocal) >= 2
1855:                 loc_cBase = SUBSTR(loc_cLocal, 1, 2)
1856:             ENDIF
1857:             IF LEN(loc_cLocal) >= 4
1858:                 loc_cNvl2 = SUBSTR(loc_cLocal, 3, 2)
1859:             ENDIF
1860:             IF LEN(loc_cLocal) >= 6
1861:                 loc_cNvl3 = SUBSTR(loc_cLocal, 5, 2)
1862:             ENDIF
1863:             IF LEN(loc_cLocal) >= 9
1864:                 loc_cNvl4 = SUBSTR(loc_cLocal, 7, 3)
1865:             ENDIF
1866: 
1867:             IF PEMSTATUS(loc_oPg2, "txt_4c_Base", 5)
1868:                 loc_oPg2.txt_4c_Base.Value = loc_cBase
1869:             ENDIF
1870:             IF PEMSTATUS(loc_oPg2, "txt_4c_DBase", 5)
1871:                 loc_oPg2.txt_4c_DBase.Value = ""
1872:             ENDIF
1873:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl2", 5)
1874:                 loc_oPg2.txt_4c_Nvl2.Value = loc_cNvl2
1875:             ENDIF
1876:             IF PEMSTATUS(loc_oPg2, "txt_4c_DNvl2", 5)
1877:                 loc_oPg2.txt_4c_DNvl2.Value = ""
1878:             ENDIF
1879:             IF PEMSTATUS(loc_oPg2, "txt_4c_Nvl3", 5)

*-- Linhas 1899 a 1966:
1899:     * LISTA: todos os botoes habilitados
1900:     * INCLUIR/ALTERAR/VISUALIZAR: botoes CRUD desabilitados (usuario esta em Page2)
1901:     *==========================================================================
1902:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1903:         LOCAL loc_oErro, loc_oPg1, loc_lEmLista
1904: 
1905:         TRY
1906:             loc_oPg1    = THIS.pgf_4c_Paginas.Page1
1907:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
1908: 
1909:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1910:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1911:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled   = loc_lEmLista
1912:                 ENDIF
1913:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
1914:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1915:                 ENDIF
1916:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
1917:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled   = loc_lEmLista
1918:                 ENDIF
1919:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1920:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled   = loc_lEmLista
1921:                 ENDIF
1922:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
1923:                     loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled    = loc_lEmLista
1924:                 ENDIF
1925:             ENDIF
1926: 
1927:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Espelho", 5)
1928:                 loc_oPg1.cmd_4c_Espelho.Enabled = loc_lEmLista
1929:             ENDIF
1930:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Fechar", 5)
1931:                 loc_oPg1.cmd_4c_Fechar.Enabled  = loc_lEmLista
1932:             ENDIF
1933:             IF PEMSTATUS(loc_oPg1, "cmd_4c_Abrir", 5)
1934:                 loc_oPg1.cmd_4c_Abrir.Enabled   = loc_lEmLista
1935:             ENDIF
1936: 
1937:         CATCH TO loc_oErro
1938:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1939:         ENDTRY
1940:     ENDPROC
1941: 
1942:     *==========================================================================
1943:     * Destroy - Libera recursos ao fechar o formulario
1944:     *==========================================================================
1945:     PROCEDURE Destroy()
1946:         LOCAL loc_oErro
1947: 
1948:         TRY
1949:             IF USED("csSigCdCnI")
1950:                 USE IN csSigCdCnI
1951:             ENDIF
1952: 
1953:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1954:                 THIS.this_oBusinessObject = .NULL.
1955:             ENDIF
1956: 
1957:             DODEFAULT()
1958: 
1959:         CATCH TO loc_oErro
1960:             MsgErro("Erro ao fechar formul" + CHR(225) + "rio:" + CHR(13) + ;
1961:                     loc_oErro.Message, "Erro")
1962:             DODEFAULT()
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966: ENDDEFINE


### BO (C:\4c\projeto\app\classes\cnlBO.prg):
*===========================================================================
* cnlBO.prg - Business Object para Contagem de Produtos por Localizacao
* Tabela principal: SigCdCnL (cabecalho da contagem)
* Tabela detalhe  : SigCdCnI (itens / localizacoes)
* Criado em: 2026-07-29
*===========================================================================

DEFINE CLASS cnlBO AS BusinessBase

    *-- Identificacao da tabela principal
    this_cTabela     = "SigCdCnL"
    this_cCampoChave = "Cods"

    *--------------------------------------------------------------------------
    * Propriedades de SigCdCnL (schema: sigcdcnl)
    *--------------------------------------------------------------------------

    *-- Chave de negocio (cods char 10) - usada em WHERE das operacoes
    this_cCodigo     = ""

    *-- Chave tecnica interna (cidchaves char 20) - PK fisica
    this_cCidChaves  = ""

    *-- Empresa (emps char 3)
    this_cEmps       = ""

    *-- Vendedor responsavel (vends char 10 - FK SigCdCli.Iclis)
    this_cVends      = ""

    *-- Localizacao principal (locals char 10 - FK SigPrLcl.codigos)
    this_cLocals     = ""

    *-- Data da contagem (datas datetime)
    this_dDatas      = {}

    *-- Ordenacao do grid (qtds numeric 5,0): 0/1=Base, 2=Nvl2, 3=Nvl3, 4=Nvl4
    this_nQtds       = 0

    *-- Status (conferido numeric 1,0): 0=aberta, 1=encerrada
    this_nConferido  = 0

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (resultado de JOINs na query Buscar)
    *--------------------------------------------------------------------------

    *-- Descricao do vendedor (alias desvends = SigCdCli.Rclis)
    this_cDesVends   = ""

    *-- Descricao da localizacao (alias dlocals = SigPrLcl.descricaos)
    this_cDLocals    = ""

    *--------------------------------------------------------------------------
    * Nomes dos cursores de trabalho
    *--------------------------------------------------------------------------

    *-- Cursor de itens criado pelo form (csSigCdCnI)
    this_cCursorItens = "csSigCdCnI"

    *-- Cursor principal da lista (Buscar)
    this_cCursorDados = "cursor_4c_Dados"

    *==========================================================================
    * Init - Inicializa tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCnL"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * Buscar - Carrega lista de contagens com JOINs
    * par_cFiltro: condicao SQL adicional (opcional)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.datas DESC, a.cods"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados) > 0
                SELECT (THIS.this_cCursorDados)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de contagens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro de SigCdCnL pelo Cods
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cods, a.conferido, a.datas," + ;
                       " a.locals, a.qtds, a.vends, a.emps," + ;
                       " b.rclis AS desvends," + ;
                       " ISNULL(c.descricaos, '') AS dlocals" + ;
                       " FROM sigcdcnl a" + ;
                       " JOIN sigcdcli b ON a.vends = b.iclis" + ;
                       " LEFT JOIN SigPrLcl c ON a.locals = c.codigos" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND a.emps = " + EscaparSQL(loc_cEmpresa)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                MsgErro("Erro ao carregar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor posicionado
    * REGRA: SEMPRE SELECT (alias) antes de acessar campos
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCodigo     = TratarNulo(cods,       "C")
            THIS.this_nConferido  = TratarNulo(conferido,  "N")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cLocals     = TratarNulo(locals,     "C")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")
            THIS.this_cVends      = TratarNulo(vends,      "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cDesVends   = TratarNulo(desvends,   "C")
            THIS.this_cDLocals    = TratarNulo(dlocals,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigCdCnL (chamado por BusinessBase.Salvar)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_cCodigo
        loc_lSucesso = .F.

        TRY
            loc_cCidChaves = THIS.ObterNovoCidChaves()
            IF !EMPTY(loc_cCidChaves)
                loc_cCodigo = THIS.ObterProximoCodigo()
                IF !EMPTY(loc_cCodigo)
                    THIS.this_cCidChaves = loc_cCidChaves
                    THIS.this_cCodigo    = loc_cCodigo
                    THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa
                    THIS.this_nConferido = 0

                    loc_cSQL = "INSERT INTO sigcdcnl" + ;
                               " (cidchaves, cods, conferido, datas, locals, qtds, vends, emps)" + ;
                               " VALUES (" + ;
                               EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                               EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                               FormatarNumeroSQL(THIS.this_nConferido) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(THIS.this_cLocals) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                               EscaparSQL(THIS.this_cVends) + ", " + ;
                               EscaparSQL(THIS.this_cEmps)  + ;
                               ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir contagem: " + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo da contagem.", "Erro")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar chave interna da contagem.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigCdCnL (vends, locals, qtds)
    * O legado fazia delete+reinsert via cursor; aqui usamos UPDATE direto.
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET" + ;
                       " vends  = " + EscaparSQL(THIS.this_cVends)  + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " qtds   = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " datas  = GETDATE()" + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de SigCdCnI (itens) + SigCdCnL (cabecalho)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(THIS.this_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM sigcdcnl" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCodigo) + ;
                           " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir contagem: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * SalvarItens - Salva itens do cursor csSigCdCnI em SigCdCnI
    * par_cCursorItens: nome do cursor com colunas Locals, QtdCtg, Qtde
    * par_cCodigo: Cods do cabecalho (SigCdCnL.cods)
    * Mapeamento: sigcdcni.qtds <- csSigCdCnI.QtdCtg (contagem)
    *             sigcdcni.estoque <- csSigCdCnI.Qtde (estoque)
    *==========================================================================
    FUNCTION SalvarItens(par_cCursorItens, par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCidChaves, loc_nResultado
        LOCAL loc_cLocals, loc_nQtdCtg, loc_nQtde
        loc_lSucesso = .F.

        IF !USED(par_cCursorItens)
            MsgErro("Cursor de itens n" + CHR(227) + "o encontrado: " + par_cCursorItens, "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Limpar itens existentes para este codigo
            loc_cSQL = "DELETE FROM sigcdcni WHERE cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                *-- Inserir itens do cursor
                SELECT (par_cCursorItens)
                GO TOP
                loc_lSucesso = .T.

                SCAN WHILE loc_lSucesso
                    *-- Capturar campos ANTES de chamar ObterNovoCidChaves (muda SELECT)
                    loc_cLocals  = ALLTRIM(locals)
                    loc_nQtdCtg  = qtdctg
                    loc_nQtde    = qtde

                    loc_cCidChaves = THIS.ObterNovoCidChaves()
                    IF EMPTY(loc_cCidChaves)
                        loc_lSucesso = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO sigcdcni" + ;
                                   " (cidchaves, cods, locals, qtds, estoque, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCodigo)    + ", " + ;
                                   EscaparSQL(loc_cLocals)    + ", " + ;
                                   FormatarNumeroSQL(loc_nQtdCtg) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtde)   + ", " + ;
                                   EscaparSQL("") + ;
                                   ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir item [" + loc_cLocals + "]: " + ;
                                    CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF

                    *-- Restaurar selecao para proxima iteracao do SCAN
                    SELECT (par_cCursorItens)
                ENDSCAN
            ELSE
                MsgErro("Erro ao limpar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em SalvarItens: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarItens - Carrega itens de SigCdCnI para um cursor
    * par_cCodigo: Cods do cabecalho
    * par_cCursorDestino: nome do cursor destino (default: crSigCdCnI)
    *==========================================================================
    FUNCTION CarregarItens(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "crSigCdCnI", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, cods, locals, qtds, estoque, mercs" + ;
                       " FROM sigcdcni" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY locals"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarItens: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FecharContagem - Define Conferido=1 (encerra a contagem)
    *==========================================================================
    FUNCTION FecharContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 1" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao fechar contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FecharContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ReobrirContagem - Define Conferido=0 (reabre a contagem encerrada)
    *==========================================================================
    FUNCTION ReobrirContagem(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdcnl SET conferido = 0" + ;
                       " WHERE cods = " + EscaparSQL(par_cCodigo) + ;
                       " AND emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao reabrir contagem: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ReobrirContagem: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarParametrosVendedor - Carrega SigCdPam para obter GrPadVens
    * Replica CursorQuery([SigCdPam], [LocalPam], ...)
    * par_cCursorDestino: nome do cursor destino (default: cursor_4c_LocalPam)
    *==========================================================================
    FUNCTION CarregarParametrosVendedor(par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_LocalPam", par_cCursorDestino)

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT GrPadVens FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                IF !EOF()
                    loc_lSucesso = !EMPTY(ALLTRIM(GrPadVens))
                ENDIF
            ELSE
                MsgErro("Erro ao carregar par" + CHR(226) + "metros de vendedor: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarParametrosVendedor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarVendedores - Carrega vendedores validos para lookup
    * Replica a query dos eventos Valid de getConta/getDConta
    * par_cFiltro    : usuario logado ou valor digitado no campo
    * par_cGrPadVens : grupo padrao de vendedores (de SigCdPam)
    * par_cCursorDestino: cursor de resultado (default: cursor_4c_Vendedores)
    *==========================================================================
    FUNCTION BuscarVendedores(par_cFiltro, par_cGrPadVens, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cCursor, loc_cEmpresa
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "cursor_4c_Vendedores", par_cCursorDestino)
        loc_cEmpresa = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT a.iclis, a.rclis, a.grupos, a.situas, a.Cpfs," + ;
                       " a.inativas, a.ContaMats, a.Emps" + ;
                       " FROM SigCdCli a" + ;
                       " INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos" + ;
                       " INNER JOIN SigCdAce c ON a.Iclis = c.Usuarios" + ;
                       " WHERE (NOT b.Coletors = 10 OR (b.Coletors = 10" + ;
                       " AND a.IClis NOT IN" + ;
                       " (SELECT DISTINCT c.Jobs FROM SigCdAcJ c" + ;
                       " WHERE c.Jobs NOT IN" + ;
                       " (SELECT DISTINCT d.Jobs FROM SigCdAcJ d" + ;
                       " WHERE d.Usuars = " + EscaparSQL(par_cFiltro) + "))))" + ;
                       " AND a.grupos = " + EscaparSQL(par_cGrPadVens) + ;
                       " AND a.Inativas <> 2" + ;
                       " AND c.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                       " ORDER BY a.iclis"

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar vendedores: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BuscarVendedores: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoesNivel - Carrega SigLcNv1/2/3/4 para cursor local
    * par_nNivel: 1, 2, 3 ou 4
    * par_cCursorDestino: cursor destino (ex: "csNivel1")
    *==========================================================================
    FUNCTION CarregarLocalizacoesNivel(par_nNivel, par_cCursorDestino)
        LOCAL loc_cSQL, loc_lSucesso, loc_cTabela, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(EMPTY(par_cCursorDestino), "csNivel" + LTRIM(STR(par_nNivel)), par_cCursorDestino)

        TRY
            DO CASE
            CASE par_nNivel = 1
                loc_cTabela = "SigLcNv1"
            CASE par_nNivel = 2
                loc_cTabela = "SigLcNv2"
            CASE par_nNivel = 3
                loc_cTabela = "SigLcNv3"
            CASE par_nNivel = 4
                loc_cTabela = "SigLcNv4"
            OTHERWISE
                MsgErro("N" + CHR(237) + "vel inv" + CHR(225) + "lido: " + ;
                        LTRIM(STR(par_nNivel)), "Erro")
                loc_lSucesso = .F.
            ENDCASE

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT * FROM " + loc_cTabela

            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) > 0
                SELECT (loc_cCursor)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar " + loc_cTabela + ": " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLocalizacoesNivel: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterNovoCidChaves - Gera novo cidchaves unico (char 20) via NEWID()
    *==========================================================================
    PROTECTED FUNCTION ObterNovoCidChaves()
        LOCAL loc_cChave, loc_lSucesso
        loc_cChave   = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36), NEWID()),'-',''), 20) AS nova_chave", ;
                "cursor_4c_NovaChave") > 0
            IF loc_lSucesso
                SELECT cursor_4c_NovaChave
                loc_cChave = ALLTRIM(nova_chave)
            ELSE
                MsgErro("Erro ao gerar chave interna: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterNovoCidChaves: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_NovaChave")
            USE IN cursor_4c_NovaChave
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * ObterProximoCodigo - Gera proximo Cods numerico disponivel em SigCdCnL
    *==========================================================================
    PROTECTED FUNCTION ObterProximoCodigo()
        LOCAL loc_cCodigo, loc_lSucesso
        loc_cCodigo  = ""
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(CAST(cods AS bigint)), 0) + 1 AS proximo FROM sigcdcnl", ;
                "cursor_4c_ProxCod") > 0
            IF loc_lSucesso
                SELECT cursor_4c_ProxCod
                loc_cCodigo = ALLTRIM(STR(cursor_4c_ProxCod.proximo, 10))
            ELSE
                MsgErro("Erro ao obter pr" + CHR(243) + "ximo c" + CHR(243) + "digo: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ObterProximoCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_cCodigo
    ENDFUNC

ENDDEFINE

