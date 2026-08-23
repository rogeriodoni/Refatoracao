# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [BINDEVENT-PARAMS] Handler 'CodigosEtqLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CodigosEtqLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Dados' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_DadosTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_LocalPrLoc' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1909 linhas total):

*-- Linhas 23 a 137:
23:     this_cModoAtual      = "LISTA"
24: 
25:     *--------------------------------------------------------------------------
26:     * Init - Apenas delega ao FormBase.Init() que chama InicializarForm()
27:     *--------------------------------------------------------------------------
28:     PROCEDURE Init()
29:         LOCAL loc_lSucesso
30:         loc_lSucesso = .F.
31:         TRY
32:             loc_lSucesso = DODEFAULT()
33:         CATCH TO loc_oErro
34:             MsgErro("Erro ao inicializar FormPrl:" + CHR(13) + loc_oErro.Message, "Erro")
35:         ENDTRY
36:         RETURN loc_lSucesso
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Chamado automaticamente pelo FormBase.Init()
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("PrlBO")
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MsgErro("Erro ao criar PrlBO", "Erro")
50:                 loc_lSucesso = .F.
51:             ENDIF
52: 
53:             THIS.ConfigurarPageFrame()
54: 
55:             THIS.pgf_4c_Paginas.Visible = .T.
56:             THIS.pgf_4c_Paginas.ActivePage = 1
57:             THIS.this_cModoAtual = "LISTA"
58: 
59:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                 THIS.CarregarLista()
61:             ENDIF
62: 
63:             loc_lSucesso = .T.
64:         CATCH TO loc_oErro
65:             MsgErro("Erro ao inicializar FormPrl:" + CHR(13) + loc_oErro.Message, "Erro")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *--------------------------------------------------------------------------
72:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
73:     *--------------------------------------------------------------------------
74:     PROTECTED PROCEDURE ConfigurarPageFrame()
75:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
76:         THIS.pgf_4c_Paginas.PageCount = 2
77:         WITH THIS.pgf_4c_Paginas
78:             .Top     = -29
79:             .Left    = 0
80:             .Width   = THIS.Width
81:             .Height  = THIS.Height + 29
82:             .Tabs    = .F.
83:             .Visible = .T.
84:             .Page1.Caption = "Lista"
85:             .Page2.Caption = "Dados"
86:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
87:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:         ENDWITH
89: 
90:         THIS.ConfigurarPaginaLista()
91:         THIS.ConfigurarPaginaDados()
92:     ENDPROC
93: 
94:     *--------------------------------------------------------------------------
95:     * ConfigurarPaginaLista - Page1: Cabecalho, botoes CRUD, grid e painel etiquetas
96:     *--------------------------------------------------------------------------
97:     PROTECTED PROCEDURE ConfigurarPaginaLista()
98:         LOCAL loc_oPagina
99:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
100: 
101:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
102:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103: 
104:         *-- Cabecalho escuro: Top=1+29=30
105:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
106:         WITH loc_oPagina.cnt_4c_Cabecalho
107:             .Top         = 30
108:             .Left        = 0
109:             .Width       = THIS.Width
110:             .Height      = 80
111:             .BackColor   = RGB(100, 100, 100)
112:             .BorderWidth = 0
113:             .Visible     = .T.
114:         ENDWITH
115: 
116:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
117:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
118:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
119:             .Top       = 15
120:             .Left      = 10
121:             .Width     = 769
122:             .Height    = 40
123:             .FontName  = "Tahoma"
124:             .FontSize  = 16
125:             .FontBold  = .T.
126:             .ForeColor = RGB(0, 0, 0)
127:             .BackStyle = 0
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
133:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
134:             .Top       = 18
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 46

*-- Linhas 177 a 373:
177:             .WordWrap        = .T.
178:             .AutoSize        = .F.
179:         ENDWITH
180:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
181: 
182:         *-- Visualizar
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
185:             .Caption         = "Visualizar"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 80
190:             .Width           = 75
191:             .Height          = 75
192:             .BackColor       = RGB(255, 255, 255)
193:             .ForeColor       = RGB(90, 90, 90)
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .FontBold        = .T.
197:             .FontItalic      = .T.
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
205: 
206:         *-- Alterar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
209:             .Caption         = "Alterar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 155
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontSize        = 8
220:             .FontBold        = .T.
221:             .FontItalic      = .T.
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .MousePointer    = 15
225:             .WordWrap        = .T.
226:             .AutoSize        = .F.
227:         ENDWITH
228:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
229: 
230:         *-- Excluir
231:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
232:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
233:             .Caption         = "Excluir"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 230
238:             .Width           = 75
239:             .Height          = 75
240:             .BackColor       = RGB(255, 255, 255)
241:             .ForeColor       = RGB(90, 90, 90)
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:         ENDWITH
252:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
253: 
254:         *-- Buscar
255:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
256:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
257:             .Caption         = "Buscar"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 305
262:             .Width           = 75
263:             .Height          = 75
264:             .BackColor       = RGB(255, 255, 255)
265:             .ForeColor       = RGB(90, 90, 90)
266:             .FontName        = "Comic Sans MS"
267:             .FontSize        = 8
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:         ENDWITH
276:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
277: 
278:         *-- Container Encerrar (canonico - prevalece sobre PILAR 1)
279:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
280:         WITH loc_oPagina.cnt_4c_Saida
281:             .Top         = 29
282:             .Left        = 917
283:             .Width       = 90
284:             .Height      = 85
285:             .BackStyle   = 0
286:             .BorderWidth = 0
287:             .Visible     = .T.
288:         ENDWITH
289: 
290:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
292:             .Caption         = "Encerrar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 5
297:             .Width           = 75
298:             .Height          = 75
299:             .BackColor       = RGB(255, 255, 255)
300:             .ForeColor       = RGB(90, 90, 90)
301:             .FontName        = "Comic Sans MS"
302:             .FontSize        = 8
303:             .FontBold        = .T.
304:             .FontItalic      = .T.
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:         ENDWITH
311:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
312: 
313:         *-- Botao Etiquetas (cmdEtiquetas original: Top=-1+29=28, Left=464)
314:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
315:         WITH loc_oPagina.cmd_4c_Etiquetas
316:             .Caption         = "Etiquetas"
317:             .Top             = 28
318:             .Left            = 464
319:             .Width           = 75
320:             .Height          = 75
321:             .BackColor       = RGB(255, 255, 255)
322:             .ForeColor       = RGB(90, 90, 90)
323:             .FontName        = "Comic Sans MS"
324:             .FontSize        = 8
325:             .FontBold        = .T.
326:             .FontItalic      = .T.
327:             .Themes          = .F.
328:             .SpecialEffect   = 0
329:             .MousePointer    = 15
330:             .WordWrap        = .T.
331:             .AutoSize        = .F.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")
334: 
335:         *-- Grid lista (Grade original: codigos 100px, descricaos 290px)
336:         *-- Top=88+29=117, Left=26, Width=890, Height=498
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 117
340:             .Left               = 26
341:             .Width              = 890
342:             .Height             = 498
343:             .FontName           = "Verdana"
344:             .FontSize           = 8
345:             .ForeColor          = RGB(90, 90, 90)
346:             .BackColor          = RGB(255, 255, 255)
347:             .GridLineColor      = RGB(238, 238, 238)
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         *-- Definir colunas FORA de WITH para que existam imediatamente
360:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
361: 
362:         WITH loc_oPagina.grd_4c_Lista.Column1
363:             .Width               = 100
364:             .Alignment           = 0
365:             .Header1.Caption     = "C" + CHR(243) + "digo"
366:         ENDWITH
367: 
368:         WITH loc_oPagina.grd_4c_Lista.Column2
369:             .Width               = 290
370:             .Alignment           = 0
371:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
372:         ENDWITH
373: 

