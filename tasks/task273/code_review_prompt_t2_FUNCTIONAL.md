# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterNodeValue()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_cConta define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_cConta.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPgDados.Page2.grd_4c_ItemXml define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPgDados.Page2.grd_4c_ItemXml.RecordSource).
- [GRID-WITH] Bloco WITH loc_nTot define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nTot.RecordSource).
- [GRID-HEADER] Header Caption 'Número' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Lista): Top original=106 vs migrado 'lbl_4c_Label1' Top=213 (diff=107px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Lista): Left original=440 vs migrado 'lbl_4c_Label1' Left=55 (diff=385px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3779 linhas total):

*-- Linhas 38 a 190:
38:     this_dDataFinal      = {}
39: 
40:     *--------------------------------------------------------------------------
41:     * Init - Delega para FormBase que chama InicializarForm
42:     *--------------------------------------------------------------------------
43:     PROCEDURE Init()
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             loc_lSucesso = DODEFAULT()
49:         CATCH TO loc_oErro
50:             MsgErro("Erro em FormSigPrCtr.Init:" + CHR(13) + loc_oErro.Message + ;
51:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
52:         ENDTRY
53: 
54:         RETURN loc_lSucesso
55:     ENDPROC
56: 
57:     *--------------------------------------------------------------------------
58:     * InicializarForm - Cria BO e monta estrutura visual
59:     * Chamado por FormBase.Init() via DODEFAULT()
60:     *--------------------------------------------------------------------------
61:     PROTECTED PROCEDURE InicializarForm()
62:         LOCAL loc_lSucesso
63:         loc_lSucesso = .F.
64: 
65:         TRY
66:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")
67: 
68:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
69:                 MsgErro("Erro ao criar SigPrCtrBO", "Erro")
70:             ELSE
71:                 THIS.this_dDataInicial = DATE()
72:                 THIS.this_dDataFinal   = DATE()
73: 
74:                 THIS.ConfigurarPageFrame()
75:                 THIS.ConfigurarPaginaLista()
76:                 THIS.ConfigurarPaginaDados()
77: 
78:                 *-- Propaga Caption para labels do cabecalho
79:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Cabecalho", 5)
80:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
81:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
82:                     ENDIF
83:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho, "lbl_4c_Titulo", 5)
84:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
85:                     ENDIF
86:                 ENDIF
87: 
88:                 THIS.CarregarLista()
89: 
90:                 THIS.pgf_4c_Paginas.Visible    = .T.
91:                 THIS.pgf_4c_Paginas.ActivePage = 1
92:                 THIS.this_cModoAtual = "LISTA"
93: 
94:                 SET DATE TO BRITISH
95:                 SET CENTURY ON
96: 
97:                 loc_lSucesso = .T.
98:             ENDIF
99:         CATCH TO loc_oErro
100:             MsgErro("Erro em FormSigPrCtr.InicializarForm:" + CHR(13) + loc_oErro.Message + ;
101:                     " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro")
102:         ENDTRY
103: 
104:         RETURN loc_lSucesso
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------
108:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
109:     * Top=-29 oculta as abas; Pages compensam +29 em seus controles diretos
110:     *--------------------------------------------------------------------------
111:     PROTECTED PROCEDURE ConfigurarPageFrame()
112:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
113: 
114:         WITH THIS.pgf_4c_Paginas
115:             .PageCount = 2
116:             .Top       = -29
117:             .Left      = 0
118:             .Width     = THIS.Width
119:             .Height    = THIS.Height + 29
120:             .Tabs      = .F.
121:         ENDWITH
122: 
123:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
124:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
125:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
126: 
127:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
128:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
129:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
130:     ENDPROC
131: 
132:     *--------------------------------------------------------------------------
133:     * ConfigurarPaginaLista - Containers da Page1 (Lista)
134:     * cnt_4c_Cabecalho : barra cinza escura com titulo
135:     * cnt_4c_Botoes    : container CRUD - botoes adicionados na Fase 4
136:     * cnt_4c_Saida     : container canonico com cmd_4c_Encerrar
137:     * Grid e filtros de data sao adicionados na Fase 4
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarPaginaLista()
140:         LOCAL loc_oPagina
141:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
142: 
143:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
144:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
145: 
146:         *-- Container cabecalho (cntSombra do legado: Top=2+29=31)
147:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
148:         WITH loc_oPagina.cnt_4c_Cabecalho
149:             .Top         = 31
150:             .Left        = 0
151:             .Width       = THIS.Width
152:             .Height      = 80
153:             .BackColor   = RGB(100, 100, 100)
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
159:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
160:             .AutoSize  = .F.
161:             .Caption   = THIS.Caption
162:             .Top       = 15
163:             .Left      = 10
164:             .Width     = THIS.Width - 20
165:             .Height    = 40
166:             .FontName  = "Tahoma"
167:             .FontSize  = 16
168:             .FontBold  = .T.
169:             .ForeColor = RGB(0, 0, 0)
170:             .BackStyle = 0
171:             .Visible   = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
175:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
176:             .AutoSize  = .F.
177:             .Caption   = THIS.Caption
178:             .Top       = 18
179:             .Left      = 10
180:             .Width     = THIS.Width - 20
181:             .Height    = 46
182:             .FontName  = "Tahoma"
183:             .FontSize  = 16
184:             .FontBold  = .T.
185:             .ForeColor = RGB(255, 255, 255)
186:             .BackStyle = 0
187:             .Visible   = .T.
188:         ENDWITH
189: 
190:         *-- Container botoes CRUD (Grupo_Op: Left escalonado para 1200px)

