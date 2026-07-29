# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'P' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, EMIS, NFIS, ITRAS, DOPES, NUMES, ICLIS, CPROS, FPAGS, CORRECS, CODS, VALUE, OPERAS, CANCELAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, EMIS, NFIS, ITRAS, DOPES, NUMES, ICLIS, CPROS, FPAGS, CORRECS, CODS, VALUE, OPERAS, CANCELAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, SERIES, EMIS, NFIS, ITRAS, DOPES, NUMES, ICLIS, CPROS, FPAGS, CORRECS, CODS, VALUE, OPERAS, CANCELAS

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
  ControlSource = "crSigMvNfi.dopes"
  ControlSource = "crSigMvNfi.numes"
  ControlSource = "crSigMvNfi.NFis"
  ControlSource = "crSigMvNfi.CFis"
  ControlSource = "crSigMvNfi.DtSaidas"
  ControlSource = "crSigMvNfi.descricaos"
  ControlSource = "crSigMvNfi.Series"
  ControlSource = "crSigMvNfi.EspecieNFs"
  ControlSource = "crSigMvNfi.Emis"
  ControlSource = "crSigMvNfi.BasecIpis"
  ControlSource = "crSigMvNfi.ValIpis"
  ControlSource = "crSigMvNfi.BasecIcms"
  ControlSource = "crSigMvNfi.ValIcms"
  ControlSource = "crSigMvNfi.TotProds"
  ControlSource = "crSigMvNfi.TotNotas"
  ControlSource = "crSigMvNfi.VlFretes"
  ControlSource = "crSigMvNfi.VlSeguros"
  ControlSource = "crSigMvNfi.DespAces"
  ControlSource = "crSigMvNfi.Qtdes"
  ControlSource = "crSigMvNfi.Espes"
  ControlSource = "crSigMvNfi.Marcas"
  ControlSource = "crSigMvNfi.Numeros"
  ControlSource = "crSigMvNfi.PLiqs"
  ControlSource = "crSigMvNfi.PBrus"
  ControlSource = "SigPrTrp.estas"
  ControlSource = "crSigMvNfi.Placas"
  ControlSource = "SigPrTrp.cidas"
  ControlSource = "crSigMvNfi.CodTrans"
  ControlSource = "SigPrTrp.razaos"
  ControlSource = "SigPrTrp.endes"
  ControlSource = "crSigMvNfi.Fretes"
  ControlSource = "crSigMvNfi.UfPlacas"
  ControlSource = "crSigMvNfi.icms"
  ControlSource = "crSigMvNfi.descsers"
  ControlSource = "crSigMvNfi.vtotsers"
  ControlSource = "crSigMvNfi.perciss"
  ControlSource = "crSigMvNfi.vtotiss"
Select CrSigMvNfi
If ThisForm.poDataMgr.SqlExecute([Select * From SigCnFNF Where emps = ?_Empr ],'CrSigCnFNF') < 1
Select CrSigCnFNF
lcLeftCfg = Iif(llCfg,[Left Join SigCnFNF g On g.emps+g.series = n.emps+n.series ],[Left Join SigCnFNF g On g.series = n.series ])
lcQryNFis = [Select n.basecicms,n.datatrans,n.descsers,n.despaces,n.dopes,n.emis,n.emps,n.espes,n.fretes,n.icms,]+;
			[From SigMvNfi n ] + lcLeftCfg +;
			[Left Join SigCdCfo f On f.codigos = n.cfis ]+;
			[Left Join SigCdCli c On c.iclis = n.clifors ]+;
lcQryTra   = [Select * From SigPrTrp Where itras = ?pItras ]
lcQryOpe   = [Select ndopes,dopes,digobs,digdoc,dtemis,dtentrs,casas,altdescs,origems,destinos,imagems,confes,valpres,cmoes ]+;
			   [From SigCdOpe Where dopes = ?pDopes Order By dopes ]
lcQryEest  = [Select * From SigMvCab Where emps = ?pNEmps And dopes = ?pDopes And numes = ?pNumes ]
lcQryEesti = [Select * From SigMvItn Where emps = ?pNEmps And dopes = ?pDopes And numes = ?pNumes ]
lcQryPar   = [Select * From SigMvPar Where emps = ?pNEmps And dopes = ?pDopes And numes = ?pNumes ]
lcQryCli   = [Select * From SigCdCli Where iclis = ?pIclis ]
lcQryPro   = [Select * From SigCdPro Where cpros = ?pCpros ]
lcQryFPag  = [Select * From SigOpFp Where fpags = ?pFPags ]
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdPam ],'CrSigCdPam') < 1
Select CrSigCdPam
If ThisForm.poDataMgr.SqlExecute([Select * From SigCnFNF Where emps = ?_Empr ],'CrSigCnFNF') < 1
Select CrSigCnFNF
	.Column1.ControlSource = 'CrSigMvNfi.nfis'
	.Column2.ControlSource = 'CrSigMvNfi.emis'
	.Column3.ControlSource = 'CrSigMvNfi.totnotas'
	.Column4.ControlSource = 'CrSigMvNfi.rclis'
Select CrSigCdSer
	Select CrSigPrTrp
	Select CrSigCdOpe
	Select CrSigMvCab
	Select CrSigMvItn
	Select CrSigMvPar
	Select CrSigMvItn
	Select CrSigMvNfi
	Select CrSigMvNfi
	Select CrSigMvNfi
		Select CrSigMvNfi
		Select CrSigMvNfi
	Select CrSigMvNfi
		Select CrSigMvNfi
	Select CrSigMvNfi
	Select Distinct a.Cods, a.Descs ;
	  From crSigCdSer a ;
	Select CrSerie
lcSql = [Select Dopes From SigCdOpe Where Dopes = ']+CrSigMvNfi.Dopes+[']
If thisform.Podatamgr.SqlExecute(lcsql,'TmpOpe') > 0 And Reccount('TmpOpe') > 0

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg) - TRECHOS RELEVANTES PARA PASS SQL (2778 linhas total):

