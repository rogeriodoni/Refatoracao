# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, CODIGOS, MERCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, CODIGOS, MERCS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LINHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PCESCOLHA, CODIGOS, MERCS

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
  ControlSource = "crSigCdGpr.Matprincs"
  ControlSource = "crSigCdGpr.codigos"
  ControlSource = "crSigCdGpr.descs"
  ControlSource = "crSigCdGpr.PesEnvs"
  ControlSource = "crSigCdGpr.nChkObjs"
  ControlSource = "crSigCdGpr.Barrefs"
  ControlSource = "crSigCdGpr.CodConPads"
  ControlSource = "crSigCdGpr.AplicFlhs"
  ControlSource = "crSigCdGpr.cpqtds"
  ControlSource = "crSigCdGpr.digauts"
  ControlSource = "crSigCdGpr.Fchcxs"
  ControlSource = "crSigCdGpr.AltEtiqs"
  ControlSource = "crSigCdGpr.linhas"
  ControlSource = "crSigCdGpr.priors"
	Select CrSigCdGpr

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formgpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1986 linhas total):

*-- Linhas 333 a 351:
333:             .HighlightBackColor = RGB(255, 255, 255)
334:             .HighlightForeColor = RGB(15, 41, 104)
335:             .HighlightStyle     = 2
336:             .DeleteMark         = .F.
337:             .RecordMark         = .F.
338:             .RowHeight          = 16
339:             .ScrollBars         = 2
340:             .GridLines          = 3
341:             .ReadOnly           = .T.
342:             .Visible            = .T.
343:         ENDWITH
344:         loc_oPagina.grd_4c_Lista.Column1.Width = 79
345:         loc_oPagina.grd_4c_Lista.Column2.Width = 290
346:         loc_oPagina.grd_4c_Lista.Column3.Width = 80
347: 
348:         THIS.TornarControlesVisiveis(loc_oPagina)
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------

*-- Linhas 1108 a 1128:
1108:                     IF loc_lResultado AND USED("cursor_4c_Dados")
1109:                         loc_oGrid.ColumnCount = 3
1110:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
1111:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1112:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1113:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.linhas"
1114:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1115:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1116:                         loc_oGrid.Column3.Header1.Caption = "Linhas"
1117:                         THIS.FormatarGridLista(loc_oGrid)
1118:                         loc_oGrid.Refresh()
1119:                     ENDIF
1120:                 ENDIF
1121:             CATCH TO loException
1122:                 MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
1123:                             "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1124:                             loException.Message, "Formgpr.CarregarLista")
1125:                 loc_lResultado = .F.
1126:             ENDTRY
1127:         ENDIF
1128: 

*-- Linhas 1230 a 1248:
1230:                 ENDIF
1231: 
1232:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1233:                     SELECT cursor_4c_BuscaProd
1234:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1235:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1236:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1237:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1238:                 ELSE
1239:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1240:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1241:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1242:                     ENDIF
1243:                 ENDIF
1244: 
1245:                 loc_oBusca.Release()
1246:             ENDIF
1247:         CATCH TO loException
1248:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupCodConPads")

*-- Linhas 1287 a 1305:
1287:                 ENDIF
1288: 
1289:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1290:                     SELECT cursor_4c_BuscaProd
1291:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1292:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1293:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1294:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1295:                 ELSE
1296:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1297:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1298:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1299:                     ENDIF
1300:                 ENDIF
1301: 
1302:                 loc_oBusca.Release()
1303:             ENDIF
1304:         CATCH TO loException
1305:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDCodConPads")

*-- Linhas 1344 a 1362:
1344:                 ENDIF
1345: 
1346:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1347:                     SELECT cursor_4c_BuscaLin
1348:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1349:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1350:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1351:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1352:                 ELSE
1353:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1354:                     loc_oPg2.txt_4c_Lin.Value  = ""
1355:                     loc_oPg2.txt_4c_DLin.Value = ""
1356:                     ENDIF
1357:                 ENDIF
1358: 
1359:                 loc_oBusca.Release()
1360:             ENDIF
1361:         CATCH TO loException
1362:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupLin")

