# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (21)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [CARGA-DADOS] OptionGroup 'opt_4c_Custo' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Fil' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterNodeValue()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Movimentos' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_MovimentosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Linhas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Movimentos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Itens' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Distribui' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_nTot define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_nTot.RecordSource).
- [GRID-HEADER] Header Caption 'Lote' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Origem' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Lista): Top original=106 vs migrado 'lbl_4c_Label1' Top=579 (diff=473px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Lista): Left original=440 vs migrado 'lbl_4c_Label1' Left=348 (diff=92px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Dados.Pageframe1.Page1): Top original=184 vs migrado 'lbl_4c_Label1' Top=579 (diff=395px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Dados.Pageframe1.Page1): Left original=55 vs migrado 'lbl_4c_Label1' Left=348 (diff=293px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3691 linhas total):

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

*-- Linhas 223 a 700:
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
239:             .FontName = "Comic Sans MS"
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
263:             .FontName = "Comic Sans MS"
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
287:             .FontName = "Comic Sans MS"
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
311:             .FontName = "Comic Sans MS"
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
362:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
363:         WITH loc_oPagina.lbl_4c_Periodo
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
484:             .FontName = "Comic Sans MS"
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
508:             .FontName = "Comic Sans MS"
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
673:                 .AutoSize = .T.
674:                 .Top = 1
675:                 .Left = 5
676:                 .Height = 15
677:                 .Width = 73
678:                 .ForeColor = RGB(90, 90, 90)
679:             ENDWITH
680:             WITH .Buttons(2)
681:                 .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
682:                 .FontName  = "Tahoma"
683:                 .FontSize = 8
684:                 .BackStyle = 0
685:                 .AutoSize = .T.
686:                 .Top = 1
687:                 .Left = 98
688:                 .Height = 15
689:                 .Width = 129
690:                 .ForeColor = RGB(90, 90, 90)
691:             ENDWITH
692:             .Value = 1
693:         ENDWITH
694: 
695:         *-- Label: Moeda (Say3: top=137+29=166)
696:         loc_oPg2P1.AddObject("lbl_4c_LoteMoeda", "Label")
697:         WITH loc_oPg2P1.lbl_4c_LoteMoeda
698:             .Caption   = "Moeda :"
699:             .AutoSize  = .T.
700:             .Top = 166

*-- Linhas 721 a 832:
721:             .SpecialEffect = 1
722:             .Visible = .T.
723:         ENDWITH
724:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaLostFocus")
725:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "KeyPress",  THIS, "TxtMoedaKeyPress")
726:         BINDEVENT(loc_oPg2P1.txt_4c_Moeda, "DblClick",  THIS, "TxtMoedaDblClick")
727: 
728:         *-- Label: Diretorio (Say2: top=160+29=189)
729:         loc_oPg2P1.AddObject("lbl_4c_Dir", "Label")
730:         WITH loc_oPg2P1.lbl_4c_Dir
731:             .Caption   = "Diret" + CHR(243) + "rio :"
732:             .AutoSize  = .T.
733:             .Top = 189
734:             .Left = 253
735:             .Height = 15
736:             .FontName  = "Tahoma"
737:             .FontSize = 8
738:             .BackStyle = 0
739:             .Visible = .T.
740:         ENDWITH
741: 
742:         *-- TextBox: Get_Arquivo / txt_4c_Arquivo - ReadOnly, preenchido por Command12
743:         loc_oPg2P1.AddObject("txt_4c_Arquivo", "TextBox")
744:         WITH loc_oPg2P1.txt_4c_Arquivo
745:             .Value = ""
746:             .MaxLength = 200
747:             .Top = 186
748:             .Left = 307
749:             .Width = 357
750:             .Height = 21
751:             .FontName = "Tahoma"
752:             .FontSize = 8
753:             .SpecialEffect = 1
754:             .ReadOnly = .T.
755:             .Visible = .T.
756:         ENDWITH
757: 
758:         *-- Button: Command12 / cmd_4c_Command12 - file picker (top=157+29=186)
759:         loc_oPg2P1.AddObject("cmd_4c_Command12", "CommandButton")
760:         WITH loc_oPg2P1.cmd_4c_Command12
761:             .Caption = "..."
762:             .Top = 186
763:             .Left = 667
764:             .Width = 20
765:             .Height = 20
766:             .FontName = "Tahoma"
767:             .FontSize = 8
768:             .SpecialEffect = 0
769:             .MousePointer = 15
770:             .Visible = .T.
771:         ENDWITH
772:         BINDEVENT(loc_oPg2P1.cmd_4c_Command12, "Click", THIS, "CmdCommand12Click")
773: 
774:         *-- Label: Carregar produtos... (Label1: top=184+29=213)
775:         loc_oPg2P1.AddObject("lbl_4c_CarrProd", "Label")
776:         WITH loc_oPg2P1.lbl_4c_CarrProd
777:             .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
778:             .FontBold  = .T.
779:             .AutoSize  = .T.
780:             .Top = 213
781:             .Left = 55
782:             .Width = 246
783:             .Height = 15
784:             .FontName  = "Tahoma"
785:             .FontSize = 8
786:             .BackStyle = 0
787:             .ForeColor = RGB(90, 90, 90)
788:             .Visible = .T.
789:         ENDWITH
790: 
791:         *-- OptionGroup: Opt_Fil / opt_4c_Fil (top=179+29=208)
792:         loc_oPg2P1.AddObject("opt_4c_Fil", "OptionGroup")
793:         loc_oPg2P1.opt_4c_Fil.ButtonCount = 3
794:         loc_oPg2P1.opt_4c_Fil.Top         = 208
795:         loc_oPg2P1.opt_4c_Fil.Left        = 303
796:         loc_oPg2P1.opt_4c_Fil.Width       = 192
797:         loc_oPg2P1.opt_4c_Fil.Height      = 24
798:         WITH loc_oPg2P1.opt_4c_Fil
799:             .BackStyle   = 0
800:             .BorderStyle = 0
801:             .Visible = .T.
802:             WITH .Buttons(1)
803:                 .Caption   = "Somente"
804:                 .BackStyle = 0
805:                 .AutoSize = .T.
806:                 .Top = 5
807:                 .Left = 5
808:                 .Height = 15
809:                 .Width = 60
810:                 .ForeColor = RGB(90, 90, 90)
811:             ENDWITH
812:             WITH .Buttons(2)
813:                 .Caption   = "N" + CHR(227) + "o"
814:                 .FontName  = "Tahoma"
815:                 .FontSize = 8
816:                 .BackStyle = 0
817:                 .AutoSize = .T.
818:                 .Top = 5
819:                 .Left = 84
820:                 .Height = 15
821:                 .Width = 37
822:                 .ForeColor = RGB(90, 90, 90)
823:             ENDWITH
824:             WITH .Buttons(3)
825:                 .Caption   = "Ambos"
826:                 .FontName  = "Tahoma"
827:                 .FontSize = 8
828:                 .BackStyle = 0
829:                 .AutoSize = .T.
830:                 .Top = 5
831:                 .Left = 132
832:                 .Height = 15

