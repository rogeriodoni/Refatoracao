# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaC' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaC(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDconta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCOC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1490 linhas total):

*-- Linhas 24 a 157:
24:     this_oBusinessObject = .NULL.
25:     this_cModoAtual      = "LISTA"
26:     this_cFiltroAtual    = ""
27:     this_cUltimoContas   = ""
28:     this_cUltimoDContas  = ""
29: 
30:     *--------------------------------------------------------------------------
31:     * Init - Inicializa o formulario
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         LOCAL loc_lSucesso
35:         loc_lSucesso = .F.
36:         TRY
37:             loc_lSucesso = DODEFAULT()
38:         CATCH TO loc_oErro
39:             MsgErro(loc_oErro.Message + CHR(13) + ;
40:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
41:                 "Procedure: " + loc_oErro.Procedure, "Erro FormCOC.Init")
42:         ENDTRY
43:         RETURN loc_lSucesso
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Configura estrutura do formulario (chamado pelo FormBase)
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52: 
53:         TRY
54:             *-- Caption com acentos via CHR()
55:             THIS.Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
56: 
57:             *-- Criar Business Object
58:             THIS.this_oBusinessObject = CREATEOBJECT("COCBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Erro ao criar Business Object COCBO.", "Erro")
62:             ELSE
63:                 *-- Carregar parametros de SigCdPac (captions do OpcaoSNA)
64:                 THIS.this_oBusinessObject.CarregarParametros()
65: 
66:                 *-- Configurar estrutura visual (PageFrame + Pages + Containers)
67:                 THIS.ConfigurarPageFrame()
68: 
69:                 *-- Carregar dados iniciais (pula se estiver validando UI sem conexao SQL)
70:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
71:                     THIS.CarregarLista()
72:                 ENDIF
73: 
74:                 THIS.pgf_4c_Paginas.Visible = .T.
75:                 THIS.pgf_4c_Paginas.ActivePage = 1
76:                 THIS.this_cModoAtual = "LISTA"
77:                 loc_lSucesso = .T.
78:             ENDIF
79: 
80:         CATCH TO loc_oErro
81:             MsgErro(loc_oErro.Message + CHR(13) + ;
82:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
83:                 "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
84:         ENDTRY
85: 
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *--------------------------------------------------------------------------
90:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
91:     *--------------------------------------------------------------------------
92:     PROTECTED PROCEDURE ConfigurarPageFrame()
93:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
94:         WITH THIS.pgf_4c_Paginas
95:             .PageCount = 2
96:             .Top = -29
97:             .Left = 0
98:             .Width = THIS.Width
99:             .Height = THIS.Height + 29
100:             .Tabs = .F.
101:             .Page1.Caption = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Visible = .T.
108:         ENDWITH
109: 
110:         THIS.ConfigurarPaginaLista()
111:         THIS.ConfigurarPaginaDados()
112:     ENDPROC
113: 
114:     *--------------------------------------------------------------------------
115:     * ConfigurarPaginaLista - Configura Page1 (Lista) com cabecalho, botoes e grid
116:     *--------------------------------------------------------------------------
117:     PROTECTED PROCEDURE ConfigurarPaginaLista()
118:         LOCAL loc_oPagina
119:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
120: 
121:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
122:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
123: 
124:         *-- Container cabecalho cinza (cntSombra no legado)
125:         *-- Top = 2 (original) + 29 (compensacao PageFrame.Top=-29) = 31
126:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH loc_oPagina.cnt_4c_Cabecalho
128:             .Top = 31
129:             .Left = 0
130:             .Width = THIS.Width
131:             .Height = 80
132:             .BackColor = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
139:             .Top = 15
140:             .Left = 10
141:             .Width = 769
142:             .Height = 40
143:             .Caption = "Ocorr" + CHR(234) + "ncias de T" + CHR(237) + "tulos"
144:             .FontName = "Tahoma"
145:             .FontSize = 16
146:             .FontBold = .T.
147:             .ForeColor = RGB(0, 0, 0)
148:             .BackStyle = 0
149:             .AutoSize = .F.
150:             .Visible = .T.
151:         ENDWITH
152: 
153:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
154:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
155:             .Top = 18
156:             .Left = 10
157:             .Width = 769

*-- Linhas 201 a 487:
201:             .MousePointer    = 15
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
205: 
206:         *-- Botao Visualizar
207:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
208:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
209:             .Caption         = "Visualizar"
210:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
211:             .PicturePosition = 13
212:             .Top             = 5
213:             .Left            = 80
214:             .Width           = 75
215:             .Height          = 75
216:             .BackColor       = RGB(255, 255, 255)
217:             .ForeColor       = RGB(90, 90, 90)
218:             .FontName        = "Comic Sans MS"
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .FontSize        = 8
222:             .Themes          = .F.
223:             .SpecialEffect   = 0
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .MousePointer    = 15
227:             .Visible         = .T.
228:         ENDWITH
229:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
230: 
231:         *-- Botao Alterar
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
234:             .Caption         = "Alterar"
235:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
236:             .PicturePosition = 13
237:             .Top             = 5
238:             .Left            = 155
239:             .Width           = 75
240:             .Height          = 75
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .FontName        = "Comic Sans MS"
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .FontSize        = 8
247:             .Themes          = .F.
248:             .SpecialEffect   = 0
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .MousePointer    = 15
252:             .Visible         = .T.
253:         ENDWITH
254:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
255: 
256:         *-- Botao Excluir
257:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
258:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
259:             .Caption         = "Excluir"
260:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
261:             .PicturePosition = 13
262:             .Top             = 5
263:             .Left            = 230
264:             .Width           = 75
265:             .Height          = 75
266:             .BackColor       = RGB(255, 255, 255)
267:             .ForeColor       = RGB(90, 90, 90)
268:             .FontName        = "Comic Sans MS"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .FontSize        = 8
272:             .Themes          = .F.
273:             .SpecialEffect   = 0
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .MousePointer    = 15
277:             .Visible         = .T.
278:         ENDWITH
279:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
280: 
281:         *-- Botao Buscar
282:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Comic Sans MS"
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .FontSize        = 8
297:             .Themes          = .F.
298:             .SpecialEffect   = 0
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .MousePointer    = 15
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
307:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
308:         WITH loc_oPagina.cnt_4c_Saida
309:             .Top = 29
310:             .Left = 917
311:             .Width = 90
312:             .Height = 85
313:             .BackStyle = 0
314:             .BorderWidth = 0
315:             .Visible = .T.
316:         ENDWITH
317: 
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Comic Sans MS"
330:             .FontBold        = .T.
331:             .FontItalic      = .T.
332:             .FontSize        = 8
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .WordWrap        = .T.
336:             .AutoSize        = .F.
337:             .MousePointer    = 15
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid da lista: Codigos(80), Descrs(600), Opers(80)
343:         *-- Top = 121 (original) + 29 (compensacao PageFrame) = 150
344:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
345:         loc_oPagina.grd_4c_Lista.RecordSource = ""
346:         loc_oPagina.grd_4c_Lista.ColumnCount  = 3
347:         WITH loc_oPagina.grd_4c_Lista
348:             .Top                = 150
349:             .Left               = 12
350:             .Width              = 900
351:             .Height             = 474
352:             .FontName           = "Verdana"
353:             .FontSize           = 8
354:             .ForeColor          = RGB(90, 90, 90)
355:             .BackColor          = RGB(255, 255, 255)
356:             .GridLineColor      = RGB(238, 238, 238)
357:             .HighlightBackColor = RGB(255, 255, 255)
358:             .HighlightForeColor = RGB(15, 41, 104)
359:             .HighlightStyle     = 2
360:             .DeleteMark         = .F.
361:             .RecordMark         = .F.
362:             .RowHeight          = 16
363:             .ScrollBars         = 2
364:             .GridLines          = 3
365:             .Visible            = .T.
366:             .Column1.Width            = 80
367:             .Column2.Width            = 600
368:             .Column3.Width            = 80
369:             .Column1.Header1.FontBold = .T.
370:             .Column2.Header1.FontBold = .T.
371:             .Column3.Header1.FontBold = .T.
372:         ENDWITH
373: 
374:         THIS.TornarControlesVisiveis(loc_oPagina)
375:     ENDPROC
376: 
377:     *--------------------------------------------------------------------------
378:     * ConfigurarPaginaDados - Configura Page2 com botoes e campos (primeira metade)
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE ConfigurarPaginaDados()
381:         LOCAL loc_oPagina
382:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
383: 
384:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
385:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
386: 
387:         *-- Container botoes acao Confirmar/Cancelar (Grupo_Salva no legado)
388:         *-- Top = 9 (original) + 29 (compensacao) = 38; Left = 817 (original)
389:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
390:         WITH loc_oPagina.cnt_4c_BotoesAcao
391:             .Top         = 38
392:             .Left        = 817
393:             .Width       = 160
394:             .Height      = 85
395:             .BackStyle   = 0
396:             .Visible     = .T.
397:         ENDWITH
398: 
399:         *-- Botao Confirmar (Salva no legado)
400:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
401:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
402:             .Caption         = "Confirmar"
403:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
404:             .PicturePosition = 13
405:             .Top             = 5
406:             .Left            = 5
407:             .Width           = 75
408:             .Height          = 75
409:             .BackColor       = RGB(255, 255, 255)
410:             .ForeColor       = RGB(90, 90, 90)
411:             .FontName        = "Comic Sans MS"
412:             .FontBold        = .T.
413:             .FontItalic      = .T.
414:             .FontSize        = 8
415:             .Themes          = .F.
416:             .SpecialEffect   = 0
417:             .WordWrap        = .T.
418:             .AutoSize        = .F.
419:             .MousePointer    = 15
420:             .Visible         = .T.
421:         ENDWITH
422:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
423: 
424:         *-- Botao Cancelar
425:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
426:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
427:             .Caption         = "Encerrar"
428:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
429:             .PicturePosition = 13
430:             .Top             = 5
431:             .Left            = 80
432:             .Width           = 75
433:             .Height          = 75
434:             .BackColor       = RGB(255, 255, 255)
435:             .ForeColor       = RGB(90, 90, 90)
436:             .FontName        = "Comic Sans MS"
437:             .FontBold        = .T.
438:             .FontItalic      = .T.
439:             .FontSize        = 8
440:             .Themes          = .F.
441:             .SpecialEffect   = 0
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .MousePointer    = 15
445:             .Visible         = .T.
446:         ENDWITH
447:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
448: 
449:         *-- Label Codigo
450:         *-- sayCodigo original: Top=109+29=138, Left=246
451:         loc_oPagina.AddObject("lbl_4c_SayCodigo", "Label")
452:         WITH loc_oPagina.lbl_4c_SayCodigo
453:             .Caption    = "C" + CHR(243) + "digo :"
454:             .Top        = 138
455:             .Left       = 246
456:             .Width      = 50
457:             .Height     = 17
458:             .FontName   = "Tahoma"
459:             .FontSize   = 8
460:             .FontBold   = .F.
461:             .FontItalic = .F.
462:             .ForeColor  = RGB(90, 90, 90)
463:             .BackStyle  = 0
464:             .Alignment  = 1
465:             .AutoSize   = .F.
466:             .Visible    = .T.
467:         ENDWITH
468: 
469:         *-- TextBox Codigo
470:         *-- getCodigo original: Top=106+29=135, Left=293, Width=80
471:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
472:         WITH loc_oPagina.txt_4c_Codigo
473:             .Top               = 135
474:             .Left              = 293
475:             .Width             = 80
476:             .Height            = 20
477:             .InputMask         = "XXXXXXXXXX"
478:             .Format            = "!"
479:             .BorderStyle       = 1
480:             .SpecialEffect     = 1
481:             .ForeColor         = RGB(0, 0, 0)
482:             .BackColor         = RGB(255, 255, 255)
483:             .DisabledBackColor = RGB(255, 255, 255)
484:             .FontName          = "Tahoma"
485:             .FontSize          = 8
486:             .Value             = ""
487:             .Visible           = .T.

*-- Linhas 564 a 694:
564:             .Value         = ""
565:             .Visible       = .T.
566:         ENDWITH
567:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "TeclaGrupo")
568:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
569: 
570:         *-- Label Conta
571:         *-- sayConta original: Top=184+29=213, Left=250
572:         loc_oPagina.AddObject("lbl_4c_SayConta", "Label")
573:         WITH loc_oPagina.lbl_4c_SayConta
574:             .Caption    = "Conta :"
575:             .Top        = 213
576:             .Left       = 250
577:             .Width      = 41
578:             .Height     = 17
579:             .FontName   = "Tahoma"
580:             .FontSize   = 8
581:             .FontBold   = .F.
582:             .FontItalic = .F.
583:             .ForeColor  = RGB(90, 90, 90)
584:             .BackStyle  = 0
585:             .Alignment  = 1
586:             .AutoSize   = .F.
587:             .Visible    = .T.
588:         ENDWITH
589: 
590:         *-- TextBox Conta - conta credito (F4 abre lookup SigCdCli)
591:         *-- Get_conta original: Top=181+29=210, Left=293, Width=80
592:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
593:         WITH loc_oPagina.txt_4c_Conta
594:             .Top               = 210
595:             .Left              = 293
596:             .Width             = 80
597:             .Height            = 20
598:             .BorderStyle       = 1
599:             .SpecialEffect     = 1
600:             .ForeColor         = RGB(0, 0, 0)
601:             .BackColor         = RGB(255, 255, 255)
602:             .FontName          = "Tahoma"
603:             .FontSize          = 8
604:             .Value             = ""
605:             .Visible           = .T.
606:         ENDWITH
607:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "TeclaContaC")
608:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarContaC")
609: 
610:         *-- TextBox DConta - conta debito (sem label proprio, na mesma linha de Conta)
611:         *-- Get_dconta original: Top=181+29=210, Left=375, Width=250
612:         *-- Habilitado apenas quando Conta estiver vazio (replicando When do legado)
613:         loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
614:         WITH loc_oPagina.txt_4c_Dconta
615:             .Top               = 210
616:             .Left              = 375
617:             .Width             = 250
618:             .Height            = 20
619:             .BorderStyle       = 1
620:             .SpecialEffect     = 1
621:             .ForeColor         = RGB(0, 0, 0)
622:             .BackColor         = RGB(255, 255, 255)
623:             .FontName          = "Tahoma"
624:             .FontSize          = 8
625:             .Value             = ""
626:             .Enabled           = .T.
627:             .Visible           = .T.
628:         ENDWITH
629:         BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "TeclaDconta")
630:         BINDEVENT(loc_oPagina.txt_4c_Dconta, "KeyPress", THIS, "ValidarDconta")
631: 
632:         *-- Label Movimento (Say1)
633:         *-- Say1 original: Top=212+29=241, Left=227
634:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
635:         WITH loc_oPagina.lbl_4c_Label1
636:             .Caption    = "Movimento :"
637:             .Top        = 241
638:             .Left       = 227
639:             .Width      = 63
640:             .Height     = 17
641:             .FontName   = "Tahoma"
642:             .FontSize   = 8
643:             .FontBold   = .F.
644:             .FontItalic = .F.
645:             .ForeColor  = RGB(90, 90, 90)
646:             .BackStyle  = 0
647:             .Alignment  = 1
648:             .AutoSize   = .F.
649:             .Visible    = .T.
650:         ENDWITH
651: 
652:         *-- OptionGroup OpcaoOcorrencia (Debito=1/Credito=2)
653:         *-- OpcaoOcorrencia original: Top=207+29=236, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
654:         loc_oPagina.AddObject("opt_4c_OpcaoOcorrencia", "OptionGroup")
655:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia
656:             .ButtonCount = 2
657:             .Top         = 236
658:             .Left        = 288
659:             .Width       = 142
660:             .Height      = 26
661:             .BackStyle   = 0
662:             .BorderStyle = 0
663:             .Value       = 1
664:             .Visible     = .T.
665:         ENDWITH
666:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(1)
667:             .Caption   = "D" + CHR(233) + "bito"
668:             .Left      = 5
669:             .Top       = 5
670:             .Width     = 60
671:             .AutoSize  = .T.
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .ForeColor = RGB(90, 90, 90)
676:             .Themes    = .F.
677:         ENDWITH
678:         WITH loc_oPagina.opt_4c_OpcaoOcorrencia.Buttons(2)
679:             .Caption   = "Cr" + CHR(233) + "dito"
680:             .Left      = 72
681:             .Top       = 5
682:             .Width     = 60
683:             .AutoSize  = .T.
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .BackStyle = 0
687:             .ForeColor = RGB(90, 90, 90)
688:             .Themes    = .F.
689:         ENDWITH
690: 
691:         *-- Label Lanca Contabilidade (Say2)
692:         *-- Say2 original: Top=239+29=268, Left=183
693:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
694:         WITH loc_oPagina.lbl_4c_Label2

