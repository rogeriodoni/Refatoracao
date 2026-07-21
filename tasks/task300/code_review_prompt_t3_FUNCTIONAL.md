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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (803 linhas total):

*-- Linhas 36 a 108:
36:     FontSize     = 8
37: 
38:     *==========================================================================
39:     PROCEDURE Init()
40:     *-- Seta Caption antes de DODEFAULT() -> FormBase.Init() -> InicializarForm()
41:     *==========================================================================
42:         THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
43:         DODEFAULT()
44:     ENDPROC
45: 
46:     *==========================================================================
47:     PROCEDURE Destroy()
48:     *==========================================================================
49:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
50:             THIS.this_oBusinessObject = .NULL.
51:         ENDIF
52:         DODEFAULT()
53:     ENDPROC
54: 
55:     *==========================================================================
56:     PROTECTED PROCEDURE ConfigurarPageFrame()
57:     *-- Fundo identico ao legado (Picture = fundo_cadastro.jpg / new_background.jpg)
58:     *==========================================================================
59:         LOCAL loc_cImg
60:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
61:         IF FILE(loc_cImg)
62:             THIS.Picture = loc_cImg
63:         ENDIF
64:         THIS.ScrollBars = 0
65:     ENDPROC
66: 
67:     *==========================================================================
68:     PROTECTED PROCEDURE ConfigurarCabecalho()
69:     *-- Container cabecalho cinza (equivalente ao cntSombra do legado)
70:     *==========================================================================
71:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
72:         WITH THIS.cnt_4c_Cabecalho
73:             .Top         = 0
74:             .Left        = 0
75:             .Width       = THIS.Width
76:             .Height      = 80
77:             .BackStyle   = 1
78:             .BackColor   = RGB(100,100,100)
79:             .BorderWidth = 0
80: 
81:             .AddObject("lbl_4c_Sombra", "Label")
82:             WITH .lbl_4c_Sombra
83:                 .AutoSize      = .F.
84:                 .FontBold      = .T.
85:                 .FontName      = "Tahoma"
86:                 .FontSize      = 18
87:                 .FontUnderline = .F.
88:                 .WordWrap      = .T.
89:                 .Alignment     = 0
90:                 .BackStyle     = 0
91:                 .Caption       = ""
92:                 .Height        = 40
93:                 .Left          = 10
94:                 .Top           = 0
95:                 .Width         = THIS.Width
96:                 .ForeColor     = RGB(0,0,0)
97:             ENDWITH
98: 
99:             .AddObject("lbl_4c_Titulo", "Label")
100:             WITH .lbl_4c_Titulo
101:                 .AutoSize    = .F.
102:                 .FontBold    = .T.
103:                 .FontName    = "Tahoma"
104:                 .FontSize    = 18
105:                 .WordWrap    = .T.
106:                 .Alignment   = 0
107:                 .BackStyle   = 0
108:                 .Caption     = ""

