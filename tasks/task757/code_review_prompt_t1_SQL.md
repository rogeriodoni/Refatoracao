# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CURSOR_4C_LOCA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 1, MARCAS, CODS, CPROS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PLACEHOLDER' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 1, MARCAS, CODS, CPROS, CITENS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DIGITADO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 1, MARCAS, CODS, CPROS, CITENS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  Column2.ControlSource = ""
Select crItensLoc
	.column1.ControlSource = [crItensLoc.Cpros]
	.column2.ControlSource = [crItensLoc.Dpros]
	.column3.ControlSource = [crItensLoc.Marcas]
	.column4.ControlSource = [crItensLoc.cItens]
	.column5.ControlSource = [crItensLoc.Locals]
lnOldSel = Select()
Select &pcCursor.
Select cidchaves, Cods, Descs, 0 as Marcas, Space(4) as Codigo From &pcCursor. Where 1=0 Into Cursor CrAux ReadWrite
Select &pcCursor.	
		Select CrAux
			Select &pcCurDest.
			Select CrAux	
Select &pcNivAnt.
Select(lnOldSel)
lnOldSel = Select()
Select crSigLcNv2
	Select * From crSigLcNv2 Where Cods = lcNivel Into Cursor LocalNivel Readwrite
Select crSigLcNv3
	Select * From crSigLcNv3 Where Cods = lcNivel Into Cursor LocalNivel Readwrite
Select crSigLcNv4
	Select * From crSigLcNv4 Where Cods = lcNivel Into Cursor LocalNivel Readwrite
Select(lnOldSel)
Select crTpmMvItn
Select 0 as Marcas, Cpros, Dpros, cItens, Iif(ThisForm.pcOrigem='ORIGEM',LocalOs,Locals) as Locals, Space(10) as Categoria ;
	from crTpmMvItn Where Not Empty(Cpros) Into Cursor crItensLoc ReadWrite 
Select crItensLoc
	lcQuery = [Select Categoria From SigCdPro where Cpros = ']+crItensLoc.Cpros+[' ]
	ThisForm.podatamgr.SqlExecute(lcQuery,[csProd])	
	Select crItensLoc
lcQuery = [Select * From SigLcNv1]
ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel1])
lcQuery = [Select * From SigLcNv2]
ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel2])
lcQuery = [Select * From SigLcNv3]
ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel3])
lcQuery = [Select * From SigLcNv4]
ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel4])
Select csNivel1
Select *, Space(4) as Codigo From csNivel1 Where 1=0 Into Cursor crSigLcNv1 ReadWrite
Select csNivel2
Select *, Space(4) as Codigo From csNivel2 Where 1=0 Into Cursor crSigLcNv2 ReadWrite
Select csNivel3
Select *, Space(4) as Codigo From csNivel3 Where 1=0 Into Cursor crSigLcNv3 ReadWrite
Select csNivel4
Select *, Space(4) as Codigo From csNivel4 Where 1=0 Into Cursor crSigLcNv4 ReadWrite
Select crItensLoc
	Select crTPro
	Select * From CrSigLcNv4 Where Cods = lcNivel Into Cursor LocalNivel Readwrite
	Select LocalNivel
	If !Seek(This.Value)
	Select * From CrSigLcNv3 Where Cods = lcNivel ;
	Select LocalNivel
	If !Seek(This.Value)
	Select * From CrSigLcNv2 Where Cods = lcNivel ;
	Select LocalNivel
	If !Seek(This.Value)
Select csLocals
		Update crTpmMvItn set Localos = csLocals.Locals where cItens = csLocals.cItens
		Update crTpmMvItn set Locals = csLocals.Locals where cItens = csLocals.cItens
Select crTpmMvItn
Select crItensLoc
Select crItensLoc
lnOldSel = Select()
Select crItensLoc
	Select csLocals
	Select crItensLoc
Select crItensLoc
Delete From crItensLoc Where Marcas <> 0 
Select crItensLoc
Select(lnOldSel)
lnOldSel = Select()
Select crItensLoc
Select(lnOldSel)
Select crItensLoc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLcl.prg) - TRECHOS RELEVANTES PARA PASS SQL (2158 linhas total):

