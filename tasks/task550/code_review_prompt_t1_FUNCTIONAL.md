# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [BINDEVENT-PARAMS] Handler 'OCodigoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE OCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ONomeLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ONomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DCodigoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DNomeLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'CfoLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CfoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarBuscaUf()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'UF Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'UF Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Aliq. ICMS' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Aliq.Sub.Trib' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Aliq.Prod.Importado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Aliq.FECP' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Aliq.Reducao Base' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'IE Subst.Trib.Dest.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Classificação, Aliq Local, Aliq FCP, Aliq Icms, CST, C Benef, CFOP. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUfd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1781 linhas total):

*-- Linhas 35 a 159:
35:     *===========================================================================
36:     * Init - Inicializa o formulario
37:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
38:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
39:     *===========================================================================
40:     PROCEDURE Init()
41:         RETURN DODEFAULT()
42:     ENDPROC
43: 
44:     *===========================================================================
45:     * InicializarForm - Configura estrutura completa
46:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
47:     *===========================================================================
48:     PROTECTED PROCEDURE InicializarForm()
49:         LOCAL loc_lSucesso
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             THIS.this_oBusinessObject = CREATEOBJECT("UfdBO")
54: 
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MostrarErro("Erro ao criar UfdBO" + CHR(13) + ;
57:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
58:                     "FormUfd.InicializarForm")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65:                 THIS.pgf_4c_Paginas.Visible = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual = "LISTA"
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 loc_lSucesso = .T.
74:             ENDIF
75: 
76:         CATCH TO loException
77:             MostrarErro("Erro ao inicializar FormUfd:" + CHR(13) + ;
78:                 loException.Message + CHR(13) + ;
79:                 "Linha: " + TRANSFORM(loException.LineNo), ;
80:                 "FormUfd.InicializarForm")
81:         ENDTRY
82: 
83:         RETURN loc_lSucesso
84:     ENDPROC
85: 
86:     *===========================================================================
87:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
88:     * Top=-29 para esconder abas; controles compensam +29 no Top
89:     *===========================================================================
90:     PROTECTED PROCEDURE ConfigurarPageFrame()
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92: 
93:         WITH THIS.pgf_4c_Paginas
94:             .PageCount = 2
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101: 
102:             .Page1.Caption   = "Lista"
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105: 
106:             .Page2.Caption   = "Dados"
107:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108:             .Page2.BackColor = RGB(255, 255, 255)
109:         ENDWITH
110: 
111:         THIS.ConfigurarPaginaLista()
112:         THIS.ConfigurarPaginaDados()
113:     ENDPROC
114: 
115:     *===========================================================================
116:     * ConfigurarPaginaLista - Estrutura completa de Page1 (Lista)
117:     * Cabecalho + Grid de 8 colunas (pColuna do legado) + Botoes CRUD + Saida
118:     *===========================================================================
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPagina
121:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
122: 
123:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
124: 
125:         *-- Container Cabecalho (cntSombra no legado)
126:         *-- Original: Top=1. Com compensacao +29: Top=31
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = THIS.Caption
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = THIS.Caption
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = 769

*-- Linhas 203 a 422:
203:             .AutoSize        = .F.
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
207: 
208:         *-- Botao Visualizar (Left=80)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
211:             .Caption         = "Visualizar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 80
216:             .Width           = 75
217:             .Height          = 75
218:             .FontName        = "Tahoma"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .ForeColor       = RGB(90, 90, 90)
223:             .BackColor       = RGB(255, 255, 255)
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
232: 
233:         *-- Botao Alterar (Left=155)
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
236:             .Caption         = "Alterar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .FontName        = "Tahoma"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .ForeColor       = RGB(90, 90, 90)
248:             .BackColor       = RGB(255, 255, 255)
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         *-- Botao Excluir (Left=230)
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
261:             .Caption         = "Excluir"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 230
266:             .Width           = 75
267:             .Height          = 75
268:             .FontName        = "Tahoma"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .FontSize        = 8
272:             .ForeColor       = RGB(90, 90, 90)
273:             .BackColor       = RGB(255, 255, 255)
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
282: 
283:         *-- Botao Buscar (Left=305)
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
286:             .Caption         = "Buscar"
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
288:             .PicturePosition = 13
289:             .Top             = 5
290:             .Left            = 305
291:             .Width           = 75
292:             .Height          = 75
293:             .FontName        = "Tahoma"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .ForeColor       = RGB(90, 90, 90)
298:             .BackColor       = RGB(255, 255, 255)
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
307: 
308:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado, CLAUDE.md regra #10)
309:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
310:         WITH loc_oPagina.cnt_4c_Saida
311:             .Top         = 29
312:             .Left        = 917
313:             .Width       = 90
314:             .Height      = 85
315:             .BackStyle   = 0
316:             .BorderWidth = 0
317:             .Visible     = .T.
318:         ENDWITH
319: 
320:         *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
321:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
322:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
323:             .Caption         = "Encerrar"
324:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
325:             .PicturePosition = 13
326:             .Top             = 5
327:             .Left            = 5
328:             .Width           = 75
329:             .Height          = 75
330:             .FontName        = "Tahoma"
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .FontSize        = 8
334:             .ForeColor       = RGB(90, 90, 90)
335:             .BackColor       = RGB(255, 255, 255)
336:             .Themes          = .F.
337:             .SpecialEffect   = 0
338:             .MousePointer    = 15
339:             .WordWrap        = .T.
340:             .AutoSize        = .F.
341:             .Visible         = .T.
342:         ENDWITH
343:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
344: 
345:         *-- Grid de listagem (Grade no legado - 8 colunas conforme pColuna)
346:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
347:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
348:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
349:         loc_oPagina.grd_4c_Lista.ColumnCount = 8
350:         WITH loc_oPagina.grd_4c_Lista
351:             .Top                = 117
352:             .Left               = 26
353:             .Width              = 880
354:             .Height             = 498
355:             .FontName           = "Verdana"
356:             .FontSize           = 8
357:             .ForeColor          = RGB(90, 90, 90)
358:             .BackColor          = RGB(255, 255, 255)
359:             .GridLineColor      = RGB(238, 238, 238)
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle     = 2
363:             .DeleteMark         = .F.
364:             .RecordMark         = .F.
365:             .RowHeight          = 16
366:             .ScrollBars         = 2
367:             .GridLines          = 3
368:             .Visible            = .T.
369:         ENDWITH
370:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
371: 
372:         THIS.TornarControlesVisiveis(loc_oPagina)
373:     ENDPROC
374: 
375:     *===========================================================================
376:     * CarregarLista - Carrega dados no grid da Page1
377:     * par_cFiltro (opcional) - clausula WHERE adicional (usado por BtnBuscarClick)
378:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
379:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
380:     * Colunas conforme pColuna do legado (comportamento.json / SIGCDUFD.Init)
381:     *===========================================================================
382:     PROCEDURE CarregarLista(par_cFiltro)
383:         LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
384:         loc_lResultado = .F.
385:         loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, "")
386: 
387:         TRY
388:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
389:                 loc_lResultado = .F.
390:             ELSE
391:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
392: 
393:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
394:                 loc_oGrid.ColumnCount = 8
395:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
396: 
397:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
398:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
399:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.destinos"
400:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aliqs"
401:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.aliqsbs"
402:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.aliqpimps"
403:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.aliqfcp"
404:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.aliqredb"
405:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.iest"
406: 
407:                 loc_oGrid.Column1.Width = 80
408:                 loc_oGrid.Column2.Width = 80
409:                 loc_oGrid.Column3.Width = 80
410:                 loc_oGrid.Column4.Width = 80
411:                 loc_oGrid.Column5.Width = 80
412:                 loc_oGrid.Column6.Width = 80
413:                 loc_oGrid.Column7.Width = 80
414:                 loc_oGrid.Column8.Width = 100
415: 
416:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
417:                 loc_oGrid.Column1.Header1.Caption = "UF Origem"
418:                 loc_oGrid.Column2.Header1.Caption = "UF Destino"
419:                 loc_oGrid.Column3.Header1.Caption = "Aliq. ICMS"
420:                 loc_oGrid.Column4.Header1.Caption = "Aliq.Sub.Trib"
421:                 loc_oGrid.Column5.Header1.Caption = "Aliq.Prod.Importado"
422:                 loc_oGrid.Column6.Header1.Caption = "Aliq.FECP"

