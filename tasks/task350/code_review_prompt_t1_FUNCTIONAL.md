# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Término' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nú. Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nú. Cheque' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Término' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Banco, Agência, Nº Conta, Nº Cheque, Vencimento, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGCDBCH.Pagina.Leitura): Top original=170 vs migrado 'opt_4c_TipoLeitura' Top=3 (diff=167px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'TipoLeitura' (parent: SIGCDBCH.Pagina.Leitura): Left original=709 vs migrado 'opt_4c_TipoLeitura' Left=3 (diff=706px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDBCH.Pagina.Leitura): Left original=923 vs migrado 'cmd_4c_Cancelar' Left=150 (diff=773px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Excluir' (parent: SIGCDBCH.Pagina.Leitura): Left original=773 vs migrado 'cmd_4c_Excluir' Left=0 (diff=773px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2834 linhas total):

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
225:             .FontName        = "Comic Sans MS"
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
246:             .FontName        = "Comic Sans MS"
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
267:             .FontName        = "Comic Sans MS"
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
288:             .FontName        = "Comic Sans MS"
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
322:             .FontName        = "Comic Sans MS"
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
458:             .FontName        = "Comic Sans MS"
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
479:             .FontName        = "Comic Sans MS"
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
741:         LOCAL loc_oPg3, loc_oBotoesLeitura, loc_oGrid
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
972:         WITH loc_oPg3.opt_4c_TipoLeitura
973:             .Top         = 199
974:             .Left        = 709
975:             .Width       = 78
976:             .Height      = 41
977:             .ButtonCount = 2
978:             .Value       = 1
979:             .BackStyle   = 0
980:             .BorderStyle = 0
981:             .Visible     = .T.
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

