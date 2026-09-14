# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (19)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=11 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=5 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=4 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3336 linhas total):

*-- Linhas 53 a 168:
53:     *--------------------------------------------------------------------------
54:     * Init - Inicializacao do formulario
55:     *--------------------------------------------------------------------------
56:     PROCEDURE Init()
57:         RETURN DODEFAULT()
58:     ENDPROC
59: 
60:     *--------------------------------------------------------------------------
61:     * InicializarForm - Configuracao inicial (chamado por FormBase.Init)
62:     *--------------------------------------------------------------------------
63:     PROTECTED PROCEDURE InicializarForm()
64:         LOCAL loc_lSucesso
65:         loc_lSucesso = .F.
66: 
67:         TRY
68:             THIS.this_oBusinessObject = CREATEOBJECT("ccrBO")
69: 
70:             IF ISNULL(THIS.this_oBusinessObject)
71:                 MostrarErro("Erro ao criar Business Object ccrBO", "Erro Cr" + CHR(237) + "tico")
72:             ELSE
73:                 THIS.ConfigurarPageFrame()
74:                 THIS.ConfigurarPaginaLista()
75:                 THIS.ConfigurarPaginaDados()
76:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
77:                     "Grupos de Contas Corrente"
78: 
79:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
80:                     THIS.CarregarLista()
81:                 ENDIF
82: 
83:                 THIS.pgf_4c_Paginas.Visible = .T.
84:                 THIS.pgf_4c_Paginas.ActivePage = 1
85:                 THIS.this_cModoAtual = "LISTA"
86:                 loc_lSucesso = .T.
87:             ENDIF
88: 
89:         CATCH TO loException
90:             MostrarErro("Erro ao inicializar Formccr:" + CHR(13) + ;
91:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
92:                 loException.Message, "Erro")
93:         ENDTRY
94: 
95:         RETURN loc_lSucesso
96:     ENDPROC
97: 
98:     *--------------------------------------------------------------------------
99:     * ConfigurarPageFrame - PageFrame externo (Page1=Lista, Page2=Dados)
100:     * Top=-29 oculta abas, Width=1003 cobre toda a forma
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarPageFrame()
103:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
104: 
105:         WITH THIS.pgf_4c_Paginas
106:             .Top       = -29
107:             .Left      = 0
108:             .Width     = 1003
109:             .Height    = 629
110:             .PageCount = 2
111:             .Tabs      = .F.
112:             .Visible   = .T.
113: 
114:             .Page1.Caption   = "Lista"
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page1.BackColor = RGB(255, 255, 255)
117: 
118:             .Page2.Caption   = "Dados"
119:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120:             .Page2.BackColor = RGB(255, 255, 255)
121:         ENDWITH
122:     ENDPROC
123: 
124:     *--------------------------------------------------------------------------
125:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, saida, grid
126:     * Compensacao +29 aplicada (Top_original + 29)
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE ConfigurarPaginaLista()
129:         LOCAL loc_oPagina
130:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
131: 
132:         *-- Container cabecalho (Top=31, Width=1020, Height=80)
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 31
136:             .Left        = 0
137:             .Width       = 1020
138:             .Height      = 80
139:             .BackStyle   = 0
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = "Grupos de Contas Corrente"
147:             .Top       = 20
148:             .Left      = 20
149:             .Width     = 400
150:             .Height    = 30
151:             .FontName  = "Tahoma"
152:             .FontSize  = 14
153:             .FontBold  = .T.
154:             .BackStyle = 0
155:             .ForeColor = RGB(90, 90, 90)
156:             .Visible   = .T.
157:         ENDWITH
158: 
159:         *-- Container botoes CRUD (Left=542, Top=29, Width=400, Height=85)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 400
165:             .Height      = 85
166:             .BackStyle = 1
167:             .BackColor = RGB(53, 53, 53)
168:             .BorderWidth = 0

*-- Linhas 187 a 434:
187:             .ForeColor       = RGB(90, 90, 90)
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         *-- Visualizar (Left=80)
193:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
194:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
195:             .Caption         = "Visualizar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:             .PicturePosition = 13
198:             .Width           = 75
199:             .Height          = 75
200:             .Left            = 80
201:             .Top             = 5
202:             .FontName        = "Tahoma"
203:             .FontSize        = 8
204:             .Themes          = .F.
205:             .SpecialEffect   = 0
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
211: 
212:         *-- Alterar (Left=155)
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
215:             .Caption         = "Alterar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
217:             .PicturePosition = 13
218:             .Width           = 75
219:             .Height          = 75
220:             .Left            = 155
221:             .Top             = 5
222:             .FontName        = "Tahoma"
223:             .FontSize        = 8
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .Visible         = .T.
229:         ENDWITH
230:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
231: 
232:         *-- Excluir (Left=230)
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
235:             .Caption         = "Excluir"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
237:             .PicturePosition = 13
238:             .Width           = 75
239:             .Height          = 75
240:             .Left            = 230
241:             .Top             = 5
242:             .FontName        = "Tahoma"
243:             .FontSize        = 8
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .BackColor       = RGB(255, 255, 255)
247:             .ForeColor       = RGB(90, 90, 90)
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
251: 
252:         *-- Buscar (Left=305)
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
255:             .Caption         = "Buscar"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
257:             .PicturePosition = 13
258:             .Width           = 75
259:             .Height          = 75
260:             .Left            = 305
261:             .Top             = 5
262:             .FontName        = "Tahoma"
263:             .FontSize        = 8
264:             .Themes          = .F.
265:             .SpecialEffect   = 0
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
271: 
272:         *-- Container saida (Left=917, Top=29, Width=90, Height=85)
273:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
274:         WITH loc_oPagina.cnt_4c_Saida
275:             .Top         = 29
276:             .Left        = 917
277:             .Width       = 90
278:             .Height      = 85
279:             .BackStyle = 1
280:             .BackColor = RGB(53, 53, 53)
281:             .BorderWidth = 0
282:             .Visible     = .T.
283:         ENDWITH
284: 
285:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
286:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
287:             .Caption         = "Encerrar"
288:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
289:             .PicturePosition = 13
290:             .Width           = 75
291:             .Height          = 75
292:             .Left            = 5
293:             .Top             = 5
294:             .FontName        = "Tahoma"
295:             .FontSize        = 8
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .BackColor       = RGB(255, 255, 255)
299:             .ForeColor       = RGB(90, 90, 90)
300:             .Visible         = .T.
301:         ENDWITH
302:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
303: 
304:         *-- Container filtros (Left=5, Top=29, vazio - busca via BtnBuscarClick)
305:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
306:         WITH loc_oPagina.cnt_4c_Filtros
307:             .Top         = 29
308:             .Left        = 5
309:             .Width       = 530
310:             .Height      = 85
311:             .BackStyle   = 0
312:             .BorderWidth = 0
313:             .Visible     = .T.
314:         ENDWITH
315: 
316:         *-- Grid de lista (Top=121, Left=11, Width=938, Height=470)
317:         *-- 5 colunas: Codigos/Descrs/Internos/TpCods/DClasses
318:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
319:         WITH loc_oPagina.grd_4c_Lista
320:             .Top               = 121
321:             .Left              = 11
322:             .Width             = 938
323:             .Height            = 470
324:             .ReadOnly          = .T.
325:             .DeleteMark        = .F.
326:             .RecordMark        = .F.
327:             .ScrollBars        = 3
328:             .GridLines         = 3
329:             .ColumnCount       = 5
330:             .AllowHeaderSizing = .T.
331:             .Visible           = .T.
332:         ENDWITH
333: 
334:         THIS.TornarControlesVisiveis(loc_oPagina)
335:     ENDPROC
336: 
337:     *--------------------------------------------------------------------------
338:     * ConfigurarPaginaDados - Page2: identificacao + inner PageFrame 4 abas
339:     * Compensacao +29 aplicada nos Tops
340:     *--------------------------------------------------------------------------
341:     PROTECTED PROCEDURE ConfigurarPaginaDados()
342:         LOCAL loc_oPagina
343:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
344: 
345:         *-- Botoes Salvar/Cancelar (Top=38, Left=819, Width=165, Height=85)
346:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
347:         WITH loc_oPagina.cnt_4c_BotoesDados
348:             .Top         = 38
349:             .Left        = 819
350:             .Width       = 165
351:             .Height      = 85
352:             .BackStyle = 1
353:             .BackColor = RGB(53, 53, 53)
354:             .BorderWidth = 0
355:             .Visible     = .T.
356:         ENDWITH
357: 
358:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
359:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
360:             .Caption         = "Salvar"
361:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
362:             .PicturePosition = 13
363:             .Width           = 75
364:             .Height          = 75
365:             .Left            = 7
366:             .Top             = 5
367:             .FontName        = "Tahoma"
368:             .FontSize        = 8
369:             .Themes          = .F.
370:             .SpecialEffect   = 0
371:             .BackColor       = RGB(255, 255, 255)
372:             .ForeColor       = RGB(90, 90, 90)
373:             .Visible         = .T.
374:         ENDWITH
375:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
376: 
377:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
378:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
379:             .Caption         = "Cancelar"
380:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
381:             .PicturePosition = 13
382:             .Width           = 75
383:             .Height          = 75
384:             .Left            = 83
385:             .Top             = 5
386:             .FontName        = "Tahoma"
387:             .FontSize        = 8
388:             .Themes          = .F.
389:             .SpecialEffect   = 0
390:             .BackColor       = RGB(255, 255, 255)
391:             .ForeColor       = RGB(90, 90, 90)
392:             .Visible         = .T.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
395: 
396:         *----------------------------------------------------------------------
397:         *-- ROW 1: Codigos | Descrs | Internos (Top=38)
398:         *----------------------------------------------------------------------
399:         loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
400:         WITH loc_oPagina.lbl_4c_LblCodigos
401:             .Caption   = "C" + CHR(243) + "digo :"
402:             .Left      = 5
403:             .Top       = 43
404:             .Width     = 50
405:             .Height    = 15
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .BackStyle = 0
409:             .ForeColor = RGB(90, 90, 90)
410:             .Visible   = .T.
411:         ENDWITH
412: 
413:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
414:         WITH loc_oPagina.txt_4c_Codigos
415:             .Value         = ""
416:             .Left          = 57
417:             .Top           = 38
418:             .Width         = 65
419:             .Height        = 24
420:             .FontName      = "Tahoma"
421:             .FontSize      = 8
422:             .SpecialEffect = 1
423:             .MaxLength     = 10
424:             .InputMask     = "XXXXXXXXXX"
425:             .Visible       = .T.
426:         ENDWITH
427: 
428:         loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
429:         WITH loc_oPagina.lbl_4c_LblDescrs
430:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
431:             .Left      = 130
432:             .Top       = 43
433:             .Width     = 63
434:             .Height    = 15

*-- Linhas 499 a 557:
499:         ENDWITH
500: 
501:         *-- opt_4c_TpCods: 1=Empresa, 2=C/C
502:         loc_oPagina.AddObject("opt_4c_TpCods", "OptionGroup")
503:         WITH loc_oPagina.opt_4c_TpCods
504:             .ButtonCount  = 2
505:             .Left         = 48
506:             .Top          = 68
507:             .Width        = 130
508:             .Height       = 24
509:             .BorderStyle  = 0
510:             .Value        = 1
511:             .Visible      = .T.
512:             .Buttons(1).Caption = "Empresa"
513:             .Buttons(1).Width   = 65
514:             .Buttons(2).Caption = "C/C"
515:             .Buttons(2).Width   = 55
516:         ENDWITH
517:         BINDEVENT(loc_oPagina.opt_4c_TpCods, "InteractiveChange", THIS, "opt_4c_TpCods_InteractiveChange")
518: 
519:         *-- Digito (visivel somente quando TpCods=1)
520:         loc_oPagina.AddObject("lbl_4c_LblDigito", "Label")
521:         WITH loc_oPagina.lbl_4c_LblDigito
522:             .Caption   = "D" + CHR(237) + "gito :"
523:             .Left      = 183
524:             .Top       = 73
525:             .Width     = 50
526:             .Height    = 15
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8
529:             .BackStyle = 0
530:             .ForeColor = RGB(90, 90, 90)
531:             .Visible   = .T.
532:         ENDWITH
533: 
534:         loc_oPagina.AddObject("txt_4c_Digito", "TextBox")
535:         WITH loc_oPagina.txt_4c_Digito
536:             .Value         = ""
537:             .Left          = 236
538:             .Top           = 68
539:             .Width         = 25
540:             .Height        = 24
541:             .FontName      = "Tahoma"
542:             .FontSize      = 8
543:             .SpecialEffect = 1
544:             .MaxLength     = 1
545:             .Visible       = .T.
546:         ENDWITH
547: 
548:         *-- Classes (lookup SigCdCss via F4/LostFocus)
549:         loc_oPagina.AddObject("lbl_4c_LblClasses", "Label")
550:         WITH loc_oPagina.lbl_4c_LblClasses
551:             .Caption   = "Classe :"
552:             .Left      = 267
553:             .Top       = 73
554:             .Width     = 48
555:             .Height    = 15
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8

*-- Linhas 573 a 617:
573:             .MaxLength     = 10
574:             .Visible       = .T.
575:         ENDWITH
576:         BINDEVENT(loc_oPagina.txt_4c_Classes, "KeyPress", THIS, "txt_4c_Classes_KeyPress")
577:         BINDEVENT(loc_oPagina.txt_4c_Classes, "LostFocus", THIS, "txt_4c_Classes_LostFocus")
578: 
579:         *-- DClasses (display-only, derivado do lookup)
580:         loc_oPagina.AddObject("txt_4c_DClasses", "TextBox")
581:         WITH loc_oPagina.txt_4c_DClasses
582:             .Value         = ""
583:             .Left          = 394
584:             .Top           = 68
585:             .Width         = 185
586:             .Height        = 24
587:             .FontName      = "Tahoma"
588:             .FontSize      = 8
589:             .SpecialEffect = 1
590:             .Enabled       = .F.
591:             .Visible       = .T.
592:         ENDWITH
593: 
594:         *-- chk_4c_LimCrds - Verif. Limite Credito (chklimcrds N(1,0))
595:         loc_oPagina.AddObject("chk_4c_LimCrds", "CheckBox")
596:         WITH loc_oPagina.chk_4c_LimCrds
597:             .Caption   = "Verif. Limite Cr" + CHR(233) + "d."
598:             .Left      = 585
599:             .Top       = 68
600:             .Width     = 105
601:             .Height    = 20
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .BackStyle = 0
605:             .Visible   = .T.
606:         ENDWITH
607: 
608:         *-- chk_4c_LimEsts - Verif. Limite Estoque (chklimests N(1,0))
609:         loc_oPagina.AddObject("chk_4c_LimEsts", "CheckBox")
610:         WITH loc_oPagina.chk_4c_LimEsts
611:             .Caption   = "Verif. Limite Est."
612:             .Left      = 695
613:             .Top       = 68
614:             .Width     = 115
615:             .Height    = 20
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8

