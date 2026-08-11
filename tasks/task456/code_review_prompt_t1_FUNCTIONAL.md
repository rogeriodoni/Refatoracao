# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [CARGA-DADOS] OptionGroup 'opt_4c_SNA' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_ChequesM' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Entrada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Situação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Agência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Alinéa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cód. Cliente' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Entrada' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Valor Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Situação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Bco, Agen, Nº Conta, Nº Chq, Valor, Vencimento, Alínea, Emp, Código Cliente, Protocolo, Dt. Emissão, Sel. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formlch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4951 linhas total):

*-- Linhas 33 a 145:
33:     *--------------------------------------------------------------------------
34:     * Init - chama DODEFAULT() (FormBase.Init faz SET DATE BRITISH + SET CENTURY ON)
35:     *--------------------------------------------------------------------------
36:     PROCEDURE Init()
37:         LOCAL loc_lResultado
38:         loc_lResultado = .F.
39:         TRY
40:             loc_lResultado = DODEFAULT()
41:         CATCH TO loc_oErro
42:             MsgErro(loc_oErro.Message, "Formlch.Init")
43:         ENDTRY
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - cria BO, monta PageFrame, carrega lista
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53:         TRY
54:             THIS.this_oBusinessObject = CREATEOBJECT("lchBO")
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Falha ao criar lchBO", "Erro")
57:             ELSE
58:                 THIS.ConfigurarPageFrame()
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Visible    = .T.
62:                 THIS.pgf_4c_Paginas.ActivePage = 1
63:                 THIS.this_cModoAtual = "LISTA"
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                     THIS.CarregarLista()
66:                 ENDIF
67:                 loc_lResultado = .T.
68:             ENDIF
69:         CATCH TO loc_oErro
70:             MsgErro(loc_oErro.Message, "Formlch.InicializarForm")
71:         ENDTRY
72:         RETURN loc_lResultado
73:     ENDPROC
74: 
75:     *--------------------------------------------------------------------------
76:     * ConfigurarPageFrame - PageFrame com 2 paginas (Lista / Dados)
77:     *--------------------------------------------------------------------------
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         LOCAL loc_oPgf
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:         loc_oPgf = THIS.pgf_4c_Paginas
82:         WITH loc_oPgf
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90:             .Page1.Caption   = "Lista"
91:             .Page1.BackColor = RGB(100, 100, 100)
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page2.Caption   = "Dados"
94:             .Page2.BackColor = RGB(100, 100, 100)
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:         ENDWITH
97:         THIS.ConfigurarPaginaLista()
98:         THIS.ConfigurarPaginaDados()
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
103:     * +29 em todos os Top pelo PageFrame.Top=-29
104:     *--------------------------------------------------------------------------
105:     PROTECTED PROCEDURE ConfigurarPaginaLista()
106:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
107:         LOCAL loc_oCnt, loc_oCntP
108: 
109:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
110: 
111:         *-- Cabecalho cinza
112:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
113:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
114:         WITH loc_oCab
115:             .Top = 29
116:             .Left = 0
117:             .Width = THIS.Width
118:             .Height = 80
119:             .BackColor = RGB(100, 100, 100)
120:             .BorderWidth = 0
121:             .Visible = .T.
122:         ENDWITH
123: 
124:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
125:         WITH loc_oCab.lbl_4c_Sombra
126:             .Caption = THIS.Caption
127:             .AutoSize = .F.
128:             .Width = THIS.Width
129:             .Height = 40
130:             .Top = 15
131:             .Left = 10
132:             .FontName = "Tahoma"
133:             .FontSize = 16
134:             .FontBold = .T.
135:             .ForeColor = RGB(0, 0, 0)
136:             .BackStyle = 0
137:             .Visible = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
141:         WITH loc_oCab.lbl_4c_Titulo
142:             .Caption = THIS.Caption
143:             .AutoSize = .F.
144:             .Width = THIS.Width
145:             .Height = 46

*-- Linhas 186 a 347:
186:             .SpecialEffect = 0
187:             .Visible = .T.
188:         ENDWITH
189:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
190: 
191:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oBotoes.cmd_4c_Visualizar
193:             .Top = 5
194:             .Left = 80
195:             .Width = 75
196:             .Height = 75
197:             .Caption = "Visualizar"
198:             .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
199:             .PicturePosition = 13
200:             .FontName = "Tahoma"
201:             .FontBold = .T.
202:             .FontItalic = .T.
203:             .FontSize = 8
204:             .ForeColor = RGB(90, 90, 90)
205:             .BackColor = RGB(255, 255, 255)
206:             .Themes = .F.
207:             .SpecialEffect = 0
208:             .Visible = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
211: 
212:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
213:         WITH loc_oBotoes.cmd_4c_Alterar
214:             .Top = 5
215:             .Left = 155
216:             .Width = 75
217:             .Height = 75
218:             .Caption = "Alterar"
219:             .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:             .PicturePosition = 13
221:             .FontName = "Tahoma"
222:             .FontBold = .T.
223:             .FontItalic = .T.
224:             .FontSize = 8
225:             .ForeColor = RGB(90, 90, 90)
226:             .BackColor = RGB(255, 255, 255)
227:             .Themes = .F.
228:             .SpecialEffect = 0
229:             .Visible = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
234:         WITH loc_oBotoes.cmd_4c_Excluir
235:             .Top = 5
236:             .Left = 230
237:             .Width = 75
238:             .Height = 75
239:             .Caption = "Excluir"
240:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:             .PicturePosition = 13
242:             .FontName = "Tahoma"
243:             .FontBold = .T.
244:             .FontItalic = .T.
245:             .FontSize = 8
246:             .ForeColor = RGB(90, 90, 90)
247:             .BackColor = RGB(255, 255, 255)
248:             .Themes = .F.
249:             .SpecialEffect = 0
250:             .Visible = .T.
251:         ENDWITH
252:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
253: 
254:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
255:         WITH loc_oBotoes.cmd_4c_Buscar
256:             .Top = 5
257:             .Left = 305
258:             .Width = 75
259:             .Height = 75
260:             .Caption = "Buscar"
261:             .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
262:             .PicturePosition = 13
263:             .FontName = "Tahoma"
264:             .FontBold = .T.
265:             .FontItalic = .T.
266:             .FontSize = 8
267:             .ForeColor = RGB(90, 90, 90)
268:             .BackColor = RGB(255, 255, 255)
269:             .Themes = .F.
270:             .SpecialEffect = 0
271:             .Visible = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
274: 
275:         *-- Saida canonico (Left=917)
276:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
277:         loc_oSaida = loc_oPg1.cnt_4c_Saida
278:         WITH loc_oSaida
279:             .Top = 29
280:             .Left = 917
281:             .Width = 90
282:             .Height = 85
283:             .BackStyle = 0
284:             .BorderWidth = 0
285:             .Visible = .T.
286:         ENDWITH
287: 
288:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
289:         WITH loc_oSaida.cmd_4c_Encerrar
290:             .Top = 5
291:             .Left = 5
292:             .Width = 75
293:             .Height = 75
294:             .Caption = "Encerrar"
295:             .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .PicturePosition = 13
297:             .FontName = "Tahoma"
298:             .FontBold = .T.
299:             .FontItalic = .T.
300:             .FontSize = 8
301:             .ForeColor = RGB(90, 90, 90)
302:             .BackColor = RGB(255, 255, 255)
303:             .Themes = .F.
304:             .SpecialEffect = 0
305:             .Visible = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
308: 
309:         *-- Filtro de periodo (cntFiltros > cnt__periodo > Dt_inicial/Dt_final)
310:         *-- original top=86+29=115
311:         loc_oPg1.AddObject("cnt_4c_Filtros", "Container")
312:         loc_oCnt = loc_oPg1.cnt_4c_Filtros
313:         WITH loc_oCnt
314:             .Top = 115
315:             .Left = 5
316:             .Width = 267
317:             .Height = 46
318:             .BackStyle = 0
319:             .BorderWidth = 0
320:             .Visible = .T.
321:         ENDWITH
322: 
323:         loc_oCnt.AddObject("cnt_4c__periodo", "Container")
324:         loc_oCntP = loc_oCnt.cnt_4c__periodo
325:         WITH loc_oCntP
326:             .Top = 3
327:             .Left = 0
328:             .Width = 267
329:             .Height = 40
330:             .BackStyle = 0
331:             .BorderWidth = 0
332:             .Visible = .T.
333:         ENDWITH
334: 
335:         loc_oCntP.AddObject("lbl_4c_LblPeriodo", "Label")
336:         WITH loc_oCntP.lbl_4c_LblPeriodo
337:             .Caption = "Per" + CHR(237) + "odo : "
338:             .Top = 6
339:             .Left = 23
340:             .Width = 48
341:             .Height = 15
342:             .AutoSize = .F.
343:             .FontName = "Tahoma"
344:             .FontSize = 8
345:             .ForeColor = RGB(255, 255, 255)
346:             .BackStyle = 0
347:             .Visible = .T.

*-- Linhas 418 a 499:
418:             .FontSize = 8
419:             .Visible = .T.
420:         ENDWITH
421:         BINDEVENT(loc_oPg1.cbo_4c_Cmb_Concilia, "InteractiveChange", THIS, "CboConcilaChange")
422: 
423:         *-- Botao Limpar Data - top=86+29=115, left=271
424:         loc_oPg1.AddObject("cmd_4c_LimpaDT", "CommandButton")
425:         WITH loc_oPg1.cmd_4c_LimpaDT
426:             .Top = 115
427:             .Left = 271
428:             .Width = 75
429:             .Height = 75
430:             .Caption = "Limpar Data"
431:             .FontName = "Tahoma"
432:             .FontBold = .F.
433:             .FontSize = 8
434:             .ForeColor = RGB(90, 90, 90)
435:             .BackColor = RGB(255, 255, 255)
436:             .Themes = .F.
437:             .SpecialEffect = 0
438:             .Visible = .T.
439:         ENDWITH
440:         BINDEVENT(loc_oPg1.cmd_4c_LimpaDT, "Click", THIS, "BtnLimpaDTClick")
441: 
442:         *-- Botao Conciliacao - top=86+29=115, left=347
443:         loc_oPg1.AddObject("cmd_4c_Conciliacao", "CommandButton")
444:         WITH loc_oPg1.cmd_4c_Conciliacao
445:             .Top = 115
446:             .Left = 347
447:             .Width = 75
448:             .Height = 75
449:             .Caption = "Concilia" + CHR(231) + CHR(227) + "o"
450:             .FontName = "Tahoma"
451:             .FontBold = .F.
452:             .FontSize = 8
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackColor = RGB(255, 255, 255)
455:             .Themes = .F.
456:             .SpecialEffect = 0
457:             .Visible = .T.
458:         ENDWITH
459:         BINDEVENT(loc_oPg1.cmd_4c_Conciliacao, "Click", THIS, "BtnConciliacaoClick")
460: 
461:         *-- Grid lista de lotes - top=193, left=5
462:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
463:         loc_oGrid = loc_oPg1.grd_4c_Dados
464:         loc_oGrid.ColumnCount = 6
465:         WITH loc_oGrid
466:             .Top = 193
467:             .Left = 5
468:             .Width = 990
469:             .Height = 435
470:             .FontName = "Verdana"
471:             .FontSize = 8
472:             .ForeColor = RGB(90, 90, 90)
473:             .BackColor = RGB(255, 255, 255)
474:             .GridLineColor = RGB(238, 238, 238)
475:             .HighlightBackColor = RGB(255, 255, 255)
476:             .HighlightForeColor = RGB(15, 41, 104)
477:             .HighlightStyle = 2
478:             .DeleteMark = .F.
479:             .RecordMark = .F.
480:             .RowHeight = 16
481:             .ScrollBars = 2
482:             .GridLines = 3
483:             .Visible = .T.
484:         ENDWITH
485:         WITH loc_oGrid.Column1
486:             .Width = 60
487:             .Header1.Caption = "Lote"
488:         ENDWITH
489:         WITH loc_oGrid.Column2
490:             .Width = 80
491:             .Header1.Caption = "Empresa"
492:         ENDWITH
493:         WITH loc_oGrid.Column3
494:             .Width = 90
495:             .Header1.Caption = "Data Entrada"
496:         ENDWITH
497:         WITH loc_oGrid.Column4
498:             .Width = 100
499:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"

*-- Linhas 507 a 621:
507:             .Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
508:         ENDWITH
509: 
510:         THIS.TornarControlesVisiveis(loc_oPg1)
511:     ENDPROC
512: 
513:     *--------------------------------------------------------------------------
514:     * ConfigurarPaginaDados - Page2: todos os containers e campos de edicao
515:     * Posicoes: layout.json + 29 (compensacao PageFrame.Top=-29)
516:     *--------------------------------------------------------------------------
517:     PROTECTED PROCEDURE ConfigurarPaginaDados()
518:         LOCAL loc_oPg2, loc_oSalva, loc_oInf, loc_oOrig, loc_oDes
519:         LOCAL loc_oDst, loc_oCC, loc_oCart, loc_oProc, loc_oEmiss
520:         LOCAL loc_oGrd, loc_oChe, loc_oEmp, loc_oCnt, loc_oFil
521:         LOCAL loc_oRes, loc_oFol, loc_oGrid
522: 
523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
524: 
525:         *=====================================================================
526:         *-- cnt_4c_Salva (Confirmar/Cancelar) - substitui cmdGrpBotoes legado
527:         *-- original: top=0+29=29, posicao na coluna direita
528:         *=====================================================================
529:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
530:         loc_oSalva = loc_oPg2.cnt_4c_Salva
531:         WITH loc_oSalva
532:             .Top = 29
533:             .Left = 853
534:             .Width = 160
535:             .Height = 85
536:             .BackStyle = 0
537:             .BorderWidth = 0
538:             .Visible = .T.
539:         ENDWITH
540: 
541:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
542:         WITH loc_oSalva.cmd_4c_Confirmar
543:             .Top = 5
544:             .Left = 5
545:             .Width = 75
546:             .Height = 75
547:             .Caption = "Confirmar"
548:             .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
549:             .PicturePosition = 13
550:             .FontName = "Tahoma"
551:             .FontBold = .T.
552:             .FontItalic = .T.
553:             .FontSize = 8
554:             .ForeColor = RGB(90, 90, 90)
555:             .BackColor = RGB(255, 255, 255)
556:             .Themes = .F.
557:             .SpecialEffect = 0
558:             .Visible = .T.
559:         ENDWITH
560:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
561: 
562:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
563:         WITH loc_oSalva.cmd_4c_Cancelar
564:             .Top = 5
565:             .Left = 80
566:             .Width = 75
567:             .Height = 75
568:             .Caption = "Encerrar"
569:             .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
570:             .PicturePosition = 13
571:             .FontName = "Tahoma"
572:             .FontBold = .T.
573:             .FontItalic = .T.
574:             .FontSize = 8
575:             .ForeColor = RGB(90, 90, 90)
576:             .BackColor = RGB(255, 255, 255)
577:             .Themes = .F.
578:             .SpecialEffect = 0
579:             .Visible = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
582: 
583:         *=====================================================================
584:         *-- Linha 1: Usuario / Lote / Data
585:         *-- original: top=9+29=38 (textboxes), top=12+29=41 (labels)
586:         *=====================================================================
587:         loc_oPg2.AddObject("lbl_4c_Usuar", "Label")
588:         WITH loc_oPg2.lbl_4c_Usuar
589:             .Caption = "Usu" + CHR(225) + "rio :"
590:             .Top = 41
591:             .Left = 36
592:             .Width = 52
593:             .Height = 18
594:             .AutoSize = .F.
595:             .FontName = "Tahoma"
596:             .FontSize = 8
597:             .ForeColor = RGB(255, 255, 255)
598:             .BackStyle = 0
599:             .Visible = .T.
600:         ENDWITH
601: 
602:         loc_oPg2.AddObject("txt_4c_Usuar", "TextBox")
603:         WITH loc_oPg2.txt_4c_Usuar
604:             .Top = 38
605:             .Left = 86
606:             .Width = 80
607:             .Height = 21
608:             .MaxLength = 15
609:             .Value = ""
610:             .ReadOnly = .T.
611:             .FontName = "Tahoma"
612:             .FontSize = 8
613:             .Visible = .T.
614:         ENDWITH
615: 
616:         loc_oPg2.AddObject("lbl_4c_Lote", "Label")
617:         WITH loc_oPg2.lbl_4c_Lote
618:             .Caption = "Lote :"
619:             .Top = 41
620:             .Left = 181
621:             .Width = 32

*-- Linhas 669 a 757:
669:             .Visible = .T.
670:         ENDWITH
671: 
672:         *-- OptionGroup SNA: Todos / Pend. / Concil.
673:         *-- original: top=30+29=59, left=209
674:         loc_oPg2.AddObject("opt_4c_SNA", "OptionGroup")
675:         WITH loc_oPg2.opt_4c_SNA
676:             .Top = 59
677:             .Left = 209
678:             .Width = 153
679:             .Height = 25
680:             .ButtonCount = 3
681:             .BackStyle = 0
682:             .Value = 1
683:             .Visible = .T.
684:             .Buttons(1).Caption = "Todos"
685:             .Buttons(2).Caption = "Pend."
686:             .Buttons(3).Caption = "Concil."
687:         ENDWITH
688: 
689:         *-- Movimento / Operacao - original: top=32+29=61 (txt), top=35+29=64 (lbl)
690:         loc_oPg2.AddObject("lbl_4c_Movimento", "Label")
691:         WITH loc_oPg2.lbl_4c_Movimento
692:             .Caption = "Movimento :"
693:             .Top = 64
694:             .Left = 23
695:             .Width = 62
696:             .Height = 18
697:             .AutoSize = .F.
698:             .FontName = "Tahoma"
699:             .FontSize = 8
700:             .ForeColor = RGB(255, 255, 255)
701:             .BackStyle = 0
702:             .Visible = .T.
703:         ENDWITH
704: 
705:         loc_oPg2.AddObject("txt_4c_Oper", "TextBox")
706:         WITH loc_oPg2.txt_4c_Oper
707:             .Top = 61
708:             .Left = 86
709:             .Width = 117
710:             .Height = 21
711:             .MaxLength = 15
712:             .Value = ""
713:             .FontName = "Tahoma"
714:             .FontSize = 8
715:             .Visible = .T.
716:         ENDWITH
717:         BINDEVENT(loc_oPg2.txt_4c_Oper, "KeyPress", THIS, "ValidarOper")
718: 
719:         *=====================================================================
720:         *-- cnt_4c_Infos - Cheques/Moeda/Cotacao/Valores
721:         *-- original: top=52+29=81, left=6, width=464, height=53
722:         *=====================================================================
723:         loc_oPg2.AddObject("cnt_4c_Infos", "Container")
724:         loc_oInf = loc_oPg2.cnt_4c_Infos
725:         WITH loc_oInf
726:             .Top = 81
727:             .Left = 6
728:             .Width = 464
729:             .Height = 53
730:             .BackStyle = 1
731:             .BackColor = RGB(235, 235, 235)
732:             .BorderWidth = 1
733:             .Visible = .T.
734:         ENDWITH
735: 
736:         loc_oInf.AddObject("lbl_4c_Cheques", "Label")
737:         WITH loc_oInf.lbl_4c_Cheques
738:             .Caption = "Cheques :"
739:             .Top = 6
740:             .Left = 27
741:             .Width = 52
742:             .Height = 15
743:             .AutoSize = .F.
744:             .FontName = "Tahoma"
745:             .FontSize = 8
746:             .BackStyle = 0
747:             .Visible = .T.
748:         ENDWITH
749: 
750:         loc_oInf.AddObject("txt_4c_Qtde", "TextBox")
751:         WITH loc_oInf.txt_4c_Qtde
752:             .Top = 3
753:             .Left = 80
754:             .Width = 70
755:             .Height = 21
756:             .Value = 0
757:             .ReadOnly = .T.

