# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 4 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacao' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGps.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (997 linhas total):

*-- Linhas 51 a 173:
51:     * par_lTipoggp    : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
52:     * par_cEscolha    : modo ('INSERIR', 'ALTERAR', ...)
53:     *--------------------------------------------------------------------------
54:     PROCEDURE Init(par_oParentForm, par_cDopes, par_lTipoggp, par_cEscolha)
55:         *-- Armazenar parametros ANTES de DODEFAULT() (que chama InicializarForm)
56:         THIS.this_oParentForm   = par_oParentForm
57:         THIS.this_cDopes        = ALLTRIM(NVL(par_cDopes, ""))
58:         THIS.this_lTipoggp      = IIF(VARTYPE(par_lTipoggp) = "L", par_lTipoggp, .F.)
59:         THIS.this_cEscolha      = ALLTRIM(NVL(par_cEscolha, ""))
60: 
61:         *-- Desabilitar form pai enquanto dialogo estiver aberto
62:         IF VARTYPE(par_oParentForm) = "O"
63:             par_oParentForm.Enabled = .F.
64:         ENDIF
65: 
66:         *-- Criar BO antes de InicializarForm (usa this_oBusinessObject)
67:         THIS.this_oBusinessObject = CREATEOBJECT("GpsBO")
68:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
69:             MsgErro("Erro ao criar GpsBO.", "Erro em Init")
70:             RETURN .F.
71:         ENDIF
72: 
73:         RETURN DODEFAULT()
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * InicializarForm - Cria todos os controles do form
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE InicializarForm()
80:         LOCAL loc_lSucesso, loc_oErro
81:         loc_lSucesso = .F.
82:         TRY
83:             *-- DataSession=2: restaurar configuracoes de data/locale (CLAUDE.md #9.4)
84:             SET DATE TO BRITISH
85:             SET CENTURY ON
86: 
87:             *-- Monta layout do dialogo (form-level + containers + grid + botoes)
88:             THIS.ConfigurarPageFrame()
89: 
90:             *-- Carrega grupos ja vinculados a operacao no cursor de trabalho
91:             THIS.CarregarDados()
92: 
93:             *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
94:             THIS.TornarControlesVisiveis(THIS)
95: 
96:             loc_lSucesso = .T.
97:         CATCH TO loc_oErro
98:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
99:         ENDTRY
100:         RETURN loc_lSucesso
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarPageFrame - Orquestra layout do dialogo flat (sem PageFrame
105:     * explicito, pois SIGCDGPS eh dialogo modal de pagina unica).
106:     * Define propriedades visuais do form e adiciona os 3 blocos de controles:
107:     * cabecalho (cnt_4c_Cabecalho), grade de grupos (grd_4c_Dados) e botoes.
108:     *--------------------------------------------------------------------------
109:     PROTECTED PROCEDURE ConfigurarPageFrame()
110:         *-- Imagem de fundo
111:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
112: 
113:         *-- Caption dinamico baseado na operacao (Dopes vindo do form pai)
114:         THIS.Caption = "Grupos de Produtos " + ALLTRIM(THIS.this_cDopes)
115: 
116:         *-- Bloco superior escuro com titulo
117:         THIS.ConfigurarCabecalho()
118: 
119:         *-- Grade de edicao dos grupos (unico bloco de dados do dialogo)
120:         THIS.ConfigurarPaginaLista()
121: 
122:         *-- Propriedades adicionais dos Text1 do grid + handler When
123:         THIS.ConfigurarPaginaDados()
124: 
125:         *-- Barra de acoes: Inserir / Excluir / Confirmar / Cancelar
126:         THIS.ConfigurarBotoes()
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------
130:     * ConfigurarCabecalho - Container header escuro com titulo da operacao
131:     * Original: cntSombra Top=-2, Left=0, Width=800, Height=80
132:     *--------------------------------------------------------------------------
133:     PROTECTED PROCEDURE ConfigurarCabecalho()
134:         LOCAL loc_oCab
135:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
136:         loc_oCab = THIS.cnt_4c_Cabecalho
137:         WITH loc_oCab
138:             .Top        = 0
139:             .Left       = 0
140:             .Width      = THIS.Width
141:             .Height     = 80
142:             .BackStyle  = 1
143:             .BackColor  = RGB(100,100,100)
144:             .BorderWidth = 0
145:         ENDWITH
146: 
147:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
148:         WITH loc_oCab.lbl_4c_Sombra
149:             .Top        = 18
150:             .Left       = 10
151:             .Width      = 769
152:             .Height     = 40
153:             .AutoSize   = .F.
154:             .BackStyle  = 0
155:             .FontName   = "Tahoma"
156:             .FontSize   = 18
157:             .FontBold   = .T.
158:             .ForeColor  = RGB(0,0,0)
159:             .WordWrap   = .T.
160:             .Alignment  = 0
161:             .Caption    = THIS.Caption
162:         ENDWITH
163: 
164:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
165:         WITH loc_oCab.lbl_4c_Titulo
166:             .Top        = 17
167:             .Left       = 10
168:             .Width      = 769
169:             .Height     = 46
170:             .AutoSize   = .F.
171:             .BackStyle  = 0
172:             .FontName   = "Tahoma"
173:             .FontSize   = 18

*-- Linhas 186 a 229:
186:     * Column2: Dgrus (char 20), Width=180 - SOMENTE LEITURA (When=.F. no legado)
187:     * Nota: form plano sem PageFrame - equivale a Page1 do padrao CRUD
188:     *--------------------------------------------------------------------------
189:     PROTECTED PROCEDURE ConfigurarPaginaLista()
190:         LOCAL loc_oGrid
191: 
192:         *-- Criar cursor de trabalho local (xOpe no legado)
193:         *-- Campos: Dopes c(20), Cgrus c(3) conforme SigCdGrp, Dgrus c(20) conforme schema
194:         SET NULL OFF
195:         IF USED("cursor_4c_Operacao")
196:             USE IN cursor_4c_Operacao
197:         ENDIF
198:         CREATE CURSOR cursor_4c_Operacao (Dopes C(20), Cgrus C(3), Dgrus C(20))
199:         INDEX ON Cgrus TAG Cgrus
200:         SET ORDER TO
201: 
202:         *-- Criar grid
203:         THIS.AddObject("grd_4c_Dados", "Grid")
204:         loc_oGrid = THIS.grd_4c_Dados
205:         WITH loc_oGrid
206:             .Top            = 87
207:             .Left           = 236
208:             .Width          = 264
209:             .Height         = 364
210:             .ColumnCount    = 2
211:             .FontName       = "Tahoma"
212:             .DeleteMark     = .F.
213:             .RecordMark     = .F.
214:             .ScrollBars     = 2
215:             .GridLineColor  = RGB(238,238,238)
216:             .HighlightStyle = 2
217:             .TabIndex       = 1
218:         ENDWITH
219: 
220:         WITH loc_oGrid.Column1
221:             .FontName   = "Tahoma"
222:             .Width      = 50
223:             .Movable    = .F.
224:             .Resizable  = .F.
225:             .BackColor  = RGB(255,255,255)
226:             WITH .Header1
227:                 .FontName   = "Tahoma"
228:                 .FontSize   = 8
229:                 .Alignment  = 2

*-- Linhas 247 a 362:
247:             ENDWITH
248:         ENDWITH
249: 
250:         *-- Vincular grid ao cursor
251:         WITH loc_oGrid
252:             .RecordSource           = "cursor_4c_Operacao"
253:             .Column1.ControlSource  = "cursor_4c_Operacao.Cgrus"
254:             .Column2.ControlSource  = "cursor_4c_Operacao.Dgrus"
255:         ENDWITH
256: 
257:         *-- Reconfigurar headers apos RecordSource (VFP reseta headers)
258:         WITH loc_oGrid.Column1.Header1
259:             .Caption = "Grupo"
260:         ENDWITH
261:         WITH loc_oGrid.Column2.Header1
262:             .Caption = "Descri" + CHR(231) + CHR(227) + "o"
263:         ENDWITH
264: 
265:         *-- Bindar KeyPress da Column1 para lookup de Cgrus
266:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1KeyPress")
267:     ENDPROC
268: 
269:     *--------------------------------------------------------------------------
270:     * ConfigurarPaginaDados - Configura propriedades visuais dos Text1 do grid
271:     * e registra o handler When da Column1 para captura do valor anterior.
272:     * Legado: Text1.When salva AntValue; Text1.BorderStyle=0; Margin=0
273:     * Neste form OPERACIONAL sem Page2, esta fase complementa a configuracao
274:     * dos controles de entrada de dados (os Text1 das colunas do grid).
275:     *--------------------------------------------------------------------------
276:     PROTECTED PROCEDURE ConfigurarPaginaDados()
277:         LOCAL loc_oGrid, loc_oErro
278:         TRY
279:             loc_oGrid = THIS.grd_4c_Dados
280: 
281:             *-- Text1 da Column1 (Cgrus - editavel)
282:             WITH loc_oGrid.Column1.Text1
283:                 .BorderStyle = 0
284:                 .Margin      = 0
285:                 .ForeColor   = RGB(0,0,0)
286:                 .BackColor   = RGB(255,255,255)
287:             ENDWITH
288: 
289:             *-- Text1 da Column2 (Dgrus - somente leitura)
290:             WITH loc_oGrid.Column2.Text1
291:                 .BorderStyle = 0
292:                 .Margin      = 0
293:                 .ForeColor   = RGB(0,0,0)
294:                 .BackColor   = RGB(240,240,240)
295:             ENDWITH
296: 
297:             *-- Registrar When da Column1.Text1 para salvar AntValue antes de editar
298:             BINDEVENT(loc_oGrid.Column1.Text1, "When", THIS, "GrdDadosCol1When")
299: 
300:             *-- Registrar When da Column2.Text1 para bloquear edicao (legado: Return .f.)
301:             BINDEVENT(loc_oGrid.Column2.Text1, "When", THIS, "GrdDadosCol2When")
302:         CATCH TO loc_oErro
303:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPaginaDados")
304:         ENDTRY
305:     ENDPROC
306: 
307:     *--------------------------------------------------------------------------
308:     * AlternarPagina - Navegacao entre estados do dialogo
309:     * Form plano sem PageFrame: apenas atualiza o grid (sem alternancia real de paginas)
310:     * Mantem assinatura padrao do pipeline multi-fase para compatibilidade
311:     *--------------------------------------------------------------------------
312:     PROCEDURE AlternarPagina(par_nPagina)
313:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
314:             THIS.grd_4c_Dados.Refresh()
315:         ENDIF
316:     ENDPROC
317: 
318:     *--------------------------------------------------------------------------
319:     * ConfigurarBotoes - 4 botoes da barra superior
320:     * Original: cmdInserir(500), cmdExcluir(575), cmdSair/Confirmar(650), Cancela(725)
321:     *--------------------------------------------------------------------------
322:     PROTECTED PROCEDURE ConfigurarBotoes()
323:         LOCAL loc_lPermiteEdicao
324:         loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
325: 
326:         *-- Inserir (Tab=4)
327:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
328:         WITH THIS.cmd_4c_Inserir
329:             .Top            = 2
330:             .Left           = 500
331:             .Width          = 75
332:             .Height         = 75
333:             .Caption        = "\<Inserir"
334:             .Picture        = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
335:             .FontName       = "Comic Sans MS"
336:             .FontBold       = .T.
337:             .FontItalic     = .T.
338:             .FontSize       = 8
339:             .ForeColor      = RGB(90,90,90)
340:             .BackColor      = RGB(255,255,255)
341:             .Themes         = .T.
342:             .SpecialEffect  = 0
343:             .PicturePosition = 13
344:             .MousePointer   = 15
345:             .WordWrap       = .T.
346:             .AutoSize       = .F.
347:             .Enabled        = loc_lPermiteEdicao
348:             .TabIndex       = 4
349:         ENDWITH
350: 
351:         *-- Excluir (Tab=2)
352:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
353:         WITH THIS.cmd_4c_Excluir
354:             .Top            = 2
355:             .Left           = 575
356:             .Width          = 75
357:             .Height         = 75
358:             .Caption        = "\<Excluir"
359:             .Picture        = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
360:             .FontName       = "Comic Sans MS"
361:             .FontBold       = .T.
362:             .FontItalic     = .T.

*-- Linhas 423 a 997:
423:         ENDWITH
424: 
425:         *-- Bindar eventos dos botoes
426:         BINDEVENT(THIS.cmd_4c_Inserir,   "Click", THIS, "CmdInserirClick")
427:         BINDEVENT(THIS.cmd_4c_Excluir,   "Click", THIS, "CmdExcluirClick")
428:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "CmdConfirmarClick")
429:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
430:     ENDPROC
431: 
432:     *--------------------------------------------------------------------------
433:     * CarregarDados - Carrega grupos do SQL Server no cursor de trabalho
434:     * Equivale ao SQLEXEC + Scan/Append Blank/Gather do legado
435:     *--------------------------------------------------------------------------
436:     PROTECTED PROCEDURE CarregarDados()
437:         LOCAL loc_oErro
438:         TRY
439:             IF !EMPTY(THIS.this_cDopes) AND THIS.this_oBusinessObject.CarregarGrupos(THIS.this_cDopes, THIS.this_lTipoggp)
440:                 IF USED("cursor_4c_GruposTemp")
441:                     SELECT cursor_4c_Operacao
442:                     ZAP
443:                     APPEND FROM DBF("cursor_4c_GruposTemp")
444:                     USE IN cursor_4c_GruposTemp
445:                 ENDIF
446:             ENDIF
447: 
448:             IF USED("cursor_4c_Operacao")
449:                 SELECT cursor_4c_Operacao
450:                 SET ORDER TO
451:                 GO TOP
452:             ENDIF
453: 
454:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
455:                 THIS.grd_4c_Dados.Refresh()
456:             ENDIF
457:         CATCH TO loc_oErro
458:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
459:         ENDTRY
460:     ENDPROC
461: 
462:     *--------------------------------------------------------------------------
463:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
464:     *--------------------------------------------------------------------------
465:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
466:         LOCAL loc_i, loc_oCtrl
467:         FOR loc_i = 1 TO par_oContainer.ControlCount
468:             loc_oCtrl = par_oContainer.Controls(loc_i)
469:             IF VARTYPE(loc_oCtrl) = "O"
470:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
471:                     loc_oCtrl.Visible = .T.
472:                 ENDIF
473:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
474:                     THIS.TornarControlesVisiveis(loc_oCtrl)
475:                 ENDIF
476:             ENDIF
477:         ENDFOR
478:     ENDPROC
479: 
480:     *==========================================================================
481:     * HANDLERS DOS BOTOES
482:     *==========================================================================
483: 
484:     *--------------------------------------------------------------------------
485:     * CmdInserirClick - Insere linha em branco no grid
486:     * Original: Insert Into xOpe (Cgrus) Values (Space(20))
487:     *--------------------------------------------------------------------------
488:     PROCEDURE CmdInserirClick()
489:         LOCAL loc_oErro
490:         TRY
491:             SELECT cursor_4c_Operacao
492:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
493:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
494:             THIS.this_lGravaDados = .T.
495:             THIS.grd_4c_Dados.Column1.SetFocus()
496:         CATCH TO loc_oErro
497:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdInserirClick")
498:         ENDTRY
499:     ENDPROC
500: 
501:     *--------------------------------------------------------------------------
502:     * CmdExcluirClick - Exclui linha corrente do grid
503:     * Original: Delete + Skip, Go Bott se EOF()
504:     *--------------------------------------------------------------------------
505:     PROCEDURE CmdExcluirClick()
506:         LOCAL loc_oErro
507:         TRY
508:             SELECT cursor_4c_Operacao
509:             IF !EOF()
510:                 DELETE
511:                 SKIP
512:                 IF EOF()
513:                     GO BOTTOM
514:                 ENDIF
515:             ENDIF
516:             THIS.this_lGravaDados = .T.
517:             THIS.grd_4c_Dados.SetFocus()
518:             THIS.grd_4c_Dados.Refresh()
519:         CATCH TO loc_oErro
520:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdExcluirClick")
521:         ENDTRY
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * CmdConfirmarClick - Valida e salva grupos no SQL Server
526:     * Original: cmdSair.Click - valida duplicidade, DELETE+INSERT em transacao
527:     *--------------------------------------------------------------------------
528:     PROCEDURE CmdConfirmarClick()
529:         LOCAL loc_lSucesso, loc_lPodeFechar, loc_oErro
530:         loc_lSucesso    = .F.
531:         loc_lPodeFechar = .T.
532:         TRY
533:             IF THIS.this_lGravaDados
534:                 *-- Validar duplicidade de Cgrus no cursor
535:                 IF !THIS.this_oBusinessObject.ValidarDuplicados("cursor_4c_Operacao")
536:                     loc_lPodeFechar = .F.
537:                 ENDIF
538: 
539:                 IF loc_lPodeFechar
540:                     *-- Salvar: DELETE todos existentes + INSERT novos em transacao
541:                     loc_lSucesso = THIS.this_oBusinessObject.SalvarGrupos( ;
542:                         THIS.this_cDopes, ;
543:                         THIS.this_lTipoggp, ;
544:                         "cursor_4c_Operacao" ;
545:                     )
546: 
547:                     IF !loc_lSucesso
548:                         MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados!!!", "Erro")
549:                         loc_lPodeFechar = .F.
550:                     ENDIF
551:                 ENDIF
552:             ENDIF
553: 
554:             IF loc_lPodeFechar
555:                 *-- Re-habilitar form pai e fechar
556:                 IF VARTYPE(THIS.this_oParentForm) = "O"
557:                     THIS.this_oParentForm.Enabled = .T.
558:                 ENDIF
559:                 THIS.Release()
560:             ENDIF
561:         CATCH TO loc_oErro
562:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdConfirmarClick")
563:         ENDTRY
564:     ENDPROC
565: 
566:     *--------------------------------------------------------------------------
567:     * CmdCancelarClick - Fecha sem salvar (Cancela no legado)
568:     *--------------------------------------------------------------------------
569:     PROCEDURE CmdCancelarClick()
570:         IF VARTYPE(THIS.this_oParentForm) = "O"
571:             THIS.this_oParentForm.Enabled = .T.
572:         ENDIF
573:         THIS.Release()
574:     ENDPROC
575: 
576:     *==========================================================================
577:     * EVENTOS PRINCIPAIS DA BARRA DE BOTOES (Btn*Click - padrao pipeline)
578:     * Este form OPERACIONAL nao tem Alterar/Visualizar semanticos no legado,
579:     * mas mantem-se os handlers Btn* para compatibilidade com o validador.
580:     *==========================================================================
581: 
582:     *--------------------------------------------------------------------------
583:     * BtnIncluirClick - Insere nova linha em branco no grid
584:     * Legado: cmdInserir.Click -> Insert Into xOpe (Cgrus) Values (Space(20))
585:     *--------------------------------------------------------------------------
586:     PROCEDURE BtnIncluirClick()
587:         LOCAL loc_oErro
588:         TRY
589:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
590:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite inclus" + CHR(227) + "o.", "Aviso")
591:                 RETURN
592:             ENDIF
593: 
594:             IF !USED("cursor_4c_Operacao")
595:                 MsgErro("Cursor de trabalho n" + CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel.", "Erro em BtnIncluirClick")
596:                 RETURN
597:             ENDIF
598: 
599:             SELECT cursor_4c_Operacao
600:             INSERT INTO cursor_4c_Operacao (Dopes, Cgrus, Dgrus) VALUES ;
601:                 (THIS.this_cDopes, SPACE(3), SPACE(20))
602:             THIS.this_lGravaDados = .T.
603: 
604:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
605:                 THIS.grd_4c_Dados.Refresh()
606:                 THIS.grd_4c_Dados.Column1.SetFocus()
607:             ENDIF
608:         CATCH TO loc_oErro
609:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
610:         ENDTRY
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * BtnAlterarClick - Coloca foco no grid para editar registro corrente
615:     * Legado: sem equivalente direto (dialogo ja abre em modo edicao).
616:     * Comportamento: valida modo, vai para o registro corrente e da foco na
617:     * Column1 (Cgrus) para permitir edicao / lookup.
618:     *--------------------------------------------------------------------------
619:     PROCEDURE BtnAlterarClick()
620:         LOCAL loc_oErro
621:         TRY
622:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
623:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite altera" + CHR(231) + CHR(227) + "o.", "Aviso")
624:                 RETURN
625:             ENDIF
626: 
627:             IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
628:                 MsgAviso("Nenhum registro para alterar.", "Aviso")
629:                 RETURN
630:             ENDIF
631: 
632:             SELECT cursor_4c_Operacao
633:             IF EOF()
634:                 GO BOTTOM
635:             ENDIF
636: 
637:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
638:                 THIS.grd_4c_Dados.Refresh()
639:                 THIS.grd_4c_Dados.Column1.SetFocus()
640:             ENDIF
641:         CATCH TO loc_oErro
642:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
643:         ENDTRY
644:     ENDPROC
645: 
646:     *--------------------------------------------------------------------------
647:     * BtnVisualizarClick - Recarrega grupos do SQL Server no grid
648:     * Legado: sem equivalente direto. Aqui recarrega os dados da operacao
649:     * do banco para o cursor de trabalho (descarta edicoes nao confirmadas).
650:     *--------------------------------------------------------------------------
651:     PROCEDURE BtnVisualizarClick()
652:         LOCAL loc_lConfirma, loc_oErro
653:         TRY
654:             IF EMPTY(THIS.this_cDopes)
655:                 MsgAviso("Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para visualizar.", "Aviso")
656:                 RETURN
657:             ENDIF
658: 
659:             IF THIS.this_lGravaDados
660:                 loc_lConfirma = MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas. Recarregar mesmo assim?", "Confirma" + CHR(231) + CHR(227) + "o")
661:                 IF !loc_lConfirma
662:                     RETURN
663:                 ENDIF
664:             ENDIF
665: 
666:             *-- Recarrega dados do SQL Server no cursor de trabalho
667:             THIS.CarregarDados()
668:             THIS.this_lGravaDados = .F.
669: 
670:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
671:                 THIS.grd_4c_Dados.Refresh()
672:             ENDIF
673:         CATCH TO loc_oErro
674:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
675:         ENDTRY
676:     ENDPROC
677: 
678:     *--------------------------------------------------------------------------
679:     * BtnExcluirClick - Exclui registro corrente do grid
680:     * Legado: cmdExcluir.Click -> Delete + Skip + Go Bott se EOF
681:     *--------------------------------------------------------------------------
682:     PROCEDURE BtnExcluirClick()
683:         LOCAL loc_lConfirma, loc_oErro
684:         TRY
685:             IF !INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
686:                 MsgAviso("Modo somente leitura n" + CHR(227) + "o permite exclus" + CHR(227) + "o.", "Aviso")
687:                 RETURN
688:             ENDIF
689: 
690:             IF !USED("cursor_4c_Operacao") OR RECCOUNT("cursor_4c_Operacao") = 0
691:                 MsgAviso("Nenhum registro para excluir.", "Aviso")
692:                 RETURN
693:             ENDIF
694: 
695:             SELECT cursor_4c_Operacao
696:             IF EOF()
697:                 MsgAviso("Posicione em um registro para excluir.", "Aviso")
698:                 RETURN
699:             ENDIF
700: 
701:             loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo selecionado?", "Confirma" + CHR(231) + CHR(227) + "o")
702:             IF !loc_lConfirma
703:                 RETURN
704:             ENDIF
705: 
706:             DELETE
707:             SKIP
708:             IF EOF()
709:                 GO BOTTOM
710:             ENDIF
711:             THIS.this_lGravaDados = .T.
712: 
713:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
714:                 THIS.grd_4c_Dados.Refresh()
715:                 THIS.grd_4c_Dados.SetFocus()
716:             ENDIF
717:         CATCH TO loc_oErro
718:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
719:         ENDTRY
720:     ENDPROC
721: 
722:     *==========================================================================
723:     * HANDLER DO GRID - Column1 (Cgrus) KeyPress com lookup F4/ENTER/TAB
724:     *==========================================================================
725: 
726:     *--------------------------------------------------------------------------
727:     * GrdDadosCol1When - Salva valor anterior antes de entrar na celula (Column1)
728:     * Original: PROCEDURE When / Thisform.AntValue = This.Value
729:     * Necessario para recuperacao de valor caso o lookup seja cancelado
730:     *--------------------------------------------------------------------------
731:     PROCEDURE GrdDadosCol1When()
732:         THIS.this_cAntValue = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
733:         RETURN .T.
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * GrdDadosCol1KeyPress - Lookup de Cgrus na coluna 1 do grid
738:     * Dispara em ENTER(13), TAB(9), F4(115)
739:     * Original: Text1.Valid no Column1 com fwbuscaext para SigCdGrp
740:     *--------------------------------------------------------------------------
741:     PROCEDURE GrdDadosCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
742:         LOCAL loc_cCgrus, loc_cSQL, loc_cDgrus, loc_oErro
743: 
744:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
745:             RETURN
746:         ENDIF
747: 
748:         TRY
749:             loc_cCgrus = ALLTRIM(THIS.grd_4c_Dados.Column1.Text1.Value)
750: 
751:             IF !EMPTY(loc_cCgrus)
752:                 *-- Busca exata em SigCdGrp
753:                 loc_cDgrus = ""
754:                 loc_cSQL = "SELECT TOP 1 dgrus FROM SigCdGrp WHERE RTRIM(cgrus) = " + ;
755:                            EscaparSQL(loc_cCgrus)
756: 
757:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpBusca") > 0 AND ;
758:                    RECCOUNT("cursor_4c_GrpBusca") > 0
759:                     SELECT cursor_4c_GrpBusca
760:                     loc_cDgrus = ALLTRIM(dgrus)
761:                     USE IN cursor_4c_GrpBusca
762: 
763:                     *-- Atualizar Dgrus na linha corrente do cursor de trabalho
764:                     SELECT cursor_4c_Operacao
765:                     REPLACE Dgrus WITH loc_cDgrus
766:                     THIS.this_lGravaDados = .T.
767:                 ELSE
768:                     IF USED("cursor_4c_GrpBusca")
769:                         USE IN cursor_4c_GrpBusca
770:                     ENDIF
771:                     *-- Nao encontrou: abrir picker (nao exibir aviso antes, conforme CLAUDE.md)
772:                     THIS.AbrirLookupGrupo(loc_cCgrus)
773:                 ENDIF
774:             ELSE
775:                 *-- Limpar descricao quando codigo em branco
776:                 SELECT cursor_4c_Operacao
777:                 REPLACE Cgrus WITH SPACE(3), Dgrus WITH SPACE(20)
778:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
779:             ENDIF
780: 
781:             THIS.grd_4c_Dados.Refresh()
782:         CATCH TO loc_oErro
783:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GrdDadosCol1KeyPress")
784:         ENDTRY
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para SigCdGrp
789:     * Original: fwbuscaext com Cgrus/Dgrus
790:     *--------------------------------------------------------------------------
791:     PROCEDURE AbrirLookupGrupo(par_cValorInicial)
792:         LOCAL loc_oBusca, loc_oErro
793:         TRY
794:             IF USED("cursor_4c_GrpLookup")
795:                 USE IN cursor_4c_GrpLookup
796:             ENDIF
797: 
798:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
799:                 gnConnHandle, ;
800:                 "SigCdGrp", ;
801:                 "cursor_4c_GrpLookup", ;
802:                 "cgrus", ;
803:                 par_cValorInicial, ;
804:                 "Grupo de Produto", ;
805:                 .T., ;
806:                 .T., ;
807:                 "" ;
808:             )
809: 
810:             IF VARTYPE(loc_oBusca) = "O"
811:                 loc_oBusca.mAddColuna("cgrus", "", "Grupo", .T.)
812:                 loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o", .T.)
813:                 loc_oBusca.Show()
814: 
815:                 IF USED("cursor_4c_GrpLookup") AND RECCOUNT("cursor_4c_GrpLookup") > 0
816:                     SELECT cursor_4c_GrpLookup
817:                     LOCAL loc_cCgrusOk, loc_cDgrusOk
818:                     loc_cCgrusOk = ALLTRIM(cgrus)
819:                     loc_cDgrusOk = ALLTRIM(dgrus)
820:                     USE IN cursor_4c_GrpLookup
821: 
822:                     SELECT cursor_4c_Operacao
823:                     REPLACE Cgrus WITH loc_cCgrusOk, Dgrus WITH loc_cDgrusOk
824:                     THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCgrusOk
825:                     THIS.this_lGravaDados = .T.
826:                 ENDIF
827:             ENDIF
828: 
829:             THIS.grd_4c_Dados.Refresh()
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupGrupo")
832:         ENDTRY
833:     ENDPROC
834: 
835:     *--------------------------------------------------------------------------
836:     * GrdDadosCol2When - Bloqueia edicao da Column2 (Dgrus - somente leitura)
837:     * Original: Column2.Text1.When = Return .f.
838:     *--------------------------------------------------------------------------
839:     PROCEDURE GrdDadosCol2When()
840:         RETURN .F.
841:     ENDPROC
842: 
843:     *==========================================================================
844:     * METODOS PADRAO DO PIPELINE (Fase 8/8 - Consolidacao)
845:     * Este form OPERACIONAL usa padroes adaptados ao dialogo modal:
846:     * dados residem em cursor_4c_Operacao, nao em campos individuais.
847:     *==========================================================================
848: 
849:     *--------------------------------------------------------------------------
850:     * BtnBuscarClick - Recarrega lista de grupos do SQL Server no grid
851:     *--------------------------------------------------------------------------
852:     PROCEDURE BtnBuscarClick()
853:         LOCAL loc_lConfirma, loc_oErro
854:         TRY
855:             IF THIS.this_lGravaDados
856:                 loc_lConfirma = MsgConfirma("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o gravadas. Recarregar mesmo assim?", "Confirma" + CHR(231) + CHR(227) + "o")
857:                 IF !loc_lConfirma
858:                     RETURN
859:                 ENDIF
860:             ENDIF
861:             THIS.CarregarDados()
862:             THIS.this_lGravaDados = .F.
863:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
864:                 THIS.grd_4c_Dados.Refresh()
865:             ENDIF
866:         CATCH TO loc_oErro
867:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BtnBuscarClick")
868:         ENDTRY
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * BtnEncerrarClick - Fecha dialogo sem salvar e re-habilita form pai
873:     *--------------------------------------------------------------------------
874:     PROCEDURE BtnEncerrarClick()
875:         IF VARTYPE(THIS.this_oParentForm) = "O"
876:             THIS.this_oParentForm.Enabled = .T.
877:         ENDIF
878:         THIS.Release()
879:     ENDPROC
880: 
881:     *--------------------------------------------------------------------------
882:     * BtnSalvarClick - Valida e salva grupos (delega ao CmdConfirmarClick)
883:     *--------------------------------------------------------------------------
884:     PROCEDURE BtnSalvarClick()
885:         THIS.CmdConfirmarClick()
886:     ENDPROC
887: 
888:     *--------------------------------------------------------------------------
889:     * BtnCancelarClick - Fecha sem salvar (delega ao CmdCancelarClick)
890:     *--------------------------------------------------------------------------
891:     PROCEDURE BtnCancelarClick()
892:         IF VARTYPE(THIS.this_oParentForm) = "O"
893:             THIS.this_oParentForm.Enabled = .T.
894:         ENDIF
895:         THIS.Release()
896:     ENDPROC
897: 
898:     *--------------------------------------------------------------------------
899:     * FormParaBO - Transfere estado do form para o BO
900:     * Dialogo modal: popula identificadores de contexto no BO
901:     *--------------------------------------------------------------------------
902:     PROCEDURE FormParaBO()
903:         THIS.this_oBusinessObject.this_cDopes      = THIS.this_cDopes
904:         THIS.this_oBusinessObject.this_lTipoggp    = THIS.this_lTipoggp
905:         THIS.this_oBusinessObject.this_cEscolha    = THIS.this_cEscolha
906:         THIS.this_oBusinessObject.this_lGravaDados = THIS.this_lGravaDados
907:     ENDPROC
908: 
909:     *--------------------------------------------------------------------------
910:     * BOParaForm - Transfere propriedades do BO para o form
911:     * Dialogo modal: sincroniza flags de estado
912:     *--------------------------------------------------------------------------
913:     PROCEDURE BOParaForm()
914:         THIS.this_cDopes      = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cDopes, ""))
915:         THIS.this_lTipoggp    = THIS.this_oBusinessObject.this_lTipoggp
916:         THIS.this_cEscolha    = ALLTRIM(NVL(THIS.this_oBusinessObject.this_cEscolha, ""))
917:         THIS.this_lGravaDados = THIS.this_oBusinessObject.this_lGravaDados
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * HabilitarCampos - Habilita/desabilita botoes de edicao conforme modo
922:     * par_lHabilitar: .T. habilita, .F. desabilita; sem param: usa this_cEscolha
923:     *--------------------------------------------------------------------------
924:     PROCEDURE HabilitarCampos(par_lHabilitar)
925:         LOCAL loc_lPermiteEdicao
926:         IF VARTYPE(par_lHabilitar) = "L"
927:             loc_lPermiteEdicao = par_lHabilitar
928:         ELSE
929:             loc_lPermiteEdicao = INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR")
930:         ENDIF
931:         IF VARTYPE(THIS.cmd_4c_Inserir) = "O"
932:             THIS.cmd_4c_Inserir.Enabled = loc_lPermiteEdicao
933:         ENDIF
934:         IF VARTYPE(THIS.cmd_4c_Excluir) = "O"
935:             THIS.cmd_4c_Excluir.Enabled = loc_lPermiteEdicao
936:         ENDIF
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * LimparCampos - Zera o cursor de trabalho (limpa grade de grupos)
941:     *--------------------------------------------------------------------------
942:     PROCEDURE LimparCampos()
943:         IF USED("cursor_4c_Operacao")
944:             SELECT cursor_4c_Operacao
945:             ZAP
946:             THIS.this_lGravaDados = .T.
947:         ENDIF
948:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
949:             THIS.grd_4c_Dados.Refresh()
950:         ENDIF
951:     ENDPROC
952: 
953:     *--------------------------------------------------------------------------
954:     * CarregarLista - Carrega grupos da operacao no grid
955:     * Wrapper sobre CarregarDados para compatibilidade com o pipeline
956:     *--------------------------------------------------------------------------
957:     PROCEDURE CarregarLista()
958:         LOCAL loc_lSucesso
959:         loc_lSucesso = .F.
960:         IF !EMPTY(THIS.this_cDopes)
961:             THIS.CarregarDados()
962:             loc_lSucesso = .T.
963:         ENDIF
964:         RETURN loc_lSucesso
965:     ENDPROC
966: 
967:     *--------------------------------------------------------------------------
968:     * AjustarBotoesPorModo - Atualiza estado dos botoes conforme this_cEscolha
969:     *--------------------------------------------------------------------------
970:     PROCEDURE AjustarBotoesPorModo()
971:         THIS.HabilitarCampos(INLIST(UPPER(THIS.this_cEscolha), "INSERIR", "ALTERAR"))
972:     ENDPROC
973: 
974:     *--------------------------------------------------------------------------
975:     * Destroy - Limpa cursores e re-habilita form pai
976:     *--------------------------------------------------------------------------
977:     PROCEDURE Destroy()
978:         IF USED("cursor_4c_Operacao")
979:             USE IN cursor_4c_Operacao
980:         ENDIF
981:         IF USED("cursor_4c_GruposTemp")
982:             USE IN cursor_4c_GruposTemp
983:         ENDIF
984:         IF USED("cursor_4c_GrpLookup")
985:             USE IN cursor_4c_GrpLookup
986:         ENDIF
987:         IF USED("cursor_4c_GrpBusca")
988:             USE IN cursor_4c_GrpBusca
989:         ENDIF
990:         IF VARTYPE(THIS.this_oParentForm) = "O"
991:             THIS.this_oParentForm.Enabled = .T.
992:         ENDIF
993:         THIS.this_oBusinessObject = .NULL.
994:         DODEFAULT()
995:     ENDPROC
996: 
997: ENDDEFINE


