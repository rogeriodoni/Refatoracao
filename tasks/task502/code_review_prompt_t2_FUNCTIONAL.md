# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1931 linhas total):

*-- Linhas 23 a 142:
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
55:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59: 
60:             THIS.pgf_4c_Paginas.Visible = .T.
61:             THIS.pgf_4c_Paginas.ActivePage = 1
62:             THIS.this_cModoAtual = "LISTA"
63: 
64:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                 THIS.CarregarLista()
66:             ENDIF
67: 
68:             loc_lSucesso = .T.
69:         CATCH TO loc_oErro
70:             MsgErro("Erro ao inicializar FormPrl:" + CHR(13) + loc_oErro.Message, "Erro")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81:         THIS.pgf_4c_Paginas.PageCount = 2
82:         WITH THIS.pgf_4c_Paginas
83:             .Top     = -29
84:             .Left    = 0
85:             .Width   = THIS.Width
86:             .Height  = THIS.Height + 29
87:             .Tabs    = .F.
88:             .Visible = .T.
89:             .Page1.Caption = "Lista"
90:             .Page2.Caption = "Dados"
91:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:         ENDWITH
94: 
95:         THIS.ConfigurarPaginaLista()
96:         THIS.ConfigurarPaginaDados()
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarPaginaLista - Page1: Cabecalho, botoes CRUD, grid e painel etiquetas
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarPaginaLista()
103:         LOCAL loc_oPagina
104:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
105: 
106:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
107:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
108: 
109:         *-- Cabecalho escuro: Top=1+29=30
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 30
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
123:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
124:             .Top       = 15
125:             .Left      = 10
126:             .Width     = 769
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .Visible   = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
138:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = 769
142:             .Height    = 46

*-- Linhas 182 a 378:
182:             .WordWrap        = .T.
183:             .AutoSize        = .F.
184:         ENDWITH
185:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
186: 
187:         *-- Visualizar
188:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
189:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
190:             .Caption         = "Visualizar"
191:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
192:             .PicturePosition = 13
193:             .Top             = 5
194:             .Left            = 80
195:             .Width           = 75
196:             .Height          = 75
197:             .BackColor       = RGB(255, 255, 255)
198:             .ForeColor       = RGB(90, 90, 90)
199:             .FontName        = "Tahoma"
200:             .FontSize        = 8
201:             .FontBold        = .T.
202:             .FontItalic      = .T.
203:             .Themes          = .F.
204:             .SpecialEffect   = 0
205:             .MousePointer    = 15
206:             .WordWrap        = .T.
207:             .AutoSize        = .F.
208:         ENDWITH
209:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
210: 
211:         *-- Alterar
212:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
213:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
214:             .Caption         = "Alterar"
215:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
216:             .PicturePosition = 13
217:             .Top             = 5
218:             .Left            = 155
219:             .Width           = 75
220:             .Height          = 75
221:             .BackColor       = RGB(255, 255, 255)
222:             .ForeColor       = RGB(90, 90, 90)
223:             .FontName        = "Tahoma"
224:             .FontSize        = 8
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .Themes          = .F.
228:             .SpecialEffect   = 0
229:             .MousePointer    = 15
230:             .WordWrap        = .T.
231:             .AutoSize        = .F.
232:         ENDWITH
233:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
234: 
235:         *-- Excluir
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
238:             .Caption         = "Excluir"
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
240:             .PicturePosition = 13
241:             .Top             = 5
242:             .Left            = 230
243:             .Width           = 75
244:             .Height          = 75
245:             .BackColor       = RGB(255, 255, 255)
246:             .ForeColor       = RGB(90, 90, 90)
247:             .FontName        = "Tahoma"
248:             .FontSize        = 8
249:             .FontBold        = .T.
250:             .FontItalic      = .T.
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .MousePointer    = 15
254:             .WordWrap        = .T.
255:             .AutoSize        = .F.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
258: 
259:         *-- Buscar
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
262:             .Caption         = "Buscar"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 305
267:             .Width           = 75
268:             .Height          = 75
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .FontName        = "Tahoma"
272:             .FontSize        = 8
273:             .FontBold        = .T.
274:             .FontItalic      = .T.
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container Encerrar (canonico - prevalece sobre PILAR 1)
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294: 
295:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
296:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
297:             .Caption         = "Encerrar"
298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
299:             .PicturePosition = 13
300:             .Top             = 5
301:             .Left            = 5
302:             .Width           = 75
303:             .Height          = 75
304:             .BackColor       = RGB(255, 255, 255)
305:             .ForeColor       = RGB(90, 90, 90)
306:             .FontName        = "Tahoma"
307:             .FontSize        = 8
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .Themes          = .F.
311:             .SpecialEffect   = 0
312:             .MousePointer    = 15
313:             .WordWrap        = .T.
314:             .AutoSize        = .F.
315:         ENDWITH
316:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
317: 
318:         *-- Botao Etiquetas (cmdEtiquetas original: Top=-1+29=28, Left=464)
319:         loc_oPagina.AddObject("cmd_4c_Etiquetas", "CommandButton")
320:         WITH loc_oPagina.cmd_4c_Etiquetas
321:             .Caption         = "Etiquetas"
322:             .Top             = 28
323:             .Left            = 464
324:             .Width           = 75
325:             .Height          = 75
326:             .BackColor       = RGB(255, 255, 255)
327:             .ForeColor       = RGB(90, 90, 90)
328:             .FontName        = "Tahoma"
329:             .FontSize        = 8
330:             .FontBold        = .T.
331:             .FontItalic      = .T.
332:             .Themes          = .F.
333:             .SpecialEffect   = 0
334:             .MousePointer    = 15
335:             .WordWrap        = .T.
336:             .AutoSize        = .F.
337:         ENDWITH
338:         BINDEVENT(loc_oPagina.cmd_4c_Etiquetas, "Click", THIS, "BtnEtiquetasClick")
339: 
340:         *-- Grid lista (Grade original: codigos 100px, descricaos 290px)
341:         *-- Top=88+29=117, Left=26, Width=890, Height=498
342:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
343:         WITH loc_oPagina.grd_4c_Lista
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 498
348:             .FontName           = "Verdana"
349:             .FontSize           = 8
350:             .ForeColor          = RGB(90, 90, 90)
351:             .BackColor          = RGB(255, 255, 255)
352:             .GridLineColor      = RGB(238, 238, 238)
353:             .HighlightBackColor = RGB(255, 255, 255)
354:             .HighlightForeColor = RGB(15, 41, 104)
355:             .HighlightStyle     = 2
356:             .DeleteMark         = .F.
357:             .RecordMark         = .F.
358:             .RowHeight          = 16
359:             .ScrollBars         = 2
360:             .GridLines          = 3
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         *-- Definir colunas FORA de WITH para que existam imediatamente
365:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
366: 
367:         WITH loc_oPagina.grd_4c_Lista.Column1
368:             .Width               = 100
369:             .Alignment           = 0
370:             .Header1.Caption     = "C" + CHR(243) + "digo"
371:         ENDWITH
372: 
373:         WITH loc_oPagina.grd_4c_Lista.Column2
374:             .Width               = 290
375:             .Alignment           = 0
376:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
377:         ENDWITH
378: 

