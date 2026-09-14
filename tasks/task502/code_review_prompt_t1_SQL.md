# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRICAOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNI, NTPIMPRES, PCESCOLHA, ETIQUETAS, I, LNVEZES, LCCOL, CODIGOS

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
  ControlSource = "crSigPrLcl.descricaos"
  ControlSource = "crSigPrLcl.Divisaos"
  ControlSource = "crSigPrLcl.Bloqueios"
  ControlSource = "crSigPrLcl.codigos"
  ControlSource = "crSigPrLcl.Tipos"
  ControlSource = "crSigPrLcl.etiquetas"
Select LocalCImp
	Select LocalCImp
lcQuery = [Select Codigos, Descricaos ] + ;
		    [From SigPrLcl ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crBusca') < 1)
Select crBusca
	If Not Seek(This.Value, 'crBusca', 'Codigos')
		Insert Into LocalPrLoc (Codigos) Values (lcCod)
Insert Into LocalPrLoc (Codigos) Values ('*FIM*')
	Select LocalPrLoc

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormPrl.prg) - TRECHOS RELEVANTES PARA PASS SQL (1910 linhas total):

*-- Linhas 348 a 366:
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         *-- Definir colunas FORA de WITH para que existam imediatamente
360:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
361: 
362:         WITH loc_oPagina.grd_4c_Lista.Column1
363:             .Width               = 100
364:             .Alignment           = 0
365:             .Header1.Caption     = "C" + CHR(243) + "digo"
366:         ENDWITH

*-- Linhas 736 a 755:
736:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
737:                     loc_oGrid.ColumnCount  = 2
738: 
739:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
740:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
741:                     loc_oGrid.Column1.Width          = 100
742:                     loc_oGrid.Column2.Width          = 290
743:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
744:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
745: 
746:                     THIS.FormatarGridLista(loc_oGrid)
747:                     loc_lResultado = .T.
748:                 ELSE
749:                     loc_lResultado = .F.
750:                 ENDIF
751:             ENDIF
752:         CATCH TO loc_oErro
753:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
754:             loc_lResultado = .F.
755:         ENDTRY

*-- Linhas 814 a 832:
814:         loc_cCodigo = ""
815: 
816:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
817:             SELECT cursor_4c_Dados
818:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
819:         ENDIF
820: 
821:         IF EMPTY(loc_cCodigo)
822:             MsgAviso("Selecione um registro na lista.", "Visualizar")
823:             RETURN
824:         ENDIF
825: 
826:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
827:             THIS.this_cModoAtual = "VISUALIZAR"
828:             THIS.BOParaForm()
829:             THIS.HabilitarCampos(.F.)
830:             THIS.AjustarBotoesPorModo()
831:             THIS.AlternarPagina(2)
832: 

*-- Linhas 850 a 868:
850:         loc_cCodigo = ""
851: 
852:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
853:             SELECT cursor_4c_Dados
854:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
855:         ENDIF
856: 
857:         IF EMPTY(loc_cCodigo)
858:             MsgAviso("Selecione um registro na lista.", "Alterar")
859:             RETURN
860:         ENDIF
861: 
862:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
863:             THIS.this_oBusinessObject.EditarRegistro()
864:             THIS.this_cModoAtual = "ALTERAR"
865:             THIS.BOParaForm()
866:             THIS.HabilitarCampos(.T.)
867:             THIS.AjustarBotoesPorModo()
868:             THIS.AlternarPagina(2)

*-- Linhas 886 a 904:
886:         loc_cDescricao = ""
887: 
888:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
889:             SELECT cursor_4c_Dados
890:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
891:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
892:         ENDIF
893: 
894:         IF EMPTY(loc_cCodigo)
895:             MsgAviso("Selecione um registro na lista.", "Excluir")
896:             RETURN
897:         ENDIF
898: 
899:         IF MsgConfirma("Excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
900:                        loc_cCodigo + " - " + loc_cDescricao + "?", "Excluir")
901:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
902:                 IF THIS.this_oBusinessObject.Excluir()
903:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
904:                     THIS.CarregarLista()

