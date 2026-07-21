# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrd.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMlu.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (921 linhas total):

*-- Linhas 30 a 118:
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
56:                 THIS.ConfigurarBotoes()
57:                 THIS.ConfigurarCntNova()
58:                 THIS.ConfigurarGrade()
59:                 THIS.ConfigurarBtnGrade()
60:                 THIS.ConfigurarBINDEVENTs()
61:                 THIS.TornarControlesVisiveis()
62: 
63:                 THIS.this_oBusinessObject.BuscarMalas()
64:                 THIS.MontarGrade()
65: 
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loc_oErro
70:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
71:                     " PROC=" + loc_oErro.Procedure, "Erro em InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *==========================================================================
78:     PROTECTED PROCEDURE ConfigurarCabecalho
79:     *==========================================================================
80:         LOCAL loc_oCab
81:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
82:         loc_oCab = THIS.cnt_4c_Cabecalho
83:         WITH loc_oCab
84:             .Top         = 0
85:             .Left        = 0
86:             .Width       = 1020
87:             .Height      = 80
88:             .BorderWidth = 0
89:             .BackStyle   = 1
90:             .BackColor   = RGB(100, 100, 100)
91:         ENDWITH
92:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
93:         WITH loc_oCab.lbl_4c_Sombra
94:             .AutoSize      = .F.
95:             .Top           = 18
96:             .Left          = 10
97:             .Width         = 1000
98:             .Height        = 40
99:             .FontBold      = .T.
100:             .FontName      = "Tahoma"
101:             .FontSize      = 18
102:             .FontUnderline = .F.
103:             .WordWrap      = .T.
104:             .Alignment     = 0
105:             .BackStyle     = 0
106:             .ForeColor     = RGB(0, 0, 0)
107:             .Caption       = "Unifica" + CHR(231) + CHR(227) + "o de Mala Direta"
108:         ENDWITH
109:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
110:         WITH loc_oCab.lbl_4c_Titulo
111:             .AutoSize      = .F.
112:             .Top           = 17
113:             .Left          = 10
114:             .Width         = 1000
115:             .Height        = 46
116:             .FontBold      = .T.
117:             .FontName      = "Tahoma"
118:             .FontSize      = 18

*-- Linhas 126 a 169:
126:     ENDPROC
127: 
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarBotoes
130:     *==========================================================================
131:         LOCAL loc_oCnt
132:         *-- Botao Processar (standalone com icone 60px, Themes=.T. + DisabledPicture obrigatorios)
133:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
134:         WITH THIS.cmd_4c_Processar
135:             .Top             = 5
136:             .Left            = 828
137:             .Height          = 75
138:             .Width           = 75
139:             .FontBold        = .T.
140:             .FontItalic      = .T.
141:             .FontName        = "Comic Sans MS"
142:             .FontSize        = 8
143:             .WordWrap        = .T.
144:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
145:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
146:             .Caption         = "\<Processar"
147:             .ToolTipText     = "[Alt+P] Processar Unifica" + CHR(231) + CHR(227) + "o"
148:             .ForeColor       = RGB(90, 90, 90)
149:             .BackColor       = RGB(255, 255, 255)
150:             .Themes          = .T.
151:         ENDWITH
152: 
153:         *-- Container canonico Encerrar (Left=917, Width=90, Height=85)
154:         THIS.AddObject("cnt_4c_Saida", "Container")
155:         loc_oCnt = THIS.cnt_4c_Saida
156:         WITH loc_oCnt
157:             .Top         = -2
158:             .Left        = 917
159:             .Width       = 90
160:             .Height      = 85
161:             .BorderWidth = 0
162:             .BackStyle   = 0
163:         ENDWITH
164:         loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
165:         WITH loc_oCnt.cmd_4c_Encerrar
166:             .Top         = 5
167:             .Left        = 5
168:             .Height      = 75
169:             .Width       = 75

