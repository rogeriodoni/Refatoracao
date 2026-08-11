# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr. Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ct. Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Operacao' (parent: SIGCDEPD.Pagina.Dados): Top original=6 vs migrado 'grd_4c_GradeOperacao' Top=97 (diff=91px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Operacao' (parent: SIGCDEPD.Pagina.Dados): Left original=616 vs migrado 'grd_4c_GradeOperacao' Left=266 (diff=350px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formepd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2276 linhas total):

*-- Linhas 31 a 155:
31:     *==========================================================================
32: 
33:     *--------------------------------------------------------------------------
34:     * Init - FormBase.Init() chama InicializarForm() automaticamente
35:     *--------------------------------------------------------------------------
36:     PROCEDURE Init()
37:         RETURN DODEFAULT()
38:     ENDPROC
39: 
40:     *--------------------------------------------------------------------------
41:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
42:     *--------------------------------------------------------------------------
43:     PROTECTED PROCEDURE InicializarForm()
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             THIS.this_oBusinessObject = CREATEOBJECT("epdBO")
49: 
50:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
51:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cios (epdBO).", ;
52:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58:                 THIS.ConfigurarPaginaDados()
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 loc_lSucesso = .T.
68:             ENDIF
69: 
70:         CATCH TO loc_oErro
71:             MsgErro("Erro em InicializarForm: " + loc_oErro.Message + CHR(13) + ;
72:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
73:         ENDTRY
74: 
75:         RETURN loc_lSucesso
76:     ENDPROC
77: 
78:     *--------------------------------------------------------------------------
79:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
80:     *--------------------------------------------------------------------------
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount  = 2
86:             .Left       = 0
87:             .Top        = -29
88:             .Width      = THIS.Width
89:             .Height     = THIS.Height + 29
90:             .Tabs       = .F.
91:             .Visible    = .T.
92:             .Page1.Caption   = "Lista"
93:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page1.BackColor = RGB(236, 233, 216)
97:             .Page2.BackColor = RGB(236, 233, 216)
98:         ENDWITH
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e bot?es CRUD
103:     *--------------------------------------------------------------------------
104:     PROTECTED PROCEDURE ConfigurarPaginaLista()
105:         LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
106:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
107: 
108:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
109:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110: 
111:         *-- Container cabe?alho escuro com t?tulo (cntSombra no legado)
112:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113:         WITH loc_oPagina.cnt_4c_Cabecalho
114:             .Top         = 2
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BorderWidth = 0
120:             .Visible     = .T.
121:         ENDWITH
122: 
123:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
124:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
125:             .Top       = 15
126:             .Left      = 10
127:             .Width     = THIS.Width - 12
128:             .Height    = 40
129:             .FontName  = "Tahoma"
130:             .FontSize  = 16
131:             .FontBold  = .T.
132:             .ForeColor = RGB(0, 0, 0)
133:             .BackStyle = 0
134:             .AutoSize  = .F.
135:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
136:             .Visible   = .T.
137:         ENDWITH
138: 
139:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Top       = 18
142:             .Left      = 10
143:             .Width     = THIS.Width - 12
144:             .Height    = 46
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(255, 255, 255)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
152:             .Visible   = .T.
153:         ENDWITH
154: 
155:         *-- Container bot?es CRUD lado direito (Grupo_Op no legado)

*-- Linhas 189 a 365:
189:             .AutoSize        = .F.
190:             .Visible         = .T.
191:         ENDWITH
192:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
193: 
194:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
195:         WITH loc_oBotoes.cmd_4c_Visualizar
196:             .Caption         = "Visualizar"
197:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
198:             .PicturePosition = 13
199:             .Top             = 5
200:             .Left            = 80
201:             .Width           = 75
202:             .Height          = 75
203:             .BackColor       = RGB(255, 255, 255)
204:             .ForeColor       = RGB(90, 90, 90)
205:             .FontName        = "Tahoma"
206:             .FontSize        = 8
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .WordWrap        = .T.
213:             .AutoSize        = .F.
214:             .Visible         = .T.
215:         ENDWITH
216:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
217: 
218:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
219:         WITH loc_oBotoes.cmd_4c_Alterar
220:             .Caption         = "Alterar"
221:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
222:             .PicturePosition = 13
223:             .Top             = 5
224:             .Left            = 155
225:             .Width           = 75
226:             .Height          = 75
227:             .BackColor       = RGB(255, 255, 255)
228:             .ForeColor       = RGB(90, 90, 90)
229:             .FontName        = "Tahoma"
230:             .FontSize        = 8
231:             .FontBold        = .T.
232:             .FontItalic      = .T.
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:             .AutoSize        = .F.
238:             .Visible         = .T.
239:         ENDWITH
240:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
241: 
242:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
243:         WITH loc_oBotoes.cmd_4c_Excluir
244:             .Caption         = "Excluir"
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:             .PicturePosition = 13
247:             .Top             = 5
248:             .Left            = 230
249:             .Width           = 75
250:             .Height          = 75
251:             .BackColor       = RGB(255, 255, 255)
252:             .ForeColor       = RGB(90, 90, 90)
253:             .FontName        = "Tahoma"
254:             .FontSize        = 8
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .MousePointer    = 15
260:             .WordWrap        = .T.
261:             .AutoSize        = .F.
262:             .Visible         = .T.
263:         ENDWITH
264:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
265: 
266:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oBotoes.cmd_4c_Buscar
268:             .Caption         = "Buscar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .BackColor       = RGB(255, 255, 255)
276:             .ForeColor       = RGB(90, 90, 90)
277:             .FontName        = "Tahoma"
278:             .FontSize        = 8
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .MousePointer    = 15
284:             .WordWrap        = .T.
285:             .AutoSize        = .F.
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
289: 
290:         *-- Container Encerrar - padr?o can?nico (Left=917, Width=90, cmd Width=75)
291:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:         WITH loc_oPagina.cnt_4c_Saida
293:             .Top         = 29
294:             .Left        = 917
295:             .Width       = 90
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.
300:         ENDWITH
301: 
302:         loc_oSaida = loc_oPagina.cnt_4c_Saida
303:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
304:         WITH loc_oSaida.cmd_4c_Encerrar
305:             .Caption         = "Encerrar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .BackColor       = RGB(255, 255, 255)
313:             .ForeColor       = RGB(90, 90, 90)
314:             .FontName        = "Tahoma"
315:             .FontSize        = 8
316:             .FontBold        = .T.
317:             .FontItalic      = .T.
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .MousePointer    = 15
321:             .WordWrap        = .T.
322:             .AutoSize        = .F.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
326: 
327:         *-- Grid principal (grd_4c_Lista) - registros de SigCdNec
328:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
329:         loc_oGrid = loc_oPagina.grd_4c_Lista
330:         loc_oGrid.Top         = 88
331:         loc_oGrid.Left        = 5
332:         loc_oGrid.Width       = 905
333:         loc_oGrid.Height      = 490
334:         loc_oGrid.ColumnCount = 7
335: 
336:         WITH loc_oGrid
337:             .FontName           = "Verdana"
338:             .FontSize           = 8
339:             .ForeColor          = RGB(90, 90, 90)
340:             .BackColor          = RGB(255, 255, 255)
341:             .GridLineColor      = RGB(238, 238, 238)
342:             .HighlightBackColor = RGB(255, 255, 255)
343:             .HighlightForeColor = RGB(15, 41, 104)
344:             .HighlightStyle     = 2
345:             .DeleteMark         = .F.
346:             .RecordMark         = .F.
347:             .RowHeight          = 16
348:             .ScrollBars         = 2
349:             .GridLines          = 3
350:             .ReadOnly           = .T.
351:             .Visible            = .T.
352:         ENDWITH
353: 
354:         WITH loc_oGrid.Column1
355:             .Width           = 75
356:             .Alignment       = 2
357:             .Header1.Caption = "C" + CHR(243) + "digo"
358:         ENDWITH
359:         WITH loc_oGrid.Column2
360:             .Width           = 80
361:             .Header1.Caption = "Data"
362:         ENDWITH
363:         WITH loc_oGrid.Column3
364:             .Width           = 90
365:             .Header1.Caption = "Gr. Origem"

*-- Linhas 381 a 586:
381:             .Header1.Caption = "Usu" + CHR(225) + "rio"
382:         ENDWITH
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)
385:     ENDPROC
386: 
387:     *--------------------------------------------------------------------------
388:     * ConfigurarPaginaDados - Configura Page2 (Dados) - Campos Parte 1/2
389:     *--------------------------------------------------------------------------
390:     PROTECTED PROCEDURE ConfigurarPaginaDados()
391:         LOCAL loc_oPagina, loc_oSalva, loc_oSaida, loc_oCnt
392:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
393: 
394:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
395:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
396: 
397:         *-- Container bot" + CHR(245) + "es Confirmar/Cancelar (Grupo_Salva no legado)
398:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oSalva = loc_oPagina.cnt_4c_BotoesAcao
410: 
411:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
412:         WITH loc_oSalva.cmd_4c_Confirmar
413:             .Caption         = "Confirmar"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
415:             .PicturePosition = 13
416:             .Top             = 5
417:             .Left            = 5
418:             .Width           = 75
419:             .Height          = 75
420:             .BackColor       = RGB(255, 255, 255)
421:             .ForeColor       = RGB(90, 90, 90)
422:             .FontName        = "Tahoma"
423:             .FontSize        = 8
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .Themes          = .F.
427:             .SpecialEffect   = 0
428:             .MousePointer    = 15
429:             .WordWrap        = .T.
430:             .AutoSize        = .F.
431:             .Visible         = .T.
432:         ENDWITH
433:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
434: 
435:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
436:         WITH loc_oSalva.cmd_4c_Cancelar
437:             .Caption         = "Encerrar"
438:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
439:             .PicturePosition = 13
440:             .Top             = 5
441:             .Left            = 80
442:             .Width           = 75
443:             .Height          = 75
444:             .BackColor       = RGB(255, 255, 255)
445:             .ForeColor       = RGB(90, 90, 90)
446:             .FontName        = "Tahoma"
447:             .FontSize        = 8
448:             .FontBold        = .T.
449:             .FontItalic      = .T.
450:             .Themes          = .F.
451:             .SpecialEffect   = 0
452:             .MousePointer    = 15
453:             .WordWrap        = .T.
454:             .AutoSize        = .F.
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
458: 
459:         *-- Container Encerrar - padr" + CHR(227) + "o can" + CHR(244) + "nico
460:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
461:         WITH loc_oPagina.cnt_4c_Saida
462:             .Top         = 29
463:             .Left        = 917
464:             .Width       = 90
465:             .Height      = 85
466:             .BackStyle   = 0
467:             .BorderWidth = 0
468:             .Visible     = .T.
469:         ENDWITH
470: 
471:         loc_oSaida = loc_oPagina.cnt_4c_Saida
472:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
473:         WITH loc_oSaida.cmd_4c_Encerrar
474:             .Caption         = "Encerrar"
475:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
476:             .PicturePosition = 13
477:             .Top             = 5
478:             .Left            = 5
479:             .Width           = 75
480:             .Height          = 75
481:             .BackColor       = RGB(255, 255, 255)
482:             .ForeColor       = RGB(90, 90, 90)
483:             .FontName        = "Tahoma"
484:             .FontSize        = 8
485:             .FontBold        = .T.
486:             .FontItalic      = .T.
487:             .Themes          = .F.
488:             .SpecialEffect   = 0
489:             .MousePointer    = 15
490:             .WordWrap        = .T.
491:             .AutoSize        = .F.
492:             .Visible         = .T.
493:         ENDWITH
494:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
495: 
496:         *-- Bot" + CHR(245) + "es de a" + CHR(231) + CHR(227) + "o no topo da Page2 (top=6+29=35)
497:         loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
498:         WITH loc_oPagina.cmd_4c_Operacao
499:             .Caption       = "\<Movimento"
500:             .Top           = 35
501:             .Left          = 616
502:             .Width         = 70
503:             .Height        = 25
504:             .BackColor     = RGB(255, 255, 255)
505:             .ForeColor     = RGB(90, 90, 90)
506:             .FontName      = "Tahoma"
507:             .FontSize      = 8
508:             .Themes        = .F.
509:             .SpecialEffect = 0
510:             .Visible       = .T.
511:         ENDWITH
512:         BINDEVENT(loc_oPagina.cmd_4c_Operacao, "Click", THIS, "BtnOperacaoClick")
513: 
514:         loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
515:         WITH loc_oPagina.cmd_4c_Boleto
516:             .Caption       = "\<Boleto"
517:             .Top           = 35
518:             .Left          = 692
519:             .Width         = 70
520:             .Height        = 25
521:             .BackColor     = RGB(255, 255, 255)
522:             .ForeColor     = RGB(90, 90, 90)
523:             .FontName      = "Tahoma"
524:             .FontSize      = 8
525:             .Themes        = .F.
526:             .SpecialEffect = 0
527:             .Visible       = .T.
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
530: 
531:         loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
532:         WITH loc_oPagina.cmd_4c_Documento
533:             .Caption       = "\<Documento"
534:             .Top           = 35
535:             .Left          = 768
536:             .Width         = 70
537:             .Height        = 25
538:             .BackColor     = RGB(255, 255, 255)
539:             .ForeColor     = RGB(90, 90, 90)
540:             .FontName      = "Tahoma"
541:             .FontSize      = 8
542:             .Themes        = .F.
543:             .SpecialEffect = 0
544:             .Visible       = .T.
545:         ENDWITH
546:         BINDEVENT(loc_oPagina.cmd_4c_Documento, "Click", THIS, "BtnDocumentoClick")
547: 
548:         *-- Separador visual (shpBtnGs no legado, top=143+29=172)
549:         loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
550:         WITH loc_oPagina.shp_4c_ShpBtnGs
551:             .Top     = 172
552:             .Left    = 635
553:             .Width   = 18
554:             .Height  = 50
555:             .Visible = .T.
556:         ENDWITH
557: 
558:         *-- Container1: C" + CHR(243) + "digo e Data (top=268+29=297)
559:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
560:         WITH loc_oPagina.cnt_4c_Container1
561:             .Top         = 297
562:             .Left        = 214
563:             .Width       = 571
564:             .Height      = 75
565:             .BackStyle   = 1
566:             .BackColor   = RGB(236, 233, 216)
567:             .BorderWidth = 0
568:             .Visible     = .T.
569:         ENDWITH
570: 
571:         loc_oCnt = loc_oPagina.cnt_4c_Container1
572: 
573:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
574:         WITH loc_oCnt.lbl_4c_Label1
575:             .Caption   = "C" + CHR(243) + "digo"
576:             .Top       = 8
577:             .Left      = 11
578:             .Width     = 80
579:             .Height    = 17
580:             .FontName  = "Tahoma"
581:             .FontSize  = 8
582:             .ForeColor = RGB(90, 90, 90)
583:             .BackStyle = 0
584:             .Visible   = .T.
585:         ENDWITH
586: 