*-- Linhas 1350 a 1464:
1350:             .BackStyle   = 0
1351:             .BorderWidth = 0
1352:             .Visible     = .T.
1353:         ENDWITH
1354: 
1355:         loc_oBotoesLeitura.AddObject("cmd_4c_Excluir", "CommandButton")
1356:         WITH loc_oBotoesLeitura.cmd_4c_Excluir
1357:             .Top             = 5
1358:             .Left            = 0
1359:             .Width           = 75
1360:             .Height          = 75
1361:             .Caption         = "Excluir"
1362:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1363:             .PicturePosition = 13
1364:             .FontName        = "Comic Sans MS"
1365:             .FontBold        = .T.
1366:             .FontItalic      = .T.
1367:             .FontSize        = 8
1368:             .ForeColor       = RGB(90, 90, 90)
1369:             .BackColor       = RGB(255, 255, 255)
1370:             .Themes          = .F.
1371:             .SpecialEffect   = 0
1372:             .Visible         = .T.
1373:         ENDWITH
1374:         BINDEVENT(loc_oBotoesLeitura.cmd_4c_Excluir, "Click", THIS, "BtnExcluirHistoricoClick")
1375: 
1376:         loc_oBotoesLeitura.AddObject("cmd_4c_Confirmar", "CommandButton")
1377:         WITH loc_oBotoesLeitura.cmd_4c_Confirmar
1378:             .Top             = 5
1379:             .Left            = 75
1380:             .Width           = 75
1381:             .Height          = 75
1382:             .Caption         = "Gravar"
1383:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1384:             .PicturePosition = 13
1385:             .FontName        = "Comic Sans MS"
1386:             .FontBold        = .T.
1387:             .FontItalic      = .T.
1388:             .FontSize        = 8
1389:             .ForeColor       = RGB(90, 90, 90)
1390:             .BackColor       = RGB(255, 255, 255)
1391:             .Themes          = .F.
1392:             .SpecialEffect   = 0
1393:             .Visible         = .T.
1394:         ENDWITH
1395:         BINDEVENT(loc_oBotoesLeitura.cmd_4c_Confirmar, "Click", THIS, "BtnGravarLeituraClick")
1396: 
1397:         loc_oBotoesLeitura.AddObject("cmd_4c_Cancelar", "CommandButton")
1398:         WITH loc_oBotoesLeitura.cmd_4c_Cancelar
1399:             .Top             = 5
1400:             .Left            = 150
1401:             .Width           = 75
1402:             .Height          = 75
1403:             .Caption         = "Encerrar"
1404:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1405:             .PicturePosition = 13
1406:             .FontName        = "Comic Sans MS"
1407:             .FontBold        = .T.
1408:             .FontItalic      = .T.
1409:             .FontSize        = 8
1410:             .ForeColor       = RGB(90, 90, 90)
1411:             .BackColor       = RGB(255, 255, 255)
1412:             .Themes          = .F.
1413:             .SpecialEffect   = 0
1414:             .Visible         = .T.
1415:         ENDWITH
1416:         BINDEVENT(loc_oBotoesLeitura.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarLeituraClick")
1417: 
1418:         THIS.TornarControlesVisiveis(loc_oPg3)
1419:     ENDPROC
1420: 
1421:     *--------------------------------------------------------------------------
1422:     * CarregarLista - Carrega registros de SigCdBch no grid da Page1
1423:     *--------------------------------------------------------------------------
1424:     PROCEDURE CarregarLista()
1425:         LOCAL loc_lResultado, loc_oGrid
1426:         loc_lResultado = .F.
1427: 
1428:         TRY
1429:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1430:                 loc_lResultado = .T.
1431:             ELSE
1432:                 IF !THIS.this_oBusinessObject.Buscar("")
1433:                     loc_lResultado = .F.
1434:                 ELSE
1435:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1436:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
1437: 
1438:                         loc_oGrid.ColumnCount = 6
1439:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1440: 
1441:                         *-- ControlSource APOS RecordSource (RecordSource reseta auto-bind)
1442:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1443:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datainis"
1444:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.datafims"
1445:                         loc_oGrid.Column4.ControlSource = ;
1446:                             "IIF(cursor_4c_Dados.tipos=1,'1a.Entrada'," + ;
1447:                             "IIF(cursor_4c_Dados.tipos=2,'Pendentes'," + ;
1448:                             "IIF(cursor_4c_Dados.tipos=3,'Devolvidos','Todos')))"
1449:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1450:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1451: 
1452:                         *-- Reconfigurar headers (RecordSource reseta captions)
1453:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1454:                         loc_oGrid.Column2.Header1.Caption = "In" + CHR(237) + "cio"
1455:                         loc_oGrid.Column3.Header1.Caption = "T" + CHR(233) + "rmino"
1456:                         loc_oGrid.Column4.Header1.Caption = "Tipo"
1457:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1458:                         loc_oGrid.Column6.Header1.Caption = "Conta"
1459: 
1460:                         THIS.FormatarGridLista(loc_oGrid)
1461:                     ENDIF
1462:                     loc_lResultado = .T.
1463:                 ENDIF
1464:             ENDIF

*-- Linhas 1472 a 1804:
1472:     *--------------------------------------------------------------------------
1473:     * AlternarPagina - Alterna entre as 3 paginas do PageFrame
1474:     *--------------------------------------------------------------------------
1475:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1476:         LOCAL loc_lResultado
1477:         loc_lResultado = .F.
1478: 
1479:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
1480:             RETURN .F.
1481:         ENDIF
1482: 
1483:         TRY
1484:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1485: 
1486:             DO CASE
1487:             CASE par_nPagina = 1
1488:                 THIS.this_cModoAtual = "LISTA"
1489:                 THIS.CarregarLista()
1490:             CASE par_nPagina = 2
1491:                 *-- modo definido pelo chamador (INCLUIR/ALTERAR/VISUALIZAR)
1492:             CASE par_nPagina = 3
1493:                 THIS.this_cModoAtual = "LEITURA"
1494:                 THIS.CarregarLeitura()
1495:             ENDCASE
1496: 
1497:             loc_lResultado = .T.
1498:         CATCH TO loc_oErro
1499:             MsgErro(loc_oErro.Message, "FormBch.AlternarPagina")
1500:         ENDTRY
1501: 
1502:         RETURN loc_lResultado
1503:     ENDPROC
1504: 
1505:     *--------------------------------------------------------------------------
1506:     * BtnEncerrarClick - Fecha o formulario
1507:     *--------------------------------------------------------------------------
1508:     PROCEDURE BtnEncerrarClick()
1509:         THIS.Release()
1510:     ENDPROC
1511: 
1512:     *--------------------------------------------------------------------------
1513:     * BtnIncluirClick - Inicia inclusao de novo balanco
1514:     *--------------------------------------------------------------------------
1515:     PROCEDURE BtnIncluirClick()
1516:         THIS.this_oBusinessObject.NovoRegistro()
1517:         THIS.LimparCampos()
1518:         THIS.this_cModoAtual = "INCLUIR"
1519:         THIS.HabilitarCampos(.T.)
1520:         THIS.AjustarBotoesPorModo()
1521:         THIS.AlternarPagina(2)
1522:     ENDPROC
1523: 
1524:     *--------------------------------------------------------------------------
1525:     * BtnVisualizarClick - Visualiza balanco selecionado (somente leitura)
1526:     *--------------------------------------------------------------------------
1527:     PROCEDURE BtnVisualizarClick()
1528:         LOCAL loc_nCodigo
1529: 
1530:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1531:             MsgAviso("Selecione um registro na lista.", "")
1532:             RETURN
1533:         ENDIF
1534: 
1535:         SELECT cursor_4c_Dados
1536:         loc_nCodigo = cursor_4c_Dados.codigos
1537: 
1538:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1539:             THIS.this_cModoAtual = "VISUALIZAR"
1540:             THIS.BOParaForm()
1541:             THIS.HabilitarCampos(.F.)
1542:             THIS.AjustarBotoesPorModo()
1543:             THIS.AlternarPagina(2)
1544:         ENDIF
1545:     ENDPROC
1546: 
1547:     *--------------------------------------------------------------------------
1548:     * BtnAlterarClick - Edita balanco selecionado
1549:     *--------------------------------------------------------------------------
1550:     PROCEDURE BtnAlterarClick()
1551:         LOCAL loc_nCodigo
1552: 
1553:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1554:             MsgAviso("Selecione um registro na lista.", "")
1555:             RETURN
1556:         ENDIF
1557: 
1558:         SELECT cursor_4c_Dados
1559: 
1560:         IF cursor_4c_Dados.encerras
1561:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1562:                      "vel alterar balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1563:             RETURN
1564:         ENDIF
1565: 
1566:         loc_nCodigo = cursor_4c_Dados.codigos
1567: 
1568:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1569:             THIS.this_oBusinessObject.EditarRegistro()
1570:             THIS.this_cModoAtual = "ALTERAR"
1571:             THIS.BOParaForm()
1572:             THIS.HabilitarCampos(.T.)
1573:             THIS.AjustarBotoesPorModo()
1574:             THIS.AlternarPagina(2)
1575:         ENDIF
1576:     ENDPROC
1577: 
1578:     *--------------------------------------------------------------------------
1579:     * BtnExcluirClick - Exclui balanco selecionado
1580:     *--------------------------------------------------------------------------
1581:     PROCEDURE BtnExcluirClick()
1582:         LOCAL loc_nCodigo
1583: 
1584:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1585:             MsgAviso("Selecione um registro para excluir.", "")
1586:             RETURN
1587:         ENDIF
1588: 
1589:         SELECT cursor_4c_Dados
1590: 
1591:         IF cursor_4c_Dados.encerras
1592:             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1593:                      "vel excluir balan" + CHR(231) + "o j" + CHR(225) + " encerrado!", "")
1594:             RETURN
1595:         ENDIF
1596: 
1597:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1598:                         "Confirmar")
1599:             RETURN
1600:         ENDIF
1601: 
1602:         loc_nCodigo = cursor_4c_Dados.codigos
1603: 
1604:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1605:             IF THIS.this_oBusinessObject.Excluir()
1606:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1607:                 THIS.CarregarLista()
1608:             ENDIF
1609:         ENDIF
1610:     ENDPROC
1611: 
1612:     *--------------------------------------------------------------------------
1613:     * BtnBuscarClick - Busca registros de SigCdBch por FormBuscaAuxiliar
1614:     *--------------------------------------------------------------------------
1615:     PROCEDURE BtnBuscarClick()
1616:         LOCAL loc_oBusca, loc_nCodigo, loc_lResultado
1617:         loc_lResultado = .F.
1618: 
1619:         TRY
1620:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1621:                 "SigCdBch", "cursor_4c_BuscaBch", "codigos", "", ;
1622:                 "Balan" + CHR(231) + "o de Cheques")
1623: 
1624:             IF VARTYPE(loc_oBusca) = "O"
1625:                 loc_oBusca.mAddColuna("codigos",   "", "C" + CHR(243) + "digo")
1626:                 loc_oBusca.mAddColuna("operacaos", "", "Opera" + CHR(231) + CHR(227) + "o")
1627:                 loc_oBusca.mAddColuna("datainis",  "", "In" + CHR(237) + "cio")
1628:                 loc_oBusca.mAddColuna("datafims",  "", "T" + CHR(233) + "rmino")
1629:                 loc_oBusca.Show()
1630: 
1631:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaBch")
1632:                     SELECT cursor_4c_BuscaBch
1633:                     IF !EOF("cursor_4c_BuscaBch")
1634:                         loc_nCodigo = cursor_4c_BuscaBch.codigos
1635:                         THIS.this_oBusinessObject.Buscar( ;
1636:                             "codigos = " + FormatarNumeroSQL(loc_nCodigo))
1637:                         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados) = "O"
1638:                             THIS.CarregarLista()
1639:                         ENDIF
1640:                     ENDIF
1641:                 ELSE
1642:                     THIS.CarregarLista()
1643:                 ENDIF
1644: 
1645:                 loc_oBusca.Release()
1646:             ENDIF
1647:         CATCH TO loc_oErro
1648:             MsgErro(loc_oErro.Message, "FormBch.BtnBuscarClick")
1649:         ENDTRY
1650: 
1651:         IF USED("cursor_4c_BuscaBch")
1652:             USE IN cursor_4c_BuscaBch
1653:         ENDIF
1654:     ENDPROC
1655: 
1656:     *--------------------------------------------------------------------------
1657:     * BtnSalvarClick - Salva registro (cmd_4c_Confirmar em Page2)
1658:     *--------------------------------------------------------------------------
1659:     PROCEDURE BtnSalvarClick()
1660:         LOCAL loc_oPg2
1661:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1662: 
1663:         *-- Validacoes fora do TRY para que RETURN funcione
1664:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1665:             IF EMPTY(loc_oPg2.txt_4c_DataInicial.Value)
1666:                 MsgAviso("Data Inicial obrigat" + CHR(243) + "ria!", "")
1667:                 RETURN
1668:             ENDIF
1669:         ENDIF
1670: 
1671:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1672:             IF EMPTY(loc_oPg2.txt_4c_DataFinal.Value)
1673:                 MsgAviso("Data Final obrigat" + CHR(243) + "ria!", "")
1674:                 RETURN
1675:             ENDIF
1676:         ENDIF
1677: 
1678:         THIS.FormParaBO()
1679: 
1680:         IF THIS.this_oBusinessObject.Salvar()
1681:             MsgInfo("Registro salvo com sucesso!", "")
1682:             THIS.this_cModoAtual = "LISTA"
1683:             THIS.AlternarPagina(1)
1684:         ENDIF
1685:     ENDPROC
1686: 
1687:     *--------------------------------------------------------------------------
1688:     * BtnCancelarClick - Cancela edicao e retorna para lista
1689:     *--------------------------------------------------------------------------
1690:     PROCEDURE BtnCancelarClick()
1691:         THIS.this_cModoAtual = "LISTA"
1692:         THIS.AlternarPagina(1)
1693:         THIS.CarregarLista()
1694:     ENDPROC
1695: 
1696:     *--------------------------------------------------------------------------
1697:     * BtnLeituraClick - Abre pagina de leitura para o balanco selecionado
1698:     *--------------------------------------------------------------------------
1699:     PROCEDURE BtnLeituraClick()
1700:         LOCAL loc_nCodigo
1701: 
1702:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1703:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1704:             RETURN
1705:         ENDIF
1706: 
1707:         SELECT cursor_4c_Dados
1708: 
1709:         IF cursor_4c_Dados.encerras
1710:             MsgAviso("Invent" + CHR(225) + "rio J" + CHR(225) + " Encerrado !!!", "")
1711:             RETURN
1712:         ENDIF
1713: 
1714:         loc_nCodigo = cursor_4c_Dados.codigos
1715: 
1716:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1717:             THIS.this_cModoAtual = "LEITURA"
1718:             THIS.AlternarPagina(3)
1719:         ENDIF
1720:     ENDPROC
1721: 
1722:     *--------------------------------------------------------------------------
1723:     * BtnFechaClick - Encerra o balanco selecionado
1724:     *--------------------------------------------------------------------------
1725:     PROCEDURE BtnFechaClick()
1726:         LOCAL loc_nCodigo
1727: 
1728:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1729:             MsgAviso("Selecione um balan" + CHR(231) + "o na lista.", "")
1730:             RETURN
1731:         ENDIF
1732: 
1733:         SELECT cursor_4c_Dados
1734: 
1735:         IF cursor_4c_Dados.encerras
1736:             MsgAviso("Balan" + CHR(231) + "o J" + CHR(225) + " Encerrado !!!", "")
1737:             RETURN
1738:         ENDIF
1739: 
1740:         IF !MsgConfirma("Este Balan" + CHR(231) + "o ser" + CHR(225) + " finalizado, n" + ;
1741:                         CHR(227) + "o podendo ser efetuada mais nenhuma leitura..." + CHR(13) + ;
1742:                         "Deseja encerrar o Balan" + CHR(231) + "o ???", ;
1743:                         "ATEN" + CHR(199) + CHR(195) + "O")
1744:             RETURN
1745:         ENDIF
1746: 
1747:         loc_nCodigo = cursor_4c_Dados.codigos
1748: 
1749:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigo)
1750:             IF THIS.this_oBusinessObject.EncerrarBalanco()
1751:                 MsgInfo("Balan" + CHR(231) + "o encerrado com sucesso!", "")
1752:                 THIS.CarregarLista()
1753:             ENDIF
1754:         ENDIF
1755:     ENDPROC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * BtnGravarLeituraClick - Grava leitura: atualiza SigCqBal e marca balanco Grvs=1
1759:     *--------------------------------------------------------------------------
1760:     PROCEDURE BtnGravarLeituraClick()
1761:         LOCAL loc_cSQL, loc_nResult, loc_nCodigos, loc_lContinuar
1762: 
1763:         IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1764:             MsgAviso("Nenhum cheque na lista para gravar.", "")
1765:             RETURN
1766:         ENDIF
1767: 
1768:         IF !MsgConfirma("Confirma a grava" + CHR(231) + CHR(227) + "o da leitura?", "")
1769:             RETURN
1770:         ENDIF
1771: 
1772:         TRY
1773:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
1774:             loc_lContinuar = .T.
1775: 
1776:             SELECT cursor_4c_Historico
1777:             GO TOP
1778: 
1779:             DO WHILE !EOF("cursor_4c_Historico") AND loc_lContinuar
1780:                 IF cursor_4c_Historico.tipos = 2
1781:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 1" + ;
1782:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1783:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1784:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1785:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1786:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1787:                 ELSE
1788:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 1" + ;
1789:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1790:                                " AND Bancos = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.bancos)) + ;
1791:                                " AND Agencias = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.agencias)) + ;
1792:                                " AND NContas = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncontas)) + ;
1793:                                " AND NCheques = " + EscaparSQL(ALLTRIM(cursor_4c_Historico.ncheques))
1794:                 ENDIF
1795: 
1796:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1797:                 IF loc_nResult < 0
1798:                     MsgErro("Erro ao atualizar SigCqBal: " + CapturarErroSQL(), "Erro SQL")
1799:                     loc_lContinuar = .F.
1800:                 ELSE
1801:                     SKIP IN cursor_4c_Historico
1802:                 ENDIF
1803:             ENDDO
1804: 