*-- Linhas 340 a 359:
340:     * Localizacao) - diferente da ordem de CRIACAO (Column1..5), que segue
341:     * a ordem do SCX.
342:     *
343:     * NAO vincula RecordSource/ControlSource aqui: cursor_4c_Itens so existe
344:     * depois de SigOpLclBO.CarregarItens() rodar, e Column.ControlSource de
345:     * cursor ainda ausente derruba o Init. O bind fica em CarregarLista(),
346:     * chamado depois na mesma ordem de InicializarForm.
347:     *==========================================================================
348:     PROTECTED PROCEDURE ConfigurarGrid()
349:         LOCAL loc_oGrid
350: 
351:         THIS.AddObject("grd_4c_Dados", "Grid")
352:         loc_oGrid = THIS.grd_4c_Dados
353: 
354:         *-- DESFAZER o auto-bind ANTES de mexer em ColumnCount. Grid nasce com
355:         *-- RecordSourceType = 1 (Alias) e o VFP9 o liga sozinho ao alias da
356:         *-- WORK AREA CORRENTE - aqui a dos cursores que o BO acabou de montar
357:         *-- (medido: RecordSource=[Cursor_4c_LcNv4], ColumnCount=2). Com a
358:         *-- coluna ja vinculada a um campo CHAR, o AddObject do CheckBox em
359:         *-- Column3 estoura "Error with CHK_4C_MARCAS - Value : Data type

*-- Linhas 368 a 386:
368:             .Height        = 387
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8
371:             .DeleteMark    = .F.
372:             .RecordMark    = .F.
373:             .RowHeight     = 16
374:             .ScrollBars    = 2
375:             .TabIndex      = 1
376:             .GridLineColor = RGB(238, 238, 238)
377:             .ColumnCount   = 5
378:             .ReadOnly      = .F.
379:             .Visible       = .T.
380:         ENDWITH
381: 
382:         *-- Column1 - Produto (Cpros). ColumnOrder=3 (3a posicao visual)
383:         WITH loc_oGrid.Column1
384:             .FontName          = "Tahoma"
385:             .FontSize          = 8
386:             .ColumnOrder       = 3

*-- Linhas 448 a 466:
448:             .Caption   = ""
449:             *-- .Value NUMERICO e OBRIGATORIO: CheckBox nasce com .Value
450:             *-- LOGICO (.F.) e a coluna ligada eh cursor_4c_Itens.Marcas
451:             *-- N(1,0). Sem esta linha o bind de Column3.ControlSource
452:             *-- estoura "Error with CHK_4C_MARCAS - Value : Data type
453:             *-- mismatch", InicializarForm devolve .F. e CREATEOBJECT
454:             *-- devolve .F. logico - a tela nao abre.
455:             .Value     = 0
456:             .Visible   = .T.
457:         ENDWITH
458:         loc_oGrid.Column3.CurrentControl = "chk_4c_Marcas"
459:         loc_oGrid.Column3.Sparse         = .F.
460:         loc_oGrid.Column3.ReadOnly       = .F.
461: 
462:         *-- Column4 - numero do item (cItens). ColumnOrder=2
463:         WITH loc_oGrid.Column4
464:             .FontName          = "Tahoma"
465:             .FontSize          = 8
466:             .ColumnOrder       = 2