*-- Linhas 904 a 1473:
904:             .MousePointer = 15
905:             .Visible = .T.
906:         ENDWITH
907:         BINDEVENT(loc_oPg2P1.cmd_4c_BotConsulta, "Click", THIS, "CmdBotConsultaClick")
908: 
909:         *-- Button: btnCadastros / cmd_4c_BtnCadastros (top=70+29=99, left=708)
910:         loc_oPg2P1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
911:         WITH loc_oPg2P1.cmd_4c_BtnCadastros
912:             .Caption     = ""
913:             .Picture     = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
914:             .Top = 99
915:             .Left = 708
916:             .Width = 40
917:             .Height = 40
918:             .BackColor = RGB(255,255,255)
919:             .ForeColor = RGB(90,90,90)
920:             .SpecialEffect = 0
921:             .Themes = .F.
922:             .ToolTipText = "<F3> Acessa o Cadastro Desta Conta"
923:             .MousePointer = 15
924:             .Visible = .T.
925:         ENDWITH
926:         BINDEVENT(loc_oPg2P1.cmd_4c_BtnCadastros, "Click", THIS, "CmdBtnCadastrosClick")
927: 
928:         *-- CommandGroup: cmdOperacao / cmd_4c_CmdOperacao (top=334+29=363)
929:         loc_oPg2P1.AddObject("cmd_4c_CmdOperacao", "CommandGroup")
930:         loc_oPg2P1.cmd_4c_CmdOperacao.ButtonCount = 1
931:         loc_oPg2P1.cmd_4c_CmdOperacao.Top         = 363
932:         loc_oPg2P1.cmd_4c_CmdOperacao.Left        = 857
933:         loc_oPg2P1.cmd_4c_CmdOperacao.Width       = 85
934:         loc_oPg2P1.cmd_4c_CmdOperacao.Height      = 85
935:         WITH loc_oPg2P1.cmd_4c_CmdOperacao
936:             .BackStyle   = 0
937:             .BorderStyle = 0
938:             .Themes = .F.
939:             .Visible = .T.
940:             WITH .Buttons(1)
941:                 .Top = 5
942:                 .Left = 5
943:                 .Height = 75
944:                 .Width = 75
945:                 .FontBold = .T.
946:                 .FontItalic = .T.
947:                 .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
948:                 .Caption         = "Movimento"
949:                 .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
950:                 .PicturePosition = 13
951:                 .ForeColor = RGB(90, 90, 90)
952:                 .BackColor = RGB(255, 255, 255)
953:                 .Themes = .F.
954:             ENDWITH
955:         ENDWITH
956:         BINDEVENT(loc_oPg2P1.cmd_4c_CmdOperacao, "Click", THIS, "CmdOperacaoClick")
957: 
958:         *-- Button: processar / cmd_4c_Processar (top=7+29=36, left=962)
959:         loc_oPg2P1.AddObject("cmd_4c_Processar", "CommandButton")
960:         WITH loc_oPg2P1.cmd_4c_Processar
961:             .Caption         = "Processar"
962:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
963:             .PicturePosition = 13
964:             .Top = 36
965:             .Left = 962
966:             .Width = 75
967:             .Height = 75
968:             .BackColor = RGB(255,255,255)
969:             .ForeColor = RGB(90,90,90)
970:             .FontName = "Comic Sans MS"
971:             .FontSize = 8
972:             .FontBold = .T.
973:             .FontItalic = .T.
974:             .Themes = .F.
975:             .SpecialEffect = 0
976:             .MousePointer = 15
977:             .WordWrap = .T.
978:             .AutoSize = .F.
979:             .Visible = .T.
980:         ENDWITH
981:         BINDEVENT(loc_oPg2P1.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
982:     ENDPROC
983: 
984:     *--------------------------------------------------------------------------
985:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
986:     *--------------------------------------------------------------------------
987:     PROCEDURE AlternarPagina(par_nPagina)
988:         LOCAL loc_lResultado
989:         loc_lResultado = .F.
990: 
991:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
992:             RETURN .F.
993:         ENDIF
994: 
995:         TRY
996:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
997: 
998:             IF par_nPagina = 1
999:                 THIS.this_cModoAtual = "LISTA"
1000:                 THIS.CarregarLista()
1001:             ENDIF
1002: 
1003:             loc_lResultado = .T.
1004:         CATCH TO loc_oErro
1005:             MsgErro("Erro em FormSigPrCtr.AlternarPagina: " + loc_oErro.Message, "Erro")
1006:         ENDTRY
1007: 
1008:         RETURN loc_lResultado
1009:     ENDPROC
1010: 
1011:     *--------------------------------------------------------------------------
1012:     * DtInicialLostFocus - Ajusta DtFinal se necessario e recarrega lista
1013:     *--------------------------------------------------------------------------
1014:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1015:         LOCAL loc_oPg1
1016:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1017: 
1018:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1019:             IF loc_oPg1.txt_4c_DtInicial.Value > loc_oPg1.txt_4c_DtFinal.Value
1020:                 loc_oPg1.txt_4c_DtFinal.Value = loc_oPg1.txt_4c_DtInicial.Value
1021:             ENDIF
1022:         ENDIF
1023: 
1024:         THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1025:         THIS.CarregarLista()
1026:     ENDPROC
1027: 
1028:     *--------------------------------------------------------------------------
1029:     * DtFinalLostFocus - Ajusta DtInicial se necessario e recarrega lista
1030:     *--------------------------------------------------------------------------
1031:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1032:         LOCAL loc_oPg1
1033:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1034: 
1035:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1036:             IF loc_oPg1.txt_4c_DtFinal.Value < loc_oPg1.txt_4c_DtInicial.Value
1037:                 loc_oPg1.txt_4c_DtInicial.Value = loc_oPg1.txt_4c_DtFinal.Value
1038:             ENDIF
1039:         ENDIF
1040: 
1041:         THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1042:         THIS.CarregarLista()
1043:     ENDPROC
1044: 
1045:     *--------------------------------------------------------------------------
1046:     * BtnIncluirClick - Prepara form para incluir novo lote
1047:     *--------------------------------------------------------------------------
1048:     PROCEDURE BtnIncluirClick()
1049:         THIS.this_oBusinessObject.NovoRegistro()
1050:         THIS.LimparCampos()
1051:         THIS.this_cModoAtual = "INCLUIR"
1052:         THIS.HabilitarCampos(.T.)
1053:         THIS.AjustarBotoesPorModo()
1054:         THIS.AlternarPagina(2)
1055:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1056:     ENDPROC
1057: 
1058:     *--------------------------------------------------------------------------
1059:     * BtnVisualizarClick - Carrega lote selecionado em modo leitura
1060:     *--------------------------------------------------------------------------
1061:     PROCEDURE BtnVisualizarClick()
1062:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1063:            RECCOUNT("cursor_4c_Dados") = 0
1064:             MsgAviso("Selecione um lote na lista.", "Aviso")
1065:             RETURN
1066:         ENDIF
1067: 
1068:         LOCAL loc_cCodigos
1069:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1070: 
1071:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1072:             THIS.BOParaForm()
1073:             THIS.this_cModoAtual = "VISUALIZAR"
1074:             THIS.HabilitarCampos(.F.)
1075:             THIS.AjustarBotoesPorModo()
1076:             THIS.AlternarPagina(2)
1077:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1078:         ENDIF
1079:     ENDPROC
1080: 
1081:     *--------------------------------------------------------------------------
1082:     * BtnAlterarClick - Carrega lote selecionado para edicao
1083:     *--------------------------------------------------------------------------
1084:     PROCEDURE BtnAlterarClick()
1085:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1086:            RECCOUNT("cursor_4c_Dados") = 0
1087:             MsgAviso("Selecione um lote na lista.", "Aviso")
1088:             RETURN
1089:         ENDIF
1090: 
1091:         LOCAL loc_cCodigos
1092:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1093: 
1094:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1095:             THIS.this_oBusinessObject.EditarRegistro()
1096:             THIS.BOParaForm()
1097:             THIS.this_cModoAtual = "ALTERAR"
1098:             THIS.HabilitarCampos(.T.)
1099:             THIS.AjustarBotoesPorModo()
1100:             THIS.AlternarPagina(2)
1101:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1102:         ENDIF
1103:     ENDPROC
1104: 
1105:     *--------------------------------------------------------------------------
1106:     * BtnExcluirClick - Exclui lote selecionado apos confirmacao
1107:     *--------------------------------------------------------------------------
1108:     PROCEDURE BtnExcluirClick()
1109:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
1110:            RECCOUNT("cursor_4c_Dados") = 0
1111:             MsgAviso("Selecione um lote na lista.", "Aviso")
1112:             RETURN
1113:         ENDIF
1114: 
1115:         LOCAL loc_cCodigos
1116:         loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1117: 
1118:         IF !MsgConfirma("Confirma exclus" + CHR(227) + "o do lote " + ;
1119:                         ALLTRIM(loc_cCodigos) + "?", ;
1120:                         "Confirmar Exclus" + CHR(227) + "o")
1121:             RETURN
1122:         ENDIF
1123: 
1124:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
1125:             IF THIS.this_oBusinessObject.Excluir()
1126:                 MsgInfo("Lote exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1127:                 THIS.CarregarLista()
1128:             ENDIF
1129:         ENDIF
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------
1133:     * BtnBuscarClick - Recarrega lista com filtros de data atuais
1134:     *--------------------------------------------------------------------------
1135:     PROCEDURE BtnBuscarClick()
1136:         LOCAL loc_oPg1
1137:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1138: 
1139:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1140:             THIS.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1141:         ENDIF
1142: 
1143:         IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1144:             THIS.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1145:         ENDIF
1146: 
1147:         THIS.CarregarLista()
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * BtnSalvarClick - Grava o lote: monta cursor_4c_Linhas a partir do JOIN
1152:     * de cursor_4c_Movimentos x cursor_4c_Distribui, entao chama Salvar()
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnSalvarClick()
1155:         LOCAL loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc
1156:         LOCAL loc_oPg2P1, loc_nQtdOs, loc_lSalvoOK, loc_oErro
1157:         loc_cConta   = ""
1158:         loc_cArquivo = ""
1159:         loc_cMoeda   = ""
1160:         loc_nOpc     = 0
1161:         loc_lSalvoOK = .F.
1162:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1163: 
1164:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1165:             loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1166:         ENDIF
1167:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1168:             loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
1169:         ENDIF
1170:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1171:             loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1172:         ENDIF
1173:         IF PEMSTATUS(loc_oPg2P1, "obj_4c_Opt_Custo", 5)
1174:             loc_nOpc = loc_oPg2P1.obj_4c_Opt_Custo.Value
1175:         ENDIF
1176: 
1177:         IF EMPTY(loc_cConta)
1178:             MsgAviso("Informe o fornecedor antes de salvar.", ;
1179:                      "Campo Obrigat" + CHR(243) + "rio")
1180:             RETURN
1181:         ENDIF
1182: 
1183:         IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
1184:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " movimentos para gravar.", "Aviso")
1185:             RETURN
1186:         ENDIF
1187: 
1188:         IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
1189:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " distribui" + CHR(231) + CHR(227) + ;
1190:                      "o para gravar.", "Aviso")
1191:             RETURN
1192:         ENDIF
1193: 
1194:         TRY
1195:             *-- Monta cursor_4c_Linhas: JOIN movimentos x distribui onde qtd > 0 e saldo > 0
1196:             IF USED("cursor_4c_TmpJoin")
1197:                 USE IN cursor_4c_TmpJoin
1198:             ENDIF
1199: 
1200:             SELECT a.Cpros, a.Qtds, a.OriDopNums, a.CidChaves, b.Qtds AS QtdXml ;
1201:                 FROM cursor_4c_Movimentos a ;
1202:                 JOIN cursor_4c_Distribui b ON ALLTRIM(a.Cpros) = ALLTRIM(b.Cpros) ;
1203:                 INTO CURSOR cursor_4c_TmpJoin READWRITE
1204: 
1205:             IF USED("cursor_4c_Linhas")
1206:                 ZAP IN cursor_4c_Linhas
1207:             ELSE
1208:                 CREATE CURSOR cursor_4c_Linhas ;
1209:                     (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
1210:                      OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
1211:                      Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
1212:                      Precific N(12,2), FkChaves C(20))
1213:             ENDIF
1214: 
1215:             IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
1216:                 SELECT cursor_4c_TmpJoin
1217:                 GO TOP
1218:                 SCAN
1219:                     loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
1220:                                      cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
1221:                     INSERT INTO cursor_4c_Linhas ;
1222:                         (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
1223:                          Contas, Arquivo, Moedas, Precific, FkChaves) ;
1224:                         VALUES ;
1225:                         (cursor_4c_TmpJoin.Cpros, "", "", cursor_4c_TmpJoin.OriDopNums, ;
1226:                          cursor_4c_TmpJoin.Qtds, loc_nQtdOs, ;
1227:                          loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc, ;
1228:                          cursor_4c_TmpJoin.CidChaves)
1229:                     SELECT cursor_4c_TmpJoin
1230:                 ENDSCAN
1231:             ENDIF
1232: 
1233:             IF USED("cursor_4c_TmpJoin")
1234:                 USE IN cursor_4c_TmpJoin
1235:             ENDIF
1236: 
1237:             IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
1238:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " linhas v" + CHR(225) + ;
1239:                          "lidas para gravar (verifique saldo e distribui" + CHR(231) + CHR(227) + "o).", ;
1240:                          "Aviso")
1241:             ELSE
1242:                 THIS.FormParaBO()
1243:                 IF THIS.this_oBusinessObject.Salvar()
1244:                     MsgInfo("Lote gravado com sucesso!", "Sucesso")
1245:                     loc_lSalvoOK = .T.
1246:                 ENDIF
1247:             ENDIF
1248:         CATCH TO loc_oErro
1249:             MsgErro("Erro em FormSigPrCtr.BtnSalvarClick:" + CHR(13) + ;
1250:                     loc_oErro.Message, "Erro")
1251:         ENDTRY
1252: 
1253:         IF loc_lSalvoOK
1254:             THIS.AlternarPagina(1)
1255:         ENDIF
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * BtnCancelarClick - Cancela edicao e volta para lista
1260:     *--------------------------------------------------------------------------
1261:     PROCEDURE BtnCancelarClick()
1262:         THIS.this_cModoAtual = "LISTA"
1263:         THIS.AjustarBotoesPorModo()
1264:         THIS.AlternarPagina(1)
1265:         THIS.CarregarLista()
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
1270:     *--------------------------------------------------------------------------
1271:     PROTECTED PROCEDURE FormParaBO()
1272:         LOCAL loc_oPg2P1
1273:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1274: 
1275:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1276:             THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1277:         ENDIF
1278:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1279:             THIS.this_oBusinessObject.this_cContas = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1280:         ENDIF
1281:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1282:             THIS.this_oBusinessObject.this_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1283:         ENDIF
1284:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1285:             THIS.this_oBusinessObject.this_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
1286:         ENDIF
1287:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1288:             THIS.this_oBusinessObject.this_cMoedas = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1289:         ENDIF
1290:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1291:             THIS.this_oBusinessObject.this_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
1292:         ENDIF
1293:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1294:             THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
1295:         ENDIF
1296:     ENDPROC
1297: 
1298:     *--------------------------------------------------------------------------
1299:     * BOParaForm - Transfere valores do BO para os campos da Page2
1300:     *--------------------------------------------------------------------------
1301:     PROTECTED PROCEDURE BOParaForm()
1302:         LOCAL loc_oPg2P1
1303:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1304: 
1305:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1306:             loc_oPg2P1.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
1307:         ENDIF
1308:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1309:             loc_oPg2P1.txt_4c_Conta.Value = THIS.this_oBusinessObject.this_cContas
1310:         ENDIF
1311:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1312:             loc_oPg2P1.txt_4c_Dconta.Value = THIS.this_oBusinessObject.this_cDconta
1313:         ENDIF
1314:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1315:             loc_oPg2P1.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
1316:         ENDIF
1317:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1318:             loc_oPg2P1.txt_4c_Moeda.Value = THIS.this_oBusinessObject.this_cMoedas
1319:         ENDIF
1320:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1321:             loc_oPg2P1.txt_4c_Cpf.Value = THIS.this_oBusinessObject.this_cCpf
1322:         ENDIF
1323:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1324:             loc_oPg2P1.opt_4c_Custo.Value = THIS.this_oBusinessObject.this_nPrecific
1325:         ENDIF
1326:     ENDPROC
1327: 
1328:     *--------------------------------------------------------------------------
1329:     * LimparCampos - Limpa valores dos campos editaveis da Page2
1330:     *--------------------------------------------------------------------------
1331:     PROTECTED PROCEDURE LimparCampos()
1332:         LOCAL loc_oPg2P1
1333:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1334: 
1335:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1336:             loc_oPg2P1.txt_4c_Grupo.Value = ""
1337:         ENDIF
1338:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1339:             loc_oPg2P1.txt_4c_Conta.Value = ""
1340:         ENDIF
1341:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1342:             loc_oPg2P1.txt_4c_Dconta.Value = ""
1343:         ENDIF
1344:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1345:             loc_oPg2P1.txt_4c_Arquivo.Value = ""
1346:         ENDIF
1347:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1348:             loc_oPg2P1.txt_4c_Moeda.Value = ""
1349:         ENDIF
1350:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1351:             loc_oPg2P1.txt_4c_Cpf.Value = ""
1352:         ENDIF
1353:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1354:             loc_oPg2P1.opt_4c_Custo.Value = 1
1355:         ENDIF
1356:     ENDPROC
1357: 
1358:     *--------------------------------------------------------------------------
1359:     * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
1360:     *--------------------------------------------------------------------------
1361:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1362:         LOCAL loc_oPg2P1, loc_oCntAcao
1363:         loc_oPg2P1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1364:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1365: 
1366:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1367:             loc_oPg2P1.txt_4c_Grupo.Enabled = par_lHabilitar
1368:         ENDIF
1369:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1370:             loc_oPg2P1.txt_4c_Conta.Enabled = par_lHabilitar
1371:         ENDIF
1372:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1373:             loc_oPg2P1.txt_4c_Dconta.Enabled = par_lHabilitar
1374:         ENDIF
1375:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
1376:             loc_oPg2P1.txt_4c_Arquivo.Enabled = par_lHabilitar
1377:         ENDIF
1378:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1379:             loc_oPg2P1.txt_4c_Moeda.Enabled = par_lHabilitar
1380:         ENDIF
1381:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1382:             loc_oPg2P1.txt_4c_Cpf.Enabled = par_lHabilitar
1383:         ENDIF
1384:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Custo", 5)
1385:             loc_oPg2P1.opt_4c_Custo.Enabled = par_lHabilitar
1386:         ENDIF
1387:         IF PEMSTATUS(loc_oPg2P1, "cmd_4c_Processar", 5)
1388:             loc_oPg2P1.cmd_4c_Processar.Enabled = par_lHabilitar
1389:         ENDIF
1390:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1391:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1392:         ENDIF
1393:     ENDPROC
1394: 
1395:     *--------------------------------------------------------------------------
1396:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo atual
1397:     *--------------------------------------------------------------------------
1398:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1399:         LOCAL loc_oCnt, loc_lLista, loc_lEdita
1400:         loc_oCnt   = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1401:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
1402:         loc_lEdita = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1403: 
1404:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1405:             loc_oCnt.cmd_4c_Incluir.Enabled = loc_lLista
1406:         ENDIF
1407:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1408:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lLista
1409:         ENDIF
1410:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1411:             loc_oCnt.cmd_4c_Alterar.Enabled = loc_lLista
1412:         ENDIF
1413:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1414:             loc_oCnt.cmd_4c_Excluir.Enabled = loc_lLista
1415:         ENDIF
1416:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1417:             loc_oCnt.cmd_4c_Buscar.Enabled = loc_lLista
1418:         ENDIF
1419: 
1420:         LOCAL loc_oCntAcao
1421:         loc_oCntAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1422:         IF PEMSTATUS(loc_oCntAcao, "cmd_4c_Confirmar", 5)
1423:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = loc_lEdita
1424:         ENDIF
1425:     ENDPROC
1426: 
1427:     *--------------------------------------------------------------------------
1428:     * CarregarLista - Busca lotes do banco e popula grd_4c_Dados
1429:     * Propaga datas de this_dDataInicial/this_dDataFinal para o BO
1430:     * grd_4c_Dados e controles de filtro sao criados na Fase 4;
1431:     *   este metodo le os controles se existirem, graciosamente ignora se nao
1432:     *--------------------------------------------------------------------------
1433:     PROCEDURE CarregarLista()
1434:         LOCAL loc_lResultado, loc_oPg1, loc_oGrid
1435:         loc_lResultado = .F.
1436: 
1437:         TRY
1438:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1439:                 loc_lResultado = .T.
1440:             ELSE
1441:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1442: 
1443:                 *-- Propagar filtros de data a partir dos controles (Fase 4 cria os controles)
1444:                 IF PEMSTATUS(loc_oPg1, "txt_4c_DtInicial", 5)
1445:                     THIS.this_oBusinessObject.this_dDataInicial = loc_oPg1.txt_4c_DtInicial.Value
1446:                 ELSE
1447:                     THIS.this_oBusinessObject.this_dDataInicial = THIS.this_dDataInicial
1448:                 ENDIF
1449: 
1450:                 IF PEMSTATUS(loc_oPg1, "txt_4c_DtFinal", 5)
1451:                     THIS.this_oBusinessObject.this_dDataFinal = loc_oPg1.txt_4c_DtFinal.Value
1452:                 ELSE
1453:                     THIS.this_oBusinessObject.this_dDataFinal = THIS.this_dDataFinal
1454:                 ENDIF
1455: 
1456:                 IF THIS.this_oBusinessObject.Buscar("")
1457:                     *-- Popula grid quando existir (criado na Fase 4)
1458:                     IF PEMSTATUS(loc_oPg1, "grd_4c_Dados", 5)
1459:                         loc_oGrid = loc_oPg1.grd_4c_Dados
1460:                         loc_oGrid.ColumnCount = 3
1461:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1462: 
1463:                         WITH loc_oGrid
1464:                             .Column1.ControlSource = "cursor_4c_Dados.Codigos"
1465:                             .Column2.ControlSource = "cursor_4c_Dados.Datas"
1466:                             .Column3.ControlSource = "cursor_4c_Dados.Contas"
1467:                             .Column4.ControlSource = "cursor_4c_Dados.Rclis"
1468:                             .Column5.ControlSource = "cursor_4c_Dados.Usuars"
1469:                             .Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1470: 
1471:                             .Column1.Header1.Caption = "Lote"
1472:                             .Column2.Header1.Caption = "Data"
1473:                             .Column3.Header1.Caption = "Conta"

