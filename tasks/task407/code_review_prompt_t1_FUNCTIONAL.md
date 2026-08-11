# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Operacoes' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_OperacoesTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Número' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Número' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Gr.Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Destino' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ordem Produção. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formepd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2266 linhas total):

*-- Linhas 31 a 153:
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
56:                 THIS.ConfigurarPaginaDados()
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lSucesso = .T.
66:             ENDIF
67: 
68:         CATCH TO loc_oErro
69:             MsgErro("Erro em InicializarForm: " + loc_oErro.Message + CHR(13) + ;
70:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount  = 2
84:             .Left       = 0
85:             .Top        = -29
86:             .Width      = THIS.Width
87:             .Height     = THIS.Height + 29
88:             .Tabs       = .F.
89:             .Visible    = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page2.Caption   = "Dados"
93:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:             .Page1.BackColor = RGB(236, 233, 216)
95:             .Page2.BackColor = RGB(236, 233, 216)
96:         ENDWITH
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e bot?es CRUD
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarPaginaLista()
103:         LOCAL loc_oPagina, loc_oBotoes, loc_oSaida, loc_oGrid
104:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
105: 
106:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
107:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *-- Container cabe?alho escuro com t?tulo (cntSombra no legado)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 2
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Top       = 15
124:             .Left      = 10
125:             .Width     = THIS.Width - 12
126:             .Height    = 40
127:             .FontName  = "Tahoma"
128:             .FontSize  = 16
129:             .FontBold  = .T.
130:             .ForeColor = RGB(0, 0, 0)
131:             .BackStyle = 0
132:             .AutoSize  = .F.
133:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = THIS.Width - 12
142:             .Height    = 46
143:             .FontName  = "Tahoma"
144:             .FontSize  = 16
145:             .FontBold  = .T.
146:             .ForeColor = RGB(255, 255, 255)
147:             .BackStyle = 0
148:             .AutoSize  = .F.
149:             .Caption   = "Finaliza" + CHR(231) + CHR(227) + "o Antecipada"
150:             .Visible   = .T.
151:         ENDWITH
152: 
153:         *-- Container bot?es CRUD lado direito (Grupo_Op no legado)

*-- Linhas 187 a 363:
187:             .AutoSize        = .F.
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193:         WITH loc_oBotoes.cmd_4c_Visualizar
194:             .Caption         = "Visualizar"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 80
199:             .Width           = 75
200:             .Height          = 75
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .FontName        = "Comic Sans MS"
204:             .FontSize        = 8
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .AutoSize        = .F.
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
215: 
216:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:         WITH loc_oBotoes.cmd_4c_Alterar
218:             .Caption         = "Alterar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .Top             = 5
222:             .Left            = 155
223:             .Width           = 75
224:             .Height          = 75
225:             .BackColor       = RGB(255, 255, 255)
226:             .ForeColor       = RGB(90, 90, 90)
227:             .FontName        = "Comic Sans MS"
228:             .FontSize        = 8
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .MousePointer    = 15
234:             .WordWrap        = .T.
235:             .AutoSize        = .F.
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
241:         WITH loc_oBotoes.cmd_4c_Excluir
242:             .Caption         = "Excluir"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 230
247:             .Width           = 75
248:             .Height          = 75
249:             .BackColor       = RGB(255, 255, 255)
250:             .ForeColor       = RGB(90, 90, 90)
251:             .FontName        = "Comic Sans MS"
252:             .FontSize        = 8
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
263: 
264:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
265:         WITH loc_oBotoes.cmd_4c_Buscar
266:             .Caption         = "Buscar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 305
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container Encerrar - padr?o can?nico (Left=917, Width=90, cmd Width=75)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 29
292:             .Left        = 917
293:             .Width       = 90
294:             .Height      = 85
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         loc_oSaida = loc_oPagina.cnt_4c_Saida
301:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
302:         WITH loc_oSaida.cmd_4c_Encerrar
303:             .Caption         = "Encerrar"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
305:             .PicturePosition = 13
306:             .Top             = 5
307:             .Left            = 5
308:             .Width           = 75
309:             .Height          = 75
310:             .BackColor       = RGB(255, 255, 255)
311:             .ForeColor       = RGB(90, 90, 90)
312:             .FontName        = "Comic Sans MS"
313:             .FontSize        = 8
314:             .FontBold        = .T.
315:             .FontItalic      = .T.
316:             .Themes          = .F.
317:             .SpecialEffect   = 0
318:             .MousePointer    = 15
319:             .WordWrap        = .T.
320:             .AutoSize        = .F.
321:             .Visible         = .T.
322:         ENDWITH
323:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
324: 
325:         *-- Grid principal (grd_4c_Lista) - registros de SigCdNec
326:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
327:         loc_oGrid = loc_oPagina.grd_4c_Lista
328:         loc_oGrid.Top         = 88
329:         loc_oGrid.Left        = 5
330:         loc_oGrid.Width       = 905
331:         loc_oGrid.Height      = 490
332:         loc_oGrid.ColumnCount = 7
333: 
334:         WITH loc_oGrid
335:             .FontName           = "Verdana"
336:             .FontSize           = 8
337:             .ForeColor          = RGB(90, 90, 90)
338:             .BackColor          = RGB(255, 255, 255)
339:             .GridLineColor      = RGB(238, 238, 238)
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .GridLines          = 3
348:             .ReadOnly           = .T.
349:             .Visible            = .T.
350:         ENDWITH
351: 
352:         WITH loc_oGrid.Column1
353:             .Width           = 75
354:             .Alignment       = 2
355:             .Header1.Caption = "N" + CHR(250) + "mero"
356:         ENDWITH
357:         WITH loc_oGrid.Column2
358:             .Width           = 80
359:             .Header1.Caption = "Data"
360:         ENDWITH
361:         WITH loc_oGrid.Column3
362:             .Width           = 90
363:             .Header1.Caption = "Gr.Origem"

*-- Linhas 379 a 584:
379:             .Header1.Caption = "Usu" + CHR(225) + "rio"
380:         ENDWITH
381: 
382:         THIS.TornarControlesVisiveis(loc_oPagina)
383:     ENDPROC
384: 
385:     *--------------------------------------------------------------------------
386:     * ConfigurarPaginaDados - Configura Page2 (Dados) - Campos Parte 1/2
387:     *--------------------------------------------------------------------------
388:     PROTECTED PROCEDURE ConfigurarPaginaDados()
389:         LOCAL loc_oPagina, loc_oSalva, loc_oSaida, loc_oCnt
390:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
391: 
392:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
393:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
394: 
395:         *-- Container bot" + CHR(245) + "es Confirmar/Cancelar (Grupo_Salva no legado)
396:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao
398:             .Top         = 33
399:             .Left        = 842
400:             .Width       = 160
401:             .Height      = 85
402:             .BackStyle   = 0
403:             .BorderWidth = 0
404:             .Visible     = .T.
405:         ENDWITH
406: 
407:         loc_oSalva = loc_oPagina.cnt_4c_BotoesAcao
408: 
409:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oSalva.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontSize        = 8
422:             .FontBold        = .T.
423:             .FontItalic      = .T.
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .AutoSize        = .F.
429:             .Visible         = .T.
430:         ENDWITH
431:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
432: 
433:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
434:         WITH loc_oSalva.cmd_4c_Cancelar
435:             .Caption         = "Encerrar"
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
437:             .PicturePosition = 13
438:             .Top             = 5
439:             .Left            = 80
440:             .Width           = 75
441:             .Height          = 75
442:             .BackColor       = RGB(255, 255, 255)
443:             .ForeColor       = RGB(90, 90, 90)
444:             .FontName        = "Comic Sans MS"
445:             .FontSize        = 8
446:             .FontBold        = .T.
447:             .FontItalic      = .T.
448:             .Themes          = .F.
449:             .SpecialEffect   = 0
450:             .MousePointer    = 15
451:             .WordWrap        = .T.
452:             .AutoSize        = .F.
453:             .Visible         = .T.
454:         ENDWITH
455:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
456: 
457:         *-- Container Encerrar - padr" + CHR(227) + "o can" + CHR(244) + "nico
458:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
459:         WITH loc_oPagina.cnt_4c_Saida
460:             .Top         = 29
461:             .Left        = 917
462:             .Width       = 90
463:             .Height      = 85
464:             .BackStyle   = 0
465:             .BorderWidth = 0
466:             .Visible     = .T.
467:         ENDWITH
468: 
469:         loc_oSaida = loc_oPagina.cnt_4c_Saida
470:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
471:         WITH loc_oSaida.cmd_4c_Encerrar
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 5
476:             .Left            = 5
477:             .Width           = 75
478:             .Height          = 75
479:             .BackColor       = RGB(255, 255, 255)
480:             .ForeColor       = RGB(90, 90, 90)
481:             .FontName        = "Comic Sans MS"
482:             .FontSize        = 8
483:             .FontBold        = .T.
484:             .FontItalic      = .T.
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .MousePointer    = 15
488:             .WordWrap        = .T.
489:             .AutoSize        = .F.
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
493: 
494:         *-- Bot" + CHR(245) + "es de a" + CHR(231) + CHR(227) + "o no topo da Page2 (top=6+29=35)
495:         loc_oPagina.AddObject("cmd_4c_Operacao", "CommandButton")
496:         WITH loc_oPagina.cmd_4c_Operacao
497:             .Caption       = "\<Movimento"
498:             .Top           = 35
499:             .Left          = 616
500:             .Width         = 70
501:             .Height        = 25
502:             .BackColor     = RGB(255, 255, 255)
503:             .ForeColor     = RGB(90, 90, 90)
504:             .FontName      = "Tahoma"
505:             .FontSize      = 8
506:             .Themes        = .F.
507:             .SpecialEffect = 0
508:             .Visible       = .T.
509:         ENDWITH
510:         BINDEVENT(loc_oPagina.cmd_4c_Operacao, "Click", THIS, "BtnOperacaoClick")
511: 
512:         loc_oPagina.AddObject("cmd_4c_Boleto", "CommandButton")
513:         WITH loc_oPagina.cmd_4c_Boleto
514:             .Caption       = "\<Boleto"
515:             .Top           = 35
516:             .Left          = 692
517:             .Width         = 70
518:             .Height        = 25
519:             .BackColor     = RGB(255, 255, 255)
520:             .ForeColor     = RGB(90, 90, 90)
521:             .FontName      = "Tahoma"
522:             .FontSize      = 8
523:             .Themes        = .F.
524:             .SpecialEffect = 0
525:             .Visible       = .T.
526:         ENDWITH
527:         BINDEVENT(loc_oPagina.cmd_4c_Boleto, "Click", THIS, "BtnBoletoClick")
528: 
529:         loc_oPagina.AddObject("cmd_4c_Documento", "CommandButton")
530:         WITH loc_oPagina.cmd_4c_Documento
531:             .Caption       = "\<Documento"
532:             .Top           = 35
533:             .Left          = 768
534:             .Width         = 70
535:             .Height        = 25
536:             .BackColor     = RGB(255, 255, 255)
537:             .ForeColor     = RGB(90, 90, 90)
538:             .FontName      = "Tahoma"
539:             .FontSize      = 8
540:             .Themes        = .F.
541:             .SpecialEffect = 0
542:             .Visible       = .T.
543:         ENDWITH
544:         BINDEVENT(loc_oPagina.cmd_4c_Documento, "Click", THIS, "BtnDocumentoClick")
545: 
546:         *-- Separador visual (shpBtnGs no legado, top=143+29=172)
547:         loc_oPagina.AddObject("shp_4c_ShpBtnGs", "Shape")
548:         WITH loc_oPagina.shp_4c_ShpBtnGs
549:             .Top     = 172
550:             .Left    = 635
551:             .Width   = 18
552:             .Height  = 50
553:             .Visible = .T.
554:         ENDWITH
555: 
556:         *-- Container1: C" + CHR(243) + "digo e Data (top=268+29=297)
557:         loc_oPagina.AddObject("cnt_4c_Container1", "Container")
558:         WITH loc_oPagina.cnt_4c_Container1
559:             .Top         = 297
560:             .Left        = 214
561:             .Width       = 571
562:             .Height      = 75
563:             .BackStyle   = 1
564:             .BackColor   = RGB(236, 233, 216)
565:             .BorderWidth = 0
566:             .Visible     = .T.
567:         ENDWITH
568: 
569:         loc_oCnt = loc_oPagina.cnt_4c_Container1
570: 
571:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
572:         WITH loc_oCnt.lbl_4c_Label1
573:             .Caption   = "C" + CHR(243) + "digo"
574:             .Top       = 8
575:             .Left      = 11
576:             .Width     = 80
577:             .Height    = 17
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .ForeColor = RGB(90, 90, 90)
581:             .BackStyle = 0
582:             .Visible   = .T.
583:         ENDWITH
584: 

*-- Linhas 721 a 793:
721:             .Value    = ""
722:             .Visible  = .T.
723:         ENDWITH
724:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsKeyPress")
725:         BINDEVENT(loc_oCnt.txt_4c_GrupoOs, "KeyPress", THIS, "TxtGrupoOsLostFocus")
726: 
727:         loc_oCnt.AddObject("txt_4c_ContaOs", "TextBox")
728:         WITH loc_oCnt.txt_4c_ContaOs
729:             .Top      = 42
730:             .Left     = 96
731:             .Width    = 80
732:             .Height   = 22
733:             .FontName = "Tahoma"
734:             .FontSize = 8
735:             .Value    = ""
736:             .Visible  = .T.
737:         ENDWITH
738:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsKeyPress")
739:         BINDEVENT(loc_oCnt.txt_4c_ContaOs, "KeyPress", THIS, "TxtContaOsLostFocus")
740: 
741:         loc_oCnt.AddObject("txt_4c_NomeContaOs", "TextBox")
742:         WITH loc_oCnt.txt_4c_NomeContaOs
743:             .Top      = 42
744:             .Left     = 180
745:             .Width    = 360
746:             .Height   = 22
747:             .FontName = "Tahoma"
748:             .FontSize = 8
749:             .Value    = ""
750:             .ReadOnly = .T.
751:             .Visible  = .T.
752:         ENDWITH
753:         BINDEVENT(loc_oCnt.txt_4c_NomeContaOs, "KeyPress", THIS, "TxtNomeContaOsKeyPress")
754: 
755:         *-- Container Destino: Grupo/Conta/Nome de Destino (top=429+29=458)
756:         loc_oPagina.AddObject("cnt_4c_Destino", "Container")
757:         WITH loc_oPagina.cnt_4c_Destino
758:             .Top         = 458
759:             .Left        = 214
760:             .Width       = 571
761:             .Height      = 75
762:             .BackStyle   = 1
763:             .BackColor   = RGB(236, 233, 216)
764:             .BorderWidth = 0
765:             .Visible     = .T.
766:         ENDWITH
767: 
768:         loc_oCnt = loc_oPagina.cnt_4c_Destino
769: 
770:         loc_oCnt.AddObject("lbl_4c_label42", "Label")
771:         WITH loc_oCnt.lbl_4c_label42
772:             .Caption   = "Destino"
773:             .Top       = 6
774:             .Left      = 11
775:             .Width     = 80
776:             .Height    = 17
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8
779:             .FontBold  = .T.
780:             .ForeColor = RGB(90, 90, 90)
781:             .BackStyle = 0
782:             .Visible   = .T.
783:         ENDWITH
784: 
785:         loc_oCnt.AddObject("lin_4c_line13", "Line")
786:         WITH loc_oCnt.lin_4c_line13
787:             .Top     = 22
788:             .Left    = 12
789:             .Width   = 340
790:             .Height  = 0
791:             .Visible = .T.
792:         ENDWITH
793: 

*-- Linhas 844 a 916:
844:             .Value    = ""
845:             .Visible  = .T.
846:         ENDWITH
847:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsKeyPress")
848:         BINDEVENT(loc_oCnt.txt_4c_GrupoDs, "KeyPress", THIS, "TxtGrupoDsLostFocus")
849: 
850:         loc_oCnt.AddObject("txt_4c_ContaDs", "TextBox")
851:         WITH loc_oCnt.txt_4c_ContaDs
852:             .Top      = 42
853:             .Left     = 96
854:             .Width    = 80
855:             .Height   = 22
856:             .FontName = "Tahoma"
857:             .FontSize = 8
858:             .Value    = ""
859:             .Visible  = .T.
860:         ENDWITH
861:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsKeyPress")
862:         BINDEVENT(loc_oCnt.txt_4c_ContaDs, "KeyPress", THIS, "TxtContaDsLostFocus")
863: 
864:         loc_oCnt.AddObject("txt_4c_NomeContaDs", "TextBox")
865:         WITH loc_oCnt.txt_4c_NomeContaDs
866:             .Top      = 42
867:             .Left     = 180
868:             .Width    = 360
869:             .Height   = 22
870:             .FontName = "Tahoma"
871:             .FontSize = 8
872:             .Value    = ""
873:             .ReadOnly = .T.
874:             .Visible  = .T.
875:         ENDWITH
876:         BINDEVENT(loc_oCnt.txt_4c_NomeContaDs, "KeyPress", THIS, "TxtNomeContaDsKeyPress")
877: 
878:         *-- Container Responsavel: Grupo/Conta/Nome do Responsavel (top=508+29=537)
879:         loc_oPagina.AddObject("cnt_4c_Responsavel", "Container")
880:         WITH loc_oPagina.cnt_4c_Responsavel
881:             .Top         = 537
882:             .Left        = 214
883:             .Width       = 571
884:             .Height      = 75
885:             .BackStyle   = 1
886:             .BackColor   = RGB(236, 233, 216)
887:             .BorderWidth = 0
888:             .Visible     = .T.
889:         ENDWITH
890: 
891:         loc_oCnt = loc_oPagina.cnt_4c_Responsavel
892: 
893:         loc_oCnt.AddObject("lbl_4c_label43", "Label")
894:         WITH loc_oCnt.lbl_4c_label43
895:             .Caption   = "Respons" + CHR(225) + "vel"
896:             .Top       = 6
897:             .Left      = 11
898:             .Width     = 80
899:             .Height    = 17
900:             .FontName  = "Tahoma"
901:             .FontSize  = 8
902:             .FontBold  = .T.
903:             .ForeColor = RGB(90, 90, 90)
904:             .BackStyle = 0
905:             .Visible   = .T.
906:         ENDWITH
907: 
908:         loc_oCnt.AddObject("lin_4c_line14", "Line")
909:         WITH loc_oCnt.lin_4c_line14
910:             .Top     = 22
911:             .Left    = 12
912:             .Width   = 340
913:             .Height  = 0
914:             .Visible = .T.
915:         ENDWITH
916: 

*-- Linhas 967 a 2095:
967:             .Value    = ""
968:             .Visible  = .T.
969:         ENDWITH
970:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsKeyPress")
971:         BINDEVENT(loc_oCnt.txt_4c_GrVends, "KeyPress", THIS, "TxtGrVendsLostFocus")
972: 
973:         loc_oCnt.AddObject("txt_4c_Vends", "TextBox")
974:         WITH loc_oCnt.txt_4c_Vends
975:             .Top      = 42
976:             .Left     = 96
977:             .Width    = 80
978:             .Height   = 22
979:             .FontName = "Tahoma"
980:             .FontSize = 8
981:             .Value    = ""
982:             .Visible  = .T.
983:         ENDWITH
984:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsKeyPress")
985:         BINDEVENT(loc_oCnt.txt_4c_Vends, "KeyPress", THIS, "TxtVendsLostFocus")
986: 
987:         loc_oCnt.AddObject("txt_4c_NomeVends", "TextBox")
988:         WITH loc_oCnt.txt_4c_NomeVends
989:             .Top      = 42
990:             .Left     = 180
991:             .Width    = 360
992:             .Height   = 22
993:             .FontName = "Tahoma"
994:             .FontSize = 8
995:             .Value    = ""
996:             .ReadOnly = .T.
997:             .Visible  = .T.
998:         ENDWITH
999:         BINDEVENT(loc_oCnt.txt_4c_NomeVends, "KeyPress", THIS, "TxtNomeVendsKeyPress")
1000: 
1001:         *-- Grade de Operacao (top=68+29=97, Visible=.F. por padrao)
1002:         loc_oPagina.AddObject("grd_4c_GradeOperacao", "Grid")
1003:         WITH loc_oPagina.grd_4c_GradeOperacao
1004:             .Top         = 97
1005:             .Left        = 266
1006:             .Width       = 171
1007:             .Height      = 182
1008:             .ColumnCount = 1
1009:             .FontName    = "Tahoma"
1010:             .FontSize    = 8
1011:             .ForeColor   = RGB(90, 90, 90)
1012:             .BackColor   = RGB(255, 255, 255)
1013:             .DeleteMark  = .F.
1014:             .RecordMark  = .F.
1015:             .RowHeight   = 16
1016:             .ScrollBars  = 2
1017:             .GridLines   = 3
1018:             .ReadOnly    = .T.
1019:             .Visible     = .F.
1020:         ENDWITH
1021: 
1022:         WITH loc_oPagina.grd_4c_GradeOperacao.Column1
1023:             .Width           = 165
1024:             .Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
1025:         ENDWITH
1026: 
1027:         *-- Botao de Ordens ao lado da grade (top=69+29=98)
1028:         loc_oPagina.AddObject("cmd_4c_BotOrdens", "CommandButton")
1029:         WITH loc_oPagina.cmd_4c_BotOrdens
1030:             .Caption       = "..."
1031:             .Top           = 98
1032:             .Left          = 440
1033:             .Width         = 40
1034:             .Height        = 40
1035:             .BackColor     = RGB(255, 255, 255)
1036:             .ForeColor     = RGB(90, 90, 90)
1037:             .FontName      = "Tahoma"
1038:             .FontSize      = 8
1039:             .Themes        = .F.
1040:             .SpecialEffect = 0
1041:             .Visible       = .T.
1042:         ENDWITH
1043:         BINDEVENT(loc_oPagina.cmd_4c_BotOrdens, "Click", THIS, "BtnBotOrdensClick")
1044: 
1045:         THIS.TornarControlesVisiveis(loc_oPagina)
1046:     ENDPROC
1047: 
1048:     *==========================================================================
1049:     * NAVEGA??O
1050:     *==========================================================================
1051: 
1052:     *--------------------------------------------------------------------------
1053:     * CarregarLista - Carrega registros no grid da Page1
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE CarregarLista()
1056:         LOCAL loc_lResultado, loc_oGrid
1057:         loc_lResultado = .F.
1058: 
1059:         TRY
1060:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1061:                 loc_lResultado = .T.
1062:             ELSE
1063:                 IF !THIS.this_oBusinessObject.Buscar("")
1064:                     loc_lResultado = .F.
1065:                 ELSE
1066:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1067: 
1068:                     loc_oGrid.ColumnCount = 7
1069:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1070:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numps"
1071:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
1072:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.grupoos"
1073:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.contaos"
1074:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupods"
1075:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contads"
1076:                     loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.usuars"
1077: 
1078:                     *-- Reconfigurar headers ap?s RecordSource (VFP reseta ao mudar RecordSource)
1079:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(250) + "mero"
1080:                     loc_oGrid.Column2.Header1.Caption = "Data"
1081:                     loc_oGrid.Column3.Header1.Caption = "Gr.Origem"
1082:                     loc_oGrid.Column4.Header1.Caption = "Conta Origem"
1083:                     loc_oGrid.Column5.Header1.Caption = "Gr.Destino"
1084:                     loc_oGrid.Column6.Header1.Caption = "Conta Destino"
1085:                     loc_oGrid.Column7.Header1.Caption = "Usu" + CHR(225) + "rio"
1086: 
1087:                     THIS.FormatarGridLista(loc_oGrid)
1088:                     loc_lResultado = .T.
1089:                 ENDIF
1090:             ENDIF
1091:         CATCH TO loc_oErro
1092:             MsgErro("Erro em CarregarLista: " + loc_oErro.Message + CHR(13) + ;
1093:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1094:             loc_lResultado = .F.
1095:         ENDTRY
1096: 
1097:         RETURN loc_lResultado
1098:     ENDPROC
1099: 
1100:     *--------------------------------------------------------------------------
1101:     * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
1102:     *--------------------------------------------------------------------------
1103:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1104:         LOCAL loc_lResultado
1105:         loc_lResultado = .F.
1106: 
1107:         TRY
1108:             IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
1109:                 loc_lResultado = .F.
1110:             ELSE
1111:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1112:                 IF par_nPagina = 1
1113:                     THIS.CarregarLista()
1114:                 ENDIF
1115:                 loc_lResultado = .T.
1116:             ENDIF
1117:         CATCH TO loc_oErro
1118:             MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
1119:             loc_lResultado = .F.
1120:         ENDTRY
1121: 
1122:         RETURN loc_lResultado
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * AUXILIARES
1127:     *==========================================================================
1128: 
1129:     *--------------------------------------------------------------------------
1130:     * TornarControlesVisiveis - Torna controles vis?veis recursivamente
1131:     *--------------------------------------------------------------------------
1132:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1133:         LOCAL loc_nI, loc_oObjeto, loc_nP
1134: 
1135:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1136:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1137: 
1138:             IF VARTYPE(loc_oObjeto) = "O"
1139:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1140:                     loc_oObjeto.Visible = .T.
1141:                 ENDIF
1142: 
1143:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1144:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1145:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1146:                     ENDFOR
1147:                 ENDIF
1148: 
1149:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1150:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1151:                 ENDIF
1152:             ENDIF
1153:         ENDFOR
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * FormatarGridLista - Formata visual do grid
1158:     *--------------------------------------------------------------------------
1159:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1160:         WITH par_oGrid
1161:             .FontName = "Tahoma"
1162:             .FontSize = 8
1163:         ENDWITH
1164:     ENDPROC
1165: 
1166:     *==========================================================================
1167:     * EVENTOS DOS BOT?ES - Page1 (Lista)
1168:     *==========================================================================
1169: 
1170:     *--------------------------------------------------------------------------
1171:     * BtnIncluirClick - Prepara formul?rio para inclus?o de novo registro
1172:     *--------------------------------------------------------------------------
1173:     PROCEDURE BtnIncluirClick()
1174:         THIS.this_oBusinessObject.NovoRegistro()
1175:         THIS.this_cModoAtual = "INCLUIR"
1176:         THIS.LimparCampos()
1177:         THIS.HabilitarCampos(.T.)
1178:         THIS.AjustarBotoesPorModo()
1179:         THIS.AlternarPagina(2)
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1184:     *--------------------------------------------------------------------------
1185:     PROCEDURE BtnVisualizarClick()
1186:         LOCAL loc_cChave
1187:         loc_cChave = ""
1188: 
1189:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1190:            EOF("cursor_4c_Dados")
1191:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1192:         ELSE
1193:             SELECT cursor_4c_Dados
1194:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1195:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1196:                 THIS.this_cModoAtual = "VISUALIZAR"
1197:                 THIS.BOParaForm()
1198:                 THIS.HabilitarCampos(.F.)
1199:                 THIS.AjustarBotoesPorModo()
1200:                 THIS.AlternarPagina(2)
1201:             ENDIF
1202:         ENDIF
1203:     ENDPROC
1204: 
1205:     *--------------------------------------------------------------------------
1206:     * BtnAlterarClick - Carrega registro selecionado para edi??o
1207:     *--------------------------------------------------------------------------
1208:     PROCEDURE BtnAlterarClick()
1209:         LOCAL loc_cChave
1210:         loc_cChave = ""
1211: 
1212:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1213:            EOF("cursor_4c_Dados")
1214:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1215:         ELSE
1216:             SELECT cursor_4c_Dados
1217:             loc_cChave = ALLTRIM(cursor_4c_Dados.empdnps)
1218:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1219:                 THIS.this_oBusinessObject.EditarRegistro()
1220:                 THIS.this_cModoAtual = "ALTERAR"
1221:                 THIS.BOParaForm()
1222:                 THIS.HabilitarCampos(.T.)
1223:                 THIS.AjustarBotoesPorModo()
1224:                 THIS.AlternarPagina(2)
1225:             ENDIF
1226:         ENDIF
1227:     ENDPROC
1228: 
1229:     *--------------------------------------------------------------------------
1230:     * BtnExcluirClick - Exclui registro selecionado ap?s confirma??o
1231:     *--------------------------------------------------------------------------
1232:     PROCEDURE BtnExcluirClick()
1233:         LOCAL loc_cChave, loc_nNumero
1234:         loc_cChave  = ""
1235:         loc_nNumero = 0
1236: 
1237:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR ;
1238:            EOF("cursor_4c_Dados")
1239:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1240:         ELSE
1241:             SELECT cursor_4c_Dados
1242:             loc_cChave  = ALLTRIM(cursor_4c_Dados.empdnps)
1243:             loc_nNumero = cursor_4c_Dados.numps
1244: 
1245:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1246:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro " + ;
1247:                                TRANSFORM(loc_nNumero) + "?", "Excluir")
1248:                     IF THIS.this_oBusinessObject.Excluir()
1249:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1250:                         THIS.CarregarLista()
1251:                     ENDIF
1252:                 ENDIF
1253:             ENDIF
1254:         ENDIF
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     * BtnBuscarClick - Recarrega lista (refresh)
1259:     *--------------------------------------------------------------------------
1260:     PROCEDURE BtnBuscarClick()
1261:         THIS.CarregarLista()
1262:     ENDPROC
1263: 
1264:     *--------------------------------------------------------------------------
1265:     * BtnEncerrarClick - Fecha o formul?rio
1266:     *--------------------------------------------------------------------------
1267:     PROCEDURE BtnEncerrarClick()
1268:         THIS.Release()
1269:     ENDPROC
1270: 
1271:     *==========================================================================
1272:     * EVENTOS DOS BOT" + CHR(213) + "ES - Page2 (Dados)
1273:     *==========================================================================
1274: 
1275:     *--------------------------------------------------------------------------
1276:     * BtnSalvarClick - Salva registro (Inserir ou Atualizar)
1277:     *--------------------------------------------------------------------------
1278:     PROCEDURE BtnSalvarClick()
1279:         LOCAL loc_lResultado
1280:         loc_lResultado = .F.
1281: 
1282:         IF !THIS.ValidarDados()
1283:             RETURN
1284:         ENDIF
1285: 
1286:         TRY
1287:             THIS.FormParaBO()
1288:             IF THIS.this_oBusinessObject.Salvar()
1289:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1290:                 THIS.this_cModoAtual = "LISTA"
1291:                 THIS.AlternarPagina(1)
1292:                 loc_lResultado = .T.
1293:             ENDIF
1294:         CATCH TO loc_oErro
1295:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + CHR(13) + ;
1296:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1297:             loc_lResultado = .F.
1298:         ENDTRY
1299: 
1300:         RETURN loc_lResultado
1301:     ENDPROC
1302: 
1303:     *--------------------------------------------------------------------------
1304:     * BtnCancelarClick - Cancela e volta para lista
1305:     *--------------------------------------------------------------------------
1306:     PROCEDURE BtnCancelarClick()
1307:         THIS.this_cModoAtual = "LISTA"
1308:         THIS.AlternarPagina(1)
1309:     ENDPROC
1310: 
1311:     *--------------------------------------------------------------------------
1312:     * BtnOperacaoClick - Abre form de Movimento de Opera" + CHR(231) + CHR(227) + "o (SigOpMpd)
1313:     *--------------------------------------------------------------------------
1314:     PROCEDURE BtnOperacaoClick()
1315:         LOCAL loc_lResultado
1316:         loc_lResultado = .F.
1317: 
1318:         IF INLIST(THIS.this_cModoAtual, "ALTERAR", "VISUALIZAR")
1319:             THIS.Enabled = .F.
1320:             TRY
1321:                 DO FORM FormSigOpMpd WITH THIS
1322:                 loc_lResultado = .T.
1323:             CATCH TO loc_oErro
1324:                 MsgErro("Erro ao abrir Movimento de Opera" + CHR(231) + CHR(227) + "o:" + ;
1325:                         CHR(13) + loc_oErro.Message, "Erro")
1326:                 loc_lResultado = .F.
1327:             ENDTRY
1328:             THIS.Enabled = .T.
1329:         ENDIF
1330: 
1331:         RETURN loc_lResultado
1332:     ENDPROC
1333: 
1334:     *--------------------------------------------------------------------------
1335:     * BtnBoletoClick - Imprime boleto se opera" + CHR(231) + CHR(227) + "o permite
1336:     *--------------------------------------------------------------------------
1337:     PROCEDURE BtnBoletoClick()
1338:         LOCAL loc_lResultado, loc_lTemBoleto
1339:         loc_lResultado = .F.
1340:         loc_lTemBoleto = .F.
1341: 
1342:         TRY
1343:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1344:                 SELECT cursor_4c_OpConfig
1345:                 loc_lTemBoleto = (cursor_4c_OpConfig.boletos = 1)
1346:             ENDIF
1347: 
1348:             IF loc_lTemBoleto
1349:                 THIS.ImprimirBoleto()
1350:                 loc_lResultado = .T.
1351:             ENDIF
1352:         CATCH TO loc_oErro
1353:             MsgErro("Erro em BtnBoletoClick: " + loc_oErro.Message, "Erro")
1354:             loc_lResultado = .F.
1355:         ENDTRY
1356: 
1357:         RETURN loc_lResultado
1358:     ENDPROC
1359: 
1360:     *--------------------------------------------------------------------------
1361:     * ImprimirBoleto - Imprime boleto banc" + CHR(225) + "rio do registro selecionado
1362:     *--------------------------------------------------------------------------
1363:     PROCEDURE ImprimirBoleto()
1364:         LOCAL loc_lResultado
1365:         loc_lResultado = .F.
1366: 
1367:         TRY
1368:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1369:                 SELECT cursor_4c_Dados
1370:                 DO SigPrBol WITH ALLTRIM(cursor_4c_Dados.emps), ;
1371:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1372:                                   cursor_4c_Dados.numps
1373:                 loc_lResultado = .T.
1374:             ENDIF
1375:         CATCH TO loc_oErro
1376:             MsgErro("Erro ao imprimir boleto: " + loc_oErro.Message, "Erro")
1377:             loc_lResultado = .F.
1378:         ENDTRY
1379: 
1380:         RETURN loc_lResultado
1381:     ENDPROC
1382: 
1383:     *--------------------------------------------------------------------------
1384:     * BtnDocumentoClick - Imprime documento se opera" + CHR(231) + CHR(227) + "o permite
1385:     *--------------------------------------------------------------------------
1386:     PROCEDURE BtnDocumentoClick()
1387:         LOCAL loc_lResultado, loc_lTemDoc, loc_nQtdDocs
1388:         loc_lResultado = .F.
1389:         loc_lTemDoc    = .F.
1390:         loc_nQtdDocs   = 0
1391: 
1392:         TRY
1393:             IF USED("cursor_4c_OpConfig") AND !EOF("cursor_4c_OpConfig")
1394:                 SELECT cursor_4c_OpConfig
1395:                 loc_lTemDoc  = (cursor_4c_OpConfig.docus = 1)
1396:                 loc_nQtdDocs = cursor_4c_OpConfig.qtddocs
1397:             ENDIF
1398: 
1399:             IF loc_lTemDoc AND USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1400:                 SELECT cursor_4c_Dados
1401:                 DO SigPrIdc WITH ALLTRIM(cursor_4c_Dados.emps), ;
1402:                                   ALLTRIM(cursor_4c_Dados.dopps), ;
1403:                                   cursor_4c_Dados.numps, 0, ;
1404:                                   loc_nQtdDocs, ;
1405:                                   .F., .F., .F., .F., .F., .F., THIS
1406:                 loc_lResultado = .T.
1407:             ENDIF
1408:         CATCH TO loc_oErro
1409:             MsgErro("Erro em BtnDocumentoClick: " + loc_oErro.Message, "Erro")
1410:             loc_lResultado = .F.
1411:         ENDTRY
1412: 
1413:         RETURN loc_lResultado
1414:     ENDPROC
1415: 
1416:     *==========================================================================
1417:     * VALIDA" + CHR(199) + CHR(195) + "O
1418:     *==========================================================================
1419: 
1420:     *--------------------------------------------------------------------------
1421:     * ValidarDados - Valida campos obrigat" + CHR(243) + "rios da Page2 antes de salvar
1422:     *--------------------------------------------------------------------------
1423:     PROTECTED PROCEDURE ValidarDados()
1424:         LOCAL loc_lValido, loc_oPg2
1425:         loc_lValido = .T.
1426:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1427: 
1428:         IF EMPTY(loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value)
1429:             MsgAviso("Data " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
1430:                      "Valida" + CHR(231) + CHR(227) + "o")
1431:             loc_oPg2.cnt_4c_Container1.txt_4c_Datas.SetFocus
1432:             loc_lValido = .F.
1433:         ENDIF
1434: 
1435:         IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value))
1436:             MsgAviso("Grupo de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1437:                      "Valida" + CHR(231) + CHR(227) + "o")
1438:             loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.SetFocus
1439:             loc_lValido = .F.
1440:         ENDIF
1441: 
1442:         IF loc_lValido AND ;
1443:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)) AND ;
1444:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value))
1445:             MsgAviso("Conta ou Nome de Origem " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1446:                      "Valida" + CHR(231) + CHR(227) + "o")
1447:             loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.SetFocus
1448:             loc_lValido = .F.
1449:         ENDIF
1450: 
1451:         IF loc_lValido AND EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value))
1452:             MsgAviso("Grupo de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1453:                      "Valida" + CHR(231) + CHR(227) + "o")
1454:             loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.SetFocus
1455:             loc_lValido = .F.
1456:         ENDIF
1457: 
1458:         IF loc_lValido AND ;
1459:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)) AND ;
1460:            EMPTY(ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value))
1461:             MsgAviso("Conta ou Nome de Destino " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1462:                      "Valida" + CHR(231) + CHR(227) + "o")
1463:             loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.SetFocus
1464:             loc_lValido = .F.
1465:         ENDIF
1466: 
1467:         RETURN loc_lValido
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * LOOKUPS - ORIGEM
1472:     *==========================================================================
1473: 
1474:     *--------------------------------------------------------------------------
1475:     * TxtGrupoOsKeyPress - F4 abre lookup de Grupos Cont" + CHR(225) + "beis (Origem)
1476:     *--------------------------------------------------------------------------
1477:     PROCEDURE TxtGrupoOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1478:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1479:             THIS.AbrirLookupGrupoOs()
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *--------------------------------------------------------------------------
1484:     * TxtGrupoOsLostFocus - Valida Grupo de Origem ao sair do campo
1485:     *--------------------------------------------------------------------------
1486:     PROCEDURE TxtGrupoOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1487:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1488:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1489:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
1490: 
1491:         IF !EMPTY(loc_cGrupo)
1492:             TRY
1493:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1494:                               EscaparSQL(loc_cGrupo)
1495:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoOsVal")
1496: 
1497:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoOsVal") OR ;
1498:                    RECCOUNT("cursor_4c_GrupoOsVal") = 0
1499:                     THIS.AbrirLookupGrupoOs()
1500:                 ENDIF
1501: 
1502:                 IF USED("cursor_4c_GrupoOsVal")
1503:                     USE IN cursor_4c_GrupoOsVal
1504:                 ENDIF
1505:             CATCH TO loc_oErro
1506:                 MsgErro("Erro ao validar Grupo: " + loc_oErro.Message, "Erro")
1507:             ENDTRY
1508:         ENDIF
1509:     ENDPROC
1510: 
1511:     *--------------------------------------------------------------------------
1512:     * AbrirLookupGrupoOs - Abre picker de Grupos Cont" + CHR(225) + "beis (SigCdGcr)
1513:     *--------------------------------------------------------------------------
1514:     PROCEDURE AbrirLookupGrupoOs()
1515:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1516:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1517:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
1518: 
1519:         TRY
1520:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1521:                                       "SigCdGcr", "cursor_4c_BuscaGrupoOs", ;
1522:                                       "Codigos", loc_cValor, ;
1523:                                       "Grupos Cont" + CHR(225) + "beis")
1524:             IF VARTYPE(loc_oBusca) = "O"
1525:                 IF !loc_oBusca.this_lAchouRegistro
1526:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1527:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1528:                     loc_oBusca.Show()
1529:                 ENDIF
1530:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoOs")
1531:                     SELECT cursor_4c_BuscaGrupoOs
1532:                     loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value = ALLTRIM(cursor_4c_BuscaGrupoOs.Codigos)
1533:                 ENDIF
1534:                 loc_oBusca.Release()
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro("Erro ao abrir busca de Grupos: " + loc_oErro.Message, "Erro")
1538:         ENDTRY
1539: 
1540:         IF USED("cursor_4c_BuscaGrupoOs")
1541:             USE IN cursor_4c_BuscaGrupoOs
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *--------------------------------------------------------------------------
1546:     * TxtContaOsKeyPress - F4 abre lookup de Contas por C" + CHR(243) + "digo (Origem)
1547:     *--------------------------------------------------------------------------
1548:     PROCEDURE TxtContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1549:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1550:             THIS.AbrirLookupContaOs()
1551:         ENDIF
1552:     ENDPROC
1553: 
1554:     *--------------------------------------------------------------------------
1555:     * TxtContaOsLostFocus - Valida Conta e preenche Nome de Origem ao sair
1556:     *--------------------------------------------------------------------------
1557:     PROCEDURE TxtContaOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1558:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1559:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1560:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
1561: 
1562:         IF !EMPTY(loc_cConta)
1563:             TRY
1564:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1565:                               EscaparSQL(loc_cConta)
1566:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOsVal")
1567: 
1568:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaOsVal") AND ;
1569:                    RECCOUNT("cursor_4c_ContaOsVal") > 0
1570:                     SELECT cursor_4c_ContaOsVal
1571:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_ContaOsVal.RClis)
1572:                 ELSE
1573:                     THIS.AbrirLookupContaOs()
1574:                 ENDIF
1575: 
1576:                 IF USED("cursor_4c_ContaOsVal")
1577:                     USE IN cursor_4c_ContaOsVal
1578:                 ENDIF
1579:             CATCH TO loc_oErro
1580:                 MsgErro("Erro ao validar Conta: " + loc_oErro.Message, "Erro")
1581:             ENDTRY
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     *--------------------------------------------------------------------------
1586:     * AbrirLookupContaOs - Abre picker de Contas por C" + CHR(243) + "digo (SigCdCli.IClis)
1587:     *--------------------------------------------------------------------------
1588:     PROCEDURE AbrirLookupContaOs()
1589:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1590:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1591:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
1592: 
1593:         TRY
1594:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1595:                                       "SigCdCli", "cursor_4c_BuscaContaOs", ;
1596:                                       "IClis", loc_cValor, ;
1597:                                       "Contas")
1598:             IF VARTYPE(loc_oBusca) = "O"
1599:                 IF !loc_oBusca.this_lAchouRegistro
1600:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1601:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1602:                     loc_oBusca.Show()
1603:                 ENDIF
1604:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaOs")
1605:                     SELECT cursor_4c_BuscaContaOs
1606:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(cursor_4c_BuscaContaOs.IClis)
1607:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaContaOs.RClis)
1608:                 ENDIF
1609:                 loc_oBusca.Release()
1610:             ENDIF
1611:         CATCH TO loc_oErro
1612:             MsgErro("Erro ao abrir busca de Contas: " + loc_oErro.Message, "Erro")
1613:         ENDTRY
1614: 
1615:         IF USED("cursor_4c_BuscaContaOs")
1616:             USE IN cursor_4c_BuscaContaOs
1617:         ENDIF
1618:     ENDPROC
1619: 
1620:     *--------------------------------------------------------------------------
1621:     * TxtNomeContaOsKeyPress - F4 abre lookup de Contas por Nome (Origem)
1622:     *--------------------------------------------------------------------------
1623:     PROCEDURE TxtNomeContaOsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1624:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1625:             THIS.AbrirLookupNomeContaOs()
1626:         ENDIF
1627:     ENDPROC
1628: 
1629:     *--------------------------------------------------------------------------
1630:     * AbrirLookupNomeContaOs - Abre picker de Contas por Nome (SigCdCli.RClis)
1631:     *--------------------------------------------------------------------------
1632:     PROCEDURE AbrirLookupNomeContaOs()
1633:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1634:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1635:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value)
1636: 
1637:         TRY
1638:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1639:                                       "SigCdCli", "cursor_4c_BuscaNomeContaOs", ;
1640:                                       "RClis", loc_cValor, ;
1641:                                       "Contas por Nome")
1642:             IF VARTYPE(loc_oBusca) = "O"
1643:                 IF !loc_oBusca.this_lAchouRegistro
1644:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1645:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1646:                     loc_oBusca.Show()
1647:                 ENDIF
1648:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaOs")
1649:                     SELECT cursor_4c_BuscaNomeContaOs
1650:                     loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value     = ALLTRIM(cursor_4c_BuscaNomeContaOs.IClis)
1651:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_BuscaNomeContaOs.RClis)
1652:                 ENDIF
1653:                 loc_oBusca.Release()
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             MsgErro("Erro ao abrir busca por Nome: " + loc_oErro.Message, "Erro")
1657:         ENDTRY
1658: 
1659:         IF USED("cursor_4c_BuscaNomeContaOs")
1660:             USE IN cursor_4c_BuscaNomeContaOs
1661:         ENDIF
1662:     ENDPROC
1663: 
1664:     *==========================================================================
1665:     * LOOKUPS - DESTINO
1666:     *==========================================================================
1667: 
1668:     *--------------------------------------------------------------------------
1669:     * TxtGrupoDsKeyPress - F4 abre lookup de Grupos Contabeis (Destino)
1670:     *--------------------------------------------------------------------------
1671:     PROCEDURE TxtGrupoDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1672:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1673:             THIS.AbrirLookupGrupoDs()
1674:         ENDIF
1675:     ENDPROC
1676: 
1677:     *--------------------------------------------------------------------------
1678:     * TxtGrupoDsLostFocus - Valida Grupo de Destino ao sair do campo
1679:     *--------------------------------------------------------------------------
1680:     PROCEDURE TxtGrupoDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1681:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1682:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1683:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
1684: 
1685:         IF !EMPTY(loc_cGrupo)
1686:             TRY
1687:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1688:                               EscaparSQL(loc_cGrupo)
1689:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoDsVal")
1690: 
1691:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrupoDsVal") OR ;
1692:                    RECCOUNT("cursor_4c_GrupoDsVal") = 0
1693:                     THIS.AbrirLookupGrupoDs()
1694:                 ENDIF
1695: 
1696:                 IF USED("cursor_4c_GrupoDsVal")
1697:                     USE IN cursor_4c_GrupoDsVal
1698:                 ENDIF
1699:             CATCH TO loc_oErro
1700:                 MsgErro("Erro ao validar Grupo Destino: " + loc_oErro.Message, "Erro")
1701:             ENDTRY
1702:         ENDIF
1703:     ENDPROC
1704: 
1705:     *--------------------------------------------------------------------------
1706:     * AbrirLookupGrupoDs - Abre picker de Grupos Contabeis (SigCdGcr) - Destino
1707:     *--------------------------------------------------------------------------
1708:     PROCEDURE AbrirLookupGrupoDs()
1709:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1710:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1711:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
1712: 
1713:         TRY
1714:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1715:                                       "SigCdGcr", "cursor_4c_BuscaGrupoDs", ;
1716:                                       "Codigos", loc_cValor, ;
1717:                                       "Grupos Cont" + CHR(225) + "beis")
1718:             IF VARTYPE(loc_oBusca) = "O"
1719:                 IF !loc_oBusca.this_lAchouRegistro
1720:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1721:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1722:                     loc_oBusca.Show()
1723:                 ENDIF
1724:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDs")
1725:                     SELECT cursor_4c_BuscaGrupoDs
1726:                     loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value = ALLTRIM(cursor_4c_BuscaGrupoDs.Codigos)
1727:                 ENDIF
1728:                 loc_oBusca.Release()
1729:             ENDIF
1730:         CATCH TO loc_oErro
1731:             MsgErro("Erro ao abrir busca de Grupos Destino: " + loc_oErro.Message, "Erro")
1732:         ENDTRY
1733: 
1734:         IF USED("cursor_4c_BuscaGrupoDs")
1735:             USE IN cursor_4c_BuscaGrupoDs
1736:         ENDIF
1737:     ENDPROC
1738: 
1739:     *--------------------------------------------------------------------------
1740:     * TxtContaDsKeyPress - F4 abre lookup de Contas por Codigo (Destino)
1741:     *--------------------------------------------------------------------------
1742:     PROCEDURE TxtContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1743:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1744:             THIS.AbrirLookupContaDs()
1745:         ENDIF
1746:     ENDPROC
1747: 
1748:     *--------------------------------------------------------------------------
1749:     * TxtContaDsLostFocus - Valida Conta e preenche Nome de Destino ao sair
1750:     *--------------------------------------------------------------------------
1751:     PROCEDURE TxtContaDsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1752:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1753:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1754:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
1755: 
1756:         IF !EMPTY(loc_cConta)
1757:             TRY
1758:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1759:                               EscaparSQL(loc_cConta)
1760:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDsVal")
1761: 
1762:                 IF loc_nResult >= 0 AND USED("cursor_4c_ContaDsVal") AND ;
1763:                    RECCOUNT("cursor_4c_ContaDsVal") > 0
1764:                     SELECT cursor_4c_ContaDsVal
1765:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_ContaDsVal.RClis)
1766:                 ELSE
1767:                     THIS.AbrirLookupContaDs()
1768:                 ENDIF
1769: 
1770:                 IF USED("cursor_4c_ContaDsVal")
1771:                     USE IN cursor_4c_ContaDsVal
1772:                 ENDIF
1773:             CATCH TO loc_oErro
1774:                 MsgErro("Erro ao validar Conta Destino: " + loc_oErro.Message, "Erro")
1775:             ENDTRY
1776:         ENDIF
1777:     ENDPROC
1778: 
1779:     *--------------------------------------------------------------------------
1780:     * AbrirLookupContaDs - Abre picker de Contas por Codigo (SigCdCli) - Destino
1781:     *--------------------------------------------------------------------------
1782:     PROCEDURE AbrirLookupContaDs()
1783:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1784:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1785:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
1786: 
1787:         TRY
1788:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1789:                                       "SigCdCli", "cursor_4c_BuscaContaDs", ;
1790:                                       "IClis", loc_cValor, ;
1791:                                       "Contas")
1792:             IF VARTYPE(loc_oBusca) = "O"
1793:                 IF !loc_oBusca.this_lAchouRegistro
1794:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1795:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1796:                     loc_oBusca.Show()
1797:                 ENDIF
1798:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaDs")
1799:                     SELECT cursor_4c_BuscaContaDs
1800:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaContaDs.IClis)
1801:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaContaDs.RClis)
1802:                 ENDIF
1803:                 loc_oBusca.Release()
1804:             ENDIF
1805:         CATCH TO loc_oErro
1806:             MsgErro("Erro ao abrir busca de Contas Destino: " + loc_oErro.Message, "Erro")
1807:         ENDTRY
1808: 
1809:         IF USED("cursor_4c_BuscaContaDs")
1810:             USE IN cursor_4c_BuscaContaDs
1811:         ENDIF
1812:     ENDPROC
1813: 
1814:     *--------------------------------------------------------------------------
1815:     * TxtNomeContaDsKeyPress - F4 abre lookup de Contas por Nome (Destino)
1816:     *--------------------------------------------------------------------------
1817:     PROCEDURE TxtNomeContaDsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1818:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1819:             THIS.AbrirLookupNomeContaDs()
1820:         ENDIF
1821:     ENDPROC
1822: 
1823:     *--------------------------------------------------------------------------
1824:     * AbrirLookupNomeContaDs - Abre picker de Contas por Nome - Destino
1825:     *--------------------------------------------------------------------------
1826:     PROCEDURE AbrirLookupNomeContaDs()
1827:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1828:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1829:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value)
1830: 
1831:         TRY
1832:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1833:                                       "SigCdCli", "cursor_4c_BuscaNomeContaDs", ;
1834:                                       "RClis", loc_cValor, ;
1835:                                       "Contas por Nome")
1836:             IF VARTYPE(loc_oBusca) = "O"
1837:                 IF !loc_oBusca.this_lAchouRegistro
1838:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1839:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1840:                     loc_oBusca.Show()
1841:                 ENDIF
1842:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeContaDs")
1843:                     SELECT cursor_4c_BuscaNomeContaDs
1844:                     loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(cursor_4c_BuscaNomeContaDs.IClis)
1845:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_BuscaNomeContaDs.RClis)
1846:                 ENDIF
1847:                 loc_oBusca.Release()
1848:             ENDIF
1849:         CATCH TO loc_oErro
1850:             MsgErro("Erro ao abrir busca por Nome Destino: " + loc_oErro.Message, "Erro")
1851:         ENDTRY
1852: 
1853:         IF USED("cursor_4c_BuscaNomeContaDs")
1854:             USE IN cursor_4c_BuscaNomeContaDs
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     *==========================================================================
1859:     * LOOKUPS - RESPONSAVEL
1860:     *==========================================================================
1861: 
1862:     *--------------------------------------------------------------------------
1863:     * TxtGrVendsKeyPress - F4 abre lookup de Grupos Contabeis (Responsavel)
1864:     *--------------------------------------------------------------------------
1865:     PROCEDURE TxtGrVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1866:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1867:             THIS.AbrirLookupGrVends()
1868:         ENDIF
1869:     ENDPROC
1870: 
1871:     *--------------------------------------------------------------------------
1872:     * TxtGrVendsLostFocus - Valida Grupo do Responsavel ao sair do campo
1873:     *--------------------------------------------------------------------------
1874:     PROCEDURE TxtGrVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1875:         LOCAL loc_cGrupo, loc_oPg2, loc_cSQL, loc_nResult
1876:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1877:         loc_cGrupo = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
1878: 
1879:         IF !EMPTY(loc_cGrupo)
1880:             TRY
1881:                 loc_cSQL    = "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + ;
1882:                               EscaparSQL(loc_cGrupo)
1883:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrVendsVal")
1884: 
1885:                 IF loc_nResult < 0 OR !USED("cursor_4c_GrVendsVal") OR ;
1886:                    RECCOUNT("cursor_4c_GrVendsVal") = 0
1887:                     THIS.AbrirLookupGrVends()
1888:                 ENDIF
1889: 
1890:                 IF USED("cursor_4c_GrVendsVal")
1891:                     USE IN cursor_4c_GrVendsVal
1892:                 ENDIF
1893:             CATCH TO loc_oErro
1894:                 MsgErro("Erro ao validar Grupo Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1895:             ENDTRY
1896:         ENDIF
1897:     ENDPROC
1898: 
1899:     *--------------------------------------------------------------------------
1900:     * AbrirLookupGrVends - Abre picker de Grupos Contabeis - Responsavel
1901:     *--------------------------------------------------------------------------
1902:     PROCEDURE AbrirLookupGrVends()
1903:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1904:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1905:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
1906: 
1907:         TRY
1908:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1909:                                       "SigCdGcr", "cursor_4c_BuscaGrVends", ;
1910:                                       "Codigos", loc_cValor, ;
1911:                                       "Grupos Cont" + CHR(225) + "beis")
1912:             IF VARTYPE(loc_oBusca) = "O"
1913:                 IF !loc_oBusca.this_lAchouRegistro
1914:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1915:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1916:                     loc_oBusca.Show()
1917:                 ENDIF
1918:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrVends")
1919:                     SELECT cursor_4c_BuscaGrVends
1920:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value = ALLTRIM(cursor_4c_BuscaGrVends.Codigos)
1921:                 ENDIF
1922:                 loc_oBusca.Release()
1923:             ENDIF
1924:         CATCH TO loc_oErro
1925:             MsgErro("Erro ao abrir busca de Grupos Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1926:         ENDTRY
1927: 
1928:         IF USED("cursor_4c_BuscaGrVends")
1929:             USE IN cursor_4c_BuscaGrVends
1930:         ENDIF
1931:     ENDPROC
1932: 
1933:     *--------------------------------------------------------------------------
1934:     * TxtVendsKeyPress - F4 abre lookup de Contas por Codigo (Responsavel)
1935:     *--------------------------------------------------------------------------
1936:     PROCEDURE TxtVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1937:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1938:             THIS.AbrirLookupVends()
1939:         ENDIF
1940:     ENDPROC
1941: 
1942:     *--------------------------------------------------------------------------
1943:     * TxtVendsLostFocus - Valida Conta e preenche Nome do Responsavel ao sair
1944:     *--------------------------------------------------------------------------
1945:     PROCEDURE TxtVendsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1946:         LOCAL loc_cConta, loc_oPg2, loc_cSQL, loc_nResult
1947:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1948:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
1949: 
1950:         IF !EMPTY(loc_cConta)
1951:             TRY
1952:                 loc_cSQL    = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1953:                               EscaparSQL(loc_cConta)
1954:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendsVal")
1955: 
1956:                 IF loc_nResult >= 0 AND USED("cursor_4c_VendsVal") AND ;
1957:                    RECCOUNT("cursor_4c_VendsVal") > 0
1958:                     SELECT cursor_4c_VendsVal
1959:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_VendsVal.RClis)
1960:                 ELSE
1961:                     THIS.AbrirLookupVends()
1962:                 ENDIF
1963: 
1964:                 IF USED("cursor_4c_VendsVal")
1965:                     USE IN cursor_4c_VendsVal
1966:                 ENDIF
1967:             CATCH TO loc_oErro
1968:                 MsgErro("Erro ao validar Conta Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
1969:             ENDTRY
1970:         ENDIF
1971:     ENDPROC
1972: 
1973:     *--------------------------------------------------------------------------
1974:     * AbrirLookupVends - Abre picker de Contas por Codigo - Responsavel
1975:     *--------------------------------------------------------------------------
1976:     PROCEDURE AbrirLookupVends()
1977:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
1978:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1979:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
1980: 
1981:         TRY
1982:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1983:                                       "SigCdCli", "cursor_4c_BuscaVends", ;
1984:                                       "IClis", loc_cValor, ;
1985:                                       "Contas")
1986:             IF VARTYPE(loc_oBusca) = "O"
1987:                 IF !loc_oBusca.this_lAchouRegistro
1988:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
1989:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
1990:                     loc_oBusca.Show()
1991:                 ENDIF
1992:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVends")
1993:                     SELECT cursor_4c_BuscaVends
1994:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaVends.IClis)
1995:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaVends.RClis)
1996:                 ENDIF
1997:                 loc_oBusca.Release()
1998:             ENDIF
1999:         CATCH TO loc_oErro
2000:             MsgErro("Erro ao abrir busca de Contas Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2001:         ENDTRY
2002: 
2003:         IF USED("cursor_4c_BuscaVends")
2004:             USE IN cursor_4c_BuscaVends
2005:         ENDIF
2006:     ENDPROC
2007: 
2008:     *--------------------------------------------------------------------------
2009:     * TxtNomeVendsKeyPress - F4 abre lookup de Contas por Nome (Responsavel)
2010:     *--------------------------------------------------------------------------
2011:     PROCEDURE TxtNomeVendsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2012:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2013:             THIS.AbrirLookupNomeVends()
2014:         ENDIF
2015:     ENDPROC
2016: 
2017:     *--------------------------------------------------------------------------
2018:     * AbrirLookupNomeVends - Abre picker de Contas por Nome - Responsavel
2019:     *--------------------------------------------------------------------------
2020:     PROCEDURE AbrirLookupNomeVends()
2021:         LOCAL loc_oBusca, loc_oPg2, loc_cValor
2022:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2023:         loc_cValor = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value)
2024: 
2025:         TRY
2026:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2027:                                       "SigCdCli", "cursor_4c_BuscaNomeVends", ;
2028:                                       "RClis", loc_cValor, ;
2029:                                       "Contas por Nome")
2030:             IF VARTYPE(loc_oBusca) = "O"
2031:                 IF !loc_oBusca.this_lAchouRegistro
2032:                     loc_oBusca.mAddColuna("IClis", "", "Conta")
2033:                     loc_oBusca.mAddColuna("RClis", "", "Nome")
2034:                     loc_oBusca.Show()
2035:                 ENDIF
2036:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaNomeVends")
2037:                     SELECT cursor_4c_BuscaNomeVends
2038:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ALLTRIM(cursor_4c_BuscaNomeVends.IClis)
2039:                     loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ALLTRIM(cursor_4c_BuscaNomeVends.RClis)
2040:                 ENDIF
2041:                 loc_oBusca.Release()
2042:             ENDIF
2043:         CATCH TO loc_oErro
2044:             MsgErro("Erro ao abrir busca por Nome Respons" + CHR(225) + "vel: " + loc_oErro.Message, "Erro")
2045:         ENDTRY
2046: 
2047:         IF USED("cursor_4c_BuscaNomeVends")
2048:             USE IN cursor_4c_BuscaNomeVends
2049:         ENDIF
2050:     ENDPROC
2051: 
2052:     *--------------------------------------------------------------------------
2053:     * BtnBotOrdensClick - Exibe/oculta grade de Ordens de Producao em aberto
2054:     *--------------------------------------------------------------------------
2055:     PROCEDURE BtnBotOrdensClick()
2056:         LOCAL loc_oPg2, loc_oGrade, loc_cSQL, loc_nResult, loc_lResultado
2057:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2058:         loc_oGrade    = loc_oPg2.grd_4c_GradeOperacao
2059:         loc_lResultado = .F.
2060: 
2061:         TRY
2062:             IF loc_oGrade.Visible
2063:                 loc_oGrade.Visible = .F.
2064:                 loc_lResultado     = .T.
2065:             ELSE
2066:                 IF USED("cursor_4c_Operacoes")
2067:                     USE IN cursor_4c_Operacoes
2068:                 ENDIF
2069: 
2070:                 IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cEmpDNps))
2071:                     loc_cSQL    = "SELECT a.nops AS nops FROM SigCdNei a" + ;
2072:                                   " WHERE a.empdnps = " + ;
2073:                                   EscaparSQL(THIS.this_oBusinessObject.this_cEmpDNps) + ;
2074:                                   " ORDER BY a.nops"
2075:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
2076: 
2077:                     IF loc_nResult >= 0 AND USED("cursor_4c_Operacoes")
2078:                         loc_oGrade.ColumnCount = 1
2079:                         loc_oGrade.RecordSource          = "cursor_4c_Operacoes"
2080:                         loc_oGrade.Column1.ControlSource = "cursor_4c_Operacoes.nops"
2081:                         loc_oGrade.Column1.Header1.Caption = "Ordem Produ" + CHR(231) + CHR(227) + "o"
2082:                         loc_oGrade.Visible = .T.
2083:                         loc_lResultado     = .T.
2084:                     ENDIF
2085:                 ELSE
2086:                     loc_oGrade.Visible = .T.
2087:                     loc_lResultado     = .T.
2088:                 ENDIF
2089:             ENDIF
2090:         CATCH TO loc_oErro
2091:             MsgErro("Erro em BtnBotOrdensClick: " + loc_oErro.Message, "Erro")
2092:             loc_lResultado = .F.
2093:         ENDTRY
2094: 
2095:         RETURN loc_lResultado