*-- Linhas 708 a 753:
708:             .Visible    = .T.
709:         ENDWITH
710: 
711:         *-- OptionGroup Opcaocontab (Sim=1 / Nao=2, padrao=2)
712:         *-- Opcaocontab original: Top=234+29=263, Left=288 (buttons: Option1.Left=5, Option2.Left=72)
713:         loc_oPagina.AddObject("opt_4c_Opcaocontab", "OptionGroup")
714:         WITH loc_oPagina.opt_4c_Opcaocontab
715:             .ButtonCount = 2
716:             .Top         = 263
717:             .Left        = 288
718:             .Width       = 122
719:             .Height      = 26
720:             .BackStyle   = 0
721:             .BorderStyle = 0
722:             .Value       = 2
723:             .Visible     = .T.
724:         ENDWITH
725:         WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(1)
726:             .Caption   = "Sim"
727:             .Left      = 5
728:             .Top       = 5
729:             .Width     = 40
730:             .AutoSize  = .T.
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .BackStyle = 0
734:             .ForeColor = RGB(90, 90, 90)
735:             .Themes    = .F.
736:         ENDWITH
737:         WITH loc_oPagina.opt_4c_Opcaocontab.Buttons(2)
738:             .Caption   = "N" + CHR(227) + "o"
739:             .Left      = 72
740:             .Top       = 5
741:             .Width     = 40
742:             .AutoSize  = .T.
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .BackStyle = 0
746:             .ForeColor = RGB(90, 90, 90)
747:             .Themes    = .F.
748:         ENDWITH
749: 
750:         *-- Label Opcao (Say3)
751:         *-- Say3 original: Top=264+29=293, Left=248
752:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
753:         WITH loc_oPagina.lbl_4c_Label3