*-- Linhas 1492 a 1882:
1492:     *--------------------------------------------------------------------------
1493:     * BtnEncerrarClick - Fecha o formulario
1494:     *--------------------------------------------------------------------------
1495:     PROCEDURE BtnEncerrarClick()
1496:         THIS.Release()
1497:     ENDPROC
1498: 
1499:     *--------------------------------------------------------------------------
1500:     * FormatarGridLista - Formata visual da grade de lotes (Page1)
1501:     *--------------------------------------------------------------------------
1502:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1503:         WITH par_oGrid
1504:             .FontName = "Tahoma"
1505:             .FontSize = 8
1506:         ENDWITH
1507:     ENDPROC
1508: 
1509:     *--------------------------------------------------------------------------
1510:     * TornarControlesVisiveis - Percorre recursivamente e seta Visible=.T.
1511:     * Inclui tratamento especial para PageFrames aninhados
1512:     *--------------------------------------------------------------------------
1513:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1514:         LOCAL loc_nI, loc_oObjeto, loc_nP
1515: 
1516:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1517:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1518: 
1519:             IF VARTYPE(loc_oObjeto) = "O"
1520:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1521:                     loc_oObjeto.Visible = .T.
1522:                 ENDIF
1523: 
1524:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1525:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1526:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1527:                     ENDFOR
1528:                 ENDIF
1529: 
1530:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1531:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1532:                 ENDIF
1533:             ENDIF
1534:         ENDFOR
1535:     ENDPROC
1536: 
1537:     *--------------------------------------------------------------------------
1538:     * TxtGrupoKeyPress - F4 abre lookup de Grupo
1539:     *--------------------------------------------------------------------------
1540:     PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1541:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1542:             THIS.AbrirLookupGrupo()
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     *--------------------------------------------------------------------------
1547:     * TxtGrupoDblClick - DblClick abre lookup de Grupo
1548:     *--------------------------------------------------------------------------
1549:     PROCEDURE TxtGrupoDblClick()
1550:         THIS.AbrirLookupGrupo()
1551:     ENDPROC
1552: 
1553:     *--------------------------------------------------------------------------
1554:     * AbrirLookupGrupo - Picker SigCdGrp (cgrus/dgrus)
1555:     *--------------------------------------------------------------------------
1556:     PROCEDURE AbrirLookupGrupo()
1557:         LOCAL loc_oPg2P1, loc_cGrupo, loc_oBusca, loc_oErro
1558:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1559:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1560:             RETURN
1561:         ENDIF
1562:         loc_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1563:         TRY
1564:             IF USED("cursor_4c_BuscaGrp")
1565:                 USE IN cursor_4c_BuscaGrp
1566:             ENDIF
1567:             =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1568:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1569:                 "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
1570:             IF VARTYPE(loc_oBusca) = "O"
1571:                 IF !loc_oBusca.this_lSelecionou
1572:                     IF USED("cursor_4c_BuscaGrp")
1573:                         USE IN cursor_4c_BuscaGrp
1574:                     ENDIF
1575:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1576:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1577:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1578:                     loc_oBusca.Show()
1579:                 ENDIF
1580:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1581:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1582:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1583:                 ENDIF
1584:                 IF USED("cursor_4c_BuscaGrp")
1585:                     USE IN cursor_4c_BuscaGrp
1586:                 ENDIF
1587:                 loc_oBusca.Release()
1588:             ENDIF
1589:         CATCH TO loc_oErro
1590:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")
1591:         ENDTRY
1592:     ENDPROC
1593: 
1594:     *--------------------------------------------------------------------------
1595:     * TxtContaKeyPress - F4 abre lookup de Conta (Fornecedor por codigo)
1596:     *--------------------------------------------------------------------------
1597:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1598:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1599:             THIS.AbrirLookupConta()
1600:         ENDIF
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * TxtContaDblClick - DblClick abre lookup de Conta (Fornecedor)
1605:     *--------------------------------------------------------------------------
1606:     PROCEDURE TxtContaDblClick()
1607:         THIS.AbrirLookupConta()
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * AbrirLookupConta - Picker SigCdCli por Iclis; preenche Conta/Dconta/Cpf
1612:     *--------------------------------------------------------------------------
1613:     PROCEDURE AbrirLookupConta()
1614:         LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_oErro
1615:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1616:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1617:             RETURN
1618:         ENDIF
1619:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1620:         TRY
1621:             IF USED("cursor_4c_BuscaCli")
1622:                 USE IN cursor_4c_BuscaCli
1623:             ENDIF
1624:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1625:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1626:                 "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1627:             IF VARTYPE(loc_oBusca) = "O"
1628:                 IF !loc_oBusca.this_lSelecionou
1629:                     IF USED("cursor_4c_BuscaCli")
1630:                         USE IN cursor_4c_BuscaCli
1631:                     ENDIF
1632:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1633:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1634:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1635:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1636:                     loc_oBusca.Show()
1637:                 ENDIF
1638:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1639:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1640:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1641:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1642:                     ENDIF
1643:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1644:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1645:                     ENDIF
1646:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1647:                 ENDIF
1648:                 IF USED("cursor_4c_BuscaCli")
1649:                     USE IN cursor_4c_BuscaCli
1650:                 ENDIF
1651:                 loc_oBusca.Release()
1652:             ENDIF
1653:         CATCH TO loc_oErro
1654:             MsgErro("Erro em FormSigPrCtr.AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "Erro")
1655:         ENDTRY
1656:     ENDPROC
1657: 
1658:     *--------------------------------------------------------------------------
1659:     * TxtDcontaKeyPress - F4 abre lookup de Dconta (nome Fornecedor)
1660:     *--------------------------------------------------------------------------
1661:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1662:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1663:             THIS.AbrirLookupDconta()
1664:         ENDIF
1665:     ENDPROC
1666: 
1667:     *--------------------------------------------------------------------------
1668:     * TxtDcontaDblClick - DblClick abre lookup de Dconta
1669:     *--------------------------------------------------------------------------
1670:     PROCEDURE TxtDcontaDblClick()
1671:         THIS.AbrirLookupDconta()
1672:     ENDPROC
1673: 
1674:     *--------------------------------------------------------------------------
1675:     * AbrirLookupDconta - Picker SigCdCli por Rclis; preenche Conta/Dconta/Cpf
1676:     *--------------------------------------------------------------------------
1677:     PROCEDURE AbrirLookupDconta()
1678:         LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_oErro
1679:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1680:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1681:             RETURN
1682:         ENDIF
1683:         loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1684:         TRY
1685:             IF USED("cursor_4c_BuscaCli")
1686:                 USE IN cursor_4c_BuscaCli
1687:             ENDIF
1688:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1689:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1690:                 "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1691:             IF VARTYPE(loc_oBusca) = "O"
1692:                 IF !loc_oBusca.this_lSelecionou
1693:                     IF USED("cursor_4c_BuscaCli")
1694:                         USE IN cursor_4c_BuscaCli
1695:                     ENDIF
1696:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1697:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1698:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1699:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1700:                     loc_oBusca.Show()
1701:                 ENDIF
1702:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1703:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1704:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1705:                     ENDIF
1706:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1707:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1708:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1709:                     ENDIF
1710:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1711:                 ENDIF
1712:                 IF USED("cursor_4c_BuscaCli")
1713:                     USE IN cursor_4c_BuscaCli
1714:                 ENDIF
1715:                 loc_oBusca.Release()
1716:             ENDIF
1717:         CATCH TO loc_oErro
1718:             MsgErro("Erro em FormSigPrCtr.AbrirLookupDconta:" + CHR(13) + loc_oErro.Message, "Erro")
1719:         ENDTRY
1720:     ENDPROC
1721: 
1722:     *--------------------------------------------------------------------------
1723:     * TxtMoedaKeyPress - F4 abre lookup de Moeda
1724:     *--------------------------------------------------------------------------
1725:     PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1726:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1727:             THIS.AbrirLookupMoeda()
1728:         ENDIF
1729:     ENDPROC
1730: 
1731:     *--------------------------------------------------------------------------
1732:     * TxtMoedaDblClick - DblClick abre lookup de Moeda
1733:     *--------------------------------------------------------------------------
1734:     PROCEDURE TxtMoedaDblClick()
1735:         THIS.AbrirLookupMoeda()
1736:     ENDPROC
1737: 
1738:     *--------------------------------------------------------------------------
1739:     * AbrirLookupMoeda - Picker SigCdMoe (CMoes/DMoes)
1740:     *--------------------------------------------------------------------------
1741:     PROCEDURE AbrirLookupMoeda()
1742:         LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_oErro
1743:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1744:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1745:             RETURN
1746:         ENDIF
1747:         loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
1748:         TRY
1749:             IF USED("cursor_4c_BuscaMoe")
1750:                 USE IN cursor_4c_BuscaMoe
1751:             ENDIF
1752:             =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1753:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1754:                 "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
1755:             IF VARTYPE(loc_oBusca) = "O"
1756:                 IF !loc_oBusca.this_lSelecionou
1757:                     IF USED("cursor_4c_BuscaMoe")
1758:                         USE IN cursor_4c_BuscaMoe
1759:                     ENDIF
1760:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1761:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1762:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1763:                     loc_oBusca.Show()
1764:                 ENDIF
1765:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1766:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1767:                 ENDIF
1768:                 IF USED("cursor_4c_BuscaMoe")
1769:                     USE IN cursor_4c_BuscaMoe
1770:                 ENDIF
1771:                 loc_oBusca.Release()
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1775:         ENDTRY
1776:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
1777:             loc_oPg2P1.txt_4c_Moeda.Refresh
1778:         ENDIF
1779:     ENDPROC
1780: 
1781:     *--------------------------------------------------------------------------
1782:     * TxtGrupoLostFocus - Persiste valor do Grupo no BO
1783:     *--------------------------------------------------------------------------
1784:     PROCEDURE TxtGrupoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1785:         LOCAL loc_oPg2P1
1786:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1787:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Grupo", 5)
1788:             THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(loc_oPg2P1.txt_4c_Grupo.Value)
1789:         ENDIF
1790:     ENDPROC
1791: 
1792:     *--------------------------------------------------------------------------
1793:     * TxtContaLostFocus - Lookup SigCdCli por Iclis; preenche Dconta, Cpf e grade
1794:     *--------------------------------------------------------------------------
1795:     PROCEDURE TxtContaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1796:         LOCAL loc_oPg2P1, loc_cConta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
1797:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1798: 
1799:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1800:             RETURN
1801:         ENDIF
1802: 
1803:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1804: 
1805:         IF EMPTY(loc_cConta)
1806:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1807:                 loc_oPg2P1.txt_4c_Dconta.Value = ""
1808:             ENDIF
1809:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1810:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
1811:             ENDIF
1812:             RETURN
1813:         ENDIF
1814: 
1815:         TRY
1816:             IF USED("cursor_4c_BuscaCli")
1817:                 USE IN cursor_4c_BuscaCli
1818:             ENDIF
1819:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1820:                        " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
1821:                        " ORDER BY Iclis"
1822:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1823: 
1824:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1825:                RECCOUNT("cursor_4c_BuscaCli") > 0
1826:                 loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1827:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1828:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1829:                 ENDIF
1830:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1831:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1832:                 ENDIF
1833:                 IF USED("cursor_4c_BuscaCli")
1834:                     USE IN cursor_4c_BuscaCli
1835:                 ENDIF
1836:                 THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
1837:             ELSE
1838:                 IF USED("cursor_4c_BuscaCli")
1839:                     USE IN cursor_4c_BuscaCli
1840:                 ENDIF
1841:                 *-- Nao encontrado exato: abre picker
1842:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1843:                     "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1844:                 IF VARTYPE(loc_oBusca) = "O"
1845:                     IF !loc_oBusca.this_lSelecionou
1846:                         IF USED("cursor_4c_BuscaCli")
1847:                             USE IN cursor_4c_BuscaCli
1848:                         ENDIF
1849:                         loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1850:                                    " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
1851:                                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
1852:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
1853:                            !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1854:                             IF USED("cursor_4c_BuscaCli")
1855:                                 USE IN cursor_4c_BuscaCli
1856:                             ENDIF
1857:                             =SQLEXEC(gnConnHandle, ;
1858:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1859:                                 "cursor_4c_BuscaCli")
1860:                         ENDIF
1861:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1862:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1863:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1864:                         loc_oBusca.Show()
1865:                     ENDIF
1866:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1867:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1868:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1869:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1870:                         ENDIF
1871:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1872:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1873:                         ENDIF
1874:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1875:                     ELSE
1876:                         loc_oPg2P1.txt_4c_Conta.Value = ""
1877:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1878:                             loc_oPg2P1.txt_4c_Dconta.Value = ""
1879:                         ENDIF
1880:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1881:                             loc_oPg2P1.txt_4c_Cpf.Value = ""
1882:                         ENDIF

*-- Linhas 1902 a 1945:
1902:     *--------------------------------------------------------------------------
1903:     * TxtDcontaLostFocus - Lookup SigCdCli por Rclis; preenche Conta e Cpf
1904:     *--------------------------------------------------------------------------
1905:     PROCEDURE TxtDcontaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1906:         LOCAL loc_oPg2P1, loc_cDconta, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
1907:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1908: 
1909:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1910:             RETURN
1911:         ENDIF
1912: 
1913:         loc_cDconta = ALLTRIM(loc_oPg2P1.txt_4c_Dconta.Value)
1914: 
1915:         IF EMPTY(loc_cDconta)
1916:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1917:                 loc_oPg2P1.txt_4c_Conta.Value = ""
1918:             ENDIF
1919:             IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1920:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
1921:             ENDIF
1922:             RETURN
1923:         ENDIF
1924: 
1925:         TRY
1926:             IF USED("cursor_4c_BuscaCli")
1927:                 USE IN cursor_4c_BuscaCli
1928:             ENDIF
1929:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1930:                        " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
1931:                        " ORDER BY Rclis"
1932:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1933: 
1934:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1935:                RECCOUNT("cursor_4c_BuscaCli") = 1
1936:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1937:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1938:                 ENDIF
1939:                 loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1940:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1941:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1942:                 ENDIF
1943:                 IF USED("cursor_4c_BuscaCli")
1944:                     USE IN cursor_4c_BuscaCli
1945:                 ENDIF

*-- Linhas 1956 a 1999:
1956:                         "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
1957:                         "cursor_4c_BuscaCli")
1958:                 ENDIF
1959:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1960:                     "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1961:                 IF VARTYPE(loc_oBusca) = "O"
1962:                     IF !loc_oBusca.this_lSelecionou
1963:                         IF USED("cursor_4c_BuscaCli")
1964:                             USE IN cursor_4c_BuscaCli
1965:                         ENDIF
1966:                         =SQLEXEC(gnConnHandle, ;
1967:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
1968:                             "cursor_4c_BuscaCli")
1969:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1970:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1971:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1972:                         loc_oBusca.Show()
1973:                     ENDIF
1974:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1975:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1976:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1977:                         ENDIF
1978:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1979:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1980:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1981:                         ENDIF
1982:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1983:                     ELSE
1984:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1985:                             loc_oPg2P1.txt_4c_Conta.Value = ""
1986:                         ENDIF
1987:                         loc_oPg2P1.txt_4c_Dconta.Value = ""
1988:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1989:                             loc_oPg2P1.txt_4c_Cpf.Value = ""
1990:                         ENDIF
1991:                     ENDIF
1992:                     IF USED("cursor_4c_BuscaCli")
1993:                         USE IN cursor_4c_BuscaCli
1994:                     ENDIF
1995:                     loc_oBusca.Release()
1996:                 ENDIF
1997:             ENDIF
1998:         CATCH TO loc_oErro
1999:             MsgErro("Erro em FormSigPrCtr.TxtDcontaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 2010 a 2609:
2010:     *--------------------------------------------------------------------------
2011:     * TxtCpfLostFocus - Lookup SigCdCli por Cpfs (CNPJ/CPF); preenche Conta e Dconta
2012:     *--------------------------------------------------------------------------
2013:     PROCEDURE TxtCpfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2014:         LOCAL loc_oPg2P1, loc_cCpf, loc_cCpfLimpo, loc_cSQL, loc_nResult, loc_oErro
2015:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2016: 
2017:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2018:             RETURN
2019:         ENDIF
2020: 
2021:         loc_cCpf = ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value)
2022:         IF EMPTY(loc_cCpf)
2023:             RETURN
2024:         ENDIF
2025: 
2026:         loc_cCpfLimpo = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
2027: 
2028:         TRY
2029:             IF USED("cursor_4c_BuscaCli")
2030:                 USE IN cursor_4c_BuscaCli
2031:             ENDIF
2032:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
2033:                        " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
2034:                        " ORDER BY Iclis"
2035:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2036: 
2037:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2038:                RECCOUNT("cursor_4c_BuscaCli") > 0
2039:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2040:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2041:                 ENDIF
2042:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
2043:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2044:                 ENDIF
2045:                 loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2046:                 IF USED("cursor_4c_BuscaCli")
2047:                     USE IN cursor_4c_BuscaCli
2048:                 ENDIF
2049:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2050:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
2051:                 ENDIF
2052:             ELSE
2053:                 IF USED("cursor_4c_BuscaCli")
2054:                     USE IN cursor_4c_BuscaCli
2055:                 ENDIF
2056:                 MsgAviso("CPF/CNPJ n" + CHR(227) + "o encontrado no cadastro.", "Aviso")
2057:                 loc_oPg2P1.txt_4c_Cpf.Value = ""
2058:             ENDIF
2059:         CATCH TO loc_oErro
2060:             MsgErro("Erro em FormSigPrCtr.TxtCpfLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2061:         ENDTRY
2062:     ENDPROC
2063: 
2064:     *--------------------------------------------------------------------------
2065:     * TxtMoedaLostFocus - Lookup SigCdMoe por CMoes; preenche ou limpa campo
2066:     *--------------------------------------------------------------------------
2067:     PROCEDURE TxtMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2068:         LOCAL loc_oPg2P1, loc_cMoeda, loc_oBusca, loc_cSQL, loc_nResult, loc_oErro
2069:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2070: 
2071:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
2072:             RETURN
2073:         ENDIF
2074: 
2075:         loc_cMoeda = ALLTRIM(loc_oPg2P1.txt_4c_Moeda.Value)
2076: 
2077:         IF EMPTY(loc_cMoeda)
2078:             loc_oPg2P1.txt_4c_Moeda.Value = ""
2079:             RETURN
2080:         ENDIF
2081: 
2082:         TRY
2083:             IF USED("cursor_4c_BuscaMoe")
2084:                 USE IN cursor_4c_BuscaMoe
2085:             ENDIF
2086:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2087:                        " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
2088:                        " ORDER BY CMoes"
2089:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
2090: 
2091:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
2092:                RECCOUNT("cursor_4c_BuscaMoe") > 0
2093:                 loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2094:                 IF USED("cursor_4c_BuscaMoe")
2095:                     USE IN cursor_4c_BuscaMoe
2096:                 ENDIF
2097:             ELSE
2098:                 IF USED("cursor_4c_BuscaMoe")
2099:                     USE IN cursor_4c_BuscaMoe
2100:                 ENDIF
2101:                 loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2102:                            " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
2103:                            EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
2104:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
2105:                    !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
2106:                     IF USED("cursor_4c_BuscaMoe")
2107:                         USE IN cursor_4c_BuscaMoe
2108:                     ENDIF
2109:                     =SQLEXEC(gnConnHandle, ;
2110:                         "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2111:                         "cursor_4c_BuscaMoe")
2112:                 ENDIF
2113:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2114:                     "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
2115:                 IF VARTYPE(loc_oBusca) = "O"
2116:                     IF !loc_oBusca.this_lSelecionou
2117:                         IF USED("cursor_4c_BuscaMoe")
2118:                             USE IN cursor_4c_BuscaMoe
2119:                         ENDIF
2120:                         =SQLEXEC(gnConnHandle, ;
2121:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2122:                             "cursor_4c_BuscaMoe")
2123:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2124:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2125:                         loc_oBusca.Show()
2126:                     ENDIF
2127:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2128:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2129:                     ELSE
2130:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2131:                     ENDIF
2132:                     IF USED("cursor_4c_BuscaMoe")
2133:                         USE IN cursor_4c_BuscaMoe
2134:                     ENDIF
2135:                     loc_oBusca.Release()
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loc_oErro
2139:             MsgErro("Erro em FormSigPrCtr.TxtMoedaLostFocus:" + CHR(13) + loc_oErro.Message, "Erro")
2140:         ENDTRY
2141: 
2142:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Moeda", 5)
2143:             loc_oPg2P1.txt_4c_Moeda.Refresh
2144:         ENDIF
2145:     ENDPROC
2146: 
2147:     *--------------------------------------------------------------------------
2148:     * CmdCommand12Click - Abre dialogo de selecao de arquivo XML
2149:     *--------------------------------------------------------------------------
2150:     PROCEDURE CmdCommand12Click()
2151:         LOCAL loc_oPg2P1, loc_cArquivo
2152:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2153:         loc_cArquivo = GETFILE("XML", "Selecionar arquivo XML", "Selecionar")
2154: 
2155:         IF !EMPTY(loc_cArquivo) AND PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
2156:             loc_oPg2P1.txt_4c_Arquivo.Value = loc_cArquivo
2157:         ENDIF
2158:     ENDPROC
2159: 
2160:     *--------------------------------------------------------------------------
2161:     * CmdBotConsultaClick - Abre consulta generica de vendas para a conta
2162:     *--------------------------------------------------------------------------
2163:     PROCEDURE CmdBotConsultaClick()
2164:         LOCAL loc_oPg2P1, loc_cConta, loc_oErro
2165:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2166: 
2167:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2168:             RETURN
2169:         ENDIF
2170: 
2171:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
2172: 
2173:         IF EMPTY(loc_cConta)
2174:             MsgAviso("Informe a conta antes de acessar a consulta.", "Aviso")
2175:             RETURN
2176:         ENDIF
2177: 
2178:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2179:             TRY
2180:                 DO FORM FormSigOpCgv WITH THIS, loc_cConta
2181:             CATCH TO loc_oErro
2182:                 MsgErro("Erro ao abrir consulta gen" + CHR(233) + "rica: " + ;
2183:                         loc_oErro.Message, "Erro")
2184:             ENDTRY
2185:         ENDIF
2186:     ENDPROC
2187: 
2188:     *--------------------------------------------------------------------------
2189:     * CmdBtnCadastrosClick - Abre cadastro do fornecedor
2190:     *--------------------------------------------------------------------------
2191:     PROCEDURE CmdBtnCadastrosClick()
2192:         LOCAL loc_oPg2P1, loc_cConta, loc_oErro
2193:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2194: 
2195:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2196:             RETURN
2197:         ENDIF
2198: 
2199:         loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
2200: 
2201:         IF EMPTY(loc_cConta)
2202:             MsgAviso("Informe a conta antes de acessar o cadastro.", "Dados Incompletos")
2203:             RETURN
2204:         ENDIF
2205: 
2206:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
2207:             TRY
2208:                 DO FORM FormSigCdCli WITH loc_cConta
2209:             CATCH TO loc_oErro
2210:                 MsgErro("Erro ao abrir cadastro: " + loc_oErro.Message, "Erro")
2211:             ENDTRY
2212:         ENDIF
2213:     ENDPROC
2214: 
2215:     *--------------------------------------------------------------------------
2216:     * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
2217:     *--------------------------------------------------------------------------
2218:     PROCEDURE CmdOperacaoClick()
2219:         LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro
2220: 
2221:         IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
2222:            RECCOUNT("cursor_4c_Pendentes") = 0
2223:             MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
2224:             RETURN
2225:         ENDIF
2226: 
2227:         TRY
2228:             SELECT cursor_4c_Pendentes
2229:             loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
2230:             loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
2231:             loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)
2232: 
2233:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
2234:                 MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
2235:                 RETURN
2236:             ENDIF
2237: 
2238:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
2239:                        EscaparSQL(loc_cDopes)
2240:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2241: 
2242:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
2243:                RECCOUNT("cursor_4c_TmpOpe") > 0
2244:                 IF USED("cursor_4c_TmpOpe")
2245:                     USE IN cursor_4c_TmpOpe
2246:                 ENDIF
2247:                 DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2248:             ELSE
2249:                 IF USED("cursor_4c_TmpOpe")
2250:                     USE IN cursor_4c_TmpOpe
2251:                 ENDIF
2252:                 loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
2253:                            EscaparSQL(loc_cDopes)
2254:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
2255:                 IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
2256:                    RECCOUNT("cursor_4c_TmpOpd") > 0
2257:                     IF USED("cursor_4c_TmpOpd")
2258:                         USE IN cursor_4c_TmpOpd
2259:                     ENDIF
2260:                     DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2261:                 ELSE
2262:                     IF USED("cursor_4c_TmpOpd")
2263:                         USE IN cursor_4c_TmpOpd
2264:                     ENDIF
2265:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2266:                              "o encontrada no cadastro.", "Aviso")
2267:                 ENDIF
2268:             ENDIF
2269:         CATCH TO loc_oErro
2270:             MsgErro("Erro em FormSigPrCtr.CmdOperacaoClick:" + CHR(13) + ;
2271:                     loc_oErro.Message, "Erro")
2272:         ENDTRY
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     * CmdProcessarClick - Processa arquivo XML: parse, busca estoque, filtra e
2277:     *   muda para Page2 do inner PageFrame para exibir resultados
2278:     *--------------------------------------------------------------------------
2279:     PROCEDURE CmdProcessarClick()
2280:         LOCAL loc_oPg2P1, loc_oPgDados, loc_cArquivo, loc_cConta, loc_cCpf
2281:         LOCAL loc_cCpfLimpo, loc_cStr, loc_cChaveNFe, loc_cCNPJXML, loc_cMsg
2282:         LOCAL loc_cSQL, loc_nResult, loc_cListaOriDopNums, loc_nTipo, loc_oErro
2283: 
2284:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2285:         loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados
2286: 
2287:         IF !PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)
2288:             RETURN
2289:         ENDIF
2290: 
2291:         loc_cArquivo = ALLTRIM(loc_oPg2P1.txt_4c_Arquivo.Value)
2292:         loc_cConta   = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5), ;
2293:                            ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), "")
2294:         loc_cCpf     = IIF(PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf",   5), ;
2295:                            ALLTRIM(loc_oPg2P1.txt_4c_Cpf.Value),   "")
2296: 
2297:         IF EMPTY(loc_cArquivo)
2298:             MsgAviso("Nenhum diret" + CHR(243) + "rio foi informado.", "Aviso")
2299:             RETURN
2300:         ENDIF
2301: 
2302:         IF EMPTY(loc_cConta)
2303:             MsgAviso("Nenhum fornecedor foi informado.", "Aviso")
2304:             RETURN
2305:         ENDIF
2306: 
2307:         IF EMPTY(loc_cCpf)
2308:             MsgAviso("CNPJ/CPF do fornecedor n" + CHR(227) + "o informado.", "Aviso")
2309:             RETURN
2310:         ENDIF
2311: 
2312:         IF !FILE(loc_cArquivo)
2313:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo, "Aviso")
2314:             RETURN
2315:         ENDIF
2316: 
2317:         LOCAL loc_lAbortou
2318:         loc_lAbortou = .F.
2319: 
2320:         TRY
2321:             *-- Compara CNPJ do XML com CNPJ do fornecedor
2322:             loc_cCpfLimpo  = STRTRAN(STRTRAN(STRTRAN(loc_cCpf, ".", ""), "-", ""), "/", "")
2323:             loc_cStr       = UPPER(FILETOSTR(loc_cArquivo))
2324:             loc_cChaveNFe  = ALLTRIM(STREXTRACT(loc_cStr, "<CHNFE>", "</CHNFE>"))
2325:             IF !EMPTY(loc_cChaveNFe)
2326:                 loc_cCNPJXML = SUBSTR(loc_cChaveNFe, 7, 14)
2327:                 IF loc_cCNPJXML != loc_cCpfLimpo
2328:                     loc_cMsg = "Fornecedor com CPF/CNPJ diferente do XML." + CHR(13) + ;
2329:                                "XML      : " + loc_cCNPJXML + CHR(13) + ;
2330:                                "Cadastro : " + loc_cCpfLimpo + CHR(13) + ;
2331:                                "Deseja continuar?"
2332:                     IF !MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2333:                         loc_lAbortou = .T.
2334:                     ENDIF
2335:                 ENDIF
2336:             ENDIF
2337: 
2338:             *-- Passo 1: parse XML -> cursor_4c_Itens
2339:             IF !loc_lAbortou
2340:                 IF !THIS.ProcessarArquivoXML(loc_cArquivo)
2341:                     loc_lAbortou = .T.
2342:                 ENDIF
2343:             ENDIF
2344: 
2345:             *-- Passo 2: lookup produtos em SigCdPro -> cursor_4c_Distribui
2346:             IF !loc_lAbortou
2347:                 THIS.CarregarItensXML()
2348:             ENDIF
2349: 
2350:             *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
2351:             IF !loc_lAbortou
2352:                 loc_cListaOriDopNums = ""
2353:                 IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0
2354:                     SELECT cursor_4c_Pendentes
2355:                     GO TOP
2356:                     SCAN
2357:                         loc_cListaOriDopNums = loc_cListaOriDopNums + ;
2358:                             IIF(EMPTY(loc_cListaOriDopNums), "", ",") + ;
2359:                             EscaparSQL(ALLTRIM(cursor_4c_Pendentes.OriDopNums))
2360:                     ENDSCAN
2361:                 ENDIF
2362:             ENDIF
2363: 
2364:             *-- Passo 4: busca estoque de distribuicao via SigMvItn
2365:             IF !loc_lAbortou
2366:                 IF USED("cursor_4c_Movimentos")
2367:                     USE IN cursor_4c_Movimentos
2368:                 ENDIF
2369:             ENDIF
2370: 
2371:             IF !loc_lAbortou AND !EMPTY(loc_cListaOriDopNums)
2372:                 loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
2373:                            " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
2374:                            " SUM(a.QtReservas) AS QtReservas," + ;
2375:                            " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
2376:                            " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
2377:                            " a.CidChaves, a.Moedas" + ;
2378:                            " FROM SigMvItn a" + ;
2379:                            " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
2380:                            " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
2381:                            " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
2382:                            " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
2383:                            " WHERE e.Distribui = 3" + ;
2384:                            " AND c.GrupoOs <> SPACE(10) AND c.ContaOs <> SPACE(10)" + ;
2385:                            " AND a.CItem2 = 0 AND a.Qtds <> a.QtBaixas" + ;
2386:                            " AND a.EmpDopNums IN (" + loc_cListaOriDopNums + ")" + ;
2387:                            " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
2388:                            "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"
2389:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
2390:                 IF loc_nResult < 0
2391:                     MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
2392:                     loc_lAbortou = .T.
2393:                 ELSE
2394:                     GO TOP IN cursor_4c_Movimentos
2395:                 ENDIF
2396:             ENDIF
2397: 
2398:             IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
2399:                 loc_cListaOriDopNums = ""  && keep var in scope
2400:                 CREATE CURSOR cursor_4c_Movimentos ;
2401:                     ( Cpros C(14), Dpros C(30), Units N(12,4), ;
2402:                       Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
2403:                       OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
2404:                       CidChaves C(20), Moedas C(3) )
2405:             ENDIF
2406: 
2407:             *-- Passo 5: aplica filtro Opt_Fil
2408:             loc_nTipo = 3
2409:             IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
2410:                 loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
2411:             ENDIF
2412: 
2413:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
2414:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
2415:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
2416:                 IF USED("cursor_4c_MovFiltro")
2417:                     USE IN cursor_4c_MovFiltro
2418:                 ENDIF
2419:                 IF loc_nTipo = 1
2420:                     SELECT * FROM cursor_4c_Movimentos ;
2421:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2422:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2423:                 ELSE
2424:                     SELECT * FROM cursor_4c_Movimentos ;
2425:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2426:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2427:                 ENDIF
2428:                 IF USED("cursor_4c_Movimentos")
2429:                     USE IN cursor_4c_Movimentos
2430:                 ENDIF
2431:                 IF USED("cursor_4c_MovFiltro")
2432:                     SELECT * FROM cursor_4c_MovFiltro ;
2433:                         INTO CURSOR cursor_4c_Movimentos READWRITE
2434:                     USE IN cursor_4c_MovFiltro
2435:                     GO TOP IN cursor_4c_Movimentos
2436:                 ENDIF
2437:             ENDIF
2438: 
2439:             *-- Passo 6: vincula grids de Page2 e muda para ela
2440:             IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
2441:                 WITH loc_oPgDados.Page2.grd_4c_Disponivel
2442:                     .RecordSourceType = 1
2443:                     .RecordSource     = "cursor_4c_Movimentos"
2444:                     .Column1.ControlSource = "cursor_4c_Movimentos.Cpros"
2445:                     .Column2.ControlSource = "cursor_4c_Movimentos.Dpros"
2446:                     .Column3.ControlSource = "cursor_4c_Movimentos.Units"
2447:                     .Column4.ControlSource = "cursor_4c_Movimentos.Qtds"
2448:                     .Column5.ControlSource = "cursor_4c_Movimentos.QtBaixas"
2449:                     .Column6.ControlSource = "cursor_4c_Movimentos.QtReservas"
2450:                     .Column7.ControlSource = "cursor_4c_Movimentos.Saldo"
2451:                 ENDWITH
2452:             ENDIF
2453:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2454:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2455:                     .RecordSourceType = 1
2456:                     .RecordSource     = "cursor_4c_Distribui"
2457:                     .Column1.ControlSource = "cursor_4c_Distribui.Cpros"
2458:                     .Column2.ControlSource = "cursor_4c_Distribui.Dpros"
2459:                     .Column3.ControlSource = "cursor_4c_Distribui.Qtds"
2460:                     .Column4.ControlSource = "cursor_4c_Distribui.Total"
2461:                 ENDWITH
2462:             ENDIF
2463:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2464:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2465:             ENDIF
2466:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2467:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2468:             ENDIF
2469:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)
2470:                 loc_oPgDados.ActivePage = 2
2471:             ENDIF
2472: 
2473:         CATCH TO loc_oErro
2474:             MsgErro("Erro em FormSigPrCtr.CmdProcessarClick:" + CHR(13) + ;
2475:                     loc_oErro.Message, "Erro")
2476:         ENDTRY
2477:     ENDPROC
2478: 
2479:     *--------------------------------------------------------------------------
2480:     * ProcessarArquivoXML - Carrega NFe XML e extrai itens para cursor_4c_Itens
2481:     *--------------------------------------------------------------------------
2482:     PROTECTED PROCEDURE ProcessarArquivoXML(par_cArquivo)
2483:         LOCAL loc_lResultado, loc_oXML, loc_nItems, loc_i, loc_oNode, loc_oErro
2484:         loc_lResultado = .F.
2485: 
2486:         IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
2487:             RETURN .F.
2488:         ENDIF
2489: 
2490:         TRY
2491:             IF USED("cursor_4c_Itens")
2492:                 USE IN cursor_4c_Itens
2493:             ENDIF
2494:             CREATE CURSOR cursor_4c_Itens ;
2495:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2496:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2497:                   desconto C(15), frete C(15) )
2498: 
2499:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2500:             IF VARTYPE(loc_oXML) != "O"
2501:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2502:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2503:             ELSE
2504:                 loc_oXML.async = .F.
2505:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2506: 
2507:                 IF !loc_oXML.Load(par_cArquivo)
2508:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;
2509:                             " corrompido.", "Erro XML")
2510:                     WAIT CLEAR
2511:                 ELSE
2512:                     IF UPPER(loc_oXML.documentElement.baseName) != "NFEPROC"
2513:                     MsgErro(JUSTFNAME(par_cArquivo) + " n" + CHR(227) + "o " + ;
2514:                             CHR(233) + " uma NF-e com autoriza" + CHR(231) + ;
2515:                             CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
2516:                     WAIT CLEAR
2517:                 ELSE
2518:                     loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2519:                     FOR loc_i = 0 TO loc_nItems - 1
2520:                         loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
2521:                         APPEND BLANK IN cursor_4c_Itens
2522:                         REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
2523:                                 IN cursor_4c_Itens
2524:                         REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
2525:                                 IN cursor_4c_Itens
2526:                         REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
2527:                                 IN cursor_4c_Itens
2528:                         REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
2529:                                 IN cursor_4c_Itens
2530:                         REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
2531:                                 IN cursor_4c_Itens
2532:                         REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
2533:                                 IN cursor_4c_Itens
2534:                         REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
2535:                                 IN cursor_4c_Itens
2536:                         REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
2537:                                 IN cursor_4c_Itens
2538:                         IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
2539:                             REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;
2540:                                     IN cursor_4c_Itens
2541:                         ENDIF
2542:                         IF loc_oNode.SelectNodes("prod/vFrete").Length > 0
2543:                             REPLACE frete WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vFrete")), 15) ;
2544:                                     IN cursor_4c_Itens
2545:                         ENDIF
2546:                         SELECT cursor_4c_Itens
2547:                     ENDFOR
2548: 
2549:                     WAIT CLEAR
2550:                     GO TOP IN cursor_4c_Itens
2551:                     loc_lResultado = .T.
2552:                     ENDIF
2553:                 ENDIF
2554:             ENDIF
2555: 
2556:         CATCH TO loc_oErro
2557:             WAIT CLEAR
2558:             MsgErro("Erro em FormSigPrCtr.ProcessarArquivoXML:" + CHR(13) + ;
2559:                     loc_oErro.Message, "Erro")
2560:         ENDTRY
2561: 
2562:         RETURN loc_lResultado
2563:     ENDPROC
2564: 
2565:     *--------------------------------------------------------------------------
2566:     * CarregarItensXML - Lookup de cada item do XML em SigCdPro (por Reffs,
2567:     *   Cpros, Dpros, DPro2s); constroi cursor_4c_Distribui com produtos encontrados
2568:     *--------------------------------------------------------------------------
2569:     PROTECTED PROCEDURE CarregarItensXML()
2570:         LOCAL loc_cCodigo, loc_nQtd, loc_nVal, loc_nTot, loc_cSQL, loc_nResult, loc_oErro
2571: 
2572:         IF USED("cursor_4c_Distribui")
2573:             USE IN cursor_4c_Distribui
2574:         ENDIF
2575:         CREATE CURSOR cursor_4c_Distribui ;
2576:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2577: 
2578:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2579:             RETURN
2580:         ENDIF
2581: 
2582:         TRY
2583:             SELECT cursor_4c_Itens
2584:             GO TOP
2585: 
2586:             SCAN
2587:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2588:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2589:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2590:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))
2591: 
2592:                 IF !EMPTY(loc_cCodigo)
2593:                     IF USED("cursor_4c_ProdImport")
2594:                         USE IN cursor_4c_ProdImport
2595:                     ENDIF
2596: 
2597:                     loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2598:                                " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
2599:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2600: 
2601:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2602:                        RECCOUNT("cursor_4c_ProdImport") = 0
2603:                         IF USED("cursor_4c_ProdImport")
2604:                             USE IN cursor_4c_ProdImport
2605:                         ENDIF
2606:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2607:                                    " WHERE Cpros = " + EscaparSQL(loc_cCodigo)
2608:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2609:                     ENDIF