*-- Linhas 786 a 846:
786:             .FontSize = 8
787:             .Visible = .T.
788:         ENDWITH
789:         BINDEVENT(loc_oInf.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
790: 
791:         loc_oInf.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
792:         WITH loc_oInf.cmd_4c_AlteraCotacao
793:             .Top = 1
794:             .Left = 236
795:             .Width = 24
796:             .Height = 23
797:             .Caption = "$"
798:             .FontName = "Tahoma"
799:             .FontBold = .T.
800:             .FontSize = 10
801:             .BackColor = RGB(255, 255, 255)
802:             .Themes = .T.
803:             .SpecialEffect = 0
804:             .Visible = .T.
805:         ENDWITH
806:         BINDEVENT(loc_oInf.cmd_4c_AlteraCotacao, "Click", THIS, "BtnAlteraCotacaoClick")
807: 
808:         loc_oInf.AddObject("lbl_4c_Cotacao", "Label")
809:         WITH loc_oInf.lbl_4c_Cotacao
810:             .Caption = "Cota" + CHR(231) + CHR(227) + "o :"
811:             .Top = 6
812:             .Left = 281
813:             .Width = 50
814:             .Height = 15
815:             .AutoSize = .F.
816:             .FontName = "Tahoma"
817:             .FontSize = 8
818:             .BackStyle = 0
819:             .Visible = .T.
820:         ENDWITH
821: 
822:         loc_oInf.AddObject("txt_4c_Cotacao", "TextBox")
823:         WITH loc_oInf.txt_4c_Cotacao
824:             .Top = 3
825:             .Left = 332
826:             .Width = 108
827:             .Height = 21
828:             .Value = 0
829:             .InputMask = "99999999.9999"
830:             .FontName = "Tahoma"
831:             .FontSize = 8
832:             .Visible = .T.
833:         ENDWITH
834: 
835:         loc_oInf.AddObject("lbl_4c_Valor", "Label")
836:         WITH loc_oInf.lbl_4c_Valor
837:             .Caption = "Valor :"
838:             .Top = 29
839:             .Left = 45
840:             .Width = 35
841:             .Height = 15
842:             .AutoSize = .F.
843:             .FontName = "Tahoma"
844:             .FontSize = 8
845:             .BackStyle = 0
846:             .Visible = .T.

*-- Linhas 945 a 1029:
945:             .FontSize = 8
946:             .Visible = .T.
947:         ENDWITH
948:         BINDEVENT(loc_oOrig.txt_4c_GruOrig, "KeyPress", THIS, "ValidarGrupoOrig")
949: 
950:         loc_oOrig.AddObject("txt_4c_DGruOrig", "TextBox")
951:         WITH loc_oOrig.txt_4c_DGruOrig
952:             .Top = 12
953:             .Left = 142
954:             .Width = 319
955:             .Height = 21
956:             .Value = ""
957:             .ReadOnly = .T.
958:             .FontName = "Tahoma"
959:             .FontSize = 8
960:             .Visible = .T.
961:         ENDWITH
962: 
963:         loc_oOrig.AddObject("lbl_4c_ConOrig", "Label")
964:         WITH loc_oOrig.lbl_4c_ConOrig
965:             .Caption = "Conta :"
966:             .Top = 38
967:             .Left = 18
968:             .Width = 42
969:             .Height = 15
970:             .AutoSize = .F.
971:             .FontName = "Tahoma"
972:             .FontSize = 8
973:             .BackStyle = 0
974:             .Visible = .T.
975:         ENDWITH
976: 
977:         loc_oOrig.AddObject("txt_4c_ConOrig", "TextBox")
978:         WITH loc_oOrig.txt_4c_ConOrig
979:             .Top = 35
980:             .Left = 61
981:             .Width = 79
982:             .Height = 21
983:             .MaxLength = 10
984:             .Value = ""
985:             .FontName = "Tahoma"
986:             .FontSize = 8
987:             .Visible = .T.
988:         ENDWITH
989:         BINDEVENT(loc_oOrig.txt_4c_ConOrig, "KeyPress", THIS, "ValidarContaOrig")
990: 
991:         loc_oOrig.AddObject("txt_4c_CpfOrig", "TextBox")
992:         WITH loc_oOrig.txt_4c_CpfOrig
993:             .Top = 35
994:             .Left = 142
995:             .Width = 115
996:             .Height = 21
997:             .MaxLength = 14
998:             .Value = ""
999:             .FontName = "Tahoma"
1000:             .FontSize = 8
1001:             .Visible = .T.
1002:         ENDWITH
1003: 
1004:         loc_oOrig.AddObject("txt_4c_DConOrig", "TextBox")
1005:         WITH loc_oOrig.txt_4c_DConOrig
1006:             .Top = 35
1007:             .Left = 259
1008:             .Width = 202
1009:             .Height = 21
1010:             .Value = ""
1011:             .ReadOnly = .T.
1012:             .FontName = "Tahoma"
1013:             .FontSize = 8
1014:             .Visible = .T.
1015:         ENDWITH
1016: 
1017:         *=====================================================================
1018:         *-- cnt_4c_Despesa - top=106+29=135, left=497, width=464, height=58
1019:         *=====================================================================
1020:         loc_oPg2.AddObject("cnt_4c_Despesa", "Container")
1021:         loc_oDes = loc_oPg2.cnt_4c_Despesa
1022:         WITH loc_oDes
1023:             .Top = 135
1024:             .Left = 497
1025:             .Width = 464
1026:             .Height = 58
1027:             .BackStyle = 1
1028:             .BackColor = RGB(235, 235, 235)
1029:             .BorderWidth = 1

*-- Linhas 1071 a 1155:
1071:             .FontSize = 8
1072:             .Visible = .T.
1073:         ENDWITH
1074:         BINDEVENT(loc_oDes.txt_4c_GruEmts, "KeyPress", THIS, "ValidarGrupoEmts")
1075: 
1076:         loc_oDes.AddObject("txt_4c_DGruEmts", "TextBox")
1077:         WITH loc_oDes.txt_4c_DGruEmts
1078:             .Top = 12
1079:             .Left = 142
1080:             .Width = 319
1081:             .Height = 21
1082:             .Value = ""
1083:             .ReadOnly = .T.
1084:             .FontName = "Tahoma"
1085:             .FontSize = 8
1086:             .Visible = .T.
1087:         ENDWITH
1088: 
1089:         loc_oDes.AddObject("lbl_4c_ConEmts", "Label")
1090:         WITH loc_oDes.lbl_4c_ConEmts
1091:             .Caption = "Conta :"
1092:             .Top = 38
1093:             .Left = 18
1094:             .Width = 42
1095:             .Height = 15
1096:             .AutoSize = .F.
1097:             .FontName = "Tahoma"
1098:             .FontSize = 8
1099:             .BackStyle = 0
1100:             .Visible = .T.
1101:         ENDWITH
1102: 
1103:         loc_oDes.AddObject("txt_4c_ConEmts", "TextBox")
1104:         WITH loc_oDes.txt_4c_ConEmts
1105:             .Top = 35
1106:             .Left = 61
1107:             .Width = 79
1108:             .Height = 21
1109:             .MaxLength = 10
1110:             .Value = ""
1111:             .FontName = "Tahoma"
1112:             .FontSize = 8
1113:             .Visible = .T.
1114:         ENDWITH
1115:         BINDEVENT(loc_oDes.txt_4c_ConEmts, "KeyPress", THIS, "ValidarContaEmts")
1116: 
1117:         loc_oDes.AddObject("txt_4c_CpfEmts", "TextBox")
1118:         WITH loc_oDes.txt_4c_CpfEmts
1119:             .Top = 35
1120:             .Left = 142
1121:             .Width = 115
1122:             .Height = 21
1123:             .MaxLength = 14
1124:             .Value = ""
1125:             .FontName = "Tahoma"
1126:             .FontSize = 8
1127:             .Visible = .T.
1128:         ENDWITH
1129: 
1130:         loc_oDes.AddObject("txt_4c_DConEmts", "TextBox")
1131:         WITH loc_oDes.txt_4c_DConEmts
1132:             .Top = 35
1133:             .Left = 259
1134:             .Width = 202
1135:             .Height = 21
1136:             .Value = ""
1137:             .ReadOnly = .T.
1138:             .FontName = "Tahoma"
1139:             .FontSize = 8
1140:             .Visible = .T.
1141:         ENDWITH
1142: 
1143:         *=====================================================================
1144:         *-- cnt_4c_Destino - top=166+29=195, left=6, width=464, height=58
1145:         *=====================================================================
1146:         loc_oPg2.AddObject("cnt_4c_Destino", "Container")
1147:         loc_oDst = loc_oPg2.cnt_4c_Destino
1148:         WITH loc_oDst
1149:             .Top = 195
1150:             .Left = 6
1151:             .Width = 464
1152:             .Height = 58
1153:             .BackStyle = 1
1154:             .BackColor = RGB(235, 235, 235)
1155:             .BorderWidth = 1

*-- Linhas 1197 a 1281:
1197:             .FontSize = 8
1198:             .Visible = .T.
1199:         ENDWITH
1200:         BINDEVENT(loc_oDst.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoDest")
1201: 
1202:         loc_oDst.AddObject("txt_4c_DGrupo", "TextBox")
1203:         WITH loc_oDst.txt_4c_DGrupo
1204:             .Top = 12
1205:             .Left = 141
1206:             .Width = 320
1207:             .Height = 21
1208:             .Value = ""
1209:             .ReadOnly = .T.
1210:             .FontName = "Tahoma"
1211:             .FontSize = 8
1212:             .Visible = .T.
1213:         ENDWITH
1214: 
1215:         loc_oDst.AddObject("lbl_4c_ConDest", "Label")
1216:         WITH loc_oDst.lbl_4c_ConDest
1217:             .Caption = "Conta :"
1218:             .Top = 38
1219:             .Left = 17
1220:             .Width = 42
1221:             .Height = 15
1222:             .AutoSize = .F.
1223:             .FontName = "Tahoma"
1224:             .FontSize = 8
1225:             .BackStyle = 0
1226:             .Visible = .T.
1227:         ENDWITH
1228: 
1229:         loc_oDst.AddObject("txt_4c_Conta", "TextBox")
1230:         WITH loc_oDst.txt_4c_Conta
1231:             .Top = 35
1232:             .Left = 60
1233:             .Width = 79
1234:             .Height = 21
1235:             .MaxLength = 10
1236:             .Value = ""
1237:             .FontName = "Tahoma"
1238:             .FontSize = 8
1239:             .Visible = .T.
1240:         ENDWITH
1241:         BINDEVENT(loc_oDst.txt_4c_Conta, "KeyPress", THIS, "ValidarContaDest")
1242: 
1243:         loc_oDst.AddObject("txt_4c_CpfDest", "TextBox")
1244:         WITH loc_oDst.txt_4c_CpfDest
1245:             .Top = 35
1246:             .Left = 141
1247:             .Width = 115
1248:             .Height = 21
1249:             .MaxLength = 14
1250:             .Value = ""
1251:             .FontName = "Tahoma"
1252:             .FontSize = 8
1253:             .Visible = .T.
1254:         ENDWITH
1255: 
1256:         loc_oDst.AddObject("txt_4c_DConta", "TextBox")
1257:         WITH loc_oDst.txt_4c_DConta
1258:             .Top = 35
1259:             .Left = 258
1260:             .Width = 203
1261:             .Height = 21
1262:             .Value = ""
1263:             .ReadOnly = .T.
1264:             .FontName = "Tahoma"
1265:             .FontSize = 8
1266:             .Visible = .T.
1267:         ENDWITH
1268: 
1269:         *=====================================================================
1270:         *-- cnt_4c_CCusto - Centro de Custo
1271:         *-- top=166+29=195, left=497, width=464, height=58
1272:         *=====================================================================
1273:         loc_oPg2.AddObject("cnt_4c_CCusto", "Container")
1274:         loc_oCC = loc_oPg2.cnt_4c_CCusto
1275:         WITH loc_oCC
1276:             .Top = 195
1277:             .Left = 497
1278:             .Width = 464
1279:             .Height = 58
1280:             .BackStyle = 1
1281:             .BackColor = RGB(235, 235, 235)

*-- Linhas 1324 a 1408:
1324:             .FontSize = 8
1325:             .Visible = .T.
1326:         ENDWITH
1327:         BINDEVENT(loc_oCC.txt_4c_GrupoCcs, "KeyPress", THIS, "ValidarGrupoCC")
1328: 
1329:         loc_oCC.AddObject("txt_4c_DGrupoCcs", "TextBox")
1330:         WITH loc_oCC.txt_4c_DGrupoCcs
1331:             .Top = 12
1332:             .Left = 141
1333:             .Width = 320
1334:             .Height = 21
1335:             .Value = ""
1336:             .ReadOnly = .T.
1337:             .FontName = "Tahoma"
1338:             .FontSize = 8
1339:             .Visible = .T.
1340:         ENDWITH
1341: 
1342:         loc_oCC.AddObject("lbl_4c_ConCC", "Label")
1343:         WITH loc_oCC.lbl_4c_ConCC
1344:             .Caption = "Conta :"
1345:             .Top = 38
1346:             .Left = 17
1347:             .Width = 42
1348:             .Height = 15
1349:             .AutoSize = .F.
1350:             .FontName = "Tahoma"
1351:             .FontSize = 8
1352:             .BackStyle = 0
1353:             .Visible = .T.
1354:         ENDWITH
1355: 
1356:         loc_oCC.AddObject("txt_4c_ContaCcs", "TextBox")
1357:         WITH loc_oCC.txt_4c_ContaCcs
1358:             .Top = 35
1359:             .Left = 60
1360:             .Width = 79
1361:             .Height = 21
1362:             .MaxLength = 10
1363:             .Value = ""
1364:             .FontName = "Tahoma"
1365:             .FontSize = 8
1366:             .Visible = .T.
1367:         ENDWITH
1368:         BINDEVENT(loc_oCC.txt_4c_ContaCcs, "KeyPress", THIS, "ValidarContaCC")
1369: 
1370:         loc_oCC.AddObject("txt_4c_CpfCCs", "TextBox")
1371:         WITH loc_oCC.txt_4c_CpfCCs
1372:             .Top = 35
1373:             .Left = 141
1374:             .Width = 115
1375:             .Height = 21
1376:             .MaxLength = 14
1377:             .Value = ""
1378:             .FontName = "Tahoma"
1379:             .FontSize = 8
1380:             .Visible = .T.
1381:         ENDWITH
1382: 
1383:         loc_oCC.AddObject("txt_4c_DContaCcs", "TextBox")
1384:         WITH loc_oCC.txt_4c_DContaCcs
1385:             .Top = 35
1386:             .Left = 258
1387:             .Width = 203
1388:             .Height = 21
1389:             .Value = ""
1390:             .ReadOnly = .T.
1391:             .FontName = "Tahoma"
1392:             .FontSize = 8
1393:             .Visible = .T.
1394:         ENDWITH
1395: 
1396:         *=====================================================================
1397:         *-- cnt_4c_Carteira - top=225+29=254, left=6, width=464, height=58
1398:         *=====================================================================
1399:         loc_oPg2.AddObject("cnt_4c_Carteira", "Container")
1400:         loc_oCart = loc_oPg2.cnt_4c_Carteira
1401:         WITH loc_oCart
1402:             .Top = 254
1403:             .Left = 6
1404:             .Width = 464
1405:             .Height = 58
1406:             .BackStyle = 1
1407:             .BackColor = RGB(235, 235, 235)
1408:             .BorderWidth = 1

*-- Linhas 1450 a 1534:
1450:             .FontSize = 8
1451:             .Visible = .T.
1452:         ENDWITH
1453:         BINDEVENT(loc_oCart.txt_4c_GruCart, "KeyPress", THIS, "ValidarGrupoCart")
1454: 
1455:         loc_oCart.AddObject("txt_4c_DGruCart", "TextBox")
1456:         WITH loc_oCart.txt_4c_DGruCart
1457:             .Top = 12
1458:             .Left = 142
1459:             .Width = 319
1460:             .Height = 21
1461:             .Value = ""
1462:             .ReadOnly = .T.
1463:             .FontName = "Tahoma"
1464:             .FontSize = 8
1465:             .Visible = .T.
1466:         ENDWITH
1467: 
1468:         loc_oCart.AddObject("lbl_4c_ConCart", "Label")
1469:         WITH loc_oCart.lbl_4c_ConCart
1470:             .Caption = "Conta :"
1471:             .Top = 38
1472:             .Left = 17
1473:             .Width = 42
1474:             .Height = 15
1475:             .AutoSize = .F.
1476:             .FontName = "Tahoma"
1477:             .FontSize = 8
1478:             .BackStyle = 0
1479:             .Visible = .T.
1480:         ENDWITH
1481: 
1482:         loc_oCart.AddObject("txt_4c_ConCart", "TextBox")
1483:         WITH loc_oCart.txt_4c_ConCart
1484:             .Top = 35
1485:             .Left = 60
1486:             .Width = 80
1487:             .Height = 21
1488:             .MaxLength = 10
1489:             .Value = ""
1490:             .FontName = "Tahoma"
1491:             .FontSize = 8
1492:             .Visible = .T.
1493:         ENDWITH
1494:         BINDEVENT(loc_oCart.txt_4c_ConCart, "KeyPress", THIS, "ValidarContaCart")
1495: 
1496:         loc_oCart.AddObject("txt_4c_DConCart", "TextBox")
1497:         WITH loc_oCart.txt_4c_DConCart
1498:             .Top = 35
1499:             .Left = 142
1500:             .Width = 319
1501:             .Height = 21
1502:             .Value = ""
1503:             .ReadOnly = .T.
1504:             .FontName = "Tahoma"
1505:             .FontSize = 8
1506:             .Visible = .T.
1507:         ENDWITH
1508: 
1509:         *=====================================================================
1510:         *-- cnt_4c_Processa - Processamento em lote
1511:         *-- top=225+29=254, left=497, width=480, height=58
1512:         *=====================================================================
1513:         loc_oPg2.AddObject("cnt_4c_Processa", "Container")
1514:         loc_oProc = loc_oPg2.cnt_4c_Processa
1515:         WITH loc_oProc
1516:             .Top = 254
1517:             .Left = 497
1518:             .Width = 480
1519:             .Height = 58
1520:             .BackStyle = 1
1521:             .BackColor = RGB(235, 235, 235)
1522:             .BorderWidth = 1
1523:             .Visible = .T.
1524:         ENDWITH
1525: 
1526:         loc_oProc.AddObject("lbl_4c_LblPeriodo", "Label")
1527:         WITH loc_oProc.lbl_4c_LblPeriodo
1528:             .Caption = "Per" + CHR(237) + "odo :"
1529:             .Top = 8
1530:             .Left = 21
1531:             .Width = 46
1532:             .Height = 15
1533:             .AutoSize = .F.
1534:             .FontName = "Tahoma"

*-- Linhas 1671 a 1714:
1671:             .SpecialEffect = 0
1672:             .Visible = .T.
1673:         ENDWITH
1674:         BINDEVENT(loc_oProc.cmd_4c_Sel_Planilha, "Click", THIS, "BtnSelPlanilhaClick")
1675: 
1676:         loc_oProc.AddObject("lbl_4c_Mensagem", "Label")
1677:         WITH loc_oProc.lbl_4c_Mensagem
1678:             .Caption = ""
1679:             .Top = 133
1680:             .Left = 13
1681:             .Width = 2
1682:             .Height = 15
1683:             .AutoSize = .T.
1684:             .FontName = "Tahoma"
1685:             .FontSize = 8
1686:             .ForeColor = RGB(200, 0, 0)
1687:             .BackStyle = 0
1688:             .Visible = .T.
1689:         ENDWITH
1690: 
1691:         *=====================================================================
1692:         *-- cnt_4c_Emissor - top=284+29=313, left=6, width=464, height=58
1693:         *=====================================================================
1694:         loc_oPg2.AddObject("cnt_4c_Emissor", "Container")
1695:         loc_oEmiss = loc_oPg2.cnt_4c_Emissor
1696:         WITH loc_oEmiss
1697:             .Top = 313
1698:             .Left = 6
1699:             .Width = 464
1700:             .Height = 58
1701:             .BackStyle = 1
1702:             .BackColor = RGB(235, 235, 235)
1703:             .BorderWidth = 1
1704:             .Visible = .T.
1705:         ENDWITH
1706: 
1707:         loc_oEmiss.AddObject("lbl_4c_TitEmissor", "Label")
1708:         WITH loc_oEmiss.lbl_4c_TitEmissor
1709:             .Caption = "Emissor"
1710:             .Top = 0
1711:             .Left = 4
1712:             .Width = 60
1713:             .Height = 14
1714:             .AutoSize = .F.

*-- Linhas 1745 a 1829:
1745:             .FontSize = 8
1746:             .Visible = .T.
1747:         ENDWITH
1748:         BINDEVENT(loc_oEmiss.txt_4c_GruEmiss, "KeyPress", THIS, "ValidarGrupoEmiss")
1749: 
1750:         loc_oEmiss.AddObject("txt_4c_DGruEmiss", "TextBox")
1751:         WITH loc_oEmiss.txt_4c_DGruEmiss
1752:             .Top = 12
1753:             .Left = 142
1754:             .Width = 319
1755:             .Height = 21
1756:             .Value = ""
1757:             .ReadOnly = .T.
1758:             .FontName = "Tahoma"
1759:             .FontSize = 8
1760:             .Visible = .T.
1761:         ENDWITH
1762: 
1763:         loc_oEmiss.AddObject("lbl_4c_ConEmiss", "Label")
1764:         WITH loc_oEmiss.lbl_4c_ConEmiss
1765:             .Caption = "Conta :"
1766:             .Top = 38
1767:             .Left = 18
1768:             .Width = 42
1769:             .Height = 15
1770:             .AutoSize = .F.
1771:             .FontName = "Tahoma"
1772:             .FontSize = 8
1773:             .BackStyle = 0
1774:             .Visible = .T.
1775:         ENDWITH
1776: 
1777:         loc_oEmiss.AddObject("txt_4c_ConEmiss", "TextBox")
1778:         WITH loc_oEmiss.txt_4c_ConEmiss
1779:             .Top = 35
1780:             .Left = 61
1781:             .Width = 79
1782:             .Height = 21
1783:             .MaxLength = 10
1784:             .Value = ""
1785:             .FontName = "Tahoma"
1786:             .FontSize = 8
1787:             .Visible = .T.
1788:         ENDWITH
1789:         BINDEVENT(loc_oEmiss.txt_4c_ConEmiss, "KeyPress", THIS, "ValidarContaEmiss")
1790: 
1791:         loc_oEmiss.AddObject("txt_4c_CpfEmiss", "TextBox")
1792:         WITH loc_oEmiss.txt_4c_CpfEmiss
1793:             .Top = 35
1794:             .Left = 142
1795:             .Width = 115
1796:             .Height = 21
1797:             .MaxLength = 14
1798:             .Value = ""
1799:             .FontName = "Tahoma"
1800:             .FontSize = 8
1801:             .Visible = .T.
1802:         ENDWITH
1803: 
1804:         loc_oEmiss.AddObject("txt_4c_DConEmiss", "TextBox")
1805:         WITH loc_oEmiss.txt_4c_DConEmiss
1806:             .Top = 35
1807:             .Left = 259
1808:             .Width = 202
1809:             .Height = 21
1810:             .Value = ""
1811:             .ReadOnly = .T.
1812:             .FontName = "Tahoma"
1813:             .FontSize = 8
1814:             .Visible = .T.
1815:         ENDWITH
1816: 
1817:         *=====================================================================
1818:         *-- Observacao (fwmemo1) - EditBox
1819:         *-- original: top=288+29=317, left=581, width=391, height=48
1820:         *=====================================================================
1821:         loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
1822:         WITH loc_oPg2.lbl_4c_Observacao
1823:             .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
1824:             .Top = 319
1825:             .Left = 509
1826:             .Width = 70
1827:             .Height = 15
1828:             .AutoSize = .F.
1829:             .FontName = "Tahoma"

*-- Linhas 1963 a 2098:
1963:             .SpecialEffect = 0
1964:             .Visible = .T.
1965:         ENDWITH
1966:         BINDEVENT(loc_oPg2.cmd_4c_BtnMarca, "Click", THIS, "BtnMarcaClick")
1967: 
1968:         *-- Botao Excluir cheque da grade - top=390+29=419, left=767
1969:         loc_oPg2.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1970:         WITH loc_oPg2.cmd_4c_BtnExcluir
1971:             .Top = 419
1972:             .Left = 767
1973:             .Width = 40
1974:             .Height = 40
1975:             .Caption = "Excluir"
1976:             .FontName = "Tahoma"
1977:             .FontSize = 7
1978:             .BackColor = RGB(255, 255, 255)
1979:             .Themes = .F.
1980:             .SpecialEffect = 0
1981:             .Visible = .T.
1982:         ENDWITH
1983:         BINDEVENT(loc_oPg2.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirChequeClick")
1984: 
1985:         *=====================================================================
1986:         *-- Botoes leitora + FollowUp (coluna direita)
1987:         *-- Chk_FollowUp: top=364+29=393, left=826
1988:         *-- CmdExcCheque: top=364+29=393, left=901
1989:         *-- Comm_Ini:     top=441+29=470, left=826
1990:         *-- Comm_Fim:     top=441+29=470, left=901
1991:         *=====================================================================
1992:         loc_oPg2.AddObject("chk_4c_FollowUp", "CheckBox")
1993:         WITH loc_oPg2.chk_4c_FollowUp
1994:             .Top = 393
1995:             .Left = 826
1996:             .Width = 75
1997:             .Height = 75
1998:             .Caption = "Repetir Followup"
1999:             .Value = 0
2000:             .FontName = "Tahoma"
2001:             .FontSize = 8
2002:             .BackStyle = 0
2003:             .Visible = .T.
2004:         ENDWITH
2005: 
2006:         loc_oPg2.AddObject("cmd_4c_CmdExcCheque", "CommandButton")
2007:         WITH loc_oPg2.cmd_4c_CmdExcCheque
2008:             .Top = 393
2009:             .Left = 901
2010:             .Width = 75
2011:             .Height = 75
2012:             .Caption = "Excluir Cheque"
2013:             .FontName = "Tahoma"
2014:             .FontBold = .T.
2015:             .FontItalic = .T.
2016:             .FontSize = 8
2017:             .BackColor = RGB(255, 255, 255)
2018:             .Themes = .F.
2019:             .SpecialEffect = 0
2020:             .Visible = .T.
2021:         ENDWITH
2022:         BINDEVENT(loc_oPg2.cmd_4c_CmdExcCheque, "Click", THIS, "BtnCmdExcChequeClick")
2023: 
2024:         loc_oPg2.AddObject("cmd_4c_Comm_Ini", "CommandButton")
2025:         WITH loc_oPg2.cmd_4c_Comm_Ini
2026:             .Top = 470
2027:             .Left = 826
2028:             .Width = 75
2029:             .Height = 75
2030:             .Caption = "Acionar Leitora"
2031:             .FontName = "Tahoma"
2032:             .FontBold = .T.
2033:             .FontItalic = .T.
2034:             .FontSize = 8
2035:             .BackColor = RGB(255, 255, 255)
2036:             .Themes = .F.
2037:             .SpecialEffect = 0
2038:             .Visible = .T.
2039:         ENDWITH
2040:         BINDEVENT(loc_oPg2.cmd_4c_Comm_Ini, "Click", THIS, "BtnCommIniClick")
2041: 
2042:         loc_oPg2.AddObject("cmd_4c_Comm_Fim", "CommandButton")
2043:         WITH loc_oPg2.cmd_4c_Comm_Fim
2044:             .Top = 470
2045:             .Left = 901
2046:             .Width = 75
2047:             .Height = 75
2048:             .Caption = "Encerrar Leitora"
2049:             .FontName = "Tahoma"
2050:             .FontBold = .T.
2051:             .FontItalic = .T.
2052:             .FontSize = 8
2053:             .BackColor = RGB(255, 255, 255)
2054:             .Themes = .F.
2055:             .SpecialEffect = 0
2056:             .Visible = .T.
2057:         ENDWITH
2058:         BINDEVENT(loc_oPg2.cmd_4c_Comm_Fim, "Click", THIS, "BtnCommFimClick")
2059: 
2060:         *=====================================================================
2061:         *-- Indicadores de porta + totalizadores
2062:         *-- top=440+29=469
2063:         *=====================================================================
2064:         loc_oPg2.AddObject("lbl_4c_AvisoPortaS", "Label")
2065:         WITH loc_oPg2.lbl_4c_AvisoPortaS
2066:             .Caption = "S"
2067:             .Top = 469
2068:             .Left = 7
2069:             .Width = 21
2070:             .Height = 26
2071:             .AutoSize = .F.
2072:             .FontName = "Tahoma"
2073:             .FontSize = 10
2074:             .FontBold = .T.
2075:             .ForeColor = RGB(180, 180, 180)
2076:             .BackStyle = 0
2077:             .Visible = .T.
2078:         ENDWITH
2079: 
2080:         loc_oPg2.AddObject("lbl_4c_AvisoPortaM", "Label")
2081:         WITH loc_oPg2.lbl_4c_AvisoPortaM
2082:             .Caption = "M"
2083:             .Top = 469
2084:             .Left = 30
2085:             .Width = 21
2086:             .Height = 26
2087:             .AutoSize = .F.
2088:             .FontName = "Tahoma"
2089:             .FontSize = 10
2090:             .FontBold = .T.
2091:             .ForeColor = RGB(180, 180, 180)
2092:             .BackStyle = 0
2093:             .Visible = .T.
2094:         ENDWITH
2095: 
2096:         loc_oPg2.AddObject("lbl_4c_AvisoPortaT", "Label")
2097:         WITH loc_oPg2.lbl_4c_AvisoPortaT
2098:             .Caption = "T"

*-- Linhas 2480 a 2523:
2480:             .FontSize = 8
2481:             .Visible = .T.
2482:         ENDWITH
2483:         BINDEVENT(loc_oEmp.txt_4c_Emps, "KeyPress", THIS, "ValidarEmpresa")
2484: 
2485:         loc_oEmp.AddObject("txt_4c_DEmps", "TextBox")
2486:         WITH loc_oEmp.txt_4c_DEmps
2487:             .Top = 1
2488:             .Left = 96
2489:             .Width = 290
2490:             .Height = 21
2491:             .Value = ""
2492:             .ReadOnly = .T.
2493:             .FontName = "Tahoma"
2494:             .FontSize = 8
2495:             .Visible = .T.
2496:         ENDWITH
2497: 
2498:         *=====================================================================
2499:         *-- cnt_4c_Conta - Conta do cliente/emissor
2500:         *-- top=531+29=560, left=52, width=648, height=23
2501:         *=====================================================================
2502:         loc_oPg2.AddObject("cnt_4c_Conta", "Container")
2503:         loc_oCnt = loc_oPg2.cnt_4c_Conta
2504:         WITH loc_oCnt
2505:             .Top = 560
2506:             .Left = 52
2507:             .Width = 648
2508:             .Height = 23
2509:             .BackStyle = 0
2510:             .BorderWidth = 0
2511:             .Visible = .T.
2512:         ENDWITH
2513: 
2514:         loc_oCnt.AddObject("lbl_4c_LblConta", "Label")
2515:         WITH loc_oCnt.lbl_4c_LblConta
2516:             .Caption = "Conta :"
2517:             .Top = 4
2518:             .Left = 13
2519:             .Width = 38
2520:             .Height = 15
2521:             .AutoSize = .F.
2522:             .FontName = "Tahoma"
2523:             .FontSize = 8

*-- Linhas 2538 a 2581:
2538:             .FontSize = 8
2539:             .Visible = .T.
2540:         ENDWITH
2541:         BINDEVENT(loc_oCnt.txt_4c_ContaIclis, "KeyPress", THIS, "ValidarContaIclis")
2542: 
2543:         loc_oCnt.AddObject("txt_4c_CpfIclis", "TextBox")
2544:         WITH loc_oCnt.txt_4c_CpfIclis
2545:             .Top = 0
2546:             .Left = 133
2547:             .Width = 150
2548:             .Height = 21
2549:             .MaxLength = 14
2550:             .Value = ""
2551:             .FontName = "Tahoma"
2552:             .FontSize = 8
2553:             .Visible = .T.
2554:         ENDWITH
2555: 
2556:         loc_oCnt.AddObject("txt_4c_NomeIclis", "TextBox")
2557:         WITH loc_oCnt.txt_4c_NomeIclis
2558:             .Top = 0
2559:             .Left = 285
2560:             .Width = 360
2561:             .Height = 21
2562:             .Value = ""
2563:             .ReadOnly = .T.
2564:             .FontName = "Tahoma"
2565:             .FontSize = 8
2566:             .Visible = .T.
2567:         ENDWITH
2568: 
2569:         *=====================================================================
2570:         *-- cnt_4c_Filtro - Filtro vencimento
2571:         *-- top=531+29=560, left=699, width=296, height=60
2572:         *=====================================================================
2573:         loc_oPg2.AddObject("cnt_4c_Filtro", "Container")
2574:         loc_oFil = loc_oPg2.cnt_4c_Filtro
2575:         WITH loc_oFil
2576:             .Top = 560
2577:             .Left = 699
2578:             .Width = 296
2579:             .Height = 60
2580:             .BackStyle = 1
2581:             .BackColor = RGB(235, 235, 235)

*-- Linhas 2706 a 2778:
2706:             .FontSize = 8
2707:             .Visible = .T.
2708:         ENDWITH
2709:         BINDEVENT(loc_oRes.txt_4c_GruRes, "KeyPress", THIS, "ValidarGrupoRes")
2710: 
2711:         loc_oRes.AddObject("lbl_4c_SepRes", "Label")
2712:         WITH loc_oRes.lbl_4c_SepRes
2713:             .Caption = "/"
2714:             .Top = 3
2715:             .Left = 168
2716:             .Width = 8
2717:             .Height = 15
2718:             .AutoSize = .F.
2719:             .FontName = "Tahoma"
2720:             .FontSize = 8
2721:             .ForeColor = RGB(255, 255, 255)
2722:             .BackStyle = 0
2723:             .Visible = .T.
2724:         ENDWITH
2725: 
2726:         loc_oRes.AddObject("txt_4c_ConRes", "TextBox")
2727:         WITH loc_oRes.txt_4c_ConRes
2728:             .Top = 0
2729:             .Left = 178
2730:             .Width = 79
2731:             .Height = 21
2732:             .MaxLength = 10
2733:             .Value = ""
2734:             .FontName = "Tahoma"
2735:             .FontSize = 8
2736:             .Visible = .T.
2737:         ENDWITH
2738:         BINDEVENT(loc_oRes.txt_4c_ConRes, "KeyPress", THIS, "ValidarContaRes")
2739: 
2740:         loc_oRes.AddObject("txt_4c_DConRes", "TextBox")
2741:         WITH loc_oRes.txt_4c_DConRes
2742:             .Top = 0
2743:             .Left = 259
2744:             .Width = 419
2745:             .Height = 21
2746:             .Value = ""
2747:             .ReadOnly = .T.
2748:             .FontName = "Tahoma"
2749:             .FontSize = 8
2750:             .Visible = .T.
2751:         ENDWITH
2752: 
2753:         *=====================================================================
2754:         *-- cnt_4c_FollowUp - top=574+29=603, left=41, width=658, height=25
2755:         *=====================================================================
2756:         loc_oPg2.AddObject("cnt_4c_FollowUp", "Container")
2757:         loc_oFol = loc_oPg2.cnt_4c_FollowUp
2758:         WITH loc_oFol
2759:             .Top = 603
2760:             .Left = 41
2761:             .Width = 658
2762:             .Height = 25
2763:             .BackStyle = 0
2764:             .BorderWidth = 0
2765:             .Visible = .T.
2766:         ENDWITH
2767: 
2768:         loc_oFol.AddObject("lbl_4c_LblFollowUp", "Label")
2769:         WITH loc_oFol.lbl_4c_LblFollowUp
2770:             .Caption = "Followup :"
2771:             .Top = 3
2772:             .Left = 12
2773:             .Width = 50
2774:             .Height = 15
2775:             .AutoSize = .F.
2776:             .FontName = "Tahoma"
2777:             .FontSize = 8
2778:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 2794 a 2843:
2794:         ENDWITH
2795: 
2796:         THIS.RegistrarKeyPressLookups()
2797:         THIS.TornarControlesVisiveis(loc_oPg2)
2798:     ENDPROC
2799: 
2800:     *--------------------------------------------------------------------------
2801:     * CarregarLista - carrega cursor_4c_Dados e vincula ao grd_4c_Dados
2802:     *--------------------------------------------------------------------------
2803:     PROCEDURE CarregarLista()
2804:         LOCAL loc_lResultado, loc_oGrid, loc_cFiltro
2805:         LOCAL loc_oPg1, loc_dDtI, loc_dDtF, loc_nConc
2806:         loc_lResultado = .F.
2807: 
2808:         TRY
2809:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2810:                 LOCAL loc_nDsAtual
2811:                 loc_nDsAtual = THIS.DataSessionID
2812:                 SET DATASESSION TO 1
2813:                 IF USED("cursor_4c_Dados")
2814:                     USE IN cursor_4c_Dados
2815:                 ENDIF
2816:                 CREATE CURSOR cursor_4c_Dados ;
2817:                     (numlotes N(10,0), emps C(3), dtents D, codigos C(15), ;
2818:                      valtots N(15,2), concs N(1,0))
2819:                 SET DATASESSION TO (loc_nDsAtual)
2820:                 loc_lResultado = .T.
2821:             ELSE
2822:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2823: 
2824:                 *-- Montar filtro a partir dos controles da Page1
2825:                 loc_cFiltro = ""
2826:                 loc_dDtI = {}
2827:                 loc_dDtF = {}
2828:                 loc_nConc = 0
2829: 
2830:                 IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"
2831:                     loc_dDtI = loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial.Value
2832:                 ENDIF
2833:                 IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final) = "O"
2834:                     loc_dDtF = loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final.Value
2835:                 ENDIF
2836:                 IF VARTYPE(loc_oPg1.cbo_4c_Cmb_Concilia) = "O"
2837:                     loc_nConc = loc_oPg1.cbo_4c_Cmb_Concilia.ListIndex
2838:                 ENDIF
2839: 
2840:                 IF !EMPTY(loc_dDtI) AND !EMPTY(loc_dDtF)
2841:                     loc_cFiltro = loc_cFiltro + ;
2842:                         " AND a.dtents >= " + FormatarDataSQL(loc_dDtI) + ;
2843:                         " AND a.dtents <= " + FormatarDataSQL(loc_dDtF)

*-- Linhas 2854 a 3417:
2854:                     loc_lResultado = .F.
2855:                 ELSE
2856:                     IF VARTYPE(loc_oPg1.grd_4c_Dados) = "O"
2857:                         loc_oGrid = loc_oPg1.grd_4c_Dados
2858:                         loc_oGrid.ColumnCount = 6
2859:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2860:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.numlotes"
2861:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
2862:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.dtents"
2863:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.codigos"
2864:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.valtots"
2865:                         loc_oGrid.Column6.ControlSource = ;
2866:                             "IIF(cursor_4c_Dados.concs=1,'Conciliado','Pendente')"
2867:                         loc_oGrid.Column1.Header1.Caption = "Lote"
2868:                         loc_oGrid.Column2.Header1.Caption = "Empresa"
2869:                         loc_oGrid.Column3.Header1.Caption = "Data Entrada"
2870:                         loc_oGrid.Column4.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2871:                         loc_oGrid.Column5.Header1.Caption = "Valor Total"
2872:                         loc_oGrid.Column6.Header1.Caption = "Situa" + CHR(231) + CHR(227) + "o"
2873:                         THIS.FormatarGridLista(loc_oGrid)
2874:                     ENDIF
2875:                     loc_lResultado = .T.
2876:                 ENDIF
2877:             ENDIF
2878:         CATCH TO loc_oErro
2879:             MsgErro(loc_oErro.Message, "Formlch.CarregarLista")
2880:         ENDTRY
2881: 
2882:         RETURN loc_lResultado
2883:     ENDPROC
2884: 
2885:     *--------------------------------------------------------------------------
2886:     * AlternarPagina - alterna entre Page1 (Lista) e Page2 (Dados)
2887:     *--------------------------------------------------------------------------
2888:     PROCEDURE AlternarPagina(par_nPagina)
2889:         LOCAL loc_lResultado
2890:         loc_lResultado = .F.
2891: 
2892:         IF VARTYPE(par_nPagina) != "N" OR !INLIST(par_nPagina, 1, 2)
2893:             RETURN .F.
2894:         ENDIF
2895: 
2896:         TRY
2897:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2898: 
2899:             IF par_nPagina = 1
2900:                 THIS.this_cModoAtual = "LISTA"
2901:                 THIS.CarregarLista()
2902:             ENDIF
2903: 
2904:             loc_lResultado = .T.
2905:         CATCH TO loc_oErro
2906:             MsgErro(loc_oErro.Message, "Formlch.AlternarPagina")
2907:         ENDTRY
2908: 
2909:         RETURN loc_lResultado
2910:     ENDPROC
2911: 
2912:     *--------------------------------------------------------------------------
2913:     * CarregarGrade - carrega cheques do lote no grd_4c_Cheques (Page2)
2914:     *--------------------------------------------------------------------------
2915:     PROCEDURE CarregarGrade()
2916:         LOCAL loc_lResultado, loc_oGrid, loc_nLote
2917:         loc_lResultado = .F.
2918: 
2919:         TRY
2920:             loc_nLote = THIS.this_oBusinessObject.this_nNumLotes
2921: 
2922:             IF loc_nLote <= 0
2923:                 IF USED("cursor_4c_ChequesM")
2924:                     USE IN cursor_4c_ChequesM
2925:                 ENDIF
2926:                 CREATE CURSOR cursor_4c_ChequesM ;
2927:                     (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2928:                      valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2929:                      iclis C(10), protocolos C(20), dtemis D, marca L)
2930:                 loc_lResultado = .T.
2931:             ELSE
2932:                 IF THIS.this_oBusinessObject.BuscarCheques(loc_nLote)
2933:                     IF USED("cursor_4c_ChequesM")
2934:                         USE IN cursor_4c_ChequesM
2935:                     ENDIF
2936: 
2937:                     IF USED("cursor_4c_Cheques") AND RECCOUNT("cursor_4c_Cheques") >= 0
2938:                         SELECT bancos, agencias, ncontas, ncheques, valors, vencs, ;
2939:                             nalineas, emps, iclis, protocolos, dtemis, .F. AS marca ;
2940:                             FROM cursor_4c_Cheques ;
2941:                             INTO CURSOR cursor_4c_ChequesM READWRITE
2942:                     ELSE
2943:                         CREATE CURSOR cursor_4c_ChequesM ;
2944:                             (bancos C(5), agencias C(10), ncontas C(20), ncheques C(20), ;
2945:                              valors N(15,2), vencs D, nalineas C(5), emps C(3), ;
2946:                              iclis C(10), protocolos C(20), dtemis D, marca L)
2947:                     ENDIF
2948:                     loc_lResultado = .T.
2949:                 ENDIF
2950:             ENDIF
2951: 
2952:             IF loc_lResultado
2953:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques) = "O"
2954:                     loc_oGrid = THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques
2955:                     loc_oGrid.ColumnCount = 12
2956:                     loc_oGrid.RecordSource = "cursor_4c_ChequesM"
2957:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_ChequesM.bancos"
2958:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_ChequesM.agencias"
2959:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_ChequesM.ncontas"
2960:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_ChequesM.ncheques"
2961:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_ChequesM.valors"
2962:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_ChequesM.vencs"
2963:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_ChequesM.nalineas"
2964:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_ChequesM.emps"
2965:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_ChequesM.iclis"
2966:                     loc_oGrid.Column10.ControlSource = "cursor_4c_ChequesM.protocolos"
2967:                     loc_oGrid.Column11.ControlSource = "cursor_4c_ChequesM.dtemis"
2968:                     loc_oGrid.Column12.ControlSource = "cursor_4c_ChequesM.marca"
2969:                 ENDIF
2970: 
2971:                 *-- Atualizar totalizadores
2972:                 IF USED("cursor_4c_ChequesM")
2973:                     LOCAL loc_nQtde, loc_nVlrTot
2974:                     loc_nQtde   = RECCOUNT("cursor_4c_ChequesM")
2975:                     loc_nVlrTot = 0
2976:                     SELECT SUM(valors) FROM cursor_4c_ChequesM INTO ARRAY laVlr
2977:                     IF TYPE("laVlr") = "N"
2978:                         loc_nVlrTot = laVlr
2979:                     ENDIF
2980: 
2981:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs) = "O"
2982:                         THIS.pgf_4c_Paginas.Page2.txt_4c_QtdeChqs.Value = loc_nQtde
2983:                     ENDIF
2984:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal) = "O"
2985:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ValorTotal.Value = loc_nVlrTot
2986:                     ENDIF
2987:                 ENDIF
2988:             ENDIF
2989:         CATCH TO loc_oErro
2990:             MsgErro(loc_oErro.Message, "Formlch.CarregarGrade")
2991:         ENDTRY
2992: 
2993:         RETURN loc_lResultado
2994:     ENDPROC
2995: 
2996:     *--------------------------------------------------------------------------
2997:     * BtnEncerrarClick
2998:     *--------------------------------------------------------------------------
2999:     PROCEDURE BtnEncerrarClick()
3000:         THIS.Release()
3001:     ENDPROC
3002: 
3003:     *--------------------------------------------------------------------------
3004:     * BtnIncluirClick
3005:     *--------------------------------------------------------------------------
3006:     PROCEDURE BtnIncluirClick()
3007:         THIS.this_oBusinessObject.NovoRegistro()
3008:         THIS.LimparCampos()
3009:         THIS.this_cModoAtual = "INCLUIR"
3010:         THIS.HabilitarCampos(.T.)
3011:         THIS.AjustarBotoesPorModo()
3012:         THIS.CarregarGrade()
3013:         THIS.AlternarPagina(2)
3014:     ENDPROC
3015: 
3016:     *--------------------------------------------------------------------------
3017:     * BtnVisualizarClick
3018:     *--------------------------------------------------------------------------
3019:     PROCEDURE BtnVisualizarClick()
3020:         LOCAL loc_nLote
3021: 
3022:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3023:             MsgAviso("Selecione um registro na lista.", "")
3024:             RETURN
3025:         ENDIF
3026: 
3027:         SELECT cursor_4c_Dados
3028:         loc_nLote = cursor_4c_Dados.numlotes
3029: 
3030:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3031:             THIS.this_cModoAtual = "VISUALIZAR"
3032:             THIS.BOParaForm()
3033:             THIS.CarregarGrade()
3034:             THIS.HabilitarCampos(.F.)
3035:             THIS.AjustarBotoesPorModo()
3036:             THIS.AlternarPagina(2)
3037:         ENDIF
3038:     ENDPROC
3039: 
3040:     *--------------------------------------------------------------------------
3041:     * BtnAlterarClick
3042:     *--------------------------------------------------------------------------
3043:     PROCEDURE BtnAlterarClick()
3044:         LOCAL loc_nLote
3045: 
3046:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3047:             MsgAviso("Selecione um registro na lista.", "")
3048:             RETURN
3049:         ENDIF
3050: 
3051:         SELECT cursor_4c_Dados
3052:         loc_nLote = cursor_4c_Dados.numlotes
3053: 
3054:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3055:             THIS.this_oBusinessObject.EditarRegistro()
3056:             THIS.this_cModoAtual = "ALTERAR"
3057:             THIS.BOParaForm()
3058:             THIS.CarregarGrade()
3059:             THIS.HabilitarCampos(.T.)
3060:             THIS.AjustarBotoesPorModo()
3061:             THIS.AlternarPagina(2)
3062:         ENDIF
3063:     ENDPROC
3064: 
3065:     *--------------------------------------------------------------------------
3066:     * BtnExcluirClick
3067:     *--------------------------------------------------------------------------
3068:     PROCEDURE BtnExcluirClick()
3069:         LOCAL loc_nLote
3070: 
3071:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3072:             MsgAviso("Selecione um registro para excluir.", "")
3073:             RETURN
3074:         ENDIF
3075: 
3076:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste lote de cheques?" + CHR(13) + ;
3077:                         "Os cheques vinculados tamb" + CHR(233) + "m ser" + CHR(227) + "o exclu" + ;
3078:                         CHR(237) + "dos!", "Confirmar")
3079:             RETURN
3080:         ENDIF
3081: 
3082:         SELECT cursor_4c_Dados
3083:         loc_nLote = cursor_4c_Dados.numlotes
3084: 
3085:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nLote)
3086:             IF THIS.this_oBusinessObject.Excluir()
3087:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "")
3088:                 THIS.CarregarLista()
3089:             ENDIF
3090:         ENDIF
3091:     ENDPROC
3092: 
3093:     *--------------------------------------------------------------------------
3094:     * BtnBuscarClick
3095:     *--------------------------------------------------------------------------
3096:     PROCEDURE BtnBuscarClick()
3097:         LOCAL loc_oBusca, loc_nLote, loc_lResultado
3098:         loc_lResultado = .F.
3099: 
3100:         TRY
3101:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3102:                 "SigChLcq", "cursor_4c_BuscaLch", "numlotes", "", ;
3103:                 "Lote de Cheques")
3104: 
3105:             IF VARTYPE(loc_oBusca) = "O"
3106:                 loc_oBusca.mAddColuna("numlotes", "", "Lote")
3107:                 loc_oBusca.mAddColuna("dtents",   "", "Data")
3108:                 loc_oBusca.mAddColuna("codigos",  "", "Opera" + CHR(231) + CHR(227) + "o")
3109:                 loc_oBusca.mAddColuna("emps",     "", "Empresa")
3110:                 loc_oBusca.mAddColuna("valtots",  "", "Valor")
3111:                 loc_oBusca.Show()
3112: 
3113:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLch")
3114:                     SELECT cursor_4c_BuscaLch
3115:                     IF !EOF("cursor_4c_BuscaLch")
3116:                         loc_nLote = cursor_4c_BuscaLch.numlotes
3117:                         THIS.this_oBusinessObject.Buscar("AND a.numlotes = " + ;
3118:                             FormatarNumeroSQL(loc_nLote))
3119:                         THIS.CarregarLista()
3120:                     ENDIF
3121:                 ELSE
3122:                     THIS.CarregarLista()
3123:                 ENDIF
3124: 
3125:                 loc_oBusca.Release()
3126:                 loc_lResultado = .T.
3127:             ENDIF
3128:         CATCH TO loc_oErro
3129:             MsgErro(loc_oErro.Message, "Formlch.BtnBuscarClick")
3130:         ENDTRY
3131: 
3132:         IF USED("cursor_4c_BuscaLch")
3133:             USE IN cursor_4c_BuscaLch
3134:         ENDIF
3135:     ENDPROC
3136: 
3137:     *--------------------------------------------------------------------------
3138:     * BtnSalvarClick
3139:     *--------------------------------------------------------------------------
3140:     PROCEDURE BtnSalvarClick()
3141:         LOCAL loc_oPg2
3142:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3143: 
3144:         *-- Validacoes fora do TRY (RETURN funciona aqui)
3145:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3146:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Oper.Value))
3147:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!", "")
3148:                 RETURN
3149:             ENDIF
3150:         ENDIF
3151: 
3152:         IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3153:             IF EMPTY(loc_oPg2.txt_4c_Data.Value)
3154:                 MsgAviso("Data de entrada obrigat" + CHR(243) + "ria!", "")
3155:                 RETURN
3156:             ENDIF
3157:         ENDIF
3158: 
3159:         THIS.FormParaBO()
3160: 
3161:         IF THIS.this_oBusinessObject.Salvar()
3162:             MsgInfo("Registro salvo com sucesso!", "")
3163:             THIS.this_cModoAtual = "LISTA"
3164:             THIS.AlternarPagina(1)
3165:         ENDIF
3166:     ENDPROC
3167: 
3168:     *--------------------------------------------------------------------------
3169:     * BtnCancelarClick
3170:     *--------------------------------------------------------------------------
3171:     PROCEDURE BtnCancelarClick()
3172:         THIS.this_cModoAtual = "LISTA"
3173:         THIS.AlternarPagina(1)
3174:     ENDPROC
3175: 
3176:     *--------------------------------------------------------------------------
3177:     * BtnLimpaDTClick - limpa datas do filtro e recarrega lista
3178:     *--------------------------------------------------------------------------
3179:     PROCEDURE BtnLimpaDTClick()
3180:         LOCAL loc_oPg1
3181:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3182: 
3183:         TRY
3184:             IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial) = "O"
3185:                 loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_inicial.Value = {}
3186:             ENDIF
3187:             IF VARTYPE(loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final) = "O"
3188:                 loc_oPg1.cnt_4c_Filtros.cnt_4c__periodo.txt_4c_Dt_final.Value = {}
3189:             ENDIF
3190:             IF VARTYPE(loc_oPg1.cbo_4c_Cmb_Concilia) = "O"
3191:                 loc_oPg1.cbo_4c_Cmb_Concilia.ListIndex = 1
3192:             ENDIF
3193:             THIS.CarregarLista()
3194:         CATCH TO loc_oErro
3195:             MsgErro(loc_oErro.Message, "Formlch.BtnLimpaDTClick")
3196:         ENDTRY
3197:     ENDPROC
3198: 
3199:     *--------------------------------------------------------------------------
3200:     * BtnConciliacaoClick - stub para processo de conciliacao
3201:     *--------------------------------------------------------------------------
3202:     PROCEDURE BtnConciliacaoClick()
3203:         MsgInfo("Processo de concilia" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
3204:                 "o implementado nesta vers" + CHR(227) + "o.", "")
3205:     ENDPROC
3206: 
3207:     *--------------------------------------------------------------------------
3208:     * CboConcilaChange - recarrega lista ao mudar filtro de situacao
3209:     *--------------------------------------------------------------------------
3210:     PROCEDURE CboConcilaChange()
3211:         THIS.CarregarLista()
3212:     ENDPROC
3213: 
3214:     *--------------------------------------------------------------------------
3215:     * BtnAlteraCotacaoClick - abre busca de cotacao para a moeda selecionada
3216:     *--------------------------------------------------------------------------
3217:     PROCEDURE BtnAlteraCotacaoClick()
3218:         LOCAL loc_oPg2, loc_cMoeda
3219:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3220: 
3221:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3222:             loc_cMoeda = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
3223:         ELSE
3224:             loc_cMoeda = ""
3225:         ENDIF
3226: 
3227:         IF EMPTY(loc_cMoeda)
3228:             MsgAviso("Informe a moeda antes de alterar a cota" + CHR(231) + CHR(227) + "o.", "")
3229:             RETURN
3230:         ENDIF
3231: 
3232:         MsgInfo("Consulta de cota" + CHR(231) + CHR(227) + "o para moeda: " + loc_cMoeda, "")
3233:     ENDPROC
3234: 
3235:     *--------------------------------------------------------------------------
3236:     * BtnSelPlanilhaClick - selecionar planilha Excel para processamento
3237:     *--------------------------------------------------------------------------
3238:     PROCEDURE BtnSelPlanilhaClick()
3239:         LOCAL loc_cArquivo
3240:         loc_cArquivo = GETFILE("XLS;XLSX", "Selecionar Planilha", "Selecionar")
3241:         IF !EMPTY(loc_cArquivo)
3242:             IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cnt_4c_Processa.txt_4c_Planilha) = "O"
3243:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Processa.txt_4c_Planilha.Value = loc_cArquivo
3244:             ENDIF
3245:         ENDIF
3246:     ENDPROC
3247: 
3248:     *--------------------------------------------------------------------------
3249:     * BtnCmdProcessaClick - processamento em lote (stub)
3250:     *--------------------------------------------------------------------------
3251:     PROCEDURE BtnCmdProcessaClick()
3252:         MsgInfo("Processamento em lote n" + CHR(227) + "o implementado nesta vers" + CHR(227) + "o.", "")
3253:     ENDPROC
3254: 
3255:     *--------------------------------------------------------------------------
3256:     * BtnExcluirChequeClick - exclui cheque selecionado no grd_4c_Cheques
3257:     *--------------------------------------------------------------------------
3258:     PROCEDURE BtnExcluirChequeClick()
3259:         LOCAL loc_cSQL, loc_nResult, loc_nNums
3260: 
3261:         IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
3262:             MsgAviso("Selecione um cheque na lista.", "")
3263:             RETURN
3264:         ENDIF
3265: 
3266:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste cheque do lote?", "")
3267:             RETURN
3268:         ENDIF
3269: 
3270:         TRY
3271:             SELECT cursor_4c_ChequesM
3272: 
3273:             IF THIS.this_oBusinessObject.this_nNumLotes <= 0
3274:                 MsgAviso("Salve o lote antes de excluir cheques.", "")
3275:                 RETURN
3276:             ENDIF
3277: 
3278:             loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3279:                 FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3280:                 " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3281:                 " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3282:                 " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3283:                 " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3284: 
3285:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3286: 
3287:             IF loc_nResult < 0
3288:                 MsgErro("Erro ao excluir cheque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3289:             ELSE
3290:                 MsgInfo("Cheque exclu" + CHR(237) + "do com sucesso!", "")
3291:                 THIS.CarregarGrade()
3292:             ENDIF
3293:         CATCH TO loc_oErro
3294:             MsgErro(loc_oErro.Message, "Formlch.BtnExcluirChequeClick")
3295:         ENDTRY
3296:     ENDPROC
3297: 
3298:     *--------------------------------------------------------------------------
3299:     * BtnMarcaClick - marca/desmarca cheque selecionado
3300:     *--------------------------------------------------------------------------
3301:     PROCEDURE BtnMarcaClick()
3302:         IF !USED("cursor_4c_ChequesM") OR EOF("cursor_4c_ChequesM")
3303:             RETURN
3304:         ENDIF
3305: 
3306:         TRY
3307:             SELECT cursor_4c_ChequesM
3308:             REPLACE cursor_4c_ChequesM.marca WITH !cursor_4c_ChequesM.marca
3309:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Grade.grd_4c_Cheques.Refresh()
3310:         CATCH TO loc_oErro
3311:             MsgErro(loc_oErro.Message, "Formlch.BtnMarcaClick")
3312:         ENDTRY
3313:     ENDPROC
3314: 
3315:     *--------------------------------------------------------------------------
3316:     * BtnCmdExcChequeClick - exclui cheques marcados do lote
3317:     *--------------------------------------------------------------------------
3318:     PROCEDURE BtnCmdExcChequeClick()
3319:         LOCAL loc_cSQL, loc_nResult, loc_nExcluidos
3320: 
3321:         IF !USED("cursor_4c_ChequesM") OR RECCOUNT("cursor_4c_ChequesM") = 0
3322:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " cheques para excluir.", "")
3323:             RETURN
3324:         ENDIF
3325: 
3326:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o dos cheques marcados?", "")
3327:             RETURN
3328:         ENDIF
3329: 
3330:         TRY
3331:             loc_nExcluidos = 0
3332:             SELECT cursor_4c_ChequesM
3333:             GO TOP
3334: 
3335:             DO WHILE !EOF("cursor_4c_ChequesM")
3336:                 IF cursor_4c_ChequesM.marca
3337:                     loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
3338:                         FormatarNumeroSQL(THIS.this_oBusinessObject.this_nNumLotes) + ;
3339:                         " AND bancos = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.bancos)) + ;
3340:                         " AND agencias = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.agencias)) + ;
3341:                         " AND ncontas = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncontas)) + ;
3342:                         " AND ncheques = " + EscaparSQL(ALLTRIM(cursor_4c_ChequesM.ncheques))
3343:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
3344:                     IF loc_nResult >= 0
3345:                         loc_nExcluidos = loc_nExcluidos + 1
3346:                     ENDIF
3347:                 ENDIF
3348:                 SKIP IN cursor_4c_ChequesM
3349:             ENDDO
3350: 
3351:             IF loc_nExcluidos > 0
3352:                 MsgInfo(TRANSFORM(loc_nExcluidos) + " cheque(s) exclu" + CHR(237) + "do(s).", "")
3353:                 THIS.CarregarGrade()
3354:             ENDIF
3355:         CATCH TO loc_oErro
3356:             MsgErro(loc_oErro.Message, "Formlch.BtnCmdExcChequeClick")
3357:         ENDTRY
3358:     ENDPROC
3359: 
3360:     *--------------------------------------------------------------------------
3361:     * BtnCommIniClick - stub: acionar leitora de cheques
3362:     *--------------------------------------------------------------------------
3363:     PROCEDURE BtnCommIniClick()
3364:         MsgInfo("Leitora de cheques n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "")
3365:     ENDPROC
3366: 
3367:     *--------------------------------------------------------------------------
3368:     * BtnCommFimClick - stub: encerrar leitora de cheques
3369:     *--------------------------------------------------------------------------
3370:     PROCEDURE BtnCommFimClick()
3371:         MsgInfo("Leitora de cheques n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "")
3372:     ENDPROC
3373: 
3374:     *--------------------------------------------------------------------------
3375:     * FormParaBO - transfere dados dos campos para as propriedades do BO
3376:     *--------------------------------------------------------------------------
3377:     PROCEDURE FormParaBO()
3378:         LOCAL loc_oPg2
3379:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3380: 
3381:         WITH THIS.this_oBusinessObject
3382:             *-- Campos principais
3383:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3384:                 .this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
3385:             ENDIF
3386:             IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3387:                 .this_dDtEnts = loc_oPg2.txt_4c_Data.Value
3388:             ENDIF
3389: 
3390:             *-- Infos financeiras
3391:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3392:                 .this_cMoeds = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
3393:             ENDIF
3394:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
3395:                 .this_nCotas = loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value
3396:             ENDIF
3397: 
3398:             *-- Origem
3399:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
3400:                 .this_cGruOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value)
3401:             ENDIF
3402:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"
3403:                 .this_cConOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Value)
3404:             ENDIF
3405:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig) = "O"
3406:                 .this_cDGruOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_DGruOrig.Value)
3407:             ENDIF
3408:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig) = "O"
3409:                 .this_cDConOrig = ALLTRIM(loc_oPg2.cnt_4c_Origem.txt_4c_DConOrig.Value)
3410:             ENDIF
3411: 
3412:             *-- Despesa
3413:             IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"
3414:                 .this_cGruEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Value)
3415:             ENDIF
3416:             IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"
3417:                 .this_cConEmts = ALLTRIM(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Value)