*-- Linhas 1815 a 1864:
1815:     *--------------------------------------------------------------------------
1816:     * BtnExcluirHistoricoClick - Remove cheque do historico e reseta SigCqBal
1817:     *--------------------------------------------------------------------------
1818:     PROCEDURE BtnExcluirHistoricoClick()
1819:         LOCAL loc_cSQL, loc_nResult
1820:         LOCAL loc_nCodigos, loc_cBancos, loc_cAgencias, loc_cNContas, loc_cNCheques, loc_nTipos
1821: 
1822:         IF !USED("cursor_4c_Historico") OR EOF("cursor_4c_Historico") OR ;
1823:            RECCOUNT("cursor_4c_Historico") = 0
1824:             MsgAviso("Nenhum cheque selecionado.", "")
1825:             RETURN
1826:         ENDIF
1827: 
1828:         TRY
1829:             SELECT cursor_4c_Historico
1830:             loc_nCodigos  = cursor_4c_Historico.codigos
1831:             loc_cBancos   = ALLTRIM(cursor_4c_Historico.bancos)
1832:             loc_cAgencias = ALLTRIM(cursor_4c_Historico.agencias)
1833:             loc_cNContas  = ALLTRIM(cursor_4c_Historico.ncontas)
1834:             loc_cNCheques = ALLTRIM(cursor_4c_Historico.ncheques)
1835:             loc_nTipos    = cursor_4c_Historico.tipos
1836: 
1837:             loc_cSQL = "DELETE FROM SigCqHis" + ;
1838:                        " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1839:                        " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1840:                        " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1841:                        " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1842:                        " AND NCheques = " + EscaparSQL(loc_cNCheques)
1843: 
1844:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
1845:             IF loc_nResult < 0
1846:                 MsgErro("Erro ao excluir hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
1847:             ELSE
1848:                 IF loc_nTipos = 2
1849:                     loc_cSQL = "UPDATE SigCqBal SET ReLidos = 0" + ;
1850:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1851:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1852:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1853:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1854:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1855:                 ELSE
1856:                     loc_cSQL = "UPDATE SigCqBal SET Lidos = 0" + ;
1857:                                " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
1858:                                " AND Bancos = " + EscaparSQL(loc_cBancos) + ;
1859:                                " AND Agencias = " + EscaparSQL(loc_cAgencias) + ;
1860:                                " AND NContas = " + EscaparSQL(loc_cNContas) + ;
1861:                                " AND NCheques = " + EscaparSQL(loc_cNCheques)
1862:                 ENDIF
1863: 
1864:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

*-- Linhas 1876 a 2069:
1876:     *--------------------------------------------------------------------------
1877:     * BtnCancelarLeituraClick - Cancela leitura e retorna para lista (Page3)
1878:     *--------------------------------------------------------------------------
1879:     PROCEDURE BtnCancelarLeituraClick()
1880:         IF MsgConfirma("Deseja Cancelar ???", "")
1881:             THIS.this_cModoAtual = "LISTA"
1882:             THIS.AlternarPagina(1)
1883:         ENDIF
1884:     ENDPROC
1885: 
1886:     *--------------------------------------------------------------------------
1887:     * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
1888:     *--------------------------------------------------------------------------
1889:     PROCEDURE HabilitarCampos(par_lHabilitar)
1890:         LOCAL loc_oPg2, loc_lEdicao
1891:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1892:         loc_lEdicao = (par_lHabilitar = .T.) AND (THIS.this_cModoAtual != "VISUALIZAR")
1893: 
1894:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1895:             loc_oPg2.txt_4c_Codigo.Enabled = (THIS.this_cModoAtual = "INCLUIR") AND par_lHabilitar
1896:         ENDIF
1897:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
1898:             loc_oPg2.cbo_4c_Operacao.Enabled = loc_lEdicao
1899:         ENDIF
1900:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
1901:             loc_oPg2.txt_4c_Oper.Enabled = loc_lEdicao
1902:         ENDIF
1903:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1904:             loc_oPg2.txt_4c_DataInicial.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1905:         ENDIF
1906:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1907:             loc_oPg2.txt_4c_DataFinal.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1908:         ENDIF
1909:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
1910:             loc_oPg2.txt_4c_Grupo.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1911:         ENDIF
1912:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
1913:             loc_oPg2.txt_4c_Conta.Enabled = loc_lEdicao AND (THIS.this_cModoAtual = "INCLUIR")
1914:         ENDIF
1915: 
1916:         IF VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
1917:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1918:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEdicao
1919:             ENDIF
1920:         ENDIF
1921:     ENDPROC
1922: 
1923:     *--------------------------------------------------------------------------
1924:     * LimparCampos - Limpa valores dos campos de edicao em Page2
1925:     *--------------------------------------------------------------------------
1926:     PROCEDURE LimparCampos()
1927:         LOCAL loc_oPg2
1928:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1929: 
1930:         IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
1931:             loc_oPg2.txt_4c_Codigo.Value = ""
1932:         ENDIF
1933:         IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
1934:             loc_oPg2.cbo_4c_Operacao.Value = 1
1935:         ENDIF
1936:         IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
1937:             loc_oPg2.txt_4c_Oper.Value = ""
1938:         ENDIF
1939:         IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
1940:             loc_oPg2.txt_4c_DataInicial.Value = {}
1941:         ENDIF
1942:         IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
1943:             loc_oPg2.txt_4c_DataFinal.Value = {}
1944:         ENDIF
1945:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
1946:             loc_oPg2.txt_4c_Grupo.Value = ""
1947:         ENDIF
1948:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
1949:             loc_oPg2.txt_4c_DGrupo.Value = ""
1950:         ENDIF
1951:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
1952:             loc_oPg2.txt_4c_Conta.Value = ""
1953:         ENDIF
1954:         IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
1955:             loc_oPg2.txt_4c_DConta.Value = ""
1956:         ENDIF
1957:     ENDPROC
1958: 
1959:     *--------------------------------------------------------------------------
1960:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1961:     *--------------------------------------------------------------------------
1962:     PROCEDURE AjustarBotoesPorModo()
1963:         LOCAL loc_oBotoes, loc_lEdicao, loc_oPg2, loc_lLista
1964:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1965:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1966:         loc_lLista  = (THIS.this_cModoAtual = "LISTA")
1967:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1968: 
1969:         IF VARTYPE(loc_oBotoes) = "O"
1970:             IF VARTYPE(loc_oBotoes.cmd_4c_Incluir) = "O"
1971:                 loc_oBotoes.cmd_4c_Incluir.Enabled = .T.
1972:             ENDIF
1973:             IF VARTYPE(loc_oBotoes.cmd_4c_Visualizar) = "O"
1974:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = .T.
1975:             ENDIF
1976:             IF VARTYPE(loc_oBotoes.cmd_4c_Alterar) = "O"
1977:                 loc_oBotoes.cmd_4c_Alterar.Enabled = .T.
1978:             ENDIF
1979:             IF VARTYPE(loc_oBotoes.cmd_4c_Excluir) = "O"
1980:                 loc_oBotoes.cmd_4c_Excluir.Enabled = .T.
1981:             ENDIF
1982:             IF VARTYPE(loc_oBotoes.cmd_4c_Buscar) = "O"
1983:                 loc_oBotoes.cmd_4c_Buscar.Enabled = .T.
1984:             ENDIF
1985:         ENDIF
1986: 
1987:         IF VARTYPE(loc_oPg2) = "O" AND VARTYPE(loc_oPg2.cnt_4c_Salva) = "O"
1988:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1989:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Visible = loc_lEdicao
1990:             ENDIF
1991:         ENDIF
1992:     ENDPROC
1993: 
1994:     *--------------------------------------------------------------------------
1995:     * FormParaBO - Transfere dados dos campos do Form para o BO
1996:     *--------------------------------------------------------------------------
1997:     PROCEDURE FormParaBO()
1998:         LOCAL loc_oPg2
1999:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2000: 
2001:         WITH THIS.this_oBusinessObject
2002:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2003:                 .this_nCodigos   = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
2004:             ENDIF
2005:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2006:                 .this_nTipos     = loc_oPg2.cbo_4c_Operacao.Value
2007:             ENDIF
2008:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2009:                 .this_cOperacaos = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2010:             ENDIF
2011:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2012:                 .this_dDataInis  = loc_oPg2.txt_4c_DataInicial.Value
2013:             ENDIF
2014:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2015:                 .this_dDataFims  = loc_oPg2.txt_4c_DataFinal.Value
2016:             ENDIF
2017:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2018:                 .this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2019:             ENDIF
2020:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2021:                 .this_cContas    = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2022:             ENDIF
2023:         ENDWITH
2024:     ENDPROC
2025: 
2026:     *--------------------------------------------------------------------------
2027:     * BOParaForm - Transfere dados do BO para os campos do Form
2028:     *--------------------------------------------------------------------------
2029:     PROCEDURE BOParaForm()
2030:         LOCAL loc_oPg2, loc_cGrupo, loc_cConta, loc_nResultado
2031:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2032: 
2033:         WITH THIS.this_oBusinessObject
2034:             IF VARTYPE(loc_oPg2.txt_4c_Codigo) = "O"
2035:                 loc_oPg2.txt_4c_Codigo.Value      = TRANSFORM(.this_nCodigos)
2036:             ENDIF
2037:             IF VARTYPE(loc_oPg2.cbo_4c_Operacao) = "O"
2038:                 loc_oPg2.cbo_4c_Operacao.Value    = .this_nTipos
2039:             ENDIF
2040:             IF VARTYPE(loc_oPg2.txt_4c_Oper) = "O"
2041:                 loc_oPg2.txt_4c_Oper.Value        = ALLTRIM(.this_cOperacaos)
2042:             ENDIF
2043:             IF VARTYPE(loc_oPg2.txt_4c_DataInicial) = "O"
2044:                 loc_oPg2.txt_4c_DataInicial.Value = .this_dDataInis
2045:             ENDIF
2046:             IF VARTYPE(loc_oPg2.txt_4c_DataFinal) = "O"
2047:                 loc_oPg2.txt_4c_DataFinal.Value   = .this_dDataFims
2048:             ENDIF
2049:             IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2050:                 loc_oPg2.txt_4c_Grupo.Value       = ALLTRIM(.this_cGrupos)
2051:             ENDIF
2052:             IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2053:                 loc_oPg2.txt_4c_Conta.Value       = ALLTRIM(.this_cContas)
2054:             ENDIF
2055:             loc_cGrupo = ALLTRIM(.this_cGrupos)
2056:             loc_cConta = ALLTRIM(.this_cContas)
2057:         ENDWITH
2058: 
2059:         *-- Buscar descricoes de Grupo e Conta para exibicao
2060:         TRY
2061:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2062:                 IF !EMPTY(loc_cGrupo)
2063:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2064:                         "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2065:                         "cursor_4c_DescGcr")
2066:                     IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2067:                         SELECT cursor_4c_DescGcr
2068:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2069:                     ELSE

*-- Linhas 2109 a 2248:
2109:     *--------------------------------------------------------------------------
2110:     * ValidOper - Valid handler: lookup SigCdOpt por operacaos (code = char 15)
2111:     *--------------------------------------------------------------------------
2112:     PROCEDURE ValidOper(par_nKeyCode, par_nShiftAltCtrl)
2113:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2114:         loc_lResultado = .T.
2115:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2116: 
2117:         IF VARTYPE(loc_oPg2.txt_4c_Oper) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2118:             RETURN .T.
2119:         ENDIF
2120: 
2121:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Oper.Value)
2122: 
2123:         IF EMPTY(loc_cCodigo)
2124:             RETURN .T.
2125:         ENDIF
2126: 
2127:         TRY
2128:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2129:                 "SELECT operacaos FROM SigCdOpt WHERE operacaos = " + EscaparSQL(loc_cCodigo), ;
2130:                 "cursor_4c_ChkOpt")
2131: 
2132:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkOpt") = 0
2133:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2134:                     "SigCdOpt", "cursor_4c_BuscaOpt", "operacaos", loc_cCodigo, ;
2135:                     "Opera" + CHR(231) + CHR(227) + "o")
2136: 
2137:                 IF VARTYPE(loc_oBusca) = "O"
2138:                     loc_oBusca.mAddColuna("operacaos", "", "C" + CHR(243) + "digo")
2139:                     loc_oBusca.mAddColuna("descrs",    "", "Descri" + CHR(231) + CHR(227) + "o")
2140:                     loc_oBusca.Show()
2141: 
2142:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2143:                         SELECT cursor_4c_BuscaOpt
2144:                         loc_oPg2.txt_4c_Oper.Value = IIF(!EOF("cursor_4c_BuscaOpt"), ;
2145:                             ALLTRIM(cursor_4c_BuscaOpt.operacaos), "")
2146:                     ELSE
2147:                         loc_oPg2.txt_4c_Oper.Value = ""
2148:                     ENDIF
2149: 
2150:                     loc_oBusca.Release()
2151:                 ENDIF
2152:             ENDIF
2153: 
2154:             IF USED("cursor_4c_ChkOpt")
2155:                 USE IN cursor_4c_ChkOpt
2156:             ENDIF
2157:             IF USED("cursor_4c_BuscaOpt")
2158:                 USE IN cursor_4c_BuscaOpt
2159:             ENDIF
2160:         CATCH TO loc_oErro
2161:             MsgErro(loc_oErro.Message, "FormBch.ValidOper")
2162:             IF USED("cursor_4c_ChkOpt")
2163:                 USE IN cursor_4c_ChkOpt
2164:             ENDIF
2165:             IF USED("cursor_4c_BuscaOpt")
2166:                 USE IN cursor_4c_BuscaOpt
2167:             ENDIF
2168:         ENDTRY
2169: 
2170:         RETURN loc_lResultado
2171:     ENDPROC
2172: 
2173:     *--------------------------------------------------------------------------
2174:     * ValidGrupo - Valid handler: lookup SigCdGcr por codigos, preenche DGrupo
2175:     *--------------------------------------------------------------------------
2176:     PROCEDURE ValidGrupo(par_nKeyCode, par_nShiftAltCtrl)
2177:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2178:         loc_lResultado = .T.
2179:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2180: 
2181:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2182:             RETURN .T.
2183:         ENDIF
2184: 
2185:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
2186: 
2187:         IF EMPTY(loc_cCodigo)
2188:             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2189:                 loc_oPg2.txt_4c_DGrupo.Value = ""
2190:             ENDIF
2191:             RETURN .T.
2192:         ENDIF
2193: 
2194:         TRY
2195:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2196:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
2197:                 "cursor_4c_ChkGcr")
2198: 
2199:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
2200:                 SELECT cursor_4c_ChkGcr
2201:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2202:                     loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
2203:                 ENDIF
2204:             ELSE
2205:                 IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2206:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2207:                 ENDIF
2208:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2209:                     "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
2210: 
2211:                 IF VARTYPE(loc_oBusca) = "O"
2212:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2213:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2214:                     loc_oBusca.Show()
2215: 
2216:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2217:                         SELECT cursor_4c_BuscaGcr
2218:                         IF !EOF("cursor_4c_BuscaGcr")
2219:                             loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2220:                             IF VARTYPE(loc_oPg2.txt_4c_DGrupo) = "O"
2221:                                 loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2222:                             ENDIF
2223:                         ELSE
2224:                             loc_oPg2.txt_4c_Grupo.Value = ""
2225:                         ENDIF
2226:                     ELSE
2227:                         loc_oPg2.txt_4c_Grupo.Value = ""
2228:                     ENDIF
2229: 
2230:                     loc_oBusca.Release()
2231:                 ENDIF
2232:             ENDIF
2233: 
2234:             IF USED("cursor_4c_ChkGcr")
2235:                 USE IN cursor_4c_ChkGcr
2236:             ENDIF
2237:             IF USED("cursor_4c_BuscaGcr")
2238:                 USE IN cursor_4c_BuscaGcr
2239:             ENDIF
2240:         CATCH TO loc_oErro
2241:             MsgErro(loc_oErro.Message, "FormBch.ValidGrupo")
2242:             IF USED("cursor_4c_ChkGcr")
2243:                 USE IN cursor_4c_ChkGcr
2244:             ENDIF
2245:             IF USED("cursor_4c_BuscaGcr")
2246:                 USE IN cursor_4c_BuscaGcr
2247:             ENDIF
2248:         ENDTRY

