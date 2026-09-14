# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Término' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Término' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGCDBCH.Pagina.Leitura): Top original=170 vs migrado 'opt_4c_TipoLeitura' Top=3 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGCDBCH.Pagina.Leitura): Left original=709 vs migrado 'opt_4c_TipoLeitura' Left=3 (diff=706px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDBCH.Pagina.Leitura): Top original=2 vs migrado 'cmd_4c_Cancelar' Top=36 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Excluir' (parent: SIGCDBCH.Pagina.Leitura): Top original=2 vs migrado 'cmd_4c_Excluir' Top=36 (diff=34px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2864 linhas total):

*-- Linhas 40 a 171:
40:     this_cTipoLeitora   = ""
41: 
42:     *--------------------------------------------------------------------------
43:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
44:     * DataSession=2: FormBase.Init define SET DATE BRITISH + SET CENTURY ON
45:     *--------------------------------------------------------------------------
46:     PROCEDURE Init()
47:         LOCAL loc_lResultado
48:         loc_lResultado = .F.
49: 
50:         TRY
51:             loc_lResultado = DODEFAULT()
52:         CATCH TO loc_oErro
53:             MsgErro(loc_oErro.Message, "FormBch.Init")
54:         ENDTRY
55: 
56:         RETURN loc_lResultado
57:     ENDPROC
58: 
59:     *--------------------------------------------------------------------------
60:     * InicializarForm - Configura estrutura basica do form
61:     * Chamado automaticamente pelo FormBase.Init()
62:     *--------------------------------------------------------------------------
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lResultado
65:         loc_lResultado = .F.
66: 
67:         TRY
68:             THIS.this_oBusinessObject = CREATEOBJECT("BchBO")
69: 
70:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
71:                 MsgErro("Falha ao criar BchBO", "Erro")
72:             ELSE
73:                 THIS.ConfigurarPageFrame()
74: 
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
77: 
78:                 THIS.pgf_4c_Paginas.Visible    = .T.
79:                 THIS.pgf_4c_Paginas.ActivePage = 1
80:                 THIS.this_cModoAtual = "LISTA"
81: 
82:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
83:                     THIS.CarregarLista()
84:                 ENDIF
85: 
86:                 loc_lResultado = .T.
87:             ENDIF
88:         CATCH TO loc_oErro
89:             MsgErro(loc_oErro.Message, "FormBch.InicializarForm")
90:         ENDTRY
91: 
92:         RETURN loc_lResultado
93:     ENDPROC
94: 
95:     *--------------------------------------------------------------------------
96:     * ConfigurarPageFrame - Cria PageFrame com 3 paginas (Lista, Dados, Leitura)
97:     *--------------------------------------------------------------------------
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         LOCAL loc_oPgf
100:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
101:         loc_oPgf = THIS.pgf_4c_Paginas
102: 
103:         WITH loc_oPgf
104:             .PageCount = 3
105:             .Top       = -29
106:             .Left      = 0
107:             .Width     = THIS.Width
108:             .Height    = THIS.Height + 29
109:             .Tabs      = .F.
110:             .Visible   = .T.
111:             .Page1.Caption   = "Lista"
112:             .Page1.BackColor = RGB(100, 100, 100)
113:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:             .Page2.Caption   = "Dados"
115:             .Page2.BackColor = RGB(100, 100, 100)
116:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page3.Caption   = "Leitura"
118:             .Page3.BackColor = RGB(100, 100, 100)
119:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120:         ENDWITH
121: 
122:         THIS.ConfigurarPaginaLista()
123:         THIS.ConfigurarPaginaDados()
124:         THIS.ConfigurarPaginaLeitura()
125:     ENDPROC
126: 
127:     *--------------------------------------------------------------------------
128:     * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD + Leitura/Fecha + grid
129:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
130:     *--------------------------------------------------------------------------
131:     PROTECTED PROCEDURE ConfigurarPaginaLista()
132:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
133: 
134:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
135: 
136:         *-- Cabecalho cinza
137:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
138:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
139:         WITH loc_oCab
140:             .Top         = 29
141:             .Left        = 0
142:             .Width       = THIS.Width
143:             .Height      = 80
144:             .BackColor   = RGB(100, 100, 100)
145:             .BorderWidth = 0
146:             .Visible     = .T.
147:         ENDWITH
148: 
149:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
150:         WITH loc_oCab.lbl_4c_Sombra
151:             .Caption   = THIS.Caption
152:             .AutoSize  = .F.
153:             .Width     = THIS.Width
154:             .Height    = 40
155:             .Top       = 15
156:             .Left      = 10
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.
160:             .ForeColor = RGB(0, 0, 0)
161:             .BackStyle = 0
162:             .Visible   = .T.
163:         ENDWITH
164: 
165:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
166:         WITH loc_oCab.lbl_4c_Titulo
167:             .Caption   = THIS.Caption
168:             .AutoSize  = .F.
169:             .Width     = THIS.Width
170:             .Height    = 46
171:             .Top       = 18

*-- Linhas 211 a 411:
211:             .SpecialEffect   = 0
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
215: 
216:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
217:         WITH loc_oBotoes.cmd_4c_Visualizar
218:             .Top             = 5
219:             .Left            = 80
220:             .Width           = 75
221:             .Height          = 75
222:             .Caption         = "Visualizar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
224:             .PicturePosition = 13
225:             .FontName        = "Tahoma"
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .FontSize        = 8
229:             .ForeColor       = RGB(90, 90, 90)
230:             .BackColor       = RGB(255, 255, 255)
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
238:         WITH loc_oBotoes.cmd_4c_Alterar
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .Caption         = "Alterar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
245:             .PicturePosition = 13
246:             .FontName        = "Tahoma"
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .FontSize        = 8
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oBotoes.cmd_4c_Excluir
260:             .Top             = 5
261:             .Left            = 230
262:             .Width           = 75
263:             .Height          = 75
264:             .Caption         = "Excluir"
265:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
266:             .PicturePosition = 13
267:             .FontName        = "Tahoma"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
278: 
279:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oBotoes.cmd_4c_Buscar
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .FontName        = "Tahoma"
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontSize        = 8
292:             .ForeColor       = RGB(90, 90, 90)
293:             .BackColor       = RGB(255, 255, 255)
294:             .Themes          = .F.
295:             .SpecialEffect   = 0
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida canonico (Left=917, Width=90, Top=29)
301:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
302:         loc_oSaida = loc_oPg1.cnt_4c_Saida
303:         WITH loc_oSaida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH loc_oSaida.cmd_4c_Encerrar
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .Caption         = "Encerrar"
320:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
321:             .PicturePosition = 13
322:             .FontName        = "Tahoma"
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .FontSize        = 8
326:             .ForeColor       = RGB(90, 90, 90)
327:             .BackColor       = RGB(255, 255, 255)
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .Visible         = .T.
331:         ENDWITH
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Botao Leitura (original: top=83+29=112, left=31, width=120, height=40)
335:         *-- Abre pagina de leitura de cheques para o balanco selecionado
336:         loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
337:         WITH loc_oPg1.cmd_4c_Leitura
338:             .Top           = 112
339:             .Left          = 31
340:             .Width         = 120
341:             .Height        = 40
342:             .Caption       = "Leitura"
343:             .FontName      = "Tahoma"
344:             .FontBold      = .F.
345:             .FontSize      = 8
346:             .ForeColor     = RGB(90, 90, 90)
347:             .BackColor     = RGB(255, 255, 255)
348:             .Themes        = .F.
349:             .SpecialEffect = 0
350:             .Visible       = .T.
351:         ENDWITH
352:         BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")
353: 
354:         *-- Botao Fecha/Encerrar Balanco (original: top=83+29=112, left=152, width=120, height=40)
355:         loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
356:         WITH loc_oPg1.cmd_4c_Fecha
357:             .Top           = 112
358:             .Left          = 152
359:             .Width         = 120
360:             .Height        = 40
361:             .Caption       = "Encerrar"
362:             .FontName      = "Tahoma"
363:             .FontBold      = .F.
364:             .FontSize      = 8
365:             .ForeColor     = RGB(90, 90, 90)
366:             .BackColor     = RGB(255, 255, 255)
367:             .Themes        = .F.
368:             .SpecialEffect = 0
369:             .Visible       = .T.
370:         ENDWITH
371:         BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")
372: 
373:         *-- Grid da lista: top=129+29=158, left=33, width=941, height=461
374:         loc_oPg1.AddObject("grd_4c_Dados", "Grid")
375:         loc_oGrid = loc_oPg1.grd_4c_Dados
376:         loc_oGrid.ColumnCount = 6
377:         WITH loc_oGrid
378:             .Top                = 158
379:             .Left               = 33
380:             .Width              = 941
381:             .Height             = 461
382:             .FontName           = "Verdana"
383:             .FontSize           = 8
384:             .ForeColor          = RGB(90, 90, 90)
385:             .BackColor          = RGB(255, 255, 255)
386:             .GridLineColor      = RGB(238, 238, 238)
387:             .HighlightBackColor = RGB(255, 255, 255)
388:             .HighlightForeColor = RGB(15, 41, 104)
389:             .HighlightStyle     = 2
390:             .DeleteMark         = .F.
391:             .RecordMark         = .F.
392:             .RowHeight          = 16
393:             .ScrollBars         = 2
394:             .GridLines          = 3
395:             .Visible            = .T.
396:         ENDWITH
397: 
398:         WITH loc_oGrid.Column1
399:             .Width = 60
400:             .Header1.Caption = "C" + CHR(243) + "digo"
401:         ENDWITH
402:         WITH loc_oGrid.Column2
403:             .Width = 90
404:             .Header1.Caption = "In" + CHR(237) + "cio"
405:         ENDWITH
406:         WITH loc_oGrid.Column3
407:             .Width = 90
408:             .Header1.Caption = "T" + CHR(233) + "rmino"
409:         ENDWITH
410:         WITH loc_oGrid.Column4
411:             .Width = 120