*-- Linhas 118 a 201:
118:     ENDPROC
119: 
120:     *==========================================================================
121:     PROTECTED PROCEDURE InicializarForm()
122:     *-- Cria BO, carrega parametros e monta estrutura visual completa
123:     *==========================================================================
124:         LOCAL loc_lSucesso, loc_oErro
125:         loc_lSucesso = .F.
126: 
127:         TRY
128:             IF gnConnHandle <= 0
129:                 MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
130:             ELSE
131:                 THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")
132:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
133:                     MsgErro("Falha ao criar SigPrIctBO.", "Erro")
134:                 ELSE
135:                     IF NOT THIS.this_oBusinessObject.CarregarParametros()
136:                         MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
137:                     ELSE
138:                         THIS.ConfigurarPageFrame()
139:                         THIS.ConfigurarCabecalho()
140:                         THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
141:                         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
142:                         THIS.ConfigurarCampos()
143:                         THIS.ConfigurarBotoes()
144:                         THIS.ConfigurarPosProcessamento()
145:                         THIS.PopularCamposIniciais()
146:                         THIS.TornarControlesVisiveis()
147:                         THIS.ConfigurarEventos()
148:                         loc_lSucesso = .T.
149:                     ENDIF
150:                 ENDIF
151:             ENDIF
152:         CATCH TO loc_oErro
153:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
154:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
155:         ENDTRY
156: 
157:         RETURN loc_lSucesso
158:     ENDPROC
159: 
160:     *==========================================================================
161:     PROTECTED PROCEDURE ConfigurarCampos()
162:     *-- Labels "Inicial :"/"Final :" e TextBoxes de data (legado: Label2/3 + Get_DataI/F)
163:     *==========================================================================
164:         THIS.AddObject("lbl_4c_LblIni", "Label")
165:         WITH THIS.lbl_4c_LblIni
166:             .AutoSize  = .F.
167:             .FontName  = "Tahoma"
168:             .FontSize  = 8
169:             .BackStyle = 0
170:             .Caption   = "Inicial : "
171:             .Height    = 15
172:             .Left      = 186
173:             .Top       = 108
174:             .Width     = 43
175:             .ForeColor = RGB(90,90,90)
176:         ENDWITH
177: 
178:         THIS.AddObject("txt_4c_DataI", "TextBox")
179:         WITH THIS.txt_4c_DataI
180:             .Value         = {}
181:             .Format        = "K"
182:             .Height        = 23
183:             .Left          = 227
184:             .Top           = 105
185:             .Width         = 80
186:             .SpecialEffect = 1
187:             .FontName      = "Tahoma"
188:             .FontSize      = 8
189:             .Alignment     = 3
190:         ENDWITH
191: 
192:         THIS.AddObject("lbl_4c_LblFin", "Label")
193:         WITH THIS.lbl_4c_LblFin
194:             .AutoSize  = .F.
195:             .FontName  = "Tahoma"
196:             .FontSize  = 8
197:             .BackStyle = 0
198:             .Caption   = "Final : "
199:             .Height    = 15
200:             .Left      = 191
201:             .Top       = 141

*-- Linhas 249 a 292:
249:     ENDPROC
250: 
251:     *==========================================================================
252:     PROTECTED PROCEDURE ConfigurarBotoes()
253:     *-- Processar + Encerrar (equivalente ao btnReport principal do legado)
254:     *-- Processar: Left=321 Top=95 | Encerrar: Left=401 Top=95
255:     *==========================================================================
256:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
257:         WITH THIS.cmd_4c_Processar
258:             .Top             = 95
259:             .Left            = 321
260:             .Height          = 75
261:             .Width           = 75
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .FontName        = "Tahoma"
265:             .FontSize        = 8
266:             .WordWrap        = .T.
267:             .Caption         = "Processar"
268:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
269:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
270:             .ForeColor       = RGB(90,90,90)
271:             .BackColor       = RGB(255,255,255)
272:             .Themes          = .T.
273:             .PicturePosition = 13
274:             .SpecialEffect   = 0
275:             .MousePointer    = 15
276:         ENDWITH
277: 
278:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
279:         WITH THIS.cmd_4c_Encerrar
280:             .Top             = 95
281:             .Left            = 401
282:             .Height          = 75
283:             .Width           = 75
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .FontName        = "Tahoma"
287:             .FontSize        = 8
288:             .WordWrap        = .T.
289:             .Caption         = "Encerrar"
290:             .Cancel          = .T.
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
292:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 300 a 343:
300:     ENDPROC
301: 
302:     *==========================================================================
303:     PROTECTED PROCEDURE ConfigurarPosProcessamento()
304:     *-- Container com botoes Video/Imprimir/Encerrar, visivel apenas apos
305:     *-- processamento com inconsistencias. Cobre area dos botoes principais.
306:     *-- Equivalente ao cntBotoes legado (Left=247 Top=88 Width=252 quando visivel)
307:     *==========================================================================
308:         THIS.AddObject("cnt_4c_PosProc", "Container")
309:         WITH THIS.cnt_4c_PosProc
310:             .Top         = 88
311:             .Left        = 247
312:             .Width       = 252
313:             .Height      = 90
314:             .BackStyle   = 1
315:             .BackColor   = RGB(214,222,233)
316:             .BorderWidth = 0
317:             .Visible     = .F.
318: 
319:             .AddObject("cmd_4c_Visualizar", "CommandButton")
320:             WITH .cmd_4c_Visualizar
321:                 .Top             = 5
322:                 .Left            = 5
323:                 .Height          = 75
324:                 .Width           = 75
325:                 .FontBold        = .T.
326:                 .FontItalic      = .T.
327:                 .FontName        = "Tahoma"
328:                 .FontSize        = 8
329:                 .WordWrap        = .T.
330:                 .Caption         = " V" + CHR(237) + "deo    "
331:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
332:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
333:                 .ForeColor       = RGB(90,90,90)
334:                 .BackColor       = RGB(255,255,255)
335:                 .PicturePosition = 13
336:                 .SpecialEffect   = 0
337:                 .MousePointer    = 15
338:             ENDWITH
339: 
340:             .AddObject("cmd_4c_Imprimir", "CommandButton")
341:             WITH .cmd_4c_Imprimir
342:                 .Top             = 5
343:                 .Left            = 80

