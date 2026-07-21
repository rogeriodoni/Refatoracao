# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (925 linhas total):

*-- Linhas 30 a 120:
30:     this_nOrdemGrade = 2
31: 
32:     *==========================================================================
33:     PROCEDURE Init
34:     *==========================================================================
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *==========================================================================
39:     PROTECTED PROCEDURE InicializarForm
40:     *==========================================================================
41:         LOCAL loc_lSucesso, loc_oErro
42:         loc_lSucesso = .F.
43: 
44:         TRY
45:             THIS.Caption = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
46: 
47:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
48:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
49:             ENDIF
50: 
51:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMluBO")
52:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
53:                 MsgErro("Falha ao criar SigPrMluBO", "Erro")
54:             ELSE
55:                 THIS.ConfigurarCabecalho()
56:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58:                 THIS.ConfigurarBotoes()
59:                 THIS.ConfigurarCntNova()
60:                 THIS.ConfigurarGrade()
61:                 THIS.ConfigurarBtnGrade()
62:                 THIS.ConfigurarBINDEVENTs()
63:                 THIS.TornarControlesVisiveis()
64: 
65:                 THIS.this_oBusinessObject.BuscarMalas()
66:                 THIS.MontarGrade()
67: 
68:                 loc_lSucesso = .T.
69:             ENDIF
70: 
71:         CATCH TO loc_oErro
72:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
73:                     " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *==========================================================================
80:     PROTECTED PROCEDURE ConfigurarCabecalho
81:     *==========================================================================
82:         LOCAL loc_oCab
83:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
84:         loc_oCab = THIS.cnt_4c_Cabecalho
85:         WITH loc_oCab
86:             .Top         = 0
87:             .Left        = 0
88:             .Width       = 1020
89:             .Height      = 80
90:             .BorderWidth = 0
91:             .BackStyle   = 1
92:             .BackColor   = RGB(100, 100, 100)
93:         ENDWITH
94:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
95:         WITH loc_oCab.lbl_4c_Sombra
96:             .AutoSize      = .F.
97:             .Top           = 18
98:             .Left          = 10
99:             .Width         = 1000
100:             .Height        = 40
101:             .FontBold      = .T.
102:             .FontName      = "Tahoma"
103:             .FontSize      = 18
104:             .FontUnderline = .F.
105:             .WordWrap      = .T.
106:             .Alignment     = 0
107:             .BackStyle     = 0
108:             .ForeColor     = RGB(0, 0, 0)
109:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
110:         ENDWITH
111:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
112:         WITH loc_oCab.lbl_4c_Titulo
113:             .AutoSize      = .F.
114:             .Top           = 17
115:             .Left          = 10
116:             .Width         = 1000
117:             .Height        = 46
118:             .FontBold      = .T.
119:             .FontName      = "Tahoma"
120:             .FontSize      = 18

*-- Linhas 128 a 171:
128:     ENDPROC
129: 
130:     *==========================================================================
131:     PROTECTED PROCEDURE ConfigurarBotoes
132:     *==========================================================================
133:         LOCAL loc_oCnt
134:         *-- Botao Processar (standalone com icone 60px, Themes=.T. + DisabledPicture obrigatorios)
135:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
136:         WITH THIS.cmd_4c_Processar
137:             .Top             = 5
138:             .Left            = 828
139:             .Height          = 75
140:             .Width           = 75
141:             .FontBold        = .T.
142:             .FontItalic      = .T.
143:             .FontName        = "Tahoma"
144:             .FontSize        = 8
145:             .WordWrap        = .T.
146:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
147:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
148:             .Caption         = "\<Processar"
149:             .ToolTipText     = "[Alt+P] Processar Unifica" + CHR(231) + CHR(227) + "o"
150:             .ForeColor       = RGB(90, 90, 90)
151:             .BackColor       = RGB(255, 255, 255)
152:             .Themes          = .T.
153:         ENDWITH
154: 
155:         *-- Container canonico Encerrar (Left=917, Width=90, Height=85)
156:         THIS.AddObject("cnt_4c_Saida", "Container")
157:         loc_oCnt = THIS.cnt_4c_Saida
158:         WITH loc_oCnt
159:             .Top         = -2
160:             .Left        = 917
161:             .Width       = 90
162:             .Height      = 85
163:             .BorderWidth = 0
164:             .BackStyle   = 0
165:         ENDWITH
166:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
167:         WITH loc_oCnt.cmd_4c_Encerrar
168:             .Top         = 5
169:             .Left        = 5
170:             .Height      = 75
171:             .Width       = 75