*-- Linhas 3504 a 3547:
3504:     *--------------------------------------------------------------------------
3505:     * BOParaForm - transfere dados do BO para os campos do formulario
3506:     *--------------------------------------------------------------------------
3507:     PROCEDURE BOParaForm()
3508:         LOCAL loc_oPg2
3509:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3510: 
3511:         WITH THIS.this_oBusinessObject
3512:             *-- Campos principais (readonly)
3513:             IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"
3514:                 loc_oPg2.txt_4c_Lote.Value = .this_nNumLotes
3515:             ENDIF
3516:             IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"
3517:                 loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(.this_cUsuar)
3518:             ENDIF
3519:             IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3520:                 loc_oPg2.txt_4c_Data.Value = .this_dDtEnts
3521:             ENDIF
3522:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3523:                 loc_oPg2.txt_4c_Oper.Value = ALLTRIM(.this_cCodigos)
3524:             ENDIF
3525: 
3526:             *-- Infos financeiras
3527:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"
3528:                 loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value = .this_nQtdeCheqs
3529:             ENDIF
3530:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3531:                 loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ALLTRIM(.this_cMoeds)
3532:             ENDIF
3533:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
3534:                 loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = .this_nCotas
3535:             ENDIF
3536:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"
3537:                 loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value = .this_nValTots
3538:             ENDIF
3539:             IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O"
3540:                 loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = .this_nValConvs
3541:             ENDIF
3542: 
3543:             *-- Origem
3544:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
3545:                 loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value = ALLTRIM(.this_cGruOrig)
3546:             ENDIF
3547:             IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"