*-- Linhas 723 a 795:
723:             .Value    = ""
724:             .Visible  = .T.
725:         ENDWITH
726:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsKeyPress")
727:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsLostFocus")
728: 
729:         loc_oCnt.AddObject("txt_4c_ContaOs", "TextBox")
730:         WITH loc_oCnt.txt_4c_ContaOs
731:             .Top      = 42
732:             .Left     = 96
733:             .Width    = 80
734:             .Height   = 22
735:             .FontName = "Tahoma"
736:             .FontSize = 8
737:             .Value    = ""
738:             .Visible  = .T.
739:         ENDWITH
740:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsKeyPress")
741:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsLostFocus")
742: 
743:         loc_oCnt.AddObject("txt_4c_NomeContaOs", "TextBox")
744:         WITH loc_oCnt.txt_4c_NomeContaOs
745:             .Top      = 42
746:             .Left     = 180
747:             .Width    = 360
748:             .Height   = 22
749:             .FontName = "Tahoma"
750:             .FontSize = 8
751:             .Value    = ""
752:             .ReadOnly = .T.
753:             .Visible  = .T.
754:         ENDWITH
755:         BINDEVENT(loc_oCnt.txt_4c_NomeContaOs, "KeyPress", THIS, "TxtNomeContaOsKeyPress")
756: 
757:         *-- Container Destino: Grupo/Conta/Nome de Destino (top=429+29=458)
758:         loc_oPagina.AddObject("cnt_4c_Destino", "Container")
759:         WITH loc_oPagina.cnt_4c_Destino
760:             .Top         = 458
761:             .Left        = 214
762:             .Width       = 571
763:             .Height      = 75
764:             .BackStyle   = 1
765:             .BackColor   = RGB(236, 233, 216)
766:             .BorderWidth = 0
767:             .Visible     = .T.
768:         ENDWITH
769: 
770:         loc_oCnt = loc_oPagina.cnt_4c_Destino
771: 
772:         loc_oCnt.AddObject("lbl_4c_label42", "Label")
773:         WITH loc_oCnt.lbl_4c_label42
774:             .Caption   = "Destino"
775:             .Top       = 6
776:             .Left      = 11
777:             .Width     = 80
778:             .Height    = 17
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .FontBold  = .T.
782:             .ForeColor = RGB(90, 90, 90)
783:             .BackStyle = 0
784:             .Visible   = .T.
785:         ENDWITH
786: 
787:         loc_oCnt.AddObject("lin_4c_line13", "Line")
788:         WITH loc_oCnt.lin_4c_line13
789:             .Top     = 22
790:             .Left    = 12
791:             .Width   = 340
792:             .Height  = 0
793:             .Visible = .T.
794:         ENDWITH
795: 