*-- Linhas 185 a 273:
185:     ENDPROC
186: 
187:     *==========================================================================
188:     PROTECTED PROCEDURE ConfigurarCntNova
189:     *-- Container com campo "Nome da Unificacao" (cntNova do legado)
190:     *==========================================================================
191:         LOCAL loc_oCnt
192:         THIS.AddObject("cnt_4c_Nova", "Container")
193:         loc_oCnt = THIS.cnt_4c_Nova
194:         WITH loc_oCnt
195:             .Top         = 92
196:             .Left        = 15
197:             .Width       = 800
198:             .Height      = 42
199:             .BackStyle   = 0
200:             .BorderWidth = 0
201:         ENDWITH
202:         loc_oCnt.AddObject("lbl_4c_Nome", "Label")
203:         WITH loc_oCnt.lbl_4c_Nome
204:             .AutoSize  = .T.
205:             .FontBold  = .T.
206:             .FontName  = "Tahoma"
207:             .FontSize  = 8
208:             .BackStyle = 0
209:             .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
210:             .Height    = 15
211:             .Left      = 20
212:             .Top       = 13
213:             .ForeColor = RGB(90, 90, 90)
214:         ENDWITH
215:         loc_oCnt.AddObject("txt_4c_GetNova", "TextBox")
216:         WITH loc_oCnt.txt_4c_GetNova
217:             .FontName          = "Courier New"
218:             .FontSize          = 9
219:             .Format            = "K"
220:             .Height            = 25
221:             .Left              = 155
222:             .MaxLength         = 20
223:             .TabIndex          = 1
224:             .Top               = 8
225:             .Width             = 220
226:             .DisabledBackColor = RGB(255, 255, 255)
227:             .DisabledForeColor = RGB(0, 0, 128)
228:             .Value             = ""
229:         ENDWITH
230:     ENDPROC
231: 
232:     *==========================================================================
233:     PROTECTED PROCEDURE ConfigurarGrade
234:     *-- Grid grd_4c_Selecoes: 6 colunas (Check, Codigo, Descricao, Usuario,
235:     *-- Dt.Entrada, N.Registros) ? espelho do grdSelecoes do legado
236:     *==========================================================================
237:         THIS.AddObject("grd_4c_Selecoes", "Grid")
238:         WITH THIS.grd_4c_Selecoes
239:             .Top                = 140
240:             .Left               = 15
241:             .Width              = 870
242:             .Height             = 420
243:             .RecordMark         = .F.
244:             .DeleteMark         = .F.
245:             .RowHeight          = 16
246:             .HeaderHeight       = 16
247:             .AllowHeaderSizing  = .F.
248:             .AllowRowSizing     = .F.
249:             .ReadOnly           = .F.
250:             .ScrollBars         = 2
251:             .FontName           = "Tahoma"
252:             .FontSize           = 8
253:             .GridLineColor      = RGB(238, 238, 238)
254:             .ColumnCount        = 6
255: 
256:             *-- Column1: CheckBox de selecao (SelImp)
257:             WITH .Column1
258:                 .ColumnOrder   = 1
259:                 .Width         = 20
260:                 .Movable       = .F.
261:                 .Resizable     = .F.
262:                 .ReadOnly      = .F.
263:                 WITH .Header1
264:                     .Caption   = ""
265:                     .Alignment = 2
266:                     .FontName  = "Tahoma"
267:                     .FontSize  = 8
268:                     .ForeColor = RGB(36, 84, 155)
269:                 ENDWITH
270:                 .AddObject("ctlCheck1", "CheckBox")
271:                 WITH .ctlCheck1
272:                     .Caption   = ""
273:                     .Alignment = 0

