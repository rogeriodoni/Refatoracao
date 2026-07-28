# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-SQL] Campo 'categoria' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'descs' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'tipo' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contas' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'valors' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'moedas' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCARGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CARGOS, CARGO, VALORS, GRUPOS, CONTAS, MOEDAS, CATEGORIA, CCARGS

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
  ControlSource = "crSigCdCrg.ccargs"
  ControlSource = "crSigCdCrg.dcargs"
  ControlSource = "crSigCdCrg.vllibcots"
  ControlSource = "crSigCdCrg.vllibpgs"
  ControlSource = "crSigCdCrg.limacres"
  ControlSource = "crSigCdCrg.acrepors"
  ControlSource = "crSigCdCrg.limdescs"
  ControlSource = "crSigCdCrg.descpors"
  ControlSource = "crSigCdCrg.nivels"
  ControlSource = "crSigCdCrg.comis"
  ControlSource = "crSigCdCrg.varmovdup"
  ControlSource = "crSigCdCrg.varcots"
  ControlSource = "crSigCdCrg.altcots"
  ControlSource = "crSigCdCrg.limites"
  ControlSource = "crSigCdCrg.AComis"
  ControlSource = "crSigCdCrg.ConsSubn"
  ControlSource = "crSigCdCrg.FComis"
  ControlSource = "crSigCdCrg.CancItens"
  ControlSource = "crSigCdCrg.LibFpags"
  ControlSource = "crSigCdCrg.libValMMax"
  ControlSource = "crSigCdCrg.custoprod"
  ControlSource = "crSigCdCrg.libPrzes"
  ControlSource = "crSigCdCrg.libDupTits"
  ControlSource = "crSigCdCrg.libleilaos"
  DeleteMark = .F.
  ControlSource = "crSigCdCrg.LibSdIns"
  ControlSource = "crSigCdCrg.vllibopes"
  ControlSource = "crSigCdCrg.LibVMovDup"
  ControlSource = "crSigCdCrg.GrComis"
  ControlSource = "crSigCdCrg.LibFpgs"
  ControlSource = "crSigCdCrg.LibOpes"
  ControlSource = "crSigCdCrg.Tpcomis"
  ControlSource = "crSigCdCrg.libDupEnds"
  DeleteMark = .F.
  ControlSource = "crSigCdCrg.LibExPrd"
lcQueryCat = [select a.*, b.descs from sigcarct a join sigcdctg b on a.categoria = b.cods]
Create Cursor xCarcc From array v01
	.column1.ControlSource = 'xCarcc.Grupos'
	.Column2.controlsource = 'xCarcc.Contas'
	.column3.controlsource = 'xcarcc.Valors'
	.column4.controlsource = 'xcarcc.Moedas'
Create Cursor xCategoria From array v02
	.column1.ControlSource = 'xCategoria.categoria'
	.Column2.controlsource = 'xCategoria.descs'
	.column3.controlsource = 'xCategoria.tipo'
Insert Into crTabTipo (Codigos) Values ([ENTRADA])
Insert Into crTabTipo (Codigos) Values ([SAIDA])
Insert Into crTabTipo (Codigos) Values ([AMBOS])
Select crTabTipo
lcDelete = [Delete From SigCrRcc Where Cargos = ']+CrSigCdCrg.ccargs+[']
If ThisForm.PodataMgr.SqlExecute(lcDelete,'') < 0
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCrRcc)')
If llOks And Not ThisForm.poDataMgr.Update('crSigCrRcc')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCrRcc)')
	lcDelete = [Delete From SigCarCt Where Cargo = ']+CrSigCdCrg.ccargs+[']
	If ThisForm.PodataMgr.SqlExecute(lcDelete,'') < 0
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCarCt)')
	If llOks And Not ThisForm.poDataMgr.Update('crSigCarCt')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCarCt)')
lcDelete = [Delete From SigCrRcc Where Cargos = ']+CrSigCdCrg.ccargs+[']
If ThisForm.PodataMgr.SqlExecute(lcDelete,'') < 0
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCrRcc)')
	lcDelete = [Delete From SigCarCt Where Cargo = ']+CrSigCdCrg.ccargs+[']
	If ThisForm.PodataMgr.SqlExecute(lcDelete,'') < 0
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete - SigCarCt)')
If Not ThisForm.poDataMgr.Update('crSigCrRcc')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCrRcc)')
	If Not ThisForm.poDataMgr.Update('crSigCarCt')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCarCt)')
	SELECT crSigCdCrg
	SELECT crSigCdCrg
select crSigCdCrg
Select xCarcc
lcSql = [Select * From SigCrRcc Where Cargos = ']+CrSigCdCrg.ccargs+[']
=ThisForm.PodataMgr.SqlExecute(lcsql,'TmpCarcc')
Select TmpCarcc
	Select xCarcc
