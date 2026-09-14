# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_xGrava' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (904 linhas total):

*-- Linhas 9 a 133:
9: *   CODE -> arquitetura em camadas (FormBase / SIGPRCPRBO)
10: *
11: * CHAMADA (por form pai, ex: FormSIGPRCIC):
12: *   loForm = CREATEOBJECT("FormSIGPRCPR", loFormPai)
13: *   loForm.Show()
14: *==============================================================================
15: 
16: DEFINE CLASS FormSIGPRCPR AS FormBase
17: 
18:     Height       = 400
19:     Width        = 800
20:     BorderStyle  = 2
21:     AutoCenter   = .T.
22:     TitleBar     = 0
23:     ControlBox   = .F.
24:     Closable     = .F.
25:     MaxButton    = .F.
26:     MinButton    = .F.
27:     ClipControls = .F.
28:     DataSession  = 2
29:     ShowWindow   = 1
30:     WindowType   = 1
31:     FontName     = "Tahoma"
32:     FontSize     = 8
33:     Caption      = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
34: 
35:     *-- Referencia ao form pai (recebe TmpEnc e DataSessionId)
36:     this_oParent         = .NULL.
37: 
38:     *-- Business Object
39:     this_oBusinessObject = .NULL.
40: 
41:     *==========================================================================
42:     PROCEDURE Init()
43:     *==========================================================================
44:         LPARAMETERS par_oParent
45: 
46:         IF VARTYPE(par_oParent) = "O"
47:             THIS.this_oParent  = par_oParent
48:             THIS.DataSessionId = par_oParent.DataSessionId
49:         ENDIF
50: 
51:         RETURN DODEFAULT()
52:     ENDPROC
53: 
54:     *==========================================================================
55:     PROTECTED PROCEDURE ConfigurarPageFrame()
56:     *==========================================================================
57:         LOCAL loc_cImgFundo
58:         loc_cImgFundo = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
59:         IF FILE(loc_cImgFundo)
60:             THIS.Picture = loc_cImgFundo
61:         ENDIF
62:         THIS.ScrollBars = 0
63:     ENDPROC
64: 
65:     *==========================================================================
66:     PROTECTED PROCEDURE InicializarForm()
67:     *==========================================================================
68:         LOCAL loc_lSucesso, loc_oErro
69:         loc_lSucesso = .F.
70:         TRY
71:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")
72:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
73:                 MsgErro("Falha ao criar SIGPRCPRBO", "Erro")
74:                 loc_lSucesso = .F.
75:             ENDIF
76: 
77:             THIS.ConfigurarPageFrame()
78:             THIS.ConfigurarCabecalho()
79:             THIS.ConfigurarPaginaDados()
80:             THIS.ConfigurarBotoes()
81:             THIS.ConfigurarPaginaLista()
82:             THIS.TornarControlesVisiveis()
83:             THIS.ConfigurarBINDEVENTs()
84:             THIS.InicializarValores()
85:             loc_lSucesso = .T.
86:         CATCH TO loc_oErro
87:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
88:         ENDTRY
89:         RETURN loc_lSucesso
90:     ENDPROC
91: 
92:     *==========================================================================
93:     PROTECTED PROCEDURE ConfigurarCabecalho()
94:     *==========================================================================
95:         LOCAL loc_nW, loc_cCaption
96:         loc_nW      = THIS.Width
97:         loc_cCaption = THIS.Caption
98: 
99:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
100:         WITH THIS.cnt_4c_Cabecalho
101:             .Top         = 0
102:             .Left        = 0
103:             .Width       = loc_nW
104:             .Height      = 80
105:             .BackStyle   = 1
106:             .BackColor   = RGB(100, 100, 100)
107:             .BorderWidth = 0
108: 
109:             .AddObject("lbl_4c_Sombra", "Label")
110:             WITH .lbl_4c_Sombra
111:                 .AutoSize      = .F.
112:                 .Width         = loc_nW
113:                 .Height        = 40
114:                 .Top           = 18
115:                 .Left          = 10
116:                 .Caption       = loc_cCaption
117:                 .FontName      = "Tahoma"
118:                 .FontSize      = 18
119:                 .FontBold      = .T.
120:                 .FontUnderline = .F.
121:                 .WordWrap      = .T.
122:                 .Alignment     = 0
123:                 .BackStyle     = 0
124:                 .ForeColor     = RGB(0, 0, 0)
125:             ENDWITH
126: 
127:             .AddObject("lbl_4c_Titulo", "Label")
128:             WITH .lbl_4c_Titulo
129:                 .AutoSize   = .F.
130:                 .Width      = loc_nW
131:                 .Height     = 46
132:                 .Top        = 17
133:                 .Left       = 10

*-- Linhas 139 a 192:
139:                 .Alignment  = 0
140:                 .BackStyle  = 0
141:                 .ForeColor  = RGB(255, 255, 255)
142:             ENDWITH
143:         ENDWITH
144:         THIS.cnt_4c_Cabecalho.Visible = .T.
145:     ENDPROC
146: 
147:     *==========================================================================
148:     * ConfigurarPaginaDados - Configura os campos principais do form OPERACIONAL
149:     * (form flat sem PageFrame, portanto sem Page2 literal; os campos abaixo
150:     * correspondem semanticamente aa "pagina de dados" do padrao CRUD).
151:     *==========================================================================
152:     PROTECTED PROCEDURE ConfigurarPaginaDados()
153:         *-- Label "Data :"
154:         THIS.AddObject("lbl_4c_Data", "Label")
155:         WITH THIS.lbl_4c_Data
156:             .AutoSize  = .T.
157:             .FontName  = "Tahoma"
158:             .FontSize  = 8
159:             .BackStyle = 0
160:             .Caption   = "Data : "
161:             .Height    = 15
162:             .Left      = 133
163:             .Top       = 110
164:             .Width     = 35
165:             .ForeColor = RGB(90, 90, 90)
166:         ENDWITH
167: 
168:         *-- TextBox data (ReadOnly, exibe data da operacao do form pai)
169:         THIS.AddObject("txt_4c_Data", "TextBox")
170:         WITH THIS.txt_4c_Data
171:             .FontName          = "Tahoma"
172:             .FontSize          = 8
173:             .Alignment         = 3
174:             .Value             = DATE()
175:             .Height            = 23
176:             .Left              = 170
177:             .ReadOnly          = .T.
178:             .SpecialEffect     = 1
179:             .Top               = 107
180:             .Width             = 80
181:             .DisabledBackColor = RGB(255, 255, 255)
182:             .BorderColor       = RGB(100, 100, 100)
183:         ENDWITH
184: 
185:         *-- Label "Codigo de barra :" (oculto ate TmpBaixa ter dados)
186:         THIS.AddObject("lbl_4c_Leitura", "Label")
187:         WITH THIS.lbl_4c_Leitura
188:             .AutoSize  = .F.
189:             .FontName  = "Tahoma"
190:             .FontSize  = 8
191:             .BackStyle = 0
192:             .Caption   = "C" + CHR(243) + "digo de barra :"