*-- Linhas 637 a 802:
637:             .Visible   = .T.  && controlado por TpCods
638:         ENDWITH
639: 
640:         loc_oPagina.AddObject("opt_4c_TpEmps", "OptionGroup")
641:         WITH loc_oPagina.opt_4c_TpEmps
642:             .ButtonCount  = 2
643:             .Left         = 447
644:             .Top          = 68
645:             .Width        = 98
646:             .Height       = 23
647:             .BorderStyle  = 0
648:             .Value        = 1
649:             .Visible      = .T.  && controlado por TpCods
650:             .Buttons(1).Caption = "Sim"
651:             .Buttons(1).Width   = 49
652:             .Buttons(2).Caption = "N" + CHR(227) + "o"
653:             .Buttons(2).Width   = 49
654:         ENDWITH
655: 
656:         loc_oPagina.AddObject("lbl_4c_TpCads", "Label")
657:         WITH loc_oPagina.lbl_4c_TpCads
658:             .Caption   = "Tp.Cad. :"
659:             .Left      = 5
660:             .Top       = 98
661:             .Width     = 55
662:             .Height    = 15
663:             .FontName  = "Tahoma"
664:             .FontSize  = 8
665:             .BackStyle = 0
666:             .ForeColor = RGB(90, 90, 90)
667:             .Visible   = .T.
668:         ENDWITH
669: 
670:         loc_oPagina.AddObject("opt_4c_TpCads", "OptionGroup")
671:         WITH loc_oPagina.opt_4c_TpCads
672:             .ButtonCount  = 2
673:             .Left         = 63
674:             .Top          = 93
675:             .Width        = 150
676:             .Height       = 23
677:             .BorderStyle  = 0
678:             .Value        = 1
679:             .Visible      = .T.
680:             .Buttons(1).Caption = "Empresa"
681:             .Buttons(1).Width   = 75
682:             .Buttons(2).Caption = "C/C"
683:             .Buttons(2).Width   = 75
684:         ENDWITH
685: 
686:         *----------------------------------------------------------------------
687:         *-- Inner PageFrame - 4 abas (Geral, Cadastro, Estoque, Faturamento)
688:         *-- (Top=120, Left=5, Width=985, Height=447)
689:         *----------------------------------------------------------------------
690:         loc_oPagina.AddObject("pgf_4c_AbaDados", "PageFrame")
691:         WITH loc_oPagina.pgf_4c_AbaDados
692:             .Top       = 120
693:             .Left      = 5
694:             .Width     = 985
695:             .Height    = 447
696:             .PageCount = 4
697:             .Tabs      = .T.
698:             .Visible   = .T.
699: 
700:             .Page1.Caption = "Geral"
701:             .Page2.Caption = "Cadastro"
702:             .Page3.Caption = "Estoque"
703:             .Page4.Caption = "Faturamento"
704:         ENDWITH
705: 
706:         THIS.ConfigurarAbaGeral()
707:         THIS.ConfigurarAbaCadastro()
708:         THIS.ConfigurarAbaEstoque()
709:         THIS.ConfigurarAbaFaturamento()
710: 
711:         THIS.TornarControlesVisiveis(loc_oPagina)
712:     ENDPROC
713: 
714:     *--------------------------------------------------------------------------
715:     * CriarLabel - Helper: adiciona Label padrao ao container
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE CriarLabel(par_oParent, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth)
718:         par_oParent.AddObject(par_cNome, "Label")
719:         WITH par_oParent.Controls(par_oParent.ControlCount)
720:             .Caption   = par_cCaption
721:             .Left      = par_nLeft
722:             .Top       = par_nTop
723:             .Width     = par_nWidth
724:             .Height    = 15
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackStyle = 0
728:             .ForeColor = RGB(90, 90, 90)
729:         ENDWITH
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     * CriarOptSimNao - Helper: adiciona OptionGroup 2-botoes Sim/Nao
734:     *--------------------------------------------------------------------------
735:     PROTECTED PROCEDURE CriarOptSimNao(par_oParent, par_cNome, par_nLeft, par_nTop, par_nWidth, par_nDefault)
736:         LOCAL loc_nBtnW
737:         loc_nBtnW = INT(par_nWidth / 2)
738:         par_oParent.AddObject(par_cNome, "OptionGroup")
739:         WITH par_oParent.Controls(par_oParent.ControlCount)
740:             .ButtonCount  = 2
741:             .Left         = par_nLeft
742:             .Top          = par_nTop
743:             .Width        = par_nWidth
744:             .Height       = 23
745:             .FontName     = "Tahoma"
746:             .FontSize     = 8
747:             .BorderStyle  = 0
748:             .BackStyle    = 0
749:             .Value        = par_nDefault
750:             .Buttons(1).Caption = "Sim"
751:             .Buttons(1).Width   = loc_nBtnW
752:             .Buttons(2).Caption = "N" + CHR(227) + "o"
753:             .Buttons(2).Width   = par_nWidth - loc_nBtnW
754:         ENDWITH
755:     ENDPROC
756: 
757:     *--------------------------------------------------------------------------
758:     * CriarContainerFiscal - Helper: container com 5 campos fiscais
759:     * Estrutura: lbl_4c_TaxNome, txt_4c_CdGrupos, txt_4c_CdContas,
760:     *            txt_4c_DsContas(disabled), txt_4c_PctAliqs, txt_4c_Receitas
761:     *--------------------------------------------------------------------------
762:     PROTECTED PROCEDURE CriarContainerFiscal(par_oAba, par_cNome, par_cLabel, par_nTop)
763:         LOCAL loc_oCnt
764:         par_oAba.AddObject(par_cNome, "Container")
765:         loc_oCnt = par_oAba.Controls(par_oAba.ControlCount)
766:         WITH loc_oCnt
767:             .Top         = par_nTop
768:             .Left        = 18
769:             .Width       = 673
770:             .Height      = 25
771:             .BackStyle   = 0
772:             .BorderWidth = 0
773:         ENDWITH
774: 
775:         loc_oCnt.AddObject("lbl_4c_TaxNome", "Label")
776:         WITH loc_oCnt.lbl_4c_TaxNome
777:             .Caption   = par_cLabel
778:             .Left      = 10
779:             .Top       = 5
780:             .Width     = 55
781:             .Height    = 15
782:             .FontName  = "Tahoma"
783:             .FontSize  = 8
784:             .BackStyle = 0
785:             .ForeColor = RGB(90, 90, 90)
786:         ENDWITH
787: 
788:         loc_oCnt.AddObject("txt_4c_CdGrupos", "TextBox")
789:         WITH loc_oCnt.txt_4c_CdGrupos
790:             .Value         = ""
791:             .Left          = 66
792:             .Top           = 2
793:             .Width         = 80
794:             .Height        = 21
795:             .FontName      = "Tahoma"
796:             .FontSize      = 8
797:             .SpecialEffect = 1
798:             .MaxLength     = 20
799:         ENDWITH
800: 
801:         loc_oCnt.AddObject("txt_4c_CdContas", "TextBox")
802:         WITH loc_oCnt.txt_4c_CdContas

