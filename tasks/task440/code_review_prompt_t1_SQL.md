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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (1949 linhas total):

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

*-- Linhas 1221 a 1239:
1221:                 ENDIF
1222: 
1223:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1224:                     SELECT cursor_4c_BuscaProd
1225:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1226:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1227:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1228:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1229:                 ELSE
1230:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1231:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1232:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1233:                     ENDIF
1234:                 ENDIF
1235: 
1236:                 loc_oBusca.Release()
1237:             ENDIF
1238:         CATCH TO loException
1239:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupCodConPads")

*-- Linhas 1271 a 1289:
1271:                 ENDIF
1272: 
1273:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1274:                     SELECT cursor_4c_BuscaProd
1275:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaProd.CPros)
1276:                     loc_cDesc   = ALLTRIM(cursor_4c_BuscaProd.DPros)
1277:                     loc_oPg2.txt_4c_CodConPads.Value  = loc_cCodigo
1278:                     loc_oPg2.txt_4c_DCodConPads.Value = loc_cDesc
1279:                 ELSE
1280:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1281:                     loc_oPg2.txt_4c_CodConPads.Value  = ""
1282:                     loc_oPg2.txt_4c_DCodConPads.Value = ""
1283:                     ENDIF
1284:                 ENDIF
1285: 
1286:                 loc_oBusca.Release()
1287:             ENDIF
1288:         CATCH TO loException
1289:             MostrarErro("Erro no lookup produto:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDCodConPads")

*-- Linhas 1321 a 1339:
1321:                 ENDIF
1322: 
1323:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1324:                     SELECT cursor_4c_BuscaLin
1325:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1326:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1327:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1328:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1329:                 ELSE
1330:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1331:                     loc_oPg2.txt_4c_Lin.Value  = ""
1332:                     loc_oPg2.txt_4c_DLin.Value = ""
1333:                     ENDIF
1334:                 ENDIF
1335: 
1336:                 loc_oBusca.Release()
1337:             ENDIF
1338:         CATCH TO loException
1339:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupLin")

*-- Linhas 1371 a 1389:
1371:                 ENDIF
1372: 
1373:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
1374:                     SELECT cursor_4c_BuscaLin
1375:                     loc_cCod  = ALLTRIM(cursor_4c_BuscaLin.Linhas)
1376:                     loc_cDesc = ALLTRIM(cursor_4c_BuscaLin.Descs)
1377:                     loc_oPg2.txt_4c_Lin.Value  = loc_cCod
1378:                     loc_oPg2.txt_4c_DLin.Value = loc_cDesc
1379:                 ELSE
1380:                     IF !loc_oBusca.this_lSelecionou AND !loc_oBusca.this_lAchouRegistro
1381:                     loc_oPg2.txt_4c_Lin.Value  = ""
1382:                     loc_oPg2.txt_4c_DLin.Value = ""
1383:                     ENDIF
1384:                 ENDIF
1385: 
1386:                 loc_oBusca.Release()
1387:             ENDIF
1388:         CATCH TO loException
1389:             MostrarErro("Erro no lookup linha:" + CHR(13) + loException.Message, "Formgpr.AbrirLookupDLin")

*-- Linhas 1424 a 1449:
1424:                 ENDIF
1425: 
1426:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatPrincs")
1427:                     SELECT cursor_4c_BuscaMatPrincs
1428:                     loc_cCod = ALLTRIM(cursor_4c_BuscaMatPrincs.CPros)
1429: 
1430:                     *-- Verificar Varias (produto deve ter peso variavel = 1)
1431:                     loc_nVarias = 0
1432:                     IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1433:                         loc_cSql = "SELECT Varias FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCod)
1434:                         loc_nRetSql = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_VariasPro")
1435:                         IF loc_nRetSql > 0 AND USED("cursor_4c_VariasPro") AND !EOF("cursor_4c_VariasPro")
1436:                             loc_nVarias = cursor_4c_VariasPro.Varias
1437:                         ENDIF
1438:                         IF USED("cursor_4c_VariasPro")
1439:                             USE IN cursor_4c_VariasPro
1440:                         ENDIF
1441:                     ENDIF
1442: 
1443:                     IF loc_nVarias <> 1
1444:                         MsgAviso("Este Produto n" + CHR(227) + "o est" + CHR(225) + ;
1445:                                  " Configurado para Peso Vari" + CHR(225) + "vel!!!", ;
1446:                                  "Selecionar Material Principal")
1447:                         loc_oPg2.txt_4c_MatPrincs.Value = ""
1448:                     ELSE
1449:                         loc_oPg2.txt_4c_MatPrincs.Value = loc_cCod