*-- Linhas 391 a 440:
391: 
392:         THIS.ConfigurarPainelEtiquetas(loc_oPagina.cnt_4c_Etiquetas)
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     * ConfigurarPaginaDados - Page2: cabecalho, campos (Parte 1) e botoes acao
399:     *--------------------------------------------------------------------------
400:     PROTECTED PROCEDURE ConfigurarPaginaDados()
401:         LOCAL loc_oPagina
402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
403: 
404:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
405:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
406: 
407:         *-- Cabecalho escuro (mesmo estilo da Page1): Top=1+29=30
408:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
409:         WITH loc_oPagina.cnt_4c_Cabecalho
410:             .Top         = 30
411:             .Left        = 0
412:             .Width       = THIS.Width
413:             .Height      = 80
414:             .BackColor   = RGB(100, 100, 100)
415:             .BorderWidth = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
420:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
421:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
422:             .Top       = 15
423:             .Left      = 10
424:             .Width     = 769
425:             .Height    = 40
426:             .FontName  = "Tahoma"
427:             .FontSize  = 16
428:             .FontBold  = .T.
429:             .ForeColor = RGB(0, 0, 0)
430:             .BackStyle = 0
431:             .Visible   = .T.
432:         ENDWITH
433: 
434:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
435:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
436:             .Caption   = "Cadastro de Localiza" + CHR(231) + CHR(227) + "o"
437:             .Top       = 18
438:             .Left      = 10
439:             .Width     = 769
440:             .Height    = 46

*-- Linhas 479 a 545:
479:             .WordWrap        = .T.
480:             .AutoSize        = .F.
481:         ENDWITH
482:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
483: 
484:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
485:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
486:             .Caption         = "Encerrar"
487:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
488:             .PicturePosition = 13
489:             .Top             = 5
490:             .Left            = 80
491:             .Width           = 75
492:             .Height          = 75
493:             .BackColor       = RGB(255, 255, 255)
494:             .ForeColor       = RGB(90, 90, 90)
495:             .FontName        = "Tahoma"
496:             .FontSize        = 8
497:             .FontBold        = .T.
498:             .FontItalic      = .T.
499:             .Themes          = .F.
500:             .SpecialEffect   = 0
501:             .MousePointer    = 15
502:             .WordWrap        = .T.
503:             .AutoSize        = .F.
504:         ENDWITH
505:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
506: 
507:         *-- Label "Codigo :" (Say8): Top=155+29=184, Left=319, Width=42
508:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
509:         WITH loc_oPagina.lbl_4c_Codigo
510:             .Caption   = "C" + CHR(243) + "digo :"
511:             .Top       = 184
512:             .Left      = 319
513:             .Width     = 42
514:             .Height    = 17
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .FontBold  = .F.
518:             .ForeColor = RGB(90, 90, 90)
519:             .BackStyle = 0
520:             .Alignment = 1
521:             .Visible   = .T.
522:         ENDWITH
523: 
524:         *-- TextBox Codigo (get_codigos): Top=152+29=181, Left=366, Width=80, Height=23
525:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
526:         WITH loc_oPagina.txt_4c_Codigos
527:             .Value         = ""
528:             .Top           = 181
529:             .Left          = 366
530:             .Width         = 80
531:             .Height        = 23
532:             .MaxLength     = 10
533:             .FontName      = "Tahoma"
534:             .FontSize      = 8
535:             .ForeColor     = RGB(90, 90, 90)
536:             .BackColor     = RGB(255, 255, 255)
537:             .SpecialEffect = 0
538:             .BorderStyle   = 1
539:             .Themes        = .F.
540:             .Enabled       = .F.
541:             .Visible       = .T.
542:         ENDWITH
543: 
544:         *-- CheckBox "Imprime Etiqueta" (chkEtiqueta): Top=155+29=184, Left=455
545:         loc_oPagina.AddObject("chk_4c_Etiqueta", "CheckBox")