*-- Linhas 853 a 1139:
853:         ENDWITH
854: 
855:         *-- Lookups F4 para CdGrupos e CdContas + LostFocus para validacao
856:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "GotFocus",  THIS, "FiscalGotFocus")
857:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "KeyPress",  THIS, "FiscalCdGruposKeyPress")
858:         BINDEVENT(loc_oCnt.txt_4c_CdGrupos, "LostFocus", THIS, "FiscalCdGruposLostFocus")
859:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "GotFocus",  THIS, "FiscalGotFocus")
860:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "KeyPress",  THIS, "FiscalCdContasKeyPress")
861:         BINDEVENT(loc_oCnt.txt_4c_CdContas, "LostFocus", THIS, "FiscalCdContasLostFocus")
862:     ENDPROC
863: 
864:     *--------------------------------------------------------------------------
865:     * ConfigurarAbaGeral - Controles da Aba 1 (Geral)
866:     * Col.Esq: Comple/Pessoais/RefBancs/FollowUp/Fiscais/DadosCom/Respos/LimCre/Comi
867:     * Col.Dir: Empresa/Contabs/Caracts/Perfil/Cargos/ChkLimCr/PreCad + Coletor
868:     * Inferior: GrupoGeral, VrLimCre, CdMoeda, DsMoeda, RodRelCC
869:     *--------------------------------------------------------------------------
870:     PROTECTED PROCEDURE ConfigurarAbaGeral()
871:         LOCAL loc_oAba
872:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
873: 
874:         *== Coluna Esquerda (labels left~27-103, opts left=128) ==================
875:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComple",   "Complemento :",                   56, 22,  74)
876:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComple",   128, 18, 97, 2)
877: 
878:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPessoais", "Dados Pessoais :",                 47, 48,  83)
879:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPessoais",  128, 44, 97, 2)
880: 
881:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRefBancs", "Ref. Banc" + CHR(225) + "rias :", 51, 74,  79)
882:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRefBancs",  128, 70, 97, 2)
883: 
884:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFollowUp", "Follow-Up :",                     74, 101, 56)
885:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFollowUp",  128, 97, 97, 2)
886: 
887:         THIS.CriarLabel(loc_oAba, "lbl_4c_GFiscais",  "Dados Fiscais :",                 57, 127, 73)
888:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFiscais",   128, 123, 97, 2)
889: 
890:         THIS.CriarLabel(loc_oAba, "lbl_4c_GDadosCom", "Dados Comerciais :",              37, 153, 93)
891:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptDadosCom",  128, 149, 97, 2)
892: 
893:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRespos", ;
894:             "Possui Respons" + CHR(225) + "vel :",             27, 178, 103)
895:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRespos",    128, 174, 97, 2)
896: 
897:         *-- Limite de Credito (3 botoes)
898:         THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCre", ;
899:             "Limite de Cr" + CHR(233) + "dito :",              41, 202, 89)
900:         loc_oAba.AddObject("opt_4c_OptLimCre", "OptionGroup")
901:         WITH loc_oAba.opt_4c_OptLimCre
902:             .ButtonCount  = 3
903:             .Left         = 126
904:             .Top          = 197
905:             .Width        = 225
906:             .Height       = 25
907:             .BorderStyle  = 0
908:             .Value        = 1
909:             .Buttons(1).Caption = "Sim"
910:             .Buttons(1).Width   = 70
911:             .Buttons(2).Caption = "N" + CHR(227) + "o"
912:             .Buttons(2).Width   = 70
913:             .Buttons(3).Caption = "Sim-Saldo"
914:             .Buttons(3).Width   = 85
915:         ENDWITH
916: 
917:         THIS.CriarLabel(loc_oAba, "lbl_4c_GComi", ;
918:             "Comiss" + CHR(227) + "o :",                       76, 229, 54)
919:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptComi",      128, 225, 97, 2)
920: 
921:         *== Coluna Direita (labels left~411-501, opts left=533) ==================
922:         THIS.CriarLabel(loc_oAba, "lbl_4c_GEmpresa",  "Dados da Empresa :",             436, 22,  98)
923:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEmpresa",   533, 18, 97, 2)
924: 
925:         THIS.CriarLabel(loc_oAba, "lbl_4c_GContabs", ;
926:             "Dados Cont" + CHR(225) + "beis :",               444, 48,  90)
927:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptContabs",   533, 44, 97, 2)
928: 
929:         THIS.CriarLabel(loc_oAba, "lbl_4c_GCaract", ;
930:             "Caracter" + CHR(237) + "sticas :",               454, 74,  80)
931:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCaract",    533, 70, 97, 2)
932: 
933:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPerfil",   "Perfil :",                       501, 127, 33)
934:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPerfil",    533, 123, 97, 2)
935: 
936:         THIS.CriarLabel(loc_oAba, "lbl_4c_GCargos",   "Cargos :",                       491, 153, 43)
937:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCargos",    533, 149, 97, 2)
938: 
939:         THIS.CriarLabel(loc_oAba, "lbl_4c_GChkLimCr", ;
940:             "Checa Limite Cr" + CHR(233) + "dito :",          427, 178, 107)
941:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimCrG", 533, 174, 97, 2)
942: 
943:         *== Extrema Direita: Grupo Padrao (Coletor, 11 botoes) ==================
944:         THIS.CriarLabel(loc_oAba, "lbl_4c_GColetor", ;
945:             "Grupo Padr" + CHR(227) + "o :",                  706, 22,  75)
946:         loc_oAba.AddObject("opt_4c_OptColetor", "OptionGroup")
947:         WITH loc_oAba.opt_4c_OptColetor
948:             .ButtonCount  = 11
949:             .Left         = 780
950:             .Top          = 15
951:             .Width        = 141
952:             .Height       = 210
953:             .BorderStyle  = 0
954:             .Value        = 1
955:             .Buttons(1).Caption  = " 1"
956:             .Buttons(2).Caption  = " 2"
957:             .Buttons(3).Caption  = " 3"
958:             .Buttons(4).Caption  = " 4"
959:             .Buttons(5).Caption  = " 5"
960:             .Buttons(6).Caption  = " 6"
961:             .Buttons(7).Caption  = " 7"
962:             .Buttons(8).Caption  = " 8"
963:             .Buttons(9).Caption  = " 9"
964:             .Buttons(10).Caption = "10"
965:             .Buttons(11).Caption = "11"
966:         ENDWITH
967: 
968:         *-- Pre Cadastro
969:         THIS.CriarLabel(loc_oAba, "lbl_4c_GPreCad", ;
970:             "Pr" + CHR(233) + " Cadastro :",                  709, 229, 72)
971:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPreCad",    780, 225, 97, 2)
972: 
973:         *== Secao inferior: Limite Credito Grupo/Vr/Moeda ========================
974:         THIS.CriarLabel(loc_oAba, "lbl_4c_GLimCrGVM", ;
975:             "Lim.Cr" + CHR(233) + "dito Grupo/Vr/Moeda :",   389, 204, 145)
976: 
977:         loc_oAba.AddObject("txt_4c_GrupoGeral", "TextBox")
978:         WITH loc_oAba.txt_4c_GrupoGeral
979:             .Value         = ""
980:             .Left          = 536
981:             .Top           = 199
982:             .Width         = 97
983:             .Height        = 23
984:             .FontName      = "Tahoma"
985:             .FontSize      = 8
986:             .SpecialEffect = 1
987:             .MaxLength     = 20
988:         ENDWITH
989:         BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "KeyPress",  THIS, "txt_4c_GrupoGeral_KeyPress")
990:         BINDEVENT(loc_oAba.txt_4c_GrupoGeral, "LostFocus", THIS, "txt_4c_GrupoGeral_LostFocus")
991: 
992:         loc_oAba.AddObject("txt_4c_VrLimCre", "TextBox")
993:         WITH loc_oAba.txt_4c_VrLimCre
994:             .Value         = 0
995:             .Left          = 636
996:             .Top           = 199
997:             .Width         = 110
998:             .Height        = 23
999:             .FontName      = "Tahoma"
1000:             .FontSize      = 8
1001:             .SpecialEffect = 1
1002:         ENDWITH
1003: 
1004:         THIS.CriarLabel(loc_oAba, "lbl_4c_GMoeda", ;
1005:             "Moeda da Comiss" + CHR(227) + "o :",             430, 229, 107)
1006: 
1007:         loc_oAba.AddObject("txt_4c_CdMoeda", "TextBox")
1008:         WITH loc_oAba.txt_4c_CdMoeda
1009:             .Value         = ""
1010:             .Left          = 536
1011:             .Top           = 225
1012:             .Width         = 32
1013:             .Height        = 23
1014:             .FontName      = "Tahoma"
1015:             .FontSize      = 8
1016:             .SpecialEffect = 1
1017:             .MaxLength     = 10
1018:         ENDWITH
1019:         BINDEVENT(loc_oAba.txt_4c_CdMoeda, "KeyPress",  THIS, "txt_4c_CdMoeda_KeyPress")
1020:         BINDEVENT(loc_oAba.txt_4c_CdMoeda, "LostFocus", THIS, "txt_4c_CdMoeda_LostFocus")
1021: 
1022:         loc_oAba.AddObject("txt_4c_DsMoeda", "TextBox")
1023:         WITH loc_oAba.txt_4c_DsMoeda
1024:             .Value         = ""
1025:             .Left          = 570
1026:             .Top           = 225
1027:             .Width         = 130
1028:             .Height        = 23
1029:             .FontName      = "Tahoma"
1030:             .FontSize      = 8
1031:             .SpecialEffect = 1
1032:             .Enabled       = .F.
1033:         ENDWITH
1034: 
1035:         *== Rodape Relatorio Conta Corrente =====================================
1036:         THIS.CriarLabel(loc_oAba, "lbl_4c_GRodape", ;
1037:             "Rod" + CHR(225) + "p" + CHR(233) + " do Relat" + CHR(243) + ;
1038:             "rio de Conta Corrente",                          165, 263, 220)
1039: 
1040:         loc_oAba.AddObject("edt_4c_RodRelCC", "EditBox")
1041:         WITH loc_oAba.edt_4c_RodRelCC
1042:             .Value         = ""
1043:             .Left          = 165
1044:             .Top           = 280
1045:             .Width         = 788
1046:             .Height        = 117
1047:             .FontName      = "Tahoma"
1048:             .FontSize      = 8
1049:             .SpecialEffect = 1
1050:             .ScrollBars    = 2
1051:         ENDWITH
1052:     ENDPROC
1053: 
1054:     *--------------------------------------------------------------------------
1055:     * ConfigurarAbaCadastro - Controles da Aba 2 (Cadastro/Financeiro)
1056:     * Col.Esq: CPFObrig/RG/CEP/CalcIMeds/ObrMails/ObrNome/ObrSit/ObrTlm/
1057:     *          ObrCla/ObrSeg/ObrIbge/FpublSobr/NascObrig
1058:     * Col.Dir: RestEnd/CntVinc/DupEnd/MFotos/Observacao/CpfFixo/Situacao/
1059:     *          CaracCad/AceJob/CCustoTit/LogAlt/InfSenha
1060:     * Financeiro: Contint/IntegCont/PadPreench/VincContas/TitBaixado
1061:     *--------------------------------------------------------------------------
1062:     PROTECTED PROCEDURE ConfigurarAbaCadastro()
1063:         LOCAL loc_oAba
1064:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
1065: 
1066:         THIS.CriarLabel(loc_oAba, "lbl_4c_CadHeader", ;
1067:             "Cadastro de Contas",                              29, 14, 120)
1068: 
1069:         *-- CPF/CNPJ Obrigatorio (4 botoes)
1070:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfObrig", ;
1071:             "CPF / CNPJ Obrigat" + CHR(243) + "rio :",        73, 32, 120)
1072:         loc_oAba.AddObject("opt_4c_CpfObrig", "OptionGroup")
1073:         WITH loc_oAba.opt_4c_CpfObrig
1074:             .ButtonCount  = 4
1075:             .Left         = 192
1076:             .Top          = 29
1077:             .Width        = 284
1078:             .Height       = 23
1079:             .BorderStyle  = 0
1080:             .Value        = 1
1081:             .Buttons(1).Caption = "N" + CHR(227) + "o"
1082:             .Buttons(1).Width   = 64
1083:             .Buttons(2).Caption = "Sim"
1084:             .Buttons(2).Width   = 64
1085:             .Buttons(3).Caption = "Sim-Dupla"
1086:             .Buttons(3).Width   = 80
1087:             .Buttons(4).Caption = "N" + CHR(227) + "o-Dupla"
1088:             .Buttons(4).Width   = 76
1089:         ENDWITH
1090: 
1091:         *-- RG/IE Obrigatorio
1092:         THIS.CriarLabel(loc_oAba, "lbl_4c_CRgObrig", ;
1093:             "RG / IE Obrigat" + CHR(243) + "rio :",           93, 53, 100)
1094:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_RgObrig",       192, 50, 115, 2)
1095: 
1096:         *-- CEP Obrigatorio (3 botoes)
1097:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCepObrig", ;
1098:             "CEP Obrigat" + CHR(243) + "rio :",               108, 76, 85)
1099:         loc_oAba.AddObject("opt_4c_CepObrig", "OptionGroup")
1100:         WITH loc_oAba.opt_4c_CepObrig
1101:             .ButtonCount  = 3
1102:             .Left         = 191
1103:             .Top          = 70
1104:             .Width        = 201
1105:             .Height       = 25
1106:             .BorderStyle  = 0
1107:             .Value        = 1
1108:             .Buttons(1).Caption = "N" + CHR(227) + "o"
1109:             .Buttons(1).Width   = 60
1110:             .Buttons(2).Caption = "Sim"
1111:             .Buttons(2).Width   = 60
1112:             .Buttons(3).Caption = "Sim-Buscar"
1113:             .Buttons(3).Width   = 81
1114:         ENDWITH
1115: 
1116:         *-- Calc.IMedias
1117:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCalcIMeds", ;
1118:             "Calc. I.M" + CHR(233) + "dias :",                108, 95, 85)
1119:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CalcIMeds",     191, 92, 97, 2)
1120: 
1121:         *-- eMail Obrigatorio
1122:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrMails", ;
1123:             "e-Mail Obrigat" + CHR(243) + "rio :",             99, 120, 94)
1124:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrMails",      191, 115, 97, 2)
1125: 
1126:         *-- Nome Obrigatorio
1127:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrNome", ;
1128:             "Nome Obrigat" + CHR(243) + "rio :",              100, 141, 93)
1129:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrNome",       191, 137, 97, 2)
1130: 
1131:         *-- Situacao Obrigatoria
1132:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrSit", ;
1133:             "Situa" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria :", 86, 164, 107)
1134:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrSit",        191, 159, 97, 2)
1135: 
1136:         *-- Telemarketing Obrigatorio
1137:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObrTlm", ;
1138:             "Telemarketing Obrigat" + CHR(243) + "rio :",      60, 186, 133)
1139:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObrTlm",        190, 181, 97, 2)