*-- Linhas 446 a 534:
446:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
447:     * Ao voltar para Page1, recarrega a lista
448:     *===========================================================================
449:     PROCEDURE AlternarPagina(par_nPagina)
450:         LOCAL loc_lResultado
451:         loc_lResultado = .F.
452: 
453:         TRY
454:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
455:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
456:             ELSE
457:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
458: 
459:                 IF par_nPagina = 1
460:                     THIS.this_cModoAtual = "LISTA"
461:                     THIS.CarregarLista()
462:                 ENDIF
463: 
464:                 loc_lResultado = .T.
465:             ENDIF
466: 
467:         CATCH TO loException
468:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
469:                 "FormUfd.AlternarPagina")
470:         ENDTRY
471: 
472:         RETURN loc_lResultado
473:     ENDPROC
474: 
475:     *===========================================================================
476:     * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
477:     *===========================================================================
478:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
479:         TRY
480:             WITH par_oGrid
481:                 .FontName = "Tahoma"
482:                 .FontSize = 8
483:             ENDWITH
484:         CATCH TO loException
485:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
486:                 "FormUfd.FormatarGridLista")
487:         ENDTRY
488:     ENDPROC
489: 
490:     *===========================================================================
491:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
492:     * TextBoxes de campos serao adicionados nas proximas fases
493:     *===========================================================================
494:     PROTECTED PROCEDURE ConfigurarPaginaDados()
495:         LOCAL loc_oPagina
496:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
497: 
498:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
499: 
500:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
501:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
502:         WITH loc_oPagina.cnt_4c_Cabecalho
503:             .Top           = 29
504:             .Left          = 0
505:             .Width         = THIS.Width
506:             .Height        = 80
507:             .BackColor     = RGB(100, 100, 100)
508:             .BorderWidth   = 0
509:             .SpecialEffect = 0
510:             .Visible       = .T.
511: 
512:             .AddObject("lbl_4c_Sombra", "Label")
513:             WITH .lbl_4c_Sombra
514:                 .Caption   = THIS.Caption
515:                 .Top       = 15
516:                 .Left      = 10
517:                 .Width     = THIS.Width
518:                 .Height    = 40
519:                 .FontName  = "Tahoma"
520:                 .FontSize  = 16
521:                 .FontBold  = .T.
522:                 .ForeColor = RGB(0, 0, 0)
523:                 .BackStyle = 0
524:                 .AutoSize  = .F.
525:                 .Visible   = .T.
526:             ENDWITH
527: 
528:             .AddObject("lbl_4c_Titulo", "Label")
529:             WITH .lbl_4c_Titulo
530:                 .Caption   = THIS.Caption
531:                 .Top       = 18
532:                 .Left      = 10
533:                 .Width     = THIS.Width
534:                 .Height    = 46

*-- Linhas 954 a 997:
954:         ENDWITH
955: 
956:         *-- OPT_ALTTRANS -> obj_4c_OPT_ALTTRANS (this_nBaseReduzida / coluna nbaseres)
957:         loc_oPagina.AddObject("obj_4c_OPT_ALTTRANS", "OptionGroup")
958:         WITH loc_oPagina.obj_4c_OPT_ALTTRANS
959:             .ButtonCount  = 2
960:             .Top          = 445
961:             .Left         = 363
962:             .Width        = 125
963:             .Height       = 15
964:             .BackStyle    = 0
965:             .BorderStyle  = 0
966:             .Themes       = .F.
967:             .Value        = 1
968:             .Visible      = .T.
969:         ENDWITH
970:         WITH loc_oPagina.obj_4c_OPT_ALTTRANS.Buttons(1)
971:             .Caption   = "Sim"
972:             .Left      = 5
973:             .Top       = 0
974:             .Width     = 40
975:             .Height    = 17
976:             .AutoSize  = .F.
977:             .FontName  = "Tahoma"
978:             .FontSize  = 8
979:             .BackStyle = 0
980:             .ForeColor = RGB(90, 90, 90)
981:             .Themes    = .F.
982:         ENDWITH
983:         WITH loc_oPagina.obj_4c_OPT_ALTTRANS.Buttons(2)
984:             .Caption   = "N" + CHR(227) + "o"
985:             .Left      = 69
986:             .Top       = 0
987:             .Width     = 46
988:             .Height    = 17
989:             .AutoSize  = .F.
990:             .FontName  = "Tahoma"
991:             .FontSize  = 8
992:             .BackStyle = 0
993:             .ForeColor = RGB(90, 90, 90)
994:             .Themes    = .F.
995:         ENDWITH
996: 
997:         *-- Say15 "Aliquota Local por Classificacao :" (rotulo da area do grid GradAlo - grid em fase futura)

