# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (15)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2926 linhas total):

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

*-- Linhas 1360 a 1445:
1360:             .SpecialEffect   = 0
1361:             .Visible         = .T.
1362:         ENDWITH
1363:         BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirHistoricoClick")
1364: 
1365:         loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
1366:         WITH loc_oPg3.cmd_4c_Confirmar
1367:             .Top             = 31
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
1388:             .Top             = 31
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
1407:         *======================================================
1408:         * 8. Grade de historico de leitura (grd_4c_Leitura)
1409:         *    Banco, Agencia, No Conta, No Cheque, Vencimento, Valor
1410:         *======================================================
1411:         loc_oPg3.AddObject("grd_4c_leitura2", "Grid")
1412:         loc_oGrid = loc_oPg3.grd_4c_leitura2
1413:         loc_oGrid.ColumnCount = 6
1414:         WITH loc_oGrid
1415:             .Top                = 532
1416:             .Left               = 30
1417:             .Width              = 770
1418:             .Height             = 120
1419:             .FontName           = "Verdana"
1420:             .FontSize           = 8
1421:             .ForeColor          = RGB(90, 90, 90)
1422:             .BackColor          = RGB(255, 255, 255)
1423:             .GridLineColor      = RGB(238, 238, 238)
1424:             .HighlightBackColor = RGB(255, 255, 255)
1425:             .HighlightForeColor = RGB(15, 41, 104)
1426:             .HighlightStyle     = 2
1427:             .DeleteMark         = .F.
1428:             .RecordMark         = .F.
1429:             .RowHeight          = 16
1430:             .ScrollBars         = 2
1431:             .GridLines          = 3
1432:             .ReadOnly           = .T.
1433:             .Visible            = .T.
1434:         ENDWITH
1435: 
1436:         WITH loc_oGrid.Column1
1437:             .Width           = 80
1438:             .ControlSource   = "cursor_4c_Historico.bancos"
1439:             .Header1.Caption = "Banco"
1440:         ENDWITH
1441:         WITH loc_oGrid.Column2
1442:             .Width           = 80
1443:             .ControlSource   = "cursor_4c_Historico.agencias"
1444:             .Header1.Caption = "Ag" + CHR(234) + "ncia"
1445:         ENDWITH

*-- Linhas 1464 a 1513:
1464:             .Header1.Caption = "Valor"
1465:         ENDWITH
1466: 
1467:         THIS.TornarControlesVisiveis(loc_oPg3)
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * CarregarLista - Carrega registros de SigCdBch no grid da Page1
1472:     *--------------------------------------------------------------------------
1473:     PROCEDURE CarregarLista()
1474:         LOCAL loc_lResultado, loc_oGrid
1475:         loc_lResultado = .F.
1476: 
1477:         TRY
1478:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1479:                 loc_lResultado = .T.
1480:             ELSE
1481:                 IF !THIS.this_oBusinessObject.Buscar("")
1482:                     loc_lResultado = .F.
1483:                 ELSE
1484:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1485:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1486: 
1487:                         loc_oGrid.ColumnCount = 6
1488:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1489: 
1490:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1491:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1492:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1493:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1494:                         loc_oGrid.Column4.ControlSource = ;
1495:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1496:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1497:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1498:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1499:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1500: 
1501:                         *-- Reconfigurar headers (RecordSource reseta captions)
1502:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1503:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1504:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1505:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1506:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1507:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1508: 
1509:                         THIS.FormatarGridLista(loc_oGrid)
1510:                     ENDIF
1511:                     loc_lResultado = .T.
1512:                 ENDIF
1513:             ENDIF