*-- Linhas 2627 a 2702:
2627:                                    " WHERE DPro2s = " + EscaparSQL(loc_cCodigo)
2628:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2629:                     ENDIF
2630: 
2631:                     IF USED("cursor_4c_ProdImport") AND RECCOUNT("cursor_4c_ProdImport") > 0
2632:                         SELECT cursor_4c_Distribui
2633:                         APPEND BLANK
2634:                         REPLACE Cpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Cpros), 14), ;
2635:                                 Dpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Dpros), 30), ;
2636:                                 Qtds  WITH loc_nQtd, ;
2637:                                 Units WITH loc_nVal, ;
2638:                                 Total WITH loc_nTot
2639:                     ENDIF
2640: 
2641:                     IF USED("cursor_4c_ProdImport")
2642:                         USE IN cursor_4c_ProdImport
2643:                     ENDIF
2644:                 ENDIF
2645: 
2646:                 SELECT cursor_4c_Itens
2647:             ENDSCAN
2648: 
2649:             IF USED("cursor_4c_Distribui")
2650:                 GO TOP IN cursor_4c_Distribui
2651:             ENDIF
2652: 
2653:         CATCH TO loc_oErro
2654:             MsgErro("Erro em FormSigPrCtr.CarregarItensXML:" + CHR(13) + ;
2655:                     loc_oErro.Message, "Erro")
2656:         ENDTRY
2657:     ENDPROC
2658: 
2659:     *--------------------------------------------------------------------------
2660:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2661:     *--------------------------------------------------------------------------
2662:     PROTECTED PROCEDURE CarregarMovimentosPendentes(par_cConta, par_lFiltrar)
2663:         LOCAL loc_oPg2P1, loc_oGrid, loc_lResultado, loc_oErro
2664:         loc_lResultado = .F.
2665: 
2666:         TRY
2667:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2668:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2669:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2670:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2671:                     loc_oGrid.ColumnCount = 5
2672:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2673:                     WITH loc_oGrid
2674:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2675:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2676:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2677:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2678:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2679:                     ENDWITH
2680:                 ENDIF
2681:                 loc_lResultado = .T.
2682:             ENDIF
2683:         CATCH TO loc_oErro
2684:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2685:                     loc_oErro.Message, "Erro")
2686:         ENDTRY
2687: 
2688:         RETURN loc_lResultado
2689:     ENDPROC
2690: 
2691:     *--------------------------------------------------------------------------
2692:     * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
2693:     *--------------------------------------------------------------------------
2694:     PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
2695:         LOCAL loc_oNode, loc_cResult, loc_oErro
2696:         loc_cResult = ""
2697: 
2698:         TRY
2699:             IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
2700:                 loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
2701:                 IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
2702:                     loc_cResult = NVL(loc_oNode.Text, "")

