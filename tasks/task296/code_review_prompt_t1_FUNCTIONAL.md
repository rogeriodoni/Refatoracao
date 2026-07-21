# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRHPR): Top original=396 vs migrado 'lbl_4c_Label11' Top=451 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRHPR): Left original=197 vs migrado 'lbl_4c_Label11' Left=557 (diff=360px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1183 linhas total):

*-- Linhas 32 a 154:
32:     this_lEhPeso         = .F.
33: 
34:     *--------------------------------------------------------------------------
35:     PROCEDURE Init
36:     *--------------------------------------------------------------------------
37:     LPARAMETERS par_oParentForm, par_dDataIni, par_dDataFim, par_cCdGrupo, par_cCdConta, par_cCdProduto, par_cDsProduto
38:         THIS.Caption = "Hist" + CHR(243) + "rico de Produtos"
39:         IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) == "O"
40:             THIS.this_oParentForm = par_oParentForm
41:         ENDIF
42:         IF PCOUNT() >= 2 AND VARTYPE(par_dDataIni) == "D"
43:             THIS.this_dDataIni = par_dDataIni
44:         ENDIF
45:         IF PCOUNT() >= 3 AND VARTYPE(par_dDataFim) == "D"
46:             THIS.this_dDataFim = par_dDataFim
47:         ENDIF
48:         IF PCOUNT() >= 4 AND VARTYPE(par_cCdGrupo) == "C"
49:             THIS.this_cCdGrupo = par_cCdGrupo
50:         ENDIF
51:         IF PCOUNT() >= 5 AND VARTYPE(par_cCdConta) == "C"
52:             THIS.this_cCdConta = par_cCdConta
53:         ENDIF
54:         IF PCOUNT() >= 6 AND VARTYPE(par_cCdProduto) == "C"
55:             THIS.this_cCdProduto = par_cCdProduto
56:         ENDIF
57:         IF PCOUNT() >= 7 AND VARTYPE(par_cDsProduto) == "C"
58:             THIS.this_cDsProduto = par_cDsProduto
59:         ENDIF
60:         RETURN DODEFAULT()
61:     ENDPROC
62: 
63:     *--------------------------------------------------------------------------
64:     PROTECTED PROCEDURE InicializarForm
65:     *--------------------------------------------------------------------------
66:         LOCAL loc_lSucesso
67:         loc_lSucesso = .F.
68:         TRY
69:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrHprBO")
70:             THIS.this_oBusinessObject.this_dDataIni   = THIS.this_dDataIni
71:             THIS.this_oBusinessObject.this_dDataFim   = THIS.this_dDataFim
72:             THIS.this_oBusinessObject.this_cCdGrupo   = THIS.this_cCdGrupo
73:             THIS.this_oBusinessObject.this_cCdConta   = THIS.this_cCdConta
74:             THIS.this_oBusinessObject.this_cCdProduto = THIS.this_cCdProduto
75:             THIS.this_oBusinessObject.this_cDsProduto = THIS.this_cDsProduto
76: 
77:             THIS.ConfigurarPageFrame()
78:             THIS.ConfigurarCabecalho()
79:             THIS.ConfigurarContainersVisuais()
80:             THIS.ConfigurarBotoesTopo()
81:             THIS.ConfigurarCamposFiltroData()
82:             THIS.ConfigurarPaginaLista()
83:             THIS.ConfigurarPaginaDados()
84:             THIS.TornarControlesVisiveis(THIS)
85:             THIS.txt_4c_Data.Visible        = .F.
86:             THIS.lbl_4c_DataLabel.Visible   = .F.
87:             THIS.chk_4c_ChkAuditado.Visible = .F.
88:             THIS.ConfigurarEventos()
89: 
90:             IF !(VARTYPE(gb_4c_ValidandoUI) == "L" AND gb_4c_ValidandoUI)
91:                 THIS.CarregarDados()
92:             ENDIF
93: 
94:             loc_lSucesso = .T.
95:         CATCH TO loc_oErro
96:             MsgErro(loc_oErro.Message, "Erro ao inicializar")
97:         ENDTRY
98:         RETURN loc_lSucesso
99:     ENDPROC
100: 
101:     *--------------------------------------------------------------------------
102:     * ConfigurarPageFrame - Layout OPERACIONAL flat: sem PageFrame.
103:     * Controles sao filhos diretos do form (grd_4c_Historico, grd_4c_Subniveis,
104:     * containers e textboxes). Metodo mantido para simetria com o pipeline.
105:     *--------------------------------------------------------------------------
106:     PROTECTED PROCEDURE ConfigurarPageFrame
107:         THIS.BackColor = RGB(236, 233, 216)
108:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
109:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
110:         ENDIF
111:     ENDPROC
112: 
113:     *--------------------------------------------------------------------------
114:     PROTECTED PROCEDURE ConfigurarCabecalho
115:     *--------------------------------------------------------------------------
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH THIS.cnt_4c_Cabecalho
118:             .Top       = 0
119:             .Left      = 0
120:             .Width     = THIS.Width
121:             .Height    = 80
122:             .BackColor = RGB(100, 100, 100)
123:             .BackStyle = 1
124:             .Visible   = .T.
125:             .AddObject("lbl_4c_Sombra", "Label")
126:             WITH .lbl_4c_Sombra
127:                 .Top       = 18
128:                 .Left      = 10
129:                 .Width     = THIS.Width
130:                 .Height    = 40
131:                 .AutoSize  = .F.
132:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 18
135:                 .FontBold  = .T.
136:                 .WordWrap  = .T.
137:                 .Alignment = 0
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .Visible   = .T.
141:             ENDWITH
142:             .AddObject("lbl_4c_Titulo", "Label")
143:             WITH .lbl_4c_Titulo
144:                 .Top       = 17
145:                 .Left      = 10
146:                 .Width     = THIS.Width
147:                 .Height    = 46
148:                 .AutoSize  = .F.
149:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 18
152:                 .FontBold  = .T.
153:                 .WordWrap  = .T.
154:                 .Alignment = 0

