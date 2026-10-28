# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'X' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODBARRAS, EMPDOPNUMS, OPERS, CBARS, CPROS, CODS, LPRECOS, EMPS, CEMPS, CESTOS, LNCOL, CTRLLOTES, CBARS_OLD, EMPDNPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODBARRAS, EMPDOPNUMS, OPERS, CBARS, CPROS, CODS, LPRECOS, EMPS, CEMPS, CESTOS, LNCOL, CTRLLOTES, CBARS_OLD, EMPDNPS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
lcSql = [Select cmoes, 0000.000 as valos From Sigcdcot group by cmoes ]
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'TmpCot')
Select TmpCot
Select TmpCot
loPag.GrdCot.Grade_cot.column1.controlsource='TmpCot.Cmoes'
loPag.GrdCot.Grade_cot.column2.controlsource='TmpCot.Valos'
Insert Into CsCabecalho (empresa,codbarras,cpros,dpros,fornecedor,referencia) ;
Select CsBranco
Append Memo Branco From (lcFigJpg) OverWrite
lcQryHis  = [Select codbarras,cpros,emps,dopes,numes,datas,grupos,estos,opers,codcors,codtams,qtds,Pesos,OriDopNums ]+;
			[From SigMvHst ]+;
If ThisForm.poDataMgr.SqlExecute(lcQryHis,'CrSigMvHst') < 1
lcQryEesti= [Select a.codbarras,a.cpros,a.emps,a.dopes,a.numes,a.opers,a.units,a.totas,b.datas,a.Qtds,a.Pesos,a.EmpDopNums ]+;
			[From SigMvItn a, SigMvCab b ]+;
If ThisForm.poDataMgr.SqlExecute(lcQryEesti,'CrSigMvItn') < 1
Select CrSigMvItn
	lcQryEesti= [Select codbarras,cpros,emps,dopes,numes,EmpDopNums ]+;
				[From SigMvIts ]+;
	If ThisForm.poDataMgr.SqlExecute(lcQryEesti,'CrSigMvIts') < 1
