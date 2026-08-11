# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [BINDEVENT-PARAMS] Handler 'EmpColLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE EmpColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'QtdeColLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE QtdeColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'LocalColLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE LocalColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'QIdealColLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE QIdealColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Min., Tam, Cor, Estoque Ideal, Emp, Qtde. Mínima, Tamanho, Grupo, Conta, Local, Estoque Alvo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Min., Tam, Cor, Estoque Ideal, Emp, Qtde. Mínima, Tamanho, Grupo, Conta, Local, Estoque Alvo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Min., Tam, Cor, Estoque Ideal, Emp, Qtde. Mínima, Tamanho, Grupo, Conta, Local, Estoque Alvo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Min., Tam, Cor, Estoque Ideal, Emp, Qtde. Mínima, Tamanho, Grupo, Conta, Local, Estoque Alvo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Sub-Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Min., Tam, Cor, Estoque Ideal, Emp, Qtde. Mínima, Tamanho, Grupo, Conta, Local, Estoque Alvo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDEMN.Pagina.Dados): Top original=38 vs migrado 'obj_4c_Opc_situacao' Top=5 (diff=33px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opc_situacao' (parent: SIGCDEMN.Pagina.Dados): Left original=504 vs migrado 'obj_4c_Opc_situacao' Left=5 (diff=499px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRetiras' (parent: SIGCDEMN.Pagina.Dados): Top original=563 vs migrado 'obj_4c_OptRetiras' Top=5 (diff=558px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optRetiras' (parent: SIGCDEMN.Pagina.Dados): Left original=207 vs migrado 'obj_4c_OptRetiras' Left=5 (diff=202px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEmn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2337 linhas total):