*-- Linhas 214 a 257:
214:     ENDPROC
215: 
216:     *==========================================================================
217:     PROTECTED PROCEDURE ConfigurarBotoes()
218:     *==========================================================================
219:         LOCAL loc_cIcones
220:         loc_cIcones = gc_4c_CaminhoIcones
221: 
222:         *-- Botao "Conf. Auto" (Left=575) - oculto ate TmpBaixa ter dados
223:         THIS.AddObject("cmd_4c_ConferirAuto", "CommandButton")
224:         WITH THIS.cmd_4c_ConferirAuto
225:             .Top             = 3
226:             .Left            = 575
227:             .Width           = 75
228:             .Height          = 75
229:             .Caption         = "Conf. Auto"
230:             .Picture         = loc_cIcones + "geral_servicos_60.jpg"
231:             .Themes          = .T.
232:             .DisabledPicture = loc_cIcones + "geral_servicos_60.jpg"
233:             .FontName        = "Tahoma"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .FontSize        = 8
237:             .ForeColor       = RGB(90, 90, 90)
238:             .PicturePosition = 13
239:             .WordWrap        = .T.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .Visible         = .F.
243:         ENDWITH
244: 
245:         *-- Botao "Ok" confirmar conferencia (Left=650) - oculto ate TmpBaixa ter dados
246:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
247:         WITH THIS.cmd_4c_Ok
248:             .Top             = 3
249:             .Left            = 650
250:             .Width           = 75
251:             .Height          = 75
252:             .Caption         = "Ok"
253:             .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
254:             .Themes          = .T.
255:             .DisabledPicture = loc_cIcones + "cadastro_salvar_60.jpg"
256:             .FontName        = "Tahoma"
257:             .FontBold        = .T.

*-- Linhas 294 a 342:
294:     * Em form OPERACIONAL flat (sem PageFrame), a "pagina lista" eh a regiao
295:     * central com a grade de etiquetas + o textbox de leitura de codigo de barra.
296:     *==========================================================================
297:     PROTECTED PROCEDURE ConfigurarPaginaLista()
298:         THIS.ConfigurarGrade()
299:     ENDPROC
300: 
301:     *==========================================================================
302:     PROTECTED PROCEDURE ConfigurarGrade()
303:     *==========================================================================
304:         THIS.AddObject("grd_4c_Dados", "Grid")
305:         WITH THIS.grd_4c_Dados
306:             .Top               = 140
307:             .Left              = 133
308:             .Width             = 534
309:             .Height            = 207
310:             .ColumnCount       = 5
311:             .FontSize          = 8
312:             .FontName          = "Tahoma"
313:             .AllowHeaderSizing = .F.
314:             .AllowRowSizing    = .F.
315:             .DeleteMark        = .F.
316:             .RecordMark        = .F.
317:             .ReadOnly          = .T.
318:             .RowHeight         = 17
319:             .ScrollBars        = 2
320:             .Panel             = 1
321:             .Visible           = .F.
322: 
323:             WITH .Column1
324:                 .Width            = 108
325:                 .Movable          = .F.
326:                 .Resizable        = .F.
327:                 .ReadOnly         = .T.
328:                 .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
329:                 WITH .Header1
330:                     .FontName  = "Tahoma"
331:                     .FontSize  = 8
332:                     .Alignment = 2
333:                     .Caption   = "C" + CHR(243) + "d. Barra"
334:                 ENDWITH
335:             ENDWITH
336: 
337:             WITH .Column2
338:                 .Width            = 108
339:                 .Movable          = .F.
340:                 .Resizable        = .F.
341:                 .ReadOnly         = .T.
342:                 .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"

*-- Linhas 393 a 446:
393:     ENDPROC
394: 
395:     *==========================================================================
396:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
397:     *==========================================================================
398:         BINDEVENT(THIS.cmd_4c_ConferirAuto, "Click", THIS, "CmdConferirAutoClick")
399:         BINDEVENT(THIS.cmd_4c_Ok,           "Click", THIS, "CmdOkClick")
400:         BINDEVENT(THIS.cmd_4c_Encerrar,     "Click", THIS, "CmdEncerrarClick")
401:         BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
402:         BINDEVENT(THIS, "Activate", THIS, "FormActivate")
403:     ENDPROC
404: 
405:     *==========================================================================
406:     PROTECTED PROCEDURE InicializarValores()
407:     *==========================================================================
408:         LOCAL loc_lSucesso, loc_oErro
409:         loc_lSucesso = .F.
410:         TRY
411:             *-- Data da operacao herdada do form pai
412:             IF VARTYPE(THIS.this_oParent) = "O"
413:                 IF PEMSTATUS(THIS.this_oParent, "txt_4c_Data", 5)
414:                     THIS.txt_4c_Data.Value = THIS.this_oParent.txt_4c_Data.Value
415:                 ELSE
416:                     IF PEMSTATUS(THIS.this_oParent, "Get_Data", 5)
417:                     THIS.txt_4c_Data.Value = THIS.this_oParent.Get_Data.Value
418:                     ENDIF
419:                 ENDIF
420:             ENDIF
421: 
422:             *-- Criar cursor TmpBaixa vazio (sempre - independe de ValidandoUI)
423:             THIS.this_oBusinessObject.InicializarCursores()
424: 
425:             *-- Carregar dados apenas fora de modo ValidarUIFidelity (requer SQL + TmpEnc do pai)
426:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
427:                 *-- Carregar SigKey de SigCdPac (usado em ConfirmarConferencia)
428:                 THIS.this_oBusinessObject.CarregarSigKey()
429: 
430:                 *-- Carregar etiquetas do cursor TmpEnc do form pai para TmpBaixa
431:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
432:             ENDIF
433: 
434:             *-- Vincular grade ao TmpBaixa (vazio ou populado)
435:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
436:                 WITH THIS.grd_4c_Dados
437:                     .ColumnCount       = 5
438:                     .RecordSource          = "TmpBaixa"
439:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
440:                     .Column2.ControlSource = "TmpBaixa.CPros"
441:                     .Column3.ControlSource = "TmpBaixa.Dopes"
442:                     .Column4.ControlSource = "TmpBaixa.Numes"
443:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
444:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
445:                     .Column2.Header1.Caption = "Produto"
446:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"

