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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrHpr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1188 linhas total):

*-- Linhas 32 a 156:
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
79:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:             THIS.ConfigurarContainersVisuais()
82:             THIS.ConfigurarBotoesTopo()
83:             THIS.ConfigurarCamposFiltroData()
84:             THIS.ConfigurarPaginaLista()
85:             THIS.ConfigurarPaginaDados()
86:             THIS.TornarControlesVisiveis(THIS)
87:             THIS.txt_4c_Data.Visible        = .F.
88:             THIS.lbl_4c_DataLabel.Visible   = .F.
89:             THIS.chk_4c_ChkAuditado.Visible = .F.
90:             THIS.ConfigurarEventos()
91: 
92:             IF !(VARTYPE(gb_4c_ValidandoUI) == "L" AND gb_4c_ValidandoUI)
93:                 THIS.CarregarDados()
94:             ENDIF
95: 
96:             loc_lSucesso = .T.
97:         CATCH TO loc_oErro
98:             MsgErro(loc_oErro.Message, "Erro ao inicializar")
99:         ENDTRY
100:         RETURN loc_lSucesso
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarPageFrame - Layout OPERACIONAL flat: sem PageFrame.
105:     * Controles sao filhos diretos do form (grd_4c_Historico, grd_4c_Subniveis,
106:     * containers e textboxes). Metodo mantido para simetria com o pipeline.
107:     *--------------------------------------------------------------------------
108:     PROTECTED PROCEDURE ConfigurarPageFrame
109:         THIS.BackColor = RGB(236, 233, 216)
110:         IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
111:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
112:         ENDIF
113:     ENDPROC
114: 
115:     *--------------------------------------------------------------------------
116:     PROTECTED PROCEDURE ConfigurarCabecalho
117:     *--------------------------------------------------------------------------
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH THIS.cnt_4c_Cabecalho
120:             .Top       = 0
121:             .Left      = 0
122:             .Width     = THIS.Width
123:             .Height    = 80
124:             .BackColor = RGB(100, 100, 100)
125:             .BackStyle = 1
126:             .Visible   = .T.
127:             .AddObject("lbl_4c_Sombra", "Label")
128:             WITH .lbl_4c_Sombra
129:                 .Top       = 18
130:                 .Left      = 10
131:                 .Width     = THIS.Width
132:                 .Height    = 40
133:                 .AutoSize  = .F.
134:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 18
137:                 .FontBold  = .T.
138:                 .WordWrap  = .T.
139:                 .Alignment = 0
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .Visible   = .T.
143:             ENDWITH
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Top       = 17
147:                 .Left      = 10
148:                 .Width     = THIS.Width
149:                 .Height    = 46
150:                 .AutoSize  = .F.
151:                 .Caption   = "Hist" + CHR(243) + "rico de Produtos"
152:                 .FontName  = "Tahoma"
153:                 .FontSize  = 18
154:                 .FontBold  = .T.
155:                 .WordWrap  = .T.
156:                 .Alignment = 0