*-- Linhas 3673 a 3716:
3673:     *--------------------------------------------------------------------------
3674:     * LimparCampos - limpa todos os campos de edicao do Page2
3675:     *--------------------------------------------------------------------------
3676:     PROCEDURE LimparCampos()
3677:         LOCAL loc_oPg2
3678:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3679: 
3680:         *-- Linha principal
3681:         IF VARTYPE(loc_oPg2.txt_4c_Lote) = "O"
3682:             loc_oPg2.txt_4c_Lote.Value  = 0
3683:         ENDIF
3684:         IF VARTYPE(loc_oPg2.txt_4c_Usuar) = "O"
3685:             loc_oPg2.txt_4c_Usuar.Value = ALLTRIM(gc_4c_UsuarioLogado)
3686:         ENDIF
3687:         IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3688:             loc_oPg2.txt_4c_Data.Value  = DATE()
3689:         ENDIF
3690:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3691:             loc_oPg2.txt_4c_Oper.Value  = ""
3692:         ENDIF
3693:         IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"
3694:             loc_oPg2.opt_4c_SNA.Value   = 1
3695:         ENDIF
3696: 
3697:         *-- Infos
3698:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Qtde) = "O"
3699:             loc_oPg2.cnt_4c_Infos.txt_4c_Qtde.Value    = 0
3700:         ENDIF
3701:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3702:             loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value   = ""
3703:         ENDIF
3704:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
3705:             loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Value = 0
3706:         ENDIF
3707:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Valor) = "O"
3708:             loc_oPg2.cnt_4c_Infos.txt_4c_Valor.Value   = 0
3709:         ENDIF
3710:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_ValConv) = "O"
3711:             loc_oPg2.cnt_4c_Infos.txt_4c_ValConv.Value = 0
3712:         ENDIF
3713: 
3714:         *-- Origem
3715:         IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
3716:             loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Value   = ""

