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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICO.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (821 linhas total):

*-- Linhas 28 a 211:
28:     this_cDirTemp = ""
29: 
30:     *--------------------------------------------------------------------------
31:     PROCEDURE Init()
32:     *--------------------------------------------------------------------------
33:         RETURN DODEFAULT()
34:     ENDPROC
35: 
36:     *--------------------------------------------------------------------------
37:     PROTECTED PROCEDURE InicializarForm()
38:     *--------------------------------------------------------------------------
39:         LOCAL loc_lSucesso, loc_oErro
40:         loc_lSucesso = .F.
41:         TRY
42:             *-- Criar Business Object
43:             THIS.this_oBusinessObject = CREATEOBJECT("ICOBO")
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MsgErro("Erro ao criar ICOBO." + CHR(13) + ;
46:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
47:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
48:                 loc_lSucesso = .F.
49:             ENDIF
50: 
51:             *-- Propriedades dinamicas do form (Caption e Picture requerem CHR/FILE)
52:             THIS.Caption = "Cadastro de " + CHR(205) + "cones"
53:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
54:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
55:             ENDIF
56: 
57:             THIS.LockScreen = .T.
58: 
59:             *-- Orquestra a composicao do layout (cabecalho + area de lista + area de acoes)
60:             THIS.ConfigurarPageFrame()
61: 
62:             *-- Carregar icones do SQL Server para cursor crTmpcdico
63:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
64:                 THIS.this_cDirTemp = ADDBS(SYS(2023))
65:                 THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
66:                 IF USED("crTmpcdico")
67:                     THIS.grd_4c_Dados.ColumnCount              = 1
68:                     THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
69:                     THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
70:                     THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
71:                     THIS.grd_4c_Dados.Visible = .T.
72:                     THIS.grd_4c_Dados.Refresh()
73:                     THIS.AtualizarPreview()
74:                     THIS.grd_4c_Dados.SetFocus()
75:                 ENDIF
76:             ENDIF
77: 
78:             THIS.LockScreen = .F.
79:             loc_lSucesso = .T.
80:         CATCH TO loc_oErro
81:             THIS.LockScreen = .F.
82:             MsgErro(loc_oErro.Message + CHR(13) + ;
83:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
84:                 "Procedure: " + loc_oErro.Procedure, ;
85:                 "Erro ao Inicializar FormICO")
86:         ENDTRY
87:         RETURN loc_lSucesso
88:     ENDPROC
89: 
90:     *--------------------------------------------------------------------------
91:     PROTECTED PROCEDURE ConfigurarPageFrame()
92:     *--------------------------------------------------------------------------
93:     * OPERACIONAL flat layout - o legado SIGCDICO nao usa PageFrame; controles
94:     * (Grid1 de icones, Icone/Image de preview, Commandgroup1 de acoes) ficam
95:     * diretamente sobre o Form. Este metodo orquestra a composicao das regioes:
96:     * cabecalho cinza (cntSombra), area de listagem (Grid1 + Image), area de
97:     * acoes (CommandGroup Novo/Excluir/Fechar). Nome preservado para
98:     * compatibilidade com o pipeline de migracao multi-fase.
99:     *--------------------------------------------------------------------------
100:         THIS.ConfigurarCabecalho()
101:         THIS.ConfigurarPaginaLista()
102:         THIS.ConfigurarPaginaDados()
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     PROTECTED PROCEDURE ConfigurarCabecalho()
107:     *--------------------------------------------------------------------------
108:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH THIS.cnt_4c_Cabecalho
110:             .Top         = -1
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BorderWidth = 0
115:             .BackStyle   = 1
116:             .BackColor   = RGB(100, 100, 100)
117:             .Visible     = .T.
118:         ENDWITH
119: 
120:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
121:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
122:             .Top           = 18
123:             .Left          = 10
124:             .Width         = 769
125:             .Height        = 40
126:             .FontBold      = .T.
127:             .FontName      = "Tahoma"
128:             .FontSize      = 18
129:             .FontUnderline = .F.
130:             .WordWrap      = .T.
131:             .Alignment     = 0
132:             .BackStyle     = 0
133:             .AutoSize      = .F.
134:             .Caption       = "Cadastro de " + CHR(205) + "cones"
135:             .ForeColor     = RGB(0, 0, 0)
136:             .Visible       = .T.
137:         ENDWITH
138: 
139:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
141:             .Top       = 17
142:             .Left      = 10
143:             .Width     = 769
144:             .Height    = 46
145:             .FontBold  = .T.
146:             .FontName  = "Tahoma"
147:             .FontSize  = 18
148:             .WordWrap  = .T.
149:             .Alignment = 0
150:             .BackStyle = 0
151:             .AutoSize  = .F.
152:             .Caption   = "Cadastro de " + CHR(205) + "cones"
153:             .ForeColor = RGB(255, 255, 255)
154:             .Visible   = .T.
155:         ENDWITH
156:     ENDPROC
157: 
158:     *--------------------------------------------------------------------------
159:     PROCEDURE Destroy()
160:     *--------------------------------------------------------------------------
161:         IF USED("crTmpcdico")
162:             USE IN crTmpcdico
163:         ENDIF
164:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
165:             THIS.this_oBusinessObject = .NULL.
166:         ENDIF
167:         DODEFAULT()
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     PROTECTED PROCEDURE ConfigurarPaginaLista()
172:     *--------------------------------------------------------------------------
173:         *-- Grid de icones (grd_4c_Dados) - Grid1 do legado
174:         THIS.AddObject("grd_4c_Dados", "Grid")
175:         THIS.grd_4c_Dados.ColumnCount = 1
176:         WITH THIS.grd_4c_Dados
177:             .Top               = 85
178:             .Left              = 30
179:             .Width             = 414
180:             .Height            = 526
181:             .ReadOnly          = .T.
182:             .AllowHeaderSizing = .F.
183:             .AllowRowSizing    = .F.
184:             .DeleteMark        = .F.
185:             .RecordMark        = .F.
186:             .ScrollBars        = 2
187:             .HeaderHeight      = 15
188:             .RowHeight         = 15
189: 
190:             .FontName = "Courier New"
191:             .SetAll("FontName",    "Verdana",           "Header")
192:             .SetAll("FontName",    "Courier New",       "TextBox")
193:             .FontSize = 9
194:             .SetAll("FontSize",    8,                   "Header")
195:             .SetAll("FontSize",    9,                   "TextBox")
196:             .SetAll("Format",      "K",                 "Column")
197:             .SetAll("Format",      "K",                 "TextBox")
198:             .SetAll("Movable",     .F.,                 "Column")
199:             .SetAll("ReadOnly",    .T.,                 "Column")
200:             .SetAll("ReadOnly",    .T.,                 "TextBox")
201:             .SetAll("Resizable",   .F.,                 "Column")
202:             .SetAll("Alignment",   3,                   "Column")
203:             .SetAll("Alignment",   3,                   "TextBox")
204:             .SetAll("Alignment",   2,                   "Header")
205:             .SetAll("BorderStyle", 0,                   "TextBox")
206:             .SetAll("Margin",      0,                   "TextBox")
207:             .SetAll("Visible",     .T.,                 "TextBox")
208:             .SetAll("ForeColor",   RGB(36, 84, 155),   "Header")
209: 
210:             .Column1.Width = 383
211:         ENDWITH

*-- Linhas 297 a 414:
297:             .PicturePosition = 13
298:         ENDWITH
299: 
300:         *-- BINDEVENTs para eventos do grid (atualizar preview ao navegar)
301:         BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdDadosScrolled")
302:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange",  THIS, "GrdDadosBeforeRowColChange")
303:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",   THIS, "GrdDadosAfterRowColChange")
304: 
305:         *-- BINDEVENTs para botoes de acao
306:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnIncluirClick")
307:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnExcluirClick")
308:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
309:     ENDPROC
310: 
311:     *--------------------------------------------------------------------------
312:     PROCEDURE AlternarPagina(par_nPagina)
313:     *--------------------------------------------------------------------------
314:         RETURN
315:     ENDPROC
316: 
317:     *--------------------------------------------------------------------------
318:     PROTECTED PROCEDURE AtualizarPreview()
319:     *--------------------------------------------------------------------------
320:         LOCAL loc_cArquivo, loc_cNomeArq
321:         loc_cArquivo = ""
322:         loc_cNomeArq = ""
323:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
324:             SELECT crTmpcdico
325:             loc_cArquivo = ALLTRIM(crTmpcdico.ctmpicones)
326:             loc_cNomeArq = ALLTRIM(crTmpcdico.carqicones)
327:         ENDIF
328:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
329:             THIS.img_4c_Icone.Picture = loc_cArquivo
330:             THIS.img_4c_Icone.Visible = .T.
331:         ELSE
332:             THIS.img_4c_Icone.Visible = .F.
333:         ENDIF
334:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
335:             THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
336:         ENDIF
337:     ENDPROC
338: 
339:     *--------------------------------------------------------------------------
340:     * GrdDadosScrolled - Atualiza preview ao rolar o grid (Grid1.Scrolled do legado)
341:     *--------------------------------------------------------------------------
342:     PROCEDURE GrdDadosScrolled(par_nDirection)
343:         THIS.AtualizarPreview()
344:     ENDPROC
345: 
346:     *--------------------------------------------------------------------------
347:     * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha
348:     *--------------------------------------------------------------------------
349:     PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
350:         THIS.AtualizarPreview()
351:     ENDPROC
352: 
353:     *--------------------------------------------------------------------------
354:     * GrdDadosAfterRowColChange - Atualiza preview apos mudar linha
355:     *--------------------------------------------------------------------------
356:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
357:         THIS.AtualizarPreview()
358:     ENDPROC
359: 
360:     *--------------------------------------------------------------------------
361:     * BtnIncluirClick - Inclui novo icone via seletor de arquivo (cmdInserir.Click do legado)
362:     *--------------------------------------------------------------------------
363:     PROCEDURE BtnIncluirClick()
364:         LOCAL loc_cArqIcone, loc_oErro
365:         loc_cArqIcone = ""
366:         TRY
367:             loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")
368: 
369:             IF EMPTY(loc_cArqIcone)
370:                 RETURN
371:             ENDIF
372: 
373:             IF !FILE(loc_cArqIcone)
374:                 MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
375:                 RETURN
376:             ENDIF
377: 
378:             THIS.LockScreen = .T.
379: 
380:             LOCAL loc_cDirTmp, loc_cArqTemp, loc_cNomeArq
381:             loc_cDirTmp  = ADDBS(SYS(2023))
382:             loc_cArqTemp = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
383:             loc_cNomeArq = LOWER(JUSTFNAME(loc_cArqIcone))
384: 
385:             LOCAL loc_lExiste
386:             loc_lExiste = USED("crTmpcdico") AND SEEK(loc_cNomeArq, "crTmpcdico", "carqicones")
387: 
388:             IF !loc_lExiste
389:                 SELECT crTmpcdico
390:                 APPEND BLANK
391:             ELSE
392:                 SELECT crTmpcdico
393:             ENDIF
394: 
395:             REPLACE carqicones WITH loc_cNomeArq
396:             REPLACE marqicones WITH FILETOSTR(loc_cArqIcone)
397:             REPLACE ctmpicones WITH loc_cArqTemp
398: 
399:             LOCAL loc_nBytes
400:             loc_nBytes = STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
401: 
402:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeArq
403:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
404: 
405:             LOCAL loc_lSucesso
406:             IF !loc_lExiste
407:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
408:             ELSE
409:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
410:             ENDIF
411: 
412:             THIS.grd_4c_Dados.Refresh()
413:             SELECT crTmpcdico
414:             GO TOP

*-- Linhas 421 a 658:
421:             THIS.LockScreen = .F.
422:             MsgErro(loc_oErro.Message + CHR(13) + ;
423:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
424:                 "Procedure: " + loc_oErro.Procedure, ;
425:                 "Erro ao Incluir " + CHR(205) + "cone")
426:         ENDTRY
427:     ENDPROC
428: 
429:     *--------------------------------------------------------------------------
430:     * BtnExcluirClick - Exclui icone selecionado (cmdExcluir.Click do legado)
431:     *--------------------------------------------------------------------------
432:     PROCEDURE BtnExcluirClick()
433:         LOCAL loc_oErro
434:         TRY
435:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
436:                 RETURN
437:             ENDIF
438: 
439:             SELECT crTmpcdico
440:             LOCAL loc_cRegistro
441:             loc_cRegistro = ALLTRIM(crTmpcdico.carqicones)
442: 
443:             IF EMPTY(loc_cRegistro)
444:                 RETURN
445:             ENDIF
446: 
447:             IF !MsgConfirma("Tem certeza que deseja Excluir?", "Excluir")
448:                 RETURN
449:             ENDIF
450: 
451:             THIS.LockScreen = .T.
452: 
453:             IF THIS.this_oBusinessObject.VerificarUsoIcone(loc_cRegistro)
454:                 MsgAviso("Existem " + CHR(237) + "tens cadastrados que est" + CHR(227) + ;
455:                     "o utilizando esse Registro!", ;
456:                     "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
457:                 THIS.LockScreen = .F.
458:                 RETURN
459:             ENDIF
460: 
461:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cRegistro
462:             IF THIS.this_oBusinessObject.Excluir()
463:                 DELETE FROM crTmpcdico WHERE ALLTRIM(carqicones) = loc_cRegistro
464:                 THIS.grd_4c_Dados.Refresh()
465:                 SELECT crTmpcdico
466:                 GO TOP
467:                 LOCATE FOR carqicones > loc_cRegistro
468:                 IF EOF()
469:                     GO BOTTOM
470:                 ENDIF
471:                 THIS.AtualizarPreview()
472:                 THIS.Refresh()
473:                 THIS.grd_4c_Dados.SetFocus()
474:             ENDIF
475: 
476:             THIS.LockScreen = .F.
477:         CATCH TO loc_oErro
478:             THIS.LockScreen = .F.
479:             MsgErro(loc_oErro.Message + CHR(13) + ;
480:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
481:                 "Procedure: " + loc_oErro.Procedure, ;
482:                 "Erro ao Excluir " + CHR(205) + "cone")
483:         ENDTRY
484:     ENDPROC
485: 
486:     *--------------------------------------------------------------------------
487:     * BtnEncerrarClick - Fecha o formulario (cmdSair.Click do legado)
488:     *--------------------------------------------------------------------------
489:     PROCEDURE BtnEncerrarClick()
490:         THIS.Release()
491:     ENDPROC
492: 
493:     *--------------------------------------------------------------------------
494:     * BtnAlterarClick - Substitui o conteudo binario do icone selecionado por
495:     * um novo arquivo (mantem o carqicones/PK, atualiza marqicones/ctmpicones).
496:     * O legado nao expoe botao Alterar; a semantica adotada segue o mesmo
497:     * fluxo de Incluir quando SEEK() encontra o registro (chama Atualizar()).
498:     *--------------------------------------------------------------------------
499:     PROCEDURE BtnAlterarClick()
500:         LOCAL loc_cArqIcone, loc_oErro
501:         loc_cArqIcone = ""
502:         TRY
503:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
504:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
505:                     "cones cadastrados para alterar.", "Aviso")
506:                 RETURN
507:             ENDIF
508: 
509:             SELECT crTmpcdico
510:             LOCAL loc_cNomeAtual
511:             loc_cNomeAtual = ALLTRIM(crTmpcdico.carqicones)
512: 
513:             IF EMPTY(loc_cNomeAtual)
514:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para alterar.", "Aviso")
515:                 RETURN
516:             ENDIF
517: 
518:             loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")
519: 
520:             IF EMPTY(loc_cArqIcone)
521:                 RETURN
522:             ENDIF
523: 
524:             IF !FILE(loc_cArqIcone)
525:                 MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
526:                 RETURN
527:             ENDIF
528: 
529:             IF !MsgConfirma("Substituir o conte" + CHR(250) + "do do " + CHR(237) + ;
530:                     "cone selecionado?", "Alterar")
531:                 RETURN
532:             ENDIF
533: 
534:             THIS.LockScreen = .T.
535: 
536:             LOCAL loc_cDirTmp, loc_cArqTemp, loc_mConteudo
537:             loc_cDirTmp   = ADDBS(SYS(2023))
538:             loc_cArqTemp  = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
539:             loc_mConteudo = FILETOSTR(loc_cArqIcone)
540: 
541:             SELECT crTmpcdico
542:             REPLACE marqicones WITH loc_mConteudo
543:             REPLACE ctmpicones WITH loc_cArqTemp
544: 
545:             STRTOFILE(loc_mConteudo, loc_cArqTemp)
546: 
547:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeAtual
548:             THIS.this_oBusinessObject.this_cMarqIcones = loc_mConteudo
549: 
550:             LOCAL loc_lSucesso
551:             loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
552: 
553:             THIS.grd_4c_Dados.Refresh()
554:             SELECT crTmpcdico
555:             LOCATE FOR ALLTRIM(carqicones) == loc_cNomeAtual
556:             THIS.AtualizarPreview()
557:             THIS.Refresh()
558:             THIS.LockScreen = .F.
559:             THIS.grd_4c_Dados.SetFocus()
560:         CATCH TO loc_oErro
561:             THIS.LockScreen = .F.
562:             MsgErro(loc_oErro.Message + CHR(13) + ;
563:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
564:                 "Procedure: " + loc_oErro.Procedure, ;
565:                 "Erro ao Alterar " + CHR(205) + "cone")
566:         ENDTRY
567:     ENDPROC
568: 
569:     *--------------------------------------------------------------------------
570:     * BtnVisualizarClick - Reforca a exibicao da imagem do icone selecionado
571:     * no painel de preview (img_4c_Icone) e devolve o foco ao grid. Espelha o
572:     * comportamento de navegacao do legado (Grid1.Scrolled/AfterRowColChange)
573:     * quando invocado explicitamente pelo usuario.
574:     *--------------------------------------------------------------------------
575:     PROCEDURE BtnVisualizarClick()
576:         LOCAL loc_oErro
577:         TRY
578:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
579:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
580:                     "cones cadastrados para visualizar.", "Aviso")
581:                 RETURN
582:             ENDIF
583: 
584:             SELECT crTmpcdico
585:             LOCAL loc_cNome
586:             loc_cNome = ALLTRIM(crTmpcdico.carqicones)
587: 
588:             IF EMPTY(loc_cNome)
589:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para visualizar.", "Aviso")
590:                 RETURN
591:             ENDIF
592: 
593:             *-- Se o arquivo temporario foi removido, regenerar a partir do MEMO
594:             LOCAL loc_cArqTemp
595:             loc_cArqTemp = ALLTRIM(crTmpcdico.ctmpicones)
596:             IF EMPTY(loc_cArqTemp) OR !FILE(loc_cArqTemp)
597:                 loc_cArqTemp = ADDBS(SYS(2023)) + "ArqIcone" + SYS(2015) + ".ico"
598:                 IF !EMPTY(crTmpcdico.marqicones)
599:                     STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
600:                     REPLACE ctmpicones WITH loc_cArqTemp
601:                 ELSE
602:                     loc_cArqTemp = ""
603:                 ENDIF
604:             ENDIF
605: 
606:             THIS.AtualizarPreview()
607:             THIS.Refresh()
608:             THIS.grd_4c_Dados.SetFocus()
609:         CATCH TO loc_oErro
610:             MsgErro(loc_oErro.Message + CHR(13) + ;
611:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
612:                 "Procedure: " + loc_oErro.Procedure, ;
613:                 "Erro ao Visualizar " + CHR(205) + "cone")
614:         ENDTRY
615:     ENDPROC
616: 
617:     *--------------------------------------------------------------------------
618:     PROTECTED PROCEDURE ConfigurarPaginaDados()
619:     *--------------------------------------------------------------------------
620:     * Painel direito do form (x=456+): labels informativos acima da preview
621:     * Area entre cabecalho (bottom=79) e imagem (top=220) ~ 140px disponiveis
622:     *--------------------------------------------------------------------------
623:         *-- Instrucao: orienta o usuario a selecionar um icone na lista
624:         THIS.AddObject("lbl_4c_Instrucao", "Label")
625:         WITH THIS.lbl_4c_Instrucao
626:             .Top       = 95
627:             .Left      = 456
628:             .Width     = 320
629:             .Height    = 20
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .FontBold  = .T.
633:             .BackStyle = 0
634:             .AutoSize  = .F.
635:             .Caption   = "Selecione um " + CHR(237) + "cone da lista:"
636:             .ForeColor = RGB(90, 90, 90)
637:             .Visible   = .T.
638:         ENDWITH
639: 
640:         *-- Exibe o nome do arquivo do icone correntemente selecionado no grid
641:         THIS.AddObject("lbl_4c_NomeIcone", "Label")
642:         WITH THIS.lbl_4c_NomeIcone
643:             .Top       = 120
644:             .Left      = 456
645:             .Width     = 320
646:             .Height    = 75
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .FontBold  = .F.
650:             .WordWrap  = .T.
651:             .BackStyle = 0
652:             .AutoSize  = .F.
653:             .Caption   = ""
654:             .ForeColor = RGB(36, 84, 155)
655:             .Visible   = .T.
656:         ENDWITH
657: 
658:         *-- Titulo da secao de preview (imagem do icone selecionado)