### BO (C:\4c\projeto\app\classes\GpsBO.prg):
*==============================================================================
* GpsBO.prg - Business Object para Grupos de Produtos (Sub-nivel)
* Tabelas: SigCdGgp (tipo GGP) / SigCdGps (tipo GPS)
* Gerado: Fase 1/8 - Propriedades e Init
*         Fase 2/8 - Metodos CRUD
*==============================================================================

DEFINE CLASS GpsBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da entidade
    *--------------------------------------------------------------------------

    *-- Identificacao da operacao (Dopes de SigCdOpe)
    this_cDopes     = ""

    *-- Codigo do grupo (Cgrus de SigCdGrp - char(3))
    this_cCgrus     = ""

    *-- Descricao do grupo (Dgrus de SigCdGrp - char(30))
    this_cDgrus     = ""

    *-- Controla qual tabela usar: .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    this_lTipoggp   = .F.

    *-- Modo de edicao recebido do form pai: 'INSERIR', 'ALTERAR', etc.
    this_cEscolha   = ""

    *-- Flag que indica se houve alteracao de dados no grid
    this_lGravaDados = .F.

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- Tabela padrao GGP; o form comuta para GPS via this_lTipoggp
        this_cTabela     = "SigCdGgp"
        this_cCampoChave = "pkchave"

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta (Dopes + Cgrus) para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes) + "|" + ALLTRIM(THIS.this_cCgrus)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor de trabalho nas propriedades do BO
    * par_cAliasCursor: nome do cursor (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes = TratarNulo(Dopes, "C")
                THIS.this_cCgrus = TratarNulo(Cgrus, "C")
                THIS.this_cDgrus = TratarNulo(Dgrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere um unico registro de grupo no SQL Server
    * Usa: this_cDopes, this_cCgrus, this_lTipoggp
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo, loc_cChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.this_lTipoggp
                loc_cTabela  = "SigCdGgp"
                loc_cPkCampo = "pkchave"
            ELSE
                loc_cTabela  = "SigCdGps"
                loc_cPkCampo = "cIdChaves"
            ENDIF

            loc_cChave = LOWER(SYS(2015) + SYS(2015))

            loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                       " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCgrus)) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo.", "Erro em Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel: grupos sao gerenciados via SalvarGrupos (batch)
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os grupos de uma operacao (Dopes)
    * Chamado internamente pelo ciclo de salvamento (SalvarGrupos)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTabela = IIF(THIS.this_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarGrupos - Carrega grupos do SQL Server em cursor temporario
    * par_cDopes   : Dopes da operacao (SigCdOpe)
    * par_lTipoggp : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * Resultado: cursor_4c_GruposTemp (Dopes c(20), Cgrus c(3), Dgrus c(30))
    *--------------------------------------------------------------------------
    FUNCTION CarregarGrupos(par_cDopes, par_lTipoggp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_GruposTemp")
                USE IN cursor_4c_GruposTemp
            ENDIF

            loc_cTabela = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cSQL = "SELECT a.Dopes, a.Cgrus, b.Dgrus " + ;
                       "FROM " + loc_cTabela + " a " + ;
                       "INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus " + ;
                       "WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTemp") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos da opera" + CHR(231) + CHR(227) + "o.", "Erro em CarregarGrupos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Verifica duplicidade de Cgrus no cursor de trabalho
    * par_cCursorOpe : Nome do cursor de trabalho (ex: "cursor_4c_Operacao")
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicados(par_cCursorOpe)
        LOCAL loc_lValido, loc_oErro
        loc_lValido = .T.
        TRY
            IF USED(par_cCursorOpe) AND RECCOUNT(par_cCursorOpe) > 0
                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF

                SELECT Cgrus, SUM(1) AS Qt ;
                    FROM (par_cCursorOpe) ;
                    WHERE NOT EMPTY(ALLTRIM(Cgrus)) ;
                    GROUP BY Cgrus ;
                    HAVING SUM(1) > 1 ;
                    INTO CURSOR cursor_4c_DupVerif READWRITE

                IF USED("cursor_4c_DupVerif") AND RECCOUNT("cursor_4c_DupVerif") > 0
                    loc_lValido = .F.
                    MsgAviso("Existem lan" + CHR(231) + "amentos de Grupos Em Duplicidade!!!", "Valida" + CHR(231) + CHR(227) + "o")
                ENDIF

                IF USED("cursor_4c_DupVerif")
                    USE IN cursor_4c_DupVerif
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarDuplicados")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Ciclo completo: exclui registros existentes e reinsere
    * par_cDopes     : Dopes da operacao identificando os grupos
    * par_lTipoggp   : .T.=SigCdGgp (GGP), .F.=SigCdGps (GPS)
    * par_cCursorOpe : Nome do cursor de trabalho com grupos editados pelo usuario
    * Retorna .T. se salvou com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cDopes, par_lTipoggp, par_cCursorOpe)
        LOCAL loc_lSucesso, loc_cSQL, loc_cTabela, loc_cPkCampo
        LOCAL loc_cChave, loc_cCgrus, loc_lTransAtiva, loc_lErroInsert, loc_oErro
        loc_lSucesso    = .F.
        loc_lTransAtiva = .F.
        loc_lErroInsert = .F.
        TRY
            loc_cTabela  = IIF(par_lTipoggp, "SigCdGgp", "SigCdGps")
            loc_cPkCampo = IIF(par_lTipoggp, "pkchave", "cIdChaves")

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransAtiva = .T.

            loc_cSQL = "DELETE FROM " + loc_cTabela + ;
                       " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cDopes))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0

                IF USED(par_cCursorOpe)
                    SELECT (par_cCursorOpe)
                    GO TOP
                    DO WHILE !EOF() AND !loc_lErroInsert
                        IF !DELETED()
                            loc_cCgrus = ALLTRIM(Cgrus)
                            IF !EMPTY(loc_cCgrus)
                                loc_cChave = LOWER(SYS(2015) + SYS(2015))
                                loc_cSQL = "INSERT INTO " + loc_cTabela + ;
                                           " (Dopes, Cgrus, " + loc_cPkCampo + ") VALUES (" + ;
                                           EscaparSQL(ALLTRIM(par_cDopes)) + ", " + ;
                                           EscaparSQL(loc_cCgrus) + ", " + ;
                                           EscaparSQL(loc_cChave) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                    loc_lErroInsert = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_lErroInsert
                            SELECT (par_cCursorOpe)
                            SKIP
                        ENDIF
                    ENDDO
                ENDIF

                IF !loc_lErroInsert
                    IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") > 0
                        loc_lTransAtiva = .F.
                        THIS.this_cDopes    = ALLTRIM(par_cDopes)
                        THIS.this_lTipoggp  = par_lTipoggp
                        THIS.RegistrarAuditoria("A")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro em SalvarGrupos")
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir grupo " + loc_cCgrus + ".", "Erro em SalvarGrupos")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir grupos existentes.", "Erro em SalvarGrupos")
            ENDIF

            IF loc_lTransAtiva AND !loc_lSucesso
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                loc_lTransAtiva = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupos")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

