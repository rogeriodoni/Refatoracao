# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (978 linhas total):

*-- Linhas 33 a 184:
33:     this_cMensagemErro   = ""
34: 
35:     *==========================================================================
36:     PROCEDURE Init
37:     *==========================================================================
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *==========================================================================
42:     PROTECTED PROCEDURE ConfigurarPageFrame
43:     *==========================================================================
44:         LOCAL loc_cImgFundo
45:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
46:         IF FILE(loc_cImgFundo)
47:             THIS.Picture = loc_cImgFundo
48:         ENDIF
49:     ENDPROC
50: 
51:     *==========================================================================
52:     PROTECTED PROCEDURE InicializarForm
53:     *==========================================================================
54:         LOCAL loc_lSucesso, loc_oErro
55:         loc_lSucesso = .F.
56: 
57:         TRY
58:             THIS.this_oBusinessObject = CREATEOBJECT("sigprilaBO")
59:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
60:                 MsgErro("Erro ao criar sigprilaBO.", "Erro")
61:             ELSE
62:                 THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de Planilha"
63: 
64:                 THIS.ConfigurarPageFrame()
65:                 THIS.ConfigurarCabecalho()
66:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption  = THIS.Caption
68:                 THIS.ConfigurarPaginaLista()
69:                 THIS.ConfigurarPaginaDados()
70:                 THIS.TornarControlesVisiveis()
71: 
72:                 IF !THIS.this_oBusinessObject.InicializarParametros()
73:                     MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
74:                 ENDIF
75:                 THIS.PreencherCombo()
76: 
77:                 THIS.ConfigurarBINDEVENTs()
78:                 loc_lSucesso = .T.
79:             ENDIF
80:         CATCH TO loc_oErro
81:             MsgErro("Erro ao inicializar Formsigprila: " + loc_oErro.Message + ;
82:                 " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
83:                 " Proc=" + loc_oErro.Procedure, "Erro")
84:         ENDTRY
85: 
86:         RETURN loc_lSucesso
87:     ENDPROC
88: 
89:     *==========================================================================
90:     PROTECTED PROCEDURE ConfigurarCabecalho
91:     *==========================================================================
92:         LOCAL loc_nW, loc_cCaption
93:         loc_nW      = THIS.Width
94:         loc_cCaption = THIS.Caption
95: 
96:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
97:         WITH THIS.cnt_4c_Cabecalho
98:             .Top         = 0
99:             .Left        = 0
100:             .Width       = loc_nW
101:             .Height      = 80
102:             .BackStyle   = 1
103:             .BackColor   = RGB(100, 100, 100)
104:             .BorderWidth = 0
105: 
106:             .AddObject("lbl_4c_Sombra", "Label")
107:             WITH .lbl_4c_Sombra
108:                 .AutoSize  = .F.
109:                 .Width     = loc_nW
110:                 .Height    = 40
111:                 .Top       = 18
112:                 .Left      = 10
113:                 .Caption   = loc_cCaption
114:                 .FontName  = "Tahoma"
115:                 .FontSize  = 18
116:                 .FontBold  = .T.
117:                 .BackStyle = 0
118:                 .ForeColor = RGB(0, 0, 0)
119:                 .WordWrap  = .T.
120:                 .Alignment = 0
121:             ENDWITH
122: 
123:             .AddObject("lbl_4c_Titulo", "Label")
124:             WITH .lbl_4c_Titulo
125:                 .AutoSize  = .F.
126:                 .Width     = loc_nW
127:                 .Height    = 46
128:                 .Top       = 17
129:                 .Left      = 10
130:                 .Caption   = loc_cCaption
131:                 .FontName  = "Tahoma"
132:                 .FontSize  = 18
133:                 .FontBold  = .T.
134:                 .BackStyle = 0
135:                 .ForeColor = RGB(255, 255, 255)
136:                 .WordWrap  = .T.
137:                 .Alignment = 0
138:             ENDWITH
139:         ENDWITH
140:         THIS.cnt_4c_Cabecalho.Visible = .T.
141:     ENDPROC
142: 
143:     *==========================================================================
144:     PROTECTED PROCEDURE ConfigurarPainelPlanilha
145:     *==========================================================================
146:         THIS.AddObject("cnt_4c_Planilha", "Container")
147:         WITH THIS.cnt_4c_Planilha
148:             .Top          = 96
149:             .Left         = 167
150:             .Width        = 466
151:             .Height       = 221
152:             .BackStyle    = 0
153:             .BorderWidth  = 0
154:             .SpecialEffect = 0
155: 
156:             *-- Label Tipo:
157:             .AddObject("lbl_4c_Say3", "Label")
158:             WITH .lbl_4c_Say3
159:                 .AutoSize  = .T.
160:                 .FontBold  = .T.
161:                 .FontName  = "Tahoma"
162:                 .FontSize  = 8
163:                 .Caption   = "Tipo:"
164:                 .Height    = 15
165:                 .Left      = 54
166:                 .Top       = 15
167:                 .Width     = 29
168:                 .BackStyle = 0
169:                 .ForeColor = RGB(90, 90, 90)
170:             ENDWITH
171: 
172:             *-- ComboBox tipos de importacao
173:             .AddObject("cbo_4c_CmbTipos", "ComboBox")
174:             WITH .cbo_4c_CmbTipos
175:                 .FontName       = "Tahoma"
176:                 .FontSize       = 8
177:                 .ColumnCount    = 1
178:                 .ColumnWidths   = "100"
179:                 .RowSourceType  = 6
180:                 .RowSource      = ""
181:                 .FirstElement   = 1
182:                 .Height         = 23
183:                 .Left           = 85
184:                 .Style          = 2