*-- Linhas 767 a 813:
767:             .Visible    = .T.
768:         ENDWITH
769: 
770:         *-- OptionGroup OpcaoSNA (3 opcoes com captions de SigCdPac)
771:         *-- OpcaoSNA original: Top=260+29=289, Left=288, Width=197, Height=25
772:         *-- Buttons: Option1.Left=5, Option2.Left=73, Option3.Left=142
773:         loc_oPagina.AddObject("opt_4c_OpcaoSNA", "OptionGroup")
774:         WITH loc_oPagina.opt_4c_OpcaoSNA
775:             .ButtonCount = 3
776:             .Top         = 289
777:             .Left        = 288
778:             .Width       = 202
779:             .Height      = 25
780:             .BackStyle   = 0
781:             .BorderStyle = 0
782:             .Value       = 0
783:             .Visible     = .T.
784:         ENDWITH
785:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(1)
786:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcS
787:             .Left      = 5
788:             .Top       = 5
789:             .Width     = 34
790:             .AutoSize  = .T.
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .BackStyle = 0
794:             .ForeColor = RGB(90, 90, 90)
795:             .Themes    = .F.
796:         ENDWITH
797:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(2)
798:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcN
799:             .Left      = 73
800:             .Top       = 5
801:             .Width     = 37
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .BackStyle = 0
806:             .ForeColor = RGB(90, 90, 90)
807:             .Themes    = .F.
808:         ENDWITH
809:         WITH loc_oPagina.opt_4c_OpcaoSNA.Buttons(3)
810:             .Caption   = THIS.this_oBusinessObject.this_cTitOpcA
811:             .Left      = 142
812:             .Top       = 5
813:             .Width     = 50

