# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRIMP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (792 linhas total):

*-- Linhas 29 a 123:
29:     *==========================================================================
30:     * Init - Cria BO e inicializa form via FormBase
31:     *==========================================================================
32:     PROCEDURE Init()
33:         THIS.this_oBusinessObject = CREATEOBJECT("SIGPRIMPBO")
34:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
35:             MsgErro("Erro ao criar SIGPRIMPBO.", ;
36:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
37:             RETURN .F.
38:         ENDIF
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *==========================================================================
43:     * InicializarForm - Configura controles e carrega dados iniciais
44:     *==========================================================================
45:     PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso, loc_oErro
47:         loc_lSucesso = .F.
48: 
49:         THIS.Caption = "Importa" + CHR(231) + CHR(227) + "o de dados"
50: 
51:         TRY
52:             THIS.ConfigurarPageFrame()
53:             THIS.ConfigurarCabecalho()
54:             THIS.ConfigurarBotoes()
55:             THIS.ConfigurarCampos()
56:             THIS.TornarControlesVisiveis()
57:             THIS.CarregarArquivos()
58:             loc_lSucesso = .T.
59:         CATCH TO loc_oErro
60:             THIS.this_cMensagemErro = loc_oErro.Message
61:             MsgErro(loc_oErro.Message + " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
62:                     " | Proc: " + loc_oErro.Procedure, "Erro ao inicializar form")
63:         ENDTRY
64: 
65:         RETURN loc_lSucesso
66:     ENDPROC
67: 
68:     *==========================================================================
69:     * ConfigurarPageFrame - Define imagem de fundo do form
70:     * OPERACIONAL flat: sem PageFrame; metodo existe por compatibilidade com pipeline
71:     *==========================================================================
72:     PROTECTED PROCEDURE ConfigurarPageFrame()
73:         LOCAL loc_cImg
74:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
75:         IF FILE(loc_cImg)
76:             THIS.Picture = loc_cImg
77:         ENDIF
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * ConfigurarCabecalho - Container escuro com titulo (equivalente ao cntSombra)
82:     *==========================================================================
83:     PROTECTED PROCEDURE ConfigurarCabecalho()
84:         LOCAL loc_cCaption
85:         loc_cCaption = "Importa" + CHR(231) + CHR(227) + "o de dados"
86: 
87:         THIS.AddObject("cnt_4c_Sombra", "Container")
88:         WITH THIS.cnt_4c_Sombra
89:             .Top         = 0
90:             .Left        = 0
91:             .Width       = 1100
92:             .Height      = 80
93:             .BorderWidth = 0
94:             .BackStyle   = 1
95:             .BackColor   = RGB(100, 100, 100)
96: 
97:             .AddObject("lbl_4c_LblSombra", "Label")
98:             WITH .lbl_4c_LblSombra
99:                 .AutoSize      = .F.
100:                 .FontBold      = .T.
101:                 .FontName      = "Tahoma"
102:                 .FontSize      = 18
103:                 .FontUnderline = .F.
104:                 .WordWrap      = .T.
105:                 .Alignment     = 0
106:                 .BackStyle     = 0
107:                 .ForeColor     = RGB(0, 0, 0)
108:                 .Caption       = loc_cCaption
109:                 .Height        = 40
110:                 .Left          = 10
111:                 .Top           = 18
112:                 .Width         = THIS.Width
113:             ENDWITH
114: 
115:             .AddObject("lbl_4c_LblTitulo", "Label")
116:             WITH .lbl_4c_LblTitulo
117:                 .AutoSize      = .F.
118:                 .FontBold      = .T.
119:                 .FontName      = "Tahoma"
120:                 .FontSize      = 18
121:                 .FontUnderline = .F.
122:                 .WordWrap      = .T.
123:                 .Alignment     = 0

*-- Linhas 135 a 178:
135:     *==========================================================================
136:     * ConfigurarBotoes - Botoes de acao posicionados no topo do form
137:     *==========================================================================
138:     PROTECTED PROCEDURE ConfigurarBotoes()
139:         *-- Botao Movimentacao de Estoque (btnMovEst: Left=700, PicturePosition=7)
140:         THIS.AddObject("cmd_4c_BtnMovEst", "CommandButton")
141:         WITH THIS.cmd_4c_BtnMovEst
142:             .Top             = 3
143:             .Left            = 700
144:             .Width           = 75
145:             .Height          = 75
146:             .Caption         = "Moviment. de Estoque"
147:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
148:             .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
149:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
150:             .PicturePosition = 7
151:             .FontName        = "Tahoma"
152:             .FontBold        = .T.
153:             .FontItalic      = .T.
154:             .FontSize        = 8
155:             .ForeColor       = RGB(90, 90, 90)
156:             .BackColor       = RGB(255, 255, 255)
157:             .Themes          = .T.
158:             .SpecialEffect   = 0
159:             .MousePointer    = 15
160:             .WordWrap        = .T.
161:             .AutoSize        = .F.
162:         ENDWITH
163: 
164:         *-- Botao Visualizar (oculto: legado ocultava no Init: Visible=.F.)
165:         THIS.AddObject("cmd_4c_Visualizar", "CommandButton")
166:         WITH THIS.cmd_4c_Visualizar
167:             .Top             = 3
168:             .Left            = 775
169:             .Width           = 75
170:             .Height          = 75
171:             .Caption         = "V" + CHR(237) + "deo"
172:             .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
173:             .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
174:             .PicturePosition = 13
175:             .FontName        = "Tahoma"
176:             .FontBold        = .T.
177:             .FontItalic      = .T.
178:             .FontSize        = 8

*-- Linhas 234 a 286:
234:             .AutoSize        = .F.
235:         ENDWITH
236: 
237:         BINDEVENT(THIS.cmd_4c_BtnMovEst,  "Click", THIS, "BtnMovEstClick")
238:         BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
239:         BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
240:         BINDEVENT(THIS.cmd_4c_Cancela,    "Click", THIS, "BtnCancelaClick")
241:     ENDPROC
242: 
243:     *==========================================================================
244:     * ConfigurarCampos - Label, TextBox de arquivo e ListBox de arquivos TXT
245:     *==========================================================================
246:     PROTECTED PROCEDURE ConfigurarCampos()
247:         *-- Label "Arquivos Importacao :" (Say4 do legado)
248:         THIS.AddObject("lbl_4c_Label4", "Label")
249:         WITH THIS.lbl_4c_Label4
250:             .AutoSize  = .F.
251:             .FontBold  = .T.
252:             .FontName  = "Tahoma"
253:             .FontSize  = 8
254:             .BackStyle = 0
255:             .Caption   = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"
256:             .Height    = 17
257:             .Left      = 310
258:             .Top       = 111
259:             .Width     = 130
260:             .ForeColor = RGB(90, 90, 90)
261:         ENDWITH
262: 
263:         *-- TextBox Get_Arquivo: somente leitura (When=.F. no legado)
264:         THIS.AddObject("txt_4c_Arquivo", "TextBox")
265:         WITH THIS.txt_4c_Arquivo
266:             .FontName      = "Tahoma"
267:             .FontSize      = 8
268:             .Value         = ""
269:             .Height        = 21
270:             .Left          = 440
271:             .Top           = 108
272:             .Width         = 250
273:             .ReadOnly      = .T.
274:             .TabStop       = .F.
275:             .SpecialEffect = 1
276:             .BorderColor   = RGB(100, 100, 100)
277:             .ForeColor     = RGB(90, 90, 90)
278:         ENDWITH
279: 
280:         *-- ListBox Arquivos: exibe TXT do diretorio de importacao
281:         THIS.AddObject("obj_4c_Arquivos", "ListBox")
282:         WITH THIS.obj_4c_Arquivos
283:             .FontName      = "Tahoma"
284:             .FontSize      = 8
285:             .Height        = 169
286:             .Left          = 402

*-- Linhas 320 a 430:
320:             .BorderColor = RGB(136, 189, 188)
321:         ENDWITH
322: 
323:         BINDEVENT(THIS.obj_4c_Arquivos, "InteractiveChange", THIS, "ArquivosInteractiveChange")
324:     ENDPROC
325: 
326:     *==========================================================================
327:     * CarregarArquivos - Carrega parametros do SigCdPam e lista arquivos TXT
328:     *==========================================================================
329:     PROCEDURE CarregarArquivos()
330:         LOCAL loc_lSucesso, loc_oErro
331:         loc_lSucesso = .F.
332: 
333:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
334:             RETURN .T.
335:         ENDIF
336: 
337:         TRY
338:             IF THIS.this_oBusinessObject.CarregarParametros()
339:                 *-- Pre-preencher textbox com diretorio de importacao (comportamento do Init legado)
340:                 IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
341:                     THIS.txt_4c_Arquivo.Value = ;
342:                         ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
343:                 ENDIF
344: 
345:                 IF THIS.this_oBusinessObject.BuscarArquivos()
346:                     *-- Vincular listbox ao cursor de arquivos
347:                     IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
348:                         WITH THIS.obj_4c_Arquivos
349:                             .RowSourceType = 6
350:                             .RowSource     = "cursor_4c_Arquivos.cArquivo"
351:                             .Refresh()
352:                         ENDWITH
353:                     ENDIF
354:                     loc_lSucesso = .T.
355:                 ENDIF
356:             ENDIF
357:         CATCH TO loc_oErro
358:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
359:                     "Erro CarregarArquivos")
360:         ENDTRY
361: 
362:         RETURN loc_lSucesso
363:     ENDPROC
364: 
365:     *==========================================================================
366:     * ArquivosInteractiveChange - Exibe arquivo selecionado no textbox
367:     *==========================================================================
368:     PROCEDURE ArquivosInteractiveChange()
369:         IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
370:             THIS.txt_4c_Arquivo.Value = ;
371:                 ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
372:                 ALLTRIM(THIS.obj_4c_Arquivos.Value)
373:             THIS.txt_4c_Arquivo.Refresh()
374:         ENDIF
375:     ENDPROC
376: 
377:     *==========================================================================
378:     * BtnMovEstClick - Processa todos os arquivos TXT do diretorio de importacao
379:     * Para cada arquivo: chama ProcessarArquivo() no BO; se sucesso, move para OK\
380:     * Equivalente ao btnMovEst.Click do legado
381:     *==========================================================================
382:     PROCEDURE BtnMovEstClick()
383:         LOCAL loc_cDirImports, loc_cDirOk, loc_cArquivo, loc_cArquivoFull
384:         LOCAL loc_nProcessados, loc_nErros, loc_oErro
385: 
386:         *-- Verificar disponibilidade de arquivos
387:         THIS.this_oBusinessObject.BuscarArquivos()
388: 
389:         IF !USED("cursor_4c_Arquivos") OR RECCOUNT("cursor_4c_Arquivos") = 0
390:             MsgAviso("Nenhum arquivo para importar.", "Aviso")
391:             RETURN
392:         ENDIF
393: 
394:         loc_nProcessados = 0
395:         loc_nErros       = 0
396:         loc_cDirImports  = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports))
397:         loc_cDirOk       = loc_cDirImports + "OK\"
398: 
399:         TRY
400:             *-- Garantir existencia do subdiretorio OK\
401:             IF !DIRECTORY(loc_cDirOk)
402:                 MKDIR (loc_cDirOk)
403:             ENDIF
404: 
405:             *-- Desabilitar botoes durante processamento
406:             THIS.cmd_4c_BtnMovEst.Enabled = .F.
407:             THIS.cmd_4c_Cancela.Enabled   = .F.
408:             THIS.Refresh()
409: 
410:             SELECT cursor_4c_Arquivos
411:             GO TOP
412:             SCAN
413:                 loc_cArquivo     = ALLTRIM(cursor_4c_Arquivos.cArquivo)
414:                 loc_cArquivoFull = loc_cDirImports + loc_cArquivo
415: 
416:                 *-- Atualizar display do arquivo em processamento
417:                 IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
418:                     THIS.txt_4c_Arquivo.Value = loc_cArquivoFull
419:                     THIS.txt_4c_Arquivo.Refresh()
420:                 ENDIF
421: 
422:                 *-- Processar via BO
423:                 IF THIS.this_oBusinessObject.ProcessarArquivo(loc_cArquivoFull)
424:                     loc_nProcessados = loc_nProcessados + 1
425:                     *-- Mover arquivo processado para OK\
426:                     IF FILE(loc_cArquivoFull)
427:                         SET SAFETY OFF
428:                         COPY FILE (loc_cArquivoFull) TO (loc_cDirOk + loc_cArquivo)
429:                         IF FILE(loc_cDirOk + loc_cArquivo)
430:                             DELETE FILE (loc_cArquivoFull)