*-- Linhas 1401 a 1419:
1401:                 ENDIF
1402: 
1403:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1404:                     SELECT cursor_4c_BuscaLin
1405:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1406:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1407:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1408:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1409:                 ELSE
1410:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1411:                     loc_oPg2.txt_4c_Lin.Value  = ""
1412:                     loc_oPg2.txt_4c_DLin.Value = ""
1413:                     ENDIF
1414:                 ENDIF
1415: 
1416:                 loc_oBusca.Release()
1417:             ENDIF
1418:         CATCH TO loException
1419:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDLin")

*-- Linhas 1454 a 1479:
1454:                 ENDIF
1455: 
1456:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatPrincs")
1457:                     SELECT cursor_4c_BuscaMatPrincs
1458:                     loc_cCod = ALLTRIM(cursor_4c_BuscaMatPrincs.CPros)
1459: 
1460:                     *-- Verificar Varias (produto deve ter peso variavel = 1)
1461:                     loc_nVarias = 0
1462:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1463:                         loc_cSql = "SELECT Varias FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
1464:                         loc_nRetSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_VariasPro")
1465:                         IF loc_nRetSql > 0 AND USED("cursor_4c_VariasPro") AND !EOF("cursor_4c_VariasPro")
1466:                             loc_nVarias = cursor_4c_VariasPro.Varias
1467:                         ENDIF
1468:                         IF USED("cursor_4c_VariasPro")
1469:                             USE IN cursor_4c_VariasPro
1470:                         ENDIF
1471:                     ENDIF
1472: 
1473:                     IF loc_nVarias <> 1
1474:                         MsgAviso("Este Produto n" + CHR(227) + "o est" + CHR(225) + ;
1475:                                  " Configurado para Peso Vari" + CHR(225) + "vel!!!", ;
1476:                                  "Selecionar Material Principal")
1477:                         loc_oPg2.txt_4c_MatPrincs.Value = ""
1478:                     ELSE
1479:                         loc_oPg2.txt_4c_MatPrincs.Value = loc_cCod

*-- Linhas 1587 a 1621:
1587:             *-- Buscar descricao do CodConPads (DPros de SigCdPro)
1588:             loc_oPg2.txt_4c_DCodConPads.Value = ""
1589:             IF !EMPTY(loc_oBO.this_cCodConPads) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1590:                 loc_cSql = "SELECT DPros FROM SigCdPro WHERE CPros = " + ;
1591:                             EscaparSQL(ALLTRIM(loc_oBO.this_cCodConPads))
1592:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescPro")
1593:                 IF loc_nRet > 0 AND USED("cursor_4c_DescPro") AND !EOF("cursor_4c_DescPro")
1594:                     loc_oPg2.txt_4c_DCodConPads.Value = ALLTRIM(cursor_4c_DescPro.DPros)
1595:                 ENDIF
1596:                 IF USED("cursor_4c_DescPro")
1597:                     USE IN cursor_4c_DescPro
1598:                 ENDIF
1599:             ENDIF
1600: 
1601:             *-- Buscar descricao da Linha (Descs de SigCdLin)
1602:             loc_oPg2.txt_4c_DLin.Value = ""
1603:             IF !EMPTY(loc_oBO.this_cLinhas) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1604:                 loc_cSql = "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
1605:                             EscaparSQL(ALLTRIM(loc_oBO.this_cLinhas))
1606:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescLin")
1607:                 IF loc_nRet > 0 AND USED("cursor_4c_DescLin") AND !EOF("cursor_4c_DescLin")
1608:                     loc_oPg2.txt_4c_DLin.Value = ALLTRIM(cursor_4c_DescLin.Descs)
1609:                 ENDIF
1610:                 IF USED("cursor_4c_DescLin")
1611:                     USE IN cursor_4c_DescLin
1612:                 ENDIF
1613:             ENDIF
1614: 
1615:             *-- OptionGroups (Value=1=Sim, Value=2=Nao)
1616:             *-- Bloquear Etiqueta Individual: DB 0=Sim, DB 1=Nao
1617:             loc_oPg2.opt_4c_BlqEtq.Value    = IIF(loc_oBO.this_nBarrefs = 0, 1, 2)
1618:             *-- Permite Alterar Dados da Etiqueta: DB 0=Sim, DB 1=Nao
1619:             loc_oPg2.opt_4c_AlteEtiq.Value  = IIF(loc_oBO.this_nAltetiqs = 0, 1, 2)
1620:             *-- Controla por Qtde: DB 0=Sim, DB 1=Nao
1621:             loc_oPg2.opt_4c_Cpq.Value       = IIF(loc_oBO.this_nCpqtds = 0, 1, 2)