*-- Linhas 846 a 918:
846:             .Value    = ""
847:             .Visible  = .T.
848:         ENDWITH
849:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsKeyPress")
850:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsLostFocus")
851: 
852:         loc_oCnt.AddObject("txt_4c_ContaDs", "TextBox")
853:         WITH loc_oCnt.txt_4c_ContaDs
854:             .Top      = 42
855:             .Left     = 96
856:             .Width    = 80
857:             .Height   = 22
858:             .FontName = "Tahoma"
859:             .FontSize = 8
860:             .Value    = ""
861:             .Visible  = .T.
862:         ENDWITH
863:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsKeyPress")
864:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsLostFocus")
865: 
866:         loc_oCnt.AddObject("txt_4c_NomeContaDs", "TextBox")
867:         WITH loc_oCnt.txt_4c_NomeContaDs
868:             .Top      = 42
869:             .Left     = 180
870:             .Width    = 360
871:             .Height   = 22
872:             .FontName = "Tahoma"
873:             .FontSize = 8
874:             .Value    = ""
875:             .ReadOnly = .T.
876:             .Visible  = .T.
877:         ENDWITH
878:         BINDEVENT(loc_oCnt.txt_4c_NomeContaDs, "KeyPress", THIS, "TxtNomeContaDsKeyPress")
879: 
880:         *-- Container Responsavel: Grupo/Conta/Nome do Responsavel (top=508+29=537)
881:         loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
882:         WITH loc_oPagina.cnt_4c_Responsavel
883:             .Top         = 537
884:             .Left        = 214
885:             .Width       = 571
886:             .Height      = 75
887:             .BackStyle   = 1
888:             .BackColor   = RGB(236, 233, 216)
889:             .BorderWidth = 0
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         loc_oCnt = loc_oPagina.cnt_4c_Responsavel
894: 
895:         loc_oCnt.AddObject("lbl_4c_label43", "Label")
896:         WITH loc_oCnt.lbl_4c_label43
897:             .Caption   = "Respons" + CHR(225) + "vel"
898:             .Top       = 6
899:             .Left      = 11
900:             .Width     = 80
901:             .Height    = 17
902:             .FontName  = "Tahoma"
903:             .FontSize  = 8
904:             .FontBold  = .T.
905:             .ForeColor = RGB(90, 90, 90)
906:             .BackStyle = 0
907:             .Visible   = .T.
908:         ENDWITH
909: 
910:         loc_oCnt.AddObject("lin_4c_line14", "Line")
911:         WITH loc_oCnt.lin_4c_line14
912:             .Top     = 22
913:             .Left    = 12
914:             .Width   = 340
915:             .Height  = 0
916:             .Visible = .T.
917:         ENDWITH
918: 

