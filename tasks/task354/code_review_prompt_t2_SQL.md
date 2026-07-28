# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [GRID-SQL] Campo 'categoria' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'descs' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'tipo' usado em ControlSource de cursor_4c_Categorias mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'contas' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'valors' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'moedas' usado em ControlSource de cursor_4c_AcessoFinan mas NAO aparece no SELECT SQL

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCargo.prg) - TRECHOS RELEVANTES PARA PASS SQL (3302 linhas total):

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
363:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
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
2160:             .Column3.Header1.Caption = "Validar"
2161:             .Column2.ReadOnly        = .T.
2162:         ENDWITH
2163: 

*-- Linhas 2225 a 2254:
2225:         TRY
2226:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2227:                 SET NULL ON
2228:                 CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(20))
2229:                 SET NULL OFF
2230:                 loc_lResultado = .T.
2231:             ELSE
2232:                 IF THIS.this_oBusinessObject.Buscar("")
2233:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2234:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2235: 
2236:                         loc_oGrid.ColumnCount  = 2
2237:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2238:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ccargs"
2239:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcargs"
2240: 
2241:                         loc_oGrid.Column1.Width = 100
2242:                         loc_oGrid.Column2.Width = 760
2243: 
2244:                         loc_oGrid.Column1.ReadOnly = .T.
2245:                         loc_oGrid.Column2.ReadOnly = .T.
2246: 
2247:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2248:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2249: 
2250:                         THIS.FormatarGridLista(loc_oGrid)
2251:                     ENDIF
2252:                     loc_lResultado = .T.
2253:                 ENDIF
2254:             ENDIF

*-- Linhas 2268 a 2311:
2268: 
2269:         TRY
2270:             *-- Grid acesso financeiro
2271:             IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
2272:                 loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2273:                 IF USED("cursor_4c_AcessoFinan")
2274:                     loc_oGridAcesso.ColumnCount = 4
2275:                     loc_oGridAcesso.RecordSource = "cursor_4c_AcessoFinan"
2276:                     loc_oGridAcesso.Column1.ControlSource = "cursor_4c_AcessoFinan.grupos"
2277:                     loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
2278:                     loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
2279:                     loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
2280:                     loc_oGridAcesso.Column1.Header1.Caption = "Grupo"
2281:                     loc_oGridAcesso.Column2.Header1.Caption = "Conta"
2282:                     loc_oGridAcesso.Column3.Header1.Caption = "Valor"
2283:                     loc_oGridAcesso.Column4.Header1.Caption = "Moeda"
2284:                     loc_oGridAcesso.Refresh
2285:                 ENDIF
2286:             ENDIF
2287: 
2288:             *-- Grid categorias
2289:             IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
2290:                 loc_oGridCat = loc_oPg2.grd_4c_Categorias
2291:                 IF USED("cursor_4c_Categorias")
2292:                     loc_oGridCat.ColumnCount = 3
2293:                     loc_oGridCat.RecordSource = "cursor_4c_Categorias"
2294:                     loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
2295:                     loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
2296:                     loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
2297:                     loc_oGridCat.Column1.Header1.Caption = "Categoria"
2298:                     loc_oGridCat.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2299:                     loc_oGridCat.Column3.Header1.Caption = "Validar"
2300:                     loc_oGridCat.Refresh
2301:                 ENDIF
2302:             ENDIF
2303:         CATCH TO loc_oErro
2304:             MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")
2305:         ENDTRY
2306:     ENDPROC
2307: 
2308:     *--------------------------------------------------------------------------
2309:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
2310:     *--------------------------------------------------------------------------
2311:     PROCEDURE AlternarPagina(par_nPagina)

*-- Linhas 2400 a 2418:
2400:             RETURN .F.
2401:         ENDIF
2402: 
2403:         SELECT cursor_4c_Dados
2404:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2405: 
2406:         TRY
2407:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2408:                 THIS.BOParaForm()
2409:                 THIS.this_cModoAtual = "VISUALIZAR"
2410:                 THIS.HabilitarCampos(.F.)
2411:                 THIS.AjustarBotoesPorModo()
2412:                 THIS.CarregarGrades()
2413:                 THIS.AlternarPagina(2)
2414:                 loc_lResultado = .T.
2415:             ENDIF
2416:         CATCH TO loc_oErro
2417:             MsgErro(loc_oErro.Message, "FormCargo.BtnVisualizarClick")
2418:         ENDTRY