*-- Linhas 2716 a 2787:
2716:     * grdDisponivel (7 colunas), grdItemXml (4 colunas), campos produto
2717:     * Offset +29 em Top para compensar tab oculta do inner PageFrame
2718:     *--------------------------------------------------------------------------
2719:     PROTECTED PROCEDURE ConfigurarPaginaDadosDetalhe()
2720:         LOCAL loc_oPg2P2
2721:         loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2722: 
2723:         *-- Shape5: borda ao redor da imagem (top=1+29=30)
2724:         loc_oPg2P2.AddObject("shp_4c_Shape5", "Shape")
2725:         WITH loc_oPg2P2.shp_4c_Shape5
2726:             .Top = 30
2727:             .Left = 424
2728:             .Height = 113
2729:             .Width = 282
2730:             .BackStyle = 0
2731:             .BorderStyle = 1
2732:             .BorderWidth = 2
2733:             .SpecialEffect = 0
2734:             .Visible = .T.
2735:         ENDWITH
2736: 
2737:         *-- Imagem produto FigJpg / img_4c_FigJpg (top=3+29=32)
2738:         loc_oPg2P2.AddObject("img_4c_FigJpg", "Image")
2739:         WITH loc_oPg2P2.img_4c_FigJpg
2740:             .Stretch = 1
2741:             .Top = 32
2742:             .Left = 426
2743:             .Width = 278
2744:             .Height = 109
2745:             .Visible = .F.
2746:         ENDWITH
2747:         BINDEVENT(loc_oPg2P2.img_4c_FigJpg, "DblClick", THIS, "ImgFigJpgDblClick")
2748: 
2749:         *-- Textboxes de cabecalho Sistema/Arquivo (top=113+29=142)
2750:         loc_oPg2P2.AddObject("txt_4c_Sistema", "TextBox")
2751:         WITH loc_oPg2P2.txt_4c_Sistema
2752:             .FontBold = .T.
2753:             .Alignment = 2
2754:             .Top = 142
2755:             .Left = 8
2756:             .Width = 684
2757:             .Height = 20
2758:             .BackColor = RGB(128, 255, 255)
2759:             .BackStyle = 1
2760:             .ReadOnly = .T.
2761:             .BorderStyle = 0
2762:             .Value = "Sistema"
2763:             .Visible = .T.
2764:         ENDWITH
2765: 
2766:         loc_oPg2P2.AddObject("txt_4c_Arquivo", "TextBox")
2767:         WITH loc_oPg2P2.txt_4c_Arquivo
2768:             .FontBold = .T.
2769:             .Alignment = 2
2770:             .Top = 142
2771:             .Left = 691
2772:             .Width = 495
2773:             .Height = 20
2774:             .BackColor = RGB(255, 255, 128)
2775:             .BackStyle = 1
2776:             .ReadOnly = .T.
2777:             .BorderStyle = 0
2778:             .Value = "Arquivo"
2779:             .Visible = .T.
2780:         ENDWITH
2781: 
2782:         *-- Label procurar produto (top=74+29=103)
2783:         loc_oPg2P2.AddObject("lbl_4c_Lbl_produto", "Label")
2784:         WITH loc_oPg2P2.lbl_4c_Lbl_produto
2785:             .Caption   = "Procurar Produto :"
2786:             .AutoSize  = .T.
2787:             .Top = 103