*-- Linhas 3860 a 3903:
3860:     *--------------------------------------------------------------------------
3861:     * HabilitarCampos - habilita/desabilita campos conforme modo
3862:     *--------------------------------------------------------------------------
3863:     PROCEDURE HabilitarCampos(par_lHabilitar)
3864:         LOCAL loc_oPg2, loc_lEdicao
3865:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3866:         loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")
3867: 
3868:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
3869:             loc_oPg2.txt_4c_Oper.Enabled         = loc_lEdicao
3870:         ENDIF
3871:         IF VARTYPE(loc_oPg2.txt_4c_Data) = "O"
3872:             loc_oPg2.txt_4c_Data.Enabled          = loc_lEdicao
3873:         ENDIF
3874:         IF VARTYPE(loc_oPg2.opt_4c_SNA) = "O"
3875:             loc_oPg2.opt_4c_SNA.Enabled           = loc_lEdicao
3876:         ENDIF
3877: 
3878:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
3879:             loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Enabled    = loc_lEdicao
3880:         ENDIF
3881:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao) = "O"
3882:             loc_oPg2.cnt_4c_Infos.txt_4c_Cotacao.Enabled  = loc_lEdicao
3883:         ENDIF
3884: 
3885:         IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig) = "O"
3886:             loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig.Enabled = loc_lEdicao
3887:         ENDIF
3888:         IF VARTYPE(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig) = "O"
3889:             loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig.Enabled = loc_lEdicao
3890:         ENDIF
3891:         IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts) = "O"
3892:             loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts.Enabled = loc_lEdicao
3893:         ENDIF
3894:         IF VARTYPE(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts) = "O"
3895:             loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts.Enabled = loc_lEdicao
3896:         ENDIF
3897:         IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo) = "O"
3898:             loc_oPg2.cnt_4c_Destino.txt_4c_Grupo.Enabled  = loc_lEdicao
3899:         ENDIF
3900:         IF VARTYPE(loc_oPg2.cnt_4c_Destino.txt_4c_Conta) = "O"
3901:             loc_oPg2.cnt_4c_Destino.txt_4c_Conta.Enabled  = loc_lEdicao
3902:         ENDIF
3903:         IF VARTYPE(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs) = "O"

