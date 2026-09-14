# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CARGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'REFERS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCARGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BUSCARMESESDISPONIVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, ICL

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
  ControlSource = "crSigCdJrn.cargos"
  ControlSource = "crSigCdJrn.iclis"
  ControlSource = "crSigCdJrn.descri"
  ControlSource = "crSigCdJrn.hora01"
  ControlSource = "crSigCdJrn.hora02"
  ControlSource = "crSigCdJrn.hora03"
  ControlSource = "crSigCdJrn.hora04"
  ControlSource = "crSigCdJrn.dom"
  ControlSource = "crSigCdJrn.seg"
  ControlSource = "crSigCdJrn.ter"
  ControlSource = "crSigCdJrn.qua"
  ControlSource = "crSigCdJrn.qui"
  ControlSource = "crSigCdJrn.sex"
  ControlSource = "crSigCdJrn.sab"
Select crSigCdJrn
	lcQryJrn = [Select a.*, b.rclis as descri, ] + ;
	      [From SigCdJrn a ] + ;
	      [Left Join SigCdCli b on a.iclis=b.iclis Order By a.pkchave]			 
		Select crSigCdJrn
lcQuery = [Select refers from SigCdJrn where (iclis=?pCta or ?pCta='') and (cargos=?pCgo or ?pCgo='') order by refers asc]
If (thisform.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
Select crTmp
Select crSigCdJrn
If Seek(cPkChave,'crSigCdJrn','pkchave')
		Insert into crSigCdJrn from memvar
	Insert into crSigCdJrn from memvar
thisform.podatamgr.update('crSigCdJrn')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS SQL (2089 linhas total):

*-- Linhas 381 a 419:
381:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
382:         *
383:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
384:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
385:         *----------------------------------------------------------------------
386:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
387:         loc_oGrid = loc_oPagina.grd_4c_Lista
388: 
389:         loc_oGrid.ColumnCount = 14
390: 
391:         WITH loc_oGrid
392:             .Top                = 125
393:             .Left               = 32
394:             .Width              = 880
395:             .Height             = 470
396:             .FontName           = "Verdana"
397:             .FontSize           = 8
398:             .ForeColor          = RGB(90, 90, 90)
399:             .BackColor          = RGB(255, 255, 255)
400:             .GridLineColor      = RGB(238, 238, 238)
401:             .HighlightBackColor = RGB(255, 255, 255)
402:             .HighlightForeColor = RGB(15, 41, 104)
403:             .HighlightStyle     = 2
404:             .DeleteMark         = .F.
405:             .RecordMark         = .F.
406:             .RowHeight          = 16
407:             .ScrollBars         = 2
408:             .GridLines          = 3
409:             .Visible            = .T.
410: 
411:             .Column1.Width           = 80
412:             .Column1.Alignment       = 0
413:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
414: 
415:             .Column2.Width           = 80
416:             .Column2.Alignment       = 0
417:             .Column2.Header1.Caption = "Cargo"
418: 
419:             .Column3.Width           = 52

*-- Linhas 1163 a 1181:
1163:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1164:                     loc_oGrid.ColumnCount  = 14
1165: 
1166:                     *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
1167:                     THIS.AtualizarBindingGrid(loc_oGrid)
1168:                     THIS.FormatarGridLista(loc_oGrid)
1169:                     loc_oGrid.Refresh()
1170:                     loc_lSucesso = .T.
1171:                 ENDIF
1172:             ENDIF
1173:         CATCH TO loc_oErro
1174:             MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1175:         ENDTRY
1176: 
1177:         RETURN loc_lSucesso
1178:     ENDPROC
1179: 
1180:     *==========================================================================
1181:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)