*-- Linhas 223 a 835:
223:             .AutoSize = .F.
224:             .Visible = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
227: 
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
230:             .Caption = "Visualizar"
231:             .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
232:             .PicturePosition = 13
233:             .Top = 5
234:             .Left = 80
235:             .Width = 75
236:             .Height = 75
237:             .BackColor = RGB(255,255,255)
238:             .ForeColor = RGB(90,90,90)
239:             .FontName = "Tahoma"
240:             .FontSize = 8
241:             .FontBold = .T.
242:             .FontItalic = .T.
243:             .Themes = .F.
244:             .SpecialEffect = 0
245:             .MousePointer = 15
246:             .WordWrap = .T.
247:             .AutoSize = .F.
248:             .Visible = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
251: 
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
254:             .Caption = "Alterar"
255:             .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
256:             .PicturePosition = 13
257:             .Top = 5
258:             .Left = 155
259:             .Width = 75
260:             .Height = 75
261:             .BackColor = RGB(255,255,255)
262:             .ForeColor = RGB(90,90,90)
263:             .FontName = "Tahoma"
264:             .FontSize = 8
265:             .FontBold = .T.
266:             .FontItalic = .T.
267:             .Themes = .F.
268:             .SpecialEffect = 0
269:             .MousePointer = 15
270:             .WordWrap = .T.
271:             .AutoSize = .F.
272:             .Visible = .T.
273:         ENDWITH
274:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
275: 
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption = "Excluir"
279:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top = 5
282:             .Left = 230
283:             .Width = 75
284:             .Height = 75
285:             .BackColor = RGB(255,255,255)
286:             .ForeColor = RGB(90,90,90)
287:             .FontName = "Tahoma"
288:             .FontSize = 8
289:             .FontBold = .T.
290:             .FontItalic = .T.
291:             .Themes = .F.
292:             .SpecialEffect = 0
293:             .MousePointer = 15
294:             .WordWrap = .T.
295:             .AutoSize = .F.
296:             .Visible = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
301:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
302:             .Caption = "Buscar"
303:             .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
304:             .PicturePosition = 13
305:             .Top = 5
306:             .Left = 305
307:             .Width = 75
308:             .Height = 75
309:             .BackColor = RGB(255,255,255)
310:             .ForeColor = RGB(90,90,90)
311:             .FontName = "Tahoma"
312:             .FontSize = 8
313:             .FontBold = .T.
314:             .FontItalic = .T.
315:             .Themes = .F.
316:             .SpecialEffect = 0
317:             .MousePointer = 15
318:             .WordWrap = .T.
319:             .AutoSize = .F.
320:             .Visible = .T.
321:         ENDWITH
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
323: 
324:         *-- Container de saida canonico: Left = THIS.Width - 83 = 1117
325:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
326:         WITH loc_oPagina.cnt_4c_Saida
327:             .Top         = 29
328:             .Left        = 917
329:             .Width       = 90
330:             .Height      = 85
331:             .BackStyle   = 0
332:             .BorderWidth = 0
333:             .Visible     = .T.
334:         ENDWITH
335: 
336:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
337:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
338:             .Caption         = "Encerrar"
339:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
340:             .PicturePosition = 13
341:             .Top = 5
342:             .Left = 5
343:             .Width = 75
344:             .Height = 75
345:             .BackColor = RGB(255,255,255)
346:             .ForeColor = RGB(90,90,90)
347:             .FontName = "Tahoma"
348:             .FontSize = 8
349:             .FontBold = .T.
350:             .FontItalic = .T.
351:             .Themes = .F.
352:             .SpecialEffect = 0
353:             .MousePointer = 15
354:             .WordWrap = .T.
355:             .AutoSize = .F.
356:             .Visible = .T.
357:         ENDWITH
358:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
359: 
360:         *-- Filtros de data (original: Dt_inicial top=102, left=495; Dt_final top=102, left=598)
361:         *-- Compensacao PageFrame +29: top=131
362:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
363:         WITH loc_oPagina.lbl_4c_Label1
364:             .Caption  = "\<Per" + CHR(237) + "odo :"
365:             .Top = 135
366:             .Left = 440
367:             .Width = 52
368:             .Height = 15
369:             .FontName = "Tahoma"
370:             .FontSize = 8
371:             .Visible  = .T.
372:         ENDWITH
373: 
374:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
375:         WITH loc_oPagina.txt_4c_DtInicial
376:             .Value  = DATE()
377:             .Format = "D"
378:             .Top = 131
379:             .Left = 495
380:             .Width = 80
381:             .Height = 21
382:             .FontName = "Tahoma"
383:             .FontSize = 8
384:             .Visible = .T.
385:         ENDWITH
386:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
387: 
388:         loc_oPagina.AddObject("lbl_4c_Sep", "Label")
389:         WITH loc_oPagina.lbl_4c_Sep
390:             .Caption  = "-"
391:             .Top = 135
392:             .Left = 578
393:             .Width = 15
394:             .Height = 15
395:             .FontName = "Tahoma"
396:             .FontSize = 8
397:             .Visible  = .T.
398:         ENDWITH
399: 
400:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
401:         WITH loc_oPagina.txt_4c_DtFinal
402:             .Value  = DATE()
403:             .Format = "D"
404:             .Top = 131
405:             .Left = 598
406:             .Width = 80
407:             .Height = 21
408:             .FontName = "Tahoma"
409:             .FontSize = 8
410:             .Visible = .T.
411:         ENDWITH
412:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
413: 
414:         *-- Grid de lista de lotes - abaixo dos filtros de data
415:         *-- ColumnCount ANTES do WITH para que Column1..N existam no bloco
416:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
417:         loc_oPagina.grd_4c_Dados.Top         = 155
418:         loc_oPagina.grd_4c_Dados.Left        = 12
419:         loc_oPagina.grd_4c_Dados.Width       = 1100
420:         loc_oPagina.grd_4c_Dados.Height      = 430
421:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
422:         WITH loc_oPagina.grd_4c_Dados
423:             .FontName           = "Verdana"
424:             .FontSize           = 8
425:             .ForeColor          = RGB(90, 90, 90)
426:             .BackColor          = RGB(255, 255, 255)
427:             .GridLineColor      = RGB(238, 238, 238)
428:             .HighlightBackColor = RGB(255, 255, 255)
429:             .HighlightForeColor = RGB(15, 41, 104)
430:             .HighlightStyle     = 2
431:             .DeleteMark         = .F.
432:             .RecordMark         = .F.
433:             .RowHeight          = 16
434:             .ScrollBars         = 2
435:             .GridLines          = 3
436:             .Visible            = .T.
437:             .Column1.Width = 80
438:             .Column2.Width = 90
439:             .Column3.Width = 90
440:             .Column4.Width = 320
441:             .Column5.Width = 120
442:             .Column6.Width = 120
443:         ENDWITH
444: 
445:         THIS.TornarControlesVisiveis(loc_oPagina)
446:     ENDPROC
447: 
448:     *--------------------------------------------------------------------------
449:     * ConfigurarPaginaDados - Containers da Page2 (Dados)
450:     * cnt_4c_BotoesAcao : Confirmar / Cancelar
451:     * pgf_4c_Dados      : PageFrame interno (original: Pageframe1 top=3, left=-1)
452:     *   Page1: campos lote + grdEstoque + OptionGroups (Fases 5-6)
453:     *   Page2: grdDisponivel + grdItemXml + campos produto (Fase 7)
454:     *--------------------------------------------------------------------------
455:     PROTECTED PROCEDURE ConfigurarPaginaDados()
456:         LOCAL loc_oPagina
457:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
458: 
459:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
460:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
461: 
462:         *-- Container botoes Confirmar/Cancelar (canonico: Top=4+29=33, Left=1042)
463:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
464:         WITH loc_oPagina.cnt_4c_BotoesAcao
465:             .Top         = 33
466:             .Left        = 1042
467:             .Width       = 160
468:             .Height      = 85
469:             .BackStyle   = 0
470:             .Visible     = .T.
471:         ENDWITH
472: 
473:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
474:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
475:             .Caption = "Confirmar"
476:             .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
477:             .PicturePosition = 13
478:             .Top = 5
479:             .Left = 5
480:             .Width = 75
481:             .Height = 75
482:             .BackColor = RGB(255,255,255)
483:             .ForeColor = RGB(90,90,90)
484:             .FontName = "Tahoma"
485:             .FontSize = 8
486:             .FontBold = .T.
487:             .FontItalic = .T.
488:             .Themes = .F.
489:             .SpecialEffect = 0
490:             .MousePointer = 15
491:             .WordWrap = .T.
492:             .AutoSize = .F.
493:             .Visible = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
496: 
497:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
498:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
499:             .Caption = "Encerrar"
500:             .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
501:             .PicturePosition = 13
502:             .Top = 5
503:             .Left = 80
504:             .Width = 75
505:             .Height = 75
506:             .BackColor = RGB(255,255,255)
507:             .ForeColor = RGB(90,90,90)
508:             .FontName = "Tahoma"
509:             .FontSize = 8
510:             .FontBold = .T.
511:             .FontItalic = .T.
512:             .Themes = .F.
513:             .SpecialEffect = 0
514:             .MousePointer = 15
515:             .WordWrap = .T.
516:             .AutoSize = .F.
517:             .Visible = .T.
518:         ENDWITH
519:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
520: 
521:         *-- PageFrame interno (Pageframe1 do legado: top=3+29=32, left=-1)
522:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
523:         WITH loc_oPagina.pgf_4c_Dados
524:             .PageCount = 2
525:             .Top       = 32
526:             .Left      = -1
527:             .Width     = THIS.Width + 1
528:             .Height    = 617
529:             .Tabs      = .F.
530:         ENDWITH
531: 
532:         loc_oPagina.pgf_4c_Dados.Page1.Caption   = "Lote"
533:         loc_oPagina.pgf_4c_Dados.Page1.BackColor = RGB(255, 255, 255)
534: 
535:         loc_oPagina.pgf_4c_Dados.Page2.Caption   = "Itens"
536:         loc_oPagina.pgf_4c_Dados.Page2.BackColor = RGB(255, 255, 255)
537: 
538:         THIS.ConfigurarPaginaDadosLote()
539:         THIS.ConfigurarPaginaDadosDetalhe()
540:         THIS.TornarControlesVisiveis(loc_oPagina)
541:     ENDPROC
542: 
543:     *--------------------------------------------------------------------------
544:     * ConfigurarPaginaDadosLote - Controles do pgf_4c_Dados.Page1 (Lote)
545:     * Campos do lote: Grupo, Conta, Dconta, Cpf, Moeda, Arquivo
546:     * OptionGroups: opt_4c_Custo (2 botoes), opt_4c_Fil (3 botoes)
547:     * Botoes: cmd_4c_Processar, cmd_4c_BotConsulta, cmd_4c_BtnCadastros,
548:     *         cmd_4c_Command12, cmd_4c_CmdOperacao (CommandGroup)
549:     * Grid: grd_4c_Estoque (5 colunas: Empresa, Movimentacao, Numero, Grupo, Conta)
550:     * Offset +29 em Top para compensar aba oculta do inner PageFrame
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarPaginaDadosLote()
553:         LOCAL loc_oPg2P1
554:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
555: 
556:         *-- Label: Fornecedores (Say4: top=69+29=98)
557:         loc_oPg2P1.AddObject("lbl_4c_Forn", "Label")
558:         WITH loc_oPg2P1.lbl_4c_Forn
559:             .Caption   = "Fornecedores :"
560:             .AutoSize  = .T.
561:             .Top = 98
562:             .Left = 228
563:             .Height = 15
564:             .FontName  = "Tahoma"
565:             .FontSize = 8
566:             .BackStyle = 0
567:             .Visible = .T.
568:         ENDWITH
569: 
570:         *-- TextBox: Get_Grupo / txt_4c_Grupo (top=66+29=95)
571:         loc_oPg2P1.AddObject("txt_4c_Grupo", "TextBox")
572:         WITH loc_oPg2P1.txt_4c_Grupo
573:             .Value = ""
574:             .MaxLength = 10
575:             .Format = "K"
576:             .Top = 95
577:             .Left = 307
578:             .Width = 85
579:             .Height = 21
580:             .FontName = "Tahoma"
581:             .FontSize = 8
582:             .SpecialEffect = 1
583:             .Visible = .T.
584:         ENDWITH
585:         BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoLostFocus")
586:         BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "KeyPress",  THIS, "TxtGrupoKeyPress")
587:         BINDEVENT(loc_oPg2P1.txt_4c_Grupo, "DblClick",  THIS, "TxtGrupoDblClick")
588: 
589:         *-- TextBox: Get_Conta / txt_4c_Conta (top=66+29=95, left=394)
590:         loc_oPg2P1.AddObject("txt_4c_Conta", "TextBox")
591:         WITH loc_oPg2P1.txt_4c_Conta
592:             .Value = ""
593:             .MaxLength = 10
594:             .Format = "K"
595:             .Top = 95
596:             .Left = 394
597:             .Width = 85
598:             .Height = 21
599:             .FontName = "Tahoma"
600:             .FontSize = 8
601:             .SpecialEffect = 1
602:             .Visible = .T.
603:         ENDWITH
604:         BINDEVENT(loc_oPg2P1.txt_4c_Conta, "KeyPress", THIS, "TxtContaLostFocus")
605:         BINDEVENT(loc_oPg2P1.txt_4c_Conta, "KeyPress",  THIS, "TxtContaKeyPress")
606:         BINDEVENT(loc_oPg2P1.txt_4c_Conta, "DblClick",  THIS, "TxtContaDblClick")
607: 
608:         *-- TextBox: Get_Dconta / txt_4c_Dconta (top=89+29=118)
609:         loc_oPg2P1.AddObject("txt_4c_Dconta", "TextBox")
610:         WITH loc_oPg2P1.txt_4c_Dconta
611:             .Value = ""
612:             .MaxLength = 40
613:             .Format = "K"
614:             .Top = 118
615:             .Left = 307
616:             .Width = 357
617:             .Height = 21
618:             .FontName = "Tahoma"
619:             .FontSize = 8
620:             .SpecialEffect = 1
621:             .Visible = .T.
622:         ENDWITH
623:         BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "KeyPress", THIS, "TxtDcontaLostFocus")
624:         BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "KeyPress",  THIS, "TxtDcontaKeyPress")
625:         BINDEVENT(loc_oPg2P1.txt_4c_Dconta, "DblClick",  THIS, "TxtDcontaDblClick")
626: 
627:         *-- TextBox: Get_cpf / txt_4c_Cpf - CNPJ/CPF do fornecedor (top=66+29=95, left=481)
628:         loc_oPg2P1.AddObject("txt_4c_Cpf", "TextBox")
629:         WITH loc_oPg2P1.txt_4c_Cpf
630:             .Value = ""
631:             .MaxLength = 20
632:             .InputMask = "XXXXXXXXXXXXXXXXXXXX"
633:             .Top = 95
634:             .Left = 481
635:             .Width = 146
636:             .Height = 21
637:             .FontName = "Tahoma"
638:             .FontSize = 8
639:             .SpecialEffect = 1
640:             .Visible = .T.
641:         ENDWITH
642:         BINDEVENT(loc_oPg2P1.txt_4c_Cpf, "KeyPress", THIS, "TxtCpfLostFocus")
643: 
644:         *-- Label: Precificacao (Say1: top=114+29=143)
645:         loc_oPg2P1.AddObject("lbl_4c_Precif", "Label")
646:         WITH loc_oPg2P1.lbl_4c_Precif
647:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
648:             .AutoSize  = .T.
649:             .Top = 143
650:             .Left = 237
651:             .Height = 15
652:             .FontName  = "Tahoma"
653:             .FontSize = 8
654:             .BackStyle = 0
655:             .Visible = .T.
656:         ENDWITH
657: 
658:         *-- OptionGroup: Opt_Custo / opt_4c_Custo (top=113+29=142)
659:         *-- ButtonCount ANTES do WITH; .Value de Buttons(N) OMITIDO (regra anti-todos-marcados)
660:         loc_oPg2P1.AddObject("opt_4c_Custo", "OptionGroup")
661:         loc_oPg2P1.opt_4c_Custo.ButtonCount = 2
662:         loc_oPg2P1.opt_4c_Custo.Top         = 142
663:         loc_oPg2P1.opt_4c_Custo.Left        = 303
664:         loc_oPg2P1.opt_4c_Custo.Width       = 255
665:         loc_oPg2P1.opt_4c_Custo.Height      = 17
666:         WITH loc_oPg2P1.opt_4c_Custo
667:             .BackStyle   = 0
668:             .BorderStyle = 0
669:             .Visible = .T.
670:             WITH .Buttons(1)
671:                 .Caption   = "Custo Total"
672:                 .BackStyle = 0
673:                 .AutoSize  = .T.
674:                 .Top = 1
675:                 .Left = 5
676:                 .Height = 15
677:                 .Width = 73
678:                 .ForeColor = RGB(90, 90, 90)
679:                 .Themes = .F.
680:             ENDWITH
681:             WITH .Buttons(2)
682:                 .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
683:                 .FontName  = "Tahoma"
684:                 .FontSize = 8
685:                 .BackStyle = 0
686:                 .AutoSize = .T.
687:                 .Top = 1
688:                 .Left = 98
689:                 .Height = 15
690:                 .Width = 129
691:                 .ForeColor = RGB(90, 90, 90)
692:                 .Themes = .F.
693:             ENDWITH
694:             .Value = 1
695:         ENDWITH
696:         BINDEVENT(loc_oPg2P1.opt_4c_Custo, "InteractiveChange", THIS, "OptCustoInteractiveChange")
697: 
698:         *-- Label: Moeda (Say3: top=137+29=166)
699:         loc_oPg2P1.AddObject("lbl_4c_LoteMoeda", "Label")
700:         WITH loc_oPg2P1.lbl_4c_LoteMoeda
701:             .Caption   = "Moeda :"
702:             .AutoSize  = .T.
703:             .Top = 166
704:             .Left = 262
705:             .Height = 15
706:             .FontName  = "Tahoma"
707:             .FontSize = 8
708:             .BackStyle = 0
709:             .Visible = .T.
710:         ENDWITH
711: 
712:         *-- TextBox: Get_Moeda / txt_4c_Moeda (top=134+29=163)
713:         loc_oPg2P1.AddObject("txt_4c_Moeda", "TextBox")
714:         WITH loc_oPg2P1.txt_4c_Moeda
715:             .Value = ""
716:             .MaxLength = 10
717:             .Format = "K"
718:             .Top = 163
719:             .Left = 307
720:             .Width = 85
721:             .Height = 21
722:             .FontName = "Tahoma"
723:             .FontSize = 8
724:             .SpecialEffect = 1
725:             .Visible = .T.
726:         ENDWITH
727:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaLostFocus")
728:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
729:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "DblClick",  THIS, "TxtMoedaDblClick")
730: 
731:         *-- Label: Diretorio (Say2: top=160+29=189)
732:         loc_oPg2P1.AddObject("lbl_4c_Dir", "Label")
733:         WITH loc_oPg2P1.lbl_4c_Dir
734:             .Caption   = "Diret" + CHR(243) + "rio :"
735:             .AutoSize  = .T.
736:             .Top = 189
737:             .Left = 253
738:             .Height = 15
739:             .FontName  = "Tahoma"
740:             .FontSize = 8
741:             .BackStyle = 0
742:             .Visible = .T.
743:         ENDWITH
744: 
745:         *-- TextBox: Get_Arquivo / txt_4c_Arquivo - ReadOnly, preenchido por Command12
746:         loc_oPg2P1.AddObject("txt_4c_Arquivo", "TextBox")
747:         WITH loc_oPg2P1.txt_4c_Arquivo
748:             .Value = ""
749:             .MaxLength = 200
750:             .Top = 186
751:             .Left = 307
752:             .Width = 357
753:             .Height = 21
754:             .FontName = "Tahoma"
755:             .FontSize = 8
756:             .SpecialEffect = 1
757:             .ReadOnly = .T.
758:             .Visible = .T.
759:         ENDWITH
760: 
761:         *-- Button: Command12 / cmd_4c_Command12 - file picker (top=157+29=186)
762:         loc_oPg2P1.AddObject("cmd_4c_Command12", "CommandButton")
763:         WITH loc_oPg2P1.cmd_4c_Command12
764:             .Caption = "..."
765:             .Top = 186
766:             .Left = 667
767:             .Width = 20
768:             .Height = 20
769:             .FontName = "Tahoma"
770:             .FontSize = 8
771:             .SpecialEffect = 0
772:             .MousePointer = 15
773:             .Visible = .T.
774:         ENDWITH
775:         BINDEVENT(loc_oPg2P1.cmd_4c_Command12, "Click", THIS, "CmdCommand12Click")
776: 
777:         *-- Label: Carregar produtos... (Label1: top=184+29=213)
778:         loc_oPg2P1.AddObject("lbl_4c_Label1", "Label")
779:         WITH loc_oPg2P1.lbl_4c_Label1
780:             .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
781:             .FontBold  = .T.
782:             .AutoSize  = .T.
783:             .Top = 213
784:             .Left = 55
785:             .Width = 246
786:             .Height = 15
787:             .FontName  = "Tahoma"
788:             .FontSize = 8
789:             .BackStyle = 0
790:             .ForeColor = RGB(90, 90, 90)
791:             .Visible = .T.
792:         ENDWITH
793: 
794:         *-- OptionGroup: Opt_Fil / opt_4c_Fil (top=179+29=208)
795:         loc_oPg2P1.AddObject("opt_4c_Fil", "OptionGroup")
796:         loc_oPg2P1.opt_4c_Fil.ButtonCount = 3
797:         loc_oPg2P1.opt_4c_Fil.Top         = 208
798:         loc_oPg2P1.opt_4c_Fil.Left        = 303
799:         loc_oPg2P1.opt_4c_Fil.Width       = 192
800:         loc_oPg2P1.opt_4c_Fil.Height      = 24
801:         WITH loc_oPg2P1.opt_4c_Fil
802:             .BackStyle   = 0
803:             .BorderStyle = 0
804:             .Visible = .T.
805:             WITH .Buttons(1)
806:                 .Caption   = "Somente"
807:                 .BackStyle = 0
808:                 .AutoSize  = .T.
809:                 .Top = 5
810:                 .Left = 5
811:                 .Height = 15
812:                 .Width = 60
813:                 .ForeColor = RGB(90, 90, 90)
814:                 .Themes = .F.
815:             ENDWITH
816:             WITH .Buttons(2)
817:                 .Caption   = "N" + CHR(227) + "o"
818:                 .FontName  = "Tahoma"
819:                 .FontSize = 8
820:                 .BackStyle = 0
821:                 .AutoSize = .T.
822:                 .Top = 5
823:                 .Left = 84
824:                 .Height = 15
825:                 .Width = 37
826:                 .ForeColor = RGB(90, 90, 90)
827:                 .Themes = .F.
828:             ENDWITH
829:             WITH .Buttons(3)
830:                 .Caption   = "Ambos"
831:                 .FontName  = "Tahoma"
832:                 .FontSize = 8
833:                 .BackStyle = 0
834:                 .AutoSize = .T.
835:                 .Top = 5

