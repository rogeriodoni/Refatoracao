# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterIconeSelecionadoNoGrid()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oPagina.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPagina.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH loc_oPagina.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPagina.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCIC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (815 linhas total):

*-- Linhas 40 a 153:
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
93:             THIS.TornarControlesVisiveis(THIS)
94:             THIS.LockScreen = .F.
95: 
96:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
97:                 THIS.CarregarDados()
98:             ENDIF
99: 
100:             loc_lSucesso = .T.
101: 
102:         CATCH TO loc_oErro
103:             THIS.LockScreen = .F.
104:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
105:         ENDTRY
106: 
107:         RETURN loc_lSucesso
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cntSombra do legado)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarCabecalho()
114:         LOCAL loc_oCab
115: 
116:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
117:         loc_oCab = THIS.cnt_4c_Cabecalho
118:         WITH loc_oCab
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126: 
127:             .AddObject("lbl_4c_Sombra", "Label")
128:             WITH .lbl_4c_Sombra
129:                 .AutoSize      = .F.
130:                 .Top           = 18
131:                 .Left          = 10
132:                 .Width         = loc_oCab.Width
133:                 .Height        = 40
134:                 .FontBold      = .T.
135:                 .FontName      = "Tahoma"
136:                 .FontSize      = 18
137:                 .FontUnderline = .F.
138:                 .WordWrap      = .T.
139:                 .Alignment     = 0
140:                 .BackStyle     = 0
141:                 .Caption       = "Escolha de " + CHR(237) + "cones"
142:                 .ForeColor     = RGB(0, 0, 0)
143:             ENDWITH
144: 
145:             .AddObject("lbl_4c_Titulo", "Label")
146:             WITH .lbl_4c_Titulo
147:                 .AutoSize  = .F.
148:                 .Top       = 17
149:                 .Left      = 10
150:                 .Width     = loc_oCab.Width
151:                 .Height    = 46
152:                 .FontBold  = .T.
153:                 .FontName  = "Tahoma"

