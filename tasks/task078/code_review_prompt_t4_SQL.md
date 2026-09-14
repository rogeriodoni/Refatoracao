# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: VENDS, SGRUS, COLECOES, CPROS, NMARCA, FPAGS, EMPDOPNUMS, CITENS, CODIGOS, DATARS, DTINI, DTFIN, EMPS, CHAITD, LANCAMENTO, IMPRIME, LNALT, RCL, DOPES, TIPOOPS, GERGDMIS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
Select nMarca, fpags From CrSigOpFp Where nMarca = 1 Into Cursor crAux1
lcQuery =	[Select a.datars, a.Emps, a.Dopes, a.Numes,     ] + ;
	[From SigMvCab a with(nolock), SigMvItn b with(nolock) ] + ;
	[left join SigMvItd d with(nolock) on b.empdopnums = d.empdopnums and b.cpros=d.Cpros and b.citens = d.citens ] + ;
	[left join sigcddes e with(nolock) on d.codigo=e.codigo, ] +;
	[left join SigCdPsg co with(nolock) on co.cgrus=p.cgrus and co.codigos=p.sgrus ] + ;
	[left join SigCdCtg ca with(nolock) on ca.cods=p.categoria ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDados') < 1)
lcQuery =	[SELECT * from sigcddes with(nolock) Where dtini >= ?pDtI And dtfin <= ?pDtF ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery, 'csDados1') < 1)
Select * From csDados1 Where emps Not In (Select emps From csDados) Into Cursor csDados1
Select csDados1
	Select csDados
Select csDados
	lcQuery =	[Select dtincs from sigcdpro with(nolock) where cpros = ']+csDados.cpros+[']
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crProd') < 1)
	Select csDados
	Select csDados
	Delete All For chaitd =Space(20)
	Select csDados
	Delete All For lancamento <> '1'
Select csDados
	lcQuery =	[Select fpags from sigmvpar with(nolock) where empdopnums = ']+csDados.empdopnums+[' group by fpags]
	If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crMvPar') < 1)
	Select crMvPar
	Select csDados
Select * From csDados Where imprime = '1' Into Cursor csRelatorio Readwrite
Select csRelatorio
	Select csDados
	Select csRelatorio
Select csRelatorio
	Select datars,emps,dopes,numes,cpros,dpros,qtds,units,unitorigs,totas,opers,repre,colecao,categoria,empdopnums,chacab,chaitn,;
		from csRelatorio ;
	Select datars,emps,dopes,numes,cpros,dpros,qtds,units,unitorigs,totas,opers,repre,colecao,categoria,empdopnums,chacab,chaitn,;
		from csRelatorio ;
Select * from csTmpRel Into cursor csRelatorio ReadWrite 
Select csRelatorio
	Select emps,Space(20) As repre, Max(valcota) As valcota, Sum(realizado) As realizado, '1' As tipo From csRelatorio Group By emps, codigo Into Cursor crAux2
	Select emps,Space(20) As repre, Sum(valcota) As valcota, Sum(realizado) As realizado, '1' As tipo From crAux2 Group By emps Into Cursor crAux2
	Select emps,repre, Max(valcota) As valcota, Sum(realizado) As realizado, '2' As tipo From csRelatorio Group By emps, repre, codigo Into Cursor crAux1
	Select emps,repre, Max(valcota) As valcota, Sum(realizado) As realizado, '2' As tipo From crAux1 Group By emps, repre Into Cursor crAux1 readwrite
	SELECT crAux1
	Delete All For EMPTY(repre)
	Select * From crAux2 Union (Select * From crAux1) Into Cursor crAux
	Select emps, repre, valcota, realizado As realizadoV, Round(realizado/Nvl(valcota,1)*100,2) As realizadoP, valcota-realizado As saldoV, ;
		from crAux Into Cursor csRelatorio Order By 1
Insert Into csCabecalho (empresa, titulo, periodo) Values (lcCbEmp, lcCbTitulo, lcCbPeriodo)
Select csRelatorio
		lcQuery = [Select GrPadVens ] + ;
				    [From SigCdPam]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdPam') < 1)
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select 0 As nMarca, fpags ]+;
	   [From SigOpFp ],'CrSigOpFp')
Select CrSigOpFp
	.Column1.ControlSource = 'CrSigOpFp.nMarca'
	.Column3.ControlSource = 'CrSigOpFp.fpags'
Select CrSigOpFp
Select CrSigOpFp

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg) - TRECHOS RELEVANTES PARA PASS SQL (2113 linhas total):

*-- Linhas 845 a 863:
845:             .Height        = 181
846:             .FontName      = "Tahoma"
847:             .AllowRowSizing = .F.
848:             .DeleteMark    = .F.
849:             .GridLines     = 3
850:             .GridLineColor = RGB(238, 238, 238)
851:             .HeaderHeight  = 18
852:             .RowHeight     = 18
853:             .ScrollBars    = 2
854:             .RecordMark    = .F.
855:             .Themes        = .F.
856: 
857:             .Visible       = .T.
858: 
859:             WITH .Column1
860:                 .Width           = 15
861:                 .Alignment       = 0
862:                 .Sparse          = .F.
863:                 .ReadOnly        = .F.

