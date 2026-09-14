# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarCodigo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOET.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (918 linhas total):

*-- Linhas 26 a 151:
26:     *===========================================================================
27:     * Init - Inicializa o formulario
28:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
30:     *===========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *===========================================================================
36:     * InicializarForm - Configura estrutura completa
37:     * Chamado automaticamente pelo FormBase.Init()
38:     *===========================================================================
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.this_oBusinessObject = CREATEOBJECT("OETBO")
45: 
46:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
47:                 MostrarErro("Erro ao criar OETBO" + CHR(13) + ;
48:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
49:                     "FormOET.InicializarForm")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55: 
56:                 THIS.pgf_4c_Paginas.Visible    = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual           = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 loc_lSucesso = .T.
65:             ENDIF
66: 
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar FormOET:" + CHR(13) + ;
69:                 loException.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loException.LineNo), ;
71:                 "FormOET.InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *===========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com 2 paginas
79:     * Top=-29 esconde abas; controles compensam +29 no Top
80:     *===========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 (Lista)
108:     * Containers base: cnt_4c_Cabecalho, cnt_4c_Botoes, cnt_4c_Saida
109:     * Grid e botoes CRUD: fase 4
110:     *===========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container Cabecalho (cntSombra no legado)
119:         *-- Legado: Top=1 -> com compensacao +29: Top=30
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top       = 30
123:             .Left      = 0
124:             .Width     = THIS.Width
125:             .Height    = 80
126:             .BackColor = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = 769
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = 769

*-- Linhas 205 a 248:
205:             .Visible         = .T.
206:         ENDWITH
207: 
208:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
209: 
210:         *-- Botoes CRUD dentro de cnt_4c_Botoes
211:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
212:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
213:             .Caption         = "Incluir"
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
215:             .PicturePosition = 13
216:             .Top             = 5
217:             .Left            = 5
218:             .Width           = 75
219:             .Height          = 75
220:             .FontName        = "Comic Sans MS"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontSize        = 8
224:             .ForeColor       = RGB(90, 90, 90)
225:             .BackColor       = RGB(255, 255, 255)
226:             .Themes          = .F.
227:             .SpecialEffect   = 0
228:             .MousePointer    = 15
229:             .WordWrap        = .T.
230:             .Visible         = .T.
231:         ENDWITH
232: 
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
235:             .Caption         = "Visualizar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 80
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .FontSize        = 8
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.

*-- Linhas 318 a 399:
318:             .Visible         = .T.
319:         ENDWITH
320: 
321:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
322:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
324:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
326: 
327:         *-- Grid Lista (Grade no legado: colunas Cods(50) e Descrs(290))
328:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
329:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
330:         WITH loc_oPagina.grd_4c_Lista
331:             .Top                = 123
332:             .Left               = 32
333:             .Width              = 880
334:             .Height             = 470
335:             .FontName           = "Verdana"
336:             .FontSize           = 8
337:             .ForeColor          = RGB(90, 90, 90)
338:             .BackColor          = RGB(255, 255, 255)
339:             .GridLineColor      = RGB(238, 238, 238)
340:             .HighlightBackColor = RGB(255, 255, 255)
341:             .HighlightForeColor = RGB(15, 41, 104)
342:             .HighlightStyle     = 2
343:             .DeleteMark         = .F.
344:             .RecordMark         = .F.
345:             .RowHeight          = 16
346:             .ScrollBars         = 2
347:             .GridLines          = 3
348:             .Visible            = .T.
349:         ENDWITH
350: 
351:         THIS.TornarControlesVisiveis(loc_oPagina)
352:     ENDPROC
353: 
354:     *===========================================================================
355:     * ConfigurarPaginaDados - Configura Page2 (Dados)
356:     * Container BotoesAcao base: cnt_4c_BotoesAcao
357:     * TextBoxes e campos: fases 5-6
358:     *===========================================================================
359:     PROTECTED PROCEDURE ConfigurarPaginaDados()
360:         LOCAL loc_oPagina
361:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
362: 
363:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
364:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
365: 
366:         *-- Container BotoesAcao (Grupo_Salva no legado)
367:         *-- Legado: Left=619, Top=8 -> com compensacao +29: Top=37
368:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
369:         WITH loc_oPagina.cnt_4c_BotoesAcao
370:             .Top       = 37
371:             .Left      = 619
372:             .Width     = 172
373:             .Height    = 85
374:             .BackStyle = 0
375:             .BorderWidth = 0
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
380:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
381:             .Caption         = "Confirmar"
382:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
383:             .PicturePosition = 13
384:             .Top             = 5
385:             .Left            = 12
386:             .Width           = 75
387:             .Height          = 75
388:             .FontName        = "Comic Sans MS"
389:             .FontBold        = .T.
390:             .FontItalic      = .T.
391:             .FontSize        = 8
392:             .ForeColor       = RGB(90, 90, 90)
393:             .BackColor       = RGB(255, 255, 255)
394:             .Themes          = .F.
395:             .SpecialEffect   = 0
396:             .MousePointer    = 15
397:             .WordWrap        = .T.
398:             .Visible         = .T.
399:         ENDWITH

