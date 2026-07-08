# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPES, NUMES, NOTAS, OBSES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPES, NUMES, NOTAS, OBSES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPES, NUMES, NOTAS, OBSES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPES, NUMES, NOTAS, OBSES

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
  btnReport.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  ControlSource = ""
lcquery = [Select emps,dopes,numes,datas,notas,datars,empdopnums,operadors,usulibs,IsNull(convert(varchar(250),Obses),'') as Obses From SigMvCab a ] +;
	.poDataMgr.sqlexecute(lcquery,[crSigMvCab])
	Select crSigMvCab
			Delete
	.grid1.column1.ControlSource = [crSigMvCab.dopes]
	.grid1.column2.ControlSource = [crSigMvCab.numes]
	.grid1.column3.ControlSource = [crSigMvCab.notas]
	.grid1.column4.ControlSource = [crSigMvCab.datas]
	.grid1.column5.ControlSource = [crSigMvCab.usulibs]
	.grid1.column6.ControlSource = [crSigMvCab.Obses]
	lcSql = [Select Dopes From SigCdOpe Where Dopes = ']+crSigMvCab.Dopes+[']
	If thisform.Podatamgr.SqlExecute(lcsql,'TmpOpe') > 0 And Reccount('TmpOpe') > 0
	SELECT crSigMvCab

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCsp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1954 linhas total):

*-- Linhas 525 a 544:
525:     *--------------------------------------------------------------------------
526:     * ProcessarClick - Executa a pesquisa e exibe resultados no grid
527:     *   1. FormParaRelatorio() copia filtros para o BO
528:     *   2. PrepararDados() executa SQLEXEC em SigMvCab
529:     *   3. RecordSource + ControlSource do grid apontam para cursor resultado
530:     *   4. Headers reconfigurados apos RecordSource (VFP9 os reseta)
531:     *   Equivalente ao procedimento 'processamento' do legado SIGRECSP.
532:     *--------------------------------------------------------------------------
533:     PROCEDURE ProcessarClick()
534:         LOCAL loc_lResultado, loc_oGrid, loc_cCursor
535:         loc_lResultado = .F.
536:         loc_oGrid      = .NULL.
537: 
538:         *-- Obter referencia ao grid dentro do PageFrame.Page1
539:         IF TYPE("THIS.pgf_4c_Paginas") = "O"
540:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
541:         ENDIF
542: 
543:         TRY
544:             IF VARTYPE(loc_oGrid) != "O"

*-- Linhas 556 a 579:
556:                         loc_oGrid.RecordSource = ""
557:                         loc_oGrid.RecordSource = loc_cCursor
558: 
559:                         loc_oGrid.Column1.ControlSource = loc_cCursor + ".dopes"
560:                         loc_oGrid.Column2.ControlSource = loc_cCursor + ".numes"
561:                         loc_oGrid.Column3.ControlSource = loc_cCursor + ".notas"
562:                         loc_oGrid.Column4.ControlSource = loc_cCursor + ".datas"
563:                         loc_oGrid.Column5.ControlSource = loc_cCursor + ".usulibs"
564:                         loc_oGrid.Column6.ControlSource = loc_cCursor + ".Obses"
565: 
566:                         *-- Reconfigurar headers (VFP9 reseta ao alterar RecordSource)
567:                         loc_oGrid.Column1.Header1.Caption = ;
568:                             "Movimenta" + CHR(231) + CHR(227) + "o"
569:                         loc_oGrid.Column2.Header1.Caption = ;
570:                             "N" + CHR(250) + "mero"
571:                         loc_oGrid.Column3.Header1.Caption = "Docum."
572:                         loc_oGrid.Column4.Header1.Caption = "Data"
573:                         loc_oGrid.Column5.Header1.Caption = ;
574:                             "Usu" + CHR(225) + "rio"
575:                         loc_oGrid.Column6.Header1.Caption = ;
576:                             "Observa" + CHR(231) + CHR(227) + "o"
577: 
578:                         *-- Navegar para a pagina de resultados e focar grid
579:                         THIS.AlternarPagina(1)