*-- Linhas 440 a 792:
440: 
441:         CATCH TO loc_oErro
442:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
443:                     " PROC=" + loc_oErro.Procedure, "Erro BtnMovEstClick")
444:         ENDTRY
445: 
446:         *-- Reabilitar botoes
447:         IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
448:             THIS.cmd_4c_BtnMovEst.Enabled = .T.
449:         ENDIF
450:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
451:             THIS.cmd_4c_Cancela.Enabled = .T.
452:         ENDIF
453: 
454:         *-- Limpar display e recarregar lista apos processamento
455:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
456:             THIS.txt_4c_Arquivo.Value = ;
457:                 ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
458:         ENDIF
459:         THIS.CarregarArquivos()
460:         THIS.Refresh()
461: 
462:         *-- Exibir resultado geral se mais de um arquivo foi processado
463:         IF loc_nProcessados + loc_nErros > 1
464:             MsgInfo("Processamento conclu" + CHR(237) + "do. " + ;
465:                     "Sucesso: " + TRANSFORM(loc_nProcessados) + ;
466:                     " | Erros: " + TRANSFORM(loc_nErros), ;
467:                     "Importa" + CHR(231) + CHR(227) + "o de Dados")
468:         ENDIF
469:     ENDPROC
470: 
471:     *==========================================================================
472:     * BtnVisualizarClick - Abre o arquivo TXT selecionado no Bloco de Notas
473:     * Botao permanece oculto (legado: Visualizar.Visible = .F. no Init)
474:     *==========================================================================
475:     PROCEDURE BtnVisualizarClick()
476:         LOCAL loc_cArquivo, loc_cCmd, loc_oErro
477:         loc_cArquivo = ALLTRIM(THIS.txt_4c_Arquivo.Value)
478:         IF EMPTY(loc_cArquivo)
479:             MsgAviso("Selecione um arquivo na lista antes de visualizar.", ;
480:                      "Visualizar arquivo")
481:             RETURN
482:         ENDIF
483:         IF !FILE(loc_cArquivo)
484:             MsgAviso("Arquivo '" + loc_cArquivo + "' n" + CHR(227) + "o encontrado.", ;
485:                      "Visualizar arquivo")
486:             RETURN
487:         ENDIF
488:         TRY
489:             loc_cCmd = "notepad.exe " + CHR(34) + loc_cArquivo + CHR(34)
490:             RUN /N &loc_cCmd.
491:         CATCH TO loc_oErro
492:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
493:                     "Erro ao abrir arquivo")
494:         ENDTRY
495:     ENDPROC
496: 
497:     *==========================================================================
498:     * BtnImprimirClick - Processa importacao (equivalente a Processar('I') do legado)
499:     * Botao permanece oculto (legado: Imprimir.Visible = .F. no Init)
500:     * O legado chamava ThisForm.Processar('I') que executava a mesma logica de
501:     * importacao que btnMovEst.Click
502:     *==========================================================================
503:     PROCEDURE BtnImprimirClick()
504:         THIS.BtnMovEstClick()
505:     ENDPROC
506: 
507:     *==========================================================================
508:     * BtnCancelaClick - Fecha o formulario (equivalente a Cancela.Click do legado)
509:     *==========================================================================
510:     PROCEDURE BtnCancelaClick()
511:         THIS.Release()
512:     ENDPROC
513: 
514:     *==========================================================================
515:     * BtnIncluirClick - Adaptacao para form OPERACIONAL de importacao
516:     * No contexto de importacao de dados, "Incluir" corresponde a processar
517:     * os arquivos disponiveis no diretorio (mesma acao do btnMovEst do legado)
518:     *==========================================================================
519:     PROCEDURE BtnIncluirClick()
520:         LOCAL loc_lConfirma
521:         loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
522:                                     CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
523:                                     "Importa" + CHR(231) + CHR(227) + "o de Dados")
524:         IF loc_lConfirma
525:             THIS.BtnMovEstClick()
526:         ENDIF
527:     ENDPROC
528: 
529:     *==========================================================================
530:     * BtnAlterarClick - Adaptacao para form OPERACIONAL de importacao
531:     * No contexto de importacao de dados, "Alterar" corresponde a recarregar a
532:     * lista de arquivos disponiveis (equivalente a atualizar o cursor Arquivos)
533:     *==========================================================================
534:     PROCEDURE BtnAlterarClick()
535:         LOCAL loc_nRegistros
536:         THIS.CarregarArquivos()
537:         loc_nRegistros = IIF(USED("cursor_4c_Arquivos"), ;
538:                              RECCOUNT("cursor_4c_Arquivos"), 0)
539:         IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
540:             THIS.obj_4c_Arquivos.Refresh()
541:         ENDIF
542:         MsgInfo("Lista atualizada. Arquivos dispon" + CHR(237) + "veis: " + ;
543:                 TRANSFORM(loc_nRegistros), ;
544:                 "Importa" + CHR(231) + CHR(227) + "o de Dados")
545:     ENDPROC
546: 
547:     *==========================================================================
548:     * BtnExcluirClick - Adaptacao para form OPERACIONAL de importacao
549:     * No contexto de importacao de dados, "Excluir" corresponde a remover
550:     * fisicamente o arquivo TXT selecionado do diretorio de importacao
551:     *==========================================================================
552:     PROCEDURE BtnExcluirClick()
553:         LOCAL loc_cArquivo, loc_cValor, loc_lConfirma, loc_oErro
554:         IF !PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
555:             RETURN
556:         ENDIF
557:         loc_cValor = ""
558:         IF VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
559:             loc_cValor = ALLTRIM(THIS.obj_4c_Arquivos.Value)
560:         ENDIF
561:         IF EMPTY(loc_cValor)
562:             MsgAviso("Selecione um arquivo na lista antes de excluir.", ;
563:                      "Excluir arquivo")
564:             RETURN
565:         ENDIF
566:         loc_cArquivo = ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + ;
567:                        loc_cValor
568:         IF !FILE(loc_cArquivo)
569:             MsgAviso("Arquivo '" + loc_cValor + "' n" + CHR(227) + "o encontrado.", ;
570:                      "Excluir arquivo")
571:             RETURN
572:         ENDIF
573:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do arquivo '" + ;
574:                                     loc_cValor + "'?", ;
575:                                     "Excluir arquivo")
576:         IF !loc_lConfirma
577:             RETURN
578:         ENDIF
579:         TRY
580:             SET SAFETY OFF
581:             DELETE FILE (loc_cArquivo)
582:             SET SAFETY ON
583:             IF FILE(loc_cArquivo)
584:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o arquivo.", ;
585:                         "Excluir arquivo")
586:             ELSE
587:                 MsgInfo("Arquivo exclu" + CHR(237) + "do com sucesso.", ;
588:                         "Excluir arquivo")
589:                 THIS.txt_4c_Arquivo.Value = ;
590:                     ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
591:                 THIS.CarregarArquivos()
592:                 THIS.Refresh()
593:             ENDIF
594:         CATCH TO loc_oErro
595:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
596:                     "Erro ao excluir arquivo")
597:         ENDTRY
598:     ENDPROC
599: 
600:     *==========================================================================
601:     * TornarControlesVisiveis - Torna controles do form visiveis
602:     * cmd_4c_Visualizar e cmd_4c_Imprimir ficam ocultos (legado: Visible=.F. no Init)
603:     *==========================================================================
604:     PROCEDURE TornarControlesVisiveis()
605:         LOCAL loc_nI, loc_oObjeto, loc_nJ, loc_oFilho
606:         FOR loc_nI = 1 TO THIS.ControlCount
607:             loc_oObjeto = THIS.Controls(loc_nI)
608:             IF VARTYPE(loc_oObjeto) != "O"
609:                 LOOP
610:             ENDIF
611:             *-- Manter Visualizar e Imprimir permanentemente ocultos
612:             IF INLIST(loc_oObjeto.Name, "cmd_4c_Visualizar", "cmd_4c_Imprimir")
613:                 *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
614:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
615:                     THIS.TornarControlesVisiveis(loc_oControl)
616:                 ENDIF
617:                 LOOP
618:             ENDIF
619:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
620:                 loc_oObjeto.Visible = .T.
621:             ENDIF
622:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND ;
623:                loc_oObjeto.ControlCount > 0
624:                 FOR loc_nJ = 1 TO loc_oObjeto.ControlCount
625:                     loc_oFilho = loc_oObjeto.Controls(loc_nJ)
626:                     IF VARTYPE(loc_oFilho) = "O" AND ;
627:                        PEMSTATUS(loc_oFilho, "Visible", 5)
628:                         loc_oFilho.Visible = .T.
629:                     ENDIF
630:                 ENDFOR
631:             ENDIF
632:         ENDFOR
633:     ENDPROC
634: 
635:     *==========================================================================
636:     * ConfigurarPaginaLista / ConfigurarPaginaDados / AlternarPagina
637:     * Stubs de compatibilidade com pipeline multi-fase (OPERACIONAL sem paginas)
638:     *==========================================================================
639:     PROTECTED PROCEDURE ConfigurarPaginaLista()
640:         RETURN
641:     ENDPROC
642: 
643:     PROTECTED PROCEDURE ConfigurarPaginaDados()
644:         RETURN
645:     ENDPROC
646: 
647:     PROCEDURE AlternarPagina(par_nPagina)
648:         RETURN
649:     ENDPROC
650: 
651:     *==========================================================================
652:     * BtnBuscarClick - Atualiza lista de arquivos TXT do diretorio de importacao
653:     *==========================================================================
654:     PROCEDURE BtnBuscarClick()
655:         THIS.CarregarLista()
656:         THIS.AjustarBotoesPorModo()
657:     ENDPROC
658: 
659:     *==========================================================================
660:     * BtnEncerrarClick - Encerra o formulario
661:     *==========================================================================
662:     PROCEDURE BtnEncerrarClick()
663:         THIS.Release()
664:     ENDPROC
665: 
666:     *==========================================================================
667:     * BtnSalvarClick - Para form OPERACIONAL de importacao, salvar = processar
668:     * Confirmacao exigida antes de disparar o processamento
669:     *==========================================================================
670:     PROCEDURE BtnSalvarClick()
671:         LOCAL loc_lConfirma
672:         loc_lConfirma = MsgConfirma("Deseja processar os arquivos de importa" + ;
673:                                     CHR(231) + CHR(227) + "o dispon" + CHR(237) + "veis?", ;
674:                                     "Importa" + CHR(231) + CHR(227) + "o de Dados")
675:         IF loc_lConfirma
676:             THIS.BtnMovEstClick()
677:         ENDIF
678:     ENDPROC
679: 
680:     *==========================================================================
681:     * BtnCancelarClick - Cancela/fecha o formulario
682:     *==========================================================================
683:     PROCEDURE BtnCancelarClick()
684:         THIS.Release()
685:     ENDPROC
686: 
687:     *==========================================================================
688:     * FormParaBO - Atualiza propriedades do BO com os dados selecionados no form
689:     * Para form OPERACIONAL, atualiza o arquivo selecionado na listbox
690:     *==========================================================================
691:     PROCEDURE FormParaBO()
692:         LOCAL loc_cArqSel
693:         IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5) AND ;
694:            VARTYPE(THIS.obj_4c_Arquivos.Value) = "C"
695:             loc_cArqSel = ALLTRIM(THIS.obj_4c_Arquivos.Value)
696:             IF !EMPTY(loc_cArqSel)
697:                 THIS.this_oBusinessObject.this_cArquivoAtual = ;
698:                     ADDBS(ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)) + loc_cArqSel
699:             ENDIF
700:         ENDIF
701:     ENDPROC
702: 
703:     *==========================================================================
704:     * BOParaForm - Carrega dados do BO nos controles do form
705:     * Para form OPERACIONAL, exibe o diretorio de importacao no textbox
706:     *==========================================================================
707:     PROCEDURE BOParaForm()
708:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
709:             THIS.txt_4c_Arquivo.Value = ;
710:                 ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
711:             THIS.txt_4c_Arquivo.Refresh()
712:         ENDIF
713:     ENDPROC
714: 
715:     *==========================================================================
716:     * HabilitarCampos - Habilita ou desabilita controles interativos
717:     * par_lHabilitar: .T. para habilitar, .F. para desabilitar
718:     *==========================================================================
719:     PROCEDURE HabilitarCampos(par_lHabilitar)
720:         IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
721:             THIS.cmd_4c_BtnMovEst.Enabled = par_lHabilitar
722:         ENDIF
723:         IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
724:             THIS.obj_4c_Arquivos.Enabled  = par_lHabilitar
725:         ENDIF
726:     ENDPROC
727: 
728:     *==========================================================================
729:     * LimparCampos - Reseta controles do form para estado inicial
730:     *==========================================================================
731:     PROCEDURE LimparCampos()
732:         IF PEMSTATUS(THIS, "txt_4c_Arquivo", 5)
733:             THIS.txt_4c_Arquivo.Value = ;
734:                 ALLTRIM(THIS.this_oBusinessObject.this_cDirImports)
735:             THIS.txt_4c_Arquivo.Refresh()
736:         ENDIF
737:         IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
738:             THIS.obj_4c_Arquivos.Value = ""
739:             THIS.obj_4c_Arquivos.Refresh()
740:         ENDIF
741:     ENDPROC
742: 
743:     *==========================================================================
744:     * CarregarLista - Recarrega cursor de arquivos TXT e vincula ao listbox
745:     * Retorna numero de arquivos encontrados
746:     *==========================================================================
747:     PROCEDURE CarregarLista()
748:         LOCAL loc_nRegistros
749:         loc_nRegistros = 0
750:         THIS.CarregarArquivos()
751:         IF USED("cursor_4c_Arquivos") AND PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
752:             WITH THIS.obj_4c_Arquivos
753:                 .RowSourceType = 6
754:                 .RowSource     = "cursor_4c_Arquivos.cArquivo"
755:                 .Refresh()
756:             ENDWITH
757:             loc_nRegistros = RECCOUNT("cursor_4c_Arquivos")
758:         ENDIF
759:         RETURN loc_nRegistros
760:     ENDPROC
761: 
762:     *==========================================================================
763:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme estado atual
764:     * BtnMovEst fica habilitado somente se houver arquivos na lista
765:     *==========================================================================
766:     PROCEDURE AjustarBotoesPorModo()
767:         LOCAL loc_lTemArquivos
768:         loc_lTemArquivos = USED("cursor_4c_Arquivos") AND ;
769:                            RECCOUNT("cursor_4c_Arquivos") > 0
770:         IF PEMSTATUS(THIS, "cmd_4c_BtnMovEst", 5)
771:             THIS.cmd_4c_BtnMovEst.Enabled = loc_lTemArquivos
772:         ENDIF
773:         IF PEMSTATUS(THIS, "obj_4c_Arquivos", 5)
774:             THIS.obj_4c_Arquivos.Enabled  = .T.
775:         ENDIF
776:         IF PEMSTATUS(THIS, "cmd_4c_Cancela", 5)
777:             THIS.cmd_4c_Cancela.Enabled   = .T.
778:         ENDIF
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * Destroy - Libera recursos ao fechar o formulario
783:     *==========================================================================
784:     PROCEDURE Destroy()
785:         IF USED("cursor_4c_Arquivos")
786:             USE IN cursor_4c_Arquivos
787:         ENDIF
788:         THIS.this_oBusinessObject = .NULL.
789:         DODEFAULT()
790:     ENDPROC
791: 
792: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRIMPBO.prg):
*==============================================================================
* SIGPRIMPBO.prg - Business Object para Importacao de Movimentacao de Estoque
* Herda de: BusinessBase
* Tabela principal: SigMvCab (cabecalho da movimentacao)
*==============================================================================
DEFINE CLASS SIGPRIMPBO AS BusinessBase

    *-- Configuracao (SigCdPam)
    this_cDirImports    = ""   && Diretorio de importacao dos arquivos TXT
    this_cMoedaPs       = ""   && Moeda padrao do sistema
    this_cMascNums      = ""   && Mascara de numeracao

    *-- Controle de processamento
    this_cArquivoAtual  = ""   && Caminho completo do arquivo TXT em processamento
    this_lResultadoOk   = .F.  && Resultado do ultimo processamento
    this_cMensagemErro  = ""   && Mensagem de erro do ultimo processamento

    *============================================================================
    PROCEDURE Init()
    *============================================================================
        THIS.this_cTabela       = "SigMvCab"
        THIS.this_cCampoChave   = "CidChaves"
        RETURN DODEFAULT()
    ENDPROC

    *============================================================================
    PROCEDURE ObterChavePrimaria()
    *============================================================================
        RETURN THIS.this_cArquivoAtual
    ENDPROC

    *============================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Nao aplicavel para este BO operacional
    *============================================================================
        RETURN .F.
    ENDPROC

    *============================================================================
    PROCEDURE CarregarParametros()
    *  Carrega parametros de SigCdPam: DirImports, MoedaPs, MascNums
    *============================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT MoedaPs, MascNums, DirImports FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamImp") > 0
                IF !EOF("cursor_4c_PamImp")
                    SELECT cursor_4c_PamImp
                    THIS.this_cMoedaPs    = ALLTRIM(NVL(MoedaPs, ""))
                    THIS.this_cMascNums   = ALLTRIM(NVL(MascNums, ""))
                    THIS.this_cDirImports = ALLTRIM(NVL(DirImports, ""))
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema (SigCdPam) n" + ;
                            CHR(227) + "o encontrados.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao consultar SigCdPam.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarParametros")
        ENDTRY
        IF USED("cursor_4c_PamImp")
            USE IN cursor_4c_PamImp
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE BuscarArquivos()
    *  Lista arquivos TXT em DirImports e popula cursor_4c_Arquivos
    *============================================================================
        LOCAL loc_lSucesso, loc_nArq, loc_nI, loc_cArq, loc_oErro
        LOCAL loc_aArqs(1,5)
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cDirImports)
                MsgAviso("Diret" + CHR(243) + "rio de importa" + CHR(231) + CHR(227) + ;
                         "o n" + CHR(227) + "o configurado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF USED("cursor_4c_Arquivos")
                USE IN cursor_4c_Arquivos
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Arquivos (cArquivo C(254) NULL)
            SET NULL OFF
            loc_nArq = ADIR(loc_aArqs, ALLTRIM(THIS.this_cDirImports) + "*.TXT")
            IF loc_nArq > 0
                FOR loc_nI = 1 TO loc_nArq
                    loc_cArq = ALLTRIM(loc_aArqs(loc_nI, 1))
                    INSERT INTO cursor_4c_Arquivos (cArquivo) VALUES (m.loc_cArq)
                ENDFOR
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarArquivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *============================================================================
    PROCEDURE ProcessarArquivo(par_cArquivo)
    *  Processa um arquivo TXT pipe-delimitado de movimentacao de estoque.
    *  Insere registros em SigMvCab, SigMvItn, SigMvIts e SigMvMov.
    *  Retorna .T. se importado com sucesso, .F. caso contrario.
    *============================================================================
        LOCAL loc_lSucesso, loc_lOk, loc_cMsg, loc_oErro
        loc_lSucesso = .F.
        loc_lOk      = .T.
        loc_cMsg     = ""
        THIS.this_cArquivoAtual = par_cArquivo
        THIS.this_lResultadoOk  = .F.
        THIS.this_cMensagemErro = ""

        TRY
            *-- Validar caminho sem espacos
            IF AT(" ", par_cArquivo) > 0
                MsgAviso("Arquivo '" + par_cArquivo + "' Inv" + CHR(225) + "lido! " + ;
                         "O caminho n" + CHR(227) + "o pode conter espa" + CHR(231) + "os.", ;
                         "Sele" + CHR(231) + CHR(227) + "o de Arquivo")
                THIS.this_cMensagemErro = "Caminho com espa" + CHR(231) + "os"
                loc_lSucesso = .F.
            ENDIF

            *-- Criar cursor que recebe o arquivo TXT (57 campos pipe-delimitados)
            SET NULL ON
            CREATE CURSOR crImpMvCab (;
                TPREGS C(5), EMPS C(3), DOPES C(20), OPERS C(1), CITENS C(4), ;
                CODBARRAS C(14), CPROS C(14), DPROS C(40), OBS C(250), MOEDAS C(3), ;
                MOEVS C(3), MOEVALS N(15,6), QTDS N(15,3), CUNIS C(3), PESOS N(15,3), ;
                CUNIPS C(3), FATORS N(15,3), UNITS N(15,6), TOTAS N(15,2), VALDESCS N(15,2), ;
                VALBASES N(15,2), SITRIBS C(2), TPIPIS C(1), BCIPIS N(15,2), ;
                BASEIPI2S N(15,2), BASEIPI3S N(15,2), ALIQS N(15,2), VALIPIS N(15,2), ;
                SITTRICMS C(3), BASEICMS N(15,2), BASEICM2S N(15,2), BASEICM3S N(15,2), ;
                ALIQICMS N(15,2), ICMS N(15,2), CFOPS C(10), BCICMSS N(15,2), ;
                ICMSS N(15,2), ALIQPIS N(15,2), VPIS N(15,2), ALIQCOFS N(15,2), ;
                VCOFINS N(15,2), ISS N(15,2), IRRF N(15,2), INSS N(15,2), CSSL N(15,2), ;
                ALIQIIS N(15,2), TAXAIIS N(15,2), NADIS N(3), NIADIS N(3), CODFABS C(60), ;
                ORIGMERCS C(1), GRUORIGS C(10), CONORIGS C(10), GRUDESTS C(10), ;
                CONDESTS C(10), DATAS D, VENDS C(10), CODCORS C(4), CODTAMS C(4), OBSES C(250))
            SET NULL OFF

            *-- Importar linhas do arquivo delimitadas por '|'
            SELECT crImpMvCab
            LOCAL loc_cArqMacro
            loc_cArqMacro = par_cArquivo
            APPEND FROM &loc_cArqMacro. DELIMITED WITH CHARACTER '|'
            GO TOP

            *-- Validar formato do arquivo
            IF EOF("crImpMvCab") OR crImpMvCab.TPREGS # "MVITN"
                MsgAviso("Arquivo '" + par_cArquivo + "' inv" + CHR(225) + ;
                         "lido para importa" + CHR(231) + CHR(227) + "o.", ;
                         "Importa" + CHR(231) + CHR(227) + "o cancelada")
                IF USED("crImpMvCab")
                    USE IN crImpMvCab
                ENDIF
                THIS.this_cMensagemErro = "Formato inv" + CHR(225) + "lido"
                loc_lSucesso = .F.
            ENDIF

            *-- Capturar dados de cabecalho da primeira linha
            LOCAL loc_cDopes, loc_cEmps, loc_dDatasArq, loc_cSQL
            loc_cDopes    = ALLTRIM(crImpMvCab.DOPES)
            loc_cEmps     = ALLTRIM(crImpMvCab.EMPS)
            loc_dDatasArq = crImpMvCab.DATAS

            *-- Validar operacao em SigCdOpe
            loc_cSQL = "SELECT Dopes, NDopes, Numeras, vCompensas, GrVends, Cmoes " + ;
                       "FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeImp") < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdOpe.", "Erro")
                loc_lOk = .F.
            ENDIF
            IF loc_lOk AND EOF("cursor_4c_OpeImp")
                loc_cMsg = "Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o configurada no sistema."
                loc_lOk  = .F.
            ENDIF

            LOCAL loc_nNumeras, loc_nVComp, loc_cGrVends, loc_cCmoes
            loc_nNumeras = 0
            loc_nVComp   = 0
            loc_cGrVends = ""
            loc_cCmoes   = ""
            IF loc_lOk
                SELECT cursor_4c_OpeImp
                loc_nNumeras = NVL(Numeras, 0)
                loc_nVComp   = NVL(vCompensas, 0)
                loc_cGrVends = ALLTRIM(NVL(GrVends, ""))
                loc_cCmoes   = ALLTRIM(NVL(Cmoes, ""))
            ENDIF
            IF USED("cursor_4c_OpeImp")
                USE IN cursor_4c_OpeImp
            ENDIF

            *-- Validar empresa
            IF loc_lOk
                loc_cSQL = "SELECT Cemps FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmps)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao consultar SigCdEmp.", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_EmpImp")
                    loc_cMsg = "Empresa n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_EmpImp")
                    USE IN cursor_4c_EmpImp
                ENDIF
            ENDIF

            *-- Validar conta de origem
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - origem).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de origem n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar conta de destino
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - destino).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de destino n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Validar vendedor
            IF loc_lOk
                SELECT crImpMvCab
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.VENDS))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCli - vendedor).", "Erro")
                    loc_lOk = .F.
                ENDIF
                IF loc_lOk AND EOF("cursor_4c_CliImp")
                    loc_cMsg = "Conta de vendedor n" + CHR(227) + "o cadastrada."
                    loc_lOk  = .F.
                ENDIF
                IF USED("cursor_4c_CliImp")
                    USE IN cursor_4c_CliImp
                ENDIF
            ENDIF

            *-- Processar importacao quando todas as validacoes passarem
            IF loc_lOk
                *-- Cursor de totais por moeda (para SigMvMov)
                CREATE CURSOR TmpTotal (;
                    Moeds C(3), Valtots N(12,2), Valitens N(12,2), Valdifs N(12,2), ;
                    PorcDifs N(12,4), Tipos C(1), Coefs N(6,3), Teors N(6,3), ;
                    Qtdes N(10,3), Mobras N(10,2), nSinals N(3), MoeVals N(12,5))
                INDEX ON Moeds TAG Moeds

                *-- Gerar numero da movimentacao
                LOCAL loc_nInicio, loc_cIniLet, loc_cEDN, loc_cCidChavesCab, loc_lNew
                loc_lNew    = .T.
                loc_nInicio = 0

                IF loc_nNumeras = 5
                    DO WHILE loc_nInicio = 0
                        TRY
                            loc_nInicio = fKeyGen()
                        CATCH
                            loc_nInicio = INT(RAND(0) * 999990) + 1
                        ENDTRY
                        loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                   "WHERE EmpDopNums = " + ;
                                   EscaparSQL(loc_cEmps + loc_cDopes + STR(loc_nInicio, 6))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkReg") > 0
                            IF !EOF("cursor_4c_ChkReg") AND NVL(cursor_4c_ChkReg.nExiste, 0) > 0
                                loc_nInicio = 0
                            ENDIF
                            IF USED("cursor_4c_ChkReg")
                                USE IN cursor_4c_ChkReg
                            ENDIF
                        ENDIF
                    ENDDO
                    loc_lNew = .F.
                ENDIF

                IF loc_lNew AND loc_nNumeras # 2
                    loc_nInicio = fGerUniqueKey(ALLTRIM(loc_cDopes) + loc_cEmps)
                ENDIF

                loc_cIniLet      = ALLTRIM(fGerMascara(loc_nInicio))
                loc_cEDN         = loc_cEmps + loc_cDopes + STR(loc_nInicio, 6)
                loc_cCidChavesCab = fUniqueIds()

                *-- Buscar cotacao da moeda da operacao
                LOCAL loc_nCotMov, loc_cMoeOpe
                loc_cMoeOpe = loc_cCmoes
                loc_nCotMov = 0

                IF !EMPTY(loc_cMoeOpe)
                    loc_nCotMov = fBuscarCotacao(loc_cMoeOpe, loc_dDatasArq)
                    IF !SEEK(PADR(loc_cMoeOpe, 3), "TmpTotal", "Moeds")
                        LOCAL loc_cMoeTmp, loc_nCotTmp
                        loc_cMoeTmp = loc_cMoeOpe
                        loc_nCotTmp = loc_nCotMov
                        INSERT INTO TmpTotal (Moeds, MoeVals) VALUES (m.loc_cMoeTmp, m.loc_nCotTmp)
                    ENDIF
                ENDIF

                *-- Iniciar transacao SQL Server
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                *-- INSERT SigMvCab (cabecalho da movimentacao)
                SELECT crImpMvCab
                loc_cSQL = "INSERT INTO SigMvCab (" + ;
                           "Emps, Dopes, Numes, Usuars, Datars, Datas, Transps, Mascnum, " + ;
                           "Tabds, LPrecos, CidChaves, EmpDopNums, Dgopes, vCompensas, " + ;
                           "GrupoOs, ContaOs, GrupoDs, ContaDs, GrVends, Vends, " + ;
                           "GrResps, Resps, Obses, DataTrans, Valos, ValInis) VALUES ("
                loc_cSQL = loc_cSQL + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(loc_cDopes) + ", " + ;
                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                           "GETDATE(), " + ;
                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                           "0, " + ;
                           EscaparSQL(LEFT(loc_cIniLet, 10)) + ", " + ;
                           "'', '', " + ;
                           EscaparSQL(loc_cCidChavesCab) + ", " + ;
                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                           "'', " + ;
                           FormatarNumeroSQL(loc_nVComp, 2) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONORIGS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.GRUDESTS)) + ", " + ;
                           EscaparSQL(ALLTRIM(crImpMvCab.CONDESTS)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(loc_cGrVends, 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.VENDS), 10)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBSES), 250)) + ", " + ;
                           "GETDATE(), 0, 0)"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao inserir cabe" + CHR(231) + "alho da movimenta" + ;
                            CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lOk = .F.
                ENDIF

                *-- Iterar sobre cada linha/item do arquivo
                IF loc_lOk
                    LOCAL loc_nValtot, loc_nCotItn, loc_nUnits, loc_nTotas, loc_cMoedaItn
                    loc_nValtot = 0

                    SELECT crImpMvCab
                    SCAN
                        *-- Validar produto
                        loc_cSQL = "SELECT Dpros FROM SigCdPro WHERE Cpros = " + ;
                                   EscaparSQL(ALLTRIM(crImpMvCab.CPROS))
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProImp") < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro).", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF EOF("cursor_4c_ProImp")
                            loc_cMsg = "Produto " + ALLTRIM(crImpMvCab.CPROS) + ;
                                       " n" + CHR(227) + "o cadastrado."
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            IF USED("cursor_4c_ProImp")
                                USE IN cursor_4c_ProImp
                            ENDIF
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_ProImp")
                            USE IN cursor_4c_ProImp
                        ENDIF

                        SELECT crImpMvCab

                        *-- Calcular cotacao e converter moeda do item
                        loc_cMoedaItn = ALLTRIM(NVL(crImpMvCab.MOEDAS, ""))
                        loc_nUnits    = NVL(crImpMvCab.UNITS, 0)
                        loc_nTotas    = NVL(crImpMvCab.TOTAS, 0)

                        IF !EMPTY(loc_cMoedaItn)
                            loc_nCotItn = IIF(NVL(crImpMvCab.MOEVALS, 0) # 0, ;
                                              NVL(crImpMvCab.MOEVALS, 0), ;
                                              fBuscarCotacao(loc_cMoedaItn, crImpMvCab.DATAS))
                            IF !SEEK(PADR(loc_cMoedaItn, 3), "TmpTotal", "Moeds")
                                LOCAL loc_cMoedaItm, loc_nCotItm
                                loc_cMoedaItm = loc_cMoedaItn
                                loc_nCotItm   = NVL(crImpMvCab.MOEVALS, 0)
                                INSERT INTO TmpTotal (Moeds, MoeVals) ;
                                    VALUES (m.loc_cMoedaItm, m.loc_nCotItm)
                                SELECT crImpMvCab
                            ENDIF
                        ELSE
                            loc_nCotItn = 0
                        ENDIF

                        IF !EMPTY(loc_cMoeOpe) AND loc_cMoeOpe # loc_cMoedaItn AND loc_nCotMov # 0
                            loc_nUnits    = loc_nUnits * loc_nCotItn / loc_nCotMov
                            loc_nTotas    = loc_nTotas * loc_nCotItn / loc_nCotMov
                            loc_cMoedaItn = loc_cMoeOpe
                        ENDIF

                        LOCAL loc_cCidChavesItn
                        loc_cCidChavesItn = fUniqueIds()

                        *-- INSERT SigMvItn (itens da movimentacao)
                        loc_cSQL = "INSERT INTO SigMvItn (" + ;
                                   "Emps, Dopes, Numes, EmpDopNums, Citens, CodBarras, " + ;
                                   "Cpros, Dpros, Obs, Moedas, Moevs, Moevals, Qtds, " + ;
                                   "Cunis, Pesos, Cunips, Fators, Units, Unit2s, Univals, " + ;
                                   "Totas, Valdescs, Valbases, Sitribs, Tpipis, Bcipis, " + ;
                                   "Baseipi2s, Baseipi3s, Aliqs, Valipis, Sittricms, " + ;
                                   "Baseicms, Baseicm2s, Baseicm3s, Aliqicms, Icms, Cfops, " + ;
                                   "Bcicmss, Icmss, Aliqpis, Vpis, Aliqcofs, Vcofins, " + ;
                                   "Iss, Irrf, Inss, Cssl, Aliqiis, Taxaiis, Nadis, Niadis, " + ;
                                   "Codfabs, Origmercs, CidChaves, Opers, " + ;
                                   "Datatrans, Dtalts) VALUES ("

                        loc_cSQL = loc_cSQL + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(loc_cDopes) + ", " + ;
                                   FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                   FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.DPROS), 40)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OBS), 250)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMoedaItn, 3)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.MOEVS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.MOEVALS, 0), 6) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CUNIPS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.FATORS, 0), 3) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nUnits, 6) + ", " + ;
                                   FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALDESCS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALBASES, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITRIBS), 2)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.TPIPIS), 1)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCIPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEIPI3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VALIPIS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.SITTRICMS), 3)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM2S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BASEICM3S, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQICMS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMS, 0), 2) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CFOPS), 10)) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.BCICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ICMSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VPIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQCOFS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.VCOFINS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ISS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.IRRF, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.INSS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.CSSL, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.ALIQIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.TAXAIIS, 0), 2) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NADIS, 0), 0) + ", " + ;
                                   FormatarNumeroSQL(NVL(crImpMvCab.NIADIS, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODFABS), 60)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.ORIGMERCS), 1)) + ", " + ;
                                   EscaparSQL(loc_cCidChavesItn) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(crImpMvCab.OPERS), 1)) + ", " + ;
                                   "GETDATE(), GETDATE())"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao inserir item da movimenta" + ;
                                    CHR(231) + CHR(227) + "o.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                            EXIT
                        ENDIF

                        *-- Validar e inserir grade cor/tamanho (SigMvIts) se informado
                        IF loc_lOk AND ;
                           (!EMPTY(ALLTRIM(crImpMvCab.CODCORS)) OR !EMPTY(ALLTRIM(crImpMvCab.CODTAMS)))

                            IF !EMPTY(ALLTRIM(crImpMvCab.CODCORS))
                                loc_cSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODCORS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdCor).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_CorImp")
                                    loc_cMsg = "Cor " + ALLTRIM(crImpMvCab.CODCORS) + ;
                                               " n" + CHR(227) + "o cadastrada."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_CorImp")
                                    USE IN cursor_4c_CorImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk AND !EMPTY(ALLTRIM(crImpMvCab.CODTAMS))
                                loc_cSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + ;
                                           EscaparSQL(ALLTRIM(crImpMvCab.CODTAMS))
                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamImp") < 1
                                    MsgErro("Falha na conex" + CHR(227) + "o (SigCdTam).", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF loc_lOk AND EOF("cursor_4c_TamImp")
                                    loc_cMsg = "Tamanho " + ALLTRIM(crImpMvCab.CODTAMS) + ;
                                               " n" + CHR(227) + "o cadastrado."
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                                IF USED("cursor_4c_TamImp")
                                    USE IN cursor_4c_TamImp
                                ENDIF
                                SELECT crImpMvCab
                            ENDIF

                            IF loc_lOk
                                LOCAL loc_cCidChavesIts
                                loc_cCidChavesIts = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvIts (" + ;
                                           "Citens, Emps, Dopes, Numes, Cpros, " + ;
                                           "CodEmbs, CodTams, CodCors, " + ;
                                           "Qtds, Aqtds, Qtdembs, Aqtdembs, " + ;
                                           "Qtbaixas, Prembs, CodembEnts, Qtdents, " + ;
                                           "CodBarras, Pesos, Qtbxprods, Qtprods, " + ;
                                           "Datatrans, Locals, Ntrans, Qtreservas, " + ;
                                           "CidChaves, EmpDopNums, ChkSubn, Compris, Dtalts) VALUES (" + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CITENS)), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CPROS), 14)) + ", " + ;
                                           "'', " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODTAMS), 4)) + ", " + ;
                                           EscaparSQL(LEFT(ALLTRIM(crImpMvCab.CODCORS), 4)) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.QTDS, 0), 3) + ", " + ;
                                           "0, 1, 1, 0, 0, '', 0, " + ;
                                           FormatarNumeroSQL(VAL(ALLTRIM(crImpMvCab.CODBARRAS)), 0) + ", " + ;
                                           FormatarNumeroSQL(NVL(crImpMvCab.PESOS, 0), 3) + ", " + ;
                                           "0, 0, GETDATE(), " + ;
                                           "'', 0, 0, " + ;
                                           EscaparSQL(loc_cCidChavesIts) + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           "0, 0, GETDATE())"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir grade da movimenta" + ;
                                            CHR(231) + CHR(227) + "o.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Acumular total (loc_nTotas ja esta convertido para moeda da operacao)
                        IF loc_lOk
                            loc_nValtot = loc_nValtot + loc_nTotas
                        ELSE
                            EXIT
                        ENDIF

                        SELECT crImpMvCab
                    ENDSCAN

                    *-- Atualizar total no cabecalho
                    IF loc_lOk
                        loc_cSQL = "UPDATE SigMvCab SET " + ;
                                   "Valos = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   ", ValInis = " + FormatarNumeroSQL(loc_nValtot, 2) + ;
                                   " WHERE EmpDopNums = " + EscaparSQL(LEFT(loc_cEDN, 29))
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            MsgErro("Falha ao atualizar total do cabe" + CHR(231) + "alho.", "Erro")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lOk = .F.
                        ENDIF
                    ENDIF

                    *-- Inserir registros por moeda em SigMvMov
                    IF loc_lOk
                        SELECT TmpTotal
                        SCAN
                            IF !EMPTY(ALLTRIM(TmpTotal.Moeds)) AND TmpTotal.MoeVals # 0
                                LOCAL loc_cCidChavesMov
                                loc_cCidChavesMov = fUniqueIds()

                                loc_cSQL = "INSERT INTO SigMvMov (" + ;
                                           "NSinals, Emps, Dopes, Numes, Moeds, " + ;
                                           "ValTots, ValItens, ValDifs, PorcDifs, Tipos, " + ;
                                           "Datatrans, Ntrans, Locals, Coefs, Mobras, " + ;
                                           "Qtdes, Teors, CidChaves, Dtalts, " + ;
                                           "EmpDopNums, Moevals) VALUES (" + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.nSinals, 0), 0) + ", " + ;
                                           EscaparSQL(loc_cEmps) + ", " + ;
                                           EscaparSQL(loc_cDopes) + ", " + ;
                                           FormatarNumeroSQL(loc_nInicio, 0) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Moeds)) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valtots, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valitens, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Valdifs, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.PorcDifs, 0), 4) + ", " + ;
                                           EscaparSQL(ALLTRIM(TmpTotal.Tipos)) + ", " + ;
                                           "NULL, 0, '', " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Coefs, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Mobras, 0), 2) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Qtdes, 0), 3) + ", " + ;
                                           FormatarNumeroSQL(NVL(TmpTotal.Teors, 0), 3) + ", " + ;
                                           EscaparSQL(loc_cCidChavesMov) + ", " + ;
                                           IIF(!EMPTY(loc_dDatasArq), FormatarDataSQL(loc_dDatasArq), "NULL") + ", " + ;
                                           EscaparSQL(LEFT(loc_cEDN, 29)) + ", " + ;
                                           FormatarNumeroSQL(TmpTotal.MoeVals, 5) + ")"

                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    MsgErro("Falha ao inserir movimenta" + ;
                                            CHR(231) + CHR(227) + "o de moeda.", "Erro")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lOk = .F.
                                    EXIT
                                ENDIF
                            ENDIF
                            SELECT TmpTotal
                        ENDSCAN
                    ENDIF
                ENDIF

                *-- Finalizar transacao
                IF loc_lOk
                    SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    THIS.this_lResultadoOk  = .T.
                    THIS.this_cMensagemErro = ""
                    MsgInfo("Arquivo '" + par_cArquivo + "' importado com sucesso!", ;
                            "Importa" + CHR(231) + CHR(227) + "o conclu" + CHR(237) + "da")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = loc_cMsg
                    IF !EMPTY(loc_cMsg)
                        MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                                 "Importa" + CHR(231) + CHR(227) + "o cancelada")
                    ENDIF
                ENDIF

            ELSE
                THIS.this_cMensagemErro = loc_cMsg
                IF !EMPTY(loc_cMsg)
                    MsgAviso(par_cArquivo + " - " + loc_cMsg, ;
                             "Importa" + CHR(231) + CHR(227) + "o cancelada")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ProcessarArquivo")
            THIS.this_cMensagemErro = loc_oErro.Message
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
        ENDTRY

        *-- Limpar cursores temporarios
        IF USED("crImpMvCab")
            USE IN crImpMvCab
        ENDIF
        IF USED("TmpTotal")
            USE IN TmpTotal
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