*-- Linhas 2254 a 2389:
2254:     * ValidDGrupo - Valid handler: busca reversa SigCdGcr por descrs
2255:     * Ativo apenas quando txt_4c_Grupo estiver vazio em modo INCLUIR
2256:     *--------------------------------------------------------------------------
2257:     PROCEDURE ValidDGrupo(par_nKeyCode, par_nShiftAltCtrl)
2258:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2259:         loc_lResultado = .T.
2260:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2261: 
2262:         IF VARTYPE(loc_oPg2.txt_4c_DGrupo) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2263:             RETURN .T.
2264:         ENDIF
2265: 
2266:         *-- Somente busca reversa quando Grupo estiver vazio
2267:         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
2268:             RETURN .T.
2269:         ENDIF
2270: 
2271:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DGrupo.Value))
2272:             RETURN .T.
2273:         ENDIF
2274: 
2275:         TRY
2276:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2277:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")
2278: 
2279:             IF VARTYPE(loc_oBusca) = "O"
2280:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2281:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2282:                 loc_oBusca.Show()
2283: 
2284:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
2285:                     SELECT cursor_4c_BuscaGcr
2286:                     IF !EOF("cursor_4c_BuscaGcr")
2287:                         IF VARTYPE(loc_oPg2.txt_4c_Grupo) = "O"
2288:                             loc_oPg2.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
2289:                         ENDIF
2290:                         loc_oPg2.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
2291:                     ELSE
2292:                         loc_oPg2.txt_4c_DGrupo.Value = ""
2293:                     ENDIF
2294:                 ELSE
2295:                     loc_oPg2.txt_4c_DGrupo.Value = ""
2296:                 ENDIF
2297: 
2298:                 loc_oBusca.Release()
2299:             ENDIF
2300: 
2301:             IF USED("cursor_4c_BuscaGcr")
2302:                 USE IN cursor_4c_BuscaGcr
2303:             ENDIF
2304:         CATCH TO loc_oErro
2305:             MsgErro(loc_oErro.Message, "FormBch.ValidDGrupo")
2306:             IF USED("cursor_4c_BuscaGcr")
2307:                 USE IN cursor_4c_BuscaGcr
2308:             ENDIF
2309:         ENDTRY
2310: 
2311:         RETURN loc_lResultado
2312:     ENDPROC
2313: 
2314:     *--------------------------------------------------------------------------
2315:     * ValidConta - Valid handler: lookup SIGCDCLI por iclis, preenche DConta
2316:     *--------------------------------------------------------------------------
2317:     PROCEDURE ValidConta(par_nKeyCode, par_nShiftAltCtrl)
2318:         LOCAL loc_oPg2, loc_cCodigo, loc_oBusca, loc_nResultado, loc_lResultado
2319:         loc_lResultado = .T.
2320:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2321: 
2322:         IF VARTYPE(loc_oPg2.txt_4c_Conta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2323:             RETURN .T.
2324:         ENDIF
2325: 
2326:         loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
2327: 
2328:         IF EMPTY(loc_cCodigo)
2329:             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2330:                 loc_oPg2.txt_4c_DConta.Value = ""
2331:             ENDIF
2332:             RETURN .T.
2333:         ENDIF
2334: 
2335:         TRY
2336:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2337:                 "SELECT iclis, razaos FROM SIGCDCLI WHERE iclis = " + EscaparSQL(loc_cCodigo), ;
2338:                 "cursor_4c_ChkCli")
2339: 
2340:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkCli") > 0
2341:                 SELECT cursor_4c_ChkCli
2342:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2343:                     loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ChkCli.razaos)
2344:                 ENDIF
2345:             ELSE
2346:                 IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2347:                     loc_oPg2.txt_4c_DConta.Value = ""
2348:                 ENDIF
2349:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2350:                     "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", loc_cCodigo, "Conta")
2351: 
2352:                 IF VARTYPE(loc_oBusca) = "O"
2353:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2354:                     loc_oBusca.mAddColuna("razaos", "", "Nome")
2355:                     loc_oBusca.Show()
2356: 
2357:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2358:                         SELECT cursor_4c_BuscaCli
2359:                         IF !EOF("cursor_4c_BuscaCli")
2360:                             loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
2361:                             IF VARTYPE(loc_oPg2.txt_4c_DConta) = "O"
2362:                                 loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2363:                             ENDIF
2364:                         ELSE
2365:                             loc_oPg2.txt_4c_Conta.Value = ""
2366:                         ENDIF
2367:                     ELSE
2368:                         loc_oPg2.txt_4c_Conta.Value = ""
2369:                     ENDIF
2370: 
2371:                     loc_oBusca.Release()
2372:                 ENDIF
2373:             ENDIF
2374: 
2375:             IF USED("cursor_4c_ChkCli")
2376:                 USE IN cursor_4c_ChkCli
2377:             ENDIF
2378:             IF USED("cursor_4c_BuscaCli")
2379:                 USE IN cursor_4c_BuscaCli
2380:             ENDIF
2381:         CATCH TO loc_oErro
2382:             MsgErro(loc_oErro.Message, "FormBch.ValidConta")
2383:             IF USED("cursor_4c_ChkCli")
2384:                 USE IN cursor_4c_ChkCli
2385:             ENDIF
2386:             IF USED("cursor_4c_BuscaCli")
2387:                 USE IN cursor_4c_BuscaCli
2388:             ENDIF
2389:         ENDTRY