*-- Linhas 289 a 333:
289:                 .Visible   = .F.
290:             ENDWITH
291: 
292:             *-- OptionGroup tipo de validacao (Codigo / Descritivo / Referencia Forn.)
293:             .AddObject("obj_4c_OptTipo", "OptionGroup")
294:             WITH .obj_4c_OptTipo
295:                 .AutoSize    = .F.
296:                 .ButtonCount = 3
297:                 .BackStyle   = 0
298:                 .Value       = 1
299:                 .Height      = 65
300:                 .Left        = 335
301:                 .Top         = 80
302:                 .Width       = 123
303:                 .Themes      = .T.
304:                 .Visible     = .F.
305: 
306:                 WITH .Buttons(1)
307:                     .Caption   = "C" + CHR(243) + "digo"
308:                     .Height    = 15
309:                     .Left      = 5
310:                     .Top       = 5
311:                     .Width     = 51
312:                     .AutoSize  = .T.
313:                     .BackStyle = 0
314:                     .ForeColor = RGB(90, 90, 90)
315:                     .Themes    = .F.
316:                 ENDWITH
317: 
318:                 WITH .Buttons(2)
319:                     .Caption   = "Descritivo"
320:                     .Height    = 15
321:                     .Left      = 5
322:                     .Top       = 22
323:                     .Width     = 65
324:                     .AutoSize  = .T.
325:                     .BackStyle = 0
326:                     .FontName  = "Tahoma"
327:                     .FontSize  = 8
328:                     .ForeColor = RGB(90, 90, 90)
329:                     .Themes    = .F.
330:                 ENDWITH
331: 
332:                 WITH .Buttons(3)
333:                     .Caption   = "Refer" + CHR(234) + "ncia Forn."

*-- Linhas 361 a 405:
361:                 .Visible   = .F.
362:             ENDWITH
363: 
364:             *-- OptionGroup tipo de preco (Venda / Custo)
365:             .AddObject("obj_4c_OptPreco", "OptionGroup")
366:             WITH .obj_4c_OptPreco
367:                 .AutoSize    = .F.
368:                 .ButtonCount = 2
369:                 .BackStyle   = 0
370:                 .Value       = 1
371:                 .Height      = 44
372:                 .Left        = 335
373:                 .Top         = 140
374:                 .Width       = 123
375:                 .Themes      = .T.
376:                 .Visible     = .F.
377: 
378:                 WITH .Buttons(1)
379:                     .Caption   = "Venda"
380:                     .Height    = 15
381:                     .Left      = 5
382:                     .Top       = 5
383:                     .Width     = 48
384:                     .AutoSize  = .T.
385:                     .BackStyle = 0
386:                     .ForeColor = RGB(90, 90, 90)
387:                     .Themes    = .F.
388:                 ENDWITH
389: 
390:                 WITH .Buttons(2)
391:                     .Caption   = "Custo"
392:                     .Height    = 15
393:                     .Left      = 5
394:                     .Top       = 22
395:                     .Width     = 46
396:                     .AutoSize  = .T.
397:                     .BackStyle = 0
398:                     .FontName  = "Tahoma"
399:                     .FontSize  = 8
400:                     .ForeColor = RGB(90, 90, 90)
401:                     .Themes    = .F.
402:                 ENDWITH
403:             ENDWITH
404: 
405:             *-- Label Clique e Arraste para Mudar