*-- Linhas 870 a 912:
870:                     .Visible   = .T.
871:                 ENDWITH
872:                 .CurrentControl = "chk_4c_Marca"
873:                 .ControlSource  = "cursor_4c_OpFp.nMarca"
874:             ENDWITH
875: 
876:             WITH .Column2
877:                 .Width         = 210
878:                 .ControlSource = "cursor_4c_OpFp.fpags"
879:                 .ReadOnly      = .T.
880:                 .Header1.Caption = "Descrs"
881:                 .AddObject("txt_4c_FpNome", "TextBox")
882:                 WITH .txt_4c_FpNome
883:                     .BorderStyle = 0
884:                     .Margin      = 0
885:                     .ReadOnly    = .T.
886:                     .ForeColor   = RGB(0, 0, 0)
887:                     .BackColor   = RGB(255, 255, 255)
888:                     .Visible     = .T.
889:                 ENDWITH
890:                 .CurrentControl = "txt_4c_FpNome"
891:             ENDWITH
892:         ENDWITH
893:         IF USED("cursor_4c_OpFp")
894:             loc_oPg.grd_4c_Forma.ColumnCount = 3
895:             loc_oPg.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
896:             loc_oPg.grd_4c_Forma.Column1.ControlSource = "cursor_4c_OpFp.nMarca"
897:             loc_oPg.grd_4c_Forma.Column2.ControlSource = "cursor_4c_OpFp.fpags"
898:         ENDIF
899: 
900:         *-- === BOTOES MARCAR / DESMARCAR (Top_orig=348/392) ===
901: 
902:         *-- Botao Marcar/Selecionar (Command2 do legado - geral_marcar_26.jpg)
903:         loc_oPg.AddObject("cmd_4c_Marcar", "CommandButton")
904:         WITH loc_oPg.cmd_4c_Marcar
905:             .Top          = 263
906:             .Left         = 355
907:             .Height       = 45
908:             .Width        = 45
909:             .Caption      = ""
910:             .ToolTipText  = "Selecionar"
911:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
912:             .FontName     = "Verdana"

*-- Linhas 1133 a 1151:
1133:                 loc_cArq = SYS(2023) + "\sigredes_" + ;
1134:                     STRTRAN(DTOC(DATE()), "/", "") + ".xls"
1135:                 IF USED("csRelatorio")
1136:                     SELECT csRelatorio
1137:                     GO TOP
1138:                     COPY TO (loc_cArq) TYPE XLS
1139:                     IF FILE(loc_cArq)
1140:                         DECLARE INTEGER ShellExecute IN SHELL32.DLL ;
1141:                             INTEGER hWnd, STRING lpOperation, ;
1142:                             STRING lpFile, STRING lpParameters, ;
1143:                             STRING lpDirectory, INTEGER nShowCmd
1144:                         ShellExecute(0, "open", loc_cArq, "", "", 1)
1145:                     ENDIF
1146:                     THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
1147:                     loc_lSucesso = .T.
1148:                 ENDIF
1149:             ELSE
1150:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
1151:             ENDIF

*-- Linhas 1166 a 1203:
1166:     PROCEDURE MarcarClick()
1167:         TRY
1168:             IF USED("cursor_4c_OpFp")
1169:                 SELECT cursor_4c_OpFp
1170:                 GO TOP
1171:                 SCAN
1172:                     REPLACE nMarca WITH 1
1173:                 ENDSCAN
1174:                 GO TOP
1175:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1176:             ENDIF
1177:         CATCH TO loc_oErro
1178:             MsgErro(loc_oErro.Message, "Erro")
1179:         ENDTRY
1180:     ENDPROC
1181: 
1182:     *--------------------------------------------------------------------------
1183:     * DesmarcarClick - Desmarca todas as formas de pagamento no grid
1184:     *--------------------------------------------------------------------------
1185:     PROCEDURE DesmarcarClick()
1186:         TRY
1187:             IF USED("cursor_4c_OpFp")
1188:                 SELECT cursor_4c_OpFp
1189:                 GO TOP
1190:                 SCAN
1191:                     REPLACE nMarca WITH 0
1192:                 ENDSCAN
1193:                 GO TOP
1194:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1195:             ENDIF
1196:         CATCH TO loc_oErro
1197:             MsgErro(loc_oErro.Message, "Erro")
1198:         ENDTRY
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
1203:     * F4=115, ENTER=13, TAB=9, ESC=27

*-- Linhas 1357 a 1379:
1357:             loc_oPg.txt_4c_DesEmpresa.Value = ""
1358:             RETURN
1359:         ENDIF
1360:         loc_cSQL = "SELECT TOP 1 Emps, Razas FROM SigCdEmp WHERE Emps = " + ;
1361:                    EscaparSQL(loc_cCodigo)
1362:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1363:         IF loc_nResult > 0
1364:             SELECT cursor_4c_EmpVal
1365:             IF !EOF()
1366:                 loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(Emps)
1367:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(Razas)
1368:             ELSE
1369:                 THIS.AbrirBuscaEmpresa()
1370:             ENDIF
1371:             USE IN cursor_4c_EmpVal
1372:         ELSE
1373:             THIS.AbrirBuscaEmpresa()
1374:         ENDIF
1375:     ENDPROC
1376: 
1377:     *--------------------------------------------------------------------------
1378:     * ValidarCGru - Busca grupo pelo codigo (SigCdGcr.codigos)
1379:     *   Replica getCGru.Valid do original: fAcessoContab modo 'C'