*-- Linhas 841 a 884:
841:             ENDWITH
842:             .Value = 1
843:         ENDWITH
844:         BINDEVENT(loc_oPg2P1.opt_4c_Fil, "InteractiveChange", THIS, "OptFilInteractiveChange")
845: 
846:         *-- Label: Movimentacoes (Say5: top=204+29=233)
847:         loc_oPg2P1.AddObject("lbl_4c_Movs", "Label")
848:         WITH loc_oPg2P1.lbl_4c_Movs
849:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es :"
850:             .FontBold  = .T.
851:             .AutoSize = .T.
852:             .Top = 233
853:             .Left = 203
854:             .Height = 15
855:             .FontName  = "Tahoma"
856:             .FontSize = 8
857:             .ForeColor = RGB(90, 90, 90)
858:             .BackStyle = 0
859:             .Visible = .T.
860:         ENDWITH
861: 
862:         *-- Grid: grdEstoque / grd_4c_Estoque (top=206+29=235)
863:         *-- ColumnCount OBRIGATORIAMENTE antes do WITH
864:         loc_oPg2P1.AddObject("grd_4c_Estoque", "Grid")
865:         loc_oPg2P1.grd_4c_Estoque.Top         = 235
866:         loc_oPg2P1.grd_4c_Estoque.Left        = 307
867:         loc_oPg2P1.grd_4c_Estoque.Width       = 545
868:         loc_oPg2P1.grd_4c_Estoque.Height      = 340
869:         loc_oPg2P1.grd_4c_Estoque.ColumnCount = 5
870:         WITH loc_oPg2P1.grd_4c_Estoque
871:             .FontName          = "Tahoma"
872:             .FontSize          = 8
873:             .ForeColor         = RGB(90, 90, 90)
874:             .BackColor         = RGB(237, 242, 243)
875:             .GridLineColor     = RGB(238, 238, 238)
876:             .AllowHeaderSizing = .F.
877:             .AllowRowSizing    = .F.
878:             .DeleteMark        = .F.
879:             .RecordMark        = .F.
880:             .RowHeight         = 16
881:             .ScrollBars        = 2
882:             .Visible           = .T.
883:             .Column1.Width = 70
884:             .Column1.Header1.Caption = "Empresa"

*-- Linhas 911 a 1236:
911:             .MousePointer = 15
912:             .Visible = .T.
913:         ENDWITH
914:         BINDEVENT(loc_oPg2P1.cmd_4c_BotConsulta, "Click", THIS, "CmdBotConsultaClick")
915: 
916:         *-- Button: btnCadastros / cmd_4c_BtnCadastros (top=70+29=99, left=708)
917:         loc_oPg2P1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
918:         WITH loc_oPg2P1.cmd_4c_BtnCadastros
919:             .Caption     = ""
920:             .Picture     = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
921:             .Top = 99
922:             .Left = 708
923:             .Width = 40
924:             .Height = 40
925:             .BackColor = RGB(255,255,255)
926:             .ForeColor = RGB(90,90,90)
927:             .SpecialEffect = 0
928:             .Themes = .F.
929:             .ToolTipText = "<F3> Acessa o Cadastro Desta Conta"
930:             .MousePointer = 15
931:             .Visible = .T.
932:         ENDWITH
933:         BINDEVENT(loc_oPg2P1.cmd_4c_BtnCadastros, "Click", THIS, "CmdBtnCadastrosClick")
934: 
935:         *-- CommandGroup: cmdOperacao / cmd_4c_CmdOperacao (top=334+29=363)
936:         loc_oPg2P1.AddObject("cmd_4c_CmdOperacao", "CommandGroup")
937:         loc_oPg2P1.cmd_4c_CmdOperacao.ButtonCount = 1
938:         loc_oPg2P1.cmd_4c_CmdOperacao.Top         = 363
939:         loc_oPg2P1.cmd_4c_CmdOperacao.Left        = 857
940:         loc_oPg2P1.cmd_4c_CmdOperacao.Width       = 85
941:         loc_oPg2P1.cmd_4c_CmdOperacao.Height      = 85
942:         WITH loc_oPg2P1.cmd_4c_CmdOperacao
943:             .BackStyle   = 0
944:             .BorderStyle = 0
945:             .Themes = .F.
946:             .Visible = .T.
947:             WITH .Buttons(1)
948:                 .Top = 5
949:                 .Left = 5
950:                 .Height = 75
951:                 .Width = 75
952:                 .FontBold = .T.
953:                 .FontItalic = .T.
954:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
955:                 .Caption         = "Movimento"
956:                 .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
957:                 .PicturePosition = 13
958:                 .ForeColor = RGB(90, 90, 90)
959:                 .BackColor = RGB(255, 255, 255)
960:                 .Themes = .F.
961:             ENDWITH
962:         ENDWITH
963:         BINDEVENT(loc_oPg2P1.cmd_4c_CmdOperacao, "Click", THIS, "CmdOperacaoClick")
964: 
965:         *-- Button: processar / cmd_4c_Processar (top=7+29=36, left=962)
966:         loc_oPg2P1.AddObject("cmd_4c_Processar", "CommandButton")
967:         WITH loc_oPg2P1.cmd_4c_Processar
968:             .Caption         = "Processar"
969:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
970:             .PicturePosition = 13
971:             .Top = 36
972:             .Left = 962
973:             .Width = 75
974:             .Height = 75
975:             .BackColor = RGB(255,255,255)
976:             .ForeColor = RGB(90,90,90)
977:             .FontName = "Tahoma"
978:             .FontSize = 8
979:             .FontBold = .T.
980:             .FontItalic = .T.
981:             .Themes = .F.
982:             .SpecialEffect = 0
983:             .MousePointer = 15
984:             .WordWrap = .T.
985:             .AutoSize = .F.
986:             .Visible = .T.
987:         ENDWITH
988:         BINDEVENT(loc_oPg2P1.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
989:     ENDPROC
990: 
991:     *--------------------------------------------------------------------------
992:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
993:     *--------------------------------------------------------------------------
994:     PROCEDURE AlternarPagina(par_nPagina)
995:         LOCAL loc_lResultado
996:         loc_lResultado = .F.
997: 
998:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
999:             RETURN .F.
1000:         ENDIF
1001: 
1002:         TRY
1003:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1004: 
1005:             IF par_nPagina = 1
1006:                 THIS.this_cModoAtual = "LISTA"
1007:                 THIS.CarregarLista()
1008:             ENDIF
1009: 
1010:             loc_lResultado = .T.
1011:         CATCH TO loc_oErro
1012:             MsgErro("Erro em FormSigPrCtr.AlternarPagina: " + loc_oErro.Message, "Erro")
1013:         ENDTRY
1014: 
1015:         RETURN loc_lResultado
1016:     ENDPROC
1017: 
1018:     *--------------------------------------------------------------------------
1019:     * DtInicialLostFocus - Ajusta DtFinal se necessario e recarrega lista
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1022:         LOCAL loc_oPg1
1023:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1024: 
1025:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1026:             IF loc_oPg1.txt_4c_DtInicial.Value > loc_oPg1.txt_4c_DtFinal.Value
1027:                 loc_oPg1.txt_4c_DtFinal.Value = loc_oPg1.txt_4c_DtInicial.Value
1028:             ENDIF
1029:         ENDIF
1030: 
1031:         THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1032:         THIS.CarregarLista()
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * DtFinalLostFocus - Ajusta DtInicial se necessario e recarrega lista
1037:     *--------------------------------------------------------------------------
1038:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1039:         LOCAL loc_oPg1
1040:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1041: 
1042:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1043:             IF loc_oPg1.txt_4c_DtFinal.Value < loc_oPg1.txt_4c_DtInicial.Value
1044:                 loc_oPg1.txt_4c_DtInicial.Value = loc_oPg1.txt_4c_DtFinal.Value
1045:             ENDIF
1046:         ENDIF
1047: 
1048:         THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1049:         THIS.CarregarLista()
1050:     ENDPROC
1051: 
1052:     *--------------------------------------------------------------------------
1053:     * BtnIncluirClick - Prepara form para incluir novo lote
1054:     *--------------------------------------------------------------------------
1055:     PROCEDURE BtnIncluirClick()
1056:         THIS.this_oBusinessObject.NovoRegistro()
1057:         THIS.LimparCampos()
1058:         THIS.this_cModoAtual = "INCLUIR"
1059:         THIS.HabilitarCampos(.T.)
1060:         THIS.AjustarBotoesPorModo()
1061:         THIS.AlternarPagina(2)
1062:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------
1066:     * BtnVisualizarClick - Carrega lote selecionado em modo leitura
1067:     *--------------------------------------------------------------------------
1068:     PROCEDURE BtnVisualizarClick()
1069:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1070:            RECCOUNT("cursor_4c_Dados") = 0
1071:             MsgAviso("Selecione um lote na lista.", "Aviso")
1072:             RETURN
1073:         ENDIF
1074: 
1075:         LOCAL loc_cCodigos
1076:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1077: 
1078:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1079:             THIS.BOParaForm()
1080:             THIS.this_cModoAtual = "VISUALIZAR"
1081:             THIS.HabilitarCampos(.F.)
1082:             THIS.AjustarBotoesPorModo()
1083:             THIS.AlternarPagina(2)
1084:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1085:         ENDIF
1086:     ENDPROC
1087: 
1088:     *--------------------------------------------------------------------------
1089:     * BtnAlterarClick - Carrega lote selecionado para edicao
1090:     *--------------------------------------------------------------------------
1091:     PROCEDURE BtnAlterarClick()
1092:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1093:            RECCOUNT("cursor_4c_Dados") = 0
1094:             MsgAviso("Selecione um lote na lista.", "Aviso")
1095:             RETURN
1096:         ENDIF
1097: 
1098:         LOCAL loc_cCodigos
1099:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1100: 
1101:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1102:             THIS.this_oBusinessObject.EditarRegistro()
1103:             THIS.BOParaForm()
1104:             THIS.this_cModoAtual = "ALTERAR"
1105:             THIS.HabilitarCampos(.T.)
1106:             THIS.AjustarBotoesPorModo()
1107:             THIS.AlternarPagina(2)
1108:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1109:         ENDIF
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * BtnExcluirClick - Exclui lote selecionado apos confirmacao
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE BtnExcluirClick()
1116:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1117:            RECCOUNT("cursor_4c_Dados") = 0
1118:             MsgAviso("Selecione um lote na lista.", "Aviso")
1119:             RETURN
1120:         ENDIF
1121: 
1122:         LOCAL loc_cCodigos
1123:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1124: 
1125:         IF !MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + ;
1126:                         ALLTRIM(loc_cCodigos) + "?", ;
1127:                         "Confirmar Exclus" + CHR(227) + "o")
1128:             RETURN
1129:         ENDIF
1130: 
1131:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1132:             IF THIS.this_oBusinessObject.Excluir()
1133:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1134:                 THIS.CarregarLista()
1135:             ENDIF
1136:         ENDIF
1137:     ENDPROC
1138: 
1139:     *--------------------------------------------------------------------------
1140:     * BtnBuscarClick - Recarrega lista com filtros de data atuais
1141:     *--------------------------------------------------------------------------
1142:     PROCEDURE BtnBuscarClick()
1143:         LOCAL loc_oPg1
1144:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1145: 
1146:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1147:             THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1148:         ENDIF
1149: 
1150:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1151:             THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1152:         ENDIF
1153: 
1154:         THIS.CarregarLista()
1155:     ENDPROC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * BtnSalvarClick - Grava o lote: monta cursor_4c_Linhas a partir do JOIN
1159:     * de cursor_4c_Movimentos x cursor_4c_Distribui, entao chama Salvar()
1160:     *--------------------------------------------------------------------------
1161:     PROCEDURE BtnSalvarClick()
1162:         LOCAL loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc
1163:         LOCAL loc_oPg2P1, loc_nQtdOs, loc_lSalvoOK, loc_oErro
1164:         loc_cConta   = ""
1165:         loc_cArquivo = ""
1166:         loc_cMoeda   = ""
1167:         loc_nOpc     = 0
1168:         loc_lSalvoOK = .F.
1169:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1170: 
1171:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1172:             loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1175:             loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
1176:         ENDIF
1177:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1178:             loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1179:         ENDIF
1180:         IF PEMSTATUS(loc_oPg2P1, "obj_4c_Opt_Custo", 5)
1181:             loc_nOpc = loc_oPg2P1.obj_4c_Opt_Custo.Value
1182:         ENDIF
1183: 
1184:         IF EMPTY(loc_cConta)
1185:             MsgAviso("Informe o fornecedor antes de salvar.", ;
1186:                      "Campo Obrigat" + CHR(243) + "rio")
1187:             RETURN
1188:         ENDIF
1189: 
1190:         IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
1191:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " movimentos para gravar.", "Aviso")
1192:             RETURN
1193:         ENDIF
1194: 
1195:         IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
1196:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " distribui" + CHR(231) + CHR(227) + ;
1197:                      "o para gravar.", "Aviso")
1198:             RETURN
1199:         ENDIF
1200: 
1201:         TRY
1202:             *-- Monta cursor_4c_Linhas: JOIN movimentos x distribui onde qtd > 0 e saldo > 0
1203:             IF USED("cursor_4c_TmpJoin")
1204:                 USE IN cursor_4c_TmpJoin
1205:             ENDIF
1206: 
1207:             SELECT a.Cpros, a.Qtds, a.OriDopNums, a.CidChaves, b.Qtds AS QtdXml ;
1208:                 FROM cursor_4c_Movimentos a ;
1209:                 JOIN cursor_4c_Distribui b ON ALLTRIM(a.Cpros) = ALLTRIM(b.Cpros) ;
1210:                 INTO CURSOR cursor_4c_TmpJoin READWRITE
1211: 
1212:             IF USED("cursor_4c_Linhas")
1213:                 ZAP IN cursor_4c_Linhas
1214:             ELSE
1215:                 SET NULL ON
1216:                 CREATE CURSOR cursor_4c_Linhas ;
1217:                     (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
1218:                      OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
1219:                      Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
1220:                      Precific N(12,2), FkChaves C(20))
1221:                 SET NULL OFF
1222:             ENDIF
1223: 
1224:             IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
1225:                 SELECT cursor_4c_TmpJoin
1226:                 GO TOP
1227:                 SCAN
1228:                     loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
1229:                                      cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
1230:                     INSERT INTO cursor_4c_Linhas ;
1231:                         (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
1232:                          Contas, Arquivo, Moedas, Precific, FkChaves) ;
1233:                         VALUES ;
1234:                         (cursor_4c_TmpJoin.Cpros, "", "", cursor_4c_TmpJoin.OriDopNums, ;
1235:                          cursor_4c_TmpJoin.Qtds, loc_nQtdOs, ;
1236:                          loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc, ;

*-- Linhas 1244 a 1482:
1244:             ENDIF
1245: 
1246:             IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
1247:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " linhas v" + CHR(225) + ;
1248:                          "lidas para gravar (verifique saldo e distribui" + CHR(231) + CHR(227) + "o).", ;
1249:                          "Aviso")
1250:             ELSE
1251:                 THIS.FormParaBO()
1252:                 IF THIS.this_oBusinessObject.Salvar()
1253:                     MsgInfo("Lote gravado com sucesso!", "Sucesso")
1254:                     loc_lSalvoOK = .T.
1255:                 ENDIF
1256:             ENDIF
1257:         CATCH TO loc_oErro
1258:             MsgErro("Erro em FormSigPrCtr.BtnSalvarClick:" + CHR(13) + ;
1259:                     loc_oErro.Message, "Erro")
1260:         ENDTRY
1261: 
1262:         IF loc_lSalvoOK
1263:             THIS.AlternarPagina(1)
1264:         ENDIF
1265:     ENDPROC
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * BtnCancelarClick - Cancela edicao e volta para lista
1269:     *--------------------------------------------------------------------------
1270:     PROCEDURE BtnCancelarClick()
1271:         THIS.this_cModoAtual = "LISTA"
1272:         THIS.AjustarBotoesPorModo()
1273:         THIS.AlternarPagina(1)
1274:         THIS.CarregarLista()
1275:     ENDPROC
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
1279:     *--------------------------------------------------------------------------
1280:     PROTECTED PROCEDURE FormParaBO()
1281:         LOCAL loc_oPg2P1
1282:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1283: 
1284:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1285:             THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1286:         ENDIF
1287:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1288:             THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1289:         ENDIF
1290:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1291:             THIS.this_oBusinessObject.this_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1292:         ENDIF
1293:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1294:             THIS.this_oBusinessObject.this_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
1295:         ENDIF
1296:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1297:             THIS.this_oBusinessObject.this_cMoedas = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1298:         ENDIF
1299:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1300:             THIS.this_oBusinessObject.this_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
1301:         ENDIF
1302:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1303:             THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *--------------------------------------------------------------------------
1308:     * BOParaForm - Transfere valores do BO para os campos da Page2
1309:     *--------------------------------------------------------------------------
1310:     PROTECTED PROCEDURE BOParaForm()
1311:         LOCAL loc_oPg2P1
1312:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1313: 
1314:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1315:             loc_oPg2P1.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
1316:         ENDIF
1317:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1318:             loc_oPg2P1.txt_4c_Conta.Value = THIS.this_oBusinessObject.this_cContas
1319:         ENDIF
1320:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1321:             loc_oPg2P1.txt_4c_Dconta.Value = THIS.this_oBusinessObject.this_cDconta
1322:         ENDIF
1323:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1324:             loc_oPg2P1.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
1325:         ENDIF
1326:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1327:             loc_oPg2P1.txt_4c_Moeda.Value = THIS.this_oBusinessObject.this_cMoedas
1328:         ENDIF
1329:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1330:             loc_oPg2P1.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cCpf
1331:         ENDIF
1332:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1333:             loc_oPg2P1.opt_4c_Custo.Value = THIS.this_oBusinessObject.this_nPrecific
1334:         ENDIF
1335:     ENDPROC
1336: 
1337:     *--------------------------------------------------------------------------
1338:     * LimparCampos - Limpa valores dos campos editaveis da Page2
1339:     *--------------------------------------------------------------------------
1340:     PROTECTED PROCEDURE LimparCampos()
1341:         LOCAL loc_oPg2P1
1342:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1343: 
1344:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1345:             loc_oPg2P1.txt_4c_Grupo.Value = ""
1346:         ENDIF
1347:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1348:             loc_oPg2P1.txt_4c_Conta.Value = ""
1349:         ENDIF
1350:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1351:             loc_oPg2P1.txt_4c_Dconta.Value = ""
1352:         ENDIF
1353:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1354:             loc_oPg2P1.txt_4c_Arquivo.Value = ""
1355:         ENDIF
1356:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1357:             loc_oPg2P1.txt_4c_Moeda.Value = ""
1358:         ENDIF
1359:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1360:             loc_oPg2P1.txt_4c_Cpf.Value = ""
1361:         ENDIF
1362:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1363:             loc_oPg2P1.opt_4c_Custo.Value = 1
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     *--------------------------------------------------------------------------
1368:     * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
1369:     *--------------------------------------------------------------------------
1370:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1371:         LOCAL loc_oPg2P1, loc_oCntAcao
1372:         loc_oPg2P1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1373:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1374: 
1375:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1376:             loc_oPg2P1.txt_4c_Grupo.Enabled = par_lHabilitar
1377:         ENDIF
1378:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1379:             loc_oPg2P1.txt_4c_Conta.Enabled = par_lHabilitar
1380:         ENDIF
1381:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1382:             loc_oPg2P1.txt_4c_Dconta.Enabled = par_lHabilitar
1383:         ENDIF
1384:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1385:             loc_oPg2P1.txt_4c_Arquivo.Enabled = par_lHabilitar
1386:         ENDIF
1387:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1388:             loc_oPg2P1.txt_4c_Moeda.Enabled = par_lHabilitar
1389:         ENDIF
1390:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1391:             loc_oPg2P1.txt_4c_Cpf.Enabled = par_lHabilitar
1392:         ENDIF
1393:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1394:             loc_oPg2P1.opt_4c_Custo.Enabled = par_lHabilitar
1395:         ENDIF
1396:         IF PEMSTATUS(loc_oPg2P1, "cmd_4c_Processar", 5)
1397:             loc_oPg2P1.cmd_4c_Processar.Enabled = par_lHabilitar
1398:         ENDIF
1399:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1400:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1401:         ENDIF
1402:     ENDPROC
1403: 
1404:     *--------------------------------------------------------------------------
1405:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
1406:     *--------------------------------------------------------------------------
1407:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1408:         LOCAL loc_oCnt, loc_lLista, loc_lEdita
1409:         loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1410:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
1411:         loc_lEdita = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1412: 
1413:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1414:             loc_oCnt.cmd_4c_Incluir.Enabled = loc_lLista
1415:         ENDIF
1416:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1417:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lLista
1418:         ENDIF
1419:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1420:             loc_oCnt.cmd_4c_Alterar.Enabled = loc_lLista
1421:         ENDIF
1422:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1423:             loc_oCnt.cmd_4c_Excluir.Enabled = loc_lLista
1424:         ENDIF
1425:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1426:             loc_oCnt.cmd_4c_Buscar.Enabled = loc_lLista
1427:         ENDIF
1428: 
1429:         LOCAL loc_oCntAcao
1430:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1431:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1432:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = loc_lEdita
1433:         ENDIF
1434:     ENDPROC
1435: 
1436:     *--------------------------------------------------------------------------
1437:     * CarregarLista - Busca lotes do banco e popula grd_4c_Dados
1438:     * Propaga datas de this_dDataInicial/this_dDataFinal para o BO
1439:     * grd_4c_Dados e controles de filtro sao criados na Fase 4;
1440:     *   este metodo le os controles se existirem, graciosamente ignora se nao
1441:     *--------------------------------------------------------------------------
1442:     PROCEDURE CarregarLista()
1443:         LOCAL loc_lResultado, loc_oPg1, loc_oGrid
1444:         loc_lResultado = .F.
1445: 
1446:         TRY
1447:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1448:                 loc_lResultado = .T.
1449:             ELSE
1450:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1451: 
1452:                 *-- Propagar filtros de data a partir dos controles (Fase 4 cria os controles)
1453:                 IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1454:                     THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1455:                 ELSE
1456:                     THIS.this_oBusinessObject.this_dDataInicial = THIS.this_dDataInicial
1457:                 ENDIF
1458: 
1459:                 IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1460:                     THIS.this_oBusinessObject.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1461:                 ELSE
1462:                     THIS.this_oBusinessObject.this_dDataFinal = THIS.this_dDataFinal
1463:                 ENDIF
1464: 
1465:                 IF THIS.this_oBusinessObject.Buscar("")
1466:                     *-- Popula grid quando existir (criado na Fase 4)
1467:                     IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
1468:                         loc_oGrid = loc_oPg1.grd_4c_Dados
1469:                         loc_oGrid.ColumnCount = 6
1470:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1471:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1472:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
1473:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
1474:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Rclis"
1475:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Usuars"
1476:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1477:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(250) + "mero"
1478:                         loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1479:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1480:                         loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1481:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1482:                         loc_oGrid.Column6.Header1.Caption = "Empresa"

