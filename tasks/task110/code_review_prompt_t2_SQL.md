# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPOS, CONTAS, MERCS, CGRUS, SGRUS, CPROS, IFORS, CODBARRAS, CBARS, GRUPOS, ESTOS, CODCORS, CODTAMS, OPERS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPOS, CONTAS, MERCS, CGRUS, SGRUS, CPROS, IFORS, CODBARRAS, CBARS, GRUPOS, ESTOS, CODCORS, CODTAMS, OPERS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
Delete File &lcArq.
Insert Into csCabecalho (Empresa, Titulo, SubTitulo, llImpConta) Values (lcNEmp, lcTits, lcSubs, Empty(lcCCon))
lcQuery = [Select a.EmpOs as Emps, a.Grupos, a.Contas, a.CPros, a.CBars, a.Qtds, a.Pesos, ] + ;
			[From SigOpEtq a ] + ;
		    [Left Join SigCdPro b On a.CPros = b.CPros ] + ;
		    [Left Join SigCdCli d on d.iClis = a.Contas ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [TmpEti]) < 1)
Update TmpEti ;
	Select crBranco
	Append Memo Branco From (lcBrc) Overwrite
	Select TmpEti
		oProg.Update(.t.)
		lcQuery = [Select Datas, Seqs ] + ;
					[From SigMvHst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [TmpHis]) < 1)
	Select TmpEti
		oProg.Update(.t.)
Select TmpEti
Delete File &lcArq.
		lnQueryOk = .poDataMgr.SqlExecute([Select cpros From SigOpEtq Where cbars = ]+lcCdBarra+[ ],'TmpEti')
		Select TmpEti
			lnQueryOk = .poDataMgr.SqlExecute([Select cpros From SigCdPro Where cbars = ]+lcCdBarra+[ ],'TmpPro')
			Select TmpPro
				lnQueryOk = .poDataMgr.SqlExecute([Select cpros,dpros From SigCdPro Where cbars = ]+lcCdBarra+[ ],'TmpPro')
				Select TmpPro
			lnQueryOk = .poDataMgr.SqlExecute([Select cpros,dpros From SigCdPro Where cpros = ']+lcCprosEti+[' ],'TmpPro')
			Select TmpPro

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrehbr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2786 linhas total):

*-- Linhas 14 a 32:
14: *   - Grupo de Produto   (cod+desc - SigCdGrp.CGrus/DGrus)
15: *   - Subgrupo de Prod.  (cod+desc - SigCdPsg.Codigos/Descricaos)
16: *   - Produto            (cod+desc - SigCdPro.cpros/dpros)
17: *   - Codigo de Barras   (SigOpEtq.cbars - busca via SQLEXEC)
18: *   - Cod. Reduzido      (Left(CodAmss, 3))
19: *   - Impressao          (Check3=Duracao, Check4=Imagem, Check1=Venda,
20: *                         Check2=Custo, Check5=Analitico)
21: *
22: * Acoes: Visualizar (preview) / Imprimir (com dialogo) / Documento / Encerrar
23: *==============================================================================
24: 
25: DEFINE CLASS Formsigrehbr AS FormBase
26: 
27:     *-- Dimensoes EXATAS do original (layout.json: Width=800, Height=650)
28:     Height      = 650
29:     Width       = 800
30:     DataSession = 2
31:     ShowWindow  = 1
32:     WindowType  = 1

*-- Linhas 1644 a 1662:
1644:         BINDEVENT(loc_oPg.txt_4c_DsCodigo, "KeyPress", THIS, "TeclaDsCodigo")
1645:         BINDEVENT(loc_oPg.txt_4c_DsCodigo, "DblClick", THIS, "AbrirBuscaDsCodigo")
1646: 
1647:         *-- BINDEVENTs - Codigo de Barras (validacao via SQLEXEC)
1648:         BINDEVENT(loc_oPg.txt_4c_CBars, "KeyPress", THIS, "TeclaCBars")
1649: 
1650:         *-- BINDEVENTs - Check5 exclui Check3 (Analitico exclui Duracao)
1651:         BINDEVENT(loc_oPg.chk_4c_Check5, "Click", THIS, "ChkCheck5Click")
1652: 
1653:         THIS.AtualizarEstadoControles()
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * TECLA* - Handlers de KeyPress (BINDEVENT requer metodos PUBLIC)
1658:     * F4=115, ENTER=13, TAB=9
1659:     *==========================================================================
1660: 
1661:     PROCEDURE TeclaDataInicial(par_nKeyCode, par_nShiftAltCtrl)
1662:         IF par_nKeyCode = 13