*-- Linhas 1521 a 1854:
1521:     *--------------------------------------------------------------------------
1522:     * AlternarPagina - Alterna entre as 3 paginas do PageFrame
1523:     *--------------------------------------------------------------------------
1524:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1525:         LOCAL loc_lResultado
1526:         loc_lResultado = .F.
1527: 
1528:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
1529:             RETURN .F.
1530:         ENDIF
1531: 
1532:         TRY
1533:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1534: 
1535:             DO CASE
1536:             CASE par_nPagina = 1
1537:                 THIS.this_cModoAtual = "LISTA"
1538:                 THIS.CarregarLista()
1539:             CASE par_nPagina = 2
1540:                 *-- modo definido pelo chamador (INCLUIR/ALTERAR/VISUALIZAR)
1541:             CASE par_nPagina = 3
1542:                 THIS.this_cModoAtual = "LEITURA"
1543:                 THIS.CarregarLeitura()
1544:             ENDCASE
1545: 
1546:             loc_lResultado = .T.
1547:         CATCH TO loc_oErro
1548:             MsgErro(loc_oErro.Message, "FormBch.AlternarPagina")
1549:         ENDTRY
1550: 
1551:         RETURN loc_lResultado
1552:     ENDPROC
1553: 
1554:     *--------------------------------------------------------------------------
1555:     * BtnEncerrarClick - Fecha o formulario
1556:     *--------------------------------------------------------------------------
1557:     PROCEDURE BtnEncerrarClick()
1558:         THIS.Release()
1559:     ENDPROC
1560: 
1561:     *--------------------------------------------------------------------------
1562:     * BtnIncluirClick - Inicia inclusao de novo balanco
1563:     *--------------------------------------------------------------------------
1564:     PROCEDURE BtnIncluirClick()
1565:         THIS.this_oBusinessObject.NovoRegistro()
1566:         THIS.LimparCampos()
1567:         THIS.this_cModoAtual = "INCLUIR"
1568:         THIS.HabilitarCampos(.T.)
1569:         THIS.AjustarBotoesPorModo()
1570:         THIS.AlternarPagina(2)
1571:     ENDPROC
1572: 
1573:     *--------------------------------------------------------------------------
1574:     * BtnVisualizarClick - Visualiza balanco selecionado (somente leitura)
1575:     *--------------------------------------------------------------------------
1576:     PROCEDURE BtnVisualizarClick()
1577:         LOCAL loc_nCodigo
1578: 
1579:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1580:             MsgAviso("Selecione um registro na lista.", "")
1581:             RETURN
1582:         ENDIF
1583: 
1584:         SELECT cursor_4c_Dados
1585:         loc_nCodigo = cursor_4c_Dados.codigos
1586: 
1587:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1588:             THIS.this_cModoAtual = "VISUALIZAR"
1589:             THIS.BOParaForm()
1590:             THIS.HabilitarCampos(.F.)
1591:             THIS.AjustarBotoesPorModo()
1592:             THIS.AlternarPagina(2)
1593:         ENDIF
1594:     ENDPROC
1595: 
1596:     *--------------------------------------------------------------------------
1597:     * BtnAlterarClick - Edita balanco selecionado
1598:     *--------------------------------------------------------------------------
1599:     PROCEDURE BtnAlterarClick()
1600:         LOCAL loc_nCodigo
1601: 
1602:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1603:             MsgAviso("Selecione um registro na lista.", "")
1604:             RETURN
1605:         ENDIF
1606: 
1607:         SELECT cursor_4c_Dados
1608: 
1609:         IF cursor_4c_Dados.encerras
1610:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1611:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1612:             RETURN
1613:         ENDIF
1614: 
1615:         loc_nCodigo = cursor_4c_Dados.codigos
1616: 
1617:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1618:             THIS.this_oBusinessObject.EditarRegistro()
1619:             THIS.this_cModoAtual = "ALTERAR"
1620:             THIS.BOParaForm()
1621:             THIS.HabilitarCampos(.T.)
1622:             THIS.AjustarBotoesPorModo()
1623:             THIS.AlternarPagina(2)
1624:         ENDIF
1625:     ENDPROC
1626: 
1627:     *--------------------------------------------------------------------------
1628:     * BtnExcluirClick - Exclui balanco selecionado
1629:     *--------------------------------------------------------------------------
1630:     PROCEDURE BtnExcluirClick()
1631:         LOCAL loc_nCodigo
1632: 
1633:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1634:             MsgAviso("Selecione um registro para excluir.", "")
1635:             RETURN
1636:         ENDIF
1637: 
1638:         SELECT cursor_4c_Dados
1639: 
1640:         IF cursor_4c_Dados.encerras
1641:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1642:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1643:             RETURN
1644:         ENDIF
1645: 
1646:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1647:                         "Confirmar")
1648:             RETURN
1649:         ENDIF
1650: 
1651:         loc_nCodigo = cursor_4c_Dados.codigos
1652: 
1653:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1654:             IF THIS.this_oBusinessObject.Excluir()
1655:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1656:                 THIS.CarregarLista()
1657:             ENDIF
1658:         ENDIF
1659:     ENDPROC
1660: 
1661:     *--------------------------------------------------------------------------
1662:     * BtnBuscarClick - Busca registros de SigCdBch por FormBuscaAuxiliar
1663:     *--------------------------------------------------------------------------
1664:     PROCEDURE BtnBuscarClick()
1665:         LOCAL loc_oBusca, loc_nCodigo, loc_lResultado
1666:         loc_lResultado = .F.
1667: 
1668:         TRY
1669:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1670:                 "SigCdBch", "cursor_4c_BuscaBch", "codigos", "", ;
1671:                 "Balan" + CHR(231) + "o de Cheques")
1672: 
1673:             IF VARTYPE(loc_oBusca) = "O"
1674:                 loc_oBusca.mAddColuna("codigos",   "", "C" + CHR(243) + "digo")
1675:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
1676:                 loc_oBusca.mAddColuna("datainis",  "", "In" + CHR(237) + "cio")
1677:                 loc_oBusca.mAddColuna("datafims",  "", "T" + CHR(233) + "rmino")
1678:                 loc_oBusca.Show()
1679: 
1680:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1681:                     SELECT cursor_4c_BuscaBch
1682:                     IF !EOF("cursor_4c_BuscaBch")
1683:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1684:                         THIS.this_oBusinessObject.Buscar( ;
1685:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1686:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1687:                             THIS.CarregarLista()
1688:                         ENDIF
1689:                     ENDIF
1690:                 ELSE
1691:                     THIS.CarregarLista()
1692:                 ENDIF
1693: 
1694:                 loc_oBusca.Release()
1695:             ENDIF
1696:         CATCH TO loc_oErro
1697:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1698:         ENDTRY
1699: 
1700:         IF USED("cursor_4c_BuscaBch")
1701:             USE IN cursor_4c_BuscaBch
1702:         ENDIF
1703:     ENDPROC
1704: 
1705:     *--------------------------------------------------------------------------
1706:     * BtnSalvarClick - Salva registro (cmd_4c_Confirmar em Page2)
1707:     *--------------------------------------------------------------------------
1708:     PROCEDURE BtnSalvarClick()
1709:         LOCAL loc_oPg2
1710:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1711: 
1712:         *-- Validacoes fora do TRY para que RETURN funcione
1713:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1714:             IF EMPTY(loc_oPg2.txt_4c_DataInicial.Value)
1715:                 MsgAviso("Data Inicial obrigat" + CHR(243) + "ria!", "")
1716:                 RETURN
1717:             ENDIF
1718:         ENDIF
1719: 
1720:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1721:             IF EMPTY(loc_oPg2.txt_4c_DataFinal.Value)
1722:                 MsgAviso("Data Final obrigat" + CHR(243) + "ria!", "")
1723:                 RETURN
1724:             ENDIF
1725:         ENDIF
1726: 
1727:         THIS.FormParaBO()
1728: 
1729:         IF THIS.this_oBusinessObject.Salvar()
1730:             MsgInfo("Registro salvo com sucesso!", "")
1731:             THIS.this_cModoAtual = "LISTA"
1732:             THIS.AlternarPagina(1)
1733:         ENDIF
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * BtnCancelarClick - Cancela edicao e retorna para lista
1738:     *--------------------------------------------------------------------------
1739:     PROCEDURE BtnCancelarClick()
1740:         THIS.this_cModoAtual = "LISTA"
1741:         THIS.AlternarPagina(1)
1742:         THIS.CarregarLista()
1743:     ENDPROC
1744: 
1745:     *--------------------------------------------------------------------------
1746:     * BtnLeituraClick - Abre pagina de leitura para o balanco selecionado
1747:     *--------------------------------------------------------------------------
1748:     PROCEDURE BtnLeituraClick()
1749:         LOCAL loc_nCodigo
1750: 
1751:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1752:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1753:             RETURN
1754:         ENDIF
1755: 
1756:         SELECT cursor_4c_Dados
1757: 
1758:         IF cursor_4c_Dados.encerras
1759:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1760:             RETURN
1761:         ENDIF
1762: 
1763:         loc_nCodigo = cursor_4c_Dados.codigos
1764: 
1765:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1766:             THIS.this_cModoAtual = "LEITURA"
1767:             THIS.AlternarPagina(3)
1768:         ENDIF
1769:     ENDPROC
1770: 
1771:     *--------------------------------------------------------------------------
1772:     * BtnFechaClick - Encerra o balanco selecionado
1773:     *--------------------------------------------------------------------------
1774:     PROCEDURE BtnFechaClick()
1775:         LOCAL loc_nCodigo
1776: 
1777:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1778:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1779:             RETURN
1780:         ENDIF
1781: 
1782:         SELECT cursor_4c_Dados
1783: 
1784:         IF cursor_4c_Dados.encerras
1785:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1786:             RETURN
1787:         ENDIF
1788: 
1789:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1790:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1791:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1792:                         "ATEN" + CHR(199) + CHR(195) + "O")
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_nCodigo = cursor_4c_Dados.codigos
1797: 
1798:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1799:             IF THIS.this_oBusinessObject.EncerrarBalanco()
1800:                 MsgInfo("Balan" + CHR(231) + "o encerrado com sucesso!", "")
1801:                 THIS.CarregarLista()
1802:             ENDIF
1803:         ENDIF
1804:     ENDPROC
1805: 
1806:     *--------------------------------------------------------------------------
1807:     * BtnGravarLeituraClick - Grava leitura: atualiza SigCqBal e marca balanco Grvs=1
1808:     *--------------------------------------------------------------------------
1809:     PROCEDURE BtnGravarLeituraClick()
1810:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_lContinuar
1811:         LOCAL loc_cCidChaveBal, loc_cBcoH, loc_cAgeH, loc_cCntH, loc_cChqH, loc_nTipH
1812: 
1813:         IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1814:             MsgAviso("Nenhum cheque na lista para gravar.", "")
1815:             RETURN
1816:         ENDIF
1817: 
1818:         IF !MsgConfirma("Confirma a grava" + CHR(231) + CHR(227) + "o da leitura?", "")
1819:             RETURN
1820:         ENDIF
1821: 
1822:         TRY
1823:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
1824:             loc_lContinuar = .T.
1825: 
1826:             *-- Carrega SigCqBal para obter cidchaves (padrao original: cursor local)
1827:             SQLEXEC(gnConnHandle, ;
1828:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1829:                 " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1830:                 "cursor_4c_BalCid")
1831: 
1832:             SELECT cursor_4c_Historico
1833:             GO TOP
1834: 
1835:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1836:                 loc_cBcoH = ALLTRIM(cursor_4c_Historico.bancos)
1837:                 loc_cAgeH = ALLTRIM(cursor_4c_Historico.agencias)
1838:                 loc_cCntH = ALLTRIM(cursor_4c_Historico.ncontas)
1839:                 loc_cChqH = ALLTRIM(cursor_4c_Historico.ncheques)
1840:                 loc_nTipH = cursor_4c_Historico.tipos
1841: 
1842:                 loc_cCidChaveBal = ""
1843:                 IF USED("cursor_4c_BalCid")
1844:                     SELECT cursor_4c_BalCid
1845:                     LOCATE FOR ALLTRIM(bancos) = loc_cBcoH AND ALLTRIM(agencias) = loc_cAgeH ;
1846:                         AND ALLTRIM(ncontas) = loc_cCntH AND ALLTRIM(ncheques) = loc_cChqH
1847:                     IF FOUND()
1848:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1849:                     ENDIF
1850:                 ENDIF
1851: 
1852:                 IF !EMPTY(loc_cCidChaveBal)
1853:                     IF loc_nTipH = 2
1854:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;

*-- Linhas 1891 a 1941:
1891:     *--------------------------------------------------------------------------
1892:     * BtnExcluirHistoricoClick - Remove cheque do historico e reseta SigCqBal
1893:     *--------------------------------------------------------------------------
1894:     PROCEDURE BtnExcluirHistoricoClick()
1895:         LOCAL loc_cSQL, loc_nResult
1896:         LOCAL loc_nCodigos, loc_cBancos, loc_cAgencias, loc_cNContas, loc_cNCheques, loc_nTipos
1897:         LOCAL loc_cCidChaveHis, loc_cCidChaveBal
1898: 
1899:         IF !USED("cursor_4c_Historico") OR EOF("cursor_4c_Historico") OR ;
1900:            RECCOUNT("cursor_4c_Historico") = 0
1901:             MsgAviso("Nenhum cheque selecionado.", "")
1902:             RETURN
1903:         ENDIF
1904: 
1905:         TRY
1906:             SELECT cursor_4c_Historico
1907:             loc_nCodigos     = cursor_4c_Historico.codigos
1908:             loc_cCidChaveHis = ALLTRIM(cursor_4c_Historico.cidchaves)
1909:             loc_cBancos      = ALLTRIM(cursor_4c_Historico.bancos)
1910:             loc_cAgencias    = ALLTRIM(cursor_4c_Historico.agencias)
1911:             loc_cNContas     = ALLTRIM(cursor_4c_Historico.ncontas)
1912:             loc_cNCheques    = ALLTRIM(cursor_4c_Historico.ncheques)
1913:             loc_nTipos       = cursor_4c_Historico.tipos
1914: 
1915:             loc_cSQL = "DELETE FROM SigCqHis WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveHis)
1916: 
1917:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1918:             IF loc_nResult < 0
1919:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1920:             ELSE
1921:                 *-- Localiza cidchaves em SigCqBal para resetar flag (padrao original: cursor local)
1922:                 loc_cCidChaveBal = ""
1923:                 SQLEXEC(gnConnHandle, ;
1924:                     "SELECT cidchaves, bancos, agencias, ncontas, ncheques FROM SigCqBal" + ;
1925:                     " WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
1926:                     "cursor_4c_BalCid")
1927:                 IF USED("cursor_4c_BalCid")
1928:                     SELECT cursor_4c_BalCid
1929:                     LOCATE FOR ALLTRIM(bancos) = loc_cBancos AND ALLTRIM(agencias) = loc_cAgencias ;
1930:                         AND ALLTRIM(ncontas) = loc_cNContas AND ALLTRIM(ncheques) = loc_cNCheques
1931:                     IF FOUND()
1932:                         loc_cCidChaveBal = ALLTRIM(cidchaves)
1933:                     ENDIF
1934:                     USE IN cursor_4c_BalCid
1935:                 ENDIF
1936: 
1937:                 IF !EMPTY(loc_cCidChaveBal)
1938:                     IF loc_nTipos = 2
1939:                         loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1940:                                    " WHERE CIdChaves = " + EscaparSQL(loc_cCidChaveBal)
1941:                     ELSE

*-- Linhas 1962 a 2155:
1962:     *--------------------------------------------------------------------------
1963:     * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
1964:     *--------------------------------------------------------------------------
1965:     PROCEDURE BtnCancelarLeituraClick()
1966:         IF MsgConfirma("Deseja Cancelar ???", "")
1967:             THIS.this_cModoAtual = "LISTA"
1968:             THIS.AlternarPagina(1)
1969:         ENDIF
1970:     ENDPROC
1971: 
1972:     *--------------------------------------------------------------------------
1973:     * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
1974:     *--------------------------------------------------------------------------
1975:     PROCEDURE HabilitarCampos(par_lHabilitar)
1976:         LOCAL loc_oPg2, loc_lEdicao
1977:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1978:         loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")
1979: 
1980:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1981:             loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR") AND par_lHabilitar
1982:         ENDIF
1983:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
1984:             loc_oPg2.cbo_4c_Operacao.Enabled = loc_lEdicao
1985:         ENDIF
1986:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
1987:             loc_oPg2.txt_4c_Oper.Enabled = loc_lEdicao
1988:         ENDIF
1989:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1990:             loc_oPg2.txt_4c_DataInicial.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1991:         ENDIF
1992:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1993:             loc_oPg2.txt_4c_DataFinal.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1994:         ENDIF
1995:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
1996:             loc_oPg2.txt_4c_Grupo.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1997:         ENDIF
1998:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
1999:             loc_oPg2.txt_4c_Conta.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
2000:         ENDIF
2001: 
2002:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
2003:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
2004:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
2005:             ENDIF
2006:         ENDIF
2007:     ENDPROC
2008: 
2009:     *--------------------------------------------------------------------------
2010:     * LimparCampos - Limpa valores dos campos de edicao em Page2
2011:     *--------------------------------------------------------------------------
2012:     PROCEDURE LimparCampos()
2013:         LOCAL loc_oPg2
2014:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2015: 
2016:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2017:             loc_oPg2.txt_4c_Codigo.Value = ""
2018:         ENDIF
2019:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2020:             loc_oPg2.cbo_4c_Operacao.Value = 1
2021:         ENDIF
2022:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2023:             loc_oPg2.txt_4c_Oper.Value = ""
2024:         ENDIF
2025:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2026:             loc_oPg2.txt_4c_DataInicial.Value = {}
2027:         ENDIF
2028:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2029:             loc_oPg2.txt_4c_DataFinal.Value = {}
2030:         ENDIF
2031:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2032:             loc_oPg2.txt_4c_Grupo.Value = ""
2033:         ENDIF
2034:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2035:             loc_oPg2.txt_4c_DGrupo.Value = ""
2036:         ENDIF
2037:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2038:             loc_oPg2.txt_4c_Conta.Value = ""
2039:         ENDIF
2040:         IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2041:             loc_oPg2.txt_4c_DConta.Value = ""
2042:         ENDIF
2043:     ENDPROC
2044: 
2045:     *--------------------------------------------------------------------------
2046:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2047:     *--------------------------------------------------------------------------
2048:     PROCEDURE AjustarBotoesPorModo()
2049:         LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2, loc_lLista
2050:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2051:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2052:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
2053:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2054: 
2055:         IF VARTYPE(loc_oBotoes) = "O"
2056:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
2057:                 loc_oBotoes.cmd_4c_Incluir.Enabled = .T.
2058:             ENDIF
2059:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
2060:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
2061:             ENDIF
2062:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
2063:                 loc_oBotoes.cmd_4c_Alterar.Enabled = .T.
2064:             ENDIF
2065:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
2066:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
2067:             ENDIF
2068:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
2069:                 loc_oBotoes.cmd_4c_Buscar.Enabled = .T.
2070:             ENDIF
2071:         ENDIF
2072: 
2073:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
2074:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
2075:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
2076:             ENDIF
2077:         ENDIF
2078:     ENDPROC
2079: 
2080:     *--------------------------------------------------------------------------
2081:     * FormParaBO - Transfere dados dos campos do Form para o BO
2082:     *--------------------------------------------------------------------------
2083:     PROCEDURE FormParaBO()
2084:         LOCAL loc_oPg2
2085:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2086: 
2087:         WITH THIS.this_oBusinessObject
2088:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2089:                 .this_nCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
2090:             ENDIF
2091:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2092:                 .this_nTipos     = loc_oPg2.cbo_4c_Operacao.Value
2093:             ENDIF
2094:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2095:                 .this_cOperacaos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2096:             ENDIF
2097:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2098:                 .this_dDataInis  = loc_oPg2.txt_4c_DataInicial.Value
2099:             ENDIF
2100:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2101:                 .this_dDataFims  = loc_oPg2.txt_4c_DataFinal.Value
2102:             ENDIF
2103:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2104:                 .this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2105:             ENDIF
2106:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2107:                 .this_cContas    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2108:             ENDIF
2109:         ENDWITH
2110:     ENDPROC
2111: 
2112:     *--------------------------------------------------------------------------
2113:     * BOParaForm - Transfere dados do BO para os campos do Form
2114:     *--------------------------------------------------------------------------
2115:     PROCEDURE BOParaForm()
2116:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nResultado
2117:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2118: 
2119:         WITH THIS.this_oBusinessObject
2120:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2121:                 loc_oPg2.txt_4c_Codigo.Value      = TRANSFORM(.this_nCodigos)
2122:             ENDIF
2123:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2124:                 loc_oPg2.cbo_4c_Operacao.Value    = .this_nTipos
2125:             ENDIF
2126:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2127:                 loc_oPg2.txt_4c_Oper.Value        = ALLTRIM(.this_cOperacaos)
2128:             ENDIF
2129:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2130:                 loc_oPg2.txt_4c_DataInicial.Value = .this_dDataInis
2131:             ENDIF
2132:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2133:                 loc_oPg2.txt_4c_DataFinal.Value   = .this_dDataFims
2134:             ENDIF
2135:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2136:                 loc_oPg2.txt_4c_Grupo.Value       = ALLTRIM(.this_cGrupos)
2137:             ENDIF
2138:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2139:                 loc_oPg2.txt_4c_Conta.Value       = ALLTRIM(.this_cContas)
2140:             ENDIF
2141:             loc_cGrupo = ALLTRIM(.this_cGrupos)
2142:             loc_cConta = ALLTRIM(.this_cContas)
2143:         ENDWITH
2144: 
2145:         *-- Buscar descricoes de Grupo e Conta para exibicao
2146:         TRY
2147:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2148:                 IF !EMPTY(loc_cGrupo)
2149:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2150:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2151:                         "cursor_4c_DescGcr")
2152:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2153:                         SELECT cursor_4c_DescGcr
2154:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2155:                     ELSE