*-- Linhas 508 a 573:
508:     *
509:     * Eh a transcricao do "PROCEDURE montagrade" do SCX legado, que faz
510:     * exatamente isto e nada mais:
511:     *     Select crItensLoc / Index on cItens Tag cItens / Go top
512:     *     With ThisForm.grdItens
513:     *         .RecordSource = [crItensLoc]
514:     *         .column1..column5.ControlSource = [crItensLoc.<coluna>]
515:     *         .Refresh()
516:     *     EndWith
517:     *     ThisForm.grdItens.Column1.SetFocus / .Refresh
518:     *
519:     * O nome canonico do projeto para esse funil eh CarregarLista (o legado
520:     * chama de montagrade), e ele eh PUBLIC de proposito (regra #3): o
521:     * harness de teste o aciona de FORA da classe, e tambem o btnLimpar do
522:     * legado o chama como ponto de recarga.
523:     *
524:     * Chamada DEPOIS de SigOpLclBO.CarregarItens() rodar. Se o cursor nao
525:     * existe (crTpmMvItn fechado - sem form chamador, caso do harness de
526:     * teste), cria um placeholder com a MESMA estrutura da SELECT do BO
527:     * (regra "cursor placeholder = cursor real"), para a grade sempre ter
528:     * um alias valido para ligar.
529:     *
530:     * RecordSource reseta Width/Header1.Caption/CurrentControl/Sparse das
531:     * colunas (Problema 48 do projeto / regra #18) - por isso sao
532:     * reaplicados abaixo, na ordem canonica: ColumnCount -> RecordSource ->
533:     * ControlSource -> Width -> Header.Caption.
534:     *==========================================================================
535:     PROCEDURE CarregarLista()
536:         LOCAL loc_oGrid
537: 
538:         IF !USED("cursor_4c_Itens")
539:             CREATE CURSOR cursor_4c_Itens (Marcas N(1, 0), Cpros C(14), ;
540:                 Dpros C(65), cItens N(10, 0), Locals C(10), Categoria C(6))
541:         ENDIF
542: 
543:         loc_oGrid = THIS.grd_4c_Dados
544: 
545:         *-- Column3 volta para o Text1 ANTES do bind: atribuir RecordSource
546:         *-- auto-vincula cada coluna ao campo de MESMA POSICAO do cursor, e a
547:         *-- 3a eh Dpros (char). Com o CheckBox ainda sendo o CurrentControl,
548:         *-- esse vinculo intermediario estoura Data type mismatch. O
549:         *-- CurrentControl eh reposto no fim, depois do ControlSource certo.
550:         loc_oGrid.Column3.CurrentControl = "Text1"
551: 
552:         loc_oGrid.RecordSource = ""
553:         loc_oGrid.RecordSource = "cursor_4c_Itens"
554:         loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.Cpros"
555:         loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.Dpros"
556:         loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.Marcas"
557:         loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.cItens"
558:         loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.Locals"
559: 
560:         loc_oGrid.Column1.Width           = 122
561:         loc_oGrid.Column1.Header1.Caption = "Produto"
562: 
563:         loc_oGrid.Column2.Width           = 290
564:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
565: 
566:         loc_oGrid.Column3.Width           = 17
567:         loc_oGrid.Column3.Header1.Caption = ""
568:         loc_oGrid.Column3.CurrentControl  = "chk_4c_Marcas"
569:         loc_oGrid.Column3.Sparse          = .F.
570: 
571:         loc_oGrid.Column4.Width           = 25
572:         loc_oGrid.Column4.Header1.Caption = "#"
573: 

*-- Linhas 579 a 597:
579:         *-- em OrdenarItens). O tag so existe quando o cursor veio de
580:         *-- CarregarItens - no placeholder do harness nao ha tag nenhum, e
581:         *-- SET ORDER TO TAG num cursor sem tag estoura.
582:         SELECT cursor_4c_Itens
583:         IF TAGNO("cItens", "", "cursor_4c_Itens") > 0
584:             SET ORDER TO TAG cItens
585:         ENDIF
586:         GO TOP
587:         loc_oGrid.Refresh()
588: 
589:         RETURN .T.
590:     ENDPROC
591: 
592:     *==========================================================================
593:     * ConfigurarBotoes - Confirmar/Cancelar (cntBotoes) + Selecionar/
594:     * Desmarcar tudo (SelTudo/apaga) do SCX legado
595:     *
596:     * Este dialogo NAO tem botoes CRUD (Incluir/Alterar/Excluir/Buscar) - o
597:     * legado so tem estes quatro botoes de acao, porque a tela eh um popup

*-- Linhas 1215 a 1233:
1215:         ENDIF
1216: 
1217:         IF USED("cursor_4c_Itens")
1218:             SELECT cursor_4c_Itens
1219:             GO TOP
1220:         ENDIF
1221:         THIS.grd_4c_Dados.Refresh()
1222:     ENDPROC
1223: 
1224:     *==========================================================================
1225:     * AtualizarDependenciaNiveis - gate dos campos de nivel (When do legado)
1226:     *
1227:     * O legado escreve a regra no When de cada caixa:
1228:     *   getBase.When : Return (InList(pcEscolha,[INSERIR],[ALTERAR]))
1229:     *   getNvl2.When : o mesmo teste de modo E, antes de liberar,
1230:     *                  If Empty(getBase.Value) -> Return .F.
1231:     *   getNvl3.When : o mesmo, mas contra getNvl2.Value
1232:     *   getNvl4.When : o mesmo, mas contra getNvl3.Value
1233:     *

*-- Linhas 1271 a 1298:
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * BtnConfirmarClick - btnConfirmar.Click do legado
1275:     *
1276:     * Propaga cursor_4c_Locais para crTpmMvItn (SigOpLclBO.Atualizar) e
1277:     * encerra o dialogo. O legado NAO tem guarda de QUANTIDADE - sempre libera
1278:     * a tela depois do Scan/Update, mesmo que nenhuma linha tenha sido afetada
1279:     * (csLocals vazio = fechar sem mudanca), e isso eh reproduzido aqui:
1280:     * Atualizar() devolve .T. com this_nItensConfirmados = 0.
1281:     *
1282:     * Mas o Atualizar() migrado tem guardas que o legado nao tem (crTpmMvItn
1283:     * ou cursor_4c_Locais fechados) e nesses caminhos ele devolve .F. deixando
1284:     * this_cMensagemErro preenchida SEM exibir - ExibirFalha da BusinessBase eh
1285:     * PROTECTED e so roda por dentro do Salvar()/Excluir() (regra #51), que
1286:     * este fluxo nao usa. Ignorar o retorno fechava a tela em SILENCIO sem
1287:     * aplicar localizacao nenhuma (regra #20: falha de gravacao nunca eh muda).
1288:     * Entao: exibe a mensagem e NAO libera o form, para o usuario nao perder as
1289:     * localizacoes que ja montou.
1290:     *==========================================================================
1291:     PROCEDURE BtnConfirmarClick()
1292:         LOCAL loc_lConfirmou
1293: 
1294:         loc_lConfirmou = .T.
1295: 
1296:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1297:             loc_lConfirmou = THIS.this_oBusinessObject.Atualizar()
1298: 

*-- Linhas 1337 a 1377:
1337:         ENDIF
1338: 
1339:         IF USED("cursor_4c_Itens")
1340:             SELECT cursor_4c_Itens
1341:             GO TOP
1342:         ENDIF
1343:         THIS.GradeAfterRowColChange()
1344:         THIS.grd_4c_Dados.Refresh()
1345:     ENDPROC
1346: 
1347:     *==========================================================================
1348:     * BtnApagaClick - apaga.Click do legado
1349:     *   Replace All Marcas With 0 / Go Top / Refresh.
1350:     *   When do legado: so age em INSERIR/ALTERAR (this_lPodeEditar).
1351:     *==========================================================================
1352:     PROCEDURE BtnApagaClick()
1353:         IF !THIS.this_lPodeEditar
1354:             RETURN
1355:         ENDIF
1356: 
1357:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1358:             THIS.this_oBusinessObject.MarcarTodosItens(0)
1359:         ENDIF
1360: 
1361:         IF USED("cursor_4c_Itens")
1362:             SELECT cursor_4c_Itens
1363:             GO TOP
1364:         ENDIF
1365:         THIS.GradeAfterRowColChange()
1366:         THIS.grd_4c_Dados.Refresh()
1367:     ENDPROC
1368: 
1369:     *==========================================================================
1370:     * ConfigurarLookupsNiveis - liga os quatro lookups de nivel (LostFocus,
1371:     * regra #47) e as cascatas de limpeza (InteractiveChange)
1372:     *
1373:     * O legado valida no Valid de cada caixa (ao SAIR dela). BINDEVENT em
1374:     * "Valid" de TextBox nao eh confiavel (regra #47), entao o equivalente
1375:     * mora em "LostFocus" - sem parametros, e com guarda de reentrancia
1376:     * this_lEmLookup (o picker eh MODAL e tira o foco, redisparando o
1377:     * proprio LostFocus).

*-- Linhas 1437 a 1455:
1437:     * BaseLostFocus - getBase.Valid do legado (busca na tabela REMOTA SigLcNv1)
1438:     *
1439:     * Legado (fwbuscaext): tenta match EXATO por Cods sozinho; so achando NAO
1440:     * acha eh que mostra o browse. Aqui: SQLEXEC exato primeiro (silencioso);
1441:     * sem match, THIS.AbrirLookupCanonico (regra #36/37 - Pattern B do
1442:     * FormBuscaAuxiliar com CREATEOBJECT de 2+ argumentos eh PROIBIDO).
1443:     *
1444:     * Guarda de reentrancia (regra #37/#47): o picker eh MODAL e tira o foco
1445:     * do campo, o que redispara este proprio LostFocus. O corpo vive em
1446:     * BaseLostFocusExec para a flag ser SEMPRE liberada, inclusive com
1447:     * RETURN antecipado dentro do Exec.
1448:     *==========================================================================
1449:     PROCEDURE BaseLostFocus()
1450:         IF THIS.this_lEmLookup
1451:             RETURN
1452:         ENDIF
1453:         THIS.this_lEmLookup = .T.
1454:         THIS.BaseLostFocusExec()
1455:         THIS.this_lEmLookup = .F.

*-- Linhas 1471 a 1490:
1471:                     USE IN cursor_4c_BaseExata
1472:                 ENDIF
1473: 
1474:                 loc_cSQL = "SELECT Cods, Descs FROM SigLcNv1 WHERE Cods = " + EscaparSQL(loc_cValor)
1475:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BaseExata")
1476: 
1477:                 IF loc_nResultado > 0 AND USED("cursor_4c_BaseExata")
1478:                     IF RECCOUNT("cursor_4c_BaseExata") = 1
1479:                         THIS.txt_4c_Base.Value  = ALLTRIM(cursor_4c_BaseExata.Cods)
1480:                         THIS.txt_4c_DBase.Value = ALLTRIM(NVL(cursor_4c_BaseExata.Descs, ""))
1481:                         loc_lAchou = .T.
1482:                     ENDIF
1483:                 ENDIF
1484: 
1485:                 IF USED("cursor_4c_BaseExata")
1486:                     USE IN cursor_4c_BaseExata
1487:                 ENDIF
1488:             ENDIF
1489:         ENDIF
1490: 

*-- Linhas 1505 a 1523:
1505:     * legado (busca no cursor LOCAL da hierarquia, ja filtrado pelo pai)
1506:     *
1507:     * Os tres delegam a ValidarNivelExec, que reproduz o padrao comum:
1508:     *   Select * From crSigLcNvN Where Cods = <pai> Into Cursor LocalNivel
1509:     *   Seek <valor digitado> - achando, NAO reatribui nada (fidelidade ao
1510:     *   legado: o Valid so toca Value/Desc no ramo "nao achou"); nao achando,
1511:     *   abre o picker sobre o cursor LOCAL (Pattern A - DefinirCursor/Mostrar)
1512:     *   e preenche codigo + descricao com o selecionado.
1513:     *==========================================================================
1514:     PROCEDURE Nvl2LostFocus()
1515:         IF THIS.this_lEmLookup
1516:             RETURN
1517:         ENDIF
1518:         THIS.this_lEmLookup = .T.
1519:         THIS.ValidarNivelExec(2)
1520:         THIS.this_lEmLookup = .F.
1521:     ENDPROC
1522: 
1523:     PROCEDURE Nvl3LostFocus()

*-- Linhas 1562 a 1583:
1562:         loc_cCursorNivel = THIS.ObterCursorNivel(par_nNivel)
1563:         loc_cValorPai    = ALLTRIM(loc_oTxtPai.Value)
1564: 
1565:         THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, loc_cValorPai)
1566: 
1567:         IF USED("cursor_4c_LocalNivel")
1568:             IF !SEEK(loc_cValor, "cursor_4c_LocalNivel", "Codigo")
1569:                 *-- Nao achou -> browse de selecao, SEMPRE pelo funil unico
1570:                 *-- (regra #37). Achando, o legado NAO reatribui nada: o
1571:                 *-- getNvlN.Valid so toca Value/Desc no ramo "nao achou".
1572:                 THIS.AbrirBuscaNivel(par_nNivel)
1573:             ENDIF
1574:         ENDIF
1575: 
1576:         loc_oTxt.Refresh()
1577:         loc_oTxtDesc.Refresh()
1578: 
1579:         THIS.AtualizarDependenciaNiveis()
1580:     ENDPROC
1581: 
1582:     *==========================================================================
1583:     * AbrirBuscaBase - FUNIL UNICO do picker da Base (SigLcNv1, tabela REMOTA)

*-- Linhas 1638 a 1661:
1638:     *
1639:     * O picker usa o Pattern A (CREATEOBJECT sem argumento + DefinirCursor +
1640:     * Mostrar) porque a lista eh um cursor LOCAL ja filtrado pelo pai - o
1641:     * Pattern B (CREATEOBJECT com parametros) dispararia um SELECT remoto
1642:     * proprio e abriria o dialogo vazio.
1643:     *
1644:     * Refaz o filtro do pai antes de abrir (CarregarNivelFiltrado) para o
1645:     * metodo ser auto-contido e correto tambem quando acionado de fora de
1646:     * ValidarNivelExec; o custo eh um SELECT em cursor local.
1647:     *==========================================================================
1648:     PROCEDURE AbrirBuscaNivel(par_nNivel)
1649:         LOCAL loc_oTxt, loc_oTxtDesc, loc_oTxtPai, loc_cCursorNivel, loc_cTitulo
1650:         LOCAL loc_oBusca, loc_lEmLookupAnt, loc_lProsseguir, loc_oErro
1651: 
1652:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1653:         THIS.this_lEmLookup = .T.
1654:         loc_lProsseguir     = .T.
1655: 
1656:         TRY
1657:             loc_oTxt     = THIS.ObterControleNivel(par_nNivel, "COD")
1658:             loc_oTxtDesc = THIS.ObterControleNivel(par_nNivel, "DESC")
1659:             loc_oTxtPai  = THIS.ObterControleNivel(par_nNivel, "PAI")
1660: 
1661:             IF VARTYPE(loc_oTxt) != "O" OR VARTYPE(loc_oTxtDesc) != "O" OR VARTYPE(loc_oTxtPai) != "O"

*-- Linhas 1673 a 1696:
1673:                 loc_cTitulo      = THIS.ObterTituloNivel(par_nNivel)
1674: 
1675:                 THIS.this_oBusinessObject.CarregarNivelFiltrado(loc_cCursorNivel, ;
1676:                     ALLTRIM(loc_oTxtPai.Value))
1677: 
1678:                 IF USED("cursor_4c_LocalNivel")
1679:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1680:                     IF VARTYPE(loc_oBusca) = "O"
1681:                         loc_oBusca.DefinirCursor("cursor_4c_LocalNivel", "Codigo", "Descs", ;
1682:                             "Sele" + CHR(231) + CHR(227) + "o - " + loc_cTitulo)
1683:                         IF loc_oBusca.Mostrar()
1684:                             loc_oTxt.Value     = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1685:                             loc_oTxtDesc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1686:                         ENDIF
1687:                         loc_oBusca.Release()
1688:                     ENDIF
1689:                 ENDIF
1690:             ENDIF
1691: 
1692:         CATCH TO loc_oErro
1693:             MsgErro("Erro ao abrir a sele" + CHR(231) + CHR(227) + "o do n" + CHR(237) + "vel:" + CHR(13) + ;
1694:                     loc_oErro.Message + CHR(13) + ;
1695:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1696:                     "Procedure: " + loc_oErro.Procedure, "Erro")

*-- Linhas 1923 a 1941:
1923:             THIS.AtualizarDependenciaNiveis()
1924: 
1925:             IF USED("cursor_4c_Itens")
1926:                 SELECT cursor_4c_Itens
1927:                 GO TOP
1928:             ENDIF
1929:             THIS.grd_4c_Dados.Column1.SetFocus()
1930:             THIS.grd_4c_Dados.Refresh()
1931:             THIS.GradeAfterRowColChange()
1932:         ELSE
1933:             *-- Inserir() recusa em silencio (modo, cursores fechados, nenhum
1934:             *-- item marcado): deixa this_cMensagemErro preenchida e NAO exibe,
1935:             *-- porque ExibirFalha da BusinessBase eh PROTECTED e so roda por
1936:             *-- dentro do Salvar() (regra #51). Sem este ELSE o usuario clicava
1937:             *-- Localizar e NADA acontecia (regra #20).
1938:             IF !THIS.this_oBusinessObject.this_lErroExibido
1939:                 IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
1940:                     MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
1941:                              "Aten" + CHR(231) + CHR(227) + "o")

*-- Linhas 1964 a 1982:
1964:         THIS.CarregarLista()
1965: 
1966:         IF USED("cursor_4c_Itens")
1967:             SELECT cursor_4c_Itens
1968:             GO TOP
1969:         ENDIF
1970: 
1971:         *-- Os oito campos do legado, pela mesma fonte unica do Localizar
1972:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1973:             THIS.this_oBusinessObject.LimparNiveis()
1974:         ENDIF
1975:         THIS.BOParaForm()
1976: 
1977:         THIS.AtualizarDependenciaNiveis()
1978:     ENDPROC
1979: 
1980:     *==========================================================================
1981:     * FormParaBO - os oito campos da localizacao -> propriedades do BO
1982:     *

