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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICO.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (825 linhas total):

*-- Linhas 28 a 213:
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
61:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:             *-- Carregar icones do SQL Server para cursor crTmpcdico
65:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                 THIS.this_cDirTemp = ADDBS(SYS(2023))
67:                 THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
68:                 IF USED("crTmpcdico")
69:                     THIS.grd_4c_Dados.ColumnCount              = 1
70:                     THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
71:                     THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
72:                     THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
73:                     THIS.grd_4c_Dados.Visible = .T.
74:                     THIS.grd_4c_Dados.Refresh()
75:                     THIS.AtualizarPreview()
76:                     THIS.grd_4c_Dados.SetFocus()
77:                 ENDIF
78:             ENDIF
79: 
80:             THIS.LockScreen = .F.
81:             loc_lSucesso = .T.
82:         CATCH TO loc_oErro
83:             THIS.LockScreen = .F.
84:             MsgErro(loc_oErro.Message + CHR(13) + ;
85:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
86:                 "Procedure: " + loc_oErro.Procedure, ;
87:                 "Erro ao Inicializar FormICO")
88:         ENDTRY
89:         RETURN loc_lSucesso
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:     *--------------------------------------------------------------------------
95:     * OPERACIONAL flat layout - o legado SIGCDICO nao usa PageFrame; controles
96:     * (Grid1 de icones, Icone/Image de preview, Commandgroup1 de acoes) ficam
97:     * diretamente sobre o Form. Este metodo orquestra a composicao das regioes:
98:     * cabecalho cinza (cntSombra), area de listagem (Grid1 + Image), area de
99:     * acoes (CommandGroup Novo/Excluir/Fechar). Nome preservado para
100:     * compatibilidade com o pipeline de migracao multi-fase.
101:     *--------------------------------------------------------------------------
102:         THIS.ConfigurarCabecalho()
103:         THIS.ConfigurarPaginaLista()
104:         THIS.ConfigurarPaginaDados()
105:     ENDPROC
106: 
107:     *--------------------------------------------------------------------------
108:     PROTECTED PROCEDURE ConfigurarCabecalho()
109:     *--------------------------------------------------------------------------
110:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH THIS.cnt_4c_Cabecalho
112:             .Top         = -1
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BorderWidth = 0
117:             .BackStyle   = 1
118:             .BackColor   = RGB(100, 100, 100)
119:             .Visible     = .T.
120:         ENDWITH
121: 
122:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
123:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
124:             .Top           = 18
125:             .Left          = 10
126:             .Width         = 769
127:             .Height        = 40
128:             .FontBold      = .T.
129:             .FontName      = "Tahoma"
130:             .FontSize      = 18
131:             .FontUnderline = .F.
132:             .WordWrap      = .T.
133:             .Alignment     = 0
134:             .BackStyle     = 0
135:             .AutoSize      = .F.
136:             .Caption       = "Cadastro de " + CHR(205) + "cones"
137:             .ForeColor     = RGB(0, 0, 0)
138:             .Visible       = .T.
139:         ENDWITH
140: 
141:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Top       = 17
144:             .Left      = 10
145:             .Width     = 769
146:             .Height    = 46
147:             .FontBold  = .T.
148:             .FontName  = "Tahoma"
149:             .FontSize  = 18
150:             .WordWrap  = .T.
151:             .Alignment = 0
152:             .BackStyle = 0
153:             .AutoSize  = .F.
154:             .Caption   = "Cadastro de " + CHR(205) + "cones"
155:             .ForeColor = RGB(255, 255, 255)
156:             .Visible   = .T.
157:         ENDWITH
158:     ENDPROC
159: 
160:     *--------------------------------------------------------------------------
161:     PROCEDURE Destroy()
162:     *--------------------------------------------------------------------------
163:         IF USED("crTmpcdico")
164:             USE IN crTmpcdico
165:         ENDIF
166:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
167:             THIS.this_oBusinessObject = .NULL.
168:         ENDIF
169:         DODEFAULT()
170:     ENDPROC
171: 
172:     *--------------------------------------------------------------------------
173:     PROTECTED PROCEDURE ConfigurarPaginaLista()
174:     *--------------------------------------------------------------------------
175:         *-- Grid de icones (grd_4c_Dados) - Grid1 do legado
176:         THIS.AddObject("grd_4c_Dados", "Grid")
177:         THIS.grd_4c_Dados.ColumnCount = 1
178:         WITH THIS.grd_4c_Dados
179:             .Top               = 85
180:             .Left              = 30
181:             .Width             = 414
182:             .Height            = 526
183:             .ReadOnly          = .T.
184:             .AllowHeaderSizing = .F.
185:             .AllowRowSizing    = .F.
186:             .DeleteMark        = .F.
187:             .RecordMark        = .F.
188:             .ScrollBars        = 2
189:             .HeaderHeight      = 15
190:             .RowHeight         = 15
191: 
192:             .FontName = "Courier New"
193:             .SetAll("FontName",    "Verdana",           "Header")
194:             .SetAll("FontName",    "Courier New",       "TextBox")
195:             .FontSize = 9
196:             .SetAll("FontSize",    8,                   "Header")
197:             .SetAll("FontSize",    9,                   "TextBox")
198:             .SetAll("Format",      "K",                 "Column")
199:             .SetAll("Format",      "K",                 "TextBox")
200:             .SetAll("Movable",     .F.,                 "Column")
201:             .SetAll("ReadOnly",    .T.,                 "Column")
202:             .SetAll("ReadOnly",    .T.,                 "TextBox")
203:             .SetAll("Resizable",   .F.,                 "Column")
204:             .SetAll("Alignment",   3,                   "Column")
205:             .SetAll("Alignment",   3,                   "TextBox")
206:             .SetAll("Alignment",   2,                   "Header")
207:             .SetAll("BorderStyle", 0,                   "TextBox")
208:             .SetAll("Margin",      0,                   "TextBox")
209:             .SetAll("Visible",     .T.,                 "TextBox")
210:             .SetAll("ForeColor",   RGB(36, 84, 155),   "Header")
211: 
212:             .Column1.Width = 383
213:         ENDWITH