*-- Linhas 1901 a 1923:
1901:             THIS.AtualizarEstadoControles()
1902:             RETURN
1903:         ENDIF
1904:         loc_nResult = SQLEXEC(gnConnHandle, ;
1905:             "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1906:             EscaparSQL(loc_cValor), "cursor_4c_GrEstVal")
1907:         IF loc_nResult > 0
1908:             SELECT cursor_4c_GrEstVal
1909:             IF !EOF()
1910:                 loc_oPg.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_GrEstVal.descrs)
1911:             ELSE
1912:                 loc_oPg.txt_4c_DsGrEstoque.Value = ""
1913:                 THIS.AbrirBuscaCdGrEstoque()
1914:             ENDIF
1915:         ELSE
1916:             loc_oPg.txt_4c_DsGrEstoque.Value = ""
1917:         ENDIF
1918:         IF USED("cursor_4c_GrEstVal")
1919:             USE IN cursor_4c_GrEstVal
1920:         ENDIF
1921:         THIS.AtualizarEstadoControles()
1922:     ENDPROC
1923: 

*-- Linhas 2011 a 2033:
2011:             THIS.AtualizarEstadoControles()
2012:             RETURN
2013:         ENDIF
2014:         loc_nResult = SQLEXEC(gnConnHandle, ;
2015:             "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
2016:             EscaparSQL(loc_cValor), "cursor_4c_EstVal")
2017:         IF loc_nResult > 0
2018:             SELECT cursor_4c_EstVal
2019:             IF !EOF()
2020:                 loc_oPg.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_EstVal.rclis)
2021:             ELSE
2022:                 loc_oPg.txt_4c_DsEstoque.Value = ""
2023:                 THIS.AbrirBuscaCdEstoque()
2024:             ENDIF
2025:         ELSE
2026:             loc_oPg.txt_4c_DsEstoque.Value = ""
2027:         ENDIF
2028:         IF USED("cursor_4c_EstVal")
2029:             USE IN cursor_4c_EstVal
2030:         ENDIF
2031:         THIS.AtualizarEstadoControles()
2032:     ENDPROC
2033: 

*-- Linhas 2121 a 2143:
2121:             THIS.AtualizarEstadoControles()
2122:             RETURN
2123:         ENDIF
2124:         loc_nResult = SQLEXEC(gnConnHandle, ;
2125:             "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
2126:             EscaparSQL(loc_cValor), "cursor_4c_ForsVal")
2127:         IF loc_nResult > 0
2128:             SELECT cursor_4c_ForsVal
2129:             IF !EOF()
2130:                 loc_oPg.txt_4c_DFors.Value = ALLTRIM(cursor_4c_ForsVal.rclis)
2131:             ELSE
2132:                 loc_oPg.txt_4c_DFors.Value = ""
2133:                 THIS.AbrirBuscaIFors()
2134:             ENDIF
2135:         ELSE
2136:             loc_oPg.txt_4c_DFors.Value = ""
2137:         ENDIF
2138:         IF USED("cursor_4c_ForsVal")
2139:             USE IN cursor_4c_ForsVal
2140:         ENDIF
2141:         THIS.AtualizarEstadoControles()
2142:     ENDPROC
2143: 