*-- Linhas 408 a 925:
408:     ENDPROC
409: 
410:     *==========================================================================
411:     PROTECTED PROCEDURE ConfigurarBtnGrade
412:     *-- Botoes Selecionar/Desmarcar tudo (cmdBtnGrade do legado)
413:     *-- Posicionados abaixo e a direita da grade
414:     *==========================================================================
415:         *-- Botao Selecionar Tudo
416:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
417:         WITH THIS.cmd_4c_SelTudo
418:             .Top         = 265
419:             .Left        = 892
420:             .Height      = 40
421:             .Width       = 40
422:             .FontName    = "Verdana"
423:             .FontSize    = 8
424:             .WordWrap    = .T.
425:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
426:             .Caption     = ""
427:             .TabStop     = .F.
428:             .ToolTipText = "Selecionar Tudo"
429:             .ForeColor   = RGB(36, 84, 155)
430:             .BackColor   = RGB(255, 255, 255)
431:             .Themes      = .T.
432:         ENDWITH
433: 
434:         *-- Botao Desmarcar Tudo
435:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
436:         WITH THIS.cmd_4c_Apaga
437:             .Top         = 310
438:             .Left        = 892
439:             .Height      = 40
440:             .Width       = 40
441:             .FontName    = "Verdana"
442:             .FontSize    = 8
443:             .WordWrap    = .T.
444:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
445:             .Caption     = ""
446:             .TabStop     = .F.
447:             .ToolTipText = "Desmarcar Tudo"
448:             .ForeColor   = RGB(36, 84, 155)
449:             .BackColor   = RGB(255, 255, 255)
450:             .Themes      = .T.
451:         ENDWITH
452:     ENDPROC
453: 
454:     *==========================================================================
455:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
456:     *==========================================================================
457:         *-- Botoes principais
458:         BINDEVENT(THIS.cmd_4c_Processar,              "Click", THIS, "BtnProcessarClick")
459:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
460: 
461:         *-- Botoes de selecao de grade
462:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelecionarTudoClick")
463:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")
464: 
465:         *-- Cliques nos cabecalhos para ordenacao
466:         BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
467:         BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
468:         BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
469:         BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")
470: 
471:         *-- CheckBox de selecao individual: MouseDown + KeyPress
472:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
473:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
474:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
475:     ENDPROC
476: 
477:     *==========================================================================
478:     PROTECTED PROCEDURE MontarGrade
479:     *-- Vincula o cursor_4c_Itn ao grid apos BuscarMalas()
480:     *==========================================================================
481:         LOCAL loc_oGrd, loc_oErro
482:         loc_oGrd = .NULL.
483:         TRY
484:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
485:                 loc_oGrd = THIS.grd_4c_Selecoes
486:                 loc_oGrd.RecordSource = ""
487:             ENDIF
488: 
489:             IF USED("cursor_4c_Itn")
490:                 THIS.OrdenarGrade(THIS.this_nOrdemGrade)
491: 
492:                 loc_oGrd.ColumnCount = 3
493:                 loc_oGrd.RecordSource = "cursor_4c_Itn"
494: 
495:                 WITH loc_oGrd
496:                     .Column1.ControlSource = "cursor_4c_Itn.SelImp"
497:                     .Column2.ControlSource = "cursor_4c_Itn.Codigos"
498:                     .Column3.ControlSource = "cursor_4c_Itn.Descs"
499:                     .Column4.ControlSource = "cursor_4c_Itn.Usuins"
500:                     .Column5.ControlSource = "cursor_4c_Itn.Datins"
501:                     .Column6.ControlSource = "cursor_4c_Itn.Nregis"
502:                 ENDWITH
503: 
504:                 GO TOP IN cursor_4c_Itn
505:             ENDIF
506: 
507:             IF VARTYPE(loc_oGrd) = "O"
508:                 loc_oGrd.Refresh()
509:             ENDIF
510: 
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message, "Erro MontarGrade")
513:         ENDTRY
514:     ENDPROC
515: 
516:     *==========================================================================
517:     PROCEDURE OrdenarGrade
518:     *-- Ordena cursor_4c_Itn pela coluna especificada e destaca header
519:     *-- par_nColuna: 2=Codigos 3=Descs 4=UsuIns 5=DatIns
520:     *==========================================================================
521:         LPARAMETERS par_nColuna
522:         LOCAL loc_cTag, loc_nRec, loc_i
523:         loc_cTag = ""
524: 
525:         IF VARTYPE(par_nColuna) = "N"
526:             THIS.this_nOrdemGrade = par_nColuna
527:         ENDIF
528: 
529:         DO CASE
530:             CASE THIS.this_nOrdemGrade = 2
531:                 loc_cTag = "Codigos"
532:             CASE THIS.this_nOrdemGrade = 3
533:                 loc_cTag = "Descs"
534:             CASE THIS.this_nOrdemGrade = 4
535:                 loc_cTag = "Usuins"
536:             CASE THIS.this_nOrdemGrade = 5
537:                 loc_cTag = "Datins"
538:         ENDCASE
539: 
540:         IF USED("cursor_4c_Itn") AND !EMPTY(loc_cTag)
541:             loc_nRec = RECNO("cursor_4c_Itn")
542:             SET ORDER TO TAG (loc_cTag) IN cursor_4c_Itn
543:             IF RECCOUNT("cursor_4c_Itn") > 0
544:                 GO loc_nRec IN cursor_4c_Itn
545:             ENDIF
546:         ENDIF
547: 
548:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
549:             FOR loc_i = 1 TO THIS.grd_4c_Selecoes.ColumnCount
550:                 THIS.grd_4c_Selecoes.Columns(loc_i).Header1.BackColor = ;
551:                     IIF(THIS.this_nOrdemGrade = loc_i, RGB(220, 255, 220), RGB(192, 192, 192))
552:             ENDFOR
553:         ENDIF
554:     ENDPROC
555: 
556:     *==========================================================================
557:     PROTECTED PROCEDURE TornarControlesVisiveis
558:     *==========================================================================
559:         LOCAL loc_i, loc_oControl
560:         FOR loc_i = 1 TO THIS.ControlCount
561:             loc_oControl = THIS.Controls(loc_i)
562:             IF VARTYPE(loc_oControl) = "O"
563:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
564:                     loc_oControl.Visible = .T.
565:                 ENDIF
566:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
567:                     THIS.TornarSubControlesVisiveis(loc_oControl)
568:                 ENDIF
569:             ENDIF
570:         ENDFOR
571:     ENDPROC
572: 
573:     PROTECTED PROCEDURE TornarSubControlesVisiveis
574:         LPARAMETERS par_oContainer
575:         LOCAL loc_i, loc_oControl
576:         FOR loc_i = 1 TO par_oContainer.ControlCount
577:             loc_oControl = par_oContainer.Controls(loc_i)
578:             IF VARTYPE(loc_oControl) = "O"
579:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
580:                     loc_oControl.Visible = .T.
581:                 ENDIF
582:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
583:                     THIS.TornarSubControlesVisiveis(loc_oControl)
584:                 ENDIF
585:             ENDIF
586:         ENDFOR
587:     ENDPROC
588: 
589:     *==========================================================================
590:     * Compatibilidade de pipeline ? OPERACIONAL flat (sem PageFrame/CRUD)
591:     *
592:     * Este form nao segue o padrao Page1=Lista/Page2=Dados.
593:     * Grid e botoes sao criados diretamente via:
594:     *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
595:     *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
596:     *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
597:     * Todos chamados em InicializarForm().
598:     *==========================================================================
599:     PROTECTED PROCEDURE ConfigurarPageFrame()
600:         *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
601:         RETURN .T.
602:     ENDPROC
603: 
604:     PROTECTED PROCEDURE ConfigurarPaginaLista()
605:         *-- OPERACIONAL: grid ja configurado por ConfigurarGrade() em InicializarForm()
606:         *-- Refrescar grade caso chamado pelo pipeline apos carga inicial
607:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5) AND USED("cursor_4c_Itn")
608:             THIS.grd_4c_Selecoes.Refresh()
609:         ENDIF
610:     ENDPROC
611: 
612:     PROTECTED PROCEDURE ConfigurarPaginaDados()
613:         *-- OPERACIONAL: sem pagina de dados separada; grade gerenciada por ConfigurarGrade()
614:         RETURN .T.
615:     ENDPROC
616: 
617:     PROCEDURE AlternarPagina(par_nPagina)
618:         *-- OPERACIONAL: nao ha troca de pagina; apenas refresca a grade
619:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
620:             THIS.grd_4c_Selecoes.Refresh()
621:         ENDIF
622:     ENDPROC
623: 
624:     *==========================================================================
625:     PROCEDURE Destroy
626:     *==========================================================================
627:         IF USED("cursor_4c_Itn")
628:             USE IN cursor_4c_Itn
629:         ENDIF
630:         DODEFAULT()
631:     ENDPROC
632: 
633:     *==========================================================================
634:     * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
635:     *==========================================================================
636: 
637:     PROCEDURE BtnProcessarClick()
638:         LOCAL loc_cNome, loc_lOk, loc_nSelecionadas, loc_oErro
639:         loc_lOk = .F.
640:         loc_cNome = ""
641: 
642:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
643:             THIS.cmd_4c_Processar.Enabled = .F.
644:         ENDIF
645: 
646:         TRY
647:             IF !USED("cursor_4c_Itn")
648:                 MsgAviso("Nenhuma mala direta carregada.", "Processar")
649:             ELSE
650:                 *-- GO TOP + refresh antes de verificar selecao (comportamento original)
651:                 GO TOP IN cursor_4c_Itn
652:                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
653:                     THIS.grd_4c_Selecoes.Refresh()
654:                 ENDIF
655: 
656:                 *-- Verificar se ha malas com registros selecionadas
657:                 SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
658:                     WHERE SelImp = 1 INTO CURSOR cursor_4c_TmpSel
659:                 loc_nSelecionadas = 0
660:                 IF USED("cursor_4c_TmpSel")
661:                     loc_nSelecionadas = NVL(cursor_4c_TmpSel.nSel, 0)
662:                     USE IN cursor_4c_TmpSel
663:                 ENDIF
664: 
665:                 IF loc_nSelecionadas < 1
666:                     MsgAviso("Nenhuma Mala Direta com registros foi selecionada para unifica" + ;
667:                              CHR(231) + CHR(227) + "o.", "Processar")
668:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
669:                         THIS.grd_4c_Selecoes.SetFocus()
670:                     ENDIF
671:                 ELSE
672:                     IF loc_nSelecionadas = 1
673:                     MsgAviso("Apenas uma Mala Direta com registros foi selecionada." + CHR(13) + ;
674:                              "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel unificar apenas uma." + CHR(13) + ;
675:                              "Selecione ao menos duas Malas Diretas.", "Processar")
676:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
677:                         THIS.grd_4c_Selecoes.SetFocus()
678:                     ENDIF
679:                 ELSE
680:                     IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
681:                         loc_cNome = ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
682:                     ENDIF
683: 
684:                     IF EMPTY(loc_cNome)
685:                         MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido." + CHR(13) + ;
686:                                  "Este " + CHR(233) + " o nome que ser" + CHR(225) + " utilizado na unifica" + ;
687:                                  CHR(231) + CHR(227) + "o gerada.", "Processar")
688:                         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
689:                             THIS.cnt_4c_Nova.txt_4c_GetNova.SetFocus()
690:                         ENDIF
691:                     ELSE
692:                         IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?")
693:                             loc_lOk = THIS.this_oBusinessObject.ProcessarUnificacao(loc_cNome)
694:                             IF loc_lOk
695:                                 THIS.MontarGrade()
696:                                 IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
697:                                     THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
698:                                 ENDIF
699:                                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
700:                                     THIS.grd_4c_Selecoes.SetFocus()
701:                                 ENDIF
702:                             ENDIF
703:                         ENDIF
704:                     ENDIF
705:                     ENDIF
706:                 ENDIF
707:             ENDIF
708: 
709:         CATCH TO loc_oErro
710:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
711:         ENDTRY
712: 
713:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
714:             THIS.cmd_4c_Processar.Enabled = .T.
715:         ENDIF
716:     ENDPROC
717: 
718:     PROCEDURE BtnEncerrarClick()
719:         THIS.Release()
720:     ENDPROC
721: 
722:     PROCEDURE BtnSelecionarTudoClick()
723:         IF USED("cursor_4c_Itn")
724:             REPLACE ALL SelImp WITH 1 IN cursor_4c_Itn
725:         ENDIF
726:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
727:             THIS.grd_4c_Selecoes.Refresh()
728:         ENDIF
729:     ENDPROC
730: 
731:     PROCEDURE BtnDesmarcarTudoClick()
732:         IF USED("cursor_4c_Itn")
733:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
734:         ENDIF
735:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
736:             THIS.grd_4c_Selecoes.Refresh()
737:         ENDIF
738:     ENDPROC
739: 
740:     PROCEDURE Col2HeaderClick()
741:         THIS.OrdenarGrade(2)
742:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
743:             THIS.grd_4c_Selecoes.Refresh()
744:         ENDIF
745:     ENDPROC
746: 
747:     PROCEDURE Col3HeaderClick()
748:         THIS.OrdenarGrade(3)
749:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
750:             THIS.grd_4c_Selecoes.Refresh()
751:         ENDIF
752:     ENDPROC
753: 
754:     PROCEDURE Col4HeaderClick()
755:         THIS.OrdenarGrade(4)
756:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
757:             THIS.grd_4c_Selecoes.Refresh()
758:         ENDIF
759:     ENDPROC
760: 
761:     PROCEDURE Col5HeaderClick()
762:         THIS.OrdenarGrade(5)
763:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
764:             THIS.grd_4c_Selecoes.Refresh()
765:         ENDIF
766:     ENDPROC
767: 
768:     *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
769:     PROCEDURE GrdChkMouseDown
770:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
771:         LOCAL loc_nSel
772:         IF USED("cursor_4c_Itn")
773:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
774:             SELECT cursor_4c_Itn
775:             REPLACE SelImp WITH loc_nSel
776:         ENDIF
777:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
778:             THIS.grd_4c_Selecoes.Refresh()
779:         ENDIF
780:         NODEFAULT
781:     ENDPROC
782: 
783:     *-- KeyPress: toggle SelImp com Enter (13) ou Space (32)
784:     PROCEDURE GrdChkKeyPress
785:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
786:         LOCAL loc_nSel
787:         IF INLIST(par_nKeyCode, 13, 32)
788:             IF USED("cursor_4c_Itn")
789:                 loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
790:                 SELECT cursor_4c_Itn
791:                 REPLACE SelImp WITH loc_nSel
792:             ENDIF
793:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
794:                 THIS.grd_4c_Selecoes.Refresh()
795:             ENDIF
796:             NODEFAULT
797:         ENDIF
798:     ENDPROC
799: 
800:     *-- Click: absorver para nao disparar duplo-toggle com MouseDown
801:     PROCEDURE GrdChkClick()
802:         NODEFAULT
803:     ENDPROC
804: 
805:     *==========================================================================
806:     * Contratos de pipeline ? nao aplicaveis a este form OPERACIONAL
807:     * (nao ha Page1=Lista/Page2=Dados nem botoes CRUD; acao principal = BtnProcessarClick)
808:     *==========================================================================
809:     PROCEDURE BtnIncluirClick()
810:         RETURN .F.
811:     ENDPROC
812: 
813:     PROCEDURE BtnAlterarClick()
814:         RETURN .F.
815:     ENDPROC
816: 
817:     PROCEDURE BtnExcluirClick()
818:         RETURN .F.
819:     ENDPROC
820: 
821:     PROCEDURE BtnVisualizarClick()
822:         RETURN .F.
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * CarregarLista - recarrega grade do servidor (contrato de pipeline)
827:     *==========================================================================
828:     PROCEDURE CarregarLista()
829:         LOCAL loc_lSucesso
830:         loc_lSucesso = .F.
831:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
832:             loc_lSucesso = THIS.this_oBusinessObject.BuscarMalas()
833:             IF loc_lSucesso
834:                 THIS.MontarGrade()
835:             ENDIF
836:         ENDIF
837:         RETURN loc_lSucesso
838:     ENDPROC
839: 
840:     *==========================================================================
841:     * FormParaBO - mapeia campo "Nome da Unificacao" para o BO
842:     * (unico campo editavel pelo usuario neste form OPERACIONAL)
843:     *==========================================================================
844:     PROCEDURE FormParaBO()
845:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
846:             IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
847:                 THIS.this_oBusinessObject.this_cDescs = ;
848:                     ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
849:             ENDIF
850:         ENDIF
851:         RETURN .T.
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * BOParaForm - popula campo "Nome da Unificacao" a partir do BO
856:     *==========================================================================
857:     PROCEDURE BOParaForm()
858:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
859:             IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
860:                 THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ;
861:                     THIS.this_oBusinessObject.this_cDescs
862:             ENDIF
863:         ENDIF
864:         RETURN .T.
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * HabilitarCampos - habilita/desabilita controles editaveis
869:     *==========================================================================
870:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
871:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
872:             THIS.cnt_4c_Nova.txt_4c_GetNova.Enabled = par_lHabilitar
873:         ENDIF
874:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
875:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
876:         ENDIF
877:     ENDPROC
878: 
879:     *==========================================================================
880:     * LimparCampos - limpa campo nome e desmarca todas as selecoes da grade
881:     *==========================================================================
882:     PROTECTED PROCEDURE LimparCampos()
883:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
884:             THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
885:         ENDIF
886:         IF USED("cursor_4c_Itn")
887:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
888:         ENDIF
889:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
890:             THIS.grd_4c_Selecoes.Refresh()
891:         ENDIF
892:     ENDPROC
893: 
894:     *==========================================================================
895:     * AjustarBotoesPorModo - sem modo CRUD neste form OPERACIONAL
896:     *==========================================================================
897:     PROTECTED PROCEDURE AjustarBotoesPorModo()
898:         *-- OPERACIONAL: habilita Processar somente se BO inicializado
899:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
900:             THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
901:         ENDIF
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * BtnBuscarClick - recarrega a lista de malas diretas do servidor
906:     *==========================================================================
907:     PROCEDURE BtnBuscarClick()
908:         THIS.CarregarLista()
909:     ENDPROC
910: 
911:     *==========================================================================
912:     * BtnSalvarClick - nao aplicavel (salvar ocorre via BtnProcessarClick)
913:     *==========================================================================
914:     PROCEDURE BtnSalvarClick()
915:         RETURN .F.
916:     ENDPROC
917: 
918:     *==========================================================================
919:     * BtnCancelarClick - limpa selecoes e campo nome
920:     *==========================================================================
921:     PROCEDURE BtnCancelarClick()
922:         THIS.LimparCampos()
923:     ENDPROC
924: 
925: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMluBO.prg):
*==============================================================================
* SigPrMluBO.prg - Business Object: Unificacao de Mala Direta
* Tabela principal: SigMlItn (lista de malas para unificacao)
* Tabela secundaria: SigMlCab (membros/destinatarios das malas)
*==============================================================================
DEFINE CLASS SigPrMluBO AS BusinessBase

    *-- Propriedades do registro SigMlItn gerado pela unificacao
    this_cCodigos        = ""   && char(10) PK - codigo gerado via SYS(2015)
    this_cDescs          = ""   && char(30) - nome da unificacao digitado pelo usuario
    this_cUsuIns         = ""   && char(10) - usuario que executou
    this_nNRegis         = 0    && numeric(8,0) - qtd de registros unificados (apos dedup)
    this_cEspelhos       = ""   && char(8)  - sempre 'SigPrMlu'
    this_cUnificas       = ""   && text     - lista de codigos unificados (sep '; ')

    *-- Controle interno do processamento
    this_nTotalMalas     = 0    && qtd de malas selecionadas (SelImp=1 AND NRegis>0)
    this_nTotalRegistros = 0    && total bruto de registros antes da deduplicacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMlItn"
        this_cCampoChave = "Codigos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna PK do registro atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia cursor_4c_Itn para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = NVL(Codigos,  "")
            THIS.this_cDescs    = NVL(Descs,    "")
            THIS.this_cUsuIns   = NVL(Usuins,   "")
            THIS.this_nNRegis   = NVL(Nregis,   0)
            THIS.this_cEspelhos = NVL(Espelhos, "")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMalas - carrega SigMlItn em cursor_4c_Itn com SelImp=0
    * Equivale ao MontaGrades + Requery do legado
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMalas()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Itn")
                TABLEREVERT(.T., "cursor_4c_Itn")
                USE IN cursor_4c_Itn
            ENDIF
            IF USED("cursor_4c_ItnTemp")
                USE IN cursor_4c_ItnTemp
            ENDIF

            loc_cSQL = "SELECT Codigos, Descs, UsuIns, DatIns, NRegis, Espelhos " + ;
                       "FROM SigMlItn ORDER BY Descs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Itn ( ;
                    SelImp   N(1,0) NULL, ;
                    Codigos  C(10)  NULL, ;
                    Descs    C(30)  NULL, ;
                    Usuins   C(10)  NULL, ;
                    Datins   T      NULL, ;
                    Nregis   N(8,0) NULL, ;
                    Espelhos C(8)   NULL  ;
                )
                SET NULL OFF

                INDEX ON Codigos TAG Codigos
                INDEX ON Descs   TAG Descs
                INDEX ON Usuins  TAG Usuins
                INDEX ON Datins  TAG Datins

                SELECT cursor_4c_Itn
                APPEND FROM DBF("cursor_4c_ItnTemp")
                REPLACE ALL SelImp WITH 0

                USE IN cursor_4c_ItnTemp
                GO TOP IN cursor_4c_Itn
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de Malas Diretas.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarUnificacao - unifica malas selecionadas (SelImp=1) em uma nova
    * par_cNomeUnificacao - nome digitado pelo usuario para a nova mala
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarUnificacao(par_cNomeUnificacao)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cNew, loc_lcUni, loc_lnTot, loc_nMalas, loc_pCod, loc_cSQL
        LOCAL loc_lInsertOk

        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Itn")
                MsgAviso("Grade de malas n" + CHR(227) + "o carregada.", "Aviso")
            ELSE
                *-- Conta malas com registros selecionadas
                loc_nMalas = 0
                SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
                    WHERE SelImp = 1 INTO CURSOR cursor_4c_ContSel READWRITE
                IF USED("cursor_4c_ContSel")
                    SELECT cursor_4c_ContSel
                    loc_nMalas = NVL(nSel, 0)
                    USE IN cursor_4c_ContSel
                ENDIF

                IF loc_nMalas < 1
                    MsgAviso("Nenhuma Mala Direta com Registros foi Selecionada para Unifica" + ;
                             CHR(231) + CHR(227) + "o!", "Aviso")
                ELSE
                    IF loc_nMalas = 1
                    MsgAviso("Selecione ao menos duas Malas Diretas para Unificar.", "Aviso")
                ELSE
                    *-- Gera novo codigo para a mala unificada
                    loc_cNew  = SUBSTR(SYS(2015), 3, 10)
                    loc_lcUni = ""
                    loc_lnTot = 0

                    *-- Cursor acumulador de TODOS os registros das malas selecionadas
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaDup ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    *-- Acumula registros de cada mala selecionada via SQLEXEC
                    SELECT cursor_4c_Itn
                    SCAN FOR SelImp = 1
                        loc_pCod  = RTRIM(cursor_4c_Itn.Codigos)
                        loc_lcUni = loc_lcUni + loc_pCod + "; "

                        loc_cSQL = "SELECT Cidchaves, IClis, Codigos, Bairs, Ceps, Compls, " + ;
                                   "Estas, Faxs, Grupos, Mes, Nums, Rclis, Tel1S, Tel2S, " + ;
                                   "Cidas, Endes, Nascs, Profiss, Sexos, Ultcomps, Aptos, " + ;
                                   "Opdest, Desti, Opini, Dtncons, Conjuges, Dtcasas, " + ;
                                   "Situas, Dataincs, Opani, Quebras, Cpfs " + ;
                                   "FROM SigMlCab WHERE Codigos = " + EscaparSQL(loc_pCod)

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MlaTemp") > 0
                            loc_lnTot = loc_lnTot + RECCOUNT("cursor_4c_MlaTemp")
                            SELECT cursor_4c_MalaDup
                            APPEND FROM DBF("cursor_4c_MlaTemp")
                            USE IN cursor_4c_MlaTemp
                        ENDIF
                    ENDSCAN

                    *-- Calcula ChaveUnica de deduplicacao para todos os registros
                    SELECT cursor_4c_MalaDup
                    REPLACE ALL ChaveUnica WITH ;
                        PADR(UPPER(STRTRAN( ;
                            RTRIM(NVL(Desti,  "")) + ;
                            RTRIM(NVL(Ceps,   "")) + ;
                            RTRIM(NVL(Endes,  "")) + ;
                            RTRIM(NVL(Nums,   "")) + ;
                            RTRIM(NVL(Compls, "")), " ", "")), 200)

                    *-- Cursor de destino: apenas registros unicos
                    SET NULL ON
                    CREATE CURSOR cursor_4c_MalaUni ( ;
                        Cidchaves C(20) NULL, IClis    C(10)  NULL, Codigos  C(10)  NULL, ;
                        Bairs     C(40) NULL, Ceps     C(9)   NULL, Compls   C(25)  NULL, ;
                        Estas     C(2)  NULL, Faxs     C(20)  NULL, Grupos   C(10)  NULL, ;
                        Mes       C(2)  NULL, Nums     C(10)  NULL, Rclis    C(50)  NULL, ;
                        Tel1S     C(20) NULL, Tel2S    C(20)  NULL, Cidas    C(30)  NULL, ;
                        Endes     C(60) NULL, Nascs    T      NULL, Profiss  C(20)  NULL, ;
                        Sexos     C(1)  NULL, Ultcomps T      NULL, Aptos    N(6,0) NULL, ;
                        Opdest    N(1,0) NULL, Desti   C(50)  NULL, Opini    N(1,0) NULL, ;
                        Dtncons   T     NULL, Conjuges C(60)  NULL, Dtcasas  T      NULL, ;
                        Situas    C(3)  NULL, Dataincs T      NULL, Opani    N(1,0) NULL, ;
                        Quebras   C(40) NULL, Cpfs     C(20)  NULL, ;
                        ChaveUnica C(200) NULL ;
                    )
                    SET NULL OFF

                    SELECT cursor_4c_MalaUni
                    INDEX ON ChaveUnica TAG idxmalauni

                    *-- Deduplicacao: copia apenas registros com ChaveUnica nova
                    SELECT cursor_4c_MalaDup
                    GO TOP
                    SCAN
                        IF !SEEK(cursor_4c_MalaDup.ChaveUnica, "cursor_4c_MalaUni", "idxmalauni")
                            SCATTER MEMVAR MEMO
                            SELECT cursor_4c_MalaUni
                            APPEND BLANK
                            GATHER MEMVAR MEMO
                            SELECT cursor_4c_MalaDup
                        ENDIF
                    ENDSCAN

                    *-- Insere registros deduplicados no SQL Server SigMlCab
                    loc_lInsertOk = .T.
                    SELECT cursor_4c_MalaUni
                    GO TOP
                    SCAN
                        loc_cSQL = THIS.GerarSQLInsertSigMlCab(loc_cNew)
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                            MsgErro("Erro ao inserir registro na Mala Direta unificada.", "Erro")
                            loc_lInsertOk = .F.
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF loc_lInsertOk
                        *-- Atualiza propriedades e persiste SigMlItn
                        THIS.this_cCodigos        = loc_cNew
                        THIS.this_cDescs          = LEFT(ALLTRIM(par_cNomeUnificacao), 30)
                        THIS.this_cUsuIns         = ALLTRIM(gc_4c_UsuarioLogado)
                        THIS.this_nNRegis         = RECCOUNT("cursor_4c_MalaUni")
                        THIS.this_cEspelhos       = "SigPrMlu"
                        THIS.this_cUnificas       = loc_lcUni
                        THIS.this_nTotalMalas     = loc_nMalas
                        THIS.this_nTotalRegistros = loc_lnTot

                        IF THIS.Inserir()
                            MsgInfo( ;
                                "Unifica" + CHR(231) + CHR(227) + "o '" + ;
                                ALLTRIM(par_cNomeUnificacao) + "' Conclu" + CHR(237) + "da!" + CHR(13) + ;
                                "Foram Selecionados " + ALLTRIM(STR(THIS.this_nNRegis)) + " Registros," + CHR(13) + ;
                                "Retirados de " + ALLTRIM(STR(loc_nMalas)) + " Malas Diretas," + CHR(13) + ;
                                "Que Continham Um Total de " + ALLTRIM(STR(loc_lnTot)) + " Registros.", ;
                                "Unifica" + CHR(231) + CHR(227) + "o")
                            THIS.BuscarMalas()
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpa cursores de trabalho (fora do TRY para sempre executar)
        IF USED("cursor_4c_MalaDup")
            USE IN cursor_4c_MalaDup
        ENDIF
        IF USED("cursor_4c_MalaUni")
            USE IN cursor_4c_MalaUni
        ENDIF
        IF USED("cursor_4c_MlaTemp")
            USE IN cursor_4c_MlaTemp
        ENDIF
        IF USED("cursor_4c_ContSel")
            USE IN cursor_4c_ContSel
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSQLInsertSigMlCab - monta SQL INSERT para um registro de SigMlCab
    * Cursor_4c_MalaUni deve estar posicionado no registro a inserir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarSQLInsertSigMlCab(par_cNovoCodigos)
        LOCAL loc_cSQL, loc_cCidChaves

        loc_cCidChaves = fUniqueIds()

        *-- Monta INSERT parte a parte para clareza
        loc_cSQL = "INSERT INTO SigMlCab " + ;
                   "(CidChaves, Codigos, IClis, Bairs, Ceps, Compls, Estas, Faxs, Grupos, " + ;
                   "Mes, Nums, Rclis, Tel1S, Tel2S, Cidas, Endes, Nascs, Profiss, " + ;
                   "Sexos, Ultcomps, Aptos, Opdest, Desti, Opini, Dtncons, Conjuges, " + ;
                   "Dtcasas, Situas, Dataincs, Opani, Quebras, Cpfs, DesDtCom, TelDtCom) " + ;
                   "VALUES (" + ;
                   EscaparSQL(loc_cCidChaves) + ", " + ;
                   EscaparSQL(par_cNovoCodigos) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.IClis,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Bairs,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Ceps,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Compls,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Estas,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Faxs,     ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Grupos,   ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Mes,      ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Nums,     ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Rclis,"")),50)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel1S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Tel2S,    ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cidas,    ""))) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Endes,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Nascs) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Profiss,"")),20)) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Sexos,    ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Ultcomps) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Aptos,  0), 0) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opdest, 0), 0) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Desti,  "")),50)) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opini,  0), 0) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtncons) + ", " + ;
                   EscaparSQL(LEFT(RTRIM(NVL(cursor_4c_MalaUni.Conjuges,"")),60)) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dtcasas) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Situas,  ""))) + ", " + ;
                   FormatarDataSQL(cursor_4c_MalaUni.Dataincs) + ", " + ;
                   FormatarNumeroSQL(NVL(cursor_4c_MalaUni.Opani,  0), 0) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Quebras, ""))) + ", " + ;
                   EscaparSQL(RTRIM(NVL(cursor_4c_MalaUni.Cpfs,    ""))) + ", " + ;
                   "'', '')"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT novo registro SigMlItn no SQL Server
    * SigMlItn tem ~80 colunas NOT NULL; filtros de selecao recebem valores
    * neutros (' '/0/0) pois este registro e produto da unificacao, nao filtro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        LOCAL loc_cCols1, loc_cCols2, loc_cCols3, loc_cCols4
        LOCAL loc_cVals1, loc_cVals2, loc_cVals3, loc_cVals4
        LOCAL loc_cCidChaves

        loc_lSucesso = .F.
        TRY
            loc_cCidChaves = fUniqueIds()

            *-- Bloco 1: colunas com valores reais do processo de unificacao
            loc_cCols1 = "Codigos, Descs, Ativos, UsuIns, UsuAlts, DatIns, NRegis, " + ;
                         "Espelhos, Unificas, CidChaves"
            loc_cVals1 = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                         EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", 1, " + ;
                         EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                         "'', GETDATE(), " + ;
                         FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                         "'SigPrMlu', " + ;
                         EscaparSQL(THIS.this_cUnificas) + ", " + ;
                         EscaparSQL(loc_cCidChaves)

            *-- Bloco 2: colunas char NOT NULL de criterios de filtro (vazias)
            loc_cCols2 = ", DEmps, Cadas, Cemps, CepFs, CepIs, Cidades, Ests, FaixaFs, FaixaIs, " + ;
                         "Nomes, Profs, RSocs, AnivFs, AnivIs, LinHas, TabUfs, BairS, Estados, " + ;
                         "Vends, CParents, Paises, Dopes, Conjuge, Situa, ClassiFis, ClassiFSs, " + ;
                         "RegIFs, RegIIs"
            loc_cVals2 = ", '', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', '', " + ;
                         "'', '', '', '', '', '', '', '', " + ;
                         "'', ''"

            *-- Bloco 3: colunas numericas NOT NULL de criterios de filtro (zero)
            loc_cCols3 = ", DestIs, OPSexS, OptCepS, OptNrS, OptUltS, Situas, OPSitua, OPAnis, " + ;
                         "OPCivis, OpenDes, OptLmk, OPIdade, EnDigual, ValosF, ValosI, IdadeFs, IdadeIs"
            loc_cVals3 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0"

            *-- Bloco 4: colunas bit NOT NULL de criterios de filtro (zero)
            loc_cCols4 = ", CkAnis, CkCads, CkCepS, CkCidS, CkEmpS, CkEsts, CkFNoms, CkNomes, CkProfs, " + ;
                         "CkRSocs, CkSexS, CkUlts, CkClas, CkSituas, CkRegis, CkSitua, CkCivils, " + ;
                         "CkDtEnts, CkLinhas, CkBairs, CkVends, CkIdade, CkDtAtus, CkTlMk, CkNComp, " + ;
                         "CkUltCom, CkPais, CkMov, CkConjuge"
            loc_cVals4 = ", 0, 0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0, 0, 0, 0, 0, " + ;
                         "0, 0, 0, 0"

            loc_cSQL = "INSERT INTO SigMlItn (" + ;
                       loc_cCols1 + loc_cCols2 + loc_cCols3 + loc_cCols4 + ") " + ;
                       "VALUES (" + loc_cVals1 + loc_cVals2 + loc_cVals3 + loc_cVals4 + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                MsgErro("Erro ao gravar Unifica" + CHR(231) + CHR(227) + "o no banco de dados.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE do registro SigMlItn no SQL Server
    * A tela original nao faz edicao apos unificar (mala unificada e imutavel),
    * mas o metodo existe para permitir manutencao (renomear, atualizar contadores)
    * via propriedades do BO.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo da Unifica" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o informado.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigMlItn SET " + ;
                           "Descs = "     + EscaparSQL(LEFT(THIS.this_cDescs, 30)) + ", " + ;
                           "UsuAlts = "   + EscaparSQL(LEFT(THIS.this_cUsuIns, 10)) + ", " + ;
                           "NRegis = "    + FormatarNumeroSQL(THIS.this_nNRegis, 0) + ", " + ;
                           "Espelhos = "  + EscaparSQL(LEFT(THIS.this_cEspelhos, 8)) + ", " + ;
                           "Unificas = "  + EscaparSQL(THIS.this_cUnificas) + " " + ;
                           "WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Erro ao atualizar Unifica" + CHR(231) + CHR(227) + ;
                            "o no banco de dados.", "Erro")
                ELSE
                    THIS.RegistrarAuditoria("A")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, DataHora, Tabela, Operacao, ChaveRegistro, Descricao) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", GETDATE(), " + ;
                       "'SigMlItn', " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL("Unifica" + CHR(231) + CHR(227) + "o: " + THIS.this_cDescs) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

ENDDEFINE