*-- Linhas 1047 a 1781:
1047:             .AutoSize        = .F.
1048:             .Visible         = .T.
1049:         ENDWITH
1050:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1051: 
1052:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
1053:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
1054:             .Caption         = "Encerrar"
1055:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1056:             .PicturePosition = 13
1057:             .Top             = 5
1058:             .Left            = 80
1059:             .Width           = 75
1060:             .Height          = 75
1061:             .FontName        = "Tahoma"
1062:             .FontBold        = .T.
1063:             .FontItalic      = .T.
1064:             .FontSize        = 8
1065:             .ForeColor       = RGB(90, 90, 90)
1066:             .BackColor       = RGB(255, 255, 255)
1067:             .Themes          = .F.
1068:             .SpecialEffect   = 0
1069:             .MousePointer    = 15
1070:             .WordWrap        = .T.
1071:             .AutoSize        = .F.
1072:             .Visible         = .T.
1073:         ENDWITH
1074:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
1075: 
1076:         *-- LOOKUPS - BINDEVENT KeyPress(F4)/DblClick/LostFocus (Fase 6 - COMPLETOS)
1077:         *-- UF Origem (SigCdUfs) - Get_OCodigo/Get_ONome do legado
1078:         BINDEVENT(loc_oPagina.txt_4c_OCodigo, "KeyPress", THIS, "OCodigoLookupKeyPress")
1079:         BINDEVENT(loc_oPagina.txt_4c_OCodigo, "DblClick", THIS, "OCodigoLookupDblClick")
1080:         BINDEVENT(loc_oPagina.txt_4c_OCodigo, "KeyPress", THIS, "OCodigoLostFocus")
1081: 
1082:         BINDEVENT(loc_oPagina.txt_4c_ONome, "KeyPress", THIS, "ONomeLookupKeyPress")
1083:         BINDEVENT(loc_oPagina.txt_4c_ONome, "DblClick", THIS, "ONomeLookupDblClick")
1084:         BINDEVENT(loc_oPagina.txt_4c_ONome, "KeyPress", THIS, "ONomeLostFocus")
1085: 
1086:         *-- UF Destino (SigCdUfs) - Get_DCodigo/Get_DNome do legado
1087:         BINDEVENT(loc_oPagina.txt_4c_DCodigo, "KeyPress", THIS, "DCodigoLookupKeyPress")
1088:         BINDEVENT(loc_oPagina.txt_4c_DCodigo, "DblClick", THIS, "DCodigoLookupDblClick")
1089:         BINDEVENT(loc_oPagina.txt_4c_DCodigo, "KeyPress", THIS, "DCodigoLostFocus")
1090: 
1091:         BINDEVENT(loc_oPagina.txt_4c_DNome, "KeyPress", THIS, "DNomeLookupKeyPress")
1092:         BINDEVENT(loc_oPagina.txt_4c_DNome, "DblClick", THIS, "DNomeLookupDblClick")
1093:         BINDEVENT(loc_oPagina.txt_4c_DNome, "KeyPress", THIS, "DNomeLostFocus")
1094: 
1095:         *-- CFO (SigCdCfo) - getCFO do legado
1096:         BINDEVENT(loc_oPagina.txt_4c_CFO, "KeyPress", THIS, "CfoLookupKeyPress")
1097:         BINDEVENT(loc_oPagina.txt_4c_CFO, "DblClick", THIS, "CfoLookupDblClick")
1098:         BINDEVENT(loc_oPagina.txt_4c_CFO, "KeyPress", THIS, "CfoLostFocus")
1099: 
1100:         THIS.TornarControlesVisiveis(loc_oPagina)
1101:     ENDPROC
1102: 
1103:     *===========================================================================
1104:     * ExecutarBuscaUf - Executa lookup em SigCdUfs (compartilhado pelos 4 campos
1105:     * de UF Origem/Destino). Preenche this_cUfLookupCodigo/this_cUfLookupDescricao.
1106:     * Retorna .T. se um registro foi selecionado/encontrado, .F. caso contrario.
1107:     *===========================================================================
1108:     PROTECTED FUNCTION ExecutarBuscaUf(par_cCampoBusca, par_cValor)
1109:         LOCAL loc_oBusca, loc_lResultado
1110:         loc_lResultado = .F.
1111:         THIS.this_cUfLookupCodigo    = ""
1112:         THIS.this_cUfLookupDescricao = ""
1113: 
1114:         IF EMPTY(ALLTRIM(par_cValor))
1115:             RETURN .F.
1116:         ENDIF
1117: 
1118:         TRY
1119:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1120:                 "SigCdUfs", "cursor_4c_BuscaUf", par_cCampoBusca, ALLTRIM(par_cValor), "Estado")
1121: 
1122:             IF VARTYPE(loc_oBusca) = "O"
1123:                 IF !loc_oBusca.this_lAchouRegistro
1124:                     loc_oBusca.mAddColuna("Estados", "", "C" + CHR(243) + "digo")
1125:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1126:                     loc_oBusca.Show()
1127:                 ENDIF
1128: 
1129:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
1130:                     SELECT cursor_4c_BuscaUf
1131:                     THIS.this_cUfLookupCodigo    = ALLTRIM(Estados)
1132:                     THIS.this_cUfLookupDescricao = ALLTRIM(Descrs)
1133:                     loc_lResultado = .T.
1134:                 ENDIF
1135: 
1136:                 loc_oBusca.Release()
1137:             ENDIF
1138: 
1139:         CATCH TO loException
1140:             MostrarErro("Erro ao buscar UF:" + CHR(13) + loException.Message, "FormUfd.ExecutarBuscaUf")
1141:         ENDTRY
1142: 
1143:         IF USED("cursor_4c_BuscaUf")
1144:             USE IN cursor_4c_BuscaUf
1145:         ENDIF
1146: 
1147:         RETURN loc_lResultado
1148:     ENDFUNC
1149: 
1150:     *===========================================================================
1151:     * Lookup UF Origem por Codigo (txt_4c_OCodigo) - so preenche a descricao
1152:     * (transcrito do legado: Get_OCodigo.Valid nunca reatribui o proprio codigo)
1153:     *===========================================================================
1154:     PROCEDURE OCodigoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1155:         IF par_nKeyCode = 28
1156:             THIS.AbrirLookupUfOrigemPorCodigo()
1157:         ENDIF
1158:     ENDPROC
1159: 
1160:     PROCEDURE OCodigoLookupDblClick()
1161:         THIS.AbrirLookupUfOrigemPorCodigo()
1162:     ENDPROC
1163: 
1164:     PROCEDURE OCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1165:         LOCAL loc_cValor
1166:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.Value)
1167:         IF loc_cValor == THIS.this_cUltOCodigo
1168:             RETURN
1169:         ENDIF
1170:         THIS.this_cUltOCodigo = loc_cValor
1171:         IF !EMPTY(loc_cValor)
1172:             THIS.AbrirLookupUfOrigemPorCodigo()
1173:         ENDIF
1174:     ENDPROC
1175: 
1176:     PROCEDURE AbrirLookupUfOrigemPorCodigo()
1177:         LOCAL loc_oPg2, loc_cValor
1178:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1179:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
1180: 
1181:         IF EMPTY(loc_cValor)
1182:             RETURN
1183:         ENDIF
1184: 
1185:         IF THIS.ExecutarBuscaUf("estados", loc_cValor)
1186:             loc_oPg2.txt_4c_ONome.Value = THIS.this_cUfLookupDescricao
1187:         ELSE
1188:             loc_oPg2.txt_4c_ONome.Value = ""
1189:         ENDIF
1190:         THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
1191:     ENDPROC
1192: 
1193:     *===========================================================================
1194:     * Lookup UF Origem por Nome (txt_4c_ONome) - preenche codigo E descricao
1195:     *===========================================================================
1196:     PROCEDURE ONomeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1197:         IF par_nKeyCode = 28
1198:             THIS.AbrirLookupUfOrigemPorNome()
1199:         ENDIF
1200:     ENDPROC
1201: 
1202:     PROCEDURE ONomeLookupDblClick()
1203:         THIS.AbrirLookupUfOrigemPorNome()
1204:     ENDPROC
1205: 
1206:     PROCEDURE ONomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1207:         LOCAL loc_cValor
1208:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_ONome.Value)
1209:         IF loc_cValor == THIS.this_cUltONome
1210:             RETURN
1211:         ENDIF
1212:         THIS.this_cUltONome = loc_cValor
1213:         IF !EMPTY(loc_cValor)
1214:             THIS.AbrirLookupUfOrigemPorNome()
1215:         ENDIF
1216:     ENDPROC
1217: 
1218:     PROCEDURE AbrirLookupUfOrigemPorNome()
1219:         LOCAL loc_oPg2, loc_cValor
1220:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1221:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)
1222: 
1223:         IF EMPTY(loc_cValor)
1224:             RETURN
1225:         ENDIF
1226: 
1227:         IF THIS.ExecutarBuscaUf("descrs", loc_cValor)
1228:             loc_oPg2.txt_4c_OCodigo.Value = THIS.this_cUfLookupCodigo
1229:             loc_oPg2.txt_4c_ONome.Value   = THIS.this_cUfLookupDescricao
1230:         ELSE
1231:             loc_oPg2.txt_4c_OCodigo.Value = ""
1232:             loc_oPg2.txt_4c_ONome.Value   = ""
1233:         ENDIF
1234:         THIS.this_cUltONome   = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)
1235:         THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
1236:     ENDPROC
1237: 
1238:     *===========================================================================
1239:     * Lookup UF Destino por Codigo (txt_4c_DCodigo) - preenche codigo E descricao
1240:     * (transcrito do legado: Get_DCodigo.Valid reatribui ambos os campos)
1241:     *===========================================================================
1242:     PROCEDURE DCodigoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1243:         IF par_nKeyCode = 28
1244:             THIS.AbrirLookupUfDestinoPorCodigo()
1245:         ENDIF
1246:     ENDPROC
1247: 
1248:     PROCEDURE DCodigoLookupDblClick()
1249:         THIS.AbrirLookupUfDestinoPorCodigo()
1250:     ENDPROC
1251: 
1252:     PROCEDURE DCodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1253:         LOCAL loc_cValor
1254:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DCodigo.Value)
1255:         IF loc_cValor == THIS.this_cUltDCodigo
1256:             RETURN
1257:         ENDIF
1258:         THIS.this_cUltDCodigo = loc_cValor
1259:         IF !EMPTY(loc_cValor)
1260:             THIS.AbrirLookupUfDestinoPorCodigo()
1261:         ENDIF
1262:     ENDPROC
1263: 
1264:     PROCEDURE AbrirLookupUfDestinoPorCodigo()
1265:         LOCAL loc_oPg2, loc_cValor
1266:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1267:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
1268: 
1269:         IF EMPTY(loc_cValor)
1270:             RETURN
1271:         ENDIF
1272: 
1273:         IF THIS.ExecutarBuscaUf("estados", loc_cValor)
1274:             loc_oPg2.txt_4c_DCodigo.Value = THIS.this_cUfLookupCodigo
1275:             loc_oPg2.txt_4c_DNome.Value   = THIS.this_cUfLookupDescricao
1276:         ELSE
1277:             loc_oPg2.txt_4c_DCodigo.Value = ""
1278:             loc_oPg2.txt_4c_DNome.Value   = ""
1279:         ENDIF
1280:         THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
1281:         THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
1282:     ENDPROC
1283: 
1284:     *===========================================================================
1285:     * Lookup UF Destino por Nome (txt_4c_DNome) - preenche codigo E descricao
1286:     *===========================================================================
1287:     PROCEDURE DNomeLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1288:         IF par_nKeyCode = 28
1289:             THIS.AbrirLookupUfDestinoPorNome()
1290:         ENDIF
1291:     ENDPROC
1292: 
1293:     PROCEDURE DNomeLookupDblClick()
1294:         THIS.AbrirLookupUfDestinoPorNome()
1295:     ENDPROC
1296: 
1297:     PROCEDURE DNomeLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1298:         LOCAL loc_cValor
1299:         loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DNome.Value)
1300:         IF loc_cValor == THIS.this_cUltDNome
1301:             RETURN
1302:         ENDIF
1303:         THIS.this_cUltDNome = loc_cValor
1304:         IF !EMPTY(loc_cValor)
1305:             THIS.AbrirLookupUfDestinoPorNome()
1306:         ENDIF
1307:     ENDPROC
1308: 
1309:     PROCEDURE AbrirLookupUfDestinoPorNome()
1310:         LOCAL loc_oPg2, loc_cValor
1311:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1312:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
1313: 
1314:         IF EMPTY(loc_cValor)
1315:             RETURN
1316:         ENDIF
1317: 
1318:         IF THIS.ExecutarBuscaUf("descrs", loc_cValor)
1319:             loc_oPg2.txt_4c_DCodigo.Value = THIS.this_cUfLookupCodigo
1320:             loc_oPg2.txt_4c_DNome.Value   = THIS.this_cUfLookupDescricao
1321:         ELSE
1322:             loc_oPg2.txt_4c_DCodigo.Value = ""
1323:             loc_oPg2.txt_4c_DNome.Value   = ""
1324:         ENDIF
1325:         THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
1326:         THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
1327:     ENDPROC
1328: 
1329:     *===========================================================================
1330:     * Lookup CFO (txt_4c_CFO) - SigCdCfo.Codigos/Descricaos
1331:     * Transcrito do legado: getCFO.Valid remove pontos antes de comparar/buscar
1332:     *===========================================================================
1333:     PROCEDURE CfoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1334:         IF par_nKeyCode = 28
1335:             THIS.AbrirLookupCfo()
1336:         ENDIF
1337:     ENDPROC
1338: 
1339:     PROCEDURE CfoLookupDblClick()
1340:         THIS.AbrirLookupCfo()
1341:     ENDPROC
1342: 
1343:     PROCEDURE CfoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1344:         LOCAL loc_cValor
1345:         loc_cValor = ALLTRIM(STRTRAN(THIS.pgf_4c_Paginas.Page2.txt_4c_CFO.Value, ".", ""))
1346:         IF loc_cValor == THIS.this_cUltCfop
1347:             RETURN
1348:         ENDIF
1349:         THIS.this_cUltCfop = loc_cValor
1350:         IF !EMPTY(loc_cValor)
1351:             THIS.AbrirLookupCfo()
1352:         ENDIF
1353:     ENDPROC
1354: 
1355:     PROCEDURE AbrirLookupCfo()
1356:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
1357:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1358:         loc_cValor = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))
1359: 
1360:         IF EMPTY(loc_cValor)
1361:             RETURN
1362:         ENDIF
1363: 
1364:         TRY
1365:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1366:                 "SigCdCfo", "cursor_4c_BuscaCfo", "Codigos", loc_cValor, "CFO")
1367: 
1368:             IF VARTYPE(loc_oBusca) = "O"
1369:                 IF !loc_oBusca.this_lAchouRegistro
1370:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1371:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1372:                     loc_oBusca.Show()
1373:                 ENDIF
1374: 
1375:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfo")
1376:                     SELECT cursor_4c_BuscaCfo
1377:                     loc_oPg2.txt_4c_CFO.Value = ALLTRIM(Codigos)
1378:                 ELSE
1379:                     loc_oPg2.txt_4c_CFO.Value = ""
1380:                 ENDIF
1381: 
1382:                 loc_oBusca.Release()
1383:             ENDIF
1384: 
1385:         CATCH TO loException
1386:             MostrarErro("Erro ao buscar CFO:" + CHR(13) + loException.Message, "FormUfd.AbrirLookupCfo")
1387:         ENDTRY
1388: 
1389:         IF USED("cursor_4c_BuscaCfo")
1390:             USE IN cursor_4c_BuscaCfo
1391:         ENDIF
1392: 
1393:         THIS.this_cUltCfop = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))
1394:     ENDPROC
1395: 
1396:     *===========================================================================
1397:     * FASE 7/8: FORM - EVENTOS PRINCIPAIS
1398:     * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
1399:     * + helpers de suporte (BOParaForm/HabilitarCampos/LimparCampos/AjustarBotoesPorModo)
1400:     * PUBLIC (sem PROTECTED) - exigido para funcionar com BINDEVENT (regra #3/Problema 17)
1401:     *===========================================================================
1402: 
1403:     *===========================================================================
1404:     * BOParaForm - Transfere propriedades do BusinessObject para os campos da Page2
1405:     * Descricoes de UF (ONome/DNome) sao repopuladas via ExecutarBuscaUf (nao sao
1406:     * persistidas no BO - mesmo padrao do legado, que so guarda o codigo)
1407:     *===========================================================================
1408:     PROTECTED PROCEDURE BOParaForm()
1409:         LOCAL loc_oPg2, loc_oBo
1410:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1411:         loc_oBo  = THIS.this_oBusinessObject
1412: 
1413:         loc_oPg2.txt_4c_OCodigo.Value       = loc_oBo.this_cUfOrigem
1414:         loc_oPg2.txt_4c_DCodigo.Value       = loc_oBo.this_cUfDestino
1415:         loc_oPg2.txt_4c_Aicms.Value         = loc_oBo.this_nAliqIcms
1416:         loc_oPg2.txt_4c_Aliqpimps.Value     = loc_oBo.this_nAliqIcmsPImp
1417:         loc_oPg2.txt_4c_AliqFcp.Value       = loc_oBo.this_nAliqFcp
1418:         loc_oPg2.txt_4c_Aliqredb.Value      = loc_oBo.this_nAliqRedBase
1419:         loc_oPg2.txt_4c_AliqSB.Value        = loc_oBo.this_nAliqSubTrib
1420:         loc_oPg2.txt_4c_AliqInter.Value     = loc_oBo.this_nAliqInterestadual
1421:         loc_oPg2.txt_4c_CFO.Value           = loc_oBo.this_cCfop
1422:         loc_oPg2.txt_4c_Iest.Value          = loc_oBo.this_cIeSubstituto
1423:         loc_oPg2.obj_4c_OPT_ALTTRANS.Value  = IIF(loc_oBo.this_nBaseReduzida = 2, 2, 1)
1424: 
1425:         IF !EMPTY(ALLTRIM(loc_oBo.this_cUfOrigem)) AND THIS.ExecutarBuscaUf("estados", ALLTRIM(loc_oBo.this_cUfOrigem))
1426:             loc_oPg2.txt_4c_ONome.Value = THIS.this_cUfLookupDescricao
1427:         ELSE
1428:             loc_oPg2.txt_4c_ONome.Value = ""
1429:         ENDIF
1430: 
1431:         IF !EMPTY(ALLTRIM(loc_oBo.this_cUfDestino)) AND THIS.ExecutarBuscaUf("estados", ALLTRIM(loc_oBo.this_cUfDestino))
1432:             loc_oPg2.txt_4c_DNome.Value = THIS.this_cUfLookupDescricao
1433:         ELSE
1434:             loc_oPg2.txt_4c_DNome.Value = ""
1435:         ENDIF
1436: 
1437:         *-- Reseta guardas de "valor alterado" dos lookups (Problema 45)
1438:         THIS.this_cUltOCodigo = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
1439:         THIS.this_cUltONome   = ALLTRIM(loc_oPg2.txt_4c_ONome.Value)
1440:         THIS.this_cUltDCodigo = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
1441:         THIS.this_cUltDNome   = ALLTRIM(loc_oPg2.txt_4c_DNome.Value)
1442:         THIS.this_cUltCfop    = ALLTRIM(STRTRAN(loc_oPg2.txt_4c_CFO.Value, ".", ""))
1443:     ENDPROC
1444: 
1445:     *===========================================================================
1446:     * FormParaBO - Transfere os campos da Page2 para o BusinessObject
1447:     * Chamado por BtnSalvarClick() antes de THIS.this_oBusinessObject.Salvar()
1448:     *===========================================================================
1449:     PROTECTED PROCEDURE FormParaBO()
1450:         LOCAL loc_oPg2, loc_oBo
1451:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1452:         loc_oBo  = THIS.this_oBusinessObject
1453: 
1454:         loc_oBo.this_cUfOrigem          = ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value)
1455:         loc_oBo.this_cUfDestino         = ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value)
1456:         loc_oBo.this_nAliqIcms          = loc_oPg2.txt_4c_Aicms.Value
1457:         loc_oBo.this_nAliqIcmsPImp      = loc_oPg2.txt_4c_Aliqpimps.Value
1458:         loc_oBo.this_nAliqFcp           = loc_oPg2.txt_4c_AliqFcp.Value
1459:         loc_oBo.this_nAliqRedBase       = loc_oPg2.txt_4c_Aliqredb.Value
1460:         loc_oBo.this_nAliqSubTrib       = loc_oPg2.txt_4c_AliqSB.Value
1461:         loc_oBo.this_nAliqInterestadual = loc_oPg2.txt_4c_AliqInter.Value
1462:         loc_oBo.this_cCfop              = ALLTRIM(loc_oPg2.txt_4c_CFO.Value)
1463:         loc_oBo.this_cIeSubstituto      = ALLTRIM(loc_oPg2.txt_4c_Iest.Value)
1464:         loc_oBo.this_nBaseReduzida      = loc_oPg2.obj_4c_OPT_ALTTRANS.Value
1465:     ENDPROC
1466: 
1467:     *===========================================================================
1468:     * LimparCampos - Limpa todos os campos da Page2 (usado em BtnIncluirClick)
1469:     *===========================================================================
1470:     PROTECTED PROCEDURE LimparCampos()
1471:         LOCAL loc_oPg2
1472:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1473: 
1474:         loc_oPg2.txt_4c_OCodigo.Value       = ""
1475:         loc_oPg2.txt_4c_ONome.Value         = ""
1476:         loc_oPg2.txt_4c_DCodigo.Value       = ""
1477:         loc_oPg2.txt_4c_DNome.Value         = ""
1478:         loc_oPg2.txt_4c_Aicms.Value         = 0
1479:         loc_oPg2.txt_4c_Aliqpimps.Value     = 0
1480:         loc_oPg2.txt_4c_AliqFcp.Value       = 0
1481:         loc_oPg2.txt_4c_Aliqredb.Value      = 0
1482:         loc_oPg2.txt_4c_AliqSB.Value         = 0
1483:         loc_oPg2.txt_4c_AliqInter.Value     = 0
1484:         loc_oPg2.txt_4c_CFO.Value           = ""
1485:         loc_oPg2.txt_4c_Iest.Value          = ""
1486:         loc_oPg2.obj_4c_OPT_ALTTRANS.Value  = 1
1487: 
1488:         THIS.this_cUltOCodigo = ""
1489:         THIS.this_cUltONome   = ""
1490:         THIS.this_cUltDCodigo = ""
1491:         THIS.this_cUltDNome   = ""
1492:         THIS.this_cUltCfop    = ""
1493:     ENDPROC
1494: 
1495:     *===========================================================================
1496:     * HabilitarCampos - Habilita/desabilita todos os campos editaveis da Page2
1497:     *===========================================================================
1498:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1499:         LOCAL loc_oPg2
1500:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1501: 
1502:         loc_oPg2.txt_4c_OCodigo.Enabled      = par_lHabilitar
1503:         loc_oPg2.txt_4c_ONome.Enabled        = par_lHabilitar
1504:         loc_oPg2.txt_4c_DCodigo.Enabled      = par_lHabilitar
1505:         loc_oPg2.txt_4c_DNome.Enabled        = par_lHabilitar
1506:         loc_oPg2.txt_4c_Aicms.Enabled        = par_lHabilitar
1507:         loc_oPg2.txt_4c_Aliqpimps.Enabled    = par_lHabilitar
1508:         loc_oPg2.txt_4c_AliqFcp.Enabled      = par_lHabilitar
1509:         loc_oPg2.txt_4c_Aliqredb.Enabled     = par_lHabilitar
1510:         loc_oPg2.txt_4c_AliqSB.Enabled       = par_lHabilitar
1511:         loc_oPg2.txt_4c_AliqInter.Enabled    = par_lHabilitar
1512:         loc_oPg2.txt_4c_CFO.Enabled          = par_lHabilitar
1513:         loc_oPg2.txt_4c_Iest.Enabled         = par_lHabilitar
1514:         loc_oPg2.obj_4c_OPT_ALTTRANS.Enabled = par_lHabilitar
1515:     ENDPROC
1516: 
1517:     *===========================================================================
1518:     * AjustarBotoesPorModo - Confirmar desabilitado em VISUALIZAR, Cancelar sempre habilitado
1519:     * (padrao frmcadastro - CLAUDE.md / migration_guide.md)
1520:     *===========================================================================
1521:     PROCEDURE AjustarBotoesPorModo()
1522:         LOCAL loc_oPg2
1523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1524: 
1525:         DO CASE
1526:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1527:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1528:             OTHERWISE
1529:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1530:         ENDCASE
1531: 
1532:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1533:     ENDPROC
1534: 
1535:     *===========================================================================
1536:     * BtnIncluirClick - Prepara BO+Form para inclusao de novo registro
1537:     * NovoRegistro() e this_cModoAtual="INCLUIR" ANTES de HabilitarCampos (Problema 18/19)
1538:     *===========================================================================
1539:     PROCEDURE BtnIncluirClick()
1540:         TRY
1541:             THIS.this_oBusinessObject.NovoRegistro()
1542:             THIS.LimparCampos()
1543:             THIS.this_cModoAtual = "INCLUIR"
1544:             THIS.HabilitarCampos(.T.)
1545:             THIS.AjustarBotoesPorModo()
1546:             THIS.AlternarPagina(2)
1547:             THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.SetFocus()
1548: 
1549:         CATCH TO loException
1550:             MostrarErro("Erro ao incluir registro:" + CHR(13) + loException.Message, ;
1551:                 "FormUfd.BtnIncluirClick")
1552:         ENDTRY
1553:     ENDPROC
1554: 
1555:     *===========================================================================
1556:     * BtnAlterarClick - Carrega registro selecionado na grade e habilita edicao
1557:     * EditarRegistro() APOS CarregarPorCodigo (Problema 18); modo ANTES de HabilitarCampos (Problema 19)
1558:     *===========================================================================
1559:     PROCEDURE BtnAlterarClick()
1560:         LOCAL loc_cChave
1561:         TRY
1562:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1563:                 MsgAviso("Selecione um registro para alterar!")
1564:             ELSE
1565:                 SELECT cursor_4c_Dados
1566:                 loc_cChave = ALLTRIM(cidchaves)
1567: 
1568:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1569:                     THIS.this_oBusinessObject.EditarRegistro()
1570:                     THIS.BOParaForm()
1571:                     THIS.this_cModoAtual = "ALTERAR"
1572:                     THIS.HabilitarCampos(.T.)
1573:                     THIS.AjustarBotoesPorModo()
1574:                     THIS.AlternarPagina(2)
1575:                     THIS.pgf_4c_Paginas.Page2.txt_4c_OCodigo.SetFocus()
1576:                 ENDIF
1577:             ENDIF
1578: 
1579:         CATCH TO loException
1580:             MostrarErro("Erro ao alterar registro:" + CHR(13) + loException.Message, ;
1581:                 "FormUfd.BtnAlterarClick")
1582:         ENDTRY
1583:     ENDPROC
1584: 
1585:     *===========================================================================
1586:     * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
1587:     * Tambem vinculado ao DblClick do grid (ConfigurarPaginaLista)
1588:     *===========================================================================
1589:     PROCEDURE BtnVisualizarClick()
1590:         LOCAL loc_cChave
1591:         TRY
1592:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1593:                 MsgAviso("Selecione um registro para visualizar!")
1594:             ELSE
1595:                 SELECT cursor_4c_Dados
1596:                 loc_cChave = ALLTRIM(cidchaves)
1597: 
1598:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1599:                     THIS.BOParaForm()
1600:                     THIS.this_cModoAtual = "VISUALIZAR"
1601:                     THIS.HabilitarCampos(.F.)
1602:                     THIS.AjustarBotoesPorModo()
1603:                     THIS.AlternarPagina(2)
1604:                 ENDIF
1605:             ENDIF
1606: 
1607:         CATCH TO loException
1608:             MostrarErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, ;
1609:                 "FormUfd.BtnVisualizarClick")
1610:         ENDTRY
1611:     ENDPROC
1612: 
1613:     *===========================================================================
1614:     * BtnExcluirClick - Exclui registro selecionado na grade (com confirmacao)
1615:     * MsgConfirma() retorna LOGICAL (regra #7); falha de Excluir() ja eh reportada
1616:     * pelo BusinessBase.ExibirFalha (regra #20) - so avisa se this_lErroExibido = .F.
1617:     *===========================================================================
1618:     PROCEDURE BtnExcluirClick()
1619:         LOCAL loc_cChave, loc_cUfO, loc_cUfD
1620:         TRY
1621:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1622:                 MsgAviso("Selecione um registro para excluir!")
1623:             ELSE
1624:                 SELECT cursor_4c_Dados
1625:                 loc_cChave = ALLTRIM(cidchaves)
1626:                 loc_cUfO   = ALLTRIM(codigos)
1627:                 loc_cUfD   = ALLTRIM(destinos)
1628: 
1629:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do ICMS Interestadual " + ;
1630:                         loc_cUfO + " -> " + loc_cUfD + "?", "Confirmar Exclus" + CHR(227) + "o")
1631: 
1632:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1633:                         IF THIS.this_oBusinessObject.Excluir()
1634:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
1635:                             THIS.CarregarLista()
1636:                         ELSE
1637:                             IF !THIS.this_oBusinessObject.this_lErroExibido
1638:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Erro")
1639:                             ENDIF
1640:                         ENDIF
1641:                     ENDIF
1642:                 ENDIF
1643:             ENDIF
1644: 
1645:         CATCH TO loException
1646:             MostrarErro("Erro ao excluir registro:" + CHR(13) + loException.Message, ;
1647:                 "FormUfd.BtnExcluirClick")
1648:         ENDTRY
1649:     ENDPROC
1650: 
1651:     *===========================================================================
1652:     * BtnBuscarClick - Filtra a lista por UF de Origem via FormBuscaAuxiliar
1653:     * (SigCdUfd nao tem cntFiltros no legado; segue o padrao dos demais
1654:     * cadastros: Buscar abre lookup em tabela relacionada e filtra o grid)
1655:     *===========================================================================
1656:     PROCEDURE BtnBuscarClick()
1657:         LOCAL loc_oBusca, loc_cCodigo
1658:         TRY
1659:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1660:                 "SigCdUfs", "cursor_4c_BuscaUfLista", "estados", "", "Buscar U.F. Origem")
1661: 
1662:             IF VARTYPE(loc_oBusca) = "O"
1663:                 IF !loc_oBusca.this_lAchouRegistro
1664:                     loc_oBusca.mAddColuna("Estados", "", "C" + CHR(243) + "digo")
1665:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1666:                     loc_oBusca.Show()
1667:                 ENDIF
1668: 
1669:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUfLista")
1670:                     SELECT cursor_4c_BuscaUfLista
1671:                     loc_cCodigo = ALLTRIM(Estados)
1672:                     THIS.CarregarLista("codigos = " + EscaparSQL(loc_cCodigo))
1673:                 ENDIF
1674: 
1675:                 loc_oBusca.Release()
1676:             ENDIF
1677: 
1678:         CATCH TO loException
1679:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormUfd.BtnBuscarClick")
1680:         ENDTRY
1681: 
1682:         IF USED("cursor_4c_BuscaUfLista")
1683:             USE IN cursor_4c_BuscaUfLista
1684:         ENDIF
1685:     ENDPROC
1686: 
1687:     *===========================================================================
1688:     * BtnSalvarClick - Valida e grava o registro (Confirmar)
1689:     * Validacoes FORA do TRY (transcrito do legado SIGCDUFD.Click: "U.F. Origem
1690:     * Invalido"/"U.F. Destino Invalido"). Salvar() sem parametro (regra CLAUDE.md);
1691:     * falha ja e reportada pelo BusinessBase (regra #20) - so avisa se nao exibido.
1692:     *===========================================================================
1693:     PROCEDURE BtnSalvarClick()
1694:         LOCAL loc_oPg2
1695:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1696: 
1697:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_OCodigo.Value))
1698:             MsgAviso("U.F. Origem Inv" + CHR(225) + "lido.")
1699:             loc_oPg2.txt_4c_OCodigo.SetFocus()
1700:             RETURN
1701:         ENDIF
1702: 
1703:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DCodigo.Value))
1704:             MsgAviso("U.F. Destino Inv" + CHR(225) + "lido.")
1705:             loc_oPg2.txt_4c_DCodigo.SetFocus()
1706:             RETURN
1707:         ENDIF
1708: 
1709:         THIS.FormParaBO()
1710: 
1711:         IF THIS.this_oBusinessObject.Salvar()
1712:             MsgInfo("Registro salvo com sucesso!", "Confirmar")
1713:             THIS.AlternarPagina(1)
1714:             THIS.CarregarLista()
1715:         ELSE
1716:             IF !THIS.this_oBusinessObject.this_lErroExibido
1717:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
1718:             ENDIF
1719:         ENDIF
1720:     ENDPROC
1721: 
1722:     *===========================================================================
1723:     * BtnCancelarClick - Cancela edicao e volta para a lista (recarregada)
1724:     *===========================================================================
1725:     PROCEDURE BtnCancelarClick()
1726:         THIS.AlternarPagina(1)
1727:         THIS.this_cModoAtual = "LISTA"
1728:         THIS.CarregarLista()
1729:     ENDPROC
1730: 
1731:     *===========================================================================
1732:     * BtnEncerrarClick - Fecha o formulario
1733:     *===========================================================================
1734:     PROCEDURE BtnEncerrarClick()
1735:         THIS.Release()
1736:     ENDPROC
1737: 
1738:     *===========================================================================
1739:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1740:     * REGRA: Deve iterar Pages E Controls para PageFrames
1741:     *===========================================================================
1742:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1743:         LOCAL loc_nI, loc_oObjeto, loc_nP
1744: 
1745:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1746:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1747: 
1748:             IF VARTYPE(loc_oObjeto) = "O"
1749:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1750:                     loc_oObjeto.Visible = .T.
1751:                 ENDIF
1752: 
1753:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1754:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1755:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1756:                     ENDFOR
1757:                 ENDIF
1758: 
1759:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1760:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1761:                 ENDIF
1762:             ENDIF
1763:         ENDFOR
1764:     ENDPROC
1765: 
1766:     *===========================================================================
1767:     * Destroy - Libera recursos do formulario
1768:     *===========================================================================
1769:     PROCEDURE Destroy()
1770:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1771:             THIS.this_oBusinessObject = .NULL.
1772:         ENDIF
1773: 
1774:         IF USED("cursor_4c_Dados")
1775:             USE IN cursor_4c_Dados
1776:         ENDIF
1777: 
1778:         DODEFAULT()
1779:     ENDPROC
1780: 
1781: ENDDEFINE