*-- Linhas 969 a 2099:
969:             .Value    = ""
970:             .Visible  = .T.
971:         ENDWITH
972:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsKeyPress")
973:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsLostFocus")
974: 
975:         loc_oCnt.AddObject("txt_4c_Vends", "TextBox")
976:         WITH loc_oCnt.txt_4c_Vends
977:             .Top      = 42
978:             .Left     = 96
979:             .Width    = 80
980:             .Height   = 22
981:             .FontName = "Tahoma"
982:             .FontSize = 8
983:             .Value    = ""
984:             .Visible  = .T.
985:         ENDWITH
986:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsKeyPress")
987:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsLostFocus")
988: 
989:         loc_oCnt.AddObject("txt_4c_NomeVends", "TextBox")
990:         WITH loc_oCnt.txt_4c_NomeVends
991:             .Top      = 42
992:             .Left     = 180
993:             .Width    = 360
994:             .Height   = 22
995:             .FontName = "Tahoma"
996:             .FontSize = 8
997:             .Value    = ""
998:             .ReadOnly = .T.
999:             .Visible  = .T.
1000:         ENDWITH
1001:         BINDEVENT(loc_oCnt.txt_4c_NomeVends, "KeyPress", THIS, "TxtNomeVendsKeyPress")
1002: 
1003:         *-- Grade de Operacao (top=68+29=97, Visible=.F. por padrao)
1004:         loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
1005:         WITH loc_oPagina.grd_4c_GradeOperacao
1006:             .Top         = 97
1007:             .Left        = 266
1008:             .Width       = 171
1009:             .Height      = 182
1010:             .ColumnCount = 1
1011:             .FontName    = "Tahoma"
1012:             .FontSize    = 8
1013:             .ForeColor   = RGB(90, 90, 90)
1014:             .BackColor   = RGB(255, 255, 255)
1015:             .DeleteMark  = .F.
1016:             .RecordMark  = .F.
1017:             .RowHeight   = 16
1018:             .ScrollBars  = 2
1019:             .GridLines   = 3
1020:             .ReadOnly    = .T.
1021:             .Visible     = .F.
1022:         ENDWITH
1023: 
1024:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1025:             .Width           = 165
1026:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1027:         ENDWITH
1028: 
1029:         *-- Botao de Ordens ao lado da grade (top=69+29=98)
1030:         loc_oPagina.AddObject("cmd_4c_BotOrdens", "CommandButton")
1031:         WITH loc_oPagina.cmd_4c_BotOrdens
1032:             .Caption       = "..."
1033:             .Top           = 98
1034:             .Left          = 440
1035:             .Width         = 40
1036:             .Height        = 40
1037:             .BackColor     = RGB(255, 255, 255)
1038:             .ForeColor     = RGB(90, 90, 90)
1039:             .FontName      = "Tahoma"
1040:             .FontSize      = 8
1041:             .Themes        = .F.
1042:             .SpecialEffect = 0
1043:             .Visible       = .T.
1044:         ENDWITH
1045:         BINDEVENT(loc_oPagina.cmd_4c_BotOrdens, "Click", THIS, "BtnBotOrdensClick")
1046: 
1047:         THIS.TornarControlesVisiveis(loc_oPagina)
1048:     ENDPROC
1049: 
1050:     *==========================================================================
1051:     * NAVEGA??O
1052:     *==========================================================================
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * CarregarLista - Carrega registros no grid da Page1
1056:     *--------------------------------------------------------------------------
1057:     PROCEDURE CarregarLista()
1058:         LOCAL loc_lResultado, loc_oGrid
1059:         loc_lResultado = .F.
1060: 
1061:         TRY
1062:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1063:                 loc_lResultado = .T.
1064:             ELSE
1065:                 IF !THIS.this_oBusinessObject.Buscar("")
1066:                     loc_lResultado = .F.
1067:                 ELSE
1068:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1069: 
1070:                     loc_oGrid.ColumnCount = 7
1071:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1072:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1073:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1074:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grupoos"
1075:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.contaos"
1076:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupods"
1077:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contads"
1078:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usuars"
1079: 
1080:                     *-- Reconfigurar headers ap?s RecordSource (VFP reseta ao mudar RecordSource)
1081:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1082:                     loc_oGrid.Column2.Header1.Caption = "Data"
1083:                     loc_oGrid.Column3.Header1.Caption = "Gr. Origem"
1084:                     loc_oGrid.Column4.Header1.Caption = "Ct. Origem"
1085:                     loc_oGrid.Column5.Header1.Caption = "Gr. Destino"
1086:                     loc_oGrid.Column6.Header1.Caption = "Ct. Destino"
1087:                     loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
1088: 
1089:                     THIS.FormatarGridLista(loc_oGrid)
1090:                     loc_lResultado = .T.
1091:                 ENDIF
1092:             ENDIF
1093:         CATCH TO loc_oErro
1094:             MsgErro("Erro em CarregarLista: " + loc_oErro.Message + CHR(13) + ;
1095:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1096:             loc_lResultado = .F.
1097:         ENDTRY
1098: 
1099:         RETURN loc_lResultado
1100:     ENDPROC
1101: 
1102:     *--------------------------------------------------------------------------
1103:     * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
1104:     *--------------------------------------------------------------------------
1105:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1106:         LOCAL loc_lResultado
1107:         loc_lResultado = .F.
1108: 
1109:         TRY
1110:             IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
1111:                 loc_lResultado = .F.
1112:             ELSE
1113:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1114:                 IF par_nPagina = 1
1115:                     THIS.CarregarLista()
1116:                 ENDIF
1117:                 loc_lResultado = .T.
1118:             ENDIF
1119:         CATCH TO loc_oErro
1120:             MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
1121:             loc_lResultado = .F.
1122:         ENDTRY
1123: 
1124:         RETURN loc_lResultado
1125:     ENDPROC
1126: 
1127:     *==========================================================================
1128:     * AUXILIARES
1129:     *==========================================================================
1130: 
1131:     *--------------------------------------------------------------------------
1132:     * TornarControlesVisiveis - Torna controles vis?veis recursivamente
1133:     *--------------------------------------------------------------------------
1134:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1135:         LOCAL loc_nI, loc_oObjeto, loc_nP
1136: 
1137:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1138:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1139: 
1140:             IF VARTYPE(loc_oObjeto) = "O"
1141:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1142:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "GRD_4C_GRADEOPERACAO")
1143:                         loc_oObjeto.Visible = .T.
1144:                     ENDIF
1145:                 ENDIF
1146: 
1147:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1148:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1149:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1150:                     ENDFOR
1151:                 ENDIF
1152: 
1153:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1154:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1155:                 ENDIF
1156:             ENDIF
1157:         ENDFOR
1158:     ENDPROC
1159: 
1160:     *--------------------------------------------------------------------------
1161:     * FormatarGridLista - Formata visual do grid
1162:     *--------------------------------------------------------------------------
1163:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1164:         WITH par_oGrid
1165:             .FontName = "Tahoma"
1166:             .FontSize = 8
1167:         ENDWITH
1168:     ENDPROC
1169: 
1170:     *==========================================================================
1171:     * EVENTOS DOS BOT?ES - Page1 (Lista)
1172:     *==========================================================================
1173: 
1174:     *--------------------------------------------------------------------------
1175:     * BtnIncluirClick - Prepara formul?rio para inclus?o de novo registro
1176:     *--------------------------------------------------------------------------
1177:     PROCEDURE BtnIncluirClick()
1178:         THIS.this_oBusinessObject.NovoRegistro()
1179:         THIS.this_cModoAtual = "INCLUIR"
1180:         THIS.LimparCampos()
1181:         THIS.HabilitarCampos(.T.)
1182:         THIS.AjustarBotoesPorModo()
1183:         THIS.AlternarPagina(2)
1184:     ENDPROC
1185: 
1186:     *--------------------------------------------------------------------------
1187:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1188:     *--------------------------------------------------------------------------
1189:     PROCEDURE BtnVisualizarClick()
1190:         LOCAL loc_cChave
1191:         loc_cChave = ""
1192: 
1193:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1194:            EOF("cursor_4c_Dados")
1195:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1196:         ELSE
1197:             SELECT cursor_4c_Dados
1198:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1199:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1200:                 THIS.this_cModoAtual = "VISUALIZAR"
1201:                 THIS.BOParaForm()
1202:                 THIS.HabilitarCampos(.F.)
1203:                 THIS.AjustarBotoesPorModo()
1204:                 THIS.AlternarPagina(2)
1205:             ENDIF
1206:         ENDIF
1207:     ENDPROC
1208: 
1209:     *--------------------------------------------------------------------------
1210:     * BtnAlterarClick - Carrega registro selecionado para edi??o
1211:     *--------------------------------------------------------------------------
1212:     PROCEDURE BtnAlterarClick()
1213:         LOCAL loc_cChave
1214:         loc_cChave = ""
1215: 
1216:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1217:            EOF("cursor_4c_Dados")
1218:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1219:         ELSE
1220:             SELECT cursor_4c_Dados
1221:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1222:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1223:                 THIS.this_oBusinessObject.EditarRegistro()
1224:                 THIS.this_cModoAtual = "ALTERAR"
1225:                 THIS.BOParaForm()
1226:                 THIS.HabilitarCampos(.T.)
1227:                 THIS.AjustarBotoesPorModo()
1228:                 THIS.AlternarPagina(2)
1229:             ENDIF
1230:         ENDIF
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------
1234:     * BtnExcluirClick - Exclui registro selecionado ap?s confirma??o
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE BtnExcluirClick()
1237:         LOCAL loc_cChave, loc_nNumero
1238:         loc_cChave  = ""
1239:         loc_nNumero = 0
1240: 
1241:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1242:            EOF("cursor_4c_Dados")
1243:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1244:         ELSE
1245:             SELECT cursor_4c_Dados
1246:             loc_cChave  = ALLTRIM(cursor_4c_Dados.empdnps)
1247:             loc_nNumero = cursor_4c_Dados.numps
1248: 
1249:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1250:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
1251:                                TRANSFORM(loc_nNumero) + "?", "Excluir")
1252:                     IF THIS.this_oBusinessObject.Excluir()
1253:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1254:                         THIS.CarregarLista()
1255:                     ENDIF
1256:                 ENDIF
1257:             ENDIF
1258:         ENDIF
1259:     ENDPROC
1260: 
1261:     *--------------------------------------------------------------------------
1262:     * BtnBuscarClick - Recarrega lista (refresh)
1263:     *--------------------------------------------------------------------------
1264:     PROCEDURE BtnBuscarClick()
1265:         THIS.CarregarLista()
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * BtnEncerrarClick - Fecha o formul?rio
1270:     *--------------------------------------------------------------------------
1271:     PROCEDURE BtnEncerrarClick()
1272:         THIS.Release()
1273:     ENDPROC
1274: 
1275:     *==========================================================================
1276:     * EVENTOS DOS BOT" + CHR(213) + "ES - Page2 (Dados)
1277:     *==========================================================================
1278: 
1279:     *--------------------------------------------------------------------------
1280:     * BtnSalvarClick - Salva registro (Inserir ou Atualizar)
1281:     *--------------------------------------------------------------------------
1282:     PROCEDURE BtnSalvarClick()
1283:         LOCAL loc_lResultado
1284:         loc_lResultado = .F.
1285: 
1286:         IF !THIS.ValidarDados()
1287:             RETURN
1288:         ENDIF
1289: 
1290:         TRY
1291:             THIS.FormParaBO()
1292:             IF THIS.this_oBusinessObject.Salvar()
1293:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1294:                 THIS.this_cModoAtual = "LISTA"
1295:                 THIS.AlternarPagina(1)
1296:                 loc_lResultado = .T.
1297:             ENDIF
1298:         CATCH TO loc_oErro
1299:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + CHR(13) + ;
1300:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1301:             loc_lResultado = .F.
1302:         ENDTRY
1303: 
1304:         RETURN loc_lResultado
1305:     ENDPROC
1306: 
1307:     *--------------------------------------------------------------------------
1308:     * BtnCancelarClick - Cancela e volta para lista
1309:     *--------------------------------------------------------------------------
1310:     PROCEDURE BtnCancelarClick()
1311:         THIS.this_cModoAtual = "LISTA"
1312:         THIS.AlternarPagina(1)
1313:     ENDPROC
1314: 
1315:     *--------------------------------------------------------------------------
1316:     * BtnOperacaoClick - Abre form de Movimento de Opera" + CHR(231) + CHR(227) + "o (SigOpMpd)
1317:     *--------------------------------------------------------------------------
1318:     PROCEDURE BtnOperacaoClick()
1319:         LOCAL loc_lResultado
1320:         loc_lResultado = .F.
1321: 
1322:         IF INLIST(THIS.this_cModoAtual, "ALTERAR", "VISUALIZAR")
1323:             THIS.Enabled = .F.
1324:             TRY
1325:                 DO FORM FormSigOpMpd WITH THIS
1326:                 loc_lResultado = .T.
1327:             CATCH TO loc_oErro
1328:                 MsgErro("Erro ao abrir Movimento de Opera" + CHR(231) + CHR(227) + "o:" + ;
1329:                         CHR(13) + loc_oErro.Message, "Erro")
1330:                 loc_lResultado = .F.
1331:             ENDTRY
1332:             THIS.Enabled = .T.
1333:         ENDIF
1334: 
1335:         RETURN loc_lResultado
1336:     ENDPROC
1337: 
1338:     *--------------------------------------------------------------------------
1339:     * BtnBoletoClick - Imprime boleto se opera" + CHR(231) + CHR(227) + "o permite
1340:     *--------------------------------------------------------------------------
1341:     PROCEDURE BtnBoletoClick()
1342:         LOCAL loc_lResultado, loc_lTemBoleto
1343:         loc_lResultado = .F.
1344:         loc_lTemBoleto = .F.
1345: 
1346:         TRY
1347:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1348:                 SELECT cursor_4c_OpConfig
1349:                 loc_lTemBoleto = (cursor_4c_OpConfig.boletos = 1)
1350:             ENDIF
1351: 
1352:             IF loc_lTemBoleto
1353:                 THIS.ImprimirBoleto()
1354:                 loc_lResultado = .T.
1355:             ENDIF
1356:         CATCH TO loc_oErro
1357:             MsgErro("Erro em BtnBoletoClick: " + loc_oErro.Message, "Erro")
1358:             loc_lResultado = .F.
1359:         ENDTRY
1360: 
1361:         RETURN loc_lResultado
1362:     ENDPROC
1363: 
1364:     *--------------------------------------------------------------------------
1365:     * ImprimirBoleto - Imprime boleto banc" + CHR(225) + "rio do registro selecionado
1366:     *--------------------------------------------------------------------------
1367:     PROCEDURE ImprimirBoleto()
1368:         LOCAL loc_lResultado
1369:         loc_lResultado = .F.
1370: 
1371:         TRY
1372:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1373:                 SELECT cursor_4c_Dados
1374:                 DO SigPrBol WITH ALLTRIM(cursor_4c_Dados.emps), ;
1375:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1376:                                   cursor_4c_Dados.numps
1377:                 loc_lResultado = .T.
1378:             ENDIF
1379:         CATCH TO loc_oErro
1380:             MsgErro("Erro ao imprimir boleto: " + loc_oErro.Message, "Erro")
1381:             loc_lResultado = .F.
1382:         ENDTRY
1383: 
1384:         RETURN loc_lResultado
1385:     ENDPROC
1386: 
1387:     *--------------------------------------------------------------------------
1388:     * BtnDocumentoClick - Imprime documento se opera" + CHR(231) + CHR(227) + "o permite
1389:     *--------------------------------------------------------------------------
1390:     PROCEDURE BtnDocumentoClick()
1391:         LOCAL loc_lResultado, loc_lTemDoc, loc_nQtdDocs
1392:         loc_lResultado = .F.
1393:         loc_lTemDoc    = .F.
1394:         loc_nQtdDocs   = 0
1395: 
1396:         TRY
1397:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1398:                 SELECT cursor_4c_OpConfig
1399:                 loc_lTemDoc  = (cursor_4c_OpConfig.docus = 1)
1400:                 loc_nQtdDocs = cursor_4c_OpConfig.qtddocs
1401:             ENDIF
1402: 
1403:             IF loc_lTemDoc AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1404:                 SELECT cursor_4c_Dados
1405:                 DO SigPrIdc WITH ALLTRIM(cursor_4c_Dados.emps), ;
1406:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1407:                                   cursor_4c_Dados.numps, 0, ;
1408:                                   loc_nQtdDocs, ;
1409:                                   .F., .F., .F., .F., .F., .F., THIS
1410:                 loc_lResultado = .T.
1411:             ENDIF
1412:         CATCH TO loc_oErro
1413:             MsgErro("Erro em BtnDocumentoClick: " + loc_oErro.Message, "Erro")
1414:             loc_lResultado = .F.
1415:         ENDTRY
1416: 
1417:         RETURN loc_lResultado
1418:     ENDPROC
1419: 
1420:     *==========================================================================
1421:     * VALIDA" + CHR(199) + CHR(195) + "O
1422:     *==========================================================================
1423: 
1424:     *--------------------------------------------------------------------------
1425:     * ValidarDados - Valida campos obrigat" + CHR(243) + "rios da Page2 antes de salvar
1426:     *--------------------------------------------------------------------------
1427:     PROTECTED PROCEDURE ValidarDados()
1428:         LOCAL loc_lValido, loc_oPg2
1429:         loc_lValido = .T.
1430:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1431: 
1432:         IF EMPTY(loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value)
1433:             MsgAviso("Data " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
1434:                      "Valida" + CHR(231) + CHR(227) + "o")
1435:             loc_oPg2.cnt_4c_Container1.txt_4c_Datas.SetFocus
1436:             loc_lValido = .F.
1437:         ENDIF
1438: 
1439:         IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value))
1440:             MsgAviso("Grupo de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1441:                      "Valida" + CHR(231) + CHR(227) + "o")
1442:             loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.SetFocus
1443:             loc_lValido = .F.
1444:         ENDIF
1445: 
1446:         IF loc_lValido AND ;
1447:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)) AND ;
1448:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value))
1449:             MsgAviso("Conta ou Nome de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1450:                      "Valida" + CHR(231) + CHR(227) + "o")
1451:             loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.SetFocus
1452:             loc_lValido = .F.
1453:         ENDIF
1454: 
1455:         IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value))
1456:             MsgAviso("Grupo de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1457:                      "Valida" + CHR(231) + CHR(227) + "o")
1458:             loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.SetFocus
1459:             loc_lValido = .F.
1460:         ENDIF
1461: 
1462:         IF loc_lValido AND ;
1463:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)) AND ;
1464:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value))
1465:             MsgAviso("Conta ou Nome de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1466:                      "Valida" + CHR(231) + CHR(227) + "o")
1467:             loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.SetFocus
1468:             loc_lValido = .F.
1469:         ENDIF
1470: 
1471:         RETURN loc_lValido
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * LOOKUPS - ORIGEM
1476:     *==========================================================================
1477: 
1478:     *--------------------------------------------------------------------------
1479:     * TxtGrupoOsKeyPress - F4 abre lookup de Grupos Cont" + CHR(225) + "beis (Origem)
1480:     *--------------------------------------------------------------------------
1481:     PROCEDURE TxtGrupoOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1482:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1483:             THIS.AbrirLookupGrupoOs()
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *--------------------------------------------------------------------------
1488:     * TxtGrupoOsLostFocus - Valida Grupo de Origem ao sair do campo
1489:     *--------------------------------------------------------------------------
1490:     PROCEDURE TxtGrupoOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1491:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1492:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1493:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
1494: 
1495:         IF !EMPTY(loc_cGrupo)
1496:             TRY
1497:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1498:                               EscaparSQL(loc_cGrupo)
1499:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOsVal")
1500: 
1501:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoOsVal") OR ;
1502:                    RECCOUNT("cursor_4c_GrupoOsVal") = 0
1503:                     THIS.AbrirLookupGrupoOs()
1504:                 ENDIF
1505: 
1506:                 IF USED("cursor_4c_GrupoOsVal")
1507:                     USE IN cursor_4c_GrupoOsVal
1508:                 ENDIF
1509:             CATCH TO loc_oErro
1510:                 MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
1511:             ENDTRY
1512:         ENDIF
1513:     ENDPROC
1514: 
1515:     *--------------------------------------------------------------------------
1516:     * AbrirLookupGrupoOs - Abre picker de Grupos Cont" + CHR(225) + "beis (SigCdGcr)
1517:     *--------------------------------------------------------------------------
1518:     PROCEDURE AbrirLookupGrupoOs()
1519:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1520:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1521:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
1522: 
1523:         TRY
1524:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1525:                                       "SigCdGcr", "cursor_4c_BuscaGrupoOs", ;
1526:                                       "Codigos", loc_cValor, ;
1527:                                       "Grupos Cont" + CHR(225) + "beis")
1528:             IF VARTYPE(loc_oBusca) = "O"
1529:                 IF !loc_oBusca.this_lAchouRegistro
1530:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1531:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1532:                     loc_oBusca.Show()
1533:                 ENDIF
1534:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoOs")
1535:                     SELECT cursor_4c_BuscaGrupoOs
1536:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(cursor_4c_BuscaGrupoOs.Codigos)
1537:                 ENDIF
1538:                 loc_oBusca.Release()
1539:             ENDIF
1540:         CATCH TO loc_oErro
1541:             MsgErro("Erro ao abrir busca de Grupos: " + loc_oErro.Message, "Erro")
1542:         ENDTRY
1543: 
1544:         IF USED("cursor_4c_BuscaGrupoOs")
1545:             USE IN cursor_4c_BuscaGrupoOs
1546:         ENDIF
1547:     ENDPROC
1548: 
1549:     *--------------------------------------------------------------------------
1550:     * TxtContaOsKeyPress - F4 abre lookup de Contas por C" + CHR(243) + "digo (Origem)
1551:     *--------------------------------------------------------------------------
1552:     PROCEDURE TxtContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1553:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1554:             THIS.AbrirLookupContaOs()
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     *--------------------------------------------------------------------------
1559:     * TxtContaOsLostFocus - Valida Conta e preenche Nome de Origem ao sair
1560:     *--------------------------------------------------------------------------
1561:     PROCEDURE TxtContaOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1562:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1563:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1564:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
1565: 
1566:         IF !EMPTY(loc_cConta)
1567:             TRY
1568:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1569:                               EscaparSQL(loc_cConta)
1570:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOsVal")
1571: 
1572:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaOsVal") AND ;
1573:                    RECCOUNT("cursor_4c_ContaOsVal") > 0
1574:                     SELECT cursor_4c_ContaOsVal
1575:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_ContaOsVal.RClis)
1576:                 ELSE
1577:                     THIS.AbrirLookupContaOs()
1578:                 ENDIF
1579: 
1580:                 IF USED("cursor_4c_ContaOsVal")
1581:                     USE IN cursor_4c_ContaOsVal
1582:                 ENDIF
1583:             CATCH TO loc_oErro
1584:                 MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
1585:             ENDTRY
1586:         ENDIF
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * AbrirLookupContaOs - Abre picker de Contas por C" + CHR(243) + "digo (SigCdCli.IClis)
1591:     *--------------------------------------------------------------------------
1592:     PROCEDURE AbrirLookupContaOs()
1593:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1594:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1595:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
1596: 
1597:         TRY
1598:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1599:                                       "SigCdCli", "cursor_4c_BuscaContaOs", ;
1600:                                       "IClis", loc_cValor, ;
1601:                                       "Contas")
1602:             IF VARTYPE(loc_oBusca) = "O"
1603:                 IF !loc_oBusca.this_lAchouRegistro
1604:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1605:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1606:                     loc_oBusca.Show()
1607:                 ENDIF
1608:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOs")
1609:                     SELECT cursor_4c_BuscaContaOs
1610:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(cursor_4c_BuscaContaOs.IClis)
1611:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaContaOs.RClis)
1612:                 ENDIF
1613:                 loc_oBusca.Release()
1614:             ENDIF
1615:         CATCH TO loc_oErro
1616:             MsgErro("Erro ao abrir busca de Contas: " + loc_oErro.Message, "Erro")
1617:         ENDTRY
1618: 
1619:         IF USED("cursor_4c_BuscaContaOs")
1620:             USE IN cursor_4c_BuscaContaOs
1621:         ENDIF
1622:     ENDPROC
1623: 
1624:     *--------------------------------------------------------------------------
1625:     * TxtNomeContaOsKeyPress - F4 abre lookup de Contas por Nome (Origem)
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE TxtNomeContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1628:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1629:             THIS.AbrirLookupNomeContaOs()
1630:         ENDIF
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     * AbrirLookupNomeContaOs - Abre picker de Contas por Nome (SigCdCli.RClis)
1635:     *--------------------------------------------------------------------------
1636:     PROCEDURE AbrirLookupNomeContaOs()
1637:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1638:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1639:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value)
1640: 
1641:         TRY
1642:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1643:                                       "SigCdCli", "cursor_4c_BuscaNomeContaOs", ;
1644:                                       "RClis", loc_cValor, ;
1645:                                       "Contas por Nome")
1646:             IF VARTYPE(loc_oBusca) = "O"
1647:                 IF !loc_oBusca.this_lAchouRegistro
1648:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1649:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1650:                     loc_oBusca.Show()
1651:                 ENDIF
1652:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaOs")
1653:                     SELECT cursor_4c_BuscaNomeContaOs
1654:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value     = ALLTRIM(cursor_4c_BuscaNomeContaOs.IClis)
1655:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaNomeContaOs.RClis)
1656:                 ENDIF
1657:                 loc_oBusca.Release()
1658:             ENDIF
1659:         CATCH TO loc_oErro
1660:             MsgErro("Erro ao abrir busca por Nome: " + loc_oErro.Message, "Erro")
1661:         ENDTRY
1662: 
1663:         IF USED("cursor_4c_BuscaNomeContaOs")
1664:             USE IN cursor_4c_BuscaNomeContaOs
1665:         ENDIF
1666:     ENDPROC
1667: 
1668:     *==========================================================================
1669:     * LOOKUPS - DESTINO
1670:     *==========================================================================
1671: 
1672:     *--------------------------------------------------------------------------
1673:     * TxtGrupoDsKeyPress - F4 abre lookup de Grupos Contabeis (Destino)
1674:     *--------------------------------------------------------------------------
1675:     PROCEDURE TxtGrupoDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1676:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1677:             THIS.AbrirLookupGrupoDs()
1678:         ENDIF
1679:     ENDPROC
1680: 
1681:     *--------------------------------------------------------------------------
1682:     * TxtGrupoDsLostFocus - Valida Grupo de Destino ao sair do campo
1683:     *--------------------------------------------------------------------------
1684:     PROCEDURE TxtGrupoDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1685:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1686:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1687:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
1688: 
1689:         IF !EMPTY(loc_cGrupo)
1690:             TRY
1691:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1692:                               EscaparSQL(loc_cGrupo)
1693:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDsVal")
1694: 
1695:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoDsVal") OR ;
1696:                    RECCOUNT("cursor_4c_GrupoDsVal") = 0
1697:                     THIS.AbrirLookupGrupoDs()
1698:                 ENDIF
1699: 
1700:                 IF USED("cursor_4c_GrupoDsVal")
1701:                     USE IN cursor_4c_GrupoDsVal
1702:                 ENDIF
1703:             CATCH TO loc_oErro
1704:                 MsgErro("Erro ao validar Grupo Destino: " + loc_oErro.Message, "Erro")
1705:             ENDTRY
1706:         ENDIF
1707:     ENDPROC
1708: 
1709:     *--------------------------------------------------------------------------
1710:     * AbrirLookupGrupoDs - Abre picker de Grupos Contabeis (SigCdGcr) - Destino
1711:     *--------------------------------------------------------------------------
1712:     PROCEDURE AbrirLookupGrupoDs()
1713:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1714:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1715:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
1716: 
1717:         TRY
1718:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1719:                                       "SigCdGcr", "cursor_4c_BuscaGrupoDs", ;
1720:                                       "Codigos", loc_cValor, ;
1721:                                       "Grupos Cont" + CHR(225) + "beis")
1722:             IF VARTYPE(loc_oBusca) = "O"
1723:                 IF !loc_oBusca.this_lAchouRegistro
1724:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1725:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1726:                     loc_oBusca.Show()
1727:                 ENDIF
1728:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDs")
1729:                     SELECT cursor_4c_BuscaGrupoDs
1730:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(cursor_4c_BuscaGrupoDs.Codigos)
1731:                 ENDIF
1732:                 loc_oBusca.Release()
1733:             ENDIF
1734:         CATCH TO loc_oErro
1735:             MsgErro("Erro ao abrir busca de Grupos Destino: " + loc_oErro.Message, "Erro")
1736:         ENDTRY
1737: 
1738:         IF USED("cursor_4c_BuscaGrupoDs")
1739:             USE IN cursor_4c_BuscaGrupoDs
1740:         ENDIF
1741:     ENDPROC
1742: 
1743:     *--------------------------------------------------------------------------
1744:     * TxtContaDsKeyPress - F4 abre lookup de Contas por Codigo (Destino)
1745:     *--------------------------------------------------------------------------
1746:     PROCEDURE TxtContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1747:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1748:             THIS.AbrirLookupContaDs()
1749:         ENDIF
1750:     ENDPROC
1751: 
1752:     *--------------------------------------------------------------------------
1753:     * TxtContaDsLostFocus - Valida Conta e preenche Nome de Destino ao sair
1754:     *--------------------------------------------------------------------------
1755:     PROCEDURE TxtContaDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1756:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1757:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1758:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
1759: 
1760:         IF !EMPTY(loc_cConta)
1761:             TRY
1762:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1763:                               EscaparSQL(loc_cConta)
1764:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")
1765: 
1766:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaDsVal") AND ;
1767:                    RECCOUNT("cursor_4c_ContaDsVal") > 0
1768:                     SELECT cursor_4c_ContaDsVal
1769:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
1770:                 ELSE
1771:                     THIS.AbrirLookupContaDs()
1772:                 ENDIF
1773: 
1774:                 IF USED("cursor_4c_ContaDsVal")
1775:                     USE IN cursor_4c_ContaDsVal
1776:                 ENDIF
1777:             CATCH TO loc_oErro
1778:                 MsgErro("Erro ao validar Conta Destino: " + loc_oErro.Message, "Erro")
1779:             ENDTRY
1780:         ENDIF
1781:     ENDPROC
1782: 
1783:     *--------------------------------------------------------------------------
1784:     * AbrirLookupContaDs - Abre picker de Contas por Codigo (SigCdCli) - Destino
1785:     *--------------------------------------------------------------------------
1786:     PROCEDURE AbrirLookupContaDs()
1787:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1788:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1789:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
1790: 
1791:         TRY
1792:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1793:                                       "SigCdCli", "cursor_4c_BuscaContaDs", ;
1794:                                       "IClis", loc_cValor, ;
1795:                                       "Contas")
1796:             IF VARTYPE(loc_oBusca) = "O"
1797:                 IF !loc_oBusca.this_lAchouRegistro
1798:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1799:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1800:                     loc_oBusca.Show()
1801:                 ENDIF
1802:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")
1803:                     SELECT cursor_4c_BuscaContaDs
1804:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
1805:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
1806:                 ENDIF
1807:                 loc_oBusca.Release()
1808:             ENDIF
1809:         CATCH TO loc_oErro
1810:             MsgErro("Erro ao abrir busca de Contas Destino: " + loc_oErro.Message, "Erro")
1811:         ENDTRY
1812: 
1813:         IF USED("cursor_4c_BuscaContaDs")
1814:             USE IN cursor_4c_BuscaContaDs
1815:         ENDIF
1816:     ENDPROC
1817: 
1818:     *--------------------------------------------------------------------------
1819:     * TxtNomeContaDsKeyPress - F4 abre lookup de Contas por Nome (Destino)
1820:     *--------------------------------------------------------------------------
1821:     PROCEDURE TxtNomeContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1822:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1823:             THIS.AbrirLookupNomeContaDs()
1824:         ENDIF
1825:     ENDPROC
1826: 
1827:     *--------------------------------------------------------------------------
1828:     * AbrirLookupNomeContaDs - Abre picker de Contas por Nome - Destino
1829:     *--------------------------------------------------------------------------
1830:     PROCEDURE AbrirLookupNomeContaDs()
1831:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1832:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1833:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value)
1834: 
1835:         TRY
1836:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1837:                                       "SigCdCli", "cursor_4c_BuscaNomeContaDs", ;
1838:                                       "RClis", loc_cValor, ;
1839:                                       "Contas por Nome")
1840:             IF VARTYPE(loc_oBusca) = "O"
1841:                 IF !loc_oBusca.this_lAchouRegistro
1842:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1843:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1844:                     loc_oBusca.Show()
1845:                 ENDIF
1846:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaDs")
1847:                     SELECT cursor_4c_BuscaNomeContaDs
1848:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaNomeContaDs.IClis)
1849:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaNomeContaDs.RClis)
1850:                 ENDIF
1851:                 loc_oBusca.Release()
1852:             ENDIF
1853:         CATCH TO loc_oErro
1854:             MsgErro("Erro ao abrir busca por Nome Destino: " + loc_oErro.Message, "Erro")
1855:         ENDTRY
1856: 
1857:         IF USED("cursor_4c_BuscaNomeContaDs")
1858:             USE IN cursor_4c_BuscaNomeContaDs
1859:         ENDIF
1860:     ENDPROC
1861: 
1862:     *==========================================================================
1863:     * LOOKUPS - RESPONSAVEL
1864:     *==========================================================================
1865: 
1866:     *--------------------------------------------------------------------------
1867:     * TxtGrVendsKeyPress - F4 abre lookup de Grupos Contabeis (Responsavel)
1868:     *--------------------------------------------------------------------------
1869:     PROCEDURE TxtGrVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1870:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1871:             THIS.AbrirLookupGrVends()
1872:         ENDIF
1873:     ENDPROC
1874: 
1875:     *--------------------------------------------------------------------------
1876:     * TxtGrVendsLostFocus - Valida Grupo do Responsavel ao sair do campo
1877:     *--------------------------------------------------------------------------
1878:     PROCEDURE TxtGrVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1879:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1880:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1881:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
1882: 
1883:         IF !EMPTY(loc_cGrupo)
1884:             TRY
1885:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1886:                               EscaparSQL(loc_cGrupo)
1887:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVendsVal")
1888: 
1889:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrVendsVal") OR ;
1890:                    RECCOUNT("cursor_4c_GrVendsVal") = 0
1891:                     THIS.AbrirLookupGrVends()
1892:                 ENDIF
1893: 
1894:                 IF USED("cursor_4c_GrVendsVal")
1895:                     USE IN cursor_4c_GrVendsVal
1896:                 ENDIF
1897:             CATCH TO loc_oErro
1898:                 MsgErro("Erro ao validar Grupo Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1899:             ENDTRY
1900:         ENDIF
1901:     ENDPROC
1902: 
1903:     *--------------------------------------------------------------------------
1904:     * AbrirLookupGrVends - Abre picker de Grupos Contabeis - Responsavel
1905:     *--------------------------------------------------------------------------
1906:     PROCEDURE AbrirLookupGrVends()
1907:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1908:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1909:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
1910: 
1911:         TRY
1912:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1913:                                       "SigCdGcr", "cursor_4c_BuscaGrVends", ;
1914:                                       "Codigos", loc_cValor, ;
1915:                                       "Grupos Cont" + CHR(225) + "beis")
1916:             IF VARTYPE(loc_oBusca) = "O"
1917:                 IF !loc_oBusca.this_lAchouRegistro
1918:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1919:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1920:                     loc_oBusca.Show()
1921:                 ENDIF
1922:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVends")
1923:                     SELECT cursor_4c_BuscaGrVends
1924:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(cursor_4c_BuscaGrVends.Codigos)
1925:                 ENDIF
1926:                 loc_oBusca.Release()
1927:             ENDIF
1928:         CATCH TO loc_oErro
1929:             MsgErro("Erro ao abrir busca de Grupos Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1930:         ENDTRY
1931: 
1932:         IF USED("cursor_4c_BuscaGrVends")
1933:             USE IN cursor_4c_BuscaGrVends
1934:         ENDIF
1935:     ENDPROC
1936: 
1937:     *--------------------------------------------------------------------------
1938:     * TxtVendsKeyPress - F4 abre lookup de Contas por Codigo (Responsavel)
1939:     *--------------------------------------------------------------------------
1940:     PROCEDURE TxtVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1941:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1942:             THIS.AbrirLookupVends()
1943:         ENDIF
1944:     ENDPROC
1945: 
1946:     *--------------------------------------------------------------------------
1947:     * TxtVendsLostFocus - Valida Conta e preenche Nome do Responsavel ao sair
1948:     *--------------------------------------------------------------------------
1949:     PROCEDURE TxtVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1950:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1951:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1952:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
1953: 
1954:         IF !EMPTY(loc_cConta)
1955:             TRY
1956:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1957:                               EscaparSQL(loc_cConta)
1958:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendsVal")
1959: 
1960:                 IF loc_nResult >= 0 AND USED("cursor_4c_VendsVal") AND ;
1961:                    RECCOUNT("cursor_4c_VendsVal") > 0
1962:                     SELECT cursor_4c_VendsVal
1963:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_VendsVal.RClis)
1964:                 ELSE
1965:                     THIS.AbrirLookupVends()
1966:                 ENDIF
1967: 
1968:                 IF USED("cursor_4c_VendsVal")
1969:                     USE IN cursor_4c_VendsVal
1970:                 ENDIF
1971:             CATCH TO loc_oErro
1972:                 MsgErro("Erro ao validar Conta Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1973:             ENDTRY
1974:         ENDIF
1975:     ENDPROC
1976: 
1977:     *--------------------------------------------------------------------------
1978:     * AbrirLookupVends - Abre picker de Contas por Codigo - Responsavel
1979:     *--------------------------------------------------------------------------
1980:     PROCEDURE AbrirLookupVends()
1981:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1982:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1983:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
1984: 
1985:         TRY
1986:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1987:                                       "SigCdCli", "cursor_4c_BuscaVends", ;
1988:                                       "IClis", loc_cValor, ;
1989:                                       "Contas")
1990:             IF VARTYPE(loc_oBusca) = "O"
1991:                 IF !loc_oBusca.this_lAchouRegistro
1992:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1993:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1994:                     loc_oBusca.Show()
1995:                 ENDIF
1996:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVends")
1997:                     SELECT cursor_4c_BuscaVends
1998:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaVends.IClis)
1999:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaVends.RClis)
2000:                 ENDIF
2001:                 loc_oBusca.Release()
2002:             ENDIF
2003:         CATCH TO loc_oErro
2004:             MsgErro("Erro ao abrir busca de Contas Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2005:         ENDTRY
2006: 
2007:         IF USED("cursor_4c_BuscaVends")
2008:             USE IN cursor_4c_BuscaVends
2009:         ENDIF
2010:     ENDPROC
2011: 
2012:     *--------------------------------------------------------------------------
2013:     * TxtNomeVendsKeyPress - F4 abre lookup de Contas por Nome (Responsavel)
2014:     *--------------------------------------------------------------------------
2015:     PROCEDURE TxtNomeVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2016:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2017:             THIS.AbrirLookupNomeVends()
2018:         ENDIF
2019:     ENDPROC
2020: 
2021:     *--------------------------------------------------------------------------
2022:     * AbrirLookupNomeVends - Abre picker de Contas por Nome - Responsavel
2023:     *--------------------------------------------------------------------------
2024:     PROCEDURE AbrirLookupNomeVends()
2025:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
2026:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2027:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value)
2028: 
2029:         TRY
2030:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2031:                                       "SigCdCli", "cursor_4c_BuscaNomeVends", ;
2032:                                       "RClis", loc_cValor, ;
2033:                                       "Contas por Nome")
2034:             IF VARTYPE(loc_oBusca) = "O"
2035:                 IF !loc_oBusca.this_lAchouRegistro
2036:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
2037:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
2038:                     loc_oBusca.Show()
2039:                 ENDIF
2040:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeVends")
2041:                     SELECT cursor_4c_BuscaNomeVends
2042:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaNomeVends.IClis)
2043:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaNomeVends.RClis)
2044:                 ENDIF
2045:                 loc_oBusca.Release()
2046:             ENDIF
2047:         CATCH TO loc_oErro
2048:             MsgErro("Erro ao abrir busca por Nome Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2049:         ENDTRY
2050: 
2051:         IF USED("cursor_4c_BuscaNomeVends")
2052:             USE IN cursor_4c_BuscaNomeVends
2053:         ENDIF
2054:     ENDPROC
2055: 
2056:     *--------------------------------------------------------------------------
2057:     * BtnBotOrdensClick - Exibe/oculta grade de Ordens de Producao em aberto
2058:     *--------------------------------------------------------------------------
2059:     PROCEDURE BtnBotOrdensClick()
2060:         LOCAL loc_oPg2, loc_oGrade, loc_cSQL, loc_nResult, loc_lResultado
2061:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2062:         loc_oGrade    = loc_oPg2.grd_4c_GradeOperacao
2063:         loc_lResultado = .F.
2064: 
2065:         TRY
2066:             IF loc_oGrade.Visible
2067:                 loc_oGrade.Visible = .F.
2068:                 loc_lResultado     = .T.
2069:             ELSE
2070:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpDNps))
2071:                     loc_cSQL    = "SELECT a.nops AS nops FROM SigCdNei a" + ;
2072:                                   " WHERE a.empdnps = " + ;
2073:                                   EscaparSQL(THIS.this_oBusinessObject.this_cEmpDNps) + ;
2074:                                   " ORDER BY a.nops"
2075:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesTemp")
2076: 
2077:                     IF loc_nResult >= 0 AND USED("cursor_4c_OperacoesTemp")
2078:                         IF USED("cursor_4c_Operacoes")
2079:                             SELECT cursor_4c_Operacoes
2080:                             ZAP
2081:                             APPEND FROM DBF("cursor_4c_OperacoesTemp")
2082:                         ELSE
2083:                             SELECT * FROM cursor_4c_OperacoesTemp INTO CURSOR cursor_4c_Operacoes NOFILTER READWRITE
2084:                         ENDIF
2085:                         IF USED("cursor_4c_OperacoesTemp")
2086:                             USE IN cursor_4c_OperacoesTemp
2087:                         ENDIF
2088:                         loc_oGrade.ColumnCount = 1
2089:                         loc_oGrade.RecordSource          = "cursor_4c_Operacoes"
2090:                         loc_oGrade.Column1.ControlSource = "cursor_4c_Operacoes.nops"
2091:                         loc_oGrade.Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
2092:                         loc_oGrade.Visible = .T.
2093:                         loc_lResultado     = .T.
2094:                     ENDIF
2095:                 ELSE
2096:                     loc_oGrade.Visible = .T.
2097:                     loc_lResultado     = .T.
2098:                 ENDIF
2099:             ENDIF