*-- Linhas 32 a 156:
32:     this_cEscolha        = ""         && INSERIR / ALTERAR / PROCURAR / VISUALIZAR (legado)
33: 
34:     *==========================================================================
35:     PROCEDURE Init()
36:     *==========================================================================
37:         LOCAL loc_lResultado
38:         loc_lResultado = .F.
39: 
40:         TRY
41:             loc_lResultado = DODEFAULT()
42:         CATCH TO loc_oErro
43:             MsgErro(loc_oErro.Message, "FormEmn.Init")
44:         ENDTRY
45: 
46:         RETURN loc_lResultado
47:     ENDPROC
48: 
49:     *==========================================================================
50:     * InicializarForm - Chamado automaticamente pelo FormBase.Init()
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm()
53:         LOCAL loc_lResultado
54:         loc_lResultado = .F.
55: 
56:         TRY
57:             *-- Pular carga de dados se estiver validando UI (sem conexao SQL)
58:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
59:                 loc_lResultado = .T.
60:             ELSE
61:                 THIS.this_oBusinessObject = CREATEOBJECT("EmnBO")
62: 
63:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
64:                     THIS.ConfigurarPageFrame()
65:                     THIS.pgf_4c_Paginas.Visible = .T.
66:                     THIS.pgf_4c_Paginas.ActivePage = 1
67:                     THIS.this_cModoAtual = "LISTA"
68:                     THIS.CarregarLista()
69:                     loc_lResultado = .T.
70:                 ELSE
71:                     MsgErro("Falha ao criar EmnBO.", "FormEmn.InicializarForm")
72:                 ENDIF
73:             ENDIF
74:         CATCH TO loc_oErro
75:             MsgErro(loc_oErro.Message, "FormEmn.InicializarForm")
76:         ENDTRY
77: 
78:         RETURN loc_lResultado
79:     ENDPROC
80: 
81:     *==========================================================================
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     *==========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         LOCAL loc_oPg1, loc_oPg2
86: 
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount  = 2
91:             .Top        = -29
92:             .Left       = 0
93:             .Width      = THIS.Width
94:             .Height     = THIS.Height + 29
95:             .Tabs       = .F.
96:             .Visible    = .T.
97: 
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page2.BackColor = RGB(100, 100, 100)
100:         ENDWITH
101: 
102:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
103:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
104: 
105:         *-- Imagem de fundo (legado: new_background.jpg)
106:         loc_oPg1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
107:         loc_oPg2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
108: 
109:         THIS.ConfigurarPaginaLista(loc_oPg1)
110:         THIS.ConfigurarPaginaDados(loc_oPg2)
111:     ENDPROC
112: 
113:     *==========================================================================
114:     * ConfigurarPaginaLista - Cria containers base na Page1 (Lista)
115:     *==========================================================================
116:     PROTECTED PROCEDURE ConfigurarPaginaLista(par_oPagina)
117: 
118:         *-- Cabecalho escuro com titulo (cntSombra legado)
119:         *-- Compensacao PageFrame: cntSombra.Top=1 + 29 = 30
120:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
121:         WITH par_oPagina.cnt_4c_Sombra
122:             .Top         = 30
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
132:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width - 12
136:             .Height    = 40
137:             .Caption   = THIS.Caption
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
148:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width - 12
152:             .Height    = 46
153:             .Caption   = THIS.Caption
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 196 a 415:
196:             .AutoSize        = .F.
197:             .Visible         = .T.
198:         ENDWITH
199:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
200: 
201:         *-- Botao Visualizar (Consultar legado: Top=5, Left=80)
202:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .FontName        = "Comic Sans MS"
212:             .FontSize        = 8
213:             .FontBold        = .T.
214:             .FontItalic      = .T.
215:             .ForeColor       = RGB(90, 90, 90)
216:             .BackColor       = RGB(255, 255, 255)
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
225: 
226:         *-- Botao Alterar (Top=5, Left=155)
227:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .FontName        = "Comic Sans MS"
237:             .FontSize        = 8
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .ForeColor       = RGB(90, 90, 90)
241:             .BackColor       = RGB(255, 255, 255)
242:             .Themes          = .F.
243:             .SpecialEffect   = 0
244:             .MousePointer    = 15
245:             .WordWrap        = .T.
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
250: 
251:         *-- Botao Excluir (Top=5, Left=230)
252:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .FontName        = "Comic Sans MS"
262:             .FontSize        = 8
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .ForeColor       = RGB(90, 90, 90)
266:             .BackColor       = RGB(255, 255, 255)
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .AutoSize        = .F.
272:             .Visible         = .T.
273:         ENDWITH
274:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
275: 
276:         *-- Botao Buscar (Procurar legado: Top=5, Left=305)
277:         par_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
278:         WITH par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
279:             .Caption         = "Buscar"
280:             .Top             = 5
281:             .Left            = 305
282:             .Width           = 75
283:             .Height          = 75
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .FontName        = "Comic Sans MS"
287:             .FontSize        = 8
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .ForeColor       = RGB(90, 90, 90)
291:             .BackColor       = RGB(255, 255, 255)
292:             .Themes          = .F.
293:             .SpecialEffect   = 0
294:             .MousePointer    = 15
295:             .WordWrap        = .T.
296:             .AutoSize        = .F.
297:             .Visible         = .T.
298:         ENDWITH
299:         BINDEVENT(par_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
300: 
301:         *-- Container de saida - padrao canonico (Grupo_Saida legado)
302:         par_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH par_oPagina.cnt_4c_Saida
304:             .Top         = 28
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         par_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
315:             .Caption         = "Encerrar"
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
321:             .PicturePosition = 13
322:             .FontName        = "Comic Sans MS"
323:             .FontSize        = 8
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .ForeColor       = RGB(90, 90, 90)
327:             .BackColor       = RGB(255, 255, 255)
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .MousePointer    = 15
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:             .Visible         = .T.
334:         ENDWITH
335: 
336:         BINDEVENT(par_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid da lista (Pagina.Lista.Grade legado: Top=121, Left=12, Width=939, Height=470)
339:         *-- Compensacao PageFrame: Top=121 + 29 = 150
340:         par_oPagina.AddObject("grd_4c_Lista", "Grid")
341:         WITH par_oPagina.grd_4c_Lista
342:             .Top               = 150
343:             .Left              = 12
344:             .Width             = 939
345:             .Height            = 435
346:             .FontName          = "Verdana"
347:             .FontSize          = 8
348:             .ForeColor         = RGB(90, 90, 90)
349:             .BackColor         = RGB(255, 255, 255)
350:             .GridLineColor     = RGB(238, 238, 238)
351:             .GridLines         = 3
352:             .RowHeight         = 16
353:             .HeaderHeight      = 20
354:             .DeleteMark        = .F.
355:             .RecordMark        = .F.
356:             .ScrollBars        = 2
357:             .HighlightStyle    = 2
358:             .HighlightBackColor = RGB(15, 41, 104)
359:             .HighlightForeColor = RGB(255, 255, 255)
360:             .ReadOnly          = .T.
361:             .AllowCellSelection = .F.
362:             .AllowHeaderSizing = .F.
363:             .ColumnCount       = 5
364:             .Visible           = .T.
365:         ENDWITH
366: 
367:         BINDEVENT(par_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnAlterarClick")
368: 
369:         THIS.TornarControlesVisiveis(par_oPagina)
370:     ENDPROC
371: 
372:     *==========================================================================
373:     * CarregarLista - Carrega registros na grid da Page1 (cursor CrProdutos)
374:     *==========================================================================
375:     PROCEDURE CarregarLista()
376:         LOCAL loc_lResultado, loc_oGrid
377:         loc_lResultado = .F.
378: 
379:         TRY
380:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
381:                 loc_lResultado = .T.
382:             ELSE
383:                 IF VARTYPE(THIS.this_oBusinessObject) <> "O"
384:                     MsgErro("Business Object nao inicializado.", "FormEmn.CarregarLista")
385:                 ELSE
386:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
387: 
388:                     IF !THIS.this_oBusinessObject.Buscar("")
389:                         loc_lResultado = .F.
390:                     ELSE
391:                         *-- Configurar RecordSource + colunas
392:                         loc_oGrid.RecordSource = "CrProdutos"
393: 
394:                         loc_oGrid.Column1.ControlSource   = "CrProdutos.cpros"
395:                         loc_oGrid.Column1.Width           = 100
396:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
397:                         loc_oGrid.Column1.Header1.Alignment = 2
398:                         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
399:                         loc_oGrid.Column1.Header1.FontSize  = 8
400:                         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
401: 
402:                         loc_oGrid.Column2.ControlSource   = "CrProdutos.dpros"
403:                         loc_oGrid.Column2.Width           = 430
404:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
405:                         loc_oGrid.Column2.Header1.Alignment = 2
406:                         loc_oGrid.Column2.Header1.FontName  = "Tahoma"
407:                         loc_oGrid.Column2.Header1.FontSize  = 8
408:                         loc_oGrid.Column2.Header1.ForeColor = RGB(90, 90, 90)
409: 
410:                         loc_oGrid.Column3.ControlSource   = "CrProdutos.ifors"
411:                         loc_oGrid.Column3.Width           = 100
412:                         loc_oGrid.Column3.Header1.Caption = "Fornecedor"
413:                         loc_oGrid.Column3.Header1.Alignment = 2
414:                         loc_oGrid.Column3.Header1.FontName  = "Tahoma"
415:                         loc_oGrid.Column3.Header1.FontSize  = 8

*-- Linhas 448 a 740:
448:     *==========================================================================
449:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
450:     *==========================================================================
451:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
452:         LOCAL loc_lResultado
453:         loc_lResultado = .F.
454: 
455:         IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
456:             RETURN .F.
457:         ENDIF
458: 
459:         TRY
460:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
461: 
462:             IF par_nPagina = 1
463:                 THIS.this_cModoAtual = "LISTA"
464:                 THIS.CarregarLista()
465:             ENDIF
466: 
467:             loc_lResultado = .T.
468:         CATCH TO loc_oErro
469:             MsgErro(loc_oErro.Message, "FormEmn.AlternarPagina")
470:         ENDTRY
471: 
472:         RETURN loc_lResultado
473:     ENDPROC
474: 
475:     *==========================================================================
476:     * BtnIncluirClick - Inicia inclusao de novo registro
477:     *==========================================================================
478:     PROCEDURE BtnIncluirClick()
479:         TRY
480:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
481:                 THIS.this_oBusinessObject.NovoRegistro()
482:             ENDIF
483: 
484:             THIS.this_cEscolha   = "INSERIR"
485:             THIS.this_cModoAtual = "INCLUIR"
486: 
487:             IF PEMSTATUS(THIS, "LimparCampos", 5)
488:                 THIS.LimparCampos()
489:             ENDIF
490:             IF PEMSTATUS(THIS, "HabilitarCampos", 5)
491:                 THIS.HabilitarCampos(.T.)
492:             ENDIF
493: 
494:             THIS.pgf_4c_Paginas.ActivePage = 2
495:         CATCH TO loc_oErro
496:             MsgErro(loc_oErro.Message, "FormEmn.BtnIncluirClick")
497:         ENDTRY
498:     ENDPROC
499: 
500:     *==========================================================================
501:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
502:     *==========================================================================
503:     PROCEDURE BtnVisualizarClick()
504:         LOCAL loc_cCPros, loc_lProsseguir
505:         loc_cCPros      = ""
506:         loc_lProsseguir = .T.
507: 
508:         TRY
509:             IF !USED("CrProdutos") OR EOF("CrProdutos")
510:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
511:                 loc_lProsseguir = .F.
512:             ENDIF
513: 
514:             IF loc_lProsseguir
515:                 SELECT CrProdutos
516:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
517:                 IF EMPTY(loc_cCPros)
518:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Visualizar")
519:                     loc_lProsseguir = .F.
520:                 ENDIF
521:             ENDIF
522: 
523:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
524:                 loc_lProsseguir = .F.
525:             ENDIF
526: 
527:             IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
528:                 MsgErro("Falha ao carregar produto " + loc_cCPros, "Visualizar")
529:                 loc_lProsseguir = .F.
530:             ENDIF
531: 
532:             IF loc_lProsseguir
533:                 THIS.this_cEscolha   = "PROCURAR"
534:                 THIS.this_cModoAtual = "VISUALIZAR"
535: 
536:                 IF PEMSTATUS(THIS, "BOParaForm", 5)
537:                     THIS.BOParaForm()
538:                 ENDIF
539:                 IF PEMSTATUS(THIS, "HabilitarCampos", 5)
540:                     THIS.HabilitarCampos(.F.)
541:                 ENDIF
542: 
543:                 THIS.pgf_4c_Paginas.ActivePage = 2
544:             ENDIF
545:         CATCH TO loc_oErro
546:             MsgErro(loc_oErro.Message, "FormEmn.BtnVisualizarClick")
547:         ENDTRY
548:     ENDPROC
549: 
550:     *==========================================================================
551:     * BtnAlterarClick - Altera registro selecionado
552:     *==========================================================================
553:     PROCEDURE BtnAlterarClick()
554:         LOCAL loc_cCPros, loc_lProsseguir
555:         loc_cCPros      = ""
556:         loc_lProsseguir = .T.
557: 
558:         TRY
559:             IF !USED("CrProdutos") OR EOF("CrProdutos")
560:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
561:                 loc_lProsseguir = .F.
562:             ENDIF
563: 
564:             IF loc_lProsseguir
565:                 SELECT CrProdutos
566:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
567:                 IF EMPTY(loc_cCPros)
568:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Alterar")
569:                     loc_lProsseguir = .F.
570:                 ENDIF
571:             ENDIF
572: 
573:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
574:                 loc_lProsseguir = .F.
575:             ENDIF
576: 
577:             IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
578:                 MsgErro("Falha ao carregar produto " + loc_cCPros, "Alterar")
579:                 loc_lProsseguir = .F.
580:             ENDIF
581: 
582:             IF loc_lProsseguir
583:                 THIS.this_oBusinessObject.EditarRegistro()
584:                 THIS.this_cEscolha   = "ALTERAR"
585:                 THIS.this_cModoAtual = "ALTERAR"
586: 
587:                 IF PEMSTATUS(THIS, "BOParaForm", 5)
588:                     THIS.BOParaForm()
589:                 ENDIF
590:                 IF PEMSTATUS(THIS, "HabilitarCampos", 5)
591:                     THIS.HabilitarCampos(.T.)
592:                 ENDIF
593: 
594:                 THIS.pgf_4c_Paginas.ActivePage = 2
595:             ENDIF
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message, "FormEmn.BtnAlterarClick")
598:         ENDTRY
599:     ENDPROC
600: 
601:     *==========================================================================
602:     * BtnExcluirClick - Exclui registro selecionado
603:     *==========================================================================
604:     PROCEDURE BtnExcluirClick()
605:         LOCAL loc_cCPros, loc_lConfirma, loc_lProsseguir
606:         loc_cCPros      = ""
607:         loc_lConfirma   = .F.
608:         loc_lProsseguir = .T.
609: 
610:         TRY
611:             IF !USED("CrProdutos") OR EOF("CrProdutos")
612:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
613:                 loc_lProsseguir = .F.
614:             ENDIF
615: 
616:             IF loc_lProsseguir
617:                 SELECT CrProdutos
618:                 loc_cCPros = ALLTRIM(CrProdutos.cpros)
619:                 IF EMPTY(loc_cCPros)
620:                     MsgAviso("Produto inv" + CHR(225) + "lido.", "Excluir")
621:                     loc_lProsseguir = .F.
622:                 ENDIF
623:             ENDIF
624: 
625:             IF loc_lProsseguir
626:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto " + loc_cCPros + " ?", "Excluir")
627:                 IF !loc_lConfirma
628:                     loc_lProsseguir = .F.
629:                 ENDIF
630:             ENDIF
631: 
632:             IF loc_lProsseguir AND VARTYPE(THIS.this_oBusinessObject) <> "O"
633:                 loc_lProsseguir = .F.
634:             ENDIF
635: 
636:             IF loc_lProsseguir AND !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCPros)
637:                 MsgErro("Falha ao carregar produto " + loc_cCPros, "Excluir")
638:                 loc_lProsseguir = .F.
639:             ENDIF
640: 
641:             IF loc_lProsseguir
642:                 IF THIS.this_oBusinessObject.Excluir()
643:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Excluir")
644:                     THIS.CarregarLista()
645:                 ENDIF
646:             ENDIF
647:         CATCH TO loc_oErro
648:             MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirClick")
649:         ENDTRY
650:     ENDPROC
651: 
652:     *==========================================================================
653:     * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar produto
654:     *==========================================================================
655:     PROCEDURE BtnBuscarClick()
656:         LOCAL loc_oBusca, loc_cCPros
657:         loc_cCPros = ""
658: 
659:         TRY
660:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
661:                 "SigCdPro", "cursor_4c_BuscaProd", "cpros", "", ;
662:                 "Buscar Produto")
663: 
664:             IF VARTYPE(loc_oBusca) <> "O"
665:                 RETURN
666:             ENDIF
667: 
668:             IF !loc_oBusca.this_lAchouRegistro
669:                 loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
670:                 loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
671:                 loc_oBusca.Show()
672:             ENDIF
673: 
674:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
675:                 loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
676:             ENDIF
677: 
678:             IF USED("cursor_4c_BuscaProd")
679:                 USE IN cursor_4c_BuscaProd
680:             ENDIF
681: 
682:             loc_oBusca.Release()
683: 
684:             IF !EMPTY(loc_cCPros)
685:                 *-- Recarrega lista filtrando pelo produto selecionado
686:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
687:                     IF THIS.this_oBusinessObject.Buscar(loc_cCPros)
688:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
689:                     ENDIF
690:                 ENDIF
691:             ENDIF
692:         CATCH TO loc_oErro
693:             MsgErro(loc_oErro.Message, "FormEmn.BtnBuscarClick")
694:         ENDTRY
695:     ENDPROC
696: 
697:     *==========================================================================
698:     * ConfigurarPaginaDados - Cria containers e campos na Page2 (Dados)
699:     *==========================================================================
700:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPagina)
701: 
702:         *-- Cabecalho escuro com titulo (padrao nova arquitetura em Page2)
703:         *-- Top = 1 + 29 = 30
704:         par_oPagina.AddObject("cnt_4c_Sombra", "Container")
705:         WITH par_oPagina.cnt_4c_Sombra
706:             .Top         = 30
707:             .Left        = 0
708:             .Width       = THIS.Width
709:             .Height      = 80
710:             .BackColor   = RGB(100, 100, 100)
711:             .BorderWidth = 0
712:             .Visible     = .T.
713:         ENDWITH
714: 
715:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
716:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Sombra
717:             .Top       = 15
718:             .Left      = 10
719:             .Width     = THIS.Width - 12
720:             .Height    = 40
721:             .Caption   = THIS.Caption
722:             .FontName  = "Tahoma"
723:             .FontSize  = 16
724:             .FontBold  = .T.
725:             .ForeColor = RGB(0, 0, 0)
726:             .BackStyle = 0
727:             .AutoSize  = .F.
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         par_oPagina.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
732:         WITH par_oPagina.cnt_4c_Sombra.lbl_4c_Titulo
733:             .Top       = 18
734:             .Left      = 10
735:             .Width     = THIS.Width - 12
736:             .Height    = 46
737:             .Caption   = THIS.Caption
738:             .FontName  = "Tahoma"
739:             .FontSize  = 16
740:             .FontBold  = .T.

*-- Linhas 923 a 968:
923:             .Visible   = .T.
924:         ENDWITH
925: 
926:         *-- OptionGroup Situacao (Opc_situacao: top=38+29=67, left=504, width=117, height=25)
927:         *-- When=.F. -> sempre desabilitado (informativo)
928:         par_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
929:         WITH par_oPagina.obj_4c_Opc_situacao
930:             .ButtonCount = 2
931:             .Top         = 67
932:             .Left        = 504
933:             .Width       = 117
934:             .Height      = 25
935:             .BackStyle   = 0
936:             .BorderStyle = 0
937:             .Value       = 1
938:             .Enabled     = .F.
939:             .Visible     = .T.
940: 
941:             WITH .Buttons(1)
942:                 .Caption   = "Ativa"
943:                 .Left      = 5
944:                 .Top       = 5
945:                 .AutoSize  = .T.
946:                 .ForeColor = RGB(90, 90, 90)
947:                 .Themes    = .F.
948:             ENDWITH
949: 
950:             WITH .Buttons(2)
951:                 .Caption   = "Inativa"
952:                 .Left      = 63
953:                 .Top       = 5
954:                 .AutoSize  = .T.
955:                 .FontName  = "Tahoma"
956:                 .FontSize  = 8
957:                 .ForeColor = RGB(90, 90, 90)
958:                 .Themes    = .F.
959:             ENDWITH
960:         ENDWITH
961: 
962:         *--------------------------------------------------------------------------
963:         *-- CAMPOS DA LINHA 3: Fornecedor
964:         *-- Compensacao PageFrame +29: top=69->98, top=66->95
965:         *--------------------------------------------------------------------------
966: 
967:         *-- Label "Fornecedor :" (Say11: top=69+29=98, left=182, width=64, height=15)
968:         par_oPagina.AddObject("lbl_4c_Label11", "Label")