*-- Linhas 299 a 416:
299:             .PicturePosition = 13
300:         ENDWITH
301: 
302:         *-- BINDEVENTs para eventos do grid (atualizar preview ao navegar)
303:         BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdDadosScrolled")
304:         BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange",  THIS, "GrdDadosBeforeRowColChange")
305:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",   THIS, "GrdDadosAfterRowColChange")
306: 
307:         *-- BINDEVENTs para botoes de acao
308:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnIncluirClick")
309:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnExcluirClick")
310:         BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
311:     ENDPROC
312: 
313:     *--------------------------------------------------------------------------
314:     PROCEDURE AlternarPagina(par_nPagina)
315:     *--------------------------------------------------------------------------
316:         RETURN
317:     ENDPROC
318: 
319:     *--------------------------------------------------------------------------
320:     PROTECTED PROCEDURE AtualizarPreview()
321:     *--------------------------------------------------------------------------
322:         LOCAL loc_cArquivo, loc_cNomeArq
323:         loc_cArquivo = ""
324:         loc_cNomeArq = ""
325:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
326:             SELECT crTmpcdico
327:             loc_cArquivo = ALLTRIM(crTmpcdico.ctmpicones)
328:             loc_cNomeArq = ALLTRIM(crTmpcdico.carqicones)
329:         ENDIF
330:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
331:             THIS.img_4c_Icone.Picture = loc_cArquivo
332:             THIS.img_4c_Icone.Visible = .T.
333:         ELSE
334:             THIS.img_4c_Icone.Visible = .F.
335:         ENDIF
336:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
337:             THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
338:         ENDIF
339:     ENDPROC
340: 
341:     *--------------------------------------------------------------------------
342:     * GrdDadosScrolled - Atualiza preview ao rolar o grid (Grid1.Scrolled do legado)
343:     *--------------------------------------------------------------------------
344:     PROCEDURE GrdDadosScrolled(par_nDirection)
345:         THIS.AtualizarPreview()
346:     ENDPROC
347: 
348:     *--------------------------------------------------------------------------
349:     * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha
350:     *--------------------------------------------------------------------------
351:     PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
352:         THIS.AtualizarPreview()
353:     ENDPROC
354: 
355:     *--------------------------------------------------------------------------
356:     * GrdDadosAfterRowColChange - Atualiza preview apos mudar linha
357:     *--------------------------------------------------------------------------
358:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
359:         THIS.AtualizarPreview()
360:     ENDPROC
361: 
362:     *--------------------------------------------------------------------------
363:     * BtnIncluirClick - Inclui novo icone via seletor de arquivo (cmdInserir.Click do legado)
364:     *--------------------------------------------------------------------------
365:     PROCEDURE BtnIncluirClick()
366:         LOCAL loc_cArqIcone, loc_oErro
367:         loc_cArqIcone = ""
368:         TRY
369:             loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")
370: 
371:             IF EMPTY(loc_cArqIcone)
372:                 RETURN
373:             ENDIF
374: 
375:             IF !FILE(loc_cArqIcone)
376:                 MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
377:                 RETURN
378:             ENDIF
379: 
380:             THIS.LockScreen = .T.
381: 
382:             LOCAL loc_cDirTmp, loc_cArqTemp, loc_cNomeArq
383:             loc_cDirTmp  = ADDBS(SYS(2023))
384:             loc_cArqTemp = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
385:             loc_cNomeArq = LOWER(JUSTFNAME(loc_cArqIcone))
386: 
387:             LOCAL loc_lExiste
388:             loc_lExiste = USED("crTmpcdico") AND SEEK(loc_cNomeArq, "crTmpcdico", "carqicones")
389: 
390:             IF !loc_lExiste
391:                 SELECT crTmpcdico
392:                 APPEND BLANK
393:             ELSE
394:                 SELECT crTmpcdico
395:             ENDIF
396: 
397:             REPLACE carqicones WITH loc_cNomeArq
398:             REPLACE marqicones WITH FILETOSTR(loc_cArqIcone)
399:             REPLACE ctmpicones WITH loc_cArqTemp
400: 
401:             LOCAL loc_nBytes
402:             loc_nBytes = STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
403: 
404:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeArq
405:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
406: 
407:             LOCAL loc_lSucesso
408:             IF !loc_lExiste
409:                 loc_lSucesso = THIS.this_oBusinessObject.Inserir()
410:             ELSE
411:                 loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
412:             ENDIF
413: 
414:             THIS.grd_4c_Dados.Refresh()
415:             SELECT crTmpcdico
416:             GO TOP