*-- Linhas 926 a 958:
926: 
927:         TRY
928:             IF !EMPTY(ALLTRIM(loc_cBusca))
929:                 loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
930:                            " FROM SigPrLcl" + ;
931:                            " WHERE codigos LIKE " + EscaparSQL(ALLTRIM(loc_cBusca) + "%") + ;
932:                            " OR descricaos LIKE " + EscaparSQL("%" + ALLTRIM(loc_cBusca) + "%") + ;
933:                            " ORDER BY codigos"
934: 
935:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
936: 
937:                 IF loc_nResult >= 0
938:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
939:                     loc_oGrid.ColumnCount = 2
940:                     loc_oGrid.RecordSource    = "cursor_4c_Dados"
941:                     loc_oGrid.ColumnCount     = 2
942:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
943:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.descricaos"
944:                     loc_oGrid.Column1.Width          = 100
945:                     loc_oGrid.Column2.Width          = 290
946:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
947:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
948:                     THIS.FormatarGridLista(loc_oGrid)
949: 
950:                     IF RECCOUNT("cursor_4c_Dados") = 0
951:                         MsgAviso("Nenhum registro encontrado para '" + ALLTRIM(loc_cBusca) + "'.", "Buscar")
952:                     ENDIF
953:                 ELSE
954:                     MsgErro("Erro na busca:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
955:                 ENDIF
956:             ELSE
957:                 THIS.CarregarLista()
958:             ENDIF

*-- Linhas 1534 a 1569:
1534:             ASORT(laPrinters)
1535: 
1536:             *-- Parametros de etiquetas em SigCdPam
1537:             loc_cSQL    = "SELECT nMaxImpEti, AjVerts, AjHorzs FROM SigCdPam"
1538:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamEtq")
1539:             IF loc_nResult > 0 AND USED("cursor_4c_ParamEtq") AND RECCOUNT("cursor_4c_ParamEtq") > 0
1540:                 SELECT cursor_4c_ParamEtq
1541:                 loc_nMaxImpEti = IIF(ISNULL(cursor_4c_ParamEtq.nMaxImpEti), 3, cursor_4c_ParamEtq.nMaxImpEti)
1542:                 loc_nAjVerts   = IIF(ISNULL(cursor_4c_ParamEtq.AjVerts),    0, cursor_4c_ParamEtq.AjVerts)
1543:                 loc_nAjHorzs   = IIF(ISNULL(cursor_4c_ParamEtq.AjHorzs),    0, cursor_4c_ParamEtq.AjHorzs)
1544:             ENDIF
1545:             IF USED("cursor_4c_ParamEtq")
1546:                 USE IN cursor_4c_ParamEtq
1547:             ENDIF
1548: 
1549:             *-- Impressoras de etiquetas cadastradas em SigCdMp (nTpImpres=2)
1550:             loc_cSQL    = "SELECT Impres, nTpImpres FROM SigCdMp ORDER BY Impres"
1551:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdMpEtq")
1552:             loc_nImpres = 1
1553:             IF loc_nResult > 0 AND USED("cursor_4c_SigCdMpEtq") AND RECCOUNT("cursor_4c_SigCdMpEtq") > 0
1554:                 SELECT cursor_4c_SigCdMpEtq
1555:                 SCAN FOR cursor_4c_SigCdMpEtq.nTpImpres = 2
1556:                     loc_nOk = ASCAN(laPrinters, ALLTRIM(UPPER(cursor_4c_SigCdMpEtq.Impres)))
1557:                     IF loc_nOk > 0
1558:                         DIMENSION laImpOk(loc_nImpres)
1559:                         laImpOk(loc_nImpres) = laPrinters(loc_nOk)
1560:                         loc_nImpres = loc_nImpres + 1
1561:                     ENDIF
1562:                 ENDSCAN
1563:             ENDIF
1564:             IF USED("cursor_4c_SigCdMpEtq")
1565:                 USE IN cursor_4c_SigCdMpEtq
1566:             ENDIF
1567:             loc_nImpres = loc_nImpres - 1
1568: 
1569:             *-- Popular OptionGroup de impressoras dinamicamente

*-- Linhas 1645 a 1668:
1645:                 loc_cValor = ALLTRIM(loc_oTxt.Value)
1646: 
1647:                 IF !EMPTY(loc_cValor)
1648:                     loc_cSQL    = "SELECT TOP 1 Codigos FROM SigPrLcl" + ;
1649:                                   " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cValor)
1650:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidEtq")
1651: 
1652:                     IF loc_nResult > 0 AND USED("cursor_4c_ValidEtq") AND RECCOUNT("cursor_4c_ValidEtq") > 0
1653:                         SELECT cursor_4c_ValidEtq
1654:                         loc_cEncontrado = ALLTRIM(cursor_4c_ValidEtq.Codigos)
1655:                     ELSE
1656:                         IF USED("cursor_4c_ValidEtq")
1657:                             USE IN cursor_4c_ValidEtq
1658:                         ENDIF
1659:                         loc_cEncontrado = THIS.AbrirBuscaCodigosEtq(loc_cValor)
1660:                     ENDIF
1661: 
1662:                     IF USED("cursor_4c_ValidEtq")
1663:                         USE IN cursor_4c_ValidEtq
1664:                     ENDIF
1665: 
1666:                     IF PEMSTATUS(loc_oTxt, "Value", 5)
1667:                         loc_oTxt.Value = loc_cEncontrado
1668:                     ENDIF

*-- Linhas 1683 a 1714:
1683: 
1684:         TRY
1685:             IF !EMPTY(ALLTRIM(par_cValor))
1686:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl" + ;
1687:                            " WHERE Etiquetas = 1 AND Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%") + ;
1688:                            " ORDER BY Codigos"
1689:             ELSE
1690:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1691:             ENDIF
1692: 
1693:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1694: 
1695:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst")
1696:                 IF RECCOUNT("cursor_4c_BuscaEtqLst") = 0
1697:                     USE IN cursor_4c_BuscaEtqLst
1698:                     loc_cSQL    = "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1699:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEtqLst")
1700:                 ENDIF
1701: 
1702:                 IF loc_nResult > 0 AND USED("cursor_4c_BuscaEtqLst") AND RECCOUNT("cursor_4c_BuscaEtqLst") > 0
1703:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1704:                     IF VARTYPE(loc_oBusca) = "O"
1705:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaEtqLst", "Codigos", "Descricaos", ;
1706:                                                  "Localiza" + CHR(231) + CHR(227) + "o")
1707:                         loc_oBusca.Mostrar()
1708:                         IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1709:                             loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1710:                         ENDIF
1711:                         loc_oBusca = .NULL.
1712:                     ENDIF
1713:                 ENDIF
1714: 

