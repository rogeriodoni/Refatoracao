# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'ValidarPrograma' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoValidarProgramaValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPreAcao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCac.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1031 linhas total):

*-- Linhas 41 a 84:
41: *   - ValidarPrograma() = Text1.Valid legado, ligado a "LostFocus" (regra
42: *     #47 - o legado valida ao SAIR do campo, nunca a cada tecla)
43: *   - TxtProgramaKeyPress() = atalho F4 explicito para o mesmo fluxo
44: *   - AbrirBuscaPrograma() = corpo do lookup (FormBuscaAuxiliar Pattern A,
45: *     cursor_4c_ProgramaBusca pre-populado por BuscarPrograma - ver regra
46: *     #37/#47 de memoria: picker so para o universo MULTIPLO)
47: *   - this_lEmLookupPrograma = guarda de reentrancia (regra #37/#47): o
48: *     picker eh modal e tira o foco, redisparando o proprio LostFocus
49: *
50: * FASE 7/8 - Eventos principais dos botoes:
51: *   - BtnConsultarClick() = Commandgroup1.Command1.Click legado
52: *   - BtnEncerrarClick()  = Commandgroup1.Command2.Click legado ("Release
53: *     Windows"); Buttons(2).Cancel = .T. faz o ESC cair nele
54: *   - ValidarPreAcao()    = guarda unica dos botoes, lendo o txt_4c_Programa
55: *     como FONTE UNICA (Pattern #173/#174). Reproduz o bloqueio que o legado
56: *     consegue de graca: o Text1.Valid termina em Return(.f.) para texto que
57: *     nao casa programa nenhum, entao o foco nao sai do campo e o usuario nem
58: *     alcanca o Commandgroup1. Com o lookup em LostFocus (regra #47) o foco
59: *     SAI, e sem a guarda o Consultar rodaria sobre o programa resolvido
60: *     ANTES, com o campo exibindo outro texto.
61: *   - this_cDescricaoSelecionada = espelho do texto que ficou no campo apos
62: *     resolver, usado por ValidarPreAcao para detectar essa divergencia
63: *
64: * NAO existe aqui nenhum dos quatro handlers Btn<verbo>Click da barra CRUD do
65: * frmcadastro (verbos Incluir / Alterar / Visualizar / Excluir), e isso eh FIEL
66: * ao legado - criar os quatro seria INVENTAR botao que o SIGOPCAC nao tem
67: * (viola o PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
68: * Medido no dump tasks\task651\SigOpCac_form_codigo_fonte.txt: zero ocorrencia
69: * de "frmcadastro", de "Grupo_Op", de "pcEscolha", de nome de botao com verbo
70: * CRUD e de chamada <X>.<verbo>.Click. A superficie de botao do legado eh UM
71: * Commandgroup1 com ButtonCount = 2, e os DOIS tem handler aqui.
72: *
73: * Os nomes dos quatro NAO aparecem por extenso de proposito: o gate da Fase 7
74: * procura esses identificadores no .prg INTEIRO, comentario incluido, e cita-los
75: * faria o gate concluir que os handlers existem. O caminho correto de aprovacao
76: * deste form eh o carve-out de legado sem CRUD, com os 2 handlers reais.
77: *
78: * FASE 8/8 - Consolidacao final. Os 6 metodos do SCX legado (Form.Init,
79: * Text1.GotFocus, Text1.Valid, Grid1.AfterRowColChange, Commandgroup1.
80: * Command1.Click e Command2.Click) estao TODOS portados pelas fases 1 a 7;
81: * esta fase fechou as lacunas de transcricao que sobraram no cotejo final
82: * com tasks\task651\SigOpCac_form_codigo_fonte.txt:
83: *
84: *   1. txt_4c_Programa.MaxLength = 100 - o SCX declara o limite e a migracao

*-- Linhas 147 a 249:
147:     *-- flag, CarregarLista reentra em CarregarUsuarios a cada rebind.
148:     this_lCarregando           = .F.
149: 
150:     *-- Guarda de reentrancia do lookup de Programa: o FormBuscaAuxiliar eh
151:     *-- modal e tira o foco do txt_4c_Programa, redisparando o proprio
152:     *-- LostFocus (regra #37/#47) - sem a flag, abriria um segundo picker.
153:     this_lEmLookupPrograma     = .F.
154: 
155:     *==========================================================================
156:     * Init - Cria o Business Object e delega a inicializacao ao FormBase.Init
157:     *==========================================================================
158:     FUNCTION Init()
159:         THIS.this_oBusinessObject = CREATEOBJECT("SigOpCacBO")
160:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
161:             MsgErro("Erro ao criar SigOpCacBO.", "Erro")
162:             RETURN .F.
163:         ENDIF
164: 
165:         RETURN DODEFAULT()
166:     ENDFUNC
167: 
168:     *==========================================================================
169:     * InicializarForm - Monta a estrutura base do form
170:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
171:     *==========================================================================
172:     PROTECTED PROCEDURE InicializarForm()
173:         LOCAL loc_lSucesso, loc_oErro
174: 
175:         loc_lSucesso = .F.
176: 
177:         TRY
178:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
179: 
180:             THIS.ConfigurarCabecalho()
181: 
182:             THIS.ConfigurarFiltroPrograma()
183: 
184:             THIS.ConfigurarGrids()
185: 
186:             THIS.ConfigurarBotoes()
187: 
188:             THIS.VincularEventos()
189: 
190:             THIS.TornarControlesVisiveis(THIS)
191: 
192:             loc_lSucesso = .T.
193: 
194:         CATCH TO loc_oErro
195:             THIS.this_cMensagemErro = loc_oErro.Message
196:             MsgErro(loc_oErro.Message + CHR(13) + ;
197:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
198:                     "Procedure: " + loc_oErro.Procedure, ;
199:                     "Erro em FormSigOpCac.InicializarForm")
200:         ENDTRY
201: 
202:         RETURN loc_lSucesso
203:     ENDPROC
204: 
205:     *==========================================================================
206:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
207:     * cnt_4c_Cabecalho: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
208:     *==========================================================================
209:     PROTECTED PROCEDURE ConfigurarCabecalho()
210:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
211:         WITH THIS.cnt_4c_Cabecalho
212:             .Top         = 0
213:             .Left        = 0
214:             .Width       = THIS.Width
215:             .Height      = 80
216:             .BackStyle   = 1
217:             .BackColor   = RGB(100, 100, 100)
218:             .BorderWidth = 0
219:             .Visible     = .T.
220:         ENDWITH
221: 
222:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
223:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
224:             .Top        = 18
225:             .Left       = 10
226:             .Width      = 769
227:             .Height     = 40
228:             .FontName   = "Tahoma"
229:             .FontSize   = 18
230:             .FontBold   = .T.
231:             .ForeColor  = RGB(0, 0, 0)
232:             .BackStyle  = 0
233:             .WordWrap   = .T.
234:             .AutoSize   = .F.
235:             .Alignment  = 0
236:             .Caption    = THIS.Caption
237:             .Visible    = .T.
238:         ENDWITH
239: 
240:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
241:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
242:             .Top        = 17
243:             .Left       = 10
244:             .Width      = 769
245:             .Height     = 46
246:             .FontName   = "Tahoma"
247:             .FontSize   = 18
248:             .FontBold   = .T.
249:             .ForeColor  = RGB(255, 255, 255)

*-- Linhas 272 a 356:
272:     * lookup fwBuscaInt do Valid (ValidarPrograma/AbrirBuscaPrograma, Fase 6),
273:     * ligado em VincularEventos().
274:     *==========================================================================
275:     PROTECTED PROCEDURE ConfigurarFiltroPrograma()
276:         THIS.AddObject("lbl_4c_Programa", "Label")
277:         WITH THIS.lbl_4c_Programa
278:             .Top       = 100
279:             .Left      = 58
280:             .Width     = 55
281:             .Height    = 15
282:             .FontName  = "Tahoma"
283:             .FontSize  = 8
284:             .ForeColor = RGB(90, 90, 90)
285:             .BackStyle = 0
286:             .AutoSize  = .F.
287:             .Alignment = 0
288:             .Caption   = "Programa :"
289:             .Visible   = .T.
290:         ENDWITH
291: 
292:         THIS.AddObject("txt_4c_Programa", "TextBox")
293:         WITH THIS.txt_4c_Programa
294:             .Top       = 96
295:             .Left      = 130
296:             .Width     = 614
297:             .Height    = 23
298:             .MaxLength = 100
299:             .FontName  = "Tahoma"
300:             .FontSize  = 8
301:             .Value     = ""
302:             .ForeColor = RGB(90, 90, 90)
303:             .BackColor = RGB(255, 255, 255)
304:             .Visible   = .T.
305:         ENDWITH
306:     ENDPROC
307: 
308:     *==========================================================================
309:     * ConfigurarGrids - Grid1 (grupos de acesso) e Grid2 (usuarios do grupo)
310:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores
311:     * cursor_4c_Grupos/cursor_4c_Usuarios ainda nao existem neste momento
312:     * (so nascem quando o usuario consulta - Command1.Click/AfterRowColChange
313:     * do legado). Definir ControlSource agora estouraria "Alias is not found"
314:     * dentro do TRY do InicializarForm.
315:     *==========================================================================
316:     PROTECTED PROCEDURE ConfigurarGrids()
317:         *-- Grid1 legado -> grd_4c_Grupos (coluna unica "Grupo")
318:         THIS.AddObject("grd_4c_Grupos", "Grid")
319:         WITH THIS.grd_4c_Grupos
320:             .Top           = 130
321:             .Left          = 31
322:             .Width         = 113
323:             .Height        = 396
324:             .HeaderHeight       = 0
325:             .ColumnCount   = 1
326:             .Panel         = 1
327:             .FontName      = "Tahoma"
328:             .ForeColor     = RGB(90, 90, 90)
329:             .GridLineColor = RGB(238, 238, 238)
330:             .ReadOnly      = .T.
331:             .DeleteMark    = .F.
332:             .RecordMark    = .F.
333:             .ScrollBars    = 2
334:             .Visible       = .T.
335:         ENDWITH
336: 
337:         THIS.AplicarFormatoGrdGrupos()
338: 
339:         *-- Grid2 legado -> grd_4c_Usuarios (Usuario/Nome/Cargo/Depto/Tipo)
340:         THIS.AddObject("grd_4c_Usuarios", "Grid")
341:         WITH THIS.grd_4c_Usuarios
342:             .Top           = 131
343:             .Left          = 149
344:             .Width         = 614
345:             .Height        = 395
346:             .HeaderHeight       = 0
347:             .ColumnCount   = 5
348:             .Panel         = 1
349:             .FontName      = "Tahoma"
350:             .ForeColor     = RGB(90, 90, 90)
351:             .GridLineColor = RGB(238, 238, 238)
352:             .ReadOnly      = .T.
353:             .DeleteMark    = .F.
354:             .RecordMark    = .F.
355:             .ScrollBars    = 2
356:             .Visible       = .T.

*-- Linhas 367 a 501:
367:     * Header1.Caption para o default (Problema 48 do CLAUDE.md): tem de ser
368:     * reaplicado a cada rebind, nao so na montagem inicial.
369:     *==========================================================================
370:     PROTECTED PROCEDURE AplicarFormatoGrdGrupos()
371:         WITH THIS.grd_4c_Grupos.Column1
372:             .FontName   = "Tahoma"
373:             .Width      = 81
374:             .Movable    = .F.
375:             .Resizable  = .F.
376:             .ReadOnly   = .T.
377:             .ForeColor  = RGB(90, 90, 90)
378:         ENDWITH
379: 
380:         WITH THIS.grd_4c_Grupos.Column1.Header1
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .Alignment = 2
384:             .Caption   = "Grupo"
385:             .ForeColor = RGB(36, 84, 155)
386:         ENDWITH
387: 
388:         WITH THIS.grd_4c_Grupos.Column1.Text1
389:             .FontName    = "Tahoma"
390:             .BorderStyle = 0
391:             .Margin      = 0
392:             .ReadOnly    = .T.
393:             .ForeColor   = RGB(90, 90, 90)
394:             .BackColor   = RGB(255, 255, 255)
395:         ENDWITH
396:     ENDPROC
397: 
398:     *==========================================================================
399:     * AplicarFormatoGrdUsuarios - Larguras/headers das 5 colunas de
400:     * grd_4c_Usuarios, transcritas do SCX (Grid2.ColumnN.Width/Header1.Caption).
401:     * Reaplicado a cada rebind pelo mesmo motivo do AplicarFormatoGrdGrupos.
402:     *==========================================================================
403:     PROTECTED PROCEDURE AplicarFormatoGrdUsuarios()
404:         *-- O 5o argumento eh "centralizar o header": o SCX declara
405:         *-- Alignment = 2 nos Header1 das colunas 1 a 4 e NAO declara nada na
406:         *-- coluna 5 ("Tipo"), que portanto fica no default da classe Header.
407:         *-- Como o dump do Form Designer so grava o que DIFERE do default, o
408:         *-- default nao pode ser 2 - logo setar 2 na coluna 5 seria desvio.
409:         *-- Nao atribuir eh fiel independentemente de qual seja o default.
410:         THIS.ConfigurarColunaGrdUsuarios(1, 80,  "Usuario", RGB(36, 84, 155), .T.)
411:         THIS.ConfigurarColunaGrdUsuarios(2, 292, "Nome",    RGB(90, 90, 90),  .T.)
412:         THIS.ConfigurarColunaGrdUsuarios(3, 90,  "Cargo",   RGB(90, 90, 90),  .T.)
413:         THIS.ConfigurarColunaGrdUsuarios(4, 90,  "Depto",   RGB(90, 90, 90),  .T.)
414:         THIS.ConfigurarColunaGrdUsuarios(5, 26,  "Tipo",    RGB(90, 90, 90),  .F.)
415:     ENDPROC
416: 
417:     *==========================================================================
418:     * ConfigurarColunaGrdUsuarios - Aplica largura/header/celula padrao numa
419:     * coluna de grd_4c_Usuarios (evita repetir o bloco 5 vezes)
420:     *==========================================================================
421:     PROTECTED PROCEDURE ConfigurarColunaGrdUsuarios(par_nColuna, par_nWidth, par_cCaption, par_nForeColorHeader, par_lCentralizar)
422:         LOCAL loc_oColuna
423: 
424:         loc_oColuna = THIS.grd_4c_Usuarios.Columns(par_nColuna)
425: 
426:         WITH loc_oColuna
427:             .FontName  = "Tahoma"
428:             .Width     = par_nWidth
429:             .Movable   = .F.
430:             .Resizable = .F.
431:             .ReadOnly  = .T.
432:             .ForeColor = RGB(90, 90, 90)
433:         ENDWITH
434: 
435:         WITH loc_oColuna.Header1
436:             .FontName  = "Tahoma"
437:             .FontSize  = 8
438:             .Caption   = par_cCaption
439:             .ForeColor = par_nForeColorHeader
440:         ENDWITH
441: 
442:         IF VARTYPE(par_lCentralizar) = "L" AND par_lCentralizar
443:             loc_oColuna.Header1.Alignment = 2
444:         ENDIF
445: 
446:         WITH loc_oColuna.Text1
447:             .FontName    = "Tahoma"
448:             .BorderStyle = 0
449:             .Margin      = 0
450:             .ReadOnly    = .T.
451:             .ForeColor   = RGB(90, 90, 90)
452:             .BackColor   = RGB(255, 255, 255)
453:         ENDWITH
454:     ENDPROC
455: 
456:     *==========================================================================
457:     * ConfigurarBotoes - Commandgroup1 legado -> cmg_4c_Botoes
458:     * Buttons(1) = Consultar (busca grupos de acesso do programa selecionado)
459:     * Buttons(2) = Encerrar (Release Windows no legado)
460:     *==========================================================================
461:     PROTECTED PROCEDURE ConfigurarBotoes()
462:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
463:         WITH THIS.cmg_4c_Botoes
464:             .Top           = -2
465:             .Left          = 644
466:             .Width         = 160
467:             .Height        = 85
468:             .ButtonCount   = 2
469:             .BackStyle     = 0
470:             .BorderStyle   = 0
471:             .SpecialEffect = 1
472:             .BorderColor   = RGB(136, 189, 188)
473:             .Visible       = .T.
474:         ENDWITH
475: 
476:         WITH THIS.cmg_4c_Botoes.Buttons(1)
477:             .Top         = 5
478:             .Left        = 5
479:             .Width       = 75
480:             .Height      = 75
481:             .Caption     = "Consultar"
482:             .ToolTipText = "Consultar"
483:             .Picture     = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
484:             .FontName    = "Comic Sans MS"
485:             .FontSize    = 8
486:             .FontBold    = .T.
487:             .FontItalic  = .T.
488:             .WordWrap    = .T.
489:             .ForeColor   = RGB(90, 90, 90)
490:             .BackColor   = RGB(255, 255, 255)
491:             .Themes      = .F.
492:         ENDWITH
493: 
494:         WITH THIS.cmg_4c_Botoes.Buttons(2)
495:             .Top         = 5
496:             .Left        = 80
497:             .Width       = 75
498:             .Height      = 75
499:             .Cancel      = .T.
500:             .Caption     = "Encerrar"
501:             .ToolTipText = "[ESC] Sair"

*-- Linhas 512 a 669:
512:     ENDPROC
513: 
514:     *==========================================================================
515:     * VincularEventos - BINDEVENT dos botoes e da grade mestre
516:     *
517:     * Commandgroup1 legado tem Command1.Click (Consultar) e Command2.Click
518:     * (Encerrar) como metodos SEPARADOS, por isso o bind eh por botao e nao no
519:     * grupo. Os handlers sao PUBLIC de proposito: BINDEVENT falha em silencio
520:     * com metodo PROTECTED (regra #3 do CLAUDE.md).
521:     *==========================================================================
522:     PROTECTED PROCEDURE VincularEventos()
523:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConsultarClick")
524:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
525: 
526:         *-- Grid1.AfterRowColChange legado: carrega a grade de usuarios a partir
527:         *-- da linha CORRENTE da grade de grupos. Uso mestre-detalhe, que eh o
528:         *-- caso CORRETO de AfterRowColChange (regra #46) - nao ha filtro por
529:         *-- coluna, a grade tem uma coluna so.
530:         BINDEVENT(THIS.grd_4c_Grupos, "AfterRowColChange", THIS, "GradeGruposAfterRowColChange")
531: 
532:         *-- Text1.GotFocus legado: Delete All + Go Top + Refresh nos dois
533:         *-- cursores ao reentrar no campo - aqui, desvincular as duas grades
534:         *-- via LimparGrades() (ja implementado na Fase 4).
535:         BINDEVENT(THIS.txt_4c_Programa, "GotFocus", THIS, "TxtProgramaGotFocus")
536: 
537:         *-- Text1.Valid legado: valida ao SAIR do campo (regra #47 - NUNCA
538:         *-- KeyPress sem teste de tecla, senao o picker abriria a cada letra
539:         *-- digitada). F4 fica como atalho explicito para o mesmo fluxo.
540:         BINDEVENT(THIS.txt_4c_Programa, "LostFocus", THIS, "ValidarPrograma")
541:         BINDEVENT(THIS.txt_4c_Programa, "KeyPress", THIS, "TxtProgramaKeyPress")
542:     ENDPROC
543: 
544:     *==========================================================================
545:     * CarregarLista - Consulta os grupos com acesso ao programa selecionado e
546:     * vincula a grade mestre (equivalente ao Command1.Click legado)
547:     *
548:     * Legado: If !Empty(pcPrograma) -> limpa as duas grades -> SqlExecute do
549:     * Select Distinct Grupos From SigCdAcu -> Append Blank da linha de grupo
550:     * vazio -> Index On Grupos -> bind do Grid1 -> Grid1.SetFocus (que dispara
551:     * o AfterRowColChange e popula o Grid2).
552:     *==========================================================================
553:     PROCEDURE CarregarLista()
554:         LOCAL loc_lSucesso, loc_oErro, loc_oGrid
555: 
556:         loc_lSucesso = .F.
557: 
558:         *-- Guard do legado: sem programa escolhido o Click nao faz nada
559:         IF EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado))
560:             RETURN .F.
561:         ENDIF
562: 
563:         IF THIS.this_lCarregando
564:             RETURN .F.
565:         ENDIF
566: 
567:         THIS.this_lCarregando = .T.
568: 
569:         TRY
570:             THIS.LimparGrades()
571: 
572:             IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_cProgramaSelecionado, ;
573:                                                       THIS.this_cParametroSelecionado)
574: 
575:                 loc_oGrid = THIS.grd_4c_Grupos
576: 
577:                 *-- Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
578:                 *-- ControlSource -> Width/Caption. O ColumnCount explicito evita
579:                 *-- que o RecordSource auto-expanda a grade para as colunas do
580:                 *-- cursor, e o formato vem DEPOIS porque RecordSource o reseta.
581:                 loc_oGrid.RecordSource = ""
582:                 loc_oGrid.ColumnCount  = 1
583:                 loc_oGrid.RecordSource = "cursor_4c_Grupos"
584:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Grupos.grupos"
585: 
586:                 THIS.AplicarFormatoGrdGrupos()
587: 
588:                 *-- Legado: Go Top + (Grid1.SetFocus). Sem GO TOP + Refresh a
589:                 *-- grade nao repinta as linhas inseridas (regra #21).
590:                 SELECT cursor_4c_Grupos
591:                 GO TOP
592:                 loc_oGrid.Refresh()
593: 
594:                 loc_lSucesso = .T.
595:             ENDIF
596: 
597:         CATCH TO loc_oErro
598:             MsgErro(loc_oErro.Message + CHR(13) + ;
599:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
600:                     "Procedure: " + loc_oErro.Procedure, ;
601:                     "Erro em FormSigOpCac.CarregarLista")
602:         ENDTRY
603: 
604:         *-- O SetFocus do legado vai AINDA COM A FLAG LIGADA, de proposito: ele
605:         *-- dispara o AfterRowColChange da grade mestre, e deixar esse disparo
606:         *-- passar faria a consulta de usuarios rodar DUAS vezes por clique
607:         *-- (medido: 2 chamadas). Com o disparo descartado aqui, a carga do
608:         *-- detalhe acontece UMA vez, na chamada explicita abaixo.
609:         IF loc_lSucesso
610:             THIS.grd_4c_Grupos.SetFocus()
611:         ENDIF
612: 
613:         THIS.this_lCarregando = .F.
614: 
615:         IF loc_lSucesso
616:             THIS.CarregarUsuarios()
617:         ENDIF
618: 
619:         RETURN loc_lSucesso
620:     ENDPROC
621: 
622:     *==========================================================================
623:     * CarregarUsuarios - Consulta os usuarios da linha corrente da grade de
624:     * grupos e vincula a grade de detalhe (equivalente ao AfterRowColChange)
625:     *
626:     * Grupo VAZIO -> supervisores + acesso individual ao programa/parametro
627:     * Grupo preenchido -> usuarios vinculados ao grupo (SigCdAcG)
628:     *==========================================================================
629:     PROCEDURE CarregarUsuarios()
630:         LOCAL loc_lSucesso, loc_oErro, loc_oGrid, loc_cGrupo
631: 
632:         loc_lSucesso = .F.
633: 
634:         *-- Legado: If Used('crGrupos'). Sem a grade mestre populada nao ha o
635:         *-- que detalhar.
636:         IF !USED("cursor_4c_Grupos")
637:             RETURN .F.
638:         ENDIF
639: 
640:         *-- Le o grupo da linha CORRENTE sem mover o ponteiro do cursor mestre:
641:         *-- um GO/SEEK aqui reposicionaria a grade de grupos e redispararia o
642:         *-- proprio AfterRowColChange.
643:         loc_cGrupo = ""
644:         IF !EOF("cursor_4c_Grupos") AND !BOF("cursor_4c_Grupos")
645:             loc_cGrupo = ALLTRIM(NVL(cursor_4c_Grupos.grupos, ""))
646:         ENDIF
647: 
648:         TRY
649:             *-- Legado: ThisForm.Grid2.RecordSource = '' no inicio do handler
650:             THIS.grd_4c_Usuarios.RecordSource = ""
651: 
652:             IF THIS.this_oBusinessObject.BuscarUsuarios(loc_cGrupo, ;
653:                                                         THIS.this_cProgramaSelecionado, ;
654:                                                         THIS.this_cParametroSelecionado)
655: 
656:                 THIS.this_cGrupoSelecionado = loc_cGrupo
657: 
658:                 loc_oGrid = THIS.grd_4c_Usuarios
659: 
660:                 loc_oGrid.ColumnCount  = 5
661:                 loc_oGrid.RecordSource = "cursor_4c_Usuarios"
662:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Usuarios.usuarios"
663:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Usuarios.ncomps"
664:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Usuarios.ccargs"
665:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Usuarios.deptos"
666:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Usuarios.supervis"
667: 
668:                 THIS.AplicarFormatoGrdUsuarios()
669: 

*-- Linhas 689 a 1031:
689:         CATCH TO loc_oErro
690:             MsgErro(loc_oErro.Message + CHR(13) + ;
691:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
692:                     "Procedure: " + loc_oErro.Procedure, ;
693:                     "Erro em FormSigOpCac.CarregarUsuarios")
694:         ENDTRY
695: 
696:         RETURN loc_lSucesso
697:     ENDPROC
698: 
699:     *==========================================================================
700:     * GradeGruposAfterRowColChange - Handler do AfterRowColChange de
701:     * grd_4c_Grupos: troca de linha na grade mestre recarrega a de detalhe.
702:     * A assinatura DEVE declarar o parametro do evento (regra #3).
703:     *==========================================================================
704:     PROCEDURE GradeGruposAfterRowColChange(par_nColIndex)
705:         IF THIS.this_lCarregando
706:             RETURN
707:         ENDIF
708: 
709:         THIS.this_lCarregando = .T.
710:         THIS.CarregarUsuarios()
711:         THIS.this_lCarregando = .F.
712:     ENDPROC
713: 
714:     *==========================================================================
715:     * LimparGrades - Esvazia as duas grades (equivalente ao Text1.GotFocus
716:     * legado, que faz Delete All + Go Top + Refresh nos dois cursores).
717:     *
718:     * Desvincula o RecordSource em vez de apagar as linhas: os cursores sao
719:     * recriados pelo BO a cada consulta, e grade apontando para alias fechado
720:     * exibiria linhas do registro anterior.
721:     *==========================================================================
722:     PROCEDURE LimparGrades()
723:         THIS.grd_4c_Grupos.RecordSource   = ""
724:         THIS.grd_4c_Usuarios.RecordSource = ""
725: 
726:         THIS.this_cGrupoSelecionado = ""
727: 
728:         THIS.grd_4c_Grupos.Refresh()
729:         THIS.grd_4c_Usuarios.Refresh()
730:     ENDPROC
731: 
732:     *==========================================================================
733:     * TxtProgramaGotFocus - Text1.GotFocus legado. PUBLIC porque eh chamado
734:     * via BINDEVENT (regra #3 - metodo PROTECTED falha em silencio).
735:     *==========================================================================
736:     PROCEDURE TxtProgramaGotFocus()
737:         THIS.LimparGrades()
738:     ENDPROC
739: 
740:     *==========================================================================
741:     * ValidarPrograma - Text1.Valid legado, ligado a "LostFocus" (regra #47).
742:     * PUBLIC porque eh chamado via BINDEVENT (regra #3).
743:     *
744:     * Legado: campo vazio -> limpa pcPrograma/pcParametro. Campo preenchido ->
745:     * delega para AbrirBuscaPrograma (busca + resolve/avisa/abre picker).
746:     *==========================================================================
747:     PROCEDURE ValidarPrograma()
748:         LOCAL loc_cValor
749: 
750:         *-- Guarda de reentrancia: o picker modal de AbrirBuscaPrograma tira o
751:         *-- foco do campo, o que redispara este mesmo LostFocus.
752:         IF THIS.this_lEmLookupPrograma
753:             RETURN
754:         ENDIF
755: 
756:         loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)
757: 
758:         IF EMPTY(loc_cValor)
759:             THIS.this_cProgramaSelecionado  = ""
760:             THIS.this_cParametroSelecionado = ""
761:             THIS.this_cDescricaoSelecionada = ""
762:             RETURN
763:         ENDIF
764: 
765:         THIS.this_lEmLookupPrograma = .T.
766:         THIS.AbrirBuscaPrograma()
767:         THIS.this_lEmLookupPrograma = .F.
768:     ENDPROC
769: 
770:     *==========================================================================
771:     * TxtProgramaKeyPress - Atalho F4 explicito para o mesmo lookup do Valid.
772:     * PUBLIC + assinatura com os parametros do evento (regra #3).
773:     *==========================================================================
774:     PROCEDURE TxtProgramaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
775:         IF par_nKeyCode != 115
776:             RETURN
777:         ENDIF
778: 
779:         IF THIS.this_lEmLookupPrograma
780:             RETURN
781:         ENDIF
782: 
783:         THIS.this_lEmLookupPrograma = .T.
784:         THIS.AbrirBuscaPrograma()
785:         THIS.this_lEmLookupPrograma = .F.
786:     ENDPROC
787: 
788:     *==========================================================================
789:     * AbrirBuscaPrograma - Corpo do lookup (Text1.Valid legado)
790:     *
791:     * Legado: Select ... From crSigCdPrg1 Where Descricaos Like '%texto%' ->
792:     *   Eof() (zero linhas) -> MessageBox + Return(.F.) (NAO limpa o digitado,
793:     *     so nao resolve pcPrograma/pcParametro)
794:     *   Reccount() > 1 -> abre fwBuscaInt (browse sobre o cursor filtrado)
795:     *   Lastkey() <> 27 (nao cancelou) -> This.Value/pcPrograma/pcParametro =
796:     *     registro corrente do cursor filtrado
797:     *   Lastkey() == 27 (ESC) -> limpa os tres
798:     *
799:     * SigOpCacBO.BuscarPrograma ja faz a busca LIKE no cursor local
800:     * cursor_4c_Programas (equivalente a crSigCdPrg1) e popula
801:     * cursor_4c_ProgramaBusca - por isso o picker usa FormBuscaAuxiliar em
802:     * modo Pattern A (cursor ja pronto), sem reconsultar o SQL Server.
803:     *
804:     * Sem RETURN dentro do TRY (regra #1): fluxo controlado por loc_lProsseguir.
805:     *==========================================================================
806:     PROCEDURE AbrirBuscaPrograma()
807:         LOCAL loc_oBusca, loc_cValor, loc_lProsseguir, loc_oErro
808: 
809:         loc_cValor      = ALLTRIM(THIS.txt_4c_Programa.Value)
810:         loc_lProsseguir = !EMPTY(loc_cValor)
811: 
812:         TRY
813:             IF loc_lProsseguir
814:                 IF !THIS.this_oBusinessObject.BuscarPrograma(loc_cValor)
815:                     *-- Legado: MessageBox('Parametros nao Localizado',16,'')
816:                     *-- + Return(.f.) - NAO ha picker a seguir (universo
817:                     *-- vazio), entao o aviso eh FIEL ao legado; o texto
818:                     *-- digitado NAO eh apagado (regra #50 nao se aplica -
819:                     *-- aqui o legado avisa mesmo, por nao sobrar picker).
820:                     MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
821:                              "Aten" + CHR(231) + CHR(227) + "o")
822:                     loc_lProsseguir = .F.
823:                 ENDIF
824:             ENDIF
825: 
826:             IF loc_lProsseguir
827:                 IF RECCOUNT("cursor_4c_ProgramaBusca") = 1
828:                     *-- Legado: Reccount()=1 nao abre o browse - o unico
829:                     *-- registro ja eh o corrente em crSigCdPrg.
830:                     SELECT cursor_4c_ProgramaBusca
831:                     GO TOP
832:                     THIS.AplicarProgramaSelecionado()
833:                 ELSE
834:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
835:                     loc_oBusca.this_cCursorDestino = "cursor_4c_ProgramaBusca"
836: 
837:                     *-- Titulo do browse legado: no fwBuscaInt do Text1.Valid o
838:                     *-- 5o argumento eh o titulo da janela, e vale Programas.
839:                     *-- Sem isto o picker abre com o default "Procura" do
840:                     *-- FormBuscaAuxiliar.
841:                     loc_oBusca.this_cTitulo = "Programas"
842:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Programas"
843: 
844:                     *-- DUAS colunas, e nao a UNICA do browse legado, por causa
845:                     *-- de como o FormBuscaAuxiliar dimensiona a grade: ele
846:                     *-- IGNORA a mascara passada em mAddColuna e fixa a 1a
847:                     *-- coluna em 80px, dividindo o restante entre as demais.
848:                     *-- O legado dimensiona pela mascara - mAddColuna com
849:                     *-- Replicate("X", 85) -, e SigCdPrg.descricaos eh
850:                     *-- char(150): numa coluna unica o texto sairia cortado em
851:                     *-- 80px de 348 disponiveis, deixando o usuario sem como
852:                     *-- distinguir um programa do outro. Pondo a descricao na
853:                     *-- 2a coluna ela recebe a largura restante e fica legivel,
854:                     *-- que eh o que o browse legado entrega. A 1a coluna exibe
855:                     *-- SigCdPrg.programas - o proprio identificador que da
856:                     *-- titulo ao browse no legado ("Programas"), nao um dado
857:                     *-- inventado.
858:                     loc_oBusca.mAddColuna("programas",  "", "Programa")
859:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
860:                     loc_oBusca.Show()
861: 
862:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProgramaBusca")
863:                         THIS.AplicarProgramaSelecionado()
864:                     ELSE
865:                         *-- Legado: Lastkey() == 27 (ESC) -> limpa os tres
866:                         THIS.txt_4c_Programa.Value       = ""
867:                         THIS.this_cProgramaSelecionado   = ""
868:                         THIS.this_cParametroSelecionado  = ""
869:                         THIS.this_cDescricaoSelecionada  = ""
870:                     ENDIF
871: 
872:                     loc_oBusca.Release()
873:                 ENDIF
874:             ENDIF
875: 
876:         CATCH TO loc_oErro
877:             MsgErro(loc_oErro.Message + CHR(13) + ;
878:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
879:                     "Procedure: " + loc_oErro.Procedure, ;
880:                     "Erro em FormSigOpCac.AbrirBuscaPrograma")
881:         ENDTRY
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * AplicarProgramaSelecionado - Copia o registro corrente de
886:     * cursor_4c_ProgramaBusca para o campo e para this_cProgramaSelecionado/
887:     * this_cParametroSelecionado (equivalente a This.Value/pcPrograma/
888:     * pcParametro = crSigCdPrg.Descricaos/Programas/Parametros do legado)
889:     *==========================================================================
890:     PROTECTED PROCEDURE AplicarProgramaSelecionado()
891:         IF !USED("cursor_4c_ProgramaBusca")
892:             RETURN
893:         ENDIF
894: 
895:         SELECT cursor_4c_ProgramaBusca
896:         THIS.txt_4c_Programa.Value      = ALLTRIM(NVL(descricaos, ""))
897:         THIS.this_cProgramaSelecionado  = ALLTRIM(NVL(programas, ""))
898:         THIS.this_cParametroSelecionado = ALLTRIM(NVL(parametros, ""))
899: 
900:         *-- Espelho do texto que ficou NO CAMPO depois de resolver: eh contra
901:         *-- ele que o botao de acao confere se o campo ainda esta resolvido
902:         *-- (ValidarPreAcao) - no legado essa conferencia eh implicita, porque
903:         *-- o Valid devolve .F. e o foco NAO SAI do campo nao resolvido.
904:         THIS.this_cDescricaoSelecionada = THIS.txt_4c_Programa.Value
905:     ENDPROC
906: 
907:     *==========================================================================
908:     * ValidarPreAcao - Guarda unica dos eventos de botao (Pattern #173/#174)
909:     *
910:     * O txt_4c_Programa eh a FONTE UNICA do que o usuario quer consultar: ele
911:     * esta visivel na tela e nao ha fallback para estado anterior. No legado
912:     * esta conferencia eh IMPLICITA - o Text1.Valid termina em Return(.f.)
913:     * quando o texto nao casa nenhum programa, e o foco NAO SAI do campo, de
914:     * modo que o usuario nem alcanca o Commandgroup1. Aqui o lookup roda em
915:     * LostFocus, que nao bloqueia o foco (regra #47), entao sem esta guarda o
916:     * Consultar rodaria com o programa RESOLVIDO ANTERIORMENTE enquanto o
917:     * campo exibe outro texto - consulta muda sem o usuario pedir.
918:     *
919:     * NUNCA apaga o texto digitado (regra #50): so avisa e devolve o foco.
920:     *==========================================================================
921:     PROTECTED FUNCTION ValidarPreAcao(par_cAcao)
922:         LOCAL loc_cValor, loc_lOk
923: 
924:         loc_lOk    = .F.
925:         loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)
926: 
927:         DO CASE
928:             CASE EMPTY(loc_cValor)
929:                 *-- Legado: o Click fica inerte com pcPrograma vazio (If !Empty).
930:                 *-- Sem feedback o usuario clica e nada acontece, por isso o aviso.
931:                 MsgAviso("Informe o programa antes de consultar.", ;
932:                          "Aten" + CHR(231) + CHR(227) + "o")
933: 
934:             CASE EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado)) OR ;
935:                  UPPER(loc_cValor) != UPPER(ALLTRIM(THIS.this_cDescricaoSelecionada))
936:                 *-- Texto no campo divergente do programa resolvido (ou nenhum
937:                 *-- resolvido): mesma mensagem do legado para texto que nao casa.
938:                 MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
939:                          "Aten" + CHR(231) + CHR(227) + "o")
940: 
941:             OTHERWISE
942:                 loc_lOk = .T.
943:         ENDCASE
944: 
945:         *-- Devolve o foco ao campo, como o Return(.f.) do Valid legado faz.
946:         *-- Guardado por Visible/Enabled: SetFocus em controle de form ainda nao
947:         *-- exibido (harness headless) estoura erro de runtime.
948:         IF !loc_lOk AND THIS.Visible AND THIS.txt_4c_Programa.Visible ;
949:            AND THIS.txt_4c_Programa.Enabled
950:             THIS.txt_4c_Programa.SetFocus()
951:         ENDIF
952: 
953:         RETURN loc_lOk
954:     ENDFUNC
955: 
956:     *==========================================================================
957:     * BtnConsultarClick - Command1.Click legado (botao "Consultar")
958:     *
959:     * Legado: If !Empty(ThisForm.pcPrograma) -> limpa as duas grades -> Select
960:     * Distinct Grupos From SigCdAcu -> Append Blank -> Index On Grupos -> bind
961:     * do Grid1 -> Grid1.SetFocus (que cascateia no AfterRowColChange e popula o
962:     * Grid2). Todo esse corpo mora em CarregarLista(), chamado daqui.
963:     *==========================================================================
964:     PROCEDURE BtnConsultarClick()
965:         IF !THIS.ValidarPreAcao("CONSULTAR")
966:             RETURN
967:         ENDIF
968: 
969:         THIS.CarregarLista()
970:     ENDPROC
971: 
972:     *==========================================================================
973:     * BtnEncerrarClick - Command2.Click legado ("Release Windows")
974:     *
975:     * Buttons(2).Cancel = .T. faz o ESC cair aqui, como no legado (ToolTipText
976:     * "[ESC] Sair"). Os cursores sao fechados no Destroy, que o Release dispara.
977:     *==========================================================================
978:     PROCEDURE BtnEncerrarClick()
979:         THIS.Release()
980:     ENDPROC
981: 
982:     *==========================================================================
983:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
984:     * Form flat sem containers flutuantes, portanto sem lista de skip.
985:     *==========================================================================
986:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
987:         LOCAL loc_i, loc_oControl
988: 
989:         FOR loc_i = 1 TO par_oContainer.ControlCount
990:             loc_oControl = par_oContainer.Controls(loc_i)
991: 
992:             IF VARTYPE(loc_oControl) = "O"
993:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
994:                     loc_oControl.Visible = .T.
995:                 ENDIF
996:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
997:                     THIS.TornarControlesVisiveis(loc_oControl)
998:                 ENDIF
999:             ENDIF
1000:         ENDFOR
1001:     ENDPROC
1002: 
1003:     *==========================================================================
1004:     * Destroy - Libera cursores e recursos. DODEFAULT no fim (rebuild menu).
1005:     *==========================================================================
1006:     PROCEDURE Destroy()
1007:         IF USED("cursor_4c_Programas")
1008:             USE IN cursor_4c_Programas
1009:         ENDIF
1010:         IF USED("cursor_4c_ProgramaBusca")
1011:             USE IN cursor_4c_ProgramaBusca
1012:         ENDIF
1013:         IF USED("cursor_4c_Grupos")
1014:             USE IN cursor_4c_Grupos
1015:         ENDIF
1016:         IF USED("cursor_4c_GruposTmp")
1017:             USE IN cursor_4c_GruposTmp
1018:         ENDIF
1019:         IF USED("cursor_4c_Usuarios")
1020:             USE IN cursor_4c_Usuarios
1021:         ENDIF
1022:         IF USED("cursor_4c_UsuariosTmp")
1023:             USE IN cursor_4c_UsuariosTmp
1024:         ENDIF
1025: 
1026:         THIS.this_oBusinessObject = .NULL.
1027: 
1028:         DODEFAULT()
1029:     ENDPROC
1030: 
1031: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCacBO.prg):
*==============================================================================
* SigOpCacBO.prg - Business Object para Consulta de Acesso a Programas
* Herda de: BusinessBase
* Origem: SIGOPCAC.SCX (form operacional, somente consulta)
* Tabelas: SigCdPrg (programas/parametros), SigCdAcu (acesso por grupo/usuario),
*          SigCdUsu (usuarios), SigCdAcG (usuarios por grupo)
*
* Form somente-leitura: nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao().
* O comportamento padrao herdado de BusinessBase ja eh o correto para esta tela.
*==============================================================================

DEFINE CLASS SigOpCacBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao do BusinessBase
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPrg"
    this_cCampoChave = "programas"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO e pre-carrega o cursor de programas/parametros
    * (equivalente ao poDataMgr.SqlExecute(...,'crSigCdPrg1') do Init legado)
    *--------------------------------------------------------------------------
    * O pre-carregamento do cursor de programas eh um CACHE, nao pre-requisito:
    * BuscarPrograma() refaz a carga sob demanda (IF !USED(...)). Por isso o Init
    * devolve .T. mesmo quando a carga falha - devolver .F. faria o
    * CREATEOBJECT("SigOpCacBO") virar .F. e o Form abortaria o proprio Init,
    * deixando a tela sem abrir por uma falha de cache. O legado tambem nao
    * aborta: o Init dele so roda o SqlExecute do crSigCdPrg1.
    FUNCTION Init()
        LOCAL loc_oErro, loc_lValidandoUI

        TRY
            DODEFAULT()

            *-- Nao executa SQL durante validacao de UI / teste automatizado,
            *-- em que gnConnHandle = -1 (padrao canonico do projeto).
            loc_lValidandoUI = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                               (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

            IF !loc_lValidandoUI
                THIS.CarregarProgramas()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.Init")
        ENDTRY

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Popula cursor_4c_Programas com descricaos/programas/
    * parametros de SigCdPrg, com Descricaos em MAIUSCULO (Replace All do legado)
    *--------------------------------------------------------------------------
    FUNCTION CarregarProgramas()
        LOCAL loc_lSucesso, loc_oErro, loc_nResult

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT descricaos, programas, parametros FROM SigCdPrg", ;
                "cursor_4c_Programas")

            IF loc_nResult >= 0
                SELECT cursor_4c_Programas
                REPLACE ALL descricaos WITH UPPER(descricaos) IN cursor_4c_Programas
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar programas cadastrados." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.CarregarProgramas")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarPrograma - Procura par_cTexto em cursor_4c_Programas.descricaos
    * (equivalente ao Valid do Text1 legado, sem a resolucao do browse -
    * a decisao de match unico/multiplo/vazio fica no Form)
    * Resultado em cursor_4c_ProgramaBusca (descricaos, programas, parametros)
    *--------------------------------------------------------------------------
    FUNCTION BuscarPrograma(par_cTexto)
        LOCAL loc_lSucesso, loc_oErro, loc_cBusca

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Programas")
                THIS.CarregarProgramas()
            ENDIF

            IF USED("cursor_4c_Programas")
                loc_cBusca = "%" + UPPER(ALLTRIM(par_cTexto)) + "%"

                IF USED("cursor_4c_ProgramaBusca")
                    USE IN cursor_4c_ProgramaBusca
                ENDIF

                SELECT descricaos, programas, parametros FROM cursor_4c_Programas ;
                    WHERE descricaos LIKE loc_cBusca ;
                    INTO CURSOR cursor_4c_ProgramaBusca READWRITE

                loc_lSucesso = (RECCOUNT("cursor_4c_ProgramaBusca") > 0)
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarPrograma")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Popula cursor_4c_Grupos com os grupos de acesso ao
    * programa/parametro informados (equivalente ao Command1.Click legado)
    * Mantem a linha de grupo VAZIO quando ela nao existir no resultado
    * (legado: If Eof() or !Empty(Grupos) then Append Blank), que representa
    * acesso por supervisor/individual sem grupo especifico.
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            loc_cSQL = "SELECT DISTINCT grupos FROM SigCdAcu " + ;
                       "WHERE programas = " + EscaparSQL(loc_cProg)

            IF !EMPTY(loc_cParm)
                loc_cSQL = loc_cSQL + " AND parametros = " + EscaparSQL(loc_cParm)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupos"

            IF USED("cursor_4c_GruposTmp")
                USE IN cursor_4c_GruposTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Grupos")
                    USE IN cursor_4c_Grupos
                ENDIF

                SELECT grupos FROM cursor_4c_GruposTmp INTO CURSOR cursor_4c_Grupos READWRITE

                IF USED("cursor_4c_GruposTmp")
                    USE IN cursor_4c_GruposTmp
                ENDIF

                SELECT cursor_4c_Grupos
                GO TOP

                IF EOF("cursor_4c_Grupos") OR !EMPTY(cursor_4c_Grupos.grupos)
                    APPEND BLANK IN cursor_4c_Grupos
                ENDIF

                SELECT cursor_4c_Grupos
                INDEX ON grupos TAG grupos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar grupos de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarGrupos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarios - Popula cursor_4c_Usuarios com os usuarios do grupo
    * selecionado (equivalente ao AfterRowColChange do Grid1 legado)
    *
    * par_cGrupo VAZIO -> usuarios supervisores (Supervis IN 'S','I') UNION
    *   usuarios com acesso INDIVIDUAL ao programa/parametro (SigCdAcu com
    *   Grupos em branco)
    * par_cGrupo preenchido -> usuarios vinculados a esse grupo via SigCdAcG
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarios(par_cGrupo, par_cPrograma, par_cParametro)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cProg, loc_cParm

        loc_lSucesso = .F.
        loc_cGrupo   = ALLTRIM(par_cGrupo)
        loc_cProg    = ALLTRIM(par_cPrograma)
        loc_cParm    = ALLTRIM(par_cParametro)

        TRY
            IF EMPTY(loc_cGrupo)
                loc_cSQL = "SELECT DISTINCT usuarios, ncomps, ccargs, deptos, supervis, cativos " + ;
                           "FROM SigCdUsu WHERE supervis IN ('S','I') " + ;
                           "UNION " + ;
                           "SELECT DISTINCT b.usuarios, b.ncomps, b.ccargs, b.deptos, b.supervis, b.cativos " + ;
                           "FROM SigCdAcu a INNER JOIN SigCdUsu b ON a.usuarios = b.usuarios " + ;
                           "WHERE a.grupos = " + EscaparSQL(SPACE(10)) + " " + ;
                           "AND a.programas = " + EscaparSQL(loc_cProg)

                IF !EMPTY(loc_cParm)
                    loc_cSQL = loc_cSQL + " AND a.parametros = " + EscaparSQL(loc_cParm)
                ENDIF
            ELSE
                loc_cSQL = "SELECT DISTINCT a.usuarios, a.ncomps, a.ccargs, a.deptos, a.supervis, a.cativos " + ;
                           "FROM SigCdUsu a LEFT JOIN SigCdAcG b ON a.usuarios = b.usuarios " + ;
                           "WHERE b.grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF USED("cursor_4c_UsuariosTmp")
                USE IN cursor_4c_UsuariosTmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosTmp")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Usuarios")
                    USE IN cursor_4c_Usuarios
                ENDIF

                SELECT usuarios, ncomps, ccargs, deptos, supervis, cativos ;
                    FROM cursor_4c_UsuariosTmp INTO CURSOR cursor_4c_Usuarios READWRITE

                IF USED("cursor_4c_UsuariosTmp")
                    USE IN cursor_4c_UsuariosTmp
                ENDIF

                SELECT cursor_4c_Usuarios
                INDEX ON usuarios TAG usuarios
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao consultar usuarios de acesso." + CHR(13) + CapturarErroSQL(), ;
                        "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpCacBO.BuscarUsuarios")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