*-- Linhas 420 a 529:
420:             .Header1.Caption = "Conta"
421:         ENDWITH
422: 
423:         THIS.TornarControlesVisiveis(loc_oPg1)
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * ConfigurarPaginaDados - Page2: container salva + todos os campos de edicao
428:     * Compensacao +29 em todos os Top pelo PageFrame.Top=-29
429:     * Lookups/Valid handlers implementados na Fase 6
430:     *--------------------------------------------------------------------------
431:     PROTECTED PROCEDURE ConfigurarPaginaDados()
432:         LOCAL loc_oPg2, loc_oSalva
433: 
434:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
435: 
436:         *-- Container Salva (Confirmar/Cancelar) - Left=842
437:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
438:         loc_oSalva = loc_oPg2.cnt_4c_Salva
439:         WITH loc_oSalva
440:             .Top         = 33
441:             .Left        = 842
442:             .Width       = 160
443:             .Height      = 85
444:             .BackStyle   = 0
445:             .BorderWidth = 0
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
450:         WITH loc_oSalva.cmd_4c_Confirmar
451:             .Top             = 5
452:             .Left            = 5
453:             .Width           = 75
454:             .Height          = 75
455:             .Caption         = "Confirmar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:             .PicturePosition = 13
458:             .FontName        = "Tahoma"
459:             .FontBold        = .T.
460:             .FontItalic      = .T.
461:             .FontSize        = 8
462:             .ForeColor       = RGB(90, 90, 90)
463:             .BackColor       = RGB(255, 255, 255)
464:             .Themes          = .F.
465:             .SpecialEffect   = 0
466:             .Visible         = .T.
467:         ENDWITH
468:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
469: 
470:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oSalva.cmd_4c_Cancelar
472:             .Top             = 5
473:             .Left            = 80
474:             .Width           = 75
475:             .Height          = 75
476:             .Caption         = "Encerrar"
477:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
478:             .PicturePosition = 13
479:             .FontName        = "Tahoma"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .FontSize        = 8
483:             .ForeColor       = RGB(90, 90, 90)
484:             .BackColor       = RGB(255, 255, 255)
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .Visible         = .T.
488:         ENDWITH
489:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
490: 
491:         *-- === Codigo (PK - readonly, top=172+29 original=143) ===
492:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
493:         WITH loc_oPg2.lbl_4c_Codigo
494:             .Top       = 176
495:             .Left      = 283
496:             .Width     = 40
497:             .Height    = 18
498:             .Caption   = "C" + CHR(243) + "digo"
499:             .AutoSize  = .F.
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .ForeColor = RGB(255, 255, 255)
503:             .BackStyle = 0
504:             .Visible   = .T.
505:         ENDWITH
506: 
507:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
508:         WITH loc_oPg2.txt_4c_Codigo
509:             .Top      = 172
510:             .Left     = 327
511:             .Width    = 60
512:             .Height   = 24
513:             .ReadOnly = .T.
514:             .Value    = ""
515:             .FontName = "Tahoma"
516:             .FontSize = 8
517:             .Visible  = .T.
518:         ENDWITH
519: 
520:         *-- === Tipo (ComboBox tipos 1-4, top=199 original=170) ===
521:         loc_oPg2.AddObject("lbl_4c_Tipo", "Label")
522:         WITH loc_oPg2.lbl_4c_Tipo
523:             .Top       = 203
524:             .Left      = 296
525:             .Width     = 28
526:             .Height    = 18
527:             .Caption   = "Tipo"
528:             .AutoSize  = .F.
529:             .FontName  = "Tahoma"

*-- Linhas 723 a 780:
723:         ENDWITH
724: 
725:         *-- Valid handlers para campos de lookup (Fase 6)
726:         BINDEVENT(loc_oPg2.txt_4c_Oper,   "KeyPress", THIS, "ValidOper")
727:         BINDEVENT(loc_oPg2.txt_4c_Grupo,  "KeyPress", THIS, "ValidGrupo")
728:         BINDEVENT(loc_oPg2.txt_4c_DGrupo, "KeyPress", THIS, "ValidDGrupo")
729:         BINDEVENT(loc_oPg2.txt_4c_Conta,  "KeyPress", THIS, "ValidConta")
730:         BINDEVENT(loc_oPg2.txt_4c_DConta, "KeyPress", THIS, "ValidDConta")
731: 
732:         THIS.TornarControlesVisiveis(loc_oPg2)
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * ConfigurarPaginaLeitura - Page3: leitura de cheques
737:     * Shapes, campos readonly do balanco, tipo leitura, entrada manual,
738:     * grade de historico (cursor_4c_Historico) e botoes de acao
739:     *--------------------------------------------------------------------------
740:     PROTECTED PROCEDURE ConfigurarPaginaLeitura()
741:         LOCAL loc_oPg3, loc_oGrid
742: 
743:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
744: 
745:         *======================================================
746:         * 1. Shapes decorativos
747:         *======================================================
748:         *-- Shape1: fundo area botoes topo (top=36 = legado 7 + 29 PageFrame)
749:         loc_oPg3.AddObject("shp_4c_BotoesBg", "Shape")
750:         WITH loc_oPg3.shp_4c_BotoesBg
751:             .Top           = 36
752:             .Left          = 537
753:             .Width         = 251
754:             .Height        = 110
755:             .SpecialEffect = 1
756:             .BackColor     = RGB(236, 233, 216)
757:             .BorderColor   = RGB(160, 160, 160)
758:             .Visible       = .T.
759:         ENDWITH
760: 
761:         *-- Shape2: fundo dados do balanco corrente
762:         loc_oPg3.AddObject("shp_4c_DadosBal", "Shape")
763:         WITH loc_oPg3.shp_4c_DadosBal
764:             .Top           = 193
765:             .Left          = 167
766:             .Width         = 509
767:             .Height        = 154
768:             .SpecialEffect = 1
769:             .BackColor     = RGB(236, 233, 216)
770:             .BorderColor   = RGB(160, 160, 160)
771:             .Visible       = .T.
772:         ENDWITH
773: 
774:         *-- Shape4: fundo area tipo de leitura
775:         loc_oPg3.AddObject("shp_4c_TipoLeitBg", "Shape")
776:         WITH loc_oPg3.shp_4c_TipoLeitBg
777:             .Top           = 193
778:             .Left          = 674
779:             .Width         = 158
780:             .Height        = 154

*-- Linhas 963 a 1011:
963:             .FontSize    = 9
964:             .Visible     = .T.
965:         ENDWITH
966: 
967:         *======================================================
968:         * 4. Tipo de Leitura (opt_4c_TipoLeitura)
969:         *    Button1=Teclado (manual), Button2=Porta (serial - desabilitado)
970:         *======================================================
971:         loc_oPg3.AddObject("opt_4c_TipoLeitura", "OptionGroup")
972:         loc_oPg3.opt_4c_TipoLeitura.Top         = 199
973:         loc_oPg3.opt_4c_TipoLeitura.Left        = 709
974:         loc_oPg3.opt_4c_TipoLeitura.Width       = 78
975:         loc_oPg3.opt_4c_TipoLeitura.Height      = 41
976:         loc_oPg3.opt_4c_TipoLeitura.ButtonCount = 2
977:         loc_oPg3.opt_4c_TipoLeitura.Value       = 1
978:         loc_oPg3.opt_4c_TipoLeitura.BackStyle   = 0
979:         loc_oPg3.opt_4c_TipoLeitura.BorderStyle = 0
980:         loc_oPg3.opt_4c_TipoLeitura.Visible     = .T.
981:         WITH loc_oPg3.opt_4c_TipoLeitura
982:             WITH .Buttons(1)
983:                 .Top     = 3
984:                 .Left    = 3
985:                 .Width   = 70
986:                 .Height  = 17
987:                 .Caption = "Teclado"
988:                 .Value   = 1
989:             ENDWITH
990:             WITH .Buttons(2)
991:                 .Top     = 22
992:                 .Left    = 3
993:                 .Width   = 70
994:                 .Height  = 17
995:                 .Caption = "Porta"
996:                 .Value   = 0
997:                 .Enabled = .F.
998:             ENDWITH
999:         ENDWITH
1000: 
1001:         *-- Shape3: destaque info modo teclado
1002:         loc_oPg3.AddObject("shp_4c_LeitorInfo", "Shape")
1003:         WITH loc_oPg3.shp_4c_LeitorInfo
1004:             .Top           = 245
1005:             .Left          = 705
1006:             .Width         = 95
1007:             .Height        = 36
1008:             .SpecialEffect = 1
1009:             .BackColor     = RGB(255, 255, 200)
1010:             .BorderColor   = RGB(160, 160, 160)
1011:             .Visible       = .T.