*-- Linhas 183 a 271:
183:     ENDPROC
184: 
185:     *==========================================================================
186:     PROTECTED PROCEDURE ConfigurarCntNova
187:     *-- Container com campo "Nome da Unificacao" (cntNova do legado)
188:     *==========================================================================
189:         LOCAL loc_oCnt
190:         THIS.AddObject("cnt_4c_Nova", "Container")
191:         loc_oCnt = THIS.cnt_4c_Nova
192:         WITH loc_oCnt
193:             .Top         = 92
194:             .Left        = 15
195:             .Width       = 800
196:             .Height      = 42
197:             .BackStyle   = 0
198:             .BorderWidth = 0
199:         ENDWITH
200:         loc_oCnt.AddObject("lbl_4c_Nome", "Label")
201:         WITH loc_oCnt.lbl_4c_Nome
202:             .AutoSize  = .T.
203:             .FontBold  = .T.
204:             .FontName  = "Tahoma"
205:             .FontSize  = 8
206:             .BackStyle = 0
207:             .Caption   = " \<Nome da Unifica" + CHR(231) + CHR(227) + "o :"
208:             .Height    = 15
209:             .Left      = 20
210:             .Top       = 13
211:             .ForeColor = RGB(90, 90, 90)
212:         ENDWITH
213:         loc_oCnt.AddObject("txt_4c_GetNova", "TextBox")
214:         WITH loc_oCnt.txt_4c_GetNova
215:             .FontName          = "Courier New"
216:             .FontSize          = 9
217:             .Format            = "K"
218:             .Height            = 25
219:             .Left              = 155
220:             .MaxLength         = 20
221:             .TabIndex          = 1
222:             .Top               = 8
223:             .Width             = 220
224:             .DisabledBackColor = RGB(255, 255, 255)
225:             .DisabledForeColor = RGB(0, 0, 128)
226:             .Value             = ""
227:         ENDWITH
228:     ENDPROC
229: 
230:     *==========================================================================
231:     PROTECTED PROCEDURE ConfigurarGrade
232:     *-- Grid grd_4c_Selecoes: 6 colunas (Check, Codigo, Descricao, Usuario,
233:     *-- Dt.Entrada, N.Registros) ? espelho do grdSelecoes do legado
234:     *==========================================================================
235:         THIS.AddObject("grd_4c_Selecoes", "Grid")
236:         WITH THIS.grd_4c_Selecoes
237:             .Top                = 140
238:             .Left               = 15
239:             .Width              = 870
240:             .Height             = 420
241:             .RecordMark         = .F.
242:             .DeleteMark         = .F.
243:             .RowHeight          = 16
244:             .HeaderHeight       = 16
245:             .AllowHeaderSizing  = .F.
246:             .AllowRowSizing     = .F.
247:             .ReadOnly           = .F.
248:             .ScrollBars         = 2
249:             .FontName           = "Tahoma"
250:             .FontSize           = 8
251:             .GridLineColor      = RGB(238, 238, 238)
252:             .ColumnCount        = 6
253: 
254:             *-- Column1: CheckBox de selecao (SelImp)
255:             WITH .Column1
256:                 .ColumnOrder   = 1
257:                 .Width         = 20
258:                 .Movable       = .F.
259:                 .Resizable     = .F.
260:                 .ReadOnly      = .F.
261:                 WITH .Header1
262:                     .Caption   = ""
263:                     .Alignment = 2
264:                     .FontName  = "Tahoma"
265:                     .FontSize  = 8
266:                     .ForeColor = RGB(36, 84, 155)
267:                 ENDWITH
268:                 .AddObject("ctlCheck1", "CheckBox")
269:                 WITH .ctlCheck1
270:                     .Caption   = ""
271:                     .Alignment = 0