*-- Linhas 1187 a 1445:
1187:         *-- Observacao (3 botoes, height=63)
1188:         THIS.CriarLabel(loc_oAba, "lbl_4c_CObservacao", ;
1189:             "Observa" + CHR(231) + CHR(227) + "o :",          621, 115, 67)
1190:         loc_oAba.AddObject("opt_4c_Observacao", "OptionGroup")
1191:         WITH loc_oAba.opt_4c_Observacao
1192:             .ButtonCount  = 3
1193:             .Left         = 689
1194:             .Top          = 115
1195:             .Width        = 115
1196:             .Height       = 63
1197:             .BorderStyle  = 0
1198:             .Value        = 1
1199:             .Buttons(1).Caption = "N" + CHR(227) + "o Mostrar"
1200:             .Buttons(1).Width   = 112
1201:             .Buttons(2).Caption = "Sempre"
1202:             .Buttons(2).Width   = 112
1203:             .Buttons(3).Caption = "Mostrar Bot" + CHR(227) + "o"
1204:             .Buttons(3).Width   = 112
1205:         ENDWITH
1206: 
1207:         *-- CPF/CNPJ Fixo (3 botoes)
1208:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCpfFixo", ;
1209:             "CPF / CNPJ Fixo :",                              602, 167, 86)
1210:         loc_oAba.AddObject("opt_4c_CpfFixo", "OptionGroup")
1211:         WITH loc_oAba.opt_4c_CpfFixo
1212:             .ButtonCount  = 3
1213:             .Left         = 690
1214:             .Top          = 164
1215:             .Width        = 167
1216:             .Height       = 23
1217:             .BorderStyle  = 0
1218:             .Value        = 1
1219:             .Buttons(1).Caption = "CPF"
1220:             .Buttons(1).Width   = 50
1221:             .Buttons(2).Caption = "CNPJ"
1222:             .Buttons(2).Width   = 50
1223:             .Buttons(3).Caption = "Ambos"
1224:             .Buttons(3).Width   = 67
1225:         ENDWITH
1226: 
1227:         *-- Situacao Padrao (textbox + lookup)
1228:         THIS.CriarLabel(loc_oAba, "lbl_4c_CSituacao", ;
1229:             "Situa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :", 601, 189, 90)
1230:         loc_oAba.AddObject("txt_4c_Situas", "TextBox")
1231:         WITH loc_oAba.txt_4c_Situas
1232:             .Value         = ""
1233:             .Left          = 693
1234:             .Top           = 185
1235:             .Width         = 32
1236:             .Height        = 23
1237:             .FontName      = "Tahoma"
1238:             .FontSize      = 8
1239:             .SpecialEffect = 1
1240:             .MaxLength     = 10
1241:         ENDWITH
1242:         BINDEVENT(loc_oAba.txt_4c_Situas, "KeyPress",  THIS, "txt_4c_Situas_KeyPress")
1243:         BINDEVENT(loc_oAba.txt_4c_Situas, "LostFocus", THIS, "txt_4c_Situas_LostFocus")
1244: 
1245:         *-- Caracteristica Cadastro
1246:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCaracCad", ;
1247:             "Caracter" + CHR(237) + "stica :",                613, 212, 75)
1248:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CaracCad",      688, 208, 115, 2)
1249: 
1250:         *-- Acesso Job
1251:         THIS.CriarLabel(loc_oAba, "lbl_4c_CAceJob",   "Acesso Job :",               625, 233, 63)
1252:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_AceJob",        688, 229, 115, 2)
1253: 
1254:         *-- Habilita Centro de Custos Titulos
1255:         THIS.CriarLabel(loc_oAba, "lbl_4c_CCCustoTit", ;
1256:             "Habilita Centro de Custos nos T" + CHR(237) + "tulos :", 503, 254, 185)
1257:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_CCustoTit",     687, 249, 97, 2)
1258: 
1259:         *-- Log de Alteracoes
1260:         THIS.CriarLabel(loc_oAba, "lbl_4c_CLogAlt", ;
1261:             "Log de Altera" + CHR(231) + CHR(245) + "es :",  593, 276, 95)
1262:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_LogAlt",        688, 272, 115, 2)
1263: 
1264:         *-- Informar Senha na Alteracao
1265:         THIS.CriarLabel(loc_oAba, "lbl_4c_CInfSenha", ;
1266:             "Informar senha na Altera" + CHR(231) + CHR(227) + "o :", 541, 296, 147)
1267:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_InfSenha",      688, 292, 115, 2)
1268: 
1269:         *== Separador Financeiro ================================================
1270:         THIS.CriarLabel(loc_oAba, "lbl_4c_CFinHeader", "Financeiro", 29, 315, 60)
1271: 
1272:         *-- Conta Corrente Interna
1273:         THIS.CriarLabel(loc_oAba, "lbl_4c_CContint",  "Conta :",                    152, 324, 40)
1274:         loc_oAba.AddObject("txt_4c_Contint", "TextBox")
1275:         WITH loc_oAba.txt_4c_Contint
1276:             .Value         = ""
1277:             .Left          = 192
1278:             .Top           = 321
1279:             .Width         = 73
1280:             .Height        = 23
1281:             .FontName      = "Tahoma"
1282:             .FontSize      = 8
1283:             .SpecialEffect = 1
1284:             .MaxLength     = 20
1285:         ENDWITH
1286:         BINDEVENT(loc_oAba.txt_4c_Contint, "KeyPress",  THIS, "txt_4c_Contint_KeyPress")
1287:         BINDEVENT(loc_oAba.txt_4c_Contint, "LostFocus", THIS, "txt_4c_Contint_LostFocus")
1288: 
1289:         *-- Integracao Contabil (3 botoes)
1290:         THIS.CriarLabel(loc_oAba, "lbl_4c_CIntegCont", ;
1291:             "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil :", 86, 348, 104)
1292:         loc_oAba.AddObject("opt_4c_IntegCont", "OptionGroup")
1293:         WITH loc_oAba.opt_4c_IntegCont
1294:             .ButtonCount  = 3
1295:             .Left         = 192
1296:             .Top          = 345
1297:             .Width        = 316
1298:             .Height       = 23
1299:             .BorderStyle  = 0
1300:             .Value        = 1
1301:             .Buttons(1).Caption = "N" + CHR(227) + "o"
1302:             .Buttons(1).Width   = 80
1303:             .Buttons(2).Caption = "Sim"
1304:             .Buttons(2).Width   = 80
1305:             .Buttons(3).Caption = "Sem ContraPartida"
1306:             .Buttons(3).Width   = 156
1307:         ENDWITH
1308: 
1309:         *-- Padrao Preenchimento (4 botoes)
1310:         THIS.CriarLabel(loc_oAba, "lbl_4c_CPadPreench", ;
1311:             "Padr" + CHR(227) + "o de Preenchimento :",       58, 369, 132)
1312:         loc_oAba.AddObject("opt_4c_PadPreench", "OptionGroup")
1313:         WITH loc_oAba.opt_4c_PadPreench
1314:             .ButtonCount  = 4
1315:             .Left         = 192
1316:             .Top          = 366
1317:             .Width        = 353
1318:             .Height       = 23
1319:             .BorderStyle  = 0
1320:             .Value        = 1
1321:             .Buttons(1).Caption = "Nenhum"
1322:             .Buttons(1).Width   = 70
1323:             .Buttons(2).Caption = "Pagamentos"
1324:             .Buttons(2).Width   = 90
1325:             .Buttons(3).Caption = "Recebimentos"
1326:             .Buttons(3).Width   = 100
1327:             .Buttons(4).Caption = "Ambos"
1328:             .Buttons(4).Width   = 93
1329:         ENDWITH
1330: 
1331:         *-- Vincula Contas no Pag/Rec
1332:         THIS.CriarLabel(loc_oAba, "lbl_4c_CVincContas", ;
1333:             "Vincula as Contas no Pag/Rec.:",                  38, 390, 152)
1334:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_VincContas",    192, 387, 181, 2)
1335: 
1336:         *-- Visualizar Titulos nao Baixados
1337:         THIS.CriarLabel(loc_oAba, "lbl_4c_CTitBaixado", ;
1338:             "Visualizar T" + CHR(237) + "tulos n" + CHR(227) + "o Baixados :", 36, 410, 154)
1339:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_TitBaixado",    192, 407, 181, 2)
1340:     ENDPROC
1341: 
1342:     *--------------------------------------------------------------------------
1343:     * ConfigurarAbaEstoque - Controles da Aba 3 (Estoque/Industria)
1344:     * Estoque: LimEsto/VerEst/EstPAcab/ChkLimEst/CCusto + Saldo/Relevante/BlqConGV/Patrim/TipoInvs
1345:     * Industria: GBals/DifPeso/Sinal/Tfalhas/GrupoEst + TrfPeso/GrupoFalha/ContaFalha
1346:     *            UnifBal/ContaPdr/FalPers/BlqDivOp/OsAlFuns/OsPend/Compagru/ObjDupTit/GetAgrupa
1347:     *--------------------------------------------------------------------------
1348:     PROTECTED PROCEDURE ConfigurarAbaEstoque()
1349:         LOCAL loc_oAba
1350:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
1351: 
1352:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstHeader", "Estoque", 21, 14, 47)
1353: 
1354:         *== Coluna Esquerda: Limite/Avalia/ProdAcabado/ChkLimEst/CCusto =========
1355:         THIS.CriarLabel(loc_oAba, "lbl_4c_ELimEsto", ;
1356:             "Limite de Estoque :",                             85, 35, 93)
1357:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptLimEsto",    174, 30, 92, 2)
1358: 
1359:         THIS.CriarLabel(loc_oAba, "lbl_4c_EVerEst",   "Avalia Estoque :",            99, 60, 80)
1360:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptVerEst",     174, 56, 92, 2)
1361: 
1362:         THIS.CriarLabel(loc_oAba, "lbl_4c_EEstPAcab", ;
1363:             "Estoque Produto Acabado :",                       45, 84, 134)
1364:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptEstPAcab",   174, 80, 92, 2)
1365: 
1366:         THIS.CriarLabel(loc_oAba, "lbl_4c_EChkLimEst", ;
1367:             "Checa Limite de Estoque:",                        55, 109, 124)
1368:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptChkLimEst",  174, 104, 92, 2)
1369: 
1370:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECCusto",   "Centro de Custos :",          86, 132, 93)
1371:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptCCustoEst",  174, 128, 92, 2)
1372: 
1373:         *== Coluna Direita: Saldo/Relevante/BlqConGV/Patrim/TipoInvs ===========
1374:         THIS.CriarLabel(loc_oAba, "lbl_4c_ESaldo", ;
1375:             "C" + CHR(225) + "lculo de Saldo :",              386, 35, 87)
1376:         loc_oAba.AddObject("opt_4c_OptSaldo", "OptionGroup")
1377:         WITH loc_oAba.opt_4c_OptSaldo
1378:             .ButtonCount  = 2
1379:             .Left         = 469
1380:             .Top          = 30
1381:             .Width        = 149
1382:             .Height       = 25
1383:             .BorderStyle  = 0
1384:             .Value        = 1
1385:             .Buttons(1).Caption = "Online"
1386:             .Buttons(1).Width   = 70
1387:             .Buttons(2).Caption = "Background"
1388:             .Buttons(2).Width   = 79
1389:         ENDWITH
1390: 
1391:         THIS.CriarLabel(loc_oAba, "lbl_4c_ERelevante", ;
1392:             "Empresa Relevante :",                            370, 60, 102)
1393:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptRelevante",  469, 56, 113, 2)
1394: 
1395:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqConGV", ;
1396:             "Bloqueia Consulta Vendas :",                     342, 85, 132)
1397:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqConGV",   469, 80, 113, 2)
1398: 
1399:         THIS.CriarLabel(loc_oAba, "lbl_4c_EPatrim", ;
1400:             "Patrimonial por Etiqueta :",                     351, 109, 123)
1401:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptPatrim",     469, 104, 113, 2)
1402: 
1403:         THIS.CriarLabel(loc_oAba, "lbl_4c_EInvTipo", ;
1404:             "Invent" + CHR(225) + "rio :",                   415, 132, 55)
1405:         loc_oAba.AddObject("opt_4c_OpTipoInvs", "OptionGroup")
1406:         WITH loc_oAba.opt_4c_OpTipoInvs
1407:             .ButtonCount  = 3
1408:             .Left         = 470
1409:             .Top          = 128
1410:             .Width        = 371
1411:             .Height       = 25
1412:             .BorderStyle  = 0
1413:             .Value        = 1
1414:             .Buttons(1).Caption = "Pr" + CHR(243) + "prio"
1415:             .Buttons(1).Width   = 100
1416:             .Buttons(2).Caption = "Pr" + CHR(243) + "prio Poder 3p"
1417:             .Buttons(2).Width   = 135
1418:             .Buttons(3).Caption = "Nos Meios 3p"
1419:             .Buttons(3).Width   = 136
1420:         ENDWITH
1421: 
1422:         *== DDR/DDF (far right) =================================================
1423:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDdR", ;
1424:             "Dias Bloqueio Retroativo :",                     723, 37, 127)
1425:         loc_oAba.AddObject("txt_4c_DdR", "TextBox")
1426:         WITH loc_oAba.txt_4c_DdR
1427:             .Value         = 0
1428:             .Left          = 852
1429:             .Top           = 33
1430:             .Width         = 45
1431:             .Height        = 23
1432:             .FontName      = "Tahoma"
1433:             .FontSize      = 8
1434:             .SpecialEffect = 1
1435:         ENDWITH
1436: 
1437:         THIS.CriarLabel(loc_oAba, "lbl_4c_EDdF", ;
1438:             "Dias Bloqueio Futuro :",                        742, 61, 112)
1439:         loc_oAba.AddObject("txt_4c_DdF", "TextBox")
1440:         WITH loc_oAba.txt_4c_DdF
1441:             .Value         = 0
1442:             .Left          = 852
1443:             .Top           = 57
1444:             .Width         = 45
1445:             .Height        = 23

*-- Linhas 1514 a 1664:
1514:             .SpecialEffect = 1
1515:             .MaxLength     = 20
1516:         ENDWITH
1517:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "KeyPress",  THIS, "txt_4c_GrupoEst_KeyPress")
1518:         BINDEVENT(loc_oAba.txt_4c_GrupoEst, "LostFocus", THIS, "txt_4c_GrupoEst_LostFocus")
1519: 
1520:         *-- Transfere Peso (5 botoes)
1521:         THIS.CriarLabel(loc_oAba, "lbl_4c_ETrfPeso",  "Transfere Peso :",            395, 219, 82)
1522:         loc_oAba.AddObject("opt_4c_ChkTrfPeso", "OptionGroup")
1523:         WITH loc_oAba.opt_4c_ChkTrfPeso
1524:             .ButtonCount  = 5
1525:             .Left         = 474
1526:             .Top          = 219
1527:             .Width        = 186
1528:             .Height       = 95
1529:             .BorderStyle  = 0
1530:             .Value        = 1
1531:             .Buttons(1).Caption = "1"
1532:             .Buttons(2).Caption = "2"
1533:             .Buttons(3).Caption = "3"
1534:             .Buttons(4).Caption = "4"
1535:             .Buttons(5).Caption = "5"
1536:         ENDWITH
1537: 
1538:         *== Grupo/Conta Falha ====================================================
1539:         THIS.CriarLabel(loc_oAba, "lbl_4c_EGrupoFalha", ;
1540:             "Grupo de Falha :",                              721, 199, 82)
1541:         loc_oAba.AddObject("txt_4c_GrupoFalha", "TextBox")
1542:         WITH loc_oAba.txt_4c_GrupoFalha
1543:             .Value         = ""
1544:             .Left          = 805
1545:             .Top           = 195
1546:             .Width         = 90
1547:             .Height        = 23
1548:             .FontName      = "Tahoma"
1549:             .FontSize      = 8
1550:             .SpecialEffect = 1
1551:             .MaxLength     = 20
1552:         ENDWITH
1553:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "KeyPress",  THIS, "txt_4c_GrupoFalha_KeyPress")
1554:         BINDEVENT(loc_oAba.txt_4c_GrupoFalha, "LostFocus", THIS, "txt_4c_GrupoFalha_LostFocus")
1555: 
1556:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaFalha", ;
1557:             "Conta de Falha :",                              721, 224, 82)
1558:         loc_oAba.AddObject("txt_4c_ContaFalha", "TextBox")
1559:         WITH loc_oAba.txt_4c_ContaFalha
1560:             .Value         = ""
1561:             .Left          = 805
1562:             .Top           = 220
1563:             .Width         = 90
1564:             .Height        = 23
1565:             .FontName      = "Tahoma"
1566:             .FontSize      = 8
1567:             .SpecialEffect = 1
1568:             .MaxLength     = 20
1569:         ENDWITH
1570:         BINDEVENT(loc_oAba.txt_4c_ContaFalha, "KeyPress",  THIS, "txt_4c_ContaFalha_KeyPress")
1571:         BINDEVENT(loc_oAba.txt_4c_ContaFalha, "LostFocus", THIS, "txt_4c_ContaFalha_LostFocus")
1572: 
1573:         loc_oAba.AddObject("txt_4c_DsContaFalha", "TextBox")
1574:         WITH loc_oAba.txt_4c_DsContaFalha
1575:             .Value         = ""
1576:             .Left          = 897
1577:             .Top           = 220
1578:             .Width         = 59
1579:             .Height        = 23
1580:             .FontName      = "Tahoma"
1581:             .FontSize      = 8
1582:             .SpecialEffect = 1
1583:             .Enabled       = .F.
1584:         ENDWITH
1585: 
1586:         *== Balanco Unificado (4 botoes) =========================================
1587:         THIS.CriarLabel(loc_oAba, "lbl_4c_EUnifBal", ;
1588:             "Balan" + CHR(231) + "o Unificado :",             83, 249, 93)
1589:         loc_oAba.AddObject("opt_4c_OptUnifBal", "OptionGroup")
1590:         WITH loc_oAba.opt_4c_OptUnifBal
1591:             .ButtonCount  = 4
1592:             .Left         = 174
1593:             .Top          = 245
1594:             .Width        = 171
1595:             .Height       = 43
1596:             .BorderStyle  = 0
1597:             .Value        = 1
1598:             .Buttons(1).Caption = "N" + CHR(227) + "o"
1599:             .Buttons(1).Width   = 42
1600:             .Buttons(2).Caption = "Sim"
1601:             .Buttons(2).Width   = 42
1602:             .Buttons(3).Caption = "Parcial"
1603:             .Buttons(3).Width   = 43
1604:             .Buttons(4).Caption = "Total"
1605:             .Buttons(4).Width   = 44
1606:         ENDWITH
1607: 
1608:         *== Conta Padrao =========================================================
1609:         THIS.CriarLabel(loc_oAba, "lbl_4c_EContaPdr", ;
1610:             "Conta Padr" + CHR(227) + "o :",                 728, 250, 75)
1611:         loc_oAba.AddObject("txt_4c_ContaPdr", "TextBox")
1612:         WITH loc_oAba.txt_4c_ContaPdr
1613:             .Value         = ""
1614:             .Left          = 805
1615:             .Top           = 246
1616:             .Width         = 90
1617:             .Height        = 23
1618:             .FontName      = "Tahoma"
1619:             .FontSize      = 8
1620:             .SpecialEffect = 1
1621:             .MaxLength     = 20
1622:         ENDWITH
1623:         BINDEVENT(loc_oAba.txt_4c_ContaPdr, "KeyPress",  THIS, "txt_4c_ContaPdr_KeyPress")
1624:         BINDEVENT(loc_oAba.txt_4c_ContaPdr, "LostFocus", THIS, "txt_4c_ContaPdr_LostFocus")
1625: 
1626:         loc_oAba.AddObject("txt_4c_DsContaPdr", "TextBox")
1627:         WITH loc_oAba.txt_4c_DsContaPdr
1628:             .Value         = ""
1629:             .Left          = 896
1630:             .Top           = 246
1631:             .Width         = 59
1632:             .Height        = 23
1633:             .FontName      = "Tahoma"
1634:             .FontSize      = 8
1635:             .SpecialEffect = 1
1636:             .Enabled       = .F.
1637:         ENDWITH
1638: 
1639:         *== Balanco Falhas/Perdas ================================================
1640:         THIS.CriarLabel(loc_oAba, "lbl_4c_EFalPers", ;
1641:             "Balan" + CHR(231) + "o Falhas/Perdas :",         61, 293, 117)
1642:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptFalPers",    174, 288, 92, 2)
1643: 
1644:         *== Bloqueia Divisao OF ==================================================
1645:         THIS.CriarLabel(loc_oAba, "lbl_4c_EBlqDivOp", ;
1646:             "Bloqueia Divis" + CHR(227) + "o de OF :",        59, 318, 118)
1647:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_OptBlqDivOp",   174, 314, 92, 2)
1648: 
1649:         *== Container Resumo de Composicao (Os/Alianca/Fundicao) ================
1650:         loc_oAba.AddObject("cnt_4c_OsAlFuns", "Container")
1651:         WITH loc_oAba.cnt_4c_OsAlFuns
1652:             .Top         = 311
1653:             .Left        = 324
1654:             .Width       = 347
1655:             .Height      = 27
1656:             .BackStyle   = 0
1657:             .BorderWidth = 0
1658:             .Visible     = .T.
1659:         ENDWITH
1660: 
1661:         loc_oAba.cnt_4c_OsAlFuns.AddObject("lbl_4c_ResComp", "Label")
1662:         WITH loc_oAba.cnt_4c_OsAlFuns.lbl_4c_ResComp
1663:             .Caption   = "Resumo de Composi" + CHR(231) + CHR(227) + "o :"
1664:             .Left      = 30