*-- Linhas 162 a 230:
162:     ENDPROC
163: 
164:     *--------------------------------------------------------------------------
165:     PROTECTED PROCEDURE ConfigurarContainersVisuais
166:     *--------------------------------------------------------------------------
167:         THIS.AddObject("cnt_4c_Origem", "Container")
168:         WITH THIS.cnt_4c_Origem
169:             .Top       = 426
170:             .Left      = 7
171:             .Width     = 478
172:             .Height    = 74
173:             .BackColor = RGB(255, 255, 255)
174:             .BackStyle = 1
175:             .Visible   = .T.
176:         ENDWITH
177:         THIS.AddObject("cnt_4c_Destino", "Container")
178:         WITH THIS.cnt_4c_Destino
179:             .Top       = 426
180:             .Left      = 504
181:             .Width     = 478
182:             .Height    = 74
183:             .BackColor = RGB(255, 255, 255)
184:             .BackStyle = 1
185:             .Visible   = .T.
186:         ENDWITH
187:     ENDPROC
188: 
189:     *--------------------------------------------------------------------------
190:     PROTECTED PROCEDURE ConfigurarBotoesTopo
191:     *--------------------------------------------------------------------------
192:         THIS.AddObject("chk_4c_ChkAuditado", "CheckBox")
193:         WITH THIS.chk_4c_ChkAuditado
194:             .Top             = 3
195:             .Left            = 700
196:             .Width           = 75
197:             .Height          = 75
198:             .Caption         = "Auditado"
199:             .Alignment       = 0
200:             .Style           = 1
201:             .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
202:             .PicturePosition = 13
203:             .WordWrap        = .T.
204:             .FontName        = "Tahoma"
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .FontSize        = 8
208:             .ForeColor       = RGB(90, 90, 90)
209:             .BackColor       = RGB(255, 255, 255)
210:             .Themes          = .F.
211:             .BackStyle       = 0
212:             .SpecialEffect   = 0
213:             .Visible         = .T.
214:         ENDWITH
215:         THIS.AddObject("cmd_4c_BtnDocumento", "CommandButton")
216:         WITH THIS.cmd_4c_BtnDocumento
217:             .Top             = 3
218:             .Left            = 775
219:             .Width           = 75
220:             .Height          = 75
221:             .Caption         = "Movimento"
222:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
223:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
224:             .PicturePosition = 13
225:             .WordWrap        = .T.
226:             .FontName        = "Tahoma"
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .FontSize        = 8
230:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 278 a 360:
278:     ENDPROC
279: 
280:     *--------------------------------------------------------------------------
281:     PROTECTED PROCEDURE ConfigurarCamposFiltroData
282:     *--------------------------------------------------------------------------
283:         THIS.AddObject("lbl_4c_DataLabel", "Label")
284:         WITH THIS.lbl_4c_DataLabel
285:             .Top      = 102
286:             .Left     = 441
287:             .AutoSize = .T.
288:             .Caption  = "Data:"
289:             .FontBold = .T.
290:             .Visible  = .F.
291:         ENDWITH
292:         THIS.AddObject("txt_4c_Data", "TextBox")
293:         WITH THIS.txt_4c_Data
294:             .Top       = 98
295:             .Left      = 478
296:             .Width     = 80
297:             .Height    = 23
298:             .Alignment = 3
299:             .MaxLength = 10
300:             .Visible   = .F.
301:         ENDWITH
302:     ENDPROC
303: 
304:     *--------------------------------------------------------------------------
305:     PROTECTED PROCEDURE ConfigurarLabelProduto
306:     *--------------------------------------------------------------------------
307:         THIS.AddObject("lbl_4c_LabelProduto", "Label")
308:         WITH THIS.lbl_4c_LabelProduto
309:             .Top       = 130
310:             .Left      = 15
311:             .AutoSize  = .T.
312:             .FontBold  = .T.
313:             .ForeColor = RGB(90, 90, 90)
314:             .Caption   = ""
315:             .Visible   = .T.
316:         ENDWITH
317:     ENDPROC
318: 
319:     *--------------------------------------------------------------------------
320:     PROTECTED PROCEDURE ConfigurarGrdHistorico
321:     *--------------------------------------------------------------------------
322:         THIS.AddObject("grd_4c_Historico", "GridBase")
323:         WITH THIS.grd_4c_Historico
324:             .Top          = 148
325:             .Left         = 4
326:             .Width        = 730
327:             .Height       = 238
328:             .ColumnCount  = 9
329:             .RecordSource = "cursor_4c_Historico"
330:             .ReadOnly     = .T.
331:             .DeleteMark   = .F.
332:             .RecordMark   = .F.
333:             .FontName     = "Courier New"
334:             .FontSize     = 9
335:             .Visible      = .T.
336:             WITH .Column1
337:                 .Width            = 86
338:                 .ControlSource    = "cursor_4c_Historico.datas"
339:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
340:                 .Header1.Caption  = "Data"
341:             ENDWITH
342:             WITH .Column2
343:                 .Width            = 57
344:                 .ControlSource    = "cursor_4c_Historico.numes"
345:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
346:                 .Header1.Caption  = "C" + CHR(243) + "digo"
347:             ENDWITH
348:             WITH .Column3
349:                 .Width            = 161
350:                 .ControlSource    = "cursor_4c_Historico.dopes"
351:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
352:                 .Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
353:             ENDWITH
354:             WITH .Column4
355:                 .Width            = 31
356:                 .ControlSource    = "cursor_4c_Historico.cunis"
357:                 .DynamicBackColor = "IIF(!EMPTY(cursor_4c_Historico.auditors),RGB(220,255,220),RGB(255,255,255))"
358:                 .Header1.Caption  = "Un."
359:             ENDWITH
360:             WITH .Column5