*-- Linhas 2112 a 2172:
2112:     *--------------------------------------------------------------------------
2113:     * FormParaBO - Transfere valores do Form para o BO
2114:     *--------------------------------------------------------------------------
2115:     PROTECTED PROCEDURE FormParaBO()
2116:         LOCAL loc_oPg2
2117:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2118: 
2119:         THIS.this_oBusinessObject.this_nNumps   = loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value
2120:         THIS.this_oBusinessObject.this_dDatas   = loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value
2121:         THIS.this_oBusinessObject.this_cGrupoOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
2122:         THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
2123:         THIS.this_oBusinessObject.this_cGrupoDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
2124:         THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
2125:         THIS.this_oBusinessObject.this_cGrVends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
2126:         THIS.this_oBusinessObject.this_cVends   = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
2127:     ENDPROC
2128: 
2129:     *--------------------------------------------------------------------------
2130:     * BOParaForm - Transfere valores do BO para o Form
2131:     *--------------------------------------------------------------------------
2132:     PROTECTED PROCEDURE BOParaForm()
2133:         LOCAL loc_oPg2, loc_cSQL, loc_nResult
2134:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2135: 
2136:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value  = THIS.this_oBusinessObject.this_nNumps
2137:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value  = THIS.this_oBusinessObject.this_dDatas
2138:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOs)
2139:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOs)
2140:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ""
2141: 
2142:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2143:             TRY
2144:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2145:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2146:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeOsBo")
2147:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeOsBo") AND ;
2148:                    RECCOUNT("cursor_4c_NomeOsBo") > 0
2149:                     SELECT cursor_4c_NomeOsBo
2150:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_NomeOsBo.RClis)
2151:                 ENDIF
2152:                 IF USED("cursor_4c_NomeOsBo")
2153:                     USE IN cursor_4c_NomeOsBo
2154:                 ENDIF
2155:             CATCH TO loc_oErro
2156:                 MsgErro("Erro ao carregar nome conta origem: " + loc_oErro.Message, "Erro")
2157:             ENDTRY
2158:         ENDIF
2159: 
2160:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDs)
2161:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDs)
2162:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
2163: 
2164:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2165:             TRY
2166:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2167:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2168:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeDsBo")
2169:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeDsBo") AND ;
2170:                    RECCOUNT("cursor_4c_NomeDsBo") > 0
2171:                     SELECT cursor_4c_NomeDsBo
2172:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_NomeDsBo.RClis)