*-- Linhas 67 a 85:
67:                     USE IN cursor_4c_Dados
68:                 ENDIF
69:                 SET NULL ON
70:                 CREATE CURSOR cursor_4c_Dados ( ;
71:                     cidchaves   C(20), ;
72:                     empdopnums  C(29), ;
73:                     emps        C(3),  ;
74:                     dopes       C(20), ;
75:                     numes       N(6,0), ;
76:                     nfis        C(6),  ;
77:                     series      C(8),  ;
78:                     especienfs  C(6),  ;
79:                     emis        T,     ;
80:                     dtsaidas    T,     ;
81:                     datans      T,     ;
82:                     operas      C(1),  ;
83:                     correcs     I,     ;
84:                     cancelas    I,     ;
85:                     regs        I,     ;

*-- Linhas 365 a 416:
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column1
368:             .ControlSource = "cursor_4c_Dados.nfis"
369:             .Width         = 70
370:             .Alignment     = 2
371:         ENDWITH
372:         loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
373: 
374:         WITH loc_oGrid.Column2
375:             .ControlSource = "cursor_4c_Dados.emis"
376:             .Width         = 95
377:             .Alignment     = 2
378:         ENDWITH
379:         loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
380: 
381:         WITH loc_oGrid.Column3
382:             .ControlSource = "cursor_4c_Dados.totnotas"
383:             .Width         = 120
384:             .Alignment     = 2
385:         ENDWITH
386:         loc_oGrid.Column3.Header1.Caption = "Total NF"
387: 
388:         WITH loc_oGrid.Column4
389:             .ControlSource = "cursor_4c_Dados.rclis"
390:             .Width         = 715
391:             .Alignment     = 2
392:         ENDWITH
393:         loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"
394: 
395:         loc_oGrid.ColumnCount = 3
396:         loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 
398:         *-- Redefinir ControlSource apos RecordSource (VFP faz auto-bind pela ordem dos campos)
399:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.nfis"
400:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emis"
401:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.totnotas"
402:         loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
403:         loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
404:         loc_oGrid.Column3.Header1.Caption = "Total NF"
405: 
406:         *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)
407:         loc_oGrid.SetAll("DynamicForeColor", ;
408:             "IIF(cursor_4c_Dados.correcs > 0, RGB(255,0,0), RGB(0,0,0))", "Column")
409: 
410:         THIS.FormatarGridLista(loc_oGrid)
411: 
412:         THIS.TornarControlesVisiveis(loc_oPagina)
413:     ENDPROC
414: 
415:     *==========================================================================
416:     * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos

*-- Linhas 845 a 865:
845:                     IF THIS.this_oBusinessObject.Buscar("")
846:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
847:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
848:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.nfis"
849:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.emis"
850:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.totnotas"
851:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
852:                         loc_lResultado = .T.
853:                     ELSE
854:                         loc_lResultado = .F.
855:                     ENDIF
856:                 ELSE
857:                     *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
858:                     loc_lResultado = .T.
859:                 ENDIF
860:             ENDIF
861: 
862:         CATCH TO loc_oErro
863:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
864:             loc_lResultado = .F.
865:         ENDTRY

*-- Linhas 907 a 925:
907: 
908:         TRY
909:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
910:                 SELECT cursor_4c_Dados
911:                 loc_lTemCarta = (NVL(cursor_4c_Dados.correcs, 0) > 0)
912:             ENDIF
913: 
914:             WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
915:                 .cmd_4c_AlteraCarta.Enabled = loc_lTemCarta
916:                 .cmd_4c_ImpCarta.Enabled    = loc_lTemCarta
917:                 .Visible     = .T.
918:             ENDWITH
919: 
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "Erro ao atualizar bot" + CHR(245) + "es")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *==========================================================================

*-- Linhas 944 a 962:
944:                 RETURN
945:             ENDIF
946: 
947:             SELECT cursor_4c_Dados
948: 
949:             IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
950:                 THIS.this_oBusinessObject.NovoRegistro()
951:                 THIS.this_cModoAtual = "INCLUIR"
952:                 THIS.BOParaForm()
953:                 THIS.HabilitarCampos(.T.)
954:                 THIS.AlternarPagina(2)
955:                 loc_lResultado = .T.
956:             ELSE
957:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
958:                     "Erro ao carregar NF")
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             MsgErro(loc_oErro.Message, "Erro ao inserir carta")

*-- Linhas 980 a 998:
980:                 RETURN
981:             ENDIF
982: 
983:             SELECT cursor_4c_Dados
984: 
985:             IF NVL(cursor_4c_Dados.correcs, 0) = 0
986:                 MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
987:                     CHR(231) + CHR(227) + "o para alterar.", "Aviso")
988:                 RETURN
989:             ENDIF
990: 
991:             IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
992:                 THIS.this_oBusinessObject.EditarRegistro()
993:                 THIS.this_cModoAtual = "ALTERAR"
994:                 THIS.BOParaForm()
995:                 THIS.HabilitarCampos(.T.)
996:                 THIS.AlternarPagina(2)
997:                 loc_lResultado = .T.
998:             ELSE

*-- Linhas 1023 a 1041:
1023:             RETURN .F.
1024:         ENDIF
1025: 
1026:         SELECT cursor_4c_Dados
1027: 
1028:         IF NVL(cursor_4c_Dados.correcs, 0) = 0
1029:             MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
1030:                 CHR(231) + CHR(227) + "o para imprimir.", "Aviso")
1031:             RETURN .F.
1032:         ENDIF
1033: 
1034:         TRY
1035:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1036:             loc_cEdns      = ALLTRIM(cursor_4c_Dados.empdopnums)
1037:             loc_cSerie     = ALLTRIM(THIS.this_cSeriesFiltro)
1038:             loc_dEmisDe    = THIS.this_dEmisDeFiltro
1039:             loc_dEmisAte   = THIS.this_dEmisAteFiltro
1040: 
1041:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)

*-- Linhas 1354 a 1372:
1354:             .HighlightBackColor = RGB(255, 255, 255)
1355:             .HighlightForeColor = RGB(15, 41, 104)
1356:             .HighlightStyle    = 2
1357:             .DeleteMark        = .F.
1358:             .RecordMark        = .F.
1359:             .RowHeight         = 16
1360:             .ScrollBars        = 2
1361:             .GridLines         = 3
1362:         ENDWITH
1363:     ENDPROC
1364: 
1365:     *==========================================================================
1366:     * ConfigurarFiltros - Popula cnt_4c_Filtros com controles de filtro
1367:     * Legado: GetEmp / Get_Serie / DtIni / DtFim / optFiltro
1368:     *==========================================================================
1369:     PROTECTED PROCEDURE ConfigurarFiltros(par_oPagina)
1370:         LOCAL loc_oCnt
1371:         loc_oCnt = par_oPagina.cnt_4c_Filtros
1372: 