Select xCarcc
Select xCategoria
lcSql = [select a.*, b.descs from sigcarct a join sigcdctg b on a.categoria = b.cods Where a.Cargo = ']+CrSigCdCrg.ccargs+[']
=ThisForm.PodataMgr.SqlExecute(lcsql,'TmpCat')
Select TmpCat
	Select xCategoria
Select xCategoria
	select crSigCdCrg
	Select xCategoria
	Select Categoria from xCategoria into cursor Duplica group by Categoria having sum(1) > 1 
	Select Duplica
	Select CrSigCrRcc
	Select xCarCc
			Select CrSigCrRcc
	Select CrSigCarCt
	Select xCategoria
			Select CrSigCarCt
SELECT csSigCdCrg
SELECT crSigCdCrg
Select xCarcc
lcSql = [Select * From SigCrRcc Where Cargos = ']+CrSigCdCrg.ccargs+[']
=ThisForm.PodataMgr.SqlExecute(lcsql,'TmpCarcc')
Select TmpCarcc
	Select xCarcc
Select xCarcc
Select crSigCdCrg
Select XCarcc
Select XCarcc
Delete
Select grupos,contas,Moedas from xCarcc into cursor Duplica group by grupos,contas,Moedas having sum(1) > 1 
Select Duplica
	Select xCarCc
Select xCarcc
Select grupos,contas,Moedas from xCarcc into cursor Duplica group by grupos,contas,Moedas  having sum(1) > 1 
Select Duplica
	Select xCarCc
Select xCarcc
Select grupos,contas,Moedas from xCarcc into cursor Duplica group by grupos,contas,Moedas having sum(1) > 1 
Select Duplica
	Select xCarCc
Select xCarcc
Select XCategoria
Select Categoria
Delete
	Select crTabTipo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCargo.prg) - TRECHOS RELEVANTES PARA PASS SQL (3293 linhas total):

*-- Linhas 349 a 367:
349:             .HighlightBackColor      = RGB(255, 255, 255)
350:             .HighlightForeColor      = RGB(15, 41, 104)
351:             .HighlightStyle          = 2
352:             .DeleteMark              = .F.
353:             .RecordMark              = .F.
354:             .RowHeight               = 16
355:             .ScrollBars              = 2
356:             .GridLines               = 3
357:             .ReadOnly                = .T.
358:             .Visible                 = .T.
359:             .Column1.Width           = 100
360:             .Column2.Width           = 760
361:             .Column1.ReadOnly        = .T.
362:             .Column2.ReadOnly        = .T.
363:             .Column1.Header1.Caption = "Cargo"
364:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)

*-- Linhas 2039 a 2057:
2039:             .HighlightBackColor      = RGB(255, 255, 255)
2040:             .HighlightForeColor      = RGB(15, 41, 104)
2041:             .HighlightStyle          = 2
2042:             .DeleteMark              = .F.
2043:             .RecordMark              = .F.
2044:             .RowHeight               = 16
2045:             .ScrollBars              = 3
2046:             .GridLines               = 3
2047:             .ReadOnly                = .F.
2048:             .Visible                 = .T.
2049:             .Column1.Width           = 70
2050:             .Column2.Width           = 85
2051:             .Column3.Width           = 90
2052:             .Column4.Width           = 55
2053:             .Column1.Header1.Caption = "Grupo"
2054:             .Column2.Header1.Caption = "Conta"
2055:             .Column3.Header1.Caption = "Valor"
2056:             .Column4.Header1.Caption = "Moeda"
2057:         ENDWITH

*-- Linhas 2145 a 2163:
2145:             .HighlightBackColor      = RGB(255, 255, 255)
2146:             .HighlightForeColor      = RGB(15, 41, 104)
2147:             .HighlightStyle          = 2
2148:             .DeleteMark              = .F.
2149:             .RecordMark              = .F.
2150:             .RowHeight               = 16
2151:             .ScrollBars              = 3
2152:             .GridLines               = 3
2153:             .ReadOnly                = .F.
2154:             .Visible                 = .T.
2155:             .Column1.Width           = 60
2156:             .Column2.Width           = 170
2157:             .Column3.Width           = 75
2158:             .Column1.Header1.Caption = "Categoria"
2159:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2160:             .Column3.Header1.Caption = "Tipo"
2161:             .Column2.ReadOnly        = .T.
2162:         ENDWITH
2163: 

*-- Linhas 2224 a 2252:
2224: 
2225:         TRY
2226:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2227:                 CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(20))
2228:                 loc_lResultado = .T.
2229:             ELSE
2230:                 IF THIS.this_oBusinessObject.Buscar("")
2231:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2232:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2233: 
2234:                         loc_oGrid.ColumnCount  = 2
2235:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2236:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ccargs"
2237:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcargs"
2238: 
2239:                         loc_oGrid.Column1.Width = 100
2240:                         loc_oGrid.Column2.Width = 760
2241: 
2242:                         loc_oGrid.Column1.ReadOnly = .T.
2243:                         loc_oGrid.Column2.ReadOnly = .T.
2244: 
2245:                         loc_oGrid.Column1.Header1.Caption = "Cargo"
2246:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2247: 
2248:                         THIS.FormatarGridLista(loc_oGrid)
2249:                     ENDIF
2250:                     loc_lResultado = .T.
2251:                 ENDIF
2252:             ENDIF