*-- Linhas 2432 a 2450:
2432:             RETURN .F.
2433:         ENDIF
2434: 
2435:         SELECT cursor_4c_Dados
2436:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2437: 
2438:         TRY
2439:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2440:                 THIS.this_oBusinessObject.EditarRegistro()
2441:                 THIS.BOParaForm()
2442:                 THIS.this_cModoAtual = "ALTERAR"
2443:                 THIS.HabilitarCampos(.T.)
2444:                 THIS.AjustarBotoesPorModo()
2445:                 THIS.CarregarGrades()
2446:                 THIS.AlternarPagina(2)
2447:                 loc_lResultado = .T.
2448:             ENDIF
2449:         CATCH TO loc_oErro
2450:             MsgErro(loc_oErro.Message, "FormCargo.BtnAlterarClick")

*-- Linhas 2465 a 2483:
2465:             RETURN .F.
2466:         ENDIF
2467: 
2468:         SELECT cursor_4c_Dados
2469:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2470: 
2471:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2472:             RETURN .F.
2473:         ENDIF
2474: 
2475:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cargo " + loc_cCcargs + "?", "Excluir")
2476:             RETURN .F.
2477:         ENDIF
2478: 
2479:         TRY
2480:             IF THIS.this_oBusinessObject.Excluir()
2481:                 MsgInfo("Cargo exclu" + CHR(237) + "do com sucesso!")
2482:                 THIS.CarregarLista()
2483:                 loc_lResultado = .T.

*-- Linhas 2554 a 2572:
2554:                 THIS.this_cModoAtual = "LISTA"
2555:                 THIS.AlternarPagina(1)
2556:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
2557:                     SELECT cursor_4c_Dados
2558:                     LOCATE FOR ALLTRIM(cursor_4c_Dados.ccargs) = loc_cCodBusca
2559:                     IF !FOUND()
2560:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.dcargs)) = UPPER(loc_cCodBusca)
2561:                     ENDIF
2562:                 ENDIF
2563:                 loc_lResultado = .T.
2564:             ELSE
2565:                 IF THIS.FormParaBO()
2566:                     IF THIS.this_oBusinessObject.Salvar()
2567:                         MsgInfo("Cargo salvo com sucesso!")
2568:                         THIS.this_cModoAtual = "LISTA"
2569:                         THIS.AlternarPagina(1)
2570:                         loc_lResultado = .T.
2571:                     ENDIF
2572:                 ENDIF

*-- Linhas 2622 a 2640:
2622:                 ENDIF
2623: 
2624:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargoBase")
2625:                     SELECT cursor_4c_BuscaCargoBase
2626:                     loc_cCargoSelecionado = ALLTRIM(cursor_4c_BuscaCargoBase.ccargs)
2627: 
2628:                     IF !EMPTY(loc_cCargoSelecionado)
2629:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSelecionado)
2630:                             THIS.BOParaForm()
2631:                             *-- Limpa o codigo para o usuario digitar o novo
2632:                             loc_oPg2.txt_4c_Ccargs.Value = ""
2633:                             THIS.CarregarGrades()
2634:                         ENDIF
2635:                     ENDIF
2636:                 ENDIF
2637: 
2638:                 loc_oBusca.Release()
2639:             ENDIF
2640:         CATCH TO loc_oErro

