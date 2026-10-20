# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADERS] Metodo CarregarGradeLista redefine RecordSource mas NAO redefine Header1.Caption. Headers ficam com nomes de campo (ex: 'Contas') ao inves de titulos legiveis (ex: 'Conta'). OBRIGATORIO redefinir TODOS os Header1.Caption APOS RecordSource.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg) - TRECHOS RELEVANTES PARA PASS GRID (1470 linhas total):

*-- Linhas 6 a 24:
6: *   Legado (SIGCDLPR.PAGINA.Dados.COPIA.Click):
7: *       Do Form SigPrSlp With ThisForm, CrSigCdLpc.lprecos
8: *   O 2o argumento eh a lista CORRENTE do pai, que serve a DOIS propositos no
9: *   legado: filtrar grd_4c_Listas (Init: "Where lprecos <> ?") e ser gravado
10: *   em m.lprecos no Command1.Click - por isso this_cLPrecoAtual eh usado nos
11: *   dois lugares. O 3o eh opcional (ver ResolverCursorDestino).
12: * Tabelas: SigCdLpc (cabecalho lista), SigCdLpi (itens lista)
13: * Legado: SIGPRSLP.SCX (form, Width=800, Height=600)
14: *
15: * METODOS DO LEGADO E ONDE FORAM PARAR
16: *   Init              -> Init + InicializarForm
17: *   montagrade2       -> MontaGrade2
18: *   Release           -> Destroy + DevolverFocoAoPai
19: *   Command1.Click    -> CmdAdicionarClick + SigPrSlpBO.AdicionarItensMarcados
20: *   GradeLista.AfterRowColChange -> GradeListasAfterRowColChange
21: *   Check1.When       -> gate replicado em TgItens1KeyPress (ver la o porque)
22: *   Sair.Click        -> CmdEncerrarClick
23: *   cmdSelTudo.Click  -> CmdSelTudoClick  / CmdApgTudo.Click -> CmdApgaTudoClick
24: *   Load (=fConfigGeral())  NAO PORTADO - deliberado, ver (a)

*-- Linhas 33 a 52:
33: *     o legado cita literalmente nao existem no pai migrado (FormLpr,
34: *     task461): o cursor de itens dele eh "cursor_4c_Itens" ("CrSigCdLpi" tem
35: *     ZERO ocorrencias no arquivo), a property eh "this_cCompVenda" e a
36: *     pagina de dados eh "pgf_4c_Paginas.Page2" com "grd_4c_Grade"/
37: *     "grd_4c_GradeC". Com os literais do legado fixos no codigo, o
38: *     AdicionarItensMarcados nao achava o destino e devolvia -1: o usuario
39: *     marcava os itens, clicava em "Adiciona os itens marcados" e so recebia
40: *     "Erro ao adicionar itens" - a UNICA funcao da tela falhava. Cada ponte
41: *     tenta PRIMEIRO o nome do legado (pai wrapper) e so depois o do migrado,
42: *     entao nenhum dos dois pais fica de fora.
43: *
44: * (a) fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg/SIGFUNCS.PRG)
45: *     que nao veio no acervo. O wrapper app/utils/fconfiggeral.prg existe
46: *     APENAS para o p-code dos VCX legado que a chamam no proprio Load, e o
47: *     cabecalho dele diz textualmente: "em codigo NOSSO nunca se chama
48: *     fConfigGeral". Na arquitetura nova a inicializacao global esta
49: *     distribuida e ja ocorreu antes deste dialogo abrir (config.prg, main.prg
50: *     e o proprio BO, que cria os cursores de que precisa). Mesmo tratamento e
51: *     mesma justificativa de FormSigMvExp.prg.
52: *

*-- Linhas 79 a 97:
79: 
80:     *-- Parametros recebidos do form pai
81:     this_oParentForm   = .NULL.   && Referencia ao form pai (pedido/venda)
82:     this_cLPrecoAtual  = ""       && Codigo da lista corrente (excluida de grd_4c_Listas)
83: 
84:     *-- Cursor de itens DO FORM PAI onde os itens marcados sao inseridos.
85:     *-- Default = nome do legado; o valor efetivo eh resolvido em runtime por
86:     *-- ResolverCursorDestino() (ver o cabecalho daquele metodo).
87:     this_cCursorDestino = "CrSigCdLpi"
88: 
89:     *--------------------------------------------------------------------------
90:     * Init - Recebe parametros do form pai, configura Caption e propriedades
91:     *
92:     * par_cCursorDestino eh OPCIONAL: permite ao pai dizer explicitamente em
93:     * qual cursor os itens marcados devem ser inseridos. Omitido, o nome eh
94:     * descoberto em runtime (ResolverCursorDestino) - necessario porque o
95:     * PILAR 3 renomeia os cursores e o nome do legado ("CrSigCdLpi") nao
96:     * existe no form pai migrado.
97:     *--------------------------------------------------------------------------

