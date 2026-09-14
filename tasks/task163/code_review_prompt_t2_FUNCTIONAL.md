# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterIconeSelecionadoNoGrid()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (826 linhas total):

*-- Linhas 40 a 155:
40:     *--------------------------------------------------------------------------
41:     * Init - Recebe form pai e chave do programa; delega inicializacao a FormBase
42:     *--------------------------------------------------------------------------
43:     PROCEDURE Init(par_oFormPai, par_cIdChaves)
44:         *-- Armazena parametros ANTES do DODEFAULT para que InicializarForm os encontre
45:         IF TYPE("par_oFormPai") = "O"
46:             THIS.this_oFormPai = par_oFormPai
47:         ELSE
48:             THIS.this_oFormPai = THIS
49:         ENDIF
50: 
51:         IF TYPE("par_cIdChaves") = "C"
52:             THIS.this_cIdChaves = par_cIdChaves
53:         ELSE
54:             THIS.this_cIdChaves = ""
55:         ENDIF
56: 
57:         RETURN DODEFAULT()
58:     ENDPROC
59: 
60:     *--------------------------------------------------------------------------
61:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
62:     * Cria BO, constroi PageFrame + containers principais e prepara dados iniciais
63:     *--------------------------------------------------------------------------
64:     PROTECTED PROCEDURE InicializarForm()
65:         LOCAL loc_lSucesso, loc_oErro
66:         loc_lSucesso = .F.
67: 
68:         TRY
69:             *-- Herdar datasession do form pai para acessar crProg1/crProg2/crSigSyIco1
70:             *-- Equivalente ao .DataSessionId = .poForm1.DataSessionId do legado
71:             IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
72:                 THIS.DataSessionId = THIS.this_oFormPai.DataSessionId
73:             ENDIF
74: 
75:             *-- Caption com acento via CHR (regra: sem literais acentuados em PRG)
76:             THIS.Caption = "Escolha de " + CHR(237) + "cones"
77: 
78:             *-- Imagem de fundo do form (copiada do SCX legado)
79:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
80: 
81:             *-- Cria Business Object
82:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCICBO")
83: 
84:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
85:                 MsgErro("Erro ao criar SIGPRCICBO", "Erro")
86:                 loc_lSucesso = .F.
87:             ENDIF
88: 
89:             *-- Construcao do form
90:             THIS.LockScreen = .T.
91:             THIS.ConfigurarCabecalho()
92:             THIS.ConfigurarPageFrame()
93:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
94:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
95:             THIS.TornarControlesVisiveis(THIS)
96:             THIS.LockScreen = .F.
97: 
98:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
99:                 THIS.CarregarDados()
100:             ENDIF
101: 
102:             loc_lSucesso = .T.
103: 
104:         CATCH TO loc_oErro
105:             THIS.LockScreen = .F.
106:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
107:         ENDTRY
108: 
109:         RETURN loc_lSucesso
110:     ENDPROC
111: 
112:     *--------------------------------------------------------------------------
113:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cntSombra do legado)
114:     *--------------------------------------------------------------------------
115:     PROTECTED PROCEDURE ConfigurarCabecalho()
116:         LOCAL loc_oCab
117: 
118:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = THIS.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 0
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 1
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128: 
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .AutoSize      = .F.
132:                 .Top           = 18
133:                 .Left          = 10
134:                 .Width         = loc_oCab.Width
135:                 .Height        = 40
136:                 .FontBold      = .T.
137:                 .FontName      = "Tahoma"
138:                 .FontSize      = 18
139:                 .FontUnderline = .F.
140:                 .WordWrap      = .T.
141:                 .Alignment     = 0
142:                 .BackStyle     = 0
143:                 .Caption       = "Escolha de " + CHR(237) + "cones"
144:                 .ForeColor     = RGB(0, 0, 0)
145:             ENDWITH
146: 
147:             .AddObject("lbl_4c_Titulo", "Label")
148:             WITH .lbl_4c_Titulo
149:                 .AutoSize  = .F.
150:                 .Top       = 17
151:                 .Left      = 10
152:                 .Width     = loc_oCab.Width
153:                 .Height    = 46
154:                 .FontBold  = .T.
155:                 .FontName  = "Tahoma"

