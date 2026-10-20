# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ThisForm.grdItens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.grdItens.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopagr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (926 linhas total):

*-- Linhas 30 a 43:
30: *   Fase 3:   Formsigopagr.prg - estrutura base (Init, InicializarForm, Destroy)
31: *   Fase 4:   Estrutura visual (todos filhos DIRETOS do form, sem Page1/Page2 -
32: *             este dialogo NAO tem PageFrame): shp_4c_ShpFigura (moldura),
33: *             grd_4c_Dados (7 colunas - Column3 com CheckBox chk_4c_Check1,
34: *             regra #18), obj_4c_CntBotoes (CommandGroup Confirmar/Cancelar),
35: *             img_4c_ImgJpg (imagem do produto) e os botoes standalone
36: *             cmd_4c_SelTudo/cmd_4c_Apaga. Column.ControlSource fica VAZIO
37: *             (CLAUDE.md regra #41 - cursor_4c_Itens ainda nao existe neste
38: *             ponto); o bind com o cursor e os handlers (toggle do checkbox,
39: *             AfterRowColChange, Confirmar/Cancelar/SelTudo/Apaga) ficam
40: *             para fase posterior.
41: *   Fase 5:   NO-OP proposital. O objetivo generico da fase ("Form - Campos
42: *             Principais - ConfigurarPaginaDados com metade dos campos") nao
43: *             se aplica a este form: o dump SIGOPAGR.SCX (layout.json) nao

*-- Linhas 64 a 72:
64: *             campo digitavel - NAO segue o padrao
65: *             BINDEVENT+AbrirLookupXxx(FormBuscaAuxiliar) desta fase; o
66: *             handler que a consome pertence a Fase 7 ("Form - Eventos"),
67: *             junto com o toggle do CheckBox da Column3 e os Click de
68: *             Confirmar/Cancelar/SelTudo/apaga. Criar um
69: *             BINDEVENT/AbrirLookupXxx fake so para preencher a fase
70: *             violaria a mesma regra da Fase 5 (nao inventar UI/fluxo que o
71: *             legado nao tem).
72: *   Fase 7:   Eventos principais. O objetivo generico desta fase

*-- Linhas 89 a 97:
89: *                 em img_4c_ImgJpg (padrao de decodificacao idem
90: *                 Formsigmvsbn.CarregarImagemProduto).
91: *               - ChkMarcasClick/MouseDown/MouseUp/KeyPress: toggle do
92: *                 CheckBox da Column3 (Marcas), replicando o NODEFAULT dos
93: *                 4 handlers do dump (Click/MouseDown suprimem o toggle
94: *                 nativo, MouseUp delega a KeyPress(13,0), KeyPress faz o
95: *                 REPLACE e repinta imagem+grid).
96: *               - BtnCancelarClick/BtnConfirmarClick: Buttons(1)/(2) do
97: *                 CommandGroup (btnSair/btnConfirmar do dump). Cancelar so

*-- Linhas 271 a 280:
271:     PROTECTED PROCEDURE ConfigurarShapeFigura()
272:         THIS.AddObject("shp_4c_ShpFigura", "Shape")
273:         WITH THIS.shp_4c_ShpFigura
274:             .Top         = 141
275:             .Left        = 795
276:             .Height      = 348
277:             .Width       = 253
278:             .BackStyle   = 0
279:             .BorderColor = RGB(136, 189, 188)
280:             .Visible     = .T.

*-- Linhas 296 a 305:
296:         THIS.AddObject("grd_4c_Dados", "Grid")
297:         loc_oGrid = THIS.grd_4c_Dados
298:         WITH loc_oGrid
299:             .Top           = 6
300:             .Left          = 1
301:             .Width         = 742
302:             .Height        = 483
303:             .ColumnCount   = 7
304:             .FontName      = "Verdana"
305:             .FontSize      = 8

*-- Linhas 322 a 330:
322:             .Resizable         = .F.
323:             .Visible           = .T.
324:             .Header1.Alignment = 2
325:             .Header1.Caption   = "Produto"
326:             .Header1.ForeColor = RGB(36, 84, 155)
327:             .Text1.Alignment   = 3
328:             .Text1.BorderStyle = 0
329:             .Text1.Margin      = 0
330:             .Text1.ReadOnly    = .F.

*-- Linhas 344 a 384:
344:             .ReadOnly          = .T.
345:             .Visible           = .T.
346:             .Header1.Alignment = 2
347:             .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
348:             .Header1.ForeColor = RGB(36, 84, 155)
349:             .Text1.BorderStyle = 0
350:             .Text1.Margin      = 0
351:             .Text1.ReadOnly    = .T.
352:             .Text1.ForeColor   = RGB(0, 0, 0)
353:             .Text1.BackColor   = RGB(255, 255, 255)
354:         ENDWITH
355: 
356:         *-- Column3: Marcas (checkbox) - ColumnOrder 1 (1a visualmente).
357:         *-- AddObject + CurrentControl + Sparse = .F. (CLAUDE.md regra #18) -
358:         *-- sem isso o controle nunca aparece, a coluna so desenha o Text1.
359:         *-- chk_4c_Check1.Caption = "Check1" transcrito LITERALMENTE do dump
360:         *-- (PILAR 1) - a Column.Width = 17 recorta a caixa, o texto nao
361:         *-- aparece na pratica (irrelevante visualmente, igual ao legado).
362:         WITH loc_oGrid.Column3
363:             .FontName        = "Verdana"
364:             .FontSize        = 8
365:             .ColumnOrder     = 1
366:             .ControlSource   = ""
367:             .Width           = 17
368:             .Sparse          = .F.
369:             .Visible         = .T.
370:             .Header1.Caption = ""
371:             .AddObject("chk_4c_Check1", "CheckBox")
372:             .chk_4c_Check1.Top       = 22
373:             .chk_4c_Check1.Left      = 22
374:             .chk_4c_Check1.Height    = 17
375:             .chk_4c_Check1.Width     = 60
376:             .chk_4c_Check1.FontName  = "Verdana"
377:             .chk_4c_Check1.FontSize  = 8
378:             .chk_4c_Check1.Alignment = 0
379:             .chk_4c_Check1.Caption   = "Check1"
380:             .chk_4c_Check1.Visible   = .T.
381:             .CurrentControl = "chk_4c_Check1"
382:         ENDWITH
383: 
384:         *-- Column4: Quantidade (crItensBor.Qtds) - ColumnOrder 5, sempre

*-- Linhas 394 a 402:
394:             .ReadOnly          = .T.
395:             .Visible           = .T.
396:             .Header1.Alignment = 2
397:             .Header1.Caption   = "Quantidade"
398:             .Header1.ForeColor = RGB(36, 84, 155)
399:             .Text1.BorderStyle = 0
400:             .Text1.Margin      = 0
401:             .Text1.ReadOnly    = .T.
402:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 417 a 425:
417:             .InputMask         = "99999,999.99"
418:             .Visible           = .T.
419:             .Header1.Alignment = 2
420:             .Header1.Caption   = "Valor"
421:             .Header1.ForeColor = RGB(36, 84, 155)
422:             .Text1.BorderStyle = 0
423:             .Text1.Margin      = 0
424:             .Text1.ReadOnly    = .F.
425:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 441 a 449:
441:             .InputMask         = "99999,999.99"
442:             .Visible           = .T.
443:             .Header1.Alignment = 2
444:             .Header1.Caption   = "Peso"
445:             .Header1.ForeColor = RGB(36, 84, 155)
446:             .Text1.BorderStyle = 0
447:             .Text1.Margin      = 0
448:             .Text1.ForeColor   = RGB(0, 0, 0)
449:             .Text1.BackColor   = RGB(255, 255, 255)

*-- Linhas 462 a 470:
462:             .ReadOnly          = .T.
463:             .Visible           = .T.
464:             .Header1.Alignment = 2
465:             .Header1.Caption   = "Tam."
466:             .Header1.ForeColor = RGB(36, 84, 155)
467:             .Text1.BorderStyle = 0
468:             .Text1.Margin      = 0
469:             .Text1.ReadOnly    = .T.
470:             .Text1.ForeColor   = RGB(0, 0, 0)

*-- Linhas 486 a 495:
486:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
487:         THIS.AddObject("obj_4c_CntBotoes", "CommandGroup")
488:         WITH THIS.obj_4c_CntBotoes
489:             .Top           = 10
490:             .Left          = 874
491:             .Width         = 171
492:             .Height        = 110
493:             .ButtonCount   = 2
494:             .AutoSize      = .T.
495:             .BackStyle     = 0

*-- Linhas 501 a 536:
501:             .Visible       = .T.
502: 
503:             WITH .Buttons(1)
504:                 .Top          = 5
505:                 .Left         = 86
506:                 .Height       = 100
507:                 .Width        = 80
508:                 .FontName     = "Verdana"
509:                 .FontSize     = 8
510:                 .WordWrap     = .T.
511:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
512:                 .Cancel       = .T.
513:                 .Caption      = "\<Cancelar"
514:                 .MousePointer = 15
515:                 .ToolTipText  = "[Esc] Encerrar"
516:                 .SpecialEffect = 0
517:                 .ForeColor    = RGB(36, 84, 155)
518:                 .BackColor    = RGB(255, 255, 255)
519:                 .Themes       = .F.
520:             ENDWITH
521: 
522:             WITH .Buttons(2)
523:                 .Top          = 5
524:                 .Left         = 5
525:                 .Height       = 100
526:                 .Width        = 80
527:                 .FontName     = "Verdana"
528:                 .FontSize     = 8
529:                 .WordWrap     = .T.
530:                 .Picture      = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
531:                 .Caption      = "\<Confirmar"
532:                 .MousePointer = 15
533:                 .ToolTipText  = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
534:                 .ForeColor    = RGB(36, 84, 155)
535:                 .BackColor    = RGB(255, 255, 255)
536:                 .Themes       = .F.

*-- Linhas 548 a 557:
548:     PROTECTED PROCEDURE ConfigurarImagemProduto()
549:         THIS.AddObject("img_4c_ImgJpg", "Image")
550:         WITH THIS.img_4c_ImgJpg
551:             .Top     = 144
552:             .Left    = 798
553:             .Height  = 341
554:             .Width   = 247
555:             .Stretch = 2
556:             .Picture = ""
557:             .Visible = .F.

*-- Linhas 572 a 610:
572:         loc_lHabilitado = INLIST(THIS.this_cEscolha, "INSERIR", "ALTERAR")
573: 
574:         *-- SelTudo (legado SIGOPAGR.SelTudo): marca todos os itens da grade
575:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
576:         WITH THIS.cmd_4c_SelTudo
577:             .Top         = 202
578:             .Left        = 745
579:             .Height      = 40
580:             .Width       = 45
581:             .FontName    = "Verdana"
582:             .FontSize    = 8
583:             .Caption     = ""
584:             .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
585:             .ToolTipText = "Selecionar"
586:             .ForeColor   = RGB(36, 84, 155)
587:             .BackColor   = RGB(255, 255, 255)
588:             .Themes           = .T.
589:             .TabStop     = .F.
590:             .Enabled     = loc_lHabilitado
591:             .Visible     = .T.
592:         ENDWITH
593: 
594:         *-- apaga (legado SIGOPAGR.apaga): desmarca todos os itens da grade
595:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
596:         WITH THIS.cmd_4c_Apaga
597:             .Top         = 243
598:             .Left        = 745
599:             .Height      = 40
600:             .Width       = 45
601:             .FontBold    = .F.
602:             .FontItalic  = .F.
603:             .FontName    = "Verdana"
604:             .FontSize    = 8
605:             .Caption     = ""
606:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
607:             .ToolTipText = "Desmarcar"
608:             .ForeColor   = RGB(36, 84, 155)
609:             .BackColor   = RGB(255, 255, 255)
610:             .Themes           = .T.

*-- Linhas 633 a 642:
633:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(1), "Click", THIS, "BtnCancelarClick")
634:         BINDEVENT(THIS.obj_4c_CntBotoes.Buttons(2), "Click", THIS, "BtnConfirmarClick")
635: 
636:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
637:         BINDEVENT(THIS.cmd_4c_Apaga,   "Click", THIS, "CmdApagaClick")
638:     ENDPROC
639: 
640:     *--------------------------------------------------------------------------
641:     * MontarGrade - Agrupa o cursor de movimento (sigopagrBO.
642:     * MontarItensAgrupados) e liga o grid ao cursor resultante (cursor_4c_Itens).

*-- Linhas 649 a 657:
649:     * RecordSource/ControlSource RESETAM Width e Header1.Caption das colunas
650:     * (CLAUDE.md regra #41/Problema 48) - por isso os dois sao reaplicados
651:     * DEPOIS do bind, na mesma ordem canonica (ControlSource -> Width ->
652:     * Header1.Caption). Column3 e CheckBox (regra #18): CurrentControl/
653:     * Sparse reafirmados por seguranca.
654:     *--------------------------------------------------------------------------
655:     PROTECTED PROCEDURE MontarGrade()
656:         LOCAL loc_oGrid, loc_cCursorItens, loc_lSucesso, loc_oErro
657:         loc_lSucesso = .F.

*-- Linhas 680 a 694:
680:                 loc_oGrid.Column6.Width = 95
681:                 loc_oGrid.Column7.Width = 44
682: 
683:                 loc_oGrid.Column1.Header1.Caption = "Produto"
684:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
685:                 loc_oGrid.Column3.Header1.Caption = ""
686:                 loc_oGrid.Column4.Header1.Caption = "Quantidade"
687:                 loc_oGrid.Column5.Header1.Caption = "Valor"
688:                 loc_oGrid.Column6.Header1.Caption = "Peso"
689:                 loc_oGrid.Column7.Header1.Caption = "Tam."
690: 
691:                 loc_oGrid.Column3.Sparse         = .F.
692:                 loc_oGrid.Column3.CurrentControl = "chk_4c_Check1"
693: 
694:                 loc_oGrid.Refresh()

*-- Linhas 771 a 779:
771: 
772:     *--------------------------------------------------------------------------
773:     * ChkMarcasClick / ChkMarcasMouseDown / ChkMarcasMouseUp / ChkMarcasKeyPress
774:     * Toggle do CheckBox da Column3 (Marcas) - replica os 4 handlers do dump
775:     * (SIGOPAGR.grdItens.Column3.Check1): Click e MouseDown suprimem o toggle
776:     * nativo (NODEFAULT), MouseUp delega a KeyPress(13,0) e KeyPress (Enter/
777:     * Espaco) faz o REPLACE + repinta imagem e grid. PUBLIC - alvo de
778:     * BINDEVENT (CLAUDE.md regra #3).
779:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigopagrBO.prg):
*------------------------------------------------------------------------------
* sigopagrBO - Business Object para Formsigopagr
* Dialogo operacional de selecao/agrupamento de itens de borracharia por
* produto + tamanho, usado para marcar itens e ajustar peso/valor antes de
* propagar os valores de volta ao cursor de movimento (crTpmMvItn).
* Migrado de: SIGOPAGR (Framework Fortyus)
*
* Este dialogo nao possui tabela propria persistida: ele recebe do form
* chamador um cursor de movimento JA ABERTO (crTpmMvItn no legado,
* this_cCursorMovimento aqui - DataSession compartilhada, igual ao legado
* DataSession=1), agrupa esse cursor por Produto+Tamanho para exibir na
* grade, deixa o usuario marcar linhas e propaga Pesos/Valor de volta para
* o PROPRIO cursor de movimento (manipulacao de cursor local, nao escrita
* em SQL Server). A UNICA tabela SQL Server realmente consultada e
* SigCdPro, e so para LEITURA (imagem do produto exibida ao navegar na
* grade) - por isso nao ha INSERT/UPDATE real para sobrescrever: ver
* comentario em Inserir()/Atualizar().
*------------------------------------------------------------------------------
DEFINE CLASS sigopagrBO AS BusinessBase

    *-- Propriedades do item agrupado (csProdItn / crItensBor no legado)
    this_nCitens  = 0
    this_cCpros   = ""
    this_cDpros   = ""
    this_cCodTams = ""
    this_nMarcas  = 0
    this_nQtds    = 0
    this_nValor   = 0
    this_nPesos   = 0
    this_cFigJpgs = ""

    *-- Nomes dos cursores que este BO consome/popula (propriedade para o
    *-- Form referenciar sem repetir literais - padrao SigMvSbnBO/SIGMVCMVBO)
    this_cCursorMovimento = ""                  && equivalente a crTpmMvItn - recebido do form chamador
    this_cCursorItens     = "cursor_4c_Itens"   && grade de itens agrupados, equivalente a crItensBor
    this_cCursorProduto   = "cursor_4c_Produto" && dados/imagem do produto exibido, equivalente a crTPro

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "Cpros"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas do registro corrente do
    * cursor de itens agrupados (this_cCursorItens, equivalente a crItensBor
    * do legado) para as propriedades this_* do item selecionado na grade.
    *   par_cAliasCursor - alias a ler; se omitido usa this_cCursorItens
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias, loc_lSucesso
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            par_cAliasCursor, THIS.this_cCursorItens)

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
        ELSE
            SELECT (loc_cAlias)

            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias
            ELSE
                THIS.this_cCpros   = TratarNulo(Cpros, "")
                THIS.this_cDpros   = TratarNulo(Dpros, "")
                THIS.this_cCodTams = TratarNulo(CodTams, "")
                THIS.this_nMarcas  = TratarNulo(Marcas, 0)
                THIS.this_nQtds    = TratarNulo(Qtds, 0)
                THIS.this_nValor   = TratarNulo(Valor, 0)
                THIS.this_nPesos   = TratarNulo(Pesos, 0)

                *-- csProdItn.cItens eh cursor vestigial do legado (criado no
                *-- Init, nunca populado nem lido em metodo nenhum do dump) -
                *-- crItensBor nao tem essa coluna. Mapear defensivamente so
                *-- quando presente, para a property nao ficar sem sentido
                *-- caso algum dia venha de um cursor de origem diferente.
                IF TYPE("Citens") = "N"
                    THIS.this_nCitens = Citens
                ELSE
                    THIS.this_nCitens = 0
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave logica do item agrupado corrente: Produto +
    * Tamanho (Cpros+CodTams), equivalente ao par usado pelo legado no
    * "Where Cpros = ... And CodTams = ..." do btnConfirmar.Click.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCpros) + "|" + ALLTRIM(THIS.this_cCodTams)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarItensAgrupados - Agrupa o cursor de movimento (this_cCursorMovimento,
    * equivalente a crTpmMvItn) por Produto+Tamanho+Descricao, somando a
    * quantidade e pegando o maior valor/peso de cada grupo - replica
    * LITERALMENTE o SELECT do Init() legado:
    *   Select 0 as Marcas, Cpros, Dpros, CodTams, Sum(Qtds) as Qtds,
    *          Max(Units) as Valor, Max(Pesos) as Pesos From crTpmMvItn
    *   Where Not Empty(Cpros) Group By Cpros, CodTams, Dpros
    *          Into Cursor crItensBor ReadWrite
    * O cursor de movimento ja chega ABERTO (recebido do form chamador,
    * DataSession compartilhada - o legado usa DataSession=1); esta
    * operacao e 100% local, sem SQLEXEC.
    *--------------------------------------------------------------------------
    PROCEDURE MontarItensAgrupados(par_cCursorMovimento)
        LOCAL loc_cCursorMov, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        loc_cCursorMov = IIF(VARTYPE(par_cCursorMovimento) = "C" AND !EMPTY(par_cCursorMovimento), ;
            par_cCursorMovimento, THIS.this_cCursorMovimento)

        IF EMPTY(loc_cCursorMov) OR !USED(loc_cCursorMov)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        THIS.this_cCursorMovimento = loc_cCursorMov

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            SELECT 0 AS Marcas, Cpros, Dpros, CodTams, ;
                   SUM(Qtds) AS Qtds, MAX(Units) AS Valor, MAX(Pesos) AS Pesos ;
                FROM (loc_cCursorMov) ;
                WHERE !EMPTY(Cpros) ;
                GROUP BY Cpros, CodTams, Dpros ;
                INTO CURSOR (THIS.this_cCursorItens) READWRITE

            SELECT (THIS.this_cCursorItens)
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosItens - Marca/desmarca TODAS as linhas da grade de itens
    * agrupados. Equivalente ao SelTudo.Click (par_nMarcas = 1) e ao
    * apaga.Click (par_nMarcas = 0) do legado:
    *   Replace All crItensBor.Marcas with 1   (ou 0)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosItens(par_nMarcas)
        IF !USED(THIS.this_cCursorItens)
            THIS.this_cMensagemErro = "Cursor " + THIS.this_cCursorItens + " n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorItens)
        REPLACE ALL Marcas WITH IIF(par_nMarcas = 1, 1, 0)
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarItemMovimento - Propaga Pesos/Valor do item CORRENTE (carregado
    * via CarregarDoCursor) para TODAS as linhas do cursor de movimento com o
    * mesmo Produto+Tamanho - replica LITERALMENTE o trecho do
    * btnConfirmar.Click legado (dentro do "Scan for Marcas = 1"):
    *   Update crTpmMvItn set Pesos = crItensBor.Pesos, Units = crItensBor.Valor
    *          where Cpros = crItensBor.Cpros And CodTams = crItensBor.CodTams
    * Este metodo NAO filtra por Marcas - quem decide QUAIS itens propagar e
    * o chamador (o Form varre o cursor de itens e chama isto so para as
    * linhas marcadas, replicando o "Scan for Marcas = 1" do legado).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarItemMovimento()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorMovimento)
            REPLACE ALL Pesos WITH THIS.this_nPesos, ;
                    Units WITH THIS.this_nValor ;
                FOR Cpros = THIS.this_cCpros AND CodTams = THIS.this_cCodTams

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularTotaisMovimento - Recalcula Totas = Units * Qtds em TODAS as
    * linhas do cursor de movimento - replica LITERALMENTE o trecho final do
    * btnConfirmar.Click legado, executado UMA UNICA VEZ apos propagar todos
    * os itens marcados (fora do loop de AtualizarItemMovimento):
    *   Update crTpmMvItn set Totas = (crTpmMvItn.Units * crTpmMvItn.Qtds)
    *--------------------------------------------------------------------------
    PROCEDURE RecalcularTotaisMovimento()
        IF EMPTY(THIS.this_cCursorMovimento) OR !USED(THIS.this_cCursorMovimento)
            THIS.this_cMensagemErro = "Cursor de movimento n" + CHR(227) + "o informado ou n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto"
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorMovimento)
        REPLACE ALL Totas WITH Units * Qtds
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarImagemProdutoPorCodigo - Consulta Cpros/FigJpgs/Dpros em SigCdPro
    * para o produto corrente, replicando a consulta feita em
    * grdItens.AfterRowColChange do legado:
    *   = ThisForm.poDataMgr.CursorQuery('SigCdPro','crTPro','Cpros',
    *                                      crItensBor.Cpros,'FigJpgs')
    * So LEITURA - a decodificacao do base64 (STRCONV) e a gravacao do .jpg
    * temporario (STRTOFILE) ficam no Form, que e quem exibe a Image (padrao
    * do projeto - ver Formsigmvsbn.CarregarImagemProduto).
    *--------------------------------------------------------------------------
    FUNCTION BuscarImagemProdutoPorCodigo(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        THIS.this_cMensagemErro = ""

        IF EMPTY(par_cCpros)
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT Cpros, FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCpros))

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (crTPro)"
            ELSE
                SELECT (THIS.this_cCursorProduto)
                GO TOP

                THIS.this_cFigJpgs = TratarNulo(FigJpgs, "")

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar (SQL Server) - SIGOPAGR nunca grava em SigCdPro,
    * a unica tabela SQL Server que toca (e so para LER a imagem do produto -
    * ver BuscarImagemProdutoPorCodigo acima). O codigo fonte legado inteiro
    * (sigopagr_form_codigo_fonte.txt) foi conferido e nao contem nenhum
    * Insert/Update/Delete/TableUpdate/Gather contra o SQL Server - a unica
    * gravacao que o dialogo faz e a propagacao de Pesos/Valor para o cursor
    * de movimento recebido do form chamador (manipulacao de CURSOR local,
    * ver AtualizarItemMovimento/RecalcularTotaisMovimento acima), e isso
    * nao e uma escrita no banco. Por isso nao ha INSERT/UPDATE real para
    * sobrescrever aqui, e RegistrarAuditoria() nunca e chamado por este BO -
    * o comportamento padrao herdado de BusinessBase (recusar a operacao)
    * ja e o correto para este par de metodos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

    PROTECTED PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Sigopagr " + CHR(233) + " um di" + CHR(225) + "logo de sele" + ;
            CHR(231) + CHR(227) + "o - n" + CHR(227) + "o grava registros."
        RETURN .F.
    ENDPROC

ENDDEFINE