*-- Linhas 423 a 660:
423:             THIS.LockScreen = .F.
424:             MsgErro(loc_oErro.Message + CHR(13) + ;
425:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
426:                 "Procedure: " + loc_oErro.Procedure, ;
427:                 "Erro ao Incluir " + CHR(205) + "cone")
428:         ENDTRY
429:     ENDPROC
430: 
431:     *--------------------------------------------------------------------------
432:     * BtnExcluirClick - Exclui icone selecionado (cmdExcluir.Click do legado)
433:     *--------------------------------------------------------------------------
434:     PROCEDURE BtnExcluirClick()
435:         LOCAL loc_oErro
436:         TRY
437:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
438:                 RETURN
439:             ENDIF
440: 
441:             SELECT crTmpcdico
442:             LOCAL loc_cRegistro
443:             loc_cRegistro = ALLTRIM(crTmpcdico.carqicones)
444: 
445:             IF EMPTY(loc_cRegistro)
446:                 RETURN
447:             ENDIF
448: 
449:             IF !MsgConfirma("Tem certeza que deseja Excluir?", "Excluir")
450:                 RETURN
451:             ENDIF
452: 
453:             THIS.LockScreen = .T.
454: 
455:             IF THIS.this_oBusinessObject.VerificarUsoIcone(loc_cRegistro)
456:                 MsgAviso("Existem " + CHR(237) + "tens cadastrados que est" + CHR(227) + ;
457:                     "o utilizando esse Registro!", ;
458:                     "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
459:                 THIS.LockScreen = .F.
460:                 RETURN
461:             ENDIF
462: 
463:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cRegistro
464:             IF THIS.this_oBusinessObject.Excluir()
465:                 DELETE FROM crTmpcdico WHERE ALLTRIM(carqicones) = loc_cRegistro
466:                 THIS.grd_4c_Dados.Refresh()
467:                 SELECT crTmpcdico
468:                 GO TOP
469:                 LOCATE FOR carqicones > loc_cRegistro
470:                 IF EOF()
471:                     GO BOTTOM
472:                 ENDIF
473:                 THIS.AtualizarPreview()
474:                 THIS.Refresh()
475:                 THIS.grd_4c_Dados.SetFocus()
476:             ENDIF
477: 
478:             THIS.LockScreen = .F.
479:         CATCH TO loc_oErro
480:             THIS.LockScreen = .F.
481:             MsgErro(loc_oErro.Message + CHR(13) + ;
482:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
483:                 "Procedure: " + loc_oErro.Procedure, ;
484:                 "Erro ao Excluir " + CHR(205) + "cone")
485:         ENDTRY
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * BtnEncerrarClick - Fecha o formulario (cmdSair.Click do legado)
490:     *--------------------------------------------------------------------------
491:     PROCEDURE BtnEncerrarClick()
492:         THIS.Release()
493:     ENDPROC
494: 
495:     *--------------------------------------------------------------------------
496:     * BtnAlterarClick - Substitui o conteudo binario do icone selecionado por
497:     * um novo arquivo (mantem o carqicones/PK, atualiza marqicones/ctmpicones).
498:     * O legado nao expoe botao Alterar; a semantica adotada segue o mesmo
499:     * fluxo de Incluir quando SEEK() encontra o registro (chama Atualizar()).
500:     *--------------------------------------------------------------------------
501:     PROCEDURE BtnAlterarClick()
502:         LOCAL loc_cArqIcone, loc_oErro
503:         loc_cArqIcone = ""
504:         TRY
505:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
506:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
507:                     "cones cadastrados para alterar.", "Aviso")
508:                 RETURN
509:             ENDIF
510: 
511:             SELECT crTmpcdico
512:             LOCAL loc_cNomeAtual
513:             loc_cNomeAtual = ALLTRIM(crTmpcdico.carqicones)
514: 
515:             IF EMPTY(loc_cNomeAtual)
516:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para alterar.", "Aviso")
517:                 RETURN
518:             ENDIF
519: 
520:             loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")
521: 
522:             IF EMPTY(loc_cArqIcone)
523:                 RETURN
524:             ENDIF
525: 
526:             IF !FILE(loc_cArqIcone)
527:                 MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
528:                 RETURN
529:             ENDIF
530: 
531:             IF !MsgConfirma("Substituir o conte" + CHR(250) + "do do " + CHR(237) + ;
532:                     "cone selecionado?", "Alterar")
533:                 RETURN
534:             ENDIF
535: 
536:             THIS.LockScreen = .T.
537: 
538:             LOCAL loc_cDirTmp, loc_cArqTemp, loc_mConteudo
539:             loc_cDirTmp   = ADDBS(SYS(2023))
540:             loc_cArqTemp  = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
541:             loc_mConteudo = FILETOSTR(loc_cArqIcone)
542: 
543:             SELECT crTmpcdico
544:             REPLACE marqicones WITH loc_mConteudo
545:             REPLACE ctmpicones WITH loc_cArqTemp
546: 
547:             STRTOFILE(loc_mConteudo, loc_cArqTemp)
548: 
549:             THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeAtual
550:             THIS.this_oBusinessObject.this_cMarqIcones = loc_mConteudo
551: 
552:             LOCAL loc_lSucesso
553:             loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
554: 
555:             THIS.grd_4c_Dados.Refresh()
556:             SELECT crTmpcdico
557:             LOCATE FOR ALLTRIM(carqicones) == loc_cNomeAtual
558:             THIS.AtualizarPreview()
559:             THIS.Refresh()
560:             THIS.LockScreen = .F.
561:             THIS.grd_4c_Dados.SetFocus()
562:         CATCH TO loc_oErro
563:             THIS.LockScreen = .F.
564:             MsgErro(loc_oErro.Message + CHR(13) + ;
565:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
566:                 "Procedure: " + loc_oErro.Procedure, ;
567:                 "Erro ao Alterar " + CHR(205) + "cone")
568:         ENDTRY
569:     ENDPROC
570: 
571:     *--------------------------------------------------------------------------
572:     * BtnVisualizarClick - Reforca a exibicao da imagem do icone selecionado
573:     * no painel de preview (img_4c_Icone) e devolve o foco ao grid. Espelha o
574:     * comportamento de navegacao do legado (Grid1.Scrolled/AfterRowColChange)
575:     * quando invocado explicitamente pelo usuario.
576:     *--------------------------------------------------------------------------
577:     PROCEDURE BtnVisualizarClick()
578:         LOCAL loc_oErro
579:         TRY
580:             IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
581:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
582:                     "cones cadastrados para visualizar.", "Aviso")
583:                 RETURN
584:             ENDIF
585: 
586:             SELECT crTmpcdico
587:             LOCAL loc_cNome
588:             loc_cNome = ALLTRIM(crTmpcdico.carqicones)
589: 
590:             IF EMPTY(loc_cNome)
591:                 MsgAviso("Selecione um " + CHR(237) + "cone na lista para visualizar.", "Aviso")
592:                 RETURN
593:             ENDIF
594: 
595:             *-- Se o arquivo temporario foi removido, regenerar a partir do MEMO
596:             LOCAL loc_cArqTemp
597:             loc_cArqTemp = ALLTRIM(crTmpcdico.ctmpicones)
598:             IF EMPTY(loc_cArqTemp) OR !FILE(loc_cArqTemp)
599:                 loc_cArqTemp = ADDBS(SYS(2023)) + "ArqIcone" + SYS(2015) + ".ico"
600:                 IF !EMPTY(crTmpcdico.marqicones)
601:                     STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
602:                     REPLACE ctmpicones WITH loc_cArqTemp
603:                 ELSE
604:                     loc_cArqTemp = ""
605:                 ENDIF
606:             ENDIF
607: 
608:             THIS.AtualizarPreview()
609:             THIS.Refresh()
610:             THIS.grd_4c_Dados.SetFocus()
611:         CATCH TO loc_oErro
612:             MsgErro(loc_oErro.Message + CHR(13) + ;
613:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
614:                 "Procedure: " + loc_oErro.Procedure, ;
615:                 "Erro ao Visualizar " + CHR(205) + "cone")
616:         ENDTRY
617:     ENDPROC
618: 
619:     *--------------------------------------------------------------------------
620:     PROTECTED PROCEDURE ConfigurarPaginaDados()
621:     *--------------------------------------------------------------------------
622:     * Painel direito do form (x=456+): labels informativos acima da preview
623:     * Area entre cabecalho (bottom=79) e imagem (top=220) ~ 140px disponiveis
624:     *--------------------------------------------------------------------------
625:         *-- Instrucao: orienta o usuario a selecionar um icone na lista
626:         THIS.AddObject("lbl_4c_Instrucao", "Label")
627:         WITH THIS.lbl_4c_Instrucao
628:             .Top       = 95
629:             .Left      = 456
630:             .Width     = 320
631:             .Height    = 20
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .FontBold  = .T.
635:             .BackStyle = 0
636:             .AutoSize  = .F.
637:             .Caption   = "Selecione um " + CHR(237) + "cone da lista:"
638:             .ForeColor = RGB(90, 90, 90)
639:             .Visible   = .T.
640:         ENDWITH
641: 
642:         *-- Exibe o nome do arquivo do icone correntemente selecionado no grid
643:         THIS.AddObject("lbl_4c_NomeIcone", "Label")
644:         WITH THIS.lbl_4c_NomeIcone
645:             .Top       = 120
646:             .Left      = 456
647:             .Width     = 320
648:             .Height    = 75
649:             .FontName  = "Tahoma"
650:             .FontSize  = 8
651:             .FontBold  = .F.
652:             .WordWrap  = .T.
653:             .BackStyle = 0
654:             .AutoSize  = .F.
655:             .Caption   = ""
656:             .ForeColor = RGB(36, 84, 155)
657:             .Visible   = .T.
658:         ENDWITH
659: 
660:         *-- Titulo da secao de preview (imagem do icone selecionado)