*-- Linhas 1754 a 1825:
1754:                 loc_nQtd = 1
1755:             ENDIF
1756: 
1757:             CREATE CURSOR cursor_4c_LocalPrLoc (Codigos C(10))
1758: 
1759:             IF EMPTY(loc_cCod)
1760:                 *-- Todas as localizacoes com etiqueta habilitada
1761:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl WHERE Etiquetas = 1 ORDER BY Codigos"
1762:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1763:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1764:                     SELECT cursor_4c_SrcPrLoc
1765:                     SCAN
1766:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (cursor_4c_SrcPrLoc.Codigos)
1767:                     ENDSCAN
1768:                     loc_lCursorOk = .T.
1769:                 ELSE
1770:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1771:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1772:                     loc_lProsseguir = .F.
1773:                 ENDIF
1774:                 IF USED("cursor_4c_SrcPrLoc")
1775:                     USE IN cursor_4c_SrcPrLoc
1776:                 ENDIF
1777:             ELSE
1778:                 *-- Codigo especifico: inserir lnQtd copias
1779:                 loc_cSQL    = "SELECT Codigos FROM SigPrLcl" + ;
1780:                               " WHERE Etiquetas = 1 AND Codigos = " + EscaparSQL(loc_cCod)
1781:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SrcPrLoc")
1782:                 IF loc_nResult > 0 AND USED("cursor_4c_SrcPrLoc") AND RECCOUNT("cursor_4c_SrcPrLoc") > 0
1783:                     IF USED("cursor_4c_SrcPrLoc")
1784:                         USE IN cursor_4c_SrcPrLoc
1785:                     ENDIF
1786:                     FOR loc_nI = 1 TO loc_nQtd
1787:                         INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES (loc_cCod)
1788:                     ENDFOR
1789:                     loc_nQtd      = 1
1790:                     loc_lCursorOk = .T.
1791:                 ELSE
1792:                     IF USED("cursor_4c_SrcPrLoc")
1793:                         USE IN cursor_4c_SrcPrLoc
1794:                     ENDIF
1795:                     MsgAviso("N" + CHR(227) + "o Existem Localiza" + CHR(231) + CHR(245) + "es a Serem Impressas!!!", ;
1796:                              "Aten" + CHR(231) + CHR(227) + "o!!!")
1797:                     loc_lProsseguir = .F.
1798:                 ENDIF
1799:             ENDIF
1800: 
1801:             IF loc_lProsseguir AND loc_lCursorOk
1802:                 INSERT INTO cursor_4c_LocalPrLoc (Codigos) VALUES ("*FIM*")
1803: 
1804:                 SET PRINTER TO NAME (loc_cImp)
1805:                 SET DEVICE TO PRINTER
1806:                 loc_lPrinterSet = .T.
1807: 
1808:                 FOR loc_nVezes = 1 TO loc_nQtd
1809:                     loc_nCnt = 1
1810:                     SELECT cursor_4c_LocalPrLoc
1811:                     GO TOP
1812:                     SCAN
1813:                         IF loc_nCnt = 1
1814:                             ??? CHR(02) + "L" + CHR(13)
1815:                             ??? "H" + ALLTRIM(STR(loc_nDen)) + CHR(13)
1816:                             ??? "D11" + CHR(13)
1817:                         ENDIF
1818: 
1819:                         DO CASE
1820:                             CASE loc_nTip = 1
1821:                                 loc_nInc = (85 * loc_nCnt) - 85
1822:                                 IF ALLTRIM(cursor_4c_LocalPrLoc.Codigos) <> "*FIM*"
1823:                                     loc_nLin = 15 + loc_nHor
1824:                                     loc_nCol = 10 + loc_nVer + loc_nInc
1825:                                     ??? "1e42034" + PADL(loc_nLin, 4, "0") + PADL(loc_nCol, 4, "0") + "B" + PADR(cursor_4c_LocalPrLoc.Codigos, 3) + CHR(13)