*-- Linhas 674 a 1246:
674:             .Visible  = .F.
675:         ENDWITH
676: 
677:         loc_oPagina.AddObject("opt_4c_Tipos", "OptionGroup")
678:         loc_oPagina.opt_4c_Tipos.ButtonCount = 3
679:         WITH loc_oPagina.opt_4c_Tipos
680:             .BackStyle   = 0
681:             .BorderStyle = 0
682:             .Top         = 522
683:             .Left        = 377
684:             .Width       = 262
685:             .Height      = 27
686:             .Value       = 1
687:             .Visible     = .F.
688:         ENDWITH
689:         WITH loc_oPagina.opt_4c_Tipos.Buttons(1)
690:             .Caption  = "Produto"
691:             .Left     = 5
692:             .Top      = 5
693:             .Width    = 63
694:             .AutoSize = .T.
695:             .FontName = "Verdana"
696:             .FontSize = 8
697:             .ForeColor = RGB(36, 84, 155)
698:             .BackStyle = 0
699:         ENDWITH
700:         WITH loc_oPagina.opt_4c_Tipos.Buttons(2)
701:             .Caption  = "Agendamento"
702:             .Left     = 81
703:             .Top      = 5
704:             .Width    = 98
705:             .AutoSize = .T.
706:             .FontName = "Verdana"
707:             .FontSize = 8
708:             .ForeColor = RGB(36, 84, 155)
709:             .BackStyle = 0
710:         ENDWITH
711:         WITH loc_oPagina.opt_4c_Tipos.Buttons(3)
712:             .Caption  = "Dep" + CHR(243) + "sito"
713:             .Left     = 183
714:             .Top      = 7
715:             .Width    = 69
716:             .AutoSize = .T.
717:             .FontName = "Verdana"
718:             .FontSize = 8
719:             .ForeColor = RGB(36, 84, 155)
720:             .BackStyle = 0
721:         ENDWITH
722: 
723:         THIS.TornarControlesVisiveis(loc_oPagina)
724:     ENDPROC
725: 
726:     *--------------------------------------------------------------------------
727:     * CarregarLista - Busca registros e vincula ao grid
728:     *--------------------------------------------------------------------------
729:     PROCEDURE CarregarLista()
730:         LOCAL loc_lResultado, loc_oGrid
731:         loc_lResultado = .F.
732: 
733:         TRY
734:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
735:                 loc_lResultado = .T.
736:             ELSE
737:                 IF THIS.this_oBusinessObject.Buscar("")
738:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
739: 
740:                     loc_oGrid.ColumnCount = 2
741:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
742:                     loc_oGrid.ColumnCount  = 2
743: 
744:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
745:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
746:                     loc_oGrid.Column1.Width          = 100
747:                     loc_oGrid.Column2.Width          = 290
748:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
749:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
750: 
751:                     THIS.FormatarGridLista(loc_oGrid)
752:                     loc_lResultado = .T.
753:                 ELSE
754:                     loc_lResultado = .F.
755:                 ENDIF
756:             ENDIF
757:         CATCH TO loc_oErro
758:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
759:             loc_lResultado = .F.
760:         ENDTRY
761: 
762:         RETURN loc_lResultado
763:     ENDPROC
764: 
765:     *--------------------------------------------------------------------------
766:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
767:     *--------------------------------------------------------------------------
768:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
769:         LOCAL loc_lResultado
770:         loc_lResultado = .F.
771: 
772:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
773:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
774:             IF par_nPagina = 1
775:                 THIS.CarregarLista()
776:             ENDIF
777:             loc_lResultado = .T.
778:         ENDIF
779: 
780:         RETURN loc_lResultado
781:     ENDPROC
782: 
783:     *--------------------------------------------------------------------------
784:     * BtnIncluirClick - Prepara form para inclusao de novo registro
785:     *--------------------------------------------------------------------------
786:     PROCEDURE BtnIncluirClick()
787:         LOCAL loc_cCodigo
788:         loc_cCodigo = ""
789: 
790:         THIS.this_oBusinessObject.NovoRegistro()
791:         THIS.LimparCampos()
792:         THIS.this_cModoAtual = "INCLUIR"
793: 
794:         *-- Gerar codigo automatico (equivalente a Padl(fGerUniqueKey([SigPrLcl]),10,'0'))
795:         TRY
796:             loc_cCodigo = THIS.this_oBusinessObject.GerarCodigo()
797:             THIS.this_oBusinessObject.this_cCodigos = loc_cCodigo
798:         CATCH TO loc_oErro
799:             MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
800:         ENDTRY
801: 
802:         THIS.HabilitarCampos(.T.)
803:         THIS.AjustarBotoesPorModo()
804:         THIS.AlternarPagina(2)
805: 
806:         LOCAL loc_oPagina
807:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
808:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
809:             loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(loc_cCodigo)
810:             loc_oPagina.txt_4c_Descricaos.SetFocus()
811:         ENDIF
812:     ENDPROC
813: 
814:     *--------------------------------------------------------------------------
815:     * BtnVisualizarClick - Carrega registro selecionado em modo leitura
816:     *--------------------------------------------------------------------------
817:     PROCEDURE BtnVisualizarClick()
818:         LOCAL loc_cCodigo
819:         loc_cCodigo = ""
820: 
821:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
822:             SELECT cursor_4c_Dados
823:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
824:         ENDIF
825: 
826:         IF EMPTY(loc_cCodigo)
827:             MsgAviso("Selecione um registro na lista.", "Visualizar")
828:             RETURN
829:         ENDIF
830: 
831:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
832:             THIS.this_cModoAtual = "VISUALIZAR"
833:             THIS.BOParaForm()
834:             THIS.HabilitarCampos(.F.)
835:             THIS.AjustarBotoesPorModo()
836:             THIS.AlternarPagina(2)
837: 
838:             LOCAL loc_oPagina
839:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
840:             IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
841:                 IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
842:                     loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
843:                 ENDIF
844:             ENDIF
845:         ELSE
846:             MsgErro("Erro ao carregar registro.", "Visualizar")
847:         ENDIF
848:     ENDPROC
849: 
850:     *--------------------------------------------------------------------------
851:     * BtnAlterarClick - Carrega registro selecionado para edicao
852:     *--------------------------------------------------------------------------
853:     PROCEDURE BtnAlterarClick()
854:         LOCAL loc_cCodigo
855:         loc_cCodigo = ""
856: 
857:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
858:             SELECT cursor_4c_Dados
859:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
860:         ENDIF
861: 
862:         IF EMPTY(loc_cCodigo)
863:             MsgAviso("Selecione um registro na lista.", "Alterar")
864:             RETURN
865:         ENDIF
866: 
867:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:             THIS.this_oBusinessObject.EditarRegistro()
869:             THIS.this_cModoAtual = "ALTERAR"
870:             THIS.BOParaForm()
871:             THIS.HabilitarCampos(.T.)
872:             THIS.AjustarBotoesPorModo()
873:             THIS.AlternarPagina(2)
874: 
875:             LOCAL loc_oPagina
876:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
877:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
878:                 loc_oPagina.txt_4c_Descricaos.SetFocus()
879:             ENDIF
880:         ELSE
881:             MsgErro("Erro ao carregar registro.", "Alterar")
882:         ENDIF
883:     ENDPROC
884: 
885:     *--------------------------------------------------------------------------
886:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
887:     *--------------------------------------------------------------------------
888:     PROCEDURE BtnExcluirClick()
889:         LOCAL loc_cCodigo, loc_cDescricao
890:         loc_cCodigo    = ""
891:         loc_cDescricao = ""
892: 
893:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
894:             SELECT cursor_4c_Dados
895:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
896:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
897:         ENDIF
898: 
899:         IF EMPTY(loc_cCodigo)
900:             MsgAviso("Selecione um registro na lista.", "Excluir")
901:             RETURN
902:         ENDIF
903: 
904:         IF MsgConfirma("Excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
905:                        loc_cCodigo + " - " + loc_cDescricao + "?", "Excluir")
906:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
907:                 IF THIS.this_oBusinessObject.Excluir()
908:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
909:                     THIS.CarregarLista()
910:                 ELSE
911:                     MsgErro("Erro ao excluir registro.", "Excluir")
912:                 ENDIF
913:             ENDIF
914:         ENDIF
915:     ENDPROC
916: 
917:     *--------------------------------------------------------------------------
918:     * BtnBuscarClick - Filtra registros por codigo ou descricao
919:     *--------------------------------------------------------------------------
920:     PROCEDURE BtnBuscarClick()
921:         LOCAL loc_cBusca, loc_cSQL, loc_nResult, loc_oGrid
922:         loc_cBusca = ""
923: 
924:         loc_cBusca = INPUTBOX("Informe o c" + CHR(243) + "digo ou descri" + ;
925:                               CHR(231) + CHR(227) + "o:", ;
926:                               "Buscar Localiza" + CHR(231) + CHR(227) + "o", "")
927: 
928:         IF VARTYPE(loc_cBusca) != "C"
929:             RETURN
930:         ENDIF
931: 
932:         TRY
933:             IF !EMPTY(ALLTRIM(loc_cBusca))
934:                 loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
935:                            " FROM SigPrLcl" + ;
936:                            " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cBusca) + "%") + ;
937:                            " ORDER BY codigos"
938: 
939:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
940: 
941:                 IF loc_nResult >= 0
942:                     IF USED("cursor_4c_Dados")
943:                         SELECT cursor_4c_Dados
944:                         ZAP
945:                         APPEND FROM DBF("cursor_4c_DadosTemp")
946:                     ENDIF
947:                     IF USED("cursor_4c_DadosTemp")
948:                         USE IN cursor_4c_DadosTemp
949:                     ENDIF
950:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
951:                     loc_oGrid.ColumnCount = 2
952:                     loc_oGrid.RecordSource    = "cursor_4c_Dados"
953:                     loc_oGrid.ColumnCount     = 2
954:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
955:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
956:                     loc_oGrid.Column1.Width          = 100
957:                     loc_oGrid.Column2.Width          = 290
958:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
959:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
960:                     THIS.FormatarGridLista(loc_oGrid)
961: 
962:                     IF RECCOUNT("cursor_4c_Dados") = 0
963:                         MsgAviso("Nenhum registro encontrado para '" + ALLTRIM(loc_cBusca) + "'.", "Buscar")
964:                     ENDIF
965:                 ELSE
966:                     IF USED("cursor_4c_DadosTemp")
967:                         USE IN cursor_4c_DadosTemp
968:                     ENDIF
969:                     MsgErro("Erro na busca:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
970:                 ENDIF
971:             ELSE
972:                 THIS.CarregarLista()
973:             ENDIF
974:         CATCH TO loc_oErro
975:             MsgErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "Erro")
976:         ENDTRY
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * BtnEncerrarClick - Fecha o formulario
981:     *--------------------------------------------------------------------------
982:     PROCEDURE BtnEncerrarClick()
983:         THIS.Release()
984:     ENDPROC
985: 
986:     *--------------------------------------------------------------------------
987:     * BtnEtiquetasClick - Alterna visibilidade do painel de impressao de etiquetas
988:     * Logica baseada em SIGCDPRL.Pagina.Lista.cntEtiquetas.CmdCancel.Click
989:     *--------------------------------------------------------------------------
990:     PROCEDURE BtnEtiquetasClick()
991:         THIS.ImprimirEtiquetas()
992:     ENDPROC
993: 
994:     *--------------------------------------------------------------------------
995:     * BtnSalvarClick - Valida e salva registro (Confirmar na Page2)
996:     * Validacoes do legado: descricao obrigatoria, codigo <= 3 chars se etiqueta
997:     *--------------------------------------------------------------------------
998:     PROCEDURE BtnSalvarClick()
999:         LOCAL loc_oPagina, loc_cDescricao, loc_cCodigo, loc_nEtiqueta
1000:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1001:         loc_cDescricao = ""
1002:         loc_cCodigo    = ""
1003:         loc_nEtiqueta  = 0
1004: 
1005:         *-- Coletar valores para validacao pre-TRY
1006:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1007:             loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1008:         ENDIF
1009:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1010:             loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1011:         ENDIF
1012:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1013:             loc_nEtiqueta = IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
1014:         ENDIF
1015: 
1016:         *-- Validacoes fora do TRY (REGRA CRITICA)
1017:         IF EMPTY(loc_cDescricao)
1018:             MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Validar")
1019:             IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1020:                 loc_oPagina.txt_4c_Descricaos.SetFocus()
1021:             ENDIF
1022:             RETURN
1023:         ENDIF
1024: 
1025:         IF loc_nEtiqueta = 1 AND LEN(loc_cCodigo) > 3
1026:             MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + ;
1027:                      "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Validar")
1028:             IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1029:                 loc_oPagina.txt_4c_Codigos.SetFocus()
1030:             ENDIF
1031:             RETURN
1032:         ENDIF
1033: 
1034:         TRY
1035:             THIS.FormParaBO()
1036:             IF THIS.this_oBusinessObject.Salvar()
1037:                 MsgInfo("Registro salvo com sucesso!")
1038:                 THIS.this_cModoAtual = "LISTA"
1039:                 THIS.AlternarPagina(1)
1040:             ELSE
1041:                 MsgErro("Erro ao salvar registro.", "Salvar")
1042:             ENDIF
1043:         CATCH TO loc_oErro
1044:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1045:         ENDTRY
1046:     ENDPROC
1047: 
1048:     *--------------------------------------------------------------------------
1049:     * BtnCancelarClick - Cancela edicao e retorna para lista
1050:     *--------------------------------------------------------------------------
1051:     PROCEDURE BtnCancelarClick()
1052:         THIS.this_cModoAtual = "LISTA"
1053:         THIS.AlternarPagina(1)
1054:         THIS.CarregarLista()
1055:     ENDPROC
1056: 
1057:     *--------------------------------------------------------------------------
1058:     * FormParaBO - Transfere valores do Form para o BO
1059:     *--------------------------------------------------------------------------
1060:     PROTECTED PROCEDURE FormParaBO()
1061:         LOCAL loc_oPagina
1062:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1063: 
1064:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1065:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1066:         ENDIF
1067:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1068:             THIS.this_oBusinessObject.this_cDescricaos = ALLTRIM(loc_oPagina.txt_4c_Descricaos.Value)
1069:         ENDIF
1070:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1071:             THIS.this_oBusinessObject.this_nEtiquetas = ;
1072:                 IIF(loc_oPagina.chk_4c_Etiqueta.Value = 1, 1, 0)
1073:         ENDIF
1074:     ENDPROC
1075: 
1076:     *--------------------------------------------------------------------------
1077:     * BOParaForm - Transfere valores do BO para o Form
1078:     *--------------------------------------------------------------------------
1079:     PROTECTED PROCEDURE BOParaForm()
1080:         LOCAL loc_oPagina
1081:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1082: 
1083:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1084:             loc_oPagina.txt_4c_Codigos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
1085:         ENDIF
1086:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1087:             loc_oPagina.txt_4c_Descricaos.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricaos)
1088:         ENDIF
1089:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1090:             loc_oPagina.chk_4c_Etiqueta.Value = (THIS.this_oBusinessObject.this_nEtiquetas .Value = IIF(THIS.this_oBusinessObject.this_nEtiquetas = 1, 1, 0))
1091:         ENDIF
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * HabilitarCampos - Habilita/desabilita campos da Page2
1096:     *--------------------------------------------------------------------------
1097:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1098:         LOCAL loc_oPagina
1099:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1100: 
1101:         *-- Codigo: editavel apenas em INCLUIR
1102:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1103:             loc_oPagina.txt_4c_Codigos.Enabled = ;
1104:                 (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1105:         ENDIF
1106:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1107:             loc_oPagina.txt_4c_Descricaos.Enabled = par_lHabilitar
1108:         ENDIF
1109:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1110:             loc_oPagina.chk_4c_Etiqueta.Enabled = par_lHabilitar
1111:         ENDIF
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * LimparCampos - Limpa valores dos campos da Page2
1116:     *--------------------------------------------------------------------------
1117:     PROTECTED PROCEDURE LimparCampos()
1118:         LOCAL loc_oPagina
1119:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1120: 
1121:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1122:             loc_oPagina.txt_4c_Codigos.Value    = ""
1123:         ENDIF
1124:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descricaos", 5)
1125:             loc_oPagina.txt_4c_Descricaos.Value = ""
1126:         ENDIF
1127:         IF PEMSTATUS(loc_oPagina, "chk_4c_Etiqueta", 5)
1128:             loc_oPagina.chk_4c_Etiqueta.Value   = 0
1129:         ENDIF
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------
1133:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar por modo atual
1134:     *--------------------------------------------------------------------------
1135:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1136:         LOCAL loc_oPagina, loc_lEditar
1137:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1138:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1139: 
1140:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1141:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1142:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1143:             ENDIF
1144:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1145:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1146:             ENDIF
1147:         ENDIF
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1152:     * cnt_4c_Etiquetas preservado oculto (painel flutuante de etiquetas)
1153:     *--------------------------------------------------------------------------
1154:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1155:         LOCAL loc_nI, loc_oObjeto, loc_cNome
1156: 
1157:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1158:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1159: 
1160:             IF VARTYPE(loc_oObjeto) = "O"
1161:                 loc_cNome = UPPER(loc_oObjeto.Name)
1162: 
1163:                 *-- Pular painel flutuante (deve iniciar oculto), mas recursionar filhos
1164:                 IF INLIST(loc_cNome, "CNT_4C_ETIQUETAS")
1165:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1166:                     LOOP
1167:                 ENDIF
1168: 
1169:                 *-- Pular campos sem uso (devem permanecer ocultos)
1170:                 IF INLIST(loc_cNome, "LBL_4C_SEMUSO2", "LBL_4C_SEMUSO3", "LBL_4C_SEMUSO22", ;
1171:                                      "TXT_4C_DIVISAOS", "TXT_4C_BLOQUEIOS", "OPT_4C_TIPOS")
1172:                     LOOP
1173:                 ENDIF
1174: 
1175:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1176:                     loc_oObjeto.Visible = .T.
1177:                 ENDIF
1178: 
1179:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1180:                     LOCAL loc_nP
1181:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1182:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1183:                     ENDFOR
1184:                 ENDIF
1185: 
1186:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1187:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1188:                 ENDIF
1189:             ENDIF
1190:         ENDFOR
1191:     ENDPROC
1192: 
1193:     *--------------------------------------------------------------------------
1194:     * FormatarGridLista - Formata visual do grid (FontName Tahoma, size 8)
1195:     *--------------------------------------------------------------------------
1196:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1197:         WITH par_oGrid
1198:             .FontName = "Tahoma"
1199:             .FontSize = 8
1200:         ENDWITH
1201:     ENDPROC
1202: 
1203:     *--------------------------------------------------------------------------
1204:     * ConfigurarPainelEtiquetas - Cria controles internos do painel de etiquetas
1205:     *--------------------------------------------------------------------------
1206:     PROTECTED PROCEDURE ConfigurarPainelEtiquetas(par_oCnt)
1207:         LOCAL loc_oErro
1208:         TRY
1209:             *-- Titulo
1210:             par_oCnt.AddObject("lbl_4c_TituloEtq", "Label")
1211:             WITH par_oCnt.lbl_4c_TituloEtq
1212:                 .Caption   = "Impress" + CHR(227) + "o de Etiquetas"
1213:                 .FontBold  = .T.
1214:                 .FontName  = "Tahoma"
1215:                 .FontSize  = 12
1216:                 .BackStyle = 0
1217:                 .ForeColor = RGB(90, 90, 90)
1218:                 .Height    = 21
1219:                 .Left      = 113
1220:                 .Top       = 5
1221:                 .Width     = 194
1222:                 .Visible   = .T.
1223:             ENDWITH
1224: 
1225:             *-- Label Codigo
1226:             par_oCnt.AddObject("lbl_4c_CodigoEtq", "Label")
1227:             WITH par_oCnt.lbl_4c_CodigoEtq
1228:                 .Caption   = "C" + CHR(243) + "digo :"
1229:                 .FontName  = "Tahoma"
1230:                 .FontSize  = 8
1231:                 .BackStyle = 0
1232:                 .ForeColor = RGB(90, 90, 90)
1233:                 .Height    = 15
1234:                 .Left      = 7
1235:                 .Top       = 36
1236:                 .Width     = 42
1237:                 .Visible   = .T.
1238:             ENDWITH
1239: 
1240:             *-- TextBox Codigo (getCodigos: MaxLength=3, codigo da localizacao)
1241:             par_oCnt.AddObject("txt_4c_CodigosEtq", "TextBox")
1242:             WITH par_oCnt.txt_4c_CodigosEtq
1243:                 .Value         = ""
1244:                 .FontName      = "Tahoma"
1245:                 .FontSize      = 8
1246:                 .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1252 a 1295:
1252:                 .Width         = 31
1253:                 .Visible       = .T.
1254:             ENDWITH
1255:             BINDEVENT(par_oCnt.txt_4c_CodigosEtq, "KeyPress", THIS, "CodigosEtqLostFocus")
1256: 
1257:             *-- Label Quantidade
1258:             par_oCnt.AddObject("lbl_4c_QuantEtq", "Label")
1259:             WITH par_oCnt.lbl_4c_QuantEtq
1260:                 .Caption   = "Quantidade :"
1261:                 .FontName  = "Tahoma"
1262:                 .FontSize  = 8
1263:                 .BackStyle = 0
1264:                 .ForeColor = RGB(90, 90, 90)
1265:                 .Height    = 15
1266:                 .Left      = 99
1267:                 .Top       = 37
1268:                 .Width     = 65
1269:                 .Visible   = .T.
1270:             ENDWITH
1271: 
1272:             *-- TextBox Quantidade (getQtde: numero de copias)
1273:             par_oCnt.AddObject("txt_4c_QtdeEtq", "TextBox")
1274:             WITH par_oCnt.txt_4c_QtdeEtq
1275:                 .Value         = 1
1276:                 .FontName      = "Tahoma"
1277:                 .FontSize      = 8
1278:                 .ForeColor     = RGB(90, 90, 90)
1279:                 .Height        = 23
1280:                 .InputMask     = "999"
1281:                 .Left          = 173
1282:                 .MaxLength     = 3
1283:                 .SpecialEffect = 1
1284:                 .Top           = 34
1285:                 .Width         = 31
1286:                 .Visible       = .T.
1287:             ENDWITH
1288: 
1289:             *-- Label Tipo
1290:             par_oCnt.AddObject("lbl_4c_TipoEtq", "Label")
1291:             WITH par_oCnt.lbl_4c_TipoEtq
1292:                 .Caption   = "Tipo :"
1293:                 .FontName  = "Tahoma"
1294:                 .FontSize  = 8
1295:                 .BackStyle = 0

*-- Linhas 1301 a 1385:
1301:                 .Visible   = .T.
1302:             ENDWITH
1303: 
1304:             *-- OptionGroup Tipo (optTipo: Pequena=1, Grande=2)
1305:             par_oCnt.AddObject("opt_4c_TipoEtq", "OptionGroup")
1306:             par_oCnt.opt_4c_TipoEtq.ButtonCount = 2
1307:             WITH par_oCnt.opt_4c_TipoEtq
1308:                 .BackStyle   = 0
1309:                 .BorderStyle = 0
1310:                 .Height      = 25
1311:                 .Left        = 52
1312:                 .Top         = 61
1313:                 .Value       = 1
1314:                 .Width       = 141
1315:                 .Visible     = .T.
1316:             ENDWITH
1317:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(1)
1318:                 .AutoSize  = .T.
1319:                 .BackStyle = 0
1320:                 .Caption   = "Pequena"
1321:                 .FontName  = "Tahoma"
1322:                 .FontSize  = 8
1323:                 .ForeColor = RGB(90, 90, 90)
1324:                 .Height    = 15
1325:                 .Left      = 5
1326:                 .Themes    = .F.
1327:                 .Top       = 5
1328:                 .Width     = 60
1329:             ENDWITH
1330:             WITH par_oCnt.opt_4c_TipoEtq.Buttons(2)
1331:                 .AutoSize  = .T.
1332:                 .BackStyle = 0
1333:                 .Caption   = "Grande"
1334:                 .FontName  = "Tahoma"
1335:                 .FontSize  = 8
1336:                 .ForeColor = RGB(90, 90, 90)
1337:                 .Height    = 15
1338:                 .Left      = 78
1339:                 .Themes    = .F.
1340:                 .Top       = 5
1341:                 .Width     = 53
1342:             ENDWITH
1343: 
1344:             *-- OptionGroup Impressora (optImpressora: populado dinamicamente em ImprimirEtiquetas)
1345:             par_oCnt.AddObject("opt_4c_Impressora", "OptionGroup")
1346:             par_oCnt.opt_4c_Impressora.ButtonCount = 1
1347:             WITH par_oCnt.opt_4c_Impressora
1348:                 .AutoSize    = .F.
1349:                 .BackStyle   = 0
1350:                 .BorderStyle = 0
1351:                 .Height      = 156
1352:                 .Left        = 12
1353:                 .Top         = 94
1354:                 .Value       = 1
1355:                 .Width       = 200
1356:                 .Visible     = .T.
1357:             ENDWITH
1358:             WITH par_oCnt.opt_4c_Impressora.Buttons(1)
1359:                 .AutoSize  = .F.
1360:                 .BackStyle = 0
1361:                 .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
1362:                 .FontName  = "Tahoma"
1363:                 .FontSize  = 8
1364:                 .ForeColor = RGB(90, 90, 90)
1365:                 .Height    = 17
1366:                 .Left      = 4
1367:                 .Top       = 10
1368:                 .Width     = 186
1369:             ENDWITH
1370: 
1371:             *-- Label Densidade
1372:             par_oCnt.AddObject("lbl_4c_DensidadeEtq", "Label")
1373:             WITH par_oCnt.lbl_4c_DensidadeEtq
1374:                 .Caption   = "Densidade"
1375:                 .FontName  = "Tahoma"
1376:                 .FontSize  = 7
1377:                 .BackStyle = 0
1378:                 .ForeColor = RGB(90, 90, 90)
1379:                 .Left      = 234
1380:                 .Top       = 37
1381:                 .Width     = 45
1382:                 .Visible   = .T.
1383:             ENDWITH
1384: 
1385:             *-- Spinner Densidade (spnDensidade: range 0-20, default 20)

*-- Linhas 1486 a 1626:
1486:                 .Width         = 45
1487:                 .Visible       = .T.
1488:             ENDWITH
1489:             BINDEVENT(par_oCnt.cmd_4c_OkEtq, "Click", THIS, "CmdOkEtqClick")
1490: 
1491:             *-- Botao Cancelar (CmdCancel: fecha painel sem imprimir)
1492:             par_oCnt.AddObject("cmd_4c_CancelEtq", "CommandButton")
1493:             WITH par_oCnt.cmd_4c_CancelEtq
1494:                 .Caption       = "Sair"
1495:                 .BackColor     = RGB(255, 255, 255)
1496:                 .Cancel        = .T.
1497:                 .ForeColor     = RGB(90, 90, 90)
1498:                 .FontName      = "Tahoma"
1499:                 .FontSize      = 8
1500:                 .Height        = 45
1501:                 .Left          = 367
1502:                 .MousePointer  = 15
1503:                 .SpecialEffect = 0
1504:                 .Themes        = .F.
1505:                 .ToolTipText   = "[ESC] Sair"
1506:                 .Top           = 206
1507:                 .Width         = 45
1508:                 .Visible       = .T.
1509:             ENDWITH
1510:             BINDEVENT(par_oCnt.cmd_4c_CancelEtq, "Click", THIS, "CmdCancelEtqClick")
1511: 
1512:         CATCH TO loc_oErro
1513:             MsgErro(loc_oErro.Message, "Erro ao configurar painel de etiquetas")
1514:         ENDTRY
1515:     ENDPROC
1516: 
1517:     *--------------------------------------------------------------------------
1518:     * ImprimirEtiquetas - Popula impressoras e exibe painel de etiquetas
1519:     * Equivalente ao metodo impetiqueta do legado SIGCDPRL
1520:     *--------------------------------------------------------------------------
1521:     PROTECTED PROCEDURE ImprimirEtiquetas()
1522:         LOCAL loc_oPagina, loc_oCnt, loc_lSucesso
1523:         LOCAL loc_nPrinters, loc_nI, loc_cI
1524:         LOCAL loc_cSQL, loc_nResult, loc_oErro
1525:         LOCAL loc_nMaxImpEti, loc_nAjVerts, loc_nAjHorzs
1526:         LOCAL loc_nImpres, loc_nOk, loc_nBtnCount, loc_nTop, loc_nHeight
1527: 
1528:         DIMENSION laPrinters(1)
1529:         DIMENSION laImpOk(1)
1530: 
1531:         loc_lSucesso   = .F.
1532:         loc_nMaxImpEti = 3
1533:         loc_nAjVerts   = 0
1534:         loc_nAjHorzs   = 0
1535: 
1536:         *-- Verificar impressoras instaladas (fora do TRY para sair cedo)
1537:         loc_nPrinters = APrinters(laPrinters)
1538:         IF loc_nPrinters = 0
1539:             MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Etiquetas")
1540:             RETURN loc_lSucesso
1541:         ENDIF
1542: 
1543:         TRY
1544:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1545:             loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas
1546: 
1547:             *-- Uppercase e ordenar nomes de impressoras (coluna 1)
1548:             FOR loc_nI = 1 TO loc_nPrinters
1549:                 laPrinters(loc_nI, 1) = UPPER(laPrinters(loc_nI, 1))
1550:             ENDFOR
1551:             ASORT(laPrinters)
1552: 
1553:             *-- Parametros de etiquetas em SigCdPam
1554:             loc_cSQL    = "SELECT nMaxImpEti, AjVerts, AjHorzs FROM SigCdPam"
1555:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamEtq")
1556:             IF loc_nResult > 0 AND USED("cursor_4c_ParamEtq") AND RECCOUNT("cursor_4c_ParamEtq") > 0
1557:                 SELECT cursor_4c_ParamEtq
1558:                 loc_nMaxImpEti = IIF(ISNULL(cursor_4c_ParamEtq.nMaxImpEti), 3, cursor_4c_ParamEtq.nMaxImpEti)
1559:                 loc_nAjVerts   = IIF(ISNULL(cursor_4c_ParamEtq.AjVerts),    0, cursor_4c_ParamEtq.AjVerts)
1560:                 loc_nAjHorzs   = IIF(ISNULL(cursor_4c_ParamEtq.AjHorzs),    0, cursor_4c_ParamEtq.AjHorzs)
1561:             ENDIF
1562:             IF USED("cursor_4c_ParamEtq")
1563:                 USE IN cursor_4c_ParamEtq
1564:             ENDIF
1565: 
1566:             *-- Impressoras de etiquetas cadastradas em SigCdMp (nTpImpres=2)
1567:             loc_cSQL    = "SELECT Impres, nTpImpres FROM SigCdMp ORDER BY Impres"
1568:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdMpEtq")
1569:             loc_nImpres = 1
1570:             IF loc_nResult > 0 AND USED("cursor_4c_SigCdMpEtq") AND RECCOUNT("cursor_4c_SigCdMpEtq") > 0
1571:                 SELECT cursor_4c_SigCdMpEtq
1572:                 SCAN FOR cursor_4c_SigCdMpEtq.nTpImpres = 2
1573:                     loc_nOk = ASCAN(laPrinters, ALLTRIM(UPPER(cursor_4c_SigCdMpEtq.Impres)))
1574:                     IF loc_nOk > 0
1575:                         DIMENSION laImpOk(loc_nImpres)
1576:                         laImpOk(loc_nImpres) = laPrinters(loc_nOk)
1577:                         loc_nImpres = loc_nImpres + 1
1578:                     ENDIF
1579:                 ENDSCAN
1580:             ENDIF
1581:             IF USED("cursor_4c_SigCdMpEtq")
1582:                 USE IN cursor_4c_SigCdMpEtq
1583:             ENDIF
1584:             loc_nImpres = loc_nImpres - 1
1585: 
1586:             *-- Popular OptionGroup de impressoras dinamicamente
1587:             loc_nTop    = loc_oCnt.opt_4c_Impressora.Top
1588:             loc_nHeight = 15
1589:             IF loc_nImpres > 0
1590:                 loc_nBtnCount = MIN(loc_nImpres, MAX(loc_nMaxImpEti, 3))
1591:                 loc_oCnt.opt_4c_Impressora.ButtonCount = loc_nBtnCount
1592:                 FOR loc_nI = 1 TO loc_nBtnCount
1593:                     loc_cI = ALLTRIM(STR(loc_nI))
1594:                     WITH loc_oCnt.opt_4c_Impressora.Buttons(loc_nI)
1595:                         .AutoSize = .F.
1596:                         .Caption  = " \<" + loc_cI + ". " + laImpOk(loc_nI)
1597:                         .FontSize = 8
1598:                         .Tag      = UPPER(laImpOk(loc_nI))
1599:                         .Top      = loc_nTop
1600:                         .Width    = 180
1601:                     ENDWITH
1602:                     loc_nTop    = loc_nTop + 20
1603:                     loc_nHeight = loc_nHeight + 20
1604:                 ENDFOR
1605:             ELSE
1606:                 loc_oCnt.opt_4c_Impressora.ButtonCount = 1
1607:                 loc_nOk = ASCAN(laPrinters, "GEN" + CHR(233) + "RICO/SOMENTE TEXTO")
1608:                 WITH loc_oCnt.opt_4c_Impressora.Buttons(1)
1609:                     .AutoSize = .F.
1610:                     .Caption  = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
1611:                     .BackStyle = 0
1612:                     .Enabled  = (loc_nOk > 0)
1613:                     .FontSize = 8
1614:                     .Tag      = "GEN" + CHR(233) + "RICO/SOMENTE TEXTO"
1615:                     .Width    = 180
1616:                 ENDWITH
1617:                 loc_nImpres  = IIF(loc_oCnt.opt_4c_Impressora.Buttons(1).Enabled, 1, 0)
1618:                 loc_nHeight  = loc_nHeight + 20
1619:             ENDIF
1620:             loc_oCnt.opt_4c_Impressora.Enabled = (loc_nImpres > 1)
1621:             loc_oCnt.opt_4c_Impressora.Height  = loc_nHeight
1622: 
1623:             *-- Inicializar spinners com ajustes de SigCdPam
1624:             loc_oCnt.spn_4c_Vertical.Value   = loc_nAjVerts
1625:             loc_oCnt.spn_4c_Horizontal.Value = loc_nAjHorzs
1626: 

*-- Linhas 1648 a 1856:
1648: 
1649:     *--------------------------------------------------------------------------
1650:     * CodigosEtqLostFocus - Valida codigo de localizacao ao sair do campo
1651:     * Handler PUBLIC pois é alvo de BINDEVENT
1652:     *--------------------------------------------------------------------------
1653:     PROCEDURE CodigosEtqLostFocus
1654:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1655:         LOCAL loc_oCnt, loc_oTxt, loc_cValor, loc_cSQL, loc_nResult, loc_cEncontrado, loc_oErro
1656: 
1657:         loc_cEncontrado = ""
1658: 
1659:         TRY
1660:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas
1661:             IF VARTYPE(loc_oCnt) = "O" AND PEMSTATUS(loc_oCnt, "txt_4c_CodigosEtq", 5)
1662:                 loc_oTxt   = loc_oCnt.txt_4c_CodigosEtq
1663:                 loc_cValor = ALLTRIM(loc_oTxt.Value)
1664: 
1665:                 IF !EMPTY(loc_cValor)
1666:                     loc_cSQL    = "SELECT TOP 1 Codigos FROM SigPrLcl" + ;
1667:                                   " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cValor)
1668:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidEtq")
1669: 
1670:                     IF loc_nResult > 0 AND USED("cursor_4c_ValidEtq") AND RECCOUNT("cursor_4c_ValidEtq") > 0
1671:                         SELECT cursor_4c_ValidEtq
1672:                         loc_cEncontrado = ALLTRIM(cursor_4c_ValidEtq.Codigos)
1673:                     ELSE
1674:                         IF USED("cursor_4c_ValidEtq")
1675:                             USE IN cursor_4c_ValidEtq
1676:                         ENDIF
1677:                         loc_cEncontrado = THIS.AbrirBuscaCodigosEtq(loc_cValor)
1678:                     ENDIF
1679: 
1680:                     IF USED("cursor_4c_ValidEtq")
1681:                         USE IN cursor_4c_ValidEtq
1682:                     ENDIF
1683: 
1684:                     IF PEMSTATUS(loc_oTxt, "Value", 5)
1685:                         loc_oTxt.Value = loc_cEncontrado
1686:                     ENDIF
1687:                 ENDIF
1688:             ENDIF
1689:         CATCH TO loc_oErro
1690:             MsgErro(loc_oErro.Message, "Erro")
1691:         ENDTRY
1692:     ENDPROC
1693: 
1694:     *--------------------------------------------------------------------------
1695:     * AbrirBuscaCodigosEtq - Abre FormBuscaAuxiliar para localizacoes com etiqueta
1696:     *--------------------------------------------------------------------------
1697:     PROTECTED PROCEDURE AbrirBuscaCodigosEtq(par_cValor)
1698:         LOCAL loc_cSQL, loc_nResult, loc_oBusca, loc_cCodigo, loc_oErro
1699: 
1700:         loc_cCodigo = ""
1701: 
1702:         TRY
1703:             IF !EMPTY(ALLTRIM(par_cValor))
1704:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl" + ;
1705:                            " WHERE Etiquetas = 1 AND Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
1706:                            " ORDER BY Codigos"
1707:             ELSE
1708:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1709:             ENDIF
1710: 
1711:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1712: 
1713:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst")
1714:                 IF RECCOUNT("cursor_4c_BuscaEtqLst") = 0
1715:                     USE IN cursor_4c_BuscaEtqLst
1716:                     loc_cSQL    = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1717:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1718:                 ENDIF
1719: 
1720:                 IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst") AND RECCOUNT("cursor_4c_BuscaEtqLst") > 0
1721:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1722:                     IF VARTYPE(loc_oBusca) = "O"
1723:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEtqLst"
1724:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaEtqLst", "Codigos", "Descricaos", ;
1725:                                                  "Localiza" + CHR(231) + CHR(227) + "o")
1726:                         loc_oBusca.Mostrar()
1727:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1728:                             loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1729:                         ENDIF
1730:                         loc_oBusca = .NULL.
1731:                     ENDIF
1732:                 ENDIF
1733: 
1734:                 IF USED("cursor_4c_BuscaEtqLst")
1735:                     USE IN cursor_4c_BuscaEtqLst
1736:                 ENDIF
1737:             ENDIF
1738:         CATCH TO loc_oErro
1739:             MsgErro(loc_oErro.Message, "Erro na busca")
1740:         ENDTRY
1741: 
1742:         RETURN loc_cCodigo
1743:     ENDPROC
1744: 
1745:     *--------------------------------------------------------------------------
1746:     * CmdOkEtqClick - Imprime etiquetas Eltron/Zebra via saida raw (???)
1747:     * Equivalente ao CmdOk.Click do legado SIGCDPRL
1748:     * Handler PUBLIC pois e alvo de BINDEVENT
1749:     *--------------------------------------------------------------------------
1750:     PROCEDURE CmdOkEtqClick()
1751:         LOCAL loc_oCnt, loc_cCod, loc_nQtd, loc_nTip, loc_nDen, loc_nHor, loc_nVer
1752:         LOCAL loc_nImp, loc_cImp, loc_cSQL, loc_nResult, loc_lProsseguir, loc_lCursorOk
1753:         LOCAL loc_nVezes, loc_nCnt, loc_nInc, loc_nLin, loc_nCol, loc_nI
1754:         LOCAL loc_lPrinterSet, loc_oErro
1755: 
1756:         loc_lProsseguir = .T.
1757:         loc_lCursorOk   = .F.
1758:         loc_lPrinterSet = .F.
1759: 
1760:         TRY
1761:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Etiquetas
1762: 
1763:             loc_cCod = ALLTRIM(loc_oCnt.txt_4c_CodigosEtq.Value)
1764:             loc_nQtd = INT(loc_oCnt.txt_4c_QtdeEtq.Value)
1765:             loc_nTip = loc_oCnt.opt_4c_TipoEtq.Value
1766:             loc_nDen = INT(loc_oCnt.spn_4c_Densidade.Value)
1767:             loc_nHor = INT(loc_oCnt.spn_4c_Horizontal.Value)
1768:             loc_nVer = INT(loc_oCnt.spn_4c_Vertical.Value)
1769:             loc_nImp = loc_oCnt.opt_4c_Impressora.Value
1770:             loc_cImp = ALLTRIM(loc_oCnt.opt_4c_Impressora.Buttons(loc_nImp).Tag)
1771: 
1772:             IF loc_nQtd < 1
1773:                 loc_nQtd = 1
1774:             ENDIF
1775: 
1776:             SET NULL ON
1777:             CREATE CURSOR cursor_4c_LocalPrLoc (Codigos C(10))
1778:             SET NULL OFF
1779: 
1780:             IF EMPTY(loc_cCod)
1781:                 *-- Todas as localizacoes com etiqueta habilitada
1782:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1783:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1784:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1785:                     SELECT cursor_4c_SrcPrLoc
1786:                     SCAN
1787:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (cursor_4c_SrcPrLoc.Codigos)
1788:                     ENDSCAN
1789:                     loc_lCursorOk = .T.
1790:                 ELSE
1791:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1792:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1793:                     loc_lProsseguir = .F.
1794:                 ENDIF
1795:                 IF USED("cursor_4c_SrcPrLoc")
1796:                     USE IN cursor_4c_SrcPrLoc
1797:                 ENDIF
1798:             ELSE
1799:                 *-- Codigo especifico: inserir lnQtd copias
1800:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl" + ;
1801:                               " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cCod)
1802:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1803:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1804:                     IF USED("cursor_4c_SrcPrLoc")
1805:                         USE IN cursor_4c_SrcPrLoc
1806:                     ENDIF
1807:                     FOR loc_nI = 1 TO loc_nQtd
1808:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (loc_cCod)
1809:                     ENDFOR
1810:                     loc_nQtd      = 1
1811:                     loc_lCursorOk = .T.
1812:                 ELSE
1813:                     IF USED("cursor_4c_SrcPrLoc")
1814:                         USE IN cursor_4c_SrcPrLoc
1815:                     ENDIF
1816:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1817:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1818:                     loc_lProsseguir = .F.
1819:                 ENDIF
1820:             ENDIF
1821: 
1822:             IF loc_lProsseguir AND loc_lCursorOk
1823:                 INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES ("*FIM*")
1824: 
1825:                 SET PRINTER TO NAME (loc_cImp)
1826:                 SET DEVICE TO PRINTER
1827:                 loc_lPrinterSet = .T.
1828: 
1829:                 FOR loc_nVezes = 1 TO loc_nQtd
1830:                     loc_nCnt = 1
1831:                     SELECT cursor_4c_LocalPrLoc
1832:                     GO TOP
1833:                     SCAN
1834:                         IF loc_nCnt = 1
1835:                             ??? CHR(02) + "L" + CHR(13)
1836:                             ??? "H" + ALLTRIM(STR(loc_nDen)) + CHR(13)
1837:                             ??? "D11" + CHR(13)
1838:                         ENDIF
1839: 
1840:                         DO CASE
1841:                             CASE loc_nTip = 1
1842:                                 loc_nInc = (85 * loc_nCnt) - 85
1843:                                 IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
1844:                                     loc_nLin = 15 + loc_nHor
1845:                                     loc_nCol = 10 + loc_nVer + loc_nInc
1846:                                     ??? "1e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1847:                                     loc_nLin = 5 + loc_nHor
1848:                                     loc_nCol = 36 + loc_nVer + loc_nInc
1849:                                     ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)
1850:                                 ELSE
1851:                                     loc_nLin = 5 + loc_nHor
1852:                                     loc_nCol = 36 + loc_nVer + loc_nInc
1853:                                     ??? "1911001" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + PADR(cursor_4c_LocalPrLoc.Codigos, 5) + CHR(13)
1854:                                 ENDIF
1855: 
1856:                             CASE loc_nTip = 2