Select CrSigMvHst
	lStrQuery = [Select empdopnums,valtots,valitens From SigMvMov ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEstMo') < 1
	Select TmpEstMo
		Select CrSigMvItn
						lStrQuery = [Select empdopnums, Sum(totas) As totas From SigMvHst Where empdopnums = "]+lcEDN+[" And opers = 'S' Group by Empdopnums]
						If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsTotal') < 1
						Select CsTotal
		lStrQuery = [Select empdopnums,valos From SigMvCab Where empdopnums = "]+lcEDN+[" ]
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsTotal') < 1
		Select CsTotal
	Insert Into CsHistorico (codbarras,cpros,emps,dopes,numes,datas,grupos,estos,opers,codcors,codtams,;
Select CrSigMvItn
		If !Seek(CrSigMvItn.emps + CrSigMvItn.dopes + Str(CrSigMvItn.numes,6),'CsHistorico','OriDopNums')
			Insert Into CsMovimento (codbarras,cpros,emps,dopes,numes,datas,opers,valor,qtds,pesos,OriDopNums) ;
	Select CrSigMvIts
		If !Seek(lcEDN2,'CsHistorico','EmpDopNum')
			lcOpers = Iif(Seek(lcEDN2,'CrSigMvItn','EmpDopNum'),CrSigMvItn.Opers,'')
			lStrQuery = [Select EmpDopNums,Datas From SigMvCab Where EmpDopNums = "]+lcEDN2+[" ]
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TprMvCab') < 1
			Select TprMvCab
			Insert Into CsMovimento (codbarras,cpros,emps,dopes,numes,datas,opers,valor,OridopNums) ;
lStrQuery = [Select a.cbars,a.cpros,a.localizas,a.empos,a.grupos,a.contas,a.qtds,a.pesos,a.codamss,a.Peso2s,IsNull(c.cbars_old,0) as Cbars_old ] + ;
		[From SigOpEtq a ]+;
		[ Left join SigOpEta c on a.cbars = c.cbars_new ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEti') < 1
Select TmpEti
lcquery = [select datas, 'E' as opers, substring(empdopnums,1,3) as emps, substring(empdopnums,4,20) as dopes, Cast(substring(empdopnums,25,6) as numeric) as numes, ] +;
			[from sigopexi where cbars = ]+Alltrim(Str(lnCodBars,14))+[ ]
If ThisForm.poDataMgr.SqlExecute(lcquery,'crSigopexi') < 1
thisform.grddevolucao.column1.ControlSource = [crSigOpexi.datas]
thisform.grddevolucao.column2.ControlSource = [crSigOpexi.opers]
thisform.grddevolucao.column3.ControlSource = [crSigOpexi.emps]
thisform.grddevolucao.column4.ControlSource = [crSigOpexi.dopes]
thisform.grddevolucao.column5.ControlSource = [crSigOpexi.numes]
thisform.grddevolucao.column6.ControlSource = [crSigOpexi.valors]
lStrQuery = [Select a.cpros,a.dpros,a.ifors,a.reffs,a.colecoes,a.pvens,a.PrecoDe,a.figjpgs,a.cunis,a.cUniPs,b.rclis,a.categoria ]+;
			[From SigCdPro a Left Join SigCdCli b On b.Iclis = a.Ifors ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
lStrQuery = [select descs from SigCdCtg where cods = ']+ALLTRIM(tmpPro.categoria)+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpCtg') < 1
lStrQuery = [Select a.pvens,a.PrecoDe ]+;
			[From SigCdLpI a, SigCdLpc b ]+;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpLpi') < 1
Select TmpLpi
Select TmpPro
	Select CsBranco
	Append Memo Branco From (lcFigJpg) OverWrite	
Select CsMovimento
Select CsHistorico
	Select CsHistorico
If ThisForm.poDataMgr.SqlExecute([Select cemps,razas From SigCdEmp Where cemps = ']+_Empr+[' ],'CsSigCdEmp') < 1
Select CsSigCdEmp
lcSql = [Select Count(1) as Qt From SigCdUni WherE cEstos = '3' ]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CstmpUni') < 1)
	.DeleteMark   = .F.
	.Column1.ControlSource  = 'CsHistorico.datas'
	.Column2.ControlSource  = 'CsHistorico.opers'
	.Column3.ControlSource  = 'CsHistorico.emps'
	.Column4.ControlSource  = 'CsHistorico.dopes'
	.Column5.ControlSource  = 'CsHistorico.numes'
	.Column6.ControlSource  = 'CsHistorico.grupos'
	.Column7.ControlSource  = 'CsHistorico.estos'
	.Column8.ControlSource  = 'CsHistorico.codcors'
	.Column9.ControlSource  = 'CsHistorico.codtams'
	.Column10.ControlSource = 'CsHistorico.Qtds'
		.Column11.ControlSource = 'CsHistorico.Valor'
		.Column11.ControlSource = 'CsHistorico.Pesos'
	.DeleteMark   = .F.
	.Column1.ControlSource  = 'CsMovimento.datas'
	.Column2.ControlSource  = 'CsMovimento.opers'
	.Column3.ControlSource  = 'CsMovimento.emps'
	.Column4.ControlSource  = 'CsMovimento.dopes'
	.Column5.ControlSource  = 'CsMovimento.numes'
	.Column6.ControlSource  = 'CsMovimento.valor'
	.Column7.ControlSource  = 'CsMovimento.qtds'
	.Column8.ControlSource  = 'CsMovimento.pesos'	
If ThisForm.poDataMgr.SqlExecute([Select * From SigCdOpe Where (ctrllotes = 1 Or ctrllotes = 2) ],'TmpOpe') < 1
ThisForm.poDatamgr.SqlExecute([Select * From SigCdPam], [csTmpParam])
	lStrQuery = [Select a.CPros,a.CBars, b.cbars_old ] + ;
		[From SigOpEtq a ] + ;
		[left join sigopeta b on a.cpros = b.cpros and a.cbars = b.cbars_new ] + ;
	If Thisform.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
	Select CrEtiqs
		lStrQuery = [Select CPros, CBars, 0 as cbars_old ] + ;
				    [From SigCdPro ] + ;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrEtiqs') < 1
		Select CrEtiqs
	lStrQuery = [Select CPros,DPros,FigJpgs From SigCdPro Where CPros = ']+CsMovimento.CPros+[' ]
	If ThisForm.poDataMgr.SQLExecute(lStrQuery,'TmpProSH') < 1
	Select TmpProSH
	Select CsMovimento
	Select CsHistorico
 	Select crSigOpexi
			Select &lcAlias.
	If ThisForm.poDataMgr.SqlExecute([Select * From SigEtHst Where cbars = ]+Alltrim(Str(lnCodBars,14))+[ ],'CrSigEtHst') < 1
			.DeleteMark   = .F.
			.Column1.ControlSource  = 'CrSigEtHst.datas'
			.Column2.ControlSource  = 'CrSigEtHst.cpros'
			.Column3.ControlSource  = 'CrSigEtHst.pesos'
			.Column4.ControlSource  = 'CrSigEtHst.codcors'
			.Column6.ControlSource  = 'CrSigEtHst.codtams'
			.Column5.ControlSource  = 'CrSigEtHst.usuars'

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgb.prg) - TRECHOS RELEVANTES PARA PASS SQL (3021 linhas total):

*-- Linhas 55 a 73:
55: * 200ms - eh o que faz o leitor de codigo de barras funcionar em sequencia.
56: * Junto vieram tres acertos de fidelidade medidos contra o dump:
57: *   (a) o Valid legado so pesquisa quando o codigo MUDOU - sem esse guard a
58: *       pesquisa inteira (3 SELECT + 3 cursores) repetia a cada saida do campo,
59: *       e o funil ganhou guard de reentrancia em wrapper fino (regra #47);
60: *   (b) as DUAS linhas finais do ramo "Init com pBar" (travar o campo e levar o
61: *       foco ao Encerrar) - aberta de outra tela, a consulta eh de UM codigo;
62: *   (c) o When das 3 grades ("Return(!Empty(GetBarras.Value))") entrou no
63: *       AtualizarEstadoBotoes, que ja cuidava dos 6 botoes.
64: *
65: * NAO portados, de proposito:
66: *   Load ("=fConfigGeral()") - funcao GLOBAL de inicializacao do legado
67: *     Fortyus; em codigo nosso a inicializacao global mora no config.prg
68: *     (mesmo precedente de FormSigMvExp/FormSigMvMen).
69: *   ThisForm.Tpbusca - propriedade ESCRITA em tres pontos do legado (Init,
70: *     Init-com-pBar e getBarras.LostFocus) e NUNCA lida: estado morto.
71: *     Migra-la seria criar propriedade que ninguem consulta.
72: *==============================================================================
73: 

*-- Linhas 99 a 117:
99:     *-- Valor do campo de barras na ENTRADA do campo (legado:
100:     *-- getBarras.peantvalue, gravado no GotFocus). O Valid legado so pesquisa
101:     *-- quando "This.peantvalue # This.Value", ou seja quando o usuario
102:     *-- realmente mudou o codigo - sem isso a pesquisa (3 SELECT + 3 cursores)
103:     *-- roda de novo a cada saida do campo.
104:     this_nBarrasAnterior  = 0
105: 
106:     *-- Guard de reentrancia do funil de pesquisa. ValidarBarras pode exibir
107:     *-- MsgErro (modal), o foco sai do campo e o proprio LostFocus redispara -
108:     *-- sem guard a pesquisa se empilha (regra CLAUDE.md #37/#47).
109:     this_lEmPesquisa      = .F.
110: 
111:     *==================================================================
112:     * Init - Armazena parametro antes de DODEFAULT (que chama InicializarForm)
113:     *==================================================================
114:     PROCEDURE Init(par_nCodBarra)
115:         LOCAL loc_lResultado
116:         loc_lResultado = .F.
117: 

*-- Linhas 158 a 176:
158:                 THIS.ConfigurarGrids()
159:                 THIS.ConfigurarTimerFoco()
160: 
161:                 *-- Cursores ANTES do bind: ControlSource de cursor inexistente
162:                 *-- derruba o Init e a tela nao abre (regra #41/CLAUDE.md).
163:                 THIS.CriarCursoresGrades()
164:                 THIS.VincularGrades()
165:                 THIS.ConfigurarBindings()
166: 
167:                 THIS.AplicarAcessoBotoes()
168:                 THIS.AtualizarEstadoBotoes(THIS.this_nCodBarraInicial)
169: 
170:                 *-- Legado: If (Type([pBar])=[N]) And (GetBarras.Value > 0) ->
171:                 *-- ThisForm.Processamento. Sem conexao (validacao de UI/teste
172:                 *-- automatizado) nao ha o que consultar. Passa pelo mesmo
173:                 *-- funil da digitacao manual (ValidarBarras), que tambem
174:                 *-- carrega Produto/Posicao Atual, nao so as grades.
175:                 IF THIS.this_nCodBarraInicial > 0 AND THIS.PodeConsultarBanco()
176:                     THIS.txt_4c_Barras.Value = THIS.this_nCodBarraInicial

*-- Linhas 871 a 889:
871:     *
872:     * Todos os campos de exibicao (TabStop=.F.) sao preenchidos pelo funil
873:     * de pesquisa (ValidarBarras/AtualizarCamposEtiqueta/AtualizarCamposProduto),
874:     * nao por ControlSource - igual ao padrao da fase anterior.
875:     *==================================================================
876:     PROTECTED PROCEDURE ConfigurarCamposComplementares()
877: 
878:         *-- Shape7 - moldura "Posicao Atual do Codigo de Barras"
879:         THIS.AddObject("shp_4c_Shape7", "Shape")
880:         WITH THIS.shp_4c_Shape7
881:             .Top         = 144
882:             .Left        = 648
883:             .Width       = 344
884:             .Height      = 106
885:             .BackStyle   = 0
886:             .BorderStyle = 6
887:             .FillStyle   = 1
888:             .ColorScheme = 1
889:             .BorderColor = RGB(90, 90, 90)

*-- Linhas 1443 a 1462:
1443:     * gerado automaticamente colidiu as 3 grades em "grd_4c_Dados".
1444:     *
1445:     * Aqui ficam SO as propriedades que nao dependem de dado. O
1446:     * RecordSource/ControlSource de cada coluna vai em VincularGrades, que
1447:     * roda depois de CriarCursoresGrades - ControlSource de cursor que ainda
1448:     * nao existe derruba o Init e a tela nao abre (regra CLAUDE.md #41).
1449:     *==================================================================
1450:     PROTECTED PROCEDURE ConfigurarGrids()
1451:         THIS.CriarGradeHistorico()
1452:         THIS.CriarGradeMovimento()
1453:         THIS.CriarGradeDevolucao()
1454:         THIS.CriarGradeCotacoes()
1455:         THIS.CriarGradeCorrecao()
1456:     ENDPROC
1457: 
1458:     *==================================================================
1459:     * ConfigurarTimerFoco - tmr_4c_FocoBarras (legado: tmAux, Timer com
1460:     * Interval = 200).
1461:     *
1462:     * NAO eh enfeite: em VFP9 nao se pode devolver o foco a um controle de

*-- Linhas 1494 a 1512:
1494:             .FontName    = "Tahoma"
1495:             .FontSize    = 8
1496:             .ColumnCount = 11
1497:             .DeleteMark  = .F.
1498:             .RecordMark  = .F.
1499:             .ReadOnly    = .T.
1500:             .Visible     = .T.
1501:         ENDWITH
1502: 
1503:     ENDPROC
1504: 
1505:     *--------------------------------------------------------------------------
1506:     * CriarGradeMovimento - grd_4c_Movimento (legado: grdMovimento, 8 colunas)
1507:     *--------------------------------------------------------------------------
1508:     PROTECTED PROCEDURE CriarGradeMovimento()
1509:         LOCAL loc_oGrd
1510: 
1511:         THIS.AddObject("grd_4c_Movimento", "Grid")
1512:         loc_oGrd = THIS.grd_4c_Movimento

*-- Linhas 1518 a 1536:
1518:             .FontName    = "Tahoma"
1519:             .FontSize    = 8
1520:             .ColumnCount = 8
1521:             .DeleteMark  = .F.
1522:             .RecordMark  = .F.
1523:             .ReadOnly    = .T.
1524:             .Visible     = .T.
1525:         ENDWITH
1526: 
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * CriarGradeDevolucao - grd_4c_Devolucao (legado: grddevolucao, 6 colunas)
1531:     *--------------------------------------------------------------------------
1532:     PROTECTED PROCEDURE CriarGradeDevolucao()
1533:         LOCAL loc_oGrd
1534: 
1535:         THIS.AddObject("grd_4c_Devolucao", "Grid")
1536:         loc_oGrd = THIS.grd_4c_Devolucao

*-- Linhas 1542 a 1560:
1542:             .FontName    = "Tahoma"
1543:             .FontSize    = 8
1544:             .ColumnCount = 6
1545:             .DeleteMark  = .F.
1546:             .RecordMark  = .F.
1547:             .ReadOnly    = .T.
1548:             .Visible     = .T.
1549:         ENDWITH
1550: 
1551:     ENDPROC
1552: 
1553:     *--------------------------------------------------------------------------
1554:     * CriarGradeCotacoes - grd_4c_Cotacoes (legado: grdCot.grade_Cot, 2
1555:     * colunas), dentro do container cnt_4c_GrdCot (que ja foi criado em
1556:     * ConfigurarCamposComplementares - a grade PRECISA do container pai).
1557:     *--------------------------------------------------------------------------
1558:     PROTECTED PROCEDURE CriarGradeCotacoes()
1559:         LOCAL loc_oGrd
1560: 

*-- Linhas 1568 a 1586:
1568:             .FontName      = "Tahoma"
1569:             .FontSize      = 8
1570:             .ColumnCount   = 2
1571:             .DeleteMark    = .F.
1572:             .RecordMark    = .F.
1573:             .ReadOnly      = .T.
1574:             .RowHeight     = 16
1575:             .ScrollBars    = 2
1576:             .GridLineColor = RGB(238, 238, 238)
1577:             .Visible       = .T.
1578:         ENDWITH
1579:     ENDPROC
1580: 
1581:     *--------------------------------------------------------------------------
1582:     * CriarGradeCorrecao - grd_4c_Correcao (legado: Cnt_Correcao.GrdCorrecao,
1583:     * 6 colunas), dentro do container cnt_4c_Correcao (criado em
1584:     * ConfigurarPainelCorrecao - a grade PRECISA do container pai).
1585:     *--------------------------------------------------------------------------
1586:     PROTECTED PROCEDURE CriarGradeCorrecao()

*-- Linhas 1596 a 1614:
1596:             .FontName    = "Tahoma"
1597:             .FontSize    = 8
1598:             .ColumnCount = 6
1599:             .DeleteMark  = .F.
1600:             .RecordMark  = .F.
1601:             .ReadOnly    = .T.
1602:             .Visible     = .T.
1603:         ENDWITH
1604:     ENDPROC
1605: 
1606:     *--------------------------------------------------------------------------
1607:     * ConfigurarColunaGrade - aplica Width/Header1.Caption/estilo de coluna
1608:     * comum as 3 grades (Tahoma 8, Alignment=2 no header - direita - igual
1609:     * ao dump; Text1 BorderStyle=0/Margin=0/ReadOnly=.T. - sem coluna
1610:     * editavel nestas grades de resultado).
1611:     *--------------------------------------------------------------------------
1612:     PROTECTED PROCEDURE ConfigurarColunaGrade(par_oGrd, par_nCol, par_nWidth, par_cCaption)
1613:         LOCAL loc_oCol
1614:         loc_oCol = par_oGrd.Columns(par_nCol)

*-- Linhas 1645 a 1862:
1645:     * se o movimento ja tem historico, e DtOpers eh a ordem de exibicao.
1646:     *
1647:     * Os tres cursores sao criados UMA UNICA VEZ, aqui, e so sao esvaziados
1648:     * (ZAP) e repopulados pelo BO - nunca derrubados por SQLEXEC, que zeraria
1649:     * o ColumnCount das grades ligadas a eles.
1650:     *
1651:     * cursor_4c_Devolucao nao existe no legado como cursor proprio: la o
1652:     * SQLEXEC das barras devolvidas ia DIRETO para o alias da grade. As
1653:     * colunas abaixo tem os nomes EXATOS dos aliases daquele SELECT, porque
1654:     * o APPEND FROM do BO casa por NOME.
1655:     *==================================================================
1656:     PROTECTED PROCEDURE CriarCursoresGrades()
1657:         *-- Grade de Historico (CsHistorico no legado)
1658:         IF USED("cursor_4c_Historico")
1659:             USE IN cursor_4c_Historico
1660:         ENDIF
1661: 
1662:         CREATE CURSOR cursor_4c_Historico ;
1663:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1664:              datas D, grupos C(10), estos C(10), opers C(1), codcors C(4), ;
1665:              codtams C(4), valor N(12,2), Qtds N(9,3), Pesos N(9,3), OriDopNums C(29))
1666: 
1667:         INDEX ON emps + dopes + STR(numes, 6) TAG EmpDopNum
1668:         INDEX ON OriDopNums TAG OriDopNums
1669:         INDEX ON DTOS(datas) TAG DtOpers
1670: 
1671:         *-- Grade de Movimento (CsMovimento no legado)
1672:         IF USED("cursor_4c_Movimento")
1673:             USE IN cursor_4c_Movimento
1674:         ENDIF
1675: 
1676:         CREATE CURSOR cursor_4c_Movimento ;
1677:             (codbarras N(14), cpros C(14), emps C(3), dopes C(20), numes N(6), ;
1678:              datas D, opers C(1), valor N(12,2), Qtds N(12,3), Pesos N(12,3), ;
1679:              OriDopNums C(29))
1680: 
1681:         INDEX ON DTOS(datas) TAG DtOpers
1682: 
1683:         *-- Grade de Devolucao (crSigOpexi no legado).
1684:         *-- SET NULL ON eh obrigatorio: SigOpExi.datas aceita NULL no banco e o
1685:         *-- APPEND FROM do BO falharia num campo declarado NOT NULL.
1686:         *-- Desvio documentado: datas aqui eh DATE e no legado era o datetime
1687:         *-- cru do SQL Server. A coluna da grade tem 70px (nao cabe a hora) e as
1688:         *-- duas grades irmas usam DATE no mesmo campo "Data".
1689:         IF USED("cursor_4c_Devolucao")
1690:             USE IN cursor_4c_Devolucao
1691:         ENDIF
1692: 
1693:         SET NULL ON
1694:         CREATE CURSOR cursor_4c_Devolucao ;
1695:             (datas D NULL, opers C(1) NULL, emps C(3) NULL, dopes C(20) NULL, ;
1696:              numes N(10) NULL, OriDopNums C(29) NULL, valors N(11,2) NULL)
1697:         SET NULL OFF
1698: 
1699:         *-- Sem indice de proposito: o legado NAO reordena a grade de devolucao
1700:         *-- (exibe na ordem do SELECT). Indexar por DTOS(datas) aqui exigiria
1701:         *-- chave de indice sobre data NULL, que eh justamente o caso que
1702:         *-- SigOpExi.datas permite.
1703: 
1704:         *-- Grade de Cotacoes (TmpCot no legado: Select cmoes, 0000.000 as
1705:         *-- valos From SigCdCot Group By cmoes)
1706:         IF USED("cursor_4c_Cotacoes")
1707:             USE IN cursor_4c_Cotacoes
1708:         ENDIF
1709: 
1710:         CREATE CURSOR cursor_4c_Cotacoes (cmoes C(3), valos N(11, 6))
1711: 
1712:         *-- Grade do painel de Correcao (CrSigEtHst no legado: Select * From
1713:         *-- SigEtHst Where cbars = <codbarras> - so as colunas usadas pela
1714:         *-- grade). SigEtHst.datas aceita NULL no banco - SET NULL ON evita
1715:         *-- que o APPEND FROM do BO falhe num campo NOT NULL por acidente.
1716:         IF USED("cursor_4c_Correcao")
1717:             USE IN cursor_4c_Correcao
1718:         ENDIF
1719: 
1720:         SET NULL ON
1721:         CREATE CURSOR cursor_4c_Correcao ;
1722:             (datas T NULL, cpros C(14), pesos N(8,2), codcors C(4), codtams C(4), usuars C(10))
1723:         SET NULL OFF
1724:     ENDPROC
1725: 
1726:     *==================================================================
1727:     * VincularGrades - Liga cada grade ao seu cursor. Roda DEPOIS de
1728:     * CriarCursoresGrades (os cursores precisam existir: ControlSource de
1729:     * cursor inexistente derruba o Init) e DEPOIS de ConfigurarGrids.
1730:     *
1731:     * Ordem obrigatoria por coluna: RecordSource -> ControlSource -> Width ->
1732:     * Header1.Caption. Mexer em RecordSource/ControlSource faz o VFP recalcular
1733:     * as larguras para o default, entao Width/Caption vem por ULTIMO.
1734:     *
1735:     * A 11a coluna da grade de Historico eh a unica condicional, igual ao
1736:     * legado: com Habvalor mostra "valor" (caption "Valor"); sem Habvalor
1737:     * mostra "Pesos" e mantem o caption desenhado no SCX.
1738:     *==================================================================
1739:     PROTECTED PROCEDURE VincularGrades()
1740:         LOCAL loc_oGrd, loc_lHabValor
1741: 
1742:         loc_lHabValor = .F.
1743:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1744:             loc_lHabValor = THIS.this_oBusinessObject.this_lHabilitaValor
1745:         ENDIF
1746: 
1747:         *-- Grade de Historico
1748:         loc_oGrd = THIS.grd_4c_Historico
1749:         loc_oGrd.ColumnCount = 11
1750:         loc_oGrd.RecordSource = "cursor_4c_Historico"
1751: 
1752:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Historico.datas"
1753:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Historico.opers"
1754:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Historico.emps"
1755:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Historico.dopes"
1756:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Historico.numes"
1757:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Historico.grupos"
1758:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Historico.estos"
1759:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Historico.codcors"
1760:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Historico.codtams"
1761:         loc_oGrd.Column10.ControlSource = "cursor_4c_Historico.Qtds"
1762: 
1763:         IF loc_lHabValor
1764:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.valor"
1765:         ELSE
1766:             loc_oGrd.Column11.ControlSource = "cursor_4c_Historico.Pesos"
1767:         ENDIF
1768: 
1769:         THIS.ConfigurarColunaGrade(loc_oGrd, 1,  69,  "Data")
1770:         THIS.ConfigurarColunaGrade(loc_oGrd, 2,  15,  "O")
1771:         THIS.ConfigurarColunaGrade(loc_oGrd, 3,  28,  "Emp")
1772:         THIS.ConfigurarColunaGrade(loc_oGrd, 4,  203, "Movimenta" + CHR(231) + CHR(227) + "o")
1773:         THIS.ConfigurarColunaGrade(loc_oGrd, 5,  50,  "C" + CHR(243) + "digo")
1774:         THIS.ConfigurarColunaGrade(loc_oGrd, 6,  75,  "Grupo")
1775:         THIS.ConfigurarColunaGrade(loc_oGrd, 7,  75,  "Conta")
1776:         THIS.ConfigurarColunaGrade(loc_oGrd, 8,  32,  "Cor")
1777:         THIS.ConfigurarColunaGrade(loc_oGrd, 9,  32,  "Tam")
1778:         THIS.ConfigurarColunaGrade(loc_oGrd, 10, 70,  "Qtd")
1779:         THIS.ConfigurarColunaGrade(loc_oGrd, 11, 70,  IIF(loc_lHabValor, "Valor", "Qtd"))
1780: 
1781:         *-- Grade de Movimento
1782:         loc_oGrd = THIS.grd_4c_Movimento
1783:         loc_oGrd.ColumnCount = 8
1784:         loc_oGrd.RecordSource = "cursor_4c_Movimento"
1785: 
1786:         loc_oGrd.Column1.ControlSource = "cursor_4c_Movimento.datas"
1787:         loc_oGrd.Column2.ControlSource = "cursor_4c_Movimento.opers"
1788:         loc_oGrd.Column3.ControlSource = "cursor_4c_Movimento.emps"
1789:         loc_oGrd.Column4.ControlSource = "cursor_4c_Movimento.dopes"
1790:         loc_oGrd.Column5.ControlSource = "cursor_4c_Movimento.numes"
1791:         loc_oGrd.Column6.ControlSource = "cursor_4c_Movimento.valor"
1792:         loc_oGrd.Column7.ControlSource = "cursor_4c_Movimento.Qtds"
1793:         loc_oGrd.Column8.ControlSource = "cursor_4c_Movimento.Pesos"
1794: 
1795:         THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70,  "Data")
1796:         THIS.ConfigurarColunaGrade(loc_oGrd, 2, 15,  "O")
1797:         THIS.ConfigurarColunaGrade(loc_oGrd, 3, 28,  "Emp")
1798:         THIS.ConfigurarColunaGrade(loc_oGrd, 4, 145, "Movimenta" + CHR(231) + CHR(227) + "o")
1799:         THIS.ConfigurarColunaGrade(loc_oGrd, 5, 50,  "C" + CHR(243) + "digo")
1800:         THIS.ConfigurarColunaGrade(loc_oGrd, 6, 80,  "Valor")
1801:         THIS.ConfigurarColunaGrade(loc_oGrd, 7, 70,  "Qtde")
1802:         THIS.ConfigurarColunaGrade(loc_oGrd, 8, 70,  "Pesos")
1803: 
1804:         *-- Grade de Devolucao
1805:         loc_oGrd = THIS.grd_4c_Devolucao
1806:         loc_oGrd.ColumnCount = 6
1807:         loc_oGrd.RecordSource = "cursor_4c_Devolucao"
1808: 
1809:         loc_oGrd.Column1.ControlSource = "cursor_4c_Devolucao.datas"
1810:         loc_oGrd.Column2.ControlSource = "cursor_4c_Devolucao.opers"
1811:         loc_oGrd.Column3.ControlSource = "cursor_4c_Devolucao.emps"
1812:         loc_oGrd.Column4.ControlSource = "cursor_4c_Devolucao.dopes"
1813:         loc_oGrd.Column5.ControlSource = "cursor_4c_Devolucao.numes"
1814:         loc_oGrd.Column6.ControlSource = "cursor_4c_Devolucao.valors"
1815: 
1816:         THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70,  "Data")
1817:         THIS.ConfigurarColunaGrade(loc_oGrd, 2, 15,  "O")
1818:         THIS.ConfigurarColunaGrade(loc_oGrd, 3, 28,  "Emp")
1819:         THIS.ConfigurarColunaGrade(loc_oGrd, 4, 145, "Movimenta" + CHR(231) + CHR(227) + "o")
1820:         THIS.ConfigurarColunaGrade(loc_oGrd, 5, 50,  "C" + CHR(243) + "digo")
1821:         THIS.ConfigurarColunaGrade(loc_oGrd, 6, 80,  "Valor")
1822: 
1823:         *-- Grade de Cotacoes (dentro de cnt_4c_GrdCot, oculta por padrao)
1824:         loc_oGrd = THIS.cnt_4c_GrdCot.grd_4c_Cotacoes
1825:         loc_oGrd.ColumnCount = 2
1826:         loc_oGrd.RecordSource = "cursor_4c_Cotacoes"
1827: 
1828:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cotacoes.cmoes"
1829:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cotacoes.valos"
1830: 
1831:         THIS.ConfigurarColunaGrade(loc_oGrd, 1, 30,  "Moe")
1832:         THIS.ConfigurarColunaGrade(loc_oGrd, 2, 100, "Cotacao")
1833:         loc_oGrd.Column2.Text1.InputMask = "999,999,999.99"
1834: 
1835:         *-- Grade do painel de Correcao (dentro de cnt_4c_Correcao, oculto
1836:         *-- por padrao). Ordem de colunas igual ao legado: Column5=usuars,
1837:         *-- Column6=codtams (NAO na ordem 4,5,6 "natural").
1838:         loc_oGrd = THIS.cnt_4c_Correcao.grd_4c_Correcao
1839:         loc_oGrd.ColumnCount = 6
1840:         loc_oGrd.RecordSource = "cursor_4c_Correcao"
1841: 
1842:         loc_oGrd.Column1.ControlSource = "cursor_4c_Correcao.datas"
1843:         loc_oGrd.Column2.ControlSource = "cursor_4c_Correcao.cpros"
1844:         loc_oGrd.Column3.ControlSource = "cursor_4c_Correcao.pesos"
1845:         loc_oGrd.Column4.ControlSource = "cursor_4c_Correcao.codcors"
1846:         loc_oGrd.Column5.ControlSource = "cursor_4c_Correcao.usuars"
1847:         loc_oGrd.Column6.ControlSource = "cursor_4c_Correcao.codtams"
1848: 
1849:         THIS.ConfigurarColunaGrade(loc_oGrd, 1, 70, "Data")
1850:         THIS.ConfigurarColunaGrade(loc_oGrd, 2, 90, "Produto")
1851:         THIS.ConfigurarColunaGrade(loc_oGrd, 3, 60, "Peso")
1852:         THIS.ConfigurarColunaGrade(loc_oGrd, 4, 60, "Cor")
1853:         THIS.ConfigurarColunaGrade(loc_oGrd, 5, 80, "Usu" + CHR(225) + "rio")
1854:         THIS.ConfigurarColunaGrade(loc_oGrd, 6, 60, "Tam")
1855:     ENDPROC
1856: 
1857:     *==================================================================
1858:     * CarregarDados - Monta as 3 grades para um codigo de barras.
1859:     * Equivalente a parte do PROCEDURE Processamento do legado que diz
1860:     * respeito as grades; os campos do produto/etiqueta sao preenchidos
1861:     * pelos metodos da pagina de dados.
1862:     *

*-- Linhas 1927 a 1977:
1927:     * vazia com o cursor cheio.
1928:     *
1929:     * O legado fecha o Processamento assim, e eh isso que se reproduz:
1930:     *   Select CsMovimento / Set Order To DtOpers / AfterRowColChange / Go Bottom
1931:     *   Select CsHistorico / Set Order To DtOpers / AfterRowColChange / Go Bottom
1932:     * ou seja GO BOTTOM (ultimo movimento, o mais recente), NAO Go Top. A grade
1933:     * de devolucao nao eh reordenada nem reposicionada pelo legado.
1934:     *
1935:     * Chamado em TODO caminho que popula ou esvazia os cursores.
1936:     *==================================================================
1937:     PROCEDURE RepintarGrades()
1938:         IF USED("cursor_4c_Historico")
1939:             SELECT cursor_4c_Historico
1940:             SET ORDER TO TAG DtOpers
1941:             GO BOTTOM
1942:             THIS.grd_4c_Historico.Refresh()
1943:         ENDIF
1944: 
1945:         IF USED("cursor_4c_Movimento")
1946:             SELECT cursor_4c_Movimento
1947:             SET ORDER TO TAG DtOpers
1948:             GO BOTTOM
1949:             THIS.grd_4c_Movimento.Refresh()
1950:         ENDIF
1951: 
1952:         IF USED("cursor_4c_Devolucao")
1953:             SELECT cursor_4c_Devolucao
1954:             GO TOP
1955:             THIS.grd_4c_Devolucao.Refresh()
1956:         ENDIF
1957: 
1958:         *-- O legado deixa CsHistorico selecionado quando CsMovimento esta vazio
1959:         *-- (If RecCount('CsMovimento') < 1 / Select CsHistorico).
1960:         IF USED("cursor_4c_Movimento") AND RECCOUNT("cursor_4c_Movimento") < 1
1961:             IF USED("cursor_4c_Historico")
1962:                 SELECT cursor_4c_Historico
1963:             ENDIF
1964:         ENDIF
1965: 
1966:         RETURN .T.
1967:     ENDPROC
1968: 
1969:     *==================================================================
1970:     * AplicarAcessoBotoes - Visibilidade dos botoes por permissao, como no
1971:     * Init legado:
1972:     *   .BtnDocumento.Visible      = fChecaAcesso('SIGOPCGB','BTNDOC')
1973:     *   .BtnImprimir.Visible       = fChecaAcesso('SIGOPCGB','IMPRIMIR')
1974:     *   .BtnVisualizar.Visible     = fChecaAcesso('SIGOPCGB','VISUALIZAR')
1975:     *   .Bot_Rastro.Visible        = fChecaAcesso('SIGOPCGB','RASTRO') And !Eof('TmpOpe')
1976:     *   .Botao_de_Correcao.Visible = fChecaAcesso('SIGOPCGB','CORRECAO')
1977:     * O !Eof('TmpOpe') eh o this_lControlaLotes do BO (existe SigCdOpe com

*-- Linhas 2635 a 2655:
2635:         IF USED("csCabecalho")
2636:             USE IN csCabecalho
2637:         ENDIF
2638:         CREATE CURSOR csCabecalho ;
2639:             (empresa C(80), codbarras N(14), cpros C(14), dpros C(40), fornecedor C(10), referencia C(10))
2640:         INSERT INTO csCabecalho (empresa, codbarras, cpros, dpros, fornecedor, referencia) ;
2641:             VALUES (loc_cEmpresa, THIS.txt_4c_Barras.Value, THIS.txt_4c_CProduto.Value, ;
2642:                     THIS.txt_4c_DProduto.Value, THIS.txt_4c_CFornecedor.Value, THIS.txt_4c_Referencia.Value)
2643: 
2644:         *-- Nome FIXO, igual a expressao do Image no FRX.
2645:         loc_cArquivoImg = SYS(2023) + "\SigOpCgb.Jpg"
2646:         loc_cFoto = TratarNulo(loc_oBO.this_cFigJpgBase64, "")
2647:         IF !EMPTY(loc_cFoto)
2648:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/png;base64,", "")
2649:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2650:             loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
2651:             loc_cFoto = STRCONV(loc_cFoto, 14)
2652:             STRTOFILE(loc_cFoto, loc_cArquivoImg)
2653:         ELSE
2654:             *-- Sem foto: fundo BRANCO, para nao imprimir a do produto anterior.
2655:             COPY FILE (loc_cBranco) TO (loc_cArquivoImg)