*-- Linhas 2195 a 2334:
2195:     *--------------------------------------------------------------------------
2196:     * ValidOper - Valid handler: lookup SigCdOpt por operacaos (code = char 15)
2197:     *--------------------------------------------------------------------------
2198:     PROCEDURE ValidOper(par_nKeyCode, par_nShiftAltCtrl)
2199:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2200:         loc_lResultado = .T.
2201:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2202: 
2203:         IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2204:             RETURN .T.
2205:         ENDIF
2206: 
2207:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2208: 
2209:         IF EMPTY(loc_cCodigo)
2210:             RETURN .T.
2211:         ENDIF
2212: 
2213:         TRY
2214:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2215:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2216:                 "cursor_4c_ChkOpt")
2217: 
2218:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2219:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2220:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2221:                     "Opera" + CHR(231) + CHR(227) + "o")
2222: 
2223:                 IF VARTYPE(loc_oBusca) = "O"
2224:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2225:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2226:                     loc_oBusca.Show()
2227: 
2228:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2229:                         SELECT cursor_4c_BuscaOpt
2230:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2231:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2232:                     ELSE
2233:                         loc_oPg2.txt_4c_Oper.Value = ""
2234:                     ENDIF
2235: 
2236:                     loc_oBusca.Release()
2237:                 ENDIF
2238:             ENDIF
2239: 
2240:             IF USED("cursor_4c_ChkOpt")
2241:                 USE IN cursor_4c_ChkOpt
2242:             ENDIF
2243:             IF USED("cursor_4c_BuscaOpt")
2244:                 USE IN cursor_4c_BuscaOpt
2245:             ENDIF
2246:         CATCH TO loc_oErro
2247:             MsgErro(loc_oErro.Message, "FormBch.ValidOper")
2248:             IF USED("cursor_4c_ChkOpt")
2249:                 USE IN cursor_4c_ChkOpt
2250:             ENDIF
2251:             IF USED("cursor_4c_BuscaOpt")
2252:                 USE IN cursor_4c_BuscaOpt
2253:             ENDIF
2254:         ENDTRY
2255: 
2256:         RETURN loc_lResultado
2257:     ENDPROC
2258: 
2259:     *--------------------------------------------------------------------------
2260:     * ValidGrupo - Valid handler: lookup SigCdGcr por codigos, preenche DGrupo
2261:     *--------------------------------------------------------------------------
2262:     PROCEDURE ValidGrupo(par_nKeyCode, par_nShiftAltCtrl)
2263:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2264:         loc_lResultado = .T.
2265:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2266: 
2267:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2268:             RETURN .T.
2269:         ENDIF
2270: 
2271:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2272: 
2273:         IF EMPTY(loc_cCodigo)
2274:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2275:                 loc_oPg2.txt_4c_DGrupo.Value = ""
2276:             ENDIF
2277:             RETURN .T.
2278:         ENDIF
2279: 
2280:         TRY
2281:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2282:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2283:                 "cursor_4c_ChkGcr")
2284: 
2285:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2286:                 SELECT cursor_4c_ChkGcr
2287:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2288:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2289:                 ENDIF
2290:             ELSE
2291:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2292:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2293:                 ENDIF
2294:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2295:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2296: 
2297:                 IF VARTYPE(loc_oBusca) = "O"
2298:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2299:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2300:                     loc_oBusca.Show()
2301: 
2302:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2303:                         SELECT cursor_4c_BuscaGcr
2304:                         IF !EOF("cursor_4c_BuscaGcr")
2305:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2306:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2307:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2308:                             ENDIF
2309:                         ELSE
2310:                             loc_oPg2.txt_4c_Grupo.Value = ""
2311:                         ENDIF
2312:                     ELSE
2313:                         loc_oPg2.txt_4c_Grupo.Value = ""
2314:                     ENDIF
2315: 
2316:                     loc_oBusca.Release()
2317:                 ENDIF
2318:             ENDIF
2319: 
2320:             IF USED("cursor_4c_ChkGcr")
2321:                 USE IN cursor_4c_ChkGcr
2322:             ENDIF
2323:             IF USED("cursor_4c_BuscaGcr")
2324:                 USE IN cursor_4c_BuscaGcr
2325:             ENDIF
2326:         CATCH TO loc_oErro
2327:             MsgErro(loc_oErro.Message, "FormBch.ValidGrupo")
2328:             IF USED("cursor_4c_ChkGcr")
2329:                 USE IN cursor_4c_ChkGcr
2330:             ENDIF
2331:             IF USED("cursor_4c_BuscaGcr")
2332:                 USE IN cursor_4c_BuscaGcr
2333:             ENDIF
2334:         ENDTRY