*-- Linhas 2395 a 2540:
2395:     * ValidDConta - Valid handler: busca reversa SIGCDCLI por razaos
2396:     * Ativo apenas quando txt_4c_Conta estiver vazio em modo INCLUIR
2397:     *--------------------------------------------------------------------------
2398:     PROCEDURE ValidDConta(par_nKeyCode, par_nShiftAltCtrl)
2399:         LOCAL loc_oPg2, loc_oBusca, loc_lResultado
2400:         loc_lResultado = .T.
2401:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2402: 
2403:         IF VARTYPE(loc_oPg2.txt_4c_DConta) != "O" OR THIS.this_cModoAtual = "VISUALIZAR"
2404:             RETURN .T.
2405:         ENDIF
2406: 
2407:         *-- Somente busca reversa quando Conta estiver vazia
2408:         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O" AND !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
2409:             RETURN .T.
2410:         ENDIF
2411: 
2412:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_DConta.Value))
2413:             RETURN .T.
2414:         ENDIF
2415: 
2416:         TRY
2417:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2418:                 "SIGCDCLI", "cursor_4c_BuscaCli", "iclis", "", "Conta")
2419: 
2420:             IF VARTYPE(loc_oBusca) = "O"
2421:                 loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
2422:                 loc_oBusca.mAddColuna("razaos", "", "Nome")
2423:                 loc_oBusca.Show()
2424: 
2425:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2426:                     SELECT cursor_4c_BuscaCli
2427:                     IF !EOF("cursor_4c_BuscaCli")
2428:                         IF VARTYPE(loc_oPg2.txt_4c_Conta) = "O"
2429:                             loc_oPg2.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.iclis)
2430:                         ENDIF
2431:                         loc_oPg2.txt_4c_DConta.Value = ALLTRIM(cursor_4c_BuscaCli.razaos)
2432:                     ELSE
2433:                         loc_oPg2.txt_4c_DConta.Value = ""
2434:                     ENDIF
2435:                 ELSE
2436:                     loc_oPg2.txt_4c_DConta.Value = ""
2437:                 ENDIF
2438: 
2439:                 loc_oBusca.Release()
2440:             ENDIF
2441: 
2442:             IF USED("cursor_4c_BuscaCli")
2443:                 USE IN cursor_4c_BuscaCli
2444:             ENDIF
2445:         CATCH TO loc_oErro
2446:             MsgErro(loc_oErro.Message, "FormBch.ValidDConta")
2447:             IF USED("cursor_4c_BuscaCli")
2448:                 USE IN cursor_4c_BuscaCli
2449:             ENDIF
2450:         ENDTRY
2451: 
2452:         RETURN loc_lResultado
2453:     ENDPROC
2454: 
2455:     *--------------------------------------------------------------------------
2456:     * TornarControlesVisiveis - Torna controles do container visiveis recursivamente
2457:     *--------------------------------------------------------------------------
2458:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2459:         LOCAL loc_i, loc_oControl, loc_nP
2460: 
2461:         IF VARTYPE(par_oContainer) != "O"
2462:             RETURN
2463:         ENDIF
2464: 
2465:         FOR loc_i = 1 TO par_oContainer.ControlCount
2466:             loc_oControl = par_oContainer.Controls(loc_i)
2467: 
2468:             IF VARTYPE(loc_oControl) = "O"
2469:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2470:                     loc_oControl.Visible = .T.
2471:                 ENDIF
2472: 
2473:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2474:                     FOR loc_nP = 1 TO loc_oControl.PageCount
2475:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
2476:                     ENDFOR
2477:                 ENDIF
2478: 
2479:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2480:                     THIS.TornarControlesVisiveis(loc_oControl)
2481:                 ENDIF
2482:             ENDIF
2483:         ENDFOR
2484:     ENDPROC
2485: 
2486:     *--------------------------------------------------------------------------
2487:     * CarregarLeitura - Popula Page3 quando entra no modo LEITURA
2488:     *--------------------------------------------------------------------------
2489:     PROTECTED PROCEDURE CarregarLeitura()
2490:         LOCAL loc_nCodigos
2491:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
2492:         THIS.PopularCamposLeitura()
2493:         THIS.CarregarGradeLeitura(loc_nCodigos)
2494:         THIS.LimparCamposLeitura()
2495:     ENDPROC
2496: 
2497:     *--------------------------------------------------------------------------
2498:     * PopularCamposLeitura - Preenche campos readonly da Page3 com dados do BO
2499:     *--------------------------------------------------------------------------
2500:     PROTECTED PROCEDURE PopularCamposLeitura()
2501:         LOCAL loc_oPg3, loc_oBO, loc_cGrupo, loc_cConta, loc_cOperacaos, loc_nResultado
2502:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2503:         loc_oBO  = THIS.this_oBusinessObject
2504: 
2505:         WITH loc_oBO
2506:             IF VARTYPE(loc_oPg3.txt_4c_CodDisp) = "O"
2507:                 loc_oPg3.txt_4c_CodDisp.Value    = TRANSFORM(.this_nCodigos)
2508:             ENDIF
2509:             IF VARTYPE(loc_oPg3.txt_4c_OperDisp) = "O"
2510:                 loc_oPg3.txt_4c_OperDisp.Value   = ALLTRIM(.this_cOperacaos)
2511:             ENDIF
2512:             IF VARTYPE(loc_oPg3.txt_4c_DataIniDisp) = "O"
2513:                 loc_oPg3.txt_4c_DataIniDisp.Value = .this_dDataInis
2514:             ENDIF
2515:             IF VARTYPE(loc_oPg3.txt_4c_DataFimDisp) = "O"
2516:                 loc_oPg3.txt_4c_DataFimDisp.Value = .this_dDataFims
2517:             ENDIF
2518:             IF VARTYPE(loc_oPg3.txt_4c_GrupoDisp) = "O"
2519:                 loc_oPg3.txt_4c_GrupoDisp.Value  = ALLTRIM(.this_cGrupos)
2520:             ENDIF
2521:             IF VARTYPE(loc_oPg3.txt_4c_ContaDisp) = "O"
2522:                 loc_oPg3.txt_4c_ContaDisp.Value  = ALLTRIM(.this_cContas)
2523:             ENDIF
2524:             loc_cGrupo     = ALLTRIM(.this_cGrupos)
2525:             loc_cConta     = ALLTRIM(.this_cContas)
2526:             loc_cOperacaos = ALLTRIM(.this_cOperacaos)
2527:         ENDWITH
2528: 
2529:         TRY
2530:             IF !EMPTY(loc_cGrupo) AND VARTYPE(loc_oPg3.txt_4c_DGrupoDisp) = "O"
2531:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2532:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupo), ;
2533:                     "cursor_4c_DescGcr")
2534:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DescGcr") > 0
2535:                     SELECT cursor_4c_DescGcr
2536:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ALLTRIM(cursor_4c_DescGcr.descrs)
2537:                 ELSE
2538:                     loc_oPg3.txt_4c_DGrupoDisp.Value = ""
2539:                 ENDIF
2540:                 IF USED("cursor_4c_DescGcr")