*-- Linhas 1202 a 1245:
1202:             .FontSize    = 9
1203:             .Visible     = .T.
1204:         ENDWITH
1205:         BINDEVENT(loc_oPg3.txt_4c_Num, "KeyPress", THIS, "NumGetLostFocus")
1206: 
1207:         *-- Valor (readonly - preenchido pela validacao)
1208:         loc_oPg3.AddObject("lbl_4c_LValor", "Label")
1209:         WITH loc_oPg3.lbl_4c_LValor
1210:             .Top       = 480
1211:             .Left      = 175
1212:             .Width     = 75
1213:             .Height    = 16
1214:             .Caption   = "Valor:"
1215:             .FontName  = "Arial"
1216:             .FontSize  = 8
1217:             .BackStyle = 0
1218:             .AutoSize  = .F.
1219:             .Visible   = .T.
1220:         ENDWITH
1221: 
1222:         loc_oPg3.AddObject("txt_4c_Valor", "TextBox")
1223:         WITH loc_oPg3.txt_4c_Valor
1224:             .Top         = 477
1225:             .Left        = 253
1226:             .Width       = 70
1227:             .Height      = 22
1228:             .ReadOnly    = .T.
1229:             .BackColor   = RGB(220, 220, 220)
1230:             .BorderStyle = 1
1231:             .FontName    = "Arial"
1232:             .FontSize    = 9
1233:             .Visible     = .T.
1234:         ENDWITH
1235: 
1236:         *-- Vencimento (readonly - preenchido pela validacao)
1237:         loc_oPg3.AddObject("lbl_4c_LVecto", "Label")
1238:         WITH loc_oPg3.lbl_4c_LVecto
1239:             .Top       = 506
1240:             .Left      = 175
1241:             .Width     = 75
1242:             .Height    = 16
1243:             .Caption   = "Vencto:"
1244:             .FontName  = "Arial"
1245:             .FontSize  = 8