*-- Linhas 386 a 435:
386: 
387:         THIS.ConfigurarPainelEtiquetas(loc_oPagina.cnt_4c_Etiquetas)
388: 
389:         THIS.TornarControlesVisiveis(loc_oPagina)
390:     ENDPROC
391: 
392:     *--------------------------------------------------------------------------
393:     * ConfigurarPaginaDados - Page2: cabecalho, campos (Parte 1) e botoes acao
394:     *--------------------------------------------------------------------------
395:     PROTECTED PROCEDURE ConfigurarPaginaDados()
396:         LOCAL loc_oPagina
397:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
398: 
399:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
400:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
401: 
402:         *-- Cabecalho escuro (mesmo estilo da Page1): Top=1+29=30
403:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
404:         WITH loc_oPagina.cnt_4c_Cabecalho
405:             .Top         = 30
406:             .Left        = 0
407:             .Width       = THIS.Width
408:             .Height      = 80
409:             .BackColor   = RGB(100, 100, 100)
410:             .BorderWidth = 0
411:             .Visible     = .T.
412:         ENDWITH
413: 
414:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
415:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
416:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
417:             .Top       = 15
418:             .Left      = 10
419:             .Width     = 769
420:             .Height    = 40
421:             .FontName  = "Tahoma"
422:             .FontSize  = 16
423:             .FontBold  = .T.
424:             .ForeColor = RGB(0, 0, 0)
425:             .BackStyle = 0
426:             .Visible   = .T.
427:         ENDWITH
428: 
429:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
430:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
431:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
432:             .Top       = 18
433:             .Left      = 10
434:             .Width     = 769
435:             .Height    = 46

*-- Linhas 474 a 540:
474:             .WordWrap        = .T.
475:             .AutoSize        = .F.
476:         ENDWITH
477:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
478: 
479:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
480:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
481:             .Caption         = "Encerrar"
482:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
483:             .PicturePosition = 13
484:             .Top             = 5
485:             .Left            = 80
486:             .Width           = 75
487:             .Height          = 75
488:             .BackColor       = RGB(255, 255, 255)
489:             .ForeColor       = RGB(90, 90, 90)
490:             .FontName        = "Comic Sans MS"
491:             .FontSize        = 8
492:             .FontBold        = .T.
493:             .FontItalic      = .T.
494:             .Themes          = .F.
495:             .SpecialEffect   = 0
496:             .MousePointer    = 15
497:             .WordWrap        = .T.
498:             .AutoSize        = .F.
499:         ENDWITH
500:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
501: 
502:         *-- Label "Codigo :" (Say8): Top=155+29=184, Left=319, Width=42
503:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
504:         WITH loc_oPagina.lbl_4c_Codigo
505:             .Caption   = "C" + CHR(243) + "digo :"
506:             .Top       = 184
507:             .Left      = 319
508:             .Width     = 42
509:             .Height    = 17
510:             .FontName  = "Tahoma"
511:             .FontSize  = 8
512:             .FontBold  = .F.
513:             .ForeColor = RGB(90, 90, 90)
514:             .BackStyle = 0
515:             .Alignment = 1
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         *-- TextBox Codigo (get_codigos): Top=152+29=181, Left=366, Width=80, Height=23
520:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
521:         WITH loc_oPagina.txt_4c_Codigos
522:             .Value         = ""
523:             .Top           = 181
524:             .Left          = 366
525:             .Width         = 80
526:             .Height        = 23
527:             .MaxLength     = 10
528:             .FontName      = "Tahoma"
529:             .FontSize      = 8
530:             .ForeColor     = RGB(90, 90, 90)
531:             .BackColor     = RGB(255, 255, 255)
532:             .SpecialEffect = 0
533:             .BorderStyle   = 1
534:             .Themes        = .F.
535:             .Enabled       = .F.
536:             .Visible       = .T.
537:         ENDWITH
538: 
539:         *-- CheckBox "Imprime Etiqueta" (chkEtiqueta): Top=155+29=184, Left=455
540:         loc_oPagina.AddObject("chk_4c_Etiqueta", "CheckBox")

