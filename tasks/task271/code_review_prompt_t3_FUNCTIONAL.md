# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (906 linhas total):

*-- Linhas 9 a 135:
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
79:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:             THIS.ConfigurarPaginaDados()
82:             THIS.ConfigurarBotoes()
83:             THIS.ConfigurarPaginaLista()
84:             THIS.TornarControlesVisiveis()
85:             THIS.ConfigurarBINDEVENTs()
86:             THIS.InicializarValores()
87:             loc_lSucesso = .T.
88:         CATCH TO loc_oErro
89:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
90:         ENDTRY
91:         RETURN loc_lSucesso
92:     ENDPROC
93: 
94:     *==========================================================================
95:     PROTECTED PROCEDURE ConfigurarCabecalho()
96:     *==========================================================================
97:         LOCAL loc_nW, loc_cCaption
98:         loc_nW      = THIS.Width
99:         loc_cCaption = THIS.Caption
100: 
101:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
102:         WITH THIS.cnt_4c_Cabecalho
103:             .Top         = 0
104:             .Left        = 0
105:             .Width       = loc_nW
106:             .Height      = 80
107:             .BackStyle   = 1
108:             .BackColor   = RGB(100, 100, 100)
109:             .BorderWidth = 0
110: 
111:             .AddObject("lbl_4c_Sombra", "Label")
112:             WITH .lbl_4c_Sombra
113:                 .AutoSize      = .F.
114:                 .Width         = loc_nW
115:                 .Height        = 40
116:                 .Top           = 18
117:                 .Left          = 10
118:                 .Caption       = loc_cCaption
119:                 .FontName      = "Tahoma"
120:                 .FontSize      = 18
121:                 .FontBold      = .T.
122:                 .FontUnderline = .F.
123:                 .WordWrap      = .T.
124:                 .Alignment     = 0
125:                 .BackStyle     = 0
126:                 .ForeColor     = RGB(0, 0, 0)
127:             ENDWITH
128: 
129:             .AddObject("lbl_4c_Titulo", "Label")
130:             WITH .lbl_4c_Titulo
131:                 .AutoSize   = .F.
132:                 .Width      = loc_nW
133:                 .Height     = 46
134:                 .Top        = 17
135:                 .Left       = 10

*-- Linhas 141 a 194:
141:                 .Alignment  = 0
142:                 .BackStyle  = 0
143:                 .ForeColor  = RGB(255, 255, 255)
144:             ENDWITH
145:         ENDWITH
146:         THIS.cnt_4c_Cabecalho.Visible = .T.
147:     ENDPROC
148: 
149:     *==========================================================================
150:     * ConfigurarPaginaDados - Configura os campos principais do form OPERACIONAL
151:     * (form flat sem PageFrame, portanto sem Page2 literal; os campos abaixo
152:     * correspondem semanticamente aa "pagina de dados" do padrao CRUD).
153:     *==========================================================================
154:     PROTECTED PROCEDURE ConfigurarPaginaDados()
155:         *-- Label "Data :"
156:         THIS.AddObject("lbl_4c_Data", "Label")
157:         WITH THIS.lbl_4c_Data
158:             .AutoSize  = .T.
159:             .FontName  = "Tahoma"
160:             .FontSize  = 8
161:             .BackStyle = 0
162:             .Caption   = "Data : "
163:             .Height    = 15
164:             .Left      = 133
165:             .Top       = 110
166:             .Width     = 35
167:             .ForeColor = RGB(90, 90, 90)
168:         ENDWITH
169: 
170:         *-- TextBox data (ReadOnly, exibe data da operacao do form pai)
171:         THIS.AddObject("txt_4c_Data", "TextBox")
172:         WITH THIS.txt_4c_Data
173:             .FontName          = "Tahoma"
174:             .FontSize          = 8
175:             .Alignment         = 3
176:             .Value             = DATE()
177:             .Height            = 23
178:             .Left              = 170
179:             .ReadOnly          = .T.
180:             .SpecialEffect     = 1
181:             .Top               = 107
182:             .Width             = 80
183:             .DisabledBackColor = RGB(255, 255, 255)
184:             .BorderColor       = RGB(100, 100, 100)
185:         ENDWITH
186: 
187:         *-- Label "Codigo de barra :" (oculto ate TmpBaixa ter dados)
188:         THIS.AddObject("lbl_4c_Leitura", "Label")
189:         WITH THIS.lbl_4c_Leitura
190:             .AutoSize  = .F.
191:             .FontName  = "Tahoma"
192:             .FontSize  = 8
193:             .BackStyle = 0
194:             .Caption   = "C" + CHR(243) + "digo de barra :"