*-- Linhas 1339 a 1453:
1339: 
1340:         *======================================================
1341:         * 7. Botoes de acao da leitura (posicionados diretamente em Page3)
1342:         *    Left absoluto: Excluir=773, Gravar=848, Encerrar=923
1343:         *======================================================
1344:         loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
1345:         WITH loc_oPg3.cmd_4c_Excluir
1346:             .Top             = 36
1347:             .Left            = 773
1348:             .Width           = 75
1349:             .Height          = 75
1350:             .Caption         = "Excluir"
1351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1352:             .PicturePosition = 13
1353:             .FontName        = "Tahoma"
1354:             .FontBold        = .T.
1355:             .FontItalic      = .T.
1356:             .FontSize        = 8
1357:             .ForeColor       = RGB(90, 90, 90)
1358:             .BackColor       = RGB(255, 255, 255)
1359:             .Themes          = .F.
1360:             .SpecialEffect   = 0
1361:             .Visible         = .T.
1362:         ENDWITH
1363:         BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirHistoricoClick")
1364: 
1365:         loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
1366:         WITH loc_oPg3.cmd_4c_Confirmar
1367:             .Top             = 36
1368:             .Left            = 848
1369:             .Width           = 75
1370:             .Height          = 75
1371:             .Caption         = "Gravar"
1372:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1373:             .PicturePosition = 13
1374:             .FontName        = "Tahoma"
1375:             .FontBold        = .T.
1376:             .FontItalic      = .T.
1377:             .FontSize        = 8
1378:             .ForeColor       = RGB(90, 90, 90)
1379:             .BackColor       = RGB(255, 255, 255)
1380:             .Themes          = .F.
1381:             .SpecialEffect   = 0
1382:             .Visible         = .T.
1383:         ENDWITH
1384:         BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarLeituraClick")
1385: 
1386:         loc_oPg3.AddObject("cmd_4c_Cancelar", "CommandButton")
1387:         WITH loc_oPg3.cmd_4c_Cancelar
1388:             .Top             = 36
1389:             .Left            = 923
1390:             .Width           = 75
1391:             .Height          = 75
1392:             .Caption         = "Encerrar"
1393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1394:             .PicturePosition = 13
1395:             .FontName        = "Tahoma"
1396:             .FontBold        = .T.
1397:             .FontItalic      = .T.
1398:             .FontSize        = 8
1399:             .ForeColor       = RGB(90, 90, 90)
1400:             .BackColor       = RGB(255, 255, 255)
1401:             .Themes          = .F.
1402:             .SpecialEffect   = 0
1403:             .Visible         = .T.
1404:         ENDWITH
1405:         BINDEVENT(loc_oPg3.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarLeituraClick")
1406: 
1407:         THIS.TornarControlesVisiveis(loc_oPg3)
1408:     ENDPROC
1409: 
1410:     *--------------------------------------------------------------------------
1411:     * CarregarLista - Carrega registros de SigCdBch no grid da Page1
1412:     *--------------------------------------------------------------------------
1413:     PROCEDURE CarregarLista()
1414:         LOCAL loc_lResultado, loc_oGrid
1415:         loc_lResultado = .F.
1416: 
1417:         TRY
1418:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1419:                 loc_lResultado = .T.
1420:             ELSE
1421:                 IF !THIS.this_oBusinessObject.Buscar("")
1422:                     loc_lResultado = .F.
1423:                 ELSE
1424:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1425:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1426: 
1427:                         loc_oGrid.ColumnCount = 6
1428:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1429: 
1430:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1431:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1432:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1433:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1434:                         loc_oGrid.Column4.ControlSource = ;
1435:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1436:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1437:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1438:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1439:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1440: 
1441:                         *-- Reconfigurar headers (RecordSource reseta captions)
1442:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1443:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1444:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1445:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1446:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1447:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1448: 
1449:                         THIS.FormatarGridLista(loc_oGrid)
1450:                     ENDIF
1451:                     loc_lResultado = .T.
1452:                 ENDIF
1453:             ENDIF

*-- Linhas 1461 a 1794:
1461:     *--------------------------------------------------------------------------
1462:     * AlternarPagina - Alterna entre as 3 paginas do PageFrame
1463:     *--------------------------------------------------------------------------
1464:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1465:         LOCAL loc_lResultado
1466:         loc_lResultado = .F.
1467: 
1468:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
1469:             RETURN .F.
1470:         ENDIF
1471: 
1472:         TRY
1473:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1474: 
1475:             DO CASE
1476:             CASE par_nPagina = 1
1477:                 THIS.this_cModoAtual = "LISTA"
1478:                 THIS.CarregarLista()
1479:             CASE par_nPagina = 2
1480:                 *-- modo definido pelo chamador (INCLUIR/ALTERAR/VISUALIZAR)
1481:             CASE par_nPagina = 3
1482:                 THIS.this_cModoAtual = "LEITURA"
1483:                 THIS.CarregarLeitura()
1484:             ENDCASE
1485: 
1486:             loc_lResultado = .T.
1487:         CATCH TO loc_oErro
1488:             MsgErro(loc_oErro.Message, "FormBch.AlternarPagina")
1489:         ENDTRY
1490: 
1491:         RETURN loc_lResultado
1492:     ENDPROC
1493: 
1494:     *--------------------------------------------------------------------------
1495:     * BtnEncerrarClick - Fecha o formulario
1496:     *--------------------------------------------------------------------------
1497:     PROCEDURE BtnEncerrarClick()
1498:         THIS.Release()
1499:     ENDPROC
1500: 
1501:     *--------------------------------------------------------------------------
1502:     * BtnIncluirClick - Inicia inclusao de novo balanco
1503:     *--------------------------------------------------------------------------
1504:     PROCEDURE BtnIncluirClick()
1505:         THIS.this_oBusinessObject.NovoRegistro()
1506:         THIS.LimparCampos()
1507:         THIS.this_cModoAtual = "INCLUIR"
1508:         THIS.HabilitarCampos(.T.)
1509:         THIS.AjustarBotoesPorModo()
1510:         THIS.AlternarPagina(2)
1511:     ENDPROC
1512: 
1513:     *--------------------------------------------------------------------------
1514:     * BtnVisualizarClick - Visualiza balanco selecionado (somente leitura)
1515:     *--------------------------------------------------------------------------
1516:     PROCEDURE BtnVisualizarClick()
1517:         LOCAL loc_nCodigo
1518: 
1519:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1520:             MsgAviso("Selecione um registro na lista.", "")
1521:             RETURN
1522:         ENDIF
1523: 
1524:         SELECT cursor_4c_Dados
1525:         loc_nCodigo = cursor_4c_Dados.codigos
1526: 
1527:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1528:             THIS.this_cModoAtual = "VISUALIZAR"
1529:             THIS.BOParaForm()
1530:             THIS.HabilitarCampos(.F.)
1531:             THIS.AjustarBotoesPorModo()
1532:             THIS.AlternarPagina(2)
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     *--------------------------------------------------------------------------
1537:     * BtnAlterarClick - Edita balanco selecionado
1538:     *--------------------------------------------------------------------------
1539:     PROCEDURE BtnAlterarClick()
1540:         LOCAL loc_nCodigo
1541: 
1542:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1543:             MsgAviso("Selecione um registro na lista.", "")
1544:             RETURN
1545:         ENDIF
1546: 
1547:         SELECT cursor_4c_Dados
1548: 
1549:         IF cursor_4c_Dados.encerras
1550:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1551:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1552:             RETURN
1553:         ENDIF
1554: 
1555:         loc_nCodigo = cursor_4c_Dados.codigos
1556: 
1557:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1558:             THIS.this_oBusinessObject.EditarRegistro()
1559:             THIS.this_cModoAtual = "ALTERAR"
1560:             THIS.BOParaForm()
1561:             THIS.HabilitarCampos(.T.)
1562:             THIS.AjustarBotoesPorModo()
1563:             THIS.AlternarPagina(2)
1564:         ENDIF
1565:     ENDPROC
1566: 
1567:     *--------------------------------------------------------------------------
1568:     * BtnExcluirClick - Exclui balanco selecionado
1569:     *--------------------------------------------------------------------------
1570:     PROCEDURE BtnExcluirClick()
1571:         LOCAL loc_nCodigo
1572: 
1573:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1574:             MsgAviso("Selecione um registro para excluir.", "")
1575:             RETURN
1576:         ENDIF
1577: 
1578:         SELECT cursor_4c_Dados
1579: 
1580:         IF cursor_4c_Dados.encerras
1581:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1582:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1583:             RETURN
1584:         ENDIF
1585: 
1586:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1587:                         "Confirmar")
1588:             RETURN
1589:         ENDIF
1590: 
1591:         loc_nCodigo = cursor_4c_Dados.codigos
1592: 
1593:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1594:             IF THIS.this_oBusinessObject.Excluir()
1595:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1596:                 THIS.CarregarLista()
1597:             ENDIF
1598:         ENDIF
1599:     ENDPROC
1600: 
1601:     *--------------------------------------------------------------------------
1602:     * BtnBuscarClick - Busca registros de SigCdBch por FormBuscaAuxiliar
1603:     *--------------------------------------------------------------------------
1604:     PROCEDURE BtnBuscarClick()
1605:         LOCAL loc_oBusca, loc_nCodigo, loc_lResultado
1606:         loc_lResultado = .F.
1607: 
1608:         TRY
1609:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1610:                 "SigCdBch", "cursor_4c_BuscaBch", "codigos", "", ;
1611:                 "Balan" + CHR(231) + "o de Cheques")
1612: 
1613:             IF VARTYPE(loc_oBusca) = "O"
1614:                 loc_oBusca.mAddColuna("codigos",   "", "C" + CHR(243) + "digo")
1615:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
1616:                 loc_oBusca.mAddColuna("datainis",  "", "In" + CHR(237) + "cio")
1617:                 loc_oBusca.mAddColuna("datafims",  "", "T" + CHR(233) + "rmino")
1618:                 loc_oBusca.Show()
1619: 
1620:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1621:                     SELECT cursor_4c_BuscaBch
1622:                     IF !EOF("cursor_4c_BuscaBch")
1623:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1624:                         THIS.this_oBusinessObject.Buscar( ;
1625:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1626:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1627:                             THIS.CarregarLista()
1628:                         ENDIF
1629:                     ENDIF
1630:                 ELSE
1631:                     THIS.CarregarLista()
1632:                 ENDIF
1633: 
1634:                 loc_oBusca.Release()
1635:             ENDIF
1636:         CATCH TO loc_oErro
1637:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1638:         ENDTRY
1639: 
1640:         IF USED("cursor_4c_BuscaBch")
1641:             USE IN cursor_4c_BuscaBch
1642:         ENDIF
1643:     ENDPROC
1644: 
1645:     *--------------------------------------------------------------------------
1646:     * BtnSalvarClick - Salva registro (cmd_4c_Confirmar em Page2)
1647:     *--------------------------------------------------------------------------
1648:     PROCEDURE BtnSalvarClick()
1649:         LOCAL loc_oPg2
1650:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1651: 
1652:         *-- Validacoes fora do TRY para que RETURN funcione
1653:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1654:             IF EMPTY(loc_oPg2.txt_4c_DataInicial.Value)
1655:                 MsgAviso("Data Inicial obrigat" + CHR(243) + "ria!", "")
1656:                 RETURN
1657:             ENDIF
1658:         ENDIF
1659: 
1660:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1661:             IF EMPTY(loc_oPg2.txt_4c_DataFinal.Value)
1662:                 MsgAviso("Data Final obrigat" + CHR(243) + "ria!", "")
1663:                 RETURN
1664:             ENDIF
1665:         ENDIF
1666: 
1667:         THIS.FormParaBO()
1668: 
1669:         IF THIS.this_oBusinessObject.Salvar()
1670:             MsgInfo("Registro salvo com sucesso!", "")
1671:             THIS.this_cModoAtual = "LISTA"
1672:             THIS.AlternarPagina(1)
1673:         ENDIF
1674:     ENDPROC
1675: 
1676:     *--------------------------------------------------------------------------
1677:     * BtnCancelarClick - Cancela edicao e retorna para lista
1678:     *--------------------------------------------------------------------------
1679:     PROCEDURE BtnCancelarClick()
1680:         THIS.this_cModoAtual = "LISTA"
1681:         THIS.AlternarPagina(1)
1682:         THIS.CarregarLista()
1683:     ENDPROC
1684: 
1685:     *--------------------------------------------------------------------------
1686:     * BtnLeituraClick - Abre pagina de leitura para o balanco selecionado
1687:     *--------------------------------------------------------------------------
1688:     PROCEDURE BtnLeituraClick()
1689:         LOCAL loc_nCodigo
1690: 
1691:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1692:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1693:             RETURN
1694:         ENDIF
1695: 
1696:         SELECT cursor_4c_Dados
1697: 
1698:         IF cursor_4c_Dados.encerras
1699:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1700:             RETURN
1701:         ENDIF
1702: 
1703:         loc_nCodigo = cursor_4c_Dados.codigos
1704: 
1705:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1706:             THIS.this_cModoAtual = "LEITURA"
1707:             THIS.AlternarPagina(3)
1708:         ENDIF
1709:     ENDPROC
1710: 
1711:     *--------------------------------------------------------------------------
1712:     * BtnFechaClick - Encerra o balanco selecionado
1713:     *--------------------------------------------------------------------------
1714:     PROCEDURE BtnFechaClick()
1715:         LOCAL loc_nCodigo
1716: 
1717:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1718:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1719:             RETURN
1720:         ENDIF
1721: 
1722:         SELECT cursor_4c_Dados
1723: 
1724:         IF cursor_4c_Dados.encerras
1725:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1726:             RETURN
1727:         ENDIF
1728: 
1729:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1730:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1731:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1732:                         "ATEN" + CHR(199) + CHR(195) + "O")
1733:             RETURN
1734:         ENDIF
1735: 
1736:         loc_nCodigo = cursor_4c_Dados.codigos
1737: 
1738:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1739:             IF THIS.this_oBusinessObject.EncerrarBalanco()
1740:                 MsgInfo("Balan" + CHR(231) + "o encerrado com sucesso!", "")
1741:                 THIS.CarregarLista()
1742:             ENDIF
1743:         ENDIF
1744:     ENDPROC
1745: 
1746:     *--------------------------------------------------------------------------
1747:     * BtnGravarLeituraClick - Grava leitura: atualiza SigCqBal e marca balanco Grvs=1
1748:     *--------------------------------------------------------------------------
1749:     PROCEDURE BtnGravarLeituraClick()
1750:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_lContinuar
1751:         LOCAL loc_cCidChaveBal, loc_cBcoH, loc_cAgeH, loc_cCntH, loc_cChqH, loc_nTipH
1752: 
1753:         IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1754:             MsgAviso("Nenhum cheque na lista para gravar.", "")
1755:             RETURN
1756:         ENDIF
1757: 
1758:         IF !MsgConfirma("Confirma a grava" + CHR(231) + CHR(227) + "o da leitura?", "")
1759:             RETURN
1760:         ENDIF
1761: 
1762:         TRY
1763:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
1764:             loc_lContinuar = .T.
1765: 
1766:             *-- Carrega SigCqBal para obter cidchaves (padrao original: cursor local)
1767:             SQLEXEC(gnConnHandle, ;
1768:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1769:                 " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1770:                 "cursor_4c_BalCid")
1771: 
1772:             SELECT cursor_4c_Historico
1773:             GO TOP
1774: 
1775:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1776:                 loc_cBcoH = ALLTRIM(cursor_4c_Historico.bancos)
1777:                 loc_cAgeH = ALLTRIM(cursor_4c_Historico.agencias)
1778:                 loc_cCntH = ALLTRIM(cursor_4c_Historico.ncontas)
1779:                 loc_cChqH = ALLTRIM(cursor_4c_Historico.ncheques)
1780:                 loc_nTipH = cursor_4c_Historico.tipos
1781: 
1782:                 loc_cCidChaveBal = ""
1783:                 IF USED("cursor_4c_BalCid")
1784:                     SELECT cursor_4c_BalCid
1785:                     LOCATE FOR ALLTRIM(bancos) = loc_cBcoH AND ALLTRIM(agencias) = loc_cAgeH ;
1786:                         AND ALLTRIM(ncontas) = loc_cCntH AND ALLTRIM(ncheques) = loc_cChqH
1787:                     IF FOUND()
1788:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1789:                     ENDIF
1790:                 ENDIF
1791: 
1792:                 IF !EMPTY(loc_cCidChaveBal)
1793:                     IF loc_nTipH = 2
1794:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;

*-- Linhas 1831 a 1881:
1831:     *--------------------------------------------------------------------------
1832:     * BtnExcluirHistoricoClick - Remove cheque do historico e reseta SigCqBal
1833:     *--------------------------------------------------------------------------
1834:     PROCEDURE BtnExcluirHistoricoClick()
1835:         LOCAL loc_cSQL, loc_nResult
1836:         LOCAL loc_nCodigos, loc_cBancos, loc_cAgencias, loc_cNContas, loc_cNCheques, loc_nTipos
1837:         LOCAL loc_cCidChaveHis, loc_cCidChaveBal
1838: 
1839:         IF !USED("cursor_4c_Historico") OR EOF("cursor_4c_Historico") OR ;
1840:            RECCOUNT("cursor_4c_Historico") = 0
1841:             MsgAviso("Nenhum cheque selecionado.", "")
1842:             RETURN
1843:         ENDIF
1844: 
1845:         TRY
1846:             SELECT cursor_4c_Historico
1847:             loc_nCodigos     = cursor_4c_Historico.codigos
1848:             loc_cCidChaveHis = ALLTRIM(cursor_4c_Historico.cidchaves)
1849:             loc_cBancos      = ALLTRIM(cursor_4c_Historico.bancos)
1850:             loc_cAgencias    = ALLTRIM(cursor_4c_Historico.agencias)
1851:             loc_cNContas     = ALLTRIM(cursor_4c_Historico.ncontas)
1852:             loc_cNCheques    = ALLTRIM(cursor_4c_Historico.ncheques)
1853:             loc_nTipos       = cursor_4c_Historico.tipos
1854: 
1855:             loc_cSQL = "DELETE FROM SigCqHis WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveHis)
1856: 
1857:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1858:             IF loc_nResult < 0
1859:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1860:             ELSE
1861:                 *-- Localiza cidchaves em SigCqBal para resetar flag (padrao original: cursor local)
1862:                 loc_cCidChaveBal = ""
1863:                 SQLEXEC(gnConnHandle, ;
1864:                     "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1865:                     " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1866:                     "cursor_4c_BalCid")
1867:                 IF USED("cursor_4c_BalCid")
1868:                     SELECT cursor_4c_BalCid
1869:                     LOCATE FOR ALLTRIM(bancos) = loc_cBancos AND ALLTRIM(agencias) = loc_cAgencias ;
1870:                         AND ALLTRIM(ncontas) = loc_cNContas AND ALLTRIM(ncheques) = loc_cNCheques
1871:                     IF FOUND()
1872:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1873:                     ENDIF
1874:                     USE IN cursor_4c_BalCid
1875:                 ENDIF
1876: 
1877:                 IF !EMPTY(loc_cCidChaveBal)
1878:                     IF loc_nTipos = 2
1879:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1880:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1881:                     ELSE

*-- Linhas 1902 a 2095:
1902:     *--------------------------------------------------------------------------
1903:     * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
1904:     *--------------------------------------------------------------------------
1905:     PROCEDURE BtnCancelarLeituraClick()
1906:         IF MsgConfirma("Deseja Cancelar ???", "")
1907:             THIS.this_cModoAtual = "LISTA"
1908:             THIS.AlternarPagina(1)
1909:         ENDIF
1910:     ENDPROC
1911: 
1912:     *--------------------------------------------------------------------------
1913:     * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
1914:     *--------------------------------------------------------------------------
1915:     PROCEDURE HabilitarCampos(par_lHabilitar)
1916:         LOCAL loc_oPg2, loc_lEdicao
1917:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1918:         loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")
1919: 
1920:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1921:             loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR") AND par_lHabilitar
1922:         ENDIF
1923:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
1924:             loc_oPg2.cbo_4c_Operacao.Enabled = loc_lEdicao
1925:         ENDIF
1926:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
1927:             loc_oPg2.txt_4c_Oper.Enabled = loc_lEdicao
1928:         ENDIF
1929:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1930:             loc_oPg2.txt_4c_DataInicial.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1931:         ENDIF
1932:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1933:             loc_oPg2.txt_4c_DataFinal.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1934:         ENDIF
1935:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
1936:             loc_oPg2.txt_4c_Grupo.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1937:         ENDIF
1938:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
1939:             loc_oPg2.txt_4c_Conta.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1940:         ENDIF
1941: 
1942:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
1943:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1944:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1945:             ENDIF
1946:         ENDIF
1947:     ENDPROC
1948: 
1949:     *--------------------------------------------------------------------------
1950:     * LimparCampos - Limpa valores dos campos de edicao em Page2
1951:     *--------------------------------------------------------------------------
1952:     PROCEDURE LimparCampos()
1953:         LOCAL loc_oPg2
1954:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1955: 
1956:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1957:             loc_oPg2.txt_4c_Codigo.Value = ""
1958:         ENDIF
1959:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
1960:             loc_oPg2.cbo_4c_Operacao.Value = 1
1961:         ENDIF
1962:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
1963:             loc_oPg2.txt_4c_Oper.Value = ""
1964:         ENDIF
1965:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1966:             loc_oPg2.txt_4c_DataInicial.Value = {}
1967:         ENDIF
1968:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1969:             loc_oPg2.txt_4c_DataFinal.Value = {}
1970:         ENDIF
1971:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
1972:             loc_oPg2.txt_4c_Grupo.Value = ""
1973:         ENDIF
1974:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
1975:             loc_oPg2.txt_4c_DGrupo.Value = ""
1976:         ENDIF
1977:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
1978:             loc_oPg2.txt_4c_Conta.Value = ""
1979:         ENDIF
1980:         IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
1981:             loc_oPg2.txt_4c_DConta.Value = ""
1982:         ENDIF
1983:     ENDPROC
1984: 
1985:     *--------------------------------------------------------------------------
1986:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1987:     *--------------------------------------------------------------------------
1988:     PROCEDURE AjustarBotoesPorModo()
1989:         LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2, loc_lLista
1990:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1991:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1992:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
1993:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1994: 
1995:         IF VARTYPE(loc_oBotoes) = "O"
1996:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
1997:                 loc_oBotoes.cmd_4c_Incluir.Enabled = .T.
1998:             ENDIF
1999:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
2000:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
2001:             ENDIF
2002:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
2003:                 loc_oBotoes.cmd_4c_Alterar.Enabled = .T.
2004:             ENDIF
2005:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
2006:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
2007:             ENDIF
2008:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
2009:                 loc_oBotoes.cmd_4c_Buscar.Enabled = .T.
2010:             ENDIF
2011:         ENDIF
2012: 
2013:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
2014:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
2015:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
2016:             ENDIF
2017:         ENDIF
2018:     ENDPROC
2019: 
2020:     *--------------------------------------------------------------------------
2021:     * FormParaBO - Transfere dados dos campos do Form para o BO
2022:     *--------------------------------------------------------------------------
2023:     PROCEDURE FormParaBO()
2024:         LOCAL loc_oPg2
2025:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2026: 
2027:         WITH THIS.this_oBusinessObject
2028:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2029:                 .this_nCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
2030:             ENDIF
2031:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2032:                 .this_nTipos     = loc_oPg2.cbo_4c_Operacao.Value
2033:             ENDIF
2034:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2035:                 .this_cOperacaos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2036:             ENDIF
2037:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2038:                 .this_dDataInis  = loc_oPg2.txt_4c_DataInicial.Value
2039:             ENDIF
2040:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2041:                 .this_dDataFims  = loc_oPg2.txt_4c_DataFinal.Value
2042:             ENDIF
2043:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2044:                 .this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2045:             ENDIF
2046:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2047:                 .this_cContas    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2048:             ENDIF
2049:         ENDWITH
2050:     ENDPROC
2051: 
2052:     *--------------------------------------------------------------------------
2053:     * BOParaForm - Transfere dados do BO para os campos do Form
2054:     *--------------------------------------------------------------------------
2055:     PROCEDURE BOParaForm()
2056:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nResultado
2057:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2058: 
2059:         WITH THIS.this_oBusinessObject
2060:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2061:                 loc_oPg2.txt_4c_Codigo.Value      = TRANSFORM(.this_nCodigos)
2062:             ENDIF
2063:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2064:                 loc_oPg2.cbo_4c_Operacao.Value    = .this_nTipos
2065:             ENDIF
2066:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2067:                 loc_oPg2.txt_4c_Oper.Value        = ALLTRIM(.this_cOperacaos)
2068:             ENDIF
2069:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2070:                 loc_oPg2.txt_4c_DataInicial.Value = .this_dDataInis
2071:             ENDIF
2072:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2073:                 loc_oPg2.txt_4c_DataFinal.Value   = .this_dDataFims
2074:             ENDIF
2075:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2076:                 loc_oPg2.txt_4c_Grupo.Value       = ALLTRIM(.this_cGrupos)
2077:             ENDIF
2078:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2079:                 loc_oPg2.txt_4c_Conta.Value       = ALLTRIM(.this_cContas)
2080:             ENDIF
2081:             loc_cGrupo = ALLTRIM(.this_cGrupos)
2082:             loc_cConta = ALLTRIM(.this_cContas)
2083:         ENDWITH
2084: 
2085:         *-- Buscar descricoes de Grupo e Conta para exibicao
2086:         TRY
2087:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2088:                 IF !EMPTY(loc_cGrupo)
2089:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2090:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2091:                         "cursor_4c_DescGcr")
2092:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2093:                         SELECT cursor_4c_DescGcr
2094:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2095:                     ELSE