### BO (C:\4c\projeto\app\classes\PrlBO.prg):
*==============================================================================
* PrlBO.prg - Business Object para Cadastro de Localizacao
* Tabela: SigPrLcl
* Herdado de: BusinessBase
*==============================================================================

DEFINE CLASS PrlBO AS BusinessBase

    *-- Propriedades da tabela SigPrLcl
    this_cCodigos    = ""   && codigos char(10) PK
    this_cDescricaos = ""   && descricaos char(20)
    this_nTipos      = 0    && tipos numeric(1,0): 1=Produto 2=Agendamento 3=Deposito
    this_nEtiquetas  = 0    && etiquetas numeric(1,0): 0=Nao 1=Sim
    this_nBloqueios  = 0    && bloqueios numeric(2,0)
    this_nDivisaos   = 0    && divisaos numeric(2,0)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrLcl"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK atual para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT todos os registros (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, etiquetas" + ;
                       " FROM SigPrLcl" + ;
                       " ORDER BY codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo PK (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, tipos, etiquetas, bloqueios, divisaos" + ;
                       " FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = TratarNulo(codigos,    "C")
            THIS.this_cDescricaos = TratarNulo(descricaos, "C")
            THIS.this_nTipos      = TratarNulo(tipos,      "N")
            THIS.this_nEtiquetas  = TratarNulo(etiquetas,  "N")
            THIS.this_nBloqueios  = TratarNulo(bloqueios,  "N")
            THIS.this_nDivisaos   = TratarNulo(divisaos,   "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrLcl" + ;
                       " (codigos, descricaos, tipos, etiquetas, bloqueios, divisaos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)         + ", " + ;
                       EscaparSQL(THIS.this_cDescricaos)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos)     + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEtiquetas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBloqueios) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nDivisaos)  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrLcl SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricaos)      + "," + ;
                       " tipos      = " + FormatarNumeroSQL(THIS.this_nTipos)     + "," + ;
                       " etiquetas  = " + FormatarNumeroSQL(THIS.this_nEtiquetas) + "," + ;
                       " bloqueios  = " + FormatarNumeroSQL(THIS.this_nBloqueios) + "," + ;
                       " divisaos   = " + FormatarNumeroSQL(THIS.this_nDivisaos)  + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigPrLcl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida regras de negocio antes de salvar (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        *-- Localizacao invalida (descricao vazia)
        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Localiza" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        *-- Para etiqueta, codigo deve ter no maximo 3 caracteres
        IF loc_lResultado AND THIS.this_nEtiquetas = 1 AND LEN(ALLTRIM(THIS.this_cCodigos)) > 3
            MsgAviso("Para Impress" + CHR(227) + "o de Etiquetas o C" + CHR(243) + "digo Deve Ter no M" + CHR(225) + "ximo 3 Caracteres!!!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarEtiquetas - Retorna localizacoes com etiqueta habilitada (PUBLIC por padrao)
    * Usado pelo painel de impressao de etiquetas (cntEtiquetas)
    *--------------------------------------------------------------------------
    FUNCTION BuscarEtiquetas(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE etiquetas = 1" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE codigos = " + EscaparSQL(PADR(par_cCodigo, 6))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Etiquetas")
                TABLEREVERT(.T., "cursor_4c_Etiquetas")
                USE IN cursor_4c_Etiquetas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiquetas")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar etiquetas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar etiquetas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoExiste - Verifica se codigo ja cadastrado (PUBLIC por padrao)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoExiste(par_cCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT codigos FROM SigPrLcl" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkCod")
                TABLEREVERT(.T., "cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkCod") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarCodigo - Gera proximo codigo unico para SigPrLcl (PUBLIC por padrao)
    * Equivalente a Padl(fGerUniqueKey([SigPrLcl]), 10, [0]) do legado
    *--------------------------------------------------------------------------
    FUNCTION GerarCodigo()
        LOCAL loc_cNovoCodigo, loc_cSQL, loc_nResult
        loc_cNovoCodigo = ""

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CASE WHEN ISNUMERIC(LTRIM(RTRIM(codigos))) = 1" + ;
                       " THEN CAST(LTRIM(RTRIM(codigos)) AS INT) ELSE 0 END), 0) + 1 AS proximo" + ;
                       " FROM SigPrLcl"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_GerarCod")
                TABLEREVERT(.T., "cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = PADL(ALLTRIM(STR(cursor_4c_GerarCod.proximo)), 10, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cNovoCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Etiquetas")
            USE IN cursor_4c_Etiquetas
        ENDIF
        IF USED("cursor_4c_ChkCod")
            USE IN cursor_4c_ChkCod
        ENDIF
        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