*-- Linhas 2231 a 2253:
2231:             THIS.AtualizarEstadoControles()
2232:             RETURN
2233:         ENDIF
2234:         loc_nResult = SQLEXEC(gnConnHandle, ;
2235:             "SELECT cemps, razas FROM sigcdemp WHERE cemps = " + ;
2236:             EscaparSQL(loc_cValor), "cursor_4c_EmpVal")
2237:         IF loc_nResult > 0
2238:             SELECT cursor_4c_EmpVal
2239:             IF !EOF()
2240:                 loc_oPg.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.razas)
2241:             ELSE
2242:                 loc_oPg.txt_4c_DsEmpresa.Value = ""
2243:                 THIS.AbrirBuscaCdEmpresa()
2244:             ENDIF
2245:         ELSE
2246:             loc_oPg.txt_4c_DsEmpresa.Value = ""
2247:         ENDIF
2248:         IF USED("cursor_4c_EmpVal")
2249:             USE IN cursor_4c_EmpVal
2250:         ENDIF
2251:         THIS.AtualizarEstadoControles()
2252:     ENDPROC
2253: 

*-- Linhas 2341 a 2363:
2341:             THIS.AtualizarEstadoControles()
2342:             RETURN
2343:         ENDIF
2344:         loc_nResult = SQLEXEC(gnConnHandle, ;
2345:             "SELECT Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
2346:             EscaparSQL(loc_cValor), "cursor_4c_GGproVal")
2347:         IF loc_nResult > 0
2348:             SELECT cursor_4c_GGproVal
2349:             IF !EOF()
2350:                 loc_oPg.txt_4c_DGgps.Value = ALLTRIM(cursor_4c_GGproVal.Descs)
2351:             ELSE
2352:                 loc_oPg.txt_4c_DGgps.Value = ""
2353:                 THIS.AbrirBuscaCGgps()
2354:             ENDIF
2355:         ELSE
2356:             loc_oPg.txt_4c_DGgps.Value = ""
2357:         ENDIF
2358:         IF USED("cursor_4c_GGproVal")
2359:             USE IN cursor_4c_GGproVal
2360:         ENDIF
2361:         THIS.AtualizarEstadoControles()
2362:     ENDPROC
2363: 

*-- Linhas 2451 a 2473:
2451:             THIS.AtualizarEstadoControles()
2452:             RETURN
2453:         ENDIF
2454:         loc_nResult = SQLEXEC(gnConnHandle, ;
2455:             "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
2456:             EscaparSQL(loc_cValor), "cursor_4c_GProVal")
2457:         IF loc_nResult > 0
2458:             SELECT cursor_4c_GProVal
2459:             IF !EOF()
2460:                 loc_oPg.txt_4c_DsGPro.Value = ALLTRIM(cursor_4c_GProVal.DGrus)
2461:             ELSE
2462:                 loc_oPg.txt_4c_DsGPro.Value = ""
2463:                 THIS.AbrirBuscaCdGPro()
2464:             ENDIF
2465:         ELSE
2466:             loc_oPg.txt_4c_DsGPro.Value = ""
2467:         ENDIF
2468:         IF USED("cursor_4c_GProVal")
2469:             USE IN cursor_4c_GProVal
2470:         ENDIF
2471:         THIS.AtualizarEstadoControles()
2472:     ENDPROC
2473: 

*-- Linhas 2561 a 2583:
2561:             THIS.AtualizarEstadoControles()
2562:             RETURN
2563:         ENDIF
2564:         loc_nResult = SQLEXEC(gnConnHandle, ;
2565:             "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
2566:             EscaparSQL(loc_cValor), "cursor_4c_SgrupoVal")
2567:         IF loc_nResult > 0
2568:             SELECT cursor_4c_SgrupoVal
2569:             IF !EOF()
2570:                 loc_oPg.txt_4c_DsSgrupo.Value = ALLTRIM(cursor_4c_SgrupoVal.Descricaos)
2571:             ELSE
2572:                 loc_oPg.txt_4c_DsSgrupo.Value = ""
2573:                 THIS.AbrirBuscaCdSgrupo()
2574:             ENDIF
2575:         ELSE
2576:             loc_oPg.txt_4c_DsSgrupo.Value = ""
2577:         ENDIF
2578:         IF USED("cursor_4c_SgrupoVal")
2579:             USE IN cursor_4c_SgrupoVal
2580:         ENDIF
2581:         THIS.AtualizarEstadoControles()
2582:     ENDPROC
2583: 