*-- Linhas 162 a 253:
162:             ENDWITH
163:         ENDWITH
164: 
165:         *-- Torna cabecalho visivel explicitamente (TornarControlesVisiveis o filtra via INLIST)
166:         loc_oCab.Visible = .T.
167:     ENDPROC
168: 
169:     *--------------------------------------------------------------------------
170:     * ConfigurarPageFrame - Constroi pgf_4c_Paginas com Page1 e Page2,
171:     * delegando a construcao dos controles a ConfigurarPaginaLista().
172:     *--------------------------------------------------------------------------
173:     PROTECTED PROCEDURE ConfigurarPageFrame()
174:         LOCAL loc_oPgf
175: 
176:         *-- Cria PageFrame que ocupa area abaixo do cabecalho
177:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
178:         loc_oPgf = THIS.pgf_4c_Paginas
179:         loc_oPgf.PageCount = 2
180:         loc_oPgf.ErasePage = .T.
181:         loc_oPgf.Top       = 80
182:         loc_oPgf.Left      = 0
183:         loc_oPgf.Width     = THIS.Width
184:         loc_oPgf.Height    = THIS.Height - 80
185:         loc_oPgf.TabIndex  = 1
186:         loc_oPgf.Tabs      = .F.
187: 
188:         loc_oPgf.Page1.Caption = "Lista"
189:         loc_oPgf.Page2.Caption = "Dados"
190: 
191:         *-- Constroi controles da Page1 (grid de icones + preview + campo Programa)
192:         THIS.ConfigurarPaginaLista()
193: 
194:         *-- Page2: dialog plano, sem campos adicionais no original
195:         THIS.ConfigurarPaginaDados()
196: 
197:         *-- Ativa Page1 por default (visao principal do dialog)
198:         loc_oPgf.Visible    = .T.
199:         loc_oPgf.ActivePage = 1
200:     ENDPROC
201: 
202:     *--------------------------------------------------------------------------
203:     * ConfigurarPaginaLista - Constroi todos os controles de Page1:
204:     *   - lbl_4c_Programa + txt_4c_Programa (campo programa, somente leitura)
205:     *   - shp_4c_Preview (borda decorativa ao redor do preview)
206:     *   - img_4c_Icone (imagem preview do icone selecionado)
207:     *   - grd_4c_Dados (lista de icones - mapeado de Grid1 do legado)
208:     *   - BINDEVENTs para navegacao no grid e selecao de icone
209:     *
210:     * Posicoes: PageFrame.Top=80; controles em coords relativas a Page1
211:     * (Top_original - 80). RecordSource definido em CarregarDados().
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarPaginaLista()
214:         LOCAL loc_oPagina, loc_oGrid
215: 
216:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
217: 
218:         *-- Label "Programa" (Say2 do legado: Top=86 -> 86-80=6)
219:         loc_oPagina.AddObject("lbl_4c_Programa", "Label")
220:         WITH loc_oPagina.lbl_4c_Programa
221:             .Caption   = "Programa"
222:             .Left      = 12
223:             .Top       = 6
224:             .AutoSize  = .T.
225:             .FontName  = "Tahoma"
226:             .FontSize  = 8
227:             .ForeColor = RGB(90, 90, 90)
228:             .BackStyle = 0
229:         ENDWITH
230: 
231:         *-- TextBox nome do programa - somente leitura (Text1 do legado: Top=103 -> 23)
232:         loc_oPagina.AddObject("txt_4c_Programa", "TextBox")
233:         WITH loc_oPagina.txt_4c_Programa
234:             .FontBold  = .T.
235:             .FontName  = "Tahoma"
236:             .FontSize  = 8
237:             .Height    = 24
238:             .Left      = 9
239:             .Top       = 23
240:             .Width     = 457
241:             .ForeColor = RGB(90, 90, 90)
242:             .ReadOnly  = .T.
243:             .Value     = ""
244:         ENDWITH
245: 
246:         *-- Shape - borda decorativa ao redor do preview (Shape1 do legado: Top=184 -> 104)
247:         loc_oPagina.AddObject("shp_4c_Preview", "Shape")
248:         WITH loc_oPagina.shp_4c_Preview
249:             .Top         = 104
250:             .Left        = 276
251:             .Height      = 169
252:             .Width       = 169
253:             .BackStyle   = 0