*-- Linhas 2809 a 3081:
2809:             .SpecialEffect = 1
2810:             .Visible = .T.
2811:         ENDWITH
2812:         BINDEVENT(loc_oPg2P2.txt_4c__produto_inicial, "KeyPress", THIS, "TxtProdutoInicialLostFocus")
2813: 
2814:         *-- Grid disponivel / grd_4c_Disponivel (7 colunas, top=134+29=163)
2815:         loc_oPg2P2.AddObject("grd_4c_Disponivel", "Grid")
2816:         loc_oPg2P2.grd_4c_Disponivel.ColumnCount = 7
2817:         loc_oPg2P2.grd_4c_Disponivel.Top         = 163
2818:         loc_oPg2P2.grd_4c_Disponivel.Left        = 8
2819:         loc_oPg2P2.grd_4c_Disponivel.Width       = 684
2820:         loc_oPg2P2.grd_4c_Disponivel.Height      = 344
2821:         WITH loc_oPg2P2.grd_4c_Disponivel
2822:             .FontName  = "Tahoma"
2823:             .FontSize = 8
2824:             .ReadOnly  = .T.
2825:             .RecordMark = .F.
2826:             .RowHeight = 17
2827:             .Panel = 1
2828:             .BackColor = RGB(237, 242, 243)
2829:             .GridLineColor = RGB(238, 238, 238)
2830:             .AllowHeaderSizing = .F.
2831:             .AllowRowSizing = .F.
2832:             .ScrollBars = 2
2833:             .Visible = .T.
2834: 
2835:             WITH .Column1
2836:                 .Width = 100
2837:                 .Movable = .F.
2838:                 .Resizable = .F.
2839:                 .ReadOnly = .T.
2840:                 .ForeColor = RGB(0, 0, 255)
2841:                 .BackColor = RGB(237, 242, 243)
2842:                 .MousePointer = 15
2843:                 .FontBold = .T.
2844:                 .FontUnderline = .T.
2845:                 .Header1.Caption = "C" + CHR(243) + "digo"
2846:                 .Header1.Alignment = 2
2847:                 .Header1.ForeColor = RGB(90, 90, 90)
2848:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2849:             ENDWITH
2850: 
2851:             WITH .Column2
2852:                 .Width = 235
2853:                 .Movable = .F.
2854:                 .Resizable = .F.
2855:                 .ReadOnly = .T.
2856:                 .BackColor = RGB(237, 242, 243)
2857:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2858:                 .Header1.Alignment = 2
2859:                 .Header1.ForeColor = RGB(90, 90, 90)
2860:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2861:             ENDWITH
2862: 
2863:             WITH .Column3
2864:                 .Width = 70
2865:                 .Movable = .F.
2866:                 .Resizable = .F.
2867:                 .ReadOnly = .T.
2868:                 .BackColor = RGB(237, 242, 243)
2869:                 .Header1.Caption = "Valor"
2870:                 .Header1.Alignment = 2
2871:                 .Header1.ForeColor = RGB(90, 90, 90)
2872:                 .ControlSource = "cursor_4c_Movimentos.Units"
2873:             ENDWITH
2874: 
2875:             WITH .Column4
2876:                 .Width = 63
2877:                 .Movable = .F.
2878:                 .Resizable = .F.
2879:                 .ReadOnly = .T.
2880:                 .BackColor = RGB(237, 242, 243)
2881:                 .FontBold = .T.
2882:                 .Header1.Caption = "Quantidade"
2883:                 .Header1.Alignment = 2
2884:                 .Header1.ForeColor = RGB(90, 90, 90)
2885:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2886:             ENDWITH
2887: 
2888:             WITH .Column5
2889:                 .Width = 63
2890:                 .Movable = .F.
2891:                 .Resizable = .F.
2892:                 .ReadOnly = .T.
2893:                 .BackColor = RGB(237, 242, 243)
2894:                 .FontBold = .T.
2895:                 .Header1.Caption = "Baixado"
2896:                 .Header1.Alignment = 2
2897:                 .Header1.ForeColor = RGB(90, 90, 90)
2898:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2899:             ENDWITH
2900: 
2901:             WITH .Column6
2902:                 .Width = 63
2903:                 .Movable = .F.
2904:                 .Resizable = .F.
2905:                 .ReadOnly = .T.
2906:                 .BackColor = RGB(237, 242, 243)
2907:                 .FontBold = .T.
2908:                 .Header1.Caption = "Reservado"
2909:                 .Header1.Alignment = 2
2910:                 .Header1.ForeColor = RGB(90, 90, 90)
2911:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2912:             ENDWITH
2913: 
2914:             WITH .Column7
2915:                 .Width = 63
2916:                 .Movable = .F.
2917:                 .Resizable = .F.
2918:                 .ReadOnly = .T.
2919:                 .BackColor = RGB(237, 242, 243)
2920:                 .FontBold = .T.
2921:                 .Header1.Caption = "Saldo"
2922:                 .Header1.Alignment = 2
2923:                 .Header1.ForeColor = RGB(90, 90, 90)
2924:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
2925:             ENDWITH
2926:         ENDWITH
2927:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
2928:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
2929: 
2930:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
2931:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
2932:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
2933:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
2934:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
2935:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
2936:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
2937:         WITH loc_oPg2P2.grd_4c_ItemXml
2938:             .FontName  = "Tahoma"
2939:             .FontSize = 8
2940:             .RecordMark = .F.
2941:             .Panel = 1
2942:             .BackColor = RGB(237, 242, 243)
2943:             .GridLineColor = RGB(238, 238, 238)
2944:             .AllowHeaderSizing = .F.
2945:             .AllowRowSizing = .F.
2946:             .RowHeight = 17
2947:             .Visible = .T.
2948: 
2949:             WITH .Column1
2950:                 .Width = 100
2951:                 .Movable = .F.
2952:                 .Resizable = .F.
2953:                 .ReadOnly = .T.
2954:                 .Enabled = .F.
2955:                 .ForeColor = RGB(0, 0, 0)
2956:                 .BackColor = RGB(237, 242, 243)
2957:                 .Header1.Caption = "C" + CHR(243) + "digo"
2958:                 .Header1.Alignment = 2
2959:                 .Header1.ForeColor = RGB(90, 90, 90)
2960:                 .ControlSource = "cursor_4c_Distribui.Cpros"
2961:             ENDWITH
2962: 
2963:             WITH .Column2
2964:                 .Width = 235
2965:                 .Movable = .F.
2966:                 .Resizable = .F.
2967:                 .ReadOnly = .T.
2968:                 .Enabled = .F.
2969:                 .ForeColor = RGB(0, 0, 0)
2970:                 .BackColor = RGB(237, 242, 243)
2971:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2972:                 .Header1.Alignment = 2
2973:                 .Header1.ForeColor = RGB(90, 90, 90)
2974:                 .ControlSource = "cursor_4c_Distribui.Dpros"
2975:             ENDWITH
2976: 
2977:             WITH .Column3
2978:                 .Width = 63
2979:                 .Movable = .F.
2980:                 .Resizable = .F.
2981:                 .InputMask = "999999"
2982:                 .ForeColor = RGB(0, 0, 0)
2983:                 .BackColor = RGB(237, 242, 243)
2984:                 .Header1.Caption = "Quantidade"
2985:                 .Header1.Alignment = 2
2986:                 .Header1.ForeColor = RGB(90, 90, 90)
2987:                 .ControlSource = "cursor_4c_Distribui.Qtds"
2988:             ENDWITH
2989: 
2990:             WITH .Column4
2991:                 .Width = 70
2992:                 .Movable = .F.
2993:                 .Resizable = .F.
2994:                 .ReadOnly = .T.
2995:                 .Enabled = .F.
2996:                 .ForeColor = RGB(0, 0, 0)
2997:                 .BackColor = RGB(237, 242, 243)
2998:                 .Header1.Caption = "Valor"
2999:                 .Header1.Alignment = 2
3000:                 .Header1.ForeColor = RGB(90, 90, 90)
3001:                 .ControlSource = "cursor_4c_Distribui.Total"
3002:             ENDWITH
3003:         ENDWITH
3004: 
3005:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
3006:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
3007:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
3008:             .Caption = ""
3009:             .Themes = .F.
3010:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3011:             .Top = 508
3012:             .Left = 663
3013:             .Width = 40
3014:             .Height = 37
3015:             .ForeColor = RGB(255, 0, 0)
3016:             .BackColor = RGB(255, 255, 255)
3017:             .ToolTipText = "Excluir Linha da Grade Sistema"
3018:             .SpecialEffect = 0
3019:             .TabStop = .F.
3020:             .Visible = .T.
3021:         ENDWITH
3022:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
3023: 
3024:         *-- Botao excluir Grade Arquivo / cmd_4c_BtnExcluirArq (top=479+29=508)
3025:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
3026:         WITH loc_oPg2P2.cmd_4c_BtnExcluirArq
3027:             .Caption = ""
3028:             .Themes = .F.
3029:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3030:             .Top = 508
3031:             .Left = 1146
3032:             .Width = 40
3033:             .Height = 37
3034:             .ForeColor = RGB(255, 0, 0)
3035:             .BackColor = RGB(255, 255, 255)
3036:             .ToolTipText = "Excluir Linha da Grade Arquivo"
3037:             .SpecialEffect = 0
3038:             .TabStop = .F.
3039:             .Visible = .T.
3040:         ENDWITH
3041:         BINDEVENT(loc_oPg2P2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
3042: 
3043:         *-- Label: Movimentacao (Say3, top=483+29=512)
3044:         loc_oPg2P2.AddObject("lbl_4c_Label3", "Label")
3045:         WITH loc_oPg2P2.lbl_4c_Label3
3046:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
3047:             .AutoSize  = .T.
3048:             .Top = 512
3049:             .Left = 40
3050:             .Height = 15
3051:             .FontName  = "Tahoma"
3052:             .FontSize = 8
3053:             .ForeColor = RGB(90, 90, 90)
3054:             .BackStyle = 0
3055:             .Visible = .T.
3056:         ENDWITH
3057: 
3058:         *-- getEmps (top=480+29=509)
3059:         loc_oPg2P2.AddObject("txt_4c_Emps", "TextBox")
3060:         WITH loc_oPg2P2.txt_4c_Emps
3061:             .Value = ""
3062:             .Format = "K!"
3063:             .ReadOnly = .T.
3064:             .Top = 509
3065:             .Left = 122
3066:             .Width = 65
3067:             .Height = 21
3068:             .FontName = "Tahoma"
3069:             .FontSize = 8
3070:             .SpecialEffect = 1
3071:             .Visible = .T.
3072:             .BackColor = RGB(255, 255, 255)
3073:             .BackStyle = 1
3074:         ENDWITH
3075: 
3076:         *-- getDopes (top=480+29=509)
3077:         loc_oPg2P2.AddObject("txt_4c_Dopes", "TextBox")
3078:         WITH loc_oPg2P2.txt_4c_Dopes
3079:             .Value = ""
3080:             .MaxLength = 20
3081:             .Format = "K!"

*-- Linhas 3333 a 3422:
3333:             .BackStyle = 1
3334:         ENDWITH
3335: 
3336:         BINDEVENT(loc_oPg2P2, "Activate", THIS, "PgfDadosPage2Activate")
3337:     ENDPROC
3338: 
3339:     *--------------------------------------------------------------------------
3340:     * PgfDadosPage2Activate - Refresca grids ao ativar Page2 de detalhe
3341:     *--------------------------------------------------------------------------
3342:     PROCEDURE PgfDadosPage2Activate()
3343:         LOCAL loc_oPg2P2, loc_oErro
3344:         TRY
3345:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3346:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3347:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3348:             ENDIF
3349:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3350:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3351:             ENDIF
3352:         CATCH TO loc_oErro
3353:             MsgErro("Erro em FormSigPrCtr.PgfDadosPage2Activate:" + CHR(13) + loc_oErro.Message, "Erro")
3354:         ENDTRY
3355:     ENDPROC
3356: 
3357:     *--------------------------------------------------------------------------
3358:     * GrdDisponivelAfterRowColChange - Ao mover linha em grd_4c_Disponivel:
3359:     *   busca detalhes SigCdPro e popula campos inferiores + FigJpg
3360:     *--------------------------------------------------------------------------
3361:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
3362:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult, loc_cArqTemp
3363:         LOCAL loc_cFigJpgs, loc_cFoto, loc_lTemFig
3364:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3365:         LOCAL loc_lAbortou, loc_oErro
3366:         loc_lAbortou = .F.
3367: 
3368:         TRY
3369:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3370:                 loc_lAbortou = .T.
3371:             ENDIF
3372: 
3373:             IF !loc_lAbortou
3374:                 loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3375:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3376:                 IF EMPTY(loc_cCpros)
3377:                     loc_lAbortou = .T.
3378:                 ENDIF
3379:             ENDIF
3380: 
3381:             IF !loc_lAbortou
3382:                 loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
3383:                            " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
3384:                            " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3385:                 IF USED("cursor_4c_TmpPro")
3386:                     USE IN cursor_4c_TmpPro
3387:                 ENDIF
3388:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3389:                 IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3390:                     loc_lAbortou = .T.
3391:                 ENDIF
3392:             ENDIF
3393: 
3394:             IF !loc_lAbortou
3395:                 SELECT cursor_4c_TmpPro
3396:                 GO TOP
3397: 
3398:                 *-- Campos detalhe produto
3399:                 loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
3400:                 loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
3401:                 loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))
3402:                 loc_oPg2P2.txt_4c__custofs.Value        = NVL(cursor_4c_TmpPro.custofs, 0)
3403:                 loc_oPg2P2.txt_4c__precoMov.Value       = NVL(cursor_4c_TmpPro.pcuss, 0)
3404:                 loc_oPg2P2.txt_4c_CIdChaves.Value       = ALLTRIM(NVL(cursor_4c_Movimentos.CidChaves, ""))
3405:                 loc_oPg2P2.txt_4c_Emps.Value            = SUBSTR(cursor_4c_Movimentos.OriDopNums, 1, 3)
3406:                 loc_oPg2P2.txt_4c_Dopes.Value           = SUBSTR(cursor_4c_Movimentos.OriDopNums, 4, 20)
3407:                 loc_oPg2P2.txt_4c_Numes.Value           = ALLTRIM(RIGHT(cursor_4c_Movimentos.OriDopNums, 6))
3408: 
3409:                 *-- Preco de venda: converte para moeda padrao se configurada
3410:                 loc_cMoeDetqs = ""
3411:                 IF USED("cursor_4c_TmpPam")
3412:                     USE IN cursor_4c_TmpPam
3413:                 ENDIF
3414:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_TmpPam") > 0 ;
3415:                    AND USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
3416:                     loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_TmpPam.moedetqs, ""))
3417:                     USE IN cursor_4c_TmpPam
3418:                 ENDIF
3419: 
3420:                 IF EMPTY(loc_cMoeDetqs)
3421:                     loc_oPg2P2.txt_4c__pr_venda.Value       = NVL(cursor_4c_TmpPro.pvens, 0)
3422:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))