*-- Linhas 2340 a 2475:
2340:     * ValidDGrupo - Valid handler: busca reversa SigCdGcr por descrs
2341:     * Ativo apenas quando txt_4c_Grupo estiver vazio em modo INCLUIR
2342:     *--------------------------------------------------------------------------
2343:     PROCEDURE ValidDGrupo(par_nKeyCode, par_nShiftAltCtrl)
2344:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2345:         loc_lResultado = .T.
2346:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2347: 
2348:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2349:             RETURN .T.
2350:         ENDIF
2351: 
2352:         *-- Somente busca reversa quando Grupo estiver vazio
2353:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
2354:             RETURN .T.
2355:         ENDIF
2356: 
2357:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value))
2358:             RETURN .T.
2359:         ENDIF
2360: 
2361:         TRY
2362:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2363:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")
2364: 
2365:             IF VARTYPE(loc_oBusca) = "O"
2366:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2367:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2368:                 loc_oBusca.Show()
2369: 
2370:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2371:                     SELECT cursor_4c_BuscaGcr
2372:                     IF !EOF("cursor_4c_BuscaGcr")
2373:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2374:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2375:                         ENDIF
2376:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2377:                     ELSE
2378:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2379:                     ENDIF
2380:                 ELSE
2381:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2382:                 ENDIF
2383: 
2384:                 loc_oBusca.Release()
2385:             ENDIF
2386: 
2387:             IF USED("cursor_4c_BuscaGcr")
2388:                 USE IN cursor_4c_BuscaGcr
2389:             ENDIF
2390:         CATCH TO loc_oErro
2391:             MsgErro(loc_oErro.Message, "FormBch.ValidDGrupo")
2392:             IF USED("cursor_4c_BuscaGcr")
2393:                 USE IN cursor_4c_BuscaGcr
2394:             ENDIF
2395:         ENDTRY
2396: 
2397:         RETURN loc_lResultado
2398:     ENDPROC
2399: 
2400:     *--------------------------------------------------------------------------
2401:     * ValidConta - Valid handler: lookup SIGCDCLI por iclis, preenche DConta
2402:     *--------------------------------------------------------------------------
2403:     PROCEDURE ValidConta(par_nKeyCode, par_nShiftAltCtrl)
2404:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2405:         loc_lResultado = .T.
2406:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2407: 
2408:         IF VARTYPE(loc_oPg2.txt_4c_Conta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2409:             RETURN .T.
2410:         ENDIF
2411: 
2412:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2413: 
2414:         IF EMPTY(loc_cCodigo)
2415:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2416:                 loc_oPg2.txt_4c_DConta.Value = ""
2417:             ENDIF
2418:             RETURN .T.
2419:         ENDIF
2420: 
2421:         TRY
2422:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2423:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2424:                 "cursor_4c_ChkCli")
2425: 
2426:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2427:                 SELECT cursor_4c_ChkCli
2428:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2429:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2430:                 ENDIF
2431:             ELSE
2432:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2433:                     loc_oPg2.txt_4c_DConta.Value = ""
2434:                 ENDIF
2435:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2436:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2437: 
2438:                 IF VARTYPE(loc_oBusca) = "O"
2439:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2440:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2441:                     loc_oBusca.Show()
2442: 
2443:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2444:                         SELECT cursor_4c_BuscaCli
2445:                         IF !EOF("cursor_4c_BuscaCli")
2446:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2447:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2448:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2449:                             ENDIF
2450:                         ELSE
2451:                             loc_oPg2.txt_4c_Conta.Value = ""
2452:                         ENDIF
2453:                     ELSE
2454:                         loc_oPg2.txt_4c_Conta.Value = ""
2455:                     ENDIF
2456: 
2457:                     loc_oBusca.Release()
2458:                 ENDIF
2459:             ENDIF
2460: 
2461:             IF USED("cursor_4c_ChkCli")
2462:                 USE IN cursor_4c_ChkCli
2463:             ENDIF
2464:             IF USED("cursor_4c_BuscaCli")
2465:                 USE IN cursor_4c_BuscaCli
2466:             ENDIF
2467:         CATCH TO loc_oErro
2468:             MsgErro(loc_oErro.Message, "FormBch.ValidConta")
2469:             IF USED("cursor_4c_ChkCli")
2470:                 USE IN cursor_4c_ChkCli
2471:             ENDIF
2472:             IF USED("cursor_4c_BuscaCli")
2473:                 USE IN cursor_4c_BuscaCli
2474:             ENDIF
2475:         ENDTRY