*-- Linhas 615 a 648:
615:                 MsgAviso("Sem registros. Execute Processar primeiro.", ;
616:                     "Movimento")
617:             ELSE
618:                 SELECT (THIS.this_oRelatorio.this_cCursorDados)
619:                 loc_cDopes = ALLTRIM(dopes)
620:                 loc_nNumes = numes
621:                 loc_cEmps  = ALLTRIM(emps)
622: 
623:                 *-- Verificar se operacao existe em SigCdOpe (igual ao legado Dados.Click)
624:                 loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
625:                     EscaparSQL(loc_cDopes)
626:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
627: 
628:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TmpOpe") > 0
629:                     USE IN cursor_4c_TmpOpe
630:                     THIS.Enabled = .F.
631:                     THIS.Refresh()
632:                     DO FORM SigMvExp WITH loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.
633:                     SELECT (THIS.this_oRelatorio.this_cCursorDados)
634:                     THIS.Enabled = .T.
635:                     THIS.Refresh()
636:                 ELSE
637:                     IF USED("cursor_4c_TmpOpe")
638:                         USE IN cursor_4c_TmpOpe
639:                     ENDIF
640:                     MsgAviso("Opera" + CHR(231) + CHR(227) + ;
641:                         "o n" + CHR(227) + "o encontrada em SigCdOpe.", ;
642:                         "Movimento")
643:                 ENDIF
644:             ENDIF
645:         CATCH TO loc_oErro
646:             THIS.Enabled = .T.
647:             MsgErro(loc_oErro.Message + CHR(13) + ;
648:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;

*-- Linhas 680 a 698:
680:                 MsgAviso("Execute Processar para carregar dados antes de imprimir.", ;
681:                     "Imprimir")
682:             ELSE
683:                 SELECT (loc_cCursor)
684:                 SET PRINTER TO PROMPT
685:                 SET PRINTER ON
686:                 LIST OFF TO PRINTER
687:                 SET PRINTER OFF
688:                 SET PRINTER TO
689:                 loc_lResultado = .T.
690:             ENDIF
691:         CATCH TO loc_oErro
692:             MsgErro(loc_oErro.Message + CHR(13) + ;
693:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
694:                 "Procedure: " + loc_oErro.Procedure, "Erro ao Imprimir")
695:         ENDTRY
696:         RETURN loc_lResultado
697:     ENDPROC
698: 

*-- Linhas 705 a 723:
705:            RECCOUNT(THIS.this_oRelatorio.this_cCursorDados) > 0
706:             loc_cArq = SYS(5) + CURDIR() + "SigReCsp_" + ;
707:                 STRTRAN(DTOC(DATE()), "/", "") + ".xls"
708:             SELECT (THIS.this_oRelatorio.this_cCursorDados)
709:             COPY TO (loc_cArq) TYPE XLS
710:             MsgInfo("Exportado para: " + loc_cArq, "Excel")
711:         ELSE
712:             MsgAviso("Sem dados para exportar. Execute Processar primeiro.", ;
713:                 "Excel")
714:         ENDIF
715:     ENDPROC
716: 
717:     *--------------------------------------------------------------------------
718:     * BtnSairClick - Encerra o formulario
719:     *--------------------------------------------------------------------------
720:     PROCEDURE BtnSairClick()
721:         THIS.Release()
722:     ENDPROC
723: 

*-- Linhas 872 a 890:
872:     *   Grid com 6 colunas equivalentes ao Grid1 original:
873:     *   dopes (Movimentacao), numes (Numero), notas (Docum.),
874:     *   datas (Data), usulibs (Usuario), Obses (Observacao).
875:     *   ControlSource e headers sao reconfigurados por ProcessarClick()
876:     *   apos cada execucao de query (VFP9 reseta headers ao mudar RecordSource).
877:     *   Posicao: Top=55 (260-205=55 do topo do PageFrame), Left=16,
878:     *            Width=760, Height=308 - espelha Grid1 original.
879:     *--------------------------------------------------------------------------
880:     PROTECTED PROCEDURE ConfigurarPaginaLista()
881:         LOCAL loc_oPagina, loc_oGrid
882:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
883: 
884:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
885:         loc_oGrid = loc_oPagina.grd_4c_Dados
886: 
887:         WITH loc_oGrid
888:             .Top                = 55
889:             .Left               = 16
890:             .Width              = 760

*-- Linhas 898 a 916:
898:             .HighlightBackColor = RGB(255, 255, 255)
899:             .HighlightForeColor = RGB(15, 41, 104)
900:             .HighlightStyle     = 2
901:             .DeleteMark         = .F.
902:             .RecordMark         = .F.
903:             .RowHeight          = 16
904:             .ScrollBars         = 2
905: 
906:             *-- Movimentacao (dopes) - operacao
907:             WITH .Column1
908:                 .Width              = 140
909:                 .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
910:                 .FontName           = "Verdana"
911:                 .FontSize           = 8
912:             ENDWITH
913: 
914:             *-- Numero (numes)
915:             WITH .Column2
916:                 .Width              = 70

*-- Linhas 1396 a 1418:
1396:             RETURN
1397:         ENDIF
1398:         TRY
1399:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1400:                 EscaparSQL(loc_cEmpresa)
1401:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValC")
1402:             IF loc_nResult > 0
1403:                 SELECT cursor_4c_EmpValC
1404:                 IF !EOF()
1405:                     IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
1406:                         THIS.txt_4c_DEmpresa.Value = ALLTRIM(Razas)
1407:                     ENDIF
1408:                 ELSE
1409:                     IF VARTYPE(THIS.txt_4c_Empresa) = "O"
1410:                         THIS.txt_4c_Empresa.Value = ""
1411:                     ENDIF
1412:                     IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
1413:                         THIS.txt_4c_DEmpresa.Value = ""
1414:                     ENDIF
1415:                 ENDIF
1416:                 USE IN cursor_4c_EmpValC
1417:             ENDIF
1418:         CATCH TO loc_oErro

*-- Linhas 1448 a 1470:
1448:             RETURN
1449:         ENDIF
1450:         TRY
1451:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + ;
1452:                 EscaparSQL("%" + loc_cDesc + "%") + " ORDER BY Razas"
1453:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpValD")
1454:             IF loc_nResult > 0
1455:                 SELECT cursor_4c_EmpValD
1456:                 DO CASE
1457:                     CASE RECCOUNT("cursor_4c_EmpValD") = 1
1458:                         IF VARTYPE(THIS.txt_4c_Empresa) = "O"
1459:                             THIS.txt_4c_Empresa.Value = ALLTRIM(Cemps)
1460:                         ENDIF
1461:                         IF VARTYPE(THIS.txt_4c_DEmpresa) = "O"
1462:                             THIS.txt_4c_DEmpresa.Value = ALLTRIM(Razas)
1463:                         ENDIF
1464:                     CASE RECCOUNT("cursor_4c_EmpValD") > 1
1465:                         USE IN cursor_4c_EmpValD
1466:                         THIS.AbrirBuscaEmpresa()
1467:                         RETURN
1468:                     OTHERWISE
1469:                         IF VARTYPE(THIS.txt_4c_Empresa) = "O"
1470:                             THIS.txt_4c_Empresa.Value = ""

*-- Linhas 1537 a 1559:
1537:             RETURN
1538:         ENDIF
1539:         TRY
1540:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
1541:                 EscaparSQL(loc_cOp)
1542:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
1543:             IF loc_nResult > 0
1544:                 SELECT cursor_4c_OpeVal
1545:                 IF EOF()
1546:                     IF VARTYPE(THIS.txt_4c_NmOperacao) = "O"
1547:                         THIS.txt_4c_NmOperacao.Value = ""
1548:                     ENDIF
1549:                     MsgAviso("Opera" + CHR(231) + CHR(227) + ;
1550:                         "o n" + CHR(227) + "o encontrada em SigCdOpe.", ;
1551:                         "Valida" + CHR(231) + CHR(227) + "o")
1552:                 ENDIF
1553:                 USE IN cursor_4c_OpeVal
1554:             ENDIF
1555:         CATCH TO loc_oErro
1556:             MsgErro(loc_oErro.Message, ;
1557:                 "Validar Opera" + CHR(231) + CHR(227) + "o")
1558:         ENDTRY
1559:     ENDPROC

*-- Linhas 1595 a 1617:
1595:             RETURN
1596:         ENDIF
1597:         TRY
1598:             loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
1599:                 EscaparSQL(loc_cCod)
1600:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1601:             IF loc_nResult > 0
1602:                 SELECT cursor_4c_GcrVal
1603:                 IF !EOF()
1604:                     IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
1605:                         THIS.txt_4c_DGrupo.Value = ALLTRIM(descs)
1606:                     ENDIF
1607:                 ELSE
1608:                     IF VARTYPE(THIS.txt_4c_Grupo) = "O"
1609:                         THIS.txt_4c_Grupo.Value  = ""
1610:                     ENDIF
1611:                     IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
1612:                         THIS.txt_4c_DGrupo.Value = ""
1613:                     ENDIF
1614:                     THIS.AbrirBuscaGrupo()
1615:                 ENDIF
1616:                 USE IN cursor_4c_GcrVal
1617:             ENDIF

*-- Linhas 1659 a 1677:
1659:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1660:                 loc_oBusca.Show()
1661:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1662:                     SELECT (loc_cCursor)
1663:                     IF VARTYPE(THIS.txt_4c_Grupo) = "O"
1664:                         THIS.txt_4c_Grupo.Value  = ALLTRIM(codigos)
1665:                     ENDIF
1666:                     IF VARTYPE(THIS.txt_4c_DGrupo) = "O"
1667:                         THIS.txt_4c_DGrupo.Value = ALLTRIM(descs)
1668:                     ENDIF
1669:                     IF VARTYPE(THIS.txt_4c_Conta) = "O"
1670:                         THIS.txt_4c_Conta.Value  = ""
1671:                     ENDIF
1672:                     IF VARTYPE(THIS.txt_4c_DConta) = "O"
1673:                         THIS.txt_4c_DConta.Value = ""
1674:                     ENDIF
1675:                 ENDIF
1676:                 loc_oBusca.Release()
1677:             ENDIF

*-- Linhas 1721 a 1746:
1721:                 loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
1722:             ENDIF
1723:             IF !EMPTY(loc_cGrupo)
1724:                 loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1725:             ENDIF
1726: 
1727:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
1728:                 EscaparSQL(loc_cCod) + loc_cFiltro
1729:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
1730:             IF loc_nResult > 0
1731:                 SELECT cursor_4c_CliVal
1732:                 IF !EOF()
1733:                     IF VARTYPE(THIS.txt_4c_DConta) = "O"
1734:                         THIS.txt_4c_DConta.Value = ALLTRIM(rclis)
1735:                     ENDIF
1736:                 ELSE
1737:                     IF VARTYPE(THIS.txt_4c_Conta) = "O"
1738:                         THIS.txt_4c_Conta.Value  = ""
1739:                     ENDIF
1740:                     IF VARTYPE(THIS.txt_4c_DConta) = "O"
1741:                         THIS.txt_4c_DConta.Value = ""
1742:                     ENDIF
1743:                     THIS.AbrirBuscaConta()
1744:                 ENDIF
1745:                 USE IN cursor_4c_CliVal
1746:             ENDIF

*-- Linhas 1785 a 1814:
1785:                 loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)
1786:             ENDIF
1787:             IF !EMPTY(loc_cGrupo)
1788:                 loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1789:             ENDIF
1790: 
1791:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1792:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
1793:                 "Selecionar Conta Cont" + CHR(225) + "bil", loc_cFiltro)
1794:             IF VARTYPE(loc_oBusca) = "O"
1795:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1796:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1797:                 loc_oBusca.Show()
1798:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1799:                     SELECT (loc_cCursor)
1800:                     IF VARTYPE(THIS.txt_4c_Conta) = "O"
1801:                         THIS.txt_4c_Conta.Value  = ALLTRIM(iclis)
1802:                     ENDIF
1803:                     IF VARTYPE(THIS.txt_4c_DConta) = "O"
1804:                         THIS.txt_4c_DConta.Value = ALLTRIM(rclis)
1805:                     ENDIF
1806:                 ENDIF
1807:                 loc_oBusca.Release()
1808:             ENDIF
1809:         CATCH TO loc_oErro
1810:             MsgErro(loc_oErro.Message, "Busca Conta")
1811:         ENDTRY
1812:         IF USED(loc_cCursor)
1813:             USE IN (loc_cCursor)
1814:         ENDIF