*-- Linhas 3965 a 4951:
3965:     *--------------------------------------------------------------------------
3966:     * AjustarBotoesPorModo - ajusta visibilidade/estado dos botoes
3967:     *--------------------------------------------------------------------------
3968:     PROCEDURE AjustarBotoesPorModo()
3969:         LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2
3970:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3971:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3972:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3973: 
3974:         IF VARTYPE(loc_oBotoes) = "O"
3975:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
3976:                 loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
3977:             ENDIF
3978:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
3979:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
3980:             ENDIF
3981:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
3982:                 loc_oBotoes.cmd_4c_Alterar.Enabled    = .T.
3983:             ENDIF
3984:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
3985:                 loc_oBotoes.cmd_4c_Excluir.Enabled    = .T.
3986:             ENDIF
3987:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
3988:                 loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
3989:             ENDIF
3990:         ENDIF
3991: 
3992:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
3993:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
3994:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
3995:             ENDIF
3996:         ENDIF
3997:     ENDPROC
3998: 
3999:     *--------------------------------------------------------------------------
4000:     * Validadores de campos - LostFocus handlers
4001:     * Padrao: buscar descricao no SQL e popular o campo de desc
4002:     *--------------------------------------------------------------------------
4003:     PROCEDURE ValidarOper(par_nKeyCode, par_nShiftAltCtrl)
4004:         LOCAL loc_oPg2, loc_cOper, loc_nRes
4005:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4006:         IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O"
4007:             RETURN
4008:         ENDIF
4009:         loc_cOper = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
4010:         IF EMPTY(loc_cOper)
4011:             RETURN
4012:         ENDIF
4013: 
4014:         TRY
4015:             loc_nRes = SQLEXEC(gnConnHandle, ;
4016:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cOper), ;
4017:                 "cursor_4c_ValidOper")
4018:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidOper") = 0
4019:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cOper, "")
4020:                 loc_oPg2.txt_4c_Oper.Value = ""
4021:             ENDIF
4022:         CATCH TO loc_oErro
4023:             MsgErro(loc_oErro.Message, "Formlch.ValidarOper")
4024:         ENDTRY
4025:         IF USED("cursor_4c_ValidOper")
4026:             USE IN cursor_4c_ValidOper
4027:         ENDIF
4028:     ENDPROC
4029: 
4030:     PROCEDURE ValidarMoeda(par_nKeyCode, par_nShiftAltCtrl)
4031:         LOCAL loc_oPg2, loc_cMoeda, loc_nRes
4032:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4033:         IF VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) != "O"
4034:             RETURN
4035:         ENDIF
4036:         loc_cMoeda = ALLTRIM(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value)
4037:         IF EMPTY(loc_cMoeda)
4038:             RETURN
4039:         ENDIF
4040: 
4041:         TRY
4042:             loc_nRes = SQLEXEC(gnConnHandle, ;
4043:                 "SELECT codigos FROM SigCdMoe WHERE codigos = " + EscaparSQL(loc_cMoeda), ;
4044:                 "cursor_4c_ValidMoe")
4045:             IF loc_nRes < 0 OR RECCOUNT("cursor_4c_ValidMoe") = 0
4046:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cMoeda, "")
4047:                 loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ""
4048:             ENDIF
4049:         CATCH TO loc_oErro
4050:             MsgErro(loc_oErro.Message, "Formlch.ValidarMoeda")
4051:         ENDTRY
4052:         IF USED("cursor_4c_ValidMoe")
4053:             USE IN cursor_4c_ValidMoe
4054:         ENDIF
4055:     ENDPROC
4056: 
4057:     PROCEDURE ValidarGrupoOrig(par_nKeyCode, par_nShiftAltCtrl)
4058:         THIS.BuscarDescGrupo("cnt_4c_Origem", "txt_4c_GruOrig", "txt_4c_DGruOrig")
4059:     ENDPROC
4060: 
4061:     PROCEDURE ValidarContaOrig(par_nKeyCode, par_nShiftAltCtrl)
4062:         THIS.BuscarDescConta("cnt_4c_Origem", "txt_4c_ConOrig", "txt_4c_DConOrig")
4063:     ENDPROC
4064: 
4065:     PROCEDURE ValidarGrupoEmts(par_nKeyCode, par_nShiftAltCtrl)
4066:         THIS.BuscarDescGrupo("cnt_4c_Despesa", "txt_4c_GruEmts", "txt_4c_DGruEmts")
4067:     ENDPROC
4068: 
4069:     PROCEDURE ValidarContaEmts(par_nKeyCode, par_nShiftAltCtrl)
4070:         THIS.BuscarDescConta("cnt_4c_Despesa", "txt_4c_ConEmts", "txt_4c_DConEmts")
4071:     ENDPROC
4072: 
4073:     PROCEDURE ValidarGrupoDest(par_nKeyCode, par_nShiftAltCtrl)
4074:         THIS.BuscarDescGrupo("cnt_4c_Destino", "txt_4c_Grupo", "txt_4c_DGrupo")
4075:     ENDPROC
4076: 
4077:     PROCEDURE ValidarContaDest(par_nKeyCode, par_nShiftAltCtrl)
4078:         THIS.BuscarDescConta("cnt_4c_Destino", "txt_4c_Conta", "txt_4c_DConta")
4079:     ENDPROC
4080: 
4081:     PROCEDURE ValidarGrupoCC(par_nKeyCode, par_nShiftAltCtrl)
4082:         THIS.BuscarDescGrupo("cnt_4c_CCusto", "txt_4c_GrupoCcs", "txt_4c_DGrupoCcs")
4083:     ENDPROC
4084: 
4085:     PROCEDURE ValidarContaCC(par_nKeyCode, par_nShiftAltCtrl)
4086:         THIS.BuscarDescConta("cnt_4c_CCusto", "txt_4c_ContaCcs", "txt_4c_DContaCcs")
4087:     ENDPROC
4088: 
4089:     PROCEDURE ValidarGrupoCart(par_nKeyCode, par_nShiftAltCtrl)
4090:         THIS.BuscarDescGrupo("cnt_4c_Carteira", "txt_4c_GruCart", "txt_4c_DGruCart")
4091:     ENDPROC
4092: 
4093:     PROCEDURE ValidarContaCart(par_nKeyCode, par_nShiftAltCtrl)
4094:         THIS.BuscarDescConta("cnt_4c_Carteira", "txt_4c_ConCart", "txt_4c_DConCart")
4095:     ENDPROC
4096: 
4097:     PROCEDURE ValidarGrupoEmiss(par_nKeyCode, par_nShiftAltCtrl)
4098:         THIS.BuscarDescGrupo("cnt_4c_Emissor", "txt_4c_GruEmiss", "txt_4c_DGruEmiss")
4099:     ENDPROC
4100: 
4101:     PROCEDURE ValidarContaEmiss(par_nKeyCode, par_nShiftAltCtrl)
4102:         THIS.BuscarDescConta("cnt_4c_Emissor", "txt_4c_ConEmiss", "txt_4c_DConEmiss")
4103:     ENDPROC
4104: 
4105:     PROCEDURE ValidarGrupoRes(par_nKeyCode, par_nShiftAltCtrl)
4106:         THIS.BuscarDescGrupo("cnt_4c_Responsavel", "txt_4c_GruRes", "")
4107:     ENDPROC
4108: 
4109:     PROCEDURE ValidarContaRes(par_nKeyCode, par_nShiftAltCtrl)
4110:         THIS.BuscarDescConta("cnt_4c_Responsavel", "txt_4c_ConRes", "txt_4c_DConRes")
4111:     ENDPROC
4112: 
4113:     PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
4114:         LOCAL loc_oPg2, loc_cEmps, loc_nRes
4115:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4116:         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) != "O"
4117:             RETURN
4118:         ENDIF
4119:         loc_cEmps = ALLTRIM(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value)
4120:         IF EMPTY(loc_cEmps)
4121:             RETURN
4122:         ENDIF
4123: 
4124:         TRY
4125:             loc_nRes = SQLEXEC(gnConnHandle, ;
4126:                 "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + EscaparSQL(loc_cEmps), ;
4127:                 "cursor_4c_ValidEmp")
4128:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidEmp") > 0
4129:                 SELECT cursor_4c_ValidEmp
4130:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4131:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_ValidEmp.razas)
4132:                 ENDIF
4133:                 THIS.this_oBusinessObject.this_cDEmps = ALLTRIM(cursor_4c_ValidEmp.razas)
4134:             ELSE
4135:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, "")
4136:                 loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ""
4137:                 IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4138:                     loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ""
4139:                 ENDIF
4140:             ENDIF
4141:         CATCH TO loc_oErro
4142:             MsgErro(loc_oErro.Message, "Formlch.ValidarEmpresa")
4143:         ENDTRY
4144:         IF USED("cursor_4c_ValidEmp")
4145:             USE IN cursor_4c_ValidEmp
4146:         ENDIF
4147:     ENDPROC
4148: 
4149:     PROCEDURE ValidarContaIclis(par_nKeyCode, par_nShiftAltCtrl)
4150:         LOCAL loc_oPg2, loc_cConta, loc_nRes
4151:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4152:         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) != "O"
4153:             RETURN
4154:         ENDIF
4155:         loc_cConta = ALLTRIM(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value)
4156:         IF EMPTY(loc_cConta)
4157:             RETURN
4158:         ENDIF
4159: 
4160:         TRY
4161:             loc_nRes = SQLEXEC(gnConnHandle, ;
4162:                 "SELECT iclis, cpfs, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4163:                 "cursor_4c_ValidCli")
4164:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ValidCli") > 0
4165:                 SELECT cursor_4c_ValidCli
4166:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4167:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ALLTRIM(cursor_4c_ValidCli.cpfs)
4168:                 ENDIF
4169:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4170:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ALLTRIM(cursor_4c_ValidCli.razaos)
4171:                 ENDIF
4172:             ELSE
4173:                 MsgAviso("Cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4174:                 loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ""
4175:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4176:                     loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ""
4177:                 ENDIF
4178:                 IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4179:                     loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ""
4180:                 ENDIF
4181:             ENDIF
4182:         CATCH TO loc_oErro
4183:             MsgErro(loc_oErro.Message, "Formlch.ValidarContaIclis")
4184:         ENDTRY
4185:         IF USED("cursor_4c_ValidCli")
4186:             USE IN cursor_4c_ValidCli
4187:         ENDIF
4188:     ENDPROC
4189: 
4190:     *--------------------------------------------------------------------------
4191:     * BuscarDescGrupo - helper para buscar descricao de grupo contabil (SigCdGcr)
4192:     *--------------------------------------------------------------------------
4193:     PROTECTED PROCEDURE BuscarDescGrupo(par_cCnt, par_cTxtGru, par_cTxtDesc)
4194:         LOCAL loc_oPg2, loc_oCnt, loc_cGrupo, loc_nRes, loc_cDesc
4195:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4196: 
4197:         IF !PEMPTY(loc_oPg2) AND VARTYPE(loc_oPg2) = "O"
4198:             loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
4199:         ELSE
4200:             RETURN
4201:         ENDIF
4202: 
4203:         IF VARTYPE(loc_oCnt) != "O"
4204:             RETURN
4205:         ENDIF
4206: 
4207:         IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtGru + ")") != "O"
4208:             RETURN
4209:         ENDIF
4210:         loc_cGrupo = ALLTRIM(EVALUATE("loc_oCnt." + par_cTxtGru + ".Value"))
4211: 
4212:         IF EMPTY(par_cTxtDesc)
4213:             IF EMPTY(loc_cGrupo)
4214:                 RETURN
4215:             ENDIF
4216:         ENDIF
4217: 
4218:         IF EMPTY(loc_cGrupo)
4219:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4220:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")
4221:             ENDIF
4222:             RETURN
4223:         ENDIF
4224: 
4225:         TRY
4226:             loc_nRes = SQLEXEC(gnConnHandle, ;
4227:                 "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
4228:                 "cursor_4c_DescGru")
4229:             loc_cDesc = ""
4230:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGru") > 0
4231:                 SELECT cursor_4c_DescGru
4232:                 loc_cDesc = ALLTRIM(cursor_4c_DescGru.descrs)
4233:             ELSE
4234:                 MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cGrupo, "")
4235:                 EVALUATE("loc_oCnt." + par_cTxtGru + ".Value = ''")
4236:             ENDIF
4237:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4238:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4239:             ENDIF
4240:         CATCH TO loc_oErro
4241:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescGrupo")
4242:         ENDTRY
4243:         IF USED("cursor_4c_DescGru")
4244:             USE IN cursor_4c_DescGru
4245:         ENDIF
4246:     ENDPROC
4247: 
4248:     *--------------------------------------------------------------------------
4249:     * BuscarDescConta - helper para buscar descricao de conta (SigCdCli.razaos)
4250:     *--------------------------------------------------------------------------
4251:     PROTECTED PROCEDURE BuscarDescConta(par_cCnt, par_cTxtCon, par_cTxtDesc)
4252:         LOCAL loc_oPg2, loc_oCnt, loc_cConta, loc_nRes, loc_cDesc
4253:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4254: 
4255:         IF VARTYPE(loc_oPg2) = "O"
4256:             loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
4257:         ELSE
4258:             RETURN
4259:         ENDIF
4260: 
4261:         IF VARTYPE(loc_oCnt) != "O"
4262:             RETURN
4263:         ENDIF
4264:         IF EVALUATE("VARTYPE(loc_oCnt." + par_cTxtCon + ")") != "O"
4265:             RETURN
4266:         ENDIF
4267:         loc_cConta = ALLTRIM(EVALUATE("loc_oCnt." + par_cTxtCon + ".Value"))
4268: 
4269:         IF EMPTY(loc_cConta)
4270:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4271:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = ''")
4272:             ENDIF
4273:             RETURN
4274:         ENDIF
4275: 
4276:         TRY
4277:             loc_nRes = SQLEXEC(gnConnHandle, ;
4278:                 "SELECT iclis, razaos FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta), ;
4279:                 "cursor_4c_DescCon")
4280:             loc_cDesc = ""
4281:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCon") > 0
4282:                 SELECT cursor_4c_DescCon
4283:                 loc_cDesc = ALLTRIM(cursor_4c_DescCon.razaos)
4284:             ELSE
4285:                 MsgAviso("Conta/cliente n" + CHR(227) + "o encontrado: " + loc_cConta, "")
4286:                 EVALUATE("loc_oCnt." + par_cTxtCon + ".Value = ''")
4287:             ENDIF
4288:             IF !EMPTY(par_cTxtDesc) AND EVALUATE("VARTYPE(loc_oCnt." + par_cTxtDesc + ")") = "O"
4289:                 EVALUATE("loc_oCnt." + par_cTxtDesc + ".Value = loc_cDesc")
4290:             ENDIF
4291:         CATCH TO loc_oErro
4292:             MsgErro(loc_oErro.Message, "Formlch.BuscarDescConta")
4293:         ENDTRY
4294:         IF USED("cursor_4c_DescCon")
4295:             USE IN cursor_4c_DescCon
4296:         ENDIF
4297:     ENDPROC
4298: 
4299:     *--------------------------------------------------------------------------
4300:     * TornarControlesVisiveis - recursivo: garante Visible=.T. em todos os filhos
4301:     *--------------------------------------------------------------------------
4302:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4303:         LOCAL loc_i, loc_oCtrl
4304: 
4305:         IF VARTYPE(par_oContainer) != "O"
4306:             RETURN
4307:         ENDIF
4308: 
4309:         FOR loc_i = 1 TO par_oContainer.ControlCount
4310:             loc_oCtrl = par_oContainer.Controls(loc_i)
4311:             IF VARTYPE(loc_oCtrl) = "O"
4312:                 IF PEMPTY(loc_oCtrl) = .F.
4313:                     loc_oCtrl.Visible = .T.
4314:                     IF loc_oCtrl.ControlCount > 0
4315:                         THIS.TornarControlesVisiveis(loc_oCtrl)
4316:                     ENDIF
4317:                 ENDIF
4318:             ENDIF
4319:         ENDFOR
4320:     ENDPROC
4321: 
4322:     *--------------------------------------------------------------------------
4323:     * FormatarGridLista - aplica formatacao padrao no grid da lista
4324:     *--------------------------------------------------------------------------
4325:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
4326:         IF VARTYPE(par_oGrid) != "O"
4327:             RETURN
4328:         ENDIF
4329:         WITH par_oGrid
4330:             .FontName = "Verdana"
4331:             .FontSize = 8
4332:         ENDWITH
4333:     ENDPROC
4334: 
4335:     *--------------------------------------------------------------------------
4336:     * Destroy - libera recursos
4337:     *--------------------------------------------------------------------------
4338:     PROCEDURE Destroy()
4339:         LOCAL loc_oErro
4340: 
4341:         TRY
4342:             IF USED("cursor_4c_Dados")
4343:                 USE IN cursor_4c_Dados
4344:             ENDIF
4345:             IF USED("cursor_4c_Cheques")
4346:                 USE IN cursor_4c_Cheques
4347:             ENDIF
4348:             IF USED("cursor_4c_ChequesM")
4349:                 USE IN cursor_4c_ChequesM
4350:             ENDIF
4351:             IF USED("cursor_4c_BuscaLch")
4352:                 USE IN cursor_4c_BuscaLch
4353:             ENDIF
4354: 
4355:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
4356:                 THIS.this_oBusinessObject = .NULL.
4357:             ENDIF
4358:         CATCH TO loc_oErro
4359:             MsgErro(loc_oErro.Message, "Formlch.Destroy")
4360:         ENDTRY
4361: 
4362:         DODEFAULT()
4363:     ENDPROC
4364: 
4365:     *--------------------------------------------------------------------------
4366:     * RegistrarKeyPressLookups - registra handlers F4/F5 para campos lookup
4367:     *--------------------------------------------------------------------------
4368:     PROTECTED PROCEDURE RegistrarKeyPressLookups()
4369:         LOCAL loc_oPg2
4370:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4371: 
4372:         BINDEVENT(loc_oPg2.txt_4c_Oper,                      "KeyPress", THIS, "KeyPressOper")
4373:         BINDEVENT(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda,        "KeyPress", THIS, "KeyPressMoeda")
4374:         BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_GruOrig,     "KeyPress", THIS, "KeyPressGruOrig")
4375:         BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_ConOrig,     "KeyPress", THIS, "KeyPressConOrig")
4376:         BINDEVENT(loc_oPg2.cnt_4c_Origem.txt_4c_CpfOrig,     "KeyPress", THIS, "KeyPressCpfOrig")
4377:         BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_GruEmts,    "KeyPress", THIS, "KeyPressGruEmts")
4378:         BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_ConEmts,    "KeyPress", THIS, "KeyPressConEmts")
4379:         BINDEVENT(loc_oPg2.cnt_4c_Despesa.txt_4c_CpfEmts,    "KeyPress", THIS, "KeyPressCpfEmts")
4380:         BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_Grupo,      "KeyPress", THIS, "KeyPressGruDest")
4381:         BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_Conta,      "KeyPress", THIS, "KeyPressConDest")
4382:         BINDEVENT(loc_oPg2.cnt_4c_Destino.txt_4c_CpfDest,    "KeyPress", THIS, "KeyPressCpfDest")
4383:         BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_GrupoCcs,    "KeyPress", THIS, "KeyPressGruCC")
4384:         BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_ContaCcs,    "KeyPress", THIS, "KeyPressConCC")
4385:         BINDEVENT(loc_oPg2.cnt_4c_CCusto.txt_4c_CpfCCs,      "KeyPress", THIS, "KeyPressCpfCC")
4386:         BINDEVENT(loc_oPg2.cnt_4c_Carteira.txt_4c_GruCart,   "KeyPress", THIS, "KeyPressGruCart")
4387:         BINDEVENT(loc_oPg2.cnt_4c_Carteira.txt_4c_ConCart,   "KeyPress", THIS, "KeyPressConCart")
4388:         BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_GruEmiss,   "KeyPress", THIS, "KeyPressGruEmiss")
4389:         BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_ConEmiss,   "KeyPress", THIS, "KeyPressConEmiss")
4390:         BINDEVENT(loc_oPg2.cnt_4c_Emissor.txt_4c_CpfEmiss,   "KeyPress", THIS, "KeyPressCpfEmiss")
4391:         BINDEVENT(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe,   "KeyPress", THIS, "KeyPressAlinea")
4392:         BINDEVENT(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps,       "KeyPress", THIS, "KeyPressEmps")
4393:         BINDEVENT(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis,   "KeyPress", THIS, "KeyPressContaIclis")
4394:         BINDEVENT(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp,     "KeyPress", THIS, "KeyPressClasemp")
4395:         BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_GruRes, "KeyPress", THIS, "KeyPressGruRes")
4396:         BINDEVENT(loc_oPg2.cnt_4c_Responsavel.txt_4c_ConRes, "KeyPress", THIS, "KeyPressConRes")
4397:     ENDPROC
4398: 
4399:     *--------------------------------------------------------------------------
4400:     * KeyPress handlers - F4=115 / F5=116 abre lookup
4401:     *--------------------------------------------------------------------------
4402:     PROCEDURE KeyPressOper(par_nKeyCode, par_nShiftAltCtrl)
4403:         IF INLIST(par_nKeyCode, 115, 116)
4404:             THIS.AbrirLookupOper()
4405:         ENDIF
4406:     ENDPROC
4407: 
4408:     PROCEDURE KeyPressMoeda(par_nKeyCode, par_nShiftAltCtrl)
4409:         IF INLIST(par_nKeyCode, 115, 116)
4410:             THIS.AbrirLookupMoeda()
4411:         ENDIF
4412:     ENDPROC
4413: 
4414:     PROCEDURE KeyPressGruOrig(par_nKeyCode, par_nShiftAltCtrl)
4415:         IF INLIST(par_nKeyCode, 115, 116)
4416:             THIS.AbrirLookupGrupo("cnt_4c_Origem",  "txt_4c_GruOrig", "txt_4c_DGruOrig")
4417:         ENDIF
4418:     ENDPROC
4419: 
4420:     PROCEDURE KeyPressConOrig(par_nKeyCode, par_nShiftAltCtrl)
4421:         IF INLIST(par_nKeyCode, 115, 116)
4422:             THIS.AbrirLookupConta("cnt_4c_Origem",  "txt_4c_ConOrig", "txt_4c_DConOrig")
4423:         ENDIF
4424:     ENDPROC
4425: 
4426:     PROCEDURE KeyPressCpfOrig(par_nKeyCode, par_nShiftAltCtrl)
4427:         IF INLIST(par_nKeyCode, 115, 116)
4428:             THIS.AbrirLookupCpf("cnt_4c_Origem",   "txt_4c_CpfOrig")
4429:         ENDIF
4430:     ENDPROC
4431: 
4432:     PROCEDURE KeyPressGruEmts(par_nKeyCode, par_nShiftAltCtrl)
4433:         IF INLIST(par_nKeyCode, 115, 116)
4434:             THIS.AbrirLookupGrupo("cnt_4c_Despesa", "txt_4c_GruEmts", "txt_4c_DGruEmts")
4435:         ENDIF
4436:     ENDPROC
4437: 
4438:     PROCEDURE KeyPressConEmts(par_nKeyCode, par_nShiftAltCtrl)
4439:         IF INLIST(par_nKeyCode, 115, 116)
4440:             THIS.AbrirLookupConta("cnt_4c_Despesa", "txt_4c_ConEmts", "txt_4c_DConEmts")
4441:         ENDIF
4442:     ENDPROC
4443: 
4444:     PROCEDURE KeyPressCpfEmts(par_nKeyCode, par_nShiftAltCtrl)
4445:         IF INLIST(par_nKeyCode, 115, 116)
4446:             THIS.AbrirLookupCpf("cnt_4c_Despesa",  "txt_4c_CpfEmts")
4447:         ENDIF
4448:     ENDPROC
4449: 
4450:     PROCEDURE KeyPressGruDest(par_nKeyCode, par_nShiftAltCtrl)
4451:         IF INLIST(par_nKeyCode, 115, 116)
4452:             THIS.AbrirLookupGrupo("cnt_4c_Destino", "txt_4c_Grupo",   "txt_4c_DGrupo")
4453:         ENDIF
4454:     ENDPROC
4455: 
4456:     PROCEDURE KeyPressConDest(par_nKeyCode, par_nShiftAltCtrl)
4457:         IF INLIST(par_nKeyCode, 115, 116)
4458:             THIS.AbrirLookupConta("cnt_4c_Destino", "txt_4c_Conta",   "txt_4c_DConta")
4459:         ENDIF
4460:     ENDPROC
4461: 
4462:     PROCEDURE KeyPressCpfDest(par_nKeyCode, par_nShiftAltCtrl)
4463:         IF INLIST(par_nKeyCode, 115, 116)
4464:             THIS.AbrirLookupCpf("cnt_4c_Destino",  "txt_4c_CpfDest")
4465:         ENDIF
4466:     ENDPROC
4467: 
4468:     PROCEDURE KeyPressGruCC(par_nKeyCode, par_nShiftAltCtrl)
4469:         IF INLIST(par_nKeyCode, 115, 116)
4470:             THIS.AbrirLookupGrupo("cnt_4c_CCusto",  "txt_4c_GrupoCcs","txt_4c_DGrupoCcs")
4471:         ENDIF
4472:     ENDPROC
4473: 
4474:     PROCEDURE KeyPressConCC(par_nKeyCode, par_nShiftAltCtrl)
4475:         IF INLIST(par_nKeyCode, 115, 116)
4476:             THIS.AbrirLookupConta("cnt_4c_CCusto",  "txt_4c_ContaCcs","txt_4c_DContaCcs")
4477:         ENDIF
4478:     ENDPROC
4479: 
4480:     PROCEDURE KeyPressCpfCC(par_nKeyCode, par_nShiftAltCtrl)
4481:         IF INLIST(par_nKeyCode, 115, 116)
4482:             THIS.AbrirLookupCpf("cnt_4c_CCusto",   "txt_4c_CpfCCs")
4483:         ENDIF
4484:     ENDPROC
4485: 
4486:     PROCEDURE KeyPressGruCart(par_nKeyCode, par_nShiftAltCtrl)
4487:         IF INLIST(par_nKeyCode, 115, 116)
4488:             THIS.AbrirLookupGrupo("cnt_4c_Carteira","txt_4c_GruCart", "txt_4c_DGruCart")
4489:         ENDIF
4490:     ENDPROC
4491: 
4492:     PROCEDURE KeyPressConCart(par_nKeyCode, par_nShiftAltCtrl)
4493:         IF INLIST(par_nKeyCode, 115, 116)
4494:             THIS.AbrirLookupConta("cnt_4c_Carteira","txt_4c_ConCart", "txt_4c_DConCart")
4495:         ENDIF
4496:     ENDPROC
4497: 
4498:     PROCEDURE KeyPressGruEmiss(par_nKeyCode, par_nShiftAltCtrl)
4499:         IF INLIST(par_nKeyCode, 115, 116)
4500:             THIS.AbrirLookupGrupo("cnt_4c_Emissor", "txt_4c_GruEmiss","txt_4c_DGruEmiss")
4501:         ENDIF
4502:     ENDPROC
4503: 
4504:     PROCEDURE KeyPressConEmiss(par_nKeyCode, par_nShiftAltCtrl)
4505:         IF INLIST(par_nKeyCode, 115, 116)
4506:             THIS.AbrirLookupConta("cnt_4c_Emissor", "txt_4c_ConEmiss","txt_4c_DConEmiss")
4507:         ENDIF
4508:     ENDPROC
4509: 
4510:     PROCEDURE KeyPressCpfEmiss(par_nKeyCode, par_nShiftAltCtrl)
4511:         IF INLIST(par_nKeyCode, 115, 116)
4512:             THIS.AbrirLookupCpf("cnt_4c_Emissor",  "txt_4c_CpfEmiss")
4513:         ENDIF
4514:     ENDPROC
4515: 
4516:     PROCEDURE KeyPressAlinea(par_nKeyCode, par_nShiftAltCtrl)
4517:         IF INLIST(par_nKeyCode, 115, 116)
4518:             THIS.AbrirLookupAlinea()
4519:         ENDIF
4520:     ENDPROC
4521: 
4522:     PROCEDURE KeyPressEmps(par_nKeyCode, par_nShiftAltCtrl)
4523:         IF INLIST(par_nKeyCode, 115, 116)
4524:             THIS.AbrirLookupEmpresa()
4525:         ENDIF
4526:     ENDPROC
4527: 
4528:     PROCEDURE KeyPressContaIclis(par_nKeyCode, par_nShiftAltCtrl)
4529:         IF INLIST(par_nKeyCode, 115, 116)
4530:             THIS.AbrirLookupContaIclis()
4531:         ENDIF
4532:     ENDPROC
4533: 
4534:     PROCEDURE KeyPressClasemp(par_nKeyCode, par_nShiftAltCtrl)
4535:         IF INLIST(par_nKeyCode, 115, 116)
4536:             THIS.AbrirLookupClasemp()
4537:         ENDIF
4538:     ENDPROC
4539: 
4540:     PROCEDURE KeyPressGruRes(par_nKeyCode, par_nShiftAltCtrl)
4541:         IF INLIST(par_nKeyCode, 115, 116)
4542:             THIS.AbrirLookupGrupo("cnt_4c_Responsavel","txt_4c_GruRes","")
4543:         ENDIF
4544:     ENDPROC
4545: 
4546:     PROCEDURE KeyPressConRes(par_nKeyCode, par_nShiftAltCtrl)
4547:         IF INLIST(par_nKeyCode, 115, 116)
4548:             THIS.AbrirLookupConta("cnt_4c_Responsavel","txt_4c_ConRes","txt_4c_DConRes")
4549:         ENDIF
4550:     ENDPROC
4551: 
4552:     *--------------------------------------------------------------------------
4553:     * AbrirLookupOper - lookup SigCdOpt (operacao)
4554:     *--------------------------------------------------------------------------
4555:     PROCEDURE AbrirLookupOper()
4556:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
4557:         loc_lResultado = .F.
4558:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4559: 
4560:         TRY
4561:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4562:                 "SigCdOpt", "cursor_4c_BuscaOper", "operacaos", "", ;
4563:                 "Opera" + CHR(231) + CHR(227) + "o")
4564: 
4565:             IF VARTYPE(loc_oBusca) = "O"
4566:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
4567:                 loc_oBusca.Show()
4568: 
4569:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOper")
4570:                     SELECT cursor_4c_BuscaOper
4571:                     IF !EOF("cursor_4c_BuscaOper") AND VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
4572:                         loc_oPg2.txt_4c_Oper.Value = ALLTRIM(cursor_4c_BuscaOper.operacaos)
4573:                     ENDIF
4574:                 ENDIF
4575: 
4576:                 loc_oBusca.Release()
4577:                 loc_lResultado = .T.
4578:             ENDIF
4579:         CATCH TO loc_oErro
4580:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupOper")
4581:         ENDTRY
4582: 
4583:         IF USED("cursor_4c_BuscaOper")
4584:             USE IN cursor_4c_BuscaOper
4585:         ENDIF
4586:         RETURN loc_lResultado
4587:     ENDPROC
4588: 
4589:     *--------------------------------------------------------------------------
4590:     * AbrirLookupMoeda - lookup SigCdMoe (codigos)
4591:     *--------------------------------------------------------------------------
4592:     PROCEDURE AbrirLookupMoeda()
4593:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
4594:         loc_lResultado = .F.
4595:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4596: 
4597:         TRY
4598:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4599:                 "SigCdMoe", "cursor_4c_BuscaMoe", "codigos", "", ;
4600:                 "Moeda")
4601: 
4602:             IF VARTYPE(loc_oBusca) = "O"
4603:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
4604:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
4605:                 loc_oBusca.Show()
4606: 
4607:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
4608:                     SELECT cursor_4c_BuscaMoe
4609:                     IF !EOF("cursor_4c_BuscaMoe") AND ;
4610:                        VARTYPE(loc_oPg2.cnt_4c_Infos.txt_4c_Moeda) = "O"
4611:                         loc_oPg2.cnt_4c_Infos.txt_4c_Moeda.Value = ;
4612:                             ALLTRIM(cursor_4c_BuscaMoe.codigos)
4613:                     ENDIF
4614:                 ENDIF
4615: 
4616:                 loc_oBusca.Release()
4617:                 loc_lResultado = .T.
4618:             ENDIF
4619:         CATCH TO loc_oErro
4620:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupMoeda")
4621:         ENDTRY
4622: 
4623:         IF USED("cursor_4c_BuscaMoe")
4624:             USE IN cursor_4c_BuscaMoe
4625:         ENDIF
4626:         RETURN loc_lResultado
4627:     ENDPROC
4628: 
4629:     *--------------------------------------------------------------------------
4630:     * AbrirLookupGrupo - lookup generico SigCdGcr (codigos/descrs)
4631:     *--------------------------------------------------------------------------
4632:     PROTECTED PROCEDURE AbrirLookupGrupo(par_cCnt, par_cTxtGru, par_cTxtDesc)
4633:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtGru, loc_oTxtDesc
4634:         loc_lResultado = .F.
4635:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4636: 
4637:         TRY
4638:             loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
4639:             IF VARTYPE(loc_oCnt) = "O"
4640:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4641:                     "SigCdGcr", "cursor_4c_BuscaGru", "codigos", "", ;
4642:                     "Grupo Cont" + CHR(225) + "bil")
4643: 
4644:                 IF VARTYPE(loc_oBusca) = "O"
4645:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
4646:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4647:                     loc_oBusca.Show()
4648: 
4649:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGru")
4650:                         SELECT cursor_4c_BuscaGru
4651:                         IF !EOF("cursor_4c_BuscaGru")
4652:                             loc_oTxtGru = EVALUATE("loc_oCnt." + par_cTxtGru)
4653:                             IF VARTYPE(loc_oTxtGru) = "O"
4654:                                 loc_oTxtGru.Value = ALLTRIM(cursor_4c_BuscaGru.codigos)
4655:                             ENDIF
4656:                             IF !EMPTY(par_cTxtDesc)
4657:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4658:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4659:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaGru.descrs)
4660:                                 ENDIF
4661:                             ENDIF
4662:                         ENDIF
4663:                     ENDIF
4664: 
4665:                     loc_oBusca.Release()
4666:                     loc_lResultado = .T.
4667:                 ENDIF
4668:             ENDIF
4669:         CATCH TO loc_oErro
4670:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupGrupo")
4671:         ENDTRY
4672: 
4673:         IF USED("cursor_4c_BuscaGru")
4674:             USE IN cursor_4c_BuscaGru
4675:         ENDIF
4676:         RETURN loc_lResultado
4677:     ENDPROC
4678: 
4679:     *--------------------------------------------------------------------------
4680:     * AbrirLookupConta - lookup generico SigCdCli (iclis/razaos)
4681:     *--------------------------------------------------------------------------
4682:     PROTECTED PROCEDURE AbrirLookupConta(par_cCnt, par_cTxtCon, par_cTxtDesc)
4683:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtCon, loc_oTxtDesc
4684:         loc_lResultado = .F.
4685:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4686: 
4687:         TRY
4688:             loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
4689:             IF VARTYPE(loc_oCnt) = "O"
4690:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4691:                     "SigCdCli", "cursor_4c_BuscaCon", "iclis", "", ;
4692:                     "Conta / Cliente")
4693: 
4694:                 IF VARTYPE(loc_oBusca) = "O"
4695:                     loc_oBusca.mAddColuna("iclis",  "", "Conta")
4696:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
4697:                     loc_oBusca.Show()
4698: 
4699:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCon")
4700:                         SELECT cursor_4c_BuscaCon
4701:                         IF !EOF("cursor_4c_BuscaCon")
4702:                             loc_oTxtCon = EVALUATE("loc_oCnt." + par_cTxtCon)
4703:                             IF VARTYPE(loc_oTxtCon) = "O"
4704:                                 loc_oTxtCon.Value = ALLTRIM(cursor_4c_BuscaCon.iclis)
4705:                             ENDIF
4706:                             IF !EMPTY(par_cTxtDesc)
4707:                                 loc_oTxtDesc = EVALUATE("loc_oCnt." + par_cTxtDesc)
4708:                                 IF VARTYPE(loc_oTxtDesc) = "O"
4709:                                     loc_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaCon.razaos)
4710:                                 ENDIF
4711:                             ENDIF
4712:                         ENDIF
4713:                     ENDIF
4714: 
4715:                     loc_oBusca.Release()
4716:                     loc_lResultado = .T.
4717:                 ENDIF
4718:             ENDIF
4719:         CATCH TO loc_oErro
4720:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupConta")
4721:         ENDTRY
4722: 
4723:         IF USED("cursor_4c_BuscaCon")
4724:             USE IN cursor_4c_BuscaCon
4725:         ENDIF
4726:         RETURN loc_lResultado
4727:     ENDPROC
4728: 
4729:     *--------------------------------------------------------------------------
4730:     * AbrirLookupCpf - lookup SigCdCli por CPF
4731:     *--------------------------------------------------------------------------
4732:     PROTECTED PROCEDURE AbrirLookupCpf(par_cCnt, par_cTxtCpf)
4733:         LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_lResultado, loc_oTxtCpf
4734:         loc_lResultado = .F.
4735:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4736: 
4737:         TRY
4738:             loc_oCnt = EVALUATE("loc_oPg2." + par_cCnt)
4739:             IF VARTYPE(loc_oCnt) = "O"
4740:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4741:                     "SigCdCli", "cursor_4c_BuscaCpf", "cpfs", "", ;
4742:                     "Busca por CPF / Cliente")
4743: 
4744:                 IF VARTYPE(loc_oBusca) = "O"
4745:                     loc_oBusca.mAddColuna("cpfs",   "", "CPF")
4746:                     loc_oBusca.mAddColuna("iclis",  "", "Conta")
4747:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
4748:                     loc_oBusca.Show()
4749: 
4750:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCpf")
4751:                         SELECT cursor_4c_BuscaCpf
4752:                         IF !EOF("cursor_4c_BuscaCpf")
4753:                             loc_oTxtCpf = EVALUATE("loc_oCnt." + par_cTxtCpf)
4754:                             IF VARTYPE(loc_oTxtCpf) = "O"
4755:                                 loc_oTxtCpf.Value = ALLTRIM(cursor_4c_BuscaCpf.cpfs)
4756:                             ENDIF
4757:                         ENDIF
4758:                     ENDIF
4759: 
4760:                     loc_oBusca.Release()
4761:                     loc_lResultado = .T.
4762:                 ENDIF
4763:             ENDIF
4764:         CATCH TO loc_oErro
4765:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupCpf")
4766:         ENDTRY
4767: 
4768:         IF USED("cursor_4c_BuscaCpf")
4769:             USE IN cursor_4c_BuscaCpf
4770:         ENDIF
4771:         RETURN loc_lResultado
4772:     ENDPROC
4773: 
4774:     *--------------------------------------------------------------------------
4775:     * AbrirLookupEmpresa - lookup SigCdEmp (cemps/razas)
4776:     *--------------------------------------------------------------------------
4777:     PROCEDURE AbrirLookupEmpresa()
4778:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
4779:         loc_lResultado = .F.
4780:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4781: 
4782:         TRY
4783:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4784:                 "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", "", ;
4785:                 "Empresa")
4786: 
4787:             IF VARTYPE(loc_oBusca) = "O"
4788:                 loc_oBusca.mAddColuna("cemps",  "", "C" + CHR(243) + "digo")
4789:                 loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
4790:                 loc_oBusca.Show()
4791: 
4792:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
4793:                     SELECT cursor_4c_BuscaEmp
4794:                     IF !EOF("cursor_4c_BuscaEmp")
4795:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_Emps) = "O"
4796:                             loc_oPg2.cnt_4c_Empresa.txt_4c_Emps.Value = ;
4797:                                 ALLTRIM(cursor_4c_BuscaEmp.cemps)
4798:                         ENDIF
4799:                         IF VARTYPE(loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps) = "O"
4800:                             loc_oPg2.cnt_4c_Empresa.txt_4c_DEmps.Value = ;
4801:                                 ALLTRIM(cursor_4c_BuscaEmp.razas)
4802:                         ENDIF
4803:                         THIS.this_oBusinessObject.this_cDEmps = ;
4804:                             ALLTRIM(cursor_4c_BuscaEmp.razas)
4805:                     ENDIF
4806:                 ENDIF
4807: 
4808:                 loc_oBusca.Release()
4809:                 loc_lResultado = .T.
4810:             ENDIF
4811:         CATCH TO loc_oErro
4812:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupEmpresa")
4813:         ENDTRY
4814: 
4815:         IF USED("cursor_4c_BuscaEmp")
4816:             USE IN cursor_4c_BuscaEmp
4817:         ENDIF
4818:         RETURN loc_lResultado
4819:     ENDPROC
4820: 
4821:     *--------------------------------------------------------------------------
4822:     * AbrirLookupContaIclis - lookup SigCdCli para cnt_4c_Conta
4823:     *--------------------------------------------------------------------------
4824:     PROCEDURE AbrirLookupContaIclis()
4825:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
4826:         loc_lResultado = .F.
4827:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4828: 
4829:         TRY
4830:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4831:                 "SigCdCli", "cursor_4c_BuscaIclis", "iclis", "", ;
4832:                 "Conta / Cliente")
4833: 
4834:             IF VARTYPE(loc_oBusca) = "O"
4835:                 loc_oBusca.mAddColuna("iclis",  "", "Conta")
4836:                 loc_oBusca.mAddColuna("cpfs",   "", "CPF")
4837:                 loc_oBusca.mAddColuna("razaos", "", "Nome")
4838:                 loc_oBusca.Show()
4839: 
4840:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIclis")
4841:                     SELECT cursor_4c_BuscaIclis
4842:                     IF !EOF("cursor_4c_BuscaIclis")
4843:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis) = "O"
4844:                             loc_oPg2.cnt_4c_Conta.txt_4c_ContaIclis.Value = ;
4845:                                 ALLTRIM(cursor_4c_BuscaIclis.iclis)
4846:                         ENDIF
4847:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis) = "O"
4848:                             loc_oPg2.cnt_4c_Conta.txt_4c_CpfIclis.Value = ;
4849:                                 ALLTRIM(cursor_4c_BuscaIclis.cpfs)
4850:                         ENDIF
4851:                         IF VARTYPE(loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis) = "O"
4852:                             loc_oPg2.cnt_4c_Conta.txt_4c_NomeIclis.Value = ;
4853:                                 ALLTRIM(cursor_4c_BuscaIclis.razaos)
4854:                         ENDIF
4855:                     ENDIF
4856:                 ENDIF
4857: 
4858:                 loc_oBusca.Release()
4859:                 loc_lResultado = .T.
4860:             ENDIF
4861:         CATCH TO loc_oErro
4862:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupContaIclis")
4863:         ENDTRY
4864: 
4865:         IF USED("cursor_4c_BuscaIclis")
4866:             USE IN cursor_4c_BuscaIclis
4867:         ENDIF
4868:         RETURN loc_lResultado
4869:     ENDPROC
4870: 
4871:     *--------------------------------------------------------------------------
4872:     * AbrirLookupClasemp - lookup SigCdGre (classe empresarial)
4873:     *--------------------------------------------------------------------------
4874:     PROCEDURE AbrirLookupClasemp()
4875:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado, loc_cClasse
4876:         loc_lResultado = .F.
4877:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4878: 
4879:         TRY
4880:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4881:                 "SigCdGre", "cursor_4c_BuscaGre", "class", "", ;
4882:                 "Classe Empresarial")
4883: 
4884:             IF VARTYPE(loc_oBusca) = "O"
4885:                 loc_oBusca.mAddColuna("class", "", "Classe")
4886:                 loc_oBusca.Show()
4887: 
4888:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGre")
4889:                     SELECT cursor_4c_BuscaGre
4890:                     IF !EOF("cursor_4c_BuscaGre") AND ;
4891:                        VARTYPE(loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp) = "O"
4892:                         SCATTER MEMVAR MEMO
4893:                         loc_cClasse = ALLTRIM(m.class)
4894:                         loc_oPg2.cnt_4c_Filtro.txt_4c_Clasemp.Value = loc_cClasse
4895:                     ENDIF
4896:                 ENDIF
4897: 
4898:                 loc_oBusca.Release()
4899:                 loc_lResultado = .T.
4900:             ENDIF
4901:         CATCH TO loc_oErro
4902:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupClasemp")
4903:         ENDTRY
4904: 
4905:         IF USED("cursor_4c_BuscaGre")
4906:             USE IN cursor_4c_BuscaGre
4907:         ENDIF
4908:         RETURN loc_lResultado
4909:     ENDPROC
4910: 
4911:     *--------------------------------------------------------------------------
4912:     * AbrirLookupAlinea - lookup SigCdAli (codigos) para txt_4c_AlineaChe
4913:     *--------------------------------------------------------------------------
4914:     PROCEDURE AbrirLookupAlinea()
4915:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
4916:         loc_lResultado = .F.
4917:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
4918: 
4919:         TRY
4920:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4921:                 "SigCdAli", "cursor_4c_BuscaAli", "codigos", "", ;
4922:                 "Al" + CHR(237) + "nea")
4923: 
4924:             IF VARTYPE(loc_oBusca) = "O"
4925:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
4926:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
4927:                 loc_oBusca.Show()
4928: 
4929:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAli")
4930:                     SELECT cursor_4c_BuscaAli
4931:                     IF !EOF("cursor_4c_BuscaAli") AND ;
4932:                        VARTYPE(loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe) = "O"
4933:                         loc_oPg2.cnt_4c_Cheque.txt_4c_AlineaChe.Value = ;
4934:                             ALLTRIM(cursor_4c_BuscaAli.codigos)
4935:                     ENDIF
4936:                 ENDIF
4937: 
4938:                 loc_oBusca.Release()
4939:                 loc_lResultado = .T.
4940:             ENDIF
4941:         CATCH TO loc_oErro
4942:             MsgErro(loc_oErro.Message, "Formlch.AbrirLookupAlinea")
4943:         ENDTRY
4944: 
4945:         IF USED("cursor_4c_BuscaAli")
4946:             USE IN cursor_4c_BuscaAli
4947:         ENDIF
4948:         RETURN loc_lResultado
4949:     ENDPROC
4950: 
4951: ENDDEFINE