*-- Linhas 1497 a 1948:
1497:     *--------------------------------------------------------------------------
1498:     * BtnEncerrarClick - Fecha o formulario
1499:     *--------------------------------------------------------------------------
1500:     PROCEDURE BtnEncerrarClick()
1501:         THIS.Release()
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * OptCustoInteractiveChange - Persiste opcao de precificacao no BO
1506:     *--------------------------------------------------------------------------
1507:     PROCEDURE OptCustoInteractiveChange()
1508:         LOCAL loc_oPg2P1
1509:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1510:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1511:             THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
1512:         ENDIF
1513:     ENDPROC
1514: 
1515:     *--------------------------------------------------------------------------
1516:     * OptFilInteractiveChange - Reaplicar filtro opt_4c_Fil ao cursor_4c_Movimentos
1517:     *--------------------------------------------------------------------------
1518:     PROCEDURE OptFilInteractiveChange()
1519:         LOCAL loc_oPg2P1, loc_nTipo, loc_oErro
1520:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1521:         loc_nTipo  = 3
1522:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
1523:             loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
1524:         ENDIF
1525: 
1526:         TRY
1527:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
1528:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
1529:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
1530:                 IF USED("cursor_4c_MovFiltro")
1531:                     USE IN cursor_4c_MovFiltro
1532:                 ENDIF
1533:                 IF loc_nTipo = 1
1534:                     SELECT * FROM cursor_4c_Movimentos ;
1535:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
1536:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
1537:                 ELSE
1538:                     SELECT * FROM cursor_4c_Movimentos ;
1539:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
1540:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
1541:                 ENDIF
1542:                 SELECT cursor_4c_Movimentos
1543:                 ZAP
1544:                 IF USED("cursor_4c_MovFiltro") AND RECCOUNT("cursor_4c_MovFiltro") > 0
1545:                     APPEND FROM DBF("cursor_4c_MovFiltro")
1546:                 ENDIF
1547:                 IF USED("cursor_4c_MovFiltro")
1548:                     USE IN cursor_4c_MovFiltro
1549:                 ENDIF
1550:                 IF USED("cursor_4c_Movimentos")
1551:                     GO TOP IN cursor_4c_Movimentos
1552:                 ENDIF
1553:             ENDIF
1554:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2, "grd_4c_Disponivel", 5)
1555:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Disponivel.Refresh()
1556:             ENDIF
1557:         CATCH TO loc_oErro
1558:             MsgErro("Erro em FormSigPrCtr.OptFilInteractiveChange:" + CHR(13) + ;
1559:                     loc_oErro.Message, "Erro")
1560:         ENDTRY
1561:     ENDPROC
1562: 
1563:     *--------------------------------------------------------------------------
1564:     * FormatarGridLista - Formata visual da grade de lotes (Page1)
1565:     *--------------------------------------------------------------------------
1566:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1567:         WITH par_oGrid
1568:             .FontName = "Tahoma"
1569:             .FontSize = 8
1570:         ENDWITH
1571:     ENDPROC
1572: 
1573:     *--------------------------------------------------------------------------
1574:     * TornarControlesVisiveis - Percorre recursivamente e seta Visible=.T.
1575:     * Inclui tratamento especial para PageFrames aninhados
1576:     *--------------------------------------------------------------------------
1577:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1578:         LOCAL loc_nI, loc_oObjeto, loc_nP
1579: 
1580:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1581:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1582: 
1583:             IF VARTYPE(loc_oObjeto) = "O"
1584:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1585:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "IMG_4C_FIGJPG")
1586:                         loc_oObjeto.Visible = .T.
1587:                     ENDIF
1588:                 ENDIF
1589: 
1590:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1591:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1592:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1593:                     ENDFOR
1594:                 ENDIF
1595: 
1596:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1597:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1598:                 ENDIF
1599:             ENDIF
1600:         ENDFOR
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * TxtGrupoKeyPress - F4 abre lookup de Grupo
1605:     *--------------------------------------------------------------------------
1606:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1607:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1608:             THIS.AbrirLookupGrupo()
1609:         ENDIF
1610:     ENDPROC
1611: 
1612:     *--------------------------------------------------------------------------
1613:     * TxtGrupoDblClick - DblClick abre lookup de Grupo
1614:     *--------------------------------------------------------------------------
1615:     PROCEDURE TxtGrupoDblClick()
1616:         THIS.AbrirLookupGrupo()
1617:     ENDPROC
1618: 
1619:     *--------------------------------------------------------------------------
1620:     * AbrirLookupGrupo - Picker SigCdGrp (cgrus/dgrus)
1621:     *--------------------------------------------------------------------------
1622:     PROCEDURE AbrirLookupGrupo()
1623:         LOCAL loc_oPg2P1, loc_cGrupo, loc_oBusca, loc_oErro
1624:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1625:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1626:             RETURN
1627:         ENDIF
1628:         loc_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1629:         TRY
1630:             IF USED("cursor_4c_BuscaGrp")
1631:                 USE IN cursor_4c_BuscaGrp
1632:             ENDIF
1633:             =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1634:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1635:                 "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
1636:             IF VARTYPE(loc_oBusca) = "O"
1637:                 IF !loc_oBusca.this_lSelecionou
1638:                     IF USED("cursor_4c_BuscaGrp")
1639:                         USE IN cursor_4c_BuscaGrp
1640:                     ENDIF
1641:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1642:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1643:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1644:                     loc_oBusca.Show()
1645:                 ENDIF
1646:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1647:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1648:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1649:                 ENDIF
1650:                 IF USED("cursor_4c_BuscaGrp")
1651:                     USE IN cursor_4c_BuscaGrp
1652:                 ENDIF
1653:                 loc_oBusca.Release()
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")
1657:         ENDTRY
1658:     ENDPROC
1659: 
1660:     *--------------------------------------------------------------------------
1661:     * TxtContaKeyPress - F4 abre lookup de Conta (Fornecedor por codigo)
1662:     *--------------------------------------------------------------------------
1663:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1664:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1665:             THIS.AbrirLookupConta()
1666:         ENDIF
1667:     ENDPROC
1668: 
1669:     *--------------------------------------------------------------------------
1670:     * TxtContaDblClick - DblClick abre lookup de Conta (Fornecedor)
1671:     *--------------------------------------------------------------------------
1672:     PROCEDURE TxtContaDblClick()
1673:         THIS.AbrirLookupConta()
1674:     ENDPROC
1675: 
1676:     *--------------------------------------------------------------------------
1677:     * AbrirLookupConta - Picker SigCdCli por Iclis; preenche Conta/Dconta/Cpf
1678:     *--------------------------------------------------------------------------
1679:     PROCEDURE AbrirLookupConta()
1680:         LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_oErro
1681:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1682:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1683:             RETURN
1684:         ENDIF
1685:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1686:         TRY
1687:             IF USED("cursor_4c_BuscaCli")
1688:                 USE IN cursor_4c_BuscaCli
1689:             ENDIF
1690:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1691:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1692:                 "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1693:             IF VARTYPE(loc_oBusca) = "O"
1694:                 IF !loc_oBusca.this_lSelecionou
1695:                     IF USED("cursor_4c_BuscaCli")
1696:                         USE IN cursor_4c_BuscaCli
1697:                     ENDIF
1698:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1699:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1700:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1701:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1702:                     loc_oBusca.Show()
1703:                 ENDIF
1704:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1705:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1706:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1707:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1708:                     ENDIF
1709:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1710:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1711:                     ENDIF
1712:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1713:                 ENDIF
1714:                 IF USED("cursor_4c_BuscaCli")
1715:                     USE IN cursor_4c_BuscaCli
1716:                 ENDIF
1717:                 loc_oBusca.Release()
1718:             ENDIF
1719:         CATCH TO loc_oErro
1720:             MsgErro("Erro em FormSigPrCtr.AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "Erro")
1721:         ENDTRY
1722:     ENDPROC
1723: 
1724:     *--------------------------------------------------------------------------
1725:     * TxtDcontaKeyPress - F4 abre lookup de Dconta (nome Fornecedor)
1726:     *--------------------------------------------------------------------------
1727:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1728:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1729:             THIS.AbrirLookupDconta()
1730:         ENDIF
1731:     ENDPROC
1732: 
1733:     *--------------------------------------------------------------------------
1734:     * TxtDcontaDblClick - DblClick abre lookup de Dconta
1735:     *--------------------------------------------------------------------------
1736:     PROCEDURE TxtDcontaDblClick()
1737:         THIS.AbrirLookupDconta()
1738:     ENDPROC
1739: 
1740:     *--------------------------------------------------------------------------
1741:     * AbrirLookupDconta - Picker SigCdCli por Rclis; preenche Conta/Dconta/Cpf
1742:     *--------------------------------------------------------------------------
1743:     PROCEDURE AbrirLookupDconta()
1744:         LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_oErro
1745:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1746:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1747:             RETURN
1748:         ENDIF
1749:         loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1750:         TRY
1751:             IF USED("cursor_4c_BuscaCli")
1752:                 USE IN cursor_4c_BuscaCli
1753:             ENDIF
1754:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1755:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1756:                 "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1757:             IF VARTYPE(loc_oBusca) = "O"
1758:                 IF !loc_oBusca.this_lSelecionou
1759:                     IF USED("cursor_4c_BuscaCli")
1760:                         USE IN cursor_4c_BuscaCli
1761:                     ENDIF
1762:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1763:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1764:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1765:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1766:                     loc_oBusca.Show()
1767:                 ENDIF
1768:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1769:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1770:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1771:                     ENDIF
1772:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1773:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1774:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1775:                     ENDIF
1776:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1777:                 ENDIF
1778:                 IF USED("cursor_4c_BuscaCli")
1779:                     USE IN cursor_4c_BuscaCli
1780:                 ENDIF
1781:                 loc_oBusca.Release()
1782:             ENDIF
1783:         CATCH TO loc_oErro
1784:             MsgErro("Erro em FormSigPrCtr.AbrirLookupDconta:" + CHR(13) + loc_oErro.Message, "Erro")
1785:         ENDTRY
1786:     ENDPROC
1787: 
1788:     *--------------------------------------------------------------------------
1789:     * TxtMoedaKeyPress - F4 abre lookup de Moeda
1790:     *--------------------------------------------------------------------------
1791:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1792:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1793:             THIS.AbrirLookupMoeda()
1794:         ENDIF
1795:     ENDPROC
1796: 
1797:     *--------------------------------------------------------------------------
1798:     * TxtMoedaDblClick - DblClick abre lookup de Moeda
1799:     *--------------------------------------------------------------------------
1800:     PROCEDURE TxtMoedaDblClick()
1801:         THIS.AbrirLookupMoeda()
1802:     ENDPROC
1803: 
1804:     *--------------------------------------------------------------------------
1805:     * AbrirLookupMoeda - Picker SigCdMoe (CMoes/DMoes)
1806:     *--------------------------------------------------------------------------
1807:     PROCEDURE AbrirLookupMoeda()
1808:         LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_oErro
1809:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1810:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1811:             RETURN
1812:         ENDIF
1813:         loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1814:         TRY
1815:             IF USED("cursor_4c_BuscaMoe")
1816:                 USE IN cursor_4c_BuscaMoe
1817:             ENDIF
1818:             =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1819:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1820:                 "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
1821:             IF VARTYPE(loc_oBusca) = "O"
1822:                 IF !loc_oBusca.this_lSelecionou
1823:                     IF USED("cursor_4c_BuscaMoe")
1824:                         USE IN cursor_4c_BuscaMoe
1825:                     ENDIF
1826:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1827:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1828:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1829:                     loc_oBusca.Show()
1830:                 ENDIF
1831:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1832:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1833:                 ENDIF
1834:                 IF USED("cursor_4c_BuscaMoe")
1835:                     USE IN cursor_4c_BuscaMoe
1836:                 ENDIF
1837:                 loc_oBusca.Release()
1838:             ENDIF
1839:         CATCH TO loc_oErro
1840:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1841:         ENDTRY
1842:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1843:             loc_oPg2P1.txt_4c_Moeda.Refresh
1844:         ENDIF
1845:     ENDPROC
1846: 
1847:     *--------------------------------------------------------------------------
1848:     * TxtGrupoLostFocus - Persiste valor do Grupo no BO
1849:     *--------------------------------------------------------------------------
1850:     PROCEDURE TxtGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1851:         LOCAL loc_oPg2P1
1852:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1853:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1854:             THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     *--------------------------------------------------------------------------
1859:     * TxtContaLostFocus - Lookup SigCdCli por Iclis; preenche Dconta, Cpf e grade
1860:     *--------------------------------------------------------------------------
1861:     PROCEDURE TxtContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1862:         LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
1863:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1864: 
1865:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1866:             RETURN
1867:         ENDIF
1868: 
1869:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1870: 
1871:         IF EMPTY(loc_cConta)
1872:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1873:                 loc_oPg2P1.txt_4c_Dconta.Value = ""
1874:             ENDIF
1875:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1876:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
1877:             ENDIF
1878:             RETURN
1879:         ENDIF
1880: 
1881:         TRY
1882:             IF USED("cursor_4c_BuscaCli")
1883:                 USE IN cursor_4c_BuscaCli
1884:             ENDIF
1885:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1886:                        " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
1887:                        " ORDER BY Iclis"
1888:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1889: 
1890:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1891:                RECCOUNT("cursor_4c_BuscaCli") > 0
1892:                 loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1893:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1894:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1895:                 ENDIF
1896:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1897:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1898:                 ENDIF
1899:                 IF USED("cursor_4c_BuscaCli")
1900:                     USE IN cursor_4c_BuscaCli
1901:                 ENDIF
1902:                 THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
1903:             ELSE
1904:                 IF USED("cursor_4c_BuscaCli")
1905:                     USE IN cursor_4c_BuscaCli
1906:                 ENDIF
1907:                 *-- Nao encontrado exato: abre picker
1908:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1909:                     "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1910:                 IF VARTYPE(loc_oBusca) = "O"
1911:                     IF !loc_oBusca.this_lSelecionou
1912:                         IF USED("cursor_4c_BuscaCli")
1913:                             USE IN cursor_4c_BuscaCli
1914:                         ENDIF
1915:                         loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1916:                                    " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
1917:                                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
1918:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
1919:                            !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1920:                             IF USED("cursor_4c_BuscaCli")
1921:                                 USE IN cursor_4c_BuscaCli
1922:                             ENDIF
1923:                             =SQLEXEC(gnConnHandle, ;
1924:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1925:                                 "cursor_4c_BuscaCli")
1926:                         ENDIF
1927:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1928:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1929:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1930:                         loc_oBusca.Show()
1931:                     ENDIF
1932:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1933:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1934:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1935:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1936:                         ENDIF
1937:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1938:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1939:                         ENDIF
1940:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1941:                     ELSE
1942:                         loc_oPg2P1.txt_4c_Conta.Value = ""
1943:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1944:                             loc_oPg2P1.txt_4c_Dconta.Value = ""
1945:                         ENDIF
1946:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1947:                             loc_oPg2P1.txt_4c_Cpf.Value = ""
1948:                         ENDIF

*-- Linhas 1968 a 2011:
1968:     *--------------------------------------------------------------------------
1969:     * TxtDcontaLostFocus - Lookup SigCdCli por Rclis; preenche Conta e Cpf
1970:     *--------------------------------------------------------------------------
1971:     PROCEDURE TxtDcontaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1972:         LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
1973:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1974: 
1975:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1976:             RETURN
1977:         ENDIF
1978: 
1979:         loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1980: 
1981:         IF EMPTY(loc_cDconta)
1982:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1983:                 loc_oPg2P1.txt_4c_Conta.Value = ""
1984:             ENDIF
1985:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1986:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
1987:             ENDIF
1988:             RETURN
1989:         ENDIF
1990: 
1991:         TRY
1992:             IF USED("cursor_4c_BuscaCli")
1993:                 USE IN cursor_4c_BuscaCli
1994:             ENDIF
1995:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1996:                        " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
1997:                        " ORDER BY Rclis"
1998:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1999: 
2000:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2001:                RECCOUNT("cursor_4c_BuscaCli") = 1
2002:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2003:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2004:                 ENDIF
2005:                 loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2006:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2007:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2008:                 ENDIF
2009:                 IF USED("cursor_4c_BuscaCli")
2010:                     USE IN cursor_4c_BuscaCli
2011:                 ENDIF

*-- Linhas 2022 a 2065:
2022:                         "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2023:                         "cursor_4c_BuscaCli")
2024:                 ENDIF
2025:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2026:                     "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
2027:                 IF VARTYPE(loc_oBusca) = "O"
2028:                     IF !loc_oBusca.this_lSelecionou
2029:                         IF USED("cursor_4c_BuscaCli")
2030:                             USE IN cursor_4c_BuscaCli
2031:                         ENDIF
2032:                         =SQLEXEC(gnConnHandle, ;
2033:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2034:                             "cursor_4c_BuscaCli")
2035:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2036:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
2037:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2038:                         loc_oBusca.Show()
2039:                     ENDIF
2040:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2041:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2042:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2043:                         ENDIF
2044:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2045:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2046:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2047:                         ENDIF
2048:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
2049:                     ELSE
2050:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2051:                             loc_oPg2P1.txt_4c_Conta.Value = ""
2052:                         ENDIF
2053:                         loc_oPg2P1.txt_4c_Dconta.Value = ""
2054:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2055:                             loc_oPg2P1.txt_4c_Cpf.Value = ""
2056:                         ENDIF
2057:                     ENDIF
2058:                     IF USED("cursor_4c_BuscaCli")
2059:                         USE IN cursor_4c_BuscaCli
2060:                     ENDIF
2061:                     loc_oBusca.Release()
2062:                 ENDIF
2063:             ENDIF
2064:         CATCH TO loc_oErro
2065:             MsgErro("Erro em FormSigPrCtr.TxtDcontaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 2076 a 2419:
2076:     *--------------------------------------------------------------------------
2077:     * TxtCpfLostFocus - Lookup SigCdCli por Cpfs (CNPJ/CPF); preenche Conta e Dconta
2078:     *--------------------------------------------------------------------------
2079:     PROCEDURE TxtCpfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2080:         LOCAL loc_oPg2P1, loc_cCpf, loc_cCpfLimpo, loc_cSQL, loc_nResult, loc_oErro
2081:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2082: 
2083:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2084:             RETURN
2085:         ENDIF
2086: 
2087:         loc_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
2088:         IF EMPTY(loc_cCpf)
2089:             RETURN
2090:         ENDIF
2091: 
2092:         loc_cCpfLimpo = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
2093: 
2094:         TRY
2095:             IF USED("cursor_4c_BuscaCli")
2096:                 USE IN cursor_4c_BuscaCli
2097:             ENDIF
2098:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
2099:                        " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
2100:                        " ORDER BY Iclis"
2101:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2102: 
2103:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2104:                RECCOUNT("cursor_4c_BuscaCli") > 0
2105:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2106:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2107:                 ENDIF
2108:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
2109:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2110:                 ENDIF
2111:                 loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2112:                 IF USED("cursor_4c_BuscaCli")
2113:                     USE IN cursor_4c_BuscaCli
2114:                 ENDIF
2115:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2116:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
2117:                 ENDIF
2118:             ELSE
2119:                 IF USED("cursor_4c_BuscaCli")
2120:                     USE IN cursor_4c_BuscaCli
2121:                 ENDIF
2122:                 MsgAviso("CPF/CNPJ n" + CHR(227) + "o encontrado no cadastro.", "Aviso")
2123:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
2124:             ENDIF
2125:         CATCH TO loc_oErro
2126:             MsgErro("Erro em FormSigPrCtr.TxtCpfLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2127:         ENDTRY
2128:     ENDPROC
2129: 
2130:     *--------------------------------------------------------------------------
2131:     * TxtMoedaLostFocus - Lookup SigCdMoe por CMoes; preenche ou limpa campo
2132:     *--------------------------------------------------------------------------
2133:     PROCEDURE TxtMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2134:         LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
2135:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2136: 
2137:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
2138:             RETURN
2139:         ENDIF
2140: 
2141:         loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
2142: 
2143:         IF EMPTY(loc_cMoeda)
2144:             loc_oPg2P1.txt_4c_Moeda.Value = ""
2145:             RETURN
2146:         ENDIF
2147: 
2148:         TRY
2149:             IF USED("cursor_4c_BuscaMoe")
2150:                 USE IN cursor_4c_BuscaMoe
2151:             ENDIF
2152:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2153:                        " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
2154:                        " ORDER BY CMoes"
2155:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
2156: 
2157:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
2158:                RECCOUNT("cursor_4c_BuscaMoe") > 0
2159:                 loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2160:                 IF USED("cursor_4c_BuscaMoe")
2161:                     USE IN cursor_4c_BuscaMoe
2162:                 ENDIF
2163:             ELSE
2164:                 IF USED("cursor_4c_BuscaMoe")
2165:                     USE IN cursor_4c_BuscaMoe
2166:                 ENDIF
2167:                 loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2168:                            " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
2169:                            EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
2170:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
2171:                    !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
2172:                     IF USED("cursor_4c_BuscaMoe")
2173:                         USE IN cursor_4c_BuscaMoe
2174:                     ENDIF
2175:                     =SQLEXEC(gnConnHandle, ;
2176:                         "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2177:                         "cursor_4c_BuscaMoe")
2178:                 ENDIF
2179:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2180:                     "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
2181:                 IF VARTYPE(loc_oBusca) = "O"
2182:                     IF !loc_oBusca.this_lSelecionou
2183:                         IF USED("cursor_4c_BuscaMoe")
2184:                             USE IN cursor_4c_BuscaMoe
2185:                         ENDIF
2186:                         =SQLEXEC(gnConnHandle, ;
2187:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2188:                             "cursor_4c_BuscaMoe")
2189:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2190:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2191:                         loc_oBusca.Show()
2192:                     ENDIF
2193:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2194:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2195:                     ELSE
2196:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2197:                     ENDIF
2198:                     IF USED("cursor_4c_BuscaMoe")
2199:                         USE IN cursor_4c_BuscaMoe
2200:                     ENDIF
2201:                     loc_oBusca.Release()
2202:                 ENDIF
2203:             ENDIF
2204:         CATCH TO loc_oErro
2205:             MsgErro("Erro em FormSigPrCtr.TxtMoedaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2206:         ENDTRY
2207: 
2208:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
2209:             loc_oPg2P1.txt_4c_Moeda.Refresh
2210:         ENDIF
2211:     ENDPROC
2212: 
2213:     *--------------------------------------------------------------------------
2214:     * CmdCommand12Click - Abre dialogo de selecao de arquivo XML
2215:     *--------------------------------------------------------------------------
2216:     PROCEDURE CmdCommand12Click()
2217:         LOCAL loc_oPg2P1, loc_cArquivo
2218:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2219:         loc_cArquivo = GETFILE("XML", "Selecionar arquivo XML", "Selecionar")
2220: 
2221:         IF !EMPTY(loc_cArquivo) AND PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
2222:             loc_oPg2P1.txt_4c_Arquivo.Value = loc_cArquivo
2223:         ENDIF
2224:     ENDPROC
2225: 
2226:     *--------------------------------------------------------------------------
2227:     * CmdBotConsultaClick - Abre consulta generica de vendas para a conta
2228:     *--------------------------------------------------------------------------
2229:     PROCEDURE CmdBotConsultaClick()
2230:         LOCAL loc_oPg2P1, loc_cConta, loc_oErro
2231:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2232: 
2233:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2234:             RETURN
2235:         ENDIF
2236: 
2237:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
2238: 
2239:         IF EMPTY(loc_cConta)
2240:             MsgAviso("Informe a conta antes de acessar a consulta.", "Aviso")
2241:             RETURN
2242:         ENDIF
2243: 
2244:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2245:             TRY
2246:                 DO FORM FormSigOpCgv WITH THIS, loc_cConta
2247:             CATCH TO loc_oErro
2248:                 MsgErro("Erro ao abrir consulta gen" + CHR(233) + "rica: " + ;
2249:                         loc_oErro.Message, "Erro")
2250:             ENDTRY
2251:         ENDIF
2252:     ENDPROC
2253: 
2254:     *--------------------------------------------------------------------------
2255:     * CmdBtnCadastrosClick - Abre cadastro do fornecedor
2256:     *--------------------------------------------------------------------------
2257:     PROCEDURE CmdBtnCadastrosClick()
2258:         LOCAL loc_oPg2P1, loc_cConta, loc_oErro
2259:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2260: 
2261:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2262:             RETURN
2263:         ENDIF
2264: 
2265:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
2266: 
2267:         IF EMPTY(loc_cConta)
2268:             MsgAviso("Informe a conta antes de acessar o cadastro.", "Dados Incompletos")
2269:             RETURN
2270:         ENDIF
2271: 
2272:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
2273:             TRY
2274:                 DO FORM FormSigCdCli WITH loc_cConta
2275:             CATCH TO loc_oErro
2276:                 MsgErro("Erro ao abrir cadastro: " + loc_oErro.Message, "Erro")
2277:             ENDTRY
2278:         ENDIF
2279:     ENDPROC
2280: 
2281:     *--------------------------------------------------------------------------
2282:     * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE CmdOperacaoClick()
2285:         LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro
2286: 
2287:         IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
2288:            RECCOUNT("cursor_4c_Pendentes") = 0
2289:             MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
2290:             RETURN
2291:         ENDIF
2292: 
2293:         TRY
2294:             SELECT cursor_4c_Pendentes
2295:             loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
2296:             loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
2297:             loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)
2298: 
2299:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
2300:                 MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
2301:                 RETURN
2302:             ENDIF
2303: 
2304:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
2305:                        EscaparSQL(loc_cDopes)
2306:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2307: 
2308:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
2309:                RECCOUNT("cursor_4c_TmpOpe") > 0
2310:                 IF USED("cursor_4c_TmpOpe")
2311:                     USE IN cursor_4c_TmpOpe
2312:                 ENDIF
2313:                 DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2314:             ELSE
2315:                 IF USED("cursor_4c_TmpOpe")
2316:                     USE IN cursor_4c_TmpOpe
2317:                 ENDIF
2318:                 loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
2319:                            EscaparSQL(loc_cDopes)
2320:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
2321:                 IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
2322:                    RECCOUNT("cursor_4c_TmpOpd") > 0
2323:                     IF USED("cursor_4c_TmpOpd")
2324:                         USE IN cursor_4c_TmpOpd
2325:                     ENDIF
2326:                     DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2327:                 ELSE
2328:                     IF USED("cursor_4c_TmpOpd")
2329:                         USE IN cursor_4c_TmpOpd
2330:                     ENDIF
2331:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2332:                              "o encontrada no cadastro.", "Aviso")
2333:                 ENDIF
2334:             ENDIF
2335:         CATCH TO loc_oErro
2336:             MsgErro("Erro em FormSigPrCtr.CmdOperacaoClick:" + CHR(13) + ;
2337:                     loc_oErro.Message, "Erro")
2338:         ENDTRY
2339:     ENDPROC
2340: 
2341:     *--------------------------------------------------------------------------
2342:     * CmdProcessarClick - Processa arquivo XML: parse, busca estoque, filtra e
2343:     *   muda para Page2 do inner PageFrame para exibir resultados
2344:     *--------------------------------------------------------------------------
2345:     PROCEDURE CmdProcessarClick()
2346:         LOCAL loc_oPg2P1, loc_oPgDados, loc_cArquivo, loc_cConta, loc_cCpf
2347:         LOCAL loc_cCpfLimpo, loc_cStr, loc_cChaveNFe, loc_cCNPJXML, loc_cMsg
2348:         LOCAL loc_cSQL, loc_nResult, loc_cListaOriDopNums, loc_nTipo, loc_oErro
2349: 
2350:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2351:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados
2352: 
2353:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
2354:             RETURN
2355:         ENDIF
2356: 
2357:         loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
2358:         loc_cConta   = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5), ;
2359:                            ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), "")
2360:         loc_cCpf     = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf",   5), ;
2361:                            ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value),   "")
2362: 
2363:         IF EMPTY(loc_cArquivo)
2364:             MsgAviso("Nenhum diret" + CHR(243) + "rio foi informado.", "Aviso")
2365:             RETURN
2366:         ENDIF
2367: 
2368:         IF EMPTY(loc_cConta)
2369:             MsgAviso("Nenhum fornecedor foi informado.", "Aviso")
2370:             RETURN
2371:         ENDIF
2372: 
2373:         IF EMPTY(loc_cCpf)
2374:             MsgAviso("CNPJ/CPF do fornecedor n" + CHR(227) + "o informado.", "Aviso")
2375:             RETURN
2376:         ENDIF
2377: 
2378:         IF !FILE(loc_cArquivo)
2379:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo, "Aviso")
2380:             RETURN
2381:         ENDIF
2382: 
2383:         LOCAL loc_lAbortou
2384:         loc_lAbortou = .F.
2385: 
2386:         TRY
2387:             *-- Compara CNPJ do XML com CNPJ do fornecedor
2388:             loc_cCpfLimpo  = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
2389:             loc_cStr       = UPPER(FILETOSTR(loc_cArquivo))
2390:             loc_cChaveNFe  = ALLTRIM(STREXTRACT(loc_cStr, "<CHNFE>", "</CHNFE>"))
2391:             IF !EMPTY(loc_cChaveNFe)
2392:                 loc_cCNPJXML = SUBSTR(loc_cChaveNFe, 7, 14)
2393:                 IF loc_cCNPJXML != loc_cCpfLimpo
2394:                     loc_cMsg = "Fornecedor com CPF/CNPJ diferente do XML." + CHR(13) + ;
2395:                                "XML      : " + loc_cCNPJXML + CHR(13) + ;
2396:                                "Cadastro : " + loc_cCpfLimpo + CHR(13) + ;
2397:                                "Deseja continuar?"
2398:                     IF !MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2399:                         loc_lAbortou = .T.
2400:                     ENDIF
2401:                 ENDIF
2402:             ENDIF
2403: 
2404:             *-- Passo 1: parse XML -> cursor_4c_Itens
2405:             IF !loc_lAbortou
2406:                 IF !THIS.ProcessarArquivoXML(loc_cArquivo)
2407:                     loc_lAbortou = .T.
2408:                 ENDIF
2409:             ENDIF
2410: 
2411:             *-- Passo 2: lookup produtos em SigCdPro -> cursor_4c_Distribui
2412:             IF !loc_lAbortou
2413:                 THIS.CarregarItensXML()
2414:             ENDIF
2415: 
2416:             *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
2417:             IF !loc_lAbortou
2418:                 loc_cListaOriDopNums = ""
2419:                 IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0