*-- Linhas 2266 a 2305:
2266: 
2267:         TRY
2268:             *-- Grid acesso financeiro
2269:             IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
2270:                 loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2271:                 IF USED("cursor_4c_AcessoFinan")
2272:                     loc_oGridAcesso.ColumnCount = 4
2273:                     loc_oGridAcesso.RecordSource = "cursor_4c_AcessoFinan"
2274:                     loc_oGridAcesso.Column1.ControlSource = "cursor_4c_AcessoFinan.grupos"
2275:                     loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
2276:                     loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
2277:                     loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
2278:                     loc_oGridAcesso.Refresh
2279:                 ENDIF
2280:             ENDIF
2281: 
2282:             *-- Grid categorias
2283:             IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
2284:                 loc_oGridCat = loc_oPg2.grd_4c_Categorias
2285:                 IF USED("cursor_4c_Categorias")
2286:                     loc_oGridCat.ColumnCount = 3
2287:                     loc_oGridCat.RecordSource = "cursor_4c_Categorias"
2288:                     loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
2289:                     loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
2290:                     loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
2291:                     loc_oGridCat.Refresh
2292:                 ENDIF
2293:             ENDIF
2294:         CATCH TO loc_oErro
2295:             MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")
2296:         ENDTRY
2297:     ENDPROC
2298: 
2299:     *--------------------------------------------------------------------------
2300:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
2301:     *--------------------------------------------------------------------------
2302:     PROCEDURE AlternarPagina(par_nPagina)
2303:         LOCAL loc_lResultado
2304:         loc_lResultado = .F.
2305: 

*-- Linhas 2391 a 2409:
2391:             RETURN .F.
2392:         ENDIF
2393: 
2394:         SELECT cursor_4c_Dados
2395:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2396: 
2397:         TRY
2398:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2399:                 THIS.BOParaForm()
2400:                 THIS.this_cModoAtual = "VISUALIZAR"
2401:                 THIS.HabilitarCampos(.F.)
2402:                 THIS.AjustarBotoesPorModo()
2403:                 THIS.CarregarGrades()
2404:                 THIS.AlternarPagina(2)
2405:                 loc_lResultado = .T.
2406:             ENDIF
2407:         CATCH TO loc_oErro
2408:             MsgErro(loc_oErro.Message, "FormCargo.BtnVisualizarClick")
2409:         ENDTRY

*-- Linhas 2423 a 2441:
2423:             RETURN .F.
2424:         ENDIF
2425: 
2426:         SELECT cursor_4c_Dados
2427:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2428: 
2429:         TRY
2430:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2431:                 THIS.this_oBusinessObject.EditarRegistro()
2432:                 THIS.BOParaForm()
2433:                 THIS.this_cModoAtual = "ALTERAR"
2434:                 THIS.HabilitarCampos(.T.)
2435:                 THIS.AjustarBotoesPorModo()
2436:                 THIS.CarregarGrades()
2437:                 THIS.AlternarPagina(2)
2438:                 loc_lResultado = .T.
2439:             ENDIF
2440:         CATCH TO loc_oErro
2441:             MsgErro(loc_oErro.Message, "FormCargo.BtnAlterarClick")

*-- Linhas 2456 a 2474:
2456:             RETURN .F.
2457:         ENDIF
2458: 
2459:         SELECT cursor_4c_Dados
2460:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2461: 
2462:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2463:             RETURN .F.
2464:         ENDIF
2465: 
2466:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cargo " + loc_cCcargs + "?", "Excluir")
2467:             RETURN .F.
2468:         ENDIF
2469: 
2470:         TRY
2471:             IF THIS.this_oBusinessObject.Excluir()
2472:                 MsgInfo("Cargo exclu" + CHR(237) + "do com sucesso!")
2473:                 THIS.CarregarLista()
2474:                 loc_lResultado = .T.

*-- Linhas 2545 a 2563:
2545:                 THIS.this_cModoAtual = "LISTA"
2546:                 THIS.AlternarPagina(1)
2547:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
2548:                     SELECT cursor_4c_Dados
2549:                     LOCATE FOR ALLTRIM(cursor_4c_Dados.ccargs) = loc_cCodBusca
2550:                     IF !FOUND()
2551:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.dcargs)) = UPPER(loc_cCodBusca)
2552:                     ENDIF
2553:                 ENDIF
2554:                 loc_lResultado = .T.
2555:             ELSE
2556:                 IF THIS.FormParaBO()
2557:                     IF THIS.this_oBusinessObject.Salvar()
2558:                         MsgInfo("Cargo salvo com sucesso!")
2559:                         THIS.this_cModoAtual = "LISTA"
2560:                         THIS.AlternarPagina(1)
2561:                         loc_lResultado = .T.
2562:                     ENDIF
2563:                 ENDIF