*-- Linhas 1741 a 1760:
1741:                 .GridLineColor   = RGB(200, 200, 200)
1742:                 .HeaderHeight    = 22
1743:                 .RowHeight       = 20
1744:                 .AllowCellSelection = .F.
1745:                 .DeleteMark      = .F.
1746:                 .RecordMark      = .F.
1747:                 .ReadOnly        = .T.
1748: 
1749:                 WITH .Column1
1750:                     .Width   = 60
1751:                     .Alignment = 2
1752:                     .Header1.FontBold = .T.
1753:                 ENDWITH
1754:                 WITH .Column2
1755:                     .Width   = 300
1756:                     .Header1.FontBold = .T.
1757:                 ENDWITH
1758:                 WITH .Column3
1759:                     .Width   = 200
1760:                     .Header1.FontBold = .T.

*-- Linhas 1798 a 1816:
1798:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1799:                 MsgAviso("Selecione um registro para alterar.", "Alterar")
1800:             ELSE
1801:                 SELECT cursor_4c_Dados
1802:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1803:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1804:                     THIS.this_oBusinessObject.EditarRegistro()
1805:                     THIS.BOParaForm()
1806:                     THIS.this_cModoAtual = "ALTERAR"
1807:                     THIS.HabilitarCampos(.T.)
1808:                     THIS.AjustarBotoesPorModo("EDICAO")
1809:                     THIS.AlternarPagina(2)
1810:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
1811:                     loc_lResultado = .T.
1812:                 ENDIF
1813:             ENDIF
1814:         CATCH TO loException
1815:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Formgpr.BtnAlterarClick")
1816:         ENDTRY

*-- Linhas 1827 a 1845:
1827:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1828:                 MsgAviso("Selecione um registro para visualizar.", "Visualizar")
1829:             ELSE
1830:                 SELECT cursor_4c_Dados
1831:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1832:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1833:                     THIS.BOParaForm()
1834:                     THIS.this_cModoAtual = "VISUALIZAR"
1835:                     THIS.HabilitarCampos(.F.)
1836:                     THIS.AjustarBotoesPorModo("NORMAL")
1837:                     THIS.AlternarPagina(2)
1838:                     loc_lResultado = .T.
1839:                 ENDIF
1840:             ENDIF
1841:         CATCH TO loException
1842:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Formgpr.BtnVisualizarClick")
1843:         ENDTRY
1844:         RETURN loc_lResultado
1845:     ENDPROC

*-- Linhas 1854 a 1872:
1854:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1855:                 MsgAviso("Selecione um registro para excluir.", "Excluir")
1856:             ELSE
1857:                 SELECT cursor_4c_Dados
1858:                 loc_cCodigo  = ALLTRIM(cursor_4c_Dados.codigos)
1859:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do grande grupo '" + ;
1860:                                             loc_cCodigo + "'?", "Excluir")
1861:                 IF loc_lConfirma
1862:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1863:                         IF THIS.this_oBusinessObject.Excluir()
1864:                             MsgInfo("Grande grupo exclu" + CHR(237) + "do com sucesso.", "Excluir")
1865:                             THIS.CarregarLista()
1866:                         ENDIF
1867:                     ENDIF
1868:                     loc_lResultado = .T.
1869:                 ENDIF
1870:             ENDIF
1871:         CATCH TO loException
1872:             MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Formgpr.BtnExcluirClick")