*-- Linhas 473 a 904:
473:     *                  - Grade visivel, leitura visivel, botoes Ok/ConfAuto visiveis
474:     *                  - Foco automatico no textbox de leitura
475:     *==========================================================================
476:     PROCEDURE AlternarPagina(par_nModo)
477:         LOCAL loc_lTemDados
478:         loc_lTemDados = (par_nModo = 2)
479: 
480:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
481:             THIS.grd_4c_Dados.Visible = loc_lTemDados
482:         ENDIF
483:         IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
484:             THIS.lbl_4c_Leitura.Visible = loc_lTemDados
485:         ENDIF
486:         IF VARTYPE(THIS.txt_4c_Leitura) = "O"
487:             THIS.txt_4c_Leitura.Visible = loc_lTemDados
488:         ENDIF
489:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
490:             THIS.cmd_4c_Ok.Visible = loc_lTemDados
491:         ENDIF
492:         IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
493:             THIS.cmd_4c_ConferirAuto.Visible = loc_lTemDados
494:         ENDIF
495: 
496:         IF loc_lTemDados AND VARTYPE(THIS.txt_4c_Leitura) = "O"
497:             THIS.txt_4c_Leitura.SetFocus()
498:         ENDIF
499:     ENDPROC
500: 
501:     *==========================================================================
502:     PROCEDURE TornarControlesVisiveis()
503:     *==========================================================================
504:         LPARAMETERS par_oContainer
505:         LOCAL loc_oContainer, loc_i, loc_oControl, loc_nP, loc_cNome
506: 
507:         IF VARTYPE(par_oContainer) = "O"
508:             loc_oContainer = par_oContainer
509:         ELSE
510:             loc_oContainer = THIS
511:         ENDIF
512: 
513:         FOR loc_i = 1 TO loc_oContainer.ControlCount
514:             loc_oControl = loc_oContainer.Controls(loc_i)
515:             IF VARTYPE(loc_oControl) = "O"
516:                 IF PEMSTATUS(loc_oControl, "Name", 5)
517:                     loc_cNome = UPPER(ALLTRIM(loc_oControl.Name))
518:                 ELSE
519:                     loc_cNome = ""
520:                 ENDIF
521: 
522:                 *-- Controles que iniciam ocultos, controlados por AlternarPagina()
523:                 IF INLIST(loc_cNome, "GRD_4C_DADOS", "TXT_4C_LEITURA", "LBL_4C_LEITURA", ;
524:                                      "CMD_4C_OK", "CMD_4C_CONFERIRAUTO")
525:                     *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
526:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
527:                         THIS.TornarControlesVisiveis(loc_oControl)
528:                     ENDIF
529:                     LOOP
530:                 ENDIF
531: 
532:                 IF UPPER(ALLTRIM(loc_oControl.BaseClass)) = "PAGEFRAME"
533:                     FOR loc_nP = 1 TO loc_oControl.PageCount
534:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
535:                     ENDFOR
536:                 ENDIF
537:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
538:                     THIS.TornarControlesVisiveis(loc_oControl)
539:                 ENDIF
540:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
541:                     loc_oControl.Visible = .T.
542:                 ENDIF
543:             ENDIF
544:         ENDFOR
545:     ENDPROC
546: 
547:     *==========================================================================
548:     PROCEDURE FormActivate()
549:     *==========================================================================
550:         IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
551:             THIS.txt_4c_Leitura.SetFocus()
552:         ENDIF
553:     ENDPROC
554: 
555:     *==========================================================================
556:     PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
557:     *==========================================================================
558:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
559:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
560:             RETURN
561:         ENDIF
562:         LOCAL loc_nCodBarra, loc_oErro
563:         TRY
564:             IF !EMPTY(THIS.txt_4c_Leitura.Value) AND THIS.txt_4c_Leitura.Value <> 0
565:                 loc_nCodBarra = THIS.txt_4c_Leitura.Value
566:                 THIS.this_oBusinessObject.MarcarLeitura(loc_nCodBarra)
567:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
568:                     SELECT TmpBaixa
569:                     SET ORDER TO CodBarra
570:                     SEEK loc_nCodBarra
571:                     THIS.grd_4c_Dados.Refresh()
572:                 ENDIF
573:                 THIS.txt_4c_Leitura.Value = 0
574:             ELSE
575:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
576:                     THIS.grd_4c_Dados.Refresh()
577:                 ENDIF
578:             ENDIF
579:             par_nKeyCode = 0
580:         CATCH TO loc_oErro
581:             MsgErro(loc_oErro.Message, "Erro Leitura")
582:         ENDTRY
583:     ENDPROC
584: 
585:     *==========================================================================
586:     PROCEDURE CmdConferirAutoClick()
587:     *==========================================================================
588:         LOCAL loc_oErro
589:         TRY
590:             THIS.this_oBusinessObject.ConferirAutomatico()
591:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
592:                 THIS.grd_4c_Dados.Refresh()
593:             ENDIF
594:         CATCH TO loc_oErro
595:             MsgErro(loc_oErro.Message, "Erro Conferir Auto")
596:         ENDTRY
597:     ENDPROC
598: 
599:     *==========================================================================
600:     PROCEDURE CmdOkClick()
601:     *==========================================================================
602:         LOCAL loc_lOk
603:         IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?")
604:             IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
605:                 THIS.txt_4c_Leitura.SetFocus()
606:             ENDIF
607:             RETURN
608:         ENDIF
609: 
610:         loc_lOk = THIS.this_oBusinessObject.ConfirmarConferencia()
611:         IF loc_lOk
612:             IF VARTYPE(THIS.this_oParent) = "O"
613:                 THIS.this_oParent.Enabled = .T.
614:             ENDIF
615:             THIS.Release()
616:         ELSE
617:             IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
618:                 THIS.txt_4c_Leitura.SetFocus()
619:             ENDIF
620:         ENDIF
621:     ENDPROC
622: 
623:     *==========================================================================
624:     PROCEDURE CmdEncerrarClick()
625:     *==========================================================================
626:         IF VARTYPE(THIS.this_oParent) = "O"
627:             THIS.this_oParent.Enabled = .T.
628:         ENDIF
629:         THIS.Release()
630:     ENDPROC
631: 
632:     *==========================================================================
633:     * BtnIncluirClick - Inicia nova leitura de etiqueta (foco no leitor de barras)
634:     * Mapeamento semantico: em form OPERACIONAL, "incluir" = adicionar leitura
635:     *==========================================================================
636:     PROCEDURE BtnIncluirClick()
637:         LOCAL loc_oErro
638:         TRY
639:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
640:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
641:                 RETURN
642:             ENDIF
643: 
644:             IF VARTYPE(THIS.txt_4c_Leitura) = "O"
645:                 THIS.txt_4c_Leitura.Visible = .T.
646:                 THIS.txt_4c_Leitura.Enabled = .T.
647:                 THIS.txt_4c_Leitura.Value   = 0
648:                 THIS.txt_4c_Leitura.SetFocus()
649:             ENDIF
650: 
651:             IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
652:                 THIS.lbl_4c_Leitura.Visible = .T.
653:             ENDIF
654:         CATCH TO loc_oErro
655:             MsgErro(loc_oErro.Message, "Erro BtnIncluir")
656:         ENDTRY
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * BtnAlterarClick - Marca todas as etiquetas como lidas (conferencia automatica)
661:     * Mapeamento semantico: em form OPERACIONAL, "alterar" = marcar todas as leituras
662:     * Delega a logica real para ConferirAutomatico() do BO (mesma que CmdConferirAuto)
663:     *==========================================================================
664:     PROCEDURE BtnAlterarClick()
665:         LOCAL loc_oErro
666:         TRY
667:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
668:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
669:                 RETURN
670:             ENDIF
671: 
672:             IF !MsgConfirma("Marcar TODAS as etiquetas como lidas?")
673:                 RETURN
674:             ENDIF
675: 
676:             THIS.this_oBusinessObject.ConferirAutomatico()
677:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
678:                 THIS.grd_4c_Dados.Refresh()
679:             ENDIF
680:         CATCH TO loc_oErro
681:             MsgErro(loc_oErro.Message, "Erro BtnAlterar")
682:         ENDTRY
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnVisualizarClick - Recarrega etiquetas do form pai e atualiza a grade
687:     * Mapeamento semantico: em form OPERACIONAL, "visualizar" = recarregar/refresh
688:     *==========================================================================
689:     PROCEDURE BtnVisualizarClick()
690:         LOCAL loc_oErro
691:         TRY
692:             IF VARTYPE(THIS.this_oParent) = "O"
693:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
694:             ENDIF
695: 
696:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
697:                 THIS.grd_4c_Dados.Refresh()
698:             ENDIF
699: 
700:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
701:                 THIS.AlternarPagina(2)
702:             ELSE
703:                 THIS.AlternarPagina(1)
704:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para confer" + CHR(234) + "ncia.", "Aviso")
705:             ENDIF
706:         CATCH TO loc_oErro
707:             MsgErro(loc_oErro.Message, "Erro BtnVisualizar")
708:         ENDTRY
709:     ENDPROC
710: 
711:     *==========================================================================
712:     * BtnExcluirClick - Limpa TODAS as leituras marcadas (zera QtdeLido)
713:     * Mapeamento semantico: em form OPERACIONAL, "excluir" = remover leituras
714:     * Operacao inversa de BtnAlterarClick / ConferirAutomatico
715:     *==========================================================================
716:     PROCEDURE BtnExcluirClick()
717:         LOCAL loc_oErro
718:         TRY
719:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
720:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para limpar.", "Aviso")
721:                 RETURN
722:             ENDIF
723: 
724:             IF !MsgConfirma("Limpar TODAS as leituras marcadas?")
725:                 RETURN
726:             ENDIF
727: 
728:             SELECT TmpBaixa
729:             REPLACE ALL QtdeLido WITH 0
730: 
731:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
732:                 THIS.grd_4c_Dados.Refresh()
733:             ENDIF
734:         CATCH TO loc_oErro
735:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
736:         ENDTRY
737:     ENDPROC
738: 
739:     *==========================================================================
740:     * CarregarLista - Recarrega etiquetas de TmpEnc e atualiza a grade
741:     *==========================================================================
742:     PROCEDURE CarregarLista()
743:         LOCAL loc_lResultado, loc_oErro
744:         loc_lResultado = .F.
745:         TRY
746:             IF VARTYPE(THIS.this_oParent) = "O"
747:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
748:             ENDIF
749: 
750:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
751:                 WITH THIS.grd_4c_Dados
752:                     .ColumnCount       = 5
753:                     .RecordSource          = "TmpBaixa"
754:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
755:                     .Column2.ControlSource = "TmpBaixa.CPros"
756:                     .Column3.ControlSource = "TmpBaixa.Dopes"
757:                     .Column4.ControlSource = "TmpBaixa.Numes"
758:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
759:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
760:                     .Column2.Header1.Caption = "Produto"
761:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
762:                     .Column4.Header1.Caption = "N" + CHR(250) + "mero"
763:                     .Column5.Header1.Caption = "Qtde."
764:                     .Refresh()
765:                 ENDWITH
766:             ENDIF
767: 
768:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
769:                 THIS.AlternarPagina(2)
770:             ELSE
771:                 THIS.AlternarPagina(1)
772:             ENDIF
773: 
774:             loc_lResultado = .T.
775:         CATCH TO loc_oErro
776:             MsgErro(loc_oErro.Message, "Erro CarregarLista")
777:         ENDTRY
778:         RETURN loc_lResultado
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * FormParaBO - Transfere estado do form para o Business Object
783:     *==========================================================================
784:     PROCEDURE FormParaBO()
785:         LOCAL loc_oErro
786:         TRY
787:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
788:                 IF VARTYPE(THIS.txt_4c_Data) = "O"
789:                     THIS.this_oBusinessObject.this_dData = THIS.txt_4c_Data.Value
790:                 ENDIF
791:             ENDIF
792:         CATCH TO loc_oErro
793:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
794:         ENDTRY
795:     ENDPROC
796: 
797:     *==========================================================================
798:     * BOParaForm - Carrega estado do Business Object para o form
799:     *==========================================================================
800:     PROCEDURE BOParaForm()
801:         LOCAL loc_oErro
802:         TRY
803:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
804:                 IF VARTYPE(THIS.txt_4c_Data) = "O"
805:                     IF !EMPTY(THIS.this_oBusinessObject.this_dData)
806:                         THIS.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
807:                     ENDIF
808:                 ENDIF
809:             ENDIF
810:         CATCH TO loc_oErro
811:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
812:         ENDTRY
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * HabilitarCampos - Habilita/desabilita controles conforme estado atual
817:     * par_lHabilitar = .T.: habilita leitura (TmpBaixa com dados)
818:     *                  .F.: desabilita leitura (TmpBaixa vazio)
819:     *==========================================================================
820:     PROCEDURE HabilitarCampos(par_lHabilitar)
821:         LOCAL loc_lHabilitar
822:         loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
823:         IF VARTYPE(THIS.txt_4c_Leitura) = "O"
824:             THIS.txt_4c_Leitura.Enabled = loc_lHabilitar
825:         ENDIF
826:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
827:             THIS.cmd_4c_Ok.Visible = loc_lHabilitar
828:         ENDIF
829:         IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
830:             THIS.cmd_4c_ConferirAuto.Visible = loc_lHabilitar
831:         ENDIF
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * LimparCampos - Zera o campo de leitura de codigo de barras
836:     *==========================================================================
837:     PROCEDURE LimparCampos()
838:         LOCAL loc_oErro
839:         TRY
840:             IF VARTYPE(THIS.txt_4c_Leitura) = "O"
841:                 THIS.txt_4c_Leitura.Value = 0
842:             ENDIF
843:         CATCH TO loc_oErro
844:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
845:         ENDTRY
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme dados
850:     * Verifica TmpBaixa e chama AlternarPagina para sincronizar estado visual
851:     *==========================================================================
852:     PROCEDURE AjustarBotoesPorModo()
853:         IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
854:             THIS.AlternarPagina(2)
855:             THIS.HabilitarCampos(.T.)
856:         ELSE
857:             THIS.AlternarPagina(1)
858:             THIS.HabilitarCampos(.F.)
859:         ENDIF
860:     ENDPROC
861: 
862:     *==========================================================================
863:     * BtnBuscarClick - Recarrega etiquetas do form pai (refresh completo)
864:     * Mapeamento semantico: em form OPERACIONAL, "buscar" = recarregar dados
865:     *==========================================================================
866:     PROCEDURE BtnBuscarClick()
867:         THIS.CarregarLista()
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * BtnEncerrarClick - Encerra o form e reabilita o form pai
872:     * Alias de CmdEncerrarClick para padrao FormBase
873:     *==========================================================================
874:     PROCEDURE BtnEncerrarClick()
875:         THIS.CmdEncerrarClick()
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * BtnSalvarClick - Confirma a conferencia (alias de CmdOkClick)
880:     * Mapeamento semantico: em form OPERACIONAL, "salvar" = confirmar conferencia
881:     *==========================================================================
882:     PROCEDURE BtnSalvarClick()
883:         THIS.CmdOkClick()
884:     ENDPROC
885: 
886:     *==========================================================================
887:     * BtnCancelarClick - Descarta e encerra sem gravar (alias de CmdEncerrarClick)
888:     * Mapeamento semantico: em form OPERACIONAL, "cancelar" = sair sem confirmar
889:     *==========================================================================
890:     PROCEDURE BtnCancelarClick()
891:         THIS.CmdEncerrarClick()
892:     ENDPROC
893: 
894:     *==========================================================================
895:     PROCEDURE Destroy()
896:     *==========================================================================
897:         IF USED("TmpBaixa")
898:             USE IN TmpBaixa
899:         ENDIF
900:         THIS.this_oBusinessObject = .NULL.
901:         DODEFAULT()
902:     ENDPROC
903: 
904: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object: Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o
* Herda de BusinessBase
* Cursor principal: TmpBaixa (VFP local)
* Tabelas SQL Server: SigOpEtq, SigMvCab, SigMvItn, SigMvIts, SigMvHst
*                    SigCdPam, SigCdPac, SigCdPro, SigCdGrp, SigCdCli, SigCdOpe
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Configuracao cursor de trabalho
    this_cTabela        = "TmpBaixa"
    this_cCampoChave    = "CodBarra"

    *-- Dados da sessao (fornecidos pelo form ao inicializar)
    this_cSigKey        = ""
    this_dData          = {}

    *-- Configuracoes carregadas de SigCdPam
    this_cGruConfs      = ""
    this_cConConfs      = ""
    this_cGruReservs    = ""
    this_cConReservs    = ""
    this_cDopeCitens    = ""
    this_cTransfEncs    = ""
    this_cGrupoEsts     = ""
    this_cContaEsts     = ""

    *-- Campos do registro corrente de TmpBaixa
    this_nCodBarra      = 0      && CodBarra N(14,0) - chave de barras
    this_cCPros         = ""     && CPros C(14) - codigo produto
    this_cDopes         = ""     && Dopes C(20) - operacao
    this_nNumes         = 0      && Numes N(6,0) - numero da ordem
    this_nQtde          = 0      && Qtde N(12,3) - quantidade total
    this_nQtdeLido      = 0      && QtdeLido N(12,3) - quantidade conferida
    this_nNops          = 0      && Nops N(10,0) - numero ops
    this_cGrupods       = ""     && Grupods C(10) - grupo destino
    this_cContads       = ""     && Contads C(10) - conta destino

    *==========================================================================
    FUNCTION Init()
    *==========================================================================
        THIS.this_cTabela     = "TmpBaixa"
        THIS.this_cCampoChave = "CodBarra"
        RETURN DODEFAULT()
    ENDFUNC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_nCodBarra
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir do cursor TmpBaixa
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodBarra  = NVL(CodBarra,  0)
                THIS.this_cCPros     = ALLTRIM(NVL(CPros,     ""))
                THIS.this_cDopes     = ALLTRIM(NVL(Dopes,     ""))
                THIS.this_nNumes     = NVL(Numes,     0)
                THIS.this_nQtde      = NVL(Qtde,      0)
                THIS.this_nQtdeLido  = NVL(QtdeLido,  0)
                THIS.this_nNops      = NVL(Nops,      0)
                THIS.this_cGrupods   = ALLTRIM(NVL(Grupods,   ""))
                THIS.this_cContads   = ALLTRIM(NVL(Contads,   ""))
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Insere registro no cursor VFP local TmpBaixa
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                       Nops, Grupods, Contads) ;
                    VALUES (THIS.this_nCodBarra, THIS.this_cCPros, THIS.this_cDopes, ;
                            THIS.this_nNumes, THIS.this_nQtde, THIS.this_nNops, ;
                            THIS.this_cGrupods, THIS.this_cContads)
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza QtdeLido/Grupods/Contads no cursor TmpBaixa
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                IF SEEK(THIS.this_nCodBarra)
                    REPLACE QtdeLido WITH THIS.this_nQtdeLido, ;
                            Grupods  WITH THIS.this_cGrupods, ;
                            Contads  WITH THIS.this_cContads
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarCursores - Cria/recria o cursor TmpBaixa com indices
    *==========================================================================
    PROCEDURE InicializarCursores()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                USE IN TmpBaixa
            ENDIF
            CREATE CURSOR TmpBaixa (CodBarra N(14,0), CPros C(14), Dopes C(20), ;
                                     Numes N(6,0), Qtde N(12,3), QtdeLido N(12,3), ;
                                     Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarConfigPam - Carrega parametros de SigCdPam para propriedades
    *==========================================================================
    PROCEDURE CarregarConfigPam()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 GruConfs, ConConfs, GruReservs, ConReservs, " + ;
                       "DopeCitens, TransfEncs, GrupoEsts, ContaEsts FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamConf") > 0
                SELECT cursor_4c_PamConf
                THIS.this_cGruConfs    = ALLTRIM(NVL(GruConfs,    ""))
                THIS.this_cConConfs    = ALLTRIM(NVL(ConConfs,    ""))
                THIS.this_cGruReservs  = ALLTRIM(NVL(GruReservs,  ""))
                THIS.this_cConReservs  = ALLTRIM(NVL(ConReservs,  ""))
                THIS.this_cDopeCitens  = ALLTRIM(NVL(DopeCitens,  ""))
                THIS.this_cTransfEncs  = ALLTRIM(NVL(TransfEncs,  ""))
                THIS.this_cGrupoEsts   = ALLTRIM(NVL(GrupoEsts,   ""))
                THIS.this_cContaEsts   = ALLTRIM(NVL(ContaEsts,   ""))
                USE IN cursor_4c_PamConf
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarSigKey - Carrega SigKeys de SigCdPac para this_cSigKey
    *==========================================================================
    PROCEDURE CarregarSigKey()
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigKey") > 0
                SELECT cursor_4c_SigKey
                THIS.this_cSigKey = ALLTRIM(NVL(SigKeys, ""))
                USE IN cursor_4c_SigKey
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MarcarLeitura - Marca codigo de barras como lido em TmpBaixa
    * par_nCodBarra: codigo de barras numerico (N14)
    * Equivalente ao Get_Leitura.Valid do legado
    *==========================================================================
    PROCEDURE MarcarLeitura(par_nCodBarra)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa") AND !EMPTY(par_nCodBarra) AND par_nCodBarra <> 0
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                IF SEEK(par_nCodBarra)
                    IF TmpBaixa.QtdeLido = 0
                        REPLACE QtdeLido WITH TmpBaixa.Qtde IN TmpBaixa
                        loc_lResultado = .T.
                    ELSE
                        MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + ;
                                 " Foi Lido!!!")
                    ENDIF
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + ;
                             "o Cadastrado!!!")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConferirAutomatico - Marca todos os itens como conferidos (QtdeLido=Qtde)
    * Equivalente ao Conferencia.Click do legado
    *==========================================================================
    PROCEDURE ConferirAutomatico()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("TmpBaixa")
                SELECT TmpBaixa
                SET ORDER TO CodBarra
                REPLACE ALL QtdeLido WITH Qtde
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarBars - Popula TmpBaixa a partir de TmpEnc + SigOpEtq
    * par_cCursorTmpEnc: alias do cursor TmpEnc do form pai
    * Equivalente ao carregabars do legado
    *==========================================================================
    PROCEDURE CarregarBars(par_cCursorTmpEnc)
        LOCAL loc_lResultado
        LOCAL loc_cEmpr, loc_cDopeCit, loc_cChave, loc_cSQL
        LOCAL loc_cDopps, loc_nNumps
        LOCAL loc_cGrupos, loc_cContas
        LOCAL loc_cEmpos, loc_cDopeOs, loc_nNumeOs, loc_cCPros
        LOCAL loc_cDopes2, loc_cGlobalizas, loc_nServicos
        LOCAL loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_cCGrus, loc_nTipoEstos
        LOCAL loc_cIClis, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtds, loc_nQtEti, loc_nQtCit
        LOCAL loc_nBaixa, loc_nPendente, loc_pVal, loc_pDat
        LOCAL loc_llBaixa
        LOCAL loc_cCBars, loc_cNops
        LOCAL loc_cCodCors, loc_cCodTams
        LOCAL loc_nCItens2, loc_cEI_CId
        LOCAL loc_cEmpDopNums2, loc_cCIdChaves, loc_nQtBaixas, loc_nQtds2
        LOCAL loc_cCIdChaves2, loc_nQtBaixas2, loc_nQtds3

        loc_lResultado = .F.

        TRY
            IF !THIS.CarregarConfigPam()
                loc_lResultado = .F.
            ENDIF

            loc_cEmpr    = go_4c_Sistema.cCodEmpresa
            loc_cDopeCit = THIS.this_cDopeCitens

            SELECT TmpBaixa
            DELETE ALL

            IF !USED(par_cCursorTmpEnc)
                loc_lResultado = .F.
            ENDIF

            SELECT (par_cCursorTmpEnc)
            DELETE ALL FOR EMPTY(Dopps) OR EMPTY(Numps)

            SCAN IN &par_cCursorTmpEnc.
                loc_cDopps = ALLTRIM(Dopps)
                loc_nNumps = Numps
                loc_cChave = loc_cEmpr + loc_cDopps + STR(loc_nNumps, 6)

                THIS.CursorQuery("SigOpEtq", "cursor_4c_SigOpEtq", "EmpDopNums", loc_cChave)

                SELECT cursor_4c_SigOpEtq
                SCAN
                    loc_cGrupos  = ALLTRIM(cursor_4c_SigOpEtq.Grupos)
                    loc_cContas  = ALLTRIM(cursor_4c_SigOpEtq.Contas)
                    loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtq.Empos)
                    loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtq.DopeOs)
                    loc_nNumeOs  = cursor_4c_SigOpEtq.NumeOs
                    loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                    loc_nQtds    = cursor_4c_SigOpEtq.Qtds
                    loc_cCBars   = cursor_4c_SigOpEtq.CBars
                    loc_cNops    = cursor_4c_SigOpEtq.Nops
                    loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                    loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtq.CodTams)

                    IF (loc_cGrupos + loc_cContas) = ;
                       (THIS.this_cGruConfs + THIS.this_cConConfs)

                        THIS.CursorQuery("SigMvCab", "cursor_4c_LocalEest", "EmpDopNums", ;
                                         loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        SELECT cursor_4c_LocalEest
                        IF !EOF()
                            loc_cDopes2 = ALLTRIM(cursor_4c_LocalEest.Dopes)
                        ELSE
                            loc_cDopes2 = ""
                        ENDIF

                        THIS.CursorQuery("SigCdOpe", "cursor_4c_SigCdOpe", "Dopes", loc_cDopes2)

                        SELECT cursor_4c_SigCdOpe
                        IF !EOF()
                            loc_cGlobalizas = cursor_4c_SigCdOpe.Globalizas
                            loc_nServicos   = cursor_4c_SigCdOpe.Servicos
                        ELSE
                            loc_cGlobalizas = 0
                            loc_nServicos   = 0
                        ENDIF

                        SELECT cursor_4c_LocalEest
                        IF !EOF()
                            IF (loc_cGlobalizas = 1) OR (loc_nServicos = 1)
                                loc_cTGrupo = ALLTRIM(cursor_4c_LocalEest.Grupoos)
                                loc_cTConta = ALLTRIM(cursor_4c_LocalEest.Contaos)
                            ELSE
                                loc_cTGrupo = ALLTRIM(cursor_4c_LocalEest.Grupods)
                                loc_cTConta = ALLTRIM(cursor_4c_LocalEest.Contads)
                            ENDIF
                        ELSE
                            loc_cTGrupo = ""
                            loc_cTConta = ""
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGruReservs), loc_cTGrupo, THIS.this_cGruReservs)
                        loc_cConta = IIF(EMPTY(THIS.this_cConReservs), loc_cTConta, THIS.this_cConReservs)

                        THIS.CursorQuery("SigCdPro", "cursor_4c_SigCdPro", "CPros", loc_cCPros, "CGrus")

                        SELECT cursor_4c_SigCdPro
                        IF !EOF()
                            loc_cCGrus = ALLTRIM(cursor_4c_SigCdPro.CGrus)
                        ELSE
                            loc_cCGrus = ""
                        ENDIF

                        THIS.CursorQuery("SigCdGrp", "cursor_4c_SigCdGrp", "CGrus", loc_cCGrus, "TipoEstos")

                        SELECT cursor_4c_SigCdGrp
                        IF !EOF()
                            loc_nTipoEstos = cursor_4c_SigCdGrp.TipoEstos
                            IF !INLIST(loc_nTipoEstos, 2, 3, 4)
                                loc_nTipoEstos = 1
                            ENDIF
                        ELSE
                            loc_nTipoEstos = 1
                        ENDIF

                        THIS.CursorQuery("SigCdCli", "cursor_4c_SigCdCli", "IClis", loc_cTConta, ;
                                         "GruProds, ConProds")

                        SELECT cursor_4c_SigCdCli
                        IF !EOF()
                            loc_cGruProds = ALLTRIM(cursor_4c_SigCdCli.GruProds)
                            loc_cConProds = ALLTRIM(cursor_4c_SigCdCli.ConProds)
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtEti = loc_nQtds
                        loc_nQtCit = 0

                        IF !EMPTY(loc_cDopeCit)
                            THIS.CursorQuery("SigMvCab", "cursor_4c_LocalEest2", "EmpDopNums", ;
                                             loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6))

                            SELECT cursor_4c_LocalEest2
                            IF !EOF()
                                IF loc_nTipoEstos = 1
                                    loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds FROM SigMvItn " + ;
                                               "WHERE EmpDopNums = " + ;
                                               EscaparSQL(loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)) + ;
                                               " AND CPros = " + EscaparSQL(loc_cCPros)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEestI") < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                "Falha na Conex" + CHR(227) + "o (LocalEestI)")
                                    ELSE
                                        loc_nBaixa = loc_nQtds

                                        SELECT cursor_4c_LocalEestI
                                        GO TOP
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_nQtBaixas  = cursor_4c_LocalEestI.QtBaixas
                                            loc_nQtds2     = cursor_4c_LocalEestI.Qtds
                                            loc_cCIdChaves = ALLTRIM(cursor_4c_LocalEestI.cIdChaves)

                                            IF (loc_nQtds2 - loc_nQtBaixas) <> 0
                                                loc_nPendente = loc_nQtds2 - loc_nQtBaixas
                                                IF loc_nPendente > loc_nBaixa
                                                    loc_pVal  = loc_nBaixa
                                                    loc_nBaixa = 0
                                                ELSE
                                                    loc_pVal   = loc_nPendente
                                                    loc_nBaixa = loc_nBaixa - loc_nPendente
                                                ENDIF

                                                loc_pDat   = DATETIME()
                                                loc_llBaixa = IIF(loc_nQtBaixas + loc_pVal = loc_nQtds2, .T., .F.)

                                                loc_cSQL = "UPDATE SigMvItn " + ;
                                                           "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                           "ChkSubn = ?loc_llBaixa, " + ;
                                                           "DtAlts = ?loc_pDat " + ;
                                                           "WHERE cIdChaves = " + EscaparSQL(loc_cCIdChaves)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                    MsgErro("Favor Reinicializar o Processo!!!", ;
                                                            "Falha na Conex" + CHR(227) + ;
                                                            "o (Update SigMvItn 1)")
                                                ENDIF
                                            ENDIF
                                        ENDSCAN
                                    ENDIF
                                ELSE
                                    loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                               "FROM SigMvIts " + ;
                                               "WHERE EmpDopNums = " + ;
                                               EscaparSQL(loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)) + ;
                                               " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                               " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                               " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEstI2") < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                "Falha na Conex" + CHR(227) + "o (LocalEstI2)")
                                    ELSE
                                        loc_nBaixa = loc_nQtds

                                        SELECT cursor_4c_LocalEstI2
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_cEmpDopNums2 = ALLTRIM(cursor_4c_LocalEstI2.EmpDopNums)
                                            loc_nCItens2     = cursor_4c_LocalEstI2.CItens
                                            loc_nQtBaixas2   = cursor_4c_LocalEstI2.QtBaixas
                                            loc_nQtds3       = cursor_4c_LocalEstI2.Qtds
                                            loc_cCIdChaves2  = ALLTRIM(cursor_4c_LocalEstI2.cIdChaves)

                                            loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds FROM SigMvItn " + ;
                                                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums2) + ;
                                                       " AND CItens = " + FormatarNumeroSQL(loc_nCItens2, 0)
                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEestI") > 0
                                                loc_nPendente = loc_nQtds3 - loc_nQtBaixas2
                                                IF loc_nPendente <> 0
                                                    IF loc_nPendente > loc_nBaixa
                                                        loc_pVal = loc_nBaixa
                                                    ELSE
                                                        loc_pVal = loc_nPendente
                                                    ENDIF
                                                    loc_pDat    = DATETIME()
                                                    loc_llBaixa = IIF(loc_nQtBaixas2 + loc_pVal = loc_nQtds3, .T., .F.)
                                                    loc_cEI_CId = ALLTRIM(cursor_4c_LocalEestI.cIdChaves)

                                                    loc_cSQL = "UPDATE SigMvIts " + ;
                                                               "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                               "ChkSubn = ?loc_llBaixa " + ;
                                                               "WHERE cIdChaves = " + EscaparSQL(loc_cCIdChaves2)
                                                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                                "Falha na Conex" + CHR(227) + ;
                                                                "o (Update SigMvIts 1)")
                                                    ENDIF

                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                               "SET QtBaixas = QtBaixas + ?loc_pVal, " + ;
                                                               "DtAlts = ?loc_pDat " + ;
                                                               "WHERE cIdChaves = " + EscaparSQL(loc_cEI_CId)
                                                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                                                "Falha na Conex" + CHR(227) + ;
                                                                "o (Update SigMvItn 3)")
                                                    ENDIF

                                                    IF loc_nPendente > loc_nBaixa
                                                        loc_nBaixa = 0
                                                    ELSE
                                                        loc_nBaixa = loc_nBaixa - loc_nPendente
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDSCAN
                                    ENDIF
                                    loc_nQtCit = loc_nQtEti - loc_nBaixa
                                ENDIF
                            ENDIF
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti <> 0
                            INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                                   Nops, Grupods, Contads) ;
                                VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                        loc_nQtEti, loc_cNops, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit <> 0
                            INSERT INTO TmpBaixa (CodBarra, CPros, Dopes, Numes, Qtde, ;
                                                   Nops, Grupods, Contads) ;
                                VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                        loc_nQtCit, loc_cNops, ;
                                        THIS.this_cGrupoEsts, THIS.this_cContaEsts)
                        ENDIF

                    ENDIF

                    SELECT (par_cCursorTmpEnc)
                ENDSCAN

                IF USED("cursor_4c_SigOpEtq")
                    USE IN cursor_4c_SigOpEtq
                ENDIF
            ENDSCAN

            SELECT TmpBaixa
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
                         CHR(231) + CHR(227) + "o!!!")
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarBars")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ConfirmarConferencia - Grava movimentos no SQL Server e encerra
    * Cria registros em SigMvCab, SigMvItn, SigMvHst e atualiza SigOpEtq
    * Equivalente ao Ok.Click do legado
    * Retorna .T. se gravacao bem-sucedida
    *==========================================================================
    PROCEDURE ConfirmarConferencia()
        LOCAL loc_lResultado, loc_llTaOk
        LOCAL loc_cEmpr, loc_cUsuar, loc_cDope, loc_nNume
        LOCAL loc_cSQL, loc_lItem
        LOCAL loc_pDat, loc_pBar, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads
        LOCAL loc_cCPros, loc_cDPros, loc_cCunis
        LOCAL loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nQtdeLido, loc_cCursor

        loc_lResultado = .F.
        loc_llTaOk     = .T.

        TRY
            IF !USED("TmpBaixa")
                loc_lResultado = .F.
            ENDIF

            SELECT TmpBaixa
            IF EOF()
                loc_lResultado = .F.
            ENDIF

            loc_cEmpr  = go_4c_Sistema.cCodEmpresa
            loc_cUsuar = gc_4c_UsuarioLogado
            loc_cDope  = THIS.this_cTransfEncs

            *-- Criar cursores de trabalho espelhando estrutura SQL Server
            THIS.CriarCursorTrabalho("SigMvCab", "cursor_4c_CrSigMvCab")
            THIS.CriarCursorTrabalho("SigMvItn", "cursor_4c_CrSigMvItn")
            THIS.CriarCursorTrabalho("SigMvHst", "cursor_4c_CrSigMvHst")

            *-- xGrava: agrupamento de itens por Grupo+Conta+Produto
            IF USED("cursor_4c_xGrava")
                USE IN cursor_4c_xGrava
            ENDIF
            CREATE CURSOR cursor_4c_xGrava (Grupo C(10), Conta C(10), CPros C(14), Qtds N(12,3))
            INDEX ON Grupo + Conta TAG GruConta

            *-- xCabec: cabecalhos distintos por Grupods+Contads
            SELECT DISTINCT Grupods, Contads FROM TmpBaixa ;
                WHERE QtdeLido <> 0 INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            SCAN
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                loc_nNume = fGerUniqueKey(loc_cEmpr + loc_cDope)

                INSERT INTO cursor_4c_CrSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, ;
                                                    Usuars, Grupoos, Contaos, Grupods, Contads, ;
                                                    EmpDopNums, cIdChaves, DtAlts, EmpGopNums) ;
                                           VALUES (loc_cEmpr, loc_cDope, loc_nNume, ;
                                                   ALLTRIM(fGerMascara(loc_nNume)), ;
                                                   DATETIME(), DATETIME(), ;
                                                   loc_cUsuar, THIS.this_cGruConfs, THIS.this_cConConfs, ;
                                                   loc_cGrupods, loc_cContads, ;
                                                   loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                   fUniqueIds(), DATETIME(), ;
                                                   loc_cEmpr + SPACE(20) + STR(0, 6))

                loc_lItem = 0

                SELECT TmpBaixa
                SET ORDER TO GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                     FOR QtdeLido <> 0

                    loc_lItem     = loc_lItem + 1
                    loc_cCPros    = ALLTRIM(TmpBaixa.CPros)
                    loc_nQtdeLido = TmpBaixa.QtdeLido
                    loc_pBar      = TmpBaixa.CodBarra

                    THIS.CursorQuery("SigCdPro", "cursor_4c_SigCdProC", "CPros", loc_cCPros, ;
                                     "DPros, CUnis")
                    THIS.CursorQuery("SigOpEtq", "cursor_4c_SigOpEtqC", "CBars", loc_pBar, ;
                                     "CodCors, CodTams, Empos")

                    SELECT cursor_4c_SigCdProC
                    IF !EOF()
                        loc_cDPros = ALLTRIM(cursor_4c_SigCdProC.DPros)
                        loc_cCunis = ALLTRIM(cursor_4c_SigCdProC.CUnis)
                    ELSE
                        loc_cDPros = ""
                        loc_cCunis = ""
                    ENDIF

                    SELECT cursor_4c_SigOpEtqC
                    IF !EOF()
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqC.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqC.CodTams)
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqC.Empos)
                    ELSE
                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = loc_cEmpr
                    ENDIF

                    INSERT INTO cursor_4c_CrSigMvItn (CItens, Emps, Dopes, Numes, CPros, Qtds, ;
                                                       CUnis, DPros, Opers, CodBarras, ;
                                                       EmpDopNums, cIdChaves, DtAlts) ;
                                               VALUES (loc_lItem, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, ;
                                                       loc_cCunis, loc_cDPros, "S", loc_pBar, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       fUniqueIds(), DATETIME())

                    *-- Historico Saida (Opers='S')
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                                 THIS.this_cSigKey
                    loc_nPSeq  = fGerUniqueKey("HISTBAR")

                    INSERT INTO cursor_4c_CrSigMvHst (Usuars, Datas, Datars, Emps, Empos, ;
                                                       Dopes, Numes, CPros, Qtds, Opers, ;
                                                       Grupos, Estos, CodBarras, CodCors, ;
                                                       CodTams, cIdChaves, EmpDopNums, ;
                                                       EmpGruEsts, OriDopNums, Seqs) ;
                                               VALUES (loc_cUsuar, DATETIME(), DATETIME(), ;
                                                       loc_cEmpos, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, "S", ;
                                                       THIS.this_cGruConfs, THIS.this_cConConfs, ;
                                                       loc_pBar, loc_cCodCors, loc_cCodTams, ;
                                                       loc_cPCidC, ;
                                                       loc_cEmpos + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_cEmpos + THIS.this_cGruConfs + THIS.this_cConConfs, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_nPSeq)

                    SELECT cursor_4c_CrSigMvHst
                    GO BOTTOM
                    =fRecalculaP(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.Grupos, ;
                                 cursor_4c_CrSigMvHst.Estos, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas, cursor_4c_CrSigMvHst.CodCors, ;
                                 cursor_4c_CrSigMvHst.CodTams)
                    =fRecalculaC(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas)

                    *-- Historico Entrada (Opers='E')
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                                 THIS.this_cSigKey
                    loc_nPSeq  = fGerUniqueKey("HISTBAR")

                    INSERT INTO cursor_4c_CrSigMvHst (Usuars, Datas, Datars, Emps, Empos, ;
                                                       Dopes, Numes, CPros, Qtds, Opers, ;
                                                       Grupos, Estos, CodBarras, CodCors, ;
                                                       CodTams, cIdChaves, EmpDopNums, ;
                                                       EmpGruEsts, OriDopNums, Seqs) ;
                                               VALUES (loc_cUsuar, DATETIME(), DATETIME(), ;
                                                       loc_cEmpos, loc_cEmpr, loc_cDope, loc_nNume, ;
                                                       loc_cCPros, loc_nQtdeLido, "E", ;
                                                       loc_cGrupods, loc_cContads, ;
                                                       loc_pBar, loc_cCodCors, loc_cCodTams, ;
                                                       loc_cPCidC, ;
                                                       loc_cEmpos + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_cEmpos + loc_cGrupods + loc_cContads, ;
                                                       loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                                       loc_nPSeq)

                    SELECT cursor_4c_CrSigMvHst
                    GO BOTTOM
                    =fRecalculaP(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.Grupos, ;
                                 cursor_4c_CrSigMvHst.Estos, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas, cursor_4c_CrSigMvHst.CodCors, ;
                                 cursor_4c_CrSigMvHst.CodTams)
                    =fRecalculaC(cursor_4c_CrSigMvHst.Emps, cursor_4c_CrSigMvHst.CPros, ;
                                 cursor_4c_CrSigMvHst.Datas)

                    *-- Update SigOpEtq no SQL Server (dentro do SCAN)
                    loc_pDat = DATETIME()
                    loc_cSQL = "UPDATE SigOpEtq SET " + ;
                               "Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = ?loc_pDat " + ;
                               "WHERE CBars = ?loc_pBar"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (Update SigOpEtq)")
                        loc_llTaOk = .F.
                    ENDIF

                    SELECT TmpBaixa
                ENDSCAN

                SELECT cursor_4c_xCabec
            ENDSCAN

            *-- Gravar cursores locais no SQL Server
            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvCab", "SigMvCab")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvCab)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvItn", "SigMvItn")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvItn)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !THIS.GravarCursorNoServidor("cursor_4c_CrSigMvHst", "SigMvHst")
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Update SigMvHst)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !fRecalculaP(.T.)
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigOpClP)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF !fRecalculaC(.T., .F., .F.)
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigOpClC)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF loc_llTaOk
                IF SQLTRANSACT(gnConnHandle, "COMMIT") < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                    loc_llTaOk = .F.
                ENDIF
            ENDIF

            IF !loc_llTaOk
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
            ENDIF

            loc_lResultado = loc_llTaOk

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfirmarConferencia")
            SQLTRANSACT(gnConnHandle, "ROLLBACK")
        ENDTRY

        *-- Limpar cursores temporarios
        IF USED("cursor_4c_CrSigMvCab")
            USE IN cursor_4c_CrSigMvCab
        ENDIF
        IF USED("cursor_4c_CrSigMvItn")
            USE IN cursor_4c_CrSigMvItn
        ENDIF
        IF USED("cursor_4c_CrSigMvHst")
            USE IN cursor_4c_CrSigMvHst
        ENDIF
        IF USED("cursor_4c_xGrava")
            USE IN cursor_4c_xGrava
        ENDIF
        IF USED("cursor_4c_xCabec")
            USE IN cursor_4c_xCabec
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CursorQuery - Helper: consulta tabela SQL Server por campo=valor
    *==========================================================================
    PROTECTED PROCEDURE CursorQuery(par_cTabela, par_cCursor, par_cCampo, par_xValor, par_cCampos)
        LOCAL loc_lcCampos, loc_lcQuery, loc_lcValor
        loc_lcCampos = IIF(PCOUNT() < 5 OR EMPTY(par_cCampos), "*", par_cCampos)
        loc_lcValor  = ALLTRIM(TRANSFORM(par_xValor))
        loc_lcQuery  = "SELECT " + loc_lcCampos + " FROM " + par_cTabela + ;
                       " WHERE " + par_cCampo + " = " + EscaparSQL(loc_lcValor)
        IF SQLEXEC(gnConnHandle, loc_lcQuery, par_cCursor) < 1
            SQLEXEC(gnConnHandle, "SELECT " + loc_lcCampos + " FROM " + par_cTabela + ;
                    " WHERE 0=1", par_cCursor)
        ENDIF
    ENDPROC

    *==========================================================================
    * CriarCursorTrabalho - Cria cursor local com estrutura da tabela SQL Server
    *==========================================================================
    PROTECTED PROCEDURE CriarCursorTrabalho(par_cTabela, par_cCursor)
        LOCAL loc_lSucesso, loc_nFlds
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .F.
        TRY
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM " + par_cTabela, "cursor_4c_TmpEstr_") > 0
                loc_nFlds = AFIELDS(loc_aFlds, "cursor_4c_TmpEstr_")
                USE IN cursor_4c_TmpEstr_
                CREATE CURSOR (par_cCursor) FROM ARRAY loc_aFlds
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao criar cursor de trabalho para " + par_cTabela, "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GravarCursorNoServidor - Insere todos os registros do cursor no SQL Server
    *==========================================================================
    PROTECTED PROCEDURE GravarCursorNoServidor(par_cCursor, par_cTabela)
        LOCAL loc_lSucesso, loc_nFlds, loc_i, loc_lcFields, loc_lcValues, loc_lcInsert
        LOCAL loc_xVal, loc_cTipo
        LOCAL ARRAY loc_aFlds(1)
        loc_lSucesso = .T.
        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                loc_nFlds = AFIELDS(loc_aFlds, par_cCursor)
                loc_lcFields = ""
                FOR loc_i = 1 TO loc_nFlds
                    IF loc_i > 1
                        loc_lcFields = loc_lcFields + ","
                    ENDIF
                    loc_lcFields = loc_lcFields + loc_aFlds(loc_i, 1)
                ENDFOR
                GO TOP IN (par_cCursor)
                SCAN IN &par_cCursor.
                    loc_lcValues = ""
                    FOR loc_i = 1 TO loc_nFlds
                        IF loc_i > 1
                            loc_lcValues = loc_lcValues + ","
                        ENDIF
                        loc_xVal  = EVALUATE(par_cCursor + "." + loc_aFlds(loc_i, 1))
                        loc_cTipo = loc_aFlds(loc_i, 2)
                        DO CASE
                            CASE ISNULL(loc_xVal)
                                loc_lcValues = loc_lcValues + "NULL"
                            CASE loc_cTipo $ "CM"
                                loc_lcValues = loc_lcValues + EscaparSQL(ALLTRIM(loc_xVal))
                            CASE loc_cTipo = "N"
                                loc_lcValues = loc_lcValues + ALLTRIM(STR(loc_xVal, 20, 6))
                            CASE loc_cTipo = "D"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + FormatarDataSQL(loc_xVal)
                                ENDIF
                            CASE loc_cTipo = "T"
                                IF EMPTY(loc_xVal)
                                    loc_lcValues = loc_lcValues + "NULL"
                                ELSE
                                    loc_lcValues = loc_lcValues + "'" + TTOC(loc_xVal, 3) + "'"
                                ENDIF
                            CASE loc_cTipo = "L"
                                loc_lcValues = loc_lcValues + IIF(loc_xVal = .T., "1", "0")
                            OTHERWISE
                                loc_lcValues = loc_lcValues + "NULL"
                        ENDCASE
                    ENDFOR
                    loc_lcInsert = "INSERT INTO " + par_cTabela + " (" + loc_lcFields + ") VALUES (" + loc_lcValues + ")"
                    IF SQLEXEC(gnConnHandle, loc_lcInsert) < 1
                        loc_lSucesso = .F.
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro GravarCursorNoServidor")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