*-- Linhas 160 a 228:
160:     ENDPROC
161: 
162:     *--------------------------------------------------------------------------
163:     PROTECTED PROCEDURE ConfigurarContainersVisuais
164:     *--------------------------------------------------------------------------
165:         THIS.AddObject("cnt_4c_Origem", "Container")
166:         WITH THIS.cnt_4c_Origem
167:             .Top       = 426
168:             .Left      = 7
169:             .Width     = 478
170:             .Height    = 74
171:             .BackColor = RGB(255, 255, 255)
172:             .BackStyle = 1
173:             .Visible   = .T.
174:         ENDWITH
175:         THIS.AddObject("cnt_4c_Destino", "Container")
176:         WITH THIS.cnt_4c_Destino
177:             .Top       = 426
178:             .Left      = 504
179:             .Width     = 478
180:             .Height    = 74
181:             .BackColor = RGB(255, 255, 255)
182:             .BackStyle = 1
183:             .Visible   = .T.
184:         ENDWITH
185:     ENDPROC
186: 
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarBotoesTopo
189:     *--------------------------------------------------------------------------
190:         THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
191:         WITH THIS.chk_4c_ChkAuditado
192:             .Top             = 3
193:             .Left            = 700
194:             .Width           = 75
195:             .Height          = 75
196:             .Caption         = "Auditado"
197:             .Alignment       = 0
198:             .Style           = 1
199:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
200:             .PicturePosition = 13
201:             .WordWrap        = .T.
202:             .FontName        = "Comic Sans MS"
203:             .FontBold        = .T.
204:             .FontItalic      = .T.
205:             .FontSize        = 8
206:             .ForeColor       = RGB(90, 90, 90)
207:             .BackColor       = RGB(255, 255, 255)
208:             .Themes          = .F.
209:             .BackStyle       = 0
210:             .SpecialEffect   = 0
211:             .Visible         = .T.
212:         ENDWITH
213:         THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
214:         WITH THIS.cmd_4c_BtnDocumento
215:             .Top             = 3
216:             .Left            = 775
217:             .Width           = 75
218:             .Height          = 75
219:             .Caption         = "Movimento"
220:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
221:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
222:             .PicturePosition = 13
223:             .WordWrap        = .T.
224:             .FontName        = "Comic Sans MS"
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .FontSize        = 8
228:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 276 a 358:
276:     ENDPROC
277: 
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarCamposFiltroData
280:     *--------------------------------------------------------------------------
281:         THIS.AddObject("lbl_4c_DataLabel", "Label")
282:         WITH THIS.lbl_4c_DataLabel
283:             .Top      = 102
284:             .Left     = 441
285:             .AutoSize = .T.
286:             .Caption  = "Data:"
287:             .FontBold = .T.
288:             .Visible  = .F.
289:         ENDWITH
290:         THIS.AddObject("txt_4c_Data", "TextBox")
291:         WITH THIS.txt_4c_Data
292:             .Top       = 98
293:             .Left      = 478
294:             .Width     = 80
295:             .Height    = 23
296:             .Alignment = 3
297:             .MaxLength = 10
298:             .Visible   = .F.
299:         ENDWITH
300:     ENDPROC
301: 
302:     *--------------------------------------------------------------------------
303:     PROTECTED PROCEDURE ConfigurarLabelProduto
304:     *--------------------------------------------------------------------------
305:         THIS.AddObject("lbl_4c_LabelProduto", "Label")
306:         WITH THIS.lbl_4c_LabelProduto
307:             .Top       = 130
308:             .Left      = 15
309:             .AutoSize  = .T.
310:             .FontBold  = .T.
311:             .ForeColor = RGB(90, 90, 90)
312:             .Caption   = ""
313:             .Visible   = .T.
314:         ENDWITH
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE ConfigurarGrdHistorico
319:     *--------------------------------------------------------------------------
320:         THIS.AddObject("grd_4c_Historico", "GridBase")
321:         WITH THIS.grd_4c_Historico
322:             .Top          = 148
323:             .Left         = 4
324:             .Width        = 730
325:             .Height       = 238
326:             .ColumnCount  = 9
327:             .RecordSource = "cursor_4c_Historico"
328:             .ReadOnly     = .T.
329:             .DeleteMark   = .F.
330:             .RecordMark   = .F.
331:             .FontName     = "Courier New"
332:             .FontSize     = 9
333:             .Visible      = .T.
334:             WITH .Column1
335:                 .Width            = 86
336:                 .ControlSource    = "cursor_4c_Historico.datas"
337:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
338:                 .Header1.Caption  = "Data"
339:             ENDWITH
340:             WITH .Column2
341:                 .Width            = 57
342:                 .ControlSource    = "cursor_4c_Historico.numes"
343:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
344:                 .Header1.Caption  = "C" + CHR(243) + "digo"
345:             ENDWITH
346:             WITH .Column3
347:                 .Width            = 161
348:                 .ControlSource    = "cursor_4c_Historico.dopes"
349:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
350:                 .Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
351:             ENDWITH
352:             WITH .Column4
353:                 .Width            = 31
354:                 .ControlSource    = "cursor_4c_Historico.cunis"
355:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
356:                 .Header1.Caption  = "Un."
357:             ENDWITH
358:             WITH .Column5

*-- Linhas 395 a 482:
395:     ENDPROC
396: 
397:     *--------------------------------------------------------------------------
398:     PROTECTED PROCEDURE ConfigurarGrdSubniveis
399:     *--------------------------------------------------------------------------
400:         THIS.AddObject("lbl_4c_Label3", "Label")
401:         WITH THIS.lbl_4c_Label3
402:             .Top      = 130
403:             .Left     = 747
404:             .AutoSize = .T.
405:             .Caption  = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
406:             .FontBold = .T.
407:             .Visible  = .T.
408:         ENDWITH
409:         THIS.AddObject("grd_4c_Subniveis", "GridBase")
410:         WITH THIS.grd_4c_Subniveis
411:             .Top          = 148
412:             .Left         = 738
413:             .Width        = 261
414:             .Height       = 238
415:             .ColumnCount  = 3
416:             .RecordSource = "cursor_4c_Subniveis"
417:             .ReadOnly     = .T.
418:             .DeleteMark   = .F.
419:             .RecordMark   = .F.
420:             .FontName     = "Courier New"
421:             .FontSize     = 9
422:             .Visible      = .T.
423:             WITH .Column1
424:                 .Width           = 31
425:                 .ControlSource   = "cursor_4c_Subniveis.emps"
426:                 .Header1.Caption = "Emp"
427:             ENDWITH
428:             WITH .Column2
429:                 .Width           = 156
430:                 .ControlSource   = "cursor_4c_Subniveis.dopes"
431:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
432:             ENDWITH
433:             WITH .Column3
434:                 .Width           = 51
435:                 .ControlSource   = "cursor_4c_Subniveis.numes"
436:                 .Header1.Caption = "C" + CHR(243) + "digo"
437:             ENDWITH
438:         ENDWITH
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     PROTECTED PROCEDURE ConfigurarAreaInfo
443:     *--------------------------------------------------------------------------
444:         THIS.AddObject("lbl_4c_Label2", "Label")
445:         WITH THIS.lbl_4c_Label2
446:             .Top      = 396
447:             .Left     = 27
448:             .AutoSize = .T.
449:             .Caption  = "Documento:"
450:             .FontBold = .T.
451:             .Visible  = .T.
452:         ENDWITH
453:         THIS.AddObject("txt_4c_Nota", "TextBox")
454:         WITH THIS.txt_4c_Nota
455:             .Top           = 392
456:             .Left          = 102
457:             .Width         = 80
458:             .Height        = 23
459:             .ReadOnly      = .T.
460:             .SpecialEffect = 1
461:             .Visible       = .T.
462:         ENDWITH
463:         THIS.AddObject("lbl_4c_Label1", "Label")
464:         WITH THIS.lbl_4c_Label1
465:             .Top      = 396
466:             .Left     = 197
467:             .AutoSize = .T.
468:             .Caption  = "Usu" + CHR(225) + "rio:"
469:             .FontBold = .T.
470:             .Visible  = .T.
471:         ENDWITH
472:         THIS.AddObject("txt_4c_Usuario", "TextBox")
473:         WITH THIS.txt_4c_Usuario
474:             .Top           = 392
475:             .Left          = 250
476:             .Width         = 96
477:             .Height        = 23
478:             .ReadOnly      = .T.
479:             .SpecialEffect = 1
480:             .Visible       = .T.
481:         ENDWITH
482:         THIS.AddObject("lbl_4c_Auditoria", "Label")

*-- Linhas 520 a 563:
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     PROTECTED PROCEDURE ConfigurarLabelsAreaContas
524:     *--------------------------------------------------------------------------
525:         THIS.AddObject("lbl_4c_Label7", "Label")
526:         WITH THIS.lbl_4c_Label7
527:             .Top      = 428
528:             .Left     = 17
529:             .AutoSize = .T.
530:             .Caption  = "Origem"
531:             .FontBold = .T.
532:             .Visible  = .T.
533:         ENDWITH
534:         THIS.AddObject("lin_4c_Line1", "Line")
535:         WITH THIS.lin_4c_Line1
536:             .Top         = 442
537:             .Left        = 18
538:             .Width       = 340
539:             .Height      = 0
540:             .BorderWidth = 2
541:             .BorderColor = RGB(90, 90, 90)
542:             .Visible     = .T.
543:         ENDWITH
544:         THIS.AddObject("lbl_4c_Label9", "Label")
545:         WITH THIS.lbl_4c_Label9
546:             .Top      = 451
547:             .Left     = 62
548:             .AutoSize = .T.
549:             .Caption  = "Grupo:"
550:             .FontBold = .T.
551:             .Visible  = .T.
552:         ENDWITH
553:         THIS.AddObject("lbl_4c_Label10", "Label")
554:         WITH THIS.lbl_4c_Label10
555:             .Top      = 475
556:             .Left     = 63
557:             .AutoSize = .T.
558:             .Caption  = "Conta:"
559:             .FontBold = .T.
560:             .Visible  = .T.
561:         ENDWITH
562:         THIS.AddObject("lbl_4c_Label8", "Label")
563:         WITH THIS.lbl_4c_Label8