*-- Linhas 2481 a 2628:
2481:     * ValidDConta - Valid handler: busca reversa SIGCDCLI por razaos
2482:     * Ativo apenas quando txt_4c_Conta estiver vazio em modo INCLUIR
2483:     *--------------------------------------------------------------------------
2484:     PROCEDURE ValidDConta(par_nKeyCode, par_nShiftAltCtrl)
2485:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2486:         loc_lResultado = .T.
2487:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2488: 
2489:         IF VARTYPE(loc_oPg2.txt_4c_DConta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2490:             RETURN .T.
2491:         ENDIF
2492: 
2493:         *-- Somente busca reversa quando Conta estiver vazia
2494:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
2495:             RETURN .T.
2496:         ENDIF
2497: 
2498:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DConta.Value))
2499:             RETURN .T.
2500:         ENDIF
2501: 
2502:         TRY
2503:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2504:                 "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", "Conta")
2505: 
2506:             IF VARTYPE(loc_oBusca) = "O"
2507:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2508:                 loc_oBusca.mAddColuna("razaos", "", "Nome")
2509:                 loc_oBusca.Show()
2510: 
2511:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2512:                     SELECT cursor_4c_BuscaCli
2513:                     IF !EOF("cursor_4c_BuscaCli")
2514:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2515:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2516:                         ENDIF
2517:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2518:                     ELSE
2519:                         loc_oPg2.txt_4c_DConta.Value = ""
2520:                     ENDIF
2521:                 ELSE
2522:                     loc_oPg2.txt_4c_DConta.Value = ""
2523:                 ENDIF
2524: 
2525:                 loc_oBusca.Release()
2526:             ENDIF
2527: 
2528:             IF USED("cursor_4c_BuscaCli")
2529:                 USE IN cursor_4c_BuscaCli
2530:             ENDIF
2531:         CATCH TO loc_oErro
2532:             MsgErro(loc_oErro.Message, "FormBch.ValidDConta")
2533:             IF USED("cursor_4c_BuscaCli")
2534:                 USE IN cursor_4c_BuscaCli
2535:             ENDIF
2536:         ENDTRY
2537: 
2538:         RETURN loc_lResultado
2539:     ENDPROC
2540: 
2541:     *--------------------------------------------------------------------------
2542:     * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
2543:     *--------------------------------------------------------------------------
2544:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2545:         LOCAL loc_i, loc_oControl, loc_nP
2546: 
2547:         IF VARTYPE(par_oContainer) != "O"
2548:             RETURN
2549:         ENDIF
2550: 
2551:         FOR loc_i = 1 TO par_oContainer.ControlCount
2552:             loc_oControl = par_oContainer.Controls(loc_i)
2553: 
2554:             IF VARTYPE(loc_oControl) = "O"
2555:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2556:                     IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
2557:                         loc_oControl.Visible = .T.
2558:                     ENDIF
2559:                 ENDIF
2560: 
2561:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2562:                     FOR loc_nP = 1 TO loc_oControl.PageCount
2563:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
2564:                     ENDFOR
2565:                 ENDIF
2566: 
2567:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2568:                     THIS.TornarControlesVisiveis(loc_oControl)
2569:                 ENDIF
2570:             ENDIF
2571:         ENDFOR
2572:     ENDPROC
2573: 
2574:     *--------------------------------------------------------------------------
2575:     * CarregarLeitura - Popula Page3 quando entra no modo LEITURA
2576:     *--------------------------------------------------------------------------
2577:     PROTECTED PROCEDURE CarregarLeitura()
2578:         LOCAL loc_nCodigos
2579:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
2580:         THIS.PopularCamposLeitura()
2581:         THIS.CarregarGradeLeitura(loc_nCodigos)
2582:         THIS.LimparCamposLeitura()
2583:     ENDPROC
2584: 
2585:     *--------------------------------------------------------------------------
2586:     * PopularCamposLeitura - Preenche campos readonly da Page3 com dados do BO
2587:     *--------------------------------------------------------------------------
2588:     PROTECTED PROCEDURE PopularCamposLeitura()
2589:         LOCAL loc_oPg3, loc_oBO, loc_cGrupo, loc_cConta, loc_cOperacaos, loc_nResultado
2590:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2591:         loc_oBO  = THIS.this_oBusinessObject
2592: 
2593:         WITH loc_oBO
2594:             IF VARTYPE(loc_oPg3.txt_4c_CodDisp) = "O"
2595:                 loc_oPg3.txt_4c_CodDisp.Value    = TRANSFORM(.this_nCodigos)
2596:             ENDIF
2597:             IF VARTYPE(loc_oPg3.txt_4c_OperDisp) = "O"
2598:                 loc_oPg3.txt_4c_OperDisp.Value   = ALLTRIM(.this_cOperacaos)
2599:             ENDIF
2600:             IF VARTYPE(loc_oPg3.txt_4c_DataIniDisp) = "O"
2601:                 loc_oPg3.txt_4c_DataIniDisp.Value = .this_dDataInis
2602:             ENDIF
2603:             IF VARTYPE(loc_oPg3.txt_4c_DataFimDisp) = "O"
2604:                 loc_oPg3.txt_4c_DataFimDisp.Value = .this_dDataFims
2605:             ENDIF
2606:             IF VARTYPE(loc_oPg3.txt_4c_GrupoDisp) = "O"
2607:                 loc_oPg3.txt_4c_GrupoDisp.Value  = ALLTRIM(.this_cGrupos)
2608:             ENDIF
2609:             IF VARTYPE(loc_oPg3.txt_4c_ContaDisp) = "O"
2610:                 loc_oPg3.txt_4c_ContaDisp.Value  = ALLTRIM(.this_cContas)
2611:             ENDIF
2612:             loc_cGrupo     = ALLTRIM(.this_cGrupos)
2613:             loc_cConta     = ALLTRIM(.this_cContas)
2614:             loc_cOperacaos = ALLTRIM(.this_cOperacaos)
2615:         ENDWITH
2616: 
2617:         TRY
2618:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2619:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2620:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2621:                     "cursor_4c_DescGcr")
2622:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2623:                     SELECT cursor_4c_DescGcr
2624:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2625:                 ELSE
2626:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2627:                 ENDIF
2628:                 IF USED("cursor_4c_DescGcr")

