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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (976 linhas total):

*-- Linhas 33 a 182:
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
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()
68:                 THIS.TornarControlesVisiveis()
69: 
70:                 IF !THIS.this_oBusinessObject.InicializarParametros()
71:                     MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
72:                 ENDIF
73:                 THIS.PreencherCombo()
74: 
75:                 THIS.ConfigurarBINDEVENTs()
76:                 loc_lSucesso = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro("Erro ao inicializar Formsigprila: " + loc_oErro.Message + ;
80:                 " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
81:                 " Proc=" + loc_oErro.Procedure, "Erro")
82:         ENDTRY
83: 
84:         RETURN loc_lSucesso
85:     ENDPROC
86: 
87:     *==========================================================================
88:     PROTECTED PROCEDURE ConfigurarCabecalho
89:     *==========================================================================
90:         LOCAL loc_nW, loc_cCaption
91:         loc_nW      = THIS.Width
92:         loc_cCaption = THIS.Caption
93: 
94:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH THIS.cnt_4c_Cabecalho
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = loc_nW
99:             .Height      = 80
100:             .BackStyle   = 1
101:             .BackColor   = RGB(100, 100, 100)
102:             .BorderWidth = 0
103: 
104:             .AddObject("lbl_4c_Sombra", "Label")
105:             WITH .lbl_4c_Sombra
106:                 .AutoSize  = .F.
107:                 .Width     = loc_nW
108:                 .Height    = 40
109:                 .Top       = 18
110:                 .Left      = 10
111:                 .Caption   = loc_cCaption
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 18
114:                 .FontBold  = .T.
115:                 .BackStyle = 0
116:                 .ForeColor = RGB(0, 0, 0)
117:                 .WordWrap  = .T.
118:                 .Alignment = 0
119:             ENDWITH
120: 
121:             .AddObject("lbl_4c_Titulo", "Label")
122:             WITH .lbl_4c_Titulo
123:                 .AutoSize  = .F.
124:                 .Width     = loc_nW
125:                 .Height    = 46
126:                 .Top       = 17
127:                 .Left      = 10
128:                 .Caption   = loc_cCaption
129:                 .FontName  = "Tahoma"
130:                 .FontSize  = 18
131:                 .FontBold  = .T.
132:                 .BackStyle = 0
133:                 .ForeColor = RGB(255, 255, 255)
134:                 .WordWrap  = .T.
135:                 .Alignment = 0
136:             ENDWITH
137:         ENDWITH
138:         THIS.cnt_4c_Cabecalho.Visible = .T.
139:     ENDPROC
140: 
141:     *==========================================================================
142:     PROTECTED PROCEDURE ConfigurarPainelPlanilha
143:     *==========================================================================
144:         THIS.AddObject("cnt_4c_Planilha", "Container")
145:         WITH THIS.cnt_4c_Planilha
146:             .Top          = 96
147:             .Left         = 167
148:             .Width        = 466
149:             .Height       = 221
150:             .BackStyle    = 0
151:             .BorderWidth  = 0
152:             .SpecialEffect = 0
153: 
154:             *-- Label Tipo:
155:             .AddObject("lbl_4c_Say3", "Label")
156:             WITH .lbl_4c_Say3
157:                 .AutoSize  = .T.
158:                 .FontBold  = .T.
159:                 .FontName  = "Tahoma"
160:                 .FontSize  = 8
161:                 .Caption   = "Tipo:"
162:                 .Height    = 15
163:                 .Left      = 54
164:                 .Top       = 15
165:                 .Width     = 29
166:                 .BackStyle = 0
167:                 .ForeColor = RGB(90, 90, 90)
168:             ENDWITH
169: 
170:             *-- ComboBox tipos de importacao
171:             .AddObject("cbo_4c_CmbTipos", "ComboBox")
172:             WITH .cbo_4c_CmbTipos
173:                 .FontName       = "Tahoma"
174:                 .FontSize       = 8
175:                 .ColumnCount    = 1
176:                 .ColumnWidths   = "100"
177:                 .RowSourceType  = 6
178:                 .RowSource      = ""
179:                 .FirstElement   = 1
180:                 .Height         = 23
181:                 .Left           = 85
182:                 .Style          = 2