*-- Linhas 326 a 826:
326:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
327:         ENDWITH
328: 
329:         *-- BINDEVENTs para navegacao no grid e selecao de icone
330:         BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")
331:         BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
332:         BINDEVENT(loc_oGrid, "Scrolled",           THIS, "GrdDadosScrolled")
333:         BINDEVENT(loc_oGrid.Column1.Text1, "DblClick",  THIS, "GrdDadosText1DblClick")
334:         BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "GrdDadosText1KeyPress")
335:     ENDPROC
336: 
337:     *--------------------------------------------------------------------------
338:     * ConfigurarPaginaDados - Page2 nao possui controles no form original
339:     * SIGPRCIC e um dialog flat: todos os campos estao em Page1
340:     *--------------------------------------------------------------------------
341:     PROTECTED PROCEDURE ConfigurarPaginaDados()
342:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(240, 240, 240)
343:     ENDPROC
344: 
345:     *--------------------------------------------------------------------------
346:     * CarregarDados - Le o icone atual do programa via BO e posiciona o cursor
347:     * de icones no arquivo correspondente.
348:     *--------------------------------------------------------------------------
349:     PROTECTED PROCEDURE CarregarDados()
350:         LOCAL loc_lSucesso, loc_cArqIcone, loc_cArquivo, loc_oPagina, loc_oErro
351:         loc_lSucesso = .F.
352: 
353:         TRY
354:             loc_oPagina   = THIS.pgf_4c_Paginas.Page1
355:             loc_cArqIcone = THIS.this_oBusinessObject.BuscarIconeAtual(THIS.this_cIdChaves)
356: 
357:             *-- Popula campo Programa com descricao lida pelo BO (crProg2.descricaos)
358:             loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
359: 
360:             *-- Posiciona cursor de icones (aberto pelo form pai) no icone atual
361:             IF USED("crSigSyIco1")
362:                 SET ORDER TO ("carqicones") IN ("crSigSyIco1")
363: 
364:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
365:                     SELECT crSigSyIco1
366:                     GO TOP
367:                 ENDIF
368: 
369:                 *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
370:                 loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
371:                 WITH loc_oPagina.grd_4c_Dados
372:                     .Column1.ControlSource = "crSigSyIco1.carqicones"
373:                     .LinkMaster            = ""
374:                     .RelationalExpr        = ""
375:                 ENDWITH
376: 
377:                 *-- Atualiza preview com o icone da linha inicial
378:                 loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
379:                 IF !EMPTY(loc_cArquivo)
380:                     loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
381:                     loc_oPagina.img_4c_Icone.Visible = .T.
382:                 ELSE
383:                     loc_oPagina.img_4c_Icone.Visible = .F.
384:                 ENDIF
385:             ENDIF
386: 
387:             loc_lSucesso = .T.
388: 
389:         CATCH TO loc_oErro
390:             MsgErro(loc_oErro.Message, "Erro CarregarDados")
391:         ENDTRY
392: 
393:         RETURN loc_lSucesso
394:     ENDPROC
395: 
396:     *--------------------------------------------------------------------------
397:     * TornarControlesVisiveis - Torna sub-controles visiveis apos AddObject
398:     * AddObject cria com Visible=.F.; percorre Controls + Pages recursivamente.
399:     *--------------------------------------------------------------------------
400:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
401:         LOCAL loc_nI, loc_oObjeto, loc_nP
402: 
403:         FOR loc_nI = 1 TO par_oContainer.ControlCount
404:             loc_oObjeto = par_oContainer.Controls(loc_nI)
405: 
406:             IF VARTYPE(loc_oObjeto) = "O"
407:                 *-- Recursao ANTES do filtro: garante que filhos de containers ocultos
408:                 *-- tambem se tornem visiveis (LOOP antecipado perderia os filhos)
409:                 IF PEMSTATUS(loc_oObjeto, "PageCount", 5)
410:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
411:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
412:                     ENDFOR
413:                 ENDIF
414: 
415:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
416:                     THIS.TornarControlesVisiveis(loc_oObjeto)
417:                 ENDIF
418: 
419:                 *-- cnt_4c_Cabecalho tem Visible gerenciado explicitamente em ConfigurarCabecalho
420:                 IF INLIST(LOWER(loc_oObjeto.Name), "cnt_4c_cabecalho")
421:                     LOOP
422:                 ENDIF
423: 
424:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
425:                     loc_oObjeto.Visible = .T.
426:                 ENDIF
427:             ENDIF
428:         ENDFOR
429:     ENDPROC
430: 
431:     *--------------------------------------------------------------------------
432:     * AlternarPagina - Muda a pagina ativa do PageFrame
433:     *--------------------------------------------------------------------------
434:     PROCEDURE AlternarPagina(par_nPagina)
435:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
436:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
437:         ENDIF
438:     ENDPROC
439: 
440:     *--------------------------------------------------------------------------
441:     * AtualizarPreviewIcone - Atualiza img_4c_Icone com o icone da linha atual
442:     * Chamado pelos handlers de navegacao do grid.
443:     *--------------------------------------------------------------------------
444:     PROTECTED PROCEDURE AtualizarPreviewIcone()
445:         LOCAL loc_cArquivo, loc_oImagem
446: 
447:         IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
448:             RETURN
449:         ENDIF
450: 
451:         loc_oImagem  = THIS.pgf_4c_Paginas.Page1.img_4c_Icone
452:         loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
453: 
454:         IF !EMPTY(loc_cArquivo)
455:             loc_oImagem.Picture = loc_cArquivo
456:             loc_oImagem.Visible = .T.
457:         ELSE
458:             loc_oImagem.Visible = .F.
459:         ENDIF
460:     ENDPROC
461: 
462:     *--------------------------------------------------------------------------
463:     * GrdDadosAfterRowColChange - Atualiza preview apos mover linha (BINDEVENT)
464:     *--------------------------------------------------------------------------
465:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
466:         THIS.AtualizarPreviewIcone()
467:     ENDPROC
468: 
469:     *--------------------------------------------------------------------------
470:     * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha (BINDEVENT)
471:     *--------------------------------------------------------------------------
472:     PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
473:         THIS.AtualizarPreviewIcone()
474:     ENDPROC
475: 
476:     *--------------------------------------------------------------------------
477:     * GrdDadosScrolled - Atualiza preview ao rolar o grid (BINDEVENT)
478:     *--------------------------------------------------------------------------
479:     PROCEDURE GrdDadosScrolled(par_nDirection)
480:         THIS.AtualizarPreviewIcone()
481:     ENDPROC
482: 
483:     *--------------------------------------------------------------------------
484:     * GrdDadosText1DblClick - Seleciona icone e fecha dialog (BINDEVENT)
485:     * Mapeado de Grid1.Column1.Text1.DblClick do legado.
486:     *--------------------------------------------------------------------------
487:     PROCEDURE GrdDadosText1DblClick()
488:         LOCAL loc_cArqIcone
489:         loc_cArqIcone = LOWER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.Text1.Value))
490:         THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
491:         THIS.Release()
492:     ENDPROC
493: 
494:     *--------------------------------------------------------------------------
495:     * GrdDadosText1KeyPress - ENTER na celula aciona selecao (BINDEVENT)
496:     * Mapeado de Grid1.Column1.Text1.KeyPress do legado.
497:     *--------------------------------------------------------------------------
498:     PROCEDURE GrdDadosText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
499:         IF par_nKeyCode = 13
500:             THIS.GrdDadosText1DblClick()
501:         ENDIF
502:     ENDPROC
503: 
504:     *--------------------------------------------------------------------------
505:     * KeyPress - ESC fecha o dialog sem salvar
506:     *--------------------------------------------------------------------------
507:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
508:         IF par_nKeyCode = 27
509:             THIS.Release()
510:         ENDIF
511:     ENDPROC
512: 
513:     *--------------------------------------------------------------------------
514:     * ObterIconeSelecionadoNoGrid - Retorna nome do arquivo de icone da linha ativa
515:     * Lida com marcador "< nenhum >" transformando em string vazia.
516:     *--------------------------------------------------------------------------
517:     PROTECTED FUNCTION ObterIconeSelecionadoNoGrid()
518:         LOCAL loc_cArqIcone
519: 
520:         IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
521:             RETURN ""
522:         ENDIF
523: 
524:         loc_cArqIcone = LOWER(ALLTRIM(NVL(crSigSyIco1.carqicones, "")))
525:         IF loc_cArqIcone == "< nenhum >"
526:             loc_cArqIcone = ""
527:         ENDIF
528: 
529:         RETURN loc_cArqIcone
530:     ENDPROC
531: 
532:     *--------------------------------------------------------------------------
533:     * BtnIncluirClick - Atribui o icone selecionado ao programa
534:     * Le o icone da linha ativa do grid + chama BO.Inserir + fecha o dialog.
535:     * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando nao havia icone.
536:     *--------------------------------------------------------------------------
537:     PROCEDURE BtnIncluirClick()
538:         LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro
539: 
540:         TRY
541:             IF EMPTY(THIS.this_cIdChaves)
542:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
543:                 RETURN
544:             ENDIF
545: 
546:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
547: 
548:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
549:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
550: 
551:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
552: 
553:             IF loc_lSucesso
554:                 THIS.Release()
555:             ELSE
556:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
557:             ENDIF
558: 
559:         CATCH TO loc_oErro
560:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
561:         ENDTRY
562:     ENDPROC
563: 
564:     *--------------------------------------------------------------------------
565:     * BtnAlterarClick - Troca o icone atribuido ao programa
566:     * Le o icone da linha ativa do grid + chama BO.Atualizar + fecha o dialog.
567:     * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando ja havia icone.
568:     *--------------------------------------------------------------------------
569:     PROCEDURE BtnAlterarClick()
570:         LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro
571: 
572:         TRY
573:             IF EMPTY(THIS.this_cIdChaves)
574:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
575:                 RETURN
576:             ENDIF
577: 
578:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
579: 
580:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
581:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
582: 
583:             IF THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
584:                 THIS.Release()
585:             ELSE
586:                 MsgAviso("Falha ao atualizar " + CHR(237) + "cone.", "Aviso")
587:             ENDIF
588: 
589:         CATCH TO loc_oErro
590:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
591:         ENDTRY
592:     ENDPROC
593: 
594:     *--------------------------------------------------------------------------
595:     * BtnVisualizarClick - Atualiza preview do icone da linha ativa
596:     * Equivalente ao Grid1.AfterRowColChange do legado (que atualizava o preview).
597:     *--------------------------------------------------------------------------
598:     PROCEDURE BtnVisualizarClick()
599:         LOCAL loc_oErro
600: 
601:         TRY
602:             IF !USED("crSigSyIco1")
603:                 MsgAviso("Lista de " + CHR(237) + "cones n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
604:                 RETURN
605:             ENDIF
606: 
607:             THIS.AtualizarPreviewIcone()
608: 
609:         CATCH TO loc_oErro
610:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
611:         ENDTRY
612:     ENDPROC
613: 
614:     *--------------------------------------------------------------------------
615:     * BtnExcluirClick - Remove o icone atribuido ao programa
616:     * Chama BO.Excluir para zerar barrapict/barraforms em crProg1/crProg2 + fecha.
617:     *--------------------------------------------------------------------------
618:     PROCEDURE BtnExcluirClick()
619:         LOCAL loc_lConfirma, loc_lSucesso, loc_oErro
620: 
621:         TRY
622:             IF EMPTY(THIS.this_cIdChaves)
623:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
624:                 RETURN
625:             ENDIF
626: 
627:             loc_lConfirma = MsgConfirma("Confirma a remo" + CHR(231) + CHR(227) + "o do " + CHR(237) + "cone atribu" + CHR(237) + "do?", "Confirma" + CHR(231) + CHR(227) + "o")
628: 
629:             IF !loc_lConfirma
630:                 RETURN
631:             ENDIF
632: 
633:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
634:             loc_lSucesso = THIS.this_oBusinessObject.Excluir()
635: 
636:             IF loc_lSucesso
637:                 THIS.Release()
638:             ELSE
639:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
640:             ENDIF
641: 
642:         CATCH TO loc_oErro
643:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
644:         ENDTRY
645:     ENDPROC
646: 
647:     *--------------------------------------------------------------------------
648:     * CarregarLista - Reinicializa o grid com crSigSyIco1 e atualiza preview
649:     * Util para refresco apos mudanca de icone ou retorno ao dialog.
650:     *--------------------------------------------------------------------------
651:     PROCEDURE CarregarLista()
652:         LOCAL loc_lSucesso, loc_oPagina, loc_oErro
653:         loc_lSucesso = .F.
654: 
655:         TRY
656:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
657: 
658:             IF USED("crSigSyIco1")
659:                 *-- RecordSource fora do WITH: Column1 pode ser acessado com seguranca em seguida
660:                 loc_oPagina.grd_4c_Dados.RecordSource = "crSigSyIco1"
661:                 WITH loc_oPagina.grd_4c_Dados
662:                     .Column1.ControlSource = "crSigSyIco1.carqicones"
663:                     .LinkMaster            = ""
664:                     .RelationalExpr        = ""
665:                 ENDWITH
666:                 THIS.AtualizarPreviewIcone()
667:             ENDIF
668: 
669:             loc_lSucesso = .T.
670: 
671:         CATCH TO loc_oErro
672:             MsgErro(loc_oErro.Message, "Erro CarregarLista")
673:         ENDTRY
674: 
675:         RETURN loc_lSucesso
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * FormParaBO - Transfere o icone selecionado no grid para o BO
680:     *--------------------------------------------------------------------------
681:     PROTECTED PROCEDURE FormParaBO()
682:         LOCAL loc_cArqIcone
683: 
684:         TRY
685:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
686:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
687:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
688:         CATCH TO loc_oErro
689:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
690:         ENDTRY
691:     ENDPROC
692: 
693:     *--------------------------------------------------------------------------
694:     * BOParaForm - Atualiza preview do form com o icone registrado no BO
695:     *--------------------------------------------------------------------------
696:     PROTECTED PROCEDURE BOParaForm()
697:         LOCAL loc_cArquivo, loc_oPagina, loc_oErro
698: 
699:         TRY
700:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
701:             loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArqIcone)
702: 
703:             IF !EMPTY(loc_cArquivo)
704:                 loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
705:                 loc_oPagina.img_4c_Icone.Visible = .T.
706:             ELSE
707:                 loc_oPagina.img_4c_Icone.Visible = .F.
708:             ENDIF
709: 
710:             loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
711:         CATCH TO loc_oErro
712:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
713:         ENDTRY
714:     ENDPROC
715: 
716:     *--------------------------------------------------------------------------
717:     * HabilitarCampos - Neste dialog os campos sao sempre readonly (somente grid)
718:     * Implementado para compatibilidade com FormBase.
719:     *--------------------------------------------------------------------------
720:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
721:         LOCAL loc_oPagina
722: 
723:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
724:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
725:             IF PEMSTATUS(loc_oPagina, "txt_4c_Programa", 5)
726:                 loc_oPagina.txt_4c_Programa.ReadOnly = .T.
727:             ENDIF
728:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
729:                 loc_oPagina.grd_4c_Dados.ReadOnly = .T.
730:             ENDIF
731:         ENDIF
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * LimparCampos - Limpa o preview e o campo de programa
736:     *--------------------------------------------------------------------------
737:     PROTECTED PROCEDURE LimparCampos()
738:         LOCAL loc_oPagina, loc_oErro
739: 
740:         TRY
741:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
742:             loc_oPagina.img_4c_Icone.Visible = .F.
743:             loc_oPagina.img_4c_Icone.Picture = ""
744:             loc_oPagina.txt_4c_Programa.Value = ""
745:         CATCH TO loc_oErro
746:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
747:         ENDTRY
748:     ENDPROC
749: 
750:     *--------------------------------------------------------------------------
751:     * AjustarBotoesPorModo - Dialog plano sem modos CRUD; sem ajuste de botoes
752:     * Implementado para compatibilidade com FormBase.
753:     *--------------------------------------------------------------------------
754:     PROTECTED PROCEDURE AjustarBotoesPorModo()
755:         RETURN
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * BtnBuscarClick - Recarrega o grid de icones e posiciona no icone atual
760:     *--------------------------------------------------------------------------
761:     PROCEDURE BtnBuscarClick()
762:         LOCAL loc_oErro
763: 
764:         TRY
765:             THIS.CarregarDados()
766:         CATCH TO loc_oErro
767:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
768:         ENDTRY
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     * BtnSalvarClick - Seleciona o icone da linha atual e fecha o dialog
773:     * Equivalente ao DblClick/ENTER no grid; usa FormParaBO antes de salvar.
774:     *--------------------------------------------------------------------------
775:     PROCEDURE BtnSalvarClick()
776:         LOCAL loc_lSucesso, loc_oErro
777: 
778:         TRY
779:             THIS.FormParaBO()
780:             loc_lSucesso = THIS.this_oBusinessObject.SelecionarIcone( ;
781:                 THIS.this_oBusinessObject.this_cArqIcone, ;
782:                 THIS.this_cIdChaves)
783: 
784:             IF loc_lSucesso
785:                 THIS.Release()
786:             ELSE
787:                 MsgAviso("Falha ao atribuir " + CHR(237) + "cone.", "Aviso")
788:             ENDIF
789: 
790:         CATCH TO loc_oErro
791:             MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
792:         ENDTRY
793:     ENDPROC
794: 
795:     *--------------------------------------------------------------------------
796:     * BtnCancelarClick - Fecha o dialog sem salvar (mesmo comportamento do ESC)
797:     *--------------------------------------------------------------------------
798:     PROCEDURE BtnCancelarClick()
799:         THIS.Release()
800:     ENDPROC
801: 
802:     *--------------------------------------------------------------------------
803:     * BtnEncerrarClick - Fecha o dialog (alias de Cancelar para compatibilidade)
804:     *--------------------------------------------------------------------------
805:     PROCEDURE BtnEncerrarClick()
806:         THIS.Release()
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * Destroy - Libera Business Object e delega restante ao FormBase
811:     *--------------------------------------------------------------------------
812:     PROCEDURE Destroy()
813:         LOCAL loc_oErro
814: 
815:         TRY
816:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
817:                 THIS.this_oBusinessObject = .NULL.
818:             ENDIF
819:         CATCH TO loc_oErro
820:             *-- Ignorar erros no Destroy (form ja esta sendo liberado)
821:         ENDTRY
822: 
823:         DODEFAULT()
824:     ENDPROC
825: 
826: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCICBO.prg):
*==============================================================================
* SIGPRCICBO.prg - Business Object para Seletor de Icones de Programas
* Data: 2026-07-02
* Funcao: Dialog de escolha de icone para item de menu/programa
* Obs: Form opera na datasession do form pai (sem SQL proprio)
*==============================================================================