*-- Linhas 397 a 484:
397:     ENDPROC
398: 
399:     *--------------------------------------------------------------------------
400:     PROTECTED PROCEDURE ConfigurarGrdSubniveis
401:     *--------------------------------------------------------------------------
402:         THIS.AddObject("lbl_4c_Label3", "Label")
403:         WITH THIS.lbl_4c_Label3
404:             .Top      = 130
405:             .Left     = 747
406:             .AutoSize = .T.
407:             .Caption  = "Movimenta" + CHR(231) + CHR(245) + "es com subn" + CHR(237) + "vel"
408:             .FontBold = .T.
409:             .Visible  = .T.
410:         ENDWITH
411:         THIS.AddObject("grd_4c_Subniveis", "GridBase")
412:         WITH THIS.grd_4c_Subniveis
413:             .Top          = 148
414:             .Left         = 738
415:             .Width        = 261
416:             .Height       = 238
417:             .ColumnCount  = 3
418:             .RecordSource = "cursor_4c_Subniveis"
419:             .ReadOnly     = .T.
420:             .DeleteMark   = .F.
421:             .RecordMark   = .F.
422:             .FontName     = "Courier New"
423:             .FontSize     = 9
424:             .Visible      = .T.
425:             WITH .Column1
426:                 .Width           = 31
427:                 .ControlSource   = "cursor_4c_Subniveis.emps"
428:                 .Header1.Caption = "Emp"
429:             ENDWITH
430:             WITH .Column2
431:                 .Width           = 156
432:                 .ControlSource   = "cursor_4c_Subniveis.dopes"
433:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
434:             ENDWITH
435:             WITH .Column3
436:                 .Width           = 51
437:                 .ControlSource   = "cursor_4c_Subniveis.numes"
438:                 .Header1.Caption = "C" + CHR(243) + "digo"
439:             ENDWITH
440:         ENDWITH
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     PROTECTED PROCEDURE ConfigurarAreaInfo
445:     *--------------------------------------------------------------------------
446:         THIS.AddObject("lbl_4c_Label2", "Label")
447:         WITH THIS.lbl_4c_Label2
448:             .Top      = 396
449:             .Left     = 27
450:             .AutoSize = .T.
451:             .Caption  = "Documento:"
452:             .FontBold = .T.
453:             .Visible  = .T.
454:         ENDWITH
455:         THIS.AddObject("txt_4c_Nota", "TextBox")
456:         WITH THIS.txt_4c_Nota
457:             .Top           = 392
458:             .Left          = 102
459:             .Width         = 80
460:             .Height        = 23
461:             .ReadOnly      = .T.
462:             .SpecialEffect = 1
463:             .Visible       = .T.
464:         ENDWITH
465:         THIS.AddObject("lbl_4c_Label1", "Label")
466:         WITH THIS.lbl_4c_Label1
467:             .Top      = 396
468:             .Left     = 197
469:             .AutoSize = .T.
470:             .Caption  = "Usu" + CHR(225) + "rio:"
471:             .FontBold = .T.
472:             .Visible  = .T.
473:         ENDWITH
474:         THIS.AddObject("txt_4c_Usuario", "TextBox")
475:         WITH THIS.txt_4c_Usuario
476:             .Top           = 392
477:             .Left          = 250
478:             .Width         = 96
479:             .Height        = 23
480:             .ReadOnly      = .T.
481:             .SpecialEffect = 1
482:             .Visible       = .T.
483:         ENDWITH
484:         THIS.AddObject("lbl_4c_Auditoria", "Label")

*-- Linhas 522 a 565:
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     PROTECTED PROCEDURE ConfigurarLabelsAreaContas
526:     *--------------------------------------------------------------------------
527:         THIS.AddObject("lbl_4c_Label7", "Label")
528:         WITH THIS.lbl_4c_Label7
529:             .Top      = 428
530:             .Left     = 17
531:             .AutoSize = .T.
532:             .Caption  = "Origem"
533:             .FontBold = .T.
534:             .Visible  = .T.
535:         ENDWITH
536:         THIS.AddObject("lin_4c_Line1", "Line")
537:         WITH THIS.lin_4c_Line1
538:             .Top         = 442
539:             .Left        = 18
540:             .Width       = 340
541:             .Height      = 0
542:             .BorderWidth = 2
543:             .BorderColor = RGB(90, 90, 90)
544:             .Visible     = .T.
545:         ENDWITH
546:         THIS.AddObject("lbl_4c_Label9", "Label")
547:         WITH THIS.lbl_4c_Label9
548:             .Top      = 451
549:             .Left     = 62
550:             .AutoSize = .T.
551:             .Caption  = "Grupo:"
552:             .FontBold = .T.
553:             .Visible  = .T.
554:         ENDWITH
555:         THIS.AddObject("lbl_4c_Label10", "Label")
556:         WITH THIS.lbl_4c_Label10
557:             .Top      = 475
558:             .Left     = 63
559:             .AutoSize = .T.
560:             .Caption  = "Conta:"
561:             .FontBold = .T.
562:             .Visible  = .T.
563:         ENDWITH
564:         THIS.AddObject("lbl_4c_Label8", "Label")
565:         WITH THIS.lbl_4c_Label8