*-- Linhas 2613 a 2631:
2613:                 ENDIF
2614: 
2615:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargoBase")
2616:                     SELECT cursor_4c_BuscaCargoBase
2617:                     loc_cCargoSelecionado = ALLTRIM(cursor_4c_BuscaCargoBase.ccargs)
2618: 
2619:                     IF !EMPTY(loc_cCargoSelecionado)
2620:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSelecionado)
2621:                             THIS.BOParaForm()
2622:                             *-- Limpa o codigo para o usuario digitar o novo
2623:                             loc_oPg2.txt_4c_Ccargs.Value = ""
2624:                             THIS.CarregarGrades()
2625:                         ENDIF
2626:                     ENDIF
2627:                 ENDIF
2628: 
2629:                 loc_oBusca.Release()
2630:             ENDIF
2631:         CATCH TO loc_oErro

*-- Linhas 2642 a 2739:
2642:     *--------------------------------------------------------------------------
2643:     PROCEDURE BtnInserirAcessoClick()
2644:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2645:             RETURN
2646:         ENDIF
2647:         IF !USED("cursor_4c_AcessoFinan")
2648:             RETURN
2649:         ENDIF
2650: 
2651:         TRY
2652:             SELECT cursor_4c_AcessoFinan
2653:             APPEND BLANK
2654:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2655:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Column1.SetFocus
2656:         CATCH TO loc_oErro
2657:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirAcessoClick")
2658:         ENDTRY
2659:     ENDPROC
2660: 
2661:     *--------------------------------------------------------------------------
2662:     * BtnExcluirAcessoClick - Remove linha da grade de acesso financeiro
2663:     *--------------------------------------------------------------------------
2664:     PROCEDURE BtnExcluirAcessoClick()
2665:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2666:             RETURN
2667:         ENDIF
2668:         IF !USED("cursor_4c_AcessoFinan")
2669:             RETURN
2670:         ENDIF
2671: 
2672:         SELECT cursor_4c_AcessoFinan
2673:         IF BOF() OR EOF()
2674:             RETURN
2675:         ENDIF
2676: 
2677:         TRY
2678:             DELETE
2679:             PACK
2680:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2681:         CATCH TO loc_oErro
2682:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirAcessoClick")
2683:         ENDTRY
2684:     ENDPROC
2685: 
2686:     *--------------------------------------------------------------------------
2687:     * BtnInserirCatClick - Adiciona linha na grade de categorias
2688:     *--------------------------------------------------------------------------
2689:     PROCEDURE BtnInserirCatClick()
2690:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2691:             RETURN
2692:         ENDIF
2693:         IF !USED("cursor_4c_Categorias")
2694:             RETURN
2695:         ENDIF
2696: 
2697:         TRY
2698:             SELECT cursor_4c_Categorias
2699:             APPEND BLANK
2700:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2701:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Column1.SetFocus
2702:         CATCH TO loc_oErro
2703:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirCatClick")
2704:         ENDTRY
2705:     ENDPROC
2706: 
2707:     *--------------------------------------------------------------------------
2708:     * BtnExcluirCatClick - Remove linha da grade de categorias
2709:     *--------------------------------------------------------------------------
2710:     PROCEDURE BtnExcluirCatClick()
2711:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2712:             RETURN
2713:         ENDIF
2714:         IF !USED("cursor_4c_Categorias")
2715:             RETURN
2716:         ENDIF
2717: 
2718:         SELECT cursor_4c_Categorias
2719:         IF BOF() OR EOF()
2720:             RETURN
2721:         ENDIF
2722: 
2723:         TRY
2724:             DELETE
2725:             PACK
2726:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2727:         CATCH TO loc_oErro
2728:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirCatClick")
2729:         ENDTRY
2730:     ENDPROC
2731: 
2732:     *--------------------------------------------------------------------------
2733:     * FormParaBO - Transfere valores do form para o BO
2734:     *--------------------------------------------------------------------------
2735:     PROTECTED PROCEDURE FormParaBO()
2736:         LOCAL loc_oPg2, loc_lResultado
2737:         loc_lResultado = .F.
2738: 
2739:         TRY

*-- Linhas 3001 a 3019:
3001:                 ENDIF
3002: 
3003:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
3004:                     SELECT cursor_4c_BuscaGcr
3005:                     loc_oPg2.txt_4c_Grcomis.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
3006:                 ENDIF
3007: 
3008:                 loc_oBusca.Release()
3009:             ENDIF
3010:         CATCH TO loc_oErro
3011:             MsgErro(loc_oErro.Message, "FormCargo.BuscarGrupoFinan")
3012:         ENDTRY
3013: 
3014:         IF USED("cursor_4c_BuscaGcr")
3015:             USE IN cursor_4c_BuscaGcr
3016:         ENDIF
3017:     ENDPROC
3018: 
3019:     *--------------------------------------------------------------------------