*-- Linhas 2135 a 2274:
2135:     *--------------------------------------------------------------------------
2136:     * ValidOper - Valid handler: lookup SigCdOpt por operacaos (code = char 15)
2137:     *--------------------------------------------------------------------------
2138:     PROCEDURE ValidOper(par_nKeyCode, par_nShiftAltCtrl)
2139:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2140:         loc_lResultado = .T.
2141:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2142: 
2143:         IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2144:             RETURN .T.
2145:         ENDIF
2146: 
2147:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2148: 
2149:         IF EMPTY(loc_cCodigo)
2150:             RETURN .T.
2151:         ENDIF
2152: 
2153:         TRY
2154:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2155:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2156:                 "cursor_4c_ChkOpt")
2157: 
2158:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2159:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2160:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2161:                     "Opera" + CHR(231) + CHR(227) + "o")
2162: 
2163:                 IF VARTYPE(loc_oBusca) = "O"
2164:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2165:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2166:                     loc_oBusca.Show()
2167: 
2168:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2169:                         SELECT cursor_4c_BuscaOpt
2170:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2171:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2172:                     ELSE
2173:                         loc_oPg2.txt_4c_Oper.Value = ""
2174:                     ENDIF
2175: 
2176:                     loc_oBusca.Release()
2177:                 ENDIF
2178:             ENDIF
2179: 
2180:             IF USED("cursor_4c_ChkOpt")
2181:                 USE IN cursor_4c_ChkOpt
2182:             ENDIF
2183:             IF USED("cursor_4c_BuscaOpt")
2184:                 USE IN cursor_4c_BuscaOpt
2185:             ENDIF
2186:         CATCH TO loc_oErro
2187:             MsgErro(loc_oErro.Message, "FormBch.ValidOper")
2188:             IF USED("cursor_4c_ChkOpt")
2189:                 USE IN cursor_4c_ChkOpt
2190:             ENDIF
2191:             IF USED("cursor_4c_BuscaOpt")
2192:                 USE IN cursor_4c_BuscaOpt
2193:             ENDIF
2194:         ENDTRY
2195: 
2196:         RETURN loc_lResultado
2197:     ENDPROC
2198: 
2199:     *--------------------------------------------------------------------------
2200:     * ValidGrupo - Valid handler: lookup SigCdGcr por codigos, preenche DGrupo
2201:     *--------------------------------------------------------------------------
2202:     PROCEDURE ValidGrupo(par_nKeyCode, par_nShiftAltCtrl)
2203:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2204:         loc_lResultado = .T.
2205:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2206: 
2207:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2208:             RETURN .T.
2209:         ENDIF
2210: 
2211:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2212: 
2213:         IF EMPTY(loc_cCodigo)
2214:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2215:                 loc_oPg2.txt_4c_DGrupo.Value = ""
2216:             ENDIF
2217:             RETURN .T.
2218:         ENDIF
2219: 
2220:         TRY
2221:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2222:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2223:                 "cursor_4c_ChkGcr")
2224: 
2225:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2226:                 SELECT cursor_4c_ChkGcr
2227:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2228:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2229:                 ENDIF
2230:             ELSE
2231:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2232:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2233:                 ENDIF
2234:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2235:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2236: 
2237:                 IF VARTYPE(loc_oBusca) = "O"
2238:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2239:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2240:                     loc_oBusca.Show()
2241: 
2242:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2243:                         SELECT cursor_4c_BuscaGcr
2244:                         IF !EOF("cursor_4c_BuscaGcr")
2245:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2246:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2247:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2248:                             ENDIF
2249:                         ELSE
2250:                             loc_oPg2.txt_4c_Grupo.Value = ""
2251:                         ENDIF
2252:                     ELSE
2253:                         loc_oPg2.txt_4c_Grupo.Value = ""
2254:                     ENDIF
2255: 
2256:                     loc_oBusca.Release()
2257:                 ENDIF
2258:             ENDIF
2259: 
2260:             IF USED("cursor_4c_ChkGcr")
2261:                 USE IN cursor_4c_ChkGcr
2262:             ENDIF
2263:             IF USED("cursor_4c_BuscaGcr")
2264:                 USE IN cursor_4c_BuscaGcr
2265:             ENDIF
2266:         CATCH TO loc_oErro
2267:             MsgErro(loc_oErro.Message, "FormBch.ValidGrupo")
2268:             IF USED("cursor_4c_ChkGcr")
2269:                 USE IN cursor_4c_ChkGcr
2270:             ENDIF
2271:             IF USED("cursor_4c_BuscaGcr")
2272:                 USE IN cursor_4c_BuscaGcr
2273:             ENDIF
2274:         ENDTRY