*-- Linhas 610 a 653:
610:     ENDPROC
611: 
612:     *--------------------------------------------------------------------------
613:     PROTECTED PROCEDURE ConfigurarCamposAreaContas
614:     *--------------------------------------------------------------------------
615:         THIS.AddObject("txt_4c_GruOri", "TextBox")
616:         WITH THIS.txt_4c_GruOri
617:             .Top           = 447
618:             .Left          = 106
619:             .Width         = 80
620:             .Height        = 23
621:             .ReadOnly      = .T.
622:             .SpecialEffect = 1
623:             .Visible       = .T.
624:         ENDWITH
625:         THIS.AddObject("txt_4c_DesGruOri", "TextBox")
626:         WITH THIS.txt_4c_DesGruOri
627:             .Top           = 447
628:             .Left          = 187
629:             .Width         = 290
630:             .Height        = 23
631:             .ReadOnly      = .T.
632:             .SpecialEffect = 1
633:             .Visible       = .T.
634:         ENDWITH
635:         THIS.AddObject("txt_4c_ConOri", "TextBox")
636:         WITH THIS.txt_4c_ConOri
637:             .Top           = 471
638:             .Left          = 106
639:             .Width         = 80
640:             .Height        = 23
641:             .ReadOnly      = .T.
642:             .SpecialEffect = 1
643:             .Visible       = .T.
644:         ENDWITH
645:         THIS.AddObject("txt_4c_DesConOri", "TextBox")
646:         WITH THIS.txt_4c_DesConOri
647:             .Top           = 471
648:             .Left          = 187
649:             .Width         = 290
650:             .Height        = 23
651:             .ReadOnly      = .T.
652:             .SpecialEffect = 1
653:             .Visible       = .T.

*-- Linhas 695 a 836:
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     PROTECTED PROCEDURE ConfigurarAreaObs
699:     *--------------------------------------------------------------------------
700:         THIS.AddObject("obj_4c_Obs", "EditBox")
701:         WITH THIS.obj_4c_Obs
702:             .Top           = 514
703:             .Left          = 106
704:             .Width         = 875
705:             .Height        = 55
706:             .ReadOnly      = .T.
707:             .SpecialEffect = 1
708:             .Visible       = .T.
709:         ENDWITH
710:     ENDPROC
711: 
712:     *--------------------------------------------------------------------------
713:     PROTECTED PROCEDURE ConfigurarPaginaLista
714:     *-- Configura a area principal: label produto + grid historico + grid subniveis
715:     *--------------------------------------------------------------------------
716:         THIS.ConfigurarLabelProduto()
717:         THIS.ConfigurarGrdHistorico()
718:         THIS.ConfigurarGrdSubniveis()
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     PROTECTED PROCEDURE ConfigurarPaginaDados
723:     *-- Configura secao inferior (equivalente a Page2 em CRUD):
724:     *-- area de informacoes, labels de contas, campos de contas e observacao
725:     *--------------------------------------------------------------------------
726:         THIS.ConfigurarAreaInfo()
727:         THIS.ConfigurarLabelsAreaContas()
728:         THIS.ConfigurarCamposAreaContas()
729:         THIS.ConfigurarAreaObs()
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     PROCEDURE AlternarPagina
734:     *-- Form OPERACIONAL flat sem PageFrame: metodo mantido por simetria com pipeline
735:     *--------------------------------------------------------------------------
736:     LPARAMETERS par_nPagina
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     PROTECTED PROCEDURE TornarControlesVisiveis
741:     *--------------------------------------------------------------------------
742:     LPARAMETERS par_oContainer
743:         LOCAL loc_nI, loc_oControl
744:         FOR loc_nI = 1 TO par_oContainer.ControlCount
745:             loc_oControl = par_oContainer.Controls(loc_nI)
746:             IF INLIST(loc_oControl.BaseClass, "Container", "PageFrame", "Page")
747:                 THIS.TornarControlesVisiveis(loc_oControl)
748:             ENDIF
749:             IF INLIST(loc_oControl.BaseClass, "Grid", "Column", "Header", "Line")
750:                 LOOP
751:             ENDIF
752:             IF INLIST(LOWER(loc_oControl.Name), "cnt_4c_cabecalho")
753:                 LOOP
754:             ENDIF
755:             loc_oControl.Visible = .T.
756:         NEXT
757:     ENDPROC
758: 
759:     *--------------------------------------------------------------------------
760:     PROTECTED PROCEDURE ConfigurarEventos
761:     *--------------------------------------------------------------------------
762:         BINDEVENT(THIS.grd_4c_Historico,              "AfterRowColChange", THIS, "GrdHistoricoAfterRowColChange")
763:         BINDEVENT(THIS.chk_4c_ChkAuditado,            "Click",             THIS, "ChkAuditadoClick")
764:         BINDEVENT(THIS.cmd_4c_Procurar,               "Click",             THIS, "CmdProcurarClick")
765:         BINDEVENT(THIS.cmd_4c_BtnDocumento,           "Click",             THIS, "CmdMovimentoClick")
766:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",          THIS, "TxtDataKeyPress")
767:         BINDEVENT(THIS.txt_4c_Data,                   "KeyPress",         THIS, "TxtDataLostFocus")
768:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click",             THIS, "CmdEncerrarClick")
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     PROTECTED PROCEDURE CarregarDados
773:     *-- CarregarHistorico ja chama CarregarDadosProduto internamente
774:     *--------------------------------------------------------------------------
775:         LOCAL loc_lSucesso
776:         loc_lSucesso = .F.
777:         TRY
778:             THIS.this_oBusinessObject.CarregarHistorico()
779:             THIS.this_lEhPeso = THIS.this_oBusinessObject.this_lEhPeso
780:             THIS.grd_4c_Historico.Column8.Visible = THIS.this_lEhPeso
781:             THIS.grd_4c_Historico.Column9.Visible = THIS.this_lEhPeso
782:             THIS.lbl_4c_LabelProduto.Caption = THIS.this_cDsProduto
783:             IF USED("cursor_4c_Historico") AND RECCOUNT("cursor_4c_Historico") > 0
784:                 SELECT cursor_4c_Historico
785:                 GO BOTTOM
786:                 THIS.AtualizarCamposLinha()
787:             ENDIF
788:             THIS.grd_4c_Historico.Refresh()
789:             loc_lSucesso = .T.
790:         CATCH TO loc_oErro
791:             MsgErro(loc_oErro.Message, "Erro ao carregar dados")
792:         ENDTRY
793:     ENDPROC
794: 
795:     *--------------------------------------------------------------------------
796:     PROCEDURE AtualizarCamposLinha
797:     *--------------------------------------------------------------------------
798:         LOCAL loc_lSucesso
799:         loc_lSucesso = .F.
800:         IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
801:             RETURN
802:         ENDIF
803:         IF BOF("cursor_4c_Historico") OR EOF("cursor_4c_Historico")
804:             RETURN
805:         ENDIF
806:         TRY
807:             THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
808:             THIS.this_oBusinessObject.CarregarDocumento()
809:             THIS.this_oBusinessObject.CarregarDescricoesContabil()
810:             THIS.this_oBusinessObject.CarregarSubniveis()
811: 
812:             THIS.txt_4c_Auditors.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
813:             IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
814:                 THIS.txt_4c_DtAudits.Value = ""
815:             ELSE
816:                 THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
817:             ENDIF
818:             THIS.txt_4c_Usuario.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cUsuars)
819:             THIS.txt_4c_Nota.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cNotas)
820:             THIS.txt_4c_GruOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoOri)
821:             THIS.txt_4c_DesGruOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoOri)
822:             THIS.txt_4c_ConOri.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaOri)
823:             THIS.txt_4c_DesConOri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaOri)
824:             THIS.txt_4c_GruDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoDes)
825:             THIS.txt_4c_DesGruDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesGrupoDes)
826:             THIS.txt_4c_ConDes.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cContaDes)
827:             THIS.txt_4c_DesConDes.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDesContaDes)
828:             THIS.obj_4c_Obs.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cObs)
829: 
830:             THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
831:             THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
832:             IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
833:                 THIS.chk_4c_ChkAuditado.Visible = .T.
834:             ELSE
835:                 THIS.chk_4c_ChkAuditado.Visible = .F.
836:             ENDIF