*-- Linhas 165 a 248:
165:     * ConfigurarPageFrame - Constroi pgf_4c_Paginas com Page1 e Page2,
166:     * delegando a construcao dos controles a ConfigurarPaginaLista().
167:     *--------------------------------------------------------------------------
168:     PROTECTED PROCEDURE ConfigurarPageFrame()
169:         LOCAL loc_oPgf
170: 
171:         *-- Cria PageFrame que ocupa area abaixo do cabecalho
172:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
173:         loc_oPgf = THIS.pgf_4c_Paginas
174:         loc_oPgf.PageCount = 2
175:         loc_oPgf.ErasePage = .T.
176:         loc_oPgf.Top       = 80
177:         loc_oPgf.Left      = 0
178:         loc_oPgf.Width     = THIS.Width
179:         loc_oPgf.Height    = THIS.Height - 80
180:         loc_oPgf.TabIndex  = 1
181:         loc_oPgf.Tabs      = .F.
182: 
183:         loc_oPgf.Page1.Caption = "Lista"
184:         loc_oPgf.Page2.Caption = "Dados"
185: 
186:         *-- Constroi controles da Page1 (grid de icones + preview + campo Programa)
187:         THIS.ConfigurarPaginaLista()
188: 
189:         *-- Page2: dialog plano, sem campos adicionais no original
190:         THIS.ConfigurarPaginaDados()
191: 
192:         *-- Ativa Page1 por default (visao principal do dialog)
193:         loc_oPgf.Visible    = .T.
194:         loc_oPgf.ActivePage = 1
195:     ENDPROC
196: 
197:     *--------------------------------------------------------------------------
198:     * ConfigurarPaginaLista - Constroi todos os controles de Page1:
199:     *   - lbl_4c_Programa + txt_4c_Programa (campo programa, somente leitura)
200:     *   - shp_4c_Preview (borda decorativa ao redor do preview)
201:     *   - img_4c_Icone (imagem preview do icone selecionado)
202:     *   - grd_4c_Dados (lista de icones - mapeado de Grid1 do legado)
203:     *   - BINDEVENTs para navegacao no grid e selecao de icone
204:     *
205:     * Posicoes: PageFrame.Top=80; controles em coords relativas a Page1
206:     * (Top_original - 80). RecordSource definido em CarregarDados().
207:     *--------------------------------------------------------------------------
208:     PROTECTED PROCEDURE ConfigurarPaginaLista()
209:         LOCAL loc_oPagina, loc_oGrid
210: 
211:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
212: 
213:         *-- Label "Programa" (Say2 do legado: Top=86 -> 86-80=6)
214:         loc_oPagina.AddObject("lbl_4c_Programa", "Label")
215:         WITH loc_oPagina.lbl_4c_Programa
216:             .Caption   = "Programa"
217:             .Left      = 12
218:             .Top       = 6
219:             .AutoSize  = .T.
220:             .FontName  = "Tahoma"
221:             .FontSize  = 8
222:             .ForeColor = RGB(90, 90, 90)
223:             .BackStyle = 0
224:         ENDWITH
225: 
226:         *-- TextBox nome do programa - somente leitura (Text1 do legado: Top=103 -> 23)
227:         loc_oPagina.AddObject("txt_4c_Programa", "TextBox")
228:         WITH loc_oPagina.txt_4c_Programa
229:             .FontBold  = .T.
230:             .FontName  = "Tahoma"
231:             .FontSize  = 8
232:             .Height    = 24
233:             .Left      = 9
234:             .Top       = 23
235:             .Width     = 457
236:             .ForeColor = RGB(90, 90, 90)
237:             .ReadOnly  = .T.
238:             .Value     = ""
239:         ENDWITH
240: 
241:         *-- Shape - borda decorativa ao redor do preview (Shape1 do legado: Top=184 -> 104)
242:         loc_oPagina.AddObject("shp_4c_Preview", "Shape")
243:         WITH loc_oPagina.shp_4c_Preview
244:             .Top         = 104
245:             .Left        = 276
246:             .Height      = 169
247:             .Width       = 169
248:             .BackStyle   = 0

*-- Linhas 259 a 280:
259:             .Top     = 120
260:             .Width   = 156
261:         ENDWITH
262: 
263:         *-- Grid de icones (Grid1 do legado: Top=131 -> 51)
264:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
265:         loc_oGrid = loc_oPagina.grd_4c_Dados
266:         WITH loc_oGrid
267:             .ColumnCount       = 1
268:             .AllowHeaderSizing = .F.
269:             .AllowRowSizing    = .F.
270:             .DeleteMark        = .F.
271:             .RecordMark        = .F.
272:             .Height            = 345
273:             .Left              = 10
274:             .Top               = 51
275:             .Width             = 242
276:             .GridLineColor     = RGB(238, 238, 238)
277:             .ReadOnly          = .T.
278:             .ScrollBars        = 2
279:             .HeaderHeight      = 15
280:             .RowHeight         = 15