*-- Linhas 2102 a 2162:
2102:     *--------------------------------------------------------------------------
2103:     * FormParaBO - Transfere valores do Form para o BO
2104:     *--------------------------------------------------------------------------
2105:     PROTECTED PROCEDURE FormParaBO()
2106:         LOCAL loc_oPg2
2107:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2108: 
2109:         THIS.this_oBusinessObject.this_nNumps   = loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value
2110:         THIS.this_oBusinessObject.this_dDatas   = loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value
2111:         THIS.this_oBusinessObject.this_cGrupoOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value)
2112:         THIS.this_oBusinessObject.this_cContaOs = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value)
2113:         THIS.this_oBusinessObject.this_cGrupoDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value)
2114:         THIS.this_oBusinessObject.this_cContaDs = ALLTRIM(loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value)
2115:         THIS.this_oBusinessObject.this_cGrVends = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value)
2116:         THIS.this_oBusinessObject.this_cVends   = ALLTRIM(loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value)
2117:     ENDPROC
2118: 
2119:     *--------------------------------------------------------------------------
2120:     * BOParaForm - Transfere valores do BO para o Form
2121:     *--------------------------------------------------------------------------
2122:     PROTECTED PROCEDURE BOParaForm()
2123:         LOCAL loc_oPg2, loc_cSQL, loc_nResult
2124:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2125: 
2126:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value  = THIS.this_oBusinessObject.this_nNumps
2127:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value  = THIS.this_oBusinessObject.this_dDatas
2128:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOs)
2129:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOs)
2130:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ""
2131: 
2132:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2133:             TRY
2134:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2135:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaOs))
2136:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeOsBo")
2137:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeOsBo") AND ;
2138:                    RECCOUNT("cursor_4c_NomeOsBo") > 0
2139:                     SELECT cursor_4c_NomeOsBo
2140:                     loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value = ALLTRIM(cursor_4c_NomeOsBo.RClis)
2141:                 ENDIF
2142:                 IF USED("cursor_4c_NomeOsBo")
2143:                     USE IN cursor_4c_NomeOsBo
2144:                 ENDIF
2145:             CATCH TO loc_oErro
2146:                 MsgErro("Erro ao carregar nome conta origem: " + loc_oErro.Message, "Erro")
2147:             ENDTRY
2148:         ENDIF
2149: 
2150:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDs)
2151:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDs)
2152:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
2153: 
2154:         IF !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2155:             TRY
2156:                 loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli WHERE IClis = " + ;
2157:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cContaDs))
2158:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NomeDsBo")
2159:                 IF loc_nResult >= 0 AND USED("cursor_4c_NomeDsBo") AND ;
2160:                    RECCOUNT("cursor_4c_NomeDsBo") > 0
2161:                     SELECT cursor_4c_NomeDsBo
2162:                     loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ALLTRIM(cursor_4c_NomeDsBo.RClis)