*-- Linhas 1386 a 1408:
1386:             loc_oPg.txt_4c_DGru.Value = ""
1387:             RETURN
1388:         ENDIF
1389:         loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1390:                    EscaparSQL(loc_cCodigo)
1391:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruVal")
1392:         IF loc_nResult > 0
1393:             SELECT cursor_4c_GruVal
1394:             IF !EOF()
1395:                 loc_oPg.txt_4c_CGru.Value = ALLTRIM(codigos)
1396:                 loc_oPg.txt_4c_DGru.Value = ALLTRIM(descrs)
1397:             ELSE
1398:                 THIS.AbrirBuscaCGru()
1399:             ENDIF
1400:             USE IN cursor_4c_GruVal
1401:         ELSE
1402:             THIS.AbrirBuscaCGru()
1403:         ENDIF
1404:     ENDPROC
1405: 
1406:     *--------------------------------------------------------------------------
1407:     * ValidarVend - Busca vendedor/conta pelo codigo (SigCdCli.IClis)
1408:     *   Replica get_vend.Valid do original: fAcessoContas modo 'C'

*-- Linhas 1415 a 1437:
1415:             loc_oPg.txt_4c_DVend.Value = ""
1416:             RETURN
1417:         ENDIF
1418:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
1419:                    EscaparSQL(loc_cCodigo)
1420:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VendVal")
1421:         IF loc_nResult > 0
1422:             SELECT cursor_4c_VendVal
1423:             IF !EOF()
1424:                 loc_oPg.txt_4c_Vend.Value  = ALLTRIM(IClis)
1425:                 loc_oPg.txt_4c_DVend.Value = ALLTRIM(RClis)
1426:             ELSE
1427:                 THIS.AbrirBuscaVend()
1428:             ENDIF
1429:             USE IN cursor_4c_VendVal
1430:         ELSE
1431:             THIS.AbrirBuscaVend()
1432:         ENDIF
1433:     ENDPROC
1434: 
1435:     *--------------------------------------------------------------------------
1436:     * ValidarCate - Busca categoria pelo codigo (SigCdCol.codigos)
1437:     *   Replica getCate.Valid do original

*-- Linhas 1444 a 1466:
1444:             loc_oPg.txt_4c_CateD.Value = ""
1445:             RETURN
1446:         ENDIF
1447:         loc_cSQL = "SELECT codigos, descrs FROM SigCdCol WHERE codigos = " + ;
1448:                    EscaparSQL(loc_cCodigo)
1449:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CateVal")
1450:         IF loc_nResult > 0
1451:             SELECT cursor_4c_CateVal
1452:             IF !EOF()
1453:                 loc_oPg.txt_4c_Cate.Value  = ALLTRIM(codigos)
1454:                 loc_oPg.txt_4c_CateD.Value = ALLTRIM(descrs)
1455:             ELSE
1456:                 THIS.AbrirBuscaCate()
1457:             ENDIF
1458:             USE IN cursor_4c_CateVal
1459:         ELSE
1460:             THIS.AbrirBuscaCate()
1461:         ENDIF
1462:     ENDPROC
1463: 
1464:     *--------------------------------------------------------------------------
1465:     * ValidarCole - Busca colecao pelo codigo (SigCdPsg.codigos)
1466:     *   Replica GetCole.Valid do original

*-- Linhas 1473 a 1495:
1473:             loc_oPg.txt_4c_ColeD.Value = ""
1474:             RETURN
1475:         ENDIF
1476:         loc_cSQL = "SELECT codigos, descricaos FROM SigCdPsg WHERE codigos = " + ;
1477:                    EscaparSQL(loc_cCodigo)
1478:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColeVal")
1479:         IF loc_nResult > 0
1480:             SELECT cursor_4c_ColeVal
1481:             IF !EOF()
1482:                 loc_oPg.txt_4c_Cole.Value  = ALLTRIM(codigos)
1483:                 loc_oPg.txt_4c_ColeD.Value = ALLTRIM(descricaos)
1484:             ELSE
1485:                 THIS.AbrirBuscaCole()
1486:             ENDIF
1487:             USE IN cursor_4c_ColeVal
1488:         ELSE
1489:             THIS.AbrirBuscaCole()
1490:         ENDIF
1491:     ENDPROC
1492: 
1493:     *--------------------------------------------------------------------------
1494:     * ValidarProd - Busca produto pelo codigo (SigCdPro.CPros)
1495:     *   Replica getProd.Valid do original

*-- Linhas 1502 a 1524:
1502:             loc_oPg.txt_4c_ProdD.Value = ""
1503:             RETURN
1504:         ENDIF
1505:         loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
1506:                    EscaparSQL(loc_cCodigo)
1507:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdVal")
1508:         IF loc_nResult > 0
1509:             SELECT cursor_4c_ProdVal
1510:             IF !EOF()
1511:                 loc_oPg.txt_4c_Prod.Value  = ALLTRIM(CPros)
1512:                 loc_oPg.txt_4c_ProdD.Value = ALLTRIM(DPros)
1513:             ELSE
1514:                 THIS.AbrirBuscaProd()
1515:             ENDIF
1516:             USE IN cursor_4c_ProdVal
1517:         ELSE
1518:             THIS.AbrirBuscaProd()
1519:         ENDIF
1520:     ENDPROC
1521: 
1522:     *==========================================================================
1523:     * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)
1524:     *==========================================================================

*-- Linhas 2044 a 2063:
2044:                 IF USED("cursor_4c_OpFp")
2045:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.ColumnCount = 2
2046:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
2047:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column1.ControlSource = "cursor_4c_OpFp.nMarca"
2048:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column2.ControlSource = "cursor_4c_OpFp.fpags"
2049:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
2050:                 ENDIF
2051:             ENDIF
2052:             loc_lSucesso = .T.
2053:         CATCH TO loc_oErro
2054:             MsgErro(loc_oErro.Message, "Erro")
2055:         ENDTRY
2056:         RETURN loc_lSucesso
2057:     ENDPROC
2058: 
2059:     *--------------------------------------------------------------------------
2060:     * AjustarBotoesPorModo - Em FormSIGREDES (REPORT), os botoes de relatorio
2061:     *   (Visualizar/Imprimir/Excel/Encerrar) ficam sempre habilitados.
2062:     *--------------------------------------------------------------------------
2063:     PROTECTED PROCEDURE AjustarBotoesPorModo()