*-- Linhas 819 a 1490:
819:             .Themes    = .F.
820:         ENDWITH
821: 
822:         THIS.TornarControlesVisiveis(loc_oPagina)
823:     ENDPROC
824: 
825:     *--------------------------------------------------------------------------
826:     * CarregarLista - Busca registros no BO e configura grid da Page1
827:     *--------------------------------------------------------------------------
828:     PROCEDURE CarregarLista()
829:         LOCAL loc_lSucesso, loc_oGrid
830:         loc_lSucesso = .F.
831: 
832:         TRY
833:             IF THIS.this_oBusinessObject.Buscar(THIS.this_cFiltroAtual)
834:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
835:                 loc_oGrid.ColumnCount = 3
836:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
837:                 loc_oGrid.ColumnCount  = 3
838:                 WITH loc_oGrid
839:                     .Column1.ControlSource    = "cursor_4c_Dados.Codigos"
840:                     .Column2.ControlSource    = "cursor_4c_Dados.Descrs"
841:                     .Column3.ControlSource    = "cursor_4c_Dados.Opers"
842:                     .Column1.Width            = 80
843:                     .Column2.Width            = 600
844:                     .Column3.Width            = 80
845:                     .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
846:                     .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
847:                     .Column3.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
848:                     .Column1.Header1.FontBold = .T.
849:                     .Column2.Header1.FontBold = .T.
850:                     .Column3.Header1.FontBold = .T.
851:                 ENDWITH
852:                 THIS.FormatarGridLista(loc_oGrid)
853:                 loc_lSucesso = .T.
854:             ENDIF
855:         CATCH TO loc_oErro
856:             MsgErro(loc_oErro.Message + CHR(13) + ;
857:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
858:                 "Procedure: " + loc_oErro.Procedure, "Erro CarregarLista")
859:             loc_lSucesso = .F.
860:         ENDTRY
861: 
862:         RETURN loc_lSucesso
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
867:     *--------------------------------------------------------------------------
868:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
869:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
870:             RETURN .F.
871:         ENDIF
872: 
873:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
874: 
875:         IF par_nPagina = 1
876:             THIS.this_cModoAtual = "LISTA"
877:             THIS.CarregarLista()
878:         ENDIF
879: 
880:         RETURN .T.
881:     ENDPROC
882: 
883:     *--------------------------------------------------------------------------
884:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
885:     *--------------------------------------------------------------------------
886:     PROCEDURE BtnIncluirClick()
887:         THIS.this_oBusinessObject.NovoRegistro()
888:         THIS.this_cModoAtual = "INCLUIR"
889:         THIS.LimparCampos()
890:         THIS.HabilitarCampos(.T.)
891:         THIS.AlternarPagina(2)
892:     ENDPROC
893: 
894:     *--------------------------------------------------------------------------
895:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
896:     *--------------------------------------------------------------------------
897:     PROCEDURE BtnVisualizarClick()
898:         LOCAL loc_cCodigo
899:         loc_cCodigo = ""
900: 
901:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
902:             SELECT cursor_4c_Dados
903:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
904:         ENDIF
905: 
906:         IF EMPTY(loc_cCodigo)
907:             MsgAviso("Selecione um registro na lista.", "Visualizar")
908:             RETURN
909:         ENDIF
910: 
911:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
912:             THIS.this_cModoAtual = "VISUALIZAR"
913:             THIS.BOParaForm()
914:             THIS.HabilitarCampos(.F.)
915:             THIS.AlternarPagina(2)
916:         ENDIF
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * BtnAlterarClick - Carrega registro selecionado para edicao
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnAlterarClick()
923:         LOCAL loc_cCodigo
924:         loc_cCodigo = ""
925: 
926:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
927:             SELECT cursor_4c_Dados
928:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
929:         ENDIF
930: 
931:         IF EMPTY(loc_cCodigo)
932:             MsgAviso("Selecione um registro na lista.", "Alterar")
933:             RETURN
934:         ENDIF
935: 
936:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
937:             THIS.this_oBusinessObject.EditarRegistro()
938:             THIS.this_cModoAtual = "ALTERAR"
939:             THIS.BOParaForm()
940:             THIS.HabilitarCampos(.T.)
941:             THIS.AlternarPagina(2)
942:         ENDIF
943:     ENDPROC
944: 
945:     *--------------------------------------------------------------------------
946:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
947:     *--------------------------------------------------------------------------
948:     PROCEDURE BtnExcluirClick()
949:         LOCAL loc_cCodigo, loc_lConfirmou
950:         loc_cCodigo    = ""
951:         loc_lConfirmou = .F.
952: 
953:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
954:             SELECT cursor_4c_Dados
955:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
956:         ENDIF
957: 
958:         IF EMPTY(loc_cCodigo)
959:             MsgAviso("Selecione um registro na lista.", "Excluir")
960:             RETURN
961:         ENDIF
962: 
963:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
964:             loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + ;
965:                 ALLTRIM(THIS.this_oBusinessObject.this_cCodigos) + " - " + ;
966:                 ALLTRIM(THIS.this_oBusinessObject.this_cDescrs) + "'?", ;
967:                 "Confirmar Exclus" + CHR(227) + "o")
968: 
969:             IF loc_lConfirmou
970:                 IF THIS.this_oBusinessObject.Excluir()
971:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
972:                     THIS.CarregarLista()
973:                 ENDIF
974:             ENDIF
975:         ENDIF
976:     ENDPROC
977: 
978:     *--------------------------------------------------------------------------
979:     * BtnBuscarClick - Filtra registros por codigo ou descricao
980:     *--------------------------------------------------------------------------
981:     PROCEDURE BtnBuscarClick()
982:         LOCAL loc_cBusca
983:         loc_cBusca = ""
984: 
985:         loc_cBusca = INPUTBOX("C" + CHR(243) + "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
986:             "Buscar Ocorr" + CHR(234) + "ncia", "")
987: 
988:         IF VARTYPE(loc_cBusca) = "C"
989:             loc_cBusca = ALLTRIM(loc_cBusca)
990:             IF !EMPTY(loc_cBusca)
991:                 THIS.this_cFiltroAtual = "Codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
992:             ELSE
993:                 THIS.this_cFiltroAtual = ""
994:             ENDIF
995:             THIS.CarregarLista()
996:         ENDIF
997:     ENDPROC
998: 
999:     *--------------------------------------------------------------------------
1000:     * BtnEncerrarClick - Fecha o formulario
1001:     *--------------------------------------------------------------------------
1002:     PROCEDURE BtnEncerrarClick()
1003:         THIS.Release()
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * BtnSalvarClick - Valida e salva o registro atual
1008:     *--------------------------------------------------------------------------
1009:     PROCEDURE BtnSalvarClick()
1010:         LOCAL loc_oPg2
1011:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1012: 
1013:         *-- Validar Codigo (obrigatorio apenas no modo INCLUIR)
1014:         IF THIS.this_cModoAtual = "INCLUIR"
1015:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1016:                 MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!", "Validar")
1017:                 loc_oPg2.txt_4c_Codigo.SetFocus
1018:                 RETURN
1019:             ENDIF
1020:             IF THIS.this_oBusinessObject.VerificarCodigoExiste(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1021:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Validar")
1022:                 loc_oPg2.txt_4c_Codigo.SetFocus
1023:                 RETURN
1024:             ENDIF
1025:         ENDIF
1026: 
1027:         *-- Validar Grupo (obrigatorio em INCLUIR e ALTERAR)
1028:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1029:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Grupo.Value))
1030:                 MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Validar")
1031:                 loc_oPg2.txt_4c_Grupo.SetFocus
1032:                 RETURN
1033:             ENDIF
1034:         ENDIF
1035: 
1036:         *-- Validar Conta (obrigatorio em INCLUIR e ALTERAR, per legado)
1037:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1038:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
1039:                 MsgAviso("Conta Inv" + CHR(225) + "lida!", "Validar")
1040:                 loc_oPg2.txt_4c_Conta.SetFocus
1041:                 RETURN
1042:             ENDIF
1043:         ENDIF
1044: 
1045:         THIS.FormParaBO()
1046: 
1047:         LOCAL loc_lSucesso
1048:         loc_lSucesso = .F.
1049: 
1050:         TRY
1051:             IF THIS.this_oBusinessObject.Salvar()
1052:                 MsgInfo("Registro salvo com sucesso!")
1053:                 THIS.AlternarPagina(1)
1054:                 loc_lSucesso = .T.
1055:             ENDIF
1056:         CATCH TO loc_oErro
1057:             MsgErro(loc_oErro.Message + CHR(13) + ;
1058:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1059:                 "Procedure: " + loc_oErro.Procedure, "Erro BtnSalvarClick")
1060:         ENDTRY
1061:     ENDPROC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * BtnCancelarClick - Cancela edicao e volta para a lista
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE BtnCancelarClick()
1067:         THIS.AlternarPagina(1)
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * TeclaGrupo - Trata F4 no campo Grupo para abrir lookup SigCdGcr
1072:     *--------------------------------------------------------------------------
1073:     PROCEDURE TeclaGrupo(par_nKeyCode, par_nShiftAltCtrl)
1074:         IF par_nKeyCode = 63
1075:             THIS.AbrirBuscaGrupo()
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *--------------------------------------------------------------------------
1080:     * ValidarGrupo - Valida codigo do Grupo contra SigCdGcr ao sair do campo
1081:     *--------------------------------------------------------------------------
1082:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1083:         LOCAL loc_cGrupo
1084:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1085: 
1086:         IF EMPTY(loc_cGrupo)
1087:             RETURN
1088:         ENDIF
1089: 
1090:         IF THIS.this_oBusinessObject.BuscarGrupo(loc_cGrupo)
1091:             IF USED("cursor_4c_BuscaGrupo")
1092:                 USE IN cursor_4c_BuscaGrupo
1093:             ENDIF
1094:         ELSE
1095:             IF USED("cursor_4c_BuscaGrupo")
1096:                 USE IN cursor_4c_BuscaGrupo
1097:             ENDIF
1098:             THIS.AbrirBuscaGrupo()
1099:         ENDIF
1100:     ENDPROC
1101: 
1102:     *--------------------------------------------------------------------------
1103:     * AbrirBuscaGrupo - Abre picker FormBuscaAuxiliar para SigCdGcr
1104:     *--------------------------------------------------------------------------
1105:     PROCEDURE AbrirBuscaGrupo()
1106:         LOCAL loc_oBusca, loc_cGrupo
1107:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
1108: 
1109:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1110:             "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1111:             "Grupo de Conta Corrente")
1112: 
1113:         IF VARTYPE(loc_oBusca) = "O"
1114:             IF !loc_oBusca.this_lAchouRegistro
1115:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1116:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1117:                 loc_oBusca.Show()
1118:             ENDIF
1119: 
1120:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1121:                 SELECT cursor_4c_BuscaGrupo
1122:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ;
1123:                     ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1124:             ENDIF
1125: 
1126:             loc_oBusca.Release()
1127:         ENDIF
1128: 
1129:         IF USED("cursor_4c_BuscaGrupo")
1130:             USE IN cursor_4c_BuscaGrupo
1131:         ENDIF
1132:     ENDPROC
1133: 
1134:     *--------------------------------------------------------------------------
1135:     * TeclaContaC - Trata F4 no campo Conta para abrir lookup
1136:     *--------------------------------------------------------------------------
1137:     PROCEDURE TeclaContaC(par_nKeyCode, par_nShiftAltCtrl)
1138:         IF par_nKeyCode = 63
1139:             THIS.AbrirBuscaContaC()
1140:         ENDIF
1141:     ENDPROC
1142: 
1143:     *--------------------------------------------------------------------------
1144:     * ValidarContaC - Valida conta ao perder foco; habilita/desabilita dconta
1145:     *--------------------------------------------------------------------------
1146:     PROCEDURE ValidarContaC(par_nKeyCode, par_nShiftAltCtrl)
1147:         LOCAL loc_cConta
1148:         loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
1149: 
1150:         IF loc_cConta == THIS.this_cUltimoContas
1151:             THIS.AtualizarHabilitacaoDconta()
1152:             RETURN
1153:         ENDIF
1154:         THIS.this_cUltimoContas = loc_cConta
1155: 
1156:         IF EMPTY(loc_cConta)
1157:             THIS.AtualizarHabilitacaoDconta()
1158:             RETURN
1159:         ENDIF
1160: 
1161:         LOCAL loc_cSQL, loc_nResult
1162:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1163:                    " WHERE Iclis = " + EscaparSQL(loc_cConta)
1164: 
1165:         IF USED("cursor_4c_ChkConta")
1166:             USE IN cursor_4c_ChkConta
1167:         ENDIF
1168: 
1169:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
1170: 
1171:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkConta") = 0
1172:             THIS.AbrirBuscaContaC()
1173:         ENDIF
1174: 
1175:         IF USED("cursor_4c_ChkConta")
1176:             USE IN cursor_4c_ChkConta
1177:         ENDIF
1178: 
1179:         THIS.AtualizarHabilitacaoDconta()
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * AbrirBuscaContaC - Abre picker FormBuscaAuxiliar para conta credito (SigCdCli)
1184:     *--------------------------------------------------------------------------
1185:     PROCEDURE AbrirBuscaContaC()
1186:         LOCAL loc_oPg2
1187:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1188: 
1189:         IF !loc_oPg2.txt_4c_Conta.Enabled
1190:             RETURN
1191:         ENDIF
1192: 
1193:         LOCAL loc_oBusca, loc_cConta
1194:         loc_cConta = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1195: 
1196:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1197:             "SigCdCli", "cursor_4c_BuscaContaC", "Iclis", loc_cConta, ;
1198:             "Buscar Conta")
1199: 
1200:         IF VARTYPE(loc_oBusca) = "O"
1201:             IF !loc_oBusca.this_lAchouRegistro
1202:                 loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1203:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1204:                 loc_oBusca.Show()
1205:             ENDIF
1206: 
1207:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaContaC")
1208:                 SELECT cursor_4c_BuscaContaC
1209:                 loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1210:                 THIS.this_cUltimoContas     = ALLTRIM(cursor_4c_BuscaContaC.Iclis)
1211:             ENDIF
1212: 
1213:             loc_oBusca.Release()
1214:         ENDIF
1215: 
1216:         IF USED("cursor_4c_BuscaContaC")
1217:             USE IN cursor_4c_BuscaContaC
1218:         ENDIF
1219: 
1220:         THIS.AtualizarHabilitacaoDconta()
1221:     ENDPROC
1222: 
1223:     *--------------------------------------------------------------------------
1224:     * TeclaDconta - Trata F4 no campo DConta para abrir lookup
1225:     *--------------------------------------------------------------------------
1226:     PROCEDURE TeclaDconta(par_nKeyCode, par_nShiftAltCtrl)
1227:         IF par_nKeyCode = 63
1228:             THIS.AbrirBuscaDconta()
1229:         ENDIF
1230:     ENDPROC
1231: 
1232:     *--------------------------------------------------------------------------
1233:     * ValidarDconta - Valida dconta ao perder foco
1234:     *--------------------------------------------------------------------------
1235:     PROCEDURE ValidarDconta(par_nKeyCode, par_nShiftAltCtrl)
1236:         LOCAL loc_cDConta
1237:         loc_cDConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dconta.Value)
1238: 
1239:         IF loc_cDConta == THIS.this_cUltimoDContas
1240:             RETURN
1241:         ENDIF
1242:         THIS.this_cUltimoDContas = loc_cDConta
1243: 
1244:         IF EMPTY(loc_cDConta)
1245:             RETURN
1246:         ENDIF
1247: 
1248:         LOCAL loc_cSQL, loc_nResult
1249:         loc_cSQL = "SELECT TOP 1 Iclis, Rclis FROM SigCdCli" + ;
1250:                    " WHERE Iclis = " + EscaparSQL(loc_cDConta)
1251: 
1252:         IF USED("cursor_4c_ChkDConta")
1253:             USE IN cursor_4c_ChkDConta
1254:         ENDIF
1255: 
1256:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDConta")
1257: 
1258:         IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkDConta") = 0
1259:             THIS.AbrirBuscaDconta()
1260:         ENDIF
1261: 
1262:         IF USED("cursor_4c_ChkDConta")
1263:             USE IN cursor_4c_ChkDConta
1264:         ENDIF
1265:     ENDPROC
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * AbrirBuscaDconta - Abre picker FormBuscaAuxiliar para conta debito (SigCdCli)
1269:     *--------------------------------------------------------------------------
1270:     PROCEDURE AbrirBuscaDconta()
1271:         LOCAL loc_oPg2
1272:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1273: 
1274:         IF !loc_oPg2.txt_4c_Dconta.Enabled
1275:             RETURN
1276:         ENDIF
1277: 
1278:         LOCAL loc_oBusca, loc_cDConta
1279:         loc_cDConta = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)
1280: 
1281:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1282:             "SigCdCli", "cursor_4c_BuscaDConta", "Iclis", loc_cDConta, ;
1283:             "Buscar Conta D" + CHR(233) + "bito")
1284: 
1285:         IF VARTYPE(loc_oBusca) = "O"
1286:             IF !loc_oBusca.this_lAchouRegistro
1287:                 loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1288:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1289:                 loc_oBusca.Show()
1290:             ENDIF
1291: 
1292:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDConta")
1293:                 SELECT cursor_4c_BuscaDConta
1294:                 loc_oPg2.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1295:                 THIS.this_cUltimoDContas     = ALLTRIM(cursor_4c_BuscaDConta.Iclis)
1296:             ENDIF
1297: 
1298:             loc_oBusca.Release()
1299:         ENDIF
1300: 
1301:         IF USED("cursor_4c_BuscaDConta")
1302:             USE IN cursor_4c_BuscaDConta
1303:         ENDIF
1304:     ENDPROC
1305: 
1306:     *--------------------------------------------------------------------------
1307:     * AtualizarHabilitacaoDconta - Habilita DConta apenas quando Conta esta vazio
1308:     * Replica logica When do campo Get_dconta no legado
1309:     *--------------------------------------------------------------------------
1310:     PROCEDURE AtualizarHabilitacaoDconta()
1311:         LOCAL loc_oPg2, loc_lContaVazia
1312:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1313:         loc_lContaVazia = EMPTY(ALLTRIM(loc_oPg2.txt_4c_Conta.Value))
1314: 
1315:         *-- DConta so fica acessivel quando Conta estiver vazio (legado: When=EMPTY(get_conta))
1316:         *-- Respeitar tambem o modo atual: se VISUALIZAR, ambos desabilitados
1317:         IF THIS.this_cModoAtual = "VISUALIZAR"
1318:             loc_oPg2.txt_4c_Dconta.Enabled = .F.
1319:         ELSE
1320:             loc_oPg2.txt_4c_Dconta.Enabled = loc_lContaVazia
1321:         ENDIF
1322:     ENDPROC
1323: 
1324:     *--------------------------------------------------------------------------
1325:     * BOParaForm - Transfere dados do BO para os campos do formulario
1326:     *--------------------------------------------------------------------------
1327:     PROTECTED PROCEDURE BOParaForm()
1328:         LOCAL loc_oPg2, loc_nOpers, loc_nContabs, loc_nNotas
1329:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1330: 
1331:         WITH THIS.this_oBusinessObject
1332:             loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(NVL(.this_cCodigos, ""))
1333:             loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(NVL(.this_cDescrs,  ""))
1334:             loc_oPg2.txt_4c_Grupo.Value     = ALLTRIM(NVL(.this_cGrupos,  ""))
1335:             loc_oPg2.txt_4c_Conta.Value     = ALLTRIM(NVL(.this_cContas,  ""))
1336:             loc_oPg2.txt_4c_Dconta.Value    = ALLTRIM(NVL(.this_cDContas, ""))
1337: 
1338:             *-- OpcaoOcorrencia: "DB"=1 (Debito), "CR"=2 (Credito)
1339:             IF ALLTRIM(NVL(.this_cOpers, "")) = "DB"
1340:                 loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1
1341:             ELSE
1342:                 loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 2
1343:             ENDIF
1344: 
1345:             *-- Opcaocontab: 1=Sim, 2=Nao (default 2 para novos registros)
1346:             loc_nContabs = NVL(.this_nContabs, 0)
1347:             loc_oPg2.opt_4c_Opcaocontab.Value = IIF(loc_nContabs = 1, 1, 2)
1348: 
1349:             *-- OpcaoSNA: 1=Sim, 2=Nao, 3=Ambos (0=nenhum)
1350:             loc_nNotas = NVL(.this_nNotas, 0)
1351:             loc_oPg2.opt_4c_OpcaoSNA.Value = IIF(INLIST(loc_nNotas, 1, 2, 3), loc_nNotas, 0)
1352:         ENDWITH
1353: 
1354:         THIS.this_cUltimoContas  = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1355:         THIS.this_cUltimoDContas = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)
1356:         THIS.AtualizarHabilitacaoDconta()
1357:     ENDPROC
1358: 
1359:     *--------------------------------------------------------------------------
1360:     * FormParaBO - Transfere dados dos campos para o BO
1361:     *--------------------------------------------------------------------------
1362:     PROTECTED PROCEDURE FormParaBO()
1363:         LOCAL loc_oPg2
1364:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1365: 
1366:         WITH THIS.this_oBusinessObject
1367:             .this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1368:             .this_cDescrs  = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1369:             .this_cGrupos  = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1370:             .this_cContas  = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
1371:             .this_cDContas = ALLTRIM(loc_oPg2.txt_4c_Dconta.Value)
1372: 
1373:             *-- OpcaoOcorrencia: Value=1 -> "DB" (Debito), Value=2 -> "CR" (Credito)
1374:             IF loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1
1375:                 .this_cOpers = "DB"
1376:             ELSE
1377:                 .this_cOpers = "CR"
1378:             ENDIF
1379: 
1380:             *-- Opcaocontab: Value diretamente (1=Sim, 2=Nao)
1381:             .this_nContabs = loc_oPg2.opt_4c_Opcaocontab.Value
1382: 
1383:             *-- OpcaoSNA: Value diretamente (1=Sim, 2=Nao, 3=Ambos)
1384:             .this_nNotas   = loc_oPg2.opt_4c_OpcaoSNA.Value
1385:         ENDWITH
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * HabilitarCampos - Habilita ou desabilita campos conforme modo atual
1390:     *--------------------------------------------------------------------------
1391:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1392:         LOCAL loc_oPg2
1393:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1394: 
1395:         *-- Codigo: editavel apenas em INCLUIR (PK nao muda em ALTERAR)
1396:         loc_oPg2.txt_4c_Codigo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1397:         loc_oPg2.txt_4c_Descricao.Enabled              = par_lHabilitar
1398:         loc_oPg2.txt_4c_Grupo.Enabled                  = par_lHabilitar
1399:         loc_oPg2.txt_4c_Conta.Enabled                  = par_lHabilitar
1400:         loc_oPg2.opt_4c_OpcaoOcorrencia.Enabled        = par_lHabilitar
1401:         loc_oPg2.opt_4c_Opcaocontab.Enabled            = par_lHabilitar
1402:         loc_oPg2.opt_4c_OpcaoSNA.Enabled               = par_lHabilitar
1403: 
1404:         *-- DConta: respeitando logica When (acessivel apenas quando Conta esta vazio)
1405:         *-- Se par_lHabilitar=.F. (VISUALIZAR), dconta fica desabilitado
1406:         *-- Se par_lHabilitar=.T., delegar para AtualizarHabilitacaoDconta
1407:         IF !par_lHabilitar
1408:             loc_oPg2.txt_4c_Dconta.Enabled = .F.
1409:         ELSE
1410:             THIS.AtualizarHabilitacaoDconta()
1411:         ENDIF
1412:     ENDPROC
1413: 
1414:     *--------------------------------------------------------------------------
1415:     * LimparCampos - Limpa todos os campos do formulario
1416:     *--------------------------------------------------------------------------
1417:     PROTECTED PROCEDURE LimparCampos()
1418:         LOCAL loc_oPg2
1419:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1420: 
1421:         loc_oPg2.txt_4c_Codigo.Value   = ""
1422:         loc_oPg2.txt_4c_Descricao.Value = ""
1423:         loc_oPg2.txt_4c_Grupo.Value     = ""
1424:         loc_oPg2.txt_4c_Conta.Value     = ""
1425:         loc_oPg2.txt_4c_Dconta.Value    = ""
1426: 
1427:         *-- OpcaoOcorrencia: sem selecao inicial para novo registro
1428:         loc_oPg2.opt_4c_OpcaoOcorrencia.Value = 1
1429: 
1430:         *-- Opcaocontab: padrao = 2 (Nao) para novo registro (legado: .value=2 no INSERIR)
1431:         loc_oPg2.opt_4c_Opcaocontab.Value = 2
1432: 
1433:         *-- OpcaoSNA: sem selecao inicial
1434:         loc_oPg2.opt_4c_OpcaoSNA.Value = 0
1435: 
1436:         THIS.this_cUltimoContas  = ""
1437:         THIS.this_cUltimoDContas = ""
1438: 
1439:         *-- DConta habilitado porque Conta estara vazio (reproduz logica When do legado)
1440:         loc_oPg2.txt_4c_Dconta.Enabled = .T.
1441:     ENDPROC
1442: 
1443:     *--------------------------------------------------------------------------
1444:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1445:     *--------------------------------------------------------------------------
1446:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1447:         LOCAL loc_nI, loc_oObjeto, loc_nP
1448: 
1449:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1450:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1451: 
1452:             IF VARTYPE(loc_oObjeto) = "O"
1453:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1454:                     loc_oObjeto.Visible = .T.
1455:                 ENDIF
1456: 
1457:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1458:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1459:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1460:                     ENDFOR
1461:                 ENDIF
1462: 
1463:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1464:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1465:                 ENDIF
1466:             ENDIF
1467:         ENDFOR
1468:     ENDPROC
1469: 
1470:     *--------------------------------------------------------------------------
1471:     * FormatarGridLista - Formata visual do grid da lista (Tahoma 8)
1472:     *--------------------------------------------------------------------------
1473:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1474:         WITH par_oGrid
1475:             .FontName = "Tahoma"
1476:             .FontSize = 8
1477:         ENDWITH
1478:     ENDPROC
1479: 
1480:     *--------------------------------------------------------------------------
1481:     * Destroy - Libera recursos ao fechar o formulario
1482:     *--------------------------------------------------------------------------
1483:     PROCEDURE Destroy()
1484:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1485:             THIS.this_oBusinessObject = .NULL.
1486:         ENDIF
1487:         DODEFAULT()
1488:     ENDPROC
1489: 
1490: ENDDEFINE