*-- Linhas 1550 a 1570:
1550:         ENDIF
1551: 
1552:         TRY
1553:             loc_cSQL    = "SELECT CEmps, Razas FROM SigCdEmp WHERE CEmps = " + ;
1554:                 EscaparSQL(loc_cEmps)
1555:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
1556: 
1557:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaEmp") > 0
1558:                 THIS.this_cEmps = loc_cEmps
1559:             ELSE
1560:                 MsgAviso("Empresa n" + CHR(227) + "o encontrada: " + loc_cEmps, ;
1561:                     "Empresa")
1562:                 loc_oCnt.txt_4c_Emp.Value = THIS.this_cEmps
1563:             ENDIF
1564: 
1565:             IF USED("cursor_4c_BuscaEmp")
1566:                 USE IN cursor_4c_BuscaEmp
1567:             ENDIF
1568: 
1569:         CATCH TO loc_oErro
1570:             MsgErro(loc_oErro.Message, "Erro ao validar empresa")

*-- Linhas 1587 a 1609:
1587:         ENDIF
1588: 
1589:         TRY
1590:             loc_cSQL    = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
1591:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
1592: 
1593:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_BuscaSer") > 0
1594:                 SELECT cursor_4c_BuscaSer
1595:                 GO TOP
1596:                 LOCATE FOR UPPER(ALLTRIM(cursor_4c_BuscaSer.Cods)) == UPPER(loc_cSerie)
1597: 
1598:                 IF FOUND()
1599:                     THIS.this_cSeriesFiltro            = ALLTRIM(cursor_4c_BuscaSer.Cods)
1600:                     loc_oCnt.txt_4c_Serie.Value        = THIS.this_cSeriesFiltro
1601:                     loc_lEncontrou                     = .T.
1602:                 ELSE
1603:                     *-- Nao encontrou exato: abrir picker
1604:                     LOCAL loc_oBusca
1605:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1606:                     IF VARTYPE(loc_oBusca) = "O"
1607:                         loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
1608:                         loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
1609:                         loc_oBusca.this_cCampoChave    = "Cods"

*-- Linhas 1615 a 1633:
1615:                         loc_oBusca.Show()
1616: 
1617:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
1618:                             SELECT cursor_4c_BuscaSer
1619:                             THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
1620:                             loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
1621:                             loc_lEncontrou              = .T.
1622:                         ELSE
1623:                             loc_oCnt.txt_4c_Serie.Value = ""
1624:                             THIS.this_cSeriesFiltro     = ""
1625:                         ENDIF
1626:                         loc_oBusca.Release()
1627:                     ENDIF
1628:                 ENDIF
1629:             ENDIF
1630: 
1631:             IF USED("cursor_4c_BuscaSer")
1632:                 USE IN cursor_4c_BuscaSer
1633:             ENDIF

*-- Linhas 2570 a 2605:
2570: 
2571:     *==========================================================================
2572:     * BtnDadosClick - Abre SigMvExp com detalhes das movimentacoes da NF
2573:     * Legado: Dados.Click -> SELECT Dopes FROM SigCdOpe -> DO FORM SigMvExp WITH ...
2574:     *==========================================================================
2575:     PROCEDURE BtnDadosClick()
2576:         LOCAL loc_lResultado, loc_cDopes, loc_nNumes, loc_cEmps, loc_nResult, loc_cSQL
2577:         loc_lResultado = .F.
2578: 
2579:         TRY
2580:             THIS.Enabled = .F.
2581: 
2582:             loc_cDopes = ALLTRIM(THIS.this_oBusinessObject.this_cDopes)
2583:             loc_nNumes = THIS.this_oBusinessObject.this_nNumes
2584:             loc_cEmps  = THIS.this_cEmps
2585: 
2586:             IF EMPTY(loc_cDopes)
2587:                 MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o definida.", "Dados")
2588:             ELSE
2589:                 loc_cSQL    = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes)
2590:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2591: 
2592:                 IF loc_nResult > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2593:                     DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
2594:                     loc_lResultado = .T.
2595:                 ELSE
2596:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "Dados")
2597:                 ENDIF
2598: 
2599:                 IF USED("cursor_4c_TmpOpe")
2600:                     USE IN cursor_4c_TmpOpe
2601:                 ENDIF
2602:             ENDIF
2603: 
2604:         CATCH TO loc_oErro
2605:             MsgErro(loc_oErro.Message, "Erro ao abrir dados da NF")

*-- Linhas 2639 a 2657:
2639:                EOF("cursor_4c_Dados")
2640:                 MsgAviso("Selecione uma Nota Fiscal na lista.", "Visualizar")
2641:             ELSE
2642:                 SELECT cursor_4c_Dados
2643: 
2644:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(ALLTRIM(cursor_4c_Dados.cidchaves))
2645:                     THIS.this_cModoAtual = "VISUALIZAR"
2646:                     THIS.BOParaForm()
2647:                     THIS.HabilitarCampos(.F.)
2648:                     *-- Desabilitar Confirmar em modo VISUALIZAR (somente leitura)
2649:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = .F.
2650:                     THIS.AlternarPagina(2)
2651:                     loc_lResultado = .T.
2652:                 ELSE
2653:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
2654:                         "Erro ao carregar NF")
2655:                 ENDIF
2656:             ENDIF
2657: 

*-- Linhas 2677 a 2695:
2677:             RETURN .F.
2678:         ENDIF
2679: 
2680:         SELECT cursor_4c_Dados
2681: 
2682:         IF NVL(cursor_4c_Dados.correcs, 0) = 0
2683:             MsgAviso("A nota selecionada n" + CHR(227) + "o possui carta de corre" + ;
2684:                 CHR(231) + CHR(227) + "o para excluir.", "Aviso")
2685:             RETURN .F.
2686:         ENDIF
2687: 
2688:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da carta de corre" + ;
2689:                 CHR(231) + CHR(227) + "o desta NF?", ;
2690:                 "Excluir Carta")
2691:             RETURN .F.
2692:         ENDIF
2693: 
2694:         TRY
2695:             loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)


### BO (C:\4c\projeto\app\classes\CNFBO.prg):
*==============================================================================
* CNFBO.prg - Business Object de Correcao de Notas Fiscais
* Tabela principal: SigMvNfi (PK: cidchaves)
*==============================================================================