*-- Linhas 1012 a 1057:
1012:             .Visible   = .T.
1013:         ENDWITH
1014: 
1015:         *-- BINDEVENTs para botoes Confirmar / Cancelar
1016:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1017:         BINDEVENT(par_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1018: 
1019:         *--------------------------------------------------------------------------
1020:         *-- LINHA 4: Referencia Fornecedor + Qtde Minima
1021:         *-- Compensacao PageFrame +29: top=95->124, top=92->121
1022:         *--------------------------------------------------------------------------
1023: 
1024:         *-- Label "Ref. Fornecedor :" (Say12: top=95+29=124, left=158, w=88, h=15)
1025:         par_oPagina.AddObject("lbl_4c_Label12", "Label")
1026:         WITH par_oPagina.lbl_4c_Label12
1027:             .Caption   = "Ref. Fornecedor :"
1028:             .Top       = 124
1029:             .Left      = 158
1030:             .Width     = 88
1031:             .Height    = 15
1032:             .FontName  = "Tahoma"
1033:             .FontSize  = 8
1034:             .BackStyle = 0
1035:             .ForeColor = RGB(90, 90, 90)
1036:             .Alignment = 1
1037:             .Visible   = .T.
1038:         ENDWITH
1039: 
1040:         *-- TextBox Ref. Fornecedor (getRefs: top=92+29=121, left=251, w=150, h=23)
1041:         *-- When=PROCURAR: apenas no modo busca; readonly nos demais modos
1042:         par_oPagina.AddObject("txt_4c_Refs", "TextBox")
1043:         WITH par_oPagina.txt_4c_Refs
1044:             .Top       = 121
1045:             .Left      = 251
1046:             .Width     = 150
1047:             .Height    = 23
1048:             .FontName  = "Tahoma"
1049:             .FontSize  = 8
1050:             .ForeColor = RGB(90, 90, 90)
1051:             .Value     = ""
1052:             .ReadOnly  = .T.
1053:             .Visible   = .T.
1054:         ENDWITH
1055: 
1056:         *-- Label "Qtde Minima :" (Say13: top=95+29=124, left=470, w=68, h=15)
1057:         par_oPagina.AddObject("lbl_4c_Label13", "Label")

*-- Linhas 1168 a 2337:
1168:             .Column8.Sparse           = .F.
1169:         ENDWITH
1170: 
1171:         *-- BINDEVENTs do grid e suas colunas
1172:         BINDEVENT(par_oPagina.grd_4c_GradeI, "AfterRowColChange", THIS, "GradeIAfterRowColChange")
1173:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column1.Text1, "KeyPress",  THIS, "EmpColKeyPress")
1174:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column1.Text1, "KeyPress", THIS, "EmpColLostFocus")
1175:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column2.Text1, "KeyPress", THIS, "QtdeColLostFocus")
1176:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column3.Text1, "KeyPress",  THIS, "TamanhoColKeyPress")
1177:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column3.Text1, "DblClick",  THIS, "TamanhoColDblClick")
1178:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column4.Text1, "KeyPress",  THIS, "CorColKeyPress")
1179:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column4.Text1, "DblClick",  THIS, "CorColDblClick")
1180:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column5.Text1, "KeyPress",  THIS, "GrupoColKeyPress")
1181:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column5.Text1, "DblClick",  THIS, "GrupoColDblClick")
1182:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column6.Text1, "KeyPress",  THIS, "ContaColKeyPress")
1183:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column6.Text1, "DblClick",  THIS, "ContaColDblClick")
1184:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "KeyPress",  THIS, "LocalColKeyPress")
1185:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "DblClick",  THIS, "LocalColDblClick")
1186:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column7.Text1, "KeyPress", THIS, "LocalColLostFocus")
1187:         BINDEVENT(par_oPagina.grd_4c_GradeI.Column8.Text1, "KeyPress", THIS, "QIdealColLostFocus")
1188: 
1189:         *--------------------------------------------------------------------------
1190:         *-- Botao Excluir linha do grid (btnExcluir: top=313+29=342, left=843, w=45, h=45)
1191:         *-- Standalone com icone - usar Themes=.T. + DisabledPicture (Problem 29)
1192:         *--------------------------------------------------------------------------
1193:         par_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1194:         WITH par_oPagina.cmd_4c_BtnExcluir
1195:             .Caption         = ""
1196:             .Top             = 342
1197:             .Left            = 843
1198:             .Width           = 45
1199:             .Height          = 45
1200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1201:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1202:             .PicturePosition = 0
1203:             .ToolTipText     = "Excluir linha"
1204:             .FontName        = "Tahoma"
1205:             .FontSize        = 8
1206:             .ForeColor       = RGB(90, 90, 90)
1207:             .BackColor       = RGB(255, 255, 255)
1208:             .Themes          = .T.
1209:             .SpecialEffect   = 0
1210:             .MousePointer    = 15
1211:             .Enabled         = .F.
1212:             .Visible         = .T.
1213:         ENDWITH
1214:         BINDEVENT(par_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")
1215: 
1216:         *--------------------------------------------------------------------------
1217:         *-- PARTE INFERIOR: "Retiravel :" + OptionGroup optRetiras
1218:         *-- Compensacao PageFrame +29: top=569->598, top=563->592
1219:         *--------------------------------------------------------------------------
1220: 
1221:         *-- Label "Retiravel :" (Say2: top=569+29=598, left=156)
1222:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
1223:         WITH par_oPagina.lbl_4c_Label2
1224:             .Caption   = "Retir" + CHR(225) + "vel :"
1225:             .Top       = 598
1226:             .Left      = 156
1227:             .FontName  = "Tahoma"
1228:             .FontSize  = 8
1229:             .BackStyle = 0
1230:             .ForeColor = RGB(90, 90, 90)
1231:             .Visible   = .T.
1232:         ENDWITH
1233: 
1234:         *-- OptionGroup Retiravel (optRetiras: top=563+29=592, left=207, w=168, h=27, 3 botoes)
1235:         *-- When=.F. no legado: display-only, atualizado via GradeIAfterRowColChange
1236:         par_oPagina.AddObject("obj_4c_OptRetiras", "OptionGroup")
1237:         WITH par_oPagina.obj_4c_OptRetiras
1238:             .ButtonCount = 3
1239:             .Top         = 592
1240:             .Left        = 207
1241:             .Width       = 168
1242:             .Height      = 27
1243:             .BackStyle   = 0
1244:             .BorderStyle = 0
1245:             .Value       = 1
1246:             .Enabled     = .F.
1247:             .Visible     = .T.
1248: 
1249:             WITH .Buttons(1)
1250:                 .Caption   = "Sim"
1251:                 .Left      = 5
1252:                 .Top       = 5
1253:                 .AutoSize  = .T.
1254:                 .ForeColor = RGB(90, 90, 90)
1255:                 .Themes    = .F.
1256:             ENDWITH
1257: 
1258:             WITH .Buttons(2)
1259:                 .Caption   = "N" + CHR(227) + "o"
1260:                 .Left      = 50
1261:                 .Top       = 5
1262:                 .AutoSize  = .T.
1263:                 .FontName  = "Tahoma"
1264:                 .FontSize  = 8
1265:                 .ForeColor = RGB(90, 90, 90)
1266:                 .Themes    = .F.
1267:             ENDWITH
1268: 
1269:             WITH .Buttons(3)
1270:                 .Caption   = "Produto"
1271:                 .Left      = 100
1272:                 .Top       = 5
1273:                 .AutoSize  = .T.
1274:                 .FontName  = "Tahoma"
1275:                 .FontSize  = 8
1276:                 .ForeColor = RGB(90, 90, 90)
1277:                 .Themes    = .F.
1278:             ENDWITH
1279:         ENDWITH
1280: 
1281:         *-- BINDEVENTs para lookup de produto (get_produto / getDpro) -- apenas em modo INSERIR
1282:         BINDEVENT(par_oPagina.txt_4c_Produto, "KeyPress", THIS, "ProdutoCodKeyPress")
1283:         BINDEVENT(par_oPagina.txt_4c_Produto, "DblClick", THIS, "ProdutoCodDblClick")
1284:         BINDEVENT(par_oPagina.txt_4c_Dpro,    "KeyPress", THIS, "ProdutoDescKeyPress")
1285:         BINDEVENT(par_oPagina.txt_4c_Dpro,    "DblClick", THIS, "ProdutoDescDblClick")
1286: 
1287:         THIS.TornarControlesVisiveis(par_oPagina)
1288:     ENDPROC
1289: 
1290:     *==========================================================================
1291:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1292:     * Containers flutuantes que iniciam ocultos sao preservados (cnt_4c_Copia)
1293:     *==========================================================================
1294:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1295:         LOCAL loc_nI, loc_oObjeto, loc_cNome
1296: 
1297:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1298:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1299: 
1300:             IF VARTYPE(loc_oObjeto) = "O"
1301:                 loc_cNome = UPPER(loc_oObjeto.Name)
1302: 
1303:                 *-- Preservar containers flutuantes que devem iniciar ocultos
1304:                 IF INLIST(loc_cNome, "CNT_4C_COPIA")
1305:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1306:                     LOOP
1307:                 ENDIF
1308: 
1309:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1310:                     loc_oObjeto.Visible = .T.
1311:                 ENDIF
1312: 
1313:                 *-- Trata PageFrame - itera Pages
1314:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1315:                     LOCAL loc_nP
1316:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1317:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1318:                     ENDFOR
1319:                 ENDIF
1320: 
1321:                 *-- Recursao em containers
1322:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1323:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1324:                 ENDIF
1325:             ENDIF
1326:         ENDFOR
1327:     ENDPROC
1328: 
1329:     *==========================================================================
1330:     * FormatarGridLista - Formata visual do grid da lista
1331:     *==========================================================================
1332:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1333:         WITH par_oGrid
1334:             .FontName = "Tahoma"
1335:             .FontSize = 8
1336:         ENDWITH
1337:     ENDPROC
1338: 
1339:     *==========================================================================
1340:     * BtnEncerrarClick - Fecha o formulario
1341:     *==========================================================================
1342:     PROCEDURE BtnEncerrarClick()
1343:         THIS.Release()
1344:     ENDPROC
1345: 
1346:     *==========================================================================
1347:     PROCEDURE Destroy()
1348:     *==========================================================================
1349:         LOCAL loc_lResultado
1350:         loc_lResultado = .F.
1351: 
1352:         TRY
1353:             *-- Limpar cursores do BO
1354:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1355:                 THIS.this_oBusinessObject = .NULL.
1356:             ENDIF
1357: 
1358:             IF USED("CrSigCdMin")
1359:                 USE IN CrSigCdMin
1360:             ENDIF
1361:             IF USED("CrProdutos")
1362:                 USE IN CrProdutos
1363:             ENDIF
1364:             IF USED("CsCabec")
1365:                 USE IN CsCabec
1366:             ENDIF
1367:             IF USED("CsCopia")
1368:                 USE IN CsCopia
1369:             ENDIF
1370: 
1371:             loc_lResultado = DODEFAULT()
1372:         CATCH TO loc_oErro
1373:             MsgErro(loc_oErro.Message, "FormEmn.Destroy")
1374:         ENDTRY
1375: 
1376:         RETURN loc_lResultado
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * BtnSalvarClick - Salva itens da grade e retorna para Page1
1381:     *==========================================================================
1382:     PROCEDURE BtnSalvarClick()
1383:         TRY
1384:             LOCAL loc_cCPros, loc_lTemLinhas
1385:             loc_cCPros     = ""
1386:             loc_lTemLinhas = .F.
1387: 
1388:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Produto", 5)
1389:                 loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
1390:             ENDIF
1391: 
1392:             IF EMPTY(loc_cCPros)
1393:                 MsgAviso("Informe o produto antes de salvar.", "Salvar")
1394:             ELSE
1395:                 IF USED("CrSigCdMin")
1396:                     SELECT CrSigCdMin
1397:                     SCAN FOR !DELETED()
1398:                         IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
1399:                             loc_lTemLinhas = .T.
1400:                             EXIT
1401:                         ENDIF
1402:                     ENDSCAN
1403:                 ENDIF
1404: 
1405:                 IF !loc_lTemLinhas
1406:                     MsgAviso("Inclua pelo menos um item na grade antes de salvar.", "Salvar")
1407:                 ELSE
1408:                     THIS.FormParaBO()
1409:                     IF THIS.this_oBusinessObject.Salvar()
1410:                         MsgInfo("Registros salvos com sucesso.", "Salvar")
1411:                         THIS.AlternarPagina(1)
1412:                     ENDIF
1413:                 ENDIF
1414:             ENDIF
1415:         CATCH TO loc_oErro
1416:             MsgErro(loc_oErro.Message, "FormEmn.BtnSalvarClick")
1417:         ENDTRY
1418:     ENDPROC
1419: 
1420:     *==========================================================================
1421:     * BtnCancelarClick - Cancela edicao e retorna para Page1
1422:     *==========================================================================
1423:     PROCEDURE BtnCancelarClick()
1424:         TRY
1425:             THIS.AlternarPagina(1)
1426:         CATCH TO loc_oErro
1427:             MsgErro(loc_oErro.Message, "FormEmn.BtnCancelarClick")
1428:         ENDTRY
1429:     ENDPROC
1430: 
1431:     *==========================================================================
1432:     * FormParaBO - Sincroniza campos do form para o BO
1433:     *==========================================================================
1434:     PROTECTED PROCEDURE FormParaBO()
1435:         TRY
1436:             LOCAL loc_oPg2
1437:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1438:             THIS.this_oBusinessObject.this_cCPros = ALLTRIM(loc_oPg2.txt_4c_Produto.Value)
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "FormEmn.FormParaBO")
1441:         ENDTRY
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * BOParaForm - Popula campos do form a partir do BO (modos VISUALIZAR/ALTERAR)
1446:     *==========================================================================
1447:     PROTECTED PROCEDURE BOParaForm()
1448:         TRY
1449:             LOCAL loc_oPg2, loc_oBO
1450:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1451:             loc_oBO  = THIS.this_oBusinessObject
1452: 
1453:             loc_oPg2.txt_4c_Produto.Value = loc_oBO.this_cCPros
1454:             loc_oPg2.txt_4c_Dpro.Value    = loc_oBO.this_cDPros
1455:             loc_oPg2.txt_4c_Cgru.Value    = loc_oBO.this_cCGrus
1456:             loc_oPg2.txt_4c_Dgru.Value    = loc_oBO.this_cDGrus
1457:             loc_oPg2.txt_4c_Ifor.Value    = loc_oBO.this_cIFors
1458:             loc_oPg2.txt_4c_Dfor.Value    = loc_oBO.this_cRClis
1459:             loc_oPg2.txt_4c_Refs.Value    = loc_oBO.this_cReffs
1460:             loc_oPg2.txt_4c_Qmin.Value    = loc_oBO.this_nQMins
1461: 
1462:             loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_oBO.this_nSituas = 1, 1, 2)
1463: 
1464:             THIS.CarregarGrade(loc_oBO.this_cCPros)
1465:         CATCH TO loc_oErro
1466:             MsgErro(loc_oErro.Message, "FormEmn.BOParaForm")
1467:         ENDTRY
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * HabilitarCampos - Habilita/desabilita campos conforme modo de edicao
1472:     *==========================================================================
1473:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1474:         TRY
1475:             LOCAL loc_oPg2, loc_lProdutoEdit
1476:             loc_oPg2         = THIS.pgf_4c_Paginas.Page2
1477:             loc_lProdutoEdit = (THIS.this_cModoAtual = "INCLUIR")
1478: 
1479:             loc_oPg2.txt_4c_Produto.ReadOnly = !loc_lProdutoEdit
1480:             loc_oPg2.txt_4c_Dpro.ReadOnly    = !loc_lProdutoEdit
1481: 
1482:             loc_oPg2.txt_4c_Cgru.ReadOnly = .T.
1483:             loc_oPg2.txt_4c_Dgru.ReadOnly = .T.
1484:             loc_oPg2.txt_4c_Ifor.ReadOnly = .T.
1485:             loc_oPg2.txt_4c_Dfor.ReadOnly = .T.
1486:             loc_oPg2.txt_4c_Refs.ReadOnly = .T.
1487:             loc_oPg2.txt_4c_Qmin.ReadOnly = .T.
1488: 
1489:             loc_oPg2.grd_4c_GradeI.ReadOnly                = !par_lHabilitar
1490:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1491:         CATCH TO loc_oErro
1492:             MsgErro(loc_oErro.Message, "FormEmn.HabilitarCampos")
1493:         ENDTRY
1494:     ENDPROC
1495: 
1496:     *==========================================================================
1497:     * LimparCampos - Limpa todos os campos da Page2
1498:     *==========================================================================
1499:     PROTECTED PROCEDURE LimparCampos()
1500:         TRY
1501:             LOCAL loc_oPg2
1502:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1503: 
1504:             loc_oPg2.txt_4c_Produto.Value = ""
1505:             loc_oPg2.txt_4c_Dpro.Value    = ""
1506:             loc_oPg2.txt_4c_Cgru.Value    = ""
1507:             loc_oPg2.txt_4c_Dgru.Value    = ""
1508:             loc_oPg2.txt_4c_Ifor.Value    = ""
1509:             loc_oPg2.txt_4c_Dfor.Value    = ""
1510:             loc_oPg2.txt_4c_Refs.Value    = ""
1511:             loc_oPg2.txt_4c_Qmin.Value    = 0
1512: 
1513:             loc_oPg2.obj_4c_Opc_situacao.Value = 1
1514:             loc_oPg2.obj_4c_OptRetiras.Value   = 1
1515: 
1516:             THIS.CriarCursorGridVazio("")
1517:             THIS.ConfigurarRecordSourceGrid()
1518:         CATCH TO loc_oErro
1519:             MsgErro(loc_oErro.Message, "FormEmn.LimparCampos")
1520:         ENDTRY
1521:     ENDPROC
1522: 
1523:     *==========================================================================
1524:     * CarregarGrade - Carrega itens do grid para o produto especificado
1525:     *==========================================================================
1526:     PROTECTED PROCEDURE CarregarGrade(par_cCPros)
1527:         TRY
1528:             THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.RecordSource = ""
1529: 
1530:             IF !THIS.this_oBusinessObject.BuscarItens(par_cCPros)
1531:                 THIS.CriarCursorGridVazio(par_cCPros)
1532:             ENDIF
1533: 
1534:             THIS.ConfigurarRecordSourceGrid()
1535:         CATCH TO loc_oErro
1536:             MsgErro(loc_oErro.Message, "FormEmn.CarregarGrade")
1537:         ENDTRY
1538:     ENDPROC
1539: 
1540:     *==========================================================================
1541:     * ConfigurarRecordSourceGrid - Vincula CrSigCdMin ao grid e seta ControlSources
1542:     * Deve ser chamado APOS qualquer mudanca no cursor (Problem 48)
1543:     *==========================================================================
1544:     PROTECTED PROCEDURE ConfigurarRecordSourceGrid()
1545:         TRY
1546:             LOCAL loc_oGrid, loc_oBO
1547:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
1548:             loc_oBO   = THIS.this_oBusinessObject
1549: 
1550:             loc_oGrid.RecordSource = "CrSigCdMin"
1551: 
1552:             *-- ControlSources APOS RecordSource (Problem 48 - RecordSource reseta bindings)
1553:             loc_oGrid.Column1.ControlSource = "CrSigCdMin.emps"
1554:             loc_oGrid.Column2.ControlSource = "CrSigCdMin.qmins"
1555:             loc_oGrid.Column3.ControlSource = "CrSigCdMin.codtams"
1556:             loc_oGrid.Column4.ControlSource = "CrSigCdMin.codcores"
1557:             loc_oGrid.Column5.ControlSource = "CrSigCdMin.grupos"
1558:             loc_oGrid.Column6.ControlSource = "CrSigCdMin.contas"
1559:             loc_oGrid.Column7.ControlSource = "CrSigCdMin.locals"
1560:             loc_oGrid.Column8.ControlSource = "CrSigCdMin.qideal"
1561: 
1562:             *-- Resetar headers (RecordSource pode ter limpo as captions)
1563:             loc_oGrid.Column1.Header1.Caption = "Emp"
1564:             loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(237) + "nima"
1565:             loc_oGrid.Column3.Header1.Caption = "Tamanho"
1566:             loc_oGrid.Column4.Header1.Caption = "Cor"
1567:             loc_oGrid.Column5.Header1.Caption = "Grupo"
1568:             loc_oGrid.Column6.Header1.Caption = "Conta"
1569:             loc_oGrid.Column7.Header1.Caption = "Local"
1570:             loc_oGrid.Column8.Header1.Caption = "Estoque Alvo"
1571: 
1572:             *-- Habilitar/desabilitar colunas Tamanho e Cor conforme flags do produto
1573:             loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
1574:             loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor
1575: 
1576:             loc_oGrid.Refresh()
1577:         CATCH TO loc_oErro
1578:             MsgErro(loc_oErro.Message, "FormEmn.ConfigurarRecordSourceGrid")
1579:         ENDTRY
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * CriarCursorGridVazio - Cria cursor CrSigCdMin com estrutura completa e
1584:     *                        uma linha em branco para entrada de dados
1585:     *==========================================================================
1586:     PROTECTED PROCEDURE CriarCursorGridVazio(par_cCPros)
1587:         TRY
1588:             IF USED("CrSigCdMin")
1589:                 USE IN CrSigCdMin
1590:             ENDIF
1591: 
1592:             SET NULL ON
1593:             CREATE CURSOR CrSigCdMin ( ;
1594:                 cpros    C(14), emps     C(3),   locals   C(10), ;
1595:                 qmins    N(8,2), codtams  C(4),   codcores C(4),  ;
1596:                 ordems   C(1),  cidchaves C(20),  contas   C(10), ;
1597:                 grupos   C(10), qideal   N(7,2),  retiras  N(1,0), ;
1598:                 pideal   N(7,3), pmins    N(7,3),  dpros    C(65), ;
1599:                 ifors    C(10), reffs    C(20),  cgrus    C(3),  ;
1600:                 situas   N(1,0), rclis    C(50),  dgrus    C(20))
1601:             SET NULL OFF
1602: 
1603:             INSERT INTO CrSigCdMin ;
1604:                 (cpros,      emps, locals, qmins, codtams, codcores, ;
1605:                  ordems,     cidchaves, contas, grupos, qideal, ;
1606:                  retiras,    pideal, pmins) ;
1607:                 VALUES ;
1608:                 (par_cCPros, "",   "",    0,     "",      "",       ;
1609:                  " ",        "",   "",    "",    0,       ;
1610:                  1,          0,    0)
1611: 
1612:             GO TOP IN CrSigCdMin
1613:         CATCH TO loc_oErro
1614:             SET NULL OFF
1615:             MsgErro(loc_oErro.Message, "FormEmn.CriarCursorGridVazio")
1616:         ENDTRY
1617:     ENDPROC
1618: 
1619:     *==========================================================================
1620:     * AdicionarLinhaGrid - Insere nova linha vazia no cursor do grid
1621:     *==========================================================================
1622:     PROTECTED PROCEDURE AdicionarLinhaGrid()
1623:         IF !USED("CrSigCdMin")
1624:             RETURN
1625:         ENDIF
1626: 
1627:         TRY
1628:             LOCAL loc_cCPros, loc_oGrid
1629:             loc_cCPros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
1630: 
1631:             INSERT INTO CrSigCdMin ;
1632:                 (cpros,      emps, locals, qmins, codtams, codcores, ;
1633:                  ordems,     cidchaves, contas, grupos, qideal, ;
1634:                  retiras,    pideal, pmins) ;
1635:                 VALUES ;
1636:                 (loc_cCPros, "",   "",    0,     "",      "",       ;
1637:                  " ",        "",   "",    "",    0,       ;
1638:                  1,          0,    0)
1639: 
1640:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
1641:             SELECT CrSigCdMin
1642:             GO BOTTOM
1643:             loc_oGrid.Refresh()
1644:             loc_oGrid.ActivateCell(RECCOUNT("CrSigCdMin"), 1)
1645:         CATCH TO loc_oErro
1646:             MsgErro(loc_oErro.Message, "FormEmn.AdicionarLinhaGrid")
1647:         ENDTRY
1648:     ENDPROC
1649: 
1650:     *==========================================================================
1651:     * CarregarDadosProduto - Popula cabecalho ao selecionar produto novo
1652:     *==========================================================================
1653:     PROTECTED PROCEDURE CarregarDadosProduto(par_cCPros)
1654:         IF EMPTY(ALLTRIM(par_cCPros))
1655:             RETURN
1656:         ENDIF
1657: 
1658:         LOCAL loc_cSQL, loc_nRes
1659:         loc_cSQL = ""
1660:         loc_nRes = 0
1661: 
1662:         TRY
1663:             loc_cSQL = "SELECT a.cpros, a.dpros, a.cgrus, a.ifors, a.reffs, a.situas," + ;
1664:                 " b.rclis, g.dgrus" + ;
1665:                 " FROM SigCdPro a" + ;
1666:                 " LEFT JOIN SigCdCli b ON b.iclis = a.ifors" + ;
1667:                 " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
1668:                 " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))
1669: 
1670:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados")
1671: 
1672:             IF loc_nRes > 0 AND USED("cursor_4c_ProdDados") AND RECCOUNT("cursor_4c_ProdDados") > 0
1673:                 SELECT cursor_4c_ProdDados
1674:                 GO TOP
1675: 
1676:                 LOCAL loc_oPg2, loc_oBO, loc_nSituas
1677:                 loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1678:                 loc_oBO     = THIS.this_oBusinessObject
1679:                 loc_nSituas = TratarNulo(cursor_4c_ProdDados.situas, "N")
1680: 
1681:                 loc_oPg2.txt_4c_Produto.Value = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
1682:                 loc_oPg2.txt_4c_Dpro.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
1683:                 loc_oPg2.txt_4c_Cgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
1684:                 loc_oPg2.txt_4c_Dgru.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dgrus, "C"))
1685:                 loc_oPg2.txt_4c_Ifor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
1686:                 loc_oPg2.txt_4c_Dfor.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.rclis, "C"))
1687:                 loc_oPg2.txt_4c_Refs.Value    = ALLTRIM(TratarNulo(cursor_4c_ProdDados.reffs, "C"))
1688:                 loc_oPg2.obj_4c_Opc_situacao.Value = IIF(loc_nSituas = 1, 1, 2)
1689: 
1690:                 loc_oBO.this_cCPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cpros, "C"))
1691:                 loc_oBO.this_cDPros  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.dpros, "C"))
1692:                 loc_oBO.this_cCGrus  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.cgrus, "C"))
1693:                 loc_oBO.this_cIFors  = ALLTRIM(TratarNulo(cursor_4c_ProdDados.ifors, "C"))
1694:                 loc_oBO.this_nSituas = loc_nSituas
1695: 
1696:                 loc_oBO.BuscarFlags(ALLTRIM(par_cCPros))
1697:                 THIS.CriarCursorGridVazio(ALLTRIM(par_cCPros))
1698:                 THIS.ConfigurarRecordSourceGrid()
1699:             ELSE
1700:                 MsgAviso("Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCPros), "Produto")
1701:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value = ""
1702:             ENDIF
1703:         CATCH TO loc_oErro
1704:             MsgErro(loc_oErro.Message, "FormEmn.CarregarDadosProduto")
1705:         ENDTRY
1706: 
1707:         IF USED("cursor_4c_ProdDados")
1708:             USE IN cursor_4c_ProdDados
1709:         ENDIF
1710:     ENDPROC
1711: 
1712:     *==========================================================================
1713:     * AbrirLookupProdutoCodigo - FormBuscaAuxiliar em SigCdPro por cpros
1714:     *==========================================================================
1715:     PROTECTED PROCEDURE AbrirLookupProdutoCodigo()
1716:         LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual
1717:         loc_cCPros      = ""
1718:         loc_cValorAtual = ""
1719: 
1720:         TRY
1721:             loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Produto.Value)
1722: 
1723:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1724:                 "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValorAtual, ;
1725:                 "Buscar Produto")
1726: 
1727:             IF VARTYPE(loc_oBusca) = "O"
1728:                 IF !loc_oBusca.this_lAchouRegistro
1729:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1730:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1731:                     loc_oBusca.Show()
1732:                 ENDIF
1733: 
1734:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1735:                     loc_cCPros = ALLTRIM(cursor_4c_BuscaProd.cpros)
1736:                 ENDIF
1737: 
1738:                 IF USED("cursor_4c_BuscaProd")
1739:                     USE IN cursor_4c_BuscaProd
1740:                 ENDIF
1741: 
1742:                 loc_oBusca.Release()
1743:             ENDIF
1744: 
1745:             IF !EMPTY(loc_cCPros)
1746:                 THIS.CarregarDadosProduto(loc_cCPros)
1747:             ENDIF
1748:         CATCH TO loc_oErro
1749:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoCodigo")
1750:         ENDTRY
1751:     ENDPROC
1752: 
1753:     PROCEDURE ProdutoCodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1754:         IF THIS.this_cModoAtual = "INCLUIR" AND par_nKeyCode = 115
1755:             THIS.AbrirLookupProdutoCodigo()
1756:         ENDIF
1757:     ENDPROC
1758: 
1759:     PROCEDURE ProdutoCodDblClick()
1760:         IF THIS.this_cModoAtual = "INCLUIR"
1761:             THIS.AbrirLookupProdutoCodigo()
1762:         ENDIF
1763:     ENDPROC
1764: 
1765:     *==========================================================================
1766:     * AbrirLookupProdutoDescricao - FormBuscaAuxiliar em SigCdPro por dpros
1767:     *==========================================================================
1768:     PROTECTED PROCEDURE AbrirLookupProdutoDescricao()
1769:         LOCAL loc_oBusca, loc_cCPros, loc_cValorAtual
1770:         loc_cCPros      = ""
1771:         loc_cValorAtual = ""
1772: 
1773:         TRY
1774:             loc_cValorAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dpro.Value)
1775: 
1776:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1777:                 "SigCdPro", "cursor_4c_BuscaProdD", "dpros", loc_cValorAtual, ;
1778:                 "Buscar Produto")
1779: 
1780:             IF VARTYPE(loc_oBusca) = "O"
1781:                 IF !loc_oBusca.this_lAchouRegistro
1782:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1783:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1784:                     loc_oBusca.Show()
1785:                 ENDIF
1786: 
1787:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdD")
1788:                     loc_cCPros = ALLTRIM(cursor_4c_BuscaProdD.cpros)
1789:                 ENDIF
1790: 
1791:                 IF USED("cursor_4c_BuscaProdD")
1792:                     USE IN cursor_4c_BuscaProdD
1793:                 ENDIF
1794: 
1795:                 loc_oBusca.Release()
1796:             ENDIF
1797: 
1798:             IF !EMPTY(loc_cCPros)
1799:                 THIS.CarregarDadosProduto(loc_cCPros)
1800:             ENDIF
1801:         CATCH TO loc_oErro
1802:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupProdutoDescricao")
1803:         ENDTRY
1804:     ENDPROC
1805: 
1806:     PROCEDURE ProdutoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1807:         IF THIS.this_cModoAtual = "INCLUIR" AND par_nKeyCode = 115
1808:             THIS.AbrirLookupProdutoDescricao()
1809:         ENDIF
1810:     ENDPROC
1811: 
1812:     PROCEDURE ProdutoDescDblClick()
1813:         IF THIS.this_cModoAtual = "INCLUIR"
1814:             THIS.AbrirLookupProdutoDescricao()
1815:         ENDIF
1816:     ENDPROC
1817: 
1818:     *==========================================================================
1819:     * AbrirLookupEmpresa - FormBuscaAuxiliar em SigCdEmp por Cemps
1820:     * Substitui fAcessoEmpresa() (funcao do framework legado nao portada)
1821:     *==========================================================================
1822:     PROTECTED PROCEDURE AbrirLookupEmpresa()
1823:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
1824:             RETURN
1825:         ENDIF
1826: 
1827:         LOCAL loc_oBusca, loc_cCemps, loc_cValorAtual
1828:         loc_cCemps      = ""
1829:         loc_cValorAtual = ""
1830: 
1831:         TRY
1832:             loc_cValorAtual = ALLTRIM(CrSigCdMin.emps)
1833: 
1834:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1835:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValorAtual, ;
1836:                 "Buscar Empresa")
1837: 
1838:             IF VARTYPE(loc_oBusca) = "O"
1839:                 IF !loc_oBusca.this_lAchouRegistro
1840:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1841:                     loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1842:                     loc_oBusca.Show()
1843:                 ENDIF
1844: 
1845:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1846:                     loc_cCemps = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1847:                 ENDIF
1848: 
1849:                 IF USED("cursor_4c_BuscaEmp")
1850:                     USE IN cursor_4c_BuscaEmp
1851:                 ENDIF
1852: 
1853:                 loc_oBusca.Release()
1854:             ENDIF
1855: 
1856:             IF !EMPTY(loc_cCemps)
1857:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
1858:                     REPLACE CrSigCdMin.emps WITH loc_cCemps
1859:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
1860:                 ENDIF
1861:             ENDIF
1862:         CATCH TO loc_oErro
1863:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupEmpresa")
1864:         ENDTRY
1865:     ENDPROC
1866: 
1867:     PROCEDURE EmpColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1868:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1869:             THIS.AbrirLookupEmpresa()
1870:         ENDIF
1871:     ENDPROC
1872: 
1873:     PROCEDURE EmpColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1874:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
1875:             RETURN
1876:         ENDIF
1877: 
1878:         TRY
1879:             LOCAL loc_cEmps, loc_nRes
1880:             loc_cEmps = ALLTRIM(CrSigCdMin.emps)
1881: 
1882:             IF !EMPTY(loc_cEmps)
1883:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1884:                     "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps), ;
1885:                     "cursor_4c_ValEmp")
1886: 
1887:                 IF loc_nRes <= 0 OR !USED("cursor_4c_ValEmp") OR RECCOUNT("cursor_4c_ValEmp") = 0
1888:                     MsgAviso("Empresa '" + loc_cEmps + "' n" + CHR(227) + "o encontrada.", "Empresa")
1889:                     IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
1890:                         REPLACE CrSigCdMin.emps WITH ""
1891:                     ENDIF
1892:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
1893:                 ENDIF
1894: 
1895:                 IF USED("cursor_4c_ValEmp")
1896:                     USE IN cursor_4c_ValEmp
1897:                 ENDIF
1898:             ENDIF
1899:         CATCH TO loc_oErro
1900:             MsgErro(loc_oErro.Message, "FormEmn.EmpColLostFocus")
1901:         ENDTRY
1902:     ENDPROC
1903: 
1904:     PROCEDURE QtdeColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1905:         TRY
1906:             IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
1907:                 IF CrSigCdMin.qmins < 0
1908:                     MsgAviso("Quantidade m" + CHR(237) + "nima n" + CHR(227) + "o pode ser negativa.", "Quantidade")
1909:                     REPLACE CrSigCdMin.qmins WITH 0
1910:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
1911:                 ENDIF
1912:             ENDIF
1913:         CATCH TO loc_oErro
1914:             MsgErro(loc_oErro.Message, "FormEmn.QtdeColLostFocus")
1915:         ENDTRY
1916:     ENDPROC
1917: 
1918:     *==========================================================================
1919:     * AbrirLookupTamanho - FormBuscaAuxiliar em SigCdTam por cods/descs
1920:     *==========================================================================
1921:     PROTECTED PROCEDURE AbrirLookupTamanho()
1922:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
1923:             RETURN
1924:         ENDIF
1925: 
1926:         LOCAL loc_oBusca, loc_cCods, loc_cValorAtual
1927:         loc_cCods       = ""
1928:         loc_cValorAtual = ""
1929: 
1930:         TRY
1931:             loc_cValorAtual = ALLTRIM(CrSigCdMin.codtams)
1932: 
1933:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1934:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValorAtual, ;
1935:                 "Buscar Tamanho")
1936: 
1937:             IF VARTYPE(loc_oBusca) = "O"
1938:                 IF !loc_oBusca.this_lAchouRegistro
1939:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
1940:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1941:                     loc_oBusca.Show()
1942:                 ENDIF
1943: 
1944:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
1945:                     loc_cCods = ALLTRIM(cursor_4c_BuscaTam.cods)
1946:                 ENDIF
1947: 
1948:                 IF USED("cursor_4c_BuscaTam")
1949:                     USE IN cursor_4c_BuscaTam
1950:                 ENDIF
1951: 
1952:                 loc_oBusca.Release()
1953:             ENDIF
1954: 
1955:             IF !EMPTY(loc_cCods)
1956:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
1957:                     REPLACE CrSigCdMin.codtams WITH loc_cCods
1958:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
1959:                 ENDIF
1960:             ENDIF
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupTamanho")
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966:     PROCEDURE TamanhoColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1967:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1968:             THIS.AbrirLookupTamanho()
1969:         ENDIF
1970:     ENDPROC
1971: 
1972:     PROCEDURE TamanhoColDblClick()
1973:         THIS.AbrirLookupTamanho()
1974:     ENDPROC
1975: 
1976:     *==========================================================================
1977:     * AbrirLookupCor - FormBuscaAuxiliar em SigCdCor por cods/descs
1978:     *==========================================================================
1979:     PROTECTED PROCEDURE AbrirLookupCor()
1980:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
1981:             RETURN
1982:         ENDIF
1983: 
1984:         LOCAL loc_oBusca, loc_cCods, loc_cValorAtual
1985:         loc_cCods       = ""
1986:         loc_cValorAtual = ""
1987: 
1988:         TRY
1989:             loc_cValorAtual = ALLTRIM(CrSigCdMin.codcores)
1990: 
1991:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1992:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValorAtual, ;
1993:                 "Buscar Cor")
1994: 
1995:             IF VARTYPE(loc_oBusca) = "O"
1996:                 IF !loc_oBusca.this_lAchouRegistro
1997:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
1998:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1999:                     loc_oBusca.Show()
2000:                 ENDIF
2001: 
2002:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
2003:                     loc_cCods = ALLTRIM(cursor_4c_BuscaCor.cods)
2004:                 ENDIF
2005: 
2006:                 IF USED("cursor_4c_BuscaCor")
2007:                     USE IN cursor_4c_BuscaCor
2008:                 ENDIF
2009: 
2010:                 loc_oBusca.Release()
2011:             ENDIF
2012: 
2013:             IF !EMPTY(loc_cCods)
2014:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
2015:                     REPLACE CrSigCdMin.codcores WITH loc_cCods
2016:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
2017:                 ENDIF
2018:             ENDIF
2019:         CATCH TO loc_oErro
2020:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupCor")
2021:         ENDTRY
2022:     ENDPROC
2023: 
2024:     PROCEDURE CorColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2025:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2026:             THIS.AbrirLookupCor()
2027:         ENDIF
2028:     ENDPROC
2029: 
2030:     PROCEDURE CorColDblClick()
2031:         THIS.AbrirLookupCor()
2032:     ENDPROC
2033: 
2034:     *==========================================================================
2035:     * AbrirLookupGrupo - FormBuscaAuxiliar em SigCdGcr por Codigos/Descrs
2036:     * Substitui fAcessoContab() (funcao do framework legado nao portada)
2037:     *==========================================================================
2038:     PROTECTED PROCEDURE AbrirLookupGrupo()
2039:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2040:             RETURN
2041:         ENDIF
2042: 
2043:         LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual
2044:         loc_cCodigos    = ""
2045:         loc_cValorAtual = ""
2046: 
2047:         TRY
2048:             loc_cValorAtual = ALLTRIM(CrSigCdMin.grupos)
2049: 
2050:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2051:                 "SigCdGcr", "cursor_4c_BuscaGrp", "Codigos", loc_cValorAtual, ;
2052:                 "Buscar Grupo")
2053: 
2054:             IF VARTYPE(loc_oBusca) = "O"
2055:                 IF !loc_oBusca.this_lAchouRegistro
2056:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2057:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2058:                     loc_oBusca.Show()
2059:                 ENDIF
2060: 
2061:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
2062:                     loc_cCodigos = ALLTRIM(cursor_4c_BuscaGrp.Codigos)
2063:                 ENDIF
2064: 
2065:                 IF USED("cursor_4c_BuscaGrp")
2066:                     USE IN cursor_4c_BuscaGrp
2067:                 ENDIF
2068: 
2069:                 loc_oBusca.Release()
2070:             ENDIF
2071: 
2072:             IF !EMPTY(loc_cCodigos)
2073:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
2074:                     REPLACE CrSigCdMin.grupos WITH loc_cCodigos
2075:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
2076:                 ENDIF
2077:             ENDIF
2078:         CATCH TO loc_oErro
2079:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupGrupo")
2080:         ENDTRY
2081:     ENDPROC
2082: 
2083:     PROCEDURE GrupoColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2084:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2085:             THIS.AbrirLookupGrupo()
2086:         ENDIF
2087:     ENDPROC
2088: 
2089:     PROCEDURE GrupoColDblClick()
2090:         THIS.AbrirLookupGrupo()
2091:     ENDPROC
2092: 
2093:     *==========================================================================
2094:     * AbrirLookupConta - FormBuscaAuxiliar em SigCdCli por iclis/rclis
2095:     * Substitui fAcessoContas() (funcao do framework legado nao portada)
2096:     *==========================================================================
2097:     PROTECTED PROCEDURE AbrirLookupConta()
2098:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2099:             RETURN
2100:         ENDIF
2101: 
2102:         LOCAL loc_oBusca, loc_cIclis, loc_cValorAtual
2103:         loc_cIclis      = ""
2104:         loc_cValorAtual = ""
2105: 
2106:         TRY
2107:             loc_cValorAtual = ALLTRIM(CrSigCdMin.contas)
2108: 
2109:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2110:                 "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValorAtual, ;
2111:                 "Buscar Conta")
2112: 
2113:             IF VARTYPE(loc_oBusca) = "O"
2114:                 IF !loc_oBusca.this_lAchouRegistro
2115:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
2116:                     loc_oBusca.mAddColuna("rclis", "", "Raz" + CHR(227) + "o Social")
2117:                     loc_oBusca.Show()
2118:                 ENDIF
2119: 
2120:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2121:                     loc_cIclis = ALLTRIM(cursor_4c_BuscaCli.iclis)
2122:                 ENDIF
2123: 
2124:                 IF USED("cursor_4c_BuscaCli")
2125:                     USE IN cursor_4c_BuscaCli
2126:                 ENDIF
2127: 
2128:                 loc_oBusca.Release()
2129:             ENDIF
2130: 
2131:             IF !EMPTY(loc_cIclis)
2132:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
2133:                     REPLACE CrSigCdMin.contas WITH loc_cIclis
2134:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
2135:                 ENDIF
2136:             ENDIF
2137:         CATCH TO loc_oErro
2138:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupConta")
2139:         ENDTRY
2140:     ENDPROC
2141: 
2142:     PROCEDURE ContaColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2143:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2144:             THIS.AbrirLookupConta()
2145:         ENDIF
2146:     ENDPROC
2147: 
2148:     PROCEDURE ContaColDblClick()
2149:         THIS.AbrirLookupConta()
2150:     ENDPROC
2151: 
2152:     *==========================================================================
2153:     * AbrirLookupLocal - FormBuscaAuxiliar em SigPrLcl (filtro Tipos=3)
2154:     *==========================================================================
2155:     PROTECTED PROCEDURE AbrirLookupLocal()
2156:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2157:             RETURN
2158:         ENDIF
2159: 
2160:         LOCAL loc_oBusca, loc_cCodigos, loc_cValorAtual
2161:         loc_cCodigos    = ""
2162:         loc_cValorAtual = ""
2163: 
2164:         TRY
2165:             loc_cValorAtual = ALLTRIM(CrSigCdMin.locals)
2166: 
2167:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2168:                 "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValorAtual, ;
2169:                 "Buscar Local", .F., .T., "Tipos = 3")
2170: 
2171:             IF VARTYPE(loc_oBusca) = "O"
2172:                 IF !loc_oBusca.this_lAchouRegistro
2173:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
2174:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2175:                     loc_oBusca.Show()
2176:                 ENDIF
2177: 
2178:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
2179:                     loc_cCodigos = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
2180:                 ENDIF
2181: 
2182:                 IF USED("cursor_4c_BuscaLcl")
2183:                     USE IN cursor_4c_BuscaLcl
2184:                 ENDIF
2185: 
2186:                 loc_oBusca.Release()
2187:             ENDIF
2188: 
2189:             IF !EMPTY(loc_cCodigos)
2190:                 IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
2191:                     REPLACE CrSigCdMin.locals WITH loc_cCodigos
2192:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
2193:                 ENDIF
2194:             ENDIF
2195:         CATCH TO loc_oErro
2196:             MsgErro(loc_oErro.Message, "FormEmn.AbrirLookupLocal")
2197:         ENDTRY
2198:     ENDPROC
2199: 
2200:     PROCEDURE LocalColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2201:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2202:             THIS.AbrirLookupLocal()
2203:         ENDIF
2204:     ENDPROC
2205: 
2206:     PROCEDURE LocalColDblClick()
2207:         THIS.AbrirLookupLocal()
2208:     ENDPROC
2209: 
2210:     PROCEDURE LocalColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2211:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2212:             RETURN
2213:         ENDIF
2214: 
2215:         TRY
2216:             IF !EMPTY(ALLTRIM(CrSigCdMin.emps)) AND !EMPTY(ALLTRIM(CrSigCdMin.locals))
2217:                 LOCAL loc_lTemVazia
2218:                 loc_lTemVazia = .F.
2219: 
2220:                 SELECT CrSigCdMin
2221:                 SCAN FOR !DELETED()
2222:                     IF EMPTY(ALLTRIM(CrSigCdMin.emps))
2223:                         loc_lTemVazia = .T.
2224:                         EXIT
2225:                     ENDIF
2226:                 ENDSCAN
2227: 
2228:                 IF !loc_lTemVazia
2229:                     THIS.AdicionarLinhaGrid()
2230:                 ENDIF
2231:             ENDIF
2232:         CATCH TO loc_oErro
2233:             MsgErro(loc_oErro.Message, "FormEmn.LocalColLostFocus")
2234:         ENDTRY
2235:     ENDPROC
2236: 
2237:     PROCEDURE QIdealColLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2238:         TRY
2239:             IF USED("CrSigCdMin") AND !EOF("CrSigCdMin")
2240:                 IF CrSigCdMin.qideal < 0
2241:                     MsgAviso("Estoque Alvo n" + CHR(227) + "o pode ser negativo.", "Estoque Alvo")
2242:                     REPLACE CrSigCdMin.qideal WITH 0
2243:                     THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI.Refresh()
2244:                 ENDIF
2245:             ENDIF
2246:         CATCH TO loc_oErro
2247:             MsgErro(loc_oErro.Message, "FormEmn.QIdealColLostFocus")
2248:         ENDTRY
2249:     ENDPROC
2250: 
2251:     *==========================================================================
2252:     * GradeIAfterRowColChange - Atualiza flags de coluna e OptRetiras ao mudar linha
2253:     *==========================================================================
2254:     PROCEDURE GradeIAfterRowColChange(par_nColIndex)
2255: 
2256:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2257:             RETURN
2258:         ENDIF
2259: 
2260:         TRY
2261:             LOCAL loc_oGrid, loc_oPg2, loc_oBO, loc_nRetiras
2262:             loc_oBO   = THIS.this_oBusinessObject
2263:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.grd_4c_GradeI
2264:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
2265: 
2266:             *-- Manter ReadOnly de Tamanho/Cor conforme flags do produto
2267:             loc_oGrid.Column3.ReadOnly = !loc_oBO.this_lTemTam
2268:             loc_oGrid.Column4.ReadOnly = !loc_oBO.this_lTemCor
2269: 
2270:             *-- Sincronizar OptionGroup Retiravel com linha corrente
2271:             loc_nRetiras = TratarNulo(CrSigCdMin.retiras, "N")
2272:             IF loc_nRetiras < 1 OR loc_nRetiras > 3
2273:                 loc_nRetiras = 3
2274:             ENDIF
2275:             loc_oPg2.obj_4c_OptRetiras.Value = loc_nRetiras
2276: 
2277:             *-- Habilitar excluir linha apenas se empresa preenchida e modo edicao
2278:             loc_oPg2.cmd_4c_BtnExcluir.Enabled = ;
2279:                 (!EMPTY(ALLTRIM(CrSigCdMin.emps)) AND THIS.this_cModoAtual <> "VISUALIZAR")
2280:         CATCH TO loc_oErro
2281:             MsgErro(loc_oErro.Message, "FormEmn.GradeIAfterRowColChange")
2282:         ENDTRY
2283:     ENDPROC
2284: 
2285:     *==========================================================================
2286:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2287:     *==========================================================================
2288:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2289:         TRY
2290:             LOCAL loc_oPg1, loc_oPg2, loc_lEdicao
2291:             loc_oPg1    = THIS.pgf_4c_Paginas.Page1
2292:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2293:             loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2294: 
2295:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
2296:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
2297:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
2298:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
2299:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
2300: 
2301:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
2302:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
2303:             loc_oPg2.cmd_4c_BtnExcluir.Visible             = loc_lEdicao
2304: 
2305:             THIS.HabilitarCampos(loc_lEdicao)
2306:         CATCH TO loc_oErro
2307:             MsgErro(loc_oErro.Message, "FormEmn.AjustarBotoesPorModo")
2308:         ENDTRY
2309:     ENDPROC
2310: 
2311:     *==========================================================================
2312:     * BtnExcluirLinhaClick - Exclui a linha corrente do cursor CrSigCdMin
2313:     *==========================================================================
2314:     PROCEDURE BtnExcluirLinhaClick()
2315:         IF !USED("CrSigCdMin") OR EOF("CrSigCdMin")
2316:             RETURN
2317:         ENDIF
2318:         IF EMPTY(ALLTRIM(CrSigCdMin.emps))
2319:             RETURN
2320:         ENDIF
2321: 
2322:         TRY
2323:             LOCAL loc_lConfirma
2324:             loc_lConfirma = MsgConfirma("Excluir esta linha da grade?", "Excluir Linha")
2325: 
2326:             IF loc_lConfirma
2327:                 SELECT CrSigCdMin
2328:                 DELETE
2329:                 PACK
2330:                 THIS.ConfigurarRecordSourceGrid()
2331:             ENDIF
2332:         CATCH TO loc_oErro
2333:             MsgErro(loc_oErro.Message, "FormEmn.BtnExcluirLinhaClick")
2334:         ENDTRY
2335:     ENDPROC
2336: 
2337: ENDDEFINE