### BO (C:\4c\projeto\app\classes\COCBO.prg):
*==============================================================================
* COCBO.prg - Business Object para Ocorrencias de Titulos (COC)
* Tabela: SigOpOco | PK: Codigos
* Schema: Codigos char(10), Descrs char(30), Grupos char, Contas char,
*         DContas char, Opers char(2), Contabs numeric, Notas numeric
*==============================================================================

DEFINE CLASS COCBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigOpOco)
    this_cCodigos  = ""    && Codigos  CHAR(10) - Codigo da Ocorrencia (PK)
    this_cDescrs   = ""    && Descrs   CHAR(30) - Descricao
    this_cGrupos   = ""    && Grupos   CHAR     - Codigo do Grupo (FK->SigCdGcr.Codigos)
    this_cContas   = ""    && Contas   CHAR     - Conta (FK->SigCdCli)
    this_cDContas  = ""    && DContas  CHAR     - Descricao da Conta (D-conta)
    this_cOpers    = ""    && Opers    CHAR(2)  - Tipo de Operacao ("DB"=Debito, "CR"=Credito)
    this_nContabs  = 0     && Contabs  NUMERIC  - Lanca Contabilidade (1=Sim, 2=Nao)
    this_nNotas    = 0     && Notas    NUMERIC  - Opcao SNA (1=Sim, 2=Nao, 3=Ambos)

    *-- Parametros de SigCdPac para captions do OpcaoSNA
    this_cTitOpcS  = "Sim"
    this_cTitOpcN  = "N" + CHR(227) + "o"
    this_cTitOpcA  = "Ambos"

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpOco"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros de SigCdPac (captions OpcaoSNA)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametros()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"

            IF USED("cursor_4c_Params")
                TABLEREVERT(.T., "cursor_4c_Params")
                USE IN cursor_4c_Params
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Params")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Params") > 0
                SELECT cursor_4c_Params
                GO TOP
                THIS.this_cTitOpcS = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcS, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcS, "C")), "Sim")
                THIS.this_cTitOpcN = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcN, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcN, "C")), "N" + CHR(227) + "o")
                THIS.this_cTitOpcA = IIF(!EMPTY(ALLTRIM(TratarNulo(TitOpcA, "C"))), ;
                    ALLTRIM(TratarNulo(TitOpcA, "C")), "Ambos")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarParametros")
        ENDTRY

        IF USED("cursor_4c_Params")
            USE IN cursor_4c_Params
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros com filtro opcional
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs, Grupos, Contas, DContas," + ;
                       " Opers, Contabs, Notas" + ;
                       " FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            THIS.this_cGrupos  = TratarNulo(Grupos,  "C")
            THIS.this_cContas  = TratarNulo(Contas,  "C")
            THIS.this_cDContas = TratarNulo(DContas, "C")
            THIS.this_cOpers   = TratarNulo(Opers,   "C")
            THIS.this_nContabs = TratarNulo(Contabs, "N")
            THIS.this_nNotas   = TratarNulo(Notas,   "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupo - Valida/busca grupo em SigCdGcr pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                       " ORDER BY Codigos"

            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")

            IF loc_nResult >= 0
                loc_lSucesso = RECCOUNT("cursor_4c_BuscaGrupo") > 0
            ELSE
                MostrarErro("Erro ao buscar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.BuscarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja existe na tabela
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_ChkExiste")
                TABLEREVERT(.T., "cursor_4c_ChkExiste")
                USE IN cursor_4c_ChkExiste
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExiste")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkExiste") > 0
                SELECT cursor_4c_ChkExiste
                loc_lExiste = (cursor_4c_ChkExiste.nExiste > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.VerificarCodigoExiste")
        ENDTRY

        IF USED("cursor_4c_ChkExiste")
            USE IN cursor_4c_ChkExiste
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigOpOco" + ;
                       " (Codigos, Descrs, Grupos, Contas, DContas, Opers, Contabs, Notas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpOco SET" + ;
                       " Descrs  = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ", " + ;
                       " Grupos  = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos))  + ", " + ;
                       " Contas  = " + EscaparSQL(ALLTRIM(THIS.this_cContas))  + ", " + ;
                       " DContas = " + EscaparSQL(ALLTRIM(THIS.this_cDContas)) + ", " + ;
                       " Opers   = " + EscaparSQL(ALLTRIM(THIS.this_cOpers))   + ", " + ;
                       " Contabs = " + FormatarNumeroSQL(THIS.this_nContabs)   + ", " + ;
                       " Notas   = " + FormatarNumeroSQL(THIS.this_nNotas)     + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigOpOco (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpOco" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "COCBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