*-- Linhas 287 a 331:
287:                 .Visible   = .F.
288:             ENDWITH
289: 
290:             *-- OptionGroup tipo de validacao (Codigo / Descritivo / Referencia Forn.)
291:             .AddObject("obj_4c_OptTipo", "OptionGroup")
292:             WITH .obj_4c_OptTipo
293:                 .AutoSize    = .F.
294:                 .ButtonCount = 3
295:                 .BackStyle   = 0
296:                 .Value       = 1
297:                 .Height      = 65
298:                 .Left        = 335
299:                 .Top         = 80
300:                 .Width       = 123
301:                 .Themes      = .T.
302:                 .Visible     = .F.
303: 
304:                 WITH .Buttons(1)
305:                     .Caption   = "C" + CHR(243) + "digo"
306:                     .Height    = 15
307:                     .Left      = 5
308:                     .Top       = 5
309:                     .Width     = 51
310:                     .AutoSize  = .T.
311:                     .BackStyle = 0
312:                     .ForeColor = RGB(90, 90, 90)
313:                     .Themes    = .F.
314:                 ENDWITH
315: 
316:                 WITH .Buttons(2)
317:                     .Caption   = "Descritivo"
318:                     .Height    = 15
319:                     .Left      = 5
320:                     .Top       = 22
321:                     .Width     = 65
322:                     .AutoSize  = .T.
323:                     .BackStyle = 0
324:                     .FontName  = "Tahoma"
325:                     .FontSize  = 8
326:                     .ForeColor = RGB(90, 90, 90)
327:                     .Themes    = .F.
328:                 ENDWITH
329: 
330:                 WITH .Buttons(3)
331:                     .Caption   = "Refer" + CHR(234) + "ncia Forn."

*-- Linhas 359 a 403:
359:                 .Visible   = .F.
360:             ENDWITH
361: 
362:             *-- OptionGroup tipo de preco (Venda / Custo)
363:             .AddObject("obj_4c_OptPreco", "OptionGroup")
364:             WITH .obj_4c_OptPreco
365:                 .AutoSize    = .F.
366:                 .ButtonCount = 2
367:                 .BackStyle   = 0
368:                 .Value       = 1
369:                 .Height      = 44
370:                 .Left        = 335
371:                 .Top         = 140
372:                 .Width       = 123
373:                 .Themes      = .T.
374:                 .Visible     = .F.
375: 
376:                 WITH .Buttons(1)
377:                     .Caption   = "Venda"
378:                     .Height    = 15
379:                     .Left      = 5
380:                     .Top       = 5
381:                     .Width     = 48
382:                     .AutoSize  = .T.
383:                     .BackStyle = 0
384:                     .ForeColor = RGB(90, 90, 90)
385:                     .Themes    = .F.
386:                 ENDWITH
387: 
388:                 WITH .Buttons(2)
389:                     .Caption   = "Custo"
390:                     .Height    = 15
391:                     .Left      = 5
392:                     .Top       = 22
393:                     .Width     = 46
394:                     .AutoSize  = .T.
395:                     .BackStyle = 0
396:                     .FontName  = "Tahoma"
397:                     .FontSize  = 8
398:                     .ForeColor = RGB(90, 90, 90)
399:                     .Themes    = .F.
400:                 ENDWITH
401:             ENDWITH
402: 
403:             *-- Label Clique e Arraste para Mudar

