# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrIct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (798 linhas total):

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

*-- Linhas 117 a 200:
117:     ENDPROC
118: 
119:     *==========================================================================
120:     PROTECTED PROCEDURE InicializarForm()
121:     *-- Cria BO, carrega parametros e monta estrutura visual completa
122:     *==========================================================================
123:         LOCAL loc_lSucesso, loc_oErro
124:         loc_lSucesso = .F.
125: 
126:         TRY
127:             IF gnConnHandle <= 0
128:                 MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro")
129:             ELSE
130:                 THIS.this_oBusinessObject = CREATEOBJECT("SigPrIctBO")
131:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
132:                     MsgErro("Falha ao criar SigPrIctBO.", "Erro")
133:                 ELSE
134:                     IF NOT THIS.this_oBusinessObject.CarregarParametros()
135:                         MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
136:                     ELSE
137:                         THIS.ConfigurarPageFrame()
138:                         THIS.ConfigurarCabecalho()
139:                         THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
140:                         THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
141:                         THIS.ConfigurarCampos()
142:                         THIS.ConfigurarBotoes()
143:                         THIS.ConfigurarPosProcessamento()
144:                         THIS.PopularCamposIniciais()
145:                         THIS.TornarControlesVisiveis()
146:                         THIS.ConfigurarEventos()
147:                         loc_lSucesso = .T.
148:                     ENDIF
149:                 ENDIF
150:             ENDIF
151:         CATCH TO loc_oErro
152:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
153:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
154:         ENDTRY
155: 
156:         RETURN loc_lSucesso
157:     ENDPROC
158: 
159:     *==========================================================================
160:     PROTECTED PROCEDURE ConfigurarCampos()
161:     *-- Labels "Inicial :"/"Final :" e TextBoxes de data (legado: Label2/3 + Get_DataI/F)
162:     *==========================================================================
163:         THIS.AddObject("lbl_4c_LblIni", "Label")
164:         WITH THIS.lbl_4c_LblIni
165:             .AutoSize  = .F.
166:             .FontName  = "Tahoma"
167:             .FontSize  = 8
168:             .BackStyle = 0
169:             .Caption   = "Inicial : "
170:             .Height    = 15
171:             .Left      = 186
172:             .Top       = 108
173:             .Width     = 43
174:             .ForeColor = RGB(90,90,90)
175:         ENDWITH
176: 
177:         THIS.AddObject("txt_4c_DataI", "TextBox")
178:         WITH THIS.txt_4c_DataI
179:             .Value         = {}
180:             .Format        = "K"
181:             .Height        = 23
182:             .Left          = 227
183:             .Top           = 105
184:             .Width         = 80
185:             .SpecialEffect = 1
186:             .FontName      = "Tahoma"
187:             .FontSize      = 8
188:             .Alignment     = 3
189:         ENDWITH
190: 
191:         THIS.AddObject("lbl_4c_LblFin", "Label")
192:         WITH THIS.lbl_4c_LblFin
193:             .AutoSize  = .F.
194:             .FontName  = "Tahoma"
195:             .FontSize  = 8
196:             .BackStyle = 0
197:             .Caption   = "Final : "
198:             .Height    = 15
199:             .Left      = 191
200:             .Top       = 141