DEFINE CLASS CNFBO AS BusinessBase

    *-- =========================================================================
    *-- Chave primaria e identificacao
    *-- =========================================================================
    this_cCidchaves    = ""   && char(20) PK composta
    this_cEmpdopnums   = ""   && char(29) emps+dopes+numes
    this_cEmps         = ""   && char(3)

    *-- =========================================================================
    *-- Cabecalho da NF
    *-- =========================================================================
    this_cDopes        = ""   && char(20) tipo de operacao
    this_nNumes        = 0    && numeric(6,0) numero interno
    this_cNfis         = ""   && char(6) numero da NF fiscal
    this_cSeries       = ""   && char(8) serie
    this_cEspecienfs   = ""   && char(6) especie da NF
    this_tEmis         = {}   && datetime data emissao
    this_tDtsaidas     = {}   && datetime data saida
    this_tDatans       = {}   && datetime data da nota
    this_cOperas       = ""   && char(1) E=Entrada S=Saida
    this_lCorrecs      = .F.  && bit possui carta de correcao
    this_lCancelas     = .F.  && bit cancelada
    this_lRegs         = .F.  && bit registrada

    *-- =========================================================================
    *-- Fiscal / CFOP
    *-- =========================================================================
    this_cCfis         = ""   && char(10) cod. fiscal CFOP
    this_cClfis        = ""   && char(12) classe fiscal
    this_cCodcons      = ""   && char(9)  cod. condicao
    this_cConds        = ""   && char(12) condicoes
    this_cCfosubs      = ""   && char(10) CFOP substituto

    *-- Display-only: JOIN SigCdCfo.descricaos
    this_cDescricaos   = ""

    *-- =========================================================================
    *-- Cliente / Fornecedor
    *-- =========================================================================
    this_cClifors      = ""   && char(20) cod. cliente/fornecedor
    this_cCgcs         = ""   && char(21) CGC/CNPJ

    *-- Display-only: JOIN SigCdCli.rclis
    this_cRclis        = ""

    *-- =========================================================================
    *-- Impostos - IPI
    *-- =========================================================================
    this_nBasecipis    = 0    && numeric(14,2) base calculo IPI
    this_nValipis      = 0    && numeric(14,2) valor IPI
    this_nIpis         = 0    && numeric(4,2)  aliquota IPI
    this_nIpincreds    = 0    && numeric(14,2) IPI nao credita
    this_nBasecip2s    = 0    && numeric(14,2) base IPI 2
    this_nBasecip3s    = 0    && numeric(14,2) base IPI 3
    this_nDesipis      = 0    && numeric(15,2) desoner. IPI
    this_nFrtipis      = 0    && numeric(15,2) frete IPI
    this_nSegipis      = 0    && numeric(15,2) seguro IPI

    *-- =========================================================================
    *-- Impostos - ICMS
    *-- =========================================================================
    this_nBasecicms    = 0    && numeric(14,2) base calculo ICMS
    this_nValicms      = 0    && numeric(14,2) valor ICMS
    this_nIcms         = 0    && numeric(4,2)  aliquota % ICMS
    this_nBasecic2s    = 0    && numeric(14,2) base ICMS 2
    this_nBasecic3s    = 0    && numeric(14,2) base ICMS 3
    this_nBcicmss      = 0    && numeric(15,2) base ICMS subst.
    this_nIcmss        = 0    && numeric(15,2) ICMS substituicao
    this_nDesicms      = 0    && numeric(15,2) desoner. ICMS
    this_nFrticms      = 0    && numeric(15,2) frete ICMS
    this_nSegicms      = 0    && numeric(15,2) seguro ICMS
    this_nVfcpst       = 0    && numeric(14,2) FCP ST

    *-- =========================================================================
    *-- Totais
    *-- =========================================================================
    this_nTotProds     = 0    && numeric(14,2) total produtos
    this_nTotNotas     = 0    && numeric(14,2) total da NF
    this_nVals         = 0    && numeric(14,2) valor
    this_nPesos        = 0    && numeric(7,2)  peso

    *-- =========================================================================
    *-- Outros valores / frete / seguro
    *-- =========================================================================
    this_nVlFretes     = 0    && numeric(14,2) valor do frete
    this_nVlSeguros    = 0    && numeric(14,2) valor do seguro
    this_nDespAces     = 0    && numeric(14,2) despesas acessorias

    *-- =========================================================================
    *-- Transporte
    *-- =========================================================================
    this_cCodtrans     = ""   && char(10) cod. transportadora
    this_nFretes       = 0    && numeric(1,0) tipo frete 0=Emit/1=Dest
    this_cPlacas       = ""   && char(8)  placa veiculo
    this_cUfPlacas     = ""   && char(2)  UF placa
    this_tDatatrans    = {}   && datetime data transporte
    this_nNtrans       = 0    && numeric(6,0) numero transporte
    this_cObsfretes    = ""   && char(10) obs frete

    *-- Display-only via JOIN SigPrTrp
    this_cTranspNome   = ""
    this_cTranspEnde   = ""
    this_cTranspCida   = ""
    this_cTranspEsta   = ""

    *-- =========================================================================
    *-- Volumes transportados
    *-- =========================================================================
    this_nQtdes        = 0    && numeric(6,0) qtde de volumes
    this_cEspes        = ""   && char(10) especie do volume
    this_cMarcas       = ""   && char(10) marca do volume
    this_cNumeros      = ""   && char(10) numero do volume
    this_nPliqs        = 0    && numeric(10,3) peso liquido
    this_nPbrus        = 0    && numeric(10,3) peso bruto
    this_cObspbrus     = ""   && char(10) obs peso bruto
    this_cObspliqs     = ""   && char(10) obs peso liquido

    *-- =========================================================================
    *-- Servicos
    *-- =========================================================================
    this_cDescsers     = ""   && text  descricao servicos (memo)
    this_nVtotsers     = 0    && numeric(14,2) valor total servicos
    this_nPerciss      = 0    && numeric(5,2)  % ISS
    this_nVtotiss      = 0    && numeric(14,2) valor total ISS
    this_cCodservs     = ""   && char(10) cod. servico
    this_cDescservs    = ""   && char(40) desc. servico

    *-- ISS retido / outras retencoes
    this_nIssretidos   = 0    && numeric(1,0)  ISS retido flag
    this_nOutretens    = 0    && numeric(15,2) outras retencoes
    this_cPrestservs   = ""   && char(7)  prestador servicos
    this_nVdeducoes    = 0    && numeric(15,2) valor deducoes
    this_nVdscconds    = 0    && numeric(15,2) desc. condicionado
    this_nVdsciconds   = 0    && numeric(15,2) desc. incondicionado
    this_cTiponfs      = ""   && char(2)  tipo NF
    this_nTptribsers   = 0    && numeric(2,0)  tipo tribut. servicos
    this_cCodsrvfis    = ""   && char(6)  cod. servico fiscal
    this_cCodbenefs    = ""   && char(3)  cod. beneficio

    *-- =========================================================================
    *-- PIS / COFINS / CSLL / IR / INSS
    *-- =========================================================================
    this_nPcofins      = 0    && numeric(5,2)  % COFINS
    this_nVcofins      = 0    && numeric(14,2) valor COFINS
    this_nPcsll        = 0    && numeric(5,2)  % CSLL
    this_nVcsll        = 0    && numeric(14,2) valor CSLL
    this_nPinss        = 0    && numeric(5,2)  % INSS
    this_nVinss        = 0    && numeric(14,2) valor INSS
    this_nPirf         = 0    && numeric(5,2)  % IR
    this_nVirf         = 0    && numeric(14,2) valor IR
    this_nPpis         = 0    && numeric(5,2)  % PIS
    this_nVpis         = 0    && numeric(14,2) valor PIS
    this_nValiis       = 0    && numeric(14,2) valor II

    *-- =========================================================================
    *-- RPS (Recibo Provisorio de Servicos)
    *-- =========================================================================
    this_nLoterps      = 0    && numeric(6,0)  lote RPS
    this_nNumrps       = 0    && numeric(12,0) numero RPS
    this_cSerierps     = ""   && char(5)  serie RPS
    this_cTiporps      = ""   && char(5)  tipo RPS

    *-- =========================================================================
    *-- NF-e / Chaves eletronicas
    *-- =========================================================================
    this_cNfechv       = ""   && char(44) chave NF-e
    this_cNfechvc      = ""   && char(44) chave NF-e cancelamento
    this_cChnfes       = ""   && char(44) chave NF-e referenciada
    this_cNfepdf       = ""   && text     NF-e PDF
    this_cNfeprt       = ""   && char(15) NF-e protocolo
    this_cNfetxt       = ""   && text     NF-e texto
    this_cNfexml       = ""   && text     NF-e XML
    this_cCanxml       = ""   && text     XML cancelamento
    this_tDdesembs     = {}   && datetime data desembarque
    this_tDregdis      = {}   && datetime data registro DI
    this_cNdis         = ""   && char(10) numero DI
    this_tInvcbds      = {}   && datetime data invalida CBD
    this_nChkenvias    = 0    && numeric(1,0) flag enviado
    this_cChaveexterna = ""   && char(33) chave externa
    this_nChkrastreio  = 0    && numeric(1,0) flag rastreio

    *-- =========================================================================
    *-- Observacoes / Misc
    *-- =========================================================================
    this_cObss         = ""   && char(40) observacoes
    this_cObs2s        = ""   && char(40) observacoes 2
    this_nImpress      = 0    && numeric(6,0)  numero de impressoes
    this_nSelos        = 0    && numeric(10,0) selos
    this_cLocals       = ""   && char(10) local
    this_tImportas     = {}   && datetime data importacao
    this_cNumeronota   = ""   && char(10) numero nota alternativo

    *-- =========================================================================
    *-- Filtros de pesquisa (usados em Buscar)
    *-- =========================================================================
    this_cEmpsFiltro    = ""   && empresa para filtro
    this_cSeriesFiltro  = ""   && serie para filtro
    this_tEmisDeFiltro  = {}   && periodo emissao de
    this_tEmisAteFiltro = {}   && periodo emissao ate
    this_cOpeFiltro     = "A"  && E=Entrada S=Saida A=Ambas
    this_cNfisDeFiltro  = ""   && NF de (filtro por numero)
    this_cNfisAteFiltro = ""   && NF ate (filtro por numero)
    this_lCancelasFiltro = .F. && incluir canceladas

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvNfi"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCidchaves    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cEmps         = ""
        THIS.this_cDopes        = ""
        THIS.this_nNumes        = 0
        THIS.this_cNfis         = ""
        THIS.this_cSeries       = ""
        THIS.this_cEspecienfs   = ""
        THIS.this_tEmis         = {}
        THIS.this_tDtsaidas     = {}
        THIS.this_tDatans       = {}
        THIS.this_cOperas       = ""
        THIS.this_lCorrecs      = .F.
        THIS.this_lCancelas     = .F.
        THIS.this_lRegs         = .F.
        THIS.this_cCfis         = ""
        THIS.this_cClfis        = ""
        THIS.this_cCodcons      = ""
        THIS.this_cConds        = ""
        THIS.this_cCfosubs      = ""
        THIS.this_cDescricaos   = ""
        THIS.this_cClifors      = ""
        THIS.this_cCgcs         = ""
        THIS.this_cRclis        = ""
        THIS.this_nBasecipis    = 0
        THIS.this_nValipis      = 0
        THIS.this_nIpis         = 0
        THIS.this_nIpincreds    = 0
        THIS.this_nBasecip2s    = 0
        THIS.this_nBasecip3s    = 0
        THIS.this_nDesipis      = 0
        THIS.this_nFrtipis      = 0
        THIS.this_nSegipis      = 0
        THIS.this_nBasecicms    = 0
        THIS.this_nValicms      = 0
        THIS.this_nIcms         = 0
        THIS.this_nBasecic2s    = 0
        THIS.this_nBasecic3s    = 0
        THIS.this_nBcicmss      = 0
        THIS.this_nIcmss        = 0
        THIS.this_nDesicms      = 0
        THIS.this_nFrticms      = 0
        THIS.this_nSegicms      = 0
        THIS.this_nVfcpst       = 0
        THIS.this_nTotProds     = 0
        THIS.this_nTotNotas     = 0
        THIS.this_nVals         = 0
        THIS.this_nPesos        = 0
        THIS.this_nVlFretes     = 0
        THIS.this_nVlSeguros    = 0
        THIS.this_nDespAces     = 0
        THIS.this_cCodtrans     = ""
        THIS.this_nFretes       = 0
        THIS.this_cPlacas       = ""
        THIS.this_cUfPlacas     = ""
        THIS.this_tDatatrans    = {}
        THIS.this_nNtrans       = 0
        THIS.this_cObsfretes    = ""
        THIS.this_cTranspNome   = ""
        THIS.this_cTranspEnde   = ""
        THIS.this_cTranspCida   = ""
        THIS.this_cTranspEsta   = ""
        THIS.this_nQtdes        = 0
        THIS.this_cEspes        = ""
        THIS.this_cMarcas       = ""
        THIS.this_cNumeros      = ""
        THIS.this_nPliqs        = 0
        THIS.this_nPbrus        = 0
        THIS.this_cObspbrus     = ""
        THIS.this_cObspliqs     = ""
        THIS.this_cDescsers     = ""
        THIS.this_nVtotsers     = 0
        THIS.this_nPerciss      = 0
        THIS.this_nVtotiss      = 0
        THIS.this_cCodservs     = ""
        THIS.this_cDescservs    = ""
        THIS.this_nIssretidos   = 0
        THIS.this_nOutretens    = 0
        THIS.this_cPrestservs   = ""
        THIS.this_nVdeducoes    = 0
        THIS.this_nVdscconds    = 0
        THIS.this_nVdsciconds   = 0
        THIS.this_cTiponfs      = ""
        THIS.this_nTptribsers   = 0
        THIS.this_cCodsrvfis    = ""
        THIS.this_cCodbenefs    = ""
        THIS.this_nPcofins      = 0
        THIS.this_nVcofins      = 0
        THIS.this_nPcsll        = 0
        THIS.this_nVcsll        = 0
        THIS.this_nPinss        = 0
        THIS.this_nVinss        = 0
        THIS.this_nPirf         = 0
        THIS.this_nVirf         = 0
        THIS.this_nPpis         = 0
        THIS.this_nVpis         = 0
        THIS.this_nValiis       = 0
        THIS.this_nLoterps      = 0
        THIS.this_nNumrps       = 0
        THIS.this_cSerierps     = ""
        THIS.this_cTiporps      = ""
        THIS.this_cNfechv       = ""
        THIS.this_cNfechvc      = ""
        THIS.this_cChnfes       = ""
        THIS.this_cNfepdf       = ""
        THIS.this_cNfeprt       = ""
        THIS.this_cNfetxt       = ""
        THIS.this_cNfexml       = ""
        THIS.this_cCanxml       = ""
        THIS.this_tDdesembs     = {}
        THIS.this_tDregdis      = {}
        THIS.this_cNdis         = ""
        THIS.this_tInvcbds      = {}
        THIS.this_nChkenvias    = 0
        THIS.this_cChaveexterna = ""
        THIS.this_nChkrastreio  = 0
        THIS.this_cObss         = ""
        THIS.this_cObs2s        = ""
        THIS.this_nImpress      = 0
        THIS.this_nSelos        = 0
        THIS.this_cLocals       = ""
        THIS.this_tImportas     = {}
        THIS.this_cNumeronota   = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega dados do cursor para propriedades do BO
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cEmpdopnums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_cDopes       = TratarNulo(dopes,       "C")
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cNfis        = TratarNulo(nfis,        "C")
            THIS.this_cSeries      = TratarNulo(series,      "C")
            THIS.this_cEspecienfs  = TratarNulo(especienfs,  "C")
            IF !ISNULL(emis)
                THIS.this_tEmis    = emis
            ENDIF
            IF !ISNULL(dtsaidas)
                THIS.this_tDtsaidas = dtsaidas
            ENDIF
            IF !ISNULL(datans)
                THIS.this_tDatans  = datans
            ENDIF
            THIS.this_cOperas      = TratarNulo(operas,      "C")
            THIS.this_lCorrecs     = (IIF(ISNULL(correcs),  0, correcs)  <> 0)
            THIS.this_lCancelas    = (IIF(ISNULL(cancelas), 0, cancelas) <> 0)
            THIS.this_lRegs        = (IIF(ISNULL(regs),     0, regs)     <> 0)
            THIS.this_cCfis        = TratarNulo(cfis,        "C")
            THIS.this_cClfis       = TratarNulo(clfis,       "C")
            THIS.this_cCodcons     = TratarNulo(codcons,     "C")
            THIS.this_cConds       = TratarNulo(conds,       "C")
            THIS.this_cClifors     = TratarNulo(clifors,     "C")
            THIS.this_cCgcs        = TratarNulo(cgcs,        "C")
            THIS.this_nBasecipis   = TratarNulo(basecipis,   "N")
            THIS.this_nValipis     = TratarNulo(valipis,     "N")
            THIS.this_nIpis        = TratarNulo(ipis,        "N")
            THIS.this_nIpincreds   = TratarNulo(ipincreds,   "N")
            THIS.this_nBasecip2s   = TratarNulo(basecip2s,   "N")
            THIS.this_nBasecip3s   = TratarNulo(basecip3s,   "N")
            THIS.this_nBasecicms   = TratarNulo(basecicms,   "N")
            THIS.this_nValicms     = TratarNulo(valicms,     "N")
            THIS.this_nIcms        = TratarNulo(icms,        "N")
            THIS.this_nBasecic2s   = TratarNulo(basecic2s,   "N")
            THIS.this_nBasecic3s   = TratarNulo(basecic3s,   "N")
            THIS.this_nTotProds    = TratarNulo(totprods,    "N")
            THIS.this_nTotNotas    = TratarNulo(totnotas,    "N")
            THIS.this_nVals        = TratarNulo(vals,        "N")
            THIS.this_nPesos       = TratarNulo(pesos,       "N")
            THIS.this_nVlFretes    = TratarNulo(vlfretes,    "N")
            THIS.this_nVlSeguros   = TratarNulo(vlseguros,   "N")
            THIS.this_nDespAces    = TratarNulo(despaces,    "N")
            THIS.this_cCodtrans    = TratarNulo(codtrans,    "C")
            THIS.this_nFretes      = TratarNulo(fretes,      "N")
            THIS.this_cPlacas      = TratarNulo(placas,      "C")
            THIS.this_cUfPlacas    = TratarNulo(ufplacas,    "C")
            IF !ISNULL(datatrans)
                THIS.this_tDatatrans = datatrans
            ENDIF
            THIS.this_nQtdes       = TratarNulo(qtdes,       "N")
            THIS.this_cEspes       = TratarNulo(espes,       "C")
            THIS.this_cMarcas      = TratarNulo(marcas,      "C")
            THIS.this_cNumeros     = TratarNulo(numeros,     "C")
            THIS.this_nPliqs       = TratarNulo(pliqs,       "N")
            THIS.this_nPbrus       = TratarNulo(pbrus,       "N")
            THIS.this_cDescsers    = TratarNulo(descsers,    "C")
            THIS.this_nVtotsers    = TratarNulo(vtotsers,    "N")
            THIS.this_nPerciss     = TratarNulo(perciss,     "N")
            THIS.this_nVtotiss     = TratarNulo(vtotiss,     "N")
            THIS.this_nImpress     = TratarNulo(impress,     "N")
            THIS.this_cObss        = TratarNulo(obss,        "C")
            THIS.this_cObs2s       = TratarNulo(obs2s,       "C")
            IF !ISNULL(importas)
                THIS.this_tImportas = importas
            ENDIF
            *-- Campos de JOIN (presentes quando vem de Buscar ou CarregarPorCodigo)
            IF TYPE("rclis") <> "U"
                THIS.this_cRclis       = TratarNulo(rclis,       "C")
            ENDIF
            IF TYPE("descricaos") <> "U"
                THIS.this_cDescricaos  = TratarNulo(descricaos,  "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar cursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Pesquisa NFs com filtros configurados nas propriedades de filtro
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cJoinCfg, loc_cWhereOpe, loc_cWhereSerie, loc_cWhereData
        LOCAL loc_cWhereNfi, loc_cWhereCan, loc_nCfgCount
        loc_lSucesso  = .F.
        loc_nCfgCount = 0

        IF EMPTY(THIS.this_cEmps)
            MsgAviso("Empresa obrigat" + CHR(243) + "ria para pesquisa.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Verifica SigCnFNF: join por emps+series ou apenas series
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS qtd FROM SigCnFNF WHERE emps = " + ;
                EscaparSQL(PADR(THIS.this_cEmps, 3)), ;
                "cursor_4c_CfgNFNF")
            IF loc_nResultado >= 0 AND USED("cursor_4c_CfgNFNF") AND RECCOUNT("cursor_4c_CfgNFNF") > 0
                SELECT cursor_4c_CfgNFNF
                loc_nCfgCount = cursor_4c_CfgNFNF.qtd
            ENDIF
            IF USED("cursor_4c_CfgNFNF")
                USE IN cursor_4c_CfgNFNF
            ENDIF

            IF loc_nCfgCount > 0
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.emps + g.series = n.emps + n.series"
            ELSE
                loc_cJoinCfg = "LEFT JOIN SigCnFNF g ON g.series = n.series"
            ENDIF

            *-- Filtro operacao E/S/A
            DO CASE
                CASE THIS.this_cOpeFiltro = "E"
                    loc_cWhereOpe = " AND n.operas = 'E'"
                CASE THIS.this_cOpeFiltro = "S"
                    loc_cWhereOpe = " AND n.operas = 'S'"
                OTHERWISE
                    loc_cWhereOpe = " AND n.operas IN ('E','S')"
            ENDCASE

            *-- Filtro serie
            IF EMPTY(THIS.this_cSeriesFiltro)
                loc_cWhereSerie = ""
            ELSE
                loc_cWhereSerie = " AND n.series = " + EscaparSQL(PADR(THIS.this_cSeriesFiltro, 8))
            ENDIF

            *-- Filtro data emissao
            IF EMPTY(THIS.this_tEmisDeFiltro) OR EMPTY(THIS.this_tEmisAteFiltro)
                loc_cWhereData = ""
            ELSE
                loc_cWhereData = " AND CAST(n.emis AS DATE) BETWEEN " + ;
                    FormatarDataSQL(THIS.this_tEmisDeFiltro) + ;
                    " AND " + FormatarDataSQL(THIS.this_tEmisAteFiltro)
            ENDIF

            *-- Filtro numero NF
            IF EMPTY(THIS.this_cNfisDeFiltro) AND EMPTY(THIS.this_cNfisAteFiltro)
                loc_cWhereNfi = ""
            ELSE
                loc_cWhereNfi = " AND n.nfis BETWEEN " + ;
                    EscaparSQL(PADR(THIS.this_cNfisDeFiltro, 6)) + ;
                    " AND " + EscaparSQL(IIF(EMPTY(THIS.this_cNfisAteFiltro), ;
                        REPLICATE(CHR(254), 6), PADR(THIS.this_cNfisAteFiltro, 6)))
            ENDIF

            *-- Filtro canceladas (padrao = so nao canceladas)
            IF THIS.this_lCancelasFiltro
                loc_cWhereCan = ""
            ELSE
                loc_cWhereCan = " AND n.cancelas = 0"
            ENDIF

            loc_cSQL = "SELECT n.cidchaves, n.empdopnums, n.emps, n.dopes, n.numes," + ;
                " n.nfis, n.series, n.especienfs, n.emis, n.dtsaidas, n.datans," + ;
                " n.operas, n.correcs, n.cancelas, n.regs," + ;
                " n.cfis, n.clfis, n.codcons, n.conds," + ;
                " n.clifors, n.cgcs," + ;
                " n.basecipis, n.valipis, n.ipis, n.ipincreds," + ;
                " n.basecip2s, n.basecip3s," + ;
                " n.basecicms, n.valicms, n.icms," + ;
                " n.basecic2s, n.basecic3s," + ;
                " n.totprods, n.totnotas, n.vals, n.pesos," + ;
                " n.vlfretes, n.vlseguros, n.despaces," + ;
                " n.codtrans, n.fretes, n.placas, n.ufplacas, n.datatrans," + ;
                " n.qtdes, n.espes, n.marcas, n.numeros, n.pliqs, n.pbrus," + ;
                " n.descsers, n.vtotsers, n.perciss, n.vtotiss," + ;
                " n.impress, n.obss, n.obs2s, n.importas," + ;
                " c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " " + loc_cJoinCfg + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.emps = " + EscaparSQL(PADR(THIS.this_cEmps, 3)) + ;
                loc_cWhereSerie + ;
                loc_cWhereData + ;
                loc_cWhereOpe + ;
                loc_cWhereCan + ;
                loc_cWhereNfi + ;
                " ORDER BY n.nfis, n.emis"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar notas fiscais:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo pelo cidchaves (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.*, c.rclis, f.descricaos" + ;
                " FROM SigMvNfi n" + ;
                " LEFT JOIN SigCdCfo f ON f.codigos = n.cfis" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = n.clifors" + ;
                " WHERE n.cidchaves = " + EscaparSQL(PADR(ALLTRIM(par_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar NF:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        *-- Carregar dados da transportadora automaticamente apos carregar NF
        IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCodtrans))
            THIS.CarregarTransportadora(THIS.this_cCodtrans)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTransportadora - Carrega dados do transportador por codtrans
    *==========================================================================
    PROTECTED PROCEDURE CarregarTransportadora(par_cCodTrans)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cTranspNome = ""
        THIS.this_cTranspEnde = ""
        THIS.this_cTranspCida = ""
        THIS.this_cTranspEsta = ""

        IF EMPTY(par_cCodTrans)
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT razaos, endes, cidas, estas" + ;
                " FROM SigPrTrp WHERE itras = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodTrans), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Transp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Transp") AND RECCOUNT("cursor_4c_Transp") > 0
                SELECT cursor_4c_Transp
                THIS.this_cTranspNome = TratarNulo(razaos, "C")
                THIS.this_cTranspEnde = TratarNulo(endes,  "C")
                THIS.this_cTranspCida = TratarNulo(cidas,  "C")
                THIS.this_cTranspEsta = TratarNulo(estas,  "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar transportadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Transp")
            USE IN cursor_4c_Transp
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarSeries - Carrega series para lookup no filtro
    *==========================================================================
    PROCEDURE BuscarSeries(par_cEmpsFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cEmpsFiltro)
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT DISTINCT Cods, Descs FROM SigCdSer" + ;
                    " WHERE emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpsFiltro), 3)) + ;
                    " ORDER BY Cods"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Series")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar s" + CHR(233) + "ries:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT no SigMvNfi
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigMvNfi" + ;
                " (cidchaves, empdopnums, emps, dopes, numes," + ;
                "  nfis, series, especienfs, emis, dtsaidas, datans, operas," + ;
                "  correcs, cancelas, regs, cfis, clfis, codcons, conds," + ;
                "  clifors, cgcs, basecipis, valipis, ipis, ipincreds," + ;
                "  basecip2s, basecip3s, basecicms, valicms, icms," + ;
                "  basecic2s, basecic3s, totprods, totnotas, vals, pesos," + ;
                "  vlfretes, vlseguros, despaces, codtrans, fretes," + ;
                "  placas, ufplacas, datatrans," + ;
                "  qtdes, espes, marcas, numeros, pliqs, pbrus," + ;
                "  descsers, vtotsers, perciss, vtotiss, impress, obss, obs2s)" + ;
                " VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmpdopnums), 29)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cDopes), 20)) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cSeries), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspecienfs), 6)) + "," + ;
                IIF(EMPTY(THIS.this_tEmis), "NULL", FormatarDataSQL(THIS.this_tEmis)) + "," + ;
                IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                IIF(EMPTY(THIS.this_tDatans), "NULL", FormatarDataSQL(THIS.this_tDatans)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cOperas), 1)) + ","
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lCorrecs, "1", "0") + "," + ;
                IIF(THIS.this_lCancelas, "1", "0") + "," + ;
                IIF(THIS.this_lRegs, "1", "0") + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcons), 9)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cConds), 12)) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCgcs), 21)) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                FormatarNumeroSQL(THIS.this_nIpincreds) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecip2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecip3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                FormatarNumeroSQL(THIS.this_nIcms) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nBasecic2s) + "," + ;
                FormatarNumeroSQL(THIS.this_nBasecic3s) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nTotNotas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVals) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesos) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                FormatarNumeroSQL(THIS.this_nDespAces) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nFretes) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + "," + ;
                IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + ","
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                FormatarNumeroSQL(THIS.this_nVtotiss) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpress) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE no SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvNfi SET" + ;
                " nfis     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNfis), 6)) + "," + ;
                " dtsaidas = " + IIF(EMPTY(THIS.this_tDtsaidas), "NULL", FormatarDataSQL(THIS.this_tDtsaidas)) + "," + ;
                " correcs  = " + IIF(THIS.this_lCorrecs, "1", "0") + ","
            loc_cSQL = loc_cSQL + ;
                " cfis    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCfis), 10)) + "," + ;
                " clfis   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClfis), 12)) + "," + ;
                " clifors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cClifors), 20)) + ","
            loc_cSQL = loc_cSQL + ;
                " basecipis = " + FormatarNumeroSQL(THIS.this_nBasecipis) + "," + ;
                " valipis   = " + FormatarNumeroSQL(THIS.this_nValipis) + "," + ;
                " ipis      = " + FormatarNumeroSQL(THIS.this_nIpis) + "," + ;
                " basecicms = " + FormatarNumeroSQL(THIS.this_nBasecicms) + ","
            loc_cSQL = loc_cSQL + ;
                " valicms  = " + FormatarNumeroSQL(THIS.this_nValicms) + "," + ;
                " icms     = " + FormatarNumeroSQL(THIS.this_nIcms) + "," + ;
                " totprods = " + FormatarNumeroSQL(THIS.this_nTotProds) + "," + ;
                " totnotas = " + FormatarNumeroSQL(THIS.this_nTotNotas) + ","
            loc_cSQL = loc_cSQL + ;
                " vlfretes  = " + FormatarNumeroSQL(THIS.this_nVlFretes) + "," + ;
                " vlseguros = " + FormatarNumeroSQL(THIS.this_nVlSeguros) + "," + ;
                " despaces  = " + FormatarNumeroSQL(THIS.this_nDespAces) + ","
            loc_cSQL = loc_cSQL + ;
                " codtrans = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtrans), 10)) + "," + ;
                " fretes   = " + FormatarNumeroSQL(THIS.this_nFretes) + "," + ;
                " placas   = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cPlacas), 8)) + "," + ;
                " ufplacas = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUfPlacas), 2)) + ","
            loc_cSQL = loc_cSQL + ;
                " datatrans = " + IIF(EMPTY(THIS.this_tDatatrans), "NULL", FormatarDataSQL(THIS.this_tDatatrans)) + "," + ;
                " qtdes     = " + FormatarNumeroSQL(THIS.this_nQtdes) + "," + ;
                " espes     = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEspes), 10)) + ","
            loc_cSQL = loc_cSQL + ;
                " marcas  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cMarcas), 10)) + "," + ;
                " numeros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cNumeros), 10)) + "," + ;
                " pliqs   = " + FormatarNumeroSQL(THIS.this_nPliqs) + "," + ;
                " pbrus   = " + FormatarNumeroSQL(THIS.this_nPbrus) + ","
            loc_cSQL = loc_cSQL + ;
                " descsers = " + EscaparSQL(ALLTRIM(THIS.this_cDescsers)) + "," + ;
                " vtotsers = " + FormatarNumeroSQL(THIS.this_nVtotsers) + "," + ;
                " perciss  = " + FormatarNumeroSQL(THIS.this_nPerciss) + "," + ;
                " vtotiss  = " + FormatarNumeroSQL(THIS.this_nVtotiss) + ","
            loc_cSQL = loc_cSQL + ;
                " obss  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObss), 40)) + "," + ;
                " obs2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObs2s), 40)) + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE do SigMvNfi pelo cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvNfi" + ;
                " WHERE cidchaves = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir nota fiscal:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