### BO (C:\4c\projeto\app\classes\EmnBO.prg):
*==============================================================================
* EmnBO.prg - Business Object para Estoque Alvo (Minimo por Produto/Empresa)
* Tabela: SigCdMin
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS EmnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades do cabecalho do produto (SigCdPro + lookups)
    *--------------------------------------------------------------------------
    this_cCPros     = ""    && Codigo do produto          char(14)
    this_cDPros     = ""    && Descricao do produto
    this_cCGrus     = ""    && Codigo do grupo do produto
    this_cDGrus     = ""    && Descricao do grupo do produto
    this_cIFors     = ""    && Codigo do fornecedor
    this_cRClis     = ""    && Razao social do fornecedor
    this_cReffs     = ""    && Referencia do fornecedor
    this_nQMins     = 0     && Quantidade minima geral   numeric(8,2)
    this_nSituas    = 1     && Situacao: 1=Ativo, 2=Inativo

    *--------------------------------------------------------------------------
    * Propriedades de um item do grid (linha de SigCdMin)
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && Chave unica / PRIMARY KEY  char(20)
    this_cEmps      = ""    && Empresa                    char(3)
    this_cLocals    = ""    && Local                      char(10)
    this_nQMinsItem = 0     && Quantidade minima          numeric(8,2)
    this_cCodTams   = ""    && Codigo do tamanho          char(4)
    this_cCodCores  = ""    && Codigo da cor              char(4)
    this_cOrdems    = ""    && Ordem                      char(1)
    this_cContas    = ""    && Conta                      char(10)
    this_cGrupos    = ""    && Grupo                      char(10)
    this_nQIdeal    = 0     && Quantidade ideal            numeric(7,2)
    this_nRetiras   = 1     && Retiravel: 1=Sim, 2=Nao, 3=Produto  numeric(1,0)
    this_nPIdeal    = 0     && Preco ideal                numeric(7,3)
    this_nPMins     = 0     && Preco minimo               numeric(7,3)

    *--------------------------------------------------------------------------
    * Flags de produto (determinam habilitacao de colunas na grade)
    *--------------------------------------------------------------------------
    this_lTemCor    = .F.   && Produto tem variacoes de cor
    this_lTemTam    = .F.   && Produto tem variacoes de tamanho
    this_nTipoEstos = 0     && Tipo de estoque do grupo do produto

    *--------------------------------------------------------------------------
    * Controle de modo externo (form chamado por outro form)
    *--------------------------------------------------------------------------
    this_cProdutoExterno = ""   && Codigo do produto fixado externamente
    this_cModoExterno    = ""   && Modo de operacao externo (INSERIR/ALTERAR)

    *--------------------------------------------------------------------------
    * Cursor principal do grid (preserva nome legado para compatibilidade)
    *--------------------------------------------------------------------------
    this_cCursorGrid  = "CrSigCdMin"   && Cursor do grid de minimos por empresa
    this_cCursorLista = "CrProdutos"   && Cursor da lista de produtos (Page1)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMin"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico usando NEWID() do SQL Server
    *==========================================================================
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRes
        loc_cChave = ""

        TRY
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CONVERT(varchar(36),NEWID()),'-',''),20) AS id", ;
                "cursor_4c_NewId")
            IF loc_nRes > 0 AND USED("cursor_4c_NewId") AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                GO TOP
                loc_cChave = ALLTRIM(cursor_4c_NewId.id)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.GerarChaveUnica")
        ENDTRY

        IF USED("cursor_4c_NewId")
            USE IN cursor_4c_NewId
        ENDIF

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(DTOS(DATE()) + STRTRAN(TRANSFORM(SECONDS()), ".", "") + SYS(2015), 20)
        ENDIF

        RETURN loc_cChave
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor de SigCdMin
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                THIS.this_cCPros     = TratarNulo(cpros,     "C")
                THIS.this_cEmps      = TratarNulo(emps,      "C")
                THIS.this_cLocals    = TratarNulo(locals,    "C")
                THIS.this_nQMinsItem = TratarNulo(qmins,     "N")
                THIS.this_cCodTams   = TratarNulo(codtams,   "C")
                THIS.this_cCodCores  = TratarNulo(codcores,  "C")
                THIS.this_cOrdems    = TratarNulo(ordems,    "C")
                THIS.this_cContas    = TratarNulo(contas,    "C")
                THIS.this_cGrupos    = TratarNulo(grupos,    "C")
                THIS.this_nQIdeal    = TratarNulo(qideal,    "N")
                THIS.this_nRetiras   = TratarNulo(retiras,   "N")
                THIS.this_nPIdeal    = TratarNulo(pideal,    "N")
                THIS.this_nPMins     = TratarNulo(pmins,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista produtos que possuem estoque alvo configurado
    *          Retorna cursor CrProdutos para a grade da Page1
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrProdutos")
            USE IN CrProdutos
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = loc_cSQL + " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrProdutos")

            IF loc_nRes > 0
                SELECT CrProdutos
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "EmnBO.Buscar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarItens - Carrega grid de itens para um produto especifico
    *               Retorna cursor CrSigCdMin (com colunas do JOIN)
    *               Tambem cria CsCabec e seta flags lTemCor/lTemTam
    *==========================================================================
    PROCEDURE BuscarItens(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        IF USED("CrSigCdMin")
            USE IN CrSigCdMin
        ENDIF
        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, a.emps, a.locals, a.qmins, a.codtams, a.codcores," + ;
                " a.ordems, a.cidchaves, a.contas, a.grupos, a.qideal, a.retiras," + ;
                " a.pideal, a.pmins," + ;
                " b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " ORDER BY a.emps, a.codtams, a.codcores"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CrSigCdMin")

            IF loc_nRes > 0
                SELECT CrSigCdMin
                GO TOP

                *-- Criar CsCabec com dados de cabecalho do produto
                THIS.CarregarCabecalho()

                *-- Atualizar flags de cor/tamanho
                THIS.BuscarFlags(par_cCPros)

                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do produto: " + CapturarErroSQL(), "EmnBO.BuscarItens")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarItens")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarFlags - Carrega flags lTemCor/lTemTam de SigCdPro x SigCdGrp
    *==========================================================================
    PROCEDURE BuscarFlags(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        THIS.this_lTemCor    = .F.
        THIS.this_lTemTam    = .F.
        THIS.this_nTipoEstos = 0

        IF EMPTY(ALLTRIM(par_cCPros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                " FROM SigCdPro a" + ;
                " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Flags")

            IF loc_nRes > 0 AND USED("cursor_4c_Flags") AND RECCOUNT("cursor_4c_Flags") > 0
                SELECT cursor_4c_Flags
                GO TOP
                THIS.this_nTipoEstos = TratarNulo(tipoestos, "N")
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 4) OR (TratarNulo(cores, "N") = 1)
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 3, 4) OR (TratarNulo(tams,  "N") = 1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.BuscarFlags")
        ENDTRY

        IF USED("cursor_4c_Flags")
            USE IN cursor_4c_Flags
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Cria cursor CsCabec com dados de cabecalho do produto
    *                     a partir do CrSigCdMin ja carregado
    *==========================================================================
    PROTECTED PROCEDURE CarregarCabecalho()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED("CsCabec")
            USE IN CsCabec
        ENDIF

        TRY
            IF USED("CrSigCdMin") AND RECCOUNT("CrSigCdMin") > 0
                SELECT DISTINCT cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas ;
                    FROM CrSigCdMin ;
                    INTO CURSOR CsCabec READWRITE
                GO TOP IN CsCabec
            ELSE
                CREATE CURSOR CsCabec ( ;
                    cpros    C(14), dpros C(65), cgrus  C(3), ;
                    dgrus    C(20), ifors C(10), rclis  C(50), ;
                    reffs    C(20), qmins N(8,2), qideal N(7,2), ;
                    situas   N(1,0))
                INSERT INTO CsCabec (cpros, dpros, cgrus, dgrus, ifors, rclis, reffs, qmins, qideal, situas) ;
                    VALUES (SPACE(14), SPACE(65), SPACE(3), SPACE(20), SPACE(10), SPACE(50), SPACE(20), 0, 0, 1)
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega propriedades de cabecalho para um produto
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCPros))
                loc_lResultado = .F.
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas," + ;
                " c.rclis, g.dgrus, a.qmins, a.qideal" + ;
                " FROM SigCdMin a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = b.ifors" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = b.cgrus" + ;
                " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.cgrus, b.situas, c.rclis, g.dgrus, a.qmins, a.qideal"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabec")

            IF loc_nRes > 0 AND USED("cursor_4c_Cabec") AND RECCOUNT("cursor_4c_Cabec") > 0
                SELECT cursor_4c_Cabec
                GO TOP
                THIS.this_cCPros    = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros    = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cIFors    = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cReffs    = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_cCGrus    = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_nSituas   = TratarNulo(situas, "N")
                THIS.this_cRClis    = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cDGrus    = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_nQMins    = TratarNulo(qmins,  "N")
                THIS.this_nQIdeal   = TratarNulo(qideal, "N")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Cabec")
            USE IN cursor_4c_Cabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarGrid - Salva todos os itens do grid no SQL Server
    *              Estrategia: DELETE todos os itens do produto, INSERT novos
    *              Apenas linhas com emps preenchido sao salvas
    *==========================================================================
    PROTECTED PROCEDURE SalvarGrid(par_cCPros)
        LOCAL loc_lResultado, loc_nRes, loc_lTransacao
        LOCAL loc_cSQL, loc_cCidChaves
        loc_lResultado = .F.
        loc_lTransacao = .F.

        IF EMPTY(ALLTRIM(par_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido para SalvarGrid.")
            RETURN .F.
        ENDIF

        IF !USED("CrSigCdMin")
            MsgErro("Cursor CrSigCdMin n" + CHR(227) + "o encontrado.", "EmnBO.SalvarGrid")
            RETURN .F.
        ENDIF

        TRY
            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            *-- Deletar todos os registros existentes para este produto
            loc_nRes = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
                "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nRes < 0
                MsgErro("Erro ao excluir registros antigos: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
            ELSE
                *-- Inserir linhas validas do cursor local
                loc_lResultado = .T.
                SELECT CrSigCdMin
                GO TOP

                SCAN FOR !DELETED()
                    IF !EMPTY(ALLTRIM(CrSigCdMin.emps))
                        *-- Gerar cidchaves se necessario
                        loc_cCidChaves = ALLTRIM(CrSigCdMin.cidchaves)
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF

                        loc_cSQL = "INSERT INTO SigCdMin" + ;
                            " (cpros, emps, locals, qmins, codtams, codcores," + ;
                            " ordems, cidchaves, contas, grupos, qideal, retiras, pideal, pmins)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.cpros))    + ", " + ;
                            EscaparSQL(ALLTRIM(CrSigCdMin.emps))     + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.locals),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qmins)      + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codtams),   4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.codcores),  4)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.ordems),    1)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCidChaves,               20)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.contas),   10)) + ", " + ;
                            EscaparSQL(LEFT(ALLTRIM(CrSigCdMin.grupos),   10)) + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.qideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.retiras)    + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pideal)     + ", " + ;
                            FormatarNumeroSQL(CrSigCdMin.pmins)      + ;
                            ")"

                        loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nRes < 0
                            MsgErro("Erro ao inserir item: " + CapturarErroSQL(), "EmnBO.SalvarGrid")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    THIS.RegistrarAuditoria("SAVE")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo), "EmnBO.SalvarGrid")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Chamado pelo BusinessBase.Salvar() para novo produto
    *           Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Chamado pelo BusinessBase.Salvar() para produto existente
    *             Delega para SalvarGrid
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.SalvarGrid(THIS.this_cCPros)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui TODOS os itens SigCdMin de um produto
    *                    Chamado via BusinessBase.Excluir()
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCPros))
                MsgAviso("C" + CHR(243) + "digo do produto inv" + CHR(225) + "lido.")
            ELSE
                loc_cSQL = "DELETE FROM SigCdMin WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Exc")

                IF USED("cursor_4c_Exc")
                    USE IN cursor_4c_Exc
                ENDIF

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir: " + CapturarErroSQL(), "EmnBO.ExecutarExclusao")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ProcessarCopia - Cria cursor CsCopia com comparacao de itens entre empresas
    *                  Cores Vermelho(0/naoexiste-dest) Preto(0/existe) Azul(2/naoexiste-orig)
    *==========================================================================
    PROCEDURE ProcessarCopia(par_cEmpO, par_cEmpD, par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cFiltroO, loc_cFiltroD, loc_cFiltroProd
        loc_lResultado = .F.

        IF USED("CsCopia")
            USE IN CsCopia
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresas Origem e Destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias.", "EmnBO.ProcessarCopia")
            ELSE
                loc_cFiltroO   = EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))
                loc_cFiltroD   = EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))
                loc_cFiltroProd = ""
                IF !EMPTY(ALLTRIM(par_cCPros))
                    loc_cFiltroProd = " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCPros), 14))
                ENDIF

                *-- Itens que existem na Origem mas NAO no Destino (marcas=1, existes=0)
                loc_cSQL = "SELECT CAST(1 AS int) AS marcas, CAST(0 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND (a.cpros + a.codtams + a.codcores) NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(1 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroO + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroD + ")" + ;
                    " UNION ALL" + ;
                    " SELECT CAST(0 AS int) AS marcas, CAST(2 AS int) AS existes," + ;
                    " a.cpros, a.emps, a.locals, a.qmins, a.qideal, a.codtams, a.codcores," + ;
                    " a.cidchaves, a.grupos, a.contas" + ;
                    " FROM SigCdMin a" + ;
                    " WHERE a.emps = " + loc_cFiltroD + loc_cFiltroProd + ;
                    " AND a.cpros + a.codtams + a.codcores NOT IN" + ;
                    " (SELECT b.cpros + b.codtams + b.codcores FROM SigCdMin b WHERE b.emps = " + loc_cFiltroO + ")"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "CsCopia")

                IF loc_nRes > 0
                    SELECT CsCopia
                    GO TOP
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao processar c" + CHR(243) + "pia: " + CapturarErroSQL(), "EmnBO.ProcessarCopia")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.ProcessarCopia")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CopiarItens - Copia itens marcados de CsCopia para empresa destino
    *               Apenas linhas marcas=1 E existes=0 sao copiadas
    *==========================================================================
    PROCEDURE CopiarItens(par_cEmpD)
        LOCAL loc_lResultado, loc_nRes, loc_nCopias, loc_nTotal
        LOCAL loc_cSQL, loc_cCidChaves, loc_lTransacao
        loc_lResultado = .F.
        loc_nCopias    = 0
        loc_nTotal     = 0
        loc_lTransacao = .F.

        TRY
            IF !USED("CsCopia") OR RECCOUNT("CsCopia") = 0
                MsgErro("Cursor CsCopia vazio. Execute ProcessarCopia primeiro.", "EmnBO.CopiarItens")
            ELSE
                IF EMPTY(ALLTRIM(par_cEmpD))
                MsgErro("Empresa Destino inv" + CHR(225) + "lida.", "EmnBO.CopiarItens")
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacao = .T.
                loc_lResultado = .T.

                SELECT CsCopia
                COUNT FOR !DELETED() TO loc_nTotal
                GO TOP

                SCAN FOR !DELETED() AND CsCopia.marcas = 1 AND CsCopia.existes = 0
                    loc_cCidChaves = THIS.GerarChaveUnica()

                    loc_cSQL = "INSERT INTO SigCdMin" + ;
                        " (cpros, emps, locals, qmins, qideal, codtams, codcores," + ;
                        " cidchaves, contas, grupos, ordems, retiras, pideal, pmins)" + ;
                        " VALUES (" + ;
                        EscaparSQL(ALLTRIM(CsCopia.cpros))               + ", " + ;
                        EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))          + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.locals),  10))   + ", " + ;
                        FormatarNumeroSQL(CsCopia.qmins)                 + ", " + ;
                        FormatarNumeroSQL(CsCopia.qideal)                + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codtams), 4))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.codcores), 4))   + ", " + ;
                        EscaparSQL(LEFT(loc_cCidChaves, 20))             + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.contas), 10))    + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(CsCopia.grupos), 10))    + ", " + ;
                        "' ', 1, 0, 0)"

                    loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
                    IF USED("cursor_4c_Copia")
                        USE IN cursor_4c_Copia
                    ENDIF

                    IF loc_nRes >= 0
                        loc_nCopias = loc_nCopias + 1
                    ELSE
                        MsgErro("Erro ao copiar item: " + CapturarErroSQL(), "EmnBO.CopiarItens")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lResultado
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    loc_lTransacao = .F.
                    MsgInfo("Foram copiados " + TRANSFORM(loc_nCopias) + " de " + ;
                        TRANSFORM(loc_nTotal) + " registros.")
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacao = .F.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "EmnBO.CopiarItens")
            loc_lResultado = .F.
        ENDTRY

        IF loc_lTransacao
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