*-- Linhas 248 a 291:
248:     ENDPROC
249: 
250:     *==========================================================================
251:     PROTECTED PROCEDURE ConfigurarBotoes()
252:     *-- Processar + Encerrar (equivalente ao btnReport principal do legado)
253:     *-- Processar: Left=321 Top=95 | Encerrar: Left=401 Top=95
254:     *==========================================================================
255:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
256:         WITH THIS.cmd_4c_Processar
257:             .Top             = 95
258:             .Left            = 321
259:             .Height          = 75
260:             .Width           = 75
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontName        = "Tahoma"
264:             .FontSize        = 8
265:             .WordWrap        = .T.
266:             .Caption         = "Processar"
267:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
268:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
269:             .ForeColor       = RGB(90,90,90)
270:             .BackColor       = RGB(255,255,255)
271:             .Themes          = .T.
272:             .PicturePosition = 13
273:             .SpecialEffect   = 0
274:             .MousePointer    = 15
275:         ENDWITH
276: 
277:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
278:         WITH THIS.cmd_4c_Encerrar
279:             .Top             = 95
280:             .Left            = 401
281:             .Height          = 75
282:             .Width           = 75
283:             .FontBold        = .T.
284:             .FontItalic      = .T.
285:             .FontName        = "Tahoma"
286:             .FontSize        = 8
287:             .WordWrap        = .T.
288:             .Caption         = "Encerrar"
289:             .Cancel          = .T.
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
291:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 299 a 342:
299:     ENDPROC
300: 
301:     *==========================================================================
302:     PROTECTED PROCEDURE ConfigurarPosProcessamento()
303:     *-- Container com botoes Video/Imprimir/Encerrar, visivel apenas apos
304:     *-- processamento com inconsistencias. Cobre area dos botoes principais.
305:     *-- Equivalente ao cntBotoes legado (Left=247 Top=88 Width=252 quando visivel)
306:     *==========================================================================
307:         THIS.AddObject("cnt_4c_PosProc", "Container")
308:         WITH THIS.cnt_4c_PosProc
309:             .Top         = 88
310:             .Left        = 247
311:             .Width       = 252
312:             .Height      = 90
313:             .BackStyle   = 1
314:             .BackColor   = RGB(214,222,233)
315:             .BorderWidth = 0
316:             .Visible     = .F.
317: 
318:             .AddObject("cmd_4c_Visualizar", "CommandButton")
319:             WITH .cmd_4c_Visualizar
320:                 .Top             = 5
321:                 .Left            = 5
322:                 .Height          = 75
323:                 .Width           = 75
324:                 .FontBold        = .T.
325:                 .FontItalic      = .T.
326:                 .FontName        = "Tahoma"
327:                 .FontSize        = 8
328:                 .WordWrap        = .T.
329:                 .Caption         = " V" + CHR(237) + "deo    "
330:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
331:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
332:                 .ForeColor       = RGB(90,90,90)
333:                 .BackColor       = RGB(255,255,255)
334:                 .PicturePosition = 13
335:                 .SpecialEffect   = 0
336:                 .MousePointer    = 15
337:             ENDWITH
338: 
339:             .AddObject("cmd_4c_Imprimir", "CommandButton")
340:             WITH .cmd_4c_Imprimir
341:                 .Top             = 5
342:                 .Left            = 80