*-- Linhas 2606 a 2624:
2606:         loc_cWhere = ""
2607:         IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5) AND ;
2608:            !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
2609:             loc_cWhere = "cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
2610:         ENDIF
2611:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2612:             "SigCdPro", "cursor_4c_BuscaCodigo", "cpros", loc_cValor, ;
2613:             "Sele" + CHR(231) + CHR(227) + "o de Produto", .F., .T., loc_cWhere)
2614:         IF VARTYPE(loc_oBusca) = "O"
2615:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2616:                 IF USED("cursor_4c_BuscaCodigo")
2617:                     loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
2618:                     loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
2619:                 ENDIF
2620:             ELSE
2621:                 IF !loc_oBusca.this_lAchouRegistro
2622:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
2623:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2624:                     loc_oBusca.Show()

*-- Linhas 2643 a 2661:
2643:         loc_cWhere = ""
2644:         IF PEMSTATUS(loc_oPg, "txt_4c_CdGPro", 5) AND ;
2645:            !EMPTY(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
2646:             loc_cWhere = "cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CdGPro.Value))
2647:         ENDIF
2648:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2649:             "SigCdPro", "cursor_4c_BuscaCodigo", "dpros", loc_cValor, ;
2650:             "Sele" + CHR(231) + CHR(227) + "o de Produto", .F., .T., loc_cWhere)
2651:         IF VARTYPE(loc_oBusca) = "O"
2652:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
2653:                 IF USED("cursor_4c_BuscaCodigo")
2654:                     loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.dpros)
2655:                     loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.cpros)
2656:                 ENDIF
2657:             ELSE
2658:                 IF !loc_oBusca.this_lAchouRegistro
2659:                     loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
2660:                     loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
2661:                     loc_oBusca.Show()

*-- Linhas 2682 a 2704:
2682:             THIS.AtualizarEstadoControles()
2683:             RETURN
2684:         ENDIF
2685:         loc_nResult = SQLEXEC(gnConnHandle, ;
2686:             "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + ;
2687:             EscaparSQL(loc_cValor), "cursor_4c_CodigoVal")
2688:         IF loc_nResult > 0
2689:             SELECT cursor_4c_CodigoVal
2690:             IF !EOF()
2691:                 loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(cursor_4c_CodigoVal.dpros)
2692:             ELSE
2693:                 loc_oPg.txt_4c_DsCodigo.Value = ""
2694:                 THIS.AbrirBuscaCdCodigo()
2695:             ENDIF
2696:         ELSE
2697:             loc_oPg.txt_4c_DsCodigo.Value = ""
2698:         ENDIF
2699:         IF USED("cursor_4c_CodigoVal")
2700:             USE IN cursor_4c_CodigoVal
2701:         ENDIF
2702:         THIS.AtualizarEstadoControles()
2703:     ENDPROC
2704: 