*-- Linhas 2205 a 2276:
2205:     *--------------------------------------------------------------------------
2206:     * HabilitarCampos - Habilita/desabilita campos editaveis na Page2
2207:     *--------------------------------------------------------------------------
2208:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2209:         LOCAL loc_oPg2
2210:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2211: 
2212:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.ReadOnly = ;
2213:             !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
2214:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.ReadOnly   = !par_lHabilitar
2215:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Enabled      = par_lHabilitar
2216:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Enabled      = par_lHabilitar
2217:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.ReadOnly  = .T.
2218:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Enabled     = par_lHabilitar
2219:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Enabled     = par_lHabilitar
2220:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.ReadOnly = .T.
2221:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Enabled  = par_lHabilitar
2222:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Enabled    = par_lHabilitar
2223:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.ReadOnly = .T.
2224:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2225:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2226:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2227:     ENDPROC
2228: 
2229:     *--------------------------------------------------------------------------
2230:     * LimparCampos - Limpa valores dos campos na Page2
2231:     *--------------------------------------------------------------------------
2232:     PROTECTED PROCEDURE LimparCampos()
2233:         LOCAL loc_oPg2
2234:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2235: 
2236:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value    = 0
2237:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value    = {}
2238:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value      = ""
2239:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value      = ""
2240:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value  = ""
2241:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value     = ""
2242:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value     = ""
2243:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
2244:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value  = ""
2245:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ""
2246:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ""
2247:         loc_oPg2.grd_4c_GradeOperacao.Visible = .F.
2248:     ENDPROC
2249: 
2250:     *--------------------------------------------------------------------------
2251:     * AjustarBotoesPorModo - Ajusta estados dos bot" + CHR(245) + "es conforme modo atual
2252:     *--------------------------------------------------------------------------
2253:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2254:         LOCAL loc_oPg2, loc_lEditando
2255:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2256:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2257: 
2258:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
2259:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2260:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2261:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2262:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2263:     ENDPROC
2264: 
2265:     *==========================================================================
2266:     * DESTRUI" + CHR(199) + CHR(195) + "O
2267:     *==========================================================================
2268: 
2269:     PROCEDURE Destroy()
2270:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2271:             THIS.this_oBusinessObject = .NULL.
2272:         ENDIF
2273:         DODEFAULT()
2274:     ENDPROC
2275: 
2276: ENDDEFINE