*-- Linhas 1901 a 1931:
1901: 
1902:     *--------------------------------------------------------------------------
1903:     * CmdCancelEtqClick - Fecha painel de etiquetas e restaura controles
1904:     * Handler PUBLIC pois e alvo de BINDEVENT
1905:     *--------------------------------------------------------------------------
1906:     PROCEDURE CmdCancelEtqClick()
1907:         LOCAL loc_oPagina, loc_oCnt
1908:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1909:         loc_oCnt    = loc_oPagina.cnt_4c_Etiquetas
1910: 
1911:         loc_oCnt.Visible                      = .F.
1912:         loc_oCnt.Enabled                      = .F.
1913:         loc_oPagina.grd_4c_Lista.Enabled      = .T.
1914:         loc_oPagina.cnt_4c_Botoes.Enabled     = .T.
1915:         loc_oPagina.cnt_4c_Saida.Enabled      = .T.
1916:         loc_oPagina.cmd_4c_Etiquetas.Enabled  = .T.
1917:         THIS.Refresh()
1918:         loc_oPagina.grd_4c_Lista.SetFocus()
1919:     ENDPROC
1920: 
1921:     *--------------------------------------------------------------------------
1922:     * Destroy - Libera recursos
1923:     *--------------------------------------------------------------------------
1924:     PROCEDURE Destroy()
1925:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1926:             THIS.this_oBusinessObject = .NULL.
1927:         ENDIF
1928:         DODEFAULT()
1929:     ENDPROC
1930: 
1931: ENDDEFINE


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