### BO (C:\4c\projeto\app\classes\lchBO.prg):
*==============================================================================
* lchBO.prg - Business Object para Lote de Cheques
* Herda de BusinessBase
* Tabela Principal : SigChLcq
* Chave Primaria   : NumLotes (numeric)
* Cursor de Dados  : cursor_4c_Dados
* Form relacionado : Formlch.prg
*==============================================================================

DEFINE CLASS lchBO AS BusinessBase

    *==========================================================================
    * PROPRIEDADES - TABELA SigChLcq (campos diretos)
    *==========================================================================

    *-- Identificacao do Lote
    this_nNumLotes    = 0      && PK - Numero do Lote
    this_nNumLoteFPs  = 0      && Numero do Lote de Parcelas vinculado

    *-- Operacao e configuracao
    this_cCodigos     = ""     && Codigo da Operacao (SigCdOpt.Operacao)
    this_cEmps        = ""     && Empresa C(3)
    this_cUsuar       = ""     && Usuario que criou/alterou

    *-- Moeda e valores financeiros
    this_cMoeds       = ""     && Codigo da Moeda
    this_nCotas       = 0      && Cotacao da Moeda
    this_cCotUsus     = ""     && Cotacao definida pelo Usuario (char(10) em SigChLcq)
    this_nValTots     = 0      && Valor Total em Moeda Original
    this_nValConvs    = 0      && Valor Total Convertido (ValTots / Cotas)

    *-- Datas
    this_dDtEnts      = {}     && Data de Entrada do Lote
    this_dDataTrans   = {}     && Data de Transporte (nullable em SigChLcq)

    *-- Grupo e Conta Destino (campos da tabela SigChLcq)
    this_cGrupos      = ""     && Grupo de Destino
    this_cContas      = ""     && Conta de Destino

    *-- Cliente Emissor (vinculo com SigCdCli)
    this_cIclis       = ""     && Codigo do Cliente Emissor
    this_cGrclis      = ""     && Grupo do Cliente Emissor

    *-- Quantidade e identificadores auxiliares
    this_nQtdeCheqs   = 0      && Quantidade de Cheques no Lote
    this_nOrdens      = 0      && Tipo de Ordens (de SigCdOpt.Ordens)

    *-- Observacoes e follow up
    this_cObss        = ""     && Observacoes gerais do Lote
    this_cFollowUp    = ""     && Texto do Follow Up
    this_lFollowUp    = .F.    && Flag Repetir Follow Up

    *==========================================================================
    * PROPRIEDADES - DESTINO (com descricoes para a UI)
    * Campos do container CntDestino (Page2)
    *==========================================================================

    this_cGruDest     = ""     && Grupo Destino (Get_Grupo em CntDestino)
    this_cConDest     = ""     && Conta Destino (Get_Conta em CntDestino)
    this_cDGruDest    = ""     && Descricao do Grupo Destino
    this_cDConDest    = ""     && Descricao da Conta Destino
    this_cCpfDest     = ""     && CPF quando destino e pessoa fisica

    *==========================================================================
    * PROPRIEDADES - ORIGEM
    * Campos do container CntOrigem (Page2)
    *==========================================================================

    this_cGruOrig     = ""     && Grupo de Origem (Get_GruOrig)
    this_cConOrig     = ""     && Conta de Origem (Get_ConOrig)
    this_cDGruOrig    = ""     && Descricao do Grupo de Origem
    this_cDConOrig    = ""     && Descricao da Conta de Origem
    this_cCpfOrig     = ""     && CPF da Origem

    *==========================================================================
    * PROPRIEDADES - CARTEIRA
    * Campos do container CntCarteira (Page2)
    *==========================================================================

    this_cGruCart     = ""     && Grupo de Carteira (Get_GruCart)
    this_cConCart     = ""     && Conta de Carteira (Get_ConCart)
    this_cDGruCart    = ""     && Descricao do Grupo de Carteira
    this_cDConCart    = ""     && Descricao da Conta de Carteira

    *==========================================================================
    * PROPRIEDADES - EMISSOR
    * Campos do container CntEmissor (Page2)
    *==========================================================================

    this_cGruEmiss    = ""     && Grupo do Emissor (Get_GruEmiss)
    this_cConEmiss    = ""     && Conta do Emissor (Get_ConEmiss)
    this_cDGruEmiss   = ""     && Descricao do Grupo do Emissor
    this_cDConEmiss   = ""     && Descricao da Conta do Emissor
    this_cCpfEmiss    = ""     && CPF do Emissor (Get_Cpf em CntEmissor)
    this_cNomeEmiss   = ""     && Nome do Emissor (Rclis de SigCdCli)

    *==========================================================================
    * PROPRIEDADES - DESPESA
    * Campos do container cntDespesa (Page2)
    *==========================================================================

    this_cGruEmts     = ""     && Grupo de Despesa (Get_GruEmts)
    this_cConEmts     = ""     && Conta de Despesa (Get_ConEmts)
    this_cDGruEmts    = ""     && Descricao do Grupo de Despesa
    this_cDConEmts    = ""     && Descricao da Conta de Despesa
    this_cCpfEmts     = ""     && CPF da Despesa

    *==========================================================================
    * PROPRIEDADES - CENTRO DE CUSTO
    * Campos do container CntCCusto (Page2)
    *==========================================================================

    this_cGruCCs      = ""     && Grupo de Centro de Custo (Get_GrupoCcs)
    this_cConCCs      = ""     && Conta de Centro de Custo (Get_ContaCcs)
    this_cDGruCCs     = ""     && Descricao do Grupo CC
    this_cDConCCs     = ""     && Descricao da Conta CC
    this_cCpfCCs      = ""     && CPF do Centro de Custo

    *==========================================================================
    * PROPRIEDADES - RESPONSAVEL
    * Campos do container CntResponsavel (Page2)
    *==========================================================================

    this_cGruRes      = ""     && Grupo do Responsavel (Get_GruRes)
    this_cConRes      = ""     && Conta do Responsavel (Get_ConRes)
    this_cDConRes     = ""     && Descricao da Conta do Responsavel

    *==========================================================================
    * PROPRIEDADES - EMPRESA (descricao para exibicao)
    *==========================================================================

    this_cDEmps       = ""     && Razao Social / Descricao da Empresa

    *==========================================================================
    * PROPRIEDADES - CONTA DO CLIENTE/EMISSOR (CntConta)
    * Container na parte inferior da Page2 para identificacao do emissor
    *==========================================================================

    this_cContaIclis  = ""     && Conta/Iclis do Emissor (Get_Conta em CntConta)
    this_cCpfIclis    = ""     && CPF do Emissor (Get_CPF em CntConta)
    this_cNomeIclis   = ""     && Nome do Emissor (Get_Nome em CntConta)

    *==========================================================================
    * PROPRIEDADES - PROCESSAMENTO EM LOTE
    * Campos do container CntProcessa (Page2) - processamento automatico
    *==========================================================================

    this_dDtIniProc   = {}     && Data Inicial do Processamento
    this_dDtFimProc   = {}     && Data Final do Processamento
    this_nLoteProc    = 0      && Numero do Lote para Processamento
    this_cEmpProc     = ""     && Empresa para Processamento em Lote
    this_cPlanilha    = ""     && Caminho completo da Planilha Excel (.XLS)

    *==========================================================================
    * PROPRIEDADES - FILTROS DE LISTAGEM (Page1)
    * Campos do cntFiltros na Page1 (lista de lotes)
    *==========================================================================

    this_dDataFiltroI = {}     && Data Inicial do Filtro (Dt_inicial)
    this_dDataFiltroF = {}     && Data Final do Filtro (Dt_final)
    this_nFiltroConc  = 0      && Filtro Conciliacao: 0=Todos, 1=Conciliados, 2=Pendentes, 3=Ambos
    this_cFiltClasemp = ""     && Filtro por Classe Empresarial (Get_Clasemp)

    *==========================================================================
    * PROPRIEDADES - CURSOR DE DADOS
    *==========================================================================

    this_cCursorDados = "cursor_4c_Dados"   && Cursor principal para listagem de lotes

    *==========================================================================
    * INIT - Configuracao da tabela principal
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigChLcq"
            THIS.this_cCampoChave = "NumLotes"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar lchBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(STR(THIS.this_nNumLotes, 10))
    ENDFUNC

    *==========================================================================
    * Buscar - Lista lotes de cheques com filtros opcionais
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.dtents >= '2024-01-01'")
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.codigos, a.emps, a.dtents, a.datas," + ;
                " a.datatrans, a.moeds, a.cotas, a.valtots, a.valconvs," + ;
                " a.grupos, a.contas, a.gruorigs, a.conorigs," + ;
                " a.grucarts, a.concarts, a.iclis, a.grclis, a.usuarios," + ;
                " a.concs, a.numloteFps, a.cotusus," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.obs" + ;
                " FROM SigChLcq a" + ;
                " WHERE 1=1"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.dtents DESC, a.numlotes DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lotes de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega lote pelo numlotes (PK)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.numlotes, a.numloteFps, a.codigos, a.emps, a.usuarios," + ;
                " a.moeds, a.cotas, a.cotusus, a.valtots, a.valconvs," + ;
                " a.dtents, a.datatrans, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.iclis, a.grclis, a.concs, a.obs," + ;
                " a.grupoccs, a.contaccs, a.grupems, a.contems," + ;
                " a.gratends, a.atends, a.tipos, a.nums," + ;
                " a.numdopes, a.dopes, a.empdopnums, a.cnotas, a.locals, a.ntrans" + ;
                " FROM SigChLcq a" + ;
                " WHERE a.numlotes = " + FormatarNumeroSQL(par_nNumLotes)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *==========================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nNumLotes    = TratarNulo(numlotes,   "N")
            THIS.this_nNumLoteFPs  = TratarNulo(numloteFps, "N")
            THIS.this_cCodigos     = TratarNulo(codigos,    "C")
            THIS.this_cEmps        = TratarNulo(emps,       "C")
            THIS.this_cUsuar       = TratarNulo(usuarios,   "C")
            THIS.this_cMoeds       = TratarNulo(moeds,      "C")
            THIS.this_nCotas       = TratarNulo(cotas,      "N")
            THIS.this_cCotUsus     = TratarNulo(cotusus,    "C")
            THIS.this_nValTots     = TratarNulo(valtots,    "N")
            THIS.this_nValConvs    = TratarNulo(valconvs,   "N")
            THIS.this_dDtEnts      = TratarNulo(dtents,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,  "D")
            THIS.this_cGrupos      = TratarNulo(grupos,     "C")
            THIS.this_cContas      = TratarNulo(contas,     "C")
            THIS.this_cIclis       = TratarNulo(iclis,      "C")
            THIS.this_cGrclis      = TratarNulo(grclis,     "C")
            THIS.this_cObss        = TratarNulo(obs,        "C")
            THIS.this_cGruCart     = TratarNulo(grucarts,   "C")
            THIS.this_cConCart     = TratarNulo(concarts,   "C")
            THIS.this_cGruOrig     = TratarNulo(gruorigs,   "C")
            THIS.this_cConOrig     = TratarNulo(conorigs,   "C")
            THIS.this_cGruCCs      = TratarNulo(grupoccs,   "C")
            THIS.this_cConCCs      = TratarNulo(contaccs,   "C")
            THIS.this_cGruEmts     = TratarNulo(grupems,    "C")
            THIS.this_cConEmts     = TratarNulo(contems,    "C")
            THIS.this_cGruRes      = TratarNulo(gratends,   "C")
            THIS.this_cConRes      = TratarNulo(atends,     "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarCheques - Carrega cheques do lote em cursor_4c_Cheques (grid Page2)
    *==========================================================================
    FUNCTION BuscarCheques(par_nNumLotes)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.nums, a.bancos, a.agencias, a.ncontas, a.ncheques," + ;
                " a.valors, a.valpags, a.vencs, a.datas, a.dtemis, a.nalineas," + ;
                " a.emps, a.iclis, a.grclis, a.grupos, a.contas," + ;
                " a.gruorigs, a.conorigs, a.grucarts, a.concarts," + ;
                " a.grures, a.conres, a.protocolos, a.leituras, a.numeros" + ;
                " FROM SIGCHE a" + ;
                " WHERE a.numos = " + FormatarNumeroSQL(par_nNumLotes) + ;
                " ORDER BY a.bancos, a.agencias, a.ncontas, a.ncheques"

            IF USED("cursor_4c_Cheques")
                USE IN cursor_4c_Cheques
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cheques")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar cheques do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.this_nQtdeCheqs = RECCOUNT("cursor_4c_Cheques")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.BuscarCheques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterProximoLote - Retorna proximo numlotes disponivel para a empresa
    *==========================================================================
    PROTECTED FUNCTION ObterProximoLote()
        LOCAL loc_cSQL, loc_nResult, loc_nProximo
        loc_nProximo = 1

        loc_cSQL = "SELECT ISNULL(MAX(numlotes), 0) + 1 AS proximo FROM SigChLcq" + ;
            " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxLote")

        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxLote") > 0
            SELECT cursor_4c_ProxLote
            loc_nProximo = cursor_4c_ProxLote.proximo
        ENDIF

        IF USED("cursor_4c_ProxLote")
            USE IN cursor_4c_ProxLote
        ENDIF

        RETURN loc_nProximo
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nProximo
        loc_lSucesso = .F.

        TRY
            loc_nProximo = THIS.ObterProximoLote()
            THIS.this_nNumLotes = loc_nProximo

            loc_cSQL = "INSERT INTO SigChLcq (" + ;
                " numlotes, numloteFps, codigos, emps, usuarios, moeds, cotas, cotusus," + ;
                " valtots, valconvs, dtents, datatrans, grupos, contas," + ;
                " iclis, grclis, obs, concs, grucarts, concarts," + ;
                " gruorigs, conorigs, grupoccs, contaccs, grupems, contems," + ;
                " gratends, atends, autos, tipos, nums, numdopes, dopes," + ;
                " empdopnums, cnotas, locals, ntrans, dtsis)" + ;
                " VALUES (" + ;
                FormatarNumeroSQL(THIS.this_nNumLotes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumLoteFPs) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                "0," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                EscaparSQL(ALLTRIM(THIS.this_cConRes)) + "," + ;
                "0,'','',0,'','',0,0,GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE em SigChLcq
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigChLcq SET" + ;
                " codigos = "   + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
                " emps = "      + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + "," + ;
                " usuarios = "  + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + "," + ;
                " moeds = "     + EscaparSQL(ALLTRIM(THIS.this_cMoeds)) + "," + ;
                " cotas = "     + FormatarNumeroSQL(THIS.this_nCotas) + "," + ;
                " cotusus = "   + EscaparSQL(ALLTRIM(THIS.this_cCotUsus)) + "," + ;
                " valtots = "   + FormatarNumeroSQL(THIS.this_nValTots) + "," + ;
                " valconvs = "  + FormatarNumeroSQL(THIS.this_nValConvs) + "," + ;
                " dtents = "    + FormatarDataSQL(THIS.this_dDtEnts) + "," + ;
                " datatrans = " + IIF(EMPTY(THIS.this_dDataTrans), "NULL", FormatarDataSQL(THIS.this_dDataTrans)) + "," + ;
                " grupos = "    + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + "," + ;
                " contas = "    + EscaparSQL(ALLTRIM(THIS.this_cContas)) + "," + ;
                " iclis = "     + EscaparSQL(ALLTRIM(THIS.this_cIclis)) + "," + ;
                " grclis = "    + EscaparSQL(ALLTRIM(THIS.this_cGrclis)) + "," + ;
                " obs = "       + EscaparSQL(ALLTRIM(THIS.this_cObss)) + "," + ;
                " grucarts = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCart)) + "," + ;
                " concarts = "  + EscaparSQL(ALLTRIM(THIS.this_cConCart)) + "," + ;
                " gruorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruOrig)) + "," + ;
                " conorigs = "  + EscaparSQL(ALLTRIM(THIS.this_cConOrig)) + "," + ;
                " grupoccs = "  + EscaparSQL(ALLTRIM(THIS.this_cGruCCs)) + "," + ;
                " contaccs = "  + EscaparSQL(ALLTRIM(THIS.this_cConCCs)) + "," + ;
                " grupems = "   + EscaparSQL(ALLTRIM(THIS.this_cGruEmts)) + "," + ;
                " contems = "   + EscaparSQL(ALLTRIM(THIS.this_cConEmts)) + "," + ;
                " gratends = "  + EscaparSQL(ALLTRIM(THIS.this_cGruRes)) + "," + ;
                " atends = "    + EscaparSQL(ALLTRIM(THIS.this_cConRes)) + ;
                " WHERE numlotes = " + FormatarNumeroSQL(THIS.this_nNumLotes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE de cheques (SIGCHE) e do lote (SigChLcq)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.RegistrarAuditoria("DELETE")

            loc_cSQL = "DELETE FROM SIGCHE WHERE numos = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            SQLEXEC(gnConnHandle, loc_cSQL)

            loc_cSQL = "DELETE FROM SigChLcq WHERE numlotes = " + ;
                FormatarNumeroSQL(THIS.this_nNumLotes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir lote de cheques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em lchBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