*-- Linhas 216 a 259:
216:     ENDPROC
217: 
218:     *==========================================================================
219:     PROTECTED PROCEDURE ConfigurarBotoes()
220:     *==========================================================================
221:         LOCAL loc_cIcones
222:         loc_cIcones = gc_4c_CaminhoIcones
223: 
224:         *-- Botao "Conf. Auto" (Left=575) - oculto ate TmpBaixa ter dados
225:         THIS.AddObject("cmd_4c_ConferirAuto", "CommandButton")
226:         WITH THIS.cmd_4c_ConferirAuto
227:             .Top             = 3
228:             .Left            = 575
229:             .Width           = 75
230:             .Height          = 75
231:             .Caption         = "Conf. Auto"
232:             .Picture         = loc_cIcones + "geral_servicos_60.jpg"
233:             .Themes          = .T.
234:             .DisabledPicture = loc_cIcones + "geral_servicos_60.jpg"
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .PicturePosition = 13
241:             .WordWrap        = .T.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .Visible         = .F.
245:         ENDWITH
246: 
247:         *-- Botao "Ok" confirmar conferencia (Left=650) - oculto ate TmpBaixa ter dados
248:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
249:         WITH THIS.cmd_4c_Ok
250:             .Top             = 3
251:             .Left            = 650
252:             .Width           = 75
253:             .Height          = 75
254:             .Caption         = "Ok"
255:             .Picture         = loc_cIcones + "cadastro_salvar_60.jpg"
256:             .Themes          = .T.
257:             .DisabledPicture = loc_cIcones + "cadastro_salvar_60.jpg"
258:             .FontName        = "Tahoma"
259:             .FontBold        = .T.

*-- Linhas 296 a 344:
296:     * Em form OPERACIONAL flat (sem PageFrame), a "pagina lista" eh a regiao
297:     * central com a grade de etiquetas + o textbox de leitura de codigo de barra.
298:     *==========================================================================
299:     PROTECTED PROCEDURE ConfigurarPaginaLista()
300:         THIS.ConfigurarGrade()
301:     ENDPROC
302: 
303:     *==========================================================================
304:     PROTECTED PROCEDURE ConfigurarGrade()
305:     *==========================================================================
306:         THIS.AddObject("grd_4c_Dados", "Grid")
307:         THIS.grd_4c_Dados.ColumnCount = 5
308:         WITH THIS.grd_4c_Dados
309:             .Top               = 140
310:             .Left              = 133
311:             .Width             = 534
312:             .Height            = 207
313:             .FontSize          = 8
314:             .FontName          = "Tahoma"
315:             .AllowHeaderSizing = .F.
316:             .AllowRowSizing    = .F.
317:             .DeleteMark        = .F.
318:             .RecordMark        = .F.
319:             .ReadOnly          = .T.
320:             .RowHeight         = 17
321:             .ScrollBars        = 2
322:             .Panel             = 1
323:             .Visible           = .F.
324: 
325:             WITH .Column1
326:                 .Width            = 108
327:                 .Movable          = .F.
328:                 .Resizable        = .F.
329:                 .ReadOnly         = .T.
330:                 .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
331:                 WITH .Header1
332:                     .FontName  = "Tahoma"
333:                     .FontSize  = 8
334:                     .Alignment = 2
335:                     .Caption   = "C" + CHR(243) + "d. Barra"
336:                 ENDWITH
337:             ENDWITH
338: 
339:             WITH .Column2
340:                 .Width            = 108
341:                 .Movable          = .F.
342:                 .Resizable        = .F.
343:                 .ReadOnly         = .T.
344:                 .DynamicForeColor = "IIF(TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"