*-- Linhas 384 a 798:
384:     ENDPROC
385: 
386:     *==========================================================================
387:     PROTECTED PROCEDURE PopularCamposIniciais()
388:     *-- Inicializa datas com data corrente (legado: .Get_Datai.Value = Date())
389:     *==========================================================================
390:         THIS.txt_4c_DataI.Value = DATE()
391:         THIS.txt_4c_DataF.Value = DATE()
392:     ENDPROC
393: 
394:     *==========================================================================
395:     PROTECTED PROCEDURE ConfigurarEventos()
396:     *==========================================================================
397:         BINDEVENT(THIS.cmd_4c_Processar,                  "Click", THIS, "CmdProcessarClick")
398:         BINDEVENT(THIS.cmd_4c_Encerrar,                   "Click", THIS, "CmdEncerrarClick")
399:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Visualizar,  "Click", THIS, "CmdVisualizarClick")
400:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Imprimir,    "Click", THIS, "CmdImprimirClick")
401:         BINDEVENT(THIS.cnt_4c_PosProc.cmd_4c_Sair,        "Click", THIS, "CmdGravarEncerrarClick")
402:     ENDPROC
403: 
404:     *==========================================================================
405:     PROCEDURE CmdProcessarClick()
406:     *-- Valida datas, confirma e dispara ChamarProcessar
407:     *==========================================================================
408:         IF EMPTY(THIS.txt_4c_DataI.Value)
409:             MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!")
410:             THIS.txt_4c_DataI.SetFocus()
411:             RETURN
412:         ENDIF
413:         IF EMPTY(THIS.txt_4c_DataF.Value)
414:             MsgAviso("Data Final Inv" + CHR(225) + "lida!!!")
415:             THIS.txt_4c_DataF.SetFocus()
416:             RETURN
417:         ENDIF
418:         IF THIS.txt_4c_DataF.Value < THIS.txt_4c_DataI.Value
419:             MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!")
420:             THIS.txt_4c_DataF.SetFocus()
421:             RETURN
422:         ENDIF
423:         IF NOT MsgConfirma("Confirma o Processamento ?")
424:             RETURN
425:         ENDIF
426:         THIS.ChamarProcessar()
427:     ENDPROC
428: 
429:     *==========================================================================
430:     PROCEDURE ChamarProcessar()
431:     *-- Executa InicializarCursores + Processar no BO e trata resultados
432:     *==========================================================================
433:         LOCAL loc_lResultado, loc_oErro, loc_oDifErro
434:         loc_lResultado = .F.
435: 
436:         TRY
437:             THIS.this_oBusinessObject.InicializarCursores()
438: 
439:             loc_lResultado = THIS.this_oBusinessObject.Processar( ;
440:                 THIS.txt_4c_DataI.Value, ;
441:                 THIS.txt_4c_DataF.Value)
442: 
443:             IF loc_lResultado
444:                 *-- Verifica diferencas entre debitos e creditos (legado: SigReDif)
445:                 IF THIS.this_oBusinessObject.this_lTemDiferencas
446:                     IF MsgConfirma("Visualizar as diferen" + CHR(231) + "as na Tela?")
447:                         TRY
448:                             DO FORM FormSigReDif WITH THIS.DataSessionId
449:                         CATCH TO loc_oDifErro
450:                             MsgAviso("Formul" + CHR(225) + "rio SigReDif n" + CHR(227) + ;
451:                                      "o dispon" + CHR(237) + "vel.")
452:                         ENDTRY
453:                     ENDIF
454:                     THIS.this_oBusinessObject.this_lTemDiferencas = .F.
455:                 ENDIF
456: 
457:                 *-- Verifica inconsistencias (SemConta com contas sem mapeamento)
458:                 IF THIS.this_oBusinessObject.this_lTemInconsistencias AND ;
459:                    USED("SemConta") AND RECCOUNT("SemConta") > 0
460:                     *-- Exibe container pos-processamento (Video/Imprimir/Encerrar)
461:                     *-- e bloqueia inputs ate decisao do usuario
462:                     THIS.cmd_4c_Processar.Enabled = .F.
463:                     THIS.txt_4c_DataI.Enabled     = .F.
464:                     THIS.txt_4c_DataF.Enabled     = .F.
465:                     THIS.cnt_4c_PosProc.Visible   = .T.
466:                 ELSE
467:                     *-- Sem inconsistencias: avisa e vai direto para geracao do arquivo
468:                     IF USED("MovAux") AND RECCOUNT("MovAux") > 0
469:                         MsgAviso("Nenhuma Inconsist" + CHR(234) + "ncia Foi Encontrada!!!")
470:                     ELSE
471:                         MsgAviso("N" + CHR(227) + "o Existe Movimenta" + CHR(231) + ;
472:                                  CHR(227) + "o no Per" + CHR(237) + "odo!!!")
473:                     ENDIF
474:                     THIS.ChamarGravar()
475:                 ENDIF
476:             ELSE
477:                 IF NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
478:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
479:                 ENDIF
480:             ENDIF
481:         CATCH TO loc_oErro
482:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
483:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
484:         ENDTRY
485:     ENDPROC
486: 
487:     *==========================================================================
488:     PROCEDURE CmdEncerrarClick()
489:     *==========================================================================
490:         THIS.Release()
491:     ENDPROC
492: 
493:     *==========================================================================
494:     PROCEDURE CmdVisualizarClick()
495:     *-- Exibe relatorio de inconsistencias em preview e chama ChamarGravar
496:     *==========================================================================
497:         THIS.ExecutarRelatorioInconsistencias("PREVIEW")
498:     ENDPROC
499: 
500:     *==========================================================================
501:     PROCEDURE CmdImprimirClick()
502:     *-- Imprime relatorio de inconsistencias e chama ChamarGravar
503:     *==========================================================================
504:         THIS.ExecutarRelatorioInconsistencias("PRINT")
505:     ENDPROC
506: 
507:     *==========================================================================
508:     PROCEDURE CmdGravarEncerrarClick()
509:     *-- Botao Encerrar do pos-processamento: apenas confirma geracao do arquivo
510:     *==========================================================================
511:         THIS.ChamarGravar()
512:     ENDPROC
513: 
514:     *==========================================================================
515:     PROCEDURE ChamarGravar()
516:     *-- Restaura UI, confirma e delega geracao do arquivo contabil ao BO
517:     *-- Equivalente ao PROCEDURE gravar do legado
518:     *==========================================================================
519:         LOCAL loc_lResultado, loc_oErro
520:         loc_lResultado = .F.
521: 
522:         *-- Restaura interface (equivalente: cntBotoes.Visible=.F. + reenablecontrols)
523:         THIS.cnt_4c_PosProc.Visible   = .F.
524:         THIS.cmd_4c_Processar.Enabled = .T.
525:         THIS.txt_4c_DataI.Enabled     = .T.
526:         THIS.txt_4c_DataF.Enabled     = .T.
527: 
528:         IF MsgConfirma("Confirma a Gera" + CHR(231) + CHR(227) + "o do Arquivo?")
529:             TRY
530:                 loc_lResultado = THIS.this_oBusinessObject.GerarArquivoContabil()
531:                 IF NOT loc_lResultado AND ;
532:                    NOT EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
533:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
534:                 ENDIF
535:             CATCH TO loc_oErro
536:                 MsgErro("Erro ao gerar arquivo: " + loc_oErro.Message, "Erro")
537:             ENDTRY
538:         ENDIF
539:     ENDPROC
540: 
541:     *==========================================================================
542:     PROCEDURE ExecutarRelatorioInconsistencias(par_cModo)
543:     *-- Exibe relatorio SIGPRICT (inconsistencias de integracao contabil)
544:     *-- par_cModo: "PREVIEW" ou "PRINT"
545:     *-- Apos exibicao chama ChamarGravar() para confirmar geracao do arquivo
546:     *==========================================================================
547:         LOCAL loc_cFrx, loc_cSavedPoint, loc_cSavedSep
548:         LOCAL loc_nSavedBehavior, loc_oErro
549: 
550:         IF NOT USED("SemConta") OR RECCOUNT("SemConta") = 0
551:             MsgAviso("Nenhuma inconsist" + CHR(234) + "ncia para exibir.")
552:             THIS.ChamarGravar()
553:             RETURN
554:         ENDIF
555: 
556:         loc_cFrx = FULLPATH(gc_4c_CaminhoReports + "SIGPRICT.frx")
557:         IF NOT FILE(loc_cFrx)
558:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado: " + ;
559:                     loc_cFrx, "Erro")
560:             THIS.ChamarGravar()
561:             RETURN
562:         ENDIF
563: 
564:         loc_cSavedPoint    = SET("POINT")
565:         loc_cSavedSep      = SET("SEPARATOR")
566:         loc_nSavedBehavior = _REPORTBEHAVIOR
567: 
568:         SET POINT TO "."
569:         SET SEPARATOR TO ","
570:         _REPORTBEHAVIOR = 80
571: 
572:         TRY
573:             IF UPPER(ALLTRIM(par_cModo)) = "PRINT"
574:                 REPORT FORM (loc_cFrx) TO PRINTER PROMPT NOCONSOLE
575:             ELSE
576:                 REPORT FORM (loc_cFrx) PREVIEW NOCONSOLE
577:             ENDIF
578:         CATCH TO loc_oErro
579:             MsgErro("Erro ao exibir relat" + CHR(243) + "rio: " + loc_oErro.Message, "Erro")
580:         ENDTRY
581: 
582:         SET POINT TO (loc_cSavedPoint)
583:         SET SEPARATOR TO (loc_cSavedSep)
584:         _REPORTBEHAVIOR = loc_nSavedBehavior
585: 
586:         THIS.ChamarGravar()
587:     ENDPROC
588: 
589:     *==========================================================================
590:     PROTECTED PROCEDURE ConfigurarPaginaLista()
591:     *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe PageFrame,
592:     *-- NAO existe grid de lista e NAO existe fluxo Page1=Lista/Page2=Dados.
593:     *-- Layout SCX legado (SigPrIct.SCX): cntSombra + Get_DataI/F + btnReport +
594:     *-- cntBotoes flutuante. Toda a estrutura visual e criada em ConfigurarCampos,
595:     *-- ConfigurarBotoes e ConfigurarPosProcessamento, chamados em InicializarForm.
596:     *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase; nao
597:     *-- ha nada a configurar em uma "Page Lista" que nao existe neste form.
598:     *==========================================================================
599:         RETURN
600:     ENDPROC
601: 
602:     *==========================================================================
603:     PROTECTED PROCEDURE ConfigurarPaginaDados()
604:     *-- Form OPERACIONAL flat (Width=800 x Height=192): NAO existe Page2 de dados.
605:     *-- O SCX legado (SIGPRICT) nao tem PageFrame de conteudo; todos os campos
606:     *-- (Get_DataI, Get_DataF, labels de periodo) e botoes sao filhos diretos
607:     *-- do form. Toda a estrutura foi criada em ConfigurarCampos(), ConfigurarBotoes()
608:     *-- e ConfigurarPosProcessamento(), chamados em InicializarForm().
609:     *-- Metodo mantido apenas para satisfazer contrato do pipeline multi-fase.
610:     *==========================================================================
611:         RETURN
612:     ENDPROC
613: 
614:     *==========================================================================
615:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
616:     *-- Form OPERACIONAL flat: NAO possui PageFrame nem multiplas pages para
617:     *-- alternar. A alternancia de UI se da via visibility toggle no container
618:     *-- cnt_4c_PosProc (metodos ChamarProcessar/ChamarGravar controlam Visible).
619:     *-- Assinatura preservada para satisfazer contrato do pipeline multi-fase.
620:     *==========================================================================
621:         LOCAL loc_nIgnorado
622:         loc_nIgnorado = par_nPagina
623:         RETURN
624:     ENDPROC
625: 
626:     *==========================================================================
627:     PROTECTED PROCEDURE TornarControlesVisiveis()
628:     *-- Torna visiveis todos os controles exceto containers/labels flutuantes:
629:     *-- cnt_4c_PosProc (visivel apenas apos processamento com inconsistencias)
630:     *-- lbl_4c_Label4 (oculto por design como no legado, Visible=.F.)
631:     *==========================================================================
632:         LOCAL loc_i, loc_oCtrl
633:         FOR loc_i = 1 TO THIS.ControlCount
634:             loc_oCtrl = THIS.Controls(loc_i)
635:             IF VARTYPE(loc_oCtrl) = "O"
636:                 IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_POSPROC", "LBL_4C_LABEL4")
637:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
638:                         THIS.TornarFilhosVisiveis(loc_oCtrl)
639:                     ENDIF
640:                     LOOP
641:                 ENDIF
642:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
643:                     loc_oCtrl.Visible = .T.
644:                 ENDIF
645:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
646:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
647:                 ENDIF
648:             ENDIF
649:         ENDFOR
650:     ENDPROC
651: 
652:     *==========================================================================
653:     PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
654:     *==========================================================================
655:         LOCAL loc_i, loc_oCtrl
656:         FOR loc_i = 1 TO par_oContainer.ControlCount
657:             loc_oCtrl = par_oContainer.Controls(loc_i)
658:             IF VARTYPE(loc_oCtrl) = "O"
659:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
660:                     loc_oCtrl.Visible = .T.
661:                 ENDIF
662:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
663:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
664:                 ENDIF
665:             ENDIF
666:         ENDFOR
667:     ENDPROC
668: 
669:     *==========================================================================
670:     PROCEDURE BtnIncluirClick()
671:     *-- Form OPERACIONAL flat: NAO possui fluxo de inclusao de registro.
672:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
673:     *==========================================================================
674:         RETURN
675:     ENDPROC
676: 
677:     *==========================================================================
678:     PROCEDURE BtnAlterarClick()
679:     *-- Form OPERACIONAL flat: NAO possui fluxo de alteracao de registro.
680:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
681:     *==========================================================================
682:         RETURN
683:     ENDPROC
684: 
685:     *==========================================================================
686:     PROCEDURE BtnVisualizarClick()
687:     *-- Form OPERACIONAL flat: a acao de visualizacao e CmdVisualizarClick()
688:     *-- (relatorio de inconsistencias pos-processamento). Stub mantido para
689:     *-- satisfazer contrato do pipeline multi-fase.
690:     *==========================================================================
691:         RETURN
692:     ENDPROC
693: 
694:     *==========================================================================
695:     PROCEDURE BtnExcluirClick()
696:     *-- Form OPERACIONAL flat: NAO possui fluxo de exclusao de registro.
697:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
698:     *==========================================================================
699:         RETURN
700:     ENDPROC
701: 
702:     *==========================================================================
703:     PROCEDURE BtnBuscarClick()
704:     *-- Form OPERACIONAL flat: NAO possui fluxo de busca de registro.
705:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
706:     *==========================================================================
707:         RETURN
708:     ENDPROC
709: 
710:     *==========================================================================
711:     PROCEDURE BtnEncerrarClick()
712:     *==========================================================================
713:         THIS.Release()
714:     ENDPROC
715: 
716:     *==========================================================================
717:     PROCEDURE BtnSalvarClick()
718:     *-- Form OPERACIONAL flat: NAO possui fluxo de gravacao CRUD.
719:     *-- Salvamento efetivo se da via ChamarGravar() apos processamento.
720:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
721:     *==========================================================================
722:         RETURN
723:     ENDPROC
724: 
725:     *==========================================================================
726:     PROCEDURE BtnCancelarClick()
727:     *-- Form OPERACIONAL flat: NAO possui fluxo de cancelamento CRUD.
728:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
729:     *==========================================================================
730:         RETURN
731:     ENDPROC
732: 
733:     *==========================================================================
734:     PROTECTED PROCEDURE FormParaBO()
735:     *-- Transfere os campos de data informados pelo usuario para o BO.
736:     *==========================================================================
737:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
738:             THIS.this_oBusinessObject.this_dDataI = THIS.txt_4c_DataI.Value
739:             THIS.this_oBusinessObject.this_dDataF = THIS.txt_4c_DataF.Value
740:         ENDIF
741:     ENDPROC
742: 
743:     *==========================================================================
744:     PROTECTED PROCEDURE BOParaForm()
745:     *-- Restaura os campos de data a partir do estado do BO.
746:     *==========================================================================
747:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
748:             RETURN
749:         ENDIF
750:         IF !EMPTY(THIS.this_oBusinessObject.this_dDataI)
751:             THIS.txt_4c_DataI.Value = THIS.this_oBusinessObject.this_dDataI
752:         ENDIF
753:         IF !EMPTY(THIS.this_oBusinessObject.this_dDataF)
754:             THIS.txt_4c_DataF.Value = THIS.this_oBusinessObject.this_dDataF
755:         ENDIF
756:     ENDPROC
757: 
758:     *==========================================================================
759:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
760:     *-- Habilita ou desabilita os campos de entrada e o botao Processar.
761:     *==========================================================================
762:         IF PEMSTATUS(THIS, "txt_4c_DataI", 5)
763:             THIS.txt_4c_DataI.Enabled = par_lHabilitar
764:         ENDIF
765:         IF PEMSTATUS(THIS, "txt_4c_DataF", 5)
766:             THIS.txt_4c_DataF.Enabled = par_lHabilitar
767:         ENDIF
768:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
769:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
770:         ENDIF
771:     ENDPROC
772: 
773:     *==========================================================================
774:     PROTECTED PROCEDURE LimparCampos()
775:     *-- Redefine os campos de data para a data corrente (estado inicial).
776:     *==========================================================================
777:         THIS.txt_4c_DataI.Value = DATE()
778:         THIS.txt_4c_DataF.Value = DATE()
779:     ENDPROC
780: 
781:     *==========================================================================
782:     PROCEDURE CarregarLista()
783:     *-- Form OPERACIONAL flat: NAO possui grade de registros para carregar.
784:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
785:     *==========================================================================
786:         RETURN .T.
787:     ENDPROC
788: 
789:     *==========================================================================
790:     PROTECTED PROCEDURE AjustarBotoesPorModo()
791:     *-- Form OPERACIONAL flat: NAO possui modos INCLUIR/ALTERAR/VISUALIZAR.
792:     *-- O estado dos botoes e controlado diretamente em ChamarProcessar/Gravar.
793:     *-- Metodo mantido para satisfazer contrato do pipeline multi-fase.
794:     *==========================================================================
795:         RETURN
796:     ENDPROC
797: 
798: ENDDEFINE