*-- Linhas 2651 a 2748:
2651:     *--------------------------------------------------------------------------
2652:     PROCEDURE BtnInserirAcessoClick()
2653:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2654:             RETURN
2655:         ENDIF
2656:         IF !USED("cursor_4c_AcessoFinan")
2657:             RETURN
2658:         ENDIF
2659: 
2660:         TRY
2661:             SELECT cursor_4c_AcessoFinan
2662:             APPEND BLANK
2663:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2664:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Column1.SetFocus
2665:         CATCH TO loc_oErro
2666:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirAcessoClick")
2667:         ENDTRY
2668:     ENDPROC
2669: 
2670:     *--------------------------------------------------------------------------
2671:     * BtnExcluirAcessoClick - Remove linha da grade de acesso financeiro
2672:     *--------------------------------------------------------------------------
2673:     PROCEDURE BtnExcluirAcessoClick()
2674:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2675:             RETURN
2676:         ENDIF
2677:         IF !USED("cursor_4c_AcessoFinan")
2678:             RETURN
2679:         ENDIF
2680: 
2681:         SELECT cursor_4c_AcessoFinan
2682:         IF BOF() OR EOF()
2683:             RETURN
2684:         ENDIF
2685: 
2686:         TRY
2687:             DELETE
2688:             PACK
2689:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2690:         CATCH TO loc_oErro
2691:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirAcessoClick")
2692:         ENDTRY
2693:     ENDPROC
2694: 
2695:     *--------------------------------------------------------------------------
2696:     * BtnInserirCatClick - Adiciona linha na grade de categorias
2697:     *--------------------------------------------------------------------------
2698:     PROCEDURE BtnInserirCatClick()
2699:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2700:             RETURN
2701:         ENDIF
2702:         IF !USED("cursor_4c_Categorias")
2703:             RETURN
2704:         ENDIF
2705: 
2706:         TRY
2707:             SELECT cursor_4c_Categorias
2708:             APPEND BLANK
2709:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2710:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Column1.SetFocus
2711:         CATCH TO loc_oErro
2712:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirCatClick")
2713:         ENDTRY
2714:     ENDPROC
2715: 
2716:     *--------------------------------------------------------------------------
2717:     * BtnExcluirCatClick - Remove linha da grade de categorias
2718:     *--------------------------------------------------------------------------
2719:     PROCEDURE BtnExcluirCatClick()
2720:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2721:             RETURN
2722:         ENDIF
2723:         IF !USED("cursor_4c_Categorias")
2724:             RETURN
2725:         ENDIF
2726: 
2727:         SELECT cursor_4c_Categorias
2728:         IF BOF() OR EOF()
2729:             RETURN
2730:         ENDIF
2731: 
2732:         TRY
2733:             DELETE
2734:             PACK
2735:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2736:         CATCH TO loc_oErro
2737:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirCatClick")
2738:         ENDTRY
2739:     ENDPROC
2740: 
2741:     *--------------------------------------------------------------------------
2742:     * FormParaBO - Transfere valores do form para o BO
2743:     *--------------------------------------------------------------------------
2744:     PROTECTED PROCEDURE FormParaBO()
2745:         LOCAL loc_oPg2, loc_lResultado
2746:         loc_lResultado = .F.
2747: 
2748:         TRY

*-- Linhas 3010 a 3028:
3010:                 ENDIF
3011: 
3012:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
3013:                     SELECT cursor_4c_BuscaGcr
3014:                     loc_oPg2.txt_4c_Grcomis.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
3015:                 ENDIF
3016: 
3017:                 loc_oBusca.Release()
3018:             ENDIF
3019:         CATCH TO loc_oErro
3020:             MsgErro(loc_oErro.Message, "FormCargo.BuscarGrupoFinan")
3021:         ENDTRY
3022: 
3023:         IF USED("cursor_4c_BuscaGcr")
3024:             USE IN cursor_4c_BuscaGcr
3025:         ENDIF
3026:     ENDPROC
3027: 
3028:     *--------------------------------------------------------------------------

*-- Linhas 3053 a 3073:
3053:                     loc_oBusca.Show()
3054:                 ENDIF
3055: 
3056:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3057:                     SELECT cursor_4c_BuscaGcr2
3058:                     REPLACE grupos WITH ALLTRIM(cursor_4c_BuscaGcr2.Codigos) IN cursor_4c_AcessoFinan
3059:                     loc_oGrid.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3060:                     loc_oGrid.Refresh
3061:                 ENDIF
3062: 
3063:                 loc_oBusca.Release()
3064:             ENDIF
3065:         CATCH TO loc_oErro
3066:             MsgErro(loc_oErro.Message, "FormCargo.ValidarGrupoGrade")
3067:         ENDTRY
3068: 
3069:         IF USED("cursor_4c_BuscaGcr2")
3070:             USE IN cursor_4c_BuscaGcr2
3071:         ENDIF
3072:     ENDPROC
3073: 