*-- Linhas 3479 a 3689:
3479:                     loc_oErro.Message, "Erro")
3480:         ENDTRY
3481:     ENDPROC
3482: 
3483:     *--------------------------------------------------------------------------
3484:     * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
3485:     *--------------------------------------------------------------------------
3486:     PROCEDURE BtnExcluirSisClick()
3487:         LOCAL loc_oPg2P2, loc_oErro
3488:         TRY
3489:             IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
3490:                 SELECT cursor_4c_Movimentos
3491:                 DELETE
3492:                 IF !EOF("cursor_4c_Movimentos")
3493:                     SKIP
3494:                     SKIP -1
3495:                 ENDIF
3496:                 GO TOP IN cursor_4c_Movimentos
3497:             ENDIF
3498:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3499:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3500:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3501:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3502:             ENDIF
3503:         CATCH TO loc_oErro
3504:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3505:         ENDTRY
3506:     ENDPROC
3507: 
3508:     *--------------------------------------------------------------------------
3509:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3510:     *--------------------------------------------------------------------------
3511:     PROCEDURE BtnExcluirArqClick()
3512:         LOCAL loc_oPg2P2, loc_oErro
3513:         TRY
3514:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3515:                 SELECT cursor_4c_Distribui
3516:                 DELETE
3517:                 IF !EOF("cursor_4c_Distribui")
3518:                     SKIP
3519:                     SKIP -1
3520:                 ENDIF
3521:                 GO TOP IN cursor_4c_Distribui
3522:             ENDIF
3523:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3524:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3525:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3526:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3527:             ENDIF
3528:         CATCH TO loc_oErro
3529:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3530:         ENDTRY
3531:     ENDPROC
3532: 
3533:     *--------------------------------------------------------------------------
3534:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3535:     *--------------------------------------------------------------------------
3536:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3537:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3538:         TRY
3539:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3540:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3541:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
3542:                 IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
3543:                     SELECT cursor_4c_Movimentos
3544:                     loc_nRecno = RECNO()
3545:                     GO TOP
3546:                     LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
3547:                     IF EOF()
3548:                         GO loc_nRecno
3549:                     ENDIF
3550:                 ENDIF
3551:             ENDIF
3552:         CATCH TO loc_oErro
3553:             MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
3554:                     loc_oErro.Message, "Erro")
3555:         ENDTRY
3556:     ENDPROC
3557: 
3558:     *--------------------------------------------------------------------------
3559:     * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
3560:     *--------------------------------------------------------------------------
3561:     PROCEDURE ImgFigJpgDblClick()
3562:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
3563:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
3564:         TRY
3565:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3566:                 RETURN
3567:             ENDIF
3568:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3569:             IF EMPTY(loc_cCpros)
3570:                 RETURN
3571:             ENDIF
3572:             loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
3573:                        EscaparSQL(loc_cCpros)
3574:             IF USED("cursor_4c_TmpPro")
3575:                 USE IN cursor_4c_TmpPro
3576:             ENDIF
3577:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3578:             IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3579:                 RETURN
3580:             ENDIF
3581:             SELECT cursor_4c_TmpPro
3582:             GO TOP
3583:             loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3584:             IF USED("cursor_4c_TmpPro")
3585:                 USE IN cursor_4c_TmpPro
3586:             ENDIF
3587:             IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
3588:                 loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3589:                 loc_cFoto = STRCONV(;
3590:                     STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3591:                         "data:image/png;base64,", ""), ;
3592:                         "data:image/jpeg;base64,", ""), ;
3593:                         "data:image/jpg;base64,", ""), 14)
3594:                 STRTOFILE(loc_cFoto, loc_cArqTemp)
3595:                 IF FILE(loc_cArqTemp)
3596:                     loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
3597:                                    ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
3598:                     IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
3599:                        FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
3600:                         DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
3601:                             WITH loc_cArqTemp, loc_cCaption, " "
3602:                     ELSE
3603:                         DECLARE INTEGER ShellExecute IN shell32.dll ;
3604:                             INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
3605:                             STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
3606:                         ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
3607:                     ENDIF
3608:                 ENDIF
3609:             ENDIF
3610:         CATCH TO loc_oErro
3611:             MsgErro("Erro em FormSigPrCtr.ImgFigJpgDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3612:         ENDTRY
3613:     ENDPROC
3614: 
3615:     *--------------------------------------------------------------------------
3616:     * GrdDisponivelDblClick - Duplo clique em Col01 abre pesquisa global produto
3617:     *--------------------------------------------------------------------------
3618:     PROCEDURE GrdDisponivelDblClick()
3619:         LOCAL loc_oPg2P2, loc_cCpros, loc_oErro
3620:         TRY
3621:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3622:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3623:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3624:                     RETURN
3625:                 ENDIF
3626:             ENDIF
3627:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3628:                 RETURN
3629:             ENDIF
3630:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3631:             IF EMPTY(loc_cCpros)
3632:                 RETURN
3633:             ENDIF
3634:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3635:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3636:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3637:             ELSE
3638:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
3639:                         ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
3640:             ENDIF
3641:         CATCH TO loc_oErro
3642:             MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3643:         ENDTRY
3644:     ENDPROC
3645: 
3646:     *--------------------------------------------------------------------------
3647:     * Destroy - Libera BO e fecha cursores
3648:     *--------------------------------------------------------------------------
3649:     PROCEDURE Destroy()
3650:         LOCAL loc_oErro
3651: 
3652:         TRY
3653:             IF USED("cursor_4c_Dados")
3654:                 USE IN cursor_4c_Dados
3655:             ENDIF
3656: 
3657:             IF USED("cursor_4c_Movimentos")
3658:                 USE IN cursor_4c_Movimentos
3659:             ENDIF
3660: 
3661:             IF USED("cursor_4c_Pendentes")
3662:                 USE IN cursor_4c_Pendentes
3663:             ENDIF
3664: 
3665:             IF USED("cursor_4c_Linhas")
3666:                 USE IN cursor_4c_Linhas
3667:             ENDIF
3668: 
3669:             IF USED("cursor_4c_Itens")
3670:                 USE IN cursor_4c_Itens
3671:             ENDIF
3672: 
3673:             IF USED("cursor_4c_Distribui")
3674:                 USE IN cursor_4c_Distribui
3675:             ENDIF
3676: 
3677:             IF USED("cursor_4c_TmpJoin")
3678:                 USE IN cursor_4c_TmpJoin
3679:             ENDIF
3680: 
3681:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3682:                 THIS.this_oBusinessObject = .NULL.
3683:             ENDIF
3684:         CATCH TO loc_oErro
3685:             MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
3686:         ENDTRY
3687: 
3688:         DODEFAULT()
3689:     ENDPROC


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