*-- Linhas 2280 a 2415:
2280:     * ValidDGrupo - Valid handler: busca reversa SigCdGcr por descrs
2281:     * Ativo apenas quando txt_4c_Grupo estiver vazio em modo INCLUIR
2282:     *--------------------------------------------------------------------------
2283:     PROCEDURE ValidDGrupo(par_nKeyCode, par_nShiftAltCtrl)
2284:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2285:         loc_lResultado = .T.
2286:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2287: 
2288:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2289:             RETURN .T.
2290:         ENDIF
2291: 
2292:         *-- Somente busca reversa quando Grupo estiver vazio
2293:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
2294:             RETURN .T.
2295:         ENDIF
2296: 
2297:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value))
2298:             RETURN .T.
2299:         ENDIF
2300: 
2301:         TRY
2302:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2303:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")
2304: 
2305:             IF VARTYPE(loc_oBusca) = "O"
2306:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2307:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2308:                 loc_oBusca.Show()
2309: 
2310:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2311:                     SELECT cursor_4c_BuscaGcr
2312:                     IF !EOF("cursor_4c_BuscaGcr")
2313:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2314:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2315:                         ENDIF
2316:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2317:                     ELSE
2318:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2319:                     ENDIF
2320:                 ELSE
2321:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2322:                 ENDIF
2323: 
2324:                 loc_oBusca.Release()
2325:             ENDIF
2326: 
2327:             IF USED("cursor_4c_BuscaGcr")
2328:                 USE IN cursor_4c_BuscaGcr
2329:             ENDIF
2330:         CATCH TO loc_oErro
2331:             MsgErro(loc_oErro.Message, "FormBch.ValidDGrupo")
2332:             IF USED("cursor_4c_BuscaGcr")
2333:                 USE IN cursor_4c_BuscaGcr
2334:             ENDIF
2335:         ENDTRY
2336: 
2337:         RETURN loc_lResultado
2338:     ENDPROC
2339: 
2340:     *--------------------------------------------------------------------------
2341:     * ValidConta - Valid handler: lookup SIGCDCLI por iclis, preenche DConta
2342:     *--------------------------------------------------------------------------
2343:     PROCEDURE ValidConta(par_nKeyCode, par_nShiftAltCtrl)
2344:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2345:         loc_lResultado = .T.
2346:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2347: 
2348:         IF VARTYPE(loc_oPg2.txt_4c_Conta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2349:             RETURN .T.
2350:         ENDIF
2351: 
2352:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2353: 
2354:         IF EMPTY(loc_cCodigo)
2355:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2356:                 loc_oPg2.txt_4c_DConta.Value = ""
2357:             ENDIF
2358:             RETURN .T.
2359:         ENDIF
2360: 
2361:         TRY
2362:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2363:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2364:                 "cursor_4c_ChkCli")
2365: 
2366:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2367:                 SELECT cursor_4c_ChkCli
2368:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2369:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2370:                 ENDIF
2371:             ELSE
2372:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2373:                     loc_oPg2.txt_4c_DConta.Value = ""
2374:                 ENDIF
2375:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2376:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2377: 
2378:                 IF VARTYPE(loc_oBusca) = "O"
2379:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2380:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2381:                     loc_oBusca.Show()
2382: 
2383:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2384:                         SELECT cursor_4c_BuscaCli
2385:                         IF !EOF("cursor_4c_BuscaCli")
2386:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2387:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2388:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2389:                             ENDIF
2390:                         ELSE
2391:                             loc_oPg2.txt_4c_Conta.Value = ""
2392:                         ENDIF
2393:                     ELSE
2394:                         loc_oPg2.txt_4c_Conta.Value = ""
2395:                     ENDIF
2396: 
2397:                     loc_oBusca.Release()
2398:                 ENDIF
2399:             ENDIF
2400: 
2401:             IF USED("cursor_4c_ChkCli")
2402:                 USE IN cursor_4c_ChkCli
2403:             ENDIF
2404:             IF USED("cursor_4c_BuscaCli")
2405:                 USE IN cursor_4c_BuscaCli
2406:             ENDIF
2407:         CATCH TO loc_oErro
2408:             MsgErro(loc_oErro.Message, "FormBch.ValidConta")
2409:             IF USED("cursor_4c_ChkCli")
2410:                 USE IN cursor_4c_ChkCli
2411:             ENDIF
2412:             IF USED("cursor_4c_BuscaCli")
2413:                 USE IN cursor_4c_BuscaCli
2414:             ENDIF
2415:         ENDTRY