*-- Linhas 2528 a 2549:
2528:                     .Column5.ControlSource = "cursor_4c_Movimentos.QtBaixas"
2529:                     .Column6.ControlSource = "cursor_4c_Movimentos.QtReservas"
2530:                     .Column7.ControlSource = "cursor_4c_Movimentos.Saldo"
2531:                 ENDWITH
2532:             ENDIF
2533:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2534:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2535:                     .RecordSourceType = 1
2536:                     .RecordSource     = "cursor_4c_Distribui"
2537:                     .Column1.ControlSource = "cursor_4c_Distribui.Cpros"
2538:                     .Column2.ControlSource = "cursor_4c_Distribui.Dpros"
2539:                     .Column3.ControlSource = "cursor_4c_Distribui.Qtds"
2540:                     .Column4.ControlSource = "cursor_4c_Distribui.Total"
2541:                 ENDWITH
2542:             ENDIF
2543:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2544:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2545:             ENDIF
2546:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2547:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2548:             ENDIF
2549:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)

*-- Linhas 2559 a 2621:
2559:     *--------------------------------------------------------------------------
2560:     * ProcessarArquivoXML - Carrega NFe XML e extrai itens para cursor_4c_Itens
2561:     *--------------------------------------------------------------------------
2562:     PROTECTED PROCEDURE ProcessarArquivoXML(par_cArquivo)
2563:         LOCAL loc_lResultado, loc_oXML, loc_nItems, loc_i, loc_oNode, loc_oErro
2564:         loc_lResultado = .F.
2565: 
2566:         IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
2567:             RETURN .F.
2568:         ENDIF
2569: 
2570:         TRY
2571:             IF USED("cursor_4c_Itens")
2572:                 USE IN cursor_4c_Itens
2573:             ENDIF
2574:             SET NULL ON
2575:             CREATE CURSOR cursor_4c_Itens ;
2576:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2577:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2578:                   desconto C(15), frete C(15) )
2579:             SET NULL OFF
2580: 
2581:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2582:             IF VARTYPE(loc_oXML) != "O"
2583:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2584:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2585:             ELSE
2586:                 loc_oXML.async = .F.
2587:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2588: 
2589:                 IF !loc_oXML.Load(par_cArquivo)
2590:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;
2591:                             " corrompido.", "Erro XML")
2592:                     WAIT CLEAR
2593:                 ELSE
2594:                     IF UPPER(loc_oXML.documentElement.baseName) != "NFEPROC"
2595:                     MsgErro(JUSTFNAME(par_cArquivo) + " n" + CHR(227) + "o " + ;
2596:                             CHR(233) + " uma NF-e com autoriza" + CHR(231) + ;
2597:                             CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
2598:                     WAIT CLEAR
2599:                 ELSE
2600:                     loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2601:                     FOR loc_i = 0 TO loc_nItems - 1
2602:                         loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
2603:                         APPEND BLANK IN cursor_4c_Itens
2604:                         REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
2605:                                 IN cursor_4c_Itens
2606:                         REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
2607:                                 IN cursor_4c_Itens
2608:                         REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
2609:                                 IN cursor_4c_Itens
2610:                         REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
2611:                                 IN cursor_4c_Itens
2612:                         REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
2613:                                 IN cursor_4c_Itens
2614:                         REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
2615:                                 IN cursor_4c_Itens
2616:                         REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
2617:                                 IN cursor_4c_Itens
2618:                         REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
2619:                                 IN cursor_4c_Itens
2620:                         IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
2621:                             REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;

*-- Linhas 2648 a 2691:
2648:     * CarregarItensXML - Lookup de cada item do XML em SigCdPro (por Reffs,
2649:     *   Cpros, Dpros, DPro2s); constroi cursor_4c_Distribui com produtos encontrados
2650:     *--------------------------------------------------------------------------
2651:     PROTECTED PROCEDURE CarregarItensXML()
2652:         LOCAL loc_cCodigo, loc_nQtd, loc_nVal, loc_nTot, loc_cSQL, loc_nResult, loc_oErro
2653: 
2654:         IF USED("cursor_4c_Distribui")
2655:             USE IN cursor_4c_Distribui
2656:         ENDIF
2657:         SET NULL ON
2658:         CREATE CURSOR cursor_4c_Distribui ;
2659:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2660:         SET NULL OFF
2661: 
2662:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2663:             RETURN
2664:         ENDIF
2665: 
2666:         TRY
2667:             SELECT cursor_4c_Itens
2668:             GO TOP
2669: 
2670:             SCAN
2671:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2672:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2673:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2674:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))
2675: 
2676:                 IF !EMPTY(loc_cCodigo)
2677:                     IF USED("cursor_4c_ProdImport")
2678:                         USE IN cursor_4c_ProdImport
2679:                     ENDIF
2680: 
2681:                     loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2682:                                " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
2683:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2684: 
2685:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2686:                        RECCOUNT("cursor_4c_ProdImport") = 0
2687:                         IF USED("cursor_4c_ProdImport")
2688:                             USE IN cursor_4c_ProdImport
2689:                         ENDIF
2690:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2691:                                    " WHERE Cpros = " + EscaparSQL(loc_cCodigo)