### BO (C:\4c\projeto\app\classes\SIGREDESBO.prg):
*==============================================================================
* SIGREDESBO.PRG
* Business Object para Relatorio de Cotas de Desconto (SIGREDES)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvCab, SigMvItn, SigMvItd, sigcddes
* Relatorios FRX: SigReDes.frx (Detalhado), SigReDe1.frx (Resumido)
*
* Filtros:
*   - Empresa    (codigo + descricao)
*   - Periodo    (data inicial / data final)
*   - Grupo      (codigo + descricao - campo Grupos de SigCdCli)
*   - Vendedor   (codigo + descricao - campo Vends/IClis de SigMvCab/SigCdCli)
*   - Categoria  (codigo + descricao - campo colecoes de SigcdPro / SigCdCol)
*   - Colecao    (codigo + descricao - campo sgrus de SigcdPro / SigCdPsg)
*   - Produto    (codigo + descricao - campo CPros de SigCdPro)
*   - Com desconto (0=todos, 1=somente com desconto)
*   - Lancamento   (0=todos, 1=somente lancamentos novos)
*   - Tipo visao   (1=Detalhado, 2=Resumido)
*==============================================================================

DEFINE CLASS SIGREDESBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: grupo (campo Grupos de SigCdCli)
    this_cCGru          = ""
    this_cDGru          = ""

    *-- Filtro: vendedor (campo Vends de SigMvCab / IClis de SigCdCli)
    this_cVend          = ""
    this_cDVend         = ""

    *-- Filtro: categoria (campo colecoes de SigcdPro; lookup SigCdCol: colecoes/descs)
    this_cCate          = ""
    this_cCateD         = ""

    *-- Filtro: colecao (campo sgrus de SigcdPro; lookup SigCdPsg: codigos/descricaos)
    this_cCole          = ""
    this_cColeD         = ""

    *-- Filtro: produto (campo CPros de SigCdPro; lookup SigCdPro: CPros/DPros)
    this_cProd          = ""
    this_cProdD         = ""

    *-- Tipo de visao: 1=Detalhado (SigReDes.frx), 2=Resumido (SigReDe1.frx)
    this_nOpcao         = 1

    *-- Filtro com desconto: 0=todos, 1=somente itens com desconto (chaitd preenchido)
    this_nDesc          = 0

    *-- Filtro lancamento: 0=todos, 1=somente lancamentos (dtincs do produto < 61 dias)
    this_nLanc          = 0

    *-- Cursores gerenciados pelo BO
    this_cCursorDados      = "cursor_4c_Dados"
    this_cCursorRelatorio  = "cursor_4c_Relatorio"
    this_cCursorOpFp       = "cursor_4c_OpFp"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de Cotas de Desconto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Inicializa filtros com valores padrao e carrega
    * formas de pagamento disponiveis em cursor_4c_OpFp (ReadWrite para que o
    * grid do form permita marcar/desmarcar via CheckBox).
    * Equivalente ao bloco de Init() do form legado SIGREDES.
    * Chamado pelo form em InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_dPrimeiro, loc_dUltimo
        loc_lSucesso = .F.
        TRY
            *-- Primeiro e ultimo dia do mes corrente
            loc_dPrimeiro = DATE() - DAY(DATE()) + 1
            loc_dUltimo   = GOMONTH(loc_dPrimeiro, 1) - 1

            THIS.this_dDtInicial  = loc_dPrimeiro
            THIS.this_dDtFinal    = loc_dUltimo
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cDesEmpresa = ""
            THIS.this_cVend       = ""
            THIS.this_cDVend      = ""
            THIS.this_cCGru       = ""
            THIS.this_cDGru       = ""
            THIS.this_cCate       = ""
            THIS.this_cCateD      = ""
            THIS.this_cCole       = ""
            THIS.this_cColeD      = ""
            THIS.this_cProd       = ""
            THIS.this_cProdD      = ""
            THIS.this_nOpcao      = 1
            THIS.this_nDesc       = 0
            THIS.this_nLanc       = 0

            *-- Carregar formas de pagamento disponiveis (SigOpFp)
            *-- Cursor precisa ser ReadWrite: usuario marca/desmarca via grid
            IF USED(THIS.this_cCursorOpFp)
                USE IN (THIS.this_cCursorOpFp)
            ENDIF
            IF USED("cursor_4c_OpFp_tmp")
                USE IN cursor_4c_OpFp_tmp
            ENDIF

            loc_cSQL = "SELECT CAST(0 AS INT) AS nMarca, fpags FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar formas de pagamento (SigOpFp)"
            ELSE
                SELECT * FROM cursor_4c_OpFp_tmp INTO CURSOR (THIS.this_cCursorOpFp) READWRITE
                USE IN cursor_4c_OpFp_tmp
                SELECT (THIS.this_cCursorOpFp)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Cotas de Desconto
    * Equivalente ao procedimento "processamento" do legado SIGREDES.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_lcGru, loc_lcVend, loc_lcEmp, loc_lcCole, loc_lcCate, loc_lcProd
        LOCAL loc_cheVen, loc_cheCole, loc_cheCate, loc_cheProd, loc_cheFP
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lcChaAnt, loc_ldDatM, loc_ldDatP, loc_lnValRel, loc_lnAlt
        LOCAL loc_lcPdes, loc_lcVdes, loc_lnOpt, loc_lnDesc, loc_lnLanc
        LOCAL loc_cOpFpAlias, loc_nVdestot
        LOCAL loc_aCursFech(11), loc_nFech
        PRIVATE pDtI, pDtF, pDtH

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Extrair valores dos filtros do BO
            loc_lcGru  = ALLTRIM(THIS.this_cCGru)
            loc_lcVend = ALLTRIM(THIS.this_cVend)
            loc_lcEmp  = ALLTRIM(THIS.this_cEmpresa)
            loc_lcCole = ALLTRIM(THIS.this_cCole)
            loc_lcCate = ALLTRIM(THIS.this_cCate)
            loc_lcProd = ALLTRIM(THIS.this_cProd)
            loc_lnOpt  = THIS.this_nOpcao
            loc_lnDesc = THIS.this_nDesc
            loc_lnLanc = THIS.this_nLanc

            *-- Parametros de data para SQLEXEC binding (?pDtI / ?pDtF / ?pDtH)
            pDtI = DTOT(THIS.this_dDtInicial)
            pDtF = DTOT(THIS.this_dDtFinal) + 86399
            pDtH = DTOT(DATE()) + 86399

            *-- Filtro vendedor
            IF EMPTY(loc_lcVend)
                loc_cheVen = ""
            ELSE
                loc_cheVen = " and a.vends = '" + loc_lcVend + "' "
            ENDIF

            *-- Filtro colecao
            IF EMPTY(loc_lcCole)
                loc_cheCole = ""
            ELSE
                loc_cheCole = " and p.sgrus = '" + loc_lcCole + "' "
            ENDIF

            *-- Filtro categoria
            IF EMPTY(loc_lcCate)
                loc_cheCate = ""
            ELSE
                loc_cheCate = " and p.colecoes = '" + loc_lcCate + "' "
            ENDIF

            *-- Filtro produto
            IF EMPTY(loc_lcProd)
                loc_cheProd = ""
            ELSE
                loc_cheProd = " and b.cpros = '" + loc_lcProd + "' "
            ENDIF

            *-- Filtro formas de pagamento (marcadas no grid)
            loc_cheFP      = ""
            loc_cOpFpAlias = THIS.this_cCursorOpFp
            IF USED(loc_cOpFpAlias)
                SELECT nMarca, fpags FROM (loc_cOpFpAlias) WHERE nMarca = 1 ;
                    INTO CURSOR cursor_4c_FpSel
                GO TOP
                IF !EOF()
                    loc_cheFP = " and e.fpags in ('"
                    SCAN
                        loc_cheFP = loc_cheFP + ALLTRIM(fpags) + "','"
                    ENDSCAN
                    loc_cheFP = LEFT(loc_cheFP, LEN(loc_cheFP) - 2) + ") "
                ENDIF
                IF USED("cursor_4c_FpSel")
                    USE IN cursor_4c_FpSel
                ENDIF
            ENDIF

            *-- Titulo para cabecalho do relatorio
            loc_lcCbEmp = "VENDAS"
            IF !EMPTY(loc_lcGru)
                loc_lcCbEmp = loc_lcCbEmp + " (" + ALLTRIM(loc_lcGru) + ")"
            ENDIF

            *-- Fechar cursores de execucao anterior
            loc_aCursFech(1)  = "csDados"
            loc_aCursFech(2)  = "csDados1"
            loc_aCursFech(3)  = "csDados_tmp"
            loc_aCursFech(4)  = "csRelatorio"
            loc_aCursFech(5)  = "csTmpRel"
            loc_aCursFech(6)  = "csCabecalho"
            loc_aCursFech(7)  = "crProd"
            loc_aCursFech(8)  = "crMvPar"
            loc_aCursFech(9)  = "crAux"
            loc_aCursFech(10) = "crAux1"
            loc_aCursFech(11) = "crAux2"
            FOR loc_nFech = 1 TO 11
                IF USED(loc_aCursFech(loc_nFech))
                    USE IN (loc_aCursFech(loc_nFech))
                ENDIF
            ENDFOR
            IF USED("cursor_4c_FpSel")
                USE IN cursor_4c_FpSel
            ENDIF

            *-- Query principal: cabecalho x itens x descontos (SQL Server)
            loc_lcQuery = ;
                "Select a.datars, a.Emps, a.Dopes, a.Numes, " + ;
                "b.CPros, b.dpros, b.qtds, b.units, b.unitorigs, b.totas, b.opers, " + ;
                "c.rclis as repre, " + ;
                "case when co.descricaos is null then 'sem subgrupo' " + ;
                "  else co.descricaos end as colecao, " + ;
                "case when ca.descs is null then 'sem categoria' " + ;
                "  else ca.descs end as categoria, " + ;
                "a.empdopnums, a.cidchaves as chaCab, b.cidchaves as chaItn, " + ;
                "d.cidchaves as chaItd, SPACE(50) as formasP, '1' as imprime, " + ;
                "' ' as lancamento, d.ddesc, d.pdes, d.vdes, d.tpdesc, " + ;
                "d.codigo, e.valcota, round(unitorigs*qtds,2) as ValR, " + ;
                "CAST(0.00 as numeric(11,4)) as DescT, " + ;
                "CAST(0.00 as numeric(11,2)) as Realizado, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes01, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes01, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes02, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes02, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes03, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes03, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes04, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes04, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes05, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes05, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes06, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes06, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes07, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes07, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes08, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes08, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes09, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes09, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes10, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes10, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes11, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes11, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes12, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes12, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes13, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes13, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes14, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes14, " + ;
                "CAST(0.00 as numeric(11,4)) as vdestot " + ;
                "From SigMvCab a with(nolock) " + ;
                "left join SigCdCli c with(nolock) on c.IClis = a.Vends " + ;
                ", SigMvItn b with(nolock) " + ;
                "left join SigMvItd d with(nolock) " + ;
                "  on b.empdopnums = d.empdopnums " + ;
                "  and b.cpros = d.Cpros and b.citens = d.citens " + ;
                "left join sigcddes e with(nolock) on d.codigo = e.codigo, " + ;
                "SigCdOpe g with(nolock), " + ;
                "SigCdTom h with(nolock), SigcdPro p with(nolock) " + ;
                "left join SigCdPsg co with(nolock) " + ;
                "  on co.cgrus = p.cgrus and co.codigos = p.sgrus " + ;
                "left join SigCdCtg ca with(nolock) on ca.cods = p.categoria " + ;
                "Where a.datars BetWeen ?pDtI And ?pDtF And " + ;
                IIF(EMPTY(loc_lcGru), "", "c.Grupos = '" + loc_lcGru + "' And ") + ;
                IIF(EMPTY(loc_lcEmp), "", "a.Emps = '"   + loc_lcEmp + "' And ") + ;
                "b.cpros = p.cpros And " + ;
                "a.EmpDopNums = b.EmpDopNums and " + ;
                "a.dopes = g.dopes and " + ;
                "g.tipoops = h.codigos and " + ;
                "h.gergdmis = 1 and " + ;
                "g.tipoops <> 5 " + ;
                loc_cheCole + loc_cheCate + loc_cheVen + loc_cheProd + ;
                "order by a.cidchaves, b.cidchaves, d.cidchaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados)"
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT * FROM csDados_tmp INTO CURSOR csDados READWRITE
                USE IN csDados_tmp
                SELECT csDados
                GO TOP

                *-- Query secundaria: cotas sigcddes nao cobertas pela query principal
                loc_lcQuery = "SELECT * FROM sigcddes WITH(NOLOCK)" + ;
                    " WHERE dtini >= ?pDtI And dtfin <= ?pDtF" + ;
                    IIF(EMPTY(loc_lcEmp), "", " and Emps = '" + loc_lcEmp + "'")
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados1)"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Append de cotas sem venda no periodo
                SELECT * FROM csDados1 ;
                    WHERE emps NOT IN (SELECT emps FROM csDados) ;
                    INTO CURSOR csDados1
                SELECT csDados1
                GO TOP
                SCAN
                    SELECT csDados
                    APPEND BLANK
                    REPLACE emps    WITH csDados1.emps
                    REPLACE valcota WITH csDados1.valcota
                    REPLACE imprime WITH "1"
                ENDSCAN
                IF USED("csDados1")
                    USE IN csDados1
                ENDIF

                *-- Marcar linhas duplicadas e sinalizar lancamentos
                loc_lcChaAnt = "xxxxxxx"
                SELECT csDados
                GO TOP
                SCAN
                    IF ISNULL(csDados.chaitd) OR EMPTY(csDados.chaitd)
                        REPLACE chaitd WITH SPACE(20) IN csDados
                        REPLACE ddesc  WITH ""         IN csDados
                        REPLACE pdes   WITH 0.00       IN csDados
                        REPLACE vdes   WITH 0.00       IN csDados
                    ENDIF
                    IF csDados.chacab + csDados.chaitn + csDados.chaitd = loc_lcChaAnt
                        REPLACE imprime WITH "" IN csDados
                    ENDIF
                    loc_lcChaAnt = csDados.chacab + csDados.chaitn + csDados.chaitd

                    *-- Lancamento: produto lancado ha menos de 61 dias da data da venda
                    loc_lcQuery = "SELECT dtincs FROM sigcdpro WITH(NOLOCK) WHERE cpros = " + ;
                                  EscaparSQL(ALLTRIM(csDados.cpros))
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crProd") >= 1
                        SELECT crProd
                        IF !EOF() AND !ISNULL(crProd.dtincs)
                            loc_ldDatM = TTOD(csDados.datars)
                            loc_ldDatP = TTOD(crProd.dtincs)
                            IF loc_ldDatM - loc_ldDatP < 61
                                REPLACE lancamento WITH "1" IN csDados
                            ENDIF
                        ENDIF
                        USE IN crProd
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Filtrar somente itens com desconto (chaitd preenchido)
                IF loc_lnDesc = 1
                    SELECT csDados
                    DELETE ALL FOR chaitd = SPACE(20)
                ENDIF

                *-- Filtrar somente produtos lancamento
                IF loc_lnLanc = 1
                    SELECT csDados
                    DELETE ALL FOR lancamento <> "1"
                ENDIF

                *-- Formas de pagamento de cada operacao
                SELECT csDados
                GO TOP
                SCAN
                    loc_lcQuery = "SELECT fpags FROM sigmvpar WITH(NOLOCK)" + ;
                        " WHERE empdopnums = " + ;
                        EscaparSQL(ALLTRIM(csDados.empdopnums)) + ;
                        " GROUP BY fpags"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMvPar") >= 1
                        SELECT crMvPar
                        GO TOP
                        SCAN
                            REPLACE formasP WITH ALLTRIM(csDados.formasP) + ;
                                " " + ALLTRIM(crMvPar.fpags) IN csDados
                        ENDSCAN
                        USE IN crMvPar
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Cursor de trabalho: apenas registros a imprimir
                SELECT * FROM csDados WHERE imprime = "1" INTO CURSOR csRelatorio READWRITE

                *-- Preencher colunas de desconto (pdes01-pdes14) por tipo
                SELECT csRelatorio
                GO TOP
                SCAN
                    SELECT csDados
                    GO TOP
                    SCAN FOR csDados.chacab + csDados.chaitn + csDados.chaitd = ;
                             csRelatorio.chacab + csRelatorio.chaitn + csRelatorio.chaitd ;
                             AND NVL(csDados.tpdesc, 0) > 0
                        loc_lcPdes = "pDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        loc_lcVdes = "vDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        REPLACE &loc_lcPdes WITH csDados.pdes IN csRelatorio
                        REPLACE &loc_lcVdes WITH csDados.vdes IN csRelatorio
                    ENDSCAN
                    SELECT csRelatorio
                    loc_lnAlt = csRelatorio.pdes01 + csRelatorio.pdes02 + ;
                                csRelatorio.pdes03 + csRelatorio.pdes04 + ;
                                csRelatorio.pdes05 + csRelatorio.pdes06 + ;
                                csRelatorio.pdes07 + csRelatorio.pdes08 + ;
                                csRelatorio.pdes09 + csRelatorio.pdes10 + ;
                                csRelatorio.pdes11 + csRelatorio.pdes12 + ;
                                csRelatorio.pdes13 + csRelatorio.pdes14
                    REPLACE desct WITH IIF(csRelatorio.ValR = 0, 0, ;
                        ROUND((csRelatorio.ValR - csRelatorio.totas) / ;
                              NVL(csRelatorio.ValR, 1) * 100, 2)) ;
                        IN csRelatorio
                    loc_lnValRel = csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes12 + csRelatorio.vdes13
                    REPLACE realizado WITH loc_lnValRel IN csRelatorio
                    loc_nVdestot = csRelatorio.vdes01 + csRelatorio.vdes02 + ;
                                   csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes11 + csRelatorio.vdes12 + ;
                                   csRelatorio.vdes13 + csRelatorio.vdes14
                    REPLACE vdestot WITH loc_nVdestot IN csRelatorio
                ENDSCAN

                *-- Agrupa em csTmpRel
                IF loc_lnOpt = 1
                    *-- Detalhado: agrupa colapsando chaitd duplicados
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, ;
                           MAX(chaitd) AS chaitd, formasp, imprime, lancamento, ;
                           MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, SUM(vdes) AS vdes, ;
                           MAX(tpdesc) AS tpdesc, codigo, valcota, valr, desct, ;
                           realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, formasp, ;
                                    imprime, lancamento, codigo, valcota, valr, ;
                                    desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ELSE
                    *-- Resumido: inclui chaitd no agrupamento
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, chaitd, formasp, imprime, ;
                           lancamento, MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, ;
                           SUM(vdes) AS vdes, MAX(tpdesc) AS tpdesc, codigo, ;
                           valcota, valr, desct, realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, chaitd, ;
                                    formasp, imprime, lancamento, codigo, valcota, ;
                                    valr, desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ENDIF

                *-- Reconstruir csRelatorio a partir de csTmpRel
                ZAP IN csRelatorio
                SELECT * FROM csTmpRel INTO CURSOR csRelatorio READWRITE
                IF USED("csTmpRel")
                    USE IN csTmpRel
                ENDIF
                SELECT csRelatorio
                GO TOP

                *-- Visao Resumida: calculos de totais por empresa e vendedor
                IF loc_lnOpt <> 1
                    SELECT emps, SPACE(20) AS repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM csRelatorio GROUP BY emps, codigo INTO CURSOR crAux2
                    SELECT emps, SPACE(20) AS repre, SUM(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM crAux2 GROUP BY emps INTO CURSOR crAux2

                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM csRelatorio GROUP BY emps, repre, codigo ;
                           INTO CURSOR crAux1
                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM crAux1 GROUP BY emps, repre ;
                           INTO CURSOR crAux1 READWRITE
                    SELECT crAux1
                    DELETE ALL FOR EMPTY(repre)

                    SELECT * FROM crAux2 UNION (SELECT * FROM crAux1) INTO CURSOR crAux
                    SELECT emps, repre, valcota, ;
                           realizado AS realizadoV, ;
                           ROUND(realizado / NVL(valcota, 1) * 100, 2) AS realizadoP, ;
                           valcota - realizado AS saldoV, ;
                           ROUND((valcota - realizado) / NVL(valcota, 1) * 100, 2) AS saldoP, ;
                           tipo ;
                           FROM crAux INTO CURSOR csRelatorio ORDER BY 1
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Resumido"
                ELSE
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Detalhado"
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_lcCbPeriodo = "Per" + CHR(237) + "odo : " + ;
                    DTOC(THIS.this_dDtInicial) + " 00:00:00 - " + ;
                    DTOC(THIS.this_dDtFinal)   + " 23:59:59 "
                CREATE CURSOR csCabecalho (empresa c(240), titulo c(240), periodo c(80))
                INSERT INTO csCabecalho (empresa, titulo, periodo) ;
                    VALUES (loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo)

                SELECT csRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Processa e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Processa e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * (snapshot de filtros - usado para reaproveitar filtros entre execucoes)
    * Equivalente a CarregarDoCursor de BOs CRUD, adaptado para relatorio.
    * par_cAliasCursor : nome do cursor com campos identicos as propriedades
    *                    de filtro do BO (cEmpresa, dDtInicial, etc.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_aFields(1), loc_nFlds, loc_nI, loc_cFld
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Mapear apenas os campos efetivamente presentes no cursor
            loc_nFlds = AFIELDS(loc_aFields, loc_cAlias)
            FOR loc_nI = 1 TO loc_nFlds
                loc_cFld = UPPER(ALLTRIM(loc_aFields(loc_nI, 1)))
                DO CASE
                    CASE loc_cFld == "CEMPRESA"
                        THIS.this_cEmpresa    = TratarNulo(EVALUATE(loc_cAlias + ".cEmpresa"),    "C")
                    CASE loc_cFld == "CDESEMPRESA"
                        THIS.this_cDesEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cDesEmpresa"), "C")
                    CASE loc_cFld == "DDTINICIAL"
                        THIS.this_dDtInicial  = TratarNulo(EVALUATE(loc_cAlias + ".dDtInicial"),  "D")
                    CASE loc_cFld == "DDTFINAL"
                        THIS.this_dDtFinal    = TratarNulo(EVALUATE(loc_cAlias + ".dDtFinal"),    "D")
                    CASE loc_cFld == "CCGRU"
                        THIS.this_cCGru       = TratarNulo(EVALUATE(loc_cAlias + ".cCGru"),       "C")
                    CASE loc_cFld == "CDGRU"
                        THIS.this_cDGru       = TratarNulo(EVALUATE(loc_cAlias + ".cDGru"),       "C")
                    CASE loc_cFld == "CVEND"
                        THIS.this_cVend       = TratarNulo(EVALUATE(loc_cAlias + ".cVend"),       "C")
                    CASE loc_cFld == "CDVEND"
                        THIS.this_cDVend      = TratarNulo(EVALUATE(loc_cAlias + ".cDVend"),      "C")
                    CASE loc_cFld == "CCATE"
                        THIS.this_cCate       = TratarNulo(EVALUATE(loc_cAlias + ".cCate"),       "C")
                    CASE loc_cFld == "CCATED"
                        THIS.this_cCateD      = TratarNulo(EVALUATE(loc_cAlias + ".cCateD"),      "C")
                    CASE loc_cFld == "CCOLE"
                        THIS.this_cCole       = TratarNulo(EVALUATE(loc_cAlias + ".cCole"),       "C")
                    CASE loc_cFld == "CCOLED"
                        THIS.this_cColeD      = TratarNulo(EVALUATE(loc_cAlias + ".cColeD"),      "C")
                    CASE loc_cFld == "CPROD"
                        THIS.this_cProd       = TratarNulo(EVALUATE(loc_cAlias + ".cProd"),       "C")
                    CASE loc_cFld == "CPRODD"
                        THIS.this_cProdD      = TratarNulo(EVALUATE(loc_cAlias + ".cProdD"),      "C")
                    CASE loc_cFld == "NOPCAO"
                        THIS.this_nOpcao      = TratarNulo(EVALUATE(loc_cAlias + ".nOpcao"),      "N")
                    CASE loc_cFld == "NDESC"
                        THIS.this_nDesc       = TratarNulo(EVALUATE(loc_cAlias + ".nDesc"),       "N")
                    CASE loc_cFld == "NLANC"
                        THIS.this_nLanc       = TratarNulo(EVALUATE(loc_cAlias + ".nLanc"),       "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Relatorio nao suporta operacoes de insercao de dados
    * Mantido por contrato com BusinessBase mas registra auditoria da execucao
    * do relatorio (que e a unica operacao "de escrita" relevante para reports)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Reports nao inserem registros de negocio. A unica acao registrada
            *-- e a auditoria da execucao do relatorio em si.
            THIS.RegistrarAuditoria("EXECUCAO_RELATORIO")
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de inser" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Relatorio nao suporta operacoes de atualizacao de dados
    * Mantido por contrato com BusinessBase. Reports sao read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de atualiza" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    * Operacao tipica: "EXECUCAO_RELATORIO"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cDetalhe, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") <> "N" OR gnConnHandle < 1
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cDetalhe = "SIGREDES " + ALLTRIM(par_cOperacao) + ;
                " | Per" + CHR(237) + "odo " + DTOC(THIS.this_dDtInicial) + ;
                " - " + DTOC(THIS.this_dDtFinal) + ;
                " | Empresa " + ALLTRIM(THIS.this_cEmpresa) + ;
                " | Vend " + ALLTRIM(THIS.this_cVend) + ;
                " | Visao " + IIF(THIS.this_nOpcao = 1, "Detalhada", "Resumida")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Usuario, DataHora, Detalhe) " + ;
                "VALUES (" + EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                FormatarDataSQL(DATETIME()) + ", " + ;
                EscaparSQL(loc_cDetalhe) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(15), loc_nI
        loc_aCursores(1)  = THIS.this_cCursorDados
        loc_aCursores(2)  = THIS.this_cCursorRelatorio
        loc_aCursores(3)  = THIS.this_cCursorOpFp
        loc_aCursores(4)  = "cursor_4c_OpFp_tmp"
        loc_aCursores(5)  = "csDados1"
        loc_aCursores(6)  = "csTmpRel"
        loc_aCursores(7)  = "csRelatorio"
        loc_aCursores(8)  = "crAux"
        loc_aCursores(9)  = "crAux1"
        loc_aCursores(10) = "crAux2"
        loc_aCursores(11) = "crProd"
        loc_aCursores(12) = "crMvPar"
        loc_aCursores(13) = "csCabecalho"
        loc_aCursores(14) = "cursor_4c_EmpCab"
        loc_aCursores(15) = "csDados"

        FOR loc_nI = 1 TO 15
            IF !EMPTY(loc_aCursores(loc_nI)) AND USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