*-- Linhas 420 a 502:
420:             .Visible         = .T.
421:         ENDWITH
422: 
423:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
424:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click",  THIS, "BtnCancelarClick")
425: 
426:         *-- === FASE 5: Campos Principais (Parte 1) ===
427:         *-- Posicoes compensadas: Top_original + 29 (PageFrame.Top = -29)
428: 
429:         *-- Label "Codigo :" (Say8: Top=170, Left=185, Width=42)
430:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
431:         WITH loc_oPagina.lbl_4c_Label8
432:             .Caption   = "C" + CHR(243) + "digo :"
433:             .Top       = 199
434:             .Left      = 185
435:             .Width     = 42
436:             .Height    = 17
437:             .FontName  = "Tahoma"
438:             .FontSize  = 8
439:             .FontBold  = .F.
440:             .ForeColor = RGB(90, 90, 90)
441:             .BackStyle = 0
442:             .Alignment = 1
443:             .Visible   = .T.
444:         ENDWITH
445: 
446:         *-- TextBox Codigo (getCods: Top=167, Left=231, Width=31)
447:         *-- When: Return Inlist(ThisForm.pcEscolha, 'INSERIR', 'PROCURAR')
448:         *-- Valid: Verifica duplicidade em INSERT
449:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
450:         WITH loc_oPagina.txt_4c_Codigo
451:             .Value    = ""
452:             .Top      = 196
453:             .Left     = 231
454:             .Width    = 31
455:             .Height   = 21
456:             .FontName = "Tahoma"
457:             .FontSize = 8
458:             .MaxLength = 5
459:             .Visible  = .T.
460:         ENDWITH
461: 
462:         BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "ValidarCodigo")
463: 
464:         *-- Label "Descricao :" (Say1: Top=197, Left=172, Width=55)
465:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
466:         WITH loc_oPagina.lbl_4c_Label1
467:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
468:             .Top       = 226
469:             .Left      = 172
470:             .Width     = 55
471:             .Height    = 17
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.
475:             .ForeColor = RGB(90, 90, 90)
476:             .BackStyle = 0
477:             .Alignment = 1
478:             .Visible   = .T.
479:         ENDWITH
480: 
481:         *-- TextBox Descricao (getDescrs: Top=194, Left=231, Width=290)
482:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
483:         WITH loc_oPagina.txt_4c_Descrs
484:             .Value    = ""
485:             .Top      = 223
486:             .Left     = 231
487:             .Width    = 290
488:             .Height   = 21
489:             .FontName = "Tahoma"
490:             .FontSize = 8
491:             .MaxLength = 50
492:             .Visible  = .T.
493:         ENDWITH
494: 
495:         *-- CheckBox Justificativa Obrigatoria (Opt_Justif: Top=222, Left=231, Width=152, Height=18)
496:         *-- Caption original: "Justificativa Obrigatoria" (com acentos via CHR)
497:         loc_oPagina.AddObject("chk_4c_Opt_Justif", "CheckBox")
498:         WITH loc_oPagina.chk_4c_Opt_Justif
499:             .Caption  = "Justificativa Obrigat" + CHR(243) + "ria"
500:             .Value    = 0
501:             .Top      = 251
502:             .Left     = 231