*-- Linhas 131 a 156:
131: 
132:             *-- Carrega listas disponiveis e vincula evento de selecao.
133:             *-- O BINDEVENT vem DEPOIS da carga de proposito: ligado antes, a
134:             *-- troca de RecordSource dispara AfterRowColChange e MontaGrade2
135:             *-- roda duas vezes na abertura.
136:             IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
137:                 loc_lCarregou = THIS.CarregarGradeLista()
138:             ELSE
139:                 loc_lCarregou = .T.
140:             ENDIF
141:             BINDEVENT(THIS.grd_4c_Listas, "AfterRowColChange", THIS, "GradeListasAfterRowColChange")
142: 
143:             *-- Legado: falhando a consulta de SigCdLpc ou o MontaGrade2, o Init
144:             *-- exibe "Favor reinicializar o processo." e chama ThisForm.Release.
145:             *-- Aqui o equivalente eh devolver .F.: o CREATEOBJECT do chamador
146:             *-- recebe .F. e o dialogo nao abre (Release dentro do Init nao eh
147:             *-- seguro - o objeto ainda esta sendo construido).
148:             IF loc_lCarregou
149:                 loc_lSucesso = .T.
150:             ELSE
151:                 THIS.ReportarFalhaProcesso()
152:             ENDIF
153:         CATCH TO loc_oErro
154:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
155:                     " PROC=" + loc_oErro.Procedure, "Erro")
156:         ENDTRY