*-- Linhas 1718 a 1901:
1718:         *== Agrupa Componentes (3 botoes) ========================================
1719:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECompagru", ;
1720:             "Agrupa Componentes :",                           364, 341, 109)
1721:         loc_oAba.AddObject("opt_4c_OpCompagru", "OptionGroup")
1722:         WITH loc_oAba.opt_4c_OpCompagru
1723:             .ButtonCount  = 3
1724:             .Left         = 474
1725:             .Top          = 340
1726:             .Width        = 186
1727:             .Height       = 21
1728:             .BorderStyle  = 0
1729:             .Value        = 1
1730:             .Buttons(1).Caption = "Sim"
1731:             .Buttons(1).Width   = 55
1732:             .Buttons(2).Caption = "N" + CHR(227) + "o"
1733:             .Buttons(2).Width   = 55
1734:             .Buttons(3).Caption = "Mat. Principal"
1735:             .Buttons(3).Width   = 76
1736:         ENDWITH
1737: 
1738:         *== Checa Duplicidade de Titulo ==========================================
1739:         THIS.CriarLabel(loc_oAba, "lbl_4c_EObjDupTit", ;
1740:             "Checa Duplicidade de T" + CHR(237) + "tulo:",    41, 369, 137)
1741:         THIS.CriarOptSimNao(loc_oAba, "opt_4c_ObjDupTit",     174, 364, 92, 2)
1742: 
1743:         *== Agrupamento ==========================================================
1744:         THIS.CriarLabel(loc_oAba, "lbl_4c_EAgrupa",   "Agrupamento:",               406, 369, 75)
1745:         loc_oAba.AddObject("txt_4c_GetAgrupa", "TextBox")
1746:         WITH loc_oAba.txt_4c_GetAgrupa
1747:             .Value         = ""
1748:             .Left          = 480
1749:             .Top           = 365
1750:             .Width         = 150
1751:             .Height        = 23
1752:             .FontName      = "Tahoma"
1753:             .FontSize      = 8
1754:             .SpecialEffect = 1
1755:             .MaxLength     = 20
1756:         ENDWITH
1757: 
1758:         *== Controle de Lote (3 botoes) ==========================================
1759:         THIS.CriarLabel(loc_oAba, "lbl_4c_ECtrlLote", ;
1760:             "Controle de Lote :",                             388, 396, 88)
1761:         loc_oAba.AddObject("opt_4c_CtrlLotes", "OptionGroup")
1762:         WITH loc_oAba.opt_4c_CtrlLotes
1763:             .ButtonCount  = 3
1764:             .Left         = 474
1765:             .Top          = 393
1766:             .Width        = 164
1767:             .Height       = 21
1768:             .BorderStyle  = 0
1769:             .Value        = 1
1770:             .Buttons(1).Caption = "Sim"
1771:             .Buttons(1).Width   = 48
1772:             .Buttons(2).Caption = "N" + CHR(227) + "o"
1773:             .Buttons(2).Width   = 48
1774:             .Buttons(3).Caption = "M" + CHR(250) + "ltiplos"
1775:             .Buttons(3).Width   = 68
1776:         ENDWITH
1777:     ENDPROC
1778: 
1779:     *--------------------------------------------------------------------------
1780:     * ConfigurarAbaFaturamento - Controles da Aba 4 (Faturamento/Fiscal)
1781:     * 9 containers fiscais: ICMS/IPI/II/ISS/IRRF/INSS/PIS/CSSL/COFINS
1782:     * Cada container: lbl(nome), CdGrupos, CdContas, DsContas, PctAliqs, Receitas
1783:     *--------------------------------------------------------------------------
1784:     PROTECTED PROCEDURE ConfigurarAbaFaturamento()
1785:         LOCAL loc_oAba
1786:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4
1787: 
1788:         *-- Headers
1789:         THIS.CriarLabel(loc_oAba, "lbl_4c_FImposto",  "Impostos",                    22, 33, 60)
1790:         THIS.CriarLabel(loc_oAba, "lbl_4c_FGrupo",    "Grupo",                       104, 33, 40)
1791:         THIS.CriarLabel(loc_oAba, "lbl_4c_FConta", ;
1792:             "Conta e Descri" + CHR(231) + CHR(227) + "o",    301, 33, 120)
1793:         THIS.CriarLabel(loc_oAba, "lbl_4c_FAliqs", ;
1794:             "Al" + CHR(237) + "quota",                        552, 33, 50)
1795:         THIS.CriarLabel(loc_oAba, "lbl_4c_FReceita",  "Receita",                     623, 33, 50)
1796: 
1797:         *-- 9 containers fiscais (mesma estrutura, tops sequenciais)
1798:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ICMS", "ICMS",   52)
1799:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IPI",  "IPI",    78)
1800:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_II",   "II",    104)
1801:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_ISS",  "ISS",   130)
1802:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_IRRF", "IRRF",  156)
1803:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_INSS", "INSS",  182)
1804:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_PIS",  "PIS",   207)
1805:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_CSL",  "CSSL",  233)
1806:         THIS.CriarContainerFiscal(loc_oAba, "cnt_4c_COF",  "COFINS",259)
1807:     ENDPROC
1808: 
1809:     *--------------------------------------------------------------------------
1810:     * CarregarLista - Carrega registros no grid da lista
1811:     * Colunas: Codigos(80), Descrs(300), Internos(120), TpCods(60), DClasses(300)
1812:     *--------------------------------------------------------------------------
1813:     PROCEDURE CarregarLista()
1814:         LOCAL loc_oGrid, loc_lResultado
1815:         loc_lResultado = .F.
1816: 
1817:         TRY
1818:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1819: 
1820:             IF !THIS.this_oBusinessObject.Buscar("")
1821:                 loc_lResultado = .F.
1822:             ELSE
1823:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1824: 
1825:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1826:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1827:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Internos"
1828:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.TpCods"
1829:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DClasses"
1830: 
1831:                 loc_oGrid.Column1.Width = 80
1832:                 loc_oGrid.Column2.Width = 300
1833:                 loc_oGrid.Column3.Width = 120
1834:                 loc_oGrid.Column4.Width = 60
1835:                 loc_oGrid.Column5.Width = 300
1836: 
1837:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1838:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1839:                 loc_oGrid.Column3.Header1.Caption = "Interno"
1840:                 loc_oGrid.Column4.Header1.Caption = "Tipo"
1841:                 loc_oGrid.Column5.Header1.Caption = "Classe"
1842: 
1843:                 THIS.FormatarGridLista(loc_oGrid)
1844:                 loc_lResultado = .T.
1845:             ENDIF
1846: 
1847:         CATCH TO loException
1848:             MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
1849:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1850:                 loException.Message, "Erro")
1851:             loc_lResultado = .F.
1852:         ENDTRY
1853: 
1854:         RETURN loc_lResultado
1855:     ENDPROC
1856: 
1857:     *--------------------------------------------------------------------------
1858:     * FormParaBO - Transfere dados do formulario para o Business Object
1859:     * NOTA: Controles das abas internas serao adicionados em FASE 4
1860:     *--------------------------------------------------------------------------
1861:     PROTECTED PROCEDURE FormParaBO()
1862:         LOCAL loc_oBO, loc_oPag2
1863:         loc_oBO   = THIS.this_oBusinessObject
1864:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1865: 
1866:         *-- Identificacao (Page2 direto)
1867:         loc_oBO.this_cCodigos = ALLTRIM(loc_oPag2.txt_4c_Codigos.Value)
1868:         loc_oBO.this_cDescrs  = ALLTRIM(loc_oPag2.txt_4c_Descrs.Value)
1869:         loc_oBO.this_cInterno = ALLTRIM(loc_oPag2.txt_4c_Interno.Value)
1870:         loc_oBO.this_nTpCods  = loc_oPag2.opt_4c_TpCods.Value
1871:         loc_oBO.this_nTpEmps  = IIF(loc_oPag2.opt_4c_TpEmps.Visible, loc_oPag2.opt_4c_TpEmps.Value, 2)
1872:         loc_oBO.this_nTpCads  = loc_oPag2.opt_4c_TpCads.Value
1873:         loc_oBO.this_cDigito  = ALLTRIM(loc_oPag2.txt_4c_Digito.Value)
1874:         loc_oBO.this_cClasses = ALLTRIM(loc_oPag2.txt_4c_Classes.Value)
1875: 
1876:         *-- ChkLimCrds (CheckBox 1=checked -> this_nOptChkLimCr=1/Sim, 0=this_nOptChkLimCr=2/Nao)
1877:         loc_oBO.this_nOptChkLimCr  = IIF(loc_oPag2.chk_4c_LimCrds.Value = 1, 1, 2)
1878:         loc_oBO.this_nOptChkLimEst = IIF(loc_oPag2.chk_4c_LimEsts.Value = 1, 1, 2)
1879: 
1880:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
1881:         loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
1882:         loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
1883:         loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
1884:         loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4
1885: 
1886:         *== ABA GERAL ===========================================================
1887:         loc_oBO.this_nOptComple    = loc_oG.opt_4c_OptComple.Value
1888:         loc_oBO.this_nOptPessoais  = loc_oG.opt_4c_OptPessoais.Value
1889:         loc_oBO.this_nOptRefBancs  = loc_oG.opt_4c_OptRefBancs.Value
1890:         loc_oBO.this_nOptFollowUp  = loc_oG.opt_4c_OptFollowUp.Value
1891:         loc_oBO.this_nOptFiscais   = loc_oG.opt_4c_OptFiscais.Value
1892:         loc_oBO.this_nOptDadosCom  = loc_oG.opt_4c_OptDadosCom.Value
1893:         loc_oBO.this_nOptRespos    = loc_oG.opt_4c_OptRespos.Value
1894:         loc_oBO.this_nOptLimCre    = loc_oG.opt_4c_OptLimCre.Value
1895:         loc_oBO.this_nOptComi      = loc_oG.opt_4c_OptComi.Value
1896:         loc_oBO.this_nOptEmpresa   = loc_oG.opt_4c_OptEmpresa.Value
1897:         loc_oBO.this_nOptContabs   = loc_oG.opt_4c_OptContabs.Value
1898:         loc_oBO.this_nOptCaract    = loc_oG.opt_4c_OptCaract.Value
1899:         loc_oBO.this_nOptPerfil    = loc_oG.opt_4c_OptPerfil.Value
1900:         loc_oBO.this_nOptCargos    = loc_oG.opt_4c_OptCargos.Value
1901:         loc_oBO.this_nOptChkLimCr  = loc_oG.opt_4c_OptChkLimCrG.Value

*-- Linhas 2023 a 2066:
2023:     * BOParaForm - Transfere dados do Business Object para o formulario
2024:     * NOTA: Controles das abas internas serao populados em FASE 4
2025:     *--------------------------------------------------------------------------
2026:     PROTECTED PROCEDURE BOParaForm()
2027:         LOCAL loc_oBO, loc_oPag2
2028:         loc_oBO   = THIS.this_oBusinessObject
2029:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2030: 
2031:         *-- Identificacao
2032:         loc_oPag2.txt_4c_Codigos.Value  = loc_oBO.this_cCodigos
2033:         loc_oPag2.txt_4c_Descrs.Value   = loc_oBO.this_cDescrs
2034:         loc_oPag2.txt_4c_Interno.Value  = loc_oBO.this_cInterno
2035:         loc_oPag2.opt_4c_TpCods.Value   = IIF(loc_oBO.this_nTpCods > 0, loc_oBO.this_nTpCods, 1)
2036:         loc_oPag2.txt_4c_Digito.Value   = loc_oBO.this_cDigito
2037:         loc_oPag2.txt_4c_Classes.Value  = loc_oBO.this_cClasses
2038:         loc_oPag2.txt_4c_DClasses.Value = loc_oBO.this_cDClasses
2039: 
2040:         *-- TpEmps / TpCads
2041:         loc_oPag2.opt_4c_TpEmps.Value = IIF(loc_oBO.this_nTpEmps > 0, loc_oBO.this_nTpEmps, 1)
2042:         loc_oPag2.opt_4c_TpCads.Value = IIF(loc_oBO.this_nTpCads > 0, loc_oBO.this_nTpCads, 1)
2043: 
2044:         *-- Visibilidade de Digito e TpEmps: controlada por TpCods=1
2045:         loc_oPag2.txt_4c_Digito.Visible    = (loc_oBO.this_nTpCods = 1)
2046:         loc_oPag2.lbl_4c_LblDigito.Visible = (loc_oBO.this_nTpCods = 1)
2047:         loc_oPag2.lbl_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2048:         loc_oPag2.opt_4c_TpEmps.Visible    = (loc_oBO.this_nTpCods = 1)
2049:         loc_oPag2.opt_4c_TpEmps.Enabled    = (loc_oBO.this_nTpCods = 1)
2050: 
2051:         *-- ChkLimCrds/ChkLimEsts
2052:         loc_oPag2.chk_4c_LimCrds.Value = IIF(loc_oBO.this_nOptChkLimCr  = 1, 1, 0)
2053:         loc_oPag2.chk_4c_LimEsts.Value = IIF(loc_oBO.this_nOptChkLimEst = 1, 1, 0)
2054: 
2055:         *-- Sincronizar guardia
2056:         THIS.this_cUltClasses = ALLTRIM(loc_oBO.this_cClasses)
2057: 
2058:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2059:         loc_oG = loc_oPag2.pgf_4c_AbaDados.Page1
2060:         loc_oC = loc_oPag2.pgf_4c_AbaDados.Page2
2061:         loc_oE = loc_oPag2.pgf_4c_AbaDados.Page3
2062:         loc_oF = loc_oPag2.pgf_4c_AbaDados.Page4
2063: 
2064:         *== ABA GERAL ===========================================================
2065:         loc_oG.opt_4c_OptComple.Value    = IIF(loc_oBO.this_nOptComple  > 0, loc_oBO.this_nOptComple,  2)
2066:         loc_oG.opt_4c_OptPessoais.Value  = IIF(loc_oBO.this_nOptPessoais > 0, loc_oBO.this_nOptPessoais, 2)