*-- Linhas 1883 a 1918:
1883:         TRY
1884:             loc_cCodigo = ""
1885:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1886:                 SELECT cursor_4c_Dados
1887:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1888:             ENDIF
1889: 
1890:             LOCAL loc_oBusca
1891:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1892:                 "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", loc_cCodigo, ;
1893:                 "Buscar Grande Grupo")
1894: 
1895:             IF VARTYPE(loc_oBusca) = "O"
1896:                 IF !loc_oBusca.this_lAchouRegistro
1897:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1898:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1899:                     loc_oBusca.Show()
1900:                 ENDIF
1901: 
1902:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
1903:                     SELECT cursor_4c_BuscaGpr
1904:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGpr.codigos)
1905:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1906:                         THIS.BOParaForm()
1907:                         THIS.this_cModoAtual = "VISUALIZAR"
1908:                         THIS.HabilitarCampos(.F.)
1909:                         THIS.AjustarBotoesPorModo("NORMAL")
1910:                         THIS.AlternarPagina(2)
1911:                     ENDIF
1912:                     loc_lResultado = .T.
1913:                 ENDIF
1914: 
1915:                 loc_oBusca.Release()
1916:             ENDIF
1917:         CATCH TO loException
1918:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Formgpr.BtnBuscarClick")