*-- Linhas 1200 a 1288:
1200:     ENDPROC
1201: 
1202:     *==========================================================================
1203:     * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
1204:     * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
1205:     *==========================================================================
1206:     PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
1207:         WITH par_oGrid
1208:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1209:             .Column1.Width           = 80
1210:             .Column1.Alignment       = 0
1211:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1212: 
1213:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1214:             .Column2.Width           = 80
1215:             .Column2.Alignment       = 0
1216:             .Column2.Header1.Caption = "Cargo"
1217: 
1218:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1219:             .Column3.Width           = 52
1220:             .Column3.Alignment       = 0
1221:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1222: 
1223:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1224:             .Column4.Width           = 45
1225:             .Column4.Alignment       = 0
1226:             .Column4.Header1.Caption = "Inicio"
1227: 
1228:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1229:             .Column5.Width           = 45
1230:             .Column5.Alignment       = 0
1231:             .Column5.Header1.Caption = "Intervalo"
1232: 
1233:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1234:             .Column6.Width           = 45
1235:             .Column6.Alignment       = 0
1236:             .Column6.Header1.Caption = "Intervalo"
1237: 
1238:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1239:             .Column7.Width           = 45
1240:             .Column7.Alignment       = 0
1241:             .Column7.Header1.Caption = "Fim"
1242: 
1243:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1244:             .Column8.Width           = 20
1245:             .Column8.Alignment       = 2
1246:             .Column8.Header1.Caption = "Dom"
1247: 
1248:             .Column9.ControlSource   = "cursor_4c_Dados.cSeg"
1249:             .Column9.Width           = 20
1250:             .Column9.Alignment       = 2
1251:             .Column9.Header1.Caption = "Seg"
1252: 
1253:             .Column10.ControlSource  = "cursor_4c_Dados.cTer"
1254:             .Column10.Width          = 20
1255:             .Column10.Alignment      = 2
1256:             .Column10.Header1.Caption = "Ter"
1257: 
1258:             .Column11.ControlSource  = "cursor_4c_Dados.cQua"
1259:             .Column11.Width          = 20
1260:             .Column11.Alignment      = 2
1261:             .Column11.Header1.Caption = "Qua"
1262: 
1263:             .Column12.ControlSource  = "cursor_4c_Dados.cQui"
1264:             .Column12.Width          = 20
1265:             .Column12.Alignment      = 2
1266:             .Column12.Header1.Caption = "Qui"
1267: 
1268:             .Column13.ControlSource  = "cursor_4c_Dados.cSex"
1269:             .Column13.Width          = 20
1270:             .Column13.Alignment      = 2
1271:             .Column13.Header1.Caption = "Sex"
1272: 
1273:             .Column14.ControlSource  = "cursor_4c_Dados.cSab"
1274:             .Column14.Width          = 20
1275:             .Column14.Alignment      = 2
1276:             .Column14.Header1.Caption = "S" + CHR(225) + "b"
1277:         ENDWITH
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * FormatarGridLista - Padroniza fonte de todas as colunas
1282:     *==========================================================================
1283:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1284:         WITH par_oGrid
1285:             .FontName = "Tahoma"
1286:             .FontSize = 8
1287:         ENDWITH
1288:     ENDPROC

*-- Linhas 1466 a 1484:
1466:         loc_cPkChave = ""
1467: 
1468:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1469:             SELECT cursor_4c_Dados
1470:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1471:         ENDIF
1472: 
1473:         IF EMPTY(loc_cPkChave)
1474:             MsgAviso("Selecione um registro na lista.")
1475:             RETURN
1476:         ENDIF
1477: 
1478:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1479:             THIS.this_cModoAtual = "VISUALIZAR"
1480:             THIS.BOParaForm()
1481:             THIS.HabilitarCampos(.F.)
1482:             THIS.AjustarBotoesPorModo()
1483:             THIS.pgf_4c_Paginas.ActivePage = 2
1484:         ENDIF

*-- Linhas 1492 a 1510:
1492:         loc_cPkChave = ""
1493: 
1494:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1495:             SELECT cursor_4c_Dados
1496:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1497:         ENDIF
1498: 
1499:         IF EMPTY(loc_cPkChave)
1500:             MsgAviso("Selecione um registro na lista.")
1501:             RETURN
1502:         ENDIF
1503: 
1504:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1505:             THIS.this_oBusinessObject.EditarRegistro()
1506:             THIS.this_cModoAtual = "ALTERAR"
1507:             THIS.BOParaForm()
1508:             THIS.HabilitarCampos(.T.)
1509:             THIS.AjustarBotoesPorModo()
1510:             THIS.pgf_4c_Paginas.ActivePage = 2

*-- Linhas 1519 a 1537:
1519:         loc_cPkChave = ""
1520: 
1521:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1522:             SELECT cursor_4c_Dados
1523:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1524:         ENDIF
1525: 
1526:         IF EMPTY(loc_cPkChave)
1527:             MsgAviso("Selecione um registro na lista.")
1528:             RETURN
1529:         ENDIF
1530: 
1531:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1532:             RETURN
1533:         ENDIF
1534: 
1535:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1536:             IF THIS.this_oBusinessObject.Excluir()
1537:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")