*-- Linhas 2677 a 2857:
2677:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2678:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2679:     *--------------------------------------------------------------------------
2680:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2681:         LOCAL loc_cSQL, loc_nResultado
2682: 
2683:         TRY
2684:             IF !USED("cursor_4c_Historico")
2685:                 SET NULL ON
2686:                 CREATE CURSOR cursor_4c_Historico ;
2687:                     (cidchaves C(20), codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2688:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2689:                      valors N(14,2), vencs D)
2690:                 SET NULL OFF
2691:             ENDIF
2692: 
2693:             loc_cSQL = "SELECT cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2694:                        " usuarios, valors, vencs" + ;
2695:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2696:                        " ORDER BY datas, ncheques"
2697: 
2698:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2699: 
2700:             IF loc_nResultado >= 0
2701:                 SELECT cursor_4c_Historico
2702:                 ZAP
2703:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2704:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2705:                 ENDIF
2706:                 IF USED("cursor_4c_HistoricoTemp")
2707:                     USE IN cursor_4c_HistoricoTemp
2708:                 ENDIF
2709:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2710:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.ColumnCount = 3
2711:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.RecordSource = "cursor_4c_Historico"
2712:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2713:                 ENDIF
2714:             ELSE
2715:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2716:             ENDIF
2717:         CATCH TO loc_oErro
2718:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2719:             IF USED("cursor_4c_HistoricoTemp")
2720:                 USE IN cursor_4c_HistoricoTemp
2721:             ENDIF
2722:         ENDTRY
2723:     ENDPROC
2724: 
2725:     *--------------------------------------------------------------------------
2726:     * LimparCamposLeitura - Limpa campos de entrada manual da Page3
2727:     *--------------------------------------------------------------------------
2728:     PROTECTED PROCEDURE LimparCamposLeitura()
2729:         LOCAL loc_oPg3
2730:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2731: 
2732:         IF VARTYPE(loc_oPg3.txt_4c_Bco) = "O"
2733:             loc_oPg3.txt_4c_Bco.Value = ""
2734:         ENDIF
2735:         IF VARTYPE(loc_oPg3.txt_4c_Age) = "O"
2736:             loc_oPg3.txt_4c_Age.Value = ""
2737:         ENDIF
2738:         IF VARTYPE(loc_oPg3.txt_4c_ContaLei) = "O"
2739:             loc_oPg3.txt_4c_ContaLei.Value = ""
2740:         ENDIF
2741:         IF VARTYPE(loc_oPg3.txt_4c_Num) = "O"
2742:             loc_oPg3.txt_4c_Num.Value = ""
2743:         ENDIF
2744:         IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2745:             loc_oPg3.txt_4c_Valor.Value = 0
2746:         ENDIF
2747:         IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2748:             loc_oPg3.txt_4c_Vecto.Value = {}
2749:         ENDIF
2750:     ENDPROC
2751: 
2752:     *--------------------------------------------------------------------------
2753:     * NumGetLostFocus - Valida cheque em SigCqBal e insere em SigCqHis
2754:     *--------------------------------------------------------------------------
2755:     PROCEDURE NumGetLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2756:         LOCAL loc_oPg3, loc_cBco, loc_cAge, loc_cConta, loc_cNum
2757:         LOCAL loc_nCodigos, loc_nTipos, loc_cSQL, loc_nResultado
2758:         LOCAL loc_nValor, loc_dVecto, loc_lContinuar, loc_cCidChaveHis
2759:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2760: 
2761:         IF VARTYPE(loc_oPg3.txt_4c_Bco) != "O" OR ;
2762:            VARTYPE(loc_oPg3.txt_4c_Age) != "O" OR ;
2763:            VARTYPE(loc_oPg3.txt_4c_ContaLei) != "O" OR ;
2764:            VARTYPE(loc_oPg3.txt_4c_Num) != "O"
2765:             RETURN
2766:         ENDIF
2767: 
2768:         loc_cBco   = ALLTRIM(loc_oPg3.txt_4c_Bco.Value)
2769:         loc_cAge   = ALLTRIM(loc_oPg3.txt_4c_Age.Value)
2770:         loc_cConta = ALLTRIM(loc_oPg3.txt_4c_ContaLei.Value)
2771:         loc_cNum   = ALLTRIM(loc_oPg3.txt_4c_Num.Value)
2772: 
2773:         IF EMPTY(loc_cNum) OR EMPTY(loc_cBco) OR EMPTY(loc_cAge) OR EMPTY(loc_cConta)
2774:             RETURN
2775:         ENDIF
2776: 
2777:         TRY
2778:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
2779:             loc_lContinuar = .T.
2780:             IF VARTYPE(loc_oPg3.opt_4c_TipoLeitura) = "O"
2781:                 loc_nTipos = loc_oPg3.opt_4c_TipoLeitura.Value
2782:             ELSE
2783:                 loc_nTipos = 1
2784:             ENDIF
2785: 
2786:             *-- Carrega SigCqBal para verificar cheque (padrao original: cursor local)
2787:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2788:                 "SELECT cidchaves, bancos, agencias, ncontas, ncheques, valors, vencs" + ;
2789:                 " FROM SigCqBal WHERE codigos = " + FormatarNumeroSQL(loc_nCodigos), ;
2790:                 "cursor_4c_BalDisp")
2791: 
2792:             *-- Verificar se cheque existe no balanco (LOCATE em cursor local)
2793:             IF loc_nResultado >= 0 AND USED("cursor_4c_BalDisp")
2794:                 SELECT cursor_4c_BalDisp
2795:                 LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2796:                     AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2797:                 IF FOUND()
2798:                     loc_nValor = TratarNulo(valors, "N")
2799:                     loc_dVecto = TratarNulo(vencs,  "D")
2800:                 ELSE
2801:                     MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2802:                     loc_lContinuar = .F.
2803:                 ENDIF
2804:                 USE IN cursor_4c_BalDisp
2805:             ELSE
2806:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2807:                 loc_lContinuar = .F.
2808:             ENDIF
2809: 
2810:             IF loc_lContinuar
2811:                 *-- Verificar duplicidade no historico (LOCATE em cursor local)
2812:                 IF USED("cursor_4c_Historico")
2813:                     SELECT cursor_4c_Historico
2814:                     LOCATE FOR ALLTRIM(bancos) = loc_cBco AND ALLTRIM(agencias) = loc_cAge ;
2815:                         AND ALLTRIM(ncontas) = loc_cConta AND ALLTRIM(ncheques) = loc_cNum
2816:                     IF FOUND()
2817:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2818:                         loc_lContinuar = .F.
2819:                     ENDIF
2820:                 ENDIF
2821:             ENDIF
2822: 
2823:             IF loc_lContinuar
2824:                 *-- Gerar cidchaves para SigCqHis
2825:                 loc_cCidChaveHis = ""
2826:                 loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", ;
2827:                     "cursor_4c_Uuid")
2828:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
2829:                     SELECT cursor_4c_Uuid
2830:                     loc_cCidChaveHis = ALLTRIM(cursor_4c_Uuid.novo_uuid)
2831:                 ENDIF
2832:                 IF USED("cursor_4c_Uuid")
2833:                     USE IN cursor_4c_Uuid
2834:                 ENDIF
2835: 
2836:                 *-- Inserir no historico de leitura
2837:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2838:                            " (cidchaves, codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2839:                            " VALUES (" + ;
2840:                            EscaparSQL(loc_cCidChaveHis) + "," + ;
2841:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2842:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2843:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2844:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2845:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2846:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2847:                            "GETDATE()," + ;
2848:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2849:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2850:                            FormatarDataSQL(loc_dVecto) + ;
2851:                            ")"
2852: 
2853:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2854: 
2855:                 IF loc_nResultado >= 0
2856:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2857:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor

*-- Linhas 2879 a 2926:
2879:     *--------------------------------------------------------------------------
2880:     * FormatarGridLista - Formata Grid da lista apos carregar dados
2881:     *--------------------------------------------------------------------------
2882:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2883:         IF VARTYPE(par_oGrid) != "O"
2884:             RETURN
2885:         ENDIF
2886: 
2887:         WITH par_oGrid
2888:             .FontName = "Verdana"
2889:             .FontSize = 8
2890:         ENDWITH
2891:     ENDPROC
2892: 
2893:     *--------------------------------------------------------------------------
2894:     * Destroy - Libera recursos do form
2895:     *--------------------------------------------------------------------------
2896:     PROCEDURE Destroy()
2897:         LOCAL loc_oErro
2898: 
2899:         TRY
2900:             IF USED("cursor_4c_Dados")
2901:                 USE IN cursor_4c_Dados
2902:             ENDIF
2903:             IF USED("cursor_4c_Historico")
2904:                 USE IN cursor_4c_Historico
2905:             ENDIF
2906:             IF USED("cursor_4c_HistoricoTemp")
2907:                 USE IN cursor_4c_HistoricoTemp
2908:             ENDIF
2909:             IF USED("Balanco")
2910:                 USE IN Balanco
2911:             ENDIF
2912:             IF USED("Historico")
2913:                 USE IN Historico
2914:             ENDIF
2915: 
2916:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2917:                 THIS.this_oBusinessObject = .NULL.
2918:             ENDIF
2919:         CATCH TO loc_oErro
2920:             MsgErro(loc_oErro.Message, "FormBch.Destroy")
2921:         ENDTRY
2922: 
2923:         DODEFAULT()
2924:     ENDPROC
2925: 
2926: ENDDEFINE


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