*-- Linhas 678 a 825:
678:     *--------------------------------------------------------------------------
679:     * CarregarLista - Recarrega a lista de icones do SQL Server
680:     *--------------------------------------------------------------------------
681:     PROCEDURE CarregarLista()
682:         LOCAL loc_oErro
683:         TRY
684:             THIS.LockScreen = .T.
685:             THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
686:             IF USED("crTmpcdico")
687:                 THIS.grd_4c_Dados.ColumnCount             = 1
688:                 THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
689:                 THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
690:                 THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
691:                 THIS.grd_4c_Dados.Visible = .T.
692:                 THIS.grd_4c_Dados.Refresh()
693:                 THIS.AtualizarPreview()
694:                 THIS.HabilitarCampos()
695:             ENDIF
696:             THIS.LockScreen = .F.
697:         CATCH TO loc_oErro
698:             THIS.LockScreen = .F.
699:             MsgErro(loc_oErro.Message + CHR(13) + ;
700:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
701:                 "Procedure: " + loc_oErro.Procedure, ;
702:                 "Erro ao Carregar Lista")
703:         ENDTRY
704:     ENDPROC
705: 
706:     *--------------------------------------------------------------------------
707:     * BtnBuscarClick - Recarrega a lista de icones (refresh)
708:     *--------------------------------------------------------------------------
709:     PROCEDURE BtnBuscarClick()
710:         THIS.CarregarLista()
711:     ENDPROC
712: 
713:     *--------------------------------------------------------------------------
714:     * BtnSalvarClick - Form OPERACIONAL: delega ao fluxo de Incluir
715:     * (nao ha modo de edicao separado; o Incluir ja persiste diretamente)
716:     *--------------------------------------------------------------------------
717:     PROCEDURE BtnSalvarClick()
718:         THIS.BtnIncluirClick()
719:     ENDPROC
720: 
721:     *--------------------------------------------------------------------------
722:     * BtnCancelarClick - Limpa preview e volta ao topo da lista
723:     *--------------------------------------------------------------------------
724:     PROCEDURE BtnCancelarClick()
725:         THIS.LimparCampos()
726:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
727:             SELECT crTmpcdico
728:             GO TOP
729:             THIS.AtualizarPreview()
730:         ENDIF
731:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
732:             THIS.grd_4c_Dados.SetFocus()
733:         ENDIF
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * FormParaBO - Sincroniza o registro selecionado no grid com o BO
738:     *--------------------------------------------------------------------------
739:     PROCEDURE FormParaBO()
740:         IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
741:             SELECT crTmpcdico
742:             THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(crTmpcdico.carqicones)
743:             THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
744:             IF TYPE("crTmpcdico.ctmpicones") != "U"
745:                 THIS.this_oBusinessObject.this_cCtmpIcones = ALLTRIM(crTmpcdico.ctmpicones)
746:             ENDIF
747:         ENDIF
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * BOParaForm - Sincroniza o BO com a area de preview e label de nome
752:     *--------------------------------------------------------------------------
753:     PROCEDURE BOParaForm()
754:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
755:             THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
756:         ENDIF
757:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
758:             LOCAL loc_cArq
759:             loc_cArq = ALLTRIM(THIS.this_oBusinessObject.this_cCtmpIcones)
760:             IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
761:                 THIS.img_4c_Icone.Picture = loc_cArq
762:                 THIS.img_4c_Icone.Visible = .T.
763:             ELSE
764:                 THIS.img_4c_Icone.Visible = .F.
765:             ENDIF
766:         ENDIF
767:     ENDPROC
768: 
769:     *--------------------------------------------------------------------------
770:     * HabilitarCampos - Habilita/desabilita botoes conforme disponibilidade de dados
771:     *--------------------------------------------------------------------------
772:     PROCEDURE HabilitarCampos()
773:         LOCAL loc_lTemRegistros
774:         loc_lTemRegistros = USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
775:         IF PEMSTATUS(THIS, "obj_4c_Commandgroup1", 5)
776:             THIS.obj_4c_Commandgroup1.Buttons(2).Enabled = loc_lTemRegistros
777:         ENDIF
778:     ENDPROC
779: 
780:     *--------------------------------------------------------------------------
781:     * LimparCampos - Limpa a area de preview e o label de nome do icone
782:     *--------------------------------------------------------------------------
783:     PROCEDURE LimparCampos()
784:         IF PEMSTATUS(THIS, "img_4c_Icone", 5)
785:             THIS.img_4c_Icone.Picture = ""
786:             THIS.img_4c_Icone.Visible = .F.
787:         ENDIF
788:         IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
789:             THIS.lbl_4c_NomeIcone.Caption = ""
790:         ENDIF
791:     ENDPROC
792: 
793:     *--------------------------------------------------------------------------
794:     * AjustarBotoesPorModo - Form OPERACIONAL flat: delega para HabilitarCampos
795:     *--------------------------------------------------------------------------
796:     PROCEDURE AjustarBotoesPorModo()
797:         THIS.HabilitarCampos()
798:     ENDPROC
799: 
800:     *--------------------------------------------------------------------------
801:     * TornarControlesVisiveis - Torna todos os controles de um container visiveis
802:     *--------------------------------------------------------------------------
803:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
804:         LOCAL loc_i, loc_oControl, loc_p
805:         FOR loc_i = 1 TO par_oContainer.ControlCount
806:             loc_oControl = par_oContainer.Controls(loc_i)
807:             IF VARTYPE(loc_oControl) = "O"
808:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
809:                     IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
810:                         loc_oControl.Visible = .T.
811:                     ENDIF
812:                 ENDIF
813:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
814:                     FOR loc_p = 1 TO loc_oControl.PageCount
815:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
816:                     ENDFOR
817:                 ENDIF
818:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
819:                     THIS.TornarControlesVisiveis(loc_oControl)
820:                 ENDIF
821:             ENDIF
822:         ENDFOR
823:     ENDPROC
824: 
825: ENDDEFINE


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