*-- Linhas 2716 a 2752:
2716: 
2717:     *==========================================================================
2718:     * VALIDARCBARS - Codigo de Barras: busca produto em SigOpEtq
2719:     * Equivalente ao getCBars.Valid do legado (SQLEXEC direto)
2720:     *==========================================================================
2721: 
2722:     PROCEDURE ValidarCBars()
2723:         LOCAL loc_cValor, loc_nResult, loc_oPg
2724:         loc_oPg    = THIS.pgf_4c_Paginas.Page1
2725:         loc_cValor = ALLTRIM(loc_oPg.txt_4c_CBars.Value)
2726:         IF EMPTY(loc_cValor)
2727:             loc_oPg.txt_4c_CdCodigo.Value = ""
2728:             loc_oPg.txt_4c_DsCodigo.Value = ""
2729:             THIS.AtualizarEstadoControles()
2730:             RETURN
2731:         ENDIF
2732:         loc_nResult = SQLEXEC(gnConnHandle, ;
2733:             "SELECT DISTINCT a.cpros, b.dpros " + ;
2734:             "FROM SigOpEtq a LEFT JOIN SigCdPro b ON a.cpros = b.cpros " + ;
2735:             "WHERE a.cbars = " + EscaparSQL(loc_cValor), "cursor_4c_BarsVal")
2736:         IF loc_nResult > 0
2737:             SELECT cursor_4c_BarsVal
2738:             IF !EOF()
2739:                 loc_oPg.txt_4c_CdCodigo.Value = ALLTRIM(cursor_4c_BarsVal.cpros)
2740:                 loc_oPg.txt_4c_DsCodigo.Value = ALLTRIM(NVL(cursor_4c_BarsVal.dpros, ""))
2741:             ELSE
2742:                 MsgAviso("C" + CHR(243) + "digo de barras n" + CHR(227) + ;
2743:                     "o encontrado.", "Aten" + CHR(231) + CHR(227) + "o")
2744:                 loc_oPg.txt_4c_CBars.Value = ""
2745:             ENDIF
2746:         ELSE
2747:             MsgAviso("Falha ao consultar c" + CHR(243) + "digo de barras.", ;
2748:                 "Aten" + CHR(231) + CHR(227) + "o")
2749:         ENDIF
2750:         IF USED("cursor_4c_BarsVal")
2751:             USE IN cursor_4c_BarsVal
2752:         ENDIF