*-- Linhas 437 a 480:
437:     ENDPROC
438: 
439:     *==========================================================================
440:     PROTECTED PROCEDURE ConfigurarBotoes
441:     *==========================================================================
442:         *-- Botao Processar (Command1 do legado: Left=650, Top=3)
443:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
444:         WITH THIS.cmd_4c_Processar
445:             .Top             = 3
446:             .Left            = 650
447:             .Width           = 75
448:             .Height          = 75
449:             .Caption         = "Processar"
450:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
451:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
452:             .Themes          = .T.
453:             .FontName        = "Comic Sans MS"
454:             .FontSize        = 8
455:             .FontBold        = .T.
456:             .FontItalic      = .T.
457:             .ForeColor       = RGB(90, 90, 90)
458:             .BackColor       = RGB(255, 255, 255)
459:             .WordWrap        = .T.
460:             .MousePointer    = 15
461:         ENDWITH
462: 
463:         *-- Botao Encerrar (Command2 do legado: Left=725, Top=3)
464:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
465:         WITH THIS.cmd_4c_Encerrar
466:             .Top             = 3
467:             .Left            = 725
468:             .Width           = 75
469:             .Height          = 75
470:             .Caption         = "Encerrar"
471:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
472:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
473:             .Cancel          = .T.
474:             .Themes          = .T.
475:             .FontName        = "Comic Sans MS"
476:             .FontSize        = 8
477:             .FontBold        = .T.
478:             .FontItalic      = .T.
479:             .ForeColor       = RGB(90, 90, 90)
480:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 490 a 556:
490:     * listbox de colunas, option groups de validacao/preco e checkbox de
491:     * cabecalho no container cnt_4c_Planilha.
492:     *==========================================================================
493:     PROTECTED PROCEDURE ConfigurarPaginaLista
494:         THIS.ConfigurarPainelPlanilha()
495:     ENDPROC
496: 
497:     *==========================================================================
498:     * ConfigurarPaginaDados - Monta a area de acoes sobre os dados de entrada
499:     * (equivalente logico da Page2 Dados do pipeline CRUD). Em Formsigprila
500:     * corresponde aos botoes que operam sobre o painel configurado por
501:     * ConfigurarPaginaLista: Processar (executa a importacao SQLEXEC/INSERT)
502:     * e Encerrar (fecha o formulario). Separado por semantica list-vs-action.
503:     *==========================================================================
504:     PROTECTED PROCEDURE ConfigurarPaginaDados
505:         THIS.ConfigurarBotoes()
506:     ENDPROC
507: 
508:     *==========================================================================
509:     * AlternarPagina - Reinicia o fluxo de importacao para uma nova operacao.
510:     * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1"
511:     * equivale a limpar todos os campos de entrada, fechar cursores de
512:     * processamento anterior e reposicionar o foco no combo de tipos.
513:     * Chamado apos concluir uma importacao (Processar) para preparar o form
514:     * para importar outra planilha sem precisar recriar controles.
515:     *==========================================================================
516:     PROCEDURE AlternarPagina(par_nPagina)
517:         LOCAL loc_oErro
518: 
519:         TRY
520:             *-- Limpa selecao de tipo e arquivo
521:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
522:                 THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value = ""
523:             ENDIF
524:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
525:                 THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = ""
526:             ENDIF
527:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "chk_4c_Cabecalho", 5)
528:                 THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 0
529:             ENDIF
530: 
531:             *-- Limpa lista de colunas e restaura defaults dos option groups
532:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_List1", 5)
533:                 THIS.cnt_4c_Planilha.obj_4c_List1.RowSource = ""
534:                 THIS.cnt_4c_Planilha.obj_4c_List1.Clear()
535:             ENDIF
536:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptTipo", 5)
537:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = 1
538:                 THIS.cnt_4c_Planilha.obj_4c_OptTipo.Visible = .F.
539:                 THIS.cnt_4c_Planilha.lbl_4c_Say5.Visible    = .F.
540:             ENDIF
541:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "obj_4c_OptPreco", 5)
542:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value  = 1
543:                 THIS.cnt_4c_Planilha.obj_4c_OptPreco.Visible = .F.
544:                 THIS.cnt_4c_Planilha.lbl_4c_Say6.Visible     = .F.
545:             ENDIF
546: 
547:             *-- Descarta cursores de processamento anterior para nova importacao
548:             IF USED("TmpPlanilha")
549:                 USE IN TmpPlanilha
550:             ENDIF
551:             IF USED("csPrNAOCad")
552:                 USE IN csPrNAOCad
553:             ENDIF
554:             IF USED("csPrSemCT")
555:                 USE IN csPrSemCT
556:             ENDIF

