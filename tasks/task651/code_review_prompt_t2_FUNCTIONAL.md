# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCac.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1050 linhas total):

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

*-- Linhas 147 a 256:
147:     *-- flag, CarregarLista reentra em CarregarUsuarios a cada rebind.
148:     this_lCarregando           = .F.
149: 
150:     *-- Guarda de reentrancia do lookup de Programa: o FormBuscaAuxiliar eh
151:     *-- modal e tira o foco do txt_4c_Programa, redisparando o proprio
152:     *-- LostFocus (regra #37/#47) - sem a flag, abriria um segundo picker.
153:     this_lEmLookupPrograma     = .F.
154: 
155:     *-- Ultimo valor de txt_4c_Programa ja validado por ValidarPrograma(). O
156:     *-- legado so dispara o Valid quando o VALOR MUDA; LostFocus dispara
157:     *-- SEMPRE que o foco sai do campo, inclusive sem o texto ter mudado
158:     *-- (ex.: usuario da TAB de volta). Sem este espelho, cada saida do campo
159:     *-- reabriria o lookup sobre um valor ja resolvido.
160:     this_cUltimoValidarProgramaValidado = ""
161: 
162:     *==========================================================================
163:     * Init - Cria o Business Object e delega a inicializacao ao FormBase.Init
164:     *==========================================================================
165:     FUNCTION Init()
166:         THIS.this_oBusinessObject = CREATEOBJECT("SigOpCacBO")
167:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
168:             MsgErro("Erro ao criar SigOpCacBO.", "Erro")
169:             RETURN .F.
170:         ENDIF
171: 
172:         RETURN DODEFAULT()
173:     ENDFUNC
174: 
175:     *==========================================================================
176:     * InicializarForm - Monta a estrutura base do form
177:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
178:     *==========================================================================
179:     PROTECTED PROCEDURE InicializarForm()
180:         LOCAL loc_lSucesso, loc_oErro
181: 
182:         loc_lSucesso = .F.
183: 
184:         TRY
185:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
186: 
187:             THIS.ConfigurarCabecalho()
188: 
189:             THIS.ConfigurarFiltroPrograma()
190: 
191:             THIS.ConfigurarGrids()
192: 
193:             THIS.ConfigurarBotoes()
194: 
195:             THIS.VincularEventos()
196: 
197:             THIS.TornarControlesVisiveis(THIS)
198: 
199:             loc_lSucesso = .T.
200: 
201:         CATCH TO loc_oErro
202:             THIS.this_cMensagemErro = loc_oErro.Message
203:             MsgErro(loc_oErro.Message + CHR(13) + ;
204:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
205:                     "Procedure: " + loc_oErro.Procedure, ;
206:                     "Erro em FormSigOpCac.InicializarForm")
207:         ENDTRY
208: 
209:         RETURN loc_lSucesso
210:     ENDPROC
211: 
212:     *==========================================================================
213:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
214:     * cnt_4c_Cabecalho: Top=0 Left=0 Width=800 Height=80 BackColor=RGB(100,100,100)
215:     *==========================================================================
216:     PROTECTED PROCEDURE ConfigurarCabecalho()
217:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
218:         WITH THIS.cnt_4c_Cabecalho
219:             .Top         = 0
220:             .Left        = 0
221:             .Width       = THIS.Width
222:             .Height      = 80
223:             .BackStyle   = 1
224:             .BackColor   = RGB(100, 100, 100)
225:             .BorderWidth = 0
226:             .Visible     = .T.
227:         ENDWITH
228: 
229:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblSombra", "Label")
230:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblSombra
231:             .Top        = 18
232:             .Left       = 10
233:             .Width      = 769
234:             .Height     = 40
235:             .FontName   = "Tahoma"
236:             .FontSize   = 18
237:             .FontBold   = .T.
238:             .ForeColor  = RGB(0, 0, 0)
239:             .BackStyle  = 0
240:             .WordWrap   = .T.
241:             .AutoSize   = .F.
242:             .Alignment  = 0
243:             .Caption    = THIS.Caption
244:             .Visible    = .T.
245:         ENDWITH
246: 
247:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_LblTitulo", "Label")
248:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_LblTitulo
249:             .Top        = 17
250:             .Left       = 10
251:             .Width      = 769
252:             .Height     = 46
253:             .FontName   = "Tahoma"
254:             .FontSize   = 18
255:             .FontBold   = .T.
256:             .ForeColor  = RGB(255, 255, 255)

*-- Linhas 279 a 363:
279:     * lookup fwBuscaInt do Valid (ValidarPrograma/AbrirBuscaPrograma, Fase 6),
280:     * ligado em VincularEventos().
281:     *==========================================================================
282:     PROTECTED PROCEDURE ConfigurarFiltroPrograma()
283:         THIS.AddObject("lbl_4c_Programa", "Label")
284:         WITH THIS.lbl_4c_Programa
285:             .Top       = 100
286:             .Left      = 58
287:             .Width     = 55
288:             .Height    = 15
289:             .FontName  = "Tahoma"
290:             .FontSize  = 8
291:             .ForeColor = RGB(90, 90, 90)
292:             .BackStyle = 0
293:             .AutoSize  = .F.
294:             .Alignment = 0
295:             .Caption   = "Programa :"
296:             .Visible   = .T.
297:         ENDWITH
298: 
299:         THIS.AddObject("txt_4c_Programa", "TextBox")
300:         WITH THIS.txt_4c_Programa
301:             .Top       = 96
302:             .Left      = 130
303:             .Width     = 614
304:             .Height    = 23
305:             .MaxLength = 100
306:             .FontName  = "Tahoma"
307:             .FontSize  = 8
308:             .Value     = ""
309:             .ForeColor = RGB(90, 90, 90)
310:             .BackColor = RGB(255, 255, 255)
311:             .Visible   = .T.
312:         ENDWITH
313:     ENDPROC
314: 
315:     *==========================================================================
316:     * ConfigurarGrids - Grid1 (grupos de acesso) e Grid2 (usuarios do grupo)
317:     * RecordSource/ControlSource NAO sao definidos aqui: os cursores
318:     * cursor_4c_Grupos/cursor_4c_Usuarios ainda nao existem neste momento
319:     * (so nascem quando o usuario consulta - Command1.Click/AfterRowColChange
320:     * do legado). Definir ControlSource agora estouraria "Alias is not found"
321:     * dentro do TRY do InicializarForm.
322:     *==========================================================================
323:     PROTECTED PROCEDURE ConfigurarGrids()
324:         *-- Grid1 legado -> grd_4c_Grupos (coluna unica "Grupo")
325:         THIS.AddObject("grd_4c_Grupos", "Grid")
326:         WITH THIS.grd_4c_Grupos
327:             .Top           = 130
328:             .Left          = 31
329:             .Width         = 113
330:             .Height        = 396
331:             .HeaderHeight       = 0
332:             .ColumnCount   = 1
333:             .Panel         = 1
334:             .FontName      = "Tahoma"
335:             .ForeColor     = RGB(90, 90, 90)
336:             .GridLineColor = RGB(238, 238, 238)
337:             .ReadOnly      = .T.
338:             .DeleteMark    = .F.
339:             .RecordMark    = .F.
340:             .ScrollBars    = 2
341:             .Visible       = .T.
342:         ENDWITH
343: 
344:         THIS.AplicarFormatoGrdGrupos()
345: 
346:         *-- Grid2 legado -> grd_4c_Usuarios (Usuario/Nome/Cargo/Depto/Tipo)
347:         THIS.AddObject("grd_4c_Usuarios", "Grid")
348:         WITH THIS.grd_4c_Usuarios
349:             .Top           = 131
350:             .Left          = 149
351:             .Width         = 614
352:             .Height        = 395
353:             .HeaderHeight       = 0
354:             .ColumnCount   = 5
355:             .Panel         = 1
356:             .FontName      = "Tahoma"
357:             .ForeColor     = RGB(90, 90, 90)
358:             .GridLineColor = RGB(238, 238, 238)
359:             .ReadOnly      = .T.
360:             .DeleteMark    = .F.
361:             .RecordMark    = .F.
362:             .ScrollBars    = 2
363:             .Visible       = .T.

*-- Linhas 374 a 508:
374:     * Header1.Caption para o default (Problema 48 do CLAUDE.md): tem de ser
375:     * reaplicado a cada rebind, nao so na montagem inicial.
376:     *==========================================================================
377:     PROTECTED PROCEDURE AplicarFormatoGrdGrupos()
378:         WITH THIS.grd_4c_Grupos.Column1
379:             .FontName   = "Tahoma"
380:             .Width      = 81
381:             .Movable    = .F.
382:             .Resizable  = .F.
383:             .ReadOnly   = .T.
384:             .ForeColor  = RGB(90, 90, 90)
385:         ENDWITH
386: 
387:         WITH THIS.grd_4c_Grupos.Column1.Header1
388:             .FontName  = "Tahoma"
389:             .FontSize  = 8
390:             .Alignment = 2
391:             .Caption   = "Grupo"
392:             .ForeColor = RGB(36, 84, 155)
393:         ENDWITH
394: 
395:         WITH THIS.grd_4c_Grupos.Column1.Text1
396:             .FontName    = "Tahoma"
397:             .BorderStyle = 0
398:             .Margin      = 0
399:             .ReadOnly    = .T.
400:             .ForeColor   = RGB(90, 90, 90)
401:             .BackColor   = RGB(255, 255, 255)
402:         ENDWITH
403:     ENDPROC
404: 
405:     *==========================================================================
406:     * AplicarFormatoGrdUsuarios - Larguras/headers das 5 colunas de
407:     * grd_4c_Usuarios, transcritas do SCX (Grid2.ColumnN.Width/Header1.Caption).
408:     * Reaplicado a cada rebind pelo mesmo motivo do AplicarFormatoGrdGrupos.
409:     *==========================================================================
410:     PROTECTED PROCEDURE AplicarFormatoGrdUsuarios()
411:         *-- O 5o argumento eh "centralizar o header": o SCX declara
412:         *-- Alignment = 2 nos Header1 das colunas 1 a 4 e NAO declara nada na
413:         *-- coluna 5 ("Tipo"), que portanto fica no default da classe Header.
414:         *-- Como o dump do Form Designer so grava o que DIFERE do default, o
415:         *-- default nao pode ser 2 - logo setar 2 na coluna 5 seria desvio.
416:         *-- Nao atribuir eh fiel independentemente de qual seja o default.
417:         THIS.ConfigurarColunaGrdUsuarios(1, 80,  "Usuario", RGB(36, 84, 155), .T.)
418:         THIS.ConfigurarColunaGrdUsuarios(2, 292, "Nome",    RGB(90, 90, 90),  .T.)
419:         THIS.ConfigurarColunaGrdUsuarios(3, 90,  "Cargo",   RGB(90, 90, 90),  .T.)
420:         THIS.ConfigurarColunaGrdUsuarios(4, 90,  "Depto",   RGB(90, 90, 90),  .T.)
421:         THIS.ConfigurarColunaGrdUsuarios(5, 26,  "Tipo",    RGB(90, 90, 90),  .F.)
422:     ENDPROC
423: 
424:     *==========================================================================
425:     * ConfigurarColunaGrdUsuarios - Aplica largura/header/celula padrao numa
426:     * coluna de grd_4c_Usuarios (evita repetir o bloco 5 vezes)
427:     *==========================================================================
428:     PROTECTED PROCEDURE ConfigurarColunaGrdUsuarios(par_nColuna, par_nWidth, par_cCaption, par_nForeColorHeader, par_lCentralizar)
429:         LOCAL loc_oColuna
430: 
431:         loc_oColuna = THIS.grd_4c_Usuarios.Columns(par_nColuna)
432: 
433:         WITH loc_oColuna
434:             .FontName  = "Tahoma"
435:             .Width     = par_nWidth
436:             .Movable   = .F.
437:             .Resizable = .F.
438:             .ReadOnly  = .T.
439:             .ForeColor = RGB(90, 90, 90)
440:         ENDWITH
441: 
442:         WITH loc_oColuna.Header1
443:             .FontName  = "Tahoma"
444:             .FontSize  = 8
445:             .Caption   = par_cCaption
446:             .ForeColor = par_nForeColorHeader
447:         ENDWITH
448: 
449:         IF VARTYPE(par_lCentralizar) = "L" AND par_lCentralizar
450:             loc_oColuna.Header1.Alignment = 2
451:         ENDIF
452: 
453:         WITH loc_oColuna.Text1
454:             .FontName    = "Tahoma"
455:             .BorderStyle = 0
456:             .Margin      = 0
457:             .ReadOnly    = .T.
458:             .ForeColor   = RGB(90, 90, 90)
459:             .BackColor   = RGB(255, 255, 255)
460:         ENDWITH
461:     ENDPROC
462: 
463:     *==========================================================================
464:     * ConfigurarBotoes - Commandgroup1 legado -> cmg_4c_Botoes
465:     * Buttons(1) = Consultar (busca grupos de acesso do programa selecionado)
466:     * Buttons(2) = Encerrar (Release Windows no legado)
467:     *==========================================================================
468:     PROTECTED PROCEDURE ConfigurarBotoes()
469:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
470:         WITH THIS.cmg_4c_Botoes
471:             .Top           = -2
472:             .Left          = 644
473:             .Width         = 160
474:             .Height        = 85
475:             .ButtonCount   = 2
476:             .BackStyle     = 0
477:             .BorderStyle   = 0
478:             .SpecialEffect = 1
479:             .BorderColor   = RGB(136, 189, 188)
480:             .Visible       = .T.
481:         ENDWITH
482: 
483:         WITH THIS.cmg_4c_Botoes.Buttons(1)
484:             .Top         = 5
485:             .Left        = 5
486:             .Width       = 75
487:             .Height      = 75
488:             .Caption     = "Consultar"
489:             .ToolTipText = "Consultar"
490:             .Picture     = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
491:             .FontName    = "Comic Sans MS"
492:             .FontSize    = 8
493:             .FontBold    = .T.
494:             .FontItalic  = .T.
495:             .WordWrap    = .T.
496:             .ForeColor   = RGB(90, 90, 90)
497:             .BackColor   = RGB(255, 255, 255)
498:             .Themes      = .F.
499:         ENDWITH
500: 
501:         WITH THIS.cmg_4c_Botoes.Buttons(2)
502:             .Top         = 5
503:             .Left        = 80
504:             .Width       = 75
505:             .Height      = 75
506:             .Cancel      = .T.
507:             .Caption     = "Encerrar"
508:             .ToolTipText = "[ESC] Sair"

*-- Linhas 519 a 676:
519:     ENDPROC
520: 
521:     *==========================================================================
522:     * VincularEventos - BINDEVENT dos botoes e da grade mestre
523:     *
524:     * Commandgroup1 legado tem Command1.Click (Consultar) e Command2.Click
525:     * (Encerrar) como metodos SEPARADOS, por isso o bind eh por botao e nao no
526:     * grupo. Os handlers sao PUBLIC de proposito: BINDEVENT falha em silencio
527:     * com metodo PROTECTED (regra #3 do CLAUDE.md).
528:     *==========================================================================
529:     PROTECTED PROCEDURE VincularEventos()
530:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConsultarClick")
531:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")
532: 
533:         *-- Grid1.AfterRowColChange legado: carrega a grade de usuarios a partir
534:         *-- da linha CORRENTE da grade de grupos. Uso mestre-detalhe, que eh o
535:         *-- caso CORRETO de AfterRowColChange (regra #46) - nao ha filtro por
536:         *-- coluna, a grade tem uma coluna so.
537:         BINDEVENT(THIS.grd_4c_Grupos, "AfterRowColChange", THIS, "GradeGruposAfterRowColChange")
538: 
539:         *-- Text1.GotFocus legado: Delete All + Go Top + Refresh nos dois
540:         *-- cursores ao reentrar no campo - aqui, desvincular as duas grades
541:         *-- via LimparGrades() (ja implementado na Fase 4).
542:         BINDEVENT(THIS.txt_4c_Programa, "GotFocus", THIS, "TxtProgramaGotFocus")
543: 
544:         *-- Text1.Valid legado: valida ao SAIR do campo (regra #47 - NUNCA
545:         *-- KeyPress sem teste de tecla, senao o picker abriria a cada letra
546:         *-- digitada). F4 fica como atalho explicito para o mesmo fluxo.
547:         BINDEVENT(THIS.txt_4c_Programa, "LostFocus", THIS, "ValidarPrograma")
548:         BINDEVENT(THIS.txt_4c_Programa, "KeyPress", THIS, "TxtProgramaKeyPress")
549:     ENDPROC
550: 
551:     *==========================================================================
552:     * CarregarLista - Consulta os grupos com acesso ao programa selecionado e
553:     * vincula a grade mestre (equivalente ao Command1.Click legado)
554:     *
555:     * Legado: If !Empty(pcPrograma) -> limpa as duas grades -> SqlExecute do
556:     * Select Distinct Grupos From SigCdAcu -> Append Blank da linha de grupo
557:     * vazio -> Index On Grupos -> bind do Grid1 -> Grid1.SetFocus (que dispara
558:     * o AfterRowColChange e popula o Grid2).
559:     *==========================================================================
560:     PROCEDURE CarregarLista()
561:         LOCAL loc_lSucesso, loc_oErro, loc_oGrid
562: 
563:         loc_lSucesso = .F.
564: 
565:         *-- Guard do legado: sem programa escolhido o Click nao faz nada
566:         IF EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado))
567:             RETURN .F.
568:         ENDIF
569: 
570:         IF THIS.this_lCarregando
571:             RETURN .F.
572:         ENDIF
573: 
574:         THIS.this_lCarregando = .T.
575: 
576:         TRY
577:             THIS.LimparGrades()
578: 
579:             IF THIS.this_oBusinessObject.BuscarGrupos(THIS.this_cProgramaSelecionado, ;
580:                                                       THIS.this_cParametroSelecionado)
581: 
582:                 loc_oGrid = THIS.grd_4c_Grupos
583: 
584:                 *-- Ordem obrigatoria (regra #41): ColumnCount -> RecordSource ->
585:                 *-- ControlSource -> Width/Caption. O ColumnCount explicito evita
586:                 *-- que o RecordSource auto-expanda a grade para as colunas do
587:                 *-- cursor, e o formato vem DEPOIS porque RecordSource o reseta.
588:                 loc_oGrid.RecordSource = ""
589:                 loc_oGrid.ColumnCount  = 1
590:                 loc_oGrid.RecordSource = "cursor_4c_Grupos"
591:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Grupos.grupos"
592: 
593:                 THIS.AplicarFormatoGrdGrupos()
594: 
595:                 *-- Legado: Go Top + (Grid1.SetFocus). Sem GO TOP + Refresh a
596:                 *-- grade nao repinta as linhas inseridas (regra #21).
597:                 SELECT cursor_4c_Grupos
598:                 GO TOP
599:                 loc_oGrid.Refresh()
600: 
601:                 loc_lSucesso = .T.
602:             ENDIF
603: 
604:         CATCH TO loc_oErro
605:             MsgErro(loc_oErro.Message + CHR(13) + ;
606:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
607:                     "Procedure: " + loc_oErro.Procedure, ;
608:                     "Erro em FormSigOpCac.CarregarLista")
609:         ENDTRY
610: 
611:         *-- O SetFocus do legado vai AINDA COM A FLAG LIGADA, de proposito: ele
612:         *-- dispara o AfterRowColChange da grade mestre, e deixar esse disparo
613:         *-- passar faria a consulta de usuarios rodar DUAS vezes por clique
614:         *-- (medido: 2 chamadas). Com o disparo descartado aqui, a carga do
615:         *-- detalhe acontece UMA vez, na chamada explicita abaixo.
616:         IF loc_lSucesso
617:             THIS.grd_4c_Grupos.SetFocus()
618:         ENDIF
619: 
620:         THIS.this_lCarregando = .F.
621: 
622:         IF loc_lSucesso
623:             THIS.CarregarUsuarios()
624:         ENDIF
625: 
626:         RETURN loc_lSucesso
627:     ENDPROC
628: 
629:     *==========================================================================
630:     * CarregarUsuarios - Consulta os usuarios da linha corrente da grade de
631:     * grupos e vincula a grade de detalhe (equivalente ao AfterRowColChange)
632:     *
633:     * Grupo VAZIO -> supervisores + acesso individual ao programa/parametro
634:     * Grupo preenchido -> usuarios vinculados ao grupo (SigCdAcG)
635:     *==========================================================================
636:     PROCEDURE CarregarUsuarios()
637:         LOCAL loc_lSucesso, loc_oErro, loc_oGrid, loc_cGrupo
638: 
639:         loc_lSucesso = .F.
640: 
641:         *-- Legado: If Used('crGrupos'). Sem a grade mestre populada nao ha o
642:         *-- que detalhar.
643:         IF !USED("cursor_4c_Grupos")
644:             RETURN .F.
645:         ENDIF
646: 
647:         *-- Le o grupo da linha CORRENTE sem mover o ponteiro do cursor mestre:
648:         *-- um GO/SEEK aqui reposicionaria a grade de grupos e redispararia o
649:         *-- proprio AfterRowColChange.
650:         loc_cGrupo = ""
651:         IF !EOF("cursor_4c_Grupos") AND !BOF("cursor_4c_Grupos")
652:             loc_cGrupo = ALLTRIM(NVL(cursor_4c_Grupos.grupos, ""))
653:         ENDIF
654: 
655:         TRY
656:             *-- Legado: ThisForm.Grid2.RecordSource = '' no inicio do handler
657:             THIS.grd_4c_Usuarios.RecordSource = ""
658: 
659:             IF THIS.this_oBusinessObject.BuscarUsuarios(loc_cGrupo, ;
660:                                                         THIS.this_cProgramaSelecionado, ;
661:                                                         THIS.this_cParametroSelecionado)
662: 
663:                 THIS.this_cGrupoSelecionado = loc_cGrupo
664: 
665:                 loc_oGrid = THIS.grd_4c_Usuarios
666: 
667:                 loc_oGrid.ColumnCount  = 5
668:                 loc_oGrid.RecordSource = "cursor_4c_Usuarios"
669:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Usuarios.usuarios"
670:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Usuarios.ncomps"
671:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Usuarios.ccargs"
672:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Usuarios.deptos"
673:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Usuarios.supervis"
674: 
675:                 THIS.AplicarFormatoGrdUsuarios()
676: 

*-- Linhas 696 a 1050:
696:         CATCH TO loc_oErro
697:             MsgErro(loc_oErro.Message + CHR(13) + ;
698:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
699:                     "Procedure: " + loc_oErro.Procedure, ;
700:                     "Erro em FormSigOpCac.CarregarUsuarios")
701:         ENDTRY
702: 
703:         RETURN loc_lSucesso
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * GradeGruposAfterRowColChange - Handler do AfterRowColChange de
708:     * grd_4c_Grupos: troca de linha na grade mestre recarrega a de detalhe.
709:     * A assinatura DEVE declarar o parametro do evento (regra #3).
710:     *==========================================================================
711:     PROCEDURE GradeGruposAfterRowColChange(par_nColIndex)
712:         IF THIS.this_lCarregando
713:             RETURN
714:         ENDIF
715: 
716:         THIS.this_lCarregando = .T.
717:         THIS.CarregarUsuarios()
718:         THIS.this_lCarregando = .F.
719:     ENDPROC
720: 
721:     *==========================================================================
722:     * LimparGrades - Esvazia as duas grades (equivalente ao Text1.GotFocus
723:     * legado, que faz Delete All + Go Top + Refresh nos dois cursores).
724:     *
725:     * Desvincula o RecordSource em vez de apagar as linhas: os cursores sao
726:     * recriados pelo BO a cada consulta, e grade apontando para alias fechado
727:     * exibiria linhas do registro anterior.
728:     *==========================================================================
729:     PROCEDURE LimparGrades()
730:         THIS.grd_4c_Grupos.RecordSource   = ""
731:         THIS.grd_4c_Usuarios.RecordSource = ""
732: 
733:         THIS.this_cGrupoSelecionado = ""
734: 
735:         THIS.grd_4c_Grupos.Refresh()
736:         THIS.grd_4c_Usuarios.Refresh()
737:     ENDPROC
738: 
739:     *==========================================================================
740:     * TxtProgramaGotFocus - Text1.GotFocus legado. PUBLIC porque eh chamado
741:     * via BINDEVENT (regra #3 - metodo PROTECTED falha em silencio).
742:     *==========================================================================
743:     PROCEDURE TxtProgramaGotFocus()
744:         THIS.LimparGrades()
745:     ENDPROC
746: 
747:     *==========================================================================
748:     * ValidarPrograma - Text1.Valid legado, ligado a "LostFocus" (regra #47).
749:     * PUBLIC porque eh chamado via BINDEVENT (regra #3).
750:     *
751:     * Legado: campo vazio -> limpa pcPrograma/pcParametro. Campo preenchido ->
752:     * delega para AbrirBuscaPrograma (busca + resolve/avisa/abre picker).
753:     *==========================================================================
754:     PROCEDURE ValidarPrograma()
755:         LOCAL loc_cValor
756: 
757:         *-- Guarda de reentrancia: o picker modal de AbrirBuscaPrograma tira o
758:         *-- foco do campo, o que redispara este mesmo LostFocus.
759:         IF THIS.this_lEmLookupPrograma
760:             RETURN
761:         ENDIF
762: 
763:         loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)
764: 
765:         *-- Guarda de valor-nao-mudou: no legado o Valid so dispara quando o
766:         *-- VALOR MUDA; aqui o LostFocus dispara sempre que o foco sai do
767:         *-- campo. Sem esta comparacao, reentrar e saltar fora do campo sem
768:         *-- alterar o texto (TAB de volta, clique no botao) reabriria o
769:         *-- lookup sobre um valor que ja esta resolvido.
770:         IF loc_cValor == THIS.this_cUltimoValidarProgramaValidado
771:             RETURN
772:         ENDIF
773: 
774:         IF EMPTY(loc_cValor)
775:             THIS.this_cProgramaSelecionado  = ""
776:             THIS.this_cParametroSelecionado = ""
777:             THIS.this_cDescricaoSelecionada = ""
778:             THIS.this_cUltimoValidarProgramaValidado = loc_cValor
779:             RETURN
780:         ENDIF
781: 
782:         THIS.this_lEmLookupPrograma = .T.
783:         THIS.AbrirBuscaPrograma()
784:         THIS.this_lEmLookupPrograma = .F.
785: 
786:         THIS.this_cUltimoValidarProgramaValidado = ALLTRIM(THIS.txt_4c_Programa.Value)
787:     ENDPROC
788: 
789:     *==========================================================================
790:     * TxtProgramaKeyPress - Atalho F4 explicito para o mesmo lookup do Valid.
791:     * PUBLIC + assinatura com os parametros do evento (regra #3).
792:     *==========================================================================
793:     PROCEDURE TxtProgramaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
794:         IF par_nKeyCode != 115
795:             RETURN
796:         ENDIF
797: 
798:         IF THIS.this_lEmLookupPrograma
799:             RETURN
800:         ENDIF
801: 
802:         THIS.this_lEmLookupPrograma = .T.
803:         THIS.AbrirBuscaPrograma()
804:         THIS.this_lEmLookupPrograma = .F.
805:     ENDPROC
806: 
807:     *==========================================================================
808:     * AbrirBuscaPrograma - Corpo do lookup (Text1.Valid legado)
809:     *
810:     * Legado: Select ... From crSigCdPrg1 Where Descricaos Like '%texto%' ->
811:     *   Eof() (zero linhas) -> MessageBox + Return(.F.) (NAO limpa o digitado,
812:     *     so nao resolve pcPrograma/pcParametro)
813:     *   Reccount() > 1 -> abre fwBuscaInt (browse sobre o cursor filtrado)
814:     *   Lastkey() <> 27 (nao cancelou) -> This.Value/pcPrograma/pcParametro =
815:     *     registro corrente do cursor filtrado
816:     *   Lastkey() == 27 (ESC) -> limpa os tres
817:     *
818:     * SigOpCacBO.BuscarPrograma ja faz a busca LIKE no cursor local
819:     * cursor_4c_Programas (equivalente a crSigCdPrg1) e popula
820:     * cursor_4c_ProgramaBusca - por isso o picker usa FormBuscaAuxiliar em
821:     * modo Pattern A (cursor ja pronto), sem reconsultar o SQL Server.
822:     *
823:     * Sem RETURN dentro do TRY (regra #1): fluxo controlado por loc_lProsseguir.
824:     *==========================================================================
825:     PROCEDURE AbrirBuscaPrograma()
826:         LOCAL loc_oBusca, loc_cValor, loc_lProsseguir, loc_oErro
827: 
828:         loc_cValor      = ALLTRIM(THIS.txt_4c_Programa.Value)
829:         loc_lProsseguir = !EMPTY(loc_cValor)
830: 
831:         TRY
832:             IF loc_lProsseguir
833:                 IF !THIS.this_oBusinessObject.BuscarPrograma(loc_cValor)
834:                     *-- Legado: MessageBox('Parametros nao Localizado',16,'')
835:                     *-- + Return(.f.) - NAO ha picker a seguir (universo
836:                     *-- vazio), entao o aviso eh FIEL ao legado; o texto
837:                     *-- digitado NAO eh apagado (regra #50 nao se aplica -
838:                     *-- aqui o legado avisa mesmo, por nao sobrar picker).
839:                     MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
840:                              "Aten" + CHR(231) + CHR(227) + "o")
841:                     loc_lProsseguir = .F.
842:                 ENDIF
843:             ENDIF
844: 
845:             IF loc_lProsseguir
846:                 IF RECCOUNT("cursor_4c_ProgramaBusca") = 1
847:                     *-- Legado: Reccount()=1 nao abre o browse - o unico
848:                     *-- registro ja eh o corrente em crSigCdPrg.
849:                     SELECT cursor_4c_ProgramaBusca
850:                     GO TOP
851:                     THIS.AplicarProgramaSelecionado()
852:                 ELSE
853:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
854:                     loc_oBusca.this_cCursorDestino = "cursor_4c_ProgramaBusca"
855: 
856:                     *-- Titulo do browse legado: no fwBuscaInt do Text1.Valid o
857:                     *-- 5o argumento eh o titulo da janela, e vale Programas.
858:                     *-- Sem isto o picker abre com o default "Procura" do
859:                     *-- FormBuscaAuxiliar.
860:                     loc_oBusca.this_cTitulo = "Programas"
861:                     loc_oBusca.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Programas"
862: 
863:                     *-- DUAS colunas, e nao a UNICA do browse legado, por causa
864:                     *-- de como o FormBuscaAuxiliar dimensiona a grade: ele
865:                     *-- IGNORA a mascara passada em mAddColuna e fixa a 1a
866:                     *-- coluna em 80px, dividindo o restante entre as demais.
867:                     *-- O legado dimensiona pela mascara - mAddColuna com
868:                     *-- Replicate("X", 85) -, e SigCdPrg.descricaos eh
869:                     *-- char(150): numa coluna unica o texto sairia cortado em
870:                     *-- 80px de 348 disponiveis, deixando o usuario sem como
871:                     *-- distinguir um programa do outro. Pondo a descricao na
872:                     *-- 2a coluna ela recebe a largura restante e fica legivel,
873:                     *-- que eh o que o browse legado entrega. A 1a coluna exibe
874:                     *-- SigCdPrg.programas - o proprio identificador que da
875:                     *-- titulo ao browse no legado ("Programas"), nao um dado
876:                     *-- inventado.
877:                     loc_oBusca.mAddColuna("programas",  "", "Programa")
878:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
879:                     loc_oBusca.Show()
880: 
881:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_ProgramaBusca")
882:                         THIS.AplicarProgramaSelecionado()
883:                     ELSE
884:                         *-- Legado: Lastkey() == 27 (ESC) -> limpa os tres
885:                         THIS.txt_4c_Programa.Value       = ""
886:                         THIS.this_cProgramaSelecionado   = ""
887:                         THIS.this_cParametroSelecionado  = ""
888:                         THIS.this_cDescricaoSelecionada  = ""
889:                     ENDIF
890: 
891:                     loc_oBusca.Release()
892:                 ENDIF
893:             ENDIF
894: 
895:         CATCH TO loc_oErro
896:             MsgErro(loc_oErro.Message + CHR(13) + ;
897:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
898:                     "Procedure: " + loc_oErro.Procedure, ;
899:                     "Erro em FormSigOpCac.AbrirBuscaPrograma")
900:         ENDTRY
901:     ENDPROC
902: 
903:     *==========================================================================
904:     * AplicarProgramaSelecionado - Copia o registro corrente de
905:     * cursor_4c_ProgramaBusca para o campo e para this_cProgramaSelecionado/
906:     * this_cParametroSelecionado (equivalente a This.Value/pcPrograma/
907:     * pcParametro = crSigCdPrg.Descricaos/Programas/Parametros do legado)
908:     *==========================================================================
909:     PROTECTED PROCEDURE AplicarProgramaSelecionado()
910:         IF !USED("cursor_4c_ProgramaBusca")
911:             RETURN
912:         ENDIF
913: 
914:         SELECT cursor_4c_ProgramaBusca
915:         THIS.txt_4c_Programa.Value      = ALLTRIM(NVL(descricaos, ""))
916:         THIS.this_cProgramaSelecionado  = ALLTRIM(NVL(programas, ""))
917:         THIS.this_cParametroSelecionado = ALLTRIM(NVL(parametros, ""))
918: 
919:         *-- Espelho do texto que ficou NO CAMPO depois de resolver: eh contra
920:         *-- ele que o botao de acao confere se o campo ainda esta resolvido
921:         *-- (ValidarPreAcao) - no legado essa conferencia eh implicita, porque
922:         *-- o Valid devolve .F. e o foco NAO SAI do campo nao resolvido.
923:         THIS.this_cDescricaoSelecionada = THIS.txt_4c_Programa.Value
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * ValidarPreAcao - Guarda unica dos eventos de botao (Pattern #173/#174)
928:     *
929:     * O txt_4c_Programa eh a FONTE UNICA do que o usuario quer consultar: ele
930:     * esta visivel na tela e nao ha fallback para estado anterior. No legado
931:     * esta conferencia eh IMPLICITA - o Text1.Valid termina em Return(.f.)
932:     * quando o texto nao casa nenhum programa, e o foco NAO SAI do campo, de
933:     * modo que o usuario nem alcanca o Commandgroup1. Aqui o lookup roda em
934:     * LostFocus, que nao bloqueia o foco (regra #47), entao sem esta guarda o
935:     * Consultar rodaria com o programa RESOLVIDO ANTERIORMENTE enquanto o
936:     * campo exibe outro texto - consulta muda sem o usuario pedir.
937:     *
938:     * NUNCA apaga o texto digitado (regra #50): so avisa e devolve o foco.
939:     *==========================================================================
940:     PROTECTED FUNCTION ValidarPreAcao(par_cAcao)
941:         LOCAL loc_cValor, loc_lOk
942: 
943:         loc_lOk    = .F.
944:         loc_cValor = ALLTRIM(THIS.txt_4c_Programa.Value)
945: 
946:         DO CASE
947:             CASE EMPTY(loc_cValor)
948:                 *-- Legado: o Click fica inerte com pcPrograma vazio (If !Empty).
949:                 *-- Sem feedback o usuario clica e nada acontece, por isso o aviso.
950:                 MsgAviso("Informe o programa antes de consultar.", ;
951:                          "Aten" + CHR(231) + CHR(227) + "o")
952: 
953:             CASE EMPTY(ALLTRIM(THIS.this_cProgramaSelecionado)) OR ;
954:                  UPPER(loc_cValor) != UPPER(ALLTRIM(THIS.this_cDescricaoSelecionada))
955:                 *-- Texto no campo divergente do programa resolvido (ou nenhum
956:                 *-- resolvido): mesma mensagem do legado para texto que nao casa.
957:                 MsgAviso("Parametros n" + CHR(227) + "o Localizado.", ;
958:                          "Aten" + CHR(231) + CHR(227) + "o")
959: 
960:             OTHERWISE
961:                 loc_lOk = .T.
962:         ENDCASE
963: 
964:         *-- Devolve o foco ao campo, como o Return(.f.) do Valid legado faz.
965:         *-- Guardado por Visible/Enabled: SetFocus em controle de form ainda nao
966:         *-- exibido (harness headless) estoura erro de runtime.
967:         IF !loc_lOk AND THIS.Visible AND THIS.txt_4c_Programa.Visible ;
968:            AND THIS.txt_4c_Programa.Enabled
969:             THIS.txt_4c_Programa.SetFocus()
970:         ENDIF
971: 
972:         RETURN loc_lOk
973:     ENDFUNC
974: 
975:     *==========================================================================
976:     * BtnConsultarClick - Command1.Click legado (botao "Consultar")
977:     *
978:     * Legado: If !Empty(ThisForm.pcPrograma) -> limpa as duas grades -> Select
979:     * Distinct Grupos From SigCdAcu -> Append Blank -> Index On Grupos -> bind
980:     * do Grid1 -> Grid1.SetFocus (que cascateia no AfterRowColChange e popula o
981:     * Grid2). Todo esse corpo mora em CarregarLista(), chamado daqui.
982:     *==========================================================================
983:     PROCEDURE BtnConsultarClick()
984:         IF !THIS.ValidarPreAcao("CONSULTAR")
985:             RETURN
986:         ENDIF
987: 
988:         THIS.CarregarLista()
989:     ENDPROC
990: 
991:     *==========================================================================
992:     * BtnEncerrarClick - Command2.Click legado ("Release Windows")
993:     *
994:     * Buttons(2).Cancel = .T. faz o ESC cair aqui, como no legado (ToolTipText
995:     * "[ESC] Sair"). Os cursores sao fechados no Destroy, que o Release dispara.
996:     *==========================================================================
997:     PROCEDURE BtnEncerrarClick()
998:         THIS.Release()
999:     ENDPROC
1000: 
1001:     *==========================================================================
1002:     * TornarControlesVisiveis - Recursivo, aplica Visible=.T. em toda hierarquia
1003:     * Form flat sem containers flutuantes, portanto sem lista de skip.
1004:     *==========================================================================
1005:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1006:         LOCAL loc_i, loc_oControl
1007: 
1008:         FOR loc_i = 1 TO par_oContainer.ControlCount
1009:             loc_oControl = par_oContainer.Controls(loc_i)
1010: 
1011:             IF VARTYPE(loc_oControl) = "O"
1012:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1013:                     loc_oControl.Visible = .T.
1014:                 ENDIF
1015:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1016:                     THIS.TornarControlesVisiveis(loc_oControl)
1017:                 ENDIF
1018:             ENDIF
1019:         ENDFOR
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * Destroy - Libera cursores e recursos. DODEFAULT no fim (rebuild menu).
1024:     *==========================================================================
1025:     PROCEDURE Destroy()
1026:         IF USED("cursor_4c_Programas")
1027:             USE IN cursor_4c_Programas
1028:         ENDIF
1029:         IF USED("cursor_4c_ProgramaBusca")
1030:             USE IN cursor_4c_ProgramaBusca
1031:         ENDIF
1032:         IF USED("cursor_4c_Grupos")
1033:             USE IN cursor_4c_Grupos
1034:         ENDIF
1035:         IF USED("cursor_4c_GruposTmp")
1036:             USE IN cursor_4c_GruposTmp
1037:         ENDIF
1038:         IF USED("cursor_4c_Usuarios")
1039:             USE IN cursor_4c_Usuarios
1040:         ENDIF
1041:         IF USED("cursor_4c_UsuariosTmp")
1042:             USE IN cursor_4c_UsuariosTmp
1043:         ENDIF
1044: 
1045:         THIS.this_oBusinessObject = .NULL.
1046: 
1047:         DODEFAULT()
1048:     ENDPROC
1049: 
1050: ENDDEFINE


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