*-- Linhas 509 a 918:
509:             .Visible  = .T.
510:         ENDWITH
511: 
512:         THIS.TornarControlesVisiveis(loc_oPagina)
513:     ENDPROC
514: 
515:     *===========================================================================
516:     * ValidarCodigo - Valida codigo ao sair do campo (LostFocus)
517:     * Verifica duplicidade em modo INCLUIR (comportamento.json: getCods.Valid)
518:     *===========================================================================
519:     PROCEDURE ValidarCodigo()
520:         LOCAL loc_oPg2, loc_cCodigo
521:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
522:         loc_cCodigo = ""
523: 
524:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
525:             loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
526:         ENDIF
527: 
528:         IF THIS.this_cModoAtual = "INCLUIR" AND !EMPTY(loc_cCodigo)
529:             LOCAL loc_nResult, loc_cSQL
530:             loc_cSQL = "SELECT TOP 1 cods FROM SigEtOco WHERE cods = " + ;
531:                 EscaparSQL(loc_cCodigo)
532:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
533:             IF loc_nResult > 0 AND USED("cursor_4c_ChkCod") AND ;
534:                     RECCOUNT("cursor_4c_ChkCod") > 0
535:                 MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", "")
536:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
537:                     loc_oPg2.txt_4c_Codigo.Value = ""
538:                     loc_oPg2.txt_4c_Codigo.SetFocus()
539:                 ENDIF
540:             ENDIF
541:             IF USED("cursor_4c_ChkCod")
542:                 USE IN cursor_4c_ChkCod
543:             ENDIF
544:         ENDIF
545:     ENDPROC
546: 
547:     *===========================================================================
548:     * CarregarLista - Carrega dados no Grid da Page1
549:     *===========================================================================
550:     PROCEDURE CarregarLista()
551:         LOCAL loc_lResultado, loc_oGrid
552:         loc_lResultado = .F.
553: 
554:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
555:             RETURN .T.
556:         ENDIF
557: 
558:         TRY
559:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
560: 
561:             IF THIS.this_oBusinessObject.Buscar("")
562:                 loc_oGrid.ColumnCount = 2
563:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
564:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
565:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
566: 
567:                 loc_oGrid.Column1.Width = 50
568:                 loc_oGrid.Column2.Width = 290
569: 
570:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
571:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
572: 
573:                 THIS.FormatarGridLista(loc_oGrid)
574: 
575:                 loc_lResultado = .T.
576:             ENDIF
577:         CATCH TO loException
578:             MsgErro("Erro em CarregarLista:" + CHR(13) + loException.Message, "Erro")
579:         ENDTRY
580: 
581:         RETURN loc_lResultado
582:     ENDPROC
583: 
584:     *===========================================================================
585:     * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
586:     *===========================================================================
587:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
588:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
589:             RETURN .F.
590:         ENDIF
591: 
592:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
593: 
594:         IF par_nPagina = 1
595:             THIS.this_cModoAtual = "LISTA"
596:             THIS.CarregarLista()
597:         ENDIF
598: 
599:         RETURN .T.
600:     ENDPROC
601: 
602:     *===========================================================================
603:     * BtnEncerrarClick - Fecha o formulario
604:     *===========================================================================
605:     PROCEDURE BtnEncerrarClick()
606:         THIS.Release()
607:     ENDPROC
608: 
609:     *===========================================================================
610:     * BtnIncluirClick - Incluir novo registro
611:     *===========================================================================
612:     PROCEDURE BtnIncluirClick()
613:         THIS.this_oBusinessObject.NovoRegistro()
614:         THIS.LimparCampos()
615:         THIS.this_cModoAtual = "INCLUIR"
616:         THIS.HabilitarCampos(.T.)
617:         THIS.AjustarBotoesPorModo()
618:         THIS.AlternarPagina(2)
619:         LOCAL loc_oPg2
620:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
621:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
622:             loc_oPg2.txt_4c_Codigo.SetFocus()
623:         ENDIF
624:     ENDPROC
625: 
626:     *===========================================================================
627:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
628:     *===========================================================================
629:     PROCEDURE BtnVisualizarClick()
630:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
631:             MsgAviso("Selecione um registro na lista.", "Aviso")
632:             RETURN
633:         ENDIF
634:         LOCAL loc_cCodigo, loc_oPg2
635:         SELECT cursor_4c_Dados
636:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
637:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
638:             THIS.BOParaForm()
639:             THIS.this_cModoAtual = "VISUALIZAR"
640:             THIS.HabilitarCampos(.F.)
641:             THIS.AjustarBotoesPorModo()
642:             THIS.AlternarPagina(2)
643:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
644:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
645:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
646:             ENDIF
647:         ENDIF
648:     ENDPROC
649: 
650:     *===========================================================================
651:     * BtnAlterarClick - Alterar registro selecionado
652:     *===========================================================================
653:     PROCEDURE BtnAlterarClick()
654:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
655:             MsgAviso("Selecione um registro na lista.", "Aviso")
656:             RETURN
657:         ENDIF
658:         LOCAL loc_cCodigo, loc_oPg2
659:         SELECT cursor_4c_Dados
660:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
661:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
662:             THIS.this_oBusinessObject.EditarRegistro()
663:             THIS.BOParaForm()
664:             THIS.this_cModoAtual = "ALTERAR"
665:             THIS.HabilitarCampos(.T.)
666:             THIS.AjustarBotoesPorModo()
667:             THIS.AlternarPagina(2)
668:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
669:             IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
670:                 loc_oPg2.txt_4c_Descrs.SetFocus()
671:             ENDIF
672:         ENDIF
673:     ENDPROC
674: 
675:     *===========================================================================
676:     * BtnExcluirClick - Excluir registro selecionado
677:     *===========================================================================
678:     PROCEDURE BtnExcluirClick()
679:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
680:             MsgAviso("Selecione um registro na lista.", "Aviso")
681:             RETURN
682:         ENDIF
683:         LOCAL loc_cCodigo
684:         SELECT cursor_4c_Dados
685:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cods)
686:         IF !MsgConfirma("Confirma exclus" + CHR(227) + "o da ocorr" + CHR(234) + ;
687:                 "ncia '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
688:             RETURN
689:         ENDIF
690:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
691:             IF THIS.this_oBusinessObject.Excluir()
692:                 MsgInfo("Ocorr" + CHR(234) + "ncia exclu" + CHR(237) + "da com sucesso.", "Sucesso")
693:                 THIS.CarregarLista()
694:             ENDIF
695:         ENDIF
696:     ENDPROC
697: 
698:     *===========================================================================
699:     * BtnBuscarClick - Abre FormBuscaAuxiliar para localizar ocorrencia
700:     *===========================================================================
701:     PROCEDURE BtnBuscarClick()
702:         LOCAL loc_oBusca, loc_cCodigo
703:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
704:             "SigEtOco", "cursor_4c_BuscaOET", "cods", "", ;
705:             "Buscar Ocorr" + CHR(234) + "ncia de Etiqueta")
706: 
707:         IF VARTYPE(loc_oBusca) = "O"
708:             loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
709:             loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
710:             loc_oBusca.Show()
711: 
712:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOET")
713:                 SELECT cursor_4c_BuscaOET
714:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaOET.cods)
715:                 IF USED("cursor_4c_Dados")
716:                     SELECT cursor_4c_Dados
717:                     LOCATE FOR ALLTRIM(cods) = loc_cCodigo
718:                     IF FOUND()
719:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
720:                     ENDIF
721:                 ENDIF
722:             ENDIF
723: 
724:             loc_oBusca.Release()
725:         ENDIF
726: 
727:         IF USED("cursor_4c_BuscaOET")
728:             USE IN cursor_4c_BuscaOET
729:         ENDIF
730:     ENDPROC
731: 
732:     *===========================================================================
733:     * BtnSalvarClick - Salva alteracoes
734:     *===========================================================================
735:     PROCEDURE BtnSalvarClick()
736:         LOCAL loc_lSucesso, loc_oPg2
737:         loc_lSucesso = .F.
738:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
739: 
740:         *-- Validacoes antes do TRY (CLAUDE.md regra #1)
741:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
742:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
743:                 MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", ;
744:                     "Valida" + CHR(231) + CHR(227) + "o")
745:                 loc_oPg2.txt_4c_Codigo.SetFocus()
746:                 RETURN .F.
747:             ENDIF
748:         ENDIF
749: 
750:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
751:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
752:                 MsgAviso("Descri" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!!!", ;
753:                     "Valida" + CHR(231) + CHR(227) + "o")
754:                 loc_oPg2.txt_4c_Descrs.SetFocus()
755:                 RETURN .F.
756:             ENDIF
757:         ENDIF
758: 
759:         THIS.FormParaBO()
760: 
761:         TRY
762:             IF THIS.this_oBusinessObject.Salvar()
763:                 MsgInfo("Ocorr" + CHR(234) + "ncia salva com sucesso.", "Sucesso")
764:                 THIS.AlternarPagina(1)
765:                 loc_lSucesso = .T.
766:             ENDIF
767:         CATCH TO loException
768:             MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
769:         ENDTRY
770: 
771:         RETURN loc_lSucesso
772:     ENDPROC
773: 
774:     *===========================================================================
775:     * BtnCancelarClick - Cancela e volta para lista
776:     *===========================================================================
777:     PROCEDURE BtnCancelarClick()
778:         THIS.AlternarPagina(1)
779:     ENDPROC
780: 
781:     *===========================================================================
782:     * FormParaBO - Transfere valores do Form para o BO
783:     *===========================================================================
784:     PROTECTED PROCEDURE FormParaBO()
785:         LOCAL loc_oPg2
786:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
787: 
788:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
789:             THIS.this_oBusinessObject.this_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
790:         ENDIF
791:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
792:             THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
793:         ENDIF
794:         IF PEMSTATUS(loc_oPg2, "chk_4c_Opt_Justif", 5)
795:             THIS.this_oBusinessObject.this_lJustifs = (loc_oPg2.chk_4c_Opt_Justif.Value = 1)
796:         ENDIF
797:     ENDPROC
798: 
799:     *===========================================================================
800:     * BOParaForm - Transfere valores do BO para o Form
801:     *===========================================================================
802:     PROTECTED PROCEDURE BOParaForm()
803:         LOCAL loc_oPg2
804:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
805: 
806:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
807:             loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
808:         ENDIF
809:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
810:             loc_oPg2.txt_4c_Descrs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
811:         ENDIF
812:         IF PEMSTATUS(loc_oPg2, "chk_4c_Opt_Justif", 5)
813:             loc_oPg2.chk_4c_Opt_Justif.Value = THIS.this_oBusinessObject.this_lJustifs
814:         ENDIF
815:     ENDPROC
816: 
817:     *===========================================================================
818:     * LimparCampos - Limpa todos os campos do Page2
819:     *===========================================================================
820:     PROTECTED PROCEDURE LimparCampos()
821:         LOCAL loc_oPg2
822:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
823: 
824:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
825:             loc_oPg2.txt_4c_Codigo.Value = ""
826:         ENDIF
827:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
828:             loc_oPg2.txt_4c_Descrs.Value = ""
829:         ENDIF
830:         IF PEMSTATUS(loc_oPg2, "chk_4c_Opt_Justif", 5)
831:             loc_oPg2.chk_4c_Opt_Justif.Value = 0
832:         ENDIF
833:     ENDPROC
834: 
835:     *===========================================================================
836:     * HabilitarCampos - Habilita ou desabilita campos do Page2
837:     *===========================================================================
838:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
839:         LOCAL loc_oPg2, loc_lHab
840:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
841:         loc_lHab = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
842: 
843:         IF PEMSTATUS(loc_oPg2, "txt_4c_Codigo", 5)
844:             loc_oPg2.txt_4c_Codigo.ReadOnly = !(loc_lHab AND THIS.this_cModoAtual = "INCLUIR")
845:             loc_oPg2.txt_4c_Codigo.Enabled  = .T.
846:         ENDIF
847:         IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
848:             loc_oPg2.txt_4c_Descrs.ReadOnly = !loc_lHab
849:             loc_oPg2.txt_4c_Descrs.Enabled  = .T.
850:         ENDIF
851:         IF PEMSTATUS(loc_oPg2, "chk_4c_Opt_Justif", 5)
852:             loc_oPg2.chk_4c_Opt_Justif.Enabled = loc_lHab
853:         ENDIF
854:     ENDPROC
855: 
856:     *===========================================================================
857:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
858:     *===========================================================================
859:     PROTECTED PROCEDURE AjustarBotoesPorModo()
860:         LOCAL loc_oPg2, loc_lEdicao
861:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
862:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
863: 
864:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
865:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
866:         ENDIF
867:         IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
868:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
869:         ENDIF
870:     ENDPROC
871: 
872:     *===========================================================================
873:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
874:     *===========================================================================
875:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
876:         LOCAL loc_nI, loc_oObjeto
877: 
878:         FOR loc_nI = 1 TO par_oContainer.ControlCount
879:             loc_oObjeto = par_oContainer.Controls(loc_nI)
880: 
881:             IF VARTYPE(loc_oObjeto) = "O"
882:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
883:                     loc_oObjeto.Visible = .T.
884:                 ENDIF
885: 
886:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
887:                     LOCAL loc_nP
888:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
889:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
890:                     ENDFOR
891:                 ENDIF
892: 
893:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
894:                     THIS.TornarControlesVisiveis(loc_oObjeto)
895:                 ENDIF
896:             ENDIF
897:         ENDFOR
898:     ENDPROC
899: 
900:     *===========================================================================
901:     * FormatarGridLista - Formata visual do grid da lista
902:     *===========================================================================
903:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
904:         WITH par_oGrid
905:             .FontName = "Tahoma"
906:             .FontSize = 8
907:         ENDWITH
908:     ENDPROC
909: 
910:     *===========================================================================
911:     * Destroy - Libera recursos
912:     *===========================================================================
913:     PROCEDURE Destroy()
914:         THIS.this_oBusinessObject = .NULL.
915:         DODEFAULT()
916:     ENDPROC
917: 
918: ENDDEFINE