*-- Linhas 676 a 821:
676:     *--------------------------------------------------------------------------
677:     * CarregarLista - Recarrega a lista de icones do SQL Server
678:     *--------------------------------------------------------------------------
679:     PROCEDURE CarregarLista()
680:         LOCAL loc_oErro
681:         TRY
682:             THIS.LockScreen = .T.
683:             THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
684:             IF USED("crTmpcdico")
685:                 THIS.grd_4c_Dados.ColumnCount             = 1
686:                 THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
687:                 THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
688:                 THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
689:                 THIS.grd_4c_Dados.Visible = .T.
690:                 THIS.grd_4c_Dados.Refresh()
691:                 THIS.AtualizarPreview()
692:                 THIS.HabilitarCampos()
693:             ENDIF
694:             THIS.LockScreen = .F.
695:         CATCH TO loc_oErro
696:             THIS.LockScreen = .F.
697:             MsgErro(loc_oErro.Message + CHR(13) + ;
698:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
699:                 "Procedure: " + loc_oErro.Procedure, ;
700:                 "Erro ao Carregar Lista")
701:         ENDTRY
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * BtnBuscarClick - Recarrega a lista de icones (refresh)
706:     *--------------------------------------------------------------------------
707:     PROCEDURE BtnBuscarClick()
708:         THIS.CarregarLista()
709:     ENDPROC
710: 
711:     *--------------------------------------------------------------------------
712:     * BtnSalvarClick - Form OPERACIONAL: delega ao fluxo de Incluir
713:     * (nao ha modo de edicao separado; o Incluir ja persiste diretamente)
714:     *--------------------------------------------------------------------------
715:     PROCEDURE BtnSalvarClick()
716:         THIS.BtnIncluirClick()
717:     ENDPROC
718: 
719:     *--------------------------------------------------------------------------
720:     * BtnCancelarClick - Limpa preview e volta ao topo da lista
721:     *--------------------------------------------------------------------------
722:     PROCEDURE BtnCancelarClick()
723:         THIS.LimparCampos()
724:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
725:             SELECT crTmpcdico
726:             GO TOP
727:             THIS.AtualizarPreview()
728:         ENDIF
729:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
730:             THIS.grd_4c_Dados.SetFocus()
731:         ENDIF
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * FormParaBO - Sincroniza o registro selecionado no grid com o BO
736:     *--------------------------------------------------------------------------
737:     PROCEDURE FormParaBO()
738:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
739:             SELECT crTmpcdico
740:             THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(crTmpcdico.carqicones)
741:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
742:             IF TYPE("crTmpcdico.ctmpicones") != "U"
743:                 THIS.this_oBusinessObject.this_cCtmpIcones = ALLTRIM(crTmpcdico.ctmpicones)
744:             ENDIF
745:         ENDIF
746:     ENDPROC
747: 
748:     *--------------------------------------------------------------------------
749:     * BOParaForm - Sincroniza o BO com a area de preview e label de nome
750:     *--------------------------------------------------------------------------
751:     PROCEDURE BOParaForm()
752:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
753:             THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
754:         ENDIF
755:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
756:             LOCAL loc_cArq
757:             loc_cArq = ALLTRIM(THIS.this_oBusinessObject.this_cCtmpIcones)
758:             IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
759:                 THIS.img_4c_Icone.Picture = loc_cArq
760:                 THIS.img_4c_Icone.Visible = .T.
761:             ELSE
762:                 THIS.img_4c_Icone.Visible = .F.
763:             ENDIF
764:         ENDIF
765:     ENDPROC
766: 
767:     *--------------------------------------------------------------------------
768:     * HabilitarCampos - Habilita/desabilita botoes conforme disponibilidade de dados
769:     *--------------------------------------------------------------------------
770:     PROCEDURE HabilitarCampos()
771:         LOCAL loc_lTemRegistros
772:         loc_lTemRegistros = USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
773:         IF PEMSTATUS(THIS, "obj_4c_Commandgroup1", 5)
774:             THIS.obj_4c_Commandgroup1.Buttons(2).Enabled = loc_lTemRegistros
775:         ENDIF
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * LimparCampos - Limpa a area de preview e o label de nome do icone
780:     *--------------------------------------------------------------------------
781:     PROCEDURE LimparCampos()
782:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
783:             THIS.img_4c_Icone.Picture = ""
784:             THIS.img_4c_Icone.Visible = .F.
785:         ENDIF
786:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
787:             THIS.lbl_4c_NomeIcone.Caption = ""
788:         ENDIF
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * AjustarBotoesPorModo - Form OPERACIONAL flat: delega para HabilitarCampos
793:     *--------------------------------------------------------------------------
794:     PROCEDURE AjustarBotoesPorModo()
795:         THIS.HabilitarCampos()
796:     ENDPROC
797: 
798:     *--------------------------------------------------------------------------
799:     * TornarControlesVisiveis - Torna todos os controles de um container visiveis
800:     *--------------------------------------------------------------------------
801:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
802:         LOCAL loc_i, loc_oControl, loc_p
803:         FOR loc_i = 1 TO par_oContainer.ControlCount
804:             loc_oControl = par_oContainer.Controls(loc_i)
805:             IF VARTYPE(loc_oControl) = "O"
806:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
807:                     loc_oControl.Visible = .T.
808:                 ENDIF
809:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
810:                     FOR loc_p = 1 TO loc_oControl.PageCount
811:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
812:                     ENDFOR
813:                 ENDIF
814:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
815:                     THIS.TornarControlesVisiveis(loc_oControl)
816:                 ENDIF
817:             ENDIF
818:         ENDFOR
819:     ENDPROC
820: 
821: ENDDEFINE