*-- Linhas 3044 a 3064:
3044:                     loc_oBusca.Show()
3045:                 ENDIF
3046: 
3047:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3048:                     SELECT cursor_4c_BuscaGcr2
3049:                     REPLACE grupos WITH ALLTRIM(cursor_4c_BuscaGcr2.Codigos) IN cursor_4c_AcessoFinan
3050:                     loc_oGrid.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3051:                     loc_oGrid.Refresh
3052:                 ENDIF
3053: 
3054:                 loc_oBusca.Release()
3055:             ENDIF
3056:         CATCH TO loc_oErro
3057:             MsgErro(loc_oErro.Message, "FormCargo.ValidarGrupoGrade")
3058:         ENDTRY
3059: 
3060:         IF USED("cursor_4c_BuscaGcr2")
3061:             USE IN cursor_4c_BuscaGcr2
3062:         ENDIF
3063:     ENDPROC
3064: 

*-- Linhas 3092 a 3112:
3092:                     loc_oBusca.Show()
3093:                 ENDIF
3094: 
3095:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3096:                     SELECT cursor_4c_BuscaConta
3097:                     REPLACE contas WITH ALLTRIM(cursor_4c_BuscaConta.Codigos) IN cursor_4c_AcessoFinan
3098:                     loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaConta.Codigos)
3099:                     loc_oGrid.Refresh
3100:                 ENDIF
3101: 
3102:                 loc_oBusca.Release()
3103:             ENDIF
3104:         CATCH TO loc_oErro
3105:             MsgErro(loc_oErro.Message, "FormCargo.ValidarContaGrade")
3106:         ENDTRY
3107: 
3108:         IF USED("cursor_4c_BuscaConta")
3109:             USE IN cursor_4c_BuscaConta
3110:         ENDIF
3111:     ENDPROC
3112: 

*-- Linhas 3138 a 3158:
3138:                     loc_oBusca.Show()
3139:                 ENDIF
3140: 
3141:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3142:                     SELECT cursor_4c_BuscaMoe
3143:                     REPLACE moedas WITH ALLTRIM(cursor_4c_BuscaMoe.CMoes) IN cursor_4c_AcessoFinan
3144:                     loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3145:                     loc_oGrid.Refresh
3146:                 ENDIF
3147: 
3148:                 loc_oBusca.Release()
3149:             ENDIF
3150:         CATCH TO loc_oErro
3151:             MsgErro(loc_oErro.Message, "FormCargo.ValidarMoedaGrade")
3152:         ENDTRY
3153: 
3154:         IF USED("cursor_4c_BuscaMoe")
3155:             USE IN cursor_4c_BuscaMoe
3156:         ENDIF
3157:     ENDPROC
3158: 

*-- Linhas 3185 a 3206:
3185:                 ENDIF
3186: 
3187:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
3188:                     SELECT cursor_4c_BuscaCtg
3189:                     REPLACE categoria WITH ALLTRIM(cursor_4c_BuscaCtg.Cods), ;
3190:                             descs     WITH ALLTRIM(cursor_4c_BuscaCtg.Descs) ;
3191:                         IN cursor_4c_Categorias
3192:                     loc_oGridCat.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Cods)
3193:                     loc_oGridCat.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Descs)
3194:                     loc_oGridCat.Refresh
3195:                 ENDIF
3196: 
3197:                 loc_oBusca.Release()
3198:             ENDIF
3199:         CATCH TO loc_oErro
3200:             MsgErro(loc_oErro.Message, "FormCargo.ValidarCategoriaGrade")
3201:         ENDTRY
3202: 
3203:         IF USED("cursor_4c_BuscaCtg")
3204:             USE IN cursor_4c_BuscaCtg
3205:         ENDIF
3206:     ENDPROC