### BO (C:\4c\projeto\app\classes\SigReCspBO.prg):
*==============================================================================
* SIGRECSPBO.PRG
* Business Object para Pesquisa de Operacoes (SIGRECSP)
* Herda de RelatorioBase
*
* Tabela principal: SigMvCab
* Chave: EmpDopNums
* Cursor resultado: cursor_4c_SigReCsp
*==============================================================================

DEFINE CLASS SigReCspBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela        = "SigMvCab"
    this_cCampoChave    = "EmpDopNums"
    this_cCursorDados   = "cursor_4c_SigReCsp"

    *-- Filtros: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtros: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: Movimentacao
    this_cNmOperacao    = ""
    this_cCodigo        = ""
    this_cDocumento     = ""

    *-- Filtros: Conta/Grupo contabil
    this_nOptConta      = 1
    this_cContas        = ""
    this_cDContas       = ""
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtros: Observacao
    this_cObses         = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO de pesquisa de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega empresa padrao e sua descricao.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco Init() do legado SIGRECSP que carrega SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRec")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpRec
                    IF !EOF()
                        THIS.this_cDEmpresa = ALLTRIM(cursor_4c_EmpRec.Razas)
                    ENDIF
                    USE IN cursor_4c_EmpRec
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal em SigMvCab com os filtros
    * definidos nas propriedades this_*. Popula cursor_4c_SigReCsp.
    * Equivalente ao metodo 'processamento' do form legado SIGRECSP.
    * NOTA: filtro de acesso por operacao (fAcessoMovmto) nao replicado -
    * funcao legada de controle de acesso nao existe no novo sistema.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cOpCta, loc_cOpGru, loc_dDtI, loc_dDtF, loc_cDtFSQL
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir o dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Colunas de Conta/Grupo dependem de OptConta:
            *-- 1=Origem -> ContaOs/GrupoOs | 2=Destino -> ContaDs/GrupoDs
            IF THIS.this_nOptConta = 1
                loc_cOpCta = "ContaOs"
                loc_cOpGru = "GrupoOs"
            ELSE
                loc_cOpCta = "ContaDs"
                loc_cOpGru = "GrupoDs"
            ENDIF

            *-- Construir clausula WHERE adicional
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cNmOperacao))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNmOperacao))
            ENDIF

            *-- numes e NUMERIC(6,0) - nao usar aspas, apenas o valor numerico
            IF !EMPTY(ALLTRIM(THIS.this_cCodigo))
                loc_cWhere = loc_cWhere + ;
                    " AND a.numes = " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cDocumento))
                loc_cWhere = loc_cWhere + ;
                    " AND a.notas = " + EscaparSQL(ALLTRIM(THIS.this_cDocumento))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrupos))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpGru + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrupos))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cContas))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpCta + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cContas))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cObses))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Obses LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(THIS.this_cObses) + "%")
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigMvCab com campos do grid original
            loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.notas," + ;
                " a.datars, a.empdopnums, a.operadors, a.usulibs," + ;
                " ISNULL(CONVERT(VARCHAR(250), a.Obses), '') AS Obses" + ;
                " FROM SigMvCab a" + ;
                " WHERE a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.EmpDopNums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de opera" + ;
                    CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ELSE
                SELECT (THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de cursor de configuracao.
    * Util para "ultimo filtro usado" sem quebrar quando o schema evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        TRY
            loc_lValido = !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            IF !loc_lValido
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel"
            ENDIF
            IF loc_lValido
                SELECT (par_cAliasCursor)
                loc_lValido = !EOF()
                IF !loc_lValido
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
            IF loc_lValido
                IF TYPE(par_cAliasCursor + ".c_empresa") = "C"
                    THIS.this_cEmpresa    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_empresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dempresa") = "C"
                    THIS.this_cDEmpresa   = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dempresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_inicial") = "D"
                    THIS.this_dDtInicial  = EVALUATE(par_cAliasCursor + ".d_inicial")
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_final") = "D"
                    THIS.this_dDtFinal    = EVALUATE(par_cAliasCursor + ".d_final")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_operacao") = "C"
                    THIS.this_cNmOperacao = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_operacao"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_codigo") = "C"
                    THIS.this_cCodigo     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_codigo"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_documento") = "C"
                    THIS.this_cDocumento  = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_documento"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".n_optconta") = "N"
                    THIS.this_nOptConta   = EVALUATE(par_cAliasCursor + ".n_optconta")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_contas") = "C"
                    THIS.this_cContas     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_contas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dcontas") = "C"
                    THIS.this_cDContas    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dcontas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_grupos") = "C"
                    THIS.this_cGrupos     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_grupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dgrupos") = "C"
                    THIS.this_cDGrupos    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dgrupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_obses") = "C"
                    THIS.this_cObses      = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_obses"))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Pesquisa nao tem chave primaria para persistencia.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro.
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_EmpRec")
            USE IN cursor_4c_EmpRec
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