### BO (C:\4c\projeto\app\classes\UfdBO.prg):
*====================================================================
* UfdBO.prg
*
* Business Object para Cadastro de ICMS Interestadual (UF x UF)
* Tabela: SigCdUfd
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS UfdBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdUfd)
    this_cChave              = ""    && cidchaves char(20) - PK
    this_cUfOrigem           = ""    && codigos char(2)
    this_cUfDestino          = ""    && destinos char(2)
    this_nAliqIcms           = 0     && aliqs numeric(5,2)
    this_cCfop               = ""    && cfos char(10)
    this_nAliqSubTrib        = 0     && aliqsbs numeric(9,2)
    this_nAliqInterestadual  = 0     && aliqsb2s numeric(9,2)
    this_nAliqIcmsPImp       = 0     && aliqpimps numeric(4,2)
    this_nAliqFcp            = 0     && aliqfcp numeric(5,3)
    this_nAliqRedBase        = 0     && aliqredb numeric(6,3)
    this_cIeSubstituto       = ""    && iest char(20)
    this_nBaseReduzida       = 0     && nbaseres numeric(1,0)
    this_nChkIcms            = 0     && chkicms numeric(1,0)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdUfd"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "UfdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChave             = TratarNulo(cidchaves, "C")
                THIS.this_cUfOrigem          = TratarNulo(codigos,   "C")
                THIS.this_cUfDestino         = TratarNulo(destinos,  "C")
                THIS.this_nAliqIcms          = TratarNulo(aliqs,     "N")
                THIS.this_cCfop              = TratarNulo(cfos,      "C")
                THIS.this_nAliqSubTrib       = TratarNulo(aliqsbs,   "N")
                THIS.this_nAliqInterestadual = TratarNulo(aliqsb2s,  "N")
                THIS.this_nAliqIcmsPImp      = TratarNulo(aliqpimps, "N")
                THIS.this_nAliqFcp           = TratarNulo(aliqfcp,   "N")
                THIS.this_nAliqRedBase       = TratarNulo(aliqredb,  "N")
                THIS.this_cIeSubstituto      = TratarNulo(iest,      "C")
                THIS.this_nBaseReduzida      = TratarNulo(nbaseres,  "N")
                THIS.this_nChkIcms           = TratarNulo(chkicms,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "UfdBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChave)
                THIS.this_cChave = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdUfd (cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    <<EscaparSQL(THIS.this_cUfDestino)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    <<EscaparSQL(THIS.this_cCfop)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "UfdBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdUfd
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdUfd
                SET codigos   = <<EscaparSQL(THIS.this_cUfOrigem)>>,
                    destinos  = <<EscaparSQL(THIS.this_cUfDestino)>>,
                    aliqs     = <<FormatarNumeroSQL(THIS.this_nAliqIcms, 2)>>,
                    cfos      = <<EscaparSQL(THIS.this_cCfop)>>,
                    aliqsbs   = <<FormatarNumeroSQL(THIS.this_nAliqSubTrib, 2)>>,
                    aliqsb2s  = <<FormatarNumeroSQL(THIS.this_nAliqInterestadual, 2)>>,
                    aliqpimps = <<FormatarNumeroSQL(THIS.this_nAliqIcmsPImp, 2)>>,
                    aliqfcp   = <<FormatarNumeroSQL(THIS.this_nAliqFcp, 3)>>,
                    aliqredb  = <<FormatarNumeroSQL(THIS.this_nAliqRedBase, 3)>>,
                    iest      = <<EscaparSQL(THIS.this_cIeSubstituto)>>,
                    nbaseres  = <<FormatarNumeroSQL(THIS.this_nBaseReduzida, 0)>>,
                    chkicms   = <<FormatarNumeroSQL(THIS.this_nChkIcms, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "UfdBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cidchaves (chave oculta p/ Alterar/Excluir)
    * + as 8 colunas exibidas na grade da lista (pColuna do legado)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), codigos C(2), destinos C(2), ;
                        aliqs N(5,2), aliqsbs N(9,2), aliqpimps N(4,2), aliqfcp N(5,3), ;
                        aliqredb N(6,3), iest C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigos, destinos, aliqs, aliqsbs," + ;
                    " aliqpimps, aliqfcp, aliqredb, iest FROM SigCdUfd"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos, destinos"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "UfdBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codigos, destinos, aliqs, cfos,
                    aliqsbs, aliqsb2s, aliqpimps, aliqfcp, aliqredb,
                    iest, nbaseres, chkicms
                FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro de ICMS Interestadual n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar ICMS Interestadual:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "UfdBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdUfd
    * Chamado internamente por BusinessBase.Excluir() (PROTECTED - regra CLAUDE.md)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdUfd WHERE cidchaves = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir ICMS Interestadual:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Erro ao excluir:" + CHR(13) + loException.Message
            MostrarErro(THIS.this_cMensagemErro, "UfdBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