*-- Linhas 3251 a 3293:
3251:                 ENDIF
3252: 
3253:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTipo")
3254:                     SELECT cursor_4c_BuscaTipo
3255:                     REPLACE tipo WITH ALLTRIM(cursor_4c_BuscaTipo.tipo) ;
3256:                         IN cursor_4c_Categorias
3257:                     loc_oGridCat.Column3.Text1.Value = ALLTRIM(cursor_4c_BuscaTipo.tipo)
3258:                     loc_oGridCat.Refresh
3259:                 ENDIF
3260: 
3261:                 loc_oBusca.Release()
3262:             ENDIF
3263:         CATCH TO loc_oErro
3264:             MsgErro(loc_oErro.Message, "FormCargo.ValidarTipoCategoria")
3265:         ENDTRY
3266: 
3267:         IF USED("cursor_4c_BuscaTipo")
3268:             USE IN cursor_4c_BuscaTipo
3269:         ENDIF
3270:     ENDPROC
3271: 
3272:     *--------------------------------------------------------------------------
3273:     * Destroy - Libera recursos e cursores
3274:     *--------------------------------------------------------------------------
3275:     PROCEDURE Destroy()
3276:         TRY
3277:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3278:                 THIS.this_oBusinessObject = .NULL.
3279:             ENDIF
3280:             IF USED("cursor_4c_AcessoFinan")
3281:                 USE IN cursor_4c_AcessoFinan
3282:             ENDIF
3283:             IF USED("cursor_4c_Categorias")
3284:                 USE IN cursor_4c_Categorias
3285:             ENDIF
3286:         CATCH TO loc_oErro
3287:             MsgErro(loc_oErro.Message, "FormCargo.Destroy")
3288:         ENDTRY
3289: 
3290:         DODEFAULT()
3291:     ENDPROC
3292: 
3293: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CargoBO.prg):
*====================================================================
* CargoBO.prg
*
* Business Object para Cargos
* Tabela principal: SIGCDCRG (ccargs PK)
* Sub-tabelas: SIGCRRCC (acesso financeiro), sigcarct (categorias)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CargoBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCRG)
	this_cCcargs      = ""   && ccargs char(10)      - PK (codigo do cargo)
	this_cDcargs      = ""   && dcargs char(20)       - descricao
	this_nAcrepors    = 0    && acrepors numeric(9,2) - acrescimo %
	this_cAltcots     = ""   && altcots char(1)       - altera cotacao (S/N)
	this_nComis       = 0    && comis numeric(5,2)    - comissao %
	this_dDatatrans   = {}   && datatrans datetime    - data transacao (NULL)
	this_nDescpors    = 0    && descpors numeric(9,2) - desconto %
	this_nLimacres    = 0    && limacres numeric(11,2) - limite acrescimo (R$)
	this_nLimdescs    = 0    && limdescs numeric(11,2) - limite desconto (R$)
	this_cNivels      = ""   && nivels char(1)        - senha (S/N)
	this_nVarcots     = 0    && varcots numeric(5,2)  - variacao cotacao %
	this_cLimites     = ""   && limites char(1)       - libera limite (S/N)
	this_nAcomis      = 0    && acomis numeric(5,2)   - fator de comissao %
	this_cFcomis      = ""   && fcomis char(1)        - tipo comissao S/N
	this_cCancitens   = ""   && cancitens char(1)     - cancela item cupom fiscal (S/N)
	this_nVllibpgs    = 0    && vllibpgs numeric(11,2) - valor liberar pagamentos (R$)
	this_cLibfpags    = ""   && libfpags char(1)      - excluir cond. pagto ecf (S/N)
	this_cLibsdins    = ""   && libsdins char(1)      - libera saldo insuficiente (S/N)
	this_nVllibcots   = 0    && vllibcots numeric(11,2) - valor liberar cotacoes (R$)
	this_nVllibopes   = 0    && vllibopes numeric(11,2) - valor liberar movimentacoes (R$)
	this_cLibfpgs     = ""   && libfpgs char(1)       - libera condicao pagto (S/N)
	this_cLibopes     = ""   && libopes char(1)       - liberar movim. estoque (S/N)
	this_cGrcomis     = ""   && grcomis char(10)      - grupo financeiro
	this_nTpcomis     = 0    && tpcomis numeric(1,0)  - tipo comissao (OptionGroup)
	this_nLibleilaos  = 0    && libleilaos numeric(1,0) - libera leilao (OptionGroup)
	this_nLibdupends  = 0    && libdupends numeric(1,0) - libera duplicidade (OptionGroup)
	this_nLibduptits  = 0    && libduptits numeric(1,0) - liberar titulos iguais (OptionGroup)
	this_nLibprzes    = 0    && libprzes numeric(1,0) - liberar prazo entrega (OptionGroup)
	this_nLibsldtqe   = 0    && libsldtqe numeric(1,0) - libera saldo cotacao (OptionGroup)
	this_cLibaltcli   = ""   && libaltcli char(1)     - libera alterar cliente (S/N)
	this_cLibexprd    = ""   && libexprd char(1)      - libera excluir mov. producao (S/N)
	this_nCustoprod   = 0    && custoprod numeric(1,0) - custo producao (OptionGroup)
	this_cLibvmovdup  = ""   && libvmovdup char(1)    - liberar variacao mov dupla (S/N)
	this_nVarmovdup   = 0    && varmovdup numeric(5,2) - variacao mov dupla %
	this_cLibopers    = ""   && libopers char(1)      - liberar operacoes (S/N)
	this_cLibvarpeso  = ""   && libvarpeso char(1)    - liberar variacao peso (S/N)
	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)

	*-- Colunas adicionais presentes no banco (nao no schema dump inicial)
	this_cConsSubn    = ""   && ConsSubn char(1)      - libera consulta todos subniveis (S/N)
	this_nLibValmmax  = 0    && libValMMax numeric(1,0) - libera valor max malote (OptionGroup)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCRG"
		THIS.this_cCampoChave = "ccargs"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCcargs)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de cargos no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG ORDER BY ccargs"
			ELSE
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG" + ;
				           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " OR dcargs LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY ccargs"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cargos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar cargos:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT acrepors, altcots, ccargs, comis, datatrans," + ;
			           " dcargs, descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs, libfpags," + ;
			           " libsdins, vllibcots, vllibopes, libfpgs, libopes, grcomis," + ;
			           " tpcomis, libleilaos, libdupends, libduptits, libprzes," + ;
			           " libsldtqe, libaltcli, libexprd, custoprod, libvmovdup," + ;
			           " varmovdup, libopers, libvarpeso, libmultvends, altvlpro" + ;
			           " FROM SIGCDCRG" + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
				IF loc_lSucesso
					THIS.CarregarSubTabelaAcessoFinan(par_cCcargs)
					THIS.CarregarSubTabelaCategorias(par_cCcargs)
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCcargs       = TratarNulo(ccargs, "C")
			THIS.this_cDcargs       = TratarNulo(dcargs, "C")
			THIS.this_nAcrepors     = TratarNulo(acrepors, "N")
			THIS.this_cAltcots      = TratarNulo(altcots, "C")
			THIS.this_nComis        = TratarNulo(comis, "N")
			THIS.this_nDescpors     = TratarNulo(descpors, "N")
			THIS.this_nLimacres     = TratarNulo(limacres, "N")
			THIS.this_nLimdescs     = TratarNulo(limdescs, "N")
			THIS.this_cNivels       = TratarNulo(nivels, "C")
			THIS.this_nVarcots      = TratarNulo(varcots, "N")
			THIS.this_cLimites      = TratarNulo(limites, "C")
			THIS.this_nAcomis       = TratarNulo(acomis, "N")
			THIS.this_cFcomis       = TratarNulo(fcomis, "C")
			THIS.this_cCancitens    = TratarNulo(cancitens, "C")
			THIS.this_nVllibpgs     = TratarNulo(vllibpgs, "N")
			THIS.this_cLibfpags     = TratarNulo(libfpags, "C")
			THIS.this_cLibsdins     = TratarNulo(libsdins, "C")
			THIS.this_nVllibcots    = TratarNulo(vllibcots, "N")
			THIS.this_nVllibopes    = TratarNulo(vllibopes, "N")
			THIS.this_cLibfpgs      = TratarNulo(libfpgs, "C")
			THIS.this_cLibopes      = TratarNulo(libopes, "C")
			THIS.this_cGrcomis      = TratarNulo(grcomis, "C")
			THIS.this_nTpcomis      = TratarNulo(tpcomis, "N")
			THIS.this_nLibleilaos   = TratarNulo(libleilaos, "N")
			THIS.this_nLibdupends   = TratarNulo(libdupends, "N")
			THIS.this_nLibduptits   = TratarNulo(libduptits, "N")
			THIS.this_nLibprzes     = TratarNulo(libprzes, "N")
			THIS.this_nLibsldtqe    = TratarNulo(libsldtqe, "N")
			THIS.this_cLibaltcli    = TratarNulo(libaltcli, "C")
			THIS.this_cLibexprd     = TratarNulo(libexprd, "C")
			THIS.this_nCustoprod    = TratarNulo(custoprod, "N")
			THIS.this_cLibvmovdup   = TratarNulo(libvmovdup, "C")
			THIS.this_nVarmovdup    = TratarNulo(varmovdup, "N")
			THIS.this_cLibopers     = TratarNulo(libopers, "C")
			THIS.this_cLibvarpeso   = TratarNulo(libvarpeso, "C")
			THIS.this_nLibmultvends = TratarNulo(libmultvends, "N")
			THIS.this_nAltvlpro     = TratarNulo(altvlpro, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaAcessoFinan - Carrega acesso financeiro (SIGCRRCC)
	*====================================================================
	PROCEDURE CarregarSubTabelaAcessoFinan(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_AcessoFinan")
				USE IN cursor_4c_AcessoFinan
			ENDIF

			loc_cSQL = "SELECT grupos, contas, valors, moedas FROM SIGCRRCC" + ;
			           " WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY grupos, contas"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessoFinan")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaCategorias - Carrega categorias (sigcarct + sigcdctg)
	*====================================================================
	PROCEDURE CarregarSubTabelaCategorias(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Categorias")
				USE IN cursor_4c_Categorias
			ENDIF

			loc_cSQL = "SELECT a.categoria, ISNULL(b.descs, '') AS descs, a.tipo, a.cargo" + ;
			           " FROM sigcarct a" + ;
			           " LEFT JOIN sigcdctg b ON RTRIM(b.cods) = RTRIM(a.categoria)" + ;
			           " WHERE RTRIM(a.cargo) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY a.categoria"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Categorias")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursoresGrid - Cria cursores vazios para grids em INCLUIR
	*====================================================================
	PROCEDURE InicializarCursoresGrid()
		IF USED("cursor_4c_AcessoFinan")
			USE IN cursor_4c_AcessoFinan
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_AcessoFinan (grupos C(10), contas C(10), valors N(13,2), moedas C(3))
		SET NULL OFF

		IF USED("cursor_4c_Categorias")
			USE IN cursor_4c_Categorias
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_Categorias (categoria C(6), descs C(30), tipo C(10), cargo C(10))
		SET NULL OFF
	ENDPROC

	*====================================================================
	* SalvarSubTabelaAcessoFinan - Salva acesso financeiro (SIGCRRCC)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaAcessoFinan()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_AcessoFinan") AND RECCOUNT("cursor_4c_AcessoFinan") > 0
					GO TOP IN cursor_4c_AcessoFinan
					SELECT cursor_4c_AcessoFinan
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.grupos)) .OR. ;
						   !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.contas))
							loc_cCidchaves = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO SIGCRRCC (cargos, cidchaves, grupos, contas, valors, moedas)" + ;
							           " VALUES (" + ;
							           EscaparSQL(THIS.this_cCcargs) + "," + ;
							           EscaparSQL(loc_cCidchaves) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.grupos) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.contas) + "," + ;
							           FormatarNumeroSQL(cursor_4c_AcessoFinan.valors) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.moedas) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarSubTabelaCategorias - Salva categorias (sigcarct)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaCategorias()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChave
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_Categorias") AND RECCOUNT("cursor_4c_Categorias") > 0
					GO TOP IN cursor_4c_Categorias
					SELECT cursor_4c_Categorias
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_Categorias.categoria))
							loc_cPkChave = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO sigcarct (categoria, pkchave, tipo, cargo)" + ;
							           " VALUES (" + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.categoria), 6)) + "," + ;
							           EscaparSQL(loc_cPkChave) + "," + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.tipo), 10)) + "," + ;
							           EscaparSQL(THIS.this_cCcargs) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SIGCDCRG" + ;
			           " (ccargs, dcargs, acrepors, altcots, comis," + ;
			           " descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs," + ;
			           " libfpags, libsdins, vllibcots, vllibopes, libfpgs," + ;
			           " libopes, grcomis, tpcomis, libleilaos, libdupends," + ;
			           " libduptits, libprzes, libsldtqe, libaltcli, libexprd," + ;
			           " custoprod, libvmovdup, varmovdup, libopers, libvarpeso," + ;
			           " libmultvends, altvlpro, ConsSubn, libValMMax)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCcargs) + "," + ;
			           EscaparSQL(THIS.this_cDcargs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           EscaparSQL(THIS.this_cAltcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           EscaparSQL(THIS.this_cNivels) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           EscaparSQL(THIS.this_cLimites) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           EscaparSQL(THIS.this_cFcomis) + "," + ;
			           EscaparSQL(THIS.this_cCancitens) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibopes) + "," + ;
			           EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           EscaparSQL(THIS.this_cLibopers) + "," + ;
			           EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCRG SET" + ;
			           " dcargs = " + EscaparSQL(THIS.this_cDcargs) + "," + ;
			           " acrepors = " + FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           " altcots = " + EscaparSQL(THIS.this_cAltcots) + "," + ;
			           " comis = " + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           " descpors = " + FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           " limacres = " + FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           " limdescs = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
			           " varcots = " + FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           " limites = " + EscaparSQL(THIS.this_cLimites) + "," + ;
			           " acomis = " + FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           " fcomis = " + EscaparSQL(THIS.this_cFcomis) + "," + ;
			           " cancitens = " + EscaparSQL(THIS.this_cCancitens) + "," + ;
			           " vllibpgs = " + FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           " libfpags = " + EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           " libsdins = " + EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           " vllibcots = " + FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           " vllibopes = " + FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           " libfpgs = " + EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           " libopes = " + EscaparSQL(THIS.this_cLibopes) + "," + ;
			           " grcomis = " + EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           " tpcomis = " + FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           " libleilaos = " + FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           " libdupends = " + FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           " libduptits = " + FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           " libprzes = " + FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           " libsldtqe = " + FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           " libaltcli = " + EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           " libexprd = " + EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           " custoprod = " + FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           " libvmovdup = " + EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           " varmovdup = " + FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           " ConsSubn = " + EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           " libValMMax = " + FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE SIGCRRCC + sigcarct + SIGCDCRG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- 1. Excluir acesso financeiro (SIGCRRCC)
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- 2. Excluir categorias (sigcarct)
				loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					MsgErro("Erro ao excluir categorias do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Excluir registro principal (SIGCDCRG)
					loc_cSQL = "DELETE FROM SIGCDCRG WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