*-- Linhas 564 a 976:
564:             ENDIF
565:         CATCH TO loc_oErro
566:             MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
567:                 " Proc=" + loc_oErro.Procedure, "Erro AlternarPagina")
568:         ENDTRY
569:     ENDPROC
570: 
571:     *==========================================================================
572:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
573:     *==========================================================================
574:         BINDEVENT(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos, "InteractiveChange", ;
575:             THIS, "CmbTiposInteractiveChange")
576:         BINDEVENT(THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp, "Click", ;
577:             THIS, "CmdgetpClick")
578:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdokClick")
579:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click",  THIS, "CmdsairClick")
580:         BINDEVENT(THIS, "KeyPress", THIS, "FormKeyPress")
581:     ENDPROC
582: 
583:     *==========================================================================
584:     * TornarControlesVisiveis - Torna controles visiveis recursivamente.
585:     * Controles condicionais (OPT/LBL de tipo/preco) sao filtrados: ficam
586:     * com Visible=.F. e sao ativados apenas em CmbTiposInteractiveChange.
587:     *==========================================================================
588:     PROCEDURE TornarControlesVisiveis(par_oContainer)
589:         LOCAL loc_oContainer, loc_i, loc_oControl, loc_cBase, loc_cNome
590: 
591:         IF VARTYPE(par_oContainer) = "O"
592:             loc_oContainer = par_oContainer
593:         ELSE
594:             loc_oContainer = THIS
595:         ENDIF
596: 
597:         IF VARTYPE(loc_oContainer) # "O"
598:             RETURN
599:         ENDIF
600:         IF VARTYPE(loc_oContainer.ControlCount) # "N"
601:             RETURN
602:         ENDIF
603: 
604:         FOR loc_i = 1 TO loc_oContainer.ControlCount
605:             loc_oControl = loc_oContainer.Controls(loc_i)
606:             loc_cBase    = LOWER(loc_oControl.BaseClass)
607:             loc_cNome    = UPPER(loc_oControl.Name)
608: 
609:             *-- Controles condicionais permanecem ocultos ate tipo ser selecionado
610:             IF INLIST(loc_cNome, "OBJ_4C_OPTTIPO", "OBJ_4C_OPTPRECO", ;
611:                     "LBL_4C_SAY5", "LBL_4C_SAY6")
612:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
613:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
614:                     THIS.TornarControlesVisiveis(loc_oControl)
615:                 ENDIF
616:                 LOOP
617:             ENDIF
618: 
619:             IF INLIST(loc_cBase, "container", "commandgroup")
620:                 THIS.TornarControlesVisiveis(loc_oControl)
621:             ENDIF
622:             loc_oControl.Visible = .T.
623:         ENDFOR
624:     ENDPROC
625: 
626:     *==========================================================================
627:     * PreencherCombo - Popula cbo_4c_CmbTipos com os tipos de importacao
628:     *==========================================================================
629:     PROCEDURE PreencherCombo()
630:         THIS.this_oBusinessObject.PreencherTipos()
631:         WITH THIS.cnt_4c_Planilha.cbo_4c_CmbTipos
632:             .RowSourceType = 6
633:             .RowSource     = "ComboTipo.Titulo"
634:         ENDWITH
635:     ENDPROC
636: 
637:     *==========================================================================
638:     * CmbTiposInteractiveChange - Atualiza lista de colunas e visibilidade
639:     *==========================================================================
640:     PROCEDURE CmbTiposInteractiveChange()
641:         LOCAL loc_cColunaLi, loc_cTitulo, loc_lVisOpt, loc_lVisPreco
642: 
643:         IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
644:             RETURN
645:         ENDIF
646: 
647:         loc_cColunaLi = THIS.this_oBusinessObject.CompletarLista("")
648:         loc_cTitulo   = ""
649:         IF USED("ComboTipo") AND !EOF("ComboTipo")
650:             loc_cTitulo = ALLTRIM(ComboTipo.Titulo)
651:         ENDIF
652:         loc_lVisOpt   = THIS.this_oBusinessObject.ObterVisibilidadeTipo(loc_cTitulo)
653:         loc_lVisPreco = THIS.this_oBusinessObject.ObterVisibilidadePreco(loc_cTitulo)
654: 
655:         WITH THIS.cnt_4c_Planilha
656:             .obj_4c_List1.RowSource = loc_cColunaLi
657:             .lbl_4c_Say5.Visible    = loc_lVisOpt
658:             .obj_4c_OptTipo.Visible = loc_lVisOpt
659:             .lbl_4c_Say6.Visible    = loc_lVisPreco
660:             .obj_4c_OptPreco.Visible = loc_lVisPreco
661:             .Visible     = .T.
662:         ENDWITH
663:     ENDPROC
664: 
665:     *==========================================================================
666:     * CmdgetpClick - Abre dialogo para selecionar arquivo XLS
667:     *==========================================================================
668:     PROCEDURE CmdgetpClick()
669:         LOCAL loc_cArq
670:         loc_cArq = GETFILE("xls", "Planilha", "Importar")
671:         IF !EMPTY(loc_cArq)
672:             THIS.cnt_4c_Planilha.txt_4c_Planilha.Value = loc_cArq
673:         ENDIF
674:     ENDPROC
675: 
676:     *==========================================================================
677:     * CmdokClick - Delega para BtnIncluirClick (padrao pipeline OPERACIONAL)
678:     *==========================================================================
679:     PROCEDURE CmdokClick()
680:         THIS.BtnIncluirClick()
681:     ENDPROC
682: 
683:     *==========================================================================
684:     * BtnIncluirClick - Executa a importacao da planilha XLS para o sistema.
685:     * Em Formsigprila "Incluir" = processar/importar os dados da planilha.
686:     * Apos importacao bem-sucedida reseta o form para nova operacao.
687:     *==========================================================================
688:     PROCEDURE BtnIncluirClick()
689:         LOCAL loc_cArquivo, loc_cRotina, loc_nTipo, loc_nPreco, loc_lCabecalho
690:         LOCAL loc_lResultado
691: 
692:         IF EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
693:             MsgAviso("Tipo Inv" + CHR(225) + "lido")
694:             THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
695:             RETURN
696:         ENDIF
697: 
698:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
699:         IF EMPTY(loc_cArquivo)
700:             MsgAviso("Arquivo Inv" + CHR(225) + "lido")
701:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
702:             RETURN
703:         ENDIF
704: 
705:         loc_nTipo      = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
706:         loc_nPreco     = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
707:         loc_lCabecalho = (THIS.cnt_4c_Planilha.chk_4c_Cabecalho.Value = 1)
708: 
709:         loc_cRotina = ""
710:         IF USED("ComboTipo") AND !EOF("ComboTipo")
711:             SELECT ComboTipo
712:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
713:         ENDIF
714: 
715:         loc_lResultado = THIS.this_oBusinessObject.Processamento( ;
716:             loc_nTipo, loc_nPreco, loc_cRotina, loc_cArquivo, ;
717:             loc_lCabecalho, THIS.cnt_4c_Planilha.obj_4c_List1)
718: 
719:         IF loc_lResultado
720:             THIS.AlternarPagina(1)
721:         ENDIF
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * BtnAlterarClick - Reaproveita o fluxo de importacao (BtnIncluirClick).
726:     * Importacao e sempre substituicao/idempotente -- nao ha distincao entre
727:     * "novo" e "re-processar" para este formulario de entrada de dados.
728:     *==========================================================================
729:     PROCEDURE BtnAlterarClick()
730:         THIS.BtnIncluirClick()
731:     ENDPROC
732: 
733:     *==========================================================================
734:     * BtnVisualizarClick - Valida a configuracao sem importar dados.
735:     * Verifica tipo selecionado, existencia do arquivo e rotina reconhecida;
736:     * reposiciona foco no campo invalido ou exibe confirmacao de configuracao
737:     * valida. Semantica nao-destrutiva (nenhum dado e gravado no banco).
738:     *==========================================================================
739:     PROCEDURE BtnVisualizarClick()
740:         LOCAL loc_cArquivo, loc_cRotina, loc_cTipoSel
741: 
742:         loc_cTipoSel = ALLTRIM(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
743:         IF EMPTY(loc_cTipoSel)
744:             MsgAviso("Selecione o tipo de importa" + CHR(231) + CHR(227) + "o antes de visualizar.")
745:             THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus
746:             RETURN
747:         ENDIF
748: 
749:         loc_cArquivo = ALLTRIM(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
750:         IF EMPTY(loc_cArquivo)
751:             MsgAviso("Selecione o arquivo de planilha antes de visualizar.")
752:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
753:             RETURN
754:         ENDIF
755: 
756:         IF !FILE(loc_cArquivo)
757:             MsgAviso("Arquivo n" + CHR(227) + "o encontrado:" + CHR(13) + loc_cArquivo)
758:             THIS.cnt_4c_Planilha.cmd_4c_Cmdgetp.SetFocus
759:             RETURN
760:         ENDIF
761: 
762:         loc_cRotina = ""
763:         IF USED("ComboTipo") AND !EOF("ComboTipo")
764:             SELECT ComboTipo
765:             loc_cRotina = ALLTRIM(ComboTipo.Rotina)
766:         ENDIF
767: 
768:         IF !THIS.this_oBusinessObject.ValidarColunas(loc_cRotina)
769:             MsgAviso("Rotina '" + loc_cRotina + "' n" + CHR(227) + "o reconhecida para o tipo selecionado.")
770:             RETURN
771:         ENDIF
772: 
773:         MsgInfo("Configura" + CHR(231) + CHR(227) + "o v" + CHR(225) + "lida." + CHR(13) + ;
774:             "Tipo: " + loc_cTipoSel + CHR(13) + ;
775:             "Arquivo: " + loc_cArquivo)
776:     ENDPROC
777: 
778:     *==========================================================================
779:     * BtnExcluirClick - Descarta as selecoes atuais e reinicia o fluxo.
780:     * Semantica "excluir" = limpar tipo, arquivo e colunas para comecar nova
781:     * importacao sem fechar o formulario. Solicita confirmacao antes de limpar.
782:     *==========================================================================
783:     PROCEDURE BtnExcluirClick()
784:         IF MsgConfirma("Deseja limpar as sele" + CHR(231) + CHR(245) + "es atuais" + CHR(13) + ;
785:                 "e iniciar nova importa" + CHR(231) + CHR(227) + "o?")
786:             THIS.AlternarPagina(1)
787:         ENDIF
788:     ENDPROC
789: 
790:     *==========================================================================
791:     * CmdsairClick - Fecha o formulario
792:     *==========================================================================
793:     PROCEDURE CmdsairClick()
794:         THIS.Release()
795:     ENDPROC
796: 
797:     *==========================================================================
798:     * FormKeyPress - ESC fecha o formulario
799:     *==========================================================================
800:     PROCEDURE FormKeyPress(par_nKeyCode, par_nShiftAltCtrl)
801:         IF par_nKeyCode = 27
802:             THIS.CmdsairClick()
803:         ENDIF
804:     ENDPROC
805: 
806:     *==========================================================================
807:     * BtnBuscarClick - Abre dialogo de selecao de arquivo XLS (planilha)
808:     *==========================================================================
809:     PROCEDURE BtnBuscarClick()
810:         THIS.CmdgetpClick()
811:     ENDPROC
812: 
813:     *==========================================================================
814:     * BtnEncerrarClick - Fecha o formulario
815:     *==========================================================================
816:     PROCEDURE BtnEncerrarClick()
817:         THIS.CmdsairClick()
818:     ENDPROC
819: 
820:     *==========================================================================
821:     * BtnSalvarClick - Executa a importacao (sinonimo de Processar)
822:     *==========================================================================
823:     PROCEDURE BtnSalvarClick()
824:         THIS.BtnIncluirClick()
825:     ENDPROC
826: 
827:     *==========================================================================
828:     * BtnCancelarClick - Cancela operacao atual e limpa os campos
829:     *==========================================================================
830:     PROCEDURE BtnCancelarClick()
831:         THIS.LimparCampos()
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * FormParaBO - Transfere estado do form para o Business Object
836:     *==========================================================================
837:     PROTECTED PROCEDURE FormParaBO()
838:         WITH THIS.this_oBusinessObject
839:             .this_nTipoImport = THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value
840:             .this_nTipoPreco  = THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value
841:         ENDWITH
842:     ENDPROC
843: 
844:     *==========================================================================
845:     * BOParaForm - Transfere estado do Business Object para o form
846:     *==========================================================================
847:     PROTECTED PROCEDURE BOParaForm()
848:         THIS.cnt_4c_Planilha.obj_4c_OptTipo.Value  = THIS.this_oBusinessObject.this_nTipoImport
849:         THIS.cnt_4c_Planilha.obj_4c_OptPreco.Value = THIS.this_oBusinessObject.this_nTipoPreco
850:     ENDPROC
851: 
852:     *==========================================================================
853:     * HabilitarCampos - Habilita ou desabilita controles de entrada.
854:     * cmd_4c_Cmdgetp tem Caption="" (icone-only) - nao recebe .Enabled conforme
855:     * regra de standalone icon-only buttons.
856:     *==========================================================================
857:     PROCEDURE HabilitarCampos(par_lHabilitar)
858:         LOCAL loc_lHab
859:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
860: 
861:         WITH THIS.cnt_4c_Planilha
862:             .cbo_4c_CmbTipos.Enabled  = loc_lHab
863:             .chk_4c_Cabecalho.Enabled = loc_lHab
864:             .Visible     = .T.
865:         ENDWITH
866: 
867:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
868:             THIS.cmd_4c_Processar.Enabled = loc_lHab
869:         ENDIF
870:     ENDPROC
871: 
872:     *==========================================================================
873:     * LimparCampos - Limpa todos os campos de entrada e cursores temporarios
874:     *==========================================================================
875:     PROCEDURE LimparCampos()
876:         LOCAL loc_oErro
877:         TRY
878:             WITH THIS.cnt_4c_Planilha
879:                 .cbo_4c_CmbTipos.Value   = ""
880:                 .txt_4c_Planilha.Value   = ""
881:                 .chk_4c_Cabecalho.Value  = 0
882:                 .obj_4c_List1.RowSource  = ""
883:                 .obj_4c_List1.Clear()
884:                 .obj_4c_OptTipo.Value    = 1
885:                 .obj_4c_OptTipo.Visible  = .F.
886:                 .lbl_4c_Say5.Visible     = .F.
887:                 .obj_4c_OptPreco.Value   = 1
888:                 .obj_4c_OptPreco.Visible = .F.
889:                 .lbl_4c_Say6.Visible     = .F.
890:             ENDWITH
891: 
892:             IF USED("TmpPlanilha")
893:                 USE IN TmpPlanilha
894:             ENDIF
895:             IF USED("csPrNAOCad")
896:                 USE IN csPrNAOCad
897:             ENDIF
898:             IF USED("csPrSemCT")
899:                 USE IN csPrSemCT
900:             ENDIF
901:             IF USED("crNomeLista")
902:                 USE IN crNomeLista
903:             ENDIF
904: 
905:             IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
906:                 THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.SetFocus()
907:             ENDIF
908:         CATCH TO loc_oErro
909:             MsgErro(loc_oErro.Message + " Ln=" + TRANSFORM(loc_oErro.LineNo), "Erro LimparCampos")
910:         ENDTRY
911:     ENDPROC
912: 
913:     *==========================================================================
914:     * CarregarLista - Recarrega o combo de tipos de importacao disponiveis
915:     *==========================================================================
916:     PROCEDURE CarregarLista()
917:         THIS.PreencherCombo()
918:     ENDPROC
919: 
920:     *==========================================================================
921:     * AjustarBotoesPorModo - Habilita cmd_4c_Processar somente quando tipo
922:     * e arquivo estao preenchidos. Formsigprila nao tem modos CRUD; "modo"
923:     * aqui equivale ao estado de preenchimento dos campos obrigatorios.
924:     *==========================================================================
925:     PROCEDURE AjustarBotoesPorModo()
926:         LOCAL loc_lTipoOk, loc_lArqOk
927:         loc_lTipoOk = .F.
928:         loc_lArqOk  = .F.
929: 
930:         IF PEMSTATUS(THIS.cnt_4c_Planilha, "cbo_4c_CmbTipos", 5)
931:             loc_lTipoOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.cbo_4c_CmbTipos.Value, ""))
932:         ENDIF
933:         IF PEMSTATUS(THIS.cnt_4c_Planilha, "txt_4c_Planilha", 5)
934:             loc_lArqOk = !EMPTY(NVL(THIS.cnt_4c_Planilha.txt_4c_Planilha.Value, ""))
935:         ENDIF
936: 
937:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
938:             THIS.cmd_4c_Processar.Enabled = (loc_lTipoOk AND loc_lArqOk)
939:         ENDIF
940:     ENDPROC
941: 
942:     *==========================================================================
943:     PROCEDURE Destroy
944:     *==========================================================================
945:         *-- Cursores de configuracao
946:         IF USED("ComboTipo")
947:             USE IN ComboTipo
948:         ENDIF
949:         *-- Cursores de processamento de planilha
950:         IF USED("TmpPlanilha")
951:             USE IN TmpPlanilha
952:         ENDIF
953:         IF USED("TmpCot")
954:             USE IN TmpCot
955:         ENDIF
956:         *-- Cursores de moeda carregados em InicializarParametros
957:         IF USED("crSigCdMoe")
958:             USE IN crSigCdMoe
959:         ENDIF
960:         IF USED("crSigCdCot")
961:             USE IN crSigCdCot
962:         ENDIF
963:         *-- Cursores de erros de importacao
964:         IF USED("csPrNAOCad")
965:             USE IN csPrNAOCad
966:         ENDIF
967:         IF USED("csPrSemCT")
968:             USE IN csPrSemCT
969:         ENDIF
970:         IF USED("crNomeLista")
971:             USE IN crNomeLista
972:         ENDIF
973:         DODEFAULT()
974:     ENDPROC
975: 
976: ENDDEFINE