*-- Linhas 2421 a 2568:
2421:     * ValidDConta - Valid handler: busca reversa SIGCDCLI por razaos
2422:     * Ativo apenas quando txt_4c_Conta estiver vazio em modo INCLUIR
2423:     *--------------------------------------------------------------------------
2424:     PROCEDURE ValidDConta(par_nKeyCode, par_nShiftAltCtrl)
2425:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2426:         loc_lResultado = .T.
2427:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2428: 
2429:         IF VARTYPE(loc_oPg2.txt_4c_DConta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2430:             RETURN .T.
2431:         ENDIF
2432: 
2433:         *-- Somente busca reversa quando Conta estiver vazia
2434:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
2435:             RETURN .T.
2436:         ENDIF
2437: 
2438:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DConta.Value))
2439:             RETURN .T.
2440:         ENDIF
2441: 
2442:         TRY
2443:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2444:                 "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", "Conta")
2445: 
2446:             IF VARTYPE(loc_oBusca) = "O"
2447:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2448:                 loc_oBusca.mAddColuna("razaos", "", "Nome")
2449:                 loc_oBusca.Show()
2450: 
2451:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2452:                     SELECT cursor_4c_BuscaCli
2453:                     IF !EOF("cursor_4c_BuscaCli")
2454:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2455:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2456:                         ENDIF
2457:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2458:                     ELSE
2459:                         loc_oPg2.txt_4c_DConta.Value = ""
2460:                     ENDIF
2461:                 ELSE
2462:                     loc_oPg2.txt_4c_DConta.Value = ""
2463:                 ENDIF
2464: 
2465:                 loc_oBusca.Release()
2466:             ENDIF
2467: 
2468:             IF USED("cursor_4c_BuscaCli")
2469:                 USE IN cursor_4c_BuscaCli
2470:             ENDIF
2471:         CATCH TO loc_oErro
2472:             MsgErro(loc_oErro.Message, "FormBch.ValidDConta")
2473:             IF USED("cursor_4c_BuscaCli")
2474:                 USE IN cursor_4c_BuscaCli
2475:             ENDIF
2476:         ENDTRY
2477: 
2478:         RETURN loc_lResultado
2479:     ENDPROC
2480: 
2481:     *--------------------------------------------------------------------------
2482:     * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
2483:     *--------------------------------------------------------------------------
2484:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2485:         LOCAL loc_i, loc_oControl, loc_nP
2486: 
2487:         IF VARTYPE(par_oContainer) != "O"
2488:             RETURN
2489:         ENDIF
2490: 
2491:         FOR loc_i = 1 TO par_oContainer.ControlCount
2492:             loc_oControl = par_oContainer.Controls(loc_i)
2493: 
2494:             IF VARTYPE(loc_oControl) = "O"
2495:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2496:                     IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
2497:                         loc_oControl.Visible = .T.
2498:                     ENDIF
2499:                 ENDIF
2500: 
2501:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2502:                     FOR loc_nP = 1 TO loc_oControl.PageCount
2503:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
2504:                     ENDFOR
2505:                 ENDIF
2506: 
2507:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2508:                     THIS.TornarControlesVisiveis(loc_oControl)
2509:                 ENDIF
2510:             ENDIF
2511:         ENDFOR
2512:     ENDPROC
2513: 
2514:     *--------------------------------------------------------------------------
2515:     * CarregarLeitura - Popula Page3 quando entra no modo LEITURA
2516:     *--------------------------------------------------------------------------
2517:     PROTECTED PROCEDURE CarregarLeitura()
2518:         LOCAL loc_nCodigos
2519:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
2520:         THIS.PopularCamposLeitura()
2521:         THIS.CarregarGradeLeitura(loc_nCodigos)
2522:         THIS.LimparCamposLeitura()
2523:     ENDPROC
2524: 
2525:     *--------------------------------------------------------------------------
2526:     * PopularCamposLeitura - Preenche campos readonly da Page3 com dados do BO
2527:     *--------------------------------------------------------------------------
2528:     PROTECTED PROCEDURE PopularCamposLeitura()
2529:         LOCAL loc_oPg3, loc_oBO, loc_cGrupo, loc_cConta, loc_cOperacaos, loc_nResultado
2530:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2531:         loc_oBO  = THIS.this_oBusinessObject
2532: 
2533:         WITH loc_oBO
2534:             IF VARTYPE(loc_oPg3.txt_4c_CodDisp) = "O"
2535:                 loc_oPg3.txt_4c_CodDisp.Value    = TRANSFORM(.this_nCodigos)
2536:             ENDIF
2537:             IF VARTYPE(loc_oPg3.txt_4c_OperDisp) = "O"
2538:                 loc_oPg3.txt_4c_OperDisp.Value   = ALLTRIM(.this_cOperacaos)
2539:             ENDIF
2540:             IF VARTYPE(loc_oPg3.txt_4c_DataIniDisp) = "O"
2541:                 loc_oPg3.txt_4c_DataIniDisp.Value = .this_dDataInis
2542:             ENDIF
2543:             IF VARTYPE(loc_oPg3.txt_4c_DataFimDisp) = "O"
2544:                 loc_oPg3.txt_4c_DataFimDisp.Value = .this_dDataFims
2545:             ENDIF
2546:             IF VARTYPE(loc_oPg3.txt_4c_GrupoDisp) = "O"
2547:                 loc_oPg3.txt_4c_GrupoDisp.Value  = ALLTRIM(.this_cGrupos)
2548:             ENDIF
2549:             IF VARTYPE(loc_oPg3.txt_4c_ContaDisp) = "O"
2550:                 loc_oPg3.txt_4c_ContaDisp.Value  = ALLTRIM(.this_cContas)
2551:             ENDIF
2552:             loc_cGrupo     = ALLTRIM(.this_cGrupos)
2553:             loc_cConta     = ALLTRIM(.this_cContas)
2554:             loc_cOperacaos = ALLTRIM(.this_cOperacaos)
2555:         ENDWITH
2556: 
2557:         TRY
2558:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2559:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2560:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2561:                     "cursor_4c_DescGcr")
2562:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2563:                     SELECT cursor_4c_DescGcr
2564:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2565:                 ELSE
2566:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2567:                 ENDIF
2568:                 IF USED("cursor_4c_DescGcr")