*-- Linhas 395 a 448:
395:     ENDPROC
396: 
397:     *==========================================================================
398:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
399:     *==========================================================================
400:         BINDEVENT(THIS.cmd_4c_ConferirAuto, "Click", THIS, "CmdConferirAutoClick")
401:         BINDEVENT(THIS.cmd_4c_Ok,           "Click", THIS, "CmdOkClick")
402:         BINDEVENT(THIS.cmd_4c_Encerrar,     "Click", THIS, "CmdEncerrarClick")
403:         BINDEVENT(THIS.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")
404:         BINDEVENT(THIS, "Activate", THIS, "FormActivate")
405:     ENDPROC
406: 
407:     *==========================================================================
408:     PROTECTED PROCEDURE InicializarValores()
409:     *==========================================================================
410:         LOCAL loc_lSucesso, loc_oErro
411:         loc_lSucesso = .F.
412:         TRY
413:             *-- Data da operacao herdada do form pai
414:             IF VARTYPE(THIS.this_oParent) = "O"
415:                 IF PEMSTATUS(THIS.this_oParent, "txt_4c_Data", 5)
416:                     THIS.txt_4c_Data.Value = THIS.this_oParent.txt_4c_Data.Value
417:                 ELSE
418:                     IF PEMSTATUS(THIS.this_oParent, "Get_Data", 5)
419:                     THIS.txt_4c_Data.Value = THIS.this_oParent.Get_Data.Value
420:                     ENDIF
421:                 ENDIF
422:             ENDIF
423: 
424:             *-- Criar cursor TmpBaixa vazio (sempre - independe de ValidandoUI)
425:             THIS.this_oBusinessObject.InicializarCursores()
426: 
427:             *-- Carregar dados apenas fora de modo ValidarUIFidelity (requer SQL + TmpEnc do pai)
428:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
429:                 *-- Carregar SigKey de SigCdPac (usado em ConfirmarConferencia)
430:                 THIS.this_oBusinessObject.CarregarSigKey()
431: 
432:                 *-- Carregar etiquetas do cursor TmpEnc do form pai para TmpBaixa
433:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
434:             ENDIF
435: 
436:             *-- Vincular grade ao TmpBaixa (vazio ou populado)
437:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
438:                 THIS.grd_4c_Dados.ColumnCount = 5
439:                 THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
440:                 WITH THIS.grd_4c_Dados
441:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
442:                     .Column2.ControlSource = "TmpBaixa.CPros"
443:                     .Column3.ControlSource = "TmpBaixa.Dopes"
444:                     .Column4.ControlSource = "TmpBaixa.Numes"
445:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
446:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
447:                     .Column2.Header1.Caption = "Produto"
448:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"

*-- Linhas 475 a 906:
475:     *                  - Grade visivel, leitura visivel, botoes Ok/ConfAuto visiveis
476:     *                  - Foco automatico no textbox de leitura
477:     *==========================================================================
478:     PROCEDURE AlternarPagina(par_nModo)
479:         LOCAL loc_lTemDados
480:         loc_lTemDados = (par_nModo = 2)
481: 
482:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
483:             THIS.grd_4c_Dados.Visible = loc_lTemDados
484:         ENDIF
485:         IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
486:             THIS.lbl_4c_Leitura.Visible = loc_lTemDados
487:         ENDIF
488:         IF VARTYPE(THIS.txt_4c_Leitura) = "O"
489:             THIS.txt_4c_Leitura.Visible = loc_lTemDados
490:         ENDIF
491:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
492:             THIS.cmd_4c_Ok.Visible = loc_lTemDados
493:         ENDIF
494:         IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
495:             THIS.cmd_4c_ConferirAuto.Visible = loc_lTemDados
496:         ENDIF
497: 
498:         IF loc_lTemDados AND VARTYPE(THIS.txt_4c_Leitura) = "O"
499:             THIS.txt_4c_Leitura.SetFocus()
500:         ENDIF
501:     ENDPROC
502: 
503:     *==========================================================================
504:     PROCEDURE TornarControlesVisiveis()
505:     *==========================================================================
506:         LPARAMETERS par_oContainer
507:         LOCAL loc_oContainer, loc_i, loc_oControl, loc_nP, loc_cNome
508: 
509:         IF VARTYPE(par_oContainer) = "O"
510:             loc_oContainer = par_oContainer
511:         ELSE
512:             loc_oContainer = THIS
513:         ENDIF
514: 
515:         FOR loc_i = 1 TO loc_oContainer.ControlCount
516:             loc_oControl = loc_oContainer.Controls(loc_i)
517:             IF VARTYPE(loc_oControl) = "O"
518:                 IF PEMSTATUS(loc_oControl, "Name", 5)
519:                     loc_cNome = UPPER(ALLTRIM(loc_oControl.Name))
520:                 ELSE
521:                     loc_cNome = ""
522:                 ENDIF
523: 
524:                 *-- Controles que iniciam ocultos, controlados por AlternarPagina() ou gerenciados internamente
525:                 IF INLIST(loc_cNome, "GRD_4C_DADOS", "TXT_4C_LEITURA", "LBL_4C_LEITURA", ;
526:                                      "CMD_4C_OK", "CMD_4C_CONFERIRAUTO", "CNT_4C_CABECALHO")
527:                     *-- Preserva estado do controle, mas recursa para tornar sub-controles visiveis
528:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
529:                         THIS.TornarControlesVisiveis(loc_oControl)
530:                     ENDIF
531:                     LOOP
532:                 ENDIF
533: 
534:                 IF UPPER(ALLTRIM(loc_oControl.BaseClass)) = "PAGEFRAME"
535:                     FOR loc_nP = 1 TO loc_oControl.PageCount
536:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
537:                     ENDFOR
538:                 ENDIF
539:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
540:                     THIS.TornarControlesVisiveis(loc_oControl)
541:                 ENDIF
542:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
543:                     loc_oControl.Visible = .T.
544:                 ENDIF
545:             ENDIF
546:         ENDFOR
547:     ENDPROC
548: 
549:     *==========================================================================
550:     PROCEDURE FormActivate()
551:     *==========================================================================
552:         IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
553:             THIS.txt_4c_Leitura.SetFocus()
554:         ENDIF
555:     ENDPROC
556: 
557:     *==========================================================================
558:     PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
559:     *==========================================================================
560:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
561:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
562:             RETURN
563:         ENDIF
564:         LOCAL loc_nCodBarra, loc_oErro
565:         TRY
566:             IF !EMPTY(THIS.txt_4c_Leitura.Value) AND THIS.txt_4c_Leitura.Value <> 0
567:                 loc_nCodBarra = THIS.txt_4c_Leitura.Value
568:                 THIS.this_oBusinessObject.MarcarLeitura(loc_nCodBarra)
569:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
570:                     SELECT TmpBaixa
571:                     SET ORDER TO CodBarra
572:                     SEEK loc_nCodBarra
573:                     THIS.grd_4c_Dados.Refresh()
574:                 ENDIF
575:                 THIS.txt_4c_Leitura.Value = 0
576:             ELSE
577:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
578:                     THIS.grd_4c_Dados.Refresh()
579:                 ENDIF
580:             ENDIF
581:             par_nKeyCode = 0
582:         CATCH TO loc_oErro
583:             MsgErro(loc_oErro.Message, "Erro Leitura")
584:         ENDTRY
585:     ENDPROC
586: 
587:     *==========================================================================
588:     PROCEDURE CmdConferirAutoClick()
589:     *==========================================================================
590:         LOCAL loc_oErro
591:         TRY
592:             THIS.this_oBusinessObject.ConferirAutomatico()
593:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
594:                 THIS.grd_4c_Dados.Refresh()
595:             ENDIF
596:         CATCH TO loc_oErro
597:             MsgErro(loc_oErro.Message, "Erro Conferir Auto")
598:         ENDTRY
599:     ENDPROC
600: 
601:     *==========================================================================
602:     PROCEDURE CmdOkClick()
603:     *==========================================================================
604:         LOCAL loc_lOk
605:         IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?")
606:             IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
607:                 THIS.txt_4c_Leitura.SetFocus()
608:             ENDIF
609:             RETURN
610:         ENDIF
611: 
612:         loc_lOk = THIS.this_oBusinessObject.ConfirmarConferencia()
613:         IF loc_lOk
614:             IF VARTYPE(THIS.this_oParent) = "O"
615:                 THIS.this_oParent.Enabled = .T.
616:             ENDIF
617:             THIS.Release()
618:         ELSE
619:             IF VARTYPE(THIS.txt_4c_Leitura) = "O" AND THIS.txt_4c_Leitura.Visible
620:                 THIS.txt_4c_Leitura.SetFocus()
621:             ENDIF
622:         ENDIF
623:     ENDPROC
624: 
625:     *==========================================================================
626:     PROCEDURE CmdEncerrarClick()
627:     *==========================================================================
628:         IF VARTYPE(THIS.this_oParent) = "O"
629:             THIS.this_oParent.Enabled = .T.
630:         ENDIF
631:         THIS.Release()
632:     ENDPROC
633: 
634:     *==========================================================================
635:     * BtnIncluirClick - Inicia nova leitura de etiqueta (foco no leitor de barras)
636:     * Mapeamento semantico: em form OPERACIONAL, "incluir" = adicionar leitura
637:     *==========================================================================
638:     PROCEDURE BtnIncluirClick()
639:         LOCAL loc_oErro
640:         TRY
641:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
642:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
643:                 RETURN
644:             ENDIF
645: 
646:             IF VARTYPE(THIS.txt_4c_Leitura) = "O"
647:                 THIS.txt_4c_Leitura.Visible = .T.
648:                 THIS.txt_4c_Leitura.Enabled = .T.
649:                 THIS.txt_4c_Leitura.Value   = 0
650:                 THIS.txt_4c_Leitura.SetFocus()
651:             ENDIF
652: 
653:             IF VARTYPE(THIS.lbl_4c_Leitura) = "O"
654:                 THIS.lbl_4c_Leitura.Visible = .T.
655:             ENDIF
656:         CATCH TO loc_oErro
657:             MsgErro(loc_oErro.Message, "Erro BtnIncluir")
658:         ENDTRY
659:     ENDPROC
660: 
661:     *==========================================================================
662:     * BtnAlterarClick - Marca todas as etiquetas como lidas (conferencia automatica)
663:     * Mapeamento semantico: em form OPERACIONAL, "alterar" = marcar todas as leituras
664:     * Delega a logica real para ConferirAutomatico() do BO (mesma que CmdConferirAuto)
665:     *==========================================================================
666:     PROCEDURE BtnAlterarClick()
667:         LOCAL loc_oErro
668:         TRY
669:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
670:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para confer" + CHR(234) + "ncia.", "Aviso")
671:                 RETURN
672:             ENDIF
673: 
674:             IF !MsgConfirma("Marcar TODAS as etiquetas como lidas?")
675:                 RETURN
676:             ENDIF
677: 
678:             THIS.this_oBusinessObject.ConferirAutomatico()
679:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
680:                 THIS.grd_4c_Dados.Refresh()
681:             ENDIF
682:         CATCH TO loc_oErro
683:             MsgErro(loc_oErro.Message, "Erro BtnAlterar")
684:         ENDTRY
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * BtnVisualizarClick - Recarrega etiquetas do form pai e atualiza a grade
689:     * Mapeamento semantico: em form OPERACIONAL, "visualizar" = recarregar/refresh
690:     *==========================================================================
691:     PROCEDURE BtnVisualizarClick()
692:         LOCAL loc_oErro
693:         TRY
694:             IF VARTYPE(THIS.this_oParent) = "O"
695:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
696:             ENDIF
697: 
698:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
699:                 THIS.grd_4c_Dados.Refresh()
700:             ENDIF
701: 
702:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
703:                 THIS.AlternarPagina(2)
704:             ELSE
705:                 THIS.AlternarPagina(1)
706:                 MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para confer" + CHR(234) + "ncia.", "Aviso")
707:             ENDIF
708:         CATCH TO loc_oErro
709:             MsgErro(loc_oErro.Message, "Erro BtnVisualizar")
710:         ENDTRY
711:     ENDPROC
712: 
713:     *==========================================================================
714:     * BtnExcluirClick - Limpa TODAS as leituras marcadas (zera QtdeLido)
715:     * Mapeamento semantico: em form OPERACIONAL, "excluir" = remover leituras
716:     * Operacao inversa de BtnAlterarClick / ConferirAutomatico
717:     *==========================================================================
718:     PROCEDURE BtnExcluirClick()
719:         LOCAL loc_oErro
720:         TRY
721:             IF !USED("TmpBaixa") OR RECCOUNT("TmpBaixa") = 0
722:                 MsgAviso("N" + CHR(227) + "o existem etiquetas para limpar.", "Aviso")
723:                 RETURN
724:             ENDIF
725: 
726:             IF !MsgConfirma("Limpar TODAS as leituras marcadas?")
727:                 RETURN
728:             ENDIF
729: 
730:             SELECT TmpBaixa
731:             REPLACE ALL QtdeLido WITH 0
732: 
733:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
734:                 THIS.grd_4c_Dados.Refresh()
735:             ENDIF
736:         CATCH TO loc_oErro
737:             MsgErro(loc_oErro.Message, "Erro BtnExcluir")
738:         ENDTRY
739:     ENDPROC
740: 
741:     *==========================================================================
742:     * CarregarLista - Recarrega etiquetas de TmpEnc e atualiza a grade
743:     *==========================================================================
744:     PROCEDURE CarregarLista()
745:         LOCAL loc_lResultado, loc_oErro
746:         loc_lResultado = .F.
747:         TRY
748:             IF VARTYPE(THIS.this_oParent) = "O"
749:                 THIS.this_oBusinessObject.CarregarBars("TmpEnc")
750:             ENDIF
751: 
752:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
753:                 THIS.grd_4c_Dados.ColumnCount = 5
754:                 THIS.grd_4c_Dados.RecordSource = "TmpBaixa"
755:                 WITH THIS.grd_4c_Dados
756:                     .Column1.ControlSource = "TmpBaixa.CodBarra"
757:                     .Column2.ControlSource = "TmpBaixa.CPros"
758:                     .Column3.ControlSource = "TmpBaixa.Dopes"
759:                     .Column4.ControlSource = "TmpBaixa.Numes"
760:                     .Column5.ControlSource = "TmpBaixa.QtdeLido"
761:                     .Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
762:                     .Column2.Header1.Caption = "Produto"
763:                     .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
764:                     .Column4.Header1.Caption = "N" + CHR(250) + "mero"
765:                     .Column5.Header1.Caption = "Qtde."
766:                     .Refresh()
767:                 ENDWITH
768:             ENDIF
769: 
770:             IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
771:                 THIS.AlternarPagina(2)
772:             ELSE
773:                 THIS.AlternarPagina(1)
774:             ENDIF
775: 
776:             loc_lResultado = .T.
777:         CATCH TO loc_oErro
778:             MsgErro(loc_oErro.Message, "Erro CarregarLista")
779:         ENDTRY
780:         RETURN loc_lResultado
781:     ENDPROC
782: 
783:     *==========================================================================
784:     * FormParaBO - Transfere estado do form para o Business Object
785:     *==========================================================================
786:     PROCEDURE FormParaBO()
787:         LOCAL loc_oErro
788:         TRY
789:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
790:                 IF VARTYPE(THIS.txt_4c_Data) = "O"
791:                     THIS.this_oBusinessObject.this_dData = THIS.txt_4c_Data.Value
792:                 ENDIF
793:             ENDIF
794:         CATCH TO loc_oErro
795:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
796:         ENDTRY
797:     ENDPROC
798: 
799:     *==========================================================================
800:     * BOParaForm - Carrega estado do Business Object para o form
801:     *==========================================================================
802:     PROCEDURE BOParaForm()
803:         LOCAL loc_oErro
804:         TRY
805:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
806:                 IF VARTYPE(THIS.txt_4c_Data) = "O"
807:                     IF !EMPTY(THIS.this_oBusinessObject.this_dData)
808:                         THIS.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
809:                     ENDIF
810:                 ENDIF
811:             ENDIF
812:         CATCH TO loc_oErro
813:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
814:         ENDTRY
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * HabilitarCampos - Habilita/desabilita controles conforme estado atual
819:     * par_lHabilitar = .T.: habilita leitura (TmpBaixa com dados)
820:     *                  .F.: desabilita leitura (TmpBaixa vazio)
821:     *==========================================================================
822:     PROCEDURE HabilitarCampos(par_lHabilitar)
823:         LOCAL loc_lHabilitar
824:         loc_lHabilitar = IIF(PCOUNT() >= 1, par_lHabilitar, .T.)
825:         IF VARTYPE(THIS.txt_4c_Leitura) = "O"
826:             THIS.txt_4c_Leitura.Enabled = loc_lHabilitar
827:         ENDIF
828:         IF VARTYPE(THIS.cmd_4c_Ok) = "O"
829:             THIS.cmd_4c_Ok.Visible = loc_lHabilitar
830:         ENDIF
831:         IF VARTYPE(THIS.cmd_4c_ConferirAuto) = "O"
832:             THIS.cmd_4c_ConferirAuto.Visible = loc_lHabilitar
833:         ENDIF
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * LimparCampos - Zera o campo de leitura de codigo de barras
838:     *==========================================================================
839:     PROCEDURE LimparCampos()
840:         LOCAL loc_oErro
841:         TRY
842:             IF VARTYPE(THIS.txt_4c_Leitura) = "O"
843:                 THIS.txt_4c_Leitura.Value = 0
844:             ENDIF
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
847:         ENDTRY
848:     ENDPROC
849: 
850:     *==========================================================================
851:     * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme dados
852:     * Verifica TmpBaixa e chama AlternarPagina para sincronizar estado visual
853:     *==========================================================================
854:     PROCEDURE AjustarBotoesPorModo()
855:         IF USED("TmpBaixa") AND RECCOUNT("TmpBaixa") > 0
856:             THIS.AlternarPagina(2)
857:             THIS.HabilitarCampos(.T.)
858:         ELSE
859:             THIS.AlternarPagina(1)
860:             THIS.HabilitarCampos(.F.)
861:         ENDIF
862:     ENDPROC
863: 
864:     *==========================================================================
865:     * BtnBuscarClick - Recarrega etiquetas do form pai (refresh completo)
866:     * Mapeamento semantico: em form OPERACIONAL, "buscar" = recarregar dados
867:     *==========================================================================
868:     PROCEDURE BtnBuscarClick()
869:         THIS.CarregarLista()
870:     ENDPROC
871: 
872:     *==========================================================================
873:     * BtnEncerrarClick - Encerra o form e reabilita o form pai
874:     * Alias de CmdEncerrarClick para padrao FormBase
875:     *==========================================================================
876:     PROCEDURE BtnEncerrarClick()
877:         THIS.CmdEncerrarClick()
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * BtnSalvarClick - Confirma a conferencia (alias de CmdOkClick)
882:     * Mapeamento semantico: em form OPERACIONAL, "salvar" = confirmar conferencia
883:     *==========================================================================
884:     PROCEDURE BtnSalvarClick()
885:         THIS.CmdOkClick()
886:     ENDPROC
887: 
888:     *==========================================================================
889:     * BtnCancelarClick - Descarta e encerra sem gravar (alias de CmdEncerrarClick)
890:     * Mapeamento semantico: em form OPERACIONAL, "cancelar" = sair sem confirmar
891:     *==========================================================================
892:     PROCEDURE BtnCancelarClick()
893:         THIS.CmdEncerrarClick()
894:     ENDPROC
895: 
896:     *==========================================================================
897:     PROCEDURE Destroy()
898:     *==========================================================================
899:         IF USED("TmpBaixa")
900:             USE IN TmpBaixa
901:         ENDIF
902:         THIS.this_oBusinessObject = .NULL.
903:         DODEFAULT()
904:     ENDPROC
905: 
906: ENDDEFINE


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
            SET NULL ON
            CREATE CURSOR cursor_4c_xGrava (Grupo C(10), Conta C(10), CPros C(14), Qtds N(12,3))
            SET NULL OFF
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
            SQLEXEC(gnConnHandle, "SELECT TOP 0 " + loc_lcCampos + " FROM " + par_cTabela, par_cCursor)
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