*-- Linhas 439 a 482:
439:     ENDPROC
440: 
441:     *==========================================================================
442:     PROTECTED PROCEDURE ConfigurarBotoes
443:     *==========================================================================
444:         *-- Botao Processar (Command1 do legado: Left=650, Top=3)
445:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
446:         WITH THIS.cmd_4c_Processar
447:             .Top             = 3
448:             .Left            = 650
449:             .Width           = 75
450:             .Height          = 75
451:             .Caption         = "Processar"
452:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
453:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
454:             .Themes          = .T.
455:             .FontName        = "Tahoma"
456:             .FontSize        = 8
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .ForeColor       = RGB(90, 90, 90)
460:             .BackColor       = RGB(255, 255, 255)
461:             .WordWrap        = .T.
462:             .MousePointer    = 15
463:         ENDWITH
464: 
465:         *-- Botao Encerrar (Command2 do legado: Left=725, Top=3)
466:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
467:         WITH THIS.cmd_4c_Encerrar
468:             .Top             = 3
469:             .Left            = 725
470:             .Width           = 75
471:             .Height          = 75
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
474:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
475:             .Cancel          = .T.
476:             .Themes          = .T.
477:             .FontName        = "Tahoma"
478:             .FontSize        = 8
479:             .FontBold        = .T.
480:             .FontItalic      = .T.
481:             .ForeColor       = RGB(90, 90, 90)
482:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 492 a 558:
492:     * listbox de colunas, option groups de validacao/preco e checkbox de
493:     * cabecalho no container cnt_4c_Planilha.
494:     *==========================================================================
495:     PROTECTED PROCEDURE ConfigurarPaginaLista
496:         THIS.ConfigurarPainelPlanilha()
497:     ENDPROC
498: 
499:     *==========================================================================
500:     * ConfigurarPaginaDados - Monta a area de acoes sobre os dados de entrada
501:     * (equivalente logico da Page2 Dados do pipeline CRUD). Em Formsigprila
502:     * corresponde aos botoes que operam sobre o painel configurado por
503:     * ConfigurarPaginaLista: Processar (executa a importacao SQLEXEC/INSERT)
504:     * e Encerrar (fecha o formulario). Separado por semantica list-vs-action.
505:     *==========================================================================
506:     PROTECTED PROCEDURE ConfigurarPaginaDados
507:         THIS.ConfigurarBotoes()
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * AlternarPagina - Reinicia o fluxo de importacao para uma nova operacao.
512:     * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1"
513:     * equivale a limpar todos os campos de entrada, fechar cursores de
514:     * processamento anterior e reposicionar o foco no combo de tipos.
515:     * Chamado apos concluir uma importacao (Processar) para preparar o form
516:     * para importar outra planilha sem precisar recriar controles.
517:     *==========================================================================
518:     PROCEDURE AlternarPagina(par_nPagina)
519:         LOCAL loc_oErro
520: 
521:         TRY
522:             *-- Limpa selecao de tipo e arquivo
523:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
524:                 THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value = ""
525:             ENDIF
526:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
527:                 THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = ""
528:             ENDIF
529:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "chk_4c_Cabecalho", 5)
530:                 THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 0
531:             ENDIF
532: 
533:             *-- Limpa lista de colunas e restaura defaults dos option groups
534:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_List1", 5)
535:                 THIS.cnt_4c_Planilha.obj_4c_List1.RowSource = ""
536:                 THIS.cnt_4c_Planilha.obj_4c_List1.Clear()
537:             ENDIF
538:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptTipo", 5)
539:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = 1
540:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Visible = .F.
541:                 THIS.cnt_4c_Planilha.lbl_4c_Say5.Visible    = .F.
542:             ENDIF
543:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptPreco", 5)
544:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value  = 1
545:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Visible = .F.
546:                 THIS.cnt_4c_Planilha.lbl_4c_Say6.Visible     = .F.
547:             ENDIF
548: 
549:             *-- Descarta cursores de processamento anterior para nova importacao
550:             IF USED("TmpPlanilha")
551:                 USE IN TmpPlanilha
552:             ENDIF
553:             IF USED("csPrNAOCad")
554:                 USE IN csPrNAOCad
555:             ENDIF
556:             IF USED("csPrSemCT")
557:                 USE IN csPrSemCT
558:             ENDIF