*-- Linhas 608 a 651:
608:     ENDPROC
609: 
610:     *--------------------------------------------------------------------------
611:     PROTECTED PROCEDURE ConfigurarCamposAreaContas
612:     *--------------------------------------------------------------------------
613:         THIS.AddObject("txt_4c_GruOri", "TextBox")
614:         WITH THIS.txt_4c_GruOri
615:             .Top           = 447
616:             .Left          = 106
617:             .Width         = 80
618:             .Height        = 23
619:             .ReadOnly      = .T.
620:             .SpecialEffect = 1
621:             .Visible       = .T.
622:         ENDWITH
623:         THIS.AddObject("txt_4c_DesGruOri", "TextBox")
624:         WITH THIS.txt_4c_DesGruOri
625:             .Top           = 447
626:             .Left          = 187
627:             .Width         = 290
628:             .Height        = 23
629:             .ReadOnly      = .T.
630:             .SpecialEffect = 1
631:             .Visible       = .T.
632:         ENDWITH
633:         THIS.AddObject("txt_4c_ConOri", "TextBox")
634:         WITH THIS.txt_4c_ConOri
635:             .Top           = 471
636:             .Left          = 106
637:             .Width         = 80
638:             .Height        = 23
639:             .ReadOnly      = .T.
640:             .SpecialEffect = 1
641:             .Visible       = .T.
642:         ENDWITH
643:         THIS.AddObject("txt_4c_DesConOri", "TextBox")
644:         WITH THIS.txt_4c_DesConOri
645:             .Top           = 471
646:             .Left          = 187
647:             .Width         = 290
648:             .Height        = 23
649:             .ReadOnly      = .T.
650:             .SpecialEffect = 1
651:             .Visible       = .T.

*-- Linhas 693 a 831:
693:     ENDPROC
694: 
695:     *--------------------------------------------------------------------------
696:     PROTECTED PROCEDURE ConfigurarAreaObs
697:     *--------------------------------------------------------------------------
698:         THIS.AddObject("obj_4c_Obs", "EditBox")
699:         WITH THIS.obj_4c_Obs
700:             .Top           = 514
701:             .Left          = 106
702:             .Width         = 875
703:             .Height        = 55
704:             .ReadOnly      = .T.
705:             .SpecialEffect = 1
706:             .Visible       = .T.
707:         ENDWITH
708:     ENDPROC
709: 
710:     *--------------------------------------------------------------------------
711:     PROTECTED PROCEDURE ConfigurarPaginaLista
712:     *-- Configura a area principal: label produto + grid historico + grid subniveis
713:     *--------------------------------------------------------------------------
714:         THIS.ConfigurarLabelProduto()
715:         THIS.ConfigurarGrdHistorico()
716:         THIS.ConfigurarGrdSubniveis()
717:     ENDPROC
718: 
719:     *--------------------------------------------------------------------------
720:     PROTECTED PROCEDURE ConfigurarPaginaDados
721:     *-- Configura secao inferior (equivalente a Page2 em CRUD):
722:     *-- area de informacoes, labels de contas, campos de contas e observacao
723:     *--------------------------------------------------------------------------
724:         THIS.ConfigurarAreaInfo()
725:         THIS.ConfigurarLabelsAreaContas()
726:         THIS.ConfigurarCamposAreaContas()
727:         THIS.ConfigurarAreaObs()
728:     ENDPROC
729: 
730:     *--------------------------------------------------------------------------
731:     PROCEDURE AlternarPagina
732:     *-- Form OPERACIONAL flat sem PageFrame: metodo mantido por simetria com pipeline
733:     *--------------------------------------------------------------------------
734:     LPARAMETERS par_nPagina
735:     ENDPROC
736: 
737:     *--------------------------------------------------------------------------
738:     PROTECTED PROCEDURE TornarControlesVisiveis
739:     *--------------------------------------------------------------------------
740:     LPARAMETERS par_oContainer
741:         LOCAL loc_nI, loc_oControl
742:         FOR loc_nI = 1 TO par_oContainer.ControlCount
743:             loc_oControl = par_oContainer.Controls(loc_nI)
744:             IF INLIST(loc_oControl.BaseClass, "Container", "PageFrame", "Page")
745:                 THIS.TornarControlesVisiveis(loc_oControl)
746:             ENDIF
747:             IF INLIST(loc_oControl.BaseClass, "Grid", "Column", "Header", "Line")
748:                 LOOP
749:             ENDIF
750:             loc_oControl.Visible = .T.
751:         NEXT
752:     ENDPROC
753: 
754:     *--------------------------------------------------------------------------
755:     PROTECTED PROCEDURE ConfigurarEventos
756:     *--------------------------------------------------------------------------
757:         BINDEVENT(THIS.grd_4c_Historico,              "AfterRowColChange", THIS, "GrdHistoricoAfterRowColChange")
758:         BINDEVENT(THIS.chk_4c_ChkAuditado,            "Click",             THIS, "ChkAuditadoClick")
759:         BINDEVENT(THIS.cmd_4c_Procurar,               "Click",             THIS, "CmdProcurarClick")
760:         BINDEVENT(THIS.cmd_4c_BtnDocumento,           "Click",             THIS, "CmdMovimentoClick")
761:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",          THIS, "TxtDataKeyPress")
762:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",         THIS, "TxtDataLostFocus")
763:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click",             THIS, "CmdEncerrarClick")
764:     ENDPROC
765: 
766:     *--------------------------------------------------------------------------
767:     PROTECTED PROCEDURE CarregarDados
768:     *-- CarregarHistorico ja chama CarregarDadosProduto internamente
769:     *--------------------------------------------------------------------------
770:         LOCAL loc_lSucesso
771:         loc_lSucesso = .F.
772:         TRY
773:             THIS.this_oBusinessObject.CarregarHistorico()
774:             THIS.this_lEhPeso = THIS.this_oBusinessObject.this_lEhPeso
775:             THIS.grd_4c_Historico.Column8.Visible = THIS.this_lEhPeso
776:             THIS.grd_4c_Historico.Column9.Visible = THIS.this_lEhPeso
777:             THIS.lbl_4c_LabelProduto.Caption = THIS.this_cDsProduto
778:             IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
779:                 SELECT cursor_4c_Historico
780:                 GO BOTTOM
781:                 THIS.AtualizarCamposLinha()
782:             ENDIF
783:             THIS.grd_4c_Historico.Refresh()
784:             loc_lSucesso = .T.
785:         CATCH TO loc_oErro
786:             MsgErro(loc_oErro.Message, "Erro ao carregar dados")
787:         ENDTRY
788:     ENDPROC
789: 
790:     *--------------------------------------------------------------------------
791:     PROCEDURE AtualizarCamposLinha
792:     *--------------------------------------------------------------------------
793:         LOCAL loc_lSucesso
794:         loc_lSucesso = .F.
795:         IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
796:             RETURN
797:         ENDIF
798:         IF BOF("cursor_4c_Historico") OR EOF("cursor_4c_Historico")
799:             RETURN
800:         ENDIF
801:         TRY
802:             THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
803:             THIS.this_oBusinessObject.CarregarDocumento()
804:             THIS.this_oBusinessObject.CarregarDescricoesContabil()
805:             THIS.this_oBusinessObject.CarregarSubniveis()
806: 
807:             THIS.txt_4c_Auditors.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
808:             IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
809:                 THIS.txt_4c_DtAudits.Value = ""
810:             ELSE
811:                 THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
812:             ENDIF
813:             THIS.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
814:             THIS.txt_4c_Nota.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cNotas)
815:             THIS.txt_4c_GruOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOri)
816:             THIS.txt_4c_DesGruOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoOri)
817:             THIS.txt_4c_ConOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOri)
818:             THIS.txt_4c_DesConOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaOri)
819:             THIS.txt_4c_GruDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDes)
820:             THIS.txt_4c_DesGruDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoDes)
821:             THIS.txt_4c_ConDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDes)
822:             THIS.txt_4c_DesConDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaDes)
823:             THIS.obj_4c_Obs.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cObs)
824: 
825:             THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
826:             THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
827:             IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
828:                 THIS.chk_4c_ChkAuditado.Visible = .T.
829:             ELSE
830:                 THIS.chk_4c_ChkAuditado.Visible = .F.
831:             ENDIF