*-- Linhas 2617 a 2795:
2617:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2618:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2619:     *--------------------------------------------------------------------------
2620:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2621:         LOCAL loc_cSQL, loc_nResultado
2622: 
2623:         TRY
2624:             IF !USED("cursor_4c_Historico")
2625:                 SET NULL ON
2626:                 CREATE CURSOR cursor_4c_Historico ;
2627:                     (cidchaves C(20), codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2628:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2629:                      valors N(14,2), vencs D)
2630:                 SET NULL OFF
2631:             ENDIF
2632: 
2633:             loc_cSQL = "SELECT cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2634:                        " usuarios, valors, vencs" + ;
2635:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2636:                        " ORDER BY datas, ncheques"
2637: 
2638:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2639: 
2640:             IF loc_nResultado >= 0
2641:                 SELECT cursor_4c_Historico
2642:                 ZAP
2643:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2644:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2645:                 ENDIF
2646:                 IF USED("cursor_4c_HistoricoTemp")
2647:                     USE IN cursor_4c_HistoricoTemp
2648:                 ENDIF
2649:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2650:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2651:                 ENDIF
2652:             ELSE
2653:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2654:             ENDIF
2655:         CATCH TO loc_oErro
2656:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2657:             IF USED("cursor_4c_HistoricoTemp")
2658:                 USE IN cursor_4c_HistoricoTemp
2659:             ENDIF
2660:         ENDTRY
2661:     ENDPROC
2662: 
2663:     *--------------------------------------------------------------------------
2664:     * LimparCamposLeitura - Limpa campos de entrada manual da Page3
2665:     *--------------------------------------------------------------------------
2666:     PROTECTED PROCEDURE LimparCamposLeitura()
2667:         LOCAL loc_oPg3
2668:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2669: 
2670:         IF VARTYPE(loc_oPg3.txt_4c_Bco) = "O"
2671:             loc_oPg3.txt_4c_Bco.Value = ""
2672:         ENDIF
2673:         IF VARTYPE(loc_oPg3.txt_4c_Age) = "O"
2674:             loc_oPg3.txt_4c_Age.Value = ""
2675:         ENDIF
2676:         IF VARTYPE(loc_oPg3.txt_4c_ContaLei) = "O"
2677:             loc_oPg3.txt_4c_ContaLei.Value = ""
2678:         ENDIF
2679:         IF VARTYPE(loc_oPg3.txt_4c_Num) = "O"
2680:             loc_oPg3.txt_4c_Num.Value = ""
2681:         ENDIF
2682:         IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2683:             loc_oPg3.txt_4c_Valor.Value = 0
2684:         ENDIF
2685:         IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2686:             loc_oPg3.txt_4c_Vecto.Value = {}
2687:         ENDIF
2688:     ENDPROC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * NumGetLostFocus - Valida cheque em SigCqBal e insere em SigCqHis
2692:     *--------------------------------------------------------------------------
2693:     PROCEDURE NumGetLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2694:         LOCAL loc_oPg3, loc_cBco, loc_cAge, loc_cConta, loc_cNum
2695:         LOCAL loc_nCodigos, loc_nTipos, loc_cSQL, loc_nResultado
2696:         LOCAL loc_nValor, loc_dVecto, loc_lContinuar, loc_cCidChaveHis
2697:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2698: 
2699:         IF VARTYPE(loc_oPg3.txt_4c_Bco) != "O" OR ;
2700:            VARTYPE(loc_oPg3.txt_4c_Age) != "O" OR ;
2701:            VARTYPE(loc_oPg3.txt_4c_ContaLei) != "O" OR ;
2702:            VARTYPE(loc_oPg3.txt_4c_Num) != "O"
2703:             RETURN
2704:         ENDIF
2705: 
2706:         loc_cBco   = ALLTRIM(loc_oPg3.txt_4c_Bco.Value)
2707:         loc_cAge   = ALLTRIM(loc_oPg3.txt_4c_Age.Value)
2708:         loc_cConta = ALLTRIM(loc_oPg3.txt_4c_ContaLei.Value)
2709:         loc_cNum   = ALLTRIM(loc_oPg3.txt_4c_Num.Value)
2710: 
2711:         IF EMPTY(loc_cNum) OR EMPTY(loc_cBco) OR EMPTY(loc_cAge) OR EMPTY(loc_cConta)
2712:             RETURN
2713:         ENDIF
2714: 
2715:         TRY
2716:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
2717:             loc_lContinuar = .T.
2718:             IF VARTYPE(loc_oPg3.opt_4c_TipoLeitura) = "O"
2719:                 loc_nTipos = loc_oPg3.opt_4c_TipoLeitura.Value
2720:             ELSE
2721:                 loc_nTipos = 1
2722:             ENDIF
2723: 
2724:             *-- Carrega SigCqBal para verificar cheque (padrao original: cursor local)
2725:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2726:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques, valors, vencs" + ;
2727:                 " FROM SigCqBal WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
2728:                 "cursor_4c_BalDisp")
2729: 
2730:             *-- Verificar se cheque existe no balanco (LOCATE em cursor local)
2731:             IF loc_nResultado >= 0 AND USED("cursor_4c_BalDisp")
2732:                 SELECT cursor_4c_BalDisp
2733:                 LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2734:                     AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2735:                 IF FOUND()
2736:                     loc_nValor = TratarNulo(valors, "N")
2737:                     loc_dVecto = TratarNulo(vencs,  "D")
2738:                 ELSE
2739:                     MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2740:                     loc_lContinuar = .F.
2741:                 ENDIF
2742:                 USE IN cursor_4c_BalDisp
2743:             ELSE
2744:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2745:                 loc_lContinuar = .F.
2746:             ENDIF
2747: 
2748:             IF loc_lContinuar
2749:                 *-- Verificar duplicidade no historico (LOCATE em cursor local)
2750:                 IF USED("cursor_4c_Historico")
2751:                     SELECT cursor_4c_Historico
2752:                     LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2753:                         AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2754:                     IF FOUND()
2755:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2756:                         loc_lContinuar = .F.
2757:                     ENDIF
2758:                 ENDIF
2759:             ENDIF
2760: 
2761:             IF loc_lContinuar
2762:                 *-- Gerar cidchaves para SigCqHis
2763:                 loc_cCidChaveHis = ""
2764:                 loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", ;
2765:                     "cursor_4c_Uuid")
2766:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
2767:                     SELECT cursor_4c_Uuid
2768:                     loc_cCidChaveHis = ALLTRIM(cursor_4c_Uuid.novo_uuid)
2769:                 ENDIF
2770:                 IF USED("cursor_4c_Uuid")
2771:                     USE IN cursor_4c_Uuid
2772:                 ENDIF
2773: 
2774:                 *-- Inserir no historico de leitura
2775:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2776:                            " (cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2777:                            " VALUES (" + ;
2778:                            EscaparSQL(loc_cCidChaveHis) + "," + ;
2779:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2780:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2781:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2782:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2783:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2784:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2785:                            "GETDATE()," + ;
2786:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2787:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2788:                            FormatarDataSQL(loc_dVecto) + ;
2789:                            ")"
2790: 
2791:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2792: 
2793:                 IF loc_nResultado >= 0
2794:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2795:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor

*-- Linhas 2817 a 2864:
2817:     *--------------------------------------------------------------------------
2818:     * FormatarGridLista - Formata Grid da lista apos carregar dados
2819:     *--------------------------------------------------------------------------
2820:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2821:         IF VARTYPE(par_oGrid) != "O"
2822:             RETURN
2823:         ENDIF
2824: 
2825:         WITH par_oGrid
2826:             .FontName = "Verdana"
2827:             .FontSize = 8
2828:         ENDWITH
2829:     ENDPROC
2830: 
2831:     *--------------------------------------------------------------------------
2832:     * Destroy - Libera recursos do form
2833:     *--------------------------------------------------------------------------
2834:     PROCEDURE Destroy()
2835:         LOCAL loc_oErro
2836: 
2837:         TRY
2838:             IF USED("cursor_4c_Dados")
2839:                 USE IN cursor_4c_Dados
2840:             ENDIF
2841:             IF USED("cursor_4c_Historico")
2842:                 USE IN cursor_4c_Historico
2843:             ENDIF
2844:             IF USED("cursor_4c_HistoricoTemp")
2845:                 USE IN cursor_4c_HistoricoTemp
2846:             ENDIF
2847:             IF USED("Balanco")
2848:                 USE IN Balanco
2849:             ENDIF
2850:             IF USED("Historico")
2851:                 USE IN Historico
2852:             ENDIF
2853: 
2854:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2855:                 THIS.this_oBusinessObject = .NULL.
2856:             ENDIF
2857:         CATCH TO loc_oErro
2858:             MsgErro(loc_oErro.Message, "FormBch.Destroy")
2859:         ENDTRY
2860: 
2861:         DODEFAULT()
2862:     ENDPROC
2863: 
2864: ENDDEFINE


### BO (C:\4c\projeto\app\classes\BchBO.prg):
*====================================================================
* BchBO.prg
*
* Business Object para Balanco de Cheques
* Tabela: SigCdBch
* PK: Codigos (numeric 6,0)
*
* Colunas (schema.sql):
*   operacaos  char(15)      NOT NULL
*   codigos    numeric(6,0)  NOT NULL  <- PK
*   datafims   datetime      NULL
*   datainis   datetime      NULL
*   encerras   bit           NOT NULL
*   tipos      numeric(1,0)  NOT NULL
*   grupos     char(10)      NOT NULL
*   contas     char(10)      NOT NULL
*   grvs       bit           NOT NULL
*====================================================================

DEFINE CLASS BchBO AS BusinessBase

	*-- Propriedades da tabela SigCdBch
	this_nCodigos  = 0
	this_cOperacaos = ""
	this_dDataInis = {}
	this_dDataFims = {}
	this_lEncerras = .F.
	this_nTipos    = 0
	this_cGrupos   = ""
	this_cContas   = ""
	this_lGrvs     = .F.

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdBch"
			THIS.this_cCampoChave = "Codigos"
			loc_lResultado = .T.
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Busca registros de SigCdBch
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch" + loc_cWhere + " ORDER BY codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros de Balan" + CHR(231) + "o de Cheques: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "SELECT codigos, operacaos, datainis, datafims, tipos," + ;
					   " grupos, contas, encerras, grvs" + ;
					   " FROM SigCdBch WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_nCodigos   = TratarNulo(codigos,   "N")
				THIS.this_cOperacaos = TratarNulo(operacaos, "C")
				THIS.this_dDataInis  = TratarNulo(datainis,  "D")
				THIS.this_dDataFims  = TratarNulo(datafims,  "D")
				THIS.this_nTipos     = TratarNulo(tipos,     "N")
				THIS.this_cGrupos    = TratarNulo(grupos,    "C")
				THIS.this_cContas    = TratarNulo(contas,    "C")
				THIS.this_lEncerras  = ConverterParaLogico(encerras)
				THIS.this_lGrvs      = ConverterParaLogico(grvs)
				loc_lResultado = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nNovoCodigo
		loc_lResultado = .F.

		TRY
			*-- Gerar novo codigo (PK)
			loc_nResultado = SQLEXEC(gnConnHandle, ;
				"SELECT ISNULL(MAX(codigos),0)+1 AS proximo FROM SigCdBch", ;
				"cursor_4c_ProxCod")

			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nNovoCodigo = proximo
			ELSE
				loc_nNovoCodigo = 1
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF

			THIS.this_nCodigos = loc_nNovoCodigo

			loc_cSQL = "INSERT INTO SigCdBch" + ;
					   " (codigos, operacaos, datainis, datafims, tipos," + ;
					   "  grupos, contas, encerras, grvs)" + ;
					   " VALUES (" + ;
					   FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   IIF(THIS.this_lGrvs, "1", "0") + ;
					   ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro em SigCdBch
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET" + ;
					   " operacaos = " + EscaparSQL(LEFT(THIS.this_cOperacaos, 15)) + "," + ;
					   " datainis  = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
					   " datafims  = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
					   " tipos     = " + FormatarNumeroSQL(THIS.this_nTipos) + "," + ;
					   " grupos    = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
					   " contas    = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
					   " encerras  = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
					   " grvs      = " + IIF(THIS.this_lGrvs, "1", "0") + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdBch
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
					"vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			THIS.RegistrarAuditoria("DELETE")

			loc_cSQL = "DELETE FROM SigCdBch WHERE codigos = " + ;
					   FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* EncerrarBalanco - Encerra o balanco de cheques (DataFims + Encerras=.T.)
	*====================================================================
	PROCEDURE EncerrarBalanco()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		IF THIS.this_lEncerras
			MsgErro("Balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "UPDATE SigCdBch SET datafims = GETDATE(), encerras = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lEncerras = .T.
				THIS.this_dDataFims = DATE()
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao encerrar balan" + CHR(231) + "o: " + ;
						CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* MarcarGravado - Define Grvs=1 em SigCdBch apos gravar leitura
	*====================================================================
	PROCEDURE MarcarGravado()
		LOCAL loc_cSQL, loc_nResultado, loc_lResultado
		loc_lResultado = .F.

		TRY
			loc_cSQL = "UPDATE SigCdBch SET grvs = 1" + ;
					   " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.this_lGrvs = .T.
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao marcar gravado: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