*-- Linhas 2589 a 2775:
2589:     * CarregarGradeLeitura - Carrega SigCqHis em cursor_4c_Historico
2590:     * Usa padrao Problem #34: placeholder CREATE CURSOR + ZAP + APPEND FROM
2591:     *--------------------------------------------------------------------------
2592:     PROTECTED PROCEDURE CarregarGradeLeitura(par_nCodigos)
2593:         LOCAL loc_cSQL, loc_nResultado
2594: 
2595:         TRY
2596:             IF !USED("cursor_4c_Historico")
2597:                 SET NULL ON
2598:                 CREATE CURSOR cursor_4c_Historico ;
2599:                     (codigos N(6,0), bancos C(10), agencias C(10), ncontas C(10), ;
2600:                      ncheques C(10), tipos N(1,0), datas D, usuarios C(15), ;
2601:                      valors N(14,2), vencs D)
2602:                 SET NULL OFF
2603:             ENDIF
2604: 
2605:             loc_cSQL = "SELECT codigos, bancos, agencias, ncontas, ncheques, tipos, datas," + ;
2606:                        " usuarios, valors, vencs" + ;
2607:                        " FROM SigCqHis WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
2608:                        " ORDER BY datas, ncheques"
2609: 
2610:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
2611: 
2612:             IF loc_nResultado >= 0
2613:                 SELECT cursor_4c_Historico
2614:                 ZAP
2615:                 IF RECCOUNT("cursor_4c_HistoricoTemp") > 0
2616:                     APPEND FROM DBF("cursor_4c_HistoricoTemp")
2617:                 ENDIF
2618:                 IF USED("cursor_4c_HistoricoTemp")
2619:                     USE IN cursor_4c_HistoricoTemp
2620:                 ENDIF
2621:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura) = "O"
2622:                     THIS.pgf_4c_Paginas.Page3.grd_4c_Leitura.Refresh()
2623:                 ENDIF
2624:             ELSE
2625:                 MsgErro("Erro ao carregar hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2626:             ENDIF
2627:         CATCH TO loc_oErro
2628:             MsgErro(loc_oErro.Message, "FormBch.CarregarGradeLeitura")
2629:             IF USED("cursor_4c_HistoricoTemp")
2630:                 USE IN cursor_4c_HistoricoTemp
2631:             ENDIF
2632:         ENDTRY
2633:     ENDPROC
2634: 
2635:     *--------------------------------------------------------------------------
2636:     * LimparCamposLeitura - Limpa campos de entrada manual da Page3
2637:     *--------------------------------------------------------------------------
2638:     PROTECTED PROCEDURE LimparCamposLeitura()
2639:         LOCAL loc_oPg3
2640:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2641: 
2642:         IF VARTYPE(loc_oPg3.txt_4c_Bco) = "O"
2643:             loc_oPg3.txt_4c_Bco.Value = ""
2644:         ENDIF
2645:         IF VARTYPE(loc_oPg3.txt_4c_Age) = "O"
2646:             loc_oPg3.txt_4c_Age.Value = ""
2647:         ENDIF
2648:         IF VARTYPE(loc_oPg3.txt_4c_ContaLei) = "O"
2649:             loc_oPg3.txt_4c_ContaLei.Value = ""
2650:         ENDIF
2651:         IF VARTYPE(loc_oPg3.txt_4c_Num) = "O"
2652:             loc_oPg3.txt_4c_Num.Value = ""
2653:         ENDIF
2654:         IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2655:             loc_oPg3.txt_4c_Valor.Value = 0
2656:         ENDIF
2657:         IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2658:             loc_oPg3.txt_4c_Vecto.Value = {}
2659:         ENDIF
2660:     ENDPROC
2661: 
2662:     *--------------------------------------------------------------------------
2663:     * NumGetLostFocus - Valida cheque em SigCqBal e insere em SigCqHis
2664:     *--------------------------------------------------------------------------
2665:     PROCEDURE NumGetLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2666:         LOCAL loc_oPg3, loc_cBco, loc_cAge, loc_cConta, loc_cNum
2667:         LOCAL loc_nCodigos, loc_nTipos, loc_cSQL, loc_nResultado
2668:         LOCAL loc_nValor, loc_dVecto, loc_lContinuar
2669:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
2670: 
2671:         IF VARTYPE(loc_oPg3.txt_4c_Bco) != "O" OR ;
2672:            VARTYPE(loc_oPg3.txt_4c_Age) != "O" OR ;
2673:            VARTYPE(loc_oPg3.txt_4c_ContaLei) != "O" OR ;
2674:            VARTYPE(loc_oPg3.txt_4c_Num) != "O"
2675:             RETURN
2676:         ENDIF
2677: 
2678:         loc_cBco   = ALLTRIM(loc_oPg3.txt_4c_Bco.Value)
2679:         loc_cAge   = ALLTRIM(loc_oPg3.txt_4c_Age.Value)
2680:         loc_cConta = ALLTRIM(loc_oPg3.txt_4c_ContaLei.Value)
2681:         loc_cNum   = ALLTRIM(loc_oPg3.txt_4c_Num.Value)
2682: 
2683:         IF EMPTY(loc_cNum) OR EMPTY(loc_cBco) OR EMPTY(loc_cAge) OR EMPTY(loc_cConta)
2684:             RETURN
2685:         ENDIF
2686: 
2687:         TRY
2688:             loc_nCodigos   = THIS.this_oBusinessObject.this_nCodigos
2689:             loc_lContinuar = .T.
2690:             IF VARTYPE(loc_oPg3.opt_4c_TipoLeitura) = "O"
2691:                 loc_nTipos = loc_oPg3.opt_4c_TipoLeitura.Value
2692:             ELSE
2693:                 loc_nTipos = 1
2694:             ENDIF
2695: 
2696:             *-- Verificar se cheque existe no balanco
2697:             loc_nResultado = SQLEXEC(gnConnHandle, ;
2698:                 "SELECT valors, vencs FROM SigCqBal" + ;
2699:                 " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2700:                 " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2701:                 " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2702:                 " AND NContas = " + EscaparSQL(loc_cConta) + ;
2703:                 " AND NCheques = " + EscaparSQL(loc_cNum), ;
2704:                 "cursor_4c_VerifBal")
2705: 
2706:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_VerifBal") = 0
2707:                 MsgAviso("Cheque n" + CHR(227) + "o encontrado no balan" + CHR(231) + "o!", "")
2708:                 IF USED("cursor_4c_VerifBal")
2709:                     USE IN cursor_4c_VerifBal
2710:                 ENDIF
2711:                 loc_lContinuar = .F.
2712:             ENDIF
2713: 
2714:             IF loc_lContinuar
2715:                 SELECT cursor_4c_VerifBal
2716:                 loc_nValor = TratarNulo(valors, "N")
2717:                 loc_dVecto = TratarNulo(vencs,  "D")
2718:                 IF USED("cursor_4c_VerifBal")
2719:                     USE IN cursor_4c_VerifBal
2720:                 ENDIF
2721: 
2722:                 *-- Verificar duplicidade no historico
2723:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2724:                     "SELECT COUNT(*) AS qtd FROM SigCqHis" + ;
2725:                     " WHERE Codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
2726:                     " AND Bancos = " + EscaparSQL(loc_cBco) + ;
2727:                     " AND Agencias = " + EscaparSQL(loc_cAge) + ;
2728:                     " AND NContas = " + EscaparSQL(loc_cConta) + ;
2729:                     " AND NCheques = " + EscaparSQL(loc_cNum), ;
2730:                     "cursor_4c_VerifDup")
2731: 
2732:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerifDup") > 0
2733:                     SELECT cursor_4c_VerifDup
2734:                     IF cursor_4c_VerifDup.qtd > 0
2735:                         MsgAviso("Cheque j" + CHR(225) + " consta no hist" + CHR(243) + "rico!", "")
2736:                         loc_lContinuar = .F.
2737:                     ENDIF
2738:                 ENDIF
2739:                 IF USED("cursor_4c_VerifDup")
2740:                     USE IN cursor_4c_VerifDup
2741:                 ENDIF
2742:             ENDIF
2743: 
2744:             IF loc_lContinuar
2745:                 *-- Inserir no historico de leitura
2746:                 loc_cSQL = "INSERT INTO SigCqHis" + ;
2747:                            " (codigos, bancos, agencias, ncontas, ncheques, tipos, datas, usuarios, valors, vencs)" + ;
2748:                            " VALUES (" + ;
2749:                            FormatarNumeroSQL(loc_nCodigos) + "," + ;
2750:                            EscaparSQL(LEFT(loc_cBco,   10)) + "," + ;
2751:                            EscaparSQL(LEFT(loc_cAge,   10)) + "," + ;
2752:                            EscaparSQL(LEFT(loc_cConta, 10)) + "," + ;
2753:                            EscaparSQL(LEFT(loc_cNum,   10)) + "," + ;
2754:                            FormatarNumeroSQL(loc_nTipos) + "," + ;
2755:                            "GETDATE()," + ;
2756:                            EscaparSQL(LEFT(gc_4c_UsuarioLogado, 15)) + "," + ;
2757:                            FormatarNumeroSQL(loc_nValor) + "," + ;
2758:                            FormatarDataSQL(loc_dVecto) + ;
2759:                            ")"
2760: 
2761:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
2762: 
2763:                 IF loc_nResultado >= 0
2764:                     IF VARTYPE(loc_oPg3.txt_4c_Valor) = "O"
2765:                         loc_oPg3.txt_4c_Valor.Value = loc_nValor
2766:                     ENDIF
2767:                     IF VARTYPE(loc_oPg3.txt_4c_Vecto) = "O"
2768:                         loc_oPg3.txt_4c_Vecto.Value = loc_dVecto
2769:                     ENDIF
2770:                     THIS.CarregarGradeLeitura(loc_nCodigos)
2771:                     THIS.LimparCamposLeitura()
2772:                 ELSE
2773:                     MsgErro("Erro ao inserir no hist" + CHR(243) + "rico: " + CapturarErroSQL(), "Erro SQL")
2774:                 ENDIF
2775:             ENDIF