*-- Linhas 1625 a 1643:
1625:         loc_cPkChave = ""
1626: 
1627:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1628:             SELECT cursor_4c_Dados
1629:             loc_cRefers  = ALLTRIM(cursor_4c_Dados.refers)
1630:             loc_cIclis   = ALLTRIM(cursor_4c_Dados.iclis)
1631:             loc_cCargos  = ALLTRIM(cursor_4c_Dados.cargos)
1632:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1633:         ENDIF
1634: 
1635:         IF EMPTY(loc_cRefers)
1636:             MsgAviso("Selecione um registro na lista para copiar.")
1637:             RETURN
1638:         ENDIF
1639: 
1640:         *-- Carregar BO com o registro selecionado (CopiarParaMes precisa dos dados do BO)
1641:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1642:             RETURN
1643:         ENDIF

*-- Linhas 1704 a 1723:
1704:         ENDIF
1705: 
1706:         TRY
1707:             loc_cSQL    = "SELECT ccargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
1708:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCgo")
1709: 
1710:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCgo") > 0
1711:                 loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_ValCgo.ccargs)
1712:             ELSE
1713:                 MsgAviso("Cargo n" + CHR(227) + "o encontrado.")
1714:                 loc_oPagina.txt_4c_CodCgo.Value = ""
1715:                 THIS.AbrirLookupCargo()
1716:             ENDIF
1717: 
1718:             IF USED("cursor_4c_ValCgo")
1719:                 USE IN cursor_4c_ValCgo
1720:             ENDIF
1721:         CATCH TO loc_oErro
1722:             MsgErro("Erro em FormJrn.ValidarCodCgo:" + CHR(13) + loc_oErro.Message, "Erro")
1723:             IF USED("cursor_4c_ValCgo")

*-- Linhas 1781 a 1800:
1781:         ENDIF
1782: 
1783:         TRY
1784:             loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
1785:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCli")
1786: 
1787:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCli") > 0
1788:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValCli.iclis)
1789:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValCli.rclis)
1790:             ELSE
1791:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1792:                 loc_oPagina.txt_4c_CodCli.Value = ""
1793:                 loc_oPagina.txt_4c_DesCli.Value = ""
1794:                 THIS.AbrirLookupFuncionario()
1795:             ENDIF
1796: 
1797:             IF USED("cursor_4c_ValCli")
1798:                 USE IN cursor_4c_ValCli
1799:             ENDIF
1800:         CATCH TO loc_oErro

*-- Linhas 1860 a 1880:
1860:         ENDIF
1861: 
1862:         TRY
1863:             loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
1864:                           EscaparSQL(loc_cValor + "%") + " ORDER BY rclis"
1865:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValDes")
1866: 
1867:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValDes") > 0
1868:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValDes.iclis)
1869:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValDes.rclis)
1870:             ELSE
1871:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1872:                 loc_oPagina.txt_4c_DesCli.Value = ""
1873:                 loc_oPagina.txt_4c_CodCli.Value = ""
1874:                 THIS.AbrirLookupFuncionarioPorNome()
1875:             ENDIF
1876: 
1877:             IF USED("cursor_4c_ValDes")
1878:                 USE IN cursor_4c_ValDes
1879:             ENDIF
1880:         CATCH TO loc_oErro

*-- Linhas 1940 a 1958:
1940: 
1941:         TRY
1942:             IF USED("cursor_4c_Meses") AND RECCOUNT("cursor_4c_Meses") > 0
1943:                 SELECT cursor_4c_Meses
1944:                 GO TOP
1945:                 SCAN
1946:                     loc_cMesRef = SUBSTR(ALLTRIM(refers), 5, 2)
1947:                     DO CASE
1948:                         CASE loc_cMesRef = "01"
1949:                             loc_cNomeMes = "Janeiro"
1950:                         CASE loc_cMesRef = "02"
1951:                             loc_cNomeMes = "Fevereiro"
1952:                         CASE loc_cMesRef = "03"
1953:                             loc_cNomeMes = "Mar" + CHR(231) + "o"
1954:                         CASE loc_cMesRef = "04"
1955:                             loc_cNomeMes = "Abril"
1956:                         CASE loc_cMesRef = "05"
1957:                             loc_cNomeMes = "Maio"
1958:                         CASE loc_cMesRef = "06"