### BO (C:\4c\projeto\app\classes\sigrehbrBO.prg):
*==============================================================================
* SIGREHBRBO.PRG
* Business Object para Relatorio de Codigos de Barras Por Estoque
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrehbrBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = ""
    this_cCampoChave    = ""

    *-- Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Conta de Estoque (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Fornecedor (getIFors / getDFors)
    this_cIFors         = ""
    this_cDFors         = ""

    *-- Grande Grupo (getCGgps / getDGgps)
    this_cCGgps         = ""
    this_cDGgps         = ""

    *-- Grupo de Produto (Get_Cd_GPro / Get_Ds_GPro)
    this_cCdGPro        = ""
    this_cDsGPro        = ""

    *-- Subgrupo de Produto (get_cd_sgrupo / get_ds_sgrupo)
    this_cCdSgrupo      = ""
    this_cDsSgrupo      = ""

    *-- Produto (get_cd_codigo / get_ds_codigo)
    this_cCdCodigo      = ""
    this_cDsCodigo      = ""

    *-- Codigo de Barras (getCBars)
    this_cCBars         = ""

    *-- Codigo Reduzido (getReduzs)
    this_cReduzs        = ""

    *-- Opcoes de impressao (checkboxes)
    this_nCheck1        = 0    && Venda
    this_nCheck2        = 0    && Custo
    this_nCheck3        = 0    && Duracao (seleciona SigReHb3)
    this_nCheck4        = 0    && Imagem
    this_nCheck5        = 0    && Analitico (seleciona SigReHb2)

    *-- Cursores e caminhos FRX
    this_cCursorDados       = "TmpEti"
    this_cCursorCabecalho   = "csCabecalho"
    this_cFrxBase1          = ""
    this_cFrxBase2          = ""
    this_cFrxBase3          = ""

    *-- Nome da empresa para cabecalho do relatorio
    this_cNomeEmpresa       = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando caminhos dos relatorios FRX
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        THIS.this_cFrxBase1   = gc_4c_CaminhoReports + "SigReHb1.frx"
        THIS.this_cFrxBase2   = gc_4c_CaminhoReports + "SigReHb2.frx"
        THIS.this_cFrxBase3   = gc_4c_CaminhoReports + "SigReHb3.frx"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e prepara TmpEti para relatorio
    * Equivalente ao metodo "processamento" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cWhere, loc_cSQL, loc_nResult
        LOCAL loc_cGrupo, loc_cSgrupo, loc_cTVen, loc_cTCus, loc_llIImg
        LOCAL loc_cNEmp, loc_cTits, loc_cSubs

        loc_lSucesso = .F.
        TRY
            loc_cTVen  = IIF(THIS.this_nCheck1 = 1, "S", "N")
            loc_cTCus  = IIF(THIS.this_nCheck2 = 1, "S", "N")
            loc_llIImg = (THIS.this_nCheck4 = 1)

            *-- Obtem nome da empresa para o cabecalho
            loc_cNEmp = THIS.BuscarNomeEmpresa()

            *-- Titulo: "Posicao de Codigo de Barras [(codigo reduzido)]"
            loc_cTits = "Posi" + CHR(231) + CHR(227) + "o de C" + CHR(243) + "digo de Barras"
            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cTits = loc_cTits + " (" + ALLTRIM(THIS.this_cReduzs) + ")"
            ENDIF

            *-- Subtitulo: periodo e filtros aplicados
            loc_cSubs = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                        " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdGrEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsGrEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdEstoque) + ;
                            " - " + ALLTRIM(THIS.this_cDsEstoque)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cCdCodigo) + ;
                            " - " + ALLTRIM(THIS.this_cDsCodigo)
            ENDIF
            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cSubs = loc_cSubs + CHR(13) + ALLTRIM(THIS.this_cIFors) + ;
                            " - " + ALLTRIM(THIS.this_cDFors)
            ENDIF

            *-- Cria cursor de cabecalho para uso no FRX
            IF USED("csCabecalho")
                USE IN csCabecalho
            ENDIF
            CREATE CURSOR csCabecalho (Empresa C(80), Titulo C(80), SubTitulo C(80), llImpConta L)
            INSERT INTO csCabecalho (Empresa, Titulo, SubTitulo, llImpConta) ;
                VALUES (loc_cNEmp, loc_cTits, loc_cSubs, EMPTY(ALLTRIM(THIS.this_cCdEstoque)))

            *-- Monta clausula WHERE baseada nos filtros
            IF EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cWhere = "1=1"
            ELSE
                loc_cGrupo = PADR(THIS.this_cCdGrEstoque, 10)
                loc_cWhere = "a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF

            IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDtFinal) + ")"
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cWhere = loc_cWhere + " AND a.EmpOs = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cWhere = loc_cWhere + " AND a.Contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCGgps))
                loc_cWhere = loc_cWhere + " AND b.Mercs = " + EscaparSQL(ALLTRIM(THIS.this_cCGgps))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdGPro))
                loc_cWhere = loc_cWhere + " AND b.CGrus = " + EscaparSQL(ALLTRIM(THIS.this_cCdGPro))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdSgrupo))
                loc_cSgrupo = PADR(THIS.this_cCdSgrupo, 6)
                loc_cWhere = loc_cWhere + " AND b.SGrus = " + EscaparSQL(loc_cSgrupo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cCdCodigo))
                loc_cWhere = loc_cWhere + " AND a.CPros = " + EscaparSQL(ALLTRIM(THIS.this_cCdCodigo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cReduzs))
                loc_cWhere = loc_cWhere + " AND Left(a.CodAmss, 3) = " + EscaparSQL(ALLTRIM(THIS.this_cReduzs))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cIFors))
                loc_cWhere = loc_cWhere + " AND b.IFors = " + EscaparSQL(ALLTRIM(THIS.this_cIFors))
            ENDIF

            *-- Monta query principal (quebrada em multiplas linhas para evitar limite VFP9)
            loc_cSQL = "Select a.EmpOs as Emps, a.Grupos, a.Contas, a.CPros, a.CBars, a.Qtds, a.Pesos, "
            loc_cSQL = loc_cSQL + "b.DPros, a.CodCors, a.CodTams, b.CUnis, b.CUniPs, b.PCuss, b.PVens, "
            loc_cSQL = loc_cSQL + "' ' as CVens, ' ' as CCuss, b.FigJpgs, a.Datas, a.CBars as NDias, 0 as Imps, "
            loc_cSQL = loc_cSQL + "d.rClis, Cast(b.dpro3s as char(200)) as dpro3s, b.Reffs, Left(a.CodAmss, 3) as Reds "
            loc_cSQL = loc_cSQL + "From SigOpEtq a "
            loc_cSQL = loc_cSQL + "Left Join SigCdPro b On a.CPros = b.CPros "
            loc_cSQL = loc_cSQL + "Left Join SigCdCli d on d.iClis = a.Contas "
            loc_cSQL = loc_cSQL + "Where " + loc_cWhere + " "
            loc_cSQL = loc_cSQL + "Order By a.EmpOs, a.Grupos, a.Contas, a.CPros, a.CBars"

            IF USED("TmpEti")
                USE IN TmpEti
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")
            IF loc_nResult > 0
                SELECT TmpEti
                GO TOP IN TmpEti

                *-- Zera Datas/NDias e define flags de impressao de venda/custo
                UPDATE TmpEti ;
                    SET Datas = {}, ;
                        NDias = 0, ;
                        CVens = loc_cTVen, ;
                        CCuss = loc_cTCus

                *-- Processa historicos (modo Duracao) ou apenas imagens
                IF THIS.this_nCheck3 = 1
                    loc_lSucesso = THIS.ProcessarHistoricosDuracao(loc_llIImg)
                ELSE
                    IF loc_llIImg
                    loc_lSucesso = THIS.ProcessarImagensSimples()
                ELSE
                    loc_lSucesso = .T.
                    ENDIF
                ENDIF

                SELECT TmpEti
                GO TOP IN TmpEti
            ELSE
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar dados de etiquetas."
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNomeEmpresa - Retorna nome da empresa para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarNomeEmpresa()
        RETURN ALLTRIM(go_4c_Sistema.cEmpresa)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarHistoricosDuracao - Para cada item em TmpEti busca o ultimo
    * historico de entrada em SigMvHst e calcula dias de permanencia no estoque
    * Equivalente ao bloco SCAN do modo Duracao (Check3=1) no original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarHistoricosDuracao(par_llIImg)
        LOCAL loc_lSucesso, loc_cKey, loc_cBar, loc_cSQL, loc_nResult
        LOCAL loc_cArq, loc_lHasImg, loc_dDataHis, loc_nDias, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)

        IF par_llIImg
            THIS.PrepararCursorBranco()
        ENDIF

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            loc_cBar = ALLTRIM(STR(TmpEti.CBars, 14))

            *-- Marca primeiro registro de cada combinacao produto/conta para imagem
            IF par_llIImg AND (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            *-- Busca ultimo historico de entrada para esta combinacao de barcode+grupo+estoque+cor+tamanho
            loc_cSQL = "Select Datas, Seqs "
            loc_cSQL = loc_cSQL + "From SigMvHst "
            loc_cSQL = loc_cSQL + "Where CodBarras = " + loc_cBar
            loc_cSQL = loc_cSQL + " And Grupos = " + EscaparSQL(ALLTRIM(TmpEti.Grupos))
            loc_cSQL = loc_cSQL + " And Estos = " + EscaparSQL(ALLTRIM(TmpEti.Contas))
            loc_cSQL = loc_cSQL + " And CodCors = " + EscaparSQL(ALLTRIM(TmpEti.CodCors))
            loc_cSQL = loc_cSQL + " And CodTams = " + EscaparSQL(ALLTRIM(TmpEti.CodTams))
            loc_cSQL = loc_cSQL + " And Opers = 'E' "
            loc_cSQL = loc_cSQL + "Order By Seqs Desc"

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
            IF loc_nResult < 1
                MsgErro("Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico.", "Erro")
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao buscar hist" + CHR(243) + "rico."
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_lSucesso = .F.
                EXIT
            ENDIF

            SELECT TmpHis
            GO TOP IN TmpHis

            IF !EOF() AND !EMPTY(TmpHis.Datas)
                loc_dDataHis = TTOD(TmpHis.Datas)
                loc_nDias    = DATE() - loc_dDataHis
                REPLACE Datas WITH TTOD(TmpHis.Datas), ;
                        NDias WITH loc_nDias ;
                        IN TmpEti
            ENDIF

            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF

            IF par_llIImg
                loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                           PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
                CLEAR RESOURCES
                loc_lHasImg = .F.
                IF !ISNULL(TmpEti.FigJpgs)
                    IF !EMPTY(TmpEti.FigJpgs)
                        IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                            loc_lHasImg = .T.
                        ENDIF
                    ENDIF
                ENDIF
                IF loc_lHasImg
                    loc_cFoto = STRCONV( ;
                        STRTRAN( ;
                            STRTRAN( ;
                                STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                                "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                    STRTOFILE(loc_cFoto, loc_cArq)
                ELSE
                    THIS.CopiarImagemBranca(loc_cArq)
                ENDIF
            ENDIF

            SELECT TmpEti
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarImagensSimples - Processa imagens sem busca de historico
    * Usado quando Check4=1 e Check3=0 (imagens sem modo Duracao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarImagensSimples()
        LOCAL loc_lSucesso, loc_cKey, loc_cArq, loc_lHasImg, loc_cFoto

        loc_lSucesso = .T.
        loc_cKey = SPACE(33)
        THIS.PrepararCursorBranco()

        SELECT TmpEti
        GO TOP IN TmpEti

        SCAN
            IF (loc_cKey <> TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros)
                loc_cKey = TmpEti.Emps + TmpEti.Grupos + TmpEti.Contas + TmpEti.CPros
                REPLACE Imps WITH 1 IN TmpEti
            ENDIF

            loc_cArq = SYS(2023) + "\SigReHb3_" + ;
                       PADL(ALLTRIM(STR(TmpEti.CBars, 14)), 14, "0") + ".jpg"
            CLEAR RESOURCES
            loc_lHasImg = .F.
            IF !ISNULL(TmpEti.FigJpgs)
                IF !EMPTY(TmpEti.FigJpgs)
                    IF LEN(ALLTRIM(TmpEti.FigJpgs)) > 10
                        loc_lHasImg = .T.
                    ENDIF
                ENDIF
            ENDIF
            IF loc_lHasImg
                loc_cFoto = STRCONV( ;
                    STRTRAN( ;
                        STRTRAN( ;
                            STRTRAN(TmpEti.FigJpgs, "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArq)
            ELSE
                THIS.CopiarImagemBranca(loc_cArq)
            ENDIF
        ENDSCAN

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursorBranco - Cria cursor memo com imagem branca para substituir
    * produtos sem foto no relatorio com imagens (Check4=1)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararCursorBranco()
        LOCAL loc_cBrc
        loc_cBrc = gc_4c_CaminhoBase + "BrJpg.JPG"
        IF !FILE(loc_cBrc)
            loc_cBrc = gc_4c_CaminhoReports + "BrJpg.JPG"
        ENDIF
        IF !FILE(loc_cBrc)
            RETURN
        ENDIF
        IF USED("crBranco")
            USE IN crBranco
        ENDIF
        CREATE CURSOR crBranco (Branco M)
        SELECT crBranco
        APPEND BLANK IN crBranco
        APPEND MEMO Branco FROM (loc_cBrc) OVERWRITE
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarImagemBranca - Copia imagem branca para o arquivo destino
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CopiarImagemBranca(par_cArquivo)
        IF USED("crBranco")
            COPY MEMO crBranco.Branco TO (par_cArquivo)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparArquivosImagem - Remove arquivos temporarios de imagem apos impressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparArquivosImagem()
        LOCAL loc_cArq
        loc_cArq = SYS(2023) + "\SigReHb3_*.jpg"
        DELETE FILE &loc_cArq.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em modo preview na tela
    * Equivalente ao metodo "visualizacao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) PREVIEW NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) PREVIEW NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora com dialogo de selecao
    * Equivalente ao metodo "impressao" do original SIGREHBR
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER PROMPT NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Envia relatorio para impressora sem dialogo de selecao
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nCheck3 = 1
                    REPORT FORM (THIS.this_cFrxBase3) TO PRINTER NOCONSOLE
                ELSE
                    IF THIS.this_nCheck5 = 1
                    REPORT FORM (THIS.this_cFrxBase2) TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cFrxBase1) TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                THIS.LimparArquivosImagem()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

ENDDEFINE