*-- Linhas 1550 a 1584:
1550:             *-- Buscar descricao do CodConPads (DPros de SigCdPro)
1551:             loc_oPg2.txt_4c_DCodConPads.Value = ""
1552:             IF !EMPTY(loc_oBO.this_cCodConPads) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1553:                 loc_cSql = "SELECT DPros FROM SigCdPro WHERE CPros = " + ;
1554:                             EscaparSQL(ALLTRIM(loc_oBO.this_cCodConPads))
1555:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescPro")
1556:                 IF loc_nRet > 0 AND USED("cursor_4c_DescPro") AND !EOF("cursor_4c_DescPro")
1557:                     loc_oPg2.txt_4c_DCodConPads.Value = ALLTRIM(cursor_4c_DescPro.DPros)
1558:                 ENDIF
1559:                 IF USED("cursor_4c_DescPro")
1560:                     USE IN cursor_4c_DescPro
1561:                 ENDIF
1562:             ENDIF
1563: 
1564:             *-- Buscar descricao da Linha (Descs de SigCdLin)
1565:             loc_oPg2.txt_4c_DLin.Value = ""
1566:             IF !EMPTY(loc_oBO.this_cLinhas) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1567:                 loc_cSql = "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
1568:                             EscaparSQL(ALLTRIM(loc_oBO.this_cLinhas))
1569:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_DescLin")
1570:                 IF loc_nRet > 0 AND USED("cursor_4c_DescLin") AND !EOF("cursor_4c_DescLin")
1571:                     loc_oPg2.txt_4c_DLin.Value = ALLTRIM(cursor_4c_DescLin.Descs)
1572:                 ENDIF
1573:                 IF USED("cursor_4c_DescLin")
1574:                     USE IN cursor_4c_DescLin
1575:                 ENDIF
1576:             ENDIF
1577: 
1578:             *-- OptionGroups (Value=1=Sim, Value=2=Nao)
1579:             *-- Bloquear Etiqueta Individual: DB 0=Sim, DB 1=Nao
1580:             loc_oPg2.opt_4c_BlqEtq.Value    = IIF(loc_oBO.this_nBarrefs = 0, 1, 2)
1581:             *-- Permite Alterar Dados da Etiqueta: DB 0=Sim, DB 1=Nao
1582:             loc_oPg2.opt_4c_AlteEtiq.Value  = IIF(loc_oBO.this_nAltetiqs = 0, 1, 2)
1583:             *-- Controla por Qtde: DB 0=Sim, DB 1=Nao
1584:             loc_oPg2.opt_4c_Cpq.Value       = IIF(loc_oBO.this_nCpqtds = 0, 1, 2)

*-- Linhas 1704 a 1723:
1704:                 .GridLineColor   = RGB(200, 200, 200)
1705:                 .HeaderHeight    = 22
1706:                 .RowHeight       = 20
1707:                 .AllowCellSelection = .F.
1708:                 .DeleteMark      = .F.
1709:                 .RecordMark      = .F.
1710:                 .ReadOnly        = .T.
1711: 
1712:                 WITH .Column1
1713:                     .Width   = 60
1714:                     .Alignment = 2
1715:                     .Header1.FontBold = .T.
1716:                 ENDWITH
1717:                 WITH .Column2
1718:                     .Width   = 300
1719:                     .Header1.FontBold = .T.
1720:                 ENDWITH
1721:                 WITH .Column3
1722:                     .Width   = 200
1723:                     .Header1.FontBold = .T.