### BO (C:\4c\projeto\app\classes\epdBO.prg):
*******************************************************************************
* epdBO.prg - Business Object para Finalizacao Antecipada
* Tabela principal: SigCdNec
* Chave: EmpDNps (Emps C3 + Dopps C20 + Str(Numps,10))
*******************************************************************************

DEFINE CLASS epdBO AS BusinessBase

    *-- Chave primaria composta
    this_cEmpDNps    = ""    && C(33) Chave: Emps+Dopps+Str(Numps,10)
    this_cEmpDNpsC   = ""    && C(29) Chave curta: Emps+Dopps+Str(Numps,6)

    *-- Campos de SigCdNec (confirmados por ControlSource)
    this_cEmps       = ""    && C(3)  Empresa
    this_cDopps      = ""    && C(20) Tipo de Operacao (fixo: ENCERRAMENTO DIRETO)
    this_nNumps      = 0     && N(10) Numero do necessario (codigo)
    this_dDatas      = {}    && D     Data de finalizacao

    *-- Origem (ControlSource: tmpnens.grupoos, tmpnens.contaos)
    this_cGrupoOs    = ""    && C     Grupo de origem
    this_cContaOs    = ""    && C     Conta de origem (IClis)

    *-- Destino (ControlSource: tmpnens.grupods, tmpnens.contads)
    this_cGrupoDs    = ""    && C     Grupo de destino
    this_cContaDs    = ""    && C     Conta de destino (IClis)

    *-- Responsavel (ControlSource: tmpnens.grvends, tmpnens.vends)
    this_cGrVends    = ""    && C     Grupo do responsavel
    this_cVends      = ""    && C     Conta do responsavel (IClis)

    *-- Controles operacionais (propriedades do form original)
    this_cDopp       = ""    && C(20) Operacao fixa ENCERRAMENTO DIRETO
    this_lAutomatico = .F.   && L     Modo automatico (parametro)
    this_lEditaOrig  = .T.   && L     Permite editar origem (editaorigem)
    this_nNops       = 0     && N     Numero da ordem de producao

    *====================================================================
    PROCEDURE Init()
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "EmpDNps"
            THIS.this_cDopp       = PADR("ENCERRAMENTO DIRETO", 20)
            loc_lResultado        = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *====================================================================
        RETURN THIS.this_cEmpDNps
    ENDPROC

    *====================================================================
    FUNCTION Buscar(par_cFiltro)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cOpI, loc_cOpF
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cOpI     = loc_cEmpresa + THIS.this_cDopp + STR(0,          10)
            loc_cOpF     = loc_cEmpresa + THIS.this_cDopp + STR(9999999999, 10)

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps BETWEEN " + EscaparSQL(loc_cOpI) + " AND " + EscaparSQL(loc_cOpF)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numps"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps = " + EscaparSQL(par_cChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado       = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps     = TratarNulo(emps,    "C")
                THIS.this_cDopps    = TratarNulo(dopps,   "C")
                THIS.this_nNumps    = TratarNulo(numps,   "N")
                THIS.this_dDatas    = TratarNulo(datas,   "D")
                THIS.this_cGrupoOs  = TratarNulo(grupoos, "C")
                THIS.this_cContaOs  = TratarNulo(contaos, "C")
                THIS.this_cGrupoDs  = TratarNulo(grupods, "C")
                THIS.this_cContaDs  = TratarNulo(contads, "C")
                THIS.this_cGrVends  = TratarNulo(grvends, "C")
                THIS.this_cVends    = TratarNulo(vends,   "C")
                THIS.this_cEmpDNps  = TratarNulo(empdnps, "C")
                THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                      STR(THIS.this_nNumps, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Inserir()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCidChave
        loc_lResultado = .F.

        TRY
            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_cDopps = THIS.this_cDopp

            THIS.this_cEmpDNps  = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 10)
            THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 6)

            loc_cCidChave = SUBSTR(THIS.this_cEmpDNps, 14, 20)

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (emps, dopps, numps, datas," + ;
                       "  grupoos, contaos, grupods, contads," + ;
                       "  grvends, vends, empdnps, cidchaves, usuars," + ;
                       "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
                       "  docus, locals, ntrans, nops, naceites, entrabs," + ;
                       "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
                       "  empds, nconforms, nlotes, jobs, pesolancs, usulins," + ;
                       "  chkbaixa, usuconfs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps)    + "," + ;
                       EscaparSQL(THIS.this_cDopps)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       EscaparSQL(THIS.this_cEmpDNps)  + "," + ;
                       EscaparSQL(loc_cCidChave)       + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + "," + ;
                       "0,0,0,0,0,0," + ;
                       "'          ','          ',0,0,0,0," + ;
                       "0,'          ','          ',0,0,0," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ",0,0,'          ',0," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ",0,'          ')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Atualizar()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       "  grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       "  contaos = " + EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       "  grupods = " + EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       "  contads = " + EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       "  grvends = " + EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       "  vends   = " + EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       "  usuars  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ;
                       " WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDNps)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Excluir itens de SigCdNei primeiro (integridade referencial)
            loc_cSQL    = "DELETE FROM SigCdNei WHERE empdnps = " + ;
                          EscaparSQL(THIS.this_cEmpDNps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens (SigCdNei):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal de SigCdNec
                loc_cSQL    = "DELETE FROM SigCdNec WHERE empdnps = " + ;
                              EscaparSQL(THIS.this_cEmpDNps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