*-- Linhas 2743 a 2786:
2743:     *--------------------------------------------------------------------------
2744:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2745:     *--------------------------------------------------------------------------
2746:     PROTECTED PROCEDURE CarregarMovimentosPendentes(par_cConta, par_lFiltrar)
2747:         LOCAL loc_oPg2P1, loc_oGrid, loc_lResultado, loc_oErro
2748:         loc_lResultado = .F.
2749: 
2750:         TRY
2751:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2752:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2753:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2754:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2755:                     loc_oGrid.ColumnCount = 5
2756:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2757:                     WITH loc_oGrid
2758:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2759:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2760:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2761:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2762:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2763:                     ENDWITH
2764:                 ENDIF
2765:                 loc_lResultado = .T.
2766:             ENDIF
2767:         CATCH TO loc_oErro
2768:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2769:                     loc_oErro.Message, "Erro")
2770:         ENDTRY
2771: 
2772:         RETURN loc_lResultado
2773:     ENDPROC
2774: 
2775:     *--------------------------------------------------------------------------
2776:     * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
2777:     *--------------------------------------------------------------------------
2778:     PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
2779:         LOCAL loc_oNode, loc_cResult, loc_oErro
2780:         loc_cResult = ""
2781: 
2782:         TRY
2783:             IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
2784:                 loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
2785:                 IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
2786:                     loc_cResult = NVL(loc_oNode.Text, "")