*-- Linhas 1761 a 1779:
1761:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1762:                 MsgAviso("Selecione um registro para alterar.", "Alterar")
1763:             ELSE
1764:                 SELECT cursor_4c_Dados
1765:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1766:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1767:                     THIS.this_oBusinessObject.EditarRegistro()
1768:                     THIS.BOParaForm()
1769:                     THIS.this_cModoAtual = "ALTERAR"
1770:                     THIS.HabilitarCampos(.T.)
1771:                     THIS.AjustarBotoesPorModo("EDICAO")
1772:                     THIS.AlternarPagina(2)
1773:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
1774:                     loc_lResultado = .T.
1775:                 ENDIF
1776:             ENDIF
1777:         CATCH TO loException
1778:             MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "Formgpr.BtnAlterarClick")
1779:         ENDTRY

*-- Linhas 1790 a 1808:
1790:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1791:                 MsgAviso("Selecione um registro para visualizar.", "Visualizar")
1792:             ELSE
1793:                 SELECT cursor_4c_Dados
1794:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1795:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1796:                     THIS.BOParaForm()
1797:                     THIS.this_cModoAtual = "VISUALIZAR"
1798:                     THIS.HabilitarCampos(.F.)
1799:                     THIS.AjustarBotoesPorModo("NORMAL")
1800:                     THIS.AlternarPagina(2)
1801:                     loc_lResultado = .T.
1802:                 ENDIF
1803:             ENDIF
1804:         CATCH TO loException
1805:             MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Formgpr.BtnVisualizarClick")
1806:         ENDTRY
1807:         RETURN loc_lResultado
1808:     ENDPROC

*-- Linhas 1817 a 1835:
1817:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1818:                 MsgAviso("Selecione um registro para excluir.", "Excluir")
1819:             ELSE
1820:                 SELECT cursor_4c_Dados
1821:                 loc_cCodigo  = ALLTRIM(cursor_4c_Dados.codigos)
1822:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do grande grupo '" + ;
1823:                                             loc_cCodigo + "'?", "Excluir")
1824:                 IF loc_lConfirma
1825:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1826:                         IF THIS.this_oBusinessObject.Excluir()
1827:                             MsgInfo("Grande grupo exclu" + CHR(237) + "do com sucesso.", "Excluir")
1828:                             THIS.CarregarLista()
1829:                         ENDIF
1830:                     ENDIF
1831:                     loc_lResultado = .T.
1832:                 ENDIF
1833:             ENDIF
1834:         CATCH TO loException
1835:             MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "Formgpr.BtnExcluirClick")

*-- Linhas 1846 a 1881:
1846:         TRY
1847:             loc_cCodigo = ""
1848:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1849:                 SELECT cursor_4c_Dados
1850:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1851:             ENDIF
1852: 
1853:             LOCAL loc_oBusca
1854:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1855:                 "SigCdGpr", "cursor_4c_BuscaGpr", "codigos", loc_cCodigo, ;
1856:                 "Buscar Grande Grupo")
1857: 
1858:             IF VARTYPE(loc_oBusca) = "O"
1859:                 IF !loc_oBusca.this_lAchouRegistro
1860:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1861:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1862:                     loc_oBusca.Show()
1863:                 ENDIF
1864: 
1865:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpr")
1866:                     SELECT cursor_4c_BuscaGpr
1867:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGpr.codigos)
1868:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1869:                         THIS.BOParaForm()
1870:                         THIS.this_cModoAtual = "VISUALIZAR"
1871:                         THIS.HabilitarCampos(.F.)
1872:                         THIS.AjustarBotoesPorModo("NORMAL")
1873:                         THIS.AlternarPagina(2)
1874:                     ENDIF
1875:                     loc_lResultado = .T.
1876:                 ENDIF
1877: 
1878:                 loc_oBusca.Release()
1879:             ENDIF
1880:         CATCH TO loException
1881:             MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "Formgpr.BtnBuscarClick")


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