*-- Linhas 669 a 1230:
669:             .Visible  = .F.
670:         ENDWITH
671: 
672:         loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
673:         loc_oPagina.opt_4c_Tipos.ButtonCount = 3
674:         WITH loc_oPagina.opt_4c_Tipos
675:             .BackStyle   = 0
676:             .BorderStyle = 0
677:             .Top         = 522
678:             .Left        = 377
679:             .Width       = 262
680:             .Height      = 27
681:             .Value       = 1
682:             .Visible     = .F.
683:         ENDWITH
684:         WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
685:             .Caption  = "Produto"
686:             .Left     = 5
687:             .Top      = 5
688:             .Width    = 63
689:             .AutoSize = .T.
690:             .FontName = "Verdana"
691:             .FontSize = 8
692:             .ForeColor = RGB(36, 84, 155)
693:             .BackStyle = 0
694:         ENDWITH
695:         WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
696:             .Caption  = "Agendamento"
697:             .Left     = 81
698:             .Top      = 5
699:             .Width    = 98
700:             .AutoSize = .T.
701:             .FontName = "Verdana"
702:             .FontSize = 8
703:             .ForeColor = RGB(36, 84, 155)
704:             .BackStyle = 0
705:         ENDWITH
706:         WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
707:             .Caption  = "Dep" + CHR(243) + "sito"
708:             .Left     = 183
709:             .Top      = 7
710:             .Width    = 69
711:             .AutoSize = .T.
712:             .FontName = "Verdana"
713:             .FontSize = 8
714:             .ForeColor = RGB(36, 84, 155)
715:             .BackStyle = 0
716:         ENDWITH
717: 
718:         THIS.TornarControlesVisiveis(loc_oPagina)
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     * CarregarLista - Busca registros e vincula ao grid
723:     *--------------------------------------------------------------------------
724:     PROCEDURE CarregarLista()
725:         LOCAL loc_lResultado, loc_oGrid
726:         loc_lResultado = .F.
727: 
728:         TRY
729:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
730:                 loc_lResultado = .T.
731:             ELSE
732:                 IF THIS.this_oBusinessObject.Buscar("")
733:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
734: 
735:                     loc_oGrid.ColumnCount = 2
736:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
737:                     loc_oGrid.ColumnCount  = 2
738: 
739:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
740:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
741:                     loc_oGrid.Column1.Width          = 100
742:                     loc_oGrid.Column2.Width          = 290
743:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
744:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745: 
746:                     THIS.FormatarGridLista(loc_oGrid)
747:                     loc_lResultado = .T.
748:                 ELSE
749:                     loc_lResultado = .F.
750:                 ENDIF
751:             ENDIF
752:         CATCH TO loc_oErro
753:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
754:             loc_lResultado = .F.
755:         ENDTRY
756: 
757:         RETURN loc_lResultado
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
762:     *--------------------------------------------------------------------------
763:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
764:         LOCAL loc_lResultado
765:         loc_lResultado = .F.
766: 
767:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
768:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
769:             IF par_nPagina = 1
770:                 THIS.CarregarLista()
771:             ENDIF
772:             loc_lResultado = .T.
773:         ENDIF
774: 
775:         RETURN loc_lResultado
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * BtnIncluirClick - Prepara form para inclusao de novo registro
780:     *--------------------------------------------------------------------------
781:     PROCEDURE BtnIncluirClick()
782:         LOCAL loc_cCodigo
783:         loc_cCodigo = ""
784: 
785:         THIS.this_oBusinessObject.NovoRegistro()
786:         THIS.LimparCampos()
787:         THIS.this_cModoAtual = "INCLUIR"
788: 
789:         *-- Gerar codigo automatico (equivalente a Padl(fGerUniqueKey([SigPrLcl]),10,'0'))
790:         TRY
791:             loc_cCodigo = THIS.this_oBusinessObject.GerarCodigo()
792:             THIS.this_oBusinessObject.this_cCodigos = loc_cCodigo
793:         CATCH TO loc_oErro
794:             MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
795:         ENDTRY
796: 
797:         THIS.HabilitarCampos(.T.)
798:         THIS.AjustarBotoesPorModo()
799:         THIS.AlternarPagina(2)
800: 
801:         LOCAL loc_oPagina
802:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
803:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
804:             loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(loc_cCodigo)
805:             loc_oPagina.txt_4c_Descricaos.SetFocus()
806:         ENDIF
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * BtnVisualizarClick - Carrega registro selecionado em modo leitura
811:     *--------------------------------------------------------------------------
812:     PROCEDURE BtnVisualizarClick()
813:         LOCAL loc_cCodigo
814:         loc_cCodigo = ""
815: 
816:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
817:             SELECT cursor_4c_Dados
818:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
819:         ENDIF
820: 
821:         IF EMPTY(loc_cCodigo)
822:             MsgAviso("Selecione um registro na lista.", "Visualizar")
823:             RETURN
824:         ENDIF
825: 
826:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
827:             THIS.this_cModoAtual = "VISUALIZAR"
828:             THIS.BOParaForm()
829:             THIS.HabilitarCampos(.F.)
830:             THIS.AjustarBotoesPorModo()
831:             THIS.AlternarPagina(2)
832: 
833:             LOCAL loc_oPagina
834:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
835:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
836:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
837:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
838:                 ENDIF
839:             ENDIF
840:         ELSE
841:             MsgErro("Erro ao carregar registro.", "Visualizar")
842:         ENDIF
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * BtnAlterarClick - Carrega registro selecionado para edicao
847:     *--------------------------------------------------------------------------
848:     PROCEDURE BtnAlterarClick()
849:         LOCAL loc_cCodigo
850:         loc_cCodigo = ""
851: 
852:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
853:             SELECT cursor_4c_Dados
854:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
855:         ENDIF
856: 
857:         IF EMPTY(loc_cCodigo)
858:             MsgAviso("Selecione um registro na lista.", "Alterar")
859:             RETURN
860:         ENDIF
861: 
862:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
863:             THIS.this_oBusinessObject.EditarRegistro()
864:             THIS.this_cModoAtual = "ALTERAR"
865:             THIS.BOParaForm()
866:             THIS.HabilitarCampos(.T.)
867:             THIS.AjustarBotoesPorModo()
868:             THIS.AlternarPagina(2)
869: 
870:             LOCAL loc_oPagina
871:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
872:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
873:                 loc_oPagina.txt_4c_Descricaos.SetFocus()
874:             ENDIF
875:         ELSE
876:             MsgErro("Erro ao carregar registro.", "Alterar")
877:         ENDIF
878:     ENDPROC
879: 
880:     *--------------------------------------------------------------------------
881:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnExcluirClick()
884:         LOCAL loc_cCodigo, loc_cDescricao
885:         loc_cCodigo    = ""
886:         loc_cDescricao = ""
887: 
888:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
889:             SELECT cursor_4c_Dados
890:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
891:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
892:         ENDIF
893: 
894:         IF EMPTY(loc_cCodigo)
895:             MsgAviso("Selecione um registro na lista.", "Excluir")
896:             RETURN
897:         ENDIF
898: 
899:         IF MsgConfirma("Excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
900:                        loc_cCodigo + " - " + loc_cDescricao + "?", "Excluir")
901:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
902:                 IF THIS.this_oBusinessObject.Excluir()
903:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
904:                     THIS.CarregarLista()
905:                 ELSE
906:                     MsgErro("Erro ao excluir registro.", "Excluir")
907:                 ENDIF
908:             ENDIF
909:         ENDIF
910:     ENDPROC
911: 
912:     *--------------------------------------------------------------------------
913:     * BtnBuscarClick - Filtra registros por codigo ou descricao
914:     *--------------------------------------------------------------------------
915:     PROCEDURE BtnBuscarClick()
916:         LOCAL loc_cBusca, loc_cSQL, loc_nResult, loc_oGrid
917:         loc_cBusca = ""
918: 
919:         loc_cBusca = INPUTBOX("Informe o c" + CHR(243) + "digo ou descri" + ;
920:                               CHR(231) + CHR(227) + "o:", ;
921:                               "Buscar Localiza" + CHR(231) + CHR(227) + "o", "")
922: 
923:         IF VARTYPE(loc_cBusca) != "C"
924:             RETURN
925:         ENDIF
926: 
927:         TRY
928:             IF !EMPTY(ALLTRIM(loc_cBusca))
929:                 loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
930:                            " FROM SigPrLcl" + ;
931:                            " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cBusca) + "%") + ;
932:                            " ORDER BY codigos"
933: 
934:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
935: 
936:                 IF loc_nResult >= 0
937:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
938:                     loc_oGrid.ColumnCount = 2
939:                     loc_oGrid.RecordSource    = "cursor_4c_Dados"
940:                     loc_oGrid.ColumnCount     = 2
941:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
942:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
943:                     loc_oGrid.Column1.Width          = 100
944:                     loc_oGrid.Column2.Width          = 290
945:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
946:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
947:                     THIS.FormatarGridLista(loc_oGrid)
948: 
949:                     IF RECCOUNT("cursor_4c_Dados") = 0
950:                         MsgAviso("Nenhum registro encontrado para '" + ALLTRIM(loc_cBusca) + "'.", "Buscar")
951:                     ENDIF
952:                 ELSE
953:                     MsgErro("Erro na busca:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
954:                 ENDIF
955:             ELSE
956:                 THIS.CarregarLista()
957:             ENDIF
958:         CATCH TO loc_oErro
959:             MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Erro")
960:         ENDTRY
961:     ENDPROC
962: 
963:     *--------------------------------------------------------------------------
964:     * BtnEncerrarClick - Fecha o formulario
965:     *--------------------------------------------------------------------------
966:     PROCEDURE BtnEncerrarClick()
967:         THIS.Release()
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     * BtnEtiquetasClick - Alterna visibilidade do painel de impressao de etiquetas
972:     * Logica baseada em SIGCDPRL.Pagina.Lista.cntEtiquetas.CmdCancel.Click
973:     *--------------------------------------------------------------------------
974:     PROCEDURE BtnEtiquetasClick()
975:         THIS.ImprimirEtiquetas()
976:     ENDPROC
977: 
978:     *--------------------------------------------------------------------------
979:     * BtnSalvarClick - Valida e salva registro (Confirmar na Page2)
980:     * Validacoes do legado: descricao obrigatoria, codigo <= 3 chars se etiqueta
981:     *--------------------------------------------------------------------------
982:     PROCEDURE BtnSalvarClick()
983:         LOCAL loc_oPagina, loc_cDescricao, loc_cCodigo, loc_nEtiqueta
984:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
985:         loc_cDescricao = ""
986:         loc_cCodigo    = ""
987:         loc_nEtiqueta  = 0
988: 
989:         *-- Coletar valores para validacao pre-TRY
990:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
991:             loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
992:         ENDIF
993:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
994:             loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
995:         ENDIF
996:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
997:             loc_nEtiqueta = IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
998:         ENDIF
999: 
1000:         *-- Validacoes fora do TRY (REGRA CRITICA)
1001:         IF EMPTY(loc_cDescricao)
1002:             MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Validar")
1003:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1004:                 loc_oPagina.txt_4c_Descricaos.SetFocus()
1005:             ENDIF
1006:             RETURN
1007:         ENDIF
1008: 
1009:         IF loc_nEtiqueta = 1 AND LEN(loc_cCodigo) > 3
1010:             MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + ;
1011:                      "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Validar")
1012:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1013:                 loc_oPagina.txt_4c_Codigos.SetFocus()
1014:             ENDIF
1015:             RETURN
1016:         ENDIF
1017: 
1018:         TRY
1019:             THIS.FormParaBO()
1020:             IF THIS.this_oBusinessObject.Salvar()
1021:                 MsgInfo("Registro salvo com sucesso!")
1022:                 THIS.this_cModoAtual = "LISTA"
1023:                 THIS.AlternarPagina(1)
1024:             ELSE
1025:                 MsgErro("Erro ao salvar registro.", "Salvar")
1026:             ENDIF
1027:         CATCH TO loc_oErro
1028:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1029:         ENDTRY
1030:     ENDPROC
1031: 
1032:     *--------------------------------------------------------------------------
1033:     * BtnCancelarClick - Cancela edicao e retorna para lista
1034:     *--------------------------------------------------------------------------
1035:     PROCEDURE BtnCancelarClick()
1036:         THIS.this_cModoAtual = "LISTA"
1037:         THIS.AlternarPagina(1)
1038:         THIS.CarregarLista()
1039:     ENDPROC
1040: 
1041:     *--------------------------------------------------------------------------
1042:     * FormParaBO - Transfere valores do Form para o BO
1043:     *--------------------------------------------------------------------------
1044:     PROTECTED PROCEDURE FormParaBO()
1045:         LOCAL loc_oPagina
1046:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1047: 
1048:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1049:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1050:         ENDIF
1051:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1052:             THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1053:         ENDIF
1054:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1055:             THIS.this_oBusinessObject.this_nEtiquetas = ;
1056:                 IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
1057:         ENDIF
1058:     ENDPROC
1059: 
1060:     *--------------------------------------------------------------------------
1061:     * BOParaForm - Transfere valores do BO para o Form
1062:     *--------------------------------------------------------------------------
1063:     PROTECTED PROCEDURE BOParaForm()
1064:         LOCAL loc_oPagina
1065:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1066: 
1067:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1068:             loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1069:         ENDIF
1070:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1071:             loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricaos)
1072:         ENDIF
1073:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1074:             loc_oPagina.chk_4c_Etiqueta.Value = (THIS.this_oBusinessObject.this_nEtiquetas .Value = IIF(THIS.this_oBusinessObject.this_nEtiquetas = 1, 1, 0))
1075:         ENDIF
1076:     ENDPROC
1077: 
1078:     *--------------------------------------------------------------------------
1079:     * HabilitarCampos - Habilita/desabilita campos da Page2
1080:     *--------------------------------------------------------------------------
1081:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1082:         LOCAL loc_oPagina
1083:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1084: 
1085:         *-- Codigo: editavel apenas em INCLUIR
1086:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1087:             loc_oPagina.txt_4c_Codigos.Enabled = ;
1088:                 (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1089:         ENDIF
1090:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1091:             loc_oPagina.txt_4c_Descricaos.Enabled = par_lHabilitar
1092:         ENDIF
1093:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1094:             loc_oPagina.chk_4c_Etiqueta.Enabled = par_lHabilitar
1095:         ENDIF
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     * LimparCampos - Limpa valores dos campos da Page2
1100:     *--------------------------------------------------------------------------
1101:     PROTECTED PROCEDURE LimparCampos()
1102:         LOCAL loc_oPagina
1103:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1104: 
1105:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1106:             loc_oPagina.txt_4c_Codigos.Value    = ""
1107:         ENDIF
1108:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1109:             loc_oPagina.txt_4c_Descricaos.Value = ""
1110:         ENDIF
1111:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1112:             loc_oPagina.chk_4c_Etiqueta.Value   = 0
1113:         ENDIF
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar por modo atual
1118:     *--------------------------------------------------------------------------
1119:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1120:         LOCAL loc_oPagina, loc_lEditar
1121:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1122:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1123: 
1124:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1125:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1126:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1127:             ENDIF
1128:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1129:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1130:             ENDIF
1131:         ENDIF
1132:     ENDPROC
1133: 
1134:     *--------------------------------------------------------------------------
1135:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1136:     * cnt_4c_Etiquetas preservado oculto (painel flutuante de etiquetas)
1137:     *--------------------------------------------------------------------------
1138:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1139:         LOCAL loc_nI, loc_oObjeto, loc_cNome
1140: 
1141:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1142:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1143: 
1144:             IF VARTYPE(loc_oObjeto) = "O"
1145:                 loc_cNome = UPPER(loc_oObjeto.Name)
1146: 
1147:                 *-- Pular painel flutuante (deve iniciar oculto), mas recursionar filhos
1148:                 IF INLIST(loc_cNome, "CNT_4C_ETIQUETAS")
1149:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1150:                     LOOP
1151:                 ENDIF
1152: 
1153:                 *-- Pular campos sem uso (devem permanecer ocultos)
1154:                 IF INLIST(loc_cNome, "LBL_4C_SEMUSO2", "LBL_4C_SEMUSO3", "LBL_4C_SEMUSO22", ;
1155:                                      "TXT_4C_DIVISAOS", "TXT_4C_BLOQUEIOS", "OPT_4C_TIPOS")
1156:                     LOOP
1157:                 ENDIF
1158: 
1159:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1160:                     loc_oObjeto.Visible = .T.
1161:                 ENDIF
1162: 
1163:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1164:                     LOCAL loc_nP
1165:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1166:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1167:                     ENDFOR
1168:                 ENDIF
1169: 
1170:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1171:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1172:                 ENDIF
1173:             ENDIF
1174:         ENDFOR
1175:     ENDPROC
1176: 
1177:     *--------------------------------------------------------------------------
1178:     * FormatarGridLista - Formata visual do grid (FontName Tahoma, size 8)
1179:     *--------------------------------------------------------------------------
1180:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1181:         WITH par_oGrid
1182:             .FontName = "Tahoma"
1183:             .FontSize = 8
1184:         ENDWITH
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * ConfigurarPainelEtiquetas - Cria controles internos do painel de etiquetas
1189:     *--------------------------------------------------------------------------
1190:     PROTECTED PROCEDURE ConfigurarPainelEtiquetas(par_oCnt)
1191:         LOCAL loc_oErro
1192:         TRY
1193:             *-- Titulo
1194:             par_oCnt.AddObject("lbl_4c_TituloEtq", "Label")
1195:             WITH par_oCnt.lbl_4c_TituloEtq
1196:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
1197:                 .FontBold  = .T.
1198:                 .FontName  = "Tahoma"
1199:                 .FontSize  = 12
1200:                 .BackStyle = 0
1201:                 .ForeColor = RGB(90, 90, 90)
1202:                 .Height    = 21
1203:                 .Left      = 113
1204:                 .Top       = 5
1205:                 .Width     = 194
1206:                 .Visible   = .T.
1207:             ENDWITH
1208: 
1209:             *-- Label Codigo
1210:             par_oCnt.AddObject("lbl_4c_CodigoEtq", "Label")
1211:             WITH par_oCnt.lbl_4c_CodigoEtq
1212:                 .Caption   = "C" + CHR(243) + "digo :"
1213:                 .FontName  = "Tahoma"
1214:                 .FontSize  = 8
1215:                 .BackStyle = 0
1216:                 .ForeColor = RGB(90, 90, 90)
1217:                 .Height    = 15
1218:                 .Left      = 7
1219:                 .Top       = 36
1220:                 .Width     = 42
1221:                 .Visible   = .T.
1222:             ENDWITH
1223: 
1224:             *-- TextBox Codigo (getCodigos: MaxLength=3, codigo da localizacao)
1225:             par_oCnt.AddObject("txt_4c_CodigosEtq", "TextBox")
1226:             WITH par_oCnt.txt_4c_CodigosEtq
1227:                 .Value         = ""
1228:                 .FontName      = "Tahoma"
1229:                 .FontSize      = 8
1230:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1236 a 1279:
1236:                 .Width         = 31
1237:                 .Visible       = .T.
1238:             ENDWITH
1239:             BINDEVENT(par_oCnt.txt_4c_CodigosEtq, "KeyPress", THIS, "CodigosEtqLostFocus")
1240: 
1241:             *-- Label Quantidade
1242:             par_oCnt.AddObject("lbl_4c_QuantEtq", "Label")
1243:             WITH par_oCnt.lbl_4c_QuantEtq
1244:                 .Caption   = "Quantidade :"
1245:                 .FontName  = "Tahoma"
1246:                 .FontSize  = 8
1247:                 .BackStyle = 0
1248:                 .ForeColor = RGB(90, 90, 90)
1249:                 .Height    = 15
1250:                 .Left      = 99
1251:                 .Top       = 37
1252:                 .Width     = 65
1253:                 .Visible   = .T.
1254:             ENDWITH
1255: 
1256:             *-- TextBox Quantidade (getQtde: numero de copias)
1257:             par_oCnt.AddObject("txt_4c_QtdeEtq", "TextBox")
1258:             WITH par_oCnt.txt_4c_QtdeEtq
1259:                 .Value         = 1
1260:                 .FontName      = "Tahoma"
1261:                 .FontSize      = 8
1262:                 .ForeColor     = RGB(90, 90, 90)
1263:                 .Height        = 23
1264:                 .InputMask     = "999"
1265:                 .Left          = 173
1266:                 .MaxLength     = 3
1267:                 .SpecialEffect = 1
1268:                 .Top           = 34
1269:                 .Width         = 31
1270:                 .Visible       = .T.
1271:             ENDWITH
1272: 
1273:             *-- Label Tipo
1274:             par_oCnt.AddObject("lbl_4c_TipoEtq", "Label")
1275:             WITH par_oCnt.lbl_4c_TipoEtq
1276:                 .Caption   = "Tipo :"
1277:                 .FontName  = "Tahoma"
1278:                 .FontSize  = 8
1279:                 .BackStyle = 0

*-- Linhas 1285 a 1367:
1285:                 .Visible   = .T.
1286:             ENDWITH
1287: 
1288:             *-- OptionGroup Tipo (optTipo: Pequena=1, Grande=2)
1289:             par_oCnt.AddObject("opt_4c_TipoEtq", "OptionGroup")
1290:             par_oCnt.opt_4c_TipoEtq.ButtonCount = 2
1291:             WITH par_oCnt.opt_4c_TipoEtq
1292:                 .BackStyle   = 0
1293:                 .BorderStyle = 0
1294:                 .Height      = 25
1295:                 .Left        = 52
1296:                 .Top         = 61
1297:                 .Value       = 1
1298:                 .Width       = 141
1299:                 .Visible     = .T.
1300:             ENDWITH
1301:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(1)
1302:                 .AutoSize  = .T.
1303:                 .BackStyle = 0
1304:                 .Caption   = "Pequena"
1305:                 .FontName  = "Tahoma"
1306:                 .FontSize  = 8
1307:                 .ForeColor = RGB(90, 90, 90)
1308:                 .Height    = 15
1309:                 .Left      = 5
1310:                 .Top       = 5
1311:                 .Width     = 60
1312:             ENDWITH
1313:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(2)
1314:                 .AutoSize  = .T.
1315:                 .BackStyle = 0
1316:                 .Caption   = "Grande"
1317:                 .FontName  = "Tahoma"
1318:                 .FontSize  = 8
1319:                 .ForeColor = RGB(90, 90, 90)
1320:                 .Height    = 15
1321:                 .Left      = 78
1322:                 .Top       = 5
1323:                 .Width     = 53
1324:             ENDWITH
1325: 
1326:             *-- OptionGroup Impressora (optImpressora: populado dinamicamente em ImprimirEtiquetas)
1327:             par_oCnt.AddObject("opt_4c_Impressora", "OptionGroup")
1328:             par_oCnt.opt_4c_Impressora.ButtonCount = 1
1329:             WITH par_oCnt.opt_4c_Impressora
1330:                 .AutoSize    = .F.
1331:                 .BackStyle   = 0
1332:                 .BorderStyle = 0
1333:                 .Height      = 156
1334:                 .Left        = 12
1335:                 .Top         = 94
1336:                 .Value       = 1
1337:                 .Width       = 200
1338:                 .Visible     = .T.
1339:             ENDWITH
1340:             WITH par_oCnt.opt_4c_Impressora.Buttons(1)
1341:                 .AutoSize  = .F.
1342:                 .BackStyle = 0
1343:                 .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
1344:                 .FontName  = "Tahoma"
1345:                 .FontSize  = 8
1346:                 .ForeColor = RGB(90, 90, 90)
1347:                 .Height    = 17
1348:                 .Left      = 4
1349:                 .Top       = 10
1350:                 .Width     = 186
1351:             ENDWITH
1352: 
1353:             *-- Label Densidade
1354:             par_oCnt.AddObject("lbl_4c_DensidadeEtq", "Label")
1355:             WITH par_oCnt.lbl_4c_DensidadeEtq
1356:                 .Caption   = "Densidade"
1357:                 .FontName  = "Tahoma"
1358:                 .FontSize  = 7
1359:                 .BackStyle = 0
1360:                 .ForeColor = RGB(90, 90, 90)
1361:                 .Left      = 234
1362:                 .Top       = 37
1363:                 .Width     = 45
1364:                 .Visible   = .T.
1365:             ENDWITH
1366: 
1367:             *-- Spinner Densidade (spnDensidade: range 0-20, default 20)

*-- Linhas 1468 a 1608:
1468:                 .Width         = 45
1469:                 .Visible       = .T.
1470:             ENDWITH
1471:             BINDEVENT(par_oCnt.cmd_4c_OkEtq, "Click", THIS, "CmdOkEtqClick")
1472: 
1473:             *-- Botao Cancelar (CmdCancel: fecha painel sem imprimir)
1474:             par_oCnt.AddObject("cmd_4c_CancelEtq", "CommandButton")
1475:             WITH par_oCnt.cmd_4c_CancelEtq
1476:                 .Caption       = "Sair"
1477:                 .BackColor     = RGB(255, 255, 255)
1478:                 .Cancel        = .T.
1479:                 .ForeColor     = RGB(90, 90, 90)
1480:                 .FontName      = "Tahoma"
1481:                 .FontSize      = 8
1482:                 .Height        = 45
1483:                 .Left          = 367
1484:                 .MousePointer  = 15
1485:                 .SpecialEffect = 0
1486:                 .Themes        = .F.
1487:                 .ToolTipText   = "[ESC] Sair"
1488:                 .Top           = 206
1489:                 .Width         = 45
1490:                 .Visible       = .T.
1491:             ENDWITH
1492:             BINDEVENT(par_oCnt.cmd_4c_CancelEtq, "Click", THIS, "CmdCancelEtqClick")
1493: 
1494:         CATCH TO loc_oErro
1495:             MsgErro(loc_oErro.Message, "Erro ao configurar painel de etiquetas")
1496:         ENDTRY
1497:     ENDPROC
1498: 
1499:     *--------------------------------------------------------------------------
1500:     * ImprimirEtiquetas - Popula impressoras e exibe painel de etiquetas
1501:     * Equivalente ao metodo impetiqueta do legado SIGCDPRL
1502:     *--------------------------------------------------------------------------
1503:     PROTECTED PROCEDURE ImprimirEtiquetas()
1504:         LOCAL loc_oPagina, loc_oCnt, loc_lSucesso
1505:         LOCAL loc_nPrinters, loc_nI, loc_cI
1506:         LOCAL loc_cSQL, loc_nResult, loc_oErro
1507:         LOCAL loc_nMaxImpEti, loc_nAjVerts, loc_nAjHorzs
1508:         LOCAL loc_nImpres, loc_nOk, loc_nBtnCount, loc_nTop, loc_nHeight
1509: 
1510:         DIMENSION laPrinters(1)
1511:         DIMENSION laImpOk(1)
1512: 
1513:         loc_lSucesso   = .F.
1514:         loc_nMaxImpEti = 3
1515:         loc_nAjVerts   = 0
1516:         loc_nAjHorzs   = 0
1517: 
1518:         *-- Verificar impressoras instaladas (fora do TRY para sair cedo)
1519:         loc_nPrinters = APrinters(laPrinters)
1520:         IF loc_nPrinters = 0
1521:             MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Etiquetas")
1522:             RETURN loc_lSucesso
1523:         ENDIF
1524: 
1525:         TRY
1526:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1527:             loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas
1528: 
1529:             *-- Uppercase e ordenar nomes de impressoras (coluna 1)
1530:             FOR loc_nI = 1 TO loc_nPrinters
1531:                 laPrinters(loc_nI, 1) = UPPER(laPrinters(loc_nI, 1))
1532:             ENDFOR
1533:             ASORT(laPrinters)
1534: 
1535:             *-- Parametros de etiquetas em SigCdPam
1536:             loc_cSQL    = "SELECT nMaxImpEti, AjVerts, AjHorzs FROM SigCdPam"
1537:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamEtq")
1538:             IF loc_nResult > 0 AND USED("cursor_4c_ParamEtq") AND RECCOUNT("cursor_4c_ParamEtq") > 0
1539:                 SELECT cursor_4c_ParamEtq
1540:                 loc_nMaxImpEti = IIF(ISNULL(cursor_4c_ParamEtq.nMaxImpEti), 3, cursor_4c_ParamEtq.nMaxImpEti)
1541:                 loc_nAjVerts   = IIF(ISNULL(cursor_4c_ParamEtq.AjVerts),    0, cursor_4c_ParamEtq.AjVerts)
1542:                 loc_nAjHorzs   = IIF(ISNULL(cursor_4c_ParamEtq.AjHorzs),    0, cursor_4c_ParamEtq.AjHorzs)
1543:             ENDIF
1544:             IF USED("cursor_4c_ParamEtq")
1545:                 USE IN cursor_4c_ParamEtq
1546:             ENDIF
1547: 
1548:             *-- Impressoras de etiquetas cadastradas em SigCdMp (nTpImpres=2)
1549:             loc_cSQL    = "SELECT Impres, nTpImpres FROM SigCdMp ORDER BY Impres"
1550:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdMpEtq")
1551:             loc_nImpres = 1
1552:             IF loc_nResult > 0 AND USED("cursor_4c_SigCdMpEtq") AND RECCOUNT("cursor_4c_SigCdMpEtq") > 0
1553:                 SELECT cursor_4c_SigCdMpEtq
1554:                 SCAN FOR cursor_4c_SigCdMpEtq.nTpImpres = 2
1555:                     loc_nOk = ASCAN(laPrinters, ALLTRIM(UPPER(cursor_4c_SigCdMpEtq.Impres)))
1556:                     IF loc_nOk > 0
1557:                         DIMENSION laImpOk(loc_nImpres)
1558:                         laImpOk(loc_nImpres) = laPrinters(loc_nOk)
1559:                         loc_nImpres = loc_nImpres + 1
1560:                     ENDIF
1561:                 ENDSCAN
1562:             ENDIF
1563:             IF USED("cursor_4c_SigCdMpEtq")
1564:                 USE IN cursor_4c_SigCdMpEtq
1565:             ENDIF
1566:             loc_nImpres = loc_nImpres - 1
1567: 
1568:             *-- Popular OptionGroup de impressoras dinamicamente
1569:             loc_nTop    = loc_oCnt.opt_4c_Impressora.Top
1570:             loc_nHeight = 15
1571:             IF loc_nImpres > 0
1572:                 loc_nBtnCount = MIN(loc_nImpres, MAX(loc_nMaxImpEti, 3))
1573:                 loc_oCnt.opt_4c_Impressora.ButtonCount = loc_nBtnCount
1574:                 FOR loc_nI = 1 TO loc_nBtnCount
1575:                     loc_cI = ALLTRIM(STR(loc_nI))
1576:                     WITH loc_oCnt.opt_4c_Impressora.Buttons(loc_nI)
1577:                         .AutoSize = .F.
1578:                         .Caption  = " \<" + loc_cI + ". " + laImpOk(loc_nI)
1579:                         .FontSize = 8
1580:                         .Tag      = UPPER(laImpOk(loc_nI))
1581:                         .Top      = loc_nTop
1582:                         .Width    = 180
1583:                     ENDWITH
1584:                     loc_nTop    = loc_nTop + 20
1585:                     loc_nHeight = loc_nHeight + 20
1586:                 ENDFOR
1587:             ELSE
1588:                 loc_oCnt.opt_4c_Impressora.ButtonCount = 1
1589:                 loc_nOk = ASCAN(laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
1590:                 WITH loc_oCnt.opt_4c_Impressora.Buttons(1)
1591:                     .AutoSize = .F.
1592:                     .Caption  = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
1593:                     .BackStyle = 0
1594:                     .Enabled  = (loc_nOk > 0)
1595:                     .FontSize = 8
1596:                     .Tag      = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
1597:                     .Width    = 180
1598:                 ENDWITH
1599:                 loc_nImpres  = IIF(loc_oCnt.opt_4c_Impressora.Buttons(1).Enabled, 1, 0)
1600:                 loc_nHeight  = loc_nHeight + 20
1601:             ENDIF
1602:             loc_oCnt.opt_4c_Impressora.Enabled = (loc_nImpres > 1)
1603:             loc_oCnt.opt_4c_Impressora.Height  = loc_nHeight
1604: 
1605:             *-- Inicializar spinners com ajustes de SigCdPam
1606:             loc_oCnt.spn_4c_Vertical.Value   = loc_nAjVerts
1607:             loc_oCnt.spn_4c_Horizontal.Value = loc_nAjHorzs
1608: 

*-- Linhas 1630 a 1909:
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * CodigosEtqLostFocus - Valida codigo de localizacao ao sair do campo
1633:     * Handler PUBLIC pois é alvo de BINDEVENT
1634:     *--------------------------------------------------------------------------
1635:     PROCEDURE CodigosEtqLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1636:         LOCAL loc_oCnt, loc_oTxt, loc_cValor, loc_cSQL, loc_nResult, loc_cEncontrado, loc_oErro
1637: 
1638:         loc_cEncontrado = ""
1639: 
1640:         TRY
1641:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas
1642:             IF VARTYPE(loc_oCnt) = "O" AND PEMSTATUS(loc_oCnt, "txt_4c_CodigosEtq", 5)
1643:                 loc_oTxt   = loc_oCnt.txt_4c_CodigosEtq
1644:                 loc_cValor = ALLTRIM(loc_oTxt.Value)
1645: 
1646:                 IF !EMPTY(loc_cValor)
1647:                     loc_cSQL    = "SELECT TOP 1 Codigos FROM SigPrLcl" + ;
1648:                                   " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cValor)
1649:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidEtq")
1650: 
1651:                     IF loc_nResult > 0 AND USED("cursor_4c_ValidEtq") AND RECCOUNT("cursor_4c_ValidEtq") > 0
1652:                         SELECT cursor_4c_ValidEtq
1653:                         loc_cEncontrado = ALLTRIM(cursor_4c_ValidEtq.Codigos)
1654:                     ELSE
1655:                         IF USED("cursor_4c_ValidEtq")
1656:                             USE IN cursor_4c_ValidEtq
1657:                         ENDIF
1658:                         loc_cEncontrado = THIS.AbrirBuscaCodigosEtq(loc_cValor)
1659:                     ENDIF
1660: 
1661:                     IF USED("cursor_4c_ValidEtq")
1662:                         USE IN cursor_4c_ValidEtq
1663:                     ENDIF
1664: 
1665:                     IF PEMSTATUS(loc_oTxt, "Value", 5)
1666:                         loc_oTxt.Value = loc_cEncontrado
1667:                     ENDIF
1668:                 ENDIF
1669:             ENDIF
1670:         CATCH TO loc_oErro
1671:             MsgErro(loc_oErro.Message, "Erro")
1672:         ENDTRY
1673:     ENDPROC
1674: 
1675:     *--------------------------------------------------------------------------
1676:     * AbrirBuscaCodigosEtq - Abre FormBuscaAuxiliar para localizacoes com etiqueta
1677:     *--------------------------------------------------------------------------
1678:     PROTECTED PROCEDURE AbrirBuscaCodigosEtq(par_cValor)
1679:         LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_cCodigo, loc_oErro
1680: 
1681:         loc_cCodigo = ""
1682: 
1683:         TRY
1684:             IF !EMPTY(ALLTRIM(par_cValor))
1685:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl" + ;
1686:                            " WHERE Etiquetas = 1 AND Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
1687:                            " ORDER BY Codigos"
1688:             ELSE
1689:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1690:             ENDIF
1691: 
1692:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1693: 
1694:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst")
1695:                 IF RECCOUNT("cursor_4c_BuscaEtqLst") = 0
1696:                     USE IN cursor_4c_BuscaEtqLst
1697:                     loc_cSQL    = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1698:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1699:                 ENDIF
1700: 
1701:                 IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst") AND RECCOUNT("cursor_4c_BuscaEtqLst") > 0
1702:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1703:                     IF VARTYPE(loc_oBusca) = "O"
1704:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaEtqLst", "Codigos", "Descricaos", ;
1705:                                                  "Localiza" + CHR(231) + CHR(227) + "o")
1706:                         loc_oBusca.Mostrar()
1707:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1708:                             loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1709:                         ENDIF
1710:                         loc_oBusca = .NULL.
1711:                     ENDIF
1712:                 ENDIF
1713: 
1714:                 IF USED("cursor_4c_BuscaEtqLst")
1715:                     USE IN cursor_4c_BuscaEtqLst
1716:                 ENDIF
1717:             ENDIF
1718:         CATCH TO loc_oErro
1719:             MsgErro(loc_oErro.Message, "Erro na busca")
1720:         ENDTRY
1721: 
1722:         RETURN loc_cCodigo
1723:     ENDPROC
1724: 
1725:     *--------------------------------------------------------------------------
1726:     * CmdOkEtqClick - Imprime etiquetas Eltron/Zebra via saida raw (???)
1727:     * Equivalente ao CmdOk.Click do legado SIGCDPRL
1728:     * Handler PUBLIC pois e alvo de BINDEVENT
1729:     *--------------------------------------------------------------------------
1730:     PROCEDURE CmdOkEtqClick()
1731:         LOCAL loc_oCnt, loc_cCod, loc_nQtd, loc_nTip, loc_nDen, loc_nHor, loc_nVer
1732:         LOCAL loc_nImp, loc_cImp, loc_cSQL, loc_nResult, loc_lProsseguir, loc_lCursorOk
1733:         LOCAL loc_nVezes, loc_nCnt, loc_nInc, loc_nLin, loc_nCol, loc_nI
1734:         LOCAL loc_lPrinterSet, loc_oErro
1735: 
1736:         loc_lProsseguir = .T.
1737:         loc_lCursorOk   = .F.
1738:         loc_lPrinterSet = .F.
1739: 
1740:         TRY
1741:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas
1742: 
1743:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_CodigosEtq.Value)
1744:             loc_nQtd = INT(loc_oCnt.txt_4c_QtdeEtq.Value)
1745:             loc_nTip = loc_oCnt.opt_4c_TipoEtq.Value
1746:             loc_nDen = INT(loc_oCnt.spn_4c_Densidade.Value)
1747:             loc_nHor = INT(loc_oCnt.spn_4c_Horizontal.Value)
1748:             loc_nVer = INT(loc_oCnt.spn_4c_Vertical.Value)
1749:             loc_nImp = loc_oCnt.opt_4c_Impressora.Value
1750:             loc_cImp = ALLTRIM(loc_oCnt.opt_4c_Impressora.Buttons(loc_nImp).Tag)
1751: 
1752:             IF loc_nQtd < 1
1753:                 loc_nQtd = 1
1754:             ENDIF
1755: 
1756:             CREATE CURSOR cursor_4c_LocalPrLoc (Codigos C(10))
1757: 
1758:             IF EMPTY(loc_cCod)
1759:                 *-- Todas as localizacoes com etiqueta habilitada
1760:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1761:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1762:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1763:                     SELECT cursor_4c_SrcPrLoc
1764:                     SCAN
1765:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (cursor_4c_SrcPrLoc.Codigos)
1766:                     ENDSCAN
1767:                     loc_lCursorOk = .T.
1768:                 ELSE
1769:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1770:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1771:                     loc_lProsseguir = .F.
1772:                 ENDIF
1773:                 IF USED("cursor_4c_SrcPrLoc")
1774:                     USE IN cursor_4c_SrcPrLoc
1775:                 ENDIF
1776:             ELSE
1777:                 *-- Codigo especifico: inserir lnQtd copias
1778:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl" + ;
1779:                               " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cCod)
1780:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1781:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1782:                     IF USED("cursor_4c_SrcPrLoc")
1783:                         USE IN cursor_4c_SrcPrLoc
1784:                     ENDIF
1785:                     FOR loc_nI = 1 TO loc_nQtd
1786:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (loc_cCod)
1787:                     ENDFOR
1788:                     loc_nQtd      = 1
1789:                     loc_lCursorOk = .T.
1790:                 ELSE
1791:                     IF USED("cursor_4c_SrcPrLoc")
1792:                         USE IN cursor_4c_SrcPrLoc
1793:                     ENDIF
1794:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1795:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1796:                     loc_lProsseguir = .F.
1797:                 ENDIF
1798:             ENDIF
1799: 
1800:             IF loc_lProsseguir AND loc_lCursorOk
1801:                 INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES ("*FIM*")
1802: 
1803:                 SET PRINTER TO NAME (loc_cImp)
1804:                 SET DEVICE TO PRINTER
1805:                 loc_lPrinterSet = .T.
1806: 
1807:                 FOR loc_nVezes = 1 TO loc_nQtd
1808:                     loc_nCnt = 1
1809:                     SELECT cursor_4c_LocalPrLoc
1810:                     GO TOP
1811:                     SCAN
1812:                         IF loc_nCnt = 1
1813:                             ??? CHR(02) + "L" + CHR(13)
1814:                             ??? "H" + ALLTRIM(STR(loc_nDen)) + CHR(13)
1815:                             ??? "D11" + CHR(13)
1816:                         ENDIF
1817: 
1818:                         DO CASE
1819:                             CASE loc_nTip = 1
1820:                                 loc_nInc = (85 * loc_nCnt) - 85
1821:                                 IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
1822:                                     loc_nLin = 15 + loc_nHor
1823:                                     loc_nCol = 10 + loc_nVer + loc_nInc
1824:                                     ??? "1e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1825:                                     loc_nLin = 5 + loc_nHor
1826:                                     loc_nCol = 36 + loc_nVer + loc_nInc
1827:                                     ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1828:                                 ELSE
1829:                                     loc_nLin = 5 + loc_nHor
1830:                                     loc_nCol = 36 + loc_nVer + loc_nInc
1831:                                     ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 5) + CHR(13)
1832:                                 ENDIF
1833: 
1834:                             CASE loc_nTip = 2
1835:                                 loc_nInc = (89 * loc_nCnt) - 89
1836:                                 IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
1837:                                     loc_nLin = 22 + loc_nHor
1838:                                     loc_nCol = 50 + loc_nVer + loc_nInc
1839:                                     ??? "4e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1840:                                     loc_nLin = 45 + loc_nHor
1841:                                     loc_nCol = 65 + loc_nVer + loc_nInc
1842:                                     ??? "4911002" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1843:                                 ELSE
1844:                                     loc_nLin = 45 + loc_nHor
1845:                                     loc_nCol = 65 + loc_nVer + loc_nInc
1846:                                     ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 5) + CHR(13)
1847:                                 ENDIF
1848:                         ENDCASE
1849: 
1850:                         loc_nCnt = loc_nCnt + 1
1851:                         IF loc_nCnt > 4 OR ALLTRIM(cursor_4c_LocalPrLoc.Codigos) = "*FIM*"
1852:                             loc_nCnt = 1
1853:                             ??? "Q0001" + CHR(13)
1854:                             ??? "E" + CHR(13)
1855:                         ENDIF
1856:                     ENDSCAN
1857:                 ENDFOR
1858: 
1859:                 SET PRINTER TO DEFAULT
1860:                 SET DEVICE TO SCREEN
1861:                 loc_lPrinterSet = .F.
1862:             ENDIF
1863: 
1864:         CATCH TO loc_oErro
1865:             MsgErro(loc_oErro.Message, "Erro ao imprimir etiquetas")
1866:         ENDTRY
1867: 
1868:         IF loc_lPrinterSet
1869:             SET PRINTER TO DEFAULT
1870:             SET DEVICE TO SCREEN
1871:         ENDIF
1872: 
1873:         IF USED("cursor_4c_LocalPrLoc")
1874:             USE IN cursor_4c_LocalPrLoc
1875:         ENDIF
1876: 
1877:         THIS.CmdCancelEtqClick()
1878:     ENDPROC
1879: 
1880:     *--------------------------------------------------------------------------
1881:     * CmdCancelEtqClick - Fecha painel de etiquetas e restaura controles
1882:     * Handler PUBLIC pois e alvo de BINDEVENT
1883:     *--------------------------------------------------------------------------
1884:     PROCEDURE CmdCancelEtqClick()
1885:         LOCAL loc_oPagina, loc_oCnt
1886:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1887:         loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas
1888: 
1889:         loc_oCnt.Visible                      = .F.
1890:         loc_oCnt.Enabled                      = .F.
1891:         loc_oPagina.grd_4c_Lista.Enabled      = .T.
1892:         loc_oPagina.cnt_4c_Botoes.Enabled     = .T.
1893:         loc_oPagina.cnt_4c_Saida.Enabled      = .T.
1894:         loc_oPagina.cmd_4c_Etiquetas.Enabled  = .T.
1895:         THIS.Refresh()
1896:         loc_oPagina.grd_4c_Lista.SetFocus()
1897:     ENDPROC
1898: 
1899:     *--------------------------------------------------------------------------
1900:     * Destroy - Libera recursos
1901:     *--------------------------------------------------------------------------
1902:     PROCEDURE Destroy()
1903:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1904:             THIS.this_oBusinessObject = .NULL.
1905:         ENDIF
1906:         DODEFAULT()
1907:     ENDPROC
1908: 
1909: ENDDEFINE