### BO (C:\4c\projeto\app\classes\ICOBO.prg):
*==============================================================================
* ICOBO.prg - Business Object: Cadastro de Icones (SigSyIco)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS ICOBO AS BusinessBase

    *-- Cursor de dados exibido no grid
    this_cCursorDados   = "crTmpcdico"

    *-- Nome do arquivo de icone selecionado/atual
    this_cCarqIcones    = ""

    *-- Conteudo binario do icone (MEMO)
    this_cMarqIcones    = ""

    *-- Caminho temporario do arquivo extraido para exibicao
    this_cCtmpIcones    = ""

    *-- Diretorio temporario usado para extracao dos icones
    this_cDirTemp       = ""

    *-- Indica se os icones ja foram carregados no cursor
    this_lCarregado     = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela      = "SigSyIco"
        THIS.this_cCampoChave  = "carqicones"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCarqIcones)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCarqIcones = TratarNulo(carqicones, "C")
            THIS.this_cMarqIcones = NVL(marqicones, "")
            IF TYPE("ctmpicones") != "U"
                THIS.this_cCtmpIcones = ALLTRIM(ctmpicones)
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarIcones - Carrega todos os icones do SQL Server para crTmpcdico
    *   par_cDirTemp: diretorio temporario para extrair arquivos de icone
    *--------------------------------------------------------------------------
    FUNCTION CarregarIcones(par_cDirTemp)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_cDirTemp = ADDBS(par_cDirTemp)

            *-- Fechar cursores anteriores
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            IF USED("crTmpcdico")
                USE IN crTmpcdico
            ENDIF

            *-- Criar cursor principal com estrutura identica ao legado
            SET NULL ON
            CREATE CURSOR crTmpcdico ( ;
                carqicones  C(128) NULL, ;
                marqicones  M NULL, ;
                ctmpicones  C(255) NULL ;
            )
            SET NULL OFF

            *-- Carregar dados do SQL Server
            LOCAL loc_cSQL
            loc_cSQL = "SELECT carqicones, marqicones FROM SigSyIco ORDER BY carqicones"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpcdico_Temp")
            IF loc_nResult > 0
                *-- Declarar variaveis do SCAN antes do loop
                LOCAL loc_cNome, loc_cArqTemp, loc_nTam
                loc_cNome    = ""
                loc_cArqTemp = ""
                loc_nTam     = 0

                IF USED("crTmpcdico_Temp") AND RECCOUNT("crTmpcdico_Temp") > 0
                    SELECT crTmpcdico_Temp
                    SCAN
                        loc_cNome    = ALLTRIM(crTmpcdico_Temp.carqicones)
                        loc_cArqTemp = ""

                        *-- Extrair conteudo binario para arquivo temporario
                        IF !EMPTY(crTmpcdico_Temp.marqicones)
                            loc_cArqTemp = THIS.this_cDirTemp + "ArqIcone" + SYS(2015) + ".ico"
                            loc_nTam = STRTOFILE(crTmpcdico_Temp.marqicones, loc_cArqTemp)
                            IF loc_nTam > 0
                                loc_cArqTemp = LOWER(loc_cArqTemp)
                            ELSE
                                loc_cArqTemp = ""
                            ENDIF
                        ENDIF

                        *-- Popular cursor principal
                        SELECT crTmpcdico
                        APPEND BLANK
                        REPLACE carqicones WITH loc_cNome
                        REPLACE marqicones WITH crTmpcdico_Temp.marqicones
                        REPLACE ctmpicones WITH loc_cArqTemp
                        SELECT crTmpcdico_Temp
                    ENDSCAN
                ENDIF

                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF

                *-- Indexar e posicionar no inicio
                SELECT crTmpcdico
                INDEX ON carqicones TAG carqicones
                SET ORDER TO carqicones IN crTmpcdico
                GO TOP IN crTmpcdico

                THIS.this_lCarregado = .T.
                loc_lResultado = .T.
            ELSE
                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao carregar " + CHR(237) + "cones: " + loc_aErros[1,2], "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar " + CHR(205) + "cones")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo icone no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO SigSyIco (carqicones, marqicones) VALUES (?loc_cNome, ?loc_mConteudo)"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao inserir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Inserir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza icone existente no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "UPDATE SigSyIco SET marqicones = ?loc_mConteudo WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao atualizar " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Atualizar " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui icone do SQL Server (chamado por Excluir())
    *   Requer this_cCarqIcones populado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_cSQL
            loc_cSQL = "DELETE FROM SigSyIco WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao excluir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Excluir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoIcone - Verifica se icone esta referenciado em SigCdPrg.barrapict
    *   par_cNomeIcone: nome do arquivo (carqicones)
    *   Retorna .T. se em uso (nao pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoIcone(par_cNomeIcone)
        LOCAL loc_lEmUso, loc_oErro
        loc_lEmUso = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(par_cNomeIcone)

            LOCAL loc_cSQL
            loc_cSQL = "SELECT COUNT(*) AS nQtd FROM SigCdPrg WHERE barrapict = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVerificaUsoIco")
            IF loc_nResult > 0
                IF USED("crVerificaUsoIco")
                    loc_lEmUso = (NVL(crVerificaUsoIco.nQtd, 0) > 0)
                    USE IN crVerificaUsoIco
                ENDIF
            ELSE
                IF USED("crVerificaUsoIco")
                    USE IN crVerificaUsoIco
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("crVerificaUsoIco")
                USE IN crVerificaUsoIco
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Verificar Uso do " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lEmUso
    ENDFUNC

ENDDEFINE