*-- Linhas 838 a 1183:
838:     ENDPROC
839: 
840:     *--------------------------------------------------------------------------
841:     PROCEDURE GrdHistoricoAfterRowColChange
842:     *--------------------------------------------------------------------------
843:     LPARAMETERS par_nColIndex
844:         THIS.AtualizarCamposLinha()
845:     ENDPROC
846: 
847:     *--------------------------------------------------------------------------
848:     PROCEDURE ChkAuditadoClick
849:     *--------------------------------------------------------------------------
850:         LOCAL loc_lSucesso, loc_lBOResult
851:         loc_lSucesso  = .F.
852:         loc_lBOResult = .F.
853:         TRY
854:             IF THIS.chk_4c_ChkAuditado.Value = 1
855:                 loc_lBOResult = THIS.this_oBusinessObject.AuditarRegistro()
856:             ELSE
857:                 loc_lBOResult = THIS.this_oBusinessObject.DesauditarRegistro()
858:             ENDIF
859:             IF loc_lBOResult
860:                 THIS.txt_4c_Auditors.Value = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
861:                 IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
862:                     THIS.txt_4c_DtAudits.Value = ""
863:                 ELSE
864:                     THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
865:                 ENDIF
866:                 THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
867:                 THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
868:                 THIS.grd_4c_Historico.Refresh()
869:             ENDIF
870:             loc_lSucesso = .T.
871:         CATCH TO loc_oErro
872:             MsgErro(loc_oErro.Message, "Erro ao auditar registro")
873:         ENDTRY
874:     ENDPROC
875: 
876:     *--------------------------------------------------------------------------
877:     PROCEDURE CmdProcurarClick
878:     *--------------------------------------------------------------------------
879:         THIS.lbl_4c_DataLabel.Visible = .T.
880:         THIS.txt_4c_Data.Visible      = .T.
881:         THIS.txt_4c_Data.Value        = DATE()
882:         THIS.txt_4c_Data.SetFocus()
883:     ENDPROC
884: 
885:     *--------------------------------------------------------------------------
886:     PROCEDURE TxtDataKeyPress
887:     *--------------------------------------------------------------------------
888:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
889:         LOCAL loc_dData
890:         IF !INLIST(par_nKeyCode, 13, 9)
891:             RETURN
892:         ENDIF
893:         loc_dData = THIS.txt_4c_Data.Value
894:         THIS.txt_4c_Data.Visible      = .F.
895:         THIS.lbl_4c_DataLabel.Visible = .F.
896:         IF EMPTY(loc_dData) OR VARTYPE(loc_dData) != "D"
897:             RETURN
898:         ENDIF
899:         IF USED("cursor_4c_Historico")
900:             SET NEAR ON
901:             = SEEK(DTOS(loc_dData), "cursor_4c_Historico", "datas")
902:             SET NEAR OFF
903:             THIS.grd_4c_Historico.Refresh()
904:             THIS.AtualizarCamposLinha()
905:         ENDIF
906:         THIS.grd_4c_Historico.SetFocus()
907:     ENDPROC
908: 
909:     *--------------------------------------------------------------------------
910:     PROCEDURE TxtDataLostFocus
911:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
912:     *--------------------------------------------------------------------------
913:         THIS.txt_4c_Data.Visible      = .F.
914:         THIS.lbl_4c_DataLabel.Visible = .F.
915:     ENDPROC
916: 
917:     *--------------------------------------------------------------------------
918:     PROCEDURE CmdMovimentoClick
919:     *--------------------------------------------------------------------------
920:         LOCAL loc_cTipoDoc, loc_lSucesso, loc_oForm
921:         loc_lSucesso = .F.
922:         loc_oForm    = .NULL.
923:         TRY
924:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
925:                 MsgAviso("Nenhum registro selecionado.")
926:             ELSE
927:                 THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
928:                 loc_cTipoDoc = THIS.this_oBusinessObject.VerificarExistenciaDocumento()
929:                 DO CASE
930:                 CASE loc_cTipoDoc == "MOVCAB"
931:                     loc_oForm = CREATEOBJECT("FormSigMvExp", THIS)
932:                     IF VARTYPE(loc_oForm) == "O"
933:                         THIS.Enabled = .F.
934:                         loc_oForm.Show()
935:                     ENDIF
936:                 CASE loc_cTipoDoc == "NEC"
937:                     loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS)
938:                     IF VARTYPE(loc_oForm) == "O"
939:                         THIS.Enabled = .F.
940:                         loc_oForm.Show()
941:                     ENDIF
942:                 OTHERWISE
943:                     MsgAviso("Documento n" + CHR(227) + "o encontrado.")
944:                 ENDCASE
945:             ENDIF
946:             loc_lSucesso = .T.
947:         CATCH TO loc_oErro
948:             MsgErro(loc_oErro.Message, "Erro ao abrir documento")
949:         ENDTRY
950:     ENDPROC
951: 
952:     *--------------------------------------------------------------------------
953:     PROCEDURE CmdEncerrarClick
954:     *--------------------------------------------------------------------------
955:         THIS.Release()
956:     ENDPROC
957: 
958:     *==========================================================================
959:     * BtnIncluirClick - Alias CRUD para OPERACIONAL de consulta:
960:     *   "Incluir" nao se aplica ao Historico (readonly). Delega para
961:     *   CarregarDados() que recarrega o historico com o filtro atual
962:     *   (data/grupo/conta/produto) e reseleciona o ultimo registro.
963:     *==========================================================================
964:     PROCEDURE BtnIncluirClick()
965:         LOCAL loc_lSucesso
966:         loc_lSucesso = .F.
967:         TRY
968:             THIS.CarregarDados()
969:             loc_lSucesso = .T.
970:         CATCH TO loc_oErro
971:             MsgErro(loc_oErro.Message, "Erro ao recarregar hist" + CHR(243) + "rico")
972:         ENDTRY
973:     ENDPROC
974: 
975:     *==========================================================================
976:     * BtnAlterarClick - Alias CRUD para OPERACIONAL de consulta:
977:     *   "Alterar" no contexto de historico = marcar/desmarcar auditoria
978:     *   do registro selecionado. Valida permissao via VerificarPermissaoAuditoria
979:     *   e delega para ChkAuditadoClick que executa AuditarRegistro ou
980:     *   DesauditarRegistro no BO.
981:     *==========================================================================
982:     PROCEDURE BtnAlterarClick()
983:         LOCAL loc_lSucesso
984:         loc_lSucesso = .F.
985:         TRY
986:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
987:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
988:             ELSE
989:                 IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
990:                     THIS.chk_4c_ChkAuditado.Value = IIF(THIS.chk_4c_ChkAuditado.Value = 1, 0, 1)
991:                     THIS.ChkAuditadoClick()
992:                 ELSE
993:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
994:                 ENDIF
995:             ENDIF
996:             loc_lSucesso = .T.
997:         CATCH TO loc_oErro
998:             MsgErro(loc_oErro.Message, "Erro ao alterar auditoria")
999:         ENDTRY
1000:     ENDPROC
1001: 
1002:     *==========================================================================
1003:     * BtnVisualizarClick - Alias CRUD para OPERACIONAL de consulta:
1004:     *   "Visualizar" abre o documento (SigMvCab ou SigCdNec) associado
1005:     *   a linha selecionada no grid de historico. Delega para
1006:     *   CmdMovimentoClick que faz VerificarExistenciaDocumento no BO
1007:     *   e instancia FormSigMvExp (movimento) ou FormSigMvPdt (necessidade).
1008:     *==========================================================================
1009:     PROCEDURE BtnVisualizarClick()
1010:         THIS.CmdMovimentoClick()
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     * BtnExcluirClick - Alias CRUD para OPERACIONAL de consulta:
1015:     *   Historico de movimentacao eh readonly - registros nao podem ser
1016:     *   excluidos individualmente. Interpretacao canonica: "Excluir" =
1017:     *   remover marca de auditoria (unico atributo mutavel do registro).
1018:     *   Solicita MsgConfirma antes e delega para ChkAuditadoClick com
1019:     *   toggle para desmarcar.
1020:     *==========================================================================
1021:     PROCEDURE BtnExcluirClick()
1022:         LOCAL loc_lSucesso, loc_cTitulo
1023:         loc_lSucesso = .F.
1024:         loc_cTitulo  = "Remover Auditoria"
1025:         TRY
1026:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1027:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
1028:             ELSE
1029:                 IF !THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1030:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
1031:                 ELSE
1032:                     IF THIS.chk_4c_ChkAuditado.Value = 1
1033:                         IF MsgConfirma("Confirma remover a marca" + CHR(231) + CHR(227) + "o de auditoria deste registro?", loc_cTitulo)
1034:                             THIS.chk_4c_ChkAuditado.Value = 0
1035:                             THIS.ChkAuditadoClick()
1036:                         ENDIF
1037:                     ELSE
1038:                         MsgAviso("O registro selecionado n" + CHR(227) + "o est" + CHR(225) + " marcado como auditado.")
1039:                     ENDIF
1040:                 ENDIF
1041:             ENDIF
1042:             loc_lSucesso = .T.
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message, "Erro ao remover auditoria")
1045:         ENDTRY
1046:     ENDPROC
1047: 
1048:     *--------------------------------------------------------------------------
1049:     PROCEDURE Destroy
1050:     *--------------------------------------------------------------------------
1051:         IF VARTYPE(THIS.this_oParentForm) == "O"
1052:             THIS.this_oParentForm.Enabled = .T.
1053:         ENDIF
1054:         THIS.this_oBusinessObject = .NULL.
1055:         DODEFAULT()
1056:     ENDPROC
1057: 
1058:     *--------------------------------------------------------------------------
1059:     * CarregarLista - Alias FormBase: delega para CarregarDados
1060:     *--------------------------------------------------------------------------
1061:     PROCEDURE CarregarLista
1062:         THIS.CarregarDados()
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------
1066:     * BtnBuscarClick - Exibe campo de filtro por data (igual ao botao Procurar)
1067:     *--------------------------------------------------------------------------
1068:     PROCEDURE BtnBuscarClick
1069:         THIS.CmdProcurarClick()
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     * BtnEncerrarClick - Encerra o formulario
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE BtnEncerrarClick
1076:         THIS.CmdEncerrarClick()
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * BtnSalvarClick - Alias CRUD para OPERACIONAL de auditoria:
1081:     *   "Salvar" = confirmar a marcacao/desmarcacao de auditoria do registro
1082:     *   selecionado. Verifica permissao e delega para ChkAuditadoClick.
1083:     *==========================================================================
1084:     PROCEDURE BtnSalvarClick
1085:         LOCAL loc_lSucesso
1086:         loc_lSucesso = .F.
1087:         TRY
1088:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1089:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
1090:             ELSE
1091:                 IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1092:                     THIS.ChkAuditadoClick()
1093:                 ELSE
1094:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
1095:                 ENDIF
1096:             ENDIF
1097:             loc_lSucesso = .T.
1098:         CATCH TO loc_oErro
1099:             MsgErro(loc_oErro.Message, "Erro ao salvar auditoria")
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * BtnCancelarClick - Alias CRUD para OPERACIONAL:
1105:     *   Oculta o campo de filtro por data e restaura foco ao grid.
1106:     *==========================================================================
1107:     PROCEDURE BtnCancelarClick
1108:         THIS.txt_4c_Data.Visible      = .F.
1109:         THIS.lbl_4c_DataLabel.Visible = .F.
1110:         THIS.grd_4c_Historico.SetFocus()
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * FormParaBO - Sincroniza estado do form -> BO
1115:     *   OPERACIONAL: propaga parametros de contexto e estado do checkbox
1116:     *--------------------------------------------------------------------------
1117:     PROCEDURE FormParaBO
1118:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1119:             RETURN
1120:         ENDIF
1121:         THIS.this_oBusinessObject.this_lTemAuditoria = (THIS.chk_4c_ChkAuditado.Value = 1)
1122:         THIS.this_oBusinessObject.this_cCdGrupo      = THIS.this_cCdGrupo
1123:         THIS.this_oBusinessObject.this_cCdConta      = THIS.this_cCdConta
1124:         THIS.this_oBusinessObject.this_cCdProduto    = THIS.this_cCdProduto
1125:         THIS.this_oBusinessObject.this_cDsProduto    = THIS.this_cDsProduto
1126:         THIS.this_oBusinessObject.this_dDataIni      = THIS.this_dDataIni
1127:         THIS.this_oBusinessObject.this_dDataFim      = THIS.this_dDataFim
1128:     ENDPROC
1129: 
1130:     *--------------------------------------------------------------------------
1131:     * BOParaForm - Sincroniza estado do BO -> form
1132:     *   OPERACIONAL: atualiza campos de exibicao da linha corrente
1133:     *--------------------------------------------------------------------------
1134:     PROCEDURE BOParaForm
1135:         THIS.AtualizarCamposLinha()
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * HabilitarCampos - OPERACIONAL: campos sao ReadOnly por natureza.
1140:     *   Gerencia apenas visibilidade do checkbox de auditoria conforme permissao.
1141:     *--------------------------------------------------------------------------
1142:     PROCEDURE HabilitarCampos
1143:     LPARAMETERS par_cModo
1144:         LOCAL loc_lPermite
1145:         loc_lPermite = .F.
1146:         TRY
1147:             IF VARTYPE(THIS.this_oBusinessObject) == "O"
1148:                 loc_lPermite = THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1149:             ENDIF
1150:             THIS.chk_4c_ChkAuditado.Visible = loc_lPermite
1151:         CATCH TO loc_oErro
1152:             MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
1153:         ENDTRY
1154:     ENDPROC
1155: 
1156:     *--------------------------------------------------------------------------
1157:     * LimparCampos - Limpa todos os campos de exibicao da linha selecionada
1158:     *--------------------------------------------------------------------------
1159:     PROCEDURE LimparCampos
1160:         THIS.txt_4c_Auditors.Value    = ""
1161:         THIS.txt_4c_DtAudits.Value    = ""
1162:         THIS.txt_4c_Usuario.Value     = ""
1163:         THIS.txt_4c_Nota.Value        = ""
1164:         THIS.txt_4c_GruOri.Value      = ""
1165:         THIS.txt_4c_DesGruOri.Value   = ""
1166:         THIS.txt_4c_ConOri.Value      = ""
1167:         THIS.txt_4c_DesConOri.Value   = ""
1168:         THIS.txt_4c_GruDes.Value      = ""
1169:         THIS.txt_4c_DesGruDes.Value   = ""
1170:         THIS.txt_4c_ConDes.Value      = ""
1171:         THIS.txt_4c_DesConDes.Value   = ""
1172:         THIS.obj_4c_Obs.Value         = ""
1173:         THIS.chk_4c_ChkAuditado.Value = 0
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: no-op de compatibilidade
1178:     *--------------------------------------------------------------------------
1179:     PROCEDURE AjustarBotoesPorModo
1180:     LPARAMETERS par_cModo
1181:     ENDPROC
1182: 
1183: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrHprBO.prg):
*================================================================================
* SigPrHprBO.prg - Business Object: Historico de Produtos (SIGPRHPR)
* Form: OPERACIONAL
* Tabela principal: SigMvHst (UPDATE de auditoria)
* Gerado: 17/07/2026
*================================================================================