*-- Linhas 2787 a 2834:
2787:     *--------------------------------------------------------------------------
2788:     * FormatarGridLista - Formata Grid da lista apos carregar dados
2789:     *--------------------------------------------------------------------------
2790:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2791:         IF VARTYPE(par_oGrid) != "O"
2792:             RETURN
2793:         ENDIF
2794: 
2795:         WITH par_oGrid
2796:             .FontName = "Verdana"
2797:             .FontSize = 8
2798:         ENDWITH
2799:     ENDPROC
2800: 
2801:     *--------------------------------------------------------------------------
2802:     * Destroy - Libera recursos do form
2803:     *--------------------------------------------------------------------------
2804:     PROCEDURE Destroy()
2805:         LOCAL loc_oErro
2806: 
2807:         TRY
2808:             IF USED("cursor_4c_Dados")
2809:                 USE IN cursor_4c_Dados
2810:             ENDIF
2811:             IF USED("cursor_4c_Historico")
2812:                 USE IN cursor_4c_Historico
2813:             ENDIF
2814:             IF USED("cursor_4c_HistoricoTemp")
2815:                 USE IN cursor_4c_HistoricoTemp
2816:             ENDIF
2817:             IF USED("Balanco")
2818:                 USE IN Balanco
2819:             ENDIF
2820:             IF USED("Historico")
2821:                 USE IN Historico
2822:             ENDIF
2823: 
2824:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2825:                 THIS.this_oBusinessObject = .NULL.
2826:             ENDIF
2827:         CATCH TO loc_oErro
2828:             MsgErro(loc_oErro.Message, "FormBch.Destroy")
2829:         ENDTRY
2830: 
2831:         DODEFAULT()
2832:     ENDPROC
2833: 
2834: ENDDEFINE


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