*-- Linhas 2215 a 2258:
2215:     *--------------------------------------------------------------------------
2216:     * LimparCampos - Limpa todos os campos do formulario
2217:     *--------------------------------------------------------------------------
2218:     PROTECTED PROCEDURE LimparCampos()
2219:         LOCAL loc_oPag2
2220:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2221: 
2222:         loc_oPag2.txt_4c_Codigos.Value  = ""
2223:         loc_oPag2.txt_4c_Descrs.Value   = ""
2224:         loc_oPag2.txt_4c_Interno.Value  = ""
2225:         loc_oPag2.opt_4c_TpCods.Value   = 1
2226:         loc_oPag2.opt_4c_TpEmps.Value   = 1
2227:         loc_oPag2.opt_4c_TpCads.Value   = 1
2228:         loc_oPag2.txt_4c_Digito.Value   = ""
2229:         loc_oPag2.txt_4c_Classes.Value  = ""
2230:         loc_oPag2.txt_4c_DClasses.Value = ""
2231:         loc_oPag2.chk_4c_LimCrds.Value  = 0
2232:         loc_oPag2.chk_4c_LimEsts.Value  = 0
2233: 
2234:         *-- Resetar visibilidade Digito e TpEmps (padrao TpCods=1 = Empresa)
2235:         loc_oPag2.txt_4c_Digito.Visible    = .T.
2236:         loc_oPag2.lbl_4c_LblDigito.Visible = .T.
2237:         loc_oPag2.lbl_4c_TpEmps.Visible    = .T.
2238:         loc_oPag2.opt_4c_TpEmps.Visible    = .T.
2239:         loc_oPag2.opt_4c_TpEmps.Enabled    = .T.
2240: 
2241:         THIS.this_cUltClasses = ""
2242: 
2243:         LOCAL loc_oG, loc_oC, loc_oE, loc_oF
2244:         loc_oG = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2245:         loc_oC = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2246:         loc_oE = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
2247:         loc_oF = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page4
2248: 
2249:         *== ABA GERAL ===========================================================
2250:         loc_oG.opt_4c_OptComple.Value    = 2
2251:         loc_oG.opt_4c_OptPessoais.Value  = 2
2252:         loc_oG.opt_4c_OptRefBancs.Value  = 2
2253:         loc_oG.opt_4c_OptFollowUp.Value  = 2
2254:         loc_oG.opt_4c_OptFiscais.Value   = 2
2255:         loc_oG.opt_4c_OptDadosCom.Value  = 2
2256:         loc_oG.opt_4c_OptRespos.Value    = 2
2257:         loc_oG.opt_4c_OptLimCre.Value    = 1
2258:         loc_oG.opt_4c_OptComi.Value      = 2