DEFINE CLASS SIGPRCICBO AS BusinessBase

    *-- Chave do programa passada pelo form pai (pcIdChaves no legado)
    this_cIdChaves      = ""    && pkChaves do programa (crProg1/crProg2)

    *-- Icone atualmente selecionado (barrapict no legado)
    this_cArqIcone      = ""    && nome do arquivo de icone (ex: "geral_ok_26.jpg")

    *-- Descricao do programa exibida no campo readonly
    this_cDescricao     = ""    && descricaos de crProg2

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGPRCIC"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de crProg2 ou alias
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves  = TratarNulo(pkChaves,   "C")
                THIS.this_cArqIcone  = LOWER(ALLTRIM(TratarNulo(barrapict,  "C")))
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do programa selecionado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarIcone - Atualiza barrapict em crProg1 e crProg2 (cursor REPLACE)
    * Este form opera na datasession do form pai; nao usa SQLEXEC proprio.
    * A gravacao definitiva no SQL Server eh feita pelo form pai ao salvar.
    *--------------------------------------------------------------------------
    FUNCTION SelecionarIcone(par_cArqIcone, par_cIdChaves)
        LOCAL loc_lSucesso, loc_cIcone
        loc_lSucesso = .F.

        TRY
            loc_cIcone = LOWER(ALLTRIM(par_cArqIcone))
            IF loc_cIcone = "< nenhum >"
                loc_cIcone = ""
            ENDIF

            IF USED("crProg1") AND SEEK(par_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg1.programas)
            ENDIF

            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH loc_cIcone, ;
                        barraforms WITH IIF(!EMPTY(barraforms), barraforms, crProg2.programas)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
            THIS.this_cIdChaves = par_cIdChaves
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Atribui um icone ao programa (primeira selecao)
    * Faz REPLACE em crProg1/crProg2 com o icone selecionado + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atribuir " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Troca o icone atribuido ao programa
    * Faz REPLACE em crProg1/crProg2 com o novo icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.SelecionarIcone(THIS.this_cArqIcone, THIS.this_cIdChaves)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao atualizar " + CHR(237) + "cone"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o icone atribuido (barrapict = "")
    * Faz REPLACE em crProg1/crProg2 zerando o icone + audita.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cMensagemErro = "Chave do programa n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            IF USED("crProg1") AND SEEK(THIS.this_cIdChaves, "crProg1", "pkChaves")
                SELECT crProg1
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            IF USED("crProg2") AND SEEK(THIS.this_cIdChaves, "crProg2", "pkChaves")
                SELECT crProg2
                REPLACE barrapict WITH "", barraforms WITH ""
            ENDIF

            THIS.this_cArqIcone = ""
            THIS.RegistrarAuditoria("DELETE")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava a alteracao de icone em LogAuditoria
    * Override: escreve com Tabela="SIGPRCIC" (form nao mapeia tabela real)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario

        loc_cChave = THIS.ObterChavePrimaria()

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
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
    * BuscarIconeAtual - Le o icone atual do cursor crProg2 para o par_cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION BuscarIconeAtual(par_cIdChaves)
        LOCAL loc_cIcone
        loc_cIcone = ""

        TRY
            IF USED("crProg2") AND SEEK(par_cIdChaves, "crProg2", "pkChaves")
                IF !EMPTY(crProg2.barrapict)
                    loc_cIcone = PADR(LOWER(ALLTRIM(crProg2.barrapict)), 64)
                ENDIF
                THIS.this_cDescricao = TratarNulo(crProg2.descricaos, "C")
            ENDIF

            IF EMPTY(loc_cIcone) AND !EMPTY(par_cIdChaves)
                loc_cIcone = PADR(LOWER(ALLTRIM(JUSTFNAME(par_cIdChaves))), 64)
            ENDIF

            THIS.this_cArqIcone = loc_cIcone
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cIcone
    ENDPROC

ENDDEFINE