*-- Linhas 3101 a 3121:
3101:                     loc_oBusca.Show()
3102:                 ENDIF
3103: 
3104:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3105:                     SELECT cursor_4c_BuscaConta
3106:                     REPLACE contas WITH ALLTRIM(cursor_4c_BuscaConta.Codigos) IN cursor_4c_AcessoFinan
3107:                     loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaConta.Codigos)
3108:                     loc_oGrid.Refresh
3109:                 ENDIF
3110: 
3111:                 loc_oBusca.Release()
3112:             ENDIF
3113:         CATCH TO loc_oErro
3114:             MsgErro(loc_oErro.Message, "FormCargo.ValidarContaGrade")
3115:         ENDTRY
3116: 
3117:         IF USED("cursor_4c_BuscaConta")
3118:             USE IN cursor_4c_BuscaConta
3119:         ENDIF
3120:     ENDPROC
3121: 

*-- Linhas 3147 a 3167:
3147:                     loc_oBusca.Show()
3148:                 ENDIF
3149: 
3150:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3151:                     SELECT cursor_4c_BuscaMoe
3152:                     REPLACE moedas WITH ALLTRIM(cursor_4c_BuscaMoe.CMoes) IN cursor_4c_AcessoFinan
3153:                     loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3154:                     loc_oGrid.Refresh
3155:                 ENDIF
3156: 
3157:                 loc_oBusca.Release()
3158:             ENDIF
3159:         CATCH TO loc_oErro
3160:             MsgErro(loc_oErro.Message, "FormCargo.ValidarMoedaGrade")
3161:         ENDTRY
3162: 
3163:         IF USED("cursor_4c_BuscaMoe")
3164:             USE IN cursor_4c_BuscaMoe
3165:         ENDIF
3166:     ENDPROC
3167: 

*-- Linhas 3194 a 3215:
3194:                 ENDIF
3195: 
3196:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
3197:                     SELECT cursor_4c_BuscaCtg
3198:                     REPLACE categoria WITH ALLTRIM(cursor_4c_BuscaCtg.Cods), ;
3199:                             descs     WITH ALLTRIM(cursor_4c_BuscaCtg.Descs) ;
3200:                         IN cursor_4c_Categorias
3201:                     loc_oGridCat.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Cods)
3202:                     loc_oGridCat.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Descs)
3203:                     loc_oGridCat.Refresh
3204:                 ENDIF
3205: 
3206:                 loc_oBusca.Release()
3207:             ENDIF
3208:         CATCH TO loc_oErro
3209:             MsgErro(loc_oErro.Message, "FormCargo.ValidarCategoriaGrade")
3210:         ENDTRY
3211: 
3212:         IF USED("cursor_4c_BuscaCtg")
3213:             USE IN cursor_4c_BuscaCtg
3214:         ENDIF
3215:     ENDPROC

*-- Linhas 3260 a 3302:
3260:                 ENDIF
3261: 
3262:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTipo")
3263:                     SELECT cursor_4c_BuscaTipo
3264:                     REPLACE tipo WITH ALLTRIM(cursor_4c_BuscaTipo.tipo) ;
3265:                         IN cursor_4c_Categorias
3266:                     loc_oGridCat.Column3.Text1.Value = ALLTRIM(cursor_4c_BuscaTipo.tipo)
3267:                     loc_oGridCat.Refresh
3268:                 ENDIF
3269: 
3270:                 loc_oBusca.Release()
3271:             ENDIF
3272:         CATCH TO loc_oErro
3273:             MsgErro(loc_oErro.Message, "FormCargo.ValidarTipoCategoria")
3274:         ENDTRY
3275: 
3276:         IF USED("cursor_4c_BuscaTipo")
3277:             USE IN cursor_4c_BuscaTipo
3278:         ENDIF
3279:     ENDPROC
3280: 
3281:     *--------------------------------------------------------------------------
3282:     * Destroy - Libera recursos e cursores
3283:     *--------------------------------------------------------------------------
3284:     PROCEDURE Destroy()
3285:         TRY
3286:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3287:                 THIS.this_oBusinessObject = .NULL.
3288:             ENDIF
3289:             IF USED("cursor_4c_AcessoFinan")
3290:                 USE IN cursor_4c_AcessoFinan
3291:             ENDIF
3292:             IF USED("cursor_4c_Categorias")
3293:                 USE IN cursor_4c_Categorias
3294:             ENDIF
3295:         CATCH TO loc_oErro
3296:             MsgErro(loc_oErro.Message, "FormCargo.Destroy")
3297:         ENDTRY
3298: 
3299:         DODEFAULT()
3300:     ENDPROC
3301: 
3302: ENDDEFINE


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