*-- Linhas 406 a 921:
406:     ENDPROC
407: 
408:     *==========================================================================
409:     PROTECTED PROCEDURE ConfigurarBtnGrade
410:     *-- Botoes Selecionar/Desmarcar tudo (cmdBtnGrade do legado)
411:     *-- Posicionados abaixo e a direita da grade
412:     *==========================================================================
413:         *-- Botao Selecionar Tudo
414:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
415:         WITH THIS.cmd_4c_SelTudo
416:             .Top         = 265
417:             .Left        = 892
418:             .Height      = 40
419:             .Width       = 40
420:             .FontName    = "Verdana"
421:             .FontSize    = 8
422:             .WordWrap    = .T.
423:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
424:             .Caption     = ""
425:             .TabStop     = .F.
426:             .ToolTipText = "Selecionar Tudo"
427:             .ForeColor   = RGB(36, 84, 155)
428:             .BackColor   = RGB(255, 255, 255)
429:             .Themes      = .T.
430:         ENDWITH
431: 
432:         *-- Botao Desmarcar Tudo
433:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
434:         WITH THIS.cmd_4c_Apaga
435:             .Top         = 310
436:             .Left        = 892
437:             .Height      = 40
438:             .Width       = 40
439:             .FontName    = "Verdana"
440:             .FontSize    = 8
441:             .WordWrap    = .T.
442:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
443:             .Caption     = ""
444:             .TabStop     = .F.
445:             .ToolTipText = "Desmarcar Tudo"
446:             .ForeColor   = RGB(36, 84, 155)
447:             .BackColor   = RGB(255, 255, 255)
448:             .Themes      = .T.
449:         ENDWITH
450:     ENDPROC
451: 
452:     *==========================================================================
453:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
454:     *==========================================================================
455:         *-- Botoes principais
456:         BINDEVENT(THIS.cmd_4c_Processar,              "Click", THIS, "BtnProcessarClick")
457:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
458: 
459:         *-- Botoes de selecao de grade
460:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "BtnSelecionarTudoClick")
461:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "BtnDesmarcarTudoClick")
462: 
463:         *-- Cliques nos cabecalhos para ordenacao
464:         BINDEVENT(THIS.grd_4c_Selecoes.Column2.Header1, "Click", THIS, "Col2HeaderClick")
465:         BINDEVENT(THIS.grd_4c_Selecoes.Column3.Header1, "Click", THIS, "Col3HeaderClick")
466:         BINDEVENT(THIS.grd_4c_Selecoes.Column4.Header1, "Click", THIS, "Col4HeaderClick")
467:         BINDEVENT(THIS.grd_4c_Selecoes.Column5.Header1, "Click", THIS, "Col5HeaderClick")
468: 
469:         *-- CheckBox de selecao individual: MouseDown + KeyPress
470:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "MouseDown", THIS, "GrdChkMouseDown")
471:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "KeyPress",  THIS, "GrdChkKeyPress")
472:         BINDEVENT(THIS.grd_4c_Selecoes.Column1.ctlCheck1, "Click",     THIS, "GrdChkClick")
473:     ENDPROC
474: 
475:     *==========================================================================
476:     PROTECTED PROCEDURE MontarGrade
477:     *-- Vincula o cursor_4c_Itn ao grid apos BuscarMalas()
478:     *==========================================================================
479:         LOCAL loc_oGrd, loc_oErro
480:         loc_oGrd = .NULL.
481:         TRY
482:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
483:                 loc_oGrd = THIS.grd_4c_Selecoes
484:                 loc_oGrd.RecordSource = ""
485:             ENDIF
486: 
487:             IF USED("cursor_4c_Itn")
488:                 THIS.OrdenarGrade(THIS.this_nOrdemGrade)
489: 
490:                 WITH loc_oGrd
491:                     .RecordSource          = "cursor_4c_Itn"
492:                     .Column1.ControlSource = "cursor_4c_Itn.SelImp"
493:                     .Column2.ControlSource = "cursor_4c_Itn.Codigos"
494:                     .Column3.ControlSource = "cursor_4c_Itn.Descs"
495:                     .Column4.ControlSource = "cursor_4c_Itn.Usuins"
496:                     .Column5.ControlSource = "cursor_4c_Itn.Datins"
497:                     .Column6.ControlSource = "cursor_4c_Itn.Nregis"
498:                 ENDWITH
499: 
500:                 GO TOP IN cursor_4c_Itn
501:             ENDIF
502: 
503:             IF VARTYPE(loc_oGrd) = "O"
504:                 loc_oGrd.Refresh()
505:             ENDIF
506: 
507:         CATCH TO loc_oErro
508:             MsgErro(loc_oErro.Message, "Erro MontarGrade")
509:         ENDTRY
510:     ENDPROC
511: 
512:     *==========================================================================
513:     PROCEDURE OrdenarGrade
514:     *-- Ordena cursor_4c_Itn pela coluna especificada e destaca header
515:     *-- par_nColuna: 2=Codigos 3=Descs 4=UsuIns 5=DatIns
516:     *==========================================================================
517:         LPARAMETERS par_nColuna
518:         LOCAL loc_cTag, loc_nRec, loc_i
519:         loc_cTag = ""
520: 
521:         IF VARTYPE(par_nColuna) = "N"
522:             THIS.this_nOrdemGrade = par_nColuna
523:         ENDIF
524: 
525:         DO CASE
526:             CASE THIS.this_nOrdemGrade = 2
527:                 loc_cTag = "Codigos"
528:             CASE THIS.this_nOrdemGrade = 3
529:                 loc_cTag = "Descs"
530:             CASE THIS.this_nOrdemGrade = 4
531:                 loc_cTag = "Usuins"
532:             CASE THIS.this_nOrdemGrade = 5
533:                 loc_cTag = "Datins"
534:         ENDCASE
535: 
536:         IF USED("cursor_4c_Itn") AND !EMPTY(loc_cTag)
537:             loc_nRec = RECNO("cursor_4c_Itn")
538:             SET ORDER TO TAG (loc_cTag) IN cursor_4c_Itn
539:             IF RECCOUNT("cursor_4c_Itn") > 0
540:                 GO loc_nRec IN cursor_4c_Itn
541:             ENDIF
542:         ENDIF
543: 
544:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
545:             FOR loc_i = 1 TO THIS.grd_4c_Selecoes.ColumnCount
546:                 THIS.grd_4c_Selecoes.Columns(loc_i).Header1.BackColor = ;
547:                     IIF(THIS.this_nOrdemGrade = loc_i, RGB(220, 255, 220), RGB(192, 192, 192))
548:             ENDFOR
549:         ENDIF
550:     ENDPROC
551: 
552:     *==========================================================================
553:     PROTECTED PROCEDURE TornarControlesVisiveis
554:     *==========================================================================
555:         LOCAL loc_i, loc_oControl
556:         FOR loc_i = 1 TO THIS.ControlCount
557:             loc_oControl = THIS.Controls(loc_i)
558:             IF VARTYPE(loc_oControl) = "O"
559:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
560:                     loc_oControl.Visible = .T.
561:                 ENDIF
562:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
563:                     THIS.TornarSubControlesVisiveis(loc_oControl)
564:                 ENDIF
565:             ENDIF
566:         ENDFOR
567:     ENDPROC
568: 
569:     PROTECTED PROCEDURE TornarSubControlesVisiveis
570:         LPARAMETERS par_oContainer
571:         LOCAL loc_i, loc_oControl
572:         FOR loc_i = 1 TO par_oContainer.ControlCount
573:             loc_oControl = par_oContainer.Controls(loc_i)
574:             IF VARTYPE(loc_oControl) = "O"
575:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
576:                     loc_oControl.Visible = .T.
577:                 ENDIF
578:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
579:                     THIS.TornarSubControlesVisiveis(loc_oControl)
580:                 ENDIF
581:             ENDIF
582:         ENDFOR
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * Compatibilidade de pipeline ? OPERACIONAL flat (sem PageFrame/CRUD)
587:     *
588:     * Este form nao segue o padrao Page1=Lista/Page2=Dados.
589:     * Grid e botoes sao criados diretamente via:
590:     *   ConfigurarGrade()    ? grd_4c_Selecoes (6 colunas, checkbox SelImp)
591:     *   ConfigurarBotoes()   ? cmd_4c_Processar + cnt_4c_Saida/cmd_4c_Encerrar
592:     *   ConfigurarBtnGrade() ? cmd_4c_SelTudo + cmd_4c_Apaga
593:     * Todos chamados em InicializarForm().
594:     *==========================================================================
595:     PROTECTED PROCEDURE ConfigurarPageFrame()
596:         *-- OPERACIONAL: sem PageFrame; controles criados diretamente em InicializarForm
597:         RETURN .T.
598:     ENDPROC
599: 
600:     PROTECTED PROCEDURE ConfigurarPaginaLista()
601:         *-- OPERACIONAL: grid ja configurado por ConfigurarGrade() em InicializarForm()
602:         *-- Refrescar grade caso chamado pelo pipeline apos carga inicial
603:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5) AND USED("cursor_4c_Itn")
604:             THIS.grd_4c_Selecoes.Refresh()
605:         ENDIF
606:     ENDPROC
607: 
608:     PROTECTED PROCEDURE ConfigurarPaginaDados()
609:         *-- OPERACIONAL: sem pagina de dados separada; grade gerenciada por ConfigurarGrade()
610:         RETURN .T.
611:     ENDPROC
612: 
613:     PROCEDURE AlternarPagina(par_nPagina)
614:         *-- OPERACIONAL: nao ha troca de pagina; apenas refresca a grade
615:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
616:             THIS.grd_4c_Selecoes.Refresh()
617:         ENDIF
618:     ENDPROC
619: 
620:     *==========================================================================
621:     PROCEDURE Destroy
622:     *==========================================================================
623:         IF USED("cursor_4c_Itn")
624:             USE IN cursor_4c_Itn
625:         ENDIF
626:         DODEFAULT()
627:     ENDPROC
628: 
629:     *==========================================================================
630:     * Handlers de eventos - PUBLIC (obrigatorio para BINDEVENT)
631:     *==========================================================================
632: 
633:     PROCEDURE BtnProcessarClick()
634:         LOCAL loc_cNome, loc_lOk, loc_nSelecionadas, loc_oErro
635:         loc_lOk = .F.
636:         loc_cNome = ""
637: 
638:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
639:             THIS.cmd_4c_Processar.Enabled = .F.
640:         ENDIF
641: 
642:         TRY
643:             IF !USED("cursor_4c_Itn")
644:                 MsgAviso("Nenhuma mala direta carregada.", "Processar")
645:             ELSE
646:                 *-- GO TOP + refresh antes de verificar selecao (comportamento original)
647:                 GO TOP IN cursor_4c_Itn
648:                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
649:                     THIS.grd_4c_Selecoes.Refresh()
650:                 ENDIF
651: 
652:                 *-- Verificar se ha malas com registros selecionadas
653:                 SELECT COUNT(*) AS nSel FROM cursor_4c_Itn ;
654:                     WHERE SelImp = 1 INTO CURSOR cursor_4c_TmpSel
655:                 loc_nSelecionadas = 0
656:                 IF USED("cursor_4c_TmpSel")
657:                     loc_nSelecionadas = NVL(cursor_4c_TmpSel.nSel, 0)
658:                     USE IN cursor_4c_TmpSel
659:                 ENDIF
660: 
661:                 IF loc_nSelecionadas < 1
662:                     MsgAviso("Nenhuma Mala Direta com registros foi selecionada para unifica" + ;
663:                              CHR(231) + CHR(227) + "o.", "Processar")
664:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
665:                         THIS.grd_4c_Selecoes.SetFocus()
666:                     ENDIF
667:                 ELSE
668:                     IF loc_nSelecionadas = 1
669:                     MsgAviso("Apenas uma Mala Direta com registros foi selecionada." + CHR(13) + ;
670:                              "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel unificar apenas uma." + CHR(13) + ;
671:                              "Selecione ao menos duas Malas Diretas.", "Processar")
672:                     IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
673:                         THIS.grd_4c_Selecoes.SetFocus()
674:                     ENDIF
675:                 ELSE
676:                     IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
677:                         loc_cNome = ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
678:                     ENDIF
679: 
680:                     IF EMPTY(loc_cNome)
681:                         MsgAviso("Nome da Unifica" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido." + CHR(13) + ;
682:                                  "Este " + CHR(233) + " o nome que ser" + CHR(225) + " utilizado na unifica" + ;
683:                                  CHR(231) + CHR(227) + "o gerada.", "Processar")
684:                         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
685:                             THIS.cnt_4c_Nova.txt_4c_GetNova.SetFocus()
686:                         ENDIF
687:                     ELSE
688:                         IF MsgConfirma("Confirma a Unifica" + CHR(231) + CHR(227) + "o das Malas Diretas?")
689:                             loc_lOk = THIS.this_oBusinessObject.ProcessarUnificacao(loc_cNome)
690:                             IF loc_lOk
691:                                 THIS.MontarGrade()
692:                                 IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
693:                                     THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
694:                                 ENDIF
695:                                 IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
696:                                     THIS.grd_4c_Selecoes.SetFocus()
697:                                 ENDIF
698:                             ENDIF
699:                         ENDIF
700:                     ENDIF
701:                     ENDIF
702:                 ENDIF
703:             ENDIF
704: 
705:         CATCH TO loc_oErro
706:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
707:         ENDTRY
708: 
709:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
710:             THIS.cmd_4c_Processar.Enabled = .T.
711:         ENDIF
712:     ENDPROC
713: 
714:     PROCEDURE BtnEncerrarClick()
715:         THIS.Release()
716:     ENDPROC
717: 
718:     PROCEDURE BtnSelecionarTudoClick()
719:         IF USED("cursor_4c_Itn")
720:             REPLACE ALL SelImp WITH 1 IN cursor_4c_Itn
721:         ENDIF
722:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
723:             THIS.grd_4c_Selecoes.Refresh()
724:         ENDIF
725:     ENDPROC
726: 
727:     PROCEDURE BtnDesmarcarTudoClick()
728:         IF USED("cursor_4c_Itn")
729:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
730:         ENDIF
731:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
732:             THIS.grd_4c_Selecoes.Refresh()
733:         ENDIF
734:     ENDPROC
735: 
736:     PROCEDURE Col2HeaderClick()
737:         THIS.OrdenarGrade(2)
738:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
739:             THIS.grd_4c_Selecoes.Refresh()
740:         ENDIF
741:     ENDPROC
742: 
743:     PROCEDURE Col3HeaderClick()
744:         THIS.OrdenarGrade(3)
745:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
746:             THIS.grd_4c_Selecoes.Refresh()
747:         ENDIF
748:     ENDPROC
749: 
750:     PROCEDURE Col4HeaderClick()
751:         THIS.OrdenarGrade(4)
752:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
753:             THIS.grd_4c_Selecoes.Refresh()
754:         ENDIF
755:     ENDPROC
756: 
757:     PROCEDURE Col5HeaderClick()
758:         THIS.OrdenarGrade(5)
759:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
760:             THIS.grd_4c_Selecoes.Refresh()
761:         ENDIF
762:     ENDPROC
763: 
764:     *-- MouseDown: toggle SelImp do registro corrente (equivale ao CheckBox original)
765:     PROCEDURE GrdChkMouseDown
766:         LPARAMETERS par_nButton, par_nShift, par_nXCoord, par_nYCoord
767:         LOCAL loc_nSel
768:         IF USED("cursor_4c_Itn")
769:             loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
770:             SELECT cursor_4c_Itn
771:             REPLACE SelImp WITH loc_nSel
772:         ENDIF
773:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
774:             THIS.grd_4c_Selecoes.Refresh()
775:         ENDIF
776:         NODEFAULT
777:     ENDPROC
778: 
779:     *-- KeyPress: toggle SelImp com Enter (13) ou Space (32)
780:     PROCEDURE GrdChkKeyPress
781:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
782:         LOCAL loc_nSel
783:         IF INLIST(par_nKeyCode, 13, 32)
784:             IF USED("cursor_4c_Itn")
785:                 loc_nSel = IIF(cursor_4c_Itn.SelImp = 1, 0, 1)
786:                 SELECT cursor_4c_Itn
787:                 REPLACE SelImp WITH loc_nSel
788:             ENDIF
789:             IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
790:                 THIS.grd_4c_Selecoes.Refresh()
791:             ENDIF
792:             NODEFAULT
793:         ENDIF
794:     ENDPROC
795: 
796:     *-- Click: absorver para nao disparar duplo-toggle com MouseDown
797:     PROCEDURE GrdChkClick()
798:         NODEFAULT
799:     ENDPROC
800: 
801:     *==========================================================================
802:     * Contratos de pipeline ? nao aplicaveis a este form OPERACIONAL
803:     * (nao ha Page1=Lista/Page2=Dados nem botoes CRUD; acao principal = BtnProcessarClick)
804:     *==========================================================================
805:     PROCEDURE BtnIncluirClick()
806:         RETURN .F.
807:     ENDPROC
808: 
809:     PROCEDURE BtnAlterarClick()
810:         RETURN .F.
811:     ENDPROC
812: 
813:     PROCEDURE BtnExcluirClick()
814:         RETURN .F.
815:     ENDPROC
816: 
817:     PROCEDURE BtnVisualizarClick()
818:         RETURN .F.
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * CarregarLista - recarrega grade do servidor (contrato de pipeline)
823:     *==========================================================================
824:     PROCEDURE CarregarLista()
825:         LOCAL loc_lSucesso
826:         loc_lSucesso = .F.
827:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
828:             loc_lSucesso = THIS.this_oBusinessObject.BuscarMalas()
829:             IF loc_lSucesso
830:                 THIS.MontarGrade()
831:             ENDIF
832:         ENDIF
833:         RETURN loc_lSucesso
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * FormParaBO - mapeia campo "Nome da Unificacao" para o BO
838:     * (unico campo editavel pelo usuario neste form OPERACIONAL)
839:     *==========================================================================
840:     PROCEDURE FormParaBO()
841:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
842:             IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
843:                 THIS.this_oBusinessObject.this_cDescs = ;
844:                     ALLTRIM(THIS.cnt_4c_Nova.txt_4c_GetNova.Value)
845:             ENDIF
846:         ENDIF
847:         RETURN .T.
848:     ENDPROC
849: 
850:     *==========================================================================
851:     * BOParaForm - popula campo "Nome da Unificacao" a partir do BO
852:     *==========================================================================
853:     PROCEDURE BOParaForm()
854:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
855:             IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
856:                 THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ;
857:                     THIS.this_oBusinessObject.this_cDescs
858:             ENDIF
859:         ENDIF
860:         RETURN .T.
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * HabilitarCampos - habilita/desabilita controles editaveis
865:     *==========================================================================
866:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
867:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
868:             THIS.cnt_4c_Nova.txt_4c_GetNova.Enabled = par_lHabilitar
869:         ENDIF
870:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
871:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
872:         ENDIF
873:     ENDPROC
874: 
875:     *==========================================================================
876:     * LimparCampos - limpa campo nome e desmarca todas as selecoes da grade
877:     *==========================================================================
878:     PROTECTED PROCEDURE LimparCampos()
879:         IF PEMSTATUS(THIS, "cnt_4c_Nova", 5)
880:             THIS.cnt_4c_Nova.txt_4c_GetNova.Value = ""
881:         ENDIF
882:         IF USED("cursor_4c_Itn")
883:             REPLACE ALL SelImp WITH 0 IN cursor_4c_Itn
884:         ENDIF
885:         IF PEMSTATUS(THIS, "grd_4c_Selecoes", 5)
886:             THIS.grd_4c_Selecoes.Refresh()
887:         ENDIF
888:     ENDPROC
889: 
890:     *==========================================================================
891:     * AjustarBotoesPorModo - sem modo CRUD neste form OPERACIONAL
892:     *==========================================================================
893:     PROTECTED PROCEDURE AjustarBotoesPorModo()
894:         *-- OPERACIONAL: habilita Processar somente se BO inicializado
895:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
896:             THIS.cmd_4c_Processar.Enabled = (VARTYPE(THIS.this_oBusinessObject) = "O")
897:         ENDIF
898:     ENDPROC
899: 
900:     *==========================================================================
901:     * BtnBuscarClick - recarrega a lista de malas diretas do servidor
902:     *==========================================================================
903:     PROCEDURE BtnBuscarClick()
904:         THIS.CarregarLista()
905:     ENDPROC
906: 
907:     *==========================================================================
908:     * BtnSalvarClick - nao aplicavel (salvar ocorre via BtnProcessarClick)
909:     *==========================================================================
910:     PROCEDURE BtnSalvarClick()
911:         RETURN .F.
912:     ENDPROC
913: 
914:     *==========================================================================
915:     * BtnCancelarClick - limpa selecoes e campo nome
916:     *==========================================================================
917:     PROCEDURE BtnCancelarClick()
918:         THIS.LimparCampos()
919:     ENDPROC
920: 
921: ENDDEFINE


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