*-- Linhas 2800 a 2871:
2800:     * grdDisponivel (7 colunas), grdItemXml (4 colunas), campos produto
2801:     * Offset +29 em Top para compensar tab oculta do inner PageFrame
2802:     *--------------------------------------------------------------------------
2803:     PROTECTED PROCEDURE ConfigurarPaginaDadosDetalhe()
2804:         LOCAL loc_oPg2P2
2805:         loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2806: 
2807:         *-- Shape5: borda ao redor da imagem (top=1+29=30)
2808:         loc_oPg2P2.AddObject("shp_4c_Shape5", "Shape")
2809:         WITH loc_oPg2P2.shp_4c_Shape5
2810:             .Top = 30
2811:             .Left = 424
2812:             .Height = 113
2813:             .Width = 282
2814:             .BackStyle = 0
2815:             .BorderStyle = 1
2816:             .BorderWidth = 2
2817:             .SpecialEffect = 0
2818:             .Visible = .T.
2819:         ENDWITH
2820: 
2821:         *-- Imagem produto FigJpg / img_4c_FigJpg (top=3+29=32)
2822:         loc_oPg2P2.AddObject("img_4c_FigJpg", "Image")
2823:         WITH loc_oPg2P2.img_4c_FigJpg
2824:             .Stretch = 1
2825:             .Top = 32
2826:             .Left = 426
2827:             .Width = 278
2828:             .Height = 109
2829:             .Visible = .F.
2830:         ENDWITH
2831:         BINDEVENT(loc_oPg2P2.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")
2832: 
2833:         *-- Textboxes de cabecalho Sistema/Arquivo (top=113+29=142)
2834:         loc_oPg2P2.AddObject("txt_4c_Sistema", "TextBox")
2835:         WITH loc_oPg2P2.txt_4c_Sistema
2836:             .FontBold = .T.
2837:             .Alignment = 2
2838:             .Top = 142
2839:             .Left = 8
2840:             .Width = 684
2841:             .Height = 20
2842:             .BackColor = RGB(128, 255, 255)
2843:             .BackStyle = 1
2844:             .ReadOnly = .T.
2845:             .BorderStyle = 0
2846:             .Value = "Sistema"
2847:             .Visible = .T.
2848:         ENDWITH
2849: 
2850:         loc_oPg2P2.AddObject("txt_4c_Arquivo", "TextBox")
2851:         WITH loc_oPg2P2.txt_4c_Arquivo
2852:             .FontBold = .T.
2853:             .Alignment = 2
2854:             .Top = 142
2855:             .Left = 691
2856:             .Width = 495
2857:             .Height = 20
2858:             .BackColor = RGB(255, 255, 128)
2859:             .BackStyle = 1
2860:             .ReadOnly = .T.
2861:             .BorderStyle = 0
2862:             .Value = "Arquivo"
2863:             .Visible = .T.
2864:         ENDWITH
2865: 
2866:         *-- Label procurar produto (top=74+29=103)
2867:         loc_oPg2P2.AddObject("lbl_4c_Lbl_produto", "Label")
2868:         WITH loc_oPg2P2.lbl_4c_Lbl_produto
2869:             .Caption   = "Procurar Produto :"
2870:             .AutoSize  = .T.
2871:             .Top = 103

*-- Linhas 2893 a 2936:
2893:             .SpecialEffect = 1
2894:             .Visible = .T.
2895:         ENDWITH
2896:         BINDEVENT(loc_oPg2P2.txt_4c__produto_inicial, "KeyPress", THIS, "TxtProdutoInicialLostFocus")
2897: 
2898:         *-- Grid disponivel / grd_4c_Disponivel (7 colunas, top=134+29=163)
2899:         loc_oPg2P2.AddObject("grd_4c_Disponivel", "Grid")
2900:         loc_oPg2P2.grd_4c_Disponivel.ColumnCount = 7
2901:         loc_oPg2P2.grd_4c_Disponivel.Top         = 163
2902:         loc_oPg2P2.grd_4c_Disponivel.Left        = 8
2903:         loc_oPg2P2.grd_4c_Disponivel.Width       = 684
2904:         loc_oPg2P2.grd_4c_Disponivel.Height      = 344
2905:         WITH loc_oPg2P2.grd_4c_Disponivel
2906:             .FontName  = "Tahoma"
2907:             .FontSize = 8
2908:             .ReadOnly  = .T.
2909:             .RecordMark = .F.
2910:             .RowHeight = 17
2911:             .Panel = 1
2912:             .BackColor = RGB(237, 242, 243)
2913:             .GridLineColor = RGB(238, 238, 238)
2914:             .AllowHeaderSizing = .F.
2915:             .AllowRowSizing = .F.
2916:             .ScrollBars = 2
2917:             .Visible = .T.
2918: 
2919:             WITH .Column1
2920:                 .Width = 100
2921:                 .Movable = .F.
2922:                 .Resizable = .F.
2923:                 .ReadOnly = .T.
2924:                 .ForeColor = RGB(0, 0, 255)
2925:                 .BackColor = RGB(237, 242, 243)
2926:                 .MousePointer = 15
2927:                 .FontBold = .T.
2928:                 .FontUnderline = .T.
2929:                 .Header1.Caption = "C" + CHR(243) + "digo"
2930:                 .Header1.Alignment = 2
2931:                 .Header1.ForeColor = RGB(90, 90, 90)
2932:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2933:             ENDWITH
2934: 
2935:             WITH .Column2
2936:                 .Width = 235

*-- Linhas 3008 a 3052:
3008:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
3009:             ENDWITH
3010:         ENDWITH
3011:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
3012:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
3013: 
3014:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
3015:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
3016:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
3017:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
3018:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
3019:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
3020:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
3021:         WITH loc_oPg2P2.grd_4c_ItemXml
3022:             .FontName  = "Tahoma"
3023:             .FontSize = 8
3024:             .RecordMark = .F.
3025:             .Panel = 1
3026:             .BackColor = RGB(237, 242, 243)
3027:             .GridLineColor = RGB(238, 238, 238)
3028:             .AllowHeaderSizing = .F.
3029:             .AllowRowSizing = .F.
3030:             .RowHeight = 17
3031:             .Visible = .T.
3032: 
3033:             WITH .Column1
3034:                 .Width = 100
3035:                 .Movable = .F.
3036:                 .Resizable = .F.
3037:                 .ReadOnly = .T.
3038:                 .Enabled = .F.
3039:                 .ForeColor = RGB(0, 0, 0)
3040:                 .BackColor = RGB(237, 242, 243)
3041:                 .Header1.Caption = "C" + CHR(243) + "digo"
3042:                 .Header1.Alignment = 2
3043:                 .Header1.ForeColor = RGB(90, 90, 90)
3044:                 .ControlSource = "cursor_4c_Distribui.Cpros"
3045:             ENDWITH
3046: 
3047:             WITH .Column2
3048:                 .Width = 235
3049:                 .Movable = .F.
3050:                 .Resizable = .F.
3051:                 .ReadOnly = .T.
3052:                 .Enabled = .F.

*-- Linhas 3103 a 3165:
3103:             .TabStop = .F.
3104:             .Visible = .T.
3105:         ENDWITH
3106:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
3107: 
3108:         *-- Botao excluir Grade Arquivo / cmd_4c_BtnExcluirArq (top=479+29=508)
3109:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
3110:         WITH loc_oPg2P2.cmd_4c_BtnExcluirArq
3111:             .Caption = ""
3112:             .Themes = .F.
3113:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3114:             .Top = 508
3115:             .Left = 1146
3116:             .Width = 40
3117:             .Height = 37
3118:             .ForeColor = RGB(255, 0, 0)
3119:             .BackColor = RGB(255, 255, 255)
3120:             .ToolTipText = "Excluir Linha da Grade Arquivo"
3121:             .SpecialEffect = 0
3122:             .TabStop = .F.
3123:             .Visible = .T.
3124:         ENDWITH
3125:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
3126: 
3127:         *-- Label: Movimentacao (Say3, top=483+29=512)
3128:         loc_oPg2P2.AddObject("lbl_4c_Label3", "Label")
3129:         WITH loc_oPg2P2.lbl_4c_Label3
3130:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
3131:             .AutoSize  = .T.
3132:             .Top = 512
3133:             .Left = 40
3134:             .Height = 15
3135:             .FontName  = "Tahoma"
3136:             .FontSize = 8
3137:             .ForeColor = RGB(90, 90, 90)
3138:             .BackStyle = 0
3139:             .Visible = .T.
3140:         ENDWITH
3141: 
3142:         *-- getEmps (top=480+29=509)
3143:         loc_oPg2P2.AddObject("txt_4c_Emps", "TextBox")
3144:         WITH loc_oPg2P2.txt_4c_Emps
3145:             .Value = ""
3146:             .Format = "K!"
3147:             .ReadOnly = .T.
3148:             .Top = 509
3149:             .Left = 122
3150:             .Width = 65
3151:             .Height = 21
3152:             .FontName = "Tahoma"
3153:             .FontSize = 8
3154:             .SpecialEffect = 1
3155:             .Visible = .T.
3156:             .BackColor = RGB(255, 255, 255)
3157:             .BackStyle = 1
3158:         ENDWITH
3159: 
3160:         *-- getDopes (top=480+29=509)
3161:         loc_oPg2P2.AddObject("txt_4c_Dopes", "TextBox")
3162:         WITH loc_oPg2P2.txt_4c_Dopes
3163:             .Value = ""
3164:             .MaxLength = 20
3165:             .Format = "K!"

*-- Linhas 3417 a 3485:
3417:             .BackStyle = 1
3418:         ENDWITH
3419: 
3420:         BINDEVENT(loc_oPg2P2, "Activate", THIS, "PgfDadosPage2Activate")
3421:     ENDPROC
3422: 
3423:     *--------------------------------------------------------------------------
3424:     * PgfDadosPage2Activate - Refresca grids ao ativar Page2 de detalhe
3425:     *--------------------------------------------------------------------------
3426:     PROCEDURE PgfDadosPage2Activate()
3427:         LOCAL loc_oPg2P2, loc_oErro
3428:         TRY
3429:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3430:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3431:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3432:             ENDIF
3433:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3434:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3435:             ENDIF
3436:         CATCH TO loc_oErro
3437:             MsgErro("Erro em FormSigPrCtr.PgfDadosPage2Activate:" + CHR(13) + loc_oErro.Message, "Erro")
3438:         ENDTRY
3439:     ENDPROC
3440: 
3441:     *--------------------------------------------------------------------------
3442:     * GrdDisponivelAfterRowColChange - Ao mover linha em grd_4c_Disponivel:
3443:     *   busca detalhes SigCdPro e popula campos inferiores + FigJpg
3444:     *--------------------------------------------------------------------------
3445:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
3446:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult, loc_cArqTemp
3447:         LOCAL loc_cFigJpgs, loc_cFoto, loc_lTemFig
3448:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3449:         LOCAL loc_lAbortou, loc_oErro
3450:         loc_lAbortou = .F.
3451: 
3452:         TRY
3453:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3454:                 loc_lAbortou = .T.
3455:             ENDIF
3456: 
3457:             IF !loc_lAbortou
3458:                 loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3459:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3460:                 IF EMPTY(loc_cCpros)
3461:                     loc_lAbortou = .T.
3462:                 ENDIF
3463:             ENDIF
3464: 
3465:             IF !loc_lAbortou
3466:                 loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
3467:                            " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
3468:                            " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3469:                 IF USED("cursor_4c_TmpPro")
3470:                     USE IN cursor_4c_TmpPro
3471:                 ENDIF
3472:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3473:                 IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3474:                     loc_lAbortou = .T.
3475:                 ENDIF
3476:             ENDIF
3477: 
3478:             IF !loc_lAbortou
3479:                 SELECT cursor_4c_TmpPro
3480:                 GO TOP
3481: 
3482:                 *-- Campos detalhe produto
3483:                 loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
3484:                 loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
3485:                 loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))