*-- Linhas 2195 a 2266:
2195:     *--------------------------------------------------------------------------
2196:     * HabilitarCampos - Habilita/desabilita campos editaveis na Page2
2197:     *--------------------------------------------------------------------------
2198:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2199:         LOCAL loc_oPg2
2200:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2201: 
2202:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.ReadOnly = ;
2203:             !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
2204:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.ReadOnly   = !par_lHabilitar
2205:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Enabled      = par_lHabilitar
2206:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Enabled      = par_lHabilitar
2207:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.ReadOnly  = .T.
2208:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Enabled     = par_lHabilitar
2209:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Enabled     = par_lHabilitar
2210:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.ReadOnly = .T.
2211:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Enabled  = par_lHabilitar
2212:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Enabled    = par_lHabilitar
2213:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.ReadOnly = .T.
2214:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2215:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2216:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2217:     ENDPROC
2218: 
2219:     *--------------------------------------------------------------------------
2220:     * LimparCampos - Limpa valores dos campos na Page2
2221:     *--------------------------------------------------------------------------
2222:     PROTECTED PROCEDURE LimparCampos()
2223:         LOCAL loc_oPg2
2224:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2225: 
2226:         loc_oPg2.cnt_4c_Container1.txt_4c_Numps.Value    = 0
2227:         loc_oPg2.cnt_4c_Container1.txt_4c_Datas.Value    = {}
2228:         loc_oPg2.cnt_4c_Origem.txt_4c_GrupoOs.Value      = ""
2229:         loc_oPg2.cnt_4c_Origem.txt_4c_ContaOs.Value      = ""
2230:         loc_oPg2.cnt_4c_Origem.txt_4c_NomeContaOs.Value  = ""
2231:         loc_oPg2.cnt_4c_Destino.txt_4c_GrupoDs.Value     = ""
2232:         loc_oPg2.cnt_4c_Destino.txt_4c_ContaDs.Value     = ""
2233:         loc_oPg2.cnt_4c_Destino.txt_4c_NomeContaDs.Value = ""
2234:         loc_oPg2.cnt_4c_Responsavel.txt_4c_GrVends.Value  = ""
2235:         loc_oPg2.cnt_4c_Responsavel.txt_4c_Vends.Value    = ""
2236:         loc_oPg2.cnt_4c_Responsavel.txt_4c_NomeVends.Value = ""
2237:         loc_oPg2.grd_4c_GradeOperacao.Visible = .F.
2238:     ENDPROC
2239: 
2240:     *--------------------------------------------------------------------------
2241:     * AjustarBotoesPorModo - Ajusta estados dos bot" + CHR(245) + "es conforme modo atual
2242:     *--------------------------------------------------------------------------
2243:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2244:         LOCAL loc_oPg2, loc_lEditando
2245:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2246:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2247: 
2248:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
2249:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2250:         loc_oPg2.cmd_4c_Operacao.Enabled  = THIS.this_cModoAtual <> "INCLUIR"
2251:         loc_oPg2.cmd_4c_Boleto.Enabled    = THIS.this_cModoAtual <> "INCLUIR"
2252:         loc_oPg2.cmd_4c_Documento.Enabled = THIS.this_cModoAtual <> "INCLUIR"
2253:     ENDPROC
2254: 
2255:     *==========================================================================
2256:     * DESTRUI" + CHR(199) + CHR(195) + "O
2257:     *==========================================================================
2258: 
2259:     PROCEDURE Destroy()
2260:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2261:             THIS.this_oBusinessObject = .NULL.
2262:         ENDIF
2263:         DODEFAULT()
2264:     ENDPROC
2265: 
2266: ENDDEFINE


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