*-- Linhas 566 a 978:
566:             ENDIF
567:         CATCH TO loc_oErro
568:             MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
569:                 " Proc=" + loc_oErro.Procedure, "Erro AlternarPagina")
570:         ENDTRY
571:     ENDPROC
572: 
573:     *==========================================================================
574:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
575:     *==========================================================================
576:         BINDEVENT(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos, "InteractiveChange", ;
577:             THIS, "CmbTiposInteractiveChange")
578:         BINDEVENT(THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp, "Click", ;
579:             THIS, "CmdgetpClick")
580:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdokClick")
581:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click",  THIS, "CmdsairClick")
582:         BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * TornarControlesVisiveis - Torna controles visiveis recursivamente.
587:     * Controles condicionais (OPT/LBL de tipo/preco) sao filtrados: ficam
588:     * com Visible=.F. e sao ativados apenas em CmbTiposInteractiveChange.
589:     *==========================================================================
590:     PROCEDURE TornarControlesVisiveis(par_oContainer)
591:         LOCAL loc_oContainer, loc_i, loc_oControl, loc_cBase, loc_cNome
592: 
593:         IF VARTYPE(par_oContainer) = "O"
594:             loc_oContainer = par_oContainer
595:         ELSE
596:             loc_oContainer = THIS
597:         ENDIF
598: 
599:         IF VARTYPE(loc_oContainer) # "O"
600:             RETURN
601:         ENDIF
602:         IF VARTYPE(loc_oContainer.ControlCount) # "N"
603:             RETURN
604:         ENDIF
605: 
606:         FOR loc_i = 1 TO loc_oContainer.ControlCount
607:             loc_oControl = loc_oContainer.Controls(loc_i)
608:             loc_cBase    = LOWER(loc_oControl.BaseClass)
609:             loc_cNome    = UPPER(loc_oControl.Name)
610: 
611:             *-- Controles condicionais ou com Visible gerenciado externamente preservam estado
612:             IF INLIST(loc_cNome, "OBJ_4C_OPTTIPO", "OBJ_4C_OPTPRECO", ;
613:                     "LBL_4C_SAY5", "LBL_4C_SAY6", "CNT_4C_CABECALHO")
614:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
615:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
616:                     THIS.TornarControlesVisiveis(loc_oControl)
617:                 ENDIF
618:                 LOOP
619:             ENDIF
620: 
621:             IF INLIST(loc_cBase, "container", "commandgroup")
622:                 THIS.TornarControlesVisiveis(loc_oControl)
623:             ENDIF
624:             loc_oControl.Visible = .T.
625:         ENDFOR
626:     ENDPROC
627: 
628:     *==========================================================================
629:     * PreencherCombo - Popula cbo_4c_CmbTipos com os tipos de importacao
630:     *==========================================================================
631:     PROCEDURE PreencherCombo()
632:         THIS.this_oBusinessObject.PreencherTipos()
633:         WITH THIS.cnt_4c_Planilha.cbo_4c_CmbTipos
634:             .RowSourceType = 6
635:             .RowSource     = "ComboTipo.Titulo"
636:         ENDWITH
637:     ENDPROC
638: 
639:     *==========================================================================
640:     * CmbTiposInteractiveChange - Atualiza lista de colunas e visibilidade
641:     *==========================================================================
642:     PROCEDURE CmbTiposInteractiveChange()
643:         LOCAL loc_cColunaLi, loc_cTitulo, loc_lVisOpt, loc_lVisPreco
644: 
645:         IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
646:             RETURN
647:         ENDIF
648: 
649:         loc_cColunaLi = THIS.this_oBusinessObject.CompletarLista("")
650:         loc_cTitulo   = ""
651:         IF USED("ComboTipo") AND !EOF("ComboTipo")
652:             loc_cTitulo = ALLTRIM(ComboTipo.Titulo)
653:         ENDIF
654:         loc_lVisOpt   = THIS.this_oBusinessObject.ObterVisibilidadeTipo(loc_cTitulo)
655:         loc_lVisPreco = THIS.this_oBusinessObject.ObterVisibilidadePreco(loc_cTitulo)
656: 
657:         WITH THIS.cnt_4c_Planilha
658:             .obj_4c_List1.RowSource = loc_cColunaLi
659:             .lbl_4c_Say5.Visible    = loc_lVisOpt
660:             .obj_4c_OptTipo.Visible = loc_lVisOpt
661:             .lbl_4c_Say6.Visible    = loc_lVisPreco
662:             .obj_4c_OptPreco.Visible = loc_lVisPreco
663:             .Visible     = .T.
664:         ENDWITH
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * CmdgetpClick - Abre dialogo para selecionar arquivo XLS
669:     *==========================================================================
670:     PROCEDURE CmdgetpClick()
671:         LOCAL loc_cArq
672:         loc_cArq = GETFILE("xls", "Planilha", "Importar")
673:         IF !EMPTY(loc_cArq)
674:             THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = loc_cArq
675:         ENDIF
676:     ENDPROC
677: 
678:     *==========================================================================
679:     * CmdokClick - Delega para BtnIncluirClick (padrao pipeline OPERACIONAL)
680:     *==========================================================================
681:     PROCEDURE CmdokClick()
682:         THIS.BtnIncluirClick()
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnIncluirClick - Executa a importacao da planilha XLS para o sistema.
687:     * Em Formsigprila "Incluir" = processar/importar os dados da planilha.
688:     * Apos importacao bem-sucedida reseta o form para nova operacao.
689:     *==========================================================================
690:     PROCEDURE BtnIncluirClick()
691:         LOCAL loc_cArquivo, loc_cRotina, loc_nTipo, loc_nPreco, loc_lCabecalho
692:         LOCAL loc_lResultado
693: 
694:         IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
695:             MsgAviso("Tipo Inv" + CHR(225) + "lido")
696:             THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
697:             RETURN
698:         ENDIF
699: 
700:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
701:         IF EMPTY(loc_cArquivo)
702:             MsgAviso("Arquivo Inv" + CHR(225) + "lido")
703:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
704:             RETURN
705:         ENDIF
706: 
707:         loc_nTipo      = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
708:         loc_nPreco     = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
709:         loc_lCabecalho = (THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 1)
710: 
711:         loc_cRotina = ""
712:         IF USED("ComboTipo") AND !EOF("ComboTipo")
713:             SELECT ComboTipo
714:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
715:         ENDIF
716: 
717:         loc_lResultado = THIS.this_oBusinessObject.Processamento( ;
718:             loc_nTipo, loc_nPreco, loc_cRotina, loc_cArquivo, ;
719:             loc_lCabecalho, THIS.cnt_4c_Planilha.obj_4c_List1)
720: 
721:         IF loc_lResultado
722:             THIS.AlternarPagina(1)
723:         ENDIF
724:     ENDPROC
725: 
726:     *==========================================================================
727:     * BtnAlterarClick - Reaproveita o fluxo de importacao (BtnIncluirClick).
728:     * Importacao e sempre substituicao/idempotente -- nao ha distincao entre
729:     * "novo" e "re-processar" para este formulario de entrada de dados.
730:     *==========================================================================
731:     PROCEDURE BtnAlterarClick()
732:         THIS.BtnIncluirClick()
733:     ENDPROC
734: 
735:     *==========================================================================
736:     * BtnVisualizarClick - Valida a configuracao sem importar dados.
737:     * Verifica tipo selecionado, existencia do arquivo e rotina reconhecida;
738:     * reposiciona foco no campo invalido ou exibe confirmacao de configuracao
739:     * valida. Semantica nao-destrutiva (nenhum dado e gravado no banco).
740:     *==========================================================================
741:     PROCEDURE BtnVisualizarClick()
742:         LOCAL loc_cArquivo, loc_cRotina, loc_cTipoSel
743: 
744:         loc_cTipoSel = ALLTRIM(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
745:         IF EMPTY(loc_cTipoSel)
746:             MsgAviso("Selecione o tipo de importa" + CHR(231) + CHR(227) + "o antes de visualizar.")
747:             THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
748:             RETURN
749:         ENDIF
750: 
751:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
752:         IF EMPTY(loc_cArquivo)
753:             MsgAviso("Selecione o arquivo de planilha antes de visualizar.")
754:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
755:             RETURN
756:         ENDIF
757: 
758:         IF !FILE(loc_cArquivo)
759:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo)
760:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
761:             RETURN
762:         ENDIF
763: 
764:         loc_cRotina = ""
765:         IF USED("ComboTipo") AND !EOF("ComboTipo")
766:             SELECT ComboTipo
767:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
768:         ENDIF
769: 
770:         IF !THIS.this_oBusinessObject.ValidarColunas(loc_cRotina)
771:             MsgAviso("Rotina '" + loc_cRotina + "' n" + CHR(227) + "o reconhecida para o tipo selecionado.")
772:             RETURN
773:         ENDIF
774: 
775:         MsgInfo("Configura" + CHR(231) + CHR(227) + "o v" + CHR(225) + "lida." + CHR(13) + ;
776:             "Tipo: " + loc_cTipoSel + CHR(13) + ;
777:             "Arquivo: " + loc_cArquivo)
778:     ENDPROC
779: 
780:     *==========================================================================
781:     * BtnExcluirClick - Descarta as selecoes atuais e reinicia o fluxo.
782:     * Semantica "excluir" = limpar tipo, arquivo e colunas para comecar nova
783:     * importacao sem fechar o formulario. Solicita confirmacao antes de limpar.
784:     *==========================================================================
785:     PROCEDURE BtnExcluirClick()
786:         IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais" + CHR(13) + ;
787:                 "e iniciar nova importa" + CHR(231) + CHR(227) + "o?")
788:             THIS.AlternarPagina(1)
789:         ENDIF
790:     ENDPROC
791: 
792:     *==========================================================================
793:     * CmdsairClick - Fecha o formulario
794:     *==========================================================================
795:     PROCEDURE CmdsairClick()
796:         THIS.Release()
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * FormKeyPress - ESC fecha o formulario
801:     *==========================================================================
802:     PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
803:         IF par_nKeyCode = 27
804:             THIS.CmdsairClick()
805:         ENDIF
806:     ENDPROC
807: 
808:     *==========================================================================
809:     * BtnBuscarClick - Abre dialogo de selecao de arquivo XLS (planilha)
810:     *==========================================================================
811:     PROCEDURE BtnBuscarClick()
812:         THIS.CmdgetpClick()
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * BtnEncerrarClick - Fecha o formulario
817:     *==========================================================================
818:     PROCEDURE BtnEncerrarClick()
819:         THIS.CmdsairClick()
820:     ENDPROC
821: 
822:     *==========================================================================
823:     * BtnSalvarClick - Executa a importacao (sinonimo de Processar)
824:     *==========================================================================
825:     PROCEDURE BtnSalvarClick()
826:         THIS.BtnIncluirClick()
827:     ENDPROC
828: 
829:     *==========================================================================
830:     * BtnCancelarClick - Cancela operacao atual e limpa os campos
831:     *==========================================================================
832:     PROCEDURE BtnCancelarClick()
833:         THIS.LimparCampos()
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * FormParaBO - Transfere estado do form para o Business Object
838:     *==========================================================================
839:     PROTECTED PROCEDURE FormParaBO()
840:         WITH THIS.this_oBusinessObject
841:             .this_nTipoImport = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
842:             .this_nTipoPreco  = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
843:         ENDWITH
844:     ENDPROC
845: 
846:     *==========================================================================
847:     * BOParaForm - Transfere estado do Business Object para o form
848:     *==========================================================================
849:     PROTECTED PROCEDURE BOParaForm()
850:         THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = THIS.this_oBusinessObject.this_nTipoImport
851:         THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value = THIS.this_oBusinessObject.this_nTipoPreco
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * HabilitarCampos - Habilita ou desabilita controles de entrada.
856:     * cmd_4c_Cmdgetp tem Caption="" (icone-only) - nao recebe .Enabled conforme
857:     * regra de standalone icon-only buttons.
858:     *==========================================================================
859:     PROCEDURE HabilitarCampos(par_lHabilitar)
860:         LOCAL loc_lHab
861:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
862: 
863:         WITH THIS.cnt_4c_Planilha
864:             .cbo_4c_CmbTipos.Enabled  = loc_lHab
865:             .chk_4c_Cabecalho.Enabled = loc_lHab
866:             .Visible     = .T.
867:         ENDWITH
868: 
869:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
870:             THIS.cmd_4c_Processar.Enabled = loc_lHab
871:         ENDIF
872:     ENDPROC
873: 
874:     *==========================================================================
875:     * LimparCampos - Limpa todos os campos de entrada e cursores temporarios
876:     *==========================================================================
877:     PROCEDURE LimparCampos()
878:         LOCAL loc_oErro
879:         TRY
880:             WITH THIS.cnt_4c_Planilha
881:                 .cbo_4c_CmbTipos.Value   = ""
882:                 .txt_4c_Planilha.Value   = ""
883:                 .chk_4c_Cabecalho.Value  = 0
884:                 .obj_4c_List1.RowSource  = ""
885:                 .obj_4c_List1.Clear()
886:                 .obj_4c_OptTipo.Value    = 1
887:                 .obj_4c_OptTipo.Visible  = .F.
888:                 .lbl_4c_Say5.Visible     = .F.
889:                 .obj_4c_OptPreco.Value   = 1
890:                 .obj_4c_OptPreco.Visible = .F.
891:                 .lbl_4c_Say6.Visible     = .F.
892:             ENDWITH
893: 
894:             IF USED("TmpPlanilha")
895:                 USE IN TmpPlanilha
896:             ENDIF
897:             IF USED("csPrNAOCad")
898:                 USE IN csPrNAOCad
899:             ENDIF
900:             IF USED("csPrSemCT")
901:                 USE IN csPrSemCT
902:             ENDIF
903:             IF USED("crNomeLista")
904:                 USE IN crNomeLista
905:             ENDIF
906: 
907:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
908:                 THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus()
909:             ENDIF
910:         CATCH TO loc_oErro
911:             MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
912:         ENDTRY
913:     ENDPROC
914: 
915:     *==========================================================================
916:     * CarregarLista - Recarrega o combo de tipos de importacao disponiveis
917:     *==========================================================================
918:     PROCEDURE CarregarLista()
919:         THIS.PreencherCombo()
920:     ENDPROC
921: 
922:     *==========================================================================
923:     * AjustarBotoesPorModo - Habilita cmd_4c_Processar somente quando tipo
924:     * e arquivo estao preenchidos. Formsigprila nao tem modos CRUD; "modo"
925:     * aqui equivale ao estado de preenchimento dos campos obrigatorios.
926:     *==========================================================================
927:     PROCEDURE AjustarBotoesPorModo()
928:         LOCAL loc_lTipoOk, loc_lArqOk
929:         loc_lTipoOk = .F.
930:         loc_lArqOk  = .F.
931: 
932:         IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
933:             loc_lTipoOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
934:         ENDIF
935:         IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
936:             loc_lArqOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
937:         ENDIF
938: 
939:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
940:             THIS.cmd_4c_Processar.Enabled = (loc_lTipoOk AND loc_lArqOk)
941:         ENDIF
942:     ENDPROC
943: 
944:     *==========================================================================
945:     PROCEDURE Destroy
946:     *==========================================================================
947:         *-- Cursores de configuracao
948:         IF USED("ComboTipo")
949:             USE IN ComboTipo
950:         ENDIF
951:         *-- Cursores de processamento de planilha
952:         IF USED("TmpPlanilha")
953:             USE IN TmpPlanilha
954:         ENDIF
955:         IF USED("TmpCot")
956:             USE IN TmpCot
957:         ENDIF
958:         *-- Cursores de moeda carregados em InicializarParametros
959:         IF USED("crSigCdMoe")
960:             USE IN crSigCdMoe
961:         ENDIF
962:         IF USED("crSigCdCot")
963:             USE IN crSigCdCot
964:         ENDIF
965:         *-- Cursores de erros de importacao
966:         IF USED("csPrNAOCad")
967:             USE IN csPrNAOCad
968:         ENDIF
969:         IF USED("csPrSemCT")
970:             USE IN csPrSemCT
971:         ENDIF
972:         IF USED("crNomeLista")
973:             USE IN crNomeLista
974:         ENDIF
975:         DODEFAULT()
976:     ENDPROC
977: 
978: ENDDEFINE