DEFINE CLASS SigPrHprBO AS BusinessBase

    *-- Tabela e chave principal (SigMvHst recebe UPDATE de auditoria)
    this_cTabela     = "SigMvHst"
    this_cCampoChave = "cidchaves"

    *-- Parametros de contexto recebidos do form pai ao abrir
    this_cCdGrupo    = ""
    this_cCdConta    = ""
    this_cCdProduto  = ""
    this_cDsProduto  = ""
    this_dDataIni    = {}
    this_dDataFim    = {}
    this_cCodEmpresa = ""

    *-- Dados do registro corrente de SigMvHst (linha selecionada no grid)
    this_cEmps       = ""
    this_cEmpos      = ""
    this_cGrupos     = ""
    this_cEstos      = ""
    this_cCpros      = ""
    this_cDopes      = ""
    this_nNumes      = 0
    this_dDatas      = {}
    this_cAuditors   = ""
    this_dDtAudits   = {}
    this_nQtds       = 0
    this_cOpers      = ""
    this_nSQtds      = 0
    this_cObs        = ""
    this_cUsuars     = ""
    this_cCidChaves  = ""
    this_nPesos      = 0
    this_nSPesos     = 0
    this_cCunis      = ""
    this_cCunips     = ""
    this_cCestos     = ""
    this_cEmpDopNums = ""
    this_cEmpGruEsts = ""

    *-- Dados do documento (SigMvCab ou SigCdNec)
    this_cGrupoOri    = ""
    this_cContaOri    = ""
    this_cGrupoDes    = ""
    this_cContaDes    = ""
    this_cNotas       = ""

    *-- Descricoes do contabil (SigCdGcr e SigCdCli)
    this_cDesGrupoOri = ""
    this_cDesContaOri = ""
    this_cDesGrupoDes = ""
    this_cDesContaDes = ""

    *-- Controle interno de permissao e tipo de produto (Cestos='3' = produto peso)
    this_lTemAuditoria = .F.
    this_lEhPeso       = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvHst"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cCodEmpresa = go_4c_Sistema.cCodEmpresa

            *-- Cursor placeholder para grid de historico
            *-- Estrutura espelha campos do SQLEXEC em CarregarHistorico
            SET NULL ON
            CREATE CURSOR cursor_4c_Historico (;
                emps      C(3)    NULL, ;
                empos     C(3)    NULL, ;
                grupos    C(10)   NULL, ;
                estos     C(10)   NULL, ;
                cpros     C(14)   NULL, ;
                dopes     C(20)   NULL, ;
                numes     N(6,0)  NULL, ;
                datas     T       NULL, ;
                auditors  C(10)   NULL, ;
                dtaudits  T       NULL, ;
                qtds      N(9,3)  NULL, ;
                opers     C(1)    NULL, ;
                sqtds     N(11,3) NULL, ;
                obs       M       NULL, ;
                usuars    C(10)   NULL, ;
                cidchaves C(20)   NULL, ;
                pesos     N(15,3) NULL, ;
                spesos    N(15,3) NULL, ;
                cunis     C(3)    NULL  ;
            )
            INDEX ON DTOS(datas) TAG datas
            INDEX ON pesos TAG pesos
            SET NULL OFF

            *-- Cursor placeholder para grid de subniveis
            *-- Estrutura espelha crSubniveis do legado
            SET NULL ON
            CREATE CURSOR cursor_4c_Subniveis (;
                emps  C(3)   NULL, ;
                dopes C(20)  NULL, ;
                numes N(6,0) NULL  ;
            )
            INDEX ON emps TAG emps
            SET NULL OFF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Copia dados da linha corrente do cursor para as props
    * Assinatura canonica CRUD (par_cAliasCursor). Alias flexivel para
    * cursor_4c_Historico ou qualquer outro cursor com estrutura de SigMvHst.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Historico", par_cAliasCursor)
            IF USED(loc_cAlias) AND RECCOUNT(loc_cAlias) > 0
                SELECT (loc_cAlias)
                THIS.this_cEmps      = TratarNulo(emps, "C")
                THIS.this_cEmpos     = TratarNulo(empos, "C")
                THIS.this_cGrupos    = TratarNulo(grupos, "C")
                THIS.this_cEstos     = TratarNulo(estos, "C")
                THIS.this_cCpros     = TratarNulo(cpros, "C")
                THIS.this_cDopes     = TratarNulo(dopes, "C")
                IF VARTYPE(numes) = "N"
                    THIS.this_nNumes = NVL(numes, 0)
                ELSE
                    THIS.this_nNumes = 0
                ENDIF
                THIS.this_dDatas     = NVL(datas, {})
                THIS.this_cAuditors  = TratarNulo(auditors, "C")
                THIS.this_dDtAudits  = NVL(dtaudits, {})
                IF VARTYPE(qtds) = "N"
                    THIS.this_nQtds  = NVL(qtds, 0)
                ELSE
                    THIS.this_nQtds  = 0
                ENDIF
                THIS.this_cOpers     = TratarNulo(opers, "C")
                IF VARTYPE(sqtds) = "N"
                    THIS.this_nSQtds = NVL(sqtds, 0)
                ELSE
                    THIS.this_nSQtds = 0
                ENDIF
                THIS.this_cObs       = TratarNulo(obs, "C")
                THIS.this_cUsuars    = TratarNulo(usuars, "C")
                THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(pesos) = "N"
                    THIS.this_nPesos = NVL(pesos, 0)
                ELSE
                    THIS.this_nPesos = 0
                ENDIF
                IF TYPE(loc_cAlias + ".spesos") != "U"
                    IF VARTYPE(spesos) = "N"
                        THIS.this_nSPesos = NVL(spesos, 0)
                    ELSE
                        THIS.this_nSPesos = 0
                    ENDIF
                ENDIF
                IF TYPE(loc_cAlias + ".cunis") != "U"
                    THIS.this_cCunis = TratarNulo(cunis, "C")
                ENDIF
                THIS.this_lTemAuditoria = (NOT EMPTY(ALLTRIM(THIS.this_cAuditors)))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDoCursor]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Este form eh OPERACIONAL de leitura (historico de produtos).
    * Registros em SigMvHst sao gerados por movimentacoes de outros modulos,
    * NUNCA inseridos manualmente por este cadastro. Assim, Inserir() bloqueia
    * a operacao e retorna .F., garantindo que o form Salvar() (chamado pela
    * FormBase por engano) nao corrompa o historico.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "N" + CHR(227) + "o " + CHR(233) + " permitido incluir registros no hist" + CHR(243) + "rico de produtos. Movimenta" + CHR(231) + CHR(245) + "es s" + CHR(227) + "o geradas pelos m" + CHR(243) + "dulos operacionais."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigMvHst dos campos de auditoria (auditors/dtaudits).
    * Aplica ou remove marca de auditor conforme this_lTemAuditoria.
    * Registra evento em LogAuditoria via RegistrarAuditoria("UPDATE").
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nQueryOk, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Nenhum registro selecionado para atualizar."
            ELSE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                IF THIS.this_lTemAuditoria
                    *-- Marcar como auditado pelo usuario logado
                    loc_cSQL = "UPDATE SigMvHst SET auditors = " + EscaparSQL(loc_cUsuario) + ;
                               ", dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ELSE
                    *-- Remover marca de auditoria
                    loc_cSQL = "UPDATE SigMvHst SET auditors = '          ', dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                ENDIF

                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    THIS.this_cMensagemErro = "Falha ao atualizar auditoria do hist" + CHR(243) + "rico."
                ELSE
                    *-- Sincronizar cursor local + props
                    IF USED("cursor_4c_Historico")
                        SELECT cursor_4c_Historico
                        IF THIS.this_lTemAuditoria
                            REPLACE auditors WITH loc_cUsuario, dtaudits WITH DATETIME()
                            THIS.this_cAuditors = loc_cUsuario
                            THIS.this_dDtAudits = DATETIME()
                        ELSE
                            REPLACE auditors WITH SPACE(10), dtaudits WITH {}
                            THIS.this_cAuditors = ""
                            THIS.this_dDtAudits = {}
                        ENDIF
                    ENDIF
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " [Atualizar]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override com GETDATE() nativo do SQL Server.
    * Regra: NUNCA usar GETDATE() em campo DataHora
    * (rejeita tipo T, gera INSERT NULL em NOT NULL). Lesson 2026-07-08.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario
        loc_cChave = THIS.ObterChavePrimaria()
        IF EMPTY(loc_cChave)
            RETURN .F.
        ENDIF
        loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
        loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                   "VALUES (" + EscaparSQL(THIS.this_cTabela) + ", " + ;
                   EscaparSQL(par_cOperacao) + ", " + ;
                   EscaparSQL(loc_cChave) + ", " + ;
                   EscaparSQL(loc_cUsuario) + ", GETDATE())"
        SQLEXEC(gnConnHandle, loc_cSQL)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarHistorico
    *-- Carrega SigMvHst para cursor_4c_Historico conforme parametros do form pai
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL, loc_cEmpGruEst, loc_cDtIni, loc_cDtFim
        loc_lSucesso = .F.
        TRY
            loc_cEmpGruEst = THIS.this_cCodEmpresa + THIS.this_cCdGrupo + THIS.this_cCdConta
            loc_cDtIni     = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDtFim     = FormatarDataSQL(THIS.this_dDataFim)

            loc_cSQL = "SELECT a.emps, a.empos, a.grupos, a.estos, a.cpros, " + ;
                       "a.dopes, a.numes, a.datas, a.auditors, a.dtaudits, " + ;
                       "a.qtds, a.opers, a.sqtds, a.obs, a.usuars, " + ;
                       "a.cidchaves, a.pesos, a.spesos, '   ' AS cunis " + ;
                       "FROM SigMvHst a " + ;
                       "WHERE a.empgruests = " + EscaparSQL(loc_cEmpGruEst) + ;
                       " AND a.cpros = " + EscaparSQL(THIS.this_cCdProduto) + ;
                       " AND CAST(a.datas AS DATE) >= " + loc_cDtIni + ;
                       " AND CAST(a.datas AS DATE) <= " + loc_cDtFim + ;
                       " ORDER BY a.emps, a.grupos, a.estos, a.cidchaves, a.opers"

            IF USED("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistoricoTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar hist" + CHR(243) + "rico de produtos.", "Erro")
            ELSE
                SELECT cursor_4c_Historico
                ZAP
                APPEND FROM DBF("cursor_4c_HistoricoTemp")
                USE IN cursor_4c_HistoricoTemp

                THIS.CarregarDadosProduto()

                IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                    SELECT cursor_4c_Historico
                    REPLACE ALL cunis WITH THIS.this_cCunis
                ENDIF

                SELECT cursor_4c_Historico
                INDEX ON DTOS(datas) TAG datas
                INDEX ON pesos TAG pesos
                GO BOTTOM

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarHistorico]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosProduto
    *-- Carrega SigCdPro e SigCdUni para o produto corrente
    *-- Preenche this_cCunis, this_cCunips, this_cCestos, this_lEhPeso
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF
            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, cunis, cunips FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(THIS.this_cCdProduto), "cursor_4c_TmpPro")
            IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                SELECT cursor_4c_TmpPro
                GO TOP
                THIS.this_cCunis  = NVL(cursor_4c_TmpPro.cunis, "")
                THIS.this_cCunips = NVL(cursor_4c_TmpPro.cunips, "")
            ELSE
                THIS.this_cCunis  = ""
                THIS.this_cCunips = ""
            ENDIF
            IF USED("cursor_4c_TmpPro")
                USE IN cursor_4c_TmpPro
            ENDIF

            THIS.this_cCestos = ""
            IF NOT EMPTY(ALLTRIM(THIS.this_cCunis))
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT Cestos FROM SigCdUni WHERE cunis = " + ;
                    EscaparSQL(THIS.this_cCunis), "cursor_4c_TmpUni")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpUni") AND RECCOUNT("cursor_4c_TmpUni") > 0
                    SELECT cursor_4c_TmpUni
                    GO TOP
                    THIS.this_cCestos = NVL(cursor_4c_TmpUni.Cestos, "")
                ENDIF
                IF USED("cursor_4c_TmpUni")
                    USE IN cursor_4c_TmpUni
                ENDIF
            ENDIF

            THIS.this_lEhPeso = (THIS.this_cCestos = "3")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosProduto]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosLinhaSelecionada
    *-- Copia dados do registro corrente de cursor_4c_Historico para props this_*
    *-- Chamado pelo form apos AfterRowColChange
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
                SELECT cursor_4c_Historico
                THIS.this_cEmps      = NVL(cursor_4c_Historico.emps, "")
                THIS.this_cEmpos     = NVL(cursor_4c_Historico.empos, "")
                THIS.this_cGrupos    = NVL(cursor_4c_Historico.grupos, "")
                THIS.this_cEstos     = NVL(cursor_4c_Historico.estos, "")
                THIS.this_cCpros     = NVL(cursor_4c_Historico.cpros, "")
                THIS.this_cDopes     = NVL(cursor_4c_Historico.dopes, "")
                THIS.this_nNumes     = NVL(cursor_4c_Historico.numes, 0)
                THIS.this_dDatas     = NVL(cursor_4c_Historico.datas, {})
                THIS.this_cAuditors  = NVL(cursor_4c_Historico.auditors, "")
                THIS.this_dDtAudits  = NVL(cursor_4c_Historico.dtaudits, {})
                THIS.this_nQtds      = NVL(cursor_4c_Historico.qtds, 0)
                THIS.this_cOpers     = NVL(cursor_4c_Historico.opers, "")
                THIS.this_nSQtds     = NVL(cursor_4c_Historico.sqtds, 0)
                THIS.this_cObs       = NVL(cursor_4c_Historico.obs, "")
                THIS.this_cUsuars    = NVL(cursor_4c_Historico.usuars, "")
                THIS.this_cCidChaves = NVL(cursor_4c_Historico.cidchaves, "")
                THIS.this_nPesos     = NVL(cursor_4c_Historico.pesos, 0)
                THIS.this_nSPesos    = NVL(cursor_4c_Historico.spesos, 0)
                THIS.this_cCunis     = NVL(cursor_4c_Historico.cunis, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDadosLinhaSelecionada]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDocumento
    *-- Carrega documento (SigMvCab ou SigCdNec) do registro corrente
    *-- Tenta SigMvCab primeiro (empdopnums); se vazio, tenta SigCdNec (empdnps)
    *-- Preenche this_cGrupoOri, this_cContaOri, this_cGrupoDes, this_cContaDes, this_cNotas
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_lSucesso = .F.
        TRY
            THIS.this_cGrupoOri = ""
            THIS.this_cContaOri = ""
            THIS.this_cGrupoDes = ""
            THIS.this_cContaDes = ""
            THIS.this_cNotas    = ""

            loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
            loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

            IF USED("cursor_4c_DocTemp")
                USE IN cursor_4c_DocTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                "SELECT grupoos, contaos, grupods, contads, Notas " + ;
                "FROM SigMvCab " + ;
                "WHERE empdopnums = " + EscaparSQL(loc_cEmpDopNum), ;
                "cursor_4c_DocTemp")

            IF loc_nQueryOk >= 1 AND USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") = 0
                USE IN cursor_4c_DocTemp
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT grupoos, contaos, grupods, contads, '      ' AS Notas " + ;
                    "FROM SigCdNec " + ;
                    "WHERE empdnps = " + EscaparSQL(loc_cEmpDopNumLong), ;
                    "cursor_4c_DocTemp")
            ENDIF

            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar documento do movimento.", "Erro")
            ELSE
                IF USED("cursor_4c_DocTemp") AND RECCOUNT("cursor_4c_DocTemp") > 0
                    SELECT cursor_4c_DocTemp
                    GO TOP
                    THIS.this_cGrupoOri = NVL(cursor_4c_DocTemp.grupoos, "")
                    THIS.this_cContaOri = NVL(cursor_4c_DocTemp.contaos, "")
                    THIS.this_cGrupoDes = NVL(cursor_4c_DocTemp.grupods, "")
                    THIS.this_cContaDes = NVL(cursor_4c_DocTemp.contads, "")
                    THIS.this_cNotas    = NVL(cursor_4c_DocTemp.Notas, "")
                ENDIF
                IF USED("cursor_4c_DocTemp")
                    USE IN cursor_4c_DocTemp
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDocumento]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescricoesContabil
    *-- Carrega descricoes de grupos (SigCdGcr) e contas (SigCdCli)
    *-- Preenche this_cDesGrupoOri/Des e this_cDesContaOri/Des
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk
        LOCAL loc_cGruOri, loc_cConOri, loc_cGruDes, loc_cConDes
        loc_lSucesso = .F.
        TRY
            loc_cGruOri = THIS.this_cGrupoOri
            loc_cConOri = THIS.this_cContaOri
            loc_cGruDes = THIS.this_cGrupoDes
            loc_cConDes = THIS.this_cContaDes

            THIS.this_cDesGrupoOri = ""
            THIS.this_cDesContaOri = ""
            THIS.this_cDesGrupoDes = ""
            THIS.this_cDesContaDes = ""

            *-- Grupos via SigCdGcr (coluna descrs COM r)
            IF USED("cursor_4c_TmpGcr")
                USE IN cursor_4c_TmpGcr
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cGruOri)) OR NOT EMPTY(ALLTRIM(loc_cGruDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr " + ;
                    "WHERE codigos = " + EscaparSQL(loc_cGruOri) + ;
                    " OR codigos = " + EscaparSQL(loc_cGruDes), ;
                    "cursor_4c_TmpGcr")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpGcr") AND RECCOUNT("cursor_4c_TmpGcr") > 0
                    SELECT cursor_4c_TmpGcr
                    INDEX ON codigos TAG codigos
                    GO TOP
                    THIS.this_cDesGrupoOri = IIF(SEEK(loc_cGruOri, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                    THIS.this_cDesGrupoDes = IIF(SEEK(loc_cGruDes, "cursor_4c_TmpGcr", "codigos"), NVL(cursor_4c_TmpGcr.descrs, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpGcr")
                    USE IN cursor_4c_TmpGcr
                ENDIF
            ENDIF

            *-- Contas via SigCdCli
            IF USED("cursor_4c_TmpCli")
                USE IN cursor_4c_TmpCli
            ENDIF
            IF NOT EMPTY(ALLTRIM(loc_cConOri)) OR NOT EMPTY(ALLTRIM(loc_cConDes))
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT iclis, rclis FROM SigCdCli " + ;
                    "WHERE iclis = " + EscaparSQL(loc_cConOri) + ;
                    " OR iclis = " + EscaparSQL(loc_cConDes), ;
                    "cursor_4c_TmpCli")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                    SELECT cursor_4c_TmpCli
                    INDEX ON iclis TAG iclis
                    GO TOP
                    THIS.this_cDesContaOri = IIF(SEEK(loc_cConOri, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                    THIS.this_cDesContaDes = IIF(SEEK(loc_cConDes, "cursor_4c_TmpCli", "iclis"), NVL(cursor_4c_TmpCli.rclis, ""), "")
                ENDIF
                IF USED("cursor_4c_TmpCli")
                    USE IN cursor_4c_TmpCli
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarDescricoesContabil]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarSubniveis
    *-- Carrega SigMvPec para cursor_4c_Subniveis do registro corrente
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cEdn, loc_cSQL
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Subniveis
            ZAP

            loc_cEdn = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT a.EmpSubns AS Emps, b.Dopes, " + ;
                       "RIGHT(STR(a.Codigos, 10), 6) AS Numes " + ;
                       "FROM SigMvPec a, SigCdOpe b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND LEFT(STR(a.Codigos, 10), 4) = STR(b.NDopes, 4) " + ;
                       "ORDER BY 1, 2, 3"

            IF USED("cursor_4c_SubniveisTemp")
                USE IN cursor_4c_SubniveisTemp
            ENDIF

            loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubniveisTemp")
            IF loc_nQueryOk < 1
                MsgErro("Falha ao carregar subniveis.", "Erro")
            ELSE
                IF USED("cursor_4c_SubniveisTemp") AND RECCOUNT("cursor_4c_SubniveisTemp") > 0
                    SELECT cursor_4c_SubniveisTemp
                    SCAN
                        INSERT INTO cursor_4c_Subniveis (emps, dopes, numes) ;
                            VALUES (cursor_4c_SubniveisTemp.Emps, ;
                                    cursor_4c_SubniveisTemp.Dopes, ;
                                    VAL(cursor_4c_SubniveisTemp.Numes))
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_SubniveisTemp")
                    USE IN cursor_4c_SubniveisTemp
                ENDIF
                SELECT cursor_4c_Subniveis
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [CarregarSubniveis]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AuditarRegistro
    *-- Marca registro corrente como auditado pelo usuario logado em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado para auditar.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao registrar auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = GETDATE() " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao registrar data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH gc_4c_UsuarioLogado
                            REPLACE dtaudits WITH DATETIME()
                        ENDIF
                        THIS.this_cAuditors = gc_4c_UsuarioLogado
                        THIS.this_dDtAudits = DATETIME()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [AuditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE DesauditarRegistro
    *-- Remove marca de auditoria do registro corrente em SigMvHst
    *-- Retorna .T. se OK
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_nQueryOk, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro selecionado.", "Auditoria")
            ELSE
                loc_cSQL = "UPDATE SigMvHst SET auditors = '          ' " + ;
                           "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                IF loc_nQueryOk < 1
                    MsgErro("Falha ao remover auditor.", "Erro de Auditoria")
                ELSE
                    loc_cSQL = "UPDATE SigMvHst SET dtaudits = NULL " + ;
                               "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, loc_cSQL, "")
                    IF loc_nQueryOk < 1
                        MsgErro("Falha ao remover data de auditoria.", "Erro de Auditoria")
                    ELSE
                        IF USED("cursor_4c_Historico")
                            SELECT cursor_4c_Historico
                            REPLACE auditors WITH SPACE(10)
                            REPLACE dtaudits WITH {}
                        ENDIF
                        THIS.this_cAuditors = ""
                        THIS.this_dDtAudits = {}
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [DesauditarRegistro]", "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarPermissaoAuditoria
    *-- Retorna .T. se o usuario logado pode auditar o registro corrente
    *-- Supervisor (4CONTROL) sempre pode; outros: apenas registros sem auditor
    *-- ou registros que o proprio usuario auditou
    *--------------------------------------------------------------------------
        LOCAL loc_lPermitido, loc_lSupervisor
        loc_lPermitido  = .F.
        TRY
            loc_lSupervisor = (UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = "4CONTROL")
            IF loc_lSupervisor
                loc_lPermitido = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cAuditors))
                    loc_lPermitido = .T.
                ELSE
                    IF UPPER(ALLTRIM(gc_4c_UsuarioLogado)) = UPPER(ALLTRIM(THIS.this_cAuditors))
                        loc_lPermitido = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarPermissaoAuditoria]", "Erro")
        ENDTRY
        RETURN loc_lPermitido
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE VerificarExistenciaDocumento
    *-- Verifica se existe documento para o registro corrente
    *-- Retorna "MOVCAB" se em SigMvCab, "NEC" se em SigCdNec, "" se nao encontrou
    *--------------------------------------------------------------------------
        LOCAL loc_cTipoDoc, loc_nQueryOk, loc_cEmpsEfetivo
        LOCAL loc_cEmpDopNum, loc_cEmpDopNumLong
        loc_cTipoDoc = ""
        TRY
            IF NOT (EMPTY(ALLTRIM(THIS.this_cEmps)) OR EMPTY(ALLTRIM(THIS.this_cDopes)) OR THIS.this_nNumes = 0)
                loc_cEmpsEfetivo   = IIF(NOT EMPTY(ALLTRIM(THIS.this_cEmpos)), THIS.this_cEmpos, THIS.this_cEmps)
                loc_cEmpDopNum     = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
                loc_cEmpDopNumLong = loc_cEmpsEfetivo + THIS.this_cDopes + STR(THIS.this_nNumes, 10)

                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF
                loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS nExiste FROM SigMvCab WHERE EmpDopNums = " + ;
                    EscaparSQL(loc_cEmpDopNum), "cursor_4c_TmpChk")
                IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                    SELECT cursor_4c_TmpChk
                    IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                        loc_cTipoDoc = "MOVCAB"
                    ENDIF
                ENDIF
                IF USED("cursor_4c_TmpChk")
                    USE IN cursor_4c_TmpChk
                ENDIF

                IF EMPTY(loc_cTipoDoc)
                    loc_nQueryOk = SQLEXEC(gnConnHandle, ;
                        "SELECT COUNT(*) AS nExiste FROM SigCdNec WHERE EmpDnPs = " + ;
                        EscaparSQL(loc_cEmpDopNumLong), "cursor_4c_TmpChk")
                    IF loc_nQueryOk >= 1 AND USED("cursor_4c_TmpChk") AND RECCOUNT("cursor_4c_TmpChk") > 0
                        SELECT cursor_4c_TmpChk
                        IF NVL(cursor_4c_TmpChk.nExiste, 0) > 0
                            loc_cTipoDoc = "NEC"
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpChk")
                        USE IN cursor_4c_TmpChk
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [VerificarExistenciaDocumento]", "Erro")
        ENDTRY
        RETURN loc_cTipoDoc
    ENDPROC

ENDDEFINE