*-- Linhas 3567 a 3685:
3567:     *--------------------------------------------------------------------------
3568:     * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
3569:     *--------------------------------------------------------------------------
3570:     PROCEDURE BtnExcluirSisClick()
3571:         LOCAL loc_oPg2P2, loc_oErro
3572:         TRY
3573:             IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
3574:                 SELECT cursor_4c_Movimentos
3575:                 DELETE
3576:                 IF !EOF("cursor_4c_Movimentos")
3577:                     SKIP
3578:                     SKIP -1
3579:                 ENDIF
3580:                 GO TOP IN cursor_4c_Movimentos
3581:             ENDIF
3582:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3583:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3584:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3585:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3586:             ENDIF
3587:         CATCH TO loc_oErro
3588:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3589:         ENDTRY
3590:     ENDPROC
3591: 
3592:     *--------------------------------------------------------------------------
3593:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3594:     *--------------------------------------------------------------------------
3595:     PROCEDURE BtnExcluirArqClick()
3596:         LOCAL loc_oPg2P2, loc_oErro
3597:         TRY
3598:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3599:                 SELECT cursor_4c_Distribui
3600:                 DELETE
3601:                 IF !EOF("cursor_4c_Distribui")
3602:                     SKIP
3603:                     SKIP -1
3604:                 ENDIF
3605:                 GO TOP IN cursor_4c_Distribui
3606:             ENDIF
3607:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3608:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3609:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3610:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3611:             ENDIF
3612:         CATCH TO loc_oErro
3613:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3614:         ENDTRY
3615:     ENDPROC
3616: 
3617:     *--------------------------------------------------------------------------
3618:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3619:     *--------------------------------------------------------------------------
3620:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3621:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3622:         TRY
3623:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3624:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3625:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
3626:                 IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
3627:                     SELECT cursor_4c_Movimentos
3628:                     loc_nRecno = RECNO()
3629:                     GO TOP
3630:                     LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
3631:                     IF EOF()
3632:                         GO loc_nRecno
3633:                     ENDIF
3634:                 ENDIF
3635:             ENDIF
3636:         CATCH TO loc_oErro
3637:             MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
3638:                     loc_oErro.Message, "Erro")
3639:         ENDTRY
3640:     ENDPROC
3641: 
3642:     *--------------------------------------------------------------------------
3643:     * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
3644:     *--------------------------------------------------------------------------
3645:     PROCEDURE ImgFigJpgDblClick()
3646:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
3647:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
3648:         TRY
3649:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3650:                 RETURN
3651:             ENDIF
3652:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3653:             IF EMPTY(loc_cCpros)
3654:                 RETURN
3655:             ENDIF
3656:             loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
3657:                        EscaparSQL(loc_cCpros)
3658:             IF USED("cursor_4c_TmpPro")
3659:                 USE IN cursor_4c_TmpPro
3660:             ENDIF
3661:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3662:             IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3663:                 RETURN
3664:             ENDIF
3665:             SELECT cursor_4c_TmpPro
3666:             GO TOP
3667:             loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3668:             IF USED("cursor_4c_TmpPro")
3669:                 USE IN cursor_4c_TmpPro
3670:             ENDIF
3671:             IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
3672:                 loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3673:                 loc_cFoto = STRCONV(;
3674:                     STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3675:                         "data:image/png;base64,", ""), ;
3676:                         "data:image/jpeg;base64,", ""), ;
3677:                         "data:image/jpg;base64,", ""), 14)
3678:                 STRTOFILE(loc_cFoto, loc_cArqTemp)
3679:                 IF FILE(loc_cArqTemp)
3680:                     loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
3681:                                    ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
3682:                     IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
3683:                        FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
3684:                         DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
3685:                             WITH loc_cArqTemp, loc_cCaption, " "

*-- Linhas 3699 a 3773:
3699:     *--------------------------------------------------------------------------
3700:     * GrdDisponivelDblClick - Duplo clique em Col01 abre pesquisa global produto
3701:     *--------------------------------------------------------------------------
3702:     PROCEDURE GrdDisponivelDblClick()
3703:         LOCAL loc_oPg2P2, loc_cCpros, loc_oErro
3704:         TRY
3705:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3706:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3707:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3708:                     RETURN
3709:                 ENDIF
3710:             ENDIF
3711:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3712:                 RETURN
3713:             ENDIF
3714:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3715:             IF EMPTY(loc_cCpros)
3716:                 RETURN
3717:             ENDIF
3718:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3719:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3720:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3721:             ELSE
3722:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
3723:                         ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
3724:             ENDIF
3725:         CATCH TO loc_oErro
3726:             MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3727:         ENDTRY
3728:     ENDPROC
3729: 
3730:     *--------------------------------------------------------------------------
3731:     * Destroy - Libera BO e fecha cursores
3732:     *--------------------------------------------------------------------------
3733:     PROCEDURE Destroy()
3734:         LOCAL loc_oErro
3735: 
3736:         TRY
3737:             IF USED("cursor_4c_Dados")
3738:                 USE IN cursor_4c_Dados
3739:             ENDIF
3740: 
3741:             IF USED("cursor_4c_Movimentos")
3742:                 USE IN cursor_4c_Movimentos
3743:             ENDIF
3744: 
3745:             IF USED("cursor_4c_Pendentes")
3746:                 USE IN cursor_4c_Pendentes
3747:             ENDIF
3748: 
3749:             IF USED("cursor_4c_Linhas")
3750:                 USE IN cursor_4c_Linhas
3751:             ENDIF
3752: 
3753:             IF USED("cursor_4c_Itens")
3754:                 USE IN cursor_4c_Itens
3755:             ENDIF
3756: 
3757:             IF USED("cursor_4c_Distribui")
3758:                 USE IN cursor_4c_Distribui
3759:             ENDIF
3760: 
3761:             IF USED("cursor_4c_TmpJoin")
3762:                 USE IN cursor_4c_TmpJoin
3763:             ENDIF
3764: 
3765:             IF USED("cursor_4c_MovTmp")
3766:                 USE IN cursor_4c_MovTmp
3767:             ENDIF
3768: 
3769:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3770:                 THIS.this_oBusinessObject = .NULL.
3771:             ENDIF
3772:         CATCH TO loc_oErro
3773:             MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*
* Descricao: Gerencia lotes de distribuicao de produtos via XML.
*   Cada "Codigos" representa um lote que agrupa N linhas em SigPrCtr
*   (uma por produto distribuido). A exclusao/atualizacao opera por Codigos
*   (DELETE WHERE Codigos = ?), nao por PkChave.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Chave primaria real da tabela (unica por linha)
    this_cPkChave    = ""  && char(20) - PRIMARY KEY
    *-- Chave de lote: identifica o conjunto de linhas do processamento
    this_cCodigos    = ""  && char(10) - identificador do lote
    *-- Campos do produto na linha
    this_cCodCors    = ""  && char(4)  - codigo da cor
    this_cCodTams    = ""  && char(4)  - codigo do tamanho
    this_cCpros      = ""  && char(14) - codigo do produto
    *-- Quantidades
    this_nQtds       = 0   && numeric(10,2) - quantidade XML
    this_nQtdOs      = 0   && numeric(10,2) - quantidade OS/distribuida
    *-- Referencia de origem
    this_cOriDopNums = ""  && char(29) - EmpDopNums da movimentacao de origem
    this_cFkChaves   = ""  && char(20) - cidchaves do item de movimentacao
    *-- Dados do fornecedor/conta
    this_cContas     = ""  && char(10) - codigo da conta/fornecedor
    *-- Opcoes de processamento
    this_nPrecific   = 0   && numeric(1,0) - tipo de precificacao (Opt_Custo)
    this_cMoedas     = ""  && char(3)  - codigo da moeda
    this_cArquivo    = ""  && char(200) - caminho do arquivo XML
    *-- Auditoria
    this_dDatas      = {}  && datetime - data/hora do processamento
    this_dDtAlts     = {}  && datetime - data/hora da ultima alteracao
    this_cUsuars     = ""  && char(10) - usuario que criou
    this_cUsualts    = ""  && char(10) - usuario da ultima alteracao

    *-- Campos operacionais do formulario (nao persistidos diretamente)
    this_cGrupo      = ""  && grupo contabil (Get_Grupo - GrPadFors de SigCdPam)
    this_cDconta     = ""  && descricao da conta (Get_Dconta)
    this_cCpf        = ""  && CPF/CNPJ do fornecedor (Get_cpf)

    *-- Filtro de data para a lista principal
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigPrCtr"
            THIS.this_cCampoChave  = "PkChave"
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar SigPrCtrBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de lote para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Grava novo lote (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN THIS.SalvarLote("", .T.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lote existente (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN THIS.SalvarLote(THIS.this_cCodigos, .F.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona lotes distintos de SigPrCtr filtrados por data
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFin, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicial)
            loc_cDataFin = FormatarDataSQL(THIS.this_dDataFinal)

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON b.Iclis = a.Contas" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFin + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " HAVING " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo Codigos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_cFkChaves   = TratarNulo(FkChaves,   "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_cUsualts    = TratarNulo(UsuAlts,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMovimentosDistribuiveis - Produtos do lote para grdDisponivel (Page2)
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosDistribuiveis(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
                       " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
                       " SUM(a.QtReservas) AS QtReservas," + ;
                       " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
                       " SUM(g.QtdOs) AS QtdOs," + ;
                       " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
                       " a.CidChaves, a.Moedas" + ;
                       " FROM SigMvItn a" + ;
                       " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
                       " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
                       " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
                       " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
                       " JOIN SigPrCtr g ON a.EmpDopNums = g.OriDopNums" + ;
                       "   AND a.Cpros = g.Cpros AND g.FkChaves = a.CidChaves" + ;
                       " WHERE e.Distribui = 3" + ;
                       " AND c.GrupoDs <> SPACE(10)" + ;
                       " AND c.ContaDs <> SPACE(10)" + ;
                       " AND a.Qtds <> a.QtBaixas" + ;
                       " AND a.CItem2 = 0" + ;
                       " AND g.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
                       "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Movimentos")
                TABLEREVERT(.T., "cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Movimentos")
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosDistribuiveis: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    *   Retorna movimentacoes distribuiveis para grdEstoque (Page1)
    *   par_cConta   : filtra por fornecedor (vazio = todos)
    *   par_lFiltrar : .T. aplica filtro de conta
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_cFiltro = ""
            IF par_lFiltrar AND !EMPTY(ALLTRIM(par_cConta))
                loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(par_cConta)
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes," + ;
                       " a.EmpDopNums AS OriDopNums," + ;
                       " a.GrupoOs AS Grupos, a.ContaOs AS Contas" + ;
                       " FROM SigMvCab a" + ;
                       " JOIN SigCdOpe b ON a.Dopes = b.Dopes" + ;
                       " JOIN SigOpCdd c ON b.Dopes = c.Dopes" + ;
                       " WHERE c.Distribui = 3" + ;
                       " AND a.ChkSubn = 0" + ;
                       " AND a.GrupoOs <> SPACE(10)" + ;
                       " AND a.ContaOs <> SPACE(10)" + ;
                       loc_cFiltro

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Pendentes")
                TABLEREVERT(.T., "cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pendentes")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Pendentes")
                    GO TOP IN cursor_4c_Pendentes
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar pendentes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosPendentes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarLote - Persiste linhas de cursor_4c_Linhas no banco.
    *   Modo INSERIR (par_lNovoLote=.T.): gera novo Codigos, insere linhas
    *   Modo ALTERAR (par_lNovoLote=.F.): deleta lote antigo, insere novas linhas
    *
    *   cursor_4c_Linhas deve conter os campos:
    *     Cpros(C14), CodCors(C4), CodTams(C4), OriDopNums(C29),
    *     Qtds(N), QtdOs(N), Contas(C10), Arquivo(C200),
    *     Moedas(C3), Precific(N), FkChaves(C20)
    *--------------------------------------------------------------------------
    FUNCTION SalvarLote(par_cCodigos, par_lNovoLote)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigos, loc_lScanOK
        loc_lResultado = .F.
        loc_cCodigos   = ""

        IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
            MsgErro("Nenhuma linha para gravar no lote.", "Aviso")
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_lResultado = .T.

            *-- Modo ALTERAR: exclui linhas do lote anterior antes de reinserir
            IF !par_lNovoLote AND !EMPTY(ALLTRIM(par_cCodigos))
                loc_cSQL   = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lote anterior: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Modo INSERIR: gera novo Codigos sequencial
            IF loc_lResultado AND par_lNovoLote
                loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) + 1" + ;
                           " AS ProxCod FROM SigPrCtr"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MaxCod")
                    TABLEREVERT(.T., "cursor_4c_MaxCod")
                    USE IN cursor_4c_MaxCod
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                    SELECT cursor_4c_MaxCod
                    loc_cCodigos = PADL(ALLTRIM(TRANSFORM(cursor_4c_MaxCod.ProxCod)), 10)
                    USE IN cursor_4c_MaxCod
                ELSE
                    MsgErro("Erro ao gerar codigo de lote: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado AND !par_lNovoLote
                loc_cCodigos = par_cCodigos
            ENDIF

            *-- Insere cada linha do cursor no banco
            IF loc_lResultado
                SELECT cursor_4c_Linhas
                GO TOP
                loc_lScanOK = .T.
                SCAN WHILE loc_lScanOK
                    loc_cSQL = "INSERT INTO SigPrCtr" + ;
                               " (PkChave, Codigos, Cpros, CodCors, CodTams," + ;
                               "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                               "  Moedas, Precific, FkChaves, Datas, Usuars)" + ;
                               " VALUES (" + ;
                               " NEWID()," + ;
                               EscaparSQL(loc_cCodigos) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Cpros), 14)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodCors), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodTams), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.OriDopNums), 29)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Qtds) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Contas), 10)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Arquivo), 200)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Moedas), 3)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Precific) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20)) + "," + ;
                               "GETDATE()," + ;
                               EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir linha do lote: " + CapturarErroSQL(), "Erro SQL")
                        loc_lScanOK = .F.
                        EXIT
                    ENDIF

                    *-- Acumula reserva em SigMvItn (espelha logica legada Salva.Click)
                    IF !EMPTY(ALLTRIM(cursor_4c_Linhas.FkChaves)) AND cursor_4c_Linhas.QtdOs > 0
                        loc_cSQL = "UPDATE SigMvItn SET QtReservas = (QtReservas + " + ;
                                   FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + ")" + ;
                                   " WHERE CidChaves = " + ;
                                   EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao atualizar reserva em SigMvItn: " + CapturarErroSQL(), "Erro SQL")
                            loc_lScanOK = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Linhas
                ENDSCAN

                loc_lResultado = loc_lScanOK
            ENDIF

            IF loc_lResultado
                THIS.this_cCodigos = loc_cCodigos
                THIS.RegistrarAuditoria(IIF(par_lNovoLote, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.SalvarLote: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todas as linhas do lote e restaura QtReservas.
    *   Chamado internamente por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lScanOK
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgErro("Codigo do lote nao informado para exclusao.", "Aviso")
            ELSE
                *-- Carrega linhas para restaurar QtReservas em SigMvItn
                loc_cSQL = "SELECT FkChaves, QtdOs FROM SigPrCtr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ExclLote")
                    TABLEREVERT(.T., "cursor_4c_ExclLote")
                    USE IN cursor_4c_ExclLote
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExclLote")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar lote para exclusao: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lScanOK = .T.
                    IF USED("cursor_4c_ExclLote") AND RECCOUNT("cursor_4c_ExclLote") > 0
                        SELECT cursor_4c_ExclLote
                        GO TOP
                        SCAN WHILE loc_lScanOK
                            loc_cSQL = "UPDATE SigMvItn SET QtReservas =" + ;
                                       " CASE WHEN (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ;
                                       ") < 0 THEN 0" + ;
                                       " ELSE (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ")" + ;
                                       " END" + ;
                                       " WHERE CidChaves = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_ExclLote.FkChaves))

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao restaurar QtReservas: " + CapturarErroSQL(), "Erro SQL")
                                loc_lScanOK = .F.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_ExclLote
                        ENDSCAN
                        USE IN cursor_4c_ExclLote
                    ENDIF

                    IF loc_lScanOK
                        loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