*-- Linhas 385 a 803:
385:     ENDPROC
386: 
387:     *==========================================================================
388:     PROTECTED PROCEDURE PopularCamposIniciais()
389:     *-- Inicializa datas com data corrente (legado: .Get_Datai.Value = Date())
390:     *==========================================================================
391:         THIS.txt_4c_DataI.Value = DATE()
392:         THIS.txt_4c_DataF.Value = DATE()
393:     ENDPROC
394: 
395:     *==========================================================================
396:     PROTECTED PROCEDURE ConfigurarEventos()
397:     *==========================================================================
398:         BINDEVENT(THIS.cmd_4c_Processar,                  "Click", THIS, "CmdProcessarClick")
399:         BINDEVENT(THIS.cmd_4c_Encerrar,                   "Click", THIS, "CmdEncerrarClick")
400:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Visualizar,  "Click", THIS, "CmdVisualizarClick")
401:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Imprimir,    "Click", THIS, "CmdImprimirClick")
402:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Sair,        "Click", THIS, "CmdGravarEncerrarClick")
403:     ENDPROC
404: 
405:     *==========================================================================
406:     PROCEDURE CmdProcessarClick()
407:     *-- Valida datas, confirma e dispara ChamarProcessar
408:     *==========================================================================
409:         IF EMPTY(THIS.txt_4c_DataI.Value)
410:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
411:             THIS.txt_4c_DataI.SetFocus()
412:             RETURN
413:         ENDIF
414:         IF EMPTY(THIS.txt_4c_DataF.Value)
415:             MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
416:             THIS.txt_4c_DataF.SetFocus()
417:             RETURN
418:         ENDIF
419:         IF THIS.txt_4c_DataF.Value < THIS.txt_4c_DataI.Value
420:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
421:             THIS.txt_4c_DataF.SetFocus()
422:             RETURN
423:         ENDIF
424:         IF NOT MsgConfirma("Confirma o Processamento ?")
425:             RETURN
426:         ENDIF
427:         THIS.ChamarProcessar()
428:     ENDPROC
429: 
430:     *==========================================================================
431:     PROCEDURE ChamarProcessar()
432:     *-- Executa InicializarCursores + Processar no BO e trata resultados
433:     *==========================================================================
434:         LOCAL loc_lResultado, loc_oErro, loc_oDifErro
435:         loc_lResultado = .F.
436: 
437:         TRY
438:             THIS.this_oBusinessObject.InicializarCursores()
439: 
440:             loc_lResultado = THIS.this_oBusinessObject.Processar( ;
441:                 THIS.txt_4c_DataI.Value, ;
442:                 THIS.txt_4c_DataF.Value)
443: 
444:             IF loc_lResultado
445:                 *-- Verifica diferencas entre debitos e creditos (legado: SigReDif)
446:                 IF THIS.this_oBusinessObject.this_lTemDiferencas
447:                     IF MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?")
448:                         TRY
449:                             DO FORM FormSigReDif WITH THIS.DataSessionId
450:                         CATCH TO loc_oDifErro
451:                             MsgAviso("Formul" + CHR(225) + "rio SigReDif n" + CHR(227) + ;
452:                                      "o dispon" + CHR(237) + "vel.")
453:                         ENDTRY
454:                     ENDIF
455:                     THIS.this_oBusinessObject.this_lTemDiferencas = .F.
456:                 ENDIF
457: 
458:                 *-- Verifica inconsistencias (SemConta com contas sem mapeamento)
459:                 IF THIS.this_oBusinessObject.this_lTemInconsistencias AND ;
460:                    USED("SemConta") AND RECCOUNT("SemConta") > 0
461:                     *-- Exibe container pos-processamento (Video/Imprimir/Encerrar)
462:                     *-- e bloqueia inputs ate decisao do usuario
463:                     THIS.cmd_4c_Processar.Enabled = .F.
464:                     THIS.txt_4c_DataI.Enabled     = .F.
465:                     THIS.txt_4c_DataF.Enabled     = .F.
466:                     THIS.cnt_4c_PosProc.Visible   = .T.
467:                 ELSE
468:                     *-- Sem inconsistencias: avisa e vai direto para geracao do arquivo
469:                     IF USED("MovAux") AND RECCOUNT("MovAux") > 0
470:                         MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!")
471:                     ELSE
472:                         MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + ;
473:                                  CHR(227) + "o no Per" + CHR(237) + "odo!!!")
474:                     ENDIF
475:                     THIS.ChamarGravar()
476:                 ENDIF
477:             ELSE
478:                 IF NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
479:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
480:                 ENDIF
481:             ENDIF
482:         CATCH TO loc_oErro
483:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
484:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
485:         ENDTRY
486:     ENDPROC
487: 
488:     *==========================================================================
489:     PROCEDURE CmdEncerrarClick()
490:     *==========================================================================
491:         THIS.Release()
492:     ENDPROC
493: 
494:     *==========================================================================
495:     PROCEDURE CmdVisualizarClick()
496:     *-- Exibe relatorio de inconsistencias em preview e chama ChamarGravar
497:     *==========================================================================
498:         THIS.ExecutarRelatorioInconsistencias("PREVIEW")
499:     ENDPROC
500: 
501:     *==========================================================================
502:     PROCEDURE CmdImprimirClick()
503:     *-- Imprime relatorio de inconsistencias e chama ChamarGravar
504:     *==========================================================================
505:         THIS.ExecutarRelatorioInconsistencias("PRINT")
506:     ENDPROC
507: 
508:     *==========================================================================
509:     PROCEDURE CmdGravarEncerrarClick()
510:     *-- Botao Encerrar do pos-processamento: apenas confirma geracao do arquivo
511:     *==========================================================================
512:         THIS.ChamarGravar()
513:     ENDPROC
514: 
515:     *==========================================================================
516:     PROCEDURE ChamarGravar()
517:     *-- Restaura UI, confirma e delega geracao do arquivo contabil ao BO
518:     *-- Equivalente ao PROCEDURE gravar do legado
519:     *==========================================================================
520:         LOCAL loc_lResultado, loc_oErro
521:         loc_lResultado = .F.
522: 
523:         *-- Restaura interface (equivalente: cntBotoes.Visible=.F. + reenablecontrols)
524:         THIS.cnt_4c_PosProc.Visible   = .F.
525:         THIS.cmd_4c_Processar.Enabled = .T.
526:         THIS.txt_4c_DataI.Enabled     = .T.
527:         THIS.txt_4c_DataF.Enabled     = .T.
528: 
529:         IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
530:             TRY
531:                 loc_lResultado = THIS.this_oBusinessObject.GerarArquivoContabil()
532:                 IF NOT loc_lResultado AND ;
533:                    NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
534:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
535:                 ENDIF
536:             CATCH TO loc_oErro
537:                 MsgErro("Erro ao gerar arquivo: " + loc_oErro.Message, "Erro")
538:             ENDTRY
539:         ENDIF
540:     ENDPROC
541: 
542:     *==========================================================================
543:     PROCEDURE ExecutarRelatorioInconsistencias(par_cModo)
544:     *-- Exibe relatorio SIGPRICT (inconsistencias de integracao contabil)
545:     *-- par_cModo: "PREVIEW" ou "PRINT"
546:     *-- Apos exibicao chama ChamarGravar() para confirmar geracao do arquivo
547:     *==========================================================================
548:         LOCAL loc_cFrx, loc_cSavedPoint, loc_cSavedSep
549:         LOCAL loc_nSavedBehavior, loc_oErro
550: 
551:         IF NOT USED("SemConta") OR RECCOUNT("SemConta") = 0
552:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia para exibir.")
553:             THIS.ChamarGravar()
554:             RETURN
555:         ENDIF
556: 
557:         loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SIGPRICT.frx")
558:         IF NOT FILE(loc_cFrx)
559:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + ;
560:                     loc_cFrx, "Erro")
561:             THIS.ChamarGravar()
562:             RETURN
563:         ENDIF
564: 
565:         loc_cSavedPoint    = SET("POINT")
566:         loc_cSavedSep      = SET("SEPARATOR")
567:         loc_nSavedBehavior = _REPORTBEHAVIOR
568: 
569:         SET POINT TO "."
570:         SET SEPARATOR TO ","
571:         _REPORTBEHAVIOR = 80
572: 
573:         TRY
574:             IF UPPER(ALLTRIM(par_cModo)) = "PRINT"
575:                 REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
576:             ELSE
577:                 REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
578:             ENDIF
579:         CATCH TO loc_oErro
580:             MsgErro("Erro ao exibir relat" + CHR(243) + "rio: " + loc_oErro.Message, "Erro")
581:         ENDTRY
582: 
583:         SET POINT TO (loc_cSavedPoint)
584:         SET SEPARATOR TO (loc_cSavedSep)
585:         _REPORTBEHAVIOR = loc_nSavedBehavior
586: 
587:         THIS.ChamarGravar()
588:     ENDPROC
589: 
590:     *==========================================================================
591:     PROTECTED PROCEDURE ConfigurarPaginaLista()
592:     *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe PageFrame,
593:     *-- NAO existe grid de lista e NAO existe fluxo Page1=Lista/Page2=Dados.
594:     *-- Layout SCX legado (SigPrIct.SCX): cntSombra + Get_DataI/F + btnReport +
595:     *-- cntBotoes flutuante. Toda a estrutura visual e criada em ConfigurarCampos,
596:     *-- ConfigurarBotoes e ConfigurarPosProcessamento, chamados em InicializarForm.
597:     *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase; nao
598:     *-- ha nada a configurar em uma "Page Lista" que nao existe neste form.
599:     *==========================================================================
600:         RETURN
601:     ENDPROC
602: 
603:     *==========================================================================
604:     PROTECTED PROCEDURE ConfigurarPaginaDados()
605:     *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe Page2 de dados.
606:     *-- O SCX legado (SIGPRICT) nao tem PageFrame de conteudo; todos os campos
607:     *-- (Get_DataI, Get_DataF, labels de periodo) e botoes sao filhos diretos
608:     *-- do form. Toda a estrutura foi criada em ConfigurarCampos(), ConfigurarBotoes()
609:     *-- e ConfigurarPosProcessamento(), chamados em InicializarForm().
610:     *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase.
611:     *==========================================================================
612:         RETURN
613:     ENDPROC
614: 
615:     *==========================================================================
616:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
617:     *-- Form OPERACIONAL flat: NAO possui PageFrame nem multiplas pages para
618:     *-- alternar. A alternancia de UI se da via visibility toggle no container
619:     *-- cnt_4c_PosProc (metodos ChamarProcessar/ChamarGravar controlam Visible).
620:     *-- Assinatura preservada para satisfazer contrato do pipeline multi-fase.
621:     *==========================================================================
622:         LOCAL loc_nIgnorado
623:         loc_nIgnorado = par_nPagina
624:         RETURN
625:     ENDPROC
626: 
627:     *==========================================================================
628:     PROTECTED PROCEDURE TornarControlesVisiveis()
629:     *-- Torna visiveis todos os controles exceto containers/labels flutuantes:
630:     *-- cnt_4c_PosProc (visivel apenas apos processamento com inconsistencias)
631:     *-- lbl_4c_Label4 (oculto por design como no legado, Visible=.F.)
632:     *-- cnt_4c_Cabecalho (header fixo, ignorado completamente pelo loop)
633:     *==========================================================================
634:         LOCAL loc_i, loc_oCtrl
635:         FOR loc_i = 1 TO THIS.ControlCount
636:             loc_oCtrl = THIS.Controls[loc_i]
637:             IF VARTYPE(loc_oCtrl) = "O"
638:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_CABECALHO")
639:                     LOOP
640:                 ENDIF
641:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_POSPROC", "LBL_4C_LABEL4")
642:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
643:                         THIS.TornarFilhosVisiveis(loc_oCtrl)
644:                     ENDIF
645:                     LOOP
646:                 ENDIF
647:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
648:                     loc_oCtrl.Visible = .T.
649:                 ENDIF
650:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
651:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
652:                 ENDIF
653:             ENDIF
654:         ENDFOR
655:     ENDPROC
656: 
657:     *==========================================================================
658:     PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
659:     *==========================================================================
660:         LOCAL loc_i, loc_oCtrl
661:         FOR loc_i = 1 TO par_oContainer.ControlCount
662:             loc_oCtrl = par_oContainer.Controls[loc_i]
663:             IF VARTYPE(loc_oCtrl) = "O"
664:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
665:                     loc_oCtrl.Visible = .T.
666:                 ENDIF
667:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
668:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
669:                 ENDIF
670:             ENDIF
671:         ENDFOR
672:     ENDPROC
673: 
674:     *==========================================================================
675:     PROCEDURE BtnIncluirClick()
676:     *-- Form OPERACIONAL flat: NAO possui fluxo de inclusao de registro.
677:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
678:     *==========================================================================
679:         RETURN
680:     ENDPROC
681: 
682:     *==========================================================================
683:     PROCEDURE BtnAlterarClick()
684:     *-- Form OPERACIONAL flat: NAO possui fluxo de alteracao de registro.
685:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
686:     *==========================================================================
687:         RETURN
688:     ENDPROC
689: 
690:     *==========================================================================
691:     PROCEDURE BtnVisualizarClick()
692:     *-- Form OPERACIONAL flat: a acao de visualizacao e CmdVisualizarClick()
693:     *-- (relatorio de inconsistencias pos-processamento). Stub mantido para
694:     *-- satisfazer contrato do pipeline multi-fase.
695:     *==========================================================================
696:         RETURN
697:     ENDPROC
698: 
699:     *==========================================================================
700:     PROCEDURE BtnExcluirClick()
701:     *-- Form OPERACIONAL flat: NAO possui fluxo de exclusao de registro.
702:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
703:     *==========================================================================
704:         RETURN
705:     ENDPROC
706: 
707:     *==========================================================================
708:     PROCEDURE BtnBuscarClick()
709:     *-- Form OPERACIONAL flat: NAO possui fluxo de busca de registro.
710:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
711:     *==========================================================================
712:         RETURN
713:     ENDPROC
714: 
715:     *==========================================================================
716:     PROCEDURE BtnEncerrarClick()
717:     *==========================================================================
718:         THIS.Release()
719:     ENDPROC
720: 
721:     *==========================================================================
722:     PROCEDURE BtnSalvarClick()
723:     *-- Form OPERACIONAL flat: NAO possui fluxo de gravacao CRUD.
724:     *-- Salvamento efetivo se da via ChamarGravar() apos processamento.
725:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
726:     *==========================================================================
727:         RETURN
728:     ENDPROC
729: 
730:     *==========================================================================
731:     PROCEDURE BtnCancelarClick()
732:     *-- Form OPERACIONAL flat: NAO possui fluxo de cancelamento CRUD.
733:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
734:     *==========================================================================
735:         RETURN
736:     ENDPROC
737: 
738:     *==========================================================================
739:     PROTECTED PROCEDURE FormParaBO()
740:     *-- Transfere os campos de data informados pelo usuario para o BO.
741:     *==========================================================================
742:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
743:             THIS.this_oBusinessObject.this_dDataI = THIS.txt_4c_DataI.Value
744:             THIS.this_oBusinessObject.this_dDataF = THIS.txt_4c_DataF.Value
745:         ENDIF
746:     ENDPROC
747: 
748:     *==========================================================================
749:     PROTECTED PROCEDURE BOParaForm()
750:     *-- Restaura os campos de data a partir do estado do BO.
751:     *==========================================================================
752:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
753:             RETURN
754:         ENDIF
755:         IF !EMPTY(THIS.this_oBusinessObject.this_dDataI)
756:             THIS.txt_4c_DataI.Value = THIS.this_oBusinessObject.this_dDataI
757:         ENDIF
758:         IF !EMPTY(THIS.this_oBusinessObject.this_dDataF)
759:             THIS.txt_4c_DataF.Value = THIS.this_oBusinessObject.this_dDataF
760:         ENDIF
761:     ENDPROC
762: 
763:     *==========================================================================
764:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
765:     *-- Habilita ou desabilita os campos de entrada e o botao Processar.
766:     *==========================================================================
767:         IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
768:             THIS.txt_4c_DataI.Enabled = par_lHabilitar
769:         ENDIF
770:         IF PEMSTATUS(THIS, "txt_4c_DataF", 5)
771:             THIS.txt_4c_DataF.Enabled = par_lHabilitar
772:         ENDIF
773:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
774:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
775:         ENDIF
776:     ENDPROC
777: 
778:     *==========================================================================
779:     PROTECTED PROCEDURE LimparCampos()
780:     *-- Redefine os campos de data para a data corrente (estado inicial).
781:     *==========================================================================
782:         THIS.txt_4c_DataI.Value = DATE()
783:         THIS.txt_4c_DataF.Value = DATE()
784:     ENDPROC
785: 
786:     *==========================================================================
787:     PROCEDURE CarregarLista()
788:     *-- Form OPERACIONAL flat: NAO possui grade de registros para carregar.
789:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
790:     *==========================================================================
791:         RETURN .T.
792:     ENDPROC
793: 
794:     *==========================================================================
795:     PROTECTED PROCEDURE AjustarBotoesPorModo()
796:     *-- Form OPERACIONAL flat: NAO possui modos INCLUIR/ALTERAR/VISUALIZAR.
797:     *-- O estado dos botoes e controlado diretamente em ChamarProcessar/Gravar.
798:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
799:     *==========================================================================
800:         RETURN
801:     ENDPROC
802: 
803: ENDDEFINE