*-- Linhas 2401 a 3336:
2401:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
2402:     * par_nPagina: 1=Lista, 2=Dados
2403:     *--------------------------------------------------------------------------
2404:     PROCEDURE AlternarPagina(par_nPagina)
2405:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2406: 
2407:         IF par_nPagina = 1
2408:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .T.
2409:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .T.
2410:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .T.
2411:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .T.
2412:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .F.
2413:         ELSE
2414:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.Visible  = .F.
2415:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.Visible   = .F.
2416:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.Visible = .F.
2417:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Visible   = .F.
2418:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.Visible = .T.
2419:         ENDIF
2420:     ENDPROC
2421: 
2422:     *--------------------------------------------------------------------------
2423:     * HabilitarCampos - Habilita/desabilita campos conforme modo
2424:     * NOTA: Completar em FASE 7 para controles das abas internas
2425:     *--------------------------------------------------------------------------
2426:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2427:         LOCAL loc_oPag2
2428:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2429: 
2430:         *-- Codigo: habilitado somente no modo INCLUIR
2431:         IF THIS.this_cModoAtual = "INCLUIR"
2432:             loc_oPag2.txt_4c_Codigos.Enabled = .T.
2433:         ELSE
2434:             loc_oPag2.txt_4c_Codigos.Enabled = .F.
2435:         ENDIF
2436: 
2437:         loc_oPag2.txt_4c_Descrs.Enabled   = par_lHabilitar
2438:         loc_oPag2.txt_4c_Interno.Enabled  = par_lHabilitar
2439:         loc_oPag2.opt_4c_TpCods.Enabled   = par_lHabilitar
2440:         loc_oPag2.txt_4c_Digito.Enabled   = par_lHabilitar
2441:         loc_oPag2.txt_4c_Classes.Enabled  = par_lHabilitar
2442:         loc_oPag2.chk_4c_LimCrds.Enabled = par_lHabilitar
2443:         loc_oPag2.chk_4c_LimEsts.Enabled = par_lHabilitar
2444:         loc_oPag2.opt_4c_TpEmps.Enabled  = par_lHabilitar
2445:         loc_oPag2.opt_4c_TpCads.Enabled  = par_lHabilitar
2446: 
2447:         *-- Abas internas: habilitar/desabilitar como grupo
2448:         loc_oPag2.pgf_4c_AbaDados.Enabled = par_lHabilitar
2449:     ENDPROC
2450: 
2451:     *==========================================================================
2452:     *-- HANDLERS: Botoes da lista
2453:     *==========================================================================
2454: 
2455:     *--------------------------------------------------------------------------
2456:     * BtnIncluirClick - Incluir novo registro
2457:     *--------------------------------------------------------------------------
2458:     PROCEDURE BtnIncluirClick()
2459:         THIS.this_oBusinessObject.NovoRegistro()
2460:         THIS.LimparCampos()
2461:         THIS.this_cModoAtual = "INCLUIR"
2462:         THIS.HabilitarCampos(.T.)
2463:         THIS.AlternarPagina(2)
2464:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus()
2465:     ENDPROC
2466: 
2467:     *--------------------------------------------------------------------------
2468:     * BtnVisualizarClick - Visualizar registro selecionado
2469:     *--------------------------------------------------------------------------
2470:     PROCEDURE BtnVisualizarClick()
2471:         LOCAL loc_cCodigo
2472: 
2473:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2474:             MsgAviso("Nenhum registro selecionado!")
2475:             RETURN
2476:         ENDIF
2477: 
2478:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2479: 
2480:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2481:             THIS.BOParaForm()
2482:             THIS.this_cModoAtual = "VISUALIZAR"
2483:             THIS.HabilitarCampos(.F.)
2484:             THIS.AlternarPagina(2)
2485:         ENDIF
2486:     ENDPROC
2487: 
2488:     *--------------------------------------------------------------------------
2489:     * BtnAlterarClick - Alterar registro selecionado
2490:     *--------------------------------------------------------------------------
2491:     PROCEDURE BtnAlterarClick()
2492:         LOCAL loc_cCodigo
2493: 
2494:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2495:             MsgAviso("Nenhum registro selecionado!")
2496:             RETURN
2497:         ENDIF
2498: 
2499:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2500: 
2501:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2502:             THIS.this_oBusinessObject.EditarRegistro()
2503:             THIS.BOParaForm()
2504:             THIS.this_cModoAtual = "ALTERAR"
2505:             THIS.HabilitarCampos(.T.)
2506:             THIS.AlternarPagina(2)
2507:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus()
2508:         ENDIF
2509:     ENDPROC
2510: 
2511:     *--------------------------------------------------------------------------
2512:     * BtnExcluirClick - Excluir registro selecionado
2513:     * Dependencias verificadas dentro de ccrBO.ExecutarExclusao (SigMvCcr/SigCdCli/SigMvCab)
2514:     *--------------------------------------------------------------------------
2515:     PROCEDURE BtnExcluirClick()
2516:         LOCAL loc_cCodigo
2517: 
2518:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2519:             MsgAviso("Nenhum registro selecionado!")
2520:             RETURN
2521:         ENDIF
2522: 
2523:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2524: 
2525:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2526:             IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + loc_cCodigo + "'?")
2527:                 IF THIS.this_oBusinessObject.Excluir()
2528:                     MsgSucesso("Grupo exclu" + CHR(237) + "do com sucesso!")
2529:                     THIS.CarregarLista()
2530:                 ENDIF
2531:             ENDIF
2532:         ENDIF
2533:     ENDPROC
2534: 
2535:     *--------------------------------------------------------------------------
2536:     * BtnBuscarClick - Busca por codigo via FormBuscaAuxiliar
2537:     *--------------------------------------------------------------------------
2538:     PROCEDURE BtnBuscarClick()
2539:         LOCAL loc_oBusca, loc_cCodigo
2540: 
2541:         TRY
2542:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2543:                 "SigCdGcr", "cursor_4c_Busca", "Codigos", "", ;
2544:                 "Buscar Grupo CCR")
2545: 
2546:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2547:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2548:             loc_oBusca.mAddColuna("Internos","", "Interno")
2549: 
2550:             loc_oBusca.Show()
2551: 
2552:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
2553:                 loc_cCodigo = ALLTRIM(cursor_4c_Busca.Codigos)
2554: 
2555:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2556:                     THIS.BOParaForm()
2557:                     THIS.this_cModoAtual = "VISUALIZAR"
2558:                     THIS.HabilitarCampos(.F.)
2559:                     THIS.AlternarPagina(2)
2560:                 ENDIF
2561:             ENDIF
2562: 
2563:             IF USED("cursor_4c_Busca")
2564:                 USE IN cursor_4c_Busca
2565:             ENDIF
2566:             loc_oBusca.Release()
2567: 
2568:         CATCH TO loException
2569:             MostrarErro("Erro ao buscar:" + CHR(13) + ;
2570:                 "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
2571:                 loException.Message, "Erro")
2572:         ENDTRY
2573:     ENDPROC
2574: 
2575:     *--------------------------------------------------------------------------
2576:     * BtnEncerrarClick - Fechar o formulario
2577:     *--------------------------------------------------------------------------
2578:     PROCEDURE BtnEncerrarClick()
2579:         THIS.Release()
2580:     ENDPROC
2581: 
2582:     *==========================================================================
2583:     *-- HANDLERS: Botoes da pagina de dados
2584:     *==========================================================================
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * BtnSalvarClick - Salvar registro (validacao pelo BO)
2588:     *--------------------------------------------------------------------------
2589:     PROCEDURE BtnSalvarClick()
2590:         THIS.FormParaBO()
2591: 
2592:         IF THIS.this_oBusinessObject.Salvar()
2593:             MsgSucesso("Registro salvo com sucesso!")
2594:             THIS.AlternarPagina(1)
2595:             THIS.CarregarLista()
2596:         ENDIF
2597:     ENDPROC
2598: 
2599:     *--------------------------------------------------------------------------
2600:     * BtnCancelarClick - Cancelar edicao e voltar para lista
2601:     *--------------------------------------------------------------------------
2602:     PROCEDURE BtnCancelarClick()
2603:         THIS.AlternarPagina(1)
2604:         THIS.this_cModoAtual = "LISTA"
2605:         THIS.CarregarLista()
2606:     ENDPROC
2607: 
2608:     *==========================================================================
2609:     *-- EVENTOS: TpCods
2610:     *==========================================================================
2611: 
2612:     *--------------------------------------------------------------------------
2613:     * opt_4c_TpCods_InteractiveChange - Controla visibilidade de Digito
2614:     * Legado: .Get_Digito.Visible = (CrSigCdGcr.TpCods = 1)
2615:     *--------------------------------------------------------------------------
2616:     PROCEDURE opt_4c_TpCods_InteractiveChange()
2617:         LOCAL loc_lEmpresa
2618:         loc_lEmpresa = (THIS.pgf_4c_Paginas.Page2.opt_4c_TpCods.Value = 1)
2619: 
2620:         THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Visible    = loc_lEmpresa
2621:         THIS.pgf_4c_Paginas.Page2.lbl_4c_LblDigito.Visible = loc_lEmpresa
2622: 
2623:         IF !loc_lEmpresa
2624:             THIS.pgf_4c_Paginas.Page2.txt_4c_Digito.Value = ""
2625:             THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Value = 2
2626:         ENDIF
2627:         THIS.pgf_4c_Paginas.Page2.lbl_4c_TpEmps.Visible = loc_lEmpresa
2628:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Visible = loc_lEmpresa
2629:         THIS.pgf_4c_Paginas.Page2.opt_4c_TpEmps.Enabled = loc_lEmpresa
2630:     ENDPROC
2631: 
2632:     *==========================================================================
2633:     *-- LOOKUPS: Classes (SigCdCss)
2634:     *==========================================================================
2635: 
2636:     *--------------------------------------------------------------------------
2637:     * txt_4c_Classes_KeyPress - F4 abre lookup de classes
2638:     *--------------------------------------------------------------------------
2639:     PROCEDURE txt_4c_Classes_KeyPress
2640:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2641:         IF par_nKeyCode = 115  && F4
2642:             THIS.AbrirLookupClasses()
2643:         ENDIF
2644:     ENDPROC
2645: 
2646:     *--------------------------------------------------------------------------
2647:     * txt_4c_Classes_LostFocus - Valida classe digitada
2648:     *--------------------------------------------------------------------------
2649:     PROCEDURE txt_4c_Classes_LostFocus()
2650:         LOCAL loc_cClasses
2651:         loc_cClasses = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)
2652: 
2653:         IF loc_cClasses = THIS.this_cUltClasses
2654:             RETURN
2655:         ENDIF
2656: 
2657:         IF EMPTY(loc_cClasses)
2658:             THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ""
2659:             THIS.this_cUltClasses = ""
2660:             RETURN
2661:         ENDIF
2662: 
2663:         THIS.ValidarClasses(loc_cClasses)
2664:     ENDPROC
2665: 
2666:     *--------------------------------------------------------------------------
2667:     * AbrirLookupClasses - Abre FormBuscaAuxiliar para SigCdCss
2668:     * Legado: fwBuscaExt em SigCdCss, campoCodigo='classes'
2669:     *--------------------------------------------------------------------------
2670:     PROTECTED PROCEDURE AbrirLookupClasses()
2671:         LOCAL loc_oBusca, loc_cValor
2672: 
2673:         TRY
2674:             loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value)
2675: 
2676:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2677:                 "SigCdCss", "cursor_4c_Css", "Classes", loc_cValor, ;
2678:                 "Sele" + CHR(231) + CHR(227) + "o de Classe")
2679:             loc_oBusca.mAddColuna("Classes", "", "Classe")
2680:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2681:             loc_oBusca.Show()
2682: 
2683:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Css")
2684:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Classes.Value  = ALLTRIM(cursor_4c_Css.Classes)
2685:                 THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ALLTRIM(cursor_4c_Css.Descrs)
2686:                 THIS.this_cUltClasses = ALLTRIM(cursor_4c_Css.Classes)
2687:             ENDIF
2688: 
2689:             IF USED("cursor_4c_Css")
2690:                 USE IN cursor_4c_Css
2691:             ENDIF
2692:             loc_oBusca.Release()
2693: 
2694:         CATCH TO loException
2695:             MostrarErro("Erro no lookup de classes:" + CHR(13) + ;
2696:                 loException.Message, "Erro")
2697:         ENDTRY
2698:     ENDPROC
2699: 
2700:     *--------------------------------------------------------------------------
2701:     * ValidarClasses - Verifica classe digitada em SigCdCss (LostFocus)
2702:     *--------------------------------------------------------------------------
2703:     PROTECTED PROCEDURE ValidarClasses(par_cClasses)
2704:         LOCAL loc_cSQL, loc_nRes
2705: 
2706:         TRY
2707:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2708:                 SELECT Classes, Descrs FROM SigCdCss
2709:                 WHERE Classes = <<EscaparSQL(par_cClasses)>>
2710:             ENDTEXT
2711: 
2712:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVerif")
2713: 
2714:             IF loc_nRes >= 0
2715:                 IF RECCOUNT("cursor_4c_CssVerif") > 0
2716:                     THIS.pgf_4c_Paginas.Page2.txt_4c_DClasses.Value = ;
2717:                         ALLTRIM(cursor_4c_CssVerif.Descrs)
2718:                     THIS.this_cUltClasses = par_cClasses
2719:                 ELSE
2720:                     *-- Codigo nao encontrado: abrir lookup
2721:                     THIS.AbrirLookupClasses()
2722:                 ENDIF
2723: 
2724:                 IF USED("cursor_4c_CssVerif")
2725:                     USE IN cursor_4c_CssVerif
2726:                 ENDIF
2727:             ENDIF
2728: 
2729:         CATCH TO loException
2730:             MostrarErro("Erro ao validar classe:" + CHR(13) + ;
2731:                 loException.Message, "Erro")
2732:         ENDTRY
2733:     ENDPROC
2734: 
2735:     *==========================================================================
2736:     *-- UTILIDADES
2737:     *==========================================================================
2738: 
2739:     *--------------------------------------------------------------------------
2740:     * FormatarGridLista - Formata visual do grid da lista
2741:     *--------------------------------------------------------------------------
2742:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2743:         WITH par_oGrid
2744:             IF .ColumnCount > 0
2745:                 .FontName = "Tahoma"
2746:                 .FontSize = 8
2747:             ENDIF
2748:         ENDWITH
2749:     ENDPROC
2750: 
2751:     *--------------------------------------------------------------------------
2752:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2753:     *--------------------------------------------------------------------------
2754:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2755:         LOCAL loc_nI, loc_oObjeto, loc_nP
2756: 
2757:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2758:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2759: 
2760:             IF VARTYPE(loc_oObjeto) = "O"
2761:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2762:                     loc_oObjeto.Visible = .T.
2763:                 ENDIF
2764: 
2765:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2766:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2767:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2768:                     ENDFOR
2769:                 ENDIF
2770: 
2771:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2772:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2773:                 ENDIF
2774:             ENDIF
2775:         ENDFOR
2776:     ENDPROC
2777: 
2778:     *==========================================================================
2779:     *-- LOOKUPS: SigCdGcr - Metodos genericos compartilhados
2780:     *==========================================================================
2781: 
2782:     *--------------------------------------------------------------------------
2783:     * AbrirLookupGcr - Abre FormBuscaAuxiliar para SigCdGcr (generico)
2784:     * par_oTxt: TextBox do codigo | par_oTxtDesc: TextBox desc (ou .NULL.)
2785:     *--------------------------------------------------------------------------
2786:     PROTECTED PROCEDURE AbrirLookupGcr(par_oTxt, par_oTxtDesc)
2787:         LOCAL loc_oBusca
2788:         TRY
2789:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2790:                 "SigCdGcr", "cursor_4c_GcrLkp", "Codigos", ;
2791:                 ALLTRIM(par_oTxt.Value), ;
2792:                 "Selecionar Grupo C/C")
2793:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2794:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2795:             loc_oBusca.Show()
2796:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_GcrLkp")
2797:                 par_oTxt.Value = ALLTRIM(cursor_4c_GcrLkp.Codigos)
2798:                 IF VARTYPE(par_oTxtDesc) = "O"
2799:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrLkp.Descrs)
2800:                 ENDIF
2801:             ENDIF
2802:             IF USED("cursor_4c_GcrLkp")
2803:                 USE IN cursor_4c_GcrLkp
2804:             ENDIF
2805:             loc_oBusca.Release()
2806:         CATCH TO loException
2807:             MostrarErro("Erro no lookup Grupo C/C:" + CHR(13) + loException.Message, "Erro")
2808:         ENDTRY
2809:     ENDPROC
2810: 
2811:     *--------------------------------------------------------------------------
2812:     * ValidarGcr - Verifica codigo SigCdGcr (generico); abre lookup se n/a
2813:     *--------------------------------------------------------------------------
2814:     PROTECTED PROCEDURE ValidarGcr(par_cCodigo, par_oTxt, par_oTxtDesc)
2815:         LOCAL loc_nRes
2816:         TRY
2817:             loc_nRes = SQLEXEC(gnConnHandle, ;
2818:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
2819:                 "cursor_4c_GcrVerif")
2820:             IF loc_nRes >= 0
2821:                 IF RECCOUNT("cursor_4c_GcrVerif") > 0
2822:                     IF VARTYPE(par_oTxtDesc) = "O"
2823:                         par_oTxtDesc.Value = ALLTRIM(cursor_4c_GcrVerif.Descrs)
2824:                     ENDIF
2825:                 ELSE
2826:                     THIS.AbrirLookupGcr(par_oTxt, par_oTxtDesc)
2827:                 ENDIF
2828:                 IF USED("cursor_4c_GcrVerif")
2829:                     USE IN cursor_4c_GcrVerif
2830:                 ENDIF
2831:             ENDIF
2832:         CATCH TO loException
2833:             MostrarErro("Erro ao validar Grupo C/C:" + CHR(13) + loException.Message, "Erro")
2834:         ENDTRY
2835:     ENDPROC
2836: 
2837:     *==========================================================================
2838:     *-- LOOKUPS: GrupoGeral (Aba Geral)
2839:     *==========================================================================
2840: 
2841:     PROCEDURE txt_4c_GrupoGeral_KeyPress
2842:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2843:         IF par_nKeyCode = 115
2844:             THIS.AbrirLookupGrupoGeral()
2845:         ENDIF
2846:     ENDPROC
2847: 
2848:     PROCEDURE txt_4c_GrupoGeral_LostFocus()
2849:         LOCAL loc_cVal, loc_oAba
2850:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2851:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
2852:         IF loc_cVal = THIS.this_cUltGrupoGeral
2853:             RETURN
2854:         ENDIF
2855:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
2856:             THIS.this_cUltGrupoGeral = ""
2857:             RETURN
2858:         ENDIF
2859:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoGeral, .NULL.)
2860:         THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
2861:     ENDPROC
2862: 
2863:     PROTECTED PROCEDURE AbrirLookupGrupoGeral()
2864:         LOCAL loc_oAba
2865:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2866:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoGeral, .NULL.)
2867:         THIS.this_cUltGrupoGeral = ALLTRIM(loc_oAba.txt_4c_GrupoGeral.Value)
2868:     ENDPROC
2869: 
2870:     *==========================================================================
2871:     *-- LOOKUPS: CdMoeda (Aba Geral / SigCdMoe)
2872:     *==========================================================================
2873: 
2874:     PROCEDURE txt_4c_CdMoeda_KeyPress
2875:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2876:         IF par_nKeyCode = 115
2877:             THIS.AbrirLookupMoeda()
2878:         ENDIF
2879:     ENDPROC
2880: 
2881:     PROCEDURE txt_4c_CdMoeda_LostFocus()
2882:         LOCAL loc_cVal, loc_oAba
2883:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2884:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value)
2885:         IF loc_cVal = THIS.this_cUltCdMoeda
2886:             RETURN
2887:         ENDIF
2888:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
2889:             loc_oAba.txt_4c_DsMoeda.Value = ""
2890:             THIS.this_cUltCdMoeda = ""
2891:             RETURN
2892:         ENDIF
2893:         THIS.ValidarMoeda(loc_cVal)
2894:     ENDPROC
2895: 
2896:     PROTECTED PROCEDURE AbrirLookupMoeda()
2897:         LOCAL loc_oBusca, loc_oAba
2898:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2899:         TRY
2900:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2901:                 "SigCdMoe", "cursor_4c_MoeLkp", "cmoes", ;
2902:                 ALLTRIM(loc_oAba.txt_4c_CdMoeda.Value), ;
2903:                 "Selecionar Moeda")
2904:             loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
2905:             loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2906:             loc_oBusca.Show()
2907:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_MoeLkp")
2908:                 loc_oAba.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.cmoes)
2909:                 loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeLkp.dmoes)
2910:                 THIS.this_cUltCdMoeda = ALLTRIM(cursor_4c_MoeLkp.cmoes)
2911:             ENDIF
2912:             IF USED("cursor_4c_MoeLkp")
2913:                 USE IN cursor_4c_MoeLkp
2914:             ENDIF
2915:             loc_oBusca.Release()
2916:         CATCH TO loException
2917:             MostrarErro("Erro no lookup de Moeda:" + CHR(13) + loException.Message, "Erro")
2918:         ENDTRY
2919:     ENDPROC
2920: 
2921:     PROTECTED PROCEDURE ValidarMoeda(par_cCodigo)
2922:         LOCAL loc_nRes, loc_oAba
2923:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page1
2924:         TRY
2925:             loc_nRes = SQLEXEC(gnConnHandle, ;
2926:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
2927:                 "cursor_4c_MoeVerif")
2928:             IF loc_nRes >= 0
2929:                 IF RECCOUNT("cursor_4c_MoeVerif") > 0
2930:                     loc_oAba.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_MoeVerif.dmoes)
2931:                     THIS.this_cUltCdMoeda = par_cCodigo
2932:                 ELSE
2933:                     THIS.AbrirLookupMoeda()
2934:                 ENDIF
2935:                 IF USED("cursor_4c_MoeVerif")
2936:                     USE IN cursor_4c_MoeVerif
2937:                 ENDIF
2938:             ENDIF
2939:         CATCH TO loException
2940:             MostrarErro("Erro ao validar Moeda:" + CHR(13) + loException.Message, "Erro")
2941:         ENDTRY
2942:     ENDPROC
2943: 
2944:     *==========================================================================
2945:     *-- LOOKUPS: Situas (Aba Cadastro / SigCdCst)
2946:     *==========================================================================
2947: 
2948:     PROCEDURE txt_4c_Situas_KeyPress
2949:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2950:         IF par_nKeyCode = 115
2951:             THIS.AbrirLookupSituas()
2952:         ENDIF
2953:     ENDPROC
2954: 
2955:     PROCEDURE txt_4c_Situas_LostFocus()
2956:         LOCAL loc_cVal, loc_oAba
2957:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2958:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_Situas.Value)
2959:         IF loc_cVal = THIS.this_cUltSituas
2960:             RETURN
2961:         ENDIF
2962:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
2963:             THIS.this_cUltSituas = ""
2964:             RETURN
2965:         ENDIF
2966:         THIS.ValidarSituas(loc_cVal)
2967:     ENDPROC
2968: 
2969:     PROTECTED PROCEDURE AbrirLookupSituas()
2970:         LOCAL loc_oBusca, loc_oAba
2971:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2972:         TRY
2973:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2974:                 "SigCdCst", "cursor_4c_CstLkp", "codigos", ;
2975:                 ALLTRIM(loc_oAba.txt_4c_Situas.Value), ;
2976:                 "Selecionar Situa" + CHR(231) + CHR(227) + "o")
2977:             loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
2978:             loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2979:             loc_oBusca.Show()
2980:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_CstLkp")
2981:                 loc_oAba.txt_4c_Situas.Value = ALLTRIM(cursor_4c_CstLkp.codigos)
2982:                 THIS.this_cUltSituas = ALLTRIM(cursor_4c_CstLkp.codigos)
2983:             ENDIF
2984:             IF USED("cursor_4c_CstLkp")
2985:                 USE IN cursor_4c_CstLkp
2986:             ENDIF
2987:             loc_oBusca.Release()
2988:         CATCH TO loException
2989:             MostrarErro("Erro no lookup de Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
2990:         ENDTRY
2991:     ENDPROC
2992: 
2993:     PROTECTED PROCEDURE ValidarSituas(par_cCodigo)
2994:         LOCAL loc_nRes, loc_oAba
2995:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
2996:         TRY
2997:             loc_nRes = SQLEXEC(gnConnHandle, ;
2998:                 "SELECT codigos FROM SigCdCst WHERE codigos = " + EscaparSQL(par_cCodigo), ;
2999:                 "cursor_4c_CstVerif")
3000:             IF loc_nRes >= 0
3001:                 IF RECCOUNT("cursor_4c_CstVerif") > 0
3002:                     THIS.this_cUltSituas = par_cCodigo
3003:                 ELSE
3004:                     THIS.AbrirLookupSituas()
3005:                 ENDIF
3006:                 IF USED("cursor_4c_CstVerif")
3007:                     USE IN cursor_4c_CstVerif
3008:                 ENDIF
3009:             ENDIF
3010:         CATCH TO loException
3011:             MostrarErro("Erro ao validar Situa" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
3012:         ENDTRY
3013:     ENDPROC
3014: 
3015:     *==========================================================================
3016:     *-- LOOKUPS: Contint (Aba Cadastro)
3017:     *==========================================================================
3018: 
3019:     PROCEDURE txt_4c_Contint_KeyPress
3020:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3021:         IF par_nKeyCode = 115
3022:             THIS.AbrirLookupContint()
3023:         ENDIF
3024:     ENDPROC
3025: 
3026:     PROCEDURE txt_4c_Contint_LostFocus()
3027:         LOCAL loc_cVal, loc_oAba
3028:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3029:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3030:         IF loc_cVal = THIS.this_cUltContint
3031:             RETURN
3032:         ENDIF
3033:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3034:             THIS.this_cUltContint = ""
3035:             RETURN
3036:         ENDIF
3037:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_Contint, .NULL.)
3038:         THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3039:     ENDPROC
3040: 
3041:     PROTECTED PROCEDURE AbrirLookupContint()
3042:         LOCAL loc_oAba
3043:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page2
3044:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_Contint, .NULL.)
3045:         THIS.this_cUltContint = ALLTRIM(loc_oAba.txt_4c_Contint.Value)
3046:     ENDPROC
3047: 
3048:     *==========================================================================
3049:     *-- LOOKUPS: GrupoEst (Aba Estoque)
3050:     *==========================================================================
3051: 
3052:     PROCEDURE txt_4c_GrupoEst_KeyPress
3053:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3054:         IF par_nKeyCode = 115
3055:             THIS.AbrirLookupGrupoEst()
3056:         ENDIF
3057:     ENDPROC
3058: 
3059:     PROCEDURE txt_4c_GrupoEst_LostFocus()
3060:         LOCAL loc_cVal, loc_oAba
3061:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3062:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3063:         IF loc_cVal = THIS.this_cUltGrupoEst
3064:             RETURN
3065:         ENDIF
3066:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3067:             THIS.this_cUltGrupoEst = ""
3068:             RETURN
3069:         ENDIF
3070:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoEst, .NULL.)
3071:         THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3072:     ENDPROC
3073: 
3074:     PROTECTED PROCEDURE AbrirLookupGrupoEst()
3075:         LOCAL loc_oAba
3076:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3077:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoEst, .NULL.)
3078:         THIS.this_cUltGrupoEst = ALLTRIM(loc_oAba.txt_4c_GrupoEst.Value)
3079:     ENDPROC
3080: 
3081:     *==========================================================================
3082:     *-- LOOKUPS: GrupoFalha (Aba Estoque)
3083:     *==========================================================================
3084: 
3085:     PROCEDURE txt_4c_GrupoFalha_KeyPress
3086:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3087:         IF par_nKeyCode = 115
3088:             THIS.AbrirLookupGrupoFalha()
3089:         ENDIF
3090:     ENDPROC
3091: 
3092:     PROCEDURE txt_4c_GrupoFalha_LostFocus()
3093:         LOCAL loc_cVal, loc_oAba
3094:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3095:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3096:         IF loc_cVal = THIS.this_cUltGrupoFalha
3097:             RETURN
3098:         ENDIF
3099:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3100:             THIS.this_cUltGrupoFalha = ""
3101:             RETURN
3102:         ENDIF
3103:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_GrupoFalha, .NULL.)
3104:         THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3105:     ENDPROC
3106: 
3107:     PROTECTED PROCEDURE AbrirLookupGrupoFalha()
3108:         LOCAL loc_oAba
3109:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3110:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_GrupoFalha, .NULL.)
3111:         THIS.this_cUltGrupoFalha = ALLTRIM(loc_oAba.txt_4c_GrupoFalha.Value)
3112:     ENDPROC
3113: 
3114:     *==========================================================================
3115:     *-- LOOKUPS: ContaFalha (Aba Estoque -> com DsContaFalha)
3116:     *==========================================================================
3117: 
3118:     PROCEDURE txt_4c_ContaFalha_KeyPress
3119:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3120:         IF par_nKeyCode = 115
3121:             THIS.AbrirLookupContaFalha()
3122:         ENDIF
3123:     ENDPROC
3124: 
3125:     PROCEDURE txt_4c_ContaFalha_LostFocus()
3126:         LOCAL loc_cVal, loc_oAba
3127:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3128:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3129:         IF loc_cVal = THIS.this_cUltContaFalha
3130:             RETURN
3131:         ENDIF
3132:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3133:             loc_oAba.txt_4c_DsContaFalha.Value = ""
3134:             THIS.this_cUltContaFalha = ""
3135:             RETURN
3136:         ENDIF
3137:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
3138:         THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3139:     ENDPROC
3140: 
3141:     PROTECTED PROCEDURE AbrirLookupContaFalha()
3142:         LOCAL loc_oAba
3143:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3144:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaFalha, loc_oAba.txt_4c_DsContaFalha)
3145:         THIS.this_cUltContaFalha = ALLTRIM(loc_oAba.txt_4c_ContaFalha.Value)
3146:     ENDPROC
3147: 
3148:     *==========================================================================
3149:     *-- LOOKUPS: ContaPdr (Aba Estoque -> com DsContaPdr)
3150:     *==========================================================================
3151: 
3152:     PROCEDURE txt_4c_ContaPdr_KeyPress
3153:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3154:         IF par_nKeyCode = 115
3155:             THIS.AbrirLookupContaPdr()
3156:         ENDIF
3157:     ENDPROC
3158: 
3159:     PROCEDURE txt_4c_ContaPdr_LostFocus()
3160:         LOCAL loc_cVal, loc_oAba
3161:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3162:         loc_cVal = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3163:         IF loc_cVal = THIS.this_cUltContaPdr
3164:             RETURN
3165:         ENDIF
3166:         IF EMPTY(loc_cVal) OR gb_4c_ValidandoUI
3167:             loc_oAba.txt_4c_DsContaPdr.Value = ""
3168:             THIS.this_cUltContaPdr = ""
3169:             RETURN
3170:         ENDIF
3171:         THIS.ValidarGcr(loc_cVal, loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
3172:         THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3173:     ENDPROC
3174: 
3175:     PROTECTED PROCEDURE AbrirLookupContaPdr()
3176:         LOCAL loc_oAba
3177:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_AbaDados.Page3
3178:         THIS.AbrirLookupGcr(loc_oAba.txt_4c_ContaPdr, loc_oAba.txt_4c_DsContaPdr)
3179:         THIS.this_cUltContaPdr = ALLTRIM(loc_oAba.txt_4c_ContaPdr.Value)
3180:     ENDPROC
3181: 
3182:     *==========================================================================
3183:     *-- LOOKUPS: Containers Fiscais (CdGrupos + CdContas via F4 + LostFocus)
3184:     *-- GotFocus rastreia container ativo em this_oFiscalCntAtivo
3185:     *-- LostFocus usa this_oFiscalCntAtivo para saber qual container processar
3186:     *==========================================================================
3187: 
3188:     *--------------------------------------------------------------------------
3189:     * FiscalGotFocus - Rastreia container fiscal ativo quando campo ganha foco
3190:     *--------------------------------------------------------------------------
3191:     PROCEDURE FiscalGotFocus()
3192:         LOCAL loc_oCtrl
3193:         loc_oCtrl = _VFP.ActiveControl
3194:         IF VARTYPE(loc_oCtrl) = "O"
3195:             THIS.this_oFiscalCntAtivo = loc_oCtrl.Parent
3196:         ENDIF
3197:     ENDPROC
3198: 
3199:     *--------------------------------------------------------------------------
3200:     * FiscalCdGruposKeyPress - Abre lookup F4 para campo CdGrupos fiscal
3201:     *--------------------------------------------------------------------------
3202:     PROCEDURE FiscalCdGruposKeyPress
3203:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3204:         IF par_nKeyCode = 115  && F4
3205:             LOCAL loc_oCtrl
3206:             loc_oCtrl = _VFP.ActiveControl
3207:             IF VARTYPE(loc_oCtrl) = "O"
3208:                 THIS.AbrirLookupFiscalGrupos(loc_oCtrl.Parent)
3209:             ENDIF
3210:         ENDIF
3211:     ENDPROC
3212: 
3213:     *--------------------------------------------------------------------------
3214:     * FiscalCdGruposLostFocus - Valida CdGrupos; limpa campos subordinados se vazio
3215:     * Legado: getCdGrupos.Valid - fAcessoContab / limpa getCdContas..Receitas
3216:     *--------------------------------------------------------------------------
3217:     PROCEDURE FiscalCdGruposLostFocus()
3218:         LOCAL loc_oCnt, loc_cVal
3219:         loc_oCnt = THIS.this_oFiscalCntAtivo
3220:         IF VARTYPE(loc_oCnt) # "O"
3221:             RETURN
3222:         ENDIF
3223:         IF gb_4c_ValidandoUI
3224:             RETURN
3225:         ENDIF
3226:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdGrupos.Value)
3227:         IF EMPTY(loc_cVal)
3228:             *-- Limpar campos subordinados ao grupo quando CdGrupos e' esvaziado
3229:             loc_oCnt.txt_4c_CdContas.Value = ""
3230:             loc_oCnt.txt_4c_DsContas.Value = ""
3231:             loc_oCnt.txt_4c_PctAliqs.Value = 0
3232:             loc_oCnt.txt_4c_Receitas.Value = ""
3233:         ELSE
3234:             THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdGrupos, .NULL.)
3235:         ENDIF
3236:         THIS.AtualizarEstadoFiscal(loc_oCnt)
3237:     ENDPROC
3238: 
3239:     *--------------------------------------------------------------------------
3240:     * FiscalCdContasKeyPress - Abre lookup F4 para campo CdContas fiscal
3241:     *--------------------------------------------------------------------------
3242:     PROCEDURE FiscalCdContasKeyPress
3243:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3244:         IF par_nKeyCode = 115  && F4
3245:             LOCAL loc_oCtrl
3246:             loc_oCtrl = _VFP.ActiveControl
3247:             IF VARTYPE(loc_oCtrl) = "O"
3248:                 THIS.AbrirLookupFiscalContas(loc_oCtrl.Parent)
3249:             ENDIF
3250:         ENDIF
3251:     ENDPROC
3252: 
3253:     *--------------------------------------------------------------------------
3254:     * FiscalCdContasLostFocus - Valida CdContas; preenche DsContas
3255:     * Legado: getCdContas.Valid - fAcessoContas(grupoX, [C], valor, DsContas)
3256:     *--------------------------------------------------------------------------
3257:     PROCEDURE FiscalCdContasLostFocus()
3258:         LOCAL loc_oCnt, loc_cVal
3259:         loc_oCnt = THIS.this_oFiscalCntAtivo
3260:         IF VARTYPE(loc_oCnt) # "O"
3261:             RETURN
3262:         ENDIF
3263:         IF gb_4c_ValidandoUI
3264:             RETURN
3265:         ENDIF
3266:         loc_cVal = ALLTRIM(loc_oCnt.txt_4c_CdContas.Value)
3267:         IF EMPTY(loc_cVal)
3268:             loc_oCnt.txt_4c_DsContas.Value = ""
3269:         ELSE
3270:             THIS.ValidarGcr(loc_cVal, loc_oCnt.txt_4c_CdContas, loc_oCnt.txt_4c_DsContas)
3271:         ENDIF
3272:         THIS.AtualizarEstadoFiscal(loc_oCnt)
3273:     ENDPROC
3274: 
3275:     *--------------------------------------------------------------------------
3276:     * AbrirLookupFiscalGrupos - Abre lookup para campo CdGrupos do container
3277:     *--------------------------------------------------------------------------
3278:     PROTECTED PROCEDURE AbrirLookupFiscalGrupos(par_oCnt)
3279:         THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdGrupos, .NULL.)
3280:         THIS.AtualizarEstadoFiscal(par_oCnt)
3281:     ENDPROC
3282: 
3283:     *--------------------------------------------------------------------------
3284:     * AbrirLookupFiscalContas - Abre lookup para campo CdContas do container
3285:     *--------------------------------------------------------------------------
3286:     PROTECTED PROCEDURE AbrirLookupFiscalContas(par_oCnt)
3287:         THIS.AbrirLookupGcr(par_oCnt.txt_4c_CdContas, par_oCnt.txt_4c_DsContas)
3288:         THIS.AtualizarEstadoFiscal(par_oCnt)
3289:     ENDPROC
3290: 
3291:     *--------------------------------------------------------------------------
3292:     * AtualizarEstadoFiscal - Atualiza Enabled dos campos condicionais no container
3293:     * Legado: When() expressions de getCdContas/getDsContas/getPctAliqs/getReceitas
3294:     * Apenas no modo INCLUIR/ALTERAR; VISUALIZAR: todos desabilitados (via pgf_4c_AbaDados.Enabled)
3295:     *--------------------------------------------------------------------------
3296:     PROTECTED PROCEDURE AtualizarEstadoFiscal(par_oCnt)
3297:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3298:             LOCAL loc_lTemGrupo, loc_lTemConta, loc_lTemPct
3299:             loc_lTemGrupo = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdGrupos.Value))
3300:             loc_lTemConta = !EMPTY(ALLTRIM(par_oCnt.txt_4c_CdContas.Value))
3301:             loc_lTemPct   = (par_oCnt.txt_4c_PctAliqs.Value # 0)
3302: 
3303:             par_oCnt.txt_4c_CdContas.Enabled = loc_lTemGrupo
3304:             par_oCnt.txt_4c_DsContas.Enabled = loc_lTemGrupo AND !loc_lTemConta
3305:             par_oCnt.txt_4c_PctAliqs.Enabled = loc_lTemGrupo AND loc_lTemConta
3306:             par_oCnt.txt_4c_Receitas.Enabled = loc_lTemGrupo AND loc_lTemConta AND loc_lTemPct
3307:         ENDIF
3308:     ENDPROC
3309: 
3310:     *--------------------------------------------------------------------------
3311:     * AtualizarEstadoFiscalTodos - Chama AtualizarEstadoFiscal para os 9 containers
3312:     * par_oF: referencia para Page4 (aba Faturamento)
3313:     *--------------------------------------------------------------------------
3314:     PROTECTED PROCEDURE AtualizarEstadoFiscalTodos(par_oF)
3315:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ICMS)
3316:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IPI)
3317:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_II)
3318:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_ISS)
3319:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_IRRF)
3320:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_INSS)
3321:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_PIS)
3322:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_CSL)
3323:         THIS.AtualizarEstadoFiscal(par_oF.cnt_4c_COF)
3324:     ENDPROC
3325: 
3326:     *--------------------------------------------------------------------------
3327:     * Destroy - Limpeza ao fechar o formulario
3328:     *--------------------------------------------------------------------------
3329:     PROCEDURE Destroy()
3330:         IF !ISNULL(THIS.this_oBusinessObject)
3331:             THIS.this_oBusinessObject = .NULL.
3332:         ENDIF
3333:         DODEFAULT()
3334:     ENDPROC
3335: 
3336: ENDDEFINE