*-- Linhas 244 a 297:
244:     * das colunas. Idempotente: seguro para ser chamado novamente.
245:     *--------------------------------------------------------------------------
246:     PROTECTED PROCEDURE ConfigurarPaginaDados()
247:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
248:             THIS.ConfigurarGradeLista()
249:         ENDIF
250: 
251:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
252:             THIS.ConfigurarGradeItens()
253:         ENDIF
254: 
255:         THIS.AplicarContratoGradeListas()
256:         THIS.AplicarContratoGradeItens()
257:     ENDPROC
258: 
259:     *--------------------------------------------------------------------------
260:     * GarantirCheckBoxItens - Cria (ou RECRIA) o CheckBox de marcacao da
261:     * Column1 de grd_4c_Itens e religa os handlers dele.
262:     *
263:     * A Column nasce apenas com Header1/Text1, entao o CheckBox tem de ser
264:     * adicionado (regra #18). E, MEDIDO no VFP9 em 2026-10-19: quando o BO
265:     * derruba e recria o alias (USE IN + SQLEXEC) com a grade ainda vinculada,
266:     * o VFP RECONSTROI os objetos Column e o Check1 DEIXA DE EXISTIR
267:     * (PEMSTATUS passa de .T. para .F.) - reatribuir propriedades nao traz o
268:     * controle de volta, so recria-lo. Sem isso, da segunda lista selecionada
269:     * em diante a coluna desenha o Text1 com o 0/1 cru e nao ha como marcar.
270:     *
271:     * Geometria: o SCX declara Width=60 para o Check1, mas a coluna tem 22px e
272:     * recorta o excedente; usar 22 evita o clipping sem alterar o que o usuario
273:     * ve (a caixa de marcacao fica identica).
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE GarantirCheckBoxItens()
276:         LOCAL loc_oColuna
277: 
278:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
279:             RETURN
280:         ENDIF
281: 
282:         loc_oColuna = THIS.grd_4c_Itens.Column1
283: 
284:         *-- So cria quando ausente: assim os BINDEVENT abaixo acontecem uma
285:         *-- unica vez por instancia de Check1 (sem binding duplicado)
286:         IF PEMSTATUS(loc_oColuna, "Check1", 5)
287:             RETURN
288:         ENDIF
289: 
290:         loc_oColuna.AddObject("Check1", "CheckBox")
291:         WITH loc_oColuna.Check1
292:             .Top       = 9
293:             .Left      = 2
294:             .Height    = 17
295:             .Width     = 22
296:             .FontName  = "Courier New"
297:             .Alignment = 0

*-- Linhas 310 a 360:
310:     ENDPROC
311: 
312:     *--------------------------------------------------------------------------
313:     * AplicarContratoGradeItens - (Re)aplica o contrato visual de grd_4c_Itens
314:     *
315:     * OBRIGATORIO em TODO caminho que (re)vincula o RecordSource. O BO RECRIA o
316:     * cursor de itens a cada troca de lista (USE IN + SQLEXEC dentro de
317:     * BuscarItensDaLista) e, com o cursor recriado, o VFP9 reseta Column.Width
318:     * para o default, perde Column.Sparse e devolve CurrentControl para "Text1".
319:     * Sem esta reaplicacao, da SEGUNDA lista selecionada em diante o CheckBox de
320:     * marcacao DESAPARECE (a coluna volta a desenhar o Text1 com o 0/1 cru) e o
321:     * usuario nao consegue marcar item nenhum - sem erro e sem log.
322:     * Referencia: CLAUDE.md regras #18 e #41 + Problema 48 (FormCor).
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE AplicarContratoGradeItens()
325:         LOCAL loc_oGrid
326: 
327:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
328:             RETURN
329:         ENDIF
330: 
331:         loc_oGrid = THIS.grd_4c_Itens
332: 
333:         *-- Grid.ReadOnly ANTES das colunas: ele propaga e sobrescreve o delas
334:         loc_oGrid.ReadOnly = .F.
335: 
336:         *-- Column1 - CheckBox de marcacao (Original: Width=22 ReadOnly=.F. Sparse=.F.)
337:         WITH loc_oGrid.Column1
338:             .Width            = 22
339:             .FontName         = "Courier New"
340:             .FontSize         = 9
341:             .Sparse           = .F.
342:             .ReadOnly         = .F.
343:             .Header1.Caption  = ""
344:             .Header1.FontName = "Tahoma"
345:             .Header1.FontSize = 8
346:         ENDWITH
347: 
348:         *-- O Check1 eh DESTRUIDO quando o alias eh recriado sob a grade:
349:         *-- recria-lo antes de apontar o CurrentControl para ele
350:         THIS.GarantirCheckBoxItens()
351: 
352:         *-- CurrentControl por ULTIMO e so com o Check1 existente: sem ele a
353:         *-- coluna segue desenhando o Text1 e o CheckBox nunca aparece (#18)
354:         IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
355:             loc_oGrid.Column1.AddObject("Check1", "CheckBox")
356:             loc_oGrid.Column1.Check1.Caption = ""
357:             loc_oGrid.Column1.CurrentControl = "Check1"
358:         ENDIF
359: 
360:         *-- Colunas 2..6 - somente leitura (Original: ReadOnly=.T. em todas)

*-- Linhas 372 a 536:
372: 
373:     *--------------------------------------------------------------------------
374:     * AplicarContratoColunaItens - Contrato de UMA coluna somente-leitura de
375:     * grd_4c_Itens. Larguras, captions e mascaras transcritos do SCX legado.
376:     * par_cInputMask vazio = o legado NAO declara mascara naquela coluna; nesse
377:     * caso nada eh atribuido (override vazio do Form Designer nao se transcreve
378:     * - CLAUDE.md regra #49).
379:     *--------------------------------------------------------------------------
380:     PROTECTED PROCEDURE AplicarContratoColunaItens(par_oColuna, par_nWidth, par_cCaption, par_cInputMask)
381:         WITH par_oColuna
382:             .Width             = par_nWidth
383:             .FontName          = "Courier New"
384:             .FontSize          = 9
385:             .ReadOnly          = .T.
386:             .Header1.Caption   = par_cCaption
387:             .Header1.FontName  = "Tahoma"
388:             .Header1.FontSize  = 8
389:             .Header1.Alignment = 2
390:             .Header1.ForeColor = RGB(0, 0, 0)
391:         ENDWITH
392: 
393:         IF !EMPTY(par_cInputMask)
394:             par_oColuna.InputMask = par_cInputMask
395:         ENDIF
396: 
397:         *-- Estilo do TextBox da coluna (Original: BorderStyle=0 Margin=0 ReadOnly=.T.)
398:         IF PEMSTATUS(par_oColuna, "Text1", 5)
399:             WITH par_oColuna.Text1
400:                 .BorderStyle = 0
401:                 .Margin      = 0
402:                 .ReadOnly    = .T.
403:                 .ForeColor   = RGB(0, 0, 0)
404:                 .BackColor   = RGB(255, 255, 255)
405:             ENDWITH
406:         ENDIF
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * AplicarContratoGradeListas - (Re)aplica o contrato visual de grd_4c_Listas
411:     * Mesmo motivo de AplicarContratoGradeItens: BuscarListasDisponiveis recria
412:     * o cursor (USE IN + SQLEXEC), o que zera Column1.Width (220 -> default) e
413:     * o Header1. Chamar depois de cada rebind do RecordSource.
414:     *--------------------------------------------------------------------------
415:     PROTECTED PROCEDURE AplicarContratoGradeListas()
416:         LOCAL loc_oGrid
417: 
418:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
419:             RETURN
420:         ENDIF
421: 
422:         loc_oGrid = THIS.grd_4c_Listas
423: 
424:         *-- Grid.ReadOnly ANTES da coluna: ele propaga e sobrescreve (regra #18)
425:         loc_oGrid.ReadOnly = .T.
426: 
427:         WITH loc_oGrid.Column1
428:             .Width             = 220
429:             .FontName          = "Courier New"
430:             .FontSize          = 9
431:             .ReadOnly          = .T.
432:             .Header1.Caption   = "Lista de Pre" + CHR(231) + "os"
433:             .Header1.FontName  = "Tahoma"
434:             .Header1.FontSize  = 8
435:             .Header1.Alignment = 2
436:             .Header1.ForeColor = RGB(0, 0, 0)
437:         ENDWITH
438: 
439:         *-- Estilo do TextBox da coluna (Original: BorderStyle=0 Margin=0 ReadOnly=.T.)
440:         IF PEMSTATUS(loc_oGrid.Column1, "Text1", 5)
441:             WITH loc_oGrid.Column1.Text1
442:                 .BorderStyle = 0
443:                 .Margin      = 0
444:                 .ReadOnly    = .T.
445:                 .ForeColor   = RGB(0, 0, 0)
446:                 .BackColor   = RGB(255, 255, 255)
447:             ENDWITH
448:         ENDIF
449:     ENDPROC
450: 
451:     *--------------------------------------------------------------------------
452:     * AlternarPagina - Move o foco entre os dois grids do dialogo.
453:     * par_nPagina = 1  -> grd_4c_Listas (cabecalho: escolha da lista de preco)
454:     * par_nPagina = 2  -> grd_4c_Itens  (detalhe: marcacao dos itens)
455:     * Neste dialogo nao ha PageFrame real; o metodo existe para compatibilidade
456:     * de API com forms CRUD e para permitir navegacao programatica entre grids.
457:     *--------------------------------------------------------------------------
458:     PROCEDURE AlternarPagina(par_nPagina)
459:         LOCAL loc_nPagina
460: 
461:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
462: 
463:         DO CASE
464:             CASE loc_nPagina = 1
465:                 IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
466:                     THIS.grd_4c_Listas.SetFocus()
467:                 ENDIF
468:             CASE loc_nPagina = 2
469:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
470:                     THIS.grd_4c_Itens.SetFocus()
471:                 ENDIF
472:         ENDCASE
473:     ENDPROC
474: 
475:     *--------------------------------------------------------------------------
476:     * ConfigurarGradeLista - Cria grd_4c_Listas para selecao de lista de preco
477:     * Original: GradeLista Top=96 Left=263 Width=258 Height=112 ColumnCount=1
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarGradeLista()
480:         THIS.AddObject("grd_4c_Listas", "Grid")
481:         WITH THIS.grd_4c_Listas
482:             .Top         = 96
483:             .Left        = 263
484:             .Width       = 258
485:             .Height      = 112
486:             .ColumnCount = 1
487:             .TabIndex    = 1       && SCX: GradeLista.TabIndex = 1
488:             .FontName    = "Courier New"
489:             .FontSize    = 9
490:             .DeleteMark  = .F.
491:             .RecordMark  = .F.
492:             .HighlightStyle     = 2
493:             .HighlightBackColor = RGB(255, 255, 255)
494:             .HighlightForeColor = RGB(15, 41, 104)
495:             .GridLineColor      = RGB(238, 238, 238)
496:             .ScrollBars  = 2
497:             .RowHeight   = 16
498:             .Visible     = .T.
499:         ENDWITH
500: 
501:         *-- Larguras, header e estilo da coluna ficam no contrato reaplicavel
502:         *-- (ReadOnly do grid eh aplicado la, ANTES do da coluna - regra #18)
503:         THIS.AplicarContratoGradeListas()
504:     ENDPROC
505: 
506:     *--------------------------------------------------------------------------
507:     * ConfigurarGradeItens - Cria grd_4c_Itens com checkbox na Column1 (6 cols)
508:     * Original: GradeItens Top=215 Left=72 Width=663 Height=184 ColumnCount=6
509:     *--------------------------------------------------------------------------
510:     PROTECTED PROCEDURE ConfigurarGradeItens()
511:         LOCAL loc_oGrid
512: 
513:         THIS.AddObject("grd_4c_Itens", "Grid")
514:         loc_oGrid = THIS.grd_4c_Itens
515: 
516:         WITH loc_oGrid
517:             .Top         = 215
518:             .Left        = 72
519:             .Width       = 663
520:             .Height      = 184
521:             .ColumnCount = 6
522:             .TabIndex    = 2       && SCX: GradeItens.TabIndex = 2
523:             .FontName    = "Courier New"
524:             .FontSize    = 9
525:             .DeleteMark  = .F.
526:             .RecordMark  = .F.
527:             .HighlightStyle     = 2
528:             .HighlightBackColor = RGB(255, 255, 255)
529:             .HighlightForeColor = RGB(15, 41, 104)
530:             .GridLineColor      = RGB(238, 238, 238)
531:             .ScrollBars  = 2
532:             .RowHeight   = 16
533:         ENDWITH
534: 
535:         *-- Column1 (CheckBox de marcacao), larguras, headers, mascaras,
536:         *-- Sparse e CurrentControl ficam no contrato reaplicavel, que eh

*-- Linhas 628 a 720:
628:     ENDPROC
629: 
630:     *--------------------------------------------------------------------------
631:     * CarregarGradeLista - Chama BO.BuscarListasDisponiveis e popula grd_4c_Listas
632:     * Apos carregar, chama MontaGrade2 com a primeira lista disponivel
633:     *--------------------------------------------------------------------------
634:     PROCEDURE CarregarGradeLista()
635:         LOCAL loc_lSucesso, loc_cCursorListas
636: 
637:         loc_lSucesso = THIS.this_oBusinessObject.BuscarListasDisponiveis(THIS.this_cLPrecoAtual)
638: 
639:         IF loc_lSucesso
640:             loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
641: 
642:             *-- Ordem canonica (regra #41): RecordSource ANTES do ControlSource
643:             THIS.grd_4c_Listas.RecordSource = ""
644:             THIS.grd_4c_Listas.RecordSource = loc_cCursorListas
645:             THIS.grd_4c_Listas.Column1.ControlSource = loc_cCursorListas + ".lprecos"
646:             *-- Cursor RECRIADO pelo BO: reaplicar largura/header da coluna
647:             THIS.AplicarContratoGradeListas()
648: 
649:             *-- Carregar itens da primeira lista disponivel. O legado testa o
650:             *-- retorno do MontaGrade2 no Init (If !(ThisForm.MontaGrade2(...)))
651:             *-- - descartar o retorno aqui esconde a falha e o dialogo abre com
652:             *-- a grade de itens vazia.
653:             SELECT (loc_cCursorListas)
654:             GO TOP
655:             IF !EOF()
656:                 loc_lSucesso = THIS.MontaGrade2(ALLTRIM(lprecos))
657:             ENDIF
658:         ENDIF
659: 
660:         *-- FUNIL (regra #40): repor o estado dos controles em TODO caminho que
661:         *-- recarrega os cursores - inclusive no caminho de falha, senao uma
662:         *-- grade fica habilitada apontando para cursor que nao existe mais.
663:         THIS.AjustarBotoesPorModo()
664: 
665:         RETURN loc_lSucesso
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------
669:     * MontaGrade2 - Carrega itens de SigCdLpi para grd_4c_Itens
670:     * par_cLPrecos: codigo da lista selecionada em grd_4c_Listas
671:     *--------------------------------------------------------------------------
672:     PROCEDURE MontaGrade2(par_cLPrecos)
673:         LOCAL loc_lSucesso, loc_cCursorItens
674: 
675:         loc_lSucesso = THIS.this_oBusinessObject.BuscarItensDaLista(par_cLPrecos)
676: 
677:         IF loc_lSucesso
678:             loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens
679: 
680:             *-- Ordem canonica (regra #41): RecordSource ANTES dos
681:             *-- ControlSource - atribuir RecordSource depois RESETA os
682:             *-- ControlSource ja definidos e a grade exibe colunas erradas
683:             THIS.grd_4c_Itens.RecordSource = ""
684:             THIS.grd_4c_Itens.RecordSource = loc_cCursorItens
685:             THIS.grd_4c_Itens.Column1.ControlSource = loc_cCursorItens + ".lMarcas"
686:             THIS.grd_4c_Itens.Column2.ControlSource = loc_cCursorItens + ".cpros"
687:             THIS.grd_4c_Itens.Column3.ControlSource = loc_cCursorItens + ".dpros"
688:             THIS.grd_4c_Itens.Column4.ControlSource = loc_cCursorItens + ".pvens"
689:             THIS.grd_4c_Itens.Column5.ControlSource = loc_cCursorItens + ".moevs"
690:             THIS.grd_4c_Itens.Column6.ControlSource = loc_cCursorItens + ".comiss"
691:             *-- O cursor foi RECRIADO (USE IN + SQLEXEC no BO): o rebind zera
692:             *-- Column.Width, perde Sparse e devolve CurrentControl para "Text1".
693:             *-- Sem reaplicar o contrato, o CheckBox de marcacao desaparece.
694:             THIS.AplicarContratoGradeItens()
695:             THIS.grd_4c_Itens.Refresh()
696:         ENDIF
697: 
698:         *-- FUNIL (regra #40): o cursor de itens foi recriado, repor o estado
699:         THIS.AjustarBotoesPorModo()
700: 
701:         RETURN loc_lSucesso
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * GradeListasAfterRowColChange - Atualiza grd_4c_Itens ao trocar linha em grd_4c_Listas
706:     *--------------------------------------------------------------------------
707:     PROCEDURE GradeListasAfterRowColChange(par_nColIndex)
708:         LOCAL loc_cCursorListas, loc_cLPrecos
709: 
710:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
711: 
712:         IF USED(loc_cCursorListas)
713:             SELECT (loc_cCursorListas)
714:             IF !EOF()
715:                 loc_cLPrecos = ALLTRIM(lprecos)
716:                 IF !EMPTY(loc_cLPrecos)
717:                     *-- Legado: If !(ThisForm.MontaGrade2(lcLPrec)) -> MessageBox
718:                     *-- "Favor reinicializar o processo." + ThisForm.Release()
719:                     IF !THIS.MontaGrade2(loc_cLPrecos)
720:                         THIS.ReportarFalhaProcesso()

*-- Linhas 909 a 939:
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * CmdSelTudoClick - Marca todos os itens de grd_4c_Itens
913:     *--------------------------------------------------------------------------
914:     PROCEDURE CmdSelTudoClick()
915:         THIS.this_oBusinessObject.MarcarTodos()
916:         THIS.grd_4c_Itens.Refresh()
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * CmdApgaTudoClick - Desmarca todos os itens de grd_4c_Itens
921:     *--------------------------------------------------------------------------
922:     PROCEDURE CmdApgaTudoClick()
923:         THIS.this_oBusinessObject.DesmarcarTodos()
924:         THIS.grd_4c_Itens.Refresh()
925:     ENDPROC
926: 
927:     *--------------------------------------------------------------------------
928:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
929:     *--------------------------------------------------------------------------
930:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
931:         LOCAL loc_i, loc_oControl, loc_p
932: 
933:         FOR loc_i = 1 TO par_oContainer.ControlCount
934:             loc_oControl = par_oContainer.Controls(loc_i)
935: 
936:             IF VARTYPE(loc_oControl) = "O"
937:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
938:                     loc_oControl.Visible = .T.
939:                 ENDIF

*-- Linhas 1019 a 1037:
1019:     * Por isso DOIS caminhos: o do pai LEGADO (Pagina.Dados.Grade, nomes do
1020:     * frmcadastro Fortyus) e o do pai MIGRADO (pgf_4c_Paginas.Page2 + a
1021:     * primeira Grid da pagina). Sem o segundo, contra o pai real - o FormLpr,
1022:     * que usa "pgf_4c_Paginas.Page2" e "grd_4c_Grade"/"grd_4c_GradeC" - todos
1023:     * os PEMSTATUS falham e o foco NUNCA volta para a grade de itens: o
1024:     * usuario fecha o dialogo e cai no pedido sem foco em campo nenhum.
1025:     * Pai sem nenhuma das duas estruturas: nada a fazer, o Refresh ja ocorreu.
1026:     *--------------------------------------------------------------------------
1027:     PROTECTED PROCEDURE DevolverFocoAoPai()
1028:         LOCAL loc_oPai, loc_oDados
1029: 
1030:         loc_oPai = THIS.this_oParentForm
1031: 
1032:         *-- PEMSTATUS sobre .NULL. estoura: guarda antes de tudo
1033:         IF VARTYPE(loc_oPai) != "O" OR ISNULL(loc_oPai)
1034:             RETURN
1035:         ENDIF
1036: 
1037:         *-- Caminho 1: pai LEGADO (Pagina.Dados.Grade)

*-- Linhas 1081 a 1100:
1081:     *
1082:     * Varre por INDICE (Controls(N) eh array - regra #34, nunca por nome) e
1083:     * filtra por BaseClass = "GRID": o pai migrado pode ter mais de uma grade
1084:     * na pagina de Dados (FormLpr tem grd_4c_Grade para venda e
1085:     * grd_4c_GradeC para compra, com a nao usada invisivel), entao o teste de
1086:     * Visible eh o que escolhe a grade certa sem precisar saber o nome dela.
1087:     *--------------------------------------------------------------------------
1088:     PROTECTED PROCEDURE FocarPrimeiraGrade(par_oContainer)
1089:         LOCAL loc_nI, loc_oCtrl
1090: 
1091:         IF VARTYPE(par_oContainer) != "O" OR ISNULL(par_oContainer)
1092:             RETURN .F.
1093:         ENDIF
1094: 
1095:         IF !PEMSTATUS(par_oContainer, "ControlCount", 5)
1096:             RETURN .F.
1097:         ENDIF
1098: 
1099:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1100:             loc_oCtrl = par_oContainer.Controls(loc_nI)

*-- Linhas 1113 a 1136:
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * Activate - Define foco inicial no grd_4c_Listas ao exibir o dialogo
1117:     * Equivale ao ThisForm.GradeLista.Column1.SetFocus do Init legado
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE Activate()
1120:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
1121:             THIS.grd_4c_Listas.SetFocus()
1122:         ENDIF
1123:         DODEFAULT()
1124:     ENDPROC
1125: 
1126:     *--------------------------------------------------------------------------
1127:     * GradeItensCheck1When - Replica o When original: Return(CsSigCdLpi.lMarcas = 0)
1128:     * Itens ja marcados NAO podem ser desmarcados individualmente; para
1129:     * desmarcar usar cmd_4c_ApgaTudo (Apaga Tudo).
1130:     *
1131:     * ATENCAO: este metodo NAO bloqueia nada por si - BINDEVENT descarta o
1132:     * retorno do delegate. Ele fica aqui como a transcricao do When legado;
1133:     * o gate que REALMENTE vale esta dentro de TgItens1KeyPress, que eh quem
1134:     * altera lMarcas. Mexer na regra exige mexer NOS DOIS.
1135:     *--------------------------------------------------------------------------
1136:     PROCEDURE GradeItensCheck1When()

*-- Linhas 1160 a 1228:
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * BtnAlterarClick - Move o foco para grd_4c_Itens permitindo ao usuario
1164:     * alterar (marcar/desmarcar) os itens da lista de preco selecionada. Como
1165:     * este eh um dialogo de selecao, "alterar" corresponde a editar quais
1166:     * itens estao marcados para inclusao.
1167:     *--------------------------------------------------------------------------
1168:     PROCEDURE BtnAlterarClick()
1169:         LOCAL loc_cCursor
1170: 
1171:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
1172:             RETURN
1173:         ENDIF
1174: 
1175:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1176: 
1177:         IF USED(loc_cCursor)
1178:             SELECT (loc_cCursor)
1179:             GO TOP
1180:             THIS.grd_4c_Itens.Refresh()
1181:             THIS.grd_4c_Itens.SetFocus()
1182:         ELSE
1183:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
1184:         ENDIF
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
1189:     * usuario visualizar as listas de preco disponiveis para importacao.
1190:     * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
1191:     * listas de preco de origem (o SCX original faz isso via GradeLista).
1192:     *--------------------------------------------------------------------------
1193:     PROCEDURE BtnVisualizarClick()
1194:         LOCAL loc_cCursor
1195: 
1196:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
1197:             RETURN
1198:         ENDIF
1199: 
1200:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
1201: 
1202:         IF USED(loc_cCursor)
1203:             SELECT (loc_cCursor)
1204:             GO TOP
1205:             THIS.grd_4c_Listas.Refresh()
1206:             THIS.grd_4c_Listas.SetFocus()
1207:         ELSE
1208:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
1209:         ENDIF
1210:     ENDPROC
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
1214:     * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
1215:     * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
1216:     * confirmacao previa se houver itens marcados.
1217:     *--------------------------------------------------------------------------
1218:     PROCEDURE BtnExcluirClick()
1219:         LOCAL loc_cCursor, loc_nMarcados
1220: 
1221:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1222: 
1223:         IF !USED(loc_cCursor)
1224:             RETURN
1225:         ENDIF
1226: 
1227:         SELECT (loc_cCursor)
1228:         COUNT FOR lMarcas = 1 TO loc_nMarcados

*-- Linhas 1269 a 1303:
1269:     ENDPROC
1270: 
1271:     *--------------------------------------------------------------------------
1272:     * BtnBuscarClick - Refoca grd_4c_Listas para navegar entre listas disponiveis
1273:     * Se o cursor de listas nao existe, recarrega via CarregarGradeLista()
1274:     *--------------------------------------------------------------------------
1275:     PROCEDURE BtnBuscarClick()
1276:         LOCAL loc_cCursor
1277: 
1278:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
1279:             RETURN
1280:         ENDIF
1281: 
1282:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
1283: 
1284:         IF USED(loc_cCursor)
1285:             SELECT (loc_cCursor)
1286:             GO TOP
1287:             THIS.grd_4c_Listas.Refresh()
1288:             THIS.grd_4c_Listas.SetFocus()
1289:         ELSE
1290:             IF !THIS.CarregarGradeLista()
1291:                 MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
1292:             ENDIF
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *--------------------------------------------------------------------------
1297:     * FormParaBO - Copia dados do form para o Business Object
1298:     * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
1299:     *--------------------------------------------------------------------------
1300:     PROCEDURE FormParaBO()
1301:         LOCAL loc_cCursor
1302: 
1303:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas

*-- Linhas 1320 a 1380:
1320:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
1321:         loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens
1322: 
1323:         IF USED(loc_cCursorListas) AND PEMSTATUS(THIS, "grd_4c_Listas", 5)
1324:             THIS.grd_4c_Listas.Refresh()
1325:         ENDIF
1326: 
1327:         IF USED(loc_cCursorItens) AND PEMSTATUS(THIS, "grd_4c_Itens", 5)
1328:             THIS.grd_4c_Itens.Refresh()
1329:         ENDIF
1330:     ENDPROC
1331: 
1332:     *--------------------------------------------------------------------------
1333:     * HabilitarCampos - Habilita ou desabilita controles editaveis do dialogo
1334:     * par_lHabilitar: .T. habilita, .F. desabilita
1335:     * OBS: cmd_4c_SelTudo e cmd_4c_ApgaTudo sao icone-only (Caption="") -
1336:     *      NUNCA setar .Enabled neles (botao fica caixa vazia sem icone)
1337:     *--------------------------------------------------------------------------
1338:     PROCEDURE HabilitarCampos(par_lHabilitar)
1339:         LOCAL loc_lHabilitar
1340: 
1341:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1342: 
1343:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
1344:             THIS.grd_4c_Listas.Enabled = loc_lHabilitar
1345:         ENDIF
1346: 
1347:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1348:             THIS.grd_4c_Itens.Enabled = loc_lHabilitar
1349:         ENDIF
1350: 
1351:         IF PEMSTATUS(THIS, "cmd_4c_Adicionar", 5)
1352:             THIS.cmd_4c_Adicionar.Enabled = loc_lHabilitar
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * LimparCampos - Desvincula grids e fecha cursores do BO
1358:     *--------------------------------------------------------------------------
1359:     PROCEDURE LimparCampos()
1360:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1361:             THIS.grd_4c_Itens.RecordSource = ""
1362:         ENDIF
1363: 
1364:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
1365:             THIS.grd_4c_Listas.RecordSource = ""
1366:         ENDIF
1367: 
1368:         IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1369:             THIS.this_oBusinessObject.LimparCursores()
1370:         ENDIF
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     * AjustarBotoesPorModo - Repoe o estado dos controles do dialogo.
1375:     *
1376:     * FIDELIDADE (PILAR 1): o Command1 do SCX legado ("Adiciona os itens
1377:     * marcados a Lista atual") NAO tem PROCEDURE When nem override de Enabled
1378:     * - ele esta SEMPRE clicavel, e o proprio Click filtra com
1379:     * "If CsSigCdLpi.lMarcas = 1" dentro do Scan, de modo que clicar sem nada
1380:     * marcado simplesmente nao insere linha nenhuma. O unico When do form

*-- Linhas 1394 a 1436:
1394:             THIS.cmd_4c_Adicionar.Enabled = .T.
1395:         ENDIF
1396: 
1397:         IF PEMSTATUS(THIS, "grd_4c_Listas", 5)
1398:             THIS.grd_4c_Listas.Enabled = USED(THIS.this_oBusinessObject.this_cCursorListas)
1399:         ENDIF
1400: 
1401:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1402:             THIS.grd_4c_Itens.Enabled = USED(THIS.this_oBusinessObject.this_cCursorItens)
1403:         ENDIF
1404:     ENDPROC
1405: 
1406: 
1407:     *==========================================================================
1408:     * Toggle do CheckBox de grid - grd_4c_Itens.Column1 (THIS.this_oBusinessObject.this_cCursorItens -> .lMarcas)
1409:     * Pattern #185 / Erro146 (2026-09-04): CheckBox em coluna de Grid nao alterna
1410:     * pelo binding nativo. Click/MouseDown suprimem o padrao; MouseUp delega ao
1411:     * KeyPress, que alterna por codigo com REPLACE no cursor + Refresh do grid.
1412:     *==========================================================================
1413:     PROTECTED PROCEDURE BindToggleItens1(par_oChk)
1414:         BINDEVENT(par_oChk, "KeyPress",  THIS, "TgItens1KeyPress")
1415:         BINDEVENT(par_oChk, "MouseUp",   THIS, "TgItens1MouseUp")
1416:         BINDEVENT(par_oChk, "MouseDown", THIS, "TgItens1MouseDown")
1417:         BINDEVENT(par_oChk, "Click",     THIS, "TgItens1Click")
1418:     ENDPROC
1419: 
1420:     *--------------------------------------------------------------------------
1421:     * TgItens1KeyPress - Alterna a marcacao da linha corrente de grd_4c_Itens.
1422:     *
1423:     * O gate do legado mora AQUI, nao no When. O SCX declara
1424:     *     Check1.When -> Return(CsSigCdLpi.lMarcas = 0)
1425:     * isto eh: item JA marcado nao entra mais na celula, logo NAO pode ser
1426:     * desmarcado um a um (para limpar, o usuario usa o botao Apaga Tudo).
1427:     * Esse gate NAO eh aplicado por GradeItensCheck1When: BINDEVENT DESCARTA
1428:     * o retorno do delegate, entao um When ligado por BINDEVENT nao bloqueia
1429:     * edicao nenhuma (regra conhecida do projeto, Pattern #185/Erro146). Sem
1430:     * replicar a condicao dentro do proprio toggle, a marcacao vira 1 <-> 0
1431:     * nos dois sentidos e o dialogo passa a permitir o que o legado proibe -
1432:     * divergencia silenciosa, sem erro e sem log.
1433:     *--------------------------------------------------------------------------
1434:     PROCEDURE TgItens1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1435:         IF !INLIST(par_nKeyCode, 13, 32)
1436:             RETURN

*-- Linhas 1452 a 1470:
1452:                 REPLACE lMarcas WITH 1
1453:             ENDIF
1454:         ENDIF
1455:         THIS.grd_4c_Itens.Refresh()
1456:     ENDPROC
1457: 
1458:     PROCEDURE TgItens1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1459:         THIS.TgItens1KeyPress(13, 0)
1460:         NODEFAULT
1461:     ENDPROC
1462: 
1463:     PROCEDURE TgItens1MouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1464:         NODEFAULT
1465:     ENDPROC
1466: 
1467:     PROCEDURE TgItens1Click()
1468:         NODEFAULT
1469:     ENDPROC
1470: ENDDEFINE