### BO (C:\4c\projeto\app\classes\PrlBO.prg):
*==============================================================================
* PrlBO.prg - Business Object para Cadastro de Localizacao
* Tabela: SigPrLcl
* Herdado de: BusinessBase
*==============================================================================

DEFINE CLASS PrlBO AS BusinessBase

    *-- Propriedades da tabela SigPrLcl
    this_cCodigos    = ""   && codigos char(10) PK
    this_cDescricaos = ""   && descricaos char(20)
    this_nTipos      = 0    && tipos numeric(1,0): 1=Produto 2=Agendamento 3=Deposito
    this_nEtiquetas  = 0    && etiquetas numeric(1,0): 0=Nao 1=Sim
    this_nBloqueios  = 0    && bloqueios numeric(2,0)
    this_nDivisaos   = 0    && divisaos numeric(2,0)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrLcl"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os registros (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
                       " FROM SigPrLcl" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, tipos, etiquetas, bloqueios, divisaos" + ;
                       " FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescricaos = TratarNulo(descricaos, "C")
            THIS.this_nTipos      = TratarNulo(tipos,      "N")
            THIS.this_nEtiquetas  = TratarNulo(etiquetas,  "N")
            THIS.this_nBloqueios  = TratarNulo(bloqueios,  "N")
            THIS.this_nDivisaos   = TratarNulo(divisaos,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrLcl" + ;
                       " (codigos, descricaos, tipos, etiquetas, bloqueios, divisaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)         + ", " + ;
                       EscaparSQL(THIS.this_cDescricaos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBloqueios) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivisaos)  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrLcl SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricaos)      + "," + ;
                       " tipos      = " + FormatarNumeroSQL(THIS.this_nTipos)     + "," + ;
                       " etiquetas  = " + FormatarNumeroSQL(THIS.this_nEtiquetas) + "," + ;
                       " bloqueios  = " + FormatarNumeroSQL(THIS.this_nBloqueios) + "," + ;
                       " divisaos   = " + FormatarNumeroSQL(THIS.this_nDivisaos)  + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        *-- Localizacao invalida (descricao vazia)
        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        *-- Para etiqueta, codigo deve ter no maximo 3 caracteres
        IF loc_lResultado AND THIS.this_nEtiquetas = 1 AND LEN(ALLTRIM(THIS.this_cCodigos)) > 3
            MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarEtiquetas - Retorna localizacoes com etiqueta habilitada (PUBLIC por padrao)
    * Usado pelo painel de impressao de etiquetas (cntEtiquetas)
    *--------------------------------------------------------------------------
    FUNCTION BuscarEtiquetas(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE etiquetas = 1" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(par_cCodigo, 6))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Etiquetas")
                TABLEREVERT(.T., "cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja cadastrado (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarCodigo - Gera proximo codigo unico para SigPrLcl (PUBLIC por padrao)
    * Equivalente a Padl(fGerUniqueKey([SigPrLcl]), 10, [0]) do legado
    *--------------------------------------------------------------------------
    FUNCTION GerarCodigo()
        LOCAL loc_cNovoCodigo, loc_cSQL, loc_nResult
        loc_cNovoCodigo = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CASE WHEN ISNUMERIC(LTRIM(RTRIM(codigos))) = 1" + ;
                       " THEN CAST(LTRIM(RTRIM(codigos)) AS INT) ELSE 0 END), 0) + 1 AS proximo" + ;
                       " FROM SigPrLcl"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GerarCod")
                TABLEREVERT(.T., "cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = PADL(ALLTRIM(STR(cursor_4c_GerarCod.proximo)), 10, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cNovoCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Etiquetas")
            USE IN cursor_4c_Etiquetas
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