### BO (C:\4c\projeto\app\classes\OETBO.prg):
*==============================================================================
* OETBO.prg - Business Object para Ocorrencias de Etiquetas
* Tabela: SigEtOco
* Chave: cods (char 3)
*==============================================================================
DEFINE CLASS OETBO AS BusinessBase

    *-- Propriedades dos campos da tabela SigEtOco
    this_cCodigo  = ""      && cods  char(3)
    this_cDescrs  = ""      && descrs char(40)
    this_lJustifs = .F.     && justifs numeric(1,0) - Justificativa Obrigatoria

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigEtOco"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional, popula cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cods, a.descrs, a.justifs" + ;
                       " FROM SigEtOco a"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar ocorr" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por PK, popula propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cods, a.descrs, a.justifs" + ;
                       " FROM SigEtOco a" + ;
                       " WHERE a.cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo  = TratarNulo(cods,   "C")
            THIS.this_cDescrs  = TratarNulo(descrs,  "C")
            THIS.this_lJustifs = ConverterParaLogico(justifs)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigEtOco (chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigEtOco (cods, descrs, justifs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       IIF(THIS.this_lJustifs, "1", "0") + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigEtOco (chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigEtOco SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " justifs = " + IIF(THIS.this_lJustifs, "1", "0") + ;
                       " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigEtOco (chamado por Excluir)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigEtOco WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

ENDDEFINE