*-- Linhas 321 a 815:
321:             .Column1.Text1.BackColor   = RGB(255, 255, 255)
322:         ENDWITH
323: 
324:         *-- BINDEVENTs para navegacao no grid e selecao de icone
325:         BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdDadosAfterRowColChange")
326:         BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdDadosBeforeRowColChange")
327:         BINDEVENT(loc_oGrid, "Scrolled",           THIS, "GrdDadosScrolled")
328:         BINDEVENT(loc_oGrid.Column1.Text1, "DblClick",  THIS, "GrdDadosText1DblClick")
329:         BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress",  THIS, "GrdDadosText1KeyPress")
330:     ENDPROC
331: 
332:     *--------------------------------------------------------------------------
333:     * ConfigurarPaginaDados - Page2 nao possui controles no form original
334:     * SIGPRCIC e um dialog flat: todos os campos estao em Page1
335:     *--------------------------------------------------------------------------
336:     PROTECTED PROCEDURE ConfigurarPaginaDados()
337:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(240, 240, 240)
338:     ENDPROC
339: 
340:     *--------------------------------------------------------------------------
341:     * CarregarDados - Le o icone atual do programa via BO e posiciona o cursor
342:     * de icones no arquivo correspondente.
343:     *--------------------------------------------------------------------------
344:     PROTECTED PROCEDURE CarregarDados()
345:         LOCAL loc_lSucesso, loc_cArqIcone, loc_cArquivo, loc_oPagina, loc_oErro
346:         loc_lSucesso = .F.
347: 
348:         TRY
349:             loc_oPagina   = THIS.pgf_4c_Paginas.Page1
350:             loc_cArqIcone = THIS.this_oBusinessObject.BuscarIconeAtual(THIS.this_cIdChaves)
351: 
352:             *-- Popula campo Programa com descricao lida pelo BO (crProg2.descricaos)
353:             loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
354: 
355:             *-- Posiciona cursor de icones (aberto pelo form pai) no icone atual
356:             IF USED("crSigSyIco1")
357:                 SET ORDER TO ("carqicones") IN ("crSigSyIco1")
358: 
359:                 IF !SEEK(loc_cArqIcone, "crSigSyIco1", "carqicones")
360:                     SELECT crSigSyIco1
361:                     GO TOP
362:                 ENDIF
363: 
364:                 *-- Define RecordSource e ControlSource do grid apos posicionar cursor
365:                 WITH loc_oPagina.grd_4c_Dados
366:                     .Column1.ControlSource = "crSigSyIco1.carqicones"
367:                     .LinkMaster            = ""
368:                     .RelationalExpr        = ""
369:                     .RecordSource          = "crSigSyIco1"
370:                 ENDWITH
371: 
372:                 *-- Atualiza preview com o icone da linha inicial
373:                 loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
374:                 IF !EMPTY(loc_cArquivo)
375:                     loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
376:                     loc_oPagina.img_4c_Icone.Visible = .T.
377:                 ELSE
378:                     loc_oPagina.img_4c_Icone.Visible = .F.
379:                 ENDIF
380:             ENDIF
381: 
382:             loc_lSucesso = .T.
383: 
384:         CATCH TO loc_oErro
385:             MsgErro(loc_oErro.Message, "Erro CarregarDados")
386:         ENDTRY
387: 
388:         RETURN loc_lSucesso
389:     ENDPROC
390: 
391:     *--------------------------------------------------------------------------
392:     * TornarControlesVisiveis - Torna sub-controles visiveis apos AddObject
393:     * AddObject cria com Visible=.F.; percorre Controls + Pages recursivamente.
394:     *--------------------------------------------------------------------------
395:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
396:         LOCAL loc_nI, loc_oObjeto, loc_nP
397: 
398:         FOR loc_nI = 1 TO par_oContainer.ControlCount
399:             loc_oObjeto = par_oContainer.Controls(loc_nI)
400: 
401:             IF VARTYPE(loc_oObjeto) = "O"
402:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
403:                     loc_oObjeto.Visible = .T.
404:                 ENDIF
405: 
406:                 *-- Trata PageFrame - itera Pages
407:                 IF PEMSTATUS(loc_oObjeto, "PageCount", 5)
408:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
409:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
410:                     ENDFOR
411:                 ENDIF
412: 
413:                 *-- Trata containers - itera Controls
414:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
415:                     THIS.TornarControlesVisiveis(loc_oObjeto)
416:                 ENDIF
417:             ENDIF
418:         ENDFOR
419:     ENDPROC
420: 
421:     *--------------------------------------------------------------------------
422:     * AlternarPagina - Muda a pagina ativa do PageFrame
423:     *--------------------------------------------------------------------------
424:     PROCEDURE AlternarPagina(par_nPagina)
425:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
426:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
427:         ENDIF
428:     ENDPROC
429: 
430:     *--------------------------------------------------------------------------
431:     * AtualizarPreviewIcone - Atualiza img_4c_Icone com o icone da linha atual
432:     * Chamado pelos handlers de navegacao do grid.
433:     *--------------------------------------------------------------------------
434:     PROTECTED PROCEDURE AtualizarPreviewIcone()
435:         LOCAL loc_cArquivo, loc_oImagem
436: 
437:         IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
438:             RETURN
439:         ENDIF
440: 
441:         loc_oImagem  = THIS.pgf_4c_Paginas.Page1.img_4c_Icone
442:         loc_cArquivo = ALLTRIM(crSigSyIco1.ctmpicones)
443: 
444:         IF !EMPTY(loc_cArquivo)
445:             loc_oImagem.Picture = loc_cArquivo
446:             loc_oImagem.Visible = .T.
447:         ELSE
448:             loc_oImagem.Visible = .F.
449:         ENDIF
450:     ENDPROC
451: 
452:     *--------------------------------------------------------------------------
453:     * GrdDadosAfterRowColChange - Atualiza preview apos mover linha (BINDEVENT)
454:     *--------------------------------------------------------------------------
455:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
456:         THIS.AtualizarPreviewIcone()
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha (BINDEVENT)
461:     *--------------------------------------------------------------------------
462:     PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
463:         THIS.AtualizarPreviewIcone()
464:     ENDPROC
465: 
466:     *--------------------------------------------------------------------------
467:     * GrdDadosScrolled - Atualiza preview ao rolar o grid (BINDEVENT)
468:     *--------------------------------------------------------------------------
469:     PROCEDURE GrdDadosScrolled(par_nDirection)
470:         THIS.AtualizarPreviewIcone()
471:     ENDPROC
472: 
473:     *--------------------------------------------------------------------------
474:     * GrdDadosText1DblClick - Seleciona icone e fecha dialog (BINDEVENT)
475:     * Mapeado de Grid1.Column1.Text1.DblClick do legado.
476:     *--------------------------------------------------------------------------
477:     PROCEDURE GrdDadosText1DblClick()
478:         LOCAL loc_cArqIcone
479:         loc_cArqIcone = LOWER(ALLTRIM(THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Column1.Text1.Value))
480:         THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
481:         THIS.Release()
482:     ENDPROC
483: 
484:     *--------------------------------------------------------------------------
485:     * GrdDadosText1KeyPress - ENTER na celula aciona selecao (BINDEVENT)
486:     * Mapeado de Grid1.Column1.Text1.KeyPress do legado.
487:     *--------------------------------------------------------------------------
488:     PROCEDURE GrdDadosText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
489:         IF par_nKeyCode = 13
490:             THIS.GrdDadosText1DblClick()
491:         ENDIF
492:     ENDPROC
493: 
494:     *--------------------------------------------------------------------------
495:     * KeyPress - ESC fecha o dialog sem salvar
496:     *--------------------------------------------------------------------------
497:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
498:         IF par_nKeyCode = 27
499:             THIS.Release()
500:         ENDIF
501:     ENDPROC
502: 
503:     *--------------------------------------------------------------------------
504:     * ObterIconeSelecionadoNoGrid - Retorna nome do arquivo de icone da linha ativa
505:     * Lida com marcador "< nenhum >" transformando em string vazia.
506:     *--------------------------------------------------------------------------
507:     PROTECTED FUNCTION ObterIconeSelecionadoNoGrid()
508:         LOCAL loc_cArqIcone
509: 
510:         IF !USED("crSigSyIco1") OR EOF("crSigSyIco1")
511:             RETURN ""
512:         ENDIF
513: 
514:         loc_cArqIcone = LOWER(ALLTRIM(NVL(crSigSyIco1.carqicones, "")))
515:         IF loc_cArqIcone == "< nenhum >"
516:             loc_cArqIcone = ""
517:         ENDIF
518: 
519:         RETURN loc_cArqIcone
520:     ENDPROC
521: 
522:     *--------------------------------------------------------------------------
523:     * BtnIncluirClick - Atribui o icone selecionado ao programa
524:     * Le o icone da linha ativa do grid + chama BO.Inserir + fecha o dialog.
525:     * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando nao havia icone.
526:     *--------------------------------------------------------------------------
527:     PROCEDURE BtnIncluirClick()
528:         LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro
529: 
530:         TRY
531:             IF EMPTY(THIS.this_cIdChaves)
532:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
533:                 RETURN
534:             ENDIF
535: 
536:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
537: 
538:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
539:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
540: 
541:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
542: 
543:             IF loc_lSucesso
544:                 THIS.Release()
545:             ELSE
546:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
547:             ENDIF
548: 
549:         CATCH TO loc_oErro
550:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
551:         ENDTRY
552:     ENDPROC
553: 
554:     *--------------------------------------------------------------------------
555:     * BtnAlterarClick - Troca o icone atribuido ao programa
556:     * Le o icone da linha ativa do grid + chama BO.Atualizar + fecha o dialog.
557:     * Equivalente ao Grid1.Column1.Text1.DblClick do legado quando ja havia icone.
558:     *--------------------------------------------------------------------------
559:     PROCEDURE BtnAlterarClick()
560:         LOCAL loc_cArqIcone, loc_lSucesso, loc_oErro
561: 
562:         TRY
563:             IF EMPTY(THIS.this_cIdChaves)
564:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
565:                 RETURN
566:             ENDIF
567: 
568:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
569: 
570:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
571:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
572: 
573:             IF THIS.this_oBusinessObject.SelecionarIcone(loc_cArqIcone, THIS.this_cIdChaves)
574:                 THIS.Release()
575:             ELSE
576:                 MsgAviso("Falha ao atualizar " + CHR(237) + "cone.", "Aviso")
577:             ENDIF
578: 
579:         CATCH TO loc_oErro
580:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
581:         ENDTRY
582:     ENDPROC
583: 
584:     *--------------------------------------------------------------------------
585:     * BtnVisualizarClick - Atualiza preview do icone da linha ativa
586:     * Equivalente ao Grid1.AfterRowColChange do legado (que atualizava o preview).
587:     *--------------------------------------------------------------------------
588:     PROCEDURE BtnVisualizarClick()
589:         LOCAL loc_oErro
590: 
591:         TRY
592:             IF !USED("crSigSyIco1")
593:                 MsgAviso("Lista de " + CHR(237) + "cones n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
594:                 RETURN
595:             ENDIF
596: 
597:             THIS.AtualizarPreviewIcone()
598: 
599:         CATCH TO loc_oErro
600:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
601:         ENDTRY
602:     ENDPROC
603: 
604:     *--------------------------------------------------------------------------
605:     * BtnExcluirClick - Remove o icone atribuido ao programa
606:     * Chama BO.Excluir para zerar barrapict/barraforms em crProg1/crProg2 + fecha.
607:     *--------------------------------------------------------------------------
608:     PROCEDURE BtnExcluirClick()
609:         LOCAL loc_lConfirma, loc_lSucesso, loc_oErro
610: 
611:         TRY
612:             IF EMPTY(THIS.this_cIdChaves)
613:                 MsgAviso("Chave do programa n" + CHR(227) + "o informada.", "Aviso")
614:                 RETURN
615:             ENDIF
616: 
617:             loc_lConfirma = MsgConfirma("Confirma a remo" + CHR(231) + CHR(227) + "o do " + CHR(237) + "cone atribu" + CHR(237) + "do?", "Confirma" + CHR(231) + CHR(227) + "o")
618: 
619:             IF !loc_lConfirma
620:                 RETURN
621:             ENDIF
622: 
623:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
624:             loc_lSucesso = THIS.this_oBusinessObject.Excluir()
625: 
626:             IF loc_lSucesso
627:                 THIS.Release()
628:             ELSE
629:                 MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Aviso")
630:             ENDIF
631: 
632:         CATCH TO loc_oErro
633:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
634:         ENDTRY
635:     ENDPROC
636: 
637:     *--------------------------------------------------------------------------
638:     * CarregarLista - Reinicializa o grid com crSigSyIco1 e atualiza preview
639:     * Util para refresco apos mudanca de icone ou retorno ao dialog.
640:     *--------------------------------------------------------------------------
641:     PROCEDURE CarregarLista()
642:         LOCAL loc_lSucesso, loc_oPagina, loc_oErro
643:         loc_lSucesso = .F.
644: 
645:         TRY
646:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
647: 
648:             IF USED("crSigSyIco1")
649:                 WITH loc_oPagina.grd_4c_Dados
650:                     .Column1.ControlSource = "crSigSyIco1.carqicones"
651:                     .LinkMaster            = ""
652:                     .RelationalExpr        = ""
653:                     .RecordSource          = "crSigSyIco1"
654:                 ENDWITH
655:                 THIS.AtualizarPreviewIcone()
656:             ENDIF
657: 
658:             loc_lSucesso = .T.
659: 
660:         CATCH TO loc_oErro
661:             MsgErro(loc_oErro.Message, "Erro CarregarLista")
662:         ENDTRY
663: 
664:         RETURN loc_lSucesso
665:     ENDPROC
666: 
667:     *--------------------------------------------------------------------------
668:     * FormParaBO - Transfere o icone selecionado no grid para o BO
669:     *--------------------------------------------------------------------------
670:     PROTECTED PROCEDURE FormParaBO()
671:         LOCAL loc_cArqIcone
672: 
673:         TRY
674:             loc_cArqIcone = THIS.ObterIconeSelecionadoNoGrid()
675:             THIS.this_oBusinessObject.this_cIdChaves = THIS.this_cIdChaves
676:             THIS.this_oBusinessObject.this_cArqIcone = loc_cArqIcone
677:         CATCH TO loc_oErro
678:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
679:         ENDTRY
680:     ENDPROC
681: 
682:     *--------------------------------------------------------------------------
683:     * BOParaForm - Atualiza preview do form com o icone registrado no BO
684:     *--------------------------------------------------------------------------
685:     PROTECTED PROCEDURE BOParaForm()
686:         LOCAL loc_cArquivo, loc_oPagina, loc_oErro
687: 
688:         TRY
689:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
690:             loc_cArquivo = ALLTRIM(THIS.this_oBusinessObject.this_cArqIcone)
691: 
692:             IF !EMPTY(loc_cArquivo)
693:                 loc_oPagina.img_4c_Icone.Picture = loc_cArquivo
694:                 loc_oPagina.img_4c_Icone.Visible = .T.
695:             ELSE
696:                 loc_oPagina.img_4c_Icone.Visible = .F.
697:             ENDIF
698: 
699:             loc_oPagina.txt_4c_Programa.Value = THIS.this_oBusinessObject.this_cDescricao
700:         CATCH TO loc_oErro
701:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
702:         ENDTRY
703:     ENDPROC
704: 
705:     *--------------------------------------------------------------------------
706:     * HabilitarCampos - Neste dialog os campos sao sempre readonly (somente grid)
707:     * Implementado para compatibilidade com FormBase.
708:     *--------------------------------------------------------------------------
709:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
710:         LOCAL loc_oPagina
711: 
712:         IF PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
713:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
714:             IF PEMSTATUS(loc_oPagina, "txt_4c_Programa", 5)
715:                 loc_oPagina.txt_4c_Programa.ReadOnly = .T.
716:             ENDIF
717:             IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
718:                 loc_oPagina.grd_4c_Dados.ReadOnly = .T.
719:             ENDIF
720:         ENDIF
721:     ENDPROC
722: 
723:     *--------------------------------------------------------------------------
724:     * LimparCampos - Limpa o preview e o campo de programa
725:     *--------------------------------------------------------------------------
726:     PROTECTED PROCEDURE LimparCampos()
727:         LOCAL loc_oPagina, loc_oErro
728: 
729:         TRY
730:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
731:             loc_oPagina.img_4c_Icone.Visible = .F.
732:             loc_oPagina.img_4c_Icone.Picture = ""
733:             loc_oPagina.txt_4c_Programa.Value = ""
734:         CATCH TO loc_oErro
735:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
736:         ENDTRY
737:     ENDPROC
738: 
739:     *--------------------------------------------------------------------------
740:     * AjustarBotoesPorModo - Dialog plano sem modos CRUD; sem ajuste de botoes
741:     * Implementado para compatibilidade com FormBase.
742:     *--------------------------------------------------------------------------
743:     PROTECTED PROCEDURE AjustarBotoesPorModo()
744:         RETURN
745:     ENDPROC
746: 
747:     *--------------------------------------------------------------------------
748:     * BtnBuscarClick - Recarrega o grid de icones e posiciona no icone atual
749:     *--------------------------------------------------------------------------
750:     PROCEDURE BtnBuscarClick()
751:         LOCAL loc_oErro
752: 
753:         TRY
754:             THIS.CarregarDados()
755:         CATCH TO loc_oErro
756:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
757:         ENDTRY
758:     ENDPROC
759: 
760:     *--------------------------------------------------------------------------
761:     * BtnSalvarClick - Seleciona o icone da linha atual e fecha o dialog
762:     * Equivalente ao DblClick/ENTER no grid; usa FormParaBO antes de salvar.
763:     *--------------------------------------------------------------------------
764:     PROCEDURE BtnSalvarClick()
765:         LOCAL loc_lSucesso, loc_oErro
766: 
767:         TRY
768:             THIS.FormParaBO()
769:             loc_lSucesso = THIS.this_oBusinessObject.SelecionarIcone( ;
770:                 THIS.this_oBusinessObject.this_cArqIcone, ;
771:                 THIS.this_cIdChaves)
772: 
773:             IF loc_lSucesso
774:                 THIS.Release()
775:             ELSE
776:                 MsgAviso("Falha ao atribuir " + CHR(237) + "cone.", "Aviso")
777:             ENDIF
778: 
779:         CATCH TO loc_oErro
780:             MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
781:         ENDTRY
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     * BtnCancelarClick - Fecha o dialog sem salvar (mesmo comportamento do ESC)
786:     *--------------------------------------------------------------------------
787:     PROCEDURE BtnCancelarClick()
788:         THIS.Release()
789:     ENDPROC
790: 
791:     *--------------------------------------------------------------------------
792:     * BtnEncerrarClick - Fecha o dialog (alias de Cancelar para compatibilidade)
793:     *--------------------------------------------------------------------------
794:     PROCEDURE BtnEncerrarClick()
795:         THIS.Release()
796:     ENDPROC
797: 
798:     *--------------------------------------------------------------------------
799:     * Destroy - Libera Business Object e delega restante ao FormBase
800:     *--------------------------------------------------------------------------
801:     PROCEDURE Destroy()
802:         LOCAL loc_oErro
803: 
804:         TRY
805:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
806:                 THIS.this_oBusinessObject = .NULL.
807:             ENDIF
808:         CATCH TO loc_oErro
809:             *-- Ignorar erros no Destroy (form ja esta sendo liberado)
810:         ENDTRY
811: 
812:         DODEFAULT()
813:     ENDPROC
814: 
815: ENDDEFINE


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