### BO (C:\4c\projeto\app\classes\JrnBO.prg):
*==============================================================================
* JrnBO.prg - Business Object para Cadastro de Jornadas (SigCdJrn)
* Herda de BusinessBase
* Tabela: SigCdJrn
* PK: pkchave (composto: refers + cargos_padded + iclis_padded)
*==============================================================================

DEFINE CLASS JrnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdJrn
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (calculada)
    this_cPkChave    = ""  && pkchave  char - refers + cargos(0pad) + iclis(0pad)

    *-- Campos de identificacao do registro
    this_cRefers     = ""  && refers   char(6)  - periodo referencia (YYYYMM)
    this_cIclis      = ""  && iclis    char     - codigo do funcionario (FK SigCdCli)
    this_cCargos     = ""  && cargos   char     - codigo do cargo (FK SigCdCrg.ccargs)

    *-- Campo dias (string 7 chars: dom/seg/ter/qua/qui/sex/sab = 'X' ou ' ')
    this_cDias       = "       "  && dias  char(7)

    *-- Horarios (formato HH:MM)
    this_cHora01     = ""  && hora01  char(5) - inicio
    this_cHora02     = ""  && hora02  char(5) - inicio intervalo
    this_cHora03     = ""  && hora03  char(5) - fim intervalo
    this_cHora04     = ""  && hora04  char(5) - fim

    *-- Flags de dias da semana (computados de this_cDias)
    this_lDom        = .F.  && Domingo    (posicao 1 de dias)
    this_lSeg        = .F.  && Segunda    (posicao 2 de dias)
    this_lTer        = .F.  && Terca      (posicao 3 de dias)
    this_lQua        = .F.  && Quarta     (posicao 4 de dias)
    this_lQui        = .F.  && Quinta     (posicao 5 de dias)
    this_lSex        = .F.  && Sexta      (posicao 6 de dias)
    this_lSab        = .F.  && Sabado     (posicao 7 de dias)

    *-- Auditoria de criacao
    this_dDatas      = {}   && datas   datetime - data/hora de inclusao
    this_cUsuars     = ""   && usuars  char     - usuario que incluiu

    *-- Auditoria de alteracao
    this_dDtalts     = {}   && dtalts  datetime - data/hora da ultima alteracao
    this_cUsualts    = ""   && usualts char     - usuario da ultima alteracao

    *-- Descricao do funcionario (calculada via JOIN com SigCdCli)
    this_cDescri     = ""   && descri  char - rclis do funcionario (nao eh campo fisico)

    *--------------------------------------------------------------------------
    * Configuracao da classe
    *--------------------------------------------------------------------------

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdJrn"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularPkChave - constroi a PK composta a partir dos campos
    * refers(6) + cargos(substituindo espacos por "0") + iclis(idem)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularPkChave()
        LOCAL loc_cPk
        loc_cPk = ALLTRIM(THIS.this_cRefers) + ;
                  STRTRAN(THIS.this_cCargos, " ", "0") + ;
                  STRTRAN(THIS.this_cIclis,  " ", "0")
        RETURN loc_cPk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirDias - constroi string dias (7 chars) a partir dos flags logicos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirDias()
        LOCAL loc_cDias
        loc_cDias = IIF(THIS.this_lDom, "X", " ") + ;
                    IIF(THIS.this_lSeg, "X", " ") + ;
                    IIF(THIS.this_lTer, "X", " ") + ;
                    IIF(THIS.this_lQua, "X", " ") + ;
                    IIF(THIS.this_lQui, "X", " ") + ;
                    IIF(THIS.this_lSex, "X", " ") + ;
                    IIF(THIS.this_lSab, "X", " ")
        RETURN loc_cDias
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParsearDias - converte string dias para flags logicos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ParsearDias(par_cDias)
        LOCAL loc_cStr
        loc_cStr = PADR(NVL(par_cDias, "       "), 7)
        THIS.this_lDom = (SUBSTR(loc_cStr, 1, 1) == "X")
        THIS.this_lSeg = (SUBSTR(loc_cStr, 2, 1) == "X")
        THIS.this_lTer = (SUBSTR(loc_cStr, 3, 1) == "X")
        THIS.this_lQua = (SUBSTR(loc_cStr, 4, 1) == "X")
        THIS.this_lQui = (SUBSTR(loc_cStr, 5, 1) == "X")
        THIS.this_lSex = (SUBSTR(loc_cStr, 6, 1) == "X")
        THIS.this_lSab = (SUBSTR(loc_cStr, 7, 1) == "X")
        THIS.this_cDias = loc_cStr
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave   = TratarNulo(pkchave, "C")
            THIS.this_cRefers    = TratarNulo(refers,  "C")
            THIS.this_cIclis     = TratarNulo(iclis,   "C")
            THIS.this_cCargos    = TratarNulo(cargos,  "C")
            THIS.this_cHora01    = TratarNulo(hora01,  "C")
            THIS.this_cHora02    = TratarNulo(hora02,  "C")
            THIS.this_cHora03    = TratarNulo(hora03,  "C")
            THIS.this_cHora04    = TratarNulo(hora04,  "C")
            THIS.this_dDatas     = TratarNulo(datas,   "D")
            THIS.this_cUsuars    = TratarNulo(usuars,  "C")
            THIS.this_dDtalts    = TratarNulo(dtalts,  "D")
            THIS.this_cUsualts   = TratarNulo(usualts, "C")
            THIS.ParsearDias(TratarNulo(dias, "C"))
            *-- descri eh calculado via JOIN - carrega se existir no cursor
            IF TYPE("descri") != "U"
                THIS.this_cDescri = TratarNulo(descri, "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com JOIN para descricao do funcionario
    * par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri," + ;
                       " SUBSTRING(a.dias,1,1) AS cDom," + ;
                       " CASE WHEN SUBSTRING(a.dias,1,1)='X' THEN 1 ELSE 0 END AS dom," + ;
                       " SUBSTRING(a.dias,2,1) AS cSeg," + ;
                       " CASE WHEN SUBSTRING(a.dias,2,1)='X' THEN 1 ELSE 0 END AS seg," + ;
                       " SUBSTRING(a.dias,3,1) AS cTer," + ;
                       " CASE WHEN SUBSTRING(a.dias,3,1)='X' THEN 1 ELSE 0 END AS ter," + ;
                       " SUBSTRING(a.dias,4,1) AS cQua," + ;
                       " CASE WHEN SUBSTRING(a.dias,4,1)='X' THEN 1 ELSE 0 END AS qua," + ;
                       " SUBSTRING(a.dias,5,1) AS cQui," + ;
                       " CASE WHEN SUBSTRING(a.dias,5,1)='X' THEN 1 ELSE 0 END AS qui," + ;
                       " SUBSTRING(a.dias,6,1) AS cSex," + ;
                       " CASE WHEN SUBSTRING(a.dias,6,1)='X' THEN 1 ELSE 0 END AS sex," + ;
                       " SUBSTRING(a.dias,7,1) AS cSab," + ;
                       " CASE WHEN SUBSTRING(a.dias,7,1)='X' THEN 1 ELSE 0 END AS sab" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       loc_cWhere + ;
                       " ORDER BY a.pkchave"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar jornadas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - carrega registro pelo pkchave
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       " WHERE a.pkchave = " + EscaparSQL(par_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdJrn
    * Constroi pkchave composto e registra auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cPkChave, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cPkChave = THIS.CalcularPkChave()
            loc_cDias    = THIS.ConstruirDias()

            loc_cSQL = "INSERT INTO SigCdJrn" + ;
                       " (pkchave, refers, iclis, cargos, dias," + ;
                       "  hora01, hora02, hora03, hora04," + ;
                       "  datas, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPkChave) + ", " + ;
                       EscaparSQL(THIS.this_cRefers) + ", " + ;
                       EscaparSQL(THIS.this_cIclis) + ", " + ;
                       EscaparSQL(THIS.this_cCargos) + ", " + ;
                       EscaparSQL(loc_cDias) + ", " + ;
                       EscaparSQL(THIS.this_cHora01) + ", " + ;
                       EscaparSQL(THIS.this_cHora02) + ", " + ;
                       EscaparSQL(THIS.this_cHora03) + ", " + ;
                       EscaparSQL(THIS.this_cHora04) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.this_cPkChave = loc_cPkChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdJrn
    * Altera apenas: dias, refers, dtalts, usualts (conforme logica original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cDias = THIS.ConstruirDias()

            loc_cSQL = "UPDATE SigCdJrn SET" + ;
                       " refers  = " + EscaparSQL(THIS.this_cRefers) + "," + ;
                       " dias    = " + EscaparSQL(loc_cDias) + "," + ;
                       " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                       " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                       " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                       " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                       " dtalts  = GETDATE()," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao alterar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdJrn
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdJrn" + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarParaMes - copia a jornada do registro atual para outro mes/ano
    * par_cAno:  ano destino (4 chars, ex: "2025")
    * par_cMes:  mes destino (2 chars, ex: "03")
    * Retorna .T. se copiou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CopiarParaMes(par_cAno, par_cMes)
        LOCAL loc_cNovoRefers, loc_cNovoPk, loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cAno)) OR EMPTY(ALLTRIM(par_cMes))
                MsgErro("Ano e m" + CHR(234) + "s s" + CHR(227) + "o obrigat" + ;
                        CHR(243) + "rios para copiar jornada.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cNovoRefers = ALLTRIM(par_cAno) + ALLTRIM(par_cMes)
            loc_cNovoPk     = loc_cNovoRefers + ;
                              STRTRAN(THIS.this_cCargos, " ", "0") + ;
                              STRTRAN(THIS.this_cIclis,  " ", "0")

            *-- Verifica se ja existe registro para o mes destino
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdJrn WHERE pkchave = " + ;
                       EscaparSQL(loc_cNovoPk)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCopia") > 0
                SELECT cursor_4c_ChkCopia
                IF cursor_4c_ChkCopia.qtd > 0
                    *-- Registro existente: UPDATE
                    loc_cSQL = "UPDATE SigCdJrn SET" + ;
                               " refers  = " + EscaparSQL(loc_cNovoRefers) + "," + ;
                               " dias    = " + EscaparSQL(THIS.ConstruirDias()) + "," + ;
                               " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                               " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                               " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                               " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                               " dtalts  = GETDATE()," + ;
                               " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                               " WHERE pkchave = " + EscaparSQL(loc_cNovoPk)
                ELSE
                    *-- Registro novo: INSERT
                    loc_cSQL = "INSERT INTO SigCdJrn" + ;
                               " (pkchave, refers, iclis, cargos, dias," + ;
                               "  hora01, hora02, hora03, hora04," + ;
                               "  datas, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoPk) + ", " + ;
                               EscaparSQL(loc_cNovoRefers) + ", " + ;
                               EscaparSQL(THIS.this_cIclis) + ", " + ;
                               EscaparSQL(THIS.this_cCargos) + ", " + ;
                               EscaparSQL(THIS.ConstruirDias()) + ", " + ;
                               EscaparSQL(THIS.this_cHora01) + ", " + ;
                               EscaparSQL(THIS.this_cHora02) + ", " + ;
                               EscaparSQL(THIS.this_cHora03) + ", " + ;
                               EscaparSQL(THIS.this_cHora04) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ")"
                ENDIF
                USE IN cursor_4c_ChkCopia
            ELSE
                MsgErro("Erro ao verificar registro destino:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ChkCopia")
                    USE IN cursor_4c_ChkCopia
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao copiar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CopiarParaMes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCopia")
                USE IN cursor_4c_ChkCopia
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMesesDisponiveis - retorna cursor com meses existentes para
    * funcionario/cargo especificados (para o painel Copiar Mes)
    * par_cIclis:  codigo do funcionario (pode ser vazio = todos)
    * par_cCargos: codigo do cargo (pode ser vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMesesDisponiveis(par_cIclis, par_cCargos)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Meses")
                USE IN cursor_4c_Meses
            ENDIF

            loc_cWhere = " WHERE (iclis = " + EscaparSQL(par_cIclis) + ;
                         " OR " + EscaparSQL(par_cIclis) + " = '')" + ;
                         " AND (cargos = " + EscaparSQL(par_cCargos) + ;
                         " OR " + EscaparSQL(par_cCargos) + " = '')"

            loc_cSQL = "SELECT refers FROM SigCdJrn" + ;
                       loc_cWhere + ;
                       " ORDER BY refers ASC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Meses")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar meses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.BuscarMesesDisponiveis:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cRefers))
            MsgErro("Refer" + CHR(234) + "ncia (Ano/M" + CHR(234) + "s) " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIclis)) AND EMPTY(ALLTRIM(THIS.this_cCargos))
            MsgAviso("Informe o Funcion" + CHR(225) + "rio ou o Cargo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cHora01)) OR EMPTY(ALLTRIM(THIS.this_cHora02)) OR ;
               EMPTY(ALLTRIM(THIS.this_cHora03)) OR EMPTY(ALLTRIM(THIS.this_cHora04))
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!! Todos os hor" + CHR(225) + ;
                        "rios devem ser preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpeza de cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_ChkCopia")
            USE IN cursor_4c_ChkCopia
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