### BO (C:\4c\projeto\app\classes\gprBO.prg):
*==============================================================================
* gprBO.prg
*
* Business Object para Grande Grupo de Produto (SigCdGpr)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS gprBO AS BusinessBase

    *-- Propriedades da tabela SigCdGpr
    this_cCodigos     = ""    && codigos    char(3)      PK
    this_cDescs       = ""    && descs      char(40)
    this_cCodConPads  = ""    && codconpads char(14)     Produto Padrao de Conserto
    this_cMatPrincs   = ""    && matprincs  char(14)     Material Principal
    this_nCpqtds      = 0     && cpqtds     numeric(1,0) Controla por Qtde
    this_cDigauts     = ""    && digauts    char(1)      Digito Codigo Automatico
    this_nIds         = 0     && ids        numeric(10,0)
    this_nAplicflhs   = 0     && aplicflhs  numeric(1,0) Aplica Falha Admitida
    this_nBarrefs     = 0     && barrefs    numeric(1,0) Bloquear Alteracao Etiqueta Individual
    this_nDigbars     = 0     && digbars    numeric(1,0)
    this_nPesenvs     = 0     && pesenvs    numeric(1,0) OF Obrigatorio na Pesagem
    this_cLinhas      = ""    && linhas     char(10)     Linha Padrao de Cadastro
    this_nFchcxs      = 0     && fchcxs     numeric(1,0)
    this_nPriors      = 0     && priors     numeric(1,0) Prioridade Recalculo Saldo
    this_nAltetiqs    = 0     && altetiqs   numeric(1,0) Permite Alterar Dados Etiqueta
    this_nNchkobjs    = 0     && nchkobjs   numeric(1,0)
    this_nProdecomm   = 0     && prodecomm  numeric(1,0)

    *-- Campos de exibicao (nao persistidos na tabela)
    this_cDescConPads = ""    && Descricao do Produto Padrao de Conserto (SigCdPro.DPros)
    this_cDescLin     = ""    && Descricao da Linha Padrao (SigCdLin.Descs)

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdGpr"
            THIS.this_cCampoChave = "codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "gprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigos)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(THIS.this_nPriors, 0, 1)
            MsgAviso("Prioridade Inv" + CHR(225) + "lida!!! Use 0 ou 1.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se codigos ja existe em SigCdGpr
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGpr" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "gprBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos     = TratarNulo(codigos,    "C")
                THIS.this_cDescs       = TratarNulo(descs,      "C")
                THIS.this_cCodConPads  = TratarNulo(CodConPads, "C")
                THIS.this_cMatPrincs   = TratarNulo(Matprincs,  "C")
                THIS.this_nCpqtds      = TratarNulo(cpqtds,     "N")
                THIS.this_cDigauts     = TratarNulo(digauts,    "C")
                THIS.this_nIds         = TratarNulo(ids,        "N")
                THIS.this_nAplicflhs   = TratarNulo(AplicFlhs,  "N")
                THIS.this_nBarrefs     = TratarNulo(Barrefs,    "N")
                THIS.this_nDigbars     = TratarNulo(digbars,    "N")
                THIS.this_nPesenvs     = TratarNulo(PesEnvs,    "N")
                THIS.this_cLinhas      = TratarNulo(linhas,     "C")
                THIS.this_nFchcxs      = TratarNulo(Fchcxs,     "N")
                THIS.this_nPriors      = TratarNulo(priors,     "N")
                THIS.this_nAltetiqs    = TratarNulo(AltEtiqs,   "N")
                THIS.this_nNchkobjs    = TratarNulo(nChkObjs,   "N")
                THIS.this_nProdecomm   = TratarNulo(prodecomm,  "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "gprBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdGpr (codigos, descs, CodConPads, Matprincs,
                    cpqtds, digauts, AplicFlhs, Barrefs, PesEnvs,
                    linhas, priors, AltEtiqs, nChkObjs, Fchcxs, digbars, prodecomm)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodConPads)>>,
                    <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    <<EscaparSQL(THIS.this_cDigauts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    <<EscaparSQL(THIS.this_cLinhas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "gprBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdGpr
                SET descs      = <<EscaparSQL(THIS.this_cDescs)>>,
                    CodConPads = <<EscaparSQL(THIS.this_cCodConPads)>>,
                    Matprincs  = <<EscaparSQL(THIS.this_cMatPrincs)>>,
                    cpqtds     = <<FormatarNumeroSQL(THIS.this_nCpqtds, 0)>>,
                    digauts    = <<EscaparSQL(THIS.this_cDigauts)>>,
                    AplicFlhs  = <<FormatarNumeroSQL(THIS.this_nAplicflhs, 0)>>,
                    Barrefs    = <<FormatarNumeroSQL(THIS.this_nBarrefs, 0)>>,
                    PesEnvs    = <<FormatarNumeroSQL(THIS.this_nPesenvs, 0)>>,
                    linhas     = <<EscaparSQL(THIS.this_cLinhas)>>,
                    priors     = <<FormatarNumeroSQL(THIS.this_nPriors, 0)>>,
                    AltEtiqs   = <<FormatarNumeroSQL(THIS.this_nAltetiqs, 0)>>,
                    nChkObjs   = <<FormatarNumeroSQL(THIS.this_nNchkobjs, 0)>>,
                    Fchcxs     = <<FormatarNumeroSQL(THIS.this_nFchcxs, 0)>>,
                    digbars    = <<FormatarNumeroSQL(THIS.this_nDigbars, 0)>>,
                    prodecomm  = <<FormatarNumeroSQL(THIS.this_nProdecomm, 0)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "gprBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdGpr
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGpr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "gprBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descs, linhas (colunas do grid)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(3), descs C(40), linhas C(10))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descs, a.linhas FROM SigCdGpr a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grandes grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "gprBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descs, a.CodConPads, a.Matprincs," + ;
                " a.cpqtds, a.digauts, a.ids, a.AplicFlhs, a.Barrefs," + ;
                " a.digbars, a.PesEnvs, a.linhas, a.Fchcxs, a.priors," + ;
                " a.AltEtiqs, a.nChkObjs, a.prodecomm" + ;
                " FROM SigCdGpr a WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grande grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "gprBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