*-- Linhas 843 a 1188:
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     PROCEDURE GrdHistoricoAfterRowColChange
847:     *--------------------------------------------------------------------------
848:     LPARAMETERS par_nColIndex
849:         THIS.AtualizarCamposLinha()
850:     ENDPROC
851: 
852:     *--------------------------------------------------------------------------
853:     PROCEDURE ChkAuditadoClick
854:     *--------------------------------------------------------------------------
855:         LOCAL loc_lSucesso, loc_lBOResult
856:         loc_lSucesso  = .F.
857:         loc_lBOResult = .F.
858:         TRY
859:             IF THIS.chk_4c_ChkAuditado.Value = 1
860:                 loc_lBOResult = THIS.this_oBusinessObject.AuditarRegistro()
861:             ELSE
862:                 loc_lBOResult = THIS.this_oBusinessObject.DesauditarRegistro()
863:             ENDIF
864:             IF loc_lBOResult
865:                 THIS.txt_4c_Auditors.Value = ALLTRIM(THIS.this_oBusinessObject.this_cAuditors)
866:                 IF EMPTY(THIS.this_oBusinessObject.this_dDtAudits)
867:                     THIS.txt_4c_DtAudits.Value = ""
868:                 ELSE
869:                     THIS.txt_4c_DtAudits.Value = DTOC(THIS.this_oBusinessObject.this_dDtAudits)
870:                 ENDIF
871:                 THIS.this_lTemAuditoria = !EMPTY(ALLTRIM(THIS.this_oBusinessObject.this_cAuditors))
872:                 THIS.chk_4c_ChkAuditado.Value = IIF(THIS.this_lTemAuditoria, 1, 0)
873:                 THIS.grd_4c_Historico.Refresh()
874:             ENDIF
875:             loc_lSucesso = .T.
876:         CATCH TO loc_oErro
877:             MsgErro(loc_oErro.Message, "Erro ao auditar registro")
878:         ENDTRY
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     PROCEDURE CmdProcurarClick
883:     *--------------------------------------------------------------------------
884:         THIS.lbl_4c_DataLabel.Visible = .T.
885:         THIS.txt_4c_Data.Visible      = .T.
886:         THIS.txt_4c_Data.Value        = DATE()
887:         THIS.txt_4c_Data.SetFocus()
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     PROCEDURE TxtDataKeyPress
892:     *--------------------------------------------------------------------------
893:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
894:         LOCAL loc_dData
895:         IF !INLIST(par_nKeyCode, 13, 9)
896:             RETURN
897:         ENDIF
898:         loc_dData = THIS.txt_4c_Data.Value
899:         THIS.txt_4c_Data.Visible      = .F.
900:         THIS.lbl_4c_DataLabel.Visible = .F.
901:         IF EMPTY(loc_dData) OR VARTYPE(loc_dData) != "D"
902:             RETURN
903:         ENDIF
904:         IF USED("cursor_4c_Historico")
905:             SET NEAR ON
906:             = SEEK(DTOS(loc_dData), "cursor_4c_Historico", "datas")
907:             SET NEAR OFF
908:             THIS.grd_4c_Historico.Refresh()
909:             THIS.AtualizarCamposLinha()
910:         ENDIF
911:         THIS.grd_4c_Historico.SetFocus()
912:     ENDPROC
913: 
914:     *--------------------------------------------------------------------------
915:     PROCEDURE TxtDataLostFocus
916:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
917:     *--------------------------------------------------------------------------
918:         THIS.txt_4c_Data.Visible      = .F.
919:         THIS.lbl_4c_DataLabel.Visible = .F.
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     PROCEDURE CmdMovimentoClick
924:     *--------------------------------------------------------------------------
925:         LOCAL loc_cTipoDoc, loc_lSucesso, loc_oForm
926:         loc_lSucesso = .F.
927:         loc_oForm    = .NULL.
928:         TRY
929:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
930:                 MsgAviso("Nenhum registro selecionado.")
931:             ELSE
932:                 THIS.this_oBusinessObject.CarregarDadosLinhaSelecionada()
933:                 loc_cTipoDoc = THIS.this_oBusinessObject.VerificarExistenciaDocumento()
934:                 DO CASE
935:                 CASE loc_cTipoDoc == "MOVCAB"
936:                     loc_oForm = CREATEOBJECT("FormSigMvExp", THIS)
937:                     IF VARTYPE(loc_oForm) == "O"
938:                         THIS.Enabled = .F.
939:                         loc_oForm.Show()
940:                     ENDIF
941:                 CASE loc_cTipoDoc == "NEC"
942:                     loc_oForm = CREATEOBJECT("FormSigMvPdt", THIS)
943:                     IF VARTYPE(loc_oForm) == "O"
944:                         THIS.Enabled = .F.
945:                         loc_oForm.Show()
946:                     ENDIF
947:                 OTHERWISE
948:                     MsgAviso("Documento n" + CHR(227) + "o encontrado.")
949:                 ENDCASE
950:             ENDIF
951:             loc_lSucesso = .T.
952:         CATCH TO loc_oErro
953:             MsgErro(loc_oErro.Message, "Erro ao abrir documento")
954:         ENDTRY
955:     ENDPROC
956: 
957:     *--------------------------------------------------------------------------
958:     PROCEDURE CmdEncerrarClick
959:     *--------------------------------------------------------------------------
960:         THIS.Release()
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * BtnIncluirClick - Alias CRUD para OPERACIONAL de consulta:
965:     *   "Incluir" nao se aplica ao Historico (readonly). Delega para
966:     *   CarregarDados() que recarrega o historico com o filtro atual
967:     *   (data/grupo/conta/produto) e reseleciona o ultimo registro.
968:     *==========================================================================
969:     PROCEDURE BtnIncluirClick()
970:         LOCAL loc_lSucesso
971:         loc_lSucesso = .F.
972:         TRY
973:             THIS.CarregarDados()
974:             loc_lSucesso = .T.
975:         CATCH TO loc_oErro
976:             MsgErro(loc_oErro.Message, "Erro ao recarregar hist" + CHR(243) + "rico")
977:         ENDTRY
978:     ENDPROC
979: 
980:     *==========================================================================
981:     * BtnAlterarClick - Alias CRUD para OPERACIONAL de consulta:
982:     *   "Alterar" no contexto de historico = marcar/desmarcar auditoria
983:     *   do registro selecionado. Valida permissao via VerificarPermissaoAuditoria
984:     *   e delega para ChkAuditadoClick que executa AuditarRegistro ou
985:     *   DesauditarRegistro no BO.
986:     *==========================================================================
987:     PROCEDURE BtnAlterarClick()
988:         LOCAL loc_lSucesso
989:         loc_lSucesso = .F.
990:         TRY
991:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
992:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
993:             ELSE
994:                 IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
995:                     THIS.chk_4c_ChkAuditado.Value = IIF(THIS.chk_4c_ChkAuditado.Value = 1, 0, 1)
996:                     THIS.ChkAuditadoClick()
997:                 ELSE
998:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
999:                 ENDIF
1000:             ENDIF
1001:             loc_lSucesso = .T.
1002:         CATCH TO loc_oErro
1003:             MsgErro(loc_oErro.Message, "Erro ao alterar auditoria")
1004:         ENDTRY
1005:     ENDPROC
1006: 
1007:     *==========================================================================
1008:     * BtnVisualizarClick - Alias CRUD para OPERACIONAL de consulta:
1009:     *   "Visualizar" abre o documento (SigMvCab ou SigCdNec) associado
1010:     *   a linha selecionada no grid de historico. Delega para
1011:     *   CmdMovimentoClick que faz VerificarExistenciaDocumento no BO
1012:     *   e instancia FormSigMvExp (movimento) ou FormSigMvPdt (necessidade).
1013:     *==========================================================================
1014:     PROCEDURE BtnVisualizarClick()
1015:         THIS.CmdMovimentoClick()
1016:     ENDPROC
1017: 
1018:     *==========================================================================
1019:     * BtnExcluirClick - Alias CRUD para OPERACIONAL de consulta:
1020:     *   Historico de movimentacao eh readonly - registros nao podem ser
1021:     *   excluidos individualmente. Interpretacao canonica: "Excluir" =
1022:     *   remover marca de auditoria (unico atributo mutavel do registro).
1023:     *   Solicita MsgConfirma antes e delega para ChkAuditadoClick com
1024:     *   toggle para desmarcar.
1025:     *==========================================================================
1026:     PROCEDURE BtnExcluirClick()
1027:         LOCAL loc_lSucesso, loc_cTitulo
1028:         loc_lSucesso = .F.
1029:         loc_cTitulo  = "Remover Auditoria"
1030:         TRY
1031:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1032:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
1033:             ELSE
1034:                 IF !THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1035:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
1036:                 ELSE
1037:                     IF THIS.chk_4c_ChkAuditado.Value = 1
1038:                         IF MsgConfirma("Confirma remover a marca" + CHR(231) + CHR(227) + "o de auditoria deste registro?", loc_cTitulo)
1039:                             THIS.chk_4c_ChkAuditado.Value = 0
1040:                             THIS.ChkAuditadoClick()
1041:                         ENDIF
1042:                     ELSE
1043:                         MsgAviso("O registro selecionado n" + CHR(227) + "o est" + CHR(225) + " marcado como auditado.")
1044:                     ENDIF
1045:                 ENDIF
1046:             ENDIF
1047:             loc_lSucesso = .T.
1048:         CATCH TO loc_oErro
1049:             MsgErro(loc_oErro.Message, "Erro ao remover auditoria")
1050:         ENDTRY
1051:     ENDPROC
1052: 
1053:     *--------------------------------------------------------------------------
1054:     PROCEDURE Destroy
1055:     *--------------------------------------------------------------------------
1056:         IF VARTYPE(THIS.this_oParentForm) == "O"
1057:             THIS.this_oParentForm.Enabled = .T.
1058:         ENDIF
1059:         THIS.this_oBusinessObject = .NULL.
1060:         DODEFAULT()
1061:     ENDPROC
1062: 
1063:     *--------------------------------------------------------------------------
1064:     * CarregarLista - Alias FormBase: delega para CarregarDados
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE CarregarLista
1067:         THIS.CarregarDados()
1068:     ENDPROC
1069: 
1070:     *--------------------------------------------------------------------------
1071:     * BtnBuscarClick - Exibe campo de filtro por data (igual ao botao Procurar)
1072:     *--------------------------------------------------------------------------
1073:     PROCEDURE BtnBuscarClick
1074:         THIS.CmdProcurarClick()
1075:     ENDPROC
1076: 
1077:     *--------------------------------------------------------------------------
1078:     * BtnEncerrarClick - Encerra o formulario
1079:     *--------------------------------------------------------------------------
1080:     PROCEDURE BtnEncerrarClick
1081:         THIS.CmdEncerrarClick()
1082:     ENDPROC
1083: 
1084:     *==========================================================================
1085:     * BtnSalvarClick - Alias CRUD para OPERACIONAL de auditoria:
1086:     *   "Salvar" = confirmar a marcacao/desmarcacao de auditoria do registro
1087:     *   selecionado. Verifica permissao e delega para ChkAuditadoClick.
1088:     *==========================================================================
1089:     PROCEDURE BtnSalvarClick
1090:         LOCAL loc_lSucesso
1091:         loc_lSucesso = .F.
1092:         TRY
1093:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
1094:                 MsgAviso("Nenhum registro selecionado no hist" + CHR(243) + "rico.")
1095:             ELSE
1096:                 IF THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1097:                     THIS.ChkAuditadoClick()
1098:                 ELSE
1099:                     MsgAviso("Usu" + CHR(225) + "rio sem permiss" + CHR(227) + "o de auditoria.")
1100:                 ENDIF
1101:             ENDIF
1102:             loc_lSucesso = .T.
1103:         CATCH TO loc_oErro
1104:             MsgErro(loc_oErro.Message, "Erro ao salvar auditoria")
1105:         ENDTRY
1106:     ENDPROC
1107: 
1108:     *==========================================================================
1109:     * BtnCancelarClick - Alias CRUD para OPERACIONAL:
1110:     *   Oculta o campo de filtro por data e restaura foco ao grid.
1111:     *==========================================================================
1112:     PROCEDURE BtnCancelarClick
1113:         THIS.txt_4c_Data.Visible      = .F.
1114:         THIS.lbl_4c_DataLabel.Visible = .F.
1115:         THIS.grd_4c_Historico.SetFocus()
1116:     ENDPROC
1117: 
1118:     *--------------------------------------------------------------------------
1119:     * FormParaBO - Sincroniza estado do form -> BO
1120:     *   OPERACIONAL: propaga parametros de contexto e estado do checkbox
1121:     *--------------------------------------------------------------------------
1122:     PROCEDURE FormParaBO
1123:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1124:             RETURN
1125:         ENDIF
1126:         THIS.this_oBusinessObject.this_lTemAuditoria = (THIS.chk_4c_ChkAuditado.Value = 1)
1127:         THIS.this_oBusinessObject.this_cCdGrupo      = THIS.this_cCdGrupo
1128:         THIS.this_oBusinessObject.this_cCdConta      = THIS.this_cCdConta
1129:         THIS.this_oBusinessObject.this_cCdProduto    = THIS.this_cCdProduto
1130:         THIS.this_oBusinessObject.this_cDsProduto    = THIS.this_cDsProduto
1131:         THIS.this_oBusinessObject.this_dDataIni      = THIS.this_dDataIni
1132:         THIS.this_oBusinessObject.this_dDataFim      = THIS.this_dDataFim
1133:     ENDPROC
1134: 
1135:     *--------------------------------------------------------------------------
1136:     * BOParaForm - Sincroniza estado do BO -> form
1137:     *   OPERACIONAL: atualiza campos de exibicao da linha corrente
1138:     *--------------------------------------------------------------------------
1139:     PROCEDURE BOParaForm
1140:         THIS.AtualizarCamposLinha()
1141:     ENDPROC
1142: 
1143:     *--------------------------------------------------------------------------
1144:     * HabilitarCampos - OPERACIONAL: campos sao ReadOnly por natureza.
1145:     *   Gerencia apenas visibilidade do checkbox de auditoria conforme permissao.
1146:     *--------------------------------------------------------------------------
1147:     PROCEDURE HabilitarCampos
1148:     LPARAMETERS par_cModo
1149:         LOCAL loc_lPermite
1150:         loc_lPermite = .F.
1151:         TRY
1152:             IF VARTYPE(THIS.this_oBusinessObject) == "O"
1153:                 loc_lPermite = THIS.this_oBusinessObject.VerificarPermissaoAuditoria()
1154:             ENDIF
1155:             THIS.chk_4c_ChkAuditado.Visible = loc_lPermite
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
1158:         ENDTRY
1159:     ENDPROC
1160: 
1161:     *--------------------------------------------------------------------------
1162:     * LimparCampos - Limpa todos os campos de exibicao da linha selecionada
1163:     *--------------------------------------------------------------------------
1164:     PROCEDURE LimparCampos
1165:         THIS.txt_4c_Auditors.Value    = ""
1166:         THIS.txt_4c_DtAudits.Value    = ""
1167:         THIS.txt_4c_Usuario.Value     = ""
1168:         THIS.txt_4c_Nota.Value        = ""
1169:         THIS.txt_4c_GruOri.Value      = ""
1170:         THIS.txt_4c_DesGruOri.Value   = ""
1171:         THIS.txt_4c_ConOri.Value      = ""
1172:         THIS.txt_4c_DesConOri.Value   = ""
1173:         THIS.txt_4c_GruDes.Value      = ""
1174:         THIS.txt_4c_DesGruDes.Value   = ""
1175:         THIS.txt_4c_ConDes.Value      = ""
1176:         THIS.txt_4c_DesConDes.Value   = ""
1177:         THIS.obj_4c_Obs.Value         = ""
1178:         THIS.chk_4c_ChkAuditado.Value = 0
1179:     ENDPROC
1180: 
1181:     *--------------------------------------------------------------------------
1182:     * AjustarBotoesPorModo - OPERACIONAL sem modos CRUD: no-op de compatibilidade
1183:     *--------------------------------------------------------------------------
1184:     PROCEDURE AjustarBotoesPorModo
1185:     LPARAMETERS par_cModo
1186:     ENDPROC
1187: 
1188: ENDDEFINE


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

